; Map battle sprite data: the format is described in tools/map_battle_layouts.py.

aMapBattleMyrmidonLayout2

  ; Block offsets by weapon type (sword, lance, axe, bow, staff or tome).
  .word _Sword - aMapBattleMyrmidonLayout2
  .word $21A8 ; no lance block
  .word $21A8 ; no axe block
  .word $21A8 ; no bow block
  .word _Magic - aMapBattleMyrmidonLayout2

_Sword
  .word _SwordFrameTable - _Sword
  .word _SwordUnknown2 - _Sword, $21A8
  .word _SwordWait - _Sword, $21A8
  .word _SwordDodge - _Sword, $21A8
  .word _SwordStrike - _Sword, $21A8
  .word _SwordRanged - _Sword, $21A8

_SwordFrame00
  .word 7 ; sprite count
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (   0,   -2), $00, SpriteSmall, $042, 2, 0, false, true
  .structSpriteEntry (   0,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_SwordFrame01
  .word 8 ; sprite count
  .structSpriteEntry (  -7,  -10), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   1,  -10), $00, SpriteSmall, $042, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   0,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_SwordFrame02
  .word 8 ; sprite count
  .structSpriteEntry (   1,  -15), $00, SpriteSmall, $043, 2, 0, false, false
  .structSpriteEntry (  -7,  -12), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   0,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    0), $00, SpriteSmall, $01E, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false

_SwordFrame03
  .word 7 ; sprite count
  .structSpriteEntry ( -12,   -5), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -21), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,  -13), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -21), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   1,   -9), $00, SpriteSmall, $042, 2, 0, false, true
  .structSpriteEntry (  -3,    0), $00, SpriteSmall, $00E, 2, 0, false, false
  .structSpriteEntry (  -4,  -15), $00, SpriteSmall, $052, 2, 0, false, true

_SwordFrame04
  .word 7 ; sprite count
  .structSpriteEntry ( -12,   -8), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -24), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,  -24), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -4,  -16), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   1,  -12), $00, SpriteSmall, $042, 2, 0, false, true
  .structSpriteEntry (  -3,    0), $00, SpriteSmall, $00E, 2, 0, false, false
  .structSpriteEntry (  -4,  -15), $00, SpriteSmall, $052, 2, 0, false, true

_SwordFrame05
  .word 7 ; sprite count
  .structSpriteEntry (   1,  -24), $00, SpriteSmall, $043, 2, 0, false, false
  .structSpriteEntry ( -12,   -8), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -24), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,  -16), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -24), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -3,    0), $00, SpriteSmall, $00E, 2, 0, false, false
  .structSpriteEntry (  -4,  -15), $00, SpriteSmall, $052, 2, 0, false, true

_SwordFrame06
  .word 7 ; sprite count
  .structSpriteEntry ( -12,   -8), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -24), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,  -16), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -24), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   1,  -19), $00, SpriteSmall, $050, 2, 0, false, false
  .structSpriteEntry (  -3,    0), $00, SpriteSmall, $00E, 2, 0, false, false
  .structSpriteEntry (  -4,  -15), $00, SpriteSmall, $052, 2, 0, false, true

_SwordFrame07
  .word 7 ; sprite count
  .structSpriteEntry (  -1,   -8), $00, SpriteSmall, $050, 2, 0, false, true
  .structSpriteEntry ( -12,   -8), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -24), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,  -24), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -4,  -16), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (  -3,    0), $00, SpriteSmall, $00E, 2, 0, false, false
  .structSpriteEntry (  -4,  -15), $00, SpriteSmall, $052, 2, 0, false, true

_SwordFrame08
  .word 7 ; sprite count
  .structSpriteEntry (  -1,   -6), $00, SpriteSmall, $050, 2, 0, false, true
  .structSpriteEntry ( -12,   -6), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -22), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,  -22), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -4,  -14), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (  -3,    0), $00, SpriteSmall, $00E, 2, 0, false, false
  .structSpriteEntry (  -4,  -15), $00, SpriteSmall, $052, 2, 0, false, true

_SwordFrame09
  .word 8 ; sprite count
  .structSpriteEntry (  -7,  -10), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   1,  -17), $00, SpriteSmall, $050, 2, 0, false, false
  .structSpriteEntry (   0,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_SwordFrame0A
  .word 7 ; sprite count
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   1,   -6), $00, SpriteSmall, $050, 2, 0, false, false
  .structSpriteEntry (   0,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_SwordFrame0B
  .word 6 ; sprite count
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   0,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_SwordFrameTable
  .word _SwordFrame00 - _Sword
  .word _SwordFrame01 - _Sword
  .word _SwordFrame02 - _Sword
  .word _SwordFrame03 - _Sword
  .word _SwordFrame04 - _Sword
  .word _SwordFrame05 - _Sword
  .word _SwordFrame06 - _Sword
  .word _SwordFrame07 - _Sword
  .word _SwordFrame08 - _Sword
  .word _SwordFrame09 - _Sword
  .word _SwordFrame0A - _Sword
  .word _SwordFrame0B - _Sword

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
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 3
  ACTIVE_SPRITE_TABLE_FRAME 4, 3
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 2
  ACTIVE_SPRITE_TABLE_FRAME 6, 5
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 4
  ACTIVE_SPRITE_TABLE_FRAME 3, 6
  ACTIVE_SPRITE_SOUND $3B
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 5
  ACTIVE_SPRITE_TABLE_FRAME 3, 7
  ACTIVE_SPRITE_TABLE_FRAME 3, 8
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 1
  ACTIVE_SPRITE_TABLE_FRAME 4, 9
  ACTIVE_SPRITE_MAP_BATTLE_STRIKE
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 6
  ACTIVE_SPRITE_TABLE_FRAME 3, 10
  ACTIVE_SPRITE_TABLE_FRAME 48, 11
  ACTIVE_SPRITE_WAIT_STRIKE_TAKEN
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 3, 0
  ACTIVE_SPRITE_END_ROUND
  ACTIVE_SPRITE_SIDE_SCRIPT

_SwordRanged
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
  .byte $A7, $21, $A7, $21, $3E, $21, $6B

_Magic
  .word _MagicFrameTable - _Magic
  .word _MagicUnknown2 - _Magic, $21A8
  .word _MagicWait - _Magic, $21A8
  .word _MagicDodge - _Magic, $21A8
  .word _MagicStrike - _Magic, $21A8
  .word _MagicStrike - _Magic, $21A8

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
  .structSpriteEntry (  -3,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -11,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   5,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -11,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_MagicFrame04
  .word 4 ; sprite count
  .structSpriteEntry (  -1,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (  -9,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   7,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -9,  -16), $21, SpriteLarge, $020, 2, 0, false, false

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
  .byte $73, $22, $73, $22, $36, $22, $6B

  MAP_BATTLE_SPRITE_DATA_END $800
