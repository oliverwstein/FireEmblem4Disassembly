; Battle animation frame data in bank $9A: sequence data blocks and frame tables
; reached from aBattleAnimationFrameTables. Written by tools/battle_frames.py;
; formats and macros in include/BattleAnimation.h.

    .section BattleAnimationFrameData9ASection

      aBattleAnimationFramesKnightLordSword ; 9A/BA2A

        ; Frame table of entries 18, 19, 20, 21, 22, 23: slices of the class sheet per frame.

        .word _Frame00 - aBattleAnimationFramesKnightLordSword
        .word _Frame01 - aBattleAnimationFramesKnightLordSword
        .word _Frame02 - aBattleAnimationFramesKnightLordSword
        .word _Frame03 - aBattleAnimationFramesKnightLordSword
        .word _Frame04 - aBattleAnimationFramesKnightLordSword
        .word _Frame05 - aBattleAnimationFramesKnightLordSword
        .word _Frame06 - aBattleAnimationFramesKnightLordSword
        .word _Frame07 - aBattleAnimationFramesKnightLordSword
        .word _Frame08 - aBattleAnimationFramesKnightLordSword
        .word _Frame09 - aBattleAnimationFramesKnightLordSword
        .word _Frame10 - aBattleAnimationFramesKnightLordSword
        .word _Frame11 - aBattleAnimationFramesKnightLordSword

      _Frame00
        ANIM_TILES
        ANIM_TILE_ROW $0000, $0380
        ANIM_TILES_END

      _Frame01
        ANIM_TILES
        ANIM_TILE_ROW $0380, $03C0
        ANIM_TILES_END

      _Frame02
        ANIM_TILES
        ANIM_TILE_ROW $0740, $03A0
        ANIM_TILES_END

      _Frame03
        ANIM_TILES
        ANIM_TILE_ROW $0AE0, $0380
        ANIM_TILES_END

      _Frame04
        ANIM_TILES
        ANIM_TILE_ROW $0E60, $0380
        ANIM_TILES_END

      _Frame05
        ANIM_TILES
        ANIM_TILE_ROW $11E0, $01E0
        ANIM_TILE_ROW $13C0, $0100
        ANIM_TILES_END

      _Frame06
        ANIM_TILES
        ANIM_TILE_ROW $14C0, $01C0
        ANIM_TILE_ROW $1680, $0100
        ANIM_TILES_END

      _Frame07
        ANIM_TILES
        ANIM_TILE_ROW $1780, $01E0
        ANIM_TILE_ROW $1960, $0100
        ANIM_TILES_END

      _Frame08
        ANIM_TILES
        ANIM_TILE_ROW $1A60, $0160
        ANIM_TILE_ROW $1BC0, $0080
        ANIM_TILES_END

      _Frame09
        ANIM_TILES
        ANIM_TILE_ROW $1C40, $01A0
        ANIM_TILE_ROW $1DE0, $0040
        ANIM_TILES_END

      _Frame10
        ANIM_TILES
        ANIM_TILE_ROW $1E20, $01A0
        ANIM_TILE_ROW $1FC0, $0080
        ANIM_TILES_END

      _Frame11
        ANIM_TILES
        ANIM_TILE_ROW $2040, $0160
        ANIM_TILE_ROW $21A0, $0080
        ANIM_TILES_END

      aBattleAnimationSequencesKnightLordSword ; 9A/BA9A

        ; Sequence data of entry 18 of aBattleAnimationFrameTables, used by: KnightLord (Sword),
        ; MasterKnight (Sword), MasterKnight (Axe), Paladin (Sword), PaladinF (Sword), Ranger
        ; (Sword), MageKnight (Sword), GreatKnight (Axe). Frames:
        ; aBattleAnimationFramesKnightLordSword.

        .word _Index - aBattleAnimationSequencesKnightLordSword, _Records - aBattleAnimationSequencesKnightLordSword

      _Index
        .word _Sequence00 - aBattleAnimationSequencesKnightLordSword
        .word _Sequence01 - aBattleAnimationSequencesKnightLordSword
        .word _Sequence02 - aBattleAnimationSequencesKnightLordSword
        .word _Sequence03 - aBattleAnimationSequencesKnightLordSword
        .word _Sequence04 - aBattleAnimationSequencesKnightLordSword
        .word _Sequence05 - aBattleAnimationSequencesKnightLordSword
        .word _Sequence06 - aBattleAnimationSequencesKnightLordSword
        .word _Sequence07 - aBattleAnimationSequencesKnightLordSword
        .word _Sequence08 - aBattleAnimationSequencesKnightLordSword
        .word _Sequence09 - aBattleAnimationSequencesKnightLordSword
        .word _Sequence10 - aBattleAnimationSequencesKnightLordSword
        .word _Sequence11 - aBattleAnimationSequencesKnightLordSword
        .word _Sequence12 - aBattleAnimationSequencesKnightLordSword
        .word _Sequence13 - aBattleAnimationSequencesKnightLordSword
        .word _Sequence14 - aBattleAnimationSequencesKnightLordSword

      _Records
        .word aBattleAnimationSequencesMasterKnightMagic._Record00 - aBattleAnimationSequencesKnightLordSword
        .word aBattleAnimationSequencesMasterKnightMagic._Record01 - aBattleAnimationSequencesKnightLordSword
        .word aBattleAnimationSequencesMasterKnightMagic._Record02 - aBattleAnimationSequencesKnightLordSword
        .word aBattleAnimationSequencesMasterKnightMagic._Record03 - aBattleAnimationSequencesKnightLordSword
        .word aBattleAnimationSequencesMasterKnightMagic._Record04 - aBattleAnimationSequencesKnightLordSword
        .word aBattleAnimationSequencesMasterKnightMagic._Record05 - aBattleAnimationSequencesKnightLordSword
        .word aBattleAnimationSequencesMasterKnightMagic._Record06 - aBattleAnimationSequencesKnightLordSword
        .word aBattleAnimationSequencesMasterKnightMagic._Record07 - aBattleAnimationSequencesKnightLordSword
        .word aBattleAnimationSequencesMasterKnightMagic._Record08 - aBattleAnimationSequencesKnightLordSword
        .word aBattleAnimationSequencesMasterKnightMagic._Record09 - aBattleAnimationSequencesKnightLordSword
        .word aBattleAnimationSequencesMasterKnightMagic._Record10 - aBattleAnimationSequencesKnightLordSword
        .word aBattleAnimationSequencesMasterKnightMagic._Record11 - aBattleAnimationSequencesKnightLordSword
        .word aBattleAnimationSequencesMasterKnightMagic._Record12 - aBattleAnimationSequencesKnightLordSword
        .word aBattleAnimationSequencesMasterKnightMagic._Record13 - aBattleAnimationSequencesKnightLordSword
        .word aBattleAnimationSequencesMasterKnightMagic._Record14 - aBattleAnimationSequencesKnightLordSword
        .word aBattleAnimationSequencesMasterKnightMagic._Record15 - aBattleAnimationSequencesKnightLordSword
        .word aBattleAnimationSequencesMasterKnightMagic._Record16 - aBattleAnimationSequencesKnightLordSword
        .word aBattleAnimationSequencesMasterKnightMagic._Record17 - aBattleAnimationSequencesKnightLordSword
        .word aBattleAnimationSequencesMasterKnightMagic._Record18 - aBattleAnimationSequencesKnightLordSword
        .word aBattleAnimationSequencesMasterKnightMagic._Record19 - aBattleAnimationSequencesKnightLordSword
        .word aBattleAnimationSequencesMasterKnightMagic._Record20 - aBattleAnimationSequencesKnightLordSword
        .word aBattleAnimationSequencesMasterKnightMagic._Record21 - aBattleAnimationSequencesKnightLordSword
        .word aBattleAnimationSequencesMasterKnightMagic._Record22 - aBattleAnimationSequencesKnightLordSword
        .word aBattleAnimationSequencesMasterKnightMagic._Record23 - aBattleAnimationSequencesKnightLordSword
        .word aBattleAnimationSequencesMasterKnightMagic._Record24 - aBattleAnimationSequencesKnightLordSword
        .word aBattleAnimationSequencesMasterKnightMagic._Record25 - aBattleAnimationSequencesKnightLordSword
        .word aBattleAnimationSequencesMasterKnightMagic._Record26 - aBattleAnimationSequencesKnightLordSword
        .word aBattleAnimationSequencesMasterKnightMagic._Record27 - aBattleAnimationSequencesKnightLordSword
        .word aBattleAnimationSequencesMasterKnightMagic._Record28 - aBattleAnimationSequencesKnightLordSword

      _Sequence00
        ANIM_CLEAR_BUSY
        ANIM_STEP 6, 2
        ANIM_HOLD

      _Sequence01
        ANIM_SOUND 19
        ANIM_STEP 7, 7
        ANIM_STEP 8, 4
        ANIM_STEP 7, 7
        ANIM_STEP 6, 1
        ANIM_CMD_F4 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence02
        ANIM_SOUND 19
        ANIM_STEP 15, 2
        ANIM_STEP 10, 3
        ANIM_STEP 9, 4
        ANIM_STEP 8, 4
        ANIM_STEP 7, 4
        ANIM_STEP 6, 1
        ANIM_CMD_F4 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence03
        ANIM_STEP 1, 1
        ANIM_SOUND 25
        ANIM_STEP 1, 4
        ANIM_STEP 2, 13
        ANIM_STEP 4, 13
        ANIM_STEP 5, 3
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence04
        ANIM_SOUND 26
        ANIM_STEP 7, 5
        ANIM_STEP 9, 5
        ANIM_STEP 10, 4
        ANIM_STEP 11, 2
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence05
        ANIM_STEP 12, 2
        ANIM_STEP 13, 4
        ANIM_CMD_EE
        ANIM_STEP 14, 4
        ANIM_STEP 14, 6
        ANIM_SOUND 0
        ANIM_STEP 16, 2
        ANIM_STEP 17, 2
        ANIM_STEP 15, 2
        ANIM_CMD_F1
        ANIM_STEP 15, 5
        ANIM_CMD_F3
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence06
        ANIM_SOUND 25
        ANIM_STEP 1, 2
        ANIM_STEP 2, 5
        ANIM_STEP 4, 6
        ANIM_STEP 5, 2
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence07
        ANIM_SOUND 19
        ANIM_STEP 6, 4
        ANIM_STEP 7, 4
        ANIM_STEP 8, 5
        ANIM_STEP 9, 3
        ANIM_STEP 11, 2
        ANIM_STEP 12, 3
        ANIM_STEP 13, 3
        ANIM_STEP 14, 3
        ANIM_CMD_EE
        ANIM_STEP 14, 10
        ANIM_SOUND 0
        ANIM_STEP 16, 2
        ANIM_STEP 17, 2
        ANIM_STEP 15, 2
        ANIM_CMD_F1
        ANIM_STEP 15, 5
        ANIM_CMD_F3
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence08
        ANIM_STEP 11, 4
        ANIM_STEP 12, 3
        ANIM_STEP 13, 6
        ANIM_STEP 14, 22
        ANIM_STEP 16, 2
        ANIM_STEP 17, 2
        ANIM_SOUND 0
        ANIM_CMD_EE
        ANIM_STEP 15, 2
        ANIM_STEP 14, 4
        ANIM_SOUND 0
        ANIM_STEP 16, 2
        ANIM_STEP 17, 2
        ANIM_SOUND 0
        ANIM_STEP 15, 2
        ANIM_SOUND 0
        ANIM_STEP 14, 5
        ANIM_SOUND 0
        ANIM_STEP 16, 2
        ANIM_STEP 17, 2
        ANIM_SOUND 0
        ANIM_CMD_F1
        ANIM_STEP 15, 5
        ANIM_CMD_F3
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence09
        ANIM_SOUND 19
        ANIM_STEP 6, 4
        ANIM_STEP 7, 4
        ANIM_STEP 8, 5
        ANIM_STEP 9, 3
        ANIM_STEP 11, 3
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence10
        ANIM_STEP 10, 2
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence11
        ANIM_CLEAR_BUSY
        ANIM_STEP 10, 5
        ANIM_STEP 11, 4
        ANIM_STEP 12, 6
        ANIM_STEP 13, 4
        ANIM_STEP 18, 1
        ANIM_SOUND 32
        ANIM_CMD_F0 3
        ANIM_STEP 18, 1
        ANIM_CMD_F4 1
        ANIM_STEP 19, 1
        ANIM_CMD_F4 1
        ANIM_STEP 11, 5
        ANIM_STEP 10, 5
        ANIM_HOLD

      _Sequence12
        ANIM_CLEAR_BUSY
        ANIM_STEP 10, 5
        ANIM_HOLD

      _Sequence13
        ANIM_CLEAR_BUSY
        ANIM_SOUND 19
        ANIM_STEP 6, 4
        ANIM_STEP 7, 4
        ANIM_STEP 8, 5
        ANIM_STEP 9, 3
        ANIM_STEP 10, 3
        ANIM_HOLD

      _Sequence14
        ANIM_STEP 1, 3
        ANIM_STEP 2, 4
        ANIM_STEP 4, 4
        ANIM_STEP 5, 4
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      aBattleAnimationSequencesMasterKnightRangedAxe ; 9A/BC1A

        ; Sequence data of entry 21 of aBattleAnimationFrameTables, used by: MasterKnight
        ; (RangedAxe), GreatKnight (RangedAxe). Frames: aBattleAnimationFramesKnightLordSword.

        .word _Index - aBattleAnimationSequencesMasterKnightRangedAxe, _Records - aBattleAnimationSequencesMasterKnightRangedAxe

      _Index
        .word _Sequence00 - aBattleAnimationSequencesMasterKnightRangedAxe
        .word _Sequence01 - aBattleAnimationSequencesMasterKnightRangedAxe
        .word _Sequence02 - aBattleAnimationSequencesMasterKnightRangedAxe
        .word _Sequence03 - aBattleAnimationSequencesMasterKnightRangedAxe
        .word _Sequence04 - aBattleAnimationSequencesMasterKnightRangedAxe
        .word _Sequence05 - aBattleAnimationSequencesMasterKnightRangedAxe
        .word _Sequence06 - aBattleAnimationSequencesMasterKnightRangedAxe
        .word _Sequence07 - aBattleAnimationSequencesMasterKnightRangedAxe
        .word _Sequence08 - aBattleAnimationSequencesMasterKnightRangedAxe
        .word _Sequence09 - aBattleAnimationSequencesMasterKnightRangedAxe
        .word _Sequence10 - aBattleAnimationSequencesMasterKnightRangedAxe
        .word _Sequence11 - aBattleAnimationSequencesMasterKnightRangedAxe
        .word _Sequence12 - aBattleAnimationSequencesMasterKnightRangedAxe
        .word _Sequence13 - aBattleAnimationSequencesMasterKnightRangedAxe
        .word _Sequence14 - aBattleAnimationSequencesMasterKnightRangedAxe
        .word _Sequence15 - aBattleAnimationSequencesMasterKnightRangedAxe

      _Records
        .word aBattleAnimationSequencesMasterKnightMagic._Record00 - aBattleAnimationSequencesMasterKnightRangedAxe
        .word aBattleAnimationSequencesMasterKnightMagic._Record01 - aBattleAnimationSequencesMasterKnightRangedAxe
        .word aBattleAnimationSequencesMasterKnightMagic._Record02 - aBattleAnimationSequencesMasterKnightRangedAxe
        .word aBattleAnimationSequencesMasterKnightMagic._Record03 - aBattleAnimationSequencesMasterKnightRangedAxe
        .word aBattleAnimationSequencesMasterKnightMagic._Record04 - aBattleAnimationSequencesMasterKnightRangedAxe
        .word aBattleAnimationSequencesMasterKnightMagic._Record05 - aBattleAnimationSequencesMasterKnightRangedAxe
        .word aBattleAnimationSequencesMasterKnightMagic._Record06 - aBattleAnimationSequencesMasterKnightRangedAxe
        .word aBattleAnimationSequencesMasterKnightMagic._Record07 - aBattleAnimationSequencesMasterKnightRangedAxe
        .word aBattleAnimationSequencesMasterKnightMagic._Record08 - aBattleAnimationSequencesMasterKnightRangedAxe
        .word aBattleAnimationSequencesMasterKnightMagic._Record09 - aBattleAnimationSequencesMasterKnightRangedAxe
        .word aBattleAnimationSequencesMasterKnightMagic._Record10 - aBattleAnimationSequencesMasterKnightRangedAxe
        .word aBattleAnimationSequencesMasterKnightMagic._Record11 - aBattleAnimationSequencesMasterKnightRangedAxe
        .word aBattleAnimationSequencesMasterKnightMagic._Record12 - aBattleAnimationSequencesMasterKnightRangedAxe
        .word aBattleAnimationSequencesMasterKnightMagic._Record13 - aBattleAnimationSequencesMasterKnightRangedAxe
        .word aBattleAnimationSequencesMasterKnightMagic._Record14 - aBattleAnimationSequencesMasterKnightRangedAxe
        .word aBattleAnimationSequencesMasterKnightMagic._Record15 - aBattleAnimationSequencesMasterKnightRangedAxe
        .word aBattleAnimationSequencesMasterKnightMagic._Record16 - aBattleAnimationSequencesMasterKnightRangedAxe
        .word aBattleAnimationSequencesMasterKnightMagic._Record17 - aBattleAnimationSequencesMasterKnightRangedAxe
        .word aBattleAnimationSequencesMasterKnightMagic._Record18 - aBattleAnimationSequencesMasterKnightRangedAxe
        .word aBattleAnimationSequencesMasterKnightMagic._Record19 - aBattleAnimationSequencesMasterKnightRangedAxe
        .word aBattleAnimationSequencesMasterKnightMagic._Record20 - aBattleAnimationSequencesMasterKnightRangedAxe
        .word aBattleAnimationSequencesMasterKnightMagic._Record21 - aBattleAnimationSequencesMasterKnightRangedAxe
        .word aBattleAnimationSequencesMasterKnightMagic._Record22 - aBattleAnimationSequencesMasterKnightRangedAxe
        .word aBattleAnimationSequencesMasterKnightMagic._Record23 - aBattleAnimationSequencesMasterKnightRangedAxe
        .word aBattleAnimationSequencesMasterKnightMagic._Record24 - aBattleAnimationSequencesMasterKnightRangedAxe
        .word aBattleAnimationSequencesMasterKnightMagic._Record25 - aBattleAnimationSequencesMasterKnightRangedAxe
        .word aBattleAnimationSequencesMasterKnightMagic._Record26 - aBattleAnimationSequencesMasterKnightRangedAxe
        .word aBattleAnimationSequencesMasterKnightMagic._Record27 - aBattleAnimationSequencesMasterKnightRangedAxe
        .word aBattleAnimationSequencesMasterKnightMagic._Record28 - aBattleAnimationSequencesMasterKnightRangedAxe

      _Sequence00
        ANIM_CLEAR_BUSY
        ANIM_STEP 6, 1
        ANIM_HOLD

      _Sequence01
        ANIM_STEP 1, 5
        ANIM_STEP 2, 22
        ANIM_STEP 3, 16
        ANIM_STEP 4, 6
        ANIM_STEP 5, 8

      _Sequence02
        ANIM_CLEAR_BUSY
        ANIM_STEP 10, 2
        ANIM_HOLD

      _Sequence03
        ANIM_STEP 4, 16

      _Sequence04
        ANIM_STEP 0, 16
        ANIM_STEP 13, 4
        ANIM_STEP 14, 22
        ANIM_STEP 6, 1
        ANIM_STEP 7, 1
        ANIM_STEP 5, 80

      _Sequence05
        ANIM_STEP 6, 16

      _Sequence06
        ANIM_SOUND 19
        ANIM_STEP 7, 7
        ANIM_STEP 8, 8
        ANIM_STEP 7, 7
        ANIM_STEP 6, 1
        ANIM_CMD_F4 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence07
        ANIM_STEP 10, 32
        ANIM_STEP 11, 5
        ANIM_STEP 12, 6
        ANIM_STEP 13, 4
        ANIM_STEP 18, 35
        ANIM_STEP 16, 3
        ANIM_STEP 17, 2
        ANIM_STEP 15, 10
        ANIM_STEP 14, 9
        ANIM_STEP 16, 3
        ANIM_STEP 17, 2
        ANIM_STEP 15, 10
        ANIM_STEP 14, 9
        ANIM_STEP 16, 3
        ANIM_STEP 17, 2
        ANIM_STEP 15, 10

      _Sequence08
        ANIM_STEP 10, 32
        ANIM_STEP 11, 5
        ANIM_STEP 12, 6
        ANIM_STEP 13, 4
        ANIM_STEP 18, 35
        ANIM_STEP 19, 48

      _Sequence09
        ANIM_STEP 10, 32
        ANIM_STEP 11, 3
        ANIM_STEP 12, 3
        ANIM_STEP 13, 2
        ANIM_STEP 14, 32
        ANIM_STEP 16, 3
        ANIM_STEP 17, 2
        ANIM_STEP 15, 32

      _Sequence10
        ANIM_STEP 10, 5
        ANIM_STEP 20, 3
        ANIM_STEP 9, 6
        ANIM_STEP 8, 5
        ANIM_STEP 7, 6
        ANIM_STEP 6, 5
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence11
        ANIM_CMD_EB
        ANIM_STEP 22, 2
        ANIM_STEP 23, 2
        ANIM_STEP 24, 2
        ANIM_STEP 25, 2
        ANIM_STEP 26, 2
        ANIM_STEP 27, 2
        ANIM_STEP 28, 2
        ANIM_RESTART
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence12
        ANIM_STEP 10, 3
        ANIM_STEP 11, 3
        ANIM_STEP 12, 4
        ANIM_STEP 13, 4
        ANIM_STEP 18, 19
        ANIM_CMD_EE
        ANIM_CMD_EF 139
        ANIM_SOUND 12
        ANIM_STEP 21, 1
        ANIM_CMD_F4 1
        ANIM_STEP 13, 4
        ANIM_STEP 18, 18
        ANIM_STEP 12, 6
        ANIM_STEP 11, 4
        ANIM_STEP 10, 5
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence13
        ANIM_STEP 0, 16
        ANIM_STEP 18, 4
        ANIM_STEP 19, 22
        ANIM_STEP 11, 1
        ANIM_STEP 12, 1
        ANIM_STEP 10, 80
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence14
        ANIM_SOUND 19
        ANIM_STEP 6, 5
        ANIM_STEP 7, 5
        ANIM_STEP 8, 5
        ANIM_STEP 9, 5
        ANIM_STEP 10, 5
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence15
        ANIM_SOUND 19
        ANIM_STEP 10, 2
        ANIM_STEP 20, 2
        ANIM_STEP 9, 3
        ANIM_STEP 8, 7
        ANIM_STEP 7, 7
        ANIM_STEP 6, 1
        ANIM_CMD_F4 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      aBattleAnimationSequencesMasterKnightStaff ; 9A/BD66

        ; Sequence data of entry 22 of aBattleAnimationFrameTables, used by: MasterKnight (Staff),
        ; PaladinF (Staff). Frames: aBattleAnimationFramesKnightLordSword.

        .word _Index - aBattleAnimationSequencesMasterKnightStaff, _Records - aBattleAnimationSequencesMasterKnightStaff

      _Index
        .word _Sequence00 - aBattleAnimationSequencesMasterKnightStaff
        .word _Sequence01 - aBattleAnimationSequencesMasterKnightStaff
        .word _Sequence02 - aBattleAnimationSequencesMasterKnightStaff
        .word _Sequence03 - aBattleAnimationSequencesMasterKnightStaff
        .word _Sequence04 - aBattleAnimationSequencesMasterKnightStaff
        .word _Sequence05 - aBattleAnimationSequencesMasterKnightStaff
        .word _Sequence06 - aBattleAnimationSequencesMasterKnightStaff
        .word _Sequence07 - aBattleAnimationSequencesMasterKnightStaff
        .word _Sequence08 - aBattleAnimationSequencesMasterKnightStaff
        .word _Sequence09 - aBattleAnimationSequencesMasterKnightStaff
        .word _Sequence10 - aBattleAnimationSequencesMasterKnightStaff
        .word _Sequence11 - aBattleAnimationSequencesMasterKnightStaff
        .word _Sequence12 - aBattleAnimationSequencesMasterKnightStaff
        .word _Sequence13 - aBattleAnimationSequencesMasterKnightStaff

      _Records
        .word aBattleAnimationSequencesMasterKnightMagic._Record00 - aBattleAnimationSequencesMasterKnightStaff
        .word aBattleAnimationSequencesMasterKnightMagic._Record01 - aBattleAnimationSequencesMasterKnightStaff
        .word aBattleAnimationSequencesMasterKnightMagic._Record02 - aBattleAnimationSequencesMasterKnightStaff
        .word aBattleAnimationSequencesMasterKnightMagic._Record03 - aBattleAnimationSequencesMasterKnightStaff
        .word aBattleAnimationSequencesMasterKnightMagic._Record04 - aBattleAnimationSequencesMasterKnightStaff
        .word aBattleAnimationSequencesMasterKnightMagic._Record05 - aBattleAnimationSequencesMasterKnightStaff
        .word aBattleAnimationSequencesMasterKnightMagic._Record06 - aBattleAnimationSequencesMasterKnightStaff
        .word aBattleAnimationSequencesMasterKnightMagic._Record07 - aBattleAnimationSequencesMasterKnightStaff
        .word aBattleAnimationSequencesMasterKnightMagic._Record08 - aBattleAnimationSequencesMasterKnightStaff
        .word aBattleAnimationSequencesMasterKnightMagic._Record09 - aBattleAnimationSequencesMasterKnightStaff
        .word aBattleAnimationSequencesMasterKnightMagic._Record10 - aBattleAnimationSequencesMasterKnightStaff
        .word aBattleAnimationSequencesMasterKnightMagic._Record11 - aBattleAnimationSequencesMasterKnightStaff
        .word aBattleAnimationSequencesMasterKnightMagic._Record12 - aBattleAnimationSequencesMasterKnightStaff
        .word aBattleAnimationSequencesMasterKnightMagic._Record13 - aBattleAnimationSequencesMasterKnightStaff
        .word aBattleAnimationSequencesMasterKnightMagic._Record14 - aBattleAnimationSequencesMasterKnightStaff
        .word aBattleAnimationSequencesMasterKnightMagic._Record15 - aBattleAnimationSequencesMasterKnightStaff
        .word aBattleAnimationSequencesMasterKnightMagic._Record16 - aBattleAnimationSequencesMasterKnightStaff
        .word aBattleAnimationSequencesMasterKnightMagic._Record17 - aBattleAnimationSequencesMasterKnightStaff
        .word aBattleAnimationSequencesMasterKnightMagic._Record18 - aBattleAnimationSequencesMasterKnightStaff
        .word aBattleAnimationSequencesMasterKnightMagic._Record19 - aBattleAnimationSequencesMasterKnightStaff
        .word aBattleAnimationSequencesMasterKnightMagic._Record20 - aBattleAnimationSequencesMasterKnightStaff
        .word aBattleAnimationSequencesMasterKnightMagic._Record21 - aBattleAnimationSequencesMasterKnightStaff
        .word aBattleAnimationSequencesMasterKnightMagic._Record22 - aBattleAnimationSequencesMasterKnightStaff
        .word aBattleAnimationSequencesMasterKnightMagic._Record23 - aBattleAnimationSequencesMasterKnightStaff
        .word aBattleAnimationSequencesMasterKnightMagic._Record24 - aBattleAnimationSequencesMasterKnightStaff
        .word aBattleAnimationSequencesMasterKnightMagic._Record25 - aBattleAnimationSequencesMasterKnightStaff
        .word aBattleAnimationSequencesMasterKnightMagic._Record26 - aBattleAnimationSequencesMasterKnightStaff
        .word aBattleAnimationSequencesMasterKnightMagic._Record27 - aBattleAnimationSequencesMasterKnightStaff
        .word aBattleAnimationSequencesMasterKnightMagic._Record28 - aBattleAnimationSequencesMasterKnightStaff

      _Sequence00
        ANIM_CLEAR_BUSY
        ANIM_STEP 6, 1
        ANIM_HOLD

      _Sequence01
        ANIM_STEP 1, 5
        ANIM_STEP 2, 22
        ANIM_STEP 3, 16
        ANIM_STEP 4, 6
        ANIM_STEP 5, 8

      _Sequence02
        ANIM_SOUND 19
        ANIM_STEP 7, 5
        ANIM_STEP 8, 5
        ANIM_STEP 9, 5
        ANIM_STEP 10, 5
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence03
        ANIM_STEP 19, 9
        ANIM_STEP 11, 6
        ANIM_STEP 10, 5
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence04
        ANIM_STEP 0, 16
        ANIM_STEP 13, 4
        ANIM_STEP 14, 22
        ANIM_STEP 6, 1
        ANIM_STEP 7, 1
        ANIM_STEP 5, 80

      _Sequence05
        ANIM_STEP 6, 16

      _Sequence06
        ANIM_SOUND 19
        ANIM_STEP 7, 7
        ANIM_STEP 8, 8
        ANIM_STEP 7, 7
        ANIM_STEP 6, 1
        ANIM_CMD_F4 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence07
        ANIM_STEP 10, 32
        ANIM_STEP 11, 5
        ANIM_STEP 12, 6
        ANIM_STEP 13, 4
        ANIM_STEP 18, 35
        ANIM_STEP 16, 3
        ANIM_STEP 17, 2
        ANIM_STEP 15, 10
        ANIM_STEP 14, 9
        ANIM_STEP 16, 3
        ANIM_STEP 17, 2
        ANIM_STEP 15, 10
        ANIM_STEP 14, 9
        ANIM_STEP 16, 3
        ANIM_STEP 17, 2
        ANIM_STEP 15, 10

      _Sequence08
        ANIM_STEP 11, 5
        ANIM_STEP 12, 6
        ANIM_STEP 13, 4
        ANIM_STEP 18, 34
        ANIM_SOUND 32
        ANIM_CMD_F0 3
        ANIM_STEP 18, 1
        ANIM_CMD_F4 1
        ANIM_STEP 19, 1
        ANIM_CMD_F4 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence09
        ANIM_STEP 10, 32
        ANIM_STEP 11, 3
        ANIM_STEP 12, 3
        ANIM_STEP 13, 2
        ANIM_STEP 14, 32
        ANIM_STEP 16, 3
        ANIM_STEP 17, 2
        ANIM_STEP 15, 32

      _Sequence10
        ANIM_SOUND 19
        ANIM_STEP 20, 3
        ANIM_STEP 9, 4
        ANIM_STEP 8, 7
        ANIM_STEP 7, 7
        ANIM_STEP 6, 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence11
        ANIM_STEP 22, 2
        ANIM_STEP 23, 2
        ANIM_STEP 24, 2
        ANIM_STEP 25, 2
        ANIM_STEP 26, 2
        ANIM_STEP 27, 2
        ANIM_STEP 28, 2

      _Sequence12
        ANIM_STEP 10, 32
        ANIM_STEP 11, 5
        ANIM_STEP 12, 6
        ANIM_STEP 13, 4
        ANIM_STEP 18, 35
        ANIM_STEP 21, 48
        ANIM_STEP 18, 48

      _Sequence13
        ANIM_STEP 0, 16
        ANIM_STEP 18, 4
        ANIM_STEP 19, 22
        ANIM_STEP 11, 1
        ANIM_STEP 12, 1
        ANIM_STEP 10, 80
        ; (no end marker: the next structure begins here)

      aBattleAnimationSequencesMasterKnightMagic ; 9A/BE86

        ; Sequence data of entry 23 of aBattleAnimationFrameTables, used by: MasterKnight (Magic),
        ; MageKnight (Magic). Frames: aBattleAnimationFramesKnightLordSword.

        .word _Index - aBattleAnimationSequencesMasterKnightMagic, _Records - aBattleAnimationSequencesMasterKnightMagic

      _Index
        .word _Sequence00 - aBattleAnimationSequencesMasterKnightMagic
        .word _Sequence01 - aBattleAnimationSequencesMasterKnightMagic
        .word _Sequence02 - aBattleAnimationSequencesMasterKnightMagic
        .word _Sequence03 - aBattleAnimationSequencesMasterKnightMagic
        .word _Sequence04 - aBattleAnimationSequencesMasterKnightMagic
        .word _Sequence05 - aBattleAnimationSequencesMasterKnightMagic
        .word _Sequence06 - aBattleAnimationSequencesMasterKnightMagic
        .word _Sequence07 - aBattleAnimationSequencesMasterKnightMagic
        .word _Sequence08 - aBattleAnimationSequencesMasterKnightMagic
        .word _Sequence09 - aBattleAnimationSequencesMasterKnightMagic
        .word _Sequence10 - aBattleAnimationSequencesMasterKnightMagic
        .word _Sequence11 - aBattleAnimationSequencesMasterKnightMagic
        .word _Sequence12 - aBattleAnimationSequencesMasterKnightMagic
        .word _Sequence13 - aBattleAnimationSequencesMasterKnightMagic

      _Records
        .word _Record00 - aBattleAnimationSequencesMasterKnightMagic
        .word _Record01 - aBattleAnimationSequencesMasterKnightMagic
        .word _Record02 - aBattleAnimationSequencesMasterKnightMagic
        .word _Record03 - aBattleAnimationSequencesMasterKnightMagic
        .word _Record04 - aBattleAnimationSequencesMasterKnightMagic
        .word _Record05 - aBattleAnimationSequencesMasterKnightMagic
        .word _Record06 - aBattleAnimationSequencesMasterKnightMagic
        .word _Record07 - aBattleAnimationSequencesMasterKnightMagic
        .word _Record08 - aBattleAnimationSequencesMasterKnightMagic
        .word _Record09 - aBattleAnimationSequencesMasterKnightMagic
        .word _Record10 - aBattleAnimationSequencesMasterKnightMagic
        .word _Record11 - aBattleAnimationSequencesMasterKnightMagic
        .word _Record12 - aBattleAnimationSequencesMasterKnightMagic
        .word _Record13 - aBattleAnimationSequencesMasterKnightMagic
        .word _Record14 - aBattleAnimationSequencesMasterKnightMagic
        .word _Record15 - aBattleAnimationSequencesMasterKnightMagic
        .word _Record16 - aBattleAnimationSequencesMasterKnightMagic
        .word _Record17 - aBattleAnimationSequencesMasterKnightMagic
        .word _Record18 - aBattleAnimationSequencesMasterKnightMagic
        .word _Record19 - aBattleAnimationSequencesMasterKnightMagic
        .word _Record20 - aBattleAnimationSequencesMasterKnightMagic
        .word _Record21 - aBattleAnimationSequencesMasterKnightMagic
        .word _Record22 - aBattleAnimationSequencesMasterKnightMagic
        .word _Record23 - aBattleAnimationSequencesMasterKnightMagic
        .word _Record24 - aBattleAnimationSequencesMasterKnightMagic
        .word _Record25 - aBattleAnimationSequencesMasterKnightMagic
        .word _Record26 - aBattleAnimationSequencesMasterKnightMagic
        .word _Record27 - aBattleAnimationSequencesMasterKnightMagic
        .word _Record28 - aBattleAnimationSequencesMasterKnightMagic

      _Sequence00
        ANIM_CLEAR_BUSY
        ANIM_STEP 6, 1
        ANIM_HOLD

      _Sequence01
        ANIM_STEP 1, 5
        ANIM_STEP 2, 22
        ANIM_STEP 3, 16
        ANIM_STEP 4, 6
        ANIM_STEP 5, 8

      _Sequence02
        ANIM_SOUND 19
        ANIM_STEP 7, 5
        ANIM_STEP 8, 5
        ANIM_STEP 9, 5
        ANIM_STEP 10, 5
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence03
        ANIM_STEP 19, 9
        ANIM_STEP 11, 6
        ANIM_STEP 10, 5
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence04
        ANIM_STEP 0, 16
        ANIM_STEP 13, 4
        ANIM_STEP 14, 22
        ANIM_STEP 6, 1
        ANIM_STEP 7, 1
        ANIM_STEP 5, 80

      _Sequence05
        ANIM_STEP 6, 16

      _Sequence06
        ANIM_SOUND 19
        ANIM_STEP 7, 7
        ANIM_STEP 8, 8
        ANIM_STEP 7, 7
        ANIM_STEP 6, 1
        ANIM_CMD_F4 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence07
        ANIM_STEP 10, 32
        ANIM_STEP 11, 5
        ANIM_STEP 12, 6
        ANIM_STEP 13, 4
        ANIM_STEP 18, 35
        ANIM_STEP 16, 3
        ANIM_STEP 17, 2
        ANIM_STEP 15, 10
        ANIM_STEP 14, 9
        ANIM_STEP 16, 3
        ANIM_STEP 17, 2
        ANIM_STEP 15, 10
        ANIM_STEP 14, 9
        ANIM_STEP 16, 3
        ANIM_STEP 17, 2
        ANIM_STEP 15, 10

      _Sequence08
        ANIM_STEP 11, 5
        ANIM_STEP 12, 6
        ANIM_STEP 13, 4
        ANIM_STEP 18, 34
        ANIM_SOUND 32
        ANIM_CMD_F0 3
        ANIM_STEP 18, 1
        ANIM_CMD_F4 1
        ANIM_STEP 19, 1
        ANIM_CMD_F4 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence09
        ANIM_STEP 10, 32
        ANIM_STEP 11, 3
        ANIM_STEP 12, 3
        ANIM_STEP 13, 2
        ANIM_STEP 14, 32
        ANIM_STEP 16, 3
        ANIM_STEP 17, 2
        ANIM_STEP 15, 32

      _Sequence10
        ANIM_SOUND 19
        ANIM_STEP 20, 3
        ANIM_STEP 9, 4
        ANIM_STEP 8, 7
        ANIM_STEP 7, 7
        ANIM_STEP 6, 1
        ANIM_CMD_F4 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence11
        ANIM_STEP 22, 2
        ANIM_STEP 23, 2
        ANIM_STEP 24, 2
        ANIM_STEP 25, 2
        ANIM_STEP 26, 2
        ANIM_STEP 27, 2
        ANIM_STEP 28, 2

      _Sequence12
        ANIM_STEP 10, 32
        ANIM_STEP 11, 5
        ANIM_STEP 12, 6
        ANIM_STEP 13, 4
        ANIM_STEP 18, 35
        ANIM_STEP 21, 48
        ANIM_STEP 18, 48

      _Sequence13
        ANIM_STEP 0, 16
        ANIM_STEP 18, 4
        ANIM_STEP 19, 22
        ANIM_STEP 11, 1
        ANIM_STEP 12, 1
        ANIM_STEP 10, 80
        ; (no end marker: the next structure begins here)

      _Record00
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry ( -12,   -1), $00, SpriteSmall, $0F1, 2, 3, false, false
        .structSpriteEntry (   4,   -1), $00, SpriteSmall, $0F2, 2, 3, false, false
        .structSpriteEntry (  -4,   -1), $00, SpriteSmall, $0F1, 2, 3, false, false
        .structSpriteEntry (  20,   -1), $00, SpriteSmall, $0F3, 2, 3, false, false
        .structSpriteEntry (  12,   -1), $00, SpriteSmall, $0F2, 2, 3, false, false
        .structSpriteEntry ( -20,   -1), $00, SpriteSmall, $0F1, 2, 3, false, false
        .structSpriteEntry ( -28,   -1), $00, SpriteSmall, $0F0, 2, 3, false, false
        ANIM_RECORD_END

      _Record01
        ANIM_RECORD 0
        .structSpriteEntry (  11,  -25), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   3,  -25), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   3,  -41), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  -5,  -34), $21, SpriteLarge, $0A2, 2, 0, false, false
        .structSpriteEntry (  -5,  -50), $21, SpriteLarge, $082, 2, 0, false, false
        .structSpriteEntry (  -9,  -15), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry (  -9,  -23), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry (  -9,  -31), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (  -9,  -39), $00, SpriteSmall, $00B, 2, 1, false, false
        .structSpriteEntry ( -25,  -23), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -25,  -39), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  -1,  -39), $00, SpriteSmall, $00C, 2, 1, false, false
        .structSpriteEntry (   7,  -15), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry (   7,  -31), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry (  -9,  -47), $00, SpriteSmall, $00D, 2, 1, false, false
        .structSpriteEntry ( -17,  -47), $00, SpriteSmall, $00E, 2, 1, false, false
        .structSpriteEntry ( -25,  -47), $00, SpriteSmall, $00F, 2, 1, false, false
        .structSpriteEntry (  -1,   -7), $00, SpriteSmall, $018, 2, 1, false, false
        .structSpriteEntry (  -1,  -15), $00, SpriteSmall, $019, 2, 1, false, false
        .structSpriteEntry (  -1,  -23), $00, SpriteSmall, $01A, 2, 1, false, false
        .structSpriteEntry (  -1,  -31), $00, SpriteSmall, $01B, 2, 1, false, false
        .structSpriteEntry (  -9,  -44), $00, SpriteSmall, $052, 2, 2, false, true
        .structSpriteEntry ( -17,  -44), $00, SpriteSmall, $051, 2, 2, false, true
        .structSpriteEntry ( -25,  -44), $00, SpriteSmall, $050, 2, 2, false, true
        ANIM_RECORD_END

      _Record02
        ANIM_RECORD 1
        .structSpriteEntry (   8,  -28), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   0,  -28), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   0,  -44), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  -5,  -38), $21, SpriteLarge, $0A4, 2, 0, false, false
        .structSpriteEntry (  -5,  -54), $21, SpriteLarge, $084, 2, 0, false, false
        .structSpriteEntry ( -24,  -23), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -24,  -39), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  -8,  -23), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry (  -8,  -31), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry (  -8,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (  -8,  -47), $00, SpriteSmall, $00B, 2, 1, false, false
        .structSpriteEntry (   0,  -15), $00, SpriteSmall, $00C, 2, 1, false, false
        .structSpriteEntry (   0,  -23), $00, SpriteSmall, $00D, 2, 1, false, false
        .structSpriteEntry (   0,  -31), $00, SpriteSmall, $00E, 2, 1, false, false
        .structSpriteEntry (   0,  -39), $00, SpriteSmall, $00F, 2, 1, false, false
        .structSpriteEntry (  24,   -7), $00, SpriteSmall, $018, 2, 1, false, false
        .structSpriteEntry (  24,  -15), $00, SpriteSmall, $019, 2, 1, false, false
        .structSpriteEntry (  24,  -23), $00, SpriteSmall, $01A, 2, 1, false, false
        .structSpriteEntry (  24,  -31), $00, SpriteSmall, $01B, 2, 1, false, false
        .structSpriteEntry (   8,  -15), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry (   8,  -31), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -16,  -47), $00, SpriteSmall, $01C, 2, 1, false, false
        .structSpriteEntry ( -24,  -47), $00, SpriteSmall, $01D, 2, 1, false, false
        .structSpriteEntry (  -9,  -46), $00, SpriteSmall, $052, 2, 2, false, true
        .structSpriteEntry ( -17,  -46), $00, SpriteSmall, $051, 2, 2, false, true
        .structSpriteEntry ( -25,  -46), $00, SpriteSmall, $050, 2, 2, false, true
        ANIM_RECORD_END

      _Record03
        ANIM_RECORD 2
        .structSpriteEntry (   5,  -28), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (  -3,  -28), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  -3,  -44), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  -7,  -37), $21, SpriteLarge, $0A4, 2, 0, false, false
        .structSpriteEntry (  -7,  -53), $21, SpriteLarge, $084, 2, 0, false, false
        .structSpriteEntry ( -28,  -15), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry ( -28,  -23), $00, SpriteSmall, $00B, 2, 1, false, false
        .structSpriteEntry ( -28,  -31), $00, SpriteSmall, $00C, 2, 1, false, false
        .structSpriteEntry ( -28,  -39), $00, SpriteSmall, $00D, 2, 1, false, false
        .structSpriteEntry ( -28,  -47), $00, SpriteSmall, $00E, 2, 1, false, false
        .structSpriteEntry ( -20,  -15), $00, SpriteSmall, $00F, 2, 1, false, false
        .structSpriteEntry ( -20,  -31), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -20,  -47), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (   4,  -15), $00, SpriteSmall, $01A, 2, 1, false, false
        .structSpriteEntry (  12,  -23), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry (   4,  -23), $00, SpriteSmall, $01B, 2, 1, false, false
        .structSpriteEntry (  -4,  -23), $00, SpriteSmall, $01C, 2, 1, false, false
        .structSpriteEntry (  12,  -39), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry ( -11,  -45), $00, SpriteSmall, $052, 2, 2, false, true
        .structSpriteEntry ( -19,  -45), $00, SpriteSmall, $051, 2, 2, false, true
        .structSpriteEntry ( -27,  -45), $00, SpriteSmall, $050, 2, 2, false, true
        ANIM_RECORD_END

      _Record04
        ANIM_RECORD 3
        .structSpriteEntry (   6,  -27), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (  -2,  -27), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  -2,  -43), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  -8,  -36), $21, SpriteLarge, $0A6, 2, 0, false, false
        .structSpriteEntry (  -8,  -52), $21, SpriteLarge, $086, 2, 0, false, false
        .structSpriteEntry (  21,  -31), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry (  21,  -15), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry (  21,  -23), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry (  13,  -15), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry (  13,  -23), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (   5,  -23), $00, SpriteSmall, $00B, 2, 1, false, false
        .structSpriteEntry (   5,  -39), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (  -3,  -23), $00, SpriteSmall, $00C, 2, 1, false, false
        .structSpriteEntry (  -3,  -31), $00, SpriteSmall, $00D, 2, 1, false, false
        .structSpriteEntry (  -3,  -39), $00, SpriteSmall, $00E, 2, 1, false, false
        .structSpriteEntry ( -11,  -39), $00, SpriteSmall, $00F, 2, 1, false, false
        .structSpriteEntry ( -19,   -7), $00, SpriteSmall, $016, 2, 1, false, false
        .structSpriteEntry ( -27,   -7), $00, SpriteSmall, $017, 2, 0, false, false
        .structSpriteEntry ( -11,  -15), $00, SpriteSmall, $018, 2, 1, false, false
        .structSpriteEntry ( -11,  -23), $00, SpriteSmall, $019, 2, 1, false, false
        .structSpriteEntry ( -11,  -31), $00, SpriteSmall, $01A, 2, 1, false, false
        .structSpriteEntry ( -27,  -23), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry ( -27,  -39), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -13,  -43), $00, SpriteSmall, $052, 2, 2, false, true
        .structSpriteEntry ( -21,  -43), $00, SpriteSmall, $051, 2, 2, false, true
        .structSpriteEntry ( -29,  -43), $00, SpriteSmall, $050, 2, 2, false, true
        .structSpriteEntry ( -20,    1), $00, SpriteSmall, $01B, 2, 1, false, false
        ANIM_RECORD_END

      _Record05
        ANIM_RECORD 4
        .structSpriteEntry (   6,  -26), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (  -2,  -26), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  -2,  -42), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  -8,  -35), $21, SpriteLarge, $0A6, 2, 0, false, false
        .structSpriteEntry (  -8,  -51), $21, SpriteLarge, $086, 2, 0, false, false
        .structSpriteEntry (  13,  -22), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (  21,  -30), $00, SpriteSmall, $00B, 2, 1, false, false
        .structSpriteEntry (  -3,   -6), $00, SpriteSmall, $00C, 2, 1, false, false
        .structSpriteEntry ( -11,   -6), $00, SpriteSmall, $00D, 2, 1, false, false
        .structSpriteEntry ( -19,   -6), $00, SpriteSmall, $00E, 2, 1, false, false
        .structSpriteEntry ( -27,   -6), $00, SpriteSmall, $00F, 2, 1, false, false
        .structSpriteEntry (   5,  -14), $00, SpriteSmall, $01A, 2, 1, false, false
        .structSpriteEntry (   5,  -22), $00, SpriteSmall, $01B, 2, 1, false, false
        .structSpriteEntry (   5,  -38), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -11,  -22), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry ( -27,  -22), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -11,  -38), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -27,  -38), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry ( -13,  -42), $00, SpriteSmall, $052, 2, 2, false, true
        .structSpriteEntry ( -21,  -42), $00, SpriteSmall, $051, 2, 2, false, true
        .structSpriteEntry ( -29,  -42), $00, SpriteSmall, $050, 2, 2, false, true
        ANIM_RECORD_END

      _Record06
        ANIM_RECORD 5
        .structSpriteEntry (   7,  -23), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (  -1,  -23), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  -1,  -39), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  -8,  -34), $21, SpriteLarge, $0A0, 2, 0, false, false
        .structSpriteEntry (  -8,  -50), $21, SpriteLarge, $080, 2, 0, false, false
        .structSpriteEntry (   2,  -15), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   2,  -31), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  -6,   -7), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry (  -6,  -15), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry (  -6,  -23), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (  -6,  -31), $00, SpriteSmall, $00B, 2, 1, false, false
        .structSpriteEntry (  -6,  -39), $00, SpriteSmall, $00C, 2, 1, false, false
        .structSpriteEntry ( -14,  -39), $00, SpriteSmall, $00D, 2, 1, false, false
        .structSpriteEntry ( -22,  -39), $00, SpriteSmall, $00E, 2, 1, false, false
        .structSpriteEntry ( -22,  -15), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -22,  -31), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -20,  -43), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry ( -20,  -59), $21, SpriteLarge, $048, 2, 2, false, false
        ANIM_RECORD_END

      _Record07
        ANIM_RECORD 6
        .structSpriteEntry (   6,  -22), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (  -2,  -22), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  -2,  -38), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  -7,  -32), $21, SpriteLarge, $0A2, 2, 0, false, false
        .structSpriteEntry (  -7,  -48), $21, SpriteLarge, $082, 2, 0, false, false
        .structSpriteEntry ( -24,  -15), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry ( -24,  -23), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -24,  -31), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry ( -24,  -39), $00, SpriteSmall, $00B, 2, 1, false, false
        .structSpriteEntry (   0,  -15), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   0,  -31), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  -8,   -7), $00, SpriteSmall, $00C, 2, 1, false, false
        .structSpriteEntry ( -16,   -7), $00, SpriteSmall, $00D, 2, 1, false, false
        .structSpriteEntry ( -16,  -23), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -16,  -39), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -14,  -46), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry ( -30,  -46), $21, SpriteLarge, $044, 2, 2, false, false
        ANIM_RECORD_END

      _Record08
        ANIM_RECORD 7
        .structSpriteEntry (  11,  -24), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   3,  -24), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   3,  -40), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  -5,  -33), $21, SpriteLarge, $0A2, 2, 0, false, false
        .structSpriteEntry (  -5,  -49), $21, SpriteLarge, $082, 2, 0, false, false
        .structSpriteEntry (   0,  -15), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   0,  -31), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry ( -16,  -10), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry ( -24,  -10), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry (  -8,  -10), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (  -8,  -18), $00, SpriteSmall, $00B, 2, 1, false, false
        .structSpriteEntry (  -8,  -26), $00, SpriteSmall, $00C, 2, 1, false, false
        .structSpriteEntry (  -8,  -34), $00, SpriteSmall, $00D, 2, 1, false, false
        .structSpriteEntry (  -8,  -42), $00, SpriteSmall, $00E, 2, 1, false, false
        .structSpriteEntry ( -24,  -26), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -24,  -42), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -11,  -47), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry ( -27,  -47), $21, SpriteLarge, $044, 2, 2, false, false
        ANIM_RECORD_END

      _Record09
        ANIM_RECORD 10
        .structSpriteEntry ( -30,  -46), $21, SpriteLarge, $044, 2, 2, false, false
        .structSpriteEntry (  -8,  -27), $00, SpriteSmall, $0B8, 2, 0, false, false
        .structSpriteEntry (  -8,  -35), $00, SpriteSmall, $0A8, 2, 0, false, false
        .structSpriteEntry (  12,  -15), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry (  12,  -23), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry (  -4,  -23), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $00B, 2, 1, false, false
        .structSpriteEntry (   4,  -23), $00, SpriteSmall, $00C, 2, 1, false, false
        .structSpriteEntry (  -4,  -15), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -14,  -46), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (   2,  -27), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   2,  -43), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  10,  -27), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (  -8,  -51), $21, SpriteLarge, $088, 2, 0, false, false
        ANIM_RECORD_END

      _Record10
        ANIM_RECORD 11
        .structSpriteEntry (  -8,  -27), $00, SpriteSmall, $0B8, 2, 0, false, false
        .structSpriteEntry (  -8,  -35), $00, SpriteSmall, $0A8, 2, 0, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (  -4,  -23), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry ( -30,  -46), $21, SpriteLarge, $044, 2, 2, false, false
        .structSpriteEntry ( -14,  -46), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry (  10,  -27), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   2,  -43), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   2,  -27), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  -8,  -51), $21, SpriteLarge, $088, 2, 0, false, false
        ANIM_RECORD_END

      _Record11
        ANIM_RECORD 11
        .structSpriteEntry ( -18,  -48), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry ( -34,  -48), $21, SpriteLarge, $044, 2, 2, false, false
        .structSpriteEntry (  -8,  -27), $00, SpriteSmall, $0B9, 2, 0, false, false
        .structSpriteEntry (  -8,  -35), $00, SpriteSmall, $0A9, 2, 0, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -16,  -43), $00, SpriteSmall, $0D7, 2, 0, false, false
        .structSpriteEntry (  -4,  -23), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (   2,  -42), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  10,  -26), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   2,  -26), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  -8,  -51), $21, SpriteLarge, $0C8, 2, 0, false, false
        ANIM_RECORD_END

      _Record12
        ANIM_RECORD 11
        .structSpriteEntry ( -21,  -57), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry ( -21,  -73), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry ( -16,  -51), $00, SpriteSmall, $0CD, 2, 0, false, false
        .structSpriteEntry (  -8,  -27), $00, SpriteSmall, $0B9, 2, 0, false, false
        .structSpriteEntry (  -8,  -35), $00, SpriteSmall, $0A9, 2, 0, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (  -4,  -23), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (   1,  -41), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   9,  -25), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   1,  -25), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  -8,  -51), $21, SpriteLarge, $0CE, 2, 0, false, false
        ANIM_RECORD_END

      _Record13
        ANIM_RECORD 11
        .structSpriteEntry ( -21,  -59), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry ( -21,  -75), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry (  -8,  -27), $00, SpriteSmall, $0BA, 2, 0, false, false
        .structSpriteEntry (  -8,  -35), $00, SpriteSmall, $0AA, 2, 0, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -16,  -53), $00, SpriteSmall, $0CD, 2, 0, false, false
        .structSpriteEntry (  -4,  -23), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (   0,  -43), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   8,  -27), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   0,  -27), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  -8,  -51), $21, SpriteLarge, $0CA, 2, 0, false, false
        ANIM_RECORD_END

      _Record14
        ANIM_RECORD 11
        .structSpriteEntry ( -11,  -60), $21, SpriteLarge, $04E, 2, 2, false, false
        .structSpriteEntry ( -11,  -76), $21, SpriteLarge, $04C, 2, 2, false, false
        .structSpriteEntry (  -8,  -27), $00, SpriteSmall, $0BA, 2, 0, false, false
        .structSpriteEntry (  -8,  -35), $00, SpriteSmall, $0AA, 2, 0, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (  -8,  -59), $00, SpriteSmall, $0DD, 2, 0, false, false
        .structSpriteEntry (  -4,  -23), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (   0,  -43), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   8,  -27), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   0,  -27), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  -8,  -51), $21, SpriteLarge, $0EE, 2, 0, false, false
        ANIM_RECORD_END

      _Record15
        ANIM_RECORD 11
        .structSpriteEntry ( -24,  -36), $21, SpriteLarge, $042, 2, 2, false, false
        .structSpriteEntry ( -40,  -36), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry ( -17,  -35), $00, SpriteSmall, $0D3, 2, 0, false, false
        .structSpriteEntry ( -17,  -43), $00, SpriteSmall, $0C3, 2, 0, false, false
        .structSpriteEntry (  -9,  -27), $00, SpriteSmall, $0D6, 2, 0, false, false
        .structSpriteEntry (  -9,  -35), $00, SpriteSmall, $0C6, 2, 0, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (  -4,  -23), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  -1,  -31), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  -1,  -47), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  -9,  -51), $21, SpriteLarge, $0C4, 2, 0, false, false
        .structSpriteEntry (   7,  -31), $00, SpriteSmall, $063, 2, 3, false, false
        ANIM_RECORD_END

      _Record16
        ANIM_RECORD 11
        .structSpriteEntry ( -43,  -33), $00, SpriteSmall, $0E7, 2, 2, false, false
        .structSpriteEntry ( -51,  -33), $00, SpriteSmall, $0E6, 2, 2, false, false
        .structSpriteEntry ( -51,  -49), $21, SpriteLarge, $0E8, 2, 2, false, false
        .structSpriteEntry ( -51,  -65), $21, SpriteLarge, $0EA, 2, 2, false, false
        .structSpriteEntry ( -17,  -35), $00, SpriteSmall, $0D3, 2, 0, false, false
        .structSpriteEntry ( -17,  -43), $00, SpriteSmall, $0C3, 2, 0, false, false
        .structSpriteEntry (  -9,  -27), $00, SpriteSmall, $0D6, 2, 0, false, false
        .structSpriteEntry (  -9,  -35), $00, SpriteSmall, $0C6, 2, 0, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (  -4,  -23), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  -1,  -47), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   7,  -31), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (  -1,  -31), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  -9,  -51), $21, SpriteLarge, $0C4, 2, 0, false, false
        ANIM_RECORD_END

      _Record17
        ANIM_RECORD 11
        .structSpriteEntry ( -44,  -32), $21, SpriteLarge, $0EC, 2, 2, false, false
        .structSpriteEntry ( -17,  -35), $00, SpriteSmall, $0D3, 2, 0, false, false
        .structSpriteEntry ( -17,  -43), $00, SpriteSmall, $0C3, 2, 0, false, false
        .structSpriteEntry (  -9,  -27), $00, SpriteSmall, $0D6, 2, 0, false, false
        .structSpriteEntry (  -9,  -35), $00, SpriteSmall, $0C6, 2, 0, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (  -4,  -23), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  -1,  -47), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   7,  -31), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (  -1,  -31), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  -9,  -51), $21, SpriteLarge, $0C4, 2, 0, false, false
        ANIM_RECORD_END

      _Record18
        ANIM_RECORD 11
        .structSpriteEntry ( -13,  -60), $21, SpriteLarge, $04E, 2, 2, false, false
        .structSpriteEntry ( -13,  -76), $21, SpriteLarge, $04C, 2, 2, false, false
        .structSpriteEntry (  -9,  -59), $00, SpriteSmall, $0E3, 2, 0, false, false
        .structSpriteEntry (  -8,  -27), $00, SpriteSmall, $0BA, 2, 0, false, false
        .structSpriteEntry (  -8,  -35), $00, SpriteSmall, $0AA, 2, 0, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (  -4,  -23), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (   0,  -43), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   8,  -27), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   0,  -27), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  -9,  -51), $21, SpriteLarge, $0E4, 2, 0, false, false
        ANIM_RECORD_END

      _Record19
        ANIM_RECORD 11
        .structSpriteEntry ( -17,  -35), $00, SpriteSmall, $0E0, 2, 0, false, false
        .structSpriteEntry ( -25,  -52), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry ( -41,  -52), $21, SpriteLarge, $044, 2, 2, false, false
        .structSpriteEntry ( -25,  -43), $00, SpriteSmall, $0D1, 2, 0, false, false
        .structSpriteEntry ( -17,  -43), $00, SpriteSmall, $0D2, 2, 0, false, false
        .structSpriteEntry ( -17,  -51), $00, SpriteSmall, $0C2, 2, 0, false, false
        .structSpriteEntry (  -9,  -27), $00, SpriteSmall, $0D6, 2, 0, false, false
        .structSpriteEntry (  -9,  -35), $00, SpriteSmall, $0C6, 2, 0, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (  -4,  -23), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  -1,  -47), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   7,  -31), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (  -1,  -31), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  -9,  -51), $21, SpriteLarge, $0C4, 2, 0, false, false
        ANIM_RECORD_END

      _Record20
        ANIM_RECORD 9
        .structSpriteEntry ( -30,  -46), $21, SpriteLarge, $044, 2, 2, false, false
        .structSpriteEntry (  -8,  -27), $00, SpriteSmall, $0B8, 2, 0, false, false
        .structSpriteEntry (  -8,  -35), $00, SpriteSmall, $0A8, 2, 0, false, false
        .structSpriteEntry (   4,  -23), $00, SpriteSmall, $002, 2, 1, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $003, 2, 1, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry (  -3,  -15), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry (  -4,  -23), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $00B, 2, 1, false, false
        .structSpriteEntry (   4,  -15), $00, SpriteSmall, $00C, 2, 1, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   2,  -27), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  10,  -27), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   2,  -43), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry ( -14,  -46), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry (  -8,  -51), $21, SpriteLarge, $088, 2, 0, false, false
        ANIM_RECORD_END

      _Record21
        ANIM_RECORD 11
        .structSpriteEntry ( -17,  -35), $00, SpriteSmall, $0E0, 2, 0, false, false
        .structSpriteEntry ( -25,  -43), $00, SpriteSmall, $0D1, 2, 0, false, false
        .structSpriteEntry ( -17,  -43), $00, SpriteSmall, $0D2, 2, 0, false, false
        .structSpriteEntry ( -17,  -51), $00, SpriteSmall, $0C2, 2, 0, false, false
        .structSpriteEntry (  -9,  -27), $00, SpriteSmall, $0D6, 2, 0, false, false
        .structSpriteEntry (  -9,  -35), $00, SpriteSmall, $0C6, 2, 0, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (  -4,  -23), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  -1,  -47), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   7,  -31), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (  -1,  -31), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  -9,  -51), $21, SpriteLarge, $0C4, 2, 0, false, false
        ANIM_RECORD_END

      _Record22
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (  -3,  -19), $21, SpriteLarge, $042, 2, 2, false, false
        .structSpriteEntry ( -19,  -19), $21, SpriteLarge, $040, 2, 2, false, false
        ANIM_RECORD_END

      _Record23
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry ( -10,  -25), $21, SpriteLarge, $04A, 2, 2, false, true
        .structSpriteEntry ( -10,   -9), $21, SpriteLarge, $048, 2, 2, false, true
        ANIM_RECORD_END

      _Record24
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (  -6,  -25), $21, SpriteLarge, $04A, 2, 2, true, true
        .structSpriteEntry (  -6,   -9), $21, SpriteLarge, $048, 2, 2, true, true
        ANIM_RECORD_END

      _Record25
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry ( -11,  -19), $21, SpriteLarge, $042, 2, 2, true, false
        .structSpriteEntry (   5,  -19), $21, SpriteLarge, $040, 2, 2, true, false
        ANIM_RECORD_END

      _Record26
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry ( -12,  -24), $21, SpriteLarge, $046, 2, 2, true, false
        .structSpriteEntry (   4,  -24), $21, SpriteLarge, $044, 2, 2, true, false
        ANIM_RECORD_END

      _Record27
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (  -7,  -20), $21, SpriteLarge, $04E, 2, 2, false, false
        .structSpriteEntry (  -7,  -36), $21, SpriteLarge, $04C, 2, 2, false, false
        ANIM_RECORD_END

      _Record28
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (  -9,  -20), $21, SpriteLarge, $04E, 2, 2, true, false
        .structSpriteEntry (  -9,  -36), $21, SpriteLarge, $04C, 2, 2, true, false
        ANIM_RECORD_END

      aBattleAnimationSequencesKnightLordLance ; 9A/C88D

        ; Sequence data of entry 19 of aBattleAnimationFrameTables, used by: KnightLord (Lance),
        ; DukeKnight (Lance), MasterKnight (Lance), Paladin (Lance), PaladinF (Lance). Frames:
        ; aBattleAnimationFramesKnightLordSword.

        .word _Index - aBattleAnimationSequencesKnightLordLance, _Records - aBattleAnimationSequencesKnightLordLance

      _Index
        .word _Sequence00 - aBattleAnimationSequencesKnightLordLance
        .word _Sequence01 - aBattleAnimationSequencesKnightLordLance
        .word _Sequence02 - aBattleAnimationSequencesKnightLordLance
        .word _Sequence03 - aBattleAnimationSequencesKnightLordLance
        .word _Sequence04 - aBattleAnimationSequencesKnightLordLance
        .word _Sequence05 - aBattleAnimationSequencesKnightLordLance
        .word _Sequence06 - aBattleAnimationSequencesKnightLordLance
        .word _Sequence07 - aBattleAnimationSequencesKnightLordLance
        .word _Sequence08 - aBattleAnimationSequencesKnightLordLance
        .word _Sequence09 - aBattleAnimationSequencesKnightLordLance
        .word _Sequence10 - aBattleAnimationSequencesKnightLordLance
        .word _Sequence11 - aBattleAnimationSequencesKnightLordLance
        .word _Sequence12 - aBattleAnimationSequencesKnightLordLance

      _Records
        .word aBattleAnimationSequencesKnightLordRangedLance._Record00 - aBattleAnimationSequencesKnightLordLance
        .word aBattleAnimationSequencesKnightLordRangedLance._Record01 - aBattleAnimationSequencesKnightLordLance
        .word aBattleAnimationSequencesKnightLordRangedLance._Record02 - aBattleAnimationSequencesKnightLordLance
        .word aBattleAnimationSequencesKnightLordRangedLance._Record03 - aBattleAnimationSequencesKnightLordLance
        .word aBattleAnimationSequencesKnightLordRangedLance._Record04 - aBattleAnimationSequencesKnightLordLance
        .word aBattleAnimationSequencesKnightLordRangedLance._Record05 - aBattleAnimationSequencesKnightLordLance
        .word aBattleAnimationSequencesKnightLordRangedLance._Record06 - aBattleAnimationSequencesKnightLordLance
        .word aBattleAnimationSequencesKnightLordRangedLance._Record07 - aBattleAnimationSequencesKnightLordLance
        .word aBattleAnimationSequencesKnightLordRangedLance._Record08 - aBattleAnimationSequencesKnightLordLance
        .word aBattleAnimationSequencesKnightLordRangedLance._Record09 - aBattleAnimationSequencesKnightLordLance
        .word aBattleAnimationSequencesKnightLordRangedLance._Record10 - aBattleAnimationSequencesKnightLordLance
        .word aBattleAnimationSequencesKnightLordRangedLance._Record11 - aBattleAnimationSequencesKnightLordLance
        .word aBattleAnimationSequencesKnightLordRangedLance._Record12 - aBattleAnimationSequencesKnightLordLance
        .word aBattleAnimationSequencesKnightLordRangedLance._Record13 - aBattleAnimationSequencesKnightLordLance
        .word aBattleAnimationSequencesKnightLordRangedLance._Record14 - aBattleAnimationSequencesKnightLordLance
        .word aBattleAnimationSequencesKnightLordRangedLance._Record15 - aBattleAnimationSequencesKnightLordLance
        .word aBattleAnimationSequencesKnightLordRangedLance._Record16 - aBattleAnimationSequencesKnightLordLance
        .word aBattleAnimationSequencesKnightLordRangedLance._Record17 - aBattleAnimationSequencesKnightLordLance
        .word aBattleAnimationSequencesKnightLordRangedLance._Record18 - aBattleAnimationSequencesKnightLordLance
        .word aBattleAnimationSequencesKnightLordRangedLance._Record19 - aBattleAnimationSequencesKnightLordLance
        .word aBattleAnimationSequencesKnightLordRangedLance._Record20 - aBattleAnimationSequencesKnightLordLance
        .word aBattleAnimationSequencesKnightLordRangedLance._Record21 - aBattleAnimationSequencesKnightLordLance
        .word aBattleAnimationSequencesKnightLordRangedLance._Record22 - aBattleAnimationSequencesKnightLordLance
        .word aBattleAnimationSequencesKnightLordRangedLance._Record23 - aBattleAnimationSequencesKnightLordLance
        .word aBattleAnimationSequencesKnightLordRangedLance._Record24 - aBattleAnimationSequencesKnightLordLance
        .word aBattleAnimationSequencesKnightLordRangedLance._Record25 - aBattleAnimationSequencesKnightLordLance
        .word aBattleAnimationSequencesKnightLordRangedLance._Record26 - aBattleAnimationSequencesKnightLordLance
        .word aBattleAnimationSequencesKnightLordRangedLance._Record27 - aBattleAnimationSequencesKnightLordLance
        .word aBattleAnimationSequencesKnightLordRangedLance._Record28 - aBattleAnimationSequencesKnightLordLance
        .word aBattleAnimationSequencesKnightLordRangedLance._Record29 - aBattleAnimationSequencesKnightLordLance
        .word aBattleAnimationSequencesKnightLordRangedLance._Record30 - aBattleAnimationSequencesKnightLordLance
        .word aBattleAnimationSequencesKnightLordRangedLance._Record31 - aBattleAnimationSequencesKnightLordLance
        .word aBattleAnimationSequencesKnightLordRangedLance._Record32 - aBattleAnimationSequencesKnightLordLance
        .word aBattleAnimationSequencesKnightLordRangedLance._Record33 - aBattleAnimationSequencesKnightLordLance
        .word aBattleAnimationSequencesKnightLordRangedLance._Record34 - aBattleAnimationSequencesKnightLordLance
        .word aBattleAnimationSequencesKnightLordRangedLance._Record35 - aBattleAnimationSequencesKnightLordLance
        .word aBattleAnimationSequencesKnightLordRangedLance._Record36 - aBattleAnimationSequencesKnightLordLance

      _Sequence00
        ANIM_CLEAR_BUSY
        ANIM_STEP 6, 1
        ANIM_HOLD

      _Sequence01
        ANIM_SOUND 25
        ANIM_STEP 1, 5
        ANIM_STEP 2, 13
        ANIM_STEP 4, 13
        ANIM_STEP 5, 3
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence02
        ANIM_SOUND 26
        ANIM_STEP 7, 5
        ANIM_STEP 8, 5
        ANIM_STEP 11, 5
        ANIM_STEP 9, 5
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence03
        ANIM_STEP 14, 3
        ANIM_STEP 15, 4
        ANIM_STEP 16, 5
        ANIM_STEP 17, 1
        ANIM_CMD_EE
        ANIM_STEP 17, 15
        ANIM_SOUND 4
        ANIM_STEP 18, 1
        ANIM_CMD_F1
        ANIM_STEP 18, 16
        ANIM_STEP 27, 10
        ANIM_CMD_F3
        ANIM_CMD_ED 3
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence04
        ANIM_SOUND 19
        ANIM_STEP 6, 4
        ANIM_STEP 7, 4
        ANIM_STEP 8, 5
        ANIM_STEP 7, 5
        ANIM_STEP 6, 5
        ANIM_CMD_F4 0
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence05
        ANIM_SOUND 19
        ANIM_STEP 9, 5
        ANIM_STEP 10, 3
        ANIM_STEP 11, 3
        ANIM_STEP 8, 5
        ANIM_STEP 7, 5
        ANIM_STEP 6, 1
        ANIM_CMD_F4 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence06
        ANIM_SOUND 25
        ANIM_STEP 1, 2
        ANIM_STEP 2, 5
        ANIM_STEP 4, 6
        ANIM_STEP 5, 2
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence07
        ANIM_SOUND 26
        ANIM_STEP 6, 4
        ANIM_STEP 7, 6
        ANIM_STEP 8, 4
        ANIM_STEP 11, 4
        ANIM_STEP 9, 9
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence08
        ANIM_STEP 9, 2
        ANIM_STEP 14, 2
        ANIM_STEP 15, 2
        ANIM_STEP 16, 5
        ANIM_STEP 17, 20
        ANIM_SOUND 5
        ANIM_STEP 19, 2
        ANIM_STEP 20, 2
        ANIM_STEP 21, 2
        ANIM_STEP 22, 2
        ANIM_STEP 23, 3
        ANIM_STEP 24, 2
        ANIM_STEP 25, 2
        ANIM_STEP 26, 8
        ANIM_CMD_EE
        ANIM_STEP 26, 14
        ANIM_SOUND 4
        ANIM_STEP 18, 2
        ANIM_CMD_F1
        ANIM_STEP 18, 15
        ANIM_STEP 27, 17
        ANIM_CMD_F3
        ANIM_CMD_ED 3
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence09
        ANIM_STEP 7, 32
        ANIM_STEP 8, 6
        ANIM_STEP 9, 8

      _Sequence10
        ANIM_STEP 35, 16
        ANIM_STEP 36, 16
        ANIM_STEP 37, 16 ; record 37: past the end of the list, never read in fe4.cdl

      _Sequence11
        ANIM_STEP 10, 48
        ANIM_STEP 32, 3
        ANIM_STEP 31, 4
        ANIM_STEP 30, 5
        ANIM_STEP 29, 22
        ANIM_STEP 33, 32
        ANIM_STEP 34, 48

      _Sequence12
        ANIM_STEP 6, 16
        ANIM_STEP 19, 4
        ANIM_STEP 20, 22
        ANIM_STEP 12, 1
        ANIM_STEP 13, 1
        ANIM_STEP 11, 80
        ; (no end marker: the next structure begins here)

      aBattleAnimationSequencesKnightLordRangedLance ; 9A/C9D1

        ; Sequence data of entry 20 of aBattleAnimationFrameTables, used by: KnightLord
        ; (RangedLance), DukeKnight (RangedLance), MasterKnight (RangedLance), Paladin
        ; (RangedLance), PaladinF (RangedLance). Frames: aBattleAnimationFramesKnightLordSword.

        .word _Index - aBattleAnimationSequencesKnightLordRangedLance, _Records - aBattleAnimationSequencesKnightLordRangedLance

      _Index
        .word _Sequence00 - aBattleAnimationSequencesKnightLordRangedLance
        .word _Sequence01 - aBattleAnimationSequencesKnightLordRangedLance
        .word _Sequence02 - aBattleAnimationSequencesKnightLordRangedLance
        .word _Sequence03 - aBattleAnimationSequencesKnightLordRangedLance
        .word _Sequence04 - aBattleAnimationSequencesKnightLordRangedLance
        .word _Sequence05 - aBattleAnimationSequencesKnightLordRangedLance
        .word _Sequence06 - aBattleAnimationSequencesKnightLordRangedLance
        .word _Sequence07 - aBattleAnimationSequencesKnightLordRangedLance
        .word _Sequence08 - aBattleAnimationSequencesKnightLordRangedLance
        .word _Sequence09 - aBattleAnimationSequencesKnightLordRangedLance
        .word _Sequence10 - aBattleAnimationSequencesKnightLordRangedLance
        .word _Sequence11 - aBattleAnimationSequencesKnightLordRangedLance

      _Records
        .word _Record00 - aBattleAnimationSequencesKnightLordRangedLance
        .word _Record01 - aBattleAnimationSequencesKnightLordRangedLance
        .word _Record02 - aBattleAnimationSequencesKnightLordRangedLance
        .word _Record03 - aBattleAnimationSequencesKnightLordRangedLance
        .word _Record04 - aBattleAnimationSequencesKnightLordRangedLance
        .word _Record05 - aBattleAnimationSequencesKnightLordRangedLance
        .word _Record06 - aBattleAnimationSequencesKnightLordRangedLance
        .word _Record07 - aBattleAnimationSequencesKnightLordRangedLance
        .word _Record08 - aBattleAnimationSequencesKnightLordRangedLance
        .word _Record09 - aBattleAnimationSequencesKnightLordRangedLance
        .word _Record10 - aBattleAnimationSequencesKnightLordRangedLance
        .word _Record11 - aBattleAnimationSequencesKnightLordRangedLance
        .word _Record12 - aBattleAnimationSequencesKnightLordRangedLance
        .word _Record13 - aBattleAnimationSequencesKnightLordRangedLance
        .word _Record14 - aBattleAnimationSequencesKnightLordRangedLance
        .word _Record15 - aBattleAnimationSequencesKnightLordRangedLance
        .word _Record16 - aBattleAnimationSequencesKnightLordRangedLance
        .word _Record17 - aBattleAnimationSequencesKnightLordRangedLance
        .word _Record18 - aBattleAnimationSequencesKnightLordRangedLance
        .word _Record19 - aBattleAnimationSequencesKnightLordRangedLance
        .word _Record20 - aBattleAnimationSequencesKnightLordRangedLance
        .word _Record21 - aBattleAnimationSequencesKnightLordRangedLance
        .word _Record22 - aBattleAnimationSequencesKnightLordRangedLance
        .word _Record23 - aBattleAnimationSequencesKnightLordRangedLance
        .word _Record24 - aBattleAnimationSequencesKnightLordRangedLance
        .word _Record25 - aBattleAnimationSequencesKnightLordRangedLance
        .word _Record26 - aBattleAnimationSequencesKnightLordRangedLance
        .word _Record27 - aBattleAnimationSequencesKnightLordRangedLance
        .word _Record28 - aBattleAnimationSequencesKnightLordRangedLance
        .word _Record29 - aBattleAnimationSequencesKnightLordRangedLance
        .word _Record30 - aBattleAnimationSequencesKnightLordRangedLance
        .word _Record31 - aBattleAnimationSequencesKnightLordRangedLance
        .word _Record32 - aBattleAnimationSequencesKnightLordRangedLance
        .word _Record33 - aBattleAnimationSequencesKnightLordRangedLance
        .word _Record34 - aBattleAnimationSequencesKnightLordRangedLance
        .word _Record35 - aBattleAnimationSequencesKnightLordRangedLance
        .word _Record36 - aBattleAnimationSequencesKnightLordRangedLance

      _Sequence00
        ANIM_CLEAR_BUSY
        ANIM_STEP 6, 8
        ANIM_HOLD

      _Sequence01
        ANIM_SOUND 19
        ANIM_STEP 7, 6
        ANIM_STEP 8, 5
        ANIM_STEP 7, 5
        ANIM_STEP 6, 16
        ANIM_CMD_F4 0
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence02
        ANIM_SOUND 19
        ANIM_STEP 9, 3
        ANIM_STEP 9, 6
        ANIM_STEP 11, 5
        ANIM_STEP 8, 5
        ANIM_STEP 7, 5
        ANIM_STEP 6, 16
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence03
        ANIM_SOUND 19
        ANIM_STEP 7, 4
        ANIM_STEP 8, 7
        ANIM_STEP 11, 7
        ANIM_STEP 9, 9
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence04
        ANIM_STEP 9, 4
        ANIM_STEP 31, 3
        ANIM_STEP 30, 3
        ANIM_STEP 29, 6
        ANIM_STEP 28, 24
        ANIM_CMD_EF 70
        ANIM_SOUND 11
        ANIM_STEP 32, 8
        ANIM_CMD_EE
        ANIM_STEP 32, 24
        ANIM_CMD_ED 2
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence05
        ANIM_STEP 6, 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence06
        ANIM_STEP 34, 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence07
        ANIM_STEP 34, 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence08
        ANIM_STEP 35, 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence09
        ANIM_STEP 36, 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence10
        ANIM_STEP 36, 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence11
      _Record00
        ; _Sequence11 is this record's first two bytes, read as a step: its frame number $FF
        ; (ANIM_END) and the low byte of the sprite count. Keep the frame ANIM_KEEP_TILES, or _Sequence11 changes.
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry ( -28,   -1), $00, SpriteSmall, $0F0, 2, 3, false, false
        .structSpriteEntry (  -4,   -1), $00, SpriteSmall, $0F1, 2, 3, false, false
        .structSpriteEntry ( -12,   -1), $00, SpriteSmall, $0F1, 2, 3, false, false
        .structSpriteEntry ( -20,   -1), $00, SpriteSmall, $0F1, 2, 3, false, false
        .structSpriteEntry (   4,   -1), $00, SpriteSmall, $0F2, 2, 3, false, false
        .structSpriteEntry (  20,   -1), $00, SpriteSmall, $0F3, 2, 3, false, false
        .structSpriteEntry (  12,   -1), $00, SpriteSmall, $0F2, 2, 3, false, false
        ANIM_RECORD_END

      _Record01
        ANIM_RECORD 0
        .structSpriteEntry (  11,  -25), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   3,  -25), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   3,  -41), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  -5,  -34), $21, SpriteLarge, $0A2, 2, 0, false, false
        .structSpriteEntry (  -5,  -50), $21, SpriteLarge, $082, 2, 0, false, false
        .structSpriteEntry (  -9,  -15), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry (  -9,  -23), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry (  -9,  -31), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (  -9,  -39), $00, SpriteSmall, $00B, 2, 1, false, false
        .structSpriteEntry ( -25,  -23), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -25,  -39), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  -1,  -39), $00, SpriteSmall, $00C, 2, 1, false, false
        .structSpriteEntry (   7,  -15), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry (   7,  -31), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry (  -9,  -47), $00, SpriteSmall, $00D, 2, 1, false, false
        .structSpriteEntry ( -17,  -47), $00, SpriteSmall, $00E, 2, 1, false, false
        .structSpriteEntry ( -25,  -47), $00, SpriteSmall, $00F, 2, 1, false, false
        .structSpriteEntry (  -1,   -7), $00, SpriteSmall, $018, 2, 1, false, false
        .structSpriteEntry (  -1,  -15), $00, SpriteSmall, $019, 2, 1, false, false
        .structSpriteEntry (  -1,  -23), $00, SpriteSmall, $01A, 2, 1, false, false
        .structSpriteEntry (  -1,  -31), $00, SpriteSmall, $01B, 2, 1, false, false
        .structSpriteEntry (  13,  -53), $00, SpriteSmall, $044, 2, 2, false, false
        .structSpriteEntry (   5,  -45), $00, SpriteSmall, $053, 2, 2, false, false
        .structSpriteEntry ( -11,  -37), $00, SpriteSmall, $043, 2, 2, false, false
        .structSpriteEntry ( -35,  -32), $21, SpriteLarge, $040, 2, 2, false, false
        ANIM_RECORD_END

      _Record02
        ANIM_RECORD 1
        .structSpriteEntry (   8,  -28), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   0,  -28), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   0,  -44), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  -5,  -38), $21, SpriteLarge, $0A4, 2, 0, false, false
        .structSpriteEntry (  -5,  -54), $21, SpriteLarge, $084, 2, 0, false, false
        .structSpriteEntry ( -24,  -23), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -24,  -39), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  -8,  -23), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry (  -8,  -31), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry (  -8,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (  -8,  -47), $00, SpriteSmall, $00B, 2, 1, false, false
        .structSpriteEntry (   0,  -15), $00, SpriteSmall, $00C, 2, 1, false, false
        .structSpriteEntry (   0,  -23), $00, SpriteSmall, $00D, 2, 1, false, false
        .structSpriteEntry (   0,  -31), $00, SpriteSmall, $00E, 2, 1, false, false
        .structSpriteEntry (   0,  -39), $00, SpriteSmall, $00F, 2, 1, false, false
        .structSpriteEntry (  24,   -7), $00, SpriteSmall, $018, 2, 1, false, false
        .structSpriteEntry (  24,  -15), $00, SpriteSmall, $019, 2, 1, false, false
        .structSpriteEntry (  24,  -23), $00, SpriteSmall, $01A, 2, 1, false, false
        .structSpriteEntry (  24,  -31), $00, SpriteSmall, $01B, 2, 1, false, false
        .structSpriteEntry (   8,  -15), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry (   8,  -31), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -16,  -47), $00, SpriteSmall, $01C, 2, 1, false, false
        .structSpriteEntry ( -24,  -47), $00, SpriteSmall, $01D, 2, 1, false, false
        .structSpriteEntry (  13,  -57), $00, SpriteSmall, $044, 2, 2, false, false
        .structSpriteEntry (   5,  -49), $00, SpriteSmall, $053, 2, 2, false, false
        .structSpriteEntry ( -11,  -41), $00, SpriteSmall, $043, 2, 2, false, false
        .structSpriteEntry ( -35,  -36), $21, SpriteLarge, $040, 2, 2, false, false
        ANIM_RECORD_END

      _Record03
        ANIM_RECORD 2
        .structSpriteEntry (   5,  -28), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (  -3,  -28), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  -3,  -44), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  -7,  -37), $21, SpriteLarge, $0A4, 2, 0, false, false
        .structSpriteEntry (  -7,  -53), $21, SpriteLarge, $084, 2, 0, false, false
        .structSpriteEntry ( -28,  -15), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry ( -28,  -23), $00, SpriteSmall, $00B, 2, 1, false, false
        .structSpriteEntry ( -28,  -31), $00, SpriteSmall, $00C, 2, 1, false, false
        .structSpriteEntry ( -28,  -39), $00, SpriteSmall, $00D, 2, 1, false, false
        .structSpriteEntry ( -28,  -47), $00, SpriteSmall, $00E, 2, 1, false, false
        .structSpriteEntry ( -20,  -15), $00, SpriteSmall, $00F, 2, 1, false, false
        .structSpriteEntry ( -20,  -31), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -20,  -47), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (   4,  -15), $00, SpriteSmall, $01A, 2, 1, false, false
        .structSpriteEntry (  12,  -23), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry (   4,  -23), $00, SpriteSmall, $01B, 2, 1, false, false
        .structSpriteEntry (  -4,  -23), $00, SpriteSmall, $01C, 2, 1, false, false
        .structSpriteEntry (  12,  -39), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry (  11,  -57), $00, SpriteSmall, $044, 2, 2, false, false
        .structSpriteEntry (   3,  -49), $00, SpriteSmall, $053, 2, 2, false, false
        .structSpriteEntry ( -13,  -41), $00, SpriteSmall, $043, 2, 2, false, false
        .structSpriteEntry ( -37,  -36), $21, SpriteLarge, $040, 2, 2, false, false
        ANIM_RECORD_END

      _Record04
        ANIM_RECORD 3
        .structSpriteEntry (   6,  -27), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (  -2,  -27), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  -2,  -43), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  -8,  -36), $21, SpriteLarge, $0A6, 2, 0, false, false
        .structSpriteEntry (  -8,  -52), $21, SpriteLarge, $086, 2, 0, false, false
        .structSpriteEntry (  21,  -31), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry (  21,  -15), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry (  21,  -23), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry (  13,  -15), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry (  13,  -23), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (   5,  -23), $00, SpriteSmall, $00B, 2, 1, false, false
        .structSpriteEntry (   5,  -39), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (  -3,  -23), $00, SpriteSmall, $00C, 2, 1, false, false
        .structSpriteEntry (  -3,  -31), $00, SpriteSmall, $00D, 2, 1, false, false
        .structSpriteEntry (  -3,  -39), $00, SpriteSmall, $00E, 2, 1, false, false
        .structSpriteEntry ( -11,  -39), $00, SpriteSmall, $00F, 2, 1, false, false
        .structSpriteEntry ( -19,   -7), $00, SpriteSmall, $016, 2, 1, false, false
        .structSpriteEntry ( -27,   -7), $00, SpriteSmall, $017, 2, 0, false, false
        .structSpriteEntry ( -11,  -15), $00, SpriteSmall, $018, 2, 1, false, false
        .structSpriteEntry ( -11,  -23), $00, SpriteSmall, $019, 2, 1, false, false
        .structSpriteEntry ( -11,  -31), $00, SpriteSmall, $01A, 2, 1, false, false
        .structSpriteEntry ( -27,  -23), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry ( -27,  -39), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry (   9,  -53), $00, SpriteSmall, $044, 2, 2, false, false
        .structSpriteEntry (   1,  -45), $00, SpriteSmall, $053, 2, 2, false, false
        .structSpriteEntry ( -15,  -37), $00, SpriteSmall, $043, 2, 2, false, false
        .structSpriteEntry ( -39,  -32), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry ( -20,    1), $00, SpriteSmall, $01B, 2, 1, false, false
        ANIM_RECORD_END

      _Record05
        ANIM_RECORD 4
        .structSpriteEntry (   6,  -26), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (  -2,  -26), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  -2,  -42), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  -8,  -35), $21, SpriteLarge, $0A6, 2, 0, false, false
        .structSpriteEntry (  -8,  -51), $21, SpriteLarge, $086, 2, 0, false, false
        .structSpriteEntry (  13,  -22), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (  21,  -30), $00, SpriteSmall, $00B, 2, 1, false, false
        .structSpriteEntry (  -3,   -6), $00, SpriteSmall, $00C, 2, 1, false, false
        .structSpriteEntry ( -11,   -6), $00, SpriteSmall, $00D, 2, 1, false, false
        .structSpriteEntry ( -19,   -6), $00, SpriteSmall, $00E, 2, 1, false, false
        .structSpriteEntry ( -27,   -6), $00, SpriteSmall, $00F, 2, 1, false, false
        .structSpriteEntry (   5,  -14), $00, SpriteSmall, $01A, 2, 1, false, false
        .structSpriteEntry (   5,  -22), $00, SpriteSmall, $01B, 2, 1, false, false
        .structSpriteEntry (   5,  -38), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -11,  -22), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry ( -27,  -22), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -11,  -38), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -27,  -38), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry (   9,  -52), $00, SpriteSmall, $044, 2, 2, false, false
        .structSpriteEntry (   1,  -44), $00, SpriteSmall, $053, 2, 2, false, false
        .structSpriteEntry ( -15,  -36), $00, SpriteSmall, $043, 2, 2, false, false
        .structSpriteEntry ( -39,  -31), $21, SpriteLarge, $040, 2, 2, false, false
        ANIM_RECORD_END

      _Record06
        ANIM_RECORD 5
        .structSpriteEntry (   7,  -23), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (  -1,  -23), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  -1,  -39), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  -8,  -34), $21, SpriteLarge, $0A0, 2, 0, false, false
        .structSpriteEntry (  -8,  -50), $21, SpriteLarge, $080, 2, 0, false, false
        .structSpriteEntry (   2,  -15), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   2,  -31), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  -6,   -7), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry (  -6,  -15), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry (  -6,  -23), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (  -6,  -31), $00, SpriteSmall, $00B, 2, 1, false, false
        .structSpriteEntry (  -6,  -39), $00, SpriteSmall, $00C, 2, 1, false, false
        .structSpriteEntry ( -14,  -39), $00, SpriteSmall, $00D, 2, 1, false, false
        .structSpriteEntry ( -22,  -39), $00, SpriteSmall, $00E, 2, 1, false, false
        .structSpriteEntry ( -22,  -15), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -22,  -31), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry (  10,  -50), $00, SpriteSmall, $044, 2, 2, false, false
        .structSpriteEntry (   2,  -42), $00, SpriteSmall, $053, 2, 2, false, false
        .structSpriteEntry ( -22,  -34), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry ( -38,  -29), $21, SpriteLarge, $040, 2, 2, false, false
        ANIM_RECORD_END

      _Record07
        ANIM_RECORD 6
        .structSpriteEntry (   6,  -22), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (  -2,  -22), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  -2,  -38), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  -7,  -32), $21, SpriteLarge, $0A2, 2, 0, false, false
        .structSpriteEntry (  -7,  -48), $21, SpriteLarge, $082, 2, 0, false, false
        .structSpriteEntry ( -24,  -15), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry ( -24,  -23), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -24,  -31), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry ( -24,  -39), $00, SpriteSmall, $00B, 2, 1, false, false
        .structSpriteEntry (   0,  -15), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   0,  -31), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  -8,   -7), $00, SpriteSmall, $00C, 2, 1, false, false
        .structSpriteEntry ( -16,   -7), $00, SpriteSmall, $00D, 2, 1, false, false
        .structSpriteEntry ( -16,  -23), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -16,  -39), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry (  10,  -48), $00, SpriteSmall, $044, 2, 2, false, false
        .structSpriteEntry (   2,  -40), $00, SpriteSmall, $053, 2, 2, false, false
        .structSpriteEntry (  -6,  -40), $00, SpriteSmall, $052, 2, 2, false, false
        .structSpriteEntry ( -22,  -32), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry ( -38,  -27), $21, SpriteLarge, $040, 2, 2, false, false
        ANIM_RECORD_END

      _Record08
        ANIM_RECORD 7
        .structSpriteEntry (  11,  -24), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   3,  -24), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   3,  -40), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  -5,  -33), $21, SpriteLarge, $0A2, 2, 0, false, false
        .structSpriteEntry (  -5,  -49), $21, SpriteLarge, $082, 2, 0, false, false
        .structSpriteEntry (   0,  -15), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   0,  -31), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry ( -16,  -10), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry ( -24,  -10), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry (  -8,  -10), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (  -8,  -18), $00, SpriteSmall, $00B, 2, 1, false, false
        .structSpriteEntry (  -8,  -26), $00, SpriteSmall, $00C, 2, 1, false, false
        .structSpriteEntry (  -8,  -34), $00, SpriteSmall, $00D, 2, 1, false, false
        .structSpriteEntry (  -8,  -42), $00, SpriteSmall, $00E, 2, 1, false, false
        .structSpriteEntry ( -24,  -26), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -24,  -42), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry (  12,  -52), $00, SpriteSmall, $044, 2, 2, false, false
        .structSpriteEntry (   4,  -44), $00, SpriteSmall, $053, 2, 2, false, false
        .structSpriteEntry ( -20,  -36), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry ( -36,  -31), $21, SpriteLarge, $040, 2, 2, false, false
        ANIM_RECORD_END

      _Record09
        ANIM_RECORD 8
        .structSpriteEntry (  -8,  -27), $00, SpriteSmall, $0B8, 2, 0, false, false
        .structSpriteEntry (  -8,  -35), $00, SpriteSmall, $0A8, 2, 0, false, false
        .structSpriteEntry (  -4,  -39), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry (   4,  -15), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry (   4,  -23), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -12,  -31), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (   4,  -39), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry (   4,  -31), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (   2,  -43), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   2,  -27), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  10,  -27), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (  -8,  -51), $21, SpriteLarge, $088, 2, 0, false, false
        .structSpriteEntry (  10,  -52), $00, SpriteSmall, $044, 2, 2, false, false
        .structSpriteEntry (   2,  -44), $00, SpriteSmall, $053, 2, 2, false, false
        .structSpriteEntry ( -14,  -36), $00, SpriteSmall, $043, 2, 2, false, false
        .structSpriteEntry ( -22,  -36), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry ( -38,  -31), $21, SpriteLarge, $040, 2, 2, false, false
        ANIM_RECORD_END

      _Record10
        ANIM_RECORD 9
        .structSpriteEntry (  -8,  -27), $00, SpriteSmall, $0B8, 2, 0, false, false
        .structSpriteEntry (  -8,  -35), $00, SpriteSmall, $0A8, 2, 0, false, false
        .structSpriteEntry (   4,  -23), $00, SpriteSmall, $002, 2, 1, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $003, 2, 1, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry (  -3,  -15), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry (  -4,  -23), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $00B, 2, 1, false, false
        .structSpriteEntry (   4,  -15), $00, SpriteSmall, $00C, 2, 1, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   2,  -43), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   2,  -27), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  10,  -27), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (  -8,  -51), $21, SpriteLarge, $088, 2, 0, false, false
        .structSpriteEntry (  10,  -52), $00, SpriteSmall, $044, 2, 2, false, false
        .structSpriteEntry (   2,  -44), $00, SpriteSmall, $053, 2, 2, false, false
        .structSpriteEntry ( -14,  -36), $00, SpriteSmall, $043, 2, 2, false, false
        .structSpriteEntry ( -22,  -36), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry ( -38,  -31), $21, SpriteLarge, $040, 2, 2, false, false
        ANIM_RECORD_END

      _Record11
        ANIM_RECORD 10
        .structSpriteEntry (  -8,  -27), $00, SpriteSmall, $0B8, 2, 0, false, false
        .structSpriteEntry (  -8,  -35), $00, SpriteSmall, $0A8, 2, 0, false, false
        .structSpriteEntry (  12,  -15), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry (  12,  -23), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry (  -4,  -23), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $00B, 2, 1, false, false
        .structSpriteEntry (   4,  -23), $00, SpriteSmall, $00C, 2, 1, false, false
        .structSpriteEntry (  -4,  -15), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (   2,  -43), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   2,  -27), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  10,  -27), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (  -8,  -51), $21, SpriteLarge, $088, 2, 0, false, false
        .structSpriteEntry (  10,  -50), $00, SpriteSmall, $044, 2, 2, false, false
        .structSpriteEntry ( -14,  -35), $00, SpriteSmall, $043, 2, 2, false, false
        .structSpriteEntry ( -22,  -35), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry ( -38,  -30), $21, SpriteLarge, $040, 2, 2, false, false
        ANIM_RECORD_END

      _Record12
        ANIM_RECORD 5
        .structSpriteEntry (   7,  -23), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (  -1,  -23), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  -1,  -39), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  -8,  -34), $21, SpriteLarge, $0A0, 2, 0, false, false
        .structSpriteEntry (  -8,  -50), $21, SpriteLarge, $080, 2, 0, false, false
        .structSpriteEntry (   2,  -15), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   2,  -31), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  -6,   -7), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry (  -6,  -15), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry (  -6,  -23), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (  -6,  -31), $00, SpriteSmall, $00B, 2, 1, false, false
        .structSpriteEntry (  -6,  -39), $00, SpriteSmall, $00C, 2, 1, false, false
        .structSpriteEntry ( -14,  -39), $00, SpriteSmall, $00D, 2, 1, false, false
        .structSpriteEntry ( -22,  -39), $00, SpriteSmall, $00E, 2, 1, false, false
        .structSpriteEntry ( -22,  -15), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -22,  -31), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -22,  -41), $00, SpriteSmall, $042, 2, 2, false, true
        .structSpriteEntry ( -38,  -54), $21, SpriteLarge, $040, 2, 2, false, true
        ANIM_RECORD_END

      _Record13
        ANIM_RECORD 6
        .structSpriteEntry (   6,  -22), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (  -2,  -22), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  -2,  -38), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  -7,  -32), $21, SpriteLarge, $0A2, 2, 0, false, false
        .structSpriteEntry (  -7,  -48), $21, SpriteLarge, $082, 2, 0, false, false
        .structSpriteEntry ( -24,  -15), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry ( -24,  -23), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -24,  -31), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry ( -24,  -39), $00, SpriteSmall, $00B, 2, 1, false, false
        .structSpriteEntry (   0,  -15), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   0,  -31), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  -8,   -7), $00, SpriteSmall, $00C, 2, 1, false, false
        .structSpriteEntry ( -16,   -7), $00, SpriteSmall, $00D, 2, 1, false, false
        .structSpriteEntry ( -16,  -23), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -16,  -39), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry (  12,  -26), $00, SpriteSmall, $044, 2, 2, false, true
        .structSpriteEntry (   4,  -33), $00, SpriteSmall, $053, 2, 2, false, true
        .structSpriteEntry ( -12,  -41), $00, SpriteSmall, $043, 2, 2, false, true
        .structSpriteEntry ( -20,  -41), $00, SpriteSmall, $042, 2, 2, false, true
        .structSpriteEntry ( -36,  -54), $21, SpriteLarge, $040, 2, 2, false, true
        ANIM_RECORD_END

      _Record14
        ANIM_RECORD 11
        .structSpriteEntry (  -8,  -27), $00, SpriteSmall, $0B9, 2, 0, false, false
        .structSpriteEntry (  -8,  -35), $00, SpriteSmall, $0A9, 2, 0, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry ( -16,  -43), $00, SpriteSmall, $09A, 2, 0, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (  -4,  -23), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (   2,  -42), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  10,  -26), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   2,  -26), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  -8,  -51), $21, SpriteLarge, $08B, 2, 0, false, false
        .structSpriteEntry (   9,  -56), $00, SpriteSmall, $044, 2, 2, false, false
        .structSpriteEntry (   1,  -48), $00, SpriteSmall, $053, 2, 2, false, false
        .structSpriteEntry ( -15,  -40), $00, SpriteSmall, $043, 2, 2, false, false
        .structSpriteEntry ( -23,  -40), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry ( -39,  -35), $21, SpriteLarge, $040, 2, 2, false, false
        ANIM_RECORD_END

      _Record15
        ANIM_RECORD 11
        .structSpriteEntry (  -8,  -27), $00, SpriteSmall, $0B9, 2, 0, false, false
        .structSpriteEntry (  -8,  -35), $00, SpriteSmall, $0A9, 2, 0, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry (  -4,  -23), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry ( -16,  -43), $00, SpriteSmall, $09D, 2, 0, false, false
        .structSpriteEntry ( -16,  -51), $00, SpriteSmall, $08D, 2, 0, false, false
        .structSpriteEntry (   8,  -61), $00, SpriteSmall, $044, 2, 2, false, false
        .structSpriteEntry (   0,  -53), $00, SpriteSmall, $053, 2, 2, false, false
        .structSpriteEntry (  -8,  -53), $00, SpriteSmall, $052, 2, 2, false, false
        .structSpriteEntry ( -16,  -45), $00, SpriteSmall, $043, 2, 2, false, false
        .structSpriteEntry ( -24,  -45), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry ( -40,  -40), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   1,  -41), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   9,  -25), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   1,  -25), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  -8,  -51), $21, SpriteLarge, $08E, 2, 0, false, false
        ANIM_RECORD_END

      _Record16
        ANIM_RECORD 11
        .structSpriteEntry (  11,  -66), $00, SpriteSmall, $044, 2, 2, false, false
        .structSpriteEntry (  -5,  -58), $00, SpriteSmall, $052, 2, 2, false, false
        .structSpriteEntry (   3,  -58), $00, SpriteSmall, $053, 2, 2, false, false
        .structSpriteEntry ( -13,  -50), $00, SpriteSmall, $043, 2, 2, false, false
        .structSpriteEntry ( -21,  -50), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry ( -37,  -45), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry (  -8,  -27), $00, SpriteSmall, $0B9, 2, 0, false, false
        .structSpriteEntry (  -8,  -35), $00, SpriteSmall, $0A9, 2, 0, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry (  -4,  -23), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   1,  -41), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   1,  -25), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   9,  -25), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (  -8,  -51), $21, SpriteLarge, $0AB, 2, 0, false, false
        ANIM_RECORD_END

      _Record17
        ANIM_RECORD 11
        .structSpriteEntry (  11,  -68), $00, SpriteSmall, $044, 2, 2, false, false
        .structSpriteEntry (   3,  -60), $00, SpriteSmall, $053, 2, 2, false, false
        .structSpriteEntry (  -5,  -60), $00, SpriteSmall, $052, 2, 2, false, false
        .structSpriteEntry ( -13,  -52), $00, SpriteSmall, $043, 2, 2, false, false
        .structSpriteEntry ( -21,  -52), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry ( -37,  -47), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry (  -8,  -27), $00, SpriteSmall, $0BA, 2, 0, false, false
        .structSpriteEntry (  -8,  -35), $00, SpriteSmall, $0AA, 2, 0, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry (  -4,  -23), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   0,  -43), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   0,  -27), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   8,  -27), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (  -8,  -51), $21, SpriteLarge, $0AE, 2, 0, false, false
        ANIM_RECORD_END

      _Record18
        ANIM_RECORD 11
        .structSpriteEntry (  -9,  -27), $00, SpriteSmall, $0D6, 2, 0, false, false
        .structSpriteEntry (  -9,  -35), $00, SpriteSmall, $0C6, 2, 0, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry (  -4,  -23), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry ( -17,  -35), $00, SpriteSmall, $0D0, 2, 0, false, false
        .structSpriteEntry ( -17,  -43), $00, SpriteSmall, $0C0, 2, 0, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (  -1,  -31), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   7,  -31), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (  -1,  -47), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  -9,  -51), $21, SpriteLarge, $0C4, 2, 0, false, false
        .structSpriteEntry ( -15,  -42), $00, SpriteSmall, $052, 2, 2, false, false
        .structSpriteEntry ( -23,  -34), $00, SpriteSmall, $043, 2, 2, false, false
        .structSpriteEntry ( -31,  -34), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry ( -47,  -29), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry (   1,  -49), $00, SpriteSmall, $044, 2, 2, false, false
        .structSpriteEntry (  -7,  -42), $00, SpriteSmall, $053, 2, 2, false, false
        ANIM_RECORD_END

      _Record19
        ANIM_RECORD 11
        .structSpriteEntry (  -8,  -27), $00, SpriteSmall, $0BA, 2, 0, false, false
        .structSpriteEntry (  -8,  -35), $00, SpriteSmall, $0AA, 2, 0, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry (  -4,  -23), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   0,  -43), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   8,  -27), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   0,  -27), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  -8,  -51), $21, SpriteLarge, $0AE, 2, 0, false, false
        .structSpriteEntry (  10,  -42), $00, SpriteSmall, $044, 2, 2, false, true
        .structSpriteEntry (   2,  -50), $00, SpriteSmall, $053, 2, 2, false, true
        .structSpriteEntry (  -6,  -50), $00, SpriteSmall, $052, 2, 2, false, true
        .structSpriteEntry ( -14,  -58), $00, SpriteSmall, $043, 2, 2, false, true
        .structSpriteEntry ( -22,  -58), $00, SpriteSmall, $042, 2, 2, false, true
        .structSpriteEntry ( -38,  -71), $21, SpriteLarge, $040, 2, 2, false, true
        ANIM_RECORD_END

      _Record20
        ANIM_RECORD 11
        .structSpriteEntry (  -8,  -27), $00, SpriteSmall, $0BA, 2, 0, false, false
        .structSpriteEntry (  -8,  -35), $00, SpriteSmall, $0AA, 2, 0, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry (  -4,  -23), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry ( -14,  -66), $00, SpriteSmall, $057, 2, 2, false, true
        .structSpriteEntry ( -14,  -58), $00, SpriteSmall, $047, 2, 2, false, true
        .structSpriteEntry ( -27,  -82), $21, SpriteLarge, $045, 2, 2, false, true
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   0,  -43), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   8,  -27), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   0,  -27), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  -8,  -51), $21, SpriteLarge, $0AE, 2, 0, false, false
        .structSpriteEntry (  -6,  -50), $00, SpriteSmall, $058, 2, 2, false, true
        ANIM_RECORD_END

      _Record21
        ANIM_RECORD 11
        .structSpriteEntry ( -23,  -34), $00, SpriteSmall, $054, 2, 2, true, true
        .structSpriteEntry ( -15,  -50), $00, SpriteSmall, $058, 2, 2, true, true
        .structSpriteEntry ( -15,  -42), $00, SpriteSmall, $048, 2, 2, true, true
        .structSpriteEntry (  -7,  -66), $00, SpriteSmall, $057, 2, 2, true, true
        .structSpriteEntry (  -7,  -58), $00, SpriteSmall, $047, 2, 2, true, true
        .structSpriteEntry (  -2,  -82), $21, SpriteLarge, $045, 2, 2, true, true
        .structSpriteEntry (  -8,  -27), $00, SpriteSmall, $0BA, 2, 0, false, false
        .structSpriteEntry (  -8,  -35), $00, SpriteSmall, $0AA, 2, 0, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (  -4,  -23), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (   0,  -43), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   8,  -27), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   0,  -27), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  -8,  -51), $21, SpriteLarge, $0AE, 2, 0, false, false
        ANIM_RECORD_END

      _Record22
        ANIM_RECORD 11
        .structSpriteEntry (  -8,  -27), $00, SpriteSmall, $0BA, 2, 0, false, false
        .structSpriteEntry (  -8,  -35), $00, SpriteSmall, $0AA, 2, 0, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry (  -4,  -23), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   0,  -43), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   8,  -27), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   0,  -27), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  -8,  -51), $21, SpriteLarge, $0AE, 2, 0, false, false
        .structSpriteEntry ( -31,  -41), $00, SpriteSmall, $044, 2, 2, true, true
        .structSpriteEntry ( -23,  -49), $00, SpriteSmall, $053, 2, 2, true, true
        .structSpriteEntry ( -15,  -49), $00, SpriteSmall, $052, 2, 2, true, true
        .structSpriteEntry (  -7,  -57), $00, SpriteSmall, $043, 2, 2, true, true
        .structSpriteEntry (   1,  -57), $00, SpriteSmall, $042, 2, 2, true, true
        .structSpriteEntry (   9,  -70), $21, SpriteLarge, $040, 2, 2, true, true
        ANIM_RECORD_END

      _Record23
        ANIM_RECORD 11
        .structSpriteEntry (  -8,  -27), $00, SpriteSmall, $0BA, 2, 0, false, false
        .structSpriteEntry (  -8,  -35), $00, SpriteSmall, $0AA, 2, 0, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry (  -4,  -23), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry ( -31,  -66), $00, SpriteSmall, $044, 2, 2, true, false
        .structSpriteEntry ( -23,  -58), $00, SpriteSmall, $053, 2, 2, true, false
        .structSpriteEntry ( -15,  -58), $00, SpriteSmall, $052, 2, 2, true, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   8,  -27), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   0,  -27), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   0,  -43), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   9,  -46), $21, SpriteLarge, $040, 2, 2, true, false
        .structSpriteEntry (  -8,  -51), $21, SpriteLarge, $0AE, 2, 0, false, false
        .structSpriteEntry (  -7,  -50), $00, SpriteSmall, $043, 2, 2, true, false
        .structSpriteEntry (   1,  -50), $00, SpriteSmall, $042, 2, 2, true, false
        ANIM_RECORD_END

      _Record24
        ANIM_RECORD 11
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (  -4,  -23), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (   0,  -27), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   0,  -43), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   8,  -27), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (  -8,  -27), $00, SpriteSmall, $0BA, 2, 0, false, false
        .structSpriteEntry (  -8,  -35), $00, SpriteSmall, $0AA, 2, 0, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry (  -8,  -51), $21, SpriteLarge, $0AE, 2, 0, false, false
        .structSpriteEntry ( -23,  -74), $00, SpriteSmall, $054, 2, 2, true, false
        .structSpriteEntry ( -15,  -58), $00, SpriteSmall, $058, 2, 2, true, false
        .structSpriteEntry ( -15,  -66), $00, SpriteSmall, $048, 2, 2, true, false
        .structSpriteEntry (  -7,  -50), $00, SpriteSmall, $047, 2, 2, true, false
        ANIM_RECORD_END

      _Record25
        ANIM_RECORD 11
        .structSpriteEntry (   2,  -75), $00, SpriteSmall, $054, 2, 2, false, false
        .structSpriteEntry (  -6,  -59), $00, SpriteSmall, $058, 2, 2, false, false
        .structSpriteEntry (  -6,  -67), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry ( -14,  -51), $00, SpriteSmall, $047, 2, 2, false, false
        .structSpriteEntry ( -27,  -35), $21, SpriteLarge, $045, 2, 2, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry ( -14,  -43), $00, SpriteSmall, $057, 2, 2, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (  -4,  -23), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (   0,  -43), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   8,  -27), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   0,  -27), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  -8,  -35), $00, SpriteSmall, $0AA, 2, 0, false, false
        .structSpriteEntry (  -8,  -27), $00, SpriteSmall, $0BA, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (  -8,  -51), $21, SpriteLarge, $0AE, 2, 0, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $004, 2, 1, false, false
        ANIM_RECORD_END

      _Record26
        ANIM_RECORD 11
        .structSpriteEntry (  11,  -68), $00, SpriteSmall, $044, 2, 2, false, false
        .structSpriteEntry (  -5,  -60), $00, SpriteSmall, $052, 2, 2, false, false
        .structSpriteEntry (   3,  -60), $00, SpriteSmall, $053, 2, 2, false, false
        .structSpriteEntry ( -13,  -52), $00, SpriteSmall, $043, 2, 2, false, false
        .structSpriteEntry ( -21,  -52), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry ( -37,  -47), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry (  -8,  -27), $00, SpriteSmall, $0BA, 2, 0, false, false
        .structSpriteEntry (  -8,  -35), $00, SpriteSmall, $0AA, 2, 0, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry (  -4,  -23), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   0,  -43), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   8,  -27), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   0,  -27), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  -8,  -51), $21, SpriteLarge, $0AE, 2, 0, false, false
        ANIM_RECORD_END

      _Record27
        ANIM_RECORD 11
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry (  -4,  -23), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  10,  -27), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (  10,  -52), $00, SpriteSmall, $044, 2, 2, false, false
        .structSpriteEntry ( -14,  -36), $00, SpriteSmall, $043, 2, 2, false, false
        .structSpriteEntry ( -22,  -36), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry ( -38,  -31), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry (   2,  -27), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  -8,  -35), $00, SpriteSmall, $0A8, 2, 0, false, false
        .structSpriteEntry (  -8,  -27), $00, SpriteSmall, $0B8, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (   2,  -43), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  -8,  -51), $21, SpriteLarge, $088, 2, 0, false, false
        .structSpriteEntry (   2,  -44), $00, SpriteSmall, $053, 2, 2, false, false
        .structSpriteEntry (  -6,  -44), $00, SpriteSmall, $052, 2, 2, false, false
        ANIM_RECORD_END

      _Record28
        ANIM_RECORD 11
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (  -4,  -23), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (   8,  -27), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   0,  -27), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   0,  -43), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  -8,  -27), $00, SpriteSmall, $0BA, 2, 0, false, false
        .structSpriteEntry (  -8,  -35), $00, SpriteSmall, $0AA, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (  -8,  -51), $21, SpriteLarge, $0AE, 2, 0, false, false
        .structSpriteEntry (  14,  -40), $00, SpriteSmall, $044, 2, 2, false, true
        .structSpriteEntry (   6,  -48), $00, SpriteSmall, $053, 2, 2, false, true
        .structSpriteEntry (  -2,  -48), $00, SpriteSmall, $052, 2, 2, false, true
        .structSpriteEntry ( -10,  -56), $00, SpriteSmall, $043, 2, 2, false, true
        .structSpriteEntry ( -18,  -56), $00, SpriteSmall, $042, 2, 2, false, true
        .structSpriteEntry ( -34,  -69), $21, SpriteLarge, $040, 2, 2, false, true
        ANIM_RECORD_END

      _Record29
        ANIM_RECORD 11
        .structSpriteEntry (  -8,  -27), $00, SpriteSmall, $0B9, 2, 0, false, false
        .structSpriteEntry (  -8,  -35), $00, SpriteSmall, $0A9, 2, 0, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry (  -4,  -23), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   1,  -41), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   9,  -25), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   1,  -25), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  -8,  -51), $21, SpriteLarge, $0AB, 2, 0, false, false
        .structSpriteEntry (  14,  -38), $00, SpriteSmall, $044, 2, 2, false, true
        .structSpriteEntry (  -2,  -46), $00, SpriteSmall, $052, 2, 2, false, true
        .structSpriteEntry (   6,  -46), $00, SpriteSmall, $053, 2, 2, false, true
        .structSpriteEntry ( -10,  -54), $00, SpriteSmall, $043, 2, 2, false, true
        .structSpriteEntry ( -18,  -54), $00, SpriteSmall, $042, 2, 2, false, true
        .structSpriteEntry ( -34,  -67), $21, SpriteLarge, $040, 2, 2, false, true
        ANIM_RECORD_END

      _Record30
        ANIM_RECORD 11
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry (  -8,  -27), $00, SpriteSmall, $0B9, 2, 0, false, false
        .structSpriteEntry ( -16,  -51), $00, SpriteSmall, $08D, 2, 0, false, false
        .structSpriteEntry (  -8,  -35), $00, SpriteSmall, $0A9, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   1,  -41), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  -8,  -51), $21, SpriteLarge, $08E, 2, 0, false, false
        .structSpriteEntry (  -4,  -23), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (   9,  -25), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   1,  -25), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry ( -16,  -43), $00, SpriteSmall, $09D, 2, 0, false, false
        .structSpriteEntry (   1,  -43), $00, SpriteSmall, $053, 2, 2, false, true
        .structSpriteEntry ( -15,  -51), $00, SpriteSmall, $043, 2, 2, false, true
        .structSpriteEntry ( -23,  -51), $00, SpriteSmall, $042, 2, 2, false, true
        .structSpriteEntry ( -39,  -64), $21, SpriteLarge, $040, 2, 2, false, true
        .structSpriteEntry (   9,  -36), $00, SpriteSmall, $044, 2, 2, false, true
        .structSpriteEntry (  -7,  -43), $00, SpriteSmall, $052, 2, 2, false, true
        ANIM_RECORD_END

      _Record31
        ANIM_RECORD 11
        .structSpriteEntry (  -8,  -27), $00, SpriteSmall, $0B9, 2, 0, false, false
        .structSpriteEntry (  -8,  -35), $00, SpriteSmall, $0A9, 2, 0, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry ( -16,  -43), $00, SpriteSmall, $09A, 2, 0, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (  -4,  -23), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (   2,  -42), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  10,  -26), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   2,  -26), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  -8,  -51), $21, SpriteLarge, $08B, 2, 0, false, false
        .structSpriteEntry (   9,  -31), $00, SpriteSmall, $044, 2, 2, false, true
        .structSpriteEntry (   1,  -38), $00, SpriteSmall, $053, 2, 2, false, true
        .structSpriteEntry ( -15,  -46), $00, SpriteSmall, $043, 2, 2, false, true
        .structSpriteEntry ( -23,  -46), $00, SpriteSmall, $042, 2, 2, false, true
        .structSpriteEntry ( -39,  -59), $21, SpriteLarge, $040, 2, 2, false, true
        ANIM_RECORD_END

      _Record32
        ANIM_RECORD 11
        .structSpriteEntry (  -9,  -27), $00, SpriteSmall, $0D6, 2, 0, false, false
        .structSpriteEntry (  -9,  -35), $00, SpriteSmall, $0C6, 2, 0, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry (  -4,  -23), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry ( -17,  -35), $00, SpriteSmall, $0D0, 2, 0, false, false
        .structSpriteEntry ( -17,  -43), $00, SpriteSmall, $0C0, 2, 0, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (  -1,  -31), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   7,  -31), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (  -1,  -47), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  -9,  -51), $21, SpriteLarge, $0C4, 2, 0, false, false
        ANIM_RECORD_END

      _Record33
        ANIM_RECORD 11
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (  -8,  -27), $00, SpriteSmall, $0B8, 2, 0, false, false
        .structSpriteEntry (  -8,  -35), $00, SpriteSmall, $0A8, 2, 0, false, false
        .structSpriteEntry (  -4,  -23), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (   2,  -43), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  10,  -27), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   2,  -27), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  -8,  -51), $21, SpriteLarge, $088, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $004, 2, 1, false, false
        ANIM_RECORD_END

      _Record34
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (  16,    2), $00, SpriteSmall, $044, 2, 2, false, true
        .structSpriteEntry (   8,   -6), $00, SpriteSmall, $053, 2, 2, false, true
        .structSpriteEntry (   0,   -6), $00, SpriteSmall, $052, 2, 2, false, true
        .structSpriteEntry (  -8,  -14), $00, SpriteSmall, $043, 2, 2, false, true
        .structSpriteEntry ( -16,  -14), $00, SpriteSmall, $042, 2, 2, false, true
        .structSpriteEntry ( -32,  -27), $21, SpriteLarge, $040, 2, 2, false, true
        ANIM_RECORD_END

      _Record35
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (  17,  -11), $00, SpriteSmall, $05F, 2, 2, false, false
        .structSpriteEntry (   9,  -11), $00, SpriteSmall, $05E, 2, 2, false, false
        .structSpriteEntry (   1,  -11), $00, SpriteSmall, $05D, 2, 2, false, false
        .structSpriteEntry (  -7,  -11), $00, SpriteSmall, $05C, 2, 2, false, false
        .structSpriteEntry ( -15,  -11), $00, SpriteSmall, $05B, 2, 2, false, false
        .structSpriteEntry ( -23,  -11), $00, SpriteSmall, $05A, 2, 2, false, false
        .structSpriteEntry ( -31,  -11), $00, SpriteSmall, $059, 2, 2, false, false
        ANIM_RECORD_END

      _Record36
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (  17,  -23), $00, SpriteSmall, $044, 2, 2, false, false
        .structSpriteEntry (   9,  -15), $00, SpriteSmall, $053, 2, 2, false, false
        .structSpriteEntry (   1,  -15), $00, SpriteSmall, $052, 2, 2, false, false
        .structSpriteEntry (  -7,   -7), $00, SpriteSmall, $043, 2, 2, false, false
        .structSpriteEntry ( -15,   -7), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry ( -31,   -2), $21, SpriteLarge, $040, 2, 2, false, false
        ANIM_RECORD_END

      aBattleAnimationFramesArcherBow ; 9A/D943

        ; Frame table of entry 3: slices of the class sheet per frame.

        .word _Frame00 - aBattleAnimationFramesArcherBow
        .word _Frame01 - aBattleAnimationFramesArcherBow
        .word _Frame02 - aBattleAnimationFramesArcherBow
        .word _Frame03 - aBattleAnimationFramesArcherBow
        .word _Frame04 - aBattleAnimationFramesArcherBow
        .word _Frame05 - aBattleAnimationFramesArcherBow
        .word _Frame06 - aBattleAnimationFramesArcherBow
        .word _Frame07 - aBattleAnimationFramesArcherBow
        .word _Frame08 - aBattleAnimationFramesArcherBow
        .word _Frame09 - aBattleAnimationFramesArcherBow
        .word _Frame10 - aBattleAnimationFramesArcherBow

      _Frame00
        ANIM_TILES
        ANIM_TILE_ROW $0000, $0100
        ANIM_TILE_ROW $0100, $0080
        ANIM_TILES_END

      _Frame01
        ANIM_TILES
        ANIM_TILE_ROW $0180, $0100
        ANIM_TILE_ROW $0280, $0080
        ANIM_TILES_END

      _Frame02
        ANIM_TILES
        ANIM_TILE_ROW $0300, $0100
        ANIM_TILE_ROW $0400, $0080
        ANIM_TILES_END

      _Frame03
        ANIM_TILES
        ANIM_TILE_ROW $0480, $0100
        ANIM_TILE_ROW $0580, $0080
        ANIM_TILES_END

      _Frame04
        ANIM_TILES
        ANIM_TILE_ROW $0600, $0100
        ANIM_TILE_ROW $0700, $0080
        ANIM_TILES_END

      _Frame05
        ANIM_TILES
        ANIM_TILE_ROW $0780, $0100
        ANIM_TILE_ROW $0880, $0080
        ANIM_TILES_END

      _Frame06
        ANIM_TILES
        ANIM_TILE_ROW $0900, $0100
        ANIM_TILE_ROW $0A00, $0080
        ANIM_TILES_END

      _Frame07
        ANIM_TILES
        ANIM_TILE_ROW $0A80, $0100
        ANIM_TILE_ROW $0B80, $0080
        ANIM_TILES_END

      _Frame08
        ANIM_TILES
        ANIM_TILE_ROW $0C00, $0100
        ANIM_TILE_ROW $0D00, $0080
        ANIM_TILES_END

      _Frame09
        ANIM_TILES
        ANIM_TILE_ROW $0D80, $0100
        ANIM_TILE_ROW $0E80, $0080
        ANIM_TILES_END

      _Frame10
        ANIM_TILES
        ANIM_TILE_ROW $0F00, $0100
        ANIM_TILE_ROW $1000, $0080
        ANIM_TILES_END

      aBattleAnimationSequencesArcherBow ; 9A/D9BC

        ; Sequence data of entry 3 of aBattleAnimationFrameTables, used by: Archer (Bow), Sniper
        ; (Bow). Frames: aBattleAnimationFramesArcherBow.

        .word _Index - aBattleAnimationSequencesArcherBow, _Records - aBattleAnimationSequencesArcherBow

      _Index
        .word _Sequence00 - aBattleAnimationSequencesArcherBow
        .word _Sequence01 - aBattleAnimationSequencesArcherBow
        .word _Sequence02 - aBattleAnimationSequencesArcherBow
        .word _Sequence03 - aBattleAnimationSequencesArcherBow
        .word _Sequence04 - aBattleAnimationSequencesArcherBow
        .word _Sequence05 - aBattleAnimationSequencesArcherBow
        .word _Sequence06 - aBattleAnimationSequencesArcherBow
        .word _Sequence07 - aBattleAnimationSequencesArcherBow
        .word _Sequence08 - aBattleAnimationSequencesArcherBow
        .word _Sequence09 - aBattleAnimationSequencesArcherBow
        .word _Sequence10 - aBattleAnimationSequencesArcherBow
        .word _Sequence11 - aBattleAnimationSequencesArcherBow
        .word _Sequence12 - aBattleAnimationSequencesArcherBow
        .word _Sequence13 - aBattleAnimationSequencesArcherBow
        .word _Sequence14 - aBattleAnimationSequencesArcherBow
        .word _Sequence15 - aBattleAnimationSequencesArcherBow
        .word _Sequence16 - aBattleAnimationSequencesArcherBow

      _Records
        .word _Record00 - aBattleAnimationSequencesArcherBow
        .word _Record01 - aBattleAnimationSequencesArcherBow
        .word _Record02 - aBattleAnimationSequencesArcherBow
        .word _Record03 - aBattleAnimationSequencesArcherBow
        .word _Record04 - aBattleAnimationSequencesArcherBow
        .word _Record05 - aBattleAnimationSequencesArcherBow
        .word _Record06 - aBattleAnimationSequencesArcherBow
        .word _Record07 - aBattleAnimationSequencesArcherBow
        .word _Record08 - aBattleAnimationSequencesArcherBow
        .word _Record09 - aBattleAnimationSequencesArcherBow
        .word _Record10 - aBattleAnimationSequencesArcherBow
        .word _Record11 - aBattleAnimationSequencesArcherBow
        .word _Record12 - aBattleAnimationSequencesArcherBow
        .word _Record13 - aBattleAnimationSequencesArcherBow
        .word _Record14 - aBattleAnimationSequencesArcherBow
        .word _Record15 - aBattleAnimationSequencesArcherBow
        .word _Record16 - aBattleAnimationSequencesArcherBow
        .word _Record17 - aBattleAnimationSequencesArcherBow
        .word _Record18 - aBattleAnimationSequencesArcherBow

      _Sequence00
        ANIM_CLEAR_BUSY
        ANIM_STEP 1, 1
        ANIM_HOLD

      _Sequence01
        ANIM_SOUND 18
        ANIM_STEP 1, 7
        ANIM_STEP 13, 9
        ANIM_SOUND 18
        ANIM_STEP 14, 9
        ANIM_STEP 1, 1
        ANIM_CMD_F4 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence02
        ANIM_STEP 2, 5
        ANIM_STEP 3, 7
        ANIM_STEP 4, 7
        ANIM_STEP 5, 5
        ANIM_STEP 6, 16
        ANIM_SOUND 9
        ANIM_STEP 7, 38
        ANIM_CMD_EF 12
        ANIM_SOUND 10
        ANIM_STEP 9, 2
        ANIM_CMD_EE
        ANIM_STEP 8, 2
        ANIM_STEP 9, 2
        ANIM_STEP 8, 2
        ANIM_STEP 9, 2
        ANIM_STEP 8, 2
        ANIM_STEP 9, 2
        ANIM_STEP 8, 18
        ANIM_STEP 2, 5
        ANIM_STEP 1, 1
        ANIM_CMD_F3
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence03
        ANIM_STEP 2, 3
        ANIM_STEP 3, 7
        ANIM_STEP 4, 6
        ANIM_STEP 5, 5
        ANIM_STEP 6, 23
        ANIM_SOUND 9
        ANIM_STEP 7, 7
        ANIM_STEP 10, 32
        ANIM_CMD_EF 5
        ANIM_SOUND 10
        ANIM_STEP 11, 2
        ANIM_CMD_EE
        ANIM_STEP 12, 2
        ANIM_STEP 11, 2
        ANIM_STEP 12, 2
        ANIM_STEP 11, 2
        ANIM_STEP 12, 2
        ANIM_STEP 11, 2
        ANIM_STEP 12, 18
        ANIM_STEP 2, 5
        ANIM_STEP 1, 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence04
        ANIM_STEP 1, 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence05
        ANIM_CLEAR_BUSY
        ANIM_STEP 15, 1
        ANIM_HOLD

      _Sequence06
        ANIM_CLEAR_BUSY
        ANIM_STEP 15, 1
        ANIM_HOLD

      _Sequence07
        ANIM_CLEAR_BUSY
        ANIM_STEP 16, 1
        ANIM_HOLD

      _Sequence08
        ANIM_CLEAR_BUSY
        ANIM_STEP 17, 1
        ANIM_HOLD

      _Sequence09
        ANIM_CLEAR_BUSY
        ANIM_STEP 17, 1
        ANIM_HOLD

      _Sequence10
        ANIM_STEP 2, 5
        ANIM_STEP 3, 7
        ANIM_STEP 4, 7
        ANIM_STEP 5, 5
        ANIM_STEP 6, 16
        ANIM_SOUND 9
        ANIM_STEP 7, 64
        ANIM_CMD_EF 12
        ANIM_SOUND 10
        ANIM_STEP 9, 2
        ANIM_CMD_EE
        ANIM_STEP 8, 2
        ANIM_STEP 9, 2
        ANIM_STEP 8, 2
        ANIM_STEP 9, 2
        ANIM_STEP 8, 2
        ANIM_STEP 9, 2
        ANIM_STEP 8, 18
        ANIM_STEP 2, 5
        ANIM_STEP 1, 1
        ANIM_CMD_F3
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence11
        ANIM_STEP 2, 3
        ANIM_STEP 3, 7
        ANIM_STEP 4, 6
        ANIM_STEP 5, 5
        ANIM_STEP 6, 23
        ANIM_SOUND 9
        ANIM_STEP 7, 7
        ANIM_STEP 10, 32
        ANIM_CMD_EF 5
        ANIM_SOUND 10
        ANIM_STEP 11, 2
        ANIM_CMD_EE
        ANIM_STEP 12, 2
        ANIM_STEP 11, 2
        ANIM_STEP 12, 2
        ANIM_STEP 11, 2
        ANIM_STEP 12, 2
        ANIM_STEP 11, 2
        ANIM_STEP 12, 18
        ANIM_STEP 2, 5
        ANIM_STEP 1, 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence12
        ANIM_STEP 16, 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence13
        ANIM_STEP 16, 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence14
        ANIM_STEP 16, 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence15
        ANIM_STEP 16, 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence16
        ANIM_STEP 16, 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Record00
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (   1,   -2), $00, SpriteSmall, $0F1, 2, 3, false, false
        .structSpriteEntry (   9,   -2), $00, SpriteSmall, $0F2, 2, 3, false, false
        .structSpriteEntry (  -7,   -2), $00, SpriteSmall, $0F1, 2, 3, false, false
        .structSpriteEntry ( -15,   -2), $00, SpriteSmall, $0F0, 2, 3, false, false
        ANIM_RECORD_END

      _Record01
        ANIM_RECORD 0
        .structSpriteEntry (  -8,  -23), $00, SpriteSmall, $059, 2, 2, false, false
        .structSpriteEntry (  -8,  -31), $00, SpriteSmall, $049, 2, 2, false, false
        .structSpriteEntry (   5,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   5,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   5,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   5,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -11,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -11,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -12,  -25), $00, SpriteSmall, $052, 2, 2, false, false
        .structSpriteEntry ( -12,  -17), $21, SpriteLarge, $043, 2, 2, false, false
        .structSpriteEntry ( -12,  -33), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry (  -4,  -30), $21, SpriteLarge, $084, 2, 0, false, false
        ANIM_RECORD_END

      _Record02
        ANIM_RECORD 1
        .structSpriteEntry (  -9,  -23), $00, SpriteSmall, $059, 2, 2, false, false
        .structSpriteEntry (  -9,  -31), $00, SpriteSmall, $049, 2, 2, false, false
        .structSpriteEntry (   5,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   5,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   5,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   5,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -11,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -11,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -14,  -17), $21, SpriteLarge, $043, 2, 2, false, false
        .structSpriteEntry ( -14,  -25), $00, SpriteSmall, $052, 2, 2, false, false
        .structSpriteEntry ( -14,  -33), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry (  -4,  -30), $21, SpriteLarge, $084, 2, 0, false, false
        ANIM_RECORD_END

      _Record03
        ANIM_RECORD 2
        .structSpriteEntry (  -9,  -23), $00, SpriteSmall, $059, 2, 2, false, false
        .structSpriteEntry (  -9,  -31), $00, SpriteSmall, $049, 2, 2, false, false
        .structSpriteEntry ( -11,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -11,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   5,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   5,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   5,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   5,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -14,  -25), $00, SpriteSmall, $052, 2, 2, false, false
        .structSpriteEntry ( -14,  -33), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry ( -14,  -17), $21, SpriteLarge, $043, 2, 2, false, false
        ANIM_RECORD_END

      _Record04
        ANIM_RECORD 3
        .structSpriteEntry (  -9,  -23), $00, SpriteSmall, $059, 2, 2, false, false
        .structSpriteEntry (  -9,  -31), $00, SpriteSmall, $049, 2, 2, false, false
        .structSpriteEntry ( -11,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (   5,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   5,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   5,  -31), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry ( -11,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   5,  -23), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -14,  -17), $21, SpriteLarge, $043, 2, 2, false, false
        .structSpriteEntry ( -14,  -25), $00, SpriteSmall, $052, 2, 2, false, false
        .structSpriteEntry ( -14,  -33), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry (  -5,  -29), $21, SpriteLarge, $084, 2, 0, false, false
        ANIM_RECORD_END

      _Record05
        ANIM_RECORD 4
        .structSpriteEntry (  -5,  -40), $00, SpriteSmall, $05E, 2, 2, false, true
        .structSpriteEntry (  -5,  -32), $00, SpriteSmall, $05D, 2, 2, false, true
        .structSpriteEntry (  -5,  -24), $00, SpriteSmall, $04D, 2, 2, false, true
        .structSpriteEntry (   5,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   5,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry ( -11,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (   5,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry ( -10,  -24), $00, SpriteSmall, $059, 2, 2, false, false
        .structSpriteEntry ( -10,  -32), $00, SpriteSmall, $049, 2, 2, false, false
        .structSpriteEntry ( -15,  -26), $00, SpriteSmall, $052, 2, 2, false, false
        .structSpriteEntry ( -15,  -34), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry ( -15,  -18), $21, SpriteLarge, $043, 2, 2, false, false
        .structSpriteEntry ( -11,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   5,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry (  -6,  -29), $21, SpriteLarge, $084, 2, 0, false, false
        ANIM_RECORD_END

      _Record06
        ANIM_RECORD 4
        .structSpriteEntry (  -9,  -18), $00, SpriteSmall, $04C, 2, 2, false, false
        .structSpriteEntry ( -17,  -18), $00, SpriteSmall, $04B, 2, 2, false, false
        .structSpriteEntry ( -25,  -18), $00, SpriteSmall, $04A, 2, 2, false, false
        .structSpriteEntry ( -10,  -24), $00, SpriteSmall, $059, 2, 2, false, false
        .structSpriteEntry ( -10,  -32), $00, SpriteSmall, $049, 2, 2, false, false
        .structSpriteEntry (   5,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   5,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry ( -11,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (   5,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry ( -11,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   5,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -15,  -26), $00, SpriteSmall, $052, 2, 2, false, false
        .structSpriteEntry ( -15,  -34), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry ( -15,  -18), $21, SpriteLarge, $043, 2, 2, false, false
        .structSpriteEntry (  -6,  -28), $21, SpriteLarge, $084, 2, 0, false, false
        ANIM_RECORD_END

      _Record07
        ANIM_RECORD 5
        .structSpriteEntry (  -5,  -27), $00, SpriteSmall, $05C, 2, 2, false, false
        .structSpriteEntry ( -13,  -27), $00, SpriteSmall, $05B, 2, 2, false, false
        .structSpriteEntry ( -21,  -27), $00, SpriteSmall, $05A, 2, 2, false, false
        .structSpriteEntry (  -5,  -24), $00, SpriteSmall, $059, 2, 2, false, true
        .structSpriteEntry (  -5,  -16), $00, SpriteSmall, $049, 2, 2, false, true
        .structSpriteEntry (  -5,  -30), $00, SpriteSmall, $059, 2, 2, false, false
        .structSpriteEntry (  -5,  -38), $00, SpriteSmall, $049, 2, 2, false, false
        .structSpriteEntry ( -22,  -23), $21, SpriteLarge, $045, 2, 2, false, true
        .structSpriteEntry ( -22,  -39), $21, SpriteLarge, $045, 2, 2, false, false
        .structSpriteEntry (  -6,  -15), $00, SpriteSmall, $047, 2, 2, false, true
        .structSpriteEntry (  -6,  -39), $00, SpriteSmall, $047, 2, 2, false, false
        .structSpriteEntry ( -14,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -14,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   2,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   2,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   2,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   2,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry (  -5,  -30), $21, SpriteLarge, $084, 2, 0, false, false
        ANIM_RECORD_END

      _Record08
        ANIM_RECORD 6
        .structSpriteEntry (  -9,  -17), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry (  -9,  -25), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry (  -9,  -31), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry (  -9,  -37), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry ( -22,  -23), $21, SpriteLarge, $040, 2, 2, false, true
        .structSpriteEntry ( -22,  -39), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry ( -14,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -14,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   2,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   2,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   2,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   2,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry (  -5,  -29), $21, SpriteLarge, $084, 2, 0, false, false
        ANIM_RECORD_END

      _Record09
        ANIM_RECORD 6
        .structSpriteEntry ( -10,  -17), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry ( -10,  -25), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry ( -10,  -31), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry ( -10,  -37), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry ( -22,  -23), $21, SpriteLarge, $040, 2, 2, false, true
        .structSpriteEntry ( -22,  -39), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry ( -14,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -14,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   2,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   2,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   2,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   2,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry (  -5,  -29), $21, SpriteLarge, $084, 2, 0, false, false
        ANIM_RECORD_END

      _Record10
        ANIM_RECORD 7
        .structSpriteEntry (  -4,  -31), $00, SpriteSmall, $04C, 2, 2, false, true
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $04B, 2, 2, false, true
        .structSpriteEntry ( -20,  -31), $00, SpriteSmall, $04A, 2, 2, false, true
        .structSpriteEntry (   0,  -32), $00, SpriteSmall, $058, 2, 2, false, false
        .structSpriteEntry (  -1,  -40), $00, SpriteSmall, $058, 2, 2, false, false
        .structSpriteEntry (  -6,  -23), $00, SpriteSmall, $057, 2, 2, false, true
        .structSpriteEntry ( -10,  -20), $00, SpriteSmall, $057, 2, 2, false, true
        .structSpriteEntry ( -15,  -42), $21, SpriteLarge, $043, 2, 2, false, true
        .structSpriteEntry ( -15,  -26), $00, SpriteSmall, $052, 2, 2, false, true
        .structSpriteEntry ( -15,  -18), $00, SpriteSmall, $042, 2, 2, false, true
        .structSpriteEntry ( -14,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -14,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   2,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   2,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   2,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   2,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry (  -4,  -30), $21, SpriteLarge, $084, 2, 0, false, false
        ANIM_RECORD_END

      _Record11
        ANIM_RECORD 8
        .structSpriteEntry ( -11,  -22), $00, SpriteSmall, $059, 2, 2, false, true
        .structSpriteEntry (  -8,  -30), $00, SpriteSmall, $059, 2, 2, false, true
        .structSpriteEntry (  -5,  -38), $00, SpriteSmall, $059, 2, 2, false, true
        .structSpriteEntry ( -15,  -42), $21, SpriteLarge, $043, 2, 2, false, true
        .structSpriteEntry ( -15,  -26), $00, SpriteSmall, $052, 2, 2, false, true
        .structSpriteEntry ( -15,  -18), $00, SpriteSmall, $042, 2, 2, false, true
        .structSpriteEntry (   5,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   5,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   5,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   5,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -11,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -11,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (  -4,  -30), $21, SpriteLarge, $084, 2, 0, false, false
        ANIM_RECORD_END

      _Record12
        ANIM_RECORD 8
        .structSpriteEntry ( -10,  -22), $00, SpriteSmall, $059, 2, 2, false, true
        .structSpriteEntry (  -7,  -30), $00, SpriteSmall, $059, 2, 2, false, true
        .structSpriteEntry (  -4,  -38), $00, SpriteSmall, $059, 2, 2, false, true
        .structSpriteEntry ( -15,  -42), $21, SpriteLarge, $043, 2, 2, false, true
        .structSpriteEntry ( -15,  -26), $00, SpriteSmall, $052, 2, 2, false, true
        .structSpriteEntry ( -15,  -18), $00, SpriteSmall, $042, 2, 2, false, true
        .structSpriteEntry (   5,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   5,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   5,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   5,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -11,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -11,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (  -4,  -30), $21, SpriteLarge, $084, 2, 0, false, false
        ANIM_RECORD_END

      _Record13
        ANIM_RECORD 9
        .structSpriteEntry (  -7,  -25), $00, SpriteSmall, $059, 2, 2, false, false
        .structSpriteEntry (  -7,  -33), $00, SpriteSmall, $049, 2, 2, false, false
        .structSpriteEntry (   5,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   5,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry ( -11,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -11,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   5,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   5,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -11,  -19), $21, SpriteLarge, $043, 2, 2, false, false
        .structSpriteEntry ( -11,  -27), $00, SpriteSmall, $052, 2, 2, false, false
        .structSpriteEntry ( -11,  -35), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry (  -4,  -29), $21, SpriteLarge, $084, 2, 0, false, false
        ANIM_RECORD_END

      _Record14
        ANIM_RECORD 10
        .structSpriteEntry (  -8,  -23), $00, SpriteSmall, $059, 2, 2, false, false
        .structSpriteEntry (  -8,  -31), $00, SpriteSmall, $049, 2, 2, false, false
        .structSpriteEntry (   5,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   5,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   5,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   5,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -11,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -11,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -12,  -18), $21, SpriteLarge, $043, 2, 2, false, false
        .structSpriteEntry ( -12,  -26), $00, SpriteSmall, $052, 2, 2, false, false
        .structSpriteEntry ( -12,  -34), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry (  -4,  -29), $21, SpriteLarge, $084, 2, 0, false, false
        ANIM_RECORD_END

      _Record15
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (   4,   -6), $00, SpriteSmall, $04C, 2, 2, false, true
        .structSpriteEntry (  -4,   -6), $00, SpriteSmall, $04B, 2, 2, false, true
        .structSpriteEntry ( -12,   -6), $00, SpriteSmall, $04A, 2, 2, false, true
        ANIM_RECORD_END

      _Record16
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $05C, 2, 2, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $05B, 2, 2, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $05A, 2, 2, false, false
        ANIM_RECORD_END

      _Record17
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (   4,   -6), $00, SpriteSmall, $04C, 2, 2, false, false
        .structSpriteEntry (  -4,   -6), $00, SpriteSmall, $04B, 2, 2, false, false
        .structSpriteEntry ( -12,   -6), $00, SpriteSmall, $04A, 2, 2, false, false
        ANIM_RECORD_END

      _Record18
        ANIM_RECORD 10
        .structSpriteEntry (  -8,  -23), $00, SpriteSmall, $057, 2, 2, false, false
        .structSpriteEntry (  -8,  -31), $00, SpriteSmall, $047, 2, 2, false, false
        .structSpriteEntry (   5,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   5,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   5,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   5,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -11,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -11,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (  -4,  -29), $21, SpriteLarge, $084, 2, 0, false, false
        .structSpriteEntry ( -12,  -18), $21, SpriteLarge, $042, 2, 2, false, false
        .structSpriteEntry ( -12,  -26), $00, SpriteSmall, $051, 2, 2, false, false
        .structSpriteEntry ( -12,  -34), $00, SpriteSmall, $041, 2, 2, false, false
        ANIM_RECORD_END

      aBattleAnimationFramesBowArmorBow ; 9A/DF7C

        ; Frame table of entry 38: slices of the class sheet per frame.

        .word _Frame00 - aBattleAnimationFramesBowArmorBow
        .word _Frame01 - aBattleAnimationFramesBowArmorBow
        .word _Frame02 - aBattleAnimationFramesBowArmorBow
        .word _Frame03 - aBattleAnimationFramesBowArmorBow
        .word _Frame04 - aBattleAnimationFramesBowArmorBow
        .word _Frame05 - aBattleAnimationFramesBowArmorBow
        .word _Frame06 - aBattleAnimationFramesBowArmorBow
        .word _Frame07 - aBattleAnimationFramesBowArmorBow

      _Frame00
        ANIM_TILES
        ANIM_TILE_ROW $0000, $0180
        ANIM_TILE_ROW $0180, $0100
        ANIM_TILES_END

      _Frame01
        ANIM_TILES
        ANIM_TILE_ROW $0280, $0180
        ANIM_TILE_ROW $0400, $0100
        ANIM_TILES_END

      _Frame02
        ANIM_TILES
        ANIM_TILE_ROW $0500, $0180
        ANIM_TILE_ROW $0680, $0100
        ANIM_TILES_END

      _Frame03
        ANIM_TILES
        ANIM_TILE_ROW $0780, $0180
        ANIM_TILE_ROW $0900, $0100
        ANIM_TILES_END

      _Frame04
        ANIM_TILES
        ANIM_TILE_ROW $0A00, $0180
        ANIM_TILE_ROW $0B80, $0100
        ANIM_TILES_END

      _Frame05
        ANIM_TILES
        ANIM_TILE_ROW $0C80, $0180
        ANIM_TILE_ROW $0E00, $0100
        ANIM_TILES_END

      _Frame06
        ANIM_TILES
        ANIM_TILE_ROW $0F00, $0180
        ANIM_TILE_ROW $1080, $0100
        ANIM_TILES_END

      _Frame07
        ANIM_TILES
        ANIM_TILE_ROW $1180, $0180
        ANIM_TILE_ROW $1300, $0100
        ANIM_TILES_END

      aBattleAnimationSequencesBowArmorBow ; 9A/DFD4

        ; Sequence data of entry 38 of aBattleAnimationFrameTables, used by: BowArmor (Bow).
        ; Frames: aBattleAnimationFramesBowArmorBow.

        .word _Index - aBattleAnimationSequencesBowArmorBow, _Records - aBattleAnimationSequencesBowArmorBow

      _Index
        .word _Sequence00 - aBattleAnimationSequencesBowArmorBow
        .word _Sequence01 - aBattleAnimationSequencesBowArmorBow
        .word _Sequence02 - aBattleAnimationSequencesBowArmorBow
        .word _Sequence03 - aBattleAnimationSequencesBowArmorBow
        .word _Sequence04 - aBattleAnimationSequencesBowArmorBow
        .word _Sequence05 - aBattleAnimationSequencesBowArmorBow
        .word _Sequence06 - aBattleAnimationSequencesBowArmorBow
        .word _Sequence07 - aBattleAnimationSequencesBowArmorBow
        .word _Sequence08 - aBattleAnimationSequencesBowArmorBow
        .word _Sequence09 - aBattleAnimationSequencesBowArmorBow
        .word _Sequence10 - aBattleAnimationSequencesBowArmorBow
        .word _Sequence11 - aBattleAnimationSequencesBowArmorBow
        .word _Sequence12 - aBattleAnimationSequencesBowArmorBow
        .word _Sequence13 - aBattleAnimationSequencesBowArmorBow
        .word _Sequence14 - aBattleAnimationSequencesBowArmorBow
        .word _Sequence15 - aBattleAnimationSequencesBowArmorBow
        .word _Sequence16 - aBattleAnimationSequencesBowArmorBow
        .word _Sequence17 - aBattleAnimationSequencesBowArmorBow
        .word _Sequence18 - aBattleAnimationSequencesBowArmorBow
        .word _Sequence19 - aBattleAnimationSequencesBowArmorBow
        .word _Sequence20 - aBattleAnimationSequencesBowArmorBow

      _Records
        .word _Record00 - aBattleAnimationSequencesBowArmorBow
        .word _Record01 - aBattleAnimationSequencesBowArmorBow
        .word _Record02 - aBattleAnimationSequencesBowArmorBow
        .word _Record03 - aBattleAnimationSequencesBowArmorBow
        .word _Record04 - aBattleAnimationSequencesBowArmorBow
        .word _Record05 - aBattleAnimationSequencesBowArmorBow
        .word _Record06 - aBattleAnimationSequencesBowArmorBow
        .word _Record07 - aBattleAnimationSequencesBowArmorBow
        .word _Record08 - aBattleAnimationSequencesBowArmorBow
        .word _Record09 - aBattleAnimationSequencesBowArmorBow
        .word _Record10 - aBattleAnimationSequencesBowArmorBow
        .word _Record11 - aBattleAnimationSequencesBowArmorBow
        .word _Record12 - aBattleAnimationSequencesBowArmorBow
        .word _Record13 - aBattleAnimationSequencesBowArmorBow
        .word _Record14 - aBattleAnimationSequencesBowArmorBow

      _Sequence00
        ANIM_CLEAR_BUSY
        ANIM_STEP 1, 1
        ANIM_HOLD

      _Sequence01
        ANIM_CLEAR_BUSY
        ANIM_STEP 1, 4
        ANIM_STEP 11, 4
        ANIM_STEP 11, 1
        ANIM_CMD_F4 1
        ANIM_HOLD

      _Sequence02
        ANIM_CLEAR_BUSY
        ANIM_STEP 1, 2
        ANIM_CMD_EC 1
        ANIM_STEP 11, 1
        ANIM_STEP 11, 2
        ANIM_STEP 11, 1
        ANIM_STEP 11, 1
        ANIM_STEP 11, 1
        ANIM_CMD_EC 0
        ANIM_STEP 11, 2
        ANIM_CMD_F4 1
        ANIM_HOLD

      _Sequence03
        ANIM_STEP 2, 21
        ANIM_STEP 3, 4
        ANIM_STEP 4, 6
        ANIM_STEP 5, 5
        ANIM_SOUND 9
        ANIM_STEP 8, 38
        ANIM_CMD_EF 8
        ANIM_SOUND 10
        ANIM_STEP 9, 2
        ANIM_CMD_EE
        ANIM_STEP 10, 2
        ANIM_STEP 9, 2
        ANIM_STEP 10, 2
        ANIM_STEP 9, 2
        ANIM_STEP 10, 2
        ANIM_STEP 9, 16
        ANIM_STEP 7, 5
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence04
        ANIM_STEP 2, 21
        ANIM_STEP 3, 4
        ANIM_STEP 4, 7
        ANIM_SOUND 9
        ANIM_STEP 5, 38
        ANIM_CMD_EF 8
        ANIM_SOUND 10
        ANIM_STEP 6, 2
        ANIM_CMD_EE
        ANIM_STEP 7, 2
        ANIM_STEP 6, 2
        ANIM_STEP 7, 2
        ANIM_STEP 6, 2
        ANIM_STEP 7, 16
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence05
        ANIM_STEP 2, 21
        ANIM_STEP 3, 4
        ANIM_STEP 4, 6
        ANIM_STEP 5, 5
        ANIM_SOUND 9
        ANIM_STEP 8, 32
        ANIM_CMD_EF 8
        ANIM_SOUND 10
        ANIM_STEP 9, 2
        ANIM_CMD_EE
        ANIM_STEP 10, 2
        ANIM_STEP 9, 2
        ANIM_STEP 10, 2
        ANIM_STEP 9, 2
        ANIM_STEP 10, 2
        ANIM_STEP 9, 16
        ANIM_STEP 7, 5
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence06
        ANIM_CLEAR_BUSY
        ANIM_STEP 1, 16
        ANIM_HOLD

      _Sequence07
        ANIM_STEP 2, 21
        ANIM_STEP 3, 4
        ANIM_STEP 4, 7
        ANIM_SOUND 9
        ANIM_STEP 5, 32
        ANIM_CMD_EF 8
        ANIM_SOUND 10
        ANIM_STEP 6, 2
        ANIM_CMD_EE
        ANIM_STEP 7, 2
        ANIM_STEP 6, 2
        ANIM_STEP 7, 2
        ANIM_STEP 6, 2
        ANIM_STEP 7, 16
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence08
        ANIM_STEP 13, 0
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence09
        ANIM_STEP 13, 0
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence10
        ANIM_STEP 13, 0
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence11
        ANIM_STEP 13, 0
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence12
        ANIM_STEP 13, 0
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence13
        ANIM_STEP 11, 5
        ANIM_STEP 1, 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence14
        ANIM_STEP 12, 0
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence15
        ANIM_STEP 12, 0
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence16
        ANIM_STEP 13, 0
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence17
        ANIM_STEP 14, 0
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence18
        ANIM_STEP 14, 0
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence19
        ANIM_STEP 2, 21
        ANIM_STEP 3, 4
        ANIM_STEP 4, 7
        ANIM_SOUND 9
        ANIM_STEP 5, 64
        ANIM_CMD_EF 8
        ANIM_SOUND 10
        ANIM_STEP 6, 2
        ANIM_CMD_EE
        ANIM_STEP 7, 2
        ANIM_STEP 6, 2
        ANIM_STEP 7, 2
        ANIM_STEP 6, 2
        ANIM_STEP 7, 16
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence20
        ANIM_STEP 2, 21
        ANIM_STEP 3, 4
        ANIM_STEP 4, 6
        ANIM_STEP 5, 5
        ANIM_SOUND 9
        ANIM_STEP 8, 64
        ANIM_CMD_EF 8
        ANIM_SOUND 10
        ANIM_STEP 9, 2
        ANIM_CMD_EE
        ANIM_STEP 10, 2
        ANIM_STEP 9, 2
        ANIM_STEP 10, 2
        ANIM_STEP 9, 2
        ANIM_STEP 10, 2
        ANIM_STEP 9, 16
        ANIM_STEP 7, 5
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Record00
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry ( -14,   -2), $00, SpriteSmall, $0F1, 2, 3, false, false
        .structSpriteEntry (  18,   -2), $00, SpriteSmall, $0F4, 2, 3, false, false
        .structSpriteEntry (  10,   -2), $00, SpriteSmall, $0F3, 2, 3, false, false
        .structSpriteEntry (   2,   -2), $00, SpriteSmall, $0F2, 2, 3, false, false
        .structSpriteEntry (  -6,   -2), $00, SpriteSmall, $0F1, 2, 3, false, false
        .structSpriteEntry ( -22,   -2), $00, SpriteSmall, $0F0, 2, 3, false, false
        ANIM_RECORD_END

      _Record01
        ANIM_RECORD 0
        .structSpriteEntry ( -11,  -27), $00, SpriteSmall, $059, 2, 2, false, false
        .structSpriteEntry ( -11,  -35), $00, SpriteSmall, $049, 2, 2, false, false
        .structSpriteEntry (  -2,  -22), $21, SpriteLarge, $084, 2, 0, true, false
        .structSpriteEntry (  10,  -39), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -39), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -39), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -39), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   2,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -14,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   2,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -14,  -31), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry ( -16,  -21), $21, SpriteLarge, $043, 2, 2, false, false
        .structSpriteEntry ( -16,  -29), $00, SpriteSmall, $052, 2, 2, false, false
        .structSpriteEntry ( -16,  -37), $00, SpriteSmall, $042, 2, 2, false, false
        ANIM_RECORD_END

      _Record02
        ANIM_RECORD 1
        .structSpriteEntry ( -11,  -27), $00, SpriteSmall, $059, 2, 2, false, false
        .structSpriteEntry ( -11,  -35), $00, SpriteSmall, $049, 2, 2, false, false
        .structSpriteEntry (   2,  -23), $00, SpriteSmall, $04D, 2, 2, false, false
        .structSpriteEntry (  -2,  -22), $21, SpriteLarge, $084, 2, 0, true, false
        .structSpriteEntry (  10,  -39), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -39), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -39), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -39), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   2,  -31), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -14,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   2,  -15), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -14,  -15), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry ( -16,  -29), $00, SpriteSmall, $052, 2, 2, false, false
        .structSpriteEntry ( -16,  -37), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry ( -16,  -21), $21, SpriteLarge, $043, 2, 2, false, false
        ANIM_RECORD_END

      _Record03
        ANIM_RECORD 1
        .structSpriteEntry ( -11,  -27), $00, SpriteSmall, $059, 2, 2, false, false
        .structSpriteEntry ( -11,  -35), $00, SpriteSmall, $049, 2, 2, false, false
        .structSpriteEntry (  -4,   -8), $00, SpriteSmall, $05E, 2, 2, true, false
        .structSpriteEntry (  -4,  -16), $00, SpriteSmall, $05D, 2, 2, true, false
        .structSpriteEntry (  -4,  -24), $00, SpriteSmall, $04D, 2, 2, true, false
        .structSpriteEntry (  -2,  -22), $21, SpriteLarge, $084, 2, 0, true, false
        .structSpriteEntry (  10,  -39), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -39), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -39), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -39), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   2,  -31), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -14,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   2,  -15), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -14,  -15), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry ( -16,  -21), $21, SpriteLarge, $043, 2, 2, false, false
        .structSpriteEntry ( -16,  -29), $00, SpriteSmall, $052, 2, 2, false, false
        .structSpriteEntry ( -16,  -37), $00, SpriteSmall, $042, 2, 2, false, false
        ANIM_RECORD_END

      _Record04
        ANIM_RECORD 2
        .structSpriteEntry ( -11,  -29), $00, SpriteSmall, $059, 2, 2, false, false
        .structSpriteEntry ( -11,  -37), $00, SpriteSmall, $049, 2, 2, false, false
        .structSpriteEntry ( -14,  -23), $00, SpriteSmall, $04B, 2, 2, false, false
        .structSpriteEntry ( -22,  -23), $00, SpriteSmall, $04A, 2, 2, false, false
        .structSpriteEntry (  -6,  -23), $00, SpriteSmall, $04C, 2, 2, false, false
        .structSpriteEntry (  -2,  -22), $21, SpriteLarge, $084, 2, 0, true, false
        .structSpriteEntry (  10,  -39), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -39), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -39), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -39), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   2,  -31), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -14,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   2,  -15), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -14,  -15), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry ( -16,  -23), $21, SpriteLarge, $043, 2, 2, false, false
        .structSpriteEntry ( -16,  -31), $00, SpriteSmall, $052, 2, 2, false, false
        .structSpriteEntry ( -16,  -39), $00, SpriteSmall, $042, 2, 2, false, false
        ANIM_RECORD_END

      _Record05
        ANIM_RECORD 3
        .structSpriteEntry (  -4,  -30), $00, SpriteSmall, $05C, 2, 2, false, false
        .structSpriteEntry ( -12,  -30), $00, SpriteSmall, $05B, 2, 2, false, false
        .structSpriteEntry ( -20,  -30), $00, SpriteSmall, $05A, 2, 2, false, false
        .structSpriteEntry (  -7,  -40), $00, SpriteSmall, $059, 2, 2, false, false
        .structSpriteEntry (  -4,  -26), $00, SpriteSmall, $059, 2, 2, false, true
        .structSpriteEntry (  -5,  -34), $00, SpriteSmall, $059, 2, 2, false, false
        .structSpriteEntry (  -6,  -20), $00, SpriteSmall, $059, 2, 2, false, true
        .structSpriteEntry (  -7,  -42), $00, SpriteSmall, $047, 2, 2, false, false
        .structSpriteEntry (  -7,  -18), $00, SpriteSmall, $047, 2, 2, false, true
        .structSpriteEntry ( -23,  -26), $21, SpriteLarge, $045, 2, 2, false, true
        .structSpriteEntry ( -23,  -42), $21, SpriteLarge, $045, 2, 2, false, false
        .structSpriteEntry (  -1,  -23), $21, SpriteLarge, $084, 2, 0, true, false
        .structSpriteEntry (  10,  -39), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -39), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -39), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -39), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   2,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -14,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   2,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -14,  -31), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record06
        ANIM_RECORD 4
        .structSpriteEntry ( -11,  -25), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry ( -11,  -33), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry ( -11,  -41), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry ( -11,  -19), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry ( -23,  -26), $21, SpriteLarge, $040, 2, 2, false, true
        .structSpriteEntry ( -23,  -42), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry (  -1,  -23), $21, SpriteLarge, $084, 2, 0, true, false
        .structSpriteEntry (  10,  -39), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -39), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -39), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -39), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   2,  -31), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -14,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   2,  -15), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -14,  -15), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record07
        ANIM_RECORD 4
        .structSpriteEntry ( -10,  -19), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry ( -10,  -25), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry ( -10,  -33), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry ( -10,  -41), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry ( -23,  -26), $21, SpriteLarge, $040, 2, 2, false, true
        .structSpriteEntry ( -23,  -42), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry (  -1,  -23), $21, SpriteLarge, $084, 2, 0, true, false
        .structSpriteEntry (  10,  -39), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -39), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -39), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -39), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   2,  -31), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -14,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   2,  -15), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -14,  -15), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record08
        ANIM_RECORD 5
        .structSpriteEntry (  -4,  -33), $00, SpriteSmall, $04C, 2, 2, false, true
        .structSpriteEntry ( -12,  -33), $00, SpriteSmall, $04B, 2, 2, false, true
        .structSpriteEntry ( -20,  -33), $00, SpriteSmall, $04A, 2, 2, false, true
        .structSpriteEntry (  -2,  -35), $00, SpriteSmall, $059, 2, 2, false, false
        .structSpriteEntry (  -2,  -43), $00, SpriteSmall, $049, 2, 2, false, false
        .structSpriteEntry ( -17,  -28), $00, SpriteSmall, $052, 2, 2, false, true
        .structSpriteEntry ( -17,  -20), $00, SpriteSmall, $042, 2, 2, false, true
        .structSpriteEntry ( -17,  -44), $21, SpriteLarge, $043, 2, 2, false, true
        .structSpriteEntry (  -5,  -27), $00, SpriteSmall, $057, 2, 2, false, true
        .structSpriteEntry ( -12,  -22), $00, SpriteSmall, $057, 2, 2, false, true
        .structSpriteEntry (  -1,  -22), $21, SpriteLarge, $084, 2, 0, true, false
        .structSpriteEntry (  10,  -39), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -39), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -39), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -39), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   2,  -31), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -14,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   2,  -15), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -14,  -15), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record09
        ANIM_RECORD 6
        .structSpriteEntry ( -11,  -30), $00, SpriteSmall, $059, 2, 2, false, true
        .structSpriteEntry (  -9,  -35), $00, SpriteSmall, $059, 2, 2, false, true
        .structSpriteEntry (  -7,  -41), $00, SpriteSmall, $059, 2, 2, false, true
        .structSpriteEntry ( -17,  -28), $00, SpriteSmall, $052, 2, 2, false, true
        .structSpriteEntry ( -17,  -20), $00, SpriteSmall, $042, 2, 2, false, true
        .structSpriteEntry ( -17,  -44), $21, SpriteLarge, $043, 2, 2, false, true
        .structSpriteEntry ( -14,  -22), $00, SpriteSmall, $059, 2, 2, false, true
        .structSpriteEntry (  -1,  -22), $21, SpriteLarge, $084, 2, 0, true, false
        .structSpriteEntry (  10,  -39), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -39), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -39), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -39), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   2,  -31), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -14,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   2,  -15), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -14,  -15), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record10
        ANIM_RECORD 6
        .structSpriteEntry (  -6,  -41), $00, SpriteSmall, $059, 2, 2, false, true
        .structSpriteEntry (  -8,  -35), $00, SpriteSmall, $059, 2, 2, false, true
        .structSpriteEntry ( -10,  -30), $00, SpriteSmall, $059, 2, 2, false, true
        .structSpriteEntry ( -17,  -44), $21, SpriteLarge, $043, 2, 2, false, true
        .structSpriteEntry ( -17,  -28), $00, SpriteSmall, $052, 2, 2, false, true
        .structSpriteEntry ( -17,  -20), $00, SpriteSmall, $042, 2, 2, false, true
        .structSpriteEntry ( -13,  -22), $00, SpriteSmall, $059, 2, 2, false, true
        .structSpriteEntry (  -1,  -22), $21, SpriteLarge, $084, 2, 0, true, false
        .structSpriteEntry (  10,  -39), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -39), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -39), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -39), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   2,  -31), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -14,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   2,  -15), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -14,  -15), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record11
        ANIM_RECORD 7
        .structSpriteEntry ( -10,  -28), $00, SpriteSmall, $059, 2, 2, false, false
        .structSpriteEntry ( -10,  -36), $00, SpriteSmall, $049, 2, 2, false, false
        .structSpriteEntry (   0,  -21), $21, SpriteLarge, $084, 2, 0, true, false
        .structSpriteEntry (  10,  -39), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -39), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -39), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -39), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   2,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -14,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   2,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -14,  -31), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry ( -15,  -30), $00, SpriteSmall, $052, 2, 2, false, false
        .structSpriteEntry ( -15,  -38), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry ( -15,  -22), $21, SpriteLarge, $043, 2, 2, false, false
        ANIM_RECORD_END

      _Record12
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (   4,   -6), $00, SpriteSmall, $04C, 2, 2, false, true
        .structSpriteEntry (  -4,   -6), $00, SpriteSmall, $04B, 2, 2, false, true
        .structSpriteEntry ( -12,   -6), $00, SpriteSmall, $04A, 2, 2, false, true
        ANIM_RECORD_END

      _Record13
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $05C, 2, 2, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $05B, 2, 2, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $05A, 2, 2, false, false
        ANIM_RECORD_END

      _Record14
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (   4,   -6), $00, SpriteSmall, $04C, 2, 2, false, false
        .structSpriteEntry (  -4,   -6), $00, SpriteSmall, $04B, 2, 2, false, false
        .structSpriteEntry ( -12,   -6), $00, SpriteSmall, $04A, 2, 2, false, false
        ANIM_RECORD_END

      aBattleAnimationFramesSwordmasterSword ; 9A/E558

        ; Frame table of entry 2: slices of the class sheet per frame.

        .word _Frame00 - aBattleAnimationFramesSwordmasterSword
        .word _Frame01 - aBattleAnimationFramesSwordmasterSword
        .word _Frame02 - aBattleAnimationFramesSwordmasterSword
        .word _Frame03 - aBattleAnimationFramesSwordmasterSword
        .word _Frame04 - aBattleAnimationFramesSwordmasterSword
        .word _Frame05 - aBattleAnimationFramesSwordmasterSword
        .word _Frame06 - aBattleAnimationFramesSwordmasterSword
        .word _Frame07 - aBattleAnimationFramesSwordmasterSword
        .word _Frame08 - aBattleAnimationFramesSwordmasterSword
        .word _Frame09 - aBattleAnimationFramesSwordmasterSword
        .word _Frame10 - aBattleAnimationFramesSwordmasterSword
        .word _Frame11 - aBattleAnimationFramesSwordmasterSword
        .word _Frame12 - aBattleAnimationFramesSwordmasterSword
        .word _Frame13 - aBattleAnimationFramesSwordmasterSword
        .word _Frame14 - aBattleAnimationFramesSwordmasterSword
        .word _Frame15 - aBattleAnimationFramesSwordmasterSword
        .word _Frame16 - aBattleAnimationFramesSwordmasterSword
        .word _Frame17 - aBattleAnimationFramesSwordmasterSword
        .word _Frame18 - aBattleAnimationFramesSwordmasterSword
        .word _Frame19 - aBattleAnimationFramesSwordmasterSword
        .word _Frame20 - aBattleAnimationFramesSwordmasterSword
        .word _Frame21 - aBattleAnimationFramesSwordmasterSword
        .word _Frame22 - aBattleAnimationFramesSwordmasterSword
        .word _Frame23 - aBattleAnimationFramesSwordmasterSword
        .word _Frame24 - aBattleAnimationFramesSwordmasterSword
        .word _Frame25 - aBattleAnimationFramesSwordmasterSword
        .word _Frame26 - aBattleAnimationFramesSwordmasterSword
        .word _Frame27 - aBattleAnimationFramesSwordmasterSword
        .word _Frame28 - aBattleAnimationFramesSwordmasterSword
        .word _Frame29 - aBattleAnimationFramesSwordmasterSword

      _Frame00
        ANIM_TILES
        ANIM_TILE_ROW $0000, $0080
        ANIM_TILE_ROW $0080, $0080
        ANIM_TILES_END

      _Frame01
        ANIM_TILES
        ANIM_TILE_ROW $0100, $0080
        ANIM_TILE_ROW $0180, $0080
        ANIM_TILES_END

      _Frame02
        ANIM_TILES
        ANIM_TILE_ROW $0200, $0100
        ANIM_TILE_ROW $0300, $0080
        ANIM_TILES_END

      _Frame03
        ANIM_TILES
        ANIM_TILE_ROW $0380, $0100
        ANIM_TILE_ROW $0480, $0080
        ANIM_TILES_END

      _Frame04
        ANIM_TILES
        ANIM_TILE_ROW $0500, $0100
        ANIM_TILE_ROW $0600, $0080
        ANIM_TILES_END

      _Frame05
        ANIM_TILES
        ANIM_TILE_ROW $0680, $0100
        ANIM_TILE_ROW $0780, $0080
        ANIM_TILES_END

      _Frame06
        ANIM_TILES
        ANIM_TILE_ROW $0800, $0100
        ANIM_TILE_ROW $0900, $0080
        ANIM_TILES_END

      _Frame07
        ANIM_TILES
        ANIM_TILE_ROW $0980, $0100
        ANIM_TILE_ROW $0A80, $0080
        ANIM_TILES_END

      _Frame08
        ANIM_TILES
        ANIM_TILE_ROW $0B00, $0100
        ANIM_TILE_ROW $0C00, $0080
        ANIM_TILES_END

      _Frame09
        ANIM_TILES
        ANIM_TILE_ROW $0C80, $0100
        ANIM_TILE_ROW $0D80, $0080
        ANIM_TILES_END

      _Frame10
        ANIM_TILES
        ANIM_TILE_ROW $0E00, $0100
        ANIM_TILE_ROW $0F00, $0080
        ANIM_TILES_END

      _Frame11
        ANIM_TILES
        ANIM_TILE_ROW $0F80, $00E0
        ANIM_TILE_ROW $1060, $0040
        ANIM_TILES_END

      _Frame12
        ANIM_TILES
        ANIM_TILE_ROW $10A0, $00E0
        ANIM_TILE_ROW $1180, $0040
        ANIM_TILES_END

      _Frame13
        ANIM_TILES
        ANIM_TILE_ROW $11C0, $0100
        ANIM_TILE_ROW $12C0, $0080
        ANIM_TILES_END

      _Frame14
        ANIM_TILES
        ANIM_TILE_ROW $1340, $0100
        ANIM_TILE_ROW $1440, $0080
        ANIM_TILES_END

      _Frame15
        ANIM_TILES
        ANIM_TILE_ROW $14C0, $0100
        ANIM_TILE_ROW $15C0, $0080
        ANIM_TILES_END

      _Frame16
        ANIM_TILES
        ANIM_TILE_ROW $1640, $0100
        ANIM_TILE_ROW $1740, $0080
        ANIM_TILES_END

      _Frame17
        ANIM_TILES
        ANIM_TILE_ROW $17C0, $0080
        ANIM_TILE_ROW $1840, $0080
        ANIM_TILES_END

      _Frame18
        ANIM_TILES
        ANIM_TILE_ROW $18C0, $00C0
        ANIM_TILE_ROW $1980, $0080
        ANIM_TILES_END

      _Frame19
        ANIM_TILES
        ANIM_TILE_ROW $1A00, $0100
        ANIM_TILE_ROW $1B00, $0080
        ANIM_TILES_END

      _Frame20
        ANIM_TILES
        ANIM_TILE_ROW $1B80, $0100
        ANIM_TILE_ROW $1C80, $0080
        ANIM_TILES_END

      _Frame21
        ANIM_TILES
        ANIM_TILE_ROW $1D00, $0100
        ANIM_TILE_ROW $1E00, $0080
        ANIM_TILES_END

      _Frame22
        ANIM_TILES
        ANIM_TILE_ROW $1E80, $00E0
        ANIM_TILE_ROW $1F60, $0040
        ANIM_TILES_END

      _Frame23
        ANIM_TILES
        ANIM_TILE_ROW $1FA0, $00C0
        ANIM_TILE_ROW $2060, $0080
        ANIM_TILES_END

      _Frame24
        ANIM_TILES
        ANIM_TILE_ROW $20E0, $0160
        ANIM_TILE_ROW $2240, $0080
        ANIM_TILES_END

      _Frame25
        ANIM_TILES
        ANIM_TILE_ROW $22C0, $0120
        ANIM_TILE_ROW $23E0, $0080
        ANIM_TILES_END

      _Frame26
        ANIM_TILES
        ANIM_TILE_ROW $2460, $00E0
        ANIM_TILE_ROW $2540, $0080
        ANIM_TILES_END

      _Frame27
        ANIM_TILES
        ANIM_TILE_ROW $25C0, $0100
        ANIM_TILE_ROW $26C0, $00C0
        ANIM_TILES_END

      _Frame28
        ANIM_TILES
        ANIM_TILE_ROW $2780, $0080
        ANIM_TILE_ROW $2800, $0080
        ANIM_TILES_END

      _Frame29
        ANIM_TILES
        ANIM_TILE_ROW $2880, $0100
        ANIM_TILE_ROW $2980, $0080
        ANIM_TILES_END

      aBattleAnimationSequencesSwordmasterSword ; 9A/E6A2

        ; Sequence data of entry 2 of aBattleAnimationFrameTables, used by: Swordmaster (Sword),
        ; Hero (Sword). Frames: aBattleAnimationFramesSwordmasterSword.

        .word _Index - aBattleAnimationSequencesSwordmasterSword, _Records - aBattleAnimationSequencesSwordmasterSword

      _Index
        .word _Sequence00 - aBattleAnimationSequencesSwordmasterSword
        .word _Sequence01 - aBattleAnimationSequencesSwordmasterSword
        .word _Sequence02 - aBattleAnimationSequencesSwordmasterSword
        .word _Sequence03 - aBattleAnimationSequencesSwordmasterSword
        .word _Sequence04 - aBattleAnimationSequencesSwordmasterSword
        .word _Sequence05 - aBattleAnimationSequencesSwordmasterSword
        .word _Sequence06 - aBattleAnimationSequencesSwordmasterSword
        .word _Sequence07 - aBattleAnimationSequencesSwordmasterSword
        .word _Sequence08 - aBattleAnimationSequencesSwordmasterSword
        .word _Sequence09 - aBattleAnimationSequencesSwordmasterSword
        .word _Sequence10 - aBattleAnimationSequencesSwordmasterSword
        .word _Sequence11 - aBattleAnimationSequencesSwordmasterSword
        .word _Sequence12 - aBattleAnimationSequencesSwordmasterSword
        .word _Sequence13 - aBattleAnimationSequencesSwordmasterSword
        .word _Sequence14 - aBattleAnimationSequencesSwordmasterSword
        .word _Sequence15 - aBattleAnimationSequencesSwordmasterSword
        .word _Sequence16 - aBattleAnimationSequencesSwordmasterSword
        .word _Sequence17 - aBattleAnimationSequencesSwordmasterSword
        .word _Sequence18 - aBattleAnimationSequencesSwordmasterSword
        .word _Sequence19 - aBattleAnimationSequencesSwordmasterSword
        .word _Sequence20 - aBattleAnimationSequencesSwordmasterSword
        .word _Sequence21 - aBattleAnimationSequencesSwordmasterSword
        .word _Sequence22 - aBattleAnimationSequencesSwordmasterSword
        .word _Sequence23 - aBattleAnimationSequencesSwordmasterSword
        .word _Sequence24 - aBattleAnimationSequencesSwordmasterSword
        .word _Sequence25 - aBattleAnimationSequencesSwordmasterSword
        .word _Sequence26 - aBattleAnimationSequencesSwordmasterSword
        .word _Sequence27 - aBattleAnimationSequencesSwordmasterSword
        .word _Sequence28 - aBattleAnimationSequencesSwordmasterSword
        .word _Sequence29 - aBattleAnimationSequencesSwordmasterSword
        .word _Sequence30 - aBattleAnimationSequencesSwordmasterSword
        .word _Sequence31 - aBattleAnimationSequencesSwordmasterSword

      _Records
        .word _Record00 - aBattleAnimationSequencesSwordmasterSword
        .word _Record01 - aBattleAnimationSequencesSwordmasterSword
        .word _Record02 - aBattleAnimationSequencesSwordmasterSword
        .word _Record03 - aBattleAnimationSequencesSwordmasterSword
        .word _Record04 - aBattleAnimationSequencesSwordmasterSword
        .word _Record05 - aBattleAnimationSequencesSwordmasterSword
        .word _Record06 - aBattleAnimationSequencesSwordmasterSword
        .word _Record07 - aBattleAnimationSequencesSwordmasterSword
        .word _Record08 - aBattleAnimationSequencesSwordmasterSword
        .word _Record09 - aBattleAnimationSequencesSwordmasterSword
        .word _Record10 - aBattleAnimationSequencesSwordmasterSword
        .word _Record11 - aBattleAnimationSequencesSwordmasterSword
        .word _Record12 - aBattleAnimationSequencesSwordmasterSword
        .word _Record13 - aBattleAnimationSequencesSwordmasterSword
        .word _Record14 - aBattleAnimationSequencesSwordmasterSword
        .word _Record15 - aBattleAnimationSequencesSwordmasterSword
        .word _Record16 - aBattleAnimationSequencesSwordmasterSword
        .word _Record17 - aBattleAnimationSequencesSwordmasterSword
        .word _Record18 - aBattleAnimationSequencesSwordmasterSword
        .word _Record19 - aBattleAnimationSequencesSwordmasterSword
        .word _Record20 - aBattleAnimationSequencesSwordmasterSword
        .word _Record21 - aBattleAnimationSequencesSwordmasterSword
        .word _Record22 - aBattleAnimationSequencesSwordmasterSword
        .word _Record23 - aBattleAnimationSequencesSwordmasterSword
        .word _Record24 - aBattleAnimationSequencesSwordmasterSword
        .word _Record25 - aBattleAnimationSequencesSwordmasterSword
        .word _Record26 - aBattleAnimationSequencesSwordmasterSword
        .word _Record27 - aBattleAnimationSequencesSwordmasterSword
        .word _Record28 - aBattleAnimationSequencesSwordmasterSword
        .word _Record29 - aBattleAnimationSequencesSwordmasterSword
        .word _Record30 - aBattleAnimationSequencesSwordmasterSword
        .word _Record31 - aBattleAnimationSequencesSwordmasterSword
        .word _Record32 - aBattleAnimationSequencesSwordmasterSword
        .word _Record33 - aBattleAnimationSequencesSwordmasterSword
        .word _Record34 - aBattleAnimationSequencesSwordmasterSword
        .word _Record35 - aBattleAnimationSequencesSwordmasterSword
        .word _Record36 - aBattleAnimationSequencesSwordmasterSword
        .word _Record37 - aBattleAnimationSequencesSwordmasterSword
        .word _Record38 - aBattleAnimationSequencesSwordmasterSword
        .word _Record39 - aBattleAnimationSequencesSwordmasterSword
        .word _Record40 - aBattleAnimationSequencesSwordmasterSword
        .word _Record41 - aBattleAnimationSequencesSwordmasterSword
        .word _Record42 - aBattleAnimationSequencesSwordmasterSword
        .word _Record43 - aBattleAnimationSequencesSwordmasterSword
        .word _Record44 - aBattleAnimationSequencesSwordmasterSword
        .word _Record45 - aBattleAnimationSequencesSwordmasterSword
        .word _Record46 - aBattleAnimationSequencesSwordmasterSword
        .word _Record47 - aBattleAnimationSequencesSwordmasterSword
        .word _Record48 - aBattleAnimationSequencesSwordmasterSword
        .word _Record49 - aBattleAnimationSequencesSwordmasterSword
        .word _Record50 - aBattleAnimationSequencesSwordmasterSword
        .word _Record51 - aBattleAnimationSequencesSwordmasterSword

      _Sequence00
        ANIM_STEP 1, 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence01
        ANIM_STEP 1, 4
        ANIM_STEP 2, 5
        ANIM_STEP 3, 7
        ANIM_STEP 4, 16
        ANIM_STEP 3, 5
        ANIM_STEP 3, 1
        ANIM_CMD_F4 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence02
        ANIM_CMD_EB
        ANIM_CLEAR_BUSY
        ANIM_STEP 5, 6
        ANIM_STEP 6, 6
        ANIM_SOUND 18
        ANIM_STEP 7, 6
        ANIM_STEP 8, 6
        ANIM_STEP 9, 6
        ANIM_SOUND 18
        ANIM_STEP 10, 6
        ANIM_RESTART
        ANIM_HOLD

      _Sequence03
        ANIM_CLEAR_BUSY
        ANIM_STEP 23, 3
        ANIM_STEP 50, 4
        ANIM_STEP 1, 2
        ANIM_STEP 18, 3
        ANIM_HOLD

      _Sequence04
        ANIM_STEP 11, 5
        ANIM_CMD_EE
        ANIM_STEP 11, 12
        ANIM_SOUND 0
        ANIM_STEP 15, 2
        ANIM_STEP 16, 2
        ANIM_CMD_F1
        ANIM_STEP 17, 2
        ANIM_STEP 25, 16
        ANIM_CMD_F3
        ANIM_CMD_ED 3
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence05
        ANIM_STEP 26, 4
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence06
        ANIM_STEP 25, 3
        ANIM_CMD_EE
        ANIM_SOUND 1
        ANIM_STEP 20, 2
        ANIM_STEP 21, 2
        ANIM_STEP 22, 2
        ANIM_STEP 23, 6
        ANIM_CMD_F1
        ANIM_STEP 23, 6
        ANIM_CMD_F3
        ANIM_CMD_ED 2
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence07
        ANIM_STEP 11, 5
        ANIM_CMD_EE
        ANIM_STEP 11, 8
        ANIM_SOUND 0
        ANIM_STEP 12, 2
        ANIM_STEP 13, 2
        ANIM_STEP 14, 2
        ANIM_CMD_F1
        ANIM_STEP 24, 22
        ANIM_CMD_F3
        ANIM_CLEAR_BUSY
        ANIM_CMD_ED 3
        ANIM_HOLD

      _Sequence08
        ANIM_SOUND 18
        ANIM_STEP 1, 11
        ANIM_STEP 50, 8
        ANIM_SOUND 18
        ANIM_STEP 18, 7
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence09
        ANIM_CLEAR_BUSY
        ANIM_STEP 18, 5
        ANIM_CMD_EE
        ANIM_STEP 18, 15
        ANIM_HOLD

      _Sequence10
        ANIM_CLEAR_BUSY
        ANIM_SOUND 23
        ANIM_STEP 28, 31
        ANIM_STEP 29, 4
        ANIM_STEP 30, 4
        ANIM_STEP 31, 4
        ANIM_STEP 32, 3
        ANIM_STEP 33, 1
        ANIM_CMD_EE
        ANIM_STEP 33, 2
        ANIM_STEP 32, 3
        ANIM_STEP 33, 3
        ANIM_STEP 32, 3
        ANIM_SOUND 24
        ANIM_STEP 33, 3
        ANIM_HOLD

      _Sequence11
        ANIM_CMD_EC 1
        ANIM_CLEAR_BUSY
        ANIM_SOUND 23
        ANIM_STEP 39, 17
        ANIM_STEP 39, 1
        ANIM_HOLD

      _Sequence12
        ANIM_CLEAR_BUSY
        ANIM_CMD_EE
        ANIM_STEP 40, 0
        ANIM_STEP 41, 0
        ANIM_STEP 42, 0
        ANIM_STEP 43, 0
        ANIM_HOLD

      _Sequence13
        ANIM_CLEAR_BUSY
        ANIM_SOUND 1
        ANIM_STEP 45, 4
        ANIM_CMD_EC 1
        ANIM_CMD_F1
        ANIM_STEP 44, 8
        ANIM_STEP 44, 8
        ANIM_CMD_EC 0
        ANIM_STEP 46, 4
        ANIM_STEP 47, 5
        ANIM_CMD_F3
        ANIM_STEP 48, 10
        ANIM_CMD_EC 1
        ANIM_STEP 49, 13
        ANIM_CMD_EC 0
        ANIM_SOUND 24
        ANIM_CMD_ED 0
        ANIM_HOLD

      _Sequence14
        ANIM_SOUND 18
        ANIM_STEP 38, 6
        ANIM_STEP 50, 6
        ANIM_SOUND 18
        ANIM_STEP 51, 9
        ANIM_STEP 51, 1
        ANIM_CMD_F4 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence15
        ANIM_CLEAR_BUSY
        ANIM_STEP 38, 6
        ANIM_HOLD

      _Sequence16
        ANIM_SOUND 0
        ANIM_STEP 36, 1
        ANIM_STEP 37, 1
        ANIM_CMD_F1
        ANIM_STEP 34, 2
        ANIM_STEP 35, 12
        ANIM_STEP 35, 12
        ANIM_CMD_F3
        ANIM_CMD_ED 3
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence17
        ANIM_CLEAR_BUSY
        ANIM_STEP 39, 10
        ANIM_CMD_EC 0
        ANIM_HOLD

      _Sequence18
        ANIM_SOUND 8
        ANIM_CLEAR_BUSY
        ANIM_STEP 19, 1
        ANIM_HOLD

      _Sequence19
        ANIM_CMD_F1
        ANIM_CLEAR_BUSY
        ANIM_STEP 23, 1
        ANIM_HOLD

      _Sequence20
        ANIM_CMD_F3
        ANIM_STEP 23, 11
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence21
        ANIM_SOUND 18
        ANIM_STEP 51, 6
        ANIM_STEP 50, 6
        ANIM_SOUND 18
        ANIM_STEP 38, 15
        ANIM_STEP 38, 1
        ANIM_CMD_F4 1
        ANIM_CLEAR_BUSY
        ANIM_CMD_ED 0
        ANIM_HOLD

      _Sequence22
        ANIM_CLEAR_BUSY
        ANIM_STEP 11, 2
        ANIM_STEP 12, 2
        ANIM_STEP 13, 2
        ANIM_SOUND 0
        ANIM_STEP 14, 2
        ANIM_STEP 24, 2
        ANIM_STEP 20, 2
        ANIM_STEP 21, 2
        ANIM_SOUND 1
        ANIM_STEP 22, 2
        ANIM_STEP 23, 5
        ANIM_CMD_EC 0
        ANIM_HOLD

      _Sequence23
        ANIM_CLEAR_BUSY
        ANIM_STEP 44, 3
        ANIM_STEP 45, 3
        ANIM_STEP 44, 6
        ANIM_STEP 46, 4
        ANIM_STEP 47, 1
        ANIM_STEP 48, 1
        ANIM_STEP 49, 2
        ANIM_STEP 27, 3
        ANIM_CMD_EC 0
        ANIM_HOLD

      _Sequence24
        ANIM_CLEAR_BUSY
        ANIM_STEP 18, 5
        ANIM_CMD_EC 3
        ANIM_STEP 18, 13
        ANIM_CMD_EE
        ANIM_STEP 18, 22
        ANIM_HOLD

      _Sequence25
        ANIM_CMD_F3
        ANIM_CMD_EC 2
        ANIM_CMD_F1
        ANIM_SOUND 1
        ANIM_STEP 23, 32
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence26
        ANIM_CLEAR_BUSY
        ANIM_STEP 51, 3
        ANIM_STEP 50, 3
        ANIM_SOUND 18
        ANIM_HOLD

      _Sequence27
        ANIM_CLEAR_BUSY
        ANIM_STEP 23, 3
        ANIM_CMD_E9
        ANIM_HOLD

      _Sequence28
        ANIM_CLEAR_BUSY
        ANIM_STEP 18, 7
        ANIM_HOLD

      _Sequence29
        ANIM_CLEAR_BUSY
        ANIM_STEP 23, 1
        ANIM_HOLD

      _Sequence30
        ANIM_CLEAR_BUSY
        ANIM_STEP 18, 1
        ANIM_SOUND 32
        ANIM_CMD_F0 3
        ANIM_STEP 18, 1
        ANIM_CMD_F4 1
        ANIM_STEP 20, 1
        ANIM_STEP 21, 1
        ANIM_STEP 22, 1
        ANIM_STEP 23, 1
        ANIM_CMD_F4 1
        ANIM_STEP 50, 5
        ANIM_STEP 1, 8
        ANIM_HOLD

      _Sequence31
        ANIM_SOUND 18
        ANIM_STEP 50, 4
        ANIM_STEP 1, 2
        ANIM_STEP 18, 3
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Record00
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (  -7,   -2), $00, SpriteSmall, $0F1, 2, 3, false, false
        .structSpriteEntry (   9,   -2), $00, SpriteSmall, $0F2, 2, 3, false, false
        .structSpriteEntry (   1,   -2), $00, SpriteSmall, $0F1, 2, 3, false, false
        .structSpriteEntry ( -15,   -2), $00, SpriteSmall, $0F0, 2, 3, false, false
        ANIM_RECORD_END

      _Record01
        ANIM_RECORD 0
        .structSpriteEntry (  -7,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (  -7,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -13,  -20), $21, SpriteLarge, $042, 2, 2, false, false
        .structSpriteEntry ( -29,  -20), $21, SpriteLarge, $040, 2, 2, false, false
        ANIM_RECORD_END

      _Record02
        ANIM_RECORD 1
        .structSpriteEntry (  -7,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (  -7,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -12,  -28), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry ( -28,  -28), $21, SpriteLarge, $044, 2, 2, false, false
        ANIM_RECORD_END

      _Record03
        ANIM_RECORD 2
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   4,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   4,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   4,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $042, 2, 2, false, true
        .structSpriteEntry ( -20,  -39), $21, SpriteLarge, $040, 2, 2, false, true
        ANIM_RECORD_END

      _Record04
        ANIM_RECORD 3
        .structSpriteEntry ( -14,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -14,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   2,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   2,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   2,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   2,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $042, 2, 2, false, true
        .structSpriteEntry ( -20,  -39), $21, SpriteLarge, $040, 2, 2, false, true
        ANIM_RECORD_END

      _Record05
        ANIM_RECORD 4
        .structSpriteEntry (   5,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   5,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   5,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   5,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -11,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -11,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   0,  -28), $21, SpriteLarge, $04A, 2, 2, true, false
        .structSpriteEntry (   0,  -44), $21, SpriteLarge, $048, 2, 2, true, false
        ANIM_RECORD_END

      _Record06
        ANIM_RECORD 5
        .structSpriteEntry ( -11,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -11,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   5,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   5,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   5,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   5,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry (   0,  -27), $21, SpriteLarge, $04A, 2, 2, true, false
        .structSpriteEntry (   0,  -43), $21, SpriteLarge, $048, 2, 2, true, false
        ANIM_RECORD_END

      _Record07
        ANIM_RECORD 6
        .structSpriteEntry (   5,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   5,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   5,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   5,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -11,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -11,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   0,  -28), $21, SpriteLarge, $04A, 2, 2, true, false
        .structSpriteEntry (   0,  -44), $21, SpriteLarge, $048, 2, 2, true, false
        ANIM_RECORD_END

      _Record08
        ANIM_RECORD 7
        .structSpriteEntry ( -11,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -11,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   5,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   5,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   5,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   5,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry (   0,  -28), $21, SpriteLarge, $04A, 2, 2, true, false
        .structSpriteEntry (   0,  -44), $21, SpriteLarge, $048, 2, 2, true, false
        ANIM_RECORD_END

      _Record09
        ANIM_RECORD 8
        .structSpriteEntry (   5,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   5,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   5,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   5,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -11,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -11,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   0,  -27), $21, SpriteLarge, $04A, 2, 2, true, false
        .structSpriteEntry (   0,  -43), $21, SpriteLarge, $048, 2, 2, true, false
        ANIM_RECORD_END

      _Record10
        ANIM_RECORD 9
        .structSpriteEntry ( -13,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -13,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   3,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   3,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   3,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   3,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry (   0,  -28), $21, SpriteLarge, $04A, 2, 2, true, false
        .structSpriteEntry (   0,  -44), $21, SpriteLarge, $048, 2, 2, true, false
        ANIM_RECORD_END

      _Record11
        ANIM_RECORD 10
        .structSpriteEntry ( -13,  -28), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry ( -13,  -36), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   3,   -4), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (  -5,   -4), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry (  -5,  -20), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (  -5,  -36), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (  -4,  -41), $21, SpriteLarge, $046, 2, 2, true, true
        .structSpriteEntry (  12,  -41), $21, SpriteLarge, $044, 2, 2, true, true
        ANIM_RECORD_END

      _Record12
        ANIM_RECORD 11
        .structSpriteEntry (   1,  -43), $00, SpriteSmall, $0E4, 2, 2, false, false
        .structSpriteEntry (  -7,  -43), $00, SpriteSmall, $0E3, 2, 2, false, false
        .structSpriteEntry ( -15,  -43), $00, SpriteSmall, $0E2, 2, 2, false, false
        .structSpriteEntry ( -23,  -43), $00, SpriteSmall, $0E1, 2, 2, false, false
        .structSpriteEntry (   6,  -15), $00, SpriteSmall, $002, 2, 0, false, false
        .structSpriteEntry (   6,  -23), $00, SpriteSmall, $003, 2, 0, false, false
        .structSpriteEntry (   6,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (  -2,   -7), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry ( -10,   -7), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry ( -10,  -23), $21, SpriteLarge, $000, 2, 0, false, false
        ANIM_RECORD_END

      _Record13
        ANIM_RECORD 11
        .structSpriteEntry ( -27,  -37), $00, SpriteSmall, $0E0, 2, 2, false, false
        .structSpriteEntry ( -11,  -45), $00, SpriteSmall, $0D2, 2, 2, false, false
        .structSpriteEntry ( -19,  -45), $00, SpriteSmall, $0D1, 2, 2, false, false
        .structSpriteEntry ( -27,  -45), $00, SpriteSmall, $0D0, 2, 2, false, false
        .structSpriteEntry (   6,  -15), $00, SpriteSmall, $002, 2, 0, false, false
        .structSpriteEntry (   6,  -23), $00, SpriteSmall, $003, 2, 0, false, false
        .structSpriteEntry (   6,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (  -2,   -7), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry ( -10,   -7), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry ( -10,  -23), $21, SpriteLarge, $000, 2, 0, false, false
        ANIM_RECORD_END

      _Record14
        ANIM_RECORD 11
        .structSpriteEntry ( -33,  -20), $00, SpriteSmall, $0A0, 2, 2, false, false
        .structSpriteEntry ( -33,  -28), $00, SpriteSmall, $090, 2, 2, false, false
        .structSpriteEntry ( -33,  -36), $00, SpriteSmall, $080, 2, 2, false, false
        .structSpriteEntry ( -17,   -4), $00, SpriteSmall, $0C2, 2, 2, false, false
        .structSpriteEntry ( -33,  -12), $21, SpriteLarge, $0B0, 2, 2, false, false
        .structSpriteEntry (   6,  -15), $00, SpriteSmall, $002, 2, 0, false, false
        .structSpriteEntry (   6,  -23), $00, SpriteSmall, $003, 2, 0, false, false
        .structSpriteEntry (   6,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (  -2,   -7), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry ( -10,   -7), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry ( -10,  -23), $21, SpriteLarge, $000, 2, 0, false, false
        ANIM_RECORD_END

      _Record15
        ANIM_RECORD 12
        .structSpriteEntry (   1,  -43), $00, SpriteSmall, $0E4, 2, 2, false, false
        .structSpriteEntry (  -7,  -43), $00, SpriteSmall, $0E3, 2, 2, false, false
        .structSpriteEntry ( -15,  -43), $00, SpriteSmall, $0E2, 2, 2, false, false
        .structSpriteEntry ( -23,  -43), $00, SpriteSmall, $0E1, 2, 2, false, false
        .structSpriteEntry (   6,   -7), $00, SpriteSmall, $002, 2, 0, false, false
        .structSpriteEntry (  -2,   -7), $00, SpriteSmall, $003, 2, 0, false, false
        .structSpriteEntry ( -10,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   6,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   6,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry ( -10,  -23), $21, SpriteLarge, $000, 2, 0, false, false
        ANIM_RECORD_END

      _Record16
        ANIM_RECORD 12
        .structSpriteEntry ( -27,  -37), $00, SpriteSmall, $0E0, 2, 2, false, false
        .structSpriteEntry ( -11,  -45), $00, SpriteSmall, $0D2, 2, 2, false, false
        .structSpriteEntry ( -19,  -45), $00, SpriteSmall, $0D1, 2, 2, false, false
        .structSpriteEntry ( -27,  -45), $00, SpriteSmall, $0D0, 2, 2, false, false
        .structSpriteEntry (   6,   -7), $00, SpriteSmall, $002, 2, 0, false, false
        .structSpriteEntry (  -2,   -7), $00, SpriteSmall, $003, 2, 0, false, false
        .structSpriteEntry ( -10,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   6,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   6,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry ( -10,  -23), $21, SpriteLarge, $000, 2, 0, false, false
        ANIM_RECORD_END

      _Record17
        ANIM_RECORD 12
        .structSpriteEntry ( -33,  -20), $00, SpriteSmall, $0A0, 2, 2, false, false
        .structSpriteEntry ( -33,  -28), $00, SpriteSmall, $090, 2, 2, false, false
        .structSpriteEntry ( -33,  -36), $00, SpriteSmall, $080, 2, 2, false, false
        .structSpriteEntry ( -17,   -4), $00, SpriteSmall, $0C2, 2, 2, false, false
        .structSpriteEntry ( -33,  -12), $21, SpriteLarge, $0B0, 2, 2, false, false
        .structSpriteEntry (   6,   -7), $00, SpriteSmall, $002, 2, 0, false, false
        .structSpriteEntry (  -2,   -7), $00, SpriteSmall, $003, 2, 0, false, false
        .structSpriteEntry ( -10,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   6,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   6,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry ( -10,  -23), $21, SpriteLarge, $000, 2, 0, false, false
        ANIM_RECORD_END

      _Record18
        ANIM_RECORD 13
        .structSpriteEntry (  -4,  -29), $21, SpriteLarge, $04E, 2, 2, true, false
        .structSpriteEntry (  -4,  -45), $21, SpriteLarge, $04C, 2, 2, true, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   4,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   4,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   4,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record19
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (  -8,  -16), $00, SpriteSmall, $0A1, 2, 2, false, false
        .structSpriteEntry ( -16,  -16), $00, SpriteSmall, $091, 2, 2, false, false
        .structSpriteEntry ( -24,  -16), $00, SpriteSmall, $081, 2, 2, false, false
        .structSpriteEntry (   0,  -16), $00, SpriteSmall, $0A1, 2, 2, true, false
        .structSpriteEntry (   8,  -16), $00, SpriteSmall, $091, 2, 2, true, false
        .structSpriteEntry (  16,  -16), $00, SpriteSmall, $081, 2, 2, true, false
        ANIM_RECORD_END

      _Record20
        ANIM_RECORD 14
        .structSpriteEntry (   6,   -3), $00, SpriteSmall, $0E4, 2, 2, false, true
        .structSpriteEntry (  -2,   -3), $00, SpriteSmall, $0E3, 2, 2, false, true
        .structSpriteEntry ( -10,   -3), $00, SpriteSmall, $0E2, 2, 2, false, true
        .structSpriteEntry ( -18,   -3), $00, SpriteSmall, $0E1, 2, 2, false, true
        .structSpriteEntry (   6,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   6,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   6,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   6,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -10,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -10,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record21
        ANIM_RECORD 14
        .structSpriteEntry ( -27,  -14), $00, SpriteSmall, $0E0, 2, 2, false, true
        .structSpriteEntry ( -11,   -6), $00, SpriteSmall, $0D2, 2, 2, false, true
        .structSpriteEntry ( -19,   -6), $00, SpriteSmall, $0D1, 2, 2, false, true
        .structSpriteEntry ( -27,   -6), $00, SpriteSmall, $0D0, 2, 2, false, true
        .structSpriteEntry (   6,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   6,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   6,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   6,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -10,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -10,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record22
        ANIM_RECORD 14
        .structSpriteEntry ( -28,  -27), $00, SpriteSmall, $0A0, 2, 2, false, true
        .structSpriteEntry ( -28,  -19), $00, SpriteSmall, $090, 2, 2, false, true
        .structSpriteEntry ( -28,  -11), $00, SpriteSmall, $080, 2, 2, false, true
        .structSpriteEntry ( -12,  -43), $00, SpriteSmall, $0C2, 2, 2, false, true
        .structSpriteEntry ( -28,  -43), $21, SpriteLarge, $0B0, 2, 2, false, true
        .structSpriteEntry (   6,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   6,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   6,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   6,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -10,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -10,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record23
        ANIM_RECORD 14
        .structSpriteEntry (   1,  -29), $21, SpriteLarge, $04E, 2, 2, true, false
        .structSpriteEntry (   1,  -45), $21, SpriteLarge, $04C, 2, 2, true, false
        .structSpriteEntry (   6,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   6,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   6,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   6,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -10,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -10,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record24
        ANIM_RECORD 11
        .structSpriteEntry (  -9,  -11), $21, SpriteLarge, $042, 2, 2, false, false
        .structSpriteEntry ( -25,  -11), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry (   6,  -15), $00, SpriteSmall, $002, 2, 0, false, false
        .structSpriteEntry (   6,  -23), $00, SpriteSmall, $003, 2, 0, false, false
        .structSpriteEntry (   6,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (  -2,   -7), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry ( -10,   -7), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry ( -10,  -23), $21, SpriteLarge, $000, 2, 0, false, false
        ANIM_RECORD_END

      _Record25
        ANIM_RECORD 12
        .structSpriteEntry (  -9,  -11), $21, SpriteLarge, $042, 2, 2, false, false
        .structSpriteEntry ( -25,  -11), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry (   6,   -7), $00, SpriteSmall, $002, 2, 0, false, false
        .structSpriteEntry (  -2,   -7), $00, SpriteSmall, $003, 2, 0, false, false
        .structSpriteEntry ( -10,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   6,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   6,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry ( -10,  -23), $21, SpriteLarge, $000, 2, 0, false, false
        ANIM_RECORD_END

      _Record26
        ANIM_RECORD 12
        .structSpriteEntry (  -7,  -17), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry ( -23,  -17), $21, SpriteLarge, $044, 2, 2, false, false
        .structSpriteEntry (   6,   -7), $00, SpriteSmall, $002, 2, 0, false, false
        .structSpriteEntry (  -2,   -7), $00, SpriteSmall, $003, 2, 0, false, false
        .structSpriteEntry ( -10,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   6,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   6,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry ( -10,  -23), $21, SpriteLarge, $000, 2, 0, false, false
        ANIM_RECORD_END

      _Record27
        ANIM_RECORD 11
        .structSpriteEntry (  -7,  -17), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry ( -23,  -17), $21, SpriteLarge, $044, 2, 2, false, false
        .structSpriteEntry (   6,  -15), $00, SpriteSmall, $002, 2, 0, false, false
        .structSpriteEntry (   6,  -23), $00, SpriteSmall, $003, 2, 0, false, false
        .structSpriteEntry (   6,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (  -2,   -7), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry ( -10,   -7), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry ( -10,  -23), $21, SpriteLarge, $000, 2, 0, false, false
        ANIM_RECORD_END

      _Record28
        ANIM_RECORD 15
        .structSpriteEntry (   5,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   5,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   5,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   5,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -11,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -11,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   1,  -29), $21, SpriteLarge, $04A, 2, 2, true, false
        .structSpriteEntry (   1,  -45), $21, SpriteLarge, $048, 2, 2, true, false
        ANIM_RECORD_END

      _Record29
        ANIM_RECORD 16
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   4,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   4,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   4,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -18,  -27), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry ( -18,  -43), $21, SpriteLarge, $048, 2, 2, false, false
        ANIM_RECORD_END

      _Record30
        ANIM_RECORD 17
        .structSpriteEntry (   0,  -22), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -16,  -22), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -10,  -16), $21, SpriteLarge, $042, 2, 2, false, false
        .structSpriteEntry ( -26,  -16), $21, SpriteLarge, $040, 2, 2, false, false
        ANIM_RECORD_END

      _Record31
        ANIM_RECORD 18
        .structSpriteEntry (   5,  -13), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (  -3,  -13), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (  -3,  -29), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -19,  -29), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   4,  -22), $21, SpriteLarge, $04A, 2, 2, true, true
        .structSpriteEntry (   4,   -6), $21, SpriteLarge, $048, 2, 2, true, true
        ANIM_RECORD_END

      _Record32
        ANIM_RECORD 19
        .structSpriteEntry (  -1,   -2), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (  -9,   -2), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   7,  -26), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   7,  -34), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry (  -9,  -18), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (  -9,  -34), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (  -9,  -38), $21, SpriteLarge, $046, 2, 2, true, true
        .structSpriteEntry (   7,  -38), $21, SpriteLarge, $044, 2, 2, true, true
        ANIM_RECORD_END

      _Record33
        ANIM_RECORD 20
        .structSpriteEntry (   7,  -26), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (  -1,   -2), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (  -9,   -2), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (  -9,  -18), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (  -9,  -34), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   7,  -34), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry (  -9,  -38), $21, SpriteLarge, $046, 2, 2, true, true
        .structSpriteEntry (   7,  -38), $21, SpriteLarge, $044, 2, 2, true, true
        ANIM_RECORD_END

      _Record34
        ANIM_RECORD 11
        .structSpriteEntry ( -26,  -13), $21, SpriteLarge, $0C3, 2, 2, false, false
        .structSpriteEntry ( -26,  -29), $21, SpriteLarge, $0A3, 2, 2, false, false
        .structSpriteEntry ( -26,  -45), $21, SpriteLarge, $083, 2, 2, false, false
        .structSpriteEntry (   6,  -15), $00, SpriteSmall, $002, 2, 0, false, false
        .structSpriteEntry (   6,  -23), $00, SpriteSmall, $003, 2, 0, false, false
        .structSpriteEntry (   6,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (  -2,   -7), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry ( -10,   -7), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry ( -10,  -23), $21, SpriteLarge, $000, 2, 0, false, false
        ANIM_RECORD_END

      _Record35
        ANIM_RECORD 11
        .structSpriteEntry (  -9,  -12), $21, SpriteLarge, $042, 2, 2, false, false
        .structSpriteEntry ( -25,  -12), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry (   6,  -15), $00, SpriteSmall, $002, 2, 0, false, false
        .structSpriteEntry (   6,  -23), $00, SpriteSmall, $003, 2, 0, false, false
        .structSpriteEntry (   6,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (  -2,   -7), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry ( -10,   -7), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry ( -10,  -23), $21, SpriteLarge, $000, 2, 0, false, false
        ANIM_RECORD_END

      _Record36
        ANIM_RECORD 11
        .structSpriteEntry ( -26,  -29), $21, SpriteLarge, $0C3, 2, 2, false, false
        .structSpriteEntry ( -26,  -45), $21, SpriteLarge, $0A3, 2, 2, false, false
        .structSpriteEntry ( -26,  -61), $21, SpriteLarge, $083, 2, 2, false, false
        .structSpriteEntry (   6,  -15), $00, SpriteSmall, $002, 2, 0, false, false
        .structSpriteEntry (   6,  -23), $00, SpriteSmall, $003, 2, 0, false, false
        .structSpriteEntry (   6,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (  -2,   -7), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry ( -10,   -7), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry ( -10,  -23), $21, SpriteLarge, $000, 2, 0, false, false
        ANIM_RECORD_END

      _Record37
        ANIM_RECORD 11
        .structSpriteEntry ( -26,  -21), $21, SpriteLarge, $0C3, 2, 2, false, false
        .structSpriteEntry ( -26,  -37), $21, SpriteLarge, $0A3, 2, 2, false, false
        .structSpriteEntry ( -26,  -53), $21, SpriteLarge, $083, 2, 2, false, false
        .structSpriteEntry (   6,  -15), $00, SpriteSmall, $002, 2, 0, false, false
        .structSpriteEntry (   6,  -23), $00, SpriteSmall, $003, 2, 0, false, false
        .structSpriteEntry (   6,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (  -2,   -7), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry ( -10,   -7), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry ( -10,  -23), $21, SpriteLarge, $000, 2, 0, false, false
        ANIM_RECORD_END

      _Record38
        ANIM_RECORD 21
        .structSpriteEntry (   5,   -6), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   5,  -14), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   5,  -22), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   5,  -30), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -11,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -11,  -30), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -11,  -26), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry ( -27,  -26), $21, SpriteLarge, $044, 2, 2, false, false
        ANIM_RECORD_END

      _Record39
        ANIM_RECORD 22
        .structSpriteEntry (  -2,  -23), $00, SpriteSmall, $002, 2, 0, false, false
        .structSpriteEntry ( -10,  -23), $00, SpriteSmall, $003, 2, 0, false, false
        .structSpriteEntry (   6,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   6,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   6,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry ( -10,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (  -9,  -26), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry ( -25,  -26), $21, SpriteLarge, $044, 2, 2, false, false
        ANIM_RECORD_END

      _Record40
        ANIM_RECORD 22
        .structSpriteEntry (  -2,  -23), $00, SpriteSmall, $002, 2, 0, false, false
        .structSpriteEntry ( -10,  -23), $00, SpriteSmall, $003, 2, 0, false, false
        .structSpriteEntry (   6,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   6,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   6,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry ( -10,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (  -8,  -24), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry (  -8,  -40), $21, SpriteLarge, $048, 2, 2, false, false
        ANIM_RECORD_END

      _Record41
        ANIM_RECORD 22
        .structSpriteEntry (  -2,  -23), $00, SpriteSmall, $002, 2, 0, false, false
        .structSpriteEntry ( -10,  -23), $00, SpriteSmall, $003, 2, 0, false, false
        .structSpriteEntry (   6,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   6,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   6,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry ( -10,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (  -4,  -24), $21, SpriteLarge, $04A, 2, 2, true, false
        .structSpriteEntry (  -4,  -40), $21, SpriteLarge, $048, 2, 2, true, false
        ANIM_RECORD_END

      _Record42
        ANIM_RECORD 22
        .structSpriteEntry (  -2,  -23), $00, SpriteSmall, $002, 2, 0, false, false
        .structSpriteEntry ( -10,  -23), $00, SpriteSmall, $003, 2, 0, false, false
        .structSpriteEntry (   6,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   6,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   6,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry ( -10,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -10,  -27), $21, SpriteLarge, $046, 2, 2, true, false
        .structSpriteEntry (   6,  -27), $21, SpriteLarge, $044, 2, 2, true, false
        ANIM_RECORD_END

      _Record43
        ANIM_RECORD 22
        .structSpriteEntry (  -2,  -23), $00, SpriteSmall, $002, 2, 0, false, false
        .structSpriteEntry ( -10,  -23), $00, SpriteSmall, $003, 2, 0, false, false
        .structSpriteEntry (   6,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   6,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   6,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry ( -10,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (  -7,  -22), $21, SpriteLarge, $042, 2, 2, true, false
        .structSpriteEntry (   9,  -22), $21, SpriteLarge, $040, 2, 2, true, false
        ANIM_RECORD_END

      _Record44
        ANIM_RECORD 23
        .structSpriteEntry ( -14,  -48), $21, SpriteLarge, $042, 2, 2, false, true
        .structSpriteEntry ( -30,  -48), $21, SpriteLarge, $040, 2, 2, false, true
        .structSpriteEntry (   1,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (  -7,   -7), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (  -7,  -23), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (  -7,  -39), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record45
        ANIM_RECORD 23
        .structSpriteEntry ( -26,  -44), $21, SpriteLarge, $0C3, 2, 2, false, true
        .structSpriteEntry ( -26,  -28), $21, SpriteLarge, $0A3, 2, 2, false, true
        .structSpriteEntry ( -26,  -12), $21, SpriteLarge, $083, 2, 2, false, true
        .structSpriteEntry (   1,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (  -7,   -7), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (  -7,  -23), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (  -7,  -39), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record46
        ANIM_RECORD 24
        .structSpriteEntry (   5,  -38), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (  -3,  -38), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry ( -11,  -38), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   5,   -6), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry (   5,  -14), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   5,  -22), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (   5,  -30), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -11,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -11,  -30), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -17,  -39), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry ( -17,  -55), $21, SpriteLarge, $048, 2, 2, false, false
        ANIM_RECORD_END

      _Record47
        ANIM_RECORD 25
        .structSpriteEntry (  10,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   2,   -7), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   2,  -15), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   2,  -23), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry (   2,  -31), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry ( -14,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -14,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -16,  -12), $21, SpriteLarge, $04A, 2, 2, false, true
        .structSpriteEntry ( -16,    4), $21, SpriteLarge, $048, 2, 2, false, true
        ANIM_RECORD_END

      _Record48
        ANIM_RECORD 26
        .structSpriteEntry (  -4,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (  -4,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry ( -17,  -21), $21, SpriteLarge, $042, 2, 2, false, false
        .structSpriteEntry ( -33,  -21), $21, SpriteLarge, $040, 2, 2, false, false
        ANIM_RECORD_END

      _Record49
        ANIM_RECORD 27
        .structSpriteEntry (   5,  -30), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   5,  -38), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -11,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -11,  -30), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -11,  -46), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -16,  -41), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry ( -32,  -41), $21, SpriteLarge, $044, 2, 2, false, false
        ANIM_RECORD_END

      _Record50
        ANIM_RECORD 28
        .structSpriteEntry (  -8,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (  -8,  -30), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -11,  -23), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry ( -11,  -39), $21, SpriteLarge, $048, 2, 2, false, false
        ANIM_RECORD_END

      _Record51
        ANIM_RECORD 29
        .structSpriteEntry (   4,   -5), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   4,  -13), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   4,  -21), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   4,  -29), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -12,  -13), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -12,  -29), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (  -5,  -27), $21, SpriteLarge, $04E, 2, 2, true, false
        .structSpriteEntry (  -5,  -43), $21, SpriteLarge, $04C, 2, 2, true, false
        ANIM_RECORD_END

      aBattleAnimationFramesMyrmidonSword ; 9A/F201

        ; Frame table of entry 1: slices of the class sheet per frame.

        .word _Frame00 - aBattleAnimationFramesMyrmidonSword
        .word _Frame01 - aBattleAnimationFramesMyrmidonSword
        .word _Frame02 - aBattleAnimationFramesMyrmidonSword
        .word _Frame03 - aBattleAnimationFramesMyrmidonSword
        .word _Frame04 - aBattleAnimationFramesMyrmidonSword
        .word _Frame05 - aBattleAnimationFramesMyrmidonSword
        .word _Frame06 - aBattleAnimationFramesMyrmidonSword
        .word _Frame07 - aBattleAnimationFramesMyrmidonSword
        .word _Frame08 - aBattleAnimationFramesMyrmidonSword
        .word _Frame09 - aBattleAnimationFramesMyrmidonSword
        .word _Frame10 - aBattleAnimationFramesMyrmidonSword
        .word _Frame11 - aBattleAnimationFramesMyrmidonSword
        .word _Frame12 - aBattleAnimationFramesMyrmidonSword
        .word _Frame13 - aBattleAnimationFramesMyrmidonSword
        .word _Frame14 - aBattleAnimationFramesMyrmidonSword
        .word _Frame15 - aBattleAnimationFramesMyrmidonSword
        .word _Frame16 - aBattleAnimationFramesMyrmidonSword
        .word _Frame17 - aBattleAnimationFramesMyrmidonSword

      _Frame00
        ANIM_TILES
        ANIM_TILE_ROW $0000, $0100
        ANIM_TILE_ROW $0100, $0080
        ANIM_TILES_END

      _Frame01
        ANIM_TILES
        ANIM_TILE_ROW $0180, $0100
        ANIM_TILE_ROW $0280, $0080
        ANIM_TILES_END

      _Frame02
        ANIM_TILES
        ANIM_TILE_ROW $0300, $0100
        ANIM_TILE_ROW $0400, $0080
        ANIM_TILES_END

      _Frame03
        ANIM_TILES
        ANIM_TILE_ROW $0480, $0100
        ANIM_TILE_ROW $0580, $0080
        ANIM_TILES_END

      _Frame04
        ANIM_TILES
        ANIM_TILE_ROW $0600, $0140
        ANIM_TILE_ROW $0740, $0080
        ANIM_TILES_END

      _Frame05
        ANIM_TILES
        ANIM_TILE_ROW $07C0, $0100
        ANIM_TILE_ROW $08C0, $0080
        ANIM_TILES_END

      _Frame06
        ANIM_TILES
        ANIM_TILE_ROW $0940, $00E0
        ANIM_TILE_ROW $0A20, $0040
        ANIM_TILES_END

      _Frame07
        ANIM_TILES
        ANIM_TILE_ROW $0A60, $0100
        ANIM_TILE_ROW $0B60, $0080
        ANIM_TILES_END

      _Frame08
        ANIM_TILES
        ANIM_TILE_ROW $0BE0, $0120
        ANIM_TILE_ROW $0D00, $0080
        ANIM_TILES_END

      _Frame09
        ANIM_TILES
        ANIM_TILE_ROW $0D80, $0100
        ANIM_TILE_ROW $0E80, $0080
        ANIM_TILES_END

      _Frame10
        ANIM_TILES
        ANIM_TILE_ROW $0F00, $0100
        ANIM_TILE_ROW $1000, $0080
        ANIM_TILES_END

      _Frame11
        ANIM_TILES
        ANIM_TILE_ROW $1080, $0120
        ANIM_TILE_ROW $11A0, $0080
        ANIM_TILES_END

      _Frame12
        ANIM_TILES
        ANIM_TILE_ROW $1220, $0100
        ANIM_TILE_ROW $1320, $0100
        ANIM_TILES_END

      _Frame13
        ANIM_TILES
        ANIM_TILE_ROW $1420, $0100
        ANIM_TILE_ROW $1520, $0100
        ANIM_TILES_END

      _Frame14
        ANIM_TILES
        ANIM_TILE_ROW $1620, $0140
        ANIM_TILE_ROW $1760, $0080
        ANIM_TILES_END

      _Frame15
        ANIM_TILES
        ANIM_TILE_ROW $17E0, $0100
        ANIM_TILE_ROW $18E0, $0080
        ANIM_TILES_END

      _Frame16
        ANIM_TILES
        ANIM_TILE_ROW $1960, $0100
        ANIM_TILE_ROW $1A60, $0080
        ANIM_TILES_END

      _Frame17
        ANIM_TILES
        ANIM_TILE_ROW $1AE0, $0100
        ANIM_TILE_ROW $1BE0, $0080
        ANIM_TILES_END

      aBattleAnimationSequencesMyrmidonSword ; 9A/F2C7

        ; Sequence data of entry 1 of aBattleAnimationFrameTables, used by: Myrmidon (Sword).
        ; Frames: aBattleAnimationFramesMyrmidonSword.

        .word _Index - aBattleAnimationSequencesMyrmidonSword, _Records - aBattleAnimationSequencesMyrmidonSword

      _Index
        .word _Sequence00 - aBattleAnimationSequencesMyrmidonSword
        .word _Sequence01 - aBattleAnimationSequencesMyrmidonSword
        .word _Sequence02 - aBattleAnimationSequencesMyrmidonSword
        .word _Sequence03 - aBattleAnimationSequencesMyrmidonSword
        .word _Sequence04 - aBattleAnimationSequencesMyrmidonSword
        .word _Sequence05 - aBattleAnimationSequencesMyrmidonSword
        .word _Sequence06 - aBattleAnimationSequencesMyrmidonSword
        .word _Sequence07 - aBattleAnimationSequencesMyrmidonSword
        .word _Sequence08 - aBattleAnimationSequencesMyrmidonSword
        .word _Sequence09 - aBattleAnimationSequencesMyrmidonSword
        .word _Sequence10 - aBattleAnimationSequencesMyrmidonSword
        .word _Sequence11 - aBattleAnimationSequencesMyrmidonSword
        .word _Sequence12 - aBattleAnimationSequencesMyrmidonSword
        .word _Sequence13 - aBattleAnimationSequencesMyrmidonSword
        .word _Sequence14 - aBattleAnimationSequencesMyrmidonSword
        .word _Sequence15 - aBattleAnimationSequencesMyrmidonSword
        .word _Sequence16 - aBattleAnimationSequencesMyrmidonSword
        .word _Sequence17 - aBattleAnimationSequencesMyrmidonSword
        .word _Sequence18 - aBattleAnimationSequencesMyrmidonSword
        .word _Sequence19 - aBattleAnimationSequencesMyrmidonSword
        .word _Sequence20 - aBattleAnimationSequencesMyrmidonSword
        .word _Sequence21 - aBattleAnimationSequencesMyrmidonSword
        .word _Sequence22 - aBattleAnimationSequencesMyrmidonSword
        .word _Sequence23 - aBattleAnimationSequencesMyrmidonSword
        .word _Sequence24 - aBattleAnimationSequencesMyrmidonSword
        .word _Sequence25 - aBattleAnimationSequencesMyrmidonSword
        .word _Sequence26 - aBattleAnimationSequencesMyrmidonSword
        .word _Sequence27 - aBattleAnimationSequencesMyrmidonSword
        .word _Sequence28 - aBattleAnimationSequencesMyrmidonSword
        .word _Sequence29 - aBattleAnimationSequencesMyrmidonSword
        .word _Sequence30 - aBattleAnimationSequencesMyrmidonSword

      _Records
        .word _Record00 - aBattleAnimationSequencesMyrmidonSword
        .word _Record01 - aBattleAnimationSequencesMyrmidonSword
        .word _Record02 - aBattleAnimationSequencesMyrmidonSword
        .word _Record03 - aBattleAnimationSequencesMyrmidonSword
        .word _Record04 - aBattleAnimationSequencesMyrmidonSword
        .word _Record05 - aBattleAnimationSequencesMyrmidonSword
        .word _Record06 - aBattleAnimationSequencesMyrmidonSword
        .word _Record07 - aBattleAnimationSequencesMyrmidonSword
        .word _Record08 - aBattleAnimationSequencesMyrmidonSword
        .word _Record09 - aBattleAnimationSequencesMyrmidonSword
        .word _Record10 - aBattleAnimationSequencesMyrmidonSword
        .word _Record11 - aBattleAnimationSequencesMyrmidonSword
        .word _Record12 - aBattleAnimationSequencesMyrmidonSword
        .word _Record13 - aBattleAnimationSequencesMyrmidonSword
        .word _Record14 - aBattleAnimationSequencesMyrmidonSword
        .word _Record15 - aBattleAnimationSequencesMyrmidonSword
        .word _Record16 - aBattleAnimationSequencesMyrmidonSword
        .word _Record17 - aBattleAnimationSequencesMyrmidonSword
        .word _Record18 - aBattleAnimationSequencesMyrmidonSword
        .word _Record19 - aBattleAnimationSequencesMyrmidonSword
        .word _Record20 - aBattleAnimationSequencesMyrmidonSword
        .word _Record21 - aBattleAnimationSequencesMyrmidonSword
        .word _Record22 - aBattleAnimationSequencesMyrmidonSword
        .word _Record23 - aBattleAnimationSequencesMyrmidonSword
        .word _Record24 - aBattleAnimationSequencesMyrmidonSword
        .word _Record25 - aBattleAnimationSequencesMyrmidonSword
        .word _Record26 - aBattleAnimationSequencesMyrmidonSword
        .word _Record27 - aBattleAnimationSequencesMyrmidonSword
        .word _Record28 - aBattleAnimationSequencesMyrmidonSword
        .word _Record29 - aBattleAnimationSequencesMyrmidonSword
        .word _Record30 - aBattleAnimationSequencesMyrmidonSword
        .word _Record31 - aBattleAnimationSequencesMyrmidonSword
        .word _Record32 - aBattleAnimationSequencesMyrmidonSword

      _Sequence00
        ANIM_STEP 1, 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence01
        ANIM_CLEAR_BUSY
        ANIM_STEP 2, 4
        ANIM_STEP 3, 4
        ANIM_SOUND 18
        ANIM_STEP 4, 4
        ANIM_STEP 5, 3
        ANIM_HOLD

      _Sequence02
        ANIM_STEP 11, 5
        ANIM_STEP 12, 6
        ANIM_CMD_EE
        ANIM_STEP 12, 11
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence03
        ANIM_STEP 2, 6
        ANIM_STEP 3, 6
        ANIM_STEP 4, 6
        ANIM_RESTART
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence04
        ANIM_STEP 13, 5
        ANIM_STEP 15, 15
        ANIM_CMD_EE
        ANIM_STEP 15, 11
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence05
        ANIM_STEP 7, 1
        ANIM_STEP 8, 2
        ANIM_STEP 9, 3
        ANIM_CMD_F1
        ANIM_SOUND 0
        ANIM_STEP 10, 16
        ANIM_CMD_F3
        ANIM_CLEAR_BUSY
        ANIM_CMD_ED 3
        ANIM_HOLD

      _Sequence06
        ANIM_STEP 10, 2
        ANIM_STEP 17, 3
        ANIM_STEP 18, 3
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence07
        ANIM_SOUND 18
        ANIM_STEP 1, 6
        ANIM_STEP 14, 3
        ANIM_STEP 13, 3
        ANIM_STEP 13, 1
        ANIM_CMD_F4 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence08
        ANIM_STEP 15, 2
        ANIM_STEP 26, 1
        ANIM_STEP 27, 2
        ANIM_STEP 28, 2
        ANIM_SOUND 0
        ANIM_CMD_F1
        ANIM_STEP 10, 16
        ANIM_CMD_F3
        ANIM_CLEAR_BUSY
        ANIM_CMD_ED 3
        ANIM_HOLD

      _Sequence09
        ANIM_STEP 10, 8
        ANIM_CMD_EE
        ANIM_STEP 22, 2
        ANIM_STEP 23, 2
        ANIM_STEP 24, 3
        ANIM_STEP 25, 3
        ANIM_STEP 19, 1
        ANIM_STEP 20, 2
        ANIM_STEP 21, 3
        ANIM_CMD_F1
        ANIM_SOUND 1
        ANIM_STEP 16, 21
        ANIM_CMD_F3
        ANIM_CMD_ED 2
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence10
        ANIM_STEP 1, 8
        ANIM_SOUND 18
        ANIM_STEP 11, 7
        ANIM_STEP 29, 1
        ANIM_SOUND 32
        ANIM_CMD_F0 3
        ANIM_STEP 29, 1
        ANIM_CMD_F4 1
        ANIM_STEP 29, 1
        ANIM_CMD_F4 1
        ANIM_STEP 11, 4
        ANIM_STEP 1, 5
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence11
        ANIM_SOUND 23
        ANIM_STEP 5, 16
        ANIM_STEP 6, 6
        ANIM_CMD_EE
        ANIM_STEP 6, 6
        ANIM_STEP 15, 3
        ANIM_SOUND 24
        ANIM_STEP 7, 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence12
        ANIM_STEP 15, 3
        ANIM_CMD_EE
        ANIM_STEP 15, 10
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence13
        ANIM_CMD_EE
        ANIM_STEP 11, 6
        ANIM_STEP 10, 9
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence14
        ANIM_SOUND 8
        ANIM_CLEAR_BUSY
        ANIM_STEP 17, 1
        ANIM_HOLD

      _Sequence15
        ANIM_CMD_F1
        ANIM_CLEAR_BUSY
        ANIM_STEP 18, 1
        ANIM_HOLD

      _Sequence16
        ANIM_CMD_F3
        ANIM_STEP 18, 16
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence17
        ANIM_STEP 2, 4
        ANIM_CMD_EE
        ANIM_STEP 3, 5
        ANIM_SOUND 17
        ANIM_STEP 4, 5
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence18
        ANIM_SOUND 23
        ANIM_STEP 5, 6
        ANIM_STEP 6, 15
        ANIM_CMD_EE
        ANIM_STEP 6, 11
        ANIM_SOUND 24
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence19
        ANIM_CLEAR_BUSY
        ANIM_SOUND 23
        ANIM_STEP 14, 16
        ANIM_SOUND 24
        ANIM_STEP 13, 0
        ANIM_CMD_F4 1
        ANIM_CMD_ED 1
        ANIM_HOLD

      _Sequence20
        ANIM_STEP 13, 4
        ANIM_STEP 14, 4
        ANIM_STEP 11, 2
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence21
        ANIM_CMD_EE
        ANIM_SOUND 18
        ANIM_STEP 13, 4
        ANIM_STEP 14, 4
        ANIM_STEP 1, 3
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence22
        ANIM_CLEAR_BUSY
        ANIM_STEP 14, 7
        ANIM_HOLD

      _Sequence23
        ANIM_SOUND 18
        ANIM_STEP 13, 4
        ANIM_STEP 14, 4
        ANIM_STEP 1, 3
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence24
        ANIM_STEP 18, 2
        ANIM_STEP 13, 4
        ANIM_STEP 14, 4
        ANIM_STEP 1, 3
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence25
        ANIM_STEP 10, 2
        ANIM_STEP 1, 5
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence26
        ANIM_CLEAR_BUSY
        ANIM_CMD_EB
        ANIM_STEP 2, 6
        ANIM_STEP 3, 6
        ANIM_SOUND 18
        ANIM_STEP 4, 6
        ANIM_STEP 30, 6
        ANIM_STEP 31, 6
        ANIM_SOUND 18
        ANIM_STEP 32, 6
        ANIM_RESTART
        ANIM_HOLD

      _Sequence27
        ANIM_STEP 2, 6
        ANIM_STEP 3, 6
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence28
        ANIM_STEP 5, 3
        ANIM_CMD_EE
        ANIM_STEP 5, 10
        ANIM_SOUND 18
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence29
        ANIM_STEP 29, 5
        ANIM_STEP 11, 5
        ANIM_STEP 1, 3
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence30
        ANIM_SOUND 18
        ANIM_STEP 14, 5
        ANIM_STEP 13, 5
        ANIM_STEP 11, 5
        ANIM_STEP 11, 1
        ANIM_CMD_F4 1
        ANIM_CMD_ED 0
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Record00
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (   0,   -3), $00, SpriteSmall, $0F1, 2, 3, false, false
        .structSpriteEntry (   8,   -3), $00, SpriteSmall, $0F2, 2, 3, false, false
        .structSpriteEntry (  -8,   -3), $00, SpriteSmall, $0F1, 2, 3, false, false
        .structSpriteEntry ( -16,   -3), $00, SpriteSmall, $0F0, 2, 3, false, false
        ANIM_RECORD_END

      _Record01
        ANIM_RECORD 0
        .structSpriteEntry (   5,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   5,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   5,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   5,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -11,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -11,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -15,  -21), $21, SpriteLarge, $042, 2, 2, false, false
        .structSpriteEntry ( -31,  -21), $21, SpriteLarge, $040, 2, 2, false, false
        ANIM_RECORD_END

      _Record02
        ANIM_RECORD 1
        .structSpriteEntry (   5,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   5,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   5,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   5,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -11,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -11,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (  -9,  -29), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry ( -25,  -29), $21, SpriteLarge, $044, 2, 2, false, false
        ANIM_RECORD_END

      _Record03
        ANIM_RECORD 2
        .structSpriteEntry (   5,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   5,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   5,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   5,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -11,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -11,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (  -9,  -29), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry ( -25,  -29), $21, SpriteLarge, $044, 2, 2, false, false
        ANIM_RECORD_END

      _Record04
        ANIM_RECORD 3
        .structSpriteEntry ( -11,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -11,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   5,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   5,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   5,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   5,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry (  -9,  -30), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry ( -25,  -30), $21, SpriteLarge, $044, 2, 2, false, false
        ANIM_RECORD_END

      _Record05
        ANIM_RECORD 4
        .structSpriteEntry (  -3,   -3), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   5,   -3), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   5,  -11), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   5,  -19), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry (   5,  -27), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   5,  -35), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry ( -11,  -19), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -11,  -35), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -11,  -38), $21, SpriteLarge, $046, 2, 2, true, true
        .structSpriteEntry (   5,  -38), $21, SpriteLarge, $044, 2, 2, true, true
        ANIM_RECORD_END

      _Record06
        ANIM_RECORD 5
        .structSpriteEntry (   2,  -10), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   2,  -18), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   2,  -26), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   2,  -34), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -14,  -18), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -14,  -34), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -10,  -37), $21, SpriteLarge, $046, 2, 2, true, true
        .structSpriteEntry (   6,  -37), $21, SpriteLarge, $044, 2, 2, true, true
        ANIM_RECORD_END

      _Record07
        ANIM_RECORD 6
        .structSpriteEntry (  -1,  -47), $00, SpriteSmall, $0E4, 2, 2, false, false
        .structSpriteEntry (  -9,  -47), $00, SpriteSmall, $0E3, 2, 2, false, false
        .structSpriteEntry ( -17,  -47), $00, SpriteSmall, $0E2, 2, 2, false, false
        .structSpriteEntry ( -25,  -47), $00, SpriteSmall, $0E1, 2, 2, false, false
        .structSpriteEntry (   4,  -14), $00, SpriteSmall, $002, 2, 0, false, false
        .structSpriteEntry (   4,  -22), $00, SpriteSmall, $003, 2, 0, false, false
        .structSpriteEntry (   4,   -6), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (  -4,   -6), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry ( -12,   -6), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry ( -12,  -22), $21, SpriteLarge, $000, 2, 0, false, false
        ANIM_RECORD_END

      _Record08
        ANIM_RECORD 6
        .structSpriteEntry ( -32,  -37), $00, SpriteSmall, $0E0, 2, 2, false, false
        .structSpriteEntry ( -16,  -45), $00, SpriteSmall, $0D2, 2, 2, false, false
        .structSpriteEntry ( -24,  -45), $00, SpriteSmall, $0D1, 2, 2, false, false
        .structSpriteEntry ( -32,  -45), $00, SpriteSmall, $0D0, 2, 2, false, false
        .structSpriteEntry (   4,  -14), $00, SpriteSmall, $002, 2, 0, false, false
        .structSpriteEntry (   4,  -22), $00, SpriteSmall, $003, 2, 0, false, false
        .structSpriteEntry (   4,   -6), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (  -4,   -6), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry ( -12,   -6), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry ( -12,  -22), $21, SpriteLarge, $000, 2, 0, false, false
        ANIM_RECORD_END

      _Record09
        ANIM_RECORD 6
        .structSpriteEntry ( -19,   -2), $00, SpriteSmall, $0C2, 2, 2, false, false
        .structSpriteEntry ( -35,  -18), $00, SpriteSmall, $0A0, 2, 2, false, false
        .structSpriteEntry ( -35,  -26), $00, SpriteSmall, $090, 2, 2, false, false
        .structSpriteEntry ( -35,  -34), $00, SpriteSmall, $080, 2, 2, false, false
        .structSpriteEntry ( -35,  -10), $21, SpriteLarge, $0B0, 2, 2, false, false
        .structSpriteEntry (   4,  -14), $00, SpriteSmall, $002, 2, 0, false, false
        .structSpriteEntry (   4,  -22), $00, SpriteSmall, $003, 2, 0, false, false
        .structSpriteEntry (   4,   -6), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (  -4,   -6), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry ( -12,   -6), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry ( -12,  -22), $21, SpriteLarge, $000, 2, 0, false, false
        ANIM_RECORD_END

      _Record10
        ANIM_RECORD 6
        .structSpriteEntry ( -10,  -11), $21, SpriteLarge, $042, 2, 2, false, false
        .structSpriteEntry ( -26,  -11), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry (   4,  -14), $00, SpriteSmall, $002, 2, 0, false, false
        .structSpriteEntry (   4,  -22), $00, SpriteSmall, $003, 2, 0, false, false
        .structSpriteEntry (   4,   -6), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (  -4,   -6), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry ( -12,   -6), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry ( -12,  -22), $21, SpriteLarge, $000, 2, 0, false, false
        ANIM_RECORD_END

      _Record11
        ANIM_RECORD 7
        .structSpriteEntry ( -13,  -30), $21, SpriteLarge, $04E, 2, 2, false, false
        .structSpriteEntry ( -13,  -46), $21, SpriteLarge, $04C, 2, 2, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   4,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   4,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   4,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record12
        ANIM_RECORD 8
        .structSpriteEntry (   5,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   5,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   5,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   5,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -11,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -11,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -12,  -37), $21, SpriteLarge, $046, 2, 2, true, true
        .structSpriteEntry (   4,  -37), $21, SpriteLarge, $044, 2, 2, true, true
        .structSpriteEntry ( -10,  -39), $00, SpriteSmall, $008, 2, 0, false, false
        ANIM_RECORD_END

      _Record13
        ANIM_RECORD 9
        .structSpriteEntry (   4,   -6), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   4,  -14), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   4,  -22), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   4,  -30), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -12,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -12,  -30), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   0,  -26), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry ( -16,  -26), $21, SpriteLarge, $044, 2, 2, false, false
        ANIM_RECORD_END

      _Record14
        ANIM_RECORD 10
        .structSpriteEntry (   4,   -6), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   4,  -14), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   4,  -22), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   4,  -30), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -12,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -12,  -30), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   0,  -28), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry ( -16,  -28), $21, SpriteLarge, $044, 2, 2, false, false
        ANIM_RECORD_END

      _Record15
        ANIM_RECORD 11
        .structSpriteEntry (  -3,   -5), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   5,  -13), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   5,  -21), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   5,  -29), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry (   5,  -37), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry ( -11,  -21), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -11,  -37), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -11,  -41), $21, SpriteLarge, $046, 2, 2, true, true
        .structSpriteEntry (   5,  -41), $21, SpriteLarge, $044, 2, 2, true, true
        ANIM_RECORD_END

      _Record16
        ANIM_RECORD 12
        .structSpriteEntry (   3,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -13,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   3,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -13,  -31), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (  -4,  -37), $21, SpriteLarge, $04E, 2, 2, true, false
        .structSpriteEntry (  -4,  -53), $21, SpriteLarge, $04C, 2, 2, true, false
        ANIM_RECORD_END

      _Record17
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (   8,  -23), $00, SpriteSmall, $091, 2, 2, true, false
        .structSpriteEntry (  16,  -23), $00, SpriteSmall, $081, 2, 2, true, false
        .structSpriteEntry (   0,  -23), $00, SpriteSmall, $0A1, 2, 2, true, false
        .structSpriteEntry ( -16,  -23), $00, SpriteSmall, $091, 2, 2, false, false
        .structSpriteEntry ( -24,  -23), $00, SpriteSmall, $081, 2, 2, false, false
        .structSpriteEntry (  -8,  -23), $00, SpriteSmall, $0A1, 2, 2, false, false
        ANIM_RECORD_END

      _Record18
        ANIM_RECORD 13
        .structSpriteEntry (  -1,  -26), $21, SpriteLarge, $04E, 2, 2, true, false
        .structSpriteEntry (  -1,  -42), $21, SpriteLarge, $04C, 2, 2, true, false
        .structSpriteEntry (   3,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -13,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   3,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -13,  -31), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record19
        ANIM_RECORD 12
        .structSpriteEntry (  14,   -1), $00, SpriteSmall, $0E4, 2, 2, false, true
        .structSpriteEntry (   6,   -1), $00, SpriteSmall, $0E3, 2, 2, false, true
        .structSpriteEntry (  -2,   -1), $00, SpriteSmall, $0E2, 2, 2, false, true
        .structSpriteEntry ( -10,   -1), $00, SpriteSmall, $0E1, 2, 2, false, true
        .structSpriteEntry (   3,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -13,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   3,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -13,  -31), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record20
        ANIM_RECORD 12
        .structSpriteEntry ( -22,  -13), $00, SpriteSmall, $0E0, 2, 2, false, true
        .structSpriteEntry (  -6,   -5), $00, SpriteSmall, $0D2, 2, 2, false, true
        .structSpriteEntry ( -14,   -5), $00, SpriteSmall, $0D1, 2, 2, false, true
        .structSpriteEntry ( -22,   -5), $00, SpriteSmall, $0D0, 2, 2, false, true
        .structSpriteEntry (   3,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -13,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   3,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -13,  -31), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record21
        ANIM_RECORD 12
        .structSpriteEntry ( -26,  -37), $00, SpriteSmall, $0A0, 2, 2, false, true
        .structSpriteEntry ( -26,  -29), $00, SpriteSmall, $090, 2, 2, false, true
        .structSpriteEntry ( -26,  -21), $00, SpriteSmall, $080, 2, 2, false, true
        .structSpriteEntry ( -10,  -53), $00, SpriteSmall, $0C2, 2, 2, false, true
        .structSpriteEntry ( -26,  -53), $21, SpriteLarge, $0B0, 2, 2, false, true
        .structSpriteEntry (   3,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -13,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   3,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -13,  -31), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record22
        ANIM_RECORD 6
        .structSpriteEntry ( -11,  -15), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry ( -11,  -31), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry (   4,  -14), $00, SpriteSmall, $002, 2, 0, false, false
        .structSpriteEntry (   4,  -22), $00, SpriteSmall, $003, 2, 0, false, false
        .structSpriteEntry (   4,   -6), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (  -4,   -6), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry ( -12,   -6), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry ( -12,  -22), $21, SpriteLarge, $000, 2, 0, false, false
        ANIM_RECORD_END

      _Record23
        ANIM_RECORD 6
        .structSpriteEntry (   4,   -6), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry ( -12,   -6), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (  -4,   -6), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (  -6,  -15), $21, SpriteLarge, $04A, 2, 2, true, false
        .structSpriteEntry (  -6,  -31), $21, SpriteLarge, $048, 2, 2, true, false
        .structSpriteEntry (   4,  -14), $00, SpriteSmall, $002, 2, 0, false, false
        .structSpriteEntry (   4,  -22), $00, SpriteSmall, $003, 2, 0, false, false
        .structSpriteEntry ( -12,  -22), $21, SpriteLarge, $000, 2, 0, false, false
        ANIM_RECORD_END

      _Record24
        ANIM_RECORD 6
        .structSpriteEntry (   4,   -6), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (  -9,  -16), $21, SpriteLarge, $046, 2, 2, true, false
        .structSpriteEntry (   7,  -16), $21, SpriteLarge, $044, 2, 2, true, false
        .structSpriteEntry (  -4,   -6), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry ( -12,   -6), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   4,  -14), $00, SpriteSmall, $002, 2, 0, false, false
        .structSpriteEntry (   4,  -22), $00, SpriteSmall, $003, 2, 0, false, false
        .structSpriteEntry ( -12,  -22), $21, SpriteLarge, $000, 2, 0, false, false
        ANIM_RECORD_END

      _Record25
        ANIM_RECORD 6
        .structSpriteEntry (  -7,  -11), $21, SpriteLarge, $042, 2, 2, true, false
        .structSpriteEntry (   9,  -11), $21, SpriteLarge, $040, 2, 2, true, false
        .structSpriteEntry (   4,  -14), $00, SpriteSmall, $002, 2, 0, false, false
        .structSpriteEntry (   4,  -22), $00, SpriteSmall, $003, 2, 0, false, false
        .structSpriteEntry (   4,   -6), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (  -4,   -6), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry ( -12,   -6), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry ( -12,  -22), $21, SpriteLarge, $000, 2, 0, false, false
        ANIM_RECORD_END

      _Record26
        ANIM_RECORD 6
        .structSpriteEntry ( -26,  -39), $21, SpriteLarge, $0C3, 2, 2, false, false
        .structSpriteEntry ( -26,  -55), $21, SpriteLarge, $0A3, 2, 2, false, false
        .structSpriteEntry ( -26,  -71), $21, SpriteLarge, $083, 2, 2, false, false
        .structSpriteEntry (  -4,   -6), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry ( -12,   -6), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry ( -12,  -22), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (   4,  -22), $00, SpriteSmall, $003, 2, 0, false, false
        .structSpriteEntry (   4,   -6), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   4,  -14), $00, SpriteSmall, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record27
        ANIM_RECORD 6
        .structSpriteEntry ( -26,  -26), $21, SpriteLarge, $0C3, 2, 2, false, false
        .structSpriteEntry ( -26,  -42), $21, SpriteLarge, $0A3, 2, 2, false, false
        .structSpriteEntry ( -26,  -58), $21, SpriteLarge, $083, 2, 2, false, false
        .structSpriteEntry (  -4,   -6), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry ( -12,   -6), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry ( -12,  -22), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (   4,  -22), $00, SpriteSmall, $003, 2, 0, false, false
        .structSpriteEntry (   4,   -6), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   4,  -14), $00, SpriteSmall, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record28
        ANIM_RECORD 6
        .structSpriteEntry ( -26,  -13), $21, SpriteLarge, $0C3, 2, 2, false, false
        .structSpriteEntry ( -26,  -29), $21, SpriteLarge, $0A3, 2, 2, false, false
        .structSpriteEntry ( -26,  -45), $21, SpriteLarge, $083, 2, 2, false, false
        .structSpriteEntry (  -4,   -6), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry ( -12,   -6), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry ( -12,  -22), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (   4,  -22), $00, SpriteSmall, $003, 2, 0, false, false
        .structSpriteEntry (   4,   -6), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   4,  -14), $00, SpriteSmall, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record29
        ANIM_RECORD 14
        .structSpriteEntry (  -8,  -42), $21, SpriteLarge, $04E, 2, 2, false, false
        .structSpriteEntry (  -8,  -58), $21, SpriteLarge, $04C, 2, 2, false, false
        .structSpriteEntry (  -3,  -39), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry ( -11,  -39), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   5,   -7), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   5,  -15), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry (   5,  -23), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   5,  -31), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry ( -11,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -11,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record30
        ANIM_RECORD 15
        .structSpriteEntry (   5,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   5,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   5,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   5,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -11,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -11,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (  -9,  -29), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry ( -25,  -29), $21, SpriteLarge, $044, 2, 2, false, false
        ANIM_RECORD_END

      _Record31
        ANIM_RECORD 16
        .structSpriteEntry (   5,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   5,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   5,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   5,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -11,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -11,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (  -9,  -29), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry ( -25,  -29), $21, SpriteLarge, $044, 2, 2, false, false
        ANIM_RECORD_END

      _Record32
        ANIM_RECORD 17
        .structSpriteEntry (   5,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   5,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   5,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   5,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -11,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -11,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (  -9,  -30), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry ( -25,  -30), $21, SpriteLarge, $044, 2, 2, false, false
        ANIM_RECORD_END

      aBattleAnimationFramesDarkPrinceMagic ; 9A/FAA5

        ; Frame table of entry 44: slices of the class sheet per frame.

        .word _Frame00 - aBattleAnimationFramesDarkPrinceMagic
        .word _Frame01 - aBattleAnimationFramesDarkPrinceMagic
        .word _Frame02 - aBattleAnimationFramesDarkPrinceMagic
        .word _Frame03 - aBattleAnimationFramesDarkPrinceMagic
        .word _Frame04 - aBattleAnimationFramesDarkPrinceMagic
        .word _Frame05 - aBattleAnimationFramesDarkPrinceMagic
        .word _Frame06 - aBattleAnimationFramesDarkPrinceMagic
        .word _Frame07 - aBattleAnimationFramesDarkPrinceMagic
        .word _Frame08 - aBattleAnimationFramesDarkPrinceMagic
        .word _Frame09 - aBattleAnimationFramesDarkPrinceMagic
        .word _Frame10 - aBattleAnimationFramesDarkPrinceMagic
        .word _Frame11 - aBattleAnimationFramesDarkPrinceMagic
        .word _Frame12 - aBattleAnimationFramesDarkPrinceMagic
        .word _Frame13 - aBattleAnimationFramesDarkPrinceMagic
        .word _Frame14 - aBattleAnimationFramesDarkPrinceMagic
        .word _Frame15 - aBattleAnimationFramesDarkPrinceMagic

      _Frame00
        ANIM_TILES
        ANIM_TILE_ROW $0000, $0100
        ANIM_TILE_ROW $0100, $0080
        ANIM_TILES_END

      _Frame01
        ANIM_TILES
        ANIM_TILE_ROW $0180, $0100
        ANIM_TILE_ROW $0280, $0080
        ANIM_TILES_END

      _Frame02
        ANIM_TILES
        ANIM_TILE_ROW $0300, $0100
        ANIM_TILE_ROW $0400, $0080
        ANIM_TILES_END

      _Frame03
        ANIM_TILES
        ANIM_TILE_ROW $0480, $0100
        ANIM_TILE_ROW $0580, $0080
        ANIM_TILES_END

      _Frame04
        ANIM_TILES
        ANIM_TILE_ROW $0600, $0120
        ANIM_TILE_ROW $0720, $0080
        ANIM_TILES_END

      _Frame05
        ANIM_TILES
        ANIM_TILE_ROW $07A0, $0100
        ANIM_TILE_ROW $08A0, $0080
        ANIM_TILES_END

      _Frame06
        ANIM_TILES
        ANIM_TILE_ROW $0920, $0100
        ANIM_TILE_ROW $0A20, $0080
        ANIM_TILES_END

      _Frame07
        ANIM_TILES
        ANIM_TILE_ROW $0AA0, $0100
        ANIM_TILE_ROW $0BA0, $0080
        ANIM_TILES_END

      _Frame08
        ANIM_TILES
        ANIM_TILE_ROW $0C20, $0120
        ANIM_TILE_ROW $0D40, $0080
        ANIM_TILES_END

      _Frame09
        ANIM_TILES
        ANIM_TILE_ROW $0DC0, $0100
        ANIM_TILE_ROW $0EC0, $0080
        ANIM_TILES_END

      _Frame10
        ANIM_TILES
        ANIM_TILE_ROW $0F40, $0100
        ANIM_TILE_ROW $1040, $0080
        ANIM_TILES_END

      _Frame11
        ANIM_TILES
        ANIM_TILE_ROW $10C0, $0180
        ANIM_TILE_ROW $1240, $0100
        ANIM_TILES_END

      _Frame12
        ANIM_TILES
        ANIM_TILE_ROW $1340, $0180
        ANIM_TILE_ROW $14C0, $0100
        ANIM_TILES_END

      _Frame13
        ANIM_TILES
        ANIM_TILE_ROW $15C0, $0100
        ANIM_TILE_ROW $16C0, $0080
        ANIM_TILES_END

      _Frame14
        ANIM_TILES
        ANIM_TILE_ROW $1740, $0100
        ANIM_TILE_ROW $1840, $0080
        ANIM_TILES_END

      _Frame15
        ANIM_TILES
        ANIM_TILE_ROW $18C0, $0180
        ANIM_TILE_ROW $1A40, $0100
        ANIM_TILES_END

      aBattleAnimationSequencesDarkPrinceMagic ; 9A/FB55

        ; Sequence data of entry 44 of aBattleAnimationFrameTables, used by: DarkPrince (Magic).
        ; Frames: aBattleAnimationFramesDarkPrinceMagic.

        .word _Index - aBattleAnimationSequencesDarkPrinceMagic, _Records - aBattleAnimationSequencesDarkPrinceMagic

      _Index
        .word _Sequence00 - aBattleAnimationSequencesDarkPrinceMagic
        .word _Sequence01 - aBattleAnimationSequencesDarkPrinceMagic
        .word _Sequence02 - aBattleAnimationSequencesDarkPrinceMagic
        .word _Sequence03 - aBattleAnimationSequencesDarkPrinceMagic
        .word _Sequence04 - aBattleAnimationSequencesDarkPrinceMagic
        .word _Sequence05 - aBattleAnimationSequencesDarkPrinceMagic
        .word _Sequence06 - aBattleAnimationSequencesDarkPrinceMagic
        .word _Sequence07 - aBattleAnimationSequencesDarkPrinceMagic
        .word _Sequence08 - aBattleAnimationSequencesDarkPrinceMagic
        .word _Sequence09 - aBattleAnimationSequencesDarkPrinceMagic

      _Records
        .word _Record00 - aBattleAnimationSequencesDarkPrinceMagic
        .word _Record01 - aBattleAnimationSequencesDarkPrinceMagic
        .word _Record02 - aBattleAnimationSequencesDarkPrinceMagic
        .word _Record03 - aBattleAnimationSequencesDarkPrinceMagic
        .word _Record04 - aBattleAnimationSequencesDarkPrinceMagic
        .word _Record05 - aBattleAnimationSequencesDarkPrinceMagic
        .word _Record06 - aBattleAnimationSequencesDarkPrinceMagic
        .word _Record07 - aBattleAnimationSequencesDarkPrinceMagic
        .word _Record08 - aBattleAnimationSequencesDarkPrinceMagic
        .word _Record09 - aBattleAnimationSequencesDarkPrinceMagic
        .word _Record10 - aBattleAnimationSequencesDarkPrinceMagic
        .word _Record11 - aBattleAnimationSequencesDarkPrinceMagic
        .word _Record12 - aBattleAnimationSequencesDarkPrinceMagic
        .word _Record13 - aBattleAnimationSequencesDarkPrinceMagic
        .word _Record14 - aBattleAnimationSequencesDarkPrinceMagic
        .word _Record15 - aBattleAnimationSequencesDarkPrinceMagic
        .word _Record16 - aBattleAnimationSequencesDarkPrinceMagic

      _Sequence00
        ANIM_CLEAR_BUSY
        ANIM_STEP 1, 1
        ANIM_HOLD

      _Sequence01
        ANIM_STEP 1, 1
        ANIM_CMD_EC 3
        ANIM_STEP 1, 16
        ANIM_CMD_EC 2
        ANIM_STEP 1, 1
        ANIM_CMD_E9
        ANIM_STEP 1, 1
        ANIM_CMD_F4 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence02
        ANIM_STEP 2, 4
        ANIM_STEP 3, 5
        ANIM_STEP 4, 6
        ANIM_STEP 5, 1
        ANIM_SOUND 32
        ANIM_CMD_F0 3
        ANIM_STEP 5, 1
        ANIM_CMD_F4 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence03
        ANIM_STEP 6, 32
        ANIM_STEP 7, 4
        ANIM_STEP 8, 4
        ANIM_STEP 9, 1
        ANIM_SOUND 32
        ANIM_CMD_F0 3
        ANIM_STEP 9, 1
        ANIM_CMD_F4 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence04
        ANIM_STEP 11, 5
        ANIM_STEP 12, 3
        ANIM_STEP 13, 3
        ANIM_CMD_F4 2
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence05
        ANIM_STEP 14, 6
        ANIM_CMD_EC 1
        ANIM_STEP 15, 1
        ANIM_STEP 15, 1
        ANIM_STEP 15, 1
        ANIM_STEP 15, 1
        ANIM_STEP 15, 1
        ANIM_STEP 15, 1
        ANIM_STEP 15, 1
        ANIM_STEP 15, 1
        ANIM_STEP 14, 1
        ANIM_STEP 14, 1
        ANIM_STEP 14, 1
        ANIM_STEP 14, 1
        ANIM_STEP 1, 1
        ANIM_STEP 1, 1
        ANIM_STEP 1, 1
        ANIM_CMD_EC 0
        ANIM_STEP 1, 1
        ANIM_CMD_F4 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence06
        ANIM_STEP 10, 5
        ANIM_STEP 12, 3
        ANIM_STEP 13, 3
        ANIM_CMD_F4 2
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence07
        ANIM_STEP 16, 5
        ANIM_STEP 1, 5
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence08
        ANIM_STEP 16, 5
        ANIM_STEP 6, 32
        ANIM_STEP 1, 5
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence09
        ANIM_STEP 1, 8
        ANIM_CMD_EC 1
        ANIM_STEP 1, 2
        ANIM_STEP 1, 2
        ANIM_STEP 1, 2
        ANIM_STEP 1, 2
        ANIM_STEP 1, 2
        ANIM_STEP 1, 2
        ANIM_STEP 1, 2
        ANIM_STEP 1, 2
        ANIM_STEP 1, 2
        ANIM_STEP 1, 2
        ANIM_STEP 1, 2
        ANIM_STEP 1, 2
        ANIM_STEP 1, 2
        ANIM_STEP 1, 2
        ANIM_STEP 1, 2
        ANIM_STEP 1, 2
        ANIM_STEP 1, 2
        ANIM_STEP 1, 2
        ANIM_STEP 1, 2
        ANIM_STEP 1, 1
        ANIM_CMD_F4 1
        ANIM_CMD_EC 0
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Record00
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (   2,   -5), $00, SpriteSmall, $0F1, 2, 3, false, false
        .structSpriteEntry (  10,   -5), $00, SpriteSmall, $0F2, 2, 3, false, false
        .structSpriteEntry (  -6,   -5), $00, SpriteSmall, $0F1, 2, 3, false, false
        .structSpriteEntry ( -14,   -5), $00, SpriteSmall, $0F0, 2, 3, false, false
        ANIM_RECORD_END

      _Record01
        ANIM_RECORD 0
        .structSpriteEntry ( -10,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -10,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   6,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   6,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   6,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   6,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        ANIM_RECORD_END

      _Record02
        ANIM_RECORD 1
        .structSpriteEntry (   6,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   6,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   6,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   6,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -10,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -10,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record03
        ANIM_RECORD 2
        .structSpriteEntry ( -10,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -10,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   6,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   6,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   6,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   6,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        ANIM_RECORD_END

      _Record04
        ANIM_RECORD 3
        .structSpriteEntry (   8,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   8,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   8,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   8,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry (  -8,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (  -8,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record05
        ANIM_RECORD 4
        .structSpriteEntry (  -8,  -39), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   8,   -7), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   8,  -15), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   8,  -23), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry (   8,  -31), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (  -8,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (  -8,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record06
        ANIM_RECORD 5
        .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   4,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   4,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   4,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        ANIM_RECORD_END

      _Record07
        ANIM_RECORD 6
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   4,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   4,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   4,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record08
        ANIM_RECORD 7
        .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   4,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   4,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   4,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        ANIM_RECORD_END

      _Record09
        ANIM_RECORD 8
        .structSpriteEntry ( -10,  -39), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   4,  -15), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   4,  -23), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry (   4,  -31), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record10
        ANIM_RECORD 9
        .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   4,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   4,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   4,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        ANIM_RECORD_END

      _Record11
        ANIM_RECORD 10
        .structSpriteEntry (   5,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   5,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   5,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   5,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -11,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -11,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record12
        ANIM_RECORD 11
        .structSpriteEntry (  15,   -7), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (  15,  -15), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  15,  -23), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry (  15,  -31), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (  -1,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -17,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (  -1,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -17,  -31), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record13
        ANIM_RECORD 12
        .structSpriteEntry (  15,   -7), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (  15,  -15), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  15,  -23), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry (  15,  -31), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (  -1,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -17,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (  -1,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -17,  -31), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record14
        ANIM_RECORD 13
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   4,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   4,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   4,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record15
        ANIM_RECORD 14
        .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   4,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   4,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   4,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        ANIM_RECORD_END

      _Record16
        ANIM_RECORD 15
        .structSpriteEntry (  16,   -7), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (  16,  -15), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  16,  -23), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry (  16,  -31), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   0,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -16,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   0,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -16,  -31), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

    .endsection BattleAnimationFrameData9ASection
