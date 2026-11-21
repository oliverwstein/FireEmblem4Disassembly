#!/usr/bin/env python3
"""Carve what a pointer table points at into labelled source.

usage: tools/carve.py TABLE --type TYPE --name NAME [options] [--write]
       tools/carve.py ADDR:SIZE --type block --name NAME [--prefix P] [--write]

TABLE is the label of a table of long pointers in the source (a run of `.long`
lines after the label) or a pointer CSV (data/....csv, one pointer per row in
its last column). Without --write the tool only reports; with it, it writes the
source, puts each run of blocks in build.asm, rewrites the table and the raw
numbers elsewhere in the source that point into the carved blocks, and builds.

TYPE says what the targets are and so how long each one is:

  dialogue    text for the dialogue engine, read to its DIALOGUE_EOF
              (tools/dialogue.py). Written as text files in --dir, built with
              tools/process_dialogue.py like the other dialogue.
  compressed  a stream for rlDecompressor, measured by tools/decompress.py.
              Written as a labelled slice of the ROM (.text ROM[...]).
  fixed:N     N bytes each. Written as a slice.
  next        each runs to the next target (the default when nothing is known).
              Written as a slice.
  block       no table: ADDR:SIZE (hex) is one region, such as a tile sheet
              that code indexes by offset. Written as one slice labelled
              PREFIX+NAME; raw numbers pointing into it become label+N. The
              offsets code adds to it, and pointers loaded in two halves
              (tools/code_pointers.py), are not rewritten.

Each target ends where its type says; if that is not where the next target
starts, the report says so. A gap before the next target is decoded the same
way when it can be (bytes nothing in the table points at, often more of the
same) and named by address; otherwise it becomes an aUnknownXXXXXX slice. A
target that its type says ends past the next target is cut there and falls
through into it, as some texts do. Slices that cross from one bank half into
the next are split the way the decompressor reads them.

Labels: NAME plus the first table index that uses the target, in hex (for
--type dialogue: dialogueShop00 in text/dialogue/DIR/Shop00.txt); targets
found in gaps: NAMEUnknown plus the address. Rename them later with
tools/rename.py.

options:
  --dir DIR          for dialogue: the folder under text/dialogue (default NAME)
  --prefix P         label prefix for slices (default g for compressed, a otherwise)
  --end ADDR         carve on past the last target up to ADDR (exclusive), as
                     more of the same type
  --write            apply (otherwise only report)
"""
import argparse
import bisect
import csv
import glob
import os
import re
import subprocess
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from decompress import decompress, rom_offset, DecompressionError
from dialogue import Decoder

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


def cpu(a):
    return f'${a >> 16:02X}/{a & 0xFFFF:04X}'


def load_labels():
    by_name, by_addr = {}, {}
    for line in open(os.path.join(ROOT, 'labels.txt')):
        parts = line.split()
        if len(parts) == 3:
            name, a = parts[2].lstrip('.'), int(parts[1], 16)
            by_name[name] = a
            if ':' not in name:
                by_addr.setdefault(a, name)
    return by_name, by_addr


class Table:
    """A pointer table in the source: where it is and its entries."""

    def __init__(self, spec, labels):
        self.entries = []          # [(file, line index, column span or None, value)]
        if spec.endswith('.csv'):
            self.path = spec
            rows = open(spec, encoding='utf-8').read().split('\n')
            for k, row in enumerate(rows[1:], 1):
                if row.strip():
                    v = row.rsplit(',', 1)[1].strip()
                    self.entries.append((spec, k, None, self.value(v, labels)))
            self.label = None
            return
        hits = [f for f in glob.glob(os.path.join(ROOT, '**', '*.asm'), recursive=True)
                if re.search(rf'^\s*{re.escape(spec)}\b', open(f, encoding='utf-8').read(), re.M)
                and not f.endswith('.csv.asm')]
        if len(hits) != 1:
            sys.exit(f'{spec}: found in {len(hits)} source files')
        self.path, self.label = hits[0], spec
        lines = open(self.path, encoding='utf-8').read().split('\n')
        start = next(i for i, l in enumerate(lines) if re.match(rf'\s*{re.escape(spec)}\b', l))
        i = start + 1
        while i < len(lines):
            code = lines[i].split(';')[0].strip()
            if not code:
                if self.entries:
                    break
                i += 1
                continue
            m = re.match(r'\.long\s+(.*)', code)
            if not m:
                break
            col = lines[i].index(m.group(1))
            for item in re.finditer(r'[^,\s][^,]*', m.group(1)):
                self.entries.append((self.path, i, (col + item.start(), col + item.end()),
                                     self.value(item.group().strip(), labels)))
            i += 1
        if not self.entries:
            sys.exit(f'{spec}: no .long entries after the label')

    @staticmethod
    def value(text, labels):
        if text.startswith('$'):
            return int(text[1:], 16)
        if text in labels:
            return labels[text]
        sys.exit(f'Table entry {text!r} is neither a number nor a known label')


class Piece:
    def __init__(self, start, end, name, kind, text=None):
        self.start, self.end, self.name, self.kind, self.text = start, end, name, kind, text


def measure(kind, rom, start, limit, decoder):
    """End of the target at start (exclusive), and its text for dialogue; None if
    the type does not fit the bytes."""
    if kind == 'dialogue':
        text, end = decoder.decode(rom, start, limit)
        return end, text
    if kind == 'compressed':
        try:
            return decompress(rom, start)[1], None
        except DecompressionError:
            return None, None
    if kind.startswith('fixed:'):
        return start + int(kind[6:], 0), None
    return limit, None


def plan(table, kind, name, rom, end_limit, mask, labels_by_addr):
    decoder = Decoder() if kind == 'dialogue' else None
    first_index = {}
    for k, (_, _, _, v) in enumerate(table.entries):
        first_index.setdefault(v, k)
    targets = sorted(first_index)
    issues, pieces = [], []
    stops = targets + ([end_limit] if end_limit else [])
    for k, t in enumerate(targets):
        nxt = stops[k + 1] if k + 1 < len(stops) else None
        if rom_offset(t) is None or mask[rom_offset(t)]:
            issues.append(f'{cpu(t)} is already source or not ROM; left alone')
            continue
        end, text = measure(kind, rom, t, nxt, decoder)
        if end is None:
            issues.append(f'{cpu(t)}: not a valid {kind} target')
            continue
        if nxt is not None and end > nxt:
            issues.append(f'{cpu(t)} runs past the next target {cpu(nxt)}; cut there (falls through)')
            end, text = measure(kind, rom, t, nxt, decoder) if kind == 'dialogue' else (nxt, None)
        pieces.append(Piece(t, end, f'{name}{first_index[t]:02X}', kind, text))
        # A gap before the next target: more of the same, if it decodes exactly.
        a = end
        while nxt is not None and a < nxt:
            e, text = measure(kind, rom, a, nxt, decoder)
            if e is None or e > nxt or e <= a:
                pieces.append(Piece(a, nxt, f'aUnknown{a:06X}', 'next'))
                issues.append(f'{cpu(a)}-{cpu(nxt)}: {nxt - a} bytes that are not {kind}; a slice')
                break
            pieces.append(Piece(a, e, f'{name}Unknown{a:06X}', kind, text))
            a = e
    for p in pieces:
        if any(mask[rom_offset(x)] for x in range(p.start, p.end) if rom_offset(x) is not None):
            issues.append(f'{p.name} ({cpu(p.start)}-{cpu(p.end)}) overlaps source; fix the extents')
        old = labels_by_addr.get(p.start)
        if old and not old.startswith('aUnknown'):
            issues.append(f'{cpu(p.start)} already has the label {old}')
    return pieces, issues


def runs(pieces):
    """Contiguous runs of pieces, split where a bank half ends."""
    out, cur = [], []
    for p in sorted(pieces, key=lambda p: p.start):
        if cur and (p.start != cur[-1].end or (p.start & 0xFFFF) in (0x0000, 0x8000)):
            out.append(cur)
            cur = []
        cur.append(p)
    if cur:
        out.append(cur)
    return out


def slices(p):
    """(start, end) ROM ranges of a piece, split where it crosses a bank half."""
    out, s = [], p.start
    while s < p.end:
        half_end = (s & 0xFF0000) + (0x8000 if s & 0xFFFF < 0x8000 else 0x10000)
        if p.end <= half_end:
            out.append((s, p.end))
            break
        out.append((s, half_end))
        s = (s & 0xFF0000) + 0x10000 + (s & 0x8000)   # next bank, same half
    return out


def write(table, pieces, kind, name, args, labels_by_name):
    label_of = {}
    blocks = []                                      # [(start, [lines])]
    for run in runs(pieces):
        lines = []
        for p in run:
            label = ('dialogue' + p.name) if p.kind == 'dialogue' else p.name
            if p.kind != 'dialogue' and not label.startswith('aUnknown'):
                label = args.prefix + label
            label_of[p.start] = label
            if p.kind == 'dialogue':
                rel = os.path.join('text', 'dialogue', args.dir, p.name + '.txt')
                os.makedirs(os.path.join(ROOT, os.path.dirname(rel)), exist_ok=True)
                open(os.path.join(ROOT, rel), 'w', encoding='utf-8').write(p.text)
                lines.append(f'      {label} .include "{rel[:-4]}.dialogue.txt" ; {p.start:06X}')
            else:
                parts = slices(p)
                for k, (s, e) in enumerate(parts):
                    if k == 0:
                        lines.append(f'      {label} .text ROM[${rom_offset(s):06X}:${rom_offset(e - 1) + 1:06X}] ; {s:06X}')
                    else:                            # rest of a piece in the next bank half
                        blocks.append((s, [f'      .text ROM[${rom_offset(s):06X}:${rom_offset(e - 1) + 1:06X}] ; {s:06X}, rest of {label}']))
        blocks.append((run[0].start, lines))
    # build.asm: each block before the first placement that starts after it.
    b = open(os.path.join(ROOT, 'build.asm'), encoding='utf-8').read().split('\n')
    starts = [(i, int(m.group(1), 16)) for i, l in enumerate(b)
              if (m := re.match(r'\s*\* = \$([0-9A-Fa-f]+)', l))]
    inserts = []
    for s, lines in blocks:
        off = rom_offset(s)
        nxt = min((x for x in starts if x[1] > off), key=lambda x: x[1], default=(len(b), None))
        inserts.append((nxt[0], off, [f'    * = ${off:06X}', f'    .logical ${s:06X}', '',
                                      *lines, '', '    .here', '']))
    for at, _, text in sorted(inserts, key=lambda t: (-t[0], -t[1])):
        b[at:at] = text
    open(os.path.join(ROOT, 'build.asm'), 'w', encoding='utf-8').write('\n'.join(b))

    # The table: rewrite its entries with the labels.
    if table.label:
        lines = open(table.path, encoding='utf-8').read().split('\n')
        first, last = table.entries[0][1], table.entries[-1][1]
        items = [label_of.get(v, f'${v:06X}') for *_, v in table.entries]
        lines[first:last + 1] = [f'        .long {x}' for x in items]
        open(table.path, 'w', encoding='utf-8').write('\n'.join(lines))
    elif table.path:
        lines = open(table.path, encoding='utf-8').read().split('\n')
        for _, line, _, v in table.entries:
            if v in label_of:
                head, _, _ = lines[line].rpartition(',')
                lines[line] = f'{head},{label_of[v]}'
        open(table.path, 'w', encoding='utf-8').write('\n'.join(lines))

    # Raw numbers elsewhere that point into the blocks, or into the table.
    ranges = sorted((p.start, p.end, label_of[p.start]) for p in pieces)
    if table.label and table.entries:
        t0 = labels_by_name[table.label]
        ranges.append((t0, t0 + 3 * len(table.entries), table.label))
    return replace_raw_numbers(sorted(ranges))


def replace_raw_numbers(ranges):
    """Rewrite six-digit numbers in the source that fall in a range as label+N."""
    starts = [r[0] for r in ranges]
    count = 0
    files = (glob.glob(os.path.join(ROOT, 'engine', '**', '*.asm'), recursive=True)
             + glob.glob(os.path.join(ROOT, 'events', '**', '*.asm'), recursive=True)
             + [f for f in glob.glob(os.path.join(ROOT, 'data', '**', '*.asm'), recursive=True)
                if not f.endswith('.csv.asm')])

    mirrored = []

    def sub(m):
        nonlocal count
        v = int(m.group(1), 16)
        k = bisect.bisect_right(starts, v) - 1
        if k >= 0 and ranges[k][0] <= v < ranges[k][1]:
            s, _, label = ranges[k]
            count += 1
            return label + (f'+{v - s}' if v > s else '')
        other = v ^ 0x400000 if v >> 16 >= 0x80 else None   # the other ROM mirror
        k = bisect.bisect_right(starts, other) - 1 if other is not None else -1
        if k >= 0 and ranges[k][0] <= other < ranges[k][1]:
            mirrored.append(m.group(0))                      # same byte, other mirror:
        return m.group(0)                                    # left for a look

    for path in files:
        text = open(path, encoding='utf-8').read()
        out = []
        for line in text.split('\n'):
            code, sep, comment = line.partition(';')
            if re.match(r'\s*\.(logical|fill)\b', code):
                out.append(line)
                continue
            code = re.sub(r'(?<![\w#<>`])\$([0-9A-Fa-f]{6})\b', sub, code)
            code = re.sub(r'(?<=#\(`)\$([0-9A-Fa-f]{6})\b', sub, code)
            code = re.sub(r'(?<=#<>)\$([0-9A-Fa-f]{6})\b', sub, code)
            out.append(code + sep + comment)
        new = '\n'.join(out)
        if new != text:
            open(path, 'w', encoding='utf-8').write(new)
    if mirrored:
        print(f'Left alone (the other ROM mirror of a carved address): {", ".join(sorted(set(mirrored)))}')
    return count


def main():
    ap = argparse.ArgumentParser(description=__doc__.split('\n')[0],
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument('table')
    ap.add_argument('--type', required=True)
    ap.add_argument('--name', required=True)
    ap.add_argument('--dir')
    ap.add_argument('--prefix')
    ap.add_argument('--end')
    ap.add_argument('--write', action='store_true')
    args = ap.parse_args()
    if not (args.type in ('dialogue', 'compressed', 'next', 'block') or re.fullmatch(r'fixed:\w+', args.type)):
        sys.exit(f'Unknown --type {args.type}')
    args.dir = args.dir or args.name
    args.prefix = args.prefix or ('g' if args.type == 'compressed' else 'a')

    from trace import coverage_mask
    labels_by_name, labels_by_addr = load_labels()
    rom = open(os.path.join(ROOT, 'fe4.sfc'), 'rb').read()
    print('Measuring what is built from source...')
    mask = coverage_mask()
    if args.type == 'block':
        m = re.fullmatch(r'\$?([0-9A-Fa-f]{6}):\$?([0-9A-Fa-f]+)', args.table)
        if not m:
            sys.exit('--type block takes ADDR:SIZE, such as D84000:4000')
        start, size = int(m.group(1), 16), int(m.group(2), 16)
        table = Table.__new__(Table)
        table.entries, table.label, table.path = [], None, None
        pieces = [Piece(start, start + size, args.name, 'next')]
        issues = [f'{cpu(start)}-{cpu(start + size)} overlaps source'
                  for _ in [0] if any(mask[rom_offset(a)] for a in range(start, start + size))]
        if labels_by_addr.get(start):
            issues.append(f'{cpu(start)} already has the label {labels_by_addr[start]}')
        print(f'{args.name}: one block of {size} bytes')
    else:
        table = Table(args.table, labels_by_name)
        end = int(args.end.lstrip('$').replace('/', ''), 16) if args.end else None
        pieces, issues = plan(table, args.type, args.name, rom, end, mask, labels_by_addr)
        distinct = len({v for *_, v in table.entries})
        print(f'{args.table}: {len(table.entries)} entries, {distinct} distinct targets')
    for run in runs(pieces):
        size = run[-1].end - run[0].start
        found = sum(1 for p in run if 'Unknown' in p.name)
        print(f'  {cpu(run[0].start)}-{cpu(run[-1].end)}: {len(run)} pieces, {size} bytes'
              + (f' ({found} found between targets)' if found else ''))
    for i in issues:
        print('  ! ' + i)
    if any('overlaps source' in i or 'not a valid' in i for i in issues):
        sys.exit('Not writing: fix the problems above first.')
    if not args.write:
        print('Dry run; --write applies it.')
        return
    n = write(table, pieces, args.type, args.name, args, labels_by_name)
    print(f'Wrote {len(pieces)} pieces; replaced {n} raw numbers in the source. Building...')
    res = subprocess.run(['./build.sh'], cwd=ROOT, capture_output=True, text=True)
    print((res.stdout + res.stderr).strip().split('\n')[-1])
    if res.returncode:
        sys.exit('The build differs: inspect with git diff, undo with git checkout.')


if __name__ == '__main__':
    main()
