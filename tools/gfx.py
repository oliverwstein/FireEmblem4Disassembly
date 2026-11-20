#!/usr/bin/env python3
"""Convert SNES 4bpp tile graphics to and from indexed PNG.

usage: tools/gfx.py png2bpp IN.4bpp.png OUT.4bpp
       tools/gfx.py lz IN.4bpp ORIGINAL.4bpp.comp OUT.4bpp.lz
       tools/gfx.py bpp2png IN.4bpp OUT.4bpp.png --palette FILE|ADDR [--width TILES]
       tools/gfx.py --self-test

png2bpp is what ./build.sh runs for every gfx/**/NAME.4bpp.png, writing
NAME.4bpp next to it. The PNG must be indexed (palette mode) with at most 16
colours: each pixel's palette index is its colour number in the tile, so the
conversion does not depend on the colours themselves. Its width and height must
be multiples of 8; tiles are read left to right, top to bottom, which is how
the game stores a sheet that is that many tiles wide.

lz compresses IN for rlDecompressor. If ORIGINAL (the stream as the ROM has
it, committed next to the PNG or .bin) still decompresses to exactly IN, it is
copied unchanged, so an unedited graphic builds byte-identical; otherwise IN is
compressed with tools/compress.py, which gives the same data in different
(usually fewer) bytes. Zero bytes past ORIGINAL's decompressed length (the
blank tiles that fill out a PNG's last row) are dropped first. ./build.sh runs
it for every NAME.4bpp.png that has a NAME.4bpp.comp beside it, and every
NAME.bin (decompressed data such as a tilemap) that has a NAME.bin.comp.

bpp2png writes such a PNG from 4bpp bytes, --width tiles across (default 16),
with the 16 colours of a BGR555 palette: a file of 32 bytes, or a CPU address
in the ROM (such as DD7FB0).

Editing: keep the PNG indexed and keep each colour at its index; most editors
do when you paint with the palette's own colours. Index 0 is transparent on
sprites and the backdrop on backgrounds.
"""
import argparse
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

try:
    from PIL import Image
except ImportError:
    sys.exit('tools/gfx.py needs Pillow: pip3 install pillow')

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


def png_to_4bpp(path):
    img = Image.open(path)
    if img.mode != 'P':
        sys.exit(f'{path}: not an indexed PNG (mode {img.mode}); save it with a palette')
    w, h = img.size
    if w % 8 or h % 8:
        sys.exit(f'{path}: {w}x{h} is not a whole number of 8x8 tiles')
    px = img.load()
    out = bytearray()
    for ty in range(h // 8):
        for tx in range(w // 8):
            planes = bytearray(32)
            for y in range(8):
                for x in range(8):
                    c = px[tx * 8 + x, ty * 8 + y]
                    if c > 15:
                        sys.exit(f'{path}: pixel ({tx * 8 + x}, {ty * 8 + y}) uses colour '
                                 f'{c}; a 4bpp tile has 16 (0-15)')
                    bit = 7 - x
                    planes[2 * y] |= (c & 1) << bit
                    planes[2 * y + 1] |= (c >> 1 & 1) << bit
                    planes[16 + 2 * y] |= (c >> 2 & 1) << bit
                    planes[17 + 2 * y] |= (c >> 3 & 1) << bit
            out += planes
    return bytes(out)


def bpp_to_png(data, colours, width):
    if len(data) % 32:
        sys.exit(f'{len(data)} bytes is not a whole number of 4bpp tiles')
    n = len(data) // 32
    rows = (n + width - 1) // width
    img = Image.new('P', (width * 8, rows * 8))
    img.putpalette([v for c in colours for v in c] + [0] * (768 - 3 * len(colours)))
    px = img.load()
    for t in range(n):
        b = data[t * 32:t * 32 + 32]
        ox, oy = t % width * 8, t // width * 8
        for y in range(8):
            p = (b[2 * y], b[2 * y + 1], b[16 + 2 * y], b[17 + 2 * y])
            for x in range(8):
                s = 7 - x
                px[ox + x, oy + y] = sum((p[k] >> s & 1) << k for k in range(4))
    return img


def bgr555(raw):
    out = []
    for i in range(0, 32, 2):
        w = raw[i] | raw[i + 1] << 8
        out.append(tuple((w >> s & 31) * 255 // 31 for s in (0, 5, 10)))
    return out


def read_palette(spec):
    if os.path.exists(spec):
        return bgr555(open(spec, 'rb').read()[:32])
    from decompress import rom_offset
    rom = open(os.path.join(ROOT, 'fe4.sfc'), 'rb').read()
    o = rom_offset(int(spec.lstrip('$').replace('/', ''), 16))
    return bgr555(rom[o:o + 32])


def lz(data, original_path):
    """The stream for data: the original if it still decompresses to data, else a new one.

    A PNG holds whole rows of tiles, so a sheet whose tile count is not a multiple
    of its width comes back with blank tiles at the end. Zero bytes beyond the
    original's decompressed length are dropped first, so they neither change an
    unedited stream nor make the game decompress more than its buffer holds.
    """
    if os.path.exists(original_path):
        from decompress import decompress
        original = open(original_path, 'rb').read()
        buf = bytearray(0x400000)                      # the stream alone, at $C0/0000
        buf[:len(original)] = original
        try:
            before = decompress(bytes(buf), 0xC00000)[0]
        except Exception:
            before = None
        if before is not None:
            if len(data) > len(before) and not any(data[len(before):]):
                data = data[:len(before)]
            if before == data:
                return original
    from compress import compress
    return compress(data)


def self_test():
    """Every 4bpp PNG in gfx/ converts to bytes that round-trip through PNG."""
    import glob
    import tempfile
    pngs = sorted(glob.glob(os.path.join(ROOT, 'gfx', '**', '*.4bpp.png'), recursive=True))
    bad = 0
    for path in pngs:
        data = png_to_4bpp(path)
        width = Image.open(path).size[0] // 8
        with tempfile.NamedTemporaryFile(suffix='.png') as f:
            bpp_to_png(data, [(0, 0, 0)] * 16, width).save(f.name)
            if png_to_4bpp(f.name) != data:
                bad += 1
                print(f'FAIL {os.path.relpath(path, ROOT)}')
    print(f'{len(pngs) - bad} of {len(pngs)} PNGs round-trip')
    return 1 if bad else 0


def main():
    if sys.argv[1:] == ['--self-test']:
        return self_test()
    ap = argparse.ArgumentParser(description=__doc__.split('\n')[0])
    sub = ap.add_subparsers(dest='cmd', required=True)
    a = sub.add_parser('png2bpp')
    a.add_argument('png')
    a.add_argument('out')
    c = sub.add_parser('lz')
    c.add_argument('bpp')
    c.add_argument('original')
    c.add_argument('out')
    b = sub.add_parser('bpp2png')
    b.add_argument('bpp')
    b.add_argument('out')
    b.add_argument('--palette', required=True)
    b.add_argument('--width', type=int, default=16)
    args = ap.parse_args()
    if args.cmd == 'png2bpp':
        open(args.out, 'wb').write(png_to_4bpp(args.png))
    elif args.cmd == 'lz':
        open(args.out, 'wb').write(lz(open(args.bpp, 'rb').read(), args.original))
    else:
        bpp_to_png(open(args.bpp, 'rb').read(), read_palette(args.palette), args.width).save(args.out)


if __name__ == '__main__':
    sys.exit(main())
