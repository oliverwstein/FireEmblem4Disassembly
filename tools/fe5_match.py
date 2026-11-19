#!/usr/bin/env python3
"""Match FE4 routines with routines the FE5 disassembly names.

usage: tools/fe5_match.py FE5_DIR [--rom FE5_ROM] [--all] [--min SCORE] [--min-length N]
                          [--range FE4LO-FE4HI:FE5LO-FE5HI ...]

FE5 (Thracia 776) was built on FE4's engine and kept some of its code (the
unit window, the low-level frame and PPU routines). FE5_DIR is a checkout of
github.com/ZaneAvernathy/FireEmblem5; FE5_ROM is a headerless FE5 ROM (the
Japanese release; the Nintendo Power dump has the same code at the same
addresses). Neither belongs in this repository.

Every routine is reduced to its instructions, each written as mnemonic plus
addressing mode (lda absx, sep imm8 #$20), so that relocated addresses and
different names do not matter. Two scores, each the difflib ratio of the two
sequences (1.00 is the same code):

  source  from the source text of both projects: FE5's routines, ours from
          engine/. Works for routines with inline data.
  bytes   decoded from the ROMs (fe4.sfc with labels.txt from ./build.sh, and
          FE5_ROM), following rep/sep. Covers the routines FE5 only declares
          by address (rlDMAByStruct :?= address($80xxxx)), about 290 more.
          Routines with inline data decode badly and get no score.

The report lists our routines (only Unknown ones unless --all) whose best
match scores at least --min (default 0.9), with the runner-up and both lengths.
Routines shorter than --min-length instructions (default 10) are left out:
small wrappers (lda, sta, jsl) match each other everywhere. A match is a
lead, not a name: short routines match each other by accident (a 6-instruction
routine scores high against many), and a runner-up close to the best means the
code is generic. Read both before renaming. Checked against routines named in
both projects, scores of 0.95 and up were the same routine every time except
one-instruction stubs; below 0.8 most matches were coincidences.

--range aligns two runs of routines in address order, for code FE5 kept as a
block (the unit window is $80/C400-CE00 here and $80/C600-D100 in FE5, and
$8B/B400-CF40 here and $90/C300-E100 in FE5). It prints every routine of ours
in the range with its two best matches in FE5's range; order is strong evidence
for a moderate score.
"""
import argparse, bisect, collections, difflib, glob, os, re, sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from disasm import OPS, SIZE

LABEL = re.compile(r'^\s*([A-Za-z]\w*)\b[^;]*;\s*([0-9A-F]{2})/?([0-9A-F]{4})\s*$')
DECLARED = re.compile(r'^\s*(r[ls]\w+)\s*:\?=\s*address\(\$([0-9A-F]{6})\)', re.M)
ENDS = {'rts', 'rtl', 'rti', 'stp', 'bra', 'brl', 'jml', 'jmp'}
MNEMONICS = {m for m, _ in OPS}


def hirom(a):
    return a & 0x3FFFFF


def lorom(a):
    return ((a & 0x7F0000) >> 1) | (a & 0x7FFF)


def source_token(line):
    """mnemonic + rough addressing mode for one source line, or None."""
    code = line.split(';')[0].strip()
    if not code:
        return None
    parts = code.split(None, 1)
    m, op = parts[0].lower(), (parts[1].strip() if len(parts) > 1 else '')
    if m in ('inc', 'dec') and op in ('x', 'y'):
        return {'inc': 'in', 'dec': 'de'}[m] + op
    if m not in MNEMONICS:
        return None
    if m in ('rep', 'sep'):
        return m + op.replace(' ', '').upper()
    if m[0] == 'b' and m != 'bit':
        return m
    if not op or op == 'a':
        return m
    if op.startswith('#'):
        return m + '#'
    if op.startswith('['):
        return m + ('[]y' if op.endswith(',y') else '[]')
    if op.startswith('('):
        return m + ('(),y' if op.endswith(',y') else '(,x)' if ',x' in op else '()')
    return m + (',x' if op.endswith(',x') else ',y' if op.endswith(',y') else '')


def source_routines(files):
    """{name: (address, m8, x8, [tokens])} for top-level rl/rs labels."""
    out = {}
    for f in files:
        lines = open(f, encoding='utf-8', errors='replace').read().split('\n')
        cur = None
        for i, line in enumerate(lines):
            m = LABEL.match(line)
            if m:
                cur = None
                if m.group(1)[:2] in ('rl', 'rs'):
                    m8 = x8 = False
                    for k in lines[i + 1:i + 14]:
                        k = k.strip()
                        m8 |= k == '.as'
                        x8 |= k == '.xs'
                        if k and not k.startswith(('.', ';')):
                            break
                    cur = m.group(1)
                    out[cur] = (int(m.group(2) + m.group(3), 16), m8, x8, [])
                continue
            if cur and (t := source_token(line)):
                out[cur][3].append(t)
    return out


def decode(rom, off, addr, m8, x8, end=None, cap=1500):
    """Tokens from the ROM, following rep/sep. Without END, stops at a return or
    jump once no forward branch is pending. None if it runs into brk."""
    pc, toks, fwd = addr, [], 0
    while len(toks) < cap and (end is None or pc < end):
        mn, mode = OPS[rom[off(pc)]]
        size = SIZE[mode] - (1 if (mode == 'immm' and m8) or (mode == 'immx' and x8) else 0)
        arg = rom[off(pc) + 1:off(pc) + 1 + size]
        if mn == 'brk':
            return None
        t = f'{mn} {mode}'
        if mn in ('rep', 'sep'):
            t += f' #${arg[0]:02X}'
            on = mn == 'sep'
            m8 = on if arg[0] & 0x20 else m8
            x8 = on if arg[0] & 0x10 else x8
        if mode == 'rel8':
            fwd = max(fwd, pc + 2 + (arg[0] - 256 if arg[0] > 127 else arg[0]))
        toks.append(t)
        pc += 1 + size
        if end is None and mn in ENDS and pc > fwd:
            break
    return toks


def ratio(a, b):
    return difflib.SequenceMatcher(None, a, b, autojunk=False).ratio()


class Index:
    """Candidates by shared runs of four tokens, scored by ratio."""

    def __init__(self, seqs):
        self.seqs, self.index = seqs, collections.defaultdict(set)
        for n, t in seqs.items():
            for g in self.grams(t):
                self.index[g].add(n)

    @staticmethod
    def grams(t):
        return {tuple(t[i:i + 4]) for i in range(len(t) - 3)}

    def best(self, t, k=2, among=None):
        if among is not None:
            cands = among
        else:
            count = collections.Counter()
            for g in self.grams(t):
                if len(self.index[g]) < 40:
                    count.update(self.index[g])
            cands = [n for n, _ in count.most_common(8)]
        return sorted(((ratio(t, self.seqs[n]), n) for n in cands), reverse=True)[:k]


def main():
    ap = argparse.ArgumentParser(description=__doc__.split('\n')[0])
    ap.add_argument('fe5_dir')
    ap.add_argument('--rom', help='FE5 ROM, for the bytes score')
    ap.add_argument('--all', action='store_true', help='also list routines that already have names')
    ap.add_argument('--min', type=float, default=0.9)
    ap.add_argument('--min-length', type=int, default=10)
    ap.add_argument('--range', action='append', default=[], help='FE4LO-FE4HI:FE5LO-FE5HI, hex')
    args = ap.parse_args()

    fe5_files = glob.glob(os.path.join(args.fe5_dir, '**', '*.asm'), recursive=True)
    fe5 = source_routines(fe5_files)
    fe4 = source_routines(glob.glob('engine/**/*.asm', recursive=True))
    declared = {}
    for f in fe5_files:
        for m in DECLARED.finditer(open(f, encoding='utf-8', errors='replace').read()):
            declared.setdefault(m.group(1), int(m.group(2), 16))
    src5 = Index({n: v[3] for n, v in fe5.items() if len(v[3]) >= 6})
    src4 = {n: v[3] for n, v in fe4.items() if len(v[3]) >= 6}

    byte5 = byte4 = None
    if args.rom:
        rom5, rom4 = open(args.rom, 'rb').read(), open('fe4.sfc', 'rb').read()
        if rom5[0x7FC0:0x7FCB] != b'FIREEMBLEM5':
            raise SystemExit(f'{args.rom}: not an FE5 ROM (no FIREEMBLEM5 title at $7FC0)')
        starts = sorted({int(p[1], 16) for p in (l.split() for l in open('labels.txt', encoding='utf-8'))
                         if len(p) == 3 and p[0] == 'al' and ':' not in p[2] and int(p[1], 16) >= 0x800000})
        entries5 = {n: (a, m8, x8) for n, (a, m8, x8, _) in fe5.items()}
        for n, a in declared.items():
            entries5.setdefault(n, (a, False, False))
        seqs = {n: decode(rom5, lorom, a, m8, x8) for n, (a, m8, x8) in entries5.items()}
        byte5 = Index({n: t for n, t in seqs.items() if t and len(t) >= 6})
        byte4 = {}
        for n, (a, m8, x8, _) in fe4.items():
            i = bisect.bisect_right(starts, a)
            end = starts[i] if i < len(starts) and starts[i] >> 16 == a >> 16 else None
            t = decode(rom4, hirom, a, m8, x8, end)
            if t and len(t) >= 6:
                byte4[n] = t
        print(f'FE5: {len(fe5)} routines in the source, {len(declared)} declared by address; '
              f'{len(byte5.seqs)} decode from the ROM. Ours: {len(src4)} by source, {len(byte4)} by bytes.\n')

    def addr5(n):
        return fe5[n][0] if n in fe5 else declared.get(n, 0)

    for spec in args.range:
        (lo4, hi4), (lo5, hi5) = [[int(x, 16) for x in half.split('-')] for half in spec.split(':')]
        print(f'## ${lo4:06X}-${hi4:06X} against FE5 ${lo5:06X}-${hi5:06X}')
        among_s = [n for n in src5.seqs if lo5 <= addr5(n) < hi5]
        among_b = [n for n in (byte5.seqs if byte5 else ()) if lo5 <= addr5(n) < hi5]
        for a, n in sorted((v[0], n) for n, v in fe4.items() if lo4 <= v[0] < hi4):
            cols = []
            if n in src4 and among_s:
                cols += [f'source {s:.2f} {m}@{addr5(m) & 0xFFFF:04X}' for s, m in src5.best(src4[n], 2, among_s)]
            if byte4 and n in byte4 and among_b:
                cols += [f'bytes {s:.2f} {m}@{addr5(m) & 0xFFFF:04X}' for s, m in byte5.best(byte4[n], 2, among_b)]
            print(f'  {a >> 16:02X}/{a & 0xFFFF:04X} {n:34} ' + ('  '.join(cols) or '(no score)'))
        print()

    rows = []
    for n, v in fe4.items():
        if not args.all and 'Unknown' not in n:
            continue
        found = {}
        if len(v[3]) < args.min_length:
            continue
        if n in src4:
            found['source'] = src5.best(src4[n])
        if byte4 and n in byte4:
            found['bytes'] = byte5.best(byte4[n])
        for kind, best in found.items():
            if best and best[0][0] >= args.min and (args.all or 'Unknown' not in best[0][1]):
                second = best[1][0] if len(best) > 1 else 0
                seq = (src5 if kind == 'source' else byte5).seqs[best[0][1]]
                mine = (src4 if kind == 'source' else byte4)[n]
                rows.append((best[0][0], n, v[0], best[0][1], kind, second, f'{len(mine)}/{len(seq)}'))
    seen = set()
    print(f'## Best matches scoring {args.min} or more')
    for s, n, a, m, kind, second, lengths in sorted(rows, key=lambda r: (-r[0], r[2])):
        if (n, m) in seen:
            continue
        seen.add((n, m))
        both = [r[4] for r in rows if r[1] == n and r[3] == m]
        print(f'  {s:.2f} ({"+".join(both)}, runner-up {second:.2f}, {lengths}) {a >> 16:02X}/{a & 0xFFFF:04X} {n:30} '
              f'FE5 {m} {addr5(m) >> 16:02X}/{addr5(m) & 0xFFFF:04X}{" (declared)" if m not in fe5 else ""}')


if __name__ == '__main__':
    main()
