#!/usr/bin/env python3
"""Find (and with --fix, remove) "nothing in the build reaches this" notes that are no longer true.

usage: tools/stale_notes.py [--fix] [-v]

tools/sweep.py and tools/cdl.py mark the routines they add with one of

    ; Found by tools/sweep.py: nothing in the build reaches this.
    ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.

Both say that no label in the build refers to the routine. When later work adds a
reference (a table entry, a jsl, a pointer), the note becomes false. This tool looks
for every such routine and searches the source the build reads (every tracked .asm,
.h, .txt and .csv outside tools/, with ; comments in .asm and .h stripped) for its
name or one of its local labels (`rlName._1234`). References from inside the routine
itself do not count.

Without --fix it lists the stale notes. With --fix it rewrites them:
  sweep notes become   ; Found by tools/sweep.py.
  log notes become     ; Found through fe4.cdl.
so the record of how the routine was found stays, and only the false claim goes.
"""
import os, re, subprocess, sys
from collections import defaultdict

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
NOTES = {
    '; Found by tools/sweep.py: nothing in the build reaches this.': '; Found by tools/sweep.py.',
    '; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.': '; Found through fe4.cdl.',
}
TOP = re.compile(r'^      ([A-Za-z_][A-Za-z0-9_]*) ; [0-9A-F]{2}/[0-9A-F]{4}')
IDENT = re.compile(r'[A-Za-z_][A-Za-z0-9_]*')


def source_files():
    out = subprocess.run(['git', 'ls-files'], cwd=ROOT, capture_output=True, text=True).stdout
    for p in out.split('\n'):
        if p.startswith('tools/') or not p.endswith(('.asm', '.h', '.txt', '.csv')):
            continue
        if p.endswith('.dialogue.txt') or p in ('labels.txt', 'log.txt'):
            continue
        yield p


def strip_comment(line):
    # 64tass comments start at ';' outside a string.
    q = None
    for i, c in enumerate(line):
        if q:
            if c == q:
                q = None
        elif c in '"\'':
            q = c
        elif c == ';':
            return line[:i]
    return line


def scan():
    """Return (noted, refs): noted = {routine: (path, line index of note)},
    refs = {name: set of (path, routine containing the reference)}."""
    noted = {}
    refs = defaultdict(set)
    for p in source_files():
        try:
            lines = open(os.path.join(ROOT, p), encoding='utf-8').read().split('\n')
        except UnicodeDecodeError:
            continue
        code = p.endswith(('.asm', '.h'))
        current = None
        for n, line in enumerate(lines):
            m = TOP.match(line)
            if m:
                current = m.group(1)
                continue
            if line.startswith('    .endsection') or line.startswith('    .section'):
                current = None
            s = line.strip()
            if s in NOTES and current:
                noted[current] = (p, n)
                continue
            text = strip_comment(line) if code else line
            for tok in IDENT.findall(text):
                refs[tok].add((p, current))
    return noted, refs


def main():
    fix = '--fix' in sys.argv
    verbose = '-v' in sys.argv
    noted, refs = scan()
    stale = defaultdict(list)  # path -> [(line, routine, referrers)]
    for name, (p, n) in noted.items():
        who = {(rp, r) for rp, r in refs.get(name, ()) if r != name}
        if who:
            stale[p].append((n, name, who))
    total = sum(len(v) for v in stale.values())
    kept = len(noted) - total
    for p in sorted(stale):
        for n, name, who in sorted(stale[p]):
            if verbose:
                by = ', '.join(sorted(f'{r or "(top level)"} in {rp}' for rp, r in who)[:3])
                print(f'{p}:{n + 1}: {name} <- {by}')
    print(f'{len(noted)} routines carry an unreached note; {total} are reached now, {kept} still are not.')
    if fix:
        for p, items in stale.items():
            path = os.path.join(ROOT, p)
            lines = open(path, encoding='utf-8').read().split('\n')
            for n, _, _ in items:
                s = lines[n].strip()
                lines[n] = lines[n][:len(lines[n]) - len(lines[n].lstrip())] + NOTES[s]
            open(path, 'w', encoding='utf-8').write('\n'.join(lines))
        print(f'Rewrote {total} notes in {len(stale)} files.')
    return 0


if __name__ == '__main__':
    sys.exit(main())
