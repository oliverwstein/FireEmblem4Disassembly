; Map battle sprite data: the format is described in tools/map_battle_layouts.py.

aMapBattleSoldierLayout0

  ; Block offsets by weapon type (sword, lance, axe, bow, staff or tome).
  .word _Sword - aMapBattleSoldierLayout0
  .word _Lance - aMapBattleSoldierLayout0
  .word _Axe - aMapBattleSoldierLayout0
  .word _Bow - aMapBattleSoldierLayout0
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
  .structSpriteEntry ( -11,    0), $00, SpriteSmall, $040, 2, 0, true, true
  .structSpriteEntry (  -7,   -9), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -11,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   5,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -3,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -11,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_SwordFrame01
  .word 6 ; sprite count
  .structSpriteEntry ( -10,   -9), $00, SpriteSmall, $040, 2, 0, true, false
  .structSpriteEntry (  -7,   -9), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -11,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   5,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -3,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -11,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_SwordFrame02
  .word 6 ; sprite count
  .structSpriteEntry (  -5,  -11), $21, SpriteLarge, $048, 2, 0, false, false
  .structSpriteEntry ( -10,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   6,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -2,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -10,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -2,  -14), $00, SpriteSmall, $040, 2, 0, false, false

_SwordFrame03
  .word 6 ; sprite count
  .structSpriteEntry ( -11,   -1), $00, SpriteSmall, $040, 2, 0, true, true
  .structSpriteEntry (  -7,  -10), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -11,   -1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   5,  -17), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -3,   -9), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -11,  -17), $21, SpriteLarge, $020, 2, 0, false, false

_SwordFrame04
  .word 6 ; sprite count
  .structSpriteEntry ( -13,   -3), $00, SpriteSmall, $040, 2, 0, true, true
  .structSpriteEntry (  -9,  -12), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -11,   -3), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   5,  -19), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -11,  -19), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -3,  -11), $21, SpriteLarge, $022, 2, 0, false, false

_SwordFrame05
  .word 6 ; sprite count
  .structSpriteEntry ( -11,   -9), $00, SpriteSmall, $041, 2, 0, false, false
  .structSpriteEntry (  -8,   -9), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false

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
  .structSpriteEntry ( -13,   -6), $00, SpriteSmall, $041, 2, 0, true, false
  .structSpriteEntry (  -7,  -14), $00, SpriteSmall, $040, 2, 0, true, false
  .structSpriteEntry (  -9,   -9), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_LanceFrame01
  .word 7 ; sprite count
  .structSpriteEntry (  -6,  -11), $21, SpriteLarge, $048, 2, 0, false, false
  .structSpriteEntry ( -11,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   5,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -3,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -11,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -1,  -13), $00, SpriteSmall, $043, 2, 0, false, true
  .structSpriteEntry (  -9,  -13), $00, SpriteSmall, $042, 2, 0, false, true

_LanceFrame02
  .word 7 ; sprite count
  .structSpriteEntry ( -15,   -7), $00, SpriteSmall, $043, 2, 0, false, true
  .structSpriteEntry ( -23,   -7), $00, SpriteSmall, $042, 2, 0, false, true
  .structSpriteEntry (  -9,   -9), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_LanceFrame03
  .word 5 ; sprite count
  .structSpriteEntry (  -8,   -9), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -13,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   3,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -5,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -13,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_LanceFrame04
  .word 7 ; sprite count
  .structSpriteEntry ( -13,   -7), $00, SpriteSmall, $041, 2, 0, true, false
  .structSpriteEntry (  -7,  -15), $00, SpriteSmall, $040, 2, 0, true, false
  .structSpriteEntry (  -9,  -10), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -12,   -1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -17), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -9), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -17), $21, SpriteLarge, $020, 2, 0, false, false

_LanceFrame05
  .word 7 ; sprite count
  .structSpriteEntry ( -15,   -9), $00, SpriteSmall, $041, 2, 0, true, false
  .structSpriteEntry (  -9,  -17), $00, SpriteSmall, $040, 2, 0, true, false
  .structSpriteEntry ( -11,  -12), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -12,   -3), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -19), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,  -19), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -4,  -11), $21, SpriteLarge, $022, 2, 0, false, false

_LanceFrame06
  .word 7 ; sprite count
  .structSpriteEntry (  -8,  -10), $00, SpriteSmall, $041, 2, 0, true, false
  .structSpriteEntry (  -2,  -18), $00, SpriteSmall, $040, 2, 0, true, false
  .structSpriteEntry (  -6,  -11), $21, SpriteLarge, $048, 2, 0, false, false
  .structSpriteEntry ( -11,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   5,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -3,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -11,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_LanceFrame07
  .word 7 ; sprite count
  .structSpriteEntry ( -18,   -2), $00, SpriteSmall, $041, 2, 0, true, false
  .structSpriteEntry ( -12,  -10), $00, SpriteSmall, $040, 2, 0, true, false
  .structSpriteEntry ( -11,   -9), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -13,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   3,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -5,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -13,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_LanceFrame08
  .word 7 ; sprite count
  .structSpriteEntry ( -16,   -4), $00, SpriteSmall, $041, 2, 0, true, false
  .structSpriteEntry ( -10,  -12), $00, SpriteSmall, $040, 2, 0, true, false
  .structSpriteEntry ( -11,   -9), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -14,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   2,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -6,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -14,  -16), $21, SpriteLarge, $020, 2, 0, false, false

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
  ACTIVE_SPRITE_TABLE_FRAME 20, 6
  ACTIVE_SPRITE_MAP_BATTLE_STRIKE
  ACTIVE_SPRITE_TABLE_FRAME 1, 6
  ACTIVE_SPRITE_TABLE_FRAME 2, 7
  ACTIVE_SPRITE_TABLE_FRAME 48, 8
  ACTIVE_SPRITE_WAIT_STRIKE_TAKEN
  ACTIVE_SPRITE_TABLE_FRAME 3, 0
  ACTIVE_SPRITE_END_ROUND
  ACTIVE_SPRITE_SIDE_SCRIPT

_LanceRanged
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_TABLE_FRAME 20, 1
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
  .byte $FF, $82, $FF, $82, $AA, $82, $6B

_Axe
  .word _AxeFrameTable - _Axe
  .word _AxeUnknown2 - _Axe, $813F
  .word _AxeWait - _Axe, $813F
  .word _AxeDodge - _Axe, $813F
  .word _AxeStrike - _Axe, $813F
  .word _AxeRanged - _Axe, $813F

_AxeFrame00
  .word 6 ; sprite count
  .structSpriteEntry ( -12,   -2), $00, SpriteSmall, $042, 2, 0, false, false
  .structSpriteEntry (  -7,   -9), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -11,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   5,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -3,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -11,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_AxeFrame01
  .word 6 ; sprite count
  .structSpriteEntry (  -7,   -9), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -11,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   5,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -3,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -11,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -8,  -11), $00, SpriteSmall, $040, 2, 0, false, false

_AxeFrame02
  .word 6 ; sprite count
  .structSpriteEntry (  -5,  -11), $21, SpriteLarge, $048, 2, 0, false, false
  .structSpriteEntry ( -10,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   6,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -2,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -10,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   0,  -11), $00, SpriteSmall, $042, 2, 0, true, true

_AxeFrame03
  .word 6 ; sprite count
  .structSpriteEntry ( -14,   -5), $00, SpriteSmall, $040, 2, 0, false, false
  .structSpriteEntry (  -7,   -9), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -11,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   5,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -3,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -11,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_AxeFrame04
  .word 5 ; sprite count
  .structSpriteEntry (  -8,   -9), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_AxeFrame05
  .word 6 ; sprite count
  .structSpriteEntry ( -12,   -3), $00, SpriteSmall, $042, 2, 0, false, false
  .structSpriteEntry (  -7,  -10), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -11,   -1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   5,  -17), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -3,   -9), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -11,  -17), $21, SpriteLarge, $020, 2, 0, false, false

_AxeFrame06
  .word 6 ; sprite count
  .structSpriteEntry ( -14,   -5), $00, SpriteSmall, $042, 2, 0, false, false
  .structSpriteEntry (  -9,  -12), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -11,   -3), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   5,  -19), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -11,  -19), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -3,  -11), $21, SpriteLarge, $022, 2, 0, false, false

_AxeFrame07
  .word 6 ; sprite count
  .structSpriteEntry ( -13,   -9), $00, SpriteSmall, $041, 2, 0, false, false
  .structSpriteEntry (  -9,   -9), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -13,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   3,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -5,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -13,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_AxeFrame08
  .word 6 ; sprite count
  .structSpriteEntry ( -13,    1), $00, SpriteSmall, $040, 2, 0, true, true
  .structSpriteEntry ( -10,   -9), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -14,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   2,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -6,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -14,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_AxeFrame09
  .word 6 ; sprite count
  .structSpriteEntry ( -19,   -5), $00, SpriteSmall, $042, 2, 0, false, false
  .structSpriteEntry (  -7,   -9), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -11,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   5,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -3,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -11,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_AxeFrame0A
  .word 6 ; sprite count
  .structSpriteEntry ( -24,   -5), $00, SpriteSmall, $040, 2, 0, true, true
  .structSpriteEntry (  -8,   -9), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false

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
  .byte $E8, $84, $E8, $84, $87, $84, $6B

_Bow
  .word _BowFrameTable - _Bow
  .word _BowUnknown2 - _Bow, $813F
  .word _BowWait - _Bow, $813F
  .word _BowDodge - _Bow, $813F
  .word $813F, $813F
  .word _BowRanged - _Bow, $813F

_BowFrame00
  .word 8 ; sprite count
  .structSpriteEntry (  -7,   -4), $00, SpriteSmall, $042, 2, 0, false, false
  .structSpriteEntry (  -8,    0), $00, SpriteSmall, $050, 2, 0, false, true
  .structSpriteEntry (  -8,   -8), $00, SpriteSmall, $050, 2, 0, false, false
  .structSpriteEntry (  -7,  -10), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -11,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   5,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -3,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -11,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_BowFrame01
  .word 8 ; sprite count
  .structSpriteEntry (  -6,   -5), $00, SpriteSmall, $042, 2, 0, false, false
  .structSpriteEntry (  -8,   -1), $00, SpriteSmall, $050, 2, 0, false, true
  .structSpriteEntry (  -8,   -9), $00, SpriteSmall, $050, 2, 0, false, false
  .structSpriteEntry (  -7,  -10), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -11,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   5,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -3,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -11,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_BowFrame02
  .word 8 ; sprite count
  .structSpriteEntry (  -6,   -7), $00, SpriteSmall, $042, 2, 0, false, false
  .structSpriteEntry (  -9,   -3), $00, SpriteSmall, $050, 2, 0, false, true
  .structSpriteEntry (  -9,  -11), $00, SpriteSmall, $050, 2, 0, false, false
  .structSpriteEntry (  -8,  -10), $21, SpriteLarge, $04A, 2, 0, false, false
  .structSpriteEntry ( -11,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   5,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -3,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -11,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_BowFrame03
  .word 8 ; sprite count
  .structSpriteEntry ( -13,   -7), $00, SpriteSmall, $042, 2, 0, false, false
  .structSpriteEntry (  -8,   -3), $00, SpriteSmall, $050, 2, 0, false, true
  .structSpriteEntry (  -8,  -11), $00, SpriteSmall, $050, 2, 0, false, false
  .structSpriteEntry (  -6,  -10), $21, SpriteLarge, $04A, 2, 0, false, false
  .structSpriteEntry ( -10,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   6,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -2,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -10,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_BowFrame04
  .word 7 ; sprite count
  .structSpriteEntry (  -8,   -3), $00, SpriteSmall, $050, 2, 0, false, true
  .structSpriteEntry (  -8,  -11), $00, SpriteSmall, $050, 2, 0, false, false
  .structSpriteEntry (  -7,  -10), $21, SpriteLarge, $04A, 2, 0, false, false
  .structSpriteEntry ( -10,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   6,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -2,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -10,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_BowFrame05
  .word 8 ; sprite count
  .structSpriteEntry (  -8,   -4), $00, SpriteSmall, $042, 2, 0, false, false
  .structSpriteEntry (  -9,    0), $00, SpriteSmall, $050, 2, 0, false, true
  .structSpriteEntry (  -9,   -8), $00, SpriteSmall, $050, 2, 0, false, false
  .structSpriteEntry (  -8,  -10), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -11,   -1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   5,  -17), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -3,   -9), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -11,  -17), $21, SpriteLarge, $020, 2, 0, false, false

_BowFrame06
  .word 8 ; sprite count
  .structSpriteEntry (  -9,   -6), $00, SpriteSmall, $042, 2, 0, false, false
  .structSpriteEntry ( -10,   -2), $00, SpriteSmall, $050, 2, 0, false, true
  .structSpriteEntry ( -10,  -10), $00, SpriteSmall, $050, 2, 0, false, false
  .structSpriteEntry (  -9,  -12), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -11,   -3), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   5,  -19), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -11,  -19), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -3,  -11), $21, SpriteLarge, $022, 2, 0, false, false

_BowFrame07
  .word 8 ; sprite count
  .structSpriteEntry ( -23,   -7), $00, SpriteSmall, $042, 2, 0, false, false
  .structSpriteEntry (  -8,   -3), $00, SpriteSmall, $050, 2, 0, false, true
  .structSpriteEntry (  -8,  -11), $00, SpriteSmall, $050, 2, 0, false, false
  .structSpriteEntry (  -6,  -10), $21, SpriteLarge, $04A, 2, 0, false, false
  .structSpriteEntry ( -10,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   6,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -2,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -10,  -16), $21, SpriteLarge, $020, 2, 0, false, false

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
  .byte $9D, $86, $9D, $86, $5A, $86, $6B

  MAP_BATTLE_SPRITE_DATA_END $800
