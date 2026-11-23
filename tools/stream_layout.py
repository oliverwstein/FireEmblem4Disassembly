#!/usr/bin/env python3
"""Lay out compressed streams across the lower halves of banks.

usage: tools/stream_layout.py LIST.streams OUT.asm

LIST names the streams in order, one per line (# starts a comment):

    start $CA65B5          where the first stream goes
    end $D05639            where the region ends (exclusive)
    LABEL NAME ; comment   the stream next to LIST, labelled LABEL: NAME.4bpp.lz
                           (built from NAME.4bpp.png) or NAME.bin.lz (built
                           from NAME.bin) if there is one, else the committed
                           NAME.comp (a stream whose format is not decoded yet)

The streams go one after another from start, in the half of the bank start is
in. The decompressor reads a stream that reaches the end of a half on from the
same half of the next bank ($0000 for a lower half, $8000 for an upper one), so
a stream that does not fit in what is left of a half is split there and
continued in the next bank. OUT gets
one placement block (* = / .logical / .here) per half, for build.asm to
include. It fails if the streams pass end.

./build.sh runs this for every gfx/**/*.streams, after making the .lz files, so
an edited graphic that compresses to a different size moves everything after
it and moves the splits with it.
"""
import datetime
import os
import sys


def main():
    if len(sys.argv) != 3:
        sys.exit(__doc__)
    list_path, out_path = sys.argv[1:]
    folder = os.path.dirname(list_path)
    start = end = None
    streams = []
    for line in open(list_path, encoding='utf-8'):
        code, _, comment = line.partition(';')
        code = code.split('#')[0].split()
        if not code:
            continue
        if code[0] in ('start', 'end'):
            value = int(code[1].lstrip('$'), 16)
            start, end = (value, end) if code[0] == 'start' else (start, value)
            continue
        label, name = code
        path = next((p for p in (os.path.join(folder, name + ext) for ext in ('.4bpp.lz', '.bin.lz', '.comp'))
                     if os.path.exists(p)), os.path.join(folder, name + '.comp'))
        streams.append((label, path, os.path.getsize(path), comment.strip()))
    if start is None or end is None:
        sys.exit(f'{list_path}: needs start and end lines')
    upper = start & 0x8000                      # which half of each bank

    blocks = []                                 # [(address, [lines])]
    here = start
    lines = []

    def new_block(address):
        nonlocal lines
        lines = []
        blocks.append((address, lines))

    new_block(here)
    for label, path, size, comment in streams:
        rel = os.path.relpath(path, os.path.dirname(out_path) or '.').replace(os.sep, '/')  # relative to OUT
        done = 0
        while done < size:
            room = ((here & 0xFF0000) + upper + 0x8000) - here
            take = min(room, size - done)
            name = f'      {label}' if done == 0 else '      '
            args = f'"{rel}"' if (done == 0 and take == size) else f'"{rel}", ${done:X}, ${take:X}'
            note = comment if done == 0 else f'rest of {label}'
            lines.append(f'{name} .binary {args} ; {here:06X}' + (f', {note}' if note else ''))
            done += take
            here += take
            if (here & 0xFFFF) == (upper + 0x8000) & 0xFFFF:   # the half is full:
                here = (here & 0xFF0000) + (0 if upper else 0x10000) + upper  # same half, next bank
                if done < size or streams[-1][0] != label:
                    new_block(here)
    if here > end:
        sys.exit(f'{list_path}: the streams end at ${here:06X}, past the region end ${end:06X} '
                 f'by {here - end} bytes')

    out = [f'; Made by tools/stream_layout.py from {list_path} on {datetime.date.today().isoformat()}; do not edit.', '']
    for address, block in blocks:
        if not block:
            continue
        out += [f'    * = ${address & 0x3FFFFF:06X}', f'    .logical ${address:06X}', '',
                *block, '', '    .here', '']
    open(out_path, 'w', encoding='utf-8').write('\n'.join(out))


if __name__ == '__main__':
    main()
