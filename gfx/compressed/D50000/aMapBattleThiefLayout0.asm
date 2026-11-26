; Map battle sprite data: the format is described in tools/map_battle_layouts.py.

aMapBattleThiefLayout0

  ; Block offsets by weapon type (sword, lance, axe, bow, staff or tome).
  .word _Sword - aMapBattleThiefLayout0
  .word $8167 ; no lance block
  .word $8167 ; no axe block
  .word $8167 ; no bow block
  .word $8167 ; no magic block

_Sword
  .word _SwordFrameTable - _Sword
  .word _SwordUnknown2 - _Sword, $8167
  .word _SwordWait - _Sword, $8167
  .word _SwordDodge - _Sword, $8167
  .word _SwordStrike - _Sword, $8167
  .word _SwordRanged - _Sword, $8167

_SwordFrame00
  .word 7 ; sprite count
  .structSpriteEntry (  -9,    0), $00, SpriteSmall, $040, 2, 0, true, true
  .structSpriteEntry (  -2,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -10,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry ( -10,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   6,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (   2,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -6,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_SwordFrame01
  .word 7 ; sprite count
  .structSpriteEntry ( -10,  -10), $00, SpriteSmall, $040, 2, 0, true, false
  .structSpriteEntry (   6,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -10,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry ( -10,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -2,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   2,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -6,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_SwordFrame02
  .word 7 ; sprite count
  .structSpriteEntry (  -9,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -9,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   7,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -1,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (  -3,  -14), $00, SpriteSmall, $040, 2, 0, false, false
  .structSpriteEntry (   3,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -5,    0), $00, SpriteSmall, $01E, 2, 0, false, false

_SwordFrame03
  .word 7 ; sprite count
  .structSpriteEntry (  -9,   -9), $00, SpriteSmall, $040, 2, 0, true, true
  .structSpriteEntry ( -10,   -5), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   6,  -21), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -2,  -13), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -10,  -21), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -1,    0), $00, SpriteSmall, $00E, 2, 0, false, false
  .structSpriteEntry (  -2,  -15), $00, SpriteSmall, $052, 2, 0, false, true

_SwordFrame04
  .word 7 ; sprite count
  .structSpriteEntry (  -9,  -12), $00, SpriteSmall, $040, 2, 0, true, true
  .structSpriteEntry (  -1,    0), $00, SpriteSmall, $00E, 2, 0, false, false
  .structSpriteEntry (  -2,  -15), $00, SpriteSmall, $052, 2, 0, false, true
  .structSpriteEntry ( -10,   -8), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   6,  -24), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -10,  -24), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -2,  -16), $21, SpriteLarge, $022, 2, 0, false, false

_SwordFrame05
  .word 7 ; sprite count
  .structSpriteEntry ( -11,  -10), $00, SpriteSmall, $041, 2, 0, false, false
  .structSpriteEntry (   5,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -11,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry ( -11,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -3,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry (   1,    0), $00, SpriteSmall, $01F, 2, 0, false, false
  .structSpriteEntry (  -7,    0), $00, SpriteSmall, $01E, 2, 0, false, false

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
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 3
  ACTIVE_SPRITE_TABLE_FRAME 3, 3
  ACTIVE_SPRITE_TABLE_FRAME 1, 4
  ACTIVE_SPRITE_WAIT_STRIKE_DONE
  ACTIVE_SPRITE_TABLE_FRAME 3, 3
  ACTIVE_SPRITE_SIDE_SCRIPT

_SwordStrike
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 1
  ACTIVE_SPRITE_TABLE_FRAME 3, 1
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 2
  ACTIVE_SPRITE_TABLE_FRAME 22, 2
  ACTIVE_SPRITE_MAP_BATTLE_STRIKE
  ACTIVE_SPRITE_TABLE_FRAME 1, 2
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 1
  ACTIVE_SPRITE_TABLE_FRAME 2, 5
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 48, 0
  ACTIVE_SPRITE_WAIT_STRIKE_TAKEN
  ACTIVE_SPRITE_TABLE_FRAME 3, 0
  ACTIVE_SPRITE_END_ROUND
  ACTIVE_SPRITE_SIDE_SCRIPT

_SwordRanged
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 1
  ACTIVE_SPRITE_TABLE_FRAME 4, 1
  ACTIVE_SPRITE_START_MAP_MAGIC
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 2
  ACTIVE_SPRITE_TABLE_FRAME 1, 2
  ACTIVE_SPRITE_WAIT_MAP_MAGIC
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 1
  ACTIVE_SPRITE_TABLE_FRAME 4, 1
  ACTIVE_SPRITE_END_ROUND
  ACTIVE_SPRITE_SIDE_SCRIPT

  ; not reached by any offset
  ACTIVE_SPRITE_END

_SwordUnknown2
  .byte $66, $81, $66, $81, $0A, $81, $6B

  MAP_BATTLE_SPRITE_DATA_END $800
