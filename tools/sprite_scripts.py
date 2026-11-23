#!/usr/bin/env python3
"""Decode active sprite scripts from the ROM as ACTIVE_SPRITE_* source.

usage: tools/sprite_scripts.py ADDR [ADDR...] [--name LABEL]

Each ADDR (CPU address, e.g. 9F9FDE) is the start of a script, as the third
word of an active sprite definition gives it (see include/ActiveSpriteEngine.h
for the format). The script is decoded until a command that does not go on to
the next one (end, jump, a computed jump, a wait that never ends); jump and
loop targets inside the decoded stretch become local labels. Several ADDRs
that follow one another are written as one block, each under its own label.

As a module: decode(rom, addr) -> list of (addr, opcode, operand bytes), and
ENDS / SIZES describe the commands.
"""
import os, re, sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from asmlib import read_rom, offset
from disasm import load_labels

# Operand bytes of each command (aActiveSpriteCommandPointers, $81/823B).
SIZES = {0x00: 3, 0x01: 0, 0x02: 2, 0x03: 1, 0x04: 0, 0x05: 0, 0x06: 0, 0x07: 0, 0x08: 0,
         0x09: 0, 0x0A: 0, 0x0B: 0, 0x0C: 0, 0x0D: 0, 0x0E: 2, 0x0F: 0, 0x10: 0, 0x11: 0,
         0x12: 1, 0x13: 1, 0x14: 2, 0x15: 2, 0x16: 1, 0x17: 2, 0x18: 3, 0x19: 2, 0x1A: 0,
         0x1B: 0, 0x1C: 0, 0x1D: 1, 0x1E: 1}
# Routines called by command $17 that read operands after it themselves:
# address -> 'jump' (a word, a script position the routine may jump to).
CALL_ARGS = {
    0x9FA00E: 'jump',  # jumps when aUnknown001320 is 0, else skips the word
    0x9FA9C1: 'jump',  # moves the sprite down; jumps once it has reached its Y
    0x9FA9F7: 'jump',  # skips the word when aUnknown0013A0 is 1, else jumps
    0x9FAA02: 'jump',  # skips the word when aUnknown0013A0 is 2, else jumps
}
# Commands after which the script does not run on.
ENDS = {0x01, 0x09, 0x0A, 0x0B, 0x0C, 0x0F, 0x15, 0x16}


def decode(rom, addr, stop=None):
    out = []
    a = addr
    while True:
        if stop is not None and a >= stop:
            break
        op = rom[offset(a)]
        if op not in SIZES:
            raise ValueError(f'${a:06X}: {op:02X} is not an active sprite command')
        n = SIZES[op]
        if op == 0x17 and (a & 0xFF0000 | word(rom, offset(a) + 1)) in CALL_ARGS:
            n += 2
        args = rom[offset(a) + 1:offset(a) + 1 + n]
        out.append((a, op, bytes(args)))
        a += 1 + n
        if op in ENDS:
            break
    return out


def word(b, i=0):
    return b[i] | b[i + 1] << 8


def signed(v):
    return v - 256 if v >= 128 else v


def render(rom, labels, starts, names=None, stop=None):
    """Source for the scripts at starts (sorted, consecutive). Each is decoded until
    its last command or the next start (or stop), whichever comes first."""
    names = names or {}
    bank = starts[0] & 0xFF0000
    cmds = []
    for k, s in enumerate(starts):
        nxt = starts[k + 1] if k + 1 < len(starts) else stop
        part = decode(rom, s, nxt if nxt is not None else None)
        if cmds and part and cmds[-1][0] + 1 + len(cmds[-1][2]) != part[0][0]:
            raise ValueError(f'scripts at ${starts[k - 1]:06X} and ${s:06X} are not adjacent')
        cmds += part
    inside = {a for a, _, _ in cmds}
    targets = set()
    for a, op, b in cmds:
        if op in (0x02, 0x15):
            targets.add(bank | word(b))
        elif op == 0x17 and len(b) == 4:
            targets.add(bank | word(b, 2))
        elif op == 0x16:
            targets.add(a + 1 + signed(b[0]))

    def name(addr, local=True):
        if addr in names:
            return names[addr]
        if local and addr in inside and addr not in starts:
            return f'_{addr & 0xFFFF:04X}'
        found = [n for n in labels.get(addr, []) if not n.startswith('_')]
        if found:
            return found[0]
        return f'${addr & 0xFFFF:04X}'

    lines, uses = [], {'frames': set(), 'routines': set()}
    for a, op, b in cmds:
        if a in starts:
            if lines:
                lines.append('')
            lines.append(f'      {name(a, False) if a in names or labels.get(a) else f"aUnknown{a:06X}"} ; {a >> 16:02X}/{a & 0xFFFF:04X}')
            lines.append('')
        elif a in targets:
            lines.append('')
            lines.append(f'        _{a & 0xFFFF:04X}')
        if op == 0x00:
            uses['frames'].add(bank | word(b, 1))
            lines.append(f'        ACTIVE_SPRITE_FRAME {b[0]}, {name(bank | word(b, 1))}')
        elif op == 0x01:
            lines.append('        ACTIVE_SPRITE_END')
        elif op == 0x02:
            lines.append(f'        ACTIVE_SPRITE_JUMP_WHILE_COUNTER {name(bank | word(b))}')
        elif op == 0x10:
            lines.append('        ACTIVE_SPRITE_START_MAP_MAGIC')
        elif op == 0x11:
            lines.append('        ACTIVE_SPRITE_WAIT_MAP_MAGIC')
        elif op == 0x12:
            lines.append(f'        ACTIVE_SPRITE_WAIT {b[0]}')
        elif op == 0x14:
            uses['routines'].add(bank | word(b))
            lines.append(f'        ACTIVE_SPRITE_SET_ONCYCLE {name(bank | word(b))}')
        elif op == 0x15:
            lines.append(f'        ACTIVE_SPRITE_JUMP {name(bank | word(b))}')
        elif op == 0x17:
            uses['routines'].add(bank | word(b))
            lines.append(f'        ACTIVE_SPRITE_CALL {name(bank | word(b))}')
            if len(b) == 4:
                lines.append(f'        .word <>{name(bank | word(b, 2))}')
        elif op == 0x19:
            lines.append(f'        ACTIVE_SPRITE_MOVE {signed(b[0])}, {signed(b[1])}')
        elif op == 0x1D:
            lines.append(f'        ACTIVE_SPRITE_SOUND ${b[0]:02X}')
        else:
            lines.append('        .byte ' + ', '.join(f'${x:02X}' for x in bytes([op]) + b)
                         + f' ; command ${op:02X}')
    end = cmds[-1][0] + 1 + len(cmds[-1][2])
    lines.append('')
    lines.append(f'        ; {end >> 16:02X}/{end & 0xFFFF:04X}')
    return '\n'.join(lines) + '\n', uses, end


def main():
    args = [a for a in sys.argv[1:] if not a.startswith('--')]
    if not args:
        raise SystemExit(__doc__)
    starts = sorted(int(a.replace('/', '').replace('$', ''), 16) for a in args)
    text, uses, end = render(read_rom(), load_labels('labels.txt'), starts)
    sys.stdout.write(text)
    print(f'; frames: {" ".join(f"{a:06X}" for a in sorted(uses["frames"]))}', file=sys.stderr)
    print(f'; routines: {" ".join(f"{a:06X}" for a in sorted(uses["routines"]))}', file=sys.stderr)


if __name__ == '__main__':
    main()
