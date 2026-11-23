#!/usr/bin/env python3
"""Decode event scripts (and movement scripts) in the ROM into the event macros.

usage: tools/event_script.py START END [--movement] [--label NAME]

Reads the layout of every event command from include/events/Main.h (the opcode
and the size of each argument) and prints START..END (CPU addresses, END
exclusive) as macro source. Jump targets inside the range get local labels
(_XXXX); long pointers to labelled ROM addresses (labels.txt from the last build)
are written as the label, characters by name (data/character/CharacterData.csv.asm). A command the macros cannot express exactly (an
opcode with no macro, or packed bits the macro would lose) is written as .byte
with a comment. With --movement the range is a movement script (MAP_* macros in
include/events/Helpers.h) instead.

Check the result by building: the output must assemble to the same bytes.
"""
import os, re, sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from decompress import rom_offset

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SIZES = {'byte': 1, 'char': 1, 'word': 2, 'sint': 2, 'addr': 2, 'long': 3}


def load_commands():
    text = open(os.path.join(ROOT, 'include/events/Main.h'), encoding='utf-8').read()
    commands = {}
    for m in re.finditer(r'(?ms)^\s+(\w+) \.segment ?([^\n]*)\n(.*?)\.endsegment', text):
        name, params, body = m.groups()
        dirs = re.findall(r'^\s+\.(byte|word|long|addr|char|sint)\s+([^\n;]*)', body, re.M)
        if not dirs or dirs[0][0] != 'byte':
            continue
        try:
            op = int(dirs[0][1].strip().lstrip('$'), 16)
        except ValueError:
            continue
        params = [p.strip().split('=')[0] for p in params.split(',') if p.strip()]
        commands[op] = (name, params, [(d, a.strip()) for d, a in dirs[1:]])
    return commands


def load_labels():
    labels = {}
    path = os.path.join(ROOT, 'labels.txt')
    if os.path.exists(path):
        for line in open(path, encoding='utf-8'):
            parts = line.split()
            if len(parts) == 3 and parts[2].startswith('.') and '.' not in parts[2][1:]:
                labels.setdefault(int(parts[1], 16), parts[2][1:])
    return labels


def load_characters():
    names = {}
    path = os.path.join(ROOT, 'data/character/CharacterData.csv.asm')
    for line in open(path, encoding='utf-8'):
        m = re.match(r'^([A-Za-z]\w*)\s+=\s+(\d+)\s*$', line)
        if m:
            names.setdefault(int(m.group(2)), m.group(1))
    return names


CHARACTERS = None


def value(kind, data):
    v = int.from_bytes(data, 'little')
    if kind == 'char' and v >= 0x80:
        v -= 0x100
    if kind == 'sint' and v >= 0x8000:
        v -= 0x10000
    return v


def hexs(v, width):
    return f'${v:0{width}X}' if v >= 0 else str(v)


def decode_command(rom, addr, commands, labels, start, end, targets):
    """Return (length, source) for the command at addr, or None."""
    off = rom_offset(addr)
    op = rom[off]
    if op == 0xFD:
        return 1, 'YIELD'
    word = rom[off] | rom[off + 1] << 8
    if word == 0xFFFF:
        return 2, 'END_EVENT'
    if word == 0xFEFE:
        return 2, 'EVENT_DUMMY'
    if op not in commands:
        return None
    name, params, dirs = commands[op]
    pos = off + 1
    args = {}
    raw = []
    for kind, expr in dirs:
        size = SIZES[kind]
        data = rom[pos:pos + size]
        pos += size
        v = value(kind, data)
        raw.append((kind, expr, v))
    length = pos - off
    for kind, expr, v in raw:
        m = re.fullmatch(r'\\(\w+)', expr)
        if m:
            p = m.group(1)
            if kind == 'long':
                args[p] = labels.get(v, hexs(v, 6))
            elif kind == 'addr':
                target = (addr & 0xFF0000) | v
                if start <= target < end:
                    targets.add(target)
                    args[p] = f'_{target & 0xFFFF:04X}'
                else:
                    args[p] = labels.get(target, hexs(v, 4))
            elif p == 'CharacterID' and v in CHARACTERS and not name.endswith('_CLASS'):
                args[p] = CHARACTERS[v]
            else:
                args[p] = hexs(v, 2 if SIZES[kind] == 1 else 4)
            continue
        m = re.fullmatch(r'\\(\w+)\[([01])\]', expr)
        if m:
            args.setdefault(m.group(1), [None, None])[int(m.group(2))] = str(v)
            continue
        m = re.fullmatch(r'\(\\(\w+)\) - \*', expr)
        if m:
            target = addr + v
            targets.add(target)
            args[m.group(1)] = f'_{target & 0xFFFF:04X}'
            continue
        if expr == r'\Slot >> 1':
            args['Slot'] = str(v << 1)
            continue
        if name in ('MOVE_TEMPORARY_TO_COORDS', 'MOVE_TEMPORARY_TO_COORDS_FOLLOW', 'MOVE_TEMPORARY_TO_COORDS_CLASS', 'MOVE_TEMPORARY_BY_SCRIPT'):
            args['MovementSpeed'] = str(v & 0x0F)
            if 'DisappearOffscreenFlag' in params:
                args['DisappearOffscreenFlag'] = 'true' if v & 0x10 else 'false'
            if 'UnitSlot' in params:
                args['UnitSlot'] = str(v >> 5 & 3)
            if 'UnknownFlag' in params:
                args['UnknownFlag'] = 'true' if v & 0x80 else 'false'
            lost = v & ~(0x0F | (0x10 if 'DisappearOffscreenFlag' in params else 0)
                         | (0x60 if 'UnitSlot' in params else 0) | (0x80 if 'UnknownFlag' in params else 0))
            if lost & 0xFF:
                return length, None
            continue
        if name == 'LOAD_UNIT_DIRECT':
            if v & 0x70:
                return length, None
            args['GroupLeaderFlag'] = 'true' if v & 0x80 else 'false'
            args['AISetting'] = str(v & 0x0F)
            continue
        return length, None
    out = []
    for p in params:
        a = args.get(p)
        if a is None:
            return length, None
        out.append(f'[{a[0]}, {a[1]}]' if isinstance(a, list) else a)
    return length, (name + (' ' + ', '.join(out) if out else ''))


MOVEMENT = {1: 'MAP_LEFT', 2: 'MAP_RIGHT', 3: 'MAP_UP', 4: 'MAP_DOWN', 5: 'MAP_UP_LEFT',
            6: 'MAP_DOWN_LEFT', 7: 'MAP_UP_RIGHT', 8: 'MAP_DOWN_RIGHT', 0x80: 'MAP_END',
            0x81: 'MAP_HALT', 0x82: 'MAP_82', 0x83: 'MAP_83', 0x85: 'MAP_FACE_LEFT',
            0x86: 'MAP_FACE_RIGHT', 0x87: 'MAP_FACE_UP', 0x88: 'MAP_FACE_DOWN'}
MOVEMENT_ARG = {0x0A: 'MAP_LEFT_MULTIPLE', 0x0B: 'MAP_RIGHT_MULTIPLE', 0x0C: 'MAP_UP_MULTIPLE',
                0x0D: 'MAP_DOWN_MULTIPLE', 0x0E: 'MAP_UP_LEFT_MULTIPLE', 0x0F: 'MAP_DOWN_LEFT_MULTIPLE',
                0x10: 'MAP_UP_RIGHT_MULTIPLE', 0x11: 'MAP_DOWN_RIGHT_MULTIPLE', 0x12: 'MAP_PAUSE',
                0x84: 'MAP_SET_SPEED'}


def decode_movement(rom, start, end):
    lines, addr = [], start
    while addr < end:
        b = rom[rom_offset(addr)]
        if b in MOVEMENT_ARG and addr + 1 < end:
            lines.append((addr, f'{MOVEMENT_ARG[b]} {rom[rom_offset(addr) + 1]}'))
            addr += 2
        elif b in MOVEMENT:
            lines.append((addr, MOVEMENT[b]))
            addr += 1
        else:
            lines.append((addr, f'.byte ${b:02X}'))
            addr += 1
    return lines


def decode_events(rom, start, end):
    global CHARACTERS
    CHARACTERS = load_characters()
    commands, labels = load_commands(), load_labels()
    lines, targets, addr = [], set(), start
    while addr < end:
        r = decode_command(rom, addr, commands, labels, start, end, targets)
        if r and r[0] and addr + r[0] <= end:
            length, src = r
            data = rom[rom_offset(addr):rom_offset(addr) + length]
            if src is None:
                name = commands[data[0]][0] if data[0] in commands else 'no macro'
                src = '.byte ' + ', '.join(f'${b:02X}' for b in data) + f' ; {name}'
            lines.append((addr, src))
            addr += length
        else:
            lines.append((addr, f'.byte ${rom[rom_offset(addr)]:02X} ; no macro'))
            addr += 1
    return lines, targets


def main():
    args = [a for a in sys.argv[1:] if not a.startswith('--')]
    if len(args) < 2:
        raise SystemExit(__doc__)
    start, end = int(args[0].replace('$', '').replace('/', ''), 16), int(args[1].replace('$', '').replace('/', ''), 16)
    rom = open(os.path.join(ROOT, 'fe4.sfc'), 'rb').read()
    if '--movement' in sys.argv:
        lines, targets = decode_movement(rom, start, end), set()
    else:
        lines, targets = decode_events(rom, start, end)
    starts = {a for a, _ in lines}
    for t in sorted(targets - starts):
        print(f'; warning: jump target {t:06X} is inside a command', file=sys.stderr)
    for a, src in lines:
        if a in targets:
            print(f'\n        _{a & 0xFFFF:04X} ; {a >> 16:02X}/{a & 0xFFFF:04X}')
        print('        ' + src)


if __name__ == '__main__':
    main()
