; Map battle sprite data: the format is described in tools/map_battle_layouts.py.

aMapBattleSoldierLayout6

  ; Block offsets by weapon type (sword, lance, axe, bow, staff or tome).
  .word _Sword - aMapBattleSoldierLayout6
  .word _Lance - aMapBattleSoldierLayout6
  .word _Axe - aMapBattleSoldierLayout6
  .word _Bow - aMapBattleSoldierLayout6
  .word $8161 ; no magic block

_Sword
  .word _SwordFrameTable - _Sword
  .word _SwordUnknown2 - _Sword, $8161
  .word _SwordWait - _Sword, $8161
  .word _SwordDodge - _Sword, $8161
  .word _SwordStrike - _Sword, $8161
  .word _SwordRanged - _Sword, $8161

_SwordFrame00
  .word 6 ; sprite count
  .structSpriteEntry (  -5,    3), $00, SpriteSmall, $043, 2, 0, false, true
  .structSpriteEntry (  -7,   -8), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_SwordFrame01
  .word 6 ; sprite count
  .structSpriteEntry (  -6,   -8), $00, SpriteSmall, $043, 2, 0, false, false
  .structSpriteEntry (  -7,   -8), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_SwordFrame02
  .word 6 ; sprite count
  .structSpriteEntry (  -7,  -11), $21, SpriteLarge, $048, 2, 0, false, false
  .structSpriteEntry ( -12,   -1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -17), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -9), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -17), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -7,  -14), $00, SpriteSmall, $042, 2, 0, false, false

_SwordFrame03
  .word 6 ; sprite count
  .structSpriteEntry (  -7,    3), $00, SpriteSmall, $043, 2, 0, false, true
  .structSpriteEntry (  -9,   -8), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -13,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   3,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -5,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -13,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_SwordFrame04
  .word 6 ; sprite count
  .structSpriteEntry ( -10,    3), $00, SpriteSmall, $043, 2, 0, false, true
  .structSpriteEntry ( -12,   -8), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -15,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   1,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -15,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -7,   -8), $21, SpriteLarge, $022, 2, 0, false, false

_SwordFrame05
  .word 6 ; sprite count
  .structSpriteEntry (  -7,   -7), $00, SpriteSmall, $050, 2, 0, false, false
  .structSpriteEntry (  -7,   -7), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -12,    1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -15), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -7), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $020, 2, 0, false, false

_SwordFrame06
  .word 6 ; sprite count
  .structSpriteEntry (  -5,    7), $00, SpriteSmall, $043, 2, 0, false, true
  .structSpriteEntry (  -7,   -5), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -12,    3), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -13), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -5), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -13), $21, SpriteLarge, $020, 2, 0, false, false

_SwordFrameTable
  .word _SwordFrame00 - _Sword
  .word _SwordFrame01 - _Sword
  .word _SwordFrame02 - _Sword
  .word _SwordFrame03 - _Sword
  .word _SwordFrame04 - _Sword
  .word _SwordFrame05 - _Sword
  .word _SwordFrame06 - _Sword

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
  ACTIVE_SPRITE_TABLE_FRAME 48, 6
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
  .byte $60, $81, $60, $81, $0E, $81, $6B

_Lance
  .word _LanceFrameTable - _Lance
  .word _LanceUnknown2 - _Lance, $8161
  .word _LanceWait - _Lance, $8161
  .word _LanceDodge - _Lance, $8161
  .word _LanceStrike - _Lance, $8161
  .word _LanceRanged - _Lance, $8161

_LanceFrame00
  .word 7 ; sprite count
  .structSpriteEntry (  -7,  -13), $00, SpriteSmall, $050, 2, 0, false, false
  .structSpriteEntry (  -7,   -5), $00, SpriteSmall, $051, 2, 0, false, false
  .structSpriteEntry (  -7,   -8), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_LanceFrame01
  .word 7 ; sprite count
  .structSpriteEntry (  -8,  -18), $00, SpriteSmall, $050, 2, 0, false, false
  .structSpriteEntry (  -8,  -10), $00, SpriteSmall, $051, 2, 0, false, false
  .structSpriteEntry (  -7,  -11), $21, SpriteLarge, $048, 2, 0, false, false
  .structSpriteEntry ( -12,   -1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -17), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -9), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -17), $21, SpriteLarge, $020, 2, 0, false, false

_LanceFrame02
  .word 7 ; sprite count
  .structSpriteEntry (  -5,    6), $00, SpriteSmall, $050, 2, 0, false, false
  .structSpriteEntry (  -5,   14), $00, SpriteSmall, $051, 2, 0, false, false
  .structSpriteEntry (  -7,   -7), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_LanceFrame03
  .word 5 ; sprite count
  .structSpriteEntry (  -7,   -7), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -12,    1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -15), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -7), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $020, 2, 0, false, false

_LanceFrame04
  .word 7 ; sprite count
  .structSpriteEntry (  -8,  -13), $00, SpriteSmall, $050, 2, 0, false, false
  .structSpriteEntry (  -8,   -5), $00, SpriteSmall, $051, 2, 0, false, false
  .structSpriteEntry (  -9,   -8), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -13,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   3,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -13,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -5,   -8), $21, SpriteLarge, $022, 2, 0, false, false

_LanceFrame05
  .word 7 ; sprite count
  .structSpriteEntry ( -12,   -5), $00, SpriteSmall, $051, 2, 0, false, false
  .structSpriteEntry ( -12,  -13), $00, SpriteSmall, $050, 2, 0, false, false
  .structSpriteEntry ( -13,   -8), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -15,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   1,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -15,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -7,   -8), $21, SpriteLarge, $022, 2, 0, false, false

_LanceFrame06
  .word 7 ; sprite count
  .structSpriteEntry (  -6,   -1), $00, SpriteSmall, $050, 2, 0, false, false
  .structSpriteEntry (  -6,    7), $00, SpriteSmall, $051, 2, 0, false, false
  .structSpriteEntry (  -7,   -7), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_LanceFrame07
  .word 7 ; sprite count
  .structSpriteEntry (  -6,   -2), $00, SpriteSmall, $050, 2, 0, false, false
  .structSpriteEntry (  -6,    6), $00, SpriteSmall, $051, 2, 0, false, false
  .structSpriteEntry (  -7,   -6), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -12,    2), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -14), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -6), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -14), $21, SpriteLarge, $020, 2, 0, false, false

_LanceFrameTable
  .word _LanceFrame00 - _Lance
  .word _LanceFrame01 - _Lance
  .word _LanceFrame02 - _Lance
  .word _LanceFrame03 - _Lance
  .word _LanceFrame04 - _Lance
  .word _LanceFrame05 - _Lance
  .word _LanceFrame06 - _Lance
  .word _LanceFrame07 - _Lance

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
  ACTIVE_SPRITE_TABLE_FRAME 32, 1
  ACTIVE_SPRITE_MAP_BATTLE_STRIKE
  ACTIVE_SPRITE_TABLE_FRAME 1, 1
  ACTIVE_SPRITE_TABLE_FRAME 2, 6
  ACTIVE_SPRITE_TABLE_FRAME 48, 7
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
  .byte $FA, $82, $FA, $82, $A5, $82, $6B

_Axe
  .word _AxeFrameTable - _Axe
  .word _AxeUnknown2 - _Axe, $8161
  .word _AxeWait - _Axe, $8161
  .word _AxeDodge - _Axe, $8161
  .word _AxeStrike - _Axe, $8161
  .word _AxeRanged - _Axe, $8161

_AxeFrame00
  .word 6 ; sprite count
  .structSpriteEntry (  -9,    0), $00, SpriteSmall, $042, 2, 0, false, false
  .structSpriteEntry (  -7,   -8), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false

_AxeFrame01
  .word 6 ; sprite count
  .structSpriteEntry ( -10,   -6), $00, SpriteSmall, $042, 2, 0, false, false
  .structSpriteEntry (  -7,   -8), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_AxeFrame02
  .word 6 ; sprite count
  .structSpriteEntry (  -7,  -11), $21, SpriteLarge, $048, 2, 0, false, false
  .structSpriteEntry ( -12,   -1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -17), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -9), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -17), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -6,  -15), $00, SpriteSmall, $040, 2, 0, false, false

_AxeFrame03
  .word 6 ; sprite count
  .structSpriteEntry (  -5,    5), $00, SpriteSmall, $042, 2, 0, false, false
  .structSpriteEntry (  -7,   -8), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_AxeFrame04
  .word 5 ; sprite count
  .structSpriteEntry (  -7,   -7), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -12,    1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -15), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -7), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $020, 2, 0, false, false

_AxeFrame05
  .word 6 ; sprite count
  .structSpriteEntry ( -11,    0), $00, SpriteSmall, $042, 2, 0, false, false
  .structSpriteEntry (  -9,   -8), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -13,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   3,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -13,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -5,   -8), $21, SpriteLarge, $022, 2, 0, false, false

_AxeFrame06
  .word 6 ; sprite count
  .structSpriteEntry ( -15,    0), $00, SpriteSmall, $042, 2, 0, false, false
  .structSpriteEntry ( -15,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry ( -13,   -8), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry (   1,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -15,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -7,   -8), $21, SpriteLarge, $022, 2, 0, false, false

_AxeFrame07
  .word 6 ; sprite count
  .structSpriteEntry (  -9,   -9), $00, SpriteSmall, $043, 2, 0, false, false
  .structSpriteEntry (  -7,   -8), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_AxeFrame08
  .word 6 ; sprite count
  .structSpriteEntry (  -7,    6), $00, SpriteSmall, $040, 2, 0, true, true
  .structSpriteEntry ( -12,    2), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (  -7,   -6), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry (   4,  -14), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -6), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -14), $21, SpriteLarge, $020, 2, 0, false, false

_AxeFrame09
  .word 6 ; sprite count
  .structSpriteEntry (  -5,   11), $00, SpriteSmall, $040, 2, 0, true, true
  .structSpriteEntry (  -7,   -8), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_AxeFrame0A
  .word 6 ; sprite count
  .structSpriteEntry (  -5,   15), $00, SpriteSmall, $042, 2, 0, true, true
  .structSpriteEntry (  -7,   -7), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -12,    1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -15), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -7), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $020, 2, 0, false, false

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
  .byte $E3, $84, $E3, $84, $82, $84, $6B

_Bow
  .word _BowFrameTable - _Bow
  .word _BowUnknown2 - _Bow, $8161
  .word _BowWait - _Bow, $8161
  .word _BowDodge - _Bow, $8161
  .word $8161, $8161
  .word _BowRanged - _Bow, $8161

_BowFrame00
  .word 8 ; sprite count
  .structSpriteEntry (  -1,    1), $00, SpriteSmall, $053, 2, 0, false, true
  .structSpriteEntry (  -3,    3), $00, SpriteSmall, $052, 2, 0, false, false
  .structSpriteEntry (  -3,   -5), $00, SpriteSmall, $051, 2, 0, false, false
  .structSpriteEntry (  -7,   -8), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_BowFrame01
  .word 8 ; sprite count
  .structSpriteEntry (  -1,    0), $00, SpriteSmall, $053, 2, 0, false, true
  .structSpriteEntry (  -3,    4), $00, SpriteSmall, $052, 2, 0, false, false
  .structSpriteEntry (  -3,   -4), $00, SpriteSmall, $051, 2, 0, false, false
  .structSpriteEntry (  -7,   -8), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_BowFrame02
  .word 8 ; sprite count
  .structSpriteEntry (  -1,   -1), $00, SpriteSmall, $053, 2, 0, false, true
  .structSpriteEntry (  -3,    4), $00, SpriteSmall, $052, 2, 0, false, false
  .structSpriteEntry (  -3,   -4), $00, SpriteSmall, $051, 2, 0, false, false
  .structSpriteEntry (  -7,   -9), $21, SpriteLarge, $048, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_BowFrame03
  .word 8 ; sprite count
  .structSpriteEntry (  -2,    5), $00, SpriteSmall, $053, 2, 0, false, true
  .structSpriteEntry (  -3,    2), $00, SpriteSmall, $052, 2, 0, false, false
  .structSpriteEntry (  -3,   -6), $00, SpriteSmall, $051, 2, 0, false, false
  .structSpriteEntry (  -7,  -11), $21, SpriteLarge, $048, 2, 0, false, false
  .structSpriteEntry ( -12,   -1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -17), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -9), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -17), $21, SpriteLarge, $020, 2, 0, false, false

_BowFrame04
  .word 7 ; sprite count
  .structSpriteEntry (  -3,    2), $00, SpriteSmall, $052, 2, 0, false, false
  .structSpriteEntry (  -3,   -6), $00, SpriteSmall, $051, 2, 0, false, false
  .structSpriteEntry (  -7,  -10), $21, SpriteLarge, $048, 2, 0, false, false
  .structSpriteEntry ( -12,   -1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -17), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -9), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -17), $21, SpriteLarge, $020, 2, 0, false, false

_BowFrame05
  .word 8 ; sprite count
  .structSpriteEntry (  -3,    1), $00, SpriteSmall, $053, 2, 0, false, true
  .structSpriteEntry (  -5,    3), $00, SpriteSmall, $052, 2, 0, false, false
  .structSpriteEntry (  -5,   -5), $00, SpriteSmall, $051, 2, 0, false, false
  .structSpriteEntry (  -9,   -8), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -13,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   3,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -5,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -13,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_BowFrame06
  .word 8 ; sprite count
  .structSpriteEntry (  -7,    1), $00, SpriteSmall, $053, 2, 0, false, true
  .structSpriteEntry (  -9,    3), $00, SpriteSmall, $052, 2, 0, false, false
  .structSpriteEntry (  -9,   -5), $00, SpriteSmall, $051, 2, 0, false, false
  .structSpriteEntry ( -13,   -8), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -15,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   1,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -15,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -7,   -8), $21, SpriteLarge, $022, 2, 0, false, false

_BowFrame07
  .word 8 ; sprite count
  .structSpriteEntry (  -2,   15), $00, SpriteSmall, $053, 2, 0, false, true
  .structSpriteEntry (  -3,    2), $00, SpriteSmall, $052, 2, 0, false, false
  .structSpriteEntry (  -3,   -6), $00, SpriteSmall, $051, 2, 0, false, false
  .structSpriteEntry (  -7,  -11), $21, SpriteLarge, $048, 2, 0, false, false
  .structSpriteEntry ( -12,   -1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -17), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -9), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -17), $21, SpriteLarge, $020, 2, 0, false, false

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
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 1
  ACTIVE_SPRITE_TABLE_FRAME 3, 5
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 2
  ACTIVE_SPRITE_TABLE_FRAME 1, 6
  ACTIVE_SPRITE_WAIT_STRIKE_DONE
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 1
  ACTIVE_SPRITE_TABLE_FRAME 3, 5
  ACTIVE_SPRITE_SIDE_SCRIPT

_BowRanged
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_TABLE_FRAME 3, 1
  ACTIVE_SPRITE_TABLE_FRAME 32, 2
  ACTIVE_SPRITE_MAP_BATTLE_STRIKE
  ACTIVE_SPRITE_TABLE_FRAME 1, 2
  ACTIVE_SPRITE_TABLE_FRAME 1, 3
  ACTIVE_SPRITE_TABLE_FRAME 1, 7
  ACTIVE_SPRITE_TABLE_FRAME 48, 4
  ACTIVE_SPRITE_WAIT_STRIKE_TAKEN
  ACTIVE_SPRITE_TABLE_FRAME 3, 0
  ACTIVE_SPRITE_END_ROUND
  ACTIVE_SPRITE_SIDE_SCRIPT

  ; not reached by any offset
  ACTIVE_SPRITE_END

_BowUnknown2
  .byte $98, $86, $98, $86, $55, $86, $6B

  MAP_BATTLE_SPRITE_DATA_END $800
