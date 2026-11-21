#!/usr/bin/env python3
"""Write the battle animation move programs (bank $97) as labelled source.

usage: tools/battle_moves.py [--write] [--self-test]

Decodes what aBattleAnimationPrograms ($97/C8E4) points at in the original ROM
(fe4.sfc): for each of its 46 entries (entry 0 is a placeholder) a list table,
an action table and a script table (formats in include/BattleAnimation.h):

  action table: a byte per action, up to the next structure: bit 7 set picks a
    move list, otherwise it is a sequence to play without moving;
  list table: word offsets, up to the lowest offset it points to; a list is
    words up to a $7F byte (rlUnknown95DB8A queues them; rlUnknown95DA1D
    plays them): low byte the movement (a script with bit 7, $7E none, else a
    move routine; the jumps, 0, 10, 11, 12, 13 and 15, take the next word:
    frames and the height of the arc), high byte the sequence (bit 15 on script steps);
  script table: word offsets, up to the lowest one; a script is signed bytes up
    to the next structure (the last ends where the table rsUnknown95B84E reads
    at $97/E8FB begins).

Entry 43's action bytes are all sequences, so its list and script pointers
are never followed; both point at entry 44's action table and are written so.

Before writing it checks that the structures cover $97/CA8B-$97/E8FA exactly,
without overlaps, that every list and script reference is in range, that every
movement is a script, $7E or one of the 18 routines, that no argument word is
missing, and that bit 15 is set exactly on script steps.

--write writes data/battle_animation/moves.asm, places it in build.asm and
builds; run tools/raw_addresses.py --write afterwards for the table's pointers.
--self-test (after --write) adds a step to a move list in the middle of the
region in a temporary copy, builds, and checks that every entry decodes the
same through aBattleAnimationPrograms except for that step, and that entries
after it moved.
"""
import argparse
import bisect
import collections
import os
import re
import shutil
import subprocess
import sys
import tempfile
import textwrap

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from decompress import rom_offset
from battle_frames import Rom, CATEGORIES, LOOKUP, LOOKUP_COUNT, DANCE_FIRST_ID

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
TABLE = 0x97C8E4                 # aBattleAnimationPrograms
PROGRAM_INDICES = 0x97C884       # aBattleAnimationProgramIndices
ENTRIES = 47
REGION = (0x97CA8B, 0x97E8FB)
UNFOLLOWED = 43                  # entry whose lists and scripts are never read
ROUTINES = 18
ARG_ROUTINES = {0, 10, 11, 12, 13, 15}   # the jumps: the next word is (frames, height)
ROUTINE_NAMES = ['JumpPastOpponent', 'HopToOpponent', 'LeapToOpponent', 'Advance80', 'CoastLinear',
                 'CoastHalving', 'GlideToOpponent', 'NoDefaultGravity', 'ToOpponentSpeedA', 'ToOpponentSpeedB',
                 'JumpToOpponent', 'JumpInPlace', 'JumpTo40', 'JumpTo80', 'AdvancePastOpponent', 'JumpTo16',
                 'LaunchAwayFromAttacker', 'Drift']


class Decoded:
    def __init__(self, rom, table=TABLE, end=REGION[1]):
        self.rom = rom
        self.end = end
        self.entries = [tuple(rom.long(table + 9 * k + 3 * i) for i in range(3)) for k in range(ENTRIES)]
        self.problems = []
        self.lists = {}          # list table -> [list addresses]
        self.scripts = {}        # script table -> [script addresses]
        for k, (A, B, C) in enumerate(self.entries[1:], 1):
            if k == UNFOLLOWED:
                continue
            self.lists[A] = [A + o for o in self.wtable(A)]
            self.scripts[C] = [C + o for o in self.wtable(C)]
        self.ends = {}           # every structure start -> end
        for A, ls in self.lists.items():
            self.ends[A] = A + 2 * len(ls)
            for a in ls:
                x = a
                while rom.byte(x) != 0x7F:
                    x += 2
                self.ends[a] = x + 1
        for C in self.scripts:
            self.ends[C] = C + 2 * len(self.scripts[C])
        starts = sorted(set(self.ends) | {B for _, B, _ in self.entries[1:]}
                        | {a for ss in self.scripts.values() for a in ss} | {end})
        self.starts = starts

        def nxt(a):
            return starts[bisect.bisect_right(starts, a)]
        for _, B, _ in self.entries[1:]:
            self.ends[B] = nxt(B)
        for ss in self.scripts.values():
            for a in ss:
                self.ends.setdefault(a, nxt(a))

    def wtable(self, base):
        lo, out = 1 << 16, []
        while 2 * len(out) < lo:
            v = self.rom.word(base + 2 * len(out))
            out.append(v)
            lo = min(lo, v)
        return out

    def steps(self, a):
        """A move list as (kind, sequence, value, argument) steps."""
        r, x, out = self.rom, a, []
        words = []
        while r.byte(x) != 0x7F:
            words.append(r.word(x))
            x += 2
        i = 0
        while i < len(words):
            w = words[i]
            lo, seq = w & 0xFF, w >> 8 & 0x3F
            if lo & 0x80:
                out.append(('script', seq, lo & 0x7F, w >> 14, None))
            elif lo == 0x7E:
                out.append(('still', seq, None, w >> 14, None))
            else:
                arg = None
                if lo in ARG_ROUTINES and i + 1 < len(words):
                    i += 1
                    arg = words[i]
                out.append(('routine', seq, lo, w >> 14, arg))
            i += 1
        return out

    def content(self):
        r = self.rom
        out = []
        for k, (A, B, C) in enumerate(self.entries[1:], 1):
            acts = bytes(r.byte(x) for x in range(B, self.ends[B]))
            if k == UNFOLLOWED:
                out.append((acts, A == B + len(acts) == C))
                continue
            out.append((acts, [self.steps(a) for a in self.lists[A]],
                        [bytes(r.byte(x) for x in range(a, self.ends[a])) for a in self.scripts[C]]))
        return out


def check(d, cdl):
    problems = list(d.problems)
    r = d.rom
    own = collections.defaultdict(list)
    for a, e in d.ends.items():
        for x in range(a, e):
            own[x].append(a)
    span = sorted(own)
    if (span[0], span[-1] + 1) != REGION or len(span) != REGION[1] - REGION[0]:
        problems.append(f'decoded bytes ${span[0]:06X}-${span[-1]:06X} ({len(span)}) are not the region')
    for x, o in own.items():
        if len(set(o)) > 1:
            problems.append(f'${x:06X} is in more than one structure')
            break
    for x in range(*REGION):
        if cdl[x & 0x3FFFFF] & 0x02 and x not in own:
            problems.append(f'${x:06X}: read in the log but not decoded')
    for k, (A, B, C) in enumerate(d.entries[1:], 1):
        acts = [r.byte(x) for x in range(B, d.ends[B])]
        if k == UNFOLLOWED:
            if any(v & 0x80 for v in acts) or not (A == C == d.ends[B]):
                problems.append(f'entry {k}: its list or script table is used')
            continue
        for v in acts:
            if v & 0x80 and (v & 0x7F) >= len(d.lists[A]):
                problems.append(f'entry {k}: action ${v:02X} past its lists')
        for a in d.lists[A]:
            words = (d.ends[a] - 1 - a) // 2
            n = 0
            for kind, seq, val, flags, arg in d.steps(a):
                n += 1 + (arg is not None)
                if kind == 'script' and (val >= len(d.scripts[C]) or flags != 2):
                    problems.append(f'entry {k}: list ${a:06X} script step ${val:02X} flags {flags}')
                if kind != 'script' and flags:
                    problems.append(f'entry {k}: list ${a:06X}: flags on a step without a script')
                if kind == 'routine' and (val >= ROUTINES or (val in ARG_ROUTINES and arg is None)):
                    problems.append(f'entry {k}: list ${a:06X}: routine {val} (argument {arg})')
            if n != words:
                problems.append(f'entry {k}: list ${a:06X} does not parse')
    return problems


def names(rom):
    classes = [l.split(',')[0] for l in open(os.path.join(ROOT, 'data/class/ClassData.csv')).read().split('\n')[1:] if l.strip()]
    users = collections.defaultdict(list)
    for k in range(LOOKUP_COUNT):
        rec = [rom.byte(LOOKUP + 8 * k + i) for i in range(8)]
        users[rom.byte(PROGRAM_INDICES + rec[4] + 1)].append((classes[rec[0]], rec[1]))
    users[rom.byte(PROGRAM_INDICES + DANCE_FIRST_ID + 1)].append(('Dancer', 'Dance'))
    out = {}
    for k in range(1, ENTRIES):
        if users[k]:
            c, cat = users[k][0]
            out[k] = c + ('Dance' if cat == 'Dance' else CATEGORIES.get(cat, f'Category{cat}'))
        else:
            out[k] = f'Unknown{k:02d}'
    assert len(set(out.values())) == len(out), out
    return out, users


def emit(d):
    r = d.rom
    nm, users = names(r)
    lines = ['    .section BattleAnimationMoveDataSection', '']
    lab = {}
    for k, (A, B, C) in enumerate(d.entries[1:], 1):
        lab[B] = f'aBattleAnimationActions{nm[k]}'
        if k != UNFOLLOWED:
            lab[A] = f'aBattleAnimationMoveLists{nm[k]}'
            lab[C] = f'aBattleAnimationMoveScripts{nm[k]}'
    for k, (A, B, C) in enumerate(d.entries[1:], 1):
        us = []
        for c, cat in users[k]:
            n = f'{c} (dancing)' if cat == 'Dance' else f'{c} ({CATEGORIES.get(cat, cat)})'
            if n not in us:
                us.append(n)
        lines += [f'      {lab[B]} ; {B >> 16:02X}/{B & 0xFFFF:04X}', '']
        text = (f'Move program of entry {k} of aBattleAnimationPrograms'
                + (f', used by: {", ".join(us)}.' if us else '; nothing selects it.'))
        if k == UNFOLLOWED:
            text += (' Its actions are all single sequences, so its list and script pointers are never'
                     ' followed; both point at the next entry\'s action table.')
        lines += ['        ; ' + l for l in textwrap.wrap(text, 88)] + ['']
        for i in range(B, d.ends[B]):
            v = r.byte(i)
            lines.append(f'        ANIM_ACTION_LIST {v & 0x7F}' if v & 0x80 else f'        ANIM_ACTION_SEQUENCE {v}')
        lines.append('')
        if k == UNFOLLOWED:
            continue
        lines += [f'      {lab[A]} ; {A >> 16:02X}/{A & 0xFFFF:04X}', '']
        first = {}
        for j, a in enumerate(d.lists[A]):
            first.setdefault(a, j)
        for j, a in enumerate(d.lists[A]):
            lines.append(f'        .word _List{first[a]:02d} - {lab[A]}')
        lines.append('')
        for a in sorted(set(d.lists[A])):
            lines.append(f'      _List{first[a]:02d}')
            for kind, seq, val, flags, arg in d.steps(a):
                if kind == 'script':
                    lines.append(f'        ANIM_MOVE_SCRIPT {seq}, {val}')
                elif kind == 'still':
                    lines.append(f'        ANIM_MOVE_STILL {seq}')
                elif arg is None:
                    lines.append(f'        ANIM_MOVE_ROUTINE {seq}, AnimMove{ROUTINE_NAMES[val]}')
                else:
                    lines.append(f'        ANIM_MOVE_JUMP {seq}, AnimMove{ROUTINE_NAMES[val]}, {arg & 0xFF}, {arg >> 8}')
            lines += ['        ANIM_MOVE_LIST_END', '']
        lines += [f'      {lab[C]} ; {C >> 16:02X}/{C & 0xFFFF:04X}', '']
        firsts = {}
        for j, a in enumerate(d.scripts[C]):
            firsts.setdefault(a, j)
        for a in d.scripts[C]:
            lines.append(f'        .word _Script{firsts[a]:02d} - {lab[C]}')
        lines.append('')
        for a in sorted(set(d.scripts[C])):
            lines.append(f'      _Script{firsts[a]:02d}')
            bs = [r.byte(x) for x in range(a, d.ends[a])]
            vals = [b - 0x100 if b & 0x80 else b for b in bs]
            for q in range(0, len(vals), 16):
                lines.append('        .char ' + ', '.join(str(v) for v in vals[q:q + 16]))
            lines.append('')
    lines += ['    .endsection BattleAnimationMoveDataSection', '']
    return lines, lab


def place(write):
    path = os.path.join(ROOT, 'build.asm')
    b = open(path, encoding='utf-8').read().split('\n')
    sec = 'BattleAnimationMoveDataSection'
    if not any(f'.dsection {sec}' in l for l in b):
        starts = [(i, int(m.group(1), 16)) for i, l in enumerate(b) if (m := re.match(r'\s*\* = \$([0-9A-Fa-f]+)', l))]
        off = rom_offset(REGION[0])
        nxt = min((s for s in starts if s[1] > off), key=lambda t: t[1])
        b[nxt[0]:nxt[0]] = [f'    * = ${off:06X}', f'    .logical ${REGION[0]:06X}', '',
                            f'      .dsection {sec}', '', '    .here', '']
    inc = '  .include "data/battle_animation/moves.asm"'
    if inc not in b:
        k = max(i for i, l in enumerate(b) if l.startswith('  .include "'))
        b[k + 1:k + 1] = [inc]
    if write:
        open(path, 'w', encoding='utf-8').write('\n'.join(b))


def self_test():
    orig = Decoded(Rom(open(os.path.join(ROOT, 'fe4.sfc'), 'rb').read()))
    tmp = tempfile.mkdtemp(prefix='battle_moves_')
    try:
        src = os.path.join(tmp, 'src')
        subprocess.run(['rsync', '-a', '--exclude', '.git', '--exclude', '*.smc', '--exclude', '*.sfc',
                        './', src + '/'], cwd=ROOT, check=True)
        shutil.copy(os.path.join(ROOT, 'fe4.sfc'), os.path.join(src, 'fe4.sfc'))
        p = os.path.join(src, 'data/battle_animation/moves.asm')
        lines = open(p).read().split('\n')
        ends = [i for i, l in enumerate(lines) if l.strip() == 'ANIM_MOVE_LIST_END']
        i = ends[len(ends) // 2]
        lines.insert(i, '        ANIM_MOVE_STILL 0')
        open(p, 'w').write('\n'.join(lines))
        subprocess.run(['./build.sh'], cwd=src, capture_output=True, text=True)
        built = os.path.join(src, 'FE4Disassembly.sfc')
        if not os.path.exists(built):
            raise SystemExit('self-test: the edited copy did not build')
        lab = {}
        for line in open(os.path.join(src, 'labels.txt')):
            q = line.split()
            if len(q) == 3 and ':' not in q[2]:
                lab.setdefault(q[2].lstrip('.'), int(q[1], 16))
        rom2 = Rom(open(built, 'rb').read())
        # The region ends where the table at $97/E8FB begins; in the copy it
        # ends that much later (the bytes past it overwrite that table, which
        # is not source yet and cannot move).
        last = TABLE + 9 * (ENTRIES - 1) + 6
        delta = rom2.long(lab['aBattleAnimationPrograms'] + 9 * (ENTRIES - 1) + 6) - orig.rom.long(last)
        new = Decoded(rom2, lab['aBattleAnimationPrograms'], REGION[1] + delta)
        over = sum(1 for x in range(REGION[1], REGION[1] + delta)
                   if rom2.byte(x) != orig.rom.byte(x))
        print(f'self-test: the region grew by {delta} bytes, over {over} changed bytes of the unbuilt table at '
              f'${REGION[1]:06X}')
        moved = sum(1 for x, y in zip(orig.entries, new.entries) if x != y)
        diffs = []
        for k, (x, y) in enumerate(zip(orig.content(), new.content()), 1):
            if x != y:
                if len(x) == 3:
                    for j, (s, t) in enumerate(zip(x[1], y[1])):
                        if s != t:
                            diffs.append((k, j, s, t))
                    if x[0] != y[0] or x[2] != y[2]:
                        diffs.append((k, 'actions or scripts', None, None))
                else:
                    diffs.append((k, 'unfollowed entry', None, None))
        print(f'self-test: added a step before line {i + 1} of moves.asm; {moved} table entries moved; '
              f'content differences: {len(diffs)}')
        ok = moved > 0 and len(diffs) == 1
        for k, j, s, t in diffs:
            print(f'  entry {k} list {j}: {len(s) if s else "?"} -> {len(t) if t else "?"} steps')
            ok = ok and isinstance(j, int) and t == s + [('still', 0, None, 0, None)]
        print('self-test passed' if ok else 'self-test FAILED')
        return ok
    finally:
        shutil.rmtree(tmp, ignore_errors=True)


def main():
    ap = argparse.ArgumentParser(description=__doc__.split('\n')[0])
    ap.add_argument('--write', action='store_true')
    ap.add_argument('--self-test', action='store_true')
    args = ap.parse_args()
    if args.self_test:
        sys.exit(0 if self_test() else 1)
    rom = Rom(open(os.path.join(ROOT, 'fe4.sfc'), 'rb').read())
    cdl = open(os.path.join(ROOT, 'fe4.cdl'), 'rb').read()[9:]
    d = Decoded(rom)
    problems = check(d, cdl)
    nl = sum(len(set(v)) for v in d.lists.values())
    ns = sum(len(set(v)) for v in d.scripts.values())
    print(f'{ENTRIES - 1} programs, {nl} move lists, {ns} movement scripts; '
          f'{REGION[1] - REGION[0]:,} bytes at ${REGION[0]:06X}-${REGION[1] - 1:06X}')
    for p in problems:
        print('problem:', p)
    if problems:
        sys.exit(1)
    print('coverage and format checks passed')
    lines, _ = emit(d)
    text = ('; Battle animation move programs: action, move list and movement script tables\n'
            '; reached from aBattleAnimationPrograms. Written by tools/battle_moves.py;\n'
            '; formats and macros in include/BattleAnimation.h.\n\n' + '\n'.join(lines))
    path = os.path.join(ROOT, 'data/battle_animation/moves.asm')
    old = open(path).read() if os.path.exists(path) else None
    print(f'data/battle_animation/moves.asm: {len(lines):,} lines' + (' (unchanged)' if old == text else ''))
    place(args.write)
    if args.write:
        open(path, 'w').write(text)
        sys.exit(subprocess.call(['./build.sh'], cwd=ROOT))


if __name__ == '__main__':
    main()
