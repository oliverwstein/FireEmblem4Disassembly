#!/usr/bin/env python3
"""Show source lines of a routines file next to the bytes they build and the original bytes.

usage: tools/show_lines.py FILE FIRST [LAST]

Builds FILE as test_routines.py does (with --long-branch, so files with branch errors
still build) and prints, for each line from FIRST to LAST (default FIRST + 30): its
address, the built bytes, the original bytes, and the source. Lines that differ are
marked with `!!`.
"""
import os, sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import asmlib
import test_routines


def main():
    if len(sys.argv) not in (3, 4):
        print(__doc__); return 2
    path, first = sys.argv[1], int(sys.argv[2])
    last = int(sys.argv[3]) if len(sys.argv) == 4 else first + 30
    res = test_routines.run(path, long_branch=True, listing=True)
    if res.errors:
        print(f'{len(res.errors)} assembly errors, e.g.:')
        for e in res.errors[:10]:
            print('  ' + e)
        return 1
    rom = asmlib.read_rom()
    for n in range(first, min(last, len(res.lines)) + 1):
        src = res.lines[n - 1].strip()
        if n in res.listing:
            off, bs = res.listing[n]
            orig = rom[off:off + len(bs)]
            mark = '  ' if orig == bs else '!!'
            print(f'{mark} {n:5} {0xC00000 + off:06X}  {bs.hex(" "):<12} {orig.hex(" "):<12} {src}')
        elif src:
            print(f'   {n:5} {"":6}  {"":<12} {"":<12} {src}')
    return 0


if __name__ == '__main__':
    sys.exit(main())
