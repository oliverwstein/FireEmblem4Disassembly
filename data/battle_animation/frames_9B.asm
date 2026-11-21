; Battle animation frame data in bank $9B: sequence data blocks and frame tables
; reached from aBattleAnimationFrameTables. Written by tools/battle_frames.py;
; formats and macros in include/BattleAnimation.h.

    .section BattleAnimationFrameData9BSection

      aBattleAnimationFramesPegasusKnightSword ; 9B/8000

        ; Frame table of entry 24: slices of the class sheet per frame.

        .word _Frame00 - aBattleAnimationFramesPegasusKnightSword
        .word _Frame01 - aBattleAnimationFramesPegasusKnightSword
        .word _Frame02 - aBattleAnimationFramesPegasusKnightSword
        .word _Frame03 - aBattleAnimationFramesPegasusKnightSword
        .word _Frame04 - aBattleAnimationFramesPegasusKnightSword
        .word _Frame05 - aBattleAnimationFramesPegasusKnightSword
        .word _Frame06 - aBattleAnimationFramesPegasusKnightSword
        .word _Frame07 - aBattleAnimationFramesPegasusKnightSword
        .word _Frame08 - aBattleAnimationFramesPegasusKnightSword
        .word _Frame09 - aBattleAnimationFramesPegasusKnightSword
        .word _Frame10 - aBattleAnimationFramesPegasusKnightSword
        .word _Frame11 - aBattleAnimationFramesPegasusKnightSword
        .word _Frame12 - aBattleAnimationFramesPegasusKnightSword
        .word _Frame13 - aBattleAnimationFramesPegasusKnightSword
        .word _Frame14 - aBattleAnimationFramesPegasusKnightSword

      _Frame00
        ANIM_TILES
        ANIM_TILE_ROW $0000, $06A0
        ANIM_TILES_END

      _Frame01
        ANIM_TILES
        ANIM_TILE_ROW $06A0, $0640
        ANIM_TILES_END

      _Frame02
        ANIM_TILES
        ANIM_TILE_ROW $0CE0, $05A0
        ANIM_TILES_END

      _Frame03
        ANIM_TILES
        ANIM_TILE_ROW $1280, $04A0
        ANIM_TILES_END

      _Frame04
        ANIM_TILES
        ANIM_TILE_ROW $1720, $0540
        ANIM_TILES_END

      _Frame05
        ANIM_TILES
        ANIM_TILE_ROW $1C60, $05A0
        ANIM_TILES_END

      _Frame06
        ANIM_TILES
        ANIM_TILE_ROW $2200, $0640
        ANIM_TILES_END

      _Frame07
        ANIM_TILES
        ANIM_TILE_ROW $2840, $05C0
        ANIM_TILES_END

      _Frame08
        ANIM_TILES
        ANIM_TILE_ROW $2E00, $0560
        ANIM_TILE_ROW $3360, $0040
        ANIM_TILES_END

      _Frame09
        ANIM_TILES
        ANIM_TILE_ROW $33A0, $0580
        ANIM_TILES_END

      _Frame10
        ANIM_TILES
        ANIM_TILE_ROW $3920, $05E0
        ANIM_TILE_ROW $3F00, $0040
        ANIM_TILES_END

      _Frame11
        ANIM_TILES
        ANIM_TILE_ROW $3F40, $04C0
        ANIM_TILES_END

      _Frame12
        ANIM_TILES
        ANIM_TILE_ROW $4400, $0460
        ANIM_TILES_END

      _Frame13
        ANIM_TILES
        ANIM_TILE_ROW $4860, $0540
        ANIM_TILES_END

      _Frame14
        ANIM_TILES
        ANIM_TILE_ROW $4DA0, $05A0
        ANIM_TILES_END

      aBattleAnimationSequencesPegasusKnightSword ; 9B/8071

        ; Sequence data of entry 24 of aBattleAnimationFrameTables, used by: PegasusKnight
        ; (Sword), FalconKnight (Sword). Frames: aBattleAnimationFramesPegasusKnightSword.

        .word _Index - aBattleAnimationSequencesPegasusKnightSword, _Records - aBattleAnimationSequencesPegasusKnightSword

      _Index
        .word _Sequence00 - aBattleAnimationSequencesPegasusKnightSword
        .word _Sequence01 - aBattleAnimationSequencesPegasusKnightSword
        .word _Sequence02 - aBattleAnimationSequencesPegasusKnightSword
        .word _Sequence03 - aBattleAnimationSequencesPegasusKnightSword
        .word _Sequence04 - aBattleAnimationSequencesPegasusKnightSword
        .word _Sequence05 - aBattleAnimationSequencesPegasusKnightSword
        .word _Sequence06 - aBattleAnimationSequencesPegasusKnightSword
        .word _Sequence07 - aBattleAnimationSequencesPegasusKnightSword
        .word _Sequence08 - aBattleAnimationSequencesPegasusKnightSword
        .word _Sequence09 - aBattleAnimationSequencesPegasusKnightSword
        .word _Sequence10 - aBattleAnimationSequencesPegasusKnightSword
        .word _Sequence11 - aBattleAnimationSequencesPegasusKnightSword
        .word _Sequence12 - aBattleAnimationSequencesPegasusKnightSword
        .word _Sequence13 - aBattleAnimationSequencesPegasusKnightSword
        .word _Sequence14 - aBattleAnimationSequencesPegasusKnightSword
        .word _Sequence15 - aBattleAnimationSequencesPegasusKnightSword
        .word _Sequence16 - aBattleAnimationSequencesPegasusKnightSword
        .word _Sequence17 - aBattleAnimationSequencesPegasusKnightSword
        .word _Sequence18 - aBattleAnimationSequencesPegasusKnightSword
        .word _Sequence19 - aBattleAnimationSequencesPegasusKnightSword

      _Records
        .word aBattleAnimationSequencesFalconKnightStaff._Record00 - aBattleAnimationSequencesPegasusKnightSword
        .word aBattleAnimationSequencesFalconKnightStaff._Record01 - aBattleAnimationSequencesPegasusKnightSword
        .word aBattleAnimationSequencesFalconKnightStaff._Record02 - aBattleAnimationSequencesPegasusKnightSword
        .word aBattleAnimationSequencesFalconKnightStaff._Record03 - aBattleAnimationSequencesPegasusKnightSword
        .word aBattleAnimationSequencesFalconKnightStaff._Record04 - aBattleAnimationSequencesPegasusKnightSword
        .word aBattleAnimationSequencesFalconKnightStaff._Record05 - aBattleAnimationSequencesPegasusKnightSword
        .word aBattleAnimationSequencesFalconKnightStaff._Record06 - aBattleAnimationSequencesPegasusKnightSword
        .word aBattleAnimationSequencesFalconKnightStaff._Record07 - aBattleAnimationSequencesPegasusKnightSword
        .word aBattleAnimationSequencesFalconKnightStaff._Record08 - aBattleAnimationSequencesPegasusKnightSword
        .word aBattleAnimationSequencesFalconKnightStaff._Record09 - aBattleAnimationSequencesPegasusKnightSword
        .word aBattleAnimationSequencesFalconKnightStaff._Record10 - aBattleAnimationSequencesPegasusKnightSword
        .word aBattleAnimationSequencesFalconKnightStaff._Record11 - aBattleAnimationSequencesPegasusKnightSword
        .word aBattleAnimationSequencesFalconKnightStaff._Record12 - aBattleAnimationSequencesPegasusKnightSword
        .word aBattleAnimationSequencesFalconKnightStaff._Record13 - aBattleAnimationSequencesPegasusKnightSword
        .word aBattleAnimationSequencesFalconKnightStaff._Record14 - aBattleAnimationSequencesPegasusKnightSword
        .word aBattleAnimationSequencesFalconKnightStaff._Record15 - aBattleAnimationSequencesPegasusKnightSword
        .word aBattleAnimationSequencesFalconKnightStaff._Record16 - aBattleAnimationSequencesPegasusKnightSword
        .word aBattleAnimationSequencesFalconKnightStaff._Record17 - aBattleAnimationSequencesPegasusKnightSword
        .word aBattleAnimationSequencesFalconKnightStaff._Record18 - aBattleAnimationSequencesPegasusKnightSword
        .word aBattleAnimationSequencesFalconKnightStaff._Record19 - aBattleAnimationSequencesPegasusKnightSword
        .word aBattleAnimationSequencesFalconKnightStaff._Record20 - aBattleAnimationSequencesPegasusKnightSword
        .word aBattleAnimationSequencesFalconKnightStaff._Record21 - aBattleAnimationSequencesPegasusKnightSword
        .word aBattleAnimationSequencesFalconKnightStaff._Record22 - aBattleAnimationSequencesPegasusKnightSword
        .word aBattleAnimationSequencesFalconKnightStaff._Record23 - aBattleAnimationSequencesPegasusKnightSword
        .word aBattleAnimationSequencesFalconKnightStaff._Record24 - aBattleAnimationSequencesPegasusKnightSword
        .word aBattleAnimationSequencesFalconKnightStaff._Record25 - aBattleAnimationSequencesPegasusKnightSword

      _Sequence00
        ANIM_CMD_ED 2
        ANIM_CMD_F7
        ANIM_STEP 9, 1
        ANIM_HOLD

      _Sequence01
        ANIM_CMD_F7
        ANIM_STEP 1, 9
        ANIM_STEP 2, 8
        ANIM_STEP 3, 8
        ANIM_STEP 4, 8
        ANIM_STEP 5, 8
        ANIM_STEP 6, 7
        ANIM_STEP 8, 6
        ANIM_HOLD

      _Sequence02
        ANIM_CMD_EB
        ANIM_CMD_F7
        ANIM_STEP 1, 9
        ANIM_STEP 2, 8
        ANIM_STEP 3, 8
        ANIM_SOUND 21
        ANIM_STEP 4, 8
        ANIM_STEP 5, 8
        ANIM_STEP 6, 7
        ANIM_RESTART
        ANIM_HOLD

      _Sequence03
        ANIM_CMD_F7
        ANIM_STEP 9, 6
        ANIM_STEP 24, 1
        ANIM_SOUND 32
        ANIM_CMD_F0 3
        ANIM_STEP 24, 1
        ANIM_CMD_F4 1
        ANIM_STEP 25, 1
        ANIM_CMD_F4 1
        ANIM_STEP 24, 3
        ANIM_STEP 12, 4
        ANIM_STEP 13, 5
        ANIM_STEP 9, 5
        ANIM_HOLD

      _Sequence04
        ANIM_STEP 12, 5
        ANIM_STEP 14, 6
        ANIM_STEP 15, 10
        ANIM_STEP 9, 6
        ANIM_STEP 9, 1
        ANIM_CMD_F4 1
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence05
        ANIM_CMD_EE
        ANIM_SOUND 27
        ANIM_STEP 7, 16
        ANIM_STEP 17, 4
        ANIM_STEP 18, 2
        ANIM_STEP 19, 2
        ANIM_STEP 20, 3
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence06
        ANIM_STEP 13, 3
        ANIM_STEP 12, 4
        ANIM_CMD_EE
        ANIM_STEP 10, 14
        ANIM_STEP 22, 1
        ANIM_STEP 23, 1
        ANIM_CMD_F1
        ANIM_SOUND 0
        ANIM_STEP 11, 16
        ANIM_CMD_F3
        ANIM_STEP 12, 3
        ANIM_STEP 13, 4
        ANIM_STEP 9, 16
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence07
        ANIM_STEP 9, 32
        ANIM_STEP 10, 6
        ANIM_STEP 11, 32
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence08
        ANIM_STEP 8, 8
        ANIM_STEP 9, 3
        ANIM_STEP 13, 8
        ANIM_STEP 10, 9
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence09
        ANIM_STEP 7, 32
        ANIM_STEP 8, 8
        ANIM_STEP 9, 8
        ANIM_STEP 10, 18
        ANIM_STEP 22, 2
        ANIM_STEP 23, 2
        ANIM_STEP 11, 8
        ANIM_STEP 12, 8
        ANIM_STEP 9, 5
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence10
        ANIM_CMD_F7
        ANIM_SOUND 27
        ANIM_STEP 7, 1
        ANIM_HOLD

      _Sequence11
        ANIM_STEP 21, 17
        ANIM_STEP 7, 13
        ANIM_STEP 8, 2
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence12
        ANIM_CMD_F7
        ANIM_STEP 9, 1
        ANIM_HOLD

      _Sequence13
        ANIM_CMD_F7
        ANIM_SOUND 1
        ANIM_CMD_F1
        ANIM_CMD_F3
        ANIM_STEP 21, 1
        ANIM_HOLD

      _Sequence14
        ANIM_CMD_F7
        ANIM_SOUND 21
        ANIM_STEP 4, 3
        ANIM_STEP 5, 9
        ANIM_STEP 6, 3
        ANIM_STEP 1, 6
        ANIM_HOLD

      _Sequence15
        ANIM_CMD_F7
        ANIM_STEP 8, 3
        ANIM_STEP 1, 5
        ANIM_STEP 2, 4
        ANIM_STEP 3, 4
        ANIM_HOLD

      _Sequence16
        ANIM_STEP 13, 8
        ANIM_STEP 12, 4
        ANIM_STEP 10, 9
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence17
        ANIM_STEP 10, 10
        ANIM_CMD_EE
        ANIM_STEP 10, 2
        ANIM_STEP 22, 1
        ANIM_STEP 23, 1
        ANIM_SOUND 0
        ANIM_STEP 11, 2
        ANIM_STEP 12, 2
        ANIM_STEP 22, 1
        ANIM_STEP 23, 1
        ANIM_SOUND 0
        ANIM_STEP 11, 2
        ANIM_STEP 12, 2
        ANIM_STEP 22, 1
        ANIM_STEP 23, 1
        ANIM_SOUND 0
        ANIM_CMD_F1
        ANIM_STEP 11, 11
        ANIM_STEP 12, 3
        ANIM_STEP 13, 4
        ANIM_STEP 9, 16
        ANIM_CMD_F3
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence18
        ANIM_STEP 10, 12
        ANIM_STEP 13, 1
        ANIM_STEP 10, 1
        ANIM_STEP 13, 1
        ANIM_STEP 24, 1
        ANIM_STEP 13, 1
        ANIM_STEP 25, 1
        ANIM_STEP 22, 1
        ANIM_STEP 23, 1
        ANIM_CMD_F1
        ANIM_SOUND 0
        ANIM_STEP 11, 1
        ANIM_STEP 13, 5
        ANIM_CMD_F3
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence19
        ANIM_CMD_F7
        ANIM_STEP 13, 3
        ANIM_STEP 12, 4
        ANIM_STEP 10, 8
        ANIM_HOLD

      aBattleAnimationFramesFalconKnightStaff ; 9B/822B

        ; Frame table of entry 27: slices of the class sheet per frame.

        .word _Frame00 - aBattleAnimationFramesFalconKnightStaff
        .word _Frame01 - aBattleAnimationFramesFalconKnightStaff
        .word _Frame02 - aBattleAnimationFramesFalconKnightStaff
        .word _Frame03 - aBattleAnimationFramesFalconKnightStaff
        .word _Frame04 - aBattleAnimationFramesFalconKnightStaff
        .word _Frame05 - aBattleAnimationFramesFalconKnightStaff
        .word _Frame06 - aBattleAnimationFramesFalconKnightStaff
        .word _Frame07 - aBattleAnimationFramesFalconKnightStaff
        .word _Frame08 - aBattleAnimationFramesFalconKnightStaff
        .word _Frame09 - aBattleAnimationFramesFalconKnightStaff
        .word _Frame10 - aBattleAnimationFramesFalconKnightStaff
        .word _Frame11 - aBattleAnimationFramesFalconKnightStaff
        .word _Frame12 - aBattleAnimationFramesFalconKnightStaff
        .word _Frame13 - aBattleAnimationFramesFalconKnightStaff
        .word _Frame14 - aBattleAnimationFramesFalconKnightStaff

      _Frame00
        ANIM_TILES
        ANIM_TILE_ROW $0000, $06A0
        ANIM_TILES_END

      _Frame01
        ANIM_TILES
        ANIM_TILE_ROW $06A0, $0640
        ANIM_TILES_END

      _Frame02
        ANIM_TILES
        ANIM_TILE_ROW $0CE0, $05A0
        ANIM_TILES_END

      _Frame03
        ANIM_TILES
        ANIM_TILE_ROW $1280, $04A0
        ANIM_TILES_END

      _Frame04
        ANIM_TILES
        ANIM_TILE_ROW $1720, $0540
        ANIM_TILES_END

      _Frame05
        ANIM_TILES
        ANIM_TILE_ROW $1C60, $05A0
        ANIM_TILES_END

      _Frame06
        ANIM_TILES
        ANIM_TILE_ROW $2200, $0640
        ANIM_TILES_END

      _Frame07
        ANIM_TILES
        ANIM_TILE_ROW $2840, $05C0
        ANIM_TILES_END

      _Frame08
        ANIM_TILES
        ANIM_TILE_ROW $2E00, $0560
        ANIM_TILE_ROW $3360, $0040
        ANIM_TILES_END

      _Frame09
        ANIM_TILES
        ANIM_TILE_ROW $33A0, $0580
        ANIM_TILES_END

      _Frame10
        ANIM_TILES
        ANIM_TILE_ROW $3920, $05E0
        ANIM_TILE_ROW $3F00, $0040
        ANIM_TILES_END

      _Frame11
        ANIM_TILES
        ANIM_TILE_ROW $3F40, $04C0
        ANIM_TILES_END

      _Frame12
        ANIM_TILES
        ANIM_TILE_ROW $4400, $0460
        ANIM_TILES_END

      _Frame13
        ANIM_TILES
        ANIM_TILE_ROW $4860, $0540
        ANIM_TILES_END

      _Frame14
        ANIM_TILES
        ANIM_TILE_ROW $4DA0, $05A0
        ANIM_TILES_END

      aBattleAnimationSequencesFalconKnightStaff ; 9B/829C

        ; Sequence data of entry 27 of aBattleAnimationFrameTables, used by: FalconKnight (Staff).
        ; Frames: aBattleAnimationFramesFalconKnightStaff.

        .word _Index - aBattleAnimationSequencesFalconKnightStaff, _Records - aBattleAnimationSequencesFalconKnightStaff

      _Index
        .word _Sequence00 - aBattleAnimationSequencesFalconKnightStaff
        .word _Sequence01 - aBattleAnimationSequencesFalconKnightStaff
        .word _Sequence02 - aBattleAnimationSequencesFalconKnightStaff
        .word _Sequence03 - aBattleAnimationSequencesFalconKnightStaff
        .word _Sequence04 - aBattleAnimationSequencesFalconKnightStaff
        .word _Sequence05 - aBattleAnimationSequencesFalconKnightStaff
        .word _Sequence06 - aBattleAnimationSequencesFalconKnightStaff
        .word _Sequence07 - aBattleAnimationSequencesFalconKnightStaff
        .word _Sequence08 - aBattleAnimationSequencesFalconKnightStaff
        .word _Sequence09 - aBattleAnimationSequencesFalconKnightStaff

      _Records
        .word _Record00 - aBattleAnimationSequencesFalconKnightStaff
        .word _Record01 - aBattleAnimationSequencesFalconKnightStaff
        .word _Record02 - aBattleAnimationSequencesFalconKnightStaff
        .word _Record03 - aBattleAnimationSequencesFalconKnightStaff
        .word _Record04 - aBattleAnimationSequencesFalconKnightStaff
        .word _Record05 - aBattleAnimationSequencesFalconKnightStaff
        .word _Record06 - aBattleAnimationSequencesFalconKnightStaff
        .word _Record07 - aBattleAnimationSequencesFalconKnightStaff
        .word _Record08 - aBattleAnimationSequencesFalconKnightStaff
        .word _Record09 - aBattleAnimationSequencesFalconKnightStaff
        .word _Record10 - aBattleAnimationSequencesFalconKnightStaff
        .word _Record11 - aBattleAnimationSequencesFalconKnightStaff
        .word _Record12 - aBattleAnimationSequencesFalconKnightStaff
        .word _Record13 - aBattleAnimationSequencesFalconKnightStaff
        .word _Record14 - aBattleAnimationSequencesFalconKnightStaff
        .word _Record15 - aBattleAnimationSequencesFalconKnightStaff
        .word _Record16 - aBattleAnimationSequencesFalconKnightStaff
        .word _Record17 - aBattleAnimationSequencesFalconKnightStaff
        .word _Record18 - aBattleAnimationSequencesFalconKnightStaff
        .word _Record19 - aBattleAnimationSequencesFalconKnightStaff
        .word _Record20 - aBattleAnimationSequencesFalconKnightStaff
        .word _Record21 - aBattleAnimationSequencesFalconKnightStaff
        .word _Record22 - aBattleAnimationSequencesFalconKnightStaff
        .word _Record23 - aBattleAnimationSequencesFalconKnightStaff
        .word _Record24 - aBattleAnimationSequencesFalconKnightStaff
        .word _Record25 - aBattleAnimationSequencesFalconKnightStaff

      _Sequence00
        ANIM_CMD_F7
        ANIM_STEP 13, 16
        ANIM_HOLD

      _Sequence01
        ANIM_STEP 1, 9
        ANIM_STEP 2, 8
        ANIM_STEP 3, 8
        ANIM_STEP 4, 8
        ANIM_STEP 5, 8
        ANIM_STEP 6, 7

      _Sequence02
        ANIM_STEP 1, 9
        ANIM_STEP 2, 8
        ANIM_STEP 3, 8
        ANIM_STEP 4, 8
        ANIM_STEP 5, 8
        ANIM_STEP 6, 7

      _Sequence03
        ANIM_STEP 13, 4
        ANIM_STEP 24, 1
        ANIM_SOUND 32
        ANIM_CMD_F0
        ANIM_CMD_F4 3
        ANIM_STEP 25, 1
        ANIM_CMD_F4 1
        ANIM_STEP 13, 5
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence04
        ANIM_STEP 12, 5
        ANIM_STEP 14, 6
        ANIM_STEP 15, 10
        ANIM_STEP 13, 10
        ANIM_STEP 13, 1
        ANIM_CMD_F4 1
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence05
        ANIM_STEP 16, 48
        ANIM_STEP 17, 32
        ANIM_STEP 18, 5
        ANIM_STEP 19, 4
        ANIM_STEP 20, 5
        ANIM_STEP 21, 64
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence06
        ANIM_STEP 13, 16
        ANIM_STEP 22, 2
        ANIM_STEP 23, 2
        ANIM_STEP 11, 16
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence07
        ANIM_STEP 9, 32
        ANIM_STEP 10, 6
        ANIM_STEP 11, 32

      _Sequence08
        ANIM_STEP 7, 32
        ANIM_STEP 8, 8
        ANIM_STEP 9, 3
        ANIM_STEP 13, 8
        ANIM_STEP 10, 34

      _Sequence09
        ANIM_STEP 7, 32
        ANIM_STEP 8, 8
        ANIM_STEP 9, 8
        ANIM_STEP 10, 18
        ANIM_STEP 11, 16
        ANIM_STEP 12, 48
        ; (no end marker: the next structure begins here)

      _Record00
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (  16,   -2), $00, SpriteSmall, $0F0, 2, 3, true, true
        .structSpriteEntry (   8,   -3), $00, SpriteSmall, $0F1, 2, 3, false, false
        .structSpriteEntry ( -16,   -3), $00, SpriteSmall, $0F1, 2, 3, false, false
        .structSpriteEntry ( -24,   -3), $00, SpriteSmall, $0F0, 2, 3, false, false
        .structSpriteEntry (   0,   -3), $00, SpriteSmall, $0F1, 2, 3, false, false
        .structSpriteEntry (  -8,   -3), $00, SpriteSmall, $0F1, 2, 3, false, false
        ANIM_RECORD_END

      _Record01
        ANIM_RECORD 0
        .structSpriteEntry (  -8,  -45), $21, SpriteLarge, $080, 2, 0, false, false
        .structSpriteEntry (  15,  -83), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (  23,  -67), $00, SpriteSmall, $022, 2, 1, false, false
        .structSpriteEntry (  15,  -67), $00, SpriteSmall, $023, 2, 1, false, false
        .structSpriteEntry (   7,  -67), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry (  17,  -43), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (   1,  -43), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  23,  -51), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry (  23,  -59), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (   7,  -59), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry (  -8,  -29), $21, SpriteLarge, $0A0, 2, 0, false, false
        .structSpriteEntry (  -6,    1), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry (   2,   -7), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry (  -6,   -7), $00, SpriteSmall, $02A, 2, 1, false, false
        .structSpriteEntry ( -22,  -15), $00, SpriteSmall, $02B, 2, 1, false, false
        .structSpriteEntry ( -22,  -23), $00, SpriteSmall, $02C, 2, 1, false, false
        .structSpriteEntry (   2,  -23), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -14,  -23), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry (  10,  -31), $00, SpriteSmall, $02D, 2, 1, false, false
        .structSpriteEntry (   2,  -31), $00, SpriteSmall, $02E, 2, 1, false, false
        .structSpriteEntry (  -6,  -31), $00, SpriteSmall, $02F, 2, 1, false, false
        .structSpriteEntry (  -6,  -39), $00, SpriteSmall, $032, 2, 1, false, false
        .structSpriteEntry ( -22,  -39), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry ( -15,  -36), $21, SpriteLarge, $042, 2, 2, false, false
        .structSpriteEntry ( -31,  -36), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry ( -16,  -71), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry ( -24,  -71), $00, SpriteSmall, $033, 2, 1, false, false
        .structSpriteEntry ( -24,  -63), $00, SpriteSmall, $034, 2, 1, false, false
        .structSpriteEntry ( -18,  -39), $21, SpriteLarge, $00E, 2, 1, false, false
        .structSpriteEntry ( -18,  -55), $21, SpriteLarge, $020, 2, 1, false, false
        ANIM_RECORD_END

      _Record02
        ANIM_RECORD 1
        .structSpriteEntry (  -8,  -44), $21, SpriteLarge, $080, 2, 0, false, false
        .structSpriteEntry (  24,  -72), $00, SpriteSmall, $00E, 2, 1, false, false
        .structSpriteEntry (  16,  -72), $00, SpriteSmall, $00F, 2, 1, false, false
        .structSpriteEntry (  16,  -80), $00, SpriteSmall, $01E, 2, 1, false, false
        .structSpriteEntry (  24,  -64), $00, SpriteSmall, $01F, 2, 1, false, false
        .structSpriteEntry (  16,  -64), $00, SpriteSmall, $020, 2, 1, false, false
        .structSpriteEntry (   0,  -32), $00, SpriteSmall, $021, 2, 1, false, false
        .structSpriteEntry (   8,  -48), $00, SpriteSmall, $022, 2, 1, false, false
        .structSpriteEntry (   8,  -56), $00, SpriteSmall, $023, 2, 1, false, false
        .structSpriteEntry (  16,  -56), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (  24,  -40), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry (   8,  -40), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  -8,  -28), $21, SpriteLarge, $0A0, 2, 0, false, false
        .structSpriteEntry ( -22,  -14), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry ( -22,  -22), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry (   2,  -22), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -14,  -22), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry (  10,   -6), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (   2,   -6), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry (  -6,   -6), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry ( -14,   -6), $00, SpriteSmall, $02A, 2, 1, false, false
        .structSpriteEntry ( -22,   -6), $00, SpriteSmall, $02B, 2, 1, false, false
        .structSpriteEntry (  10,  -30), $00, SpriteSmall, $02C, 2, 1, false, false
        .structSpriteEntry (   2,  -30), $00, SpriteSmall, $02D, 2, 1, false, false
        .structSpriteEntry (  -6,  -30), $00, SpriteSmall, $02E, 2, 1, false, false
        .structSpriteEntry (  -6,  -38), $00, SpriteSmall, $02F, 2, 1, false, false
        .structSpriteEntry ( -22,  -38), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry ( -31,  -35), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry ( -15,  -35), $21, SpriteLarge, $042, 2, 2, false, false
        .structSpriteEntry ( -14,  -34), $00, SpriteSmall, $030, 2, 1, false, false
        .structSpriteEntry ( -22,  -34), $00, SpriteSmall, $031, 2, 1, false, false
        .structSpriteEntry ( -22,  -50), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry ( -22,  -66), $21, SpriteLarge, $00C, 2, 1, false, false
        ANIM_RECORD_END

      _Record03
        ANIM_RECORD 2
        .structSpriteEntry (  -8,  -43), $21, SpriteLarge, $080, 2, 0, false, false
        .structSpriteEntry (  10,  -69), $00, SpriteSmall, $00E, 2, 1, false, false
        .structSpriteEntry (  10,  -61), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   4,  -37), $00, SpriteSmall, $00F, 2, 1, false, false
        .structSpriteEntry (  12,  -45), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  18,  -29), $00, SpriteSmall, $01E, 2, 1, false, false
        .structSpriteEntry (  10,  -29), $00, SpriteSmall, $01F, 2, 1, false, false
        .structSpriteEntry (   2,  -29), $00, SpriteSmall, $020, 2, 1, false, false
        .structSpriteEntry (  -8,  -27), $21, SpriteLarge, $0A0, 2, 0, false, false
        .structSpriteEntry (  10,  -29), $00, SpriteSmall, $021, 2, 1, false, false
        .structSpriteEntry (   2,  -29), $00, SpriteSmall, $022, 2, 1, false, false
        .structSpriteEntry ( -22,  -13), $00, SpriteSmall, $023, 2, 1, false, false
        .structSpriteEntry (   2,  -21), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -14,  -21), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry (  10,   -5), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry (   2,   -5), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (  -6,   -5), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry ( -14,   -5), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry ( -22,   -5), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry (  -6,  -29), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry (  -6,  -37), $00, SpriteSmall, $02A, 2, 1, false, false
        .structSpriteEntry ( -22,  -37), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry ( -15,  -34), $21, SpriteLarge, $042, 2, 2, false, false
        .structSpriteEntry ( -31,  -34), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry ( -14,  -28), $00, SpriteSmall, $02B, 2, 1, false, false
        .structSpriteEntry ( -22,  -28), $00, SpriteSmall, $02C, 2, 1, false, false
        .structSpriteEntry ( -27,  -44), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry ( -27,  -60), $21, SpriteLarge, $00C, 2, 1, false, false
        ANIM_RECORD_END

      _Record04
        ANIM_RECORD 3
        .structSpriteEntry (  -8,  -43), $21, SpriteLarge, $080, 2, 0, false, false
        .structSpriteEntry (  -8,  -27), $21, SpriteLarge, $0A0, 2, 0, false, false
        .structSpriteEntry (   9,  -28), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (   1,  -28), $00, SpriteSmall, $00B, 2, 1, false, false
        .structSpriteEntry (  33,  -28), $00, SpriteSmall, $00C, 2, 1, false, false
        .structSpriteEntry (  33,  -36), $00, SpriteSmall, $00D, 2, 1, false, false
        .structSpriteEntry (  17,  -36), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (  10,   -5), $00, SpriteSmall, $00E, 2, 1, false, false
        .structSpriteEntry (   2,   -5), $00, SpriteSmall, $00F, 2, 1, false, false
        .structSpriteEntry (  -6,   -5), $00, SpriteSmall, $01A, 2, 1, false, false
        .structSpriteEntry ( -14,   -5), $00, SpriteSmall, $01B, 2, 1, false, false
        .structSpriteEntry ( -22,  -13), $00, SpriteSmall, $01C, 2, 1, false, false
        .structSpriteEntry ( -22,  -21), $00, SpriteSmall, $01D, 2, 1, false, false
        .structSpriteEntry (   2,  -21), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry ( -14,  -21), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry (  10,  -29), $00, SpriteSmall, $01E, 2, 1, false, false
        .structSpriteEntry (   2,  -29), $00, SpriteSmall, $01F, 2, 1, false, false
        .structSpriteEntry (  -6,  -29), $00, SpriteSmall, $020, 2, 1, false, false
        .structSpriteEntry (  -6,  -37), $00, SpriteSmall, $021, 2, 1, false, false
        .structSpriteEntry ( -22,  -37), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -31,  -34), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry ( -15,  -34), $21, SpriteLarge, $042, 2, 2, false, false
        .structSpriteEntry ( -20,  -39), $00, SpriteSmall, $022, 2, 1, false, false
        .structSpriteEntry ( -28,  -39), $00, SpriteSmall, $023, 2, 1, false, false
        .structSpriteEntry ( -28,  -47), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry ( -28,  -31), $21, SpriteLarge, $008, 2, 1, false, false
        ANIM_RECORD_END

      _Record05
        ANIM_RECORD 4
        .structSpriteEntry (  -8,  -44), $21, SpriteLarge, $080, 2, 0, false, false
        .structSpriteEntry (  -8,  -28), $21, SpriteLarge, $0A0, 2, 0, false, false
        .structSpriteEntry (   1,  -21), $00, SpriteSmall, $00E, 2, 1, false, false
        .structSpriteEntry (  25,  -21), $00, SpriteSmall, $00F, 2, 1, false, false
        .structSpriteEntry (   9,  -29), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   9,  -13), $00, SpriteSmall, $01E, 2, 1, false, false
        .structSpriteEntry (  24,    3), $00, SpriteSmall, $01F, 2, 1, false, false
        .structSpriteEntry (  17,  -13), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (   1,  -29), $00, SpriteSmall, $020, 2, 1, false, false
        .structSpriteEntry (  10,   -6), $00, SpriteSmall, $021, 2, 1, false, false
        .structSpriteEntry (   2,   -6), $00, SpriteSmall, $022, 2, 1, false, false
        .structSpriteEntry (  -6,   -6), $00, SpriteSmall, $023, 2, 1, false, false
        .structSpriteEntry ( -14,   -6), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry (   2,  -22), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -14,  -22), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry (  10,  -30), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (   2,  -30), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry (  -6,  -30), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (  -6,  -38), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry ( -22,  -38), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry ( -15,  -35), $21, SpriteLarge, $042, 2, 2, false, false
        .structSpriteEntry ( -31,  -35), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry ( -12,  -28), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry ( -28,  -12), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry ( -28,  -28), $21, SpriteLarge, $00C, 2, 1, false, false
        ANIM_RECORD_END

      _Record06
        ANIM_RECORD 5
        .structSpriteEntry (  25,   -6), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (  25,  -14), $00, SpriteSmall, $00B, 2, 1, false, false
        .structSpriteEntry (  17,  -14), $00, SpriteSmall, $00C, 2, 1, false, false
        .structSpriteEntry (  17,  -30), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   9,  -30), $00, SpriteSmall, $00D, 2, 1, false, false
        .structSpriteEntry (   1,  -30), $00, SpriteSmall, $00E, 2, 1, false, false
        .structSpriteEntry (  25,  -38), $00, SpriteSmall, $00F, 2, 1, false, false
        .structSpriteEntry (  17,  -38), $00, SpriteSmall, $01A, 2, 1, false, false
        .structSpriteEntry (  17,  -46), $00, SpriteSmall, $01B, 2, 1, false, false
        .structSpriteEntry (   1,  -46), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  -8,  -46), $21, SpriteLarge, $080, 2, 0, false, false
        .structSpriteEntry (  -8,  -30), $21, SpriteLarge, $0A0, 2, 0, false, false
        .structSpriteEntry ( -22,   -8), $00, SpriteSmall, $01C, 2, 1, false, false
        .structSpriteEntry (   2,   -8), $00, SpriteSmall, $01D, 2, 1, false, false
        .structSpriteEntry (  10,  -16), $00, SpriteSmall, $01E, 2, 1, false, false
        .structSpriteEntry (   2,  -16), $00, SpriteSmall, $01F, 2, 1, false, false
        .structSpriteEntry (  -6,  -16), $00, SpriteSmall, $020, 2, 1, false, false
        .structSpriteEntry (  10,  -24), $00, SpriteSmall, $021, 2, 1, false, false
        .structSpriteEntry (   2,  -24), $00, SpriteSmall, $022, 2, 1, false, false
        .structSpriteEntry (  -6,  -24), $00, SpriteSmall, $023, 2, 1, false, false
        .structSpriteEntry ( -14,   -8), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry ( -22,  -24), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry (  10,  -32), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (   2,  -32), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry (  -6,  -32), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (  -6,  -40), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry ( -22,  -40), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -12,  -38), $21, SpriteLarge, $042, 2, 2, false, false
        .structSpriteEntry ( -28,  -38), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry ( -26,  -11), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry ( -18,  -19), $00, SpriteSmall, $02A, 2, 0, false, false
        .structSpriteEntry ( -26,  -19), $00, SpriteSmall, $02B, 2, 1, false, false
        .structSpriteEntry ( -26,  -35), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry ( -16,  -16), $00, SpriteSmall, $02C, 2, 1, false, false
        ANIM_RECORD_END

      _Record07
        ANIM_RECORD 6
        .structSpriteEntry (  15,  -38), $00, SpriteSmall, $022, 2, 1, false, false
        .structSpriteEntry (   6,  -62), $00, SpriteSmall, $023, 2, 1, false, false
        .structSpriteEntry (  23,  -54), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry (  -1,  -38), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (  15,  -46), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (  15,  -54), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry (  -1,  -54), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  13,  -70), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -12,  -24), $21, SpriteLarge, $0A2, 2, 0, false, false
        .structSpriteEntry ( -12,  -40), $21, SpriteLarge, $082, 2, 0, false, false
        .structSpriteEntry (  24,  -19), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (  16,  -14), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry (   8,  -14), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry (   0,  -14), $00, SpriteSmall, $02A, 2, 1, false, false
        .structSpriteEntry ( -16,  -14), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -24,  -14), $00, SpriteSmall, $02B, 2, 1, false, false
        .structSpriteEntry (   8,  -30), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry (  -8,  -30), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry ( -24,  -30), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry ( -15,  -37), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry ( -31,  -37), $21, SpriteLarge, $044, 2, 2, false, false
        .structSpriteEntry (  -9,  -68), $00, SpriteSmall, $02C, 2, 1, false, false
        .structSpriteEntry ( -11,  -60), $21, SpriteLarge, $00E, 2, 1, false, false
        .structSpriteEntry (  -1,  -36), $00, SpriteSmall, $02D, 2, 1, false, false
        .structSpriteEntry ( -17,  -28), $00, SpriteSmall, $02E, 2, 1, false, false
        .structSpriteEntry (  -1,  -44), $00, SpriteSmall, $02F, 2, 1, false, false
        .structSpriteEntry ( -17,  -44), $21, SpriteLarge, $020, 2, 1, false, false
        ANIM_RECORD_END

      _Record08
        ANIM_RECORD 7
        .structSpriteEntry (  -2,  -40), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (  14,  -40), $00, SpriteSmall, $020, 2, 1, false, false
        .structSpriteEntry (   5,  -64), $00, SpriteSmall, $021, 2, 1, false, false
        .structSpriteEntry (  22,  -56), $00, SpriteSmall, $022, 2, 1, false, false
        .structSpriteEntry (  14,  -48), $00, SpriteSmall, $023, 2, 1, false, false
        .structSpriteEntry (  14,  -56), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry (  -2,  -56), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  12,  -72), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -12,  -27), $21, SpriteLarge, $0A4, 2, 0, false, false
        .structSpriteEntry ( -12,  -43), $21, SpriteLarge, $084, 2, 0, false, false
        .structSpriteEntry (   9,  -14), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (   9,  -22), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry ( -15,   -6), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry ( -15,  -14), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry ( -22,  -38), $00, SpriteSmall, $02A, 2, 1, false, false
        .structSpriteEntry (  -7,  -14), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry (  -7,  -30), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry ( -23,  -30), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry ( -22,  -40), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry ( -22,  -56), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry (  -7,  -70), $00, SpriteSmall, $02B, 2, 1, false, false
        .structSpriteEntry (  -9,  -62), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry (   1,  -38), $00, SpriteSmall, $02C, 2, 1, false, false
        .structSpriteEntry (   1,  -46), $00, SpriteSmall, $02D, 2, 1, false, false
        .structSpriteEntry ( -15,  -46), $21, SpriteLarge, $00E, 2, 1, false, false
        ANIM_RECORD_END

      _Record09
        ANIM_RECORD 8
        .structSpriteEntry (   3,  -48), $00, SpriteSmall, $022, 2, 1, false, false
        .structSpriteEntry (  11,  -48), $00, SpriteSmall, $023, 2, 1, false, false
        .structSpriteEntry (  -5,  -48), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry ( -13,  -48), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (  19,  -40), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   3,  -40), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry ( -13,  -40), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -21,  -28), $21, SpriteLarge, $0A4, 2, 0, false, false
        .structSpriteEntry ( -21,  -44), $21, SpriteLarge, $084, 2, 0, false, false
        .structSpriteEntry ( -23,  -38), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry ( -26,  -14), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (  -2,  -14), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -18,  -14), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry (   0,  -22), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry (   0,  -30), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry ( -16,  -30), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry ( -32,  -30), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry ( -25,  -40), $21, SpriteLarge, $04E, 2, 2, false, false
        .structSpriteEntry ( -25,  -56), $21, SpriteLarge, $04C, 2, 2, false, false
        .structSpriteEntry ( -28,  -44), $21, SpriteLarge, $00E, 2, 1, false, false
        .structSpriteEntry ( -12,  -52), $21, SpriteLarge, $020, 2, 1, false, false
        .structSpriteEntry (   4,  -52), $00, SpriteSmall, $02A, 2, 1, false, false
        ANIM_RECORD_END

      _Record10
        ANIM_RECORD 8
        .structSpriteEntry ( -14,  -56), $21, SpriteLarge, $042, 2, 2, true, true
        .structSpriteEntry (   2,  -56), $21, SpriteLarge, $040, 2, 2, true, true
        .structSpriteEntry (   3,  -48), $00, SpriteSmall, $022, 2, 1, false, false
        .structSpriteEntry (  11,  -48), $00, SpriteSmall, $023, 2, 1, false, false
        .structSpriteEntry (  -5,  -48), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry ( -13,  -48), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (  19,  -40), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   3,  -40), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry ( -13,  -40), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -17,  -31), $21, SpriteLarge, $0A8, 2, 0, false, false
        .structSpriteEntry ( -17,  -47), $21, SpriteLarge, $088, 2, 0, false, false
        .structSpriteEntry ( -23,  -38), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry ( -26,  -14), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (  -2,  -14), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -18,  -14), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry (   0,  -22), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry (   0,  -30), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry ( -16,  -30), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry ( -32,  -30), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry ( -28,  -44), $21, SpriteLarge, $00E, 2, 1, false, false
        .structSpriteEntry ( -12,  -52), $21, SpriteLarge, $020, 2, 1, false, false
        .structSpriteEntry (   4,  -52), $00, SpriteSmall, $02A, 2, 1, false, false
        ANIM_RECORD_END

      _Record11
        ANIM_RECORD 8
        .structSpriteEntry ( -40,  -35), $21, SpriteLarge, $042, 2, 2, false, false
        .structSpriteEntry ( -56,  -35), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry ( -24,  -29), $21, SpriteLarge, $0E9, 2, 0, false, false
        .structSpriteEntry (   3,  -48), $00, SpriteSmall, $022, 2, 1, false, false
        .structSpriteEntry ( -32,  -37), $00, SpriteSmall, $0D8, 2, 0, false, false
        .structSpriteEntry ( -32,  -45), $00, SpriteSmall, $0C8, 2, 0, false, false
        .structSpriteEntry ( -24,  -45), $21, SpriteLarge, $0C9, 2, 0, false, false
        .structSpriteEntry (  11,  -48), $00, SpriteSmall, $023, 2, 1, false, false
        .structSpriteEntry (  -5,  -48), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry ( -13,  -48), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (  19,  -40), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   3,  -40), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry ( -13,  -40), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -23,  -38), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry ( -26,  -14), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (  -2,  -14), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -18,  -14), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry (   0,  -22), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry (   0,  -30), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry ( -16,  -30), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry ( -32,  -30), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry ( -28,  -44), $21, SpriteLarge, $00E, 2, 1, false, false
        .structSpriteEntry ( -12,  -52), $21, SpriteLarge, $020, 2, 1, false, false
        .structSpriteEntry (   4,  -52), $00, SpriteSmall, $02A, 2, 1, false, false
        ANIM_RECORD_END

      _Record12
        ANIM_RECORD 8
        .structSpriteEntry ( -24,  -56), $21, SpriteLarge, $042, 2, 2, true, true
        .structSpriteEntry (  -8,  -56), $21, SpriteLarge, $040, 2, 2, true, true
        .structSpriteEntry ( -22,  -31), $21, SpriteLarge, $0AC, 2, 0, false, false
        .structSpriteEntry (   3,  -48), $00, SpriteSmall, $022, 2, 1, false, false
        .structSpriteEntry (  11,  -48), $00, SpriteSmall, $023, 2, 1, false, false
        .structSpriteEntry (  -5,  -48), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry ( -13,  -48), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (  19,  -40), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   3,  -40), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry ( -13,  -40), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -22,  -47), $21, SpriteLarge, $08C, 2, 0, false, false
        .structSpriteEntry ( -23,  -38), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry ( -26,  -14), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (  -2,  -14), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -18,  -14), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry (   0,  -22), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry (   0,  -30), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry ( -16,  -30), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry ( -32,  -30), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry ( -28,  -44), $21, SpriteLarge, $00E, 2, 1, false, false
        .structSpriteEntry ( -12,  -52), $21, SpriteLarge, $020, 2, 1, false, false
        .structSpriteEntry (   4,  -52), $00, SpriteSmall, $02A, 2, 1, false, false
        ANIM_RECORD_END

      _Record13
        ANIM_RECORD 8
        .structSpriteEntry ( -23,  -55), $21, SpriteLarge, $042, 2, 2, true, true
        .structSpriteEntry (  -7,  -55), $21, SpriteLarge, $040, 2, 2, true, true
        .structSpriteEntry (   3,  -48), $00, SpriteSmall, $022, 2, 1, false, false
        .structSpriteEntry (  11,  -48), $00, SpriteSmall, $023, 2, 1, false, false
        .structSpriteEntry (  -5,  -48), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry ( -13,  -48), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (  19,  -40), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   3,  -40), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry ( -13,  -40), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -22,  -30), $21, SpriteLarge, $0AA, 2, 0, false, false
        .structSpriteEntry ( -22,  -46), $21, SpriteLarge, $08A, 2, 0, false, false
        .structSpriteEntry ( -23,  -38), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry ( -26,  -14), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (  -2,  -14), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -18,  -14), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry (   0,  -22), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry (   0,  -30), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry ( -16,  -30), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry ( -32,  -30), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry ( -28,  -44), $21, SpriteLarge, $00E, 2, 1, false, false
        .structSpriteEntry ( -12,  -52), $21, SpriteLarge, $020, 2, 1, false, false
        .structSpriteEntry (   4,  -52), $00, SpriteSmall, $02A, 2, 1, false, false
        ANIM_RECORD_END

      _Record14
        ANIM_RECORD 9
        .structSpriteEntry ( -22,  -48), $21, SpriteLarge, $046, 2, 2, true, true
        .structSpriteEntry (  -6,  -48), $21, SpriteLarge, $044, 2, 2, true, true
        .structSpriteEntry ( -12,  -32), $21, SpriteLarge, $0AE, 2, 0, false, false
        .structSpriteEntry (  28,  -40), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (  20,  -48), $00, SpriteSmall, $020, 2, 1, false, false
        .structSpriteEntry (  12,  -48), $00, SpriteSmall, $021, 2, 1, false, false
        .structSpriteEntry (   4,  -48), $00, SpriteSmall, $022, 2, 1, false, false
        .structSpriteEntry (  -4,  -48), $00, SpriteSmall, $023, 2, 1, false, false
        .structSpriteEntry (  12,  -40), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  -4,  -40), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -20,  -33), $00, SpriteSmall, $0E0, 2, 0, false, false
        .structSpriteEntry ( -20,  -48), $00, SpriteSmall, $0D0, 2, 0, false, false
        .structSpriteEntry ( -12,  -48), $21, SpriteLarge, $08E, 2, 0, false, false
        .structSpriteEntry ( -15,   -8), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry ( -15,  -16), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry ( -22,  -40), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry ( -14,  -40), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (   9,  -16), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry (   9,  -24), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry (  -7,  -16), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry (  -7,  -32), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry ( -23,  -32), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry (   2,  -53), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry (  18,  -53), $00, SpriteSmall, $02A, 2, 1, false, false
        .structSpriteEntry (  18,  -45), $00, SpriteSmall, $02B, 2, 1, false, false
        .structSpriteEntry ( -14,  -45), $21, SpriteLarge, $00E, 2, 1, false, false
        ANIM_RECORD_END

      _Record15
        ANIM_RECORD 10
        .structSpriteEntry ( -11,  -44), $21, SpriteLarge, $04A, 2, 2, true, true
        .structSpriteEntry ( -11,  -28), $21, SpriteLarge, $048, 2, 2, true, true
        .structSpriteEntry (   5,  -40), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (  21,  -40), $00, SpriteSmall, $022, 2, 1, false, false
        .structSpriteEntry (  12,  -64), $00, SpriteSmall, $023, 2, 1, false, false
        .structSpriteEntry (  29,  -56), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry (  21,  -48), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (  21,  -56), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry (   5,  -56), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  19,  -72), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -11,  -41), $00, SpriteSmall, $0C1, 2, 0, false, false
        .structSpriteEntry (  -3,  -26), $21, SpriteLarge, $0E2, 2, 0, false, false
        .structSpriteEntry (  -3,  -42), $21, SpriteLarge, $0C2, 2, 0, false, false
        .structSpriteEntry (  16,  -14), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (  16,  -22), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry (  16,  -30), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry (   0,  -14), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -16,  -14), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry (   0,  -30), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry ( -16,  -30), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry (   2,  -69), $00, SpriteSmall, $02A, 2, 1, false, false
        .structSpriteEntry (   0,  -61), $21, SpriteLarge, $00E, 2, 1, false, false
        .structSpriteEntry (  10,  -37), $00, SpriteSmall, $02B, 2, 1, false, false
        .structSpriteEntry (   2,  -29), $00, SpriteSmall, $02C, 2, 1, false, false
        .structSpriteEntry (  -6,  -29), $00, SpriteSmall, $02D, 2, 1, false, false
        .structSpriteEntry (  10,  -45), $00, SpriteSmall, $02E, 2, 1, false, false
        .structSpriteEntry (  -6,  -45), $21, SpriteLarge, $020, 2, 1, false, false
        ANIM_RECORD_END

      _Record16
        ANIM_RECORD 6
        .structSpriteEntry ( -15,  -45), $21, SpriteLarge, $046, 2, 2, false, true
        .structSpriteEntry ( -31,  -45), $21, SpriteLarge, $044, 2, 2, false, true
        .structSpriteEntry (  15,  -38), $00, SpriteSmall, $022, 2, 1, false, false
        .structSpriteEntry (   6,  -62), $00, SpriteSmall, $023, 2, 1, false, false
        .structSpriteEntry (  23,  -54), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry (  -1,  -38), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (  15,  -46), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (  15,  -54), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry (  -1,  -54), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  13,  -70), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -12,  -26), $21, SpriteLarge, $0E4, 2, 0, false, false
        .structSpriteEntry ( -12,  -42), $21, SpriteLarge, $0C4, 2, 0, false, false
        .structSpriteEntry (  24,  -19), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (  16,  -14), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry (   8,  -14), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry (   0,  -14), $00, SpriteSmall, $02A, 2, 1, false, false
        .structSpriteEntry ( -16,  -14), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -24,  -14), $00, SpriteSmall, $02B, 2, 1, false, false
        .structSpriteEntry (   8,  -30), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry (  -8,  -30), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry ( -24,  -30), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry (  -9,  -68), $00, SpriteSmall, $02C, 2, 1, false, false
        .structSpriteEntry ( -11,  -60), $21, SpriteLarge, $00E, 2, 1, false, false
        .structSpriteEntry (  -1,  -36), $00, SpriteSmall, $02D, 2, 1, false, false
        .structSpriteEntry ( -17,  -28), $00, SpriteSmall, $02E, 2, 1, false, false
        .structSpriteEntry (  -1,  -44), $00, SpriteSmall, $02F, 2, 1, false, false
        .structSpriteEntry ( -17,  -44), $21, SpriteLarge, $020, 2, 1, false, false
        ANIM_RECORD_END

      _Record17
        ANIM_RECORD 7
        .structSpriteEntry (  -6,  -52), $21, SpriteLarge, $046, 2, 2, false, true
        .structSpriteEntry ( -22,  -52), $21, SpriteLarge, $044, 2, 2, false, true
        .structSpriteEntry (  -2,  -40), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (  14,  -40), $00, SpriteSmall, $020, 2, 1, false, false
        .structSpriteEntry (   5,  -64), $00, SpriteSmall, $021, 2, 1, false, false
        .structSpriteEntry (  22,  -56), $00, SpriteSmall, $022, 2, 1, false, false
        .structSpriteEntry (  14,  -48), $00, SpriteSmall, $023, 2, 1, false, false
        .structSpriteEntry (  14,  -56), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry (  -2,  -56), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  12,  -72), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry (  -8,  -31), $21, SpriteLarge, $0A8, 2, 0, false, false
        .structSpriteEntry (  -8,  -47), $21, SpriteLarge, $088, 2, 0, false, false
        .structSpriteEntry (   9,  -14), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (   9,  -22), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry ( -15,   -6), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry ( -15,  -14), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry ( -22,  -38), $00, SpriteSmall, $02A, 2, 1, false, false
        .structSpriteEntry (  -7,  -14), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry (  -7,  -30), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry ( -23,  -30), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry (  -7,  -70), $00, SpriteSmall, $02B, 2, 1, false, false
        .structSpriteEntry (  -9,  -62), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry (   1,  -38), $00, SpriteSmall, $02C, 2, 1, false, false
        .structSpriteEntry (   1,  -46), $00, SpriteSmall, $02D, 2, 1, false, false
        .structSpriteEntry ( -15,  -46), $21, SpriteLarge, $00E, 2, 1, false, false
        ANIM_RECORD_END

      _Record18
        ANIM_RECORD 11
        .structSpriteEntry (  -6,  -51), $21, SpriteLarge, $046, 2, 2, false, true
        .structSpriteEntry ( -22,  -51), $21, SpriteLarge, $044, 2, 2, false, true
        .structSpriteEntry (   2,  -38), $00, SpriteSmall, $00C, 2, 1, false, false
        .structSpriteEntry (  16,  -30), $00, SpriteSmall, $00D, 2, 1, false, false
        .structSpriteEntry (   8,  -30), $00, SpriteSmall, $00E, 2, 1, false, false
        .structSpriteEntry (   0,  -30), $00, SpriteSmall, $00F, 2, 1, false, false
        .structSpriteEntry (   8,  -70), $00, SpriteSmall, $01C, 2, 1, false, false
        .structSpriteEntry (  10,  -46), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   8,  -62), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  -8,  -31), $21, SpriteLarge, $0A8, 2, 0, false, false
        .structSpriteEntry (  -8,  -47), $21, SpriteLarge, $088, 2, 0, false, false
        .structSpriteEntry (   9,  -14), $00, SpriteSmall, $01D, 2, 1, false, false
        .structSpriteEntry (   9,  -22), $00, SpriteSmall, $01E, 2, 1, false, false
        .structSpriteEntry ( -15,   -6), $00, SpriteSmall, $01F, 2, 1, false, false
        .structSpriteEntry ( -15,  -14), $00, SpriteSmall, $020, 2, 1, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $021, 2, 1, false, false
        .structSpriteEntry ( -22,  -38), $00, SpriteSmall, $022, 2, 1, false, false
        .structSpriteEntry (  -7,  -14), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry (  -7,  -30), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -23,  -30), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry ( -21,  -54), $00, SpriteSmall, $023, 2, 1, false, false
        .structSpriteEntry ( -13,  -46), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry ( -21,  -46), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry ( -21,  -38), $21, SpriteLarge, $00A, 2, 1, false, false
        ANIM_RECORD_END

      _Record19
        ANIM_RECORD 12
        .structSpriteEntry ( -34,  -21), $21, SpriteLarge, $048, 2, 2, false, true
        .structSpriteEntry ( -34,  -37), $21, SpriteLarge, $04A, 2, 2, false, true
        .structSpriteEntry ( -24,  -37), $00, SpriteSmall, $0D8, 2, 0, false, false
        .structSpriteEntry ( -24,  -45), $00, SpriteSmall, $0C8, 2, 0, false, false
        .structSpriteEntry ( -16,  -29), $21, SpriteLarge, $0E9, 2, 0, false, false
        .structSpriteEntry ( -16,  -45), $21, SpriteLarge, $0C9, 2, 0, false, false
        .structSpriteEntry (  -2,  -22), $00, SpriteSmall, $00C, 2, 1, false, false
        .structSpriteEntry (  22,  -22), $00, SpriteSmall, $00D, 2, 1, false, false
        .structSpriteEntry (   6,  -30), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   6,  -14), $00, SpriteSmall, $00E, 2, 1, false, false
        .structSpriteEntry (  21,    2), $00, SpriteSmall, $00F, 2, 1, false, false
        .structSpriteEntry (  14,  -14), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  -2,  -30), $00, SpriteSmall, $01C, 2, 1, false, false
        .structSpriteEntry (   9,  -14), $00, SpriteSmall, $01D, 2, 1, false, false
        .structSpriteEntry ( -15,   -6), $00, SpriteSmall, $01E, 2, 1, false, false
        .structSpriteEntry ( -15,  -14), $00, SpriteSmall, $01F, 2, 1, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $020, 2, 1, false, false
        .structSpriteEntry ( -22,  -38), $00, SpriteSmall, $021, 2, 1, false, false
        .structSpriteEntry (  -7,  -14), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry (  -7,  -30), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -23,  -30), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry ( -22,   -3), $00, SpriteSmall, $022, 2, 1, false, false
        .structSpriteEntry ( -22,  -19), $21, SpriteLarge, $00A, 2, 1, false, false
        ANIM_RECORD_END

      _Record20
        ANIM_RECORD 13
        .structSpriteEntry ( -32,  -24), $21, SpriteLarge, $048, 2, 2, false, true
        .structSpriteEntry ( -32,  -40), $21, SpriteLarge, $04A, 2, 2, false, true
        .structSpriteEntry ( -24,  -38), $00, SpriteSmall, $0C0, 2, 0, false, false
        .structSpriteEntry ( -16,  -29), $21, SpriteLarge, $0A6, 2, 0, false, false
        .structSpriteEntry ( -16,  -45), $21, SpriteLarge, $086, 2, 0, false, false
        .structSpriteEntry (  23,   -3), $00, SpriteSmall, $00E, 2, 1, false, false
        .structSpriteEntry (   7,  -27), $00, SpriteSmall, $00F, 2, 1, false, false
        .structSpriteEntry (  23,  -11), $00, SpriteSmall, $01E, 2, 1, false, false
        .structSpriteEntry (  15,  -11), $00, SpriteSmall, $01F, 2, 1, false, false
        .structSpriteEntry (  -1,  -27), $00, SpriteSmall, $020, 2, 1, false, false
        .structSpriteEntry (  23,  -35), $00, SpriteSmall, $021, 2, 1, false, false
        .structSpriteEntry (  15,  -35), $00, SpriteSmall, $022, 2, 1, false, false
        .structSpriteEntry (  15,  -43), $00, SpriteSmall, $023, 2, 1, false, false
        .structSpriteEntry (  15,  -27), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (  -1,  -43), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (   9,  -14), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry (   9,  -22), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry ( -15,   -6), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry ( -15,  -14), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry ( -22,  -38), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry (  -7,  -14), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry (  -7,  -30), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -23,  -30), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry ( -27,  -17), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry ( -27,  -33), $21, SpriteLarge, $00C, 2, 1, false, false
        ANIM_RECORD_END

      _Record21
        ANIM_RECORD 14
        .structSpriteEntry ( -13,  -51), $21, SpriteLarge, $046, 2, 2, false, true
        .structSpriteEntry ( -29,  -51), $21, SpriteLarge, $044, 2, 2, false, true
        .structSpriteEntry (  14,  -46), $00, SpriteSmall, $020, 2, 1, false, false
        .structSpriteEntry (  14,  -38), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -10,  -31), $21, SpriteLarge, $0E6, 2, 0, false, false
        .structSpriteEntry (  -2,  -38), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  -6,  -31), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry (  10,  -23), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry (   2,  -15), $00, SpriteSmall, $021, 2, 1, false, false
        .structSpriteEntry (  -6,  -15), $00, SpriteSmall, $022, 2, 1, false, false
        .structSpriteEntry ( -14,  -15), $00, SpriteSmall, $023, 2, 1, false, false
        .structSpriteEntry ( -10,  -47), $21, SpriteLarge, $0C6, 2, 0, false, false
        .structSpriteEntry (  22,  -46), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry (   6,  -46), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (  -2,  -46), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry (  30,  -38), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry ( -14,  -39), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (  18,    1), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry (  18,   -7), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry (  10,   -7), $00, SpriteSmall, $02A, 2, 1, false, false
        .structSpriteEntry ( -22,  -15), $00, SpriteSmall, $02B, 2, 1, false, false
        .structSpriteEntry ( -22,  -31), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry ( -17,  -42), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry (  15,  -50), $00, SpriteSmall, $02C, 2, 1, false, false
        .structSpriteEntry (  -1,  -50), $21, SpriteLarge, $00E, 2, 1, false, false
        ANIM_RECORD_END

      _Record22
        ANIM_RECORD 8
        .structSpriteEntry ( -36,  -45), $00, SpriteSmall, $0DC, 2, 2, false, false
        .structSpriteEntry ( -44,  -45), $00, SpriteSmall, $0CC, 2, 2, false, false
        .structSpriteEntry ( -52,  -45), $00, SpriteSmall, $0CB, 2, 2, false, false
        .structSpriteEntry ( -24,  -29), $21, SpriteLarge, $0E9, 2, 0, false, false
        .structSpriteEntry (   3,  -48), $00, SpriteSmall, $022, 2, 1, false, false
        .structSpriteEntry ( -32,  -37), $00, SpriteSmall, $0D8, 2, 0, false, false
        .structSpriteEntry ( -32,  -45), $00, SpriteSmall, $0C8, 2, 0, false, false
        .structSpriteEntry ( -24,  -45), $21, SpriteLarge, $0C9, 2, 0, false, false
        .structSpriteEntry (  11,  -48), $00, SpriteSmall, $023, 2, 1, false, false
        .structSpriteEntry (  -5,  -48), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry ( -13,  -48), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (  19,  -40), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   3,  -40), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry ( -13,  -40), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -23,  -38), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry ( -26,  -14), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (  -2,  -14), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -18,  -14), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry (   0,  -22), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry (   0,  -30), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry ( -16,  -30), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry ( -32,  -30), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry ( -28,  -44), $21, SpriteLarge, $00E, 2, 1, false, false
        .structSpriteEntry ( -12,  -52), $21, SpriteLarge, $020, 2, 1, false, false
        .structSpriteEntry (   4,  -52), $00, SpriteSmall, $02A, 2, 1, false, false
        ANIM_RECORD_END

      _Record23
        ANIM_RECORD 8
        .structSpriteEntry ( -56,  -38), $00, SpriteSmall, $0EC, 2, 2, false, false
        .structSpriteEntry ( -64,  -30), $00, SpriteSmall, $0EB, 2, 2, false, false
        .structSpriteEntry ( -64,  -38), $00, SpriteSmall, $0DB, 2, 2, false, false
        .structSpriteEntry ( -24,  -29), $21, SpriteLarge, $0E9, 2, 0, false, false
        .structSpriteEntry (   3,  -48), $00, SpriteSmall, $022, 2, 1, false, false
        .structSpriteEntry ( -32,  -37), $00, SpriteSmall, $0D8, 2, 0, false, false
        .structSpriteEntry ( -32,  -45), $00, SpriteSmall, $0C8, 2, 0, false, false
        .structSpriteEntry ( -24,  -45), $21, SpriteLarge, $0C9, 2, 0, false, false
        .structSpriteEntry (  11,  -48), $00, SpriteSmall, $023, 2, 1, false, false
        .structSpriteEntry (  -5,  -48), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry ( -13,  -48), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (  19,  -40), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   3,  -40), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry ( -13,  -40), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -23,  -38), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry ( -26,  -14), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (  -2,  -14), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -18,  -14), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry (   0,  -22), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry (   0,  -30), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry ( -16,  -30), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry ( -32,  -30), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry ( -28,  -44), $21, SpriteLarge, $00E, 2, 1, false, false
        .structSpriteEntry ( -12,  -52), $21, SpriteLarge, $020, 2, 1, false, false
        .structSpriteEntry (   4,  -52), $00, SpriteSmall, $02A, 2, 1, false, false
        ANIM_RECORD_END

      _Record24
        ANIM_RECORD 8
        .structSpriteEntry ( -22,  -31), $21, SpriteLarge, $0AC, 2, 0, false, false
        .structSpriteEntry (   3,  -48), $00, SpriteSmall, $022, 2, 1, false, false
        .structSpriteEntry (  11,  -48), $00, SpriteSmall, $023, 2, 1, false, false
        .structSpriteEntry (  -5,  -48), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry ( -13,  -48), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (  19,  -40), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   3,  -40), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry ( -13,  -40), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -22,  -47), $21, SpriteLarge, $08C, 2, 0, false, false
        .structSpriteEntry ( -23,  -38), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry ( -26,  -14), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (  -2,  -14), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -18,  -14), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry (   0,  -22), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry (   0,  -30), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry ( -16,  -30), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry ( -32,  -30), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry ( -28,  -44), $21, SpriteLarge, $00E, 2, 1, false, false
        .structSpriteEntry ( -23,  -69), $21, SpriteLarge, $04C, 2, 2, false, false
        .structSpriteEntry ( -23,  -53), $21, SpriteLarge, $04E, 2, 2, false, false
        .structSpriteEntry ( -12,  -52), $21, SpriteLarge, $020, 2, 1, false, false
        .structSpriteEntry (   4,  -52), $00, SpriteSmall, $02A, 2, 1, false, false
        ANIM_RECORD_END

      _Record25
        ANIM_RECORD 8
        .structSpriteEntry ( -36,  -47), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry ( -52,  -47), $21, SpriteLarge, $044, 2, 2, false, false
        .structSpriteEntry ( -30,  -38), $00, SpriteSmall, $0E1, 2, 0, false, false
        .structSpriteEntry ( -22,  -29), $21, SpriteLarge, $0A6, 2, 0, false, false
        .structSpriteEntry (   3,  -48), $00, SpriteSmall, $022, 2, 1, false, false
        .structSpriteEntry (  11,  -48), $00, SpriteSmall, $023, 2, 1, false, false
        .structSpriteEntry (  -5,  -48), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry ( -13,  -48), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (  19,  -40), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   3,  -40), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry ( -13,  -40), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -22,  -45), $21, SpriteLarge, $086, 2, 0, false, false
        .structSpriteEntry ( -23,  -38), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry ( -26,  -14), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (  -2,  -14), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -18,  -14), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry (   0,  -22), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry (   0,  -30), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry ( -16,  -30), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry ( -32,  -30), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry ( -28,  -44), $21, SpriteLarge, $00E, 2, 1, false, false
        .structSpriteEntry ( -12,  -52), $21, SpriteLarge, $020, 2, 1, false, false
        .structSpriteEntry (   4,  -52), $00, SpriteSmall, $02A, 2, 1, false, false
        ANIM_RECORD_END

      aBattleAnimationFramesPegasusKnightLance ; 9B/904E

        ; Frame table of entry 25: slices of the class sheet per frame.

        .word _Frame00 - aBattleAnimationFramesPegasusKnightLance
        .word _Frame01 - aBattleAnimationFramesPegasusKnightLance
        .word _Frame02 - aBattleAnimationFramesPegasusKnightLance
        .word _Frame03 - aBattleAnimationFramesPegasusKnightLance
        .word _Frame04 - aBattleAnimationFramesPegasusKnightLance
        .word _Frame05 - aBattleAnimationFramesPegasusKnightLance
        .word _Frame06 - aBattleAnimationFramesPegasusKnightLance
        .word _Frame07 - aBattleAnimationFramesPegasusKnightLance
        .word _Frame08 - aBattleAnimationFramesPegasusKnightLance
        .word _Frame09 - aBattleAnimationFramesPegasusKnightLance
        .word _Frame10 - aBattleAnimationFramesPegasusKnightLance
        .word _Frame11 - aBattleAnimationFramesPegasusKnightLance
        .word _Frame12 - aBattleAnimationFramesPegasusKnightLance
        .word _Frame13 - aBattleAnimationFramesPegasusKnightLance
        .word _Frame14 - aBattleAnimationFramesPegasusKnightLance

      _Frame00
        ANIM_TILES
        ANIM_TILE_ROW $0000, $06A0
        ANIM_TILES_END

      _Frame01
        ANIM_TILES
        ANIM_TILE_ROW $06A0, $0640
        ANIM_TILES_END

      _Frame02
        ANIM_TILES
        ANIM_TILE_ROW $0CE0, $05A0
        ANIM_TILES_END

      _Frame03
        ANIM_TILES
        ANIM_TILE_ROW $1280, $04A0
        ANIM_TILES_END

      _Frame04
        ANIM_TILES
        ANIM_TILE_ROW $1720, $0540
        ANIM_TILES_END

      _Frame05
        ANIM_TILES
        ANIM_TILE_ROW $1C60, $05A0
        ANIM_TILES_END

      _Frame06
        ANIM_TILES
        ANIM_TILE_ROW $2200, $0640
        ANIM_TILES_END

      _Frame07
        ANIM_TILES
        ANIM_TILE_ROW $2840, $05C0
        ANIM_TILES_END

      _Frame08
        ANIM_TILES
        ANIM_TILE_ROW $2E00, $0560
        ANIM_TILE_ROW $3360, $0040
        ANIM_TILES_END

      _Frame09
        ANIM_TILES
        ANIM_TILE_ROW $33A0, $0580
        ANIM_TILES_END

      _Frame10
        ANIM_TILES
        ANIM_TILE_ROW $3920, $05E0
        ANIM_TILE_ROW $3F00, $0040
        ANIM_TILES_END

      _Frame11
        ANIM_TILES
        ANIM_TILE_ROW $3F40, $04C0
        ANIM_TILES_END

      _Frame12
        ANIM_TILES
        ANIM_TILE_ROW $4400, $0460
        ANIM_TILES_END

      _Frame13
        ANIM_TILES
        ANIM_TILE_ROW $4860, $0540
        ANIM_TILES_END

      _Frame14
        ANIM_TILES
        ANIM_TILE_ROW $4DA0, $05A0
        ANIM_TILES_END

      aBattleAnimationSequencesPegasusKnightLance ; 9B/90BF

        ; Sequence data of entry 25 of aBattleAnimationFrameTables, used by: PegasusKnight
        ; (Lance), FalconKnight (Lance). Frames: aBattleAnimationFramesPegasusKnightLance.

        .word _Index - aBattleAnimationSequencesPegasusKnightLance, _Records - aBattleAnimationSequencesPegasusKnightLance

      _Index
        .word _Sequence00 - aBattleAnimationSequencesPegasusKnightLance
        .word _Sequence01 - aBattleAnimationSequencesPegasusKnightLance
        .word _Sequence02 - aBattleAnimationSequencesPegasusKnightLance
        .word _Sequence03 - aBattleAnimationSequencesPegasusKnightLance
        .word _Sequence04 - aBattleAnimationSequencesPegasusKnightLance
        .word _Sequence05 - aBattleAnimationSequencesPegasusKnightLance
        .word _Sequence06 - aBattleAnimationSequencesPegasusKnightLance
        .word _Sequence07 - aBattleAnimationSequencesPegasusKnightLance
        .word _Sequence08 - aBattleAnimationSequencesPegasusKnightLance
        .word _Sequence09 - aBattleAnimationSequencesPegasusKnightLance
        .word _Sequence10 - aBattleAnimationSequencesPegasusKnightLance
        .word _Sequence11 - aBattleAnimationSequencesPegasusKnightLance
        .word _Sequence12 - aBattleAnimationSequencesPegasusKnightLance
        .word _Sequence13 - aBattleAnimationSequencesPegasusKnightLance
        .word _Sequence14 - aBattleAnimationSequencesPegasusKnightLance
        .word _Sequence15 - aBattleAnimationSequencesPegasusKnightLance
        .word _Sequence16 - aBattleAnimationSequencesPegasusKnightLance
        .word _Sequence17 - aBattleAnimationSequencesPegasusKnightLance
        .word _Sequence18 - aBattleAnimationSequencesPegasusKnightLance
        .word _Sequence19 - aBattleAnimationSequencesPegasusKnightLance
        .word _Sequence20 - aBattleAnimationSequencesPegasusKnightLance

      _Records
        .word aBattleAnimationSequencesPegasusKnightRangedLance._Record00 - aBattleAnimationSequencesPegasusKnightLance
        .word aBattleAnimationSequencesPegasusKnightRangedLance._Record01 - aBattleAnimationSequencesPegasusKnightLance
        .word aBattleAnimationSequencesPegasusKnightRangedLance._Record02 - aBattleAnimationSequencesPegasusKnightLance
        .word aBattleAnimationSequencesPegasusKnightRangedLance._Record03 - aBattleAnimationSequencesPegasusKnightLance
        .word aBattleAnimationSequencesPegasusKnightRangedLance._Record04 - aBattleAnimationSequencesPegasusKnightLance
        .word aBattleAnimationSequencesPegasusKnightRangedLance._Record05 - aBattleAnimationSequencesPegasusKnightLance
        .word aBattleAnimationSequencesPegasusKnightRangedLance._Record06 - aBattleAnimationSequencesPegasusKnightLance
        .word aBattleAnimationSequencesPegasusKnightRangedLance._Record07 - aBattleAnimationSequencesPegasusKnightLance
        .word aBattleAnimationSequencesPegasusKnightRangedLance._Record08 - aBattleAnimationSequencesPegasusKnightLance
        .word aBattleAnimationSequencesPegasusKnightRangedLance._Record09 - aBattleAnimationSequencesPegasusKnightLance
        .word aBattleAnimationSequencesPegasusKnightRangedLance._Record10 - aBattleAnimationSequencesPegasusKnightLance
        .word aBattleAnimationSequencesPegasusKnightRangedLance._Record11 - aBattleAnimationSequencesPegasusKnightLance
        .word aBattleAnimationSequencesPegasusKnightRangedLance._Record12 - aBattleAnimationSequencesPegasusKnightLance
        .word aBattleAnimationSequencesPegasusKnightRangedLance._Record13 - aBattleAnimationSequencesPegasusKnightLance
        .word aBattleAnimationSequencesPegasusKnightRangedLance._Record14 - aBattleAnimationSequencesPegasusKnightLance
        .word aBattleAnimationSequencesPegasusKnightRangedLance._Record15 - aBattleAnimationSequencesPegasusKnightLance
        .word aBattleAnimationSequencesPegasusKnightRangedLance._Record16 - aBattleAnimationSequencesPegasusKnightLance
        .word aBattleAnimationSequencesPegasusKnightRangedLance._Record17 - aBattleAnimationSequencesPegasusKnightLance
        .word aBattleAnimationSequencesPegasusKnightRangedLance._Record18 - aBattleAnimationSequencesPegasusKnightLance
        .word aBattleAnimationSequencesPegasusKnightRangedLance._Record19 - aBattleAnimationSequencesPegasusKnightLance
        .word aBattleAnimationSequencesPegasusKnightRangedLance._Record20 - aBattleAnimationSequencesPegasusKnightLance
        .word aBattleAnimationSequencesPegasusKnightRangedLance._Record21 - aBattleAnimationSequencesPegasusKnightLance
        .word aBattleAnimationSequencesPegasusKnightRangedLance._Record22 - aBattleAnimationSequencesPegasusKnightLance
        .word aBattleAnimationSequencesPegasusKnightRangedLance._Record23 - aBattleAnimationSequencesPegasusKnightLance
        .word aBattleAnimationSequencesPegasusKnightRangedLance._Record24 - aBattleAnimationSequencesPegasusKnightLance
        .word aBattleAnimationSequencesPegasusKnightRangedLance._Record25 - aBattleAnimationSequencesPegasusKnightLance
        .word aBattleAnimationSequencesPegasusKnightRangedLance._Record26 - aBattleAnimationSequencesPegasusKnightLance

      _Sequence00
        ANIM_CMD_ED 2
        ANIM_CMD_F7
        ANIM_STEP 9, 1
        ANIM_HOLD

      _Sequence01
        ANIM_CMD_EB
        ANIM_CMD_F7
        ANIM_STEP 1, 9
        ANIM_STEP 2, 8
        ANIM_STEP 3, 8
        ANIM_STEP 4, 8
        ANIM_SOUND 21
        ANIM_STEP 5, 8
        ANIM_STEP 6, 7
        ANIM_RESTART
        ANIM_HOLD

      _Sequence02
        ANIM_CMD_F7
        ANIM_STEP 1, 32
        ANIM_HOLD

      _Sequence03
        ANIM_STEP 9, 3
        ANIM_STEP 13, 4
        ANIM_CMD_EE
        ANIM_STEP 13, 1
        ANIM_STEP 10, 10
        ANIM_SOUND 4
        ANIM_STEP 11, 5
        ANIM_CMD_F1
        ANIM_STEP 11, 6
        ANIM_CMD_F3
        ANIM_STEP 12, 5
        ANIM_STEP 13, 3
        ANIM_STEP 9, 16
        ANIM_CMD_ED 3
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence04
        ANIM_STEP 12, 5
        ANIM_STEP 14, 6
        ANIM_STEP 15, 10
        ANIM_STEP 14, 10
        ANIM_STEP 13, 1
        ANIM_CMD_F4 1
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence05
        ANIM_CMD_EE
        ANIM_SOUND 27
        ANIM_STEP 7, 16
        ANIM_STEP 17, 4
        ANIM_STEP 18, 2
        ANIM_STEP 19, 2
        ANIM_STEP 20, 3
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence06
        ANIM_STEP 11, 16
        ANIM_STEP 13, 16
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence07
        ANIM_STEP 9, 32
        ANIM_STEP 10, 6
        ANIM_STEP 11, 32
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence08
        ANIM_CMD_EE
        ANIM_STEP 8, 8
        ANIM_STEP 9, 3
        ANIM_STEP 13, 8
        ANIM_STEP 10, 34
        ANIM_CMD_F1
        ANIM_SOUND 0
        ANIM_STEP 11, 8
        ANIM_STEP 12, 16
        ANIM_STEP 13, 4
        ANIM_STEP 9, 5
        ANIM_CMD_F3
        ANIM_CMD_ED 3
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence09
        ANIM_STEP 9, 6
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence10
        ANIM_CMD_F7
        ANIM_SOUND 27
        ANIM_STEP 7, 1
        ANIM_HOLD

      _Sequence11
        ANIM_STEP 8, 10
        ANIM_STEP 9, 1
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence12
        ANIM_STEP 21, 13
        ANIM_STEP 7, 16
        ANIM_STEP 8, 4
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence13
        ANIM_CMD_F7
        ANIM_SOUND 4
        ANIM_CMD_F1
        ANIM_CMD_F3
        ANIM_CMD_ED 3
        ANIM_STEP 21, 1
        ANIM_HOLD

      _Sequence14
        ANIM_STEP 9, 3
        ANIM_STEP 13, 8
        ANIM_STEP 10, 34
        ANIM_CMD_F1
        ANIM_SOUND 0
        ANIM_STEP 11, 8
        ANIM_STEP 12, 16
        ANIM_STEP 13, 4
        ANIM_STEP 9, 5
        ANIM_CMD_ED 3
        ANIM_CMD_F3
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence15
        ANIM_CMD_F7
        ANIM_STEP 4, 3
        ANIM_SOUND 21
        ANIM_STEP 5, 9
        ANIM_STEP 6, 3
        ANIM_STEP 1, 6
        ANIM_HOLD

      _Sequence16
        ANIM_CMD_F7
        ANIM_STEP 14, 3
        ANIM_STEP 1, 5
        ANIM_STEP 2, 4
        ANIM_STEP 3, 4
        ANIM_HOLD

      _Sequence17
        ANIM_STEP 12, 4
        ANIM_CMD_EE
        ANIM_STEP 12, 1
        ANIM_STEP 10, 10
        ANIM_SOUND 4
        ANIM_STEP 11, 5
        ANIM_CMD_F1
        ANIM_STEP 11, 4
        ANIM_STEP 12, 5
        ANIM_STEP 13, 3
        ANIM_STEP 9, 16
        ANIM_CMD_F3
        ANIM_CMD_ED 3
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence18
        ANIM_CMD_EE
        ANIM_STEP 12, 16
        ANIM_CMD_F1
        ANIM_SOUND 0
        ANIM_STEP 11, 11
        ANIM_STEP 12, 8
        ANIM_STEP 13, 8
        ANIM_CMD_F3
        ANIM_CMD_ED 3
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence19
        ANIM_STEP 9, 5
        ANIM_CMD_EE
        ANIM_STEP 13, 4
        ANIM_STEP 10, 10
        ANIM_STEP 11, 2
        ANIM_SOUND 4
        ANIM_STEP 12, 3
        ANIM_STEP 11, 3
        ANIM_SOUND 4
        ANIM_STEP 12, 3
        ANIM_STEP 11, 3
        ANIM_SOUND 4
        ANIM_STEP 12, 3
        ANIM_SOUND 4
        ANIM_STEP 11, 3
        ANIM_CMD_F1
        ANIM_STEP 11, 0
        ANIM_STEP 12, 3
        ANIM_STEP 13, 3
        ANIM_STEP 9, 21
        ANIM_CMD_F3
        ANIM_CMD_ED 3
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence20
        ANIM_STEP 12, 16
        ANIM_STEP 10, 9
        ANIM_CMD_EE
        ANIM_STEP 10, 7
        ANIM_STEP 11, 3
        ANIM_SOUND 4
        ANIM_STEP 12, 3
        ANIM_STEP 11, 3
        ANIM_SOUND 4
        ANIM_STEP 12, 3
        ANIM_STEP 11, 3
        ANIM_SOUND 4
        ANIM_STEP 12, 3
        ANIM_SOUND 4
        ANIM_STEP 11, 3
        ANIM_CMD_F1
        ANIM_STEP 11, 0
        ANIM_STEP 12, 3
        ANIM_STEP 10, 8
        ANIM_STEP 13, 21
        ANIM_CMD_F3
        ANIM_CMD_ED 3
        ANIM_CMD_F7
        ANIM_HOLD

      aBattleAnimationFramesPegasusKnightRangedLance ; 9B/92AF

        ; Frame table of entry 26: slices of the class sheet per frame.

        .word _Frame00 - aBattleAnimationFramesPegasusKnightRangedLance
        .word _Frame01 - aBattleAnimationFramesPegasusKnightRangedLance
        .word _Frame02 - aBattleAnimationFramesPegasusKnightRangedLance
        .word _Frame03 - aBattleAnimationFramesPegasusKnightRangedLance
        .word _Frame04 - aBattleAnimationFramesPegasusKnightRangedLance
        .word _Frame05 - aBattleAnimationFramesPegasusKnightRangedLance
        .word _Frame06 - aBattleAnimationFramesPegasusKnightRangedLance
        .word _Frame07 - aBattleAnimationFramesPegasusKnightRangedLance
        .word _Frame08 - aBattleAnimationFramesPegasusKnightRangedLance
        .word _Frame09 - aBattleAnimationFramesPegasusKnightRangedLance
        .word _Frame10 - aBattleAnimationFramesPegasusKnightRangedLance
        .word _Frame11 - aBattleAnimationFramesPegasusKnightRangedLance
        .word _Frame12 - aBattleAnimationFramesPegasusKnightRangedLance
        .word _Frame13 - aBattleAnimationFramesPegasusKnightRangedLance
        .word _Frame14 - aBattleAnimationFramesPegasusKnightRangedLance

      _Frame00
        ANIM_TILES
        ANIM_TILE_ROW $0000, $06A0
        ANIM_TILES_END

      _Frame01
        ANIM_TILES
        ANIM_TILE_ROW $06A0, $0640
        ANIM_TILES_END

      _Frame02
        ANIM_TILES
        ANIM_TILE_ROW $0CE0, $05A0
        ANIM_TILES_END

      _Frame03
        ANIM_TILES
        ANIM_TILE_ROW $1280, $04A0
        ANIM_TILES_END

      _Frame04
        ANIM_TILES
        ANIM_TILE_ROW $1720, $0540
        ANIM_TILES_END

      _Frame05
        ANIM_TILES
        ANIM_TILE_ROW $1C60, $05A0
        ANIM_TILES_END

      _Frame06
        ANIM_TILES
        ANIM_TILE_ROW $2200, $0640
        ANIM_TILES_END

      _Frame07
        ANIM_TILES
        ANIM_TILE_ROW $2840, $05C0
        ANIM_TILES_END

      _Frame08
        ANIM_TILES
        ANIM_TILE_ROW $2E00, $0560
        ANIM_TILE_ROW $3360, $0040
        ANIM_TILES_END

      _Frame09
        ANIM_TILES
        ANIM_TILE_ROW $33A0, $0580
        ANIM_TILES_END

      _Frame10
        ANIM_TILES
        ANIM_TILE_ROW $3920, $05E0
        ANIM_TILE_ROW $3F00, $0040
        ANIM_TILES_END

      _Frame11
        ANIM_TILES
        ANIM_TILE_ROW $3F40, $04C0
        ANIM_TILES_END

      _Frame12
        ANIM_TILES
        ANIM_TILE_ROW $4400, $0460
        ANIM_TILES_END

      _Frame13
        ANIM_TILES
        ANIM_TILE_ROW $4860, $0540
        ANIM_TILES_END

      _Frame14
        ANIM_TILES
        ANIM_TILE_ROW $4DA0, $05A0
        ANIM_TILES_END

      aBattleAnimationSequencesPegasusKnightRangedLance ; 9B/9320

        ; Sequence data of entry 26 of aBattleAnimationFrameTables, used by: PegasusKnight
        ; (RangedLance), FalconKnight (RangedLance). Frames:
        ; aBattleAnimationFramesPegasusKnightRangedLance.

        .word _Index - aBattleAnimationSequencesPegasusKnightRangedLance, _Records - aBattleAnimationSequencesPegasusKnightRangedLance

      _Index
        .word _Sequence00 - aBattleAnimationSequencesPegasusKnightRangedLance
        .word _Sequence01 - aBattleAnimationSequencesPegasusKnightRangedLance
        .word _Sequence02 - aBattleAnimationSequencesPegasusKnightRangedLance
        .word _Sequence03 - aBattleAnimationSequencesPegasusKnightRangedLance
        .word _Sequence04 - aBattleAnimationSequencesPegasusKnightRangedLance
        .word _Sequence05 - aBattleAnimationSequencesPegasusKnightRangedLance
        .word _Sequence06 - aBattleAnimationSequencesPegasusKnightRangedLance
        .word _Sequence07 - aBattleAnimationSequencesPegasusKnightRangedLance
        .word _Sequence08 - aBattleAnimationSequencesPegasusKnightRangedLance
        .word _Sequence09 - aBattleAnimationSequencesPegasusKnightRangedLance
        .word _Sequence10 - aBattleAnimationSequencesPegasusKnightRangedLance
        .word _Sequence11 - aBattleAnimationSequencesPegasusKnightRangedLance
        .word _Sequence12 - aBattleAnimationSequencesPegasusKnightRangedLance
        .word _Sequence13 - aBattleAnimationSequencesPegasusKnightRangedLance
        .word _Sequence14 - aBattleAnimationSequencesPegasusKnightRangedLance

      _Records
        .word _Record00 - aBattleAnimationSequencesPegasusKnightRangedLance
        .word _Record01 - aBattleAnimationSequencesPegasusKnightRangedLance
        .word _Record02 - aBattleAnimationSequencesPegasusKnightRangedLance
        .word _Record03 - aBattleAnimationSequencesPegasusKnightRangedLance
        .word _Record04 - aBattleAnimationSequencesPegasusKnightRangedLance
        .word _Record05 - aBattleAnimationSequencesPegasusKnightRangedLance
        .word _Record06 - aBattleAnimationSequencesPegasusKnightRangedLance
        .word _Record07 - aBattleAnimationSequencesPegasusKnightRangedLance
        .word _Record08 - aBattleAnimationSequencesPegasusKnightRangedLance
        .word _Record09 - aBattleAnimationSequencesPegasusKnightRangedLance
        .word _Record10 - aBattleAnimationSequencesPegasusKnightRangedLance
        .word _Record11 - aBattleAnimationSequencesPegasusKnightRangedLance
        .word _Record12 - aBattleAnimationSequencesPegasusKnightRangedLance
        .word _Record13 - aBattleAnimationSequencesPegasusKnightRangedLance
        .word _Record14 - aBattleAnimationSequencesPegasusKnightRangedLance
        .word _Record15 - aBattleAnimationSequencesPegasusKnightRangedLance
        .word _Record16 - aBattleAnimationSequencesPegasusKnightRangedLance
        .word _Record17 - aBattleAnimationSequencesPegasusKnightRangedLance
        .word _Record18 - aBattleAnimationSequencesPegasusKnightRangedLance
        .word _Record19 - aBattleAnimationSequencesPegasusKnightRangedLance
        .word _Record20 - aBattleAnimationSequencesPegasusKnightRangedLance
        .word _Record21 - aBattleAnimationSequencesPegasusKnightRangedLance
        .word _Record22 - aBattleAnimationSequencesPegasusKnightRangedLance
        .word _Record23 - aBattleAnimationSequencesPegasusKnightRangedLance
        .word _Record24 - aBattleAnimationSequencesPegasusKnightRangedLance
        .word _Record25 - aBattleAnimationSequencesPegasusKnightRangedLance
        .word _Record26 - aBattleAnimationSequencesPegasusKnightRangedLance

      _Sequence00
        ANIM_CMD_F7
        ANIM_STEP 9, 16
        ANIM_HOLD

      _Sequence01
        ANIM_CMD_F7
        ANIM_STEP 9, 1
        ANIM_HOLD

      _Sequence02
        ANIM_STEP 1, 9
        ANIM_STEP 2, 8
        ANIM_STEP 3, 8
        ANIM_STEP 4, 8
        ANIM_STEP 5, 8
        ANIM_STEP 6, 7

      _Sequence03
        ANIM_STEP 8, 32
        ANIM_STEP 9, 8
        ANIM_STEP 10, 3
        ANIM_STEP 14, 8
        ANIM_STEP 11, 18
        ANIM_STEP 12, 16
        ANIM_STEP 13, 48

      _Sequence04
        ANIM_STEP 12, 5
        ANIM_STEP 14, 6
        ANIM_STEP 15, 10
        ANIM_STEP 13, 10
        ANIM_STEP 13, 1
        ANIM_CMD_F4 1
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence05
        ANIM_STEP 17, 48
        ANIM_STEP 18, 32
        ANIM_STEP 19, 5
        ANIM_STEP 20, 4
        ANIM_STEP 21, 5
        ANIM_STEP 22, 64

      _Sequence06
        ANIM_STEP 12, 16
        ANIM_STEP 14, 16

      _Sequence07
        ANIM_STEP 9, 32
        ANIM_STEP 10, 6
        ANIM_STEP 11, 32
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence08
        ANIM_STEP 9, 5
        ANIM_STEP 13, 6
        ANIM_STEP 22, 18
        ANIM_CMD_EF 74
        ANIM_SOUND 11
        ANIM_STEP 23, 16
        ANIM_CMD_EE
        ANIM_STEP 11, 5
        ANIM_STEP 9, 40
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence09
        ANIM_STEP 7, 32
        ANIM_STEP 8, 5
        ANIM_STEP 9, 5
        ANIM_STEP 13, 6
        ANIM_STEP 22, 18
        ANIM_STEP 23, 64
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence10
        ANIM_CMD_F7
        ANIM_STEP 24, 16
        ANIM_HOLD

      _Sequence11
        ANIM_CMD_F7
        ANIM_STEP 24, 16
        ANIM_HOLD

      _Sequence12
        ANIM_CMD_F7
        ANIM_STEP 25, 16
        ANIM_HOLD

      _Sequence13
        ANIM_CMD_F7
        ANIM_STEP 26, 16
        ANIM_HOLD

      _Sequence14
        ANIM_CMD_F7
        ANIM_STEP 26, 16
        ANIM_HOLD

      _Record00
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (  16,   -2), $00, SpriteSmall, $0F0, 2, 3, true, true
        .structSpriteEntry (   8,   -3), $00, SpriteSmall, $0F1, 2, 3, false, false
        .structSpriteEntry ( -16,   -3), $00, SpriteSmall, $0F1, 2, 3, false, false
        .structSpriteEntry ( -24,   -3), $00, SpriteSmall, $0F0, 2, 3, false, false
        .structSpriteEntry (   0,   -3), $00, SpriteSmall, $0F1, 2, 3, false, false
        .structSpriteEntry (  -8,   -3), $00, SpriteSmall, $0F1, 2, 3, false, false
        ANIM_RECORD_END

      _Record01
        ANIM_RECORD 0
        .structSpriteEntry (  -8,  -45), $21, SpriteLarge, $080, 2, 0, false, false
        .structSpriteEntry (  15,  -83), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (  23,  -67), $00, SpriteSmall, $022, 2, 1, false, false
        .structSpriteEntry (  15,  -67), $00, SpriteSmall, $023, 2, 1, false, false
        .structSpriteEntry (   7,  -67), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry (  17,  -43), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (   1,  -43), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  23,  -51), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry (  23,  -59), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (   7,  -59), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry (  -8,  -29), $21, SpriteLarge, $0A0, 2, 0, false, false
        .structSpriteEntry (  -6,    1), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry (   2,   -7), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry (  -6,   -7), $00, SpriteSmall, $02A, 2, 1, false, false
        .structSpriteEntry ( -22,  -15), $00, SpriteSmall, $02B, 2, 1, false, false
        .structSpriteEntry ( -22,  -23), $00, SpriteSmall, $02C, 2, 1, false, false
        .structSpriteEntry (   2,  -23), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -14,  -23), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry (  10,  -31), $00, SpriteSmall, $02D, 2, 1, false, false
        .structSpriteEntry (   2,  -31), $00, SpriteSmall, $02E, 2, 1, false, false
        .structSpriteEntry (  -6,  -31), $00, SpriteSmall, $02F, 2, 1, false, false
        .structSpriteEntry (  -6,  -39), $00, SpriteSmall, $032, 2, 1, false, false
        .structSpriteEntry ( -22,  -39), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry ( -20,  -30), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry ( -36,  -25), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry ( -16,  -71), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry ( -24,  -71), $00, SpriteSmall, $033, 2, 1, false, false
        .structSpriteEntry ( -24,  -63), $00, SpriteSmall, $034, 2, 1, false, false
        .structSpriteEntry ( -18,  -39), $21, SpriteLarge, $00E, 2, 1, false, false
        .structSpriteEntry ( -18,  -55), $21, SpriteLarge, $020, 2, 1, false, false
        ANIM_RECORD_END

      _Record02
        ANIM_RECORD 1
        .structSpriteEntry (  -8,  -44), $21, SpriteLarge, $080, 2, 0, false, false
        .structSpriteEntry (  24,  -72), $00, SpriteSmall, $00E, 2, 1, false, false
        .structSpriteEntry (  16,  -72), $00, SpriteSmall, $00F, 2, 1, false, false
        .structSpriteEntry (  16,  -80), $00, SpriteSmall, $01E, 2, 1, false, false
        .structSpriteEntry (  24,  -64), $00, SpriteSmall, $01F, 2, 1, false, false
        .structSpriteEntry (  16,  -64), $00, SpriteSmall, $020, 2, 1, false, false
        .structSpriteEntry (   0,  -32), $00, SpriteSmall, $021, 2, 1, false, false
        .structSpriteEntry (   8,  -48), $00, SpriteSmall, $022, 2, 1, false, false
        .structSpriteEntry (   8,  -56), $00, SpriteSmall, $023, 2, 1, false, false
        .structSpriteEntry (  16,  -56), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (  24,  -40), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry (   8,  -40), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  -8,  -28), $21, SpriteLarge, $0A0, 2, 0, false, false
        .structSpriteEntry ( -22,  -14), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry ( -22,  -22), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry (   2,  -22), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -14,  -22), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry (  10,   -6), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (   2,   -6), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry (  -6,   -6), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry ( -14,   -6), $00, SpriteSmall, $02A, 2, 1, false, false
        .structSpriteEntry ( -22,   -6), $00, SpriteSmall, $02B, 2, 1, false, false
        .structSpriteEntry (  10,  -30), $00, SpriteSmall, $02C, 2, 1, false, false
        .structSpriteEntry (   2,  -30), $00, SpriteSmall, $02D, 2, 1, false, false
        .structSpriteEntry (  -6,  -30), $00, SpriteSmall, $02E, 2, 1, false, false
        .structSpriteEntry (  -6,  -38), $00, SpriteSmall, $02F, 2, 1, false, false
        .structSpriteEntry ( -22,  -38), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry ( -20,  -29), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry (   4,  -36), $00, SpriteSmall, $053, 2, 2, false, false
        .structSpriteEntry ( -36,  -24), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry ( -14,  -34), $00, SpriteSmall, $030, 2, 1, false, false
        .structSpriteEntry ( -22,  -34), $00, SpriteSmall, $031, 2, 1, false, false
        .structSpriteEntry ( -22,  -50), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry ( -22,  -66), $21, SpriteLarge, $00C, 2, 1, false, false
        ANIM_RECORD_END

      _Record03
        ANIM_RECORD 2
        .structSpriteEntry (  -8,  -43), $21, SpriteLarge, $080, 2, 0, false, false
        .structSpriteEntry (  10,  -69), $00, SpriteSmall, $00E, 2, 1, false, false
        .structSpriteEntry (  10,  -61), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   4,  -37), $00, SpriteSmall, $00F, 2, 1, false, false
        .structSpriteEntry (  12,  -45), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  18,  -29), $00, SpriteSmall, $01E, 2, 1, false, false
        .structSpriteEntry (  10,  -29), $00, SpriteSmall, $01F, 2, 1, false, false
        .structSpriteEntry (  -8,  -27), $21, SpriteLarge, $0A0, 2, 0, false, false
        .structSpriteEntry (   2,  -29), $00, SpriteSmall, $020, 2, 1, false, false
        .structSpriteEntry (  10,  -29), $00, SpriteSmall, $021, 2, 1, false, false
        .structSpriteEntry (   2,  -29), $00, SpriteSmall, $022, 2, 1, false, false
        .structSpriteEntry ( -22,  -13), $00, SpriteSmall, $023, 2, 1, false, false
        .structSpriteEntry (   2,  -21), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -14,  -21), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry (  10,   -5), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry (   2,   -5), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (  -6,   -5), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry ( -14,   -5), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry ( -22,   -5), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry (  -6,  -29), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry (  -6,  -37), $00, SpriteSmall, $02A, 2, 1, false, false
        .structSpriteEntry ( -20,  -28), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry (   4,  -35), $00, SpriteSmall, $053, 2, 2, false, false
        .structSpriteEntry ( -36,  -23), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry ( -22,  -37), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry ( -14,  -28), $00, SpriteSmall, $02B, 2, 1, false, false
        .structSpriteEntry ( -22,  -28), $00, SpriteSmall, $02C, 2, 1, false, false
        .structSpriteEntry ( -27,  -44), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry ( -27,  -60), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry (  12,  -43), $00, SpriteSmall, $044, 2, 2, false, false
        ANIM_RECORD_END

      _Record04
        ANIM_RECORD 3
        .structSpriteEntry (  -8,  -43), $21, SpriteLarge, $080, 2, 0, false, false
        .structSpriteEntry (  -8,  -27), $21, SpriteLarge, $0A0, 2, 0, false, false
        .structSpriteEntry (   9,  -28), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (   1,  -28), $00, SpriteSmall, $00B, 2, 1, false, false
        .structSpriteEntry (  33,  -28), $00, SpriteSmall, $00C, 2, 1, false, false
        .structSpriteEntry (  33,  -36), $00, SpriteSmall, $00D, 2, 1, false, false
        .structSpriteEntry (  17,  -36), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (  10,   -5), $00, SpriteSmall, $00E, 2, 1, false, false
        .structSpriteEntry (   2,   -5), $00, SpriteSmall, $00F, 2, 1, false, false
        .structSpriteEntry (  -6,   -5), $00, SpriteSmall, $01A, 2, 1, false, false
        .structSpriteEntry ( -14,   -5), $00, SpriteSmall, $01B, 2, 1, false, false
        .structSpriteEntry ( -22,  -13), $00, SpriteSmall, $01C, 2, 1, false, false
        .structSpriteEntry ( -22,  -21), $00, SpriteSmall, $01D, 2, 1, false, false
        .structSpriteEntry (   2,  -21), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry ( -14,  -21), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry (  10,  -29), $00, SpriteSmall, $01E, 2, 1, false, false
        .structSpriteEntry (   2,  -29), $00, SpriteSmall, $01F, 2, 1, false, false
        .structSpriteEntry (  -6,  -29), $00, SpriteSmall, $020, 2, 1, false, false
        .structSpriteEntry (  -6,  -37), $00, SpriteSmall, $021, 2, 1, false, false
        .structSpriteEntry ( -22,  -37), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -20,  -28), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry (   4,  -35), $00, SpriteSmall, $053, 2, 2, false, false
        .structSpriteEntry (  12,  -43), $00, SpriteSmall, $044, 2, 2, false, false
        .structSpriteEntry ( -36,  -23), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry ( -20,  -39), $00, SpriteSmall, $022, 2, 1, false, false
        .structSpriteEntry ( -28,  -39), $00, SpriteSmall, $023, 2, 1, false, false
        .structSpriteEntry ( -28,  -47), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry ( -28,  -31), $21, SpriteLarge, $008, 2, 1, false, false
        ANIM_RECORD_END

      _Record05
        ANIM_RECORD 4
        .structSpriteEntry (  -8,  -44), $21, SpriteLarge, $080, 2, 0, false, false
        .structSpriteEntry (  -8,  -28), $21, SpriteLarge, $0A0, 2, 0, false, false
        .structSpriteEntry (   1,  -21), $00, SpriteSmall, $00E, 2, 1, false, false
        .structSpriteEntry (  25,  -21), $00, SpriteSmall, $00F, 2, 1, false, false
        .structSpriteEntry (   9,  -29), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   9,  -13), $00, SpriteSmall, $01E, 2, 1, false, false
        .structSpriteEntry (  24,    3), $00, SpriteSmall, $01F, 2, 1, false, false
        .structSpriteEntry (  17,  -13), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (   1,  -29), $00, SpriteSmall, $020, 2, 1, false, false
        .structSpriteEntry (  10,   -6), $00, SpriteSmall, $021, 2, 1, false, false
        .structSpriteEntry (   2,   -6), $00, SpriteSmall, $022, 2, 1, false, false
        .structSpriteEntry (  -6,   -6), $00, SpriteSmall, $023, 2, 1, false, false
        .structSpriteEntry ( -14,   -6), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry (   2,  -22), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -14,  -22), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry (  10,  -30), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (   2,  -30), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry (  -6,  -30), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (  -6,  -38), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry ( -22,  -38), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry ( -20,  -29), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry (   4,  -36), $00, SpriteSmall, $053, 2, 2, false, false
        .structSpriteEntry (  12,  -44), $00, SpriteSmall, $044, 2, 2, false, false
        .structSpriteEntry ( -36,  -24), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry ( -12,  -28), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry ( -28,  -12), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry ( -28,  -28), $21, SpriteLarge, $00C, 2, 1, false, false
        ANIM_RECORD_END

      _Record06
        ANIM_RECORD 5
        .structSpriteEntry (  25,   -6), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (  25,  -14), $00, SpriteSmall, $00B, 2, 1, false, false
        .structSpriteEntry (  17,  -14), $00, SpriteSmall, $00C, 2, 1, false, false
        .structSpriteEntry (  17,  -30), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   9,  -30), $00, SpriteSmall, $00D, 2, 1, false, false
        .structSpriteEntry (   1,  -30), $00, SpriteSmall, $00E, 2, 1, false, false
        .structSpriteEntry (  25,  -38), $00, SpriteSmall, $00F, 2, 1, false, false
        .structSpriteEntry (  17,  -38), $00, SpriteSmall, $01A, 2, 1, false, false
        .structSpriteEntry (  17,  -46), $00, SpriteSmall, $01B, 2, 1, false, false
        .structSpriteEntry (   1,  -46), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  -8,  -46), $21, SpriteLarge, $080, 2, 0, false, false
        .structSpriteEntry (  -8,  -30), $21, SpriteLarge, $0A0, 2, 0, false, false
        .structSpriteEntry ( -22,   -8), $00, SpriteSmall, $01C, 2, 1, false, false
        .structSpriteEntry (   2,   -8), $00, SpriteSmall, $01D, 2, 1, false, false
        .structSpriteEntry (  10,  -16), $00, SpriteSmall, $01E, 2, 1, false, false
        .structSpriteEntry (   2,  -16), $00, SpriteSmall, $01F, 2, 1, false, false
        .structSpriteEntry (  -6,  -16), $00, SpriteSmall, $020, 2, 1, false, false
        .structSpriteEntry (  10,  -24), $00, SpriteSmall, $021, 2, 1, false, false
        .structSpriteEntry (   2,  -24), $00, SpriteSmall, $022, 2, 1, false, false
        .structSpriteEntry (  -6,  -24), $00, SpriteSmall, $023, 2, 1, false, false
        .structSpriteEntry ( -14,   -8), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry ( -22,  -24), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry (  10,  -32), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (   2,  -32), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry (  -6,  -32), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (  -6,  -40), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry ( -22,  -40), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -20,  -31), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry ( -36,  -26), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry ( -26,  -11), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry ( -18,  -19), $00, SpriteSmall, $02A, 2, 0, false, false
        .structSpriteEntry ( -26,  -19), $00, SpriteSmall, $02B, 2, 1, false, false
        .structSpriteEntry ( -26,  -35), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry ( -16,  -16), $00, SpriteSmall, $02C, 2, 1, false, false
        ANIM_RECORD_END

      _Record07
        ANIM_RECORD 6
        .structSpriteEntry (  15,  -38), $00, SpriteSmall, $022, 2, 1, false, false
        .structSpriteEntry (   6,  -62), $00, SpriteSmall, $023, 2, 1, false, false
        .structSpriteEntry (  23,  -54), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry (  -1,  -38), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (  15,  -46), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (  15,  -54), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry (  -1,  -54), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  13,  -70), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -12,  -24), $21, SpriteLarge, $0A2, 2, 0, false, false
        .structSpriteEntry ( -12,  -40), $21, SpriteLarge, $082, 2, 0, false, false
        .structSpriteEntry (  24,  -19), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (  16,  -14), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry (   8,  -14), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry (   0,  -14), $00, SpriteSmall, $02A, 2, 1, false, false
        .structSpriteEntry ( -16,  -14), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -24,  -14), $00, SpriteSmall, $02B, 2, 1, false, false
        .structSpriteEntry (   8,  -30), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry (  -8,  -30), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry ( -24,  -30), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry ( -34,  -25), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry (  14,  -44), $00, SpriteSmall, $044, 2, 2, false, false
        .structSpriteEntry ( -10,  -30), $00, SpriteSmall, $043, 2, 2, false, false
        .structSpriteEntry ( -18,  -30), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry (  -9,  -68), $00, SpriteSmall, $02C, 2, 1, false, false
        .structSpriteEntry ( -11,  -60), $21, SpriteLarge, $00E, 2, 1, false, false
        .structSpriteEntry (  -1,  -36), $00, SpriteSmall, $02D, 2, 1, false, false
        .structSpriteEntry ( -17,  -28), $00, SpriteSmall, $02E, 2, 1, false, false
        .structSpriteEntry (  -1,  -44), $00, SpriteSmall, $02F, 2, 1, false, false
        .structSpriteEntry ( -17,  -44), $21, SpriteLarge, $020, 2, 1, false, false
        ANIM_RECORD_END

      _Record08
        ANIM_RECORD 7
        .structSpriteEntry (  -2,  -40), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (  14,  -40), $00, SpriteSmall, $020, 2, 1, false, false
        .structSpriteEntry (   5,  -64), $00, SpriteSmall, $021, 2, 1, false, false
        .structSpriteEntry (  22,  -56), $00, SpriteSmall, $022, 2, 1, false, false
        .structSpriteEntry (  14,  -48), $00, SpriteSmall, $023, 2, 1, false, false
        .structSpriteEntry (  14,  -56), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry (  -2,  -56), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  12,  -72), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -12,  -27), $21, SpriteLarge, $0A4, 2, 0, false, false
        .structSpriteEntry ( -12,  -43), $21, SpriteLarge, $084, 2, 0, false, false
        .structSpriteEntry ( -37,  -32), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry ( -13,  -37), $00, SpriteSmall, $043, 2, 2, false, false
        .structSpriteEntry ( -21,  -37), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry (   9,  -14), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (   9,  -22), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry ( -15,   -6), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry ( -15,  -14), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry ( -22,  -38), $00, SpriteSmall, $02A, 2, 1, false, false
        .structSpriteEntry (  -7,  -14), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry (  -7,  -30), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry ( -23,  -30), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry (  -7,  -70), $00, SpriteSmall, $02B, 2, 1, false, false
        .structSpriteEntry (  -9,  -62), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry (   1,  -38), $00, SpriteSmall, $02C, 2, 1, false, false
        .structSpriteEntry (   1,  -46), $00, SpriteSmall, $02D, 2, 1, false, false
        .structSpriteEntry ( -15,  -46), $21, SpriteLarge, $00E, 2, 1, false, false
        ANIM_RECORD_END

      _Record09
        ANIM_RECORD 8
        .structSpriteEntry (   3,  -48), $00, SpriteSmall, $022, 2, 1, false, false
        .structSpriteEntry (  11,  -48), $00, SpriteSmall, $023, 2, 1, false, false
        .structSpriteEntry (  -5,  -48), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry ( -13,  -48), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (  19,  -40), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   3,  -40), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry ( -13,  -40), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -21,  -28), $21, SpriteLarge, $0A4, 2, 0, false, false
        .structSpriteEntry ( -21,  -44), $21, SpriteLarge, $084, 2, 0, false, false
        .structSpriteEntry ( -23,  -38), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry ( -26,  -14), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (  -2,  -14), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -18,  -14), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry (   0,  -22), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry (   0,  -30), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry ( -16,  -30), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry ( -32,  -30), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry ( -46,  -34), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry (   2,  -54), $00, SpriteSmall, $044, 2, 2, false, false
        .structSpriteEntry ( -22,  -39), $00, SpriteSmall, $043, 2, 2, false, false
        .structSpriteEntry ( -30,  -39), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry (  -6,  -46), $00, SpriteSmall, $053, 2, 2, false, false
        .structSpriteEntry ( -28,  -44), $21, SpriteLarge, $00E, 2, 1, false, false
        .structSpriteEntry ( -12,  -52), $21, SpriteLarge, $020, 2, 1, false, false
        .structSpriteEntry (   4,  -52), $00, SpriteSmall, $02A, 2, 1, false, false
        ANIM_RECORD_END

      _Record10
        ANIM_RECORD 8
        .structSpriteEntry (   7,  -62), $00, SpriteSmall, $044, 2, 2, false, false
        .structSpriteEntry ( -17,  -46), $00, SpriteSmall, $043, 2, 2, false, false
        .structSpriteEntry ( -25,  -46), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry (  -1,  -54), $00, SpriteSmall, $053, 2, 2, false, false
        .structSpriteEntry (  -9,  -54), $00, SpriteSmall, $052, 2, 2, false, false
        .structSpriteEntry ( -41,  -41), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry (   3,  -48), $00, SpriteSmall, $022, 2, 1, false, false
        .structSpriteEntry (  11,  -48), $00, SpriteSmall, $023, 2, 1, false, false
        .structSpriteEntry (  -5,  -48), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry ( -13,  -48), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (  19,  -40), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   3,  -40), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry ( -13,  -40), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -17,  -31), $21, SpriteLarge, $0A8, 2, 0, false, false
        .structSpriteEntry ( -17,  -47), $21, SpriteLarge, $088, 2, 0, false, false
        .structSpriteEntry ( -23,  -38), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry ( -26,  -14), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (  -2,  -14), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -18,  -14), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry (   0,  -22), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry (   0,  -30), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry ( -16,  -30), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry ( -32,  -30), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry ( -28,  -44), $21, SpriteLarge, $00E, 2, 1, false, false
        .structSpriteEntry ( -12,  -52), $21, SpriteLarge, $020, 2, 1, false, false
        .structSpriteEntry (   4,  -52), $00, SpriteSmall, $02A, 2, 1, false, false
        ANIM_RECORD_END

      _Record11
        ANIM_RECORD 8
        .structSpriteEntry ( -60,  -28), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry ( -36,  -33), $00, SpriteSmall, $043, 2, 2, false, false
        .structSpriteEntry ( -44,  -33), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry ( -22,  -29), $21, SpriteLarge, $0A6, 2, 0, false, false
        .structSpriteEntry ( -30,  -38), $00, SpriteSmall, $0C0, 2, 0, false, false
        .structSpriteEntry (   3,  -48), $00, SpriteSmall, $022, 2, 1, false, false
        .structSpriteEntry (  11,  -48), $00, SpriteSmall, $023, 2, 1, false, false
        .structSpriteEntry (  -5,  -48), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry ( -13,  -48), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (  19,  -40), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   3,  -40), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry ( -13,  -40), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -22,  -45), $21, SpriteLarge, $086, 2, 0, false, false
        .structSpriteEntry ( -23,  -38), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry ( -26,  -14), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (  -2,  -14), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -18,  -14), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry (   0,  -22), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry (   0,  -30), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry ( -16,  -30), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry ( -32,  -30), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry ( -28,  -44), $21, SpriteLarge, $00E, 2, 1, false, false
        .structSpriteEntry ( -12,  -52), $21, SpriteLarge, $020, 2, 1, false, false
        .structSpriteEntry (   4,  -52), $00, SpriteSmall, $02A, 2, 1, false, false
        ANIM_RECORD_END

      _Record12
        ANIM_RECORD 8
        .structSpriteEntry ( -49,  -42), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry (  -1,  -63), $00, SpriteSmall, $044, 2, 2, false, false
        .structSpriteEntry ( -25,  -47), $00, SpriteSmall, $043, 2, 2, false, false
        .structSpriteEntry ( -33,  -47), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry (  -9,  -55), $00, SpriteSmall, $053, 2, 2, false, false
        .structSpriteEntry ( -17,  -55), $00, SpriteSmall, $052, 2, 2, false, false
        .structSpriteEntry ( -22,  -31), $21, SpriteLarge, $0AC, 2, 0, false, false
        .structSpriteEntry (   3,  -48), $00, SpriteSmall, $022, 2, 1, false, false
        .structSpriteEntry (  11,  -48), $00, SpriteSmall, $023, 2, 1, false, false
        .structSpriteEntry (  -5,  -48), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry ( -13,  -48), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (  19,  -40), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   3,  -40), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry ( -13,  -40), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -22,  -47), $21, SpriteLarge, $08C, 2, 0, false, false
        .structSpriteEntry ( -23,  -38), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry ( -26,  -14), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (  -2,  -14), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -18,  -14), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry (   0,  -22), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry (   0,  -30), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry ( -16,  -30), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry ( -32,  -30), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry ( -28,  -44), $21, SpriteLarge, $00E, 2, 1, false, false
        .structSpriteEntry ( -12,  -52), $21, SpriteLarge, $020, 2, 1, false, false
        .structSpriteEntry (   4,  -52), $00, SpriteSmall, $02A, 2, 1, false, false
        ANIM_RECORD_END

      _Record13
        ANIM_RECORD 8
        .structSpriteEntry ( -47,  -41), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry (   1,  -62), $00, SpriteSmall, $044, 2, 2, false, false
        .structSpriteEntry ( -23,  -46), $00, SpriteSmall, $043, 2, 2, false, false
        .structSpriteEntry ( -31,  -46), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry (  -7,  -54), $00, SpriteSmall, $053, 2, 2, false, false
        .structSpriteEntry ( -15,  -54), $00, SpriteSmall, $052, 2, 2, false, false
        .structSpriteEntry (   3,  -48), $00, SpriteSmall, $022, 2, 1, false, false
        .structSpriteEntry (  11,  -48), $00, SpriteSmall, $023, 2, 1, false, false
        .structSpriteEntry (  -5,  -48), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry ( -13,  -48), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (  19,  -40), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   3,  -40), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry ( -13,  -40), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -22,  -30), $21, SpriteLarge, $0AA, 2, 0, false, false
        .structSpriteEntry ( -22,  -46), $21, SpriteLarge, $08A, 2, 0, false, false
        .structSpriteEntry ( -23,  -38), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry ( -26,  -14), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (  -2,  -14), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -18,  -14), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry (   0,  -22), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry (   0,  -30), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry ( -16,  -30), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry ( -32,  -30), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry ( -28,  -44), $21, SpriteLarge, $00E, 2, 1, false, false
        .structSpriteEntry ( -12,  -52), $21, SpriteLarge, $020, 2, 1, false, false
        .structSpriteEntry (   4,  -52), $00, SpriteSmall, $02A, 2, 1, false, false
        ANIM_RECORD_END

      _Record14
        ANIM_RECORD 9
        .structSpriteEntry ( -15,  -53), $00, SpriteSmall, $058, 2, 2, false, false
        .structSpriteEntry ( -15,  -61), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry ( -36,  -29), $21, SpriteLarge, $045, 2, 2, false, false
        .structSpriteEntry (  -7,  -69), $00, SpriteSmall, $054, 2, 2, false, false
        .structSpriteEntry ( -23,  -37), $00, SpriteSmall, $057, 2, 2, false, false
        .structSpriteEntry ( -23,  -45), $00, SpriteSmall, $047, 2, 2, false, false
        .structSpriteEntry ( -12,  -32), $21, SpriteLarge, $0AE, 2, 0, false, false
        .structSpriteEntry (  28,  -40), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (  20,  -48), $00, SpriteSmall, $020, 2, 1, false, false
        .structSpriteEntry (  12,  -48), $00, SpriteSmall, $021, 2, 1, false, false
        .structSpriteEntry (   4,  -48), $00, SpriteSmall, $022, 2, 1, false, false
        .structSpriteEntry (  -4,  -48), $00, SpriteSmall, $023, 2, 1, false, false
        .structSpriteEntry (  12,  -40), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  -4,  -40), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -20,  -33), $00, SpriteSmall, $0E0, 2, 0, false, false
        .structSpriteEntry ( -20,  -48), $00, SpriteSmall, $0D0, 2, 0, false, false
        .structSpriteEntry ( -12,  -48), $21, SpriteLarge, $08E, 2, 0, false, false
        .structSpriteEntry ( -15,   -8), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry ( -15,  -16), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry ( -22,  -40), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry ( -14,  -40), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (   9,  -16), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry (   9,  -24), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry (  -7,  -16), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry (  -7,  -32), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry ( -23,  -32), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry (   2,  -53), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry (  18,  -53), $00, SpriteSmall, $02A, 2, 1, false, false
        .structSpriteEntry (  18,  -45), $00, SpriteSmall, $02B, 2, 1, false, false
        .structSpriteEntry ( -14,  -45), $21, SpriteLarge, $00E, 2, 1, false, false
        ANIM_RECORD_END

      _Record15
        ANIM_RECORD 10
        .structSpriteEntry ( -14,  -43), $00, SpriteSmall, $058, 2, 2, true, false
        .structSpriteEntry ( -14,  -51), $00, SpriteSmall, $048, 2, 2, true, false
        .structSpriteEntry (  -6,  -27), $00, SpriteSmall, $058, 2, 2, true, false
        .structSpriteEntry (  -6,  -35), $00, SpriteSmall, $048, 2, 2, true, false
        .structSpriteEntry (  -1,  -19), $21, SpriteLarge, $045, 2, 2, true, false
        .structSpriteEntry ( -22,  -59), $00, SpriteSmall, $054, 2, 2, true, false
        .structSpriteEntry (   5,  -40), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (  21,  -40), $00, SpriteSmall, $022, 2, 1, false, false
        .structSpriteEntry (  12,  -64), $00, SpriteSmall, $023, 2, 1, false, false
        .structSpriteEntry (  29,  -56), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry (  21,  -48), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (  21,  -56), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry (   5,  -56), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  19,  -72), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -11,  -41), $00, SpriteSmall, $0C1, 2, 0, false, false
        .structSpriteEntry (  -3,  -26), $21, SpriteLarge, $0E2, 2, 0, false, false
        .structSpriteEntry (  -3,  -42), $21, SpriteLarge, $0C2, 2, 0, false, false
        .structSpriteEntry (  16,  -14), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (  16,  -22), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry (  16,  -30), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry (   0,  -14), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -16,  -14), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry (   0,  -30), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry ( -16,  -30), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry (   2,  -69), $00, SpriteSmall, $02A, 2, 1, false, false
        .structSpriteEntry (   0,  -61), $21, SpriteLarge, $00E, 2, 1, false, false
        .structSpriteEntry (  10,  -37), $00, SpriteSmall, $02B, 2, 1, false, false
        .structSpriteEntry (   2,  -29), $00, SpriteSmall, $02C, 2, 1, false, false
        .structSpriteEntry (  -6,  -29), $00, SpriteSmall, $02D, 2, 1, false, false
        .structSpriteEntry (  10,  -45), $00, SpriteSmall, $02E, 2, 1, false, false
        .structSpriteEntry (  -6,  -45), $21, SpriteLarge, $020, 2, 1, false, false
        ANIM_RECORD_END

      _Record16
        ANIM_RECORD 6
        .structSpriteEntry (  15,  -38), $00, SpriteSmall, $022, 2, 1, false, false
        .structSpriteEntry (   6,  -62), $00, SpriteSmall, $023, 2, 1, false, false
        .structSpriteEntry (  23,  -54), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry (  -1,  -38), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (  15,  -46), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (  15,  -54), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry (  -1,  -54), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  13,  -70), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -12,  -26), $21, SpriteLarge, $0E4, 2, 0, false, false
        .structSpriteEntry ( -12,  -42), $21, SpriteLarge, $0C4, 2, 0, false, false
        .structSpriteEntry (  24,  -19), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (  16,  -14), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry (   8,  -14), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry (   0,  -14), $00, SpriteSmall, $02A, 2, 1, false, false
        .structSpriteEntry ( -16,  -14), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -24,  -14), $00, SpriteSmall, $02B, 2, 1, false, false
        .structSpriteEntry (   8,  -30), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry (  -8,  -30), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry ( -24,  -30), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry ( -38,  -36), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry ( -14,  -41), $00, SpriteSmall, $043, 2, 2, false, false
        .structSpriteEntry ( -22,  -41), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry (   2,  -49), $00, SpriteSmall, $053, 2, 2, false, false
        .structSpriteEntry (  -6,  -49), $00, SpriteSmall, $052, 2, 2, false, false
        .structSpriteEntry (  -9,  -68), $00, SpriteSmall, $02C, 2, 1, false, false
        .structSpriteEntry ( -11,  -60), $21, SpriteLarge, $00E, 2, 1, false, false
        .structSpriteEntry (  -1,  -36), $00, SpriteSmall, $02D, 2, 1, false, false
        .structSpriteEntry ( -17,  -28), $00, SpriteSmall, $02E, 2, 1, false, false
        .structSpriteEntry (  -1,  -44), $00, SpriteSmall, $02F, 2, 1, false, false
        .structSpriteEntry ( -17,  -44), $21, SpriteLarge, $020, 2, 1, false, false
        ANIM_RECORD_END

      _Record17
        ANIM_RECORD 7
        .structSpriteEntry (  -2,  -40), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (  14,  -40), $00, SpriteSmall, $020, 2, 1, false, false
        .structSpriteEntry (   5,  -64), $00, SpriteSmall, $021, 2, 1, false, false
        .structSpriteEntry (  22,  -56), $00, SpriteSmall, $022, 2, 1, false, false
        .structSpriteEntry (  14,  -48), $00, SpriteSmall, $023, 2, 1, false, false
        .structSpriteEntry (  14,  -56), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry (  -2,  -56), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  -8,  -31), $21, SpriteLarge, $0A8, 2, 0, false, false
        .structSpriteEntry (  -8,  -47), $21, SpriteLarge, $088, 2, 0, false, false
        .structSpriteEntry (  12,  -72), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry (   9,  -14), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (   9,  -22), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry ( -15,   -6), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry ( -15,  -14), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry ( -22,  -38), $00, SpriteSmall, $02A, 2, 1, false, false
        .structSpriteEntry (  -7,  -14), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry (  -7,  -30), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry (   1,  -64), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry ( -20,  -32), $21, SpriteLarge, $045, 2, 2, false, false
        .structSpriteEntry (   9,  -72), $00, SpriteSmall, $054, 2, 2, false, false
        .structSpriteEntry (  -7,  -40), $00, SpriteSmall, $057, 2, 2, false, false
        .structSpriteEntry (  -7,  -48), $00, SpriteSmall, $047, 2, 2, false, false
        .structSpriteEntry (   1,  -56), $00, SpriteSmall, $058, 2, 2, false, false
        .structSpriteEntry ( -23,  -30), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry (  -7,  -70), $00, SpriteSmall, $02B, 2, 1, false, false
        .structSpriteEntry (  -9,  -62), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry (   1,  -38), $00, SpriteSmall, $02C, 2, 1, false, false
        .structSpriteEntry (   1,  -46), $00, SpriteSmall, $02D, 2, 1, false, false
        .structSpriteEntry ( -15,  -46), $21, SpriteLarge, $00E, 2, 1, false, false
        ANIM_RECORD_END

      _Record18
        ANIM_RECORD 11
        .structSpriteEntry (   2,  -38), $00, SpriteSmall, $00C, 2, 1, false, false
        .structSpriteEntry (  16,  -30), $00, SpriteSmall, $00D, 2, 1, false, false
        .structSpriteEntry (   8,  -30), $00, SpriteSmall, $00E, 2, 1, false, false
        .structSpriteEntry (   0,  -30), $00, SpriteSmall, $00F, 2, 1, false, false
        .structSpriteEntry (   8,  -70), $00, SpriteSmall, $01C, 2, 1, false, false
        .structSpriteEntry (  10,  -46), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   8,  -62), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  -8,  -31), $21, SpriteLarge, $0A8, 2, 0, false, false
        .structSpriteEntry (  -8,  -47), $21, SpriteLarge, $088, 2, 0, false, false
        .structSpriteEntry (   9,  -14), $00, SpriteSmall, $01D, 2, 1, false, false
        .structSpriteEntry (   9,  -22), $00, SpriteSmall, $01E, 2, 1, false, false
        .structSpriteEntry ( -15,   -6), $00, SpriteSmall, $01F, 2, 1, false, false
        .structSpriteEntry ( -15,  -14), $00, SpriteSmall, $020, 2, 1, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $021, 2, 1, false, false
        .structSpriteEntry ( -22,  -38), $00, SpriteSmall, $022, 2, 1, false, false
        .structSpriteEntry (  -7,  -14), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry (  -7,  -30), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -23,  -30), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry (   0,  -61), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry (   8,  -69), $00, SpriteSmall, $054, 2, 2, false, false
        .structSpriteEntry ( -21,  -29), $21, SpriteLarge, $045, 2, 2, false, false
        .structSpriteEntry (  -8,  -37), $00, SpriteSmall, $057, 2, 2, false, false
        .structSpriteEntry (  -8,  -45), $00, SpriteSmall, $047, 2, 2, false, false
        .structSpriteEntry (   0,  -53), $00, SpriteSmall, $058, 2, 2, false, false
        .structSpriteEntry ( -21,  -54), $00, SpriteSmall, $023, 2, 1, false, false
        .structSpriteEntry ( -13,  -46), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry ( -21,  -46), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry ( -21,  -38), $21, SpriteLarge, $00A, 2, 1, false, false
        ANIM_RECORD_END

      _Record19
        ANIM_RECORD 12
        .structSpriteEntry (  -2,  -22), $00, SpriteSmall, $00C, 2, 1, false, false
        .structSpriteEntry (  22,  -22), $00, SpriteSmall, $00D, 2, 1, false, false
        .structSpriteEntry (   6,  -30), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   6,  -14), $00, SpriteSmall, $00E, 2, 1, false, false
        .structSpriteEntry (  21,    2), $00, SpriteSmall, $00F, 2, 1, false, false
        .structSpriteEntry (  14,  -14), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  -2,  -30), $00, SpriteSmall, $01C, 2, 1, false, false
        .structSpriteEntry ( -18,  -45), $00, SpriteSmall, $0C1, 2, 0, false, false
        .structSpriteEntry ( -10,  -30), $21, SpriteLarge, $0E2, 2, 0, false, false
        .structSpriteEntry ( -10,  -46), $21, SpriteLarge, $0C2, 2, 0, false, false
        .structSpriteEntry (   9,  -14), $00, SpriteSmall, $01D, 2, 1, false, false
        .structSpriteEntry ( -15,   -6), $00, SpriteSmall, $01E, 2, 1, false, false
        .structSpriteEntry ( -15,  -14), $00, SpriteSmall, $01F, 2, 1, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $020, 2, 1, false, false
        .structSpriteEntry ( -22,  -38), $00, SpriteSmall, $021, 2, 1, false, false
        .structSpriteEntry (  -7,  -14), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry (  -7,  -30), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -23,  -30), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry ( -15,  -58), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry ( -15,  -50), $00, SpriteSmall, $058, 2, 2, false, false
        .structSpriteEntry (  -7,  -66), $00, SpriteSmall, $054, 2, 2, false, false
        .structSpriteEntry ( -36,  -26), $21, SpriteLarge, $045, 2, 2, false, false
        .structSpriteEntry ( -23,  -34), $00, SpriteSmall, $057, 2, 2, false, false
        .structSpriteEntry ( -23,  -42), $00, SpriteSmall, $047, 2, 2, false, false
        .structSpriteEntry ( -22,   -3), $00, SpriteSmall, $022, 2, 1, false, false
        .structSpriteEntry ( -22,  -19), $21, SpriteLarge, $00A, 2, 1, false, false
        ANIM_RECORD_END

      _Record20
        ANIM_RECORD 13
        .structSpriteEntry ( -15,  -58), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry ( -15,  -50), $00, SpriteSmall, $058, 2, 2, false, false
        .structSpriteEntry (  -7,  -66), $00, SpriteSmall, $054, 2, 2, false, false
        .structSpriteEntry ( -36,  -26), $21, SpriteLarge, $045, 2, 2, false, false
        .structSpriteEntry ( -23,  -34), $00, SpriteSmall, $057, 2, 2, false, false
        .structSpriteEntry ( -23,  -42), $00, SpriteSmall, $047, 2, 2, false, false
        .structSpriteEntry (  23,   -3), $00, SpriteSmall, $00E, 2, 1, false, false
        .structSpriteEntry (   7,  -27), $00, SpriteSmall, $00F, 2, 1, false, false
        .structSpriteEntry (  23,  -11), $00, SpriteSmall, $01E, 2, 1, false, false
        .structSpriteEntry (  15,  -11), $00, SpriteSmall, $01F, 2, 1, false, false
        .structSpriteEntry (  -1,  -27), $00, SpriteSmall, $020, 2, 1, false, false
        .structSpriteEntry (  23,  -35), $00, SpriteSmall, $021, 2, 1, false, false
        .structSpriteEntry (  15,  -35), $00, SpriteSmall, $022, 2, 1, false, false
        .structSpriteEntry (  15,  -43), $00, SpriteSmall, $023, 2, 1, false, false
        .structSpriteEntry (  15,  -27), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (  -1,  -43), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry ( -18,  -45), $00, SpriteSmall, $0C1, 2, 0, false, false
        .structSpriteEntry ( -10,  -30), $21, SpriteLarge, $0E2, 2, 0, false, false
        .structSpriteEntry ( -10,  -46), $21, SpriteLarge, $0C2, 2, 0, false, false
        .structSpriteEntry (   9,  -14), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry (   9,  -22), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry ( -15,   -6), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry ( -15,  -14), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry ( -22,  -38), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry (  -7,  -14), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry (  -7,  -30), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -23,  -30), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry ( -27,  -17), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry ( -27,  -33), $21, SpriteLarge, $00C, 2, 1, false, false
        ANIM_RECORD_END

      _Record21
        ANIM_RECORD 14
        .structSpriteEntry (  14,  -46), $00, SpriteSmall, $020, 2, 1, false, false
        .structSpriteEntry (  14,  -38), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -10,  -31), $21, SpriteLarge, $0E6, 2, 0, false, false
        .structSpriteEntry (  -2,  -38), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  -6,  -31), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry (  10,  -23), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry (   2,  -15), $00, SpriteSmall, $021, 2, 1, false, false
        .structSpriteEntry (  -6,  -15), $00, SpriteSmall, $022, 2, 1, false, false
        .structSpriteEntry ( -14,  -15), $00, SpriteSmall, $023, 2, 1, false, false
        .structSpriteEntry ( -10,  -47), $21, SpriteLarge, $0C6, 2, 0, false, false
        .structSpriteEntry (  22,  -46), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry (   6,  -46), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (  -2,  -46), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry (  30,  -38), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry ( -14,  -39), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (  18,    1), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry (  18,   -7), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry (  10,   -7), $00, SpriteSmall, $02A, 2, 1, false, false
        .structSpriteEntry ( -22,  -15), $00, SpriteSmall, $02B, 2, 1, false, false
        .structSpriteEntry ( -22,  -31), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry (  -5,  -56), $00, SpriteSmall, $058, 2, 2, false, false
        .structSpriteEntry (  -5,  -64), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry (   3,  -72), $00, SpriteSmall, $054, 2, 2, false, false
        .structSpriteEntry ( -26,  -32), $21, SpriteLarge, $045, 2, 2, false, false
        .structSpriteEntry ( -13,  -40), $00, SpriteSmall, $057, 2, 2, false, false
        .structSpriteEntry ( -13,  -48), $00, SpriteSmall, $047, 2, 2, false, false
        .structSpriteEntry ( -17,  -42), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry (  15,  -50), $00, SpriteSmall, $02C, 2, 1, false, false
        .structSpriteEntry (  -1,  -50), $21, SpriteLarge, $00E, 2, 1, false, false
        ANIM_RECORD_END

      _Record22
        ANIM_RECORD 8
        .structSpriteEntry (   3,  -48), $00, SpriteSmall, $022, 2, 1, false, false
        .structSpriteEntry (  11,  -48), $00, SpriteSmall, $023, 2, 1, false, false
        .structSpriteEntry (  -5,  -48), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry ( -13,  -48), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (  19,  -40), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   3,  -40), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry ( -13,  -40), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -17,  -54), $00, SpriteSmall, $043, 2, 2, false, true
        .structSpriteEntry ( -25,  -54), $00, SpriteSmall, $042, 2, 2, false, true
        .structSpriteEntry (  -9,  -46), $00, SpriteSmall, $052, 2, 2, false, true
        .structSpriteEntry ( -41,  -67), $21, SpriteLarge, $040, 2, 2, false, true
        .structSpriteEntry ( -17,  -31), $21, SpriteLarge, $0A8, 2, 0, false, false
        .structSpriteEntry ( -17,  -47), $21, SpriteLarge, $088, 2, 0, false, false
        .structSpriteEntry ( -23,  -38), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry ( -26,  -14), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (  -2,  -14), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -18,  -14), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry (   0,  -22), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry (   0,  -30), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry ( -16,  -30), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry ( -32,  -30), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry ( -28,  -44), $21, SpriteLarge, $00E, 2, 1, false, false
        .structSpriteEntry ( -12,  -52), $21, SpriteLarge, $020, 2, 1, false, false
        .structSpriteEntry (   4,  -52), $00, SpriteSmall, $02A, 2, 1, false, false
        ANIM_RECORD_END

      _Record23
        ANIM_RECORD 8
        .structSpriteEntry ( -22,  -29), $21, SpriteLarge, $0A6, 2, 0, false, false
        .structSpriteEntry ( -30,  -38), $00, SpriteSmall, $0C0, 2, 0, false, false
        .structSpriteEntry (   3,  -48), $00, SpriteSmall, $022, 2, 1, false, false
        .structSpriteEntry (  11,  -48), $00, SpriteSmall, $023, 2, 1, false, false
        .structSpriteEntry (  -5,  -48), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry ( -13,  -48), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (  19,  -40), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   3,  -40), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry ( -13,  -40), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -22,  -45), $21, SpriteLarge, $086, 2, 0, false, false
        .structSpriteEntry ( -23,  -38), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry ( -26,  -14), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (  -2,  -14), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -18,  -14), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry (   0,  -22), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry (   0,  -30), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry ( -16,  -30), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry ( -32,  -30), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry ( -28,  -44), $21, SpriteLarge, $00E, 2, 1, false, false
        .structSpriteEntry ( -12,  -52), $21, SpriteLarge, $020, 2, 1, false, false
        .structSpriteEntry (   4,  -52), $00, SpriteSmall, $02A, 2, 1, false, false
        ANIM_RECORD_END

      _Record24
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (  16,    8), $00, SpriteSmall, $044, 2, 2, false, true
        .structSpriteEntry ( -32,  -21), $21, SpriteLarge, $040, 2, 2, false, true
        .structSpriteEntry (  -8,   -8), $00, SpriteSmall, $043, 2, 2, false, true
        .structSpriteEntry ( -16,   -8), $00, SpriteSmall, $042, 2, 2, false, true
        .structSpriteEntry (   8,    0), $00, SpriteSmall, $053, 2, 2, false, true
        .structSpriteEntry (   0,    0), $00, SpriteSmall, $052, 2, 2, false, true
        ANIM_RECORD_END

      _Record25
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (   0,   -4), $00, SpriteSmall, $05D, 2, 2, false, false
        .structSpriteEntry (  16,   -4), $00, SpriteSmall, $05F, 2, 2, false, false
        .structSpriteEntry (   8,   -4), $00, SpriteSmall, $05E, 2, 2, false, false
        .structSpriteEntry (  -8,   -4), $00, SpriteSmall, $05C, 2, 2, false, false
        .structSpriteEntry ( -16,   -4), $00, SpriteSmall, $05B, 2, 2, false, false
        .structSpriteEntry ( -32,  -12), $21, SpriteLarge, $049, 2, 2, false, false
        ANIM_RECORD_END

      _Record26
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (  16,  -16), $00, SpriteSmall, $044, 2, 2, false, false
        .structSpriteEntry ( -32,    5), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry (  -8,    0), $00, SpriteSmall, $043, 2, 2, false, false
        .structSpriteEntry ( -16,    0), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry (   8,   -8), $00, SpriteSmall, $053, 2, 2, false, false
        .structSpriteEntry (   0,   -8), $00, SpriteSmall, $052, 2, 2, false, false
        ANIM_RECORD_END

      aBattleAnimationFramesDragonriderSword ; 9B/A16E

        ; Frame table of entry 28: slices of the class sheet per frame.

        .word _Frame00 - aBattleAnimationFramesDragonriderSword
        .word _Frame01 - aBattleAnimationFramesDragonriderSword
        .word _Frame02 - aBattleAnimationFramesDragonriderSword
        .word _Frame03 - aBattleAnimationFramesDragonriderSword
        .word _Frame04 - aBattleAnimationFramesDragonriderSword
        .word _Frame05 - aBattleAnimationFramesDragonriderSword
        .word _Frame06 - aBattleAnimationFramesDragonriderSword

      _Frame00
        ANIM_TILES
        ANIM_TILE_ROW $0000, $0800
        ANIM_TILES_END

      _Frame01
        ANIM_TILES
        ANIM_TILE_ROW $0800, $06A0
        ANIM_TILES_END

      _Frame02
        ANIM_TILES
        ANIM_TILE_ROW $0EA0, $0720
        ANIM_TILES_END

      _Frame03
        ANIM_TILES
        ANIM_TILE_ROW $15C0, $06C0
        ANIM_TILES_END

      _Frame04
        ANIM_TILES
        ANIM_TILE_ROW $1C80, $07E0
        ANIM_TILES_END

      _Frame05
        ANIM_TILES
        ANIM_TILE_ROW $2460, $06A0
        ANIM_TILES_END

      _Frame06
        ANIM_TILES
        ANIM_TILE_ROW $2B00, $0740
        ANIM_TILES_END

      aBattleAnimationSequencesDragonriderSword ; 9B/A19F

        ; Sequence data of entry 28 of aBattleAnimationFrameTables, used by: Dragonrider (Sword),
        ; Dragonknight (Sword), Dragonmaster (Sword). Frames:
        ; aBattleAnimationFramesDragonriderSword.

        .word _Index - aBattleAnimationSequencesDragonriderSword, _Records - aBattleAnimationSequencesDragonriderSword

      _Index
        .word _Sequence00 - aBattleAnimationSequencesDragonriderSword
        .word _Sequence01 - aBattleAnimationSequencesDragonriderSword
        .word _Sequence02 - aBattleAnimationSequencesDragonriderSword
        .word _Sequence03 - aBattleAnimationSequencesDragonriderSword
        .word _Sequence04 - aBattleAnimationSequencesDragonriderSword
        .word _Sequence05 - aBattleAnimationSequencesDragonriderSword
        .word _Sequence06 - aBattleAnimationSequencesDragonriderSword
        .word _Sequence07 - aBattleAnimationSequencesDragonriderSword
        .word _Sequence08 - aBattleAnimationSequencesDragonriderSword
        .word _Sequence09 - aBattleAnimationSequencesDragonriderSword
        .word _Sequence10 - aBattleAnimationSequencesDragonriderSword
        .word _Sequence11 - aBattleAnimationSequencesDragonriderSword
        .word _Sequence12 - aBattleAnimationSequencesDragonriderSword
        .word _Sequence13 - aBattleAnimationSequencesDragonriderSword
        .word _Sequence14 - aBattleAnimationSequencesDragonriderSword
        .word _Sequence15 - aBattleAnimationSequencesDragonriderSword
        .word _Sequence16 - aBattleAnimationSequencesDragonriderSword
        .word _Sequence17 - aBattleAnimationSequencesDragonriderSword
        .word _Sequence18 - aBattleAnimationSequencesDragonriderSword
        .word _Sequence19 - aBattleAnimationSequencesDragonriderSword
        .word _Sequence20 - aBattleAnimationSequencesDragonriderSword
        .word _Sequence21 - aBattleAnimationSequencesDragonriderSword
        .word _Sequence22 - aBattleAnimationSequencesDragonriderSword
        .word _Sequence23 - aBattleAnimationSequencesDragonriderSword

      _Records
        .word _Record00 - aBattleAnimationSequencesDragonriderSword
        .word _Record01 - aBattleAnimationSequencesDragonriderSword
        .word _Record02 - aBattleAnimationSequencesDragonriderSword
        .word _Record03 - aBattleAnimationSequencesDragonriderSword
        .word _Record04 - aBattleAnimationSequencesDragonriderSword
        .word _Record05 - aBattleAnimationSequencesDragonriderSword
        .word _Record06 - aBattleAnimationSequencesDragonriderSword
        .word _Record07 - aBattleAnimationSequencesDragonriderSword
        .word _Record08 - aBattleAnimationSequencesDragonriderSword
        .word _Record09 - aBattleAnimationSequencesDragonriderSword
        .word _Record10 - aBattleAnimationSequencesDragonriderSword
        .word _Record11 - aBattleAnimationSequencesDragonriderSword
        .word _Record12 - aBattleAnimationSequencesDragonriderSword
        .word _Record13 - aBattleAnimationSequencesDragonriderSword
        .word _Record14 - aBattleAnimationSequencesDragonriderSword
        .word _Record15 - aBattleAnimationSequencesDragonriderSword
        .word _Record16 - aBattleAnimationSequencesDragonriderSword
        .word _Record17 - aBattleAnimationSequencesDragonriderSword

      _Sequence00
        ANIM_CMD_F7
        ANIM_CMD_ED 2
        ANIM_STEP 6, 2
        ANIM_HOLD

      _Sequence01
        ANIM_STEP 5, 3
        ANIM_STEP 4, 5
        ANIM_STEP 1, 3
        ANIM_SOUND 22
        ANIM_STEP 1, 2
        ANIM_STEP 2, 5
        ANIM_STEP 3, 4
        ANIM_STEP 4, 7
        ANIM_STEP 5, 7
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence02
        ANIM_STEP 1, 4
        ANIM_STEP 2, 4
        ANIM_SOUND 22
        ANIM_STEP 3, 4
        ANIM_STEP 4, 4
        ANIM_STEP 5, 7
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence03
        ANIM_STEP 7, 10
        ANIM_STEP 10, 13
        ANIM_STEP 11, 9
        ANIM_STEP 13, 4
        ANIM_STEP 7, 7
        ANIM_STEP 6, 1
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence04
        ANIM_STEP 8, 2
        ANIM_STEP 7, 1
        ANIM_CMD_EE
        ANIM_STEP 7, 10
        ANIM_SOUND 0
        ANIM_STEP 7, 1
        ANIM_STEP 14, 2
        ANIM_STEP 15, 3
        ANIM_CMD_F1
        ANIM_STEP 9, 4
        ANIM_CMD_F3
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence05
        ANIM_STEP 4, 4
        ANIM_SOUND 22
        ANIM_STEP 3, 4
        ANIM_STEP 1, 10
        ANIM_STEP 2, 4
        ANIM_SOUND 22
        ANIM_STEP 3, 4
        ANIM_STEP 4, 2
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence06
        ANIM_STEP 6, 1
        ANIM_CMD_F4 1
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence07
        ANIM_STEP 5, 3
        ANIM_STEP 1, 6
        ANIM_STEP 2, 6
        ANIM_SOUND 22
        ANIM_STEP 3, 7
        ANIM_STEP 4, 6
        ANIM_STEP 1, 10
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence08
        ANIM_CMD_EB
        ANIM_CMD_F7
        ANIM_STEP 1, 14
        ANIM_STEP 2, 9
        ANIM_SOUND 22
        ANIM_STEP 3, 9
        ANIM_STEP 4, 9
        ANIM_RESTART
        ANIM_HOLD

      _Sequence09
        ANIM_STEP 10, 3
        ANIM_STEP 7, 1
        ANIM_CMD_EE
        ANIM_STEP 7, 5
        ANIM_SOUND 0
        ANIM_STEP 14, 2
        ANIM_STEP 15, 2
        ANIM_CMD_F1
        ANIM_STEP 9, 4
        ANIM_CMD_F3
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence10
        ANIM_STEP 6, 5
        ANIM_STEP 8, 5
        ANIM_STEP 7, 3
        ANIM_SOUND 32
        ANIM_CMD_F0 3
        ANIM_STEP 7, 3
        ANIM_CMD_F4 1
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence11
        ANIM_CMD_F7
        ANIM_STEP 5, 2
        ANIM_HOLD

      _Sequence12
        ANIM_SOUND 27
        ANIM_STEP 1, 8
        ANIM_STEP 10, 16
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence13
        ANIM_STEP 6, 3
        ANIM_STEP 7, 2
        ANIM_STEP 10, 3
        ANIM_CMD_EE
        ANIM_STEP 10, 12
        ANIM_SOUND 0
        ANIM_STEP 14, 2
        ANIM_STEP 15, 2
        ANIM_CMD_F1
        ANIM_STEP 9, 16
        ANIM_CMD_F3
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence14
        ANIM_STEP 6, 2
        ANIM_STEP 7, 4
        ANIM_STEP 10, 16
        ANIM_STEP 6, 2
        ANIM_CMD_F4 1
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence15
        ANIM_SOUND 27
        ANIM_STEP 1, 10
        ANIM_STEP 10, 2
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence16
        ANIM_SOUND 27
        ANIM_STEP 1, 8
        ANIM_STEP 10, 2
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence17
        ANIM_STEP 1, 6
        ANIM_STEP 2, 6
        ANIM_SOUND 22
        ANIM_STEP 3, 6
        ANIM_STEP 4, 6
        ANIM_STEP 1, 20
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence18
        ANIM_STEP 8, 4
        ANIM_STEP 6, 4
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence19
        ANIM_STEP 8, 3
        ANIM_CMD_EE
        ANIM_STEP 7, 12
        ANIM_SOUND 0
        ANIM_STEP 14, 2
        ANIM_STEP 15, 2
        ANIM_CMD_F1
        ANIM_STEP 9, 16
        ANIM_CMD_F3
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence20
        ANIM_STEP 6, 2
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence21
        ANIM_STEP 7, 6
        ANIM_STEP 17, 2
        ANIM_CMD_F4 1
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence22
        ANIM_STEP 6, 8
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence23
        ANIM_STEP 1, 6
        ANIM_STEP 2, 6
        ANIM_SOUND 22
        ANIM_STEP 3, 8
        ANIM_STEP 4, 6
        ANIM_STEP 1, 12
        ANIM_CMD_F7
        ANIM_HOLD

      _Record00
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (  -4,   -3), $00, SpriteSmall, $0F1, 2, 3, false, false
        .structSpriteEntry ( -12,   -3), $00, SpriteSmall, $0F1, 2, 3, false, false
        .structSpriteEntry ( -20,   -3), $00, SpriteSmall, $0F1, 2, 3, false, false
        .structSpriteEntry ( -28,   -3), $00, SpriteSmall, $0F1, 2, 3, false, false
        .structSpriteEntry ( -36,   -3), $00, SpriteSmall, $0F0, 2, 3, false, false
        .structSpriteEntry (  28,   -2), $00, SpriteSmall, $0F0, 2, 3, true, true
        .structSpriteEntry (  20,   -3), $00, SpriteSmall, $0F1, 2, 3, false, false
        .structSpriteEntry (  12,   -3), $00, SpriteSmall, $0F1, 2, 3, false, false
        .structSpriteEntry (   4,   -3), $00, SpriteSmall, $0F1, 2, 3, false, false
        ANIM_RECORD_END

      _Record01
        ANIM_RECORD 0
        .structSpriteEntry ( -16,  -49), $21, SpriteLarge, $0A0, 2, 0, false, false
        .structSpriteEntry ( -16,  -65), $21, SpriteLarge, $080, 2, 0, false, false
        .structSpriteEntry ( -20,  -58), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry ( -36,  -58), $21, SpriteLarge, $044, 2, 2, false, false
        .structSpriteEntry (  16, -100), $00, SpriteSmall, $020, 2, 1, false, false
        .structSpriteEntry (  16,  -92), $00, SpriteSmall, $021, 2, 1, false, false
        .structSpriteEntry (   8,  -92), $00, SpriteSmall, $022, 2, 1, false, false
        .structSpriteEntry (  24,  -74), $00, SpriteSmall, $023, 2, 1, false, false
        .structSpriteEntry (  24, -100), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry (  16,  -84), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (   8,  -84), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry (   0,  -84), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (   8,  -60), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry (   8,  -76), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (  -8,  -60), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  -8,  -76), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry (  35,   -9), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry (  27,   -9), $00, SpriteSmall, $02A, 2, 1, false, false
        .structSpriteEntry (  24,  -16), $00, SpriteSmall, $02B, 2, 1, false, false
        .structSpriteEntry (  21,  -23), $00, SpriteSmall, $02C, 2, 1, false, false
        .structSpriteEntry (  21,  -31), $00, SpriteSmall, $02D, 2, 1, false, false
        .structSpriteEntry (  21,  -39), $00, SpriteSmall, $02E, 2, 1, false, false
        .structSpriteEntry ( -27,  -32), $00, SpriteSmall, $02F, 2, 1, false, false
        .structSpriteEntry ( -35,  -32), $00, SpriteSmall, $030, 2, 1, false, false
        .structSpriteEntry ( -35,  -40), $00, SpriteSmall, $031, 2, 1, false, false
        .structSpriteEntry ( -19,  -32), $00, SpriteSmall, $032, 2, 1, false, false
        .structSpriteEntry ( -14,  -24), $00, SpriteSmall, $033, 2, 1, false, false
        .structSpriteEntry (  12,  -16), $00, SpriteSmall, $034, 2, 1, false, false
        .structSpriteEntry (  -3,  -32), $00, SpriteSmall, $035, 2, 1, false, false
        .structSpriteEntry ( -11,  -32), $00, SpriteSmall, $036, 2, 1, false, false
        .structSpriteEntry (  -3,  -24), $00, SpriteSmall, $037, 2, 1, false, false
        .structSpriteEntry (   5,  -32), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry (   5,  -48), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry ( -11,  -48), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry ( -27,  -48), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry ( -25,  -88), $00, SpriteSmall, $038, 2, 1, false, false
        .structSpriteEntry ( -25,  -96), $00, SpriteSmall, $039, 2, 1, false, false
        .structSpriteEntry ( -19,  -80), $00, SpriteSmall, $03A, 2, 1, false, false
        .structSpriteEntry ( -27,  -80), $00, SpriteSmall, $03B, 2, 1, false, false
        .structSpriteEntry (  -9,  -56), $00, SpriteSmall, $03C, 2, 1, false, false
        .structSpriteEntry ( -17,  -56), $00, SpriteSmall, $03D, 2, 1, false, false
        .structSpriteEntry ( -11,  -64), $00, SpriteSmall, $03E, 2, 1, false, false
        .structSpriteEntry ( -11,  -72), $00, SpriteSmall, $03F, 2, 1, false, false
        .structSpriteEntry ( -27,  -72), $21, SpriteLarge, $00E, 2, 1, false, false
        ANIM_RECORD_END

      _Record02
        ANIM_RECORD 1
        .structSpriteEntry ( -16,  -48), $21, SpriteLarge, $0A0, 2, 0, false, false
        .structSpriteEntry ( -16,  -64), $21, SpriteLarge, $080, 2, 0, false, false
        .structSpriteEntry ( -20,  -57), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry ( -36,  -57), $21, SpriteLarge, $044, 2, 2, false, false
        .structSpriteEntry (  33,  -54), $00, SpriteSmall, $00E, 2, 1, false, false
        .structSpriteEntry (  25,  -54), $00, SpriteSmall, $00F, 2, 1, false, false
        .structSpriteEntry (  25,  -46), $00, SpriteSmall, $01E, 2, 1, false, false
        .structSpriteEntry (  17,  -46), $00, SpriteSmall, $01F, 2, 1, false, false
        .structSpriteEntry (   9,  -46), $00, SpriteSmall, $020, 2, 1, false, false
        .structSpriteEntry (   1,  -46), $00, SpriteSmall, $021, 2, 1, false, false
        .structSpriteEntry (  -7,  -46), $00, SpriteSmall, $022, 2, 1, false, false
        .structSpriteEntry (   9,  -38), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (  -7,  -38), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  35,   -8), $00, SpriteSmall, $023, 2, 1, false, false
        .structSpriteEntry (  27,   -8), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry (  24,  -15), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (  21,  -22), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry (  21,  -30), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (  21,  -38), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry ( -27,  -31), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry ( -35,  -31), $00, SpriteSmall, $02A, 2, 1, false, false
        .structSpriteEntry ( -35,  -39), $00, SpriteSmall, $02B, 2, 1, false, false
        .structSpriteEntry ( -19,  -31), $00, SpriteSmall, $02C, 2, 1, false, false
        .structSpriteEntry ( -14,  -23), $00, SpriteSmall, $02D, 2, 1, false, false
        .structSpriteEntry (  12,  -15), $00, SpriteSmall, $02E, 2, 1, false, false
        .structSpriteEntry (  -3,  -31), $00, SpriteSmall, $02F, 2, 1, false, false
        .structSpriteEntry ( -11,  -31), $00, SpriteSmall, $030, 2, 1, false, false
        .structSpriteEntry (  -3,  -23), $00, SpriteSmall, $031, 2, 1, false, false
        .structSpriteEntry (   5,  -31), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry (   5,  -47), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -11,  -47), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry ( -27,  -47), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry ( -24,  -66), $00, SpriteSmall, $032, 2, 1, false, false
        .structSpriteEntry ( -21,  -58), $00, SpriteSmall, $033, 2, 1, false, false
        .structSpriteEntry ( -29,  -50), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry ( -29,  -58), $00, SpriteSmall, $034, 2, 1, false, false
        ANIM_RECORD_END

      _Record03
        ANIM_RECORD 2
        .structSpriteEntry ( -16,  -47), $21, SpriteLarge, $0A0, 2, 0, false, false
        .structSpriteEntry ( -16,  -63), $21, SpriteLarge, $080, 2, 0, false, false
        .structSpriteEntry ( -20,  -56), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry ( -36,  -56), $21, SpriteLarge, $044, 2, 2, false, false
        .structSpriteEntry (  -1,    5), $00, SpriteSmall, $020, 2, 1, false, false
        .structSpriteEntry (  -1,   -3), $00, SpriteSmall, $021, 2, 1, false, false
        .structSpriteEntry (   8,  -19), $00, SpriteSmall, $022, 2, 1, false, false
        .structSpriteEntry (   8,  -27), $00, SpriteSmall, $023, 2, 1, false, false
        .structSpriteEntry (   8,  -35), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry (   5,  -11), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (  -3,  -11), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry (  -8,  -27), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (  -8,  -43), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  35,   -7), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (  27,   -7), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry (  24,  -14), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry (  21,  -21), $00, SpriteSmall, $02A, 2, 1, false, false
        .structSpriteEntry (  21,  -29), $00, SpriteSmall, $02B, 2, 1, false, false
        .structSpriteEntry (  21,  -37), $00, SpriteSmall, $02C, 2, 1, false, false
        .structSpriteEntry ( -27,  -30), $00, SpriteSmall, $02D, 2, 1, false, false
        .structSpriteEntry ( -35,  -30), $00, SpriteSmall, $02E, 2, 1, false, false
        .structSpriteEntry ( -35,  -38), $00, SpriteSmall, $02F, 2, 1, false, false
        .structSpriteEntry ( -19,  -30), $00, SpriteSmall, $030, 2, 1, false, false
        .structSpriteEntry ( -14,  -22), $00, SpriteSmall, $031, 2, 1, false, false
        .structSpriteEntry (  12,  -14), $00, SpriteSmall, $032, 2, 1, false, false
        .structSpriteEntry (  -3,  -30), $00, SpriteSmall, $033, 2, 1, false, false
        .structSpriteEntry ( -11,  -30), $00, SpriteSmall, $034, 2, 1, false, false
        .structSpriteEntry (  -3,  -22), $00, SpriteSmall, $035, 2, 1, false, false
        .structSpriteEntry (   5,  -30), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry (   5,  -46), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -11,  -46), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry ( -27,  -46), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry ( -31,  -33), $00, SpriteSmall, $036, 2, 1, false, false
        .structSpriteEntry ( -15,   -9), $00, SpriteSmall, $037, 2, 1, false, false
        .structSpriteEntry ( -23,   -9), $00, SpriteSmall, $038, 2, 1, false, false
        .structSpriteEntry ( -23,  -25), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry ( -23,  -41), $21, SpriteLarge, $00E, 2, 1, false, false
        ANIM_RECORD_END

      _Record04
        ANIM_RECORD 3
        .structSpriteEntry ( -16,  -48), $21, SpriteLarge, $0A0, 2, 0, false, false
        .structSpriteEntry ( -16,  -64), $21, SpriteLarge, $080, 2, 0, false, false
        .structSpriteEntry ( -20,  -57), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry ( -36,  -57), $21, SpriteLarge, $044, 2, 2, false, false
        .structSpriteEntry (  24,  -54), $00, SpriteSmall, $020, 2, 1, false, false
        .structSpriteEntry (   5,  -70), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (  -8,  -54), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  12,  -30), $00, SpriteSmall, $021, 2, 1, false, false
        .structSpriteEntry (  12,  -38), $00, SpriteSmall, $022, 2, 1, false, false
        .structSpriteEntry (  -3,  -62), $00, SpriteSmall, $023, 2, 1, false, false
        .structSpriteEntry (  -3,  -70), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry (   8,  -54), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry (  35,   -8), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (  27,   -8), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry (  24,  -15), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (  21,  -22), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry (  21,  -30), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry (  21,  -38), $00, SpriteSmall, $02A, 2, 1, false, false
        .structSpriteEntry ( -27,  -31), $00, SpriteSmall, $02B, 2, 1, false, false
        .structSpriteEntry ( -35,  -31), $00, SpriteSmall, $02C, 2, 1, false, false
        .structSpriteEntry ( -35,  -39), $00, SpriteSmall, $02D, 2, 1, false, false
        .structSpriteEntry ( -19,  -31), $00, SpriteSmall, $02E, 2, 1, false, false
        .structSpriteEntry ( -14,  -23), $00, SpriteSmall, $02F, 2, 1, false, false
        .structSpriteEntry (  12,  -15), $00, SpriteSmall, $030, 2, 1, false, false
        .structSpriteEntry (  -3,  -31), $00, SpriteSmall, $031, 2, 1, false, false
        .structSpriteEntry ( -11,  -31), $00, SpriteSmall, $032, 2, 1, false, false
        .structSpriteEntry (  -3,  -23), $00, SpriteSmall, $033, 2, 1, false, false
        .structSpriteEntry (   5,  -31), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry (   5,  -47), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry ( -11,  -47), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry ( -27,  -47), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry ( -21,  -34), $00, SpriteSmall, $034, 2, 1, false, false
        .structSpriteEntry ( -21,  -42), $00, SpriteSmall, $035, 2, 1, false, false
        .structSpriteEntry ( -29,  -58), $21, SpriteLarge, $00E, 2, 1, false, false
        ANIM_RECORD_END

      _Record05
        ANIM_RECORD 4
        .structSpriteEntry ( -18,  -45), $21, SpriteLarge, $0A2, 2, 0, false, false
        .structSpriteEntry ( -18,  -61), $21, SpriteLarge, $082, 2, 0, false, false
        .structSpriteEntry ( -21,  -55), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry ( -37,  -55), $21, SpriteLarge, $044, 2, 2, false, false
        .structSpriteEntry (  11,  -29), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry (  11,  -37), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (  23,  -53), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry (   4,  -69), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   7,  -53), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  -9,  -53), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry (  -4,  -61), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (  -4,  -69), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry (  26,  -21), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry (  34,   -5), $00, SpriteSmall, $02A, 2, 1, false, false
        .structSpriteEntry (  26,   -5), $00, SpriteSmall, $02B, 2, 1, false, false
        .structSpriteEntry (  26,  -13), $00, SpriteSmall, $02C, 2, 1, false, false
        .structSpriteEntry ( -38,  -19), $00, SpriteSmall, $02D, 2, 1, false, false
        .structSpriteEntry ( -38,  -35), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -14,  -13), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry (  18,  -13), $00, SpriteSmall, $02E, 2, 1, false, false
        .structSpriteEntry (  10,  -13), $00, SpriteSmall, $02F, 2, 1, false, false
        .structSpriteEntry (   2,  -13), $00, SpriteSmall, $034, 2, 1, false, false
        .structSpriteEntry (  18,  -37), $00, SpriteSmall, $035, 2, 1, false, false
        .structSpriteEntry (  10,  -37), $00, SpriteSmall, $036, 2, 1, false, false
        .structSpriteEntry (  10,  -45), $00, SpriteSmall, $037, 2, 1, false, false
        .structSpriteEntry (  10,  -29), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry (  -6,  -29), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry (  -6,  -45), $21, SpriteLarge, $00E, 2, 1, false, false
        .structSpriteEntry ( -14,  -21), $00, SpriteSmall, $038, 2, 1, false, false
        .structSpriteEntry ( -14,  -29), $00, SpriteSmall, $039, 2, 1, false, false
        .structSpriteEntry ( -22,  -29), $00, SpriteSmall, $03A, 2, 1, false, false
        .structSpriteEntry ( -22,  -45), $21, SpriteLarge, $020, 2, 1, false, false
        .structSpriteEntry ( -21,  -32), $00, SpriteSmall, $03B, 2, 1, false, false
        .structSpriteEntry ( -21,  -40), $00, SpriteSmall, $03C, 2, 1, false, false
        .structSpriteEntry ( -13,  -48), $00, SpriteSmall, $03D, 2, 1, false, false
        .structSpriteEntry ( -13,  -56), $00, SpriteSmall, $03E, 2, 1, false, false
        .structSpriteEntry ( -29,  -56), $21, SpriteLarge, $022, 2, 1, false, false
        ANIM_RECORD_END

      _Record06
        ANIM_RECORD 5
        .structSpriteEntry (  16,  -47), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry (   8,  -39), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (   0,  -39), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry (  -8,  -39), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (   0,  -55), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -16,  -55), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry ( -17,  -54), $21, SpriteLarge, $084, 2, 0, false, false
        .structSpriteEntry ( -17,  -38), $21, SpriteLarge, $0A4, 2, 0, false, false
        .structSpriteEntry (  -3,   -7), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry ( -11,   -7), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry ( -11,  -23), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -11,  -39), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -19,  -39), $00, SpriteSmall, $02A, 2, 1, false, false
        .structSpriteEntry (   5,  -39), $00, SpriteSmall, $02B, 2, 1, false, false
        .structSpriteEntry (  21,  -23), $00, SpriteSmall, $02C, 2, 1, false, false
        .structSpriteEntry (  45,   -7), $00, SpriteSmall, $02D, 2, 1, false, false
        .structSpriteEntry (  37,   -7), $00, SpriteSmall, $02E, 2, 1, false, false
        .structSpriteEntry (  21,  -15), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry (   5,  -15), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry (   5,  -31), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry ( -27,  -15), $21, SpriteLarge, $00E, 2, 1, false, false
        .structSpriteEntry ( -27,  -31), $21, SpriteLarge, $020, 2, 1, false, false
        .structSpriteEntry ( -27,  -73), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry ( -27,  -57), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry ( -27,  -47), $21, SpriteLarge, $022, 2, 1, false, false
        .structSpriteEntry ( -11,  -39), $00, SpriteSmall, $02F, 2, 1, false, false
        .structSpriteEntry ( -11,  -47), $00, SpriteSmall, $034, 2, 1, false, false
        ANIM_RECORD_END

      _Record07
        ANIM_RECORD 5
        .structSpriteEntry ( -10,  -68), $21, SpriteLarge, $042, 2, 2, true, true
        .structSpriteEntry (   6,  -68), $21, SpriteLarge, $040, 2, 2, true, true
        .structSpriteEntry (  16,  -47), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry (   8,  -39), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (   0,  -39), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry (  -8,  -39), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (   0,  -55), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -16,  -55), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry ( -13,  -41), $21, SpriteLarge, $0A8, 2, 0, false, false
        .structSpriteEntry ( -13,  -57), $21, SpriteLarge, $088, 2, 0, false, false
        .structSpriteEntry (  -3,   -7), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry ( -11,   -7), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry ( -11,  -23), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -11,  -39), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -19,  -39), $00, SpriteSmall, $02A, 2, 1, false, false
        .structSpriteEntry (   5,  -39), $00, SpriteSmall, $02B, 2, 1, false, false
        .structSpriteEntry (  21,  -23), $00, SpriteSmall, $02C, 2, 1, false, false
        .structSpriteEntry (  45,   -7), $00, SpriteSmall, $02D, 2, 1, false, false
        .structSpriteEntry (  37,   -7), $00, SpriteSmall, $02E, 2, 1, false, false
        .structSpriteEntry (  21,  -15), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry (   5,  -15), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry (   5,  -31), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry ( -27,  -15), $21, SpriteLarge, $00E, 2, 1, false, false
        .structSpriteEntry ( -27,  -31), $21, SpriteLarge, $020, 2, 1, false, false
        .structSpriteEntry ( -27,  -47), $21, SpriteLarge, $022, 2, 1, false, false
        .structSpriteEntry ( -11,  -39), $00, SpriteSmall, $02F, 2, 1, false, false
        .structSpriteEntry ( -11,  -47), $00, SpriteSmall, $034, 2, 1, false, false
        ANIM_RECORD_END

      _Record08
        ANIM_RECORD 5
        .structSpriteEntry (  16,  -47), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry (   8,  -39), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (   0,  -39), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry (  -8,  -39), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (   0,  -55), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -16,  -55), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry ( -18,  -40), $21, SpriteLarge, $0AA, 2, 0, false, false
        .structSpriteEntry ( -18,  -56), $21, SpriteLarge, $08A, 2, 0, false, false
        .structSpriteEntry (  -3,   -7), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry ( -11,   -7), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry ( -11,  -23), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -11,  -39), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -19,  -39), $00, SpriteSmall, $02A, 2, 1, false, false
        .structSpriteEntry (   5,  -39), $00, SpriteSmall, $02B, 2, 1, false, false
        .structSpriteEntry (  21,  -23), $00, SpriteSmall, $02C, 2, 1, false, false
        .structSpriteEntry (  45,   -7), $00, SpriteSmall, $02D, 2, 1, false, false
        .structSpriteEntry (  37,   -7), $00, SpriteSmall, $02E, 2, 1, false, false
        .structSpriteEntry (  21,  -15), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry (   5,  -15), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry (   5,  -31), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry ( -27,  -15), $21, SpriteLarge, $00E, 2, 1, false, false
        .structSpriteEntry ( -27,  -31), $21, SpriteLarge, $020, 2, 1, false, false
        .structSpriteEntry ( -18,  -61), $21, SpriteLarge, $04E, 2, 2, false, false
        .structSpriteEntry ( -18,  -77), $21, SpriteLarge, $04C, 2, 2, false, false
        .structSpriteEntry ( -27,  -47), $21, SpriteLarge, $022, 2, 1, false, false
        .structSpriteEntry ( -11,  -39), $00, SpriteSmall, $02F, 2, 1, false, false
        .structSpriteEntry ( -11,  -47), $00, SpriteSmall, $035, 2, 1, false, false
        ANIM_RECORD_END

      _Record09
        ANIM_RECORD 5
        .structSpriteEntry ( -34,  -40), $21, SpriteLarge, $042, 2, 2, false, false
        .structSpriteEntry ( -50,  -40), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry (  16,  -47), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry (   8,  -39), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (   0,  -39), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry (  -8,  -39), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (   0,  -55), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -16,  -55), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry ( -26,  -51), $00, SpriteSmall, $0C8, 2, 0, false, false
        .structSpriteEntry ( -26,  -43), $00, SpriteSmall, $0D8, 2, 0, false, false
        .structSpriteEntry ( -18,  -35), $21, SpriteLarge, $0E9, 2, 0, false, false
        .structSpriteEntry ( -18,  -51), $21, SpriteLarge, $0C9, 2, 0, false, false
        .structSpriteEntry (  -3,   -7), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry ( -11,   -7), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry ( -11,  -23), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -11,  -39), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -19,  -39), $00, SpriteSmall, $02A, 2, 1, false, false
        .structSpriteEntry (   5,  -39), $00, SpriteSmall, $02B, 2, 1, false, false
        .structSpriteEntry (  21,  -23), $00, SpriteSmall, $02C, 2, 1, false, false
        .structSpriteEntry (  45,   -7), $00, SpriteSmall, $02D, 2, 1, false, false
        .structSpriteEntry (  37,   -7), $00, SpriteSmall, $02E, 2, 1, false, false
        .structSpriteEntry (  21,  -15), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry (   5,  -15), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry (   5,  -31), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry ( -27,  -15), $21, SpriteLarge, $00E, 2, 1, false, false
        .structSpriteEntry ( -27,  -31), $21, SpriteLarge, $020, 2, 1, false, false
        .structSpriteEntry ( -27,  -47), $21, SpriteLarge, $022, 2, 1, false, false
        .structSpriteEntry ( -11,  -39), $00, SpriteSmall, $02F, 2, 1, false, false
        .structSpriteEntry ( -11,  -47), $00, SpriteSmall, $034, 2, 1, false, false
        ANIM_RECORD_END

      _Record10
        ANIM_RECORD 6
        .structSpriteEntry (   7,  -45), $00, SpriteSmall, $022, 2, 1, false, false
        .structSpriteEntry (  -1,  -45), $00, SpriteSmall, $023, 2, 1, false, false
        .structSpriteEntry (  -9,  -45), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry (  15,  -53), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (  -1,  -61), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -17,  -61), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry ( -16,  -47), $21, SpriteLarge, $0A8, 2, 0, false, false
        .structSpriteEntry ( -16,  -63), $21, SpriteLarge, $088, 2, 0, false, false
        .structSpriteEntry ( -13,  -73), $21, SpriteLarge, $042, 2, 2, true, true
        .structSpriteEntry (   3,  -73), $21, SpriteLarge, $040, 2, 2, true, true
        .structSpriteEntry ( -39,  -19), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry ( -39,  -35), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -15,  -13), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry (  25,  -21), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (  33,   -5), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry (  25,   -5), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry (  25,  -13), $00, SpriteSmall, $02A, 2, 1, false, false
        .structSpriteEntry (  17,  -13), $00, SpriteSmall, $02B, 2, 1, false, false
        .structSpriteEntry (   9,  -13), $00, SpriteSmall, $02C, 2, 1, false, false
        .structSpriteEntry (   1,  -13), $00, SpriteSmall, $02D, 2, 1, false, false
        .structSpriteEntry (  17,  -37), $00, SpriteSmall, $02E, 2, 1, false, false
        .structSpriteEntry (   9,  -37), $00, SpriteSmall, $02F, 2, 1, false, false
        .structSpriteEntry (   9,  -45), $00, SpriteSmall, $032, 2, 1, false, false
        .structSpriteEntry (   9,  -29), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry (  -7,  -29), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry ( -15,  -21), $00, SpriteSmall, $033, 2, 1, false, false
        .structSpriteEntry ( -15,  -29), $00, SpriteSmall, $036, 2, 1, false, false
        .structSpriteEntry ( -23,  -29), $00, SpriteSmall, $037, 2, 1, false, false
        .structSpriteEntry (  -7,  -45), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry ( -23,  -45), $21, SpriteLarge, $00E, 2, 1, false, false
        .structSpriteEntry ( -31,  -53), $21, SpriteLarge, $020, 2, 1, false, false
        .structSpriteEntry ( -15,  -45), $00, SpriteSmall, $038, 2, 1, false, false
        .structSpriteEntry ( -15,  -53), $00, SpriteSmall, $039, 2, 1, false, false
        ANIM_RECORD_END

      _Record11
        ANIM_RECORD 5
        .structSpriteEntry ( -25,  -57), $21, SpriteLarge, $04A, 2, 2, true, true
        .structSpriteEntry ( -25,  -41), $21, SpriteLarge, $048, 2, 2, true, true
        .structSpriteEntry (  16,  -47), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry (   8,  -39), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (   0,  -39), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry (  -8,  -39), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (   0,  -55), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -16,  -55), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry ( -25,  -54), $00, SpriteSmall, $0C1, 2, 0, false, false
        .structSpriteEntry ( -17,  -39), $21, SpriteLarge, $0E2, 2, 0, false, false
        .structSpriteEntry ( -17,  -55), $21, SpriteLarge, $0C2, 2, 0, false, false
        .structSpriteEntry (  -3,   -7), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry ( -11,   -7), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry ( -11,  -23), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -11,  -39), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -19,  -39), $00, SpriteSmall, $02A, 2, 1, false, false
        .structSpriteEntry (   5,  -39), $00, SpriteSmall, $02B, 2, 1, false, false
        .structSpriteEntry (  21,  -23), $00, SpriteSmall, $02C, 2, 1, false, false
        .structSpriteEntry (  45,   -7), $00, SpriteSmall, $02D, 2, 1, false, false
        .structSpriteEntry (  37,   -7), $00, SpriteSmall, $02E, 2, 1, false, false
        .structSpriteEntry (  21,  -15), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry (   5,  -15), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry (   5,  -31), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry ( -27,  -15), $21, SpriteLarge, $00E, 2, 1, false, false
        .structSpriteEntry ( -27,  -31), $21, SpriteLarge, $020, 2, 1, false, false
        .structSpriteEntry ( -27,  -47), $21, SpriteLarge, $022, 2, 1, false, false
        .structSpriteEntry ( -11,  -39), $00, SpriteSmall, $02F, 2, 1, false, false
        .structSpriteEntry ( -11,  -47), $00, SpriteSmall, $034, 2, 1, false, false
        ANIM_RECORD_END

      _Record12
        ANIM_RECORD 6
        .structSpriteEntry ( -13,  -74), $21, SpriteLarge, $042, 2, 2, true, true
        .structSpriteEntry (   3,  -74), $21, SpriteLarge, $040, 2, 2, true, true
        .structSpriteEntry (   7,  -45), $00, SpriteSmall, $022, 2, 1, false, false
        .structSpriteEntry (  -1,  -45), $00, SpriteSmall, $023, 2, 1, false, false
        .structSpriteEntry (  -9,  -45), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry (  15,  -53), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (  -1,  -61), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -17,  -61), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry ( -16,  -47), $21, SpriteLarge, $0A8, 2, 0, false, false
        .structSpriteEntry ( -16,  -63), $21, SpriteLarge, $088, 2, 0, false, false
        .structSpriteEntry ( -39,  -19), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry ( -39,  -35), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -15,  -13), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry (  25,  -21), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (  33,   -5), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry (  25,   -5), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry (  25,  -13), $00, SpriteSmall, $02A, 2, 1, false, false
        .structSpriteEntry (  17,  -13), $00, SpriteSmall, $02B, 2, 1, false, false
        .structSpriteEntry (   9,  -13), $00, SpriteSmall, $02C, 2, 1, false, false
        .structSpriteEntry (   1,  -13), $00, SpriteSmall, $02D, 2, 1, false, false
        .structSpriteEntry (  17,  -37), $00, SpriteSmall, $02E, 2, 1, false, false
        .structSpriteEntry (   9,  -37), $00, SpriteSmall, $02F, 2, 1, false, false
        .structSpriteEntry (   9,  -45), $00, SpriteSmall, $032, 2, 1, false, false
        .structSpriteEntry (   9,  -29), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry (  -7,  -29), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry ( -15,  -21), $00, SpriteSmall, $033, 2, 1, false, false
        .structSpriteEntry ( -15,  -29), $00, SpriteSmall, $035, 2, 1, false, false
        .structSpriteEntry ( -23,  -29), $00, SpriteSmall, $036, 2, 1, false, false
        .structSpriteEntry (  -7,  -45), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry ( -23,  -45), $21, SpriteLarge, $00E, 2, 1, false, false
        .structSpriteEntry ( -31,  -53), $21, SpriteLarge, $020, 2, 1, false, false
        .structSpriteEntry ( -15,  -45), $00, SpriteSmall, $037, 2, 1, false, false
        .structSpriteEntry ( -15,  -53), $00, SpriteSmall, $038, 2, 1, false, false
        ANIM_RECORD_END

      _Record13
        ANIM_RECORD 5
        .structSpriteEntry (  16,  -47), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry (   8,  -39), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (   0,  -39), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry (  -8,  -39), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (   0,  -55), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -16,  -55), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry ( -13,  -41), $21, SpriteLarge, $0A8, 2, 0, false, false
        .structSpriteEntry ( -13,  -57), $21, SpriteLarge, $088, 2, 0, false, false
        .structSpriteEntry (  -3,   -7), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry ( -11,   -7), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry ( -11,  -23), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -11,  -39), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -19,  -39), $00, SpriteSmall, $02A, 2, 1, false, false
        .structSpriteEntry (   5,  -39), $00, SpriteSmall, $02B, 2, 1, false, false
        .structSpriteEntry (  21,  -23), $00, SpriteSmall, $02C, 2, 1, false, false
        .structSpriteEntry (  45,   -7), $00, SpriteSmall, $02D, 2, 1, false, false
        .structSpriteEntry (  37,   -7), $00, SpriteSmall, $02E, 2, 1, false, false
        .structSpriteEntry (  21,  -15), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry (   5,  -15), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry (   5,  -31), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry ( -27,  -15), $21, SpriteLarge, $00E, 2, 1, false, false
        .structSpriteEntry ( -27,  -31), $21, SpriteLarge, $020, 2, 1, false, false
        .structSpriteEntry ( -27,  -47), $21, SpriteLarge, $022, 2, 1, false, false
        .structSpriteEntry ( -11,  -39), $00, SpriteSmall, $02F, 2, 1, false, false
        .structSpriteEntry ( -11,  -47), $00, SpriteSmall, $034, 2, 1, false, false
        ANIM_RECORD_END

      _Record14
        ANIM_RECORD 5
        .structSpriteEntry ( -31,  -53), $00, SpriteSmall, $0DC, 2, 2, false, false
        .structSpriteEntry ( -39,  -53), $00, SpriteSmall, $0CC, 2, 2, false, false
        .structSpriteEntry ( -47,  -53), $00, SpriteSmall, $0CB, 2, 2, false, false
        .structSpriteEntry (  16,  -47), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry (   8,  -39), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (   0,  -39), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry (  -8,  -39), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (   0,  -55), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -16,  -55), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry ( -26,  -51), $00, SpriteSmall, $0C8, 2, 0, false, false
        .structSpriteEntry ( -26,  -43), $00, SpriteSmall, $0D8, 2, 0, false, false
        .structSpriteEntry ( -18,  -35), $21, SpriteLarge, $0E9, 2, 0, false, false
        .structSpriteEntry ( -18,  -51), $21, SpriteLarge, $0C9, 2, 0, false, false
        .structSpriteEntry (  -3,   -7), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry ( -11,   -7), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry ( -11,  -23), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -11,  -39), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -19,  -39), $00, SpriteSmall, $02A, 2, 1, false, false
        .structSpriteEntry (   5,  -39), $00, SpriteSmall, $02B, 2, 1, false, false
        .structSpriteEntry (  21,  -23), $00, SpriteSmall, $02C, 2, 1, false, false
        .structSpriteEntry (  45,   -7), $00, SpriteSmall, $02D, 2, 1, false, false
        .structSpriteEntry (  37,   -7), $00, SpriteSmall, $02E, 2, 1, false, false
        .structSpriteEntry (  21,  -15), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry (   5,  -15), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry (   5,  -31), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry ( -27,  -15), $21, SpriteLarge, $00E, 2, 1, false, false
        .structSpriteEntry ( -27,  -31), $21, SpriteLarge, $020, 2, 1, false, false
        .structSpriteEntry ( -27,  -47), $21, SpriteLarge, $022, 2, 1, false, false
        .structSpriteEntry ( -11,  -39), $00, SpriteSmall, $02F, 2, 1, false, false
        .structSpriteEntry ( -11,  -47), $00, SpriteSmall, $035, 2, 1, false, false
        ANIM_RECORD_END

      _Record15
        ANIM_RECORD 5
        .structSpriteEntry ( -51,  -47), $00, SpriteSmall, $0EC, 2, 2, false, false
        .structSpriteEntry ( -59,  -47), $00, SpriteSmall, $0DB, 2, 2, false, false
        .structSpriteEntry ( -59,  -39), $00, SpriteSmall, $0EB, 2, 2, false, false
        .structSpriteEntry (  16,  -47), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry (   8,  -39), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (   0,  -39), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry (  -8,  -39), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (   0,  -55), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -16,  -55), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry ( -26,  -51), $00, SpriteSmall, $0C8, 2, 0, false, false
        .structSpriteEntry ( -26,  -43), $00, SpriteSmall, $0D8, 2, 0, false, false
        .structSpriteEntry ( -18,  -35), $21, SpriteLarge, $0E9, 2, 0, false, false
        .structSpriteEntry ( -18,  -51), $21, SpriteLarge, $0C9, 2, 0, false, false
        .structSpriteEntry (  -3,   -7), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry ( -11,   -7), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry ( -11,  -23), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -11,  -39), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -19,  -39), $00, SpriteSmall, $02A, 2, 1, false, false
        .structSpriteEntry (   5,  -39), $00, SpriteSmall, $02B, 2, 1, false, false
        .structSpriteEntry (  21,  -23), $00, SpriteSmall, $02C, 2, 1, false, false
        .structSpriteEntry (  45,   -7), $00, SpriteSmall, $02D, 2, 1, false, false
        .structSpriteEntry (  37,   -7), $00, SpriteSmall, $02E, 2, 1, false, false
        .structSpriteEntry (  21,  -15), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry (   5,  -15), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry (   5,  -31), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry ( -27,  -15), $21, SpriteLarge, $00E, 2, 1, false, false
        .structSpriteEntry ( -27,  -31), $21, SpriteLarge, $020, 2, 1, false, false
        .structSpriteEntry ( -27,  -47), $21, SpriteLarge, $022, 2, 1, false, false
        .structSpriteEntry ( -11,  -39), $00, SpriteSmall, $02F, 2, 1, false, false
        .structSpriteEntry ( -11,  -47), $00, SpriteSmall, $034, 2, 1, false, false
        ANIM_RECORD_END

      _Record16
        ANIM_RECORD 5
        .structSpriteEntry (  16,  -47), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry (   8,  -39), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (   0,  -39), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry (  -8,  -39), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (   0,  -55), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -16,  -55), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry ( -19,  -39), $21, SpriteLarge, $0AC, 2, 0, false, false
        .structSpriteEntry ( -19,  -55), $21, SpriteLarge, $08C, 2, 0, false, false
        .structSpriteEntry ( -20,  -61), $21, SpriteLarge, $04E, 2, 2, false, false
        .structSpriteEntry ( -20,  -77), $21, SpriteLarge, $04C, 2, 2, false, false
        .structSpriteEntry (  -3,   -7), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry ( -11,   -7), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry ( -11,  -23), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -11,  -39), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -19,  -39), $00, SpriteSmall, $02A, 2, 1, false, false
        .structSpriteEntry (   5,  -39), $00, SpriteSmall, $02B, 2, 1, false, false
        .structSpriteEntry (  21,  -23), $00, SpriteSmall, $02C, 2, 1, false, false
        .structSpriteEntry (  45,   -7), $00, SpriteSmall, $02D, 2, 1, false, false
        .structSpriteEntry (  37,   -7), $00, SpriteSmall, $02E, 2, 1, false, false
        .structSpriteEntry (  21,  -15), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry (   5,  -15), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry (   5,  -31), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry ( -27,  -15), $21, SpriteLarge, $00E, 2, 1, false, false
        .structSpriteEntry ( -27,  -31), $21, SpriteLarge, $020, 2, 1, false, false
        .structSpriteEntry ( -27,  -47), $21, SpriteLarge, $022, 2, 1, false, false
        .structSpriteEntry ( -11,  -39), $00, SpriteSmall, $02F, 2, 1, false, false
        .structSpriteEntry ( -11,  -47), $00, SpriteSmall, $036, 2, 1, false, false
        ANIM_RECORD_END

      _Record17
        ANIM_RECORD 5
        .structSpriteEntry ( -32,  -52), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry ( -48,  -52), $21, SpriteLarge, $044, 2, 2, false, false
        .structSpriteEntry (  16,  -47), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry (   8,  -39), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (   0,  -39), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry (  -8,  -39), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (   0,  -55), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -16,  -55), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry ( -27,  -46), $00, SpriteSmall, $0C0, 2, 0, false, false
        .structSpriteEntry ( -19,  -37), $21, SpriteLarge, $0A6, 2, 0, false, false
        .structSpriteEntry ( -19,  -53), $21, SpriteLarge, $086, 2, 0, false, false
        .structSpriteEntry (  -3,   -7), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry ( -11,   -7), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry ( -11,  -23), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -11,  -39), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -19,  -39), $00, SpriteSmall, $02A, 2, 1, false, false
        .structSpriteEntry (   5,  -39), $00, SpriteSmall, $02B, 2, 1, false, false
        .structSpriteEntry (  21,  -23), $00, SpriteSmall, $02C, 2, 1, false, false
        .structSpriteEntry (  45,   -7), $00, SpriteSmall, $02D, 2, 1, false, false
        .structSpriteEntry (  37,   -7), $00, SpriteSmall, $02E, 2, 1, false, false
        .structSpriteEntry (  21,  -15), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry (   5,  -15), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry (   5,  -31), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry ( -27,  -15), $21, SpriteLarge, $00E, 2, 1, false, false
        .structSpriteEntry ( -27,  -31), $21, SpriteLarge, $020, 2, 1, false, false
        .structSpriteEntry ( -27,  -47), $21, SpriteLarge, $022, 2, 1, false, false
        .structSpriteEntry ( -11,  -39), $00, SpriteSmall, $02F, 2, 1, false, false
        .structSpriteEntry ( -11,  -47), $00, SpriteSmall, $034, 2, 1, false, false
        ANIM_RECORD_END

      aBattleAnimationFramesDragonriderLance ; 9B/AE20

        ; Frame table of entry 29: slices of the class sheet per frame.

        .word _Frame00 - aBattleAnimationFramesDragonriderLance
        .word _Frame01 - aBattleAnimationFramesDragonriderLance
        .word _Frame02 - aBattleAnimationFramesDragonriderLance
        .word _Frame03 - aBattleAnimationFramesDragonriderLance
        .word _Frame04 - aBattleAnimationFramesDragonriderLance
        .word _Frame05 - aBattleAnimationFramesDragonriderLance
        .word _Frame06 - aBattleAnimationFramesDragonriderLance

      _Frame00
        ANIM_TILES
        ANIM_TILE_ROW $0000, $0800
        ANIM_TILES_END

      _Frame01
        ANIM_TILES
        ANIM_TILE_ROW $0800, $06A0
        ANIM_TILES_END

      _Frame02
        ANIM_TILES
        ANIM_TILE_ROW $0EA0, $0720
        ANIM_TILES_END

      _Frame03
        ANIM_TILES
        ANIM_TILE_ROW $15C0, $06C0
        ANIM_TILES_END

      _Frame04
        ANIM_TILES
        ANIM_TILE_ROW $1C80, $07E0
        ANIM_TILES_END

      _Frame05
        ANIM_TILES
        ANIM_TILE_ROW $2460, $06A0
        ANIM_TILES_END

      _Frame06
        ANIM_TILES
        ANIM_TILE_ROW $2B00, $0740
        ANIM_TILES_END

      aBattleAnimationSequencesDragonriderLance ; 9B/AE51

        ; Sequence data of entry 29 of aBattleAnimationFrameTables, used by: Dragonrider (Lance),
        ; Dragonknight (Lance), Dragonmaster (Lance). Frames:
        ; aBattleAnimationFramesDragonriderLance.

        .word _Index - aBattleAnimationSequencesDragonriderLance, _Records - aBattleAnimationSequencesDragonriderLance

      _Index
        .word _Sequence00 - aBattleAnimationSequencesDragonriderLance
        .word _Sequence01 - aBattleAnimationSequencesDragonriderLance
        .word _Sequence02 - aBattleAnimationSequencesDragonriderLance
        .word _Sequence03 - aBattleAnimationSequencesDragonriderLance
        .word _Sequence04 - aBattleAnimationSequencesDragonriderLance
        .word _Sequence05 - aBattleAnimationSequencesDragonriderLance
        .word _Sequence06 - aBattleAnimationSequencesDragonriderLance
        .word _Sequence07 - aBattleAnimationSequencesDragonriderLance
        .word _Sequence08 - aBattleAnimationSequencesDragonriderLance
        .word _Sequence09 - aBattleAnimationSequencesDragonriderLance
        .word _Sequence10 - aBattleAnimationSequencesDragonriderLance
        .word _Sequence11 - aBattleAnimationSequencesDragonriderLance
        .word _Sequence12 - aBattleAnimationSequencesDragonriderLance
        .word _Sequence13 - aBattleAnimationSequencesDragonriderLance
        .word _Sequence14 - aBattleAnimationSequencesDragonriderLance
        .word _Sequence15 - aBattleAnimationSequencesDragonriderLance
        .word _Sequence16 - aBattleAnimationSequencesDragonriderLance
        .word _Sequence17 - aBattleAnimationSequencesDragonriderLance
        .word _Sequence18 - aBattleAnimationSequencesDragonriderLance
        .word _Sequence19 - aBattleAnimationSequencesDragonriderLance
        .word _Sequence20 - aBattleAnimationSequencesDragonriderLance

      _Records
        .word aBattleAnimationSequencesDragonriderRangedLance._Record00 - aBattleAnimationSequencesDragonriderLance
        .word aBattleAnimationSequencesDragonriderRangedLance._Record01 - aBattleAnimationSequencesDragonriderLance
        .word aBattleAnimationSequencesDragonriderRangedLance._Record02 - aBattleAnimationSequencesDragonriderLance
        .word aBattleAnimationSequencesDragonriderRangedLance._Record03 - aBattleAnimationSequencesDragonriderLance
        .word aBattleAnimationSequencesDragonriderRangedLance._Record04 - aBattleAnimationSequencesDragonriderLance
        .word aBattleAnimationSequencesDragonriderRangedLance._Record05 - aBattleAnimationSequencesDragonriderLance
        .word aBattleAnimationSequencesDragonriderRangedLance._Record06 - aBattleAnimationSequencesDragonriderLance
        .word aBattleAnimationSequencesDragonriderRangedLance._Record07 - aBattleAnimationSequencesDragonriderLance
        .word aBattleAnimationSequencesDragonriderRangedLance._Record08 - aBattleAnimationSequencesDragonriderLance
        .word aBattleAnimationSequencesDragonriderRangedLance._Record09 - aBattleAnimationSequencesDragonriderLance
        .word aBattleAnimationSequencesDragonriderRangedLance._Record10 - aBattleAnimationSequencesDragonriderLance
        .word aBattleAnimationSequencesDragonriderRangedLance._Record11 - aBattleAnimationSequencesDragonriderLance
        .word aBattleAnimationSequencesDragonriderRangedLance._Record12 - aBattleAnimationSequencesDragonriderLance
        .word aBattleAnimationSequencesDragonriderRangedLance._Record13 - aBattleAnimationSequencesDragonriderLance
        .word aBattleAnimationSequencesDragonriderRangedLance._Record14 - aBattleAnimationSequencesDragonriderLance
        .word aBattleAnimationSequencesDragonriderRangedLance._Record15 - aBattleAnimationSequencesDragonriderLance
        .word aBattleAnimationSequencesDragonriderRangedLance._Record16 - aBattleAnimationSequencesDragonriderLance
        .word aBattleAnimationSequencesDragonriderRangedLance._Record17 - aBattleAnimationSequencesDragonriderLance
        .word aBattleAnimationSequencesDragonriderRangedLance._Record18 - aBattleAnimationSequencesDragonriderLance
        .word aBattleAnimationSequencesDragonriderRangedLance._Record19 - aBattleAnimationSequencesDragonriderLance

      _Sequence00
        ANIM_CMD_F7
        ANIM_STEP 6, 1
        ANIM_HOLD

      _Sequence01
        ANIM_STEP 5, 2
        ANIM_STEP 4, 4
        ANIM_STEP 1, 5
        ANIM_STEP 2, 5
        ANIM_SOUND 22
        ANIM_STEP 3, 7
        ANIM_STEP 4, 5
        ANIM_STEP 5, 4
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence02
        ANIM_STEP 6, 2
        ANIM_CMD_F4 0
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence03
        ANIM_STEP 7, 2
        ANIM_STEP 12, 19
        ANIM_STEP 13, 2
        ANIM_STEP 6, 4
        ANIM_CMD_F4 0
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence04
        ANIM_SOUND 27
        ANIM_STEP 1, 16
        ANIM_STEP 5, 4
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence05
        ANIM_STEP 5, 1
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence06
        ANIM_STEP 6, 3
        ANIM_CMD_EE
        ANIM_STEP 7, 16
        ANIM_SOUND 4
        ANIM_CMD_F1
        ANIM_STEP 9, 11
        ANIM_STEP 6, 9
        ANIM_CMD_F3
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence07
        ANIM_STEP 5, 3
        ANIM_STEP 4, 6
        ANIM_STEP 1, 6
        ANIM_STEP 2, 6
        ANIM_SOUND 22
        ANIM_STEP 3, 8
        ANIM_STEP 4, 6
        ANIM_STEP 1, 10
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence08
        ANIM_STEP 1, 6
        ANIM_STEP 2, 6
        ANIM_SOUND 22
        ANIM_STEP 3, 6
        ANIM_STEP 4, 6
        ANIM_STEP 1, 19
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence09
        ANIM_SOUND 27
        ANIM_STEP 1, 6
        ANIM_STEP 10, 2
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence10
        ANIM_STEP 10, 2
        ANIM_CMD_EE
        ANIM_STEP 10, 4
        ANIM_STEP 9, 11
        ANIM_SOUND 4
        ANIM_CMD_F1
        ANIM_STEP 9, 3
        ANIM_STEP 6, 10
        ANIM_CMD_F3
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence11
        ANIM_STEP 6, 3
        ANIM_STEP 8, 5
        ANIM_CMD_EE
        ANIM_STEP 7, 9
        ANIM_SOUND 4
        ANIM_STEP 7, 1
        ANIM_STEP 9, 5
        ANIM_CMD_F1
        ANIM_STEP 9, 10
        ANIM_STEP 6, 10
        ANIM_CMD_F3
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence12
        ANIM_STEP 1, 6
        ANIM_STEP 2, 6
        ANIM_SOUND 22
        ANIM_STEP 3, 6
        ANIM_STEP 4, 6
        ANIM_STEP 1, 13
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence13
        ANIM_STEP 5, 2
        ANIM_STEP 10, 5
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence14
        ANIM_STEP 10, 2
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence15
        ANIM_STEP 6, 8
        ANIM_STEP 8, 3
        ANIM_STEP 14, 22
        ANIM_STEP 15, 4
        ANIM_CMD_EF 16
        ANIM_SOUND 11
        ANIM_STEP 16, 16
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence16
        ANIM_STEP 17, 1
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence17
        ANIM_STEP 18, 1
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence18
        ANIM_STEP 19, 1
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence19
        ANIM_STEP 6, 1
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence20
        ANIM_CMD_EB
        ANIM_CMD_F7
        ANIM_STEP 1, 14
        ANIM_STEP 2, 9
        ANIM_SOUND 22
        ANIM_STEP 3, 9
        ANIM_STEP 4, 8
        ANIM_RESTART
        ANIM_HOLD

      aBattleAnimationFramesDragonriderRangedLance ; 9B/AFB3

        ; Frame table of entry 30: slices of the class sheet per frame.

        .word _Frame00 - aBattleAnimationFramesDragonriderRangedLance
        .word _Frame01 - aBattleAnimationFramesDragonriderRangedLance
        .word _Frame02 - aBattleAnimationFramesDragonriderRangedLance
        .word _Frame03 - aBattleAnimationFramesDragonriderRangedLance
        .word _Frame04 - aBattleAnimationFramesDragonriderRangedLance
        .word _Frame05 - aBattleAnimationFramesDragonriderRangedLance
        .word _Frame06 - aBattleAnimationFramesDragonriderRangedLance

      _Frame00
        ANIM_TILES
        ANIM_TILE_ROW $0000, $0800
        ANIM_TILES_END

      _Frame01
        ANIM_TILES
        ANIM_TILE_ROW $0800, $06A0
        ANIM_TILES_END

      _Frame02
        ANIM_TILES
        ANIM_TILE_ROW $0EA0, $0720
        ANIM_TILES_END

      _Frame03
        ANIM_TILES
        ANIM_TILE_ROW $15C0, $06C0
        ANIM_TILES_END

      _Frame04
        ANIM_TILES
        ANIM_TILE_ROW $1C80, $07E0
        ANIM_TILES_END

      _Frame05
        ANIM_TILES
        ANIM_TILE_ROW $2460, $06A0
        ANIM_TILES_END

      _Frame06
        ANIM_TILES
        ANIM_TILE_ROW $2B00, $0740
        ANIM_TILES_END

      aBattleAnimationSequencesDragonriderRangedLance ; 9B/AFE4

        ; Sequence data of entry 30 of aBattleAnimationFrameTables, used by: Dragonrider
        ; (RangedLance), Dragonknight (RangedLance), Dragonmaster (RangedLance). Frames:
        ; aBattleAnimationFramesDragonriderRangedLance.

        .word _Index - aBattleAnimationSequencesDragonriderRangedLance, _Records - aBattleAnimationSequencesDragonriderRangedLance

      _Index
        .word _Sequence00 - aBattleAnimationSequencesDragonriderRangedLance
        .word _Sequence01 - aBattleAnimationSequencesDragonriderRangedLance
        .word _Sequence02 - aBattleAnimationSequencesDragonriderRangedLance
        .word _Sequence03 - aBattleAnimationSequencesDragonriderRangedLance
        .word _Sequence04 - aBattleAnimationSequencesDragonriderRangedLance
        .word _Sequence05 - aBattleAnimationSequencesDragonriderRangedLance
        .word _Sequence06 - aBattleAnimationSequencesDragonriderRangedLance
        .word _Sequence07 - aBattleAnimationSequencesDragonriderRangedLance
        .word _Sequence08 - aBattleAnimationSequencesDragonriderRangedLance
        .word _Sequence09 - aBattleAnimationSequencesDragonriderRangedLance
        .word _Sequence10 - aBattleAnimationSequencesDragonriderRangedLance
        .word _Sequence11 - aBattleAnimationSequencesDragonriderRangedLance
        .word _Sequence12 - aBattleAnimationSequencesDragonriderRangedLance
        .word _Sequence13 - aBattleAnimationSequencesDragonriderRangedLance
        .word _Sequence14 - aBattleAnimationSequencesDragonriderRangedLance
        .word _Sequence15 - aBattleAnimationSequencesDragonriderRangedLance
        .word _Sequence16 - aBattleAnimationSequencesDragonriderRangedLance
        .word _Sequence17 - aBattleAnimationSequencesDragonriderRangedLance
        .word _Sequence18 - aBattleAnimationSequencesDragonriderRangedLance

      _Records
        .word _Record00 - aBattleAnimationSequencesDragonriderRangedLance
        .word _Record01 - aBattleAnimationSequencesDragonriderRangedLance
        .word _Record02 - aBattleAnimationSequencesDragonriderRangedLance
        .word _Record03 - aBattleAnimationSequencesDragonriderRangedLance
        .word _Record04 - aBattleAnimationSequencesDragonriderRangedLance
        .word _Record05 - aBattleAnimationSequencesDragonriderRangedLance
        .word _Record06 - aBattleAnimationSequencesDragonriderRangedLance
        .word _Record07 - aBattleAnimationSequencesDragonriderRangedLance
        .word _Record08 - aBattleAnimationSequencesDragonriderRangedLance
        .word _Record09 - aBattleAnimationSequencesDragonriderRangedLance
        .word _Record10 - aBattleAnimationSequencesDragonriderRangedLance
        .word _Record11 - aBattleAnimationSequencesDragonriderRangedLance
        .word _Record12 - aBattleAnimationSequencesDragonriderRangedLance
        .word _Record13 - aBattleAnimationSequencesDragonriderRangedLance
        .word _Record14 - aBattleAnimationSequencesDragonriderRangedLance
        .word _Record15 - aBattleAnimationSequencesDragonriderRangedLance
        .word _Record16 - aBattleAnimationSequencesDragonriderRangedLance
        .word _Record17 - aBattleAnimationSequencesDragonriderRangedLance
        .word _Record18 - aBattleAnimationSequencesDragonriderRangedLance
        .word _Record19 - aBattleAnimationSequencesDragonriderRangedLance

      _Sequence00
        ANIM_CMD_ED 2
        ANIM_CMD_F7
        ANIM_STEP 6, 1
        ANIM_HOLD

      _Sequence01
        ANIM_CMD_EB
        ANIM_CMD_F7
        ANIM_STEP 1, 14
        ANIM_STEP 2, 9
        ANIM_SOUND 22
        ANIM_STEP 3, 9
        ANIM_STEP 4, 9
        ANIM_RESTART
        ANIM_HOLD

      _Sequence02
        ANIM_STEP 6, 8
        ANIM_STEP 12, 14
        ANIM_STEP 13, 3
        ANIM_STEP 6, 2
        ANIM_CMD_F4 1
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence03
        ANIM_STEP 1, 5
        ANIM_STEP 2, 5
        ANIM_SOUND 22
        ANIM_STEP 3, 5
        ANIM_STEP 4, 5
        ANIM_STEP 1, 5
        ANIM_STEP 2, 5
        ANIM_SOUND 22
        ANIM_STEP 3, 5
        ANIM_STEP 4, 5
        ANIM_STEP 5, 2
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence04
        ANIM_STEP 6, 7
        ANIM_STEP 8, 7
        ANIM_CMD_EE
        ANIM_STEP 7, 16
        ANIM_CMD_F1
        ANIM_SOUND 0
        ANIM_STEP 9, 13
        ANIM_STEP 7, 2
        ANIM_CMD_F3
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence05
        ANIM_STEP 1, 5
        ANIM_STEP 2, 5
        ANIM_SOUND 22
        ANIM_STEP 3, 4
        ANIM_STEP 4, 4
        ANIM_STEP 5, 14
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence06
        ANIM_STEP 5, 5
        ANIM_STEP 4, 5
        ANIM_STEP 1, 5
        ANIM_STEP 2, 5
        ANIM_SOUND 22
        ANIM_STEP 3, 5
        ANIM_STEP 4, 11
        ANIM_STEP 1, 7
        ANIM_STEP 2, 7
        ANIM_SOUND 22
        ANIM_STEP 3, 8
        ANIM_STEP 4, 3
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence07
        ANIM_STEP 6, 3
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence08
        ANIM_STEP 8, 5
        ANIM_STEP 7, 5
        ANIM_STEP 10, 8
        ANIM_CMD_EE
        ANIM_STEP 10, 7
        ANIM_STEP 9, 9
        ANIM_CMD_F1
        ANIM_SOUND 0
        ANIM_STEP 8, 16
        ANIM_CMD_F3
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence09
        ANIM_STEP 5, 7
        ANIM_STEP 4, 3
        ANIM_STEP 1, 6
        ANIM_STEP 2, 6
        ANIM_SOUND 22
        ANIM_STEP 3, 6
        ANIM_STEP 4, 11
        ANIM_STEP 5, 8
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence10
        ANIM_STEP 6, 1
        ANIM_CMD_F4 1
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence11
        ANIM_STEP 10, 38
        ANIM_CMD_EE
        ANIM_STEP 7, 5
        ANIM_STEP 9, 9
        ANIM_CMD_F1
        ANIM_SOUND 0
        ANIM_STEP 8, 4
        ANIM_CMD_F3
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence12
        ANIM_STEP 6, 2
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence13
        ANIM_STEP 6, 10
        ANIM_STEP 15, 6
        ANIM_STEP 14, 16
        ANIM_CMD_EF 78
        ANIM_SOUND 11
        ANIM_STEP 16, 16
        ANIM_CMD_EE
        ANIM_STEP 6, 48
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence14
        ANIM_STEP 17, 0
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence15
        ANIM_STEP 17, 0
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence16
        ANIM_STEP 18, 0
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence17
        ANIM_STEP 19, 0
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence18
        ANIM_STEP 19, 0
        ANIM_CMD_F7
        ANIM_HOLD

      _Record00
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (  -4,   -3), $00, SpriteSmall, $0F1, 2, 3, false, false
        .structSpriteEntry ( -12,   -3), $00, SpriteSmall, $0F1, 2, 3, false, false
        .structSpriteEntry ( -20,   -3), $00, SpriteSmall, $0F1, 2, 3, false, false
        .structSpriteEntry ( -28,   -3), $00, SpriteSmall, $0F1, 2, 3, false, false
        .structSpriteEntry ( -36,   -3), $00, SpriteSmall, $0F0, 2, 3, false, false
        .structSpriteEntry (  28,   -2), $00, SpriteSmall, $0F0, 2, 3, true, true
        .structSpriteEntry (  20,   -3), $00, SpriteSmall, $0F1, 2, 3, false, false
        .structSpriteEntry (  12,   -3), $00, SpriteSmall, $0F1, 2, 3, false, false
        .structSpriteEntry (   4,   -3), $00, SpriteSmall, $0F1, 2, 3, false, false
        ANIM_RECORD_END

      _Record01
        ANIM_RECORD 0
        .structSpriteEntry ( -20,  -57), $00, SpriteSmall, $043, 2, 2, false, true
        .structSpriteEntry ( -28,  -57), $00, SpriteSmall, $042, 2, 2, false, true
        .structSpriteEntry ( -44,  -70), $21, SpriteLarge, $040, 2, 2, false, true
        .structSpriteEntry ( -16,  -49), $21, SpriteLarge, $0A0, 2, 0, false, false
        .structSpriteEntry ( -16,  -65), $21, SpriteLarge, $080, 2, 0, false, false
        .structSpriteEntry (  16, -100), $00, SpriteSmall, $020, 2, 1, false, false
        .structSpriteEntry (  16,  -92), $00, SpriteSmall, $021, 2, 1, false, false
        .structSpriteEntry (   8,  -92), $00, SpriteSmall, $022, 2, 1, false, false
        .structSpriteEntry (  24,  -74), $00, SpriteSmall, $023, 2, 1, false, false
        .structSpriteEntry (  24, -100), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry (  16,  -84), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (   8,  -84), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry (   0,  -84), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (   8,  -60), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry (   8,  -76), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (  -8,  -60), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  -8,  -76), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry (  35,   -9), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry (  27,   -9), $00, SpriteSmall, $02A, 2, 1, false, false
        .structSpriteEntry (  24,  -16), $00, SpriteSmall, $02B, 2, 1, false, false
        .structSpriteEntry (  21,  -23), $00, SpriteSmall, $02C, 2, 1, false, false
        .structSpriteEntry (  21,  -31), $00, SpriteSmall, $02D, 2, 1, false, false
        .structSpriteEntry (  21,  -39), $00, SpriteSmall, $02E, 2, 1, false, false
        .structSpriteEntry ( -27,  -32), $00, SpriteSmall, $02F, 2, 1, false, false
        .structSpriteEntry ( -35,  -32), $00, SpriteSmall, $030, 2, 1, false, false
        .structSpriteEntry ( -35,  -40), $00, SpriteSmall, $031, 2, 1, false, false
        .structSpriteEntry ( -19,  -32), $00, SpriteSmall, $032, 2, 1, false, false
        .structSpriteEntry ( -14,  -24), $00, SpriteSmall, $033, 2, 1, false, false
        .structSpriteEntry (  12,  -16), $00, SpriteSmall, $034, 2, 1, false, false
        .structSpriteEntry (  -3,  -32), $00, SpriteSmall, $035, 2, 1, false, false
        .structSpriteEntry ( -11,  -32), $00, SpriteSmall, $036, 2, 1, false, false
        .structSpriteEntry (  -3,  -24), $00, SpriteSmall, $037, 2, 1, false, false
        .structSpriteEntry (   5,  -32), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry (   5,  -48), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry ( -11,  -48), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry ( -27,  -48), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry ( -25,  -88), $00, SpriteSmall, $038, 2, 1, false, false
        .structSpriteEntry ( -25,  -96), $00, SpriteSmall, $039, 2, 1, false, false
        .structSpriteEntry ( -19,  -80), $00, SpriteSmall, $03A, 2, 1, false, false
        .structSpriteEntry ( -27,  -80), $00, SpriteSmall, $03B, 2, 1, false, false
        .structSpriteEntry (  -9,  -56), $00, SpriteSmall, $03C, 2, 1, false, false
        .structSpriteEntry ( -17,  -56), $00, SpriteSmall, $03D, 2, 1, false, false
        .structSpriteEntry ( -11,  -64), $00, SpriteSmall, $03E, 2, 1, false, false
        .structSpriteEntry ( -11,  -72), $00, SpriteSmall, $03F, 2, 1, false, false
        .structSpriteEntry ( -27,  -72), $21, SpriteLarge, $00E, 2, 1, false, false
        ANIM_RECORD_END

      _Record02
        ANIM_RECORD 1
        .structSpriteEntry ( -16,  -48), $21, SpriteLarge, $0A0, 2, 0, false, false
        .structSpriteEntry ( -16,  -64), $21, SpriteLarge, $080, 2, 0, false, false
        .structSpriteEntry (  33,  -54), $00, SpriteSmall, $00E, 2, 1, false, false
        .structSpriteEntry (  25,  -54), $00, SpriteSmall, $00F, 2, 1, false, false
        .structSpriteEntry (  25,  -46), $00, SpriteSmall, $01E, 2, 1, false, false
        .structSpriteEntry (  17,  -46), $00, SpriteSmall, $01F, 2, 1, false, false
        .structSpriteEntry (   9,  -46), $00, SpriteSmall, $020, 2, 1, false, false
        .structSpriteEntry (   1,  -46), $00, SpriteSmall, $021, 2, 1, false, false
        .structSpriteEntry (  -7,  -46), $00, SpriteSmall, $022, 2, 1, false, false
        .structSpriteEntry (   9,  -38), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (  -7,  -38), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  35,   -8), $00, SpriteSmall, $023, 2, 1, false, false
        .structSpriteEntry (  27,   -8), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry (  24,  -15), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (  21,  -22), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry (  21,  -30), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (  21,  -38), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry ( -27,  -31), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry ( -35,  -31), $00, SpriteSmall, $02A, 2, 1, false, false
        .structSpriteEntry ( -35,  -39), $00, SpriteSmall, $02B, 2, 1, false, false
        .structSpriteEntry ( -19,  -31), $00, SpriteSmall, $02C, 2, 1, false, false
        .structSpriteEntry ( -14,  -23), $00, SpriteSmall, $02D, 2, 1, false, false
        .structSpriteEntry (  12,  -15), $00, SpriteSmall, $02E, 2, 1, false, false
        .structSpriteEntry (  -3,  -31), $00, SpriteSmall, $02F, 2, 1, false, false
        .structSpriteEntry ( -11,  -31), $00, SpriteSmall, $030, 2, 1, false, false
        .structSpriteEntry (  -3,  -23), $00, SpriteSmall, $031, 2, 1, false, false
        .structSpriteEntry (   5,  -31), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry (   5,  -47), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -11,  -47), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry ( -27,  -47), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry ( -20,  -56), $00, SpriteSmall, $043, 2, 2, false, true
        .structSpriteEntry ( -28,  -56), $00, SpriteSmall, $042, 2, 2, false, true
        .structSpriteEntry ( -44,  -69), $21, SpriteLarge, $040, 2, 2, false, true
        .structSpriteEntry ( -24,  -66), $00, SpriteSmall, $032, 2, 1, false, false
        .structSpriteEntry ( -21,  -58), $00, SpriteSmall, $033, 2, 1, false, false
        .structSpriteEntry ( -29,  -50), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry ( -29,  -58), $00, SpriteSmall, $034, 2, 1, false, false
        ANIM_RECORD_END

      _Record03
        ANIM_RECORD 2
        .structSpriteEntry ( -16,  -47), $21, SpriteLarge, $0A0, 2, 0, false, false
        .structSpriteEntry ( -16,  -63), $21, SpriteLarge, $080, 2, 0, false, false
        .structSpriteEntry (  -1,    5), $00, SpriteSmall, $020, 2, 1, false, false
        .structSpriteEntry (  -1,   -3), $00, SpriteSmall, $021, 2, 1, false, false
        .structSpriteEntry (   8,  -19), $00, SpriteSmall, $022, 2, 1, false, false
        .structSpriteEntry (   8,  -27), $00, SpriteSmall, $023, 2, 1, false, false
        .structSpriteEntry (   8,  -35), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry (   5,  -11), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (  -3,  -11), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry (  -8,  -27), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (  -8,  -43), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  35,   -7), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (  27,   -7), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry (  24,  -14), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry (  21,  -21), $00, SpriteSmall, $02A, 2, 1, false, false
        .structSpriteEntry (  21,  -29), $00, SpriteSmall, $02B, 2, 1, false, false
        .structSpriteEntry (  21,  -37), $00, SpriteSmall, $02C, 2, 1, false, false
        .structSpriteEntry ( -27,  -30), $00, SpriteSmall, $02D, 2, 1, false, false
        .structSpriteEntry ( -35,  -30), $00, SpriteSmall, $02E, 2, 1, false, false
        .structSpriteEntry ( -35,  -38), $00, SpriteSmall, $02F, 2, 1, false, false
        .structSpriteEntry ( -19,  -30), $00, SpriteSmall, $030, 2, 1, false, false
        .structSpriteEntry ( -14,  -22), $00, SpriteSmall, $031, 2, 1, false, false
        .structSpriteEntry (  12,  -14), $00, SpriteSmall, $032, 2, 1, false, false
        .structSpriteEntry (  -3,  -30), $00, SpriteSmall, $033, 2, 1, false, false
        .structSpriteEntry ( -11,  -30), $00, SpriteSmall, $034, 2, 1, false, false
        .structSpriteEntry (  -3,  -22), $00, SpriteSmall, $035, 2, 1, false, false
        .structSpriteEntry (   5,  -30), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry (   5,  -46), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -11,  -46), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry ( -27,  -46), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry ( -31,  -33), $00, SpriteSmall, $036, 2, 1, false, false
        .structSpriteEntry ( -15,   -9), $00, SpriteSmall, $037, 2, 1, false, false
        .structSpriteEntry ( -23,   -9), $00, SpriteSmall, $038, 2, 1, false, false
        .structSpriteEntry ( -23,  -25), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry ( -23,  -41), $21, SpriteLarge, $00E, 2, 1, false, false
        .structSpriteEntry ( -20,  -55), $00, SpriteSmall, $043, 2, 2, false, true
        .structSpriteEntry ( -28,  -55), $00, SpriteSmall, $042, 2, 2, false, true
        .structSpriteEntry ( -44,  -68), $21, SpriteLarge, $040, 2, 2, false, true
        ANIM_RECORD_END

      _Record04
        ANIM_RECORD 3
        .structSpriteEntry ( -20,  -56), $00, SpriteSmall, $043, 2, 2, false, true
        .structSpriteEntry ( -28,  -56), $00, SpriteSmall, $042, 2, 2, false, true
        .structSpriteEntry ( -44,  -69), $21, SpriteLarge, $040, 2, 2, false, true
        .structSpriteEntry ( -16,  -48), $21, SpriteLarge, $0A0, 2, 0, false, false
        .structSpriteEntry ( -16,  -64), $21, SpriteLarge, $080, 2, 0, false, false
        .structSpriteEntry (  24,  -54), $00, SpriteSmall, $020, 2, 1, false, false
        .structSpriteEntry (   5,  -70), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (  -8,  -54), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  12,  -30), $00, SpriteSmall, $021, 2, 1, false, false
        .structSpriteEntry (  12,  -38), $00, SpriteSmall, $022, 2, 1, false, false
        .structSpriteEntry (  -3,  -62), $00, SpriteSmall, $023, 2, 1, false, false
        .structSpriteEntry (  -3,  -70), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry (   8,  -54), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry (  35,   -8), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (  27,   -8), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry (  24,  -15), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (  21,  -22), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry (  21,  -30), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry (  21,  -38), $00, SpriteSmall, $02A, 2, 1, false, false
        .structSpriteEntry ( -27,  -31), $00, SpriteSmall, $02B, 2, 1, false, false
        .structSpriteEntry ( -35,  -31), $00, SpriteSmall, $02C, 2, 1, false, false
        .structSpriteEntry ( -35,  -39), $00, SpriteSmall, $02D, 2, 1, false, false
        .structSpriteEntry ( -19,  -31), $00, SpriteSmall, $02E, 2, 1, false, false
        .structSpriteEntry ( -14,  -23), $00, SpriteSmall, $02F, 2, 1, false, false
        .structSpriteEntry (  12,  -15), $00, SpriteSmall, $030, 2, 1, false, false
        .structSpriteEntry (  -3,  -31), $00, SpriteSmall, $031, 2, 1, false, false
        .structSpriteEntry ( -11,  -31), $00, SpriteSmall, $032, 2, 1, false, false
        .structSpriteEntry (  -3,  -23), $00, SpriteSmall, $033, 2, 1, false, false
        .structSpriteEntry (   5,  -31), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry (   5,  -47), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry ( -11,  -47), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry ( -27,  -47), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry ( -21,  -34), $00, SpriteSmall, $034, 2, 1, false, false
        .structSpriteEntry ( -21,  -42), $00, SpriteSmall, $035, 2, 1, false, false
        .structSpriteEntry ( -29,  -58), $21, SpriteLarge, $00E, 2, 1, false, false
        ANIM_RECORD_END

      _Record05
        ANIM_RECORD 4
        .structSpriteEntry ( -18,  -45), $21, SpriteLarge, $0A2, 2, 0, false, false
        .structSpriteEntry ( -18,  -61), $21, SpriteLarge, $082, 2, 0, false, false
        .structSpriteEntry (  11,  -29), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry (  11,  -37), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (  23,  -53), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry (   4,  -69), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   7,  -53), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  -9,  -53), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry (  -4,  -61), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (  -4,  -69), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry ( -46,  -45), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry (  -6,  -58), $00, SpriteSmall, $053, 2, 2, false, false
        .structSpriteEntry ( -22,  -50), $00, SpriteSmall, $043, 2, 2, false, false
        .structSpriteEntry ( -30,  -50), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry (  26,  -21), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry (  34,   -5), $00, SpriteSmall, $02A, 2, 1, false, false
        .structSpriteEntry (  26,   -5), $00, SpriteSmall, $02B, 2, 1, false, false
        .structSpriteEntry (  26,  -13), $00, SpriteSmall, $02C, 2, 1, false, false
        .structSpriteEntry ( -38,  -19), $00, SpriteSmall, $02D, 2, 1, false, false
        .structSpriteEntry ( -38,  -35), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -14,  -13), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry (  18,  -13), $00, SpriteSmall, $02E, 2, 1, false, false
        .structSpriteEntry (  10,  -13), $00, SpriteSmall, $02F, 2, 1, false, false
        .structSpriteEntry (   2,  -13), $00, SpriteSmall, $034, 2, 1, false, false
        .structSpriteEntry (  18,  -37), $00, SpriteSmall, $035, 2, 1, false, false
        .structSpriteEntry (  10,  -37), $00, SpriteSmall, $036, 2, 1, false, false
        .structSpriteEntry (  10,  -45), $00, SpriteSmall, $037, 2, 1, false, false
        .structSpriteEntry (  10,  -29), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry (  -6,  -29), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry (  -6,  -45), $21, SpriteLarge, $00E, 2, 1, false, false
        .structSpriteEntry ( -14,  -21), $00, SpriteSmall, $038, 2, 1, false, false
        .structSpriteEntry ( -14,  -29), $00, SpriteSmall, $039, 2, 1, false, false
        .structSpriteEntry ( -22,  -29), $00, SpriteSmall, $03A, 2, 1, false, false
        .structSpriteEntry ( -22,  -45), $21, SpriteLarge, $020, 2, 1, false, false
        .structSpriteEntry ( -21,  -32), $00, SpriteSmall, $03B, 2, 1, false, false
        .structSpriteEntry ( -21,  -40), $00, SpriteSmall, $03C, 2, 1, false, false
        .structSpriteEntry ( -13,  -48), $00, SpriteSmall, $03D, 2, 1, false, false
        .structSpriteEntry ( -13,  -56), $00, SpriteSmall, $03E, 2, 1, false, false
        .structSpriteEntry ( -29,  -56), $21, SpriteLarge, $022, 2, 1, false, false
        ANIM_RECORD_END

      _Record06
        ANIM_RECORD 5
        .structSpriteEntry (  16,  -47), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry (   8,  -39), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (   0,  -39), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry (  -8,  -39), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (   0,  -55), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -16,  -55), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry ( -17,  -54), $21, SpriteLarge, $084, 2, 0, false, false
        .structSpriteEntry ( -17,  -38), $21, SpriteLarge, $0A4, 2, 0, false, false
        .structSpriteEntry (  -3,   -7), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry ( -11,   -7), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry ( -11,  -23), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -11,  -39), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -19,  -39), $00, SpriteSmall, $02A, 2, 1, false, false
        .structSpriteEntry (   5,  -39), $00, SpriteSmall, $02B, 2, 1, false, false
        .structSpriteEntry (  21,  -23), $00, SpriteSmall, $02C, 2, 1, false, false
        .structSpriteEntry (  45,   -7), $00, SpriteSmall, $02D, 2, 1, false, false
        .structSpriteEntry (  37,   -7), $00, SpriteSmall, $02E, 2, 1, false, false
        .structSpriteEntry (  21,  -15), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry (   5,  -15), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry (   5,  -31), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry ( -27,  -15), $21, SpriteLarge, $00E, 2, 1, false, false
        .structSpriteEntry ( -27,  -31), $21, SpriteLarge, $020, 2, 1, false, false
        .structSpriteEntry ( -45,  -44), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry ( -21,  -49), $00, SpriteSmall, $043, 2, 2, false, false
        .structSpriteEntry ( -29,  -49), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry (  -5,  -57), $00, SpriteSmall, $053, 2, 2, false, false
        .structSpriteEntry (   3,  -65), $00, SpriteSmall, $044, 2, 2, false, false
        .structSpriteEntry ( -27,  -47), $21, SpriteLarge, $022, 2, 1, false, false
        .structSpriteEntry ( -11,  -39), $00, SpriteSmall, $02F, 2, 1, false, false
        .structSpriteEntry ( -11,  -47), $00, SpriteSmall, $034, 2, 1, false, false
        ANIM_RECORD_END

      _Record07
        ANIM_RECORD 5
        .structSpriteEntry (  16,  -47), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry (   8,  -39), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (   0,  -39), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry (  -8,  -39), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (   0,  -55), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -16,  -55), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry ( -13,  -41), $21, SpriteLarge, $0A8, 2, 0, false, false
        .structSpriteEntry ( -13,  -57), $21, SpriteLarge, $088, 2, 0, false, false
        .structSpriteEntry (  -3,   -7), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry ( -11,   -7), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry ( -11,  -23), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -11,  -39), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -19,  -39), $00, SpriteSmall, $02A, 2, 1, false, false
        .structSpriteEntry (   5,  -39), $00, SpriteSmall, $02B, 2, 1, false, false
        .structSpriteEntry (  21,  -23), $00, SpriteSmall, $02C, 2, 1, false, false
        .structSpriteEntry (  45,   -7), $00, SpriteSmall, $02D, 2, 1, false, false
        .structSpriteEntry (  37,   -7), $00, SpriteSmall, $02E, 2, 1, false, false
        .structSpriteEntry (  21,  -15), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry (   5,  -15), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry (   5,  -31), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry ( -27,  -15), $21, SpriteLarge, $00E, 2, 1, false, false
        .structSpriteEntry ( -27,  -31), $21, SpriteLarge, $020, 2, 1, false, false
        .structSpriteEntry ( -36,  -51), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry (   4,  -64), $00, SpriteSmall, $053, 2, 2, false, false
        .structSpriteEntry (  -4,  -64), $00, SpriteSmall, $052, 2, 2, false, false
        .structSpriteEntry ( -12,  -56), $00, SpriteSmall, $043, 2, 2, false, false
        .structSpriteEntry ( -20,  -56), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry (  12,  -72), $00, SpriteSmall, $044, 2, 2, false, false
        .structSpriteEntry ( -27,  -47), $21, SpriteLarge, $022, 2, 1, false, false
        .structSpriteEntry ( -11,  -39), $00, SpriteSmall, $02F, 2, 1, false, false
        .structSpriteEntry ( -11,  -47), $00, SpriteSmall, $034, 2, 1, false, false
        ANIM_RECORD_END

      _Record08
        ANIM_RECORD 5
        .structSpriteEntry ( -44,  -50), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry (  -4,  -63), $00, SpriteSmall, $053, 2, 2, false, false
        .structSpriteEntry ( -12,  -63), $00, SpriteSmall, $052, 2, 2, false, false
        .structSpriteEntry ( -20,  -55), $00, SpriteSmall, $043, 2, 2, false, false
        .structSpriteEntry ( -28,  -55), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry (   4,  -71), $00, SpriteSmall, $044, 2, 2, false, false
        .structSpriteEntry (  16,  -47), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry (   8,  -39), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (   0,  -39), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry (  -8,  -39), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (   0,  -55), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -16,  -55), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry ( -18,  -40), $21, SpriteLarge, $0AA, 2, 0, false, false
        .structSpriteEntry ( -18,  -56), $21, SpriteLarge, $08A, 2, 0, false, false
        .structSpriteEntry (  -3,   -7), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry ( -11,   -7), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry ( -11,  -23), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -11,  -39), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -19,  -39), $00, SpriteSmall, $02A, 2, 1, false, false
        .structSpriteEntry (   5,  -39), $00, SpriteSmall, $02B, 2, 1, false, false
        .structSpriteEntry (  21,  -23), $00, SpriteSmall, $02C, 2, 1, false, false
        .structSpriteEntry (  45,   -7), $00, SpriteSmall, $02D, 2, 1, false, false
        .structSpriteEntry (  37,   -7), $00, SpriteSmall, $02E, 2, 1, false, false
        .structSpriteEntry (  21,  -15), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry (   5,  -15), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry (   5,  -31), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry ( -27,  -15), $21, SpriteLarge, $00E, 2, 1, false, false
        .structSpriteEntry ( -27,  -31), $21, SpriteLarge, $020, 2, 1, false, false
        .structSpriteEntry ( -27,  -47), $21, SpriteLarge, $022, 2, 1, false, false
        .structSpriteEntry ( -11,  -39), $00, SpriteSmall, $02F, 2, 1, false, false
        .structSpriteEntry ( -11,  -47), $00, SpriteSmall, $035, 2, 1, false, false
        ANIM_RECORD_END

      _Record09
        ANIM_RECORD 5
        .structSpriteEntry ( -57,  -31), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry ( -33,  -36), $00, SpriteSmall, $043, 2, 2, false, false
        .structSpriteEntry ( -41,  -36), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry (  16,  -47), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry (   8,  -39), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (   0,  -39), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry (  -8,  -39), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (   0,  -55), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -16,  -55), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry ( -26,  -51), $00, SpriteSmall, $0C8, 2, 0, false, false
        .structSpriteEntry ( -26,  -43), $00, SpriteSmall, $0D8, 2, 0, false, false
        .structSpriteEntry ( -18,  -35), $21, SpriteLarge, $0E9, 2, 0, false, false
        .structSpriteEntry ( -18,  -51), $21, SpriteLarge, $0C9, 2, 0, false, false
        .structSpriteEntry (  -3,   -7), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry ( -11,   -7), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry ( -11,  -23), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -11,  -39), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -19,  -39), $00, SpriteSmall, $02A, 2, 1, false, false
        .structSpriteEntry (   5,  -39), $00, SpriteSmall, $02B, 2, 1, false, false
        .structSpriteEntry (  21,  -23), $00, SpriteSmall, $02C, 2, 1, false, false
        .structSpriteEntry (  45,   -7), $00, SpriteSmall, $02D, 2, 1, false, false
        .structSpriteEntry (  37,   -7), $00, SpriteSmall, $02E, 2, 1, false, false
        .structSpriteEntry (  21,  -15), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry (   5,  -15), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry (   5,  -31), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry ( -27,  -15), $21, SpriteLarge, $00E, 2, 1, false, false
        .structSpriteEntry ( -27,  -31), $21, SpriteLarge, $020, 2, 1, false, false
        .structSpriteEntry ( -27,  -47), $21, SpriteLarge, $022, 2, 1, false, false
        .structSpriteEntry ( -11,  -39), $00, SpriteSmall, $02F, 2, 1, false, false
        .structSpriteEntry ( -11,  -47), $00, SpriteSmall, $034, 2, 1, false, false
        ANIM_RECORD_END

      _Record10
        ANIM_RECORD 6
        .structSpriteEntry ( -39,  -58), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry (   1,  -71), $00, SpriteSmall, $053, 2, 2, false, false
        .structSpriteEntry (  -7,  -71), $00, SpriteSmall, $052, 2, 2, false, false
        .structSpriteEntry ( -15,  -63), $00, SpriteSmall, $043, 2, 2, false, false
        .structSpriteEntry ( -23,  -63), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry (   9,  -79), $00, SpriteSmall, $044, 2, 2, false, false
        .structSpriteEntry (   7,  -45), $00, SpriteSmall, $022, 2, 1, false, false
        .structSpriteEntry (  -1,  -45), $00, SpriteSmall, $023, 2, 1, false, false
        .structSpriteEntry (  -9,  -45), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry (  15,  -53), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (  -1,  -61), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -17,  -61), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry ( -16,  -47), $21, SpriteLarge, $0A8, 2, 0, false, false
        .structSpriteEntry ( -16,  -63), $21, SpriteLarge, $088, 2, 0, false, false
        .structSpriteEntry ( -39,  -19), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry ( -39,  -35), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -15,  -13), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry (  25,  -21), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (  33,   -5), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry (  25,   -5), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry (  25,  -13), $00, SpriteSmall, $02A, 2, 1, false, false
        .structSpriteEntry (  17,  -13), $00, SpriteSmall, $02B, 2, 1, false, false
        .structSpriteEntry (   9,  -13), $00, SpriteSmall, $02C, 2, 1, false, false
        .structSpriteEntry (   1,  -13), $00, SpriteSmall, $02D, 2, 1, false, false
        .structSpriteEntry (  17,  -37), $00, SpriteSmall, $02E, 2, 1, false, false
        .structSpriteEntry (   9,  -37), $00, SpriteSmall, $02F, 2, 1, false, false
        .structSpriteEntry (   9,  -45), $00, SpriteSmall, $032, 2, 1, false, false
        .structSpriteEntry (   9,  -29), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry (  -7,  -29), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry ( -15,  -21), $00, SpriteSmall, $033, 2, 1, false, false
        .structSpriteEntry ( -15,  -29), $00, SpriteSmall, $036, 2, 1, false, false
        .structSpriteEntry ( -23,  -29), $00, SpriteSmall, $037, 2, 1, false, false
        .structSpriteEntry (  -7,  -45), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry ( -23,  -45), $21, SpriteLarge, $00E, 2, 1, false, false
        .structSpriteEntry ( -31,  -53), $21, SpriteLarge, $020, 2, 1, false, false
        .structSpriteEntry ( -15,  -45), $00, SpriteSmall, $038, 2, 1, false, false
        .structSpriteEntry ( -15,  -53), $00, SpriteSmall, $039, 2, 1, false, false
        ANIM_RECORD_END

      _Record11
        ANIM_RECORD 5
        .structSpriteEntry (  16,  -47), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry (   8,  -39), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (   0,  -39), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry (  -8,  -39), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (   0,  -55), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -16,  -55), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry ( -16,  -34), $21, SpriteLarge, $045, 2, 2, true, false
        .structSpriteEntry ( -29,  -58), $00, SpriteSmall, $058, 2, 2, true, false
        .structSpriteEntry ( -29,  -66), $00, SpriteSmall, $048, 2, 2, true, false
        .structSpriteEntry ( -21,  -42), $00, SpriteSmall, $057, 2, 2, true, false
        .structSpriteEntry ( -21,  -50), $00, SpriteSmall, $047, 2, 2, true, false
        .structSpriteEntry ( -25,  -54), $00, SpriteSmall, $0C1, 2, 0, false, false
        .structSpriteEntry ( -17,  -39), $21, SpriteLarge, $0E2, 2, 0, false, false
        .structSpriteEntry ( -17,  -55), $21, SpriteLarge, $0C2, 2, 0, false, false
        .structSpriteEntry (  -3,   -7), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry ( -11,   -7), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry ( -11,  -23), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -11,  -39), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -19,  -39), $00, SpriteSmall, $02A, 2, 1, false, false
        .structSpriteEntry (   5,  -39), $00, SpriteSmall, $02B, 2, 1, false, false
        .structSpriteEntry (  21,  -23), $00, SpriteSmall, $02C, 2, 1, false, false
        .structSpriteEntry (  45,   -7), $00, SpriteSmall, $02D, 2, 1, false, false
        .structSpriteEntry (  37,   -7), $00, SpriteSmall, $02E, 2, 1, false, false
        .structSpriteEntry (  21,  -15), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry (   5,  -15), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry (   5,  -31), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry ( -27,  -15), $21, SpriteLarge, $00E, 2, 1, false, false
        .structSpriteEntry ( -27,  -31), $21, SpriteLarge, $020, 2, 1, false, false
        .structSpriteEntry ( -27,  -47), $21, SpriteLarge, $022, 2, 1, false, false
        .structSpriteEntry ( -11,  -39), $00, SpriteSmall, $02F, 2, 1, false, false
        .structSpriteEntry ( -11,  -47), $00, SpriteSmall, $034, 2, 1, false, false
        .structSpriteEntry ( -37,  -74), $00, SpriteSmall, $054, 2, 2, true, false
        ANIM_RECORD_END

      _Record12
        ANIM_RECORD 6
        .structSpriteEntry (   7,  -45), $00, SpriteSmall, $022, 2, 1, false, false
        .structSpriteEntry (  -1,  -45), $00, SpriteSmall, $023, 2, 1, false, false
        .structSpriteEntry (  -9,  -45), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry (  15,  -53), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (  -1,  -61), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -17,  -61), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry ( -28,  -46), $21, SpriteLarge, $045, 2, 2, false, false
        .structSpriteEntry ( -15,  -54), $00, SpriteSmall, $057, 2, 2, false, false
        .structSpriteEntry ( -15,  -62), $00, SpriteSmall, $047, 2, 2, false, false
        .structSpriteEntry (   1,  -86), $00, SpriteSmall, $054, 2, 2, false, false
        .structSpriteEntry (  -7,  -70), $00, SpriteSmall, $058, 2, 2, false, false
        .structSpriteEntry (  -7,  -78), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry ( -16,  -47), $21, SpriteLarge, $0A8, 2, 0, false, false
        .structSpriteEntry ( -16,  -63), $21, SpriteLarge, $088, 2, 0, false, false
        .structSpriteEntry ( -39,  -19), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry ( -39,  -35), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -15,  -13), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry (  25,  -21), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (  33,   -5), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry (  25,   -5), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry (  25,  -13), $00, SpriteSmall, $02A, 2, 1, false, false
        .structSpriteEntry (  17,  -13), $00, SpriteSmall, $02B, 2, 1, false, false
        .structSpriteEntry (   9,  -13), $00, SpriteSmall, $02C, 2, 1, false, false
        .structSpriteEntry (   1,  -13), $00, SpriteSmall, $02D, 2, 1, false, false
        .structSpriteEntry (  17,  -37), $00, SpriteSmall, $02E, 2, 1, false, false
        .structSpriteEntry (   9,  -37), $00, SpriteSmall, $02F, 2, 1, false, false
        .structSpriteEntry (   9,  -45), $00, SpriteSmall, $032, 2, 1, false, false
        .structSpriteEntry (   9,  -29), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry (  -7,  -29), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry ( -15,  -21), $00, SpriteSmall, $033, 2, 1, false, false
        .structSpriteEntry ( -15,  -29), $00, SpriteSmall, $035, 2, 1, false, false
        .structSpriteEntry ( -23,  -29), $00, SpriteSmall, $036, 2, 1, false, false
        .structSpriteEntry (  -7,  -45), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry ( -23,  -45), $21, SpriteLarge, $00E, 2, 1, false, false
        .structSpriteEntry ( -31,  -53), $21, SpriteLarge, $020, 2, 1, false, false
        .structSpriteEntry ( -15,  -45), $00, SpriteSmall, $037, 2, 1, false, false
        .structSpriteEntry ( -15,  -53), $00, SpriteSmall, $038, 2, 1, false, false
        ANIM_RECORD_END

      _Record13
        ANIM_RECORD 5
        .structSpriteEntry (  16,  -47), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry (   8,  -39), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (   0,  -39), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry (  -8,  -39), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (   0,  -55), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -16,  -55), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry ( -26,  -38), $21, SpriteLarge, $045, 2, 2, false, false
        .structSpriteEntry ( -13,  -46), $00, SpriteSmall, $057, 2, 2, false, false
        .structSpriteEntry ( -13,  -54), $00, SpriteSmall, $047, 2, 2, false, false
        .structSpriteEntry (   3,  -78), $00, SpriteSmall, $054, 2, 2, false, false
        .structSpriteEntry (  -5,  -62), $00, SpriteSmall, $058, 2, 2, false, false
        .structSpriteEntry (  -5,  -70), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry ( -13,  -41), $21, SpriteLarge, $0A8, 2, 0, false, false
        .structSpriteEntry ( -13,  -57), $21, SpriteLarge, $088, 2, 0, false, false
        .structSpriteEntry (  -3,   -7), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry ( -11,   -7), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry ( -11,  -23), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -11,  -39), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -19,  -39), $00, SpriteSmall, $02A, 2, 1, false, false
        .structSpriteEntry (   5,  -39), $00, SpriteSmall, $02B, 2, 1, false, false
        .structSpriteEntry (  21,  -23), $00, SpriteSmall, $02C, 2, 1, false, false
        .structSpriteEntry (  45,   -7), $00, SpriteSmall, $02D, 2, 1, false, false
        .structSpriteEntry (  37,   -7), $00, SpriteSmall, $02E, 2, 1, false, false
        .structSpriteEntry (  21,  -15), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry (   5,  -15), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry (   5,  -31), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry ( -27,  -15), $21, SpriteLarge, $00E, 2, 1, false, false
        .structSpriteEntry ( -27,  -31), $21, SpriteLarge, $020, 2, 1, false, false
        .structSpriteEntry ( -27,  -47), $21, SpriteLarge, $022, 2, 1, false, false
        .structSpriteEntry ( -11,  -39), $00, SpriteSmall, $02F, 2, 1, false, false
        .structSpriteEntry ( -11,  -47), $00, SpriteSmall, $034, 2, 1, false, false
        ANIM_RECORD_END

      _Record14
        ANIM_RECORD 5
        .structSpriteEntry (  16,  -47), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry (   8,  -39), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (   0,  -39), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry (  -8,  -39), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (   0,  -55), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -16,  -55), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry ( -13,  -41), $21, SpriteLarge, $0A8, 2, 0, false, false
        .structSpriteEntry ( -13,  -57), $21, SpriteLarge, $088, 2, 0, false, false
        .structSpriteEntry (  -3,   -7), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry ( -11,   -7), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry ( -11,  -23), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -11,  -39), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -19,  -39), $00, SpriteSmall, $02A, 2, 1, false, false
        .structSpriteEntry (   5,  -39), $00, SpriteSmall, $02B, 2, 1, false, false
        .structSpriteEntry (  21,  -23), $00, SpriteSmall, $02C, 2, 1, false, false
        .structSpriteEntry (  45,   -7), $00, SpriteSmall, $02D, 2, 1, false, false
        .structSpriteEntry (  37,   -7), $00, SpriteSmall, $02E, 2, 1, false, false
        .structSpriteEntry (  21,  -15), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry (   5,  -15), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry (   5,  -31), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry ( -27,  -15), $21, SpriteLarge, $00E, 2, 1, false, false
        .structSpriteEntry ( -27,  -31), $21, SpriteLarge, $020, 2, 1, false, false
        .structSpriteEntry ( -36,  -78), $21, SpriteLarge, $040, 2, 2, false, true
        .structSpriteEntry (   4,  -57), $00, SpriteSmall, $053, 2, 2, false, true
        .structSpriteEntry (  -4,  -57), $00, SpriteSmall, $052, 2, 2, false, true
        .structSpriteEntry ( -12,  -65), $00, SpriteSmall, $043, 2, 2, false, true
        .structSpriteEntry ( -20,  -65), $00, SpriteSmall, $042, 2, 2, false, true
        .structSpriteEntry (  12,  -49), $00, SpriteSmall, $044, 2, 2, false, true
        .structSpriteEntry ( -27,  -47), $21, SpriteLarge, $022, 2, 1, false, false
        .structSpriteEntry ( -11,  -39), $00, SpriteSmall, $02F, 2, 1, false, false
        .structSpriteEntry ( -11,  -47), $00, SpriteSmall, $035, 2, 1, false, false
        ANIM_RECORD_END

      _Record15
        ANIM_RECORD 5
        .structSpriteEntry (  16,  -47), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry (   8,  -39), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (   0,  -39), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry (  -8,  -39), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (   0,  -55), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -16,  -55), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry ( -45,  -76), $21, SpriteLarge, $040, 2, 2, false, true
        .structSpriteEntry (  -5,  -55), $00, SpriteSmall, $053, 2, 2, false, true
        .structSpriteEntry ( -13,  -55), $00, SpriteSmall, $052, 2, 2, false, true
        .structSpriteEntry ( -21,  -63), $00, SpriteSmall, $043, 2, 2, false, true
        .structSpriteEntry ( -29,  -63), $00, SpriteSmall, $042, 2, 2, false, true
        .structSpriteEntry (   3,  -47), $00, SpriteSmall, $044, 2, 2, false, true
        .structSpriteEntry ( -18,  -40), $21, SpriteLarge, $0AA, 2, 0, false, false
        .structSpriteEntry ( -18,  -56), $21, SpriteLarge, $08A, 2, 0, false, false
        .structSpriteEntry (  -3,   -7), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry ( -11,   -7), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry ( -11,  -23), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -11,  -39), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -19,  -39), $00, SpriteSmall, $02A, 2, 1, false, false
        .structSpriteEntry (   5,  -39), $00, SpriteSmall, $02B, 2, 1, false, false
        .structSpriteEntry (  21,  -23), $00, SpriteSmall, $02C, 2, 1, false, false
        .structSpriteEntry (  45,   -7), $00, SpriteSmall, $02D, 2, 1, false, false
        .structSpriteEntry (  37,   -7), $00, SpriteSmall, $02E, 2, 1, false, false
        .structSpriteEntry (  21,  -15), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry (   5,  -15), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry (   5,  -31), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry ( -27,  -15), $21, SpriteLarge, $00E, 2, 1, false, false
        .structSpriteEntry ( -27,  -31), $21, SpriteLarge, $020, 2, 1, false, false
        .structSpriteEntry ( -27,  -47), $21, SpriteLarge, $022, 2, 1, false, false
        .structSpriteEntry ( -11,  -39), $00, SpriteSmall, $02F, 2, 1, false, false
        .structSpriteEntry ( -11,  -47), $00, SpriteSmall, $034, 2, 1, false, false
        ANIM_RECORD_END

      _Record16
        ANIM_RECORD 5
        .structSpriteEntry (  16,  -47), $00, SpriteSmall, $024, 2, 1, false, false
        .structSpriteEntry (   8,  -39), $00, SpriteSmall, $025, 2, 1, false, false
        .structSpriteEntry (   0,  -39), $00, SpriteSmall, $026, 2, 1, false, false
        .structSpriteEntry (  -8,  -39), $00, SpriteSmall, $027, 2, 1, false, false
        .structSpriteEntry (   0,  -55), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -16,  -55), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry ( -26,  -51), $00, SpriteSmall, $0C8, 2, 0, false, false
        .structSpriteEntry ( -26,  -43), $00, SpriteSmall, $0D8, 2, 0, false, false
        .structSpriteEntry ( -18,  -35), $21, SpriteLarge, $0E9, 2, 0, false, false
        .structSpriteEntry ( -18,  -51), $21, SpriteLarge, $0C9, 2, 0, false, false
        .structSpriteEntry (  -3,   -7), $00, SpriteSmall, $028, 2, 1, false, false
        .structSpriteEntry ( -11,   -7), $00, SpriteSmall, $029, 2, 1, false, false
        .structSpriteEntry ( -11,  -23), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -11,  -39), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -19,  -39), $00, SpriteSmall, $02A, 2, 1, false, false
        .structSpriteEntry (   5,  -39), $00, SpriteSmall, $02B, 2, 1, false, false
        .structSpriteEntry (  21,  -23), $00, SpriteSmall, $02C, 2, 1, false, false
        .structSpriteEntry (  45,   -7), $00, SpriteSmall, $02D, 2, 1, false, false
        .structSpriteEntry (  37,   -7), $00, SpriteSmall, $02E, 2, 1, false, false
        .structSpriteEntry (  21,  -15), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry (   5,  -15), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry (   5,  -31), $21, SpriteLarge, $00C, 2, 1, false, false
        .structSpriteEntry ( -27,  -15), $21, SpriteLarge, $00E, 2, 1, false, false
        .structSpriteEntry ( -27,  -31), $21, SpriteLarge, $020, 2, 1, false, false
        .structSpriteEntry ( -27,  -47), $21, SpriteLarge, $022, 2, 1, false, false
        .structSpriteEntry ( -11,  -39), $00, SpriteSmall, $02F, 2, 1, false, false
        .structSpriteEntry ( -11,  -47), $00, SpriteSmall, $036, 2, 1, false, false
        ANIM_RECORD_END

      _Record17
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry ( -29,  -30), $21, SpriteLarge, $040, 2, 2, false, true
        .structSpriteEntry (  11,   -9), $00, SpriteSmall, $053, 2, 2, false, true
        .structSpriteEntry (   3,   -9), $00, SpriteSmall, $052, 2, 2, false, true
        .structSpriteEntry (  -5,  -17), $00, SpriteSmall, $043, 2, 2, false, true
        .structSpriteEntry ( -13,  -17), $00, SpriteSmall, $042, 2, 2, false, true
        .structSpriteEntry (  19,   -1), $00, SpriteSmall, $044, 2, 2, false, true
        ANIM_RECORD_END

      _Record18
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (  16,  -16), $00, SpriteSmall, $05F, 2, 2, false, false
        .structSpriteEntry (   8,  -16), $00, SpriteSmall, $05E, 2, 2, false, false
        .structSpriteEntry (   0,  -16), $00, SpriteSmall, $05D, 2, 2, false, false
        .structSpriteEntry (  -8,  -16), $00, SpriteSmall, $05C, 2, 2, false, false
        .structSpriteEntry ( -16,  -16), $00, SpriteSmall, $05B, 2, 2, false, false
        .structSpriteEntry ( -24,  -16), $00, SpriteSmall, $05A, 2, 2, false, false
        .structSpriteEntry ( -32,  -16), $00, SpriteSmall, $059, 2, 2, false, false
        ANIM_RECORD_END

      _Record19
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry ( -31,   -8), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry (   9,  -21), $00, SpriteSmall, $053, 2, 2, false, false
        .structSpriteEntry (   1,  -21), $00, SpriteSmall, $052, 2, 2, false, false
        .structSpriteEntry (  -7,  -13), $00, SpriteSmall, $043, 2, 2, false, false
        .structSpriteEntry ( -15,  -13), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry (  17,  -29), $00, SpriteSmall, $044, 2, 2, false, false
        ANIM_RECORD_END

      aBattleAnimationFramesUnknown45 ; 9B/BC9E

        ; Frame table of entry 45: slices of the class sheet per frame.

        .word _Frame00 - aBattleAnimationFramesUnknown45
        .word _Frame01 - aBattleAnimationFramesUnknown45
        .word _Frame02 - aBattleAnimationFramesUnknown45
        .word _Frame03 - aBattleAnimationFramesUnknown45
        .word _Frame04 - aBattleAnimationFramesUnknown45
        .word _Frame05 - aBattleAnimationFramesUnknown45
        .word _Frame06 - aBattleAnimationFramesUnknown45
        .word _Frame07 - aBattleAnimationFramesUnknown45
        .word _Frame08 - aBattleAnimationFramesUnknown45
        .word _Frame09 - aBattleAnimationFramesUnknown45
        .word _Frame10 - aBattleAnimationFramesUnknown45
        .word _Frame11 - aBattleAnimationFramesUnknown45
        .word _Frame12 - aBattleAnimationFramesUnknown45
        .word _Frame13 - aBattleAnimationFramesUnknown45
        .word _Frame14 - aBattleAnimationFramesUnknown45
        .word _Frame15 - aBattleAnimationFramesUnknown45
        .word _Frame16 - aBattleAnimationFramesUnknown45
        .word _Frame17 - aBattleAnimationFramesUnknown45
        .word _Frame18 - aBattleAnimationFramesUnknown45
        .word _Frame19 - aBattleAnimationFramesUnknown45

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
        ANIM_TILE_ROW $0900, $0180
        ANIM_TILE_ROW $0A80, $00C0
        ANIM_TILES_END

      _Frame07
        ANIM_TILES
        ANIM_TILE_ROW $0B40, $01A0
        ANIM_TILE_ROW $0CE0, $00C0
        ANIM_TILES_END

      _Frame08
        ANIM_TILES
        ANIM_TILE_ROW $0DA0, $0160
        ANIM_TILE_ROW $0F00, $00C0
        ANIM_TILES_END

      _Frame09
        ANIM_TILES
        ANIM_TILE_ROW $0FC0, $0100
        ANIM_TILE_ROW $10C0, $0080
        ANIM_TILES_END

      _Frame10
        ANIM_TILES
        ANIM_TILE_ROW $1140, $0100
        ANIM_TILE_ROW $1240, $0080
        ANIM_TILES_END

      _Frame11
        ANIM_TILES
        ANIM_TILE_ROW $12C0, $0100
        ANIM_TILE_ROW $13C0, $0080
        ANIM_TILES_END

      _Frame12
        ANIM_TILES
        ANIM_TILE_ROW $1440, $00E0
        ANIM_TILE_ROW $1520, $0040
        ANIM_TILES_END

      _Frame13
        ANIM_TILES
        ANIM_TILE_ROW $1560, $00E0
        ANIM_TILE_ROW $1640, $0040
        ANIM_TILES_END

      _Frame14
        ANIM_TILES
        ANIM_TILE_ROW $1680, $01E0
        ANIM_TILE_ROW $1860, $00C0
        ANIM_TILES_END

      _Frame15
        ANIM_TILES
        ANIM_TILE_ROW $1920, $0140
        ANIM_TILE_ROW $1A60, $00C0
        ANIM_TILES_END

      _Frame16
        ANIM_TILES
        ANIM_TILE_ROW $1B20, $0140
        ANIM_TILE_ROW $1C60, $0100
        ANIM_TILES_END

      _Frame17
        ANIM_TILES
        ANIM_TILE_ROW $1D60, $01A0
        ANIM_TILE_ROW $1F00, $00C0
        ANIM_TILES_END

      _Frame18
        ANIM_TILES
        ANIM_TILE_ROW $1FC0, $01A0
        ANIM_TILE_ROW $2160, $00C0
        ANIM_TILES_END

      _Frame19
        ANIM_TILES
        ANIM_TILE_ROW $2220, $01C0
        ANIM_TILE_ROW $23E0, $0080
        ANIM_TILES_END

      aBattleAnimationSequencesUnknown45 ; 9B/BD7A

        ; Sequence data of entry 45 of aBattleAnimationFrameTables; no record of the animation
        ; lookup uses it. Frames: aBattleAnimationFramesUnknown45.

        .word _Index - aBattleAnimationSequencesUnknown45, _Records - aBattleAnimationSequencesUnknown45

      _Index
        .word _Sequence00 - aBattleAnimationSequencesUnknown45
        .word _Sequence01 - aBattleAnimationSequencesUnknown45
        .word _Sequence02 - aBattleAnimationSequencesUnknown45
        .word _Sequence03 - aBattleAnimationSequencesUnknown45
        .word _Sequence04 - aBattleAnimationSequencesUnknown45

      _Records
        .word _Record00 - aBattleAnimationSequencesUnknown45
        .word _Record01 - aBattleAnimationSequencesUnknown45
        .word _Record02 - aBattleAnimationSequencesUnknown45
        .word _Record03 - aBattleAnimationSequencesUnknown45
        .word _Record04 - aBattleAnimationSequencesUnknown45
        .word _Record05 - aBattleAnimationSequencesUnknown45
        .word _Record06 - aBattleAnimationSequencesUnknown45
        .word _Record07 - aBattleAnimationSequencesUnknown45
        .word _Record08 - aBattleAnimationSequencesUnknown45
        .word _Record09 - aBattleAnimationSequencesUnknown45
        .word _Record10 - aBattleAnimationSequencesUnknown45
        .word _Record11 - aBattleAnimationSequencesUnknown45
        .word _Record12 - aBattleAnimationSequencesUnknown45
        .word _Record13 - aBattleAnimationSequencesUnknown45
        .word _Record14 - aBattleAnimationSequencesUnknown45
        .word _Record15 - aBattleAnimationSequencesUnknown45
        .word _Record16 - aBattleAnimationSequencesUnknown45
        .word _Record17 - aBattleAnimationSequencesUnknown45
        .word _Record18 - aBattleAnimationSequencesUnknown45
        .word _Record19 - aBattleAnimationSequencesUnknown45
        .word _Record20 - aBattleAnimationSequencesUnknown45

      _Sequence00
        ANIM_CMD_F7
        ANIM_STEP 1, 1
        ANIM_HOLD

      _Sequence01
        ANIM_STEP 1, 16
        ANIM_STEP 2, 6
        ANIM_STEP 3, 7
        ANIM_SOUND 33
        ANIM_STEP 4, 7
        ANIM_STEP 5, 7
        ANIM_STEP 10, 7
        ANIM_STEP 11, 7
        ANIM_STEP 10, 7
        ANIM_STEP 11, 8
        ANIM_STEP 6, 6
        ANIM_STEP 12, 0
        ANIM_STEP 13, 6
        ANIM_STEP 14, 22
        ANIM_STEP 7, 6
        ANIM_STEP 8, 6
        ANIM_STEP 15, 6
        ANIM_STEP 17, 8
        ANIM_STEP 16, 8
        ANIM_STEP 9, 10
        ANIM_STEP 18, 7
        ANIM_STEP 19, 6
        ANIM_STEP 20, 32
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence02
        ANIM_STEP 2, 16
        ANIM_STEP 3, 16
        ANIM_STEP 4, 16
        ANIM_STEP 5, 16
        ANIM_STEP 10, 16
        ANIM_STEP 11, 16
        ANIM_STEP 10, 16
        ANIM_STEP 11, 16
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence03
        ANIM_STEP 11, 32
        ANIM_STEP 6, 32
        ANIM_STEP 12, 32
        ANIM_STEP 13, 32
        ANIM_STEP 14, 32
        ANIM_STEP 7, 32
        ANIM_STEP 8, 32
        ANIM_CMD_F7
        ANIM_HOLD

      _Sequence04
        ANIM_STEP 8, 32
        ANIM_STEP 15, 32
        ANIM_STEP 17, 32
        ANIM_STEP 16, 32
        ANIM_STEP 9, 32
        ANIM_STEP 18, 32
        ANIM_STEP 19, 32
        ANIM_STEP 20, 32
        ANIM_CMD_F7
        ANIM_HOLD

      _Record00
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (   3,   -5), $00, SpriteSmall, $0F1, 2, 3, false, false
        .structSpriteEntry (  11,   -5), $00, SpriteSmall, $0F2, 2, 3, false, false
        .structSpriteEntry (  -5,   -5), $00, SpriteSmall, $0F1, 2, 3, false, false
        .structSpriteEntry ( -13,   -5), $00, SpriteSmall, $0F0, 2, 3, false, false
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
        .structSpriteEntry (   5,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   5,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   5,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   5,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -11,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -11,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record03
        ANIM_RECORD 2
        .structSpriteEntry ( -14,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -14,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   2,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   2,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   2,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   2,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        ANIM_RECORD_END

      _Record04
        ANIM_RECORD 3
        .structSpriteEntry ( -13,  -39), $00, SpriteSmall, $0F9, 2, 0, false, false
        .structSpriteEntry (  -5,  -39), $00, SpriteSmall, $0FA, 2, 0, false, false
        .structSpriteEntry (   3,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   3,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   3,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   3,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -13,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -13,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record05
        ANIM_RECORD 4
        .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   4,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   4,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   4,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        ANIM_RECORD_END

      _Record06
        ANIM_RECORD 5
        .structSpriteEntry (   5,   -6), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   5,  -14), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   5,  -22), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   5,  -30), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -11,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -11,  -30), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record07
        ANIM_RECORD 6
        .structSpriteEntry ( -18,  -10), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry ( -18,  -18), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -10,  -18), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -14,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -14,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry (   2,   -7), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -15), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (   2,  -23), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry (   2,  -31), $00, SpriteSmall, $00B, 2, 0, false, false
        ANIM_RECORD_END

      _Record08
        ANIM_RECORD 7
        .structSpriteEntry (   7,  -19), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (  -1,  -19), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry (  -9,  -19), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (  -1,  -35), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (   2,   -7), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (   2,  -15), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry (   2,  -23), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   2,  -31), $00, SpriteSmall, $00C, 2, 0, false, false
        .structSpriteEntry ( -14,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -14,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        ANIM_RECORD_END

      _Record09
        ANIM_RECORD 8
        .structSpriteEntry ( -32,  -35), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -16,  -27), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   2,   -7), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry (   2,  -15), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -23), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (   2,  -31), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry ( -14,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -14,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        ANIM_RECORD_END

      _Record10
        ANIM_RECORD 9
        .structSpriteEntry (  -9,  -16), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (  -9,  -32), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   7,   -8), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   7,  -16), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   7,  -24), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   7,  -32), $00, SpriteSmall, $007, 2, 0, false, false
        ANIM_RECORD_END

      _Record11
        ANIM_RECORD 10
        .structSpriteEntry (   2,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   2,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   2,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   2,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -14,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -14,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record12
        ANIM_RECORD 11
        .structSpriteEntry (   5,   -6), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   5,  -14), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   5,  -22), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   5,  -30), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -11,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -11,  -30), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record13
        ANIM_RECORD 12
        .structSpriteEntry (   5,   -6), $00, SpriteSmall, $002, 2, 0, false, false
        .structSpriteEntry (   5,  -14), $00, SpriteSmall, $003, 2, 0, false, false
        .structSpriteEntry (   5,  -22), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (  -3,  -22), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry ( -11,  -22), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry ( -11,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        ANIM_RECORD_END

      _Record14
        ANIM_RECORD 13
        .structSpriteEntry (  -3,  -22), $00, SpriteSmall, $002, 2, 0, false, false
        .structSpriteEntry ( -11,  -22), $00, SpriteSmall, $003, 2, 0, false, false
        .structSpriteEntry (   5,   -6), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   5,  -14), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   5,  -22), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry ( -11,  -14), $21, SpriteLarge, $000, 2, 0, false, false
        ANIM_RECORD_END

      _Record15
        ANIM_RECORD 14
        .structSpriteEntry (  -1,  -21), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (  -1,  -29), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry (   7,  -29), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (  15,  -37), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   7,  -37), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  -1,  -37), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry (   2,   -7), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   2,  -15), $00, SpriteSmall, $00C, 2, 0, false, false
        .structSpriteEntry (   2,  -23), $00, SpriteSmall, $00D, 2, 0, false, false
        .structSpriteEntry (   2,  -31), $00, SpriteSmall, $00E, 2, 0, false, false
        .structSpriteEntry ( -14,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -14,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        ANIM_RECORD_END

      _Record16
        ANIM_RECORD 15
        .structSpriteEntry (  16,  -39), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   8,  -39), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry (   0,  -39), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (  -8,  -39), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (   8,  -31), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (  -8,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (  -8,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        ANIM_RECORD_END

      _Record17
        ANIM_RECORD 16
        .structSpriteEntry (  10,  -39), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,  -39), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (   2,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -14,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   2,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -14,  -31), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record18
        ANIM_RECORD 17
        .structSpriteEntry ( -16,   -8), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry ( -16,  -16), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -16,  -24), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry ( -32,  -16), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (   2,   -7), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (   2,  -15), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry (   2,  -23), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   2,  -31), $00, SpriteSmall, $00C, 2, 0, false, false
        .structSpriteEntry ( -14,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -14,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        ANIM_RECORD_END

      _Record19
        ANIM_RECORD 18
        .structSpriteEntry ( -32,  -17), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -16,   -9), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry ( -16,  -17), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -16,  -25), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (   2,   -7), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (   2,  -15), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry (   2,  -23), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   2,  -31), $00, SpriteSmall, $00C, 2, 0, false, false
        .structSpriteEntry ( -14,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -14,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        ANIM_RECORD_END

      _Record20
        ANIM_RECORD 19
        .structSpriteEntry ( -24,   -9), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry ( -32,   -9), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry ( -40,   -9), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry ( -16,   -9), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -16,  -17), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry ( -16,  -25), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (   2,   -7), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry (   2,  -15), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   2,  -23), $00, SpriteSmall, $00C, 2, 0, false, false
        .structSpriteEntry (   2,  -31), $00, SpriteSmall, $00D, 2, 0, false, false
        .structSpriteEntry ( -14,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -14,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

    .endsection BattleAnimationFrameData9BSection
