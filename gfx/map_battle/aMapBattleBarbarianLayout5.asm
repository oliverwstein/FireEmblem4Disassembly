; Map battle sprite data: the format is described in tools/map_battle_layouts.py.

aMapBattleBarbarianLayout5

  ; Block offsets by weapon type (sword, lance, axe, bow, staff or tome).
  .word $2105 ; no sword block
  .word $2105 ; no lance block
  .word _Axe - aMapBattleBarbarianLayout5
  .word $2105 ; no bow block
  .word $2105 ; no magic block

_Axe
  .word _AxeFrameTable - _Axe
  .word _AxeUnknown2 - _Axe, $2105
  .word _AxeWait - _Axe, $2105
  .word _AxeDodge - _Axe, $2105
  .word _AxeStrike - _Axe, $2105

_AxeFrame00
  .word 7 ; sprite count
  .structSpriteEntry (   4,   -3), $00, SpriteSmall, $042, 2, 0, true, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   0,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame01
  .word 7 ; sprite count
  .structSpriteEntry (  -1,   -8), $00, SpriteSmall, $040, 2, 0, true, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   0,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame02
  .word 7 ; sprite count
  .structSpriteEntry ( -13,  -17), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -5,   -9), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   3,  -17), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -13,   -1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry ( -11,  -13), $00, SpriteSmall, $042, 2, 0, false, true
  .structSpriteEntry (  -1,   -1), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -9,   -1), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame03
  .word 7 ; sprite count
  .structSpriteEntry (   5,    0), $00, SpriteSmall, $042, 2, 0, true, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   0,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame04
  .word 6 ; sprite count
  .structSpriteEntry (   6,  -14), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -10,    2), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry ( -10,  -14), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -2,   -6), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   2,    2), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -6,    2), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame05
  .word 7 ; sprite count
  .structSpriteEntry (   3,   -4), $00, SpriteSmall, $042, 2, 0, true, false
  .structSpriteEntry (   3,  -15), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -13,    1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry ( -13,  -15), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -5,   -7), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (  -1,    1), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -9,    1), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame06
  .word 7 ; sprite count
  .structSpriteEntry (  -4,   -1), $00, SpriteSmall, $042, 2, 0, true, false
  .structSpriteEntry (  -3,  -13), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -19,    3), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry ( -19,  -13), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry ( -11,   -5), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (  -3,    3), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry ( -11,    3), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame07
  .word 7 ; sprite count
  .structSpriteEntry (   7,    1), $00, SpriteSmall, $040, 2, 0, false, true
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   0,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame08
  .word 7 ; sprite count
  .structSpriteEntry (  11,    6), $00, SpriteSmall, $042, 2, 0, false, true
  .structSpriteEntry (   6,  -14), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -10,    2), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry ( -10,  -14), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -2,   -6), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   2,    2), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -6,    2), $00, SpriteSmall, $01E, 2, 0, false, false

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
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 1
  ACTIVE_SPRITE_TABLE_FRAME 3, 3
  ACTIVE_SPRITE_TABLE_FRAME 1, 7
  ACTIVE_SPRITE_MAP_BATTLE_STRIKE
  ACTIVE_SPRITE_TABLE_FRAME 1, 7
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 2, 8
  ACTIVE_SPRITE_TABLE_FRAME 48, 4
  ACTIVE_SPRITE_WAIT_STRIKE_TAKEN
  ACTIVE_SPRITE_TABLE_FRAME 3, 0
  ACTIVE_SPRITE_END_ROUND
  ACTIVE_SPRITE_SIDE_SCRIPT

  ; not reached by any offset
  ACTIVE_SPRITE_END

_AxeUnknown2
  .byte $04, $21, $04, $21, $B6, $20, $6B

  MAP_BATTLE_SPRITE_DATA_END $800
