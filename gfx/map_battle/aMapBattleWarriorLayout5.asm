; Map battle sprite data: the format is described in tools/map_battle_layouts.py.

aMapBattleWarriorLayout5

  ; Block offsets by weapon type (sword, lance, axe, bow, staff or tome).
  .word $211E ; no sword block
  .word $211E ; no lance block
  .word _Axe - aMapBattleWarriorLayout5
  .word _Bow - aMapBattleWarriorLayout5
  .word $211E ; no magic block

_Axe
  .word _AxeFrameTable - _Axe
  .word _AxeUnknown2 - _Axe, $211E
  .word _AxeWait - _Axe, $211E
  .word _AxeDodge - _Axe, $211E
  .word _AxeStrike - _Axe, $211E

_AxeFrame00
  .word 7 ; sprite count
  .structSpriteEntry (   4,   -6), $00, SpriteSmall, $042, 2, 0, true, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   0,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame01
  .word 7 ; sprite count
  .structSpriteEntry (   5,   -3), $00, SpriteSmall, $042, 2, 0, true, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   0,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame02
  .word 8 ; sprite count
  .structSpriteEntry (  -1,   -9), $00, SpriteSmall, $040, 2, 0, true, false
  .structSpriteEntry (  -8,  -11), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   0,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame03
  .word 7 ; sprite count
  .structSpriteEntry ( -13,  -17), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry ( -13,   -1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   3,  -17), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -5,   -9), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -11,  -13), $00, SpriteSmall, $042, 2, 0, false, true
  .structSpriteEntry (  -1,   -1), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -9,   -1), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame04
  .word 8 ; sprite count
  .structSpriteEntry (   6,   -3), $00, SpriteSmall, $040, 2, 0, true, false
  .structSpriteEntry (  -8,  -11), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   0,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame05
  .word 6 ; sprite count
  .structSpriteEntry ( -10,    2), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   6,  -14), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -2,   -6), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -10,  -14), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   2,    2), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -6,    2), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame06
  .word 8 ; sprite count
  .structSpriteEntry (   0,   -1), $00, SpriteSmall, $042, 2, 0, true, false
  .structSpriteEntry ( -12,   -7), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -15,    3), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   1,  -13), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -7,   -5), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -15,  -13), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -3,    3), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry ( -11,    3), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame07
  .word 8 ; sprite count
  .structSpriteEntry (   5,    1), $00, SpriteSmall, $042, 2, 0, true, false
  .structSpriteEntry (  -8,  -11), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   0,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame08
  .word 7 ; sprite count
  .structSpriteEntry (  10,    6), $00, SpriteSmall, $040, 2, 0, false, true
  .structSpriteEntry ( -10,    2), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   6,  -14), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -2,   -6), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -10,  -14), $21, SpriteLarge, $020, 2, 0, false, false
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
  ACTIVE_SPRITE_TABLE_FRAME 3, 0
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 1
  ACTIVE_SPRITE_TABLE_FRAME 1, 6
  ACTIVE_SPRITE_WAIT_STRIKE_DONE
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 3, 0
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
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 2
  ACTIVE_SPRITE_TABLE_FRAME 3, 4
  ACTIVE_SPRITE_TABLE_FRAME 1, 7
  ACTIVE_SPRITE_MAP_BATTLE_STRIKE
  ACTIVE_SPRITE_TABLE_FRAME 1, 7
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 1
  ACTIVE_SPRITE_TABLE_FRAME 2, 8
  ACTIVE_SPRITE_TABLE_FRAME 48, 5
  ACTIVE_SPRITE_WAIT_STRIKE_TAKEN
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 3, 0
  ACTIVE_SPRITE_END_ROUND
  ACTIVE_SPRITE_SIDE_SCRIPT

  ; not reached by any offset
  ACTIVE_SPRITE_END

_AxeUnknown2
  .byte $1D, $21, $1D, $21, $CA, $20, $6B

_Bow
  .word _BowFrameTable - _Bow
  .word _BowUnknown2 - _Bow, $211E
  .word _BowWait - _Bow, $211E
  .word _BowDodge - _Bow, $211E
  .word _BowStrike - _Bow, $211E

_BowFrame00
  .word 9 ; sprite count
  .structSpriteEntry (  -2,   -8), $00, SpriteSmall, $040, 2, 0, true, false
  .structSpriteEntry (  -2,    0), $00, SpriteSmall, $041, 2, 0, true, false
  .structSpriteEntry (   0,   -5), $00, SpriteSmall, $043, 2, 0, true, false
  .structSpriteEntry ( -13,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   3,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -5,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -13,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -1,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -9,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_BowFrame01
  .word 10 ; sprite count
  .structSpriteEntry (  -1,    1), $00, SpriteSmall, $041, 2, 0, true, false
  .structSpriteEntry (  -1,   -7), $00, SpriteSmall, $040, 2, 0, true, false
  .structSpriteEntry (   0,   -6), $00, SpriteSmall, $043, 2, 0, true, false
  .structSpriteEntry (  -9,  -10), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -13,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry ( -13,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   3,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -5,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (  -9,    0), $00, SpriteSmall, $01E, 2, 0, false, false
  .structSpriteEntry (  -1,    0), $00, SpriteSmall, $01F, 2, 0, false, false

_BowFrame02
  .word 9 ; sprite count
  .structSpriteEntry (  -1,    0), $00, SpriteSmall, $041, 2, 0, true, false
  .structSpriteEntry (  -1,   -8), $00, SpriteSmall, $040, 2, 0, true, false
  .structSpriteEntry (  -9,  -11), $21, SpriteLarge, $048, 2, 0, false, false
  .structSpriteEntry ( -13,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -5,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -13,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   3,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -1,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -9,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_BowFrame03
  .word 10 ; sprite count
  .structSpriteEntry (  -3,   -1), $00, SpriteSmall, $041, 2, 0, true, false
  .structSpriteEntry (  -3,   -9), $00, SpriteSmall, $040, 2, 0, true, false
  .structSpriteEntry (   2,   -2), $00, SpriteSmall, $043, 2, 0, true, false
  .structSpriteEntry ( -11,  -12), $21, SpriteLarge, $048, 2, 0, false, false
  .structSpriteEntry ( -14,  -17), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry ( -14,   -1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   2,  -17), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -6,   -9), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (  -2,   -1), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry ( -10,   -1), $00, SpriteSmall, $01E, 2, 0, false, false

_BowFrame04
  .word 9 ; sprite count
  .structSpriteEntry (  -2,   -8), $00, SpriteSmall, $040, 2, 0, true, false
  .structSpriteEntry (  -2,    0), $00, SpriteSmall, $041, 2, 0, true, false
  .structSpriteEntry ( -10,  -12), $21, SpriteLarge, $048, 2, 0, false, false
  .structSpriteEntry ( -14,  -17), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry ( -14,   -1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   2,  -17), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -6,   -9), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (  -2,   -1), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry ( -10,   -1), $00, SpriteSmall, $01E, 2, 0, false, false

_BowFrame05
  .word 10 ; sprite count
  .structSpriteEntry (  -6,    4), $00, SpriteSmall, $041, 2, 0, true, false
  .structSpriteEntry (  -6,   -4), $00, SpriteSmall, $040, 2, 0, true, false
  .structSpriteEntry (  -4,   -1), $00, SpriteSmall, $043, 2, 0, true, false
  .structSpriteEntry ( -13,   -6), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -16,  -13), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   0,  -13), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -8,   -5), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -16,    3), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (  -4,    3), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry ( -12,    3), $00, SpriteSmall, $01E, 2, 0, false, false

_BowFrame06
  .word 10 ; sprite count
  .structSpriteEntry (  -3,   -1), $00, SpriteSmall, $041, 2, 0, true, false
  .structSpriteEntry (  -3,   -9), $00, SpriteSmall, $040, 2, 0, true, false
  .structSpriteEntry (   7,    3), $00, SpriteSmall, $043, 2, 0, true, false
  .structSpriteEntry ( -11,  -12), $21, SpriteLarge, $048, 2, 0, false, false
  .structSpriteEntry ( -14,  -17), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry ( -14,   -1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   2,  -17), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -6,   -9), $21, SpriteLarge, $022, 2, 0, false, false
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

_BowStrike
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
  .byte $E0, $22, $E0, $22, $9B, $22, $6B

  MAP_BATTLE_SPRITE_DATA_END $800
