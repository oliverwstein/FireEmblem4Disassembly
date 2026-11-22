#!/usr/bin/env python3
"""Rename labels everywhere in the source.

usage: tools/rename.py FILE

FILE has one rename per line: OLD NEW, optionally followed by | and a comment to
add below the routine's .databank ? line (# starts a comment line in FILE).
Whole words are replaced in engine/, include/, events/, data/ and build.asm. A
NEW name that is already used anywhere is refused. Run ./build.sh afterwards.
"""
import glob, re, sys


def main():
    if len(sys.argv) != 2:
        raise SystemExit(__doc__)
    renames, notes = {}, {}
    for line in open(sys.argv[1], encoding='utf-8'):
        if not line.strip() or line.lstrip().startswith('#'):
            continue
        spec, _, note = line.partition('|')
        old, new = spec.split()
        renames[old] = new
        if note.strip():
            notes[new] = note.strip()
    files = (glob.glob('engine/**/*.asm', recursive=True) + glob.glob('include/**/*.h', recursive=True)
             + glob.glob('events/**/*.asm', recursive=True) + glob.glob('data/**/*.asm', recursive=True)
             + glob.glob('data/**/*.csv', recursive=True) + glob.glob('audio/**/*.asm', recursive=True)
             + glob.glob('text/dialogue/**/*.txt', recursive=True) + ['build.asm'])
    text = {f: open(f, encoding='utf-8').read() for f in files}
    everything = '\n'.join(text.values())
    for old, new in renames.items():
        if re.search(r'\b' + re.escape(new) + r'\b', everything):
            raise SystemExit(f'{new} is already used')
        if not re.search(r'\b' + re.escape(old) + r'\b', everything):
            raise SystemExit(f'{old} is not used anywhere')
    pat = re.compile(r'\b(' + '|'.join(map(re.escape, renames)) + r')\b')
    for f, t in text.items():
        new = pat.sub(lambda m: renames[m.group(1)], t)
        for name, note in notes.items():
            m = re.search(r'^      ' + name + r' ;[^\n]*\n(?:(?!^      \w).*\n)*?        \.databank \?\n', new, re.M)
            if m and note not in new:
                comment = ''.join(f'        ; {x.strip()}\n' for x in note.split('\\n'))
                new = new[:m.end()] + '\n' + comment + new[m.end():]
        if new != t:
            open(f, 'w', encoding='utf-8').write(new)
    print(f'renamed {len(renames)} labels')


if __name__ == '__main__':
    main()
