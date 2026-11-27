; Map battle sprite data: the format is described in tools/map_battle_layouts.py.

aMapBattleBallisticianLayout4

  ; Block offsets by weapon type (sword, lance, axe, bow, staff or tome).
  .word $20D7 ; no sword block
  .word $20D7 ; no lance block
  .word $20D7 ; no axe block
  .word _Bow - aMapBattleBallisticianLayout4
  .word $20D7 ; no magic block

_Bow
  .word _BowFrameTable - _Bow
  .word _BowUnknown2 - _Bow, $20D7
  .word _BowWait - _Bow, $20D7
  .word _BowDodge - _Bow, $20D7
  .word $20D7, $20D7
  .word _BowRanged - _Bow, _BowRangedAux - _Bow

_BowFrame00
  .word 4 ; sprite count
  .structSpriteEntry (   0,    0), $21, SpriteLarge, $026, 2, 0, false, false
  .structSpriteEntry ( -16,    0), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry (   0,  -16), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -16,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_BowFrame01
  .word 6 ; sprite count
  .structSpriteEntry ( -16,    0), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry ( -16,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   0,    0), $21, SpriteLarge, $026, 2, 0, false, false
  .structSpriteEntry (   0,  -16), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (  -3,   -5), $00, SpriteSmall, $054, 2, 0, true, false
  .structSpriteEntry (   5,  -11), $00, SpriteSmall, $044, 2, 0, true, false

_BowFrame02
  .word 5 ; sprite count
  .structSpriteEntry (   0,    0), $21, SpriteLarge, $026, 2, 0, false, false
  .structSpriteEntry ( -16,    0), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry (   0,  -16), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -16,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   4,  -10), $00, SpriteSmall, $044, 2, 0, true, false

_BowFrame03
  .word 6 ; sprite count
  .structSpriteEntry (   0,    0), $21, SpriteLarge, $026, 2, 0, false, false
  .structSpriteEntry ( -16,    0), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry ( -16,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   0,  -16), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   2,  -10), $00, SpriteSmall, $054, 2, 0, true, false
  .structSpriteEntry (  10,  -16), $00, SpriteSmall, $044, 2, 0, true, false

_BowFrame04
  .word 4 ; sprite count
  .structSpriteEntry (   0,    0), $21, SpriteLarge, $026, 2, 0, false, false
  .structSpriteEntry ( -16,    0), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry (   0,  -16), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -16,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_BowFrame05
  .word 2 ; sprite count
  .structSpriteEntry (  -8,   -1), $00, SpriteSmall, $034, 2, 0, true, false
  .structSpriteEntry (   0,   -7), $00, SpriteSmall, $024, 2, 0, true, false

_BowFrame06
  .word 2 ; sprite count
  .structSpriteEntry (  -8,   -3), $00, SpriteSmall, $036, 2, 0, true, false
  .structSpriteEntry (   0,   -6), $00, SpriteSmall, $026, 2, 0, true, false

_BowFrame07
  .word 2 ; sprite count
  .structSpriteEntry (  -8,   -4), $00, SpriteSmall, $035, 2, 0, true, false
  .structSpriteEntry (   0,   -4), $00, SpriteSmall, $025, 2, 0, true, false

_BowFrame08
  .word 2 ; sprite count
  .structSpriteEntry (  -8,   -5), $00, SpriteSmall, $035, 2, 0, true, true
  .structSpriteEntry (   0,   -5), $00, SpriteSmall, $025, 2, 0, true, true

_BowFrame09
  .word 2 ; sprite count
  .structSpriteEntry (  -8,   -5), $00, SpriteSmall, $036, 2, 0, true, true
  .structSpriteEntry (   0,   -2), $00, SpriteSmall, $026, 2, 0, true, true

_BowFrame0A
  .word 2 ; sprite count
  .structSpriteEntry (  -8,   -7), $00, SpriteSmall, $034, 2, 0, true, true
  .structSpriteEntry (   0,   -1), $00, SpriteSmall, $024, 2, 0, true, true

_BowFrame0B
  .word 4 ; sprite count
  .structSpriteEntry (   0,    0), $21, SpriteLarge, $026, 2, 0, false, false
  .structSpriteEntry ( -16,    0), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry (   0,  -16), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -16,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_BowFrame0C
  .word 4 ; sprite count
  .structSpriteEntry (   0,    0), $21, SpriteLarge, $026, 2, 0, false, false
  .structSpriteEntry ( -16,    0), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry (   0,  -16), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -16,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_BowFrameTable
  .word _BowFrame00 - _Bow
  .word _BowFrame01 - _Bow
  .word _BowFrame02 - _Bow
  .word _BowFrame03 - _Bow
  .word _BowFrame04 - _Bow
  .word _BowFrame05 - _Bow
  .word _BowFrame06 - _Bow
  .word _BowFrame07 - _Bow
  .word _BowFrame08 - _Bow
  .word _BowFrame09 - _Bow
  .word _BowFrame0A - _Bow
  .word _BowFrame0B - _Bow
  .word _BowFrame0C - _Bow

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
  ACTIVE_SPRITE_TABLE_FRAME 3, 11
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 4
  ACTIVE_SPRITE_TABLE_FRAME 1, 12
  ACTIVE_SPRITE_WAIT_STRIKE_DONE
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 3
  ACTIVE_SPRITE_TABLE_FRAME 3, 11
  ACTIVE_SPRITE_SIDE_SCRIPT

_BowRanged
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 1
  ACTIVE_SPRITE_TABLE_FRAME 2, 1
  ACTIVE_SPRITE_SOUND $0A
  ACTIVE_SPRITE_TABLE_FRAME 32, 2
  ACTIVE_SPRITE_TABLE_FRAME 1, 2
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 2
  ACTIVE_SPRITE_TABLE_FRAME 2, 3
  ACTIVE_SPRITE_FIRE_BOLT
  ACTIVE_SPRITE_TABLE_FRAME 1, 4
  ACTIVE_SPRITE_WAIT_BOLT_DONE
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 3, 0
  ACTIVE_SPRITE_END_ROUND
  ACTIVE_SPRITE_SIDE_SCRIPT

_BowRangedAux
  ACTIVE_SPRITE_TABLE_FRAME 1, 5
  ACTIVE_SPRITE_WAIT_BOLT_SIGNAL
  ACTIVE_SPRITE_TABLE_FRAME 1, 6
  ACTIVE_SPRITE_WAIT_BOLT_SIGNAL
  ACTIVE_SPRITE_TABLE_FRAME 1, 7
  ACTIVE_SPRITE_WAIT_BOLT_SIGNAL
  ACTIVE_SPRITE_TABLE_FRAME 1, 8
  ACTIVE_SPRITE_WAIT_BOLT_SIGNAL
  ACTIVE_SPRITE_TABLE_FRAME 1, 9
  ACTIVE_SPRITE_WAIT_BOLT_SIGNAL
  ACTIVE_SPRITE_MAP_BATTLE_STRIKE
  ACTIVE_SPRITE_TABLE_FRAME 1, 10
  ACTIVE_SPRITE_WAIT_BOLT_SIGNAL
  ACTIVE_SPRITE_END

_BowUnknown2
  .byte $D6, $20, $D6, $20, $75, $20, $6B

  MAP_BATTLE_SPRITE_DATA_END $800
