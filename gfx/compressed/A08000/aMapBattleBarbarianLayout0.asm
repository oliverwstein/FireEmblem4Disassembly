; Map battle sprite data: the format is described in tools/map_battle_layouts.py.

aMapBattleBarbarianLayout0

  ; Block offsets by weapon type (sword, lance, axe, bow, staff or tome).
  .word $217A ; no sword block
  .word $217A ; no lance block
  .word _Axe - aMapBattleBarbarianLayout0
  .word $217A ; no bow block
  .word $217A ; no magic block

_Axe
  .word _AxeFrameTable - _Axe
  .word _AxeUnknown2 - _Axe, $217A
  .word _AxeWait - _Axe, $217A
  .word _AxeDodge - _Axe, $217A
  .word _AxeStrike - _Axe, $217A
  .word _AxeRanged - _Axe, $217A

_AxeFrame00
  .word 7 ; sprite count
  .structSpriteEntry ( -13,   -4), $00, SpriteSmall, $042, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   0,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame01
  .word 7 ; sprite count
  .structSpriteEntry ( -13,   -8), $00, SpriteSmall, $042, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   0,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame02
  .word 7 ; sprite count
  .structSpriteEntry ( -11,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   5,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -11,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (  -3,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (  -5,  -15), $00, SpriteSmall, $040, 2, 0, false, false
  .structSpriteEntry (   1,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -7,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame03
  .word 7 ; sprite count
  .structSpriteEntry ( -13,  -13), $00, SpriteSmall, $041, 2, 0, false, false
  .structSpriteEntry (   3,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -13,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry ( -13,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -5,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (  -1,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -9,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame04
  .word 7 ; sprite count
  .structSpriteEntry ( -15,    2), $00, SpriteSmall, $040, 2, 0, true, true
  .structSpriteEntry (   1,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -15,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry ( -15,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -7,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (  -3,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry ( -11,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame05
  .word 7 ; sprite count
  .structSpriteEntry ( -17,   -7), $00, SpriteSmall, $042, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   0,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame06
  .word 6 ; sprite count
  .structSpriteEntry (   2,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -14,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry ( -14,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -6,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (  -2,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry ( -10,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame07
  .word 7 ; sprite count
  .structSpriteEntry ( -12,   -8), $00, SpriteSmall, $042, 2, 0, false, false
  .structSpriteEntry (   4,  -18), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,   -2), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry ( -12,  -18), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -4,  -10), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   0,   -2), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,   -2), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame08
  .word 7 ; sprite count
  .structSpriteEntry ( -13,  -11), $00, SpriteSmall, $042, 2, 0, false, false
  .structSpriteEntry (   4,  -21), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,   -5), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry ( -12,  -21), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -4,  -13), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   0,   -5), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,   -5), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame09
  .word 7 ; sprite count
  .structSpriteEntry ( -20,   -5), $00, SpriteSmall, $040, 2, 0, true, true
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   0,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame0A
  .word 7 ; sprite count
  .structSpriteEntry ( -28,   -4), $00, SpriteSmall, $042, 2, 0, true, true
  .structSpriteEntry (   2,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -14,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry ( -14,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -6,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (  -2,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry ( -10,    0), $00, SpriteSmall, $01E, 2, 0, false, false

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
  .word _AxeFrame09 - _Axe
  .word _AxeFrame0A - _Axe

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
  ACTIVE_SPRITE_TABLE_FRAME 3, 7
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 4
  ACTIVE_SPRITE_TABLE_FRAME 1, 8
  ACTIVE_SPRITE_WAIT_STRIKE_DONE
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 3
  ACTIVE_SPRITE_TABLE_FRAME 3, 7
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
  ACTIVE_SPRITE_TABLE_FRAME 48, 4
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
  ACTIVE_SPRITE_TABLE_FRAME 3, 5
  ACTIVE_SPRITE_TABLE_FRAME 1, 9
  ACTIVE_SPRITE_MAP_BATTLE_STRIKE
  ACTIVE_SPRITE_TABLE_FRAME 1, 9
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 2, 10
  ACTIVE_SPRITE_TABLE_FRAME 48, 6
  ACTIVE_SPRITE_WAIT_STRIKE_TAKEN
  ACTIVE_SPRITE_TABLE_FRAME 3, 0
  ACTIVE_SPRITE_END_ROUND
  ACTIVE_SPRITE_SIDE_SCRIPT

  ; not reached by any offset
  ACTIVE_SPRITE_END

_AxeUnknown2
  .byte $79, $21, $79, $21, $08, $21, $6B

  MAP_BATTLE_SPRITE_DATA_END $800
