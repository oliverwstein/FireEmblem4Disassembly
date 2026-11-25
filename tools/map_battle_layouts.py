#!/usr/bin/env python3
"""Decode, encode, and preview-render FE4 map-battle sprite layouts (aMapBattle*Layout*).

usage: tools/map_battle_layouts.py decode LAYOUT.bin OUT.json
       tools/map_battle_layouts.py encode IN.json OUT.bin
       tools/map_battle_layouts.py render LAYOUT_NAME OUT.png
       tools/map_battle_layouts.py --self-test
"""
import argparse
import glob
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
from sprite_scripts import SIZES, ENDS

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


def load_labels():
    labels = {}
    with open(os.path.join(ROOT, 'labels.txt'), encoding='utf-8') as f:
        for line in f:
            parts = line.split()
            if len(parts) == 3 and ':' not in parts[2]:
                labels.setdefault(parts[2].lstrip('.'), int(parts[1], 16))
    return labels


def parse_sprite_data_pairs():
    """Map each aMapBattle*Layout* name to its paired g4bppcMapBattle* graphics name."""
    text = open(os.path.join(ROOT, 'engine/battle/map_battle.asm'), encoding='utf-8').read()
    pairs = {}
    for m in re.finditer(r'\b(aMapBattle\w+Layout\d+),\s*(g4bppcMapBattle\w+)', text):
        pairs.setdefault(m.group(1), m.group(2))
    return pairs


def decode_4bpp_tiles(raw):
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


def decode_oam_array(data, pos):
    """Try to decode a structSpriteArray at pos; return (array_dict, end_pos) or None."""
    if pos + 2 > len(data):
        return None
    count = struct.unpack_from('<H', data, pos)[0]
    if count == 0 or count > 64 or pos + 2 + count * 5 > len(data):
        return None
    entries = []
    for i in range(count):
        x_lo, x_hi_size, y_s, tile_lo, attr = struct.unpack_from('<BBbBB', data, pos + 2 + i * 5)
        x = x_lo | ((x_hi_size & 1) << 8)
        if x >= 256:
            x -= 512
        entries.append({
            'x': x,
            'y': y_s,
            'large': bool(x_hi_size & 0x80),
            'size_byte': x_hi_size,
            'tile': tile_lo | ((attr & 1) << 8),
            'palette': (attr >> 1) & 7,
            'priority': (attr >> 4) & 3,
            'hflip': bool((attr >> 6) & 1),
            'vflip': bool((attr >> 7) & 1),
        })
    return {'offset': pos, 'entries': entries}, pos + 2 + count * 5


def decode_script(data, start, max_end):
    """Decode an active sprite script starting at `start`."""
    cmds = []
    pos = start
    while pos < max_end:
        op = data[pos]
        if op not in SIZES:
            break
        n = SIZES[op]
        if pos + 1 + n > max_end:
            break
        args = data[pos + 1:pos + 1 + n]
        cmds.append({'offset': pos, 'op': op, 'args': list(args)})
        pos += 1 + n
        if op in ENDS:
            break
    return cmds, pos


def decode_layout(raw):
    """Decode an aMapBattle*Layout*.bin into a lossless editable JSON dict."""
    hdr_words = list(struct.unpack_from('<16H', raw, 0))
    valid_blocks = sorted({w for w in hdr_words[:12] if 10 <= w < len(raw) - 10})
    header_end = valid_blocks[0] if valid_blocks else 10
    header = list(struct.unpack_from(f'<{header_end // 2}H', raw, 0))

    weapon_blocks = []
    script_starts = set()
    for blk in valid_blocks:
        if blk + 10 > len(raw):
            continue
        words = list(struct.unpack_from('<5H', raw, blk))
        weapon_blocks.append({'offset': blk, 'words': words})
        for w in words:
            target = blk + w
            if blk + 10 <= target < len(raw):
                script_starts.add(target)

    scripts = []
    frame_offsets = set()
    covered = set(range(0, header_end))
    for blk in weapon_blocks:
        for b in range(blk['offset'], blk['offset'] + 10):
            covered.add(b)

    for s in sorted(script_starts):
        cmds, end = decode_script(raw, s, len(raw))
        if cmds:
            scripts.append({'offset': s, 'end': end, 'commands': cmds})
            for b in range(s, end):
                covered.add(b)
            for c in cmds:
                if c['op'] == 0x00 and len(c['args']) == 3:
                    foff = c['args'][1] | (c['args'][2] << 8)
                    # Frame offsets are relative to the weapon block (0x000A) or layout start
                    for blk in weapon_blocks:
                        cand = blk['offset'] + foff
                        if 0 < cand < len(raw):
                            frame_offsets.add(cand)
                    if 0 < foff < len(raw):
                        frame_offsets.add(foff)

    # Scan uncovered gaps for OAM frame arrays referenced by scripts
    frames = []
    for foff in sorted(frame_offsets):
        if foff in covered:
            continue
        arr = decode_oam_array(raw, foff)
        if arr:
            _, end = arr
            if not any(b in covered for b in range(foff, end)):
                frames.append(arr[0])
                for b in range(foff, end):
                    covered.add(b)

    # Preserve any remaining uncovered byte spans losslessly
    raw_spans = []
    i = 0
    while i < len(raw):
        if i in covered:
            i += 1
            continue
        j = i
        while j < len(raw) and j not in covered:
            j += 1
        raw_spans.append({'offset': i, 'hex': raw[i:j].hex()})
        i = j

    return {
        'size': len(raw),
        'header': header,
        'weapon_blocks': weapon_blocks,
        'frames': frames,
        'scripts': scripts,
        'raw_spans': raw_spans,
    }


def encode_layout(obj):
    buf = bytearray(obj['size'])
    for i, w in enumerate(obj['header']):
        struct.pack_into('<H', buf, i * 2, w)
    for blk in obj['weapon_blocks']:
        struct.pack_into('<5H', buf, blk['offset'], *blk['words'])
    for fr in obj['frames']:
        pos = fr['offset']
        entries = fr['entries']
        struct.pack_into('<H', buf, pos, len(entries))
        for i, e in enumerate(entries):
            x_u = e['x'] & 0x1FF
            x_lo = x_u & 0xFF
            x_hi_size = (e['size_byte'] & 0xFE) | ((x_u >> 8) & 1)
            tile_lo = e['tile'] & 0xFF
            attr = (
                ((e['tile'] >> 8) & 1)
                | ((e['palette'] & 7) << 1)
                | ((e['priority'] & 3) << 4)
                | ((1 if e['hflip'] else 0) << 6)
                | ((1 if e['vflip'] else 0) << 7)
            )
            struct.pack_into('<BBbBB', buf, pos + 2 + i * 5, x_lo, x_hi_size, e['y'], tile_lo, attr)
    for sc in obj['scripts']:
        pos = sc['offset']
        for c in sc['commands']:
            buf[pos] = c['op']
            buf[pos + 1:pos + 1 + len(c['args'])] = bytes(c['args'])
            pos += 1 + len(c['args'])
    for sp in obj['raw_spans']:
        b = bytes.fromhex(sp['hex'])
        buf[sp['offset']:sp['offset'] + len(b)] = b
    return bytes(buf)


def render_layout(layout_path, gfx_path, rom, labels, out_png):
    obj = decode_layout(open(layout_path, 'rb').read())
    tiles = decode_4bpp_tiles(open(gfx_path, 'rb').read())
    pal_addr = labels['aPortraitAndMapUIOAMPalettes']
    pal_off = offset(pal_addr)
    palette = bgr555(rom[pal_off:pal_off + 32])

    frames = obj['frames']
    if not frames:
        Image.new('RGBA', (64, 64), (0, 0, 0, 0)).save(out_png)
        return

    cell = 64
    cols = min(8, len(frames))
    rows = (len(frames) + cols - 1) // cols
    img = Image.new('RGBA', (cols * cell, rows * cell), (24, 24, 32, 255))
    px = img.load()

    def blit_8x8(tid, ox, oy, hf, vf):
        if tid >= len(tiles):
            return
        t = tiles[tid]
        for y in range(8):
            sy = 7 - y if vf else y
            for x in range(8):
                sx = 7 - x if hf else x
                c = t[sy * 8 + sx]
                if c:
                    r, g, b = palette[c]
                    if 0 <= ox + x < img.width and 0 <= oy + y < img.height:
                        px[ox + x, oy + y] = (r, g, b, 255)

    for idx, fr in enumerate(frames):
        cx = (idx % cols) * cell + cell // 2
        cy = (idx // cols) * cell + cell // 2
        for e in reversed(fr['entries']):
            ox, oy = cx + e['x'], cy + e['y']
            tid = e['tile']
            hf, vf = e['hflip'], e['vflip']
            if e['large']:
                blit_8x8(tid + (1 if hf else 0) + (16 if vf else 0), ox, oy, hf, vf)
                blit_8x8(tid + (0 if hf else 1) + (16 if vf else 0), ox + 8, oy, hf, vf)
                blit_8x8(tid + (1 if hf else 0) + (0 if vf else 16), ox, oy + 8, hf, vf)
                blit_8x8(tid + (0 if hf else 1) + (0 if vf else 16), ox + 8, oy + 8, hf, vf)
            else:
                blit_8x8(tid, ox, oy, hf, vf)

    os.makedirs(os.path.dirname(os.path.abspath(out_png)), exist_ok=True)
    img.save(out_png)


def self_test():
    files = sorted(glob.glob(os.path.join(ROOT, 'gfx/compressed/*/aMapBattle*Layout*.bin')))
    assert len(files) == 120, f'Expected 120 layouts, got {len(files)}'
    for p in files:
        raw = open(p, 'rb').read()
        dec = decode_layout(raw)
        enc = encode_layout(dec)
        assert enc == raw, f'Round-trip mismatch for {p}'

    pairs = parse_sprite_data_pairs()
    rom = open(os.path.join(ROOT, 'fe4.sfc'), 'rb').read()
    labels = load_labels()
    sample = files[0]
    name = os.path.basename(sample)[:-4]
    gfx_name = pairs[name]
    gfx_matches = glob.glob(os.path.join(ROOT, 'gfx/compressed/*', f'{gfx_name}.4bpp'))
    assert gfx_matches, f'Missing unpacked 4bpp for {gfx_name}'
    with tempfile.TemporaryDirectory() as tmp:
        render_layout(sample, gfx_matches[0], rom, labels, os.path.join(tmp, f'{name}.png'))
    print(f'120 of 120 map-battle layouts decode/encode byte-identical + preview rendered ({name})')


def main():
    ap = argparse.ArgumentParser(description=__doc__.split('\n')[0])
    ap.add_argument('--self-test', action='store_true')
    sub = ap.add_subparsers(dest='cmd')
    p_dec = sub.add_parser('decode')
    p_dec.add_argument('layout_bin')
    p_dec.add_argument('out_json')
    p_enc = sub.add_parser('encode')
    p_enc.add_argument('in_json')
    p_enc.add_argument('out_bin')
    p_ren = sub.add_parser('render')
    p_ren.add_argument('layout_name')
    p_ren.add_argument('out_png')
    args = ap.parse_args()

    if args.self_test:
        self_test()
        return

    if args.cmd == 'decode':
        obj = decode_layout(open(args.layout_bin, 'rb').read())
        json.dump(obj, open(args.out_json, 'w', encoding='utf-8'), indent=2)
    elif args.cmd == 'encode':
        obj = json.load(open(args.in_json, encoding='utf-8'))
        open(args.out_bin, 'wb').write(encode_layout(obj))
    elif args.cmd == 'render':
        pairs = parse_sprite_data_pairs()
        rom = open(os.path.join(ROOT, 'fe4.sfc'), 'rb').read()
        labels = load_labels()
        l_matches = glob.glob(os.path.join(ROOT, 'gfx/compressed/*', f'{args.layout_name}.bin'))
        g_matches = glob.glob(os.path.join(ROOT, 'gfx/compressed/*', f'{pairs[args.layout_name]}.4bpp'))
        render_layout(l_matches[0], g_matches[0], rom, labels, args.out_png)
    else:
        ap.print_help()


if __name__ == '__main__':
    main()
