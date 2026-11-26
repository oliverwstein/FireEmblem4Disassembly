; Map battle sprite data: the format is described in tools/map_battle_layouts.py.

aMapBattleArcherLayout6

  ; Block offsets by weapon type (sword, lance, axe, bow, staff or tome).
  .word $81E9 ; no sword block
  .word $81E9 ; no lance block
  .word $81E9 ; no axe block
  .word _Bow - aMapBattleArcherLayout6
  .word $81E9 ; no magic block

_Bow
  .word _BowFrameTable - _Bow
  .word _BowUnknown2 - _Bow, $81E9
  .word _BowWait - _Bow, $81E9
  .word _BowDodge - _Bow, $81E9
  .word $81E9, $81E9
  .word _BowRanged - _Bow, $81E9

_BowFrame00
  .word 9 ; sprite count
  .structSpriteEntry (   0,    0), $00, SpriteSmall, $053, 2, 0, false, true
  .structSpriteEntry (  -2,    3), $00, SpriteSmall, $052, 2, 0, false, false
  .structSpriteEntry (  -2,   -5), $00, SpriteSmall, $051, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (   0,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_BowFrame01
  .word 9 ; sprite count
  .structSpriteEntry (   0,   -1), $00, SpriteSmall, $053, 2, 0, false, true
  .structSpriteEntry (  -2,    3), $00, SpriteSmall, $052, 2, 0, false, false
  .structSpriteEntry (  -2,   -5), $00, SpriteSmall, $051, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   0,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_BowFrame02
  .word 9 ; sprite count
  .structSpriteEntry (   0,   -2), $00, SpriteSmall, $053, 2, 0, false, true
  .structSpriteEntry (  -2,    4), $00, SpriteSmall, $052, 2, 0, false, false
  .structSpriteEntry (  -2,   -4), $00, SpriteSmall, $051, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   0,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_BowFrame03
  .word 9 ; sprite count
  .structSpriteEntry (  -1,    4), $00, SpriteSmall, $053, 2, 0, false, true
  .structSpriteEntry (  -2,    1), $00, SpriteSmall, $052, 2, 0, false, false
  .structSpriteEntry (  -2,   -7), $00, SpriteSmall, $051, 2, 0, false, false
  .structSpriteEntry ( -12,  -17), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry ( -12,   -1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -17), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -9), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   0,   -1), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,   -1), $00, SpriteSmall, $01E, 2, 0, false, false

_BowFrame04
  .word 8 ; sprite count
  .structSpriteEntry (  -2,    1), $00, SpriteSmall, $052, 2, 0, false, false
  .structSpriteEntry (  -2,   -7), $00, SpriteSmall, $051, 2, 0, false, false
  .structSpriteEntry ( -12,  -17), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry ( -12,   -1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -17), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -9), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   0,   -1), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,   -1), $00, SpriteSmall, $01E, 2, 0, false, false

_BowFrame05
  .word 9 ; sprite count
  .structSpriteEntry (   0,   -7), $00, SpriteSmall, $053, 2, 0, false, true
  .structSpriteEntry (  -2,   -4), $00, SpriteSmall, $052, 2, 0, false, false
  .structSpriteEntry (  -2,  -12), $00, SpriteSmall, $051, 2, 0, false, false
  .structSpriteEntry (  -3,    0), $00, SpriteSmall, $00E, 2, 0, false, false
  .structSpriteEntry (  -4,  -15), $00, SpriteSmall, $052, 2, 0, false, true
  .structSpriteEntry ( -12,   -5), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -21), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,  -13), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -21), $21, SpriteLarge, $020, 2, 0, false, false

_BowFrame06
  .word 9 ; sprite count
  .structSpriteEntry (   0,  -10), $00, SpriteSmall, $053, 2, 0, false, true
  .structSpriteEntry (  -2,   -7), $00, SpriteSmall, $052, 2, 0, false, false
  .structSpriteEntry (  -2,  -15), $00, SpriteSmall, $051, 2, 0, false, false
  .structSpriteEntry (  -3,    0), $00, SpriteSmall, $00E, 2, 0, false, false
  .structSpriteEntry (  -3,  -15), $00, SpriteSmall, $052, 2, 0, false, true
  .structSpriteEntry ( -12,   -8), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -24), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,  -24), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -4,  -16), $21, SpriteLarge, $022, 2, 0, false, false

_BowFrame07
  .word 9 ; sprite count
  .structSpriteEntry (  -1,   15), $00, SpriteSmall, $053, 2, 0, false, true
  .structSpriteEntry (  -2,    1), $00, SpriteSmall, $052, 2, 0, false, false
  .structSpriteEntry (  -2,   -7), $00, SpriteSmall, $051, 2, 0, false, false
  .structSpriteEntry ( -12,  -17), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry ( -12,   -1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -17), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -9), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   0,   -1), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,   -1), $00, SpriteSmall, $01E, 2, 0, false, false

_BowFrameTable
  .word _BowFrame00 - _Bow
  .word _BowFrame01 - _Bow
  .word _BowFrame02 - _Bow
  .word _BowFrame03 - _Bow
  .word _BowFrame04 - _Bow
  .word _BowFrame05 - _Bow
  .word _BowFrame06 - _Bow
  .word _BowFrame07 - _Bow

_BowWait
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_WAIT_ROUND
  ACTIVE_SPRITE_ROUND_SCRIPT

_BowDodge
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_WAIT_STRIKE
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 3
  ACTIVE_SPRITE_TABLE_FRAME 3, 5
  ACTIVE_SPRITE_TABLE_FRAME 1, 6
  ACTIVE_SPRITE_WAIT_STRIKE_DONE
  ACTIVE_SPRITE_TABLE_FRAME 3, 5
  ACTIVE_SPRITE_SIDE_SCRIPT

_BowRanged
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 1
  ACTIVE_SPRITE_TABLE_FRAME 4, 1
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 2
  ACTIVE_SPRITE_TABLE_FRAME 32, 2
  ACTIVE_SPRITE_MAP_BATTLE_STRIKE
  ACTIVE_SPRITE_TABLE_FRAME 1, 2
  ACTIVE_SPRITE_TABLE_FRAME 1, 3
  ACTIVE_SPRITE_TABLE_FRAME 1, 7
  ACTIVE_SPRITE_TABLE_FRAME 48, 4
  ACTIVE_SPRITE_WAIT_STRIKE_TAKEN
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 3, 0
  ACTIVE_SPRITE_END_ROUND
  ACTIVE_SPRITE_SIDE_SCRIPT

  ; not reached by any offset
  ACTIVE_SPRITE_END

_BowUnknown2
  .byte $E8, $81, $E8, $81, $A3, $81, $6B

  MAP_BATTLE_SPRITE_DATA_END $800
