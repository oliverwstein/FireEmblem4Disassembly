#!/usr/bin/env python3
"""Map battle sprite graphics as frame-grid PNGs, and previews that step their scripts.

usage: tools/map_battle_sprites.py unpack [--force]
       tools/map_battle_sprites.py build
       tools/map_battle_sprites.py clean
       tools/map_battle_sprites.py rows
       tools/map_battle_sprites.py preview ROW OUT_DIR [--facing F] [--weapon W] [--item ITEM]
       tools/map_battle_sprites.py --self-test

A row of aBattleMapSpriteData (engine/battle/map_battle.asm) is a battle
sprite class: for each of 8 facings, the sprite data stream (aMapBattle*Layout*,
source in gfx/map_battle/, tools/map_battle_layouts.py) and a graphics stream,
then a byte, wSideTallSprite (1 for the mounted and flying rows). Facing 0 is
left and they go clockwise: 1 up-left, 2 up, 3 up-right, 4 right, 5 down-right,
6 down, 7 down-left (aMapBattleFacingOffsets: the attacker's position less the
defender's picks it).

The 500 graphics streams the rows name each decompress to $2000 bytes at
aDecompressionBuffer (+ $2000 for side 1):

- $0000-$09FF: tile blocks. rlUploadMapBattleSideTiles uploads $400 bytes to
  sprite tiles $40-$5F ($60-$7F for side 1) from the offset its weapon type
  gives (aMapBattleWeaponTypeTileOffsets): $000 sword, lance and axe, $400 bow,
  $600 staff or tome. The bow and magic blocks overlap.
- $0A00-$0FFF: zero in every stream; nothing reads it.
- $1000 on: 8 frames (aMapBattleSpriteDMATable), short $140 bytes and tall
  $200, the format of a walking map sprite frame (tools/map_sprites.py).
  rlUploadMapBattleSideFrame and command $03 put one at tiles $20.. and $30..
  ($28.. and $38.. for side 1). The 8 short frames end at $1A00; the rest of
  a short stream ($1A00-$1FFF, 48 tiles) is zero or a repeated filler tile.

The authored file is gfx/map_battle/sheets/NAME.png (NAME is the label without
g4bppcMapBattle), indexed, colours 0-15 (the palette is for viewing only):

- row 0: frames 0-7 in 24x24 (short, 192 wide) or 32x32 (tall, 256 wide)
  cells, mapped to tiles as map_sprites.py maps a walking frame (short
  frames' tiles $22 and $31 hold the same pixels in every stream; the centre
  cell writes both).
- under it, $0000-$09FF as 5 rows of 16 tiles (128 pixels wide), 16 tiles a
  VRAM row as they are uploaded, so 16x16 sprites read whole: rows 0-1 are
  the sword/lance/axe block, rows 2-3 the bow block, rows 3-4 the magic block.
- short sheets only: $1A00-$1FFF as 3 more rows of 16 tiles.

Pixels right of the 128-pixel tile rows must be colour 0.

build packs every PNG newer than its NAME.4bpp (beside NAME.4bpp.comp in
gfx/build/*/) for gfx.py lz, and fails when a row's graphics stream has no
PNG. unpack writes the PNGs from the .comp streams.

preview steps the scripts of one row (rows lists them) as the active sprite
engine runs them, for side 0 (the attacker), and writes a GIF and a frame strip
for each facing, weapon block and script (wait, dodge, strike, ranged strike).
It reads the sprite data from gfx/map_battle/*.asm (assembled with 64tass) and
the graphics from gfx/map_battle/sheets/, so it shows edits before a build.
What it models:

- commands $0E (frame from the block's table, for Duration frames), $12
  (wait), $03 (upload graphics frame N), $19 (move); the commands that wait
  for the other side, a round or a magic effect go on at once, and $04 (the
  strike lands) is marked in the strip. The script stops at $01 or a jump to
  another script ($09-$0C).
- tiles as rlPushToOAMBufferDualTileBase reads them: below $20 as they are,
  $20-$3F plus the sprite's tile base, $40 and up plus its high base. Side 0's
  main sprite has both at 0; a tall row's aux sprite (created for weapon types
  0-3) has tile base $20, so its $20-$3F are the tile block. Tiles below $20
  are not drawn.
- the weapon in hand: rlUploadMapBattleWeaponIcon writes the item's icon
  (aMapBattleWeaponIcons: the low byte times $100 into
  g4bppcMapBattleWeaponIcons) over tiles $40-$43 and $50-$53, and its two
  colours (aMapBattleWeaponIconColors) into colours 2 and 3. --item ITEM picks
  the item (an ID or a name from data/item/ItemData.csv); the default is the
  iron weapon of the block's type, and none for staves and tomes.
- the aux sprite (higher slot, so earlier in OAM) in front of the main one;
  in a sprite array, earlier entries in front.
"""
import argparse
import glob
import os
import re
import sys
import tempfile

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from decompress import decompress
import gfx
import map_sprites as ms
import map_battle_layouts as mbl

try:
    from PIL import Image
except ImportError:
    sys.exit('tools/map_battle_sprites.py needs Pillow: pip3 install pillow')

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SHEET_DIR = os.path.join(ROOT, 'gfx', 'map_battle', 'sheets')
LAYOUT_DIR = os.path.join(ROOT, 'gfx', 'map_battle')
ENGINE = os.path.join(ROOT, 'engine', 'battle', 'map_battle.asm')
PREFIX = 'g4bppcMapBattle'
TILE = 32
SIZE = 0x2000
FRAMES_AT = 0x1000
BLOCK_BYTES = 0xA00          # $0000-$09FF: the tile blocks
BLOCK_ROWS = BLOCK_BYTES // (16 * TILE)
TAIL_AT = 0x1A00             # short streams: after the 8 frames
TAIL_ROWS = (SIZE - TAIL_AT) // (16 * TILE)
WEAPON_BLOCK = [0x000, 0x000, 0x000, 0x400, 0x600]
WEAPONS = mbl.WEAPONS
FACINGS = ['Left', 'UpLeft', 'Up', 'UpRight', 'Right', 'DownRight', 'Down', 'DownLeft']
SCRIPTS = [('Wait', 'WaitAux'), ('Dodge', 'DodgeAux'), ('Strike', 'StrikeAux'), ('Ranged', 'RangedAux')]


def kind(tall):
    return 'tall' if tall else 'short'


def frame_bytes(tall):
    return 0x200 if tall else 0x140


def rows():
    """[(name, [(layout label, graphics label)] * 8, tall)] from aBattleMapSpriteData."""
    src = open(ENGINE, encoding='utf-8').read()
    start = src.index('aBattleMapSpriteData ; ')
    body = src[start:src.index('.endsection', start)]
    out, name, longs = [], None, []
    for line in body.split('\n')[1:]:
        s = line.strip()
        if s.startswith('; ') and not longs:
            name = s[2:].strip()
        elif s.startswith('.long'):
            longs += [x.strip() for x in s[5:].split(',')]
        elif s.startswith('.byte'):
            assert len(longs) == 16, f'{name}: {len(longs)} pointers'
            out.append((name, [(longs[2 * k], longs[2 * k + 1]) for k in range(8)], int(s.split()[1], 0)))
            longs = []
    return out


def sheets():
    """{graphics label: tall} for every graphics stream a row names."""
    out = {}
    for name, pairs, tall in rows():
        for _, g in pairs:
            assert out.get(g, tall) == tall, f'{g} is used by short and tall rows'
            out[g] = tall
    return out


def comp_path(label):
    found = glob.glob(os.path.join(ROOT, 'gfx', 'build', '*', label + '.4bpp.comp'))
    if len(found) != 1:
        sys.exit(f'{label}: expected one .4bpp.comp in gfx/build/*/, found {len(found)}')
    return found[0]


def src_path(label):
    assert label.startswith(PREFIX), label
    return os.path.join(SHEET_DIR, label[len(PREFIX):] + '.png')


def decompress_file(path):
    orig = open(path, 'rb').read()
    buf = bytearray(0x400000)
    buf[:len(orig)] = orig
    return decompress(bytes(buf), 0xC00000)[0]


def sheet_size(tall):
    c = 32 if tall else 24
    return 8 * c, c + 8 * (BLOCK_ROWS + (0 if tall else TAIL_ROWS))


def put_tile(px, raw, ox, oy):
    for y, row in enumerate(ms.decode_tile(raw)):
        for x, v in enumerate(row):
            px[ox + x, oy + y] = v


def to_image(data, tall, colours, where=''):
    if len(data) != SIZE:
        raise ValueError(f'{where}: {len(data):#x} bytes, expected {SIZE:#x}')
    if any(data[BLOCK_BYTES:FRAMES_AT]):
        raise ValueError(f'{where}: bytes $A00-$FFF are not zero; the PNG cannot hold them')
    k = ms.KINDS[kind(tall)]
    img = Image.new('P', sheet_size(tall), 0)
    flat = [v for c in colours[:16] for v in c]
    img.putpalette(flat + [0] * (768 - len(flat)))
    px = img.load()
    fb, n = frame_bytes(tall), k['walk_tiles']
    for f in range(8):
        fr = data[FRAMES_AT + f * fb:FRAMES_AT + (f + 1) * fb]
        tiles = [fr[t * TILE:(t + 1) * TILE] for t in range(n)]
        if not tall and tiles[2] != tiles[6]:
            raise ValueError(f'{where}: frame {f}: tiles $22 and $31 differ')
        for t, (x, y) in k['walk'].items():
            put_tile(px, tiles[t], f * k['cell'] + x, y)
    top = k['cell']
    for t in range(BLOCK_BYTES // TILE):
        put_tile(px, data[t * TILE:(t + 1) * TILE], (t % 16) * 8, top + (t // 16) * 8)
    if not tall:
        top += BLOCK_ROWS * 8
        for t in range((SIZE - TAIL_AT) // TILE):
            put_tile(px, data[TAIL_AT + t * TILE:TAIL_AT + (t + 1) * TILE], (t % 16) * 8, top + (t // 16) * 8)
    return img


def from_image(path, tall):
    k = ms.KINDS[kind(tall)]
    img = Image.open(path)
    if img.mode != 'P':
        raise ValueError(f'{path}: not an indexed PNG (mode {img.mode}); save it with a palette')
    if img.size != sheet_size(tall):
        w, h = sheet_size(tall)
        raise ValueError(f'{path}: a {kind(tall)} map battle sheet is {w}x{h}, got {img.size[0]}x{img.size[1]}')
    px = img.load()
    w, h = img.size
    for y in range(k['cell'], h):
        for x in range(128, w):
            if px[x, y]:
                raise ValueError(f'{path}: pixel ({x}, {y}) is right of the tile rows and must be colour 0')
    out = bytearray(SIZE)
    top = k['cell']
    for t in range(BLOCK_BYTES // TILE):
        out[t * TILE:(t + 1) * TILE] = ms.encode_tile(px, (t % 16) * 8, top + (t // 16) * 8, path)
    fb = frame_bytes(tall)
    for f in range(8):
        for t in range(k['walk_tiles']):
            x, y = k['walk'][t]
            a = FRAMES_AT + f * fb + t * TILE
            out[a:a + TILE] = ms.encode_tile(px, f * k['cell'] + x, y, path)
    if not tall:
        top += BLOCK_ROWS * 8
        for t in range((SIZE - TAIL_AT) // TILE):
            a = TAIL_AT + t * TILE
            out[a:a + TILE] = ms.encode_tile(px, (t % 16) * 8, top + (t // 16) * 8, path)
    return bytes(out)


def unpack(force=False):
    n = 0
    os.makedirs(SHEET_DIR, exist_ok=True)
    for label, tall in sorted(sheets().items()):
        out = src_path(label)
        if os.path.exists(out) and not force:
            sys.exit(f'{out} exists; use --force to overwrite')
        to_image(decompress_file(comp_path(label)), tall, ms.VIEW_PALETTE, label).save(out)
        n += 1
    print(f'wrote {n} map battle sheets to {os.path.relpath(SHEET_DIR, ROOT)}/')


def build():
    s = sheets()
    missing = [src_path(l) for l in s if not os.path.exists(src_path(l))]
    if missing:
        sys.exit('tools/map_battle_sprites.py: missing ' + ', '.join(os.path.relpath(m, ROOT) for m in missing))
    for label, tall in s.items():
        src = src_path(label)
        out = comp_path(label)[:-len('.comp')]
        if not os.path.exists(out) or os.path.getmtime(src) > os.path.getmtime(out):
            try:
                data = from_image(src, tall)
            except ValueError as e:
                sys.exit(str(e))
            with open(out, 'wb') as f:
                f.write(data)


def clean():
    for label in sheets():
        p = comp_path(label)[:-len('.comp')]
        if os.path.exists(p):
            os.remove(p)


# --- preview -----------------------------------------------------------------

def layout_bytes(label, cache={}):
    """The sprite data of a layout, assembled from gfx/map_battle/LABEL.asm."""
    if label not in cache:
        with tempfile.TemporaryDirectory() as tmp:
            cache[label] = mbl.assemble(os.path.join(LAYOUT_DIR, label + '.asm'), os.path.join(tmp, 'out.bin'))
    return cache[label]


def run_script(cmds):
    """Steps of one script: [(duration, frame index or None, graphics frame, x, y, strike)]."""
    steps, frame, gfx_frame, x, y, strike = [], None, 0, 0, 0, False
    for _, op, args in cmds or []:
        if op == 0x0E:
            steps.append((max(args[0], 1), args[1], gfx_frame, x, y, strike))
            frame, strike = args[1], False
        elif op == 0x12:
            steps.append((max(args[0], 1), frame, gfx_frame, x, y, strike))
            strike = False
        elif op == 0x03:
            gfx_frame = args[0]
        elif op == 0x19:
            dx, dy = (v - 256 if v >= 128 else v for v in args)
            x, y = x + dx, y + dy
        elif op == 0x04:
            strike = True
    return steps


DEFAULT_ITEMS = ['IronSword', 'IronLance', 'IronAxe', 'IronBow', None]
ICON_SHEET = os.path.join(ROOT, 'gfx', 'build', 'A08000', 'g4bppcMapBattleWeaponIcons.4bpp.png')


def asm_words(label):
    """The .word values of a table in map_battle.asm."""
    src = open(ENGINE, encoding='utf-8').read()
    start = src.index(label + ' ; ')
    body = src[start:src.index('.endsection', start)]
    return [int(v.strip().lstrip('$'), 16) for line in body.split('\n') if line.strip().startswith('.word')
            for v in line.strip()[5:].split(',')]


def item_id(item):
    names = [l.split(',')[0] for l in open(os.path.join(ROOT, 'data', 'item', 'ItemData.csv'))][1:]
    if isinstance(item, int) or str(item).lstrip('-').isdigit():
        return int(item)
    if item not in names:
        sys.exit(f'no item {item} in data/item/ItemData.csv')
    return names.index(item)


def weapon_icon(item):
    """(8 tiles: $40-$43 then $50-$53, colours 2 and 3 as RGB) for an item, or None."""
    if item is None:
        return None
    i = item_id(item)
    if not (i < 0x3A or 0x7A <= i < 0x7D):
        return None
    if i >= 0x7A:
        i = i - 0x7A + 0x3A
    entry = asm_words('aMapBattleWeaponIcons')[i]
    icons = gfx.png_to_4bpp(ICON_SHEET)
    off = (entry & 0xFF) << 8
    colours = asm_words('aMapBattleWeaponIconColors')
    c = [tuple((colours[(entry >> 8) * 2 + k] >> sh & 31) * 255 // 31 for sh in (0, 5, 10)) for k in (0, 1)]
    return icons[off:off + 0x100], c


def vram(sheet, tall, weapon, gfx_frame, icon=None):
    """Sprite tiles $20-$5F of side 0 as {tile: 32 bytes}."""
    tiles = {}
    blk = WEAPON_BLOCK[weapon]
    for t in range(32):
        tiles[0x40 + t] = sheet[blk + t * TILE:blk + (t + 1) * TILE]
    if icon is not None:
        for t in range(8):
            tiles[(0x40, 0x50)[t // 4] + t % 4] = icon[0][t * TILE:(t + 1) * TILE]
    fb = frame_bytes(tall)
    fr = sheet[FRAMES_AT + gfx_frame * fb:FRAMES_AT + (gfx_frame + 1) * fb]
    half = fb // 2 // TILE
    for t in range(half):
        tiles[0x20 + t] = fr[t * TILE:(t + 1) * TILE]
        tiles[0x30 + t] = fr[(half + t) * TILE:(half + t + 1) * TILE]
    return tiles


def draw_array(canvas, entries, tiles, base, high, ox, oy):
    """Draw a sprite array, last entry first so earlier entries end up in front."""
    px = canvas.load()
    W, H = canvas.size
    for e in reversed(entries):
        n = 2 if e['large'] else 1
        for ty in range(n):
            for tx in range(n):
                t = e['tile'] + ty * 16 + tx
                t = t if t < 0x20 else t + (base if t < 0x40 else high)
                raw = tiles.get(t)
                if raw is None:
                    continue
                dx = (n - 1 - tx) if e['hflip'] else tx
                dy = (n - 1 - ty) if e['vflip'] else ty
                for yy, row in enumerate(ms.decode_tile(raw)):
                    for xx, v in enumerate(row):
                        if not v:
                            continue
                        sx = 7 - xx if e['hflip'] else xx
                        sy = 7 - yy if e['vflip'] else yy
                        X, Y = ox + e['x'] + dx * 8 + sx, oy + e['y'] + dy * 8 + sy
                        if 0 <= X < W and 0 <= Y < H:
                            px[X, Y] = v


def timeline(main, aux):
    """Merge two step lists into [(duration, main step, aux step)]."""
    def expand(steps):
        out = []
        for s in steps:
            out += [s] * s[0]
        return out
    a, b = expand(main), expand(aux)
    n = max(len(a), len(b))
    a += [a[-1]] * (n - len(a)) if a else [None] * n
    b += [b[-1]] * (n - len(b)) if b else [None] * n
    merged = []
    for pair in zip(a, b):
        if merged and merged[-1][1] is pair[0] and merged[-1][2] is pair[1]:
            merged[-1][0] += 1
        else:
            merged.append([1, pair[0], pair[1]])
    return merged


CANVAS = (64, 56)
ORIGIN = (32, 36)


def render_script(layout, block, slot, sheet, tall, weapon, icon=None):
    """[(duration, Image, strike)] for one script pair of a block, or [] if it has none."""
    main_at = block['slots'].get(slot[0])
    if main_at is None:
        return []
    aux_at = block['slots'].get(slot[1]) if tall and weapon < 4 else None
    main = run_script(block['scripts'].get(main_at))
    aux = run_script(block['scripts'].get(aux_at)) if aux_at is not None else []
    frames = [mbl.parse_frame(layout, f) for f in block['frames']]
    out = []
    for dur, m, a in timeline(main, aux):
        img = Image.new('P', CANVAS, 0)
        pal = list(ms.VIEW_PALETTE)
        if icon is not None:
            pal[2], pal[3] = icon[1]
        img.putpalette([v for c in pal for v in c] + [0] * 720)
        for step, base in ((m, 0x00), (a, 0x20)):
            if step is None or step[1] is None or step[1] >= len(frames):
                continue
            tiles = vram(sheet, tall, weapon, step[2], icon)
            draw_array(img, frames[step[1]], tiles, base, 0x00, ORIGIN[0] + step[3], ORIGIN[1] + step[4])
        strike = any(s is not None and s[5] for s in (m, a))
        out.append((dur, img, strike))
    return out


def preview(row_name, out_dir, facing=None, weapon=None, item=None):
    matches = [r for r in rows() if r[0] == row_name]
    if not matches:
        sys.exit(f'no row {row_name}; tools/map_battle_sprites.py rows lists them')
    name, pairs, tall = matches[0]
    os.makedirs(out_dir, exist_ok=True)
    written = 0
    for f, (layout_label, gfx_label) in enumerate(pairs):
        if facing is not None and f != facing:
            continue
        layout = layout_bytes(layout_label)
        parsed = mbl.parse(layout)
        sheet = from_image(src_path(gfx_label), tall)
        for w, b in enumerate(parsed['header']):
            if b is None or (weapon is not None and w != weapon):
                continue
            block = parsed['blocks'][b]
            icon = weapon_icon(item if item is not None else DEFAULT_ITEMS[w])
            for slot in SCRIPTS:
                frames = render_script(layout, block, slot, sheet, tall, w, icon)
                if not frames:
                    continue
                stem = os.path.join(out_dir, f'{name}_{f}{FACINGS[f]}_{WEAPONS[w]}_{slot[0]}')
                bg = (128, 128, 128)
                rgb = []
                for dur, img, strike in frames:
                    im = Image.new('RGB', CANVAS, bg)
                    im.paste(img.convert('RGB'), mask=img.point(lambda v: 255 if v else 0, '1'))
                    if strike:
                        for i in range(CANVAS[0]):
                            im.putpixel((i, CANVAS[1] - 1), (255, 0, 0))
                    rgb.append((dur, im.resize((CANVAS[0] * 3, CANVAS[1] * 3), Image.NEAREST)))
                rgb[0][1].save(stem + '.gif', save_all=True, append_images=[i for _, i in rgb[1:]],
                               duration=[max(20, round(d * 1000 / 60)) for d, _ in rgb], loop=0, disposal=1)
                strip = Image.new('RGB', (CANVAS[0] * len(frames), CANVAS[1] + 8), bg)
                for i, (dur, img, strike) in enumerate(frames):
                    im = Image.new('RGB', CANVAS, bg)
                    im.paste(img.convert('RGB'), mask=img.point(lambda v: 255 if v else 0, '1'))
                    strip.paste(im, (i * CANVAS[0], 0))
                    # duration as a bar under the frame (one pixel per frame, capped)
                    for x in range(min(dur, CANVAS[0] - 2)):
                        strip.putpixel((i * CANVAS[0] + 1 + x, CANVAS[1] + 3), (255, 0, 0) if strike else (0, 0, 0))
                strip.save(stem + '.png')
                written += 1
    print(f'wrote {written} previews of {name} to {out_dir}')
    return written


# --- self-test ---------------------------------------------------------------

def self_test():
    s = sheets()
    assert len(s) == 500, f'expected 500 map battle sheets, found {len(s)}'
    with tempfile.TemporaryDirectory() as tmp:
        for label, tall in s.items():
            raw = decompress_file(comp_path(label))
            p = os.path.join(tmp, 'x.png')
            to_image(raw, tall, ms.VIEW_PALETTE, label).save(p)
            assert from_image(p, tall) == raw, f'{label}: unpack/pack differs'
            assert from_image(src_path(label), tall) == raw, f'{label}: committed PNG differs'

        # A pixel in a short frame's centre cell changes tiles $22 and $31 of that
        # frame only; a pixel in tile row 2 changes the bow block's first tile.
        label = 'g4bppcMapBattleSoldier0'
        raw = from_image(src_path(label), False)
        img = Image.open(src_path(label)).copy()
        px = img.load()
        px[3 * 24 + 9, 9] = (px[3 * 24 + 9, 9] + 1) % 16
        px[0, 24 + 16] = (px[0, 24 + 16] + 1) % 16
        e = os.path.join(tmp, 'e.png')
        img.save(e)
        edited = from_image(e, False)
        changed = {i // TILE for i in range(SIZE) if raw[i] != edited[i]}
        f3 = (FRAMES_AT + 3 * 0x140) // TILE
        assert changed == {f3 + 2, f3 + 6, 0x400 // TILE}, f'edit changed tiles {sorted(changed)}'
        lz = gfx.lz(edited, comp_path(label))
        buf = bytearray(0x400000)
        buf[:len(lz)] = lz
        assert decompress(bytes(buf), 0xC00000)[0] == edited

        # Refusals: a pixel right of the tile rows, the wrong size.
        img = Image.open(src_path(label)).copy()
        img.putpixel((150, 30), 1)
        img.save(e)
        try:
            from_image(e, False)
        except ValueError:
            pass
        else:
            raise AssertionError('a pixel right of the tile rows should fail')
        try:
            from_image(src_path(label), True)
        except ValueError:
            pass
        else:
            raise AssertionError('a short sheet read as tall should fail')

        # The preview steps every script of two rows (short and tall) without
        # error, and draws something for each.
        for row in ('Soldier', 'Cavalier'):
            n = preview(row, os.path.join(tmp, row), facing=0)
            assert n > 0, f'{row}: no previews'
    print('500 of 500 map battle sheets unpack and pack byte-identical (committed PNGs checked); '
          'edit, LZ, refusal and preview checks passed')


def main():
    ap = argparse.ArgumentParser(description=__doc__.split('\n')[0])
    ap.add_argument('--self-test', action='store_true')
    sub = ap.add_subparsers(dest='cmd')
    p = sub.add_parser('unpack')
    p.add_argument('--force', action='store_true')
    sub.add_parser('build')
    sub.add_parser('clean')
    sub.add_parser('rows')
    p = sub.add_parser('preview')
    p.add_argument('row')
    p.add_argument('out_dir')
    p.add_argument('--facing', type=int)
    p.add_argument('--weapon', type=int)
    p.add_argument('--item')
    args = ap.parse_args()
    if args.self_test:
        self_test()
    elif args.cmd == 'unpack':
        unpack(args.force)
    elif args.cmd == 'build':
        build()
    elif args.cmd == 'clean':
        clean()
    elif args.cmd == 'rows':
        for name, pairs, tall in rows():
            print(f'{name:24} {"tall" if tall else "short"}')
    elif args.cmd == 'preview':
        preview(args.row, args.out_dir, args.facing, args.weapon, args.item)
    else:
        ap.print_help()


if __name__ == '__main__':
    main()
