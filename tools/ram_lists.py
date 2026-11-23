#!/usr/bin/env python3
"""Write the RAM write lists that rlBattleSceneWriteRAM reads as WRITE_RAM_* macros.

usage: tools/ram_lists.py [--write]

rlBattleSceneWriteRAM (bank $96) takes a long pointer in lR18 to a list of
entries: a word, the address (below $4000) with the type in bits 14-15, then
a byte (type 0), a word ($4000), an AND and an OR byte ($8000) or an AND and
an OR word ($C000). $FFFF ends the list. The macros are in
include/BattleAnimation.h.

The tool finds every call whose lR18 is loaded just before it, as labels
(lda #(`label)<<8 / lda #<>label) or as two raw halves (lda #$9500 /
lda #$EDD0), and decodes the list from fe4.sfc. Addresses that name a PPU
register buffer in WRAM.h (bBufferTM ...) are written by name.

- A list with a label whose data (up to the next label or section end) is
  exactly the list is rewritten in place.
- A list in bytes not built from source is written to wip/ram_lists.asm as
  aUnknownXXXXXX, for tools/test_routines.py and tools/place_routines.py, and
  the raw halves become the label.
Without --write it only reports. Run ./build.sh afterwards.
"""
import glob, os, re, sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from asmlib import read_rom, offset

CALL = re.compile(r'^\s+jsl rlBattleSceneWriteRAM\b')
HIGH = re.compile(r'^\s+lda #(?:\(`(\w+)\)<<8|\$([0-9A-F]{2})00)\s*$')
LOW = re.compile(r'^\s+lda #(?:<>(\w+)|\$([0-9A-F]{4}))\s*$')
LABEL = re.compile(r'^      ([a-z]\w+) ; ([0-9A-F]{2})/([0-9A-F]{4})')


def wram_names():
    """{address: name} for the direct page buffer registers in WRAM.h."""
    names = {}
    for line in open('include/WRAM.h', encoding='utf-8'):
        m = re.match(r'^\s+([bw]Buffer\w+)\s+\.(byte|word) \? ; \$0000([0-9A-F]{2})\b', line)
        if m:
            names[int(m.group(3), 16)] = m.group(1)
    return names


def decode(rom, addr):
    """[(type, address, operands)], length in bytes."""
    p = offset(addr)
    start, out = p, []
    while True:
        w = rom[p] | rom[p + 1] << 8
        if w == 0xFFFF:
            return out, p + 2 - start
        kind, a = w & 0xC000, w & 0x3FFF
        p += 2
        if kind == 0x0000:
            ops = (rom[p],); p += 1
        elif kind == 0x4000:
            ops = (rom[p] | rom[p + 1] << 8,); p += 2
        elif kind == 0x8000:
            ops = (rom[p], rom[p + 1]); p += 2
        else:
            ops = (rom[p] | rom[p + 1] << 8, rom[p + 2] | rom[p + 3] << 8); p += 4
        out.append((kind, a, ops))
        if p - start > 0x400:
            raise ValueError(f'${addr:06X}: no end within $400 bytes')


def render(entries, names):
    lines = []
    for kind, a, ops in entries:
        name = names.get(a, f'${a:04X}')
        if kind == 0x0000:
            lines.append(f'        WRITE_RAM_BYTE {name}, ${ops[0]:02X}')
        elif kind == 0x4000:
            lines.append(f'        WRITE_RAM_WORD {name}, ${ops[0]:04X}')
        elif kind == 0x8000:
            lines.append(f'        WRITE_RAM_MASK_BYTE {name}, ${ops[0]:02X}, ${ops[1]:02X}')
        else:
            lines.append(f'        WRITE_RAM_MASK_WORD {name}, ${ops[0]:04X}, ${ops[1]:04X}')
    lines.append('        WRITE_RAM_END')
    return lines


def labels():
    """{name: address} of top-level labels, from labels.txt."""
    out = {}
    for line in open('labels.txt', encoding='utf-8'):
        p = line.split()
        if len(p) == 3 and p[0] == 'al' and ':' not in p[2]:
            out[p[2].lstrip('.')] = int(p[1], 16)
    return out


def find_calls(files, known):
    """[(file, high line, low line, address, label or None)]"""
    out = []
    for f in files:
        lines = open(f, encoding='utf-8').read().split('\n')
        for i, l in enumerate(lines):
            if not CALL.match(l):
                continue
            hi = lo = None
            for j in range(i - 1, max(0, i - 7), -1):
                if hi is None and (m := HIGH.match(lines[j])):
                    hi = (j, m)
                if lo is None and (m := LOW.match(lines[j])):
                    lo = (j, m)
            if not (hi and lo):
                continue
            (hj, hm), (lj, lm) = hi, lo
            if lm.group(1):
                if lm.group(1) not in known:
                    continue
                out.append((f, hj, lj, known[lm.group(1)] | 0x800000, lm.group(1)))
            elif hm.group(2):
                addr = int(hm.group(2), 16) << 16 | int(lm.group(2), 16)
                out.append((f, hj, lj, addr, None))
    return out


def block_extent(lines, k):
    """Lines of the data that follows the label at line k: (first, end)."""
    e = k + 1
    while e < len(lines) and not LABEL.match(lines[e]) and not lines[e].strip().startswith('.endsection'):
        e += 1
    while e > k + 1 and not lines[e - 1].strip():
        e -= 1
    return k + 1, e


def built_size(block):
    n = 0
    for l in block:
        s = l.split(';')[0].strip()
        if s.startswith('.word'):
            n += 2 * len(s[5:].split(','))
        elif s.startswith('.byte'):
            n += len(s[5:].split(','))
        elif s.startswith('.long'):
            n += 3 * len(s[5:].split(','))
        elif s and not s.startswith('.'):
            return None
    return n


def main():
    write = '--write' in sys.argv
    rom, names = read_rom(), wram_names()
    known = labels()
    by_addr = {}
    for k, v in known.items():
        by_addr.setdefault(v | 0x800000, []).append(k)
    files = glob.glob('engine/**/*.asm', recursive=True)
    calls = find_calls(files, known)
    done, wip, raw, problems = set(), [], [], []
    edits = {}
    for f, hj, lj, addr, label in calls:
        entries, size = decode(rom, addr)
        name = label or next((n for n in by_addr.get(addr, []) if n.startswith('a')), None)
        if name is None:
            name = f'aUnknown{addr:06X}'
            if addr not in done:
                wip.append((addr, name, entries))
        else:
            if addr not in done:
                edits.setdefault(name, (addr, size, entries))
        if label is None:
            raw.append((f, hj, lj, name))
        done.add(addr)
    # In-place rewrites.
    rewritten = 0
    for f in files:
        lines = open(f, encoding='utf-8').read().split('\n')
        changed = False
        k = 0
        while k < len(lines):
            m = LABEL.match(lines[k])
            if m and m.group(1) in edits:
                addr, size, entries = edits[m.group(1)]
                first, end = block_extent(lines, k)
                body = lines[first:end]
                if any('WRITE_RAM_' in l for l in body):
                    k += 1; continue
                if built_size(body) != size:
                    problems.append(f'{f}:{k + 1} {m.group(1)}: the data is {built_size(body)} bytes, the list {size}')
                    k += 1; continue
                new = [''] + render(entries, names)
                lines[first:end] = new
                changed = True
                rewritten += 1
                k = first + len(new)
                continue
            k += 1
        if changed and write:
            open(f, 'w', encoding='utf-8').write('\n'.join(lines))
    # Raw halves become labels.
    if write:
        for f, hj, lj, name in raw:
            lines = open(f, encoding='utf-8').read().split('\n')
            lines[hj] = re.sub(r'#\$[0-9A-F]{2}00', f'#(`{name})<<8', lines[hj])
            lines[lj] = re.sub(r'#\$[0-9A-F]{4}', f'#<>{name}', lines[lj])
            open(f, 'w', encoding='utf-8').write('\n'.join(lines))
    if wip and write:
        with open('wip/ram_lists.asm', 'w', encoding='utf-8') as out:
            for addr, name, entries in sorted(wip):
                out.write(f'      {name} ; {addr >> 16:02X}/{addr & 0xFFFF:04X}\n\n')
                out.write('\n'.join(render(entries, names)) + '\n\n')
    print(f'{len(calls)} calls, {len(done)} lists: {rewritten} rewritten in place, {len(wip)} not built'
          f'{" (wip/ram_lists.asm)" if wip and write else ""}, {len(raw)} raw pointers')
    for p in problems:
        print('  ' + p)


if __name__ == '__main__':
    main()
