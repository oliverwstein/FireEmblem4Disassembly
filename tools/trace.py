#!/usr/bin/env python3
"""Find code that is not disassembled yet by following calls and jumps from built code.

usage: tools/trace.py [--bank XX] [--write FILE] [--list]

Starting from every routine already in the build, this follows jsr, jsl, jmp and jml
to addresses that still come from the base ROM, disassembles what it finds there
(with tools/disasm.py), and follows the calls in that code too. Since everything it
finds is reached from verified code, it is code rather than data misread as code.
Register widths at each new routine are the caller's widths at the call.

It prints a summary per bank. --list prints every routine found, with its size,
starting widths, a caller, and warnings:
  stack-args   reads bytes after its return address (inline arguments), so code
               after calls to it may be misread until INLINE_ARGS in disasm.py
               lists it
  odd-opcode   contains brk, cop, wdm, stp or xce, which usually means data
  mid-branch   branches into the middle of one of its own instructions
  widths       called with different register widths from different places

--write FILE writes the routines found (optionally only in --bank) to FILE as a
routines file for tools/test_routines.py and tools/place_routines.py.
"""
import argparse, collections, glob, os, re, sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from asmlib import read_rom, offset, repo_copy, assemble
from disasm import Disassembler, load_labels

ODD = {'brk', 'cop', 'wdm', 'stp', 'xce'}


def coverage_mask():
    """bytearray with 1 for each ROM byte built from source (same method as build.sh)."""
    builds = []
    with repo_copy() as root:
        for fill in (0x00, 0xFF):
            open(os.path.join(root, 'fe4.sfc'), 'wb').write(bytes([fill]) * 0x400000)
            ok, log = assemble(root, out=f'fill{fill:02X}.sfc')
            if not ok:
                raise SystemExit('the build failed:\n' + log[-2000:])
            builds.append(open(os.path.join(root, f'fill{fill:02X}.sfc'), 'rb').read())
    a, b = builds
    return bytearray(x == y for x, y in zip(a, b))


def built_routines():
    """[(address, name, m8, x8)] for routines in the build, with their starting widths."""
    out = []
    for f in glob.glob('engine/**/*.asm', recursive=True):
        lines = open(f, encoding='utf-8').read().split('\n')
        for i, l in enumerate(lines):
            m = re.match(r'^ {6}(r[ls]\w+) ; ([0-9A-F]{2})/([0-9A-F]{4})\s*$', l)
            if m:
                head = ' '.join(lines[i + 1:i + 6])
                out.append((int(m.group(2) + m.group(3), 16), m.group(1), '.as' in head, '.xs' in head))
    return sorted(out)


def is_rom_code_address(a):
    bank, addr = a >> 16, a & 0xFFFF
    if 0x80 <= bank <= 0xBF:
        return addr >= 0x8000
    return 0xC0 <= bank <= 0xFF


def calls(insns):
    """(target, m8, x8, kind) for each call or jump to a fixed address."""
    for ins in insns:
        if ins['mn'] in ('jsr', 'jsl', 'jmp', 'jml') and ins['mode'] in ('absj', 'abslj'):
            yield ins['target'], ins['m8'], ins['x8'], ins['mn'], ins['pc']


def warnings(insns, disasm, start):
    w = []
    if any(i['mn'] in ODD for i in insns):
        w.append('odd-opcode')
    starts = {i['pc'] for i in insns}
    for i in insns:
        t = i.get('target')
        if i['mode'].startswith('rel') and t is not None and start <= t < disasm.stop_pc and t not in starts:
            w.append('mid-branch')
            break
    # Reading the return address: lda $01,s / lda $03,s ... followed by a store back.
    sr = [i for i in insns if i['mode'] == 'sr']
    if any(i['mn'] == 'lda' for i in sr) and any(i['mn'] == 'sta' for i in sr):
        w.append('stack-args')
    return w


def trace(rom, labels, mask):
    found = {}                     # address -> info
    entry = collections.defaultdict(set)
    callers = collections.defaultdict(list)
    queue = []

    def visit(insns, who):
        for t, m8, x8, kind, pc in calls(insns):
            if not is_rom_code_address(t) or mask[offset(t)]:
                continue
            entry[t].add((m8, x8))
            callers[t].append((who, pc, kind))
            if t not in found:
                found[t] = None
                queue.append((t, m8, x8))

    for a, name, m8, x8 in built_routines():
        d = Disassembler(rom, labels, a, None, m8, x8)
        insns, _ = d.decode()
        visit(insns, name)

    while queue:
        a, m8, x8 = queue.pop()
        d = Disassembler(rom, labels, a, None, m8, x8)
        insns, _ = d.decode()
        # Stop at code that is already built: this routine runs on into it.
        end = d.stop_pc
        built = next((x for x in range(a, end) if mask[offset(x)]), None)
        if built is not None:
            end = built
            d = Disassembler(rom, labels, a, end, m8, x8)
            insns, _ = d.decode()
        found[a] = dict(end=end, m8=m8, x8=x8, warn=warnings(insns, d, a), clipped=built is not None)
        visit(insns, f'{a:06X}')

    for a, info in found.items():
        if len(entry[a]) > 1:
            info['warn'].append('widths')
        info['callers'] = callers[a]
    return found


def merge(found):
    """Drop routines that start inside another one found earlier in the ROM (local entry
    points), keeping the outer one."""
    out, end = [], 0
    for a in sorted(found):
        if a < end:
            continue
        out.append((a, found[a]))
        end = max(end, found[a]['end'])
    return out


def main():
    ap = argparse.ArgumentParser(description=__doc__.split('\n')[0])
    ap.add_argument('--bank', help='only this bank, e.g. 88')
    ap.add_argument('--list', action='store_true', help='list every routine found')
    ap.add_argument('--write', metavar='FILE', help='write the routines found to FILE')
    a = ap.parse_args()

    rom, labels = read_rom(), load_labels('labels.txt')
    if not labels:
        raise SystemExit('labels.txt is missing; run ./build.sh first')
    mask = coverage_mask()
    found = merge(trace(rom, labels, mask))
    if a.bank:
        bank = int(a.bank, 16) & 0x3F
        found = [(x, i) for x, i in found if (x >> 16) & 0x3F == bank]

    per_bank = collections.defaultdict(lambda: [0, 0, 0])
    for x, info in found:
        b = per_bank[(x >> 16) | 0x80 if x >> 16 < 0xC0 else x >> 16]
        b[0] += 1
        b[1] += info['end'] - x
        b[2] += bool(info['warn'])
    print('bank  routines    bytes  with warnings')
    for bank in sorted(per_bank):
        n, size, w = per_bank[bank]
        print(f' ${bank:02X}  {n:8}  {size:7,}  {w:13}')
    total = sum(v[1] for v in per_bank.values())
    print(f'total {len(found):8}  {total:7,}')

    if a.list:
        for x, info in found:
            who = info['callers'][0]
            widths = ('m8' if info['m8'] else 'm16') + ' ' + ('x8' if info['x8'] else 'x16')
            print(f'{x >> 16:02X}/{x & 0xFFFF:04X} {info["end"] - x:5} bytes  {widths:7}  '
                  f'{len(info["callers"])} caller(s), e.g. {who[2]} from {who[0]}  {" ".join(info["warn"])}')

    if a.write:
        parts = ['; Routines found by tools/trace.py. Each was reached from code in the build.\n']
        for x, info in found:
            d = Disassembler(rom, labels, x, info['end'] if info['clipped'] else None, info['m8'], info['x8'])
            text = d.render(f'rlUnknown{x:06X}')
            if info['clipped']:
                text = text.replace('\n', '\n\n        ; Runs on into built code at the end.', 1)
            if info['warn']:
                text = text.replace('\n', f'\n\n        ; TRACE: {" ".join(info["warn"])}', 1)
            parts.append(text)
        open(a.write, 'w', encoding='utf-8').write('\n'.join(parts))
        print(f'wrote {len(found)} routines to {a.write}')


if __name__ == '__main__':
    main()
