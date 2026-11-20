#!/usr/bin/env python3
"""Decode dialogue in the ROM into the text format tools/process_dialogue.py reads.

usage: tools/dialogue.py ADDR [ADDR ...]       print the text at each address
       tools/dialogue.py --self-test          decode every dialogue file in the
                                              build from the ROM and rebuild

As a module:

    from dialogue import Decoder
    text, end = Decoder().decode(rom, 0x8AD0D4)

decode() reads until DIALOGUE_EOF or DIALOGUE_STACK_EOF and returns the text
and the CPU address after it. The output round-trips: process_dialogue.py turns
it back into the same bytes. That takes some care, because process_dialogue.py
inserts DIALOGUE_FONT_n itself when a character needs another font page, and
keeps track of the page from 0 at the start of each file without counting
explicit {DIALOGUE_FONT_n} codes. So a font switch in the ROM is left out when
the encoder will put it back (it comes right before a character of that page),
and written as {DIALOGUE_FONT_n} otherwise. A character the encoder would place
differently is written as a raw {.byte $XX}.

Control codes come from include/Dialogue.h and the characters from
text/dialogue/Dialogue.h (the .edef tables) and text/dialogue/DialogueFont.txt
(which page the encoder uses for each glyph). Arguments are written the way the
existing files write them: portraits as PortraitXxx (data/character/
PortraitDataIDs.csv), characters by name, pointers as labels when one is at the
address, coordinates as [x, y], pauses and speeds in decimal.
"""
import csv
import os
import re
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from decompress import rom_offset

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

# Codes after which the text file breaks the line, as the existing files do.
LINE_BREAK_AFTER = {'DIALOGUE_NL', 'DIALOGUE_WAIT_PRESS', 'DIALOGUE_SCROLL',
                    'DIALOGUE_SCROLL_ALL', 'DIALOGUE_CLEAR', 'DIALOGUE_EOF',
                    'DIALOGUE_STACK_EOF', 'DIALOGUE_STACK_NL', 'DIALOGUE_LOAD_PORTRAIT',
                    'DIALOGUE_UNLOAD_PORTRAIT', 'DIALOGUE_CLOSE_BOX'}
DECIMAL_ARGS = {'DIALOGUE_PAUSE', 'DIALOGUE_SET_SPEED'}
PORTRAIT_ARGS = {'DIALOGUE_LOAD_PORTRAIT', 'DIALOGUE_WM_LOAD_PORTRAIT'}
CHARACTER_ARGS = {'DIALOGUE_CHILD_NAME'}
ENDS = {'DIALOGUE_EOF', 'DIALOGUE_STACK_EOF'}


def read_segments(path):
    """{code bytes: (name, [(param, size, part)])} from the .segment macros."""
    text = open(path, encoding='utf-8').read()
    out = {}
    for m in re.finditer(r'^\s*(DIALOGUE_\w+) \.segment ?([^\n]*)\n(.*?)\.endsegment', text, re.M | re.S):
        name, body = m.group(1), m.group(3)
        lines = [l.split(';')[0].strip() for l in body.split('\n')]
        lines = [l for l in lines if l.startswith('.')]
        code = []
        args = []
        for l in lines:
            d, _, val = l.partition(' ')
            if '\\' not in val:
                if d == '.byte':
                    code += [eval(v.replace('$', '0x')) for v in val.split(',')]
                continue
            p = re.match(r'\\(\w+)(?:\[(\d)\])?', val)
            size = {'.byte': 1, '.char': 1, '.word': 2, '.long': 3}[d]
            args.append((p.group(1), size, p.group(2), d))
        if not code:
            continue
        out[tuple(code)] = (name, args)
    return out


def read_pages(header, font):
    """Glyph tables per page, and the page the encoder picks for each glyph."""
    tables, page = {}, None
    for line in open(header, encoding='utf-8'):
        m = re.match(r'\.enc "DialoguePage(\d)"', line)
        if m:
            page = int(m.group(1))
            tables[page] = {}
        m = re.match(r'\s*\.edef "(.*)", \$([0-9A-Fa-f]{2})', line)
        if m and page is not None and m.group(1) != '\\n':
            tables[page][int(m.group(2), 16)] = m.group(1)
    encoder_page = {}
    for line_no, line in enumerate(open(font, encoding='utf-8')):
        for glyph in line.rstrip('\n').split('\t'):
            encoder_page[glyph] = line_no * 8 // (256 - 16)
    return tables, encoder_page


def load_names():
    labels = {}
    path = os.path.join(ROOT, 'labels.txt')
    if os.path.exists(path):
        for line in open(path):
            parts = line.split()
            if len(parts) == 3 and ':' not in parts[2]:
                labels.setdefault(int(parts[1], 16), parts[2].lstrip('.'))
    portraits = {}
    rows = list(csv.reader(open(os.path.join(ROOT, 'data', 'character', 'PortraitDataIDs.csv'))))
    start = int(rows[0][0].split()[1])
    for k, row in enumerate(rows[1:]):
        portraits[start + k] = row[0]
    characters = {}
    rows = list(csv.reader(open(os.path.join(ROOT, 'data', 'character', 'CharacterData.csv'))))
    start = int(rows[0][0].split()[1])
    for k, row in enumerate(rows[1:]):
        name = row[0] or row[1] or row[2]
        if name:
            characters[start + k] = name
    return labels, portraits, characters


class Decoder:
    def __init__(self):
        self.segments = read_segments(os.path.join(ROOT, 'include', 'Dialogue.h'))
        self.tables, self.encoder_page = read_pages(
            os.path.join(ROOT, 'text', 'dialogue', 'Dialogue.h'),
            os.path.join(ROOT, 'text', 'dialogue', 'DialogueFont.txt'))
        self.labels, self.portraits, self.characters = load_names()
        self.raw_pointers = []          # (address in text, value) of unlabelled pointers

    def glyph(self, page, byte):
        g = self.tables.get(page, {}).get(byte)
        if g is not None and self.encoder_page.get(g) == page:
            return g
        return None                     # not a character the encoder would place here

    def format_arg(self, name, size, directive, value):
        if size == 3:
            if value in self.labels:
                return self.labels[value]
            return f'${value:06X}'
        if name in PORTRAIT_ARGS and size == 2 and value in self.portraits:
            return self.portraits[value]
        if name in CHARACTER_ARGS and value in self.characters:
            return self.characters[value]
        if name in DECIMAL_ARGS:
            if directive == '.char' and value >= 0x80:
                value -= 0x100
            return 'DS_Options' if name == 'DIALOGUE_SET_SPEED' and value == -3 else str(value)
        return f'${value:0{size * 2}X}'

    def decode(self, rom, start, end=None):
        """Text from `start` to its EOF, or to `end` if that comes first (a text
        that runs into the next one without an EOF), and the address after it."""
        def byte(a):
            return rom[rom_offset(a)]

        out = []
        line = []
        runtime, tracked = 0, 0          # the game's font page, and the encoder's
        a = start
        while end is None or a < end:
            b = byte(a)
            if b >= 0x10:                                    # a character
                g = self.glyph(runtime, b)
                if g is not None and runtime == tracked:
                    line.append(g)
                else:
                    line.append(f'{{.byte ${b:02X}}}')
                a += 1
                continue
            if 0x09 <= b <= 0x0E:                            # DIALOGUE_FONT_n
                n = b - 9
                nxt = byte(a + 1)
                if n != tracked and nxt >= 0x10 and self.glyph(n, nxt) is not None:
                    tracked = n                              # the encoder puts it back
                else:
                    line.append(f'{{DIALOGUE_FONT_{n}}}')
                runtime = n
                a += 1
                continue
            if b == 0x0F:                                    # a copy of DIALOGUE_FONT_5
                line.append('{.byte $0F}')
                runtime = 5
                a += 1
                continue
            key = (b,) if b else (0, byte(a + 1))
            if key not in self.segments:
                raw = ', '.join(f'${x:02X}' for x in key)
                line.append(f'{{.byte {raw}}}')
                a += len(key)
                continue
            name, params = self.segments[key]
            a += len(key)
            args, coords = [], {}
            for pname, size, part, directive in params:
                v = sum(byte(a + i) << (8 * i) for i in range(size))
                if size == 3:
                    if v not in self.labels:
                        self.raw_pointers.append((a, v))
                a += size
                if part is not None:
                    coords.setdefault(pname, []).append(v)
                    if len(coords[pname]) == 2:
                        args.append(f'[{coords[pname][0]}, {coords[pname][1]}]')
                    continue
                args.append(self.format_arg(name, size, directive, v))
            line.append('{' + name + (' ' + ', '.join(args) if args else '') + '}')
            if name in LINE_BREAK_AFTER:
                out.append(''.join(line))
                line = []
            if name in ENDS:
                break
        if line:
            out.append(''.join(line))
        return '\n'.join(out) + '\n', a


def self_test():
    """Decode every dialogue file in the build from the ROM, rebuild with those."""
    import shutil
    import subprocess
    import tempfile
    rom = open(os.path.join(ROOT, 'fe4.sfc'), 'rb').read()
    dec = Decoder()
    addr = {}
    for line in open(os.path.join(ROOT, 'labels.txt')):
        parts = line.split()
        if len(parts) == 3:
            addr[parts[2].lstrip('.')] = int(parts[1], 16)
    starts = sorted(a for name, a in addr.items() if ':' not in name and a >= 0x800000)
    files = []
    for line in open(os.path.join(ROOT, 'build.asm'), encoding='utf-8'):
        m = re.match(r'\s*(\w+)\s+\.include\s+"(text/dialogue/\S+)\.dialogue\.txt"', line)
        if m and m.group(1) in addr:
            files.append((m.group(1), m.group(2) + '.txt'))
    tmp = tempfile.mkdtemp()
    try:
        src = os.path.join(tmp, 'src')
        subprocess.run(['rsync', '-a', '--exclude', '.git', '--exclude', '*.dialogue.txt',
                        ROOT + '/', src + '/'], check=True)
        raw_chars = 0
        import bisect
        for label, path in files:
            a = addr[label]
            nxt = starts[bisect.bisect_right(starts, a)]      # the next label ends it
            text, _ = dec.decode(rom, a, nxt)
            raw_chars += text.count('{.byte')
            open(os.path.join(src, path), 'w', encoding='utf-8').write(text)
        res = subprocess.run(['./build.sh'], cwd=src, capture_output=True, text=True)
        print(f'Decoded {len(files)} dialogue files from the ROM ({raw_chars} raw bytes kept as '
              f'{{.byte}}) and rebuilt: {(res.stdout + res.stderr).strip().splitlines()[-1]}')
        return res.returncode
    finally:
        shutil.rmtree(tmp)


def main():
    args = sys.argv[1:]
    if args == ['--self-test']:
        return self_test()
    if not args:
        sys.exit(__doc__)
    rom = open(os.path.join(ROOT, 'fe4.sfc'), 'rb').read()
    dec = Decoder()
    for s in args:
        a = int(s.lstrip('$').replace('/', ''), 16)
        text, end = dec.decode(rom, a)
        print(f'; ${a:06X}-${end:06X}')
        print(text)


if __name__ == '__main__':
    sys.exit(main())
