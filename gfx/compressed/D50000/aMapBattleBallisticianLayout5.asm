; Map battle sprite data: the format is described in tools/map_battle_layouts.py.

aMapBattleBallisticianLayout5

  ; Block offsets by weapon type (sword, lance, axe, bow, staff or tome).
  .word $20CE ; no sword block
  .word $20CE ; no lance block
  .word $20CE ; no axe block
  .word _Bow - aMapBattleBallisticianLayout5
  .word $20CE ; no magic block

_Bow
  .word _BowFrameTable - _Bow
  .word _BowUnknown2 - _Bow, $20CE
  .word _BowWait - _Bow, $20CE
  .word _BowDodge - _Bow, $20CE
  .word _BowStrike - _Bow, _BowStrikeAux - _Bow

_BowFrame00
  .word 4 ; sprite count
  .structSpriteEntry (   0,    0), $21, SpriteLarge, $026, 2, 0, false, false
  .structSpriteEntry ( -16,    0), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry (   0,  -16), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -16,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_BowFrame01
  .word 5 ; sprite count
  .structSpriteEntry (   0,   -9), $00, SpriteSmall, $049, 2, 0, true, false
  .structSpriteEntry (   0,    0), $21, SpriteLarge, $026, 2, 0, false, false
  .structSpriteEntry ( -16,    0), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry (   0,  -16), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -16,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_BowFrame02
  .word 5 ; sprite count
  .structSpriteEntry (  -1,   -8), $00, SpriteSmall, $049, 2, 0, true, false
  .structSpriteEntry (   0,    0), $21, SpriteLarge, $026, 2, 0, false, false
  .structSpriteEntry ( -16,    0), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry (   0,  -16), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -16,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_BowFrame03
  .word 6 ; sprite count
  .structSpriteEntry (   3,  -20), $00, SpriteSmall, $047, 2, 0, false, false
  .structSpriteEntry (   3,  -12), $00, SpriteSmall, $057, 2, 0, false, false
  .structSpriteEntry (   0,    0), $21, SpriteLarge, $026, 2, 0, false, false
  .structSpriteEntry ( -16,    0), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry (   0,  -16), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -16,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_BowFrame04
  .word 4 ; sprite count
  .structSpriteEntry (   0,    0), $21, SpriteLarge, $026, 2, 0, false, false
  .structSpriteEntry ( -16,    0), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry (   0,  -16), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -16,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_BowFrame05
  .word 2 ; sprite count
  .structSpriteEntry (   0,   -8), $00, SpriteSmall, $037, 2, 0, false, false
  .structSpriteEntry (   0,  -16), $00, SpriteSmall, $027, 2, 0, false, false

_BowFrame06
  .word 2 ; sprite count
  .structSpriteEntry (  -2,   -7), $00, SpriteSmall, $034, 2, 0, true, false
  .structSpriteEntry (   4,  -11), $00, SpriteSmall, $024, 2, 0, true, false

_BowFrame07
  .word 2 ; sprite count
  .structSpriteEntry (  -1,   -5), $00, SpriteSmall, $036, 2, 0, true, false
  .structSpriteEntry (   5,   -8), $00, SpriteSmall, $026, 2, 0, true, false

_BowFrame08
  .word 2 ; sprite count
  .structSpriteEntry (   0,   -5), $00, SpriteSmall, $035, 2, 0, true, false
  .structSpriteEntry (   5,   -5), $00, SpriteSmall, $025, 2, 0, true, false

_BowFrame09
  .word 2 ; sprite count
  .structSpriteEntry (  -1,   -5), $00, SpriteSmall, $036, 2, 0, true, true
  .structSpriteEntry (   5,   -2), $00, SpriteSmall, $026, 2, 0, true, true

_BowFrame0A
  .word 2 ; sprite count
  .structSpriteEntry (  -3,   -3), $00, SpriteSmall, $038, 2, 0, false, true
  .structSpriteEntry (   1,    5), $00, SpriteSmall, $028, 2, 0, false, true

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

_BowStrike
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

_BowStrikeAux
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
  .byte $CD, $20, $CD, $20, $6C, $20, $6B

  MAP_BATTLE_SPRITE_DATA_END $800
