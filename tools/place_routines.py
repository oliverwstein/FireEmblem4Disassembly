#!/usr/bin/env python3
"""Move verified routines from a work-in-progress file into engine files and the build.

usage: tools/place_routines.py FILE SPEC [--remove]

SPEC lists where the routines go, one section per line (# starts a comment):

    # first label                file                     section name
    rlUnknown869D1B              engine/ai/engine.asm     AIEngineCycleSection
    rlUnknown869F35              engine/ai/attack.asm     AIAttackSection

A section runs from its first label until the next label in SPEC or the end of the
contiguous run of routines, whichever comes first. Routines not covered by any section
stay where they are. Labels must be in address order.

The tool first tests FILE (see test_routines.py) and refuses unless every routine in a
section assembles and matches the ROM. It then measures the register widths at each
section start, writes the sections into their files (in address order; a new file gets
a TODO description), adds placement blocks and includes to build.asm, removes the
placed routines' forward declarations from include/Undisassembled.h, and with
--remove deletes the placed routines from FILE. Run ./build.sh afterwards.
"""
import os, re, sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import asmlib
import test_routines


def read_spec(path):
    spec = []
    for n, l in enumerate(open(path, encoding='utf-8'), 1):
        l = l.split('#', 1)[0].split()
        if not l:
            continue
        if len(l) != 3:
            raise SystemExit(f'{path}:{n}: expected "label file section"')
        spec.append(tuple(l))
    return spec


def first_addr(text):
    m = re.search(r';\s*([0-9A-F]{2})/?([0-9A-F]{4})\b', text)
    return int(m.group(1) + m.group(2), 16) if m else 0


def main():
    args = sys.argv[1:]
    if len(args) < 2:
        print(__doc__); return 2
    path, spec_path, remove = args[0], args[1], '--remove' in args
    spec = read_spec(spec_path)

    res = test_routines.run(path)
    if res.errors:
        raise SystemExit(f'{path} does not assemble; run tools/test_routines.py on it first')
    rom = asmlib.read_rom()
    lines, routines = res.lines, res.routines
    index = {name: k for k, (_, name, _) in enumerate(routines)}
    for label, _, _ in spec:
        if label not in index:
            raise SystemExit(f'{label} is not a routine in {path}')
    starts = [index[label] for label, _, _ in spec]
    if starts != sorted(starts):
        raise SystemExit('SPEC labels must be in address order')

    # Which routines each section covers.
    def contiguous(k):        # routine k+1 directly follows routine k in the ROM
        a, b = routines[k][2], routines[k + 1][2]
        return res.ranges[a][1] == res.ranges[b][0]
    sections = []
    for s, (label, fname, sec) in enumerate(spec):
        k = index[label]
        stop = starts[s + 1] if s + 1 < len(spec) else len(routines)
        members = [k]
        while members[-1] + 1 < stop and contiguous(members[-1]):
            members.append(members[-1] + 1)
        sections.append((label, fname, sec, members))
    placed = [k for *_, members in sections for k in members]
    bad = {name for name, addr, *_ in res.mismatches(rom)}
    not_matching = [routines[k][1] for k in placed if routines[k][1] in bad]
    if not_matching:
        raise SystemExit(f'these routines do not match the ROM yet: {", ".join(not_matching[:10])}')

    widths = asmlib.probe_widths(path, [label for label, *_ in sections])

    def body_of(k):
        i = routines[k][0]
        j = routines[k + 1][0] if k + 1 < len(routines) else len(lines)
        return lines[i:j]

    # Include paths are relative to the including file, so rewrite them for the new location.
    def move_paths(line, dst):
        def rep(m):
            full = os.path.normpath(os.path.join(os.path.dirname(path), m.group(1)))
            return '"' + os.path.relpath(full, os.path.dirname(dst)) + '"'
        return re.sub(r'"(\.\./[^"]+)"', rep, line)

    # Write each section into its file.
    for label, fname, sec, members in sections:
        body = [move_paths(l, fname) for k in members for l in body_of(k)]
        while body and not body[-1].strip():
            body.pop()
        a, x = widths[label]
        new = (f'    .section {sec}\n\n      {a}\n      {x}\n\n' + '\n'.join(body) + f'\n\n    .endsection {sec}\n')
        if os.path.exists(fname):
            d = open(fname, encoding='utf-8').read()
            parts = list(re.finditer(r'    \.section (\w+)\n.*?\n    \.endsection \1\n', d, re.S))
            pos = next((q.start() for q in parts if first_addr(q.group(0)) > routines[members[0]][2]), None)
            d = d.rstrip('\n') + '\n\n\n' + new if pos is None else d[:pos] + new + '\n\n' + d[pos:]
        else:
            os.makedirs(os.path.dirname(fname), exist_ok=True)
            d = '; TODO: describe this file.\n\n' + new
        open(fname, 'w', encoding='utf-8').write(d)

    # Placement blocks: consecutive sections that are contiguous in the ROM share one block.
    blocks = []
    for label, fname, sec, members in sections:
        start = routines[members[0]][2]
        if blocks and blocks[-1][2] == res.ranges[start][0]:
            blocks[-1][1].append(sec)
        else:
            blocks.append([start, [sec], None])
        blocks[-1][2] = res.ranges[routines[members[-1]][2]][1]
    b = open('build.asm', encoding='utf-8').read()
    existing = [(int(m.group(1), 16), m.start()) for m in re.finditer(r'^    \* = \$([0-9A-F]{6})\n', b, re.M)]
    for start, secs, _ in sorted(blocks, reverse=True):
        text = (f'    * = ${asmlib.offset(start):06X}\n    .logical ${start:06X}\n\n'
                + ''.join(f'      .dsection {s}\n' for s in secs) + '\n    .here\n\n')
        pos = next((p for a, p in existing if a > asmlib.offset(start)), None)
        if pos is None:
            raise SystemExit('could not find where to place the block in build.asm')
        b = b[:pos] + text + b[pos:]
    for fname in sorted({f for _, f, _, _ in sections}):
        inc = f'  .include "{fname}"\n'
        if inc in b:
            continue
        engine = [m for m in re.finditer(r'^  \.include "engine/[^"]+"\n', b, re.M)]
        after = [m for m in engine if m.group(0) < inc]
        pos = after[-1].end() if after else engine[0].start()
        b = b[:pos] + inc + b[pos:]
    open('build.asm', 'w', encoding='utf-8').write(b)

    # The placed routines are now defined, so their forward declarations can go.
    und = 'include/Undisassembled.h'
    if os.path.exists(und):
        names = {routines[k][1] for k in placed}
        h = open(und, encoding='utf-8').read().split('\n')
        kept = [l for l in h if not ((m := re.match(r'\s+(\w+)\s+:\?=', l)) and m.group(1) in names)]
        if len(kept) != len(h):
            open(und, 'w', encoding='utf-8').write('\n'.join(kept))

    if remove:
        drop = set()
        for k in placed:
            i = routines[k][0]
            j = routines[k + 1][0] if k + 1 < len(routines) else len(lines)
            drop.update(range(i, j))
        open(path, 'w', encoding='utf-8').write('\n'.join(l for n, l in enumerate(lines) if n not in drop))
    print(f'placed {len(placed)} routines in {len(sections)} sections ({len(blocks)} placement blocks)'
          + (f'; removed them from {path}' if remove else ''))
    return 0


if __name__ == '__main__':
    sys.exit(main())
