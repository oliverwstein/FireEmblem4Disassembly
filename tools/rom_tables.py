#!/usr/bin/env python3
"""Label the ROM tables that built code reads by raw address.

usage: tools/rom_tables.py FILE [--max N]

Finds every read (lda, cmp, adc, ...) in built routines of a ROM address that is
not built yet. Reads within 3 bytes of each other count as one table. Then:

- A table whose extent is certain is written to FILE as a routines file entry,
  aUnknownXXXXXX with its bytes. Its extent is taken as certain when it runs to
  the next table or to built code within N bytes (default 256) and the bytes do
  not look like code (a jsl, jsr or jmp to a known routine). Check the result
  anyway: a short table followed by code that calls nothing known still slips
  through, and the reader's loop bounds are the real test.
- Other tables only get a name: it is declared weakly in include/Undisassembled.h,
  so code can use it while its bytes still come from the ROM.
- Raw addresses of these tables in built code are replaced by the names
  (aUnknown879471+2,x and so on).

Words are used when every read is 16-bit and the length is even. A word that is
the address of a label in the table's bank is written as <>label.
Check FILE with tools/test_routines.py and place it with tools/place_routines.py.
"""
import argparse, collections, glob, os, re, sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from asmlib import read_rom, offset
from disasm import Disassembler, load_labels
from trace import built_routines, coverage_mask

READS = {'lda', 'ldx', 'ldy', 'adc', 'sbc', 'cmp', 'and', 'ora', 'eor', 'bit', 'cpx', 'cpy'}


def is_rom(a):
    return (0x80 <= a >> 16 <= 0xBF and a & 0xFFFF >= 0x8000) or a >> 16 >= 0xC0


def find_reads(rom, labels, mask):
    refs = collections.defaultdict(list)
    for a, name, m8, x8 in built_routines():
        insns, _ = Disassembler(rom, labels, a, None, m8, x8).decode()
        for i in insns:
            if i['mn'] not in READS or i['val'] is None:
                continue
            v = i['val']
            if i['mode'] in ('absl', 'abslx'):
                full = v
            elif i['mode'] in ('abs', 'absx', 'absy') and i['db'] is not None and v >= 0x8000:
                full = (i['db'] << 16) | v
            else:
                continue
            if not is_rom(full) or mask[offset(full)]:
                continue
            wide = not (i['x8'] if i['mn'] in ('ldx', 'ldy', 'cpx', 'cpy') else i['m8'])
            refs[full].append((name, wide))
    return refs


def main():
    ap = argparse.ArgumentParser(description=__doc__.split('\n')[0])
    ap.add_argument('file')
    ap.add_argument('--max', type=int, default=256)
    a = ap.parse_args()

    rom, labels = read_rom(), load_labels('labels.txt')
    mask = coverage_mask()
    refs = find_reads(rom, labels, mask)
    groups = []
    for x in sorted(refs):
        if groups and x - groups[-1][-1] <= 3:
            groups[-1].append(x)
        else:
            groups.append([x])
    starts = [g[0] for g in groups]

    def name_at(x):
        n = [m for m in labels.get(x, []) if m[0] in 'ar' and 'Unknown' not in m] or labels.get(x, [])
        return n[0] if n else None

    routine_starts = {x for x, n in labels.items() if x >= 0x800000 and any(m[:2] in ('rl', 'rs') for m in n)}

    def looks_like_code(start, end):
        """True if the bytes hold what looks like a jsl, jsr or jmp to a known routine:
        then the gap holds code after the table, and its extent is not certain."""
        b = rom[offset(start):offset(end)]
        for i in range(len(b) - 3):
            if b[i] == 0x22 and b[i + 1] | b[i + 2] << 8 | b[i + 3] << 16 in routine_starts:
                return True
            if b[i] in (0x20, 0x4C) and (start & 0xFF0000) | b[i + 1] | b[i + 2] << 8 in routine_starts:
                return True
        return False

    entries, weak, names = [], [], {}
    for k, g in enumerate(groups):
        start = g[0]
        name = f'aUnknown{start:06X}'
        names[start] = (name, g)
        bank_end = (start | 0xFFFF) + 1
        end = next((x for x in range(start, bank_end) if mask[offset(x)]), bank_end)
        if k + 1 < len(groups) and starts[k + 1] < end:
            end = starts[k + 1]
        readers = sorted({r for x in g for r, _ in refs[x]})
        if end - start > a.max or end - start < g[-1] - start + 1 or looks_like_code(start, end):
            weak.append((name, start, readers))
            continue
        data = rom[offset(start):offset(end)]
        wide = all(w for x in g for _, w in refs[x]) and len(data) % 2 == 0
        lines = [f'      {name} ; {start >> 16:02X}/{start & 0xFFFF:04X}', '',
                 '        ; Read by ' + ', '.join(readers) + '.', '']
        if wide:
            words = [data[i] | data[i + 1] << 8 for i in range(0, len(data), 2)]
            text = [(f'<>{name_at((start & 0xFF0000) | w)}' if w >= 0x8000 and name_at((start & 0xFF0000) | w)
                     else f'${w:04X}') for w in words]
            for i in range(0, len(text), 8):
                lines.append('        .word ' + ', '.join(text[i:i + 8]))
        else:
            for i in range(0, len(data), 16):
                lines.append('        .byte ' + ', '.join(f'${b:02X}' for b in data[i:i + 16]))
        lines += ['', f'        ; {end >> 16:02X}/{end & 0xFFFF:04X}', '']
        entries.append('\n'.join(lines))

    open(a.file, 'w', encoding='utf-8').write(
        '; ROM tables that built code reads, written by tools/rom_tables.py.\n\n' + '\n'.join(entries))

    # Weak names for the rest.
    p = 'include/Undisassembled.h'
    h = open(p, encoding='utf-8').read()
    add = ''.join(f'    {n:<56} :?= address(${s:06X}) ; read by {", ".join(r)}\n' for n, s, r in weak
                  if re.search(r'^\s+' + n + r'\s', h, re.M) is None)
    h = h.replace('  .endweak', add + '\n  .endweak', 1)
    open(p, 'w', encoding='utf-8').write(h)

    # Use the names in built code.
    pat = re.compile(r'(?<![\w$])(@l )?\$([89A-F][0-9A-F]{5})\b(\+\d+)?')
    lookup = {}
    for s, (n, g) in names.items():
        for x in g:
            lookup[x] = (n, x - s)
    changed = 0
    for f in glob.glob('engine/**/*.asm', recursive=True):
        text = open(f, encoding='utf-8').read()

        def rep(m):
            nonlocal changed
            x = int(m.group(2), 16) + (int(m.group(3)[1:]) if m.group(3) else 0)
            if x not in lookup:
                return m.group(0)
            n, k = lookup[x]
            changed += 1
            return (m.group(1) or '') + n + (f'+{k}' if k else '')
        new = '\n'.join(pat.sub(rep, l) if re.match(r'^\s+(lda|ldx|ldy|adc|sbc|cmp|and|ora|eor|bit|cpx|cpy)\b', l) else l
                        for l in text.split('\n'))
        if new != text:
            open(f, 'w', encoding='utf-8').write(new)
    print(f'{len(groups)} tables: {len(entries)} written to {a.file}, {len(weak)} named only; '
          f'{changed} operands now use the names')


if __name__ == '__main__':
    main()
