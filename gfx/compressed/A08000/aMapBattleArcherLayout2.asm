; Map battle sprite data: the format is described in tools/map_battle_layouts.py.

aMapBattleArcherLayout2

  ; Block offsets by weapon type (sword, lance, axe, bow, staff or tome).
  .word $8195 ; no sword block
  .word $8195 ; no lance block
  .word $8195 ; no axe block
  .word _Bow - aMapBattleArcherLayout2
  .word $8195 ; no magic block

_Bow
  .word _BowFrameTable - _Bow
  .word _BowUnknown2 - _Bow, $8195
  .word _BowWait - _Bow, $8195
  .word _BowDodge - _Bow, $8195
  .word $8195, $8195
  .word _BowRanged - _Bow, $8195

_BowFrame00
  .word 8 ; sprite count
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (  -5,  -12), $00, SpriteSmall, $053, 2, 0, false, false
  .structSpriteEntry (  -3,  -16), $00, SpriteSmall, $052, 2, 0, false, true
  .structSpriteEntry (   0,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_BowFrame01
  .word 8 ; sprite count
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (  -5,  -10), $00, SpriteSmall, $053, 2, 0, false, false
  .structSpriteEntry (  -3,  -16), $00, SpriteSmall, $052, 2, 0, false, true
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   0,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_BowFrame02
  .word 7 ; sprite count
  .structSpriteEntry (  -3,  -16), $00, SpriteSmall, $052, 2, 0, false, true
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   0,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_BowFrame03
  .word 8 ; sprite count
  .structSpriteEntry (  -3,  -16), $00, SpriteSmall, $052, 2, 0, false, true
  .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry ( -12,    1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -15), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -7), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   0,    1), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    1), $00, SpriteSmall, $01E, 2, 0, false, false
  .structSpriteEntry (  -4,  -18), $00, SpriteSmall, $053, 2, 0, false, false

_BowFrame04
  .word 8 ; sprite count
  .structSpriteEntry ( -12,   -5), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -21), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,  -13), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -21), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -5,  -19), $00, SpriteSmall, $053, 2, 0, false, false
  .structSpriteEntry (  -3,  -23), $00, SpriteSmall, $052, 2, 0, false, true
  .structSpriteEntry (  -3,    0), $00, SpriteSmall, $00E, 2, 0, false, false
  .structSpriteEntry (  -4,  -15), $00, SpriteSmall, $052, 2, 0, false, true

_BowFrame05
  .word 8 ; sprite count
  .structSpriteEntry ( -12,   -8), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -24), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,  -24), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -4,  -16), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (  -5,  -22), $00, SpriteSmall, $053, 2, 0, false, false
  .structSpriteEntry (  -3,  -26), $00, SpriteSmall, $052, 2, 0, false, true
  .structSpriteEntry (  -3,    0), $00, SpriteSmall, $00E, 2, 0, false, false
  .structSpriteEntry (  -3,  -15), $00, SpriteSmall, $052, 2, 0, false, true

_BowFrame06
  .word 8 ; sprite count
  .structSpriteEntry (  -4,  -23), $00, SpriteSmall, $053, 2, 0, false, false
  .structSpriteEntry (  -3,  -16), $00, SpriteSmall, $052, 2, 0, false, true
  .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry ( -12,    1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -15), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -7), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   0,    1), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    1), $00, SpriteSmall, $01E, 2, 0, false, false

_BowFrameTable
  .word _BowFrame00 - _Bow
  .word _BowFrame01 - _Bow
  .word _BowFrame02 - _Bow
  .word _BowFrame03 - _Bow
  .word _BowFrame04 - _Bow
  .word _BowFrame05 - _Bow
  .word _BowFrame06 - _Bow

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
  ACTIVE_SPRITE_TABLE_FRAME 3, 4
  ACTIVE_SPRITE_TABLE_FRAME 1, 5
  ACTIVE_SPRITE_WAIT_STRIKE_DONE
  ACTIVE_SPRITE_TABLE_FRAME 3, 4
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
  ACTIVE_SPRITE_TABLE_FRAME 1, 6
  ACTIVE_SPRITE_TABLE_FRAME 48, 2
  ACTIVE_SPRITE_WAIT_STRIKE_TAKEN
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 3, 0
  ACTIVE_SPRITE_END_ROUND
  ACTIVE_SPRITE_SIDE_SCRIPT

  ; not reached by any offset
  ACTIVE_SPRITE_END

_BowUnknown2
  .byte $94, $81, $94, $81, $4F, $81, $6B

  MAP_BATTLE_SPRITE_DATA_END $800
