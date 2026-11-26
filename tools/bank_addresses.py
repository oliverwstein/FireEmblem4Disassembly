"""List raw ROM addresses in code that the other tools miss: tools/bank_addresses.py

raw_addresses.py reads six-digit numbers and code_pointers.py long pointers in two
halves. This lists the four-digit ones whose bank comes from elsewhere:

  data      `lda $AA2A,b,y` and the like, $8000 and up, where the data bank is a ROM
            bank: the nearest `.databank $XX` above, or the code's own bank when that
            is `?` and the routine has phk / plb. Write them `<>label,b`.
  sprites   `ldy #$XXXX` up to nine lines before `jsl rlPushToOAMBuffer...`, the
            sprite array in the data bank. Write them `#<>label`.
  dma       `lda #$BB00 / sta $43x3 / lda #$XXXX / sta $43x2`, a DMA source in ROM.
            A fixed-source DMA often reads a zero inside a routine; give it a local
            label (`_DMAFillZero`) and write `Routine._DMAFillZero+1`.
  inline    a raw `.word $XXXX` ($8000 and up) or `.long $XXXXXX` right after a jsl or
            jsr: an inline argument (rlFadePaletteToColors takes a bank $7E address).

Each line gives the place, the address and the label it falls in (label+N inside
one). It changes nothing: a target inside a table or an instruction needs a label
placed by hand first. After a clean pass it prints nothing.
"""
import bisect
import os
import re
import subprocess
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from raw_addresses import listing, load_labels  # noqa: E402

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
OP = re.compile(r'^\s*([a-z]{3})\s+\$([0-9A-Fa-f]{4})(,b)?(,[xy])?\s*(?:;.*)?$')


def main():
    os.chdir(ROOT)
    glob_l, _ = load_labels()
    starts = sorted(glob_l)

    def label(t):
        i = bisect.bisect_right(starts, t) - 1
        return glob_l[starts[i]] + (f'+{t - starts[i]}' if t != starts[i] else '') if i >= 0 else '?'

    addr = {(f, n): a for (f, n), (a, _, _) in listing().items()}
    files = subprocess.run(['git', 'ls-files', 'engine/*.asm', 'events/*.asm'],
                           capture_output=True, text=True).stdout.split()
    out = []
    for f in files:
        L = open(f, encoding='utf-8').read().split('\n')

        def data_bank(i):
            """The data bank in effect at line index i, or None if not a ROM bank."""
            for k in range(i, max(-1, i - 150), -1):
                d = re.match(r'\s*\.databank\s+(\S+)', L[k])
                if d:
                    if d.group(1).startswith('$'):
                        b = int(d.group(1)[1:], 16)
                        return b if b >= 0x80 and b not in (0x7E, 0x7F) else None
                    break
            above = '\n'.join(L[max(0, i - 80):i])
            a = addr.get((f, i + 1))
            return a >> 16 if a is not None and 'phk' in above and 'plb' in above else None

        for i, l in enumerate(L):
            m = OP.match(l)
            if m and m.group(1) not in ('jmp', 'jsr', 'pea') and int(m.group(2), 16) >= 0x8000 and (f, i + 1) in addr:
                b = data_bank(i)
                if b is not None:
                    t = b << 16 | int(m.group(2), 16)
                    out.append(('data', f, i + 1, t))
            m = re.match(r'^\s+ldy #\$([0-9A-F]{4})\s*(;.*)?$', l)
            if m and int(m.group(1), 16) >= 0x8000 and any(
                    re.match(r'^\s+jsl rlPushToOAMBuffer', L[k]) for k in range(i + 1, min(i + 10, len(L)))):
                b = data_bank(i)
                if b is not None:
                    out.append(('sprites', f, i + 1, b << 16 | int(m.group(1), 16)))
            m = re.match(r'^\s+lda #\$([0-9A-F]{2})00\s*(;.*)?$', l)
            if m and i + 3 < len(L) and int(m.group(1), 16) >= 0x80:
                s = re.match(r'^\s+sta \$43([0-7])3(,b)?\s*$', L[i + 1])
                m2 = re.match(r'^\s+lda #\$([0-9A-F]{4})\s*$', L[i + 2])
                if s and m2 and re.match(rf'^\s+sta \$43{s.group(1)}2(,b)?\s*$', L[i + 3]):
                    out.append(('dma', f, i + 1, int(m.group(1), 16) << 16 | int(m2.group(1), 16)))
            if re.match(r'^\s+(jsl|jsr)\s+\w+\s*(;.*)?$', l):
                k = i + 1
                while k < len(L) and not L[k].strip():
                    k += 1
                d = re.match(r'^\s+\.(word|long|addr)\s+([^;]*)', L[k]) if k < len(L) else None
                if d:
                    for v in (x.strip() for x in d.group(2).split(',')):
                        if re.fullmatch(r'\$[0-9A-Fa-f]{4}', v) and int(v[1:], 16) >= 0x8000 or re.fullmatch(r'\$[0-9A-Fa-f]{6}', v):
                            out.append(('inline', f, k + 1, int(v[1:], 16)))
    for kind, f, n, t in out:
        where = label(t) if len(f'{t:X}') == 6 and t >> 16 >= 0x80 else '(a bank $7E address if the callee takes one)'
        print(f'{kind:8} {f}:{n}  ${t:06X}  {where}')
    if out:
        print(f'{len(out)} raw addresses')


if __name__ == '__main__':
    main()
