#!/usr/bin/env python3
"""Item icons manifest, assembly offset compiler, 16x16 icon packer, and previewer.

usage: tools/item_icons.py build
       tools/item_icons.py clean
       tools/item_icons.py preview OUT_DIR [--scale N]
       tools/item_icons.py unpack-icons OUT_DIR
       tools/item_icons.py pack-icons IN_DIR
       tools/item_icons.py add NAME [PNG] [--item ITEM]
       tools/item_icons.py --self-test

Source of truth:
- gfx/icons/ItemIcons.4bpp.png: 128x256 indexed PNG (8 icons across x 16 rows, 16x16 each)
- gfx/icons/ItemIcons.json: ordered icon names (slots 0..N-1) and 140 item -> icon mappings

build generates data/item/ItemIconOffsets.asm (gitignored) from ItemIcons.json.
"""
import argparse
import csv
import json
import os
import re
import shutil
import struct
import sys
import tempfile

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import gfx

try:
    from PIL import Image, ImageDraw
except ImportError:
    sys.exit('tools/item_icons.py needs Pillow: pip3 install pillow')

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
MANIFEST_PATH = os.path.join(ROOT, 'gfx', 'icons', 'ItemIcons.json')
OFFSETS_ASM = os.path.join(ROOT, 'data', 'item', 'ItemIconOffsets.asm')

HEADER = (
    '; One per item ID: the item\'s icon on the sheet g4bppItemIcons, as an icon\n'
    '; number (ItemIconOffset turns it into the offset rlCopyItemIcon adds).\n\n'
)


def repo_path(rel):
    return rel if os.path.isabs(rel) else os.path.join(ROOT, rel)


def load_manifest(path=MANIFEST_PATH):
    with open(path, encoding='utf-8') as f:
        m = json.load(f)
    icons = m.get('icons') or []
    max_icons = m.get('max_icons', 128)
    if len(icons) > max_icons:
        raise ValueError(f'{path}: {len(icons)} icons exceeds max_icons ({max_icons})')
    seen = set()
    for name in icons:
        if not name or name in seen:
            raise ValueError(f'{path}: duplicate or empty icon name {name!r}')
        seen.add(name)
    for idx, entry in enumerate(m.get('items') or []):
        if entry.get('icon') not in seen:
            raise ValueError(f'{path}: item {idx} ({entry.get("item")!r}) references unknown icon {entry.get("icon")!r}')
    return m


def validate_sheet(sheet_path, min_icons):
    img = Image.open(sheet_path)
    if img.mode != 'P':
        raise ValueError(f'{sheet_path}: expected indexed mode P, got {img.mode}')
    if img.size != (128, 256):
        raise ValueError(f'{sheet_path}: expected 128x256, got {img.size[0]}x{img.size[1]}')
    max_slots = (img.width // 16) * (img.height // 16)
    if min_icons > max_slots:
        raise ValueError(f'{sheet_path}: {min_icons} icons exceeds sheet capacity ({max_slots})')
    px = img.load()
    for y in range(img.height):
        for x in range(img.width):
            if px[x, y] >= 16:
                raise ValueError(f'{sheet_path}: pixel ({x}, {y}) uses colour {px[x, y]}; 4bpp supports 0-15')
    return img


def render_offsets_asm(manifest):
    icon_index = {name: i for i, name in enumerate(manifest['icons'])}
    lines = [HEADER]
    for entry in manifest['items']:
        lines.append(f"  .word ItemIconOffset({icon_index[entry['icon']]:3d}) ; {entry['item']}\n")
    return ''.join(lines)


def check_items(m, manifest_path=MANIFEST_PATH):
    """The items list is indexed by item ID: its names must follow data/item/ItemData.csv.

    Rows past the last item are padding the table carries, named "(no item)".
    """
    rows = list(csv.reader(open(os.path.join(ROOT, 'data', 'item', 'ItemData.csv'), encoding='utf-8')))[1:]
    names = [r[0] or r[1] for r in rows]
    items = [e['item'] for e in m['items']]
    if len(items) < len(names):
        raise ValueError(f'{manifest_path}: {len(items)} item rows, but ItemData.csv has {len(names)} items')
    for i, (want, got) in enumerate(zip(names, items)):
        if want != got:
            raise ValueError(f'{manifest_path}: item row {i} is {got!r}, but ItemData.csv item {i} is {want!r}')
    extra = [x for x in items[len(names):] if x != '(no item)']
    if extra:
        raise ValueError(f'{manifest_path}: rows past the last item must be "(no item)", got {extra}')


def build(manifest_path=MANIFEST_PATH, out_path=OFFSETS_ASM):
    m = load_manifest(manifest_path)
    check_items(m, manifest_path)
    sheet_path = repo_path(m['sheet'])
    validate_sheet(sheet_path, len(m['icons']))
    in_mtime = max(os.path.getmtime(manifest_path), os.path.getmtime(sheet_path))
    if os.path.exists(out_path) and in_mtime <= os.path.getmtime(out_path):
        return False
    text = render_offsets_asm(m)
    os.makedirs(os.path.dirname(out_path), exist_ok=True)
    with open(out_path, 'w', encoding='utf-8') as f:
        f.write(text)
    return True


def clean(out_path=OFFSETS_ASM):
    if os.path.exists(out_path):
        os.remove(out_path)


def icon_crop(sheet_img, number):
    x, y = number % 8 * 16, number // 8 * 16
    return sheet_img.crop((x, y, x + 16, y + 16))


def preview(out_dir, scale=2, manifest_path=MANIFEST_PATH):
    m = load_manifest(manifest_path)
    sheet_img = validate_sheet(repo_path(m['sheet']), len(m['icons'])).convert('RGB')
    icons = m['icons']
    icon_index = {name: i for i, name in enumerate(icons)}
    rows = list(csv.reader(open(os.path.join(ROOT, 'data', 'item', 'ItemData.csv'), encoding='utf-8')))[1:]
    names = [r[0] or r[1] for r in rows]
    os.makedirs(out_dir, exist_ok=True)

    cell_w, cell_h = 96, 30
    grid = Image.new('RGB', (8 * cell_w, ((len(icons) + 7) // 8) * cell_h), (32, 32, 32))
    draw = ImageDraw.Draw(grid)
    for n, name in enumerate(icons):
        x, y = (n % 8) * cell_w + 4, (n // 8) * cell_h + 2
        grid.paste(icon_crop(sheet_img, n), (x, y))
        draw.text((x + 18, y), f'{n:3d}', fill=(200, 200, 200))
        draw.text((x, y + 17), name[:15], fill=(180, 210, 240))
    grid.resize((grid.width * scale, grid.height * scale), Image.NEAREST).save(os.path.join(out_dir, 'sheet.png'))

    cols = 4
    items_img = Image.new('RGB', (cols * 160, ((len(m['items']) + cols - 1) // cols) * 20), (32, 32, 32))
    draw = ImageDraw.Draw(items_img)
    for i, entry in enumerate(m['items']):
        n = icon_index[entry['icon']]
        x, y = (i % cols) * 160 + 2, (i // cols) * 20 + 2
        items_img.paste(icon_crop(sheet_img, n), (x, y))
        label = names[i] if i < len(names) else entry['item']
        draw.text((x + 20, y + 3), f'{i:02X} {label[:18]}', fill=(220, 220, 220))
    items_img.resize((items_img.width * scale, items_img.height * scale), Image.NEAREST).save(
        os.path.join(out_dir, 'items.png'))
    print(f'Wrote sheet.png ({len(icons)} icons) and items.png ({len(m["items"])} items) to {out_dir}')


def unpack_icons(out_dir, manifest_path=MANIFEST_PATH):
    m = load_manifest(manifest_path)
    sheet_img = validate_sheet(repo_path(m['sheet']), len(m['icons']))
    os.makedirs(out_dir, exist_ok=True)
    for n, name in enumerate(m['icons']):
        icon_crop(sheet_img, n).save(os.path.join(out_dir, f'{name}.png'))
    return len(m['icons'])


def _validate_icon_png(path):
    img = Image.open(path)
    if img.mode != 'P':
        raise ValueError(f'{path}: expected indexed mode P, got {img.mode}')
    if img.size != (16, 16):
        raise ValueError(f'{path}: expected 16x16, got {img.size[0]}x{img.size[1]}')
    px = img.load()
    for y in range(16):
        for x in range(16):
            if px[x, y] >= 16:
                raise ValueError(f'{path}: pixel ({x}, {y}) uses colour {px[x, y]}; 4bpp supports 0-15')
    return img


def pack_icons(in_dir, manifest_path=MANIFEST_PATH):
    m = load_manifest(manifest_path)
    sheet_path = repo_path(m['sheet'])
    orig = validate_sheet(sheet_path, len(m['icons']))
    out = Image.new('P', orig.size, 0)
    pal = orig.getpalette()
    if pal:
        out.putpalette(pal)
    for n, name in enumerate(m['icons']):
        icon_path = os.path.join(in_dir, f'{name}.png')
        if not os.path.exists(icon_path):
            raise ValueError(f'missing icon PNG: {icon_path}')
        ic = _validate_icon_png(icon_path)
        out.paste(ic, ((n % 8) * 16, (n // 8) * 16))
    out.save(sheet_path)
    return len(m['icons'])


def add_icon(name, png_path=None, item_name=None, manifest_path=MANIFEST_PATH, out_path=OFFSETS_ASM):
    m = load_manifest(manifest_path)
    if not name or name in m['icons']:
        raise ValueError(f'invalid or duplicate icon name: {name!r}')
    if len(m['icons']) >= m.get('max_icons', 128):
        raise ValueError(f'cannot add {name!r}: reached max_icons ({m.get("max_icons", 128)})')
    slot = len(m['icons'])
    sheet_path = repo_path(m['sheet'])
    sheet = validate_sheet(sheet_path, slot)
    if png_path is not None:
        ic = _validate_icon_png(png_path)
        sheet = sheet.copy()
        sheet.paste(ic, ((slot % 8) * 16, (slot // 8) * 16))
        sheet.save(sheet_path)
    m['icons'].append(name)
    if item_name is not None:
        matched = [e for e in m['items'] if e['item'] == item_name]
        if not matched:
            raise ValueError(f'unknown item name in {manifest_path}: {item_name!r}')
        for e in matched:
            e['icon'] = name
    with open(manifest_path, 'w', encoding='utf-8') as f:
        f.write(json.dumps(m, indent=2, ensure_ascii=False) + '\n')
    build(manifest_path, out_path)
    return slot


def self_test():
    m = load_manifest(MANIFEST_PATH)
    assert len(m['icons']) == 111
    assert len(m['items']) == 140
    check_items(m)
    for mutate, needle in ((lambda b: b['items'][5].update(item='Wrong'), 'item row 5'),
                           (lambda b: b['items'].pop(), None),
                           (lambda b: b['items'][-1].update(item='Extra'), '(no item)'),
                           (lambda b: b['items'].__delitem__(slice(130, None)), 'ItemData.csv has')):
        bad = json.loads(json.dumps(m))
        mutate(bad)
        try:
            check_items(bad)
        except ValueError as e:
            assert needle and needle in str(e), f'unexpected item check error: {e}'
        else:
            assert needle is None, f'item check should fail ({needle})'
    asm_text = render_offsets_asm(m)

    # Check exact bytes against fe4.sfc if present, and against ItemIconOffset formula.
    icon_idx = {name: i for i, name in enumerate(m['icons'])}
    expected_words = [((icon_idx[e['icon']] // 8) * 0x400) + ((icon_idx[e['icon']] % 8) * 0x40)
                      for e in m['items']]
    parsed = [int(x) for x in re.findall(r'\.word ItemIconOffset\(\s*(\d+)\)', asm_text)]
    assert len(parsed) == 140
    assert [((n // 8) * 0x400) + ((n % 8) * 0x40) for n in parsed] == expected_words

    labels_path = os.path.join(ROOT, 'labels.txt')
    rom_path = os.path.join(ROOT, 'fe4.sfc')
    if os.path.exists(labels_path) and os.path.exists(rom_path):
        from decompress import rom_offset
        from portraits import load_labels
        labels = load_labels()
        if 'aItemIconOffsets' in labels:
            rom = open(rom_path, 'rb').read()
            off = rom_offset(labels['aItemIconOffsets'])
            rom_words = list(struct.unpack('<140H', rom[off:off + 280]))
            assert rom_words == expected_words, 'ItemIcons.json does not match ROM aItemIconOffsets'

    orig_bpp = gfx.png_to_bpp(repo_path(m['sheet']), 4)

    with tempfile.TemporaryDirectory() as tmp:
        # 1. build + unpack-icons + pack-icons round-trip
        tmp_manifest = os.path.join(tmp, 'ItemIcons.json')
        tmp_sheet = os.path.join(tmp, 'ItemIcons.4bpp.png')
        tmp_asm = os.path.join(tmp, 'ItemIconOffsets.asm')
        shutil.copy(repo_path(m['sheet']), tmp_sheet)
        tm = json.loads(json.dumps(m))
        tm['sheet'] = tmp_sheet
        with open(tmp_manifest, 'w', encoding='utf-8') as f:
            json.dump(tm, f)
        assert build(tmp_manifest, tmp_asm)
        assert open(tmp_asm, encoding='utf-8').read() == asm_text

        icons_dir = os.path.join(tmp, 'icons')
        assert unpack_icons(icons_dir, tmp_manifest) == 111
        assert pack_icons(icons_dir, tmp_manifest) == 111
        assert gfx.png_to_bpp(tmp_sheet, 4) == orig_bpp, 'unpack-icons -> pack-icons changed .4bpp bytes'

        # 2. preview
        prev_dir = os.path.join(tmp, 'preview')
        preview(prev_dir, scale=1, manifest_path=tmp_manifest)
        assert os.path.exists(os.path.join(prev_dir, 'sheet.png'))
        assert os.path.exists(os.path.join(prev_dir, 'items.png'))

        # 3. add icon + assign to item
        new_ic = os.path.join(tmp, 'TestIcon.png')
        im = Image.new('P', (16, 16), 3)
        im.putpalette(Image.open(tmp_sheet).getpalette())
        im.save(new_ic)
        slot = add_icon('TestIcon', new_ic, item_name='Circlet', manifest_path=tmp_manifest, out_path=tmp_asm)
        assert slot == 111
        new_asm = open(tmp_asm, encoding='utf-8').read()
        assert 'ItemIconOffset(111) ; Circlet' in new_asm
        assert gfx.png_to_bpp(tmp_sheet, 4) != orig_bpp

        # 4. Negative checks
        for bad_fn, desc in (
            (lambda: add_icon('IronSword', manifest_path=tmp_manifest, out_path=tmp_asm), 'duplicate icon'),
            (lambda: add_icon('BadItem', item_name='NoSuchItem', manifest_path=tmp_manifest, out_path=tmp_asm), 'unknown item'),
        ):
            try:
                bad_fn()
            except ValueError:
                pass
            else:
                raise AssertionError(f'{desc} should fail')

        over_m = json.loads(json.dumps(tm))
        over_m['icons'] = [f'Icon{i}' for i in range(129)]
        over_p = os.path.join(tmp, 'over.json')
        with open(over_p, 'w') as f:
            json.dump(over_m, f)
        try:
            load_manifest(over_p)
        except ValueError:
            pass
        else:
            raise AssertionError('max_icons overflow should fail')

        bad_png = os.path.join(tmp, 'bad.png')
        Image.new('RGB', (16, 16)).save(bad_png)
        try:
            _validate_icon_png(bad_png)
        except ValueError:
            pass
        else:
            raise AssertionError('RGB icon PNG should fail')

    print('111 item icons (140 items) build byte-identical; unpack-icons/pack-icons, preview, add, and validation checks passed')


def main():
    ap = argparse.ArgumentParser(description=__doc__.split('\n')[0])
    ap.add_argument('--self-test', action='store_true')
    sub = ap.add_subparsers(dest='cmd')
    sub.add_parser('build')
    sub.add_parser('clean')
    p = sub.add_parser('preview')
    p.add_argument('out')
    p.add_argument('--scale', type=int, default=2)
    p = sub.add_parser('unpack-icons')
    p.add_argument('out')
    p = sub.add_parser('pack-icons')
    p.add_argument('in_dir')
    p = sub.add_parser('add')
    p.add_argument('name')
    p.add_argument('png', nargs='?')
    p.add_argument('--item')
    args = ap.parse_args()

    try:
        if args.self_test:
            self_test()
        elif args.cmd == 'build':
            build()
        elif args.cmd == 'clean':
            clean()
        elif args.cmd == 'preview':
            preview(args.out, scale=args.scale)
        elif args.cmd == 'unpack-icons':
            n = unpack_icons(args.out)
            print(f'Unpacked {n} icons to {args.out}')
        elif args.cmd == 'pack-icons':
            n = pack_icons(args.in_dir)
            print(f'Packed {n} icons into {MANIFEST_PATH}')
        elif args.cmd == 'add':
            slot = add_icon(args.name, args.png, item_name=args.item)
            print(f'Added icon {args.name} at slot {slot}')
        else:
            ap.print_help()
    except ValueError as e:
        sys.exit(str(e))


if __name__ == '__main__':
    main()
