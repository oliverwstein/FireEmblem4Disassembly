#!/usr/bin/env python3
"""Rename compressed streams: label, .streams entry and files together.

usage: tools/name_streams.py FILE [--write]

FILE has one rename per line, OLD NEW (# starts a comment line). OLD is a
stream listed in a gfx/**/*.streams file as `OLD OLD` (label and file name the
same, as tools/find_streams.py writes them). For each rename the tool

  - rewrites that .streams line as `NEW NEW`, keeping its comment;
  - renames the stream's files next to it: OLD.comp, OLD.4bpp.comp and
    OLD.4bpp.png (with git mv when they are tracked);
  - replaces OLD as a whole word in engine/, include/, events/, data/ and
    build.asm.

A rename may also carry notes: lines of FILE that start with `#:` are added as
comment lines above the next rename's .streams entry (where comments stay when
tools/find_streams.py rewrites the folder).

NEW must not be used anywhere yet. Without --write it checks the list and
reports; with it, it applies the renames and builds. Run
tools/stream_catalog.py afterwards.
"""
import argparse
import glob
import os
import re
import subprocess
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SOURCES = ('engine/**/*.asm', 'include/**/*.h', 'events/**/*.asm', 'data/**/*.asm', 'data/**/*.csv')


def read_list(path):
    renames, notes, pending = {}, {}, []
    for n, line in enumerate(open(path, encoding='utf-8'), 1):
        if line.startswith('#:'):
            pending.append('# ' + line[2:].strip())
            continue
        f = line.split('#', 1)[0].split()
        if not f:
            continue
        if len(f) != 2:
            sys.exit(f'{path}:{n}: expected OLD NEW')
        if f[0] in renames:
            sys.exit(f'{path}:{n}: {f[0]} renamed twice')
        renames[f[0]] = f[1]
        if pending:
            notes[f[0]], pending = pending, []
    if len(set(renames.values())) != len(renames):
        sys.exit(f'{path}: two streams get the same name')
    return renames, notes


def main():
    ap = argparse.ArgumentParser(description=__doc__.split('\n')[0],
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument('list')
    ap.add_argument('--write', action='store_true')
    args = ap.parse_args()
    renames, notes = read_list(args.list)

    streams = {}                                  # OLD -> .streams path
    for path in glob.glob(os.path.join(ROOT, 'gfx', '**', '*.streams'), recursive=True):
        for line in open(path):
            if (m := re.match(r'(\w+) (\w+)\b', line)) and m.group(1) in renames:
                if m.group(1) != m.group(2):
                    sys.exit(f'{m.group(1)}: label and file name differ in {path}')
                streams[m.group(1)] = path
    missing = [o for o in renames if o not in streams]
    if missing:
        sys.exit(f'Not a stream in any .streams file: {", ".join(missing)}')
    files = [f for pat in SOURCES for f in glob.glob(os.path.join(ROOT, pat), recursive=True)
             if not f.endswith('.csv.asm')] + [os.path.join(ROOT, 'build.asm')]
    text = {f: open(f, encoding='utf-8').read() for f in files}
    everything = '\n'.join(text.values()) + ''.join(open(p).read() for p in set(streams.values()))
    used = [n for n in renames.values() if re.search(rf'\b{re.escape(n)}\b', everything)]
    if used:
        sys.exit(f'Already used: {", ".join(used)}')
    print(f'{len(renames)} streams in {len(set(streams.values()))} .streams files')
    if not args.write:
        print('Dry run; --write renames them.')
        return

    pat = re.compile(r'\b(' + '|'.join(map(re.escape, renames)) + r')\b')
    for f, t in text.items():
        new = pat.sub(lambda m: renames[m.group(1)], t)
        if new != t:
            open(f, 'w', encoding='utf-8').write(new)
    tracked = set(subprocess.run(['git', 'ls-files', 'gfx'], cwd=ROOT, capture_output=True,
                                 text=True).stdout.split('\n'))
    for path in set(streams.values()):
        out = []
        for line in open(path).read().split('\n'):
            m = re.match(r'(\w+) \w+(.*)', line)
            if m and m.group(1) in renames:
                old, new = m.group(1), renames[m.group(1)]
                out += [n for n in notes.get(old, []) if n not in out[-len(notes[old]):]]
                out.append(f'{new} {new}{m.group(2)}')
                folder = os.path.dirname(path)
                for ext in ('.comp', '.4bpp.comp', '.4bpp.png', '.bin.comp', '.bin'):
                    src, dst = os.path.join(folder, old + ext), os.path.join(folder, new + ext)
                    if os.path.exists(src):
                        if os.path.relpath(src, ROOT) in tracked:
                            subprocess.run(['git', 'mv', src, dst], cwd=ROOT, check=True)
                        else:
                            os.rename(src, dst)
            else:
                out.append(line)
        open(path, 'w').write('\n'.join(out))
    print(f'Renamed {len(renames)} streams.')
    sys.exit(subprocess.call(['./build.sh'], cwd=ROOT))


if __name__ == '__main__':
    main()
