#!/usr/bin/env python3
"""Move verified routines from a work-in-progress file into engine files and the build.

usage: tools/place_routines.py FILE SPEC [--remove]

SPEC lists where the routines go, one section per line (# starts a comment):

    # first label                file                     section name
    rlUnknown869D1B              engine/ai/engine.asm     AIEngineCycleSection
    rlUnknown869F35              engine/ai/attack.asm     AIAttackSection

A section runs from its first label until the next label in SPEC, the end of the
contiguous run of routines, or a routine that does not match the ROM, whichever comes
first. Routines not covered by any section stay where they are. Labels must be in
address order.

Steps:
  1. Test FILE (see test_routines.py). FILE must assemble.
  2. Measure the register widths at each section start.
  3. Trial: apply the placement to a temporary copy, build it, and leave out any
     routine whose bytes differ. This catches routines that only matched because of
     code that stays behind, such as a branch into the next routine. Repeat until the
     trial build matches the ROM.
  4. Apply the placement to the working tree: write the sections into their files (in
     address order; a new file gets a TODO description), add placement blocks and
     includes to build.asm, remove the placed routines' forward declarations from
     include/Undisassembled.h, and with --remove delete them from FILE.
Run ./build.sh afterwards.
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


class Placement:
    def __init__(self, path, res, spec, excluded):
        self.path, self.res = path, res
        self.lines, self.routines = res.lines, res.routines
        index = {name: k for k, (_, name, _) in enumerate(self.routines)}
        starts = [index[label] for label, _, _ in spec]

        def contiguous(k):
            a, b = self.routines[k][2], self.routines[k + 1][2]
            return a in res.ranges and b in res.ranges and res.ranges[a][1] == res.ranges[b][0]

        self.sections = []
        for s, (label, fname, sec) in enumerate(spec):
            k = index[label]
            if label in excluded:
                continue
            stop = starts[s + 1] if s + 1 < len(spec) else len(self.routines)
            members = [k]
            while (members[-1] + 1 < stop and self.routines[members[-1] + 1][1] not in excluded
                   and contiguous(members[-1])):
                members.append(members[-1] + 1)
            self.sections.append((label, fname, sec, members))
        self.placed = [k for *_, members in self.sections for k in members]

    def body_of(self, k):
        i = self.routines[k][0]
        j = self.routines[k + 1][0] if k + 1 < len(self.routines) else len(self.lines)
        return self.lines[i:j]

    def move_paths(self, line, dst):
        """Include paths are relative to the including file; rewrite them for dst."""
        def rep(m):
            full = os.path.normpath(os.path.join(os.path.dirname(self.path), m.group(1)))
            return '"' + os.path.relpath(full, os.path.dirname(dst)) + '"'
        return re.sub(r'"(\.\./[^"]+)"', rep, line)

    def apply(self, root, widths, remove):
        res, routines = self.res, self.routines
        for label, fname, sec, members in self.sections:
            body = [self.move_paths(l, fname) for k in members for l in self.body_of(k)]
            while body and not body[-1].strip():
                body.pop()
            a, x = widths[label]
            new = f'    .section {sec}\n\n      {a}\n      {x}\n\n' + '\n'.join(body) + f'\n\n    .endsection {sec}\n'
            full = os.path.join(root, fname)
            if os.path.exists(full):
                d = open(full, encoding='utf-8').read()
                parts = list(re.finditer(r'    \.section (\w+)\n.*?\n    \.endsection \1\n', d, re.S))
                pos = next((q.start() for q in parts if first_addr(q.group(0)) > routines[members[0]][2]), None)
                d = d.rstrip('\n') + '\n\n\n' + new if pos is None else d[:pos] + new + '\n\n' + d[pos:]
            else:
                os.makedirs(os.path.dirname(full), exist_ok=True)
                d = '; TODO: describe this file.\n\n' + new
            open(full, 'w', encoding='utf-8').write(d)

        # Placement blocks: consecutive sections that are contiguous in the ROM share one block.
        blocks = []
        for label, fname, sec, members in self.sections:
            start = routines[members[0]][2]
            if blocks and blocks[-1][2] == res.ranges[start][0]:
                blocks[-1][1].append(sec)
            else:
                blocks.append([start, [sec], None])
            blocks[-1][2] = res.ranges[routines[members[-1]][2]][1]
        bp = os.path.join(root, 'build.asm')
        b = open(bp, encoding='utf-8').read()
        existing = [(int(m.group(1), 16), m.start()) for m in re.finditer(r'^    \* = \$([0-9A-F]{6})\n', b, re.M)]
        for start, secs, _ in sorted(blocks, reverse=True):
            text = (f'    * = ${asmlib.offset(start):06X}\n    .logical ${start:06X}\n\n'
                    + ''.join(f'      .dsection {s}\n' for s in secs) + '\n    .here\n\n')
            pos = next((p for a, p in existing if a > asmlib.offset(start)), None)
            if pos is None:
                raise SystemExit('could not find where to place a block in build.asm')
            b = b[:pos] + text + b[pos:]
        for fname in sorted({f for _, f, _, _ in self.sections}):
            inc = f'  .include "{fname}"\n'
            if inc in b:
                continue
            engine = list(re.finditer(r'^  \.include "engine/[^"]+"\n', b, re.M))
            after = [m for m in engine if m.group(0) < inc]
            pos = after[-1].end() if after else engine[0].start()
            b = b[:pos] + inc + b[pos:]
        open(bp, 'w', encoding='utf-8').write(b)

        # The placed routines are now defined, so their forward declarations can go.
        und = os.path.join(root, 'include/Undisassembled.h')
        if os.path.exists(und):
            names = {routines[k][1] for k in self.placed}
            h = open(und, encoding='utf-8').read().split('\n')
            kept = [l for l in h if not ((m := re.match(r'\s+(\w+)\s+:\?=', l)) and m.group(1) in names)]
            open(und, 'w', encoding='utf-8').write('\n'.join(kept))

        if remove:
            drop = set()
            for k in self.placed:
                i = routines[k][0]
                j = routines[k + 1][0] if k + 1 < len(routines) else len(self.lines)
                drop.update(range(i, j))
            open(os.path.join(root, self.path), 'w', encoding='utf-8').write(
                '\n'.join(l for n, l in enumerate(self.lines) if n not in drop))
        return len(blocks)


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
    index = {name: k for k, (_, name, _) in enumerate(res.routines)}
    for label, _, _ in spec:
        if label not in index:
            raise SystemExit(f'{label} is not a routine in {path}')
    starts = [index[label] for label, _, _ in spec]
    if starts != sorted(starts):
        raise SystemExit('SPEC labels must be in address order')
    excluded = {name for name, addr, *_ in res.mismatches(rom)}
    not_matching = [label for label, _, _ in spec if label in excluded]
    if not_matching:
        raise SystemExit(f'these SPEC labels do not match the ROM yet: {", ".join(not_matching[:10])}')

    widths = asmlib.probe_widths(path, [label for label, _, _ in spec])

    # Trial placements until the real build matches.
    left_out = []
    while True:
        plan = Placement(path, res, spec, excluded)
        if not plan.placed:
            raise SystemExit('nothing left to place')
        with asmlib.repo_copy() as tmp:
            plan.apply(tmp, widths, remove=True)
            ok, log = asmlib.assemble(tmp)
            if not ok:
                raise SystemExit('trial build failed:\n' + '\n'.join(asmlib.errors(log)[:15]))
            built = open(os.path.join(tmp, 'out.sfc'), 'rb').read()
        wrong = [res.routines[k][1] for k in plan.placed
                 if (r := res.ranges[res.routines[k][2]]) and built[r[0]:r[1]] != rom[r[0]:r[1]]]
        if not wrong:
            if built != rom:
                raise SystemExit('trial build differs outside the placed routines; nothing changed')
            break
        left_out += wrong
        excluded |= set(wrong)

    nblocks = plan.apply('.', widths, remove)
    print(f'placed {len(plan.placed)} routines in {len(plan.sections)} sections ({nblocks} placement blocks)'
          + (f'; removed them from {path}' if remove else ''))
    if left_out:
        print(f'left out {len(left_out)} that only match together with code that stays in {path}: '
              + ', '.join(left_out))
    return 0


if __name__ == '__main__':
    sys.exit(main())
