#!/usr/bin/env python3
"""Carve palettes in the ROM into labelled .word data.

usage: tools/carve_palettes.py LIST FILE [--write]

LIST has one palette per line (# starts a comment):

    LABEL  ADDR  SIZE        e.g.  aDialogueBackgroundGatePalette  8CC500  $200

SIZE is in bytes (hex with $, else decimal) and must be even. Each palette is
written as BGR555 colours, eight to a line. Palettes that follow one another
in the ROM share a section; each section is placed in build.asm before the
first placement that starts after it. FILE (such as data/palettes/X.asm) is
written with the sections (appended to, if it exists) and included from
build.asm after the other top-level includes.

The tool refuses a palette that overlaps bytes already built from source or
another palette in LIST. Without --write it reports the sections. With it, it
writes FILE and the placements, rewrites raw six-digit numbers in the source
that point into a palette as LABEL+N (as tools/carve.py does), and builds.
"""
import argparse
import os
import re
import subprocess
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from decompress import rom_offset
import carve

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


def read_list(path):
    out = []
    for n, line in enumerate(open(path, encoding='utf-8'), 1):
        f = line.split('#', 1)[0].split()
        if not f:
            continue
        if len(f) != 3:
            sys.exit(f'{path}:{n}: expected LABEL ADDR SIZE')
        size = int(f[2][1:], 16) if f[2].startswith('$') else int(f[2])
        if size <= 0 or size % 2:
            sys.exit(f'{path}:{n}: size must be a positive even number')
        out.append((f[0], int(f[1].lstrip('$'), 16), size))
    return sorted(out, key=lambda p: p[1])


def sections(pals):
    """Group palettes that follow one another: [[(label, addr, size)]]."""
    groups = []
    for p in pals:
        if groups and groups[-1][-1][1] + groups[-1][-1][2] == p[1] and (p[1] & 0xFFFF) != 0x8000 \
                and (p[1] & 0xFFFF) != 0:
            groups[-1].append(p)
        else:
            groups.append([p])
    return groups


def main():
    ap = argparse.ArgumentParser(description=__doc__.split('\n')[0],
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument('list')
    ap.add_argument('file')
    ap.add_argument('--write', action='store_true')
    args = ap.parse_args()
    from trace import coverage_mask
    rom = open(os.path.join(ROOT, 'fe4.sfc'), 'rb').read()
    pals = read_list(args.list)
    print('Measuring what is built from source...')
    mask = coverage_mask()
    problems = []
    for (l1, a1, s1), (l2, a2, _) in zip(pals, pals[1:]):
        if a1 + s1 > a2:
            problems.append(f'{l1} ({a1:06X}+{s1:X}) runs into {l2} ({a2:06X})')
    for label, a, size in pals:
        o = rom_offset(a)
        if o is None or rom_offset(a + size - 1) != o + size - 1:
            problems.append(f'{label}: {a:06X}+{size:X} is not one stretch of ROM')
        elif any(mask[o:o + size]):
            problems.append(f'{label}: {a:06X}+{size:X} overlaps bytes built from source')
    if problems:
        sys.exit('\n'.join(problems))
    groups = sections(pals)
    for g in groups:
        print(f'  ${g[0][1]:06X}-${g[-1][1] + g[-1][2]:06X}: {", ".join(p[0] for p in g)}')
    if not args.write:
        print('Dry run; --write carves them.')
        return

    rel = os.path.relpath(os.path.abspath(args.file), ROOT)
    head = os.path.splitext(os.path.basename(rel))[0]
    text = []
    if os.path.exists(os.path.join(ROOT, rel)):
        text = open(os.path.join(ROOT, rel), encoding='utf-8').read().rstrip('\n').split('\n') + ['']
    else:
        text = ['; Palettes (BGR555), carved by tools/carve_palettes.py.', '']
    b = open(os.path.join(ROOT, 'build.asm'), encoding='utf-8').read().split('\n')
    starts = [(i, int(m.group(1), 16)) for i, l in enumerate(b)
              if (m := re.match(r'\s*\* = \$([0-9A-Fa-f]+)', l))]
    inserts = []
    for g in groups:
        name = f'{head}{g[0][1]:06X}Section'
        text += [f'    .section {name}', '']
        for label, a, size in g:
            o = rom_offset(a)
            words = [rom[o + k] | rom[o + k + 1] << 8 for k in range(0, size, 2)]
            text.append(f'      {label} ; {a >> 16:02X}/{a & 0xFFFF:04X}')
            text += ['        .word ' + ', '.join(f'${w:04X}' for w in words[k:k + 8])
                     for k in range(0, len(words), 8)]
            text.append('')
        text += [f'    .endsection {name}', '']
        off = rom_offset(g[0][1])
        nxt = min((x for x in starts if x[1] > off), key=lambda x: x[1], default=(len(b), None))
        inserts.append((nxt[0], off, [f'    * = ${off:06X}', f'    .logical ${g[0][1]:06X}', '',
                                      f'      .dsection {name}', '', '    .here', '']))
    for at, _, block in sorted(inserts, key=lambda t: (-t[0], -t[1])):
        b[at:at] = block
    inc = f'  .include "{rel}"'
    if inc not in b:                              # after the top-level includes
        k = max(i for i, l in enumerate(b) if l.startswith('  .include "'))
        b[k + 1:k + 1] = [inc]
    os.makedirs(os.path.dirname(os.path.join(ROOT, rel)), exist_ok=True)
    open(os.path.join(ROOT, rel), 'w', encoding='utf-8').write('\n'.join(text))
    open(os.path.join(ROOT, 'build.asm'), 'w', encoding='utf-8').write('\n'.join(b))
    n = carve.replace_raw_numbers(sorted((a, a + s, l) for l, a, s in pals))
    print(f'Wrote {len(pals)} palettes in {len(groups)} sections to {rel}; {n} raw numbers now labels.')
    sys.exit(subprocess.call(['./build.sh'], cwd=ROOT))


if __name__ == '__main__':
    main()
