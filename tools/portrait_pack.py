#!/usr/bin/env python3
"""Author-facing 80x64 portrait PNGs (face + mouth frames) to/from 4bpp.

usage: tools/portrait_pack.py unpack IN OUT [--palette FILE|ADDR|grey]
       tools/portrait_pack.py pack IN.png OUT.4bpp
       tools/portrait_pack.py build
       tools/portrait_pack.py --self-test

Each portrait graphic is $800 bytes (64 4bpp tiles, stored as 4 rows of 16).
The authored PNG (gfx/portraits/NAME.png) is 80x64 indexed (mode 'P', 16-colour
palette for viewing only; pixel indices 0-15 are what get packed):

- Left 48x64 (x = 0..47): the assembled 6x8-tile face
  - y = 0..31:  columns 0..5 of storage order (tiles $00..$05, $10..$15, ...)
  - y = 32..63: columns 6..11 of storage order (tiles $06..$0B, $16..$1B, ...)
- Bottom-right 32x32 (x = 48..79, y = 32..63): columns 12..15 of storage order,
  which are the two 32x16 (4x2-tile) mouth animation frames replacing
  (0, 32)..(31, 47) on the face:
  - y = 32..47: Mouth Frame 1 (rows 0..1, cols 12..15)
  - y = 48..63: Mouth Frame 2 (rows 2..3, cols 12..15)
- Top-right 32x32 (x = 48..79, y = 0..31): unused; must be colour index 0.

build packs every gfx/portraits/NAME.png newer than NAME.4bpp before gfx.py lz
compresses it; ./build.sh runs build.
"""
import argparse
import glob
import os
import sys
import tempfile

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from decompress import decompress
import gfx

try:
    from PIL import Image
except ImportError:
    sys.exit('tools/portrait_pack.py needs Pillow: pip3 install pillow')

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
PORTRAIT_DIR = os.path.join(ROOT, 'gfx', 'portraits')
PORTRAIT_BYTES = 0x800
WIDTH = 80
HEIGHT = 64


def tile_origin(t):
    """Top-left pixel (x, y) in the 80x64 authored PNG for storage tile t (0..63)."""
    row, col = divmod(t, 16)
    if col < 6:
        return col * 8, row * 8
    if col < 12:
        return (col - 6) * 8, 32 + row * 8
    return 48 + (col - 12) * 8, 32 + row * 8


def bpp_to_portrait(data, colours):
    """Decode $800 bytes of 4bpp portrait tiles into an 80x64 indexed Image."""
    if len(data) != PORTRAIT_BYTES:
        raise ValueError(f'expected {PORTRAIT_BYTES} bytes, got {len(data)}')
    img = Image.new('P', (WIDTH, HEIGHT), 0)
    flat = [v for c in colours[:16] for v in c]
    img.putpalette(flat + [0] * (768 - len(flat)))
    px = img.load()
    for t in range(64):
        b = data[t * 32:t * 32 + 32]
        ox, oy = tile_origin(t)
        for y in range(8):
            p = (b[2 * y], b[2 * y + 1], b[16 + 2 * y], b[17 + 2 * y])
            for x in range(8):
                s = 7 - x
                px[ox + x, oy + y] = sum((p[k] >> s & 1) << k for k in range(4))
    return img


def portrait_to_bpp(path):
    """Encode an 80x64 indexed portrait PNG into $800 bytes of 4bpp tiles."""
    img = Image.open(path)
    if img.mode != 'P':
        raise ValueError(f'{path}: not an indexed PNG (mode {img.mode}); save it with a palette')
    if img.size != (WIDTH, HEIGHT):
        raise ValueError(f'{path}: expected {WIDTH}x{HEIGHT}, got {img.size[0]}x{img.size[1]}')
    px = img.load()
    for y in range(32):
        for x in range(48, WIDTH):
            if px[x, y] != 0:
                raise ValueError(f'{path}: unused top-right pixel ({x}, {y}) must be colour 0, got {px[x, y]}')
    out = bytearray()
    for t in range(64):
        ox, oy = tile_origin(t)
        planes = bytearray(32)
        for y in range(8):
            for x in range(8):
                c = px[ox + x, oy + y]
                if not 0 <= c < 16:
                    raise ValueError(f'{path}: pixel ({ox + x}, {oy + y}) uses colour {c}; 4bpp supports 0-15')
                bit = 7 - x
                for k in range(4):
                    planes[16 * (k // 2) + 2 * y + k % 2] |= (c >> k & 1) << bit
        out += planes
    return bytes(out)


def unpack_file(src, out, palette_spec=None):
    """Unpack a .4bpp.png, .4bpp.comp, or .4bpp portrait into an 80x64 PNG."""
    if src.endswith('.4bpp.png'):
        data = gfx.png_to_4bpp(src)
        if palette_spec:
            colours = gfx.read_palette(palette_spec, 4)
        else:
            pal = Image.open(src).getpalette() or [0] * 48
            colours = [tuple(pal[i:i + 3]) for i in range(0, 48, 3)]
    elif src.endswith('.comp'):
        with open(src, 'rb') as f:
            orig = f.read()
        buf = bytearray(0x400000)
        buf[:len(orig)] = orig
        data = decompress(bytes(buf), 0xC00000)[0]
        colours = gfx.read_palette(palette_spec or 'grey', 4)
    else:
        with open(src, 'rb') as f:
            data = f.read()
        colours = gfx.read_palette(palette_spec or 'grey', 4)
    bpp_to_portrait(data, colours).save(out)


def pack_file(src, out):
    """Pack an 80x64 portrait PNG into .4bpp bytes after full validation."""
    data = portrait_to_bpp(src)
    with open(out, 'wb') as f:
        f.write(data)
    return data


def build():
    """Pack every gfx/portraits/NAME.png newer than NAME.4bpp."""
    n = 0
    for src in sorted(glob.glob(os.path.join(PORTRAIT_DIR, '*.png'))):
        if src.endswith(('.4bpp.png', '.2bpp.png')):
            continue
        out = src[:-4] + '.4bpp'
        if not os.path.exists(out) or os.path.getmtime(src) > os.path.getmtime(out):
            try:
                pack_file(src, out)
            except ValueError as e:
                sys.exit(str(e))
            n += 1
    return n


def self_test():
    """Round-trip all 152 portraits, test edits + LZ recompression, and check validation."""
    comps = sorted(glob.glob(os.path.join(PORTRAIT_DIR, '*.4bpp.comp')))
    assert len(comps) == 152, f'expected 152 portrait streams, found {len(comps)}'
    committed = 0
    with tempfile.TemporaryDirectory() as tmp:
        for c in comps:
            name = os.path.basename(c)[:-len('.4bpp.comp')]
            with open(c, 'rb') as f:
                orig = f.read()
            buf = bytearray(0x400000)
            buf[:len(orig)] = orig
            raw = decompress(bytes(buf), 0xC00000)[0]
            assert len(raw) == PORTRAIT_BYTES, f'{name}: expected ${PORTRAIT_BYTES:X} bytes, got {len(raw):#x}'

            tmp_png = os.path.join(tmp, name + '.png')
            bpp_to_portrait(raw, gfx.grey(4)).save(tmp_png)
            assert portrait_to_bpp(tmp_png) == raw, f'{name}: unpack/pack differs'

            committed_png = os.path.join(PORTRAIT_DIR, name + '.png')
            assert os.path.exists(committed_png), f'{name}: missing committed {committed_png}'
            assert portrait_to_bpp(committed_png) == raw, f'{name}: committed PNG differs from .comp'
            committed += 1

        # Edit 1 pixel in each of the 4 regions of Sigurd.png and verify tile mapping + LZ.
        sigurd_comp = os.path.join(PORTRAIT_DIR, 'Sigurd.4bpp.comp')
        sigurd_png = os.path.join(PORTRAIT_DIR, 'Sigurd.png')
        orig_raw = portrait_to_bpp(sigurd_png)
        img = Image.open(sigurd_png).copy()
        px = img.load()
        for x, y in ((0, 0), (0, 32), (48, 32), (48, 48)):
            px[x, y] = (px[x, y] + 1) % 16
        edited_png = os.path.join(tmp, 'Sigurd_edit.png')
        img.save(edited_png)
        edited_raw = portrait_to_bpp(edited_png)
        changed_tiles = {t for t in range(64)
                         if edited_raw[t * 32:(t + 1) * 32] != orig_raw[t * 32:(t + 1) * 32]}
        assert changed_tiles == {0x00, 0x06, 0x0C, 0x2C}, f'unexpected changed tiles: {changed_tiles}'

        lz_stream = gfx.lz(edited_raw, sigurd_comp)
        with open(sigurd_comp, 'rb') as f:
            assert lz_stream != f.read(), 'edited stream unexpectedly matched original .comp'
        buf = bytearray(0x400000)
        buf[:len(lz_stream)] = lz_stream
        assert decompress(bytes(buf), 0xC00000)[0] == edited_raw, 'recompressed stream failed to decompress'

        # Negative validation checks.
        rgb_path = os.path.join(tmp, 'rgb.png')
        Image.new('RGB', (WIDTH, HEIGHT), (0, 0, 0)).save(rgb_path)
        for bad_path, desc in (
            (rgb_path, 'RGB mode'),
            (os.path.join(tmp, 'w128.png'), '128x32 size'),
            (os.path.join(tmp, 'w48.png'), '48x64 size'),
        ):
            if not os.path.exists(bad_path):
                size = (128, 32) if '128' in bad_path else (48, 64)
                Image.new('P', size, 0).save(bad_path)
            try:
                portrait_to_bpp(bad_path)
            except ValueError:
                pass
            else:
                raise AssertionError(f'{desc} should fail')

        c16_path = os.path.join(tmp, 'c16.png')
        im16 = Image.new('P', (WIDTH, HEIGHT), 0)
        im16.putpalette([0] * 768)
        im16.putpixel((0, 0), 16)
        im16.save(c16_path)
        try:
            portrait_to_bpp(c16_path)
        except ValueError:
            pass
        else:
            raise AssertionError('colour index 16 should fail')

        unused_path = os.path.join(tmp, 'unused.png')
        unused_out = os.path.join(tmp, 'unused.4bpp')
        im_u = Image.new('P', (WIDTH, HEIGHT), 0)
        im_u.putpixel((48, 0), 1)
        im_u.save(unused_path)
        try:
            pack_file(unused_path, unused_out)
        except ValueError:
            pass
        else:
            raise AssertionError('non-zero top-right pixel should fail')
        assert not os.path.exists(unused_out), 'failed pack_file left output behind'

    print(f'152 of 152 portraits unpack and pack byte-identical ({committed} committed PNGs checked); '
          f'tile edit + LZ recompression and validation checks passed')


def main():
    ap = argparse.ArgumentParser(description=__doc__.split('\n')[0])
    ap.add_argument('--self-test', action='store_true')
    sub = ap.add_subparsers(dest='cmd')
    p = sub.add_parser('unpack')
    p.add_argument('src')
    p.add_argument('out')
    p.add_argument('--palette', help='palette file, CPU address, or grey')
    p = sub.add_parser('pack')
    p.add_argument('src')
    p.add_argument('out')
    sub.add_parser('build')
    args = ap.parse_args()

    if args.self_test:
        self_test()
    elif args.cmd == 'unpack':
        unpack_file(args.src, args.out, args.palette)
    elif args.cmd == 'pack':
        try:
            pack_file(args.src, args.out)
        except ValueError as e:
            sys.exit(str(e))
    elif args.cmd == 'build':
        build()
    else:
        ap.print_help()


if __name__ == '__main__':
    main()
