#!/usr/bin/env python3
"""Turn labelled ROM slices of uncompressed tile graphics into indexed PNGs.

usage: tools/gfx_blocks.py LIST [--write]

LIST has one block per line (# starts a comment):

    LABEL NEWLABEL gfx/DIR/NAME.4bpp.png PALETTE [WIDTH]

LABEL is a slice in build.asm (`LABEL .text ROM[$A:$B]`, as tools/carve.py
--type block writes it). The depth comes from the PNG's name (`.2bpp.png` or
`.4bpp.png`). PALETTE only colours the PNG: `grey`, a CPU address, or a label
with an optional +N (colours from labels.txt). WIDTH is in tiles (default 16, or
the largest width up to 16 that divides the tile count, so the sheet has no
filler tiles that would change the build).

Each block is written as NAME.Nbpp.png, checked to convert back to exactly the
slice's bytes (tools/gfx.py png2bpp, which ./build.sh runs), and the slice
becomes `NEWLABEL .binary "gfx/DIR/NAME.Nbpp"`; LABEL is renamed to NEWLABEL
everywhere in the source. Without --write it only reports; with it, it writes
and builds.
"""
import argparse
import glob
import os
import re
import subprocess
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from decompress import rom_offset
from gfx import bpp_to_png, png_to_bpp, depth_of, read_palette, bgr555

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


def labels():
    out = {}
    for line in open(os.path.join(ROOT, 'labels.txt')):
        p = line.split()
        if len(p) == 3:
            out[p[2].lstrip('.')] = int(p[1], 16)
    return out


def colours(spec, depth, rom, names):
    if spec == 'grey' or re.fullmatch(r'\$?[0-9A-Fa-f]{6}', spec):
        return read_palette(spec, depth)
    m = re.fullmatch(r'(\w+)(?:\+\$?([0-9A-Fa-f]+))?', spec)
    if not m or m.group(1) not in names:
        sys.exit(f'palette {spec}: not grey, an address or a label')
    a = names[m.group(1)] + (int(m.group(2), 16) if m.group(2) else 0)
    o = rom_offset(a)
    return bgr555(rom[o:o + 32])[:1 << depth]


def source_files():
    return (glob.glob(os.path.join(ROOT, 'engine', '**', '*.asm'), recursive=True)
            + glob.glob(os.path.join(ROOT, 'include', '**', '*.h'), recursive=True)
            + glob.glob(os.path.join(ROOT, 'events', '*.asm'))
            + glob.glob(os.path.join(ROOT, 'data', '**', '*.asm'), recursive=True)
            + [os.path.join(ROOT, 'build.asm')])


def main():
    ap = argparse.ArgumentParser(description=__doc__.split('\n')[0])
    ap.add_argument('list')
    ap.add_argument('--write', action='store_true')
    args = ap.parse_args()
    rom = open(os.path.join(ROOT, 'fe4.sfc'), 'rb').read()
    names = labels()
    text = {f: open(f, encoding='utf-8').read() for f in source_files()}
    build = os.path.join(ROOT, 'build.asm')
    everything = '\n'.join(text.values())
    jobs = []
    for line in open(args.list, encoding='utf-8'):
        line = line.split('#')[0].split()
        if not line:
            continue
        label, new, png, pal = line[:4]
        width = int(line[4]) if len(line) > 4 else None
        m = re.search(r'^      ' + re.escape(label) + r' \.text ROM\[\$([0-9A-F]+):\$([0-9A-F]+)\] ;([^\n]*)$',
                      text[build], re.M)
        if not m:
            sys.exit(f'{label}: no slice `{label} .text ROM[...]` in build.asm')
        if re.search(r'rest of ' + re.escape(label) + r'\b', text[build]):
            sys.exit(f'{label}: the slice continues in another bank half; not handled')
        if new != label and re.search(r'\b' + re.escape(new) + r'\b', everything):
            sys.exit(f'{new} is already used')
        if not re.fullmatch(r'gfx/.+\.[24]bpp\.png', png):
            sys.exit(f'{png}: give a path gfx/.../NAME.4bpp.png or NAME.2bpp.png')
        depth = depth_of(png)
        data = rom[int(m.group(1), 16):int(m.group(2), 16)]
        tiles, rest = divmod(len(data), 8 * depth)
        if rest or not tiles:
            sys.exit(f'{label}: {len(data)} bytes is not a whole number of {depth}bpp tiles')
        if width is None:
            width = max(w for w in range(1, 17) if tiles % w == 0)
        if tiles % width:
            sys.exit(f'{label}: {tiles} tiles do not fill rows of {width}')
        jobs.append((label, new, png, depth, data, width, colours(pal, depth, rom, names), m))
        print(f'{label} -> {new}: {png}, {tiles} tiles {depth}bpp, {width} wide, palette {pal}')
    if not args.write:
        print('Dry run; --write applies it.')
        return 0
    for label, new, png, depth, data, width, cols, m in jobs:
        path = os.path.join(ROOT, png)
        os.makedirs(os.path.dirname(path), exist_ok=True)
        bpp_to_png(data, cols, width, depth).save(path)
        if png_to_bpp(path, depth) != data:
            sys.exit(f'{png}: does not convert back to the same bytes')
        text[build] = text[build].replace(
            m.group(0), f'      {label} .binary "{png[:-4]}" ;{m.group(3)}')
    renames = {j[0]: j[1] for j in jobs if j[0] != j[1]}
    pat = re.compile(r'\b(' + '|'.join(map(re.escape, renames)) + r')\b')
    for f, t in text.items():
        n = pat.sub(lambda mm: renames[mm.group(1)], t) if renames else t
        if n != open(f, encoding='utf-8').read():
            open(f, 'w', encoding='utf-8').write(n)
    print(f'Wrote {len(jobs)} PNGs. Building...')
    r = subprocess.run(['./build.sh'], cwd=ROOT, capture_output=True, text=True)
    print((r.stdout + r.stderr).strip().split('\n')[-1])
    return r.returncode


if __name__ == '__main__':
    sys.exit(main())
