#!/usr/bin/env python3
"""The colours a battle scene effect layer is shown in, traced from its scripts.

usage: tools/battle_scene_palettes.py TILEMAP_LABEL...   (prints the trace)
       tools/battle_scene_palettes.py --self-test

Used by tools/battle_effects.py unpack to write the palette specs of the
gfx/effects/battle_scene/ manifests; the colours are for previews only (grid
layers pack from their CSVs, whatever the colours).

A battle scene effect script (aBattleSceneEffectOffsetTable, 77 scripts; started
by rlBattleSceneStartScript from the table at $97/8F7D) is a list of command
words, one word each (rsBattleSceneScriptNextCommand moves on two bytes;
$FFF8-$FFFF are control words, $FFFF ends). A command word's bits 9-13 pick the
handler, bits 0-8 are its argument. The commands that matter here:

- 1 (rlBattleSceneCommandDecompressToVRAM): entry arg of
  aBattleSceneDecompressToVRAMTable; 20 is the same with arg+1 when the
  attacker's flag is set. This is how a layer's tilemap is loaded.
- 14 (rlBattleSceneCommandLoadColors): entry arg of aBattleScenePaletteCopyTable
  ($97/AFE5): first color, count, long source; little-endian colors copied
  into aBGPaletteBuffer.
- 11 (rlBattleSceneCommandPaletteEffect): entry arg of aBattleScenePaletteEffects
  (PALETTE_EFFECT_*: slot, type, first color, count, data). Types 0, 1, 2 and
  12 read their data as a stream of frames, each an optional delay byte
  $80 | n and Count colors stored big-endian (lda then xba; a color's high
  byte never has bit 7 set, which is how a delay byte is told apart), $FE
  restarts, $FF ends. Types 7 and 10 read Count little-endian colors.

The trace takes the first script that loads the layer (command 1 or 20, or
command 6 through aBattleSceneDecompressTable) and writes colors, and applies
its color commands in order: command 14 as it copies; for an effect
of type 0, its brightest frame (an effect that fades in starts on black); for
types 1, 2 and 12, the colors a full scroll leaves (the first Count colors of
the stream); for 7 and 10, the data. Other types change colors already there
and are skipped. Each write becomes a spec naming the source label and byte
offset (from the address comments of the top-level labels in
engine/battle_scene/data.asm, the original addresses), so the manifest reads
the colors from the source file.
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from decompress import rom_offset

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SCRIPTS = 0x978F7D
SCRIPT_COUNT = 77
DECOMP_TABLE = 0x97B081
COPY_TABLE = 0x97AFE5
EFFECT_TABLE = 0x97A9A8
STREAM_TYPES = (0, 1, 2, 12)
DIRECT_TYPES = (7, 10)


def _rom():
    return open(os.path.join(ROOT, 'fe4.sfc'), 'rb').read()


def _word(rom, a):
    o = rom_offset(a)
    return rom[o] | rom[o + 1] << 8


def _long(rom, a):
    o = rom_offset(a)
    return rom[o] | rom[o + 1] << 8 | rom[o + 2] << 16


DATA_ASM = 'engine/battle_scene/data.asm'
DEF_RE = __import__('re').compile(r'^\s+([A-Za-z_]\w*) ; ([0-9A-F]{2})/([0-9A-F]{4})\s*$')


def data_labels():
    """{ROM file offset: label} for the top-level labels of engine/battle_scene/data.asm,
    from their address comments (the original addresses)."""
    out = {}
    for line in open(os.path.join(ROOT, DATA_ASM), encoding='utf-8'):
        m = DEF_RE.match(line)
        if m:
            o = rom_offset(int(m.group(2) + m.group(3), 16))
            if o is not None:
                out.setdefault(o, m.group(1))
    return out


def script_commands(rom, i):
    """[(command, arg, word)] of script i."""
    a = SCRIPTS + _word(rom, SCRIPTS + 2 * i)
    out = []
    while True:
        w = _word(rom, a)
        a += 2
        if w == 0xFFFF:
            return out
        if w >= 0xFFF8:
            continue
        out.append(((w >> 9) & 31, w & 0x1FF, w))


def decomp_sources(rom):
    """Source address of each aBattleSceneDecompressToVRAMTable entry (10 bytes each)."""
    out = []
    a = DECOMP_TABLE
    while True:
        o = rom_offset(a)
        if a >= DECOMP_TABLE + 10 * 160:
            break
        out.append(rom[o] | rom[o + 1] << 8 | rom[o + 2] << 16)
        a += 10
    return out


def stream_items(rom, data):
    """[(byte offset from data, color)] of a big-endian palette effect stream:
    a byte with bit 7 set before a color is a delay, $FE or $FF ends it."""
    out, p = [], data
    for _ in range(1024):
        o = rom_offset(p)
        b = rom[o]
        if b in (0xFE, 0xFF):
            break
        if b & 0x80:
            p += 1
            continue
        out.append((p - data, rom[o] << 8 | rom[o + 1]))
        p += 2
    return out


def brightness(c):
    return (c & 31) + (c >> 5 & 31) + (c >> 10 & 31)


def trace_script(rom, i):
    """[(first color, colors, source address, stream, note, reversed)] in script order."""
    writes = []
    for cmd, arg, _ in script_commands(rom, i):
        if cmd == 14:
            e = COPY_TABLE + _word(rom, COPY_TABLE + 2 * arg)
            o = rom_offset(e)
            first, count, src = rom[o], rom[o + 1], _long(rom, e + 2)
            so = rom_offset(src)
            cols = [rom[so + 2 * k] | rom[so + 2 * k + 1] << 8 for k in range(count)]
            writes.append((first, cols, src, False, f'aBattleScenePaletteCopyTable entry {arg}', False))
        elif cmd == 11:
            e = EFFECT_TABLE + _word(rom, EFFECT_TABLE + 2 * arg)
            o = rom_offset(e)
            slot, kind, first, count = rom[o:o + 4]
            t = kind & 0x3F
            if t in STREAM_TYPES:
                data = _long(rom, e + 4)
                if rom_offset(data) is None:
                    continue
                items = stream_items(rom, data)
                if len(items) < count:
                    continue
                # Type 0 shows frames of count colors; types 1, 2 and 12 scroll one
                # color in at a time, so any count colors in a row are on screen at
                # once (type 2 puts the newest first). Show the brightest.
                starts = range(0, len(items) - count + 1, count if t == 0 else 1)
                k = max(starts, key=lambda j: sum(brightness(c) for _, c in items[j:j + count]))
                cols = [c for _, c in items[k:k + count]]
                rev = t == 2
                if rev:
                    cols = cols[::-1]
                what = f'frame {k // count}' if t == 0 else f'colors {k}-{k + count - 1} (scroll, type {t})'
                writes.append((first, cols, data + items[k][0], True,
                               f'aBattleScenePaletteEffects entry {arg}, {what}, the brightest', rev))
            elif t in DIRECT_TYPES:
                data = _long(rom, e + (5 if t == 7 else 4))
                so = rom_offset(data)
                if so is None:      # data in RAM (type 7 toward $7FF636, a palette operation's copy)
                    continue
                cols = [rom[so + 2 * k] | rom[so + 2 * k + 1] << 8 for k in range(count)]
                writes.append((first, cols, data, False, f'aBattleScenePaletteEffects entry {arg} (type {t})', False))
    return writes


def _table_labels(table):
    """The source label of each entry of a table in engine/battle_scene/script.asm."""
    src = open(os.path.join(ROOT, 'engine/battle_scene/script.asm'), encoding='utf-8').read()
    a = src.index(table + ' ;')
    names = []
    for line in src[a:].split('\n')[1:]:
        t = line.split(';')[0].strip()
        if t.startswith('.long'):
            names.append(t[5:].split(',')[0].strip())
        elif t.startswith('.endsection'):
            break
    return names


def load_sites(tilemap_label):
    """[(command, entry)] that load a label: command 1 (and 20) through
    aBattleSceneDecompressToVRAMTable, command 6 through aBattleSceneDecompressTable."""
    out = []
    for cmd, table in ((1, 'aBattleSceneDecompressToVRAMTable'), (6, 'aBattleSceneDecompressTable')):
        names = _table_labels(table)
        out += [(cmd, i) for i, n in enumerate(names) if n == tilemap_label]
    return out


def scripts_loading(rom, cmd_want, index):
    """Script IDs that load entry index with command cmd_want (1 also counts 20)."""
    out = []
    for i in range(SCRIPT_COUNT):
        for cmd, arg, _ in script_commands(rom, i):
            if (cmd == cmd_want and arg == index) or (cmd_want == 1 and cmd == 20 and index in (arg, arg + 1)):
                out.append(i)
                break
    return out


def specs_for_tilemap(tilemap_label):
    """(palette specs, script ID or None, notes) for a layer's tilemap label."""
    rom = _rom()
    labels = data_labels()
    sites = load_sites(tilemap_label)
    if not sites:
        return [], None, ['in neither decompress table']
    ids = sorted({i for cmd, idx in sites for i in scripts_loading(rom, cmd, idx)})
    if not ids:
        return [], None, ['no script loads it (' + ', '.join(f'command {c} entry {i}' for c, i in sites) + ')']
    specs, notes = [], []
    writes = []
    for sid in ids:
        writes = trace_script(rom, sid)
        if writes:
            break
    if not writes:
        return [], ids[0], [f'scripts {", ".join(f"{i:#04x}" for i in ids)} load it but write no colors']
    # Dimmer writes first, so that where two cover the same colors the brightest
    # (an effect's peak, not its fade from black) is the one shown.
    writes = sorted(writes, key=lambda w: sum(map(brightness, w[1])) / len(w[1]))
    for first, cols, src, big, note, rev in writes:
        so = rom_offset(src)
        base = max((o for o in labels if o <= so), default=None)
        if base is None:
            notes.append(f'{note}: source {src:06X} is not in {DATA_ASM}')
            continue
        label = labels[base]
        spec = {'asm': DATA_ASM, 'label': label, 'byte_offset': so - base,
                'dest': first, 'count': len(cols), 'span_labels': True, 'from': note}
        if big:
            spec['stream'] = True
        if rev:
            spec['reverse'] = True
        specs.append(spec)
    return specs, sid, notes


def self_test():
    rom = _rom()
    n = sum(len(script_commands(rom, i)) for i in range(SCRIPT_COUNT))
    assert n == 1601, n
    # Bolganone's effect fades in from black: its brightest frame is not black.
    writes = [w for i in range(SCRIPT_COUNT) for w in trace_script(rom, i)]
    assert any(w[3] for w in writes), 'no palette effect stream traced'
    assert all(any(c for c in w[1]) for w in writes if w[3]), 'a traced stream frame is all black'
    # Fire's script ($02) colors its layers only through a type 2 scroll (entry 161).
    assert any('entry 161' in w[4] for w in trace_script(rom, 2)), 'type 2 scroll not traced'
    print(f'{n} commands in {SCRIPT_COUNT} scripts; {len(writes)} color writes traced')


if __name__ == '__main__':
    if sys.argv[1:] == ['--self-test']:
        self_test()
    else:
        for lbl in sys.argv[1:]:
            specs, sid, notes = specs_for_tilemap(lbl)
            print(lbl, 'script', sid, notes)
            for s in specs:
                print('  ', s)
