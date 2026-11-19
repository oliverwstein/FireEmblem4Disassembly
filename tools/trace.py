#!/usr/bin/env python3
"""Find code that is not disassembled yet by following calls and jumps from built code.

usage: tools/trace.py [--bank XX] [--write FILE] [--list]

Starting from every routine already in the build, this follows jsr, jsl, jmp and jml
to addresses that still come from the base ROM, and the entries of jsr (table,x) and
jmp (table,x) tables that the emulator log (fe4.cdl) shows read, disassembles what it finds there
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

--from-log also starts from every entry point of executed code in fe4.cdl that is
not built: the log proves it is code, so it needs no caller in the build.

--write FILE writes the routines found (optionally only in --bank) to FILE as a
routines file for tools/test_routines.py and tools/place_routines.py.
"""
import argparse, collections, glob, os, re, sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from asmlib import read_rom, offset, repo_copy, assemble
from disasm import Disassembler, load_labels, width_log
import procs

ODD = {'brk', 'cop', 'wdm', 'stp', 'xce'}

# Routines that take a definition in lR44 whose header points to init and
# on-cycle routines, and where in the header those two pointers are (each a
# word in the definition's bank). The engines call them with 16-bit registers.
CREATORS = {
    'rlProcEngineCreateProc': (2, 4),
    'rlProcEngineCreateProcByIndex': (2, 4),
    'rlEventEngineCreateProc': (2, 4),
    'rlHDMAEngineCreateEntry': (0, 2),
    'rlHDMAEngineCreateEntryByIndex': (0, 2),
    'rlActiveSpriteEngineCreateSpriteHighestSlot': (0, 2),
}
LR44 = 0x62


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


def table_entries():
    """(address, m8, x8, table) for raw entries in pointer tables in the build whose
    other entries are routines. Widths come from the labelled entries. A raw .word
    entry ($XXXX or <>$XXXX) is taken to be in the table's own bank; words below $8000
    (unused slots) belong to the table but are not followed."""
    starts = {name: (m8, x8) for _, name, m8, x8 in built_routines()}
    entry = re.compile(r'^\s+\.(addr|word|long) (?:<>)?(\$[0-9A-F]{6}|\$[0-9A-F]{4}|[A-Za-z]\w*)\s*(;.*)?$')
    for f in glob.glob('engine/**/*.asm', recursive=True):
        lines = open(f, encoding='utf-8').read().split('\n') + ['']
        block, table, bank = [], None, 0
        for l in lines:
            m = entry.match(l)
            if m:
                block.append(m.group(2))
                continue
            if l.strip() == '' and block:
                continue
            if block:
                named = [starts[x] for x in block if x in starts]
                # Words below $8000 (unused slots such as $0000) stay part of the
                # table but are not code.
                raw = [int(x[1:], 16) | (bank if len(x) == 5 else 0) for x in block
                       if x.startswith('$') and (len(x) != 5 or int(x[1:], 16) >= 0x8000)]
                if named and raw:
                    m8, x8 = max(set(named), key=named.count)
                    for a in raw:
                        yield a, m8, x8, table
            block = []
            t = re.match(r'^ {6}([A-Za-z]\w*) ; ([0-9A-F]{2})/', l)
            if t:
                table, bank = t.group(1), int(t.group(2), 16) << 16


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


def indexed_jump_targets(insns, rom, log):
    """(target, m8, x8, kind, pc) for the entries of the tables that jsr (table,x) and
    jmp (table,x) jump through. A table's length is not in the code, so only the
    entries that the emulator log shows read, and whose targets it shows executed, are
    taken."""
    if not log:
        return
    for ins in insns:
        if ins['mode'] != 'absindx':
            continue
        o = offset((ins['pc'] & 0xFF0000) | ins['val'])
        while log[o] & 0x02 and log[o + 1] & 0x02 and not log[o] & 0x01:
            t = (ins['pc'] & 0xFF0000) | rom[o] | rom[o + 1] << 8
            # An entry that was jumped through leads to code that ran; anything else
            # means the walk has gone past the end of the table.
            if t & 0xFFFF < 0x8000 or not log[offset(t)] & 0x01:
                break
            yield t, ins['m8'], ins['x8'], f'{ins["mn"]} (table,x) entry', ins['pc']
            o += 2


def definitions(insns, name_of):
    """(definition address, creator name) for each long pointer loaded into lR44
    shortly before a call to one of CREATORS."""
    for i in range(len(insns) - 3):
        a, b, c, d = insns[i:i + 4]
        if not (a['mn'] == c['mn'] == 'lda' and a['mode'] == c['mode'] == 'immm' and a['size'] == 2
                and b['mn'] == d['mn'] == 'sta' and b['mode'] == d['mode'] == 'dp'
                and b['val'] == LR44 + 1 and d['val'] == LR44):
            continue
        ptr = ((a['val'] >> 8) << 16) | c['val']
        for e in insns[i + 4:i + 14]:
            if e['mn'] == 'jsl':
                creator = name_of(e['target'])
                if creator in CREATORS:
                    yield ptr, creator
                break


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


def trace(rom, labels, mask, from_log=False):
    found = {}                     # address -> info
    entry = collections.defaultdict(set)
    callers = collections.defaultdict(list)
    queue = []

    def name_of(a):
        n = labels.get(a, [])
        return n[0] if n else None

    seen_defs = set()

    def definition_targets(ptr, creator):
        """Routines that a definition leads to: its init and on-cycle routines, and for a
        proc, the routines its script calls and the sprites it creates."""
        if ptr in seen_defs or not is_rom_code_address(ptr):
            return []
        seen_defs.add(ptr)
        out = []
        o = offset(ptr)
        for field in CREATORS[creator]:
            t = (ptr & 0xFF0000) | rom[o + field] | rom[o + field + 1] << 8
            if t & 0xFFFF >= 0x8000:
                out.append((t, False, False, f'{creator} definition {ptr:06X}', ptr))
        if CREATORS[creator] == (2, 4):
            script = procs.header(rom, ptr)[2]
            if script:
                _, refs, problems = procs.walk(rom, script)
                for kind, a, at in refs:
                    if kind == 'routine':
                        out.append((a, False, False, f'proc script {script:06X}', at))
                    else:
                        out += definition_targets(a, 'rlActiveSpriteEngineCreateSpriteHighestSlot')
        return out

    log = width_log()

    def visit(insns, who):
        targets = list(calls(insns)) + list(indexed_jump_targets(insns, rom, log))
        for ptr, creator in definitions(insns, name_of):
            targets += definition_targets(ptr, creator)
        add(targets, who)

    def add(targets, who):
        for t, m8, x8, kind, pc in targets:
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

    # Every proc that has a label, whether or not code that creates it is built.
    for a, names in labels.items():
        if a >= 0x800000 and any(n.startswith('proc') for n in names):
            add(definition_targets(a, 'rlProcEngineCreateProc'), names[0])

    if from_log:
        # Every entry point of executed code that is not built: the first byte of
        # each executed run and every byte the log marks as a jump or call target.
        # The log proves these are code, so they need no caller in the build.
        for o in range(0x8000, 0x400000):
            if not (o & 0x8000) or mask[o] or not log[o] & 0x01:
                continue
            if log[o] & 0x0C or not log[o - 1] & 0x01:
                a = 0x800000 | o
                entry[a].add((bool(log[o] & 0x20), bool(log[o] & 0x10)))
                callers[a].append(('fe4.cdl', a, 'log entry'))
                if a not in found:
                    found[a] = None
                    queue.append((a, bool(log[o] & 0x20), bool(log[o] & 0x10)))

    for a, m8, x8, table in table_entries():
        # An entry that points at $00 (brk) is an unused slot aimed at padding, not code.
        if is_rom_code_address(a) and not mask[offset(a)] and rom[offset(a)] != 0x00:
            entry[a].add((m8, x8))
            callers[a].append((table, a, 'table entry'))
            if a not in found:
                found[a] = None
                queue.append((a, m8, x8))

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
    ap.add_argument('--from-log', action='store_true',
                    help='also start from every entry point of executed code in fe4.cdl')
    a = ap.parse_args()

    rom, labels = read_rom(), load_labels('labels.txt')
    if not labels:
        raise SystemExit('labels.txt is missing; run ./build.sh first')
    mask = coverage_mask()
    if a.from_log and not width_log():
        raise SystemExit('--from-log needs fe4.cdl recorded from this ROM')
    found = merge(trace(rom, labels, mask, a.from_log))
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
        parts = ['; Routines found by tools/trace.py. Each was reached from code in the build'
                 + (' or ran in fe4.cdl.\n' if a.from_log else '.\n')]
        for x, info in found:
            d = Disassembler(rom, labels, x, info['end'] if info['clipped'] else None, info['m8'], info['x8'])
            insns, _ = d.decode()
            # The project names routines that return with rts rs..., and rtl rl...
            mns = {i['mn'] for i in insns}
            prefix = 'rs' if 'rts' in mns and 'rtl' not in mns else 'rl'
            text = d.render(f'{prefix}Unknown{x:06X}')
            if info['clipped']:
                text = text.replace('\n', '\n\n        ; Runs on into built code at the end.', 1)
            if info['warn']:
                text = text.replace('\n', f'\n\n        ; TRACE: {" ".join(info["warn"])}', 1)
            parts.append(text)
        open(a.write, 'w', encoding='utf-8').write('\n'.join(parts))
        print(f'wrote {len(found)} routines to {a.write}')


if __name__ == '__main__':
    main()
