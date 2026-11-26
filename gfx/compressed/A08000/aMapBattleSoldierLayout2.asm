; Map battle sprite data: the format is described in tools/map_battle_layouts.py.

aMapBattleSoldierLayout2

  ; Block offsets by weapon type (sword, lance, axe, bow, staff or tome).
  .word _Sword - aMapBattleSoldierLayout2
  .word _Lance - aMapBattleSoldierLayout2
  .word _Axe - aMapBattleSoldierLayout2
  .word _Bow - aMapBattleSoldierLayout2
  .word $813F ; no magic block

_Sword
  .word _SwordFrameTable - _Sword
  .word _SwordUnknown2 - _Sword, $813F
  .word _SwordWait - _Sword, $813F
  .word _SwordDodge - _Sword, $813F
  .word _SwordStrike - _Sword, $813F
  .word _SwordRanged - _Sword, $813F

_SwordFrame00
  .word 6 ; sprite count
  .structSpriteEntry (  -7,   -8), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   0,   -1), $00, SpriteSmall, $042, 2, 0, false, true

_SwordFrame01
  .word 6 ; sprite count
  .structSpriteEntry (  -7,   -9), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   0,  -13), $00, SpriteSmall, $042, 2, 0, false, false

_SwordFrame02
  .word 6 ; sprite count
  .structSpriteEntry (   0,   -6), $00, SpriteSmall, $043, 2, 0, false, true
  .structSpriteEntry (  -7,   -9), $21, SpriteLarge, $048, 2, 0, false, false
  .structSpriteEntry ( -12,    1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -15), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -7), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $020, 2, 0, false, false

_SwordFrame03
  .word 6 ; sprite count
  .structSpriteEntry (  -5,   -8), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -11,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   5,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -3,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -11,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   2,   -1), $00, SpriteSmall, $042, 2, 0, false, true

_SwordFrame04
  .word 6 ; sprite count
  .structSpriteEntry (  -3,   -8), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry (  -9,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   7,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -9,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -1,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   4,   -1), $00, SpriteSmall, $042, 2, 0, false, true

_SwordFrame05
  .word 6 ; sprite count
  .structSpriteEntry (  -7,  -10), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -12,   -1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -17), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -9), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -17), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   0,  -15), $00, SpriteSmall, $050, 2, 0, false, false

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
  .byte $3E, $81, $3E, $81, $EC, $80, $6B

_Lance
  .word _LanceFrameTable - _Lance
  .word _LanceUnknown2 - _Lance, $813F
  .word _LanceWait - _Lance, $813F
  .word _LanceDodge - _Lance, $813F
  .word _LanceStrike - _Lance, $813F
  .word _LanceRanged - _Lance, $813F

_LanceFrame00
  .word 7 ; sprite count
  .structSpriteEntry (   0,   -3), $00, SpriteSmall, $053, 2, 0, false, false
  .structSpriteEntry (   0,  -11), $00, SpriteSmall, $052, 2, 0, false, false
  .structSpriteEntry (  -7,   -9), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_LanceFrame01
  .word 7 ; sprite count
  .structSpriteEntry (   0,   -1), $00, SpriteSmall, $053, 2, 0, false, false
  .structSpriteEntry (   0,   -9), $00, SpriteSmall, $052, 2, 0, false, false
  .structSpriteEntry (  -7,   -9), $21, SpriteLarge, $048, 2, 0, false, false
  .structSpriteEntry ( -12,    1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -15), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -7), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $020, 2, 0, false, false

_LanceFrame02
  .word 7 ; sprite count
  .structSpriteEntry (   0,  -13), $00, SpriteSmall, $053, 2, 0, false, false
  .structSpriteEntry (   0,  -21), $00, SpriteSmall, $052, 2, 0, false, false
  .structSpriteEntry (  -7,   -9), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_LanceFrame03
  .word 5 ; sprite count
  .structSpriteEntry (  -7,  -10), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -12,   -1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -17), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -9), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -17), $21, SpriteLarge, $020, 2, 0, false, false

_LanceFrame04
  .word 7 ; sprite count
  .structSpriteEntry (   2,   -3), $00, SpriteSmall, $053, 2, 0, false, false
  .structSpriteEntry (   2,  -11), $00, SpriteSmall, $052, 2, 0, false, false
  .structSpriteEntry (  -5,   -9), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -11,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   5,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -11,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -3,   -8), $21, SpriteLarge, $022, 2, 0, false, false

_LanceFrame05
  .word 7 ; sprite count
  .structSpriteEntry (   6,   -2), $00, SpriteSmall, $053, 2, 0, false, false
  .structSpriteEntry (   6,  -10), $00, SpriteSmall, $052, 2, 0, false, false
  .structSpriteEntry (  -2,   -9), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry (  -9,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   7,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -9,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -1,   -8), $21, SpriteLarge, $022, 2, 0, false, false

_LanceFrame06
  .word 7 ; sprite count
  .structSpriteEntry (   0,  -12), $00, SpriteSmall, $053, 2, 0, false, false
  .structSpriteEntry (   0,  -20), $00, SpriteSmall, $052, 2, 0, false, false
  .structSpriteEntry (  -7,  -12), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -12,   -1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -17), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -9), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -17), $21, SpriteLarge, $020, 2, 0, false, false

_LanceFrame07
  .word 7 ; sprite count
  .structSpriteEntry (   0,  -10), $00, SpriteSmall, $053, 2, 0, false, false
  .structSpriteEntry (   0,  -18), $00, SpriteSmall, $052, 2, 0, false, false
  .structSpriteEntry (  -7,  -13), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -12,   -3), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -19), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,  -11), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -19), $21, SpriteLarge, $020, 2, 0, false, false

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
  .byte $D8, $82, $D8, $82, $83, $82, $6B

_Axe
  .word _AxeFrameTable - _Axe
  .word _AxeUnknown2 - _Axe, $813F
  .word _AxeWait - _Axe, $813F
  .word _AxeDodge - _Axe, $813F
  .word _AxeStrike - _Axe, $813F
  .word _AxeRanged - _Axe, $813F

_AxeFrame00
  .word 6 ; sprite count
  .structSpriteEntry (  -7,   -8), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   2,   -4), $00, SpriteSmall, $042, 2, 0, true, false

_AxeFrame01
  .word 6 ; sprite count
  .structSpriteEntry (  -2,  -14), $00, SpriteSmall, $040, 2, 0, true, false
  .structSpriteEntry (  -7,   -9), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_AxeFrame02
  .word 6 ; sprite count
  .structSpriteEntry (  -4,   -9), $00, SpriteSmall, $042, 2, 0, false, true
  .structSpriteEntry (  -7,   -9), $21, SpriteLarge, $048, 2, 0, false, false
  .structSpriteEntry ( -12,    1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -15), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -7), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $020, 2, 0, false, false

_AxeFrame03
  .word 6 ; sprite count
  .structSpriteEntry (  -3,  -16), $00, SpriteSmall, $040, 2, 0, true, false
  .structSpriteEntry (  -7,   -9), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_AxeFrame04
  .word 5 ; sprite count
  .structSpriteEntry (  -7,   -9), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -12,   -1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -17), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -9), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -17), $21, SpriteLarge, $020, 2, 0, false, false

_AxeFrame05
  .word 6 ; sprite count
  .structSpriteEntry (  -6,   -8), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -11,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   5,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -11,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -3,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   3,   -4), $00, SpriteSmall, $042, 2, 0, true, false

_AxeFrame06
  .word 6 ; sprite count
  .structSpriteEntry (  -9,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (  -3,   -8), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry (   7,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -9,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -1,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   6,   -4), $00, SpriteSmall, $042, 2, 0, true, false

_AxeFrame07
  .word 6 ; sprite count
  .structSpriteEntry (   0,  -15), $00, SpriteSmall, $043, 2, 0, false, false
  .structSpriteEntry (  -7,   -9), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -12,   -1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -17), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -9), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -17), $21, SpriteLarge, $020, 2, 0, false, false

_AxeFrame08
  .word 6 ; sprite count
  .structSpriteEntry (  -7,  -12), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -12,   -3), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -19), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,  -11), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -19), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   1,   -7), $00, SpriteSmall, $042, 2, 0, true, false

_AxeFrame09
  .word 6 ; sprite count
  .structSpriteEntry (  -3,  -20), $00, SpriteSmall, $042, 2, 0, true, false
  .structSpriteEntry (  -7,   -9), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_AxeFrame0A
  .word 6 ; sprite count
  .structSpriteEntry (  -3,  -26), $00, SpriteSmall, $040, 2, 0, false, true
  .structSpriteEntry (  -7,   -9), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -12,   -1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -17), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -9), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -17), $21, SpriteLarge, $020, 2, 0, false, false

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
  .byte $C1, $84, $C1, $84, $60, $84, $6B

_Bow
  .word _BowFrameTable - _Bow
  .word _BowUnknown2 - _Bow, $813F
  .word _BowWait - _Bow, $813F
  .word _BowDodge - _Bow, $813F
  .word _BowStrike - _Bow, $813F
  .word _BowStrike - _Bow, $813F

_BowFrame00
  .word 6 ; sprite count
  .structSpriteEntry (  -8,  -10), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -3,  -13), $00, SpriteSmall, $052, 2, 0, false, true

_BowFrame01
  .word 6 ; sprite count
  .structSpriteEntry (  -8,  -10), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -3,  -13), $00, SpriteSmall, $052, 2, 0, false, true

_BowFrame02
  .word 6 ; sprite count
  .structSpriteEntry (  -8,  -10), $21, SpriteLarge, $048, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -3,  -14), $00, SpriteSmall, $052, 2, 0, false, true

_BowFrame03
  .word 7 ; sprite count
  .structSpriteEntry (  -5,  -16), $00, SpriteSmall, $053, 2, 0, false, false
  .structSpriteEntry (  -8,   -8), $21, SpriteLarge, $048, 2, 0, false, false
  .structSpriteEntry ( -12,    1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -15), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -7), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -3,  -14), $00, SpriteSmall, $052, 2, 0, false, true

_BowFrame04
  .word 6 ; sprite count
  .structSpriteEntry (  -8,   -9), $21, SpriteLarge, $048, 2, 0, false, false
  .structSpriteEntry ( -12,    1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -15), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -7), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -3,  -14), $00, SpriteSmall, $052, 2, 0, false, true

_BowFrame05
  .word 6 ; sprite count
  .structSpriteEntry (  -6,  -10), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -11,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   5,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -3,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -11,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -1,  -13), $00, SpriteSmall, $052, 2, 0, false, true

_BowFrame06
  .word 6 ; sprite count
  .structSpriteEntry (  -3,  -10), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry (  -9,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   7,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -9,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -1,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   2,  -13), $00, SpriteSmall, $052, 2, 0, false, true

_BowFrame07
  .word 7 ; sprite count
  .structSpriteEntry (  -5,  -24), $00, SpriteSmall, $053, 2, 0, false, false
  .structSpriteEntry (  -8,   -8), $21, SpriteLarge, $048, 2, 0, false, false
  .structSpriteEntry ( -12,    1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -15), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -7), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -3,  -14), $00, SpriteSmall, $052, 2, 0, false, true

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

_BowStrike
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
  .byte $35, $86, $35, $86, $F2, $85, $6B

  MAP_BATTLE_SPRITE_DATA_END $800
