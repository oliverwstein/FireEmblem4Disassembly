#!/usr/bin/env python3
"""Map sprites as frame-grid PNGs: standing and walking frames of one sprite in one file.

usage: tools/map_sprites.py unpack [--force]
       tools/map_sprites.py build
       tools/map_sprites.py clean
       tools/map_sprites.py --self-test

A map sprite ID is a row of data/class/MapMovementShortSpritePointers.csv (65,
IDs 0-64) or, with bit $8000 set, of MapMovementTallSpritePointers.csv (32,
IDs 0-31); the first column names it, and class map sprite assignments
(data/class/ClassMapSpriteAssignment.asm) and events use those names. Each ID
has two graphics:

- walking frames, a compressed stream in gfx/build/MapMovementSprites/
  (NAME.4bpp.comp, placed by sprites.streams), decompressed to $7EAB88 by
  rlLoadMovingUnitSprite: 4 facings x 4 frames, short $140 bytes (10 tiles)
  a frame, tall $200 (16 tiles). Facing $00 is left, $08 right, $10 up, $18
  down (wMovingUnitSpriteFacing; rsSetShortMovingUnitSpriteFrame multiplies it
  out). Each frame's first half goes to sprite tiles $20.., the second to
  $30.. (word addresses $6200 and $6300).
- standing frames, uncompressed: short IDs 0-62 in g4bppStandingMapSprites1
  ($D70000, $180 bytes = 3 frames of 4 tiles each), tall IDs 0-30 in
  g4bppStandingMapSprites2 ($DA0000, $240 bytes = 3 frames of 6 tiles), as
  aShortStandingMapSpritePointers and aTallStandingMapSpritePointers read them.
  The game plays them 0, 1, 2, 1 (rsQueueShortStandingMapSpriteFrames). Short
  IDs 63-64 (SmallOifey, ShortEmpty) and tall ID 31 (TallEmpty) have none.

The authored file is gfx/map_sprites/short/NAME.png (96x120) or
gfx/map_sprites/tall/NAME.png (128x160), indexed, colours 0-15 (0 transparent;
the PNG palette is for viewing only). Cells are 24x24 (short) or 32x32 (tall),
4 across:

- row 0: standing frames 0-2 in cells 0-2; cell 3 must be blank.
- rows 1-4: walking frames, one facing a row (left, right, up, down), frames
  0-3 across.

How a cell maps to tiles follows the sprite arrays the game draws with:

- short walking (aMovingUnitSprite24x24): a 24x24 picture from the cell's top
  left, tiles $20 $21 $24 / $30 $22 $23 / $34 $32 $33 in 8x8 steps. Tiles $31
  and $22 overlap at the centre, and every original frame stores the same
  pixels in both, so the centre cell is written to both.
- tall walking (aMovingUnitSprite32x32): a 32x32 picture, tiles $20-$23 /
  $30-$33 / $24-$27 / $34-$37. At run time each frame is also nudged by
  aMapSpriteWalkOffsets; that offset is code data, not part of the PNG.
- short standing: one 16x16 sprite (aMapSpriteSlotTiles), drawn in the cell at
  (4, 8), where the walking array puts the unit's tile; frame tiles 0 1 / 2 3.
- tall standing: two 16x16 sprites, the upper one 16 pixels higher
  (rlDrawDeployedUnitMapSprites). Only six tiles are uploaded: frame tiles 0-1
  go to the lower sprite's top row, 2-5 to the next VRAM row (the lower
  sprite's bottom row, then the upper sprite's bottom row); the upper sprite's
  top row is never written. So the frame is 16x24, drawn at (8, 8): tiles 4 5 /
  0 1 / 2 3.

Every pixel of a cell outside its picture must be colour 0, or pack refuses.

build packs every PNG into gfx/build/MapMovementSprites/NAME.4bpp (for gfx.py
lz, which keeps NAME.4bpp.comp while it matches) when the PNG is newer, and
writes gfx/build/map_sprites/StandingMapSprites1.4bpp and 2.4bpp, which
build.asm includes. It fails when a NAME.4bpp.comp has no PNG. unpack writes
the PNGs from the .comp streams and the standing sheets in fe4.sfc.
"""
import argparse
import glob
import os
import sys
import tempfile

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from decompress import decompress, rom_offset
import gfx

try:
    from PIL import Image
except ImportError:
    sys.exit('tools/map_sprites.py needs Pillow: pip3 install pillow')

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SRC_DIR = os.path.join(ROOT, 'gfx', 'map_sprites')
WALK_DIR = os.path.join(ROOT, 'gfx', 'build', 'MapMovementSprites')
STAND_DIR = os.path.join(ROOT, 'gfx', 'build', 'map_sprites')
CSV = {'short': os.path.join(ROOT, 'data', 'class', 'MapMovementShortSpritePointers.csv'),
       'tall': os.path.join(ROOT, 'data', 'class', 'MapMovementTallSpritePointers.csv')}
STREAMS = os.path.join(WALK_DIR, 'sprites.streams')

TILE = 32
FACINGS = ('left', 'right', 'up', 'down')

# Per size: cell size, walking frame tiles, standing frame tiles, standing IDs,
# standing sheet, its ROM address, and (x, y) of each tile in the cell.
KINDS = {
    'short': dict(
        cell=24, walk_tiles=10, stand_tiles=4, stand_count=63,
        sheet='StandingMapSprites1', addr=0xD70000,
        walk={0: (0, 0), 1: (8, 0), 4: (16, 0),
              5: (0, 8), 2: (8, 8), 6: (8, 8), 3: (16, 8),
              9: (0, 16), 7: (8, 16), 8: (16, 16)},
        stand={0: (4, 8), 1: (12, 8), 2: (4, 16), 3: (12, 16)},
    ),
    'tall': dict(
        cell=32, walk_tiles=16, stand_tiles=6, stand_count=31,
        sheet='StandingMapSprites2', addr=0xDA0000,
        walk={t: ((t % 4) * 8, ((t >= 8) + 2 * ((t % 8) >= 4)) * 8) for t in range(16)},
        stand={4: (8, 8), 5: (16, 8), 0: (8, 16), 1: (16, 16), 2: (8, 24), 3: (16, 24)},
    ),
}


def size(kind):
    c = KINDS[kind]['cell']
    return 4 * c, 5 * c


def sprite_names(kind):
    """Map sprite names in ID order, from the pointer CSV."""
    rows = [l.strip() for l in open(CSV[kind]) if l.strip()]
    return [r.split(',')[0] for r in rows[1:]]


def stream_files():
    """Label -> file name for each line of sprites.streams."""
    out = {}
    for line in open(STREAMS):
        line = line.split('#')[0].split()
        if len(line) == 2 and line[0] not in ('start', 'end'):
            out[line[0]] = line[1]
    return out


def sprites():
    """[(kind, id, name, stream file name)] for every map sprite."""
    files = stream_files()
    out = []
    for kind in ('short', 'tall'):
        rows = [l.strip() for l in open(CSV[kind]) if l.strip()][1:]
        for i, r in enumerate(rows):
            name, label = r.split(',')[:2]
            if label not in files:
                sys.exit(f'{CSV[kind]}: {label} is not in {STREAMS}')
            out.append((kind, i, name, files[label]))
    return out


def decode_tile(b):
    rows = []
    for y in range(8):
        p = (b[2 * y], b[2 * y + 1], b[16 + 2 * y], b[17 + 2 * y])
        rows.append([sum((p[k] >> (7 - x) & 1) << k for k in range(4)) for x in range(8)])
    return rows


def encode_tile(px, ox, oy, where):
    out = bytearray(TILE)
    for y in range(8):
        for x in range(8):
            c = px[ox + x, oy + y]
            if not 0 <= c < 16:
                raise ValueError(f'{where}: pixel ({ox + x}, {oy + y}) uses colour {c}; 4bpp supports 0-15')
            for k in range(4):
                out[16 * (k // 2) + 2 * y + k % 2] |= (c >> k & 1) << (7 - x)
    return bytes(out)


def walk_cell(kind, facing, frame):
    c = KINDS[kind]['cell']
    return frame * c, (1 + facing) * c


def to_image(kind, walk, stand, colours, where=''):
    """An indexed frame-grid Image from walking bytes and standing bytes (or None)."""
    k = KINDS[kind]
    w, h = size(kind)
    img = Image.new('P', (w, h), 0)
    flat = [v for col in colours[:16] for v in col]
    img.putpalette(flat + [0] * (768 - len(flat)))
    px = img.load()
    n = k['walk_tiles']
    if len(walk) != 16 * n * TILE:
        raise ValueError(f'{where}: walking frames are {len(walk):#x} bytes, expected {16 * n * TILE:#x}')

    def put(tile, ox, oy):
        for y, row in enumerate(decode_tile(tile)):
            for x, v in enumerate(row):
                px[ox + x, oy + y] = v

    for f in range(16):
        facing, frame = divmod(f, 4)
        cx, cy = walk_cell(kind, facing, frame)
        tiles = [walk[(f * n + t) * TILE:(f * n + t + 1) * TILE] for t in range(n)]
        if kind == 'short' and tiles[2] != tiles[6]:
            raise ValueError(f'{where}: {FACINGS[facing]} frame {frame}: tiles $22 and $31 differ, '
                             'so the frame cannot be one 24x24 picture')
        for t, (x, y) in k['walk'].items():
            put(tiles[t], cx + x, cy + y)
    if stand is not None:
        m = k['stand_tiles']
        for frame in range(3):
            for t, (x, y) in k['stand'].items():
                put(stand[(frame * m + t) * TILE:(frame * m + t + 1) * TILE], frame * k['cell'] + x, y)
    return img


def picture_mask(kind, has_stand):
    """Set of (x, y) pixels that belong to some picture."""
    k = KINDS[kind]
    c = k['cell']
    mask = set()
    for facing in range(4):
        for frame in range(4):
            cx, cy = walk_cell(kind, facing, frame)
            for x, y in k['walk'].values():
                mask.update((cx + x + i, cy + y + j) for i in range(8) for j in range(8))
    if has_stand:
        for frame in range(3):
            for x, y in k['stand'].values():
                mask.update((frame * c + x + i, y + j) for i in range(8) for j in range(8))
    return mask


_MASKS = {}


def from_image(kind, path, has_stand):
    """(walking bytes, standing bytes or None) from a frame-grid PNG, after checking it."""
    k = KINDS[kind]
    img = Image.open(path)
    if img.mode != 'P':
        raise ValueError(f'{path}: not an indexed PNG (mode {img.mode}); save it with a palette')
    if img.size != size(kind):
        raise ValueError(f'{path}: a {kind} map sprite is {size(kind)[0]}x{size(kind)[1]}, '
                         f'got {img.size[0]}x{img.size[1]}')
    px = img.load()
    key = (kind, has_stand)
    if key not in _MASKS:
        _MASKS[key] = picture_mask(kind, has_stand)
    mask = _MASKS[key]
    w, h = img.size
    for y in range(h):
        for x in range(w):
            if px[x, y] and (x, y) not in mask:
                c = k['cell']
                what = ('standing row' if y < c else
                        f'{FACINGS[y // c - 1]} frame {x // c}')
                raise ValueError(f'{path}: pixel ({x}, {y}) in the {what} is outside the picture '
                                 f'and must be colour 0, got {px[x, y]}')
    walk = bytearray()
    for f in range(16):
        facing, frame = divmod(f, 4)
        cx, cy = walk_cell(kind, facing, frame)
        for t in range(k['walk_tiles']):
            x, y = k['walk'][t]
            walk += encode_tile(px, cx + x, cy + y, path)
    stand = None
    if has_stand:
        stand = bytearray()
        for frame in range(3):
            for t in range(k['stand_tiles']):
                x, y = k['stand'][t]
                stand += encode_tile(px, frame * k['cell'] + x, y, path)
        stand = bytes(stand)
    return bytes(walk), stand


def decompress_file(path):
    orig = open(path, 'rb').read()
    buf = bytearray(0x400000)
    buf[:len(orig)] = orig
    return decompress(bytes(buf), 0xC00000)[0]


def rom_standing(rom, kind):
    k = KINDS[kind]
    n = k['stand_count'] * 3 * k['stand_tiles'] * TILE
    off = rom_offset(k['addr'])
    return rom[off:off + n]


def src_path(kind, name):
    return os.path.join(SRC_DIR, kind, name + '.png')


def unpack(force=False):
    rom_path = os.path.join(ROOT, 'fe4.sfc')
    rom = open(rom_path, 'rb').read()
    colours = VIEW_PALETTE
    n = 0
    for kind, i, name, fname in sprites():
        k = KINDS[kind]
        out = src_path(kind, name)
        if os.path.exists(out) and not force:
            sys.exit(f'{out} exists; use --force to overwrite')
        walk = decompress_file(os.path.join(WALK_DIR, fname + '.4bpp.comp'))
        stand = None
        if i < k['stand_count']:
            m = 3 * k['stand_tiles'] * TILE
            stand = rom_standing(rom, kind)[i * m:(i + 1) * m]
        os.makedirs(os.path.dirname(out), exist_ok=True)
        to_image(kind, walk, stand, colours, out).save(out)
        n += 1
    print(f'wrote {n} map sprite PNGs to {os.path.relpath(SRC_DIR, ROOT)}/')


# The colours the PNGs are drawn with: those of the VRAM-order sheets they
# replace (index 0 a dark blue so the transparent area stands out).
VIEW_PALETTE = [(0, 0, 115), (255, 255, 255), (0, 0, 0), (0, 0, 0), (172, 172, 156), (74, 74, 65),
                (180, 213, 255), (65, 74, 255), (16, 24, 82), (213, 115, 49), (123, 49, 24),
                (32, 32, 41), (222, 189, 148), (131, 98, 74), (8, 16, 32), (8, 8, 0)]


def build():
    """Pack the PNGs into the walking .4bpp files and the two standing sheets."""
    entries = sprites()
    missing = [n for kind, i, n, f in entries if not os.path.exists(src_path(kind, n))]
    if missing:
        sys.exit('tools/map_sprites.py: no gfx/map_sprites/{short,tall}/NAME.png for ' + ', '.join(missing))
    named = {f for kind, i, n, f in entries}
    orphans = sorted(os.path.basename(c)[:-len('.4bpp.comp')]
                     for c in glob.glob(os.path.join(WALK_DIR, '*.4bpp.comp'))
                     if os.path.basename(c)[:-len('.4bpp.comp')] not in named)
    if orphans:
        sys.exit('tools/map_sprites.py: no pointer CSV row for ' + ', '.join(orphans))
    os.makedirs(STAND_DIR, exist_ok=True)
    for kind in ('short', 'tall'):
        k = KINDS[kind]
        rows = [e for e in entries if e[0] == kind]
        sheet = os.path.join(STAND_DIR, k['sheet'] + '.4bpp')
        sheet_time = os.path.getmtime(sheet) if os.path.exists(sheet) else -1
        csv_time = os.path.getmtime(CSV[kind])
        stand_rows = [e for e in rows if e[1] < k['stand_count']]
        rebuild_sheet = (
            sheet_time < csv_time
            or sheet_time < os.path.getmtime(__file__)
            or any(os.path.getmtime(src_path(kind, n)) > sheet_time for _, _, n, _ in stand_rows)
        )
        stands = []
        for _, i, name, fname in rows:
            src = src_path(kind, name)
            out = os.path.join(WALK_DIR, fname + '.4bpp')
            t = os.path.getmtime(src)
            need_walk = not os.path.exists(out) or t > os.path.getmtime(out)
            need_stand = rebuild_sheet and i < k['stand_count']
            if not (need_walk or need_stand):
                continue
            try:
                walk, stand = from_image(kind, src, i < k['stand_count'])
            except ValueError as e:
                sys.exit(str(e))
            if need_walk:
                with open(out, 'wb') as f:
                    f.write(walk)
            if need_stand:
                stands.append(stand)
        if rebuild_sheet:
            with open(sheet, 'wb') as f:
                f.write(b''.join(stands))


def clean():
    for kind, i, name, fname in sprites():
        p = os.path.join(WALK_DIR, fname + '.4bpp')
        if os.path.exists(p):
            os.remove(p)
    for kind in KINDS:
        p = os.path.join(STAND_DIR, KINDS[kind]['sheet'] + '.4bpp')
        if os.path.exists(p):
            os.remove(p)


def self_test():
    rom = open(os.path.join(ROOT, 'fe4.sfc'), 'rb').read()
    entries = sprites()
    assert len(entries) == 97, f'expected 97 map sprites, found {len(entries)}'
    stand_sheets = {kind: bytearray() for kind in KINDS}
    with tempfile.TemporaryDirectory() as tmp:
        for kind, i, name, fname in entries:
            k = KINDS[kind]
            walk = decompress_file(os.path.join(WALK_DIR, fname + '.4bpp.comp'))
            has = i < k['stand_count']
            m = 3 * k['stand_tiles'] * TILE
            stand = rom_standing(rom, kind)[i * m:(i + 1) * m] if has else None
            p = os.path.join(tmp, name + '.png')
            to_image(kind, walk, stand, VIEW_PALETTE, name).save(p)
            assert from_image(kind, p, has) == (walk, stand), f'{name}: unpack/pack differs'
            committed = src_path(kind, name)
            assert os.path.exists(committed), f'missing {committed}'
            assert from_image(kind, committed, has) == (walk, stand), f'{name}: committed PNG differs'
            if has:
                stand_sheets[kind] += stand
        for kind in KINDS:
            assert bytes(stand_sheets[kind]) == rom_standing(rom, kind), f'{kind} standing sheet differs'

        # Edits: the shared centre cell of a short walking frame changes tiles 2
        # and 6 only; a standing pixel changes only that frame's tile; a tall
        # walking pixel changes the tile the 32x32 array draws there.
        soldier = src_path('short', 'Soldier')
        walk0, stand0 = from_image('short', soldier, True)
        img = Image.open(soldier).copy()
        px = img.load()
        cx, cy = walk_cell('short', 2, 1)                       # up, frame 1
        px[cx + 9, cy + 9] = (px[cx + 9, cy + 9] + 1) % 16      # centre cell
        px[2 * 24 + 4, 16] = (px[2 * 24 + 4, 16] + 1) % 16      # standing frame 2, tile 2
        e = os.path.join(tmp, 'edit.png')
        img.save(e)
        walk1, stand1 = from_image('short', e, True)
        changed = {t for t in range(160) if walk0[t * TILE:(t + 1) * TILE] != walk1[t * TILE:(t + 1) * TILE]}
        assert changed == {9 * 10 + 2, 9 * 10 + 6}, f'short centre edit changed tiles {changed}'
        changed = {t for t in range(12) if stand0[t * TILE:(t + 1) * TILE] != stand1[t * TILE:(t + 1) * TILE]}
        assert changed == {2 * 4 + 2}, f'standing edit changed tiles {changed}'
        comp = os.path.join(WALK_DIR, 'Soldier.4bpp.comp')
        lz = gfx.lz(walk1, comp)
        assert lz != open(comp, 'rb').read()
        buf = bytearray(0x400000)
        buf[:len(lz)] = lz
        assert decompress(bytes(buf), 0xC00000)[0] == walk1, 'recompressed stream differs'

        knight = src_path('tall', 'Cavalier')
        walk0, _ = from_image('tall', knight, True)
        img = Image.open(knight).copy()
        px = img.load()
        cx, cy = walk_cell('tall', 3, 0)                         # down, frame 0
        px[cx + 8, cy + 16] = (px[cx + 8, cy + 16] + 1) % 16     # third row, tile $25
        img.save(e)
        walk1, _ = from_image('tall', e, True)
        changed = {t for t in range(256) if walk0[t * TILE:(t + 1) * TILE] != walk1[t * TILE:(t + 1) * TILE]}
        assert changed == {12 * 16 + 5}, f'tall edit changed tiles {changed}'

        # Refusals: a pixel outside the picture (the never-written top row of a
        # tall standing frame, standing cell 3, the margin around a short
        # standing frame), a standing row on a sprite without standing frames,
        # mode, size and colour index.
        def refuses(kind, path, has, what):
            try:
                from_image(kind, path, has)
            except ValueError:
                return
            raise AssertionError(f'{what} should fail')

        for kind, name, has, (x, y) in (('tall', 'Cavalier', True, (8, 0)),
                                        ('short', 'Soldier', True, (3 * 24 + 1, 1)),
                                        ('short', 'Soldier', True, (0, 0)),
                                        ('short', 'ShortEmpty', False, (4, 8)),
                                        ('tall', 'TallEmpty', False, (8, 8))):
            img = Image.open(src_path(kind, name)).copy()
            img.putpixel((x, y), 1)
            img.save(e)
            refuses(kind, e, has, f'{name} pixel {x, y}')
        Image.new('RGB', size('short')).save(e)
        refuses('short', e, True, 'RGB')
        Image.new('P', (96, 96)).save(e)
        refuses('short', e, True, 'wrong size')
        img = Image.new('P', size('short'))
        img.putpalette([0] * 768)
        img.putpixel((4, 8), 16)
        img.save(e)
        refuses('short', e, True, 'colour 16')
    print('97 of 97 map sprites unpack and pack byte-identical (committed PNGs checked); '
          'both standing sheets match fe4.sfc; edit, LZ and refusal checks passed')


def main():
    ap = argparse.ArgumentParser(description=__doc__.split('\n')[0])
    ap.add_argument('--self-test', action='store_true')
    sub = ap.add_subparsers(dest='cmd')
    p = sub.add_parser('unpack')
    p.add_argument('--force', action='store_true')
    sub.add_parser('build')
    sub.add_parser('clean')
    args = ap.parse_args()
    if args.self_test:
        self_test()
    elif args.cmd == 'unpack':
        unpack(args.force)
    elif args.cmd == 'build':
        build()
    elif args.cmd == 'clean':
        clean()
    else:
        ap.print_help()


if __name__ == '__main__':
    main()
