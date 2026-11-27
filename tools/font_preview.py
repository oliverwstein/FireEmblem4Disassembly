#!/usr/bin/env python3
"""Render DialogueFont*.2bpp.png glyph-grid previews with dialogue codes and advance widths.

usage: tools/font_preview.py OUT_DIR [--scale N]
       tools/font_preview.py --self-test

Reads:
- gfx/fonts/DialogueFont.2bpp.png  (128x1024, 512 glyphs, indices 0..511)
- gfx/fonts/DialogueFont2.2bpp.png (128x1024, 512 glyphs, indices 512..1023)
- gfx/fonts/DialogueFont3.2bpp.png (128x512,  256 glyphs, indices 1024..1279)
- data/dialogue/DialogueFontWidth.asm (1280 .byte advance widths)
- text/dialogue/DialogueFont.txt      (1280 tab-separated glyph labels)

Dialogue code mapping (from rsDialogueLoadCharacterGraphicIntoBuffer):
  font_page = index // 240  (0..5)
  char_byte = 0x10 + (index % 240)  ($10..$FF)
"""
import argparse
import os
import re
import sys
import tempfile

try:
    from PIL import Image, ImageDraw
except ImportError:
    sys.exit('tools/font_preview.py needs Pillow: pip3 install pillow')

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
FONTS_DIR = os.path.join(ROOT, 'gfx', 'fonts')
WIDTHS_ASM = os.path.join(ROOT, 'data', 'dialogue', 'DialogueFontWidth.asm')
FONT_TXT = os.path.join(ROOT, 'text', 'dialogue', 'DialogueFont.txt')

SHEETS = [
    ('DialogueFont.2bpp.png', 0, 512),
    ('DialogueFont2.2bpp.png', 512, 512),
    ('DialogueFont3.2bpp.png', 1024, 256),
]
TOTAL_GLYPHS = 1280


def glyph_code(index):
    """Return (font_page, char_byte) for global glyph index 0..1279."""
    if not 0 <= index < TOTAL_GLYPHS:
        raise ValueError(f'glyph index {index} out of range 0-{TOTAL_GLYPHS - 1}')
    return index // 240, 0x10 + (index % 240)


def code_to_index(font_page, char_byte):
    """Inverse of glyph_code."""
    if not 0x10 <= char_byte <= 0xFF:
        raise ValueError(f'char_byte ${char_byte:02X} out of range $10-$FF')
    idx = font_page * 240 + (char_byte - 0x10)
    if not 0 <= idx < TOTAL_GLYPHS:
        raise ValueError(f'code {font_page}:{char_byte:02X} out of range')
    return idx


def load_widths(path=WIDTHS_ASM):
    widths = []
    with open(path, encoding='utf-8') as f:
        for line in f:
            m = re.match(r'\s*\.byte\s+\$([0-9A-Fa-f]{2})\b', line)
            if m:
                widths.append(int(m.group(1), 16))
    if len(widths) != TOTAL_GLYPHS:
        raise ValueError(f'{path}: expected {TOTAL_GLYPHS} widths, got {len(widths)}')
    return widths


def load_chars(path=FONT_TXT):
    chars = []
    with open(path, encoding='utf-8') as f:
        for line in f:
            chars.extend(line.rstrip('\r\n').split('\t'))
    if len(chars) != TOTAL_GLYPHS:
        raise ValueError(f'{path}: expected {TOTAL_GLYPHS} characters, got {len(chars)}')
    return chars


def _drawn_width(glyph_img):
    px = glyph_img.load()
    max_x = -1
    for y in range(16):
        for x in range(16):
            if px[x, y] != 0:
                if x > max_x:
                    max_x = x
    return max_x + 1


def render_previews(out_dir, scale=2, fonts_dir=FONTS_DIR, widths_path=WIDTHS_ASM, chars_path=FONT_TXT):
    if scale < 1:
        raise ValueError(f'scale must be >= 1, got {scale}')
    widths = load_widths(widths_path)
    chars = load_chars(chars_path)
    os.makedirs(out_dir, exist_ok=True)

    rows_report = []
    overflows = 0

    for filename, base_idx, count in SHEETS:
        sheet_path = os.path.join(fonts_dir, filename)
        img = Image.open(sheet_path)
        if img.mode != 'P':
            raise ValueError(f'{sheet_path}: expected indexed mode P, got {img.mode}')
        expected_h = (count // 8) * 16
        if img.size != (128, expected_h):
            raise ValueError(f'{sheet_path}: expected 128x{expected_h}, got {img.size[0]}x{img.size[1]}')

        g_sz = 16 * scale
        cell_w = max(g_sz + 8, 66)
        cell_h = g_sz + 24
        grid = Image.new('RGB', (8 * cell_w, (count // 8) * cell_h), (28, 28, 32))
        draw = ImageDraw.Draw(grid)

        for local in range(count):
            idx = base_idx + local
            col, row = local % 8, local // 8
            crop = img.crop((col * 16, row * 16, col * 16 + 16, row * 16 + 16))
            dw = _drawn_width(crop)
            w = widths[idx]
            page, ch_byte = glyph_code(idx)
            overflow = dw > w
            if overflow:
                overflows += 1

            ox, oy = col * cell_w + 4, row * cell_h + 2
            scaled = crop.convert('RGB').resize((g_sz, g_sz), Image.NEAREST)
            grid.paste(scaled, (ox, oy))
            draw.rectangle([ox - 1, oy - 1, ox + g_sz, oy + g_sz], outline=(64, 64, 72))

            gx = ox + min(w, 16) * scale
            guide_col = (255, 80, 80) if overflow else (80, 220, 255)
            draw.line([(gx, oy), (gx, oy + g_sz - 1)], fill=guide_col, width=1)

            draw.text((ox, oy + g_sz + 2), f'{page}:{ch_byte:02X} w{w:02d}',
                      fill=(255, 140, 140) if overflow else (210, 210, 210))
            draw.text((ox, oy + g_sz + 12), f'#{idx:04d}', fill=(140, 160, 180))

            rows_report.append(
                f'{idx:4d}\t{page}:{ch_byte:02X}\t{filename}({col},{row:2d})\t'
                f'{w:2d}\t{dw:2d}\t{"OVER" if overflow else "ok"}\t{chars[idx]}'
            )

        out_png = os.path.join(out_dir, filename.replace('.2bpp.png', '.png'))
        grid.save(out_png)

    index_path = os.path.join(out_dir, 'font_index.txt')
    with open(index_path, 'w', encoding='utf-8') as f:
        f.write(f'# DialogueFont index ({TOTAL_GLYPHS} glyphs, {overflows} drawn past advance width)\n')
        f.write('index\tcode\tsheet(col,row)\twidth\tdrawn_w\tstatus\tchar\n')
        f.write('\n'.join(rows_report) + '\n')
    return overflows


def self_test():
    widths = load_widths()
    chars = load_chars()
    assert len(widths) == TOTAL_GLYPHS and len(chars) == TOTAL_GLYPHS
    assert all(1 <= w <= 16 for w in widths), 'unexpected glyph width out of 1..16'

    for idx in (0, 239, 240, 511, 512, 1023, 1024, 1279):
        p, b = glyph_code(idx)
        assert code_to_index(p, b) == idx, f'code round-trip failed for {idx}'

    with tempfile.TemporaryDirectory() as tmp:
        overflows = render_previews(tmp, scale=2)
        for name in ('DialogueFont.png', 'DialogueFont2.png', 'DialogueFont3.png', 'font_index.txt'):
            p = os.path.join(tmp, name)
            assert os.path.exists(p), f'missing output {name}'
        lines = open(os.path.join(tmp, 'font_index.txt'), encoding='utf-8').read().splitlines()
        assert len(lines) == TOTAL_GLYPHS + 2

        bad_w = os.path.join(tmp, 'bad_widths.asm')
        open(bad_w, 'w').write('  .byte $0C\n')
        try:
            load_widths(bad_w)
        except ValueError:
            pass
        else:
            raise AssertionError('short width table should fail')

    print(f'{TOTAL_GLYPHS} glyphs across 3 font sheets verified ({overflows} drawn past advance width); '
          f'code mapping, grid rendering, and validation checks passed')


def main():
    ap = argparse.ArgumentParser(description=__doc__.split('\n')[0])
    ap.add_argument('out', nargs='?')
    ap.add_argument('--scale', type=int, default=2)
    ap.add_argument('--self-test', action='store_true')
    args = ap.parse_args()

    try:
        if args.self_test:
            self_test()
        elif args.out:
            overflows = render_previews(args.out, scale=args.scale)
            print(f'Wrote DialogueFont*.png and font_index.txt to {args.out} ({overflows} width overflows)')
        else:
            ap.print_help()
    except ValueError as e:
        sys.exit(str(e))


if __name__ == '__main__':
    main()
