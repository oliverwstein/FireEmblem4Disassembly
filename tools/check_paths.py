#!/usr/bin/env python3
"""Check that every file the assembly includes exists with exactly that spelling.

macOS and Windows ignore case in file names, so a wrong-case include builds
there but fails on Linux. 64tass resolves an include relative to the file that
contains it.
"""
import functools, os, re, sys

INCLUDE = re.compile(r'''(?:\.b?include|\.binary|binary\()\s*"([^"]+)"''')

@functools.lru_cache(maxsize=None)
def listdir(path):
    return frozenset(os.listdir(path))

def exists_exact(path):
    path = os.path.normpath(path)
    parts = path.split(os.sep)
    cur = '.'
    for p in parts:
        if p in ('', '.'):
            continue
        if p == '..':
            cur = os.path.join(cur, '..'); continue
        try:
            if p not in listdir(cur):
                return False
        except (FileNotFoundError, NotADirectoryError):
            return False
        cur = os.path.join(cur, p)
    return True

def main():
    seen, todo, bad = set(), ['build.asm'], []
    while todo:
        f = todo.pop()
        if f in seen:
            continue
        seen.add(f)
        try:
            text = open(f, encoding='utf-8', errors='replace').read()
        except FileNotFoundError:
            continue
        for n, line in enumerate(text.split('\n'), 1):
            code = line.split(';', 1)[0]
            for m in INCLUDE.finditer(code):
                target = os.path.normpath(os.path.join(os.path.dirname(f), m.group(1)))
                generated = target.endswith(('.dialogue.txt', '.csv.asm'))
                if not exists_exact(target) and not (generated and not os.path.exists(target)):
                    bad.append(f'{f}:{n}: "{m.group(1)}"')
                elif not target.endswith(('.comp', '.bin', '.sfc')):
                    todo.append(target)
    for b in bad:
        print('wrong case or missing:', b, file=sys.stderr)
    return 1 if bad else 0

if __name__ == '__main__':
    sys.exit(main())
