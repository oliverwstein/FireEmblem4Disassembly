#!/usr/bin/env python3
"""Find the compressed streams in the ROM and carve them into gfx/compressed/.

usage: tools/find_streams.py [--table LABEL ...] [--write]

A stream is data for rlDecompressor (tools/decompress.py). Starting points:

  - the source each call of rlAppendDecompList, rlDecompressSingle and
    rlHandleMapMenuDecompressionDMA loads (as two halves, before the call);
  - the Source of every .structDecompressionDMAEntry;
  - every value of the pointer tables named with --table (runs of .long);
  - every stream already listed in a gfx/**/*.streams file.

Starts that decompress cleanly and are not built from source are sorted by
address within each kind of bank half (streams run on from the end of a half
into the same half of the next bank). Two neighbouring starts belong to one
region if the streams after the first one, decoded end to end, land exactly on
the second; those in between are found streams. After a region's last start
the tool goes on the same way while the bytes decode as a stream whose output
is a whole number of 32-byte tiles, stopping at built bytes or the next region.
A start that falls inside another stream is reported, not used.

Without --write it reports the regions. With it, each region becomes
gfx/compressed/ADDR/ (the CPU address of its start): the streams as NAME.comp
(the ROM's bytes) and ADDR.streams for tools/stream_layout.py, which build.sh
turns into Layout.asm. A stream keeps the label it has; others are named
gcUnknownADDR (format not identified: graphics or a tilemap). The tool removes
the ROM[...] slices and the earlier .streams folders that the regions replace,
adds the includes to build.asm, and builds. Comment lines just before a label in
an earlier .streams file are kept.

Pointers to the streams in the source still have to be written as labels
(tools/carve.py's raw-number pass, and two-halves loads).
"""
import argparse
import glob
import os
import re
import shutil
import subprocess
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from decompress import decompress, rom_offset, DecompressionError

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
CALLS = {'rlAppendDecompList': 'lR18', 'rlDecompressSingle': 'lR45',
         'rlHandleMapMenuDecompressionDMA': 'lR19'}
KEEP = ('gfx/portraits', 'gfx/MapMovementSprites')      # carved with PNGs already


def load_labels():
    by_name, by_addr = {}, {}
    for line in open(os.path.join(ROOT, 'labels.txt')):
        p = line.split()
        if len(p) == 3 and ':' not in p[2]:
            by_name[p[2].lstrip('.')] = int(p[1], 16)
            by_addr.setdefault(int(p[1], 16), p[2].lstrip('.'))
    return by_name, by_addr


def resolve(expr, labels):
    expr = expr.strip()
    if m := re.fullmatch(r'\$([0-9A-Fa-f]+)', expr):
        return int(m.group(1), 16)
    if (m := re.fullmatch(r'\(`(\w+)\)<<8', expr)) and m.group(1) in labels:
        return (labels[m.group(1)] >> 16) << 8
    if (m := re.fullmatch(r'<>(\w+)', expr)) and m.group(1) in labels:
        return labels[m.group(1)] & 0xFFFF
    if (m := re.fullmatch(r'`(\w+)', expr)) and m.group(1) in labels:
        return labels[m.group(1)] >> 16
    return None


def seeds(rom, labels, tables):
    out = set()
    files = glob.glob(os.path.join(ROOT, 'engine', '**', '*.asm'), recursive=True) + \
        glob.glob(os.path.join(ROOT, 'events', '**', '*.asm'), recursive=True)
    for f in files:
        lines = open(f, encoding='utf-8').read().split('\n')
        for i, line in enumerate(lines):
            if m := re.match(r'\s*\.structDecompressionDMAEntry\s+([^,]+)', line):
                v = labels.get(m.group(1).strip()) or resolve(m.group(1), labels)
                if v:
                    out.add(v)
            m = re.match(r'\s*jsl (\w+)', line)
            if not m:
                continue
            if m.group(1) == 'rlDecompressor':
                hi = lo = None
                for j in range(i - 1, max(0, i - 14), -1):
                    if re.match(r'\s*(jsl|jml|rtl|rts)\b', lines[j]):
                        break
                    ms_lo = re.match(r'\s*stx (?:DecompressionVariables(?:\.lSource)?|\$C8)\b', lines[j].split(';')[0])
                    ml_lo = re.match(r'\s*ldx #(.+)$', lines[j - 1].split(';')[0].rstrip()) if ms_lo else None
                    if ml_lo and lo is None:
                        lo = resolve(ml_lo.group(1), labels)
                    ms_hi = re.match(r'\s*sta (?:DecompressionVariables\.lSource\+2|\$CA)\b', lines[j].split(';')[0])
                    ml_hi = re.match(r'\s*lda #(.+)$', lines[j - 1].split(';')[0].rstrip()) if ms_hi else None
                    if ml_hi and hi is None:
                        hi = resolve(ml_hi.group(1), labels)
                if hi is not None and lo is not None:
                    out.add((hi << 16) | lo)
                continue
            if m.group(1) not in CALLS:
                continue
            reg, hi, lo = CALLS[m.group(1)], None, None
            for j in range(i - 1, max(0, i - 14), -1):
                if re.match(r'\s*(jsl|jml|rtl|rts)\b', lines[j]):
                    break
                ms = re.match(rf'\s*sta {reg}(\+1)?\s*$', lines[j].split(';')[0])
                ml = re.match(r'\s*lda #(.+)$', lines[j - 1].split(';')[0].rstrip()) if ms else None
                if ml:
                    v = resolve(ml.group(1), labels)
                    if ms.group(1) and hi is None:
                        hi = v
                    elif not ms.group(1) and lo is None:
                        lo = v
            if hi is not None and lo is not None:
                a = (hi >> 8) << 16 | lo
                if reg == 'lR19':                      # an entry: its source, if compressed
                    o = rom_offset(a)
                    if o is not None and rom[o + 4]:
                        out.add(rom[o + 5] | rom[o + 6] << 8 | rom[o + 7] << 16)
                else:
                    out.add(a)
    for table in tables:
        hits = [f for f in files if re.search(rf'^\s*{table}\b', open(f, encoding='utf-8').read(), re.M)]
        if len(hits) != 1:
            sys.exit(f'--table {table}: found in {len(hits)} files')
        text = open(hits[0], encoding='utf-8').read()
        body = text[re.search(rf'^\s*{table}\b', text, re.M).end():]
        if end_m := re.search(r'\n\s*\.endsection\b', body):
            body = body[:end_m.start()]
        for m in re.finditer(r'^\s*\.long\s+([^\n;]+)', body, re.M):
            for v in m.group(1).split(','):
                v = v.strip()
                out.add(labels[v] if v in labels else resolve(v, labels))
        out.discard(None)
    for path in glob.glob(os.path.join(ROOT, 'gfx', '**', '*.streams'), recursive=True):
        if path.startswith(tuple(os.path.join(ROOT, k) for k in KEEP)):
            continue
        for line in open(path):
            if (m := re.match(r'(\w+) \w+', line)) and m.group(1) in labels:
                out.add(labels[m.group(1)])
    return out


def lin(a):
    """Order within a kind of half: (half, position counting halves of that kind)."""
    return (a & 0x8000, (a >> 16) << 15 | (a & 0x7FFF))


def main():
    ap = argparse.ArgumentParser(description=__doc__.split('\n')[0])
    ap.add_argument('--table', action='append', default=[])
    ap.add_argument('--write', action='store_true')
    args = ap.parse_args()
    from trace import coverage_mask
    rom = open(os.path.join(ROOT, 'fe4.sfc'), 'rb').read()
    labels, by_addr = load_labels()
    print('Measuring what is built from source...')
    mask = coverage_mask()
    carved = {}                                   # streams in folders this tool replaces
    for path in glob.glob(os.path.join(ROOT, 'gfx', '**', '*.streams'), recursive=True):
        if not path.startswith(tuple(os.path.join(ROOT, k) for k in KEEP)):
            for line in open(path):
                if (m := re.match(r'(\w+) \w+', line)) and m.group(1) in labels:
                    carved[labels[m.group(1)]] = path

    def raw(a):                                   # not source (or carved by an earlier run)
        o = rom_offset(a)
        return o is not None and (not mask[o] or a in carved)

    cache = {}

    def stream(a):
        if a not in cache:
            cache[a] = None
            if raw(a):
                try:
                    data, end = decompress(rom, a)
                    if data and len(data) <= 0x10000:
                        cache[a] = (len(data), end)
                except DecompressionError:
                    pass
        return cache[a]

    def step(a):                                  # where the next stream starts:
        return a                                  # decompress() already wraps the end
                                                  # into the next bank's same half

    starts = sorted((a for a in seeds(rom, labels, args.table) if stream(a)), key=lin)
    regions, notes = [], []
    cur = None
    for s in starts:
        if cur and lin(s) < lin(cur[-1][1]):
            if s not in [x[0] for x in cur]:
                notes.append(f'${s:06X} falls inside a stream ({cur[-1][0]:06X}-{cur[-1][1]:06X}); not used')
            continue
        if cur and lin(s)[0] == lin(cur[-1][1])[0]:
            a, chain = step(cur[-1][1]), []
            while lin(a) < lin(s) and len(chain) < 200:
                st = stream(a)
                if not st or lin(st[1]) > lin(s):
                    break
                chain.append((a, st[1], 'found'))
                a = step(st[1])
            if a == s:
                cur += chain + [(s, stream(s)[1], 'seed')]
                continue
        if cur:
            regions.append(cur)
        cur = [(s, stream(s)[1], 'seed')]
    if cur:
        regions.append(cur)
    # Go on past each region's last start.
    region_starts = sorted(lin(r[0][0]) for r in regions)
    for r in regions:
        a = step(r[-1][1])
        while True:
            nxt = next((x for x in region_starts if x > lin(r[0][0])), None)
            if nxt is not None and lin(a) >= nxt:
                break
            st = stream(a)
            if not st or st[0] % 32 or (nxt is not None and lin(st[1]) > nxt):
                break
            if not raw(st[1] - 1):
                break
            r.append((a, st[1], 'after'))
            a = step(st[1])

    total = sum(len(r) for r in regions)
    print(f'{len(starts)} starting points; {len(regions)} regions, {total} streams')
    for r in regions:
        kinds = {k: sum(1 for x in r if x[2] == k) for k in ('seed', 'found', 'after')}
        print(f'  ${r[0][0]:06X}-${r[-1][1]:06X}: {len(r)} streams ({kinds["seed"]} known, '
              f'{kinds["found"]} between them, {kinds["after"]} after)')
    for n in notes:
        print('  ! ' + n)
    if not args.write:
        print('Dry run; --write carves them.')
        return
    write(rom, regions, by_addr, carved)
    res = subprocess.run(['./build.sh'], cwd=ROOT, capture_output=True, text=True)
    if not res.returncode:
        n, pairs = name_references()
        print(f'Wrote {n} raw numbers and {pairs} two-halves loads of the streams as labels.')
        res = subprocess.run(['./build.sh'], cwd=ROOT, capture_output=True, text=True)
    print((res.stdout + res.stderr).strip().split('\n')[-1])
    if res.returncode:
        sys.exit('The build differs: inspect with git diff, undo with git checkout and git clean.')


def name_references():
    """Write numbers in the source that are a carved stream's address as its label:
    six-digit numbers (tools/carve.py's pass) and long pointers loaded in two
    halves (lda #$BB00 / sta X+1 and lda #$LLLL / sta X)."""
    import carve
    labels, _ = load_labels()
    streams = {}
    for path in glob.glob(os.path.join(ROOT, 'gfx', '**', '*.streams'), recursive=True):
        for line in open(path):
            if (m := re.match(r'(\w+) \w+', line)) and m.group(1) in labels:
                streams[labels[m.group(1)]] = m.group(1)
    n = carve.replace_raw_numbers(sorted((a, a + 1, l) for a, l in streams.items()))
    pairs = 0
    files = glob.glob(os.path.join(ROOT, 'engine', '**', '*.asm'), recursive=True) + \
        glob.glob(os.path.join(ROOT, 'events', '**', '*.asm'), recursive=True)
    for f in files:
        lines = open(f, encoding='utf-8').read().split('\n')
        changed = False
        for i in range(len(lines) - 1):
            mh = re.match(r'(\s*)lda #\$([0-9A-F]{2})00\s*$', lines[i])
            ms = re.match(r'\s*sta (\w+)\+1\s*$', lines[i + 1])
            if not (mh and ms):
                continue
            for j in range(max(0, i - 6), min(len(lines) - 1, i + 8)):
                ml = re.match(r'(\s*)lda #\$([0-9A-F]{4})\s*$', lines[j])
                if j != i and ml and re.match(rf'\s*sta {ms.group(1)}\s*$', lines[j + 1]):
                    full = int(mh.group(2), 16) << 16 | int(ml.group(2), 16)
                    if full in streams:
                        lines[i] = f'{mh.group(1)}lda #(`{streams[full]})<<8'
                        lines[j] = f'{ml.group(1)}lda #<>{streams[full]}'
                        pairs += 1
                        changed = True
                    break
        for i, line in enumerate(lines):
            if not re.match(r'\s*jsl rlDecompressor\b', line):
                continue
            hi_i = lo_i = hi_val = lo_val = None
            for j in range(i - 1, max(0, i - 14), -1):
                if re.match(r'\s*(jsl|jml|rtl|rts)\b', lines[j]):
                    break
                if re.match(r'\s*stx (?:DecompressionVariables(?:\.lSource)?|\$C8)\b', lines[j].split(';')[0]):
                    if (ml := re.match(r'(\s*)ldx #\$([0-9A-F]{4})\s*$', lines[j - 1])) and lo_i is None:
                        lo_i, lo_val = j - 1, int(ml.group(2), 16)
                if re.match(r'\s*sta (?:DecompressionVariables\.lSource\+2|\$CA)\b', lines[j].split(';')[0]):
                    if (mh := re.match(r'(\s*)lda #\$([0-9A-F]{2})\s*$', lines[j - 1])) and hi_i is None:
                        hi_i, hi_val = j - 1, int(mh.group(2), 16)
            if hi_i is not None and lo_i is not None:
                full = hi_val << 16 | lo_val
                if full in streams:
                    lines[hi_i] = re.sub(r'\$\w+', f'`{streams[full]}', lines[hi_i])
                    lines[lo_i] = re.sub(r'\$\w+', f'<>{streams[full]}', lines[lo_i])
                    pairs += 1
                    changed = True
        if changed:
            open(f, 'w', encoding='utf-8').write('\n'.join(lines))
    return n, pairs


def stream_bytes(rom, a, end):
    out, s = bytearray(), a
    while s != end:
        half_end = (s & 0xFF0000) + (s & 0x8000) + 0x8000
        e = end if (end & 0xFF0000) == (s & 0xFF0000) and end <= half_end else half_end
        out += rom[rom_offset(s):rom_offset(e - 1) + 1]
        if e == end:
            break
        s = (s & 0xFF0000) + 0x10000 + (s & 0x8000)
    return bytes(out)


def write(rom, regions, by_addr, carved):
    # Keep comment lines from earlier .streams files, by label.
    notes = {}
    for path in set(carved.values()):
        pending = []
        for line in open(path):
            if line.startswith('#') and not line.startswith('# Compressed streams') and \
                    not line.startswith(('# start to end', '# it; gcUnknown')):
                pending.append(line.rstrip('\n'))
            elif m := re.match(r'(\w+) \w+', line):
                if pending:
                    notes[m.group(1)] = pending
                pending = []
            elif not line.strip():
                pending = []
    # A region that an earlier .streams file already lists as it is (same start,
    # end and labels in order) keeps its folder untouched: PNGs, names and notes.
    def listed(path):
        text = open(path).read()
        return (re.search(r'^start \$(\w+)', text, re.M).group(1), re.search(r'^end \$(\w+)', text, re.M).group(1),
                re.findall(r'^(\w+) \w+', text, re.M))
    def label_of(a):
        label = by_addr.get(a) or f'gcUnknown{a:06X}'
        return f'gcUnknown{a:06X}' if label.startswith('aUnknown') and label != f'aUnknown{a:06X}' else label
    unchanged = {}
    for path in set(carved.values()):
        start, end, labels = listed(path)
        for r in regions:
            if (f'{r[0][0]:06X}', f'{r[-1][1]:06X}', [label_of(a) for a, *_ in r]) == (start, end, labels):
                unchanged[id(r)] = path
    regions = [r for r in regions if id(r) not in unchanged]
    if unchanged:
        print(f'Unchanged, left as they are: {", ".join(sorted(os.path.relpath(p, ROOT) for p in unchanged.values()))}')
    old_dirs = {os.path.dirname(p) for p in carved.values()} - {os.path.dirname(p) for p in unchanged.values()}
    preserved = {}
    PRESERVE_EXTS = ('.4bpp.png', '.4bpp.comp', '.2bpp.png', '.2bpp.comp', '.bin', '.bin.comp')
    for d in old_dirs:
        for fname in os.listdir(d):
            for ext in PRESERVE_EXTS:
                if fname.endswith(ext):
                    lbl = fname[:-len(ext)]
                    preserved.setdefault(lbl, []).append((ext, open(os.path.join(d, fname), 'rb').read()))
                    break
    for d in old_dirs:
        shutil.rmtree(d)
    build = open(os.path.join(ROOT, 'build.asm'), encoding='utf-8').read()
    for d in old_dirs:
        rel = os.path.relpath(d, ROOT)
        build = re.sub(rf'\n    ; Compressed streams: generated from {re.escape(rel)}/[^\n]*\n'
                       rf'    \.include "{re.escape(rel)}/Layout\.asm"\n\n?', '\n', build)
    starts = {}
    for r in regions:
        top = f'{r[0][0]:06X}'
        folder = os.path.join(ROOT, 'gfx', 'compressed', top)
        os.makedirs(folder, exist_ok=True)
        lines = ['# Compressed streams for rlDecompressor, placed in this order from start to',
                 '# end (tools/stream_layout.py), found by tools/find_streams.py. NAME.comp is',
                 '# the stream as the ROM has it; gcUnknown... are not identified yet (graphics',
                 '# or tilemaps).', f'start ${r[0][0]:06X}', f'end ${r[-1][1]:06X}', '']
        for a, end, kind in r:
            label = by_addr.get(a) or f'gcUnknown{a:06X}'
            if label.startswith('aUnknown') and label != f'aUnknown{a:06X}':
                label = f'gcUnknown{a:06X}'
            data, _ = decompress(rom, a)
            if label in preserved and any(ext.endswith('.comp') for ext, _ in preserved[label]):
                for ext, raw_bytes in preserved[label]:
                    open(os.path.join(folder, label + ext), 'wb').write(raw_bytes)
            else:
                open(os.path.join(folder, label + '.comp'), 'wb').write(stream_bytes(rom, a, end))
            lines += notes.get(label, [])
            lines.append(f'{label} {label} ; {len(data)} bytes decompressed'
                         + ('' if kind == 'seed' else f', {kind}'))
            starts[rom_offset(a)] = label
        open(os.path.join(folder, top + '.streams'), 'w').write('\n'.join(lines) + '\n')
    # build.asm: drop the slices the streams replace, then empty blocks; add includes.
    b = build.split('\n')
    b = [l for l in b if not ((m := re.search(r'ROM\[\$([0-9A-F]+):\$([0-9A-F]+)\]', l))
                              and int(m.group(1), 16) in starts)]
    out, i = [], 0
    while i < len(b):
        if re.match(r'\s*\* = \$', b[i]):
            j = i
            while not re.match(r'\s*\.here\b', b[j]):
                j += 1
            if not [l for l in b[i + 2:j] if l.strip() and not l.strip().startswith(';')]:
                i = j + 1
                if i < len(b) and not b[i].strip():
                    i += 1
                continue
        out.append(b[i])
        i += 1
    b = out
    blocks = [(i, int(m.group(1), 16)) for i, l in enumerate(b)
              if (m := re.match(r'\s*\* = \$([0-9A-Fa-f]+)', l))]
    for r in sorted(regions, key=lambda r: -rom_offset(r[0][0])):
        off, top = rom_offset(r[0][0]), f'{r[0][0]:06X}'
        at = min((x for x in blocks if x[1] > off), key=lambda x: x[1], default=(len(b), 0))[0]
        b[at:at] = [f'    ; Compressed streams: generated from gfx/compressed/{top}/{top}.streams by build.sh.',
                    f'    .include "gfx/compressed/{top}/Layout.asm"', '']
    open(os.path.join(ROOT, 'build.asm'), 'w', encoding='utf-8').write('\n'.join(b))


if __name__ == '__main__':
    main()
