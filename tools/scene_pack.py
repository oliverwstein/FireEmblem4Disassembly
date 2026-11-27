#!/usr/bin/env python3
"""Scenes, backgrounds and UI layouts to/from SNES tiles + tilemaps.

usage: tools/scene_pack.py unpack MANIFEST.scene.json [--force]
       tools/scene_pack.py pack MANIFEST.scene.json [--compact]
       tools/scene_pack.py render MANIFEST.scene.json OUT_DIR
       tools/scene_pack.py build
       tools/scene_pack.py clean
       tools/scene_pack.py --self-test

Each MANIFEST.scene.json describes one scene (or a group of layers sharing a
tile sheet or palette): bit depth (4 or 2), palette sources (BGR555 labels in
.asm or .bin/.bin.comp, or "grey"; "offset" skips colours, "dest" and "count"
place them), tile sheets ("png": a .4bpp.png/.2bpp.png, or "comp": a seed read
straight from its .comp stream), and layers, each built to a .bin tilemap whose
committed original is TILEMAP.comp (compressed) or TILEMAP.seed (uncompressed).

A layer's source is one of two kinds:

- "png": an assembled picture (+ optional 1-bit _priority.png mask). The
  picture is the source of the art: the packer finds or makes the tiles. Used
  by scenes whose sheets are "writable".
- "grid": a CSV of tilemap entries, one row per tilemap row, each entry
  TILE:PALETTE (hex tile number, palette 0-7) plus any of p (priority), h and v
  (flips), as in the chapter map CSVs: 300:0p, 314:0pv. The art stays in the
  sheets, so editing a sheet changes every layout that uses its tiles. Used by
  fixed-sheet UI layouts. render draws previews.

A sheet a manifest marks "writable" is the seed only: pack refuses to run when
a "png" seed no longer decodes to its committed .comp stream, because the scene
PNG would silently put the old pixels back. Sheets that are not writable (the
shared UI sheets, or a sheet another manifest owns) are sources as they are.

Packing matches each 8x8 cell against existing tiles in their committed order
(trying all four flip combinations and preferring the original tilemap entry
when pixels still match). A cell nothing matches gets a new tile in the
layer's append_sheet: first in a blank slot that no committed scene tilemap
references, then appended up to the sheet's max_tiles VRAM budget. A sheet
with "external" set (a string naming its other user) is also read by a
tilemap outside gfx/scenes/, so its blank slots are never reused and it is
never compacted. Fixed-sheet layers set append_sheet to null. Colours must
already be in one of the layer's allowed sub-palettes; palettes are edited in
their .asm files, not in the PNG.

pack --compact also drops, from each writable sheet only this manifest uses,
the blank tiles nothing references and the tiles the edit left unreferenced,
and renumbers the rest. Tiles that no committed scene tilemap ever referenced
are kept: code or another screen may read them.

unpack renders the scene PNGs and priority masks from the committed sheets and
.bin.comp tilemaps (refusing to overwrite existing PNGs without --force),
records new masks in the manifest, checks that packing reproduces the .comp
streams, and reports unreferenced tiles per sheet.
"""
import argparse
import csv
import glob
import json
import os
import re
import shutil
import struct
import sys
import tempfile

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from decompress import decompress
from chapter_maps import entry_text, entry_value
import gfx

try:
    from PIL import Image
except ImportError:
    sys.exit('tools/scene_pack.py needs Pillow: pip3 install pillow')

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SCENES_DIR = os.path.join(ROOT, 'gfx', 'scenes')
UI_LAYOUTS_DIR = os.path.join(ROOT, 'gfx', 'ui', 'layouts')
EFFECTS_DIR = os.path.join(ROOT, 'gfx', 'effects')

WORD_ITEM_RE = re.compile(r'bgr555\(\s*(\d+)\s*,\s*(\d+)\s*,\s*(\d+)\s*\)|\$([0-9A-Fa-f]{1,4})\b')


def repo_path(rel):
    return rel if os.path.isabs(rel) else os.path.join(ROOT, rel)


def sheet_source(s):
    return s['png'] if 'png' in s else s['comp']


def sheet_bpp_out(s):
    return s['png'][:-4] if 'png' in s else s['comp'][:-5]


def sheet_key(s):
    path = sheet_bpp_out(s) if isinstance(s, dict) else s[:-4]
    return os.path.normpath(repo_path(path))


def decompress_comp(path):
    with open(path, 'rb') as f:
        orig = f.read()
    buf = bytearray(0x400000)
    buf[:len(orig)] = orig
    return decompress(bytes(buf), 0xC00000)[0]


def read_comp_bin(bin_path):
    """Read decompressed bytes from .comp or .seed if present, else bin_path, else None."""
    for ext in ('.comp', '.seed'):
        p = bin_path + ext
        if os.path.exists(p):
            return decompress_comp(p) if ext == '.comp' else open(p, 'rb').read()
    if os.path.exists(bin_path):
        with open(bin_path, 'rb') as f:
            return f.read()
    return None


def load_manifest(path):
    with open(path, encoding='utf-8') as f:
        m = json.load(f)
    validate_manifest(m, path)
    return m


def write_manifest(path, m):
    with open(path, 'w', encoding='utf-8') as f:
        f.write(json.dumps(m, indent=2, ensure_ascii=False) + '\n')


def validate_manifest(m, path):
    """Check the indexes and values pack relies on, so a bad manifest fails with a message."""
    def bad(msg):
        raise ValueError(f'{path}: {msg}')
    if m.get('depth') not in (2, 4):
        bad(f"depth must be 2 or 4, got {m.get('depth')!r}")
    sheets = m.get('sheets') or []
    if not sheets:
        bad('no sheets')
    for i, s in enumerate(sheets):
        if 'png' in s:
            if not s['png'].endswith(f".{m['depth']}bpp.png"):
                bad(f"sheet {i} ({s['png']!r}) is not a .{m['depth']}bpp.png")
        elif 'comp' in s:
            if not s['comp'].endswith(f".{m['depth']}bpp.comp"):
                bad(f"sheet {i} ({s['comp']!r}) is not a .{m['depth']}bpp.comp")
        else:
            bad(f'sheet {i} must specify "png" or "comp"')
    for li, layer in enumerate(m.get('layers') or []):
        name = layer.get('png') or layer.get('grid') or f'layer {li}'
        if ('png' in layer) == ('grid' in layer):
            bad(f'{name}: a layer needs exactly one of "png" and "grid"')
        refs = layer.get('sheets') or []
        if not refs:
            bad(f'{name}: no sheets')
        for r in refs:
            if not 0 <= r.get('sheet', -1) < len(sheets):
                bad(f"{name}: sheet index {r.get('sheet')!r} out of range (0-{len(sheets) - 1})")
            if not 0 <= r.get('base', -1) < 1024:
                bad(f"{name}: base {r.get('base')!r} out of range")
        pals = layer.get('palettes')
        if 'png' in layer or pals is not None:
            if not pals or any(not isinstance(p, int) or not 0 <= p < 8 for p in pals):
                bad(f'{name}: palettes must be a non-empty list of 0-7, got {pals!r}')
        a = layer.get('append_sheet')
        if 'grid' in layer and a is not None:
            bad(f'{name}: a grid layer names its tiles and cannot append (append_sheet must be null)')
        if a is not None:
            if not isinstance(a, int) or not 0 <= a < len(refs):
                bad(f"{name}: append_sheet {a!r} is not an index into this layer's {len(refs)} sheet(s)")
            if not sheets[refs[a]['sheet']].get('writable', False):
                bad(f"{name}: append_sheet points at {sheet_source(sheets[refs[a]['sheet']])}, which is not writable")
        if layer.get('width', 0) <= 0 or layer.get('height', 0) <= 0:
            bad(f'{name}: width and height must be positive')


def _bgr555_to_rgb(w):
    return tuple((w >> s & 31) * 255 // 31 for s in (0, 5, 10))


def _parse_asm_palette(asm_path, label, byte_offset=0, need=None, big_endian=False, stream=False):
    """Colors from the data after a label: its .word and .byte rows, from byte_offset.

    Reading stops at the next label, or, when need (a byte count) is given and not
    yet reached, goes on through the data rows of the labels after it (a battle
    scene color copy may start in one palette label and run into the next).
    big_endian reads each color high byte first, as the battle scene's palette
    effect streams store them; stream also skips their delay bytes ($80 | n)
    and stops at $FE or $FF.
    """
    with open(asm_path, encoding='utf-8') as f:
        lines = f.readlines()
    label_re = re.compile(rf'^\s*{re.escape(label)}\b')
    start = None
    for i, line in enumerate(lines):
        if label_re.match(line):
            start = i + 1
            break
    if start is None:
        raise ValueError(f'{asm_path}: palette label {label!r} not found')
    raw = bytearray()
    for line in lines[start:]:
        code = line.split(';', 1)[0].strip()
        if not code:
            continue
        if code.startswith('.endsection') or code.startswith('.section'):
            break
        if not code.startswith('.') and re.match(r'^[A-Za-z_]\w*', code):
            if need is None or len(raw) >= byte_offset + need:
                break
            continue
        if code.startswith('.word'):
            for m in WORD_ITEM_RE.finditer(code[5:]):
                if m.group(1) is not None:
                    r, g, b = (int(m.group(k)) for k in (1, 2, 3))
                    w = r | (g << 5) | (b << 10)
                else:
                    w = int(m.group(4), 16)
                raw.extend((w & 0xFF, (w >> 8) & 0xFF))
        elif code.startswith('.byte'):
            for m in re.finditer(r'\$([0-9A-Fa-f]{1,2})\b', code[5:]):
                raw.append(int(m.group(1), 16))
        elif need is not None:
            break               # not data: stop rather than read past it
    if byte_offset:
        raw = raw[byte_offset:]
    if stream:
        # A palette effect stream: colors high byte first; a byte with bit 7 set
        # ($80 | delay) may come before a color, $FE or $FF ends the stream.
        cols, i = [], 0
        while i + 1 < len(raw):
            b = raw[i]
            if b in (0xFE, 0xFF):
                break
            if b & 0x80:
                i += 1
                continue
            cols.append(_bgr555_to_rgb(raw[i] << 8 | raw[i + 1]))
            i += 2
        return cols
    if need is not None and len(raw) < need and not stream:
        raise ValueError(f'{asm_path}: {label} + {byte_offset}: {len(raw)} bytes of data, {need} needed')
    if big_endian:
        return [_bgr555_to_rgb(raw[i] << 8 | raw[i + 1]) for i in range(0, len(raw) - 1, 2)]
    return [_bgr555_to_rgb(raw[i] | (raw[i + 1] << 8)) for i in range(0, len(raw) - 1, 2)]


def load_palette(specs, depth):
    """Load 8 sub-palettes (128 RGB tuples for 4bpp, 32 for 2bpp)."""
    stride = 1 << depth
    cgram = [(0, 0, 0)] * (8 * stride)
    if specs == 'grey':
        g = gfx.grey(depth)
        for p in range(8):
            cgram[p * stride:(p + 1) * stride] = g
        return cgram
    for spec in specs:
        if 'asm' in spec:
            # span_labels (set by tools/battle_scene_palettes.py): the colors may run on
            # past the label into the data after it; without it a spec reads only its
            # label's data and colors past it stay black, as before.
            need = None
            if spec.get('span_labels') and spec.get('count') is not None:
                need = 2 * (spec.get('offset', 0) + spec['count'])
                if spec.get('stream'):
                    need = 3 * need    # a delay byte may come before each color
            cols = _parse_asm_palette(repo_path(spec['asm']), spec['label'], spec.get('byte_offset', 0),
                                      need, spec.get('big_endian', False), spec.get('stream', False))
            if spec.get('reverse'):
                cols = cols[:spec['count']][::-1]
        elif 'bin' in spec:
            p = repo_path(spec['bin'])
            raw = decompress_comp(p) if p.endswith('.comp') else open(p, 'rb').read()
            cols = [_bgr555_to_rgb(w) for w in struct.unpack(f'<{len(raw) // 2}H', raw)]
        else:
            raise ValueError(f'unknown palette spec: {spec!r}')
        dest = spec.get('dest', 0)
        offset = spec.get('offset', 0)
        if offset:
            cols = cols[offset:]
        count = spec.get('count')
        if count is not None:
            cols = cols[:count]
        cgram[dest:dest + len(cols)] = cols
    return cgram


def palette_dep_files(specs):
    if specs == 'grey':
        return []
    out = []
    for spec in specs:
        if 'asm' in spec:
            out.append(repo_path(spec['asm']))
        elif 'bin' in spec:
            out.append(repo_path(spec['bin']))
    return out


def decode_tiles(raw, depth):
    size = 8 * depth
    if len(raw) % size:
        raise ValueError(f'{len(raw)} bytes is not a multiple of {size} ({depth}bpp tile)')
    tiles = []
    for t in range(0, len(raw), size):
        b = raw[t:t + size]
        px = [0] * 64
        for y in range(8):
            planes = [b[16 * (k // 2) + 2 * y + k % 2] for k in range(depth)]
            for x in range(8):
                s = 7 - x
                px[y * 8 + x] = sum((planes[k] >> s & 1) << k for k in range(depth))
        tiles.append(tuple(px))
    return tiles


def encode_tile(px64, depth):
    planes = bytearray(8 * depth)
    for y in range(8):
        for x in range(8):
            c = px64[y * 8 + x]
            bit = 7 - x
            for k in range(depth):
                planes[16 * (k // 2) + 2 * y + k % 2] |= (c >> k & 1) << bit
    return bytes(planes)


def encode_tiles(tiles, depth):
    return b''.join(encode_tile(t, depth) for t in tiles)


def flip_tile(px64, hf, vf):
    if not hf and not vf:
        return px64
    return tuple(
        px64[(7 - y if vf else y) * 8 + (7 - x if hf else x)]
        for y in range(8) for x in range(8)
    )


def tilemap_index(tx, ty, width):
    if width == 64:
        return ((ty // 32) * 2 + (tx // 32)) * 1024 + (ty % 32) * 32 + (tx % 32)
    return ty * width + tx


def read_seed_sheet(src_path, depth, check=False):
    """Decode a seed sheet (.png or .comp) to tiles, trimming PNG row padding past .comp length.

    With check, fail if a PNG no longer decodes to the .comp stream: the
    sheet of a writable scene is not the source, and edits to it would be
    overridden by the scene PNG.
    """
    if src_path.endswith('.comp'):
        return decode_tiles(decompress_comp(src_path), depth)
    raw = gfx.png_to_bpp(src_path, depth)
    comp = src_path[:-4] + '.comp'
    if os.path.exists(comp):
        want = decompress_comp(comp)
        orig_len = len(want)
        if len(raw) > orig_len and not any(raw[orig_len:]):
            raw = raw[:orig_len]
        if check and raw != want:
            raise ValueError(
                f'{src_path} differs from {os.path.basename(comp)}: this sheet is the seed '
                f'of a scene, and the scene PNGs in gfx/scenes/ are the source. Revert the '
                f'sheet and edit the scene PNG instead.')
    return decode_tiles(raw, depth)


def _render_tile(px64, sub_pal, transparent):
    if transparent:
        return tuple((0, 0, 0, 0) if c == 0 else (*sub_pal[c], 255) for c in px64)
    return tuple(sub_pal[c] for c in px64)


def _lookup_sheet_tile(tid, layer_sheets, sheets_tiles):
    for ref in layer_sheets:
        base = ref['base']
        tiles = sheets_tiles[ref['sheet']]
        if base <= tid < base + len(tiles):
            return tiles[tid - base]
    return None


def _render_word(word, layer, sheets_tiles, cgram, stride, trans):
    tile = _lookup_sheet_tile(word & 0x3FF, layer['sheets'], sheets_tiles) or (0,) * 64
    pal = (word >> 10) & 7
    sub_pal = cgram[pal * stride:(pal + 1) * stride]
    return _render_tile(flip_tile(tile, bool(word & 0x4000), bool(word & 0x8000)), sub_pal, trans)


_SCENE_INDEX = None


def scene_index():
    """Every manifest's view of each sheet, from the committed .comp tilemaps.

    Returns {sheet_key: {'refs': set of local tile IDs any committed scene
    tilemap references, 'users': set of manifest basenames}}.
    """
    global _SCENE_INDEX
    if _SCENE_INDEX is None:
        idx = {}
        for mp in manifests():
            with open(mp, encoding='utf-8') as f:
                m = json.load(f)
            lens = [len(read_seed_sheet(repo_path(sheet_source(s)), m['depth'])) for s in m['sheets']]
            for s in m['sheets']:
                idx.setdefault(sheet_key(s), {'refs': set(), 'users': set()})['users'].add(
                    os.path.basename(mp))
            for layer in m['layers']:
                raw = read_comp_bin(repo_path(layer['tilemap']))
                if raw is None:
                    continue
                for w in struct.unpack(f'<{len(raw) // 2}H', raw):
                    tid = w & 0x3FF
                    for r in layer['sheets']:
                        if r['base'] <= tid < r['base'] + lens[r['sheet']]:
                            idx[sheet_key(m['sheets'][r['sheet']])]['refs'].add(tid - r['base'])
                            break
        _SCENE_INDEX = idx
    return _SCENE_INDEX


def _check_png_target(path, force):
    if os.path.exists(path) and not force:
        raise ValueError(f'{path} exists; unpack would overwrite it (pass --force to replace it)')


def read_grid(path, w, h):
    """Read a grid layer CSV (h rows of w TILE:PALETTE[phv] entries) into tilemap words."""
    with open(path, encoding='utf-8') as f:
        rows = [r for r in csv.reader(f) if r]
    if len(rows) != h:
        raise ValueError(f'{path}: expected {h} rows, got {len(rows)}')
    words = [0] * (w * h)
    for ty, row in enumerate(rows):
        if len(row) != w:
            raise ValueError(f'{path}: row {ty} has {len(row)} entries, expected {w}')
        for tx, text in enumerate(row):
            try:
                words[tilemap_index(tx, ty, w)] = entry_value(text)
            except ValueError as e:
                raise ValueError(f'{path}: cell ({tx}, {ty}): {e}') from None
    return words


def grid_text(words, w, h):
    return ''.join(','.join(entry_text(words[tilemap_index(tx, ty, w)]) for tx in range(w)) + '\n'
                   for ty in range(h))


def _layer_image(words, layer, sheets_tiles, cgram, stride):
    w, h = layer['width'], layer['height']
    trans = layer.get('transparent', False)
    img = Image.new('RGBA' if trans else 'RGB', (w * 8, h * 8))
    px = img.load()
    for ty in range(h):
        for tx in range(w):
            rendered = _render_word(words[tilemap_index(tx, ty, w)], layer, sheets_tiles, cgram, stride, trans)
            for y in range(8):
                for x in range(8):
                    px[tx * 8 + x, ty * 8 + y] = rendered[y * 8 + x]
    return img


def render_scene(manifest_path, out_dir):
    """Draw every layer as the build would put it in VRAM, from the current sources."""
    m = load_manifest(manifest_path)
    depth = m['depth']
    cgram = load_palette(m['palette'], depth)
    sheet_outs, tm_outs = pack_scene(manifest_path, write=False)
    sheets_tiles = []
    for s in m['sheets']:
        out = repo_path(sheet_bpp_out(s))
        sheets_tiles.append(decode_tiles(sheet_outs[out], depth) if out in sheet_outs
                            else read_seed_sheet(repo_path(sheet_source(s)), depth))
    os.makedirs(out_dir, exist_ok=True)
    written = []
    for layer in m['layers']:
        raw = tm_outs[repo_path(layer['tilemap'])]
        words = struct.unpack(f'<{len(raw) // 2}H', raw)
        name = os.path.splitext(layer.get('png') or layer['grid'])[0] + '.png'
        _layer_image(words, layer, sheets_tiles, cgram, 1 << depth).save(os.path.join(out_dir, name))
        written.append(name)
    return written


def unpack_scene(manifest_path, force=False):
    """Write each layer's source from the committed sheets and .comp/.seed tilemaps.

    A "png" layer gets its picture (and a _priority.png mask when any entry
    sets priority, recorded in the manifest); a "grid" layer gets its CSV.
    Refuses to overwrite existing files unless force, and checks that packing
    the result reproduces the committed streams. Returns {sheet: unreferenced
    tile count}.
    """
    mdir = os.path.dirname(os.path.abspath(manifest_path))
    m = load_manifest(manifest_path)
    depth = m['depth']
    stride = 1 << depth
    cgram = load_palette(m['palette'], depth)
    sheets_tiles = [read_seed_sheet(repo_path(sheet_source(s)), depth) for s in m['sheets']]
    referenced = [set() for _ in m['sheets']]
    manifest_changed = False

    outputs = []  # (path, writer)
    for layer in m['layers']:
        w, h = layer['width'], layer['height']
        tm_raw = read_comp_bin(repo_path(layer['tilemap']))
        if tm_raw is None:
            raise ValueError(f"{layer['tilemap']}: missing .comp and .seed")
        words = struct.unpack(f'<{len(tm_raw) // 2}H', tm_raw)
        if len(words) != w * h:
            raise ValueError(f"{layer['tilemap']}: expected {w * h} words, got {len(words)}")
        for word in words:
            tid = word & 0x3FF
            for ref in layer['sheets']:
                if ref['base'] <= tid < ref['base'] + len(sheets_tiles[ref['sheet']]):
                    referenced[ref['sheet']].add(tid - ref['base'])
                    break

        if 'grid' in layer:
            text = grid_text(words, w, h)
            outputs.append((os.path.join(mdir, layer['grid']),
                            lambda p, t=text: open(p, 'w', encoding='utf-8').write(t)))
            continue

        img = _layer_image(words, layer, sheets_tiles, cgram, stride)
        outputs.append((os.path.join(mdir, layer['png']), lambda p, i=img: i.save(p)))
        pri_cells = [(tx, ty) for ty in range(h) for tx in range(w) if words[tilemap_index(tx, ty, w)] & 0x2000]
        if pri_cells:
            if not layer.get('priority'):
                layer['priority'] = os.path.splitext(layer['png'])[0] + '_priority.png'
                manifest_changed = True
            pimg = Image.new('1', (w * 8, h * 8), 0)
            ppx = pimg.load()
            for tx, ty in pri_cells:
                for y in range(8):
                    for x in range(8):
                        ppx[tx * 8 + x, ty * 8 + y] = 255
            outputs.append((os.path.join(mdir, layer['priority']), lambda p, i=pimg: i.save(p)))

    for path, _ in outputs:
        _check_png_target(path, force)
    for path, writer in outputs:
        writer(path)
    if manifest_changed:
        write_manifest(manifest_path, m)

    verify_against_comp(manifest_path)
    return {
        sheet_source(m['sheets'][i]): len(tiles) - len(referenced[i])
        for i, tiles in enumerate(sheets_tiles)
    }


def verify_against_comp(manifest_path):
    """Pack without writing and fail unless every output equals its committed .comp or .seed."""
    sheet_outs, tm_outs = pack_scene(manifest_path, write=False)
    for bpp_path, got in sheet_outs.items():
        comp = bpp_path + '.comp'
        if os.path.exists(comp) and got != decompress_comp(comp):
            raise ValueError(f'{manifest_path}: sheet {bpp_path} does not pack back to its .comp')
    for tm_path, got in tm_outs.items():
        comp = tm_path + '.comp'
        seed = tm_path + '.seed'
        if os.path.exists(comp):
            want = decompress_comp(comp)
        elif os.path.exists(seed):
            with open(seed, 'rb') as f:
                want = f.read()
        else:
            raise ValueError(f'{manifest_path}: tilemap {tm_path} has neither .comp nor .seed')
        if got != want:
            raise ValueError(f'{manifest_path}: tilemap {tm_path} does not pack back to its committed source')


def _read_cell(px, tx, ty, trans):
    ox, oy = tx * 8, ty * 8
    if trans:
        out = []
        for y in range(8):
            for x in range(8):
                r, g, b, a = px[ox + x, oy + y]
                out.append((0, 0, 0, 0) if a < 128 else (r, g, b, 255))
        return tuple(out)
    return tuple(px[ox + x, oy + y][:3] for y in range(8) for x in range(8))


def _read_priority_mask(path, w, h):
    if not path:
        return None
    pimg = Image.open(path)
    if pimg.size != (w * 8, h * 8):
        raise ValueError(f'{path}: expected {w * 8}x{h * 8}, got {pimg.size[0]}x{pimg.size[1]}')
    pimg = pimg.convert('L')
    ppx = pimg.load()
    grid = [[False] * w for _ in range(h)]
    for ty in range(h):
        for tx in range(w):
            ox, oy = tx * 8, ty * 8
            vals = {ppx[ox + x, oy + y] > 127 for y in range(8) for x in range(8)}
            if len(vals) != 1:
                raise ValueError(f'{path}: cell ({tx}, {ty}) mixes priority on and off')
            grid[ty][tx] = vals.pop()
    return grid


def _open_layer_png(png_path, w, h, trans):
    img = Image.open(png_path)
    if img.size != (w * 8, h * 8):
        raise ValueError(f'{png_path}: expected {w * 8}x{h * 8}, got {img.size[0]}x{img.size[1]}')
    img = img.convert('RGBA' if trans else 'RGB')
    return img.load()


def pack_scene(manifest_path, write=True, compact=False):
    """Pack scene PNGs + priority masks into writable .4bpp/.2bpp sheets and .bin tilemaps."""
    mdir = os.path.dirname(os.path.abspath(manifest_path))
    mname = os.path.basename(manifest_path)
    m = load_manifest(manifest_path)
    depth = m['depth']
    stride = 1 << depth
    cgram = load_palette(m['palette'], depth)
    sheets_tiles = [read_seed_sheet(repo_path(sheet_source(s)), depth, check=s.get('writable', False))
                    for s in m['sheets']]
    index = scene_index()

    # Blank slots a new tile may take: blank, in a writable sheet with no
    # outside user, and referenced by no committed scene tilemap.
    free_slots = {}
    for si, s in enumerate(m['sheets']):
        if s.get('writable', False) and not s.get('external'):
            refs = index.get(sheet_key(s), {}).get('refs', set())
            free_slots[si] = [i for i, t in enumerate(sheets_tiles[si]) if not any(t) and i not in refs]
    used_now = {si: set() for si in range(len(m['sheets']))}

    # Cache: (sheet_idx, pal, trans) -> dict[rendered_64 -> (local_tid, hf, vf)]
    cache = {}

    def get_sheet_map(si, pal, trans):
        key = (si, pal, trans)
        if key not in cache:
            sub_pal = cgram[pal * stride:(pal + 1) * stride]
            d = {}
            for idx, tile in enumerate(sheets_tiles[si]):
                for hf, vf in ((False, False), (True, False), (False, True), (True, True)):
                    r = _render_tile(flip_tile(tile, hf, vf), sub_pal, trans)
                    d.setdefault(r, (idx, hf, vf))
            cache[key] = d
        return cache[key]

    def note_use(layer, word):
        tid = word & 0x3FF
        for ref in layer['sheets']:
            if ref['base'] <= tid < ref['base'] + len(sheets_tiles[ref['sheet']]):
                used_now[ref['sheet']].add(tid - ref['base'])
                return

    layer_words_out = []
    for layer in m['layers']:
        w, h = layer['width'], layer['height']
        trans = layer.get('transparent', False)
        if 'grid' in layer:
            grid_path = os.path.join(mdir, layer['grid'])
            words = read_grid(grid_path, w, h)
            allowed = layer.get('palettes')
            for i, wd in enumerate(words):
                if allowed is not None and (wd >> 10) & 7 not in allowed:
                    raise ValueError(f'{grid_path}: entry {entry_text(wd)} uses palette {(wd >> 10) & 7}, '
                                     f'not one of {allowed}')
                note_use(layer, wd)
            layer_words_out.append((layer, words))
            continue
        png_path = os.path.join(mdir, layer['png'])
        px = _open_layer_png(png_path, w, h, trans)

        pri_path = os.path.join(mdir, layer['priority']) if layer.get('priority') else None
        pri_grid = _read_priority_mask(pri_path, w, h)

        tm_path = repo_path(layer['tilemap'])
        seed_raw = read_comp_bin(tm_path)
        seed_words = struct.unpack(f'<{len(seed_raw) // 2}H', seed_raw) if seed_raw else None

        words = [0] * (w * h)
        allowed_pals = layer['palettes']

        for ty in range(h):
            for tx in range(w):
                idx = tilemap_index(tx, ty, w)
                cell = _read_cell(px, tx, ty, trans)
                pri = pri_grid[ty][tx] if pri_grid else False

                # 1. Seed tiebreaker: preserve original entry if rendered pixels still match.
                matched = None
                if seed_words is not None and idx < len(seed_words):
                    sw = seed_words[idx]
                    if (sw >> 10) & 7 in allowed_pals and \
                            _render_word(sw, layer, sheets_tiles, cgram, stride, trans) == cell:
                        matched = (sw & ~0x2000) | (0x2000 if pri else 0)

                # 2. Match against existing tiles in committed order.
                if matched is None:
                    for p in allowed_pals:
                        for ref in layer['sheets']:
                            hit = get_sheet_map(ref['sheet'], p, trans).get(cell)
                            if hit is not None:
                                local_tid, hf, vf = hit
                                matched = ((ref['base'] + local_tid) | (p << 10)
                                           | (0x2000 if pri else 0)
                                           | (0x4000 if hf else 0)
                                           | (0x8000 if vf else 0))
                                break
                        if matched is not None:
                            break

                # 3. New tile: a free blank slot, else appended within the VRAM budget.
                if matched is None:
                    chosen_pal = None
                    chosen_indices = None
                    best_missing = None
                    for p in allowed_pals:
                        sub_pal = cgram[p * stride:(p + 1) * stride]
                        color_to_idx = {}
                        for ci in range(1 if trans else 0, stride):
                            key = (*sub_pal[ci], 255) if trans else sub_pal[ci]
                            color_to_idx.setdefault(key, ci)
                        indices = []
                        missing = set()
                        for pix in cell:
                            if trans and pix[3] == 0:
                                indices.append(0)
                            elif pix in color_to_idx:
                                indices.append(color_to_idx[pix])
                            else:
                                missing.add(pix[:3])
                        if not missing:
                            chosen_pal = p
                            chosen_indices = tuple(indices)
                            break
                        if best_missing is None or len(missing) < len(best_missing):
                            best_missing = missing

                    if chosen_pal is None:
                        cols_str = ', '.join(str(c) for c in sorted(best_missing)[:4])
                        raise ValueError(
                            f'{png_path}: cell ({tx}, {ty}) has colours not in allowed palettes '
                            f'{allowed_pals}: {cols_str}'
                        )

                    app_ref_idx = layer.get('append_sheet')
                    if app_ref_idx is None:
                        raise ValueError(
                            f'{png_path}: cell ({tx}, {ty}) does not match any existing tile '
                            f'and appending is disabled'
                        )
                    app_ref = layer['sheets'][app_ref_idx]
                    si = app_ref['sheet']
                    slot = next((i for i in free_slots.get(si, ()) if i not in used_now[si]), None)
                    if slot is not None:
                        free_slots[si].remove(slot)
                        sheets_tiles[si][slot] = chosen_indices
                        new_local_tid = slot
                    else:
                        max_tiles = m['sheets'][si].get('max_tiles', 1024)
                        if len(sheets_tiles[si]) >= max_tiles:
                            raise ValueError(
                                f"{png_path}: cell ({tx}, {ty}) needs a new tile, but sheet "
                                f"{sheet_source(m['sheets'][si])} has no free blank slot and reached its "
                                f"VRAM budget ({max_tiles} tiles)"
                            )
                        new_local_tid = len(sheets_tiles[si])
                        sheets_tiles[si].append(chosen_indices)
                    # Invalidate caches for this sheet so later cells and layers see the new tile.
                    for ck in [k for k in cache if k[0] == si]:
                        del cache[ck]
                    matched = (app_ref['base'] + new_local_tid) | (chosen_pal << 10) | (0x2000 if pri else 0)

                words[idx] = matched
                note_use(layer, matched)

        layer_words_out.append((layer, words))

    if compact:
        for si, s in enumerate(m['sheets']):
            if not s.get('writable', False):
                continue
            info = index.get(sheet_key(s), {'refs': set(), 'users': set()})
            others = sorted(info['users'] - {mname})
            if s.get('external') or others:
                raise ValueError(
                    f"{manifest_path}: --compact would renumber {sheet_source(s)}, which is also read by "
                    f"{', '.join(others) if others else s['external']}")
            old = sheets_tiles[si]
            keep = [i for i, t in enumerate(old)
                    if i in used_now[si] or (any(t) and i not in info['refs'])]
            remap = {o: n for n, o in enumerate(keep)}
            sheets_tiles[si] = [old[i] for i in keep]
            for layer, words in layer_words_out:
                for ref in layer['sheets']:
                    if ref['sheet'] != si:
                        continue
                    base = ref['base']
                    for i, wd in enumerate(words):
                        tid = wd & 0x3FF
                        if base <= tid < base + len(old):
                            words[i] = (wd & ~0x3FF) | (base + remap[tid - base])

    sheet_outputs = {}
    for si, s in enumerate(m['sheets']):
        if s.get('writable', False):
            sheet_outputs[repo_path(sheet_bpp_out(s))] = encode_tiles(sheets_tiles[si], depth)

    tilemap_outputs = {}
    for layer, words in layer_words_out:
        tilemap_outputs[repo_path(layer['tilemap'])] = struct.pack(f'<{len(words)}H', *words)

    if write:
        for path, data in list(sheet_outputs.items()) + list(tilemap_outputs.items()):
            with open(path, 'wb') as f:
                f.write(data)

    return sheet_outputs, tilemap_outputs


def manifests():
    return sorted(
        glob.glob(os.path.join(SCENES_DIR, '**', '*.scene.json'), recursive=True)
        + glob.glob(os.path.join(UI_LAYOUTS_DIR, '**', '*.scene.json'), recursive=True)
        + glob.glob(os.path.join(EFFECTS_DIR, '**', '*.scene.json'), recursive=True)
    )


def build():
    n = 0
    for mp in manifests():
        mdir = os.path.dirname(os.path.abspath(mp))
        try:
            m = load_manifest(mp)
        except ValueError as e:
            sys.exit(str(e))
        inputs = [mp] + palette_dep_files(m['palette'])
        inputs += [repo_path(sheet_source(s)) for s in m['sheets']]
        outputs = [repo_path(sheet_bpp_out(s)) for s in m['sheets'] if s.get('writable', False)]
        for layer in m['layers']:
            inputs.append(os.path.join(mdir, layer.get('png') or layer['grid']))
            if layer.get('priority'):
                inputs.append(os.path.join(mdir, layer['priority']))
            tm_path = repo_path(layer['tilemap'])
            for ext in ('.comp', '.seed'):
                if os.path.exists(tm_path + ext):
                    inputs.append(tm_path + ext)
                    break
            outputs.append(tm_path)
        in_mtime = max(os.path.getmtime(p) for p in inputs)
        if any(not os.path.exists(p) or in_mtime > os.path.getmtime(p) for p in outputs):
            try:
                pack_scene(mp, write=True)
            except ValueError as e:
                sys.exit(str(e))
            n += 1
    return n


def clean():
    for mp in manifests():
        with open(mp, encoding='utf-8') as f:
            m = json.load(f)
        for layer in m['layers']:
            p = repo_path(layer['tilemap'])
            if os.path.exists(p):
                os.remove(p)


def _expect_error(fn, needle, what):
    try:
        fn()
    except ValueError as e:
        assert needle in str(e), f'{what}: unexpected error: {e}'
    else:
        raise AssertionError(f'{what} should fail')


def _copy_scene(mp, tmp, sub):
    """Copy a manifest and its layer sources (PNGs, masks, grids) into tmp/sub; return the copy's path."""
    src_dir = os.path.dirname(mp)
    dst = os.path.join(tmp, sub)
    os.makedirs(dst)
    m = load_manifest(mp)
    for layer in m['layers']:
        for key in ('png', 'priority', 'grid'):
            if layer.get(key):
                shutil.copy(os.path.join(src_dir, layer[key]), dst)
    shutil.copy(mp, dst)
    return os.path.join(dst, os.path.basename(mp))


def _new_tile_edit(png_path, start_row=0):
    """Change one pixel of the first two-colour cell at or below start_row to another colour of that cell.

    The cell stays inside its sub-palette and almost surely matches no tile.
    Returns the cell (tx, ty).
    """
    img = Image.open(png_path)
    px = img.load()
    for ty in range(start_row, img.height // 8):
        for tx in range(img.width // 8):
            cols = [px[tx * 8 + x, ty * 8 + y] for y in range(8) for x in range(8)]
            if len(set(cols)) >= 2 and not (img.mode == 'RGBA' and any(c[3] == 0 for c in cols)):
                other = next(c for c in cols if c != cols[0])
                px[tx * 8, ty * 8] = other
                img.save(png_path)
                return tx, ty
    raise AssertionError(f'{png_path}: no two-colour cell to edit')


def self_test():
    mps = manifests()
    assert mps, 'no .scene.json manifests found'
    names = [os.path.basename(mp) for mp in mps]
    assert len(set(names)) == len(names), 'manifest file names must be unique'
    total_layers = 0
    writable_sheets = set()
    tilemap_targets = set()

    for mp in mps:
        m = load_manifest(mp)
        for s in m['sheets']:
            if s.get('writable', False):
                key = sheet_key(s)
                assert key not in writable_sheets, f"duplicate writable sheet {sheet_source(s)}"
                writable_sheets.add(key)
        for layer in m['layers']:
            assert layer['tilemap'] not in tilemap_targets, f"duplicate tilemap {layer['tilemap']}"
            tilemap_targets.add(layer['tilemap'])
            total_layers += 1
        verify_against_comp(mp)

    assert len(mps) == 135, f'expected 135 manifests, found {len(mps)}'
    assert total_layers == 204, f'expected 204 scene/UI/effect layers, found {total_layers}'

    with tempfile.TemporaryDirectory() as tmp:
        # 1. Tile append + LZ recompression on OpeningLogo (65/256 tiles, no blank slots).
        logo_src = os.path.join(SCENES_DIR, 'screens', 'OpeningLogo.scene.json')
        logo_m = load_manifest(logo_src)
        tmp_logo_mp = _copy_scene(logo_src, tmp, 'logo')
        logo_png = os.path.join(os.path.dirname(tmp_logo_mp), 'OpeningLogo.png')
        orig_img = Image.open(logo_png).copy()
        cgram = load_palette(logo_m['palette'], 4)
        c0 = orig_img.getpixel((0, 0))
        alt = next(c for c in cgram[17:32] if c != c0)
        edited = orig_img.copy()
        edited.putpixel((0, 0), alt)
        edited.save(logo_png)
        s_outs, t_outs = pack_scene(tmp_logo_mp, write=False)
        bpp_bytes = next(iter(s_outs.values()))
        tm_bytes = next(iter(t_outs.values()))
        assert len(bpp_bytes) == 66 * 32, f'expected 66 tiles, got {len(bpp_bytes) // 32}'
        assert struct.unpack_from('<H', tm_bytes, 0)[0] & 0x3FF == 65, 'edited cell did not point to appended tile 65'
        lz_tm = gfx.lz(tm_bytes, repo_path(logo_m['layers'][0]['tilemap'] + '.comp'))
        buf = bytearray(0x400000)
        buf[:len(lz_tm)] = lz_tm
        assert decompress(bytes(buf), 0xC00000)[0] == tm_bytes, 'recompressed tilemap failed round-trip'

        # 2. A new tile in a full sheet takes a free blank slot (Plains 512/512,
        #    ThroneForeground 256/256), size unchanged, every other entry the same.
        for src, sub, layer_i in ((os.path.join(SCENES_DIR, 'battle', 'Plains.scene.json'), 'plains', 0),
                                  (os.path.join(SCENES_DIR, 'dialogue', 'Throne.scene.json'), 'throne_fill', 1)):
            mp2 = _copy_scene(src, tmp, sub)
            m2 = load_manifest(mp2)
            layer = m2['layers'][layer_i]
            tx, ty = _new_tile_edit(os.path.join(os.path.dirname(mp2), layer['png']), start_row=2)
            si = layer['sheets'][layer['append_sheet']]['sheet']
            s_obj = m2['sheets'][si]
            s_src = sheet_source(s_obj)
            s_bpp = repo_path(sheet_bpp_out(s_obj))
            free = sorted(i for i, t in enumerate(read_seed_sheet(repo_path(s_src), m2['depth']))
                          if not any(t) and i not in scene_index()[sheet_key(s_obj)]['refs'])
            s_outs, t_outs = pack_scene(mp2, write=False)
            orig_sheet = decompress_comp(s_bpp + '.comp')
            new_sheet = s_outs[s_bpp]
            assert len(new_sheet) == len(orig_sheet), f'{sub}: sheet size changed'
            tm = repo_path(layer['tilemap'])
            old_w = struct.unpack(f'<{layer["width"] * layer["height"]}H', decompress_comp(tm + '.comp'))
            new_w = struct.unpack(f'<{layer["width"] * layer["height"]}H', t_outs[tm])
            i = tilemap_index(tx, ty, layer['width'])
            changed = [k for k in range(len(old_w)) if old_w[k] != new_w[k]]
            assert changed == [i], f'{sub}: expected only entry {i} to change, got {changed[:5]}'
            base = layer['sheets'][layer['append_sheet']]['base']
            assert (new_w[i] & 0x3FF) - base == free[0], f'{sub}: new tile not in first free slot {free[0]}'

        # 3. A sheet with an outside user never gives up blank slots (Unused16 / TitleIntro).
        tit_mp = _copy_scene(os.path.join(SCENES_DIR, 'battle', 'Unused16.scene.json'), tmp, 'titleintro')
        _new_tile_edit(os.path.join(os.path.dirname(tit_mp), 'Unused16.png'), start_row=2)
        _expect_error(lambda: pack_scene(tit_mp, write=False), 'VRAM budget', 'external sheet append')

        # 4. Priority mask toggle on ThroneForeground.
        throne_src = os.path.join(SCENES_DIR, 'dialogue', 'Throne.scene.json')
        throne_m = load_manifest(throne_src)
        tmp_throne_mp = _copy_scene(throne_src, tmp, 'throne')
        tmp_throne_dir = os.path.dirname(tmp_throne_mp)
        pri_png = os.path.join(tmp_throne_dir, throne_m['layers'][1]['priority'])
        pimg = Image.open(pri_png).copy()
        ppx = pimg.load()
        was = ppx[0, 0] > 127
        for y in range(8):
            for x in range(8):
                ppx[x, y] = 0 if was else 255
        pimg.save(pri_png)
        _, t_outs2 = pack_scene(tmp_throne_mp, write=False)
        fg_tm_path = repo_path(throne_m['layers'][1]['tilemap'])
        orig_fg = decompress_comp(fg_tm_path + '.comp')
        new_fg = t_outs2[fg_tm_path]
        assert struct.unpack_from('<H', new_fg, 0)[0] == struct.unpack_from('<H', orig_fg, 0)[0] ^ 0x2000, \
            'priority toggle did not flip bit $2000'
        assert new_fg[2:] == orig_fg[2:], 'priority toggle changed other entries'

        # 5. --compact on Gate keeps every tile no scene ever referenced, drops
        #    the unreferenced blank ones, and still renders the same picture.
        gate_mp = _copy_scene(os.path.join(SCENES_DIR, 'dialogue', 'Gate.scene.json'), tmp, 'gate')
        gate_m = load_manifest(gate_mp)
        gate_s = gate_m['sheets'][0]
        seed = read_seed_sheet(repo_path(sheet_source(gate_s)), 4)
        refs = scene_index()[sheet_key(gate_s)]['refs']
        s_outs, t_outs = pack_scene(gate_mp, write=False, compact=True)
        new_tiles = decode_tiles(s_outs[repo_path(sheet_bpp_out(gate_s))], 4)
        want = [t for i, t in enumerate(seed) if i in refs or any(t)]
        assert new_tiles == want, 'compact kept or dropped the wrong tiles'
        assert len(new_tiles) < len(seed), 'compact dropped nothing'
        layer = gate_m['layers'][0]
        g_cgram = load_palette(gate_m['palette'], 4)
        g_px = _open_layer_png(os.path.join(os.path.dirname(gate_mp), layer['png']),
                               layer['width'], layer['height'], False)
        g_words = struct.unpack(f'<{layer["width"] * layer["height"]}H', t_outs[repo_path(layer['tilemap'])])
        for ty in range(layer['height']):
            for tx in range(layer['width']):
                got = _render_word(g_words[tilemap_index(tx, ty, layer['width'])], layer,
                                   [new_tiles], g_cgram, 16, False)
                assert got == _read_cell(g_px, tx, ty, False), f'compacted Gate differs at ({tx}, {ty})'

        # 6. --compact refuses sheets another manifest or outside tilemap reads.
        thicket_mp = _copy_scene(os.path.join(SCENES_DIR, 'battle', 'Thicket.scene.json'), tmp, 'thicket')
        _expect_error(lambda: pack_scene(thicket_mp, write=False, compact=True),
                      'EpilogueCredits.scene.json', 'compact of a shared sheet')
        shutil.copy(os.path.join(SCENES_DIR, 'battle', 'Unused16.png'), os.path.dirname(tit_mp))
        _expect_error(lambda: pack_scene(tit_mp, write=False, compact=True), 'title scene',
                      'compact of an external sheet')

        # 7. An edited writable PNG seed sheet is refused (the scene PNG is the source).
        sheet_dir = os.path.join(tmp, 'sheet')
        os.makedirs(sheet_dir)
        logo_comp = repo_path(sheet_source(logo_m['sheets'][0]))
        tmp_sheet = os.path.join(sheet_dir, 'OpeningLogo.4bpp.png')
        shutil.copy(logo_comp, os.path.join(sheet_dir, 'OpeningLogo.4bpp.comp'))
        simg = gfx.bpp_to_png(decompress_comp(logo_comp), gfx.grey(4), 16, depth=4)
        simg.putpixel((0, 0), (simg.getpixel((0, 0)) + 1) % 16)
        simg.save(tmp_sheet)
        orig_img.save(logo_png)
        sheet_m = json.loads(json.dumps(logo_m))
        sheet_m['sheets'][0] = {'png': tmp_sheet, 'max_tiles': 256, 'writable': True}
        write_manifest(tmp_logo_mp, sheet_m)
        _expect_error(lambda: pack_scene(tmp_logo_mp, write=False), 'edit the scene PNG',
                      'edited seed sheet')

        # 8. unpack refuses to overwrite, and with --force rewrites and verifies.
        write_manifest(tmp_logo_mp, logo_m)
        _expect_error(lambda: unpack_scene(tmp_logo_mp), 'pass --force', 'unpack over an existing PNG')
        unpack_scene(tmp_logo_mp, force=True)
        assert Image.open(logo_png).tobytes() == orig_img.convert(Image.open(logo_png).mode).tobytes(), \
            'unpack --force did not reproduce OpeningLogo.png'

        # 9. Negative checks: off-palette colour, VRAM budget, disabled append,
        #    mixed priority cell, bad append_sheet index.
        bad_img = orig_img.copy()
        bad_img.putpixel((0, 0), (1, 2, 3))
        bad_img.save(logo_png)
        try:
            pack_scene(tmp_logo_mp, write=False)
        except ValueError as e:
            assert '(0, 0)' in str(e) and '(1, 2, 3)' in str(e), f'unexpected error message: {e}'
        else:
            raise AssertionError('off-palette colour should fail')

        edited.save(logo_png)
        budget_m = json.loads(json.dumps(logo_m))
        budget_m['sheets'][0]['max_tiles'] = 65
        write_manifest(tmp_logo_mp, budget_m)
        _expect_error(lambda: pack_scene(tmp_logo_mp, write=False), 'VRAM budget', 'VRAM budget overflow')

        fixed_m = json.loads(json.dumps(logo_m))
        fixed_m['layers'][0]['append_sheet'] = None
        write_manifest(tmp_logo_mp, fixed_m)
        _expect_error(lambda: pack_scene(tmp_logo_mp, write=False), 'appending is disabled', 'disabled append')

        idx_m = json.loads(json.dumps(logo_m))
        idx_m['layers'][0]['append_sheet'] = 1
        write_manifest(tmp_logo_mp, idx_m)
        _expect_error(lambda: pack_scene(tmp_logo_mp, write=False), 'append_sheet 1', 'bad append_sheet index')

        pimg = Image.open(pri_png).copy()
        pimg.putpixel((0, 0), 0)
        pimg.putpixel((1, 0), 255)
        pimg.save(pri_png)
        _expect_error(lambda: pack_scene(tmp_throne_mp, write=False), 'mixes priority', 'mixed priority cell')

        # 10. Grid layer edit on an uncompressed UI tilemap (.seed): copying
        #     one entry changes exactly that word; a bad entry is refused.
        st_mp = _copy_scene(os.path.join(UI_LAYOUTS_DIR, 'StatusScreen.scene.json'), tmp, 'status')
        st_m = load_manifest(st_mp)
        st_layer = st_m['layers'][0]
        st_csv = os.path.join(os.path.dirname(st_mp), st_layer['grid'])
        rows = [r.split(',') for r in open(st_csv, encoding='utf-8').read().splitlines()]
        rows[0][1] = rows[0][0]
        open(st_csv, 'w', encoding='utf-8').write(''.join(','.join(r) + '\n' for r in rows))
        _, st_outs = pack_scene(st_mp, write=False)
        st_tm = repo_path(st_layer['tilemap'])
        seed_raw = open(st_tm + '.seed', 'rb').read()
        got_raw = st_outs[st_tm]
        assert got_raw[2:4] == seed_raw[0:2] and got_raw[:2] == seed_raw[:2] and got_raw[4:] == seed_raw[4:], \
            'grid edit did not change only entry (1, 0)'
        rows[0][1] = '400:0'
        open(st_csv, 'w', encoding='utf-8').write(''.join(','.join(r) + '\n' for r in rows))
        _expect_error(lambda: pack_scene(st_mp, write=False), 'cell (1, 0)', 'out-of-range grid tile')

        # 11. Grid layer edit on a compressed UI tilemap, and its LZ round-trip.
        iw_mp = _copy_scene(os.path.join(UI_LAYOUTS_DIR, 'ItemWindow.scene.json'), tmp, 'itemwin')
        iw_m = load_manifest(iw_mp)
        iw_layer = iw_m['layers'][0]
        iw_csv = os.path.join(os.path.dirname(iw_mp), iw_layer['grid'])
        rows = [r.split(',') for r in open(iw_csv, encoding='utf-8').read().splitlines()]
        rows[0][1] = rows[1][0]
        open(iw_csv, 'w', encoding='utf-8').write(''.join(','.join(r) + '\n' for r in rows))
        _, iw_outs = pack_scene(iw_mp, write=False)
        iw_tm = repo_path(iw_layer['tilemap'])
        assert iw_outs[iw_tm] != decompress_comp(iw_tm + '.comp'), 'ItemWindowBG1 grid edit changed nothing'
        iw_lz = gfx.lz(iw_outs[iw_tm], iw_tm + '.comp')
        buf = bytearray(0x400000)
        buf[:len(iw_lz)] = iw_lz
        assert decompress(bytes(buf), 0xC00000)[0] == iw_outs[iw_tm], 'ItemWindowBG1 LZ round-trip failed'

        # 12. Editing a shared sheet reaches every layout that uses the tile:
        #     the tilemap stays the same and the rendered preview changes.
        uw_mp = _copy_scene(os.path.join(UI_LAYOUTS_DIR, 'UnitWindowList.scene.json'), tmp, 'uwlist')
        uw_m = load_manifest(uw_mp)
        before_dir = os.path.join(tmp, 'uw_before')
        render_scene(uw_mp, before_dir)
        wf_copy = os.path.join(tmp, 'WindowFrames.4bpp.png')
        shutil.copy(repo_path(uw_m['sheets'][0]['png']), wf_copy)
        uw_layer = uw_m['layers'][0]
        first = read_grid(os.path.join(os.path.dirname(uw_mp), uw_layer['grid']),
                          uw_layer['width'], uw_layer['height'])[0]
        local = (first & 0x3FF) - uw_layer['sheets'][0]['base']
        wf_img = Image.open(wf_copy).copy()
        tx0, ty0 = local % (wf_img.width // 8) * 8, local // (wf_img.width // 8) * 8
        wf_img.putpixel((tx0 + 3, ty0 + 3), (wf_img.getpixel((tx0 + 3, ty0 + 3)) + 1) % 16)
        wf_img.save(wf_copy)
        uw_m['sheets'][0]['png'] = wf_copy
        write_manifest(uw_mp, uw_m)
        _, uw_outs = pack_scene(uw_mp, write=False)
        uw_tm = repo_path(uw_layer['tilemap'])
        assert uw_outs[uw_tm] == read_comp_bin(uw_tm), 'a sheet edit changed the layout tilemap'
        after_dir = os.path.join(tmp, 'uw_after')
        name = render_scene(uw_mp, after_dir)[0]
        assert Image.open(os.path.join(before_dir, name)).tobytes() != \
            Image.open(os.path.join(after_dir, name)).tobytes(), 'the sheet edit did not reach the preview'

        # 13. A grid layer cannot append, and needs exactly one source.
        bad_m = json.loads(json.dumps(uw_m))
        bad_m['layers'][0]['append_sheet'] = 0
        _expect_error(lambda: validate_manifest(bad_m, 'bad'), 'cannot append', 'grid layer with append_sheet')
        bad_m = json.loads(json.dumps(uw_m))
        bad_m['layers'][0]['png'] = 'x.png'
        _expect_error(lambda: validate_manifest(bad_m, 'bad'), 'exactly one', 'layer with png and grid')

    print(f'{total_layers} of {total_layers} scene/UI layers ({len(mps)} manifests) pack byte-identical; '
          f'tile append, blank-slot reuse, external sheets, priority toggle, compact, seed-sheet '
          f'guard, unpack, LZ recompression, UI grid layers (.seed and compressed edits, shared-sheet edits reaching the layouts), and validation checks passed')


def main():
    ap = argparse.ArgumentParser(description=__doc__.split('\n')[0])
    ap.add_argument('--self-test', action='store_true')
    sub = ap.add_subparsers(dest='cmd')
    p = sub.add_parser('unpack')
    p.add_argument('manifest')
    p.add_argument('--force', action='store_true', help='overwrite existing layer sources')
    p = sub.add_parser('pack')
    p.add_argument('manifest')
    p.add_argument('--compact', action='store_true')
    p = sub.add_parser('render')
    p.add_argument('manifest')
    p.add_argument('out_dir')
    sub.add_parser('build')
    sub.add_parser('clean')
    args = ap.parse_args()

    try:
        if args.self_test:
            self_test()
        elif args.cmd == 'unpack':
            for sheet, n in unpack_scene(args.manifest, force=args.force).items():
                if n:
                    print(f'  {sheet}: {n} unreferenced tiles')
        elif args.cmd == 'pack':
            pack_scene(args.manifest, write=True, compact=args.compact)
        elif args.cmd == 'render':
            for name in render_scene(args.manifest, args.out_dir):
                print(f'  {os.path.join(args.out_dir, name)}')
        elif args.cmd == 'build':
            build()
        elif args.cmd == 'clean':
            clean()
        else:
            ap.print_help()
    except ValueError as e:
        sys.exit(str(e))


if __name__ == '__main__':
    main()
