#!/usr/bin/env python3
"""Fix absolute/long addressing differences in a routines file, using the ROM as the reference.

usage: tools/fix_addressing.py FILE

First it adds `.databank X` after each explicit bank switch (`lda #X / pha / rep #$20 /
plb`) that does not declare one. Then it repeatedly tests FILE (see test_routines.py).
While there are assembly errors, it fixes
the two systematic data bank ones (for operands outside bank $00):

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
  built direct page, original absolute or long
      -> `,b` or `@l` on the operand
  an immediate operand one byte longer or shorter than in the ROM
      -> a register width directive (.as/.al/.xs/.xl) goes before that instruction

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
    """Fix the two systematic data bank errors. Returns the number of lines changed.

    `not a data bank address` on an operand outside bank $00: the instruction has no long
    form, so the routine must run with that data bank; set the nearest `.databank ?` to it.
    `too large for a 16 bit` on such an operand: `,b` needs a 16-bit operand, so drop the
    `,b` and let .databank decide the addressing mode.
    """
    lines = res.lines
    changed = set()
    for e in res.errors:
        m = re.search(rf'{re.escape(path)}:(\d+):\d+: error: (not a data bank address|too large for a 16 bit)'
                      rf"[^']*'\$([0-9a-f][1-9a-f]|[1-9a-f]0)[0-9a-f]{{4}}'", e)
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


M_IMMEDIATE = {0x09, 0x29, 0x49, 0x69, 0x89, 0xA9, 0xC9, 0xE9}   # ora and eor adc bit lda cmp sbc #
X_IMMEDIATE = {0xA0, 0xA2, 0xC0, 0xE0}                           # ldy ldx cpy cpx #


def width_fix(ln, built, orig, res, at_offset):
    """A register width directive that makes an immediate operand the size the ROM has.

    64tass tracks register widths through rep/sep, but not through plp or across
    routines entered in a different mode, so an immediate can come out one byte too long
    or too short. Returns (line number, directive) or None.
    """
    def directive(op, wide):
        return ('.al' if wide else '.as') if op in M_IMMEDIATE else ('.xl' if wide else '.xs')
    # Built 16-bit, original 8-bit: same opcode and low byte, but the next byte differs.
    if (len(built) == 3 and built[0] in M_IMMEDIATE | X_IMMEDIATE and orig[0] == built[0]
            and orig[1] == built[1] and orig[2] != built[2]):
        return ln, directive(built[0], False)
    # (The opposite case, built 8-bit where the original is 16-bit, cannot be told apart
    # reliably from other size differences, so it is left to be fixed by hand.)
    return None


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
        inserts = []                     # (line number, directive) to insert before that line
        at_offset = {off: (n, bs) for n, (off, bs) in res.listing.items()}
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
            elif asmlib.DP_TO_ABS.get(built[0]) == orig[0] and ',b' not in lines[ln - 1]:
                # Built direct page, original absolute: say so with ,b.
                new = re.sub(r'^(\s*[a-z]{3}\s+[^\s;,]+)', r'\1,b', lines[ln - 1], count=1)
                if new != lines[ln - 1]:
                    lines[ln - 1] = new; changed += 1
            elif (asmlib.ABS_TO_LONG.get(asmlib.DP_TO_ABS.get(built[0])) == orig[0]
                  and '@l' not in lines[ln - 1]):
                # Built direct page, original long.
                new = re.sub(r'^(\s*[a-z]{3}\s+)', r'\1@l ', lines[ln - 1], count=1)
                if new != lines[ln - 1]:
                    lines[ln - 1] = new; changed += 1
            elif (w := width_fix(ln, built, orig, res, at_offset)):
                inserts.append(w); changed += 1
        for n, directive in sorted(set(inserts), reverse=True):
            indent = lines[n - 1][:len(lines[n - 1]) - len(lines[n - 1].lstrip())]
            lines.insert(n - 1, indent + directive)
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
