#!/usr/bin/env python3
"""Turn carved compressed streams into editable files.

usage: tools/unpack_streams.py LIST [--write]

LIST has one stream per line (# starts a comment):

    LABEL 4bpp PALETTE [WIDTH]    4bpp tiles: NAME.4bpp.png, WIDTH tiles across (16)
    LABEL 2bpp PALETTE [WIDTH]    2bpp tiles: NAME.2bpp.png, WIDTH tiles across (16)
    LABEL bin                     other data (a tilemap, a compressed palette):
                                  NAME.bin, the decompressed bytes
    LABEL colours PALETTE         an unpacked NAME.4bpp.png or NAME.2bpp.png:
                                  give it other colours (only its palette
                                  changes; the tool checks the pixels convert to
                                  the same bytes)

LABEL is a stream listed in a gfx/**/*.streams file as `LABEL LABEL`.
PALETTE gives the PNG its 16 colours, for viewing only (pixels are colour
numbers, so the colours do not change the bytes): a CPU address (8CA400), a
label plus a byte offset (aWindowPalette+64), stream:LABEL+N for colours inside
another stream's decompressed bytes, or grey. A PALETTE ending in @1 gives the
colours from colour 1 on (sprite palettes the game copies from colour 1), with
colour 0, which is transparent, drawn black.

For each stream the tool writes the file, renames NAME.comp to NAME.4bpp.comp,
NAME.2bpp.comp or NAME.bin.comp (git mv), and checks that the file converts
back to exactly the decompressed bytes (for a PNG, after the blank tiles that
fill its last row are dropped, as tools/gfx.py lz does). The build then
rebuilds each stream from the file, through the original while it is unchanged.
Without --write it only checks; with it, it writes and builds.
"""
import argparse
import glob
import os
import re
import subprocess
import sys
import tempfile

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from decompress import decompress, rom_offset
from gfx import bpp_to_png, png_to_bpp, bgr555, grey

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
GREY = [(i * 17,) * 3 for i in range(16)]


def stream_data(path):
    comp = open(path, 'rb').read()
    buf = bytearray(0x400000)
    buf[:len(comp)] = comp
    return decompress(bytes(buf), 0xC00000)[0]


def main():
    ap = argparse.ArgumentParser(description=__doc__.split('\n')[0],
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument('list')
    ap.add_argument('--write', action='store_true')
    args = ap.parse_args()
    rom = open(os.path.join(ROOT, 'fe4.sfc'), 'rb').read()
    labels = {}
    for line in open(os.path.join(ROOT, 'labels.txt')):
        p = line.split()
        if len(p) == 3 and ':' not in p[2]:
            labels.setdefault(p[2].lstrip('.'), int(p[1], 16))
    folder_of = {}
    for path in glob.glob(os.path.join(ROOT, 'gfx', '**', '*.streams'), recursive=True):
        for line in open(path):
            if m := re.match(r'(\w+) (\w+)\b', line):
                if m.group(1) == m.group(2):
                    folder_of[m.group(1)] = os.path.dirname(path)

    def colours(spec, depth=4):
        if spec == 'grey':
            return grey(depth)
        if spec.endswith('@1'):                     # colours from colour 1; 0 (transparent) black
            return ([(0, 0, 0)] + colours(spec[:-2], 4)[:15])[:1 << depth]
        if m := re.fullmatch(r'stream:(\w+)(?:\+(\d+))?', spec):
            data = stream_data(comp_path(m.group(1)))
            k = int(m.group(2) or 0)
            return bgr555(data[k:k + 32])[:1 << depth]
        if m := re.fullmatch(r'([A-Za-z]\w*)(?:([+-])(\d+))?', spec):
            a = labels[m.group(1)] + (int(m.group(3)) * (-1 if m.group(2) == '-' else 1) if m.group(3) else 0)
        else:
            a = int(spec.lstrip('$'), 16)
        o = rom_offset(a)
        if o is None:                               # a lower bank half: its $C0-$FF mirror
            o = rom_offset(a | 0x400000)
        return bgr555(rom[o:o + 32])[:1 << depth]

    def comp_path(label):
        folder = folder_of.get(label)
        if not folder:
            sys.exit(f'{label}: not a stream in any .streams file')
        for ext in ('.comp', '.4bpp.comp', '.2bpp.comp', '.bin.comp'):
            if os.path.exists(os.path.join(folder, label + ext)):
                return os.path.join(folder, label + ext)
        sys.exit(f'{label}: no .comp file in {folder}')

    jobs = []
    for n, line in enumerate(open(args.list, encoding='utf-8'), 1):
        f = line.split('#', 1)[0].split()
        if not f:
            continue
        if f[1] == 'colours' and len(f) == 3:
            folder = folder_of.get(f[0], '')
            png = next((p for p in (os.path.join(folder, f[0] + '.4bpp.png'),
                                    os.path.join(folder, f[0] + '.2bpp.png'))
                        if os.path.exists(p)), None)
            if not png:
                sys.exit(f'{f[0]}: no {f[0]}.4bpp.png or {f[0]}.2bpp.png to recolour')
            jobs.append((f[0], 'colours', f[2], 0, png))
            continue
        if f[1] not in ('4bpp', '2bpp', 'bin') or (f[1] in ('4bpp', '2bpp')) != (len(f) in (3, 4)) or (f[1] == 'bin' and len(f) != 2):
            sys.exit(f'{args.list}:{n}: expected LABEL 4bpp|2bpp PALETTE [WIDTH], LABEL bin or LABEL colours PALETTE')
        path = comp_path(f[0])
        if not path.endswith(os.sep + f[0] + '.comp'):
            sys.exit(f'{f[0]}: already unpacked ({os.path.relpath(path, ROOT)})')
        jobs.append((f[0], f[1], f[2] if len(f) > 2 else None, int(f[3]) if len(f) > 3 else 16, path))

    bad = 0
    with tempfile.TemporaryDirectory() as tmp:
        for label, kind, pal, width, path in jobs:
            if kind == 'colours':
                from PIL import Image
                depth = 2 if path.endswith('.2bpp.png') else 4
                before = png_to_bpp(path, depth)
                img = Image.open(path)
                pal_list = colours(pal, depth)
                img.putpalette([v for c in pal_list for v in c] + [0] * (768 - 3 * len(pal_list)))
                out = os.path.join(tmp, label + '.png')
                img.save(out)
                if png_to_bpp(out, depth) != before:
                    print(f'{label}: recolouring changed the pixels'); bad += 1; continue
                if args.write:
                    img.save(path)
                continue
            data = stream_data(path)
            folder = os.path.dirname(path)
            if kind in ('4bpp', '2bpp'):
                depth = 2 if kind == '2bpp' else 4
                tile_size = 8 * depth
                if len(data) % tile_size:
                    print(f'{label}: {len(data)} bytes is not whole {kind} tiles'); bad += 1; continue
                img = bpp_to_png(data, colours(pal, depth), width, depth)
                out = os.path.join(tmp if not args.write else folder, f'{label}.{kind}.png')
                img.save(out)
                back = png_to_bpp(out, depth)
                if back[:len(data)] != data or any(back[len(data):]):
                    print(f'{label}: the PNG does not convert back'); bad += 1; continue
            else:
                out = os.path.join(tmp if not args.write else folder, label + '.bin')
                open(out, 'wb').write(data)
            if args.write:
                dst = os.path.join(folder, f'{label}.{kind}.comp')
                if subprocess.run(['git', 'ls-files', '--error-unmatch', path], cwd=ROOT,
                                  capture_output=True).returncode == 0:
                    subprocess.run(['git', 'mv', path, dst], cwd=ROOT, check=True)
                else:
                    os.rename(path, dst)
    print(f'{len(jobs) - bad} of {len(jobs)} streams ' + ('unpacked' if args.write else 'convert and convert back'))
    if bad:
        sys.exit(1)
    if args.write:
        sys.exit(subprocess.call(['./build.sh'], cwd=ROOT))


if __name__ == '__main__':
    main()
