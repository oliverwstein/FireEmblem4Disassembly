#!/usr/bin/env python3
"""Close one unbuilt piece by writing it into the section just before it.

usage: tools/close_gap.py ADDR FILE

ADDR is the piece's first address (CPU address, as GAPS.md gives it). FILE holds
the source to put there: any lines (labels, code, .byte rows, macros), written
in the project's style. The source is added at the end of the section that holds
the last built label before ADDR, just before its .endsection line. If build.asm
then has a placement break (.here, * = ..., .logical ...) at the piece's end, so
that the next block starts right after it, the break is removed and the two
blocks become one.

The tool builds after each change and puts everything back if the output stops
matching the ROM (with the break kept if only the merge failed). Run
tools/gaps.py afterwards.

As a module: close(addr, text) returns True if the piece is closed.
"""
import os, re, subprocess, sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import glob

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


def build_ok():
    r = subprocess.run(['./build.sh'], cwd=ROOT, capture_output=True, text=True)
    return 'matches the original ROM' in r.stdout + r.stderr


def labels():
    out = {}
    for l in open(os.path.join(ROOT, 'labels.txt')):
        p = l.split()
        if len(p) >= 3 and re.fullmatch(r'\.?[A-Za-z]\w*', p[2]):
            try:
                out.setdefault(p[2].lstrip('.'), int(p[1], 16))
            except ValueError:
                pass
    return out


def find_section(addr):
    """The engine file and section holding the last top-level label before addr."""
    best = None
    for f in glob.glob(os.path.join(ROOT, 'engine/**/*.asm'), recursive=True):
        t = open(f, encoding='utf-8').read()
        for m in re.finditer(r'(?m)^      (\w+) ; ([0-9A-F]{2})/([0-9A-F]{4})\b', t):
            a = int(m.group(2) + m.group(3), 16)
            if a < addr and (best is None or a > best[0]):
                best = (a, f, m.start())
    if best is None:
        return None
    _, f, pos = best
    t = open(f, encoding='utf-8').read()
    starts = [m for m in re.finditer(r'(?m)^[ \t]*\.section (\w+)\s*$', t) if m.start() < pos]
    return f, starts[-1].group(1)


def close(addr, text, end=None):
    found = find_section(addr)
    if not found:
        print(f'{addr:06X}: no section before it')
        return False
    f, sec = found
    old = open(f, encoding='utf-8').read()
    m = re.search(r'(?m)^[ \t]*\.endsection ' + re.escape(sec) + r'\s*$', old)
    new = old[:m.start()].rstrip('\n') + '\n\n' + text.rstrip('\n') + '\n\n' + old[m.start():]
    open(f, 'w', encoding='utf-8').write(new)
    if not build_ok():
        open(f, 'w', encoding='utf-8').write(old)
        print(f'{addr:06X}: build differs with the source in {os.path.relpath(f, ROOT)}; put back')
        return False
    print(f'{addr:06X}: written into {sec} ({os.path.relpath(f, ROOT)})')
    if end is not None:
        merge_break(end)
    return True


def merge_break(end):
    """Remove the placement break whose next block starts at end (CPU address)."""
    b = os.path.join(ROOT, 'build.asm')
    old = open(b, encoding='utf-8').read()
    pat = re.compile(r'\n[ \t]*\.here[ \t]*\n(?:[ \t]*\n)*[ \t]*\* = \$[0-9A-F]+[ \t]*\n[ \t]*\.logical \$%06X[ \t]*\n' % end)
    m = pat.search(old)
    if not m:
        return
    new = old[:m.start()] + '\n' + old[m.end():]
    open(b, 'w', encoding='utf-8').write(new)
    if build_ok():
        print(f'  merged the placement block at {end:06X}')
    else:
        open(b, 'w', encoding='utf-8').write(old)
        build_ok()
        print(f'  kept the placement break at {end:06X}')


def main():
    if len(sys.argv) != 3:
        raise SystemExit(__doc__)
    addr = int(sys.argv[1].replace('$', '').replace('/', ''), 16)
    text = open(sys.argv[2], encoding='utf-8').read()
    end = None
    for l in open(os.path.join(ROOT, 'GAPS.md'), encoding='utf-8'):
        m = re.match(r'\| \$([0-9A-F]{2})/([0-9A-F]{4})-\$([0-9A-F]{2})/([0-9A-F]{4}) \|', l)
        if m and int(m.group(1) + m.group(2), 16) == addr:
            end = int(m.group(3) + m.group(4), 16) + 1
    close(addr, text, end)


if __name__ == '__main__':
    main()
