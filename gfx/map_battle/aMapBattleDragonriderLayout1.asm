; Map battle sprite data: the format is described in tools/map_battle_layouts.py.

aMapBattleDragonriderLayout1

  ; Block offsets by weapon type (sword, lance, axe, bow, staff or tome).
  .word _Sword - aMapBattleDragonriderLayout1
  .word _Lance - aMapBattleDragonriderLayout1
  .word $2069 ; no axe block
  .word $2069 ; no bow block
  .word $2069 ; no magic block

_Sword
  .word _SwordFrameTable - _Sword
  .word _SwordUnknown2 - _Sword, _SwordUnknown4 - _Sword
  .word _SwordWait - _Sword, _SwordWaitAux - _Sword
  .word _SwordDodge - _Sword, _SwordDodgeAux - _Sword
  .word _SwordStrike - _Sword, _SwordStrikeAux - _Sword

_SwordFrame00
  .word 6 ; sprite count
  .structSpriteEntry (   2,   -8), $21, SpriteLarge, $026, 2, 0, false, false
  .structSpriteEntry ( -14,   -8), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry (   2,  -24), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -14,  -24), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   2,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -6,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_SwordFrame01
  .word 6 ; sprite count
  .structSpriteEntry (   0,  -22), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   0,   -6), $21, SpriteLarge, $026, 2, 0, false, false
  .structSpriteEntry ( -16,   -6), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry ( -16,  -22), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   0,    2), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    2), $00, SpriteSmall, $01E, 2, 0, false, false

_SwordFrame02
  .word 6 ; sprite count
  .structSpriteEntry (  -3,   -3), $21, SpriteLarge, $026, 2, 0, false, false
  .structSpriteEntry ( -19,   -3), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry (  -3,  -19), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -19,  -19), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -3,    5), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry ( -11,    5), $00, SpriteSmall, $01E, 2, 0, false, false

_SwordFrame03
  .word 2 ; sprite count
  .structSpriteEntry (  -7,  -16), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry ( -11,   -6), $00, SpriteSmall, $020, 2, 0, true, true

_SwordFrame04
  .word 2 ; sprite count
  .structSpriteEntry ( -11,  -17), $00, SpriteSmall, $020, 2, 0, true, false
  .structSpriteEntry (  -8,  -16), $21, SpriteLarge, $028, 2, 0, false, false

_SwordFrame05
  .word 2 ; sprite count
  .structSpriteEntry (  -4,  -19), $00, SpriteSmall, $020, 2, 0, false, false
  .structSpriteEntry (  -8,  -16), $21, SpriteLarge, $026, 2, 0, false, false

_SwordFrame06
  .word 2 ; sprite count
  .structSpriteEntry (  -9,  -16), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry ( -13,   -6), $00, SpriteSmall, $020, 2, 0, true, true

_SwordFrame07
  .word 2 ; sprite count
  .structSpriteEntry ( -11,  -12), $21, SpriteLarge, $02A, 2, 0, false, false
  .structSpriteEntry ( -15,   -4), $00, SpriteSmall, $020, 2, 0, true, true

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
  ACTIVE_SPRITE_TABLE_FRAME 3, 6
  ACTIVE_SPRITE_TABLE_FRAME 1, 7
  ACTIVE_SPRITE_WAIT_STRIKE_DONE
  ACTIVE_SPRITE_TABLE_FRAME 3, 6
  ACTIVE_SPRITE_SIDE_AUX_SCRIPT

_SwordStrike
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_TABLE_FRAME 4, 0
  ACTIVE_SPRITE_START_MAP_MAGIC
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_WAIT_MAP_MAGIC
  ACTIVE_SPRITE_TABLE_FRAME 4, 0
  ACTIVE_SPRITE_SIDE_SCRIPT

_SwordStrikeAux
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
  .byte $68, $20, $68, $20, $08, $20

_SwordUnknown4
  .byte $68, $20, $68, $20, $0F, $20, $6B

_Lance
  .word _LanceFrameTable - _Lance
  .word _LanceUnknown2 - _Lance, _LanceUnknown4 - _Lance
  .word _LanceWait - _Lance, _LanceWaitAux - _Lance
  .word _LanceDodge - _Lance, _LanceDodgeAux - _Lance
  .word _LanceStrike - _Lance, _LanceStrikeAux - _Lance

_LanceFrame00
  .word 6 ; sprite count
  .structSpriteEntry (   4,   -6), $21, SpriteLarge, $026, 2, 0, false, false
  .structSpriteEntry ( -12,   -6), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry (   4,  -22), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -22), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   4,    2), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -4,    2), $00, SpriteSmall, $01E, 2, 0, false, false

_LanceFrame01
  .word 6 ; sprite count
  .structSpriteEntry (   2,  -20), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   2,   -4), $21, SpriteLarge, $026, 2, 0, false, false
  .structSpriteEntry ( -14,   -4), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry ( -14,  -20), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   2,    4), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -6,    4), $00, SpriteSmall, $01E, 2, 0, false, false

_LanceFrame02
  .word 6 ; sprite count
  .structSpriteEntry (  -1,   -1), $21, SpriteLarge, $026, 2, 0, false, false
  .structSpriteEntry ( -17,   -1), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry (  -1,  -17), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -17,  -17), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -1,    7), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -9,    7), $00, SpriteSmall, $01E, 2, 0, false, false

_LanceFrame03
  .word 3 ; sprite count
  .structSpriteEntry (  -6,  -14), $21, SpriteLarge, $026, 2, 0, false, false
  .structSpriteEntry (  -4,  -16), $00, SpriteSmall, $021, 2, 0, true, true
  .structSpriteEntry (   2,   -8), $00, SpriteSmall, $020, 2, 0, true, true

_LanceFrame04
  .word 3 ; sprite count
  .structSpriteEntry (  -6,  -14), $21, SpriteLarge, $028, 2, 0, false, false
  .structSpriteEntry ( -11,  -17), $00, SpriteSmall, $021, 2, 0, true, true
  .structSpriteEntry (  -5,   -9), $00, SpriteSmall, $020, 2, 0, true, true

_LanceFrame05
  .word 1 ; sprite count
  .structSpriteEntry (  -6,  -15), $21, SpriteLarge, $024, 2, 0, false, false

_LanceFrame06
  .word 1 ; sprite count
  .structSpriteEntry (  -6,  -14), $21, SpriteLarge, $028, 2, 0, false, false

_LanceFrame07
  .word 3 ; sprite count
  .structSpriteEntry (  -8,  -14), $21, SpriteLarge, $026, 2, 0, false, false
  .structSpriteEntry (  -6,  -16), $00, SpriteSmall, $021, 2, 0, true, true
  .structSpriteEntry (   0,   -8), $00, SpriteSmall, $020, 2, 0, true, true

_LanceFrame08
  .word 3 ; sprite count
  .structSpriteEntry (  -6,  -16), $00, SpriteSmall, $021, 2, 0, true, true
  .structSpriteEntry (   0,   -8), $00, SpriteSmall, $020, 2, 0, true, true
  .structSpriteEntry (  -8,  -10), $21, SpriteLarge, $02C, 2, 0, false, false

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
  ACTIVE_SPRITE_TABLE_FRAME 3, 7
  ACTIVE_SPRITE_TABLE_FRAME 1, 8
  ACTIVE_SPRITE_WAIT_STRIKE_DONE
  ACTIVE_SPRITE_TABLE_FRAME 3, 7
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
  ACTIVE_SPRITE_TABLE_FRAME 3, 6
  ACTIVE_SPRITE_END_ROUND
  ACTIVE_SPRITE_SIDE_AUX_SCRIPT

  ; not reached by any offset
  ACTIVE_SPRITE_END

_LanceUnknown2
  .byte $A3, $21, $A3, $21, $3F, $21

_LanceUnknown4
  .byte $A3, $21, $A3, $21, $46, $21, $6B

  MAP_BATTLE_SPRITE_DATA_END $800
