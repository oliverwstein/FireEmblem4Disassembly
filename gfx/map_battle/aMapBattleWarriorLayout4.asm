; Map battle sprite data: the format is described in tools/map_battle_layouts.py.

aMapBattleWarriorLayout4

  ; Block offsets by weapon type (sword, lance, axe, bow, staff or tome).
  .word $21BF ; no sword block
  .word $21BF ; no lance block
  .word _Axe - aMapBattleWarriorLayout4
  .word _Bow - aMapBattleWarriorLayout4
  .word $21BF ; no magic block

_Axe
  .word _AxeFrameTable - _Axe
  .word _AxeUnknown2 - _Axe, $21BF
  .word _AxeWait - _Axe, $21BF
  .word _AxeDodge - _Axe, $21BF
  .word _AxeStrike - _Axe, $21BF
  .word _AxeRanged - _Axe, $21BF

_AxeFrame00
  .word 7 ; sprite count
  .structSpriteEntry (   2,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -14,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry ( -14,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -6,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   2,   -7), $00, SpriteSmall, $042, 2, 0, true, false
  .structSpriteEntry (  -2,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry ( -10,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame01
  .word 7 ; sprite count
  .structSpriteEntry (   2,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -14,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry ( -14,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -6,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   4,   -8), $00, SpriteSmall, $042, 2, 0, true, false
  .structSpriteEntry (  -2,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry ( -10,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame02
  .word 8 ; sprite count
  .structSpriteEntry (  -9,  -10), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry (  -1,  -13), $00, SpriteSmall, $040, 2, 0, true, false
  .structSpriteEntry ( -14,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   2,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -14,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (  -6,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -10,    0), $00, SpriteSmall, $01E, 2, 0, false, false
  .structSpriteEntry (  -2,    0), $00, SpriteSmall, $01F, 2, 0, false, false

_AxeFrame03
  .word 7 ; sprite count
  .structSpriteEntry (  -8,  -12), $00, SpriteSmall, $042, 2, 0, false, true
  .structSpriteEntry ( -15,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   1,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -7,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -15,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -3,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry ( -11,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame04
  .word 8 ; sprite count
  .structSpriteEntry (  -8,  -10), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry (   4,  -14), $00, SpriteSmall, $041, 2, 0, true, false
  .structSpriteEntry ( -13,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   3,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -5,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -13,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -1,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -9,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame05
  .word 7 ; sprite count
  .structSpriteEntry (   6,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -10,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry ( -10,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -2,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   7,   -2), $00, SpriteSmall, $040, 2, 0, false, true
  .structSpriteEntry (   2,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -6,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame06
  .word 8 ; sprite count
  .structSpriteEntry (   9,   -9), $00, SpriteSmall, $040, 2, 0, true, false
  .structSpriteEntry (  -8,  -10), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -13,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   3,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -5,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -13,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -1,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -9,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame07
  .word 6 ; sprite count
  .structSpriteEntry (   6,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -10,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry ( -10,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -2,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   2,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -6,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame08
  .word 7 ; sprite count
  .structSpriteEntry ( -14,    1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   2,  -15), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -6,   -7), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -14,  -15), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   4,   -6), $00, SpriteSmall, $042, 2, 0, true, false
  .structSpriteEntry (  -2,    1), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry ( -10,    1), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame09
  .word 8 ; sprite count
  .structSpriteEntry (  13,   -7), $00, SpriteSmall, $042, 2, 0, true, false
  .structSpriteEntry (  -8,  -10), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -13,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   3,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -5,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -13,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -1,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -9,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame0A
  .word 7 ; sprite count
  .structSpriteEntry (  18,   -8), $00, SpriteSmall, $040, 2, 0, false, true
  .structSpriteEntry (   6,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -10,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry ( -10,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -2,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   2,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -6,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame0B
  .word 7 ; sprite count
  .structSpriteEntry ( -14,    3), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   2,  -13), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -6,   -5), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -14,  -13), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   4,   -4), $00, SpriteSmall, $042, 2, 0, true, false
  .structSpriteEntry (  -2,    3), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry ( -10,    3), $00, SpriteSmall, $01E, 2, 0, false, false

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
  .word _AxeFrame0B - _Axe

_AxeWait
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_WAIT_ROUND
  ACTIVE_SPRITE_ROUND_SCRIPT

_AxeDodge
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_WAIT_STRIKE
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 4
  ACTIVE_SPRITE_TABLE_FRAME 3, 8
  ACTIVE_SPRITE_TABLE_FRAME 1, 11
  ACTIVE_SPRITE_WAIT_STRIKE_DONE
  ACTIVE_SPRITE_TABLE_FRAME 3, 8
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
  ACTIVE_SPRITE_TABLE_FRAME 48, 5
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
  ACTIVE_SPRITE_TABLE_FRAME 3, 6
  ACTIVE_SPRITE_TABLE_FRAME 1, 9
  ACTIVE_SPRITE_MAP_BATTLE_STRIKE
  ACTIVE_SPRITE_TABLE_FRAME 1, 9
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 1
  ACTIVE_SPRITE_TABLE_FRAME 2, 10
  ACTIVE_SPRITE_TABLE_FRAME 48, 7
  ACTIVE_SPRITE_WAIT_STRIKE_TAKEN
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 3, 0
  ACTIVE_SPRITE_END_ROUND
  ACTIVE_SPRITE_SIDE_SCRIPT

  ; not reached by any offset
  ACTIVE_SPRITE_END

_AxeUnknown2
  .byte $BE, $21, $BE, $21, $43, $21, $6B

_Bow
  .word _BowFrameTable - _Bow
  .word _BowUnknown2 - _Bow, $21BF
  .word _BowWait - _Bow, $21BF
  .word _BowDodge - _Bow, $21BF
  .word $21BF, $21BF
  .word _BowRanged - _Bow, $21BF

_BowFrame00
  .word 9 ; sprite count
  .structSpriteEntry ( -14,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   2,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -14,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -6,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (  -2,   -4), $00, SpriteSmall, $040, 2, 0, true, true
  .structSpriteEntry (  -2,  -12), $00, SpriteSmall, $041, 2, 0, true, true
  .structSpriteEntry (   0,  -10), $00, SpriteSmall, $043, 2, 0, false, false
  .structSpriteEntry (  -2,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry ( -10,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_BowFrame01
  .word 9 ; sprite count
  .structSpriteEntry (  -9,  -11), $21, SpriteLarge, $048, 2, 0, false, false
  .structSpriteEntry ( -14,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   2,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -6,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -14,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   1,   -6), $00, SpriteSmall, $050, 2, 0, true, true
  .structSpriteEntry (   1,  -14), $00, SpriteSmall, $050, 2, 0, true, false
  .structSpriteEntry (  -2,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry ( -10,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_BowFrame02
  .word 9 ; sprite count
  .structSpriteEntry (  -7,  -13), $21, SpriteLarge, $04A, 2, 0, false, false
  .structSpriteEntry ( -14,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   2,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -14,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -6,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   4,   -5), $00, SpriteSmall, $050, 2, 0, true, true
  .structSpriteEntry (   4,  -13), $00, SpriteSmall, $050, 2, 0, true, false
  .structSpriteEntry (  -2,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry ( -10,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_BowFrame03
  .word 10 ; sprite count
  .structSpriteEntry (  -9,  -13), $21, SpriteLarge, $04A, 2, 0, false, false
  .structSpriteEntry ( -15,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   1,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -15,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -7,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   3,   -6), $00, SpriteSmall, $050, 2, 0, true, true
  .structSpriteEntry (   3,  -14), $00, SpriteSmall, $050, 2, 0, true, false
  .structSpriteEntry (  -3,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry ( -11,    0), $00, SpriteSmall, $01E, 2, 0, false, false
  .structSpriteEntry (   6,   -8), $00, SpriteSmall, $042, 2, 0, true, false

_BowFrame04
  .word 9 ; sprite count
  .structSpriteEntry (  -8,  -13), $21, SpriteLarge, $04A, 2, 0, false, false
  .structSpriteEntry ( -15,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   1,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -15,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -7,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   3,   -6), $00, SpriteSmall, $050, 2, 0, true, true
  .structSpriteEntry (   3,  -14), $00, SpriteSmall, $050, 2, 0, true, false
  .structSpriteEntry (  -3,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry ( -11,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_BowFrame05
  .word 10 ; sprite count
  .structSpriteEntry ( -10,   -6), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -14,    3), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   2,  -13), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -6,   -5), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -14,  -13), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -2,   -1), $00, SpriteSmall, $040, 2, 0, true, true
  .structSpriteEntry (  -2,   -9), $00, SpriteSmall, $041, 2, 0, true, true
  .structSpriteEntry (  -1,   -7), $00, SpriteSmall, $043, 2, 0, false, false
  .structSpriteEntry (  -2,    3), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry ( -10,    3), $00, SpriteSmall, $01E, 2, 0, false, false

_BowFrame06
  .word 10 ; sprite count
  .structSpriteEntry (  -9,  -13), $21, SpriteLarge, $04A, 2, 0, false, false
  .structSpriteEntry ( -15,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   1,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -15,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -7,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (  15,   -8), $00, SpriteSmall, $042, 2, 0, true, false
  .structSpriteEntry (   3,   -6), $00, SpriteSmall, $050, 2, 0, true, true
  .structSpriteEntry (   3,  -14), $00, SpriteSmall, $050, 2, 0, true, false
  .structSpriteEntry (  -3,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry ( -11,    0), $00, SpriteSmall, $01E, 2, 0, false, false

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
  .byte $80, $23, $80, $23, $3B, $23, $6B

  MAP_BATTLE_SPRITE_DATA_END $800
