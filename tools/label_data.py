#!/usr/bin/env python3
"""Put labels at addresses inside built data blocks.

usage: tools/label_data.py ADDR[=NAME] ... [--from-code-pointers]

Each ADDR (CPU address, e.g. 97AD24) must fall inside a labelled data block of
.byte rows (the rows a disassembly leaves for data it does not know). The row
that holds ADDR is split there and a top-level label is inserted, NAME or
aUnknownXXXXXX, with its address comment:

        .byte $01, $02, $03, $04          .byte $01, $02
                                    ->
                                        aUnknown97AD24 ; 97/AD24

                                          .byte $03, $04

Local labels (_XXXX) inside the block are passed over; an address that has one
is reported, to be written Parent._XXXX by hand. Addresses of the block's
.word or .long rows are only accepted at the start of
an item. --from-code-pointers takes the addresses from tools/code_pointers.py's
"No label at the address" list (two-halves pointers into data); run
tools/code_pointers.py --write and ./build.sh afterwards. Without labels.txt
from a current build the addresses cannot be found: run ./build.sh first.
"""
import glob, os, re, subprocess, sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

LABEL = re.compile(r'^      ([a-z]\w+) ; ([0-9A-F]{2})/([0-9A-F]{4})\s*$')
ROW = re.compile(r'^(\s+)\.(byte|word|long) (.*?)\s*(;.*)?$')
SIZE = {'byte': 1, 'word': 2, 'long': 3}


def blocks():
    """[(file, label line, start address)] of every top-level label in engine/ and data/."""
    out = []
    for f in glob.glob('engine/**/*.asm', recursive=True) + glob.glob('data/**/*.asm', recursive=True):
        for i, l in enumerate(open(f, encoding='utf-8').read().split('\n')):
            m = LABEL.match(l)
            if m:
                out.append((f, i, int(m.group(2) + m.group(3), 16)))
    return out


def insert(addr, name, index):
    cands = [b for b in index if b[2] <= addr and b[2] >> 16 == addr >> 16]
    if not cands:
        return f'${addr:06X}: no label before it'
    f, k, start = max(cands, key=lambda b: b[2])
    lines = open(f, encoding='utf-8').read().split('\n')
    a = start
    for j in range(k + 1, len(lines)):
        l = lines[j]
        if LABEL.match(l) or l.strip().startswith('.endsection'):
            return f'${addr:06X}: past the end of the data after {LABEL.match(lines[k]).group(1)}'
        loc = re.match(r'^      (_\w+) ; ([0-9A-F]{2})/([0-9A-F]{4})\s*$', l)
        if loc:
            if int(loc.group(2) + loc.group(3), 16) == addr:
                return f'${addr:06X}: the local label {LABEL.match(lines[k]).group(1)}.{loc.group(1)} is there'
            continue
        m = ROW.match(l)
        if not m:
            if l.strip() and not l.strip().startswith(';'):
                return f'${addr:06X}: {f}:{j + 1} is not a data row ({l.strip()})'
            continue
        items = [x.strip() for x in m.group(3).split(',')]
        size = SIZE[m.group(2)]
        if a + size * len(items) <= addr:
            a += size * len(items)
            continue
        off = addr - a
        if off % size:
            return f'${addr:06X}: inside a .{m.group(2)} item ({f}:{j + 1})'
        n = off // size
        indent, kind = m.group(1), m.group(2)
        new = []
        if n:
            new += [f'{indent}.{kind} ' + ', '.join(items[:n]), '']
        new += [f'      {name} ; {addr >> 16:02X}/{addr & 0xFFFF:04X}', '']
        new += [f'{indent}.{kind} ' + ', '.join(items[n:])]
        lines[j:j + 1] = new
        open(f, 'w', encoding='utf-8').write('\n'.join(lines))
        return None
    return f'${addr:06X}: end of file'


def from_code_pointers():
    out = subprocess.run([sys.executable, 'tools/code_pointers.py'], capture_output=True, text=True).stdout
    part = out.split('No label at the address:', 1)[-1]
    addrs = set()
    for m in re.finditer(r'\$([0-9A-F]{6}) \(inside or after (a\w+)\+', part):
        addrs.add(int(m.group(1), 16))
    return sorted(addrs)


def main():
    args = [a for a in sys.argv[1:] if not a.startswith('--')]
    todo = [(int(a.split('=')[0], 16), a.split('=')[1] if '=' in a else None) for a in args]
    if '--from-code-pointers' in sys.argv:
        todo += [(a, None) for a in from_code_pointers()]
    if not todo:
        raise SystemExit(__doc__)
    done = 0
    for addr, name in sorted(set(todo), reverse=True):
        err = insert(addr, name or f'aUnknown{addr:06X}', blocks())
        if err:
            print(err)
        else:
            done += 1
    print(f'{done} labels inserted')


if __name__ == '__main__':
    main()
