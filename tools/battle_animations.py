#!/usr/bin/env python3
"""Battle scene animation sheets as indexed PNGs, budget validator, and preview renderer.

usage: tools/battle_animations.py unpack [--force]
       tools/battle_animations.py build
       tools/battle_animations.py clean
       tools/battle_animations.py list
       tools/battle_animations.py validate
       tools/battle_animations.py preview OUT_DIR [--class NAME | --record N | --dance]
                                          [--category CAT] [--item ITEM] [--character NAME]
                                          [--gender Male|Female] [--enemy] [--facing left|right]
                                          [--action NAME|N] [--sequence N] [--frames] [--scale N]
                                          [--ids A,B,C,D] [--entry N] [--sheet LABEL]
       tools/battle_animations.py --self-test

Manages the 231 reachable battle-scene sprite streams in gfx/battle_animation/:

- sheets/NAME.png (84): class sheets laid out in frame-row order (each unique
  ANIM_TILE_ROW slice takes ceil(tiles / 16) 16-tile rows, 128 px wide; trailing
  slots in a slice's last row must be colour 0; max $6000 bytes). The layout is
  not stored with the PNG: it is worked out from the slices of every frame
  table that uses the sheet (data/battle_animation/frames_*.asm), which must
  cover it from 0 exactly once. Changing those slices changes the expected
  layout, so the PNG has to be rearranged with them; build stops with a
  message when they no longer fit.

These are tile sheets (tiles in the rows the game uploads them to VRAM), not
pictures of frames; preview draws the frames. gfx_inventory.py counts them as
sheet.

validate also checks the budgets: the $6000-byte sheet buffer, the 16-entry
upload queue (rows past it are dropped; over 8 rows a frame is a warning,
since both combatants share it), $0C00 bytes of tiles a VBlank (a warning:
the rest goes a VBlank late), and 128 sprites a record.

preview takes a lookup record (--record, or the first for --class, narrowed by
--category, --character, --gender), or the dance (--dance). To look at data no
record uses: --ids A,B,C,D gives the four animation IDs in hex (frames, sheet,
extras, palette; 5E,66,46,2E is the dance), --entry N draws entry N of
aBattleAnimationFrameTables instead of the first ID's, and --sheet LABEL takes
the class sheet from that stream (read from its .comp when it has no PNG, as
the unreachable g4bppcBattleAnimationSheet50 and 52 do).
- extras/NAME.png (65): extra tile sheets in 16-tile VRAM rows (128x64 or
  128x80 for Ballisticians), coloured with the first user's palette.
- weapons/NAME.png (64): weapon tile sheets (128x16, 32 tiles for VRAM $40-$5F).
- pieces/NAME.png (18): character piece sheets (128x16; tiles 0-23 = $300 bytes
  DMA'd to VRAM $60-$77; tiles 24-31 in the bottom-right 64x8 must be colour 0).

All subcommands except --self-test read directly from the repository's source
files (gfx/battle_animation/, data/battle_animation/frames_98-9B.asm, moves.asm,
data/palettes/BattleAnimationPalettes.asm, engine/battle_scene/animations.asm,
data.asm, rounds.asm) without requiring a built ROM.
"""
import argparse
import collections
import glob
import os
import re
import sys
import tempfile

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from decompress import decompress, rom_offset
from gen_offsets import read_csv_names
import gfx
import map_sprites as ms

try:
    from PIL import Image
except ImportError:
    sys.exit('tools/battle_animations.py needs Pillow: pip3 install pillow')

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
GFX_DIR = os.path.join(ROOT, 'gfx', 'battle_animation')
ANIM_ASM = os.path.join(ROOT, 'engine', 'battle_scene', 'animations.asm')
DATA_ASM = os.path.join(ROOT, 'engine', 'battle_scene', 'data.asm')
ROUNDS_ASM = os.path.join(ROOT, 'engine', 'battle_scene', 'rounds.asm')
PAL_ASM = os.path.join(ROOT, 'data', 'palettes', 'BattleAnimationPalettes.asm')
BUILD_ASM = os.path.join(ROOT, 'build.asm')
FRAMES_GLOB = os.path.join(ROOT, 'data', 'battle_animation', 'frames_*.asm')
MOVES_ASM = os.path.join(ROOT, 'data', 'battle_animation', 'moves.asm')

TILE = 32
MAX_SHEET_BYTES = 0x6000       # $7F0000 vs $7F6000 in rsBattleSceneLoadSheet
# rlBattleSceneRunUploads sends up to $0C00 bytes a VBlank and leaves the rest
# queued for the next one: more is not lost, only late (a soft budget).
FRAME_DMA_BUDGET = 0x0C00
# rlBattleSceneQueueUpload holds 16 uploads and sets carry when full;
# rsBattleAnimationQueueFrameRows ignores the carry, so rows past it are
# dropped. Both combatants share the queue, so a frame over 8 rows can drop
# rows when the other combatant changes frame in the same VBlank.
UPLOAD_QUEUE = 16
MAX_OAM_SPRITES = 128          # SNES OAM table limit

CATEGORIES = {
    'AnimCategorySword': 0, 'AnimCategoryLance': 1, 'AnimCategoryAxe': 2,
    'AnimCategoryBow': 3, 'AnimCategoryRangedSword': 4, 'AnimCategoryRangedLance': 5,
    'AnimCategoryRangedAxe': 6, 'AnimCategoryMagic': 7, 'AnimCategoryStaff': 8,
    'AnimCategoryAny': 9,
}
CAT_NAMES = {v: k[len('AnimCategory'):] for k, v in CATEGORIES.items()}
SHORT_CAT = {v.lower(): k for k, v in CAT_NAMES.items()}

ATTACK_STYLES = {
    'AttackStyleSword': 0, 'AttackStyleLance': 2, 'AttackStyleAxe': 3,
    'AttackStyleRanged': 4, 'AttackStyleMagic': 5, 'AttackStyleStaff': 6,
}

GENDERS = {'GenderMale': 0, 'GenderFemale': 1, 'Genderless': 0xFF}

DANCE_IDS = (0x5E, 0x66, 0x46, 0x2E)

COMMANDS = {
    'ANIM_END': 0xFF, 'ANIM_HOLD': 0xFE, 'ANIM_RESTART': 0xFD, 'ANIM_BACK': 0xFC,
    'ANIM_WAIT': 0xFB, 'ANIM_SOUND': 0xFA, 'ANIM_NOP': 0xF9, 'ANIM_CMD_F8': 0xF8,
    'ANIM_CLEAR_BUSY': 0xF7, 'ANIM_SET_BUSY': 0xF6, 'ANIM_CMD_F5': 0xF5,
    'ANIM_CMD_F4': 0xF4, 'ANIM_CMD_F3': 0xF3, 'ANIM_CMD_F2': 0xF2,
    'ANIM_CMD_F1': 0xF1, 'ANIM_CMD_F0': 0xF0, 'ANIM_CMD_EF': 0xEF,
    'ANIM_CMD_EE': 0xEE, 'ANIM_CMD_ED': 0xED, 'ANIM_CMD_EC': 0xEC,
    'ANIM_CMD_EB': 0xEB, 'ANIM_CMD_EA': 0xEA, 'ANIM_CMD_E9': 0xE9,
    'ANIM_CMD_E8': 0xE8,
}

ROUTINES = [
    'AnimMoveJumpPastOpponent', 'AnimMoveHopToOpponent', 'AnimMoveLeapToOpponent',
    'AnimMoveAdvance80', 'AnimMoveCoastLinear', 'AnimMoveCoastHalving',
    'AnimMoveGlideToOpponent', 'AnimMoveNoDefaultGravity', 'AnimMoveToOpponentSpeedA',
    'AnimMoveToOpponentSpeedB', 'AnimMoveJumpToOpponent', 'AnimMoveJumpInPlace',
    'AnimMoveJumpTo40', 'AnimMoveJumpTo80', 'AnimMoveAdvancePastOpponent',
    'AnimMoveJumpTo16', 'AnimMoveLaunchAwayFromAttacker', 'AnimMoveDrift',
]
ROUTINE_IDS = {name: i for i, name in enumerate(ROUTINES)}

KNOWN_BAD_SEQUENCES = {
    ('aBattleAnimationSequencesBarbarianAxe', '_Sequence17'),
    ('aBattleAnimationSequencesGeneralRangedLance', '_Sequence05'),
    ('aBattleAnimationSequencesGeneralRangedLance', '_Sequence06'),
}

PREFIXES = {
    'sheets': 'g4bppcBattleAnimationSheet',
    'extras': 'g4bppcBattleAnimationExtra',
    'weapons': 'g4bppcBattleWeapon',
    'pieces': 'g4bppcBattleCharacterPiece',
}


def _int(s):
    s = s.strip()
    if s.startswith('$'):
        return int(s[1:], 16)
    return int(s, 0)


def _strip_comment(line):
    return line.split(';', 1)[0].strip()


# --- Source Parsers ----------------------------------------------------------

def load_constants():
    classes = read_csv_names('data/class/ClassData.csv', 1)
    chars = read_csv_names('data/character/CharacterData.csv', 3)
    items = read_csv_names('data/item/ItemData.csv', 2)
    sym = {}
    for i, n in enumerate(classes):
        sym[n] = i
    for i, n in enumerate(chars, 1):
        sym[n] = i
    sym['AnimAnyCharacter'] = 0
    for i, n in enumerate(items):
        sym[n] = i
    sym.update(CATEGORIES)
    sym.update(ATTACK_STYLES)
    sym.update(GENDERS)
    return classes, chars, items, sym


def _parse_bytes(text):
    out = []
    for line in text.splitlines():
        s = _strip_comment(line)
        if s.startswith('.byte'):
            for v in s[5:].split(','):
                out.append(_int(v))
    return out


def _parse_words(text):
    out = []
    for line in text.splitlines():
        s = _strip_comment(line)
        if s.startswith('.word'):
            for v in s[5:].split(','):
                out.append(_int(v))
    return out


def load_animations_tables(sym):
    src = open(ANIM_ASM, encoding='utf-8').read()

    def sec(start_lbl, end_lbl):
        i = src.index(start_lbl)
        j = src.index(end_lbl, i)
        return src[i:j]

    sheet_indices = _parse_bytes(sec('aBattleAnimationSheetIndices ;', 'aBattleAnimationSheets ;'))
    sheets = re.findall(r'\.long\s+([A-Za-z_]\w*)',
                        sec('aBattleAnimationSheets ;', '.endsection BattleAnimationSheetsSection'))

    extra_indices = _parse_bytes(sec('aBattleAnimationExtraIndices ;', 'aBattleAnimationExtras ;'))
    extras = []
    cur_pair = None
    for line in sec('aBattleAnimationExtras ;', 'aBattleAnimationPaletteIndices ;').splitlines():
        s = _strip_comment(line)
        if s.startswith('.byte'):
            parts = [_int(x) for x in s[5:].split(',')]
            cur_pair = (parts[0], parts[1])
        elif s.startswith('.long') and cur_pair is not None:
            extras.append((cur_pair[0], cur_pair[1], s[5:].strip()))
            cur_pair = None

    palette_indices = _parse_bytes(sec('aBattleAnimationPaletteIndices ;', 'aBattleAnimationPalettes ;'))
    palettes = []
    cur_pal = None
    for line in sec('aBattleAnimationPalettes ;', 'aBattleAnimationPaletteOverrides ;').splitlines():
        s = _strip_comment(line)
        if s.startswith('.long'):
            cur_pal = s[5:].strip()
        elif s.startswith('.byte') and cur_pal is not None:
            palettes.append((cur_pal, _int(s[5:])))
            cur_pal = None

    pal_overrides = []
    ov_lines = sec('aBattleAnimationPaletteOverrides ;', '.endsection BattleAnimationExtrasSection').splitlines()
    cur_char = None
    for line in ov_lines:
        s = _strip_comment(line)
        if s.startswith('.word'):
            v = s[5:].strip()
            if v == '$FFFF':
                break
            cur_char = sym[v] if v in sym else _int(v)
        elif s.startswith('.byte') and cur_char is not None:
            parts = [x.strip() for x in s[5:].split(',')]
            cls_id = sym[parts[0]] if parts[0] in sym else _int(parts[0])
            pal_overrides.append((cur_char, cls_id, _int(parts[1])))
            cur_char = None

    frame_indices = _parse_bytes(sec('aBattleAnimationFrameIndices ;', 'aBattleAnimationFrameTables ;'))
    frame_tables = []
    for line in sec('aBattleAnimationFrameTables ;', 'aBattleAnimationLookup ;').splitlines():
        s = _strip_comment(line)
        if s.startswith('.long'):
            a, b = [x.strip() for x in s[5:].split(',')]
            frame_tables.append((a, b))

    lookup = []
    for line in sec('aBattleAnimationLookup ;', '.endsection BattleAnimationFramesSection').splitlines():
        s = _strip_comment(line)
        if s.startswith('.structBattleAnimationLookupEntry'):
            parts = [x.strip() for x in s[len('.structBattleAnimationLookupEntry'):].split(',')]
            lookup.append(tuple(sym[p] if p in sym else _int(p) for p in parts))

    program_indices = _parse_bytes(sec('aBattleAnimationProgramIndices ;', 'aBattleAnimationPrograms ;'))
    programs = []
    for line in sec('aBattleAnimationPrograms ;', '.endsection BattleAnimationProgramsSection').splitlines():
        s = _strip_comment(line)
        if s.startswith('.long'):
            parts = [x.strip() for x in s[5:].split(',')]
            programs.append(tuple(parts))

    # Character pieces
    cp_sec = sec('aBattleCharacterPieceLookup ;', 'aBattleCharacterPieces ;')
    cp_lists = {}
    cur_list_lbl = None
    cur_cls = None
    cp_class_map = {}
    for line in cp_sec.splitlines():
        s = _strip_comment(line)
        if not s:
            continue
        m = re.match(r'^([A-Za-z_]\w*)\b', line.strip())
        if m and m.group(1).startswith('aBattleCharacterPieceList'):
            cur_list_lbl = m.group(1)
            cp_lists[cur_list_lbl] = []
        elif cur_list_lbl is None:
            if s.startswith('.byte'):
                v = s[5:].strip()
                cur_cls = sym[v] if v in sym else _int(v)
            elif s.startswith('.word'):
                v = s[5:].strip()
                if v == '$FFFF':
                    if cur_cls is not None:
                        cp_class_map[cur_cls] = None
                        cur_cls = None
                else:
                    target = v.split('-')[0].strip()
                    cp_class_map[cur_cls] = target
                    cur_cls = None
        else:
            if s.startswith('.word'):
                parts = [x.strip() for x in s[5:].split(',')]
                if len(parts) == 2:
                    ch = sym[parts[0]] if parts[0] in sym else _int(parts[0])
                    val = _int(parts[1])
                    cp_lists[cur_list_lbl].append((ch, val & 0xFF, val >> 8))
                elif parts[0] != '$FFFF':
                    val = _int(parts[0])
                    cp_lists[cur_list_lbl].append((None, val & 0xFF, val >> 8))
    cp_lookup = {cls_id: cp_lists[lbl] if lbl else None for cls_id, lbl in cp_class_map.items()}
    char_pieces = re.findall(r'\.long\s+([A-Za-z_]\w*)',
                             sec('aBattleCharacterPieces ;', '.endsection BattleCharacterPiecesSection'))

    weapon_indices = []
    for line in sec('aBattleWeaponGraphicsIndices ;', 'aBattleWeaponGraphics ;').splitlines():
        s = _strip_comment(line)
        if s.startswith('.byte'):
            a, b = [_int(x) for x in s[5:].split(',')]
            weapon_indices.append((a, b))
    weapons = re.findall(r'\.long\s+([A-Za-z_]\w*)',
                         sec('aBattleWeaponGraphics ;', 'aBattleSceneAnimSprite9988E2 ;'))

    return {
        'sheet_indices': sheet_indices, 'sheets': sheets,
        'extra_indices': extra_indices, 'extras': extras,
        'palette_indices': palette_indices, 'palettes': palettes,
        'palette_overrides': pal_overrides,
        'frame_indices': frame_indices, 'frame_tables': frame_tables,
        'lookup': lookup,
        'program_indices': program_indices, 'programs': programs,
        'cp_lookup': cp_lookup, 'char_pieces': char_pieces,
        'weapon_indices': weapon_indices, 'weapons': weapons,
    }


def _bgr555_to_rgb(w):
    return tuple((w >> s & 31) * 255 // 31 for s in (0, 5, 10))


def _eval_pal_word(expr):
    expr = expr.strip()
    m = re.match(r'^bgr555\(\s*(\d+)\s*,\s*(\d+)\s*,\s*(\d+)\s*\)$', expr)
    if m:
        r, g, b = int(m.group(1)), int(m.group(2)), int(m.group(3))
        return r | (g << 5) | (b << 10)
    return _int(expr)


def load_palettes():
    """Parse BattleAnimationPalettes.asm + data.asm character colors in build.asm section order."""
    build_txt = open(BUILD_ASM, encoding='utf-8').read()
    sec_order = re.findall(r'\.dsection\s+(BattleAnimationPalettes\w+Section)', build_txt)

    pal_txt = open(PAL_ASM, encoding='utf-8').read()
    sections = {}
    cur_sec = None
    cur_words = None
    cur_labels = None
    for line in pal_txt.splitlines():
        s = _strip_comment(line)
        if not s:
            continue
        if s.startswith('.section '):
            cur_sec = s.split()[1]
            cur_words = []
            cur_labels = {}
        elif s.startswith('.endsection'):
            sections[cur_sec] = (cur_words, cur_labels)
            cur_sec = None
        elif cur_sec is not None:
            if s.startswith('.word'):
                # split on ', ' outside bgr555(...)
                rest = s[5:].strip()
                parts = re.findall(r'bgr555\([^)]+\)|\$[0-9A-Fa-f]+|\d+', rest)
                for p in parts:
                    cur_words.append(_eval_pal_word(p))
            else:
                m = re.match(r'^([A-Za-z_]\w*)\b', s)
                if m:
                    cur_labels[m.group(1)] = len(cur_words)

    flat_words = []
    label_word_off = {}
    for sec_name in sec_order:
        if sec_name not in sections:
            continue
        words, labels = sections[sec_name]
        base = len(flat_words)
        flat_words.extend(words)
        for lbl, off in labels.items():
            label_word_off[lbl] = base + off

    # Also parse data.asm character colors
    data_txt = open(DATA_ASM, encoding='utf-8').read()
    cc_sec = data_txt[data_txt.index('aBattleSceneCharacterColorIndices ;'):data_txt.index('aBattleSceneBarehandedClasses ;')]
    char_color_idx = {}
    cur_ch = None
    for line in cc_sec.splitlines():
        s = _strip_comment(line)
        if s.startswith('.word'):
            v = _int(s[5:])
            if v == 0xFFFF:
                break
            cur_ch = v
        elif s.startswith('.byte') and cur_ch is not None:
            char_color_idx[cur_ch] = _int(s[5:])
            cur_ch = None

    cc_words = _parse_words(data_txt[data_txt.index('aBattleSceneCharacterColors ;'):data_txt.index('.endsection DataE00060Section')])
    return {
        'words': flat_words,
        'label_off': label_word_off,
        'char_color_idx': char_color_idx,
        'char_colors': cc_words,
    }


def get_combatant_palette(pal_db, label, byte_count, enemy=False):
    off = pal_db['label_off'][label]
    n = byte_count // 2
    if enemy and off + 2 * n <= len(pal_db['words']):
        off += n
    return [_bgr555_to_rgb(w) for w in pal_db['words'][off:off + n]]


def get_weapon_palette(pal_db, pal_idx):
    off = pal_db['label_off']['aBattleWeaponPaletteIronSword'] + pal_idx * 15
    return [_bgr555_to_rgb(w) for w in pal_db['words'][off:off + 15]]


def get_piece_palette(pal_db, pal_idx):
    off = pal_db['label_off']['aBattleCharacterPiecePaletteAzelle'] + pal_idx * 9
    return [_bgr555_to_rgb(w) for w in pal_db['words'][off:off + 9]]


def load_frames_data():
    """Parse data/battle_animation/frames_*.asm into frame tables, sequences, and records."""
    ftables = {}
    seq_blocks = {}
    frames_by_key = {}
    recs_by_key = {}
    seqs_by_key = {}

    def resolve_ref(ref_str, cur_top):
        target = ref_str.split('-')[0].strip()
        if '.' in target:
            top, loc = target.split('.', 1)
            return (top, loc)
        return (cur_top, target)

    for path in sorted(glob.glob(FRAMES_GLOB)):
        txt = open(path, encoding='utf-8').read()
        cur_top = None
        cur_kind = None  # 'ftab' or 'seq'
        pending_locals = []
        mode = None      # 'index', 'list', 'frame', 'record', 'seq'
        cur_frame_rows = None
        cur_rec_frame = None
        cur_rec_sprites = None
        cur_seq_steps = None

        def flush_seq():
            nonlocal cur_seq_steps
            if cur_seq_steps is not None:
                for loc in pending_locals:
                    if loc.startswith('_Sequence'):
                        seqs_by_key[(cur_top, loc)] = cur_seq_steps
                cur_seq_steps = None

        for raw_line in txt.splitlines():
            s = _strip_comment(raw_line)
            if not s or s.startswith('.section') or s.startswith('.endsection'):
                if s.startswith('.endsection'):
                    flush_seq()
                continue

            if s.startswith('aBattleAnimationFrames'):
                flush_seq()
                pending_locals = []
                mode = None
                cur_top = s.split()[0]
                cur_kind = 'ftab'
                ftables[cur_top] = []
                continue
            if s.startswith('aBattleAnimationSequences'):
                flush_seq()
                pending_locals = []
                mode = None
                cur_top = s.split()[0]
                cur_kind = 'seq'
                seq_blocks[cur_top] = {'seqs': [], 'recs': []}
                continue

            if s.startswith('_'):
                if s == '_Index':
                    flush_seq()
                    pending_locals = []
                    mode = 'index'
                elif s == '_Records':
                    flush_seq()
                    pending_locals = []
                    mode = 'list'
                elif s.startswith('_Frame'):
                    flush_seq()
                    pending_locals = [s]
                    mode = 'frame_wait'
                elif s.startswith('_Sequence') or s.startswith('_Record'):
                    if mode == 'seq':
                        # A new _Sequence or _Record label inside a sequence: if it's _Sequence,
                        # another sequence starts at the same or next position.
                        if s.startswith('_Record'):
                            flush_seq()
                            pending_locals.append(s)
                            mode = 'record_wait'
                        else:
                            # _Sequence label: keep accumulating pending_locals if we're waiting
                            # or flush previous sequence and start new one
                            if cur_seq_steps is not None:
                                flush_seq()
                            pending_locals.append(s)
                            mode = 'seq'
                            cur_seq_steps = []
                    else:
                        pending_locals.append(s)
                        if s.startswith('_Record'):
                            mode = 'record_wait'
                continue

            if s.startswith('.word ') and cur_kind == 'ftab':
                ftables[cur_top].append(resolve_ref(s[6:], cur_top))
            elif s.startswith('.word ') and mode == 'index':
                seq_blocks[cur_top]['seqs'].append(resolve_ref(s[6:], cur_top))
            elif s.startswith('.word ') and mode == 'list':
                seq_blocks[cur_top]['recs'].append(resolve_ref(s[6:], cur_top))
            elif s == 'ANIM_TILES':
                cur_frame_rows = []
                mode = 'frame'
            elif s.startswith('ANIM_TILE_ROW '):
                off, sz = [_int(x) for x in s[len('ANIM_TILE_ROW '):].split(',')]
                cur_frame_rows.append((off, sz))
            elif s == 'ANIM_TILES_END':
                for loc in pending_locals:
                    if loc.startswith('_Frame'):
                        frames_by_key[(cur_top, loc)] = cur_frame_rows
                pending_locals = []
                cur_frame_rows = None
                mode = None
            elif s.startswith('ANIM_RECORD '):
                arg = s[len('ANIM_RECORD '):].strip()
                cur_rec_frame = None if arg == 'ANIM_KEEP_TILES' else _int(arg)
                cur_rec_sprites = []
                mode = 'record'
                # If a _SequenceNN label sits on this ANIM_RECORD ANIM_KEEP_TILES ($FF = ANIM_END),
                # record that sequence as [('ANIM_END', 0)].
                for loc in pending_locals:
                    if loc.startswith('_Sequence'):
                        seqs_by_key[(cur_top, loc)] = [('ANIM_END', 0)]
            elif s.startswith('.structSpriteEntry '):
                # .structSpriteEntry ( x, y), AttrBits, Size, Index, Priority, Palette, HFlip, VFlip
                rest = s[len('.structSpriteEntry '):].strip()
                m = re.match(r'^\(\s*(-?\d+)\s*,\s*(-?\d+)\s*\)\s*,\s*(.+)$', rest)
                x, y = int(m.group(1)), int(m.group(2))
                parts = [p.strip() for p in m.group(3).split(',')]
                size = 16 if parts[1] == 'SpriteLarge' else 8
                tile = _int(parts[2])
                pal = _int(parts[4])
                hflip = parts[5] == 'true'
                vflip = parts[6] == 'true'
                cur_rec_sprites.append((x, y, size, tile, pal, hflip, vflip))
            elif s == 'ANIM_RECORD_END':
                for loc in pending_locals:
                    if loc.startswith('_Record'):
                        recs_by_key[(cur_top, loc)] = (cur_rec_frame, cur_rec_sprites)
                pending_locals = []
                cur_rec_frame = None
                cur_rec_sprites = None
                mode = None
            elif s.startswith('ANIM_STEP '):
                if mode != 'seq':
                    cur_seq_steps = []
                    mode = 'seq'
                rec_idx, dur = [_int(x) for x in s[len('ANIM_STEP '):].split(',')]
                cur_seq_steps.append(('STEP', rec_idx, dur))
            elif s.startswith('ANIM_'):
                if mode != 'seq':
                    cur_seq_steps = []
                    mode = 'seq'
                parts = s.split(None, 1)
                cmd = parts[0]
                arg = _int(parts[1]) if len(parts) > 1 else 0
                cur_seq_steps.append((cmd, arg))
                if cmd in ('ANIM_END', 'ANIM_HOLD'):
                    flush_seq()
                    pending_locals = []
                    mode = None

    return ftables, seq_blocks, frames_by_key, recs_by_key, seqs_by_key


def load_moves_data():
    """Parse data/battle_animation/moves.asm."""
    txt = open(MOVES_ASM, encoding='utf-8').read()
    actions = {}
    move_lists = {}
    move_scripts = {}
    cur_lbl = None
    mode = None
    cur_list_idx = None
    cur_script_idx = None

    for line in txt.splitlines():
        s = _strip_comment(line)
        if not s or s.startswith('.section') or s.startswith('.endsection'):
            continue
        if s.startswith('aBattleAnimationActions'):
            cur_lbl = s.split()[0]
            actions[cur_lbl] = []
            mode = 'actions'
        elif s.startswith('aBattleAnimationMoveLists'):
            cur_lbl = s.split()[0]
            move_lists[cur_lbl] = {'order': [], 'lists': {}}
            mode = 'list_table'
        elif s.startswith('aBattleAnimationMoveScripts'):
            cur_lbl = s.split()[0]
            move_scripts[cur_lbl] = {'order': [], 'scripts': {}}
            mode = 'script_table'
        elif mode == 'actions':
            if s.startswith('ANIM_ACTION_LIST '):
                actions[cur_lbl].append(('LIST', _int(s[len('ANIM_ACTION_LIST '):])))
            elif s.startswith('ANIM_ACTION_SEQUENCE '):
                actions[cur_lbl].append(('SEQ', _int(s[len('ANIM_ACTION_SEQUENCE '):])))
        elif mode == 'list_table':
            if s.startswith('.word '):
                move_lists[cur_lbl]['order'].append(s[6:].split('-')[0].strip())
            elif s.startswith('_List'):
                cur_list_idx = s
                move_lists[cur_lbl]['lists'][cur_list_idx] = []
                mode = 'list_body'
        elif mode == 'list_body':
            if s.startswith('_List'):
                cur_list_idx = s
                move_lists[cur_lbl]['lists'][cur_list_idx] = []
            elif s.startswith('ANIM_MOVE_SCRIPT '):
                seq, scr = [_int(x) for x in s[len('ANIM_MOVE_SCRIPT '):].split(',')]
                move_lists[cur_lbl]['lists'][cur_list_idx].append(('script', seq, scr, None))
            elif s.startswith('ANIM_MOVE_STILL '):
                seq = _int(s[len('ANIM_MOVE_STILL '):])
                move_lists[cur_lbl]['lists'][cur_list_idx].append(('still', seq, None, None))
            elif s.startswith('ANIM_MOVE_ROUTINE '):
                seq_s, rtn_s = [x.strip() for x in s[len('ANIM_MOVE_ROUTINE '):].split(',')]
                move_lists[cur_lbl]['lists'][cur_list_idx].append(('routine', _int(seq_s), ROUTINE_IDS[rtn_s], None))
            elif s.startswith('ANIM_MOVE_JUMP '):
                parts = [x.strip() for x in s[len('ANIM_MOVE_JUMP '):].split(',')]
                move_lists[cur_lbl]['lists'][cur_list_idx].append(
                    ('jump', _int(parts[0]), ROUTINE_IDS[parts[1]], (_int(parts[2]), _int(parts[3])))
                )
        elif mode == 'script_table':
            if s.startswith('.word '):
                move_scripts[cur_lbl]['order'].append(s[6:].split('-')[0].strip())
            elif s.startswith('_Script'):
                cur_script_idx = s
                move_scripts[cur_lbl]['scripts'][cur_script_idx] = []
                mode = 'script_body'
        elif mode == 'script_body':
            if s.startswith('_Script'):
                cur_script_idx = s
                move_scripts[cur_lbl]['scripts'][cur_script_idx] = []
            elif s.startswith('.char '):
                vals = [int(x.strip()) for x in s[6:].split(',')]
                move_scripts[cur_lbl]['scripts'][cur_script_idx].extend(vals)
    return actions, move_lists, move_scripts


def load_battle_data(sym):
    """Parse data.asm and rounds.asm tables needed for preview."""
    d_txt = open(DATA_ASM, encoding='utf-8').read()
    r_txt = open(ROUNDS_ASM, encoding='utf-8').read()

    def sec(txt, start_lbl, end_lbl):
        i = txt.index(start_lbl)
        j = txt.index(end_lbl, i)
        return txt[i:j]

    barehanded = set(_parse_words(sec(d_txt, 'aBattleSceneBarehandedClasses ;', '.endsection Data998F02Section'))) - {0xFFFF}

    # aItemAnimationCategories: 1 byte per item+1 (starts at NoItem $FF -> index 0)
    item_cats = []
    for line in sec(d_txt, 'aItemAnimationCategories ;', 'aClassDefaultGenders ;').splitlines():
        s = _strip_comment(line)
        if s.startswith('.byte'):
            expr = s[5:].strip()
            if expr == '$FF':
                item_cats.append(0xFF)
            else:
                m = re.match(r'\((\w+)\s*<<\s*4\)\s*\|\s*(\w+)', expr)
                item_cats.append((sym[m.group(1)] << 4) | sym[m.group(2)])

    body_map = {}
    for line in sec(d_txt, 'aBattleAnimationBodyRecords ;', 'aBattleSceneCombatantBodyRecords ;').splitlines():
        s = _strip_comment(line)
        if s.startswith('.byte'):
            vals = [_int(x) for x in s[5:].split(',')]
            if len(vals) == 3:
                body_map[(vals[0], vals[1])] = vals[2]

    body_records = []
    for line in sec(d_txt, 'aBattleSceneCombatantBodyRecords ;', 'aBattleSceneClassWeights ;').splitlines():
        s = _strip_comment(line)
        if s.startswith('.byte'):
            body_records.append([_int(x) for x in s[5:].split(',')])

    attack_actions = _parse_bytes(sec(d_txt, 'aBattleSceneAttackActions ;', '.endsection Data95AC3BSection'))
    crit_actions = _parse_bytes(sec(d_txt, 'aBattleSceneCriticalActions ;', '.endsection Data95ACA8Section'))
    scrit_actions = _parse_bytes(sec(d_txt, 'aBattleSceneSpecialCriticalActions ;', '.endsection Data95ACF0Section'))
    dodge_actions = _parse_bytes(sec(r_txt, 'aBattleSceneDodgeActions ;', 'rlBattleSceneQueueVariant1Action ;'))

    return {
        'barehanded': barehanded,
        'item_cats': item_cats,
        'body_map': body_map,
        'body_records': body_records,
        'attack_actions': attack_actions,
        'crit_actions': crit_actions,
        'scrit_actions': scrit_actions,
        'dodge_actions': dodge_actions,
    }


# --- Reachable Asset Inventory & Slice Computation ---------------------------

def comp_path(label):
    found = glob.glob(os.path.join(ROOT, 'gfx', 'build', '*', label + '.4bpp.comp'))
    if len(found) != 1:
        sys.exit(f'{label}: expected one .4bpp.comp in gfx/build/*/, found {len(found)}')
    return found[0]


def src_path(kind, label):
    prefix = PREFIXES[kind]
    assert label.startswith(prefix), label
    return os.path.join(GFX_DIR, kind, label[len(prefix):] + '.png')


def decompress_file(path):
    orig = open(path, 'rb').read()
    buf = bytearray(0x400000)
    buf[:len(orig)] = orig
    return decompress(bytes(buf), 0xC00000)[0]


def collect_assets(tables=None, ftables=None, frames_by_key=None):
    """Return {kind: {label: metadata}} for all 231 reachable battle animation streams."""
    if tables is None:
        _, _, _, sym = load_constants()
        tables = load_animations_tables(sym)
    if ftables is None or frames_by_key is None:
        ftables, _, frames_by_key, _, _ = load_frames_data()

    # Every (f_id, s_id, e_id, p_id) reachable from aBattleAnimationLookup + Dance
    tuples = [rec[4:] for rec in tables['lookup']] + [DANCE_IDS]

    sheet_ftabs = collections.defaultdict(set)
    sheet_pal = {}
    extra_pal = {}
    extra_meta = {}
    for f_id, s_id, e_id, p_id in tuples:
        si = tables['sheet_indices'][s_id + 1]
        fi = tables['frame_indices'][f_id + 1]
        ei = tables['extra_indices'][e_id + 1]
        pi = tables['palette_indices'][p_id + 1]
        s_lbl = tables['sheets'][si]
        f_lbl = tables['frame_tables'][fi][1]
        e_off, e_cnt, e_lbl = tables['extras'][ei]
        p_lbl, p_bytes = tables['palettes'][pi]
        sheet_ftabs[s_lbl].add(f_lbl)
        sheet_pal.setdefault(s_lbl, (p_lbl, p_bytes))
        extra_pal.setdefault(e_lbl, (p_lbl, p_bytes))
        extra_meta[e_lbl] = (e_off, e_cnt)

    sheets_info = {}
    for s_lbl, f_lbls in sorted(sheet_ftabs.items()):
        slices = set()
        for f_lbl in f_lbls:
            for fkey in ftables[f_lbl]:
                for row in frames_by_key[fkey]:
                    slices.add(row)
        ordered = sorted(slices)
        # The PNG's layout is these slices in order, so they must tile the
        # sheet from 0 with no gap or overlap (true of all 84 original sheets).
        pos = 0
        for off, sz in ordered:
            problem = None
            if sz <= 0 or sz % TILE:
                problem = f'a slice of {sz:#x} bytes is not a whole number of tiles'
            elif off < pos:
                problem = f'the slice at {off:#x} overlaps the one before it (which ends at {pos:#x})'
            elif off > pos:
                problem = f'bytes {pos:#x}-{off - 1:#x} are in no slice'
            if problem:
                sys.exit(f'tools/battle_animations.py: {s_lbl}: {problem}. Its PNG '
                         f'({os.path.relpath(src_path("sheets", s_lbl), ROOT)}) is laid out from the '
                         f'ANIM_TILE_ROW slices of {", ".join(sorted(f_lbls))} in data/battle_animation/frames_*.asm, '
                         'one group of 16-tile rows per slice, so those slices must cover the sheet from 0 '
                         'exactly once. After changing them, rearrange the PNG to match.')
            pos += sz
        sheets_info[s_lbl] = {
            'slices': ordered,
            'size': pos,
            'palette': sheet_pal[s_lbl],
        }

    extras_info = {}
    for e_lbl, (e_off, e_cnt) in sorted(extra_meta.items()):
        extras_info[e_lbl] = {
            'vram_tile': e_off,
            'tile_count': e_cnt,
            'size': e_cnt * TILE,
            'palette': extra_pal[e_lbl],
        }

    # Weapons: every entry in aBattleWeaponGraphicsIndices (except $FF)
    weapons_info = {}
    for g_idx, p_idx in tables['weapon_indices']:
        if g_idx == 0xFF:
            continue
        w_lbl = tables['weapons'][g_idx]
        weapons_info.setdefault(w_lbl, {'pal_idx': p_idx, 'size': 0x400})

    # Character pieces: every entry in aBattleCharacterPieceLookup
    pieces_info = {}
    for entries in tables['cp_lookup'].values():
        if not entries:
            continue
        for _, pc_idx, p_idx in entries:
            pc_lbl = tables['char_pieces'][pc_idx]
            pieces_info.setdefault(pc_lbl, {'pal_idx': p_idx, 'size': 0x400, 'active': 0x300})

    return {
        'sheets': sheets_info,
        'extras': extras_info,
        'weapons': weapons_info,
        'pieces': pieces_info,
    }


def all_reachable_labels():
    """Fast map {label: (kind, rel_png_path)} for gfx_inventory.py."""
    assets = collect_assets()
    out = {}
    for kind, items in assets.items():
        for lbl in items:
            out[lbl] = (kind, os.path.relpath(src_path(kind, lbl), ROOT).replace(os.sep, '/'))
    return out


# --- Image <-> 4bpp Packing --------------------------------------------------

def _put_tile(px, raw, ox, oy):
    for y, row in enumerate(ms.decode_tile(raw)):
        for x, v in enumerate(row):
            px[ox + x, oy + y] = v


def _make_palette(colours15):
    pal = [(0, 0, 0)] + list(colours15) + [(40, 40, 40)] * 16
    flat = [v for c in pal[:16] for v in c]
    return flat + [0] * (768 - len(flat))


def sheet_to_image(raw, slices, colours15, where=''):
    total = sum(sz for _, sz in slices)
    if len(raw) != total:
        raise ValueError(f'{where}: {len(raw):#x} bytes, expected {total:#x}')
    total_rows = sum(((sz // TILE) + 15) // 16 for _, sz in slices)
    img = Image.new('P', (128, total_rows * 8), 0)
    img.putpalette(_make_palette(colours15))
    px = img.load()
    row_y = 0
    for off, sz in slices:
        ntiles = sz // TILE
        for t in range(ntiles):
            _put_tile(px, raw[off + t * TILE:off + (t + 1) * TILE], (t % 16) * 8, (row_y + t // 16) * 8)
        row_y += (ntiles + 15) // 16
    return img


def sheet_from_image(path, slices):
    img = Image.open(path)
    if img.mode != 'P':
        raise ValueError(f'{path}: not an indexed PNG (mode {img.mode})')
    total_rows = sum(((sz // TILE) + 15) // 16 for _, sz in slices)
    exp_size = (128, total_rows * 8)
    if img.size != exp_size:
        raise ValueError(f'{path}: expected {exp_size[0]}x{exp_size[1]}, got {img.size[0]}x{img.size[1]} '
                         '(the size comes from the ANIM_TILE_ROW slices in data/battle_animation/frames_*.asm: '
                         'one group of 16-tile rows per slice)')
    px = img.load()
    out = bytearray()
    row_y = 0
    for off, sz in slices:
        ntiles = sz // TILE
        nrows = (ntiles + 15) // 16
        for t in range(ntiles):
            out.extend(ms.encode_tile(px, (t % 16) * 8, (row_y + t // 16) * 8, path))
        for t in range(ntiles, nrows * 16):
            tx, ty = (t % 16) * 8, (row_y + t // 16) * 8
            for yy in range(8):
                for xx in range(8):
                    if px[tx + xx, ty + yy]:
                        raise ValueError(f'{path}: pixel ({tx + xx}, {ty + yy}) in slice padding must be colour 0')
        row_y += nrows
    if len(out) > MAX_SHEET_BYTES:
        raise ValueError(f'{path}: {len(out):#x} bytes exceeds ${MAX_SHEET_BYTES:X} buffer limit')
    return bytes(out)


def grid_to_image(raw, colours15, exp_size, where=''):
    if len(raw) != exp_size:
        raise ValueError(f'{where}: {len(raw):#x} bytes, expected {exp_size:#x}')
    nrows = exp_size // (16 * TILE)
    img = Image.new('P', (128, nrows * 8), 0)
    img.putpalette(_make_palette(colours15))
    px = img.load()
    for t in range(exp_size // TILE):
        _put_tile(px, raw[t * TILE:(t + 1) * TILE], (t % 16) * 8, (t // 16) * 8)
    return img


def grid_from_image(path, exp_size, active_bytes=None):
    img = Image.open(path)
    if img.mode != 'P':
        raise ValueError(f'{path}: not an indexed PNG (mode {img.mode})')
    nrows = exp_size // (16 * TILE)
    exp_dims = (128, nrows * 8)
    if img.size != exp_dims:
        raise ValueError(f'{path}: expected {exp_dims[0]}x{exp_dims[1]}, got {img.size[0]}x{img.size[1]}')
    px = img.load()
    if active_bytes is not None and active_bytes < exp_size:
        for t in range(active_bytes // TILE, exp_size // TILE):
            tx, ty = (t % 16) * 8, (t // 16) * 8
            for yy in range(8):
                for xx in range(8):
                    if px[tx + xx, ty + yy]:
                        raise ValueError(f'{path}: pixel ({tx + xx}, {ty + yy}) past active ${active_bytes:X} bytes must be colour 0')
    out = bytearray()
    for t in range(exp_size // TILE):
        out.extend(ms.encode_tile(px, (t % 16) * 8, (t // 16) * 8, path))
    return bytes(out)


# --- CLI: unpack / build / clean / list / validate ---------------------------

def unpack(force=False):
    pal_db = load_palettes()
    assets = collect_assets()
    total = 0
    for kind, items in assets.items():
        os.makedirs(os.path.join(GFX_DIR, kind), exist_ok=True)
        for lbl, info in items.items():
            out = src_path(kind, lbl)
            if os.path.exists(out) and not force:
                sys.exit(f'{out} exists; use --force to overwrite')
            raw = decompress_file(comp_path(lbl))
            if kind == 'sheets':
                cols = get_combatant_palette(pal_db, info['palette'][0], info['palette'][1])[:15]
                img = sheet_to_image(raw, info['slices'], cols, lbl)
            elif kind == 'extras':
                cols = get_combatant_palette(pal_db, info['palette'][0], info['palette'][1])[:15]
                img = grid_to_image(raw, cols, info['size'], lbl)
            elif kind == 'weapons':
                cols = get_weapon_palette(pal_db, info['pal_idx'])
                img = grid_to_image(raw, cols, info['size'], lbl)
            else:
                cols = get_piece_palette(pal_db, info['pal_idx'])
                img = grid_to_image(raw, cols, info['size'], lbl)
            img.save(out)
            total += 1
    print(f'wrote {total} battle animation PNGs to {os.path.relpath(GFX_DIR, ROOT)}/')


def _check_frame_budgets(tables, ftables, seq_blocks, frames_by_key, recs_by_key, seqs_by_key):
    """Check upload queue, VBlank DMA, OAM sprite count, and index bounds across all frame tables."""
    errors, warnings = [], []
    for k, (s_lbl, f_lbl) in enumerate(tables['frame_tables'][1:], 1):
        blk = seq_blocks[s_lbl]
        for fkey in ftables[f_lbl]:
            rows = frames_by_key[fkey]
            e, w = check_frame_rows(fkey, rows)
            errors += e
            warnings += w
        for rkey in blk['recs']:
            fnum, sprites = recs_by_key[rkey]
            if len(sprites) > MAX_OAM_SPRITES:
                errors.append(f'{rkey}: {len(sprites)} sprites > {MAX_OAM_SPRITES}')
            if fnum is not None and fnum >= len(ftables[f_lbl]):
                errors.append(f'{rkey}: frame {fnum} >= {len(ftables[f_lbl])}')
        for skey in blk['seqs']:
            for step in seqs_by_key[skey]:
                if step[0] == 'STEP' and step[1] >= len(blk['recs']) and skey not in KNOWN_BAD_SEQUENCES:
                    errors.append(f'{skey}: record {step[1]} >= {len(blk["recs"])}')
    return errors, warnings


def build():
    tables = load_animations_tables(load_constants()[3])
    ftables, seq_blocks, frames_by_key, recs_by_key, seqs_by_key = load_frames_data()
    assets = collect_assets(tables, ftables, frames_by_key)
    missing = [src_path(k, l) for k, items in assets.items() for l in items if not os.path.exists(src_path(k, l))]
    if missing:
        sys.exit('tools/battle_animations.py: missing ' + ', '.join(os.path.relpath(m, ROOT) for m in missing[:10]))
    errors, warnings = _check_frame_budgets(tables, ftables, seq_blocks, frames_by_key, recs_by_key, seqs_by_key)
    for w in warnings[:20]:
        print('warning:', w, file=sys.stderr)
    if errors:
        for e in errors[:20]:
            print('ERROR:', e, file=sys.stderr)
        sys.exit(f'{len(errors)} validation errors')
    anim_mtime = os.path.getmtime(ANIM_ASM)
    sheets_meta_mtime = max([anim_mtime] + [os.path.getmtime(p) for p in glob.glob(FRAMES_GLOB)])
    for kind, items in assets.items():
        meta_mtime = sheets_meta_mtime if kind == 'sheets' else anim_mtime
        for lbl, info in items.items():
            src = src_path(kind, lbl)
            out = comp_path(lbl)[:-len('.comp')]
            dep_mtime = max(os.path.getmtime(src), meta_mtime)
            if not os.path.exists(out) or dep_mtime > os.path.getmtime(out):
                try:
                    if kind == 'sheets':
                        data = sheet_from_image(src, info['slices'])
                    elif kind == 'pieces':
                        data = grid_from_image(src, info['size'], info['active'])
                    else:
                        data = grid_from_image(src, info['size'])
                except ValueError as e:
                    sys.exit(str(e))
                with open(out, 'wb') as f:
                    f.write(data)


def clean():
    assets = collect_assets()
    for kind, items in assets.items():
        for lbl in items:
            p = comp_path(lbl)[:-len('.comp')]
            if os.path.exists(p):
                os.remove(p)


def list_records():
    classes, chars, _, _ = load_constants()
    tables = load_animations_tables(load_constants()[3])
    for i, rec in enumerate(tables['lookup']):
        cls_id, cat_id, ch_id, gen_id, f_id, s_id, e_id, p_id = rec
        cls_n = classes[cls_id] if cls_id < len(classes) else str(cls_id)
        cat_n = CAT_NAMES.get(cat_id, str(cat_id))
        ch_n = '*' if ch_id == 0 else (chars[ch_id - 1] if ch_id - 1 < len(chars) else str(ch_id))
        gen_n = 'M' if gen_id == 0 else ('F' if gen_id == 1 else str(gen_id))
        s_lbl = tables['sheets'][tables['sheet_indices'][s_id + 1]][len('g4bppcBattleAnimationSheet'):]
        e_lbl = tables['extras'][tables['extra_indices'][e_id + 1]][2][len('g4bppcBattleAnimationExtra'):]
        f_lbl = tables['frame_tables'][tables['frame_indices'][f_id + 1]][1][len('aBattleAnimationFrames'):]
        p_lbl = tables['palettes'][tables['palette_indices'][p_id + 1]][0][len('aBattleAnimationPalette'):]
        print(f'{i:3d}: {cls_n:18s} {cat_n:11s} {ch_n:10s} {gen_n}  '
              f'sheet={s_lbl:16s} extra={e_lbl:16s} frames={f_lbl:20s} pal={p_lbl}')
    print('dance: Dancer (--dance)  sheet=61               extra=44               frames=DancerDance          pal=Dancer')


def check_frame_rows(fkey, rows):
    """(errors, warnings) for one frame's tile rows against the upload limits."""
    errors, warnings = [], []
    dma_bytes = sum(sz for _, sz in rows)
    if len(rows) > UPLOAD_QUEUE:
        errors.append(f'{fkey}: {len(rows)} tile rows; the upload queue holds {UPLOAD_QUEUE} '
                      'and drops the rest')
    elif len(rows) > UPLOAD_QUEUE // 2:
        warnings.append(f'{fkey}: {len(rows)} tile rows; with the other combatant changing frame '
                        f'in the same VBlank, rows past {UPLOAD_QUEUE} are dropped')
    if dma_bytes > FRAME_DMA_BUDGET:
        warnings.append(f'{fkey}: {dma_bytes:#x} bytes of tiles, over the ${FRAME_DMA_BUDGET:X} a VBlank '
                        'sends; the rest goes a VBlank late')
    return errors, warnings


def validate():
    tables = load_animations_tables(load_constants()[3])
    ftables, seq_blocks, frames_by_key, recs_by_key, seqs_by_key = load_frames_data()
    actions, move_lists, move_scripts = load_moves_data()
    assets = collect_assets(tables, ftables, frames_by_key)

    errors, warnings = [], []
    for kind, items in assets.items():
        for lbl, info in items.items():
            src = src_path(kind, lbl)
            if not os.path.exists(src):
                errors.append(f'missing PNG: {src}')
                continue
            try:
                if kind == 'sheets':
                    sheet_from_image(src, info['slices'])
                elif kind == 'pieces':
                    grid_from_image(src, info['size'], info['active'])
                else:
                    grid_from_image(src, info['size'])
            except ValueError as e:
                errors.append(str(e))

    # Budget checks across all 46 frame tables and sequence blocks
    b_errors, b_warnings = _check_frame_budgets(tables, ftables, seq_blocks, frames_by_key, recs_by_key, seqs_by_key)
    errors += b_errors
    warnings += b_warnings

    for w in warnings[:20]:
        print('warning:', w, file=sys.stderr)
    if errors:
        for e in errors[:20]:
            print('ERROR:', e, file=sys.stderr)
        sys.exit(f'{len(errors)} validation errors')
    print(f'validated {sum(len(v) for v in assets.values())} PNGs, '
          f'{len(tables["frame_tables"]) - 1} frame/sequence entries, '
          f'{len(tables["programs"]) - 1} move programs')


# --- Preview & Timeline Renderer ---------------------------------------------

def _decode_vram_tile(raw32):
    return [[sum((raw32[2 * y + (q & 1) + 16 * (q >> 1)] >> (7 - x) & 1) << q for q in range(4))
             for x in range(8)] for y in range(8)]


def _build_vram_for_frame(fnum, prev_vram, sheet_bytes, ftable_rows, weapon_bytes, piece_bytes, extra_bytes, extra_tile):
    vram = bytearray(prev_vram)
    if fnum is not None:
        vram[:64 * TILE] = b'\0' * (64 * TILE)
        for p, (off, sz) in enumerate(ftable_rows[fnum]):
            dst = p * 16 * TILE
            vram[dst:dst + sz] = sheet_bytes[off:off + sz]
    vram[0x40 * TILE:0x60 * TILE] = weapon_bytes.ljust(0x20 * TILE, b'\0')[:0x20 * TILE]
    vram[0x60 * TILE:0x78 * TILE] = piece_bytes.ljust(0x18 * TILE, b'\0')[:0x18 * TILE]
    eb = extra_tile * TILE
    vram[eb:eb + len(extra_bytes)] = extra_bytes
    return vram


def _render_record_rgba(sprites, vram, full_pal, facing='left', ox=80, oy=100, size=(160, 128)):
    """Render a sprite array (earlier entries in front; mirrored if facing == 'right')."""
    img = Image.new('RGBA', size, (0, 0, 0, 0))
    px = img.load()
    W, H = size
    mirror = (facing == 'right')
    for x, y, sz, tile, pal, hflip, vflip in reversed(sprites):
        sx_base = -x - sz if mirror else x
        hf = (not hflip) if mirror else hflip
        n = sz // 8
        for ty in range(n):
            for tx in range(n):
                ti = tile + ty * 16 + tx
                tt = _decode_vram_tile(vram[ti * TILE:(ti + 1) * TILE])
                dx = (n - 1 - tx) if hf else tx
                dy = (n - 1 - ty) if vflip else ty
                for yy in range(8):
                    for xx in range(8):
                        c = tt[yy][xx]
                        if not c:
                            continue
                        sxx = 7 - xx if hf else xx
                        syy = 7 - yy if vflip else yy
                        X, Y = ox + sx_base + dx * 8 + sxx, oy + y + dy * 8 + syy
                        if 0 <= X < W and 0 <= Y < H:
                            r, g, b = full_pal[16 * (pal & 3) + c]
                            px[X, Y] = (r, g, b, 255)
    return img


def _step_sequence(seq_steps, max_steps=160):
    """Expand sequence commands into [(rec_idx, dur, markers)] frames."""
    frames = []
    ip = 0
    markers = set()
    f4_seen = {}
    steps_taken = 0
    while 0 <= ip < len(seq_steps) and steps_taken < max_steps:
        steps_taken += 1
        st = seq_steps[ip]
        op = st[0]
        if op == 'STEP':
            frames.append((st[1], max(st[2], 1), sorted(markers)))
            markers.clear()
            ip += 1
        elif op in ('ANIM_END', 'ANIM_HOLD'):
            break
        elif op == 'ANIM_RESTART':
            break
        elif op == 'ANIM_BACK':
            ip = max(0, ip - max(st[1], 1))
        elif op == 'ANIM_WAIT':
            if frames:
                r, d, m = frames[-1]
                frames.append((r, max(st[1], 1), m))
            ip += 1
        elif op == 'ANIM_CMD_F4':
            # Allow one loop cycle in preview, then exit
            cnt = f4_seen.get(ip, 0) + 1
            f4_seen[ip] = cnt
            if cnt >= 2:
                ip += 1
            else:
                ip = max(0, ip - max(st[1], 1))
        elif op in ('ANIM_CMD_F1', 'ANIM_CMD_F0', 'ANIM_CMD_EF'):
            markers.add(op)
            ip += 1
        else:
            ip += 1
    return frames


def _save_gif_and_strip(rendered_frames, out_stem, scale=2, bg=(40, 40, 60)):
    """Save animated GIF and frame strip with duration/strike bars."""
    if not rendered_frames:
        return
    W, H = rendered_frames[0][0].size
    gif_frames = []
    durs = []
    for rgba, dur, _ in rendered_frames:
        im = Image.new('RGB', (W, H), bg)
        im.paste(rgba, (0, 0), rgba)
        if scale > 1:
            im = im.resize((W * scale, H * scale), Image.NEAREST)
        gif_frames.append(im)
        durs.append(max(20, round(dur * 1000 / 60)))
    gif_frames[0].save(
        out_stem + '.gif', save_all=True, append_images=gif_frames[1:],
        duration=durs, loop=0, disposal=2,
    )
    strip = Image.new('RGB', (W * len(rendered_frames), H + 8), bg)
    for i, (rgba, dur, markers) in enumerate(rendered_frames):
        im = Image.new('RGB', (W, H), bg)
        im.paste(rgba, (0, 0), rgba)
        strip.paste(im, (i * W, 0))
        is_hit = any(m in markers for m in ('ANIM_CMD_F1', 'ANIM_CMD_F0', 'ANIM_CMD_EF'))
        bar_col = (255, 60, 60) if is_hit else (200, 200, 200)
        for x in range(min(dur, W - 2)):
            strip.putpixel((i * W + 1 + x, H + 3), bar_col)
    if scale > 1:
        strip = strip.resize((strip.width * scale, strip.height * scale), Image.NEAREST)
    strip.save(out_stem + '.png')


def preview(out_dir, cls_name=None, record=None, dance=False, category=None, item='IronSword',
            character=None, gender=None, enemy=False, facing='left', action=None,
            sequence=None, frames_only=False, scale=2, ids_override=None, entry=None, sheet=None):
    classes, chars, items, sym = load_constants()
    tables = load_animations_tables(sym)
    pal_db = load_palettes()
    ftables, seq_blocks, frames_by_key, recs_by_key, seqs_by_key = load_frames_data()
    actions_db, move_lists, move_scripts = load_moves_data()
    bdata = load_battle_data(sym)

    # Resolve item
    item_id = items.index(item) if item in items else int(item, 0)
    anim_style = bdata['item_cats'][item_id + 1] if item_id + 1 < len(bdata['item_cats']) else 0x90
    if anim_style == 0xFF:
        anim_style = 0x90
    item_cat = anim_style >> 4
    atk_style = anim_style & 0x0F

    # Pick lookup record
    if dance:
        cls_id = classes.index('Dancer') if 'Dancer' in classes else 0
        cat_id = 0
        ch_id = sym[character] if character and character in sym else 0
        gen_id = 1
        ids = DANCE_IDS
        tag = 'DancerDance'
    elif record is not None:
        rec = tables['lookup'][record]
        cls_id, cat_id, ch_id, gen_id = rec[:4]
        ids = rec[4:]
        tag = f'rec{record}_{classes[cls_id]}'
    else:
        want_cls = sym[cls_name] if cls_name else 0
        want_cat = SHORT_CAT[category.lower()] if category else None
        want_gen = 0 if gender is None else (0 if gender.lower().startswith('m') else 1)
        want_ch = sym[character] if character and character in sym else 0
        matches = [r for r in tables['lookup'] if r[0] == want_cls]
        if not matches:
            matches = [tables['lookup'][0]]
        picked = None
        for r in matches:
            if gender is not None and r[3] != want_gen:
                continue
            if r[2] != 0 and r[2] != want_ch:
                continue
            if want_cat is not None and r[1] != want_cat:
                continue
            picked = r
            break
        if picked is None:
            picked = matches[0]
        cls_id, cat_id, ch_id, gen_id = picked[:4]
        ids = picked[4:]
        if character and character in sym:
            ch_id = sym[character]
        tag = f'{classes[cls_id]}_{CAT_NAMES.get(cat_id, cat_id)}'

    if ids_override is not None:
        ids = ids_override
        tag += '_ids' + ''.join(f'{i:02X}' for i in ids)
    f_id, s_id, e_id, p_id = ids
    f_entry = tables['frame_indices'][f_id + 1] if entry is None else entry
    if entry is not None:
        tag += f'_entry{entry}'
    s_lbl, f_lbl = tables['frame_tables'][f_entry]
    sheet_lbl = tables['sheets'][tables['sheet_indices'][s_id + 1]] if sheet is None else sheet
    extra_tile, _, extra_lbl = tables['extras'][tables['extra_indices'][e_id + 1]]
    p_entry = tables['palette_indices'][p_id + 1]
    if ch_id:
        for ov_ch, ov_cls, ov_p in tables['palette_overrides']:
            if ov_ch == ch_id and ov_cls == cls_id:
                p_entry = ov_p
                enemy = False
                break
    pal_lbl, pal_bytes = tables['palettes'][p_entry]

    # Load live PNGs
    assets = collect_assets(tables, ftables, frames_by_key)
    if sheet_lbl in assets['sheets']:
        sheet_bytes = sheet_from_image(src_path('sheets', sheet_lbl), assets['sheets'][sheet_lbl]['slices'])
    else:
        # A sheet no record reaches has no PNG: read its committed stream.
        sheet_bytes = decompress_file(comp_path(sheet_lbl))
        tag += '_' + sheet_lbl[len(PREFIXES['sheets']):]
    extra_bytes = grid_from_image(src_path('extras', extra_lbl), assets['extras'][extra_lbl]['size'])

    # Weapon tiles & palette (magic/any/barehanded staff get blank)
    bare = (item_cat in (7, 9)) or (item_cat == 8 and cls_id in bdata['barehanded'])
    w_gfx_idx, w_pal_idx = tables['weapon_indices'][item_id]
    if bare or w_gfx_idx == 0xFF:
        weapon_bytes = b'\0' * 0x400
        weapon_pal = [(255, 0, 255)] * 15
    else:
        w_lbl = tables['weapons'][w_gfx_idx]
        weapon_bytes = grid_from_image(src_path('weapons', w_lbl), 0x400)
        weapon_pal = get_weapon_palette(pal_db, w_pal_idx)

    # Character piece tiles & palette (Bow gets blank)
    piece_bytes = b'\0' * 0x300
    piece_pal = [(255, 0, 255)] * 9
    cp_entries = tables['cp_lookup'].get(cls_id)
    if cp_entries and item_cat != 3:
        picked_cp = next(((pc, pl) for c, pc, pl in cp_entries if c == ch_id), None)
        if picked_cp is None:
            picked_cp = next(((pc, pl) for c, pc, pl in cp_entries if c is None), None)
        if picked_cp is not None:
            pc_idx, pc_pal_idx = picked_cp
            pc_lbl = tables['char_pieces'][pc_idx]
            piece_bytes = grid_from_image(src_path('pieces', pc_lbl), 0x400, 0x300)[:0x300]
            piece_pal = get_piece_palette(pal_db, pc_pal_idx)

    # Build 4 OAM palettes (64 RGB entries)
    body_cols = get_combatant_palette(pal_db, pal_lbl, pal_bytes, enemy=enemy)
    if ch_id and ch_id in pal_db['char_color_idx']:
        ci = pal_db['char_color_idx'][ch_id]
        c3 = [_bgr555_to_rgb(w) for w in pal_db['char_colors'][ci * 3:ci * 3 + 3]]
        body_cols[11:14] = c3  # colours 12-14 of OAM palette 0 (1-based in buffer)
    full_pal = ([(0, 0, 0)] + body_cols + [(255, 0, 255)] * 31)[:32]
    full_pal += ([(0, 0, 0)] + weapon_pal + [(255, 0, 255)] * 15)[:16]
    # OAM palette 3: colours 1-9 character piece, colour 15 ground shadow (black)
    pal3 = [(0, 0, 0)] + piece_pal + [(255, 0, 255)] * 5 + [(0, 0, 0)]
    full_pal += pal3[:16]

    ftable_rows = [frames_by_key[fk] for fk in ftables[f_lbl]]
    blk = seq_blocks[s_lbl]
    os.makedirs(out_dir, exist_ok=True)
    written = 0

    if frames_only:
        pics = []
        vram = bytearray(0x8000)
        for rkey in blk['recs']:
            fnum, sprites = recs_by_key[rkey]
            vram = _build_vram_for_frame(fnum, vram, sheet_bytes, ftable_rows, weapon_bytes, piece_bytes, extra_bytes, extra_tile)
            pics.append(_render_record_rgba(sprites, vram, full_pal, facing=facing))
        cols_n = 4
        sheet_img = Image.new('RGB', (160 * cols_n, 128 * ((len(pics) + cols_n - 1) // cols_n)), (40, 40, 60))
        for i, rgba in enumerate(pics):
            sheet_img.paste(rgba, (i % cols_n * 160, i // cols_n * 128), rgba)
        if scale > 1:
            sheet_img = sheet_img.resize((sheet_img.width * scale, sheet_img.height * scale), Image.NEAREST)
        out_p = os.path.join(out_dir, f'{tag}_frames.png')
        sheet_img.save(out_p)
        print(f'wrote {len(pics)} frame records to {out_p}')
        return 1

    prog_idx = tables['program_indices'][f_id + 1]
    lists_lbl, acts_lbl, scripts_lbl = tables['programs'][prog_idx]
    act_entries = actions_db[acts_lbl]

    def render_seq_list(seq_runs, stem):
        vram = bytearray(0x8000)
        rendered = []
        cur_x = 0
        for seq_idx, dx_fn, jump_arg in seq_runs:
            if seq_idx >= len(blk['seqs']):
                continue
            skey = blk['seqs'][seq_idx]
            steps = _step_sequence(seqs_by_key[skey])
            t = 0
            for step_i, (rec_idx, dur, markers) in enumerate(steps):
                if rec_idx >= len(blk['recs']):
                    continue
                cur_x += dx_fn(step_i)
                dy = 0
                if jump_arg is not None:
                    jf, jh = jump_arg
                    if jf > 0 and 0 <= t <= jf:
                        dy = -round(4 * jh * (t / jf) * (1 - t / jf))
                t += dur
                fnum, sprites = recs_by_key[blk['recs'][rec_idx]]
                vram = _build_vram_for_frame(fnum, vram, sheet_bytes, ftable_rows, weapon_bytes, piece_bytes, extra_bytes, extra_tile)
                ox = 80 + (-cur_x if facing == 'right' else cur_x)
                rgba = _render_record_rgba(sprites, vram, full_pal, facing=facing, ox=ox, oy=100 + dy)
                rendered.append((rgba, dur, markers))
        if rendered:
            _save_gif_and_strip(rendered, stem, scale=scale)
            return 1
        return 0

    if sequence is not None:
        written += render_seq_list([(sequence, lambda _: 0, None)], os.path.join(out_dir, f'{tag}_seq{sequence:02d}'))
        print(f'wrote {written} sequence preview(s) to {out_dir}')
        return written

    # Resolve action presets
    presets = {
        'idle': 0,
        'dodge': bdata['dodge_actions'][atk_style] if atk_style < len(bdata['dodge_actions']) else 1,
        'attack': bdata['attack_actions'][atk_style] if atk_style < len(bdata['attack_actions']) else 0,
        'critical': bdata['crit_actions'][atk_style] if atk_style < len(bdata['crit_actions']) else 0,
        'special': bdata['scrit_actions'][atk_style] if atk_style < len(bdata['scrit_actions']) else 0,
        'staff': 5,
        'dance': 1,
    }
    if action is None:
        todo = [('idle', presets['idle']), ('dodge', presets['dodge']), ('attack', presets['attack']), ('critical', presets['critical'])]
    elif action.lower() in presets:
        todo = [(action.lower(), presets[action.lower()])]
    else:
        ai = int(action, 0)
        todo = [(f'act{ai:02d}', ai)]

    for aname, aidx in todo:
        if aidx >= len(act_entries):
            continue
        kind_a, val = act_entries[aidx]
        if kind_a == 'SEQ':
            written += render_seq_list([(val, lambda _: 0, None)], os.path.join(out_dir, f'{tag}_{aname}'))
        else:
            ml_data = move_lists.get(lists_lbl)
            ms_data = move_scripts.get(scripts_lbl)
            if not ml_data or val >= len(ml_data['order']):
                continue
            l_name = ml_data['order'][val]
            steps = ml_data['lists'][l_name]
            seq_runs = []
            for mkind, mseq, mval, marg in steps:
                if mkind == 'script' and ms_data and mval < len(ms_data['order']):
                    scr_vals = ms_data['scripts'][ms_data['order'][mval]]
                    seq_runs.append((mseq, lambda i, sv=scr_vals: (sv[i] if i < len(sv) else 0), None))
                elif mkind == 'jump':
                    seq_runs.append((mseq, lambda _: 0, marg))
                else:
                    seq_runs.append((mseq, lambda _: 0, None))
            written += render_seq_list(seq_runs, os.path.join(out_dir, f'{tag}_{aname}'))
    print(f'wrote {written} preview(s) of {tag} to {out_dir}')
    return written


# --- Self-Test ---------------------------------------------------------------

def self_test():
    classes, chars, items, sym = load_constants()
    tables = load_animations_tables(sym)
    pal_db = load_palettes()
    ftables, seq_blocks, frames_by_key, recs_by_key, seqs_by_key = load_frames_data()
    assets = collect_assets(tables, ftables, frames_by_key)

    counts = {k: len(v) for k, v in assets.items()}
    assert counts == {'sheets': 84, 'extras': 65, 'weapons': 64, 'pieces': 18}, counts

    # 1. Verify all 231 streams unpack & pack byte-identical, and committed PNGs match
    with tempfile.TemporaryDirectory() as tmp:
        for kind, items_d in assets.items():
            for lbl, info in items_d.items():
                raw = decompress_file(comp_path(lbl))
                p = os.path.join(tmp, 'x.png')
                if kind == 'sheets':
                    cols = get_combatant_palette(pal_db, info['palette'][0], info['palette'][1])[:15]
                    sheet_to_image(raw, info['slices'], cols, lbl).save(p)
                    assert sheet_from_image(p, info['slices']) == raw, f'{lbl}: unpack/pack differs'
                    assert sheet_from_image(src_path(kind, lbl), info['slices']) == raw, f'{lbl}: committed PNG differs'
                elif kind == 'extras':
                    cols = get_combatant_palette(pal_db, info['palette'][0], info['palette'][1])[:15]
                    grid_to_image(raw, cols, info['size'], lbl).save(p)
                    assert grid_from_image(p, info['size']) == raw, f'{lbl}: unpack/pack differs'
                    assert grid_from_image(src_path(kind, lbl), info['size']) == raw, f'{lbl}: committed PNG differs'
                elif kind == 'weapons':
                    cols = get_weapon_palette(pal_db, info['pal_idx'])
                    grid_to_image(raw, cols, info['size'], lbl).save(p)
                    assert grid_from_image(p, info['size']) == raw, f'{lbl}: unpack/pack differs'
                    assert grid_from_image(src_path(kind, lbl), info['size']) == raw, f'{lbl}: committed PNG differs'
                else:
                    cols = get_piece_palette(pal_db, info['pal_idx'])
                    grid_to_image(raw, cols, info['size'], lbl).save(p)
                    assert grid_from_image(p, info['size'], info['active']) == raw, f'{lbl}: unpack/pack differs'
                    assert grid_from_image(src_path(kind, lbl), info['size'], info['active']) == raw, f'{lbl}: committed PNG differs'

        # 2. Verify palette counts & source-vs-ROM consistency on fe4.sfc
        rom = open(os.path.join(ROOT, 'fe4.sfc'), 'rb').read()
        def r_off(a):
            x = rom_offset(a)
            return rom_offset(a | 0x400000) if x is None else x
        override_pals = {ov_p for _, _, ov_p in tables['palette_overrides']}
        for k, (p_lbl, p_bytes) in enumerate(tables['palettes'][1:], 1):
            # Compare against aBattleAnimationPalettes in fe4.sfc
            ptr_off = r_off(0x978521 + 4 * k)
            addr = int.from_bytes(rom[ptr_off:ptr_off + 3], 'little')
            rom_off = r_off(addr)
            nwords = p_bytes // 2 if (k in override_pals or p_lbl == 'aBattleAnimationPaletteDarkPrince') else p_bytes
            src_words = pal_db['words'][pal_db['label_off'][p_lbl]:pal_db['label_off'][p_lbl] + nwords]
            rom_words = [int.from_bytes(rom[rom_off + 2 * i:rom_off + 2 * i + 2], 'little') for i in range(nwords)]
            assert src_words == rom_words, f'palette {p_lbl} mismatch vs fe4.sfc'

        # 2b. Verify all 46 frame tables, sequence counts, and .structSpriteEntry fields vs fe4.sfc
        import battle_frames as bf
        dec = bf.Decoded(bf.Rom(rom))
        for k, (s_lbl, f_lbl) in enumerate(tables['frame_tables'][1:], 1):
            S, F = dec.entries[k]
            rom_ft = [[(dec.rom.word(fa + 1 + 4 * p), dec.rom.word(fa + 3 + 4 * p))
                       for p in range(dec.rom.byte(fa))] for fa in dec.ftabs[F]]
            src_ft = [frames_by_key[fk] for fk in ftables[f_lbl]]
            assert rom_ft == src_ft, f'frame table {f_lbl} mismatch vs fe4.sfc'
            blk = seq_blocks[s_lbl]
            assert len(blk['seqs']) == len(dec.blocks[S]['seqs']), f'seq count {s_lbl} mismatch'
            for ra, rkey in zip(dec.blocks[S]['recs'], blk['recs']):
                fnum = None if dec.rom.byte(ra) == 0xFF else dec.rom.byte(ra)
                sprites = []
                for s in range(dec.rom.word(ra + 1)):
                    a = ra + 3 + 5 * s
                    xw, yy, attr = dec.rom.word(a), dec.rom.byte(a + 2), dec.rom.word(a + 3)
                    sx = (xw & 0x1FF) - (0x200 if xw & 0x100 else 0)
                    sy = yy - 0x100 if yy & 0x80 else yy
                    sz = 16 if xw & 0x8000 else 8
                    sprites.append((sx, sy, sz, attr & 0x1FF, (attr >> 9) & 7, bool(attr & 0x4000), bool(attr & 0x8000)))
                assert recs_by_key[rkey] == (fnum, sprites), f'record {rkey} mismatch vs fe4.sfc'

        # 3. Run full budget validation
        validate()
        # The row limits: 17 rows is an error, 9 a warning, $C40 bytes a warning;
        # the original data's largest frame (2 rows, $800 bytes) passes clean.
        row = [(0, 0x40)]
        assert check_frame_rows('t', row * 17)[0], '17 rows should be an error'
        assert not check_frame_rows('t', row * 9)[0] and check_frame_rows('t', row * 9)[1], '9 rows: a warning'
        assert check_frame_rows('t', [(0, 0x800), (0x800, 0x440)])[1], '$C40 bytes: a warning'
        assert check_frame_rows('t', [(0, 0x400), (0x400, 0x400)]) == ([], []), '2 rows, $800 bytes: clean'
        # Slices that no longer tile a sheet stop collect_assets with a message.
        _ft, _, _fbk, _, _ = load_frames_data()
        key = ('aBattleAnimationFramesPegasusKnightSword', '_Frame08')
        _fbk[key] = [(0x2E00, 0x540), (0x3360, 0x40)]
        try:
            collect_assets(None, _ft, _fbk)
        except SystemExit as ex:
            assert 'FalconKnight' in str(ex) and 'ANIM_TILE_ROW' in str(ex), ex
        else:
            raise AssertionError('changed slices should stop collect_assets')

        # 4. Pixel edit + LZ round-trip for each of the 4 asset kinds
        edit_cases = [
            ('sheets', 'g4bppcBattleAnimationSheetMyrmidon', (0, 0),
             lambda p: sheet_from_image(p, assets['sheets']['g4bppcBattleAnimationSheetMyrmidon']['slices'])),
            ('extras', 'g4bppcBattleAnimationExtraMyrmidon', (0, 0),
             lambda p: grid_from_image(p, assets['extras']['g4bppcBattleAnimationExtraMyrmidon']['size'])),
            ('weapons', 'g4bppcBattleWeaponIronSword', (0, 0),
             lambda p: grid_from_image(p, 0x400)),
            ('pieces', 'g4bppcBattleCharacterPieceKnightLord', (0, 0),
             lambda p: grid_from_image(p, 0x400, 0x300)),
        ]
        for kind, lbl, (px_x, px_y), packer in edit_cases:
            orig_bytes = packer(src_path(kind, lbl))
            im = Image.open(src_path(kind, lbl)).copy()
            im.putpixel((px_x, px_y), (im.getpixel((px_x, px_y)) + 1) % 16)
            ep = os.path.join(tmp, f'edit_{kind}.png')
            im.save(ep)
            edited = packer(ep)
            changed = {i // TILE for i in range(len(orig_bytes)) if orig_bytes[i] != edited[i]}
            assert changed == {0}, f'{lbl}: expected tile 0 changed, got {changed}'
            lz = gfx.lz(edited, comp_path(lbl))
            buf = bytearray(0x400000)
            buf[:len(lz)] = lz
            assert decompress(bytes(buf), 0xC00000)[0] == edited, f'{lbl}: LZ round-trip failed'

        # 5. Negative validation tests
        ep = os.path.join(tmp, 'bad.png')
        # RGB mode
        Image.new('RGB', (128, 16)).save(ep)
        try:
            grid_from_image(ep, 0x400)
            raise AssertionError('RGB PNG should fail')
        except ValueError:
            pass
        # Wrong dimensions
        Image.new('P', (128, 32)).save(ep)
        try:
            grid_from_image(ep, 0x400)
            raise AssertionError('wrong size PNG should fail')
        except ValueError:
            pass
        # Non-zero in piece unused $300-$3FF
        im = Image.open(src_path('pieces', 'g4bppcBattleCharacterPieceKnightLord')).copy()
        im.putpixel((64, 8), 1)
        im.save(ep)
        try:
            grid_from_image(ep, 0x400, 0x300)
            raise AssertionError('non-zero piece padding should fail')
        except ValueError:
            pass
        # Non-zero in sheet slice-row padding (Myrmidon slice 0 is $100 = 8 tiles -> x=64..127, y=0..7 must be 0)
        im = Image.open(src_path('sheets', 'g4bppcBattleAnimationSheetMyrmidon')).copy()
        im.putpixel((64, 0), 1)
        im.save(ep)
        try:
            sheet_from_image(ep, assets['sheets']['g4bppcBattleAnimationSheetMyrmidon']['slices'])
            raise AssertionError('non-zero sheet slice padding should fail')
        except ValueError:
            pass

        # 6. Preview tests across diverse classes/cases
        assert preview(os.path.join(tmp, 'p1'), cls_name='Myrmidon', action='attack') > 0
        assert preview(os.path.join(tmp, 'p1f'), cls_name='Myrmidon', frames_only=True) > 0
        assert preview(os.path.join(tmp, 'p2'), cls_name='Cavalier', character='Alec', action='attack', enemy=True) > 0
        assert preview(os.path.join(tmp, 'p3'), cls_name='FalconKnight', item='IronLance', frames_only=True) > 0
        assert preview(os.path.join(tmp, 'p3a'), cls_name='FalconKnight', item='IronLance', action='attack') > 0
        assert preview(os.path.join(tmp, 'p4'), cls_name='Ballistician', item='Ballista', frames_only=True) > 0
        assert preview(os.path.join(tmp, 'p4a'), cls_name='Ballistician', item='Ballista', action='attack') > 0
        assert preview(os.path.join(tmp, 'p5'), dance=True, action='dance') > 0

    print('231 of 231 battle animation streams unpack and pack byte-identical (committed PNGs checked); '
          'palettes, budgets, edits, LZ, refusals and previews passed')


def main():
    ap = argparse.ArgumentParser(description=__doc__.split('\n')[0])
    ap.add_argument('--self-test', action='store_true')
    sub = ap.add_subparsers(dest='cmd')
    p = sub.add_parser('unpack')
    p.add_argument('--force', action='store_true')
    sub.add_parser('build')
    sub.add_parser('clean')
    sub.add_parser('list')
    sub.add_parser('validate')
    p = sub.add_parser('preview')
    p.add_argument('out_dir')
    p.add_argument('--class', dest='cls')
    p.add_argument('--record', type=int)
    p.add_argument('--dance', action='store_true')
    p.add_argument('--category')
    p.add_argument('--item', default='IronSword')
    p.add_argument('--character')
    p.add_argument('--gender')
    p.add_argument('--enemy', action='store_true')
    p.add_argument('--facing', default='left', choices=('left', 'right'))
    p.add_argument('--action')
    p.add_argument('--sequence', type=int)
    p.add_argument('--frames', action='store_true')
    p.add_argument('--scale', type=int, default=2)
    p.add_argument('--ids', help='four animation IDs in hex, A,B,C,D (frames, sheet, extras, palette)')
    p.add_argument('--entry', type=int, help='aBattleAnimationFrameTables entry instead of the first ID\'s')
    p.add_argument('--sheet', help='class sheet stream label instead of the second ID\'s (read from its .comp)')
    args = ap.parse_args()
    if args.self_test:
        self_test()
    elif args.cmd == 'unpack':
        unpack(args.force)
    elif args.cmd == 'build':
        build()
    elif args.cmd == 'clean':
        clean()
    elif args.cmd == 'list':
        list_records()
    elif args.cmd == 'validate':
        validate()
    elif args.cmd == 'preview':
        preview(args.out_dir, args.cls, args.record, args.dance, args.category, args.item,
                args.character, args.gender, args.enemy, args.facing, args.action,
                args.sequence, args.frames, args.scale,
                tuple(int(x, 16) for x in args.ids.split(',')) if args.ids else None,
                args.entry, args.sheet)
    else:
        ap.print_help()


if __name__ == '__main__':
    main()
