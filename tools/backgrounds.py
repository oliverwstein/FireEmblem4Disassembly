#!/usr/bin/env python3
"""Render the backgrounds as the game composes them, from the built ROM.

usage: tools/backgrounds.py OUT_DIR [--rom FILE] [--scale N]
       tools/backgrounds.py --self-test

Reads the tables (aDialogueBackgroundPointers, aBattleBackgrounds,
aMapBattleMagicBackgrounds) at their labels in labels.txt from the built ROM
(FE4Disassembly.sfc by default), decompresses what they point at and writes:

  dialogue/NAME.png   the picture (32x11 tilemap, rows 9-19 of the screen)
                      with the foreground layer over it;
  battle/NN_NAME.png  the 64x32 background, colours from palette 3 colour 1;
  magic/NN_ITEM.png   the map battle magic layer (tiles from tile 896).

These are previews, not source: the source is the assembled scene PNGs in
gfx/scenes/ (packed by tools/scene_pack.py to .4bpp/.2bpp and .bin) and the
palettes. Because they come from the built ROM, an edit to any of those shows up
here after ./build.sh.

--self-test makes two edits to gfx/scenes/battle/Plains.png in a temporary copy
of the repository (a cell copied from elsewhere, and a changed pixel that needs a
new tile, which goes into a free blank slot of the full sheet) and builds it with
./build.sh mod. It checks that the build succeeded, that Plains' tiles and
tilemap changed, and that the built ROM's streams decompress to the edited bytes
while every other table entry decompresses to the same bytes as before (so the
streams after the edited ones moved, and the tables moved with them).
"""
import argparse
import os
import shutil
import subprocess
import sys
import tempfile

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from decompress import decompress, rom_offset

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DIALOGUE = ['Fountain', 'Gate', 'Alley', 'Throne', 'Hallway', 'Cloister']


def load_labels(root):
    out, by_addr = {}, {}
    for line in open(os.path.join(root, 'labels.txt')):
        p = line.split()
        if len(p) == 3 and ':' not in p[2]:
            out.setdefault(p[2].lstrip('.'), int(p[1], 16))
            by_addr.setdefault(int(p[1], 16), p[2].lstrip('.'))
    return out, by_addr


class Rom:
    def __init__(self, path):
        self.b = open(path, 'rb').read()

    def off(self, a):
        o = rom_offset(a)
        return rom_offset(a | 0x400000) if o is None else o

    def long(self, a):
        o = self.off(a)
        return int.from_bytes(self.b[o:o + 3], 'little')

    def raw(self, a, n):
        o = self.off(a)
        return self.b[o:o + n]

    def comp(self, a):
        return decompress(self.b, a)[0]


def colours(raw):
    return [tuple((w >> s & 31) * 255 // 31 for s in (0, 5, 10))
            for w in (raw[i] | raw[i + 1] << 8 for i in range(0, len(raw) - 1, 2))]


def draw(img, tiles, tilemap, pal, x0=0, y0=0, width=32, base=0, transparent=False):
    """Draw a tilemap (SNES words, 32 entries a row; a 64-wide map is two 32x32
    screens side by side) of 4bpp tiles numbered from base."""
    px = img.load()
    entries = [tilemap[i] | tilemap[i + 1] << 8 for i in range(0, len(tilemap) - 1, 2)]
    for k, e in enumerate(entries):
        screen, r = divmod(k, 32 * 32) if width == 64 else (0, k)
        tx, ty = screen * 32 + r % 32, r // 32
        n = (e & 0x3FF) - base
        t = tiles[n * 32:n * 32 + 32] if 0 <= n * 32 < len(tiles) else bytes(32)
        p, hf, vf = e >> 10 & 7, e & 0x4000, e & 0x8000
        for y in range(8):
            for x in range(8):
                sx, sy = (7 - x if hf else x), (7 - y if vf else y)
                s = 7 - sx
                c = sum((t[(2 * sy + (q & 1)) + 16 * (q >> 1)] >> s & 1) << q for q in range(4))
                if transparent and c == 0:
                    continue
                X, Y = x0 + tx * 8 + x, y0 + ty * 8 + y
                if 0 <= X < img.size[0] and 0 <= Y < img.size[1]:
                    px[X, Y] = pal[(p * 16 + c) % len(pal)] if pal else (c * 17,) * 3


def render(rom, labels, by_addr, out, scale):
    from PIL import Image
    made = 0

    def save(img, path):
        nonlocal made
        os.makedirs(os.path.dirname(path), exist_ok=True)
        if scale > 1:
            img = img.resize((img.size[0] * scale, img.size[1] * scale), Image.NEAREST)
        img.save(path)
        made += 1

    t = labels['aDialogueBackgroundPointers']
    for i, name in enumerate(DIALOGUE):
        r = rom.long(t + 3 * i)
        fg, pic, pal, fgm, picm = (rom.long(r + k) for k in (0, 3, 6, 9, 12))
        tiles = bytearray(0x8000)
        a = rom.comp(pic)[:0x4000]; tiles[:len(a)] = a                 # VRAM $0000: tiles 0-511
        b = rom.comp(fg)[:0x2000]; tiles[0x4000:0x4000 + len(b)] = b    # VRAM $2000: tiles 512-767
        img = Image.new('RGB', (256, 224))
        p = colours(rom.raw(pal, 0x200))
        draw(img, tiles, rom.comp(picm), p, y0=9 * 8)
        draw(img, tiles, rom.comp(fgm), p, transparent=True)
        save(img, os.path.join(out, 'dialogue', f'{name}.png'))

    t = labels['aBattleBackgrounds']
    for i in range(24):
        r = t + 10 * i
        g, m, pal = rom.long(r), rom.long(r + 3), rom.long(r + 6)
        p = colours(bytes(0x62) + rom.raw(pal, 0x5E) + bytes(0x100))
        img = Image.new('RGB', (512, 256))
        draw(img, rom.comp(g), rom.comp(m), p, width=64)
        save(img, os.path.join(out, 'battle', f'{i:02X}_{by_addr.get(pal, "").replace("aBattleBackground", "").replace("Palette", "")}.png'))

    t = labels['aMapBattleMagicBackgrounds']
    from gen_offsets import read_csv_names
    items = read_csv_names('data/item/ItemData.csv', 2)  # item names in ID order
    for i in range(42):
        r = t + 9 * i
        g, m, pal = rom.long(r), rom.long(r + 3), rom.long(r + 6)
        img = Image.new('RGB', (256, 256))
        draw(img, rom.comp(g), rom.comp(m), colours(rom.comp(pal)), base=896)
        save(img, os.path.join(out, 'magic', f'{i:02X}_{items[0x3E + i]}.png'))
    return made


def self_test():
    """Edit assembled scene PNGs in a copy, build, and check what the ROM holds."""
    from PIL import Image
    rom0 = Rom(os.path.join(ROOT, 'FE4Disassembly.sfc'))
    labels, _ = load_labels(ROOT)
    t = labels['aBattleBackgrounds']
    before = [rom0.comp(rom0.long(t + 10 * i + k)) for i in range(24) for k in (0, 3)]
    tmp = tempfile.mkdtemp()
    try:
        subprocess.run(['rsync', '-a', '--exclude', '.git', ROOT + '/', tmp + '/'], check=True)
        # Two edits to gfx/scenes/battle/Plains.png: copy cell (0, 16) onto (0, 0),
        # which reuses existing tiles, and change one pixel of a two-colour cell,
        # which needs a new tile. Plains' sheet is full (512 of 512), so the new
        # tile takes a free blank slot and the sheet keeps its size.
        import json
        import scene_pack
        manifest = json.load(open(os.path.join(ROOT, 'gfx/scenes/battle/Plains.scene.json')))
        bpp_rel = manifest['sheets'][0]['png'][:-4]
        tm_rel = manifest['layers'][0]['tilemap']
        plains_png = os.path.join(tmp, 'gfx/scenes/battle/Plains.png')
        pimg = Image.open(plains_png)
        pimg.paste(pimg.crop((0, 128, 8, 136)), (0, 0))
        pimg.save(plains_png)
        scene_pack._new_tile_edit(plains_png, start_row=2)
        # Generated files copied from the working tree must not stand in for a failed pack.
        for rel in (bpp_rel, tm_rel, bpp_rel + '.lz', tm_rel + '.lz'):
            if os.path.exists(os.path.join(tmp, rel)):
                os.remove(os.path.join(tmp, rel))

        # ./build.sh mod builds without comparing to fe4.sfc, so a non-zero exit
        # means a build step (such as scene_pack.py build) failed.
        r = subprocess.run(['./build.sh', 'mod'], cwd=tmp, capture_output=True, text=True)
        if r.returncode != 0:
            print('FAIL: the edited build failed')
            print((r.stdout + r.stderr)[-2000:])
            return 1
        rom1 = Rom(os.path.join(tmp, 'FE4Disassembly.sfc'))
        labels1, _ = load_labels(tmp)
        t1 = labels1['aBattleBackgrounds']
        after = [rom1.comp(rom1.long(t1 + 10 * i + k)) for i in range(24) for k in (0, 3)]
        plains_bpp = open(os.path.join(tmp, bpp_rel), 'rb').read()
        plains_tm = open(os.path.join(tmp, tm_rel), 'rb').read()
        bad = 0
        if plains_bpp == before[0] or len(plains_bpp) != len(before[0]):
            bad += 1
            print('FAIL: the new tile did not change the Plains sheet in place')
        if plains_tm == before[1]:
            bad += 1
            print('FAIL: the edits did not change the Plains tilemap')
        for i, (b, a) in enumerate(zip(before, after)):
            rec, k = divmod(i, 2)
            if rec in (0, 1):
                expect = plains_bpp if k == 0 else plains_tm
            else:
                expect = b
            if a != expect:
                bad += 1
                print(f'FAIL: entry {rec:02X} {"tiles" if k == 0 else "tilemap"} decompresses to other bytes')
        print('edited scenes built and decompress as edited; other entries unchanged'
              if not bad else f'{bad} entries wrong')
        return 1 if bad else 0
    finally:
        shutil.rmtree(tmp)


def main():
    if sys.argv[1:] == ['--self-test']:
        return self_test()
    ap = argparse.ArgumentParser(description=__doc__.split('\n')[0])
    ap.add_argument('out')
    ap.add_argument('--rom', default=os.path.join(ROOT, 'FE4Disassembly.sfc'))
    ap.add_argument('--scale', type=int, default=1)
    args = ap.parse_args()
    labels, by_addr = load_labels(ROOT)
    n = render(Rom(args.rom), labels, by_addr, args.out, args.scale)
    print(f'Wrote {n} pictures to {args.out}')


if __name__ == '__main__':
    sys.exit(main())
