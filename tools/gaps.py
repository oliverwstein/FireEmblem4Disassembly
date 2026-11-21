#!/usr/bin/env python3
"""Catalogue the ROM bytes that are not built from source yet: GAPS.md.

usage: tools/gaps.py [--out GAPS.md]

Splits the bytes the build still copies from fe4.sfc (the same two-fill test as
./build.sh coverage) into pieces: each run of unbuilt bytes. A run of one
value ($00 or $FF) is padding and is only counted. For every other piece it
gathers the evidence of what it is, and writes one row per piece:

  - references from the source: six-digit numbers into it (from
    tools/raw_addresses.py --list), long pointers loaded in two halves (from
    tools/code_pointers.py), and names in include/Undisassembled.h, each with
    where it is and whether it points at the piece's first byte;
  - fe4.cdl: how many bytes the prologue log shows read (and executed: none
    should be, since everything executed is built), and the first and last
    byte read;
  - the built labels on either side, and how much of the piece is padding.

Pieces are classed by the strongest evidence:

  code      a jsl, jml, jsr, jmp or RUN_ASM in the source targets it, or a
            jump table's raw entry: disassemble it (tools/disasm.py);
  table     read by built code at its first byte: a table, its length from the
            reader (tools/rom_tables.py writes those with a certain extent);
  inside    built code reads or points into it, but not at its start: more than
            one structure, or a table that starts in built bytes;
  log       read in the log, but nothing in the source points at it: reached
            through a pointer that is data (a table not decoded yet) or computed;
  none      no evidence: dead code or data, or reached from data not decoded.

Takes a minute or two (it builds three times). Run it again as gaps close.
"""
import argparse
import bisect
import collections
import os
import re
import subprocess
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from decompress import rom_offset
from trace import coverage_mask

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
CODE_REF = re.compile(r'\b(jsl|jml|jsr|jmp|RUN_ASM|PROC_CALL\w*)\b')


def address(o):
    """The address a ROM offset is read at: bank $80-$BF for upper halves, $C0-$FF else."""
    return (0x800000 | o) if o & 0x8000 and o < 0x400000 else (0xC00000 | o)


def fmt(o):
    a = address(o)
    return f'${a >> 16:02X}/{a & 0xFFFF:04X}'


def off(a):
    x = rom_offset(a)
    return rom_offset(a | 0x400000) if x is None else x


def references():
    """[(offset, kind, where, text)] for references in the source to unbuilt bytes."""
    out = []
    raw = subprocess.run([sys.executable, 'tools/raw_addresses.py', '--list'], cwd=ROOT,
                         capture_output=True, text=True).stdout
    for l in raw.split('\n'):
        m = re.match(r'\s+left\s+(\S+): (.*)', l)
        if m:
            for a in re.findall(r'\$([0-9A-F]{6})\b', m.group(2)):
                o = off(int(a, 16))
                if o is not None:
                    out.append((o, 'number', m.group(1), m.group(2).strip()))
    cp = subprocess.run([sys.executable, 'tools/code_pointers.py'], cwd=ROOT, capture_output=True, text=True).stdout
    for l in cp.split('\n'):
        m = re.match(r'\s+(\S+:\d+) (\S+) \$([0-9A-F]{6})', l)
        if m:
            o = off(int(m.group(3), 16))
            if o is not None:
                out.append((o, 'halves', m.group(1), f'long pointer in {m.group(2)}'))
    for n, l in enumerate(open(os.path.join(ROOT, 'include/Undisassembled.h')), 1):
        m = re.search(r'^\s*(\w+)\s*:\?= address\(\$([0-9A-F]{6})\) ; read by (.*)', l)
        if m:
            out.append((off(int(m.group(2), 16)), 'named', f'include/Undisassembled.h:{n}',
                        f'{m.group(1)}, read by {m.group(3)}'))
    return out


def labels():
    out = {}
    for l in open(os.path.join(ROOT, 'labels.txt')):
        p = l.split()
        if len(p) == 3 and ':' not in p[2]:
            o = off(int(p[1], 16))
            if o is not None:
                out.setdefault(o, p[2].lstrip('.'))
    return out


def main():
    ap = argparse.ArgumentParser(description=__doc__.split('\n')[0])
    ap.add_argument('--out', default='GAPS.md')
    args = ap.parse_args()
    rom = open(os.path.join(ROOT, 'fe4.sfc'), 'rb').read()
    cdl = open(os.path.join(ROOT, 'fe4.cdl'), 'rb').read()[9:]
    subprocess.run(['./build.sh'], cwd=ROOT, capture_output=True)       # fresh labels.txt
    mask = coverage_mask()
    lab = labels()
    lab_offs = sorted(lab)
    runs, i = [], 0
    while i < len(mask):
        if not mask[i]:
            j = i
            while j < len(mask) and not mask[j]:
                j += 1
            runs.append((i, j))
            i = j
        else:
            i += 1
    pad = [(a, b) for a, b in runs if len(set(rom[a:b])) == 1 and rom[a] in (0, 0xFF)]
    pieces = [(a, b) for a, b in runs if (a, b) not in set(pad)]
    starts = [a for a, _ in pieces]
    refs = collections.defaultdict(list)
    for o, kind, where, text in references():
        k = bisect.bisect_right(starts, o) - 1
        if k >= 0 and pieces[k][0] <= o < pieces[k][1]:
            refs[k].append((o, kind, where, text))
    rows = []
    for k, (a, b) in enumerate(pieces):
        rd = [x for x in range(a, b) if cdl[x] & 2]
        ex = sum(1 for x in range(a, b) if cdl[x] & 1)
        r = refs.get(k, [])
        padn = sum(1 for x in rom[a:b] if x in (0, 0xFF))
        if any(CODE_REF.search(t) or (t.startswith('.word') and '<>r' in t) for _, _, _, t in r):
            cls = 'code'
        elif any(o == a for o, _, _, _ in r):
            cls = 'table'
        elif r:
            cls = 'inside'
        elif rd:
            cls = 'log'
        else:
            cls = 'none'
        j = bisect.bisect_right(lab_offs, a) - 1
        before = lab[lab_offs[j]] if j >= 0 else ''
        after = lab.get(b, '')
        rows.append(dict(a=a, b=b, cls=cls, refs=r, read=rd, exe=ex, pad=padn, before=before, after=after))
    order = ['code', 'table', 'inside', 'log', 'none']
    text = ['# ROM bytes not built from source', '',
            'Made by `tools/gaps.py`; do not edit. Every run of bytes the build still copies from',
            '`fe4.sfc`, with the evidence of what it is. Classes, strongest evidence first:',
            '`code` (a call or jump in the source targets it), `table` (built code reads it at its',
            'first byte), `inside` (built code points into it, not at its start), `log` (read in',
            '`fe4.cdl` only), `none` (no evidence). Addresses are given where the game reads them:',
            'upper halves in banks `$80`-`$BF`, lower halves in `$C0`-`$FF`.', '']
    total = sum(b - a for a, b in runs)
    text += [f'{total:,} bytes in {len(runs)} runs: {len(pad)} runs of padding ({sum(b - a for a, b in pad):,} bytes) '
             f'and {len(rows)} pieces ({sum(r["b"] - r["a"] for r in rows):,} bytes).', '',
             '| Class | Pieces | Bytes | Read in the log |', '|---|---|---|---|']
    for c in order:
        rs = [r for r in rows if r['cls'] == c]
        text.append(f'| `{c}` | {len(rs)} | {sum(r["b"] - r["a"] for r in rs):,} | '
                    f'{sum(len(r["read"]) for r in rs):,} |')
    text.append('')
    for c in order:
        rs = [r for r in rows if r['cls'] == c]
        text += [f'## `{c}` ({len(rs)})', '', '| Piece | Bytes | Log reads | Between | Evidence |', '|---|---|---|---|---|']
        for r in rs:
            n = r['b'] - r['a']
            rd = r['read']
            log = f'{len(rd)} (+{rd[0] - r["a"]:X}-+{rd[-1] - r["a"]:X})' if rd else '0'
            if r['exe']:
                log += f', {r["exe"]} executed'
            ev = '; '.join(f'{"**at start** " if o == r["a"] else f"+{o - r["a"]:X} "}{kind} `{where}`: `{t[:60]}`'
                           for o, kind, where, t in r['refs'][:4])
            if len(r['refs']) > 4:
                ev += f'; and {len(r["refs"]) - 4} more'
            if r['pad'] * 2 > n:
                ev = (ev + '; ' if ev else '') + f'{r["pad"] * 100 // n}% $00/$FF'
            text.append(f'| {fmt(r["a"])}-{fmt(r["b"] - 1)} | {n:,} | {log} | `{r["before"]}` / `{r["after"]}` | {ev} |')
        text.append('')
    open(os.path.join(ROOT, args.out), 'w').write('\n'.join(text))
    for c in order:
        rs = [r for r in rows if r['cls'] == c]
        print(f'{c:7} {len(rs):4} pieces {sum(r["b"] - r["a"] for r in rs):9,} bytes')
    print(f'padding {len(pad)} runs; wrote {args.out}')


if __name__ == '__main__':
    main()
