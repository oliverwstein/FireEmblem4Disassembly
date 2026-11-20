#!/usr/bin/env python3
"""Export the portraits as PNG images.

usage: tools/portraits.py OUT_DIR [--ids 00,B9-F2] [--scale N] [--tiles]

For each entry of aPortraitGraphicPointers (or those given by --ids, in hex),
decompresses its graphics (tools/decompress.py), colours them with the entry's
palette from aPortraitPalettePointers, and writes OUT_DIR/PortraitXX.png, plus
OUT_DIR/sheet.png with every exported portrait and its index. --tiles also
writes PortraitXX_tiles.png, the 64 tiles as they are stored. Needs labels.txt
from ./build.sh, and Pillow.

How a portrait is stored: $800 bytes decompressed, 64 4bpp tiles, read as four
rows of 16 tiles. rsDialogueLoadPortraitWriteTilemap ($91/9739) builds the 6x8
tile face from them: the top half is columns 0-5, the bottom half columns 6-11
(the tile 6 after the one above). Columns 12-15 are not part of the face; they
are probably the mouth and eye frames. The game mirrors the face for one of the
two dialogue slots. Colour 0 is drawn as it is in the palette.

Several entries share graphics with different palettes. Entries $B9-$F2 are
generic class cards (a framed picture of the class, not a face): portrait ID
$F3 in character data means "use the class's card" (rlTryGetClassPortraitDataID
reads aClassPortraitDataIDs). Entries $73, $74, $9C, $F3 and $F4 share one
horseman card with different palettes.
"""
import argparse
import csv
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from decompress import decompress, rom_offset

try:
    from PIL import Image, ImageDraw
except ImportError:
    sys.exit('tools/portraits.py needs Pillow: pip3 install pillow')

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


def load_labels():
    labels = {}
    for line in open(os.path.join(ROOT, 'labels.txt')):
        parts = line.split()
        if len(parts) == 3:
            labels[parts[2].lstrip('.')] = int(parts[1], 16)
    return labels


def pointer_table(name, labels):
    rows = list(csv.reader(open(os.path.join(ROOT, 'data', name))))[1:]
    return [labels[v] if v in labels else int(v.lstrip('$'), 16) for _, v in rows]


def palette(rom, addr):
    o = rom_offset(addr)
    colours = []
    for i in range(16):
        w = rom[o + 2 * i] | rom[o + 2 * i + 1] << 8      # BGR555
        colours.append(tuple((w >> s & 31) * 255 // 31 for s in (0, 5, 10)))
    return colours


def tiles_image(data, colours, width=16):
    """The 4bpp tiles in `data` as an image, `width` tiles per row."""
    n = len(data) // 32
    img = Image.new('RGB', (width * 8, (n + width - 1) // width * 8))
    px = img.load()
    for t in range(n):
        b = data[t * 32:t * 32 + 32]
        ox, oy = t % width * 8, t // width * 8
        for y in range(8):
            p = (b[2 * y], b[2 * y + 1], b[16 + 2 * y], b[17 + 2 * y])
            for x in range(8):
                s = 7 - x
                c = sum((p[k] >> s & 1) << k for k in range(4))
                px[ox + x, oy + y] = colours[c]
    return img


def face(tiles):
    img = Image.new('RGB', (48, 64))
    img.paste(tiles.crop((0, 0, 48, 32)), (0, 0))
    img.paste(tiles.crop((48, 0, 96, 32)), (0, 32))
    return img


def parse_ids(spec, count):
    ids = []
    for part in spec.split(','):
        lo, _, hi = part.partition('-')
        ids += range(int(lo, 16), int(hi or lo, 16) + 1)
    bad = [i for i in ids if i >= count]
    if bad:
        sys.exit(f'No portrait ${bad[0]:02X}: the table has {count} entries')
    return ids


def main():
    ap = argparse.ArgumentParser(description=__doc__.split('\n')[0])
    ap.add_argument('out')
    ap.add_argument('--ids', help='hex IDs and ranges, such as 00,B9-F2')
    ap.add_argument('--scale', type=int, default=1, help='scale the images by N')
    ap.add_argument('--tiles', action='store_true', help='also write the stored tiles')
    args = ap.parse_args()

    rom = open(os.path.join(ROOT, 'fe4.sfc'), 'rb').read()
    labels = load_labels()
    graphics = pointer_table('PortraitGraphicPointers.csv', labels)
    palettes = pointer_table('PortraitPalettePointers.csv', labels)
    ids = parse_ids(args.ids, len(graphics)) if args.ids else range(len(graphics))
    os.makedirs(args.out, exist_ok=True)

    def scaled(img):
        s = args.scale
        return img.resize((img.width * s, img.height * s), Image.NEAREST) if s > 1 else img

    faces = []
    for i in ids:
        data, _ = decompress(rom, graphics[i])
        tiles = tiles_image(data, palette(rom, palettes[i]))
        img = face(tiles)
        faces.append((i, img))
        scaled(img).save(os.path.join(args.out, f'Portrait{i:02X}.png'))
        if args.tiles:
            scaled(tiles).save(os.path.join(args.out, f'Portrait{i:02X}_tiles.png'))

    cols = 16
    rows = (len(faces) + cols - 1) // cols
    sheet = Image.new('RGB', (cols * 52, rows * 78), (32, 32, 32))
    draw = ImageDraw.Draw(sheet)
    for k, (i, img) in enumerate(faces):
        x, y = k % cols * 52 + 2, k // cols * 78 + 2
        sheet.paste(img, (x, y))
        draw.text((x, y + 64), f'{i:02X}', fill=(255, 255, 255))
    scaled(sheet).save(os.path.join(args.out, 'sheet.png'))
    print(f'Wrote {len(faces)} portraits and sheet.png to {args.out}')


if __name__ == '__main__':
    main()
