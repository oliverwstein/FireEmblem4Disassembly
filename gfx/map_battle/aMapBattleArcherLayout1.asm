; Map battle sprite data: the format is described in tools/map_battle_layouts.py.

aMapBattleArcherLayout1

  ; Block offsets by weapon type (sword, lance, axe, bow, staff or tome).
  .word $81E5 ; no sword block
  .word $81E5 ; no lance block
  .word $81E5 ; no axe block
  .word _Bow - aMapBattleArcherLayout1
  .word $81E5 ; no magic block

_Bow
  .word _BowFrameTable - _Bow
  .word _BowUnknown2 - _Bow, $81E5
  .word _BowWait - _Bow, $81E5
  .word _BowDodge - _Bow, $81E5
  .word _BowStrike - _Bow, $81E5

_BowFrame00
  .word 9 ; sprite count
  .structSpriteEntry ( -10,   -9), $00, SpriteSmall, $043, 2, 0, true, false
  .structSpriteEntry ( -11,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -3,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (  -7,  -11), $00, SpriteSmall, $041, 2, 0, false, true
  .structSpriteEntry (  -7,   -3), $00, SpriteSmall, $040, 2, 0, false, true
  .structSpriteEntry ( -11,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   5,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (   1,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -7,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_BowFrame01
  .word 9 ; sprite count
  .structSpriteEntry (  -9,   -8), $00, SpriteSmall, $043, 2, 0, true, false
  .structSpriteEntry (  -3,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -11,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -7,  -11), $00, SpriteSmall, $041, 2, 0, false, true
  .structSpriteEntry (  -7,   -3), $00, SpriteSmall, $040, 2, 0, false, true
  .structSpriteEntry (   5,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -11,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   1,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -7,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_BowFrame02
  .word 9 ; sprite count
  .structSpriteEntry (  -8,   -8), $00, SpriteSmall, $043, 2, 0, true, false
  .structSpriteEntry ( -11,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry ( -11,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   5,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -3,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (  -7,  -12), $00, SpriteSmall, $041, 2, 0, false, true
  .structSpriteEntry (  -7,   -4), $00, SpriteSmall, $040, 2, 0, false, true
  .structSpriteEntry (   1,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -7,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_BowFrame03
  .word 9 ; sprite count
  .structSpriteEntry ( -10,  -10), $00, SpriteSmall, $043, 2, 0, true, false
  .structSpriteEntry ( -10,  -15), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry ( -10,    1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   6,  -15), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -2,   -7), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (  -6,  -12), $00, SpriteSmall, $041, 2, 0, false, true
  .structSpriteEntry (  -6,   -4), $00, SpriteSmall, $040, 2, 0, false, true
  .structSpriteEntry (   2,    1), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -6,    1), $00, SpriteSmall, $01E, 2, 0, false, false

_BowFrame04
  .word 8 ; sprite count
  .structSpriteEntry ( -10,  -15), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry ( -10,    1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   6,  -15), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -2,   -7), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (  -6,  -12), $00, SpriteSmall, $041, 2, 0, false, true
  .structSpriteEntry (  -6,   -4), $00, SpriteSmall, $040, 2, 0, false, true
  .structSpriteEntry (   2,    1), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -6,    1), $00, SpriteSmall, $01E, 2, 0, false, false

_BowFrame05
  .word 9 ; sprite count
  .structSpriteEntry (  -9,  -16), $00, SpriteSmall, $043, 2, 0, true, false
  .structSpriteEntry ( -11,   -5), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   5,  -21), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -3,  -13), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -11,  -21), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -6,  -18), $00, SpriteSmall, $041, 2, 0, false, true
  .structSpriteEntry (  -6,  -10), $00, SpriteSmall, $040, 2, 0, false, true
  .structSpriteEntry (  -2,    0), $00, SpriteSmall, $00E, 2, 0, false, false
  .structSpriteEntry (  -3,  -15), $00, SpriteSmall, $052, 2, 0, false, true

_BowFrame06
  .word 9 ; sprite count
  .structSpriteEntry (  -9,  -19), $00, SpriteSmall, $043, 2, 0, true, false
  .structSpriteEntry ( -11,   -8), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   5,  -24), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -11,  -24), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -3,  -16), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (  -6,  -21), $00, SpriteSmall, $041, 2, 0, false, true
  .structSpriteEntry (  -6,  -13), $00, SpriteSmall, $040, 2, 0, false, true
  .structSpriteEntry (  -2,    0), $00, SpriteSmall, $00E, 2, 0, false, false
  .structSpriteEntry (  -2,  -15), $00, SpriteSmall, $052, 2, 0, false, true

_BowFrame07
  .word 9 ; sprite count
  .structSpriteEntry ( -15,  -15), $00, SpriteSmall, $043, 2, 0, true, false
  .structSpriteEntry ( -10,  -15), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry ( -10,    1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   6,  -15), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -2,   -7), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (  -6,  -12), $00, SpriteSmall, $041, 2, 0, false, true
  .structSpriteEntry (  -6,   -4), $00, SpriteSmall, $040, 2, 0, false, true
  .structSpriteEntry (   2,    1), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -6,    1), $00, SpriteSmall, $01E, 2, 0, false, false

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

_BowStrike
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
  .byte $E4, $81, $E4, $81, $9F, $81, $6B

  MAP_BATTLE_SPRITE_DATA_END $800
