#!/usr/bin/env python3
"""Write the catalog of compressed streams not identified yet.

usage: tools/stream_catalog.py

Lists every stream in gfx/compressed/*/*.streams still named gcUnknownADDR in
gfx/compressed/CATALOG.md, with what is known about it, and draws a preview of
each in gfx/compressed/catalog/. Run it again after identifying streams.

For each stream: its region, its size compressed and decompressed, and every
place in the source that names it, with the routine or table it is in. A
reference from a .structDecompressionDMAEntry also gives the entry's VRAM
destination and byte count, and the places that name the entry. The preview
draws the decompressed bytes as 4bpp tiles, 16 across, in grey: only a first
look, since a stream may be 2bpp, a tilemap or other data.
"""
import glob
import os
import re
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from decompress import decompress
from gfx import bpp_to_png

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
OUT = os.path.join(ROOT, 'gfx', 'compressed')
GREY = [(i * 17, i * 17, i * 17) for i in range(16)]


def source_files():
    return (glob.glob(os.path.join(ROOT, 'engine', '**', '*.asm'), recursive=True)
            + glob.glob(os.path.join(ROOT, 'events', '**', '*.asm'), recursive=True)
            + [os.path.join(ROOT, 'build.asm')])


def references(names):
    """{name: [(file, line, enclosing label, text)]} for each of names in the source."""
    pat = re.compile(r'\b(' + '|'.join(map(re.escape, names)) + r')\b')
    refs = {n: [] for n in names}
    for f in source_files():
        owner = None
        for k, line in enumerate(open(f, encoding='utf-8'), 1):
            if m := re.match(r'\s{4,6}([a-z]\w+)(?:\s*;|\s+\.|\s*$)', line):
                owner = m.group(1)
            code = line.split(';')[0]
            for m in pat.finditer(code):
                if re.match(rf'\s*{m.group(1)}\b', code):
                    continue                          # the definition itself
                if any(r[2] == owner and r[0] == os.path.relpath(f, ROOT) for r in refs[m.group(1)]):
                    continue                          # one per routine (two-halves loads)
                refs[m.group(1)].append((os.path.relpath(f, ROOT), k, owner, code.strip()))
    return refs


def main():
    streams = []                                  # (region, name, path)
    for path in sorted(glob.glob(os.path.join(OUT, '*', '*.streams'))):
        region = os.path.basename(os.path.dirname(path))
        for line in open(path):
            if m := re.match(r'(gcUnknown\w+) (\w+)', line):
                streams.append((region, m.group(1), os.path.join(os.path.dirname(path), m.group(2) + '.comp')))
    refs = references([n for _, n, _ in streams])
    entries = {}                                  # entry label -> (stream, count, vram)
    entry_refs = {}
    for f in source_files():
        for line in open(f, encoding='utf-8'):
            m = re.match(r'\s*(\w+)?\s*\.structDecompressionDMAEntry\s+(\w+),\s*(\$\w+),\s*(\$\w+)', line)
            if m and m.group(1):
                entries[m.group(1)] = (m.group(2), m.group(3), m.group(4))
    # Entries written on the line after their label (in engine files).
    for f in source_files():
        last = None
        for line in open(f, encoding='utf-8'):
            if m := re.match(r'\s{6}(a\w+) ;', line):
                last = m.group(1)
            m = re.match(r'\s*\.structDecompressionDMAEntry\s+(\w+),\s*(\$\w+),\s*(\$\w+)', line)
            if m and last and last not in entries:
                entries[last] = (m.group(1), m.group(2), m.group(3))
    if entries:
        entry_refs = references(list(entries))

    os.makedirs(os.path.join(OUT, 'catalog'), exist_ok=True)
    for old in glob.glob(os.path.join(OUT, 'catalog', '*.png')):
        os.remove(old)
    lines = ['# Unidentified compressed streams', '',
             'Made by `tools/stream_catalog.py`; do not edit. These streams are carved',
             '(labelled, and placed by the build) but not identified: each is still the',
             "ROM's bytes, `gcUnknownADDR.comp`. When the code that uses one is read, give it",
             'a real name and format (a PNG if it is graphics) and run the tool again.', '',
             'Previews draw the decompressed bytes as 4bpp tiles, 16 across, in grey. That',
             'is only a first look: a stream may be 2bpp graphics, a tilemap, or other data.', '',
             f'{len(streams)} streams.', '']
    region = None
    for reg, name, path in streams:
        if reg != region:
            region = reg
            lines += [f'## Region ${reg}', '']
        comp = open(path, 'rb').read()
        buf = bytearray(0x400000)
        buf[:len(comp)] = comp
        data, _ = decompress(bytes(buf), 0xC00000)
        whole = data[:len(data) // 32 * 32]
        if whole:
            bpp_to_png(whole, GREY, 16).save(os.path.join(OUT, 'catalog', name + '.png'))
        lines.append(f'### {name}')
        lines.append('')
        lines.append(f'{len(comp)} bytes compressed, {len(data)} decompressed'
                     + ('' if len(data) % 32 == 0 else ' (not a whole number of 32-byte tiles)') + '.')
        used = refs.get(name, [])
        if not used:
            lines.append('Nothing in the source names it (found between other streams).')
        for f, k, owner, text in used:
            if owner in entries:
                _, count, vram = entries[owner]
                by = ', '.join(f'`{o}` ({ff}:{kk})' for ff, kk, o, _ in entry_refs.get(owner, [])) or 'nothing named'
                lines.append(f'- Entry `{owner}` ({f}:{k}): {count} bytes to VRAM {vram}; used by {by}.')
            else:
                lines.append(f'- `{owner}` ({f}:{k}): `{text}`')
        if whole:
            lines += ['', f'![{name}](catalog/{name}.png)']
        lines.append('')
    open(os.path.join(OUT, 'CATALOG.md'), 'w', encoding='utf-8').write('\n'.join(lines))
    print(f'Wrote gfx/compressed/CATALOG.md: {len(streams)} streams')


if __name__ == '__main__':
    main()
