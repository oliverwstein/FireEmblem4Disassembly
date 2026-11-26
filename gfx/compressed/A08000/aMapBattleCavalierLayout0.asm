; Map battle sprite data: the format is described in tools/map_battle_layouts.py.

aMapBattleCavalierLayout0

  ; Block offsets by weapon type (sword, lance, axe, bow, staff or tome).
  .word _Sword - aMapBattleCavalierLayout0
  .word _Lance - aMapBattleCavalierLayout0
  .word _Axe - aMapBattleCavalierLayout0
  .word _Bow - aMapBattleCavalierLayout0
  .word _Magic - aMapBattleCavalierLayout0

_Sword
  .word _SwordFrameTable - _Sword
  .word _SwordUnknown2 - _Sword, _SwordUnknown4 - _Sword
  .word _SwordWait - _Sword, _SwordWaitAux - _Sword
  .word _SwordDodge - _Sword, _SwordDodgeAux - _Sword
  .word _SwordStrike - _Sword, _SwordStrikeAux - _Sword
  .word _SwordRanged - _Sword, _SwordRangedAux - _Sword

_SwordFrame00
  .word 6 ; sprite count
  .structSpriteEntry (   0,   -8), $21, SpriteLarge, $026, 2, 0, false, false
  .structSpriteEntry ( -16,   -8), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry (   0,  -24), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -16,  -24), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   0,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_SwordFrame01
  .word 6 ; sprite count
  .structSpriteEntry ( -16,  -26), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   0,  -10), $21, SpriteLarge, $026, 2, 0, false, false
  .structSpriteEntry ( -16,  -10), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry (   0,  -26), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   0,   -2), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,   -2), $00, SpriteSmall, $01E, 2, 0, false, false

_SwordFrame02
  .word 6 ; sprite count
  .structSpriteEntry (   0,  -13), $21, SpriteLarge, $026, 2, 0, false, false
  .structSpriteEntry ( -16,  -13), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry (   0,  -29), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -16,  -29), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   0,   -5), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,   -5), $00, SpriteSmall, $01E, 2, 0, false, false

_SwordFrame03
  .word 2 ; sprite count
  .structSpriteEntry (  -9,   -4), $00, SpriteSmall, $020, 2, 0, true, true
  .structSpriteEntry (  -7,  -14), $21, SpriteLarge, $028, 2, 0, false, false

_SwordFrame04
  .word 2 ; sprite count
  .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $020, 2, 0, true, false
  .structSpriteEntry (  -9,  -14), $21, SpriteLarge, $026, 2, 0, false, false

_SwordFrame05
  .word 2 ; sprite count
  .structSpriteEntry (  -9,  -14), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry (  -6,  -17), $00, SpriteSmall, $020, 2, 0, false, false

_SwordFrame06
  .word 2 ; sprite count
  .structSpriteEntry ( -11,  -16), $00, SpriteSmall, $021, 2, 0, false, false
  .structSpriteEntry (  -9,  -14), $21, SpriteLarge, $026, 2, 0, false, false

_SwordFrame07
  .word 2 ; sprite count
  .structSpriteEntry ( -11,  -13), $00, SpriteSmall, $020, 2, 0, true, true
  .structSpriteEntry (  -9,  -21), $21, SpriteLarge, $02A, 2, 0, false, false

_SwordFrameTable
  .word _SwordFrame00 - _Sword
  .word _SwordFrame01 - _Sword
  .word _SwordFrame02 - _Sword
  .word _SwordFrame03 - _Sword
  .word _SwordFrame04 - _Sword
  .word _SwordFrame05 - _Sword
  .word _SwordFrame06 - _Sword
  .word _SwordFrame07 - _Sword

_SwordWait
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_WAIT_ROUND
  ACTIVE_SPRITE_ROUND_SCRIPT

_SwordWaitAux
  ACTIVE_SPRITE_TABLE_FRAME 1, 3
  ACTIVE_SPRITE_WAIT_ROUND
  ACTIVE_SPRITE_AUX_ROUND_SCRIPT

_SwordDodge
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_WAIT_STRIKE
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 1
  ACTIVE_SPRITE_TABLE_FRAME 3, 1
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 2
  ACTIVE_SPRITE_TABLE_FRAME 1, 2
  ACTIVE_SPRITE_WAIT_STRIKE_DONE
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 1
  ACTIVE_SPRITE_TABLE_FRAME 3, 1
  ACTIVE_SPRITE_SIDE_SCRIPT

_SwordDodgeAux
  ACTIVE_SPRITE_TABLE_FRAME 1, 3
  ACTIVE_SPRITE_WAIT_STRIKE
  ACTIVE_SPRITE_TABLE_FRAME 3, 3
  ACTIVE_SPRITE_TABLE_FRAME 1, 7
  ACTIVE_SPRITE_WAIT_STRIKE_DONE
  ACTIVE_SPRITE_TABLE_FRAME 3, 3
  ACTIVE_SPRITE_SIDE_AUX_SCRIPT

_SwordStrike
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_TABLE_FRAME 3, 0
  ACTIVE_SPRITE_TABLE_FRAME 32, 0
  ACTIVE_SPRITE_TABLE_FRAME 3, 0
  ACTIVE_SPRITE_TABLE_FRAME 48, 0
  ACTIVE_SPRITE_TABLE_FRAME 3, 0
  ACTIVE_SPRITE_SIDE_SCRIPT

_SwordStrikeAux
  ACTIVE_SPRITE_TABLE_FRAME 1, 3
  ACTIVE_SPRITE_TABLE_FRAME 3, 4
  ACTIVE_SPRITE_TABLE_FRAME 32, 5
  ACTIVE_SPRITE_MAP_BATTLE_STRIKE
  ACTIVE_SPRITE_TABLE_FRAME 3, 6
  ACTIVE_SPRITE_TABLE_FRAME 48, 3
  ACTIVE_SPRITE_WAIT_STRIKE_TAKEN
  ACTIVE_SPRITE_TABLE_FRAME 3, 3
  ACTIVE_SPRITE_END_ROUND
  ACTIVE_SPRITE_SIDE_AUX_SCRIPT

_SwordRanged
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_TABLE_FRAME 4, 0
  ACTIVE_SPRITE_START_MAP_MAGIC
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_WAIT_MAP_MAGIC
  ACTIVE_SPRITE_TABLE_FRAME 4, 0
  ACTIVE_SPRITE_SIDE_SCRIPT

_SwordRangedAux
  ACTIVE_SPRITE_TABLE_FRAME 1, 3
  ACTIVE_SPRITE_TABLE_FRAME 4, 4
  ACTIVE_SPRITE_START_MAP_MAGIC
  ACTIVE_SPRITE_TABLE_FRAME 1, 5
  ACTIVE_SPRITE_WAIT_MAP_MAGIC
  ACTIVE_SPRITE_TABLE_FRAME 4, 4
  ACTIVE_SPRITE_END_ROUND
  ACTIVE_SPRITE_SIDE_AUX_SCRIPT

  ; not reached by any offset
  ACTIVE_SPRITE_END

_SwordUnknown2
  .byte $97, $20, $97, $20, $0C, $20

_SwordUnknown4
  .byte $97, $20, $97, $20, $13, $20, $6B

_Lance
  .word _LanceFrameTable - _Lance
  .word _LanceUnknown2 - _Lance, _LanceUnknown4 - _Lance
  .word _LanceWait - _Lance, _LanceWaitAux - _Lance
  .word _LanceDodge - _Lance, _LanceDodgeAux - _Lance
  .word _LanceStrike - _Lance, _LanceStrikeAux - _Lance
  .word _LanceRanged - _Lance, _LanceRangedAux - _Lance

_LanceFrame00
  .word 6 ; sprite count
  .structSpriteEntry (   1,   -8), $21, SpriteLarge, $026, 2, 0, false, false
  .structSpriteEntry ( -15,   -8), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry (   1,  -24), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -15,  -24), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   1,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -7,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_LanceFrame01
  .word 6 ; sprite count
  .structSpriteEntry ( -15,  -26), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   1,  -10), $21, SpriteLarge, $026, 2, 0, false, false
  .structSpriteEntry ( -15,  -10), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry (   1,  -26), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   1,   -2), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -7,   -2), $00, SpriteSmall, $01E, 2, 0, false, false

_LanceFrame02
  .word 6 ; sprite count
  .structSpriteEntry (   1,  -13), $21, SpriteLarge, $026, 2, 0, false, false
  .structSpriteEntry ( -15,  -13), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry (   1,  -29), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -15,  -29), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   1,   -5), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -7,   -5), $00, SpriteSmall, $01E, 2, 0, false, false

_LanceFrame03
  .word 3 ; sprite count
  .structSpriteEntry ( -10,  -11), $00, SpriteSmall, $021, 2, 0, true, false
  .structSpriteEntry (  -4,  -19), $00, SpriteSmall, $020, 2, 0, true, false
  .structSpriteEntry (  -8,  -14), $21, SpriteLarge, $026, 2, 0, false, false

_LanceFrame04
  .word 3 ; sprite count
  .structSpriteEntry ( -10,  -14), $00, SpriteSmall, $021, 2, 0, true, false
  .structSpriteEntry (  -4,  -22), $00, SpriteSmall, $020, 2, 0, true, false
  .structSpriteEntry (  -8,  -14), $21, SpriteLarge, $024, 2, 0, false, false

_LanceFrame05
  .word 3 ; sprite count
  .structSpriteEntry ( -15,   -6), $00, SpriteSmall, $021, 2, 0, true, false
  .structSpriteEntry (  -9,  -14), $00, SpriteSmall, $020, 2, 0, true, false
  .structSpriteEntry (  -8,  -14), $21, SpriteLarge, $026, 2, 0, false, false

_LanceFrame06
  .word 3 ; sprite count
  .structSpriteEntry ( -13,   -9), $00, SpriteSmall, $021, 2, 0, true, false
  .structSpriteEntry (  -7,  -17), $00, SpriteSmall, $020, 2, 0, true, false
  .structSpriteEntry (  -9,  -14), $21, SpriteLarge, $026, 2, 0, false, false

_LanceFrame07
  .word 3 ; sprite count
  .structSpriteEntry (  -8,  -14), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry (  -2,  -17), $00, SpriteSmall, $023, 2, 0, false, true
  .structSpriteEntry ( -10,  -17), $00, SpriteSmall, $022, 2, 0, false, true

_LanceFrame08
  .word 3 ; sprite count
  .structSpriteEntry ( -14,  -11), $00, SpriteSmall, $023, 2, 0, false, true
  .structSpriteEntry ( -22,  -11), $00, SpriteSmall, $022, 2, 0, false, true
  .structSpriteEntry (  -8,  -14), $21, SpriteLarge, $026, 2, 0, false, false

_LanceFrame09
  .word 1 ; sprite count
  .structSpriteEntry (  -7,  -14), $21, SpriteLarge, $028, 2, 0, false, false

_LanceFrame0A
  .word 1 ; sprite count
  .structSpriteEntry (  -8,  -14), $21, SpriteLarge, $026, 2, 0, false, false

_LanceFrame0B
  .word 3 ; sprite count
  .structSpriteEntry ( -11,  -21), $00, SpriteSmall, $021, 2, 0, true, false
  .structSpriteEntry (  -5,  -29), $00, SpriteSmall, $020, 2, 0, true, false
  .structSpriteEntry (  -8,  -21), $21, SpriteLarge, $02C, 2, 0, false, false

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
  .word _LanceFrame09 - _Lance
  .word _LanceFrame0A - _Lance
  .word _LanceFrame0B - _Lance

_LanceWait
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_WAIT_ROUND
  ACTIVE_SPRITE_ROUND_SCRIPT

_LanceWaitAux
  ACTIVE_SPRITE_TABLE_FRAME 1, 3
  ACTIVE_SPRITE_WAIT_ROUND
  ACTIVE_SPRITE_AUX_ROUND_SCRIPT

_LanceDodge
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_WAIT_STRIKE
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 1
  ACTIVE_SPRITE_TABLE_FRAME 3, 1
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 2
  ACTIVE_SPRITE_TABLE_FRAME 1, 2
  ACTIVE_SPRITE_WAIT_STRIKE_DONE
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 1
  ACTIVE_SPRITE_TABLE_FRAME 3, 1
  ACTIVE_SPRITE_SIDE_SCRIPT

_LanceDodgeAux
  ACTIVE_SPRITE_TABLE_FRAME 1, 3
  ACTIVE_SPRITE_WAIT_STRIKE
  ACTIVE_SPRITE_TABLE_FRAME 3, 4
  ACTIVE_SPRITE_TABLE_FRAME 1, 11
  ACTIVE_SPRITE_WAIT_STRIKE_DONE
  ACTIVE_SPRITE_TABLE_FRAME 3, 4
  ACTIVE_SPRITE_SIDE_AUX_SCRIPT

_LanceStrike
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_TABLE_FRAME 32, 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_TABLE_FRAME 2, 0
  ACTIVE_SPRITE_TABLE_FRAME 48, 0
  ACTIVE_SPRITE_TABLE_FRAME 3, 0
  ACTIVE_SPRITE_SIDE_SCRIPT

_LanceStrikeAux
  ACTIVE_SPRITE_TABLE_FRAME 1, 3
  ACTIVE_SPRITE_TABLE_FRAME 32, 4
  ACTIVE_SPRITE_MAP_BATTLE_STRIKE
  ACTIVE_SPRITE_TABLE_FRAME 1, 4
  ACTIVE_SPRITE_TABLE_FRAME 2, 5
  ACTIVE_SPRITE_TABLE_FRAME 48, 6
  ACTIVE_SPRITE_WAIT_STRIKE_TAKEN
  ACTIVE_SPRITE_TABLE_FRAME 3, 3
  ACTIVE_SPRITE_END_ROUND
  ACTIVE_SPRITE_SIDE_AUX_SCRIPT

_LanceRanged
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_TABLE_FRAME 32, 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_TABLE_FRAME 2, 0
  ACTIVE_SPRITE_TABLE_FRAME 48, 0
  ACTIVE_SPRITE_TABLE_FRAME 3, 0
  ACTIVE_SPRITE_SIDE_SCRIPT

_LanceRangedAux
  ACTIVE_SPRITE_TABLE_FRAME 1, 3
  ACTIVE_SPRITE_TABLE_FRAME 32, 7
  ACTIVE_SPRITE_MAP_BATTLE_STRIKE
  ACTIVE_SPRITE_TABLE_FRAME 1, 7
  ACTIVE_SPRITE_TABLE_FRAME 2, 8
  ACTIVE_SPRITE_TABLE_FRAME 48, 9
  ACTIVE_SPRITE_WAIT_STRIKE_TAKEN
  ACTIVE_SPRITE_TABLE_FRAME 3, 10
  ACTIVE_SPRITE_END_ROUND
  ACTIVE_SPRITE_SIDE_AUX_SCRIPT

  ; not reached by any offset
  ACTIVE_SPRITE_END

_LanceUnknown2
  .byte $40, $22, $40, $22, $AB, $21

_LanceUnknown4
  .byte $40, $22, $40, $22, $B2, $21, $6B

_Axe
  .word _AxeFrameTable - _Axe
  .word _AxeUnknown2 - _Axe, _AxeUnknown4 - _Axe
  .word _AxeWait - _Axe, _AxeWaitAux - _Axe
  .word _AxeDodge - _Axe, _AxeDodgeAux - _Axe
  .word _AxeStrike - _Axe, _AxeStrikeAux - _Axe
  .word _AxeRanged - _Axe, _AxeRangedAux - _Axe

_AxeFrame00
  .word 6 ; sprite count
  .structSpriteEntry (   0,   -8), $21, SpriteLarge, $026, 2, 0, false, false
  .structSpriteEntry ( -16,   -8), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry (   0,  -24), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -16,  -24), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   0,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame01
  .word 6 ; sprite count
  .structSpriteEntry ( -16,  -26), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   0,  -10), $21, SpriteLarge, $026, 2, 0, false, false
  .structSpriteEntry ( -16,  -10), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry (   0,  -26), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   0,   -2), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,   -2), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame02
  .word 6 ; sprite count
  .structSpriteEntry (   0,  -13), $21, SpriteLarge, $026, 2, 0, false, false
  .structSpriteEntry ( -16,  -13), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry (   0,  -29), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -16,  -29), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   0,   -5), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,   -5), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame03
  .word 2 ; sprite count
  .structSpriteEntry (  -8,   -3), $00, SpriteSmall, $020, 2, 0, true, true
  .structSpriteEntry (  -7,  -14), $21, SpriteLarge, $028, 2, 0, false, false

_AxeFrame04
  .word 2 ; sprite count
  .structSpriteEntry ( -13,  -13), $00, SpriteSmall, $022, 2, 0, false, false
  .structSpriteEntry (  -9,  -14), $21, SpriteLarge, $026, 2, 0, false, false

_AxeFrame05
  .word 2 ; sprite count
  .structSpriteEntry (  -9,  -14), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry (  -6,  -18), $00, SpriteSmall, $020, 2, 0, false, false

_AxeFrame06
  .word 2 ; sprite count
  .structSpriteEntry ( -12,  -14), $00, SpriteSmall, $021, 2, 0, false, false
  .structSpriteEntry (  -9,  -14), $21, SpriteLarge, $026, 2, 0, false, false

_AxeFrame07
  .word 2 ; sprite count
  .structSpriteEntry ( -14,  -11), $00, SpriteSmall, $022, 2, 0, false, false
  .structSpriteEntry (  -9,  -14), $21, SpriteLarge, $026, 2, 0, false, false

_AxeFrame08
  .word 1 ; sprite count
  .structSpriteEntry (  -8,  -14), $21, SpriteLarge, $028, 2, 0, false, false

_AxeFrame09
  .word 2 ; sprite count
  .structSpriteEntry ( -10,  -12), $00, SpriteSmall, $020, 2, 0, true, true
  .structSpriteEntry (  -9,  -21), $21, SpriteLarge, $02A, 2, 0, false, false

_AxeFrame0A
  .word 2 ; sprite count
  .structSpriteEntry ( -18,   -8), $00, SpriteSmall, $020, 2, 0, true, true
  .structSpriteEntry (  -9,  -14), $21, SpriteLarge, $026, 2, 0, false, false

_AxeFrame0B
  .word 2 ; sprite count
  .structSpriteEntry ( -26,   -6), $00, SpriteSmall, $022, 2, 0, true, true
  .structSpriteEntry (  -9,  -14), $21, SpriteLarge, $026, 2, 0, false, false

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

_AxeWaitAux
  ACTIVE_SPRITE_TABLE_FRAME 1, 3
  ACTIVE_SPRITE_WAIT_ROUND
  ACTIVE_SPRITE_AUX_ROUND_SCRIPT

_AxeDodge
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_WAIT_STRIKE
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 1
  ACTIVE_SPRITE_TABLE_FRAME 3, 1
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 2
  ACTIVE_SPRITE_TABLE_FRAME 1, 2
  ACTIVE_SPRITE_WAIT_STRIKE_DONE
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 1
  ACTIVE_SPRITE_TABLE_FRAME 3, 1
  ACTIVE_SPRITE_SIDE_SCRIPT

_AxeDodgeAux
  ACTIVE_SPRITE_TABLE_FRAME 1, 3
  ACTIVE_SPRITE_WAIT_STRIKE
  ACTIVE_SPRITE_TABLE_FRAME 3, 3
  ACTIVE_SPRITE_TABLE_FRAME 1, 9
  ACTIVE_SPRITE_WAIT_STRIKE_DONE
  ACTIVE_SPRITE_TABLE_FRAME 3, 3
  ACTIVE_SPRITE_SIDE_AUX_SCRIPT

_AxeStrike
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_TABLE_FRAME 3, 0
  ACTIVE_SPRITE_TABLE_FRAME 32, 0
  ACTIVE_SPRITE_TABLE_FRAME 3, 0
  ACTIVE_SPRITE_TABLE_FRAME 48, 0
  ACTIVE_SPRITE_TABLE_FRAME 3, 0
  ACTIVE_SPRITE_SIDE_SCRIPT

_AxeStrikeAux
  ACTIVE_SPRITE_TABLE_FRAME 1, 3
  ACTIVE_SPRITE_TABLE_FRAME 3, 4
  ACTIVE_SPRITE_TABLE_FRAME 32, 5
  ACTIVE_SPRITE_MAP_BATTLE_STRIKE
  ACTIVE_SPRITE_TABLE_FRAME 3, 6
  ACTIVE_SPRITE_TABLE_FRAME 48, 3
  ACTIVE_SPRITE_WAIT_STRIKE_TAKEN
  ACTIVE_SPRITE_TABLE_FRAME 3, 3
  ACTIVE_SPRITE_END_ROUND
  ACTIVE_SPRITE_SIDE_AUX_SCRIPT

_AxeRanged
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_TABLE_FRAME 3, 0
  ACTIVE_SPRITE_TABLE_FRAME 32, 0
  ACTIVE_SPRITE_TABLE_FRAME 7, 0
  ACTIVE_SPRITE_TABLE_FRAME 48, 0
  ACTIVE_SPRITE_TABLE_FRAME 3, 0
  ACTIVE_SPRITE_SIDE_SCRIPT

_AxeRangedAux
  ACTIVE_SPRITE_TABLE_FRAME 1, 3
  ACTIVE_SPRITE_TABLE_FRAME 3, 4
  ACTIVE_SPRITE_TABLE_FRAME 32, 5
  ACTIVE_SPRITE_TABLE_FRAME 3, 7
  ACTIVE_SPRITE_TABLE_FRAME 1, 10
  ACTIVE_SPRITE_MAP_BATTLE_STRIKE
  ACTIVE_SPRITE_TABLE_FRAME 1, 10
  ACTIVE_SPRITE_TABLE_FRAME 2, 11
  ACTIVE_SPRITE_TABLE_FRAME 48, 8
  ACTIVE_SPRITE_WAIT_STRIKE_TAKEN
  ACTIVE_SPRITE_TABLE_FRAME 3, 3
  ACTIVE_SPRITE_END_ROUND
  ACTIVE_SPRITE_SIDE_AUX_SCRIPT

  ; not reached by any offset
  ACTIVE_SPRITE_END

_AxeUnknown2
  .byte $D4, $23, $D4, $23, $36, $23

_AxeUnknown4
  .byte $D4, $23, $D4, $23, $3D, $23, $6B

_Bow
  .word _BowFrameTable - _Bow
  .word _BowUnknown2 - _Bow, _BowUnknown4 - _Bow
  .word _BowWait - _Bow, _BowWaitAux - _Bow
  .word _BowDodge - _Bow, _BowDodgeAux - _Bow
  .word $2098, $2098
  .word _BowRanged - _Bow, _BowRangedAux - _Bow

_BowFrame00
  .word 6 ; sprite count
  .structSpriteEntry (   0,   -8), $21, SpriteLarge, $026, 2, 0, false, false
  .structSpriteEntry ( -16,   -8), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry (   0,  -24), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -16,  -24), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   0,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_BowFrame01
  .word 6 ; sprite count
  .structSpriteEntry ( -16,  -26), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   0,  -10), $21, SpriteLarge, $026, 2, 0, false, false
  .structSpriteEntry ( -16,  -10), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry (   0,  -26), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   0,   -2), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,   -2), $00, SpriteSmall, $01E, 2, 0, false, false

_BowFrame02
  .word 6 ; sprite count
  .structSpriteEntry (   0,  -13), $21, SpriteLarge, $026, 2, 0, false, false
  .structSpriteEntry ( -16,  -13), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry (   0,  -29), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -16,  -29), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   0,   -5), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,   -5), $00, SpriteSmall, $01E, 2, 0, false, false

_BowFrame03
  .word 4 ; sprite count
  .structSpriteEntry (  -8,  -12), $00, SpriteSmall, $022, 2, 0, false, false
  .structSpriteEntry (  -9,   -8), $00, SpriteSmall, $030, 2, 0, false, true
  .structSpriteEntry (  -9,  -16), $00, SpriteSmall, $030, 2, 0, false, false
  .structSpriteEntry (  -9,  -15), $21, SpriteLarge, $024, 2, 0, false, false

_BowFrame04
  .word 4 ; sprite count
  .structSpriteEntry (  -7,  -12), $00, SpriteSmall, $022, 2, 0, false, false
  .structSpriteEntry ( -10,   -8), $00, SpriteSmall, $030, 2, 0, false, true
  .structSpriteEntry ( -10,  -16), $00, SpriteSmall, $030, 2, 0, false, false
  .structSpriteEntry (  -9,  -15), $21, SpriteLarge, $026, 2, 0, false, false

_BowFrame05
  .word 4 ; sprite count
  .structSpriteEntry (  -6,  -12), $00, SpriteSmall, $022, 2, 0, false, false
  .structSpriteEntry ( -10,   -8), $00, SpriteSmall, $030, 2, 0, false, true
  .structSpriteEntry ( -10,  -16), $00, SpriteSmall, $030, 2, 0, false, false
  .structSpriteEntry (  -9,  -15), $21, SpriteLarge, $026, 2, 0, false, false

_BowFrame06
  .word 4 ; sprite count
  .structSpriteEntry ( -15,  -11), $00, SpriteSmall, $022, 2, 0, false, false
  .structSpriteEntry (  -9,  -10), $00, SpriteSmall, $030, 2, 0, false, true
  .structSpriteEntry (  -9,  -18), $00, SpriteSmall, $030, 2, 0, false, false
  .structSpriteEntry (  -8,  -15), $21, SpriteLarge, $026, 2, 0, false, false

_BowFrame07
  .word 3 ; sprite count
  .structSpriteEntry (  -9,   -9), $00, SpriteSmall, $030, 2, 0, false, true
  .structSpriteEntry (  -9,  -17), $00, SpriteSmall, $030, 2, 0, false, false
  .structSpriteEntry (  -8,  -15), $21, SpriteLarge, $026, 2, 0, false, false

_BowFrame08
  .word 4 ; sprite count
  .structSpriteEntry (  -7,  -19), $00, SpriteSmall, $022, 2, 0, false, false
  .structSpriteEntry ( -10,  -14), $00, SpriteSmall, $030, 2, 0, false, true
  .structSpriteEntry ( -10,  -22), $00, SpriteSmall, $030, 2, 0, false, false
  .structSpriteEntry (  -9,  -21), $21, SpriteLarge, $024, 2, 0, false, false

_BowFrameTable
  .word _BowFrame00 - _Bow
  .word _BowFrame01 - _Bow
  .word _BowFrame02 - _Bow
  .word _BowFrame03 - _Bow
  .word _BowFrame04 - _Bow
  .word _BowFrame05 - _Bow
  .word _BowFrame06 - _Bow
  .word _BowFrame07 - _Bow
  .word _BowFrame08 - _Bow

_BowWait
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_WAIT_ROUND
  ACTIVE_SPRITE_ROUND_SCRIPT

_BowWaitAux
  ACTIVE_SPRITE_TABLE_FRAME 1, 3
  ACTIVE_SPRITE_WAIT_ROUND
  ACTIVE_SPRITE_AUX_ROUND_SCRIPT

_BowDodge
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_WAIT_STRIKE
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 1
  ACTIVE_SPRITE_TABLE_FRAME 3, 1
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 2
  ACTIVE_SPRITE_TABLE_FRAME 1, 2
  ACTIVE_SPRITE_WAIT_STRIKE_DONE
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 1
  ACTIVE_SPRITE_TABLE_FRAME 3, 1
  ACTIVE_SPRITE_SIDE_SCRIPT

_BowDodgeAux
  ACTIVE_SPRITE_TABLE_FRAME 1, 3
  ACTIVE_SPRITE_WAIT_STRIKE
  ACTIVE_SPRITE_TABLE_FRAME 3, 3
  ACTIVE_SPRITE_TABLE_FRAME 1, 8
  ACTIVE_SPRITE_WAIT_STRIKE_DONE
  ACTIVE_SPRITE_TABLE_FRAME 3, 3
  ACTIVE_SPRITE_SIDE_AUX_SCRIPT

_BowRanged
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_TABLE_FRAME 3, 0
  ACTIVE_SPRITE_TABLE_FRAME 32, 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_TABLE_FRAME 2, 0
  ACTIVE_SPRITE_TABLE_FRAME 48, 0
  ACTIVE_SPRITE_TABLE_FRAME 3, 0
  ACTIVE_SPRITE_SIDE_SCRIPT

_BowRangedAux
  ACTIVE_SPRITE_TABLE_FRAME 1, 3
  ACTIVE_SPRITE_TABLE_FRAME 3, 4
  ACTIVE_SPRITE_TABLE_FRAME 32, 5
  ACTIVE_SPRITE_MAP_BATTLE_STRIKE
  ACTIVE_SPRITE_TABLE_FRAME 1, 5
  ACTIVE_SPRITE_TABLE_FRAME 2, 6
  ACTIVE_SPRITE_TABLE_FRAME 48, 7
  ACTIVE_SPRITE_WAIT_STRIKE_TAKEN
  ACTIVE_SPRITE_TABLE_FRAME 3, 3
  ACTIVE_SPRITE_END_ROUND
  ACTIVE_SPRITE_SIDE_AUX_SCRIPT

  ; not reached by any offset
  ACTIVE_SPRITE_END

_BowUnknown2
  .byte $4C, $25, $4C, $25, $DC, $24

_BowUnknown4
  .byte $4C, $25, $4C, $25, $E3, $24, $6B

_Magic
  .word _MagicFrameTable - _Magic
  .word _MagicUnknown2 - _Magic, $2098
  .word _MagicWait - _Magic, $2098
  .word _MagicDodge - _Magic, $2098
  .word _MagicStrike - _Magic, $2098
  .word _MagicStrike - _Magic, $2098

_MagicFrame00
  .word 6 ; sprite count
  .structSpriteEntry (   0,   -8), $21, SpriteLarge, $026, 2, 0, false, false
  .structSpriteEntry ( -16,   -8), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry (   0,  -24), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -16,  -24), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   0,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_MagicFrame01
  .word 6 ; sprite count
  .structSpriteEntry (   0,   -8), $21, SpriteLarge, $026, 2, 0, false, false
  .structSpriteEntry ( -16,   -8), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry (   0,  -24), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -16,  -24), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   0,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_MagicFrame02
  .word 6 ; sprite count
  .structSpriteEntry (   0,   -8), $21, SpriteLarge, $026, 2, 0, false, false
  .structSpriteEntry ( -16,   -8), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry (   0,  -24), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -16,  -24), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   0,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_MagicFrame03
  .word 6 ; sprite count
  .structSpriteEntry (   0,  -10), $21, SpriteLarge, $026, 2, 0, false, false
  .structSpriteEntry ( -16,  -10), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry (   0,  -26), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -16,  -26), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   0,   -2), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,   -2), $00, SpriteSmall, $01E, 2, 0, false, false

_MagicFrame04
  .word 6 ; sprite count
  .structSpriteEntry (   0,  -13), $21, SpriteLarge, $026, 2, 0, false, false
  .structSpriteEntry ( -16,  -13), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry (   0,  -29), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -16,  -29), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   0,   -5), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,   -5), $00, SpriteSmall, $01E, 2, 0, false, false

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
  .byte $4A, $26, $4A, $26, $0D, $26, $6B

  MAP_BATTLE_SPRITE_DATA_END $800
