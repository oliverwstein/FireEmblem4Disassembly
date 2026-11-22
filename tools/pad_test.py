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
- it lists calls (jsl/jml, jsr/jmp) and long pointers (three bytes: low, high,
  bank) into the block from bytes not built from source, which cannot move;
  long pointers checked by hand and found to be chance are in NOT_POINTERS;
- it lists six-digit numbers in the source that are addresses in the block
  (`jml $84F889`): built, but they do not move;
- it warns if anything changed inside the code the game checksums while it runs
  (include/Checksums.h), since the game would then detect the change;
- it fixes the internal header checksum of FE4Padded.sfc.

What it cannot see is a hidden address: a number in code or data that is really
an address but is written as a number, so it did not move. For that, run
FE4Padded.sfc in Mesen and play through whatever uses the block.

The padding is NOPs, so code that falls through from the previous section into
SECTION still works, as it would after a real mod.
"""

import glob
import os
import re
import shutil
import subprocess
import sys
import tempfile
from collections import defaultdict

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import checksums

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

# Bytes in unbuilt data that read as a long pointer into a tested block (banks
# $84 and $86) but were checked by hand and are not one (2026-11-20), as file offsets. Remove an entry
# once the data around it is built.
NOT_POINTERS = {
    0x0BE0CB: 'compressed graphics or data, no pointers beside it',  # $8B/E0CB
    0x0BE66E: 'compressed graphics or data, no pointers beside it',  # $8B/E66E
    0x0BED1E: 'compressed graphics or data, no pointers beside it',  # $8B/ED1E
    0x0CF04E: 'straddles two entries of the $8C/FExx pointer table aUnknown8CEE6A',  # $8C/F04E
    0x0DA8D2: 'operand of ldx #$9388',  # $8D/A8D2
    0x0DA9DA: 'operand of ldx #$9388',  # $8D/A9DA
    0x14C7BA: 'compressed graphics or data, no pointers beside it',  # $94/C7BA
    0x14CE6B: 'compressed graphics or data, no pointers beside it',  # $94/CE6B
    0x14D14D: 'compressed graphics or data, no pointers beside it',  # $94/D14D
    0x14D30B: 'compressed graphics or data, no pointers beside it',  # $94/D30B
    0x14DC65: 'compressed graphics or data, no pointers beside it',  # $94/DC65
    0x14E7F4: 'compressed graphics or data, no pointers beside it',  # $94/E7F4
    0x14E800: 'compressed graphics or data, no pointers beside it',  # $94/E800
    0x14EFFA: 'compressed graphics or data, no pointers beside it',  # $94/EFFA
    0x17CA97: 'run of $82-$88 bytes',  # $97/CA97
    0x17CBCF: 'run of $80-$90 bytes',  # $97/CBCF
    0x17CD0F: 'compressed graphics or data, no pointers beside it',  # $97/CD0F
    0x17DABF: 'compressed graphics or data, no pointers beside it',  # $97/DABF
    0x17DAD8: 'compressed graphics or data, no pointers beside it',  # $97/DAD8
    0x17E4F6: 'run of $81-$87 bytes',  # $97/E4F6
    0x17E5AC: 'compressed graphics or data, no pointers beside it',  # $97/E5AC
    0x17E604: 'run of $81-$89 bytes',  # $97/E604
    0x17E737: 'run of $81-$84 bytes',  # $97/E737
    0x17E802: 'run of $81-$89 bytes',  # $97/E802
    0x17F904: 'same bytes as $9A/A1BC: graphics',  # $97/F904
    0x18A0A4: 'increasing byte series',  # $98/A0A4
    0x18A11D: 'increasing byte series',  # $98/A11D
    0x18A196: 'increasing byte series',  # $98/A196
    0x18A238: 'increasing byte series',  # $98/A238
    0x18A289: 'increasing byte series',  # $98/A289
    0x18A4C1: 'increasing byte series',  # $98/A4C1
    0x18A62F: 'increasing byte series',  # $98/A62F
    0x18A6A9: 'increasing byte series',  # $98/A6A9
    0x18D0E2: '01 DD C6 inside sprite-like records',  # $98/D0E2
    0x18D14E: '01 DD C6 inside sprite-like records',  # $98/D14E
    0x18D1AB: '01 DD C6 inside sprite-like records',  # $98/D1AB
    0x18D274: '01 DD C6 inside sprite-like records',  # $98/D274
    0x18D33D: '01 DD C6 inside sprite-like records',  # $98/D33D
    0x18DEC8: '01 DD C6 inside sprite-like records',  # $98/DEC8
    0x18E4D3: '01 DD C6 inside sprite-like records',  # $98/E4D3
    0x1A9B4D: 'compressed graphics or data, no pointers beside it',  # $9A/9B4D
    0x1AA1BC: 'same bytes as $97/F904: graphics',  # $9A/A1BC
    0x1AC592: '01 DD C6 inside sprite-like records',  # $9A/C592
    0x1AC5FE: '01 DD C6 inside sprite-like records',  # $9A/C5FE
    0x1AC65B: '01 DD C6 inside sprite-like records',  # $9A/C65B
    0x1AC724: '01 DD C6 inside sprite-like records',  # $9A/C724
    0x1AC7ED: '01 DD C6 inside sprite-like records',  # $9A/C7ED
    0x1AD256: '01 DD C6 inside sprite-like records',  # $9A/D256
    0x1AD83E: '01 DD C6 inside sprite-like records',  # $9A/D83E
    0x1C9BFE: 'compressed graphics or data, no pointers beside it',  # $9C/9BFE
    0x1CAB77: 'compressed graphics or data, no pointers beside it',  # $9C/AB77
    0x1CAC87: 'compressed graphics or data, no pointers beside it',  # $9C/AC87
    0x1CADFA: 'compressed graphics or data, no pointers beside it',  # $9C/ADFA
    0x1CB018: 'compressed graphics or data, no pointers beside it',  # $9C/B018
    0x1CB95E: 'compressed graphics or data, no pointers beside it',  # $9C/B95E
    0x1CC0DF: 'compressed graphics or data, no pointers beside it',  # $9C/C0DF
    0x1CC666: 'compressed graphics or data, no pointers beside it',  # $9C/C666
    0x1CD088: 'compressed graphics or data, no pointers beside it',  # $9C/D088
    0x1CD3AF: 'compressed graphics or data, no pointers beside it',  # $9C/D3AF
    0x1CE346: 'compressed graphics or data, no pointers beside it',  # $9C/E346
    0x1FC4BA: 'inside 9-byte records of $9F/C4xx words',  # $9F/C4BA
    0x02EB91: 'operand + opcode of bit #$8000; beq',  # $82/EB91
    0x02EC19: 'operand + opcode of bit #$8000; beq',  # $82/EC19
    0x05D33B: 'operand + opcode of cmp #$8000; beq',  # $85/D33B
    0x05D34B: 'operand + opcode of cmp #$8000; beq',  # $85/D34B
    0x08ACDF: 'word table / graphics metadata, not a pointer',  # $88/ACDF
    0x08E01B: 'operand + opcode of and #$8000; beq',  # $88/E01B
    0x0ADE75: 'zero padding followed by $A0',  # $8A/DE75
    0x0AE01A: 'zero padding followed by $A0',  # $8A/E01A
    0x16BFC2: 'operand + opcode of ldx #$0000; bra',  # $96/BFC2
    0x16C4D1: 'operand + opcode of ldx #$0000; bra',  # $96/C4D1
    0x16C59B: 'operand + opcode of bit #$8000; beq',  # $96/C59B
    0x16C7B8: 'operand + opcode of ldx #$0000; bra',  # $96/C7B8
    0x16DCF5: 'operand + opcode of ldx #$0000; ldy #$0000',  # $96/DCF5
    0x1BE6FA: 'operand + opcode of ldx #$0000; ldy #$0000',  # $9B/E6FA
    0x1BF89D: 'operand + opcode of ldx #$0000; ldy #$0006',  # $9B/F89D
    0x1BF8DC: 'operand + opcode of ldx #$0000; ldy #$0008',  # $9B/F8DC
    0x1BF91B: 'operand + opcode of ldx #$0000; ldy #$000A',  # $9B/F91B
    0x1BF95A: 'operand + opcode of ldx #$0000; ldy #$000C',  # $9B/F95A
    0x1BF999: 'operand + opcode of ldx #$0000; ldy #$000E',  # $9B/F999
    0x1EE421: 'operand of lda #$EAD5 + opcode sta @l (bank $9E, not $8F)',  # $9E/E421
    0x1EE632: 'operand of lda #$EBB9 + opcode sta @l (bank $9E, not $8F)',  # $9E/E632
    0x1EE896: 'operand of lda #$EB4A + opcode sta @l (bank $9E, not $8F)',  # $9E/E896
    0x1EE8AE: 'operand of sta $63 + lda #$EBB2',  # $9E/E8AE
    0x1EE8F6: 'operand of sta $63 + lda #$EBB2',  # $9E/E8F6
    0x1EE93E: 'operand of sta $63 + lda #$EBB2',  # $9E/E93E
}


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
    disable_checks = '--disable-checks' in args
    fix_checksums = '--fix-checksums' in args or disable_checks
    args = [a for a in args if a not in ('--fix-checksums', '--disable-checks')]
    if len(args) != 2 or not args[1].isdigit() or int(args[1]) < 1:
        sys.exit('Usage: ./build.sh pad SECTION N [--fix-checksums|--disable-checks]   (N: bytes to insert, 1 or more)')
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
        # Which bytes come from source: build with the base ROM filled with $00
        # and with $FF; bytes that agree do not come from the base ROM.
        with open(os.path.join(src, 'build.asm'), 'w') as f:
            f.write('\n'.join(lines))
        fills = []
        for fill in (0x00, 0xFF):
            with open(os.path.join(src, ROM), 'wb') as f:
                f.write(bytes([fill]) * len(rom))
            subprocess.run(['64tass', *asflags, '-o', 'fill.sfc', 'build.asm'],
                           cwd=src, capture_output=True)
            fills.append(open(os.path.join(src, 'fill.sfc'), 'rb').read())
        from_source = bytes(x == y for x, y in zip(*fills))
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

    # 4. References into the block from bytes that are not source. The assembler
    #    cannot update these, so they still point at the old addresses. Calls
    #    (jsl/jml, and jsr/jmp from the same bank) to the start of a routine or
    #    table in the block are listed; the ones fe4.cdl shows ran are certain.
    targets = {}
    for name, a in original.items():
        if ':' not in name and in_block(a):
            targets[offset(a)] = name
    bank = s_off >> 16
    try:
        cdl = open('fe4.cdl', 'rb').read()
    except OSError:
        cdl = b''
    if cdl.startswith(b'CDLv2'):
        cdl = cdl[9:]                 # "CDLv2" and the ROM's CRC32, then one byte per ROM byte
    ran = lambda o: o < len(cdl) and cdl[o] & 1
    calls = []
    for o in range(len(rom) - 3):
        op = rom[o]
        if op in (0x22, 0x5C):                                   # jsl, jml long
            if rom[o + 3] & 0x3F != bank or rom[o + 3] < 0x80:
                continue
            size = 4
        elif op in (0x20, 0x4C) and o >> 16 == bank:             # jsr, jmp absolute
            size = 3
        else:
            continue
        t = (bank << 16) | rom[o + 1] | rom[o + 2] << 8
        if t in targets and not any(from_source[o:o + size]):
            calls.append((o, op, t))
    # The game's code runs from the upper halves of banks $80-$9F; a match in the
    # lower half of a bank ($xx/0000-7FFF) or above bank $9F is data that only
    # looks like a call, unless the log shows it ran.
    lower = [c for c in calls if not ran(c[0]) and ((c[0] & 0xFFFF) < 0x8000 or c[0] >> 16 >= 0x20)]
    if lower:
        print(f'Calls into the block in data areas (lower bank halves, or past bank $9F), '
              f'taken to be data: {len(lower)} (' + ', '.join(cpu(o) for o, _, _ in lower[:6])
              + (' ...' if len(lower) > 6 else '') + ')')
    calls = [c for c in calls if c not in lower]
    certain = [c for c in calls if ran(c[0])]
    mnem = {0x22: 'jsl', 0x5C: 'jml', 0x20: 'jsr', 0x4C: 'jmp'}
    if calls:
        by_bank = defaultdict(int)
        for o, _, _ in calls:
            by_bank[f'${0x80 + (o >> 16):02X}'] += 1
        print(f'Calls into the block from bytes not built from source: {len(calls)} '
              f'({len(certain)} ran in fe4.cdl). By bank: '
              + ', '.join(f'{b} {k}' for b, k in sorted(by_bank.items())))
        for o, op, t in (certain + [c for c in calls if not ran(c[0])])[:12]:
            print(f'  {cpu(o)} {mnem[op]} {targets[t]}{" (ran)" if ran(o) else ""}')
        if len(calls) > 12:
            print(f'  ... and {len(calls) - 12} more')
        print('  These still go to the old addresses. Those that did not run may be data that\n'
              '  only looks like a call; any that are code break what they belong to.')
    if certain:
        problems.append(f'{len(certain)} calls into the block that fe4.cdl shows ran come from '
                        'bytes not built from source, so they did not move with it; build '
                        'the code around them first.')

    # 4b. Long pointers into the block in bytes that are not source: three bytes
    #     low, high, bank ($8x or $Cx) giving the start of a routine or table in
    #     the block, as in a table of `.long label`. Only the code banks' upper
    #     halves are searched; data elsewhere matches by chance too often. Bytes
    #     that are the operand of a jsl/jml listed above are left out.
    call_operands = {o + 1 for o, op, _ in calls if op in (0x22, 0x5C)}
    pointers = []
    for o in range(0, 0x200000 - 2):
        if (o & 0xFFFF) < 0x8000 or (o & 0xFFFF) > 0xFFFD or o in call_operands:
            continue
        hb = rom[o + 2]
        if hb & 0x3F != bank or hb < 0x80:
            continue
        t = (bank << 16) | rom[o] | rom[o + 1] << 8
        if t in targets and not any(from_source[o:o + 3]):
            pointers.append((o, t))
    reviewed = [p for p in pointers if p[0] in NOT_POINTERS]
    pointers = [p for p in pointers if p[0] not in NOT_POINTERS]
    if reviewed:
        print(f'Long pointers into the block checked by hand and found to be chance '
              f'(NOT_POINTERS): {len(reviewed)}')
    read = lambda o: o < len(cdl) and cdl[o] & 2
    if pointers:
        read_ptrs = [p for p in pointers if read(p[0])]
        by_bank = defaultdict(int)
        for o, _ in pointers:
            by_bank[f'${0x80 + (o >> 16):02X}'] += 1
        print(f'Long pointers into the block in bytes not built from source: {len(pointers)} '
              f'({len(read_ptrs)} read in fe4.cdl). By bank: '
              + ', '.join(f'{b} {k}' for b, k in sorted(by_bank.items())))
        for o, t in sorted(pointers):
            print(f'  {cpu(o)} .long {targets[t]}{" (read)" if read(o) else ""}')
        print('  These still hold the old addresses. Write the tables they belong to as\n'
              '  source (`.long label`); a match in code or unrelated data is chance.')
        problems.append(f'{len(pointers)} long pointers into the block are in bytes not built '
                        'from source; write the tables they belong to, or confirm each is '
                        'not a pointer.')

    # 4c. Addresses into the block written as numbers in the source, such as
    #     `jml $84F889` or `.long $84C398`: they are source, so the assembler
    #     builds them, but they do not move. Six-digit numbers only; a bank's
    #     short addresses ($C4B2) look too much like other numbers to search.
    hidden = []
    files = (glob.glob('engine/**/*.asm', recursive=True)
             + glob.glob('data/**/*.asm', recursive=True) + glob.glob('events/**/*.asm', recursive=True))
    for path in files:
        for k, line in enumerate(open(path, encoding='utf-8'), 1):
            code = line.split(';')[0]
            if re.match(r'\s*\.(logical|fill)\b', code):
                continue
            for m in re.finditer(r'\$([0-9A-Fa-f]{6})\b', code):
                v = int(m.group(1), 16)
                if v >> 16 >= 0x80 and offset(v) is not None and s_off <= offset(v) < e_off:
                    hidden.append(f'  {path}:{k}: {code.strip()}')
    if hidden:
        print(f'Addresses into the block written as numbers in the source: {len(hidden)}')
        print('\n'.join(hidden[:20]) + ('\n  ...' if len(hidden) > 20 else ''))
        problems.append(f'{len(hidden)} numbers in the source are addresses in the block; '
                        'write them as labels so they move with it.')

    # 5. The game's own code checksums.
    for lo, hi, what in CHECKED_RANGES:
        hit = [o for o in range(lo, hi) if built[o] != rom[o]]
        if hit:
            if fix_checksums:
                print(f'Note: {len(hit)} bytes changed in checksummed code {what}; '
                      f'updating checksums in {OUT}.')
            else:
                problems.append(f'{len(hit)} bytes changed in checksummed code {what}; the game '
                                'will detect the change unless the sums in include/Checksums.h '
                                'are updated (or pass --fix-checksums).')

    # Update code checksums (when requested) and the SNES header checksum.
    if fix_checksums:
        pad_labels = {k: padded.get(k, v) for k, v in checksums.DEFAULTS.items()}
        checksums.update_rom(built, pad_labels, disable_checks=disable_checks)
    else:
        comp, total = checksums.compute_header_checksum(built)
        built[0xFFDC:0xFFE0] = bytes([comp & 0xFF, comp >> 8, total & 0xFF, total >> 8])
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
