#!/usr/bin/env python3
"""Export the portraits as PNG images.

usage: tools/portraits.py OUT_DIR [--ids 00,B9-F2] [--scale N] [--tiles]

For each entry of aPortraitGraphicPointers (or those given by --ids, in hex),
decompresses its graphics (tools/decompress.py), colours them with the entry's
palette from aPortraitPalettePointers, and writes OUT_DIR/PortraitXX.png, plus
OUT_DIR/sheet.png with the portraits grouped (playable, named units,
dialogue only, class cards, not used) and labelled, and OUT_DIR/portraits.txt
listing each entry's group, its users and the entries sharing its graphics. --tiles also
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


GROUPS = ['Playable', 'Named units', 'Dialogue only', 'Class cards', 'Not used']


def group_entries(count, graphics):
    """Each entry's (group, short name, users), from the game's own tables.

    aPortraitDataIDs (data/character/PortraitDataIDs.csv) gives each character
    ID its entry; IDs past the last character are dialogue-only portraits.
    A character's unit type (data/character/CharacterData.csv) says whether it
    is playable (Static or Dynamic). aClassPortraitDataIDs gives the class cards.
    """
    data = os.path.join(ROOT, 'data')
    rows = list(csv.reader(open(os.path.join(data, 'character', 'CharacterData.csv'))))
    ti, ii = rows[0].index('Type'), rows[0].index('ID')
    unit_type = {int(r[ii].lstrip('$'), 16): r[ti] for r in rows[1:] if r[ii]}
    index = {name: k for k, (name, _) in
             enumerate(list(csv.reader(open(os.path.join(data, 'portraits', 'PortraitGraphicPointers.csv'))))[1:])}

    def entry_index(value):                 # PortraitDataSigurd, or a number
        return index[value] if value in index else int(value.lstrip('$'), 16)

    users = {i: [] for i in range(count)}
    types = {i: set() for i in range(count)}
    ids = list(csv.reader(open(os.path.join(data, 'character', 'PortraitDataIDs.csv'))))[1:]
    for character, (name, value) in enumerate(ids, 1):
        i = entry_index(value)
        if i < count:
            users[i].append(name.removeprefix('Portrait'))
            types[i].add(unit_type.get(character, 'none'))
    cards = {i: [] for i in range(count)}
    for name, value in list(csv.reader(open(os.path.join(data, 'class', 'ClassPortraitDataIDs.csv'))))[1:]:
        cards[entry_index(value)].append(name.removeprefix('ClassPortrait'))
    result = {}
    for i in range(count):
        if types[i] & {'UnitTypeStatic', 'UnitTypeDynamic'}:
            group = 'Playable'
        elif cards[i]:
            group = 'Class cards'
        elif types[i] & {'UnitTypeEnemy', 'UnitTypeHoly'}:
            group = 'Named units'
        elif users[i]:
            group = 'Dialogue only'
        else:
            group = 'Not used'
        names = cards[i] + users[i]
        short = (names[0].removeprefix('Dialogue') if names else '-')
        result[i] = (group, short, names[:8] + ([f'and {len(names) - 8} more'] if len(names) > 8 else []))
    return result


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
    graphics = pointer_table(os.path.join('portraits', 'PortraitGraphicPointers.csv'), labels)
    palettes = pointer_table(os.path.join('portraits', 'PortraitPalettePointers.csv'), labels)
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

    groups = group_entries(len(graphics), graphics)
    by_group = {}
    for i, img in faces:
        by_group.setdefault(groups[i][0], []).append((i, img))
    cols, cell_w, cell_h, head = 12, 68, 88, 22
    height = sum(head + (len(v) + cols - 1) // cols * cell_h for v in by_group.values())
    sheet = Image.new('RGB', (cols * cell_w + 8, height + 4), (32, 32, 32))
    draw = ImageDraw.Draw(sheet)
    y = 2
    for title in GROUPS:
        members = by_group.get(title)
        if not members:
            continue
        draw.text((6, y + 6), f'{title} ({len(members)})', fill=(255, 220, 120))
        y += head
        for k, (i, img) in enumerate(members):
            x, yy = k % cols * cell_w + 10, y + k // cols * cell_h
            sheet.paste(img, (x, yy))
            draw.text((x, yy + 65), f'{i:02X}', fill=(255, 255, 255))
            draw.text((x, yy + 75), groups[i][1][:10], fill=(170, 170, 170))
        y += (len(members) + cols - 1) // cols * cell_h
    scaled(sheet).save(os.path.join(args.out, 'sheet.png'))
    with open(os.path.join(args.out, 'portraits.txt'), 'w') as f:
        for title in GROUPS:
            for i, _ in by_group.get(title, []):
                same = [f'{j:02X}' for j in range(len(graphics))
                        if graphics[j] == graphics[i] and j != i]
                f.write(f'{i:02X}  {title:<16}  {", ".join(groups[i][2]) or "-"}'
                        + (f'  [same graphics as {", ".join(same)}]' if same else '') + '\n')
    print(f'Wrote {len(faces)} portraits, sheet.png and portraits.txt to {args.out}')


if __name__ == '__main__':
    main()
