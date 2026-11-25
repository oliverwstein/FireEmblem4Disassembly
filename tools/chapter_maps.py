#!/usr/bin/env python3
"""Decode, encode, and preview-render FE4 chapter maps (aChapterMapPointers).

usage: tools/chapter_maps.py decode CHAPTER OUT_DIR
       tools/chapter_maps.py encode IN_DIR OUT_PREFIX
       tools/chapter_maps.py render CHAPTER|all OUT_DIR
       tools/chapter_maps.py --self-test
"""
import argparse
import csv
import json
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


def decode_chapter(ch, out_dir):
    os.makedirs(out_dir, exist_ok=True)
    layout_raw = open(bin_path(ch['layout']), 'rb').read()
    entries_raw = open(bin_path(ch['tile_entries']), 'rb').read()
    terrain_raw = open(bin_path(ch['terrain']), 'rb').read()

    words = struct.unpack(f'<{len(layout_raw) // 2}H', layout_raw)
    with open(os.path.join(out_dir, 'layout.csv'), 'w', newline='', encoding='utf-8') as f:
        w = csv.writer(f)
        for row in range(0, len(words), 64):
            w.writerow([f'{v:04X}' for v in words[row:row + 64]])

    metatiles = []
    for i in range(0, len(entries_raw), 8):
        tl, bl, tr, br = struct.unpack('<4H', entries_raw[i:i + 8])
        def unpack_tile(val):
            return {
                'tile': val & 0x3FF,
                'palette': (val >> 10) & 7,
                'priority': bool((val >> 13) & 1),
                'hflip': bool((val >> 14) & 1),
                'vflip': bool((val >> 15) & 1),
            }
        metatiles.append({
            'tl': unpack_tile(tl),
            'bl': unpack_tile(bl),
            'tr': unpack_tile(tr),
            'br': unpack_tile(br),
        })
    with open(os.path.join(out_dir, 'metatiles.json'), 'w', encoding='utf-8') as f:
        json.dump(metatiles, f, indent=2)

    with open(os.path.join(out_dir, 'terrain.json'), 'w', encoding='utf-8') as f:
        json.dump(list(terrain_raw), f)


def encode_chapter(in_dir, out_prefix):
    rows = list(csv.reader(open(os.path.join(in_dir, 'layout.csv'), encoding='utf-8')))
    layout_words = [int(cell, 16) for row in rows for cell in row]
    open(f'{out_prefix}Layout.bin', 'wb').write(struct.pack(f'<{len(layout_words)}H', *layout_words))

    metatiles = json.load(open(os.path.join(in_dir, 'metatiles.json'), encoding='utf-8'))
    def pack_tile(t):
        return (
            (t['tile'] & 0x3FF)
            | ((t['palette'] & 7) << 10)
            | ((1 if t['priority'] else 0) << 13)
            | ((1 if t['hflip'] else 0) << 14)
            | ((1 if t['vflip'] else 0) << 15)
        )
    entries = bytearray()
    for mt in metatiles:
        entries += struct.pack('<4H', pack_tile(mt['tl']), pack_tile(mt['bl']), pack_tile(mt['tr']), pack_tile(mt['br']))
    open(f'{out_prefix}TileEntries.bin', 'wb').write(entries)

    terrain = json.load(open(os.path.join(in_dir, 'terrain.json'), encoding='utf-8'))
    open(f'{out_prefix}Terrain.bin', 'wb').write(bytes(terrain))


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
    layout_words = struct.unpack(f'<{len(layout_raw) // 2}H', layout_raw)
    metatiles = [struct.unpack('<4H', entries_raw[i:i + 8]) for i in range(0, len(entries_raw), 8)]

    img = Image.new('RGB', (1024, 1024))
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
        mt_id = mt_word & 0x3FF
        if mt_id >= len(metatiles):
            continue
        mx, my = (idx % 64) * 16, (idx // 64) * 16
        tl, bl, tr, br = metatiles[mt_id]
        blit_8x8(tl, mx, my)
        blit_8x8(bl, mx, my + 8)
        blit_8x8(tr, mx + 8, my)
        blit_8x8(br, mx + 8, my + 8)

    os.makedirs(os.path.dirname(os.path.abspath(out_png)), exist_ok=True)
    img.save(out_png)


def self_test():
    chapters = parse_chapter_maps()
    assert len(chapters) == 12, f'Expected 12 chapters, got {len(chapters)}'
    rom = open(os.path.join(ROOT, 'fe4.sfc'), 'rb').read()
    labels = load_labels()
    base_tiles = decode_4bpp_tiles(open(os.path.join(ROOT, 'gfx/map/MapTiles.4bpp'), 'rb').read())

    with tempfile.TemporaryDirectory() as tmp:
        for name, ch in chapters.items():
            d = os.path.join(tmp, name)
            decode_chapter(ch, d)
            out_pref = os.path.join(tmp, f're_{name}')
            encode_chapter(d, out_pref)
            for suffix, key in [('Layout', 'layout'), ('TileEntries', 'tile_entries'), ('Terrain', 'terrain')]:
                got = open(f'{out_pref}{suffix}.bin', 'rb').read()
                exp = open(bin_path(ch[key]), 'rb').read()
                assert got == exp, f'{name} {suffix} round-trip mismatch'
        render_chapter(chapters['Prologue'], rom, labels, base_tiles, os.path.join(tmp, 'Prologue.png'))
    print('12 of 12 chapter maps decode/encode byte-identical + preview rendered')


def main():
    ap = argparse.ArgumentParser(description=__doc__.split('\n')[0])
    ap.add_argument('--self-test', action='store_true')
    sub = ap.add_subparsers(dest='cmd')
    p_dec = sub.add_parser('decode')
    p_dec.add_argument('chapter')
    p_dec.add_argument('out_dir')
    p_enc = sub.add_parser('encode')
    p_enc.add_argument('in_dir')
    p_enc.add_argument('out_prefix')
    p_ren = sub.add_parser('render')
    p_ren.add_argument('chapter')
    p_ren.add_argument('out_dir')
    args = ap.parse_args()

    if args.self_test:
        self_test()
        return

    chapters = parse_chapter_maps()
    if args.cmd == 'decode':
        decode_chapter(chapters[args.chapter], args.out_dir)
    elif args.cmd == 'encode':
        encode_chapter(args.in_dir, args.out_prefix)
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
