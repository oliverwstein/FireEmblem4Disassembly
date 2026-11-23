#!/usr/bin/env python3
"""Disassemble a range again from its real entry points, following step chains.

usage: tools/redisasm_chain.py FILE START END ENTRY... [s:SCRIPT...] [--dry-run]

Replaces the source lines that build the ROM bytes START..END-1 (CPU addresses,
e.g. 9F9F7A) in FILE with a fresh disassembly. The range is cut into one
routine per entry point; each piece is decoded by tools/disasm.py from its
entry up to the next entry (16-bit A and X, as the engines call on-cycle
routines). Entry points are the ENTRY addresses plus every address the decoded
code stores into an on-cycle pointer (lda #$XXXX / sta ...OnCycle) or calls
with jsr that falls in the range, repeated until no new one appears. Pieces
reached by jsr are named rs..., the others rl....

s:SCRIPT marks the start of an active sprite script inside the range: it is
written with tools/sprite_scripts.py up to the next entry, and the routines it
calls or sets as on-cycle become entries.

Use it where earlier tools decoded a step chain as .byte rows or started a
routine in the middle of an instruction. Rebuild afterwards (./build.sh) and
rerun name_ram.py, apply_constants.py and name_struct_fields.py: the fresh
disassembly has raw RAM addresses.
"""
import os, re, sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import asmlib
import disasm
import promote_locals
import sprite_scripts

STEP_RE = re.compile(r'lda #\$([0-9A-F]{4})\s*\n\s+sta (?:aProcSystem\.aHeaderOnCycle|aActiveSpriteSystem\.aOnCycle|\$1160),b,[xy]')
LABEL_STEP_RE = re.compile(r'lda #<>(\w+)\s*\n\s+sta (?:aProcSystem\.aHeaderOnCycle|aActiveSpriteSystem\.aOnCycle|\$1160),b,[xy]')


def decode(rom, labels, entries, end, prefix={}, scripts=(), used=None, inner={}):
    """[(start, name, text)] for each piece. inner: {piece start: further addresses
    inside it that other pieces reach}, given local labels."""
    out = []
    es = sorted(set(entries) | set(scripts))
    for k, e in enumerate(es):
        stop = es[k + 1] if k + 1 < len(es) else end
        if e in scripts:
            text, uses, send = sprite_scripts.render(rom, labels, [e], stop=stop)
            if used is not None:
                used |= uses['routines']
            name = re.match(r'\s*(\w+)', text).group(1)
            out.append((e, name, text))
            if send < stop:
                d = disasm.Disassembler(rom, labels, send, stop, False, False)
                out.append((send, f'rlUnknown{send:06X}', d.render(f'rlUnknown{send:06X}')))
            continue
        d = disasm.Disassembler(rom, labels, e, stop, False, False, entries=inner.get(e, ()))
        old = [n for n in labels.get(e, []) if n[:2] in ('rl', 'rs')]
        name = old[0] if old else f'{prefix.get(e, "rl")}Unknown{e:06X}'
        out.append((e, name, d.render(name)))
    return out


RAW_RE = re.compile(r'^(\s+(?:b[a-z]{2}|brl|jmp|jml|jsr|jsl) )\$([0-9A-F]{6})\s*$', re.M)


def link(pieces, start, end):
    """Rewrite raw jumps and branches into another piece of the range as labels.
    Returns (text, {piece start: inner addresses needed}) ."""
    starts = [p[0] for p in pieces]
    names = {p[0]: p[1] for p in pieces}
    need = {}
    texts = []
    for s, name, text in pieces:
        def fix(m):
            a = int(m.group(2), 16)
            if not (start <= a < end):
                return m.group(0)
            if a in names:
                return m.group(1) + names[a]
            owner = max(x for x in starts if x <= a)
            need.setdefault(owner, set()).add(a)
            return m.group(1) + f'{names[owner]}._{a & 0xFFFF:04X}'
        texts.append(RAW_RE.sub(fix, text))
    return ''.join(texts), need


def main():
    args = [a for a in sys.argv[1:] if not a.startswith('--')]
    if len(args) < 4:
        raise SystemExit(__doc__)
    path = args[0]
    start, end = (int(a.replace('/', ''), 16) for a in args[1:3])
    entries = {int(a.replace('/', ''), 16) for a in args[3:] if not a.startswith('s:')}
    scripts = {int(a[2:].replace('/', ''), 16) for a in args[3:] if a.startswith('s:')}
    rom = asmlib.read_rom()
    labels = disasm.load_labels('labels.txt')
    prefix = {}
    by_name = {n: a for a, ns in labels.items() for n in ns}
    inner = {}
    while True:
        used = set()
        pieces = decode(rom, labels, entries, end, prefix, scripts, used, inner)
        text, need = link(pieces, start, end)
        if any(not set(v) <= set(inner.get(k, ())) for k, v in need.items()):
            for k, v in need.items():
                inner[k] = set(inner.get(k, ())) | v
            continue
        new = {int(m.group(1), 16) | (start & 0xFF0000) for m in STEP_RE.finditer(text)} | used
        for m in LABEL_STEP_RE.finditer(text):
            mm = re.search(r'([0-9A-F]{6})$', m.group(1))
            if mm:
                new.add(int(mm.group(1), 16))
        for m in re.finditer(r'(?:jsr|jsl|jml) (\$[0-9A-F]{4,6}|\w+)\s*$', text, re.M):
            tgt = m.group(1)
            a = (int(tgt[-4:], 16) | (start & 0xFF0000)) if tgt.startswith('$') else by_name.get(tgt, 0)
            new.add(a)
            if 'jsr' in m.group(0):
                prefix.setdefault(a, 'rs')
        new = {a for a in new if start <= a < end} - entries
        if not new:
            break
        entries |= new
    print('entries:', ' '.join(f'{e:06X}' for e in sorted(entries)), file=sys.stderr)
    if '--dry-run' in sys.argv:
        sys.stdout.write(text)
        return
    lines = open(path, encoding='utf-8').read().split('\n')
    lst = promote_locals.listing()
    first = last = None
    for l in lst:
        m = promote_locals.LIST_RE.match(l)
        if not m:
            continue
        a, n = int(m.group(2), 16), int(m.group(1)) - 1
        if not (0 <= n < len(lines)) or lines[n].rstrip() != m.group(4).rstrip():
            continue
        nbytes = len(m.group(3).split())
        if start <= a < end and nbytes:
            first = n if first is None else min(first, n)
            last = n if last is None else max(last, n)
    if first is None:
        raise SystemExit('no source line builds that range')
    # Take the routine label line(s) and header just above the first byte line along.
    walk = re.compile(r'^\s*$|^\s*;|^\s*\.(al|as|xl|xs|autsiz|databank \?)\s*$')
    while first > 0 and (walk.match(lines[first - 1]) or promote_locals.TOP_RE.match(lines[first - 1])
                         or promote_locals.LOCAL_DEF_RE.match(lines[first - 1])):
        first -= 1
    while last + 1 < len(lines) and (not lines[last + 1].strip() or lines[last + 1].strip() == '.databank 0'):
        last += 1
    removed = lines[first:last + 1]
    gone = [m.group(1) for l in removed if (m := promote_locals.TOP_RE.match(l)) and not l.strip().startswith('.')]
    print('replaced lines', first + 1, '-', last + 1, '; labels removed:', ' '.join(gone), file=sys.stderr)
    lines[first:last + 1] = [''] + text.rstrip('\n').split('\n') + ['']
    open(path, 'w', encoding='utf-8').write('\n'.join(lines))


if __name__ == '__main__':
    main()
