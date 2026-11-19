#!/usr/bin/env python3
"""Look for code in the gaps that nothing in the build points to.

usage: tools/sweep.py [--banks 80-91,9E,9F] [--write FILE] [--min-score N] [--list]

For each gap in the $8000-$FFFF half of the given banks (bytes that still come
from the base ROM), this decodes from the start of the gap, and again right after
each routine it accepts, first with 16-bit registers and then 8-bit. A candidate
is accepted when it:
  - ends with rts, rtl, rti, jmp, jml, bra or brl, inside the gap;
  - has no brk, cop, wdm, stp or xce, and no branch into its own instructions;
  - calls (jsr, jsl, jmp, jml) only known routine starts or places in gaps;
  - is at least 6 bytes long;
  - does not start like a proc header or a table of word or long pointers.
Calls into gaps are queued as further starting points.

Each routine gets a score: the number of calls to known routines plus the number
of operands that are named RAM variables. Nothing in the build reaches these
routines, so the score is the evidence that they are code; --write writes those
with at least --min-score (default 3) to FILE as a routines file for
test_routines.py and place_routines.py. --list shows every candidate.
"""
import argparse, os, sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from asmlib import read_rom, offset
from disasm import Disassembler, load_labels
from trace import ODD, coverage_mask


def parse_banks(text):
    out = []
    for part in text.split(','):
        if '-' in part:
            a, b = (int(x, 16) for x in part.split('-'))
            out += range(a, b + 1)
        else:
            out.append(int(part, 16))
    return out


def gaps(mask, bank):
    lo = offset(bank << 16 | 0x8000)
    hi = lo + 0x8000
    o = lo
    while o < hi:
        if mask[o]:
            o += 1
            continue
        e = o
        while e < hi and not mask[e]:
            e += 1
        yield (bank << 16) | (o & 0xFFFF) | 0x8000, (bank << 16) | ((e - 1) & 0xFFFF | 0x8000) + 1
        o = e


def main():
    ap = argparse.ArgumentParser(description=__doc__.split('\n')[0])
    ap.add_argument('--banks', default='80-91,9E,9F')
    ap.add_argument('--write', metavar='FILE')
    ap.add_argument('--min-score', type=int, default=3)
    ap.add_argument('--list', action='store_true')
    a = ap.parse_args()

    rom, labels = read_rom(), load_labels('labels.txt')
    mask = coverage_mask()
    known = {x for x, n in labels.items() if x >= 0x800000 and any(m[:2] in ('rl', 'rs') for m in n)}
    ram_names = {x for x, n in labels.items() if x < 0x800000 and len(n) == 1}
    gap_of = {}
    for bank in parse_banks(a.banks):
        for s, e in gaps(mask, bank):
            gap_of[s] = e

    def gap_end(x):
        for s, e in gap_of.items():
            if s <= x < e:
                return e
        return None

    def looks_like_data(start):
        """A proc header, or a table of word or long pointers into nearby code."""
        o = offset(start)
        b = rom[o:o + 12]
        bank = start >> 16
        if all(0x20 <= x < 0x7F for x in b[:2]) and (b[2] | b[3] << 8) == (start + 8) & 0xFFFF:
            return True
        words = [b[i] | b[i + 1] << 8 for i in range(0, 6, 2)]
        if all(0x8000 <= v and abs(v - (start & 0xFFFF)) < 0x1000 for v in words):
            return True
        longs = [(b[i + 2], b[i] | b[i + 1] << 8) for i in range(0, 9, 3)]
        if all(k == longs[0][0] and (0x80 <= k <= 0xBF or k >= 0xC0) and v >= 0x8000 for k, v in longs):
            return True
        return False

    def try_decode(start, end):
        if looks_like_data(start):
            return None
        for m8, x8 in ((False, False), (True, False), (False, True), (True, True)):
            d = Disassembler(rom, labels, start, None, m8, x8)
            insns, _ = d.decode()
            if d.stop_pc > end or not insns or not insns[-1]['ends'] or d.stop_pc - start < 6:
                continue
            if any(i['mn'] in ODD for i in insns):
                continue
            starts = {i['pc'] for i in insns}
            if any(i['mode'].startswith('rel') and start <= (i.get('target') or 0) < d.stop_pc
                   and i['target'] not in starts for i in insns):
                continue
            calls, ok = [], True
            for i in insns:
                if i['mn'] in ('jsr', 'jsl', 'jmp', 'jml') and i['mode'] in ('absj', 'abslj'):
                    t = i['target']
                    if start <= t < d.stop_pc:
                        continue
                    if t in known:
                        calls.append(t)
                    elif gap_end(t) is None:
                        ok = False
                        break
            if not ok:
                continue
            score = len(calls) + sum(1 for i in insns if i['mode'] in ('abs', 'absx', 'absy', 'dp', 'absl', 'abslx')
                                     and i['val'] is not None and i['val'] in ram_names and i['val'] >= 0x100)
            return dict(end=d.stop_pc, m8=m8, x8=x8, score=score, insns=insns)
        return None

    found = {}
    todo = sorted(gap_of.items())
    queue = []
    for s, e in todo:
        pc = s
        while pc < e:
            r = try_decode(pc, e)
            if not r:
                break
            found[pc] = r
            for i in r['insns']:
                if i['mn'] in ('jsr', 'jsl', 'jmp', 'jml') and i['mode'] in ('absj', 'abslj'):
                    if gap_end(i['target']) and i['target'] not in found:
                        queue.append(i['target'])
            pc = r['end']
    while queue:
        t = queue.pop()
        if t in found or any(x < t < f['end'] for x, f in found.items()):
            continue
        e = gap_end(t)
        r = try_decode(t, e) if e else None
        if r:
            found[t] = r

    keep = {x: f for x, f in found.items() if f['score'] >= a.min_score}
    total = sum(f['end'] - x for x, f in found.items())
    kept = sum(f['end'] - x for x, f in keep.items())
    print(f'{len(found)} candidates ({total:,} bytes); {len(keep)} with score >= {a.min_score} ({kept:,} bytes)')
    if a.list:
        for x in sorted(found):
            f = found[x]
            print(f'{x >> 16:02X}/{x & 0xFFFF:04X} {f["end"] - x:5} bytes  score {f["score"]:3}  '
                  f'{"m8" if f["m8"] else "m16"} {"x8" if f["x8"] else "x16"}')
    if a.write:
        parts = ['; Routines found by tools/sweep.py. Nothing in the build reaches them.\n']
        for x in sorted(keep):
            f = keep[x]
            d = Disassembler(rom, labels, x, f['end'], f['m8'], f['x8'])
            insns, _ = d.decode()
            mns = {i['mn'] for i in insns}
            prefix = 'rs' if 'rts' in mns and 'rtl' not in mns else 'rl'
            text = d.render(f'{prefix}Unknown{x:06X}')
            text = text.replace('\n', '\n\n        ; Found by tools/sweep.py: nothing in the build reaches this.', 1)
            parts.append(text)
        open(a.write, 'w', encoding='utf-8').write('\n'.join(parts))
        print(f'wrote {len(keep)} routines to {a.write}')


if __name__ == '__main__':
    main()
