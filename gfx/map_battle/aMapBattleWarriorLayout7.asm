; Map battle sprite data: the format is described in tools/map_battle_layouts.py.

aMapBattleWarriorLayout7

  ; Block offsets by weapon type (sword, lance, axe, bow, staff or tome).
  .word $214A ; no sword block
  .word $214A ; no lance block
  .word _Axe - aMapBattleWarriorLayout7
  .word _Bow - aMapBattleWarriorLayout7
  .word $214A ; no magic block

_Axe
  .word _AxeFrameTable - _Axe
  .word _AxeUnknown2 - _Axe, $214A
  .word _AxeWait - _Axe, $214A
  .word _AxeDodge - _Axe, $214A
  .word _AxeStrike - _Axe, $214A

_AxeFrame00
  .word 7 ; sprite count
  .structSpriteEntry ( -12,   -4), $00, SpriteSmall, $042, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   0,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame01
  .word 8 ; sprite count
  .structSpriteEntry ( -14,   -4), $00, SpriteSmall, $042, 2, 0, false, false
  .structSpriteEntry ( -10,   -9), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   0,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame02
  .word 7 ; sprite count
  .structSpriteEntry (  -8,  -11), $00, SpriteSmall, $040, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   0,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    0), $00, SpriteSmall, $01E, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_AxeFrame03
  .word 7 ; sprite count
  .structSpriteEntry ( -11,  -17), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -3,   -9), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (  -4,  -14), $00, SpriteSmall, $042, 2, 0, true, true
  .structSpriteEntry ( -11,   -1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   5,  -17), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (   1,   -1), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -7,   -1), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame04
  .word 7 ; sprite count
  .structSpriteEntry ( -12,   -1), $00, SpriteSmall, $040, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   0,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame05
  .word 7 ; sprite count
  .structSpriteEntry ( -12,   -7), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry (   2,  -14), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -14,    2), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry ( -14,  -14), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -6,   -6), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (  -2,    2), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry ( -10,    2), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame06
  .word 8 ; sprite count
  .structSpriteEntry ( -14,   -6), $00, SpriteSmall, $042, 2, 0, false, false
  .structSpriteEntry ( -11,  -11), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -13,  -17), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry ( -13,   -1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   3,  -17), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -5,   -9), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (  -1,   -1), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -9,   -1), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame07
  .word 8 ; sprite count
  .structSpriteEntry ( -16,   -8), $00, SpriteSmall, $042, 2, 0, false, false
  .structSpriteEntry ( -13,  -13), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -15,  -19), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry ( -15,   -3), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   1,  -19), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -7,  -11), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (  -3,   -3), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry ( -11,   -3), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame08
  .word 7 ; sprite count
  .structSpriteEntry ( -14,    2), $00, SpriteSmall, $042, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   0,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame09
  .word 8 ; sprite count
  .structSpriteEntry ( -17,    7), $00, SpriteSmall, $040, 2, 0, true, true
  .structSpriteEntry ( -12,   -7), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry (   2,  -14), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -14,    2), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry ( -14,  -14), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -6,   -6), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (  -2,    2), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry ( -10,    2), $00, SpriteSmall, $01E, 2, 0, false, false

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

_AxeWait
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_WAIT_ROUND
  ACTIVE_SPRITE_ROUND_SCRIPT

_AxeDodge
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_WAIT_STRIKE
  ACTIVE_SPRITE_TABLE_FRAME 3, 6
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 1
  ACTIVE_SPRITE_TABLE_FRAME 1, 7
  ACTIVE_SPRITE_WAIT_STRIKE_DONE
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 3, 6
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
  ACTIVE_SPRITE_TABLE_FRAME 1, 8
  ACTIVE_SPRITE_MAP_BATTLE_STRIKE
  ACTIVE_SPRITE_TABLE_FRAME 1, 8
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 1
  ACTIVE_SPRITE_TABLE_FRAME 2, 9
  ACTIVE_SPRITE_TABLE_FRAME 48, 5
  ACTIVE_SPRITE_WAIT_STRIKE_TAKEN
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 3, 0
  ACTIVE_SPRITE_END_ROUND
  ACTIVE_SPRITE_SIDE_SCRIPT

  ; not reached by any offset
  ACTIVE_SPRITE_END

_AxeUnknown2
  .byte $49, $21, $49, $21, $F6, $20, $6B

_Bow
  .word _BowFrameTable - _Bow
  .word _BowUnknown2 - _Bow, $214A
  .word _BowWait - _Bow, $214A
  .word _BowDodge - _Bow, $214A
  .word _BowStrike - _Bow, $214A

_BowFrame00
  .word 9 ; sprite count
  .structSpriteEntry (  -8,   -1), $00, SpriteSmall, $043, 2, 0, false, false
  .structSpriteEntry (  -7,   -7), $00, SpriteSmall, $040, 2, 0, false, false
  .structSpriteEntry (  -7,    1), $00, SpriteSmall, $041, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   0,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_BowFrame01
  .word 10 ; sprite count
  .structSpriteEntry (  -8,   -3), $00, SpriteSmall, $043, 2, 0, false, false
  .structSpriteEntry (  -9,   -7), $00, SpriteSmall, $040, 2, 0, false, false
  .structSpriteEntry (  -9,    1), $00, SpriteSmall, $041, 2, 0, false, false
  .structSpriteEntry ( -10,  -10), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   0,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_BowFrame02
  .word 10 ; sprite count
  .structSpriteEntry (  -8,   -4), $00, SpriteSmall, $043, 2, 0, false, false
  .structSpriteEntry ( -10,   -8), $00, SpriteSmall, $040, 2, 0, false, false
  .structSpriteEntry ( -10,    0), $00, SpriteSmall, $041, 2, 0, false, false
  .structSpriteEntry ( -10,  -10), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   0,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_BowFrame03
  .word 10 ; sprite count
  .structSpriteEntry (  -9,   -2), $00, SpriteSmall, $043, 2, 0, false, false
  .structSpriteEntry (  -8,    0), $00, SpriteSmall, $041, 2, 0, false, false
  .structSpriteEntry (  -8,   -8), $00, SpriteSmall, $040, 2, 0, false, false
  .structSpriteEntry (  -8,  -11), $21, SpriteLarge, $048, 2, 0, false, false
  .structSpriteEntry ( -11,  -17), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   5,  -17), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -11,   -1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (  -3,   -9), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   1,   -1), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -7,   -1), $00, SpriteSmall, $01E, 2, 0, false, false

_BowFrame04
  .word 9 ; sprite count
  .structSpriteEntry (  -8,    0), $00, SpriteSmall, $041, 2, 0, false, false
  .structSpriteEntry (  -8,   -8), $00, SpriteSmall, $040, 2, 0, false, false
  .structSpriteEntry (  -9,  -11), $21, SpriteLarge, $048, 2, 0, false, false
  .structSpriteEntry ( -11,  -17), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   5,  -17), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -11,   -1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (  -3,   -9), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   1,   -1), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -7,   -1), $00, SpriteSmall, $01E, 2, 0, false, false

_BowFrame05
  .word 10 ; sprite count
  .structSpriteEntry (  -9,   -3), $00, SpriteSmall, $043, 2, 0, false, false
  .structSpriteEntry (  -8,   -9), $00, SpriteSmall, $040, 2, 0, false, false
  .structSpriteEntry (  -8,   -1), $00, SpriteSmall, $041, 2, 0, false, false
  .structSpriteEntry ( -10,  -12), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry (   3,  -17), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -13,   -1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (  -5,   -9), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -13,  -17), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -1,   -1), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -9,   -1), $00, SpriteSmall, $01E, 2, 0, false, false

_BowFrame06
  .word 10 ; sprite count
  .structSpriteEntry ( -11,   -5), $00, SpriteSmall, $043, 2, 0, false, false
  .structSpriteEntry ( -10,  -11), $00, SpriteSmall, $040, 2, 0, false, false
  .structSpriteEntry ( -10,   -3), $00, SpriteSmall, $041, 2, 0, false, false
  .structSpriteEntry ( -12,  -14), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry (   1,  -19), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -15,   -3), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (  -7,  -11), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -15,  -19), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -3,   -3), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry ( -11,   -3), $00, SpriteSmall, $01E, 2, 0, false, false

_BowFrame07
  .word 10 ; sprite count
  .structSpriteEntry ( -14,    3), $00, SpriteSmall, $043, 2, 0, false, false
  .structSpriteEntry (  -8,    0), $00, SpriteSmall, $041, 2, 0, false, false
  .structSpriteEntry (  -8,   -8), $00, SpriteSmall, $040, 2, 0, false, false
  .structSpriteEntry (  -8,  -11), $21, SpriteLarge, $048, 2, 0, false, false
  .structSpriteEntry ( -11,  -17), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   5,  -17), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -11,   -1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (  -3,   -9), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   1,   -1), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -7,   -1), $00, SpriteSmall, $01E, 2, 0, false, false

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
  ACTIVE_SPRITE_TABLE_FRAME 3, 5
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 5
  ACTIVE_SPRITE_TABLE_FRAME 1, 6
  ACTIVE_SPRITE_WAIT_STRIKE_DONE
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 3, 5
  ACTIVE_SPRITE_SIDE_SCRIPT

_BowStrike
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 1
  ACTIVE_SPRITE_TABLE_FRAME 4, 1
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
  .byte $47, $23, $47, $23, $02, $23, $6B

  MAP_BATTLE_SPRITE_DATA_END $800
