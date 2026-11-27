; Map battle sprite data: the format is described in tools/map_battle_layouts.py.

aMapBattleCavalierLayout5

  ; Block offsets by weapon type (sword, lance, axe, bow, staff or tome).
  .word _Sword - aMapBattleCavalierLayout5
  .word _Lance - aMapBattleCavalierLayout5
  .word _Axe - aMapBattleCavalierLayout5
  .word _Bow - aMapBattleCavalierLayout5
  .word _Magic - aMapBattleCavalierLayout5

_Sword
  .word _SwordFrameTable - _Sword
  .word _SwordUnknown2 - _Sword, _SwordUnknown4 - _Sword
  .word _SwordWait - _Sword, _SwordWaitAux - _Sword
  .word _SwordDodge - _Sword, _SwordDodgeAux - _Sword
  .word _SwordStrike - _Sword, _SwordStrikeAux - _Sword

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
  .structSpriteEntry ( -18,  -22), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -2,   -6), $21, SpriteLarge, $026, 2, 0, false, false
  .structSpriteEntry ( -18,   -6), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry (  -2,  -22), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (  -2,    2), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry ( -10,    2), $00, SpriteSmall, $01E, 2, 0, false, false

_SwordFrame02
  .word 6 ; sprite count
  .structSpriteEntry (  -5,   -3), $21, SpriteLarge, $026, 2, 0, false, false
  .structSpriteEntry ( -21,   -3), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry (  -5,  -19), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -21,  -19), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -5,    5), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry ( -13,    5), $00, SpriteSmall, $01E, 2, 0, false, false

_SwordFrame03
  .word 2 ; sprite count
  .structSpriteEntry (   1,   -7), $00, SpriteSmall, $020, 2, 0, false, true
  .structSpriteEntry (  -9,  -15), $21, SpriteLarge, $028, 2, 0, false, false

_SwordFrame04
  .word 2 ; sprite count
  .structSpriteEntry (   2,  -15), $00, SpriteSmall, $020, 2, 0, false, false
  .structSpriteEntry (  -9,  -15), $21, SpriteLarge, $026, 2, 0, false, false

_SwordFrame05
  .word 2 ; sprite count
  .structSpriteEntry (  -5,  -18), $00, SpriteSmall, $020, 2, 0, true, false
  .structSpriteEntry (  -9,  -15), $21, SpriteLarge, $024, 2, 0, false, false

_SwordFrame06
  .word 2 ; sprite count
  .structSpriteEntry (  -5,   -1), $00, SpriteSmall, $020, 2, 0, false, true
  .structSpriteEntry ( -15,  -10), $21, SpriteLarge, $02A, 2, 0, false, false

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
  ACTIVE_SPRITE_TABLE_FRAME 1, 6
  ACTIVE_SPRITE_WAIT_STRIKE_DONE
  ACTIVE_SPRITE_TABLE_FRAME 3, 3
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
  .byte $5A, $20, $5A, $20, $FA, $1F

_SwordUnknown4
  .byte $5A, $20, $5A, $20, $01, $20, $6B

_Lance
  .word _LanceFrameTable - _Lance
  .word _LanceUnknown2 - _Lance, _LanceUnknown4 - _Lance
  .word _LanceWait - _Lance, _LanceWaitAux - _Lance
  .word _LanceDodge - _Lance, _LanceDodgeAux - _Lance
  .word _LanceStrike - _Lance, _LanceStrikeAux - _Lance

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
  .structSpriteEntry ( -18,  -22), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -2,   -6), $21, SpriteLarge, $026, 2, 0, false, false
  .structSpriteEntry ( -18,   -6), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry (  -2,  -22), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (  -2,    2), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry ( -10,    2), $00, SpriteSmall, $01E, 2, 0, false, false

_LanceFrame02
  .word 6 ; sprite count
  .structSpriteEntry (  -5,   -3), $21, SpriteLarge, $026, 2, 0, false, false
  .structSpriteEntry ( -21,   -3), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry (  -5,  -19), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -21,  -19), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -5,    5), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry ( -13,    5), $00, SpriteSmall, $01E, 2, 0, false, false

_LanceFrame03
  .word 3 ; sprite count
  .structSpriteEntry (   0,  -14), $00, SpriteSmall, $021, 2, 0, false, false
  .structSpriteEntry (  -6,  -22), $00, SpriteSmall, $020, 2, 0, false, false
  .structSpriteEntry (  -9,  -14), $21, SpriteLarge, $024, 2, 0, false, false

_LanceFrame04
  .word 3 ; sprite count
  .structSpriteEntry (   7,    2), $00, SpriteSmall, $021, 2, 0, false, false
  .structSpriteEntry (   1,   -6), $00, SpriteSmall, $020, 2, 0, false, false
  .structSpriteEntry (  -9,  -14), $21, SpriteLarge, $026, 2, 0, false, false

_LanceFrame05
  .word 1 ; sprite count
  .structSpriteEntry (  -8,  -13), $21, SpriteLarge, $028, 2, 0, false, false

_LanceFrame06
  .word 1 ; sprite count
  .structSpriteEntry (  -9,  -14), $21, SpriteLarge, $026, 2, 0, false, false

_LanceFrame07
  .word 3 ; sprite count
  .structSpriteEntry (  -4,  -13), $00, SpriteSmall, $021, 2, 0, false, false
  .structSpriteEntry ( -10,  -21), $00, SpriteSmall, $020, 2, 0, false, false
  .structSpriteEntry ( -12,  -13), $21, SpriteLarge, $024, 2, 0, false, false

_LanceFrame08
  .word 3 ; sprite count
  .structSpriteEntry (  -6,   -9), $00, SpriteSmall, $021, 2, 0, false, false
  .structSpriteEntry ( -12,  -17), $00, SpriteSmall, $020, 2, 0, false, false
  .structSpriteEntry ( -15,  -10), $21, SpriteLarge, $024, 2, 0, false, false

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
  .byte $95, $21, $95, $21, $31, $21

_LanceUnknown4
  .byte $95, $21, $95, $21, $38, $21, $6B

_Axe
  .word _AxeFrameTable - _Axe
  .word _AxeUnknown2 - _Axe, _AxeUnknown4 - _Axe
  .word _AxeWait - _Axe, _AxeWaitAux - _Axe
  .word _AxeDodge - _Axe, _AxeDodgeAux - _Axe
  .word _AxeStrike - _Axe, _AxeStrikeAux - _Axe

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
  .structSpriteEntry ( -18,  -22), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -2,   -6), $21, SpriteLarge, $026, 2, 0, false, false
  .structSpriteEntry ( -18,   -6), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry (  -2,  -22), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (  -2,    2), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry ( -10,    2), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame02
  .word 6 ; sprite count
  .structSpriteEntry (  -5,   -3), $21, SpriteLarge, $026, 2, 0, false, false
  .structSpriteEntry ( -21,   -3), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry (  -5,  -19), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -21,  -19), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -5,    5), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry ( -13,    5), $00, SpriteSmall, $01E, 2, 0, false, false

_AxeFrame03
  .word 2 ; sprite count
  .structSpriteEntry (   0,   -5), $00, SpriteSmall, $020, 2, 0, false, true
  .structSpriteEntry (  -9,  -15), $21, SpriteLarge, $028, 2, 0, false, false

_AxeFrame04
  .word 2 ; sprite count
  .structSpriteEntry (   3,  -14), $00, SpriteSmall, $022, 2, 0, true, false
  .structSpriteEntry (  -9,  -15), $21, SpriteLarge, $026, 2, 0, false, false

_AxeFrame05
  .word 2 ; sprite count
  .structSpriteEntry (  -5,  -19), $00, SpriteSmall, $020, 2, 0, true, false
  .structSpriteEntry (  -9,  -15), $21, SpriteLarge, $024, 2, 0, false, false

_AxeFrame06
  .word 2 ; sprite count
  .structSpriteEntry (   3,  -12), $00, SpriteSmall, $022, 2, 0, true, false
  .structSpriteEntry (  -9,  -15), $21, SpriteLarge, $026, 2, 0, false, false

_AxeFrame07
  .word 1 ; sprite count
  .structSpriteEntry (  -8,  -14), $21, SpriteLarge, $028, 2, 0, false, false

_AxeFrame08
  .word 2 ; sprite count
  .structSpriteEntry (  -6,    1), $00, SpriteSmall, $020, 2, 0, false, true
  .structSpriteEntry ( -15,  -10), $21, SpriteLarge, $02A, 2, 0, false, false

_AxeFrame09
  .word 2 ; sprite count
  .structSpriteEntry (   5,   -7), $00, SpriteSmall, $020, 2, 0, false, true
  .structSpriteEntry (  -9,  -15), $21, SpriteLarge, $026, 2, 0, false, false

_AxeFrame0A
  .word 2 ; sprite count
  .structSpriteEntry (  10,   -4), $00, SpriteSmall, $022, 2, 0, false, true
  .structSpriteEntry (  -8,  -14), $21, SpriteLarge, $026, 2, 0, false, false

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
  ACTIVE_SPRITE_TABLE_FRAME 1, 8
  ACTIVE_SPRITE_WAIT_STRIKE_DONE
  ACTIVE_SPRITE_TABLE_FRAME 3, 3
  ACTIVE_SPRITE_SIDE_AUX_SCRIPT

_AxeStrike
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_TABLE_FRAME 3, 0
  ACTIVE_SPRITE_TABLE_FRAME 32, 0
  ACTIVE_SPRITE_TABLE_FRAME 7, 0
  ACTIVE_SPRITE_TABLE_FRAME 48, 0
  ACTIVE_SPRITE_TABLE_FRAME 3, 0
  ACTIVE_SPRITE_SIDE_SCRIPT

_AxeStrikeAux
  ACTIVE_SPRITE_TABLE_FRAME 1, 3
  ACTIVE_SPRITE_TABLE_FRAME 3, 4
  ACTIVE_SPRITE_TABLE_FRAME 32, 5
  ACTIVE_SPRITE_TABLE_FRAME 3, 6
  ACTIVE_SPRITE_TABLE_FRAME 1, 9
  ACTIVE_SPRITE_MAP_BATTLE_STRIKE
  ACTIVE_SPRITE_TABLE_FRAME 1, 9
  ACTIVE_SPRITE_TABLE_FRAME 2, 10
  ACTIVE_SPRITE_TABLE_FRAME 48, 7
  ACTIVE_SPRITE_WAIT_STRIKE_TAKEN
  ACTIVE_SPRITE_TABLE_FRAME 3, 3
  ACTIVE_SPRITE_END_ROUND
  ACTIVE_SPRITE_SIDE_AUX_SCRIPT

  ; not reached by any offset
  ACTIVE_SPRITE_END

_AxeUnknown2
  .byte $EC, $22, $EC, $22, $79, $22

_AxeUnknown4
  .byte $EC, $22, $EC, $22, $80, $22, $6B

_Bow
  .word _BowFrameTable - _Bow
  .word _BowUnknown2 - _Bow, _BowUnknown4 - _Bow
  .word _BowWait - _Bow, _BowWaitAux - _Bow
  .word _BowDodge - _Bow, _BowDodgeAux - _Bow
  .word _BowStrike - _Bow, _BowStrikeAux - _Bow

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
  .structSpriteEntry ( -18,  -22), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -2,   -6), $21, SpriteLarge, $026, 2, 0, false, false
  .structSpriteEntry ( -18,   -6), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry (  -2,  -22), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (  -2,    2), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry ( -10,    2), $00, SpriteSmall, $01E, 2, 0, false, false

_BowFrame02
  .word 6 ; sprite count
  .structSpriteEntry (  -5,   -3), $21, SpriteLarge, $026, 2, 0, false, false
  .structSpriteEntry ( -21,   -3), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry (  -5,  -19), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -21,  -19), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -5,    5), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry ( -13,    5), $00, SpriteSmall, $01E, 2, 0, false, false

_BowFrame03
  .word 4 ; sprite count
  .structSpriteEntry (  -2,   -6), $00, SpriteSmall, $021, 2, 0, true, false
  .structSpriteEntry (  -2,  -14), $00, SpriteSmall, $020, 2, 0, true, false
  .structSpriteEntry (   1,   -9), $00, SpriteSmall, $023, 2, 0, false, true
  .structSpriteEntry (  -9,  -15), $21, SpriteLarge, $024, 2, 0, false, false

_BowFrame04
  .word 3 ; sprite count
  .structSpriteEntry (  -2,   -6), $00, SpriteSmall, $021, 2, 0, true, false
  .structSpriteEntry (  -2,  -14), $00, SpriteSmall, $020, 2, 0, true, false
  .structSpriteEntry (  -9,  -15), $21, SpriteLarge, $026, 2, 0, false, false

_BowFrame05
  .word 3 ; sprite count
  .structSpriteEntry (  -2,   -5), $00, SpriteSmall, $021, 2, 0, true, false
  .structSpriteEntry (  -2,  -13), $00, SpriteSmall, $020, 2, 0, true, false
  .structSpriteEntry (  -9,  -15), $21, SpriteLarge, $028, 2, 0, false, false

_BowFrame06
  .word 4 ; sprite count
  .structSpriteEntry (   5,   -3), $00, SpriteSmall, $023, 2, 0, true, false
  .structSpriteEntry (  -3,   -9), $00, SpriteSmall, $021, 2, 0, true, false
  .structSpriteEntry (  -3,  -17), $00, SpriteSmall, $020, 2, 0, true, false
  .structSpriteEntry ( -10,  -16), $21, SpriteLarge, $028, 2, 0, false, false

_BowFrame07
  .word 3 ; sprite count
  .structSpriteEntry (  -2,   -8), $00, SpriteSmall, $021, 2, 0, true, false
  .structSpriteEntry (  -2,  -16), $00, SpriteSmall, $020, 2, 0, true, false
  .structSpriteEntry (  -9,  -15), $21, SpriteLarge, $028, 2, 0, false, false

_BowFrame08
  .word 4 ; sprite count
  .structSpriteEntry (  -4,   -4), $00, SpriteSmall, $021, 2, 0, true, false
  .structSpriteEntry (  -4,  -12), $00, SpriteSmall, $020, 2, 0, true, false
  .structSpriteEntry (  -2,   -8), $00, SpriteSmall, $023, 2, 0, true, false
  .structSpriteEntry ( -11,  -13), $21, SpriteLarge, $024, 2, 0, false, false

_BowFrame09
  .word 4 ; sprite count
  .structSpriteEntry (  -8,   -1), $00, SpriteSmall, $021, 2, 0, true, false
  .structSpriteEntry (  -8,   -9), $00, SpriteSmall, $020, 2, 0, true, false
  .structSpriteEntry (  -6,   -5), $00, SpriteSmall, $023, 2, 0, true, false
  .structSpriteEntry ( -15,  -10), $21, SpriteLarge, $02A, 2, 0, false, false

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
  .word _BowFrame09 - _Bow

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
  ACTIVE_SPRITE_TABLE_FRAME 3, 8
  ACTIVE_SPRITE_TABLE_FRAME 1, 9
  ACTIVE_SPRITE_WAIT_STRIKE_DONE
  ACTIVE_SPRITE_TABLE_FRAME 3, 8
  ACTIVE_SPRITE_SIDE_AUX_SCRIPT

_BowStrike
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_TABLE_FRAME 3, 0
  ACTIVE_SPRITE_TABLE_FRAME 22, 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_TABLE_FRAME 2, 0
  ACTIVE_SPRITE_TABLE_FRAME 48, 0
  ACTIVE_SPRITE_TABLE_FRAME 3, 0
  ACTIVE_SPRITE_SIDE_SCRIPT

_BowStrikeAux
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

  ; not reached by any offset
  ACTIVE_SPRITE_END

_BowUnknown2
  .byte $6E, $24, $6E, $24, $FE, $23

_BowUnknown4
  .byte $6E, $24, $6E, $24, $05, $24, $6B

_Magic
  .word _MagicFrameTable - _Magic
  .word _MagicUnknown2 - _Magic, $205B
  .word _MagicWait - _Magic, $205B
  .word _MagicDodge - _Magic, $205B
  .word _MagicStrike - _Magic, $205B

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
  .structSpriteEntry (  -2,   -6), $21, SpriteLarge, $026, 2, 0, false, false
  .structSpriteEntry ( -18,   -6), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry (  -2,  -22), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -18,  -22), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -2,    2), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry ( -10,    2), $00, SpriteSmall, $01E, 2, 0, false, false

_MagicFrame04
  .word 6 ; sprite count
  .structSpriteEntry (  -5,   -3), $21, SpriteLarge, $026, 2, 0, false, false
  .structSpriteEntry ( -21,   -3), $21, SpriteLarge, $024, 2, 0, false, false
  .structSpriteEntry (  -5,  -19), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -21,  -19), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -5,    5), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry ( -13,    5), $00, SpriteSmall, $01E, 2, 0, false, false

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
  .byte $68, $25, $68, $25, $2B, $25, $6B

  MAP_BATTLE_SPRITE_DATA_END $800
