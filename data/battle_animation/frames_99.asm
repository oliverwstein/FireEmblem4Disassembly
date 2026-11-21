; Battle animation frame data in bank $99: sequence data blocks and frame tables
; reached from aBattleAnimationFrameTables. Written by tools/battle_frames.py;
; formats and macros in include/BattleAnimation.h.

    .section BattleAnimationFrameData99Section

      aBattleAnimationFramesGeneralSword ; 99/8FA1

        ; Frame table of entries 31, 34: slices of the class sheet per frame.

        .word _Frame00 - aBattleAnimationFramesGeneralSword
        .word _Frame01 - aBattleAnimationFramesGeneralSword
        .word _Frame02 - aBattleAnimationFramesGeneralSword
        .word _Frame03 - aBattleAnimationFramesGeneralSword
        .word _Frame04 - aBattleAnimationFramesGeneralSword
        .word _Frame05 - aBattleAnimationFramesGeneralSword
        .word _Frame06 - aBattleAnimationFramesGeneralSword
        .word _Frame07 - aBattleAnimationFramesGeneralSword
        .word _Frame08 - aBattleAnimationFramesGeneralSword
        .word _Frame09 - aBattleAnimationFramesGeneralSword
        .word _Frame10 - aBattleAnimationFramesGeneralSword
        .word _Frame11 - aBattleAnimationFramesGeneralSword
        .word _Frame12 - aBattleAnimationFramesGeneralSword
        .word _Frame13 - aBattleAnimationFramesGeneralSword
        .word _Frame14 - aBattleAnimationFramesGeneralSword
        .word _Frame15 - aBattleAnimationFramesGeneralSword
        .word _Frame16 - aBattleAnimationFramesGeneralSword
        .word _Frame17 - aBattleAnimationFramesGeneralSword
        .word _Frame18 - aBattleAnimationFramesGeneralSword
        .word _Frame19 - aBattleAnimationFramesGeneralSword
        .word _Frame20 - aBattleAnimationFramesGeneralSword
        .word _Frame21 - aBattleAnimationFramesGeneralSword
        .word _Frame22 - aBattleAnimationFramesGeneralSword
        .word _Frame23 - aBattleAnimationFramesGeneralSword
        .word _Frame24 - aBattleAnimationFramesGeneralSword
        .word _Frame25 - aBattleAnimationFramesGeneralSword
        .word _Frame26 - aBattleAnimationFramesGeneralSword

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

      _Frame08
        ANIM_TILES
        ANIM_TILE_ROW $1400, $0180
        ANIM_TILE_ROW $1580, $0100
        ANIM_TILES_END

      _Frame09
        ANIM_TILES
        ANIM_TILE_ROW $1680, $0180
        ANIM_TILE_ROW $1800, $0100
        ANIM_TILES_END

      _Frame10
        ANIM_TILES
        ANIM_TILE_ROW $1900, $0180
        ANIM_TILE_ROW $1A80, $0100
        ANIM_TILES_END

      _Frame11
        ANIM_TILES
        ANIM_TILE_ROW $1B80, $0180
        ANIM_TILE_ROW $1D00, $0100
        ANIM_TILES_END

      _Frame12
        ANIM_TILES
        ANIM_TILE_ROW $1E00, $0180
        ANIM_TILE_ROW $1F80, $0100
        ANIM_TILES_END

      _Frame13
        ANIM_TILES
        ANIM_TILE_ROW $2080, $0180
        ANIM_TILE_ROW $2200, $0100
        ANIM_TILES_END

      _Frame14
        ANIM_TILES
        ANIM_TILE_ROW $2300, $0180
        ANIM_TILE_ROW $2480, $0100
        ANIM_TILES_END

      _Frame15
        ANIM_TILES
        ANIM_TILE_ROW $2580, $01C0
        ANIM_TILE_ROW $2740, $0100
        ANIM_TILES_END

      _Frame16
        ANIM_TILES
        ANIM_TILE_ROW $2840, $0180
        ANIM_TILE_ROW $29C0, $0100
        ANIM_TILES_END

      _Frame17
        ANIM_TILES
        ANIM_TILE_ROW $2AC0, $0180
        ANIM_TILE_ROW $2C40, $0100
        ANIM_TILES_END

      _Frame18
        ANIM_TILES
        ANIM_TILE_ROW $2D40, $0180
        ANIM_TILE_ROW $2EC0, $0100
        ANIM_TILES_END

      _Frame19
        ANIM_TILES
        ANIM_TILE_ROW $2FC0, $0180
        ANIM_TILE_ROW $3140, $0100
        ANIM_TILES_END

      _Frame20
        ANIM_TILES
        ANIM_TILE_ROW $3240, $0180
        ANIM_TILE_ROW $33C0, $0100
        ANIM_TILES_END

      _Frame21
        ANIM_TILES
        ANIM_TILE_ROW $34C0, $0180
        ANIM_TILE_ROW $3640, $0100
        ANIM_TILES_END

      _Frame22
        ANIM_TILES
        ANIM_TILE_ROW $3740, $0180
        ANIM_TILE_ROW $38C0, $0100
        ANIM_TILES_END

      _Frame23
        ANIM_TILES
        ANIM_TILE_ROW $39C0, $01A0
        ANIM_TILE_ROW $3B60, $0100
        ANIM_TILES_END

      _Frame24
        ANIM_TILES
        ANIM_TILE_ROW $3C60, $0180
        ANIM_TILE_ROW $3DE0, $0100
        ANIM_TILES_END

      _Frame25
        ANIM_TILES
        ANIM_TILE_ROW $3EE0, $0180
        ANIM_TILE_ROW $4060, $0100
        ANIM_TILES_END

      _Frame26
        ANIM_TILES
        ANIM_TILE_ROW $4160, $0180
        ANIM_TILE_ROW $42E0, $0100
        ANIM_TILES_END

      aBattleAnimationSequencesGeneralSword ; 99/90CA

        ; Sequence data of entry 31 of aBattleAnimationFrameTables, used by: General (Sword),
        ; General (Axe), Emperor (Sword), Emperor (Axe), Baron (Sword), Baron (Axe), AxeArmor
        ; (Axe), SwordArmor (Sword). Frames: aBattleAnimationFramesGeneralSword.

        .word _Index - aBattleAnimationSequencesGeneralSword, _Records - aBattleAnimationSequencesGeneralSword

      _Index
        .word _Sequence00 - aBattleAnimationSequencesGeneralSword
        .word _Sequence01 - aBattleAnimationSequencesGeneralSword
        .word _Sequence02 - aBattleAnimationSequencesGeneralSword
        .word _Sequence03 - aBattleAnimationSequencesGeneralSword
        .word _Sequence04 - aBattleAnimationSequencesGeneralSword
        .word _Sequence05 - aBattleAnimationSequencesGeneralSword
        .word _Sequence06 - aBattleAnimationSequencesGeneralSword
        .word _Sequence07 - aBattleAnimationSequencesGeneralSword
        .word _Sequence08 - aBattleAnimationSequencesGeneralSword
        .word _Sequence09 - aBattleAnimationSequencesGeneralSword
        .word _Sequence10 - aBattleAnimationSequencesGeneralSword
        .word _Sequence11 - aBattleAnimationSequencesGeneralSword
        .word _Sequence12 - aBattleAnimationSequencesGeneralSword
        .word _Sequence13 - aBattleAnimationSequencesGeneralSword
        .word _Sequence14 - aBattleAnimationSequencesGeneralSword
        .word _Sequence15 - aBattleAnimationSequencesGeneralSword
        .word _Sequence16 - aBattleAnimationSequencesGeneralSword
        .word _Sequence17 - aBattleAnimationSequencesGeneralSword
        .word _Sequence18 - aBattleAnimationSequencesGeneralSword
        .word _Sequence19 - aBattleAnimationSequencesGeneralSword
        .word _Sequence20 - aBattleAnimationSequencesGeneralSword
        .word _Sequence21 - aBattleAnimationSequencesGeneralSword
        .word _Sequence22 - aBattleAnimationSequencesGeneralSword
        .word _Sequence23 - aBattleAnimationSequencesGeneralSword
        .word _Sequence24 - aBattleAnimationSequencesGeneralSword

      _Records
        .word aBattleAnimationSequencesGeneralRangedAxe._Record00 - aBattleAnimationSequencesGeneralSword
        .word aBattleAnimationSequencesGeneralRangedAxe._Record01 - aBattleAnimationSequencesGeneralSword
        .word aBattleAnimationSequencesGeneralRangedAxe._Record02 - aBattleAnimationSequencesGeneralSword
        .word aBattleAnimationSequencesGeneralRangedAxe._Record03 - aBattleAnimationSequencesGeneralSword
        .word aBattleAnimationSequencesGeneralRangedAxe._Record04 - aBattleAnimationSequencesGeneralSword
        .word aBattleAnimationSequencesGeneralRangedAxe._Record05 - aBattleAnimationSequencesGeneralSword
        .word aBattleAnimationSequencesGeneralRangedAxe._Record06 - aBattleAnimationSequencesGeneralSword
        .word aBattleAnimationSequencesGeneralRangedAxe._Record07 - aBattleAnimationSequencesGeneralSword
        .word aBattleAnimationSequencesGeneralRangedAxe._Record08 - aBattleAnimationSequencesGeneralSword
        .word aBattleAnimationSequencesGeneralRangedAxe._Record09 - aBattleAnimationSequencesGeneralSword
        .word aBattleAnimationSequencesGeneralRangedAxe._Record10 - aBattleAnimationSequencesGeneralSword
        .word aBattleAnimationSequencesGeneralRangedAxe._Record11 - aBattleAnimationSequencesGeneralSword
        .word aBattleAnimationSequencesGeneralRangedAxe._Record12 - aBattleAnimationSequencesGeneralSword
        .word aBattleAnimationSequencesGeneralRangedAxe._Record13 - aBattleAnimationSequencesGeneralSword
        .word aBattleAnimationSequencesGeneralRangedAxe._Record14 - aBattleAnimationSequencesGeneralSword
        .word aBattleAnimationSequencesGeneralRangedAxe._Record15 - aBattleAnimationSequencesGeneralSword
        .word aBattleAnimationSequencesGeneralRangedAxe._Record16 - aBattleAnimationSequencesGeneralSword
        .word aBattleAnimationSequencesGeneralRangedAxe._Record17 - aBattleAnimationSequencesGeneralSword
        .word aBattleAnimationSequencesGeneralRangedAxe._Record18 - aBattleAnimationSequencesGeneralSword
        .word aBattleAnimationSequencesGeneralRangedAxe._Record19 - aBattleAnimationSequencesGeneralSword
        .word aBattleAnimationSequencesGeneralRangedAxe._Record20 - aBattleAnimationSequencesGeneralSword
        .word aBattleAnimationSequencesGeneralRangedAxe._Record21 - aBattleAnimationSequencesGeneralSword
        .word aBattleAnimationSequencesGeneralRangedAxe._Record22 - aBattleAnimationSequencesGeneralSword
        .word aBattleAnimationSequencesGeneralRangedAxe._Record23 - aBattleAnimationSequencesGeneralSword
        .word aBattleAnimationSequencesGeneralRangedAxe._Record24 - aBattleAnimationSequencesGeneralSword
        .word aBattleAnimationSequencesGeneralRangedAxe._Record25 - aBattleAnimationSequencesGeneralSword
        .word aBattleAnimationSequencesGeneralRangedAxe._Record26 - aBattleAnimationSequencesGeneralSword
        .word aBattleAnimationSequencesGeneralRangedAxe._Record27 - aBattleAnimationSequencesGeneralSword
        .word aBattleAnimationSequencesGeneralRangedAxe._Record28 - aBattleAnimationSequencesGeneralSword
        .word aBattleAnimationSequencesGeneralRangedAxe._Record29 - aBattleAnimationSequencesGeneralSword
        .word aBattleAnimationSequencesGeneralRangedAxe._Record30 - aBattleAnimationSequencesGeneralSword
        .word aBattleAnimationSequencesGeneralRangedAxe._Record31 - aBattleAnimationSequencesGeneralSword
        .word aBattleAnimationSequencesGeneralRangedAxe._Record32 - aBattleAnimationSequencesGeneralSword
        .word aBattleAnimationSequencesGeneralRangedAxe._Record33 - aBattleAnimationSequencesGeneralSword
        .word aBattleAnimationSequencesGeneralRangedAxe._Record34 - aBattleAnimationSequencesGeneralSword
        .word aBattleAnimationSequencesGeneralRangedAxe._Record35 - aBattleAnimationSequencesGeneralSword
        .word aBattleAnimationSequencesGeneralRangedAxe._Record36 - aBattleAnimationSequencesGeneralSword
        .word aBattleAnimationSequencesGeneralRangedAxe._Record37 - aBattleAnimationSequencesGeneralSword
        .word aBattleAnimationSequencesGeneralRangedAxe._Record38 - aBattleAnimationSequencesGeneralSword
        .word aBattleAnimationSequencesGeneralRangedAxe._Record39 - aBattleAnimationSequencesGeneralSword
        .word aBattleAnimationSequencesGeneralRangedAxe._Record40 - aBattleAnimationSequencesGeneralSword
        .word aBattleAnimationSequencesGeneralRangedAxe._Record41 - aBattleAnimationSequencesGeneralSword
        .word aBattleAnimationSequencesGeneralRangedAxe._Record42 - aBattleAnimationSequencesGeneralSword
        .word aBattleAnimationSequencesGeneralRangedAxe._Record43 - aBattleAnimationSequencesGeneralSword

      _Sequence00
        ANIM_CMD_F7
        ANIM_STEP 1, 1
        ANIM_HOLD

      _Sequence01
        ANIM_STEP 22, 4
        ANIM_SOUND 16
        ANIM_STEP 18, 7
        ANIM_STEP 19, 9
        ANIM_STEP 20, 5
        ANIM_STEP 21, 1
        ANIM_CMD_F4 1
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence02
        ANIM_CMD_EB
        ANIM_CMD_F7
        ANIM_SOUND 16
        ANIM_STEP 2, 5
        ANIM_STEP 3, 5
        ANIM_STEP 4, 5
        ANIM_STEP 5, 5
        ANIM_STEP 6, 6
        ANIM_STEP 7, 15
        ANIM_SOUND 16
        ANIM_STEP 8, 5
        ANIM_STEP 9, 5
        ANIM_STEP 10, 5
        ANIM_STEP 11, 7
        ANIM_STEP 12, 15
        ANIM_RESTART
        ANIM_HOLD

      _Sequence03
        ANIM_STEP 21, 1
        ANIM_CMD_EE
        ANIM_STEP 21, 6
        ANIM_STEP 18, 5
        ANIM_STEP 22, 5
        ANIM_CMD_F1
        ANIM_SOUND 0
        ANIM_STEP 24, 10
        ANIM_STEP 23, 16
        ANIM_CMD_F3
        ANIM_CMD_F7
        ANIM_CMD_ED 3
        ANIM_HOLD

      _Sequence04
        ANIM_STEP 22, 8
        ANIM_SOUND 16
        ANIM_STEP 18, 7
        ANIM_STEP 19, 9
        ANIM_STEP 20, 5
        ANIM_STEP 21, 4
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence05
        ANIM_STEP 21, 17
        ANIM_CMD_EE
        ANIM_STEP 21, 3
        ANIM_STEP 25, 2
        ANIM_STEP 26, 5
        ANIM_SOUND 16
        ANIM_STEP 27, 2
        ANIM_STEP 28, 2
        ANIM_SOUND 0
        ANIM_CMD_F1
        ANIM_STEP 29, 2
        ANIM_STEP 30, 16
        ANIM_CMD_F3
        ANIM_CMD_F7
        ANIM_CMD_ED 2
        ANIM_HOLD

      _Sequence06
        ANIM_CMD_EE
        ANIM_STEP 26, 4
        ANIM_STEP 27, 4
        ANIM_STEP 28, 3
        ANIM_SOUND 3
        ANIM_CMD_F1
        ANIM_STEP 29, 1
        ANIM_STEP 30, 1
        ANIM_CMD_F3
        ANIM_CMD_F7
        ANIM_CMD_ED 2
        ANIM_HOLD

      _Sequence07
        ANIM_STEP 14, 6
        ANIM_STEP 15, 32
        ANIM_STEP 16, 48
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence08
        ANIM_STEP 14, 5
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence09
        ANIM_STEP 27, 2
        ANIM_STEP 28, 2
        ANIM_STEP 29, 2
        ANIM_STEP 30, 6
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence10
        ANIM_SOUND 16
        ANIM_STEP 7, 5
        ANIM_STEP 3, 3
        ANIM_STEP 2, 3
        ANIM_STEP 1, 3
        ANIM_STEP 22, 4
        ANIM_SOUND 16
        ANIM_STEP 18, 7
        ANIM_STEP 19, 9
        ANIM_STEP 20, 5
        ANIM_STEP 21, 1
        ANIM_CMD_F4 1
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence11
        ANIM_STEP 22, 5
        ANIM_SOUND 16
        ANIM_STEP 18, 9
        ANIM_STEP 19, 11
        ANIM_STEP 20, 7
        ANIM_STEP 21, 16
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence12
        ANIM_STEP 1, 32
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence13
        ANIM_CMD_F7
        ANIM_STEP 22, 4
        ANIM_STEP 18, 3
        ANIM_STEP 19, 3
        ANIM_STEP 20, 3
        ANIM_CMD_EE 255
        ANIM_STEP 21, 19
        ANIM_STEP 20, 3
        ANIM_STEP 19, 4
        ANIM_STEP 18, 5
        ANIM_HOLD

      _Sequence14
        ANIM_CMD_F1
        ANIM_CMD_F7
        ANIM_STEP 23, 10
        ANIM_HOLD

      _Sequence15
        ANIM_SOUND 0
        ANIM_CMD_F7
        ANIM_STEP 17, 1
        ANIM_HOLD

      _Sequence16
        ANIM_CMD_F7
        ANIM_STEP 21, 24
        ANIM_HOLD

      _Sequence17
        ANIM_CMD_F7
        ANIM_STEP 21, 32
        ANIM_HOLD

      _Sequence18
        ANIM_STEP 23, 2
        ANIM_STEP 17, 6
        ANIM_STEP 18, 6
        ANIM_STEP 19, 6
        ANIM_STEP 20, 9
        ANIM_STEP 21, 3
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence19
        ANIM_STEP 30, 2
        ANIM_STEP 17, 4
        ANIM_STEP 18, 6
        ANIM_STEP 19, 6
        ANIM_STEP 20, 8
        ANIM_STEP 21, 3
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence20
        ANIM_STEP 1, 3
        ANIM_STEP 17, 4
        ANIM_SOUND 16
        ANIM_STEP 18, 6
        ANIM_STEP 19, 6
        ANIM_STEP 20, 8
        ANIM_STEP 21, 3
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence21
        ANIM_STEP 21, 2
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence22
        ANIM_STEP 21, 3
        ANIM_SOUND 32
        ANIM_CMD_F0 3
        ANIM_STEP 21, 3
        ANIM_CMD_F4 1
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence23
        ANIM_STEP 21, 2
        ANIM_STEP 26, 4
        ANIM_STEP 24, 2
        ANIM_STEP 23, 2
        ANIM_CMD_F4 2
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence24
        ANIM_STEP 23, 2
        ANIM_STEP 22, 7
        ANIM_STEP 14, 8
        ANIM_CMD_F7
        ANIM_HOLD

      aBattleAnimationSequencesGeneralRangedAxe ; 99/92D2

        ; Sequence data of entry 34 of aBattleAnimationFrameTables, used by: General (RangedAxe),
        ; Emperor (RangedAxe), Baron (RangedAxe), AxeArmor (RangedAxe). Frames:
        ; aBattleAnimationFramesGeneralSword.

        .word _Index - aBattleAnimationSequencesGeneralRangedAxe, _Records - aBattleAnimationSequencesGeneralRangedAxe

      _Index
        .word _Sequence00 - aBattleAnimationSequencesGeneralRangedAxe
        .word _Sequence01 - aBattleAnimationSequencesGeneralRangedAxe
        .word _Sequence02 - aBattleAnimationSequencesGeneralRangedAxe
        .word _Sequence03 - aBattleAnimationSequencesGeneralRangedAxe
        .word _Sequence04 - aBattleAnimationSequencesGeneralRangedAxe
        .word _Sequence05 - aBattleAnimationSequencesGeneralRangedAxe
        .word _Sequence06 - aBattleAnimationSequencesGeneralRangedAxe
        .word _Sequence07 - aBattleAnimationSequencesGeneralRangedAxe
        .word _Sequence08 - aBattleAnimationSequencesGeneralRangedAxe
        .word _Sequence09 - aBattleAnimationSequencesGeneralRangedAxe
        .word _Sequence10 - aBattleAnimationSequencesGeneralRangedAxe
        .word _Sequence11 - aBattleAnimationSequencesGeneralRangedAxe
        .word _Sequence12 - aBattleAnimationSequencesGeneralRangedAxe

      _Records
        .word _Record00 - aBattleAnimationSequencesGeneralRangedAxe
        .word _Record01 - aBattleAnimationSequencesGeneralRangedAxe
        .word _Record02 - aBattleAnimationSequencesGeneralRangedAxe
        .word _Record03 - aBattleAnimationSequencesGeneralRangedAxe
        .word _Record04 - aBattleAnimationSequencesGeneralRangedAxe
        .word _Record05 - aBattleAnimationSequencesGeneralRangedAxe
        .word _Record06 - aBattleAnimationSequencesGeneralRangedAxe
        .word _Record07 - aBattleAnimationSequencesGeneralRangedAxe
        .word _Record08 - aBattleAnimationSequencesGeneralRangedAxe
        .word _Record09 - aBattleAnimationSequencesGeneralRangedAxe
        .word _Record10 - aBattleAnimationSequencesGeneralRangedAxe
        .word _Record11 - aBattleAnimationSequencesGeneralRangedAxe
        .word _Record12 - aBattleAnimationSequencesGeneralRangedAxe
        .word _Record13 - aBattleAnimationSequencesGeneralRangedAxe
        .word _Record14 - aBattleAnimationSequencesGeneralRangedAxe
        .word _Record15 - aBattleAnimationSequencesGeneralRangedAxe
        .word _Record16 - aBattleAnimationSequencesGeneralRangedAxe
        .word _Record17 - aBattleAnimationSequencesGeneralRangedAxe
        .word _Record18 - aBattleAnimationSequencesGeneralRangedAxe
        .word _Record19 - aBattleAnimationSequencesGeneralRangedAxe
        .word _Record20 - aBattleAnimationSequencesGeneralRangedAxe
        .word _Record21 - aBattleAnimationSequencesGeneralRangedAxe
        .word _Record22 - aBattleAnimationSequencesGeneralRangedAxe
        .word _Record23 - aBattleAnimationSequencesGeneralRangedAxe
        .word _Record24 - aBattleAnimationSequencesGeneralRangedAxe
        .word _Record25 - aBattleAnimationSequencesGeneralRangedAxe
        .word _Record26 - aBattleAnimationSequencesGeneralRangedAxe
        .word _Record27 - aBattleAnimationSequencesGeneralRangedAxe
        .word _Record28 - aBattleAnimationSequencesGeneralRangedAxe
        .word _Record29 - aBattleAnimationSequencesGeneralRangedAxe
        .word _Record30 - aBattleAnimationSequencesGeneralRangedAxe
        .word _Record31 - aBattleAnimationSequencesGeneralRangedAxe
        .word _Record32 - aBattleAnimationSequencesGeneralRangedAxe
        .word _Record33 - aBattleAnimationSequencesGeneralRangedAxe
        .word _Record34 - aBattleAnimationSequencesGeneralRangedAxe
        .word _Record35 - aBattleAnimationSequencesGeneralRangedAxe
        .word _Record36 - aBattleAnimationSequencesGeneralRangedAxe
        .word _Record37 - aBattleAnimationSequencesGeneralRangedAxe
        .word _Record38 - aBattleAnimationSequencesGeneralRangedAxe
        .word _Record39 - aBattleAnimationSequencesGeneralRangedAxe
        .word _Record40 - aBattleAnimationSequencesGeneralRangedAxe
        .word _Record41 - aBattleAnimationSequencesGeneralRangedAxe
        .word _Record42 - aBattleAnimationSequencesGeneralRangedAxe
        .word _Record43 - aBattleAnimationSequencesGeneralRangedAxe

      _Sequence00
        ANIM_CMD_F7
        ANIM_STEP 1, 1
        ANIM_HOLD

      _Sequence01
        ANIM_SOUND 16
        ANIM_STEP 7, 5
        ANIM_STEP 3, 4
        ANIM_STEP 2, 4
        ANIM_STEP 1, 4
        ANIM_STEP 22, 6
        ANIM_SOUND 16
        ANIM_STEP 18, 9
        ANIM_STEP 19, 11
        ANIM_STEP 20, 7
        ANIM_STEP 21, 4
        ANIM_STEP 21, 1
        ANIM_CMD_F4 1
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence02
        ANIM_STEP 1, 32
        ANIM_STEP 2, 7
        ANIM_STEP 3, 7
        ANIM_STEP 4, 7
        ANIM_STEP 5, 7
        ANIM_STEP 6, 8
        ANIM_STEP 7, 19
        ANIM_STEP 8, 7
        ANIM_STEP 9, 7
        ANIM_STEP 10, 7
        ANIM_STEP 11, 7
        ANIM_STEP 12, 8
        ANIM_STEP 12, 64
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence03
        ANIM_STEP 1, 48
        ANIM_STEP 14, 6
        ANIM_STEP 15, 32
        ANIM_STEP 16, 48
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence04
        ANIM_STEP 1, 48
        ANIM_STEP 14, 3
        ANIM_STEP 15, 19
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence05
        ANIM_SOUND 16
        ANIM_STEP 22, 10
        ANIM_STEP 18, 9
        ANIM_STEP 19, 11
        ANIM_STEP 20, 7
        ANIM_STEP 21, 16
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence06
        ANIM_STEP 21, 32
        ANIM_STEP 20, 3
        ANIM_STEP 19, 4
        ANIM_STEP 18, 5
        ANIM_STEP 17, 5
        ANIM_STEP 24, 10
        ANIM_STEP 23, 32
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence07
        ANIM_STEP 21, 2
        ANIM_STEP 25, 2
        ANIM_SOUND 16
        ANIM_STEP 26, 4
        ANIM_CMD_EF 138
        ANIM_CMD_EE
        ANIM_SOUND 12
        ANIM_STEP 31, 1
        ANIM_CMD_F4 1
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence08
        ANIM_STEP 27, 2
        ANIM_STEP 28, 2
        ANIM_STEP 29, 2
        ANIM_STEP 30, 16
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence09
        ANIM_CMD_F7
        ANIM_STEP 21, 1
        ANIM_HOLD

      _Sequence10
        ANIM_CMD_EB
        ANIM_STEP 32, 2
        ANIM_STEP 33, 2
        ANIM_STEP 34, 2
        ANIM_STEP 35, 2
        ANIM_STEP 36, 2
        ANIM_STEP 37, 2
        ANIM_STEP 38, 2
        ANIM_RESTART
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence11
        ANIM_STEP 39, 10
        ANIM_STEP 40, 9
        ANIM_STEP 41, 11
        ANIM_STEP 42, 7
        ANIM_STEP 43, 16
        ANIM_STEP 21, 16
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence12
        ANIM_SOUND 16
        ANIM_STEP 22, 10
        ANIM_STEP 18, 9
        ANIM_STEP 19, 11
        ANIM_STEP 20, 7
        ANIM_STEP 21, 31
        ANIM_STEP 21, 1
        ANIM_CMD_F4 1
        ANIM_CMD_F7
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
        .structSpriteEntry ( -20,  -43), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry ( -20,  -27), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry (   5,  -26), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  13,  -10), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   5,  -10), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   2,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -14,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   2,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -14,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (  10,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        ANIM_RECORD_END

      _Record02
        ANIM_RECORD 1
        .structSpriteEntry ( -19,  -28), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry ( -19,  -44), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry (   3,  -26), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  11,  -10), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   3,  -10), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   9,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   1,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -7,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -15,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   1,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -15,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   1,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -15,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record03
        ANIM_RECORD 2
        .structSpriteEntry ( -19,  -28), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry ( -19,  -44), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry (   3,  -26), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  11,  -10), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   3,  -10), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   9,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   1,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -7,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -15,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   1,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -15,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   1,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -15,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record04
        ANIM_RECORD 3
        .structSpriteEntry ( -19,  -28), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry ( -19,  -44), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry ( -14,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (   3,  -26), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  11,  -10), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   3,  -10), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   2,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   2,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -14,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (  10,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        ANIM_RECORD_END

      _Record05
        ANIM_RECORD 4
        .structSpriteEntry ( -19,  -27), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry ( -19,  -43), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry (   3,  -25), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  11,   -9), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   3,   -9), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry ( -14,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (   2,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   2,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -14,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (  10,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        ANIM_RECORD_END

      _Record06
        ANIM_RECORD 5
        .structSpriteEntry ( -19,  -43), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry ( -19,  -27), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry (   3,  -25), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  11,   -9), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   3,   -9), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry ( -14,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (  10,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   2,  -30), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -14,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry (   2,  -14), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record07
        ANIM_RECORD 6
        .structSpriteEntry ( -19,  -27), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry ( -19,  -43), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry ( -14,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (   3,  -25), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  11,   -9), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   3,   -9), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   2,  -30), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -14,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry (  10,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   2,  -14), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record08
        ANIM_RECORD 7
        .structSpriteEntry ( -19,  -28), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry ( -19,  -44), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry (   3,  -26), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  11,  -10), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   3,  -10), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  10,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   2,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -14,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   2,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -14,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record09
        ANIM_RECORD 8
        .structSpriteEntry ( -19,  -44), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry ( -19,  -28), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry (   3,  -26), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  11,  -10), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   3,  -10), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   2,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -14,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   2,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -14,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (  10,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        ANIM_RECORD_END

      _Record10
        ANIM_RECORD 9
        .structSpriteEntry ( -19,  -44), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry ( -19,  -28), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry (  11,  -10), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   3,  -10), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry ( -14,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (   3,  -26), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  10,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   2,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   2,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -14,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record11
        ANIM_RECORD 10
        .structSpriteEntry ( -19,  -43), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry ( -19,  -27), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry ( -14,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (   3,  -25), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  11,   -9), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   3,   -9), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  10,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   2,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   2,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -14,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record12
        ANIM_RECORD 11
        .structSpriteEntry ( -19,  -43), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry ( -19,  -27), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry ( -14,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (   3,  -25), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  11,   -9), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   3,   -9), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   2,  -30), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -14,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry (  10,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   2,  -14), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record13
        ANIM_RECORD 12
        .structSpriteEntry ( -19,  -28), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry ( -19,  -44), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry ( -14,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (   3,  -25), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  11,   -9), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   3,   -9), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   2,  -30), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -14,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry (  10,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   2,  -14), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record14
        ANIM_RECORD 13
        .structSpriteEntry (  13,  -12), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   5,  -12), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   5,  -28), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry ( -21,  -28), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry ( -21,  -44), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry (  10,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry ( -14,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (   2,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   2,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry (  -6,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry ( -14,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record15
        ANIM_RECORD 14
        .structSpriteEntry (   4,  -30), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  12,  -14), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   4,  -14), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry ( -15,  -29), $21, SpriteLarge, $04E, 2, 2, false, false
        .structSpriteEntry ( -15,  -45), $21, SpriteLarge, $04C, 2, 2, false, false
        .structSpriteEntry (  10,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry ( -14,  -30), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (   2,  -30), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   2,  -14), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -14,  -14), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record16
        ANIM_RECORD 15
        .structSpriteEntry (  11,  -14), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   3,  -14), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   3,  -30), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry ( -21,  -33), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry ( -37,  -33), $21, SpriteLarge, $044, 2, 2, false, false
        .structSpriteEntry (  10,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry ( -22,  -30), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (  -6,  -30), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (  10,  -22), $00, SpriteSmall, $00C, 2, 0, false, false
        .structSpriteEntry (  10,  -30), $00, SpriteSmall, $00D, 2, 0, false, false
        .structSpriteEntry (   2,  -14), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -14,  -14), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record17
        ANIM_RECORD 16
        .structSpriteEntry (   1,  -29), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   9,  -13), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   1,  -13), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  13,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   5,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -3,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -11,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   5,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -11,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   5,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -11,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry ( -12,  -23), $21, SpriteLarge, $042, 2, 2, false, false
        .structSpriteEntry ( -28,  -23), $21, SpriteLarge, $040, 2, 2, false, false
        ANIM_RECORD_END

      _Record18
        ANIM_RECORD 17
        .structSpriteEntry ( -12,  -13), $00, SpriteSmall, $063, 2, 3, true, false
        .structSpriteEntry (  -4,  -13), $00, SpriteSmall, $062, 2, 3, true, false
        .structSpriteEntry ( -12,  -29), $21, SpriteLarge, $060, 2, 3, true, false
        .structSpriteEntry (   8,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   0,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -8,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -16,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   0,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -16,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   0,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -16,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (  -9,  -34), $21, SpriteLarge, $042, 2, 2, false, true
        .structSpriteEntry ( -25,  -34), $21, SpriteLarge, $040, 2, 2, false, true
        ANIM_RECORD_END

      _Record19
        ANIM_RECORD 18
        .structSpriteEntry ( -19,  -31), $21, SpriteLarge, $060, 2, 3, true, false
        .structSpriteEntry ( -19,  -15), $00, SpriteSmall, $063, 2, 3, true, false
        .structSpriteEntry ( -11,  -15), $00, SpriteSmall, $062, 2, 3, true, false
        .structSpriteEntry (   9,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   1,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -7,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -15,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   1,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -15,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   1,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -15,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (   2,  -43), $21, SpriteLarge, $042, 2, 2, false, true
        .structSpriteEntry ( -14,  -43), $21, SpriteLarge, $040, 2, 2, false, true
        ANIM_RECORD_END

      _Record20
        ANIM_RECORD 19
        .structSpriteEntry ( -19,  -31), $21, SpriteLarge, $060, 2, 3, true, false
        .structSpriteEntry ( -19,  -15), $00, SpriteSmall, $063, 2, 3, true, false
        .structSpriteEntry ( -11,  -15), $00, SpriteSmall, $062, 2, 3, true, false
        .structSpriteEntry (   9,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   1,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -7,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -15,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   1,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -15,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   1,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -15,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (   2,  -43), $21, SpriteLarge, $042, 2, 2, false, true
        .structSpriteEntry ( -14,  -43), $21, SpriteLarge, $040, 2, 2, false, true
        ANIM_RECORD_END

      _Record21
        ANIM_RECORD 20
        .structSpriteEntry ( -19,  -31), $21, SpriteLarge, $060, 2, 3, true, false
        .structSpriteEntry ( -19,  -15), $00, SpriteSmall, $063, 2, 3, true, false
        .structSpriteEntry ( -11,  -15), $00, SpriteSmall, $062, 2, 3, true, false
        .structSpriteEntry ( -15,  -30), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (   1,  -30), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -15,  -14), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry (   1,  -14), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (   1,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   9,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -7,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -15,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   2,  -43), $21, SpriteLarge, $042, 2, 2, false, true
        .structSpriteEntry ( -14,  -43), $21, SpriteLarge, $040, 2, 2, false, true
        ANIM_RECORD_END

      _Record22
        ANIM_RECORD 21
        .structSpriteEntry ( -14,  -29), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry ( -30,  -29), $21, SpriteLarge, $044, 2, 2, false, false
        .structSpriteEntry (  10,  -10), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   2,  -10), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   2,  -26), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  10,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   2,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -14,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   2,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -14,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record23
        ANIM_RECORD 22
        .structSpriteEntry ( -21,  -30), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry ( -37,  -30), $21, SpriteLarge, $044, 2, 2, false, false
        .structSpriteEntry (   7,  -27), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  15,  -11), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   7,  -11), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   8,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   0,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -8,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -16,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   0,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -16,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   0,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -16,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record24
        ANIM_RECORD 23
        .structSpriteEntry ( -21,  -30), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry ( -37,  -30), $21, SpriteLarge, $044, 2, 2, false, false
        .structSpriteEntry (   7,  -27), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  15,  -11), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   7,  -11), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   0,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -16,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -16,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry (   0,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (   8,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   0,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -8,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -16,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (  -8,  -38), $00, SpriteSmall, $00C, 2, 0, false, false
        ANIM_RECORD_END

      _Record25
        ANIM_RECORD 18
        .structSpriteEntry (  20,  -43), $21, SpriteLarge, $040, 2, 2, true, true
        .structSpriteEntry (   4,  -43), $21, SpriteLarge, $042, 2, 2, true, true
        .structSpriteEntry ( -19,  -31), $21, SpriteLarge, $060, 2, 3, true, false
        .structSpriteEntry ( -19,  -15), $00, SpriteSmall, $063, 2, 3, true, false
        .structSpriteEntry ( -11,  -15), $00, SpriteSmall, $062, 2, 3, true, false
        .structSpriteEntry (   9,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   1,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -7,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -15,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   1,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -15,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   1,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -15,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record26
        ANIM_RECORD 24
        .structSpriteEntry (  -9,  -45), $21, SpriteLarge, $042, 2, 2, true, true
        .structSpriteEntry (   7,  -45), $21, SpriteLarge, $040, 2, 2, true, true
        .structSpriteEntry (   8,  -15), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   0,  -15), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   0,  -31), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  12,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   4,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -4,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -12,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   4,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -12,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   4,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -12,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record27
        ANIM_RECORD 25
        .structSpriteEntry ( -15,  -56), $00, SpriteSmall, $0E3, 2, 2, false, false
        .structSpriteEntry ( -23,  -56), $00, SpriteSmall, $0E2, 2, 2, false, false
        .structSpriteEntry ( -31,  -56), $00, SpriteSmall, $0E1, 2, 2, false, false
        .structSpriteEntry ( -39,  -56), $00, SpriteSmall, $0E0, 2, 2, false, false
        .structSpriteEntry (  14,  -14), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   6,  -14), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   6,  -30), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   8,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   0,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -8,  -38), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry ( -16,  -38), $00, SpriteSmall, $00B, 2, 1, false, false
        .structSpriteEntry (   0,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -16,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   0,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -16,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record28
        ANIM_RECORD 26
        .structSpriteEntry ( -40,  -35), $00, SpriteSmall, $0D0, 2, 2, false, false
        .structSpriteEntry ( -40,  -43), $00, SpriteSmall, $0C0, 2, 2, false, false
        .structSpriteEntry ( -40,  -51), $00, SpriteSmall, $0B0, 2, 2, false, false
        .structSpriteEntry ( -32,  -51), $00, SpriteSmall, $0D1, 2, 2, false, false
        .structSpriteEntry ( -32,  -59), $00, SpriteSmall, $0C1, 2, 2, false, false
        .structSpriteEntry (  14,  -14), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   6,  -14), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   6,  -30), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   8,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   0,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -8,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -16,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   0,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -16,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   0,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -16,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record29
        ANIM_RECORD 26
        .structSpriteEntry ( -27,  -15), $00, SpriteSmall, $0A2, 2, 2, false, false
        .structSpriteEntry ( -43,  -23), $21, SpriteLarge, $0C2, 2, 2, false, false
        .structSpriteEntry ( -43,  -31), $00, SpriteSmall, $0B1, 2, 2, false, false
        .structSpriteEntry ( -43,  -39), $00, SpriteSmall, $0A1, 2, 2, false, false
        .structSpriteEntry (  14,  -14), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   6,  -14), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   6,  -30), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   8,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   0,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -8,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -16,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   0,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -16,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   0,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -16,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record30
        ANIM_RECORD 26
        .structSpriteEntry ( -21,  -18), $21, SpriteLarge, $042, 2, 2, false, false
        .structSpriteEntry ( -37,  -18), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry (  14,  -14), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   6,  -14), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   6,  -30), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   8,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   0,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -8,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -16,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   0,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -16,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   0,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -16,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record31
        ANIM_RECORD 23
        .structSpriteEntry (   7,  -27), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  15,  -11), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   7,  -11), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   0,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -16,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -16,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry (   0,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (   8,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   0,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -8,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -16,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (  -8,  -38), $00, SpriteSmall, $00C, 2, 0, false, false
        ANIM_RECORD_END

      _Record32
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (  -3,  -19), $21, SpriteLarge, $042, 2, 2, false, false
        .structSpriteEntry ( -19,  -19), $21, SpriteLarge, $040, 2, 2, false, false
        ANIM_RECORD_END

      _Record33
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry ( -10,  -25), $21, SpriteLarge, $04A, 2, 2, false, true
        .structSpriteEntry ( -10,   -9), $21, SpriteLarge, $048, 2, 2, false, true
        ANIM_RECORD_END

      _Record34
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (  -6,  -25), $21, SpriteLarge, $04A, 2, 2, true, true
        .structSpriteEntry (  -6,   -9), $21, SpriteLarge, $048, 2, 2, true, true
        ANIM_RECORD_END

      _Record35
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry ( -11,  -19), $21, SpriteLarge, $042, 2, 2, true, false
        .structSpriteEntry (   5,  -19), $21, SpriteLarge, $040, 2, 2, true, false
        ANIM_RECORD_END

      _Record36
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry ( -12,  -24), $21, SpriteLarge, $046, 2, 2, true, false
        .structSpriteEntry (   4,  -24), $21, SpriteLarge, $044, 2, 2, true, false
        ANIM_RECORD_END

      _Record37
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (  -7,  -20), $21, SpriteLarge, $04E, 2, 2, false, false
        .structSpriteEntry (  -7,  -36), $21, SpriteLarge, $04C, 2, 2, false, false
        ANIM_RECORD_END

      _Record38
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (  -9,  -20), $21, SpriteLarge, $04E, 2, 2, true, false
        .structSpriteEntry (  -9,  -36), $21, SpriteLarge, $04C, 2, 2, true, false
        ANIM_RECORD_END

      _Record39
        ANIM_RECORD 21
        .structSpriteEntry (  10,  -10), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   2,  -10), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   2,  -26), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  10,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   2,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -14,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   2,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -14,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record40
        ANIM_RECORD 17
        .structSpriteEntry ( -12,  -13), $00, SpriteSmall, $063, 2, 3, true, false
        .structSpriteEntry (  -4,  -13), $00, SpriteSmall, $062, 2, 3, true, false
        .structSpriteEntry ( -12,  -29), $21, SpriteLarge, $060, 2, 3, true, false
        .structSpriteEntry (   8,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   0,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -8,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -16,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   0,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -16,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   0,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -16,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record41
        ANIM_RECORD 18
        .structSpriteEntry ( -19,  -31), $21, SpriteLarge, $060, 2, 3, true, false
        .structSpriteEntry ( -19,  -15), $00, SpriteSmall, $063, 2, 3, true, false
        .structSpriteEntry ( -11,  -15), $00, SpriteSmall, $062, 2, 3, true, false
        .structSpriteEntry (   9,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   1,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -7,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -15,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   1,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -15,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   1,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -15,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record42
        ANIM_RECORD 19
        .structSpriteEntry ( -19,  -31), $21, SpriteLarge, $060, 2, 3, true, false
        .structSpriteEntry ( -19,  -15), $00, SpriteSmall, $063, 2, 3, true, false
        .structSpriteEntry ( -11,  -15), $00, SpriteSmall, $062, 2, 3, true, false
        .structSpriteEntry (   9,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   1,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -7,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -15,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   1,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -15,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   1,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -15,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record43
        ANIM_RECORD 20
        .structSpriteEntry ( -19,  -31), $21, SpriteLarge, $060, 2, 3, true, false
        .structSpriteEntry ( -19,  -15), $00, SpriteSmall, $063, 2, 3, true, false
        .structSpriteEntry ( -11,  -15), $00, SpriteSmall, $062, 2, 3, true, false
        .structSpriteEntry ( -15,  -30), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (   1,  -30), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -15,  -14), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry (   1,  -14), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (   1,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   9,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -7,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -15,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        ANIM_RECORD_END

      aBattleAnimationFramesGeneralLance ; 99/9E2B

        ; Frame table of entry 32: slices of the class sheet per frame.

        .word _Frame00 - aBattleAnimationFramesGeneralLance
        .word _Frame01 - aBattleAnimationFramesGeneralLance
        .word _Frame02 - aBattleAnimationFramesGeneralLance
        .word _Frame03 - aBattleAnimationFramesGeneralLance
        .word _Frame04 - aBattleAnimationFramesGeneralLance
        .word _Frame05 - aBattleAnimationFramesGeneralLance
        .word _Frame06 - aBattleAnimationFramesGeneralLance
        .word _Frame07 - aBattleAnimationFramesGeneralLance
        .word _Frame08 - aBattleAnimationFramesGeneralLance
        .word _Frame09 - aBattleAnimationFramesGeneralLance
        .word _Frame10 - aBattleAnimationFramesGeneralLance
        .word _Frame11 - aBattleAnimationFramesGeneralLance
        .word _Frame12 - aBattleAnimationFramesGeneralLance
        .word _Frame13 - aBattleAnimationFramesGeneralLance
        .word _Frame14 - aBattleAnimationFramesGeneralLance
        .word _Frame15 - aBattleAnimationFramesGeneralLance
        .word _Frame16 - aBattleAnimationFramesGeneralLance
        .word _Frame17 - aBattleAnimationFramesGeneralLance
        .word _Frame18 - aBattleAnimationFramesGeneralLance
        .word _Frame19 - aBattleAnimationFramesGeneralLance
        .word _Frame20 - aBattleAnimationFramesGeneralLance

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

      _Frame08
        ANIM_TILES
        ANIM_TILE_ROW $1400, $0180
        ANIM_TILE_ROW $1580, $0100
        ANIM_TILES_END

      _Frame09
        ANIM_TILES
        ANIM_TILE_ROW $1680, $0180
        ANIM_TILE_ROW $1800, $0100
        ANIM_TILES_END

      _Frame10
        ANIM_TILES
        ANIM_TILE_ROW $1900, $0180
        ANIM_TILE_ROW $1A80, $0100
        ANIM_TILES_END

      _Frame11
        ANIM_TILES
        ANIM_TILE_ROW $1B80, $0180
        ANIM_TILE_ROW $1D00, $0100
        ANIM_TILES_END

      _Frame12
        ANIM_TILES
        ANIM_TILE_ROW $1E00, $0180
        ANIM_TILE_ROW $1F80, $0100
        ANIM_TILES_END

      _Frame13
        ANIM_TILES
        ANIM_TILE_ROW $2080, $0180
        ANIM_TILE_ROW $2200, $0100
        ANIM_TILES_END

      _Frame14
        ANIM_TILES
        ANIM_TILE_ROW $2300, $0180
        ANIM_TILE_ROW $2480, $0100
        ANIM_TILES_END

      _Frame15
        ANIM_TILES
        ANIM_TILE_ROW $2580, $0180
        ANIM_TILE_ROW $2700, $0100
        ANIM_TILES_END

      _Frame16
        ANIM_TILES
        ANIM_TILE_ROW $2800, $0180
        ANIM_TILE_ROW $2980, $0100
        ANIM_TILES_END

      _Frame17
        ANIM_TILES
        ANIM_TILE_ROW $2A80, $0180
        ANIM_TILE_ROW $2C00, $0100
        ANIM_TILES_END

      _Frame18
        ANIM_TILES
        ANIM_TILE_ROW $2D00, $0180
        ANIM_TILE_ROW $2E80, $0100
        ANIM_TILES_END

      _Frame19
        ANIM_TILES
        ANIM_TILE_ROW $2F80, $0180
        ANIM_TILE_ROW $3100, $0100
        ANIM_TILES_END

      _Frame20
        ANIM_TILES
        ANIM_TILE_ROW $3200, $01A0
        ANIM_TILE_ROW $33A0, $0100
        ANIM_TILES_END

      aBattleAnimationSequencesGeneralLance ; 99/9F12

        ; Sequence data of entry 32 of aBattleAnimationFrameTables, used by: General (Lance),
        ; Emperor (Lance), Baron (Lance), LanceArmor (Lance). Frames:
        ; aBattleAnimationFramesGeneralLance.

        .word _Index - aBattleAnimationSequencesGeneralLance, _Records - aBattleAnimationSequencesGeneralLance

      _Index
        .word _Sequence00 - aBattleAnimationSequencesGeneralLance
        .word _Sequence01 - aBattleAnimationSequencesGeneralLance
        .word _Sequence02 - aBattleAnimationSequencesGeneralLance
        .word _Sequence03 - aBattleAnimationSequencesGeneralLance
        .word _Sequence04 - aBattleAnimationSequencesGeneralLance
        .word _Sequence05 - aBattleAnimationSequencesGeneralLance
        .word _Sequence06 - aBattleAnimationSequencesGeneralLance
        .word _Sequence07 - aBattleAnimationSequencesGeneralLance
        .word _Sequence08 - aBattleAnimationSequencesGeneralLance
        .word _Sequence09 - aBattleAnimationSequencesGeneralLance
        .word _Sequence10 - aBattleAnimationSequencesGeneralLance
        .word _Sequence11 - aBattleAnimationSequencesGeneralLance
        .word _Sequence12 - aBattleAnimationSequencesGeneralLance

      _Records
        .word aBattleAnimationSequencesGeneralRangedLance._Record00 - aBattleAnimationSequencesGeneralLance
        .word aBattleAnimationSequencesGeneralRangedLance._Record01 - aBattleAnimationSequencesGeneralLance
        .word aBattleAnimationSequencesGeneralRangedLance._Record02 - aBattleAnimationSequencesGeneralLance
        .word aBattleAnimationSequencesGeneralRangedLance._Record03 - aBattleAnimationSequencesGeneralLance
        .word aBattleAnimationSequencesGeneralRangedLance._Record04 - aBattleAnimationSequencesGeneralLance
        .word aBattleAnimationSequencesGeneralRangedLance._Record05 - aBattleAnimationSequencesGeneralLance
        .word aBattleAnimationSequencesGeneralRangedLance._Record06 - aBattleAnimationSequencesGeneralLance
        .word aBattleAnimationSequencesGeneralRangedLance._Record07 - aBattleAnimationSequencesGeneralLance
        .word aBattleAnimationSequencesGeneralRangedLance._Record08 - aBattleAnimationSequencesGeneralLance
        .word aBattleAnimationSequencesGeneralRangedLance._Record09 - aBattleAnimationSequencesGeneralLance
        .word aBattleAnimationSequencesGeneralRangedLance._Record10 - aBattleAnimationSequencesGeneralLance
        .word aBattleAnimationSequencesGeneralRangedLance._Record11 - aBattleAnimationSequencesGeneralLance
        .word aBattleAnimationSequencesGeneralRangedLance._Record12 - aBattleAnimationSequencesGeneralLance
        .word aBattleAnimationSequencesGeneralRangedLance._Record13 - aBattleAnimationSequencesGeneralLance
        .word aBattleAnimationSequencesGeneralRangedLance._Record14 - aBattleAnimationSequencesGeneralLance
        .word aBattleAnimationSequencesGeneralRangedLance._Record15 - aBattleAnimationSequencesGeneralLance
        .word aBattleAnimationSequencesGeneralRangedLance._Record16 - aBattleAnimationSequencesGeneralLance
        .word aBattleAnimationSequencesGeneralRangedLance._Record17 - aBattleAnimationSequencesGeneralLance
        .word aBattleAnimationSequencesGeneralRangedLance._Record18 - aBattleAnimationSequencesGeneralLance
        .word aBattleAnimationSequencesGeneralRangedLance._Record19 - aBattleAnimationSequencesGeneralLance
        .word aBattleAnimationSequencesGeneralRangedLance._Record20 - aBattleAnimationSequencesGeneralLance
        .word aBattleAnimationSequencesGeneralRangedLance._Record21 - aBattleAnimationSequencesGeneralLance
        .word aBattleAnimationSequencesGeneralRangedLance._Record22 - aBattleAnimationSequencesGeneralLance
        .word aBattleAnimationSequencesGeneralRangedLance._Record23 - aBattleAnimationSequencesGeneralLance
        .word aBattleAnimationSequencesGeneralRangedLance._Record24 - aBattleAnimationSequencesGeneralLance
        .word aBattleAnimationSequencesGeneralRangedLance._Record25 - aBattleAnimationSequencesGeneralLance
        .word aBattleAnimationSequencesGeneralRangedLance._Record26 - aBattleAnimationSequencesGeneralLance
        .word aBattleAnimationSequencesGeneralRangedLance._Record27 - aBattleAnimationSequencesGeneralLance
        .word aBattleAnimationSequencesGeneralRangedLance._Record28 - aBattleAnimationSequencesGeneralLance
        .word aBattleAnimationSequencesGeneralRangedLance._Record29 - aBattleAnimationSequencesGeneralLance
        .word aBattleAnimationSequencesGeneralRangedLance._Record30 - aBattleAnimationSequencesGeneralLance
        .word aBattleAnimationSequencesGeneralRangedLance._Record31 - aBattleAnimationSequencesGeneralLance
        .word aBattleAnimationSequencesGeneralRangedLance._Record32 - aBattleAnimationSequencesGeneralLance
        .word aBattleAnimationSequencesGeneralRangedLance._Record33 - aBattleAnimationSequencesGeneralLance
        .word aBattleAnimationSequencesGeneralRangedLance._Record34 - aBattleAnimationSequencesGeneralLance
        .word aBattleAnimationSequencesGeneralRangedLance._Record35 - aBattleAnimationSequencesGeneralLance
        .word aBattleAnimationSequencesGeneralRangedLance._Record36 - aBattleAnimationSequencesGeneralLance
        .word aBattleAnimationSequencesGeneralRangedLance._Record37 - aBattleAnimationSequencesGeneralLance
        .word aBattleAnimationSequencesGeneralRangedLance._Record38 - aBattleAnimationSequencesGeneralLance

      _Sequence00
        ANIM_CMD_F7
        ANIM_STEP 1, 1
        ANIM_HOLD

      _Sequence01
        ANIM_SOUND 16
        ANIM_STEP 19, 4
        ANIM_STEP 15, 7
        ANIM_STEP 16, 9
        ANIM_STEP 17, 5
        ANIM_STEP 18, 10
        ANIM_CMD_F4 1
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence02
        ANIM_CMD_F7
        ANIM_CMD_EB
        ANIM_SOUND 16
        ANIM_STEP 2, 5
        ANIM_STEP 3, 5
        ANIM_STEP 4, 5
        ANIM_STEP 5, 5
        ANIM_STEP 6, 6
        ANIM_STEP 7, 15
        ANIM_SOUND 16
        ANIM_STEP 8, 5
        ANIM_STEP 9, 5
        ANIM_STEP 10, 5
        ANIM_STEP 11, 7
        ANIM_STEP 12, 15
        ANIM_RESTART
        ANIM_HOLD

      _Sequence03
        ANIM_STEP 19, 5
        ANIM_SOUND 16
        ANIM_STEP 15, 9
        ANIM_STEP 16, 11
        ANIM_STEP 17, 7
        ANIM_STEP 18, 22
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence04
        ANIM_STEP 18, 3
        ANIM_CMD_EE
        ANIM_STEP 18, 3
        ANIM_STEP 15, 5
        ANIM_SOUND 16
        ANIM_STEP 14, 5
        ANIM_STEP 21, 3
        ANIM_SOUND 4
        ANIM_CMD_F1
        ANIM_STEP 21, 4
        ANIM_STEP 20, 8
        ANIM_CMD_F3
        ANIM_CMD_ED 2
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence05
        ANIM_STEP 18, 5
        ANIM_STEP 10, 5
        ANIM_STEP 9, 5
        ANIM_STEP 8, 5
        ANIM_STEP 7, 5
        ANIM_STEP 15, 9
        ANIM_STEP 16, 11
        ANIM_STEP 17, 7
        ANIM_STEP 18, 1
        ANIM_CMD_F4 1
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence06
        ANIM_STEP 19, 7
        ANIM_SOUND 16
        ANIM_STEP 15, 9
        ANIM_STEP 16, 11
        ANIM_STEP 17, 7
        ANIM_STEP 18, 22
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence07
        ANIM_SOUND 5
        ANIM_STEP 22, 1
        ANIM_STEP 23, 2
        ANIM_STEP 24, 2
        ANIM_STEP 25, 2
        ANIM_STEP 26, 2
        ANIM_STEP 27, 2
        ANIM_STEP 28, 2
        ANIM_STEP 29, 36
        ANIM_CMD_EE
        ANIM_STEP 29, 3
        ANIM_STEP 15, 5
        ANIM_SOUND 16
        ANIM_STEP 14, 5
        ANIM_SOUND 4
        ANIM_STEP 21, 3
        ANIM_CMD_F1
        ANIM_STEP 21, 8
        ANIM_STEP 20, 16
        ANIM_CMD_F3
        ANIM_CMD_ED 2
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence08
        ANIM_SOUND 16
        ANIM_STEP 20, 5
        ANIM_STEP 1, 16
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence09
        ANIM_SOUND 16
        ANIM_STEP 18, 5
        ANIM_STEP 9, 7
        ANIM_STEP 1, 5
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence10
        ANIM_STEP 1, 4
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence11
        ANIM_STEP 14, 6
        ANIM_STEP 15, 32
        ANIM_STEP 16, 48
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence12
        ANIM_SOUND 16
        ANIM_STEP 7, 5
        ANIM_STEP 4, 3
        ANIM_STEP 3, 3
        ANIM_STEP 2, 3
        ANIM_STEP 1, 3
        ANIM_STEP 14, 7
        ANIM_SOUND 16
        ANIM_STEP 15, 4
        ANIM_STEP 16, 5
        ANIM_STEP 17, 5
        ANIM_STEP 18, 10
        ANIM_CMD_F4 1
        ANIM_CMD_F7
        ANIM_HOLD

      aBattleAnimationFramesGeneralRangedLance ; 99/A080

        ; Frame table of entry 33: slices of the class sheet per frame.

        .word _Frame00 - aBattleAnimationFramesGeneralRangedLance
        .word _Frame01 - aBattleAnimationFramesGeneralRangedLance
        .word _Frame02 - aBattleAnimationFramesGeneralRangedLance
        .word _Frame03 - aBattleAnimationFramesGeneralRangedLance
        .word _Frame04 - aBattleAnimationFramesGeneralRangedLance
        .word _Frame05 - aBattleAnimationFramesGeneralRangedLance
        .word _Frame06 - aBattleAnimationFramesGeneralRangedLance
        .word _Frame07 - aBattleAnimationFramesGeneralRangedLance
        .word _Frame08 - aBattleAnimationFramesGeneralRangedLance
        .word _Frame09 - aBattleAnimationFramesGeneralRangedLance
        .word _Frame10 - aBattleAnimationFramesGeneralRangedLance
        .word _Frame11 - aBattleAnimationFramesGeneralRangedLance
        .word _Frame12 - aBattleAnimationFramesGeneralRangedLance
        .word _Frame13 - aBattleAnimationFramesGeneralRangedLance
        .word _Frame14 - aBattleAnimationFramesGeneralRangedLance
        .word _Frame15 - aBattleAnimationFramesGeneralRangedLance
        .word _Frame16 - aBattleAnimationFramesGeneralRangedLance
        .word _Frame17 - aBattleAnimationFramesGeneralRangedLance
        .word _Frame18 - aBattleAnimationFramesGeneralRangedLance
        .word _Frame19 - aBattleAnimationFramesGeneralRangedLance
        .word _Frame20 - aBattleAnimationFramesGeneralRangedLance

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

      _Frame08
        ANIM_TILES
        ANIM_TILE_ROW $1400, $0180
        ANIM_TILE_ROW $1580, $0100
        ANIM_TILES_END

      _Frame09
        ANIM_TILES
        ANIM_TILE_ROW $1680, $0180
        ANIM_TILE_ROW $1800, $0100
        ANIM_TILES_END

      _Frame10
        ANIM_TILES
        ANIM_TILE_ROW $1900, $0180
        ANIM_TILE_ROW $1A80, $0100
        ANIM_TILES_END

      _Frame11
        ANIM_TILES
        ANIM_TILE_ROW $1B80, $0180
        ANIM_TILE_ROW $1D00, $0100
        ANIM_TILES_END

      _Frame12
        ANIM_TILES
        ANIM_TILE_ROW $1E00, $0180
        ANIM_TILE_ROW $1F80, $0100
        ANIM_TILES_END

      _Frame13
        ANIM_TILES
        ANIM_TILE_ROW $2080, $0180
        ANIM_TILE_ROW $2200, $0100
        ANIM_TILES_END

      _Frame14
        ANIM_TILES
        ANIM_TILE_ROW $2300, $0180
        ANIM_TILE_ROW $2480, $0100
        ANIM_TILES_END

      _Frame15
        ANIM_TILES
        ANIM_TILE_ROW $2580, $0180
        ANIM_TILE_ROW $2700, $0100
        ANIM_TILES_END

      _Frame16
        ANIM_TILES
        ANIM_TILE_ROW $2800, $0180
        ANIM_TILE_ROW $2980, $0100
        ANIM_TILES_END

      _Frame17
        ANIM_TILES
        ANIM_TILE_ROW $2A80, $0180
        ANIM_TILE_ROW $2C00, $0100
        ANIM_TILES_END

      _Frame18
        ANIM_TILES
        ANIM_TILE_ROW $2D00, $0180
        ANIM_TILE_ROW $2E80, $0100
        ANIM_TILES_END

      _Frame19
        ANIM_TILES
        ANIM_TILE_ROW $2F80, $0180
        ANIM_TILE_ROW $3100, $0100
        ANIM_TILES_END

      _Frame20
        ANIM_TILES
        ANIM_TILE_ROW $3200, $01A0
        ANIM_TILE_ROW $33A0, $0100
        ANIM_TILES_END

      aBattleAnimationSequencesGeneralRangedLance ; 99/A167

        ; Sequence data of entry 33 of aBattleAnimationFrameTables, used by: General
        ; (RangedLance), Emperor (RangedLance), Baron (RangedLance), LanceArmor (RangedLance).
        ; Frames: aBattleAnimationFramesGeneralRangedLance.

        .word _Index - aBattleAnimationSequencesGeneralRangedLance, _Records - aBattleAnimationSequencesGeneralRangedLance

      _Index
        .word _Sequence00 - aBattleAnimationSequencesGeneralRangedLance
        .word _Sequence01 - aBattleAnimationSequencesGeneralRangedLance
        .word _Sequence02 - aBattleAnimationSequencesGeneralRangedLance
        .word _Sequence03 - aBattleAnimationSequencesGeneralRangedLance
        .word _Sequence04 - aBattleAnimationSequencesGeneralRangedLance
        .word _Sequence05 - aBattleAnimationSequencesGeneralRangedLance
        .word _Sequence06 - aBattleAnimationSequencesGeneralRangedLance
        .word _Sequence07 - aBattleAnimationSequencesGeneralRangedLance
        .word _Sequence08 - aBattleAnimationSequencesGeneralRangedLance
        .word _Sequence09 - aBattleAnimationSequencesGeneralRangedLance
        .word _Sequence10 - aBattleAnimationSequencesGeneralRangedLance
        .word _Sequence11 - aBattleAnimationSequencesGeneralRangedLance
        .word _Sequence12 - aBattleAnimationSequencesGeneralRangedLance
        .word _Sequence13 - aBattleAnimationSequencesGeneralRangedLance
        .word _Sequence14 - aBattleAnimationSequencesGeneralRangedLance

      _Records
        .word _Record00 - aBattleAnimationSequencesGeneralRangedLance
        .word _Record01 - aBattleAnimationSequencesGeneralRangedLance
        .word _Record02 - aBattleAnimationSequencesGeneralRangedLance
        .word _Record03 - aBattleAnimationSequencesGeneralRangedLance
        .word _Record04 - aBattleAnimationSequencesGeneralRangedLance
        .word _Record05 - aBattleAnimationSequencesGeneralRangedLance
        .word _Record06 - aBattleAnimationSequencesGeneralRangedLance
        .word _Record07 - aBattleAnimationSequencesGeneralRangedLance
        .word _Record08 - aBattleAnimationSequencesGeneralRangedLance
        .word _Record09 - aBattleAnimationSequencesGeneralRangedLance
        .word _Record10 - aBattleAnimationSequencesGeneralRangedLance
        .word _Record11 - aBattleAnimationSequencesGeneralRangedLance
        .word _Record12 - aBattleAnimationSequencesGeneralRangedLance
        .word _Record13 - aBattleAnimationSequencesGeneralRangedLance
        .word _Record14 - aBattleAnimationSequencesGeneralRangedLance
        .word _Record15 - aBattleAnimationSequencesGeneralRangedLance
        .word _Record16 - aBattleAnimationSequencesGeneralRangedLance
        .word _Record17 - aBattleAnimationSequencesGeneralRangedLance
        .word _Record18 - aBattleAnimationSequencesGeneralRangedLance
        .word _Record19 - aBattleAnimationSequencesGeneralRangedLance
        .word _Record20 - aBattleAnimationSequencesGeneralRangedLance
        .word _Record21 - aBattleAnimationSequencesGeneralRangedLance
        .word _Record22 - aBattleAnimationSequencesGeneralRangedLance
        .word _Record23 - aBattleAnimationSequencesGeneralRangedLance
        .word _Record24 - aBattleAnimationSequencesGeneralRangedLance
        .word _Record25 - aBattleAnimationSequencesGeneralRangedLance
        .word _Record26 - aBattleAnimationSequencesGeneralRangedLance
        .word _Record27 - aBattleAnimationSequencesGeneralRangedLance
        .word _Record28 - aBattleAnimationSequencesGeneralRangedLance
        .word _Record29 - aBattleAnimationSequencesGeneralRangedLance
        .word _Record30 - aBattleAnimationSequencesGeneralRangedLance
        .word _Record31 - aBattleAnimationSequencesGeneralRangedLance
        .word _Record32 - aBattleAnimationSequencesGeneralRangedLance
        .word _Record33 - aBattleAnimationSequencesGeneralRangedLance
        .word _Record34 - aBattleAnimationSequencesGeneralRangedLance
        .word _Record35 - aBattleAnimationSequencesGeneralRangedLance
        .word _Record36 - aBattleAnimationSequencesGeneralRangedLance
        .word _Record37 - aBattleAnimationSequencesGeneralRangedLance
        .word _Record38 - aBattleAnimationSequencesGeneralRangedLance

      _Sequence00
        ANIM_CMD_F7
        ANIM_STEP 1, 1
        ANIM_HOLD

      _Sequence01
        ANIM_SOUND 16
        ANIM_STEP 7, 5
        ANIM_STEP 3, 4
        ANIM_STEP 2, 4
        ANIM_STEP 1, 4
        ANIM_STEP 19, 6
        ANIM_SOUND 16
        ANIM_STEP 15, 9
        ANIM_STEP 16, 11
        ANIM_STEP 17, 7
        ANIM_STEP 18, 4
        ANIM_STEP 18, 1
        ANIM_CMD_F4 1
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence02
        ANIM_STEP 1, 32
        ANIM_STEP 2, 7
        ANIM_STEP 3, 7
        ANIM_STEP 4, 7
        ANIM_STEP 5, 7
        ANIM_STEP 6, 8
        ANIM_STEP 7, 19
        ANIM_STEP 8, 7
        ANIM_STEP 9, 7
        ANIM_STEP 10, 7
        ANIM_STEP 11, 7
        ANIM_STEP 12, 8
        ANIM_STEP 12, 64
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence03
        ANIM_SOUND 16
        ANIM_STEP 19, 10
        ANIM_STEP 15, 9
        ANIM_STEP 16, 11
        ANIM_STEP 17, 7
        ANIM_STEP 18, 5
        ANIM_STEP 22, 2
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence04
        ANIM_SOUND 16
        ANIM_STEP 19, 10
        ANIM_STEP 15, 9
        ANIM_STEP 16, 11
        ANIM_STEP 17, 7
        ANIM_STEP 18, 31
        ANIM_STEP 18, 1
        ANIM_CMD_F4 1
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence05
        ANIM_CMD_F7
        ANIM_STEP 18, 16
        ANIM_HOLD

      _Sequence06
        ANIM_STEP 18, 32
        ANIM_STEP 17, 7
        ANIM_STEP 16, 6
        ANIM_STEP 15, 6
        ANIM_STEP 14, 6
        ANIM_STEP 21, 10
        ANIM_STEP 20, 32
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence07
        ANIM_STEP 18, 32
        ANIM_STEP 29, 32
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence08
        ANIM_SOUND 16
        ANIM_STEP 19, 10
        ANIM_STEP 31, 9
        ANIM_STEP 32, 11
        ANIM_STEP 30, 7
        ANIM_STEP 22, 16
        ANIM_SOUND 16
        ANIM_STEP 33, 5
        ANIM_SOUND 11
        ANIM_CMD_EF 73
        ANIM_STEP 34, 6
        ANIM_STEP 35, 6
        ANIM_CMD_EE
        ANIM_STEP 35, 12
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence09
        ANIM_STEP 36, 1
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence10
        ANIM_STEP 36, 1
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence11
        ANIM_STEP 37, 1
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence12
        ANIM_STEP 38, 1
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence13
        ANIM_STEP 38, 1
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence14
        ANIM_STEP 22, 9
        ANIM_SOUND 16
        ANIM_STEP 33, 5
        ANIM_SOUND 11
        ANIM_CMD_EF 73
        ANIM_STEP 34, 5
        ANIM_STEP 35, 8
        ANIM_CMD_EE
        ANIM_STEP 35, 32
        ANIM_CMD_F7
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
        .structSpriteEntry ( -11,  -19), $00, SpriteSmall, $058, 2, 2, false, true
        .structSpriteEntry ( -19,  -35), $00, SpriteSmall, $057, 2, 2, false, true
        .structSpriteEntry ( -19,  -27), $00, SpriteSmall, $047, 2, 2, false, true
        .structSpriteEntry ( -32,  -51), $21, SpriteLarge, $045, 2, 2, false, true
        .structSpriteEntry (   5,  -26), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  13,  -10), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   5,  -10), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   2,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -14,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   2,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -14,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (  10,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry ( -11,  -11), $00, SpriteSmall, $048, 2, 2, false, true
        .structSpriteEntry (  -3,   -3), $00, SpriteSmall, $054, 2, 2, false, true
        ANIM_RECORD_END

      _Record02
        ANIM_RECORD 1
        .structSpriteEntry ( -18,  -35), $00, SpriteSmall, $057, 2, 2, false, true
        .structSpriteEntry ( -18,  -27), $00, SpriteSmall, $047, 2, 2, false, true
        .structSpriteEntry ( -31,  -51), $21, SpriteLarge, $045, 2, 2, false, true
        .structSpriteEntry ( -10,  -19), $00, SpriteSmall, $058, 2, 2, false, true
        .structSpriteEntry (   3,  -26), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  11,  -10), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   3,  -10), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   9,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   1,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -7,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -15,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   1,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -15,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   1,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -15,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry ( -10,  -11), $00, SpriteSmall, $048, 2, 2, false, true
        .structSpriteEntry (  -2,   -3), $00, SpriteSmall, $054, 2, 2, false, true
        ANIM_RECORD_END

      _Record03
        ANIM_RECORD 2
        .structSpriteEntry ( -18,  -35), $00, SpriteSmall, $057, 2, 2, false, true
        .structSpriteEntry ( -18,  -27), $00, SpriteSmall, $047, 2, 2, false, true
        .structSpriteEntry ( -10,  -19), $00, SpriteSmall, $058, 2, 2, false, true
        .structSpriteEntry ( -31,  -51), $21, SpriteLarge, $045, 2, 2, false, true
        .structSpriteEntry (   3,  -26), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  11,  -10), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   3,  -10), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   9,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   1,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -7,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -15,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   1,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -15,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   1,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -15,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry ( -10,  -11), $00, SpriteSmall, $048, 2, 2, false, true
        .structSpriteEntry (  -2,   -3), $00, SpriteSmall, $054, 2, 2, false, true
        ANIM_RECORD_END

      _Record04
        ANIM_RECORD 3
        .structSpriteEntry ( -10,  -19), $00, SpriteSmall, $058, 2, 2, false, true
        .structSpriteEntry ( -18,  -35), $00, SpriteSmall, $057, 2, 2, false, true
        .structSpriteEntry ( -18,  -27), $00, SpriteSmall, $047, 2, 2, false, true
        .structSpriteEntry ( -31,  -51), $21, SpriteLarge, $045, 2, 2, false, true
        .structSpriteEntry ( -14,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (   3,  -26), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  11,  -10), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   3,  -10), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   2,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   2,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -14,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (  10,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry ( -10,  -11), $00, SpriteSmall, $048, 2, 2, false, true
        .structSpriteEntry (  -2,   -3), $00, SpriteSmall, $054, 2, 2, false, true
        ANIM_RECORD_END

      _Record05
        ANIM_RECORD 4
        .structSpriteEntry ( -18,  -34), $00, SpriteSmall, $057, 2, 2, false, true
        .structSpriteEntry ( -18,  -26), $00, SpriteSmall, $047, 2, 2, false, true
        .structSpriteEntry ( -10,  -18), $00, SpriteSmall, $058, 2, 2, false, true
        .structSpriteEntry ( -31,  -50), $21, SpriteLarge, $045, 2, 2, false, true
        .structSpriteEntry (   3,  -25), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  11,   -9), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   3,   -9), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry ( -14,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (   2,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   2,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -14,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (  10,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry ( -10,  -10), $00, SpriteSmall, $048, 2, 2, false, true
        .structSpriteEntry (  -2,   -2), $00, SpriteSmall, $054, 2, 2, false, true
        ANIM_RECORD_END

      _Record06
        ANIM_RECORD 5
        .structSpriteEntry ( -18,  -34), $00, SpriteSmall, $057, 2, 2, false, true
        .structSpriteEntry ( -18,  -26), $00, SpriteSmall, $047, 2, 2, false, true
        .structSpriteEntry ( -31,  -50), $21, SpriteLarge, $045, 2, 2, false, true
        .structSpriteEntry ( -10,  -18), $00, SpriteSmall, $058, 2, 2, false, true
        .structSpriteEntry (   3,  -25), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  11,   -9), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   3,   -9), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry ( -14,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (  10,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   2,  -30), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -14,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry (   2,  -14), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry ( -10,  -10), $00, SpriteSmall, $048, 2, 2, false, true
        .structSpriteEntry (  -2,   -2), $00, SpriteSmall, $054, 2, 2, false, true
        ANIM_RECORD_END

      _Record07
        ANIM_RECORD 6
        .structSpriteEntry ( -10,  -18), $00, SpriteSmall, $058, 2, 2, false, true
        .structSpriteEntry ( -18,  -34), $00, SpriteSmall, $057, 2, 2, false, true
        .structSpriteEntry ( -18,  -26), $00, SpriteSmall, $047, 2, 2, false, true
        .structSpriteEntry ( -31,  -50), $21, SpriteLarge, $045, 2, 2, false, true
        .structSpriteEntry ( -14,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (   3,  -25), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  11,   -9), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   3,   -9), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   2,  -30), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -14,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry (  10,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   2,  -14), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (  -2,   -2), $00, SpriteSmall, $054, 2, 2, false, true
        .structSpriteEntry ( -10,  -10), $00, SpriteSmall, $048, 2, 2, false, true
        ANIM_RECORD_END

      _Record08
        ANIM_RECORD 7
        .structSpriteEntry ( -10,  -20), $00, SpriteSmall, $058, 2, 2, false, true
        .structSpriteEntry ( -18,  -36), $00, SpriteSmall, $057, 2, 2, false, true
        .structSpriteEntry ( -18,  -28), $00, SpriteSmall, $047, 2, 2, false, true
        .structSpriteEntry ( -31,  -52), $21, SpriteLarge, $045, 2, 2, false, true
        .structSpriteEntry (   3,  -26), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  11,  -10), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   3,  -10), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  10,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   2,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -14,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   2,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -14,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry ( -10,  -12), $00, SpriteSmall, $048, 2, 2, false, true
        .structSpriteEntry (  -2,   -4), $00, SpriteSmall, $054, 2, 2, false, true
        ANIM_RECORD_END

      _Record09
        ANIM_RECORD 8
        .structSpriteEntry ( -10,  -20), $00, SpriteSmall, $058, 2, 2, false, true
        .structSpriteEntry ( -18,  -36), $00, SpriteSmall, $057, 2, 2, false, true
        .structSpriteEntry ( -18,  -28), $00, SpriteSmall, $047, 2, 2, false, true
        .structSpriteEntry ( -31,  -52), $21, SpriteLarge, $045, 2, 2, false, true
        .structSpriteEntry (   3,  -26), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  11,  -10), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   3,  -10), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   2,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -14,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   2,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -14,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (  10,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (  -2,   -4), $00, SpriteSmall, $054, 2, 2, false, true
        .structSpriteEntry ( -10,  -12), $00, SpriteSmall, $048, 2, 2, false, true
        ANIM_RECORD_END

      _Record10
        ANIM_RECORD 9
        .structSpriteEntry ( -10,  -20), $00, SpriteSmall, $058, 2, 2, false, true
        .structSpriteEntry ( -18,  -36), $00, SpriteSmall, $057, 2, 2, false, true
        .structSpriteEntry ( -18,  -28), $00, SpriteSmall, $047, 2, 2, false, true
        .structSpriteEntry ( -31,  -52), $21, SpriteLarge, $045, 2, 2, false, true
        .structSpriteEntry (  11,  -10), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   3,  -10), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry ( -14,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (   3,  -26), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  10,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   2,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   2,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -14,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry ( -10,  -12), $00, SpriteSmall, $048, 2, 2, false, true
        .structSpriteEntry (  -2,   -4), $00, SpriteSmall, $054, 2, 2, false, true
        ANIM_RECORD_END

      _Record11
        ANIM_RECORD 10
        .structSpriteEntry ( -10,  -19), $00, SpriteSmall, $058, 2, 2, false, true
        .structSpriteEntry ( -18,  -35), $00, SpriteSmall, $057, 2, 2, false, true
        .structSpriteEntry ( -18,  -27), $00, SpriteSmall, $047, 2, 2, false, true
        .structSpriteEntry ( -31,  -51), $21, SpriteLarge, $045, 2, 2, false, true
        .structSpriteEntry ( -14,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (   3,  -25), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  11,   -9), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   3,   -9), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  10,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   2,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   2,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -14,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry ( -10,  -11), $00, SpriteSmall, $048, 2, 2, false, true
        .structSpriteEntry (  -2,   -3), $00, SpriteSmall, $054, 2, 2, false, true
        ANIM_RECORD_END

      _Record12
        ANIM_RECORD 11
        .structSpriteEntry ( -18,  -35), $00, SpriteSmall, $057, 2, 2, false, true
        .structSpriteEntry ( -18,  -27), $00, SpriteSmall, $047, 2, 2, false, true
        .structSpriteEntry ( -31,  -51), $21, SpriteLarge, $045, 2, 2, false, true
        .structSpriteEntry ( -10,  -19), $00, SpriteSmall, $058, 2, 2, false, true
        .structSpriteEntry ( -14,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (   3,  -25), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  11,   -9), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   3,   -9), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   2,  -30), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -14,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry (  10,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   2,  -14), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry ( -10,  -11), $00, SpriteSmall, $048, 2, 2, false, true
        .structSpriteEntry (  -2,   -3), $00, SpriteSmall, $054, 2, 2, false, true
        ANIM_RECORD_END

      _Record13
        ANIM_RECORD 12
        .structSpriteEntry ( -10,  -19), $00, SpriteSmall, $058, 2, 2, false, true
        .structSpriteEntry ( -18,  -35), $00, SpriteSmall, $057, 2, 2, false, true
        .structSpriteEntry ( -18,  -27), $00, SpriteSmall, $047, 2, 2, false, true
        .structSpriteEntry ( -31,  -51), $21, SpriteLarge, $045, 2, 2, false, true
        .structSpriteEntry (   3,  -25), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  11,   -9), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   3,   -9), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   2,  -30), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -14,  -30), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (  10,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   2,  -14), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -14,  -14), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry ( -10,  -11), $00, SpriteSmall, $048, 2, 2, false, true
        .structSpriteEntry (  -2,   -3), $00, SpriteSmall, $054, 2, 2, false, true
        ANIM_RECORD_END

      _Record14
        ANIM_RECORD 13
        .structSpriteEntry (   1,  -29), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   9,  -13), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   1,  -13), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  13,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   5,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -3,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -11,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   5,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -11,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   5,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -11,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (  11,  -35), $00, SpriteSmall, $044, 2, 2, false, false
        .structSpriteEntry (   3,  -28), $00, SpriteSmall, $053, 2, 2, false, false
        .structSpriteEntry (  -5,  -28), $00, SpriteSmall, $052, 2, 2, false, false
        .structSpriteEntry ( -13,  -20), $00, SpriteSmall, $043, 2, 2, false, false
        .structSpriteEntry ( -21,  -20), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry ( -37,  -15), $21, SpriteLarge, $040, 2, 2, false, false
        ANIM_RECORD_END

      _Record15
        ANIM_RECORD 14
        .structSpriteEntry ( -12,  -13), $00, SpriteSmall, $063, 2, 3, true, false
        .structSpriteEntry (  -4,  -13), $00, SpriteSmall, $062, 2, 3, true, false
        .structSpriteEntry ( -12,  -29), $21, SpriteLarge, $060, 2, 3, true, false
        .structSpriteEntry (   8,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   0,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -8,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -16,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   0,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -16,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   0,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -16,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (  21,  -48), $00, SpriteSmall, $044, 2, 2, false, false
        .structSpriteEntry (  13,  -40), $00, SpriteSmall, $053, 2, 2, false, false
        .structSpriteEntry (   5,  -40), $00, SpriteSmall, $052, 2, 2, false, false
        .structSpriteEntry (  -3,  -32), $00, SpriteSmall, $043, 2, 2, false, false
        .structSpriteEntry ( -11,  -32), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry ( -27,  -27), $21, SpriteLarge, $040, 2, 2, false, false
        ANIM_RECORD_END

      _Record16
        ANIM_RECORD 15
        .structSpriteEntry ( -19,  -31), $21, SpriteLarge, $060, 2, 3, true, false
        .structSpriteEntry ( -19,  -15), $00, SpriteSmall, $063, 2, 3, true, false
        .structSpriteEntry ( -11,  -15), $00, SpriteSmall, $062, 2, 3, true, false
        .structSpriteEntry (   9,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   1,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -7,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -15,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   1,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -15,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   1,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -15,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (  27,  -48), $00, SpriteSmall, $044, 2, 2, false, false
        .structSpriteEntry (  19,  -40), $00, SpriteSmall, $053, 2, 2, false, false
        .structSpriteEntry (  11,  -40), $00, SpriteSmall, $052, 2, 2, false, false
        .structSpriteEntry (   3,  -32), $00, SpriteSmall, $043, 2, 2, false, false
        .structSpriteEntry (  -5,  -32), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry ( -21,  -27), $21, SpriteLarge, $040, 2, 2, false, false
        ANIM_RECORD_END

      _Record17
        ANIM_RECORD 16
        .structSpriteEntry ( -19,  -31), $21, SpriteLarge, $060, 2, 3, true, false
        .structSpriteEntry ( -19,  -15), $00, SpriteSmall, $063, 2, 3, true, false
        .structSpriteEntry ( -11,  -15), $00, SpriteSmall, $062, 2, 3, true, false
        .structSpriteEntry (   9,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   1,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -7,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -15,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   1,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -15,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   1,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -15,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (  27,  -48), $00, SpriteSmall, $044, 2, 2, false, false
        .structSpriteEntry (  19,  -40), $00, SpriteSmall, $053, 2, 2, false, false
        .structSpriteEntry (  11,  -40), $00, SpriteSmall, $052, 2, 2, false, false
        .structSpriteEntry (   3,  -32), $00, SpriteSmall, $043, 2, 2, false, false
        .structSpriteEntry (  -5,  -32), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry ( -21,  -27), $21, SpriteLarge, $040, 2, 2, false, false
        ANIM_RECORD_END

      _Record18
        ANIM_RECORD 17
        .structSpriteEntry (   9,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   1,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry ( -19,  -31), $21, SpriteLarge, $060, 2, 3, true, false
        .structSpriteEntry ( -19,  -15), $00, SpriteSmall, $063, 2, 3, true, false
        .structSpriteEntry ( -11,  -15), $00, SpriteSmall, $062, 2, 3, true, false
        .structSpriteEntry ( -15,  -30), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (   1,  -30), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -15,  -14), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry (   1,  -14), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (  27,  -48), $00, SpriteSmall, $044, 2, 2, false, false
        .structSpriteEntry (  19,  -40), $00, SpriteSmall, $053, 2, 2, false, false
        .structSpriteEntry (  11,  -40), $00, SpriteSmall, $052, 2, 2, false, false
        .structSpriteEntry (   3,  -32), $00, SpriteSmall, $043, 2, 2, false, false
        .structSpriteEntry (  -5,  -32), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry ( -21,  -27), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry (  -7,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -15,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        ANIM_RECORD_END

      _Record19
        ANIM_RECORD 18
        .structSpriteEntry ( -14,  -25), $00, SpriteSmall, $043, 2, 2, false, true
        .structSpriteEntry ( -22,  -25), $00, SpriteSmall, $042, 2, 2, false, true
        .structSpriteEntry ( -38,  -38), $21, SpriteLarge, $040, 2, 2, false, true
        .structSpriteEntry (  10,  -10), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   2,  -10), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   2,  -26), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  10,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   2,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -14,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   2,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -14,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record20
        ANIM_RECORD 19
        .structSpriteEntry (   7,  -27), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  15,  -11), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   7,  -11), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   8,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   0,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -8,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -16,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   0,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -16,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   0,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -16,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry ( -15,  -19), $00, SpriteSmall, $052, 2, 2, false, true
        .structSpriteEntry ( -47,  -40), $21, SpriteLarge, $040, 2, 2, false, true
        .structSpriteEntry ( -23,  -27), $00, SpriteSmall, $043, 2, 2, false, true
        .structSpriteEntry ( -31,  -27), $00, SpriteSmall, $042, 2, 2, false, true
        ANIM_RECORD_END

      _Record21
        ANIM_RECORD 20
        .structSpriteEntry (   7,  -27), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  15,  -11), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   7,  -11), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   0,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (   0,  -30), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -16,  -14), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -16,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry ( -15,  -19), $00, SpriteSmall, $052, 2, 2, false, true
        .structSpriteEntry ( -23,  -27), $00, SpriteSmall, $043, 2, 2, false, true
        .structSpriteEntry ( -31,  -27), $00, SpriteSmall, $042, 2, 2, false, true
        .structSpriteEntry ( -47,  -40), $21, SpriteLarge, $040, 2, 2, false, true
        .structSpriteEntry (   8,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   0,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -8,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -16,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (  -8,  -38), $00, SpriteSmall, $00C, 2, 0, false, false
        ANIM_RECORD_END

      _Record22
        ANIM_RECORD 17
        .structSpriteEntry (  -7,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry (   1,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (   9,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (  28,  -23), $00, SpriteSmall, $044, 2, 2, false, true
        .structSpriteEntry (  20,  -31), $00, SpriteSmall, $053, 2, 2, false, true
        .structSpriteEntry (  12,  -31), $00, SpriteSmall, $052, 2, 2, false, true
        .structSpriteEntry (   4,  -39), $00, SpriteSmall, $043, 2, 2, false, true
        .structSpriteEntry (  -4,  -39), $00, SpriteSmall, $042, 2, 2, false, true
        .structSpriteEntry ( -20,  -52), $21, SpriteLarge, $040, 2, 2, false, true
        .structSpriteEntry (   1,  -30), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -19,  -31), $21, SpriteLarge, $060, 2, 3, true, false
        .structSpriteEntry ( -19,  -15), $00, SpriteSmall, $063, 2, 3, true, false
        .structSpriteEntry ( -11,  -15), $00, SpriteSmall, $062, 2, 3, true, false
        .structSpriteEntry ( -15,  -30), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -15,  -14), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry (   1,  -14), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry ( -15,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        ANIM_RECORD_END

      _Record23
        ANIM_RECORD 17
        .structSpriteEntry (   1,  -30), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -19,  -31), $21, SpriteLarge, $060, 2, 3, true, false
        .structSpriteEntry ( -19,  -15), $00, SpriteSmall, $063, 2, 3, true, false
        .structSpriteEntry ( -11,  -15), $00, SpriteSmall, $062, 2, 3, true, false
        .structSpriteEntry ( -15,  -30), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -15,  -14), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry (   1,  -14), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (  20,  -15), $00, SpriteSmall, $054, 2, 2, false, true
        .structSpriteEntry (  12,  -31), $00, SpriteSmall, $058, 2, 2, false, true
        .structSpriteEntry (  12,  -23), $00, SpriteSmall, $048, 2, 2, false, true
        .structSpriteEntry (   4,  -47), $00, SpriteSmall, $057, 2, 2, false, true
        .structSpriteEntry (   4,  -39), $00, SpriteSmall, $047, 2, 2, false, true
        .structSpriteEntry (  -9,  -63), $21, SpriteLarge, $045, 2, 2, false, true
        .structSpriteEntry (   1,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (   9,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (  -7,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -15,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        ANIM_RECORD_END

      _Record24
        ANIM_RECORD 17
        .structSpriteEntry ( -19,  -31), $21, SpriteLarge, $060, 2, 3, true, false
        .structSpriteEntry ( -19,  -15), $00, SpriteSmall, $063, 2, 3, true, false
        .structSpriteEntry ( -11,  -15), $00, SpriteSmall, $062, 2, 3, true, false
        .structSpriteEntry ( -15,  -14), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry (  12,  -47), $00, SpriteSmall, $057, 2, 2, true, true
        .structSpriteEntry (  17,  -63), $21, SpriteLarge, $045, 2, 2, true, true
        .structSpriteEntry (  12,  -39), $00, SpriteSmall, $047, 2, 2, true, true
        .structSpriteEntry (   1,  -30), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   1,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (   9,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (  -7,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -15,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry ( -15,  -30), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (   1,  -14), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record25
        ANIM_RECORD 17
        .structSpriteEntry (  11,  -39), $00, SpriteSmall, $043, 2, 2, true, true
        .structSpriteEntry (  19,  -39), $00, SpriteSmall, $042, 2, 2, true, true
        .structSpriteEntry (  27,  -52), $21, SpriteLarge, $040, 2, 2, true, true
        .structSpriteEntry ( -19,  -31), $21, SpriteLarge, $060, 2, 3, true, false
        .structSpriteEntry ( -19,  -15), $00, SpriteSmall, $063, 2, 3, true, false
        .structSpriteEntry ( -11,  -15), $00, SpriteSmall, $062, 2, 3, true, false
        .structSpriteEntry (   1,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (   9,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (  -7,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -15,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry ( -15,  -30), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (   1,  -30), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -15,  -14), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry (   1,  -14), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record26
        ANIM_RECORD 17
        .structSpriteEntry (   1,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (   9,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry ( -13,  -47), $00, SpriteSmall, $044, 2, 2, true, false
        .structSpriteEntry (  11,  -31), $00, SpriteSmall, $043, 2, 2, true, false
        .structSpriteEntry (  19,  -31), $00, SpriteSmall, $042, 2, 2, true, false
        .structSpriteEntry (  -5,  -39), $00, SpriteSmall, $053, 2, 2, true, false
        .structSpriteEntry (   3,  -39), $00, SpriteSmall, $052, 2, 2, true, false
        .structSpriteEntry (  27,  -26), $21, SpriteLarge, $040, 2, 2, true, false
        .structSpriteEntry (   1,  -30), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -19,  -31), $21, SpriteLarge, $060, 2, 3, true, false
        .structSpriteEntry ( -19,  -15), $00, SpriteSmall, $063, 2, 3, true, false
        .structSpriteEntry ( -11,  -15), $00, SpriteSmall, $062, 2, 3, true, false
        .structSpriteEntry (  -7,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -15,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry ( -15,  -30), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -15,  -14), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry (   1,  -14), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record27
        ANIM_RECORD 17
        .structSpriteEntry (   9,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   1,  -30), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (  -5,  -56), $00, SpriteSmall, $054, 2, 2, true, false
        .structSpriteEntry (  16,  -16), $21, SpriteLarge, $045, 2, 2, true, false
        .structSpriteEntry (  11,  -24), $00, SpriteSmall, $057, 2, 2, true, false
        .structSpriteEntry (  11,  -32), $00, SpriteSmall, $047, 2, 2, true, false
        .structSpriteEntry (   3,  -40), $00, SpriteSmall, $058, 2, 2, true, false
        .structSpriteEntry (   3,  -48), $00, SpriteSmall, $048, 2, 2, true, false
        .structSpriteEntry ( -19,  -31), $21, SpriteLarge, $060, 2, 3, true, false
        .structSpriteEntry ( -19,  -15), $00, SpriteSmall, $063, 2, 3, true, false
        .structSpriteEntry ( -11,  -15), $00, SpriteSmall, $062, 2, 3, true, false
        .structSpriteEntry (   1,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -7,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -15,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry ( -15,  -30), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -15,  -14), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry (   1,  -14), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record28
        ANIM_RECORD 17
        .structSpriteEntry (  19,  -56), $00, SpriteSmall, $054, 2, 2, false, false
        .structSpriteEntry (  11,  -40), $00, SpriteSmall, $058, 2, 2, false, false
        .structSpriteEntry (  11,  -48), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry (   1,  -14), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (   1,  -30), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -19,  -31), $21, SpriteLarge, $060, 2, 3, true, false
        .structSpriteEntry ( -19,  -15), $00, SpriteSmall, $063, 2, 3, true, false
        .structSpriteEntry ( -11,  -15), $00, SpriteSmall, $062, 2, 3, true, false
        .structSpriteEntry (   1,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (   9,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (  -7,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -15,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry ( -15,  -30), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -15,  -14), $21, SpriteLarge, $004, 2, 0, false, false
        ANIM_RECORD_END

      _Record29
        ANIM_RECORD 17
        .structSpriteEntry (   9,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry ( -22,  -34), $21, SpriteLarge, $060, 2, 3, true, false
        .structSpriteEntry ( -22,  -18), $00, SpriteSmall, $063, 2, 3, true, false
        .structSpriteEntry ( -14,  -18), $00, SpriteSmall, $062, 2, 3, true, false
        .structSpriteEntry ( -15,  -30), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -15,  -14), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry (  27,  -48), $00, SpriteSmall, $044, 2, 2, false, false
        .structSpriteEntry (  19,  -40), $00, SpriteSmall, $053, 2, 2, false, false
        .structSpriteEntry (  11,  -40), $00, SpriteSmall, $052, 2, 2, false, false
        .structSpriteEntry ( -21,  -27), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry (   1,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -7,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -15,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   1,  -30), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   1,  -14), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record30
        ANIM_RECORD 16
        .structSpriteEntry ( -19,  -31), $21, SpriteLarge, $060, 2, 3, true, false
        .structSpriteEntry ( -19,  -15), $00, SpriteSmall, $063, 2, 3, true, false
        .structSpriteEntry ( -11,  -15), $00, SpriteSmall, $062, 2, 3, true, false
        .structSpriteEntry (   9,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   1,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -7,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -15,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   1,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -15,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   1,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -15,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (  28,  -23), $00, SpriteSmall, $044, 2, 2, false, true
        .structSpriteEntry (  20,  -31), $00, SpriteSmall, $053, 2, 2, false, true
        .structSpriteEntry (  12,  -31), $00, SpriteSmall, $052, 2, 2, false, true
        .structSpriteEntry (   4,  -39), $00, SpriteSmall, $043, 2, 2, false, true
        .structSpriteEntry (  -4,  -39), $00, SpriteSmall, $042, 2, 2, false, true
        .structSpriteEntry ( -20,  -52), $21, SpriteLarge, $040, 2, 2, false, true
        ANIM_RECORD_END

      _Record31
        ANIM_RECORD 14
        .structSpriteEntry ( -12,  -13), $00, SpriteSmall, $063, 2, 3, true, false
        .structSpriteEntry (  -4,  -13), $00, SpriteSmall, $062, 2, 3, true, false
        .structSpriteEntry ( -12,  -29), $21, SpriteLarge, $060, 2, 3, true, false
        .structSpriteEntry (   8,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   0,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -8,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -16,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   0,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -16,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   0,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -16,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (  21,  -18), $00, SpriteSmall, $044, 2, 2, false, true
        .structSpriteEntry (  13,  -26), $00, SpriteSmall, $053, 2, 2, false, true
        .structSpriteEntry (   5,  -26), $00, SpriteSmall, $052, 2, 2, false, true
        .structSpriteEntry (  -3,  -34), $00, SpriteSmall, $043, 2, 2, false, true
        .structSpriteEntry ( -11,  -34), $00, SpriteSmall, $042, 2, 2, false, true
        .structSpriteEntry ( -27,  -47), $21, SpriteLarge, $040, 2, 2, false, true
        ANIM_RECORD_END

      _Record32
        ANIM_RECORD 15
        .structSpriteEntry ( -19,  -31), $21, SpriteLarge, $060, 2, 3, true, false
        .structSpriteEntry ( -19,  -15), $00, SpriteSmall, $063, 2, 3, true, false
        .structSpriteEntry ( -11,  -15), $00, SpriteSmall, $062, 2, 3, true, false
        .structSpriteEntry (   9,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   1,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -7,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -15,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   1,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -15,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   1,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -15,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (  28,  -23), $00, SpriteSmall, $044, 2, 2, false, true
        .structSpriteEntry (  20,  -31), $00, SpriteSmall, $053, 2, 2, false, true
        .structSpriteEntry (  12,  -31), $00, SpriteSmall, $052, 2, 2, false, true
        .structSpriteEntry (   4,  -39), $00, SpriteSmall, $043, 2, 2, false, true
        .structSpriteEntry (  -4,  -39), $00, SpriteSmall, $042, 2, 2, false, true
        .structSpriteEntry ( -20,  -52), $21, SpriteLarge, $040, 2, 2, false, true
        ANIM_RECORD_END

      _Record33
        ANIM_RECORD 13
        .structSpriteEntry (   1,  -29), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   9,  -13), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   1,  -13), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  13,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   5,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -3,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -11,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   5,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -11,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   5,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -11,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (  11,  -23), $00, SpriteSmall, $044, 2, 2, false, true
        .structSpriteEntry (   3,  -30), $00, SpriteSmall, $053, 2, 2, false, true
        .structSpriteEntry (  -5,  -30), $00, SpriteSmall, $052, 2, 2, false, true
        .structSpriteEntry ( -13,  -38), $00, SpriteSmall, $043, 2, 2, false, true
        .structSpriteEntry ( -21,  -38), $00, SpriteSmall, $042, 2, 2, false, true
        .structSpriteEntry ( -37,  -51), $21, SpriteLarge, $040, 2, 2, false, true
        ANIM_RECORD_END

      _Record34
        ANIM_RECORD 20
        .structSpriteEntry (   0,  -27), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   8,  -11), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   0,  -11), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   0,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (   0,  -30), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -16,  -14), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -16,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (   8,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   0,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -8,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -16,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (  -8,  -38), $00, SpriteSmall, $00C, 2, 0, false, false
        ANIM_RECORD_END

      _Record35
        ANIM_RECORD 19
        .structSpriteEntry (   0,  -27), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   8,  -11), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   0,  -11), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   8,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   0,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -8,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -16,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   0,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -16,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   0,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -16,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record36
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (  17,    2), $00, SpriteSmall, $044, 2, 2, false, true
        .structSpriteEntry (   9,   -6), $00, SpriteSmall, $053, 2, 2, false, true
        .structSpriteEntry (   1,   -6), $00, SpriteSmall, $052, 2, 2, false, true
        .structSpriteEntry (  -7,  -14), $00, SpriteSmall, $043, 2, 2, false, true
        .structSpriteEntry ( -15,  -14), $00, SpriteSmall, $042, 2, 2, false, true
        .structSpriteEntry ( -31,  -27), $21, SpriteLarge, $040, 2, 2, false, true
        ANIM_RECORD_END

      _Record37
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (  17,   -9), $00, SpriteSmall, $05F, 2, 2, false, false
        .structSpriteEntry (   9,   -9), $00, SpriteSmall, $05E, 2, 2, false, false
        .structSpriteEntry (   1,   -9), $00, SpriteSmall, $05D, 2, 2, false, false
        .structSpriteEntry (  -7,   -9), $00, SpriteSmall, $05C, 2, 2, false, false
        .structSpriteEntry ( -15,   -9), $00, SpriteSmall, $05B, 2, 2, false, false
        .structSpriteEntry ( -23,   -9), $00, SpriteSmall, $05A, 2, 2, false, false
        .structSpriteEntry ( -31,   -9), $00, SpriteSmall, $059, 2, 2, false, false
        ANIM_RECORD_END

      _Record38
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (  17,  -22), $00, SpriteSmall, $044, 2, 2, false, false
        .structSpriteEntry (   9,  -14), $00, SpriteSmall, $053, 2, 2, false, false
        .structSpriteEntry (   1,  -14), $00, SpriteSmall, $052, 2, 2, false, false
        .structSpriteEntry (  -7,   -6), $00, SpriteSmall, $043, 2, 2, false, false
        .structSpriteEntry ( -15,   -6), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry ( -31,   -1), $21, SpriteLarge, $040, 2, 2, false, false
        ANIM_RECORD_END

      aBattleAnimationFramesGeneralBow ; 99/AEB8

        ; Frame table of entry 35: slices of the class sheet per frame.

        .word _Frame00 - aBattleAnimationFramesGeneralBow
        .word _Frame01 - aBattleAnimationFramesGeneralBow
        .word _Frame02 - aBattleAnimationFramesGeneralBow
        .word _Frame03 - aBattleAnimationFramesGeneralBow
        .word _Frame04 - aBattleAnimationFramesGeneralBow
        .word _Frame05 - aBattleAnimationFramesGeneralBow
        .word _Frame06 - aBattleAnimationFramesGeneralBow
        .word _Frame07 - aBattleAnimationFramesGeneralBow

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

      aBattleAnimationSequencesGeneralBow ; 99/AF10

        ; Sequence data of entry 35 of aBattleAnimationFrameTables, used by: General (Bow),
        ; Emperor (Bow), Baron (Bow). Frames: aBattleAnimationFramesGeneralBow.

        .word _Index - aBattleAnimationSequencesGeneralBow, _Records - aBattleAnimationSequencesGeneralBow

      _Index
        .word _Sequence00 - aBattleAnimationSequencesGeneralBow
        .word _Sequence01 - aBattleAnimationSequencesGeneralBow
        .word _Sequence02 - aBattleAnimationSequencesGeneralBow
        .word _Sequence03 - aBattleAnimationSequencesGeneralBow
        .word _Sequence04 - aBattleAnimationSequencesGeneralBow
        .word _Sequence05 - aBattleAnimationSequencesGeneralBow
        .word _Sequence06 - aBattleAnimationSequencesGeneralBow
        .word _Sequence07 - aBattleAnimationSequencesGeneralBow
        .word _Sequence08 - aBattleAnimationSequencesGeneralBow
        .word _Sequence09 - aBattleAnimationSequencesGeneralBow
        .word _Sequence10 - aBattleAnimationSequencesGeneralBow
        .word _Sequence11 - aBattleAnimationSequencesGeneralBow
        .word _Sequence12 - aBattleAnimationSequencesGeneralBow
        .word _Sequence13 - aBattleAnimationSequencesGeneralBow
        .word _Sequence14 - aBattleAnimationSequencesGeneralBow
        .word _Sequence15 - aBattleAnimationSequencesGeneralBow
        .word _Sequence16 - aBattleAnimationSequencesGeneralBow
        .word _Sequence17 - aBattleAnimationSequencesGeneralBow
        .word _Sequence18 - aBattleAnimationSequencesGeneralBow
        .word _Sequence19 - aBattleAnimationSequencesGeneralBow
        .word _Sequence20 - aBattleAnimationSequencesGeneralBow

      _Records
        .word _Record00 - aBattleAnimationSequencesGeneralBow
        .word _Record01 - aBattleAnimationSequencesGeneralBow
        .word _Record02 - aBattleAnimationSequencesGeneralBow
        .word _Record03 - aBattleAnimationSequencesGeneralBow
        .word _Record04 - aBattleAnimationSequencesGeneralBow
        .word _Record05 - aBattleAnimationSequencesGeneralBow
        .word _Record06 - aBattleAnimationSequencesGeneralBow
        .word _Record07 - aBattleAnimationSequencesGeneralBow
        .word _Record08 - aBattleAnimationSequencesGeneralBow
        .word _Record09 - aBattleAnimationSequencesGeneralBow
        .word _Record10 - aBattleAnimationSequencesGeneralBow
        .word _Record11 - aBattleAnimationSequencesGeneralBow
        .word _Record12 - aBattleAnimationSequencesGeneralBow
        .word _Record13 - aBattleAnimationSequencesGeneralBow
        .word _Record14 - aBattleAnimationSequencesGeneralBow

      _Sequence00
        ANIM_CMD_F7
        ANIM_STEP 1, 1
        ANIM_HOLD

      _Sequence01
        ANIM_CMD_F7
        ANIM_SOUND 16
        ANIM_STEP 1, 4
        ANIM_STEP 11, 5
        ANIM_CMD_F4 0
        ANIM_HOLD

      _Sequence02
        ANIM_CMD_F7
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
        ANIM_STEP 2, 20
        ANIM_STEP 3, 4
        ANIM_STEP 4, 7
        ANIM_SOUND 9
        ANIM_STEP 5, 5
        ANIM_STEP 8, 38
        ANIM_SOUND 10
        ANIM_CMD_EF 14
        ANIM_CMD_EE
        ANIM_STEP 9, 2
        ANIM_STEP 10, 2
        ANIM_STEP 9, 2
        ANIM_STEP 10, 2
        ANIM_STEP 9, 2
        ANIM_STEP 10, 2
        ANIM_STEP 9, 48
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence04
        ANIM_STEP 3, 4
        ANIM_STEP 4, 7
        ANIM_SOUND 9
        ANIM_STEP 5, 38
        ANIM_SOUND 10
        ANIM_CMD_EF 8
        ANIM_CMD_EE
        ANIM_STEP 6, 1
        ANIM_STEP 7, 1
        ANIM_STEP 6, 1
        ANIM_STEP 7, 1
        ANIM_STEP 6, 1
        ANIM_STEP 7, 48
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence05
        ANIM_STEP 3, 4
        ANIM_STEP 4, 7
        ANIM_SOUND 9
        ANIM_STEP 5, 5
        ANIM_STEP 8, 32
        ANIM_CMD_EF 8
        ANIM_SOUND 10
        ANIM_CMD_EE
        ANIM_STEP 9, 1
        ANIM_STEP 10, 1
        ANIM_STEP 9, 1
        ANIM_STEP 10, 1
        ANIM_STEP 9, 1
        ANIM_STEP 10, 1
        ANIM_STEP 9, 48
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence06
        ANIM_CMD_F7
        ANIM_STEP 1, 16
        ANIM_HOLD

      _Sequence07
        ANIM_STEP 1, 5
        ANIM_STEP 2, 20
        ANIM_STEP 3, 4
        ANIM_STEP 4, 7
        ANIM_SOUND 9
        ANIM_STEP 5, 32
        ANIM_SOUND 10
        ANIM_CMD_EF 8
        ANIM_STEP 6, 2
        ANIM_CMD_EE
        ANIM_STEP 7, 2
        ANIM_STEP 6, 2
        ANIM_STEP 7, 2
        ANIM_STEP 6, 2
        ANIM_STEP 7, 13
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence08
        ANIM_STEP 13, 0
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence09
        ANIM_STEP 13, 0
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence10
        ANIM_STEP 13, 0
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence11
        ANIM_STEP 13, 0
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence12
        ANIM_STEP 13, 0
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence13
        ANIM_STEP 11, 7
        ANIM_STEP 1, 1
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence14
        ANIM_STEP 12, 1
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence15
        ANIM_STEP 12, 1
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence16
        ANIM_STEP 13, 1
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence17
        ANIM_STEP 14, 1
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence18
        ANIM_STEP 14, 1
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence19
        ANIM_STEP 1, 5
        ANIM_STEP 2, 21
        ANIM_STEP 3, 4
        ANIM_STEP 4, 7
        ANIM_SOUND 9
        ANIM_STEP 5, 64
        ANIM_SOUND 10
        ANIM_CMD_EF 8
        ANIM_STEP 6, 2
        ANIM_CMD_EE
        ANIM_STEP 7, 2
        ANIM_STEP 6, 2
        ANIM_STEP 7, 2
        ANIM_STEP 6, 2
        ANIM_STEP 7, 13
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence20
        ANIM_STEP 2, 20
        ANIM_STEP 3, 4
        ANIM_STEP 4, 7
        ANIM_SOUND 9
        ANIM_STEP 5, 5
        ANIM_STEP 8, 64
        ANIM_SOUND 10
        ANIM_CMD_EF 14
        ANIM_CMD_EE
        ANIM_STEP 9, 2
        ANIM_STEP 10, 2
        ANIM_STEP 9, 2
        ANIM_STEP 10, 2
        ANIM_STEP 9, 2
        ANIM_STEP 10, 2
        ANIM_STEP 9, 48
        ANIM_CMD_F7
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

      aBattleAnimationFramesEmperorStaff ; 99/B48E

        ; Frame table of entry 36: slices of the class sheet per frame.

        .word _Frame00 - aBattleAnimationFramesEmperorStaff
        .word _Frame01 - aBattleAnimationFramesEmperorStaff
        .word _Frame02 - aBattleAnimationFramesEmperorStaff
        .word _Frame03 - aBattleAnimationFramesEmperorStaff
        .word _Frame04 - aBattleAnimationFramesEmperorStaff
        .word _Frame05 - aBattleAnimationFramesEmperorStaff
        .word _Frame06 - aBattleAnimationFramesEmperorStaff
        .word _Frame07 - aBattleAnimationFramesEmperorStaff
        .word _Frame08 - aBattleAnimationFramesEmperorStaff
        .word _Frame09 - aBattleAnimationFramesEmperorStaff
        .word _Frame10 - aBattleAnimationFramesEmperorStaff
        .word _Frame11 - aBattleAnimationFramesEmperorStaff
        .word _Frame12 - aBattleAnimationFramesEmperorStaff
        .word _Frame13 - aBattleAnimationFramesEmperorStaff
        .word _Frame14 - aBattleAnimationFramesEmperorStaff
        .word _Frame15 - aBattleAnimationFramesEmperorStaff
        .word _Frame16 - aBattleAnimationFramesEmperorStaff
        .word _Frame17 - aBattleAnimationFramesEmperorStaff
        .word _Frame18 - aBattleAnimationFramesEmperorStaff
        .word _Frame19 - aBattleAnimationFramesEmperorStaff
        .word _Frame20 - aBattleAnimationFramesEmperorStaff
        .word _Frame21 - aBattleAnimationFramesEmperorStaff
        .word _Frame22 - aBattleAnimationFramesEmperorStaff
        .word _Frame23 - aBattleAnimationFramesEmperorStaff
        .word _Frame24 - aBattleAnimationFramesEmperorStaff
        .word _Frame25 - aBattleAnimationFramesEmperorStaff
        .word _Frame26 - aBattleAnimationFramesEmperorStaff

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

      _Frame08
        ANIM_TILES
        ANIM_TILE_ROW $1400, $0180
        ANIM_TILE_ROW $1580, $0100
        ANIM_TILES_END

      _Frame09
        ANIM_TILES
        ANIM_TILE_ROW $1680, $0180
        ANIM_TILE_ROW $1800, $0100
        ANIM_TILES_END

      _Frame10
        ANIM_TILES
        ANIM_TILE_ROW $1900, $0180
        ANIM_TILE_ROW $1A80, $0100
        ANIM_TILES_END

      _Frame11
        ANIM_TILES
        ANIM_TILE_ROW $1B80, $0180
        ANIM_TILE_ROW $1D00, $0100
        ANIM_TILES_END

      _Frame12
        ANIM_TILES
        ANIM_TILE_ROW $1E00, $0180
        ANIM_TILE_ROW $1F80, $0100
        ANIM_TILES_END

      _Frame13
        ANIM_TILES
        ANIM_TILE_ROW $2080, $0180
        ANIM_TILE_ROW $2200, $0100
        ANIM_TILES_END

      _Frame14
        ANIM_TILES
        ANIM_TILE_ROW $2300, $0180
        ANIM_TILE_ROW $2480, $0100
        ANIM_TILES_END

      _Frame15
        ANIM_TILES
        ANIM_TILE_ROW $2580, $01C0
        ANIM_TILE_ROW $2740, $0100
        ANIM_TILES_END

      _Frame16
        ANIM_TILES
        ANIM_TILE_ROW $2840, $0180
        ANIM_TILE_ROW $29C0, $0100
        ANIM_TILES_END

      _Frame17
        ANIM_TILES
        ANIM_TILE_ROW $2AC0, $0180
        ANIM_TILE_ROW $2C40, $0100
        ANIM_TILES_END

      _Frame18
        ANIM_TILES
        ANIM_TILE_ROW $2D40, $0180
        ANIM_TILE_ROW $2EC0, $0100
        ANIM_TILES_END

      _Frame19
        ANIM_TILES
        ANIM_TILE_ROW $2FC0, $0180
        ANIM_TILE_ROW $3140, $0100
        ANIM_TILES_END

      _Frame20
        ANIM_TILES
        ANIM_TILE_ROW $3240, $0180
        ANIM_TILE_ROW $33C0, $0100
        ANIM_TILES_END

      _Frame21
        ANIM_TILES
        ANIM_TILE_ROW $34C0, $0180
        ANIM_TILE_ROW $3640, $0100
        ANIM_TILES_END

      _Frame22
        ANIM_TILES
        ANIM_TILE_ROW $3740, $0180
        ANIM_TILE_ROW $38C0, $0100
        ANIM_TILES_END

      _Frame23
        ANIM_TILES
        ANIM_TILE_ROW $39C0, $01A0
        ANIM_TILE_ROW $3B60, $0100
        ANIM_TILES_END

      _Frame24
        ANIM_TILES
        ANIM_TILE_ROW $3C60, $0180
        ANIM_TILE_ROW $3DE0, $0100
        ANIM_TILES_END

      _Frame25
        ANIM_TILES
        ANIM_TILE_ROW $3EE0, $0180
        ANIM_TILE_ROW $4060, $0100
        ANIM_TILES_END

      _Frame26
        ANIM_TILES
        ANIM_TILE_ROW $4160, $0180
        ANIM_TILE_ROW $42E0, $0100
        ANIM_TILES_END

      aBattleAnimationSequencesEmperorStaff ; 99/B5B7

        ; Sequence data of entry 36 of aBattleAnimationFrameTables, used by: Emperor (Staff),
        ; Baron (Staff). Frames: aBattleAnimationFramesEmperorStaff.

        .word _Index - aBattleAnimationSequencesEmperorStaff, _Records - aBattleAnimationSequencesEmperorStaff

      _Index
        .word _Sequence00 - aBattleAnimationSequencesEmperorStaff
        .word _Sequence01 - aBattleAnimationSequencesEmperorStaff
        .word _Sequence02 - aBattleAnimationSequencesEmperorStaff
        .word _Sequence03 - aBattleAnimationSequencesEmperorStaff
        .word _Sequence04 - aBattleAnimationSequencesEmperorStaff
        .word _Sequence05 - aBattleAnimationSequencesEmperorStaff
        .word _Sequence06 - aBattleAnimationSequencesEmperorStaff
        .word _Sequence07 - aBattleAnimationSequencesEmperorStaff
        .word _Sequence08 - aBattleAnimationSequencesEmperorStaff
        .word _Sequence09 - aBattleAnimationSequencesEmperorStaff
        .word _Sequence10 - aBattleAnimationSequencesEmperorStaff

      _Records
        .word _Record00 - aBattleAnimationSequencesEmperorStaff
        .word _Record01 - aBattleAnimationSequencesEmperorStaff
        .word _Record02 - aBattleAnimationSequencesEmperorStaff
        .word _Record03 - aBattleAnimationSequencesEmperorStaff
        .word _Record04 - aBattleAnimationSequencesEmperorStaff
        .word _Record05 - aBattleAnimationSequencesEmperorStaff
        .word _Record06 - aBattleAnimationSequencesEmperorStaff
        .word _Record07 - aBattleAnimationSequencesEmperorStaff
        .word _Record08 - aBattleAnimationSequencesEmperorStaff
        .word _Record09 - aBattleAnimationSequencesEmperorStaff
        .word _Record10 - aBattleAnimationSequencesEmperorStaff
        .word _Record11 - aBattleAnimationSequencesEmperorStaff
        .word _Record12 - aBattleAnimationSequencesEmperorStaff
        .word _Record13 - aBattleAnimationSequencesEmperorStaff
        .word _Record14 - aBattleAnimationSequencesEmperorStaff
        .word _Record15 - aBattleAnimationSequencesEmperorStaff
        .word _Record16 - aBattleAnimationSequencesEmperorStaff
        .word _Record17 - aBattleAnimationSequencesEmperorStaff
        .word _Record18 - aBattleAnimationSequencesEmperorStaff
        .word _Record19 - aBattleAnimationSequencesEmperorStaff
        .word _Record20 - aBattleAnimationSequencesEmperorStaff
        .word _Record21 - aBattleAnimationSequencesEmperorStaff
        .word _Record22 - aBattleAnimationSequencesEmperorStaff
        .word _Record23 - aBattleAnimationSequencesEmperorStaff
        .word _Record24 - aBattleAnimationSequencesEmperorStaff
        .word _Record25 - aBattleAnimationSequencesEmperorStaff
        .word _Record26 - aBattleAnimationSequencesEmperorStaff
        .word _Record27 - aBattleAnimationSequencesEmperorStaff
        .word _Record28 - aBattleAnimationSequencesEmperorStaff
        .word _Record29 - aBattleAnimationSequencesEmperorStaff
        .word _Record30 - aBattleAnimationSequencesEmperorStaff
        .word _Record31 - aBattleAnimationSequencesEmperorStaff
        .word _Record32 - aBattleAnimationSequencesEmperorStaff
        .word _Record33 - aBattleAnimationSequencesEmperorStaff
        .word _Record34 - aBattleAnimationSequencesEmperorStaff
        .word _Record35 - aBattleAnimationSequencesEmperorStaff
        .word _Record36 - aBattleAnimationSequencesEmperorStaff
        .word _Record37 - aBattleAnimationSequencesEmperorStaff
        .word _Record38 - aBattleAnimationSequencesEmperorStaff
        .word _Record39 - aBattleAnimationSequencesEmperorStaff
        .word _Record40 - aBattleAnimationSequencesEmperorStaff
        .word _Record41 - aBattleAnimationSequencesEmperorStaff
        .word _Record42 - aBattleAnimationSequencesEmperorStaff
        .word _Record43 - aBattleAnimationSequencesEmperorStaff

      _Sequence00
        ANIM_CMD_F7
        ANIM_STEP 1, 1
        ANIM_HOLD

      _Sequence01
        ANIM_SOUND 16
        ANIM_STEP 7, 5
        ANIM_STEP 3, 4
        ANIM_STEP 2, 4
        ANIM_STEP 1, 4
        ANIM_STEP 22, 6
        ANIM_SOUND 16
        ANIM_STEP 18, 9
        ANIM_STEP 19, 11
        ANIM_STEP 20, 7
        ANIM_STEP 21, 4
        ANIM_STEP 21, 1
        ANIM_CMD_F4 1
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence02
        ANIM_STEP 1, 32
        ANIM_STEP 2, 7
        ANIM_STEP 3, 7
        ANIM_STEP 4, 7
        ANIM_STEP 5, 7
        ANIM_STEP 6, 8
        ANIM_STEP 7, 19
        ANIM_STEP 8, 7
        ANIM_STEP 9, 7
        ANIM_STEP 10, 7
        ANIM_STEP 11, 7
        ANIM_STEP 12, 8
        ANIM_STEP 12, 64

      _Sequence03
        ANIM_STEP 14, 8
        ANIM_STEP 15, 7
        ANIM_SOUND 32
        ANIM_CMD_F0
        ANIM_STEP 15, 1
        ANIM_CMD_F4 1
        ANIM_STEP 16, 31
        ANIM_STEP 16, 1
        ANIM_CMD_F4 1
        ANIM_STEP 15, 5
        ANIM_STEP 14, 8
        ANIM_STEP 1, 1
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence04
        ANIM_STEP 1, 48
        ANIM_STEP 14, 3
        ANIM_STEP 15, 19
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence05
        ANIM_SOUND 16
        ANIM_STEP 22, 10
        ANIM_STEP 18, 9
        ANIM_STEP 19, 11
        ANIM_STEP 20, 7
        ANIM_STEP 21, 31
        ANIM_STEP 21, 1
        ANIM_CMD_F4 1
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence06
        ANIM_STEP 21, 32
        ANIM_STEP 20, 3
        ANIM_STEP 19, 4
        ANIM_STEP 18, 5
        ANIM_STEP 17, 5
        ANIM_STEP 24, 10
        ANIM_STEP 23, 32

      _Sequence07
        ANIM_STEP 21, 48

      _Sequence08
        ANIM_STEP 27, 2
        ANIM_STEP 28, 2
        ANIM_STEP 29, 2
        ANIM_STEP 30, 16

      _Sequence09
        ANIM_STEP 21, 48

      _Sequence10
        ANIM_STEP 32, 2
        ANIM_STEP 33, 2
        ANIM_STEP 34, 2
        ANIM_STEP 35, 2
        ANIM_STEP 36, 2
        ANIM_STEP 37, 2
        ANIM_STEP 38, 2
        ; (no end marker: the next structure begins here)

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
        .structSpriteEntry ( -20,  -43), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry ( -20,  -27), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry (   5,  -26), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  13,  -10), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   5,  -10), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   2,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -14,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   2,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -14,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (  10,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        ANIM_RECORD_END

      _Record02
        ANIM_RECORD 1
        .structSpriteEntry ( -19,  -28), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry ( -19,  -44), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry (   3,  -26), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  11,  -10), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   3,  -10), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   9,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   1,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -7,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -15,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   1,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -15,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   1,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -15,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record03
        ANIM_RECORD 2
        .structSpriteEntry ( -19,  -28), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry ( -19,  -44), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry (   3,  -26), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  11,  -10), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   3,  -10), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   9,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   1,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -7,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -15,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   1,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -15,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   1,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -15,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record04
        ANIM_RECORD 3
        .structSpriteEntry ( -19,  -28), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry ( -19,  -44), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry ( -14,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (   3,  -26), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  11,  -10), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   3,  -10), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   2,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   2,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -14,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (  10,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        ANIM_RECORD_END

      _Record05
        ANIM_RECORD 4
        .structSpriteEntry ( -19,  -27), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry ( -19,  -43), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry (   3,  -25), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  11,   -9), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   3,   -9), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry ( -14,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (   2,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   2,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -14,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (  10,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        ANIM_RECORD_END

      _Record06
        ANIM_RECORD 5
        .structSpriteEntry ( -19,  -43), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry ( -19,  -27), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry (   3,  -25), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  11,   -9), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   3,   -9), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry ( -14,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (  10,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   2,  -30), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -14,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry (   2,  -14), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record07
        ANIM_RECORD 6
        .structSpriteEntry ( -19,  -27), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry ( -19,  -43), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry ( -14,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (   3,  -25), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  11,   -9), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   3,   -9), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   2,  -30), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -14,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry (  10,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   2,  -14), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record08
        ANIM_RECORD 7
        .structSpriteEntry ( -19,  -28), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry ( -19,  -44), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry (   3,  -26), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  11,  -10), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   3,  -10), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  10,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   2,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -14,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   2,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -14,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record09
        ANIM_RECORD 8
        .structSpriteEntry ( -19,  -44), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry ( -19,  -28), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry (   3,  -26), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  11,  -10), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   3,  -10), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   2,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -14,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   2,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -14,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (  10,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        ANIM_RECORD_END

      _Record10
        ANIM_RECORD 9
        .structSpriteEntry ( -19,  -44), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry ( -19,  -28), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry (  11,  -10), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   3,  -10), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry ( -14,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (   3,  -26), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  10,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   2,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   2,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -14,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record11
        ANIM_RECORD 10
        .structSpriteEntry ( -19,  -43), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry ( -19,  -27), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry ( -14,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (   3,  -25), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  11,   -9), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   3,   -9), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  10,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   2,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   2,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -14,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record12
        ANIM_RECORD 11
        .structSpriteEntry ( -19,  -43), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry ( -19,  -27), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry ( -14,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (   3,  -25), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  11,   -9), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   3,   -9), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   2,  -30), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -14,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry (  10,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   2,  -14), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record13
        ANIM_RECORD 12
        .structSpriteEntry ( -19,  -28), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry ( -19,  -44), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry ( -14,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (   3,  -25), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  11,   -9), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   3,   -9), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   2,  -30), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -14,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry (  10,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   2,  -14), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record14
        ANIM_RECORD 13
        .structSpriteEntry (  13,  -12), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   5,  -12), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   5,  -28), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry ( -21,  -28), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry ( -21,  -44), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry (  10,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry ( -14,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (   2,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   2,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry (  -6,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry ( -14,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record15
        ANIM_RECORD 14
        .structSpriteEntry (   4,  -30), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  12,  -14), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   4,  -14), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry ( -15,  -29), $21, SpriteLarge, $04E, 2, 2, false, false
        .structSpriteEntry ( -15,  -45), $21, SpriteLarge, $04C, 2, 2, false, false
        .structSpriteEntry (  10,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry ( -14,  -30), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (   2,  -30), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   2,  -14), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -14,  -14), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record16
        ANIM_RECORD 15
        .structSpriteEntry (  11,  -14), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   3,  -14), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   3,  -30), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry ( -21,  -33), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry ( -37,  -33), $21, SpriteLarge, $044, 2, 2, false, false
        .structSpriteEntry (  10,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry ( -22,  -30), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (  -6,  -30), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (  10,  -22), $00, SpriteSmall, $00C, 2, 0, false, false
        .structSpriteEntry (  10,  -30), $00, SpriteSmall, $00D, 2, 0, false, false
        .structSpriteEntry (   2,  -14), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -14,  -14), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record17
        ANIM_RECORD 16
        .structSpriteEntry (   1,  -29), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   9,  -13), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   1,  -13), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  13,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   5,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -3,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -11,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   5,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -11,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   5,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -11,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry ( -12,  -23), $21, SpriteLarge, $042, 2, 2, false, false
        .structSpriteEntry ( -28,  -23), $21, SpriteLarge, $040, 2, 2, false, false
        ANIM_RECORD_END

      _Record18
        ANIM_RECORD 17
        .structSpriteEntry ( -12,  -13), $00, SpriteSmall, $063, 2, 3, true, false
        .structSpriteEntry (  -4,  -13), $00, SpriteSmall, $062, 2, 3, true, false
        .structSpriteEntry ( -12,  -29), $21, SpriteLarge, $060, 2, 3, true, false
        .structSpriteEntry (   8,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   0,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -8,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -16,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   0,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -16,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   0,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -16,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (  -9,  -34), $21, SpriteLarge, $042, 2, 2, false, true
        .structSpriteEntry ( -25,  -34), $21, SpriteLarge, $040, 2, 2, false, true
        ANIM_RECORD_END

      _Record19
        ANIM_RECORD 18
        .structSpriteEntry ( -19,  -31), $21, SpriteLarge, $060, 2, 3, true, false
        .structSpriteEntry ( -19,  -15), $00, SpriteSmall, $063, 2, 3, true, false
        .structSpriteEntry ( -11,  -15), $00, SpriteSmall, $062, 2, 3, true, false
        .structSpriteEntry (   9,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   1,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -7,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -15,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   1,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -15,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   1,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -15,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (   2,  -43), $21, SpriteLarge, $042, 2, 2, false, true
        .structSpriteEntry ( -14,  -43), $21, SpriteLarge, $040, 2, 2, false, true
        ANIM_RECORD_END

      _Record20
        ANIM_RECORD 19
        .structSpriteEntry ( -19,  -31), $21, SpriteLarge, $060, 2, 3, true, false
        .structSpriteEntry ( -19,  -15), $00, SpriteSmall, $063, 2, 3, true, false
        .structSpriteEntry ( -11,  -15), $00, SpriteSmall, $062, 2, 3, true, false
        .structSpriteEntry (   9,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   1,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -7,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -15,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   1,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -15,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   1,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -15,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (   2,  -43), $21, SpriteLarge, $042, 2, 2, false, true
        .structSpriteEntry ( -14,  -43), $21, SpriteLarge, $040, 2, 2, false, true
        ANIM_RECORD_END

      _Record21
        ANIM_RECORD 20
        .structSpriteEntry ( -19,  -31), $21, SpriteLarge, $060, 2, 3, true, false
        .structSpriteEntry ( -19,  -15), $00, SpriteSmall, $063, 2, 3, true, false
        .structSpriteEntry ( -11,  -15), $00, SpriteSmall, $062, 2, 3, true, false
        .structSpriteEntry ( -15,  -30), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (   1,  -30), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -15,  -14), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry (   1,  -14), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (   1,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   9,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -7,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -15,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   2,  -43), $21, SpriteLarge, $042, 2, 2, false, true
        .structSpriteEntry ( -14,  -43), $21, SpriteLarge, $040, 2, 2, false, true
        ANIM_RECORD_END

      _Record22
        ANIM_RECORD 21
        .structSpriteEntry ( -14,  -29), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry ( -30,  -29), $21, SpriteLarge, $044, 2, 2, false, false
        .structSpriteEntry (  10,  -10), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   2,  -10), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   2,  -26), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  10,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   2,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -14,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   2,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -14,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record23
        ANIM_RECORD 22
        .structSpriteEntry ( -21,  -30), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry ( -37,  -30), $21, SpriteLarge, $044, 2, 2, false, false
        .structSpriteEntry (   7,  -27), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  15,  -11), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   7,  -11), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   8,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   0,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -8,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -16,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   0,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -16,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   0,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -16,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record24
        ANIM_RECORD 23
        .structSpriteEntry ( -21,  -30), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry ( -37,  -30), $21, SpriteLarge, $044, 2, 2, false, false
        .structSpriteEntry (   7,  -27), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  15,  -11), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   7,  -11), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   0,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -16,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -16,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry (   0,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (   8,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   0,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -8,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -16,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (  -8,  -38), $00, SpriteSmall, $00C, 2, 0, false, false
        ANIM_RECORD_END

      _Record25
        ANIM_RECORD 18
        .structSpriteEntry (  20,  -43), $21, SpriteLarge, $040, 2, 2, true, true
        .structSpriteEntry (   4,  -43), $21, SpriteLarge, $042, 2, 2, true, true
        .structSpriteEntry ( -19,  -31), $21, SpriteLarge, $060, 2, 3, true, false
        .structSpriteEntry ( -19,  -15), $00, SpriteSmall, $063, 2, 3, true, false
        .structSpriteEntry ( -11,  -15), $00, SpriteSmall, $062, 2, 3, true, false
        .structSpriteEntry (   9,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   1,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -7,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -15,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   1,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -15,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   1,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -15,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record26
        ANIM_RECORD 24
        .structSpriteEntry (  -9,  -45), $21, SpriteLarge, $042, 2, 2, true, true
        .structSpriteEntry (   7,  -45), $21, SpriteLarge, $040, 2, 2, true, true
        .structSpriteEntry (   8,  -15), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   0,  -15), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   0,  -31), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  12,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   4,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -4,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -12,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   4,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -12,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   4,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -12,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record27
        ANIM_RECORD 25
        .structSpriteEntry ( -15,  -56), $00, SpriteSmall, $0E3, 2, 2, false, false
        .structSpriteEntry ( -23,  -56), $00, SpriteSmall, $0E2, 2, 2, false, false
        .structSpriteEntry ( -31,  -56), $00, SpriteSmall, $0E1, 2, 2, false, false
        .structSpriteEntry ( -39,  -56), $00, SpriteSmall, $0E0, 2, 2, false, false
        .structSpriteEntry (  14,  -14), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   6,  -14), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   6,  -30), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   8,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   0,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -8,  -38), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry ( -16,  -38), $00, SpriteSmall, $00B, 2, 1, false, false
        .structSpriteEntry (   0,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -16,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   0,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -16,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record28
        ANIM_RECORD 26
        .structSpriteEntry ( -40,  -35), $00, SpriteSmall, $0D0, 2, 2, false, false
        .structSpriteEntry ( -40,  -43), $00, SpriteSmall, $0C0, 2, 2, false, false
        .structSpriteEntry ( -40,  -51), $00, SpriteSmall, $0B0, 2, 2, false, false
        .structSpriteEntry ( -32,  -51), $00, SpriteSmall, $0D1, 2, 2, false, false
        .structSpriteEntry ( -32,  -59), $00, SpriteSmall, $0C1, 2, 2, false, false
        .structSpriteEntry (  14,  -14), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   6,  -14), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   6,  -30), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   8,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   0,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -8,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -16,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   0,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -16,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   0,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -16,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record29
        ANIM_RECORD 26
        .structSpriteEntry ( -27,  -15), $00, SpriteSmall, $0A2, 2, 2, false, false
        .structSpriteEntry ( -43,  -23), $21, SpriteLarge, $0C2, 2, 2, false, false
        .structSpriteEntry ( -43,  -31), $00, SpriteSmall, $0B1, 2, 2, false, false
        .structSpriteEntry ( -43,  -39), $00, SpriteSmall, $0A1, 2, 2, false, false
        .structSpriteEntry (  14,  -14), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   6,  -14), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   6,  -30), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   8,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   0,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -8,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -16,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   0,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -16,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   0,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -16,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record30
        ANIM_RECORD 26
        .structSpriteEntry ( -21,  -18), $21, SpriteLarge, $042, 2, 2, false, false
        .structSpriteEntry ( -37,  -18), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry (  14,  -14), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   6,  -14), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   6,  -30), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   8,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   0,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -8,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -16,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   0,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -16,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   0,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -16,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record31
        ANIM_RECORD 23
        .structSpriteEntry (   7,  -27), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  15,  -11), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   7,  -11), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   0,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -16,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -16,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry (   0,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (   8,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   0,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -8,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -16,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (  -8,  -38), $00, SpriteSmall, $00C, 2, 0, false, false
        ANIM_RECORD_END

      _Record32
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (  -3,  -19), $21, SpriteLarge, $042, 2, 2, false, false
        .structSpriteEntry ( -19,  -19), $21, SpriteLarge, $040, 2, 2, false, false
        ANIM_RECORD_END

      _Record33
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry ( -10,  -25), $21, SpriteLarge, $04A, 2, 2, false, true
        .structSpriteEntry ( -10,   -9), $21, SpriteLarge, $048, 2, 2, false, true
        ANIM_RECORD_END

      _Record34
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (  -6,  -25), $21, SpriteLarge, $04A, 2, 2, true, true
        .structSpriteEntry (  -6,   -9), $21, SpriteLarge, $048, 2, 2, true, true
        ANIM_RECORD_END

      _Record35
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry ( -11,  -19), $21, SpriteLarge, $042, 2, 2, true, false
        .structSpriteEntry (   5,  -19), $21, SpriteLarge, $040, 2, 2, true, false
        ANIM_RECORD_END

      _Record36
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry ( -12,  -24), $21, SpriteLarge, $046, 2, 2, true, false
        .structSpriteEntry (   4,  -24), $21, SpriteLarge, $044, 2, 2, true, false
        ANIM_RECORD_END

      _Record37
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (  -7,  -20), $21, SpriteLarge, $04E, 2, 2, false, false
        .structSpriteEntry (  -7,  -36), $21, SpriteLarge, $04C, 2, 2, false, false
        ANIM_RECORD_END

      _Record38
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (  -9,  -20), $21, SpriteLarge, $04E, 2, 2, true, false
        .structSpriteEntry (  -9,  -36), $21, SpriteLarge, $04C, 2, 2, true, false
        ANIM_RECORD_END

      _Record39
        ANIM_RECORD 21
        .structSpriteEntry (  10,  -10), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   2,  -10), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   2,  -26), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  10,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   2,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -14,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   2,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -14,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record40
        ANIM_RECORD 17
        .structSpriteEntry ( -12,  -13), $00, SpriteSmall, $063, 2, 3, true, false
        .structSpriteEntry (  -4,  -13), $00, SpriteSmall, $062, 2, 3, true, false
        .structSpriteEntry ( -12,  -29), $21, SpriteLarge, $060, 2, 3, true, false
        .structSpriteEntry (   8,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   0,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -8,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -16,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   0,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -16,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   0,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -16,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record41
        ANIM_RECORD 18
        .structSpriteEntry ( -19,  -31), $21, SpriteLarge, $060, 2, 3, true, false
        .structSpriteEntry ( -19,  -15), $00, SpriteSmall, $063, 2, 3, true, false
        .structSpriteEntry ( -11,  -15), $00, SpriteSmall, $062, 2, 3, true, false
        .structSpriteEntry (   9,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   1,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -7,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -15,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   1,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -15,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   1,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -15,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record42
        ANIM_RECORD 19
        .structSpriteEntry ( -19,  -31), $21, SpriteLarge, $060, 2, 3, true, false
        .structSpriteEntry ( -19,  -15), $00, SpriteSmall, $063, 2, 3, true, false
        .structSpriteEntry ( -11,  -15), $00, SpriteSmall, $062, 2, 3, true, false
        .structSpriteEntry (   9,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   1,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -7,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -15,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   1,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -15,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   1,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -15,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record43
        ANIM_RECORD 20
        .structSpriteEntry ( -19,  -31), $21, SpriteLarge, $060, 2, 3, true, false
        .structSpriteEntry ( -19,  -15), $00, SpriteSmall, $063, 2, 3, true, false
        .structSpriteEntry ( -11,  -15), $00, SpriteSmall, $062, 2, 3, true, false
        .structSpriteEntry ( -15,  -30), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (   1,  -30), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -15,  -14), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry (   1,  -14), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (   1,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   9,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -7,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -15,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        ANIM_RECORD_END

      aBattleAnimationFramesEmperorMagic ; 99/C0D0

        ; Frame table of entry 37: slices of the class sheet per frame.

        .word _Frame00 - aBattleAnimationFramesEmperorMagic
        .word _Frame01 - aBattleAnimationFramesEmperorMagic
        .word _Frame02 - aBattleAnimationFramesEmperorMagic
        .word _Frame03 - aBattleAnimationFramesEmperorMagic
        .word _Frame04 - aBattleAnimationFramesEmperorMagic
        .word _Frame05 - aBattleAnimationFramesEmperorMagic
        .word _Frame06 - aBattleAnimationFramesEmperorMagic
        .word _Frame07 - aBattleAnimationFramesEmperorMagic
        .word _Frame08 - aBattleAnimationFramesEmperorMagic
        .word _Frame09 - aBattleAnimationFramesEmperorMagic
        .word _Frame10 - aBattleAnimationFramesEmperorMagic
        .word _Frame11 - aBattleAnimationFramesEmperorMagic
        .word _Frame12 - aBattleAnimationFramesEmperorMagic
        .word _Frame13 - aBattleAnimationFramesEmperorMagic
        .word _Frame14 - aBattleAnimationFramesEmperorMagic
        .word _Frame15 - aBattleAnimationFramesEmperorMagic
        .word _Frame16 - aBattleAnimationFramesEmperorMagic
        .word _Frame17 - aBattleAnimationFramesEmperorMagic
        .word _Frame18 - aBattleAnimationFramesEmperorMagic
        .word _Frame19 - aBattleAnimationFramesEmperorMagic
        .word _Frame20 - aBattleAnimationFramesEmperorMagic
        .word _Frame21 - aBattleAnimationFramesEmperorMagic
        .word _Frame22 - aBattleAnimationFramesEmperorMagic
        .word _Frame23 - aBattleAnimationFramesEmperorMagic
        .word _Frame24 - aBattleAnimationFramesEmperorMagic
        .word _Frame25 - aBattleAnimationFramesEmperorMagic
        .word _Frame26 - aBattleAnimationFramesEmperorMagic

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

      _Frame08
        ANIM_TILES
        ANIM_TILE_ROW $1400, $0180
        ANIM_TILE_ROW $1580, $0100
        ANIM_TILES_END

      _Frame09
        ANIM_TILES
        ANIM_TILE_ROW $1680, $0180
        ANIM_TILE_ROW $1800, $0100
        ANIM_TILES_END

      _Frame10
        ANIM_TILES
        ANIM_TILE_ROW $1900, $0180
        ANIM_TILE_ROW $1A80, $0100
        ANIM_TILES_END

      _Frame11
        ANIM_TILES
        ANIM_TILE_ROW $1B80, $0180
        ANIM_TILE_ROW $1D00, $0100
        ANIM_TILES_END

      _Frame12
        ANIM_TILES
        ANIM_TILE_ROW $1E00, $0180
        ANIM_TILE_ROW $1F80, $0100
        ANIM_TILES_END

      _Frame13
        ANIM_TILES
        ANIM_TILE_ROW $2080, $0180
        ANIM_TILE_ROW $2200, $0100
        ANIM_TILES_END

      _Frame14
        ANIM_TILES
        ANIM_TILE_ROW $2300, $0180
        ANIM_TILE_ROW $2480, $0100
        ANIM_TILES_END

      _Frame15
        ANIM_TILES
        ANIM_TILE_ROW $2580, $01C0
        ANIM_TILE_ROW $2740, $0100
        ANIM_TILES_END

      _Frame16
        ANIM_TILES
        ANIM_TILE_ROW $2840, $0180
        ANIM_TILE_ROW $29C0, $0100
        ANIM_TILES_END

      _Frame17
        ANIM_TILES
        ANIM_TILE_ROW $2AC0, $0180
        ANIM_TILE_ROW $2C40, $0100
        ANIM_TILES_END

      _Frame18
        ANIM_TILES
        ANIM_TILE_ROW $2D40, $0180
        ANIM_TILE_ROW $2EC0, $0100
        ANIM_TILES_END

      _Frame19
        ANIM_TILES
        ANIM_TILE_ROW $2FC0, $0180
        ANIM_TILE_ROW $3140, $0100
        ANIM_TILES_END

      _Frame20
        ANIM_TILES
        ANIM_TILE_ROW $3240, $0180
        ANIM_TILE_ROW $33C0, $0100
        ANIM_TILES_END

      _Frame21
        ANIM_TILES
        ANIM_TILE_ROW $34C0, $0180
        ANIM_TILE_ROW $3640, $0100
        ANIM_TILES_END

      _Frame22
        ANIM_TILES
        ANIM_TILE_ROW $3740, $0180
        ANIM_TILE_ROW $38C0, $0100
        ANIM_TILES_END

      _Frame23
        ANIM_TILES
        ANIM_TILE_ROW $39C0, $01A0
        ANIM_TILE_ROW $3B60, $0100
        ANIM_TILES_END

      _Frame24
        ANIM_TILES
        ANIM_TILE_ROW $3C60, $0180
        ANIM_TILE_ROW $3DE0, $0100
        ANIM_TILES_END

      _Frame25
        ANIM_TILES
        ANIM_TILE_ROW $3EE0, $0180
        ANIM_TILE_ROW $4060, $0100
        ANIM_TILES_END

      _Frame26
        ANIM_TILES
        ANIM_TILE_ROW $4160, $0180
        ANIM_TILE_ROW $42E0, $0100
        ANIM_TILES_END

      aBattleAnimationSequencesEmperorMagic ; 99/C1F9

        ; Sequence data of entry 37 of aBattleAnimationFrameTables, used by: Emperor (Magic),
        ; Baron (Magic). Frames: aBattleAnimationFramesEmperorMagic.

        .word _Index - aBattleAnimationSequencesEmperorMagic, _Records - aBattleAnimationSequencesEmperorMagic

      _Index
        .word _Sequence00 - aBattleAnimationSequencesEmperorMagic
        .word _Sequence01 - aBattleAnimationSequencesEmperorMagic
        .word _Sequence02 - aBattleAnimationSequencesEmperorMagic
        .word _Sequence03 - aBattleAnimationSequencesEmperorMagic
        .word _Sequence04 - aBattleAnimationSequencesEmperorMagic
        .word _Sequence05 - aBattleAnimationSequencesEmperorMagic
        .word _Sequence06 - aBattleAnimationSequencesEmperorMagic
        .word _Sequence07 - aBattleAnimationSequencesEmperorMagic
        .word _Sequence08 - aBattleAnimationSequencesEmperorMagic
        .word _Sequence09 - aBattleAnimationSequencesEmperorMagic
        .word _Sequence10 - aBattleAnimationSequencesEmperorMagic
        .word _Sequence11 - aBattleAnimationSequencesEmperorMagic

      _Records
        .word _Record00 - aBattleAnimationSequencesEmperorMagic
        .word _Record01 - aBattleAnimationSequencesEmperorMagic
        .word _Record02 - aBattleAnimationSequencesEmperorMagic
        .word _Record03 - aBattleAnimationSequencesEmperorMagic
        .word _Record04 - aBattleAnimationSequencesEmperorMagic
        .word _Record05 - aBattleAnimationSequencesEmperorMagic
        .word _Record06 - aBattleAnimationSequencesEmperorMagic
        .word _Record07 - aBattleAnimationSequencesEmperorMagic
        .word _Record08 - aBattleAnimationSequencesEmperorMagic
        .word _Record09 - aBattleAnimationSequencesEmperorMagic
        .word _Record10 - aBattleAnimationSequencesEmperorMagic
        .word _Record11 - aBattleAnimationSequencesEmperorMagic
        .word _Record12 - aBattleAnimationSequencesEmperorMagic
        .word _Record13 - aBattleAnimationSequencesEmperorMagic
        .word _Record14 - aBattleAnimationSequencesEmperorMagic
        .word _Record15 - aBattleAnimationSequencesEmperorMagic
        .word _Record16 - aBattleAnimationSequencesEmperorMagic
        .word _Record17 - aBattleAnimationSequencesEmperorMagic
        .word _Record18 - aBattleAnimationSequencesEmperorMagic
        .word _Record19 - aBattleAnimationSequencesEmperorMagic
        .word _Record20 - aBattleAnimationSequencesEmperorMagic
        .word _Record21 - aBattleAnimationSequencesEmperorMagic
        .word _Record22 - aBattleAnimationSequencesEmperorMagic
        .word _Record23 - aBattleAnimationSequencesEmperorMagic
        .word _Record24 - aBattleAnimationSequencesEmperorMagic
        .word _Record25 - aBattleAnimationSequencesEmperorMagic
        .word _Record26 - aBattleAnimationSequencesEmperorMagic
        .word _Record27 - aBattleAnimationSequencesEmperorMagic
        .word _Record28 - aBattleAnimationSequencesEmperorMagic
        .word _Record29 - aBattleAnimationSequencesEmperorMagic
        .word _Record30 - aBattleAnimationSequencesEmperorMagic
        .word _Record31 - aBattleAnimationSequencesEmperorMagic
        .word _Record32 - aBattleAnimationSequencesEmperorMagic
        .word _Record33 - aBattleAnimationSequencesEmperorMagic
        .word _Record34 - aBattleAnimationSequencesEmperorMagic
        .word _Record35 - aBattleAnimationSequencesEmperorMagic
        .word _Record36 - aBattleAnimationSequencesEmperorMagic
        .word _Record37 - aBattleAnimationSequencesEmperorMagic
        .word _Record38 - aBattleAnimationSequencesEmperorMagic
        .word _Record39 - aBattleAnimationSequencesEmperorMagic
        .word _Record40 - aBattleAnimationSequencesEmperorMagic
        .word _Record41 - aBattleAnimationSequencesEmperorMagic
        .word _Record42 - aBattleAnimationSequencesEmperorMagic
        .word _Record43 - aBattleAnimationSequencesEmperorMagic

      _Sequence00
        ANIM_CMD_F7
        ANIM_STEP 1, 1
        ANIM_HOLD

      _Sequence01
        ANIM_SOUND 16
        ANIM_STEP 7, 5
        ANIM_STEP 3, 4
        ANIM_STEP 2, 4
        ANIM_STEP 1, 4
        ANIM_STEP 22, 6
        ANIM_SOUND 16
        ANIM_STEP 18, 9
        ANIM_STEP 19, 11
        ANIM_STEP 20, 7
        ANIM_STEP 21, 4
        ANIM_STEP 21, 1
        ANIM_CMD_F4 1
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence02
        ANIM_STEP 1, 32
        ANIM_STEP 2, 7
        ANIM_STEP 3, 7
        ANIM_STEP 4, 7
        ANIM_STEP 5, 7
        ANIM_STEP 6, 8
        ANIM_STEP 7, 19
        ANIM_STEP 8, 7
        ANIM_STEP 9, 7
        ANIM_STEP 10, 7
        ANIM_STEP 11, 7
        ANIM_STEP 12, 8
        ANIM_STEP 12, 64

      _Sequence03
        ANIM_STEP 14, 8
        ANIM_STEP 15, 7
        ANIM_SOUND 32
        ANIM_CMD_F0
        ANIM_STEP 15, 1
        ANIM_CMD_F4 1
        ANIM_STEP 16, 31
        ANIM_STEP 16, 1
        ANIM_CMD_F4 1
        ANIM_STEP 15, 5
        ANIM_STEP 14, 8
        ANIM_STEP 1, 1
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence04
        ANIM_STEP 1, 48
        ANIM_STEP 14, 3
        ANIM_STEP 15, 19
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence05
        ANIM_SOUND 16
        ANIM_STEP 22, 10
        ANIM_STEP 18, 9
        ANIM_STEP 19, 11
        ANIM_STEP 20, 7
        ANIM_STEP 21, 31
        ANIM_STEP 21, 1
        ANIM_CMD_F4 1
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence06
        ANIM_STEP 21, 5
        ANIM_SOUND 16
        ANIM_STEP 7, 3
        ANIM_STEP 3, 4
        ANIM_STEP 2, 5
        ANIM_STEP 1, 5
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence07
        ANIM_SOUND 16
        ANIM_STEP 22, 10
        ANIM_STEP 18, 9
        ANIM_STEP 19, 11
        ANIM_STEP 20, 7
        ANIM_STEP 21, 31
        ANIM_SOUND 32
        ANIM_CMD_F0 3
        ANIM_STEP 21, 1
        ANIM_CMD_F4 1
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence08
        ANIM_STEP 21, 2
        ANIM_SOUND 16
        ANIM_STEP 22, 2
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence09
        ANIM_STEP 23, 3
        ANIM_STEP 24, 3
        ANIM_CMD_F4 2
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence10
        ANIM_STEP 32, 2
        ANIM_STEP 33, 2
        ANIM_STEP 34, 2
        ANIM_STEP 35, 2
        ANIM_STEP 36, 2
        ANIM_STEP 37, 2
        ANIM_STEP 38, 2

      _Sequence11
        ANIM_SOUND 16
        ANIM_STEP 22, 7
        ANIM_STEP 16, 7
        ANIM_STEP 1, 5
        ANIM_CMD_F7
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
        .structSpriteEntry ( -20,  -43), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry ( -20,  -27), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry (   5,  -26), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  13,  -10), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   5,  -10), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   2,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -14,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   2,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -14,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (  10,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        ANIM_RECORD_END

      _Record02
        ANIM_RECORD 1
        .structSpriteEntry ( -19,  -28), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry ( -19,  -44), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry (   3,  -26), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  11,  -10), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   3,  -10), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   9,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   1,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -7,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -15,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   1,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -15,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   1,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -15,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record03
        ANIM_RECORD 2
        .structSpriteEntry ( -19,  -28), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry ( -19,  -44), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry (   3,  -26), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  11,  -10), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   3,  -10), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   9,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   1,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -7,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -15,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   1,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -15,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   1,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -15,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record04
        ANIM_RECORD 3
        .structSpriteEntry ( -19,  -28), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry ( -19,  -44), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry ( -14,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (   3,  -26), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  11,  -10), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   3,  -10), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   2,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   2,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -14,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (  10,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        ANIM_RECORD_END

      _Record05
        ANIM_RECORD 4
        .structSpriteEntry ( -19,  -27), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry ( -19,  -43), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry (   3,  -25), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  11,   -9), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   3,   -9), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry ( -14,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (   2,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   2,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -14,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (  10,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        ANIM_RECORD_END

      _Record06
        ANIM_RECORD 5
        .structSpriteEntry ( -19,  -43), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry ( -19,  -27), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry (   3,  -25), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  11,   -9), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   3,   -9), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry ( -14,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (  10,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   2,  -30), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -14,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry (   2,  -14), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record07
        ANIM_RECORD 6
        .structSpriteEntry ( -19,  -27), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry ( -19,  -43), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry ( -14,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (   3,  -25), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  11,   -9), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   3,   -9), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   2,  -30), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -14,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry (  10,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   2,  -14), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record08
        ANIM_RECORD 7
        .structSpriteEntry ( -19,  -28), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry ( -19,  -44), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry (   3,  -26), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  11,  -10), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   3,  -10), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  10,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   2,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -14,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   2,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -14,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record09
        ANIM_RECORD 8
        .structSpriteEntry ( -19,  -44), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry ( -19,  -28), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry (   3,  -26), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  11,  -10), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   3,  -10), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   2,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -14,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   2,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -14,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (  10,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        ANIM_RECORD_END

      _Record10
        ANIM_RECORD 9
        .structSpriteEntry ( -19,  -44), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry ( -19,  -28), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry (  11,  -10), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   3,  -10), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry ( -14,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (   3,  -26), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  10,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   2,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   2,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -14,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record11
        ANIM_RECORD 10
        .structSpriteEntry ( -19,  -43), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry ( -19,  -27), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry ( -14,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (   3,  -25), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  11,   -9), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   3,   -9), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  10,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   2,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   2,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -14,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record12
        ANIM_RECORD 11
        .structSpriteEntry ( -19,  -43), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry ( -19,  -27), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry ( -14,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (   3,  -25), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  11,   -9), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   3,   -9), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   2,  -30), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -14,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry (  10,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   2,  -14), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record13
        ANIM_RECORD 12
        .structSpriteEntry ( -19,  -28), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry ( -19,  -44), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry ( -14,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (   3,  -25), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  11,   -9), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   3,   -9), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   2,  -30), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -14,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry (  10,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   2,  -14), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record14
        ANIM_RECORD 13
        .structSpriteEntry (  13,  -12), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   5,  -12), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   5,  -28), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry ( -21,  -28), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry ( -21,  -44), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry (  10,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry ( -14,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (   2,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   2,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry (  -6,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry ( -14,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record15
        ANIM_RECORD 14
        .structSpriteEntry (   4,  -30), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  12,  -14), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   4,  -14), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry ( -15,  -29), $21, SpriteLarge, $04E, 2, 2, false, false
        .structSpriteEntry ( -15,  -45), $21, SpriteLarge, $04C, 2, 2, false, false
        .structSpriteEntry (  10,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry ( -14,  -30), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (   2,  -30), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   2,  -14), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -14,  -14), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record16
        ANIM_RECORD 15
        .structSpriteEntry (  11,  -14), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   3,  -14), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   3,  -30), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry ( -21,  -33), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry ( -37,  -33), $21, SpriteLarge, $044, 2, 2, false, false
        .structSpriteEntry (  10,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry ( -22,  -30), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (  -6,  -30), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (  10,  -22), $00, SpriteSmall, $00C, 2, 0, false, false
        .structSpriteEntry (  10,  -30), $00, SpriteSmall, $00D, 2, 0, false, false
        .structSpriteEntry (   2,  -14), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -14,  -14), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record17
        ANIM_RECORD 16
        .structSpriteEntry (   1,  -29), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   9,  -13), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   1,  -13), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  13,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   5,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -3,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -11,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   5,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -11,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   5,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -11,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry ( -12,  -23), $21, SpriteLarge, $042, 2, 2, false, false
        .structSpriteEntry ( -28,  -23), $21, SpriteLarge, $040, 2, 2, false, false
        ANIM_RECORD_END

      _Record18
        ANIM_RECORD 17
        .structSpriteEntry ( -12,  -13), $00, SpriteSmall, $063, 2, 3, true, false
        .structSpriteEntry (  -4,  -13), $00, SpriteSmall, $062, 2, 3, true, false
        .structSpriteEntry ( -12,  -29), $21, SpriteLarge, $060, 2, 3, true, false
        .structSpriteEntry (   8,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   0,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -8,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -16,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   0,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -16,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   0,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -16,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (  -9,  -34), $21, SpriteLarge, $042, 2, 2, false, true
        .structSpriteEntry ( -25,  -34), $21, SpriteLarge, $040, 2, 2, false, true
        ANIM_RECORD_END

      _Record19
        ANIM_RECORD 18
        .structSpriteEntry ( -19,  -31), $21, SpriteLarge, $060, 2, 3, true, false
        .structSpriteEntry ( -19,  -15), $00, SpriteSmall, $063, 2, 3, true, false
        .structSpriteEntry ( -11,  -15), $00, SpriteSmall, $062, 2, 3, true, false
        .structSpriteEntry (   9,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   1,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -7,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -15,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   1,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -15,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   1,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -15,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (   2,  -43), $21, SpriteLarge, $042, 2, 2, false, true
        .structSpriteEntry ( -14,  -43), $21, SpriteLarge, $040, 2, 2, false, true
        ANIM_RECORD_END

      _Record20
        ANIM_RECORD 19
        .structSpriteEntry ( -19,  -31), $21, SpriteLarge, $060, 2, 3, true, false
        .structSpriteEntry ( -19,  -15), $00, SpriteSmall, $063, 2, 3, true, false
        .structSpriteEntry ( -11,  -15), $00, SpriteSmall, $062, 2, 3, true, false
        .structSpriteEntry (   9,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   1,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -7,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -15,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   1,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -15,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   1,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -15,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (   2,  -43), $21, SpriteLarge, $042, 2, 2, false, true
        .structSpriteEntry ( -14,  -43), $21, SpriteLarge, $040, 2, 2, false, true
        ANIM_RECORD_END

      _Record21
        ANIM_RECORD 20
        .structSpriteEntry ( -19,  -31), $21, SpriteLarge, $060, 2, 3, true, false
        .structSpriteEntry ( -19,  -15), $00, SpriteSmall, $063, 2, 3, true, false
        .structSpriteEntry ( -11,  -15), $00, SpriteSmall, $062, 2, 3, true, false
        .structSpriteEntry ( -15,  -30), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (   1,  -30), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -15,  -14), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry (   1,  -14), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (   1,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   9,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -7,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -15,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   2,  -43), $21, SpriteLarge, $042, 2, 2, false, true
        .structSpriteEntry ( -14,  -43), $21, SpriteLarge, $040, 2, 2, false, true
        ANIM_RECORD_END

      _Record22
        ANIM_RECORD 21
        .structSpriteEntry ( -14,  -29), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry ( -30,  -29), $21, SpriteLarge, $044, 2, 2, false, false
        .structSpriteEntry (  10,  -10), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   2,  -10), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   2,  -26), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  10,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   2,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -14,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   2,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -14,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record23
        ANIM_RECORD 22
        .structSpriteEntry ( -21,  -30), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry ( -37,  -30), $21, SpriteLarge, $044, 2, 2, false, false
        .structSpriteEntry (   7,  -27), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  15,  -11), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   7,  -11), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   8,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   0,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -8,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -16,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   0,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -16,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   0,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -16,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record24
        ANIM_RECORD 23
        .structSpriteEntry ( -21,  -30), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry ( -37,  -30), $21, SpriteLarge, $044, 2, 2, false, false
        .structSpriteEntry (   7,  -27), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  15,  -11), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   7,  -11), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   0,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -16,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -16,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry (   0,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (   8,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   0,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -8,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -16,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (  -8,  -38), $00, SpriteSmall, $00C, 2, 0, false, false
        ANIM_RECORD_END

      _Record25
        ANIM_RECORD 18
        .structSpriteEntry (  20,  -43), $21, SpriteLarge, $040, 2, 2, true, true
        .structSpriteEntry (   4,  -43), $21, SpriteLarge, $042, 2, 2, true, true
        .structSpriteEntry ( -19,  -31), $21, SpriteLarge, $060, 2, 3, true, false
        .structSpriteEntry ( -19,  -15), $00, SpriteSmall, $063, 2, 3, true, false
        .structSpriteEntry ( -11,  -15), $00, SpriteSmall, $062, 2, 3, true, false
        .structSpriteEntry (   9,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   1,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -7,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -15,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   1,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -15,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   1,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -15,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record26
        ANIM_RECORD 24
        .structSpriteEntry (  -9,  -45), $21, SpriteLarge, $042, 2, 2, true, true
        .structSpriteEntry (   7,  -45), $21, SpriteLarge, $040, 2, 2, true, true
        .structSpriteEntry (   8,  -15), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   0,  -15), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   0,  -31), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  12,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   4,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -4,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -12,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   4,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -12,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   4,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -12,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record27
        ANIM_RECORD 25
        .structSpriteEntry ( -15,  -56), $00, SpriteSmall, $0E3, 2, 2, false, false
        .structSpriteEntry ( -23,  -56), $00, SpriteSmall, $0E2, 2, 2, false, false
        .structSpriteEntry ( -31,  -56), $00, SpriteSmall, $0E1, 2, 2, false, false
        .structSpriteEntry ( -39,  -56), $00, SpriteSmall, $0E0, 2, 2, false, false
        .structSpriteEntry (  14,  -14), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   6,  -14), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   6,  -30), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   8,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   0,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -8,  -38), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry ( -16,  -38), $00, SpriteSmall, $00B, 2, 1, false, false
        .structSpriteEntry (   0,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -16,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   0,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -16,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record28
        ANIM_RECORD 26
        .structSpriteEntry ( -40,  -35), $00, SpriteSmall, $0D0, 2, 2, false, false
        .structSpriteEntry ( -40,  -43), $00, SpriteSmall, $0C0, 2, 2, false, false
        .structSpriteEntry ( -40,  -51), $00, SpriteSmall, $0B0, 2, 2, false, false
        .structSpriteEntry ( -32,  -51), $00, SpriteSmall, $0D1, 2, 2, false, false
        .structSpriteEntry ( -32,  -59), $00, SpriteSmall, $0C1, 2, 2, false, false
        .structSpriteEntry (  14,  -14), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   6,  -14), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   6,  -30), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   8,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   0,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -8,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -16,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   0,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -16,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   0,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -16,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record29
        ANIM_RECORD 26
        .structSpriteEntry ( -27,  -15), $00, SpriteSmall, $0A2, 2, 2, false, false
        .structSpriteEntry ( -43,  -23), $21, SpriteLarge, $0C2, 2, 2, false, false
        .structSpriteEntry ( -43,  -31), $00, SpriteSmall, $0B1, 2, 2, false, false
        .structSpriteEntry ( -43,  -39), $00, SpriteSmall, $0A1, 2, 2, false, false
        .structSpriteEntry (  14,  -14), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   6,  -14), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   6,  -30), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   8,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   0,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -8,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -16,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   0,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -16,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   0,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -16,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record30
        ANIM_RECORD 26
        .structSpriteEntry ( -21,  -18), $21, SpriteLarge, $042, 2, 2, false, false
        .structSpriteEntry ( -37,  -18), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry (  14,  -14), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   6,  -14), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   6,  -30), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   8,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   0,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -8,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -16,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   0,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -16,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   0,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -16,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record31
        ANIM_RECORD 23
        .structSpriteEntry (   7,  -27), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  15,  -11), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   7,  -11), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   0,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -16,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -16,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry (   0,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (   8,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   0,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -8,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -16,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (  -8,  -38), $00, SpriteSmall, $00C, 2, 0, false, false
        ANIM_RECORD_END

      _Record32
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (  -3,  -19), $21, SpriteLarge, $042, 2, 2, false, false
        .structSpriteEntry ( -19,  -19), $21, SpriteLarge, $040, 2, 2, false, false
        ANIM_RECORD_END

      _Record33
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry ( -10,  -25), $21, SpriteLarge, $04A, 2, 2, false, true
        .structSpriteEntry ( -10,   -9), $21, SpriteLarge, $048, 2, 2, false, true
        ANIM_RECORD_END

      _Record34
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (  -6,  -25), $21, SpriteLarge, $04A, 2, 2, true, true
        .structSpriteEntry (  -6,   -9), $21, SpriteLarge, $048, 2, 2, true, true
        ANIM_RECORD_END

      _Record35
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry ( -11,  -19), $21, SpriteLarge, $042, 2, 2, true, false
        .structSpriteEntry (   5,  -19), $21, SpriteLarge, $040, 2, 2, true, false
        ANIM_RECORD_END

      _Record36
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry ( -12,  -24), $21, SpriteLarge, $046, 2, 2, true, false
        .structSpriteEntry (   4,  -24), $21, SpriteLarge, $044, 2, 2, true, false
        ANIM_RECORD_END

      _Record37
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (  -7,  -20), $21, SpriteLarge, $04E, 2, 2, false, false
        .structSpriteEntry (  -7,  -36), $21, SpriteLarge, $04C, 2, 2, false, false
        ANIM_RECORD_END

      _Record38
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (  -9,  -20), $21, SpriteLarge, $04E, 2, 2, true, false
        .structSpriteEntry (  -9,  -36), $21, SpriteLarge, $04C, 2, 2, true, false
        ANIM_RECORD_END

      _Record39
        ANIM_RECORD 21
        .structSpriteEntry (  10,  -10), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   2,  -10), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   2,  -26), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  10,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -6,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   2,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -14,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   2,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -14,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record40
        ANIM_RECORD 17
        .structSpriteEntry ( -12,  -13), $00, SpriteSmall, $063, 2, 3, true, false
        .structSpriteEntry (  -4,  -13), $00, SpriteSmall, $062, 2, 3, true, false
        .structSpriteEntry ( -12,  -29), $21, SpriteLarge, $060, 2, 3, true, false
        .structSpriteEntry (   8,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   0,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -8,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -16,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   0,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -16,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   0,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -16,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record41
        ANIM_RECORD 18
        .structSpriteEntry ( -19,  -31), $21, SpriteLarge, $060, 2, 3, true, false
        .structSpriteEntry ( -19,  -15), $00, SpriteSmall, $063, 2, 3, true, false
        .structSpriteEntry ( -11,  -15), $00, SpriteSmall, $062, 2, 3, true, false
        .structSpriteEntry (   9,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   1,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -7,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -15,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   1,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -15,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   1,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -15,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record42
        ANIM_RECORD 19
        .structSpriteEntry ( -19,  -31), $21, SpriteLarge, $060, 2, 3, true, false
        .structSpriteEntry ( -19,  -15), $00, SpriteSmall, $063, 2, 3, true, false
        .structSpriteEntry ( -11,  -15), $00, SpriteSmall, $062, 2, 3, true, false
        .structSpriteEntry (   9,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   1,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -7,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -15,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   1,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -15,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   1,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -15,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record43
        ANIM_RECORD 20
        .structSpriteEntry ( -19,  -31), $21, SpriteLarge, $060, 2, 3, true, false
        .structSpriteEntry ( -19,  -15), $00, SpriteSmall, $063, 2, 3, true, false
        .structSpriteEntry ( -11,  -15), $00, SpriteSmall, $062, 2, 3, true, false
        .structSpriteEntry ( -15,  -30), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (   1,  -30), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -15,  -14), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry (   1,  -14), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (   1,  -38), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   9,  -38), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -7,  -38), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -15,  -38), $00, SpriteSmall, $00B, 2, 0, false, false
        ANIM_RECORD_END

      aBattleAnimationFramesBallisticianBow ; 99/CD42

        ; Frame table of entry 43: slices of the class sheet per frame.

        .word _Frame00 - aBattleAnimationFramesBallisticianBow
        .word _Frame01 - aBattleAnimationFramesBallisticianBow
        .word _Frame02 - aBattleAnimationFramesBallisticianBow

      _Frame00
        ANIM_TILES
        ANIM_TILE_ROW $0000, $0160
        ANIM_TILE_ROW $0160, $0100
        ANIM_TILES_END

      _Frame01
        ANIM_TILES
        ANIM_TILE_ROW $0260, $0120
        ANIM_TILE_ROW $0380, $00C0
        ANIM_TILES_END

      _Frame02
        ANIM_TILES
        ANIM_TILE_ROW $0440, $0120
        ANIM_TILE_ROW $0560, $0100
        ANIM_TILES_END

      aBattleAnimationSequencesBallisticianBow ; 99/CD63

        ; Sequence data of entry 43 of aBattleAnimationFrameTables, used by: Ballistician (Bow),
        ; IronBallistician (Bow), KillerBallistician (Bow), GreatBallistician (Bow). Frames:
        ; aBattleAnimationFramesBallisticianBow.

        .word _Index - aBattleAnimationSequencesBallisticianBow, _Records - aBattleAnimationSequencesBallisticianBow

      _Index
        .word _Sequence00 - aBattleAnimationSequencesBallisticianBow
        .word _Sequence01 - aBattleAnimationSequencesBallisticianBow
        .word _Sequence02 - aBattleAnimationSequencesBallisticianBow
        .word _Sequence03 - aBattleAnimationSequencesBallisticianBow
        .word _Sequence04 - aBattleAnimationSequencesBallisticianBow

      _Records
        .word _Record00 - aBattleAnimationSequencesBallisticianBow
        .word _Record01 - aBattleAnimationSequencesBallisticianBow
        .word _Record02 - aBattleAnimationSequencesBallisticianBow
        .word _Record03 - aBattleAnimationSequencesBallisticianBow
        .word _Record04 - aBattleAnimationSequencesBallisticianBow
        .word _Record05 - aBattleAnimationSequencesBallisticianBow
        .word _Record06 - aBattleAnimationSequencesBallisticianBow
        .word _Record07 - aBattleAnimationSequencesBallisticianBow

      _Sequence00
        ANIM_STEP 1, 1
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence01
        ANIM_STEP 1, 16
        ANIM_SOUND 13
        ANIM_STEP 4, 1
        ANIM_STEP 5, 5
        ANIM_CMD_EF 195
        ANIM_SOUND 14
        ANIM_STEP 2, 1
        ANIM_STEP 2, 1
        ANIM_STEP 3, 2
        ANIM_STEP 2, 2
        ANIM_STEP 3, 2
        ANIM_STEP 2, 2
        ANIM_STEP 3, 2
        ANIM_STEP 2, 2
        ANIM_STEP 3, 2
        ANIM_STEP 2, 2
        ANIM_STEP 3, 16
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence02
        ANIM_STEP 1, 1
        ANIM_CMD_F4 1
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence03
        ANIM_STEP 6, 1
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence04
        ANIM_STEP 7, 1
        ANIM_CMD_F7
        ANIM_HOLD

      _Record00
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (  16,   -3), $00, SpriteSmall, $0F1, 2, 3, false, false
        .structSpriteEntry (   8,   -3), $00, SpriteSmall, $0F1, 2, 3, false, false
        .structSpriteEntry (   0,   -3), $00, SpriteSmall, $0F1, 2, 3, false, false
        .structSpriteEntry (  -8,   -3), $00, SpriteSmall, $0F1, 2, 3, false, false
        .structSpriteEntry ( -24,   -3), $00, SpriteSmall, $0F1, 2, 3, false, false
        .structSpriteEntry ( -16,   -3), $00, SpriteSmall, $0F1, 2, 3, false, false
        .structSpriteEntry (  24,   -3), $00, SpriteSmall, $0F1, 2, 3, false, false
        .structSpriteEntry (  32,   -3), $00, SpriteSmall, $0F2, 2, 3, false, false
        .structSpriteEntry ( -32,   -3), $00, SpriteSmall, $0F1, 2, 3, false, false
        .structSpriteEntry ( -40,   -3), $00, SpriteSmall, $0F0, 2, 3, false, false
        ANIM_RECORD_END

      _Record01
        ANIM_RECORD 0
        .structSpriteEntry (  10,   -7), $00, SpriteSmall, $0BC, 2, 1, false, false
        .structSpriteEntry (  -6,  -15), $21, SpriteLarge, $0AA, 2, 1, false, false
        .structSpriteEntry ( -22,  -31), $21, SpriteLarge, $088, 2, 1, false, false
        .structSpriteEntry ( -38,  -31), $21, SpriteLarge, $086, 2, 1, false, false
        .structSpriteEntry ( -38,  -15), $21, SpriteLarge, $0A6, 2, 1, false, false
        .structSpriteEntry ( -22,  -15), $21, SpriteLarge, $0A8, 2, 1, false, false
        .structSpriteEntry (  -4,  -31), $21, SpriteLarge, $0BE, 2, 1, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $0BD, 2, 1, false, false
        .structSpriteEntry (  -4,  -47), $21, SpriteLarge, $09E, 2, 1, false, false
        .structSpriteEntry ( -20,  -47), $21, SpriteLarge, $09C, 2, 1, false, false
        .structSpriteEntry (  -6,  -31), $21, SpriteLarge, $08A, 2, 1, false, false
        .structSpriteEntry (  29,   -7), $00, SpriteSmall, $0B2, 2, 0, false, false
        .structSpriteEntry (  29,  -15), $00, SpriteSmall, $0A2, 2, 0, false, false
        .structSpriteEntry (  29,  -23), $00, SpriteSmall, $092, 2, 0, false, false
        .structSpriteEntry (  29,  -31), $00, SpriteSmall, $082, 2, 0, false, false
        .structSpriteEntry (  13,  -15), $21, SpriteLarge, $0A0, 2, 0, false, false
        .structSpriteEntry (  13,  -31), $21, SpriteLarge, $080, 2, 0, false, false
        .structSpriteEntry (   5,  -39), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry ( -10,  -23), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -18,  -23), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry ( -10,  -39), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -26,  -39), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry ( -10,  -55), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -26,  -55), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -32,  -54), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry (   6,  -20), $21, SpriteLarge, $0E3, 2, 1, false, false
        ANIM_RECORD_END

      _Record02
        ANIM_RECORD 1
        .structSpriteEntry (  21,  -20), $21, SpriteLarge, $0C6, 2, 1, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $0BD, 2, 1, false, false
        .structSpriteEntry (  -4,  -31), $21, SpriteLarge, $0BE, 2, 1, false, false
        .structSpriteEntry (  -4,  -47), $21, SpriteLarge, $09E, 2, 1, false, false
        .structSpriteEntry ( -20,  -47), $21, SpriteLarge, $09C, 2, 1, false, false
        .structSpriteEntry (  10,   -7), $00, SpriteSmall, $0BC, 2, 1, false, false
        .structSpriteEntry (  -6,  -31), $21, SpriteLarge, $08A, 2, 1, false, false
        .structSpriteEntry ( -22,  -31), $21, SpriteLarge, $088, 2, 1, false, false
        .structSpriteEntry ( -22,  -15), $21, SpriteLarge, $0A8, 2, 1, false, false
        .structSpriteEntry ( -38,  -15), $21, SpriteLarge, $0A6, 2, 1, false, false
        .structSpriteEntry ( -38,  -31), $21, SpriteLarge, $086, 2, 1, false, false
        .structSpriteEntry ( -22,  -58), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (  -6,  -42), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry (  -6,  -50), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry (  -6,  -58), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry ( -22,  -26), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry ( -22,  -42), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry (  22,  -17), $00, SpriteSmall, $0C2, 2, 0, false, false
        .structSpriteEntry (  19,  -31), $21, SpriteLarge, $0C0, 2, 0, false, false
        .structSpriteEntry (  22,  -15), $21, SpriteLarge, $0A4, 2, 0, false, false
        .structSpriteEntry (  14,   -7), $00, SpriteSmall, $0B3, 2, 0, false, false
        .structSpriteEntry (  14,  -15), $00, SpriteSmall, $0A3, 2, 0, false, false
        .structSpriteEntry (  -6,  -15), $21, SpriteLarge, $0AA, 2, 1, false, false
        .structSpriteEntry (   5,  -20), $21, SpriteLarge, $0C4, 2, 1, false, false
        ANIM_RECORD_END

      _Record03
        ANIM_RECORD 2
        .structSpriteEntry (  21,  -20), $21, SpriteLarge, $0C6, 2, 1, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $0BD, 2, 1, false, false
        .structSpriteEntry (  -4,  -31), $21, SpriteLarge, $0BE, 2, 1, false, false
        .structSpriteEntry (  -4,  -47), $21, SpriteLarge, $09E, 2, 1, false, false
        .structSpriteEntry ( -20,  -47), $21, SpriteLarge, $09C, 2, 1, false, false
        .structSpriteEntry (  10,   -7), $00, SpriteSmall, $0BC, 2, 1, false, false
        .structSpriteEntry (  -6,  -31), $21, SpriteLarge, $08A, 2, 1, false, false
        .structSpriteEntry ( -22,  -31), $21, SpriteLarge, $088, 2, 1, false, false
        .structSpriteEntry (  -6,  -15), $21, SpriteLarge, $0AA, 2, 1, false, false
        .structSpriteEntry ( -22,  -15), $21, SpriteLarge, $0A8, 2, 1, false, false
        .structSpriteEntry ( -38,  -15), $21, SpriteLarge, $0A6, 2, 1, false, false
        .structSpriteEntry ( -38,  -31), $21, SpriteLarge, $086, 2, 1, false, false
        .structSpriteEntry (  -6,  -42), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry (  -6,  -58), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -22,  -26), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry ( -22,  -42), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -22,  -58), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry (  22,  -17), $00, SpriteSmall, $0C2, 2, 0, false, false
        .structSpriteEntry (  22,  -15), $21, SpriteLarge, $0A4, 2, 0, false, false
        .structSpriteEntry (  14,   -7), $00, SpriteSmall, $0B3, 2, 0, false, false
        .structSpriteEntry (  14,  -15), $00, SpriteSmall, $0A3, 2, 0, false, false
        .structSpriteEntry (  19,  -31), $21, SpriteLarge, $0C0, 2, 0, false, false
        .structSpriteEntry (   5,  -20), $21, SpriteLarge, $0C4, 2, 1, false, false
        ANIM_RECORD_END

      _Record04
        ANIM_RECORD 0
        .structSpriteEntry (  -6,  -15), $21, SpriteLarge, $0AA, 2, 1, false, false
        .structSpriteEntry (  22,  -15), $21, SpriteLarge, $0A4, 2, 0, false, false
        .structSpriteEntry (  22,  -31), $21, SpriteLarge, $084, 2, 0, false, false
        .structSpriteEntry (  14,   -7), $00, SpriteSmall, $0B3, 2, 0, false, false
        .structSpriteEntry (  14,  -15), $00, SpriteSmall, $0A3, 2, 0, false, false
        .structSpriteEntry (  14,  -23), $00, SpriteSmall, $093, 2, 0, false, false
        .structSpriteEntry (  14,  -31), $00, SpriteSmall, $083, 2, 0, false, false
        .structSpriteEntry (  -4,  -31), $21, SpriteLarge, $0BE, 2, 1, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $0BD, 2, 1, false, false
        .structSpriteEntry (  -4,  -47), $21, SpriteLarge, $09E, 2, 1, false, false
        .structSpriteEntry ( -20,  -47), $21, SpriteLarge, $09C, 2, 1, false, false
        .structSpriteEntry (  10,   -7), $00, SpriteSmall, $0BC, 2, 1, false, false
        .structSpriteEntry ( -22,  -15), $21, SpriteLarge, $0A8, 2, 1, false, false
        .structSpriteEntry (  -6,  -31), $21, SpriteLarge, $08A, 2, 1, false, false
        .structSpriteEntry ( -22,  -31), $21, SpriteLarge, $088, 2, 1, false, false
        .structSpriteEntry ( -38,  -31), $21, SpriteLarge, $086, 2, 1, false, false
        .structSpriteEntry ( -38,  -15), $21, SpriteLarge, $0A6, 2, 1, false, false
        .structSpriteEntry (   5,  -39), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry ( -10,  -23), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -18,  -23), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry ( -10,  -39), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -26,  -39), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry ( -10,  -55), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -26,  -55), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -32,  -54), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry (   6,  -19), $21, SpriteLarge, $0E6, 2, 1, false, false
        ANIM_RECORD_END

      _Record05
        ANIM_RECORD 0
        .structSpriteEntry (  21,  -20), $21, SpriteLarge, $0C6, 2, 1, false, false
        .structSpriteEntry (  -4,  -47), $21, SpriteLarge, $09E, 2, 1, false, false
        .structSpriteEntry ( -20,  -47), $21, SpriteLarge, $09C, 2, 1, false, false
        .structSpriteEntry (  -4,  -31), $21, SpriteLarge, $0BE, 2, 1, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $0BD, 2, 1, false, false
        .structSpriteEntry (  10,   -7), $00, SpriteSmall, $0BC, 2, 1, false, false
        .structSpriteEntry (  -6,  -15), $21, SpriteLarge, $0AA, 2, 1, false, false
        .structSpriteEntry ( -22,  -15), $21, SpriteLarge, $0A8, 2, 1, false, false
        .structSpriteEntry ( -38,  -15), $21, SpriteLarge, $0A6, 2, 1, false, false
        .structSpriteEntry (  -6,  -31), $21, SpriteLarge, $08A, 2, 1, false, false
        .structSpriteEntry ( -22,  -31), $21, SpriteLarge, $088, 2, 1, false, false
        .structSpriteEntry ( -38,  -31), $21, SpriteLarge, $086, 2, 1, false, false
        .structSpriteEntry (   5,  -39), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry ( -10,  -23), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -18,  -23), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry ( -10,  -39), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -26,  -39), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry ( -10,  -55), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -26,  -55), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry (  22,  -17), $00, SpriteSmall, $0C2, 2, 0, false, false
        .structSpriteEntry (  19,  -31), $21, SpriteLarge, $0C0, 2, 0, false, false
        .structSpriteEntry (  22,  -15), $21, SpriteLarge, $0A4, 2, 0, false, false
        .structSpriteEntry (  14,   -7), $00, SpriteSmall, $0B3, 2, 0, false, false
        .structSpriteEntry (  14,  -15), $00, SpriteSmall, $0A3, 2, 0, false, false
        .structSpriteEntry ( -32,  -54), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry (   5,  -20), $21, SpriteLarge, $0C4, 2, 1, false, false
        ANIM_RECORD_END

      _Record06
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (   8,    0), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry (  -8,    0), $21, SpriteLarge, $044, 2, 2, false, false
        .structSpriteEntry (  -8,  -16), $21, SpriteLarge, $042, 2, 2, false, false
        .structSpriteEntry ( -24,  -16), $21, SpriteLarge, $040, 2, 2, false, false
        ANIM_RECORD_END

      _Record07
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (   8,  -16), $21, SpriteLarge, $046, 2, 2, false, true
        .structSpriteEntry (  -8,  -16), $21, SpriteLarge, $044, 2, 2, false, true
        .structSpriteEntry (  -8,    0), $21, SpriteLarge, $042, 2, 2, false, true
        .structSpriteEntry ( -24,    0), $21, SpriteLarge, $040, 2, 2, false, true
        ANIM_RECORD_END

      aBattleAnimationFramesBarbarianAxe ; 99/D0A4

        ; Frame table of entries 39, 40: slices of the class sheet per frame.

        .word _Frame00 - aBattleAnimationFramesBarbarianAxe
        .word _Frame01 - aBattleAnimationFramesBarbarianAxe
        .word _Frame02 - aBattleAnimationFramesBarbarianAxe
        .word _Frame03 - aBattleAnimationFramesBarbarianAxe
        .word _Frame04 - aBattleAnimationFramesBarbarianAxe
        .word _Frame05 - aBattleAnimationFramesBarbarianAxe
        .word _Frame06 - aBattleAnimationFramesBarbarianAxe
        .word _Frame07 - aBattleAnimationFramesBarbarianAxe
        .word _Frame08 - aBattleAnimationFramesBarbarianAxe
        .word _Frame09 - aBattleAnimationFramesBarbarianAxe
        .word _Frame10 - aBattleAnimationFramesBarbarianAxe
        .word _Frame11 - aBattleAnimationFramesBarbarianAxe
        .word _Frame12 - aBattleAnimationFramesBarbarianAxe
        .word _Frame13 - aBattleAnimationFramesBarbarianAxe
        .word _Frame14 - aBattleAnimationFramesBarbarianAxe
        .word _Frame15 - aBattleAnimationFramesBarbarianAxe
        .word _Frame16 - aBattleAnimationFramesBarbarianAxe
        .word _Frame17 - aBattleAnimationFramesBarbarianAxe
        .word _Frame18 - aBattleAnimationFramesBarbarianAxe
        .word _Frame19 - aBattleAnimationFramesBarbarianAxe
        .word _Frame20 - aBattleAnimationFramesBarbarianAxe
        .word _Frame21 - aBattleAnimationFramesBarbarianAxe
        .word _Frame22 - aBattleAnimationFramesBarbarianAxe
        .word _Frame23 - aBattleAnimationFramesBarbarianAxe
        .word _Frame24 - aBattleAnimationFramesBarbarianAxe
        .word _Frame25 - aBattleAnimationFramesBarbarianAxe
        .word _Frame26 - aBattleAnimationFramesBarbarianAxe
        .word _Frame27 - aBattleAnimationFramesBarbarianAxe
        .word _Frame28 - aBattleAnimationFramesBarbarianAxe
        .word _Frame29 - aBattleAnimationFramesBarbarianAxe
        .word _Frame30 - aBattleAnimationFramesBarbarianAxe
        .word _Frame31 - aBattleAnimationFramesBarbarianAxe
        .word _Frame32 - aBattleAnimationFramesBarbarianAxe

      _Frame00
        ANIM_TILES
        ANIM_TILE_ROW $0000, $0100
        ANIM_TILE_ROW $0100, $0100
        ANIM_TILES_END

      _Frame01
        ANIM_TILES
        ANIM_TILE_ROW $0200, $0100
        ANIM_TILE_ROW $0300, $0080
        ANIM_TILES_END

      _Frame02
        ANIM_TILES
        ANIM_TILE_ROW $0380, $0160
        ANIM_TILE_ROW $04E0, $0080
        ANIM_TILES_END

      _Frame03
        ANIM_TILES
        ANIM_TILE_ROW $0560, $0100
        ANIM_TILE_ROW $0660, $0100
        ANIM_TILES_END

      _Frame04
        ANIM_TILES
        ANIM_TILE_ROW $0760, $0120
        ANIM_TILE_ROW $0880, $0080
        ANIM_TILES_END

      _Frame05
        ANIM_TILES
        ANIM_TILE_ROW $0900, $0100
        ANIM_TILE_ROW $0A00, $0100
        ANIM_TILES_END

      _Frame06
        ANIM_TILES
        ANIM_TILE_ROW $0B00, $0100
        ANIM_TILE_ROW $0C00, $0100
        ANIM_TILES_END

      _Frame07
        ANIM_TILES
        ANIM_TILE_ROW $0D00, $0140
        ANIM_TILE_ROW $0E40, $0040
        ANIM_TILES_END

      _Frame08
        ANIM_TILES
        ANIM_TILE_ROW $0E80, $0100
        ANIM_TILE_ROW $0F80, $0080
        ANIM_TILES_END

      _Frame09
        ANIM_TILES
        ANIM_TILE_ROW $1000, $0100
        ANIM_TILE_ROW $1100, $0100
        ANIM_TILES_END

      _Frame10
        ANIM_TILES
        ANIM_TILE_ROW $1200, $0100
        ANIM_TILE_ROW $1300, $0080
        ANIM_TILES_END

      _Frame11
        ANIM_TILES
        ANIM_TILE_ROW $1380, $0100
        ANIM_TILE_ROW $1480, $00C0
        ANIM_TILES_END

      _Frame12
        ANIM_TILES
        ANIM_TILE_ROW $1540, $0100
        ANIM_TILE_ROW $1640, $0100
        ANIM_TILES_END

      _Frame13
        ANIM_TILES
        ANIM_TILE_ROW $1740, $0100
        ANIM_TILE_ROW $1840, $0100
        ANIM_TILES_END

      _Frame14
        ANIM_TILES
        ANIM_TILE_ROW $1940, $0100
        ANIM_TILE_ROW $1A40, $0100
        ANIM_TILES_END

      _Frame15
        ANIM_TILES
        ANIM_TILE_ROW $1B40, $0100
        ANIM_TILE_ROW $1C40, $0100
        ANIM_TILES_END

      _Frame16
        ANIM_TILES
        ANIM_TILE_ROW $1D40, $0100
        ANIM_TILE_ROW $1E40, $0100
        ANIM_TILES_END

      _Frame17
        ANIM_TILES
        ANIM_TILE_ROW $1F40, $0100
        ANIM_TILE_ROW $2040, $0080
        ANIM_TILES_END

      _Frame18
        ANIM_TILES
        ANIM_TILE_ROW $20C0, $00E0
        ANIM_TILE_ROW $21A0, $0080
        ANIM_TILES_END

      _Frame19
        ANIM_TILES
        ANIM_TILE_ROW $2220, $00E0
        ANIM_TILE_ROW $2300, $00C0
        ANIM_TILES_END

      _Frame20
        ANIM_TILES
        ANIM_TILE_ROW $23C0, $0100
        ANIM_TILE_ROW $24C0, $0080
        ANIM_TILES_END

      _Frame21
        ANIM_TILES
        ANIM_TILE_ROW $2540, $00C0
        ANIM_TILE_ROW $2600, $0080
        ANIM_TILES_END

      _Frame22
        ANIM_TILES
        ANIM_TILE_ROW $2680, $00C0
        ANIM_TILE_ROW $2740, $0080
        ANIM_TILES_END

      _Frame23
        ANIM_TILES
        ANIM_TILE_ROW $27C0, $0100
        ANIM_TILE_ROW $28C0, $0080
        ANIM_TILES_END

      _Frame24
        ANIM_TILES
        ANIM_TILE_ROW $2940, $00C0
        ANIM_TILE_ROW $2A00, $0080
        ANIM_TILES_END

      _Frame25
        ANIM_TILES
        ANIM_TILE_ROW $2A80, $0120
        ANIM_TILE_ROW $2BA0, $0080
        ANIM_TILES_END

      _Frame26
        ANIM_TILES
        ANIM_TILE_ROW $2C20, $0140
        ANIM_TILE_ROW $2D60, $0100
        ANIM_TILES_END

      _Frame27
        ANIM_TILES
        ANIM_TILE_ROW $2E60, $00E0
        ANIM_TILE_ROW $2F40, $0080
        ANIM_TILES_END

      _Frame28
        ANIM_TILES
        ANIM_TILE_ROW $2FC0, $0100
        ANIM_TILE_ROW $30C0, $0080
        ANIM_TILES_END

      _Frame29
        ANIM_TILES
        ANIM_TILE_ROW $3140, $0100
        ANIM_TILE_ROW $3240, $0100
        ANIM_TILES_END

      _Frame30
        ANIM_TILES
        ANIM_TILE_ROW $3340, $0160
        ANIM_TILE_ROW $34A0, $0080
        ANIM_TILES_END

      _Frame31
        ANIM_TILES
        ANIM_TILE_ROW $3520, $0100
        ANIM_TILE_ROW $3620, $0100
        ANIM_TILES_END

      _Frame32
        ANIM_TILES
        ANIM_TILE_ROW $3720, $0140
        ANIM_TILE_ROW $3860, $0080
        ANIM_TILES_END

      aBattleAnimationSequencesBarbarianAxe ; 99/D20F

        ; Sequence data of entry 39 of aBattleAnimationFrameTables, used by: Barbarian (Axe),
        ; Fighter (Axe), Brigand (Axe), Warrior (Axe), Pirate (Axe). Frames:
        ; aBattleAnimationFramesBarbarianAxe.

        .word _Index - aBattleAnimationSequencesBarbarianAxe, _Records - aBattleAnimationSequencesBarbarianAxe

      _Index
        .word _Sequence00 - aBattleAnimationSequencesBarbarianAxe
        .word _Sequence01 - aBattleAnimationSequencesBarbarianAxe
        .word _Sequence02 - aBattleAnimationSequencesBarbarianAxe
        .word _Sequence03 - aBattleAnimationSequencesBarbarianAxe
        .word _Sequence04 - aBattleAnimationSequencesBarbarianAxe
        .word _Sequence05 - aBattleAnimationSequencesBarbarianAxe
        .word _Sequence06 - aBattleAnimationSequencesBarbarianAxe
        .word _Sequence07 - aBattleAnimationSequencesBarbarianAxe
        .word _Sequence08 - aBattleAnimationSequencesBarbarianAxe
        .word _Sequence09 - aBattleAnimationSequencesBarbarianAxe
        .word _Sequence10 - aBattleAnimationSequencesBarbarianAxe
        .word _Sequence11 - aBattleAnimationSequencesBarbarianAxe
        .word _Sequence12 - aBattleAnimationSequencesBarbarianAxe
        .word _Sequence13 - aBattleAnimationSequencesBarbarianAxe
        .word _Sequence14 - aBattleAnimationSequencesBarbarianAxe
        .word _Sequence15 - aBattleAnimationSequencesBarbarianAxe
        .word _Sequence16 - aBattleAnimationSequencesBarbarianAxe
        .word _Sequence17 - aBattleAnimationSequencesBarbarianAxe
        .word _Sequence18 - aBattleAnimationSequencesBarbarianAxe
        .word _Sequence19 - aBattleAnimationSequencesBarbarianAxe
        .word _Sequence20 - aBattleAnimationSequencesBarbarianAxe

      _Records
        .word aBattleAnimationSequencesBarbarianRangedAxe._Record00 - aBattleAnimationSequencesBarbarianAxe
        .word aBattleAnimationSequencesBarbarianRangedAxe._Record01 - aBattleAnimationSequencesBarbarianAxe
        .word aBattleAnimationSequencesBarbarianRangedAxe._Record02 - aBattleAnimationSequencesBarbarianAxe
        .word aBattleAnimationSequencesBarbarianRangedAxe._Record03 - aBattleAnimationSequencesBarbarianAxe
        .word aBattleAnimationSequencesBarbarianRangedAxe._Record04 - aBattleAnimationSequencesBarbarianAxe
        .word aBattleAnimationSequencesBarbarianRangedAxe._Record05 - aBattleAnimationSequencesBarbarianAxe
        .word aBattleAnimationSequencesBarbarianRangedAxe._Record06 - aBattleAnimationSequencesBarbarianAxe
        .word aBattleAnimationSequencesBarbarianRangedAxe._Record07 - aBattleAnimationSequencesBarbarianAxe
        .word aBattleAnimationSequencesBarbarianRangedAxe._Record08 - aBattleAnimationSequencesBarbarianAxe
        .word aBattleAnimationSequencesBarbarianRangedAxe._Record09 - aBattleAnimationSequencesBarbarianAxe
        .word aBattleAnimationSequencesBarbarianRangedAxe._Record10 - aBattleAnimationSequencesBarbarianAxe
        .word aBattleAnimationSequencesBarbarianRangedAxe._Record11 - aBattleAnimationSequencesBarbarianAxe
        .word aBattleAnimationSequencesBarbarianRangedAxe._Record12 - aBattleAnimationSequencesBarbarianAxe
        .word aBattleAnimationSequencesBarbarianRangedAxe._Record13 - aBattleAnimationSequencesBarbarianAxe
        .word aBattleAnimationSequencesBarbarianRangedAxe._Record14 - aBattleAnimationSequencesBarbarianAxe
        .word aBattleAnimationSequencesBarbarianRangedAxe._Record15 - aBattleAnimationSequencesBarbarianAxe
        .word aBattleAnimationSequencesBarbarianRangedAxe._Record16 - aBattleAnimationSequencesBarbarianAxe
        .word aBattleAnimationSequencesBarbarianRangedAxe._Record17 - aBattleAnimationSequencesBarbarianAxe
        .word aBattleAnimationSequencesBarbarianRangedAxe._Record18 - aBattleAnimationSequencesBarbarianAxe
        .word aBattleAnimationSequencesBarbarianRangedAxe._Record19 - aBattleAnimationSequencesBarbarianAxe
        .word aBattleAnimationSequencesBarbarianRangedAxe._Record20 - aBattleAnimationSequencesBarbarianAxe
        .word aBattleAnimationSequencesBarbarianRangedAxe._Record21 - aBattleAnimationSequencesBarbarianAxe
        .word aBattleAnimationSequencesBarbarianRangedAxe._Record22 - aBattleAnimationSequencesBarbarianAxe
        .word aBattleAnimationSequencesBarbarianRangedAxe._Record23 - aBattleAnimationSequencesBarbarianAxe
        .word aBattleAnimationSequencesBarbarianRangedAxe._Record24 - aBattleAnimationSequencesBarbarianAxe
        .word aBattleAnimationSequencesBarbarianRangedAxe._Record25 - aBattleAnimationSequencesBarbarianAxe
        .word aBattleAnimationSequencesBarbarianRangedAxe._Record26 - aBattleAnimationSequencesBarbarianAxe
        .word aBattleAnimationSequencesBarbarianRangedAxe._Record27 - aBattleAnimationSequencesBarbarianAxe
        .word aBattleAnimationSequencesBarbarianRangedAxe._Record28 - aBattleAnimationSequencesBarbarianAxe
        .word aBattleAnimationSequencesBarbarianRangedAxe._Record29 - aBattleAnimationSequencesBarbarianAxe
        .word aBattleAnimationSequencesBarbarianRangedAxe._Record30 - aBattleAnimationSequencesBarbarianAxe
        .word aBattleAnimationSequencesBarbarianRangedAxe._Record31 - aBattleAnimationSequencesBarbarianAxe
        .word aBattleAnimationSequencesBarbarianRangedAxe._Record32 - aBattleAnimationSequencesBarbarianAxe
        .word aBattleAnimationSequencesBarbarianRangedAxe._Record33 - aBattleAnimationSequencesBarbarianAxe
        .word aBattleAnimationSequencesBarbarianRangedAxe._Record34 - aBattleAnimationSequencesBarbarianAxe
        .word aBattleAnimationSequencesBarbarianRangedAxe._Record35 - aBattleAnimationSequencesBarbarianAxe
        .word aBattleAnimationSequencesBarbarianRangedAxe._Record36 - aBattleAnimationSequencesBarbarianAxe
        .word aBattleAnimationSequencesBarbarianRangedAxe._Record37 - aBattleAnimationSequencesBarbarianAxe
        .word aBattleAnimationSequencesBarbarianRangedAxe._Record38 - aBattleAnimationSequencesBarbarianAxe
        .word aBattleAnimationSequencesBarbarianRangedAxe._Record39 - aBattleAnimationSequencesBarbarianAxe
        .word aBattleAnimationSequencesBarbarianRangedAxe._Record40 - aBattleAnimationSequencesBarbarianAxe
        .word aBattleAnimationSequencesBarbarianRangedAxe._Record41 - aBattleAnimationSequencesBarbarianAxe
        .word aBattleAnimationSequencesBarbarianRangedAxe._Record42 - aBattleAnimationSequencesBarbarianAxe
        .word aBattleAnimationSequencesBarbarianRangedAxe._Record43 - aBattleAnimationSequencesBarbarianAxe
        .word aBattleAnimationSequencesBarbarianRangedAxe._Record44 - aBattleAnimationSequencesBarbarianAxe
        .word aBattleAnimationSequencesBarbarianRangedAxe._Record45 - aBattleAnimationSequencesBarbarianAxe
        .word aBattleAnimationSequencesBarbarianRangedAxe._Record46 - aBattleAnimationSequencesBarbarianAxe
        .word aBattleAnimationSequencesBarbarianRangedAxe._Record47 - aBattleAnimationSequencesBarbarianAxe
        .word aBattleAnimationSequencesBarbarianRangedAxe._Record48 - aBattleAnimationSequencesBarbarianAxe
        .word aBattleAnimationSequencesBarbarianRangedAxe._Record49 - aBattleAnimationSequencesBarbarianAxe

      _Sequence00
        ANIM_CMD_F7
        ANIM_STEP 1, 2
        ANIM_HOLD

      _Sequence01
        ANIM_STEP 1, 8
        ANIM_STEP 9, 26
        ANIM_STEP 1, 2
        ANIM_CMD_F4 0
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence02
        ANIM_SOUND 28
        ANIM_STEP 1, 2
        ANIM_STEP 16, 4
        ANIM_STEP 17, 4
        ANIM_STEP 18, 4
        ANIM_SOUND 28
        ANIM_STEP 19, 4
        ANIM_STEP 18, 4
        ANIM_STEP 1, 10
        ANIM_CMD_F4 0
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence03
        ANIM_STEP 6, 5
        ANIM_STEP 1, 2
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence04
        ANIM_CMD_EB
        ANIM_CMD_F7
        ANIM_SOUND 28
        ANIM_STEP 16, 7
        ANIM_STEP 17, 7
        ANIM_SOUND 28
        ANIM_STEP 18, 7
        ANIM_STEP 19, 7
        ANIM_RESTART
        ANIM_HOLD

      _Sequence05
        ANIM_STEP 1, 10
        ANIM_STEP 2, 5
        ANIM_STEP 3, 6
        ANIM_CMD_EE
        ANIM_STEP 3, 10
        ANIM_STEP 20, 2
        ANIM_STEP 4, 2
        ANIM_STEP 5, 2
        ANIM_SOUND 0
        ANIM_CMD_F1
        ANIM_STEP 6, 10
        ANIM_CMD_F3
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence06
        ANIM_CMD_EB
        ANIM_CMD_F7
        ANIM_SOUND 17
        ANIM_STEP 10, 7
        ANIM_STEP 11, 7
        ANIM_STEP 12, 7
        ANIM_SOUND 17
        ANIM_STEP 13, 7
        ANIM_STEP 14, 7
        ANIM_STEP 15, 7
        ANIM_RESTART
        ANIM_HOLD

      _Sequence07
        ANIM_STEP 22, 3
        ANIM_STEP 23, 4
        ANIM_STEP 24, 4
        ANIM_STEP 25, 3
        ANIM_STEP 26, 3
        ANIM_STEP 27, 3
        ANIM_CMD_EE
        ANIM_STEP 28, 7
        ANIM_STEP 29, 2
        ANIM_STEP 30, 2
        ANIM_STEP 31, 4
        ANIM_SOUND 0
        ANIM_CMD_F1
        ANIM_STEP 31, 10
        ANIM_CMD_F3
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence08
        ANIM_STEP 1, 9
        ANIM_STEP 12, 5
        ANIM_STEP 21, 31
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence09
        ANIM_STEP 39, 6
        ANIM_STEP 46, 2
        ANIM_STEP 40, 16
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence10
        ANIM_STEP 7, 7
        ANIM_STEP 1, 10
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence11
        ANIM_CMD_F7
        ANIM_SOUND 23
        ANIM_STEP 34, 18
        ANIM_STEP 35, 7
        ANIM_CMD_EE
        ANIM_STEP 35, 9
        ANIM_STEP 36, 3
        ANIM_STEP 37, 3
        ANIM_CMD_F1
        ANIM_SOUND 0
        ANIM_STEP 38, 3
        ANIM_CMD_F3
        ANIM_HOLD

      _Sequence12
        ANIM_STEP 38, 7
        ANIM_STEP 38, 12
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence13
        ANIM_SOUND 23
        ANIM_STEP 34, 16
        ANIM_CMD_EE
        ANIM_STEP 35, 16
        ANIM_STEP 36, 3
        ANIM_STEP 37, 3
        ANIM_CMD_F1
        ANIM_SOUND 0
        ANIM_STEP 38, 1
        ANIM_CMD_F3
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence14
        ANIM_STEP 38, 24
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence15
        ANIM_CMD_EC 1
        ANIM_STEP 34, 16
        ANIM_STEP 35, 16
        ANIM_CMD_EE
        ANIM_STEP 36, 3
        ANIM_STEP 37, 3
        ANIM_SOUND 0
        ANIM_CMD_F1
        ANIM_STEP 38, 1
        ANIM_CMD_EC 0
        ANIM_CMD_F3
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence16
        ANIM_STEP 9, 0
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence17
        ANIM_CMD_EB
        ANIM_STEP 42, 1
        ANIM_STEP 43, 1
        ANIM_STEP 44, 1
        ANIM_STEP 45, 1
        ANIM_STEP 46, 1
        ANIM_STEP 49, 1
        ANIM_STEP 51, 1 ; record 51: past the end of the list, never read in fe4.cdl
        ANIM_STEP 50, 1 ; record 50: past the end of the list, never read in fe4.cdl
        ANIM_RESTART
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence18
        ANIM_CMD_EB
        ANIM_CMD_F7
        ANIM_STEP 22, 2
        ANIM_STEP 23, 2
        ANIM_STEP 24, 2
        ANIM_STEP 25, 2
        ANIM_STEP 26, 2
        ANIM_RESTART
        ANIM_HOLD

      _Sequence19
        ANIM_STEP 40, 6
        ANIM_STEP 39, 2
        ANIM_STEP 40, 6
        ANIM_STEP 39, 2
        ANIM_STEP 40, 6
        ANIM_STEP 39, 2
        ANIM_STEP 40, 6
        ANIM_STEP 39, 5
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence20
        ANIM_STEP 32, 16
        ANIM_CMD_EF 145
        ANIM_SOUND 12
        ANIM_STEP 33, 2
        ANIM_CMD_F4 1
        ANIM_STEP 33, 0
        ANIM_CMD_F7
        ANIM_HOLD

      aBattleAnimationSequencesBarbarianRangedAxe ; 99/D407

        ; Sequence data of entry 40 of aBattleAnimationFrameTables, used by: Barbarian
        ; (RangedAxe), Fighter (RangedAxe), Brigand (RangedAxe), Warrior (RangedAxe), Pirate
        ; (RangedAxe). Frames: aBattleAnimationFramesBarbarianAxe.

        .word _Index - aBattleAnimationSequencesBarbarianRangedAxe, _Records - aBattleAnimationSequencesBarbarianRangedAxe

      _Index
        .word _Sequence00 - aBattleAnimationSequencesBarbarianRangedAxe
        .word _Sequence01 - aBattleAnimationSequencesBarbarianRangedAxe
        .word _Sequence02 - aBattleAnimationSequencesBarbarianRangedAxe
        .word _Sequence03 - aBattleAnimationSequencesBarbarianRangedAxe
        .word _Sequence04 - aBattleAnimationSequencesBarbarianRangedAxe
        .word _Sequence05 - aBattleAnimationSequencesBarbarianRangedAxe
        .word _Sequence06 - aBattleAnimationSequencesBarbarianRangedAxe
        .word _Sequence07 - aBattleAnimationSequencesBarbarianRangedAxe

      _Records
        .word _Record00 - aBattleAnimationSequencesBarbarianRangedAxe
        .word _Record01 - aBattleAnimationSequencesBarbarianRangedAxe
        .word _Record02 - aBattleAnimationSequencesBarbarianRangedAxe
        .word _Record03 - aBattleAnimationSequencesBarbarianRangedAxe
        .word _Record04 - aBattleAnimationSequencesBarbarianRangedAxe
        .word _Record05 - aBattleAnimationSequencesBarbarianRangedAxe
        .word _Record06 - aBattleAnimationSequencesBarbarianRangedAxe
        .word _Record07 - aBattleAnimationSequencesBarbarianRangedAxe
        .word _Record08 - aBattleAnimationSequencesBarbarianRangedAxe
        .word _Record09 - aBattleAnimationSequencesBarbarianRangedAxe
        .word _Record10 - aBattleAnimationSequencesBarbarianRangedAxe
        .word _Record11 - aBattleAnimationSequencesBarbarianRangedAxe
        .word _Record12 - aBattleAnimationSequencesBarbarianRangedAxe
        .word _Record13 - aBattleAnimationSequencesBarbarianRangedAxe
        .word _Record14 - aBattleAnimationSequencesBarbarianRangedAxe
        .word _Record15 - aBattleAnimationSequencesBarbarianRangedAxe
        .word _Record16 - aBattleAnimationSequencesBarbarianRangedAxe
        .word _Record17 - aBattleAnimationSequencesBarbarianRangedAxe
        .word _Record18 - aBattleAnimationSequencesBarbarianRangedAxe
        .word _Record19 - aBattleAnimationSequencesBarbarianRangedAxe
        .word _Record20 - aBattleAnimationSequencesBarbarianRangedAxe
        .word _Record21 - aBattleAnimationSequencesBarbarianRangedAxe
        .word _Record22 - aBattleAnimationSequencesBarbarianRangedAxe
        .word _Record23 - aBattleAnimationSequencesBarbarianRangedAxe
        .word _Record24 - aBattleAnimationSequencesBarbarianRangedAxe
        .word _Record25 - aBattleAnimationSequencesBarbarianRangedAxe
        .word _Record26 - aBattleAnimationSequencesBarbarianRangedAxe
        .word _Record27 - aBattleAnimationSequencesBarbarianRangedAxe
        .word _Record28 - aBattleAnimationSequencesBarbarianRangedAxe
        .word _Record29 - aBattleAnimationSequencesBarbarianRangedAxe
        .word _Record30 - aBattleAnimationSequencesBarbarianRangedAxe
        .word _Record31 - aBattleAnimationSequencesBarbarianRangedAxe
        .word _Record32 - aBattleAnimationSequencesBarbarianRangedAxe
        .word _Record33 - aBattleAnimationSequencesBarbarianRangedAxe
        .word _Record34 - aBattleAnimationSequencesBarbarianRangedAxe
        .word _Record35 - aBattleAnimationSequencesBarbarianRangedAxe
        .word _Record36 - aBattleAnimationSequencesBarbarianRangedAxe
        .word _Record37 - aBattleAnimationSequencesBarbarianRangedAxe
        .word _Record38 - aBattleAnimationSequencesBarbarianRangedAxe
        .word _Record39 - aBattleAnimationSequencesBarbarianRangedAxe
        .word _Record40 - aBattleAnimationSequencesBarbarianRangedAxe
        .word _Record41 - aBattleAnimationSequencesBarbarianRangedAxe
        .word _Record42 - aBattleAnimationSequencesBarbarianRangedAxe
        .word _Record43 - aBattleAnimationSequencesBarbarianRangedAxe
        .word _Record44 - aBattleAnimationSequencesBarbarianRangedAxe
        .word _Record45 - aBattleAnimationSequencesBarbarianRangedAxe
        .word _Record46 - aBattleAnimationSequencesBarbarianRangedAxe
        .word _Record47 - aBattleAnimationSequencesBarbarianRangedAxe
        .word _Record48 - aBattleAnimationSequencesBarbarianRangedAxe
        .word _Record49 - aBattleAnimationSequencesBarbarianRangedAxe

      _Sequence00
        ANIM_CMD_F7
        ANIM_STEP 1, 1
        ANIM_HOLD

      _Sequence01
        ANIM_STEP 1, 15
        ANIM_STEP 9, 19
        ANIM_STEP 1, 1
        ANIM_CMD_F4 1
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence02
        ANIM_STEP 1, 8
        ANIM_SOUND 28
        ANIM_STEP 16, 5
        ANIM_STEP 17, 5
        ANIM_SOUND 28
        ANIM_STEP 18, 5
        ANIM_STEP 19, 5
        ANIM_STEP 18, 5
        ANIM_STEP 1, 1
        ANIM_CMD_F4 1
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence03
        ANIM_STEP 1, 16
        ANIM_STEP 32, 16
        ANIM_CMD_EE
        ANIM_CMD_EF 133
        ANIM_STEP 33, 1
        ANIM_CMD_F4 1
        ANIM_STEP 32, 16
        ANIM_STEP 1, 16
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence04
        ANIM_STEP 1, 16
        ANIM_STEP 32, 16
        ANIM_CMD_EE
        ANIM_CMD_EF 133
        ANIM_SOUND 12
        ANIM_STEP 33, 1
        ANIM_CMD_F4 1
        ANIM_STEP 32, 16
        ANIM_STEP 1, 0
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence05
        ANIM_CMD_EB
        ANIM_STEP 41, 2
        ANIM_STEP 42, 2
        ANIM_STEP 43, 2
        ANIM_STEP 44, 2
        ANIM_STEP 45, 2
        ANIM_STEP 47, 2
        ANIM_STEP 49, 2
        ANIM_STEP 48, 2
        ANIM_RESTART
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence06
        ANIM_CMD_F7
        ANIM_STEP 1, 32
        ANIM_HOLD

      _Sequence07
        ANIM_STEP 1, 1
        ANIM_CMD_F7
        ANIM_HOLD

      _Record00
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (   0,   -2), $00, SpriteSmall, $0F1, 2, 3, false, false
        .structSpriteEntry (   8,   -2), $00, SpriteSmall, $0F2, 2, 3, false, false
        .structSpriteEntry (  -8,   -2), $00, SpriteSmall, $0F1, 2, 3, false, false
        .structSpriteEntry ( -16,   -2), $00, SpriteSmall, $0F0, 2, 3, false, false
        ANIM_RECORD_END

      _Record01
        ANIM_RECORD 0
        .structSpriteEntry ( -23,  -19), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry ( -23,  -35), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry (   0,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -16,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   0,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -16,  -31), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record02
        ANIM_RECORD 1
        .structSpriteEntry ( -22,  -25), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry ( -22,  -41), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   4,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   4,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   4,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record03
        ANIM_RECORD 2
        .structSpriteEntry ( -10,  -46), $21, SpriteLarge, $042, 2, 2, true, true
        .structSpriteEntry (   6,  -46), $21, SpriteLarge, $040, 2, 2, true, true
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (  12,   -7), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   4,  -14), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   4,  -22), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry (   4,  -30), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -12,  -23), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -12,  -39), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record04
        ANIM_RECORD 3
        .structSpriteEntry ( -44,  -41), $21, SpriteLarge, $080, 2, 2, false, false
        .structSpriteEntry (   3,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -13,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   3,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -13,  -31), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record05
        ANIM_RECORD 3
        .structSpriteEntry ( -43,   -9), $21, SpriteLarge, $0C0, 2, 2, false, false
        .structSpriteEntry ( -43,  -25), $21, SpriteLarge, $0A0, 2, 2, false, false
        .structSpriteEntry (   3,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -13,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   3,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -13,  -31), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record06
        ANIM_RECORD 3
        .structSpriteEntry ( -11,  -10), $21, SpriteLarge, $042, 2, 2, false, false
        .structSpriteEntry ( -27,  -10), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry (   3,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -13,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   3,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -13,  -31), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record07
        ANIM_RECORD 4
        .structSpriteEntry ( -23,  -17), $21, SpriteLarge, $042, 2, 2, false, false
        .structSpriteEntry ( -39,  -17), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry (   5,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (  -3,   -7), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry ( -11,   -7), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (  -3,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -11,  -31), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (  -3,  -23), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -19,  -23), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record08
        ANIM_RECORD 0
        .structSpriteEntry ( -23,  -19), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry ( -23,  -35), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry (   0,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -16,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   0,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -16,  -31), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record09
        ANIM_RECORD 5
        .structSpriteEntry (  -5,  -38), $21, SpriteLarge, $042, 2, 2, true, true
        .structSpriteEntry (  11,  -38), $21, SpriteLarge, $040, 2, 2, true, true
        .structSpriteEntry (   0,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -16,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   0,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -16,  -31), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record10
        ANIM_RECORD 6
        .structSpriteEntry ( -16,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -16,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -12,  -24), $21, SpriteLarge, $04E, 2, 2, false, false
        .structSpriteEntry ( -12,  -40), $21, SpriteLarge, $04C, 2, 2, false, false
        .structSpriteEntry (   0,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry (   0,  -15), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record11
        ANIM_RECORD 7
        .structSpriteEntry (  -8,  -31), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (  -8,   -7), $00, SpriteSmall, $002, 2, 0, false, false
        .structSpriteEntry ( -11,  -25), $21, SpriteLarge, $04E, 2, 2, false, false
        .structSpriteEntry ( -11,  -41), $21, SpriteLarge, $04C, 2, 2, false, false
        .structSpriteEntry ( -16,  -23), $00, SpriteSmall, $003, 2, 0, false, false
        .structSpriteEntry ( -16,  -31), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   8,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   8,   -7), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   0,  -15), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry (  -8,  -15), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   0,   -7), $00, SpriteSmall, $009, 2, 0, false, false
        ANIM_RECORD_END

      _Record12
        ANIM_RECORD 8
        .structSpriteEntry ( -16,  -31), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (   0,  -31), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   0,  -23), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry ( -10,  -26), $21, SpriteLarge, $04E, 2, 2, false, false
        .structSpriteEntry ( -10,  -42), $21, SpriteLarge, $04C, 2, 2, false, false
        .structSpriteEntry (   0,   -7), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   0,  -15), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -16,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record13
        ANIM_RECORD 9
        .structSpriteEntry ( -16,  -31), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -10,  -26), $21, SpriteLarge, $04E, 2, 2, false, false
        .structSpriteEntry ( -10,  -42), $21, SpriteLarge, $04C, 2, 2, false, false
        .structSpriteEntry (   0,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -16,  -15), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry (   0,  -31), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record14
        ANIM_RECORD 10
        .structSpriteEntry ( -16,  -31), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (   0,  -23), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry ( -10,  -25), $21, SpriteLarge, $04E, 2, 2, false, false
        .structSpriteEntry ( -10,  -41), $21, SpriteLarge, $04C, 2, 2, false, false
        .structSpriteEntry (   8,   -7), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   8,  -15), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (  -8,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   0,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        ANIM_RECORD_END

      _Record15
        ANIM_RECORD 11
        .structSpriteEntry ( -16,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -16,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -11,  -25), $21, SpriteLarge, $04E, 2, 2, false, false
        .structSpriteEntry ( -11,  -41), $21, SpriteLarge, $04C, 2, 2, false, false
        .structSpriteEntry (   0,  -15), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry (   0,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   0,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        ANIM_RECORD_END

      _Record16
        ANIM_RECORD 12
        .structSpriteEntry ( -26,  -21), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry ( -26,  -37), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry (   0,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -16,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   0,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -16,  -31), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record17
        ANIM_RECORD 13
        .structSpriteEntry ( -23,  -19), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry ( -23,  -35), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry (   0,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -16,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   0,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -16,  -31), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record18
        ANIM_RECORD 14
        .structSpriteEntry ( -21,  -18), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry ( -21,  -34), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry (   0,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -16,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   0,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -16,  -31), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record19
        ANIM_RECORD 15
        .structSpriteEntry ( -23,  -19), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry ( -23,  -35), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry (   0,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -16,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   0,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -16,  -31), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record20
        ANIM_RECORD 3
        .structSpriteEntry ( -15,  -53), $21, SpriteLarge, $084, 2, 2, false, false
        .structSpriteEntry ( -31,  -53), $21, SpriteLarge, $082, 2, 2, false, false
        .structSpriteEntry (   3,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -13,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   3,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -13,  -31), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record21
        ANIM_RECORD 16
        .structSpriteEntry (   2,  -31), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -14,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   4,  -33), $21, SpriteLarge, $046, 2, 2, true, false
        .structSpriteEntry (  20,  -33), $21, SpriteLarge, $044, 2, 2, true, false
        .structSpriteEntry ( -14,  -15), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry (   2,  -15), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record22
        ANIM_RECORD 17
        .structSpriteEntry (   1,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   1,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   1,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   1,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -15,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -15,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record23
        ANIM_RECORD 18
        .structSpriteEntry (  -6,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -14,  -15), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry ( -14,  -23), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry ( -14,  -31), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (  -6,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record24
        ANIM_RECORD 19
        .structSpriteEntry ( -14,  -31), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (  -6,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -14,  -15), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   2,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        ANIM_RECORD_END

      _Record25
        ANIM_RECORD 20
        .structSpriteEntry (   6,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   6,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   6,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   6,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -10,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -10,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record26
        ANIM_RECORD 21
        .structSpriteEntry ( -14,  -23), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry ( -14,  -31), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (  -6,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (  -6,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record27
        ANIM_RECORD 22
        .structSpriteEntry ( -10,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -10,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   6,  -23), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   6,  -31), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   0,  -34), $21, SpriteLarge, $046, 2, 2, true, true
        .structSpriteEntry (  16,  -34), $21, SpriteLarge, $044, 2, 2, true, true
        ANIM_RECORD_END

      _Record28
        ANIM_RECORD 23
        .structSpriteEntry ( -10,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -10,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (  -2,  -39), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   6,  -23), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   6,  -31), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   6,  -39), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry (  -2,  -39), $21, SpriteLarge, $046, 2, 2, true, true
        .structSpriteEntry (  14,  -39), $21, SpriteLarge, $044, 2, 2, true, true
        ANIM_RECORD_END

      _Record29
        ANIM_RECORD 24
        .structSpriteEntry ( -19,  -48), $00, SpriteSmall, $085, 2, 2, false, false
        .structSpriteEntry ( -27,  -48), $00, SpriteSmall, $084, 2, 2, false, false
        .structSpriteEntry ( -35,  -48), $00, SpriteSmall, $083, 2, 2, false, false
        .structSpriteEntry ( -43,  -48), $00, SpriteSmall, $082, 2, 2, false, false
        .structSpriteEntry ( -43,  -40), $21, SpriteLarge, $092, 2, 2, false, false
        .structSpriteEntry (   0,  -23), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (  -8,  -23), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   0,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -16,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record30
        ANIM_RECORD 24
        .structSpriteEntry ( -28,  -13), $21, SpriteLarge, $0D4, 2, 2, false, false
        .structSpriteEntry ( -44,  -13), $21, SpriteLarge, $0D2, 2, 2, false, false
        .structSpriteEntry ( -44,  -29), $21, SpriteLarge, $0B2, 2, 2, false, false
        .structSpriteEntry (   0,  -23), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (  -8,  -23), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   0,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -16,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record31
        ANIM_RECORD 24
        .structSpriteEntry (   0,  -23), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (  -8,  -23), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   0,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -16,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -18,  -14), $21, SpriteLarge, $042, 2, 2, false, false
        .structSpriteEntry ( -34,  -14), $21, SpriteLarge, $040, 2, 2, false, false
        ANIM_RECORD_END

      _Record32
        ANIM_RECORD 25
        .structSpriteEntry ( -12,  -31), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (   4,  -23), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry ( -20,   -7), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   4,  -15), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry (   4,  -31), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (  -3,  -39), $21, SpriteLarge, $042, 2, 2, false, true
        .structSpriteEntry ( -19,  -39), $21, SpriteLarge, $040, 2, 2, false, true
        ANIM_RECORD_END

      _Record33
        ANIM_RECORD 26
        .structSpriteEntry ( -24,  -23), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry ( -24,  -31), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (   0,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -16,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   0,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -16,  -31), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record34
        ANIM_RECORD 27
        .structSpriteEntry (   5,   -3), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   5,  -11), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   5,  -35), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry ( -11,  -19), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -11,  -35), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (  -5,  -38), $21, SpriteLarge, $046, 2, 2, true, true
        .structSpriteEntry (  11,  -38), $21, SpriteLarge, $044, 2, 2, true, true
        ANIM_RECORD_END

      _Record35
        ANIM_RECORD 28
        .structSpriteEntry (   7,   -1), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   7,   -9), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   7,  -25), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   7,  -33), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry (  -9,  -17), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (  -9,  -33), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (  -1,  -29), $21, SpriteLarge, $046, 2, 2, true, true
        .structSpriteEntry (  15,  -29), $21, SpriteLarge, $044, 2, 2, true, true
        ANIM_RECORD_END

      _Record36
        ANIM_RECORD 29
        .structSpriteEntry ( -41,  -48), $00, SpriteSmall, $082, 2, 2, false, false
        .structSpriteEntry ( -41,  -40), $21, SpriteLarge, $092, 2, 2, false, false
        .structSpriteEntry ( -18,  -48), $00, SpriteSmall, $085, 2, 2, false, false
        .structSpriteEntry ( -25,  -48), $00, SpriteSmall, $084, 2, 2, false, false
        .structSpriteEntry ( -33,  -48), $00, SpriteSmall, $083, 2, 2, false, false
        .structSpriteEntry ( -14,  -27), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (   2,  -11), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -14,  -11), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry (   2,  -27), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record37
        ANIM_RECORD 29
        .structSpriteEntry ( -26,  -10), $21, SpriteLarge, $0D4, 2, 2, false, false
        .structSpriteEntry ( -42,  -10), $21, SpriteLarge, $0D2, 2, 2, false, false
        .structSpriteEntry ( -42,  -26), $21, SpriteLarge, $0B2, 2, 2, false, false
        .structSpriteEntry ( -14,  -27), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (   2,  -11), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -14,  -11), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry (   2,  -27), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record38
        ANIM_RECORD 29
        .structSpriteEntry ( -14,  -27), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (   2,  -11), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -14,  -11), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry (   2,  -27), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry ( -18,  -12), $21, SpriteLarge, $042, 2, 2, false, false
        .structSpriteEntry ( -34,  -12), $21, SpriteLarge, $040, 2, 2, false, false
        ANIM_RECORD_END

      _Record39
        ANIM_RECORD 30
        .structSpriteEntry ( -11,  -47), $21, SpriteLarge, $04C, 2, 2, false, false
        .structSpriteEntry ( -11,  -31), $21, SpriteLarge, $04E, 2, 2, false, false
        .structSpriteEntry (   0,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   8,  -31), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   0,  -31), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (  -8,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry (  -8,   -7), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   0,  -23), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -16,  -23), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   8,   -7), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry ( -16,   -7), $00, SpriteSmall, $00A, 2, 0, false, false
        ANIM_RECORD_END

      _Record40
        ANIM_RECORD 31
        .structSpriteEntry ( -23,  -23), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry ( -23,  -39), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry (   0,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -16,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   0,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -16,  -31), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record41
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (  -3,  -27), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry ( -19,  -27), $21, SpriteLarge, $044, 2, 2, false, false
        ANIM_RECORD_END

      _Record42
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (  -3,  -23), $21, SpriteLarge, $042, 2, 2, false, false
        .structSpriteEntry ( -19,  -23), $21, SpriteLarge, $040, 2, 2, false, false
        ANIM_RECORD_END

      _Record43
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry ( -10,  -30), $21, SpriteLarge, $04A, 2, 2, false, true
        .structSpriteEntry ( -10,  -14), $21, SpriteLarge, $048, 2, 2, false, true
        ANIM_RECORD_END

      _Record44
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (  -6,  -30), $21, SpriteLarge, $04E, 2, 2, false, true
        .structSpriteEntry (  -6,  -14), $21, SpriteLarge, $04C, 2, 2, false, true
        ANIM_RECORD_END

      _Record45
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry ( -13,  -23), $21, SpriteLarge, $042, 2, 2, true, false
        .structSpriteEntry (   3,  -23), $21, SpriteLarge, $040, 2, 2, true, false
        ANIM_RECORD_END

      _Record46
        ANIM_RECORD 32
        .structSpriteEntry ( -16,  -28), $21, SpriteLarge, $04E, 2, 2, false, false
        .structSpriteEntry ( -16,  -44), $21, SpriteLarge, $04C, 2, 2, false, false
        .structSpriteEntry (   0,  -31), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (  -8,  -31), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   0,  -23), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -16,  -23), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   0,   -7), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (  -8,   -7), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry (   8,   -7), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry ( -16,   -7), $00, SpriteSmall, $009, 2, 0, false, false
        ANIM_RECORD_END

      _Record47
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry ( -13,  -27), $21, SpriteLarge, $046, 2, 2, true, false
        .structSpriteEntry (   3,  -27), $21, SpriteLarge, $044, 2, 2, true, false
        ANIM_RECORD_END

      _Record48
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry ( -10,  -19), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry ( -10,  -35), $21, SpriteLarge, $048, 2, 2, false, false
        ANIM_RECORD_END

      _Record49
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (  -5,  -20), $21, SpriteLarge, $04E, 2, 2, false, false
        .structSpriteEntry (  -5,  -36), $21, SpriteLarge, $04C, 2, 2, false, false
        ANIM_RECORD_END

      aBattleAnimationFramesWarriorBow ; 99/DB82

        ; Frame table of entry 41: slices of the class sheet per frame.

        .word _Frame00 - aBattleAnimationFramesWarriorBow
        .word _Frame01 - aBattleAnimationFramesWarriorBow
        .word _Frame02 - aBattleAnimationFramesWarriorBow
        .word _Frame03 - aBattleAnimationFramesWarriorBow
        .word _Frame04 - aBattleAnimationFramesWarriorBow
        .word _Frame05 - aBattleAnimationFramesWarriorBow
        .word _Frame06 - aBattleAnimationFramesWarriorBow
        .word _Frame07 - aBattleAnimationFramesWarriorBow
        .word _Frame08 - aBattleAnimationFramesWarriorBow
        .word _Frame09 - aBattleAnimationFramesWarriorBow
        .word _Frame10 - aBattleAnimationFramesWarriorBow

      _Frame00
        ANIM_TILES
        ANIM_TILE_ROW $0000, $0100
        ANIM_TILE_ROW $0100, $0100
        ANIM_TILES_END

      _Frame01
        ANIM_TILES
        ANIM_TILE_ROW $0200, $0100
        ANIM_TILE_ROW $0300, $0080
        ANIM_TILES_END

      _Frame02
        ANIM_TILES
        ANIM_TILE_ROW $0380, $0120
        ANIM_TILE_ROW $04A0, $0080
        ANIM_TILES_END

      _Frame03
        ANIM_TILES
        ANIM_TILE_ROW $0520, $0100
        ANIM_TILE_ROW $0620, $0100
        ANIM_TILES_END

      _Frame04
        ANIM_TILES
        ANIM_TILE_ROW $0720, $0100
        ANIM_TILE_ROW $0820, $0100
        ANIM_TILES_END

      _Frame05
        ANIM_TILES
        ANIM_TILE_ROW $0920, $0100
        ANIM_TILE_ROW $0A20, $0100
        ANIM_TILES_END

      _Frame06
        ANIM_TILES
        ANIM_TILE_ROW $0B20, $0100
        ANIM_TILE_ROW $0C20, $0100
        ANIM_TILES_END

      _Frame07
        ANIM_TILES
        ANIM_TILE_ROW $0D20, $0100
        ANIM_TILE_ROW $0E20, $0100
        ANIM_TILES_END

      _Frame08
        ANIM_TILES
        ANIM_TILE_ROW $0F20, $0100
        ANIM_TILE_ROW $1020, $0100
        ANIM_TILES_END

      _Frame09
        ANIM_TILES
        ANIM_TILE_ROW $1120, $0100
        ANIM_TILE_ROW $1220, $0100
        ANIM_TILES_END

      _Frame10
        ANIM_TILES
        ANIM_TILE_ROW $1320, $0100
        ANIM_TILE_ROW $1420, $0100
        ANIM_TILES_END

      aBattleAnimationSequencesWarriorBow ; 99/DBFB

        ; Sequence data of entry 41 of aBattleAnimationFrameTables, used by: Warrior (Bow), Hunter
        ; (Bow). Frames: aBattleAnimationFramesWarriorBow.

        .word _Index - aBattleAnimationSequencesWarriorBow, _Records - aBattleAnimationSequencesWarriorBow

      _Index
        .word _Sequence00 - aBattleAnimationSequencesWarriorBow
        .word _Sequence01 - aBattleAnimationSequencesWarriorBow
        .word _Sequence02 - aBattleAnimationSequencesWarriorBow
        .word _Sequence03 - aBattleAnimationSequencesWarriorBow
        .word _Sequence04 - aBattleAnimationSequencesWarriorBow
        .word _Sequence05 - aBattleAnimationSequencesWarriorBow
        .word _Sequence06 - aBattleAnimationSequencesWarriorBow
        .word _Sequence07 - aBattleAnimationSequencesWarriorBow
        .word _Sequence08 - aBattleAnimationSequencesWarriorBow
        .word _Sequence09 - aBattleAnimationSequencesWarriorBow
        .word _Sequence10 - aBattleAnimationSequencesWarriorBow
        .word _Sequence11 - aBattleAnimationSequencesWarriorBow
        .word _Sequence12 - aBattleAnimationSequencesWarriorBow
        .word _Sequence13 - aBattleAnimationSequencesWarriorBow
        .word _Sequence14 - aBattleAnimationSequencesWarriorBow
        .word _Sequence15 - aBattleAnimationSequencesWarriorBow
        .word _Sequence16 - aBattleAnimationSequencesWarriorBow
        .word _Sequence17 - aBattleAnimationSequencesWarriorBow
        .word _Sequence18 - aBattleAnimationSequencesWarriorBow
        .word _Sequence19 - aBattleAnimationSequencesWarriorBow
        .word _Sequence20 - aBattleAnimationSequencesWarriorBow
        .word _Sequence21 - aBattleAnimationSequencesWarriorBow
        .word _Sequence22 - aBattleAnimationSequencesWarriorBow

      _Records
        .word _Record00 - aBattleAnimationSequencesWarriorBow
        .word _Record01 - aBattleAnimationSequencesWarriorBow
        .word _Record02 - aBattleAnimationSequencesWarriorBow
        .word _Record03 - aBattleAnimationSequencesWarriorBow
        .word _Record04 - aBattleAnimationSequencesWarriorBow
        .word _Record05 - aBattleAnimationSequencesWarriorBow
        .word _Record06 - aBattleAnimationSequencesWarriorBow
        .word _Record07 - aBattleAnimationSequencesWarriorBow
        .word _Record08 - aBattleAnimationSequencesWarriorBow
        .word _Record09 - aBattleAnimationSequencesWarriorBow
        .word _Record10 - aBattleAnimationSequencesWarriorBow
        .word _Record11 - aBattleAnimationSequencesWarriorBow
        .word _Record12 - aBattleAnimationSequencesWarriorBow
        .word _Record13 - aBattleAnimationSequencesWarriorBow
        .word _Record14 - aBattleAnimationSequencesWarriorBow
        .word _Record15 - aBattleAnimationSequencesWarriorBow
        .word _Record16 - aBattleAnimationSequencesWarriorBow
        .word _Record17 - aBattleAnimationSequencesWarriorBow
        .word _Record18 - aBattleAnimationSequencesWarriorBow

      _Sequence00
        ANIM_CMD_F7
        ANIM_STEP 1, 1
        ANIM_HOLD

      _Sequence01
        ANIM_CMD_EF 0
        ANIM_STEP 7, 2
        ANIM_CMD_EE
        ANIM_STEP 8, 2
        ANIM_STEP 7, 2
        ANIM_STEP 8, 2
        ANIM_STEP 7, 2
        ANIM_STEP 8, 2
        ANIM_STEP 7, 1
        ANIM_STEP 8, 1
        ANIM_STEP 7, 1
        ANIM_STEP 8, 1
        ANIM_STEP 7, 1
        ANIM_STEP 8, 1
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence02
        ANIM_STEP 2, 5
        ANIM_STEP 3, 5
        ANIM_STEP 4, 5
        ANIM_STEP 5, 32
        ANIM_SOUND 9
        ANIM_STEP 16, 38
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence03
        ANIM_CMD_F7
        ANIM_STEP 2, 1
        ANIM_HOLD

      _Sequence04
        ANIM_SOUND 28
        ANIM_STEP 9, 4
        ANIM_STEP 11, 5
        ANIM_SOUND 28
        ANIM_STEP 10, 4
        ANIM_STEP 12, 4
        ANIM_STEP 12, 1
        ANIM_CMD_F4 1
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence05
        ANIM_CMD_EF 9
        ANIM_SOUND 10
        ANIM_STEP 17, 2
        ANIM_CMD_EE
        ANIM_STEP 18, 2
        ANIM_STEP 17, 2
        ANIM_STEP 18, 2
        ANIM_STEP 17, 2
        ANIM_STEP 18, 2
        ANIM_STEP 17, 1
        ANIM_STEP 18, 1
        ANIM_STEP 17, 1
        ANIM_STEP 18, 1
        ANIM_STEP 17, 1
        ANIM_STEP 18, 1
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence06
        ANIM_STEP 2, 5
        ANIM_STEP 3, 5
        ANIM_STEP 4, 5
        ANIM_STEP 5, 32
        ANIM_SOUND 9
        ANIM_STEP 6, 38
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence07
        ANIM_STEP 1, 5
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence08
        ANIM_STEP 1, 16
        ANIM_STEP 8, 1
        ANIM_CMD_F4 1
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence09
        ANIM_STEP 14, 16
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence10
        ANIM_STEP 14, 16
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence11
        ANIM_STEP 14, 16
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence12
        ANIM_STEP 14, 16
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence13
        ANIM_STEP 14, 16
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence14
        ANIM_STEP 13, 16
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence15
        ANIM_STEP 13, 16
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence16
        ANIM_STEP 14, 16
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence17
        ANIM_STEP 15, 16
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence18
        ANIM_STEP 15, 16
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence19
        ANIM_STEP 3, 5
        ANIM_STEP 4, 5
        ANIM_STEP 5, 32
        ANIM_SOUND 9
        ANIM_STEP 16, 38
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence20
        ANIM_STEP 2, 5
        ANIM_STEP 3, 5
        ANIM_STEP 4, 5
        ANIM_STEP 5, 32
        ANIM_SOUND 9
        ANIM_STEP 6, 38
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence21
        ANIM_STEP 2, 5
        ANIM_STEP 3, 5
        ANIM_STEP 4, 5
        ANIM_STEP 5, 32
        ANIM_SOUND 9
        ANIM_STEP 16, 64
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence22
        ANIM_STEP 2, 5
        ANIM_STEP 3, 5
        ANIM_STEP 4, 5
        ANIM_STEP 5, 32
        ANIM_SOUND 9
        ANIM_STEP 6, 64
        ANIM_CMD_F7
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
        .structSpriteEntry (  -9,   -9), $00, SpriteSmall, $059, 2, 2, false, false
        .structSpriteEntry ( -10,  -12), $00, SpriteSmall, $059, 2, 2, false, false
        .structSpriteEntry ( -13,  -20), $00, SpriteSmall, $059, 2, 2, false, false
        .structSpriteEntry ( -13,  -28), $00, SpriteSmall, $049, 2, 2, false, false
        .structSpriteEntry ( -18,  -14), $21, SpriteLarge, $043, 2, 2, false, false
        .structSpriteEntry ( -18,  -22), $00, SpriteSmall, $052, 2, 2, false, false
        .structSpriteEntry ( -18,  -30), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry (  -1,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -17,  -30), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (  -1,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry (  -5,  -16), $21, SpriteLarge, $082, 2, 0, false, false
        .structSpriteEntry ( -17,  -14), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record02
        ANIM_RECORD 1
        .structSpriteEntry (   0,  -14), $00, SpriteSmall, $04C, 2, 2, true, false
        .structSpriteEntry (   8,  -14), $00, SpriteSmall, $04B, 2, 2, true, false
        .structSpriteEntry (  16,  -14), $00, SpriteSmall, $04A, 2, 2, true, false
        .structSpriteEntry (  -9,   -9), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry (  -9,  -15), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry (  -9,  -23), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry (  -9,  -31), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry ( -20,  -16), $21, SpriteLarge, $040, 2, 2, false, true
        .structSpriteEntry ( -20,  -32), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry (   4,   -6), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   4,  -14), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   4,  -22), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   4,  -30), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -12,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -12,  -30), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (  -3,  -15), $21, SpriteLarge, $082, 2, 0, false, false
        ANIM_RECORD_END

      _Record03
        ANIM_RECORD 1
        .structSpriteEntry (   1,    1), $00, SpriteSmall, $05E, 2, 2, false, false
        .structSpriteEntry (   1,   -7), $00, SpriteSmall, $05D, 2, 2, false, false
        .structSpriteEntry (   1,  -15), $00, SpriteSmall, $04D, 2, 2, false, false
        .structSpriteEntry (  -9,  -10), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry (  -9,  -14), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry (  -9,  -22), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry (  -9,  -30), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry ( -20,  -16), $21, SpriteLarge, $040, 2, 2, false, true
        .structSpriteEntry ( -20,  -32), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry (   4,   -6), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   4,  -14), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   4,  -22), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   4,  -30), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -12,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -12,  -30), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (  -3,  -15), $21, SpriteLarge, $082, 2, 0, false, false
        ANIM_RECORD_END

      _Record04
        ANIM_RECORD 1
        .structSpriteEntry (  -5,  -14), $00, SpriteSmall, $04C, 2, 2, false, false
        .structSpriteEntry ( -13,  -14), $00, SpriteSmall, $04B, 2, 2, false, false
        .structSpriteEntry ( -21,  -14), $00, SpriteSmall, $04A, 2, 2, false, false
        .structSpriteEntry (  -9,  -10), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry (  -9,  -15), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry (  -9,  -23), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry (  -9,  -31), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry ( -20,  -16), $21, SpriteLarge, $040, 2, 2, false, true
        .structSpriteEntry ( -20,  -32), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry (   4,   -6), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   4,  -14), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   4,  -22), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   4,  -30), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -12,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -12,  -30), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (  -3,  -15), $21, SpriteLarge, $082, 2, 0, false, false
        ANIM_RECORD_END

      _Record05
        ANIM_RECORD 2
        .structSpriteEntry ( -13,  -19), $00, SpriteSmall, $05C, 2, 2, false, false
        .structSpriteEntry ( -21,  -19), $00, SpriteSmall, $05B, 2, 2, false, false
        .structSpriteEntry ( -29,  -19), $00, SpriteSmall, $05A, 2, 2, false, false
        .structSpriteEntry ( -10,  -10), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry ( -10,  -14), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry ( -10,  -22), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry ( -10,  -30), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry ( -21,  -16), $21, SpriteLarge, $040, 2, 2, false, true
        .structSpriteEntry ( -21,  -32), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry (   9,   -6), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   1,   -6), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   1,  -14), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   1,  -22), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry (   1,  -30), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry ( -15,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -15,  -30), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (  -5,  -16), $21, SpriteLarge, $082, 2, 0, false, false
        ANIM_RECORD_END

      _Record06
        ANIM_RECORD 3
        .structSpriteEntry (  -6,  -28), $00, SpriteSmall, $04C, 2, 2, false, true
        .structSpriteEntry ( -14,  -28), $00, SpriteSmall, $04B, 2, 2, false, true
        .structSpriteEntry ( -22,  -28), $00, SpriteSmall, $04A, 2, 2, false, true
        .structSpriteEntry ( -10,  -20), $00, SpriteSmall, $057, 2, 2, false, true
        .structSpriteEntry ( -13,  -18), $00, SpriteSmall, $057, 2, 2, false, true
        .structSpriteEntry (  -3,  -29), $00, SpriteSmall, $058, 2, 2, false, false
        .structSpriteEntry (  -4,  -37), $00, SpriteSmall, $058, 2, 2, false, false
        .structSpriteEntry ( -18,  -23), $00, SpriteSmall, $052, 2, 2, false, true
        .structSpriteEntry ( -18,  -15), $00, SpriteSmall, $042, 2, 2, false, true
        .structSpriteEntry ( -18,  -39), $21, SpriteLarge, $043, 2, 2, false, true
        .structSpriteEntry (  -8,  -21), $00, SpriteSmall, $055, 2, 2, false, true
        .structSpriteEntry (  -4,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -20,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (  -4,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -20,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (  -5,  -15), $21, SpriteLarge, $082, 2, 0, false, false
        ANIM_RECORD_END

      _Record07
        ANIM_RECORD 4
        .structSpriteEntry ( -16,  -17), $00, SpriteSmall, $059, 2, 2, true, false
        .structSpriteEntry ( -13,  -25), $00, SpriteSmall, $059, 2, 2, true, false
        .structSpriteEntry ( -10,  -33), $00, SpriteSmall, $059, 2, 2, true, false
        .structSpriteEntry ( -11,  -38), $00, SpriteSmall, $049, 2, 2, true, false
        .structSpriteEntry ( -18,  -39), $21, SpriteLarge, $043, 2, 2, false, true
        .structSpriteEntry ( -18,  -23), $00, SpriteSmall, $052, 2, 2, false, true
        .structSpriteEntry ( -18,  -15), $00, SpriteSmall, $042, 2, 2, false, true
        .structSpriteEntry (  -4,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -20,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (  -4,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -20,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (  -5,  -15), $21, SpriteLarge, $082, 2, 0, false, false
        ANIM_RECORD_END

      _Record08
        ANIM_RECORD 4
        .structSpriteEntry ( -15,  -17), $00, SpriteSmall, $059, 2, 2, true, false
        .structSpriteEntry ( -13,  -22), $00, SpriteSmall, $059, 2, 2, true, false
        .structSpriteEntry (  -8,  -36), $00, SpriteSmall, $059, 2, 2, true, false
        .structSpriteEntry (  -7,  -28), $00, SpriteSmall, $049, 2, 2, false, true
        .structSpriteEntry ( -18,  -23), $00, SpriteSmall, $052, 2, 2, false, true
        .structSpriteEntry ( -18,  -15), $00, SpriteSmall, $042, 2, 2, false, true
        .structSpriteEntry ( -18,  -39), $21, SpriteLarge, $043, 2, 2, false, true
        .structSpriteEntry (  -4,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -20,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (  -4,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -20,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (  -5,  -15), $21, SpriteLarge, $082, 2, 0, false, false
        ANIM_RECORD_END

      _Record09
        ANIM_RECORD 5
        .structSpriteEntry (  -9,   -8), $00, SpriteSmall, $059, 2, 2, false, false
        .structSpriteEntry ( -10,  -12), $00, SpriteSmall, $059, 2, 2, false, false
        .structSpriteEntry ( -13,  -20), $00, SpriteSmall, $059, 2, 2, false, false
        .structSpriteEntry ( -13,  -28), $00, SpriteSmall, $049, 2, 2, false, false
        .structSpriteEntry ( -18,  -14), $21, SpriteLarge, $043, 2, 2, false, false
        .structSpriteEntry ( -18,  -22), $00, SpriteSmall, $052, 2, 2, false, false
        .structSpriteEntry ( -18,  -30), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry (  -1,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -17,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (  -1,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -17,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (  -5,  -16), $21, SpriteLarge, $082, 2, 0, false, false
        ANIM_RECORD_END

      _Record10
        ANIM_RECORD 6
        .structSpriteEntry (  -9,   -8), $00, SpriteSmall, $059, 2, 2, false, false
        .structSpriteEntry ( -10,  -12), $00, SpriteSmall, $059, 2, 2, false, false
        .structSpriteEntry ( -13,  -20), $00, SpriteSmall, $059, 2, 2, false, false
        .structSpriteEntry ( -13,  -28), $00, SpriteSmall, $049, 2, 2, false, false
        .structSpriteEntry ( -18,  -14), $21, SpriteLarge, $043, 2, 2, false, false
        .structSpriteEntry ( -18,  -22), $00, SpriteSmall, $052, 2, 2, false, false
        .structSpriteEntry ( -18,  -30), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry (  -1,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -17,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (  -1,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -17,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (  -5,  -16), $21, SpriteLarge, $082, 2, 0, false, false
        ANIM_RECORD_END

      _Record11
        ANIM_RECORD 7
        .structSpriteEntry ( -11,  -10), $00, SpriteSmall, $059, 2, 2, false, false
        .structSpriteEntry ( -12,  -13), $00, SpriteSmall, $059, 2, 2, false, false
        .structSpriteEntry ( -15,  -21), $00, SpriteSmall, $059, 2, 2, false, false
        .structSpriteEntry ( -15,  -29), $00, SpriteSmall, $049, 2, 2, false, false
        .structSpriteEntry ( -20,  -15), $21, SpriteLarge, $043, 2, 2, false, false
        .structSpriteEntry ( -20,  -23), $00, SpriteSmall, $052, 2, 2, false, false
        .structSpriteEntry ( -20,  -31), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry (  -1,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -17,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (  -1,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -17,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (  -5,  -15), $21, SpriteLarge, $082, 2, 0, false, false
        ANIM_RECORD_END

      _Record12
        ANIM_RECORD 8
        .structSpriteEntry ( -11,  -11), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry ( -11,  -15), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry ( -11,  -23), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry ( -11,  -31), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry ( -23,  -33), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry ( -23,  -17), $21, SpriteLarge, $040, 2, 2, false, true
        .structSpriteEntry (  -1,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -17,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (  -1,  -30), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -17,  -30), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (  -5,  -17), $21, SpriteLarge, $082, 2, 0, false, false
        ANIM_RECORD_END

      _Record13
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (   4,   -6), $00, SpriteSmall, $04C, 2, 2, false, true
        .structSpriteEntry (  -4,   -6), $00, SpriteSmall, $04B, 2, 2, false, true
        .structSpriteEntry ( -12,   -6), $00, SpriteSmall, $04A, 2, 2, false, true
        ANIM_RECORD_END

      _Record14
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $05C, 2, 2, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $05B, 2, 2, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $05A, 2, 2, false, false
        ANIM_RECORD_END

      _Record15
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (   4,   -6), $00, SpriteSmall, $04C, 2, 2, false, false
        .structSpriteEntry (  -4,   -6), $00, SpriteSmall, $04B, 2, 2, false, false
        .structSpriteEntry ( -12,   -6), $00, SpriteSmall, $04A, 2, 2, false, false
        ANIM_RECORD_END

      _Record16
        ANIM_RECORD 9
        .structSpriteEntry (  -7,  -25), $00, SpriteSmall, $05C, 2, 2, false, false
        .structSpriteEntry ( -15,  -25), $00, SpriteSmall, $05B, 2, 2, false, false
        .structSpriteEntry ( -23,  -25), $00, SpriteSmall, $05A, 2, 2, false, false
        .structSpriteEntry (  -7,  -14), $00, SpriteSmall, $049, 2, 2, false, true
        .structSpriteEntry (  -7,  -21), $00, SpriteSmall, $059, 2, 2, false, true
        .structSpriteEntry (  -7,  -30), $00, SpriteSmall, $059, 2, 2, false, false
        .structSpriteEntry (  -7,  -37), $00, SpriteSmall, $049, 2, 2, false, false
        .structSpriteEntry ( -25,  -22), $21, SpriteLarge, $045, 2, 2, false, true
        .structSpriteEntry ( -25,  -38), $21, SpriteLarge, $045, 2, 2, false, false
        .structSpriteEntry (  -9,  -14), $00, SpriteSmall, $047, 2, 2, false, true
        .structSpriteEntry (  -9,  -38), $00, SpriteSmall, $047, 2, 2, false, false
        .structSpriteEntry (  -4,  -30), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -20,  -30), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (  -4,  -14), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -20,  -14), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (  -6,  -16), $21, SpriteLarge, $082, 2, 0, false, false
        ANIM_RECORD_END

      _Record17
        ANIM_RECORD 10
        .structSpriteEntry ( -13,  -16), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry ( -13,  -24), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry ( -13,  -28), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry ( -13,  -36), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry ( -25,  -22), $21, SpriteLarge, $040, 2, 2, false, true
        .structSpriteEntry ( -25,  -38), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry (  -4,  -30), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -20,  -30), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (  -4,  -14), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -20,  -14), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (  -6,  -16), $21, SpriteLarge, $082, 2, 0, false, false
        ANIM_RECORD_END

      _Record18
        ANIM_RECORD 10
        .structSpriteEntry ( -12,  -16), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry ( -12,  -24), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry ( -12,  -28), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry ( -12,  -36), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry ( -25,  -22), $21, SpriteLarge, $040, 2, 2, false, true
        .structSpriteEntry ( -25,  -38), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry (  -4,  -30), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -20,  -30), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (  -4,  -14), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -20,  -14), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (  -6,  -16), $21, SpriteLarge, $082, 2, 0, false, false
        ANIM_RECORD_END

      aBattleAnimationFramesDancerSword ; 99/E1CB

        ; Frame table of entry 11: slices of the class sheet per frame.

        .word _Frame00 - aBattleAnimationFramesDancerSword
        .word _Frame01 - aBattleAnimationFramesDancerSword
        .word _Frame02 - aBattleAnimationFramesDancerSword
        .word _Frame03 - aBattleAnimationFramesDancerSword
        .word _Frame04 - aBattleAnimationFramesDancerSword
        .word _Frame05 - aBattleAnimationFramesDancerSword
        .word _Frame06 - aBattleAnimationFramesDancerSword
        .word _Frame07 - aBattleAnimationFramesDancerSword
        .word _Frame08 - aBattleAnimationFramesDancerSword
        .word _Frame09 - aBattleAnimationFramesDancerSword
        .word _Frame10 - aBattleAnimationFramesDancerSword
        .word _Frame11 - aBattleAnimationFramesDancerSword
        .word _Frame12 - aBattleAnimationFramesDancerSword
        .word _Frame13 - aBattleAnimationFramesDancerSword
        .word _Frame14 - aBattleAnimationFramesDancerSword
        .word _Frame15 - aBattleAnimationFramesDancerSword
        .word _Frame16 - aBattleAnimationFramesDancerSword
        .word _Frame17 - aBattleAnimationFramesDancerSword
        .word _Frame18 - aBattleAnimationFramesDancerSword
        .word _Frame19 - aBattleAnimationFramesDancerSword

      _Frame00
        ANIM_TILES
        ANIM_TILE_ROW $0000, $0100
        ANIM_TILE_ROW $0100, $0080
        ANIM_TILES_END

      _Frame01
        ANIM_TILES
        ANIM_TILE_ROW $0180, $0100
        ANIM_TILE_ROW $0280, $0100
        ANIM_TILES_END

      _Frame02
        ANIM_TILES
        ANIM_TILE_ROW $0380, $0100
        ANIM_TILE_ROW $0480, $0100
        ANIM_TILES_END

      _Frame03
        ANIM_TILES
        ANIM_TILE_ROW $0580, $0100
        ANIM_TILE_ROW $0680, $0100
        ANIM_TILES_END

      _Frame04
        ANIM_TILES
        ANIM_TILE_ROW $0780, $0100
        ANIM_TILE_ROW $0880, $0100
        ANIM_TILES_END

      _Frame05
        ANIM_TILES
        ANIM_TILE_ROW $0980, $0100
        ANIM_TILE_ROW $0A80, $0100
        ANIM_TILES_END

      _Frame06
        ANIM_TILES
        ANIM_TILE_ROW $0B80, $0100
        ANIM_TILE_ROW $0C80, $0100
        ANIM_TILES_END

      _Frame07
        ANIM_TILES
        ANIM_TILE_ROW $0D80, $0100
        ANIM_TILE_ROW $0E80, $0100
        ANIM_TILES_END

      _Frame08
        ANIM_TILES
        ANIM_TILE_ROW $0F80, $0100
        ANIM_TILE_ROW $1080, $0080
        ANIM_TILES_END

      _Frame09
        ANIM_TILES
        ANIM_TILE_ROW $1100, $0100
        ANIM_TILE_ROW $1200, $0080
        ANIM_TILES_END

      _Frame10
        ANIM_TILES
        ANIM_TILE_ROW $1280, $0100
        ANIM_TILE_ROW $1380, $0080
        ANIM_TILES_END

      _Frame11
        ANIM_TILES
        ANIM_TILE_ROW $1400, $0100
        ANIM_TILE_ROW $1500, $0080
        ANIM_TILES_END

      _Frame12
        ANIM_TILES
        ANIM_TILE_ROW $1580, $0100
        ANIM_TILE_ROW $1680, $0080
        ANIM_TILES_END

      _Frame13
        ANIM_TILES
        ANIM_TILE_ROW $1700, $0100
        ANIM_TILE_ROW $1800, $0080
        ANIM_TILES_END

      _Frame14
        ANIM_TILES
        ANIM_TILE_ROW $1880, $0100
        ANIM_TILE_ROW $1980, $0080
        ANIM_TILES_END

      _Frame15
        ANIM_TILES
        ANIM_TILE_ROW $1A00, $0100
        ANIM_TILE_ROW $1B00, $0080
        ANIM_TILES_END

      _Frame16
        ANIM_TILES
        ANIM_TILE_ROW $1B80, $0100
        ANIM_TILE_ROW $1C80, $0080
        ANIM_TILES_END

      _Frame17
        ANIM_TILES
        ANIM_TILE_ROW $1D00, $0100
        ANIM_TILE_ROW $1E00, $0100
        ANIM_TILES_END

      _Frame18
        ANIM_TILES
        ANIM_TILE_ROW $1F00, $0100
        ANIM_TILE_ROW $2000, $0080
        ANIM_TILES_END

      _Frame19
        ANIM_TILES
        ANIM_TILE_ROW $2080, $0180
        ANIM_TILE_ROW $2200, $00C0
        ANIM_TILES_END

      aBattleAnimationSequencesDancerSword ; 99/E2A7

        ; Sequence data of entry 11 of aBattleAnimationFrameTables, used by: Dancer (Sword), Thief
        ; (Sword), Rogue (Sword). Frames: aBattleAnimationFramesDancerSword.

        .word _Index - aBattleAnimationSequencesDancerSword, _Records - aBattleAnimationSequencesDancerSword

      _Index
        .word _Sequence00 - aBattleAnimationSequencesDancerSword
        .word _Sequence01 - aBattleAnimationSequencesDancerSword
        .word _Sequence02 - aBattleAnimationSequencesDancerSword
        .word _Sequence03 - aBattleAnimationSequencesDancerSword
        .word _Sequence04 - aBattleAnimationSequencesDancerSword
        .word _Sequence05 - aBattleAnimationSequencesDancerSword
        .word _Sequence06 - aBattleAnimationSequencesDancerSword
        .word _Sequence07 - aBattleAnimationSequencesDancerSword
        .word _Sequence08 - aBattleAnimationSequencesDancerSword
        .word _Sequence09 - aBattleAnimationSequencesDancerSword
        .word _Sequence10 - aBattleAnimationSequencesDancerSword
        .word _Sequence11 - aBattleAnimationSequencesDancerSword
        .word _Sequence12 - aBattleAnimationSequencesDancerSword
        .word _Sequence13 - aBattleAnimationSequencesDancerSword
        .word _Sequence14 - aBattleAnimationSequencesDancerSword
        .word _Sequence15 - aBattleAnimationSequencesDancerSword
        .word _Sequence16 - aBattleAnimationSequencesDancerSword
        .word _Sequence17 - aBattleAnimationSequencesDancerSword
        .word _Sequence18 - aBattleAnimationSequencesDancerSword

      _Records
        .word _Record00 - aBattleAnimationSequencesDancerSword
        .word _Record01 - aBattleAnimationSequencesDancerSword
        .word _Record02 - aBattleAnimationSequencesDancerSword
        .word _Record03 - aBattleAnimationSequencesDancerSword
        .word _Record04 - aBattleAnimationSequencesDancerSword
        .word _Record05 - aBattleAnimationSequencesDancerSword
        .word _Record06 - aBattleAnimationSequencesDancerSword
        .word _Record07 - aBattleAnimationSequencesDancerSword
        .word _Record08 - aBattleAnimationSequencesDancerSword
        .word _Record09 - aBattleAnimationSequencesDancerSword
        .word _Record10 - aBattleAnimationSequencesDancerSword
        .word _Record11 - aBattleAnimationSequencesDancerSword
        .word _Record12 - aBattleAnimationSequencesDancerSword
        .word _Record13 - aBattleAnimationSequencesDancerSword
        .word _Record14 - aBattleAnimationSequencesDancerSword
        .word _Record15 - aBattleAnimationSequencesDancerSword
        .word _Record16 - aBattleAnimationSequencesDancerSword
        .word _Record17 - aBattleAnimationSequencesDancerSword
        .word _Record18 - aBattleAnimationSequencesDancerSword
        .word _Record19 - aBattleAnimationSequencesDancerSword
        .word _Record20 - aBattleAnimationSequencesDancerSword
        .word _Record21 - aBattleAnimationSequencesDancerSword
        .word _Record22 - aBattleAnimationSequencesDancerSword
        .word _Record23 - aBattleAnimationSequencesDancerSword
        .word _Record24 - aBattleAnimationSequencesDancerSword
        .word _Record25 - aBattleAnimationSequencesDancerSword
        .word _Record26 - aBattleAnimationSequencesDancerSword
        .word _Record27 - aBattleAnimationSequencesDancerSword
        .word _Record28 - aBattleAnimationSequencesDancerSword
        .word _Record29 - aBattleAnimationSequencesDancerSword
        .word _Record30 - aBattleAnimationSequencesDancerSword
        .word _Record31 - aBattleAnimationSequencesDancerSword

      _Sequence00
        ANIM_STEP 1, 5
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence01
        ANIM_CMD_F7
        ANIM_SOUND 18
        ANIM_STEP 8, 8
        ANIM_CMD_EE
        ANIM_STEP 8, 3
        ANIM_HOLD

      _Sequence02
        ANIM_CMD_F7
        ANIM_CMD_E8
        ANIM_STEP 2, 6
        ANIM_STEP 3, 6
        ANIM_SOUND 18
        ANIM_STEP 4, 6
        ANIM_STEP 5, 6
        ANIM_STEP 6, 6
        ANIM_SOUND 17
        ANIM_STEP 7, 6
        ANIM_RESTART
        ANIM_HOLD

      _Sequence03
        ANIM_STEP 8, 2
        ANIM_STEP 9, 2
        ANIM_STEP 10, 2
        ANIM_STEP 11, 3
        ANIM_CMD_F1
        ANIM_SOUND 0
        ANIM_STEP 12, 16
        ANIM_CMD_F3
        ANIM_CMD_F7
        ANIM_CMD_ED 3
        ANIM_HOLD

      _Sequence04
        ANIM_STEP 12, 7
        ANIM_CMD_EE
        ANIM_STEP 12, 5
        ANIM_STEP 13, 1
        ANIM_STEP 14, 2
        ANIM_STEP 15, 3
        ANIM_STEP 16, 2
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence05
        ANIM_STEP 17, 1
        ANIM_STEP 18, 2
        ANIM_CMD_F1
        ANIM_SOUND 1
        ANIM_STEP 19, 3
        ANIM_STEP 20, 32
        ANIM_CMD_F3
        ANIM_CMD_ED 2
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence06
        ANIM_STEP 20, 5
        ANIM_STEP 21, 5
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence07
        ANIM_SOUND 18
        ANIM_STEP 22, 5
        ANIM_STEP 23, 6
        ANIM_STEP 27, 1
        ANIM_CMD_F4 1
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence08
        ANIM_STEP 24, 5
        ANIM_STEP 25, 1
        ANIM_SOUND 32
        ANIM_CMD_F0 3
        ANIM_STEP 25, 1
        ANIM_CMD_F4 1
        ANIM_STEP 26, 1
        ANIM_CMD_F4 1
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence09
        ANIM_STEP 1, 16
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence10
        ANIM_SOUND 23
        ANIM_STEP 2, 4
        ANIM_STEP 8, 19
        ANIM_CMD_EE
        ANIM_STEP 8, 9
        ANIM_SOUND 24
        ANIM_STEP 9, 1
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence11
        ANIM_STEP 9, 1
        ANIM_STEP 10, 2
        ANIM_STEP 11, 3
        ANIM_CMD_F1
        ANIM_SOUND 0
        ANIM_STEP 12, 16
        ANIM_CMD_F3
        ANIM_CMD_F7
        ANIM_CMD_ED 3
        ANIM_HOLD

      _Sequence12
        ANIM_STEP 27, 5
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence13
        ANIM_CMD_F7
        ANIM_SOUND 23
        ANIM_STEP 28, 14
        ANIM_STEP 29, 4
        ANIM_STEP 30, 5
        ANIM_STEP 31, 15
        ANIM_SOUND 24
        ANIM_STEP 31, 1
        ANIM_HOLD

      _Sequence14
        ANIM_CMD_F7
        ANIM_STEP 27, 10
        ANIM_HOLD

      _Sequence15
        ANIM_STEP 2, 4
        ANIM_STEP 3, 4
        ANIM_STEP 4, 4
        ANIM_STEP 5, 4
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence16
        ANIM_CMD_F7
        ANIM_CMD_EC 1
        ANIM_SOUND 23
        ANIM_STEP 5, 2
        ANIM_CMD_EE
        ANIM_STEP 5, 12
        ANIM_CMD_E9
        ANIM_STEP 8, 2
        ANIM_CMD_EC 0
        ANIM_STEP 9, 1
        ANIM_STEP 10, 1
        ANIM_CMD_F1
        ANIM_SOUND 0
        ANIM_STEP 11, 2
        ANIM_HOLD

      _Sequence17
        ANIM_STEP 12, 16
        ANIM_CMD_F3
        ANIM_CMD_F7
        ANIM_CMD_ED 3
        ANIM_HOLD

      _Sequence18
        ANIM_STEP 27, 5
        ANIM_STEP 1, 5
        ANIM_CMD_F7
        ANIM_HOLD

      _Record00
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (  -6,   -5), $00, SpriteSmall, $0F1, 2, 3, false, false
        .structSpriteEntry ( -14,   -5), $00, SpriteSmall, $0F0, 2, 3, false, false
        .structSpriteEntry (  10,   -5), $00, SpriteSmall, $0F2, 2, 3, false, false
        .structSpriteEntry (   2,   -5), $00, SpriteSmall, $0F1, 2, 3, false, false
        ANIM_RECORD_END

      _Record01
        ANIM_RECORD 0
        .structSpriteEntry (   6,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   6,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   6,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   6,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -10,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -10,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -11,  -24), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry ( -27,  -24), $21, SpriteLarge, $044, 2, 2, false, false
        ANIM_RECORD_END

      _Record02
        ANIM_RECORD 1
        .structSpriteEntry (   4,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   4,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (  -7,  -26), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry ( -23,  -26), $21, SpriteLarge, $044, 2, 2, false, false
        ANIM_RECORD_END

      _Record03
        ANIM_RECORD 2
        .structSpriteEntry (   4,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   4,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (  -7,  -26), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry ( -23,  -26), $21, SpriteLarge, $044, 2, 2, false, false
        ANIM_RECORD_END

      _Record04
        ANIM_RECORD 3
        .structSpriteEntry (   4,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   4,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (  -6,  -27), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry ( -22,  -27), $21, SpriteLarge, $044, 2, 2, false, false
        ANIM_RECORD_END

      _Record05
        ANIM_RECORD 4
        .structSpriteEntry (   4,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   4,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (  -5,  -26), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry ( -21,  -26), $21, SpriteLarge, $044, 2, 2, false, false
        ANIM_RECORD_END

      _Record06
        ANIM_RECORD 5
        .structSpriteEntry (   4,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   4,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (  -7,  -26), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry ( -23,  -26), $21, SpriteLarge, $044, 2, 2, false, false
        ANIM_RECORD_END

      _Record07
        ANIM_RECORD 6
        .structSpriteEntry (   4,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   4,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (  -7,  -27), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry ( -23,  -27), $21, SpriteLarge, $044, 2, 2, false, false
        ANIM_RECORD_END

      _Record08
        ANIM_RECORD 7
        .structSpriteEntry ( -10,  -39), $21, SpriteLarge, $042, 2, 2, true, true
        .structSpriteEntry (   6,  -39), $21, SpriteLarge, $040, 2, 2, true, true
        .structSpriteEntry (   2,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -14,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   2,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -14,  -31), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record09
        ANIM_RECORD 8
        .structSpriteEntry (   1,  -43), $00, SpriteSmall, $0E4, 2, 2, false, false
        .structSpriteEntry (  -7,  -43), $00, SpriteSmall, $0E3, 2, 2, false, false
        .structSpriteEntry ( -15,  -43), $00, SpriteSmall, $0E2, 2, 2, false, false
        .structSpriteEntry ( -23,  -43), $00, SpriteSmall, $0E1, 2, 2, false, false
        .structSpriteEntry (   5,   -4), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   5,  -12), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   5,  -20), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   5,  -28), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -11,  -12), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -11,  -28), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record10
        ANIM_RECORD 8
        .structSpriteEntry ( -31,  -30), $00, SpriteSmall, $0E0, 2, 2, false, false
        .structSpriteEntry ( -15,  -38), $00, SpriteSmall, $0D2, 2, 2, false, false
        .structSpriteEntry ( -23,  -38), $00, SpriteSmall, $0D1, 2, 2, false, false
        .structSpriteEntry ( -31,  -38), $00, SpriteSmall, $0D0, 2, 2, false, false
        .structSpriteEntry (   5,   -4), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   5,  -12), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   5,  -20), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   5,  -28), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -11,  -12), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -11,  -28), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record11
        ANIM_RECORD 8
        .structSpriteEntry ( -35,  -19), $00, SpriteSmall, $0A0, 2, 2, false, false
        .structSpriteEntry ( -35,  -27), $00, SpriteSmall, $090, 2, 2, false, false
        .structSpriteEntry ( -35,  -35), $00, SpriteSmall, $080, 2, 2, false, false
        .structSpriteEntry ( -19,   -3), $00, SpriteSmall, $0C2, 2, 2, false, false
        .structSpriteEntry ( -35,  -11), $21, SpriteLarge, $0B0, 2, 2, false, false
        .structSpriteEntry (   5,   -4), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   5,  -12), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   5,  -20), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   5,  -28), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -11,  -12), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -11,  -28), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record12
        ANIM_RECORD 8
        .structSpriteEntry ( -10,  -12), $21, SpriteLarge, $042, 2, 2, false, false
        .structSpriteEntry ( -26,  -12), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry (   5,   -4), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   5,  -12), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   5,  -20), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   5,  -28), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -11,  -12), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -11,  -28), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record13
        ANIM_RECORD 8
        .structSpriteEntry (  -8,  -17), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry ( -24,  -17), $21, SpriteLarge, $044, 2, 2, false, false
        .structSpriteEntry (   5,   -4), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   5,  -12), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   5,  -20), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   5,  -28), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -11,  -12), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -11,  -28), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record14
        ANIM_RECORD 8
        .structSpriteEntry ( -11,  -32), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry ( -11,  -16), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry (   5,   -4), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   5,  -12), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   5,  -20), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   5,  -28), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -11,  -12), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -11,  -28), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record15
        ANIM_RECORD 8
        .structSpriteEntry (  -6,  -32), $21, SpriteLarge, $048, 2, 2, true, false
        .structSpriteEntry (  -6,  -16), $21, SpriteLarge, $04A, 2, 2, true, false
        .structSpriteEntry (   5,   -4), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   5,  -12), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   5,  -20), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   5,  -28), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -11,  -12), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -11,  -28), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record16
        ANIM_RECORD 8
        .structSpriteEntry (  -9,  -17), $21, SpriteLarge, $046, 2, 2, true, false
        .structSpriteEntry (   7,  -17), $21, SpriteLarge, $044, 2, 2, true, false
        .structSpriteEntry (   5,   -4), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   5,  -12), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   5,  -20), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   5,  -28), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -11,  -12), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -11,  -28), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record17
        ANIM_RECORD 9
        .structSpriteEntry (   7,    3), $00, SpriteSmall, $0E4, 2, 2, false, true
        .structSpriteEntry (  -1,    3), $00, SpriteSmall, $0E3, 2, 2, false, true
        .structSpriteEntry (  -9,    3), $00, SpriteSmall, $0E2, 2, 2, false, true
        .structSpriteEntry ( -17,    3), $00, SpriteSmall, $0E1, 2, 2, false, true
        .structSpriteEntry (   3,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   3,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   3,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   3,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -13,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -13,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record18
        ANIM_RECORD 9
        .structSpriteEntry ( -26,   -6), $00, SpriteSmall, $0E0, 2, 2, false, true
        .structSpriteEntry ( -10,    2), $00, SpriteSmall, $0D2, 2, 2, false, true
        .structSpriteEntry ( -18,    2), $00, SpriteSmall, $0D1, 2, 2, false, true
        .structSpriteEntry ( -26,    2), $00, SpriteSmall, $0D0, 2, 2, false, true
        .structSpriteEntry (   3,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   3,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   3,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   3,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -13,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -13,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record19
        ANIM_RECORD 9
        .structSpriteEntry ( -32,  -25), $00, SpriteSmall, $0A0, 2, 2, false, true
        .structSpriteEntry ( -32,  -17), $00, SpriteSmall, $090, 2, 2, false, true
        .structSpriteEntry ( -32,   -9), $00, SpriteSmall, $080, 2, 2, false, true
        .structSpriteEntry ( -16,  -41), $00, SpriteSmall, $0C2, 2, 2, false, true
        .structSpriteEntry ( -32,  -41), $21, SpriteLarge, $0B0, 2, 2, false, true
        .structSpriteEntry (   3,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   3,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   3,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   3,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -13,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -13,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record20
        ANIM_RECORD 9
        .structSpriteEntry (  -6,  -39), $21, SpriteLarge, $042, 2, 2, false, true
        .structSpriteEntry ( -22,  -39), $21, SpriteLarge, $040, 2, 2, false, true
        .structSpriteEntry (   3,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   3,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   3,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   3,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -13,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -13,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record21
        ANIM_RECORD 9
        .structSpriteEntry (  -3,  -39), $21, SpriteLarge, $042, 2, 2, true, true
        .structSpriteEntry (  13,  -39), $21, SpriteLarge, $040, 2, 2, true, true
        .structSpriteEntry (   3,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   3,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   3,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   3,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -13,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -13,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record22
        ANIM_RECORD 10
        .structSpriteEntry (   6,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   6,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   6,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   6,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -10,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -10,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -12,  -25), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry ( -28,  -25), $21, SpriteLarge, $044, 2, 2, false, false
        ANIM_RECORD_END

      _Record23
        ANIM_RECORD 11
        .structSpriteEntry (   6,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   6,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   6,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   6,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -10,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -10,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -12,  -25), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry ( -28,  -25), $21, SpriteLarge, $044, 2, 2, false, false
        ANIM_RECORD_END

      _Record24
        ANIM_RECORD 12
        .structSpriteEntry ( -17,  -43), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry ( -17,  -27), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry (   6,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   6,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   6,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   6,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -10,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -10,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record25
        ANIM_RECORD 13
        .structSpriteEntry ( -10,  -53), $21, SpriteLarge, $04C, 2, 2, false, false
        .structSpriteEntry ( -10,  -37), $21, SpriteLarge, $04E, 2, 2, false, false
        .structSpriteEntry (   6,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   6,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   6,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   6,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -10,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -10,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record26
        ANIM_RECORD 14
        .structSpriteEntry ( -17,  -33), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry ( -33,  -33), $21, SpriteLarge, $044, 2, 2, false, false
        .structSpriteEntry (   1,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   1,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   1,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   1,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -15,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -15,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record27
        ANIM_RECORD 15
        .structSpriteEntry ( -18,  -40), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry ( -18,  -24), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry (   5,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   5,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   5,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   5,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -11,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -11,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record28
        ANIM_RECORD 16
        .structSpriteEntry (   5,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   5,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   5,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   5,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -11,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -11,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -13,  -43), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry ( -13,  -27), $21, SpriteLarge, $04A, 2, 2, false, false
        ANIM_RECORD_END

      _Record29
        ANIM_RECORD 17
        .structSpriteEntry (   0,  -16), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -16,  -16), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   0,  -32), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -16,  -32), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (  -5,  -39), $21, SpriteLarge, $04C, 2, 2, false, false
        .structSpriteEntry (  -5,  -23), $21, SpriteLarge, $04E, 2, 2, false, false
        ANIM_RECORD_END

      _Record30
        ANIM_RECORD 18
        .structSpriteEntry (   2,   -8), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   2,  -16), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   2,  -24), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   2,  -32), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -14,  -16), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -14,  -32), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (  -5,  -11), $21, SpriteLarge, $048, 2, 2, true, true
        .structSpriteEntry (  -5,  -27), $21, SpriteLarge, $04A, 2, 2, true, true
        ANIM_RECORD_END

      _Record31
        ANIM_RECORD 19
        .structSpriteEntry ( -14,  -29), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry ( -30,  -29), $21, SpriteLarge, $044, 2, 2, false, false
        .structSpriteEntry (   7,   -3), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   7,  -11), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry (   7,  -19), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   7,  -27), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (   7,  -35), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry (   7,  -43), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (  -9,  -11), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (  -9,  -27), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (  -9,  -43), $21, SpriteLarge, $004, 2, 0, false, false
        ANIM_RECORD_END

      aBattleAnimationFramesJuniorLordSword ; 99/E978

        ; Frame table of entry 46: slices of the class sheet per frame.

        .word _Frame00 - aBattleAnimationFramesJuniorLordSword
        .word _Frame01 - aBattleAnimationFramesJuniorLordSword
        .word _Frame02 - aBattleAnimationFramesJuniorLordSword
        .word _Frame03 - aBattleAnimationFramesJuniorLordSword
        .word _Frame04 - aBattleAnimationFramesJuniorLordSword
        .word _Frame05 - aBattleAnimationFramesJuniorLordSword
        .word _Frame06 - aBattleAnimationFramesJuniorLordSword
        .word _Frame07 - aBattleAnimationFramesJuniorLordSword
        .word _Frame08 - aBattleAnimationFramesJuniorLordSword
        .word _Frame09 - aBattleAnimationFramesJuniorLordSword
        .word _Frame10 - aBattleAnimationFramesJuniorLordSword
        .word _Frame11 - aBattleAnimationFramesJuniorLordSword
        .word _Frame12 - aBattleAnimationFramesJuniorLordSword
        .word _Frame13 - aBattleAnimationFramesJuniorLordSword
        .word _Frame14 - aBattleAnimationFramesJuniorLordSword
        .word _Frame15 - aBattleAnimationFramesJuniorLordSword
        .word _Frame16 - aBattleAnimationFramesJuniorLordSword
        .word _Frame17 - aBattleAnimationFramesJuniorLordSword
        .word _Frame18 - aBattleAnimationFramesJuniorLordSword
        .word _Frame19 - aBattleAnimationFramesJuniorLordSword
        .word _Frame20 - aBattleAnimationFramesJuniorLordSword
        .word _Frame21 - aBattleAnimationFramesJuniorLordSword
        .word _Frame22 - aBattleAnimationFramesJuniorLordSword
        .word _Frame23 - aBattleAnimationFramesJuniorLordSword
        .word _Frame24 - aBattleAnimationFramesJuniorLordSword
        .word _Frame25 - aBattleAnimationFramesJuniorLordSword
        .word _Frame26 - aBattleAnimationFramesJuniorLordSword
        .word _Frame27 - aBattleAnimationFramesJuniorLordSword
        .word _Frame28 - aBattleAnimationFramesJuniorLordSword
        .word _Frame29 - aBattleAnimationFramesJuniorLordSword
        .word _Frame30 - aBattleAnimationFramesJuniorLordSword
        .word _Frame31 - aBattleAnimationFramesJuniorLordSword
        .word _Frame32 - aBattleAnimationFramesJuniorLordSword
        .word _Frame33 - aBattleAnimationFramesJuniorLordSword

      _Frame00
        ANIM_TILES
        ANIM_TILE_ROW $0000, $0100
        ANIM_TILE_ROW $0100, $0080
        ANIM_TILES_END

      _Frame01
        ANIM_TILES
        ANIM_TILE_ROW $0180, $0100
        ANIM_TILE_ROW $0280, $0100
        ANIM_TILES_END

      _Frame02
        ANIM_TILES
        ANIM_TILE_ROW $0380, $0100
        ANIM_TILE_ROW $0480, $0100
        ANIM_TILES_END

      _Frame03
        ANIM_TILES
        ANIM_TILE_ROW $0580, $0100
        ANIM_TILE_ROW $0680, $0100
        ANIM_TILES_END

      _Frame04
        ANIM_TILES
        ANIM_TILE_ROW $0780, $0100
        ANIM_TILE_ROW $0880, $0100
        ANIM_TILES_END

      _Frame05
        ANIM_TILES
        ANIM_TILE_ROW $0980, $0100
        ANIM_TILE_ROW $0A80, $0100
        ANIM_TILES_END

      _Frame06
        ANIM_TILES
        ANIM_TILE_ROW $0B80, $0100
        ANIM_TILE_ROW $0C80, $0100
        ANIM_TILES_END

      _Frame07
        ANIM_TILES
        ANIM_TILE_ROW $0D80, $0100
        ANIM_TILE_ROW $0E80, $0100
        ANIM_TILES_END

      _Frame08
        ANIM_TILES
        ANIM_TILE_ROW $0F80, $0180
        ANIM_TILE_ROW $1100, $00C0
        ANIM_TILES_END

      _Frame09
        ANIM_TILES
        ANIM_TILE_ROW $11C0, $0140
        ANIM_TILE_ROW $1300, $00C0
        ANIM_TILES_END

      _Frame10
        ANIM_TILES
        ANIM_TILE_ROW $13C0, $0160
        ANIM_TILE_ROW $1520, $00C0
        ANIM_TILES_END

      _Frame11
        ANIM_TILES
        ANIM_TILE_ROW $15E0, $0180
        ANIM_TILE_ROW $1760, $00C0
        ANIM_TILES_END

      _Frame12
        ANIM_TILES
        ANIM_TILE_ROW $1820, $0180
        ANIM_TILE_ROW $19A0, $00C0
        ANIM_TILES_END

      _Frame13
        ANIM_TILES
        ANIM_TILE_ROW $1A60, $0180
        ANIM_TILE_ROW $1BE0, $00C0
        ANIM_TILES_END

      _Frame14
        ANIM_TILES
        ANIM_TILE_ROW $1CA0, $0180
        ANIM_TILE_ROW $1E20, $00C0
        ANIM_TILES_END

      _Frame15
        ANIM_TILES
        ANIM_TILE_ROW $1EE0, $0140
        ANIM_TILE_ROW $2020, $00C0
        ANIM_TILES_END

      _Frame16
        ANIM_TILES
        ANIM_TILE_ROW $20E0, $01A0
        ANIM_TILE_ROW $2280, $00C0
        ANIM_TILES_END

      _Frame17
        ANIM_TILES
        ANIM_TILE_ROW $2340, $01A0
        ANIM_TILE_ROW $24E0, $00C0
        ANIM_TILES_END

      _Frame18
        ANIM_TILES
        ANIM_TILE_ROW $25A0, $01A0
        ANIM_TILE_ROW $2740, $00C0
        ANIM_TILES_END

      _Frame19
        ANIM_TILES
        ANIM_TILE_ROW $2800, $0100
        ANIM_TILE_ROW $2900, $0080
        ANIM_TILES_END

      _Frame20
        ANIM_TILES
        ANIM_TILE_ROW $2980, $0100
        ANIM_TILE_ROW $2A80, $0080
        ANIM_TILES_END

      _Frame21
        ANIM_TILES
        ANIM_TILE_ROW $2B00, $0100
        ANIM_TILE_ROW $2C00, $0080
        ANIM_TILES_END

      _Frame22
        ANIM_TILES
        ANIM_TILE_ROW $2C80, $0100
        ANIM_TILE_ROW $2D80, $0080
        ANIM_TILES_END

      _Frame23
        ANIM_TILES
        ANIM_TILE_ROW $2E00, $0100
        ANIM_TILE_ROW $2F00, $0080
        ANIM_TILES_END

      _Frame24
        ANIM_TILES
        ANIM_TILE_ROW $2F80, $0120
        ANIM_TILE_ROW $30A0, $0080
        ANIM_TILES_END

      _Frame25
        ANIM_TILES
        ANIM_TILE_ROW $3120, $0140
        ANIM_TILE_ROW $3260, $0080
        ANIM_TILES_END

      _Frame26
        ANIM_TILES
        ANIM_TILE_ROW $32E0, $0100
        ANIM_TILE_ROW $33E0, $0080
        ANIM_TILES_END

      _Frame27
        ANIM_TILES
        ANIM_TILE_ROW $3460, $0100
        ANIM_TILE_ROW $3560, $0080
        ANIM_TILES_END

      _Frame28
        ANIM_TILES
        ANIM_TILE_ROW $35E0, $0100
        ANIM_TILE_ROW $36E0, $0080
        ANIM_TILES_END

      _Frame29
        ANIM_TILES
        ANIM_TILE_ROW $3760, $0100
        ANIM_TILE_ROW $3860, $0100
        ANIM_TILES_END

      _Frame30
        ANIM_TILES
        ANIM_TILE_ROW $3960, $0120
        ANIM_TILE_ROW $3A80, $0080
        ANIM_TILES_END

      _Frame31
        ANIM_TILES
        ANIM_TILE_ROW $3B00, $0100
        ANIM_TILE_ROW $3C00, $0080
        ANIM_TILES_END

      _Frame32
        ANIM_TILES
        ANIM_TILE_ROW $3C80, $0180
        ANIM_TILE_ROW $3E00, $00C0
        ANIM_TILES_END

      _Frame33
        ANIM_TILES
        ANIM_TILE_ROW $3EC0, $0180
        ANIM_TILE_ROW $4040, $00C0
        ANIM_TILES_END

      aBattleAnimationSequencesJuniorLordSword ; 99/EAEE

        ; Sequence data of entry 46 of aBattleAnimationFrameTables, used by: JuniorLord (Sword),
        ; Prince (Sword), Princess (Sword). Frames: aBattleAnimationFramesJuniorLordSword.

        .word _Index - aBattleAnimationSequencesJuniorLordSword, _Records - aBattleAnimationSequencesJuniorLordSword

      _Index
        .word _Sequence00 - aBattleAnimationSequencesJuniorLordSword
        .word _Sequence01 - aBattleAnimationSequencesJuniorLordSword
        .word _Sequence02 - aBattleAnimationSequencesJuniorLordSword
        .word _Sequence03 - aBattleAnimationSequencesJuniorLordSword
        .word _Sequence04 - aBattleAnimationSequencesJuniorLordSword
        .word _Sequence05 - aBattleAnimationSequencesJuniorLordSword
        .word _Sequence06 - aBattleAnimationSequencesJuniorLordSword
        .word _Sequence07 - aBattleAnimationSequencesJuniorLordSword
        .word _Sequence08 - aBattleAnimationSequencesJuniorLordSword
        .word _Sequence09 - aBattleAnimationSequencesJuniorLordSword
        .word _Sequence10 - aBattleAnimationSequencesJuniorLordSword
        .word _Sequence11 - aBattleAnimationSequencesJuniorLordSword
        .word _Sequence12 - aBattleAnimationSequencesJuniorLordSword
        .word _Sequence13 - aBattleAnimationSequencesJuniorLordSword
        .word _Sequence14 - aBattleAnimationSequencesJuniorLordSword
        .word _Sequence15 - aBattleAnimationSequencesJuniorLordSword
        .word _Sequence16 - aBattleAnimationSequencesJuniorLordSword
        .word _Sequence17 - aBattleAnimationSequencesJuniorLordSword
        .word _Sequence18 - aBattleAnimationSequencesJuniorLordSword
        .word _Sequence19 - aBattleAnimationSequencesJuniorLordSword
        .word _Sequence20 - aBattleAnimationSequencesJuniorLordSword
        .word _Sequence21 - aBattleAnimationSequencesJuniorLordSword
        .word _Sequence22 - aBattleAnimationSequencesJuniorLordSword

      _Records
        .word _Record00 - aBattleAnimationSequencesJuniorLordSword
        .word _Record01 - aBattleAnimationSequencesJuniorLordSword
        .word _Record02 - aBattleAnimationSequencesJuniorLordSword
        .word _Record03 - aBattleAnimationSequencesJuniorLordSword
        .word _Record04 - aBattleAnimationSequencesJuniorLordSword
        .word _Record05 - aBattleAnimationSequencesJuniorLordSword
        .word _Record06 - aBattleAnimationSequencesJuniorLordSword
        .word _Record07 - aBattleAnimationSequencesJuniorLordSword
        .word _Record08 - aBattleAnimationSequencesJuniorLordSword
        .word _Record09 - aBattleAnimationSequencesJuniorLordSword
        .word _Record10 - aBattleAnimationSequencesJuniorLordSword
        .word _Record11 - aBattleAnimationSequencesJuniorLordSword
        .word _Record12 - aBattleAnimationSequencesJuniorLordSword
        .word _Record13 - aBattleAnimationSequencesJuniorLordSword
        .word _Record14 - aBattleAnimationSequencesJuniorLordSword
        .word _Record15 - aBattleAnimationSequencesJuniorLordSword
        .word _Record16 - aBattleAnimationSequencesJuniorLordSword
        .word _Record17 - aBattleAnimationSequencesJuniorLordSword
        .word _Record18 - aBattleAnimationSequencesJuniorLordSword
        .word _Record19 - aBattleAnimationSequencesJuniorLordSword
        .word _Record20 - aBattleAnimationSequencesJuniorLordSword
        .word _Record21 - aBattleAnimationSequencesJuniorLordSword
        .word _Record22 - aBattleAnimationSequencesJuniorLordSword
        .word _Record23 - aBattleAnimationSequencesJuniorLordSword
        .word _Record24 - aBattleAnimationSequencesJuniorLordSword
        .word _Record25 - aBattleAnimationSequencesJuniorLordSword
        .word _Record26 - aBattleAnimationSequencesJuniorLordSword
        .word _Record27 - aBattleAnimationSequencesJuniorLordSword
        .word _Record28 - aBattleAnimationSequencesJuniorLordSword
        .word _Record29 - aBattleAnimationSequencesJuniorLordSword
        .word _Record30 - aBattleAnimationSequencesJuniorLordSword
        .word _Record31 - aBattleAnimationSequencesJuniorLordSword
        .word _Record32 - aBattleAnimationSequencesJuniorLordSword
        .word _Record33 - aBattleAnimationSequencesJuniorLordSword
        .word _Record34 - aBattleAnimationSequencesJuniorLordSword
        .word _Record35 - aBattleAnimationSequencesJuniorLordSword
        .word _Record36 - aBattleAnimationSequencesJuniorLordSword
        .word _Record37 - aBattleAnimationSequencesJuniorLordSword
        .word _Record38 - aBattleAnimationSequencesJuniorLordSword
        .word _Record39 - aBattleAnimationSequencesJuniorLordSword
        .word _Record40 - aBattleAnimationSequencesJuniorLordSword
        .word _Record41 - aBattleAnimationSequencesJuniorLordSword
        .word _Record42 - aBattleAnimationSequencesJuniorLordSword
        .word _Record43 - aBattleAnimationSequencesJuniorLordSword
        .word _Record44 - aBattleAnimationSequencesJuniorLordSword
        .word _Record45 - aBattleAnimationSequencesJuniorLordSword
        .word _Record46 - aBattleAnimationSequencesJuniorLordSword
        .word _Record47 - aBattleAnimationSequencesJuniorLordSword

      _Sequence00
        ANIM_CMD_F7
        ANIM_STEP 1, 1
        ANIM_HOLD

      _Sequence01
        ANIM_STEP 1, 16

      _Sequence02
        ANIM_STEP 9, 2
        ANIM_STEP 10, 3
        ANIM_STEP 11, 3
        ANIM_SOUND 0
        ANIM_CMD_F1
        ANIM_STEP 12, 3
        ANIM_STEP 12, 3
        ANIM_STEP 13, 2
        ANIM_STEP 14, 4
        ANIM_STEP 15, 5
        ANIM_STEP 16, 5
        ANIM_CMD_F3
        ANIM_STEP 16, 2
        ANIM_CMD_F7
        ANIM_CMD_ED 3
        ANIM_HOLD

      _Sequence03
        ANIM_STEP 16, 12
        ANIM_CMD_EE
        ANIM_STEP 17, 2
        ANIM_STEP 18, 2
        ANIM_STEP 19, 2
        ANIM_STEP 20, 2
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence04
        ANIM_STEP 20, 2
        ANIM_STEP 21, 2
        ANIM_STEP 22, 2
        ANIM_CMD_F1
        ANIM_SOUND 1
        ANIM_STEP 23, 2
        ANIM_STEP 24, 2
        ANIM_STEP 25, 3
        ANIM_STEP 26, 3
        ANIM_STEP 27, 3
        ANIM_STEP 28, 21
        ANIM_CMD_F3
        ANIM_CMD_ED 2
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence05
        ANIM_STEP 28, 1
        ANIM_CMD_EE
        ANIM_STEP 28, 2
        ANIM_STEP 29, 3
        ANIM_STEP 30, 3
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence06
        ANIM_CMD_F7
        ANIM_SOUND 23
        ANIM_STEP 9, 24
        ANIM_STEP 46, 6
        ANIM_CMD_EE
        ANIM_STEP 46, 12
        ANIM_SOUND 24
        ANIM_STEP 10, 2
        ANIM_HOLD

      _Sequence07
        ANIM_CMD_F7
        ANIM_STEP 33, 5
        ANIM_STEP 34, 5
        ANIM_STEP 35, 4
        ANIM_STEP 1, 5
        ANIM_HOLD

      _Sequence08
        ANIM_STEP 1, 8
        ANIM_SOUND 18
        ANIM_STEP 16, 4
        ANIM_STEP 31, 4
        ANIM_STEP 31, 1
        ANIM_CMD_F4 1
        ANIM_STEP 1, 5
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence09
        ANIM_CMD_EB
        ANIM_CMD_F7
        ANIM_STEP 3, 6
        ANIM_STEP 4, 6
        ANIM_SOUND 18
        ANIM_STEP 5, 6
        ANIM_STEP 6, 6
        ANIM_STEP 7, 6
        ANIM_SOUND 18
        ANIM_STEP 8, 6
        ANIM_RESTART
        ANIM_STEP 9, 2
        ANIM_HOLD

      _Sequence10
        ANIM_STEP 33, 3
        ANIM_STEP 34, 4
        ANIM_STEP 35, 5
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence11
        ANIM_STEP 36, 5
        ANIM_STEP 37, 6
        ANIM_STEP 38, 1
        ANIM_SOUND 32
        ANIM_CMD_F0 3
        ANIM_STEP 38, 1
        ANIM_CMD_F4 1
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence12
        ANIM_STEP 39, 1
        ANIM_CMD_F4 1
        ANIM_STEP 36, 5
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence13
        ANIM_SOUND 18
        ANIM_STEP 40, 8
        ANIM_SOUND 18
        ANIM_STEP 41, 6
        ANIM_STEP 36, 15
        ANIM_STEP 36, 1
        ANIM_CMD_F4 1
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence14
        ANIM_SOUND 23
        ANIM_STEP 40, 5
        ANIM_STEP 41, 6
        ANIM_STEP 42, 9
        ANIM_STEP 43, 3
        ANIM_STEP 44, 4
        ANIM_STEP 45, 6
        ANIM_STEP 46, 6
        ANIM_SOUND 24
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence15
        ANIM_CMD_F1
        ANIM_SOUND 0
        ANIM_STEP 10, 2
        ANIM_STEP 11, 3
        ANIM_STEP 12, 3
        ANIM_STEP 13, 2
        ANIM_STEP 14, 4
        ANIM_STEP 15, 5
        ANIM_CMD_F3
        ANIM_STEP 16, 2
        ANIM_CMD_F7
        ANIM_CMD_ED 3
        ANIM_HOLD

      _Sequence16
        ANIM_CMD_F7
        ANIM_CMD_EC 1
        ANIM_CMD_EE
        ANIM_STEP 47, 2
        ANIM_STEP 47, 2
        ANIM_STEP 47, 2
        ANIM_STEP 47, 1
        ANIM_STEP 47, 1
        ANIM_STEP 47, 1
        ANIM_STEP 47, 1
        ANIM_STEP 47, 1
        ANIM_STEP 47, 1
        ANIM_STEP 47, 1
        ANIM_STEP 47, 1
        ANIM_STEP 47, 1
        ANIM_STEP 47, 1
        ANIM_CMD_EC 0
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence17
        ANIM_STEP 9, 4
        ANIM_CMD_EE
        ANIM_STEP 9, 8
        ANIM_SOUND 18
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence18
        ANIM_CMD_F7
        ANIM_STEP 36, 5
        ANIM_HOLD

      _Sequence19
        ANIM_CMD_F7
        ANIM_CMD_EC 1
        ANIM_STEP 47, 2
        ANIM_STEP 47, 2
        ANIM_STEP 47, 2
        ANIM_STEP 47, 2
        ANIM_STEP 47, 2
        ANIM_STEP 47, 2
        ANIM_HOLD

      _Sequence20
        ANIM_STEP 20, 2
        ANIM_STEP 21, 2
        ANIM_STEP 22, 2
        ANIM_SOUND 1
        ANIM_STEP 23, 2
        ANIM_STEP 24, 2
        ANIM_STEP 10, 2
        ANIM_STEP 11, 2
        ANIM_SOUND 1
        ANIM_STEP 12, 3
        ANIM_STEP 39, 3
        ANIM_STEP 38, 3
        ANIM_SOUND 0
        ANIM_STEP 33, 2
        ANIM_STEP 34, 2
        ANIM_STEP 35, 2
        ANIM_STEP 21, 2
        ANIM_STEP 22, 2
        ANIM_SOUND 0
        ANIM_STEP 23, 3
        ANIM_CMD_EE
        ANIM_STEP 23, 1
        ANIM_STEP 10, 3
        ANIM_STEP 11, 3
        ANIM_SOUND 0
        ANIM_STEP 12, 3
        ANIM_STEP 16, 1
        ANIM_STEP 17, 1
        ANIM_STEP 18, 1
        ANIM_STEP 19, 1
        ANIM_STEP 20, 1
        ANIM_STEP 21, 1
        ANIM_CMD_F1
        ANIM_SOUND 1
        ANIM_STEP 22, 1
        ANIM_STEP 23, 1
        ANIM_STEP 24, 1
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence21
        ANIM_CMD_F7
        ANIM_STEP 33, 2
        ANIM_STEP 34, 3
        ANIM_STEP 35, 5
        ANIM_STEP 40, 4
        ANIM_STEP 41, 4
        ANIM_STEP 42, 4
        ANIM_STEP 43, 4
        ANIM_STEP 44, 4
        ANIM_STEP 45, 4
        ANIM_STEP 46, 5
        ANIM_SOUND 24
        ANIM_STEP 47, 16
        ANIM_STEP 32, 4
        ANIM_SOUND 18
        ANIM_STEP 1, 2
        ANIM_CMD_F3
        ANIM_CMD_EC 0
        ANIM_HOLD

      _Sequence22
        ANIM_CMD_F7
        ANIM_STEP 33, 3
        ANIM_STEP 34, 1
        ANIM_CMD_EE
        ANIM_STEP 34, 3
        ANIM_STEP 35, 5
        ANIM_HOLD

      _Record00
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (  -6,   -5), $00, SpriteSmall, $0F1, 2, 3, false, false
        .structSpriteEntry ( -14,   -5), $00, SpriteSmall, $0F0, 2, 3, false, false
        .structSpriteEntry (  10,   -5), $00, SpriteSmall, $0F2, 2, 3, false, false
        .structSpriteEntry (   2,   -5), $00, SpriteSmall, $0F1, 2, 3, false, false
        ANIM_RECORD_END

      _Record01
        ANIM_RECORD 0
        .structSpriteEntry ( -14,  -20), $21, SpriteLarge, $042, 2, 2, false, false
        .structSpriteEntry ( -30,  -20), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry ( -10,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -10,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   6,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   6,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   6,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   6,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        ANIM_RECORD_END

      _Record02
        ANIM_RECORD 0
        .structSpriteEntry ( -12,  -26), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry ( -28,  -26), $21, SpriteLarge, $044, 2, 2, false, false
        .structSpriteEntry ( -10,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -10,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   6,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   6,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   6,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   6,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        ANIM_RECORD_END

      _Record03
        ANIM_RECORD 1
        .structSpriteEntry (   4,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   4,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (  -8,  -21), $21, SpriteLarge, $042, 2, 2, false, false
        .structSpriteEntry ( -24,  -21), $21, SpriteLarge, $040, 2, 2, false, false
        ANIM_RECORD_END

      _Record04
        ANIM_RECORD 2
        .structSpriteEntry (   4,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   4,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (  -8,  -21), $21, SpriteLarge, $042, 2, 2, false, false
        .structSpriteEntry ( -24,  -21), $21, SpriteLarge, $040, 2, 2, false, false
        ANIM_RECORD_END

      _Record05
        ANIM_RECORD 3
        .structSpriteEntry (   4,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   4,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (  -7,  -22), $21, SpriteLarge, $042, 2, 2, false, false
        .structSpriteEntry ( -23,  -22), $21, SpriteLarge, $040, 2, 2, false, false
        ANIM_RECORD_END

      _Record06
        ANIM_RECORD 4
        .structSpriteEntry (   4,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   4,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (  -6,  -22), $21, SpriteLarge, $042, 2, 2, false, false
        .structSpriteEntry ( -22,  -22), $21, SpriteLarge, $040, 2, 2, false, false
        ANIM_RECORD_END

      _Record07
        ANIM_RECORD 5
        .structSpriteEntry (   4,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   4,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (  -6,  -22), $21, SpriteLarge, $042, 2, 2, false, false
        .structSpriteEntry ( -22,  -22), $21, SpriteLarge, $040, 2, 2, false, false
        ANIM_RECORD_END

      _Record08
        ANIM_RECORD 6
        .structSpriteEntry (   4,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   4,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (  -6,  -23), $21, SpriteLarge, $042, 2, 2, false, false
        .structSpriteEntry ( -22,  -23), $21, SpriteLarge, $040, 2, 2, false, false
        ANIM_RECORD_END

      _Record09
        ANIM_RECORD 7
        .structSpriteEntry ( -10,  -42), $21, SpriteLarge, $042, 2, 2, true, true
        .structSpriteEntry (   6,  -42), $21, SpriteLarge, $040, 2, 2, true, true
        .structSpriteEntry (   3,  -17), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -13,  -17), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   3,  -33), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -13,  -33), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record10
        ANIM_RECORD 8
        .structSpriteEntry (   6,  -46), $00, SpriteSmall, $0E4, 2, 2, false, false
        .structSpriteEntry (  -2,  -46), $00, SpriteSmall, $0E3, 2, 2, false, false
        .structSpriteEntry ( -10,  -46), $00, SpriteSmall, $0E2, 2, 2, false, false
        .structSpriteEntry ( -18,  -46), $00, SpriteSmall, $0E1, 2, 2, false, false
        .structSpriteEntry (   5,   -4), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   5,  -12), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry (   5,  -20), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   5,  -28), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry ( -11,  -12), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -11,  -28), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (  13,  -17), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry (  13,  -25), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (  -3,  -25), $21, SpriteLarge, $004, 2, 0, false, false
        ANIM_RECORD_END

      _Record11
        ANIM_RECORD 8
        .structSpriteEntry ( -30,  -36), $00, SpriteSmall, $0E0, 2, 2, false, false
        .structSpriteEntry ( -14,  -44), $00, SpriteSmall, $0D2, 2, 2, false, false
        .structSpriteEntry ( -22,  -44), $00, SpriteSmall, $0D1, 2, 2, false, false
        .structSpriteEntry ( -30,  -44), $00, SpriteSmall, $0D0, 2, 2, false, false
        .structSpriteEntry (   5,   -4), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   5,  -12), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry (   5,  -20), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   5,  -28), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry ( -11,  -12), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -11,  -28), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (  13,  -17), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry (  13,  -25), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (  -3,  -25), $21, SpriteLarge, $004, 2, 0, false, false
        ANIM_RECORD_END

      _Record12
        ANIM_RECORD 8
        .structSpriteEntry ( -35,  -19), $00, SpriteSmall, $0A0, 2, 2, false, false
        .structSpriteEntry ( -35,  -27), $00, SpriteSmall, $090, 2, 2, false, false
        .structSpriteEntry ( -35,  -35), $00, SpriteSmall, $080, 2, 2, false, false
        .structSpriteEntry ( -19,   -3), $00, SpriteSmall, $0C2, 2, 2, false, false
        .structSpriteEntry ( -35,  -11), $21, SpriteLarge, $0B0, 2, 2, false, false
        .structSpriteEntry (   5,   -4), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   5,  -12), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry (   5,  -20), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   5,  -28), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry ( -11,  -12), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -11,  -28), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (  13,  -17), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry (  13,  -25), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (  -3,  -25), $21, SpriteLarge, $004, 2, 0, false, false
        ANIM_RECORD_END

      _Record13
        ANIM_RECORD 9
        .structSpriteEntry ( -10,  -12), $21, SpriteLarge, $042, 2, 2, false, false
        .structSpriteEntry ( -26,  -12), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry ( -11,  -12), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -11,  -28), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   5,   -4), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   5,  -12), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry (   5,  -20), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   5,  -28), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -3,  -34), $21, SpriteLarge, $004, 2, 0, false, false
        ANIM_RECORD_END

      _Record14
        ANIM_RECORD 10
        .structSpriteEntry ( -10,  -12), $21, SpriteLarge, $042, 2, 2, false, false
        .structSpriteEntry ( -26,  -12), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry ( -11,  -12), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -11,  -28), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   5,   -4), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   5,  -12), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry (   5,  -20), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   5,  -28), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (   2,  -33), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -33), $21, SpriteLarge, $004, 2, 0, false, false
        ANIM_RECORD_END

      _Record15
        ANIM_RECORD 11
        .structSpriteEntry ( -10,  -12), $21, SpriteLarge, $042, 2, 2, false, false
        .structSpriteEntry ( -26,  -12), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry ( -11,  -12), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -11,  -28), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   5,   -4), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   5,  -12), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry (   5,  -20), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   5,  -28), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry ( -10,  -32), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -18,  -32), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry ( -18,  -24), $21, SpriteLarge, $004, 2, 0, false, false
        ANIM_RECORD_END

      _Record16
        ANIM_RECORD 12
        .structSpriteEntry ( -10,  -12), $21, SpriteLarge, $042, 2, 2, false, false
        .structSpriteEntry ( -26,  -12), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry ( -15,  -12), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (  -7,  -20), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry ( -15,  -20), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -11,  -12), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -11,  -28), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry (   5,   -4), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   5,  -12), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (   5,  -20), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry (   5,  -28), $00, SpriteSmall, $00B, 2, 0, false, false
        ANIM_RECORD_END

      _Record17
        ANIM_RECORD 12
        .structSpriteEntry (  -8,  -17), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry ( -24,  -17), $21, SpriteLarge, $044, 2, 2, false, false
        .structSpriteEntry ( -15,  -12), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (  -7,  -20), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry ( -15,  -20), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -11,  -12), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -11,  -28), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry (   5,   -4), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   5,  -12), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (   5,  -20), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry (   5,  -28), $00, SpriteSmall, $00B, 2, 0, false, false
        ANIM_RECORD_END

      _Record18
        ANIM_RECORD 12
        .structSpriteEntry ( -11,  -16), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry ( -11,  -32), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry ( -15,  -12), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (  -7,  -20), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry ( -15,  -20), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -11,  -12), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -11,  -28), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry (   5,   -4), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   5,  -12), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (   5,  -20), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry (   5,  -28), $00, SpriteSmall, $00B, 2, 0, false, false
        ANIM_RECORD_END

      _Record19
        ANIM_RECORD 12
        .structSpriteEntry (  -6,  -16), $21, SpriteLarge, $04A, 2, 2, true, false
        .structSpriteEntry (  -6,  -32), $21, SpriteLarge, $048, 2, 2, true, false
        .structSpriteEntry ( -15,  -12), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (  -7,  -20), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry ( -15,  -20), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -11,  -12), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -11,  -28), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry (   5,   -4), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   5,  -12), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (   5,  -20), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry (   5,  -28), $00, SpriteSmall, $00B, 2, 0, false, false
        ANIM_RECORD_END

      _Record20
        ANIM_RECORD 12
        .structSpriteEntry (  -9,  -17), $21, SpriteLarge, $046, 2, 2, true, false
        .structSpriteEntry (   7,  -17), $21, SpriteLarge, $044, 2, 2, true, false
        .structSpriteEntry ( -15,  -12), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (  -7,  -20), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry ( -15,  -20), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -11,  -12), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -11,  -28), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry (   5,   -4), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   5,  -12), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (   5,  -20), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry (   5,  -28), $00, SpriteSmall, $00B, 2, 0, false, false
        ANIM_RECORD_END

      _Record21
        ANIM_RECORD 13
        .structSpriteEntry (  16,    6), $00, SpriteSmall, $0E4, 2, 2, false, true
        .structSpriteEntry (   8,    6), $00, SpriteSmall, $0E3, 2, 2, false, true
        .structSpriteEntry (   0,    6), $00, SpriteSmall, $0E2, 2, 2, false, true
        .structSpriteEntry (  -8,    6), $00, SpriteSmall, $0E1, 2, 2, false, true
        .structSpriteEntry ( -12,  -31), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -13,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (  -5,  -22), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry ( -13,  -22), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   4,  -15), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (   4,  -23), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry (   4,  -31), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $004, 2, 0, false, false
        ANIM_RECORD_END

      _Record22
        ANIM_RECORD 13
        .structSpriteEntry ( -25,   -5), $00, SpriteSmall, $0E0, 2, 2, false, true
        .structSpriteEntry (  -9,    3), $00, SpriteSmall, $0D2, 2, 2, false, true
        .structSpriteEntry ( -17,    3), $00, SpriteSmall, $0D1, 2, 2, false, true
        .structSpriteEntry ( -25,    3), $00, SpriteSmall, $0D0, 2, 2, false, true
        .structSpriteEntry ( -12,  -31), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -13,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (  -5,  -22), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry ( -13,  -22), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   4,  -15), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (   4,  -23), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry (   4,  -31), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $004, 2, 0, false, false
        ANIM_RECORD_END

      _Record23
        ANIM_RECORD 13
        .structSpriteEntry ( -12,  -31), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -13,  -14), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (  -5,  -22), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry ( -13,  -22), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -15,  -42), $00, SpriteSmall, $0C2, 2, 2, false, true
        .structSpriteEntry ( -31,  -26), $00, SpriteSmall, $0A0, 2, 2, false, true
        .structSpriteEntry ( -31,  -18), $00, SpriteSmall, $090, 2, 2, false, true
        .structSpriteEntry ( -31,  -10), $00, SpriteSmall, $080, 2, 2, false, true
        .structSpriteEntry ( -31,  -42), $21, SpriteLarge, $0B0, 2, 2, false, true
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   4,  -15), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (   4,  -23), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry (   4,  -31), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $004, 2, 0, false, false
        ANIM_RECORD_END

      _Record24
        ANIM_RECORD 14
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   4,  -15), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry (   4,  -23), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   4,  -31), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (  -5,  -40), $21, SpriteLarge, $042, 2, 2, false, true
        .structSpriteEntry ( -21,  -40), $21, SpriteLarge, $040, 2, 2, false, true
        .structSpriteEntry (  -7,  -19), $00, SpriteSmall, $00A, 2, 0, true, false
        .structSpriteEntry (  -7,  -27), $00, SpriteSmall, $00B, 2, 0, true, false
        .structSpriteEntry ( -23,  -27), $21, SpriteLarge, $004, 2, 0, true, false
        ANIM_RECORD_END

      _Record25
        ANIM_RECORD 15
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   4,  -15), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry (   4,  -23), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   4,  -31), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -13,  -40), $21, SpriteLarge, $004, 2, 0, true, false
        .structSpriteEntry (  -5,  -40), $21, SpriteLarge, $042, 2, 2, false, true
        .structSpriteEntry ( -21,  -40), $21, SpriteLarge, $040, 2, 2, false, true
        ANIM_RECORD_END

      _Record26
        ANIM_RECORD 16
        .structSpriteEntry (  -1,  -29), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (  -9,  -31), $00, SpriteSmall, $007, 2, 0, true, false
        .structSpriteEntry (  -9,  -39), $00, SpriteSmall, $008, 2, 0, true, false
        .structSpriteEntry (  -1,  -39), $21, SpriteLarge, $000, 2, 0, true, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (   4,  -15), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry (   4,  -23), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   4,  -31), $00, SpriteSmall, $00C, 2, 0, false, false
        .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry (  -5,  -40), $21, SpriteLarge, $042, 2, 2, false, true
        .structSpriteEntry ( -21,  -40), $21, SpriteLarge, $040, 2, 2, false, true
        ANIM_RECORD_END

      _Record27
        ANIM_RECORD 17
        .structSpriteEntry (   1,  -26), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   0,  -30), $21, SpriteLarge, $000, 2, 0, true, false
        .structSpriteEntry (   0,  -38), $00, SpriteSmall, $007, 2, 0, true, false
        .structSpriteEntry (   8,  -38), $00, SpriteSmall, $008, 2, 0, true, false
        .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (   4,  -15), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry (   4,  -23), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   4,  -31), $00, SpriteSmall, $00C, 2, 0, false, false
        .structSpriteEntry (  -5,  -40), $21, SpriteLarge, $042, 2, 2, false, true
        .structSpriteEntry ( -21,  -40), $21, SpriteLarge, $040, 2, 2, false, true
        ANIM_RECORD_END

      _Record28
        ANIM_RECORD 18
        .structSpriteEntry (   0,  -22), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (  -3,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (   5,  -23), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry (  -3,  -23), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (   4,  -15), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry (   4,  -23), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   4,  -31), $00, SpriteSmall, $00C, 2, 0, false, false
        .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry (  -5,  -40), $21, SpriteLarge, $042, 2, 2, false, true
        .structSpriteEntry ( -21,  -40), $21, SpriteLarge, $040, 2, 2, false, true
        ANIM_RECORD_END

      _Record29
        ANIM_RECORD 18
        .structSpriteEntry (   0,  -22), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (  -3,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (   5,  -23), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry (  -3,  -23), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (   4,  -15), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry (   4,  -23), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   4,  -31), $00, SpriteSmall, $00C, 2, 0, false, false
        .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry (  -6,  -53), $21, SpriteLarge, $04C, 2, 2, true, false
        .structSpriteEntry (  -6,  -37), $21, SpriteLarge, $04E, 2, 2, true, false
        ANIM_RECORD_END

      _Record30
        ANIM_RECORD 18
        .structSpriteEntry (   0,  -22), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (  -3,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (   5,  -23), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry (  -3,  -23), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (   4,  -15), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry (   4,  -23), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   4,  -31), $00, SpriteSmall, $00C, 2, 0, false, false
        .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry (  -1,  -53), $21, SpriteLarge, $04C, 2, 2, false, false
        .structSpriteEntry (  -1,  -37), $21, SpriteLarge, $04E, 2, 2, false, false
        ANIM_RECORD_END

      _Record31
        ANIM_RECORD 19
        .structSpriteEntry ( -18,  -40), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry ( -18,  -24), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   4,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   4,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   4,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record32
        ANIM_RECORD 19
        .structSpriteEntry ( -18,  -40), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry ( -18,  -24), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   4,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   4,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   4,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record33
        ANIM_RECORD 20
        .structSpriteEntry (   6,   -8), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   6,  -16), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   6,  -24), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   6,  -32), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -10,  -16), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -10,  -32), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (  -9,  -34), $21, SpriteLarge, $042, 2, 2, false, true
        .structSpriteEntry ( -25,  -34), $21, SpriteLarge, $040, 2, 2, false, true
        ANIM_RECORD_END

      _Record34
        ANIM_RECORD 21
        .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -12,  -32), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   4,   -8), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   4,  -16), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   4,  -24), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   4,  -32), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry (  -5,  -38), $21, SpriteLarge, $042, 2, 2, false, true
        .structSpriteEntry ( -21,  -38), $21, SpriteLarge, $040, 2, 2, false, true
        ANIM_RECORD_END

      _Record35
        ANIM_RECORD 22
        .structSpriteEntry (  -1,  -32), $21, SpriteLarge, $04A, 2, 2, true, false
        .structSpriteEntry (  -1,  -48), $21, SpriteLarge, $048, 2, 2, true, false
        .structSpriteEntry (   3,   -8), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   3,  -16), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   3,  -24), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   3,  -32), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -13,  -16), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -13,  -32), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record36
        ANIM_RECORD 23
        .structSpriteEntry ( -14,  -28), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry ( -30,  -28), $21, SpriteLarge, $044, 2, 2, false, false
        .structSpriteEntry (   6,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   6,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   6,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   6,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -10,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -10,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record37
        ANIM_RECORD 23
        .structSpriteEntry ( -17,  -43), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry ( -17,  -27), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry (   6,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   6,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   6,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   6,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -10,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -10,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record38
        ANIM_RECORD 24
        .structSpriteEntry ( -10,  -38), $21, SpriteLarge, $04E, 2, 2, false, false
        .structSpriteEntry ( -10,  -54), $21, SpriteLarge, $04C, 2, 2, false, false
        .structSpriteEntry ( -10,  -39), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   6,   -7), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   6,  -15), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   6,  -23), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry (   6,  -31), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry ( -10,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -10,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record39
        ANIM_RECORD 25
        .structSpriteEntry (   9,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   9,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry ( -17,  -33), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry ( -33,  -33), $21, SpriteLarge, $044, 2, 2, false, false
        .structSpriteEntry (   1,   -7), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   1,  -15), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry (   1,  -23), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   1,  -31), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry ( -15,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -15,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record40
        ANIM_RECORD 26
        .structSpriteEntry ( -15,  -19), $21, SpriteLarge, $042, 2, 2, false, false
        .structSpriteEntry ( -31,  -19), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry (   5,   -6), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   5,  -14), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   5,  -22), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   5,  -30), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -11,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -11,  -30), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record41
        ANIM_RECORD 27
        .structSpriteEntry ( -15,  -20), $21, SpriteLarge, $042, 2, 2, false, false
        .structSpriteEntry ( -31,  -20), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry (   5,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   5,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   5,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   5,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -11,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -11,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record42
        ANIM_RECORD 28
        .structSpriteEntry (   5,   -8), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   5,  -16), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   5,  -24), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   5,  -32), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -11,  -16), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -11,  -32), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -12,  -24), $21, SpriteLarge, $042, 2, 2, false, false
        .structSpriteEntry ( -28,  -24), $21, SpriteLarge, $040, 2, 2, false, false
        ANIM_RECORD_END

      _Record43
        ANIM_RECORD 29
        .structSpriteEntry (   0,  -16), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -16,  -16), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   0,  -32), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -16,  -32), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (  -6,  -30), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry ( -22,  -30), $21, SpriteLarge, $044, 2, 2, false, false
        ANIM_RECORD_END

      _Record44
        ANIM_RECORD 30
        .structSpriteEntry (   3,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   3,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   3,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   3,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -13,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -13,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (  -9,  -25), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry (  -9,  -41), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry (   0,    0), $00, SpriteSmall, $008, 2, 0, false, false
        ANIM_RECORD_END

      _Record45
        ANIM_RECORD 31
        .structSpriteEntry (   6,   -8), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   6,  -16), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   6,  -24), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   6,  -32), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -10,  -16), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -10,  -32), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -12,  -16), $21, SpriteLarge, $042, 2, 2, false, false
        .structSpriteEntry ( -28,  -16), $21, SpriteLarge, $040, 2, 2, false, false
        ANIM_RECORD_END

      _Record46
        ANIM_RECORD 32
        .structSpriteEntry ( -13,  -31), $21, SpriteLarge, $04E, 2, 2, false, false
        .structSpriteEntry ( -13,  -47), $21, SpriteLarge, $04C, 2, 2, false, false
        .structSpriteEntry (   7,    0), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   7,   -8), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry (   7,  -16), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   7,  -24), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (   7,  -32), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry (   7,  -40), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (  -9,   -8), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (  -9,  -24), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (  -9,  -40), $21, SpriteLarge, $004, 2, 0, false, false
        ANIM_RECORD_END

      _Record47
        ANIM_RECORD 33
        .structSpriteEntry (  -9,  -17), $21, SpriteLarge, $046, 2, 2, true, false
        .structSpriteEntry (   7,  -17), $21, SpriteLarge, $044, 2, 2, true, false
        .structSpriteEntry (   5,   -4), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   5,  -12), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry (   5,  -20), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   5,  -28), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry ( -11,  -12), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -11,  -28), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (  12,  -17), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry (  12,  -25), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (  -4,  -25), $21, SpriteLarge, $004, 2, 0, false, false
        ANIM_RECORD_END

    .endsection BattleAnimationFrameData99Section
