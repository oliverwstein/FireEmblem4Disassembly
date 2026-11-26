; Map battle sprite data: the format is described in tools/map_battle_layouts.py.

aMapBattleArcherLayout3

  ; Block offsets by weapon type (sword, lance, axe, bow, staff or tome).
  .word $81DB ; no sword block
  .word $81DB ; no lance block
  .word $81DB ; no axe block
  .word _Bow - aMapBattleArcherLayout3
  .word $81DB ; no magic block

_Bow
  .word _BowFrameTable - _Bow
  .word _BowUnknown2 - _Bow, $81DB
  .word _BowWait - _Bow, $81DB
  .word _BowDodge - _Bow, $81DB
  .word _BowStrike - _Bow, $81DB

_BowFrame00
  .word 9 ; sprite count
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   0,  -13), $00, SpriteSmall, $041, 2, 0, true, true
  .structSpriteEntry (   0,   -5), $00, SpriteSmall, $040, 2, 0, true, true
  .structSpriteEntry (   2,  -11), $00, SpriteSmall, $043, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   0,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_BowFrame01
  .word 8 ; sprite count
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   0,  -13), $00, SpriteSmall, $041, 2, 0, true, true
  .structSpriteEntry (   0,   -5), $00, SpriteSmall, $040, 2, 0, true, true
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   0,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_BowFrame02
  .word 8 ; sprite count
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   0,  -13), $00, SpriteSmall, $041, 2, 0, true, true
  .structSpriteEntry (   0,   -5), $00, SpriteSmall, $040, 2, 0, true, true
  .structSpriteEntry (   0,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_BowFrame03
  .word 9 ; sprite count
  .structSpriteEntry ( -13,  -15), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry ( -13,    1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   3,  -15), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -5,   -7), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   4,  -11), $00, SpriteSmall, $043, 2, 0, false, false
  .structSpriteEntry (  -1,  -13), $00, SpriteSmall, $041, 2, 0, true, true
  .structSpriteEntry (  -1,   -5), $00, SpriteSmall, $040, 2, 0, true, true
  .structSpriteEntry (  -1,    1), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -9,    1), $00, SpriteSmall, $01E, 2, 0, false, false

_BowFrame04
  .word 8 ; sprite count
  .structSpriteEntry ( -13,  -15), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry ( -13,    1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   3,  -15), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -5,   -7), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (  -1,  -13), $00, SpriteSmall, $041, 2, 0, true, true
  .structSpriteEntry (  -1,   -5), $00, SpriteSmall, $040, 2, 0, true, true
  .structSpriteEntry (  -1,    1), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -9,    1), $00, SpriteSmall, $01E, 2, 0, false, false

_BowFrame05
  .word 9 ; sprite count
  .structSpriteEntry ( -12,   -5), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -21), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,  -13), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -21), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   0,  -20), $00, SpriteSmall, $041, 2, 0, true, true
  .structSpriteEntry (   0,  -12), $00, SpriteSmall, $040, 2, 0, true, true
  .structSpriteEntry (   2,  -18), $00, SpriteSmall, $043, 2, 0, false, false
  .structSpriteEntry (  -3,    0), $00, SpriteSmall, $00E, 2, 0, false, false
  .structSpriteEntry (  -4,  -15), $00, SpriteSmall, $052, 2, 0, false, true

_BowFrame06
  .word 9 ; sprite count
  .structSpriteEntry ( -12,   -8), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -24), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,  -24), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -4,  -16), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   0,  -23), $00, SpriteSmall, $041, 2, 0, true, true
  .structSpriteEntry (   0,  -15), $00, SpriteSmall, $040, 2, 0, true, true
  .structSpriteEntry (   2,  -21), $00, SpriteSmall, $043, 2, 0, false, false
  .structSpriteEntry (  -3,    0), $00, SpriteSmall, $00E, 2, 0, false, false
  .structSpriteEntry (  -3,  -15), $00, SpriteSmall, $052, 2, 0, false, true

_BowFrame07
  .word 9 ; sprite count
  .structSpriteEntry ( -13,  -15), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry ( -13,    1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   3,  -15), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -5,   -7), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   8,  -15), $00, SpriteSmall, $043, 2, 0, false, false
  .structSpriteEntry (  -1,  -13), $00, SpriteSmall, $041, 2, 0, true, true
  .structSpriteEntry (  -1,   -5), $00, SpriteSmall, $040, 2, 0, true, true
  .structSpriteEntry (  -1,    1), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -9,    1), $00, SpriteSmall, $01E, 2, 0, false, false

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
  .byte $DA, $81, $DA, $81, $95, $81, $6B

  MAP_BATTLE_SPRITE_DATA_END $800
