#!/usr/bin/env python3
"""Map battle sprite data (aMapBattle*Layout*) as assembly source, and back.

usage: tools/map_battle_layouts.py decode NAME.bin OUT.asm
       tools/map_battle_layouts.py assemble IN.asm OUT.bin
       tools/map_battle_layouts.py build
       tools/map_battle_layouts.py clean
       tools/map_battle_layouts.py --self-test

Each aMapBattle*Layout* stream is the sprite data of one class row and facing in
aBattleMapSpriteData (engine/battle/map_battle.asm): rlMapBattleQueueSpriteData
decompresses it to aDecompressionBuffer + $6000 (side 0) or + $6880 (side 1), and
the side's main and aux active sprites run scripts straight out of it. The
format, as the code reads it:

- Five words, one per wSideWeaponType (0 sword, 1 lance, 2 axe, 3 bow, 4 staff
  or tome: rlMapBattleSetSpriteScripts), each the offset of that weapon's block.
  Weapon types a class never shows hold a fill value that is not an offset
  (one value per file, such as $2124); nothing reads them.
- A block (lAttackerSpriteData / lDefenderSpriteData point at it) starts with
  the offset of its frame table, two words no routine reads (kept as
  Unknown2 / Unknown4), then (main, aux) script offsets, all counted from the
  block: +6 wait, +$0A dodge, +$0E strike, +$12 strike at range
  (rsGetMapBattleRoundScripts). The strike-at-range pair is left out of blocks
  whose weapon has no ranged strike; slots a sprite never runs hold the fill.
- The frame table is a list of frame offsets, also from the block. Command $0E
  (ACTIVE_SPRITE_TABLE_FRAME Duration, Index) draws frame Index. A frame is a
  sprite array: a word count and 5-byte entries (.structSpriteEntry).
- Scripts use no absolute addresses (the data runs at two places in RAM), only
  the commands in include/ActiveSpriteEngine.h.
- The stream ends in zeros up to $800 or $880 bytes; $880 is the most a side's
  buffer holds.

decode writes that as source: labels for every block, table, frame and script,
offsets as label differences, so frames and scripts can grow, shrink, be added
or reordered and every offset follows. Bytes no offset reaches stay as .byte.
assemble runs 64tass on it (with include/Sprites.h and
include/ActiveSpriteEngine.h) to the .bin that gfx.py lz compresses; build does
that for every gfx/map_battle/aMapBattle*Layout*.asm newer than its .bin (written
beside its .bin.comp in gfx/build/*/), and
is what ./build.sh runs.

A frame does not hold its own picture: its tiles from $20 ($28 for side 1) are
whatever graphics frame the script last uploaded with command $03
(ACTIVE_SPRITE_MAP_BATTLE_FRAME, from the paired g4bppcMapBattle* stream through
aMapBattleSpriteDMATable to aMapBattleSideFrameVRAM), and the rest depend on
each sprite's tile bases. tools/map_battle_sprites.py preview steps the scripts
to draw them.

--self-test decodes and assembles all 120 streams (from their committed .comp)
and compares bytes, checks that the committed .asm files assemble to the same
bytes, and that adding a sprite to one frame moves everything after it while the
parsed scripts and frames stay the same.
"""
import argparse
import glob
import os
import re
import struct
import subprocess
import sys
import tempfile

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SRC_DIR = os.path.join(ROOT, 'gfx/map_battle')
BUILD_PATTERN = os.path.join(ROOT, 'gfx/build/*/aMapBattle*Layout*')

WEAPONS = ['Sword', 'Lance', 'Axe', 'Bow', 'Magic']
# Block header words after the frame table offset: (name, offset in block).
SLOTS = [('Unknown2', 2), ('Unknown4', 4), ('Wait', 6), ('WaitAux', 8), ('Dodge', 0x0A),
         ('DodgeAux', 0x0C), ('Strike', 0x0E), ('StrikeAux', 0x10), ('Ranged', 0x12), ('RangedAux', 0x14)]
MAX_SIZE = 0x880

# Script commands: opcode -> (operand bytes, macro, operand formatter).
def _u(b):
    return [str(x) for x in b]


def _hex(b):
    return [f'${x:02X}' for x in b]


def _s(b):
    return [str(x - 256 if x >= 128 else x) for x in b]


COMMANDS = {
    0x01: (0, 'ACTIVE_SPRITE_END', None),
    0x03: (1, 'ACTIVE_SPRITE_MAP_BATTLE_FRAME', _u),
    0x04: (0, 'ACTIVE_SPRITE_MAP_BATTLE_STRIKE', None),
    0x05: (0, 'ACTIVE_SPRITE_WAIT_STRIKE_TAKEN', None),
    0x06: (0, 'ACTIVE_SPRITE_WAIT_STRIKE', None),
    0x07: (0, 'ACTIVE_SPRITE_WAIT_STRIKE_DONE', None),
    0x08: (0, 'ACTIVE_SPRITE_WAIT_ROUND', None),
    0x09: (0, 'ACTIVE_SPRITE_ROUND_SCRIPT', None),
    0x0A: (0, 'ACTIVE_SPRITE_AUX_ROUND_SCRIPT', None),
    0x0B: (0, 'ACTIVE_SPRITE_SIDE_SCRIPT', None),
    0x0C: (0, 'ACTIVE_SPRITE_SIDE_AUX_SCRIPT', None),
    0x0D: (0, 'ACTIVE_SPRITE_END_ROUND', None),
    0x0E: (2, 'ACTIVE_SPRITE_TABLE_FRAME', _u),
    0x10: (0, 'ACTIVE_SPRITE_START_MAP_MAGIC', None),
    0x11: (0, 'ACTIVE_SPRITE_WAIT_MAP_MAGIC', None),
    0x12: (1, 'ACTIVE_SPRITE_WAIT', _u),
    0x19: (2, 'ACTIVE_SPRITE_MOVE', _s),
    0x1A: (0, 'ACTIVE_SPRITE_WAIT_BOLT_SIGNAL', None),
    0x1B: (0, 'ACTIVE_SPRITE_FIRE_BOLT', None),
    0x1C: (0, 'ACTIVE_SPRITE_WAIT_BOLT_DONE', None),
    0x1D: (1, 'ACTIVE_SPRITE_SOUND', _hex),
    0x1E: (1, 'ACTIVE_SPRITE_SET_MUSIC', _hex),
}
# Commands after which a script does not run on.
ENDS = {0x01, 0x09, 0x0A, 0x0B, 0x0C}


def word(raw, pos):
    return struct.unpack_from('<H', raw, pos)[0]


def parse_script(raw, pos, limit):
    """Commands from pos up to an ending command: [(offset, opcode, operands)],
    or None if a byte on the way is not a command this data can use."""
    out = []
    while pos < limit:
        op = raw[pos]
        if op not in COMMANDS or pos + 1 + COMMANDS[op][0] > limit:
            return None
        n = COMMANDS[op][0]
        out.append((pos, op, bytes(raw[pos + 1:pos + 1 + n])))
        pos += 1 + n
        if op in ENDS:
            return out
    return None


def parse_frame(raw, pos):
    count = word(raw, pos)
    entries = []
    for i in range(count):
        e = raw[pos + 2 + 5 * i:pos + 7 + 5 * i]
        xw = e[0] | e[1] << 8
        attr = e[3] | e[4] << 8
        x = xw & 0x1FF
        entries.append(dict(x=x - 512 if x & 0x100 else x, y=e[2] - 256 if e[2] & 0x80 else e[2],
                            attr_bits=(xw >> 9) & 0x3F, large=xw >> 15, tile=attr & 0x1FF,
                            palette=(attr >> 9) & 7, priority=(attr >> 12) & 3,
                            hflip=bool(attr & 0x4000), vflip=bool(attr & 0x8000)))
    return entries


def parse(raw):
    """The structure of one stream: {'size', 'end', 'fill', 'header', 'blocks'}.

    header is five entries, each a block offset or None (the fill value).
    blocks maps a block offset to {'slots': {name: abs offset or None},
    'ranged': bool, 'table': abs offset, 'frames': [abs offsets],
    'scripts': {abs offset: commands or None}}.
    """
    size = len(raw)
    end = max((i for i, b in enumerate(raw) if b), default=0) + 1
    hdr = struct.unpack_from('<5H', raw, 0)
    fills = {h for h in hdr if h >= size}
    starts = sorted({h for h in hdr if h < size})
    blocks = {}
    for bi, b in enumerate(starts):
        bend = starts[bi + 1] if bi + 1 < len(starts) else end
        words = struct.unpack_from('<11H', raw, b)
        table = b + words[0]
        # The scripts always present (+6 to +$10) name the frames they draw; the
        # first frame starts right after the header, which says whether the
        # strike-at-range pair is there (22 bytes) or not (18).
        used = 0
        for k in range(3, 9):
            if words[k] >= size:
                fills.add(words[k])
                continue
            cmds = parse_script(raw, b + words[k], bend)
            for _, op, args in cmds or []:
                if op == 0x0E:
                    used = max(used, args[1] + 1)
        first = min(b + word(raw, table + 2 * i) for i in range(max(used, 1)))
        hl = first - b
        assert hl in (18, 22), f'block ${b:X}: header of {hl} bytes'
        slots = {}
        for name, off in SLOTS[:hl // 2 - 1]:
            v = words[off // 2]
            if v >= size:
                fills.add(v)
                slots[name] = None
            else:
                assert b <= b + v < bend, f'block ${b:X}: {name} outside the block'
                slots[name] = b + v
        scripts = {}
        for name, a in slots.items():
            if a is not None and not name.startswith('Unknown'):
                scripts[a] = parse_script(raw, a, bend)
        # The table runs until the next thing a header word points at.
        nexts = [a for a in list(slots.values()) + [bend] if a is not None and a > table]
        tend = min(nexts)
        frames = []
        for i in range((tend - table) // 2):
            f = b + word(raw, table + 2 * i)
            if not (b + hl <= f < table):
                break
            frames.append(f)
        assert len(frames) >= used, f'block ${b:X}: frame table shorter than its scripts use'
        blocks[b] = dict(slots=slots, ranged=hl == 22, table=table, frames=frames, scripts=scripts, end=bend)
    assert len(fills) <= 1, f'more than one fill value: {sorted(fills)}'
    return dict(size=size, end=end, fill=fills.pop() if fills else None,
                header=[h if h < size else None for h in hdr], blocks=blocks)


def entry_source(e):
    size = 'SpriteLarge' if e['large'] else 'SpriteSmall'
    return (f".structSpriteEntry ({e['x']:4}, {e['y']:4}), ${e['attr_bits']:02X}, {size}, ${e['tile']:03X}, "
            f"{e['priority']}, {e['palette']}, {str(e['hflip']).lower()}, {str(e['vflip']).lower()}")


def to_source(raw, name):
    """Assembly source for one stream (see the module docstring)."""
    p = parse(raw)
    fill = f"${p['fill']:04X}" if p['fill'] is not None else None
    labels = {}       # offset -> label
    items = []        # (offset, length, [(offset, text)])
    ind = '  '

    def label(off, text):
        labels.setdefault(off, text)
        return labels[off]

    weapon_of = {}
    for i, h in enumerate(p['header']):
        if h is not None:
            weapon_of.setdefault(h, WEAPONS[i])
    lines = [(0, f'{ind}; Block offsets by weapon type (sword, lance, axe, bow, staff or tome).')]
    for i, h in enumerate(p['header']):
        if h is None:
            lines.append((None, f'{ind}.word {fill} ; no {WEAPONS[i].lower()} block'))
        else:
            lines.append((None, f'{ind}.word _{weapon_of[h]} - {name}'))
    items.append((0, 10, lines))

    for b, blk in p['blocks'].items():
        w = weapon_of[b]
        base = f'_{w}'
        label(b, base)
        label(blk['table'], f'{base}FrameTable')
        for i, f in enumerate(blk['frames']):
            label(f, f'{base}Frame{i:02X}')
        for sname, a in blk['slots'].items():
            if a is not None:
                label(a, f'{base}{sname}')
        hl = 22 if blk['ranged'] else 18
        lines = [(None, f'{ind}.word {base}FrameTable - {base}')]
        pairs = list(blk['slots'].items())
        for k in range(0, len(pairs), 2):
            cells = []
            for sname, a in pairs[k:k + 2]:
                cells.append(f'{labels[a]} - {base}' if a is not None else fill)
            lines.append((None, f'{ind}.word ' + ', '.join(cells)))
        items.append((b, hl, lines))

        for f in sorted(set(blk['frames'])):
            entries = parse_frame(raw, f)
            fl = [(None, f'{ind}.word {len(entries)} ; sprite count')]
            fl += [(None, f'{ind}{entry_source(e)}') for e in entries]
            items.append((f, 2 + 5 * len(entries), fl))
        tl = [(None, f'{ind}.word {labels[f]} - {base}') for f in blk['frames']]
        items.append((blk['table'], 2 * len(blk['frames']), tl))
        for a, cmds in blk['scripts'].items():
            if cmds is None:
                continue
            sl = []
            for off, op, args in cmds:
                n, macro, fmt = COMMANDS[op]
                sl.append((off, f'{ind}{macro}' + (' ' + ', '.join(fmt(args)) if n else '')))
            last = cmds[-1]
            items.append((a, last[0] + 1 + len(last[2]) - a, sl))

    # Bytes something points at that are not frames or scripts: Unknown2 / Unknown4,
    # and a script that is not made of commands. Each runs to the next thing
    # anything points at.
    for b, blk in p['blocks'].items():
        bad = [a for a, cmds in blk['scripts'].items() if cmds is None]
        for a in [blk['slots']['Unknown2'], blk['slots']['Unknown4']] + bad:
            if a is None or any(it[0] == a for it in items):
                continue
            others = [it[0] for it in items] + [blk['slots']['Unknown2'] or 0, blk['slots']['Unknown4'] or 0] + bad
            stop = min([o for o in others if o > a] + [blk['end']])
            ul = [(None, f'{ind}.byte ' + ', '.join(f'${x:02X}' for x in raw[i:min(i + 16, stop)]))
                  for i in range(a, stop, 16)]
            if a in bad:
                if 0x17 in raw[a:stop]:
                    ul.insert(0, (None, f'{ind}; Not a script this data can run: command $17 calls '
                                        f'routines in the sprite\'s bank, $7E (RAM), where none starts.'))
                else:
                    ul.insert(0, (None, f'{ind}; Not a valid active sprite script.'))
            items.append((a, stop - a, ul))

    # Lay the items out in order; whatever lies between is kept as bytes.
    items.sort(key=lambda t: t[0])
    merged = []
    for it in items:
        if merged and it[0] < merged[-1][0] + merged[-1][1]:
            prev = merged[-1]
            # A script that is the tail of another: its label goes inside.
            inner = {o for o, _ in prev[2] if o is not None}
            assert it[0] in inner and it[0] + it[1] <= prev[0] + prev[1], \
                f'{name}: overlap at ${it[0]:X}'
            continue
        merged.append(it)
    out = [f'; Map battle sprite data: the format is described in tools/map_battle_layouts.py.', '',
           f'{name}']
    pos = 0
    for off, length, lines in merged:
        if off > pos:
            out += gap(raw, pos, off, labels, ind)
        out.append('')
        if off in labels:
            out.append(labels[off])
        for o, text in lines:
            if o is not None and o != off and o in labels:
                out.append(labels[o])     # a script that is the tail of this one
            out.append(text)
        pos = off + length
    if p['end'] > pos:
        out += gap(raw, pos, p['end'], labels, ind)
    out += ['', f"{ind}MAP_BATTLE_SPRITE_DATA_END ${p['size']:X}", '']
    return '\n'.join(out)


def gap(raw, start, stop, labels, ind):
    """Bytes no offset reaches: an END ($01) after some scripts, and in two streams
    a whole script. Written as commands when they are commands, else as bytes."""
    out = ['', f'{ind}; not reached by any offset']
    cmds = parse_script(raw, start, stop)
    if cmds and cmds[-1][0] + 1 + len(cmds[-1][2]) == stop:
        for _, op, args in cmds:
            n, macro, fmt = COMMANDS[op]
            out.append(f'{ind}{macro}' + (' ' + ', '.join(fmt(args)) if n else ''))
        return out
    for i in range(start, stop, 16):
        out.append(f'{ind}.byte ' + ', '.join(f'${b:02X}' for b in raw[i:min(i + 16, stop)]))
    return out


PRELUDE = '''.cpu "65816"
.include "{root}/include/Sprites.h"
.include "{root}/include/ActiveSpriteEngine.h"
* = 0
.include "{src}"
'''


def assemble(src, out):
    with tempfile.TemporaryDirectory() as tmp:
        wrapper = os.path.join(tmp, 'wrap.asm')
        tmp_out = os.path.join(tmp, 'out.bin')
        with open(wrapper, 'w', encoding='utf-8') as f:
            f.write(PRELUDE.format(
                root=ROOT.replace('\\', '/'),
                src=os.path.abspath(src).replace('\\', '/'),
            ))
        exe = next((x for x in (os.path.join(ROOT, 'tools', '64tass.exe'), os.path.join(ROOT, 'tools', '64tass'))
                    if os.path.exists(x)), '64tass')
        r = subprocess.run([exe, '-q', '--nostart', '-Wall', '-Wno-portable', '-Wno-shadow',
                            '-o', tmp_out, wrapper], capture_output=True, text=True)
        if r.returncode:
            sys.exit(f'{src}: 64tass failed\n{r.stdout}{r.stderr}')
        with open(tmp_out, 'rb') as f:
            data = f.read()
    if len(data) > MAX_SIZE:
        sys.exit(f'{src}: {len(data):#x} bytes, more than a side\'s ${MAX_SIZE:X}-byte buffer')
    with open(out, 'wb') as f:
        f.write(data)
    return data


def decompress_comp(path):
    from decompress import decompress
    data = open(path, 'rb').read()
    buf = bytearray(0x400000)
    buf[:len(data)] = data
    return decompress(bytes(buf), 0xC00000)[0]


def _comp_map():
    return {os.path.basename(c)[:-len('.bin.comp')]: c
            for c in sorted(glob.glob(BUILD_PATTERN + '.bin.comp'))}


def build():
    deps_mtime = max(os.path.getmtime(os.path.join(ROOT, p))
                     for p in ('include/Sprites.h', 'include/ActiveSpriteEngine.h'))
    comps = _comp_map()
    n = 0
    for src in sorted(glob.glob(os.path.join(SRC_DIR, 'aMapBattle*Layout*.asm'))):
        name = os.path.basename(src)[:-4]
        if name not in comps:
            sys.exit(f'tools/map_battle_layouts.py: no .bin.comp for {src}')
        out = comps[name][:-len('.comp')]
        if not os.path.exists(out) or max(os.path.getmtime(src), deps_mtime) > os.path.getmtime(out):
            assemble(src, out)
            n += 1
    return n


def clean():
    for comp in _comp_map().values():
        p = comp[:-len('.comp')]
        if os.path.exists(p):
            os.remove(p)


def self_test():
    comps = sorted(glob.glob(BUILD_PATTERN + '.bin.comp'))
    assert len(comps) == 120, f'expected 120 streams, found {len(comps)}'
    committed = 0
    with tempfile.TemporaryDirectory() as tmp:
        for c in comps:
            name = os.path.basename(c)[:-len('.bin.comp')]
            raw = decompress_comp(c)
            src = os.path.join(tmp, name + '.asm')
            open(src, 'w').write(to_source(raw, name))
            got = assemble(src, os.path.join(tmp, name + '.bin'))
            assert got == raw, f'{name}: decode/assemble differs'
            mine = os.path.join(SRC_DIR, name + '.asm')
            if os.path.exists(mine):
                assert assemble(mine, os.path.join(tmp, name + '.c.bin')) == raw, \
                    f'{name}: committed source does not assemble to the stream'
                committed += 1

        # An edit that changes sizes: one more sprite in the first frame of the
        # first block. Everything after it moves; the parsed structure must not change.
        name = 'aMapBattleCavalierLayout0'
        raw = decompress_comp(glob.glob(BUILD_PATTERN.replace('aMapBattle*Layout*', name) + '.bin.comp')[0])
        text = to_source(raw, name)
        first = re.search(r'\n(_\w+Frame00)\n  \.word (\d+) ; sprite count\n(  \.structSpriteEntry[^\n]*)\n', text)
        edited = text.replace(first.group(0), f'\n{first.group(1)}\n  .word {int(first.group(2)) + 1} ; sprite count\n'
                              f'{first.group(3)}\n{first.group(3)}\n', 1)
        src = os.path.join(tmp, 'edit.asm')
        open(src, 'w').write(edited)
        new = assemble(src, os.path.join(tmp, 'edit.bin'))
        a, b = parse(raw), parse(new)

        def shape(p, data):
            out = []
            for blk in p['blocks'].values():
                frames = [parse_frame(data, f) for f in blk['frames']]
                scripts = sorted([(name, [(op, args) for _, op, args in blk['scripts'][at] or []])
                                  for name, at in blk['slots'].items() if at in blk['scripts']])
                out.append((frames, scripts))
            return out
        sa, sb = shape(a, raw), shape(b, new)
        assert sb[0][0][0] == sa[0][0][0][:1] + sa[0][0][0], 'edited frame did not gain the sprite'
        sb[0][0][0] = sa[0][0][0]
        assert sa == sb, 'adding a sprite changed other frames or scripts'
        assert list(b['blocks'])[1] == list(a['blocks'])[1] + 5, 'later blocks did not move by 5 bytes'

        over_src = os.path.join(tmp, 'over.asm')
        over_out = os.path.join(tmp, 'over.bin')
        with open(over_src, 'w', encoding='utf-8') as f:
            f.write(f'  .fill ${MAX_SIZE + 1:X}, 0\n')
        try:
            assemble(over_src, over_out)
        except SystemExit:
            pass
        else:
            raise AssertionError('oversized layout should fail')
        assert not os.path.exists(over_out), 'failed assemble left output file behind'
    print(f'120 of 120 map battle sprite data streams decode and assemble byte-identical '
          f'({committed} committed sources checked); a 5-byte frame edit moves the rest and keeps every script')


def main():
    ap = argparse.ArgumentParser(description=__doc__.split('\n')[0])
    ap.add_argument('--self-test', action='store_true')
    sub = ap.add_subparsers(dest='cmd')
    p = sub.add_parser('decode')
    p.add_argument('bin')
    p.add_argument('out')
    p = sub.add_parser('assemble')
    p.add_argument('src')
    p.add_argument('out')
    sub.add_parser('build')
    sub.add_parser('clean')
    args = ap.parse_args()
    if args.self_test:
        self_test()
    elif args.cmd == 'decode':
        raw = open(args.bin, 'rb').read()
        name = os.path.basename(args.bin).split('.')[0]
        open(args.out, 'w').write(to_source(raw, name))
    elif args.cmd == 'assemble':
        assemble(args.src, args.out)
    elif args.cmd == 'build':
        build()
    elif args.cmd == 'clean':
        clean()
    else:
        ap.print_help()


if __name__ == '__main__':
    main()
