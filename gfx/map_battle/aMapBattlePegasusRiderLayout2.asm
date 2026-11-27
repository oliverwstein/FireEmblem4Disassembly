; Map battle sprite data: the format is described in tools/map_battle_layouts.py.

aMapBattlePegasusRiderLayout2

  ; Block offsets by weapon type (sword, lance, axe, bow, staff or tome).
  .word _Sword - aMapBattlePegasusRiderLayout2
  .word _Lance - aMapBattlePegasusRiderLayout2
  .word $209E ; no axe block
  .word $209E ; no bow block
  .word _Magic - aMapBattlePegasusRiderLayout2

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
  .structSpriteEntry ( -14,  -24), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   2,   -8), $21, SpriteLarge, $026, 2, 0, false, false
  .structSpriteEntry ( -14,   -8), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry (   2,  -24), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   2,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -6,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_SwordFrame02
  .word 6 ; sprite count
  .structSpriteEntry (   5,   -6), $21, SpriteLarge, $026, 2, 0, false, false
  .structSpriteEntry ( -11,   -6), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry (   5,  -22), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -11,  -22), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   5,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -3,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_SwordFrame03
  .word 2 ; sprite count
  .structSpriteEntry (  -7,  -14), $21, SpriteLarge, $028, 2, 0, false, false
  .structSpriteEntry (   0,  -13), $00, SpriteSmall, $022, 2, 0, false, false

_SwordFrame04
  .word 2 ; sprite count
  .structSpriteEntry (  -7,  -14), $21, SpriteLarge, $026, 2, 0, false, false
  .structSpriteEntry (   0,  -18), $00, SpriteSmall, $023, 2, 0, false, false

_SwordFrame05
  .word 2 ; sprite count
  .structSpriteEntry (   1,  -12), $00, SpriteSmall, $023, 2, 0, false, true
  .structSpriteEntry (  -7,  -14), $21, SpriteLarge, $024, 2, 0, false, false

_SwordFrame06
  .word 2 ; sprite count
  .structSpriteEntry (  -7,  -15), $21, SpriteLarge, $026, 2, 0, false, false
  .structSpriteEntry (   0,  -19), $00, SpriteSmall, $030, 2, 0, false, false

_SwordFrame07
  .word 2 ; sprite count
  .structSpriteEntry (  -3,  -17), $21, SpriteLarge, $02A, 2, 0, false, false
  .structSpriteEntry (   6,  -14), $00, SpriteSmall, $022, 2, 0, false, false

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
  .byte $9D, $20, $9D, $20, $0C, $20

_SwordUnknown4
  .byte $9D, $20, $9D, $20, $13, $20, $6B

_Lance
  .word _LanceFrameTable - _Lance
  .word _LanceUnknown2 - _Lance, _LanceUnknown4 - _Lance
  .word _LanceWait - _Lance, _LanceWaitAux - _Lance
  .word _LanceDodge - _Lance, _LanceDodgeAux - _Lance
  .word _LanceStrike - _Lance, _LanceStrikeAux - _Lance
  .word _LanceRanged - _Lance, _LanceRangedAux - _Lance

_LanceFrame00
  .word 6 ; sprite count
  .structSpriteEntry (   0,   -8), $21, SpriteLarge, $026, 2, 0, false, false
  .structSpriteEntry ( -16,   -8), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry (   0,  -24), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -16,  -24), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   0,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_LanceFrame01
  .word 6 ; sprite count
  .structSpriteEntry ( -14,  -24), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   2,   -8), $21, SpriteLarge, $026, 2, 0, false, false
  .structSpriteEntry ( -14,   -8), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry (   2,  -24), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   2,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -6,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_LanceFrame02
  .word 6 ; sprite count
  .structSpriteEntry (   5,   -7), $21, SpriteLarge, $026, 2, 0, false, false
  .structSpriteEntry ( -11,   -7), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry (   5,  -23), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -11,  -23), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   5,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -3,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_LanceFrame03
  .word 3 ; sprite count
  .structSpriteEntry (   0,   -7), $00, SpriteSmall, $033, 2, 0, false, false
  .structSpriteEntry (   0,  -15), $00, SpriteSmall, $032, 2, 0, false, false
  .structSpriteEntry (  -8,  -15), $21, SpriteLarge, $024, 2, 0, false, false

_LanceFrame04
  .word 3 ; sprite count
  .structSpriteEntry (  -1,   -9), $00, SpriteSmall, $033, 2, 0, false, false
  .structSpriteEntry (  -1,  -17), $00, SpriteSmall, $032, 2, 0, false, false
  .structSpriteEntry (  -8,  -15), $21, SpriteLarge, $026, 2, 0, false, false

_LanceFrame05
  .word 3 ; sprite count
  .structSpriteEntry (  -1,  -14), $00, SpriteSmall, $033, 2, 0, false, false
  .structSpriteEntry (  -1,  -22), $00, SpriteSmall, $032, 2, 0, false, false
  .structSpriteEntry (  -8,  -16), $21, SpriteLarge, $026, 2, 0, false, false

_LanceFrame06
  .word 3 ; sprite count
  .structSpriteEntry (  -1,  -18), $00, SpriteSmall, $033, 2, 0, false, false
  .structSpriteEntry (  -1,  -26), $00, SpriteSmall, $032, 2, 0, false, false
  .structSpriteEntry (  -8,  -15), $21, SpriteLarge, $026, 2, 0, false, false

_LanceFrame07
  .word 1 ; sprite count
  .structSpriteEntry (  -8,  -16), $21, SpriteLarge, $028, 2, 0, false, false

_LanceFrame08
  .word 1 ; sprite count
  .structSpriteEntry (  -8,  -15), $21, SpriteLarge, $026, 2, 0, false, false

_LanceFrame09
  .word 3 ; sprite count
  .structSpriteEntry (   6,   -9), $00, SpriteSmall, $033, 2, 0, false, false
  .structSpriteEntry (   6,  -17), $00, SpriteSmall, $032, 2, 0, false, false
  .structSpriteEntry (  -3,  -18), $21, SpriteLarge, $02C, 2, 0, false, false

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
  ACTIVE_SPRITE_TABLE_FRAME 3, 3
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
  .byte $14, $22, $14, $22, $8B, $21

_LanceUnknown4
  .byte $14, $22, $14, $22, $92, $21, $6B

_Magic
  .word _MagicFrameTable - _Magic
  .word _MagicUnknown2 - _Magic, $209E
  .word _MagicWait - _Magic, $209E
  .word _MagicDodge - _Magic, $209E
  .word _MagicStrike - _Magic, $209E
  .word _MagicStrike - _Magic, $209E

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
  .structSpriteEntry (   0,   -9), $21, SpriteLarge, $026, 2, 0, false, false
  .structSpriteEntry ( -16,   -9), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry (   0,  -25), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -16,  -25), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   0,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_MagicFrame02
  .word 6 ; sprite count
  .structSpriteEntry (   0,  -10), $21, SpriteLarge, $026, 2, 0, false, false
  .structSpriteEntry ( -16,  -10), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry (   0,  -26), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -16,  -26), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   0,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -8,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_MagicFrame03
  .word 6 ; sprite count
  .structSpriteEntry (   2,   -8), $21, SpriteLarge, $026, 2, 0, false, false
  .structSpriteEntry ( -14,   -8), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry (   2,  -24), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -14,  -24), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   2,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -6,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_MagicFrame04
  .word 6 ; sprite count
  .structSpriteEntry (   7,   -6), $21, SpriteLarge, $026, 2, 0, false, false
  .structSpriteEntry (  -9,   -6), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry (   7,  -22), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (  -9,  -22), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   5,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -3,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_MagicFrame05
  .word 3 ; sprite count
  .structSpriteEntry (   1,   -7), $00, SpriteSmall, $033, 2, 0, false, false
  .structSpriteEntry (   1,  -15), $00, SpriteSmall, $032, 2, 0, false, false
  .structSpriteEntry (  -7,  -14), $21, SpriteLarge, $024, 2, 0, false, false

_MagicFrame06
  .word 3 ; sprite count
  .structSpriteEntry (   1,  -11), $00, SpriteSmall, $033, 2, 0, false, false
  .structSpriteEntry (   1,  -19), $00, SpriteSmall, $032, 2, 0, false, false
  .structSpriteEntry (  -7,  -15), $21, SpriteLarge, $026, 2, 0, false, false

_MagicFrame07
  .word 3 ; sprite count
  .structSpriteEntry (   1,  -14), $00, SpriteSmall, $033, 2, 0, false, false
  .structSpriteEntry (   1,  -22), $00, SpriteSmall, $032, 2, 0, false, false
  .structSpriteEntry (  -7,  -17), $21, SpriteLarge, $028, 2, 0, false, false

_MagicFrame08
  .word 3 ; sprite count
  .structSpriteEntry (   0,  -17), $00, SpriteSmall, $033, 2, 0, false, false
  .structSpriteEntry (   0,  -25), $00, SpriteSmall, $032, 2, 0, false, false
  .structSpriteEntry (  -7,  -15), $21, SpriteLarge, $026, 2, 0, false, false

_MagicFrame09
  .word 1 ; sprite count
  .structSpriteEntry (  -7,  -17), $21, SpriteLarge, $028, 2, 0, false, false

_MagicFrame0A
  .word 1 ; sprite count
  .structSpriteEntry (  -7,  -15), $21, SpriteLarge, $026, 2, 0, false, false

_MagicFrame0B
  .word 3 ; sprite count
  .structSpriteEntry (   3,   -9), $00, SpriteSmall, $033, 2, 0, false, false
  .structSpriteEntry (   3,  -17), $00, SpriteSmall, $032, 2, 0, false, false
  .structSpriteEntry (  -5,  -15), $21, SpriteLarge, $024, 2, 0, false, false

_MagicFrame0C
  .word 3 ; sprite count
  .structSpriteEntry (   8,   -9), $00, SpriteSmall, $033, 2, 0, false, false
  .structSpriteEntry (   8,  -17), $00, SpriteSmall, $032, 2, 0, false, false
  .structSpriteEntry (  -2,  -17), $21, SpriteLarge, $02A, 2, 0, false, false

_MagicFrameTable
  .word _MagicFrame00 - _Magic
  .word _MagicFrame01 - _Magic
  .word _MagicFrame02 - _Magic
  .word _MagicFrame03 - _Magic
  .word _MagicFrame04 - _Magic
  .word _MagicFrame05 - _Magic
  .word _MagicFrame06 - _Magic
  .word _MagicFrame07 - _Magic
  .word _MagicFrame08 - _Magic
  .word _MagicFrame09 - _Magic
  .word _MagicFrame0A - _Magic
  .word _MagicFrame0B - _Magic
  .word _MagicFrame0C - _Magic

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
  .byte $96, $23, $96, $23, $59, $23, $6B

  MAP_BATTLE_SPRITE_DATA_END $800
