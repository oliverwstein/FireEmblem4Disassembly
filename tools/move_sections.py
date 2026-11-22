#!/usr/bin/env python3
"""Move whole sections from one engine file to another.

usage: tools/move_sections.py SPEC

SPEC has one line per section: the section name and the file to move it to
(# starts a comment). Each `.section NAME` ... `.endsection NAME` block is cut
from the file that has it and added to the end of the target file, in address
order with any other sections moved there. build.asm places sections by name, so
this does not change the ROM; a target file that is not included in build.asm
yet is added to it. Run ./build.sh afterwards.
"""
import os, re, sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))


def find_block(text, name):
    m = re.search(r'(?m)^[ \t]*\.section ' + re.escape(name) + r'\s*$', text)
    if not m:
        return None
    e = re.search(r'(?m)^[ \t]*\.endsection ' + re.escape(name) + r'\s*$', text[m.end():])
    start = m.start()
    end = m.end() + e.end()
    return start, end


def first_address(block):
    m = re.search(r';\s*([0-9A-F]{2})/([0-9A-F]{4})', block)
    return int(m.group(1) + m.group(2), 16) if m else 0


def main():
    if len(sys.argv) != 2:
        raise SystemExit(__doc__)
    spec = []
    for line in open(sys.argv[1], encoding='utf-8'):
        p = line.split('#', 1)[0].split()
        if p:
            spec.append((p[0], p[1]))
    files = {}
    import glob
    for f in glob.glob('engine/**/*.asm', recursive=True):
        files[f] = open(f, encoding='utf-8').read()
    moved = {}
    for name, target in spec:
        src = next((f for f, t in files.items() if find_block(t, name)), None)
        if src is None:
            raise SystemExit(f'section {name} not found')
        if src == target:
            continue
        s, e = find_block(files[src], name)
        block = files[src][s:e]
        files[src] = re.sub(r'\n{3,}', '\n\n\n', files[src][:s].rstrip('\n') + '\n\n\n' + files[src][e:].lstrip('\n'))
        moved.setdefault(target, []).append(block)
    for target, blocks in moved.items():
        text = files.get(target)
        if text is None:
            text = '; TODO: describe this file.\n'
        for b in sorted(blocks, key=first_address):
            text = text.rstrip('\n') + '\n\n\n' + b + '\n'
        files[target] = text
    for target in moved:
        # Before anything is written: a missing folder would otherwise fail
        # after the sources had already lost their sections.
        os.makedirs(os.path.dirname(target), exist_ok=True)
    for f, t in files.items():
        if not os.path.exists(f) or open(f, encoding='utf-8').read() != t:
            open(f, 'w', encoding='utf-8').write(t)
    build = open('build.asm', encoding='utf-8').read()
    for target in moved:
        inc = f'  .include "{target}"\n'
        if inc not in build:
            anchor = '  ROM = binary("fe4.sfc")\n'
            build = build.replace(anchor, anchor + inc, 1)
    open('build.asm', 'w', encoding='utf-8').write(build)
    print(f'moved {sum(len(b) for b in moved.values())} sections into {len(moved)} files')


if __name__ == '__main__':
    main()
