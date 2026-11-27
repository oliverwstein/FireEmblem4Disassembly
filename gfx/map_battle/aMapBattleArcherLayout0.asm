; Map battle sprite data: the format is described in tools/map_battle_layouts.py.

aMapBattleArcherLayout0

  ; Block offsets by weapon type (sword, lance, axe, bow, staff or tome).
  .word $2124 ; no sword block
  .word $2124 ; no lance block
  .word $2124 ; no axe block
  .word _Bow - aMapBattleArcherLayout0
  .word $2124 ; no magic block

_Bow
  .word _BowFrameTable - _Bow
  .word _BowUnknown2 - _Bow, $2124
  .word _BowWait - _Bow, $2124
  .word _BowDodge - _Bow, $2124
  .word $2124, $2124
  .word _BowRanged - _Bow, $2124

_BowFrame00
  .word 9 ; sprite count
  .structSpriteEntry (  -9,   -4), $00, SpriteSmall, $042, 2, 0, false, false
  .structSpriteEntry (  -9,    0), $00, SpriteSmall, $050, 2, 0, false, true
  .structSpriteEntry (  -9,   -8), $00, SpriteSmall, $050, 2, 0, false, false
  .structSpriteEntry (  -3,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -11,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry ( -11,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   5,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (   1,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -7,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_BowFrame01
  .word 9 ; sprite count
  .structSpriteEntry (  -7,   -4), $00, SpriteSmall, $042, 2, 0, false, false
  .structSpriteEntry (  -9,    0), $00, SpriteSmall, $050, 2, 0, false, true
  .structSpriteEntry (  -9,   -8), $00, SpriteSmall, $050, 2, 0, false, false
  .structSpriteEntry (   5,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -11,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry ( -11,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -3,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   1,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -7,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_BowFrame02
  .word 9 ; sprite count
  .structSpriteEntry (  -6,   -6), $00, SpriteSmall, $042, 2, 0, false, false
  .structSpriteEntry (  -9,   -1), $00, SpriteSmall, $050, 2, 0, false, true
  .structSpriteEntry (  -9,   -9), $00, SpriteSmall, $050, 2, 0, false, false
  .structSpriteEntry ( -11,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry ( -11,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   5,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -3,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   1,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -7,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_BowFrame03
  .word 9 ; sprite count
  .structSpriteEntry ( -12,   -6), $00, SpriteSmall, $042, 2, 0, false, false
  .structSpriteEntry (  -8,   -2), $00, SpriteSmall, $050, 2, 0, false, true
  .structSpriteEntry (  -8,  -10), $00, SpriteSmall, $050, 2, 0, false, false
  .structSpriteEntry ( -10,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry ( -10,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   6,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -2,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   2,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -6,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_BowFrame04
  .word 8 ; sprite count
  .structSpriteEntry (  -8,   -2), $00, SpriteSmall, $050, 2, 0, false, true
  .structSpriteEntry (  -8,  -10), $00, SpriteSmall, $050, 2, 0, false, false
  .structSpriteEntry ( -10,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry ( -10,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   6,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -2,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   2,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -6,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_BowFrame05
  .word 9 ; sprite count
  .structSpriteEntry ( -10,  -12), $00, SpriteSmall, $042, 2, 0, false, false
  .structSpriteEntry ( -10,   -8), $00, SpriteSmall, $050, 2, 0, false, true
  .structSpriteEntry ( -10,  -16), $00, SpriteSmall, $050, 2, 0, false, false
  .structSpriteEntry ( -10,   -5), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   6,  -21), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -2,  -13), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -10,  -21), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -2,    0), $00, SpriteSmall, $00E, 2, 0, false, false
  .structSpriteEntry (  -3,  -15), $00, SpriteSmall, $052, 2, 0, false, true

_BowFrame06
  .word 8 ; sprite count
  .structSpriteEntry ( -10,  -16), $00, SpriteSmall, $042, 2, 0, false, false
  .structSpriteEntry ( -10,  -12), $00, SpriteSmall, $050, 2, 0, false, true
  .structSpriteEntry ( -10,  -20), $00, SpriteSmall, $050, 2, 0, false, false
  .structSpriteEntry (  -2,    0), $00, SpriteSmall, $00E, 2, 0, false, false
  .structSpriteEntry ( -10,   -8), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   6,  -24), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -10,  -24), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -2,  -16), $21, SpriteLarge, $022, 2, 0, false, false

_BowFrame07
  .word 9 ; sprite count
  .structSpriteEntry ( -23,   -6), $00, SpriteSmall, $042, 2, 0, false, false
  .structSpriteEntry (  -8,   -2), $00, SpriteSmall, $050, 2, 0, false, true
  .structSpriteEntry (  -8,  -10), $00, SpriteSmall, $050, 2, 0, false, false
  .structSpriteEntry ( -10,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry ( -10,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   6,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -2,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   2,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -6,    0), $00, SpriteSmall, $01E, 2, 0, false, false

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
  .byte $23, $21, $23, $21, $DE, $20, $6B

  MAP_BATTLE_SPRITE_DATA_END $800
