; Map battle sprite data: the format is described in tools/map_battle_layouts.py.

aMapBattleWarriorLayout6

  ; Block offsets by weapon type (sword, lance, axe, bow, staff or tome).
  .word $219F ; no sword block
  .word $219F ; no lance block
  .word _Axe - aMapBattleWarriorLayout6
  .word _Bow - aMapBattleWarriorLayout6
  .word $219F ; no magic block

_Axe
  .word _AxeFrameTable - _Axe
  .word _AxeUnknown2 - _Axe, $219F
  .word _AxeWait - _Axe, $219F
  .word _AxeDodge - _Axe, $219F
  .word _AxeStrike - _Axe, $219F
  .word _AxeRanged - _Axe, $219F

_AxeFrame00
  .word 7 ; sprite count
  .structSpriteEntry (  -5,    0), $00, SpriteSmall, $040, 2, 0, true, true
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   0,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame01
  .word 7 ; sprite count
  .structSpriteEntry (  -7,    2), $00, SpriteSmall, $040, 2, 0, true, true
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   0,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame02
  .word 8 ; sprite count
  .structSpriteEntry ( -10,   -6), $00, SpriteSmall, $042, 2, 0, false, false
  .structSpriteEntry (  -6,  -10), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   0,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame03
  .word 7 ; sprite count
  .structSpriteEntry ( -12,   -1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -17), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -9), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -17), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -3,  -18), $00, SpriteSmall, $040, 2, 0, false, false
  .structSpriteEntry (   0,   -1), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,   -1), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame04
  .word 8 ; sprite count
  .structSpriteEntry (  -9,   -5), $00, SpriteSmall, $041, 2, 0, false, false
  .structSpriteEntry (  -6,   -9), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   4,  -15), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,    1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (  -4,   -7), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   0,    1), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    1), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame05
  .word 8 ; sprite count
  .structSpriteEntry (  -5,    6), $00, SpriteSmall, $042, 2, 0, false, false
  .structSpriteEntry (  -6,  -10), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   0,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame06
  .word 6 ; sprite count
  .structSpriteEntry (   4,  -14), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,    2), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry ( -12,  -14), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -4,   -6), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   0,    2), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    2), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame07
  .word 7 ; sprite count
  .structSpriteEntry (  -8,    2), $00, SpriteSmall, $040, 2, 0, true, true
  .structSpriteEntry ( -13,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   3,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -5,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -13,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -1,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -9,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame08
  .word 8 ; sprite count
  .structSpriteEntry ( -11,    2), $00, SpriteSmall, $040, 2, 0, true, true
  .structSpriteEntry ( -11,  -10), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -15,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   1,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -15,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -7,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (  -3,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry ( -11,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame09
  .word 8 ; sprite count
  .structSpriteEntry (  -5,   12), $00, SpriteSmall, $040, 2, 0, true, true
  .structSpriteEntry (  -6,  -10), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   0,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame0A
  .word 7 ; sprite count
  .structSpriteEntry (  -5,   17), $00, SpriteSmall, $042, 2, 0, true, true
  .structSpriteEntry (   4,  -14), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,    2), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry ( -12,  -14), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -4,   -6), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   0,    2), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    2), $00, SpriteSmall, $01E, 2, 0, false, false

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
  ACTIVE_SPRITE_TABLE_FRAME 3, 7
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 1
  ACTIVE_SPRITE_TABLE_FRAME 1, 8
  ACTIVE_SPRITE_WAIT_STRIKE_DONE
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 3, 7
  ACTIVE_SPRITE_SIDE_SCRIPT

_AxeStrike
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 1
  ACTIVE_SPRITE_TABLE_FRAME 2, 1
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 2
  ACTIVE_SPRITE_TABLE_FRAME 2, 2
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 3
  ACTIVE_SPRITE_TABLE_FRAME 32, 3
  ACTIVE_SPRITE_MAP_BATTLE_STRIKE
  ACTIVE_SPRITE_TABLE_FRAME 1, 3
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 2
  ACTIVE_SPRITE_TABLE_FRAME 2, 4
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 1
  ACTIVE_SPRITE_TABLE_FRAME 48, 1
  ACTIVE_SPRITE_WAIT_STRIKE_TAKEN
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 3, 0
  ACTIVE_SPRITE_END_ROUND
  ACTIVE_SPRITE_SIDE_SCRIPT

_AxeRanged
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 1
  ACTIVE_SPRITE_TABLE_FRAME 2, 1
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 2
  ACTIVE_SPRITE_TABLE_FRAME 2, 2
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 3
  ACTIVE_SPRITE_TABLE_FRAME 32, 3
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 2
  ACTIVE_SPRITE_TABLE_FRAME 3, 5
  ACTIVE_SPRITE_TABLE_FRAME 1, 9
  ACTIVE_SPRITE_MAP_BATTLE_STRIKE
  ACTIVE_SPRITE_TABLE_FRAME 1, 9
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 1
  ACTIVE_SPRITE_TABLE_FRAME 2, 10
  ACTIVE_SPRITE_TABLE_FRAME 48, 6
  ACTIVE_SPRITE_WAIT_STRIKE_TAKEN
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 3, 0
  ACTIVE_SPRITE_END_ROUND
  ACTIVE_SPRITE_SIDE_SCRIPT

  ; not reached by any offset
  ACTIVE_SPRITE_END

_AxeUnknown2
  .byte $9E, $21, $9E, $21, $21, $21, $6B

_Bow
  .word _BowFrameTable - _Bow
  .word _BowUnknown2 - _Bow, $219F
  .word _BowWait - _Bow, $219F
  .word _BowDodge - _Bow, $219F
  .word $219F, $219F
  .word _BowRanged - _Bow, $219F

_BowFrame00
  .word 9 ; sprite count
  .structSpriteEntry (  -1,    0), $00, SpriteSmall, $053, 2, 0, false, true
  .structSpriteEntry (  -3,    2), $00, SpriteSmall, $052, 2, 0, false, false
  .structSpriteEntry (  -3,   -6), $00, SpriteSmall, $051, 2, 0, false, false
  .structSpriteEntry ( -14,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   2,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -6,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -14,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -2,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry ( -10,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_BowFrame01
  .word 10 ; sprite count
  .structSpriteEntry (  -1,   -2), $00, SpriteSmall, $053, 2, 0, false, true
  .structSpriteEntry (  -3,    3), $00, SpriteSmall, $052, 2, 0, false, false
  .structSpriteEntry (  -3,   -5), $00, SpriteSmall, $051, 2, 0, false, false
  .structSpriteEntry (  -7,  -10), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -14,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   2,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -14,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -6,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (  -2,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry ( -10,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_BowFrame02
  .word 10 ; sprite count
  .structSpriteEntry (  -1,   -4), $00, SpriteSmall, $053, 2, 0, false, true
  .structSpriteEntry (  -3,    5), $00, SpriteSmall, $052, 2, 0, false, false
  .structSpriteEntry (  -3,   -3), $00, SpriteSmall, $051, 2, 0, false, false
  .structSpriteEntry (  -7,  -12), $21, SpriteLarge, $048, 2, 0, false, false
  .structSpriteEntry ( -14,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   2,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -6,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -14,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -2,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry ( -10,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_BowFrame03
  .word 10 ; sprite count
  .structSpriteEntry (  -3,    2), $00, SpriteSmall, $052, 2, 0, false, false
  .structSpriteEntry (  -3,   -6), $00, SpriteSmall, $051, 2, 0, false, false
  .structSpriteEntry (  -1,    3), $00, SpriteSmall, $053, 2, 0, false, true
  .structSpriteEntry (  -7,  -14), $21, SpriteLarge, $048, 2, 0, false, false
  .structSpriteEntry ( -14,   -1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   2,  -17), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -6,   -9), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -14,  -17), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -2,   -1), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry ( -10,   -1), $00, SpriteSmall, $01E, 2, 0, false, false

_BowFrame04
  .word 9 ; sprite count
  .structSpriteEntry (  -3,    2), $00, SpriteSmall, $052, 2, 0, false, false
  .structSpriteEntry (  -3,   -6), $00, SpriteSmall, $051, 2, 0, false, false
  .structSpriteEntry (  -7,  -13), $21, SpriteLarge, $048, 2, 0, false, false
  .structSpriteEntry ( -14,   -1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   2,  -17), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -6,   -9), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -14,  -17), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -2,   -1), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry ( -10,   -1), $00, SpriteSmall, $01E, 2, 0, false, false

_BowFrame05
  .word 10 ; sprite count
  .structSpriteEntry (  -9,    2), $00, SpriteSmall, $052, 2, 0, false, false
  .structSpriteEntry (  -9,   -6), $00, SpriteSmall, $051, 2, 0, false, false
  .structSpriteEntry (  -7,    0), $00, SpriteSmall, $053, 2, 0, false, true
  .structSpriteEntry ( -13,  -11), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -18,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (  -2,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -18,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry ( -10,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (  -5,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry ( -13,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_BowFrame06
  .word 10 ; sprite count
  .structSpriteEntry (  -3,    2), $00, SpriteSmall, $052, 2, 0, false, false
  .structSpriteEntry (  -3,   -6), $00, SpriteSmall, $051, 2, 0, false, false
  .structSpriteEntry (  -1,   16), $00, SpriteSmall, $053, 2, 0, false, true
  .structSpriteEntry (  -7,  -14), $21, SpriteLarge, $048, 2, 0, false, false
  .structSpriteEntry ( -14,   -1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   2,  -17), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -6,   -9), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -14,  -17), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -2,   -1), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry ( -10,   -1), $00, SpriteSmall, $01E, 2, 0, false, false

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
  ACTIVE_SPRITE_TABLE_FRAME 3, 0
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 5
  ACTIVE_SPRITE_TABLE_FRAME 1, 5
  ACTIVE_SPRITE_WAIT_STRIKE_DONE
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 3, 0
  ACTIVE_SPRITE_SIDE_SCRIPT

_BowRanged
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 2
  ACTIVE_SPRITE_TABLE_FRAME 4, 1
  ACTIVE_SPRITE_TABLE_FRAME 32, 2
  ACTIVE_SPRITE_MAP_BATTLE_STRIKE
  ACTIVE_SPRITE_TABLE_FRAME 1, 2
  ACTIVE_SPRITE_TABLE_FRAME 1, 3
  ACTIVE_SPRITE_TABLE_FRAME 1, 6
  ACTIVE_SPRITE_TABLE_FRAME 48, 4
  ACTIVE_SPRITE_WAIT_STRIKE_TAKEN
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 3, 0
  ACTIVE_SPRITE_END_ROUND
  ACTIVE_SPRITE_SIDE_SCRIPT

  ; not reached by any offset
  ACTIVE_SPRITE_END

_BowUnknown2
  .byte $6A, $23, $6A, $23, $25, $23, $6B

  MAP_BATTLE_SPRITE_DATA_END $800
