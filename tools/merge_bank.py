#!/usr/bin/env python3
"""Merge a bank's placement blocks in build.asm into as few blocks as possible.

Usage:
    python3 tools/merge_bank.py BANK          e.g. 86 (the $80-$BF or $C0-$FF bank)
    python3 tools/merge_bank.py BANK --dry-run

Every block in build.asm is pinned to its original address by `* = ...` and
`.logical ...`. A pin is only needed where the block before it does not end
exactly there (a gap of base-ROM bytes, or another file's code in between).
This tool assembles a temporary copy with a marker label at the end of each
block in the bank, and removes each pin whose block starts exactly where the
previous block (the one just before it in build.asm, in the same bank) ends.
The merged blocks then flow freely: code added early moves everything after
it. The output is unchanged; run ./build.sh to confirm.

Pins that stay are listed with the reason, which is the work left before the
bank can be one block. If a chain of merged blocks is followed by free filler
($00 or $FF, nothing labelled) up to the bank end, that space is written as
`.fill <bank end> - *`, so the bank can grow into it. Comments in build.asm
like `; 84/9FB9`, which marked where old blocks ended, are removed.
"""

import os
import re
import shutil
import subprocess
import sys
import tempfile

ASFLAGS = ['-x', '-f', '-C', '-a', '-Wall', '-Wno-portable', '-Wno-shadow', '-Wno-deprecated']
STAR = re.compile(r'\s*\* = \$([0-9A-Fa-f]+)\s*(;.*)?$')
LOGICAL = re.compile(r'\s*\.logical\s+\$([0-9A-Fa-f]+)\s*(;.*)?$')
HERE = re.compile(r'\s*\.here\b')


def blocks(lines):
    """Each block as [star_line, here_line, file_offset, logical_bank], in file order."""
    out = []
    for i, l in enumerate(lines):
        m = STAR.match(l)
        if m:
            here = next(j for j in range(i + 1, len(lines)) if HERE.match(lines[j]))
            lm = LOGICAL.match(lines[i + 1]) if i + 1 < len(lines) else None
            lbank = int(lm.group(1), 16) >> 16 if lm else None
            out.append([i, here, int(m.group(1), 16), lbank])
    return out


def cpu(off):
    return f'${0x80 + (off >> 16):02X}/{off & 0xFFFF:04X}'


def main():
    args = [a for a in sys.argv[1:] if a != '--dry-run']
    dry = '--dry-run' in sys.argv
    if len(args) != 1 or not re.fullmatch(r'[0-9A-Fa-f]{2}', args[0]):
        sys.exit(__doc__.split('\n\n')[1])
    bank = int(args[0], 16) & 0x3F

    lines = open('build.asm').read().split('\n')
    bs = [b for b in blocks(lines) if b[2] >> 16 == bank]
    if not bs:
        sys.exit(f'No blocks in bank ${0x80 + bank:02X}')

    # Assemble with a marker label before each block's .here to get its end.
    marked = list(lines)
    for k, (star, here, _, _) in sorted(enumerate(bs), key=lambda x: -x[1][1]):
        marked[here:here] = [f'      MergeBankEnd{k}']
    tmp = tempfile.mkdtemp()
    try:
        src = os.path.join(tmp, 'src')
        subprocess.run(['rsync', '-a', '--exclude', '.git', '--exclude', '*.smc',
                        '--exclude', 'FE4Disassembly.sfc', './', src + '/'], check=True)
        open(os.path.join(src, 'build.asm'), 'w').write('\n'.join(marked))
        res = subprocess.run(['64tass', *ASFLAGS, '-o', 'out.sfc', '--vice-labels',
                              '-l', 'out_labels.txt', 'build.asm'],
                             cwd=src, capture_output=True, text=True)
        if res.returncode:
            sys.exit('Assembly failed; run ./build.sh first\n' + res.stdout[-1500:])
        ends = {}
        for l in open(os.path.join(src, 'out_labels.txt')):
            m = re.match(r'al ([0-9a-f]+) \.MergeBankEnd(\d+)$', l.strip())
            if m:
                ends[int(m.group(2))] = int(m.group(1), 16) & 0x3FFFFF
    finally:
        shutil.rmtree(tmp)

    merge, keep = [], []
    for k in range(1, len(bs)):
        prev, cur = bs[k - 1], bs[k]
        between = lines[prev[1] + 1:cur[0]]
        if any(l.strip() for l in between):
            keep.append((cur, 'other code comes between it and the previous block in build.asm'))
        elif prev[3] is not None and cur[3] is not None and prev[3] != cur[3]:
            keep.append((cur, f'logical bank changes from ${prev[3]:02X} to ${cur[3]:02X}'))
        elif ends[k - 1] != cur[2]:
            gap = cur[2] - ends[k - 1]
            keep.append((cur, f'{gap:,} bytes not built from source before it, from '
                              f'{cpu(ends[k - 1])}' if gap > 0 else
                              f'the previous block overlaps it by {-gap:,} bytes'))
        else:
            merge.append(cur)

    print(f'Bank ${0x80 + bank:02X}: {len(bs)} blocks; {len(merge)} pins can go.')
    print(f'Kept: {cpu(bs[0][2])} (first block in build.asm)')
    for b, why in keep:
        print(f'Kept: {cpu(b[2])} ({why})')
    # A free run of filler from the end of a chain of blocks to the bank end
    # (nothing labelled or placed there) becomes `.fill <bank end> - *`, so the
    # chain can grow into it.
    rom = open('fe4.sfc', 'rb').read()
    labelled = set()
    for l in open('labels.txt'):
        m = re.match(r'al ([0-9a-f]+) ', l)
        if m and int(m.group(1), 16) >> 16 >= 0x80:
            labelled.add(int(m.group(1), 16) & 0x3FFFFF)
    starts = {b[2] for b in blocks(lines)}
    merged = {id(b) for b in merge}
    bank_end = (bank << 16) + 0x10000
    fills = []
    for k, b in enumerate(bs):
        if k + 1 < len(bs) and id(bs[k + 1]) in merged:
            continue                  # not the last block of its chain
        if b[3] is not None and b[3] != 0x80 + bank:
            continue                  # lower-half block ($Cx-$FF); don't fill to upper bank end
        e = ends[k]
        tail = rom[e:bank_end]
        if (e < bank_end and e >> 16 == bank and tail[0] in (0x00, 0xFF)
                and tail == bytes([tail[0]]) * len(tail)
                and not any(e <= o < bank_end for o in labelled | starts)):
            fills.append((b[1], tail[0], bank_end - e))
            print(f'Fill: {bank_end - e:,} bytes of ${tail[0]:02X} from {cpu(e)} to the bank end')
    if dry or not (merge or fills):
        return

    insert = {}
    for here, fill, _ in fills:
        base = 0x800000 + (bank << 16) + 0x8000
        insert[here] = ['', f'      .fill ${base:06X} + $8000 - *, ${fill:02X}', '']

    # Remove, for each merged block, the lines from the previous block's .here
    # through this block's .logical, with the blank lines around them, leaving
    # one blank line.
    drop = set()
    for star, _, _, _ in merge:
        here = max(b[1] for b in bs if b[1] < star)
        lo = here
        while lo > 0 and not lines[lo - 1].strip():
            lo -= 1
        hi = star + 1
        if not LOGICAL.match(lines[hi]):
            sys.exit(f'build.asm:{hi + 1}: expected .logical after the `* =` line')
        while hi + 1 < len(lines) and not lines[hi + 1].strip():
            hi += 1
        drop.update(range(lo, hi + 1))
        drop.discard(lo)          # keep one blank line
        lines[lo] = ''

    # Comments such as `; 84/9FB9` in build.asm marked where a block ended. In a
    # merged block they would go stale as soon as anything moves.
    for b in bs:
        for i in range(b[0], b[1]):
            if re.match(r'\s*; [0-9A-F]{2}/[0-9A-F]{4}\s*$', lines[i]):
                drop.add(i)
                if not lines[i - 1].strip():
                    drop.add(i - 1)

    out = []
    for i, l in enumerate(lines):
        if i in insert:
            while out and not out[-1].strip():
                out.pop()
            out.extend(insert[i])
        if i not in drop:
            out.append(l)
    open('build.asm', 'w').write('\n'.join(out))
    print('Rewrote build.asm. Run ./build.sh to confirm the output still matches.')

if __name__ == '__main__':
    main()
