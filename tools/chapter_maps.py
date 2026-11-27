#!/usr/bin/env python3
"""Chapter maps (aChapterMapPointers) as CSV source, and back; previews.

usage: tools/chapter_maps.py decode CHAPTER|all
       tools/chapter_maps.py build
       tools/chapter_maps.py render CHAPTER|all OUT_DIR
       tools/chapter_maps.py --self-test

Each chapter's entry in engine/map/chapter_maps.asm names three compressed data
streams in gfx/compressed/C70C80/ (besides its tile graphics and palettes). Each
has one CSV source beside it, which build turns into the NAME.bin that gfx.py lz
compresses; ./build.sh runs build. Chapter 2 uses the Prologue's tile entries and
terrain, and the final chapter Chapter 5's.

- acChapterMap*Layout.csv: the map, 64 rows of 64 words (aMapData), in hex. The
  low ten bits are the tile ID (wMapTileIDMask, $03FF); bits 10-15 are the area
  the tile belongs to, which the chapter can close to player units
  (wAreaRestrictionBitfield). Maps narrower or shorter than 64 tiles leave the
  rest unused.
- acChapterMap*TileEntries.csv: tile IDs 0-255, each four 8x8 BG tilemap
  entries (decompressed to $7F0000; IDs from 256 come from
  gfx/map/BaseMapTileEntries.bin). Columns in stored order: top left, bottom
  left, top right, bottom right. An entry is TILE:PALETTE (hex tile number,
  palette 0-7) followed by any of p (priority), h and v (flips): 0A3:2, 1C0:3hv.
- acChapterMap*Terrain.csv: the terrain of each tile ID 0-1023
  (aTerrainTileset), by its name in include/Terrain.h, or in hex for values no
  name covers ($1A and up occur; what reads them is not yet traced).

decode writes the CSVs from the .bin files (a one-time extraction; the CSVs are
the source after that). render draws a chapter's map from the built .bin and
.4bpp files and the palettes in the ROM. --self-test decodes and encodes every
stream from its committed .comp and compares bytes, checks that the committed
CSVs encode to the same bytes, and renders the Prologue.
"""
import argparse
import csv
import os
import re
import struct
import sys
import tempfile

from PIL import Image

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from asmlib import offset
from gfx import bgr555

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


def load_labels():
    labels = {}
    with open(os.path.join(ROOT, 'labels.txt'), encoding='utf-8') as f:
        for line in f:
            parts = line.split()
            if len(parts) == 3 and ':' not in parts[2]:
                labels.setdefault(parts[2].lstrip('.'), int(parts[1], 16))
    return labels


def parse_chapter_maps():
    """Parse aChapterMap* entries from engine/map/chapter_maps.asm."""
    text = open(os.path.join(ROOT, 'engine/map/chapter_maps.asm'), encoding='utf-8').read()
    chapters = {}
    pat = re.compile(
        r'^\s+(aChapterMap(\w+))\s*;\s*[0-9A-F]{2}/[0-9A-F]{4}\s*\n\s*\n'
        r'\s+\.long\s+(\w+),\s*(\w+),\s*(\w+),\s*(\w+)\s*\n'
        r'\s+\.word\s+([^\n]+)\n'
        r'\s+\.long\s+(\w+)',
        re.M,
    )
    for m in pat.finditer(text):
        name = m.group(2)
        chapters[name] = {
            'name': name,
            'layout': m.group(3),
            'tile_entries': m.group(4),
            'tiles': m.group(5),
            'palette': m.group(6),
            'words': m.group(7).strip(),
            'terrain': m.group(8),
        }
    return chapters


def bin_path(label):
    return os.path.join(ROOT, 'gfx/compressed/C70C80', f'{label}.bin')


def bpp_path(label):
    return os.path.join(ROOT, 'gfx/compressed/C70C80', f'{label}.4bpp')


def decode_4bpp_tiles(raw):
    """Decode SNES 4bpp tile bytes into a list of 8x8 color-index lists."""
    tiles = []
    for t in range(0, len(raw), 32):
        b = raw[t:t + 32]
        px = [0] * 64
        for y in range(8):
            p0, p1, p2, p3 = b[2 * y], b[2 * y + 1], b[16 + 2 * y], b[16 + 2 * y + 1]
            for x in range(8):
                s = 7 - x
                px[y * 8 + x] = ((p0 >> s) & 1) | (((p1 >> s) & 1) << 1) | (((p2 >> s) & 1) << 2) | (((p3 >> s) & 1) << 3)
        tiles.append(px)
    return tiles


def terrain_names():
    names = {}
    for line in open(os.path.join(ROOT, 'include/Terrain.h'), encoding='utf-8'):
        m = re.match(r'\s*(Terrain\w+)\s*=\s*\$([0-9A-F]+)', line)
        if m:
            names[int(m.group(2), 16)] = m.group(1)
    return names


def entry_text(v):
    flags = ('p' if v & 0x2000 else '') + ('h' if v & 0x4000 else '') + ('v' if v & 0x8000 else '')
    return f'{v & 0x3FF:03X}:{(v >> 10) & 7}{flags}'


def entry_value(text):
    m = re.fullmatch(r'([0-9A-Fa-f]{1,3}):([0-7])([phv]*)', text.strip())
    if not m:
        raise ValueError(f'bad tilemap entry {text!r}')
    tile = int(m.group(1), 16)
    if tile > 0x3FF:
        raise ValueError(f'tile index ${tile:X} exceeds 10-bit max ($3FF) in {text!r}')
    v = tile | int(m.group(2)) << 10
    for c, bit in (('p', 0x2000), ('h', 0x4000), ('v', 0x8000)):
        if c in m.group(3):
            v |= bit
    return v


def layout_csv(raw):
    words = struct.unpack(f'<{len(raw) // 2}H', raw)
    return ''.join(','.join(f'{v:04X}' for v in words[r:r + 64]) + '\n' for r in range(0, len(words), 64))


def layout_bin(text):
    rows = list(csv.reader(text.splitlines()))
    if len(rows) != 64:
        raise ValueError(f'layout must have 64 rows, got {len(rows)}')
    data = bytearray()
    for r, row in enumerate(rows):
        if len(row) != 64:
            raise ValueError(f'layout row {r} must have 64 columns, got {len(row)}')
        for c, cell in enumerate(row):
            val = int(cell, 16)
            if not 0 <= val <= 0xFFFF:
                raise ValueError(f'layout word out of range at ({r}, {c}): {cell!r}')
            data += struct.pack('<H', val)
    return bytes(data)


def entries_csv(raw):
    out = ['tile_id,top_left,bottom_left,top_right,bottom_right']
    for i in range(0, len(raw), 8):
        out.append(f'{i // 8},' + ','.join(entry_text(v) for v in struct.unpack_from('<4H', raw, i)))
    return '\n'.join(out) + '\n'


def entries_bin(text):
    rows = list(csv.reader(text.splitlines()))[1:]
    if len(rows) != 256:
        raise ValueError(f'tile entries must have 256 rows, got {len(rows)}')
    data = bytearray()
    for n, row in enumerate(rows):
        if len(row) != 5:
            raise ValueError(f'tile entry row {n} must have 5 columns, got {len(row)}')
        if int(row[0]) != n:
            raise ValueError(f'tile ID {row[0]} out of order (expected {n})')
        data += struct.pack('<4H', *(entry_value(c) for c in row[1:5]))
    return bytes(data)


def terrain_csv(raw):
    names = terrain_names()
    return 'tile_id,terrain\n' + ''.join(f'{i},{names.get(b, f"${b:02X}")}\n' for i, b in enumerate(raw))


def terrain_bin(text):
    values = {n: v for v, n in terrain_names().items()}
    rows = list(csv.reader(text.splitlines()))[1:]
    if len(rows) != 1024:
        raise ValueError(f'terrain table must have 1024 rows, got {len(rows)}')
    data = bytearray()
    for n, row in enumerate(rows):
        if len(row) != 2:
            raise ValueError(f'terrain row {n} must have 2 columns, got {len(row)}')
        tid, t = row[0].strip(), row[1].strip()
        if int(tid) != n:
            raise ValueError(f'tile ID {tid} out of order (expected {n})')
        if t.startswith('$'):
            val = int(t[1:], 16)
            if not 0 <= val <= 0xFF:
                raise ValueError(f'terrain value out of range at tile {n}: {t!r}')
            data.append(val)
        else:
            if t not in values:
                raise ValueError(f'unknown terrain {t!r} at tile {n}')
            data.append(values[t])
    return bytes(data)


KINDS = {'Layout': (layout_csv, layout_bin), 'TileEntries': (entries_csv, entries_bin),
         'Terrain': (terrain_csv, terrain_bin)}


def kind_of(label):
    return next(k for k in KINDS if label.endswith(k))


def stream_labels():
    labels = set()
    for ch in parse_chapter_maps().values():
        labels |= {ch['layout'], ch['tile_entries'], ch['terrain']}
    return sorted(labels)


def decode(label):
    raw = open(bin_path(label), 'rb').read()
    open(bin_path(label)[:-4] + '.csv', 'w', encoding='utf-8').write(KINDS[kind_of(label)][0](raw))


def build():
    terrain_h = os.path.join(ROOT, 'include/Terrain.h')
    terrain_h_mtime = os.path.getmtime(terrain_h)
    for label in stream_labels():
        kind = kind_of(label)
        src, out = bin_path(label)[:-4] + '.csv', bin_path(label)
        src_mtime = os.path.getmtime(src)
        if kind == 'Terrain':
            src_mtime = max(src_mtime, terrain_h_mtime)
        if not os.path.exists(out) or src_mtime > os.path.getmtime(out):
            with open(src, encoding='utf-8') as f:
                data = KINDS[kind][1](f.read())
            with open(out, 'wb') as f:
                f.write(data)


def render_chapter(ch, rom, labels, base_tiles, out_png):
    pal_addr = labels[ch['palette']]
    pal_off = offset(pal_addr)
    # 7 BG palettes (BG palettes 1-7); BG palette 0 is black/transparent fallback.
    palettes = [[(0, 0, 0)] * 16]
    for p in range(7):
        palettes.append(bgr555(rom[pal_off + p * 32:pal_off + (p + 1) * 32]))

    chap_tiles = decode_4bpp_tiles(open(bpp_path(ch['tiles']), 'rb').read())
    all_tiles = base_tiles + chap_tiles

    layout_raw = open(bin_path(ch['layout']), 'rb').read()
    entries_raw = open(bin_path(ch['tile_entries']), 'rb').read()
    base_entries_raw = open(os.path.join(ROOT, 'gfx/map/BaseMapTileEntries.bin'), 'rb').read()
    layout_words = struct.unpack(f'<{len(layout_raw) // 2}H', layout_raw)
    metatiles = [struct.unpack('<4H', entries_raw[i:i + 8]) for i in range(0, len(entries_raw), 8)]
    metatiles += [struct.unpack('<4H', base_entries_raw[i:i + 8]) for i in range(0, len(base_entries_raw), 8)]

    words = [int(w.strip().lstrip('$'), 16) for w in ch['words'].split(',')]
    width, height = words[4], words[5]
    img = Image.new('RGB', (width, height))
    px = img.load()

    def blit_8x8(word, ox, oy):
        tid = word & 0x3FF
        pal = palettes[(word >> 10) & 7]
        hf = (word >> 14) & 1
        vf = (word >> 15) & 1
        tile = all_tiles[tid] if tid < len(all_tiles) else [0] * 64
        for y in range(8):
            sy = 7 - y if vf else y
            for x in range(8):
                sx = 7 - x if hf else x
                px[ox + x, oy + y] = pal[tile[sy * 8 + sx]]

    for idx, mt_word in enumerate(layout_words):
        mx, my = (idx % 64) * 16, (idx // 64) * 16
        if mx >= width or my >= height:
            continue
        mt_id = mt_word & 0x3FF
        if mt_id >= len(metatiles):
            continue
        tl, bl, tr, br = metatiles[mt_id]
        blit_8x8(tl, mx, my)
        blit_8x8(bl, mx, my + 8)
        blit_8x8(tr, mx + 8, my)
        blit_8x8(br, mx + 8, my + 8)

    os.makedirs(os.path.dirname(os.path.abspath(out_png)), exist_ok=True)
    img.save(out_png)


def decompress_comp(path):
    from decompress import decompress
    data = open(path, 'rb').read()
    buf = bytearray(0x400000)
    buf[:len(data)] = data
    return decompress(bytes(buf), 0xC00000)[0]


def self_test():
    chapters = parse_chapter_maps()
    assert len(chapters) == 12, f'Expected 12 chapters, got {len(chapters)}'
    labels = stream_labels()
    committed = 0
    for label in labels:
        raw = decompress_comp(bin_path(label) + '.comp')
        to_csv, to_bin = KINDS[kind_of(label)]
        text = to_csv(raw)
        assert to_bin(text) == raw, f'{label}: decode/encode differs'
        src = bin_path(label)[:-4] + '.csv'
        if os.path.exists(src):
            assert to_bin(open(src, encoding='utf-8').read()) == raw, f'{label}: committed CSV differs'
            committed += 1
    with tempfile.TemporaryDirectory() as tmp:
        render_chapter(chapters['Prologue'], open(os.path.join(ROOT, 'fe4.sfc'), 'rb').read(), load_labels(),
                       decode_4bpp_tiles(open(os.path.join(ROOT, 'gfx/map/MapTiles.4bpp'), 'rb').read()),
                       os.path.join(tmp, 'Prologue.png'))
    for bad in ('400:1', 'FFF:0'):
        try:
            entry_value(bad)
        except ValueError:
            pass
        else:
            raise AssertionError(f'entry_value({bad!r}) should fail')
    for fn, arg, desc in (
        (layout_bin, '0000\n', 'short layout'),
        (entries_bin, 'tile_id,top_left,bottom_left,top_right,bottom_right\n0,000:0,000:0,000:0,000:0\n', 'short entries'),
        (entries_bin, 'tile_id,top_left,bottom_left,top_right,bottom_right\n' +
                      ''.join(f'{i},000:0,000:0,000:0,000:0,extra\n' for i in range(256)), 'extra entry col'),
        (terrain_bin, 'tile_id,terrain\n0,TerrainPlains\n', 'short terrain'),
        (terrain_bin, 'tile_id,terrain\n' + ''.join(f'{i},TerrainBogus\n' for i in range(1024)), 'unknown terrain'),
    ):
        try:
            fn(arg)
        except ValueError:
            pass
        else:
            raise AssertionError(f'{desc} should fail')
    print(f'{len(labels)} chapter map streams (12 chapters) decode and encode byte-identical '
          f'({committed} committed CSVs checked); Prologue rendered')


def main():
    ap = argparse.ArgumentParser(description=__doc__.split('\n')[0])
    ap.add_argument('--self-test', action='store_true')
    sub = ap.add_subparsers(dest='cmd')
    p = sub.add_parser('decode')
    p.add_argument('chapter')
    sub.add_parser('build')
    p = sub.add_parser('render')
    p.add_argument('chapter')
    p.add_argument('out_dir')
    args = ap.parse_args()

    if args.self_test:
        self_test()
        return
    chapters = parse_chapter_maps()
    if args.cmd == 'decode':
        targets = chapters.values() if args.chapter == 'all' else [chapters[args.chapter]]
        for ch in targets:
            for key in ('layout', 'tile_entries', 'terrain'):
                decode(ch[key])
    elif args.cmd == 'build':
        build()
    elif args.cmd == 'render':
        rom = open(os.path.join(ROOT, 'fe4.sfc'), 'rb').read()
        labels = load_labels()
        base_tiles = decode_4bpp_tiles(open(os.path.join(ROOT, 'gfx/map/MapTiles.4bpp'), 'rb').read())
        targets = list(chapters.values()) if args.chapter == 'all' else [chapters[args.chapter]]
        for ch in targets:
            render_chapter(ch, rom, labels, base_tiles, os.path.join(args.out_dir, f'{ch["name"]}.png'))
    else:
        ap.print_help()


if __name__ == '__main__':
    main()
