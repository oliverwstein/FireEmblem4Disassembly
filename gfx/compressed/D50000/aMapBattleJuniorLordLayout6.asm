; Map battle sprite data: the format is described in tools/map_battle_layouts.py.

aMapBattleJuniorLordLayout6

  ; Block offsets by weapon type (sword, lance, axe, bow, staff or tome).
  .word _Sword - aMapBattleJuniorLordLayout6
  .word $20F6 ; no lance block
  .word $20F6 ; no axe block
  .word $20F6 ; no bow block
  .word $20F6 ; no magic block

_Sword
  .word _SwordFrameTable - _Sword
  .word _SwordUnknown2 - _Sword, $20F6
  .word _SwordWait - _Sword, $20F6
  .word _SwordDodge - _Sword, $20F6
  .word _SwordStrike - _Sword, $20F6
  .word _SwordRanged - _Sword, $20F6

_SwordFrame00
  .word 6 ; sprite count
  .structSpriteEntry (  -7,    3), $00, SpriteSmall, $043, 2, 0, false, true
  .structSpriteEntry (  -8,   -8), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false

_SwordFrame01
  .word 6 ; sprite count
  .structSpriteEntry (  -7,   -9), $00, SpriteSmall, $043, 2, 0, false, false
  .structSpriteEntry (  -8,   -9), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false

_SwordFrame02
  .word 6 ; sprite count
  .structSpriteEntry (  -7,  -11), $21, SpriteLarge, $048, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -8,  -13), $00, SpriteSmall, $042, 2, 0, false, false

_SwordFrame03
  .word 5 ; sprite count
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -10,   -2), $00, SpriteSmall, $040, 2, 0, true, true

_SwordFrame04
  .word 5 ; sprite count
  .structSpriteEntry ( -13,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   3,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -13,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -5,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (  -8,   -4), $00, SpriteSmall, $040, 2, 0, true, true

_SwordFrame05
  .word 6 ; sprite count
  .structSpriteEntry (   1,    1), $00, SpriteSmall, $040, 2, 0, false, true
  .structSpriteEntry (  -6,   -8), $21, SpriteLarge, $04A, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false

_SwordFrame06
  .word 6 ; sprite count
  .structSpriteEntry (   0,  -11), $00, SpriteSmall, $043, 2, 0, false, false
  .structSpriteEntry (  -6,   -9), $21, SpriteLarge, $04C, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false

_SwordFrame07
  .word 5 ; sprite count
  .structSpriteEntry (  -8,    5), $00, SpriteSmall, $041, 2, 0, false, true
  .structSpriteEntry ( -12,    2), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -14), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -6), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -14), $21, SpriteLarge, $020, 2, 0, false, false

_SwordFrame08
  .word 5 ; sprite count
  .structSpriteEntry ( -13,   -4), $00, SpriteSmall, $041, 2, 0, false, false
  .structSpriteEntry (   4,  -13), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,    3), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry ( -12,  -13), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -4,   -5), $21, SpriteLarge, $022, 2, 0, false, false

_SwordFrame09
  .word 5 ; sprite count
  .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $040, 2, 0, true, false
  .structSpriteEntry (   4,  -12), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,    4), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry ( -12,  -12), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -4,   -4), $21, SpriteLarge, $022, 2, 0, false, false

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
  .byte $F5, $20, $F5, $20, $9B, $20, $6B

  MAP_BATTLE_SPRITE_DATA_END $800
