#!/usr/bin/env python3
"""Write the battle animation frame data (banks $98-$9B) as labelled source.

usage: tools/battle_frames.py [--write] [--self-test]

Decodes everything aBattleAnimationFrameTables ($97/87AF) points at in the
original ROM (fe4.sfc): for each of its 46 entries (entry 0 is a placeholder)
a sequence data block and a frame table (formats in include/BattleAnimation.h).

  sequence data block: header (offsets of the index and of the record list),
    index (one word offset per sequence), frame record list (word offsets; it
    runs up to the lowest offset the index or the list points to), the
    sequences (two-byte steps; one ends at $FE/$FF or where the next structure
    begins, since $FD, $FC and $F4 jump back and data follows them) and the
    frame records (a frame number, then a structSpriteArray);
  frame table: word offsets to frames (the first word / 2 is the count); a
    frame is a count byte and (sheet offset, byte count) word pairs.

Blocks overlap: blocks that share frame records have the same record list,
and the later block's header sits among the earlier block's sequences. Every
address something points to is referenced by the block (or frame table) whose
start is the nearest before it, so each structure is labelled locally in that
scope (_SequenceNN, _RecordNN, _FrameNN, numbered by that block) and every
offset is written as label - block.

Before writing it checks that the decoded structures cover exactly the four
known regions, that no two structures overlap except as known (one sequence
is the $FF frame byte of a record), that all sequences agree on step
alignment, that every byte fe4.cdl shows read near the regions is decoded,
and that the steps which name a record past the end of their block's list
are the known ones, in sequences fe4.cdl never read.

Without --write it reports. --write writes data/battle_animation/frames_XX.asm
(one section per region), places the sections in build.asm and builds; run
tools/raw_addresses.py --write afterwards for the table's pointers.

--self-test (after --write): in a temporary copy, duplicates one sprite in the
middle of a sprite array in the first region, builds, and checks that the
decoded content of every entry, read through aBattleAnimationFrameTables in the
built ROM, is the original's except for that one sprite, and that the blocks
after the edit moved.
"""
import argparse
import bisect
import collections
import os
import re
import shutil
import subprocess
import sys
import tempfile
import textwrap

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from decompress import rom_offset

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
TABLE = 0x9787AF                 # aBattleAnimationFrameTables
FRAME_INDICES = 0x97874F         # aBattleAnimationFrameIndices
LOOKUP = 0x9788C9                # 206 records: class, weapon category, character,
LOOKUP_COUNT = 206               # class/gender value, four animation IDs
ENTRIES = 47
# rlBattleAnimationCheckDance replaces the lookup for a Dancer whose action is a dance
# (action struct field Unknown = 8, bits 2-3 of $7FFC59): IDs $5E $66 $46 $2E.
DANCE_FIRST_ID = 0x5E
REGIONS = [(0x98B41E, 0x98FF85), (0x998FA1, 0x99F6C1), (0x9ABA2A, 0x9AFEAA), (0x9B8000, 0x9BC16F)]
# Sequences with a step naming a record past the end of the block's list:
# (block, offset of the sequence in the block). Four steps in all, three
# distinct: two sequences share the one in $9A/C88D.
KNOWN_BAD_SEQUENCES = {(0x99D20F, 0x1AA), (0x9AC88D, 0x11E), (0x9AC88D, 0x124)}
# Weapon categories (high nibble of the item's byte in the table at $99/83B9,
# read by rlBattleSceneGetWeaponAnimStyle): 5 is the Javelin and 6 the Hand Axe and Helswath,
# which use them only at wBattleDistance 2 or more (else lance or axe).
CATEGORIES = {0: 'Sword', 1: 'Lance', 2: 'Axe', 3: 'Bow', 5: 'RangedLance', 6: 'RangedAxe',
              7: 'Magic', 8: 'Staff'}
COMMANDS = {0xFF: 'ANIM_END', 0xFE: 'ANIM_HOLD', 0xFD: 'ANIM_RESTART', 0xFC: 'ANIM_BACK',
            0xFB: 'ANIM_WAIT', 0xFA: 'ANIM_SOUND', 0xF9: 'ANIM_NOP', 0xF7: 'ANIM_CLEAR_BUSY',
            0xF6: 'ANIM_SET_BUSY'}
ARG_REQUIRED = {0xFC, 0xFB, 0xFA, 0xF4, 0xEF, 0xED, 0xEC}


class Rom:
    def __init__(self, data):
        self.b = data

    def o(self, a):
        x = rom_offset(a)
        return rom_offset(a | 0x400000) if x is None else x

    def byte(self, a): return self.b[self.o(a)]
    def word(self, a): x = self.o(a); return self.b[x] | self.b[x + 1] << 8
    def long(self, a): x = self.o(a); return int.from_bytes(self.b[x:x + 3], 'little')


class Decoded:
    """Everything the table points at, by address."""

    def __init__(self, rom, table=TABLE):
        self.rom = rom
        self.entries = [(rom.long(table + 6 * k), rom.long(table + 6 * k + 3)) for k in range(ENTRIES)]
        self.blocks = {}       # start -> dict(index, list, seqs, recs)
        self.ftabs = {}        # start -> [frame addresses]
        self.structs = {}      # start -> (kind, end) for everything but sequences
        self.seqs = {}         # start -> end
        self.problems = []
        for S, F in self.entries[1:]:
            if S not in self.blocks:
                self.block(S)
            if F not in self.ftabs:
                self.ftab(F)
        self.sequences()

    def add(self, a, n, kind):
        old = self.structs.get(a)
        if old and old != (kind, a + n):
            self.problems.append(f'${a:06X}: {old[0]} and {kind} of different lengths')
        self.structs[a] = (kind, a + n)

    def block(self, S):
        r = self.rom
        io, lo = r.word(S), r.word(S + 2)
        idx = [r.word(S + io + 2 * j) for j in range((lo - io) // 2)]
        limit = min(idx)
        lst = []
        while lo + 2 * len(lst) < limit:
            v = r.word(S + lo + 2 * len(lst))
            lst.append(v)
            limit = min(limit, v)
        self.blocks[S] = {'index': S + io, 'list': S + lo,
                          'seqs': [S + v for v in idx], 'recs': [S + v for v in lst]}
        self.add(S, 4, 'header')
        self.add(S + io, 2 * len(idx), 'index')
        self.add(S + lo, 2 * len(lst), 'list')
        for a in self.blocks[S]['recs']:
            self.add(a, 3 + 5 * r.word(a + 1), 'record')

    def ftab(self, F):
        r = self.rom
        frames = [F + r.word(F + 2 * j) for j in range(r.word(F) // 2)]
        self.ftabs[F] = frames
        self.add(F, 2 * len(frames), 'ftab')
        for a in frames:
            self.add(a, 1 + 4 * r.byte(a), 'frame')

    def sequences(self):
        starts = sorted(self.structs)
        for b in self.blocks.values():
            for a in b['seqs']:
                if a in self.seqs:
                    continue
                k = bisect.bisect_right(starts, a)
                nxt = starts[k] if k < len(starts) else 1 << 24
                x = a
                while x < nxt:
                    first = self.rom.byte(x)
                    x += 2
                    if first in (0xFE, 0xFF):
                        break
                if x > nxt:
                    self.problems.append(f'sequence ${a:06X} runs into ${nxt:06X}')
                self.seqs[a] = x

    def owners(self):
        """Address -> set of (kind, start) for every decoded byte."""
        own = collections.defaultdict(set)
        for a, (kind, e) in self.structs.items():
            for x in range(a, e):
                own[x].add((kind, a))
        for a, e in self.seqs.items():
            for x in range(a, e):
                own[x].add(('sequence', (x - a) & 1))       # step alignment
        return own

    def content(self):
        """The entries' content, independent of addresses (for the self-test)."""
        r = self.rom
        out = []
        for S, F in self.entries[1:]:
            b = self.blocks[S]
            out.append((
                [bytes(r.byte(x) for x in range(a, self.seqs[a])) for a in b['seqs']],
                [(r.byte(a), bytes(r.byte(x) for x in range(a + 3, self.structs[a][1]))) for a in b['recs']],
                [bytes(r.byte(x) for x in range(a, self.structs[a][1])) for a in self.ftabs[F]]))
        return out


def check(d, cdl):
    """The coverage and log checks. Returns a list of problems."""
    problems = list(d.problems)
    own = d.owners()
    runs = []
    for a in sorted(own):
        if runs and runs[-1][1] == a:
            runs[-1][1] = a + 1
        else:
            runs.append([a, a + 1])
    if [tuple(r) for r in runs] != REGIONS:
        problems.append('decoded runs ' + ', '.join(f'${a:06X}-${b - 1:06X}' for a, b in runs)
                        + ' are not the four known regions')
    for x, o in own.items():
        kinds = {k for k, _ in o}
        if len(o) == 1:
            continue
        if kinds == {'sequence'}:
            problems.append(f'${x:06X}: sequences disagree on step alignment')
        elif kinds == {'record', 'sequence'} and len(o) == 2:
            rec = next(s for k, s in o if k == 'record')
            if rec not in d.seqs or d.seqs[rec] != rec + 2 or d.rom.byte(rec) != 0xFF:
                problems.append(f'${x:06X}: a sequence overlaps record ${rec:06X}')
        else:
            problems.append(f'${x:06X}: claimed by ' + ', '.join(f'{k} {s}' for k, s in sorted(o, key=str)))
    # Every byte the log shows read in the regions must be inside a structure.
    for a, b in REGIONS:
        for x in range(a, b):
            if cdl[x & 0x3FFFFF] & 0x02 and x not in own:
                problems.append(f'${x:06X}: read in the log but not decoded')
    # Steps that name a record past the end of their block's list.
    bad = set()
    for S, b in d.blocks.items():
        for a in b['seqs']:
            for x in range(a, d.seqs[a], 2):
                first = d.rom.byte(x)
                if first < 0xE8 and first - 1 >= len(b['recs']):
                    bad.add((S, x - S, a))
    if {(S, a - S) for S, o, a in bad} != KNOWN_BAD_SEQUENCES or len(bad) != 4:
        problems.append('steps past the record list: ' + ', '.join(f'${S:06X}+${o:X} (sequence +${a - S:X})'
                                                                   for S, o, a in sorted(bad)))
    for S, o, a in bad:
        if any(cdl[x & 0x3FFFFF] & 0x02 for x in range(a, d.seqs[a])):
            problems.append(f'sequence ${a:06X}, with a step past the record list, was read in the log')
    return problems, bad


def names(d, rom):
    """Entry number -> name, from the first user in the animation lookup."""
    classes = [l.split(',')[0] for l in open(os.path.join(ROOT, 'data/class/ClassData.csv')).read().split('\n')[1:] if l.strip()]
    users = collections.defaultdict(list)
    for k in range(LOOKUP_COUNT):
        rec = [rom.byte(LOOKUP + 8 * k + i) for i in range(8)]
        users[rom.byte(FRAME_INDICES + rec[4] + 1)].append((classes[rec[0]], rec[1]))
    out = {}
    dance = rom.byte(FRAME_INDICES + DANCE_FIRST_ID + 1)
    users[dance].append(('Dancer', 'Dance'))
    for k in range(1, ENTRIES):
        if k == dance and len(users[k]) == 1:
            out[k] = 'DancerDance'
        elif users[k]:
            cls, cat = users[k][0]
            out[k] = cls + CATEGORIES.get(cat, f'Category{cat}')
        else:
            out[k] = f'Unused{k:02d}'
    assert len(set(out.values())) == len(out), 'names are not unique'
    return out, users


def hexw(v, n=4):
    return f'${v:0{n}X}'


def emit(d, problems_bad):
    rom = d.rom
    nm, users = names(d, rom)
    first_entry_s = {}
    first_entry_f = {}
    for k, (S, F) in enumerate(d.entries[1:], 1):
        first_entry_s.setdefault(S, k)
        first_entry_f.setdefault(F, k)
    top = {}                                   # address -> global label
    for S, k in first_entry_s.items():
        top[S] = f'aBattleAnimationSequences{nm[k]}'
    for F, k in first_entry_f.items():
        top[F] = f'aBattleAnimationFrames{nm[k]}'
    scopes = sorted(top)

    def scope(a):
        return scopes[bisect.bisect_right(scopes, a) - 1]

    local = collections.defaultdict(list)      # address -> [local names] (in its scope)
    for S, b in d.blocks.items():
        local[b['index']].append('_Index')
        local[b['list']].append('_Records')
    for S, b in d.blocks.items():
        for j, a in enumerate(b['seqs']):
            if scope(a) == S and f'_Sequence{j:02d}' not in local[a]:
                local[a].append(f'_Sequence{j:02d}')
        for j, a in enumerate(b['recs']):
            if scope(a) == S:
                local[a].append(f'_Record{j:02d}')
    for F, frames in d.ftabs.items():
        for j, a in enumerate(frames):
            assert scope(a) == F
            local[a].append(f'_Frame{j:02d}')

    def ref(a, kind, here):
        """A label for address a, qualified unless it is in scope `here`."""
        s = scope(a)
        if a == s:
            return top[s]
        cands = [n for n in local[a] if n.startswith(kind)] or local[a]
        if not cands:
            raise SystemExit(f'nothing labels ${a:06X} ({kind})')
        return cands[0] if s == here else f'{top[s]}.{cands[0]}'

    def offset(a, base, kind, here):
        return f'{ref(a, kind, here)} - {top[base]}'

    seqends = {a: e for a, e in d.seqs.items()}
    noend = {a for a, e in seqends.items() if rom.byte(e - 2) not in (0xFE, 0xFF)}
    seqbytes = set()
    for a, e in seqends.items():
        seqbytes.update(range(a, e))
    bad_at = {S + o for S, o, _ in problems_bad}
    files = {}
    for ra, rb in REGIONS:
        bank = ra >> 16
        sec = f'BattleAnimationFrameData{bank:02X}Section'
        out = [f'    .section {sec}', '']
        x = ra
        cur = None
        while x < rb:
            if x in top:
                cur = x
                lab = top[x]
                out.append(f'      {lab} ; {x >> 16:02X}/{x & 0xFFFF:04X}')
                out.append('')
                if x in d.blocks:
                    ks = [k for k, (S, F) in enumerate(d.entries) if S == x and k]
                    k = ks[0]
                    us = []
                    for c, cat in users[k]:
                        n = f'{c} (dancing, rlBattleAnimationCheckDance)' if cat == 'Dance' else f'{c} ({CATEGORIES.get(cat, cat)})'
                        if n not in us:
                            us.append(n)
                    F = d.entries[k][1]
                    text = (f'Sequence data of entry {k} of aBattleAnimationFrameTables'
                            + (f', used by: {", ".join(us)}.' if us else
                               '; nothing selects it (no lookup record has a first ID that leads here) and no '
                               'sheet in aBattleAnimationSheets is the size its frames need: probably left over.')
                            + f' Frames: {top[F]}.')
                    out += ['        ; ' + l for l in textwrap.wrap(text, 88)]
                    out.append('')
                    b = d.blocks[x]
                    out.append(f'        .word {offset(b["index"], x, "_Index", x)}, {offset(b["list"], x, "_Records", x)}')
                    out.append('')
                    x += 4
                    continue
                else:
                    ks = [k for k, (S, F) in enumerate(d.entries) if F == x and k]
                    out.append(f'        ; Frame table of entr{"y" if len(ks) == 1 else "ies"} '
                               + ', '.join(str(k) for k in ks) + ': slices of the class sheet per frame.')
                    out.append('')
                    for a in d.ftabs[x]:
                        out.append(f'        .word {offset(a, x, "_Frame", cur)}')
                    out.append('')
                    x += 2 * len(d.ftabs[x])
                    continue
            labels = local.get(x, [])
            st = d.structs.get(x)
            if st:
                kind, e = st
                for n in labels:
                    out.append(f'      {n}')
                seq_here = [n for n in labels if n.startswith('_Sequence')]
                if kind == 'record' and seq_here:
                    out.append(f'        ; {seq_here[0]} is this record\'s first two bytes, read as a step: '
                               f'its frame number $FF')
                    out.append(f'        ; (ANIM_END) and the low byte of the sprite count. Keep the frame '
                               f'ANIM_KEEP_TILES, or {seq_here[0]} changes.')
                if kind in ('index', 'list'):
                    blk = next(S for S, b in d.blocks.items() if b['index' if kind == 'index' else 'list'] == x)
                    targets = d.blocks[blk]['seqs' if kind == 'index' else 'recs']
                    for t in targets:
                        out.append(f'        .word {offset(t, blk, "_Sequence" if kind == "index" else "_Record", cur)}')
                elif kind == 'record':
                    f = rom.byte(x)
                    out.append(f'        ANIM_RECORD {"ANIM_KEEP_TILES" if f == 0xFF else f}')
                    for s in range(rom.word(x + 1)):
                        a = x + 3 + 5 * s
                        xw, y, attr = rom.word(a), rom.byte(a + 2), rom.word(a + 3)
                        xc = (xw & 0x1FF) - (0x200 if xw & 0x100 else 0)
                        yc = y - 0x100 if y & 0x80 else y
                        out.append(f'        .structSpriteEntry ({xc:4}, {yc:4}), {hexw(xw >> 9 & 0x3F, 2)}, '
                                   f'{"SpriteLarge" if xw & 0x8000 else "SpriteSmall"}, {hexw(attr & 0x1FF, 3)}, '
                                   f'{attr >> 12 & 3}, {attr >> 9 & 7}, {str(bool(attr & 0x4000)).lower()}, '
                                   f'{str(bool(attr & 0x8000)).lower()}')
                    out.append('        ANIM_RECORD_END')
                elif kind == 'frame':
                    out.append('        ANIM_TILES')
                    for p in range(rom.byte(x)):
                        out.append(f'        ANIM_TILE_ROW {hexw(rom.word(x + 1 + 4 * p))}, {hexw(rom.word(x + 3 + 4 * p))}')
                    out.append('        ANIM_TILES_END')
                else:
                    raise SystemExit(f'unexpected {kind} at ${x:06X}')
                out.append('')
                x = e
                continue
            if x in seqbytes:
                # A run of steps: up to the next structure or top label.
                for n in labels:
                    out.append(f'      {n}')
                first, arg = rom.byte(x), rom.byte(x + 1)
                note = ''
                if x in bad_at:
                    note = f' ; record {first - 1}: past the end of the list, never read in fe4.cdl'
                if first < 0xE8:
                    out.append(f'        ANIM_STEP {first - 1}, {arg}{note}')
                else:
                    m = COMMANDS.get(first, f'ANIM_CMD_{first:02X}')
                    out.append(f'        {m}' + (f' {arg}' if arg or first in ARG_REQUIRED else ''))
                x += 2
                nxt_struct = x in d.structs or x in top
                if any(seqends[a] == x for a in seqends if a < x and a in noend) and nxt_struct:
                    out.append('        ; (no end marker: the next structure begins here)')
                if x in d.structs or x in top or x in local or rom.byte(x - 2) in (0xFE, 0xFF):
                    out.append('')
                continue
            raise SystemExit(f'${x:06X}: not decoded')
        out += [f'    .endsection {sec}', '']
        files[bank] = out
    return files


def place(files, write):
    """Place one section per region in build.asm before the next placement."""
    path = os.path.join(ROOT, 'build.asm')
    b = open(path, encoding='utf-8').read().split('\n')
    starts = [(i, int(m.group(1), 16)) for i, l in enumerate(b) if (m := re.match(r'\s*\* = \$([0-9A-Fa-f]+)', l))]
    inserts = []
    for (ra, rb), bank in zip(REGIONS, sorted(files)):
        sec = f'BattleAnimationFrameData{bank:02X}Section'
        if any(f'.dsection {sec}' in l for l in b):
            continue
        off = rom_offset(ra)
        for i, s in starts:
            if off <= s < rom_offset(rb - 1) + 1:
                raise SystemExit(f'build.asm already places something at ${s:06X}, inside ${ra:06X}-${rb - 1:06X}')
        nxt = min((s for s in starts if s[1] > off), key=lambda t: t[1], default=(len(b), None))
        inserts.append((nxt[0], off, [f'    * = ${off:06X}', f'    .logical ${ra:06X}', '',
                                      f'      .dsection {sec}', '', '    .here', '']))
    for at, _, block in sorted(inserts, key=lambda t: (-t[0], -t[1])):
        b[at:at] = block
    incs = [f'  .include "data/battle_animation/frames_{bank:02X}.asm"' for bank in sorted(files)]
    for inc in incs:
        if inc not in b:
            k = max(i for i, l in enumerate(b) if l.startswith('  .include "'))
            b[k + 1:k + 1] = [inc]
    if write:
        open(path, 'w', encoding='utf-8').write('\n'.join(b))
    return len(inserts)


def self_test():
    """Duplicate a sprite in a temporary copy, build, compare decoded content."""
    rom = Rom(open(os.path.join(ROOT, 'fe4.sfc'), 'rb').read())
    orig = Decoded(rom)
    tmp = tempfile.mkdtemp(prefix='battle_frames_')
    try:
        src = os.path.join(tmp, 'src')
        subprocess.run(['rsync', '-a', '--exclude', '.git', '--exclude', '*.smc', '--exclude', '*.sfc',
                        './', src + '/'], cwd=ROOT, check=True)
        shutil.copy(os.path.join(ROOT, 'fe4.sfc'), os.path.join(src, 'fe4.sfc'))
        # Bank $9A: bank $98 has 1 spare byte since the demo battles were placed after the frame
        # data, and $9A's .fill to the bank end absorbs the growth.
        name = 'frames_9A.asm'
        p = os.path.join(src, 'data/battle_animation', name)
        lines = open(p).read().split('\n')
        # A record in the middle of the region with at least three sprites.
        recs = [i for i, l in enumerate(lines) if l.strip().startswith('ANIM_RECORD ')]
        i = next(i for i in recs[len(recs) // 2:] if lines[i + 3].strip().startswith('.structSpriteEntry'))
        lines.insert(i + 2, lines[i + 2])
        open(p, 'w').write('\n'.join(lines))
        r = subprocess.run(['./build.sh'], cwd=src, capture_output=True, text=True)
        built = os.path.join(src, 'FE4Disassembly.sfc')
        if not os.path.exists(built):
            log = os.path.join(src, 'log.txt')
            errs = [l for l in open(log).read().split('\n') if ': error:' in l] if os.path.exists(log) else []
            print('\n'.join(errs[:10]) or r.stdout[-2000:] + r.stderr[-2000:])
            raise SystemExit('self-test: the edited copy did not build')
        lab = {}
        for line in open(os.path.join(src, 'labels.txt')):
            q = line.split()
            if len(q) == 3 and ':' not in q[2]:
                lab.setdefault(q[2].lstrip('.'), int(q[1], 16))
        new = Decoded(Rom(open(built, 'rb').read()), lab['aBattleAnimationFrameTables'])
        a, b = orig.content(), new.content()
        diffs = []
        for k, (x, y) in enumerate(zip(a, b), 1):
            for part, (u, v) in enumerate(zip(x, y)):
                for j, (s, t) in enumerate(zip(u, v)):
                    if s != t:
                        diffs.append((k, ('sequence', 'record', 'frame')[part], j, s, t))
        moved = sum(1 for (S0, F0), (S1, F1) in zip(orig.entries, new.entries) if S0 != S1 or F0 != F1)
        print(f'self-test: duplicated sprite at line {i + 3} of {name}; '
              f'{moved} table entries moved; content differences: {len(diffs)}')
        ok = moved > 0
        # Expected: the edited record (in every block sharing it) has one sprite more.
        for k, part, j, s, t in diffs:
            if part != 'record' or s[0] != t[0] or len(t[1]) != len(s[1]) + 5:
                ok = False
            print(f'  entry {k} {part} {j}: {len(s[1]) // 5} -> {len(t[1]) // 5} sprites')
        if not diffs:
            ok = False
        print('self-test passed' if ok else 'self-test FAILED')
        return ok
    finally:
        shutil.rmtree(tmp, ignore_errors=True)


def kept_tail(old, sec):
    """What the existing file has after this tool's section: other sections later work put in the
    same file (the demo battles and battle scene texts in frames_98 and frames_9A), kept as they are."""
    if old is None:
        return ''
    end = f'    .endsection {sec}\n'
    if end not in old:
        raise SystemExit(f'{sec}: no ".endsection" line in the existing file; not overwriting it')
    return old.split(end, 1)[1]


def main():
    ap = argparse.ArgumentParser(description=__doc__.split('\n')[0])
    ap.add_argument('--write', action='store_true')
    ap.add_argument('--self-test', action='store_true')
    args = ap.parse_args()
    if args.self_test:
        sys.exit(0 if self_test() else 1)
    rom = Rom(open(os.path.join(ROOT, 'fe4.sfc'), 'rb').read())
    cdl = open(os.path.join(ROOT, 'fe4.cdl'), 'rb').read()[9:]
    d = Decoded(rom)
    problems, bad = check(d, cdl)
    nrec = sum(1 for k, _ in d.structs.values() if k == 'record')
    nfr = sum(1 for k, _ in d.structs.values() if k == 'frame')
    noend = sum(1 for a, e in d.seqs.items() if rom.byte(e - 2) not in (0xFE, 0xFF))
    print(f'{len(d.blocks)} sequence blocks, {len(d.ftabs)} frame tables, {len(d.seqs)} sequences '
          f'({noend} without an end marker), {nrec} frame records, {nfr} frames; '
          f'{sum(b - a for a, b in REGIONS):,} bytes in {len(REGIONS)} regions')
    for p in problems:
        print('problem:', p)
    if problems:
        sys.exit(1)
    print('coverage and log checks passed')
    files = emit(d, bad)
    rel = 'data/battle_animation'
    changed = []
    for bank, lines in files.items():
        text = (f'; Battle animation frame data in bank ${bank:02X}: sequence data blocks and frame tables\n'
                f'; reached from aBattleAnimationFrameTables. Written by tools/battle_frames.py;\n'
                f'; formats and macros in include/BattleAnimation.h.\n\n' + '\n'.join(lines))
        path = os.path.join(ROOT, rel, f'frames_{bank:02X}.asm')
        old = open(path).read() if os.path.exists(path) else None
        text += kept_tail(old, f'BattleAnimationFrameData{bank:02X}Section')
        if old != text:
            changed.append(path)
            if args.write:
                os.makedirs(os.path.dirname(path), exist_ok=True)
                open(path, 'w').write(text)
        print(f'{rel}/frames_{bank:02X}.asm: {len(lines):,} lines' + ('' if old != text else ' (unchanged)'))
    n = place(files, args.write)
    print(f'{n} placements to add to build.asm')
    if not args.write:
        return
    inc = os.path.join(ROOT, 'include/fe4.h')
    t = open(inc).read()
    if '"BattleAnimation.h"' not in t:
        t = t.replace('  .include "Battle.h"\n', '  .include "Battle.h"\n  .include "BattleAnimation.h"\n')
        open(inc, 'w').write(t)
    sys.exit(subprocess.call(['./build.sh'], cwd=ROOT))


if __name__ == '__main__':
    main()
