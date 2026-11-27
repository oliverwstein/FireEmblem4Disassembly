#!/usr/bin/env python3
"""Build compressed BGR555 palette streams from authored bgr555() assembly sources.

Usage:
  tools/palettes.py build           Build stale .bin files in gfx/build/9C8000/
  tools/palettes.py clean           Remove generated .bin files
  tools/palettes.py unpack [--force]
                                    Extract .asm sources from committed .bin.comp
  tools/palettes.py --self-test     Verify byte-identical round-trip, edit+LZ, validation
"""
import argparse
import os
import re
import sys
import tempfile

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from decompress import decompress
import gfx

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

PALETTES = [
    ('acSaveMenuPalettes',
     'data/palettes/SaveMenuPalettes.asm',
     'gfx/build/9C8000/acSaveMenuPalettes.bin',
     'Save menu palettes (256 BGR555 colors).'),
    ('acWarningScreenPalettes',
     'data/palettes/WarningScreenPalettes.asm',
     'gfx/build/9C8000/acWarningScreenPalettes.bin',
     'Anti-piracy and abnormality warning screen palettes (256 BGR555 colors).'),
    ('acBattleBannerPalettes',
     'data/palettes/BattleBannerPalettes.asm',
     'gfx/build/9C8000/acBattleBannerPalettes.bin',
     'House battle banner palettes (256 BGR555 colors).'),
]

BGR555_RE = re.compile(r'bgr555\(\s*(-?\d+)\s*,\s*(-?\d+)\s*,\s*(-?\d+)\s*\)')


def parse_palette_asm(path):
    """Parse bgr555(r, g, b) calls in path into 512 little-endian bytes."""
    words = []
    with open(path, encoding='utf-8') as f:
        for lineno, line in enumerate(f, 1):
            code = line.split(';', 1)[0]
            for m in BGR555_RE.finditer(code):
                r, g, b = (int(x) for x in m.groups())
                for name, v in (('r', r), ('g', g), ('b', b)):
                    if not (0 <= v <= 31):
                        raise ValueError(f'{path}:{lineno}: {name}={v} out of range 0..31')
                words.append((b << 10) | (g << 5) | r)
    if len(words) != 256:
        raise ValueError(f'{path}: expected 256 bgr555() colors, got {len(words)}')
    out = bytearray()
    for w in words:
        out.append(w & 0xFF)
        out.append((w >> 8) & 0xFF)
    return bytes(out)


def format_palette_asm(label, comment, data):
    """Format 512 bytes of BGR555 colors as a bgr555() assembly file."""
    if len(data) != 512:
        raise ValueError(f'{label}: expected 512 bytes, got {len(data)}')
    lines = [
        f'; {comment}',
        f'; Built to gfx/build/9C8000/{label}.bin by tools/palettes.py.',
        '',
        label,
    ]
    for pal in range(16):
        lines.append(f'  ; Palette {pal}')
        for row in range(2):
            base = (pal * 16 + row * 8) * 2
            entries = []
            for i in range(8):
                w = data[base + i * 2] | (data[base + i * 2 + 1] << 8)
                r = w & 31
                g = (w >> 5) & 31
                b = (w >> 10) & 31
                entries.append(f'bgr555({r:2d}, {g:2d}, {b:2d})')
            lines.append('  .word ' + ', '.join(entries))
    lines.append('')
    return '\n'.join(lines)


def _decompress_comp(comp_path):
    raw = open(comp_path, 'rb').read()
    buf = bytearray(0x400000)
    buf[:len(raw)] = raw
    return decompress(bytes(buf), 0xC00000)[0]


def cmd_build():
    built = 0
    for _label, src_rel, out_rel, _comment in PALETTES:
        src_p = os.path.join(ROOT, src_rel)
        out_p = os.path.join(ROOT, out_rel)
        if not os.path.exists(src_p):
            sys.exit(f'Missing palette source: {src_rel}')
        if not os.path.exists(out_p) or os.path.getmtime(src_p) > os.path.getmtime(out_p):
            data = parse_palette_asm(src_p)
            os.makedirs(os.path.dirname(out_p), exist_ok=True)
            with open(out_p, 'wb') as f:
                f.write(data)
            built += 1
    print(f'Built {built} compressed palette(s).')
    return 0


def cmd_clean():
    removed = 0
    for _label, _src_rel, out_rel, _comment in PALETTES:
        out_p = os.path.join(ROOT, out_rel)
        if os.path.exists(out_p):
            os.remove(out_p)
            removed += 1
    print(f'Cleaned {removed} generated palette .bin file(s).')
    return 0


def cmd_unpack(force=False):
    for label, src_rel, out_rel, comment in PALETTES:
        src_p = os.path.join(ROOT, src_rel)
        comp_p = os.path.join(ROOT, out_rel + '.comp')
        if os.path.exists(src_p) and not force:
            sys.exit(f'{src_rel} already exists (use --force to overwrite)')
        data = _decompress_comp(comp_p)
        text = format_palette_asm(label, comment, data)
        os.makedirs(os.path.dirname(src_p), exist_ok=True)
        with open(src_p, 'w', encoding='utf-8') as f:
            f.write(text)
        print(f'Wrote {src_rel}')
    return 0


def self_test():
    for label, src_rel, out_rel, _comment in PALETTES:
        src_p = os.path.join(ROOT, src_rel)
        comp_p = os.path.join(ROOT, out_rel + '.comp')
        expected = _decompress_comp(comp_p)
        actual = parse_palette_asm(src_p)
        assert actual == expected, f'{src_rel} does not match {out_rel}.comp'

    # Test edit + gfx.lz recompression round-trip
    with tempfile.TemporaryDirectory() as tmp:
        test_asm = os.path.join(tmp, 'TestPalette.asm')
        src_p = os.path.join(ROOT, PALETTES[0][1])
        comp_p = os.path.join(ROOT, PALETTES[0][2] + '.comp')
        txt = open(src_p, encoding='utf-8').read()
        edited_txt = txt.replace('bgr555( 0,  0,  0)', 'bgr555(31,  0, 15)', 1)
        assert edited_txt != txt
        open(test_asm, 'w', encoding='utf-8').write(edited_txt)
        edited_bin = parse_palette_asm(test_asm)
        lz_bytes = gfx.lz(edited_bin, comp_p)
        buf = bytearray(0x400000)
        buf[:len(lz_bytes)] = lz_bytes
        assert decompress(bytes(buf), 0xC00000)[0] == edited_bin, 'LZ round-trip failed'

        # Test out-of-range channel validation
        bad_asm = os.path.join(tmp, 'BadPalette.asm')
        open(bad_asm, 'w', encoding='utf-8').write(txt.replace('bgr555( 0,  0,  0)', 'bgr555(32,  0,  0)', 1))
        try:
            parse_palette_asm(bad_asm)
        except ValueError:
            pass
        else:
            raise AssertionError('Expected ValueError for channel > 31')

    print(f'OK: {len(PALETTES)} compressed palettes verified (round-trip, edit+LZ, validation).')
    return 0


def main():
    if sys.argv[1:] == ['--self-test']:
        return self_test()
    ap = argparse.ArgumentParser(description=__doc__.split('\n')[0])
    sub = ap.add_subparsers(dest='cmd', required=True)
    sub.add_parser('build')
    sub.add_parser('clean')
    u = sub.add_parser('unpack')
    u.add_argument('--force', action='store_true')
    args = ap.parse_args()
    if args.cmd == 'build':
        return cmd_build()
    if args.cmd == 'clean':
        return cmd_clean()
    return cmd_unpack(force=args.force)


if __name__ == '__main__':
    sys.exit(main())
