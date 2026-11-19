#!/usr/bin/env python3
"""Test-assemble a file of disassembled routines and compare each one with the original ROM.

usage: tools/test_routines.py FILE [--long-branch] [--diagnose] [--overlap] [--show N]

FILE holds routines in the usual style, each starting with a top-level label and its
address (`      rlName ; 86/9D1B`). Each routine is assembled as its own section at that
address, in a temporary copy of the repo, and its bytes are compared with fe4.sfc.

  --long-branch  let out-of-range branches assemble (as longer jumps) so that a
                 build with branch errors can still be compared; for diagnosis only
  --diagnose     for each routine that differs, show the first source line whose
                 instruction differs from the ROM (ignoring branch offsets, which are
                 usually a symptom of a size difference further on)
  --overlap      also check whether any routine overlaps code already built from source
  --show N       list at most N differing routines (default 20)

Errors are reported with line numbers in FILE. Exit status is 0 only if every routine
assembles and matches.
"""
import os, re, sys
from dataclasses import dataclass, field

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import asmlib


@dataclass
class Result:
    lines: list
    routines: list                                   # (line index, name, address)
    errors: list = field(default_factory=list)       # messages with FILE line numbers
    ranges: dict = field(default_factory=dict)       # address -> (start offset, end offset)
    built: bytes = b''
    listing: dict = field(default_factory=dict)      # source line number -> (offset, bytes)

    def mismatches(self, rom):
        """[(name, address, differing byte count, size, first differing offset)]"""
        out = []
        for _, name, addr in self.routines:
            if addr not in self.ranges:
                out.append((name, addr, None, 0, None)); continue
            s, e = self.ranges[addr]
            diffs = [o for o in range(s, e) if self.built[o] != rom[o]]
            if diffs:
                out.append((name, addr, len(diffs), e - s, diffs[0]))
        return out

    def first_difference(self, addr, rom):
        """(source line number, built bytes, original bytes) of the first real difference.

        An instruction whose opcode matches but whose operand differs is usually a
        symptom: it refers forward (a branch, jump or table) past code that has a
        different size. Those are skipped unless nothing else differs.
        """
        s, e = self.ranges[addr]
        entries = [(n, *self.listing[n]) for n in sorted(self.listing) if s <= self.listing[n][0] < e]
        for skip_operand_only in (True, False):
            for n, off, bs in entries:
                orig = rom[off:off + len(bs)]
                if orig == bs or (skip_operand_only and orig[0] == bs[0]):
                    continue
                return n, bs, orig
        return None

    def databank_at(self, n):
        """The nearest .databank directive at or above source line n, and its line number."""
        for j in range(n - 1, -1, -1):
            if self.lines[j].strip().startswith('.databank'):
                return self.lines[j].strip(), j + 1
        return '?', None


def run(path, long_branch=False, listing=False):
    lines = open(path, encoding='utf-8').read().split('\n')
    routines = asmlib.find_routines(lines)
    if not routines:
        raise SystemExit(f'{path}: no routines found (expected lines like "      rlName ; 86/9D1B")')
    out = ['      .al', '      .xl', '']
    srcline = [None, None, None]          # generated line index -> FILE line number
    place = []
    for k, (i, name, addr) in enumerate(routines):
        end = routines[k + 1][0] if k + 1 < len(routines) else len(lines)
        sec = f'TEST_{addr:06X}'
        out += [f'    .section {sec}'] + lines[i:end] + [f'    .endsection {sec}', '']
        srcline += [None] + list(range(i + 1, end + 1)) + [None, None]
        place.append((addr, [sec]))

    res = Result(lines, routines)
    rel = os.path.join(os.path.dirname(path), '_test_routines.asm')
    extra = (['--long-branch'] if long_branch else []) + (['-L', 'list.txt', '--line-numbers'] if listing else [])
    with asmlib.repo_copy() as tmp:
        open(os.path.join(tmp, rel), 'w').write('\n'.join(out))
        asmlib.add_to_build(tmp, rel, place)
        ok, log = asmlib.assemble(tmp, extra=extra)

        def remap(e):
            m = re.match(r'(.*?)_test_routines\.asm:(\d+):(\d+):(.*)', e)
            if m and srcline[int(m.group(2)) - 1]:
                return f'{path}:{srcline[int(m.group(2)) - 1]}:{m.group(3)}:{m.group(4)}'
            return e.replace(tmp + '/', '')
        if os.environ.get('FE4_KEEP_LOG'):
            open(os.environ['FE4_KEEP_LOG'], 'w').write(log)
        res.errors = [remap(e) for e in asmlib.errors(log)]
        if not ok:
            return res
        res.built = open(os.path.join(tmp, 'out.sfc'), 'rb').read()
        res.ranges = {int(n[5:], 16): r for n, r in asmlib.section_ranges(log, 'TEST_').items()}
        if listing and os.environ.get('FE4_KEEP_LISTING'):
            import shutil
            shutil.copy(os.path.join(tmp, 'list.txt'), os.environ['FE4_KEEP_LISTING'])
        if listing:
            cur = None
            for l in open(os.path.join(tmp, 'list.txt'), errors='replace'):
                if 'Processing file:' in l or 'Return to file:' in l:
                    cur = l.rsplit(':', 1)[1].strip(); continue
                m = re.match(r'^(\d+)\t\.([0-9a-f]{1,6})\t[0-9a-f]{6}\t([0-9a-f ]+)\t', l)
                if m and cur == rel and srcline[int(m.group(1)) - 1]:
                    res.listing[srcline[int(m.group(1)) - 1]] = (int(m.group(2), 16), bytes.fromhex(m.group(3).replace(' ', '')))
    return res


def main():
    args = sys.argv[1:]
    if not args or args[0].startswith('-'):
        print(__doc__); return 2
    path = args[0]
    show = int(args[args.index('--show') + 1]) if '--show' in args else 20
    res = run(path, '--long-branch' in args, '--diagnose' in args)
    if res.errors:
        print(f'{len(res.errors)} assembly errors:')
        for e in res.errors[:show * 3]:
            print('  ' + e)
        return 1
    rom = asmlib.read_rom()
    bad = res.mismatches(rom)
    total = sum(e - s for s, e in res.ranges.values())
    print(f'{len(res.routines)} routines, {total:,} bytes: {len(res.routines) - len(bad)} match, {len(bad)} differ')
    for name, addr, n, size, first in bad[:show]:
        if n is None:
            print(f'  {addr:06X} {name}: no bytes emitted'); continue
        print(f'  {addr:06X} {name}: {n} of {size} bytes differ, first at {0xC00000 + first:06X}'
              f' (original {rom[first]:02X}, built {res.built[first]:02X})')
        if res.listing and (d := res.first_difference(addr, rom)):
            ln, bs, orig = d
            db, dbline = res.databank_at(ln)
            print(f'      line {ln}: {res.lines[ln - 1].strip()}   built {bs.hex(" ")}, original {orig.hex(" ")}'
                  f'   [{db}, line {dbline}]')
    if len(bad) > show:
        print(f'  ... {len(bad) - show} more')

    # Contiguous runs, i.e. what needs one placement block each.
    spans = sorted(res.ranges.values())
    runs, gaps = [], []
    for s, e in spans:
        if runs and s == runs[-1][1]:
            runs[-1][1] = e
        else:
            if runs:
                gaps.append((runs[-1][1], s))
            runs.append([s, e])
    overlaps = [(a, b) for a, b in gaps if b < a]
    print(f'{len(runs)} contiguous runs' + (f'; gaps: ' + ', '.join(
        f'{0xC00000 + a:06X}-{0xC00000 + b - 1:06X}' for a, b in gaps if b > a)[:400] if gaps else ''))
    if overlaps:
        print(f'{len(overlaps)} routines overlap the next one (usually because a routine assembled too long)')
    if '--overlap' in args:
        srcmap = asmlib.source_map()
        hit = [name for _, name, addr in res.routines if addr in res.ranges
               and any(srcmap[o] for o in range(*res.ranges[addr]))]
        print(f'{len(hit)} routines overlap code already built from source' + (f': {", ".join(hit[:8])}' if hit else ''))
    return 0 if not bad else 1


if __name__ == '__main__':
    sys.exit(main())
