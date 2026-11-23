#!/usr/bin/env python3
"""Decode the title screen's timelines into TITLE_TIMELINE_* macros.

usage: tools/title_timeline.py ADDR [ADDR ...]
       tools/title_timeline.py --write

A timeline (rsRunTitleTimeline, include/TitleScreen.h) is a list of entries:
a frame word, then commands of a byte and a long routine pointer (below $80:
install the routine in that slot; $80 + n: call it once with A = n), ended by
$FF. A frame of $FFFF ends the timeline.

With addresses, prints each timeline as macros, routines by their labels in
labels.txt. --write replaces the .byte rows from $97/EC63 to $97/F19B (the
three timelines rlResetTitleTimeline, rlTitleScreenSkipIntro and
rlTitleScreenStartFadeOut load) with the macros and labels, keeping the rows
before them; then run ./build.sh.
"""
import os, re, sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from asmlib import read_rom, offset
from disasm import load_labels

TIMELINES = [(0x97EC63, 'aTitleIntroTimeline'), (0x97F12D, 'aTitleTimeline'), (0x97F15D, 'aTitleFadeOutTimeline')]
END = 0x97F19B
FILE = 'engine/unsorted/bank97.asm'


def decode(rom, addr):
    """[(frame, [(command, routine address)])], end address."""
    p = offset(addr)
    out = []
    while True:
        frame = rom[p] | rom[p + 1] << 8
        p += 2
        if frame == 0xFFFF:
            return out, addr + (p - offset(addr))
        cmds = []
        while rom[p] != 0xFF:
            cmds.append((rom[p], rom[p + 1] | rom[p + 2] << 8 | rom[p + 3] << 16))
            p += 4
        p += 1
        out.append((frame, cmds))


def render(entries, names):
    lines = []
    for frame, cmds in entries:
        lines.append(f'        TITLE_TIMELINE_AT ${frame:04X}')
        for c, r in cmds:
            label = names.get(r, [None])[0] or f'${r:06X}'
            if c & 0x80:
                lines.append(f'          TITLE_TIMELINE_CALL {c & 0x7F}, {label}')
            else:
                lines.append(f'          TITLE_TIMELINE_SLOT {c}, {label}')
        lines.append('        TITLE_TIMELINE_NEXT')
    lines.append('        TITLE_TIMELINE_END')
    return lines


def main():
    rom = read_rom()
    names = load_labels('labels.txt')
    if '--write' not in sys.argv:
        for a in sys.argv[1:]:
            entries, end = decode(rom, int(a, 16))
            print('\n'.join(render(entries, names)))
            print(f'        ; ends at {end:06X}')
        return
    out = []
    expect = TIMELINES[0][0]
    for addr, name in TIMELINES:
        if addr != expect:
            raise SystemExit(f'${addr:06X} does not follow the timeline before it (${expect:06X})')
        entries, expect = decode(rom, addr)
        out += ['', f'      {name} ; {addr >> 16:02X}/{addr & 0xFFFF:04X}', ''] + render(entries, names)
    if expect != END:
        raise SystemExit(f'the timelines end at ${expect:06X}, not ${END:06X}')
    lines = open(FILE, encoding='utf-8').read().split('\n')
    # The .byte rows of the label before $97/EC63 run on into the timelines:
    # keep the bytes before $97/EC63 and replace the rest.
    k = next(i for i, l in enumerate(lines) if re.match(r'^      \w+ ; 97/EC1A', l))
    start = 0x97EC1A
    first = next(i for i in range(k + 1, len(lines)) if lines[i].strip().startswith('.byte'))
    last = first
    while lines[last + 1].strip().startswith('.byte'):
        last += 1
    data = []
    for l in lines[first:last + 1]:
        data += [int(x.strip()[1:], 16) for x in l.strip()[5:].split(',')]
    if start + len(data) != END or bytes(data) != rom[offset(start):offset(END)]:
        raise SystemExit('the rows at $97/EC1A are not the bytes up to $97/F19B')
    keep = data[:TIMELINES[0][0] - start]
    rows = ['        .byte ' + ', '.join(f'${b:02X}' for b in keep[i:i + 16]) for i in range(0, len(keep), 16)]
    lines[first:last + 1] = rows + out
    open(FILE, 'w', encoding='utf-8').write('\n'.join(lines))
    print(f'wrote {len(TIMELINES)} timelines into {FILE}')


if __name__ == '__main__':
    main()
