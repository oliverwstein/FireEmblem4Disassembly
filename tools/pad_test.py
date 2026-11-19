#!/usr/bin/env python3
"""Padding test: build with N bytes inserted at the start of a section.

Usage (through build.sh, which builds and verifies first):
    ./build.sh pad SECTION N

This proves a block shiftable. It assembles a temporary copy of the repository
with N bytes of $EA (NOP) inserted just before `.dsection SECTION` in build.asm,
so SECTION and everything after it in its placement block (the code between one
`* = ...` and its `.here`) moves N bytes later, and writes FE4Padded.sfc. Then:

- it checks the block has N bytes of free space after it to grow into (filler
  bytes that no label or other block uses), and refuses if not;
- it checks every label in the block moved by N and no label outside it moved;
- it lists the bytes changed outside the block: references to the moved code
  that the assembler updated;
- it warns if anything changed inside the code the game checksums while it runs
  (include/Checksums.h), since the game would then detect the change;
- it fixes the internal header checksum of FE4Padded.sfc.

What it cannot see is a hidden address: a number in code or data that is really
an address but is written as a number, so it did not move. For that, run
FE4Padded.sfc in Mesen and play through whatever uses the block.

The padding is NOPs, so code that falls through from the previous section into
SECTION still works, as it would after a real mod.
"""

import os
import re
import shutil
import subprocess
import sys
import tempfile
from collections import defaultdict

ROM = 'fe4.sfc'
OUT = 'FE4Padded.sfc'
PAD_BYTE = 0xEA
START_LABEL = 'PadTestPadding'
END_LABEL = 'PadTestBlockEnd'

# Code the game sums while it runs (include/Checksums.h), as file offsets.
CHECKED_RANGES = [
    (0x008D56, 0x008E2C, '$80/8D56-8E2C (summed by rlCheckCodeChecksums)'),
    (0x078017, 0x0780A9, '$87/8017-80A9 (summed by rlCheckCodeChecksums)'),
    (0x088888, 0x088907, '$88/8888-8907 (checking code)'),
]


def offset(addr):
    """CPU address of a ROM label to its file offset (HiROM), or None for RAM."""
    bank = addr >> 16
    if 0x80 <= bank <= 0xBF or 0xC0 <= bank <= 0xFF:
        return addr & 0x3FFFFF
    return None


def cpu(off):
    return f'${0x80 + (off >> 16):02X}/{off & 0xFFFF:04X}'


def read_labels(path):
    labels = {}
    with open(path) as f:
        for line in f:
            m = re.match(r'al ([0-9a-fA-F]+) \.(\S+)', line)
            if m:
                labels[m.group(2)] = int(m.group(1), 16)
    return labels


def find_block(lines, section):
    """Line indices of the section's .dsection, and its block's '* =' and .here."""
    hits = [i for i, l in enumerate(lines)
            if re.match(rf'\s*\.dsection\s+{re.escape(section)}\s*(;.*)?$', l)]
    if not hits:
        sys.exit(f'No `.dsection {section}` in build.asm')
    if len(hits) > 1:
        sys.exit(f'`.dsection {section}` appears {len(hits)} times in build.asm')
    at = hits[0]
    star = next((i for i in range(at, -1, -1) if re.match(r'\s*\* = ', lines[i])), None)
    here = next((i for i in range(at, len(lines)) if re.match(r'\s*\.here\b', lines[i])), None)
    if star is None or here is None:
        sys.exit(f'{section} is not inside a `* = ...` / `.here` block in build.asm')
    return star, at, here


def block_starts(lines):
    starts = []
    for l in lines:
        m = re.match(r'\s*\* = \$([0-9A-Fa-f]+)', l)
        if m:
            starts.append(int(m.group(1), 16))
    return starts


def main():
    args = sys.argv[1:]
    if '--' in args:
        i = args.index('--')
        args, asflags = args[:i], args[i + 1:]
    else:
        asflags = ['-x', '-f', '-C', '-a']
    if len(args) != 2 or not args[1].isdigit() or int(args[1]) < 1:
        sys.exit('Usage: ./build.sh pad SECTION N   (N: bytes to insert, 1 or more)')
    section, n = args[0], int(args[1])

    lines = open('build.asm').read().split('\n')
    star, at, here = find_block(lines, section)
    block_sections = [re.match(r'\s*\.dsection\s+(\w+)', l).group(1)
                      for l in lines[star:here] if re.match(r'\s*\.dsection\s', l)]
    rom = open(ROM, 'rb').read()
    original = read_labels('labels.txt')

    def with_padding(k):
        padded_lines = list(lines)
        padded_lines[here:here] = [f'      {END_LABEL}']
        padded_lines[at:at] = [f'      {START_LABEL} .fill {k}, ${PAD_BYTE:02X}']
        return '\n'.join(padded_lines)

    # Assemble twice in a temporary copy: unpadded with the marker labels, for the
    # block's true end (a padded block that overflows its bank does not report
    # its end reliably), and padded.
    tmp = tempfile.mkdtemp()
    try:
        src = os.path.join(tmp, 'src')
        subprocess.run(['rsync', '-a', '--exclude', '.git', '--exclude', '*.smc',
                        '--exclude', 'FE4Disassembly.sfc', '--exclude', OUT,
                        './', src + '/'], check=True)
        results = []
        for k in (0, n):
            with open(os.path.join(src, 'build.asm'), 'w') as f:
                f.write(with_padding(k))
            res = subprocess.run(['64tass', *asflags, '-o', 'out.sfc', '--vice-labels',
                                  '-l', 'out_labels.txt', 'build.asm'],
                                 cwd=src, capture_output=True, text=True)
            if res.returncode:
                errors = [l for l in (res.stdout + res.stderr).split('\n')
                          if 'error' in l.lower()]
                print('\n'.join(errors[:20]) or res.stdout[-2000:], file=sys.stderr)
                hint = ('\nA negative .fill means the block has less free space at its end '
                        'than the padding.' if 'non-negative' in res.stdout + res.stderr else '')
                sys.exit('The padded build failed to assemble' + hint)
            results.append((bytearray(open(os.path.join(src, 'out.sfc'), 'rb').read()),
                            read_labels(os.path.join(src, 'out_labels.txt'))))
    finally:
        shutil.rmtree(tmp)
    (_, markers), (built, padded) = results

    s = markers[START_LABEL]           # where the section starts, and the padding goes
    e = markers[END_LABEL]             # end of the block (exclusive)
    s_off, e_off = offset(s), offset(e)
    pe_off = offset(padded[END_LABEL])  # its end once padded; a fill such as
    growth = pe_off - e_off            # `.fill $878000 - *, 0` can absorb the padding
    star_off = int(re.match(r'\s*\* = \$([0-9A-Fa-f]+)', lines[star]).group(1), 16)

    print(f'Inserted {n} bytes at {cpu(s_off)}, the start of {section}.')
    later = block_sections[block_sections.index(section):]
    plural = lambda k, word: f'{k} {word}{"s" if k != 1 else ""}'
    print(f'Block {cpu(star_off)}-{cpu(e_off)} ({plural(len(block_sections), "section")}, '
          f'end exclusive); moved: {plural(len(later), "section")}, {e_off - s_off:,} bytes.')
    if growth == n:
        print(f'The block grew by {n} and now ends at {cpu(pe_off)}.')
    else:
        print(f'The block grew by {growth}: a fill at its end absorbed '
              f'{n - growth} of the {n} bytes.')

    problems = []

    # 1. Room to grow: the bytes after the block that it grew into must be unused filler.
    starts = block_starts(lines)
    used = {offset(a) for a in original.values()} - {None}

    def free(off, fill):
        return (off < len(rom) and rom[off] == fill and off not in used
                and off not in starts and (off & 0xFFFF) != 0)  # no crossing banks

    fill = rom[e_off] if e_off < len(rom) else None
    slack = 0
    if fill in (0x00, 0xFF):
        while slack < 0x10000 and free(e_off + slack, fill):
            slack += 1
    if slack < growth:
        what = (f'{slack} free byte{"s" if slack != 1 else ""} (${fill:02X})' if slack
                else 'no free space')
        sys.exit(f'FAILED: the block has {what} after it at {cpu(e_off)}, fewer than {growth}.\n'
                 'Growing it would overwrite whatever follows. Pick a block that ends in\n'
                 'free space or a fill to its bank end (a merged bank, step 4 of\n'
                 'the plan), or a smaller N.')
    if growth:
        print(f'Room: {slack:,} free bytes (${fill:02X}) after the block; {growth} used.')

    # 2. Labels: those in the block move by n, the rest stay put.
    in_block = lambda a: offset(a) is not None and s_off <= offset(a) < e_off
    moved_ok = stayed = 0
    wrong = []
    for name, a in original.items():
        if name not in padded:
            continue
        b = padded[name]
        want = a + n if in_block(a) else a
        if b == want:
            moved_ok += in_block(a)
            stayed += not in_block(a)
        else:
            wrong.append(f'  {name}: was {a:06X}, now {b:06X}, expected {want:06X}')
    print(f'Labels: {moved_ok:,} in the block moved by {n}; {stayed:,} outside it stayed.')
    if wrong:
        problems.append(f'{len(wrong)} labels did not move as expected:\n' + '\n'.join(wrong[:15]))

    # 3. Bytes: compare the build with the original, shifting the moved range.
    def original_at(off):
        if s_off <= off < s_off + n:
            return None                       # the padding itself
        if s_off + n <= off < pe_off:
            return rom[off - n]
        return rom[off]

    for i in range(0xFFDC, 0xFFE0):           # header checksum, rewritten below
        built[i] = rom[i]
    changed = [o for o in range(len(built))
               if (want := original_at(o)) is not None and built[o] != want]
    inside = [o for o in changed if s_off + n <= o < pe_off]
    outside = [o for o in changed if not s_off + n <= o < pe_off]

    by_label = sorted((offset(a), name) for name, a in padded.items()
                      if offset(a) is not None and ':' not in name)

    def owner(off):
        best = None
        for o, name in by_label:
            if o > off:
                break
            best = name
        return best or '?'

    def groups(offs):
        g = defaultdict(list)
        for o in offs:
            g[owner(o)].append(o)
        return g

    print(f'References updated: {len(inside):,} bytes inside the block, '
          f'{len(outside):,} outside it.')
    for name, offs in sorted(groups(outside).items(), key=lambda kv: kv[1][0])[:10]:
        print(f'  {name}: {", ".join(cpu(o) for o in offs[:4])}'
              f'{f" and {len(offs) - 4} more" if len(offs) > 4 else ""}')
    if len(groups(outside)) > 10:
        print(f'  ... and {len(groups(outside)) - 10} more routines or tables')

    # 4. The game's own code checksums.
    for lo, hi, what in CHECKED_RANGES:
        hit = [o for o in range(lo, hi) if built[o] != rom[o]]
        if hit:
            problems.append(f'{len(hit)} bytes changed in checksummed code {what}; the game '
                            'will detect the change unless the sums in include/Checksums.h '
                            'are updated (step 3 of the plan).')

    # Fix the header checksum so emulators and flash carts accept the ROM.
    built[0xFFDC:0xFFE0] = b'\xFF\xFF\x00\x00'
    total = sum(built) & 0xFFFF
    built[0xFFDC:0xFFE0] = bytes([~total & 0xFF, (~total >> 8) & 0xFF,
                                  total & 0xFF, total >> 8])
    open(OUT, 'wb').write(built)

    if problems:
        print()
        for p in problems:
            print('PROBLEM: ' + p, file=sys.stderr)
        print(f'\nWrote {OUT}, but fix the problems above before trusting it.', file=sys.stderr)
        sys.exit(1)
    print(f'\nOK: wrote {OUT}. Now run it and use what the block does:\n'
          f'  open -a Mesen {OUT}')


if __name__ == '__main__':
    main()
