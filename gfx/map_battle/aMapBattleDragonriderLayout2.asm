; Map battle sprite data: the format is described in tools/map_battle_layouts.py.

aMapBattleDragonriderLayout2

  ; Block offsets by weapon type (sword, lance, axe, bow, staff or tome).
  .word _Sword - aMapBattleDragonriderLayout2
  .word _Lance - aMapBattleDragonriderLayout2
  .word $20BA ; no axe block
  .word $20BA ; no bow block
  .word $20BA ; no magic block

_Sword
  .word _SwordFrameTable - _Sword
  .word _SwordUnknown2 - _Sword, _SwordUnknown4 - _Sword
  .word _SwordWait - _Sword, _SwordWaitAux - _Sword
  .word _SwordDodge - _Sword, _SwordDodgeAux - _Sword
  .word _SwordStrike - _Sword, _SwordStrikeAux - _Sword
  .word _SwordRanged - _Sword, _SwordRangedAux - _Sword

_SwordFrame00
  .word 6 ; sprite count
  .structSpriteEntry (  -1,    0), $21, SpriteLarge, $026, 2, 0, false, false
  .structSpriteEntry ( -17,    0), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry (  -1,  -16), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -17,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -1,    3), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -9,    3), $00, SpriteSmall, $01E, 2, 0, false, false

_SwordFrame01
  .word 6 ; sprite count
  .structSpriteEntry (  -4,    3), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry ( -12,    3), $00, SpriteSmall, $01E, 2, 0, false, false
  .structSpriteEntry (  -5,    0), $21, SpriteLarge, $026, 2, 0, false, false
  .structSpriteEntry ( -21,    0), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry (  -5,  -16), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -21,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_SwordFrame02
  .word 6 ; sprite count
  .structSpriteEntry (  -9,    0), $21, SpriteLarge, $026, 2, 0, false, false
  .structSpriteEntry ( -25,    0), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry (  -9,  -16), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -25,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -7,    3), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry ( -15,    3), $00, SpriteSmall, $01E, 2, 0, false, false

_SwordFrame03
  .word 2 ; sprite count
  .structSpriteEntry ( -10,  -16), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry (  -3,  -13), $00, SpriteSmall, $022, 2, 0, false, false

_SwordFrame04
  .word 2 ; sprite count
  .structSpriteEntry ( -10,  -16), $21, SpriteLarge, $026, 2, 0, false, false
  .structSpriteEntry (  -3,  -16), $00, SpriteSmall, $023, 2, 0, false, false

_SwordFrame05
  .word 2 ; sprite count
  .structSpriteEntry (  -3,  -13), $00, SpriteSmall, $023, 2, 0, false, true
  .structSpriteEntry ( -10,  -16), $21, SpriteLarge, $028, 2, 0, false, false

_SwordFrame06
  .word 2 ; sprite count
  .structSpriteEntry (  -3,  -19), $00, SpriteSmall, $030, 2, 0, false, false
  .structSpriteEntry ( -10,  -16), $21, SpriteLarge, $026, 2, 0, false, false

_SwordFrame07
  .word 2 ; sprite count
  .structSpriteEntry ( -10,  -17), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry (  -3,  -13), $00, SpriteSmall, $022, 2, 0, false, false

_SwordFrame08
  .word 2 ; sprite count
  .structSpriteEntry ( -13,  -17), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry (  -6,  -15), $00, SpriteSmall, $022, 2, 0, false, false

_SwordFrame09
  .word 2 ; sprite count
  .structSpriteEntry ( -14,  -17), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry (  -8,  -15), $00, SpriteSmall, $022, 2, 0, false, false

_SwordFrameTable
  .word _SwordFrame00 - _Sword
  .word _SwordFrame01 - _Sword
  .word _SwordFrame02 - _Sword
  .word _SwordFrame03 - _Sword
  .word _SwordFrame04 - _Sword
  .word _SwordFrame05 - _Sword
  .word _SwordFrame06 - _Sword
  .word _SwordFrame07 - _Sword
  .word _SwordFrame08 - _Sword
  .word _SwordFrame09 - _Sword

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
  ACTIVE_SPRITE_TABLE_FRAME 3, 8
  ACTIVE_SPRITE_TABLE_FRAME 1, 9
  ACTIVE_SPRITE_WAIT_STRIKE_DONE
  ACTIVE_SPRITE_TABLE_FRAME 3, 8
  ACTIVE_SPRITE_SIDE_AUX_SCRIPT

_SwordStrike
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_TABLE_FRAME 3, 0
  ACTIVE_SPRITE_TABLE_FRAME 22, 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_TABLE_FRAME 2, 0
  ACTIVE_SPRITE_TABLE_FRAME 48, 0
  ACTIVE_SPRITE_TABLE_FRAME 3, 0
  ACTIVE_SPRITE_SIDE_SCRIPT

_SwordStrikeAux
  ACTIVE_SPRITE_TABLE_FRAME 1, 3
  ACTIVE_SPRITE_TABLE_FRAME 3, 4
  ACTIVE_SPRITE_TABLE_FRAME 22, 5
  ACTIVE_SPRITE_MAP_BATTLE_STRIKE
  ACTIVE_SPRITE_TABLE_FRAME 1, 5
  ACTIVE_SPRITE_TABLE_FRAME 2, 6
  ACTIVE_SPRITE_TABLE_FRAME 48, 7
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
  .byte $B9, $20, $B9, $20, $28, $20

_SwordUnknown4
  .byte $B9, $20, $B9, $20, $2F, $20, $6B

_Lance
  .word _LanceFrameTable - _Lance
  .word _LanceUnknown2 - _Lance, _LanceUnknown4 - _Lance
  .word _LanceWait - _Lance, _LanceWaitAux - _Lance
  .word _LanceDodge - _Lance, _LanceDodgeAux - _Lance
  .word _LanceStrike - _Lance, _LanceStrikeAux - _Lance
  .word _LanceRanged - _Lance, _LanceRangedAux - _Lance

_LanceFrame00
  .word 6 ; sprite count
  .structSpriteEntry (   0,    0), $21, SpriteLarge, $026, 2, 0, false, false
  .structSpriteEntry ( -16,    0), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry (   0,  -16), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -16,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   0,    3), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    3), $00, SpriteSmall, $01E, 2, 0, false, false

_LanceFrame01
  .word 6 ; sprite count
  .structSpriteEntry (  -3,    3), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry ( -11,    3), $00, SpriteSmall, $01E, 2, 0, false, false
  .structSpriteEntry (  -4,    0), $21, SpriteLarge, $026, 2, 0, false, false
  .structSpriteEntry ( -20,    0), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry (  -4,  -16), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -20,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_LanceFrame02
  .word 6 ; sprite count
  .structSpriteEntry (  -8,    0), $21, SpriteLarge, $026, 2, 0, false, false
  .structSpriteEntry ( -24,    0), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry (  -8,  -16), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -24,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -6,    3), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry ( -14,    3), $00, SpriteSmall, $01E, 2, 0, false, false

_LanceFrame03
  .word 3 ; sprite count
  .structSpriteEntry (  -2,  -13), $00, SpriteSmall, $032, 2, 0, false, false
  .structSpriteEntry (  -2,   -5), $00, SpriteSmall, $033, 2, 0, false, false
  .structSpriteEntry (  -9,  -15), $21, SpriteLarge, $028, 2, 0, false, false

_LanceFrame04
  .word 3 ; sprite count
  .structSpriteEntry (  -2,   -7), $00, SpriteSmall, $033, 2, 0, false, false
  .structSpriteEntry (  -2,  -15), $00, SpriteSmall, $032, 2, 0, false, false
  .structSpriteEntry (  -9,  -15), $21, SpriteLarge, $026, 2, 0, false, false

_LanceFrame05
  .word 3 ; sprite count
  .structSpriteEntry (  -2,  -20), $00, SpriteSmall, $032, 2, 0, false, false
  .structSpriteEntry (  -2,  -12), $00, SpriteSmall, $033, 2, 0, false, false
  .structSpriteEntry (  -9,  -16), $21, SpriteLarge, $026, 2, 0, false, false

_LanceFrame06
  .word 3 ; sprite count
  .structSpriteEntry (  -3,  -17), $00, SpriteSmall, $033, 2, 0, false, false
  .structSpriteEntry (  -3,  -25), $00, SpriteSmall, $032, 2, 0, false, false
  .structSpriteEntry (  -9,  -15), $21, SpriteLarge, $026, 2, 0, false, false

_LanceFrame07
  .word 1 ; sprite count
  .structSpriteEntry (  -9,  -16), $21, SpriteLarge, $024, 2, 0, false, false

_LanceFrame08
  .word 1 ; sprite count
  .structSpriteEntry (  -9,  -15), $21, SpriteLarge, $026, 2, 0, false, false

_LanceFrame09
  .word 3 ; sprite count
  .structSpriteEntry (  -7,  -13), $00, SpriteSmall, $032, 2, 0, false, false
  .structSpriteEntry (  -7,   -5), $00, SpriteSmall, $033, 2, 0, false, false
  .structSpriteEntry ( -14,  -15), $21, SpriteLarge, $02A, 2, 0, false, false

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
  ACTIVE_SPRITE_TABLE_FRAME 3, 3
  ACTIVE_SPRITE_TABLE_FRAME 1, 9
  ACTIVE_SPRITE_WAIT_STRIKE_DONE
  ACTIVE_SPRITE_TABLE_FRAME 3, 3
  ACTIVE_SPRITE_SIDE_AUX_SCRIPT

_LanceStrike
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_TABLE_FRAME 2, 0
  ACTIVE_SPRITE_TABLE_FRAME 48, 0
  ACTIVE_SPRITE_TABLE_FRAME 3, 0
  ACTIVE_SPRITE_SIDE_SCRIPT

_LanceStrikeAux
  ACTIVE_SPRITE_TABLE_FRAME 1, 3
  ACTIVE_SPRITE_MAP_BATTLE_STRIKE
  ACTIVE_SPRITE_TABLE_FRAME 1, 3
  ACTIVE_SPRITE_TABLE_FRAME 2, 4
  ACTIVE_SPRITE_TABLE_FRAME 48, 5
  ACTIVE_SPRITE_WAIT_STRIKE_TAKEN
  ACTIVE_SPRITE_TABLE_FRAME 3, 4
  ACTIVE_SPRITE_END_ROUND
  ACTIVE_SPRITE_SIDE_AUX_SCRIPT

_LanceRanged
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_TABLE_FRAME 2, 0
  ACTIVE_SPRITE_TABLE_FRAME 48, 0
  ACTIVE_SPRITE_TABLE_FRAME 3, 0
  ACTIVE_SPRITE_SIDE_SCRIPT

_LanceRangedAux
  ACTIVE_SPRITE_TABLE_FRAME 1, 3
  ACTIVE_SPRITE_MAP_BATTLE_STRIKE
  ACTIVE_SPRITE_TABLE_FRAME 1, 3
  ACTIVE_SPRITE_TABLE_FRAME 2, 6
  ACTIVE_SPRITE_TABLE_FRAME 48, 7
  ACTIVE_SPRITE_WAIT_STRIKE_TAKEN
  ACTIVE_SPRITE_TABLE_FRAME 3, 8
  ACTIVE_SPRITE_END_ROUND
  ACTIVE_SPRITE_SIDE_AUX_SCRIPT

  ; not reached by any offset
  ACTIVE_SPRITE_END

_LanceUnknown2
  .byte $30, $22, $30, $22, $A7, $21

_LanceUnknown4
  .byte $30, $22, $30, $22, $AE, $21, $6B

  MAP_BATTLE_SPRITE_DATA_END $800
