#!/usr/bin/env python3
"""Write small offsets from an index register as struct fields.

usage: tools/name_struct_fields.py [--dry-run] [--list]

An operand like lda $0006,b,y reads a field of whatever Y points to. To name it,
the tool needs to know which struct that is. It finds where the index register
was last loaded (ldy SOURCE, or lda SOURCE then tay) and learns, from operands
that already use struct field names, which struct each SOURCE points to. A
SOURCE counts only if all of its named uses agree on one struct; SEEDS adds a
few that the code uses raw but whose struct is clear. Then each raw offset with
such a SOURCE becomes structName.Field, or Field+1 / Field+2 for a byte inside a
word or long field. Offsets where a union puts several fields are left alone.

Field offsets come from building with --dump-labels. A field name has the same
value as the number, so the ROM cannot change.
"""
import argparse, collections, glob, os, re, subprocess, sys, tempfile

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from asmlib import ASFLAGS

SEEDS = {
    'lMapMenuTilemapRAMEntryPointer,b': 'structMapMenuTilemapData',
    'lMapMenuRAMEntryPointer,b': 'structMapMenu',
}
OPERAND = re.compile(r'^(\s+[a-z]{3} )(\$00([0-9A-F]{2})|(struct\w+)\.[\w.]+(?:\+\d+)?),b,([xy])(\s*)$')
LABEL = re.compile(r'^\s*(_\w+|[+-]+)\s*$')


def struct_fields():
    """{struct: {offset: [field names]}} from --dump-labels."""
    with tempfile.TemporaryDirectory() as tmp:
        out = os.path.join(tmp, 'all.txt')
        subprocess.run(['64tass', *ASFLAGS, '-o', os.path.join(tmp, 'x.sfc'), '--dump-labels', '-l', out,
                        'build.asm'], capture_output=True, text=True)
        text = open(out, encoding='utf-8').read()
    fields = collections.defaultdict(lambda: collections.defaultdict(list))
    for m in re.finditer(r'^include/[^:]+:\d+:\d+: (struct\w+)\.([\w.]+) = \$?([0-9a-f]+)$', text, re.M):
        v = m.group(3)
        fields[m.group(1)][int(v, 16) if not v.isdigit() else int(v)].append(m.group(2))
    return fields


def field_sizes():
    """{field name: bytes} for fields declared with .byte, .char, .word, .addr or .long."""
    out = {}
    width = {'byte': 1, 'char': 1, 'word': 2, 'addr': 2, 'sint': 2, 'long': 3}
    for f in glob.glob('include/**/*.h', recursive=True):
        for m in re.finditer(r'^\s+([A-Za-z]\w*)\s+\.(byte|char|word|addr|sint|long)\b', open(f, encoding='utf-8').read(), re.M):
            out.setdefault(m.group(1), width[m.group(2)])
    return out


def source_of(lines, i, reg):
    for j in range(i - 1, max(i - 40, 0), -1):
        p = lines[j]
        if LABEL.match(p):
            return None
        m = re.match(r'^\s+ld' + reg + r' (\S+)\s*$', p)
        if m:
            return m.group(1)
        if re.match(r'^\s+ta' + reg + r'\b', p):
            for k in range(j - 1, max(j - 6, 0), -1):
                m = re.match(r'^\s+lda (\S+)\s*$', lines[k])
                if m:
                    return 'A=' + m.group(1)
                if re.match(r'^\s+(jsl|jsr)\s+(\S+)', lines[k]):
                    return 'A=call ' + lines[k].split()[1]
            return None
        if re.match(r'^\s+(t[xy]' + reg + r'|pl' + reg + r'|in' + reg + r'|de' + reg + r'|inc ' + reg + r'|dec ' + reg + r'|jsl|jsr|rts|rtl)\b', p):
            return None
    return None


def main():
    ap = argparse.ArgumentParser(description=__doc__.split('\n')[0])
    ap.add_argument('--dry-run', action='store_true')
    ap.add_argument('--list', action='store_true')
    a = ap.parse_args()
    fields = struct_fields()
    files = sorted(glob.glob('engine/**/*.asm', recursive=True))
    text = {f: open(f, encoding='utf-8').read().split('\n') for f in files}

    learned = collections.defaultdict(collections.Counter)
    for f in files:
        code = [l.split(';')[0].rstrip() for l in text[f]]
        for i, c in enumerate(code):
            m = OPERAND.match(c)
            if m and m.group(4):
                s = source_of(code, i, m.group(5))
                if s:
                    learned[s][m.group(4)] += 1
    # General-purpose pointers can point at different structs in different routines.
    general = re.compile(r'^(A=)?(lStructPointer\d|lR\d+|wR\d+)\b')
    mapping = {s: next(iter(c)) for s, c in learned.items() if len(c) == 1 and not general.match(s)}
    mapping.update(SEEDS)
    if a.list:
        for s, st in sorted(mapping.items()):
            print(f'{st:40} <- {s}')

    def field(st, off, byte_read):
        fs = fields.get(st, {})
        if off in fs:
            names = fs[off]
            if len(names) == 1:
                return names[0]
            # A union: a byte read takes the field that is one byte long.
            pick = [n for n in names if (size(fs, off, n) == 1) == byte_read and size(fs, off, n)]
            return pick[0] if len(pick) == 1 else None
        for k in (1, 2):
            if off - k in fs and len(fs[off - k]) == 1 and not any(off - k < o <= off for o in fs):
                return f'{fs[off - k][0]}+{k}'
        return None

    sizes = field_sizes()

    def size(fs, off, name):
        return sizes.get(name, 0)

    total = 0
    for f in files:
        lines = text[f]
        code = [l.split(';')[0].rstrip() for l in lines]
        changed = 0
        for i, c in enumerate(code):
            m = OPERAND.match(c)
            if not m or m.group(4):
                continue
            s = source_of(code, i, m.group(5))
            st = mapping.get(s)
            if not st:
                continue
            byte_read = 8 if False else None
            j = i - 1
            width = 16
            while j >= 0:
                cc = code[j]
                if re.match(r'^\s+sep #\$?(20|30)\b', cc) or cc.strip() == '.as':
                    width = 8
                    break
                if re.match(r'^\s+rep #\$?(20|30)\b', cc) or cc.strip() == '.al':
                    break
                j -= 1
            nxt = next((x for x in code[i + 1:i + 3] if x.strip()), '')
            byte_read = width == 8 or bool(re.match(r'^\s+and #\$?(00)?FF\s*$', nxt))
            name = field(st, int(m.group(3), 16), byte_read)
            if not name:
                continue
            rest = lines[i][len(c):]
            lines[i] = f'{m.group(1)}{st}.{name},b,{m.group(5)}{m.group(6)}{rest}'
            changed += 1
        if changed:
            total += changed
            if not a.dry_run:
                open(f, 'w', encoding='utf-8').write('\n'.join(lines))
    print(f'{len(mapping)} pointer sources with a known struct; {total} offsets now use field names')


if __name__ == '__main__':
    main()
