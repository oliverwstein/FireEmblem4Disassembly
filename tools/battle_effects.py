#!/usr/bin/env python3
"""Battle scene effects and map-battle magic assets: unpack, build, clean, preview.

usage: tools/battle_effects.py unpack [--force]
       tools/battle_effects.py build
       tools/battle_effects.py clean
       tools/battle_effects.py list
       tools/battle_effects.py preview OUT_DIR [--map-magic | --battle-scene | --all]
       tools/battle_effects.py --self-test

Manages all Phase 7 battle_effects assets:

1. Map-battle magic palettes (21 files in gfx/effects/map_magic/palettes/*.asm):
   256-color BGR555 palettes compiled to gfx/build/D50000/acMapBattleMagic*Palette.bin.
2. Map-battle magic backgrounds (23 manifests, 25 layers in gfx/effects/map_magic/):
   Assembled 256x256 PNGs (+ priority masks) packed by tools/scene_pack.py.
3. Map-battle magic / action / cutscene / ripple sprite sheets (24 PNGs in
   gfx/effects/map_magic/sprites/*.4bpp.png): packed to .4bpp in gfx/build/*/.
4. Battle scene effect & window tile sheets (47 PNGs in
   gfx/effects/battle_scene/tiles/*.{4bpp,2bpp}.png): packed to .4bpp or .2bpp in
   gfx/build/E02EBD/.
5. Battle scene effect & window tilemap layouts (61 grid CSV layers in
   gfx/effects/battle_scene/*.scene.json): packed by tools/scene_pack.py.

The asset lists (MAP_MAGIC_*, BATTLE_SCENE_*) are written by hand in this file:
names, labels, layer sizes and sheet bases. The streams themselves are loaded
through aMapBattleMagicBackgrounds, aMapBattleMagicSprites,
aBattleSceneDecompressToVRAMTable and aBattleSceneDecompressTable; --self-test
fails when a label here is missing from those tables or a stream they load is
missing here (unless gfx_inventory.py lists it as unreachable). Adding an
asset therefore means a row here as well as the engine table entry.

palettes rewrites each battle scene manifest's colors from the scripts that
load its layers (tools/battle_scene_palettes.py) and recolors the effect tile
sheet PNGs (their pixels do not change). Layers no script colors keep the
palette written by hand, or grey where that palette read a palette effect
stream as plain colors.
"""
import argparse
import csv
import json
import os
import re
import shutil
import struct
import sys
import tempfile

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from chapter_maps import entry_text
from decompress import decompress
import battle_scene_palettes
import gfx
import scene_pack

try:
    from PIL import Image
except ImportError:
    sys.exit('tools/battle_effects.py needs Pillow: pip3 install pillow')

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
EFFECTS_DIR = os.path.join(ROOT, 'gfx', 'effects')
MAP_MAGIC_DIR = os.path.join(EFFECTS_DIR, 'map_magic')
MAP_MAGIC_PAL_DIR = os.path.join(MAP_MAGIC_DIR, 'palettes')
MAP_MAGIC_SPR_DIR = os.path.join(MAP_MAGIC_DIR, 'sprites')
BATTLE_SCENE_DIR = os.path.join(EFFECTS_DIR, 'battle_scene')
BATTLE_SCENE_TILES_DIR = os.path.join(BATTLE_SCENE_DIR, 'tiles')

BGR555_RE = re.compile(r'bgr555\(\s*(-?\d+)\s*,\s*(-?\d+)\s*,\s*(-?\d+)\s*\)')

# 21 map-battle magic palettes in gfx/build/D50000/
MAP_MAGIC_PALETTES = [
    'Fire', 'Bolganone', 'Valflame', 'Meteor',
    'Thunder', 'Thoron', 'Mjolnir',
    'Wind', 'Forseti', 'Blizzard',
    'Light', 'Nosferatu', 'Aura',
    'Fenrir', 'Hel',
    'Fortify', 'ReturnStaff', 'RestoreStaff',
    'SilenceStaff', 'SleepStaff', 'BerserkStaff',
]

# 23 map-battle magic background manifests (25 tilemaps total)
# (name, sheet_label, pal_name, [(tilemap_label, png_name)], ext_blank_tile)
MAP_MAGIC_SCENES = [
    ('Fire', 'g4bppcMapBattleMagicFire', 'Fire', [('acMapBattleMagicFireTilemap', 'Fire.png')], None),
    ('Bolganone', 'g4bppcMapBattleMagicBolganone', 'Bolganone', [('acMapBattleMagicBolganoneTilemap', 'Bolganone.png')], 0x340),
    ('Valflame', 'g4bppcMapBattleMagicValflame', 'Valflame', [
        ('acMapBattleMagicValflameTilemap', 'Valflame.png'),
        ('acMapBattleMagicValflameTilemap2', 'ValflameRight.png'),
    ], None),
    ('Meteor', 'g4bppcMapBattleMagicMeteor', 'Meteor', [
        ('acMapBattleMagicMeteorTilemap', 'Meteor.png'),
        ('acMapBattleMagicMeteorTilemap2', 'MeteorRight.png'),
    ], None),
    ('Thunder', 'g4bppcMapBattleMagicThunder', 'Thunder', [('acMapBattleMagicThunderTilemap', 'Thunder.png')], 0x340),
    ('Thoron', 'g4bppcMapBattleMagicThoron', 'Thoron', [('acMapBattleMagicThoronTilemap', 'Thoron.png')], 0x340),
    ('Mjolnir', 'g4bppcMapBattleMagicMjolnir', 'Mjolnir', [('acMapBattleMagicMjolnirTilemap', 'Mjolnir.png')], 0x340),
    ('Wind', 'g4bppcMapBattleMagicWind', 'Wind', [('acMapBattleMagicWindTilemap', 'Wind.png')], None),
    ('Forseti', 'g4bppcMapBattleMagicForseti', 'Forseti', [('acMapBattleMagicForsetiTilemap', 'Forseti.png')], 0x37F),
    ('Blizzard', 'g4bppcMapBattleMagicBlizzard', 'Blizzard', [('acMapBattleMagicBlizzardTilemap', 'Blizzard.png')], None),
    ('Light', 'g4bppcMapBattleMagicLight', 'Light', [('acMapBattleMagicLightTilemap', 'Light.png')], 0x340),
    ('Nosferatu', 'g4bppcMapBattleMagicNosferatu', 'Nosferatu', [('acMapBattleMagicNosferatuTilemap', 'Nosferatu.png')], 0x340),
    ('Aura', 'g4bppcMapBattleMagicAura', 'Aura', [('acMapBattleMagicAuraTilemap', 'Aura.png')], None),
    ('Fenrir', 'g4bppcMapBattleMagicFenrir', 'Fenrir', [('acMapBattleMagicFenrirTilemap', 'Fenrir.png')], None),
    ('Hel', 'g4bppcMapBattleMagicHel', 'Hel', [('acMapBattleMagicHelTilemap', 'Hel.png')], None),
    ('MendStaff', 'g4bppcMapBattleMagicMendStaff', 'Wind', [('acMapBattleMagicMendStaffTilemap', 'MendStaff.png')], None),
    ('RecoverStaff', 'g4bppcMapBattleMagicRecoverStaff', 'Wind', [('acMapBattleMagicRecoverStaffTilemap', 'RecoverStaff.png')], None),
    ('Fortify', 'g4bppcMapBattleMagicFortify', 'Fortify', [('acMapBattleMagicFortifyTilemap', 'Fortify.png')], None),
    ('ReturnStaff', 'g4bppcMapBattleMagicReturnStaff', 'ReturnStaff', [('acMapBattleMagicReturnStaffTilemap', 'ReturnStaff.png')], 0x36F),
    ('RestoreStaff', 'g4bppcMapBattleMagicRestoreStaff', 'RestoreStaff', [('acMapBattleMagicRestoreStaffTilemap', 'RestoreStaff.png')], 0x36F),
    ('SilenceStaff', 'g4bppcMapBattleMagicSilenceStaff', 'SilenceStaff', [('acMapBattleMagicSilenceStaffTilemap', 'SilenceStaff.png')], 0x36F),
    ('SleepStaff', 'g4bppcMapBattleMagicSleepStaff', 'SleepStaff', [('acMapBattleMagicSleepStaffTilemap', 'SleepStaff.png')], 0x36F),
    ('BerserkStaff', 'g4bppcMapBattleMagicBerserkStaff', 'BerserkStaff', [('acMapBattleMagicBerserkStaffTilemap', 'BerserkStaff.png')], 0x36F),
]

# 24 map-battle sprite / action / cutscene / ripple sheets
# (png_stem, region, label, pal_spec)
_PAL_MAGIC = 'data/palettes/MapBattleMagicPalettes.asm'
_PAL_ACTION = 'engine/battle/map_action_animations.asm'
_PAL_CUTSCENE = 'engine/battle/map_magic_effects.asm'
_PAL_RIPPLE = 'engine/battle/map_battle_magic.asm'

MAP_MAGIC_SPRITES = [
    ('FireSprites', 'D50000', 'g4bppcMapBattleMagicFireSprites', (_PAL_MAGIC, 'aMapBattleMagicSpritePaletteFire')),
    ('ElfireSprites', 'D50000', 'g4bppcMapBattleMagicElfireSprites', (_PAL_MAGIC, 'aMapBattleMagicSpritePaletteFire')),
    ('BolganoneSprites', 'D50000', 'g4bppcMapBattleMagicBolganoneSprites', (_PAL_MAGIC, 'aMapBattleMagicSpritePaletteBolganone')),
    ('ValflameSprites', 'D50000', 'g4bppcMapBattleMagicValflameSprites', (_PAL_MAGIC, 'aMapBattleMagicSpritePaletteFire')),
    ('MeteorSprites', 'D50000', 'g4bppcMapBattleMagicMeteorSprites', (_PAL_MAGIC, 'aMapBattleMagicSpritePaletteMeteor')),
    ('ThunderSprites', 'D50000', 'g4bppcMapBattleMagicThunderSprites', (_PAL_MAGIC, 'aMapBattleMagicSpritePaletteFire')),
    ('ThoronSprites', 'D50000', 'g4bppcMapBattleMagicThoronSprites', (_PAL_MAGIC, 'aMapBattleMagicSpritePaletteFire')),
    ('MjolnirSprites', 'D50000', 'g4bppcMapBattleMagicMjolnirSprites', (_PAL_MAGIC, 'aMapBattleMagicSpritePaletteBolganone')),
    ('WindSprites', 'D50000', 'g4bppcMapBattleMagicWindSprites', (_PAL_MAGIC, 'aMapBattleMagicSpritePaletteFire')),
    ('ElwindSprites', 'D50000', 'g4bppcMapBattleMagicElwindSprites', (_PAL_MAGIC, 'aMapBattleMagicSpritePaletteFire')),
    ('TornadoSprites', 'D50000', 'g4bppcMapBattleMagicTornadoSprites', (_PAL_MAGIC, 'aMapBattleMagicSpritePaletteFire')),
    ('LightSprites', 'D50000', 'g4bppcMapBattleMagicLightSprites', (_PAL_MAGIC, 'aMapBattleMagicSpritePaletteLight')),
    ('NosferatuSprites', 'D50000', 'g4bppcMapBattleMagicNosferatuSprites', (_PAL_MAGIC, 'aMapBattleMagicSpritePaletteNosferatu')),
    ('JormungandrSprites', 'D50000', 'g4bppcMapBattleMagicJormungandrSprites', (_PAL_MAGIC, 'aMapBattleMagicSpritePaletteBolganone')),
    ('FenrirSprites', 'D50000', 'g4bppcMapBattleMagicFenrirSprites', (_PAL_MAGIC, 'aMapBattleMagicSpritePaletteBolganone')),
    ('ReturnStaffSprites', 'D50000', 'g4bppcMapBattleMagicReturnStaffSprites', None),
    ('WarpStaffSprites', 'D50000', 'g4bppcMapBattleMagicWarpStaffSprites', (_PAL_MAGIC, 'aMapBattleMagicSpritePaletteFire')),
    ('RescueStaffSprites', 'D50000', 'g4bppcMapBattleMagicRescueStaffSprites', (_PAL_MAGIC, 'aMapBattleMagicSpritePaletteFire')),
    ('ThiefStaffSprites', 'D50000', 'g4bppcMapBattleMagicThiefStaffSprites', (_PAL_MAGIC, 'aMapBattleMagicSpritePaletteLight')),
    ('MapActionEffect1', 'D50000', 'g4bppcMapActionEffectGfx1', (_PAL_ACTION, 'aMapActionEffectOAMPalette')),
    ('MapActionEffect2', 'D50000', 'g4bppcMapActionEffectGfx2', (_PAL_ACTION, 'aMapActionEffectOAMPalette')),
    ('MapMagicCutscene1', 'AFC8C0', 'g4bppcMapMagicCutsceneGfx1', (_PAL_CUTSCENE, 'aMapMagicCutsceneGfxData')),
    ('MapMagicCutscene2', 'D50000', 'g4bppcMapMagicCutsceneGfx2', (_PAL_CUTSCENE, 'aMapMagicCutsceneGfxData')),
    ('MapMagicRipple', 'C00A2B', 'g4bppcMapMagicRippleTiles', (_PAL_RIPPLE, 'aMapMagicRipplePalette')),
]

# 47 battle scene effect / decomp / skill tile sheets in gfx/build/E02EBD/
# (png_stem, label, out_ext, depth, max_bytes, pal_spec)
_DATA_ASM = 'engine/battle_scene/data.asm'
BATTLE_SCENE_TILES = [
    # Spells & staves (4bpp)
    ('Fire', 'g4bppcBattleSceneEffectTilesEF6F42', '.4bpp', 4, 0x1400, (_DATA_ASM, 'aBattleScenePaletteE02090', 0x10)),
    ('BolganoneBG1', 'g4bppcBattleSceneEffectTilesF0013D', '.4bpp', 4, 0x1C00, (_DATA_ASM, 'aBattleScenePaletteScript9BC31B', 1)),
    ('MeteorBG2', 'g4bppcBattleSceneEffectTilesF046BF', '.4bpp', 4, 0x4000, (_DATA_ASM, 'aBattleScenePaletteScript9BD078', 1)),
    ('ThunderBG1', 'g4bppcBattleSceneEffectTilesF2292F', '.4bpp', 4, 0x0A00, (_DATA_ASM, 'aBattleScenePaletteE0215C', 0x7A)),
    ('ElthunderBG1', 'g4bppcBattleSceneEffectTilesF232C0', '.4bpp', 4, 0x1600, (_DATA_ASM, 'aBattleScenePaletteE0215C', 0x98)),
    ('ThoronBG1', 'g4bppcBattleSceneEffectTilesF21081', '.4bpp', 4, 0x1200, (_DATA_ASM, 'aBattleScenePaletteE0215C', 0x5C)),
    ('MjolnirBG1', 'g4bppcBattleSceneEffectTilesF1771D', '.4bpp', 4, 0x1200, (_DATA_ASM, 'aBattleScenePaletteE0215C', 0x3E)),
    ('Wind', 'g4bppcBattleSceneEffectTilesF149C5', '.4bpp', 4, 0x0A00, (_DATA_ASM, 'aBattleScenePaletteScript9BCF26', 1)),
    ('Elwind', 'g4bppcBattleSceneEffectTilesF15110', '.4bpp', 4, 0x1E00, (_DATA_ASM, 'aBattleScenePaletteScript9BCB6B', 1)),
    ('TornadoBG1', 'g4bppcBattleSceneEffectTilesF15FDD', '.4bpp', 4, 0x1000, (_DATA_ASM, 'aBattleScenePaletteScript9BDBE2', 1)),
    ('Forseti', 'g4bppcBattleSceneEffectTilesF12972', '.4bpp', 4, 0x2000, (_DATA_ASM, 'aBattleScenePaletteScript9BCF68', 1)),
    ('BlizzardBG1', 'g4bppcBattleSceneEffectTilesF17076', '.4bpp', 4, 0x0400, (_DATA_ASM, 'aBattleScenePaletteE0215C', 0)),
    ('LightBG1', 'g4bppcBattleSceneEffectTilesF262AC', '.4bpp', 4, 0x1800, (_DATA_ASM, 'aBattleScenePaletteScript9BC6A5', 1)),
    ('Nosferatu', 'g4bppcBattleSceneEffectTilesF078E5', '.4bpp', 4, 0x4000, (_DATA_ASM, 'aBattleScenePaletteScript9BCC89', 1)),
    ('Aura', 'g4bppcBattleSceneEffectTilesF11286', '.4bpp', 4, 0x1C00, (_DATA_ASM, 'aBattleScenePaletteE02090', 0x8A)),
    ('Jormungandr', 'g4bppcBattleSceneEffectTilesF41469', '.4bpp', 4, 0x1000, (_DATA_ASM, 'aTitleScenePaletteE022B7', 0)),
    ('FenrirBG1', 'g4bppcBattleSceneEffectTilesF43D26', '.4bpp', 4, 0x1E00, (_DATA_ASM, 'aBattleScenePaletteScript9BD85C', 1)),
    ('FenrirBG2', 'g4bppcBattleSceneEffectTilesF4493C', '.4bpp', 4, 0x2A00, (_DATA_ASM, 'aBattleScenePaletteE02373', 0)),
    ('HelBG1', 'g4bppcBattleSceneEffectTilesF33DD0', '.4bpp', 4, 0x1400, (_DATA_ASM, 'aBattleScenePaletteE0221D', 0x5C)),
    ('HealStaff', 'g4bppcBattleSceneEffectTilesEF0815', '.4bpp', 4, 0x0C00, (_DATA_ASM, 'aBattleScenePaletteScript9BC16F', 1)),
    ('MendStaff', 'g4bppcBattleSceneEffectTilesEF0C10', '.4bpp', 4, 0x0E00, (_DATA_ASM, 'aBattleScenePaletteScript9BDA02', 1)),
    ('RecoverStaff', 'g4bppcBattleSceneEffectTilesEF1175', '.4bpp', 4, 0x1000, (_DATA_ASM, 'aBattleScenePaletteScript9BDAD8', 1)),
    ('Fortify', 'g4bppcBattleSceneEffectTilesEF19AE', '.4bpp', 4, 0x2000, (_DATA_ASM, 'aBattleScenePaletteScript9BDB8C', 1)),
    ('ReturnStaff', 'g4bppcBattleSceneEffectTilesEF421A', '.4bpp', 4, 0x0220, (_DATA_ASM, 'aBattleScenePaletteScript9BCF01', 1)),
    ('WarpStaff', 'g4bppcBattleSceneEffectTilesEF2EB2', '.4bpp', 4, 0x2000, (_DATA_ASM, 'aBattleScenePaletteScript9BCFEC', 1)),
    ('CharmStaff', 'g4bppcBattleSceneEffectTilesEF6771', '.4bpp', 4, 0x0400, (_DATA_ASM, 'aBattleScenePaletteScript9BC59F', 1)),
    ('RestoreStaff', 'g4bppcBattleSceneEffectTilesEF4324', '.4bpp', 4, 0x1800, (_DATA_ASM, 'aBattleScenePaletteScript9BC82A', 1)),
    ('SilenceStaff', 'g4bppcBattleSceneEffectTilesEF698D', '.4bpp', 4, 0x0520, (_DATA_ASM, 'aBattleScenePaletteE02090', 0)),
    ('SleepStaff', 'g4bppcBattleSceneEffectTilesEF4C33', '.4bpp', 4, 0x1000, (_DATA_ASM, 'aBattleScenePaletteScript9BCDF9', 1)),
    ('BerserkStaff', 'g4bppcBattleSceneEffectTilesEF5739', '.4bpp', 4, 0x2000, (_DATA_ASM, 'aBattleScenePaletteScript9BC241', 1)),
    ('ClassChange', 'g4bppcBattleSceneEffectTilesF61BB4', '.4bpp', 4, 0x0C00, (_DATA_ASM, 'aBattleScenePaletteE027A5', 0)),
    # BG3 2bpp sheets (renamed g2bppc... in the Phase 7 review: 4 were labelled 4bpp, 4 as data)
    ('BolganoneBG3', 'g2bppcBattleSceneEffectTilesF01360', '.2bpp', 2, 0x0500, (_DATA_ASM, 'aBattleScenePaletteE02090', 0x4E)),
    ('MjolnirBG3', 'g2bppcBattleSceneEffectTilesF20083', '.2bpp', 2, 0x0D00, (_DATA_ASM, 'aBattleScenePaletteE0215C', 0x3E)),
    ('ThoronBG3', 'g2bppcBattleSceneEffectTilesF21830', '.2bpp', 2, 0x0E00, (_DATA_ASM, 'aBattleScenePaletteE0215C', 0x5C)),
    ('ElthunderBG3', 'g2bppcBattleSceneEffectTilesF23B79', '.2bpp', 2, 0x0F00, (_DATA_ASM, 'aBattleScenePaletteE0215C', 0x98)),
    ('ThunderBG3', 'g2bppcBattleSceneEffectTilesF22E80', '.2bpp', 2, 0x0200, (_DATA_ASM, 'aBattleScenePaletteE0215C', 0x7A)),
    ('TornadoBG3', 'g2bppcBattleSceneEffectTilesF16C14', '.2bpp', 2, 0x0200, (_DATA_ASM, 'aBattleScenePaletteE02156', 0)),
    ('BlizzardBG3', 'g2bppcBattleSceneEffectTilesF1718D', '.2bpp', 2, 0x0200, (_DATA_ASM, 'aBattleScenePaletteE0215C', 0)),
    ('LightBG3', 'g2bppcBattleSceneEffectTilesF276E0', '.2bpp', 2, 0x0800, (_DATA_ASM, 'aBattleScenePaletteE0215C', 0xBB)),
    # OAM skill strips (renamed g4bppc... from acBattleSceneEffectData...)
    ('SkillSparkle', 'g4bppcBattleSceneEffectTilesF62298', '.4bpp', 4, 0x0040, (_DATA_ASM, 'aBattleSceneAstraColors', 0)),
    ('SkillHoly', 'g4bppcBattleSceneEffectTilesF622C0', '.4bpp', 4, 0x00A0, (_DATA_ASM, 'aBattleSceneHolyColors', 0)),
    ('SkillDarkness', 'g4bppcBattleSceneEffectTilesF6232E', '.4bpp', 4, 0x00A0, (_DATA_ASM, 'aBattleSceneDarknessColors', 0)),
    ('SkillPavise', 'g4bppcBattleSceneEffectTilesF6239C', '.4bpp', 4, 0x0060, (_DATA_ASM, 'aBattleScenePaviseColors', 0)),
    # Decomp / window tile sheets (two renamed g4bppc... from acBattleSceneDecomp...)
    ('LevelUpWindow', 'g4bppcBattleSceneDecompE03105', '.4bpp', 4, 0x0800, (_DATA_ASM, 'aBattleSceneHUDColors', 0)),
    ('LevelUpExtra', 'g4bppcBattleSceneDecompE033A5', '.4bpp', 4, 0x0300, (_DATA_ASM, 'aBattleSceneHUDBaseColors', 0)),
    ('ExpBar', 'g4bppcBattleSceneEffectTilesE03749', '.4bpp', 4, 0x0400, (_DATA_ASM, 'aBattleSceneHUDColors', 0)),
    ('MessageWindow', 'g4bppcBattleSceneDecompE03D7F', '.4bpp', 4, 0x0200, (_DATA_ASM, 'aBattleSceneHUDBaseColors', 0)),
]

# 61 battle scene effect & decomp grid tilemaps grouped into manifests
# Each entry: (manifest_name, depth, palette_specs, sheets_specs, layers_specs)
# where sheets_specs = [(tiles_rel_png, max_tiles)]
# and layers_specs = [(csv_name, tilemap_label, width, height, [(sheet_idx, base)], palettes)]
BATTLE_SCENE_SCENES = [
    ('Fire', 4,
     [{'asm': _DATA_ASM, 'label': 'aBattleScenePaletteE02090', 'byte_offset': 0x10, 'dest': 17, 'count': 15},
      {'asm': _DATA_ASM, 'label': 'aBattleScenePaletteE02090', 'byte_offset': 0x10, 'dest': 33, 'count': 15}],
     [('gfx/effects/battle_scene/tiles/Fire.4bpp.png', 160)],
     [('Fire.csv', 'acBattleSceneEffectTilemapEF7EBA', 64, 32, [(0, 0x200)], [0, 1]),
      ('FireFlip.csv', 'acBattleSceneEffectTilemapEF7FFC', 64, 32, [(0, 0x200)], [0, 1]),
      ('Elfire.csv', 'acBattleSceneEffectTilemapEF7972', 64, 64, [(0, 0x200)], [0, 2])]),
    ('BolganoneBG1', 4,
     [{'asm': _DATA_ASM, 'label': 'aBattleScenePaletteE02090', 'byte_offset': 0x4E, 'dest': 17, 'count': 15},
      {'asm': _DATA_ASM, 'label': 'aBattleScenePaletteScript9BC31B', 'byte_offset': 1, 'dest': 33, 'count': 15}],
     [('gfx/effects/battle_scene/tiles/BolganoneBG1.4bpp.png', 224),
      ('gfx/effects/OutsideTile.4bpp.png', 1)],
     [('BolganoneBG1.csv', 'acBattleSceneEffectDataF016E8', 32, 32, [(0, 0x200), (1, 0)], [0, 2])]),
    ('BolganoneBG3', 2,
     [{'asm': _DATA_ASM, 'label': 'aBattleScenePaletteE02090', 'byte_offset': 0x4E, 'dest': 1, 'count': 15}],
     [('gfx/effects/battle_scene/tiles/BolganoneBG3.2bpp.png', 80)],
     [('BolganoneBG3.csv', 'acBattleSceneEffectDataF018FC', 32, 32, [(0, 0)], [0, 4, 5, 6])]),
    ('Valflame', 4,
     [{'asm': _DATA_ASM, 'label': 'aBattleScenePaletteE02090', 'byte_offset': 0x6C, 'dest': 17, 'count': 15},
      {'asm': _DATA_ASM, 'label': 'aBattleScenePaletteScript9BD3C5', 'byte_offset': 1, 'dest': 65, 'count': 15}],
     [('gfx/build/E02EBD/g4bppcTitleSceneTilesF019F4.4bpp.png', 192)],
     [('ValflameBG2.csv', 'acBattleSceneEffectDataF0358F', 32, 32, [(0, 0)], [0, 4]),
      ('ValflameBG2Alt.csv', 'acBattleSceneEffectDataF03771', 32, 32, [(0, 0)], [0, 4])]),
    ('Meteor', 4,
     [{'asm': _DATA_ASM, 'label': 'aBattleScenePaletteScript9BD078', 'byte_offset': 1, 'dest': 49, 'count': 15},
      {'asm': _DATA_ASM, 'label': 'aBattleScenePaletteScript9BD092', 'byte_offset': 1, 'dest': 65, 'count': 15}],
     [('gfx/effects/battle_scene/tiles/MeteorBG2.4bpp.png', 512)],
     [('MeteorBG2.csv', 'acBattleSceneEffectDataF07009', 32, 32, [(0, 0)], [0, 3]),
      ('MeteorBG2Phase2.csv', 'acBattleSceneEffectDataF07458', 32, 32, [(0, 0)], [4])]),
    ('ThunderBG1', 4,
     [{'asm': _DATA_ASM, 'label': 'aBattleScenePaletteE0215C', 'byte_offset': 0x7A, 'dest': 17, 'count': 15},
      {'asm': _DATA_ASM, 'label': 'aBattleScenePaletteScript9BC92C', 'byte_offset': 1, 'dest': 33, 'count': 15}],
     [('gfx/effects/battle_scene/tiles/ThunderBG1.4bpp.png', 80)],
     [('ThunderBG1.csv', 'acBattleSceneEffectTilemapF22FD8', 64, 32, [(0, 0x200)], [0, 2])]),
    ('ThunderBG3', 2,
     [{'asm': _DATA_ASM, 'label': 'aBattleScenePaletteE0215C', 'byte_offset': 0x7A, 'dest': 1, 'count': 15}],
     [('gfx/effects/battle_scene/tiles/ThunderBG3.2bpp.png', 32)],
     [('ThunderBG3.csv', 'acBattleSceneEffectDataF2316A', 32, 32, [(0, 0)], [0, 4, 5, 6])]),
    ('ElthunderBG1', 4,
     [{'asm': _DATA_ASM, 'label': 'aBattleScenePaletteE0215C', 'byte_offset': 0x98, 'dest': 17, 'count': 12},
      {'asm': _DATA_ASM, 'label': 'aBattleScenePaletteScript9BC92C', 'byte_offset': 1, 'dest': 33, 'count': 15}],
     [('gfx/effects/battle_scene/tiles/ElthunderBG1.4bpp.png', 176)],
     [('ElthunderBG1.csv', 'acBattleSceneEffectTilemapF2447D', 64, 32, [(0, 0x200)], [0, 2])]),
    ('ElthunderBG3', 2,
     [{'asm': _DATA_ASM, 'label': 'aBattleScenePaletteE0215C', 'byte_offset': 0x98, 'dest': 1, 'count': 12}],
     [('gfx/effects/battle_scene/tiles/ElthunderBG3.2bpp.png', 240)],
     [('ElthunderBG3.csv', 'acBattleSceneEffectDataF246DA', 32, 32, [(0, 0)], [0, 4, 5, 6])]),
    ('ThoronBG1', 4,
     [{'asm': _DATA_ASM, 'label': 'aBattleScenePaletteE0215C', 'byte_offset': 0x5C, 'dest': 17, 'count': 15},
      {'asm': _DATA_ASM, 'label': 'aBattleScenePaletteScript9BD99A', 'byte_offset': 1, 'dest': 33, 'count': 15}],
     [('gfx/effects/battle_scene/tiles/ThoronBG1.4bpp.png', 144)],
     [('ThoronBG1.csv', 'acBattleSceneEffectTilemapF2200D', 64, 32, [(0, 0x220)], [0, 1]),
      ('ThoronBG1Flip.csv', 'acBattleSceneEffectTilemapF22128', 64, 32, [(0, 0x220)], [0, 1]),
      ('ThoronBG2.csv', 'acBattleSceneEffectTilemapF22240', 64, 32, [(0, 0x220)], [2])]),
    ('ThoronBG3', 2,
     [{'asm': _DATA_ASM, 'label': 'aBattleScenePaletteE0215C', 'byte_offset': 0x5C, 'dest': 1, 'count': 15}],
     [('gfx/effects/battle_scene/tiles/ThoronBG3.2bpp.png', 224),
      ('gfx/effects/OutsideTile.2bpp.png', 1)],
     [('ThoronBG3.csv', 'acBattleSceneEffectDataF22579', 32, 32, [(0, 0), (1, 0xFF)], [0, 4, 5, 6]),
      ('ThoronBG3Strip.csv', 'acBattleSceneEffectTilemapF22851', 32, 16, [(0, 0), (1, 0xFF)], [0, 4, 5, 6])]),
    ('MjolnirBG1', 4,
     [{'asm': _DATA_ASM, 'label': 'aBattleScenePaletteE0215C', 'byte_offset': 0x3E, 'dest': 17, 'count': 15},
      {'asm': _DATA_ASM, 'label': 'aBattleScenePaletteScript9BD8C8', 'byte_offset': 1, 'dest': 33, 'count': 15}],
     [('gfx/effects/battle_scene/tiles/MjolnirBG1.4bpp.png', 144)],
     [('MjolnirBG1.csv', 'acBattleSceneEffectDataF206F9', 32, 32, [(0, 0x200)], [0, 2])]),
    ('MjolnirBG3', 2,
     [{'asm': _DATA_ASM, 'label': 'aBattleScenePaletteE0215C', 'byte_offset': 0x3E, 'dest': 1, 'count': 15}],
     [('gfx/effects/battle_scene/tiles/MjolnirBG3.2bpp.png', 208)],
     [('MjolnirBG3.csv', 'acBattleSceneEffectTilemapF209BE', 32, 96, [(0, 0)], [0, 4, 5, 6])]),
    ('Wind', 4,
     [{'asm': _DATA_ASM, 'label': 'aBattleScenePaletteScript9BCF26', 'byte_offset': 1, 'dest': 33, 'count': 14}],
     [('gfx/effects/battle_scene/tiles/Wind.4bpp.png', 80)],
     [('Wind.csv', 'acBattleSceneEffectTilemapF14E0F', 64, 32, [(0, 0x200)], [0, 2]),
      ('WindFlip.csv', 'acBattleSceneEffectTilemapF14F90', 64, 32, [(0, 0x200)], [0, 2])]),
    ('Elwind', 4,
     [{'asm': _DATA_ASM, 'label': 'aBattleScenePaletteScript9BCB6B', 'byte_offset': 1, 'dest': 33, 'count': 15}],
     [('gfx/effects/battle_scene/tiles/Elwind.4bpp.png', 240)],
     [('Elwind.csv', 'acBattleSceneEffectTilemapF15927', 64, 32, [(0, 0x200)], [2]),
      ('ElwindFlip.csv', 'acBattleSceneEffectTilemapF15C82', 64, 32, [(0, 0x200)], [2])]),
    ('TornadoBG1', 4,
     [{'asm': _DATA_ASM, 'label': 'aBattleScenePaletteScript9BDBE2', 'byte_offset': 1, 'dest': 33, 'count': 15}],
     [('gfx/effects/battle_scene/tiles/TornadoBG1.4bpp.png', 128)],
     [('TornadoBG1.csv', 'acBattleSceneEffectTilemapF16912', 64, 32, [(0, 0x200)], [0, 2]),
      ('TornadoBG1Flip.csv', 'acBattleSceneEffectTilemapF16A9C', 64, 32, [(0, 0x200)], [0, 2])]),
    ('TornadoBG3', 2,
     [{'asm': _DATA_ASM, 'label': 'aBattleScenePaletteE02156', 'byte_offset': 0, 'dest': 1, 'count': 3}],
     [('gfx/effects/battle_scene/tiles/TornadoBG3.2bpp.png', 32)],
     [('TornadoBG3.csv', 'acBattleSceneEffectDataF16D80', 32, 32, [(0, 0)], [0, 4])]),
    ('Forseti', 4,
     [{'asm': _DATA_ASM, 'label': 'aBattleScenePaletteE02138', 'byte_offset': 0, 'dest': 17, 'count': 15},
      {'asm': _DATA_ASM, 'label': 'aBattleScenePaletteScript9BCF68', 'byte_offset': 1, 'dest': 33, 'count': 15}],
     [('gfx/effects/battle_scene/tiles/Forseti.4bpp.png', 256)],
     [('ForsetiBG1.csv', 'acBattleSceneEffectTilemapF14061', 64, 32, [(0, 0x200)], [0, 2]),
      ('ForsetiBG3.csv', 'acBattleSceneEffectDataF14534', 32, 32, [(0, 0x200)], [1])]),
    ('BlizzardBG1', 4,
     [{'asm': _DATA_ASM, 'label': 'aBattleScenePaletteE0215C', 'byte_offset': 0, 'dest': 33, 'count': 15}],
     [('gfx/effects/battle_scene/tiles/BlizzardBG1.4bpp.png', 32)],
     [('BlizzardBG1.csv', 'acBattleSceneEffectDataF17245', 32, 32, [(0, 0x200)], [0, 2]),
      ('BlizzardBG1Flip.csv', 'acBattleSceneEffectDataF173D5', 32, 32, [(0, 0x200)], [0, 2])]),
    ('BlizzardBG3', 2,
     [{'asm': _DATA_ASM, 'label': 'aBattleScenePaletteE0215C', 'byte_offset': 0, 'dest': 1, 'count': 15}],
     [('gfx/effects/battle_scene/tiles/BlizzardBG3.2bpp.png', 32)],
     [('BlizzardBG3.csv', 'acBattleSceneEffectDataF1756A', 32, 32, [(0, 0)], [0, 4]),
      ('BlizzardBG3Flip.csv', 'acBattleSceneEffectDataF17647', 32, 32, [(0, 0)], [0, 4])]),
    ('LightBG1', 4,
     [{'asm': _DATA_ASM, 'label': 'aBattleScenePaletteE0215C', 'byte_offset': 0xBB, 'dest': 17, 'count': 3},
      {'asm': _DATA_ASM, 'label': 'aBattleScenePaletteScript9BC6A5', 'byte_offset': 1, 'dest': 33, 'count': 15}],
     [('gfx/effects/battle_scene/tiles/LightBG1.4bpp.png', 192),
      ('gfx/effects/OutsideTile.4bpp.png', 1)],
     [('LightBG1.csv', 'acBattleSceneEffectDataF2736D', 32, 32, [(0, 0x200), (1, 0)], [0, 2])]),
    ('LightBG3', 2,
     [{'asm': _DATA_ASM, 'label': 'aBattleScenePaletteE0215C', 'byte_offset': 0xBB, 'dest': 1, 'count': 3}],
     [('gfx/effects/battle_scene/tiles/LightBG3.2bpp.png', 128)],
     [('LightBG3.csv', 'acBattleSceneEffectDataF27D79', 32, 32, [(0, 0)], [4])]),
    ('Nosferatu', 4,
     [{'asm': _DATA_ASM, 'label': 'aBattleScenePaletteScript9BCC89', 'byte_offset': 1, 'dest': 17, 'count': 10},
      {'asm': _DATA_ASM, 'label': 'aBattleScenePaletteScript9BCC89', 'byte_offset': 1, 'dest': 33, 'count': 10}],
     [('gfx/effects/battle_scene/tiles/Nosferatu.4bpp.png', 512)],
     [('NosferatuBG1.csv', 'acBattleSceneEffectTilemapF10762', 64, 32, [(0, 0x100)], [0, 1, 2]),
      ('NosferatuBG2.csv', 'acBattleSceneEffectDataF10DF5', 32, 32, [(0, 0)], [1])]),
    ('Aura', 4,
     [{'asm': _DATA_ASM, 'label': 'aBattleScenePaletteE02090', 'byte_offset': 0x8A, 'dest': 33, 'count': 15},
      {'asm': _DATA_ASM, 'label': 'aBattleScenePaletteScript9BD72E', 'byte_offset': 1, 'dest': 49, 'count': 15}],
     [('gfx/effects/battle_scene/tiles/Aura.4bpp.png', 224)],
     [('AuraBG1.csv', 'acBattleSceneEffectTilemapF124AF', 32, 64, [(0, 0x200)], [0, 2]),
      ('AuraBG2.csv', 'acBattleSceneEffectDataF12801', 32, 32, [(0, 0)], [3])]),
    ('Jormungandr', 4,
     [{'asm': _DATA_ASM, 'label': 'aTitleScenePaletteE022B7', 'byte_offset': 0, 'dest': 33, 'count': 15}],
     [('gfx/effects/battle_scene/tiles/Jormungandr.4bpp.png', 128)],
     [('Jormungandr.csv', 'acBattleSceneEffectDataF41C5A', 32, 32, [(0, 0x200)], [2]),
      ('JormungandrFlip.csv', 'acBattleSceneEffectDataF41DCD', 32, 32, [(0, 0x200)], [2])]),
    ('Fenrir', 4,
     [{'asm': _DATA_ASM, 'label': 'aBattleScenePaletteScript9BD85C', 'byte_offset': 1, 'dest': 33, 'count': 14},
      {'asm': _DATA_ASM, 'label': 'aBattleScenePaletteE02373', 'byte_offset': 0, 'dest': 49, 'count': 31}],
     [('gfx/effects/battle_scene/tiles/FenrirBG1.4bpp.png', 240),
      ('gfx/effects/battle_scene/tiles/FenrirBG2.4bpp.png', 336)],
     [('FenrirBG1.csv', 'acBattleSceneEffectDataF460FF', 32, 32, [(0, 0x200)], [2]),
      ('FenrirBG2.csv', 'acBattleSceneEffectTilemapF46551', 64, 64, [(1, 0)], [3, 4])]),
    ('Hel', 4,
     [{'asm': _DATA_ASM, 'label': 'aBattleScenePaletteE0221D', 'byte_offset': 0x5C, 'dest': 33, 'count': 15}],
     [('gfx/effects/battle_scene/tiles/HelBG1.4bpp.png', 160)],
     [('HelBG1.csv', 'acBattleSceneEffectDataF40D9D', 32, 32, [(0, 0x300)], [2])]),
    ('HealStaff', 4,
     [{'asm': _DATA_ASM, 'label': 'aBattleScenePaletteScript9BC16F', 'byte_offset': 1, 'dest': 33, 'count': 7}],
     [('gfx/effects/battle_scene/tiles/HealStaff.4bpp.png', 96)],
     [('HealStaff.csv', 'acBattleSceneEffectTilemapEF0A82', 64, 32, [(0, 0x300)], [2])]),
    ('MendStaff', 4,
     [{'asm': _DATA_ASM, 'label': 'aBattleScenePaletteScript9BDA02', 'byte_offset': 1, 'dest': 33, 'count': 7}],
     [('gfx/effects/battle_scene/tiles/MendStaff.4bpp.png', 112)],
     [('MendStaff.csv', 'acBattleSceneEffectTilemapEF0F33', 64, 32, [(0, 0x300)], [2])]),
    ('RecoverStaff', 4,
     [{'asm': _DATA_ASM, 'label': 'aBattleScenePaletteScript9BDAD8', 'byte_offset': 1, 'dest': 33, 'count': 7}],
     [('gfx/effects/battle_scene/tiles/RecoverStaff.4bpp.png', 128)],
     [('RecoverStaff.csv', 'acBattleSceneEffectTilemapEF1680', 64, 32, [(0, 0x300)], [2])]),
    ('Fortify', 4,
     [{'asm': _DATA_ASM, 'label': 'aBattleScenePaletteScript9BDB8C', 'byte_offset': 1, 'dest': 36, 'count': 12}],
     [('gfx/effects/battle_scene/tiles/Fortify.4bpp.png', 256)],
     [('Fortify.csv', 'acBattleSceneEffectDataEF29FC', 32, 32, [(0, 0x200)], [0, 2])]),
    ('ReturnStaff', 4,
     [{'asm': _DATA_ASM, 'label': 'aBattleScenePaletteScript9BCF01', 'byte_offset': 1, 'dest': 33, 'count': 8}],
     [('gfx/effects/battle_scene/tiles/ReturnStaff.4bpp.png', 17)],
     [('ReturnStaff.csv', 'acBattleSceneEffectTilemapEF4246', 64, 32, [(0, 0x300)], [0, 2])]),
    ('WarpStaff', 4,
     [{'asm': _DATA_ASM, 'label': 'aBattleScenePaletteE02080', 'byte_offset': 0, 'dest': 40, 'count': 2},
      {'asm': _DATA_ASM, 'label': 'aBattleScenePaletteScript9BCFEC', 'byte_offset': 1, 'dest': 33, 'count': 7}],
     [('gfx/effects/battle_scene/tiles/WarpStaff.4bpp.png', 256)],
     [('WarpStaff.csv', 'acBattleSceneEffectTilemapEF3FF1', 64, 32, [(0, 0x200)], [0, 2])]),
    ('CharmStaff', 4,
     [{'asm': _DATA_ASM, 'label': 'aBattleScenePaletteScript9BC59F', 'byte_offset': 1, 'dest': 33, 'count': 15}],
     [('gfx/effects/battle_scene/tiles/CharmStaff.4bpp.png', 32)],
     [('CharmStaff.csv', 'acBattleSceneEffectDataEF68C3', 32, 32, [(0, 0x200)], [2])]),
    ('RestoreStaff', 4,
     [{'asm': _DATA_ASM, 'label': 'aBattleScenePaletteScript9BC82A', 'byte_offset': 1, 'dest': 33, 'count': 8},
      {'asm': _DATA_ASM, 'label': 'aBattleScenePaletteE02080', 'byte_offset': 4, 'dest': 41, 'count': 3}],
     [('gfx/effects/battle_scene/tiles/RestoreStaff.4bpp.png', 192)],
     [('RestoreStaff.csv', 'acBattleSceneEffectTilemapEF49D5', 32, 64, [(0, 0x200)], [0, 2])]),
    ('SilenceStaff', 4,
     [{'asm': _DATA_ASM, 'label': 'aBattleScenePaletteE02090', 'byte_offset': 0, 'dest': 33, 'count': 8}],
     [('gfx/effects/battle_scene/tiles/SilenceStaff.4bpp.png', 41)],
     [('SilenceStaff.csv', 'acBattleSceneEffectDataEF6D77', 32, 32, [(0, 0x200)], [2])]),
    ('SleepStaff', 4,
     [{'asm': _DATA_ASM, 'label': 'aBattleScenePaletteScript9BCDF9', 'byte_offset': 1, 'dest': 33, 'count': 14}],
     [('gfx/effects/battle_scene/tiles/SleepStaff.4bpp.png', 128),
      ('gfx/effects/OutsideTile.4bpp.png', 1)],
     [('SleepStaff.csv', 'acBattleSceneEffectTilemapEF5460', 32, 64, [(0, 0x200), (1, 0)], [0, 2])]),
    ('BerserkStaff', 4,
     [{'asm': _DATA_ASM, 'label': 'aBattleScenePaletteScript9BC241', 'byte_offset': 1, 'dest': 33, 'count': 15}],
     [('gfx/effects/battle_scene/tiles/BerserkStaff.4bpp.png', 256)],
     [('BerserkStaff.csv', 'acBattleSceneEffectTilemapEF6513', 64, 32, [(0, 0x200)], [0, 2])]),
    ('ClassChangeEffect', 4,
     [{'asm': _DATA_ASM, 'label': 'aBattleScenePaletteE027A5', 'byte_offset': 0, 'dest': 81, 'count': 15}],
     [('gfx/effects/battle_scene/tiles/ClassChange.4bpp.png', 96)],
     [('ClassChangeEffect.csv', 'acBattleSceneEffectDataF621E6', 32, 32, [(0, 0x100)], [5])]),
    ('JuliusEnd', 4,
     [{'asm': _DATA_ASM, 'label': 'aBattleScenePaletteE02315', 'byte_offset': 0, 'dest': 17, 'count': 31}],
     [('gfx/build/E02EBD/g4bppcTitleSceneTilesF41F38.4bpp.png', 416)],
     [('JuliusEnd.csv', 'acBattleSceneEffectDataF43AD9', 32, 32, [(0, 0)], [0, 1, 2])]),
    ('BattleSceneLevelUpWindow', 4,
     [{'asm': _DATA_ASM, 'label': 'aBattleSceneHUDBaseColors', 'dest': 0, 'count': 16},
      {'asm': _DATA_ASM, 'label': 'aBattleSceneHUDColors', 'offset': 0, 'dest': 97, 'count': 8},
      {'asm': _DATA_ASM, 'label': 'aBattleSceneHUDColors', 'offset': 11, 'dest': 113, 'count': 8}],
     [('gfx/effects/battle_scene/tiles/LevelUpWindow.4bpp.png', 64),
      ('gfx/effects/battle_scene/tiles/LevelUpExtra.4bpp.png', 24),
      ('gfx/build/E02EBD/g4bppcBattleSceneHUDTiles.4bpp.png', 32)],
     [('LevelUpWindow.csv', 'acBattleSceneDecompTilemapE03B09', 32, 20, [(0, 0x20), (1, 0xC0), (2, 0xE0)], [0, 6, 7])]),
    ('BattleSceneLevelUpBG3', 2,
     [{'asm': _DATA_ASM, 'label': 'aBattleSceneHUDBaseColors', 'dest': 0, 'count': 16}],
     [('gfx/build/E02EBD/gcBattleSceneStatLabels.2bpp.png', 64)],
     [('LevelUpBG3.csv', 'acBattleSceneDecompTilemapE03D3B', 32, 10, [(0, 0x180)], [0])]),
    ('BattleSceneMessageWindow', 4,
     [{'asm': _DATA_ASM, 'label': 'aBattleSceneHUDBaseColors', 'dest': 0, 'count': 16},
      {'asm': _DATA_ASM, 'label': 'aBattleSceneHUDColors', 'offset': 11, 'dest': 113, 'count': 8}],
     [('gfx/effects/battle_scene/tiles/MessageWindow.4bpp.png', 16)],
     [('MessageWindow.csv', 'acBattleSceneDecompTilemapE04000', 32, 10, [(0, 0x80)], [0, 7]),
      ('MessageWindowNoPortrait.csv', 'acBattleSceneDecompTilemapE040D3', 32, 10, [(0, 0x80)], [0])]),
]


def _repo_path(rel):
    return rel if os.path.isabs(rel) else os.path.join(ROOT, rel)


def _decompress_comp(path):
    with open(path, 'rb') as f:
        orig = f.read()
    buf = bytearray(0x400000)
    buf[:len(orig)] = orig
    return decompress(bytes(buf), 0xC00000)[0]


def _bgr555_to_rgb(w):
    return tuple((w >> s & 31) * 255 // 31 for s in (0, 5, 10))


def _load_sheet_palette(pal_spec, depth):
    if pal_spec is None:
        return gfx.grey(depth)
    asm_rel, label = pal_spec[:2]
    byte_off = pal_spec[2] if len(pal_spec) > 2 else 0
    cols = scene_pack._parse_asm_palette(_repo_path(asm_rel), label, byte_off)
    if byte_off != 0 or 'Script' in label:
        cols = [(0, 0, 0)] + cols
    n = 1 << depth
    cols = (cols + [(0, 0, 0)] * n)[:n]
    return cols


def _write_png_from_bytes(raw, out_path, depth, pal_spec):
    os.makedirs(os.path.dirname(out_path), exist_ok=True)
    cols = _load_sheet_palette(pal_spec, depth)
    gfx.bpp_to_png(raw, cols, 16, depth).save(out_path)


def _pack_sheet_png(png_path, depth, max_bytes):
    img = Image.open(png_path)
    if img.mode != 'P':
        raise ValueError(f'{png_path}: expected indexed (P) PNG, got {img.mode}')
    w, h = img.size
    if w % 8 or h % 8:
        raise ValueError(f'{png_path}: {w}x{h} is not a whole number of 8x8 tiles')
    raw = gfx.png_to_bpp(png_path, depth)
    if len(raw) > max_bytes:
        if any(raw[max_bytes:]):
            raise ValueError(
                f'{png_path}: non-zero pixels past ${max_bytes:04X}-byte budget '
                f'({len(raw)} bytes)')
        raw = raw[:max_bytes]
    return raw


def _parse_palette_asm(asm_path):
    words = []
    for line in open(asm_path, encoding='utf-8'):
        code = line.split(';', 1)[0].strip()
        if not code or not code.startswith('.word'):
            continue
        for m in BGR555_RE.finditer(code):
            r, g, b = (int(m.group(k)) for k in (1, 2, 3))
            for ch, v in (('R', r), ('G', g), ('B', b)):
                if not 0 <= v <= 31:
                    raise ValueError(f'{asm_path}: {ch} channel {v} out of 0..31')
            words.append(r | (g << 5) | (b << 10))
    if len(words) != 256:
        raise ValueError(f'{asm_path}: expected 256 colors, got {len(words)}')
    return struct.pack('<256H', *words)


def _format_palette_asm(name, raw):
    words = struct.unpack('<256H', raw)
    lines = [
        f'; Map-battle magic palette for {name} (256 BGR555 colors).',
        '; BG palettes 6 and 7 (colors $69-$6F) are copied by rlCopyMapMagicBackgroundColors.',
        '',
        f'acMapBattleMagic{name}Palette',
    ]
    for p in range(16):
        lines.append(f'  ; Palette {p}')
        for row in (0, 8):
            chunk = words[p * 16 + row:p * 16 + row + 8]
            items = ', '.join(f'bgr555({w & 31:2d}, {(w >> 5) & 31:2d}, {(w >> 10) & 31:2d})'
                              for w in chunk)
            lines.append(f'  .word {items}')
    return '\n'.join(lines) + '\n'


def _write_csv(path, words, width, height):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, 'w', newline='', encoding='utf-8') as f:
        w = csv.writer(f, lineterminator='\n')
        for ty in range(height):
            w.writerow([entry_text(words[scene_pack.tilemap_index(tx, ty, width)])
                        for tx in range(width)])


def all_managed_palettes():
    """Return {label: source_rel_path} for the 21 map-battle magic palettes."""
    return {
        f'acMapBattleMagic{name}Palette': f'gfx/effects/map_magic/palettes/{name}.asm'
        for name in MAP_MAGIC_PALETTES
    }


def all_managed_sheets():
    """Return {label: (source_rel_path, out_rel_path)} for the 71 effect tile sheets."""
    out = {}
    for stem, region, label, _ in MAP_MAGIC_SPRITES:
        out[label] = (
            f'gfx/effects/map_magic/sprites/{stem}.4bpp.png',
            f'gfx/build/{region}/{label}.4bpp',
        )
    for stem, label, ext, depth, _, _ in BATTLE_SCENE_TILES:
        out[label] = (
            f'gfx/effects/battle_scene/tiles/{stem}.{depth}bpp.png',
            f'gfx/build/E02EBD/{label}{ext}',
        )
    return out


def unpack(force=False):
    # 1. Map-battle magic palettes
    os.makedirs(MAP_MAGIC_PAL_DIR, exist_ok=True)
    for name in MAP_MAGIC_PALETTES:
        comp = _repo_path(f'gfx/build/D50000/acMapBattleMagic{name}Palette.bin.comp')
        out_asm = os.path.join(MAP_MAGIC_PAL_DIR, f'{name}.asm')
        if force or not os.path.exists(out_asm):
            raw = _decompress_comp(comp)
            with open(out_asm, 'w', encoding='utf-8') as f:
                f.write(_format_palette_asm(name, raw))

    # 2. Map-battle magic scene manifests + PNGs
    for name, sheet_lbl, pal_name, tms, ext_blank in MAP_MAGIC_SCENES:
        mp = os.path.join(MAP_MAGIC_DIR, f'MapMagic{name}.scene.json')
        sheets = [{
            'comp': f'gfx/build/D50000/{sheet_lbl}.4bpp.comp',
            'max_tiles': 128,
            'writable': True,
        }]
        layer_sheets = [{'sheet': 0, 'base': 0x380}]
        if ext_blank is not None:
            sheets.append({
                'png': 'gfx/effects/OutsideTile.4bpp.png',
                'max_tiles': 1,
                'writable': False,
            })
            layer_sheets.append({'sheet': 1, 'base': ext_blank})
        layers = []
        for tm_lbl, png_name in tms:
            tm_rel = f'gfx/build/D50000/{tm_lbl}.bin'
            tm_raw = _decompress_comp(_repo_path(tm_rel + '.comp'))
            words = struct.unpack(f'<{len(tm_raw) // 2}H', tm_raw)
            pals = sorted({(w >> 10) & 7 for w in words})
            layers.append({
                'png': png_name,
                'tilemap': tm_rel,
                'width': 32,
                'height': 32,
                'transparent': False,
                'palettes': pals,
                'sheets': layer_sheets,
                'append_sheet': 0,
            })
        manifest = {
            'depth': 4,
            'palette': [{
                'asm': f'gfx/effects/map_magic/palettes/{pal_name}.asm',
                'label': f'acMapBattleMagic{pal_name}Palette',
                'dest': 0,
                'count': 128,
            }],
            'sheets': sheets,
            'layers': layers,
        }
        scene_pack.write_manifest(mp, manifest)
        scene_pack.unpack_scene(mp, force=force)

    # 3. Map-battle magic / action / cutscene / ripple sprite sheets
    os.makedirs(MAP_MAGIC_SPR_DIR, exist_ok=True)
    for stem, region, label, pal_spec in MAP_MAGIC_SPRITES:
        out_png = os.path.join(MAP_MAGIC_SPR_DIR, f'{stem}.4bpp.png')
        if force or not os.path.exists(out_png):
            comp = _repo_path(f'gfx/build/{region}/{label}.4bpp.comp')
            _write_png_from_bytes(_decompress_comp(comp), out_png, 4, pal_spec)

    # 4. Battle scene effect / decomp / skill tile sheets
    os.makedirs(BATTLE_SCENE_TILES_DIR, exist_ok=True)
    for stem, label, ext, depth, _, pal_spec in BATTLE_SCENE_TILES:
        out_png = os.path.join(BATTLE_SCENE_TILES_DIR, f'{stem}.{depth}bpp.png')
        if force or not os.path.exists(out_png):
            comp = _repo_path(f'gfx/build/E02EBD/{label}{ext}.comp')
            _write_png_from_bytes(_decompress_comp(comp), out_png, depth, pal_spec)

    # 5. Battle scene effect & decomp grid manifests + CSVs
    os.makedirs(BATTLE_SCENE_DIR, exist_ok=True)
    for mname, depth, pal_specs, sheet_specs, layer_specs in BATTLE_SCENE_SCENES:
        mp = os.path.join(BATTLE_SCENE_DIR, f'{mname}.scene.json')
        sheets = [{'png': sp, 'max_tiles': mt, 'writable': False} for sp, mt in sheet_specs]
        layers = []
        for csv_name, tm_lbl, width, height, l_sheets, pals in layer_specs:
            tm_rel = f'gfx/build/E02EBD/{tm_lbl}.bin'
            tm_raw = _decompress_comp(_repo_path(tm_rel + '.comp'))
            words = struct.unpack(f'<{len(tm_raw) // 2}H', tm_raw)
            _write_csv(os.path.join(BATTLE_SCENE_DIR, csv_name), words, width, height)
            layers.append({
                'grid': csv_name,
                'tilemap': tm_rel,
                'width': width,
                'height': height,
                'transparent': True,
                'palettes': pals,
                'sheets': [{'sheet': si, 'base': base} for si, base in l_sheets],
            })
        manifest = {
            'depth': depth,
            'palette': pal_specs,
            'sheets': sheets,
            'layers': layers,
        }
        manifest['palette'], _ = traced_palette([l[1] for l in layer_specs], pal_specs)
        scene_pack.write_manifest(mp, manifest)
        # Verify byte-identical pack immediately
        _, tm_outs = scene_pack.pack_scene(mp, write=False)
        for layer in layers:
            want = _decompress_comp(_repo_path(layer['tilemap'] + '.comp'))
            got = tm_outs[_repo_path(layer['tilemap'])]
            assert got == want, f'{mname}/{layer["tilemap"]}: pack mismatch ({len(got)} vs {len(want)})'


def traced_palette(tilemap_labels, fallback):
    """(palette specs, notes) for a battle scene manifest: the colors the scripts
    that load its layers write (tools/battle_scene_palettes.py), the first
    layer's last so they win; fallback when no script loads any of them."""
    specs, notes = [], []
    for lbl in reversed(tilemap_labels):
        s, sid, n = battle_scene_palettes.specs_for_tilemap(lbl)
        notes += [f'{lbl}: {x}' for x in n]
        for spec in s:
            spec['from'] = f'script {sid:#04x}: ' + spec['from']
            if spec not in specs:
                specs.append(spec)
    if not specs:
        # A hand-written spec that reads a palette effect stream (big-endian, with
        # delay bytes) as plain colors shows wrong colors: grey says "unknown".
        if any('PaletteScript' in f.get('label', '') for f in fallback):
            notes.append('no traced colors; palette grey (the spec written by hand read a palette '
                         'effect stream as plain colors)')
            return 'grey', notes
        notes.append('no traced colors; palette kept as written by hand')
        return fallback, notes
    return specs, notes


def _cell_tile_palette(cell):
    t, rest = cell.split(':')
    return int(t, 16), int(rest[0])


def retrace_palettes(write=True):
    """Rewrite the palette of every gfx/effects/battle_scene manifest from the trace,
    then recolor the effect tile sheet PNGs with the sub-palette their layers use
    most. Returns notes for manifests the trace could not color."""
    report = []
    use = {}      # sheet png -> {(manifest, sub-palette): count}
    for mname, depth, pal_specs, sheet_specs, layer_specs in BATTLE_SCENE_SCENES:
        mp = os.path.join(BATTLE_SCENE_DIR, f'{mname}.scene.json')
        m = json.load(open(mp, encoding='utf-8'))
        specs, notes = traced_palette([l[1] for l in layer_specs], pal_specs)
        report += [f'{mname}: {n}' for n in notes]
        m['palette'] = specs
        if write:
            scene_pack.write_manifest(mp, m)
        for layer in m['layers']:
            rows = list(csv.reader(open(os.path.join(BATTLE_SCENE_DIR, layer['grid']), encoding='utf-8')))
            for row in rows:
                for cell in row:
                    t, p = _cell_tile_palette(cell)
                    for ls in layer['sheets']:
                        sheet = m['sheets'][ls['sheet']]
                        if ls['base'] <= t < ls['base'] + sheet['max_tiles'] and 'png' in sheet:
                            key = (mp, p)
                            use.setdefault(sheet['png'], {})
                            use[sheet['png']][key] = use[sheet['png']].get(key, 0) + 1
        # Sub-palettes the layers use that no traced color reaches.
        cgram = scene_pack.load_palette(m['palette'], depth)
        stride = 1 << depth
        used = sorted({p for l in m['layers'] for p in l['palettes']})
        dark = [p for p in used if p and not any(c != (0, 0, 0) for c in cgram[p * stride + 1:(p + 1) * stride])]
        if dark:
            report.append(f'{mname}: sub-palettes {dark} get no colors from its script '
                          '(set at run time by other code, or unused)')
    for png, counts in use.items():
        if not png.startswith('gfx/effects/battle_scene/tiles/'):
            continue
        (mp, p), _ = max(counts.items(), key=lambda kv: kv[1])
        m = json.load(open(mp, encoding='utf-8'))
        depth = m['depth']
        stride = 1 << depth
        cols = scene_pack.load_palette(m['palette'], depth)[p * stride:(p + 1) * stride]
        if write and any(c != (0, 0, 0) for c in cols[1:]):
            path = _repo_path(png)
            img = Image.open(path)
            flat = [v for c in cols for v in c]
            img.putpalette(flat + [0] * (768 - len(flat)))
            img.save(path)
    return report


def build():
    n = 0
    for name in MAP_MAGIC_PALETTES:
        src = os.path.join(MAP_MAGIC_PAL_DIR, f'{name}.asm')
        out = _repo_path(f'gfx/build/D50000/acMapBattleMagic{name}Palette.bin')
        if not os.path.exists(out) or os.path.getmtime(src) > os.path.getmtime(out):
            try:
                raw = _parse_palette_asm(src)
            except ValueError as e:
                sys.exit(str(e))
            with open(out, 'wb') as f:
                f.write(raw)
            n += 1

    for stem, region, label, _ in MAP_MAGIC_SPRITES:
        src = os.path.join(MAP_MAGIC_SPR_DIR, f'{stem}.4bpp.png')
        out = _repo_path(f'gfx/build/{region}/{label}.4bpp')
        if not os.path.exists(out) or os.path.getmtime(src) > os.path.getmtime(out):
            max_bytes = len(_decompress_comp(out + '.comp'))
            try:
                raw = _pack_sheet_png(src, 4, max_bytes)
            except ValueError as e:
                sys.exit(str(e))
            with open(out, 'wb') as f:
                f.write(raw)
            n += 1

    for stem, label, ext, depth, max_bytes, _ in BATTLE_SCENE_TILES:
        src = os.path.join(BATTLE_SCENE_TILES_DIR, f'{stem}.{depth}bpp.png')
        out = _repo_path(f'gfx/build/E02EBD/{label}{ext}')
        if not os.path.exists(out) or os.path.getmtime(src) > os.path.getmtime(out):
            try:
                raw = _pack_sheet_png(src, depth, max_bytes)
            except ValueError as e:
                sys.exit(str(e))
            with open(out, 'wb') as f:
                f.write(raw)
            n += 1
    return n


def clean():
    for name in MAP_MAGIC_PALETTES:
        p = _repo_path(f'gfx/build/D50000/acMapBattleMagic{name}Palette.bin')
        if os.path.exists(p):
            os.remove(p)
    for _, region, label, _ in MAP_MAGIC_SPRITES:
        p = _repo_path(f'gfx/build/{region}/{label}.4bpp')
        if os.path.exists(p):
            os.remove(p)
    for _, label, ext, _, _, _ in BATTLE_SCENE_TILES:
        p = _repo_path(f'gfx/build/E02EBD/{label}{ext}')
        if os.path.exists(p):
            os.remove(p)


def cmd_list():
    print(f'Map-battle magic palettes ({len(MAP_MAGIC_PALETTES)}):')
    for name in MAP_MAGIC_PALETTES:
        print(f'  {name:14s} -> acMapBattleMagic{name}Palette')
    print(f'\nMap-battle magic scenes ({len(MAP_MAGIC_SCENES)} manifests):')
    for name, sh, pal, tms, blank in MAP_MAGIC_SCENES:
        b = f' blank=${blank:03X}' if blank is not None else ''
        print(f'  {name:14s} sheet={sh} pal={pal} layers={len(tms)}{b}')
    print(f'\nMap-battle sprite/effect sheets ({len(MAP_MAGIC_SPRITES)}):')
    for stem, region, label, _ in MAP_MAGIC_SPRITES:
        print(f'  {stem:22s} ({region}) -> {label}')
    print(f'\nBattle scene tile sheets ({len(BATTLE_SCENE_TILES)}):')
    for stem, label, ext, depth, mb, _ in BATTLE_SCENE_TILES:
        print(f'  {stem:16s} {depth}bpp max=${mb:04X} -> {label}{ext}')
    print(f'\nBattle scene layouts ({len(BATTLE_SCENE_SCENES)} manifests):')
    for mname, depth, _, _, layers in BATTLE_SCENE_SCENES:
        print(f'  {mname:26s} {depth}bpp layers={len(layers)}')


def preview(out_dir, which='all'):
    os.makedirs(out_dir, exist_ok=True)
    made = 0
    if which in ('battle-scene', 'all'):
        bs_out = os.path.join(out_dir, 'battle_scene')
        for mname, _, _, _, _ in BATTLE_SCENE_SCENES:
            mp = os.path.join(BATTLE_SCENE_DIR, f'{mname}.scene.json')
            made += len(scene_pack.render_scene(mp, bs_out))
    if which in ('map-magic', 'all'):
        mm_out = os.path.join(out_dir, 'map_magic')
        os.makedirs(mm_out, exist_ok=True)
        for name, _, _, tms, _ in MAP_MAGIC_SCENES:
            for _, png_name in tms:
                src = os.path.join(MAP_MAGIC_DIR, png_name)
                if os.path.exists(src):
                    shutil.copy(src, os.path.join(mm_out, png_name))
                    made += 1
    return made


def engine_labels(path, table):
    """Every label named on a .long row of a table, up to the table's .endsection."""
    src = open(_repo_path(path), encoding='utf-8').read()
    a = src.index(table + ' ;')
    out = set()
    for line in src[a:src.index('.endsection', a)].split('\n'):
        t = line.split(';')[0].strip()
        if t.startswith('.long'):
            out |= {x.strip() for x in t[5:].split(',') if re.match(r'^[A-Za-z_]\w*$', x.strip())}
    return out


def check_tables_against_engine():
    """The asset lists in this file are written by hand. Check them against the
    engine's own tables, both ways, so neither can drift without a failure:
    every label listed here is in the table that loads it, and every graphics
    stream those tables load is listed here (or is a known unreachable entry)."""
    import gfx_inventory
    bg = engine_labels('engine/battle/map_battle_magic.asm', 'aMapBattleMagicBackgrounds')
    spr = engine_labels('engine/battle/map_battle_magic.asm', 'aMapBattleMagicSprites')
    vram = engine_labels('engine/battle_scene/script.asm', 'aBattleSceneDecompressToVRAMTable')
    dec = engine_labels('engine/battle_scene/script.asm', 'aBattleSceneDecompressTable')
    mine_bg = {sh for _, sh, _, _, _ in MAP_MAGIC_SCENES} | {tm for *_, tms, _ in MAP_MAGIC_SCENES for tm, _ in tms} \
        | {f'acMapBattleMagic{n}Palette' for n in MAP_MAGIC_PALETTES}
    mine_spr = {lbl for _, region, lbl, _ in MAP_MAGIC_SPRITES}
    mine_bs = {lbl for _, lbl, *_ in BATTLE_SCENE_TILES} | {l[1] for *_, layers in BATTLE_SCENE_SCENES for l in layers}
    # Streams code loads directly rather than through these tables (the second
    # Meteor and Valflame tilemaps, rlQueueMapMagicBackgroundTilemap; the map action
    # and cutscene sheets): enough that some engine code names them.
    engine_src = ''.join(open(f, encoding='utf-8').read() for f in
                         __import__('glob').glob(_repo_path('engine/**/*.asm'), recursive=True))
    named = lambda x: re.search(rf'\b{re.escape(x)}\b', engine_src) is not None
    problems = []
    for x in sorted((mine_bg - bg) | (mine_spr - spr)):
        if not named(x):
            problems.append(f'{x}: listed here, named nowhere in engine/')
    mine_bg &= bg
    mine_spr &= spr
    problems += [f'{x}: listed here, not in aMapBattleMagicBackgrounds' for x in sorted(mine_bg - bg)]
    problems += [f'{x}: in aMapBattleMagicBackgrounds, not listed here' for x in sorted(bg - mine_bg)]
    problems += [f'{x}: listed here, not in aMapBattleMagicSprites' for x in sorted(mine_spr - spr)]
    problems += [f'{x}: in aMapBattleMagicSprites, not listed here' for x in sorted(spr - mine_spr)]
    problems += [f'{x}: listed here, in neither battle scene decompress table' for x in sorted(mine_bs - vram - dec)]
    loaded = {x for x in vram | dec if x.startswith(('ac', 'g'))}
    # Only effect and window streams are this tool's (the HUD's sheets are not).
    other = {x for x in loaded - mine_bs if not x.startswith((
        'acBattleSceneEffect', 'acBattleSceneDecomp', 'g2bppcBattleSceneEffect',
        'g4bppcBattleSceneEffect', 'g4bppcBattleSceneDecomp'))}
    missing = sorted(loaded - mine_bs - other - gfx_inventory.UNREACHABLE)
    problems += [f'{x}: loaded by a battle scene decompress table, not listed here' for x in missing]
    return problems


def self_test():
    # 0. The hand-written asset lists agree with the engine's tables.
    problems = check_tables_against_engine()
    assert not problems, 'asset lists out of step with the engine tables:\n  ' + '\n  '.join(problems)
    global BATTLE_SCENE_TILES
    saved = BATTLE_SCENE_TILES
    BATTLE_SCENE_TILES = saved[1:]
    try:
        dropped = saved[0][1]
        assert any(dropped in p for p in check_tables_against_engine()), 'a dropped row went unnoticed'
    finally:
        BATTLE_SCENE_TILES = saved

    # 1. Verify all 21 map-battle magic palettes round-trip byte-identically
    for name in MAP_MAGIC_PALETTES:
        asm_path = os.path.join(MAP_MAGIC_PAL_DIR, f'{name}.asm')
        comp_path = _repo_path(f'gfx/build/D50000/acMapBattleMagic{name}Palette.bin.comp')
        got = _parse_palette_asm(asm_path)
        want = _decompress_comp(comp_path)
        assert got == want, f'{name} palette mismatch'

    # 2. Verify all 24 map-battle sprite/effect sheets + 47 battle scene sheets round-trip
    for stem, region, label, _ in MAP_MAGIC_SPRITES:
        src = os.path.join(MAP_MAGIC_SPR_DIR, f'{stem}.4bpp.png')
        comp = _repo_path(f'gfx/build/{region}/{label}.4bpp.comp')
        want = _decompress_comp(comp)
        got = _pack_sheet_png(src, 4, len(want))
        assert got == want, f'{stem} mismatch'

    for stem, label, ext, depth, max_bytes, _ in BATTLE_SCENE_TILES:
        src = os.path.join(BATTLE_SCENE_TILES_DIR, f'{stem}.{depth}bpp.png')
        comp = _repo_path(f'gfx/build/E02EBD/{label}{ext}.comp')
        want = _decompress_comp(comp)
        assert len(want) <= max_bytes, f'{stem}: .comp ({len(want)}) > max_bytes ({max_bytes})'
        got = _pack_sheet_png(src, depth, max_bytes)
        assert got == want, f'{stem} mismatch'

    tmp = tempfile.mkdtemp()
    try:
        # 3. Palette edit + LZ recompression + validation refusals
        pal_asm = os.path.join(tmp, 'Fire.asm')
        shutil.copy(os.path.join(MAP_MAGIC_PAL_DIR, 'Fire.asm'), pal_asm)
        txt = open(pal_asm, encoding='utf-8').read()
        edited = txt.replace('bgr555( 0,  0,  0)', 'bgr555( 1,  2,  3)', 1)
        open(pal_asm, 'w', encoding='utf-8').write(edited)
        raw_ed = _parse_palette_asm(pal_asm)
        comp_orig = _repo_path('gfx/build/D50000/acMapBattleMagicFirePalette.bin.comp')
        lz_ed = gfx.lz(raw_ed, comp_orig)
        buf = bytearray(0x400000); buf[:len(lz_ed)] = lz_ed
        assert decompress(bytes(buf), 0xC00000)[0] == raw_ed

        bad_chan = os.path.join(tmp, 'bad_chan.asm')
        open(bad_chan, 'w').write(txt.replace('bgr555( 0,  0,  0)', 'bgr555(32,  0,  0)', 1))
        try:
            _parse_palette_asm(bad_chan)
            raise AssertionError('out-of-range channel should fail')
        except ValueError as e:
            assert 'out of 0..31' in str(e)

        bad_cnt = os.path.join(tmp, 'bad_cnt.asm')
        open(bad_cnt, 'w').write('\n'.join(txt.splitlines()[:-1]))
        try:
            _parse_palette_asm(bad_cnt)
            raise AssertionError('wrong color count should fail')
        except ValueError as e:
            assert 'expected 256' in str(e)

        # 4. Tile sheet pixel edit + LZ recompression, 4bpp and 2bpp
        for src_rel, comp_rel, depth, max_b in [
            ('gfx/effects/map_magic/sprites/FireSprites.4bpp.png',
             'gfx/build/D50000/g4bppcMapBattleMagicFireSprites.4bpp.comp', 4, 0x0400),
            ('gfx/effects/battle_scene/tiles/BolganoneBG3.2bpp.png',
             'gfx/build/E02EBD/g2bppcBattleSceneEffectTilesF01360.2bpp.comp', 2, 0x0500),
            ('gfx/effects/battle_scene/tiles/LevelUpWindow.4bpp.png',
             'gfx/build/E02EBD/g4bppcBattleSceneDecompE03105.4bpp.comp', 4, 0x0800),
        ]:
            tp = os.path.join(tmp, os.path.basename(src_rel))
            shutil.copy(_repo_path(src_rel), tp)
            img = Image.open(tp)
            px = img.load()
            px[0, 0] = (px[0, 0] + 1) % (1 << depth)
            img.save(tp)
            raw = _pack_sheet_png(tp, depth, max_b)
            lz = gfx.lz(raw, _repo_path(comp_rel))
            buf = bytearray(0x400000); buf[:len(lz)] = lz
            assert decompress(bytes(buf), 0xC00000)[0] == raw

        # 5. Negative sheet refusals (non-indexed, over-budget)
        rgb = os.path.join(tmp, 'rgb.png')
        Image.new('RGB', (128, 16)).save(rgb)
        try:
            _pack_sheet_png(rgb, 4, 0x0400)
            raise AssertionError('RGB PNG should fail')
        except ValueError as e:
            assert 'indexed' in str(e)

        over = os.path.join(tmp, 'over.png')
        im_over = Image.new('P', (128, 32), 1)
        im_over.putpalette([0] * 768)
        im_over.save(over)
        try:
            _pack_sheet_png(over, 4, 0x0400)
            raise AssertionError('over-budget PNG should fail')
        except ValueError as e:
            assert 'budget' in str(e)

        # 6. Render sample previews
        prev_dir = os.path.join(tmp, 'previews')
        for mname in ('Fire', 'BolganoneBG1', 'BolganoneBG3', 'MjolnirBG3', 'Fenrir', 'BattleSceneLevelUpWindow'):
            mp = os.path.join(BATTLE_SCENE_DIR, f'{mname}.scene.json')
            scene_pack.render_scene(mp, prev_dir)
        assert os.path.exists(os.path.join(prev_dir, 'Fire.png'))
        assert Image.open(os.path.join(prev_dir, 'MjolnirBG3.png')).size == (256, 768)
        assert Image.open(os.path.join(prev_dir, 'FenrirBG2.png')).size == (512, 512)
        assert Image.open(os.path.join(prev_dir, 'LevelUpWindow.png')).size == (256, 160)
    finally:
        shutil.rmtree(tmp)

    print(f'{len(MAP_MAGIC_PALETTES)} palettes, {len(MAP_MAGIC_SPRITES)} map-magic sheets, '
          f'and {len(BATTLE_SCENE_TILES)} battle-scene sheets round-trip byte-identical; '
          f'edits, LZ recompression, previews, and validation checks passed')
    return 0


def main():
    if sys.argv[1:] == ['--self-test']:
        return self_test()
    ap = argparse.ArgumentParser(description=__doc__.split('\n')[0])
    sub = ap.add_subparsers(dest='cmd', required=True)
    u = sub.add_parser('unpack')
    u.add_argument('--force', action='store_true')
    sub.add_parser('build')
    sub.add_parser('clean')
    sub.add_parser('list')
    sub.add_parser('palettes')
    p = sub.add_parser('preview')
    p.add_argument('out_dir')
    g = p.add_mutually_exclusive_group()
    g.add_argument('--map-magic', action='store_true')
    g.add_argument('--battle-scene', action='store_true')
    g.add_argument('--all', action='store_true')
    args = ap.parse_args()
    if args.cmd == 'unpack':
        unpack(force=args.force)
        print('Unpacked battle effects and map-battle magic.')
    elif args.cmd == 'build':
        n = build()
        print(f'Built {n} battle-effect file(s).')
    elif args.cmd == 'clean':
        clean()
    elif args.cmd == 'palettes':
        for line in retrace_palettes():
            print(line)
    elif args.cmd == 'list':
        cmd_list()
    elif args.cmd == 'preview':
        which = 'map-magic' if args.map_magic else ('battle-scene' if args.battle_scene else 'all')
        n = preview(args.out_dir, which=which)
        print(f'Wrote {n} preview(s) to {args.out_dir}')
    return 0


if __name__ == '__main__':
    sys.exit(main())
