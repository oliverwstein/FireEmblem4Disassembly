; Map battle sprite data: the format is described in tools/map_battle_layouts.py.

aMapBattleDancerLayout4

  ; Block offsets by weapon type (sword, lance, axe, bow, staff or tome).
  .word _Sword - aMapBattleDancerLayout4
  .word $8174 ; no lance block
  .word $8174 ; no axe block
  .word $8174 ; no bow block
  .word _Magic - aMapBattleDancerLayout4

_Sword
  .word _SwordFrameTable - _Sword
  .word _SwordUnknown2 - _Sword, $8174
  .word _SwordWait - _Sword, $8174
  .word _SwordDodge - _Sword, $8174
  .word _SwordStrike - _Sword, $8174
  .word _SwordRanged - _Sword, $8174

_SwordFrame00
  .word 6 ; sprite count
  .structSpriteEntry (  -8,   -7), $21, SpriteLarge, $044, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   0,   -2), $00, SpriteSmall, $040, 2, 0, false, true

_SwordFrame01
  .word 6 ; sprite count
  .structSpriteEntry (  -7,   -8), $21, SpriteLarge, $046, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   0,  -11), $00, SpriteSmall, $040, 2, 0, false, false

_SwordFrame02
  .word 5 ; sprite count
  .structSpriteEntry (  -6,  -14), $00, SpriteSmall, $040, 2, 0, true, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_SwordFrame03
  .word 5 ; sprite count
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -6,   -9), $00, SpriteSmall, $041, 2, 0, false, false

_SwordFrame04
  .word 5 ; sprite count
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (   8,   -3), $00, SpriteSmall, $041, 2, 0, true, true

_SwordFrame05
  .word 5 ; sprite count
  .structSpriteEntry (   6,   -9), $00, SpriteSmall, $040, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_SwordFrame06
  .word 5 ; sprite count
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -2,  -10), $00, SpriteSmall, $040, 2, 0, false, false

_SwordFrame07
  .word 5 ; sprite count
  .structSpriteEntry (  -4,   -7), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry ( -12,    1), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -15), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -3,  -10), $00, SpriteSmall, $040, 2, 0, false, false

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

_SwordDodge
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_WAIT_STRIKE
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 4
  ACTIVE_SPRITE_TABLE_FRAME 3, 6
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 5
  ACTIVE_SPRITE_TABLE_FRAME 1, 7
  ACTIVE_SPRITE_WAIT_STRIKE_DONE
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 3, 6
  ACTIVE_SPRITE_SIDE_SCRIPT

_SwordStrike
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_TABLE_FRAME 3, 1
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 1
  ACTIVE_SPRITE_TABLE_FRAME 7, 2
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 2
  ACTIVE_SPRITE_TABLE_FRAME 2, 3
  ACTIVE_SPRITE_MAP_BATTLE_STRIKE
  ACTIVE_SPRITE_TABLE_FRAME 1, 3
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 3
  ACTIVE_SPRITE_TABLE_FRAME 2, 4
  ACTIVE_SPRITE_TABLE_FRAME 48, 5
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
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 1
  ACTIVE_SPRITE_TABLE_FRAME 1, 2
  ACTIVE_SPRITE_WAIT_MAP_MAGIC
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 4, 1
  ACTIVE_SPRITE_END_ROUND
  ACTIVE_SPRITE_SIDE_SCRIPT

  ; not reached by any offset
  ACTIVE_SPRITE_END

_SwordUnknown2
  .byte $73, $81, $73, $81, $12, $81, $6B

_Magic
  .word _MagicFrameTable - _Magic
  .word _MagicUnknown2 - _Magic, $8174
  .word _MagicWait - _Magic, $8174
  .word $8174, $8174
  .word _MagicStrike - _Magic, $8174

_MagicFrame00
  .word 4 ; sprite count
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false

_MagicFrame01
  .word 5 ; sprite count
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,   -8), $00, SpriteSmall, $040, 2, 0, true, false

_MagicFrame02
  .word 4 ; sprite count
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_MagicFrame03
  .word 4 ; sprite count
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_MagicFrame04
  .word 4 ; sprite count
  .structSpriteEntry ( -12,    0), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -16), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,   -8), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $020, 2, 0, false, false

_MagicFrame05
  .word 5 ; sprite count
  .structSpriteEntry (  -4,  -12), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,   -4), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -20), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,  -20), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -4,    0), $00, SpriteSmall, $00E, 2, 0, false, false

_MagicFrame06
  .word 5 ; sprite count
  .structSpriteEntry (  -4,  -13), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,   -5), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -21), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry ( -12,  -21), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -4,    0), $00, SpriteSmall, $00E, 2, 0, false, false

_MagicFrame07
  .word 5 ; sprite count
  .structSpriteEntry ( -12,  -21), $21, SpriteLarge, $020, 2, 0, false, false
  .structSpriteEntry (  -4,  -13), $21, SpriteLarge, $022, 2, 0, false, false
  .structSpriteEntry ( -12,   -5), $00, SpriteSmall, $034, 2, 0, false, false
  .structSpriteEntry (   4,  -21), $00, SpriteSmall, $024, 2, 0, false, false
  .structSpriteEntry (  -4,    0), $00, SpriteSmall, $00E, 2, 0, false, false

_MagicFrameTable
  .word _MagicFrame00 - _Magic
  .word _MagicFrame01 - _Magic
  .word _MagicFrame02 - _Magic
  .word _MagicFrame03 - _Magic
  .word _MagicFrame04 - _Magic
  .word _MagicFrame05 - _Magic
  .word _MagicFrame06 - _Magic
  .word _MagicFrame07 - _Magic

_MagicWait
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_WAIT_ROUND
  ACTIVE_SPRITE_ROUND_SCRIPT

_MagicStrike
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 0
  ACTIVE_SPRITE_TABLE_FRAME 1, 0
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 1
  ACTIVE_SPRITE_TABLE_FRAME 4, 1
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 2
  ACTIVE_SPRITE_TABLE_FRAME 3, 2
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 3
  ACTIVE_SPRITE_TABLE_FRAME 4, 3
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 1
  ACTIVE_SPRITE_TABLE_FRAME 3, 1
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 2
  ACTIVE_SPRITE_TABLE_FRAME 4, 2
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 3
  ACTIVE_SPRITE_TABLE_FRAME 3, 3
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 1
  ACTIVE_SPRITE_TABLE_FRAME 4, 1
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 2
  ACTIVE_SPRITE_TABLE_FRAME 3, 2
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 3
  ACTIVE_SPRITE_TABLE_FRAME 4, 3
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 1
  ACTIVE_SPRITE_TABLE_FRAME 3, 1
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 2
  ACTIVE_SPRITE_TABLE_FRAME 4, 2
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 3
  ACTIVE_SPRITE_TABLE_FRAME 3, 3
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 4
  ACTIVE_SPRITE_TABLE_FRAME 12, 4
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 5
  ACTIVE_SPRITE_TABLE_FRAME 3, 5
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 6
  ACTIVE_SPRITE_TABLE_FRAME 6, 6
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 7
  ACTIVE_SPRITE_TABLE_FRAME 32, 7
  ACTIVE_SPRITE_MAP_BATTLE_FRAME 5
  ACTIVE_SPRITE_TABLE_FRAME 3, 5
  ACTIVE_SPRITE_END_ROUND
  ACTIVE_SPRITE_SIDE_SCRIPT

  ; not reached by any offset
  ACTIVE_SPRITE_END

_MagicUnknown2
  .byte $C4, $82, $C4, $82, $5A, $82, $6B

  MAP_BATTLE_SPRITE_DATA_END $800
