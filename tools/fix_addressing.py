#!/usr/bin/env python3
"""Fix absolute/long addressing differences in a routines file, using the ROM as the reference.

usage: tools/fix_addressing.py FILE

First it adds `.databank X` after each explicit bank switch (`lda #X / pha / rep #$20 /
plb`) that does not declare one. Then it repeatedly tests FILE (see test_routines.py).
While there are assembly errors, it fixes
the two systematic ones for WRAM in banks $7E/$7F:

  `not a data bank address`  -> the nearest `.databank ?` gets that bank
  `too large for a 16 bit`   -> the operand's `,b` is removed (in 64tass, `,b` requires a
                                16-bit operand; it does not subtract the data bank)

Once it assembles, for each differing routine it looks at the first real difference:

  built long, original absolute, and the nearest .databank is `?`
      -> the routine runs with the data bank already set, so that .databank line gets
         the operand's bank (e.g. `.databank $7F`)
  built absolute, original long
      -> the original used a long address although the data bank allowed absolute,
         so the operand gets `@l`

Stops when a round changes nothing, then prints the remaining differences, which need a
look by hand. FILE is edited in place; review the changes with `git diff`.
"""
import os, re, sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import asmlib
import test_routines


SWITCH = re.compile(r'lda #(\$[0-9A-Fa-f]{2}|`\w+)$')


def declare_bank_switches(path):
    """Add `.databank X` after every `lda #X / pha / rep #$20 / plb` that lacks one.

    That sequence sets the data bank; declaring it lets 64tass pick absolute addressing
    for that bank, which is what the original code does after switching.
    """
    lines = open(path, encoding='utf-8').read().split('\n')
    n = 0
    for i in range(len(lines) - 1, -1, -1):        # backwards, so insertions keep indexes valid
        if lines[i].strip() != 'plb':
            continue
        prev = [x.strip() for x in lines[max(0, i - 4):i] if x.strip()][-3:]
        if not (len(prev) == 3 and prev[1] == 'pha' and prev[2] == 'rep #$20' and (m := SWITCH.match(prev[0]))):
            continue
        j = next((k for k in range(i + 1, len(lines)) if lines[k].strip()), None)
        indent = lines[i][:len(lines[i]) - len(lines[i].lstrip())]
        if j is not None and lines[j].strip() == '.databank ?':
            lines[j] = indent + f'.databank {m.group(1)}'; n += 1
        elif j is None or not lines[j].strip().startswith('.databank'):
            lines.insert(i + 1, indent + f'.databank {m.group(1)}'); n += 1
    if n:
        open(path, 'w', encoding='utf-8').write('\n'.join(lines))
    return n


def fix_errors(path, res):
    """Fix the two systematic WRAM addressing errors. Returns the number of lines changed.

    `not a data bank address` on a $7E/$7F operand: the instruction has no long form, so
    the routine must run with that data bank; set the nearest `.databank ?` to it.
    `too large for a 16 bit` on a $7E/$7F operand: `,b` needs a 16-bit operand, so drop
    the `,b` and let .databank decide the addressing mode.
    """
    lines = res.lines
    changed = set()
    for e in res.errors:
        m = re.search(rf'{re.escape(path)}:(\d+):\d+: error: (not a data bank address|too large for a 16 bit)'
                      rf"[^']*'\$(7[ef])[0-9a-f]{{4}}'", e)
        if not m:
            continue
        ln, kind, bank = int(m.group(1)), m.group(2), m.group(3).upper()
        if kind.startswith('not a data bank'):
            db, dbline = res.databank_at(ln)
            if db == '.databank ?' and dbline not in changed:
                lines[dbline - 1] = lines[dbline - 1].replace('.databank ?', f'.databank ${bank}')
                changed.add(dbline)
        elif ln not in changed:
            new = re.sub(r',b\b', '', lines[ln - 1], count=1)
            if new != lines[ln - 1]:
                lines[ln - 1] = new; changed.add(ln)
    if changed:
        open(path, 'w', encoding='utf-8').write('\n'.join(lines))
    return len(changed)


def main():
    if len(sys.argv) != 2:
        print(__doc__); return 2
    path = sys.argv[1]
    rom = asmlib.read_rom()
    n = declare_bank_switches(path)
    print(f'declared the data bank after {n} explicit bank switches')
    for rnd in range(1, 50):
        res = test_routines.run(path, long_branch=True, listing=True)
        if res.errors:
            fixed = fix_errors(path, res)
            print(f'round {rnd}: {len(res.errors)} assembly errors; {fixed} fixes')
            if fixed:
                continue
            print('Remaining errors need a look by hand, e.g.:')
            for e in res.errors[:15]:
                print('  ' + e)
            return 1
        bad = res.mismatches(rom)
        lines = res.lines
        changed, headers = 0, set()
        for name, addr, n, size, first in bad:
            d = res.first_difference(addr, rom) if n else None
            if not d:
                continue
            ln, built, orig = d
            db, dbline = res.databank_at(ln)
            if asmlib.LONG_TO_ABS.get(built[0]) == orig[0] and db == '.databank ?' and dbline not in headers:
                lines[dbline - 1] = lines[dbline - 1].replace('.databank ?', f'.databank ${built[3]:02X}')
                headers.add(dbline); changed += 1
            elif asmlib.ABS_TO_LONG.get(built[0]) == orig[0] and '@l' not in lines[ln - 1]:
                new = re.sub(r'^(\s*[a-z]{3}\s+)', r'\1@l ', lines[ln - 1], count=1)
                if new != lines[ln - 1]:
                    lines[ln - 1] = new; changed += 1
        print(f'round {rnd}: {len(res.routines) - len(bad)} of {len(res.routines)} routines match; {changed} fixes')
        if not changed:
            break
        open(path, 'w', encoding='utf-8').write('\n'.join(lines))
    if bad:
        print('Remaining differences:')
        for name, addr, n, size, first in bad:
            print(f'  {addr:06X} {name}')
            if n and (d := res.first_difference(addr, rom)):
                ln, bs, orig = d
                print(f'      line {ln}: {res.lines[ln - 1].strip()}   built {bs.hex(" ")}, original {orig.hex(" ")}')
    return 0 if not bad else 1


if __name__ == '__main__':
    sys.exit(main())
