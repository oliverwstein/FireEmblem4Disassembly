#!/usr/bin/env python3
"""Write raw ROM addresses in the source as labels.

usage: tools/raw_addresses.py [--write] [--list]

Finds six-digit numbers in engine/ and events/ that are ROM addresses (in
operands, data and macro arguments, with or without #<>, #(`...)<<8 and the
like) and resolves each against the current build (labels.txt and a 64tass
listing):

  label    a label is at that address: the label, or routine._XXXX for a local
           label (64tass reaches a routine's _XXXX labels that way);
  entry    the address starts an instruction that has no label: a local label
           _XXXX is added before that instruction and the number becomes
           routine._XXXX (an entry point, so it must not be label+N, which
           would break when the routine changes);
  offset   the address is inside built data, or inside an instruction: the
           nearest label before it, plus N, if no other label and no unbuilt
           byte lies between them; or, for an indexed read 1-4 bytes before a
           built data label (a table indexed from 1 or 2), that label minus N;
  left     anything else, reported: unbuilt bytes, an address whose label is
           in the other ROM mirror ($80-$BF against $C0-$FF), or code whose
           routine cannot be told.

Without --write it reports counts (--list shows every number). With --write it
edits the files and builds; the build must still match the ROM.
"""
import argparse
import bisect
import collections
import glob
import os
import re
import subprocess
import sys
import tempfile

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from decompress import rom_offset
import asmlib

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
NUMBER = re.compile(r'(?<![\w$])\$([0-9A-Fa-f]{6})\b')
TOP_LABEL = re.compile(r'^ {4,6}([A-Za-z]\w*)\b')
LOCAL_LABEL = re.compile(r'^\s+(_[0-9A-Fa-f]{4})\s*(?:;.*)?$')


def listing():
    """{(file, line): (address, is_instruction, text)} for every line that emits bytes or is a label."""
    with tempfile.TemporaryDirectory() as tmp:
        path = os.path.join(tmp, 'list.txt')
        ok, log = asmlib.assemble(ROOT, os.path.join(tmp, 'out.sfc'), ('-L', path, '--line-numbers'))
        if not ok:
            sys.exit('build failed:\n' + '\n'.join(asmlib.errors(log)[:10]))
        text = open(path, encoding='utf-8', errors='replace').read().split('\n')
    files, out = {}, {}
    current = None
    for line in text:
        if m := re.match(r'^:(\d+)\t;\*{6}  (?:Processing (?:input )?file|Return to file): (.*)$', line):
            files[m.group(1)] = m.group(2)
            current = m.group(2)
            continue
        if m := re.match(r'^:(\d+)\t', line):
            current = files.get(m.group(1), current)
            continue
        f = line.split('\t')
        if len(f) >= 6 and re.fullmatch(r'\d+', f[0]) and re.fullmatch(r'[0-9a-f]{6}', f[2]):
            out[(current, int(f[0]))] = (int(f[2], 16), f[1].startswith('.') and bool(f[3]) and any(f[4:-1]), f[-1])
    return out


def load_labels():
    """({address: name} for global labels, {address: routine._XXXX} for local ones)."""
    glob_l, loc_l = {}, {}
    for line in open(os.path.join(ROOT, 'labels.txt')):
        p = line.split()
        if len(p) != 3:
            continue
        a, name = int(p[1], 16), p[2].lstrip('.')
        if ':' not in name:
            glob_l.setdefault(a, name)
        elif re.fullmatch(r'\w+:_\w+', name):
            loc_l.setdefault(a, name.replace(':', '.'))
    return glob_l, loc_l


def main():
    ap = argparse.ArgumentParser(description=__doc__.split('\n')[0],
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument('--write', action='store_true')
    ap.add_argument('--list', action='store_true')
    args = ap.parse_args()
    print('Measuring what is built from source...')
    mask = asmlib.source_map()
    lst = listing()
    glob_l, loc_l = load_labels()
    labels = {**loc_l, **glob_l}                     # globals win at the same address
    starts = sorted(labels)
    glob_starts = sorted(glob_l)
    instr = {}                                       # address -> (file, line) of an instruction
    cache = {}
    for (f, n), (a, is_instr, text) in lst.items():
        if is_instr and f and f.startswith(('engine/', 'events/')):
            lines = open(os.path.join(ROOT, f), encoding='utf-8').read().split('\n') if f not in cache else cache[f]
            cache[f] = lines
            if n <= len(lines) and lines[n - 1].strip() == text.strip():   # not a macro's line
                instr.setdefault(a, (f, n))

    def routine_of(f, n):
        """The top-level label in effect at line n of f (1-based), or None."""
        lines = source[f]
        for k in range(n - 1, -1, -1):
            if m := TOP_LABEL.match(lines[k]):
                if not re.match(r'\s*\.', lines[k]) and m.group(1) not in ('_',):
                    return m.group(1)
        return None

    source = {}
    files = sorted(glob.glob(os.path.join('engine', '**', '*.asm'), recursive=True, root_dir=ROOT)
                   + glob.glob(os.path.join('events', '**', '*.asm'), recursive=True, root_dir=ROOT))
    for f in files:
        source[f] = open(os.path.join(ROOT, f), encoding='utf-8').read().split('\n')

    found = []                                       # (file, line index, start, end, value, kind, text)
    new_locals = {}                                  # (file, line index) -> local name
    reasons = collections.Counter()
    for f in files:
        for i, line in enumerate(source[f]):
            code = line.split(';')[0]
            if re.match(r'\s*\.(logical|fill|text|virtual)\b', code) or not code.strip():
                continue
            for m in NUMBER.finditer(code):
                v = int(m.group(1), 16)
                o = rom_offset(v)
                if o is None:
                    continue
                kind, text = None, None
                if v in labels:
                    kind, text = 'label', labels[v]
                elif v in instr:
                    tf, tn = instr[v]
                    r = routine_of(tf, tn)
                    g = bisect.bisect_right(glob_starts, v) - 1
                    if r and g >= 0 and glob_l[glob_starts[g]] == r:
                        kind, text = 'entry', f'{r}._{v & 0xFFFF:04X}'
                        new_locals[(tf, tn - 1)] = f'_{v & 0xFFFF:04X}'
                    else:
                        reasons['code whose routine cannot be told'] += 1
                if kind is None and mask[o]:
                    k = bisect.bisect_right(starts, v) - 1
                    if k >= 0:
                        base = starts[k]
                        bo = rom_offset(base)
                        if bo is not None and base >> 16 == v >> 16 and v - base < 0x1000 and all(mask[bo:o + 1]):
                            kind, text = 'offset', f'{labels[base]}+{v - base}'
                if kind is None:                     # just before a table: an index that starts at 1-4
                    after = [d for d in range(1, 5) if v + d in labels and labels[v + d][0] in 'ag'
                             and rom_offset(v + d) is not None and mask[rom_offset(v + d)]]
                    if after and code.split()[0].startswith(('ld', 'cmp', 'adc', 'sbc', 'and', 'ora', 'eor')) \
                            and ',' in code[m.end(1):]:
                        kind, text = 'offset', f'{labels[v + after[0]]}-{after[0]}'
                if kind is None:
                    other = v ^ 0x400000 if v >> 16 >= 0x80 else None
                    if not mask[o]:
                        reasons['not built'] += 1
                    elif other in labels:
                        reasons['label in the other mirror'] += 1
                    else:
                        reasons['no label near it'] += 1
                    if args.list:
                        print(f'  left    {f}:{i + 1}: {code.strip()}')
                    continue
                found.append((f, i, m.start(1) - 1, m.end(1), v, kind, text))
                if args.list:
                    print(f'  {kind:7} {f}:{i + 1}: {code.strip()}  ->  {text}')
    counts = collections.Counter(k for *_, k, _ in found)
    print(', '.join(f'{counts[k]} {k}' for k in ('label', 'entry', 'offset')) +
          f'; {len(new_locals)} local labels to add')
    print('Left: ' + ', '.join(f'{n} {r}' for r, n in reasons.most_common()))
    if not args.write:
        print('Dry run; --write applies them.')
        return

    by_file = collections.defaultdict(list)
    for f, i, s, e, _, _, text in found:
        by_file[f].append((i, s, e, text))
    for (f, i), name in new_locals.items():
        by_file.setdefault(f, [])
    for f, edits in by_file.items():
        lines = source[f]
        for i, s, e, text in sorted(edits, key=lambda t: (t[0], -t[1])):
            lines[i] = lines[i][:s] + text + lines[i][e:]
        for (lf, li), name in sorted(new_locals.items(), key=lambda t: -t[0][1]):
            if lf != f:
                continue
            k = li - 1
            while k >= 0 and not lines[k].strip():
                k -= 1
            if k >= 0 and LOCAL_LABEL.match(lines[k]) and LOCAL_LABEL.match(lines[k]).group(1) == name:
                continue
            indent = re.match(r'\s*', lines[li]).group(0)
            lines[li:li] = ['', f'{indent}{name}'] if lines[li - 1].strip() else [f'{indent}{name}']
        open(os.path.join(ROOT, f), 'w', encoding='utf-8').write('\n'.join(lines))
    print(f'Wrote {len(found)} numbers as labels in {len(by_file)} files.')
    sys.exit(subprocess.call(['./build.sh'], cwd=ROOT))


if __name__ == '__main__':
    main()
