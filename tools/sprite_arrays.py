#!/usr/bin/env python3
"""Print sprite arrays from the ROM as source, in the form include/Sprites.h reads.

usage: tools/sprite_arrays.py ADDRESS [LABEL] [ADDRESS [LABEL] ...]

ADDRESS is a SNES address such as 89B1F3 or $89/B1F3. A sprite array is a word
count followed by that many 5-byte entries (structSpriteEntry): an X word (bit 15
large size, bits 9-14 a value kept as "Unknown", bits 0-8 a signed X), a signed Y
byte and an attribute word (V/H flip, priority, palette, tile). The output is the
_Sprites list and the .structSpriteArray line that builds the same bytes, and the
address of the first byte after the array.
"""
import os, re, sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from decompress import rom_offset


def signed(v, bits):
    return v - (1 << bits) if v & (1 << (bits - 1)) else v


def decode(rom, address):
    o = rom_offset(address)
    count = rom[o] | rom[o + 1] << 8
    entries = []
    for i in range(count):
        e = rom[o + 2 + 5 * i:o + 7 + 5 * i]
        xw = e[0] | e[1] << 8
        attr = e[3] | e[4] << 8
        entries.append(dict(x=signed(xw & 0x1FF, 9), y=signed(e[2], 8), unknown=(xw >> 9) & 0x3F,
                            large=xw >> 15, tile=attr & 0x1FF, palette=(attr >> 9) & 7,
                            priority=(attr >> 12) & 3, hflip=bool(attr & 0x4000), vflip=bool(attr & 0x8000)))
    return entries, address + 2 + 5 * count


def source(label, entries):
    lines = []
    for i, e in enumerate(entries):
        op = ':=' if i == 0 else '..='
        size = 'SpriteLarge' if e['large'] else 'SpriteSmall'
        lines.append(f"        _Sprites {op} [[({e['x']:4}, {e['y']:4}), ${e['unknown']:02X}, {size}, ${e['tile']:03X}, "
                     f"{e['priority']}, {e['palette']}, {str(e['hflip']).lower()}, {str(e['vflip']).lower()}]]")
    if not entries:
        lines.append('        _Sprites := []')
    lines.append('')
    lines.append(f'        .structSpriteArray {label}._Sprites')
    return '\n'.join(lines)


def main():
    args = sys.argv[1:]
    if not args:
        raise SystemExit(__doc__)
    rom = open('fe4.sfc', 'rb').read()
    i = 0
    while i < len(args):
        address = int(re.sub(r'[$/]', '', args[i]), 16)
        label = args[i + 1] if i + 1 < len(args) and not re.fullmatch(r'\$?[0-9A-Fa-f]{2}/?[0-9A-Fa-f]{4}', args[i + 1]) else None
        i += 2 if label else 1
        label = label or f'aUnknown{address:06X}'
        entries, end = decode(rom, address)
        print(f'      {label} ; {address >> 16:02X}/{address & 0xFFFF:04X}\n')
        print(source(label, entries))
        print(f'\n        ; {end >> 16:02X}/{end & 0xFFFF:04X}\n')


if __name__ == '__main__':
    main()
