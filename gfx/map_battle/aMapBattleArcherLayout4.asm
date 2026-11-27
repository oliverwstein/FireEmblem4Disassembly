; Map battle sprite data: the format is described in tools/map_battle_layouts.py.

aMapBattleArcherLayout4

  ; Block offsets by weapon type (sword, lance, axe, bow, staff or tome).
  .word $81E4 ; no sword block
  .word $81E4 ; no lance block
  .word $81E4 ; no axe block
  .word _Bow - aMapBattleArcherLayout4
  .word $81E4 ; no magic block

_Bow
  .word _BowFrameTable - _Bow
  .word _BowUnknown2 - _Bow, $81E4
  .word _BowWait - _Bow, $81E4
  .word _BowDodge - _Bow, $81E4
  .word $81E4, $81E4
  .word _BowRanged - _Bow, $81E4

_BowFrame00
  .word 9 ; sprite count
  .structSpriteEntry (  -5,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -13,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry ( -13,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   3,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (   1,   -5), $00, SpriteSmall, $050, 2, 0, true, true
  .structSpriteEntry (   1,  -13), $00, SpriteSmall, $050, 2, 0, true, false
  .structSpriteEntry (   1,   -9), $00, SpriteSmall, $042, 2, 0, true, false
  .structSpriteEntry (  -1,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -9,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_BowFrame01
  .word 9 ; sprite count
  .structSpriteEntry (  -5,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   1,   -5), $00, SpriteSmall, $050, 2, 0, true, true
  .structSpriteEntry (   1,  -13), $00, SpriteSmall, $050, 2, 0, true, false
  .structSpriteEntry (   0,   -9), $00, SpriteSmall, $042, 2, 0, true, false
  .structSpriteEntry ( -13,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   3,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -13,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (  -1,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -9,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_BowFrame02
  .word 8 ; sprite count
  .structSpriteEntry ( -13,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry ( -13,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   3,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -5,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   1,   -5), $00, SpriteSmall, $050, 2, 0, true, true
  .structSpriteEntry (   1,  -13), $00, SpriteSmall, $050, 2, 0, true, false
  .structSpriteEntry (  -1,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -9,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_BowFrame03
  .word 9 ; sprite count
  .structSpriteEntry (   5,   -8), $00, SpriteSmall, $042, 2, 0, true, false
  .structSpriteEntry ( -14,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry ( -14,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   2,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -6,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   0,   -6), $00, SpriteSmall, $050, 2, 0, true, true
  .structSpriteEntry (   0,  -14), $00, SpriteSmall, $050, 2, 0, true, false
  .structSpriteEntry (  -2,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry ( -10,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_BowFrame04
  .word 8 ; sprite count
  .structSpriteEntry ( -14,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry ( -14,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   2,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -6,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   0,   -6), $00, SpriteSmall, $050, 2, 0, true, true
  .structSpriteEntry (   0,  -14), $00, SpriteSmall, $050, 2, 0, true, false
  .structSpriteEntry (  -2,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry ( -10,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_BowFrame05
  .word 9 ; sprite count
  .structSpriteEntry ( -13,   -5), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   3,  -21), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -5,  -13), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -13,  -21), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   1,  -12), $00, SpriteSmall, $050, 2, 0, true, true
  .structSpriteEntry (   1,  -20), $00, SpriteSmall, $050, 2, 0, true, false
  .structSpriteEntry (   1,  -16), $00, SpriteSmall, $042, 2, 0, true, false
  .structSpriteEntry (  -4,    0), $00, SpriteSmall, $00E, 2, 0, false, false
  .structSpriteEntry (  -5,  -15), $00, SpriteSmall, $052, 2, 0, false, true

_BowFrame06
  .word 9 ; sprite count
  .structSpriteEntry ( -13,   -8), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   3,  -24), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -13,  -24), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -5,  -16), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   1,  -15), $00, SpriteSmall, $050, 2, 0, true, true
  .structSpriteEntry (   1,  -23), $00, SpriteSmall, $050, 2, 0, true, false
  .structSpriteEntry (   1,  -19), $00, SpriteSmall, $042, 2, 0, true, false
  .structSpriteEntry (  -4,    0), $00, SpriteSmall, $00E, 2, 0, false, false
  .structSpriteEntry (  -4,  -15), $00, SpriteSmall, $052, 2, 0, false, true

_BowFrame07
  .word 9 ; sprite count
  .structSpriteEntry (  15,   -8), $00, SpriteSmall, $042, 2, 0, true, false
  .structSpriteEntry ( -14,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry ( -14,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   2,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -6,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   0,   -6), $00, SpriteSmall, $050, 2, 0, true, true
  .structSpriteEntry (   0,  -14), $00, SpriteSmall, $050, 2, 0, true, false
  .structSpriteEntry (  -2,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry ( -10,    0), $00, SpriteSmall, $01E, 2, 0, false, false

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
  .byte $E3, $81, $E3, $81, $9E, $81, $6B

  MAP_BATTLE_SPRITE_DATA_END $800
