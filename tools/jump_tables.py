#!/usr/bin/env python3
"""Write the jump tables that built code reaches by raw address.

usage: tools/jump_tables.py [--bank 8A] [--write FILE]

Built code such as `jsr ($8AC08F,x)` jumps through a table of words that may
still be base-ROM bytes. Nothing can follow such a jump: tools/trace.py only
follows tables that are labelled, and fe4.cdl only shows the entries that ran.
For each `jsr`/`jmp (addr,x)` in engine/ whose operand is a raw address in an
unbuilt part of the ROM, this reads the table's entries and lists them, marking
targets that are not built with *.

The number of entries is found from a `cmp #N` bound shortly before the jump if
there is one; otherwise entries are read until one is below $8000, points into
the table itself, or the next word is the first target or a built byte (code
usually follows its table). Check the list before writing.

--write FILE writes the tables as a routines file (`aUnknownXXXXXX .word ...`):
entries with a label use it, the rest stay raw words, which tools/trace.py then
follows. Test and place FILE as usual (test_routines.py, place_routines.py),
using the .spec file written next to it, then run this again with --fix to
point the jumps at the new labels, and run tools/trace.py for the targets.
"""
import argparse, glob, os, re, sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from asmlib import read_rom, offset
from trace import coverage_mask

JUMP = re.compile(r'^(\s+)(jsr|jmp) \(\$([0-9A-F]{6}),x\)')


def labels_at():
    """{cpu address: assembler name} for labels.txt, preferring top-level names."""
    names = {}
    for l in open('labels.txt'):
        p = l.split()
        if len(p) < 3:
            continue
        a, n = int(p[1], 16), p[2][1:].replace(':', '.')
        if a >> 16 < 0x80:
            continue
        if a not in names or '.' in names[a] and '.' not in n:
            names[a] = n
    return names


def bound_before(lines, i):
    """N from a `cmp #N` within the few lines before the jump, if any."""
    for l in reversed(lines[max(0, i - 8):i]):
        m = re.match(r'\s+cmp #\$?([0-9A-Fa-f]+)\b', l)
        if m:
            v = m.group(1)
            return int(v, 16) if '$' in l else int(v)
        if re.match(r'\s+(jsr|jsl|rts|rtl|bra|jmp|jml)\b', l):
            return None
    return None


def read_table(rom, mask, addr, n=None):
    bank, o = addr & 0xFF0000, offset(addr)
    ents, first = [], None
    while n is None or len(ents) < n:
        if mask[o] or mask[o + 1]:
            break
        if n is None and first is not None and (o & 0xFFFF) >= first:
            break
        w = rom[o] | rom[o + 1] << 8
        if n is None and (w < 0x8000 or addr & 0xFFFF <= w < (addr & 0xFFFF) + 2 * (len(ents) + 1)):
            break
        ents.append(bank | w)
        first = w if first is None else min(first, w)
        o += 2
        if len(ents) > 64:
            break
    return ents


def find_jumps(bank=None):
    """[(file, line index, table address, cmp bound or None, routine name)]."""
    out = []
    for f in sorted(glob.glob('engine/**/*.asm', recursive=True)):
        lines = open(f, encoding='utf-8').read().split('\n')
        routine = None
        for i, l in enumerate(lines):
            m = re.match(r'^ {6}(r[ls]\w+) ; ', l)
            if m:
                routine = m.group(1)
            m = JUMP.match(l)
            if m:
                addr = int(m.group(3), 16)
                if bank is None or (addr >> 16) & 0x3F == bank:
                    out.append((f, i, addr, bound_before(lines, i), routine))
    return out


def main():
    ap = argparse.ArgumentParser(description=__doc__.split('\n')[0])
    ap.add_argument('--bank')
    ap.add_argument('--write', metavar='FILE')
    ap.add_argument('--fix', action='store_true', help='point raw jumps at tables now labelled')
    a = ap.parse_args()
    bank = int(a.bank, 16) & 0x3F if a.bank else None
    names = labels_at()

    if a.fix:
        n = 0
        for f, i, addr, _, _ in find_jumps(bank):
            name = names.get(addr)
            if name and not name.startswith('r'):
                lines = open(f, encoding='utf-8').read().split('\n')
                lines[i] = lines[i].replace(f'(${addr:06X},x)', f'({name},x)')
                open(f, 'w', encoding='utf-8').write('\n'.join(lines))
                n += 1
        print(f'{n} jumps now use the table labels')
        return

    rom, mask = read_rom(), coverage_mask()
    tables = {}
    for f, i, addr, n, routine in find_jumps(bank):
        if mask[offset(addr)]:
            print(f'{f}:{i + 1}: ${addr:06X} is built but has no label at the operand; skipped')
            continue
        ents = read_table(rom, mask, addr, n)
        tables.setdefault(addr, (ents, n, f, i, routine))
    for addr, (ents, n, f, i, routine) in sorted(tables.items()):
        unbuilt = sum(not mask[offset(e)] for e in ents)
        how = f'cmp #{n}' if n is not None else 'heuristic'
        print(f'${addr:06X} {len(ents):2} entries ({how}), {unbuilt} not built  {f}:{i + 1}')
        print('   ', ' '.join(f'{e & 0xFFFF:04X}{"" if mask[offset(e)] else "*"}' for e in ents))

    if a.write:
        parts = ['; Jump tables written by tools/jump_tables.py.\n']
        spec = []
        for addr, (ents, n, f, i, routine) in sorted(tables.items()):
            if not ents:
                continue
            words = [f'<>{names[e]}' if e in names else f'${e & 0xFFFF:04X}' for e in ents]
            if not any(w.startswith('<>') for w in words):
                print(f'${addr:06X}: no entry has a label; tools/trace.py could not follow it')
            body = ''.join(f'        .word {w}\n' for w in words)
            parts.append(f'      aUnknown{addr:06X} ; {addr >> 16:02X}/{addr & 0xFFFF:04X}\n\n'
                         f'        ; Jump table of {routine}.\n{body}')
            spec.append(f'aUnknown{addr:06X}  {f}  Table{addr:06X}Section')
        open(a.write, 'w', encoding='utf-8').write('\n'.join(parts))
        spec_path = os.path.splitext(a.write)[0] + '.spec'
        open(spec_path, 'w').write('\n'.join(spec) + '\n')
        print(f'wrote {spec_path} for tools/place_routines.py (each table beside its jump)')
        print(f'wrote {len(parts) - 1} tables to {a.write}')


if __name__ == '__main__':
    main()
