#!/usr/bin/env python3
"""Write raw code pointers stored into the engines' pointer variables as labels.

usage: tools/code_pointers.py [--write] [--cdl FILE]

Finds an immediate load directly followed by a store of the same register into
a variable that the game jumps through:

    lda #$841F                          lda #<>rlUnknown82841F
    sta aProcSystem.aHeaderOnCycle,b,x  sta aProcSystem.aHeaderOnCycle,b,x

and reports, for each, the routine at the target or why it was left alone.
--write replaces the number with <>label, removes the "Found through fe4.cdl"
comment from routines that now have a reference, and shortens their "Found by
tools/sweep.py: nothing in the build reaches this." to "Found by tools/sweep.py.". Needs labels.txt
from ./build.sh.

The bank of the target is the bank the dispatching code jumps into:

  wVBlankPointer      $80  NMI handler (rlUnknown8081B6) jml's into $80, then jmp (wVBlankPointer)
  wIRQPointer         $80  IRQ handler (rlUnknown8081FD) the same, jmp (wIRQPointer)
  wMainLoopPointer    $80  jmp (wMainLoopPointer) at $80/8EEE
  aProcSystem.aHeaderOnCycle    rlProcEngineRunProcOnCycle: bank from aHeaderTypeBank
  aHDMASystem.aOnCycle          rlHDMAEngineRunOnCycle: bank from aTypeBank
  aActiveSpriteSystem.aOnCycle  rlActiveSpriteRunOnCycle: bank from aBanks

For the last three the bank is the bank of the proc, HDMA or active sprite
header, which the store does not name. Two ways to settle it:

  - The header: a store in a routine that a .structProcInfo or HDMA header
    names as its init or on-cycle routine gets that header's bank. A target set
    this way becomes another on-cycle routine of the same header, so the rule
    carries along a chain of cycles.
  - The log: otherwise the tool takes the store's own bank (a proc switching
    its own on-cycle routine runs in its header's bank) and accepts the target
    only when fe4.cdl confirms it: the target ran and is marked as a jump
    target ($04) or subroutine entry ($08).

For the fixed-bank variables and header-settled stores a routine label at the
target is enough. The log is checked wherever it has the target, and a
disagreement (ran but not entered by a jump, or only read as data) skips it.

A target is written as a label only when exactly one top-level routine label
(rl.../rs...) is at that address.

Second rule, long pointers loaded in two halves into any variable:

    lda #$8A00                       lda #(`label)<<8
    sta lRoutineVariable+1,b         sta lRoutineVariable+1,b
    lda #$88E0                       lda #<>label
    sta lRoutineVariable,b           sta lRoutineVariable,b

The address half is the nearest immediate stored into the same variable within
six lines of the bank half. Most of these point at data (menu text,
definitions, lR44/lR18), so both halves are written only when exactly one
top-level label is at the full 24-bit ROM address; the rest are counted, and
listed with the nearest label below the address. The other active sprite fields (aCodeOffset,
aFrameOffset, aUnknown...) hold script, frame data or counters, not code.
"""
import argparse, bisect, collections, glob, os, re, sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from asmlib import ROUTINE_RE

FIXED = {'wVBlankPointer': 0x80, 'wIRQPointer': 0x80, 'wMainLoopPointer': 0x80}
OWN_BANK = ('aProcSystem.aHeaderOnCycle', 'aHDMASystem.aOnCycle', 'aActiveSpriteSystem.aOnCycle')
VARS = (*FIXED, *OWN_BANK)

LOAD = re.compile(r'^(\s+ld([axy]) #)(\$[0-9A-F]{4}|<>(\w+))(\s*(?:;.*)?)$')
STORE = re.compile(r'^\s+st([axy]) (' + '|'.join(re.escape(v) for v in VARS) + r')((?:,b)?(?:,[xy])?)\s*(?:;.*)?$')
FOUND = '        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.'
SWEPT = ('        ; Found by tools/sweep.py: nothing in the build reaches this.', '        ; Found by tools/sweep.py.')
CODE_FLAGS = 0x01
ENTRY_FLAGS = 0x04 | 0x08


def load_labels():
    """{address: [top-level names]} and {name: address} from labels.txt."""
    if not os.path.exists('labels.txt'):
        raise SystemExit('labels.txt not found: run ./build.sh first')
    at, addr = collections.defaultdict(list), {}
    for line in open('labels.txt', encoding='utf-8'):
        p = line.split()
        if len(p) == 3 and p[0] == 'al' and ':' not in p[2]:
            name, a = p[2].lstrip('.'), int(p[1], 16)
            if a >= 0x800000 and name not in addr:
                addr[name] = a
                at[a].append(name)
    return at, addr


def load_cdl(path):
    if not path or not os.path.exists(path):
        return None
    raw = open(path, 'rb').read()
    if raw[:5] != b'CDLv2':
        raise SystemExit(f'{path}: not a Mesen CDLv2 log')
    return raw[9:]


def find_stores(files):
    """[(file, line index, routine name, routine address, register, variable, value or label)]"""
    out = []
    for f in files:
        lines = open(f, encoding='utf-8').read().split('\n')
        routine = (None, None)
        for i, line in enumerate(lines[:-1]):
            if m := ROUTINE_RE.match(line):
                routine = (m.group(1), int(m.group(2) + m.group(3), 16))
            ld, st = LOAD.match(line), STORE.match(lines[i + 1])
            if ld and st and ld.group(2) == st.group(1):
                value = ld.group(4) or int(ld.group(3)[1:], 16)
                out.append((f, i, *routine, ld.group(2), st.group(2), value))
    return out


HEADER = re.compile(r'\.struct(?:ProcInfo\s+"[^"]*"|HDMA(?:Direct|Indirect)EntryInfo)\s*,?\s*(\w+)\s*,\s*(\w+)'
                    r'\s*,\s*(\$?\w+)')
PROC_CALL = re.compile(r'^\s+PROC_CALL(?:_ARGS)?\s+(\w+)')


def header_banks(files):
    """{routine name: bank} for the routines that run as part of a proc or HDMA header.

    These are the init and on-cycle routines a header names, and the routines that
    the proc's code script runs with PROC_CALL (a jsl with X still the current proc).
    A routine that headers in two banks claim gets no bank.
    """
    claims = collections.defaultdict(set)
    scripts = collections.defaultdict(set)  # code label: header banks
    blocks = {}  # top-level label: PROC_CALL targets in its block
    for f in files:
        bank, label = None, None
        for line in open(f, encoding='utf-8'):
            if m := ROUTINE_RE.match(line):
                bank, label = int(m.group(2), 16), m.group(1)
                blocks.setdefault(label, set())
            if bank is not None and (m := HEADER.search(line)):
                for name in m.group(1, 2):
                    claims[name].add(bank)
                scripts[m.group(3)].add(bank)
            if label and (m := PROC_CALL.match(line)):
                blocks[label].add(m.group(1))
    for code, banks in scripts.items():
        for name in blocks.get(code, ()):
            claims[name] |= banks
    return {name: next(iter(b)) for name, b in claims.items() if len(b) == 1}


BANK_HALF = re.compile(r'^(\s+ld([axy]) #)\$([0-9A-F]{2})00(\s*(?:;.*)?)$')
BANK_STORE = re.compile(r'^\s+st([axy]) ([\w.]+)\+1((?:,b)?)\s*(?:;.*)?$')
ADDRESS_HALF = re.compile(r'^(\s+ld([axy]) #)(\$[0-9A-F]{4}|<>[\w.]+)(\s*(?:;.*)?)$')


def find_halves(files):
    """[(file, bank line, address line or None, variable, full address or None)]"""
    out = []
    for f in files:
        lines = open(f, encoding='utf-8').read().split('\n')
        for i in range(len(lines) - 1):
            b, st = BANK_HALF.match(lines[i]), BANK_STORE.match(lines[i + 1])
            if not (b and st and b.group(2) == st.group(1)):
                continue
            var, suffix = st.group(2), st.group(3)
            store = re.compile(r'^\s+st([axy]) ' + re.escape(var + suffix) + r'\s*(?:;.*)?$')
            near = []
            for j in range(max(0, i - 6), min(len(lines) - 1, i + 7)):
                a, s = ADDRESS_HALF.match(lines[j]), store.match(lines[j + 1])
                if j != i and a and s and a.group(2) == s.group(1):
                    near.append((abs(j - i), j, a.group(3)))
            if not near:
                out.append((f, i, None, var, None))
                continue
            _, j, value = min(near)
            full = None if value.startswith('<>') else int(b.group(3), 16) << 16 | int(value[1:], 16)
            out.append((f, i, j, var, full))
    return out


def classify(store, at, addr, cdl, local_at, headers):
    """(label, None) to write, or (None, reason) to leave the number."""
    f, i, rname, raddr, reg, var, value = store
    if raddr is None:
        return None, 'no enclosing routine with an address'
    by_header = var in OWN_BANK and rname in headers
    bank = FIXED.get(var, headers[rname] if by_header else raddr >> 16)
    target = bank << 16 | value
    flags = cdl[target & 0x3FFFFF] if cdl is not None else None
    names = [n for n in at.get(target, []) if n.startswith(('rl', 'rs'))]
    where = f'${bank:02X}/{value:04X}'
    if not names:
        others = at.get(target, [])
        if others:
            return None, f'{where} is labelled {", ".join(others)}, not a routine'
        if target in local_at:
            return None, f'{where} is the local label {local_at[target]}'
        ran = '' if flags is None else (', ran' if flags & CODE_FLAGS else ', not in the log')
        return None, f'no routine label at {where}{ran}'
    if len(names) > 1:
        return None, f'{where} has several labels: {", ".join(names)}'
    if flags is not None and flags & CODE_FLAGS and not flags & ENTRY_FLAGS:
        return None, f'{where} ({names[0]}) ran, but the log does not mark it as a jump target'
    if flags is not None and flags and not flags & CODE_FLAGS:
        return None, f'{where} ({names[0]}) is only read as data in the log'
    if var in OWN_BANK and not by_header and (flags is None or not flags & CODE_FLAGS):
        return None, f'{where} ({names[0]}) is not in the log, so the header bank is not confirmed'
    return names[0], None


def local_labels():
    """{address: 'routine._local'} for local labels written _XXXX after a routine at bank/XXXX."""
    out = {}
    for f in glob.glob('engine/**/*.asm', recursive=True):
        routine = None
        for line in open(f, encoding='utf-8'):
            if m := ROUTINE_RE.match(line):
                routine = (m.group(1), int(m.group(2), 16))
            elif routine and (m := re.match(r'^\s+(_([0-9A-F]{4}))\s*$', line)):
                out[routine[1] << 16 | int(m.group(2), 16)] = f'{routine[0]}.{m.group(1)}'
    return out


def main():
    ap = argparse.ArgumentParser(description=__doc__.split('\n')[0])
    ap.add_argument('--write', action='store_true', help='replace the numbers and remove the comments')
    ap.add_argument('--cdl', default='fe4.cdl', help='Mesen code/data log (default fe4.cdl)')
    args = ap.parse_args()

    at, addr = load_labels()
    cdl = load_cdl(args.cdl)
    files = sorted(glob.glob('engine/**/*.asm', recursive=True))
    stores = find_stores(files)
    locs = local_labels()

    named = [s for s in stores if isinstance(s[6], str)]
    same = sum(1 for s in named if s[6] in addr and (s[5] in FIXED or addr[s[6]] >> 16 == s[3] >> 16))
    print(f'Already named: {len(named)} stores, {same} of them in the bank the rule gives.')
    for s in named:
        if s[6] in addr and not (s[5] in FIXED or addr[s[6]] >> 16 == s[3] >> 16):
            print(f'  {s[0]}:{s[1] + 1} {s[6]} is in bank ${addr[s[6]] >> 16:02X}, the store in ${s[3] >> 16:02X}')

    # Carry header banks along chains of on-cycle routines until nothing changes.
    headers = header_banks(files)
    raw = [s for s in stores if isinstance(s[6], int)]
    while True:
        before = len(headers)
        for s in named:
            if s[5] in OWN_BANK and s[2] in headers and s[6] in addr and addr[s[6]] >> 16 == headers[s[2]]:
                headers.setdefault(s[6], headers[s[2]])
        for s in raw:
            if s[5] in OWN_BANK and s[2] in headers:
                label, _ = classify(s, at, addr, cdl, locs, headers)
                if label:
                    headers.setdefault(label, headers[s[2]])
        if len(headers) == before:
            break
    mismatched = [s for s in raw if s[5] in OWN_BANK and s[2] in headers and headers[s[2]] != s[3] >> 16]
    print(f'Header banks known for {len(headers)} routines; {len(mismatched)} raw stores sit in another bank '
          f'than their header.')

    done, skipped = [], []
    for s in raw:
        label, reason = classify(s, at, addr, cdl, locs, headers)
        (done if label else skipped).append((s, label or reason))

    by_var = collections.Counter(s[5] for s, _ in done)
    left = collections.Counter(s[5] for s, _ in skipped)
    print(f'\nRaw stores: {len(raw)}. Written as labels: {len(done)}. Left: {len(skipped)}.')
    for v in VARS:
        print(f'  {v:30} {by_var[v]:4} labelled {left[v]:4} left')

    print('\nLeft as numbers:')
    for (f, i, rname, raddr, reg, var, value), reason in skipped:
        print(f'  {f}:{i + 1} ({rname}) st{reg} {var}: {reason}')

    targets = sorted({label for _, label in done})
    print(f'\nTargets: {len(targets)} routines.')

    # Second rule: long pointers loaded in two halves.
    starts = sorted(a for a in at if a >= 0x800000)
    halves, half_left = [], collections.Counter()
    half_notes = []
    for h in find_halves(files):
        f, i, j, var, full = h
        if j is None:
            why = 'no address half stored within six lines'
        elif full is None:
            why = 'the address half is already a name'
        elif full < 0x800000:
            why = 'RAM address'
        elif len(at.get(full, [])) == 1:
            halves.append((h, at[full][0]))
            continue
        elif full in at:
            why = 'several labels'
        else:
            below = starts[bisect.bisect_right(starts, full) - 1] if starts and starts[0] <= full else None
            hint = f' (inside or after {at[below][0]}+${full - below:X})' if below and below >> 16 == full >> 16 else ''
            why = 'no label at the address'
            half_notes.append(f'  {f}:{i + 1} {var} ${full:06X}{hint}')
        half_left[why] += 1
    print(f'\nLong pointers in two halves: {len(halves) + sum(half_left.values())}. '
          f'Written as labels: {len(halves)}. Left:')
    for why, n in half_left.most_common():
        print(f'  {n:4} {why}')
    for (f, i, j, var, full), label in halves:
        print(f'  {f}:{i + 1} {var} ${full:06X} -> {label}')
    print('\nNo label at the address:')
    print('\n'.join(half_notes))

    if not args.write:
        for (f, i, rname, raddr, reg, var, value), label in done:
            how = 'header' if var in OWN_BANK and rname in headers else ('log' if var in OWN_BANK else 'fixed')
            print(f'  {f}:{i + 1} ${value:04X} -> {label} ({how})')
        return

    edits = collections.defaultdict(dict)
    for (f, i, *_), label in done:
        edits[f][i] = ('word', label)
    for (f, i, j, var, full), label in halves:
        edits[f][i] = ('bank', label)
        edits[f][j] = ('address', label)
    for f, lines_to_fix in edits.items():
        lines = open(f, encoding='utf-8').read().split('\n')
        for i, (kind, label) in lines_to_fix.items():
            if kind == 'word':
                m = LOAD.match(lines[i])
                lines[i] = f'{m.group(1)}<>{label}{m.group(5)}'
            elif kind == 'bank':
                m = BANK_HALF.match(lines[i])
                lines[i] = f'{m.group(1)}(`{label})<<8{m.group(4)}'
            else:
                m = ADDRESS_HALF.match(lines[i])
                lines[i] = f'{m.group(1)}<>{label}{m.group(4)}'
        open(f, 'w', encoding='utf-8').write('\n'.join(lines))

    # The targets now have a reference: drop the comment saying nothing reaches them.
    cleared = swept = 0
    want = set(targets) | {label for _, label in halves}
    for f in files:
        lines = open(f, encoding='utf-8').read().split('\n')
        out, current, changed = [], None, False
        for line in lines:
            if m := ROUTINE_RE.match(line):
                current = m.group(1)
            if line == FOUND and current in want:
                cleared += 1
                changed = True
                continue
            if line == SWEPT[0] and current in want:
                line, swept, changed = SWEPT[1], swept + 1, True
            out.append(line)
        if changed:
            open(f, 'w', encoding='utf-8').write('\n'.join(out))
    remaining = sum(open(f, encoding='utf-8').read().count(FOUND) for f in files)
    print(f'Wrote {len(done)} labels and {len(halves)} long pointers in {len(edits)} files; removed the "Found through fe4.cdl" comment '
          f'from {cleared} routines ({remaining} left) and shortened {swept} "Found by tools/sweep.py" comments.')


if __name__ == '__main__':
    main()
