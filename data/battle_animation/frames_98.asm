; Battle animation frame data in bank $98: sequence data blocks and frame tables
; reached from aBattleAnimationFrameTables. Written by tools/battle_frames.py;
; formats and macros in include/BattleAnimation.h.

    .section BattleAnimationFrameData98Section

      aBattleAnimationFramesPrincessStaff ; 98/B41E

        ; Frame table of entries 4, 5: slices of the class sheet per frame.

        .word _Frame00 - aBattleAnimationFramesPrincessStaff
        .word _Frame01 - aBattleAnimationFramesPrincessStaff
        .word _Frame02 - aBattleAnimationFramesPrincessStaff
        .word _Frame03 - aBattleAnimationFramesPrincessStaff
        .word _Frame04 - aBattleAnimationFramesPrincessStaff
        .word _Frame05 - aBattleAnimationFramesPrincessStaff
        .word _Frame06 - aBattleAnimationFramesPrincessStaff
        .word _Frame07 - aBattleAnimationFramesPrincessStaff
        .word _Frame08 - aBattleAnimationFramesPrincessStaff
        .word _Frame09 - aBattleAnimationFramesPrincessStaff
        .word _Frame10 - aBattleAnimationFramesPrincessStaff
        .word _Frame11 - aBattleAnimationFramesPrincessStaff
        .word _Frame12 - aBattleAnimationFramesPrincessStaff
        .word _Frame13 - aBattleAnimationFramesPrincessStaff
        .word _Frame14 - aBattleAnimationFramesPrincessStaff
        .word _Frame15 - aBattleAnimationFramesPrincessStaff
        .word _Frame16 - aBattleAnimationFramesPrincessStaff

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
        ANIM_TILE_ROW $16C0, $0100
        ANIM_TILES_END

      _Frame14
        ANIM_TILES
        ANIM_TILE_ROW $17C0, $0100
        ANIM_TILE_ROW $18C0, $0080
        ANIM_TILES_END

      _Frame15
        ANIM_TILES
        ANIM_TILE_ROW $1940, $0100
        ANIM_TILE_ROW $1A40, $0080
        ANIM_TILES_END

      _Frame16
        ANIM_TILES
        ANIM_TILE_ROW $1AC0, $0180
        ANIM_TILE_ROW $1C40, $0100
        ANIM_TILES_END

      aBattleAnimationSequencesWarMageMagic ; 98/B4D9

        ; Sequence data of entry 5 of aBattleAnimationFrameTables, used by: WarMage (Magic),
        ; WarMageF (Magic), Queen (Magic), Mage (Magic), FireMage (Magic), ThunderMage (Magic),
        ; WindMage (Magic), HighPriest (Magic), Bishop (Magic), Sage (Magic), Bard (Magic),
        ; Priestess (Magic), DarkMage (Magic), DarkBishop (Magic). Frames:
        ; aBattleAnimationFramesPrincessStaff.

        .word _Index - aBattleAnimationSequencesWarMageMagic, _Records - aBattleAnimationSequencesWarMageMagic

      _Index
        .word _Sequence00 - aBattleAnimationSequencesWarMageMagic
        .word _Sequence01 - aBattleAnimationSequencesWarMageMagic
        .word _Sequence02 - aBattleAnimationSequencesWarMageMagic
        .word _Sequence03 - aBattleAnimationSequencesWarMageMagic
        .word _Sequence04 - aBattleAnimationSequencesWarMageMagic
        .word _Sequence05 - aBattleAnimationSequencesWarMageMagic
        .word _Sequence06 - aBattleAnimationSequencesWarMageMagic
        .word _Sequence07 - aBattleAnimationSequencesWarMageMagic
        .word _Sequence08 - aBattleAnimationSequencesWarMageMagic

      _Records
        .word aBattleAnimationSequencesPrincessStaff._Record00 - aBattleAnimationSequencesWarMageMagic
        .word aBattleAnimationSequencesPrincessStaff._Record01 - aBattleAnimationSequencesWarMageMagic
        .word aBattleAnimationSequencesPrincessStaff._Record02 - aBattleAnimationSequencesWarMageMagic
        .word aBattleAnimationSequencesPrincessStaff._Record03 - aBattleAnimationSequencesWarMageMagic
        .word aBattleAnimationSequencesPrincessStaff._Record04 - aBattleAnimationSequencesWarMageMagic
        .word aBattleAnimationSequencesPrincessStaff._Record05 - aBattleAnimationSequencesWarMageMagic
        .word aBattleAnimationSequencesPrincessStaff._Record06 - aBattleAnimationSequencesWarMageMagic
        .word aBattleAnimationSequencesPrincessStaff._Record07 - aBattleAnimationSequencesWarMageMagic
        .word aBattleAnimationSequencesPrincessStaff._Record08 - aBattleAnimationSequencesWarMageMagic
        .word aBattleAnimationSequencesPrincessStaff._Record09 - aBattleAnimationSequencesWarMageMagic
        .word aBattleAnimationSequencesPrincessStaff._Record10 - aBattleAnimationSequencesWarMageMagic
        .word aBattleAnimationSequencesPrincessStaff._Record11 - aBattleAnimationSequencesWarMageMagic
        .word aBattleAnimationSequencesPrincessStaff._Record12 - aBattleAnimationSequencesWarMageMagic
        .word aBattleAnimationSequencesPrincessStaff._Record13 - aBattleAnimationSequencesWarMageMagic
        .word aBattleAnimationSequencesPrincessStaff._Record14 - aBattleAnimationSequencesWarMageMagic
        .word aBattleAnimationSequencesPrincessStaff._Record15 - aBattleAnimationSequencesWarMageMagic
        .word aBattleAnimationSequencesPrincessStaff._Record16 - aBattleAnimationSequencesWarMageMagic
        .word aBattleAnimationSequencesPrincessStaff._Record17 - aBattleAnimationSequencesWarMageMagic

      _Sequence00
        ANIM_CLEAR_BUSY
        ANIM_STEP 1, 1
        ANIM_HOLD

      _Sequence01
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

      _Sequence02
        ANIM_STEP 6, 15
        ANIM_STEP 7, 14
        ANIM_STEP 8, 4
        ANIM_STEP 9, 1
        ANIM_SOUND 32
        ANIM_CMD_F0 3
        ANIM_STEP 9, 1
        ANIM_CMD_F4 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence03
        ANIM_STEP 11, 3
        ANIM_STEP 12, 3
        ANIM_STEP 13, 3
        ANIM_CMD_F4 2
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence04
        ANIM_CLEAR_BUSY
        ANIM_STEP 15, 6
        ANIM_STEP 16, 5
        ANIM_STEP 15, 4
        ANIM_STEP 15, 1
        ANIM_CMD_F4 1
        ANIM_HOLD

      _Sequence05
        ANIM_CLEAR_BUSY
        ANIM_STEP 16, 2
        ANIM_CMD_EC 1
        ANIM_STEP 16, 1
        ANIM_STEP 16, 1
        ANIM_STEP 16, 1
        ANIM_STEP 16, 1
        ANIM_STEP 16, 1
        ANIM_STEP 16, 1
        ANIM_CMD_EC 0
        ANIM_STEP 16, 2
        ANIM_STEP 16, 1
        ANIM_CMD_F4 1
        ANIM_HOLD

      _Sequence06
        ANIM_STEP 10, 3
        ANIM_STEP 12, 3
        ANIM_STEP 13, 3
        ANIM_CMD_F4 2
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence07
        ANIM_STEP 17, 3
        ANIM_STEP 6, 4
        ANIM_STEP 1, 6
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence08
        ANIM_STEP 1, 5
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      aBattleAnimationSequencesPrincessStaff ; 98/B593

        ; Sequence data of entry 4 of aBattleAnimationFrameTables, used by: Princess (Staff),
        ; WarMageF (Staff), Queen (Staff), Priest (Staff), HighPriest (Staff), Bishop (Staff),
        ; Sage (Staff), Priestess (Staff), DarkMage (Staff), DarkBishop (Staff). Frames:
        ; aBattleAnimationFramesPrincessStaff.

        .word _Index - aBattleAnimationSequencesPrincessStaff, _Records - aBattleAnimationSequencesPrincessStaff

      _Index
        .word _Sequence00 - aBattleAnimationSequencesPrincessStaff
        .word _Sequence01 - aBattleAnimationSequencesPrincessStaff
        .word _Sequence02 - aBattleAnimationSequencesPrincessStaff
        .word _Sequence03 - aBattleAnimationSequencesPrincessStaff
        .word _Sequence04 - aBattleAnimationSequencesPrincessStaff
        .word _Sequence05 - aBattleAnimationSequencesPrincessStaff

      _Records
        .word _Record00 - aBattleAnimationSequencesPrincessStaff
        .word _Record01 - aBattleAnimationSequencesPrincessStaff
        .word _Record02 - aBattleAnimationSequencesPrincessStaff
        .word _Record03 - aBattleAnimationSequencesPrincessStaff
        .word _Record04 - aBattleAnimationSequencesPrincessStaff
        .word _Record05 - aBattleAnimationSequencesPrincessStaff
        .word _Record06 - aBattleAnimationSequencesPrincessStaff
        .word _Record07 - aBattleAnimationSequencesPrincessStaff
        .word _Record08 - aBattleAnimationSequencesPrincessStaff
        .word _Record09 - aBattleAnimationSequencesPrincessStaff
        .word _Record10 - aBattleAnimationSequencesPrincessStaff
        .word _Record11 - aBattleAnimationSequencesPrincessStaff
        .word _Record12 - aBattleAnimationSequencesPrincessStaff
        .word _Record13 - aBattleAnimationSequencesPrincessStaff
        .word _Record14 - aBattleAnimationSequencesPrincessStaff
        .word _Record15 - aBattleAnimationSequencesPrincessStaff
        .word _Record16 - aBattleAnimationSequencesPrincessStaff
        .word _Record17 - aBattleAnimationSequencesPrincessStaff

      _Sequence00
        ANIM_CLEAR_BUSY
        ANIM_STEP 1, 1
        ANIM_HOLD

      _Sequence01
        ANIM_STEP 2, 4
        ANIM_STEP 3, 5
        ANIM_STEP 4, 6
        ANIM_STEP 5, 1
        ANIM_SOUND 32
        ANIM_CMD_F0
        ANIM_STEP 5, 1
        ANIM_CMD_F4 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence02
        ANIM_STEP 11, 3
        ANIM_STEP 14, 1
        ANIM_CMD_F4 1
        ANIM_STEP 3, 3
        ANIM_STEP 2, 3
        ANIM_STEP 1, 5
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence03
        ANIM_STEP 15, 6
        ANIM_STEP 16, 5
        ANIM_STEP 15, 4
        ANIM_STEP 15, 1
        ANIM_CMD_F4 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence04
        ANIM_CLEAR_BUSY
        ANIM_STEP 16, 2
        ANIM_CMD_EC 1
        ANIM_STEP 16, 1
        ANIM_STEP 16, 1
        ANIM_STEP 16, 1
        ANIM_STEP 16, 1
        ANIM_STEP 16, 1
        ANIM_STEP 16, 1
        ANIM_CMD_EC 0
        ANIM_STEP 16, 2
        ANIM_STEP 16, 1
        ANIM_CMD_F4 1
        ANIM_HOLD

      _Sequence05
        ANIM_STEP 1, 5
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
        .structSpriteEntry ( -19,  -40), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry ( -11,   -8), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry ( -11,  -24), $21, SpriteLarge, $044, 2, 2, false, false
        .structSpriteEntry ( -10,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -10,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   6,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   6,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   6,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   6,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        ANIM_RECORD_END

      _Record02
        ANIM_RECORD 1
        .structSpriteEntry ( -20,  -43), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry ( -12,  -11), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry ( -12,  -27), $21, SpriteLarge, $044, 2, 2, false, false
        .structSpriteEntry (   6,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   6,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   6,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   6,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -10,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -10,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record03
        ANIM_RECORD 2
        .structSpriteEntry ( -17,  -32), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry ( -17,  -16), $21, SpriteLarge, $042, 2, 2, false, false
        .structSpriteEntry ( -17,  -48), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry ( -10,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -10,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   6,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   6,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   6,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   6,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        ANIM_RECORD_END

      _Record04
        ANIM_RECORD 3
        .structSpriteEntry ( -17,  -36), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry ( -17,  -20), $21, SpriteLarge, $042, 2, 2, false, false
        .structSpriteEntry ( -17,  -52), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry (   6,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   6,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   6,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   6,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -10,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -10,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record05
        ANIM_RECORD 4
        .structSpriteEntry ( -14,  -42), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry ( -14,  -26), $21, SpriteLarge, $042, 2, 2, false, false
        .structSpriteEntry ( -14,  -58), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry ( -10,  -39), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   6,   -7), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   6,  -15), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   6,  -23), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry (   6,  -31), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry ( -10,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -10,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record06
        ANIM_RECORD 5
        .structSpriteEntry ( -10,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -10,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   6,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   6,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   6,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   6,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        ANIM_RECORD_END

      _Record07
        ANIM_RECORD 6
        .structSpriteEntry (   5,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   5,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   5,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   5,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -11,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -11,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record08
        ANIM_RECORD 7
        .structSpriteEntry ( -11,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -11,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   5,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   5,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   5,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   5,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        ANIM_RECORD_END

      _Record09
        ANIM_RECORD 8
        .structSpriteEntry (  -8,  -39), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   6,   -7), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   6,  -15), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   6,  -23), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry (   6,  -31), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry ( -10,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -10,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record10
        ANIM_RECORD 9
        .structSpriteEntry ( -10,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -10,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   6,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   6,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   6,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   6,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        ANIM_RECORD_END

      _Record11
        ANIM_RECORD 10
        .structSpriteEntry ( -17,  -23), $21, SpriteLarge, $042, 2, 2, false, false
        .structSpriteEntry ( -17,  -39), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry ( -17,  -55), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   4,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   4,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   4,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record12
        ANIM_RECORD 11
        .structSpriteEntry (  17,   -7), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (  17,  -15), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  17,  -23), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry (  17,  -31), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   1,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -15,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   1,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -15,  -31), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record13
        ANIM_RECORD 12
        .structSpriteEntry (  17,   -7), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (  17,  -15), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  17,  -23), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry (  17,  -31), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   1,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -15,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   1,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -15,  -31), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record14
        ANIM_RECORD 13
        .structSpriteEntry ( -24,  -48), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry ( -16,  -16), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry ( -16,  -32), $21, SpriteLarge, $044, 2, 2, false, false
        .structSpriteEntry (   1,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -15,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   1,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -15,  -31), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record15
        ANIM_RECORD 14
        .structSpriteEntry ( -10,  -12), $21, SpriteLarge, $046, 2, 2, true, false
        .structSpriteEntry ( -10,  -28), $21, SpriteLarge, $044, 2, 2, true, false
        .structSpriteEntry (  -2,  -44), $21, SpriteLarge, $04A, 2, 2, true, false
        .structSpriteEntry (   5,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   5,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   5,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   5,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -11,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -11,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record16
        ANIM_RECORD 15
        .structSpriteEntry (  -9,  -14), $21, SpriteLarge, $046, 2, 2, true, false
        .structSpriteEntry (  -9,  -30), $21, SpriteLarge, $044, 2, 2, true, false
        .structSpriteEntry (  -1,  -46), $21, SpriteLarge, $04A, 2, 2, true, false
        .structSpriteEntry ( -11,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -11,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   5,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   5,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   5,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   5,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        ANIM_RECORD_END

      _Record17
        ANIM_RECORD 16
        .structSpriteEntry (  17,   -7), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (  17,  -15), $00, SpriteSmall, $009, 2, 0, false, false
        .structSpriteEntry (  17,  -23), $00, SpriteSmall, $00A, 2, 0, false, false
        .structSpriteEntry (  17,  -31), $00, SpriteSmall, $00B, 2, 0, false, false
        .structSpriteEntry (   1,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -15,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   1,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -15,  -31), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      aBattleAnimationFramesWarMageSword ; 98/B90E

        ; Frame table of entry 42: slices of the class sheet per frame.

        .word _Frame00 - aBattleAnimationFramesWarMageSword
        .word _Frame01 - aBattleAnimationFramesWarMageSword
        .word _Frame02 - aBattleAnimationFramesWarMageSword
        .word _Frame03 - aBattleAnimationFramesWarMageSword
        .word _Frame04 - aBattleAnimationFramesWarMageSword
        .word _Frame05 - aBattleAnimationFramesWarMageSword
        .word _Frame06 - aBattleAnimationFramesWarMageSword
        .word _Frame07 - aBattleAnimationFramesWarMageSword
        .word _Frame08 - aBattleAnimationFramesWarMageSword
        .word _Frame09 - aBattleAnimationFramesWarMageSword
        .word _Frame10 - aBattleAnimationFramesWarMageSword
        .word _Frame11 - aBattleAnimationFramesWarMageSword
        .word _Frame12 - aBattleAnimationFramesWarMageSword
        .word _Frame13 - aBattleAnimationFramesWarMageSword
        .word _Frame14 - aBattleAnimationFramesWarMageSword
        .word _Frame15 - aBattleAnimationFramesWarMageSword
        .word _Frame16 - aBattleAnimationFramesWarMageSword
        .word _Frame17 - aBattleAnimationFramesWarMageSword
        .word _Frame18 - aBattleAnimationFramesWarMageSword
        .word _Frame19 - aBattleAnimationFramesWarMageSword
        .word _Frame20 - aBattleAnimationFramesWarMageSword
        .word _Frame21 - aBattleAnimationFramesWarMageSword
        .word _Frame22 - aBattleAnimationFramesWarMageSword
        .word _Frame23 - aBattleAnimationFramesWarMageSword
        .word _Frame24 - aBattleAnimationFramesWarMageSword
        .word _Frame25 - aBattleAnimationFramesWarMageSword
        .word _Frame26 - aBattleAnimationFramesWarMageSword
        .word _Frame27 - aBattleAnimationFramesWarMageSword
        .word _Frame28 - aBattleAnimationFramesWarMageSword
        .word _Frame29 - aBattleAnimationFramesWarMageSword
        .word _Frame30 - aBattleAnimationFramesWarMageSword
        .word _Frame31 - aBattleAnimationFramesWarMageSword
        .word _Frame32 - aBattleAnimationFramesWarMageSword
        .word _Frame33 - aBattleAnimationFramesWarMageSword

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

      aBattleAnimationSequencesWarMageSword ; 98/BA84

        ; Sequence data of entry 42 of aBattleAnimationFrameTables, used by: WarMage (Sword),
        ; WarMageF (Sword). Frames: aBattleAnimationFramesWarMageSword.

        .word _Index - aBattleAnimationSequencesWarMageSword, _Records - aBattleAnimationSequencesWarMageSword

      _Index
        .word _Sequence00 - aBattleAnimationSequencesWarMageSword
        .word _Sequence01 - aBattleAnimationSequencesWarMageSword
        .word _Sequence02 - aBattleAnimationSequencesWarMageSword
        .word _Sequence03 - aBattleAnimationSequencesWarMageSword
        .word _Sequence04 - aBattleAnimationSequencesWarMageSword
        .word _Sequence05 - aBattleAnimationSequencesWarMageSword
        .word _Sequence06 - aBattleAnimationSequencesWarMageSword
        .word _Sequence07 - aBattleAnimationSequencesWarMageSword
        .word _Sequence08 - aBattleAnimationSequencesWarMageSword
        .word _Sequence09 - aBattleAnimationSequencesWarMageSword
        .word _Sequence10 - aBattleAnimationSequencesWarMageSword
        .word _Sequence11 - aBattleAnimationSequencesWarMageSword
        .word _Sequence12 - aBattleAnimationSequencesWarMageSword
        .word _Sequence13 - aBattleAnimationSequencesWarMageSword
        .word _Sequence14 - aBattleAnimationSequencesWarMageSword
        .word _Sequence15 - aBattleAnimationSequencesWarMageSword
        .word _Sequence16 - aBattleAnimationSequencesWarMageSword
        .word _Sequence17 - aBattleAnimationSequencesWarMageSword
        .word _Sequence18 - aBattleAnimationSequencesWarMageSword
        .word _Sequence19 - aBattleAnimationSequencesWarMageSword
        .word _Sequence20 - aBattleAnimationSequencesWarMageSword
        .word _Sequence21 - aBattleAnimationSequencesWarMageSword
        .word _Sequence22 - aBattleAnimationSequencesWarMageSword
        .word _Sequence23 - aBattleAnimationSequencesWarMageSword
        .word _Sequence24 - aBattleAnimationSequencesWarMageSword

      _Records
        .word _Record00 - aBattleAnimationSequencesWarMageSword
        .word _Record01 - aBattleAnimationSequencesWarMageSword
        .word _Record02 - aBattleAnimationSequencesWarMageSword
        .word _Record03 - aBattleAnimationSequencesWarMageSword
        .word _Record04 - aBattleAnimationSequencesWarMageSword
        .word _Record05 - aBattleAnimationSequencesWarMageSword
        .word _Record06 - aBattleAnimationSequencesWarMageSword
        .word _Record07 - aBattleAnimationSequencesWarMageSword
        .word _Record08 - aBattleAnimationSequencesWarMageSword
        .word _Record09 - aBattleAnimationSequencesWarMageSword
        .word _Record10 - aBattleAnimationSequencesWarMageSword
        .word _Record11 - aBattleAnimationSequencesWarMageSword
        .word _Record12 - aBattleAnimationSequencesWarMageSword
        .word _Record13 - aBattleAnimationSequencesWarMageSword
        .word _Record14 - aBattleAnimationSequencesWarMageSword
        .word _Record15 - aBattleAnimationSequencesWarMageSword
        .word _Record16 - aBattleAnimationSequencesWarMageSword
        .word _Record17 - aBattleAnimationSequencesWarMageSword
        .word _Record18 - aBattleAnimationSequencesWarMageSword
        .word _Record19 - aBattleAnimationSequencesWarMageSword
        .word _Record20 - aBattleAnimationSequencesWarMageSword
        .word _Record21 - aBattleAnimationSequencesWarMageSword
        .word _Record22 - aBattleAnimationSequencesWarMageSword
        .word _Record23 - aBattleAnimationSequencesWarMageSword
        .word _Record24 - aBattleAnimationSequencesWarMageSword
        .word _Record25 - aBattleAnimationSequencesWarMageSword
        .word _Record26 - aBattleAnimationSequencesWarMageSword
        .word _Record27 - aBattleAnimationSequencesWarMageSword
        .word _Record28 - aBattleAnimationSequencesWarMageSword
        .word _Record29 - aBattleAnimationSequencesWarMageSword
        .word _Record30 - aBattleAnimationSequencesWarMageSword
        .word _Record31 - aBattleAnimationSequencesWarMageSword
        .word _Record32 - aBattleAnimationSequencesWarMageSword
        .word _Record33 - aBattleAnimationSequencesWarMageSword
        .word _Record34 - aBattleAnimationSequencesWarMageSword
        .word _Record35 - aBattleAnimationSequencesWarMageSword
        .word _Record36 - aBattleAnimationSequencesWarMageSword
        .word _Record37 - aBattleAnimationSequencesWarMageSword
        .word _Record38 - aBattleAnimationSequencesWarMageSword
        .word _Record39 - aBattleAnimationSequencesWarMageSword
        .word _Record40 - aBattleAnimationSequencesWarMageSword
        .word _Record41 - aBattleAnimationSequencesWarMageSword
        .word _Record42 - aBattleAnimationSequencesWarMageSword
        .word _Record43 - aBattleAnimationSequencesWarMageSword
        .word _Record44 - aBattleAnimationSequencesWarMageSword
        .word _Record45 - aBattleAnimationSequencesWarMageSword
        .word _Record46 - aBattleAnimationSequencesWarMageSword
        .word _Record47 - aBattleAnimationSequencesWarMageSword

      _Sequence00
        ANIM_CLEAR_BUSY
        ANIM_STEP 1, 1
        ANIM_HOLD

      _Sequence01
        ANIM_STEP 1, 1
        ANIM_CMD_ED 0
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence02
        ANIM_STEP 9, 2
        ANIM_STEP 10, 3
        ANIM_STEP 11, 3
        ANIM_CMD_F1
        ANIM_SOUND 0
        ANIM_STEP 12, 3
        ANIM_STEP 13, 2
        ANIM_STEP 14, 4
        ANIM_STEP 15, 5
        ANIM_CMD_F3
        ANIM_STEP 16, 2
        ANIM_CLEAR_BUSY
        ANIM_CMD_ED 3
        ANIM_HOLD

      _Sequence03
        ANIM_STEP 16, 5
        ANIM_CMD_EE
        ANIM_STEP 16, 4
        ANIM_STEP 17, 2
        ANIM_STEP 18, 2
        ANIM_STEP 19, 2
        ANIM_STEP 20, 2
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence04
        ANIM_STEP 21, 2
        ANIM_STEP 22, 2
        ANIM_STEP 23, 2
        ANIM_CMD_F1
        ANIM_SOUND 1
        ANIM_STEP 24, 2
        ANIM_STEP 25, 3
        ANIM_STEP 26, 3
        ANIM_STEP 27, 3
        ANIM_STEP 28, 16
        ANIM_CMD_F3
        ANIM_CMD_ED 2
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence05
        ANIM_STEP 28, 1
        ANIM_CMD_EE
        ANIM_STEP 28, 2
        ANIM_STEP 29, 3
        ANIM_STEP 30, 3
        ANIM_SOUND 18
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence06
        ANIM_CLEAR_BUSY
        ANIM_SOUND 23
        ANIM_STEP 9, 24
        ANIM_STEP 46, 6
        ANIM_CMD_EE
        ANIM_STEP 46, 12
        ANIM_SOUND 24
        ANIM_STEP 10, 2
        ANIM_HOLD

      _Sequence07
        ANIM_STEP 1, 16
        ANIM_STEP 2, 16
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence08
        ANIM_STEP 1, 16
        ANIM_STEP 2, 16

      _Sequence09
        ANIM_STEP 1, 8
        ANIM_STEP 16, 4
        ANIM_STEP 17, 3
        ANIM_STEP 31, 4
        ANIM_STEP 31, 1
        ANIM_CMD_F4 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence10
        ANIM_CMD_E8
        ANIM_CLEAR_BUSY
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

      _Sequence11
        ANIM_STEP 33, 3
        ANIM_STEP 34, 4
        ANIM_STEP 35, 5
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence12
        ANIM_STEP 36, 5
        ANIM_STEP 37, 6
        ANIM_STEP 38, 1
        ANIM_SOUND 32
        ANIM_CMD_F0 3
        ANIM_STEP 38, 1
        ANIM_CMD_F4 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence13
        ANIM_STEP 39, 1
        ANIM_CMD_F4 1
        ANIM_STEP 36, 5
        ANIM_STEP 1, 5
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence14
        ANIM_SOUND 18
        ANIM_STEP 40, 8
        ANIM_STEP 41, 6
        ANIM_STEP 36, 1
        ANIM_CMD_F4 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence15
        ANIM_SOUND 23
        ANIM_STEP 40, 5
        ANIM_STEP 41, 6
        ANIM_STEP 42, 9
        ANIM_STEP 43, 3
        ANIM_STEP 44, 4
        ANIM_STEP 45, 6
        ANIM_STEP 46, 6
        ANIM_SOUND 24
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence16
        ANIM_STEP 10, 2
        ANIM_CMD_F1
        ANIM_SOUND 0
        ANIM_STEP 11, 3
        ANIM_STEP 12, 3
        ANIM_STEP 13, 2
        ANIM_STEP 14, 4
        ANIM_STEP 15, 5
        ANIM_CMD_F3
        ANIM_STEP 16, 2
        ANIM_CLEAR_BUSY
        ANIM_CMD_ED 3
        ANIM_HOLD

      _Sequence17
        ANIM_CLEAR_BUSY
        ANIM_CMD_EC 1
        ANIM_CMD_EE
        ANIM_STEP 47, 2
        ANIM_STEP 47, 2
        ANIM_STEP 47, 2
        ANIM_STEP 47, 2
        ANIM_STEP 47, 2
        ANIM_STEP 47, 2
        ANIM_STEP 47, 2
        ANIM_STEP 47, 2
        ANIM_STEP 47, 2
        ANIM_STEP 47, 2
        ANIM_CMD_EC 0
        ANIM_HOLD

      _Sequence18
        ANIM_STEP 9, 3
        ANIM_CMD_EE
        ANIM_STEP 9, 8
        ANIM_SOUND 18
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence19
        ANIM_STEP 33, 4
        ANIM_STEP 34, 1
        ANIM_CMD_EE
        ANIM_STEP 34, 4
        ANIM_STEP 35, 6
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence20
        ANIM_CLEAR_BUSY
        ANIM_CMD_EC 1
        ANIM_STEP 47, 2
        ANIM_STEP 47, 2
        ANIM_STEP 47, 2
        ANIM_STEP 47, 2
        ANIM_STEP 47, 2
        ANIM_STEP 47, 2
        ANIM_HOLD

      _Sequence21
        ANIM_STEP 20, 2
        ANIM_STEP 21, 2
        ANIM_STEP 22, 2
        ANIM_SOUND 0
        ANIM_STEP 23, 2
        ANIM_STEP 24, 2
        ANIM_STEP 10, 2
        ANIM_STEP 11, 2
        ANIM_SOUND 0
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
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence22
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
        ANIM_STEP 47, 16
        ANIM_STEP 31, 4
        ANIM_STEP 1, 2
        ANIM_CMD_F3
        ANIM_CMD_EC 0
        ANIM_HOLD

      _Sequence23
        ANIM_CLEAR_BUSY
        ANIM_STEP 36, 5
        ANIM_HOLD

      _Sequence24
        ANIM_CLEAR_BUSY
        ANIM_STEP 33, 4
        ANIM_STEP 34, 4
        ANIM_STEP 35, 4
        ANIM_STEP 1, 4
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

      aBattleAnimationFramesCavalierSword ; 98/C659

        ; Frame table of entries 12, 15, 17: slices of the class sheet per frame.

        .word _Frame00 - aBattleAnimationFramesCavalierSword
        .word _Frame01 - aBattleAnimationFramesCavalierSword
        .word _Frame02 - aBattleAnimationFramesCavalierSword
        .word _Frame03 - aBattleAnimationFramesCavalierSword
        .word _Frame04 - aBattleAnimationFramesCavalierSword
        .word _Frame05 - aBattleAnimationFramesCavalierSword
        .word _Frame06 - aBattleAnimationFramesCavalierSword
        .word _Frame07 - aBattleAnimationFramesCavalierSword
        .word _Frame08 - aBattleAnimationFramesCavalierSword
        .word _Frame09 - aBattleAnimationFramesCavalierSword
        .word _Frame10 - aBattleAnimationFramesCavalierSword
        .word _Frame11 - aBattleAnimationFramesCavalierSword

      _Frame00
        ANIM_TILES
        ANIM_TILE_ROW $0000, $03A0
        ANIM_TILES_END

      _Frame01
        ANIM_TILES
        ANIM_TILE_ROW $03A0, $0420
        ANIM_TILES_END

      _Frame02
        ANIM_TILES
        ANIM_TILE_ROW $07C0, $03A0
        ANIM_TILES_END

      _Frame03
        ANIM_TILES
        ANIM_TILE_ROW $0B60, $03A0
        ANIM_TILES_END

      _Frame04
        ANIM_TILES
        ANIM_TILE_ROW $0F00, $0380
        ANIM_TILES_END

      _Frame05
        ANIM_TILES
        ANIM_TILE_ROW $1280, $0380
        ANIM_TILES_END

      _Frame06
        ANIM_TILES
        ANIM_TILE_ROW $1600, $01E0
        ANIM_TILE_ROW $17E0, $0100
        ANIM_TILES_END

      _Frame07
        ANIM_TILES
        ANIM_TILE_ROW $18E0, $01C0
        ANIM_TILE_ROW $1AA0, $0100
        ANIM_TILES_END

      _Frame08
        ANIM_TILES
        ANIM_TILE_ROW $1BA0, $01E0
        ANIM_TILE_ROW $1D80, $0100
        ANIM_TILES_END

      _Frame09
        ANIM_TILES
        ANIM_TILE_ROW $1E80, $01A0
        ANIM_TILE_ROW $2020, $0080
        ANIM_TILES_END

      _Frame10
        ANIM_TILES
        ANIM_TILE_ROW $20A0, $0160
        ANIM_TILE_ROW $2200, $0080
        ANIM_TILES_END

      _Frame11
        ANIM_TILES
        ANIM_TILE_ROW $2280, $01A0
        ANIM_TILE_ROW $2420, $0040
        ANIM_TILES_END

      aBattleAnimationSequencesCavalierSword ; 98/C6C5

        ; Sequence data of entry 12 of aBattleAnimationFrameTables, used by: Cavalier (Sword),
        ; AxeKnight (Axe), FreeKnight (Sword), Troubadour (Sword). Frames:
        ; aBattleAnimationFramesCavalierSword.

        .word _Index - aBattleAnimationSequencesCavalierSword, _Records - aBattleAnimationSequencesCavalierSword

      _Index
        .word _Sequence00 - aBattleAnimationSequencesCavalierSword
        .word _Sequence01 - aBattleAnimationSequencesCavalierSword
        .word _Sequence02 - aBattleAnimationSequencesCavalierSword
        .word _Sequence03 - aBattleAnimationSequencesCavalierSword
        .word _Sequence04 - aBattleAnimationSequencesCavalierSword
        .word _Sequence05 - aBattleAnimationSequencesCavalierSword
        .word _Sequence06 - aBattleAnimationSequencesCavalierSword
        .word _Sequence07 - aBattleAnimationSequencesCavalierSword
        .word _Sequence08 - aBattleAnimationSequencesCavalierSword
        .word _Sequence09 - aBattleAnimationSequencesCavalierSword
        .word _Sequence10 - aBattleAnimationSequencesCavalierSword
        .word _Sequence11 - aBattleAnimationSequencesCavalierSword
        .word _Sequence12 - aBattleAnimationSequencesCavalierSword
        .word _Sequence13 - aBattleAnimationSequencesCavalierSword

      _Records
        .word aBattleAnimationSequencesTroubadourStaff._Record00 - aBattleAnimationSequencesCavalierSword
        .word aBattleAnimationSequencesTroubadourStaff._Record01 - aBattleAnimationSequencesCavalierSword
        .word aBattleAnimationSequencesTroubadourStaff._Record02 - aBattleAnimationSequencesCavalierSword
        .word aBattleAnimationSequencesTroubadourStaff._Record03 - aBattleAnimationSequencesCavalierSword
        .word aBattleAnimationSequencesTroubadourStaff._Record04 - aBattleAnimationSequencesCavalierSword
        .word aBattleAnimationSequencesTroubadourStaff._Record05 - aBattleAnimationSequencesCavalierSword
        .word aBattleAnimationSequencesTroubadourStaff._Record06 - aBattleAnimationSequencesCavalierSword
        .word aBattleAnimationSequencesTroubadourStaff._Record07 - aBattleAnimationSequencesCavalierSword
        .word aBattleAnimationSequencesTroubadourStaff._Record08 - aBattleAnimationSequencesCavalierSword
        .word aBattleAnimationSequencesTroubadourStaff._Record09 - aBattleAnimationSequencesCavalierSword
        .word aBattleAnimationSequencesTroubadourStaff._Record10 - aBattleAnimationSequencesCavalierSword
        .word aBattleAnimationSequencesTroubadourStaff._Record11 - aBattleAnimationSequencesCavalierSword
        .word aBattleAnimationSequencesTroubadourStaff._Record12 - aBattleAnimationSequencesCavalierSword
        .word aBattleAnimationSequencesTroubadourStaff._Record13 - aBattleAnimationSequencesCavalierSword
        .word aBattleAnimationSequencesTroubadourStaff._Record14 - aBattleAnimationSequencesCavalierSword
        .word aBattleAnimationSequencesTroubadourStaff._Record15 - aBattleAnimationSequencesCavalierSword
        .word aBattleAnimationSequencesTroubadourStaff._Record16 - aBattleAnimationSequencesCavalierSword
        .word aBattleAnimationSequencesTroubadourStaff._Record17 - aBattleAnimationSequencesCavalierSword
        .word aBattleAnimationSequencesTroubadourStaff._Record18 - aBattleAnimationSequencesCavalierSword
        .word aBattleAnimationSequencesTroubadourStaff._Record19 - aBattleAnimationSequencesCavalierSword
        .word aBattleAnimationSequencesTroubadourStaff._Record20 - aBattleAnimationSequencesCavalierSword
        .word aBattleAnimationSequencesTroubadourStaff._Record21 - aBattleAnimationSequencesCavalierSword
        .word aBattleAnimationSequencesTroubadourStaff._Record22 - aBattleAnimationSequencesCavalierSword
        .word aBattleAnimationSequencesTroubadourStaff._Record23 - aBattleAnimationSequencesCavalierSword
        .word aBattleAnimationSequencesTroubadourStaff._Record24 - aBattleAnimationSequencesCavalierSword
        .word aBattleAnimationSequencesTroubadourStaff._Record25 - aBattleAnimationSequencesCavalierSword
        .word aBattleAnimationSequencesTroubadourStaff._Record26 - aBattleAnimationSequencesCavalierSword
        .word aBattleAnimationSequencesTroubadourStaff._Record27 - aBattleAnimationSequencesCavalierSword
        .word aBattleAnimationSequencesTroubadourStaff._Record28 - aBattleAnimationSequencesCavalierSword
        .word aBattleAnimationSequencesTroubadourStaff._Record29 - aBattleAnimationSequencesCavalierSword

      _Sequence00
        ANIM_CLEAR_BUSY
        ANIM_STEP 7, 1
        ANIM_HOLD

      _Sequence01
        ANIM_CLEAR_BUSY
        ANIM_CMD_EB
        ANIM_SOUND 19
        ANIM_STEP 2, 6
        ANIM_STEP 3, 6
        ANIM_STEP 4, 6
        ANIM_STEP 5, 6
        ANIM_STEP 6, 6
        ANIM_RESTART
        ANIM_HOLD

      _Sequence02
        ANIM_STEP 10, 5
        ANIM_STEP 11, 5
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence03
        ANIM_SOUND 19
        ANIM_STEP 21, 3
        ANIM_STEP 10, 4
        ANIM_STEP 9, 7
        ANIM_STEP 8, 7
        ANIM_STEP 7, 1
        ANIM_CMD_F4 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence04
        ANIM_SOUND 19
        ANIM_STEP 8, 7
        ANIM_STEP 9, 4
        ANIM_STEP 8, 7
        ANIM_STEP 7, 1
        ANIM_CMD_F4 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence05
        ANIM_STEP 11, 3
        ANIM_STEP 12, 4
        ANIM_STEP 13, 3
        ANIM_STEP 14, 6
        ANIM_STEP 19, 20
        ANIM_SOUND 0
        ANIM_STEP 19, 2
        ANIM_CMD_EE
        ANIM_STEP 17, 2
        ANIM_SOUND 0
        ANIM_STEP 18, 2
        ANIM_STEP 16, 2
        ANIM_STEP 15, 2
        ANIM_SOUND 0
        ANIM_STEP 17, 2
        ANIM_STEP 18, 2
        ANIM_SOUND 0
        ANIM_STEP 16, 2
        ANIM_STEP 15, 2
        ANIM_SOUND 0
        ANIM_STEP 17, 2
        ANIM_CMD_F1
        ANIM_STEP 18, 2
        ANIM_STEP 16, 16
        ANIM_CMD_F3
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence06
        ANIM_CLEAR_BUSY
        ANIM_STEP 11, 5
        ANIM_STEP 12, 5
        ANIM_STEP 13, 6
        ANIM_STEP 14, 4
        ANIM_STEP 19, 1
        ANIM_SOUND 32
        ANIM_CMD_F0 3
        ANIM_STEP 19, 1
        ANIM_CMD_F4 1
        ANIM_STEP 20, 1
        ANIM_CMD_F4 1
        ANIM_STEP 12, 4
        ANIM_STEP 11, 5
        ANIM_HOLD

      _Sequence07
        ANIM_STEP 11, 3
        ANIM_STEP 12, 2
        ANIM_STEP 13, 3
        ANIM_STEP 14, 3
        ANIM_STEP 15, 7
        ANIM_CMD_EE
        ANIM_STEP 15, 10
        ANIM_SOUND 0
        ANIM_STEP 17, 2
        ANIM_STEP 18, 2
        ANIM_CMD_F1
        ANIM_STEP 16, 16
        ANIM_CMD_F3
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence08
        ANIM_STEP 21, 3
        ANIM_STEP 10, 6
        ANIM_STEP 9, 5
        ANIM_STEP 8, 6
        ANIM_STEP 7, 5
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence09
        ANIM_CLEAR_BUSY
        ANIM_STEP 11, 5
        ANIM_HOLD

      _Sequence10
        ANIM_SOUND 19
        ANIM_STEP 7, 5
        ANIM_STEP 8, 5
        ANIM_STEP 9, 5
        ANIM_STEP 10, 5
        ANIM_STEP 11, 2
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence11
        ANIM_STEP 10, 5
        ANIM_STEP 11, 4
        ANIM_STEP 11, 1
        ANIM_CMD_F4 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence12
        ANIM_STEP 21, 3
        ANIM_STEP 10, 6
        ANIM_STEP 9, 5
        ANIM_STEP 8, 6
        ANIM_STEP 7, 1
        ANIM_CMD_ED 0
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence13
        ANIM_CLEAR_BUSY
        ANIM_CMD_EB
        ANIM_SOUND 19
        ANIM_STEP 2, 7
        ANIM_STEP 3, 7
        ANIM_STEP 4, 7
        ANIM_STEP 5, 7
        ANIM_STEP 6, 7
        ANIM_RESTART
        ANIM_HOLD

      aBattleAnimationSequencesAxeKnightRangedAxe ; 98/C82B

        ; Sequence data of entry 15 of aBattleAnimationFrameTables, used by: AxeKnight
        ; (RangedAxe). Frames: aBattleAnimationFramesCavalierSword.

        .word _Index - aBattleAnimationSequencesAxeKnightRangedAxe, _Records - aBattleAnimationSequencesAxeKnightRangedAxe

      _Index
        .word _Sequence00 - aBattleAnimationSequencesAxeKnightRangedAxe
        .word _Sequence01 - aBattleAnimationSequencesAxeKnightRangedAxe
        .word _Sequence02 - aBattleAnimationSequencesAxeKnightRangedAxe
        .word _Sequence03 - aBattleAnimationSequencesAxeKnightRangedAxe
        .word _Sequence04 - aBattleAnimationSequencesAxeKnightRangedAxe
        .word _Sequence05 - aBattleAnimationSequencesAxeKnightRangedAxe
        .word _Sequence06 - aBattleAnimationSequencesAxeKnightRangedAxe
        .word _Sequence07 - aBattleAnimationSequencesAxeKnightRangedAxe
        .word _Sequence08 - aBattleAnimationSequencesAxeKnightRangedAxe
        .word _Sequence09 - aBattleAnimationSequencesAxeKnightRangedAxe
        .word _Sequence10 - aBattleAnimationSequencesAxeKnightRangedAxe
        .word _Sequence11 - aBattleAnimationSequencesAxeKnightRangedAxe
        .word _Sequence12 - aBattleAnimationSequencesAxeKnightRangedAxe
        .word _Sequence13 - aBattleAnimationSequencesAxeKnightRangedAxe
        .word _Sequence14 - aBattleAnimationSequencesAxeKnightRangedAxe

      _Records
        .word aBattleAnimationSequencesTroubadourStaff._Record00 - aBattleAnimationSequencesAxeKnightRangedAxe
        .word aBattleAnimationSequencesTroubadourStaff._Record01 - aBattleAnimationSequencesAxeKnightRangedAxe
        .word aBattleAnimationSequencesTroubadourStaff._Record02 - aBattleAnimationSequencesAxeKnightRangedAxe
        .word aBattleAnimationSequencesTroubadourStaff._Record03 - aBattleAnimationSequencesAxeKnightRangedAxe
        .word aBattleAnimationSequencesTroubadourStaff._Record04 - aBattleAnimationSequencesAxeKnightRangedAxe
        .word aBattleAnimationSequencesTroubadourStaff._Record05 - aBattleAnimationSequencesAxeKnightRangedAxe
        .word aBattleAnimationSequencesTroubadourStaff._Record06 - aBattleAnimationSequencesAxeKnightRangedAxe
        .word aBattleAnimationSequencesTroubadourStaff._Record07 - aBattleAnimationSequencesAxeKnightRangedAxe
        .word aBattleAnimationSequencesTroubadourStaff._Record08 - aBattleAnimationSequencesAxeKnightRangedAxe
        .word aBattleAnimationSequencesTroubadourStaff._Record09 - aBattleAnimationSequencesAxeKnightRangedAxe
        .word aBattleAnimationSequencesTroubadourStaff._Record10 - aBattleAnimationSequencesAxeKnightRangedAxe
        .word aBattleAnimationSequencesTroubadourStaff._Record11 - aBattleAnimationSequencesAxeKnightRangedAxe
        .word aBattleAnimationSequencesTroubadourStaff._Record12 - aBattleAnimationSequencesAxeKnightRangedAxe
        .word aBattleAnimationSequencesTroubadourStaff._Record13 - aBattleAnimationSequencesAxeKnightRangedAxe
        .word aBattleAnimationSequencesTroubadourStaff._Record14 - aBattleAnimationSequencesAxeKnightRangedAxe
        .word aBattleAnimationSequencesTroubadourStaff._Record15 - aBattleAnimationSequencesAxeKnightRangedAxe
        .word aBattleAnimationSequencesTroubadourStaff._Record16 - aBattleAnimationSequencesAxeKnightRangedAxe
        .word aBattleAnimationSequencesTroubadourStaff._Record17 - aBattleAnimationSequencesAxeKnightRangedAxe
        .word aBattleAnimationSequencesTroubadourStaff._Record18 - aBattleAnimationSequencesAxeKnightRangedAxe
        .word aBattleAnimationSequencesTroubadourStaff._Record19 - aBattleAnimationSequencesAxeKnightRangedAxe
        .word aBattleAnimationSequencesTroubadourStaff._Record20 - aBattleAnimationSequencesAxeKnightRangedAxe
        .word aBattleAnimationSequencesTroubadourStaff._Record21 - aBattleAnimationSequencesAxeKnightRangedAxe
        .word aBattleAnimationSequencesTroubadourStaff._Record22 - aBattleAnimationSequencesAxeKnightRangedAxe
        .word aBattleAnimationSequencesTroubadourStaff._Record23 - aBattleAnimationSequencesAxeKnightRangedAxe
        .word aBattleAnimationSequencesTroubadourStaff._Record24 - aBattleAnimationSequencesAxeKnightRangedAxe
        .word aBattleAnimationSequencesTroubadourStaff._Record25 - aBattleAnimationSequencesAxeKnightRangedAxe
        .word aBattleAnimationSequencesTroubadourStaff._Record26 - aBattleAnimationSequencesAxeKnightRangedAxe
        .word aBattleAnimationSequencesTroubadourStaff._Record27 - aBattleAnimationSequencesAxeKnightRangedAxe
        .word aBattleAnimationSequencesTroubadourStaff._Record28 - aBattleAnimationSequencesAxeKnightRangedAxe
        .word aBattleAnimationSequencesTroubadourStaff._Record29 - aBattleAnimationSequencesAxeKnightRangedAxe

      _Sequence00
        ANIM_STEP 7, 2
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence01
        ANIM_STEP 2, 7
        ANIM_STEP 3, 7
        ANIM_STEP 4, 7
        ANIM_STEP 5, 7
        ANIM_STEP 6, 7
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence02
        ANIM_STEP 11, 2
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence03
        ANIM_STEP 0, 16
        ANIM_STEP 13, 4
        ANIM_STEP 14, 22
        ANIM_STEP 6, 1
        ANIM_STEP 7, 1
        ANIM_STEP 5, 80
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence04
        ANIM_STEP 7, 16
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence05
        ANIM_SOUND 19
        ANIM_STEP 7, 5
        ANIM_STEP 8, 7
        ANIM_STEP 9, 7
        ANIM_STEP 8, 6
        ANIM_STEP 7, 1
        ANIM_CMD_F4 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence06
        ANIM_STEP 11, 32
        ANIM_STEP 12, 5
        ANIM_STEP 13, 6
        ANIM_STEP 14, 4
        ANIM_STEP 19, 35
        ANIM_STEP 17, 3
        ANIM_STEP 18, 2
        ANIM_STEP 16, 10
        ANIM_STEP 15, 9
        ANIM_STEP 17, 3
        ANIM_STEP 18, 2
        ANIM_STEP 16, 10
        ANIM_STEP 15, 9
        ANIM_STEP 17, 3
        ANIM_STEP 18, 2
        ANIM_STEP 16, 10
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence07
        ANIM_STEP 11, 32
        ANIM_STEP 12, 5
        ANIM_STEP 13, 6
        ANIM_STEP 14, 4
        ANIM_STEP 19, 35
        ANIM_STEP 20, 48
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence08
        ANIM_STEP 11, 32
        ANIM_STEP 12, 3
        ANIM_STEP 13, 3
        ANIM_STEP 14, 2
        ANIM_STEP 15, 32
        ANIM_STEP 17, 3
        ANIM_STEP 18, 2
        ANIM_STEP 16, 32
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence09
        ANIM_CLEAR_BUSY
        ANIM_STEP 11, 2
        ANIM_STEP 21, 3
        ANIM_STEP 10, 6
        ANIM_STEP 9, 5
        ANIM_STEP 8, 6
        ANIM_STEP 7, 5
        ANIM_HOLD

      _Sequence10
        ANIM_CMD_EB
        ANIM_STEP 23, 2
        ANIM_STEP 24, 2
        ANIM_STEP 25, 2
        ANIM_STEP 26, 2
        ANIM_STEP 27, 2
        ANIM_STEP 28, 2
        ANIM_STEP 29, 2
        ANIM_RESTART
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence11
        ANIM_CLEAR_BUSY
        ANIM_STEP 11, 3
        ANIM_STEP 12, 3
        ANIM_STEP 13, 4
        ANIM_STEP 14, 4
        ANIM_STEP 19, 19
        ANIM_CMD_EE
        ANIM_CMD_EF 138
        ANIM_SOUND 12
        ANIM_STEP 22, 1
        ANIM_CMD_F4 1
        ANIM_STEP 14, 2
        ANIM_STEP 19, 18
        ANIM_STEP 13, 6
        ANIM_STEP 12, 4
        ANIM_STEP 11, 5
        ANIM_HOLD

      _Sequence12
        ANIM_STEP 0, 16
        ANIM_STEP 19, 4
        ANIM_STEP 20, 22
        ANIM_STEP 12, 1
        ANIM_STEP 13, 1
        ANIM_STEP 11, 80
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence13
        ANIM_CLEAR_BUSY
        ANIM_SOUND 19
        ANIM_STEP 7, 5
        ANIM_STEP 8, 5
        ANIM_STEP 9, 5
        ANIM_STEP 10, 5
        ANIM_STEP 11, 3
        ANIM_HOLD

      _Sequence14
        ANIM_SOUND 19
        ANIM_STEP 21, 3
        ANIM_STEP 10, 4
        ANIM_STEP 9, 7
        ANIM_STEP 8, 7
        ANIM_STEP 7, 1
        ANIM_CMD_F4 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      aBattleAnimationSequencesTroubadourStaff ; 98/C98D

        ; Sequence data of entry 17 of aBattleAnimationFrameTables, used by: Troubadour (Staff).
        ; Frames: aBattleAnimationFramesCavalierSword.

        .word _Index - aBattleAnimationSequencesTroubadourStaff, _Records - aBattleAnimationSequencesTroubadourStaff

      _Index
        .word _Sequence00 - aBattleAnimationSequencesTroubadourStaff
        .word _Sequence01 - aBattleAnimationSequencesTroubadourStaff
        .word _Sequence02 - aBattleAnimationSequencesTroubadourStaff
        .word _Sequence03 - aBattleAnimationSequencesTroubadourStaff
        .word _Sequence04 - aBattleAnimationSequencesTroubadourStaff
        .word _Sequence05 - aBattleAnimationSequencesTroubadourStaff
        .word _Sequence06 - aBattleAnimationSequencesTroubadourStaff
        .word _Sequence07 - aBattleAnimationSequencesTroubadourStaff
        .word _Sequence08 - aBattleAnimationSequencesTroubadourStaff
        .word _Sequence09 - aBattleAnimationSequencesTroubadourStaff
        .word _Sequence10 - aBattleAnimationSequencesTroubadourStaff
        .word _Sequence11 - aBattleAnimationSequencesTroubadourStaff
        .word _Sequence12 - aBattleAnimationSequencesTroubadourStaff

      _Records
        .word _Record00 - aBattleAnimationSequencesTroubadourStaff
        .word _Record01 - aBattleAnimationSequencesTroubadourStaff
        .word _Record02 - aBattleAnimationSequencesTroubadourStaff
        .word _Record03 - aBattleAnimationSequencesTroubadourStaff
        .word _Record04 - aBattleAnimationSequencesTroubadourStaff
        .word _Record05 - aBattleAnimationSequencesTroubadourStaff
        .word _Record06 - aBattleAnimationSequencesTroubadourStaff
        .word _Record07 - aBattleAnimationSequencesTroubadourStaff
        .word _Record08 - aBattleAnimationSequencesTroubadourStaff
        .word _Record09 - aBattleAnimationSequencesTroubadourStaff
        .word _Record10 - aBattleAnimationSequencesTroubadourStaff
        .word _Record11 - aBattleAnimationSequencesTroubadourStaff
        .word _Record12 - aBattleAnimationSequencesTroubadourStaff
        .word _Record13 - aBattleAnimationSequencesTroubadourStaff
        .word _Record14 - aBattleAnimationSequencesTroubadourStaff
        .word _Record15 - aBattleAnimationSequencesTroubadourStaff
        .word _Record16 - aBattleAnimationSequencesTroubadourStaff
        .word _Record17 - aBattleAnimationSequencesTroubadourStaff
        .word _Record18 - aBattleAnimationSequencesTroubadourStaff
        .word _Record19 - aBattleAnimationSequencesTroubadourStaff
        .word _Record20 - aBattleAnimationSequencesTroubadourStaff
        .word _Record21 - aBattleAnimationSequencesTroubadourStaff
        .word _Record22 - aBattleAnimationSequencesTroubadourStaff
        .word _Record23 - aBattleAnimationSequencesTroubadourStaff
        .word _Record24 - aBattleAnimationSequencesTroubadourStaff
        .word _Record25 - aBattleAnimationSequencesTroubadourStaff
        .word _Record26 - aBattleAnimationSequencesTroubadourStaff
        .word _Record27 - aBattleAnimationSequencesTroubadourStaff
        .word _Record28 - aBattleAnimationSequencesTroubadourStaff
        .word _Record29 - aBattleAnimationSequencesTroubadourStaff

      _Sequence00
        ANIM_CLEAR_BUSY
        ANIM_STEP 7, 16
        ANIM_HOLD

      _Sequence01
        ANIM_SOUND 19
        ANIM_STEP 8, 7
        ANIM_STEP 9, 8
        ANIM_STEP 8, 7
        ANIM_STEP 7, 1
        ANIM_CMD_F4 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence02
        ANIM_STEP 1, 16

      _Sequence03
        ANIM_STEP 0, 16
        ANIM_STEP 13, 4
        ANIM_STEP 14, 22
        ANIM_STEP 6, 1
        ANIM_STEP 7, 1
        ANIM_STEP 5, 80
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence04
        ANIM_STEP 7, 16

      _Sequence05
        ANIM_SOUND 19
        ANIM_STEP 8, 5
        ANIM_STEP 9, 5
        ANIM_STEP 10, 5
        ANIM_STEP 11, 5
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence06
        ANIM_STEP 11, 32
        ANIM_STEP 12, 5
        ANIM_STEP 13, 6
        ANIM_STEP 14, 4
        ANIM_STEP 19, 35
        ANIM_STEP 17, 3
        ANIM_STEP 18, 2
        ANIM_STEP 16, 10
        ANIM_STEP 15, 9
        ANIM_STEP 17, 3
        ANIM_STEP 18, 2
        ANIM_STEP 16, 10
        ANIM_STEP 15, 9
        ANIM_STEP 17, 3
        ANIM_STEP 18, 2
        ANIM_STEP 16, 10

      _Sequence07
        ANIM_STEP 12, 5
        ANIM_STEP 13, 6
        ANIM_STEP 14, 4
        ANIM_STEP 19, 34
        ANIM_SOUND 32
        ANIM_CMD_F0
        ANIM_STEP 19, 1
        ANIM_CMD_F4 1
        ANIM_STEP 20, 1
        ANIM_CMD_F4 1
        ANIM_STEP 19, 9
        ANIM_STEP 13, 4
        ANIM_STEP 12, 6
        ANIM_STEP 11, 5
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence08
        ANIM_STEP 11, 32
        ANIM_STEP 12, 3
        ANIM_STEP 13, 3
        ANIM_STEP 14, 2
        ANIM_STEP 15, 32
        ANIM_STEP 17, 3
        ANIM_STEP 18, 2
        ANIM_STEP 16, 32

      _Sequence09
        ANIM_SOUND 19
        ANIM_STEP 21, 3
        ANIM_STEP 10, 4
        ANIM_STEP 9, 7
        ANIM_STEP 8, 7
        ANIM_STEP 7, 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence10
        ANIM_STEP 23, 2
        ANIM_STEP 24, 2
        ANIM_STEP 25, 2
        ANIM_STEP 26, 2
        ANIM_STEP 27, 2
        ANIM_STEP 28, 2
        ANIM_STEP 29, 2

      _Sequence11
        ANIM_STEP 11, 32
        ANIM_STEP 12, 5
        ANIM_STEP 13, 6
        ANIM_STEP 14, 4
        ANIM_STEP 19, 35
        ANIM_STEP 22, 48
        ANIM_STEP 19, 48
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence12
        ANIM_STEP 0, 16
        ANIM_STEP 19, 4
        ANIM_STEP 20, 22
        ANIM_STEP 12, 1
        ANIM_STEP 13, 1
        ANIM_STEP 11, 80
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Record00
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (   4,   -1), $00, SpriteSmall, $0F2, 2, 3, false, false
        .structSpriteEntry (  -4,   -1), $00, SpriteSmall, $0F1, 2, 3, false, false
        .structSpriteEntry (  20,   -1), $00, SpriteSmall, $0F3, 2, 3, false, false
        .structSpriteEntry (  12,   -1), $00, SpriteSmall, $0F2, 2, 3, false, false
        .structSpriteEntry ( -12,   -1), $00, SpriteSmall, $0F1, 2, 3, false, false
        .structSpriteEntry ( -20,   -1), $00, SpriteSmall, $0F1, 2, 3, false, false
        .structSpriteEntry ( -28,   -1), $00, SpriteSmall, $0F0, 2, 3, false, false
        ANIM_RECORD_END

      _Record01
        ANIM_RECORD 0
        .structSpriteEntry ( -24,  -47), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   5,  -26), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   0,  -42), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  -3,  -34), $21, SpriteLarge, $0A4, 2, 0, false, false
        .structSpriteEntry (  -4,  -50), $21, SpriteLarge, $084, 2, 0, false, false
        .structSpriteEntry (   0,  -39), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry (  16,   -7), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry (  16,  -15), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (  16,  -23), $00, SpriteSmall, $00B, 2, 1, false, false
        .structSpriteEntry (  16,  -31), $00, SpriteSmall, $00C, 2, 1, false, false
        .structSpriteEntry (   0,  -15), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (   0,  -31), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry (  -8,  -23), $00, SpriteSmall, $00D, 2, 1, false, false
        .structSpriteEntry (  -8,  -31), $00, SpriteSmall, $00E, 2, 1, false, false
        .structSpriteEntry (  -8,  -39), $00, SpriteSmall, $00F, 2, 1, false, false
        .structSpriteEntry (  -8,  -47), $00, SpriteSmall, $018, 2, 1, false, false
        .structSpriteEntry (  -8,  -15), $00, SpriteSmall, $019, 2, 1, false, false
        .structSpriteEntry ( -16,  -15), $00, SpriteSmall, $01A, 2, 1, false, false
        .structSpriteEntry ( -24,  -15), $00, SpriteSmall, $01B, 2, 1, false, false
        .structSpriteEntry ( -24,  -31), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -16,  -45), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry ( -16,  -61), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry (   8,  -39), $00, SpriteSmall, $01C, 2, 5, false, false
        ANIM_RECORD_END

      _Record02
        ANIM_RECORD 1
        .structSpriteEntry (   2,  -28), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  -3,  -44), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  -6,  -36), $21, SpriteLarge, $0A4, 2, 0, false, false
        .structSpriteEntry (  -7,  -52), $21, SpriteLarge, $084, 2, 0, false, false
        .structSpriteEntry (  23,   -8), $00, SpriteSmall, $00C, 2, 1, false, false
        .structSpriteEntry (  23,  -16), $00, SpriteSmall, $00D, 2, 1, false, false
        .structSpriteEntry (  23,  -24), $00, SpriteSmall, $00E, 2, 1, false, false
        .structSpriteEntry (  23,  -32), $00, SpriteSmall, $00F, 2, 1, false, false
        .structSpriteEntry (   7,  -16), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   7,  -32), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  -9,    0), $00, SpriteSmall, $01C, 2, 1, false, false
        .structSpriteEntry ( -17,    0), $00, SpriteSmall, $01D, 2, 1, false, false
        .structSpriteEntry (  -9,   -8), $00, SpriteSmall, $01E, 2, 1, false, false
        .structSpriteEntry ( -17,   -8), $00, SpriteSmall, $01F, 2, 1, false, false
        .structSpriteEntry ( -25,   -8), $00, SpriteSmall, $020, 2, 1, false, false
        .structSpriteEntry (  -9,  -24), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -25,  -24), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry (  -9,  -40), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry ( -25,  -40), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry ( -18,  -48), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry ( -18,  -64), $21, SpriteLarge, $048, 2, 2, false, false
        ANIM_RECORD_END

      _Record03
        ANIM_RECORD 2
        .structSpriteEntry ( -19,  -48), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry ( -19,  -64), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry (   1,  -28), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  -4,  -44), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  -7,  -36), $21, SpriteLarge, $0A4, 2, 0, false, false
        .structSpriteEntry (  -8,  -52), $21, SpriteLarge, $084, 2, 0, false, false
        .structSpriteEntry (  22,  -23), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry (  22,  -31), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -26,  -23), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry ( -26,  -31), $00, SpriteSmall, $00B, 2, 1, false, false
        .structSpriteEntry ( -26,  -39), $00, SpriteSmall, $00C, 2, 1, false, false
        .structSpriteEntry ( -10,    1), $00, SpriteSmall, $00D, 2, 1, false, false
        .structSpriteEntry (   6,   -7), $00, SpriteSmall, $00E, 2, 1, false, false
        .structSpriteEntry (  -2,   -7), $00, SpriteSmall, $00F, 2, 1, false, false
        .structSpriteEntry ( -10,   -7), $00, SpriteSmall, $018, 2, 1, false, false
        .structSpriteEntry ( -18,   -7), $00, SpriteSmall, $019, 2, 1, false, false
        .structSpriteEntry (  14,  -23), $00, SpriteSmall, $01A, 2, 1, false, false
        .structSpriteEntry (  14,  -31), $00, SpriteSmall, $01B, 2, 1, false, false
        .structSpriteEntry (  14,  -39), $00, SpriteSmall, $01C, 2, 1, false, false
        .structSpriteEntry (  -2,  -23), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -18,  -23), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  -2,  -39), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -18,  -39), $21, SpriteLarge, $006, 2, 1, false, false
        ANIM_RECORD_END

      _Record04
        ANIM_RECORD 3
        .structSpriteEntry (   3,  -27), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  -2,  -43), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  -6,  -35), $21, SpriteLarge, $0A4, 2, 0, false, false
        .structSpriteEntry (  -7,  -51), $21, SpriteLarge, $084, 2, 0, false, false
        .structSpriteEntry (  14,  -16), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry (  22,  -24), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry (  22,  -32), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (  14,  -24), $00, SpriteSmall, $00B, 2, 1, false, false
        .structSpriteEntry (  14,  -32), $00, SpriteSmall, $00C, 2, 1, false, false
        .structSpriteEntry ( -26,  -16), $00, SpriteSmall, $00D, 2, 1, false, false
        .structSpriteEntry ( -26,  -24), $00, SpriteSmall, $00E, 2, 1, false, false
        .structSpriteEntry ( -26,  -32), $00, SpriteSmall, $00F, 2, 1, false, false
        .structSpriteEntry ( -26,  -40), $00, SpriteSmall, $018, 2, 1, false, false
        .structSpriteEntry (   6,   -8), $00, SpriteSmall, $019, 2, 1, false, false
        .structSpriteEntry (  -2,   -8), $00, SpriteSmall, $01A, 2, 1, false, false
        .structSpriteEntry ( -10,   -8), $00, SpriteSmall, $01B, 2, 1, false, false
        .structSpriteEntry ( -18,   -8), $00, SpriteSmall, $01C, 2, 1, false, false
        .structSpriteEntry (  -2,  -24), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -18,  -24), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  -2,  -40), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -18,  -40), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -18,  -47), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry ( -18,  -63), $21, SpriteLarge, $048, 2, 2, false, false
        ANIM_RECORD_END

      _Record05
        ANIM_RECORD 4
        .structSpriteEntry (   4,  -26), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  -1,  -42), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  -5,  -34), $21, SpriteLarge, $0A4, 2, 0, false, false
        .structSpriteEntry (  -6,  -50), $21, SpriteLarge, $084, 2, 0, false, false
        .structSpriteEntry (   8,   -6), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry (   0,   -6), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry (  16,   -6), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (  16,  -14), $00, SpriteSmall, $00B, 2, 1, false, false
        .structSpriteEntry (  16,  -22), $00, SpriteSmall, $00C, 2, 1, false, false
        .structSpriteEntry (  16,  -30), $00, SpriteSmall, $00D, 2, 1, false, false
        .structSpriteEntry (   0,  -22), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   0,  -38), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry ( -24,  -10), $00, SpriteSmall, $00E, 2, 1, false, false
        .structSpriteEntry ( -24,  -18), $00, SpriteSmall, $00F, 2, 1, false, false
        .structSpriteEntry ( -24,  -26), $00, SpriteSmall, $018, 2, 1, false, false
        .structSpriteEntry ( -24,  -34), $00, SpriteSmall, $019, 2, 1, false, false
        .structSpriteEntry ( -24,  -42), $00, SpriteSmall, $01A, 2, 1, false, false
        .structSpriteEntry ( -16,  -10), $00, SpriteSmall, $01B, 2, 1, false, false
        .structSpriteEntry ( -16,  -26), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -16,  -42), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -17,  -47), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry ( -17,  -63), $21, SpriteLarge, $048, 2, 2, false, false
        ANIM_RECORD_END

      _Record06
        ANIM_RECORD 5
        .structSpriteEntry (   4,  -27), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  -1,  -43), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  -5,  -35), $21, SpriteLarge, $0A4, 2, 0, false, false
        .structSpriteEntry (  -6,  -51), $21, SpriteLarge, $084, 2, 0, false, false
        .structSpriteEntry (   8,  -39), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry (   8,  -15), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   8,  -31), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (   0,   -7), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry (   0,  -15), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (   0,  -23), $00, SpriteSmall, $00B, 2, 1, false, false
        .structSpriteEntry (   0,  -31), $00, SpriteSmall, $00C, 2, 1, false, false
        .structSpriteEntry (   0,  -39), $00, SpriteSmall, $00D, 2, 1, false, false
        .structSpriteEntry (  -8,  -19), $00, SpriteSmall, $00E, 2, 1, false, false
        .structSpriteEntry ( -16,  -11), $00, SpriteSmall, $00F, 2, 1, false, false
        .structSpriteEntry ( -24,  -11), $00, SpriteSmall, $018, 2, 1, false, false
        .structSpriteEntry (  -8,  -27), $00, SpriteSmall, $019, 2, 1, false, false
        .structSpriteEntry (  -8,  -35), $00, SpriteSmall, $01A, 2, 1, false, false
        .structSpriteEntry (  -8,  -43), $00, SpriteSmall, $01B, 2, 1, false, false
        .structSpriteEntry ( -24,  -27), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -24,  -43), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -17,  -48), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry ( -17,  -64), $21, SpriteLarge, $048, 2, 2, false, false
        ANIM_RECORD_END

      _Record07
        ANIM_RECORD 6
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

      _Record08
        ANIM_RECORD 7
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

      _Record09
        ANIM_RECORD 8
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

      _Record10
        ANIM_RECORD 9
        .structSpriteEntry ( -30,  -46), $21, SpriteLarge, $044, 2, 2, false, false
        .structSpriteEntry (  -8,  -27), $00, SpriteSmall, $0B8, 2, 0, false, false
        .structSpriteEntry (  -8,  -35), $00, SpriteSmall, $0A8, 2, 0, false, false
        .structSpriteEntry (  12,  -15), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry (  12,  -23), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry (  -4,  -23), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry (   4,  -23), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (  -4,  -15), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00B, 2, 1, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $00C, 2, 1, false, false
        .structSpriteEntry ( -14,  -46), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (   2,  -27), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   2,  -43), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  10,  -27), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (  -8,  -51), $21, SpriteLarge, $088, 2, 0, false, false
        ANIM_RECORD_END

      _Record11
        ANIM_RECORD 10
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry ( -30,  -46), $21, SpriteLarge, $044, 2, 2, false, false
        .structSpriteEntry (  -8,  -27), $00, SpriteSmall, $0B8, 2, 0, false, false
        .structSpriteEntry (  -8,  -35), $00, SpriteSmall, $0A8, 2, 0, false, false
        .structSpriteEntry (  10,  -27), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   2,  -27), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry (  -4,  -23), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (   2,  -43), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry ( -14,  -46), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry (  -8,  -51), $21, SpriteLarge, $088, 2, 0, false, false
        ANIM_RECORD_END

      _Record12
        ANIM_RECORD 10
        .structSpriteEntry ( -18,  -48), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry ( -34,  -48), $21, SpriteLarge, $044, 2, 2, false, false
        .structSpriteEntry (  -8,  -27), $00, SpriteSmall, $0B9, 2, 0, false, false
        .structSpriteEntry (  -8,  -35), $00, SpriteSmall, $0A9, 2, 0, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry (  -4,  -23), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry ( -16,  -43), $00, SpriteSmall, $0D7, 2, 0, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (   2,  -42), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  10,  -26), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   2,  -26), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  -8,  -51), $21, SpriteLarge, $0C8, 2, 0, false, false
        ANIM_RECORD_END

      _Record13
        ANIM_RECORD 10
        .structSpriteEntry ( -21,  -57), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry ( -21,  -73), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry ( -16,  -51), $00, SpriteSmall, $0CD, 2, 0, false, false
        .structSpriteEntry (  -8,  -27), $00, SpriteSmall, $0B9, 2, 0, false, false
        .structSpriteEntry (  -8,  -35), $00, SpriteSmall, $0A9, 2, 0, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry (  -4,  -23), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (   1,  -41), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   9,  -25), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   1,  -25), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  -8,  -51), $21, SpriteLarge, $0CE, 2, 0, false, false
        ANIM_RECORD_END

      _Record14
        ANIM_RECORD 10
        .structSpriteEntry ( -21,  -59), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry ( -21,  -75), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry (  -8,  -27), $00, SpriteSmall, $0BA, 2, 0, false, false
        .structSpriteEntry (  -8,  -35), $00, SpriteSmall, $0AA, 2, 0, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry (  -4,  -23), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry ( -16,  -53), $00, SpriteSmall, $0CD, 2, 0, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (   0,  -43), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   8,  -27), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   0,  -27), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  -8,  -51), $21, SpriteLarge, $0CA, 2, 0, false, false
        ANIM_RECORD_END

      _Record15
        ANIM_RECORD 10
        .structSpriteEntry ( -11,  -60), $21, SpriteLarge, $04E, 2, 2, false, false
        .structSpriteEntry ( -11,  -76), $21, SpriteLarge, $04C, 2, 2, false, false
        .structSpriteEntry (  -8,  -27), $00, SpriteSmall, $0BA, 2, 0, false, false
        .structSpriteEntry (  -8,  -35), $00, SpriteSmall, $0AA, 2, 0, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry (  -4,  -23), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (  -8,  -59), $00, SpriteSmall, $0DD, 2, 0, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (   0,  -43), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   8,  -27), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   0,  -27), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  -8,  -51), $21, SpriteLarge, $0EE, 2, 0, false, false
        ANIM_RECORD_END

      _Record16
        ANIM_RECORD 10
        .structSpriteEntry ( -24,  -36), $21, SpriteLarge, $042, 2, 2, false, false
        .structSpriteEntry ( -40,  -36), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry ( -17,  -35), $00, SpriteSmall, $0D3, 2, 0, false, false
        .structSpriteEntry ( -17,  -43), $00, SpriteSmall, $0C3, 2, 0, false, false
        .structSpriteEntry (  -9,  -27), $00, SpriteSmall, $0D6, 2, 0, false, false
        .structSpriteEntry (  -9,  -35), $00, SpriteSmall, $0C6, 2, 0, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry (  -4,  -23), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  -1,  -31), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  -1,  -47), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  -9,  -51), $21, SpriteLarge, $0C4, 2, 0, false, false
        .structSpriteEntry (   7,  -31), $00, SpriteSmall, $063, 2, 3, false, false
        ANIM_RECORD_END

      _Record17
        ANIM_RECORD 10
        .structSpriteEntry ( -43,  -33), $00, SpriteSmall, $0E7, 2, 2, false, false
        .structSpriteEntry ( -51,  -33), $00, SpriteSmall, $0E6, 2, 2, false, false
        .structSpriteEntry ( -51,  -49), $21, SpriteLarge, $0E8, 2, 2, false, false
        .structSpriteEntry ( -51,  -65), $21, SpriteLarge, $0EA, 2, 2, false, false
        .structSpriteEntry ( -17,  -35), $00, SpriteSmall, $0D3, 2, 0, false, false
        .structSpriteEntry ( -17,  -43), $00, SpriteSmall, $0C3, 2, 0, false, false
        .structSpriteEntry (  -9,  -27), $00, SpriteSmall, $0D6, 2, 0, false, false
        .structSpriteEntry (  -9,  -35), $00, SpriteSmall, $0C6, 2, 0, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry (  -4,  -23), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  -1,  -47), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   7,  -31), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (  -1,  -31), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  -9,  -51), $21, SpriteLarge, $0C4, 2, 0, false, false
        ANIM_RECORD_END

      _Record18
        ANIM_RECORD 10
        .structSpriteEntry ( -44,  -32), $21, SpriteLarge, $0EC, 2, 2, false, false
        .structSpriteEntry ( -17,  -35), $00, SpriteSmall, $0D3, 2, 0, false, false
        .structSpriteEntry ( -17,  -43), $00, SpriteSmall, $0C3, 2, 0, false, false
        .structSpriteEntry (  -9,  -27), $00, SpriteSmall, $0D6, 2, 0, false, false
        .structSpriteEntry (  -9,  -35), $00, SpriteSmall, $0C6, 2, 0, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry (  -4,  -23), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  -1,  -47), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   7,  -31), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (  -1,  -31), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  -9,  -51), $21, SpriteLarge, $0C4, 2, 0, false, false
        ANIM_RECORD_END

      _Record19
        ANIM_RECORD 10
        .structSpriteEntry ( -13,  -60), $21, SpriteLarge, $04E, 2, 2, false, false
        .structSpriteEntry ( -13,  -76), $21, SpriteLarge, $04C, 2, 2, false, false
        .structSpriteEntry (  -9,  -59), $00, SpriteSmall, $0E3, 2, 0, false, false
        .structSpriteEntry (  -8,  -27), $00, SpriteSmall, $0BA, 2, 0, false, false
        .structSpriteEntry (  -8,  -35), $00, SpriteSmall, $0AA, 2, 0, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry (  -4,  -23), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (   0,  -43), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   8,  -27), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   0,  -27), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  -9,  -51), $21, SpriteLarge, $0E4, 2, 0, false, false
        ANIM_RECORD_END

      _Record20
        ANIM_RECORD 10
        .structSpriteEntry ( -17,  -35), $00, SpriteSmall, $0E0, 2, 0, false, false
        .structSpriteEntry ( -25,  -52), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry ( -41,  -52), $21, SpriteLarge, $044, 2, 2, false, false
        .structSpriteEntry ( -25,  -43), $00, SpriteSmall, $0D1, 2, 0, false, false
        .structSpriteEntry ( -17,  -43), $00, SpriteSmall, $0D2, 2, 0, false, false
        .structSpriteEntry ( -17,  -51), $00, SpriteSmall, $0C2, 2, 0, false, false
        .structSpriteEntry (  -9,  -27), $00, SpriteSmall, $0D6, 2, 0, false, false
        .structSpriteEntry (  -9,  -35), $00, SpriteSmall, $0C6, 2, 0, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry (  -4,  -23), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  -1,  -47), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   7,  -31), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (  -1,  -31), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  -9,  -51), $21, SpriteLarge, $0C4, 2, 0, false, false
        ANIM_RECORD_END

      _Record21
        ANIM_RECORD 11
        .structSpriteEntry ( -30,  -46), $21, SpriteLarge, $044, 2, 2, false, false
        .structSpriteEntry (  -8,  -27), $00, SpriteSmall, $0B8, 2, 0, false, false
        .structSpriteEntry (  -8,  -35), $00, SpriteSmall, $0A8, 2, 0, false, false
        .structSpriteEntry (   4,  -23), $00, SpriteSmall, $002, 2, 1, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $003, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry (  -3,  -15), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry (  -4,  -23), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry (   4,  -15), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $00B, 2, 1, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00C, 2, 1, false, false
        .structSpriteEntry (   2,  -27), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  10,  -27), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   2,  -43), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry ( -14,  -46), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry (  -8,  -51), $21, SpriteLarge, $088, 2, 0, false, false
        ANIM_RECORD_END

      _Record22
        ANIM_RECORD 10
        .structSpriteEntry ( -17,  -35), $00, SpriteSmall, $0E0, 2, 0, false, false
        .structSpriteEntry ( -25,  -43), $00, SpriteSmall, $0D1, 2, 0, false, false
        .structSpriteEntry ( -17,  -43), $00, SpriteSmall, $0D2, 2, 0, false, false
        .structSpriteEntry ( -17,  -51), $00, SpriteSmall, $0C2, 2, 0, false, false
        .structSpriteEntry (  -9,  -27), $00, SpriteSmall, $0D6, 2, 0, false, false
        .structSpriteEntry (  -9,  -35), $00, SpriteSmall, $0C6, 2, 0, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry (  -4,  -23), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  -1,  -47), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   7,  -31), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (  -1,  -31), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  -9,  -51), $21, SpriteLarge, $0C4, 2, 0, false, false
        ANIM_RECORD_END

      _Record23
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (  -3,  -19), $21, SpriteLarge, $042, 2, 2, false, false
        .structSpriteEntry ( -19,  -19), $21, SpriteLarge, $040, 2, 2, false, false
        ANIM_RECORD_END

      _Record24
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry ( -10,  -25), $21, SpriteLarge, $04A, 2, 2, false, true
        .structSpriteEntry ( -10,   -9), $21, SpriteLarge, $048, 2, 2, false, true
        ANIM_RECORD_END

      _Record25
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (  -6,  -25), $21, SpriteLarge, $04A, 2, 2, true, true
        .structSpriteEntry (  -6,   -9), $21, SpriteLarge, $048, 2, 2, true, true
        ANIM_RECORD_END

      _Record26
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry ( -11,  -19), $21, SpriteLarge, $042, 2, 2, true, false
        .structSpriteEntry (   5,  -19), $21, SpriteLarge, $040, 2, 2, true, false
        ANIM_RECORD_END

      _Record27
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry ( -12,  -24), $21, SpriteLarge, $046, 2, 2, true, false
        .structSpriteEntry (   4,  -24), $21, SpriteLarge, $044, 2, 2, true, false
        ANIM_RECORD_END

      _Record28
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (  -7,  -20), $21, SpriteLarge, $04E, 2, 2, false, false
        .structSpriteEntry (  -7,  -36), $21, SpriteLarge, $04C, 2, 2, false, false
        ANIM_RECORD_END

      _Record29
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (  -9,  -20), $21, SpriteLarge, $04E, 2, 2, true, false
        .structSpriteEntry (  -9,  -36), $21, SpriteLarge, $04C, 2, 2, true, false
        ANIM_RECORD_END

      aBattleAnimationFramesCavalierLance ; 98/D3DD

        ; Frame table of entries 13, 14: slices of the class sheet per frame.

        .word _Frame00 - aBattleAnimationFramesCavalierLance
        .word _Frame01 - aBattleAnimationFramesCavalierLance
        .word _Frame02 - aBattleAnimationFramesCavalierLance
        .word _Frame03 - aBattleAnimationFramesCavalierLance
        .word _Frame04 - aBattleAnimationFramesCavalierLance
        .word _Frame05 - aBattleAnimationFramesCavalierLance
        .word _Frame06 - aBattleAnimationFramesCavalierLance
        .word _Frame07 - aBattleAnimationFramesCavalierLance
        .word _Frame08 - aBattleAnimationFramesCavalierLance
        .word _Frame09 - aBattleAnimationFramesCavalierLance
        .word _Frame10 - aBattleAnimationFramesCavalierLance
        .word _Frame11 - aBattleAnimationFramesCavalierLance

      _Frame00
        ANIM_TILES
        ANIM_TILE_ROW $0000, $03A0
        ANIM_TILES_END

      _Frame01
        ANIM_TILES
        ANIM_TILE_ROW $03A0, $0420
        ANIM_TILES_END

      _Frame02
        ANIM_TILES
        ANIM_TILE_ROW $07C0, $03A0
        ANIM_TILES_END

      _Frame03
        ANIM_TILES
        ANIM_TILE_ROW $0B60, $03A0
        ANIM_TILES_END

      _Frame04
        ANIM_TILES
        ANIM_TILE_ROW $0F00, $0380
        ANIM_TILES_END

      _Frame05
        ANIM_TILES
        ANIM_TILE_ROW $1280, $0380
        ANIM_TILES_END

      _Frame06
        ANIM_TILES
        ANIM_TILE_ROW $1600, $01E0
        ANIM_TILE_ROW $17E0, $0100
        ANIM_TILES_END

      _Frame07
        ANIM_TILES
        ANIM_TILE_ROW $18E0, $01C0
        ANIM_TILE_ROW $1AA0, $0100
        ANIM_TILES_END

      _Frame08
        ANIM_TILES
        ANIM_TILE_ROW $1BA0, $01E0
        ANIM_TILE_ROW $1D80, $0100
        ANIM_TILES_END

      _Frame09
        ANIM_TILES
        ANIM_TILE_ROW $1E80, $01A0
        ANIM_TILE_ROW $2020, $0080
        ANIM_TILES_END

      _Frame10
        ANIM_TILES
        ANIM_TILE_ROW $20A0, $0160
        ANIM_TILE_ROW $2200, $0080
        ANIM_TILES_END

      _Frame11
        ANIM_TILES
        ANIM_TILE_ROW $2280, $01A0
        ANIM_TILE_ROW $2420, $0040
        ANIM_TILES_END

      aBattleAnimationSequencesCavalierLance ; 98/D449

        ; Sequence data of entry 13 of aBattleAnimationFrameTables, used by: Cavalier (Lance),
        ; LanceKnight (Lance). Frames: aBattleAnimationFramesCavalierLance.

        .word _Index - aBattleAnimationSequencesCavalierLance, _Records - aBattleAnimationSequencesCavalierLance

      _Index
        .word _Sequence00 - aBattleAnimationSequencesCavalierLance
        .word _Sequence01 - aBattleAnimationSequencesCavalierLance
        .word _Sequence02 - aBattleAnimationSequencesCavalierLance
        .word _Sequence03 - aBattleAnimationSequencesCavalierLance
        .word _Sequence04 - aBattleAnimationSequencesCavalierLance
        .word _Sequence05 - aBattleAnimationSequencesCavalierLance
        .word _Sequence06 - aBattleAnimationSequencesCavalierLance
        .word _Sequence07 - aBattleAnimationSequencesCavalierLance
        .word _Sequence08 - aBattleAnimationSequencesCavalierLance
        .word _Sequence09 - aBattleAnimationSequencesCavalierLance
        .word _Sequence10 - aBattleAnimationSequencesCavalierLance
        .word _Sequence11 - aBattleAnimationSequencesCavalierLance

      _Records
        .word aBattleAnimationSequencesCavalierRangedLance._Record00 - aBattleAnimationSequencesCavalierLance
        .word aBattleAnimationSequencesCavalierRangedLance._Record01 - aBattleAnimationSequencesCavalierLance
        .word aBattleAnimationSequencesCavalierRangedLance._Record02 - aBattleAnimationSequencesCavalierLance
        .word aBattleAnimationSequencesCavalierRangedLance._Record03 - aBattleAnimationSequencesCavalierLance
        .word aBattleAnimationSequencesCavalierRangedLance._Record04 - aBattleAnimationSequencesCavalierLance
        .word aBattleAnimationSequencesCavalierRangedLance._Record05 - aBattleAnimationSequencesCavalierLance
        .word aBattleAnimationSequencesCavalierRangedLance._Record06 - aBattleAnimationSequencesCavalierLance
        .word aBattleAnimationSequencesCavalierRangedLance._Record07 - aBattleAnimationSequencesCavalierLance
        .word aBattleAnimationSequencesCavalierRangedLance._Record08 - aBattleAnimationSequencesCavalierLance
        .word aBattleAnimationSequencesCavalierRangedLance._Record09 - aBattleAnimationSequencesCavalierLance
        .word aBattleAnimationSequencesCavalierRangedLance._Record10 - aBattleAnimationSequencesCavalierLance
        .word aBattleAnimationSequencesCavalierRangedLance._Record11 - aBattleAnimationSequencesCavalierLance
        .word aBattleAnimationSequencesCavalierRangedLance._Record12 - aBattleAnimationSequencesCavalierLance
        .word aBattleAnimationSequencesCavalierRangedLance._Record13 - aBattleAnimationSequencesCavalierLance
        .word aBattleAnimationSequencesCavalierRangedLance._Record14 - aBattleAnimationSequencesCavalierLance
        .word aBattleAnimationSequencesCavalierRangedLance._Record15 - aBattleAnimationSequencesCavalierLance
        .word aBattleAnimationSequencesCavalierRangedLance._Record16 - aBattleAnimationSequencesCavalierLance
        .word aBattleAnimationSequencesCavalierRangedLance._Record17 - aBattleAnimationSequencesCavalierLance
        .word aBattleAnimationSequencesCavalierRangedLance._Record18 - aBattleAnimationSequencesCavalierLance
        .word aBattleAnimationSequencesCavalierRangedLance._Record19 - aBattleAnimationSequencesCavalierLance
        .word aBattleAnimationSequencesCavalierRangedLance._Record20 - aBattleAnimationSequencesCavalierLance
        .word aBattleAnimationSequencesCavalierRangedLance._Record21 - aBattleAnimationSequencesCavalierLance
        .word aBattleAnimationSequencesCavalierRangedLance._Record22 - aBattleAnimationSequencesCavalierLance
        .word aBattleAnimationSequencesCavalierRangedLance._Record23 - aBattleAnimationSequencesCavalierLance
        .word aBattleAnimationSequencesCavalierRangedLance._Record24 - aBattleAnimationSequencesCavalierLance
        .word aBattleAnimationSequencesCavalierRangedLance._Record25 - aBattleAnimationSequencesCavalierLance
        .word aBattleAnimationSequencesCavalierRangedLance._Record26 - aBattleAnimationSequencesCavalierLance
        .word aBattleAnimationSequencesCavalierRangedLance._Record27 - aBattleAnimationSequencesCavalierLance
        .word aBattleAnimationSequencesCavalierRangedLance._Record28 - aBattleAnimationSequencesCavalierLance
        .word aBattleAnimationSequencesCavalierRangedLance._Record29 - aBattleAnimationSequencesCavalierLance
        .word aBattleAnimationSequencesCavalierRangedLance._Record30 - aBattleAnimationSequencesCavalierLance
        .word aBattleAnimationSequencesCavalierRangedLance._Record31 - aBattleAnimationSequencesCavalierLance
        .word aBattleAnimationSequencesCavalierRangedLance._Record32 - aBattleAnimationSequencesCavalierLance
        .word aBattleAnimationSequencesCavalierRangedLance._Record33 - aBattleAnimationSequencesCavalierLance
        .word aBattleAnimationSequencesCavalierRangedLance._Record34 - aBattleAnimationSequencesCavalierLance
        .word aBattleAnimationSequencesCavalierRangedLance._Record35 - aBattleAnimationSequencesCavalierLance
        .word aBattleAnimationSequencesCavalierRangedLance._Record36 - aBattleAnimationSequencesCavalierLance

      _Sequence00
        ANIM_CLEAR_BUSY
        ANIM_STEP 7, 1
        ANIM_HOLD

      _Sequence01
        ANIM_SOUND 19
        ANIM_STEP 7, 4
        ANIM_STEP 8, 4
        ANIM_STEP 9, 5
        ANIM_STEP 8, 5
        ANIM_STEP 7, 16
        ANIM_CMD_F4 0
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence02
        ANIM_SOUND 25
        ANIM_STEP 28, 3
        ANIM_STEP 12, 3
        ANIM_STEP 10, 3
        ANIM_STEP 10, 3
        ANIM_SOUND 26
        ANIM_STEP 9, 5
        ANIM_STEP 8, 5
        ANIM_STEP 7, 16
        ANIM_CMD_F4 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence03
        ANIM_CLEAR_BUSY
        ANIM_CMD_EB
        ANIM_SOUND 19
        ANIM_STEP 2, 6
        ANIM_STEP 3, 6
        ANIM_STEP 4, 6
        ANIM_STEP 5, 6
        ANIM_STEP 6, 6
        ANIM_RESTART
        ANIM_HOLD

      _Sequence04
        ANIM_SOUND 19
        ANIM_STEP 13, 5
        ANIM_STEP 14, 5
        ANIM_STEP 9, 5
        ANIM_STEP 11, 4
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence05
        ANIM_STEP 11, 5
        ANIM_STEP 11, 3
        ANIM_STEP 16, 4
        ANIM_STEP 17, 5
        ANIM_CMD_EE
        ANIM_STEP 18, 15
        ANIM_SOUND 4
        ANIM_STEP 19, 1
        ANIM_CMD_F1
        ANIM_STEP 19, 8
        ANIM_STEP 19, 8
        ANIM_STEP 28, 2
        ANIM_CMD_F3
        ANIM_CMD_ED 3
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence06
        ANIM_STEP 11, 10
        ANIM_STEP 16, 2
        ANIM_STEP 17, 5
        ANIM_STEP 18, 20
        ANIM_SOUND 5
        ANIM_STEP 20, 2
        ANIM_STEP 21, 2
        ANIM_STEP 22, 2
        ANIM_STEP 23, 2
        ANIM_STEP 24, 3
        ANIM_STEP 25, 2
        ANIM_STEP 26, 2
        ANIM_STEP 18, 8
        ANIM_CMD_EE
        ANIM_STEP 18, 14
        ANIM_STEP 19, 2
        ANIM_SOUND 4
        ANIM_CMD_F1
        ANIM_STEP 19, 15
        ANIM_STEP 28, 17
        ANIM_CMD_F3
        ANIM_CMD_ED 3
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence07
        ANIM_STEP 19, 3
        ANIM_STEP 10, 4
        ANIM_STEP 9, 7
        ANIM_STEP 8, 7
        ANIM_STEP 7, 1
        ANIM_CMD_F4 0
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence08
        ANIM_STEP 18, 10
        ANIM_STEP 20, 2
        ANIM_STEP 21, 2
        ANIM_STEP 22, 2
        ANIM_STEP 23, 2
        ANIM_STEP 24, 2
        ANIM_STEP 25, 2
        ANIM_STEP 26, 2
        ANIM_STEP 18, 11
        ANIM_STEP 19, 2
        ANIM_CMD_EE
        ANIM_STEP 19, 16
        ANIM_CMD_F1
        ANIM_STEP 27, 10
        ANIM_CMD_F3
        ANIM_CMD_ED 3
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence09
        ANIM_CLEAR_BUSY
        ANIM_STEP 18, 1
        ANIM_STEP 17, 1
        ANIM_STEP 16, 1
        ANIM_STEP 15, 2
        ANIM_STEP 10, 3
        ANIM_STEP 11, 3
        ANIM_STEP 12, 3
        ANIM_STEP 9, 5
        ANIM_STEP 8, 5
        ANIM_STEP 7, 16
        ANIM_CMD_F4 0
        ANIM_HOLD

      _Sequence10
        ANIM_STEP 0, 0
        ANIM_STEP 19, 4
        ANIM_STEP 20, 22
        ANIM_STEP 12, 1
        ANIM_STEP 13, 1
        ANIM_STEP 11, 80
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence11
        ANIM_CLEAR_BUSY
        ANIM_CMD_EB
        ANIM_SOUND 19
        ANIM_STEP 2, 7
        ANIM_STEP 3, 7
        ANIM_STEP 4, 7
        ANIM_STEP 5, 7
        ANIM_STEP 6, 7
        ANIM_RESTART
        ANIM_HOLD

      aBattleAnimationSequencesCavalierRangedLance ; 98/D5C3

        ; Sequence data of entry 14 of aBattleAnimationFrameTables, used by: Cavalier
        ; (RangedLance), LanceKnight (RangedLance). Frames: aBattleAnimationFramesCavalierLance.

        .word _Index - aBattleAnimationSequencesCavalierRangedLance, _Records - aBattleAnimationSequencesCavalierRangedLance

      _Index
        .word _Sequence00 - aBattleAnimationSequencesCavalierRangedLance
        .word _Sequence01 - aBattleAnimationSequencesCavalierRangedLance
        .word _Sequence02 - aBattleAnimationSequencesCavalierRangedLance
        .word _Sequence03 - aBattleAnimationSequencesCavalierRangedLance
        .word _Sequence04 - aBattleAnimationSequencesCavalierRangedLance
        .word _Sequence05 - aBattleAnimationSequencesCavalierRangedLance
        .word _Sequence06 - aBattleAnimationSequencesCavalierRangedLance
        .word _Sequence07 - aBattleAnimationSequencesCavalierRangedLance
        .word _Sequence08 - aBattleAnimationSequencesCavalierRangedLance
        .word _Sequence09 - aBattleAnimationSequencesCavalierRangedLance
        .word _Sequence10 - aBattleAnimationSequencesCavalierRangedLance

      _Records
        .word _Record00 - aBattleAnimationSequencesCavalierRangedLance
        .word _Record01 - aBattleAnimationSequencesCavalierRangedLance
        .word _Record02 - aBattleAnimationSequencesCavalierRangedLance
        .word _Record03 - aBattleAnimationSequencesCavalierRangedLance
        .word _Record04 - aBattleAnimationSequencesCavalierRangedLance
        .word _Record05 - aBattleAnimationSequencesCavalierRangedLance
        .word _Record06 - aBattleAnimationSequencesCavalierRangedLance
        .word _Record07 - aBattleAnimationSequencesCavalierRangedLance
        .word _Record08 - aBattleAnimationSequencesCavalierRangedLance
        .word _Record09 - aBattleAnimationSequencesCavalierRangedLance
        .word _Record10 - aBattleAnimationSequencesCavalierRangedLance
        .word _Record11 - aBattleAnimationSequencesCavalierRangedLance
        .word _Record12 - aBattleAnimationSequencesCavalierRangedLance
        .word _Record13 - aBattleAnimationSequencesCavalierRangedLance
        .word _Record14 - aBattleAnimationSequencesCavalierRangedLance
        .word _Record15 - aBattleAnimationSequencesCavalierRangedLance
        .word _Record16 - aBattleAnimationSequencesCavalierRangedLance
        .word _Record17 - aBattleAnimationSequencesCavalierRangedLance
        .word _Record18 - aBattleAnimationSequencesCavalierRangedLance
        .word _Record19 - aBattleAnimationSequencesCavalierRangedLance
        .word _Record20 - aBattleAnimationSequencesCavalierRangedLance
        .word _Record21 - aBattleAnimationSequencesCavalierRangedLance
        .word _Record22 - aBattleAnimationSequencesCavalierRangedLance
        .word _Record23 - aBattleAnimationSequencesCavalierRangedLance
        .word _Record24 - aBattleAnimationSequencesCavalierRangedLance
        .word _Record25 - aBattleAnimationSequencesCavalierRangedLance
        .word _Record26 - aBattleAnimationSequencesCavalierRangedLance
        .word _Record27 - aBattleAnimationSequencesCavalierRangedLance
        .word _Record28 - aBattleAnimationSequencesCavalierRangedLance
        .word _Record29 - aBattleAnimationSequencesCavalierRangedLance
        .word _Record30 - aBattleAnimationSequencesCavalierRangedLance
        .word _Record31 - aBattleAnimationSequencesCavalierRangedLance
        .word _Record32 - aBattleAnimationSequencesCavalierRangedLance
        .word _Record33 - aBattleAnimationSequencesCavalierRangedLance
        .word _Record34 - aBattleAnimationSequencesCavalierRangedLance
        .word _Record35 - aBattleAnimationSequencesCavalierRangedLance
        .word _Record36 - aBattleAnimationSequencesCavalierRangedLance

      _Sequence00
        ANIM_CLEAR_BUSY
        ANIM_STEP 7, 8
        ANIM_HOLD

      _Sequence01
        ANIM_CLEAR_BUSY
        ANIM_SOUND 19
        ANIM_STEP 8, 6
        ANIM_STEP 9, 5
        ANIM_STEP 8, 5
        ANIM_STEP 7, 15
        ANIM_STEP 7, 1
        ANIM_CMD_F4 1
        ANIM_HOLD

      _Sequence02
        ANIM_CLEAR_BUSY
        ANIM_SOUND 19
        ANIM_STEP 10, 3
        ANIM_STEP 11, 2
        ANIM_STEP 12, 2
        ANIM_STEP 9, 6
        ANIM_STEP 8, 6
        ANIM_STEP 7, 10
        ANIM_HOLD

      _Sequence03
        ANIM_SOUND 19
        ANIM_STEP 14, 7
        ANIM_STEP 9, 7
        ANIM_STEP 12, 6
        ANIM_STEP 10, 9
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence04
        ANIM_STEP 10, 4
        ANIM_STEP 15, 3
        ANIM_STEP 29, 3
        ANIM_STEP 30, 3
        ANIM_STEP 31, 3
        ANIM_STEP 32, 29
        ANIM_CMD_EF 70
        ANIM_SOUND 11
        ANIM_STEP 33, 8
        ANIM_CMD_EE
        ANIM_STEP 33, 24
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence05
        ANIM_STEP 28, 1
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

      _Record00
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (   4,   -1), $00, SpriteSmall, $0F2, 2, 3, false, false
        .structSpriteEntry (  -4,   -1), $00, SpriteSmall, $0F1, 2, 3, false, false
        .structSpriteEntry (  20,   -1), $00, SpriteSmall, $0F3, 2, 3, false, false
        .structSpriteEntry (  12,   -1), $00, SpriteSmall, $0F2, 2, 3, false, false
        .structSpriteEntry ( -12,   -1), $00, SpriteSmall, $0F1, 2, 3, false, false
        .structSpriteEntry ( -20,   -1), $00, SpriteSmall, $0F1, 2, 3, false, false
        .structSpriteEntry ( -28,   -1), $00, SpriteSmall, $0F0, 2, 3, false, false
        ANIM_RECORD_END

      _Record01
        ANIM_RECORD 0
        .structSpriteEntry ( -24,  -47), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   8,  -26), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   0,  -26), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   0,  -42), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  -3,  -34), $21, SpriteLarge, $0A4, 2, 0, false, false
        .structSpriteEntry (  -4,  -50), $21, SpriteLarge, $084, 2, 0, false, false
        .structSpriteEntry (   0,  -39), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry (  16,   -7), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry (  16,  -15), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (  16,  -23), $00, SpriteSmall, $00B, 2, 1, false, false
        .structSpriteEntry (  16,  -31), $00, SpriteSmall, $00C, 2, 1, false, false
        .structSpriteEntry (   0,  -15), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (   0,  -31), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry (  -8,  -23), $00, SpriteSmall, $00D, 2, 1, false, false
        .structSpriteEntry (  -8,  -31), $00, SpriteSmall, $00E, 2, 1, false, false
        .structSpriteEntry (  -8,  -39), $00, SpriteSmall, $00F, 2, 1, false, false
        .structSpriteEntry (  -8,  -47), $00, SpriteSmall, $018, 2, 1, false, false
        .structSpriteEntry (  -8,  -15), $00, SpriteSmall, $019, 2, 1, false, false
        .structSpriteEntry ( -16,  -15), $00, SpriteSmall, $01A, 2, 1, false, false
        .structSpriteEntry ( -24,  -15), $00, SpriteSmall, $01B, 2, 1, false, false
        .structSpriteEntry ( -24,  -31), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry (  15,  -54), $00, SpriteSmall, $044, 2, 2, false, false
        .structSpriteEntry (   7,  -46), $00, SpriteSmall, $053, 2, 2, false, false
        .structSpriteEntry (  -9,  -38), $00, SpriteSmall, $043, 2, 2, false, false
        .structSpriteEntry ( -33,  -34), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry (   8,  -39), $00, SpriteSmall, $01C, 2, 5, false, false
        ANIM_RECORD_END

      _Record02
        ANIM_RECORD 1
        .structSpriteEntry (   5,  -28), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (  -3,  -28), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  -3,  -44), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  -6,  -36), $21, SpriteLarge, $0A4, 2, 0, false, false
        .structSpriteEntry (  -7,  -52), $21, SpriteLarge, $084, 2, 0, false, false
        .structSpriteEntry (  23,   -8), $00, SpriteSmall, $00C, 2, 1, false, false
        .structSpriteEntry (  23,  -16), $00, SpriteSmall, $00D, 2, 1, false, false
        .structSpriteEntry (  23,  -24), $00, SpriteSmall, $00E, 2, 1, false, false
        .structSpriteEntry (  23,  -32), $00, SpriteSmall, $00F, 2, 1, false, false
        .structSpriteEntry (   7,  -16), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   7,  -32), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  -9,    0), $00, SpriteSmall, $01C, 2, 1, false, false
        .structSpriteEntry ( -17,    0), $00, SpriteSmall, $01D, 2, 1, false, false
        .structSpriteEntry (  -9,   -8), $00, SpriteSmall, $01E, 2, 1, false, false
        .structSpriteEntry ( -17,   -8), $00, SpriteSmall, $01F, 2, 1, false, false
        .structSpriteEntry ( -25,   -8), $00, SpriteSmall, $020, 2, 1, false, false
        .structSpriteEntry (  -9,  -24), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -25,  -24), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry (  -9,  -40), $21, SpriteLarge, $008, 2, 1, false, false
        .structSpriteEntry ( -25,  -40), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry (  11,  -55), $00, SpriteSmall, $044, 2, 2, false, false
        .structSpriteEntry (   3,  -47), $00, SpriteSmall, $053, 2, 2, false, false
        .structSpriteEntry ( -13,  -39), $00, SpriteSmall, $043, 2, 2, false, false
        .structSpriteEntry ( -37,  -35), $21, SpriteLarge, $040, 2, 2, false, false
        ANIM_RECORD_END

      _Record03
        ANIM_RECORD 2
        .structSpriteEntry (   4,  -28), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (  -4,  -28), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  -4,  -44), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  -7,  -36), $21, SpriteLarge, $0A4, 2, 0, false, false
        .structSpriteEntry (  -8,  -52), $21, SpriteLarge, $084, 2, 0, false, false
        .structSpriteEntry (  22,  -23), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry (  22,  -31), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -26,  -23), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry ( -26,  -31), $00, SpriteSmall, $00B, 2, 1, false, false
        .structSpriteEntry ( -26,  -39), $00, SpriteSmall, $00C, 2, 1, false, false
        .structSpriteEntry ( -10,    1), $00, SpriteSmall, $00D, 2, 1, false, false
        .structSpriteEntry (   6,   -7), $00, SpriteSmall, $00E, 2, 1, false, false
        .structSpriteEntry (  -2,   -7), $00, SpriteSmall, $00F, 2, 1, false, false
        .structSpriteEntry ( -10,   -7), $00, SpriteSmall, $018, 2, 1, false, false
        .structSpriteEntry ( -18,   -7), $00, SpriteSmall, $019, 2, 1, false, false
        .structSpriteEntry (  14,  -23), $00, SpriteSmall, $01A, 2, 1, false, false
        .structSpriteEntry (  14,  -31), $00, SpriteSmall, $01B, 2, 1, false, false
        .structSpriteEntry (  14,  -39), $00, SpriteSmall, $01C, 2, 1, false, false
        .structSpriteEntry (  -2,  -23), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -18,  -23), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  -2,  -39), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -18,  -39), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry (  10,  -55), $00, SpriteSmall, $044, 2, 2, false, false
        .structSpriteEntry (   2,  -47), $00, SpriteSmall, $053, 2, 2, false, false
        .structSpriteEntry ( -14,  -39), $00, SpriteSmall, $043, 2, 2, false, false
        .structSpriteEntry ( -38,  -35), $21, SpriteLarge, $040, 2, 2, false, false
        ANIM_RECORD_END

      _Record04
        ANIM_RECORD 3
        .structSpriteEntry (   6,  -27), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (  -2,  -27), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  -2,  -43), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  -6,  -35), $21, SpriteLarge, $0A4, 2, 0, false, false
        .structSpriteEntry (  -7,  -51), $21, SpriteLarge, $084, 2, 0, false, false
        .structSpriteEntry (  14,  -16), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry (  22,  -24), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry (  22,  -32), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (  14,  -24), $00, SpriteSmall, $00B, 2, 1, false, false
        .structSpriteEntry (  14,  -32), $00, SpriteSmall, $00C, 2, 1, false, false
        .structSpriteEntry ( -26,  -16), $00, SpriteSmall, $00D, 2, 1, false, false
        .structSpriteEntry ( -26,  -24), $00, SpriteSmall, $00E, 2, 1, false, false
        .structSpriteEntry ( -26,  -32), $00, SpriteSmall, $00F, 2, 1, false, false
        .structSpriteEntry ( -26,  -40), $00, SpriteSmall, $018, 2, 1, false, false
        .structSpriteEntry (   6,   -8), $00, SpriteSmall, $019, 2, 1, false, false
        .structSpriteEntry (  -2,   -8), $00, SpriteSmall, $01A, 2, 1, false, false
        .structSpriteEntry ( -10,   -8), $00, SpriteSmall, $01B, 2, 1, false, false
        .structSpriteEntry ( -18,   -8), $00, SpriteSmall, $01C, 2, 1, false, false
        .structSpriteEntry (  -2,  -24), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -18,  -24), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  -2,  -40), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -18,  -40), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry (  10,  -54), $00, SpriteSmall, $044, 2, 2, false, false
        .structSpriteEntry (   2,  -46), $00, SpriteSmall, $053, 2, 2, false, false
        .structSpriteEntry ( -14,  -38), $00, SpriteSmall, $043, 2, 2, false, false
        .structSpriteEntry ( -38,  -34), $21, SpriteLarge, $040, 2, 2, false, false
        ANIM_RECORD_END

      _Record05
        ANIM_RECORD 4
        .structSpriteEntry (   7,  -26), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (  -1,  -26), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  -1,  -42), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  -5,  -34), $21, SpriteLarge, $0A4, 2, 0, false, false
        .structSpriteEntry (  -6,  -50), $21, SpriteLarge, $084, 2, 0, false, false
        .structSpriteEntry (   8,   -6), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry (   0,   -6), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry (  16,   -6), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (  16,  -14), $00, SpriteSmall, $00B, 2, 1, false, false
        .structSpriteEntry (  16,  -22), $00, SpriteSmall, $00C, 2, 1, false, false
        .structSpriteEntry (  16,  -30), $00, SpriteSmall, $00D, 2, 1, false, false
        .structSpriteEntry (   0,  -22), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   0,  -38), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry ( -24,  -10), $00, SpriteSmall, $00E, 2, 1, false, false
        .structSpriteEntry ( -24,  -18), $00, SpriteSmall, $00F, 2, 1, false, false
        .structSpriteEntry ( -24,  -26), $00, SpriteSmall, $018, 2, 1, false, false
        .structSpriteEntry ( -24,  -34), $00, SpriteSmall, $019, 2, 1, false, false
        .structSpriteEntry ( -24,  -42), $00, SpriteSmall, $01A, 2, 1, false, false
        .structSpriteEntry ( -16,  -10), $00, SpriteSmall, $01B, 2, 1, false, false
        .structSpriteEntry ( -16,  -26), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -16,  -42), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry (  12,  -53), $00, SpriteSmall, $044, 2, 2, false, false
        .structSpriteEntry (   4,  -45), $00, SpriteSmall, $053, 2, 2, false, false
        .structSpriteEntry ( -36,  -33), $21, SpriteLarge, $040, 2, 2, false, false
        ANIM_RECORD_END

      _Record06
        ANIM_RECORD 5
        .structSpriteEntry (   7,  -27), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (  -1,  -27), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  -1,  -43), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  -5,  -35), $21, SpriteLarge, $0A4, 2, 0, false, false
        .structSpriteEntry (  -6,  -51), $21, SpriteLarge, $084, 2, 0, false, false
        .structSpriteEntry (   8,  -39), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry (   8,  -15), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   8,  -31), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (   0,   -7), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry (   0,  -15), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (   0,  -23), $00, SpriteSmall, $00B, 2, 1, false, false
        .structSpriteEntry (   0,  -31), $00, SpriteSmall, $00C, 2, 1, false, false
        .structSpriteEntry (   0,  -39), $00, SpriteSmall, $00D, 2, 1, false, false
        .structSpriteEntry (  -8,  -19), $00, SpriteSmall, $00E, 2, 1, false, false
        .structSpriteEntry ( -16,  -11), $00, SpriteSmall, $00F, 2, 1, false, false
        .structSpriteEntry ( -24,  -11), $00, SpriteSmall, $018, 2, 1, false, false
        .structSpriteEntry (  -8,  -27), $00, SpriteSmall, $019, 2, 1, false, false
        .structSpriteEntry (  -8,  -35), $00, SpriteSmall, $01A, 2, 1, false, false
        .structSpriteEntry (  -8,  -43), $00, SpriteSmall, $01B, 2, 1, false, false
        .structSpriteEntry ( -24,  -27), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -24,  -43), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry (  12,  -54), $00, SpriteSmall, $044, 2, 2, false, false
        .structSpriteEntry (   4,  -46), $00, SpriteSmall, $053, 2, 2, false, false
        .structSpriteEntry ( -36,  -34), $21, SpriteLarge, $040, 2, 2, false, false
        ANIM_RECORD_END

      _Record07
        ANIM_RECORD 6
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

      _Record08
        ANIM_RECORD 7
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

      _Record09
        ANIM_RECORD 8
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

      _Record10
        ANIM_RECORD 9
        .structSpriteEntry (  -8,  -27), $00, SpriteSmall, $0B8, 2, 0, false, false
        .structSpriteEntry (  12,  -15), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry (  12,  -23), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry (  -4,  -23), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry (   4,  -23), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (  -4,  -15), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (  10,  -27), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   2,  -27), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  -8,  -35), $00, SpriteSmall, $0A8, 2, 0, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00B, 2, 1, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $00C, 2, 1, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (   2,  -43), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  -8,  -51), $21, SpriteLarge, $088, 2, 0, false, false
        .structSpriteEntry (  10,  -50), $00, SpriteSmall, $044, 2, 2, false, false
        .structSpriteEntry ( -14,  -35), $00, SpriteSmall, $043, 2, 2, false, false
        .structSpriteEntry ( -22,  -35), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry ( -38,  -30), $21, SpriteLarge, $040, 2, 2, false, false
        ANIM_RECORD_END

      _Record11
        ANIM_RECORD 10
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry (  -8,  -27), $00, SpriteSmall, $0B8, 2, 0, false, false
        .structSpriteEntry (  10,  -27), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   2,  -27), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry (  -4,  -23), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (  -8,  -35), $00, SpriteSmall, $0A8, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (   2,  -43), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  -8,  -51), $21, SpriteLarge, $088, 2, 0, false, false
        .structSpriteEntry ( -22,  -36), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry ( -38,  -31), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry (  10,  -52), $00, SpriteSmall, $044, 2, 2, false, false
        .structSpriteEntry ( -14,  -36), $00, SpriteSmall, $043, 2, 2, false, false
        .structSpriteEntry (   2,  -44), $00, SpriteSmall, $053, 2, 2, false, false
        ANIM_RECORD_END

      _Record12
        ANIM_RECORD 11
        .structSpriteEntry (  -8,  -27), $00, SpriteSmall, $0B8, 2, 0, false, false
        .structSpriteEntry (   4,  -23), $00, SpriteSmall, $002, 2, 1, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $003, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry (  -3,  -15), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry (  -4,  -23), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry (   4,  -15), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (  10,  -27), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   2,  -27), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  -8,  -35), $00, SpriteSmall, $0A8, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $00B, 2, 1, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   2,  -43), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00C, 2, 1, false, false
        .structSpriteEntry (  -8,  -51), $21, SpriteLarge, $088, 2, 0, false, false
        .structSpriteEntry ( -22,  -36), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry ( -38,  -31), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry (  10,  -52), $00, SpriteSmall, $044, 2, 2, false, false
        .structSpriteEntry (   2,  -44), $00, SpriteSmall, $053, 2, 2, false, false
        .structSpriteEntry ( -14,  -36), $00, SpriteSmall, $043, 2, 2, false, false
        ANIM_RECORD_END

      _Record13
        ANIM_RECORD 6
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

      _Record14
        ANIM_RECORD 7
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

      _Record15
        ANIM_RECORD 10
        .structSpriteEntry (  -8,  -27), $00, SpriteSmall, $0B9, 2, 0, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry (   9,  -56), $00, SpriteSmall, $044, 2, 2, false, false
        .structSpriteEntry ( -23,  -40), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry ( -39,  -35), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry (  10,  -26), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   2,  -26), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry ( -16,  -43), $00, SpriteSmall, $09A, 2, 0, false, false
        .structSpriteEntry (  -8,  -35), $00, SpriteSmall, $0A9, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (  -4,  -23), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (   2,  -42), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  -8,  -51), $21, SpriteLarge, $08B, 2, 0, false, false
        .structSpriteEntry (   1,  -48), $00, SpriteSmall, $053, 2, 2, false, false
        .structSpriteEntry ( -15,  -40), $00, SpriteSmall, $043, 2, 2, false, false
        ANIM_RECORD_END

      _Record16
        ANIM_RECORD 10
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry ( -16,  -43), $00, SpriteSmall, $09D, 2, 0, false, false
        .structSpriteEntry ( -16,  -51), $00, SpriteSmall, $08D, 2, 0, false, false
        .structSpriteEntry (   8,  -61), $00, SpriteSmall, $044, 2, 2, false, false
        .structSpriteEntry (   0,  -53), $00, SpriteSmall, $053, 2, 2, false, false
        .structSpriteEntry (  -8,  -53), $00, SpriteSmall, $052, 2, 2, false, false
        .structSpriteEntry ( -16,  -45), $00, SpriteSmall, $043, 2, 2, false, false
        .structSpriteEntry ( -24,  -45), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry ( -40,  -40), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry (   9,  -25), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   1,  -25), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  -8,  -27), $00, SpriteSmall, $0B9, 2, 0, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry (  -4,  -23), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (  -8,  -35), $00, SpriteSmall, $0A9, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (   1,  -41), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  -8,  -51), $21, SpriteLarge, $08E, 2, 0, false, false
        ANIM_RECORD_END

      _Record17
        ANIM_RECORD 10
        .structSpriteEntry (  11,  -66), $00, SpriteSmall, $044, 2, 2, false, false
        .structSpriteEntry (  -5,  -58), $00, SpriteSmall, $052, 2, 2, false, false
        .structSpriteEntry (   3,  -58), $00, SpriteSmall, $053, 2, 2, false, false
        .structSpriteEntry ( -13,  -50), $00, SpriteSmall, $043, 2, 2, false, false
        .structSpriteEntry ( -21,  -50), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry ( -37,  -45), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry (  -8,  -27), $00, SpriteSmall, $0B9, 2, 0, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry (  -4,  -23), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   9,  -25), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   1,  -25), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  -8,  -35), $00, SpriteSmall, $0A9, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (   1,  -41), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  -8,  -51), $21, SpriteLarge, $0AB, 2, 0, false, false
        ANIM_RECORD_END

      _Record18
        ANIM_RECORD 10
        .structSpriteEntry (  11,  -68), $00, SpriteSmall, $044, 2, 2, false, false
        .structSpriteEntry (   3,  -60), $00, SpriteSmall, $053, 2, 2, false, false
        .structSpriteEntry (  -5,  -60), $00, SpriteSmall, $052, 2, 2, false, false
        .structSpriteEntry ( -13,  -52), $00, SpriteSmall, $043, 2, 2, false, false
        .structSpriteEntry ( -21,  -52), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry ( -37,  -47), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry (  -8,  -27), $00, SpriteSmall, $0BA, 2, 0, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry (  -4,  -23), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   8,  -27), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   0,  -27), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  -8,  -35), $00, SpriteSmall, $0AA, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (   0,  -43), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  -8,  -51), $21, SpriteLarge, $0AE, 2, 0, false, false
        ANIM_RECORD_END

      _Record19
        ANIM_RECORD 10
        .structSpriteEntry (  -9,  -27), $00, SpriteSmall, $0D6, 2, 0, false, false
        .structSpriteEntry (  -9,  -35), $00, SpriteSmall, $0C6, 2, 0, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry (  -4,  -23), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -17,  -35), $00, SpriteSmall, $0D0, 2, 0, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  -1,  -47), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   7,  -31), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (  -1,  -31), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry ( -17,  -43), $00, SpriteSmall, $0C0, 2, 0, false, false
        .structSpriteEntry (  -9,  -51), $21, SpriteLarge, $0C4, 2, 0, false, false
        .structSpriteEntry ( -23,  -34), $00, SpriteSmall, $043, 2, 2, false, false
        .structSpriteEntry ( -31,  -34), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry ( -47,  -29), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry (   1,  -49), $00, SpriteSmall, $044, 2, 2, false, false
        .structSpriteEntry ( -15,  -42), $00, SpriteSmall, $052, 2, 2, false, false
        .structSpriteEntry (  -7,  -42), $00, SpriteSmall, $053, 2, 2, false, false
        ANIM_RECORD_END

      _Record20
        ANIM_RECORD 10
        .structSpriteEntry (  -8,  -27), $00, SpriteSmall, $0BA, 2, 0, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry (  -4,  -23), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   0,  -27), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   8,  -27), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (  -8,  -35), $00, SpriteSmall, $0AA, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (   0,  -43), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  -8,  -51), $21, SpriteLarge, $0AE, 2, 0, false, false
        .structSpriteEntry ( -22,  -58), $00, SpriteSmall, $042, 2, 2, false, true
        .structSpriteEntry ( -38,  -71), $21, SpriteLarge, $040, 2, 2, false, true
        .structSpriteEntry (  10,  -42), $00, SpriteSmall, $044, 2, 2, false, true
        .structSpriteEntry (  -6,  -50), $00, SpriteSmall, $052, 2, 2, false, true
        .structSpriteEntry ( -14,  -58), $00, SpriteSmall, $043, 2, 2, false, true
        .structSpriteEntry (   2,  -50), $00, SpriteSmall, $053, 2, 2, false, true
        ANIM_RECORD_END

      _Record21
        ANIM_RECORD 10
        .structSpriteEntry (  -8,  -27), $00, SpriteSmall, $0BA, 2, 0, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry (  -4,  -23), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   0,  -27), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   8,  -27), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (  -8,  -35), $00, SpriteSmall, $0AA, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (   0,  -43), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  -8,  -51), $21, SpriteLarge, $0AE, 2, 0, false, false
        .structSpriteEntry ( -14,  -66), $00, SpriteSmall, $057, 2, 2, false, true
        .structSpriteEntry ( -27,  -82), $21, SpriteLarge, $045, 2, 2, false, true
        .structSpriteEntry (  -6,  -50), $00, SpriteSmall, $058, 2, 2, false, true
        .structSpriteEntry ( -14,  -58), $00, SpriteSmall, $047, 2, 2, false, true
        ANIM_RECORD_END

      _Record22
        ANIM_RECORD 10
        .structSpriteEntry (  -8,  -27), $00, SpriteSmall, $0BA, 2, 0, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry (  -4,  -23), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry (   8,  -27), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   0,  -27), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  -8,  -35), $00, SpriteSmall, $0AA, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (   0,  -43), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  -8,  -51), $21, SpriteLarge, $0AE, 2, 0, false, false
        .structSpriteEntry ( -23,  -34), $00, SpriteSmall, $054, 2, 2, true, true
        .structSpriteEntry ( -15,  -42), $00, SpriteSmall, $048, 2, 2, true, true
        .structSpriteEntry (  -7,  -66), $00, SpriteSmall, $057, 2, 2, true, true
        .structSpriteEntry (  -2,  -82), $21, SpriteLarge, $045, 2, 2, true, true
        .structSpriteEntry (  -7,  -58), $00, SpriteSmall, $047, 2, 2, true, true
        .structSpriteEntry ( -15,  -50), $00, SpriteSmall, $058, 2, 2, true, true
        ANIM_RECORD_END

      _Record23
        ANIM_RECORD 10
        .structSpriteEntry (  -8,  -27), $00, SpriteSmall, $0BA, 2, 0, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry (  -4,  -23), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -31,  -41), $00, SpriteSmall, $044, 2, 2, true, true
        .structSpriteEntry ( -23,  -49), $00, SpriteSmall, $053, 2, 2, true, true
        .structSpriteEntry (   1,  -57), $00, SpriteSmall, $042, 2, 2, true, true
        .structSpriteEntry (   9,  -70), $21, SpriteLarge, $040, 2, 2, true, true
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry (   0,  -27), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   8,  -27), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (  -8,  -35), $00, SpriteSmall, $0AA, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (   0,  -43), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  -8,  -51), $21, SpriteLarge, $0AE, 2, 0, false, false
        .structSpriteEntry ( -15,  -49), $00, SpriteSmall, $052, 2, 2, true, true
        .structSpriteEntry (  -7,  -57), $00, SpriteSmall, $043, 2, 2, true, true
        ANIM_RECORD_END

      _Record24
        ANIM_RECORD 10
        .structSpriteEntry (  -8,  -27), $00, SpriteSmall, $0BA, 2, 0, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry (  -4,  -23), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   0,  -27), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   8,  -27), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (  -8,  -35), $00, SpriteSmall, $0AA, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (   0,  -43), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  -8,  -51), $21, SpriteLarge, $0AE, 2, 0, false, false
        .structSpriteEntry ( -31,  -66), $00, SpriteSmall, $044, 2, 2, true, false
        .structSpriteEntry ( -23,  -58), $00, SpriteSmall, $053, 2, 2, true, false
        .structSpriteEntry (   9,  -46), $21, SpriteLarge, $040, 2, 2, true, false
        .structSpriteEntry (  -7,  -50), $00, SpriteSmall, $043, 2, 2, true, false
        .structSpriteEntry (   1,  -50), $00, SpriteSmall, $042, 2, 2, true, false
        .structSpriteEntry ( -15,  -58), $00, SpriteSmall, $052, 2, 2, true, false
        ANIM_RECORD_END

      _Record25
        ANIM_RECORD 10
        .structSpriteEntry (  -8,  -27), $00, SpriteSmall, $0BA, 2, 0, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry (  -4,  -23), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   0,  -27), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   8,  -27), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (  -8,  -35), $00, SpriteSmall, $0AA, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (   0,  -43), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  -8,  -51), $21, SpriteLarge, $0AE, 2, 0, false, false
        .structSpriteEntry ( -23,  -74), $00, SpriteSmall, $054, 2, 2, true, false
        .structSpriteEntry ( -15,  -66), $00, SpriteSmall, $048, 2, 2, true, false
        .structSpriteEntry ( -15,  -58), $00, SpriteSmall, $058, 2, 2, true, false
        .structSpriteEntry (  -7,  -50), $00, SpriteSmall, $047, 2, 2, true, false
        ANIM_RECORD_END

      _Record26
        ANIM_RECORD 10
        .structSpriteEntry (  -8,  -27), $00, SpriteSmall, $0BA, 2, 0, false, false
        .structSpriteEntry (  -4,  -23), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   2,  -75), $00, SpriteSmall, $054, 2, 2, false, false
        .structSpriteEntry (  -6,  -67), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry ( -14,  -43), $00, SpriteSmall, $057, 2, 2, false, false
        .structSpriteEntry ( -27,  -35), $21, SpriteLarge, $045, 2, 2, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry (   8,  -27), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   0,  -27), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  -8,  -35), $00, SpriteSmall, $0AA, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (   0,  -43), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  -8,  -51), $21, SpriteLarge, $0AE, 2, 0, false, false
        .structSpriteEntry ( -14,  -51), $00, SpriteSmall, $047, 2, 2, false, false
        .structSpriteEntry (  -6,  -59), $00, SpriteSmall, $058, 2, 2, false, false
        ANIM_RECORD_END

      _Record27
        ANIM_RECORD 10
        .structSpriteEntry (  11,  -68), $00, SpriteSmall, $044, 2, 2, false, false
        .structSpriteEntry (  -5,  -60), $00, SpriteSmall, $052, 2, 2, false, false
        .structSpriteEntry (   3,  -60), $00, SpriteSmall, $053, 2, 2, false, false
        .structSpriteEntry ( -21,  -52), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry ( -37,  -47), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry (   0,  -27), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   8,  -27), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (  -8,  -27), $00, SpriteSmall, $0BA, 2, 0, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry (  -4,  -23), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (  -8,  -35), $00, SpriteSmall, $0AA, 2, 0, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -13,  -52), $00, SpriteSmall, $043, 2, 2, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (   0,  -43), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  -8,  -51), $21, SpriteLarge, $0AE, 2, 0, false, false
        ANIM_RECORD_END

      _Record28
        ANIM_RECORD 10
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry (  -8,  -27), $00, SpriteSmall, $0B8, 2, 0, false, false
        .structSpriteEntry (   2,  -27), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  10,  -27), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry (  -8,  -35), $00, SpriteSmall, $0A8, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (  -4,  -23), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (   2,  -43), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  -8,  -51), $21, SpriteLarge, $088, 2, 0, false, false
        .structSpriteEntry ( -22,  -36), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry ( -38,  -31), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry (  10,  -52), $00, SpriteSmall, $044, 2, 2, false, false
        .structSpriteEntry ( -14,  -36), $00, SpriteSmall, $043, 2, 2, false, false
        .structSpriteEntry (  -6,  -44), $00, SpriteSmall, $052, 2, 2, false, false
        .structSpriteEntry (   2,  -44), $00, SpriteSmall, $053, 2, 2, false, false
        ANIM_RECORD_END

      _Record29
        ANIM_RECORD 10
        .structSpriteEntry (  -8,  -27), $00, SpriteSmall, $0B9, 2, 0, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry (   2,  -26), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  10,  -26), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (  -8,  -35), $00, SpriteSmall, $0A9, 2, 0, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -16,  -43), $00, SpriteSmall, $09A, 2, 0, false, false
        .structSpriteEntry (  -4,  -23), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (   2,  -42), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  -8,  -51), $21, SpriteLarge, $08B, 2, 0, false, false
        .structSpriteEntry (   9,  -31), $00, SpriteSmall, $044, 2, 2, false, true
        .structSpriteEntry (   1,  -38), $00, SpriteSmall, $053, 2, 2, false, true
        .structSpriteEntry ( -23,  -46), $00, SpriteSmall, $042, 2, 2, false, true
        .structSpriteEntry ( -39,  -59), $21, SpriteLarge, $040, 2, 2, false, true
        .structSpriteEntry ( -15,  -46), $00, SpriteSmall, $043, 2, 2, false, true
        ANIM_RECORD_END

      _Record30
        ANIM_RECORD 10
        .structSpriteEntry (  -8,  -27), $00, SpriteSmall, $0B9, 2, 0, false, false
        .structSpriteEntry ( -16,  -43), $00, SpriteSmall, $09D, 2, 0, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry ( -16,  -51), $00, SpriteSmall, $08D, 2, 0, false, false
        .structSpriteEntry (  -4,  -23), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   9,  -25), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (   1,  -25), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (  -8,  -35), $00, SpriteSmall, $0A9, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (   1,  -41), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  -8,  -51), $21, SpriteLarge, $08E, 2, 0, false, false
        .structSpriteEntry ( -24,  -52), $00, SpriteSmall, $042, 2, 2, false, true
        .structSpriteEntry ( -40,  -65), $21, SpriteLarge, $040, 2, 2, false, true
        .structSpriteEntry ( -16,  -52), $00, SpriteSmall, $043, 2, 2, false, true
        .structSpriteEntry (   8,  -37), $00, SpriteSmall, $044, 2, 2, false, true
        .structSpriteEntry (  -8,  -44), $00, SpriteSmall, $052, 2, 2, false, true
        .structSpriteEntry (   0,  -44), $00, SpriteSmall, $053, 2, 2, false, true
        ANIM_RECORD_END

      _Record31
        ANIM_RECORD 10
        .structSpriteEntry (  -8,  -27), $00, SpriteSmall, $0B9, 2, 0, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry (  -4,  -23), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   1,  -25), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   9,  -25), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (  -8,  -35), $00, SpriteSmall, $0A9, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (   1,  -41), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  -8,  -51), $21, SpriteLarge, $0AB, 2, 0, false, false
        .structSpriteEntry (  11,  -40), $00, SpriteSmall, $044, 2, 2, false, true
        .structSpriteEntry ( -21,  -56), $00, SpriteSmall, $042, 2, 2, false, true
        .structSpriteEntry ( -37,  -69), $21, SpriteLarge, $040, 2, 2, false, true
        .structSpriteEntry (  -5,  -48), $00, SpriteSmall, $052, 2, 2, false, true
        .structSpriteEntry (   3,  -48), $00, SpriteSmall, $053, 2, 2, false, true
        .structSpriteEntry ( -13,  -56), $00, SpriteSmall, $043, 2, 2, false, true
        ANIM_RECORD_END

      _Record32
        ANIM_RECORD 10
        .structSpriteEntry (  -8,  -27), $00, SpriteSmall, $0BA, 2, 0, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry (  -4,  -23), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry (   0,  -27), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry (   8,  -27), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (  -8,  -35), $00, SpriteSmall, $0AA, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (   0,  -43), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  -8,  -51), $21, SpriteLarge, $0AE, 2, 0, false, false
        .structSpriteEntry (  11,  -42), $00, SpriteSmall, $044, 2, 2, false, true
        .structSpriteEntry (   3,  -50), $00, SpriteSmall, $053, 2, 2, false, true
        .structSpriteEntry ( -21,  -58), $00, SpriteSmall, $042, 2, 2, false, true
        .structSpriteEntry ( -37,  -71), $21, SpriteLarge, $040, 2, 2, false, true
        .structSpriteEntry (  -5,  -50), $00, SpriteSmall, $052, 2, 2, false, true
        .structSpriteEntry ( -13,  -58), $00, SpriteSmall, $043, 2, 2, false, true
        ANIM_RECORD_END

      _Record33
        ANIM_RECORD 10
        .structSpriteEntry ( -17,  -43), $00, SpriteSmall, $0C0, 2, 0, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $006, 2, 1, false, false
        .structSpriteEntry ( -12,  -15), $00, SpriteSmall, $007, 2, 1, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 1, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $005, 2, 1, false, false
        .structSpriteEntry ( -17,  -35), $00, SpriteSmall, $0D0, 2, 0, false, false
        .structSpriteEntry (  -9,  -27), $00, SpriteSmall, $0D6, 2, 0, false, false
        .structSpriteEntry ( -12,  -23), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry (  -9,  -35), $00, SpriteSmall, $0C6, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry (   7,  -31), $00, SpriteSmall, $063, 2, 3, false, false
        .structSpriteEntry (  -1,  -31), $00, SpriteSmall, $062, 2, 3, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (  -4,  -39), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  -1,  -47), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (  -9,  -51), $21, SpriteLarge, $0C4, 2, 0, false, false
        .structSpriteEntry (  -4,  -23), $21, SpriteLarge, $000, 2, 1, false, false
        ANIM_RECORD_END

      _Record34
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (  19,    3), $00, SpriteSmall, $044, 2, 2, false, true
        .structSpriteEntry (  11,   -5), $00, SpriteSmall, $053, 2, 2, false, true
        .structSpriteEntry (   3,   -5), $00, SpriteSmall, $052, 2, 2, false, true
        .structSpriteEntry (  -5,  -13), $00, SpriteSmall, $043, 2, 2, false, true
        .structSpriteEntry ( -13,  -13), $00, SpriteSmall, $042, 2, 2, false, true
        .structSpriteEntry ( -29,  -26), $21, SpriteLarge, $040, 2, 2, false, true
        ANIM_RECORD_END

      _Record35
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (  17,  -10), $00, SpriteSmall, $05F, 2, 2, false, false
        .structSpriteEntry (   9,  -10), $00, SpriteSmall, $05E, 2, 2, false, false
        .structSpriteEntry (   1,  -10), $00, SpriteSmall, $05D, 2, 2, false, false
        .structSpriteEntry (  -7,  -10), $00, SpriteSmall, $05C, 2, 2, false, false
        .structSpriteEntry ( -15,  -10), $00, SpriteSmall, $05B, 2, 2, false, false
        .structSpriteEntry ( -23,  -10), $00, SpriteSmall, $05A, 2, 2, false, false
        .structSpriteEntry ( -31,  -10), $00, SpriteSmall, $059, 2, 2, false, false
        ANIM_RECORD_END

      _Record36
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (  19,  -26), $00, SpriteSmall, $044, 2, 2, false, false
        .structSpriteEntry (  11,  -18), $00, SpriteSmall, $053, 2, 2, false, false
        .structSpriteEntry (   3,  -18), $00, SpriteSmall, $052, 2, 2, false, false
        .structSpriteEntry (  -5,  -10), $00, SpriteSmall, $043, 2, 2, false, false
        .structSpriteEntry ( -13,  -10), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry ( -29,   -5), $21, SpriteLarge, $040, 2, 2, false, false
        ANIM_RECORD_END

      aBattleAnimationFramesBowKnightBow ; 98/E567

        ; Frame table of entry 16: slices of the class sheet per frame.

        .word _Frame00 - aBattleAnimationFramesBowKnightBow
        .word _Frame01 - aBattleAnimationFramesBowKnightBow
        .word _Frame02 - aBattleAnimationFramesBowKnightBow
        .word _Frame03 - aBattleAnimationFramesBowKnightBow

      _Frame00
        ANIM_TILES
        ANIM_TILE_ROW $0000, $0300
        ANIM_TILES_END

      _Frame01
        ANIM_TILES
        ANIM_TILE_ROW $0300, $0300
        ANIM_TILES_END

      _Frame02
        ANIM_TILES
        ANIM_TILE_ROW $0600, $0300
        ANIM_TILES_END

      _Frame03
        ANIM_TILES
        ANIM_TILE_ROW $0900, $0320
        ANIM_TILES_END

      aBattleAnimationSequencesBowKnightBow ; 98/E583

        ; Sequence data of entry 16 of aBattleAnimationFrameTables, used by: BowKnight (Bow),
        ; MasterKnight (Bow), ArchKnight (Bow). Frames: aBattleAnimationFramesBowKnightBow.

        .word _Index - aBattleAnimationSequencesBowKnightBow, _Records - aBattleAnimationSequencesBowKnightBow

      _Index
        .word _Sequence00 - aBattleAnimationSequencesBowKnightBow
        .word _Sequence01 - aBattleAnimationSequencesBowKnightBow
        .word _Sequence02 - aBattleAnimationSequencesBowKnightBow
        .word _Sequence03 - aBattleAnimationSequencesBowKnightBow
        .word _Sequence04 - aBattleAnimationSequencesBowKnightBow
        .word _Sequence05 - aBattleAnimationSequencesBowKnightBow
        .word _Sequence06 - aBattleAnimationSequencesBowKnightBow
        .word _Sequence07 - aBattleAnimationSequencesBowKnightBow
        .word _Sequence08 - aBattleAnimationSequencesBowKnightBow
        .word _Sequence09 - aBattleAnimationSequencesBowKnightBow
        .word _Sequence10 - aBattleAnimationSequencesBowKnightBow
        .word _Sequence11 - aBattleAnimationSequencesBowKnightBow
        .word _Sequence12 - aBattleAnimationSequencesBowKnightBow
        .word _Sequence13 - aBattleAnimationSequencesBowKnightBow
        .word _Sequence14 - aBattleAnimationSequencesBowKnightBow
        .word _Sequence15 - aBattleAnimationSequencesBowKnightBow
        .word _Sequence16 - aBattleAnimationSequencesBowKnightBow

      _Records
        .word _Record00 - aBattleAnimationSequencesBowKnightBow
        .word _Record01 - aBattleAnimationSequencesBowKnightBow
        .word _Record02 - aBattleAnimationSequencesBowKnightBow
        .word _Record03 - aBattleAnimationSequencesBowKnightBow
        .word _Record04 - aBattleAnimationSequencesBowKnightBow
        .word _Record05 - aBattleAnimationSequencesBowKnightBow
        .word _Record06 - aBattleAnimationSequencesBowKnightBow
        .word _Record07 - aBattleAnimationSequencesBowKnightBow
        .word _Record08 - aBattleAnimationSequencesBowKnightBow
        .word _Record09 - aBattleAnimationSequencesBowKnightBow
        .word _Record10 - aBattleAnimationSequencesBowKnightBow
        .word _Record11 - aBattleAnimationSequencesBowKnightBow
        .word _Record12 - aBattleAnimationSequencesBowKnightBow
        .word _Record13 - aBattleAnimationSequencesBowKnightBow

      _Sequence00
        ANIM_CLEAR_BUSY
        ANIM_STEP 1, 1
        ANIM_HOLD

      _Sequence01
        ANIM_CLEAR_BUSY
        ANIM_SOUND 19
        ANIM_STEP 3, 4
        ANIM_STEP 4, 7
        ANIM_STEP 3, 6
        ANIM_STEP 1, 5
        ANIM_CMD_F4 0
        ANIM_HOLD

      _Sequence02
        ANIM_STEP 2, 2
        ANIM_SOUND 9
        ANIM_STEP 2, 3
        ANIM_STEP 5, 38
        ANIM_SOUND 10
        ANIM_CMD_EF 4
        ANIM_STEP 6, 1
        ANIM_STEP 7, 1
        ANIM_STEP 6, 2
        ANIM_STEP 7, 2
        ANIM_CMD_EE
        ANIM_STEP 6, 2
        ANIM_STEP 7, 2
        ANIM_STEP 6, 18
        ANIM_STEP 2, 6
        ANIM_STEP 1, 24
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence03
        ANIM_STEP 2, 5
        ANIM_SOUND 9
        ANIM_STEP 5, 7
        ANIM_STEP 8, 38
        ANIM_SOUND 10
        ANIM_CMD_EF 9
        ANIM_STEP 9, 2
        ANIM_STEP 10, 2
        ANIM_STEP 9, 2
        ANIM_STEP 10, 2
        ANIM_STEP 9, 2
        ANIM_STEP 10, 18
        ANIM_STEP 6, 6
        ANIM_STEP 2, 6
        ANIM_STEP 1, 24
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence04
        ANIM_STEP 12, 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence05
        ANIM_STEP 12, 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence06
        ANIM_STEP 12, 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence07
        ANIM_STEP 12, 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence08
        ANIM_STEP 12, 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence09
        ANIM_STEP 11, 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence10
        ANIM_STEP 11, 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence11
        ANIM_STEP 12, 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence12
        ANIM_STEP 13, 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence13
        ANIM_STEP 13, 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence14
        ANIM_STEP 2, 2
        ANIM_SOUND 9
        ANIM_STEP 2, 3
        ANIM_STEP 5, 64
        ANIM_SOUND 10
        ANIM_CMD_EF 4
        ANIM_STEP 6, 1
        ANIM_STEP 7, 1
        ANIM_STEP 6, 2
        ANIM_STEP 7, 2
        ANIM_CMD_EE
        ANIM_STEP 6, 2
        ANIM_STEP 7, 2
        ANIM_STEP 6, 18
        ANIM_STEP 2, 6
        ANIM_STEP 1, 24
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence15
        ANIM_CLEAR_BUSY
        ANIM_STEP 1, 21
        ANIM_HOLD

      _Sequence16
        ANIM_STEP 2, 5
        ANIM_SOUND 9
        ANIM_STEP 5, 7
        ANIM_STEP 8, 64
        ANIM_SOUND 10
        ANIM_CMD_EF 9
        ANIM_STEP 9, 2
        ANIM_STEP 10, 2
        ANIM_STEP 9, 2
        ANIM_STEP 10, 2
        ANIM_STEP 9, 2
        ANIM_STEP 10, 18
        ANIM_STEP 6, 6
        ANIM_STEP 2, 6
        ANIM_STEP 1, 24
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Record00
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (  -4,   -2), $00, SpriteSmall, $0F1, 2, 3, false, false
        .structSpriteEntry (   4,   -2), $00, SpriteSmall, $0F2, 2, 3, false, false
        .structSpriteEntry (  20,   -2), $00, SpriteSmall, $0F3, 2, 3, false, false
        .structSpriteEntry (  12,   -2), $00, SpriteSmall, $0F2, 2, 3, false, false
        .structSpriteEntry ( -12,   -2), $00, SpriteSmall, $0F1, 2, 3, false, false
        .structSpriteEntry ( -20,   -2), $00, SpriteSmall, $0F1, 2, 3, false, false
        .structSpriteEntry ( -28,   -2), $00, SpriteSmall, $0F0, 2, 3, false, false
        ANIM_RECORD_END

      _Record01
        ANIM_RECORD 0
        .structSpriteEntry (  -5,  -31), $21, SpriteLarge, $0A0, 2, 0, false, false
        .structSpriteEntry (  -5,  -47), $21, SpriteLarge, $080, 2, 0, false, false
        .structSpriteEntry (   3,  -39), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry (  -5,  -39), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -13,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry ( -21,  -39), $00, SpriteSmall, $00B, 2, 1, false, false
        .structSpriteEntry (  11,   -7), $00, SpriteSmall, $00C, 2, 1, false, false
        .structSpriteEntry (  11,  -15), $00, SpriteSmall, $00D, 2, 1, false, false
        .structSpriteEntry (  11,  -23), $00, SpriteSmall, $00E, 2, 1, false, false
        .structSpriteEntry (  11,  -31), $00, SpriteSmall, $00F, 2, 1, false, false
        .structSpriteEntry (  -5,  -15), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -21,  -15), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  -5,  -31), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -21,  -31), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -13,  -40), $00, SpriteSmall, $052, 2, 2, false, false
        .structSpriteEntry ( -13,  -48), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry ( -10,  -44), $00, SpriteSmall, $058, 2, 2, false, false
        ANIM_RECORD_END

      _Record02
        ANIM_RECORD 1
        .structSpriteEntry ( -12,  -47), $00, SpriteSmall, $0C0, 2, 0, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $0D0, 2, 0, false, false
        .structSpriteEntry (  -4,  -31), $21, SpriteLarge, $0C3, 2, 0, false, false
        .structSpriteEntry (  -4,  -47), $21, SpriteLarge, $0C1, 2, 0, false, false
        .structSpriteEntry (   1,  -39), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (  -7,  -39), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -15,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry ( -23,  -39), $00, SpriteSmall, $00B, 2, 1, false, false
        .structSpriteEntry (   9,   -7), $00, SpriteSmall, $00C, 2, 1, false, false
        .structSpriteEntry (   9,  -15), $00, SpriteSmall, $00D, 2, 1, false, false
        .structSpriteEntry (   9,  -23), $00, SpriteSmall, $00E, 2, 1, false, false
        .structSpriteEntry (   9,  -31), $00, SpriteSmall, $00F, 2, 1, false, false
        .structSpriteEntry (  -7,  -15), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -23,  -15), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  -7,  -31), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -23,  -31), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry (  -9,  -39), $00, SpriteSmall, $059, 2, 2, false, false
        .structSpriteEntry (  -9,  -47), $00, SpriteSmall, $049, 2, 2, false, false
        .structSpriteEntry ( -14,  -41), $00, SpriteSmall, $052, 2, 2, false, false
        .structSpriteEntry ( -14,  -49), $00, SpriteSmall, $042, 2, 2, false, false
        ANIM_RECORD_END

      _Record03
        ANIM_RECORD 2
        .structSpriteEntry (  -8,  -43), $00, SpriteSmall, $058, 2, 2, false, false
        .structSpriteEntry (  -4,  -30), $21, SpriteLarge, $0A2, 2, 0, false, false
        .structSpriteEntry (  -4,  -46), $21, SpriteLarge, $082, 2, 0, false, false
        .structSpriteEntry (   1,  -39), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry (  -7,  -39), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -15,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry ( -23,  -39), $00, SpriteSmall, $00B, 2, 1, false, false
        .structSpriteEntry (   9,   -7), $00, SpriteSmall, $00C, 2, 1, false, false
        .structSpriteEntry (   9,  -15), $00, SpriteSmall, $00D, 2, 1, false, false
        .structSpriteEntry (   9,  -23), $00, SpriteSmall, $00E, 2, 1, false, false
        .structSpriteEntry (   9,  -31), $00, SpriteSmall, $00F, 2, 1, false, false
        .structSpriteEntry (  -7,  -15), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -23,  -15), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  -7,  -31), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -23,  -31), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -11,  -39), $00, SpriteSmall, $052, 2, 2, false, false
        .structSpriteEntry ( -11,  -47), $00, SpriteSmall, $042, 2, 2, false, false
        ANIM_RECORD_END

      _Record04
        ANIM_RECORD 3
        .structSpriteEntry (  -6,  -47), $00, SpriteSmall, $058, 2, 2, false, false
        .structSpriteEntry (  -3,  -33), $21, SpriteLarge, $0A2, 2, 0, false, false
        .structSpriteEntry (  -3,  -49), $21, SpriteLarge, $082, 2, 0, false, false
        .structSpriteEntry ( -15,  -15), $00, SpriteSmall, $008, 2, 1, false, false
        .structSpriteEntry ( -23,  -15), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -23,  -31), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -23,  -47), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  -7,  -47), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry (   1,  -39), $00, SpriteSmall, $00B, 2, 1, false, false
        .structSpriteEntry (  -7,  -39), $00, SpriteSmall, $00C, 2, 1, false, false
        .structSpriteEntry (   9,   -7), $00, SpriteSmall, $00D, 2, 1, false, false
        .structSpriteEntry (   9,  -15), $00, SpriteSmall, $00E, 2, 1, false, false
        .structSpriteEntry (   9,  -23), $00, SpriteSmall, $00F, 2, 1, false, false
        .structSpriteEntry (   9,  -31), $00, SpriteSmall, $018, 2, 1, false, false
        .structSpriteEntry (  -7,  -15), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry (  -7,  -31), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry (  -9,  -43), $00, SpriteSmall, $052, 2, 2, false, false
        .structSpriteEntry (  -9,  -51), $00, SpriteSmall, $042, 2, 2, false, false
        ANIM_RECORD_END

      _Record05
        ANIM_RECORD 1
        .structSpriteEntry (  -3,  -42), $00, SpriteSmall, $05C, 2, 2, false, false
        .structSpriteEntry ( -11,  -42), $00, SpriteSmall, $05B, 2, 2, false, false
        .structSpriteEntry ( -19,  -42), $00, SpriteSmall, $05A, 2, 2, false, false
        .structSpriteEntry (   1,  -37), $00, SpriteSmall, $049, 2, 2, false, true
        .structSpriteEntry (   1,  -45), $00, SpriteSmall, $058, 2, 2, false, false
        .structSpriteEntry (  -1,  -52), $00, SpriteSmall, $058, 2, 2, false, false
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $094, 2, 0, false, false
        .structSpriteEntry ( -12,  -47), $00, SpriteSmall, $084, 2, 0, false, false
        .structSpriteEntry (  -4,  -31), $21, SpriteLarge, $0A5, 2, 0, false, false
        .structSpriteEntry (  -4,  -47), $21, SpriteLarge, $085, 2, 0, false, false
        .structSpriteEntry (   1,  -39), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (  -7,  -39), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -15,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry ( -23,  -39), $00, SpriteSmall, $00B, 2, 1, false, false
        .structSpriteEntry (   9,   -7), $00, SpriteSmall, $00C, 2, 1, false, false
        .structSpriteEntry (   9,  -15), $00, SpriteSmall, $00D, 2, 1, false, false
        .structSpriteEntry (   9,  -23), $00, SpriteSmall, $00E, 2, 1, false, false
        .structSpriteEntry (   9,  -31), $00, SpriteSmall, $00F, 2, 1, false, false
        .structSpriteEntry (  -7,  -15), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -23,  -15), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  -7,  -31), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -23,  -31), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry (  -9,  -38), $00, SpriteSmall, $056, 2, 2, false, true
        .structSpriteEntry ( -17,  -38), $00, SpriteSmall, $055, 2, 0, false, true
        .structSpriteEntry ( -17,  -54), $21, SpriteLarge, $045, 2, 2, false, false
        .structSpriteEntry (  -1,  -54), $00, SpriteSmall, $047, 2, 2, false, false
        ANIM_RECORD_END

      _Record06
        ANIM_RECORD 1
        .structSpriteEntry (  -5,  -42), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry (  -5,  -44), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry (  -5,  -52), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry (  -9,  -39), $00, SpriteSmall, $097, 2, 0, false, false
        .structSpriteEntry (  -9,  -47), $00, SpriteSmall, $087, 2, 0, false, false
        .structSpriteEntry (  -1,  -31), $21, SpriteLarge, $0A8, 2, 0, false, false
        .structSpriteEntry (  -1,  -47), $21, SpriteLarge, $088, 2, 0, false, false
        .structSpriteEntry (   1,  -39), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (  -7,  -39), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -15,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry ( -23,  -39), $00, SpriteSmall, $00B, 2, 1, false, false
        .structSpriteEntry (   9,   -7), $00, SpriteSmall, $00C, 2, 1, false, false
        .structSpriteEntry (   9,  -15), $00, SpriteSmall, $00D, 2, 1, false, false
        .structSpriteEntry (   9,  -23), $00, SpriteSmall, $00E, 2, 1, false, false
        .structSpriteEntry (   9,  -31), $00, SpriteSmall, $00F, 2, 1, false, false
        .structSpriteEntry (  -7,  -15), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -23,  -15), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  -7,  -31), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -23,  -31), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -17,  -54), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry ( -17,  -38), $00, SpriteSmall, $050, 2, 0, false, true
        .structSpriteEntry (  -9,  -38), $00, SpriteSmall, $051, 2, 2, false, true
        ANIM_RECORD_END

      _Record07
        ANIM_RECORD 1
        .structSpriteEntry (  -4,  -41), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry (  -4,  -45), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry (  -4,  -52), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry (  -9,  -39), $00, SpriteSmall, $097, 2, 0, false, false
        .structSpriteEntry (  -9,  -47), $00, SpriteSmall, $087, 2, 0, false, false
        .structSpriteEntry (  -1,  -31), $21, SpriteLarge, $0A8, 2, 0, false, false
        .structSpriteEntry (  -1,  -47), $21, SpriteLarge, $088, 2, 0, false, false
        .structSpriteEntry (   1,  -39), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (  -7,  -39), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -15,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry ( -23,  -39), $00, SpriteSmall, $00B, 2, 1, false, false
        .structSpriteEntry (   9,   -7), $00, SpriteSmall, $00C, 2, 1, false, false
        .structSpriteEntry (   9,  -15), $00, SpriteSmall, $00D, 2, 1, false, false
        .structSpriteEntry (   9,  -23), $00, SpriteSmall, $00E, 2, 1, false, false
        .structSpriteEntry (   9,  -31), $00, SpriteSmall, $00F, 2, 1, false, false
        .structSpriteEntry (  -7,  -15), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -23,  -15), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  -7,  -31), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -23,  -31), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry ( -17,  -38), $00, SpriteSmall, $050, 2, 0, false, true
        .structSpriteEntry (  -9,  -38), $00, SpriteSmall, $051, 2, 2, false, true
        .structSpriteEntry ( -17,  -54), $21, SpriteLarge, $040, 2, 2, false, false
        ANIM_RECORD_END

      _Record08
        ANIM_RECORD 1
        .structSpriteEntry (   0,  -47), $00, SpriteSmall, $04C, 2, 2, false, true
        .structSpriteEntry (  -8,  -47), $00, SpriteSmall, $04B, 2, 2, false, true
        .structSpriteEntry ( -16,  -47), $00, SpriteSmall, $04A, 2, 2, false, true
        .structSpriteEntry (  -3,  -41), $00, SpriteSmall, $057, 2, 2, false, true
        .structSpriteEntry (   1,  -49), $00, SpriteSmall, $059, 2, 2, false, false
        .structSpriteEntry (   1,  -57), $00, SpriteSmall, $049, 2, 2, false, false
        .structSpriteEntry ( -13,  -59), $21, SpriteLarge, $043, 2, 2, false, true
        .structSpriteEntry ( -13,  -43), $00, SpriteSmall, $052, 2, 2, false, true
        .structSpriteEntry ( -12,  -39), $00, SpriteSmall, $09A, 2, 0, false, false
        .structSpriteEntry ( -12,  -47), $00, SpriteSmall, $08A, 2, 0, false, false
        .structSpriteEntry (  -4,  -31), $21, SpriteLarge, $0AB, 2, 0, false, false
        .structSpriteEntry (  -4,  -47), $21, SpriteLarge, $08B, 2, 0, false, false
        .structSpriteEntry (   1,  -39), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry (  -7,  -39), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -15,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry ( -23,  -39), $00, SpriteSmall, $00B, 2, 1, false, false
        .structSpriteEntry (   9,   -7), $00, SpriteSmall, $00C, 2, 1, false, false
        .structSpriteEntry (   9,  -15), $00, SpriteSmall, $00D, 2, 1, false, false
        .structSpriteEntry (   9,  -23), $00, SpriteSmall, $00E, 2, 1, false, false
        .structSpriteEntry (   9,  -31), $00, SpriteSmall, $00F, 2, 1, false, false
        .structSpriteEntry (  -7,  -15), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -23,  -15), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  -7,  -31), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -23,  -31), $21, SpriteLarge, $006, 2, 1, false, false
        ANIM_RECORD_END

      _Record09
        ANIM_RECORD 1
        .structSpriteEntry (  -8,  -42), $00, SpriteSmall, $059, 2, 2, true, false
        .structSpriteEntry (  -6,  -48), $00, SpriteSmall, $059, 2, 2, true, false
        .structSpriteEntry (  -3,  -56), $00, SpriteSmall, $059, 2, 2, true, false
        .structSpriteEntry (   1,  -39), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry ( -13,  -59), $21, SpriteLarge, $043, 2, 2, false, true
        .structSpriteEntry ( -13,  -43), $00, SpriteSmall, $052, 2, 2, false, true
        .structSpriteEntry ( -10,  -39), $00, SpriteSmall, $09D, 2, 0, false, false
        .structSpriteEntry ( -10,  -47), $00, SpriteSmall, $08D, 2, 0, false, false
        .structSpriteEntry (  -2,  -31), $21, SpriteLarge, $0AE, 2, 0, false, false
        .structSpriteEntry (  -2,  -47), $21, SpriteLarge, $08E, 2, 0, false, false
        .structSpriteEntry (  -7,  -39), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -15,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry ( -23,  -39), $00, SpriteSmall, $00B, 2, 1, false, false
        .structSpriteEntry (   9,   -7), $00, SpriteSmall, $00C, 2, 1, false, false
        .structSpriteEntry (   9,  -15), $00, SpriteSmall, $00D, 2, 1, false, false
        .structSpriteEntry (   9,  -23), $00, SpriteSmall, $00E, 2, 1, false, false
        .structSpriteEntry (   9,  -31), $00, SpriteSmall, $00F, 2, 1, false, false
        .structSpriteEntry (  -7,  -15), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -23,  -15), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  -7,  -31), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -23,  -31), $21, SpriteLarge, $006, 2, 1, false, false
        ANIM_RECORD_END

      _Record10
        ANIM_RECORD 1
        .structSpriteEntry (  -7,  -42), $00, SpriteSmall, $059, 2, 2, true, false
        .structSpriteEntry (  -5,  -48), $00, SpriteSmall, $059, 2, 2, true, false
        .structSpriteEntry (  -2,  -56), $00, SpriteSmall, $059, 2, 2, true, false
        .structSpriteEntry (   1,  -39), $00, SpriteSmall, $008, 2, 0, false, false
        .structSpriteEntry ( -13,  -59), $21, SpriteLarge, $043, 2, 2, false, true
        .structSpriteEntry ( -13,  -43), $00, SpriteSmall, $052, 2, 2, false, true
        .structSpriteEntry ( -10,  -39), $00, SpriteSmall, $09D, 2, 0, false, false
        .structSpriteEntry ( -10,  -47), $00, SpriteSmall, $08D, 2, 0, false, false
        .structSpriteEntry (  -2,  -31), $21, SpriteLarge, $0AE, 2, 0, false, false
        .structSpriteEntry (  -2,  -47), $21, SpriteLarge, $08E, 2, 0, false, false
        .structSpriteEntry (  -7,  -39), $00, SpriteSmall, $009, 2, 1, false, false
        .structSpriteEntry ( -15,  -39), $00, SpriteSmall, $00A, 2, 1, false, false
        .structSpriteEntry ( -23,  -39), $00, SpriteSmall, $00B, 2, 1, false, false
        .structSpriteEntry (   9,   -7), $00, SpriteSmall, $00C, 2, 1, false, false
        .structSpriteEntry (   9,  -15), $00, SpriteSmall, $00D, 2, 1, false, false
        .structSpriteEntry (   9,  -23), $00, SpriteSmall, $00E, 2, 1, false, false
        .structSpriteEntry (   9,  -31), $00, SpriteSmall, $00F, 2, 1, false, false
        .structSpriteEntry (  -7,  -15), $21, SpriteLarge, $000, 2, 1, false, false
        .structSpriteEntry ( -23,  -15), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (  -7,  -31), $21, SpriteLarge, $004, 2, 1, false, false
        .structSpriteEntry ( -23,  -31), $21, SpriteLarge, $006, 2, 1, false, false
        ANIM_RECORD_END

      _Record11
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (   4,  -16), $00, SpriteSmall, $04C, 2, 2, false, true
        .structSpriteEntry (  -4,  -16), $00, SpriteSmall, $04B, 2, 2, false, true
        .structSpriteEntry ( -12,  -16), $00, SpriteSmall, $04A, 2, 2, false, true
        ANIM_RECORD_END

      _Record12
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (   4,  -16), $00, SpriteSmall, $05C, 2, 2, false, false
        .structSpriteEntry (  -4,  -16), $00, SpriteSmall, $05B, 2, 2, false, false
        .structSpriteEntry ( -12,  -16), $00, SpriteSmall, $05A, 2, 2, false, false
        ANIM_RECORD_END

      _Record13
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (   4,  -16), $00, SpriteSmall, $04C, 2, 2, false, false
        .structSpriteEntry (  -4,  -16), $00, SpriteSmall, $04B, 2, 2, false, false
        .structSpriteEntry ( -12,  -16), $00, SpriteSmall, $04A, 2, 2, false, false
        ANIM_RECORD_END

      aBattleAnimationFramesUnknown06 ; 98/EB33

        ; Frame table of entries 6, 9: slices of the class sheet per frame.

        .word _Frame00 - aBattleAnimationFramesUnknown06
        .word _Frame01 - aBattleAnimationFramesUnknown06
        .word _Frame02 - aBattleAnimationFramesUnknown06
        .word _Frame03 - aBattleAnimationFramesUnknown06
        .word _Frame04 - aBattleAnimationFramesUnknown06
        .word _Frame05 - aBattleAnimationFramesUnknown06
        .word _Frame06 - aBattleAnimationFramesUnknown06
        .word _Frame07 - aBattleAnimationFramesUnknown06
        .word _Frame08 - aBattleAnimationFramesUnknown06
        .word _Frame09 - aBattleAnimationFramesUnknown06
        .word _Frame10 - aBattleAnimationFramesUnknown06

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
        ANIM_TILE_ROW $0D00, $0100
        ANIM_TILES_END

      _Frame09
        ANIM_TILES
        ANIM_TILE_ROW $0E00, $0100
        ANIM_TILE_ROW $0F00, $0100
        ANIM_TILES_END

      _Frame10
        ANIM_TILES
        ANIM_TILE_ROW $1000, $0100
        ANIM_TILE_ROW $1100, $0100
        ANIM_TILES_END

      aBattleAnimationSequencesUnknown06 ; 98/EBAC

        ; Sequence data of entry 6 of aBattleAnimationFrameTables; nothing selects it (no lookup
        ; record has a first ID that leads here) and no sheet in aBattleAnimationSheets is the
        ; size its frames need: probably left over. Frames: aBattleAnimationFramesUnknown06.

        .word _Index - aBattleAnimationSequencesUnknown06, _Records - aBattleAnimationSequencesUnknown06

      _Index
        .word _Sequence00 - aBattleAnimationSequencesUnknown06
        .word _Sequence01 - aBattleAnimationSequencesUnknown06
        .word _Sequence02 - aBattleAnimationSequencesUnknown06
        .word _Sequence03 - aBattleAnimationSequencesUnknown06
        .word _Sequence04 - aBattleAnimationSequencesUnknown06
        .word _Sequence05 - aBattleAnimationSequencesUnknown06
        .word _Sequence06 - aBattleAnimationSequencesUnknown06
        .word _Sequence07 - aBattleAnimationSequencesUnknown06
        .word _Sequence08 - aBattleAnimationSequencesUnknown06
        .word _Sequence09 - aBattleAnimationSequencesUnknown06
        .word _Sequence10 - aBattleAnimationSequencesUnknown06
        .word _Sequence11 - aBattleAnimationSequencesUnknown06
        .word _Sequence12 - aBattleAnimationSequencesUnknown06
        .word _Sequence13 - aBattleAnimationSequencesUnknown06
        .word _Sequence14 - aBattleAnimationSequencesUnknown06
        .word _Sequence15 - aBattleAnimationSequencesUnknown06
        .word _Sequence16 - aBattleAnimationSequencesUnknown06
        .word _Sequence17 - aBattleAnimationSequencesUnknown06
        .word _Sequence18 - aBattleAnimationSequencesUnknown06
        .word _Sequence19 - aBattleAnimationSequencesUnknown06
        .word _Sequence20 - aBattleAnimationSequencesUnknown06
        .word _Sequence21 - aBattleAnimationSequencesUnknown06

      _Records
        .word aBattleAnimationSequencesUnknown09._Record00 - aBattleAnimationSequencesUnknown06
        .word aBattleAnimationSequencesUnknown09._Record01 - aBattleAnimationSequencesUnknown06
        .word aBattleAnimationSequencesUnknown09._Record02 - aBattleAnimationSequencesUnknown06
        .word aBattleAnimationSequencesUnknown09._Record03 - aBattleAnimationSequencesUnknown06
        .word aBattleAnimationSequencesUnknown09._Record04 - aBattleAnimationSequencesUnknown06
        .word aBattleAnimationSequencesUnknown09._Record05 - aBattleAnimationSequencesUnknown06
        .word aBattleAnimationSequencesUnknown09._Record06 - aBattleAnimationSequencesUnknown06
        .word aBattleAnimationSequencesUnknown09._Record07 - aBattleAnimationSequencesUnknown06
        .word aBattleAnimationSequencesUnknown09._Record08 - aBattleAnimationSequencesUnknown06
        .word aBattleAnimationSequencesUnknown09._Record09 - aBattleAnimationSequencesUnknown06
        .word aBattleAnimationSequencesUnknown09._Record10 - aBattleAnimationSequencesUnknown06
        .word aBattleAnimationSequencesUnknown09._Record11 - aBattleAnimationSequencesUnknown06
        .word aBattleAnimationSequencesUnknown09._Record12 - aBattleAnimationSequencesUnknown06
        .word aBattleAnimationSequencesUnknown09._Record13 - aBattleAnimationSequencesUnknown06
        .word aBattleAnimationSequencesUnknown09._Record14 - aBattleAnimationSequencesUnknown06
        .word aBattleAnimationSequencesUnknown09._Record15 - aBattleAnimationSequencesUnknown06
        .word aBattleAnimationSequencesUnknown09._Record16 - aBattleAnimationSequencesUnknown06
        .word aBattleAnimationSequencesUnknown09._Record17 - aBattleAnimationSequencesUnknown06
        .word aBattleAnimationSequencesUnknown09._Record18 - aBattleAnimationSequencesUnknown06
        .word aBattleAnimationSequencesUnknown09._Record19 - aBattleAnimationSequencesUnknown06
        .word aBattleAnimationSequencesUnknown09._Record20 - aBattleAnimationSequencesUnknown06
        .word aBattleAnimationSequencesUnknown09._Record21 - aBattleAnimationSequencesUnknown06
        .word aBattleAnimationSequencesUnknown09._Record22 - aBattleAnimationSequencesUnknown06
        .word aBattleAnimationSequencesUnknown09._Record23 - aBattleAnimationSequencesUnknown06
        .word aBattleAnimationSequencesUnknown09._Record24 - aBattleAnimationSequencesUnknown06
        .word aBattleAnimationSequencesUnknown09._Record25 - aBattleAnimationSequencesUnknown06
        .word aBattleAnimationSequencesUnknown09._Record26 - aBattleAnimationSequencesUnknown06
        .word aBattleAnimationSequencesUnknown09._Record27 - aBattleAnimationSequencesUnknown06
        .word aBattleAnimationSequencesUnknown09._Record28 - aBattleAnimationSequencesUnknown06
        .word aBattleAnimationSequencesUnknown09._Record29 - aBattleAnimationSequencesUnknown06
        .word aBattleAnimationSequencesUnknown09._Record30 - aBattleAnimationSequencesUnknown06

      _Sequence00
        ANIM_CLEAR_BUSY
        ANIM_STEP 1, 2
        ANIM_HOLD

      _Sequence01
        ANIM_CLEAR_BUSY
        ANIM_STEP 1, 2
        ANIM_STEP 20, 6
        ANIM_STEP 9, 4
        ANIM_STEP 10, 1
        ANIM_CMD_F4 1
        ANIM_HOLD

      _Sequence02
        ANIM_CLEAR_BUSY
        ANIM_STEP 10, 4
        ANIM_STEP 2, 2
        ANIM_STEP 3, 2
        ANIM_STEP 1, 6
        ANIM_STEP 20, 3
        ANIM_STEP 9, 4
        ANIM_STEP 10, 1
        ANIM_CMD_F4 1
        ANIM_HOLD

      _Sequence03
        ANIM_CLEAR_BUSY
        ANIM_CMD_EB
        ANIM_STEP 2, 12
        ANIM_STEP 3, 7
        ANIM_STEP 4, 7
        ANIM_STEP 5, 12
        ANIM_STEP 6, 7
        ANIM_STEP 7, 7
        ANIM_RESTART
        ANIM_HOLD

      _Sequence04
        ANIM_STEP 20, 5
        ANIM_STEP 11, 2
        ANIM_STEP 12, 3
        ANIM_CMD_EE
        ANIM_STEP 13, 10
        ANIM_STEP 8, 4
        ANIM_CMD_F1
        ANIM_SOUND 0
        ANIM_STEP 18, 16
        ANIM_CMD_F3
        ANIM_CLEAR_BUSY
        ANIM_CMD_ED 2
        ANIM_HOLD

      _Sequence05
        ANIM_CLEAR_BUSY
        ANIM_STEP 18, 6
        ANIM_STEP 21, 4
        ANIM_STEP 9, 5
        ANIM_STEP 10, 1
        ANIM_CMD_F4 1
        ANIM_HOLD

      _Sequence06
        ANIM_CLEAR_BUSY
        ANIM_STEP 17, 4
        ANIM_STEP 21, 4
        ANIM_STEP 9, 1
        ANIM_CMD_F4 1
        ANIM_HOLD

      _Sequence07
        ANIM_STEP 11, 3
        ANIM_STEP 12, 3
        ANIM_STEP 13, 3
        ANIM_CMD_EE
        ANIM_STEP 13, 10
        ANIM_STEP 8, 4
        ANIM_CMD_F1
        ANIM_SOUND 0
        ANIM_STEP 18, 16
        ANIM_CMD_F3
        ANIM_CMD_ED 2
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence08
        ANIM_STEP 21, 3
        ANIM_STEP 20, 2
        ANIM_STEP 11, 3
        ANIM_STEP 12, 3
        ANIM_CMD_EE
        ANIM_STEP 13, 15
        ANIM_STEP 8, 3
        ANIM_CMD_F1
        ANIM_SOUND 0
        ANIM_STEP 18, 16
        ANIM_CMD_ED 2
        ANIM_CMD_F3
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence09
        ANIM_STEP 21, 4
        ANIM_STEP 9, 5
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence10
        ANIM_CLEAR_BUSY
        ANIM_STEP 10, 10
        ANIM_STEP 10, 2
        ANIM_STEP 11, 2
        ANIM_STEP 12, 2
        ANIM_CMD_EE
        ANIM_STEP 13, 16
        ANIM_STEP 8, 2
        ANIM_CMD_F1
        ANIM_SOUND 0
        ANIM_STEP 14, 2
        ANIM_STEP 15, 2
        ANIM_STEP 16, 2
        ANIM_STEP 17, 16
        ANIM_CMD_ED 3
        ANIM_CMD_F3
        ANIM_HOLD

      _Sequence11
        ANIM_STEP 21, 10
        ANIM_STEP 13, 19
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence12
        ANIM_STEP 17, 9
        ANIM_STEP 21, 3
        ANIM_STEP 20, 3
        ANIM_STEP 11, 3
        ANIM_STEP 13, 5
        ANIM_CMD_EE
        ANIM_STEP 13, 13
        ANIM_STEP 8, 3
        ANIM_CMD_F1
        ANIM_SOUND 0
        ANIM_STEP 18, 16
        ANIM_CMD_ED 2
        ANIM_CMD_F3
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence13
        ANIM_STEP 21, 4
        ANIM_STEP 9, 5
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence14
        ANIM_STEP 21, 4
        ANIM_STEP 9, 5
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence15
        ANIM_STEP 10, 5
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence16
        ANIM_STEP 18, 3
        ANIM_STEP 21, 3
        ANIM_STEP 20, 3
        ANIM_STEP 9, 3
        ANIM_STEP 10, 5
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence17
        ANIM_STEP 17, 3
        ANIM_STEP 21, 3
        ANIM_STEP 20, 2
        ANIM_STEP 9, 4
        ANIM_STEP 10, 10
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence18
        ANIM_CLEAR_BUSY
        ANIM_STEP 6, 8
        ANIM_STEP 7, 8
        ANIM_HOLD

      _Sequence19
        ANIM_STEP 10, 3
        ANIM_STEP 11, 2
        ANIM_STEP 12, 2
        ANIM_STEP 13, 2
        ANIM_SOUND 32
        ANIM_CMD_F0 3
        ANIM_STEP 13, 2
        ANIM_CMD_F4 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence20
        ANIM_STEP 13, 2
        ANIM_STEP 19, 3
        ANIM_STEP 18, 3
        ANIM_STEP 18, 2
        ANIM_CMD_F4 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence21
        ANIM_STEP 18, 4
        ANIM_STEP 4, 4
        ANIM_STEP 1, 4
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      aBattleAnimationSequencesUnknown09 ; 98/ED76

        ; Sequence data of entry 9 of aBattleAnimationFrameTables; nothing selects it (no lookup
        ; record has a first ID that leads here) and no sheet in aBattleAnimationSheets is the
        ; size its frames need: probably left over. Frames: aBattleAnimationFramesUnknown06.

        .word _Index - aBattleAnimationSequencesUnknown09, _Records - aBattleAnimationSequencesUnknown09

      _Index
        .word _Sequence00 - aBattleAnimationSequencesUnknown09
        .word _Sequence01 - aBattleAnimationSequencesUnknown09
        .word _Sequence02 - aBattleAnimationSequencesUnknown09
        .word _Sequence03 - aBattleAnimationSequencesUnknown09
        .word _Sequence04 - aBattleAnimationSequencesUnknown09
        .word _Sequence05 - aBattleAnimationSequencesUnknown09
        .word _Sequence06 - aBattleAnimationSequencesUnknown09
        .word _Sequence07 - aBattleAnimationSequencesUnknown09

      _Records
        .word _Record00 - aBattleAnimationSequencesUnknown09
        .word _Record01 - aBattleAnimationSequencesUnknown09
        .word _Record02 - aBattleAnimationSequencesUnknown09
        .word _Record03 - aBattleAnimationSequencesUnknown09
        .word _Record04 - aBattleAnimationSequencesUnknown09
        .word _Record05 - aBattleAnimationSequencesUnknown09
        .word _Record06 - aBattleAnimationSequencesUnknown09
        .word _Record07 - aBattleAnimationSequencesUnknown09
        .word _Record08 - aBattleAnimationSequencesUnknown09
        .word _Record09 - aBattleAnimationSequencesUnknown09
        .word _Record10 - aBattleAnimationSequencesUnknown09
        .word _Record11 - aBattleAnimationSequencesUnknown09
        .word _Record12 - aBattleAnimationSequencesUnknown09
        .word _Record13 - aBattleAnimationSequencesUnknown09
        .word _Record14 - aBattleAnimationSequencesUnknown09
        .word _Record15 - aBattleAnimationSequencesUnknown09
        .word _Record16 - aBattleAnimationSequencesUnknown09
        .word _Record17 - aBattleAnimationSequencesUnknown09
        .word _Record18 - aBattleAnimationSequencesUnknown09
        .word _Record19 - aBattleAnimationSequencesUnknown09
        .word _Record20 - aBattleAnimationSequencesUnknown09
        .word _Record21 - aBattleAnimationSequencesUnknown09
        .word _Record22 - aBattleAnimationSequencesUnknown09
        .word _Record23 - aBattleAnimationSequencesUnknown09
        .word _Record24 - aBattleAnimationSequencesUnknown09
        .word _Record25 - aBattleAnimationSequencesUnknown09
        .word _Record26 - aBattleAnimationSequencesUnknown09
        .word _Record27 - aBattleAnimationSequencesUnknown09
        .word _Record28 - aBattleAnimationSequencesUnknown09
        .word _Record29 - aBattleAnimationSequencesUnknown09
        .word _Record30 - aBattleAnimationSequencesUnknown09

      _Sequence00
        ANIM_CLEAR_BUSY
        ANIM_STEP 1, 16
        ANIM_HOLD

      _Sequence01
        ANIM_STEP 20, 7
        ANIM_STEP 9, 7
        ANIM_STEP 10, 1
        ANIM_CMD_F4 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence02
        ANIM_STEP 10, 4
        ANIM_STEP 2, 4
        ANIM_STEP 3, 4
        ANIM_STEP 1, 6
        ANIM_STEP 20, 4
        ANIM_STEP 9, 4
        ANIM_STEP 10, 1
        ANIM_CMD_F4 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence03
        ANIM_STEP 10, 0
        ANIM_STEP 11, 2
        ANIM_STEP 12, 2
        ANIM_STEP 13, 2
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence04
        ANIM_STEP 13, 2
        ANIM_STEP 19, 5
        ANIM_CMD_EE
        ANIM_CMD_EF 135
        ANIM_STEP 23, 6
        ANIM_CMD_F4 1
        ANIM_STEP 2, 5
        ANIM_STEP 10, 18
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence05
        ANIM_STEP 20, 7
        ANIM_STEP 9, 3
        ANIM_STEP 10, 11
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence06
        ANIM_STEP 23, 16
        ANIM_STEP 4, 9
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence07
        ANIM_CMD_EB
        ANIM_STEP 24, 1
        ANIM_STEP 25, 1
        ANIM_STEP 26, 1
        ANIM_STEP 27, 1
        ANIM_STEP 28, 1
        ANIM_STEP 29, 1
        ANIM_STEP 30, 1
        ANIM_RESTART
        ANIM_CLEAR_BUSY
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
        .structSpriteEntry (  -1,  -25), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry ( -19,  -44), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry ( -19,  -28), $21, SpriteLarge, $04A, 2, 2, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   4,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   4,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   4,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record02
        ANIM_RECORD 1
        .structSpriteEntry (  -2,  -24), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   4,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   4,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   4,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -17,  -43), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry ( -17,  -27), $21, SpriteLarge, $04A, 2, 2, false, false
        ANIM_RECORD_END

      _Record03
        ANIM_RECORD 2
        .structSpriteEntry (  -2,  -25), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   4,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   4,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   4,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -17,  -44), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry ( -17,  -28), $21, SpriteLarge, $04A, 2, 2, false, false
        ANIM_RECORD_END

      _Record04
        ANIM_RECORD 3
        .structSpriteEntry (  -2,  -25), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   4,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   4,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   4,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -17,  -44), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry ( -17,  -28), $21, SpriteLarge, $04A, 2, 2, false, false
        ANIM_RECORD_END

      _Record05
        ANIM_RECORD 4
        .structSpriteEntry (  -2,  -24), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   4,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   4,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   4,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -17,  -43), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry ( -17,  -27), $21, SpriteLarge, $04A, 2, 2, false, false
        ANIM_RECORD_END

      _Record06
        ANIM_RECORD 5
        .structSpriteEntry (  -2,  -25), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   4,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   4,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   4,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -17,  -44), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry ( -17,  -28), $21, SpriteLarge, $04A, 2, 2, false, false
        ANIM_RECORD_END

      _Record07
        ANIM_RECORD 6
        .structSpriteEntry (  -2,  -25), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   4,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   4,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   4,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -17,  -44), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry ( -17,  -28), $21, SpriteLarge, $04A, 2, 2, false, false
        ANIM_RECORD_END

      _Record08
        ANIM_RECORD 7
        .structSpriteEntry (  -7,  -41), $21, SpriteLarge, $042, 2, 2, true, true
        .structSpriteEntry (   9,  -41), $21, SpriteLarge, $040, 2, 2, true, true
        .structSpriteEntry (  -4,  -25), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   6,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   6,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   6,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   6,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -10,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -10,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record09
        ANIM_RECORD 8
        .structSpriteEntry ( -16,  -24), $21, SpriteLarge, $060, 2, 3, true, false
        .structSpriteEntry (  -2,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -18,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (  -2,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -18,  -31), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (  -5,  -39), $21, SpriteLarge, $042, 2, 2, false, true
        .structSpriteEntry ( -21,  -39), $21, SpriteLarge, $040, 2, 2, false, true
        ANIM_RECORD_END

      _Record10
        ANIM_RECORD 8
        .structSpriteEntry ( -17,  -25), $21, SpriteLarge, $060, 2, 3, true, false
        .structSpriteEntry (  -2,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -18,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (  -2,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -18,  -31), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (  -5,  -39), $21, SpriteLarge, $042, 2, 2, false, true
        .structSpriteEntry ( -21,  -39), $21, SpriteLarge, $040, 2, 2, false, true
        ANIM_RECORD_END

      _Record11
        ANIM_RECORD 8
        .structSpriteEntry (  -6,  -35), $21, SpriteLarge, $04E, 2, 2, true, false
        .structSpriteEntry (  -6,  -51), $21, SpriteLarge, $04C, 2, 2, true, false
        .structSpriteEntry ( -17,  -25), $21, SpriteLarge, $060, 2, 3, true, false
        .structSpriteEntry (  -2,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -18,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (  -2,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -18,  -31), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record12
        ANIM_RECORD 8
        .structSpriteEntry (  -1,  -35), $21, SpriteLarge, $04E, 2, 2, false, false
        .structSpriteEntry (  -1,  -51), $21, SpriteLarge, $04C, 2, 2, false, false
        .structSpriteEntry ( -17,  -25), $21, SpriteLarge, $060, 2, 3, true, false
        .structSpriteEntry (  -2,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -18,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (  -2,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -18,  -31), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record13
        ANIM_RECORD 8
        .structSpriteEntry (  -2,  -40), $21, SpriteLarge, $042, 2, 2, true, true
        .structSpriteEntry (  14,  -40), $21, SpriteLarge, $040, 2, 2, true, true
        .structSpriteEntry ( -17,  -25), $21, SpriteLarge, $060, 2, 3, true, false
        .structSpriteEntry (  -2,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -18,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (  -2,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -18,  -31), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record14
        ANIM_RECORD 9
        .structSpriteEntry (  -7,  -47), $00, SpriteSmall, $0E4, 2, 2, false, false
        .structSpriteEntry ( -15,  -47), $00, SpriteSmall, $0E3, 2, 2, false, false
        .structSpriteEntry ( -23,  -47), $00, SpriteSmall, $0E2, 2, 2, false, false
        .structSpriteEntry ( -31,  -47), $00, SpriteSmall, $0E1, 2, 2, false, false
        .structSpriteEntry (   2,  -26), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   0,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -16,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   0,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -16,  -31), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record15
        ANIM_RECORD 9
        .structSpriteEntry ( -38,  -37), $00, SpriteSmall, $0E0, 2, 2, false, false
        .structSpriteEntry ( -22,  -45), $00, SpriteSmall, $0D2, 2, 2, false, false
        .structSpriteEntry ( -30,  -45), $00, SpriteSmall, $0D1, 2, 2, false, false
        .structSpriteEntry ( -38,  -45), $00, SpriteSmall, $0D0, 2, 2, false, false
        .structSpriteEntry (   2,  -26), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   0,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -16,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   0,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -16,  -31), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record16
        ANIM_RECORD 9
        .structSpriteEntry ( -24,   -8), $00, SpriteSmall, $0C2, 2, 2, false, false
        .structSpriteEntry ( -40,  -16), $21, SpriteLarge, $0B0, 2, 2, false, false
        .structSpriteEntry ( -40,  -24), $00, SpriteSmall, $0A0, 2, 2, false, false
        .structSpriteEntry ( -40,  -32), $00, SpriteSmall, $090, 2, 2, false, false
        .structSpriteEntry ( -40,  -40), $00, SpriteSmall, $080, 2, 2, false, false
        .structSpriteEntry (   2,  -26), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   0,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -16,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   0,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -16,  -31), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record17
        ANIM_RECORD 9
        .structSpriteEntry ( -18,  -16), $21, SpriteLarge, $042, 2, 2, false, false
        .structSpriteEntry ( -34,  -16), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry (   2,  -26), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   0,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -16,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   0,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -16,  -31), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record18
        ANIM_RECORD 10
        .structSpriteEntry ( -19,  -28), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry ( -35,  -28), $21, SpriteLarge, $044, 2, 2, false, false
        .structSpriteEntry (   2,  -23), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   0,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -16,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   0,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -16,  -31), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record19
        ANIM_RECORD 7
        .structSpriteEntry (  -4,  -25), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   6,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   6,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   6,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   6,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -10,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -10,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (  -6,  -37), $21, SpriteLarge, $04E, 2, 2, false, false
        .structSpriteEntry (  -6,  -53), $21, SpriteLarge, $04C, 2, 2, false, false
        ANIM_RECORD_END

      _Record20
        ANIM_RECORD 2
        .structSpriteEntry (  -1,  -25), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   4,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   4,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   4,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -16,  -44), $21, SpriteLarge, $048, 2, 2, false, false
        .structSpriteEntry ( -16,  -28), $21, SpriteLarge, $04A, 2, 2, false, false
        ANIM_RECORD_END

      _Record21
        ANIM_RECORD 2
        .structSpriteEntry (  -1,  -25), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   4,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   4,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   4,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -11,  -29), $21, SpriteLarge, $046, 2, 2, false, false
        .structSpriteEntry ( -27,  -29), $21, SpriteLarge, $044, 2, 2, false, false
        ANIM_RECORD_END

      _Record22
        ANIM_RECORD 2
        .structSpriteEntry (  -1,  -25), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   4,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   4,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   4,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -13,  -22), $21, SpriteLarge, $042, 2, 2, false, false
        .structSpriteEntry ( -29,  -22), $21, SpriteLarge, $040, 2, 2, false, false
        ANIM_RECORD_END

      _Record23
        ANIM_RECORD 10
        .structSpriteEntry (   2,  -20), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   0,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -16,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   0,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -16,  -31), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record24
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (  -3,  -19), $21, SpriteLarge, $042, 2, 2, false, false
        .structSpriteEntry ( -19,  -19), $21, SpriteLarge, $040, 2, 2, false, false
        ANIM_RECORD_END

      _Record25
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry ( -10,  -25), $21, SpriteLarge, $04A, 2, 2, false, true
        .structSpriteEntry ( -10,   -9), $21, SpriteLarge, $048, 2, 2, false, true
        ANIM_RECORD_END

      _Record26
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (  -6,  -25), $21, SpriteLarge, $04A, 2, 2, true, true
        .structSpriteEntry (  -6,   -9), $21, SpriteLarge, $048, 2, 2, true, true
        ANIM_RECORD_END

      _Record27
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry ( -11,  -19), $21, SpriteLarge, $042, 2, 2, true, false
        .structSpriteEntry (   5,  -19), $21, SpriteLarge, $040, 2, 2, true, false
        ANIM_RECORD_END

      _Record28
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry ( -12,  -24), $21, SpriteLarge, $046, 2, 2, true, false
        .structSpriteEntry (   4,  -24), $21, SpriteLarge, $044, 2, 2, true, false
        ANIM_RECORD_END

      _Record29
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (  -7,  -20), $21, SpriteLarge, $04E, 2, 2, false, false
        .structSpriteEntry (  -7,  -36), $21, SpriteLarge, $04C, 2, 2, false, false
        ANIM_RECORD_END

      _Record30
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (  -9,  -20), $21, SpriteLarge, $04E, 2, 2, true, false
        .structSpriteEntry (  -9,  -36), $21, SpriteLarge, $04C, 2, 2, true, false
        ANIM_RECORD_END

      aBattleAnimationFramesUnknown07 ; 98/F2A3

        ; Frame table of entries 7, 8: slices of the class sheet per frame.

        .word _Frame00 - aBattleAnimationFramesUnknown07
        .word _Frame01 - aBattleAnimationFramesUnknown07
        .word _Frame02 - aBattleAnimationFramesUnknown07
        .word _Frame03 - aBattleAnimationFramesUnknown07
        .word _Frame04 - aBattleAnimationFramesUnknown07
        .word _Frame05 - aBattleAnimationFramesUnknown07
        .word _Frame06 - aBattleAnimationFramesUnknown07
        .word _Frame07 - aBattleAnimationFramesUnknown07
        .word _Frame08 - aBattleAnimationFramesUnknown07
        .word _Frame09 - aBattleAnimationFramesUnknown07
        .word _Frame10 - aBattleAnimationFramesUnknown07
        .word _Frame11 - aBattleAnimationFramesUnknown07

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
        ANIM_TILE_ROW $0D00, $0100
        ANIM_TILES_END

      _Frame09
        ANIM_TILES
        ANIM_TILE_ROW $0E00, $0100
        ANIM_TILE_ROW $0F00, $0100
        ANIM_TILES_END

      _Frame10
        ANIM_TILES
        ANIM_TILE_ROW $1000, $0100
        ANIM_TILE_ROW $1100, $0080
        ANIM_TILES_END

      _Frame11
        ANIM_TILES
        ANIM_TILE_ROW $1180, $0100
        ANIM_TILE_ROW $1280, $0080
        ANIM_TILES_END

      aBattleAnimationSequencesUnknown07 ; 98/F327

        ; Sequence data of entry 7 of aBattleAnimationFrameTables; nothing selects it (no lookup
        ; record has a first ID that leads here) and no sheet in aBattleAnimationSheets is the
        ; size its frames need: probably left over. Frames: aBattleAnimationFramesUnknown07.

        .word _Index - aBattleAnimationSequencesUnknown07, _Records - aBattleAnimationSequencesUnknown07

      _Index
        .word _Sequence00 - aBattleAnimationSequencesUnknown07
        .word _Sequence01 - aBattleAnimationSequencesUnknown07
        .word _Sequence02 - aBattleAnimationSequencesUnknown07
        .word _Sequence03 - aBattleAnimationSequencesUnknown07
        .word _Sequence04 - aBattleAnimationSequencesUnknown07
        .word _Sequence05 - aBattleAnimationSequencesUnknown07
        .word _Sequence06 - aBattleAnimationSequencesUnknown07
        .word _Sequence07 - aBattleAnimationSequencesUnknown07
        .word _Sequence08 - aBattleAnimationSequencesUnknown07
        .word _Sequence09 - aBattleAnimationSequencesUnknown07
        .word _Sequence10 - aBattleAnimationSequencesUnknown07
        .word _Sequence11 - aBattleAnimationSequencesUnknown07
        .word _Sequence12 - aBattleAnimationSequencesUnknown07
        .word _Sequence13 - aBattleAnimationSequencesUnknown07
        .word _Sequence14 - aBattleAnimationSequencesUnknown07
        .word _Sequence15 - aBattleAnimationSequencesUnknown07
        .word _Sequence16 - aBattleAnimationSequencesUnknown07

      _Records
        .word aBattleAnimationSequencesUnknown08._Record00 - aBattleAnimationSequencesUnknown07
        .word aBattleAnimationSequencesUnknown08._Record01 - aBattleAnimationSequencesUnknown07
        .word aBattleAnimationSequencesUnknown08._Record02 - aBattleAnimationSequencesUnknown07
        .word aBattleAnimationSequencesUnknown08._Record03 - aBattleAnimationSequencesUnknown07
        .word aBattleAnimationSequencesUnknown08._Record04 - aBattleAnimationSequencesUnknown07
        .word aBattleAnimationSequencesUnknown08._Record05 - aBattleAnimationSequencesUnknown07
        .word aBattleAnimationSequencesUnknown08._Record06 - aBattleAnimationSequencesUnknown07
        .word aBattleAnimationSequencesUnknown08._Record07 - aBattleAnimationSequencesUnknown07
        .word aBattleAnimationSequencesUnknown08._Record08 - aBattleAnimationSequencesUnknown07
        .word aBattleAnimationSequencesUnknown08._Record09 - aBattleAnimationSequencesUnknown07
        .word aBattleAnimationSequencesUnknown08._Record10 - aBattleAnimationSequencesUnknown07
        .word aBattleAnimationSequencesUnknown08._Record11 - aBattleAnimationSequencesUnknown07
        .word aBattleAnimationSequencesUnknown08._Record12 - aBattleAnimationSequencesUnknown07
        .word aBattleAnimationSequencesUnknown08._Record13 - aBattleAnimationSequencesUnknown07
        .word aBattleAnimationSequencesUnknown08._Record14 - aBattleAnimationSequencesUnknown07
        .word aBattleAnimationSequencesUnknown08._Record15 - aBattleAnimationSequencesUnknown07
        .word aBattleAnimationSequencesUnknown08._Record16 - aBattleAnimationSequencesUnknown07
        .word aBattleAnimationSequencesUnknown08._Record17 - aBattleAnimationSequencesUnknown07
        .word aBattleAnimationSequencesUnknown08._Record18 - aBattleAnimationSequencesUnknown07
        .word aBattleAnimationSequencesUnknown08._Record19 - aBattleAnimationSequencesUnknown07

      _Sequence00
        ANIM_STEP 1, 2
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence01
        ANIM_STEP 9, 5
        ANIM_STEP 8, 3
        ANIM_STEP 1, 3
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence02
        ANIM_CLEAR_BUSY
        ANIM_CMD_EB
        ANIM_STEP 2, 12
        ANIM_STEP 3, 7
        ANIM_STEP 4, 7
        ANIM_STEP 5, 12
        ANIM_STEP 6, 7
        ANIM_STEP 7, 7
        ANIM_RESTART
        ANIM_STEP 8, 8
        ANIM_HOLD

      _Sequence03
        ANIM_STEP 9, 16
        ANIM_CMD_EE
        ANIM_STEP 9, 5
        ANIM_STEP 10, 6
        ANIM_STEP 11, 5
        ANIM_SOUND 1
        ANIM_CMD_F1 4
        ANIM_STEP 11, 13
        ANIM_CMD_F3
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence04
        ANIM_STEP 10, 5
        ANIM_STEP 9, 5
        ANIM_STEP 12, 14
        ANIM_CMD_EE
        ANIM_STEP 12, 6
        ANIM_STEP 10, 5
        ANIM_STEP 11, 5
        ANIM_SOUND 1
        ANIM_CMD_F1
        ANIM_STEP 11, 12
        ANIM_CMD_F3
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence05
        ANIM_STEP 8, 5
        ANIM_STEP 9, 6
        ANIM_STEP 12, 1
        ANIM_CMD_F4 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence06
        ANIM_STEP 1, 5
        ANIM_STEP 8, 5
        ANIM_STEP 14, 6
        ANIM_STEP 13, 48
        ANIM_STEP 19, 5
        ANIM_CMD_EE
        ANIM_CMD_EF 7
        ANIM_STEP 15, 64
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence07
        ANIM_STEP 16, 16
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence08
        ANIM_STEP 16, 16
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence09
        ANIM_STEP 17, 16
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence10
        ANIM_STEP 18, 16
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence11
        ANIM_STEP 18, 16
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence12
        ANIM_STEP 12, 8
        ANIM_CMD_EE
        ANIM_STEP 12, 6
        ANIM_STEP 10, 5
        ANIM_STEP 11, 5
        ANIM_CMD_F1
        ANIM_SOUND 1
        ANIM_STEP 11, 12
        ANIM_CMD_F3
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence13
        ANIM_STEP 13, 11
        ANIM_STEP 19, 5
        ANIM_CMD_EE
        ANIM_CMD_EF 7
        ANIM_STEP 15, 64
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence14
        ANIM_CLEAR_BUSY
        ANIM_STEP 6, 8
        ANIM_STEP 7, 8
        ANIM_HOLD

      _Sequence15
        ANIM_STEP 10, 5
        ANIM_STEP 9, 3
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence16
        ANIM_STEP 8, 5
        ANIM_STEP 9, 6
        ANIM_STEP 12, 5
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      aBattleAnimationSequencesUnknown08 ; 98/F447

        ; Sequence data of entry 8 of aBattleAnimationFrameTables; nothing selects it (no lookup
        ; record has a first ID that leads here) and no sheet in aBattleAnimationSheets is the
        ; size its frames need: probably left over. Frames: aBattleAnimationFramesUnknown07.

        .word _Index - aBattleAnimationSequencesUnknown08, _Records - aBattleAnimationSequencesUnknown08

      _Index
        .word _Sequence00 - aBattleAnimationSequencesUnknown08
        .word _Sequence01 - aBattleAnimationSequencesUnknown08
        .word _Sequence02 - aBattleAnimationSequencesUnknown08
        .word _Sequence03 - aBattleAnimationSequencesUnknown08
        .word _Sequence04 - aBattleAnimationSequencesUnknown08
        .word _Sequence05 - aBattleAnimationSequencesUnknown08
        .word _Sequence06 - aBattleAnimationSequencesUnknown08
        .word _Sequence07 - aBattleAnimationSequencesUnknown08
        .word _Sequence08 - aBattleAnimationSequencesUnknown08
        .word _Sequence09 - aBattleAnimationSequencesUnknown08
        .word _Sequence10 - aBattleAnimationSequencesUnknown08
        .word _Sequence11 - aBattleAnimationSequencesUnknown08
        .word _Sequence12 - aBattleAnimationSequencesUnknown08
        .word _Sequence12 - aBattleAnimationSequencesUnknown08
        .word _Sequence14 - aBattleAnimationSequencesUnknown08

      _Records
        .word _Record00 - aBattleAnimationSequencesUnknown08
        .word _Record01 - aBattleAnimationSequencesUnknown08
        .word _Record02 - aBattleAnimationSequencesUnknown08
        .word _Record03 - aBattleAnimationSequencesUnknown08
        .word _Record04 - aBattleAnimationSequencesUnknown08
        .word _Record05 - aBattleAnimationSequencesUnknown08
        .word _Record06 - aBattleAnimationSequencesUnknown08
        .word _Record07 - aBattleAnimationSequencesUnknown08
        .word _Record08 - aBattleAnimationSequencesUnknown08
        .word _Record09 - aBattleAnimationSequencesUnknown08
        .word _Record10 - aBattleAnimationSequencesUnknown08
        .word _Record11 - aBattleAnimationSequencesUnknown08
        .word _Record12 - aBattleAnimationSequencesUnknown08
        .word _Record13 - aBattleAnimationSequencesUnknown08
        .word _Record14 - aBattleAnimationSequencesUnknown08
        .word _Record15 - aBattleAnimationSequencesUnknown08
        .word _Record16 - aBattleAnimationSequencesUnknown08
        .word _Record17 - aBattleAnimationSequencesUnknown08
        .word _Record18 - aBattleAnimationSequencesUnknown08
        .word _Record19 - aBattleAnimationSequencesUnknown08

      _Sequence00
        ANIM_CLEAR_BUSY
        ANIM_STEP 1, 16
        ANIM_HOLD

      _Sequence01
        ANIM_STEP 9, 5
        ANIM_STEP 8, 3
        ANIM_STEP 1, 3
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence02
        ANIM_STEP 2, 16
        ANIM_STEP 3, 8
        ANIM_STEP 4, 8
        ANIM_STEP 5, 16
        ANIM_STEP 6, 8
        ANIM_STEP 7, 8

      _Sequence03
        ANIM_STEP 1, 48
        ANIM_STEP 8, 8
        ANIM_STEP 9, 48
        ANIM_STEP 10, 6
        ANIM_STEP 11, 64
        ANIM_STEP 10, 7
        ANIM_STEP 9, 80

      _Sequence04
        ANIM_STEP 1, 48
        ANIM_STEP 8, 5
        ANIM_STEP 9, 6
        ANIM_STEP 12, 48
        ANIM_STEP 10, 5
        ANIM_STEP 11, 64

      _Sequence05
        ANIM_STEP 8, 5
        ANIM_STEP 9, 6
        ANIM_STEP 12, 1
        ANIM_CMD_F4 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence06
        ANIM_STEP 1, 5
        ANIM_STEP 8, 5
        ANIM_STEP 14, 6
        ANIM_STEP 13, 28
        ANIM_STEP 19, 5
        ANIM_CMD_EF 71
        ANIM_STEP 15, 16
        ANIM_CMD_EE
        ANIM_STEP 15, 32
        ANIM_STEP 5, 4
        ANIM_STEP 1, 5
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence07
        ANIM_STEP 16, 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence08
        ANIM_STEP 16, 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence09
        ANIM_STEP 17, 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence10
        ANIM_STEP 18, 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence11
        ANIM_STEP 18, 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence12
      _Sequence13
        ANIM_STEP 13, 16
        ANIM_STEP 19, 5
        ANIM_CMD_EF 71
        ANIM_STEP 15, 16
        ANIM_CMD_EE
        ANIM_STEP 15, 32
        ANIM_STEP 5, 4
        ANIM_STEP 1, 5
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence14
        ANIM_STEP 1, 5
        ANIM_STEP 8, 5
        ANIM_STEP 14, 6
        ANIM_STEP 13, 16
        ANIM_CLEAR_BUSY
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
        .structSpriteEntry (   0,  -25), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   4,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   4,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   4,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   0,   -3), $00, SpriteSmall, $054, 2, 2, false, true
        .structSpriteEntry ( -16,  -35), $00, SpriteSmall, $057, 2, 2, false, true
        .structSpriteEntry ( -16,  -27), $00, SpriteSmall, $047, 2, 2, false, true
        .structSpriteEntry (  -8,  -19), $00, SpriteSmall, $058, 2, 2, false, true
        .structSpriteEntry (  -8,  -11), $00, SpriteSmall, $048, 2, 2, false, true
        .structSpriteEntry ( -29,  -51), $21, SpriteLarge, $045, 2, 2, false, true
        ANIM_RECORD_END

      _Record02
        ANIM_RECORD 1
        .structSpriteEntry (  -2,  -23), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   4,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   4,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   4,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry (   1,   -3), $00, SpriteSmall, $054, 2, 2, false, true
        .structSpriteEntry ( -15,  -35), $00, SpriteSmall, $057, 2, 2, false, true
        .structSpriteEntry ( -15,  -27), $00, SpriteSmall, $047, 2, 2, false, true
        .structSpriteEntry (  -7,  -19), $00, SpriteSmall, $058, 2, 2, false, true
        .structSpriteEntry (  -7,  -11), $00, SpriteSmall, $048, 2, 2, false, true
        .structSpriteEntry ( -28,  -51), $21, SpriteLarge, $045, 2, 2, false, true
        ANIM_RECORD_END

      _Record03
        ANIM_RECORD 2
        .structSpriteEntry (  -2,  -24), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   4,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   4,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   4,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   1,   -4), $00, SpriteSmall, $054, 2, 2, false, true
        .structSpriteEntry ( -15,  -36), $00, SpriteSmall, $057, 2, 2, false, true
        .structSpriteEntry ( -15,  -28), $00, SpriteSmall, $047, 2, 2, false, true
        .structSpriteEntry (  -7,  -20), $00, SpriteSmall, $058, 2, 2, false, true
        .structSpriteEntry (  -7,  -12), $00, SpriteSmall, $048, 2, 2, false, true
        .structSpriteEntry ( -28,  -52), $21, SpriteLarge, $045, 2, 2, false, true
        ANIM_RECORD_END

      _Record04
        ANIM_RECORD 3
        .structSpriteEntry (  -2,  -24), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   4,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   4,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   4,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry (   1,   -4), $00, SpriteSmall, $054, 2, 2, false, true
        .structSpriteEntry ( -15,  -36), $00, SpriteSmall, $057, 2, 2, false, true
        .structSpriteEntry ( -15,  -28), $00, SpriteSmall, $047, 2, 2, false, true
        .structSpriteEntry (  -7,  -20), $00, SpriteSmall, $058, 2, 2, false, true
        .structSpriteEntry (  -7,  -12), $00, SpriteSmall, $048, 2, 2, false, true
        .structSpriteEntry ( -28,  -52), $21, SpriteLarge, $045, 2, 2, false, true
        ANIM_RECORD_END

      _Record05
        ANIM_RECORD 4
        .structSpriteEntry (  -2,  -23), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   4,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   4,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   4,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   1,   -3), $00, SpriteSmall, $054, 2, 2, false, true
        .structSpriteEntry ( -15,  -35), $00, SpriteSmall, $057, 2, 2, false, true
        .structSpriteEntry ( -15,  -27), $00, SpriteSmall, $047, 2, 2, false, true
        .structSpriteEntry (  -7,  -19), $00, SpriteSmall, $058, 2, 2, false, true
        .structSpriteEntry (  -7,  -11), $00, SpriteSmall, $048, 2, 2, false, true
        .structSpriteEntry ( -28,  -51), $21, SpriteLarge, $045, 2, 2, false, true
        ANIM_RECORD_END

      _Record06
        ANIM_RECORD 5
        .structSpriteEntry (  -2,  -24), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   4,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   4,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   4,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry (   1,   -4), $00, SpriteSmall, $054, 2, 2, false, true
        .structSpriteEntry ( -15,  -36), $00, SpriteSmall, $057, 2, 2, false, true
        .structSpriteEntry ( -15,  -28), $00, SpriteSmall, $047, 2, 2, false, true
        .structSpriteEntry (  -7,  -20), $00, SpriteSmall, $058, 2, 2, false, true
        .structSpriteEntry (  -7,  -12), $00, SpriteSmall, $048, 2, 2, false, true
        .structSpriteEntry ( -28,  -52), $21, SpriteLarge, $045, 2, 2, false, true
        ANIM_RECORD_END

      _Record07
        ANIM_RECORD 6
        .structSpriteEntry (  -2,  -24), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   4,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   4,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   4,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   1,   -4), $00, SpriteSmall, $054, 2, 2, false, true
        .structSpriteEntry ( -15,  -36), $00, SpriteSmall, $057, 2, 2, false, true
        .structSpriteEntry ( -15,  -28), $00, SpriteSmall, $047, 2, 2, false, true
        .structSpriteEntry (  -7,  -20), $00, SpriteSmall, $058, 2, 2, false, true
        .structSpriteEntry (  -7,  -12), $00, SpriteSmall, $048, 2, 2, false, true
        .structSpriteEntry ( -28,  -52), $21, SpriteLarge, $045, 2, 2, false, true
        ANIM_RECORD_END

      _Record08
        ANIM_RECORD 2
        .structSpriteEntry (  -2,  -24), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   4,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   4,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   4,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   7,  -10), $00, SpriteSmall, $044, 2, 2, false, true
        .structSpriteEntry ( -41,  -39), $21, SpriteLarge, $040, 2, 2, false, true
        .structSpriteEntry ( -17,  -26), $00, SpriteSmall, $043, 2, 2, false, true
        .structSpriteEntry ( -25,  -26), $00, SpriteSmall, $042, 2, 2, false, true
        .structSpriteEntry (  -1,  -18), $00, SpriteSmall, $053, 2, 2, false, true
        .structSpriteEntry (  -9,  -18), $00, SpriteSmall, $052, 2, 2, false, true
        ANIM_RECORD_END

      _Record09
        ANIM_RECORD 7
        .structSpriteEntry (  -2,  -23), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   4,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   4,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   4,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (  12,  -34), $00, SpriteSmall, $044, 2, 2, false, false
        .structSpriteEntry ( -36,  -13), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry ( -12,  -18), $00, SpriteSmall, $043, 2, 2, false, false
        .structSpriteEntry ( -20,  -18), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry (   4,  -26), $00, SpriteSmall, $053, 2, 2, false, false
        .structSpriteEntry (  -4,  -26), $00, SpriteSmall, $052, 2, 2, false, false
        ANIM_RECORD_END

      _Record10
        ANIM_RECORD 2
        .structSpriteEntry (  -2,  -24), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   4,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   4,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   4,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   9,  -33), $00, SpriteSmall, $044, 2, 2, false, false
        .structSpriteEntry ( -39,  -12), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry ( -15,  -17), $00, SpriteSmall, $043, 2, 2, false, false
        .structSpriteEntry ( -23,  -17), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry (   1,  -25), $00, SpriteSmall, $053, 2, 2, false, false
        .structSpriteEntry (  -7,  -25), $00, SpriteSmall, $052, 2, 2, false, false
        ANIM_RECORD_END

      _Record11
        ANIM_RECORD 8
        .structSpriteEntry ( -16,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -16,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry ( -45,  -38), $21, SpriteLarge, $040, 2, 2, false, true
        .structSpriteEntry ( -21,  -25), $00, SpriteSmall, $043, 2, 2, false, true
        .structSpriteEntry ( -29,  -25), $00, SpriteSmall, $042, 2, 2, false, true
        .structSpriteEntry ( -13,  -17), $00, SpriteSmall, $052, 2, 2, false, true
        .structSpriteEntry (   2,  -20), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   0,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry (   0,  -15), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (   3,  -10), $00, SpriteSmall, $044, 2, 2, false, true
        .structSpriteEntry (  -5,  -17), $00, SpriteSmall, $053, 2, 2, false, true
        ANIM_RECORD_END

      _Record12
        ANIM_RECORD 9
        .structSpriteEntry ( -16,  -22), $21, SpriteLarge, $060, 2, 3, true, false
        .structSpriteEntry (  -1,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -17,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (  -1,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -17,  -31), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (  21,  -44), $00, SpriteSmall, $044, 2, 2, false, false
        .structSpriteEntry ( -27,  -23), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry (  -3,  -28), $00, SpriteSmall, $043, 2, 2, false, false
        .structSpriteEntry ( -11,  -28), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry (  13,  -36), $00, SpriteSmall, $053, 2, 2, false, false
        .structSpriteEntry (   5,  -36), $00, SpriteSmall, $052, 2, 2, false, false
        ANIM_RECORD_END

      _Record13
        ANIM_RECORD 9
        .structSpriteEntry ( -16,  -22), $21, SpriteLarge, $060, 2, 3, true, false
        .structSpriteEntry (  -1,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -17,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (  -1,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -17,  -31), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (  23,  -19), $00, SpriteSmall, $044, 2, 2, false, true
        .structSpriteEntry ( -25,  -48), $21, SpriteLarge, $040, 2, 2, false, true
        .structSpriteEntry (  -1,  -35), $00, SpriteSmall, $043, 2, 2, false, true
        .structSpriteEntry (  -9,  -35), $00, SpriteSmall, $042, 2, 2, false, true
        .structSpriteEntry (  15,  -27), $00, SpriteSmall, $053, 2, 2, false, true
        .structSpriteEntry (   7,  -27), $00, SpriteSmall, $052, 2, 2, false, true
        ANIM_RECORD_END

      _Record14
        ANIM_RECORD 10
        .structSpriteEntry (  -2,  -23), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   4,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   4,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   4,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (  13,  -10), $00, SpriteSmall, $044, 2, 2, false, true
        .structSpriteEntry ( -35,  -39), $21, SpriteLarge, $040, 2, 2, false, true
        .structSpriteEntry ( -11,  -26), $00, SpriteSmall, $043, 2, 2, false, true
        .structSpriteEntry ( -19,  -26), $00, SpriteSmall, $042, 2, 2, false, true
        .structSpriteEntry (   5,  -18), $00, SpriteSmall, $053, 2, 2, false, true
        .structSpriteEntry (  -3,  -18), $00, SpriteSmall, $052, 2, 2, false, true
        ANIM_RECORD_END

      _Record15
        ANIM_RECORD 8
        .structSpriteEntry (   2,  -20), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry ( -16,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -16,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   0,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry (   0,  -15), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record16
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (  18,    2), $00, SpriteSmall, $044, 2, 2, false, true
        .structSpriteEntry ( -30,  -27), $21, SpriteLarge, $040, 2, 2, false, true
        .structSpriteEntry (  -6,  -14), $00, SpriteSmall, $043, 2, 2, false, true
        .structSpriteEntry ( -14,  -14), $00, SpriteSmall, $042, 2, 2, false, true
        .structSpriteEntry (  10,   -6), $00, SpriteSmall, $053, 2, 2, false, true
        .structSpriteEntry (   2,   -6), $00, SpriteSmall, $052, 2, 2, false, true
        ANIM_RECORD_END

      _Record17
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (  18,   -9), $00, SpriteSmall, $05F, 2, 2, false, false
        .structSpriteEntry (  10,   -9), $00, SpriteSmall, $05E, 2, 2, false, false
        .structSpriteEntry (   2,   -9), $00, SpriteSmall, $05D, 2, 2, false, false
        .structSpriteEntry (  -6,   -9), $00, SpriteSmall, $05C, 2, 2, false, false
        .structSpriteEntry ( -14,   -9), $00, SpriteSmall, $05B, 2, 2, false, false
        .structSpriteEntry ( -22,   -9), $00, SpriteSmall, $05A, 2, 2, false, false
        .structSpriteEntry ( -30,   -9), $00, SpriteSmall, $059, 2, 2, false, false
        ANIM_RECORD_END

      _Record18
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (  20,  -25), $00, SpriteSmall, $044, 2, 2, false, false
        .structSpriteEntry ( -28,   -4), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry (  -4,   -9), $00, SpriteSmall, $043, 2, 2, false, false
        .structSpriteEntry ( -12,   -9), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry (  12,  -17), $00, SpriteSmall, $053, 2, 2, false, false
        .structSpriteEntry (   4,  -17), $00, SpriteSmall, $052, 2, 2, false, false
        ANIM_RECORD_END

      _Record19
        ANIM_RECORD 11
        .structSpriteEntry (  16,  -23), $00, SpriteSmall, $044, 2, 2, false, true
        .structSpriteEntry ( -32,  -52), $21, SpriteLarge, $040, 2, 2, false, true
        .structSpriteEntry (  -8,  -39), $00, SpriteSmall, $043, 2, 2, false, true
        .structSpriteEntry ( -16,  -39), $00, SpriteSmall, $042, 2, 2, false, true
        .structSpriteEntry (   8,  -31), $00, SpriteSmall, $053, 2, 2, false, true
        .structSpriteEntry (   0,  -31), $00, SpriteSmall, $052, 2, 2, false, true
        .structSpriteEntry (  -5,  -22), $21, SpriteLarge, $060, 2, 3, false, false
        .structSpriteEntry (   6,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   6,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   6,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   6,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -10,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -10,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      aBattleAnimationFramesUnknown10 ; 98/F9A4

        ; Frame table of entry 10: slices of the class sheet per frame.

        .word _Frame00 - aBattleAnimationFramesUnknown10
        .word _Frame01 - aBattleAnimationFramesUnknown10
        .word _Frame02 - aBattleAnimationFramesUnknown10
        .word _Frame03 - aBattleAnimationFramesUnknown10
        .word _Frame04 - aBattleAnimationFramesUnknown10
        .word _Frame05 - aBattleAnimationFramesUnknown10
        .word _Frame06 - aBattleAnimationFramesUnknown10
        .word _Frame07 - aBattleAnimationFramesUnknown10
        .word _Frame08 - aBattleAnimationFramesUnknown10

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
        ANIM_TILE_ROW $0A00, $0100
        ANIM_TILES_END

      _Frame07
        ANIM_TILES
        ANIM_TILE_ROW $0B00, $0100
        ANIM_TILE_ROW $0C00, $0080
        ANIM_TILES_END

      _Frame08
        ANIM_TILES
        ANIM_TILE_ROW $0C80, $0100
        ANIM_TILE_ROW $0D80, $0100
        ANIM_TILES_END

      aBattleAnimationSequencesUnknown10 ; 98/FA07

        ; Sequence data of entry 10 of aBattleAnimationFrameTables; nothing selects it (no lookup
        ; record has a first ID that leads here) and no sheet in aBattleAnimationSheets is the
        ; size its frames need: probably left over. Frames: aBattleAnimationFramesUnknown10.

        .word _Index - aBattleAnimationSequencesUnknown10, _Records - aBattleAnimationSequencesUnknown10

      _Index
        .word _Sequence00 - aBattleAnimationSequencesUnknown10
        .word _Sequence01 - aBattleAnimationSequencesUnknown10
        .word _Sequence02 - aBattleAnimationSequencesUnknown10
        .word _Sequence03 - aBattleAnimationSequencesUnknown10
        .word _Sequence04 - aBattleAnimationSequencesUnknown10
        .word _Sequence05 - aBattleAnimationSequencesUnknown10
        .word _Sequence06 - aBattleAnimationSequencesUnknown10
        .word _Sequence07 - aBattleAnimationSequencesUnknown10
        .word _Sequence08 - aBattleAnimationSequencesUnknown10
        .word _Sequence09 - aBattleAnimationSequencesUnknown10
        .word _Sequence10 - aBattleAnimationSequencesUnknown10
        .word _Sequence11 - aBattleAnimationSequencesUnknown10
        .word _Sequence12 - aBattleAnimationSequencesUnknown10
        .word _Sequence13 - aBattleAnimationSequencesUnknown10
        .word _Sequence14 - aBattleAnimationSequencesUnknown10
        .word _Sequence15 - aBattleAnimationSequencesUnknown10
        .word _Sequence16 - aBattleAnimationSequencesUnknown10
        .word _Sequence17 - aBattleAnimationSequencesUnknown10
        .word _Sequence18 - aBattleAnimationSequencesUnknown10
        .word _Sequence19 - aBattleAnimationSequencesUnknown10
        .word _Sequence20 - aBattleAnimationSequencesUnknown10
        .word _Sequence21 - aBattleAnimationSequencesUnknown10
        .word _Sequence22 - aBattleAnimationSequencesUnknown10
        .word _Sequence23 - aBattleAnimationSequencesUnknown10
        .word _Sequence24 - aBattleAnimationSequencesUnknown10

      _Records
        .word _Record00 - aBattleAnimationSequencesUnknown10
        .word _Record01 - aBattleAnimationSequencesUnknown10
        .word _Record02 - aBattleAnimationSequencesUnknown10
        .word _Record03 - aBattleAnimationSequencesUnknown10
        .word _Record04 - aBattleAnimationSequencesUnknown10
        .word _Record05 - aBattleAnimationSequencesUnknown10
        .word _Record06 - aBattleAnimationSequencesUnknown10
        .word _Record07 - aBattleAnimationSequencesUnknown10
        .word _Record08 - aBattleAnimationSequencesUnknown10
        .word _Record09 - aBattleAnimationSequencesUnknown10
        .word _Record10 - aBattleAnimationSequencesUnknown10
        .word _Record11 - aBattleAnimationSequencesUnknown10
        .word _Record12 - aBattleAnimationSequencesUnknown10
        .word _Record13 - aBattleAnimationSequencesUnknown10
        .word _Record14 - aBattleAnimationSequencesUnknown10
        .word _Record15 - aBattleAnimationSequencesUnknown10
        .word _Record16 - aBattleAnimationSequencesUnknown10

      _Sequence00
        ANIM_CLEAR_BUSY
        ANIM_STEP 1, 1
        ANIM_HOLD

      _Sequence01
        ANIM_STEP 2, 16
        ANIM_CMD_F4 1
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence02
        ANIM_CMD_EF 6
        ANIM_SOUND 10
        ANIM_STEP 7, 2
        ANIM_CMD_EE
        ANIM_STEP 10, 2
        ANIM_STEP 7, 2
        ANIM_STEP 10, 2
        ANIM_STEP 7, 2
        ANIM_STEP 10, 2
        ANIM_STEP 7, 1
        ANIM_STEP 10, 1
        ANIM_STEP 7, 1
        ANIM_STEP 10, 1
        ANIM_STEP 7, 1
        ANIM_STEP 10, 1
        ANIM_STEP 7, 10
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence03
        ANIM_STEP 2, 24
        ANIM_STEP 3, 8
        ANIM_STEP 4, 15
        ANIM_STEP 8, 4
        ANIM_STEP 9, 4
        ANIM_STEP 5, 21
        ANIM_STEP 6, 4
        ANIM_SOUND 9
        ANIM_STEP 11, 38
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence04
        ANIM_SOUND 10
        ANIM_CMD_EF 11
        ANIM_STEP 12, 2
        ANIM_CMD_EE
        ANIM_STEP 13, 2
        ANIM_STEP 12, 2
        ANIM_STEP 13, 2
        ANIM_STEP 12, 2
        ANIM_STEP 13, 2
        ANIM_STEP 12, 1
        ANIM_STEP 13, 1
        ANIM_STEP 12, 1
        ANIM_STEP 13, 1
        ANIM_STEP 12, 1
        ANIM_STEP 13, 1
        ANIM_STEP 12, 10
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence05
        ANIM_STEP 2, 24
        ANIM_STEP 3, 8
        ANIM_STEP 4, 15
        ANIM_STEP 8, 4
        ANIM_STEP 9, 4
        ANIM_STEP 5, 21
        ANIM_SOUND 9
        ANIM_STEP 6, 38
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence06
        ANIM_STEP 15, 16
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence07
        ANIM_STEP 15, 16
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence08
        ANIM_STEP 15, 16
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence09
        ANIM_STEP 15, 16
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence10
        ANIM_STEP 15, 16
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence11
        ANIM_STEP 14, 16
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence12
        ANIM_STEP 14, 16
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence13
        ANIM_STEP 15, 16
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence14
        ANIM_STEP 16, 16
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence15
        ANIM_STEP 16, 16
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence16
        ANIM_STEP 2, 5
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence17
        ANIM_STEP 1, 5
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence18
        ANIM_STEP 7, 5
        ANIM_STEP 2, 3
        ANIM_STEP 1, 5
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence19
        ANIM_STEP 3, 8
        ANIM_STEP 4, 15
        ANIM_STEP 8, 4
        ANIM_STEP 9, 4
        ANIM_STEP 5, 21
        ANIM_STEP 6, 4
        ANIM_SOUND 9
        ANIM_STEP 11, 38
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence20
        ANIM_STEP 3, 8
        ANIM_STEP 4, 15
        ANIM_STEP 8, 4
        ANIM_STEP 9, 4
        ANIM_STEP 5, 21
        ANIM_SOUND 9
        ANIM_STEP 6, 38
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence21
        ANIM_SOUND 10
        ANIM_CMD_EF 11
        ANIM_STEP 12, 2
        ANIM_CMD_EE
        ANIM_STEP 13, 2
        ANIM_STEP 12, 2
        ANIM_STEP 13, 2
        ANIM_STEP 12, 2
        ANIM_STEP 13, 2
        ANIM_STEP 12, 1
        ANIM_STEP 13, 1
        ANIM_STEP 12, 1
        ANIM_STEP 13, 1
        ANIM_STEP 12, 1
        ANIM_STEP 13, 1
        ANIM_STEP 12, 10
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence22
        ANIM_CMD_EF 6
        ANIM_SOUND 10
        ANIM_STEP 7, 2
        ANIM_CMD_EE
        ANIM_STEP 10, 2
        ANIM_STEP 7, 2
        ANIM_STEP 10, 2
        ANIM_STEP 7, 2
        ANIM_STEP 10, 2
        ANIM_STEP 7, 1
        ANIM_STEP 10, 1
        ANIM_STEP 7, 1
        ANIM_STEP 10, 1
        ANIM_STEP 7, 1
        ANIM_STEP 10, 1
        ANIM_STEP 7, 10
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence23
        ANIM_STEP 2, 24
        ANIM_STEP 3, 8
        ANIM_STEP 4, 15
        ANIM_STEP 8, 4
        ANIM_STEP 9, 4
        ANIM_STEP 5, 21
        ANIM_SOUND 9
        ANIM_STEP 6, 64
        ANIM_CLEAR_BUSY
        ANIM_HOLD

      _Sequence24
        ANIM_STEP 2, 24
        ANIM_STEP 3, 8
        ANIM_STEP 4, 15
        ANIM_STEP 8, 4
        ANIM_STEP 9, 4
        ANIM_STEP 5, 21
        ANIM_STEP 6, 4
        ANIM_SOUND 9
        ANIM_STEP 11, 64
        ANIM_CLEAR_BUSY
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
        .structSpriteEntry ( -10,  -34), $00, SpriteSmall, $049, 2, 2, false, false
        .structSpriteEntry ( -10,  -26), $00, SpriteSmall, $059, 2, 2, false, false
        .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -15,  -19), $21, SpriteLarge, $043, 2, 2, false, false
        .structSpriteEntry ( -15,  -27), $00, SpriteSmall, $052, 2, 2, false, false
        .structSpriteEntry ( -15,  -35), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   4,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   4,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   4,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record02
        ANIM_RECORD 1
        .structSpriteEntry ( -10,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (   6,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   6,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (  -8,  -26), $00, SpriteSmall, $059, 2, 2, false, false
        .structSpriteEntry (  -8,  -34), $00, SpriteSmall, $049, 2, 2, false, false
        .structSpriteEntry ( -13,  -19), $21, SpriteLarge, $043, 2, 2, false, false
        .structSpriteEntry ( -13,  -27), $00, SpriteSmall, $052, 2, 2, false, false
        .structSpriteEntry ( -13,  -35), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry ( -10,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   6,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   6,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry (   6,  -18), $00, SpriteSmall, $04C, 2, 2, false, false
        ANIM_RECORD_END

      _Record03
        ANIM_RECORD 2
        .structSpriteEntry (  14,  -10), $00, SpriteSmall, $05E, 2, 2, false, false
        .structSpriteEntry (  14,  -18), $00, SpriteSmall, $05D, 2, 2, false, false
        .structSpriteEntry (  14,  -26), $00, SpriteSmall, $04D, 2, 2, false, false
        .structSpriteEntry (  -8,  -26), $00, SpriteSmall, $059, 2, 2, false, false
        .structSpriteEntry (  -8,  -34), $00, SpriteSmall, $049, 2, 2, false, false
        .structSpriteEntry (  -8,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -13,  -19), $21, SpriteLarge, $043, 2, 2, false, false
        .structSpriteEntry ( -13,  -27), $00, SpriteSmall, $052, 2, 2, false, false
        .structSpriteEntry ( -13,  -35), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry (  -8,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   8,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   8,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   8,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   8,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        ANIM_RECORD_END

      _Record04
        ANIM_RECORD 3
        .structSpriteEntry (   6,  -30), $00, SpriteSmall, $04C, 2, 2, true, false
        .structSpriteEntry (  14,  -30), $00, SpriteSmall, $04B, 2, 2, true, false
        .structSpriteEntry (  22,  -30), $00, SpriteSmall, $04A, 2, 2, true, false
        .structSpriteEntry (  -8,  -26), $00, SpriteSmall, $059, 2, 2, false, false
        .structSpriteEntry (  -8,  -34), $00, SpriteSmall, $049, 2, 2, false, false
        .structSpriteEntry (  -8,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -13,  -19), $21, SpriteLarge, $043, 2, 2, false, false
        .structSpriteEntry ( -13,  -27), $00, SpriteSmall, $052, 2, 2, false, false
        .structSpriteEntry ( -13,  -35), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry (   8,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   8,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   8,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   8,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry (  -8,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record05
        ANIM_RECORD 4
        .structSpriteEntry (  -6,  -20), $00, SpriteSmall, $04C, 2, 2, false, false
        .structSpriteEntry ( -14,  -20), $00, SpriteSmall, $04B, 2, 2, false, false
        .structSpriteEntry ( -22,  -20), $00, SpriteSmall, $04A, 2, 2, false, false
        .structSpriteEntry (  -8,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (  -8,  -26), $00, SpriteSmall, $059, 2, 2, false, false
        .structSpriteEntry (  -8,  -34), $00, SpriteSmall, $049, 2, 2, false, false
        .structSpriteEntry ( -13,  -19), $21, SpriteLarge, $043, 2, 2, false, false
        .structSpriteEntry ( -13,  -27), $00, SpriteSmall, $052, 2, 2, false, false
        .structSpriteEntry ( -13,  -35), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry (  -8,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   8,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   8,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   8,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   8,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        ANIM_RECORD_END

      _Record06
        ANIM_RECORD 5
        .structSpriteEntry (  -3,  -23), $00, SpriteSmall, $059, 2, 2, false, true
        .structSpriteEntry (  -3,  -15), $00, SpriteSmall, $049, 2, 2, false, true
        .structSpriteEntry (  -3,  -31), $00, SpriteSmall, $059, 2, 2, false, false
        .structSpriteEntry (  -3,  -39), $00, SpriteSmall, $049, 2, 2, false, false
        .structSpriteEntry (  -4,  -28), $00, SpriteSmall, $05C, 2, 2, false, false
        .structSpriteEntry ( -12,  -28), $00, SpriteSmall, $05B, 2, 2, false, false
        .structSpriteEntry ( -20,  -28), $00, SpriteSmall, $05A, 2, 2, false, false
        .structSpriteEntry (  -5,  -15), $00, SpriteSmall, $047, 2, 2, false, true
        .structSpriteEntry (  -5,  -39), $00, SpriteSmall, $047, 2, 2, false, false
        .structSpriteEntry ( -21,  -23), $21, SpriteLarge, $045, 2, 2, false, true
        .structSpriteEntry ( -21,  -39), $21, SpriteLarge, $045, 2, 2, false, false
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   4,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   4,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   4,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record07
        ANIM_RECORD 6
        .structSpriteEntry (  -9,  -17), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry (  -9,  -29), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry (  -9,  -21), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry (  -9,  -37), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry ( -21,  -23), $21, SpriteLarge, $040, 2, 2, false, true
        .structSpriteEntry ( -21,  -39), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry (   1,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -15,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   1,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -15,  -31), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record08
        ANIM_RECORD 3
        .structSpriteEntry (   5,  -35), $00, SpriteSmall, $04C, 2, 2, true, true
        .structSpriteEntry (  13,  -35), $00, SpriteSmall, $04B, 2, 2, true, true
        .structSpriteEntry (  21,  -35), $00, SpriteSmall, $04A, 2, 2, true, true
        .structSpriteEntry (  -8,  -26), $00, SpriteSmall, $059, 2, 2, false, false
        .structSpriteEntry (  -8,  -34), $00, SpriteSmall, $049, 2, 2, false, false
        .structSpriteEntry (  -8,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -13,  -19), $21, SpriteLarge, $043, 2, 2, false, false
        .structSpriteEntry ( -13,  -27), $00, SpriteSmall, $052, 2, 2, false, false
        .structSpriteEntry ( -13,  -35), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry (   8,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   8,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   8,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   8,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        .structSpriteEntry (  -8,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        ANIM_RECORD_END

      _Record09
        ANIM_RECORD 4
        .structSpriteEntry (  -2,  -41), $00, SpriteSmall, $05E, 2, 2, false, true
        .structSpriteEntry (  -2,  -33), $00, SpriteSmall, $05D, 2, 2, false, true
        .structSpriteEntry (  -2,  -25), $00, SpriteSmall, $04D, 2, 2, false, true
        .structSpriteEntry (  -8,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry (  -8,  -26), $00, SpriteSmall, $059, 2, 2, false, false
        .structSpriteEntry (  -8,  -34), $00, SpriteSmall, $049, 2, 2, false, false
        .structSpriteEntry ( -13,  -19), $21, SpriteLarge, $043, 2, 2, false, false
        .structSpriteEntry ( -13,  -27), $00, SpriteSmall, $052, 2, 2, false, false
        .structSpriteEntry ( -13,  -35), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry (  -8,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   8,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   8,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   8,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   8,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        ANIM_RECORD_END

      _Record10
        ANIM_RECORD 6
        .structSpriteEntry (  -8,  -17), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry (  -8,  -29), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry (  -8,  -21), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry (  -8,  -37), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry ( -21,  -23), $21, SpriteLarge, $040, 2, 2, false, true
        .structSpriteEntry ( -21,  -39), $21, SpriteLarge, $040, 2, 2, false, false
        .structSpriteEntry (   1,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -15,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   1,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -15,  -31), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record11
        ANIM_RECORD 7
        .structSpriteEntry (  -5,  -24), $00, SpriteSmall, $057, 2, 2, false, true
        .structSpriteEntry (  -9,  -21), $00, SpriteSmall, $057, 2, 2, false, true
        .structSpriteEntry (   0,  -33), $00, SpriteSmall, $058, 2, 2, false, false
        .structSpriteEntry (  -1,  -38), $00, SpriteSmall, $058, 2, 2, false, false
        .structSpriteEntry (  -4,  -32), $00, SpriteSmall, $04C, 2, 2, false, true
        .structSpriteEntry ( -12,  -32), $00, SpriteSmall, $04B, 2, 2, false, true
        .structSpriteEntry ( -20,  -32), $00, SpriteSmall, $04A, 2, 2, false, true
        .structSpriteEntry ( -14,  -42), $21, SpriteLarge, $043, 2, 2, false, true
        .structSpriteEntry ( -14,  -26), $00, SpriteSmall, $052, 2, 2, false, true
        .structSpriteEntry ( -14,  -18), $00, SpriteSmall, $042, 2, 2, false, true
        .structSpriteEntry ( -10,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -10,  -31), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   6,   -7), $00, SpriteSmall, $004, 2, 0, false, false
        .structSpriteEntry (   6,  -15), $00, SpriteSmall, $005, 2, 0, false, false
        .structSpriteEntry (   6,  -23), $00, SpriteSmall, $006, 2, 0, false, false
        .structSpriteEntry (   6,  -31), $00, SpriteSmall, $007, 2, 0, false, false
        ANIM_RECORD_END

      _Record12
        ANIM_RECORD 8
        .structSpriteEntry ( -11,  -19), $00, SpriteSmall, $059, 2, 2, false, true
        .structSpriteEntry (  -9,  -24), $00, SpriteSmall, $059, 2, 2, false, true
        .structSpriteEntry (  -6,  -32), $00, SpriteSmall, $059, 2, 2, false, true
        .structSpriteEntry (  -3,  -40), $00, SpriteSmall, $059, 2, 2, false, true
        .structSpriteEntry ( -14,  -42), $21, SpriteLarge, $043, 2, 2, false, true
        .structSpriteEntry ( -14,  -26), $00, SpriteSmall, $052, 2, 2, false, true
        .structSpriteEntry ( -14,  -18), $00, SpriteSmall, $042, 2, 2, false, true
        .structSpriteEntry (   4,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   4,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record13
        ANIM_RECORD 8
        .structSpriteEntry ( -10,  -19), $00, SpriteSmall, $059, 2, 2, false, true
        .structSpriteEntry (  -8,  -24), $00, SpriteSmall, $059, 2, 2, false, true
        .structSpriteEntry (  -5,  -32), $00, SpriteSmall, $059, 2, 2, false, true
        .structSpriteEntry (  -2,  -40), $00, SpriteSmall, $059, 2, 2, false, true
        .structSpriteEntry ( -14,  -42), $21, SpriteLarge, $043, 2, 2, false, true
        .structSpriteEntry ( -14,  -26), $00, SpriteSmall, $052, 2, 2, false, true
        .structSpriteEntry ( -14,  -18), $00, SpriteSmall, $042, 2, 2, false, true
        .structSpriteEntry (   4,  -15), $21, SpriteLarge, $000, 2, 0, false, false
        .structSpriteEntry ( -12,  -15), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   4,  -31), $21, SpriteLarge, $004, 2, 0, false, false
        .structSpriteEntry ( -12,  -31), $21, SpriteLarge, $006, 2, 0, false, false
        ANIM_RECORD_END

      _Record14
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (   4,   -6), $00, SpriteSmall, $04C, 2, 2, false, true
        .structSpriteEntry (  -4,   -6), $00, SpriteSmall, $04B, 2, 2, false, true
        .structSpriteEntry ( -12,   -6), $00, SpriteSmall, $04A, 2, 2, false, true
        ANIM_RECORD_END

      _Record15
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (   4,   -7), $00, SpriteSmall, $05C, 2, 2, false, false
        .structSpriteEntry (  -4,   -7), $00, SpriteSmall, $05B, 2, 2, false, false
        .structSpriteEntry ( -12,   -7), $00, SpriteSmall, $05A, 2, 2, false, false
        ANIM_RECORD_END

      _Record16
        ANIM_RECORD ANIM_KEEP_TILES
        .structSpriteEntry (   4,   -6), $00, SpriteSmall, $04C, 2, 2, false, false
        .structSpriteEntry (  -4,   -6), $00, SpriteSmall, $04B, 2, 2, false, false
        .structSpriteEntry ( -12,   -6), $00, SpriteSmall, $04A, 2, 2, false, false
        ANIM_RECORD_END

    .endsection BattleAnimationFrameData98Section


    .section DemoBattles98Section

      .al
      .xl

      dialogueBattleSceneClear ; 98/FF85
        .include "../../text/dialogue/BattleScene/Clear.dialogue.txt"

      dialogueBattleSceneItemObtained ; 98/FF87
        .include "../../text/dialogue/BattleScene/ItemObtained.dialogue.txt"

      dialogueBattleSceneGoldObtained ; 98/FF98
        .include "../../text/dialogue/BattleScene/GoldObtained.dialogue.txt"

      dialogueBattleSceneGoldStolen ; 98/FFAB
        .include "../../text/dialogue/BattleScene/GoldStolen.dialogue.txt"

      dialogueBattleSceneWaitPress ; 98/FFB9
        .include "../../text/dialogue/BattleScene/WaitPress.dialogue.txt"

      dialogueBattleSceneWeaponBroke ; 98/FFBB
        .include "../../text/dialogue/BattleScene/WeaponBroke.dialogue.txt"

      dialogueDemoBattleQuote98FFC9 ; 98/FFC9
        .byte $07, $00, $05, $01
        _98FFC9_Body .include "../../text/dialogue/DemoBattles/Quote98FFC9.dialogue.txt"

      dialogueDemoBattleQuote98FFEE ; 98/FFEE
        .byte $07, $00, $05, $01
        _98FFEE_Body .include "../../text/dialogue/DemoBattles/Quote98FFEE.dialogue.txt"

        .enc "proc"

    .endsection DemoBattles98Section
