#!/usr/bin/env python3
"""Replace numbers in built code with the constants they stand for.

usage: tools/apply_constants.py [RULES] [--dry-run]

RULES (default tools/constant_rules.txt) pairs a source of a value with a family
of constants. Each line is:

    getter  ROUTINE  FAMILY  KIND    the value ROUTINE returns in A
    setter  ROUTINE  FAMILY  KIND    the value in A when ROUTINE is called
    field   OPERAND  FAMILY  KIND    the value an lda of OPERAND reads (a regex)

FAMILY is a constant name prefix (UnitState), or file:PATH for every constant
defined at the start of a line in PATH (the character and class IDs that the CSV
tables define). KIND is enum or bits.

After a getter or field read, the accumulator is followed until something changes
it (another load, a transfer, a call, a return or a label). On the way:
  - for enum families, cmp #N becomes cmp #Name, but only when a beq or bne uses
    the result (a bcc or bcs usually means a range check);
  - for bits families, the operands of bit, and, ora, eor, trb and tsb become
    names joined with |, and and #~(...) is used for masks that clear bits. A
    number is only replaced if all of its bits have names.
Before a setter, an lda #N just before the call becomes lda #Name.

The constants only stand for the numbers, so the ROM cannot change; build.sh
checks anyway.
"""
import argparse, glob, os, re, sys

CHANGES_A = re.compile(r'^\s+(lda|pla|txa|tya|tdc|tsc|xba|jsl|jsr|jml|jmp|rtl|rts|rti|adc|sbc|asl|lsr|rol|ror|inc a|dec a)\b')
LABEL = re.compile(r'^\s*(_\w+|[+-]+|[A-Za-z]\w*)\s*(;.*)?$')
VALUE = re.compile(r'^(?:bits\()?\s*(\$[0-9A-Fa-f]+|%[01]+|\d+)\s*\)?\s*(;.*)?$')


def number(text):
    text = text.strip()
    if text.startswith('$'):
        return int(text[1:], 16)
    if text.startswith('%'):
        return int(text[1:], 2)
    return int(text)


def load_constants():
    """{name: (value, file)} for simple numeric constants in include/ and data/."""
    out = {}
    files = glob.glob('include/**/*.h', recursive=True) + glob.glob('data/**/*.asm', recursive=True)
    for f in files:
        for line in open(f, encoding='utf-8', errors='ignore'):
            m = re.match(r'^(\s*)([A-Za-z_]\w*)\s*:?\??=\s*(.+)$', line)
            if not m:
                continue
            v = VALUE.match(m.group(3).strip())
            if v:
                out.setdefault(m.group(2), (number(v.group(1)), f, m.group(1) == ''))
    return out


def family(spec, constants):
    """{value: name} for a family; values with more than one name are left out."""
    if spec.startswith('file:'):
        path = spec[5:]
        names = {n: v for n, (v, f, top) in constants.items() if f == path and top}
    else:
        names = {n: v for n, (v, f, top) in constants.items() if n.startswith(spec)}
    by_value = {}
    for n, v in names.items():
        by_value.setdefault(v, []).append(n)
    return {v: ns[0] for v, ns in by_value.items() if len(ns) == 1}


def as_bits(value, fam, width):
    single = {v: n for v, n in fam.items() if v and v & (v - 1) == 0}
    if value in fam:
        return fam[value]
    parts, rest = [], value
    for bit in sorted(single):
        if rest & bit:
            parts.append(single[bit])
            rest &= ~bit
    if rest or not parts:
        inv = ~value & ((1 << width) - 1)
        if inv and inv != value:
            text = as_bits(inv, fam, width) if inv in fam or all(
                inv & b == 0 or b in single for b in (1 << k for k in range(width))) else None
            if text:
                return f'~({text})' if '|' in text else f'~{text}'
        return None
    return ' | '.join(parts)


def main():
    ap = argparse.ArgumentParser(description=__doc__.split('\n')[0])
    ap.add_argument('rules', nargs='?', default='tools/constant_rules.txt')
    ap.add_argument('--dry-run', action='store_true')
    a = ap.parse_args()

    constants = load_constants()
    rules = []
    for line in open(a.rules, encoding='utf-8'):
        p = line.split('#', 1)[0].split()
        if p:
            kind, source, fam, how = p
            rules.append((kind, source, family(fam, constants), how))

    total = 0
    for f in sorted(glob.glob('engine/**/*.asm', recursive=True)):
        lines = open(f, encoding='utf-8').read().split('\n')
        changed = 0
        for i, line in enumerate(lines):
            code = line.split(';')[0]
            for kind, source, fam, how in rules:
                if kind == 'getter':
                    hit = re.match(r'^\s+jsl ' + re.escape(source) + r'\s*$', code)
                elif kind == 'field':
                    hit = re.match(r'^\s+lda (@l )?' + source + r'\s*$', code)
                else:
                    hit = re.match(r'^\s+jsl ' + re.escape(source) + r'\s*$', code)
                if not hit:
                    continue
                if kind == 'setter':
                    j = i - 1
                    while j >= 0 and lines[j].strip() == '':
                        j -= 1
                    m = re.match(r'^(\s+lda #)(\$?[0-9A-F]+|\d+)(\s*(;.*)?)$', lines[j])
                    if m and how == 'enum' and number(m.group(2)) in fam:
                        lines[j] = m.group(1) + fam[number(m.group(2))] + m.group(3)
                        changed += 1
                    continue
                width = 16
                for j in range(i + 1, min(i + 40, len(lines))):
                    c = lines[j].split(';')[0]
                    if not c.strip():
                        continue
                    if LABEL.match(c) or CHANGES_A.match(c):
                        break
                    if re.match(r'^\s+sep #\$?(20|30)\b', c):
                        width = 8
                    if re.match(r'^\s+rep #\$?(20|30)\b', c):
                        width = 16
                    m = re.match(r'^(\s+)(cmp|bit|and|ora|eor|trb|tsb) #(\$[0-9A-F]+|\d+)(\s*)$', c)
                    if not m:
                        continue
                    op, v = m.group(2), number(m.group(3))
                    new = None
                    if how == 'enum' and op == 'cmp' and v in fam:
                        nxt = next((x for x in lines[j + 1:j + 4] if x.split(';')[0].strip()), '')
                        if re.match(r'^\s+(beq|bne)\b', nxt):
                            new = fam[v]
                    elif how == 'bits' and op != 'cmp':
                        new = as_bits(v, fam, width)
                    if new:
                        rest = lines[j][len(c):]
                        lines[j] = f'{m.group(1)}{op} #{new}{m.group(4)}{rest}'
                        changed += 1
        if changed:
            total += changed
            print(f'{changed:4} {f}')
            if not a.dry_run:
                open(f, 'w', encoding='utf-8').write('\n'.join(lines))
    print(f'{total} operands now use constants')


if __name__ == '__main__':
    main()
