#!/usr/bin/env python3
"""Write the battle scene's palette effect entries as PALETTE_EFFECT_* macros.

usage: tools/palette_effects.py [--write]

rlBattleSceneStartPaletteEffect (bank $96) takes a long pointer in lR18 to one
entry: the slot (0-9), the type (bits 0-5; rlUnknown96D695 runs the slot by
it), the first color in aBGPaletteBuffer and the color count, then by type:

  types 0-2, 10, 12   a long pointer (PALETTE_EFFECT)
  types 3-6           one byte (PALETTE_EFFECT_VALUE)
  type 7              one byte and a long pointer (PALETTE_EFFECT_VALUE_DATA)
  types 8, 9, 11      nothing more (PALETTE_EFFECT_NO_DATA)

The macros are in include/BattleScene.h. The entries are found through the
offset table of script command 11 (aBattleScenePaletteEffects, $97/A9A8) and
through every `lda #<>label` / `sta lR18` before a call. An entry is rewritten
when its label is followed by `.byte` rows that start with it; bytes after it
up to the next label stay `.byte` rows. A
pointer is written as the label at its address; pointers into the ROM with no
label are listed (give them one with tools/label_data.py and run again).
Without --write it only reports. Run ./build.sh afterwards.
"""
import collections, glob, os, re, sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from asmlib import read_rom, offset

TABLE = 'aBattleScenePaletteEffects'
CALL = re.compile(r'^\s+jsl rlBattleSceneStartPaletteEffect\b')
LOW = re.compile(r'^\s+lda #<>([\w.]+)\s*$')
DEF = re.compile(r'^      ([A-Za-z_]\w*) ; ([0-9A-F]{2})/([0-9A-F]{4})\s*$')
BYTES = re.compile(r'^\s+\.byte ((?:\$[0-9A-F]{2}(?:, )?)+)\s*$')


def labels():
    """{address: name} from labels.txt (top-level names first)."""
    names = {}
    for line in open('labels.txt', encoding='utf-8'):
        p = line.split()
        if len(p) != 3:
            continue
        a, n = int(p[1], 16), p[2].lstrip('.').replace(':', '.')
        if a not in names or (n.count('.') < names[a].count('.')):
            names[a] = n
    return names


def decode(rom, addr):
    p = offset(addr)
    slot, kind, first, count = rom[p:p + 4]
    t = kind & 0x3F
    long_at = lambda q: rom[q] | rom[q + 1] << 8 | rom[q + 2] << 16
    if t in (0, 1, 2, 10, 12):
        return ('PALETTE_EFFECT', [slot, kind, first, count], long_at(p + 4)), 7
    if t in (3, 4, 5, 6):
        return ('PALETTE_EFFECT_VALUE', [slot, kind, first, count, rom[p + 4]], None), 5
    if t == 7:
        return ('PALETTE_EFFECT_VALUE_DATA', [slot, kind, first, count, rom[p + 4]], long_at(p + 5)), 8
    return ('PALETTE_EFFECT_NO_DATA', [slot, kind, first, count], None), 4


def main():
    write = '--write' in sys.argv
    rom = read_rom()
    names = labels()
    by_name = collections.defaultdict(list)
    for a, n in names.items():
        by_name[n].append(a)
    files = sorted(glob.glob('engine/**/*.asm', recursive=True))
    text = {f: open(f, encoding='utf-8').read().split('\n') for f in files}

    # The entries' addresses.
    entries = set()
    for f, lines in text.items():
        for i, l in enumerate(lines):
            m = re.match(r'^\s+\.word ([\w.]+) - ' + TABLE + r'\s*$', l)
            if m and m.group(1) in by_name:
                entries.update(by_name[m.group(1)])
            if m and m.group(1).lstrip('_') and m.group(1) not in by_name:
                full = TABLE + '.' + m.group(1)
                entries.update(by_name.get(full, []))
            if CALL.match(l):
                for k in range(i - 1, max(i - 12, 0), -1):
                    m = LOW.match(lines[k])
                    if m:
                        entries.update(by_name.get(m.group(1), []))
                        break
    entries = {a for a in entries if 0x800000 <= a < 0xC00000 or a >= 0xC00000}

    unlabelled, done, skipped, already = set(), 0, [], 0
    for f, lines in text.items():
        changed = False
        for i, l in enumerate(lines):
            m = DEF.match(l) if l is not None else None
            if not m:
                continue
            a = int(m.group(2) + m.group(3), 16)
            if a not in entries:
                continue
            (macro, args, ptr), size = decode(rom, a)
            rows, k = [], i + 1
            while k < len(lines) and lines[k] is not None and not lines[k].strip():
                k += 1
            if k < len(lines) and lines[k] is not None and lines[k].lstrip().startswith('PALETTE_EFFECT'):
                already += 1
                continue
            while k < len(lines) and lines[k] is not None and BYTES.match(lines[k]):
                rows.append(k); k += 1
            got = [int(x[1:], 16) for r in rows for x in BYTES.match(lines[r]).group(1).split(', ')]
            if len(got) < size:
                skipped.append(f'{m.group(1)} {m.group(2)}/{m.group(3)}: {len(got)} bytes, entry {size}')
                continue
            rest = got[size:]
            ops = [f'${v:02X}' for v in args]
            if ptr is not None:
                if ptr in names:
                    ops.append(names[ptr])
                elif ptr >= 0x7E0000 and ptr < 0x800000:
                    ops.append(f'${ptr:06X}')
                else:
                    unlabelled.add(ptr); ops.append(f'${ptr:06X}')
            indent = re.match(r'^\s*', lines[rows[0]]).group(0)
            lines[rows[0]] = f'{indent}{macro} ' + ', '.join(ops)
            if rest:
                # Bytes after the entry that nothing reads as part of it.
                lines[rows[0]] += ''.join(f'\n{indent}.byte ' + ', '.join(f'${v:02X}' for v in rest[j:j + 16])
                                          for j in range(0, len(rest), 16))
            for r in rows[1:]:
                lines[r] = None
            changed = True; done += 1
        if changed and write:
            open(f, 'w', encoding='utf-8').write('\n'.join(x for x in lines if x is not None))
    print(f'{len(entries)} entries, {already} already macros, {done} rewritten, {len(skipped)} skipped, '
          f'{len(unlabelled)} ROM pointers without a label')
    for s in skipped:
        print('  skipped', s)
    if unlabelled:
        print('  no label:', ' '.join(f'{a:06X}' for a in sorted(unlabelled)))


if __name__ == '__main__':
    main()
