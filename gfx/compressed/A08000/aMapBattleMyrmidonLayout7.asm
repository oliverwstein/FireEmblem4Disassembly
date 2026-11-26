; Map battle sprite data: the format is described in tools/map_battle_layouts.py.

aMapBattleMyrmidonLayout7

  ; Block offsets by weapon type (sword, lance, axe, bow, staff or tome).
  .word _Sword - aMapBattleMyrmidonLayout7
  .word $205F ; no lance block
  .word $205F ; no axe block
  .word $205F ; no bow block
  .word _Magic - aMapBattleMyrmidonLayout7

_Sword
  .word _SwordFrameTable - _Sword
  .word _SwordUnknown2 - _Sword, $205F
  .word _SwordWait - _Sword, $205F
  .word _SwordDodge - _Sword, $205F
  .word _SwordStrike - _Sword, $205F

_SwordFrame00
  .word 7 ; sprite count
  .structSpriteEntry (   6,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -2,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -10,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry ( -10,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $040, 2, 0, true, false
  .structSpriteEntry (   2,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -6,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_SwordFrame01
  .word 8 ; sprite count
  .structSpriteEntry ( -10,  -10), $00, SpriteSmall, $040, 2, 0, true, false
  .structSpriteEntry (  -6,   -8), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry (   6,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -10,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry ( -10,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -2,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   2,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -6,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_SwordFrame02
  .word 8 ; sprite count
  .structSpriteEntry (  -6,  -11), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry (   6,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -10,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry ( -10,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -2,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (  -4,  -14), $00, SpriteSmall, $040, 2, 0, false, false
  .structSpriteEntry (   2,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -6,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_SwordFrame03
  .word 7 ; sprite count
  .structSpriteEntry (  -9,   -9), $00, SpriteSmall, $040, 2, 0, true, true
  .structSpriteEntry ( -10,   -5), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   6,  -21), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -2,  -13), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -10,  -21), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -1,    0), $00, SpriteSmall, $00E, 2, 0, false, false
  .structSpriteEntry (  -2,  -15), $00, SpriteSmall, $052, 2, 0, false, true

_SwordFrame04
  .word 7 ; sprite count
  .structSpriteEntry (  -9,  -12), $00, SpriteSmall, $040, 2, 0, true, true
  .structSpriteEntry (  -1,    0), $00, SpriteSmall, $00E, 2, 0, false, false
  .structSpriteEntry (  -2,  -15), $00, SpriteSmall, $052, 2, 0, false, true
  .structSpriteEntry ( -10,   -8), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   6,  -24), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -10,  -24), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -2,  -16), $21, SpriteLarge, $022, 2, 0, false, false

_SwordFrameTable
  .word _SwordFrame00 - _Sword
  .word _SwordFrame01 - _Sword
  .word _SwordFrame02 - _Sword
  .word _SwordFrame03 - _Sword
  .word _SwordFrame04 - _Sword

_SwordWait
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_WAIT_ROUND
  ACTIVE_SPRITE_ROUND_SCRIPT

_SwordDodge
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_WAIT_STRIKE
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 3
  ACTIVE_SPRITE_TABLE_FRAME 3, 3
  ACTIVE_SPRITE_TABLE_FRAME 1, 4
  ACTIVE_SPRITE_WAIT_STRIKE_DONE
  ACTIVE_SPRITE_TABLE_FRAME 3, 3
  ACTIVE_SPRITE_SIDE_SCRIPT

_SwordStrike
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 1
  ACTIVE_SPRITE_TABLE_FRAME 4, 1
  ACTIVE_SPRITE_START_MAP_MAGIC
  ACTIVE_SPRITE_TABLE_FRAME 1, 2
  ACTIVE_SPRITE_WAIT_MAP_MAGIC
  ACTIVE_SPRITE_TABLE_FRAME 4, 1
  ACTIVE_SPRITE_END_ROUND
  ACTIVE_SPRITE_SIDE_SCRIPT

  ; not reached by any offset
  ACTIVE_SPRITE_END

_SwordUnknown2
  .byte $5E, $20, $5E, $20, $29, $20, $6B

_Magic
  .word _MagicFrameTable - _Magic
  .word _MagicUnknown2 - _Magic, $205F
  .word _MagicWait - _Magic, $205F
  .word _MagicDodge - _Magic, $205F
  .word _MagicStrike - _Magic, $205F

_MagicFrame00
  .word 4 ; sprite count
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_MagicFrame01
  .word 4 ; sprite count
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_MagicFrame02
  .word 4 ; sprite count
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_MagicFrame03
  .word 4 ; sprite count
  .structSpriteEntry (  -3,   -9), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -11,   -1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   5,  -17), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -11,  -17), $21, SpriteLarge, $020, 2, 0, false, false

_MagicFrame04
  .word 4 ; sprite count
  .structSpriteEntry (  -1,  -11), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (  -9,   -3), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   7,  -19), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -9,  -19), $21, SpriteLarge, $020, 2, 0, false, false

_MagicFrameTable
  .word _MagicFrame00 - _Magic
  .word _MagicFrame01 - _Magic
  .word _MagicFrame02 - _Magic
  .word _MagicFrame03 - _Magic
  .word _MagicFrame04 - _Magic

_MagicWait
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 3
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_WAIT_ROUND
  ACTIVE_SPRITE_ROUND_SCRIPT

_MagicDodge
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 3
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_WAIT_STRIKE
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 6
  ACTIVE_SPRITE_TABLE_FRAME 3, 3
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 7
  ACTIVE_SPRITE_TABLE_FRAME 1, 4
  ACTIVE_SPRITE_WAIT_STRIKE_DONE
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 6
  ACTIVE_SPRITE_TABLE_FRAME 3, 3
  ACTIVE_SPRITE_SIDE_SCRIPT

_MagicStrike
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 3
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 4
  ACTIVE_SPRITE_TABLE_FRAME 3, 1
  ACTIVE_SPRITE_START_MAP_MAGIC
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 5
  ACTIVE_SPRITE_TABLE_FRAME 1, 2
  ACTIVE_SPRITE_WAIT_MAP_MAGIC
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 4
  ACTIVE_SPRITE_TABLE_FRAME 3, 1
  ACTIVE_SPRITE_END_ROUND
  ACTIVE_SPRITE_SIDE_SCRIPT

  ; not reached by any offset
  ACTIVE_SPRITE_END

_MagicUnknown2
  .byte $26, $21, $26, $21, $E9, $20, $6B

  MAP_BATTLE_SPRITE_DATA_END $800
