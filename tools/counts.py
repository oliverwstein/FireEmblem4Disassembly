#!/usr/bin/env python3
"""Print the project's progress numbers. Every doc quotes these, and only these.

usage: tools/counts.py [--fast]

Prints:
  - coverage: ROM bytes built from source (the two-fill test of ./build.sh
    coverage; takes about half a minute), and the unbuilt bytes split into
    padding runs (one repeated value) and pieces;
  - gap classes, read from GAPS.md (run tools/gaps.py to refresh it);
  - routines: top-level rl/rs labels under engine/, how many are Unknown, and
    how many are still in engine/unsorted/ (and how many lines it holds);
  - pinned blocks: `* = $` placements in build.asm;
  - notes: the "Found through fe4.cdl" / "Found by tools/sweep.py" records,
    the "nothing reaches this" claims among them, and comments in engine/
    that end in a question mark.

--fast skips the coverage builds.
"""
import argparse
import glob
import os
import re
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from asmlib import source_map

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
TOP = re.compile(r'^ {6}(r[ls]\w+) ; [0-9A-F]{2}/[0-9A-F]{4}')


def coverage():
    mask = source_map()
    rom = open('fe4.sfc', 'rb').read()
    built = sum(mask)
    padding = pieces = pad_bytes = piece_bytes = 0
    i, n = 0, len(mask)
    while i < n:
        if mask[i]:
            i += 1
            continue
        j = i
        while j < n and not mask[j]:
            j += 1
        if len(set(rom[i:j])) == 1 and rom[i] in (0x00, 0xFF):
            padding += 1
            pad_bytes += j - i
        else:
            pieces += 1
            piece_bytes += j - i
        i = j
    print(f'Coverage: {built / n:.2%} built from source ({built:,} of {n:,} bytes)')
    print(f'  unbuilt: {pieces} pieces ({piece_bytes:,} bytes), '
          f'{padding} padding runs ({pad_bytes:,} bytes)')


def gap_classes():
    try:
        text = open('GAPS.md', encoding='utf-8').read()
    except OSError:
        return
    rows = re.findall(r'^\| `(\w+)` \| (\d+) \| ([\d,]+) \|', text, re.M)
    print('Gap classes (GAPS.md): ' + ', '.join(f'{c} {p} ({b} bytes)' for c, p, b in rows))


def routines():
    total = unknown = unsorted = 0
    lines = 0
    for f in glob.glob('engine/**/*.asm', recursive=True):
        in_unsorted = f.startswith('engine/unsorted/')
        text = open(f, encoding='utf-8').read().split('\n')
        if in_unsorted:
            lines += len(text)
        for l in text:
            m = TOP.match(l)
            if m:
                total += 1
                unknown += 'Unknown' in m.group(1)
                unsorted += in_unsorted
    print(f'Routines: {total:,} in engine/, {total - unknown:,} named, {unknown:,} Unknown')
    print(f'  engine/unsorted/: {unsorted:,} routines in {lines:,} lines')


def pinned():
    n = sum(1 for l in open('build.asm', encoding='utf-8') if re.match(r'^\s*\*\s*=\s*\$', l))
    print(f'Pinned blocks in build.asm: {n}')


def notes():
    cdl = sweep = claims = questions = 0
    for f in glob.glob('engine/**/*.asm', recursive=True):
        for l in open(f, encoding='utf-8'):
            if '; Found through fe4.cdl' in l:
                cdl += 1
            if '; Found by tools/sweep.py' in l:
                sweep += 1
            if 'nothing in the build reaches' in l:
                claims += 1
            c = l.find(';')
            if c >= 0 and l.rstrip().endswith('?'):
                questions += 1
    print(f'Notes: {cdl} "Found through fe4.cdl", {sweep} "Found by tools/sweep.py", '
          f'{claims} of them say nothing reaches the routine')
    print(f'  comments ending in "?": {questions}')


def main():
    ap = argparse.ArgumentParser(description=__doc__.split('\n')[0])
    ap.add_argument('--fast', action='store_true', help='skip the coverage builds')
    args = ap.parse_args()
    os.chdir(ROOT)
    if not args.fast:
        coverage()
    gap_classes()
    routines()
    pinned()
    notes()


if __name__ == '__main__':
    main()
