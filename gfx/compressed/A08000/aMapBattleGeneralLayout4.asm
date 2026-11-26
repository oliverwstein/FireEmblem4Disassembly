; Map battle sprite data: the format is described in tools/map_battle_layouts.py.

aMapBattleGeneralLayout4

  ; Block offsets by weapon type (sword, lance, axe, bow, staff or tome).
  .word _Sword - aMapBattleGeneralLayout4
  .word _Lance - aMapBattleGeneralLayout4
  .word _Axe - aMapBattleGeneralLayout4
  .word _Bow - aMapBattleGeneralLayout4
  .word _Magic - aMapBattleGeneralLayout4

_Sword
  .word _SwordFrameTable - _Sword
  .word _SwordUnknown2 - _Sword, $815D
  .word _SwordWait - _Sword, $815D
  .word _SwordDodge - _Sword, $815D
  .word _SwordStrike - _Sword, $815D
  .word _SwordRanged - _Sword, $815D

_SwordFrame00
  .word 7 ; sprite count
  .structSpriteEntry ( -16,   -7), $21, SpriteLarge, $04E, 2, 0, false, false
  .structSpriteEntry (  -9,  -10), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -13,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   3,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -5,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -13,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   2,    0), $00, SpriteSmall, $040, 2, 0, false, true

_SwordFrame01
  .word 7 ; sprite count
  .structSpriteEntry ( -16,   -6), $21, SpriteLarge, $04E, 2, 0, false, false
  .structSpriteEntry (  -9,  -10), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -13,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   3,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -5,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -13,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   3,  -12), $00, SpriteSmall, $040, 2, 0, false, false

_SwordFrame02
  .word 7 ; sprite count
  .structSpriteEntry ( -17,   -6), $21, SpriteLarge, $04E, 2, 0, false, false
  .structSpriteEntry (  -4,  -16), $00, SpriteSmall, $040, 2, 0, true, false
  .structSpriteEntry ( -10,  -11), $21, SpriteLarge, $048, 2, 0, false, false
  .structSpriteEntry ( -14,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   2,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -6,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -14,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_SwordFrame03
  .word 7 ; sprite count
  .structSpriteEntry ( -16,   -5), $21, SpriteLarge, $04E, 2, 0, false, false
  .structSpriteEntry (  -9,   -9), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -13,    1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   3,  -15), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -5,   -7), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -13,  -15), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   2,    1), $00, SpriteSmall, $040, 2, 0, false, true

_SwordFrame04
  .word 7 ; sprite count
  .structSpriteEntry ( -15,   -2), $21, SpriteLarge, $04E, 2, 0, false, false
  .structSpriteEntry (  -8,   -7), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -13,    3), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   3,  -13), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -13,  -13), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -5,   -5), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   3,    3), $00, SpriteSmall, $040, 2, 0, false, true

_SwordFrame05
  .word 7 ; sprite count
  .structSpriteEntry ( -14,   -6), $21, SpriteLarge, $04E, 2, 0, false, false
  .structSpriteEntry (   6,  -13), $00, SpriteSmall, $041, 2, 0, true, false
  .structSpriteEntry (  -7,  -10), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -11,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   5,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -3,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -11,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_SwordFrameTable
  .word _SwordFrame00 - _Sword
  .word _SwordFrame01 - _Sword
  .word _SwordFrame02 - _Sword
  .word _SwordFrame03 - _Sword
  .word _SwordFrame04 - _Sword
  .word _SwordFrame05 - _Sword

_SwordWait
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_WAIT_ROUND
  ACTIVE_SPRITE_ROUND_SCRIPT

_SwordDodge
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_WAIT_STRIKE
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 1
  ACTIVE_SPRITE_TABLE_FRAME 3, 3
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 2
  ACTIVE_SPRITE_TABLE_FRAME 1, 4
  ACTIVE_SPRITE_WAIT_STRIKE_DONE
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 1
  ACTIVE_SPRITE_TABLE_FRAME 3, 3
  ACTIVE_SPRITE_SIDE_SCRIPT

_SwordStrike
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_TABLE_FRAME 3, 1
  ACTIVE_SPRITE_TABLE_FRAME 22, 2
  ACTIVE_SPRITE_MAP_BATTLE_STRIKE
  ACTIVE_SPRITE_TABLE_FRAME 1, 2
  ACTIVE_SPRITE_TABLE_FRAME 2, 5
  ACTIVE_SPRITE_TABLE_FRAME 48, 0
  ACTIVE_SPRITE_WAIT_STRIKE_TAKEN
  ACTIVE_SPRITE_TABLE_FRAME 3, 0
  ACTIVE_SPRITE_END_ROUND
  ACTIVE_SPRITE_SIDE_SCRIPT

_SwordRanged
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_TABLE_FRAME 4, 1
  ACTIVE_SPRITE_START_MAP_MAGIC
  ACTIVE_SPRITE_TABLE_FRAME 1, 2
  ACTIVE_SPRITE_WAIT_MAP_MAGIC
  ACTIVE_SPRITE_TABLE_FRAME 4, 1
  ACTIVE_SPRITE_END_ROUND
  ACTIVE_SPRITE_SIDE_SCRIPT

  ; not reached by any offset
  ACTIVE_SPRITE_END

_SwordUnknown2
  .byte $5C, $81, $5C, $81, $0A, $81, $6B

_Lance
  .word _LanceFrameTable - _Lance
  .word _LanceUnknown2 - _Lance, $815D
  .word _LanceWait - _Lance, $815D
  .word _LanceDodge - _Lance, $815D
  .word _LanceStrike - _Lance, $815D
  .word _LanceRanged - _Lance, $815D

_LanceFrame00
  .word 8 ; sprite count
  .structSpriteEntry ( -16,   -6), $21, SpriteLarge, $04E, 2, 0, false, false
  .structSpriteEntry (  -4,  -18), $00, SpriteSmall, $040, 2, 0, false, false
  .structSpriteEntry (   2,  -10), $00, SpriteSmall, $041, 2, 0, false, false
  .structSpriteEntry (  -9,  -10), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -13,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   3,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -5,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -13,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_LanceFrame01
  .word 8 ; sprite count
  .structSpriteEntry ( -17,   -5), $21, SpriteLarge, $04E, 2, 0, false, false
  .structSpriteEntry (  -9,  -16), $00, SpriteSmall, $043, 2, 0, true, true
  .structSpriteEntry (  -1,  -16), $00, SpriteSmall, $042, 2, 0, true, true
  .structSpriteEntry ( -10,  -11), $21, SpriteLarge, $048, 2, 0, false, false
  .structSpriteEntry ( -14,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   2,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -6,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -14,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_LanceFrame02
  .word 8 ; sprite count
  .structSpriteEntry ( -16,   -6), $21, SpriteLarge, $04E, 2, 0, false, false
  .structSpriteEntry (  14,  -10), $00, SpriteSmall, $042, 2, 0, true, true
  .structSpriteEntry (   6,  -10), $00, SpriteSmall, $043, 2, 0, true, true
  .structSpriteEntry (  -9,  -10), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -13,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   3,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -5,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -13,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_LanceFrame03
  .word 6 ; sprite count
  .structSpriteEntry ( -15,   -7), $21, SpriteLarge, $04E, 2, 0, false, false
  .structSpriteEntry (  -8,   -9), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_LanceFrame04
  .word 8 ; sprite count
  .structSpriteEntry ( -16,   -5), $21, SpriteLarge, $04E, 2, 0, false, false
  .structSpriteEntry (  -3,  -16), $00, SpriteSmall, $040, 2, 0, false, false
  .structSpriteEntry (   3,   -8), $00, SpriteSmall, $041, 2, 0, false, false
  .structSpriteEntry (  -9,   -9), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -13,    1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   3,  -15), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -13,  -15), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -5,   -7), $21, SpriteLarge, $022, 2, 0, false, false

_LanceFrame05
  .word 8 ; sprite count
  .structSpriteEntry ( -15,   -1), $21, SpriteLarge, $04E, 2, 0, false, false
  .structSpriteEntry (   4,   -6), $00, SpriteSmall, $041, 2, 0, false, false
  .structSpriteEntry (  -2,  -14), $00, SpriteSmall, $040, 2, 0, false, false
  .structSpriteEntry (  -8,   -7), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -13,    3), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   3,  -13), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -13,  -13), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -5,   -5), $21, SpriteLarge, $022, 2, 0, false, false

_LanceFrame06
  .word 8 ; sprite count
  .structSpriteEntry ( -17,   -6), $21, SpriteLarge, $04E, 2, 0, false, false
  .structSpriteEntry (  -5,  -21), $00, SpriteSmall, $040, 2, 0, false, false
  .structSpriteEntry (   1,  -13), $00, SpriteSmall, $041, 2, 0, false, false
  .structSpriteEntry ( -10,  -11), $21, SpriteLarge, $048, 2, 0, false, false
  .structSpriteEntry ( -14,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   2,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -6,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -14,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_LanceFrame07
  .word 8 ; sprite count
  .structSpriteEntry ( -14,   -6), $21, SpriteLarge, $04E, 2, 0, false, false
  .structSpriteEntry (   3,  -13), $00, SpriteSmall, $040, 2, 0, false, false
  .structSpriteEntry (   9,   -5), $00, SpriteSmall, $041, 2, 0, false, false
  .structSpriteEntry (  -7,  -10), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -11,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   5,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -3,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -11,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_LanceFrame08
  .word 8 ; sprite count
  .structSpriteEntry ( -13,   -6), $21, SpriteLarge, $04E, 2, 0, false, false
  .structSpriteEntry (   1,  -15), $00, SpriteSmall, $040, 2, 0, false, false
  .structSpriteEntry (   7,   -7), $00, SpriteSmall, $041, 2, 0, false, false
  .structSpriteEntry (  -6,  -10), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -10,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   6,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -2,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -10,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_LanceFrameTable
  .word _LanceFrame00 - _Lance
  .word _LanceFrame01 - _Lance
  .word _LanceFrame02 - _Lance
  .word _LanceFrame03 - _Lance
  .word _LanceFrame04 - _Lance
  .word _LanceFrame05 - _Lance
  .word _LanceFrame06 - _Lance
  .word _LanceFrame07 - _Lance
  .word _LanceFrame08 - _Lance

_LanceWait
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_WAIT_ROUND
  ACTIVE_SPRITE_ROUND_SCRIPT

_LanceDodge
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_WAIT_STRIKE
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 1
  ACTIVE_SPRITE_TABLE_FRAME 3, 4
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 2
  ACTIVE_SPRITE_TABLE_FRAME 1, 5
  ACTIVE_SPRITE_WAIT_STRIKE_DONE
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 1
  ACTIVE_SPRITE_TABLE_FRAME 3, 4
  ACTIVE_SPRITE_SIDE_SCRIPT

_LanceStrike
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_TABLE_FRAME 32, 6
  ACTIVE_SPRITE_MAP_BATTLE_STRIKE
  ACTIVE_SPRITE_TABLE_FRAME 1, 1
  ACTIVE_SPRITE_TABLE_FRAME 2, 7
  ACTIVE_SPRITE_TABLE_FRAME 48, 8
  ACTIVE_SPRITE_WAIT_STRIKE_TAKEN
  ACTIVE_SPRITE_TABLE_FRAME 3, 0
  ACTIVE_SPRITE_END_ROUND
  ACTIVE_SPRITE_SIDE_SCRIPT

_LanceRanged
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_TABLE_FRAME 32, 1
  ACTIVE_SPRITE_MAP_BATTLE_STRIKE
  ACTIVE_SPRITE_TABLE_FRAME 1, 1
  ACTIVE_SPRITE_TABLE_FRAME 2, 2
  ACTIVE_SPRITE_TABLE_FRAME 48, 3
  ACTIVE_SPRITE_WAIT_STRIKE_TAKEN
  ACTIVE_SPRITE_TABLE_FRAME 3, 0
  ACTIVE_SPRITE_END_ROUND
  ACTIVE_SPRITE_SIDE_SCRIPT

  ; not reached by any offset
  ACTIVE_SPRITE_END

_LanceUnknown2
  .byte $4A, $83, $4A, $83, $F5, $82, $6B

_Axe
  .word _AxeFrameTable - _Axe
  .word _AxeUnknown2 - _Axe, $815D
  .word _AxeWait - _Axe, $815D
  .word _AxeDodge - _Axe, $815D
  .word _AxeStrike - _Axe, $815D
  .word _AxeRanged - _Axe, $815D

_AxeFrame00
  .word 7 ; sprite count
  .structSpriteEntry ( -16,   -7), $21, SpriteLarge, $04E, 2, 0, false, false
  .structSpriteEntry (  -9,  -10), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry (   3,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -5,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -13,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   1,    0), $00, SpriteSmall, $040, 2, 0, false, true
  .structSpriteEntry ( -13,    0), $00, SpriteSmall, $034, 2, 0, false, false

_AxeFrame01
  .word 7 ; sprite count
  .structSpriteEntry ( -16,   -6), $21, SpriteLarge, $04E, 2, 0, false, false
  .structSpriteEntry (  -9,  -10), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -13,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   3,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -5,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -13,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   3,  -11), $00, SpriteSmall, $042, 2, 0, true, false

_AxeFrame02
  .word 7 ; sprite count
  .structSpriteEntry ( -17,   -6), $21, SpriteLarge, $04E, 2, 0, false, false
  .structSpriteEntry (  -3,  -17), $00, SpriteSmall, $040, 2, 0, true, false
  .structSpriteEntry ( -10,  -11), $21, SpriteLarge, $048, 2, 0, false, false
  .structSpriteEntry ( -14,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   2,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -6,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -14,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_AxeFrame03
  .word 7 ; sprite count
  .structSpriteEntry (   6,   -8), $00, SpriteSmall, $042, 2, 0, true, false
  .structSpriteEntry ( -16,   -6), $21, SpriteLarge, $04E, 2, 0, false, false
  .structSpriteEntry (  -9,  -10), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -13,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   3,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -5,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -13,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_AxeFrame04
  .word 6 ; sprite count
  .structSpriteEntry ( -15,   -7), $21, SpriteLarge, $04E, 2, 0, false, false
  .structSpriteEntry (  -8,  -10), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_AxeFrame05
  .word 7 ; sprite count
  .structSpriteEntry ( -16,   -5), $21, SpriteLarge, $04E, 2, 0, false, false
  .structSpriteEntry (  -9,   -9), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -13,    1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   3,  -15), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -5,   -7), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -13,  -15), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   1,    1), $00, SpriteSmall, $040, 2, 0, false, true

_AxeFrame06
  .word 7 ; sprite count
  .structSpriteEntry ( -15,   -2), $21, SpriteLarge, $04E, 2, 0, false, false
  .structSpriteEntry (  -8,   -6), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -13,    3), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   3,  -13), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -13,  -13), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -5,   -5), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   1,    3), $00, SpriteSmall, $040, 2, 0, false, true

_AxeFrame07
  .word 7 ; sprite count
  .structSpriteEntry ( -14,   -6), $21, SpriteLarge, $04E, 2, 0, false, false
  .structSpriteEntry (   6,  -12), $00, SpriteSmall, $041, 2, 0, true, false
  .structSpriteEntry (  -7,  -10), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -11,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   5,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -3,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -11,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_AxeFrame08
  .word 7 ; sprite count
  .structSpriteEntry ( -13,   -7), $21, SpriteLarge, $04E, 2, 0, false, false
  .structSpriteEntry (  -5,  -10), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry (   7,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -1,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (  -9,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   6,    0), $00, SpriteSmall, $040, 2, 0, false, true
  .structSpriteEntry (  -9,    0), $00, SpriteSmall, $034, 2, 0, false, false

_AxeFrame09
  .word 7 ; sprite count
  .structSpriteEntry (  11,   -7), $00, SpriteSmall, $040, 2, 0, false, true
  .structSpriteEntry ( -16,   -6), $21, SpriteLarge, $04E, 2, 0, false, false
  .structSpriteEntry (  -9,  -10), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -13,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   3,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -5,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -13,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_AxeFrame0A
  .word 7 ; sprite count
  .structSpriteEntry (  18,   -7), $00, SpriteSmall, $042, 2, 0, false, true
  .structSpriteEntry ( -16,   -6), $21, SpriteLarge, $04E, 2, 0, false, false
  .structSpriteEntry (  -9,  -10), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -13,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   3,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -5,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -13,  -16), $21, SpriteLarge, $020, 2, 0, false, false

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
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 1
  ACTIVE_SPRITE_TABLE_FRAME 3, 5
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 2
  ACTIVE_SPRITE_TABLE_FRAME 1, 6
  ACTIVE_SPRITE_WAIT_STRIKE_DONE
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 1
  ACTIVE_SPRITE_TABLE_FRAME 3, 5
  ACTIVE_SPRITE_SIDE_SCRIPT

_AxeStrike
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_TABLE_FRAME 3, 1
  ACTIVE_SPRITE_TABLE_FRAME 22, 2
  ACTIVE_SPRITE_MAP_BATTLE_STRIKE
  ACTIVE_SPRITE_TABLE_FRAME 1, 2
  ACTIVE_SPRITE_TABLE_FRAME 2, 7
  ACTIVE_SPRITE_TABLE_FRAME 48, 8
  ACTIVE_SPRITE_WAIT_STRIKE_TAKEN
  ACTIVE_SPRITE_TABLE_FRAME 3, 0
  ACTIVE_SPRITE_END_ROUND
  ACTIVE_SPRITE_SIDE_SCRIPT

_AxeRanged
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_TABLE_FRAME 3, 1
  ACTIVE_SPRITE_TABLE_FRAME 32, 2
  ACTIVE_SPRITE_TABLE_FRAME 3, 3
  ACTIVE_SPRITE_TABLE_FRAME 1, 9
  ACTIVE_SPRITE_MAP_BATTLE_STRIKE
  ACTIVE_SPRITE_TABLE_FRAME 1, 9
  ACTIVE_SPRITE_TABLE_FRAME 2, 10
  ACTIVE_SPRITE_TABLE_FRAME 48, 4
  ACTIVE_SPRITE_WAIT_STRIKE_TAKEN
  ACTIVE_SPRITE_TABLE_FRAME 3, 0
  ACTIVE_SPRITE_END_ROUND
  ACTIVE_SPRITE_SIDE_SCRIPT

  ; not reached by any offset
  ACTIVE_SPRITE_END

_AxeUnknown2
  .byte $6A, $85, $6A, $85, $09, $85, $6B

_Bow
  .word _BowFrameTable - _Bow
  .word _BowUnknown2 - _Bow, $815D
  .word _BowWait - _Bow, $815D
  .word _BowDodge - _Bow, $815D
  .word $815D, $815D
  .word _BowRanged - _Bow, $815D

_BowFrame00
  .word 8 ; sprite count
  .structSpriteEntry (   1,   -3), $00, SpriteSmall, $050, 2, 0, true, true
  .structSpriteEntry (   1,  -11), $00, SpriteSmall, $050, 2, 0, true, false
  .structSpriteEntry (  -8,  -10), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -13,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   3,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -5,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -13,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   1,   -7), $00, SpriteSmall, $042, 2, 0, true, false

_BowFrame01
  .word 7 ; sprite count
  .structSpriteEntry (  -8,  -10), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -13,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   3,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -5,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -13,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   1,   -4), $00, SpriteSmall, $050, 2, 0, true, true
  .structSpriteEntry (   1,  -12), $00, SpriteSmall, $050, 2, 0, true, false

_BowFrame02
  .word 7 ; sprite count
  .structSpriteEntry (  -9,  -10), $21, SpriteLarge, $04A, 2, 0, false, false
  .structSpriteEntry ( -13,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   3,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -5,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -13,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   2,   -2), $00, SpriteSmall, $050, 2, 0, true, true
  .structSpriteEntry (   2,  -10), $00, SpriteSmall, $050, 2, 0, true, false

_BowFrame03
  .word 8 ; sprite count
  .structSpriteEntry (   1,   -2), $00, SpriteSmall, $050, 2, 0, true, true
  .structSpriteEntry (   1,  -10), $00, SpriteSmall, $050, 2, 0, true, false
  .structSpriteEntry ( -11,  -10), $21, SpriteLarge, $04A, 2, 0, false, false
  .structSpriteEntry ( -14,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   2,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -14,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -6,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   4,   -6), $00, SpriteSmall, $042, 2, 0, true, false

_BowFrame04
  .word 8 ; sprite count
  .structSpriteEntry (   1,   -2), $00, SpriteSmall, $050, 2, 0, true, true
  .structSpriteEntry (   1,  -10), $00, SpriteSmall, $050, 2, 0, true, false
  .structSpriteEntry (  -8,   -9), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -13,    1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   3,  -15), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -5,   -7), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -13,  -15), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   1,   -6), $00, SpriteSmall, $042, 2, 0, true, false

_BowFrame05
  .word 8 ; sprite count
  .structSpriteEntry (   2,    0), $00, SpriteSmall, $050, 2, 0, true, true
  .structSpriteEntry (   2,   -8), $00, SpriteSmall, $050, 2, 0, true, false
  .structSpriteEntry (  -7,   -7), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -13,    3), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   3,  -13), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -13,  -13), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -5,   -5), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   2,   -4), $00, SpriteSmall, $042, 2, 0, true, false

_BowFrame06
  .word 8 ; sprite count
  .structSpriteEntry ( -10,  -10), $21, SpriteLarge, $04A, 2, 0, false, false
  .structSpriteEntry (  15,   -6), $00, SpriteSmall, $042, 2, 0, true, false
  .structSpriteEntry (   1,   -2), $00, SpriteSmall, $050, 2, 0, true, true
  .structSpriteEntry (   1,  -10), $00, SpriteSmall, $050, 2, 0, true, false
  .structSpriteEntry ( -14,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   2,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -6,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -14,  -16), $21, SpriteLarge, $020, 2, 0, false, false

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
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 1
  ACTIVE_SPRITE_TABLE_FRAME 3, 4
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 2
  ACTIVE_SPRITE_TABLE_FRAME 1, 5
  ACTIVE_SPRITE_WAIT_STRIKE_DONE
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 1
  ACTIVE_SPRITE_TABLE_FRAME 3, 4
  ACTIVE_SPRITE_SIDE_SCRIPT

_BowRanged
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_TABLE_FRAME 3, 1
  ACTIVE_SPRITE_TABLE_FRAME 32, 2
  ACTIVE_SPRITE_TABLE_FRAME 1, 3
  ACTIVE_SPRITE_MAP_BATTLE_STRIKE
  ACTIVE_SPRITE_TABLE_FRAME 1, 3
  ACTIVE_SPRITE_TABLE_FRAME 2, 6
  ACTIVE_SPRITE_TABLE_FRAME 48, 2
  ACTIVE_SPRITE_WAIT_STRIKE_TAKEN
  ACTIVE_SPRITE_TABLE_FRAME 3, 0
  ACTIVE_SPRITE_END_ROUND
  ACTIVE_SPRITE_SIDE_SCRIPT

  ; not reached by any offset
  ACTIVE_SPRITE_END

_BowUnknown2
  .byte $EE, $86, $EE, $86, $AB, $86, $6B

_Magic
  .word _MagicFrameTable - _Magic
  .word _MagicUnknown2 - _Magic, $815D
  .word _MagicWait - _Magic, $815D
  .word _MagicDodge - _Magic, $815D
  .word _MagicStrike - _Magic, $815D
  .word _MagicStrike - _Magic, $815D

_MagicFrame00
  .word 4 ; sprite count
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_MagicFrame01
  .word 4 ; sprite count
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_MagicFrame02
  .word 4 ; sprite count
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_MagicFrame03
  .word 4 ; sprite count
  .structSpriteEntry (  -5,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -13,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   3,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -13,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_MagicFrame04
  .word 4 ; sprite count
  .structSpriteEntry (  -7,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -15,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   1,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -15,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_MagicFrameTable
  .word _MagicFrame00 - _Magic
  .word _MagicFrame01 - _Magic
  .word _MagicFrame02 - _Magic
  .word _MagicFrame03 - _Magic
  .word _MagicFrame04 - _Magic

_MagicWait
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 3
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_WAIT_ROUND
  ACTIVE_SPRITE_ROUND_SCRIPT

_MagicDodge
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 3
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_WAIT_STRIKE
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 6
  ACTIVE_SPRITE_TABLE_FRAME 3, 3
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 7
  ACTIVE_SPRITE_TABLE_FRAME 1, 4
  ACTIVE_SPRITE_WAIT_STRIKE_DONE
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 6
  ACTIVE_SPRITE_TABLE_FRAME 3, 3
  ACTIVE_SPRITE_SIDE_SCRIPT

_MagicStrike
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 3
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 4
  ACTIVE_SPRITE_TABLE_FRAME 3, 1
  ACTIVE_SPRITE_START_MAP_MAGIC
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 5
  ACTIVE_SPRITE_TABLE_FRAME 1, 2
  ACTIVE_SPRITE_WAIT_MAP_MAGIC
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 4
  ACTIVE_SPRITE_TABLE_FRAME 3, 1
  ACTIVE_SPRITE_END_ROUND
  ACTIVE_SPRITE_SIDE_SCRIPT

  ; not reached by any offset
  ACTIVE_SPRITE_END

_MagicUnknown2
  .byte $BA, $87, $BA, $87, $7D, $87, $6B

  MAP_BATTLE_SPRITE_DATA_END $880
