; Map battle sprite data: the format is described in tools/map_battle_layouts.py.

aMapBattleJuniorLordLayout0

  ; Block offsets by weapon type (sword, lance, axe, bow, staff or tome).
  .word _Sword - aMapBattleJuniorLordLayout0
  .word $20F1 ; no lance block
  .word $20F1 ; no axe block
  .word $20F1 ; no bow block
  .word $20F1 ; no magic block

_Sword
  .word _SwordFrameTable - _Sword
  .word _SwordUnknown2 - _Sword, $20F1
  .word _SwordWait - _Sword, $20F1
  .word _SwordDodge - _Sword, $20F1
  .word _SwordStrike - _Sword, $20F1
  .word _SwordRanged - _Sword, $20F1

_SwordFrame00
  .word 6 ; sprite count
  .structSpriteEntry (  -9,    1), $00, SpriteSmall, $040, 2, 0, true, true
  .structSpriteEntry (  -7,   -9), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry (  -2,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -10,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry ( -10,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   6,  -16), $00, SpriteSmall, $024, 2, 0, false, false

_SwordFrame01
  .word 6 ; sprite count
  .structSpriteEntry ( -10,   -8), $00, SpriteSmall, $040, 2, 0, true, false
  .structSpriteEntry (  -7,   -9), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry ( -10,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   6,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -2,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -10,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_SwordFrame02
  .word 6 ; sprite count
  .structSpriteEntry (  -7,  -11), $21, SpriteLarge, $048, 2, 0, false, false
  .structSpriteEntry ( -10,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   6,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -2,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -10,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -4,  -13), $00, SpriteSmall, $040, 2, 0, false, false

_SwordFrame03
  .word 5 ; sprite count
  .structSpriteEntry ( -10,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   6,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -2,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -10,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -6,   -2), $00, SpriteSmall, $040, 2, 0, true, true

_SwordFrame04
  .word 4 ; sprite count
  .structSpriteEntry (   6,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -10,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry ( -10,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -2,   -8), $21, SpriteLarge, $022, 2, 0, false, false

_SwordFrame05
  .word 6 ; sprite count
  .structSpriteEntry (   1,    3), $00, SpriteSmall, $040, 2, 0, false, true
  .structSpriteEntry (  -3,   -7), $21, SpriteLarge, $04C, 2, 0, false, false
  .structSpriteEntry ( -10,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   6,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -2,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -10,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_SwordFrame06
  .word 6 ; sprite count
  .structSpriteEntry (   4,   -5), $00, SpriteSmall, $040, 2, 0, false, false
  .structSpriteEntry (  -4,   -7), $21, SpriteLarge, $04A, 2, 0, false, false
  .structSpriteEntry ( -10,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   6,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -2,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -10,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_SwordFrame07
  .word 5 ; sprite count
  .structSpriteEntry ( -11,    2), $00, SpriteSmall, $041, 2, 0, false, true
  .structSpriteEntry ( -10,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   6,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -2,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -10,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_SwordFrame08
  .word 5 ; sprite count
  .structSpriteEntry ( -14,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   2,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -6,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -14,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry ( -10,  -14), $00, SpriteSmall, $041, 2, 0, false, false

_SwordFrame09
  .word 5 ; sprite count
  .structSpriteEntry ( -15,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   1,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -7,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -15,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -8,  -14), $00, SpriteSmall, $040, 2, 0, true, false

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

_SwordDodge
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_WAIT_STRIKE
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 4
  ACTIVE_SPRITE_TABLE_FRAME 3, 3
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 5
  ACTIVE_SPRITE_TABLE_FRAME 1, 4
  ACTIVE_SPRITE_WAIT_STRIKE_DONE
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 4
  ACTIVE_SPRITE_TABLE_FRAME 3, 3
  ACTIVE_SPRITE_SIDE_SCRIPT

_SwordStrike
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 1
  ACTIVE_SPRITE_TABLE_FRAME 3, 5
  ACTIVE_SPRITE_TABLE_FRAME 16, 6
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 2
  ACTIVE_SPRITE_TABLE_FRAME 3, 7
  ACTIVE_SPRITE_MAP_BATTLE_STRIKE
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 3
  ACTIVE_SPRITE_TABLE_FRAME 3, 8
  ACTIVE_SPRITE_TABLE_FRAME 48, 9
  ACTIVE_SPRITE_WAIT_STRIKE_TAKEN
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
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
  .byte $F0, $20, $F0, $20, $96, $20, $6B

  MAP_BATTLE_SPRITE_DATA_END $800
