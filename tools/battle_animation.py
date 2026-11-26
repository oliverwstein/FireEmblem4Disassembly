#!/usr/bin/env python3
"""Render the frames of a battle animation from the built ROM.

usage: tools/battle_animation.py OUT.png [--class NAME] [--record N] [--item NAME]
                                 [--ids A,B,C,D] [--entry N] [--sheet LABEL]
                                 [--rom FILE] [--scale N]

Picks a record of aBattleAnimationLookup (206 records of class,
weapon category, character, class/gender value and four animation IDs), by
--record or as the first record for --class, and draws every frame record of
its sequence data. Each frame is assembled the way the battle code does it:

  - the class sheet (second ID, aBattleAnimationSheets) is decompressed, and
    the frame's entry in the frame table (first ID, second pointer of
    aBattleAnimationFrameTables) copies slices of it into sprite VRAM, one
    16-tile row per slice, from tile 0 (frame 255 keeps the last frame's);
  - the weapon graphics of --item (aBattleWeaponGraphics) go to tile 64, the
    extra tiles (third ID, aBattleAnimationExtras) to their record's offset;
  - the frame record's sprite array (first pointer: a frame number, then a
    structSpriteArray) places 8x8 and 16x16 sprites with those tiles;
  - colours: the fourth ID's palettes (sprite palettes 0-1), the weapon's
    palette (2); palette 3 (character pieces) is drawn magenta.

--ids gives the four animation IDs (hex) instead of the record's, e.g.
5E,66,46,2E for a Dancer's dance (rlUnknown95A3C1). --entry N draws entry N of aBattleAnimationFrameTables instead of the
record's, and --sheet LABEL takes the class sheet from that compressed stream:
for entries no record uses (6-10), to try candidate sheets.

A preview, not source. Tables are read at their labels in labels.txt, so an
edit to them shows here after ./build.sh.
"""
import argparse
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from decompress import decompress, rom_offset

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


def names(path):
    return [l.split(',')[0] for l in open(os.path.join(ROOT, path)).read().split('\n')[1:] if l.strip()]


class Rom:
    def __init__(self, path):
        self.b = open(path, 'rb').read()

    def o(self, a):
        x = rom_offset(a)
        return rom_offset(a | 0x400000) if x is None else x

    def byte(self, a): return self.b[self.o(a)]
    def word(self, a): x = self.o(a); return self.b[x] | self.b[x + 1] << 8
    def long(self, a): x = self.o(a); return int.from_bytes(self.b[x:x + 3], 'little')
    def raw(self, a, n): x = self.o(a); return self.b[x:x + n]
    def comp(self, a): return decompress(self.b, a)[0]


def colours(raw):
    return [tuple(((raw[i] | raw[i + 1] << 8) >> s & 31) * 255 // 31 for s in (0, 5, 10))
            for i in range(0, len(raw) - 1, 2)]


def tile(vram, n):
    b = vram[n * 32:n * 32 + 32].ljust(32, b'\0')
    return [[sum((b[2 * y + (q & 1) + 16 * (q >> 1)] >> (7 - x) & 1) << q for q in range(4))
             for x in range(8)] for y in range(8)]


def main():
    ap = argparse.ArgumentParser(description=__doc__.split('\n')[0])
    ap.add_argument('out')
    ap.add_argument('--class', dest='cls')
    ap.add_argument('--record', type=int)
    ap.add_argument('--item', default='IronSword')
    ap.add_argument('--rom', default=os.path.join(ROOT, 'FE4Disassembly.sfc'))
    ap.add_argument('--scale', type=int, default=2)
    ap.add_argument('--entry', type=int)
    ap.add_argument('--ids')
    ap.add_argument('--sheet')
    args = ap.parse_args()
    from PIL import Image
    from gen_offsets import read_csv_names
    lab = {}
    for line in open(os.path.join(ROOT, 'labels.txt')):
        p = line.split()
        if len(p) == 3 and ':' not in p[2]:
            lab.setdefault(p[2].lstrip('.'), int(p[1], 16))
    rom = Rom(args.rom)
    classes, items = names('data/class/ClassData.csv'), read_csv_names('data/item/ItemData.csv', 2)
    records = [rom.raw(lab['aBattleAnimationLookup'] + 8 * k, 8) for k in range(0x670 // 8)]
    if args.record is not None:
        k = args.record
    else:
        want = classes.index(args.cls) if args.cls else 0
        k = next(i for i, e in enumerate(records) if e[0] == want)
    e = records[k]
    ids = bytes(int(x, 16) for x in args.ids.split(',')) if args.ids else e[4:]
    fr = args.entry if args.entry is not None else rom.byte(lab['aBattleAnimationFrameIndices'] + ids[0] + 1)
    seqs = rom.long(lab['aBattleAnimationFrameTables'] + 6 * fr)
    frames = rom.long(lab['aBattleAnimationFrameTables'] + 6 * fr + 3)
    sheet = rom.comp(lab[args.sheet] if args.sheet else
                     rom.long(lab['aBattleAnimationSheets'] + 5 * rom.byte(lab['aBattleAnimationSheetIndices'] + ids[1] + 1)))
    xa = lab['aBattleAnimationExtras'] + 7 * rom.byte(lab['aBattleAnimationExtraIndices'] + ids[2] + 1)
    extras = rom.comp(rom.long(xa + 2))
    pa = lab['aBattleAnimationPalettes'] + 4 * rom.byte(lab['aBattleAnimationPaletteIndices'] + ids[3] + 1)
    body = colours(rom.raw(rom.long(pa), rom.byte(pa + 3)))
    item = items.index(args.item)
    w = rom.word(lab['aBattleWeaponGraphicsIndices'] + 2 * item)
    weapon = rom.comp(rom.long(lab['aBattleWeaponGraphics'] + 3 * (w & 0xFF))) if w & 0xFF != 0xFF else b''
    wp = colours(rom.raw(0xE00F30 + 30 * (w >> 8), 30)) if w & 0xFF != 0xFF else []
    pal = ([(0, 0, 0)] + body + [(255, 0, 255)] * 31)[:32]
    pal += ([(0, 0, 0)] + wp + [(255, 0, 255)] * 15)[:16] + [(0, 0, 0)] + [(255, 0, 255)] * 15
    print(f'record {k}: {classes[e[0]] if e[0] < len(classes) else e[0]}, IDs {ids.hex(" ")}, '
          f'sequences ${seqs:06X}, frames ${frames:06X}')

    # The header holds the offsets of the sequence index and of the frame record
    # list; the list runs up to the first byte anything in either points to.
    lst = seqs + rom.word(seqs + 2)
    limit = min(rom.word(seqs + k) for k in range(rom.word(seqs), rom.word(seqs + 2), 2))
    count = 0
    while rom.word(seqs + 2) + 2 * count < limit and count < 256:
        limit = min(limit, rom.word(lst + 2 * count))
        count += 1
    vram = bytearray(0x8000)
    pics = []
    for i in range(count):
        ra = seqs + rom.word(lst + 2 * i)
        f = rom.byte(ra)
        if f != 0xFF:
            vram = bytearray(0x8000)
            fo = frames + rom.word(frames + 2 * f)
            for p in range(rom.byte(fo)):
                so, sz = rom.word(fo + 1 + 4 * p), rom.word(fo + 3 + 4 * p)
                vram[p * 512:p * 512 + sz] = sheet[so:so + sz].ljust(sz, b'\0')
            vram[64 * 32:64 * 32 + len(weapon)] = weapon
            n = rom.byte(xa + 1) * 32
            vram[rom.byte(xa) * 32:rom.byte(xa) * 32 + n] = extras[:n].ljust(n, b'\0')
        img = Image.new('RGB', (160, 128), (40, 40, 60))
        px = img.load()
        arr = ra + 1
        for s in range(rom.word(arr)):
            a = arr + 2 + 5 * s
            xw, y, attr = rom.word(a), rom.byte(a + 2), rom.word(a + 3)
            size = 16 if xw & 0x8000 else 8
            x = (xw & 0x1FF) - (0x200 if xw & 0x100 else 0)
            y -= 0x100 if y & 0x80 else 0
            t, pl = attr & 0x1FF, attr >> 9 & 7
            for ty in range(size // 8):
                for tx in range(size // 8):
                    tt = tile(vram, t + ty * 16 + tx)
                    for yy in range(8):
                        for xx in range(8):
                            c = tt[yy][xx]
                            if not c:
                                continue
                            sx = size - 1 - (tx * 8 + xx) if attr & 0x4000 else tx * 8 + xx
                            sy = size - 1 - (ty * 8 + yy) if attr & 0x8000 else ty * 8 + yy
                            X, Y = 80 + x + sx, 100 + y + sy
                            if 0 <= X < 160 and 0 <= Y < 128:
                                px[X, Y] = pal[(16 * (pl & 3) + c) % len(pal)]
        pics.append(img)
    cols = 4
    sheet_img = Image.new('RGB', (160 * cols, 128 * ((len(pics) + cols - 1) // cols)))
    for i, im in enumerate(pics):
        sheet_img.paste(im, (i % cols * 160, i // cols * 128))
    if args.scale > 1:
        sheet_img = sheet_img.resize((sheet_img.width * args.scale, sheet_img.height * args.scale), Image.NEAREST)
    sheet_img.save(args.out)
    print(f'{len(pics)} frame records to {args.out}')


if __name__ == '__main__':
    main()
