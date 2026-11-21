#!/usr/bin/env python3
"""Write the sound data ($F7/7C00 to the end of the ROM) as labelled source.

usage: tools/sound.py [--write] [--self-test]

The sound data is one linear block: the readers (rlUnknown808EF6, the upload
routine rlUnknown8091B3, rsUnknown8093C6, rsUnknown809677, and the
decompressor's linear entry rlUnknown80A9F2) step from $xx/FFFF to $xx+1/0000,
and every pointer in it is a 16-bit address plus a bank relative to the
header's bank ($04B8 holds that bank as $F700). The header (aSoundHeader)
points at everything else, so the decoder starts there:

  Driver          3 bytes: address, bank - header bank; then a 0 byte. The SPC
                  driver, in the IPL upload format rlUnknown809124 sends: blocks
                  of (size, SPC address, bytes), ended by size 0 and the address
                  to start at.
  Scripts         word table, indexed by request - 1 (rsUnknown809677): each
                  entry points at a script.
  ScriptData      the scripts: words up to $0000. Bits 15-10 a command (0 none),
                  bits 9-0 frames to wait after it; a command takes the next
                  word as its argument. Commands 7-14 upload: the argument
                  points at an upload list (7-10 at once, 11-14 when the APU is
                  free); 1-2 play a sound effect, 3-4 a second sound effect, 5
                  sends a sound command; the rest are not read yet.
  UploadLists     word table of upload lists, indexed by an upload list ID
                  below $64 (rsUnknown8093C6 steps through the list, one entry
                  per call).
  UploadData      the upload lists, read by rlUnknown8091B3: words up to $0000.
                  $0064-$07FF uploads that chunk; $0001-$0063 an indirect
                  upload (rsUnknown8093C6); bits 15-12 a command: $Cxxx takes
                  the next word as the SPC address for what follows, $A, $B and
                  $F others (jump table aUnknown809357).
  Chunks          the chunk table: 8 bytes per chunk ID from $64: address (3
                  bytes, as above), size, SPC address (0: after the previous
                  chunk), flags (bit 0 compressed, decompressed into a WRAM
                  buffer first, bit 1 picks the second buffer).
  DriverID        the driver's ID text.
  Unknown12       byte tables rsUnknown8093C6 indexes by a unit value
                  ($7E4EA9,x) for upload IDs 1-4.
  StartUpload     a word: the upload list sent after the driver (rlUnknown808EF6).
  TerrainUploads  word table of upload lists that IDs 3 and 4 index by terrain.

Chunks are written as audio/chunks/ID.bin (raw) or ID.comp (compressed, the
ROM's bytes), named after the lowest ID that uses them; the driver blocks as
audio/driver/ADDR.bin. Everything else goes into audio/sound_data.asm, with
every pointer a label. Before writing it checks that the header's structures
and the chunks cover $F7/7C00 to the end of the ROM without overlaps, that
every compressed chunk decompresses to its stated size and that every pointer
lands on the start of a list.

--write writes the files, places the section in build.asm and builds.
--self-test (after --write) lengthens a raw chunk in the middle of the region
by 16 bytes in a temporary copy, builds, and checks that every chunk, script
and list decodes the same from the built ROM except for that chunk, and that
the chunks after it moved.
"""
import argparse
import os
import re
import shutil
import subprocess
import sys
import tempfile

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from decompress import rom_offset, decompress

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
HEADER = 0xF77C00
ROM_END = 0x1000000             # $FF/FFFF + 1
FIRST_CHUNK = 0x64


class Sound:
    def __init__(self, rom, header=HEADER):
        self.rom = rom
        self.h = header
        self.bank = header >> 16
        b = self.byte
        self.hdr = {
            'Driver': self.word(header) | (self.bank + b(header + 2)) << 16,
            'Scripts': self.ptr(header + 4), 'ScriptData': self.ptr(header + 6),
            'UploadLists': self.ptr(header + 8), 'UploadData': self.ptr(header + 10),
            'Chunks': self.ptr(header + 12), 'StartUpload': self.ptr(header + 14),
            'DriverID': self.ptr(header + 16), 'Unknown12': self.ptr(header + 18),
            'TerrainUploads': self.ptr(header + 20)}
        H = self.hdr
        self.problems = []
        # Driver blocks.
        self.driver = []
        a = H['Driver']
        while True:
            size, dest = self.word(a), self.word(a + 2)
            if size == 0:
                self.driver_start = dest
                self.driver_end = a + 4
                break
            self.driver.append((dest, self.bytes(a + 4, size)))
            a += 4 + size
        # Chunk table.
        n = (H['Scripts'] - H['Chunks']) // 8
        self.chunks = []
        for k in range(n):
            e = H['Chunks'] + 8 * k
            addr = self.word(e) | (self.bank + b(e + 2)) << 16
            size, dest, flags = self.word(e + 3), self.word(e + 5), b(e + 7)
            if flags & 1:
                data, end = decompress(rom, addr, linear=True)
                if len(data) != size:
                    self.problems.append(f'chunk ${FIRST_CHUNK + k:03X} decompresses to {len(data)} bytes, not {size}')
            else:
                end = addr + size
            self.chunks.append((addr, end, size, dest, flags))
        # Word tables and lists.
        self.scripts = [self.ptr(H['Scripts'] + 2 * i) for i in range((H['ScriptData'] - H['Scripts']) // 2)]
        self.script_lists = self.lists(H['ScriptData'], H['UploadLists'], script=True)
        self.upload_table = [self.ptr(H['UploadLists'] + 2 * i, zero=True)
                             for i in range((H['TerrainUploads'] - H['UploadLists']) // 2)]
        self.terrain_table = [self.ptr(H['TerrainUploads'] + 2 * i, zero=True)
                              for i in range((H['UploadData'] - H['TerrainUploads']) // 2)]
        self.upload_lists = self.lists(H['UploadData'], H['DriverID'], script=False)
        self.driver_id = self.bytes(H['DriverID'], H['Unknown12'] - H['DriverID'])
        self.unknown12 = self.bytes(H['Unknown12'], H['StartUpload'] - H['Unknown12'])
        self.start_upload = self.ptr(H['StartUpload'])
        self.tables_end = H['StartUpload'] + 2
        # Every pointer must land on a list start.
        for name, targets, lists in [('script table', self.scripts, self.script_lists),
                                     ('upload list table', self.upload_table, self.upload_lists),
                                     ('terrain table', self.terrain_table, self.upload_lists),
                                     ('start upload', [self.start_upload], self.upload_lists),
                                     ('script arguments', self.script_targets(), self.upload_lists)]:
            for t in targets:
                if t and t not in lists:
                    self.problems.append(f'{name}: ${t:06X} is not the start of a list')

    # ROM access.
    def byte(self, a):
        return self.rom[rom_offset(a)]

    def word(self, a):
        return self.byte(a) | self.byte(a + 1) << 8

    def bytes(self, a, n):
        return bytes(self.byte(a + i) for i in range(n))

    def ptr(self, a, zero=False):
        w = self.word(a)
        return 0 if (zero and w == 0) else (self.bank << 16 | w)

    def lists(self, start, end, script):
        """{address: [items]} for the lists from start to end. A script item is
        (word, argument or None); an upload item is (word, argument or None)."""
        out = {}
        a = start
        while a < end:
            s = a
            items = []
            while True:
                w = self.word(a)
                a += 2
                if w == 0:
                    break
                arg = None
                if (script and w >> 10) or (not script and w >> 12 == 0xC):
                    arg = self.word(a)
                    a += 2
                items.append((w, arg))
            out[s] = items
        if a != end:
            self.problems.append(f'lists ${start:06X}-${end:06X} end at ${a:06X}')
        return out

    def script_targets(self):
        return [self.bank << 16 | arg for items in self.script_lists.values()
                for w, arg in items if 7 <= w >> 10 <= 14]

    def regions(self):
        """(start, end, what) for everything the header reaches, in address order."""
        H = self.hdr
        r = [(self.h, self.h + 22, 'header'), (H['Chunks'], H['Scripts'], 'chunk table'),
             (H['Scripts'], self.tables_end, 'tables and lists'),
             (H['Driver'], self.driver_end, 'driver')]
        seen = set()
        for k, (a, e, *_rest) in enumerate(self.chunks):
            if a not in seen:
                seen.add(a)
                r.append((a, e, f'chunk ${FIRST_CHUNK + k:03X}'))
        return sorted(r)

    def content(self):
        """What the data says, with addresses replaced by what they point at."""
        def resolve(items, lists):
            return tuple((w, tuple(lists[self.bank << 16 | arg]) if 7 <= w >> 10 <= 14 else arg)
                         for w, arg in items)
        chunks = [(size, dest, flags, self.bytes(a, e - a)) for a, e, size, dest, flags in self.chunks]
        scripts = [resolve(self.script_lists[t], self.upload_lists) for t in self.scripts]
        uploads = [tuple(self.upload_lists[t]) if t else None for t in self.upload_table + self.terrain_table]
        return {'chunks': chunks, 'scripts': scripts, 'uploads': uploads,
                'start': tuple(self.upload_lists[self.start_upload]),
                'driver': (self.driver, self.driver_start), 'id': self.driver_id, 'unknown12': self.unknown12}


def check(s):
    problems = list(s.problems)
    pos = s.h
    gaps = []
    for a, e, what in s.regions():
        if a < pos:
            problems.append(f'{what} at ${a:06X} overlaps what ends at ${pos:06X}')
        elif a > pos:
            gaps.append((pos, a))
        pos = max(pos, e)
    tail = (pos, ROM_END)
    if any(s.byte(x) for x in range(*tail)):
        problems.append(f'the bytes after the last chunk (${pos:06X}) are not all $00')
    return problems, gaps, tail


def name(s, k):
    return f'aSoundChunk{FIRST_CHUNK + k:03X}'


def emit(s, gaps, tail):
    """Lines of audio/sound_data.asm, and {path: bytes} of the files."""
    H = s.hdr
    files = {}
    chunk_name = {}                       # address -> (label, path, compressed)
    for k, (a, e, size, dest, flags) in enumerate(s.chunks):
        if a not in chunk_name:
            ext = 'comp' if flags & 1 else 'bin'
            path = f'chunks/{FIRST_CHUNK + k:03X}.{ext}'
            chunk_name[a] = (name(s, k), path)
            files[path] = s.bytes(a, e - a)

    def lab(prefix, a):
        return f'{prefix}{a:06X}'

    def script_label(a):
        return lab('aSoundScript', a)

    def upload_label(a):
        return lab('aSoundUpload', a)

    L = []
    w = L.append
    w('    .section SoundDataSection')
    w('')
    w(f'      aSoundHeader .block ; {s.h >> 16:02X}/{s.h & 0xFFFF:04X}')
    w('        Driver         .word <>aSoundDriver')
    w('                       .byte (`aSoundDriver) - (`aSoundHeader), 0')
    w('        Scripts        .word <>aSoundScripts')
    w(f'        ScriptData     .word <>{script_label(H["ScriptData"])}')
    w('        UploadLists    .word <>aSoundUploadLists')
    w(f'        UploadData     .word <>{upload_label(H["UploadData"])}')
    w('        Chunks         .word <>aSoundChunks')
    w('        StartUpload    .word <>aSoundStartUpload')
    w('        DriverID       .word <>aSoundDriverID')
    w('        Unknown12      .word <>aSoundUnknownF7AD9C')
    w('        TerrainUploads .word <>aSoundTerrainUploads')
    w('      .endblock')
    w('')
    w(f'      aSoundChunks ; {H["Chunks"] >> 16:02X}/{H["Chunks"] & 0xFFFF:04X}')
    w('')
    w('        ; label, size, SPC address (0: after the previous chunk), flags; chunk ID in the comment')
    for k, (a, e, size, dest, flags) in enumerate(s.chunks):
        label, path = chunk_name[a]
        fl = ' | '.join(f for bit, f in [(1, 'SOUND_CHUNK_COMPRESSED'), (2, 'SOUND_CHUNK_BUFFER2')] if flags & bit) or '0'
        sz = f'${size:04X}' if flags & 1 else f'len(binary("{path}"))'
        w(f'        .soundChunk {label}, {sz}, ${dest:04X}, {fl} ; ${FIRST_CHUNK + k:03X}')
    w('')
    w(f'      aSoundScripts ; {H["Scripts"] >> 16:02X}/{H["Scripts"] & 0xFFFF:04X}')
    w('')
    w('        ; Indexed by request - 1.')
    for i, t in enumerate(s.scripts):
        w(f'        .word <>{script_label(t)} ; {i + 1}')
    w('')
    for a, items in s.script_lists.items():
        w(f'      {script_label(a)}')
        for word, arg in items:
            cmd, wait = word >> 10, word & 0x3FF
            if arg is None:
                w(f'        .word ${word:04X}')
            elif 7 <= cmd <= 14:
                w(f'        .word ${word:04X}, <>{upload_label(s.bank << 16 | arg)}')
            else:
                w(f'        .word ${word:04X}, ${arg:04X}')
        w('        .word $0000')
        w('')
    w(f'      aSoundUploadLists ; {H["UploadLists"] >> 16:02X}/{H["UploadLists"] & 0xFFFF:04X}')
    w('')
    for i, t in enumerate(s.upload_table):
        w(f'        .word ' + (f'<>{upload_label(t)}' if t else '0') + f' ; ${i:02X}')
    w('')
    w(f'      aSoundTerrainUploads ; {H["TerrainUploads"] >> 16:02X}/{H["TerrainUploads"] & 0xFFFF:04X}')
    w('')
    for t in s.terrain_table:
        w(f'        .word ' + (f'<>{upload_label(t)}' if t else '0'))
    w('')
    for a, items in s.upload_lists.items():
        w(f'      {upload_label(a)}')
        words = []
        for word, arg in items:
            words.append(f'${word:04X}')
            if arg is not None:
                words.append(f'${arg:04X}')
        words.append('$0000')
        for i in range(0, len(words), 8):
            w('        .word ' + ', '.join(words[i:i + 8]))
        w('')
    text = s.driver_id.rstrip(b'\0')
    assert all(0x20 <= c < 0x7F for c in text)
    w(f'      aSoundDriverID ; {H["DriverID"] >> 16:02X}/{H["DriverID"] & 0xFFFF:04X}')
    w(f'        .text "{text.decode()}"' + ', 0' * (len(s.driver_id) - len(text)))
    w('')
    w(f'      aSoundUnknownF7AD9C ; {H["Unknown12"] >> 16:02X}/{H["Unknown12"] & 0xFFFF:04X}')
    w('')
    w('        ; Read by rsUnknown8093C6: from +0 for upload IDs 1 and 2, from +$140 for 3 and 4.')
    for i in range(0, len(s.unknown12), 16):
        w('        .byte ' + ', '.join(f'${c:02X}' for c in s.unknown12[i:i + 16]))
    w('')
    w(f'      aSoundStartUpload ; {H["StartUpload"] >> 16:02X}/{H["StartUpload"] & 0xFFFF:04X}')
    w(f'        .word <>{upload_label(s.start_upload)}')
    w('')
    # Chunks, the driver and the bytes nothing points at, in address order.
    order = sorted([(a, 'chunk', a) for a in chunk_name] + [(H['Driver'], 'driver', None)] +
                   [(g[0], 'gap', g) for g in gaps])
    for a, kind, x in order:
        if kind == 'chunk':
            label, path = chunk_name[a]
            w(f'      {label} .soundBinary "{path}" ; {a >> 16:02X}/{a & 0xFFFF:04X}')
        elif kind == 'gap':
            g0, g1 = x
            w(f'      aSoundUnknown{g0:06X} ; {g0 >> 16:02X}/{g0 & 0xFFFF:04X}, nothing points here')
            w('        .byte ' + ', '.join(f'${c:02X}' for c in s.bytes(g0, g1 - g0)))
        else:
            w('')
            w(f'      aSoundDriver ; {a >> 16:02X}/{a & 0xFFFF:04X}')
            w('')
            w('        ; SPC700 code and data in blocks of (size, SPC address, bytes), then 0 and the')
            w('        ; address to start at, as rlUnknown809124 sends them.')
            for dest, data in s.driver:
                path = f'driver/{dest:04X}.bin'
                files[path] = data
                w(f'        .word len(binary("{path}")), ${dest:04X}')
                w(f'        .soundBinary "{path}"')
            w(f'        .word 0, ${s.driver_start:04X}')
            w('')
    w('')
    w(f'      ; ${tail[0]:06X} to the end of the ROM: free')
    w('')
    w('    .endsection SoundDataSection')
    return L, files


MACROS = '''  ; A chunk table entry: where the chunk is (address, then its bank relative to
  ; aSoundHeader's), its size (decompressed, if compressed), the SPC address
  ; to upload it to (0: after the previous chunk) and the flags.
  soundChunk .macro Data, Size, Dest, Flags
    .word <>\\Data
    .byte (`\\Data) - (`aSoundHeader)
    .word \\Size, \\Dest
    .byte \\Flags
  .endmacro

  ; A file in the sound data, which the sound code reads straight across bank
  ; boundaries. A file that reaches one is written in two parts with the
  ; program counter set again in between; that only quiets 64tass's warning
  ; about the program counter crossing a bank. It still warns once at the
  ; .dsection and once at the .here in build.asm, since the block as a whole
  ; spans banks $F7-$FF, which is what the sound code expects.
  soundBinary .macro File
    _Data := binary(\\File)
    _Room := $10000 - (* & $FFFF)
    .if len(_Data) > _Room
      .text _Data[:_Room]
      * := *
      .text _Data[_Room:]
    .else
      .text _Data
    .endif
    .if (* & $FFFF) == 0
      * := *
    .endif
  .endmacro
'''


HEAD = '''; The sound data: everything the sound loader reads, from aSoundHeader to the
; end of the ROM. Written by tools/sound.py, which describes the formats; the
; flags are in include/Sound.h. Chunks and the SPC driver are files in audio/.
; The macros are here, not in include/, because 64tass opens a file named in
; a macro relative to the file that defines the macro.

''' + MACROS + '\n'


def place(write):
    """Put the section in build.asm in place of the old placement of $F7/7C00."""
    path = os.path.join(ROOT, 'build.asm')
    b = open(path, encoding='utf-8').read()
    new = ('    * = $377C00\n    .logical $F77C00\n\n      .dsection SoundDataSection\n\n'
           '    .here\n\n    ; The rest of the last bank is free.\n    .fill $400000 - *, 0\n')
    old = re.search(r'    \* = \$377C00\n    \.logical \$F77C00\n\n(      \.dsection \w+\n)+\n    \.here\n'
                    r'(\n    ; The rest of the last bank is free\.\n    \.fill \$400000 - \*, 0\n)*', b)
    if old:
        b = b[:old.start()] + new + b[old.end():]
    elif new not in b:
        raise SystemExit('build.asm: the placement at $F77C00 is not where it was expected')
    inc = '  .include "audio/sound_data.asm"'
    if inc not in b:
        lines = b.split('\n')
        k = max(i for i, l in enumerate(lines) if l.startswith('  .include "'))
        lines[k + 1:k + 1] = [inc]
        b = '\n'.join(lines)
    if write:
        open(path, 'w', encoding='utf-8').write(b)


def labels(path):
    lab = {}
    for line in open(path):
        q = line.split()
        if len(q) == 3 and ':' not in q[2]:
            lab.setdefault(q[2].lstrip('.'), int(q[1], 16))
    return lab


def self_test():
    orig = Sound(open(os.path.join(ROOT, 'fe4.sfc'), 'rb').read())
    tmp = tempfile.mkdtemp(prefix='sound_')
    try:
        src = os.path.join(tmp, 'src')
        subprocess.run(['rsync', '-a', '--exclude', '.git', '--exclude', '*.smc', '--exclude', '*.sfc',
                        './', src + '/'], cwd=ROOT, check=True)
        shutil.copy(os.path.join(ROOT, 'fe4.sfc'), os.path.join(src, 'fe4.sfc'))
        raw = [k for k, c in enumerate(orig.chunks) if not c[4] & 1 and c[2] > 16
               and os.path.exists(os.path.join(src, f'audio/chunks/{FIRST_CHUNK + k:03X}.bin'))]
        k = raw[len(raw) // 2]
        p = os.path.join(src, f'audio/chunks/{FIRST_CHUNK + k:03X}.bin')
        open(p, 'ab').write(bytes(range(16)))
        r = subprocess.run(['./build.sh'], cwd=src, capture_output=True, text=True)
        built = os.path.join(src, 'FE4Disassembly.sfc')
        if not os.path.exists(built):
            print(r.stdout[-2000:], r.stderr[-2000:])
            raise SystemExit('self-test: the edited copy did not build')
        lab = labels(os.path.join(src, 'labels.txt'))
        new = Sound(open(built, 'rb').read(), lab['aSoundHeader'])
        if new.problems:
            print('\n'.join(new.problems))
        a, b = orig.content(), new.content()
        diffs = [key for key in a if key != 'chunks' and a[key] != b[key]]
        changed = [j for j, (x, y) in enumerate(zip(a['chunks'], b['chunks'])) if x != y]
        moved = sum(1 for x, y in zip(orig.chunks, new.chunks) if x[0] != y[0])
        shared = [j for j, c in enumerate(orig.chunks) if c[0] == orig.chunks[k][0]]
        size, dest, flags, data = a['chunks'][k]
        expect = (size + 16, dest, flags, data + bytes(range(16)))
        ok = (not new.problems and not diffs and changed == shared and moved > 0
              and all(b['chunks'][j] == expect for j in shared))
        print(f'self-test: lengthened chunk ${FIRST_CHUNK + k:03X} by 16 bytes; {moved} chunks moved; '
              f'chunks that differ: {", ".join(f"${FIRST_CHUNK + j:03X}" for j in changed) or "none"}; '
              f'other differences: {", ".join(diffs) or "none"}')
        print('self-test passed' if ok else 'self-test FAILED')
        return ok
    finally:
        shutil.rmtree(tmp, ignore_errors=True)


def main():
    ap = argparse.ArgumentParser(description=__doc__.split('\n')[0])
    ap.add_argument('--write', action='store_true')
    ap.add_argument('--self-test', action='store_true')
    args = ap.parse_args()
    if args.self_test:
        sys.exit(0 if self_test() else 1)
    s = Sound(open(os.path.join(ROOT, 'fe4.sfc'), 'rb').read())
    problems, gaps, tail = check(s)
    ncomp = sum(1 for c in s.chunks if c[4] & 1)
    print(f'{len(s.chunks)} chunk IDs ({ncomp} compressed), {len(set(c[0] for c in s.chunks))} distinct chunks; '
          f'{len(s.scripts)} scripts in the table, {len(s.script_lists)} script lists, '
          f'{len(s.upload_lists)} upload lists; driver: {len(s.driver)} blocks')
    print(f'unreferenced bytes: {sum(b - a for a, b in gaps)} in {len(gaps)} runs; '
          f'free at the end: {tail[1] - tail[0]} bytes from ${tail[0]:06X}')
    for p in problems:
        print('problem:', p)
    if problems:
        sys.exit(1)
    lines, files = emit(s, gaps, tail)
    text = HEAD + '\n'.join(lines) + '\n'
    path = os.path.join(ROOT, 'audio/sound_data.asm')
    old = open(path).read() if os.path.exists(path) else None
    print(f'audio/sound_data.asm: {len(lines):,} lines' + (' (unchanged)' if old == text else '') +
          f'; {len(files)} files, {sum(len(v) for v in files.values()):,} bytes')
    place(args.write)
    if args.write:
        for p, data in files.items():
            full = os.path.join(ROOT, 'audio', p)
            os.makedirs(os.path.dirname(full), exist_ok=True)
            if not os.path.exists(full) or open(full, 'rb').read() != data:
                open(full, 'wb').write(data)
        open(path, 'w').write(text)
        sys.exit(subprocess.call(['./build.sh'], cwd=ROOT))


if __name__ == '__main__':
    main()
