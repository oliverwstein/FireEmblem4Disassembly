; Map battle sprite data: the format is described in tools/map_battle_layouts.py.

aMapBattleWarriorLayout0

  ; Block offsets by weapon type (sword, lance, axe, bow, staff or tome).
  .word $219F ; no sword block
  .word $219F ; no lance block
  .word _Axe - aMapBattleWarriorLayout0
  .word _Bow - aMapBattleWarriorLayout0
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
  .structSpriteEntry ( -10,   -4), $00, SpriteSmall, $042, 2, 0, false, false
  .structSpriteEntry (   6,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -10,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry ( -10,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -2,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   2,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -6,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame01
  .word 8 ; sprite count
  .structSpriteEntry ( -12,   -4), $00, SpriteSmall, $042, 2, 0, false, false
  .structSpriteEntry (  -8,   -9), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry (   6,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -10,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry ( -10,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -2,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   2,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -6,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame02
  .word 7 ; sprite count
  .structSpriteEntry (  -6,  -11), $00, SpriteSmall, $040, 2, 0, false, false
  .structSpriteEntry ( -10,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   6,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -2,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -10,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   2,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -6,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame03
  .word 7 ; sprite count
  .structSpriteEntry (  -9,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -1,  -12), $00, SpriteSmall, $042, 2, 0, true, true
  .structSpriteEntry (  -1,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (  -9,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   7,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (   3,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -5,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame04
  .word 7 ; sprite count
  .structSpriteEntry ( -12,  -11), $00, SpriteSmall, $041, 2, 0, false, false
  .structSpriteEntry ( -11,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   5,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -3,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -11,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   1,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -7,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame05
  .word 7 ; sprite count
  .structSpriteEntry ( -15,   -6), $00, SpriteSmall, $040, 2, 0, false, false
  .structSpriteEntry ( -10,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   6,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -2,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -10,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   2,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -6,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame06
  .word 7 ; sprite count
  .structSpriteEntry ( -10,   -9), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   0,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame07
  .word 8 ; sprite count
  .structSpriteEntry ( -11,   -6), $00, SpriteSmall, $042, 2, 0, false, false
  .structSpriteEntry (  -8,  -11), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -10,   -1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   6,  -17), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -2,   -9), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -10,  -17), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   2,   -1), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -6,   -1), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame08
  .word 8 ; sprite count
  .structSpriteEntry ( -11,   -8), $00, SpriteSmall, $042, 2, 0, false, false
  .structSpriteEntry (  -8,  -13), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -10,   -3), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   6,  -19), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -10,  -19), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -2,  -11), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   2,   -3), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -6,   -3), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame09
  .word 7 ; sprite count
  .structSpriteEntry ( -20,   -5), $00, SpriteSmall, $042, 2, 0, false, false
  .structSpriteEntry ( -10,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   6,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -2,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -10,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   2,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -6,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame0A
  .word 8 ; sprite count
  .structSpriteEntry ( -26,   -6), $00, SpriteSmall, $040, 2, 0, true, true
  .structSpriteEntry ( -10,   -9), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   0,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    0), $00, SpriteSmall, $01E, 2, 0, false, false

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
  .structSpriteEntry ( -10,   -4), $00, SpriteSmall, $042, 2, 0, false, false
  .structSpriteEntry (  -9,    1), $00, SpriteSmall, $050, 2, 0, false, true
  .structSpriteEntry (  -9,   -7), $00, SpriteSmall, $050, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   0,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_BowFrame01
  .word 10 ; sprite count
  .structSpriteEntry (  -9,   -6), $00, SpriteSmall, $042, 2, 0, false, false
  .structSpriteEntry ( -11,   -2), $00, SpriteSmall, $050, 2, 0, true, false
  .structSpriteEntry ( -11,  -10), $00, SpriteSmall, $050, 2, 0, false, false
  .structSpriteEntry ( -10,  -10), $21, SpriteLarge, $048, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   0,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_BowFrame02
  .word 10 ; sprite count
  .structSpriteEntry (  -9,   -7), $00, SpriteSmall, $042, 2, 0, false, false
  .structSpriteEntry ( -12,   -3), $00, SpriteSmall, $050, 2, 0, false, true
  .structSpriteEntry ( -12,  -11), $00, SpriteSmall, $050, 2, 0, false, false
  .structSpriteEntry ( -11,  -10), $21, SpriteLarge, $04C, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   0,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_BowFrame03
  .word 10 ; sprite count
  .structSpriteEntry ( -14,   -7), $00, SpriteSmall, $042, 2, 0, false, false
  .structSpriteEntry ( -11,   -4), $00, SpriteSmall, $050, 2, 0, false, true
  .structSpriteEntry (  -9,  -10), $21, SpriteLarge, $04C, 2, 0, false, false
  .structSpriteEntry ( -11,  -12), $00, SpriteSmall, $050, 2, 0, false, false
  .structSpriteEntry ( -11,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   5,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -3,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -11,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   1,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -7,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_BowFrame04
  .word 9 ; sprite count
  .structSpriteEntry ( -11,   -4), $00, SpriteSmall, $050, 2, 0, false, true
  .structSpriteEntry ( -10,  -10), $21, SpriteLarge, $04C, 2, 0, false, false
  .structSpriteEntry ( -11,  -12), $00, SpriteSmall, $050, 2, 0, false, false
  .structSpriteEntry ( -11,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   5,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -3,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -11,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   1,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -7,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_BowFrame05
  .word 10 ; sprite count
  .structSpriteEntry ( -10,   -6), $00, SpriteSmall, $042, 2, 0, false, false
  .structSpriteEntry (  -9,   -1), $00, SpriteSmall, $050, 2, 0, false, true
  .structSpriteEntry (  -9,   -9), $00, SpriteSmall, $050, 2, 0, false, false
  .structSpriteEntry (  -9,  -12), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -12,   -1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -17), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -9), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -17), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   0,   -1), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,   -1), $00, SpriteSmall, $01E, 2, 0, false, false

_BowFrame06
  .word 10 ; sprite count
  .structSpriteEntry ( -10,   -8), $00, SpriteSmall, $042, 2, 0, false, false
  .structSpriteEntry (  -9,   -3), $00, SpriteSmall, $050, 2, 0, false, true
  .structSpriteEntry (  -9,  -11), $00, SpriteSmall, $050, 2, 0, false, false
  .structSpriteEntry (  -9,  -14), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -12,   -3), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -19), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,  -19), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -4,  -11), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   0,   -3), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,   -3), $00, SpriteSmall, $01E, 2, 0, false, false

_BowFrame07
  .word 10 ; sprite count
  .structSpriteEntry ( -11,   -4), $00, SpriteSmall, $050, 2, 0, false, true
  .structSpriteEntry (  -9,  -10), $21, SpriteLarge, $04C, 2, 0, false, false
  .structSpriteEntry ( -11,  -12), $00, SpriteSmall, $050, 2, 0, false, false
  .structSpriteEntry ( -23,   -7), $00, SpriteSmall, $042, 2, 0, false, false
  .structSpriteEntry ( -11,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   5,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -3,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -11,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   1,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -7,    0), $00, SpriteSmall, $01E, 2, 0, false, false

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
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 4
  ACTIVE_SPRITE_TABLE_FRAME 3, 5
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 5
  ACTIVE_SPRITE_TABLE_FRAME 1, 6
  ACTIVE_SPRITE_WAIT_STRIKE_DONE
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 3, 5
  ACTIVE_SPRITE_SIDE_SCRIPT

_BowRanged
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
  .byte $A2, $23, $A2, $23, $5B, $23, $6B

  MAP_BATTLE_SPRITE_DATA_END $800
