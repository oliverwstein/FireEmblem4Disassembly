#!/usr/bin/env python3
"""Export the item icons as PNG images.

usage: tools/item_icons.py OUT_DIR [--scale N]

Writes OUT_DIR/sheet.png (g4bppItemIcons with each icon's number) and
OUT_DIR/items.png (every item ID with its icon, from aItemIconOffsets, and its
name from data/item/ItemData.csv), coloured with aItemIconPalette. Needs
labels.txt from ./build.sh, and Pillow.

The sheet is uncompressed 4bpp, 8 icons across (see ItemIconOffset in
include/Items.h); the item window copies the whole of it to VRAM, and
rlCopyItemIcon copies single icons.
"""
import argparse
import csv
import os
import re
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from decompress import rom_offset
from portraits import load_labels, palette, tiles_image, ROOT

try:
    from PIL import Image, ImageDraw
except ImportError:
    sys.exit('tools/item_icons.py needs Pillow: pip3 install pillow')


def icon(sheet_img, number):
    x, y = number % 8 * 16, number // 8 * 16
    return sheet_img.crop((x, y, x + 16, y + 16))


def main():
    ap = argparse.ArgumentParser(description=__doc__.split('\n')[0])
    ap.add_argument('out')
    ap.add_argument('--scale', type=int, default=2)
    args = ap.parse_args()
    rom = open(os.path.join(ROOT, 'fe4.sfc'), 'rb').read()
    labels = load_labels()
    start = rom_offset(labels['g4bppItemIcons'])
    sheet = tiles_image(rom[start:start + 0x4000], palette(rom, labels['aItemIconPalette']), 16)

    icons = []                                    # icon number per item ID
    for line in open(os.path.join(ROOT, 'data', 'item', 'ItemIconOffsets.asm'), encoding='utf-8'):
        m = re.match(r'\s*\.word ItemIconOffset\(\s*(\d+)\)', line)
        if m:
            icons.append(int(m.group(1)))
    rows = list(csv.reader(open(os.path.join(ROOT, 'data', 'item', 'ItemData.csv'))))[1:]
    names = [r[0] or r[1] for r in rows]
    os.makedirs(args.out, exist_ok=True)
    s = args.scale

    used = max(icons) + 1
    grid = Image.new('RGB', (8 * 28, (used + 7) // 8 * 30), (32, 32, 32))
    draw = ImageDraw.Draw(grid)
    for n in range(used):
        x, y = n % 8 * 28 + 6, n // 8 * 30 + 2
        grid.paste(icon(sheet, n), (x, y))
        draw.text((x, y + 17), str(n), fill=(200, 200, 200))
    grid.resize((grid.width * s, grid.height * s), Image.NEAREST).save(os.path.join(args.out, 'sheet.png'))

    cols = 4
    items = Image.new('RGB', (cols * 150, (len(icons) + cols - 1) // cols * 20), (32, 32, 32))
    draw = ImageDraw.Draw(items)
    for i, n in enumerate(icons):
        x, y = i % cols * 150 + 2, i // cols * 20 + 2
        items.paste(icon(sheet, n), (x, y))
        name = names[i] if i < len(names) else '-'
        draw.text((x + 20, y + 3), f'{i:02X} {name[:18]}', fill=(220, 220, 220))
    items.resize((items.width * s, items.height * s), Image.NEAREST).save(os.path.join(args.out, 'items.png'))
    print(f'Wrote sheet.png ({used} icons) and items.png ({len(icons)} items) to {args.out}')


if __name__ == '__main__':
    main()
