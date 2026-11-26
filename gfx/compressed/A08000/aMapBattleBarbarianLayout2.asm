; Map battle sprite data: the format is described in tools/map_battle_layouts.py.

aMapBattleBarbarianLayout2

  ; Block offsets by weapon type (sword, lance, axe, bow, staff or tome).
  .word $211D ; no sword block
  .word $211D ; no lance block
  .word _Axe - aMapBattleBarbarianLayout2
  .word $211D ; no bow block
  .word $211D ; no magic block

_Axe
  .word _AxeFrameTable - _Axe
  .word _AxeUnknown2 - _Axe, $211D
  .word _AxeWait - _Axe, $211D
  .word _AxeDodge - _Axe, $211D
  .word _AxeStrike - _Axe, $211D
  .word _AxeRanged - _Axe, $211D

_AxeFrame00
  .word 6 ; sprite count
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   0,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame01
  .word 7 ; sprite count
  .structSpriteEntry (   2,  -15), $00, SpriteSmall, $040, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   0,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame02
  .word 7 ; sprite count
  .structSpriteEntry (   3,  -10), $00, SpriteSmall, $042, 2, 0, true, true
  .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   4,  -15), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,    1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (  -4,   -7), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   0,    1), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    1), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame03
  .word 7 ; sprite count
  .structSpriteEntry (   1,  -19), $00, SpriteSmall, $043, 2, 0, false, false
  .structSpriteEntry (   4,  -17), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,   -1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry ( -12,  -17), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -4,   -9), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   0,   -1), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,   -1), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame04
  .word 7 ; sprite count
  .structSpriteEntry (  -2,  -17), $00, SpriteSmall, $040, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   0,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame05
  .word 6 ; sprite count
  .structSpriteEntry (   5,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -11,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry ( -11,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -3,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   1,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -7,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame06
  .word 5 ; sprite count
  .structSpriteEntry (  -1,    1), $00, SpriteSmall, $00E, 2, 0, false, false
  .structSpriteEntry (   9,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -7,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (  -7,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   1,   -8), $21, SpriteLarge, $022, 2, 0, false, false

_AxeFrame07
  .word 7 ; sprite count
  .structSpriteEntry (  -3,  -21), $00, SpriteSmall, $042, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   0,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame08
  .word 7 ; sprite count
  .structSpriteEntry (  -3,  -28), $00, SpriteSmall, $040, 2, 0, true, true
  .structSpriteEntry (   4,  -18), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,   -2), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry ( -12,  -18), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -4,  -10), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   0,   -2), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,   -2), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrameTable
  .word _AxeFrame00 - _Axe
  .word _AxeFrame01 - _Axe
  .word _AxeFrame02 - _Axe
  .word _AxeFrame03 - _Axe
  .word _AxeFrame04 - _Axe
  .word _AxeFrame05 - _Axe
  .word _AxeFrame06 - _Axe
  .word _AxeFrame07 - _Axe
  .word _AxeFrame08 - _Axe

_AxeWait
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_WAIT_ROUND
  ACTIVE_SPRITE_ROUND_SCRIPT

_AxeDodge
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_WAIT_STRIKE
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 3
  ACTIVE_SPRITE_TABLE_FRAME 3, 5
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 4
  ACTIVE_SPRITE_TABLE_FRAME 1, 6
  ACTIVE_SPRITE_WAIT_STRIKE_DONE
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 3
  ACTIVE_SPRITE_TABLE_FRAME 3, 5
  ACTIVE_SPRITE_SIDE_SCRIPT

_AxeStrike
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 1
  ACTIVE_SPRITE_TABLE_FRAME 4, 1
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 2
  ACTIVE_SPRITE_TABLE_FRAME 32, 2
  ACTIVE_SPRITE_MAP_BATTLE_STRIKE
  ACTIVE_SPRITE_TABLE_FRAME 1, 2
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 1
  ACTIVE_SPRITE_TABLE_FRAME 2, 3
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 48, 0
  ACTIVE_SPRITE_WAIT_STRIKE_TAKEN
  ACTIVE_SPRITE_TABLE_FRAME 3, 0
  ACTIVE_SPRITE_END_ROUND
  ACTIVE_SPRITE_SIDE_SCRIPT

_AxeRanged
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 1
  ACTIVE_SPRITE_TABLE_FRAME 4, 1
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 2
  ACTIVE_SPRITE_TABLE_FRAME 32, 2
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 1
  ACTIVE_SPRITE_TABLE_FRAME 3, 4
  ACTIVE_SPRITE_TABLE_FRAME 1, 7
  ACTIVE_SPRITE_MAP_BATTLE_STRIKE
  ACTIVE_SPRITE_TABLE_FRAME 1, 7
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 2, 8
  ACTIVE_SPRITE_TABLE_FRAME 48, 0
  ACTIVE_SPRITE_WAIT_STRIKE_TAKEN
  ACTIVE_SPRITE_TABLE_FRAME 3, 0
  ACTIVE_SPRITE_END_ROUND
  ACTIVE_SPRITE_SIDE_SCRIPT

  ; not reached by any offset
  ACTIVE_SPRITE_END

_AxeUnknown2
  .byte $1C, $21, $1C, $21, $AB, $20, $6B

  MAP_BATTLE_SPRITE_DATA_END $800
