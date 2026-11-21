#!/usr/bin/env python3
"""Sort the sound chunks by kind, by replaying the uploads into SPC RAM.

usage: tools/sound_kinds.py [--report]

As a module, kinds() returns {chunk ID: kind} for the chunks it can prove, and
the evidence. It replays what the game uploads (tools/sound.py decodes the
lists) into a 64 KB image of SPC RAM: the driver, the start upload list, then
each song script's upload lists, the way rlRunSoundUploadList places them
(an SPC address of 0 means after the previous chunk; $Cxxx sets it). An
indirect ID uploads its whole list. IDs 1-4 depend on the battle, so every
upload list no song names is also replayed on top of the battle song $31.
Each kind has a test that could fail:

  directory    uploaded into $FD00-$FDFF: the driver sets the DSP's sample
               directory register (DIR, $5D) to $FD (audio/driver/0660.bin,
               SPC $0692). Entries are (start, loop) words.
  sample       BRR data: some directory entry starts in it, and walking 9-byte
               BRR blocks from each such start reaches a block with the end
               flag inside the same chunk; the starts and ends tile the chunk
               exactly; a loop address is a block start, and equal to the end
               only when the loop flag is clear.
  instruments  uploaded into $FE00-$FEFF, a whole number of 6-byte entries;
               each entry's first byte is a sample number whose directory
               entry, in the same replay, starts in a sample chunk, and its
               second byte has bit 7 set (ADSR on).
  sequence     compressed, uploaded to $C500 (songs), $B500, $BC00 or $D400:
               after a first word ($C500 only), a list of words up to $0000:
               $0001-$00FF take an address in the chunk (a loop or jump);
               larger ones point at a pattern in the chunk of 8 track pointers,
               each 0 or in the chunk.

Everything else is `other`, listed with where it goes. --report prints the
counts, the chunks of each kind and anything a test rejected.
"""
import argparse
import collections
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from sound import Sound, FIRST_CHUNK
from decompress import decompress

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DIR = 0xFD00                    # the driver's DIR value << 8
INSTRUMENTS = 0xFE00
SEQUENCE_DESTS = (0xC500, 0xB500, 0xBC00, 0xD400)
BATTLE_SONG = 0x31


class Replay:
    def __init__(self, s, data):
        self.s, self.data = s, data
        self.ram = bytearray(0x10000)
        self.owner = [None] * 0x10000
        self.dest = 0
        self.placed = {}
        for dest, block in s.driver:
            self.ram[dest:dest + len(block)] = block

    def upload(self, cid):
        d = self.data(cid)
        dest = self.s.chunks[cid - FIRST_CHUNK][3] or self.dest
        self.ram[dest:dest + len(d)] = d
        self.owner[dest:dest + len(d)] = [cid] * len(d)
        self.placed[cid] = (dest, len(d))
        self.dest = dest + len(d)

    def run(self, ul):
        s = self.s
        for w, arg in s.upload_lists[ul]:
            if w >> 12 == 0xC:
                self.dest = arg
            elif w >> 12:
                continue
            elif w < FIRST_CHUNK:
                if w >= 5:
                    for x, _ in s.upload_lists[s.upload_table[w]]:
                        self.upload(x & 0x7FF)
            else:
                self.upload(w & 0x7FF)


def word(b, o):
    return b[o] | b[o + 1] << 8


def brr_end(ram, start):
    a = start
    while a <= 0xFFFF - 9:
        h = ram[a]
        a += 9
        if h & 1:
            return a, bool(h & 2)
    return None, None


def check_sequence(d, dest):
    end = dest + len(d)
    o = 2 if dest == 0xC500 else 0
    pats = []
    while True:
        if o + 2 > len(d):
            return 'the list runs past the end'
        w = word(d, o)
        o += 2
        if w == 0:
            break
        if w < 0x100:
            t = word(d, o)
            o += 2
            if not dest <= t < end:
                return f'command ${w:02X} goes to ${t:04X}, outside'
            continue
        if not dest <= w < end:
            return f'pattern ${w:04X} outside'
        pats.append(w)
    for p in pats:
        for k in range(8):
            t = word(d, p - dest + 2 * k)
            if t and not dest <= t < end:
                return f'track ${t:04X} of pattern ${p:04X} outside'
    return None


def kinds(s=None, rom=None):
    if s is None:
        rom = open(os.path.join(ROOT, 'fe4.sfc'), 'rb').read()
        s = Sound(rom)
    cache = {}

    def data(cid):
        if cid not in cache:
            a, e, size, dest, fl = s.chunks[cid - FIRST_CHUNK]
            cache[cid] = decompress(rom, a, linear=True)[0] if fl & 1 else s.bytes(a, size)
        return cache[cid]

    def base():
        r = Replay(s, data)
        r.run(s.start_upload)
        return r

    def song(n):
        r = base()
        for w, arg in s.script_lists[s.scripts[n - 1]]:
            if 7 <= w >> 10 <= 14:
                r.run(s.bank << 16 | arg)
        return r, f'song ${n:02X}'

    replays = [song(n) for n in range(1, len(s.scripts) + 1)]
    by_songs = set()
    for r, _ in replays:
        by_songs |= set(r.placed)
    battle, _ = song(BATTLE_SONG)
    for ul in s.upload_lists:
        ids = [w & 0x7FF for w, arg in s.upload_lists[ul] if not w >> 12 and w >= FIRST_CHUNK]
        if ids and not set(ids) <= by_songs:
            r, _ = song(BATTLE_SONG)
            r.run(ul)
            replays.append((r, f'song ${BATTLE_SONG:02X} + aSoundUpload{ul:06X}'))

    kind, problems, notes = {}, [], []
    tiles = collections.defaultdict(set)
    reached = set()
    for r, name in replays:
        reached |= set(r.placed)
        for cid, (dest, n) in r.placed.items():
            if DIR <= dest < DIR + 0x100:
                kind[cid] = 'directory'
        for i in range(64):
            a = DIR + 4 * i
            if r.owner[a] is None:
                continue
            st, lp = word(r.ram, a), word(r.ram, a + 2)
            if not st and not lp:
                continue
            o = r.owner[st]
            if o is None:
                notes.append(f'{name}: directory entry {i} starts at ${st:04X}, where nothing of this replay was '
                             f'uploaded (left from an earlier upload, or not played)')
                continue
            e, loops = brr_end(r.ram, st)
            if e is None or r.owner[e - 1] != o:
                problems.append(f'{name}: sample at ${st:04X} runs out of chunk ${o:03X}')
                continue
            if not (st <= lp <= e and (lp - st) % 9 == 0) or (loops and lp == e):
                problems.append(f'{name}: sample at ${st:04X} loops at ${lp:04X}')
                continue
            d0 = r.placed[o][0]
            tiles[o].add((st - d0, e - d0))
        for cid, (dest, n) in r.placed.items():
            if INSTRUMENTS <= dest < INSTRUMENTS + 0x100:
                okay = n % 6 == 0
                for x in range(dest, dest + n - 5, 6):
                    a = DIR + 4 * r.ram[x]
                    st = word(r.ram, a)
                    if not (st and r.owner[st] in tiles) or not r.ram[x + 1] & 0x80:
                        okay = False
                if okay:
                    kind.setdefault(cid, 'instruments')
                else:
                    problems.append(f'{name}: chunk ${cid:03X} at ${dest:04X} is not a table of instruments')
    for o, spans in tiles.items():
        pos = 0
        for x, y in sorted(spans):
            if x != pos:
                break
            pos = y
        if pos == len(data(o)):
            kind[o] = 'sample'
        else:
            problems.append(f'chunk ${o:03X}: its samples do not cover it')
    for k, (a, e, size, dest, fl) in enumerate(s.chunks):
        cid = k + FIRST_CHUNK
        if fl & 1 and dest in SEQUENCE_DESTS:
            why = check_sequence(data(cid), dest)
            if why:
                problems.append(f'chunk ${cid:03X}: {why}')
            else:
                kind[cid] = 'sequence'
    for k, c in enumerate(s.chunks):
        kind.setdefault(k + FIRST_CHUNK, 'other' if k + FIRST_CHUNK in reached else 'not reached')
    return kind, problems, notes


def main():
    ap = argparse.ArgumentParser(description=__doc__.split('\n')[0])
    ap.add_argument('--report', action='store_true')
    args = ap.parse_args()
    rom = open(os.path.join(ROOT, 'fe4.sfc'), 'rb').read()
    s = Sound(rom)
    kind, problems, notes = kinds(s, rom)
    distinct = {}
    for k, c in enumerate(s.chunks):
        distinct.setdefault(c[0], k + FIRST_CHUNK)
    counts = collections.Counter(kind[cid] for cid in distinct.values())
    print(f'{len(distinct)} distinct chunks: ' + ', '.join(f'{v} {k}' for k, v in counts.most_common()))
    for p in problems:
        print('problem:', p)
    for n in sorted(set(notes)):
        print('note:', n)
    if args.report:
        for kd in ['other', 'not reached']:
            ids = [cid for cid in distinct.values() if kind[cid] == kd]
            print(f'{kd}:', ' '.join(f'${cid:03X}@{s.chunks[cid - FIRST_CHUNK][3]:04X}' for cid in ids))
    sys.exit(1 if problems else 0)


if __name__ == '__main__':
    main()
