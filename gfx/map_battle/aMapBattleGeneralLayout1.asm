; Map battle sprite data: the format is described in tools/map_battle_layouts.py.

aMapBattleGeneralLayout1

  ; Block offsets by weapon type (sword, lance, axe, bow, staff or tome).
  .word _Sword - aMapBattleGeneralLayout1
  .word _Lance - aMapBattleGeneralLayout1
  .word _Axe - aMapBattleGeneralLayout1
  .word _Bow - aMapBattleGeneralLayout1
  .word _Magic - aMapBattleGeneralLayout1

_Sword
  .word _SwordFrameTable - _Sword
  .word _SwordUnknown2 - _Sword, $8117
  .word _SwordWait - _Sword, $8117
  .word _SwordDodge - _Sword, $8117
  .word _SwordStrike - _Sword, $8117

_SwordFrame00
  .word 7 ; sprite count
  .structSpriteEntry (  -1,   -6), $21, SpriteLarge, $04E, 2, 0, false, false
  .structSpriteEntry (  -6,  -11), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -11,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   5,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -3,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -11,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry ( -10,   -5), $00, SpriteSmall, $040, 2, 0, true, false

_SwordFrame01
  .word 7 ; sprite count
  .structSpriteEntry (  -1,   -6), $21, SpriteLarge, $04E, 2, 0, false, false
  .structSpriteEntry (  -7,  -13), $00, SpriteSmall, $040, 2, 0, false, false
  .structSpriteEntry (  -6,  -11), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -11,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   5,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -3,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -11,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_SwordFrame02
  .word 7 ; sprite count
  .structSpriteEntry (   0,   -6), $21, SpriteLarge, $04E, 2, 0, false, false
  .structSpriteEntry (  -5,  -13), $21, SpriteLarge, $048, 2, 0, false, false
  .structSpriteEntry ( -10,   -1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   6,  -17), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -2,   -9), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -10,  -17), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -3,  -14), $00, SpriteSmall, $040, 2, 0, false, true

_SwordFrame03
  .word 7 ; sprite count
  .structSpriteEntry (   1,   -7), $21, SpriteLarge, $04E, 2, 0, false, false
  .structSpriteEntry (  -4,  -12), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -10,   -1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   6,  -17), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -2,   -9), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -10,  -17), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -8,   -6), $00, SpriteSmall, $040, 2, 0, true, false

_SwordFrame04
  .word 7 ; sprite count
  .structSpriteEntry (   3,   -9), $21, SpriteLarge, $04E, 2, 0, false, false
  .structSpriteEntry (  -2,  -14), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry (  -8,   -3), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   8,  -19), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -8,  -19), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   0,  -11), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (  -5,   -7), $00, SpriteSmall, $040, 2, 0, true, false

_SwordFrameTable
  .word _SwordFrame00 - _Sword
  .word _SwordFrame01 - _Sword
  .word _SwordFrame02 - _Sword
  .word _SwordFrame03 - _Sword
  .word _SwordFrame04 - _Sword

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
  .byte $16, $81, $16, $81, $DF, $80, $6B

_Lance
  .word _LanceFrameTable - _Lance
  .word _LanceUnknown2 - _Lance, $8117
  .word _LanceWait - _Lance, $8117
  .word _LanceDodge - _Lance, $8117
  .word _LanceStrike - _Lance, $8117

_LanceFrame00
  .word 8 ; sprite count
  .structSpriteEntry (  -1,   -6), $21, SpriteLarge, $04E, 2, 0, false, false
  .structSpriteEntry (  -6,  -11), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -11,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   5,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -3,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -11,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -9,  -14), $00, SpriteSmall, $041, 2, 0, true, true
  .structSpriteEntry (  -3,   -6), $00, SpriteSmall, $040, 2, 0, true, true

_LanceFrame01
  .word 8 ; sprite count
  .structSpriteEntry (   0,   -4), $21, SpriteLarge, $04E, 2, 0, false, false
  .structSpriteEntry (  -5,  -11), $21, SpriteLarge, $048, 2, 0, false, false
  .structSpriteEntry ( -10,    1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   6,  -15), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -2,   -7), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -10,  -15), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -6,  -16), $00, SpriteSmall, $041, 2, 0, true, true
  .structSpriteEntry (   0,   -8), $00, SpriteSmall, $040, 2, 0, true, true

_LanceFrame02
  .word 8 ; sprite count
  .structSpriteEntry (  -1,   -6), $21, SpriteLarge, $04E, 2, 0, false, false
  .structSpriteEntry (  -6,  -11), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -11,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   5,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -3,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -11,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry ( -11,  -17), $00, SpriteSmall, $041, 2, 0, true, true
  .structSpriteEntry (  -5,   -9), $00, SpriteSmall, $040, 2, 0, true, true

_LanceFrame03
  .word 6 ; sprite count
  .structSpriteEntry (  -2,   -8), $21, SpriteLarge, $04E, 2, 0, false, false
  .structSpriteEntry (  -7,  -12), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -12,   -1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -17), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -9), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -17), $21, SpriteLarge, $020, 2, 0, false, false

_LanceFrame04
  .word 8 ; sprite count
  .structSpriteEntry (   0,   -7), $21, SpriteLarge, $04E, 2, 0, false, false
  .structSpriteEntry (  -5,  -12), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -11,   -1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   5,  -17), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -3,   -9), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -11,  -17), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -7,  -14), $00, SpriteSmall, $041, 2, 0, true, true
  .structSpriteEntry (  -1,   -6), $00, SpriteSmall, $040, 2, 0, true, true

_LanceFrame05
  .word 8 ; sprite count
  .structSpriteEntry (   2,   -9), $21, SpriteLarge, $04E, 2, 0, false, false
  .structSpriteEntry (  -2,  -14), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry (  -9,   -3), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   7,  -19), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -9,  -19), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -1,  -11), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (  -4,  -16), $00, SpriteSmall, $041, 2, 0, true, true
  .structSpriteEntry (   2,   -8), $00, SpriteSmall, $040, 2, 0, true, true

_LanceFrameTable
  .word _LanceFrame00 - _Lance
  .word _LanceFrame01 - _Lance
  .word _LanceFrame02 - _Lance
  .word _LanceFrame03 - _Lance
  .word _LanceFrame04 - _Lance
  .word _LanceFrame05 - _Lance

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
  .byte $64, $82, $64, $82, $27, $82, $6B

_Axe
  .word _AxeFrameTable - _Axe
  .word _AxeUnknown2 - _Axe, $8117
  .word _AxeWait - _Axe, $8117
  .word _AxeDodge - _Axe, $8117
  .word _AxeStrike - _Axe, $8117

_AxeFrame00
  .word 7 ; sprite count
  .structSpriteEntry (  -1,   -6), $21, SpriteLarge, $04E, 2, 0, false, false
  .structSpriteEntry (  -6,  -11), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -11,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   5,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -3,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -11,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry ( -10,   -3), $00, SpriteSmall, $042, 2, 0, false, false

_AxeFrame01
  .word 7 ; sprite count
  .structSpriteEntry (  -1,   -6), $21, SpriteLarge, $04E, 2, 0, false, false
  .structSpriteEntry (  -6,  -11), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -11,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   5,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -3,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -11,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -7,  -12), $00, SpriteSmall, $040, 2, 0, false, false

_AxeFrame02
  .word 7 ; sprite count
  .structSpriteEntry (   1,   -4), $21, SpriteLarge, $04E, 2, 0, false, false
  .structSpriteEntry (  -5,  -11), $21, SpriteLarge, $048, 2, 0, false, false
  .structSpriteEntry ( -10,    1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   6,  -15), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -2,   -7), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -10,  -15), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -2,  -13), $00, SpriteSmall, $042, 2, 0, true, true

_AxeFrame03
  .word 7 ; sprite count
  .structSpriteEntry (  -9,  -13), $00, SpriteSmall, $040, 2, 0, false, false
  .structSpriteEntry (  -1,   -6), $21, SpriteLarge, $04E, 2, 0, false, false
  .structSpriteEntry (  -6,  -11), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -11,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   5,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -3,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -11,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_AxeFrame04
  .word 6 ; sprite count
  .structSpriteEntry (  -2,   -7), $21, SpriteLarge, $04E, 2, 0, false, false
  .structSpriteEntry (  -7,  -12), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -12,   -1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -17), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -9), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -17), $21, SpriteLarge, $020, 2, 0, false, false

_AxeFrame05
  .word 7 ; sprite count
  .structSpriteEntry (   0,   -7), $21, SpriteLarge, $04E, 2, 0, false, false
  .structSpriteEntry (  -4,  -12), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -10,   -1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   6,  -17), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -2,   -9), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -10,  -17), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -8,   -4), $00, SpriteSmall, $042, 2, 0, false, false

_AxeFrame06
  .word 7 ; sprite count
  .structSpriteEntry (   3,   -8), $21, SpriteLarge, $04E, 2, 0, false, false
  .structSpriteEntry (  -1,  -14), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry (  -8,   -3), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   8,  -19), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -8,  -19), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   0,  -11), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (  -5,   -6), $00, SpriteSmall, $042, 2, 0, false, false

_AxeFrame07
  .word 7 ; sprite count
  .structSpriteEntry (  -1,   -6), $21, SpriteLarge, $04E, 2, 0, false, false
  .structSpriteEntry ( -12,  -14), $00, SpriteSmall, $042, 2, 0, false, false
  .structSpriteEntry (  -6,  -11), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -11,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   5,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -3,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -11,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_AxeFrame08
  .word 7 ; sprite count
  .structSpriteEntry ( -14,  -19), $00, SpriteSmall, $040, 2, 0, true, true
  .structSpriteEntry (  -2,   -7), $21, SpriteLarge, $04E, 2, 0, false, false
  .structSpriteEntry (  -7,  -12), $21, SpriteLarge, $044, 2, 0, false, false
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
  ACTIVE_SPRITE_TABLE_FRAME 32, 2
  ACTIVE_SPRITE_TABLE_FRAME 3, 3
  ACTIVE_SPRITE_TABLE_FRAME 1, 7
  ACTIVE_SPRITE_MAP_BATTLE_STRIKE
  ACTIVE_SPRITE_TABLE_FRAME 1, 7
  ACTIVE_SPRITE_TABLE_FRAME 2, 8
  ACTIVE_SPRITE_TABLE_FRAME 48, 4
  ACTIVE_SPRITE_WAIT_STRIKE_TAKEN
  ACTIVE_SPRITE_TABLE_FRAME 3, 0
  ACTIVE_SPRITE_END_ROUND
  ACTIVE_SPRITE_SIDE_SCRIPT

  ; not reached by any offset
  ACTIVE_SPRITE_END

_AxeUnknown2
  .byte $17, $84, $17, $84, $D1, $83, $6B

_Bow
  .word _BowFrameTable - _Bow
  .word _BowUnknown2 - _Bow, $8117
  .word _BowWait - _Bow, $8117
  .word _BowDodge - _Bow, $8117
  .word _BowStrike - _Bow, $8117

_BowFrame00
  .word 8 ; sprite count
  .structSpriteEntry (  -8,   -8), $00, SpriteSmall, $043, 2, 0, false, true
  .structSpriteEntry (  -8,  -10), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -11,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   5,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -3,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -11,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -7,  -12), $00, SpriteSmall, $041, 2, 0, false, true
  .structSpriteEntry (  -7,   -4), $00, SpriteSmall, $040, 2, 0, false, true

_BowFrame01
  .word 8 ; sprite count
  .structSpriteEntry (  -7,   -8), $00, SpriteSmall, $043, 2, 0, false, true
  .structSpriteEntry (  -8,  -10), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -11,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   5,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -3,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -11,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -8,  -13), $00, SpriteSmall, $041, 2, 0, false, true
  .structSpriteEntry (  -8,   -5), $00, SpriteSmall, $040, 2, 0, false, true

_BowFrame02
  .word 8 ; sprite count
  .structSpriteEntry (  -6,   -8), $00, SpriteSmall, $043, 2, 0, false, true
  .structSpriteEntry (  -8,  -10), $21, SpriteLarge, $048, 2, 0, false, false
  .structSpriteEntry ( -11,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   5,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -3,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -11,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -7,   -6), $00, SpriteSmall, $040, 2, 0, false, true
  .structSpriteEntry (  -7,  -14), $00, SpriteSmall, $041, 2, 0, false, true

_BowFrame03
  .word 8 ; sprite count
  .structSpriteEntry (  -8,  -10), $00, SpriteSmall, $043, 2, 0, false, true
  .structSpriteEntry (  -6,   -9), $21, SpriteLarge, $048, 2, 0, false, false
  .structSpriteEntry ( -10,    1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   6,  -15), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -2,   -7), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -10,  -15), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -6,   -6), $00, SpriteSmall, $040, 2, 0, false, true
  .structSpriteEntry (  -6,  -14), $00, SpriteSmall, $041, 2, 0, false, true

_BowFrame04
  .word 7 ; sprite count
  .structSpriteEntry (  -7,   -9), $21, SpriteLarge, $048, 2, 0, false, false
  .structSpriteEntry ( -10,    1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   6,  -15), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -2,   -7), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -10,  -15), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -6,   -6), $00, SpriteSmall, $040, 2, 0, false, true
  .structSpriteEntry (  -6,  -14), $00, SpriteSmall, $041, 2, 0, false, true

_BowFrame05
  .word 8 ; sprite count
  .structSpriteEntry (  -7,  -10), $00, SpriteSmall, $043, 2, 0, true, false
  .structSpriteEntry (  -6,  -11), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry ( -10,   -1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   6,  -17), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -2,   -9), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -10,  -17), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -6,  -13), $00, SpriteSmall, $041, 2, 0, false, true
  .structSpriteEntry (  -6,   -5), $00, SpriteSmall, $040, 2, 0, false, true

_BowFrame06
  .word 8 ; sprite count
  .structSpriteEntry (  -4,  -12), $00, SpriteSmall, $043, 2, 0, true, false
  .structSpriteEntry (  -3,  -13), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry (  -8,   -3), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   8,  -19), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -8,  -19), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   0,  -11), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (  -3,  -15), $00, SpriteSmall, $041, 2, 0, false, true
  .structSpriteEntry (  -3,   -7), $00, SpriteSmall, $040, 2, 0, false, true

_BowFrame07
  .word 8 ; sprite count
  .structSpriteEntry ( -13,  -15), $00, SpriteSmall, $043, 2, 0, false, true
  .structSpriteEntry (  -7,   -9), $21, SpriteLarge, $048, 2, 0, false, false
  .structSpriteEntry ( -10,    1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   6,  -15), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -2,   -7), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -10,  -15), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -6,   -6), $00, SpriteSmall, $040, 2, 0, false, true
  .structSpriteEntry (  -6,  -14), $00, SpriteSmall, $041, 2, 0, false, true

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
  ACTIVE_SPRITE_TABLE_FRAME 1, 3
  ACTIVE_SPRITE_MAP_BATTLE_STRIKE
  ACTIVE_SPRITE_TABLE_FRAME 1, 3
  ACTIVE_SPRITE_TABLE_FRAME 2, 7
  ACTIVE_SPRITE_TABLE_FRAME 48, 4
  ACTIVE_SPRITE_WAIT_STRIKE_TAKEN
  ACTIVE_SPRITE_TABLE_FRAME 3, 0
  ACTIVE_SPRITE_END_ROUND
  ACTIVE_SPRITE_SIDE_SCRIPT

  ; not reached by any offset
  ACTIVE_SPRITE_END

_BowUnknown2
  .byte $C8, $85, $C8, $85, $85, $85, $6B

_Magic
  .word _MagicFrameTable - _Magic
  .word _MagicUnknown2 - _Magic, $8117
  .word _MagicWait - _Magic, $8117
  .word _MagicDodge - _Magic, $8117
  .word _MagicStrike - _Magic, $8117

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
  .structSpriteEntry (  -3,   -7), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -11,    1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   5,  -15), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -11,  -15), $21, SpriteLarge, $020, 2, 0, false, false

_MagicFrame04
  .word 4 ; sprite count
  .structSpriteEntry (  -1,   -5), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (  -9,    3), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   7,  -13), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -9,  -13), $21, SpriteLarge, $020, 2, 0, false, false

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
  .byte $90, $86, $90, $86, $53, $86, $6B

  MAP_BATTLE_SPRITE_DATA_END $880
