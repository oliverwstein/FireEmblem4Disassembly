; Code from bank $8D not yet assigned to a game system.

    .section DemoBattlesSection

      .al
      .xl

      aDemoBattlesPointerTable ; 8D/8000

        .long aDemoBattle00, aDemoBattle00_UnitList
        .long aDemoBattle01, aDemoBattle01_UnitList
        .long aDemoBattle02, aDemoBattle02_UnitList
        .long aDemoBattle03, aDemoBattle03_UnitList
        .long aDemoBattle04, aDemoBattle04_UnitList
        .long aDemoBattle05, aDemoBattle05_UnitList
        .long aDemoBattle06, aDemoBattle06_UnitList
        .long aDemoBattle07, aDemoBattle07_UnitList
        .long aDemoBattle08, aDemoBattle08_UnitList
        .long aDemoBattle09, aDemoBattle09_UnitList
        .long aDemoBattle10, aDemoBattle10_UnitList
        .long aDemoBattle11, aDemoBattle11_UnitList
        .long aDemoBattle12, aDemoBattle12_UnitList
        .long aDemoBattle13, aDemoBattle13_UnitList
        .long aDemoBattle14, aDemoBattle14_UnitList
        .long aDemoBattle15, aDemoBattle15_UnitList
        .long aDemoBattle16, aDemoBattle16_UnitList
        .long aDemoBattle17, aDemoBattle17_UnitList
        .long aDemoBattle18, aDemoBattle18_UnitList
        .long aDemoBattle19, aDemoBattle19_UnitList
        .long aDemoBattle20, aDemoBattle20_UnitList
        .long aDemoBattle21, aDemoBattle21_UnitList
        .long aDemoBattle22, aDemoBattle22_UnitList
        .long aDemoBattle23, aDemoBattle23_UnitList
        .long aDemoBattle24, aDemoBattle24_UnitList
        .long aDemoBattle25, aDemoBattle25_UnitList
        .long aDemoBattle26, aDemoBattle26_UnitList
        .long aDemoBattle27, aDemoBattle27_UnitList
        .long aDemoBattle28, aDemoBattle28_UnitList
        .long aDemoBattle29, aDemoBattle29_UnitList
        .long aDemoBattle30, aDemoBattle30_UnitList
        .long aDemoBattle31, aDemoBattle31_UnitList

      aDemoBattle00 ; 8D/80C0
        .byte $00, $60, $00, $0C, $01, $1A, $17, $21, $18, $04, $04, $2A, $26, $1E, $23, $06
        .byte $12, $38, $64, $12, $14, $0E, $07, $D4, $51, $01
        .word $0000
        .word $0000

      aDemoBattle00_UnitList ; 8D/80DE
        .word $0009, $0C14, $0600, $0C14, $FFFF

      aDemoBattle01 ; 8D/80E8
        .byte $00, $EC, $00, $A5, $00, $3B, $14, $3F, $05, $0E, $0E, $20, $30, $20, $30, $0D
        .byte $08, $48, $62, $12, $10, $08, $04, $78, $60, $05
        .word $0000
        .word $0000

      aDemoBattle01_UnitList ; 8D/8106
        .word $1049, $1049, $1004, $FFFF

      aDemoBattle02 ; 8D/810E
        .byte $00, $03, $00, $02, $00, $09, $09, $1C, $00, $19, $04, $2A, $2B, $2A, $2B, $19
        .byte $1D, $58, $5C, $1C, $1C, $10, $14, $36, $36, $01
        .long dialogueDemoBattleQuote96FD6F
        .long dialogueDemoBattleQuote96FD84

      aDemoBattle02_UnitList ; 8D/812E
        .word $0000, $0801, $0C04, $1005, $FFFF

      aDemoBattle03 ; 8D/8138
        .byte $00, $04, $00, $13, $00, $1A, $17, $1E, $05, $17, $17, $32, $26, $18, $14, $1C
        .byte $19, $63, $64, $1F, $19, $1B, $0C, $36, $36, $05
        .long dialogueDemoBattleQuote98FFC9
        .long dialogueDemoBattleQuote98FFEE

      aDemoBattle03_UnitList ; 8D/8158
        .word $0009, $13FE, $0814, $0400, $02FE, $0000, $0404, $0814
        .word $FFFF

      aDemoBattle04 ; 8D/816A
        .byte $00, $52, $00, $10, $00, $3D, $3C, $52, $63, $09, $04, $32, $1B, $32, $1B, $0A
        .byte $04, $FF, $FF, $FF, $FF, $FF, $FF, $D7, $36, $07
        .word $0000
        .long dialogueDemoBattleQuote96FF3E

      aDemoBattle04_UnitList ; 8D/8189
        .word $0002, $FFFF

      aDemoBattle05 ; 8D/818D
        .byte $00, $0A, $00, $17, $00, $0D, $38, $FF, $5F, $0E, $0E, $28, $20, $02, $20, $1D
        .byte $1E, $FF, $FF, $FF, $FF, $FF, $FF, $36, $36, $05
        .word $0000
        .long dialogueDemoBattleQuote96FF5D

      aDemoBattle05_UnitList ; 8D/81AC
        .word $0002, $FFFF

      aDemoBattle06 ; 8D/81B0
        .byte $00, $5A, $00, $01, $00, $09, $06, $14, $02, $04, $04, $41, $35, $41, $35, $19
        .byte $16, $64, $1F, $34, $24, $18, $0D, $44, $36, $01
        .word $0000
        .long dialogueDemoBattleQuote96FF7A

      aDemoBattle06_UnitList ; 8D/81CF
        .word $2701, $0008, $FFFF

      aDemoBattle07 ; 8D/81D5
        .byte $00, $5A, $00, $12, $00, $09, $2F, $14, $FF, $04, $04, $41, $1E, $41, $1E, $19
        .byte $08, $64, $FF, $34, $FF, $18, $FF, $44, $36, $05
        .word $0000
        .long dialogueDemoBattleQuote96FFA6

      aDemoBattle07_UnitList ; 8D/81F4
        .word $FFFF

      aDemoBattle08 ; 8D/81F6
        .byte $00, $14, $00, $16, $00, $11, $32, $FF, $19, $12, $04, $29, $23, $29, $23, $14
        .byte $12, $00, $00, $00, $04, $0C, $05, $36, $36, $0D
        .long dialogueDemoBattleQuote96FDA0
        .long dialogueDemoBattleQuote96FDCC

      aDemoBattle08_UnitList ; 8D/8216
        .word $0008, $0008, $FFFF

      aDemoBattle09 ; 8D/821C
        .byte $00, $16, $00, $08, $00, $32, $3A, $19, $FF, $12, $04, $23, $31, $23, $31, $12
        .byte $17, $00, $00, $04, $00, $05, $09, $36, $36, $09
        .long dialogueDemoBattleQuote96FDE2
        .long dialogueDemoBattleQuote96FE02

      aDemoBattle09_UnitList ; 8D/823C
        .word $0009, $0009, $FFFF

      aDemoBattle10 ; 8D/8242
        .byte $00, $EF, $00, $06, $00, $14, $07, $23, $24, $08, $08, $4B, $32, $4B, $05, $1E
        .byte $13, $64, $5A, $3D, $3C, $21, $1B, $60, $05, $01
        .word $0000
        .long dialogueDemoBattleQuote96FFE0

      aDemoBattle10_UnitList ; 8D/8261
        .word $1B00, $1B00, $0511, $FFFF

      aDemoBattle11 ; 8D/8269
        .byte $00, $61, $01, $1D, $00, $14, $08, $1E, $02, $03, $04, $41, $35, $41, $35, $1E
        .byte $17, $41, $64, $31, $28, $1A, $19, $60, $36, $01
        .word $0000
        .long dialogueDemoBattleQuote8D8468

      aDemoBattle11_UnitList ; 8D/8288
        .word $0E00, $0E00, $0009, $2514, $FFFF

      aDemoBattle12 ; 8D/8292
        .byte $00, $3A, $00, $32, $00, $16, $16, $00, $00, $17, $17, $1C, $1D, $1C, $1D, $FF
        .byte $FF, $3D, $2D, $0F, $0F, $07, $07, $36, $36, $09
        .long dialogueDemoBattleQuote96FE35
        .long dialogueDemoBattleQuote96FE68

      aDemoBattle12_UnitList ; 8D/82B2
        .word $13FE, $0008, $0800, $0008, $0800, $0008, $13FE, $0801
        .word $0801, $0009, $0801, $0801, $FFFF

      aDemoBattle13 ; 8D/82CC
        .byte $00, $1A, $00, $3A, $00, $17, $16, $00, $00, $17, $17, $26, $1C, $26, $1C, $0C
        .byte $FF, $42, $26, $18, $0F, $0C, $07, $36, $36, $05
        .long dialogueDemoBattleQuote96FE9C
        .long dialogueDemoBattleQuote96FEC1

      aDemoBattle13_UnitList ; 8D/82EC
        .word $13FE, $0300, $0300, $0008, $0008, $0008, $1101, $1101
        .word $FFFF

      aDemoBattle14 ; 8D/82FE
        .byte $00, $7D, $01, $3D, $00, $31, $34, $40, $43, $09, $09, $41, $25, $41, $25, $1B
        .byte $0C, $5C, $29, $32, $14, $1E, $10, $88, $36, $0E
        .word $0000
        .word $0000

      aDemoBattle14_UnitList ; 8D/831C
        .word $0A44, $2241, $FFFF

      aDemoBattle15 ; 8D/8322
        .byte $00, $3D, $00, $35, $00, $34, $3A, $FF, $5A, $09, $09, $25, $36, $03, $36, $0C
        .byte $19, $FF, $FF, $FF, $FF, $FF, $FF, $36, $36, $09
        .word $0000
        .long dialogueDemoBattleQuote8D8487

      aDemoBattle15_UnitList ; 8D/8341
        .word $2202, $FFFF

      aDemoBattle16 ; 8D/8345
        .byte $00, $1E, $00, $31, $00, $03, $27, $29, $29, $04, $03, $28, $2A, $28, $2A, $0C
        .byte $0C, $5A, $54, $20, $21, $0A, $0C, $11, $11, $01
        .word $0000
        .word $0000

      aDemoBattle16_UnitList ; 8D/8363
        .word $1401, $1401, $0009, $2B14, $FFFF

      aDemoBattle17 ; 8D/836D
        .byte $00, $1E, $00, $3B, $00, $03, $33, $29, $5A, $03, $04, $28, $22, $02, $22, $0C
        .byte $05, $FF, $FF, $FF, $FF, $FF, $FF, $36, $36, $05
        .long dialogueDemoBattleQuote96FEF4
        .long dialogueDemoBattleQuote96FF29

      aDemoBattle17_UnitList ; 8D/838D
        .word $2602, $FFFF

      aDemoBattle26 ; 8D/8391
        .byte $00, $04, $01, $01, $00, $3A, $06, $41, $15, $03, $03, $3C, $3C, $3C, $3C, $1E
        .byte $1E, $FF, $64, $FF, $3B, $FF, $0A, $78, $36, $01
        .long dialogueDemoBattleQuote8D85F4
        .word $0000

      aDemoBattle26_UnitList ; 8D/83B0
        .word $3041, $2D00, $FFFF

      aDemoBattle27 ; 8D/83B6
        .byte $00, $04, $01, $10, $00, $3A, $3C, $41, $5A, $09, $09, $3C, $1B, $0F, $1B, $1E
        .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $78, $B8, $05
        .word $0000
        .long dialogueDemoBattleQuote8D860D

      aDemoBattle27_UnitList ; 8D/83D5
        .word $2D02, $FFFF

      aDemoBattle28 ; 8D/83D9
        .byte $00, $2B, $00, $10, $00, $3C, $3C, $FF, $5E, $09, $09, $12, $18, $12, $04, $FF
        .byte $01, $FF, $FF, $FF, $FF, $FF, $FF, $B8, $B8, $0D
        .word $0000
        .long dialogueDemoBattleQuote8D8556

      aDemoBattle28_UnitList ; 8D/83F8
        .word $0002, $FFFF

      aDemoBattle29 ; 8D/83FC
        .byte $00, $C6, $01, $10, $00, $47, $3C, $54, $FF, $09, $09, $50, $18, $50, $04, $1E
        .byte $01, $64, $FF, $37, $FF, $1E, $FF, $C8, $B8, $05
        .long dialogueDemoBattleQuote8D8575
        .word $0000

      aDemoBattle29_UnitList ; 8D/841B
        .word $0451, $FFFF

      aDemoBattle30 ; 8D/841F
        .byte $00, $C6, $01, $2B, $00, $47, $3A, $54, $50, $09, $09, $50, $2A, $28, $16, $1E
        .byte $1A, $49, $41, $37, $3C, $1E, $2E, $C8, $36, $05
        .long dialogueDemoBattleQuote8D8597
        .word $0000

      aDemoBattle30_UnitList ; 8D/843E
        .word $0941, $1E40, $FFFF

      aDemoBattle31 ; 8D/8444
        .byte $00, $C6, $01, $19, $00, $47, $06, $54, $15, $09, $09, $50, $42, $0A, $10, $1E
        .byte $1E, $3D, $47, $37, $1E, $19, $26, $C8, $36, $01
        .word $0000
        .word $0000

      aDemoBattle31_UnitList ; 8D/8462
        .word $0049, $0A14, $FFFF

      dialogueDemoBattleQuote8D8468 ; 8D/8468
        .byte $07, $00, $05, $01
        _8D8468_Body .include "../../text/dialogue/DemoBattles/Quote8D8468.dialogue.txt"

      dialogueDemoBattleQuote8D8487 ; 8D/8487
        .byte $07, $00, $05, $01
        _8D8487_Body .include "../../text/dialogue/DemoBattles/Quote8D8487.dialogue.txt"

      dialogueDemoBattleQuote8D84A0 ; 8D/84A0
        .byte $07, $00, $05, $01
        _8D84A0_Body .include "../../text/dialogue/DemoBattles/Quote8D84A0.dialogue.txt"

      dialogueDemoBattleQuote8D84C1 ; 8D/84C1
        .byte $07, $00, $05, $01
        _8D84C1_Body .include "../../text/dialogue/DemoBattles/Quote8D84C1.dialogue.txt"

      dialogueDemoBattleQuote8D84EC ; 8D/84EC
        .byte $07, $00, $05, $01
        _8D84EC_Body .include "../../text/dialogue/DemoBattles/Quote8D84EC.dialogue.txt"

      dialogueDemoBattleQuote8D8508 ; 8D/8508
        .byte $07, $00, $05, $01
        _8D8508_Body .include "../../text/dialogue/DemoBattles/Quote8D8508.dialogue.txt"

      dialogueDemoBattleQuote8D8524 ; 8D/8524
        .byte $07, $00, $05, $01
        _8D8524_Body .include "../../text/dialogue/DemoBattles/Quote8D8524.dialogue.txt"

      dialogueDemoBattleQuote8D853E ; 8D/853E
        .byte $07, $00, $05, $01
        _8D853E_Body .include "../../text/dialogue/DemoBattles/Quote8D853E.dialogue.txt"

      dialogueDemoBattleQuote8D8556 ; 8D/8556
        .byte $07, $00, $05, $01
        _8D8556_Body .include "../../text/dialogue/DemoBattles/Quote8D8556.dialogue.txt"

      dialogueDemoBattleQuote8D8575 ; 8D/8575
        .byte $07, $00, $05, $01
        _8D8575_Body .include "../../text/dialogue/DemoBattles/Quote8D8575.dialogue.txt"

      dialogueDemoBattleQuote8D8597 ; 8D/8597
        .byte $07, $00, $05, $01
        _8D8597_Body .include "../../text/dialogue/DemoBattles/Quote8D8597.dialogue.txt"

      dialogueDemoBattleQuote8D85B7 ; 8D/85B7
        .byte $07, $00, $05, $01
        _8D85B7_Body .include "../../text/dialogue/DemoBattles/Quote8D85B7.dialogue.txt"

      dialogueDemoBattleQuote8D85D1 ; 8D/85D1
        .byte $07, $00, $05, $01
        _8D85D1_Body .include "../../text/dialogue/DemoBattles/Quote8D85D1.dialogue.txt"

      dialogueDemoBattleQuote8D85F4 ; 8D/85F4
        .byte $07, $00, $05, $01
        _8D85F4_Body .include "../../text/dialogue/DemoBattles/Quote8D85F4.dialogue.txt"

      dialogueDemoBattleQuote8D860D ; 8D/860D
        .byte $07, $00, $05, $01
        _8D860D_Body .include "../../text/dialogue/DemoBattles/Quote8D860D.dialogue.txt"


    .endsection DemoBattlesSection


    .section Unsorted8DA06ASection

      .al
      .xl

      rlEpilogueUpkeep ; 8D/A06A

        .al
        .xl
        .autsiz
        .databank ?

        ; Game state routine $35, every frame while the epilogue is up: does nothing.

        rtl

        .databank 0

        ; 8D/A06B

      rlEpilogueSetup ; 8D/A06B

        .al
        .xl
        .autsiz
        .databank ?

        ; Game state routine $36, once: builds the RAM area at $7F5709, clears $7F4400-$7F5708, turns on active sprites and, unless $08DA is 0-2, starts a fade-in; moves on to $37.

        lda #$7F00
        sta lR18+1
        lda #$5709
        sta lR18
        lda #$A8F6
        jsl rlBuildRAMAreaHeaderAndGuidingEntry
        ldx #$1308
        lda #$0000

        _A082
        sta $7F4400,x
        dec x
        bpl _A082
        jsl rlEnableActiveSpriteEngine
        inc wGameStateRoutine1,b
        lda $08DA,b
        cmp #$0001
        beq _A0B6
        cmp #$0000
        beq _A0B6
        cmp #$0002
        beq _A0B6
        lda #$0004
        sta wScreenFadingProcInput,b
        lda #(`procFadeInByScreenFadingTimer)<<8
        sta lR44+1
        lda #<>procFadeInByScreenFadingTimer
        sta lR44
        jsl rlProcEngineCreateProc

        _A0B6
        rtl

        .databank 0

        ; 8D/A0B7

      rlEpilogueStep ; 8D/A0B7

        .al
        .xl
        .autsiz
        .databank ?

        ; Game state routine $37, every frame: runs the routine for wGameStateStep from aUnknown8DA0C6.

        phb
        php
        phk
        plb
        .databank $8D
        lda wGameStateStep,b
        asl a
        tax
        jsr (aUnknown8DA0C6,x)
        plp
        plb
        .databank $8D
        rtl

        .databank 0

        ; 8D/A0C6

    .endsection Unsorted8DA06ASection


    .section Unsorted8DA0C6Section

      .al
      .xl

      aUnknown8DA0C6 ; 8D/A0C6

        ; Step handlers of rlEpilogueStep, by wGameStateStep.
        .word <>rsUnknown8DA0EC, <>rsUnknown8DA113, <>rsUnknown8DA136, <>rsUnknown8DA13B, <>rsUnknown8DA180, <>rsUnknown8DA185, <>rsUnknown8DA18F, <>rsUnknown8DA194, <>rsUnknown8DA199, <>rsUnknown8DA19E, <>rsUnknown8DA1A3, <>rsUnknown8DA1C0, <>rsUnknown8DA1DF, <>rsUnknown8DA1FA, <>rsUnknown8DA20B, <>rsUnknown8DA240, <>rsUnknown8DA258, <>rsUnknown8DA282, <>rsUnknown8DA287


      rsUnknown8DA0EC ; 8D/A0EC

        .al
        .xl
        .autsiz
        .databank ?

        ; Step 0 of aUnknown8DA0C6.

        lda aDialogue.wStatus,b
        beq _A0F2
        rts


        _A0F2
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0800, $80, $D000

        lda #$000B
        sta wGameStateStep,b
        lda #$0001
        sta wNextMenuState,b
        lda #$0000
        sta $7F5486
        rts

        .databank 0

        ; 8D/A113

      rsUnknown8DA113 ; 8D/A113

        .al
        .xl
        .autsiz
        .databank ?

        ; Step 1 of aUnknown8DA0C6.

        lda $7F5486
        cmp #$00C0
        bcs _A122
        inc a
        sta $7F5486
        rts


        _A122
        lda #$0000
        sta $7F5486
        lda #$000A
        sta wGameStateStep,b
        lda #$000C
        sta wNextMenuState,b
        rts

        .databank 0

        ; 8D/A136

      rsUnknown8DA136 ; 8D/A136

        .al
        .xl
        .autsiz
        .databank ?

        ; Step 2 of aUnknown8DA0C6.

        jsl rlSetupEpilogueCreditsDisplay
        rts

        .databank 0

        ; 8D/A13B

      rsUnknown8DA13B ; 8D/A13B

        .al
        .xl
        .autsiz
        .databank ?

        ; Step 3 of aUnknown8DA0C6.

        lda $7F5486
        bne _A161
        lda #(`aUnknown8DA504)<<8
        sta lR44+1
        lda #<>aUnknown8DA504
        sta lR44
        jsl rlHDMAEngineCreateEntry
        lda #(`aUnknown8DA4A8)<<8
        sta lR44+1
        lda #<>aUnknown8DA4A8
        sta lR44
        jsl rlHDMAEngineCreateEntry
        jsl rlUnknown8DA755

        _A161
        jsr rsUnknown8DA34D
        lda $7F5486
        inc a
        sta $7F5486
        cmp #$0060
        bcc _A17F
        lda #$0000
        sta $7F5486
        lda #$0004
        sta wGameStateStep,b

        _A17F
        rts

        .databank 0

        ; 8D/A180

      rsUnknown8DA180 ; 8D/A180

        .al
        .xl
        .autsiz
        .databank ?

        ; Step 4 of aUnknown8DA0C6.

        jsl rlUnknown8DA2AA
        rts

        .databank 0

        ; 8D/A185

      rsUnknown8DA185 ; 8D/A185

        .al
        .xl
        .autsiz
        .databank ?

        ; Step 5 of aUnknown8DA0C6.

        jsr rsUnknown8DA624
        jsr rsUnknown8DA624._A676
        jsr rsUnknown8DA624._A6E9
        rts

        .databank 0

        ; 8D/A18F

      rsUnknown8DA18F ; 8D/A18F

        .al
        .xl
        .autsiz
        .databank ?

        ; Step 6 of aUnknown8DA0C6.

        jsl rlSetupEpilogueRankingsDisplay
        rts

        .databank 0

        ; 8D/A194

      rsUnknown8DA194 ; 8D/A194

        .al
        .xl
        .autsiz
        .databank ?

        ; Step 7 of aUnknown8DA0C6.

        jsl rlUnknown8DAD73
        rts

        .databank 0

        ; 8D/A199

      rsUnknown8DA199 ; 8D/A199

        .al
        .xl
        .autsiz
        .databank ?

        ; Step 8 of aUnknown8DA0C6.

        jsl rlStartEpilogueCharacterEndings
        rts

        .databank 0

        ; 8D/A19E

      rsUnknown8DA19E ; 8D/A19E

        .al
        .xl
        .autsiz
        .databank ?

        ; Step 9 of aUnknown8DA0C6.

        jsl rlUnknown8DB4F1
        rts

        .databank 0

        ; 8D/A1A3

      rsUnknown8DA1A3 ; 8D/A1A3

        .al
        .xl
        .autsiz
        .databank ?

        ; Step 10 of aUnknown8DA0C6.

        lda wVBlankEnabledFramecount
        and #$0007
        bne _A1B4
        sep #$20
        lda bBufferINIDISP
        and #$0F
        beq _A1B7
        dec bBufferINIDISP

        _A1B4
        rep #$20
        rts


        _A1B7
        .as
        rep #$20
        lda wNextMenuState,b
        sta wGameStateStep,b
        rts

        .databank 0

        ; 8D/A1C0

      rsUnknown8DA1C0 ; 8D/A1C0

        .al
        .xl
        .autsiz
        .databank ?

        ; Step 11 of aUnknown8DA0C6.

        lda wVBlankEnabledFramecount
        and #$0007
        bne _A1D3
        sep #$20
        lda bBufferINIDISP
        and #$0F
        cmp #$0F
        beq _A1D6
        inc bBufferINIDISP

        _A1D3
        rep #$20
        rts


        _A1D6
        .as
        rep #$20
        lda wNextMenuState,b
        sta wGameStateStep,b
        rts

        .databank 0

        ; 8D/A1DF

      rsUnknown8DA1DF ; 8D/A1DF

        .al
        .xl
        .autsiz
        .databank ?

        ; Step 12 of aUnknown8DA0C6.

        lda #$FFFF
        sta wCurrentChapter,b
        lda #(`aEventChapterEpilogueWorldMap)<<8
        sta lR18+1
        lda #<>aEventChapterEpilogueWorldMap
        sta lR18
        jsl rlStartEventScript
        lda #$0005
        sta wGameStateStep,b
        rts

        .databank 0

        ; 8D/A1FA

      rsUnknown8DA1FA ; 8D/A1FA

        .al
        .xl
        .autsiz
        .databank ?

        ; Step 13 of aUnknown8DA0C6.

        jsl rlUnknown8DAF33
        lda #$000B
        sta wGameStateStep,b
        lda #$000E
        sta wNextMenuState,b
        rts

        .databank 0

        ; 8D/A20B

      rsUnknown8DA20B ; 8D/A20B

        .al
        .xl
        .autsiz
        .databank ?

        ; Step 14 of aUnknown8DA0C6.

        lda $7F5486
        inc a
        sta $7F5486
        cmp #$0B40
        bcs _A223
        cmp #$0100
        bcs _A21F

        _A21E
        rts


        _A21F
        lda wJoy1New
        beq _A21E

        _A223
        lda #$000A
        sta wGameStateStep,b
        lda #$0006
        sta wNextMenuState,b
        jsl rlCalculateFinalRankingScore
        cmp #$0003
        bcs _A23F
        lda #$00E3
        jsl rlQueueSoundCommand

        _A23F
        rts

        .databank 0

        ; 8D/A240

      rsUnknown8DA240 ; 8D/A240

        .al
        .xl
        .autsiz
        .databank ?

        ; Step 15 of aUnknown8DA0C6.

        jsl rlUnknown8DAFA5
        lda #$0000
        sta $7F5486
        lda #$000B
        sta wGameStateStep,b
        lda #$0010
        sta wNextMenuState,b
        rts

        .databank 0

        ; 8D/A258

      rsUnknown8DA258 ; 8D/A258

        .al
        .xl
        .autsiz
        .databank ?

        ; Step 16 of aUnknown8DA0C6.

        lda $7F5486
        cmp #$0180
        bcs _A267
        inc a
        sta $7F5486
        rts


        _A267
        lda #$0000
        sta $7F5486
        lda #$0011
        sta wGameStateStep,b
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8088, $0040, $80, $D500

        rts

        .databank 0

        ; 8D/A282

      rsUnknown8DA282 ; 8D/A282

        .al
        .xl
        .autsiz
        .databank ?

        ; Step 17 of aUnknown8DA0C6.

        jsl rlUnknown8DB276
        rts

        .databank 0

        ; 8D/A287

      rsUnknown8DA287 ; 8D/A287

        .al
        .xl
        .autsiz
        .databank ?

        ; Step 18 of aUnknown8DA0C6.

        rts

        .databank 0

        ; 8D/A288

    .endsection Unsorted8DA0C6Section


    .section Unsorted8DA288Section

      .al
      .xl

      rlUnknown8DA288 ; 8D/A288

        .al
        .xl
        .autsiz
        .databank ?

        stz $08DA,b
        lda #$FFFF
        sta wCurrentChapter,b
        lda #$ECC9
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        jsl rlUnknown88B3AF
        rtl

        .databank 0

        ; 8D/A2AA

    .endsection Unsorted8DA288Section


    .section Unsorted8DA2AASection

      .al
      .xl

      rlUnknown8DA2AA ; 8D/A2AA

        .al
        .xl
        .autsiz
        .databank ?

        lda wBufferBG2VOFS
        sec
        sbc #$0038
        clc
        adc #$0010
        cmp #$0000
        beq _A332
        lda $7F5491
        clc
        adc #$5500
        sta $7F5491
        lda $7F5490
        adc #$0000
        sta $7F5490
        lda #$0140
        sec
        sbc $7F5490
        sta wBufferBG1VOFS
        lda $7F5494
        clc
        adc #$3900
        sta $7F5494
        lda $7F5493
        adc #$0000
        sta $7F5493
        lda #$0140
        sec
        sbc $7F5493
        sta wBufferBG2VOFS
        lda wBufferBG2VOFS
        cmp #$0080
        bcc _A305
        jsr rsUnknown8DA34D

        _A305
        lda wBufferBG2VOFS
        cmp #$00E0
        bne _A310
        jsl rlUnknown8DA755

        _A310
        lda wBufferBG2VOFS
        cmp #$00A0
        bne _A324
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0400, $80, $AC00


        _A324
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8788, $0400, $80, $D400

        rtl


        _A332
        lda $7F5486
        inc a
        sta $7F5486
        cmp #$0040
        bcc _A324
        lda #$000A
        sta wGameStateStep,b
        lda #$000D
        sta wNextMenuState,b
        rtl

        .databank 0

        ; 8D/A34D

    .endsection Unsorted8DA2AASection


    .section Unsorted8DA34DSection

      .al
      .xl

      rsUnknown8DA34D ; 8D/A34D

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0000
        jsr rsUnknown8DA624
        ldx #$0002
        jsr rsUnknown8DA624
        ldx #$0004
        jsr rsUnknown8DA624
        ldx #$0006
        jsr rsUnknown8DA624
        ldx #$0008
        jsr rsUnknown8DA624
        ldx #$000A
        jsr rsUnknown8DA624
        rts

        .databank 0

        ; 8D/A372

    .endsection Unsorted8DA34DSection


    .section Unsorted8DA372Section

      .al
      .xl

      rsUnknown8DA372 ; 8D/A372

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda wJoy1New
        bit #$2000
        bne _A389
        bit #$8000
        bne _A3A4
        bit #$0040
        bne _A3CC
        bit #$4000
        bne _A3D1
        rts


        _A389
        lda #$0001
        sta $08DA,b
        lda #$ECC9
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        rts


        _A3A4
        lda #$0000
        sta wCurrentChapter,b
        lda #$0021
        jsl rlPlaySoundEffect
        lda #$0002
        sta wMainGameMode,b
        lda #<>rsUnknown80B122
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        rts


        _A3CC
        jsl rlSetupEpilogueRankingsDisplay
        rts


        _A3D1
        lda #$000A
        sta wGameStateStep,b
        lda #$000F
        sta wNextMenuState,b
        rts

        .databank 0

        ; 8D/A3DE

    .endsection Unsorted8DA372Section


    .section Unsorted8DA3DESection

      .al
      .xl

      rlUnknown8DA3DE ; 8D/A3DE

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0500
        tsb aDialogue.wStatus,b
        lda #$01FF
        sta aDialogue.wClearTile,b
        lda #$0001
        sta aDialogue.wTextSpeed,b
        lda #$0004
        sta aDialogue.wUnknown00188C,b
        lda #$0080
        sta $18E1,b,x
        lda #$0818
        sta $18DB,b,x
        lda #$4000
        sta $18D7,b,x
        lda #$7E00
        sta $18D5,b,x
        lda #$8388
        sta $18D4,b,x
        lda #$2000
        sta aDialogue.wBaseTile,b,x
        lda #$150C
        sta wR1
        sep #$20
        lda #$00
        sta wR0+1
        xba
        lda wR1
        sta wR0
        lda wR1+1
        xba
        rep #$20
        lsr a
        lsr a
        clc
        adc wR0
        sta wR0
        ldx aDialogue,b
        lda #$7E00
        sta $18D5,b,x
        lda #$8388
        clc
        adc wR0
        sta $18D4,b,x
        rtl

        .databank 0

        ; 8D/A449

    .endsection Unsorted8DA3DESection


    .section Unsorted8DA449Section

      .al
      .xl

      rlUnknown8DA449 ; 8D/A449

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0100
        tsb aDialogue.wStatus,b
        lda #$01FF
        sta aDialogue.wClearTile,b
        lda #$0001
        sta aDialogue.wTextSpeed,b
        lda #$101A
        sta $18DB,b,x
        lda #$4000
        sta $18D7,b,x
        lda #$7E00
        sta $18D5,b,x
        lda #$8388
        sta $18D4,b,x
        lda #$2000
        sta aDialogue.wBaseTile,b,x
        lda #$0809
        sta wR1
        sep #$20
        lda #$00
        sta wR0+1
        xba
        lda wR1
        sta wR0
        lda wR1+1
        xba
        rep #$20
        lsr a
        lsr a
        clc
        adc wR0
        sta wR0
        ldx aDialogue,b
        lda #$7E00
        sta $18D5,b,x
        lda #$8388
        clc
        adc wR0
        sta $18D4,b,x
        rtl

        .databank 0

        ; 8D/A4A8

      aUnknown8DA4A8 .dstruct structHDMADirectEntryInfo, rlUnknown8DA4B3, $A4B5, aUnknown8DA502, $0008BC, PPU_REG_BASE + $2C, $00 ; 8D/A4A8

    .endsection Unsorted8DA449Section


    .section Unsorted8DA4B3Section

      .al
      .xl

      rlUnknown8DA4B3 ; 8D/A4B3

        .al
        .xl
        .autsiz
        .databank ?

        rep #$20
        sep #$20
        lda #$18
        sta @l $0008BC
        lda #$00
        sta @l $0008BD
        lda #$58
        sta @l $0008BE
        lda bBufferTM
        sta @l $0008BF
        lda #$48
        sta @l $0008C0
        lda #$03
        sta @l $0008C1
        lda #$20
        sta @l $0008C2
        lda #$04
        sta @l $0008C3
        lda #$08
        sta @l $0008C4
        lda #$00
        sta @l $0008C5
        lda #$00
        sta @l $0008C6
        lda #$00
        sta @l $0008C7
        rep #$20
        rtl

        .databank 0

        ; 8D/A502

    .endsection Unsorted8DA4B3Section


    .section Table8DA502Section

      .al
      .xl

      aUnknown8DA502 ; 8D/A502
        HDMA_HALT

      aUnknown8DA504 .dstruct structHDMADirectEntryInfo, rlUnknown8DA50F, rlUnknown8DA50F, $A622, $7F56C9, PPU_REG_BASE + $0F, $02 ; 8D/A504

    .endsection Table8DA502Section


    .section Unsorted8DA50FSection

      .al
      .xl

      rlUnknown8DA50F ; 8D/A50F

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$60
        sta $7F56C9
        rep #$20
        lda wBufferBG2HOFS
        sta $7F56CA
        lda $7F5493
        cmp #$0064
        bcc _A52C
        jml _A60D


        _A52C
        sep #$20
        lda #$08
        clc
        adc #$04
        clc
        adc $7F5493
        sta $7F56CC
        rep #$20
        lda wBufferBG2HOFS
        sta $7F56CD
        ldx #$0015
        lda wVBlankEnabledFramecount
        lsr a
        lsr a
        and #$000F
        tay

        _A54F
        sep #$20
        lda #$01
        sta $7F56CF,x
        rep #$20
        lda $A612,b,y
        and #$00FF
        sta $7F56D0,x
        tya
        sec
        sbc #$0001
        and #$000F
        tay
        dec x
        dec x
        dec x
        bpl _A54F
        sep #$20
        lda #$08
        sta $7F56E7
        rep #$20
        lda wBufferBG2HOFS
        sta $7F56E8
        ldx #$002D
        lda wVBlankEnabledFramecount
        lsr a
        lsr a
        and #$000F
        tay

        _A58C
        sep #$20
        lda #$01
        sta $7F56EA,x
        rep #$20
        lda $A612,b,y
        and #$00FF
        sta $7F56EB,x
        tya
        sec
        sbc #$0001
        and #$000F
        tay
        dec x
        dec x
        dec x
        bpl _A58C
        sep #$20
        lda #$08
        sta $7F571A
        rep #$20
        lda wBufferBG2HOFS
        sta $7F571B
        ldx #$0015
        lda wVBlankEnabledFramecount
        lsr a
        lsr a
        and #$000F
        tay

        _A5C9
        sep #$20
        lda #$01
        sta $7F571D,x
        rep #$20
        lda $A612,b,y
        and #$00FF
        sta $7F571E,x
        tya
        sec
        sbc #$0001
        and #$000F
        tay
        dec x
        dec x
        dec x
        bpl _A5C9
        sep #$20
        lda #$08
        sta $7F5735
        rep #$20
        lda wBufferBG2HOFS
        sta $7F5736
        sep #$20
        lda #$00
        sta $7F5738
        rep #$20
        lda #$0000
        sta $7F5739
        rtl


        _A60D
        jsl rlHDMAEngineFreeEntryByOffset
        rtl

        .databank 0

        ; 8D/A612

    .endsection Unsorted8DA50FSection


    .section Unsorted8DA624Section

      .al
      .xl

      rsUnknown8DA624 ; 8D/A624

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda aWorldMapPortrait,x
        asl a
        tax
        lda wVBlankEnabledFramecount
        and #$0001
        bne _A638
        lda aUnknown8DA73D,x
        bra _A63E


        _A638
        lda aUnknown8DA743,x
        bra _A63E


        _A63E
        sta wR0
        lda wVBlankEnabledFramecount
        and #$0001
        bne _A64D
        lda aUnknown8DA749,x
        bra _A653


        _A64D
        lda aUnknown8DA74F,x
        bra _A653


        _A653
        sta wR1
        plx
        lda $7F5420,x
        clc
        adc #$0020
        bmi _A676
        lda $7F5420,x
        sec
        sbc wR0
        sta $7F5420,x
        lda $7F5430,x
        sec
        sbc wR1
        sta $7F5430,x

        _A676
        lda $7F5410,x
        dec a
        sta $7F5410,x
        bpl _A6BD
        lda aWorldMapMarker,x
        inc a

        _A686
        sta aWorldMapMarker,x
        phx
        asl a
        asl a
        sta wR0
        lda aWorldMapPortrait,x
        asl a
        tax
        lda aUnknown8DA737,x
        clc
        adc wR0
        tax
        lda aUnknown8DCF88,x
        cmp #$FFFF
        bne _A6AC
        lda #$0000
        plx
        bra _A686


        _A6AC
        sta wR0
        lda aUnknown8DCF88+2,x
        plx
        sta $7F5410,x
        lda wR0
        sta $7F5440,x

        _A6BD
        sep #$20
        lda #$8D
        pha
        plb
        .databank $8D
        rep #$20
        lda $7F5440,x
        tay
        lda $7F5420,x
        sta wR0
        lda #$0030
        lda $7F5430,x
        sta wR1
        lda #$0000
        sta wR5
        lda #$0000
        sta wR4
        phx
        jsl rlPushToOAMBuffer
        plx

        _A6E9
        sep #$20
        lda #$8D
        pha
        plb
        .databank $8D
        rep #$20
        lda aWorldMapMarker,x
        asl a
        asl a
        phx
        sta wR0
        lda aWorldMapPortrait,x
        asl a
        tax
        lda @l aUnknown8DA737,x
        clc
        adc wR0
        tax
        lda @l aUnknown8DCF9A,x
        tay
        plx
        lda #$0080
        lda $7F5420,x
        sta wR0
        lda #$00D0
        sec
        sbc $7F5430,x
        clc
        adc $7F5493
        sta wR1
        lda #$0000
        sta wR5
        lda #$0000
        sta wR4
        phx
        jsl rlPushToOAMBuffer
        plx
        rts

        .databank 0

        ; 8D/A737

    .endsection Unsorted8DA624Section


    .section Data8DA737Section

      .al
      .xl

      aUnknown8DA737 ; 8D/A737

        ; Read by rsUnknown8DA624.

        .word $0000, $0024, $0048

        ; 8D/A73D

      aUnknown8DA73D ; 8D/A73D

        ; Read by rsUnknown8DA624.

        .word $0001, $0001, $0002

        ; 8D/A743

      aUnknown8DA743 ; 8D/A743

        ; Read by rsUnknown8DA624.

        .word $0002, $0001, $0002

        ; 8D/A749

      aUnknown8DA749 ; 8D/A749

        ; Read by rsUnknown8DA624.

        .word $0000, $0000, $0000

        ; 8D/A74F

      aUnknown8DA74F ; 8D/A74F

        ; Read by rsUnknown8DA624.

        .word $0000, $0000, $0001

        ; 8D/A755

    .endsection Data8DA737Section


    .section Unsorted8DA755Section

      .al
      .xl

      rlUnknown8DA755 ; 8D/A755

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0000
        lda #$0100
        sta $7F5420,x
        lda #$0028
        sta $7F5430,x
        lda #$0001
        sta aWorldMapMarker,x
        lda #$0001
        sta aWorldMapPortrait,x
        ldx #$0002
        lda #$0140
        sta $7F5420,x
        lda #$0048
        sta $7F5430,x
        lda #$0000
        sta aWorldMapMarker,x
        lda #$0002
        sta aWorldMapPortrait,x
        ldx #$0004
        lda #$0138
        sta $7F5420,x
        lda #$0034
        sta $7F5430,x
        lda #$0002
        sta aWorldMapMarker,x
        lda #$0000
        sta aWorldMapPortrait,x
        ldx #$0006
        lda #$0130
        sta $7F5420,x
        lda #$0040
        sta $7F5430,x
        lda #$0002
        sta aWorldMapMarker,x
        lda #$0001
        sta aWorldMapPortrait,x
        ldx #$0008
        lda #$0150
        sta $7F5420,x
        lda #$0058
        sta $7F5430,x
        lda #$0000
        sta aWorldMapMarker,x
        lda #$0002
        sta aWorldMapPortrait,x
        ldx #$000A
        lda #$01A8
        sta $7F5420,x
        lda #$0068
        sta $7F5430,x
        lda #$0001
        sta aWorldMapMarker,x
        lda #$0002
        sta aWorldMapPortrait,x
        rtl

        .databank 0

        ; 8D/A810

    .endsection Unsorted8DA755Section


    .section Unsorted8DA810Section

      .al
      .xl

      rlUnknown8DA810 ; 8D/A810

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0009
        sta wCurrentChapter,b
        lda #$0002
        sta wMainGameMode,b
        lda #$FFFF
        sta wMapStateFlags,b
        lda #$0080
        sta wCursorXOffset,b
        sta wCursorYOffset,b
        rtl

        .databank 0

        ; 8D/A82C

      rlUnknown8DA82C ; 8D/A82C

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0002
        sta wCurrentChapter,b
        lda #$0002
        sta wMainGameMode,b
        lda #$FFFF
        sta wMapStateFlags,b
        lda #$0080
        sta wCursorXOffset,b
        sta wCursorYOffset,b
        rtl

        .databank 0

        ; 8D/A848

      rlUnknown8DA848 ; 8D/A848

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0007
        sta wCurrentChapter,b
        lda #$0002
        sta wMainGameMode,b
        lda #$FFFF
        sta wMapStateFlags,b
        lda #$0080
        sta wCursorXOffset,b
        sta wCursorYOffset,b
        rtl

        .databank 0

        ; 8D/A864

      rlUnknown8DA864 ; 8D/A864

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$000B
        sta wCurrentChapter,b
        lda #$0002
        sta wMainGameMode,b
        lda #$FFFF
        sta wMapStateFlags,b
        lda #$0080
        sta wCursorXOffset,b
        sta wCursorYOffset,b
        rtl

        .databank 0

        ; 8D/A880

      rlUnknown8DA880 ; 8D/A880

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$80
        sta $2100,b
        sta bBufferINIDISP
        rep #$20
        jsl rlDisableVBlank
        jsl rlResetHDMAEngine
        jsl rlInitMapMenus
        jsl rlDisableMapMenuUploads
        sep #$20
        rep #$10
        ldx #<>gcUnknownD44143
        stx DecompressionVariables
        lda #`gcUnknownD44143
        sta $CA
        ldx #$7B88
        stx $CB
        lda #$7E
        sta $CD
        rep #$30
        jsl rlDecompressor
        jsl rlDMAByStruct

          .structDMAToVRAM $7E7B88, $0800, $80, $A800

        sep #$20
        rep #$10
        ldx #<>gcUnknownD43402
        stx DecompressionVariables
        lda #`gcUnknownD43402
        sta $CA
        ldx #$9388
        stx $CB
        lda #$7E
        sta $CD
        rep #$30
        jsl rlDecompressor
        jsl rlDMAByStruct

          .structDMAToVRAM $7E9388, $1000, $80, $6000

        sep #$20
        rep #$10
        ldx #<>gcUnknownD4486F
        stx DecompressionVariables
        lda #`gcUnknownD4486F
        sta $CA
        ldx #$8388
        stx $CB
        lda #$7E
        sta $CD
        rep #$30
        jsl rlDecompressor
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0800, $80, $B000

        sep #$20
        rep #$10
        ldx #<>gcUnknownD4429B
        stx DecompressionVariables
        lda #`gcUnknownD4429B
        sta $CA
        ldx #$A388
        stx $CB
        lda #$7E
        sta $CD
        rep #$30
        jsl rlDecompressor
        jsl rlDMAByStruct

          .structDMAToVRAM $7EA388, $0800, $80, $8000

        lda #(`procUnknown8DAA96)<<8
        sta lR44+1
        lda #<>procUnknown8DAA96
        sta lR44
        jsl rlProcEngineCreateProc
        sep #$20
        lda #$11
        sta bBufferTM
        lda #$06
        sta bBufferTS
        sta bBufferTSW
        lda #$02
        sta bBufferCGWSEL
        lda #$27
        sta bBufferCGADSUB
        rep #$20
        ldx #$001E

        _A966
        lda aUnknown8CEBC0,x
        sta aBGPaletteBuffer.aPalette6,b,x
        dec x
        dec x
        bpl _A966
        ldx #$001C

        _A974
        lda aUnknown8CEB00+2,x
        sta $0102,b,x
        dec x
        dec x
        bpl _A974
        jsl rlEnableVBlank
        sep #$20
        lda #$00
        sta bBufferINIDISP
        rep #$20
        rtl

        .databank 0

        ; 8D/A98C

      rlUnknown8DA98C ; 8D/A98C

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$80
        sta $2100,b
        sta bBufferINIDISP
        rep #$20
        jsl rlDisableVBlank
        jsl rlInitMapMenus
        jsl rlDisableMapMenuUploads
        sep #$20
        rep #$10
        ldx #<>gcUnknownD44143
        stx DecompressionVariables
        lda #`gcUnknownD44143
        sta $CA
        ldx #$7B88
        stx $CB
        lda #$7E
        sta $CD
        rep #$30
        jsl rlDecompressor
        jsl rlDMAByStruct

          .structDMAToVRAM $7E7B88, $0800, $80, $A800

        sep #$20
        rep #$10
        ldx #<>gcUnknownD43402
        stx DecompressionVariables
        lda #`gcUnknownD43402
        sta $CA
        ldx #$9388
        stx $CB
        lda #$7E
        sta $CD
        rep #$30
        jsl rlDecompressor
        jsl rlDMAByStruct

          .structDMAToVRAM $7E9388, $1000, $80, $6000

        sep #$20
        rep #$10
        ldx #<>gcUnknownD4486F
        stx DecompressionVariables
        lda #`gcUnknownD4486F
        sta $CA
        ldx #$8388
        stx $CB
        lda #$7E
        sta $CD
        rep #$30
        jsl rlDecompressor
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0800, $80, $B000

        sep #$20
        rep #$10
        ldx #<>gcUnknownD4429B
        stx DecompressionVariables
        lda #`gcUnknownD4429B
        sta $CA
        ldx #$A388
        stx $CB
        lda #$7E
        sta $CD
        rep #$30
        jsl rlDecompressor
        jsl rlDMAByStruct

          .structDMAToVRAM $7EA388, $0800, $80, $8000

        lda #(`procUnknown8DAA96)<<8
        sta lR44+1
        lda #<>procUnknown8DAA96
        sta lR44
        jsl rlProcEngineCreateProc
        sep #$20
        lda #$06
        sta bBufferTM
        sta bBufferTMW
        lda #$11
        sta bBufferTS
        sta bBufferTSW
        lda #$02
        sta bBufferCGWSEL
        lda #$27
        sta bBufferCGADSUB
        rep #$20
        ldx #$001E

        _AA70
        lda aUnknown8CEBC0,x
        sta aBGPaletteBuffer.aPalette6,b,x
        dec x
        dec x
        bpl _AA70
        ldx #$001C

        _AA7E
        lda aUnknown8CEB00+2,x
        sta $0102,b,x
        dec x
        dec x
        bpl _AA7E
        jsl rlEnableVBlank
        sep #$20
        lda #$00
        sta bBufferINIDISP
        rep #$20
        rtl

        .databank 0

        ; 8D/AA96

    .endsection Unsorted8DA810Section


    .section Unsorted8DAA96Section

      .al
      .xl

      procUnknown8DAA96 ; 8D/AA96

        .structProcInfo "KM", rlUnknown8DAA9E, rlUnknown8DAA9E._AAA4, aProcUnknown8DAA96Code

    .endsection Unsorted8DAA96Section


    .section Unsorted8DAA9ESection

      .al
      .xl

      rlUnknown8DAA9E ; 8D/AA9E

        .al
        .xl
        .autsiz
        .databank ?

        lda wMapScrollXPixels,b
        sta aProcSystem.aBody0,b,x

        _AAA4
        lda wMapScrollXPixels,b
        cmp aProcSystem.aBody0,b,x
        beq _AABF
        sta aProcSystem.aBody0,b,x
        lda wBufferBG2HOFS
        clc
        adc wMapScrollSpeed,b
        sta wBufferBG2HOFS
        lda wBufferBG3HOFS
        clc
        adc wMapScrollSpeed,b
        sta wBufferBG3HOFS

        _AABF
        lda wVBlankEnabledFramecount
        and #$0001
        bne _AAD7
        lda wBufferBG2HOFS
        inc a
        sta wBufferBG2HOFS
        lda wVBlankEnabledFramecount
        and #$0003
        bne _AAD7
        lda wBufferBG3HOFS
        inc a
        sta wBufferBG3HOFS

        _AAD7
        lda wVBlankEnabledFramecount
        and #$0003
        bne _AAEF
        lda wBufferBG2VOFS
        dec a
        sta wBufferBG2VOFS
        lda wVBlankEnabledFramecount
        and #$0007
        bne _AAEF
        lda wBufferBG3VOFS
        dec a
        sta wBufferBG3VOFS

        _AAEF
        lda wGameStateRoutine1,b
        beq _AAF5

        _AAF4
        rtl


        _AAF5
        jsl rlProcEngineFreeProc
        bra _AAF4

        .databank 0

        ; 8D/AAFB

    .endsection Unsorted8DAA9ESection


    .section Unsorted8DAAFBSection

      .al
      .xl

      aProcUnknown8DAA96Code ; 8D/AAFB

        PROC_HALT


        ; 8D/AAFD

    .endsection Unsorted8DAAFBSection


    .section Unsorted8DAD73Section

      .al
      .xl

      rlUnknown8DAD73 ; 8D/AD73

        .al
        .xl
        .autsiz
        .databank ?

        lda aDialogue.wStatus,b
        beq _AD91
        dec wBufferBG1VOFS
        lda wVBlankEnabledFramecount
        and #$0007
        bne _AD83
        inc wBufferBG2VOFS

        _AD83
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0800, $80, $D000

        rtl


        _AD91
        lda #$000A
        sta wGameStateStep,b
        lda #$000F
        sta wNextMenuState,b
        rtl

        .databank 0

        ; 8D/AD9E

    .endsection Unsorted8DAD73Section


    .section Unsorted8DAD9ESection

      .al
      .xl

      rsUnknown8DAD9E ; 8D/AD9E

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda wJoy1New
        bit #$8000
        bne _ADB0
        bit #$2000
        bne _ADD8
        bit #$0040
        bne _ADF5
        rts


        _ADB0
        lda #$0000
        sta wCurrentChapter,b
        lda #$0021
        jsl rlPlaySoundEffect
        lda #$0002
        sta wMainGameMode,b
        lda #<>rsUnknown80B122
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        rts


        _ADD8
        jsl rlResetDialogueEngine
        lda #(`dialogueEpilogueCredits8DC9A6)<<8
        sta lR18+1
        lda #<>dialogueEpilogueCredits8DC9A6
        sta lR18
        lda #$0002
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsl rlUnknown8DA3DE
        rts


        _ADF5
        jsl rlStartEpilogueCharacterEndings
        rts

        .databank 0

        ; 8D/ADFA

    .endsection Unsorted8DAD9ESection


    .section Table8DADFASection

      .al
      .xl

      aUnknown8DADFA .dstruct structHDMADirectEntryInfo, rlUnknown8DAE05, rlUnknown8DAE05, aUnknown8DAE30, $7F56C9, PPU_REG_BASE + $00, $00 ; 8D/ADFA

      rlUnknown8DAE05 ; 8D/AE05

        .al
        .xl
        .autsiz
        .databank ?

        phk
        plb
        .databank $8D
        rep #$20
        ldx #$0000
        ldy #$0000
        sep #$20

        _AE11
        lda aUnknown8DAE32,y
        sta $7F56C9,x
        beq _AE2D
        lda $AE33,b,y
        cmp bBufferINIDISP
        bcc _AE23
        lda bBufferINIDISP

        _AE23
        sta $7F56CA,x
        inc x
        inc x
        inc y
        inc y
        bra _AE11


        _AE2D
        rep #$20
        rtl

        .databank 0

        ; 8D/AE30

      aUnknown8DAE30 ; 8D/AE30
        HDMA_HALT

      aUnknown8DAE32 ; 8D/AE32
        .byte $24, $00, $01, $01, $02, $03, $03, $05, $04, $07, $05, $09, $06, $0B, $08, $0D
        .byte $28, $0F, $08, $0D, $08, $0B, $08, $09, $06, $07, $04, $05, $03, $03, $02, $01
        .byte $01, $00, $00, $00, $28, $00, $01, $01, $02, $03, $03, $05, $04, $07, $04, $09
        .byte $04, $0B, $04, $0D, $28, $0F, $08, $0D, $08, $0B, $08, $09, $04, $07, $04, $05
        .byte $04, $03, $04, $01, $01, $00, $00, $00

      aUnknown8DAE7A .dstruct structHDMADirectEntryInfo, rlUnknown8DAE85, rlUnknown8DAE85, $AEC0, $7F56C9, PPU_REG_BASE + $2C, $00 ; 8D/AE7A

    .endsection Table8DADFASection


    .section Unsorted8DAE85Section

      .al
      .xl

      rlUnknown8DAE85 ; 8D/AE85

        .al
        .xl
        .autsiz
        .databank ?

        phk
        plb
        .databank $8D
        sep #$20
        lda #$18
        sta $7F56C9
        lda #$00
        lda #$00
        sta $7F56CA
        lda #$64
        sta $7F56CB
        lda #$06
        sta $7F56CC
        lda #$24
        sta $7F56CD
        lda #$00
        lda #$00
        sta $7F56CE
        lda #$00
        sta $7F56CF
        lda #$00
        sta $7F56D0
        rep #$20
        rtl

        .databank 0

        ; 8D/AEC0

    .endsection Unsorted8DAE85Section


    .section Unsorted8DAEC2Section

      .al
      .xl

      rlUnknown8DAEC2 ; 8D/AEC2

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0500
        tsb aDialogue.wStatus,b
        lda #$03FF
        sta aDialogue.wClearTile,b
        lda #$0001
        sta aDialogue.wTextSpeed,b
        lda #$0004
        sta aDialogue.wUnknown00188C,b
        lda #$0080
        sta $18E1,b,x
        lda #$0026
        sta $18DD,b
        lda #$101C
        sta $18DB,b,x
        lda #$4000
        sta $18D7,b,x
        lda #$7E00
        sta $18D5,b,x
        lda #$8388
        sta $18D4,b,x
        lda #$2000
        sta aDialogue.wBaseTile,b,x
        lda #$0102
        sta wR1
        sep #$20
        lda #$00
        sta wR0+1
        xba
        lda wR1
        sta wR0
        lda wR1+1
        xba
        rep #$20
        lsr a
        lsr a
        clc
        adc wR0
        sta wR0
        ldx aDialogue,b
        lda #$7E00
        sta $18D5,b,x
        lda #$8388
        clc
        adc wR0
        sta $18D4,b,x
        rtl

        .databank 0

        ; 8D/AF33

    .endsection Unsorted8DAEC2Section


    .section Unsorted8DAF33Section

      .al
      .xl

      rlUnknown8DAF33 ; 8D/AF33

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$80
        sta $2100,b
        sta bBufferINIDISP
        rep #$20
        jsl rlDisableVBlank
        jsl rlResetHDMAEngine
        jsl rlUnknown9180BC
        jsl rlDialogueFreeHDMA
        stz wBufferBG2VOFS
        lda #(`aDecompressionDMAEntry8DAF95)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry8DAF95
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        lda #(`aDecompressionDMAEntry8DAF9D)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry8DAF9D
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        ldx #$01FE

        _AF6F
        lda aUnknown8CA400,x
        sta aBGPaletteBuffer,b,x
        dec x
        dec x
        bpl _AF6F
        lda #$0000
        sta aBGPaletteBuffer,b
        jsl rlEnableVBlank
        sep #$20
        lda #$00
        sta bBufferINIDISP
        lda #$02
        sta bBufferTM
        lda #$00
        sta bBufferTS
        rep #$20
        rtl

        .databank 0

        ; 8D/AF95

    .endsection Unsorted8DAF33Section


    .section Unsorted8DAFA5Section

      .al
      .xl

      rlUnknown8DAFA5 ; 8D/AFA5

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$80
        sta $2100,b
        sta bBufferINIDISP
        rep #$20
        jsl rlDisableVBlank
        jsl rlResetHDMAEngine
        jsl rlUnknown9180BC
        jsl rlDialogueFreeHDMA
        stz wBufferBG2VOFS
        stz wBufferBG3VOFS
        lda #(`aDecompressionDMAEntry8DB056)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry8DB056
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        lda #(`aDecompressionDMAEntry8DB066)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry8DB066
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        sep #$20
        rep #$10
        ldx #<>gcUnknownD428B8
        stx DecompressionVariables
        lda #`gcUnknownD428B8
        sta $CA
        ldx #$8388
        stx $CB
        lda #$7E
        sta $CD
        rep #$30
        jsl rlDecompressor
        jsr rsUnknown8DB06E
        jsr rsUnknown8DB150
        jsr rsUnknown8DB1DD
        jsr rsUnknown8DB217
        jsr rsUnknown8DB252
        ldx #$00BE

        _B00E
        lda $7E8888,x
        sta $7E8088,x
        dec x
        dec x
        bpl _B00E
        ldx #$00BE
        lda #$007F

        _B020
        sta $7E8888,x
        dec x
        dec x
        bpl _B020
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0800, $80, $D000

        sep #$20
        lda #$06
        sta bBufferTM
        lda #$01
        sta bBufferTS
        lda #$00
        sta bBufferCGWSEL
        lda #$00
        sta bBufferCGADSUB
        rep #$20
        jsl rlEnableVBlank
        sep #$20
        lda #$00
        sta bBufferINIDISP
        rep #$20
        rtl

        .databank 0

        ; 8D/B056

    .endsection Unsorted8DAFA5Section


    .section Unsorted8DB06ESection

      .al
      .xl

      rsUnknown8DB06E ; 8D/B06E

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlCalculateTacticsRanking
        asl a
        sta wR0
        clc
        adc #$2820
        sta $7E8564
        lda wR0
        clc
        adc #$2821
        sta $7E8566
        lda wR0
        clc
        adc #$2830
        sta $7E85A4
        lda wR0
        clc
        adc #$2831
        sta $7E85A6
        jsl rlCalculateExperienceRanking
        asl a
        sta wR0
        clc
        adc #$2820
        sta $7E8578
        lda wR0
        clc
        adc #$2821
        sta $7E857A
        lda wR0
        clc
        adc #$2830
        sta $7E85B8
        lda wR0
        clc
        adc #$2831
        sta $7E85BA
        jsl rlCalculateSurvivalRanking
        asl a
        sta wR0
        clc
        adc #$2820
        sta $7E85E4
        lda wR0
        clc
        adc #$2821
        sta $7E85E6
        lda wR0
        clc
        adc #$2830
        sta $7E8624
        lda wR0
        clc
        adc #$2831
        sta $7E8626
        jsl rlCalculateCombatRanking
        asl a
        sta wR0
        clc
        adc #$2820
        sta $7E85F8
        lda wR0
        clc
        adc #$2821
        sta $7E85FA
        lda wR0
        clc
        adc #$2830
        sta $7E8638
        lda wR0
        clc
        adc #$2831
        sta $7E863A
        jsl rlCalculateFinalRankingScore
        asl a
        sta wR0
        clc
        adc #$2820
        sta $7E86F6
        lda wR0
        clc
        adc #$2821
        sta $7E86F8
        lda wR0
        clc
        adc #$2830
        sta $7E8736
        lda wR0
        clc
        adc #$2831
        sta $7E8738
        rts

        .databank 0

        ; 8D/B150

    .endsection Unsorted8DB06ESection


    .section Unsorted8DB150Section

      .al
      .xl

      rsUnknown8DB150 ; 8D/B150

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlGetGameTimeHoursMinutes
        txa
        sta wR0
        stz wR2
        stz wR3
        stz wR4
        stz wR5

        _B15F
        lda wR0
        cmp #$03E8
        bcc _B176
        sec
        sbc #$03E8
        sta wR0
        lda wR2
        clc
        adc #$0001
        sta wR2
        bra _B15F


        _B176
        lda wR0
        cmp #$0064
        bcc _B18D
        sec
        sbc #$0064
        sta wR0
        lda wR3
        clc
        adc #$0001
        sta wR3
        bra _B176


        _B18D
        lda wR0
        cmp #$000A
        bcc _B1A4
        sec
        sbc #$000A
        sta wR0
        lda wR4
        clc
        adc #$0001
        sta wR4
        bra _B18D


        _B1A4
        lda wR0
        sta wR5
        lda wR2
        clc
        adc #$0075
        ora #$3400
        sta $7E889C
        lda wR3
        clc
        adc #$0075
        ora #$3400
        sta $7E889E
        lda wR4
        clc
        adc #$0075
        ora #$3400
        sta $7E88A0
        lda wR5
        clc
        adc #$0075
        ora #$3400
        sta $7E88A2
        rts

        .databank 0

        ; 8D/B1DD

    .endsection Unsorted8DB150Section


    .section Unsorted8DB1DDSection

      .al
      .xl

      rsUnknown8DB1DD ; 8D/B1DD

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlGetGameTimeHoursMinutes
        sta wR0
        stz wR4

        _B1E5
        lda wR0
        cmp #$000A
        bcc _B1FC
        sec
        sbc #$000A
        sta wR0
        lda wR4
        clc
        adc #$0001
        sta wR4
        bra _B1E5


        _B1FC
        lda wR4
        clc
        adc #$0075
        ora #$3400
        sta $7E88A6
        lda wR0
        clc
        adc #$0075
        ora #$3400
        sta $7E88A8
        rts

        .databank 0

        ; 8D/B217

    .endsection Unsorted8DB1DDSection


    .section Unsorted8DB217Section

      .al
      .xl

      rsUnknown8DB217 ; 8D/B217

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlGetCurrentSaveCompletionCount
        inc a
        sta wR0
        stz wR4

        _B220
        lda wR0
        cmp #$000A
        bcc _B237
        sec
        sbc #$000A
        sta wR0
        lda wR4
        clc
        adc #$0001
        sta wR4
        bra _B220


        _B237
        lda wR4
        clc
        adc #$0075
        ora #$3400
        sta $7E88BA
        lda wR0
        clc
        adc #$0075
        ora #$3400
        sta $7E88BC
        rts

        .databank 0

        ; 8D/B252

    .endsection Unsorted8DB217Section


    .section Unsorted8DB252Section

      .al
      .xl

      rsUnknown8DB252 ; 8D/B252

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$001E

        _B255
        phx
        sep #$20
        txa
        lsr a
        tax
        lda aUnknown7FC70A,x
        sec
        sbc #$41
        rep #$20
        plx
        clc
        adc #$0080
        ora #$3800
        sta $7E8918,x
        dec x
        dec x
        txa
        bpl _B255
        rts

        .databank 0

        ; 8D/B276

    .endsection Unsorted8DB252Section


    .section Unsorted8DB276Section

      .al
      .xl

      rlUnknown8DB276 ; 8D/B276

        .al
        .xl
        .autsiz
        .databank ?

        phk
        plb
        .databank $8D
        lda wJoy1New
        beq _B29A
        sta wR0
        lda $7F5486
        asl a
        tax
        lda @l aUnknown8DB2B8,x
        cmp wR0
        bne _B2AF
        lda $7F5486
        cmp #$000B
        beq _B29B
        inc a
        sta $7F5486

        _B29A
        rtl


        _B29B
        lda #$0012
        sta wGameStateStep,b
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8108, $0040, $80, $D580

        rtl


        _B2AF
        lda #$0000
        sta $7F5486
        bra _B29A

        .databank 0

        ; 8D/B2B8

    .endsection Unsorted8DB276Section


    .section Unsorted8DB2B8Section

      .al
      .xl

      aUnknown8DB2B8 ; 8D/B2B8

        ; A button sequence: rlUnknown8DB276 compares each new press with the next
        ; entry and goes to step $12 after the twelfth. Select, Up, A, Down, B, Left,
        ; X, Right, Y, L, R, Start.
        .word $2000, $0800, $0080, $0400, $8000, $0200, $0040, $0100, $4000, $0020, $0010, $1000


      rlUnknown8DB2D0 ; 8D/B2D0

        .al
        .xl
        .autsiz
        .databank ?

        ; One of 13 alike: stores a chapter's turn count (aChapterTurncounts) in $18AD
        ; and runs rsUnknown8DB386. Word pointers to these sit at $8D/CA4A-CBF2, in
        ; data not built yet.

        ldx #$0000
        lda aChapterTurncounts,b,x
        sta aDialogue.wNumber1,b
        jsr rsUnknown8DB386
        rtl

        .databank 0

        ; 8D/B2DD

      rlUnknown8DB2DD ; 8D/B2DD

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0002
        lda aChapterTurncounts,b,x
        sta aDialogue.wNumber1,b
        jsr rsUnknown8DB386
        rtl

        .databank 0

        ; 8D/B2EA

      rlUnknown8DB2EA ; 8D/B2EA

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0004
        lda aChapterTurncounts,b,x
        sta aDialogue.wNumber1,b
        jsr rsUnknown8DB386
        rtl

        .databank 0

        ; 8D/B2F7

      rlUnknown8DB2F7 ; 8D/B2F7

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0006
        lda aChapterTurncounts,b,x
        sta aDialogue.wNumber1,b
        jsr rsUnknown8DB386
        rtl

        .databank 0

        ; 8D/B304

      rlUnknown8DB304 ; 8D/B304

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0008
        lda aChapterTurncounts,b,x
        sta aDialogue.wNumber1,b
        jsr rsUnknown8DB386
        rtl

        .databank 0

        ; 8D/B311

      rlUnknown8DB311 ; 8D/B311

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$000A
        lda aChapterTurncounts,b,x
        sta aDialogue.wNumber1,b
        jsr rsUnknown8DB386
        rtl

        .databank 0

        ; 8D/B31E

      rlUnknown8DB31E ; 8D/B31E

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$000C
        lda aChapterTurncounts,b,x
        sta aDialogue.wNumber1,b
        jsr rsUnknown8DB386
        rtl

        .databank 0

        ; 8D/B32B

      rlUnknown8DB32B ; 8D/B32B

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$000E
        lda aChapterTurncounts,b,x
        sta aDialogue.wNumber1,b
        jsr rsUnknown8DB386
        rtl

        .databank 0

        ; 8D/B338

      rlUnknown8DB338 ; 8D/B338

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0010
        lda aChapterTurncounts,b,x
        sta aDialogue.wNumber1,b
        jsr rsUnknown8DB386
        rtl

        .databank 0

        ; 8D/B345

      rlUnknown8DB345 ; 8D/B345

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0012
        lda aChapterTurncounts,b,x
        sta aDialogue.wNumber1,b
        jsr rsUnknown8DB386
        rtl

        .databank 0

        ; 8D/B352

      rlUnknown8DB352 ; 8D/B352

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0014
        lda aChapterTurncounts,b,x
        sta aDialogue.wNumber1,b
        jsr rsUnknown8DB386
        rtl

        .databank 0

        ; 8D/B35F

      rlUnknown8DB35F ; 8D/B35F

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0016
        lda aChapterTurncounts,b,x
        sta aDialogue.wNumber1,b
        jsr rsUnknown8DB386
        rtl

        .databank 0

        ; 8D/B36C

      rlUnknown8DB36C ; 8D/B36C

        .al
        .xl
        .autsiz
        .databank ?

        stz aDialogue.wNumber1,b
        phx
        ldx #$0016

        _B373
        lda aChapterTurncounts,b,x
        clc
        adc aDialogue.wNumber1,b
        sta aDialogue.wNumber1,b
        dec x
        dec x
        bpl _B373
        plx
        jsr rsUnknown8DB3B4
        rtl

        .databank 0

        ; 8D/B386

      rsUnknown8DB386 ; 8D/B386

        .al
        .xl
        .autsiz
        .databank ?

        lda aDialogue.wNumber1,b
        cmp #$000A
        bcc _B395
        cmp #$0064
        bcs _B3B3
        bra _B3A4


        _B395
        lda #(`dialogueEpilogueCredits8DCC3D)<<8
        sta lR18+1
        lda #<>dialogueEpilogueCredits8DCC3D
        sta lR18
        jsl rlDialoguePushToActivePointerStack
        rts


        _B3A4
        lda #(`dialogueEpilogueCredits8DCC39)<<8
        sta lR18+1
        lda #<>dialogueEpilogueCredits8DCC39
        sta lR18
        jsl rlDialoguePushToActivePointerStack
        rts


        _B3B3
        rts

        .databank 0

        ; 8D/B3B4

      rsUnknown8DB3B4 ; 8D/B3B4

        .al
        .xl
        .autsiz
        .databank ?

        lda aDialogue.wNumber1,b
        cmp #$000A
        bcc _B3CD
        cmp #$0064
        bcc _B3DC
        cmp #$03E8
        bcc _B3EB
        cmp #$2710
        bcc _B3FA
        bra _B409


        _B3CD
        lda #(`dialogueEpilogueCredits8DCC54)<<8
        sta lR18+1
        lda #<>dialogueEpilogueCredits8DCC54
        sta lR18
        jsl rlDialoguePushToActivePointerStack
        rts


        _B3DC
        lda #(`dialogueEpilogueCredits8DCC4C)<<8
        sta lR18+1
        lda #<>dialogueEpilogueCredits8DCC4C
        sta lR18
        jsl rlDialoguePushToActivePointerStack
        rts


        _B3EB
        lda #(`dialogueEpilogueCredits8DCC46)<<8
        sta lR18+1
        lda #<>dialogueEpilogueCredits8DCC46
        sta lR18
        jsl rlDialoguePushToActivePointerStack
        rts


        _B3FA
        lda #(`dialogueEpilogueCredits8DCC42)<<8
        sta lR18+1
        lda #<>dialogueEpilogueCredits8DCC42
        sta lR18
        jsl rlDialoguePushToActivePointerStack
        rts


        _B409
        rts

        .databank 0

        ; 8D/B40A

      rlUnknown8DB40A ; 8D/B40A

        .al
        .xl
        .autsiz
        .databank ?

        stz $0AD3,b
        rtl

        .databank 0

        ; 8D/B40E

      rlUnknown8DB40E ; 8D/B40E

        .al
        .xl
        .autsiz
        .databank ?

        lda aDialogue.lActivePointer,b
        sec
        sbc #$0005
        sta aDialogue.lActivePointer,b

        _B418
        lda $0AD3,b
        clc
        adc #$0001
        cmp #$0019
        bcs _B471
        sta $0AD3,b
        lda $0AD3,b
        sta aDialogue.wUnit1,b
        lda $0AD3,b
        jsl rlUnknown8486A0
        sta aDialogue.wNumber1,b
        lda $0AD3,b
        jsl rlUnknown8486E5
        sta aDialogue.wNumber2,b
        lda $0AD3,b
        asl a
        tax
        lda aEpilogueUnitStates,x
        bit #$4000
        bne _B418
        bit #$8000
        bne _B45C
        lda #$2000
        sta aDialogue.wBaseTile,b
        bra _B462


        _B45C
        lda #$2400
        sta aDialogue.wBaseTile,b

        _B462
        lda #(`dialogueEpilogueCredits8DCC24)<<8
        sta lR18+1
        lda #<>dialogueEpilogueCredits8DCC24
        sta lR18
        jsl rlDialoguePushToActivePointerStack
        rtl


        _B471
        lda aDialogue.lActivePointer,b
        clc
        adc #$0005
        sta aDialogue.lActivePointer,b
        rtl

        .databank 0

        ; 8D/B47C

      rlUnknown8DB47C ; 8D/B47C

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0018
        sta $0AD3,b
        rtl

        .databank 0

        ; 8D/B483

      rlUnknown8DB483 ; 8D/B483

        .al
        .xl
        .autsiz
        .databank ?

        lda aDialogue.lActivePointer,b
        sec
        sbc #$0005
        sta aDialogue.lActivePointer,b

        _B48D
        lda $0AD3,b
        clc
        adc #$0001
        cmp #$0040
        bcs _B4E6
        sta $0AD3,b
        lda $0AD3,b
        sta aDialogue.wUnit1,b
        lda $0AD3,b
        jsl rlUnknown8486A0
        sta aDialogue.wNumber1,b
        lda $0AD3,b
        jsl rlUnknown8486E5
        sta aDialogue.wNumber2,b
        lda $0AD3,b
        asl a
        tax
        lda aEpilogueUnitStates,x
        bit #$4000
        bne _B48D
        bit #$8000
        bne _B4D1
        lda #$2000
        sta aDialogue.wBaseTile,b
        bra _B4D7


        _B4D1
        lda #$2400
        sta aDialogue.wBaseTile,b

        _B4D7
        lda #(`dialogueEpilogueCredits8DCC24)<<8
        sta lR18+1
        lda #<>dialogueEpilogueCredits8DCC24
        sta lR18
        jsl rlDialoguePushToActivePointerStack
        rtl


        _B4E6
        lda aDialogue.lActivePointer,b
        clc
        adc #$0005
        sta aDialogue.lActivePointer,b
        rtl

        .databank 0

        ; 8D/B4F1

    .endsection Unsorted8DB2B8Section


    .section Unsorted8DB4F1Section

      .al
      .xl

      rlUnknown8DB4F1 ; 8D/B4F1

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown8DB52C
        rtl

        .databank 0

        ; 8D/B4F6

    .endsection Unsorted8DB4F1Section


    .section Unsorted8DB4F6Section

      .al
      .xl

      rsUnknown8DB4F6 ; 8D/B4F6

        .al
        .xl
        .autsiz
        .databank ?

        lda wJoy1Input
        bit #$8000
        bne _B503
        bit #$2000
        bne _B52B
        rts


        _B503
        lda #$0000
        sta wCurrentChapter,b
        lda #$0021
        jsl rlPlaySoundEffect
        lda #$0002
        sta wMainGameMode,b
        lda #<>rsUnknown80B122
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        rts


        _B52B
        rts

        .databank 0

        ; 8D/B52C

      rlUnknown8DB52C ; 8D/B52C

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown8DB53A
        jsr rsUnknown8DB4F6
        lda #$000B
        sta wGameStateStep,b
        rtl

        .databank 0

        ; 8D/B539

    .endsection Unsorted8DB4F6Section


    .section Unsorted8DB53ASection

      .al
      .xl

      rsUnknown8DB53A ; 8D/B53A

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0002
        tsb wConversationFlags,b
        lda #$FFFF
        sta $7F7670
        lda #$0004
        trb wConversationFlags,b
        lda #$0008
        trb wConversationFlags,b
        lda #$0001
        trb wConversationFlags,b
        lda $08DC,b
        cmp #$003F
        bcc _B563
        bra _B5A9


        _B563
        inc $08DC,b
        lda $08DC,b
        sta aDialogue.wUnit1,b
        sta wConversationRightUnit,b
        lda $08DC,b
        sec
        sbc #$0019
        sta wR0
        clc
        adc wR0
        clc
        adc wR0
        tax
        lda aUnknown8DB5C8+1,x
        sta lConversationDialoguePointer+1,b
        lda aUnknown8DB5C8,x
        sta lConversationDialoguePointer,b
        lda $08DC,b
        and #$0003
        sta wConversationBackground,b
        lda #CONVERSATION_EXIT_CALLBACK
        sta wConversationExitMode,b
        lda #CASTLE_SCREEN_CONVERSATION
        sta wCastleScreenHandler,b
        lda #$0002
        sta wScreenFadingProcInput,b
        rts


        _B5A9
        lda #$0001
        sta $08DA,b
        lda #$ECC9
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        jsl rlUnknown88B3AF
        rts

        .databank 0

        ; 8D/B5C8

    .endsection Unsorted8DB53ASection


    .section Data8DB5C8Section

      .al
      .xl

      aUnknown8DB5C8 ; 8D/B5C8

        ; Read by rsUnknown8DB53A.

        .byte $6B, $CC, $8D, $6B, $CC, $8D, $6B, $CC, $8D, $6B, $CC, $8D, $6B, $CC, $8D, $6B
        .byte $CC, $8D, $6B, $CC, $8D, $6B, $CC, $8D, $6B, $CC, $8D, $6B, $CC, $8D, $6B, $CC
        .byte $8D, $6B, $CC, $8D, $6B, $CC, $8D, $6B, $CC, $8D, $6B, $CC, $8D, $94, $CC, $8D
        .byte $94, $CC, $8D, $94, $CC, $8D, $94, $CC, $8D, $94, $CC, $8D, $94, $CC, $8D, $94
        .byte $CC, $8D, $94, $CC, $8D, $94, $CC, $8D, $94, $CC, $8D, $94, $CC, $8D, $94, $CC
        .byte $8D, $94, $CC, $8D, $94, $CC, $8D, $94, $CC, $8D, $94, $CC, $8D, $94, $CC, $8D
        .byte $94, $CC, $8D, $94, $CC, $8D, $94, $CC, $8D, $94, $CC, $8D, $94, $CC, $8D, $94
        .byte $CC, $8D, $94, $CC, $8D

        ; 8D/B63D

    .endsection Data8DB5C8Section

    .section Table8DC964Section

      .al
      .xl

      dialogueEpilogueCredits8DC964 .include "../../text/dialogue/Epilogue/Credits8DC964.dialogue.txt" ; 8D/C964
      dialogueEpilogueCredits8DC9A6 .include "../../text/dialogue/Epilogue/Credits8DC9A6.dialogue.txt" ; 8D/C9A6
      dialogueEpilogueCredits8DC9FE .include "../../text/dialogue/Epilogue/Credits8DC9FE.dialogue.txt" ; 8D/C9FE
      dialogueEpilogueCredits8DC9FF .include "../../text/dialogue/Epilogue/Credits8DC9FF.dialogue.txt" ; 8D/C9FF
      dialogueEpilogueCredits8DCC24 .include "../../text/dialogue/Epilogue/Credits8DCC24.dialogue.txt" ; 8D/CC24
      dialogueEpilogueCredits8DCC39 .include "../../text/dialogue/Epilogue/Credits8DCC39.dialogue.txt" ; 8D/CC39
      dialogueEpilogueCredits8DCC3D .include "../../text/dialogue/Epilogue/Credits8DCC3D.dialogue.txt" ; 8D/CC3D
      dialogueEpilogueCredits8DCC42 .include "../../text/dialogue/Epilogue/Credits8DCC42.dialogue.txt" ; 8D/CC42
      dialogueEpilogueCredits8DCC46 .include "../../text/dialogue/Epilogue/Credits8DCC46.dialogue.txt" ; 8D/CC46
      dialogueEpilogueCredits8DCC4C .include "../../text/dialogue/Epilogue/Credits8DCC4C.dialogue.txt" ; 8D/CC4C
      dialogueEpilogueCredits8DCC54 .include "../../text/dialogue/Epilogue/Credits8DCC54.dialogue.txt" ; 8D/CC54
      dialogueEpilogueCredits8DCC5D .include "../../text/dialogue/Epilogue/Credits8DCC5D.dialogue.txt" ; 8D/CC5D
      dialogueEpilogueCredits8DCC6B .include "../../text/dialogue/Epilogue/Credits8DCC6B.dialogue.txt" ; 8D/CC6B
      dialogueEpilogueCredits8DCC94 .include "../../text/dialogue/Epilogue/Credits8DCC94.dialogue.txt" ; 8D/CC94

      aUnknown8DCCB0 ; 8D/CCB0
        .word 4 ; sprite count
        .structSpriteEntry (  16,   16), $21, SpriteLarge, $022, 2, 0, false, false
        .structSpriteEntry (   0,   16), $21, SpriteLarge, $020, 2, 0, false, false
        .structSpriteEntry (  16,    0), $21, SpriteLarge, $002, 2, 0, false, false
        .structSpriteEntry (   0,    0), $21, SpriteLarge, $000, 2, 0, false, false

      aUnknown8DCCC6 ; 8D/CCC6
        .word 4 ; sprite count
        .structSpriteEntry (  16,   16), $21, SpriteLarge, $026, 2, 0, false, false
        .structSpriteEntry (   0,   16), $21, SpriteLarge, $024, 2, 0, false, false
        .structSpriteEntry (  16,    0), $21, SpriteLarge, $006, 2, 0, false, false
        .structSpriteEntry (   0,    0), $21, SpriteLarge, $004, 2, 0, false, false

      aUnknown8DCCDC ; 8D/CCDC
        .word 4 ; sprite count
        .structSpriteEntry (  18,   14), $21, SpriteLarge, $02A, 2, 0, false, false
        .structSpriteEntry (   2,   14), $21, SpriteLarge, $028, 2, 0, false, false
        .structSpriteEntry (  18,   -2), $21, SpriteLarge, $00A, 2, 0, false, false
        .structSpriteEntry (   2,   -2), $21, SpriteLarge, $008, 2, 0, false, false

      aUnknown8DCCF2 ; 8D/CCF2
        .word 4 ; sprite count
        .structSpriteEntry (  16,   16), $21, SpriteLarge, $02E, 2, 0, false, false
        .structSpriteEntry (   0,   16), $21, SpriteLarge, $02C, 2, 0, false, false
        .structSpriteEntry (  16,    0), $21, SpriteLarge, $00E, 2, 0, false, false
        .structSpriteEntry (   0,    0), $21, SpriteLarge, $00C, 2, 0, false, false

      aUnknown8DCD08 ; 8D/CD08
        .word 4 ; sprite count
        .structSpriteEntry (  16,  -32), $21, SpriteLarge, $022, 2, 4, false, true
        .structSpriteEntry (   0,  -32), $21, SpriteLarge, $020, 2, 4, false, true
        .structSpriteEntry (  16,  -16), $21, SpriteLarge, $002, 2, 4, false, true
        .structSpriteEntry (   0,  -16), $21, SpriteLarge, $000, 2, 4, false, true

      aUnknown8DCD1E ; 8D/CD1E
        .word 4 ; sprite count
        .structSpriteEntry (  16,  -32), $21, SpriteLarge, $026, 2, 4, false, true
        .structSpriteEntry (   0,  -32), $21, SpriteLarge, $024, 2, 4, false, true
        .structSpriteEntry (  16,  -16), $21, SpriteLarge, $006, 2, 4, false, true
        .structSpriteEntry (   0,  -16), $21, SpriteLarge, $004, 2, 4, false, true

      aUnknown8DCD34 ; 8D/CD34
        .word 4 ; sprite count
        .structSpriteEntry (  18,  -30), $21, SpriteLarge, $02A, 2, 4, false, true
        .structSpriteEntry (   2,  -30), $21, SpriteLarge, $028, 2, 4, false, true
        .structSpriteEntry (  18,  -14), $21, SpriteLarge, $00A, 2, 4, false, true
        .structSpriteEntry (   2,  -14), $21, SpriteLarge, $008, 2, 4, false, true

      aUnknown8DCD4A ; 8D/CD4A
        .word 4 ; sprite count
        .structSpriteEntry (  16,  -32), $21, SpriteLarge, $02E, 2, 4, false, true
        .structSpriteEntry (   0,  -32), $21, SpriteLarge, $02C, 2, 4, false, true
        .structSpriteEntry (  16,  -16), $21, SpriteLarge, $00E, 2, 4, false, true
        .structSpriteEntry (   0,  -16), $21, SpriteLarge, $00C, 2, 4, false, true

      aUnknown8DCD60 ; 8D/CD60
        .word 4 ; sprite count
        .structSpriteEntry (  16,   16), $21, SpriteLarge, $022, 2, 1, false, false
        .structSpriteEntry (   0,   16), $21, SpriteLarge, $020, 2, 1, false, false
        .structSpriteEntry (  16,    0), $21, SpriteLarge, $002, 2, 1, false, false
        .structSpriteEntry (   0,    0), $21, SpriteLarge, $000, 2, 1, false, false

      aUnknown8DCD76 ; 8D/CD76
        .word 4 ; sprite count
        .structSpriteEntry (  16,   16), $21, SpriteLarge, $026, 2, 1, false, false
        .structSpriteEntry (   0,   16), $21, SpriteLarge, $024, 2, 1, false, false
        .structSpriteEntry (  16,    0), $21, SpriteLarge, $006, 2, 1, false, false
        .structSpriteEntry (   0,    0), $21, SpriteLarge, $004, 2, 1, false, false

      aUnknown8DCD8C ; 8D/CD8C
        .word 4 ; sprite count
        .structSpriteEntry (  18,   14), $21, SpriteLarge, $02A, 2, 1, false, false
        .structSpriteEntry (   2,   14), $21, SpriteLarge, $028, 2, 1, false, false
        .structSpriteEntry (  18,   -2), $21, SpriteLarge, $00A, 2, 1, false, false
        .structSpriteEntry (   2,   -2), $21, SpriteLarge, $008, 2, 1, false, false

      aUnknown8DCDA2 ; 8D/CDA2
        .word 4 ; sprite count
        .structSpriteEntry (  16,   16), $21, SpriteLarge, $02E, 2, 1, false, false
        .structSpriteEntry (   0,   16), $21, SpriteLarge, $02C, 2, 1, false, false
        .structSpriteEntry (  16,    0), $21, SpriteLarge, $00E, 2, 1, false, false
        .structSpriteEntry (   0,    0), $21, SpriteLarge, $00C, 2, 1, false, false

      aUnknown8DCDB8 ; 8D/CDB8
        .word 4 ; sprite count
        .structSpriteEntry (  16,  -32), $21, SpriteLarge, $022, 2, 5, false, true
        .structSpriteEntry (   0,  -32), $21, SpriteLarge, $020, 2, 5, false, true
        .structSpriteEntry (  16,  -16), $21, SpriteLarge, $002, 2, 5, false, true
        .structSpriteEntry (   0,  -16), $21, SpriteLarge, $000, 2, 5, false, true

      aUnknown8DCDCE ; 8D/CDCE
        .word 4 ; sprite count
        .structSpriteEntry (  16,  -32), $21, SpriteLarge, $026, 2, 5, false, true
        .structSpriteEntry (   0,  -32), $21, SpriteLarge, $024, 2, 5, false, true
        .structSpriteEntry (  16,  -16), $21, SpriteLarge, $006, 2, 5, false, true
        .structSpriteEntry (   0,  -16), $21, SpriteLarge, $004, 2, 5, false, true

      aUnknown8DCDE4 ; 8D/CDE4
        .word 4 ; sprite count
        .structSpriteEntry (  18,  -30), $21, SpriteLarge, $02A, 2, 5, false, true
        .structSpriteEntry (   2,  -30), $21, SpriteLarge, $028, 2, 5, false, true
        .structSpriteEntry (  18,  -14), $21, SpriteLarge, $00A, 2, 5, false, true
        .structSpriteEntry (   2,  -14), $21, SpriteLarge, $008, 2, 5, false, true

      aUnknown8DCDFA ; 8D/CDFA
        .word 4 ; sprite count
        .structSpriteEntry (  16,  -32), $21, SpriteLarge, $02E, 2, 5, false, true
        .structSpriteEntry (   0,  -32), $21, SpriteLarge, $02C, 2, 5, false, true
        .structSpriteEntry (  16,  -16), $21, SpriteLarge, $00E, 2, 5, false, true
        .structSpriteEntry (   0,  -16), $21, SpriteLarge, $00C, 2, 5, false, true

      aUnknown8DCE10 ; 8D/CE10
        .word 9 ; sprite count
        .structSpriteEntry (  16,   16), $00, SpriteSmall, $062, 2, 2, false, false
        .structSpriteEntry (   8,   16), $00, SpriteSmall, $061, 2, 2, false, false
        .structSpriteEntry (   0,   16), $00, SpriteSmall, $060, 2, 2, false, false
        .structSpriteEntry (  16,    8), $00, SpriteSmall, $052, 2, 2, false, false
        .structSpriteEntry (   8,    8), $00, SpriteSmall, $051, 2, 2, false, false
        .structSpriteEntry (   0,    8), $00, SpriteSmall, $050, 2, 2, false, false
        .structSpriteEntry (  16,    0), $00, SpriteSmall, $042, 2, 2, false, false
        .structSpriteEntry (   8,    0), $00, SpriteSmall, $041, 2, 2, false, false
        .structSpriteEntry (   0,    0), $00, SpriteSmall, $040, 2, 2, false, false

      aUnknown8DCE3F ; 8D/CE3F
        .word 9 ; sprite count
        .structSpriteEntry (  16,   16), $00, SpriteSmall, $065, 2, 2, false, false
        .structSpriteEntry (   8,   16), $00, SpriteSmall, $064, 2, 2, false, false
        .structSpriteEntry (   0,   16), $00, SpriteSmall, $063, 2, 2, false, false
        .structSpriteEntry (  16,    8), $00, SpriteSmall, $055, 2, 2, false, false
        .structSpriteEntry (   8,    8), $00, SpriteSmall, $054, 2, 2, false, false
        .structSpriteEntry (   0,    8), $00, SpriteSmall, $053, 2, 2, false, false
        .structSpriteEntry (  16,    0), $00, SpriteSmall, $045, 2, 2, false, false
        .structSpriteEntry (   8,    0), $00, SpriteSmall, $044, 2, 2, false, false
        .structSpriteEntry (   0,    0), $00, SpriteSmall, $043, 2, 2, false, false

      aUnknown8DCE6E ; 8D/CE6E
        .word 9 ; sprite count
        .structSpriteEntry (  18,   14), $00, SpriteSmall, $068, 2, 2, false, false
        .structSpriteEntry (  10,   14), $00, SpriteSmall, $067, 2, 2, false, false
        .structSpriteEntry (   2,   14), $00, SpriteSmall, $066, 2, 2, false, false
        .structSpriteEntry (  18,    6), $00, SpriteSmall, $058, 2, 2, false, false
        .structSpriteEntry (  10,    6), $00, SpriteSmall, $057, 2, 2, false, false
        .structSpriteEntry (   2,    6), $00, SpriteSmall, $056, 2, 2, false, false
        .structSpriteEntry (  18,   -2), $00, SpriteSmall, $048, 2, 2, false, false
        .structSpriteEntry (  10,   -2), $00, SpriteSmall, $047, 2, 2, false, false
        .structSpriteEntry (   2,   -2), $00, SpriteSmall, $046, 2, 2, false, false

      aUnknown8DCE9D ; 8D/CE9D
        .word 9 ; sprite count
        .structSpriteEntry (  16,   16), $00, SpriteSmall, $06B, 2, 2, false, false
        .structSpriteEntry (   8,   16), $00, SpriteSmall, $06A, 2, 2, false, false
        .structSpriteEntry (   0,   16), $00, SpriteSmall, $069, 2, 2, false, false
        .structSpriteEntry (  16,    8), $00, SpriteSmall, $05B, 2, 2, false, false
        .structSpriteEntry (   8,    8), $00, SpriteSmall, $05A, 2, 2, false, false
        .structSpriteEntry (   0,    8), $00, SpriteSmall, $059, 2, 2, false, false
        .structSpriteEntry (  16,    0), $00, SpriteSmall, $04B, 2, 2, false, false
        .structSpriteEntry (   8,    0), $00, SpriteSmall, $04A, 2, 2, false, false
        .structSpriteEntry (   0,    0), $00, SpriteSmall, $049, 2, 2, false, false

      aUnknown8DCECC ; 8D/CECC
        .word 9 ; sprite count
        .structSpriteEntry (  16,  -24), $00, SpriteSmall, $062, 2, 6, false, true
        .structSpriteEntry (   8,  -24), $00, SpriteSmall, $061, 2, 6, false, true
        .structSpriteEntry (   0,  -24), $00, SpriteSmall, $060, 2, 6, false, true
        .structSpriteEntry (  16,  -16), $00, SpriteSmall, $052, 2, 6, false, true
        .structSpriteEntry (   8,  -16), $00, SpriteSmall, $051, 2, 6, false, true
        .structSpriteEntry (   0,  -16), $00, SpriteSmall, $050, 2, 6, false, true
        .structSpriteEntry (  16,   -8), $00, SpriteSmall, $042, 2, 6, false, true
        .structSpriteEntry (   8,   -8), $00, SpriteSmall, $041, 2, 6, false, true
        .structSpriteEntry (   0,   -8), $00, SpriteSmall, $040, 2, 6, false, true

      aUnknown8DCEFB ; 8D/CEFB
        .word 9 ; sprite count
        .structSpriteEntry (  16,  -24), $00, SpriteSmall, $065, 2, 6, false, true
        .structSpriteEntry (   8,  -24), $00, SpriteSmall, $064, 2, 6, false, true
        .structSpriteEntry (   0,  -24), $00, SpriteSmall, $063, 2, 6, false, true
        .structSpriteEntry (  16,  -16), $00, SpriteSmall, $055, 2, 6, false, true
        .structSpriteEntry (   8,  -16), $00, SpriteSmall, $054, 2, 6, false, true
        .structSpriteEntry (   0,  -16), $00, SpriteSmall, $053, 2, 6, false, true
        .structSpriteEntry (  16,   -8), $00, SpriteSmall, $045, 2, 6, false, true
        .structSpriteEntry (   8,   -8), $00, SpriteSmall, $044, 2, 6, false, true
        .structSpriteEntry (   0,   -8), $00, SpriteSmall, $043, 2, 6, false, true

      aUnknown8DCF2A ; 8D/CF2A
        .word 9 ; sprite count
        .structSpriteEntry (  18,  -26), $00, SpriteSmall, $068, 2, 6, false, true
        .structSpriteEntry (  10,  -26), $00, SpriteSmall, $067, 2, 6, false, true
        .structSpriteEntry (   2,  -26), $00, SpriteSmall, $066, 2, 6, false, true
        .structSpriteEntry (  18,  -18), $00, SpriteSmall, $058, 2, 6, false, true
        .structSpriteEntry (  10,  -18), $00, SpriteSmall, $057, 2, 6, false, true
        .structSpriteEntry (   2,  -18), $00, SpriteSmall, $056, 2, 6, false, true
        .structSpriteEntry (  18,  -10), $00, SpriteSmall, $048, 2, 6, false, true
        .structSpriteEntry (  10,  -10), $00, SpriteSmall, $047, 2, 6, false, true
        .structSpriteEntry (   2,  -10), $00, SpriteSmall, $046, 2, 6, false, true

      aUnknown8DCF59 ; 8D/CF59
        .word 9 ; sprite count
        .structSpriteEntry (  16,  -24), $00, SpriteSmall, $06B, 2, 6, false, true
        .structSpriteEntry (   8,  -24), $00, SpriteSmall, $06A, 2, 6, false, true
        .structSpriteEntry (   0,  -24), $00, SpriteSmall, $069, 2, 6, false, true
        .structSpriteEntry (  16,  -16), $00, SpriteSmall, $05B, 2, 6, false, true
        .structSpriteEntry (   8,  -16), $00, SpriteSmall, $05A, 2, 6, false, true
        .structSpriteEntry (   0,  -16), $00, SpriteSmall, $059, 2, 6, false, true
        .structSpriteEntry (  16,   -8), $00, SpriteSmall, $04B, 2, 6, false, true
        .structSpriteEntry (   8,   -8), $00, SpriteSmall, $04A, 2, 6, false, true
        .structSpriteEntry (   0,   -8), $00, SpriteSmall, $049, 2, 6, false, true


    .endsection Table8DC964Section


    .section Data8DCF88Section

      .al
      .xl

      aUnknown8DCF88 ; 8D/CF88

        ; Read by rsUnknown8DA624.

        .word $CCF2, $0008, $CCC6, $000A, $CCDC, $000E, $CCB0, $0008
        .word $FFFF

        ; 8D/CF9A

      aUnknown8DCF9A ; 8D/CF9A

        ; Read by rsUnknown8DA624.

        .byte $4A, $CD, $08, $00, $1E, $CD, $0A, $00, $34, $CD, $0E, $00, $08, $CD, $08, $00
        .byte $FF, $FF, $A2, $CD, $08, $00, $76, $CD, $0A, $00, $8C, $CD, $0E, $00, $60, $CD
        .byte $08, $00, $FF, $FF, $FA, $CD, $08, $00, $CE, $CD, $0A, $00, $E4, $CD, $0E, $00
        .byte $B8, $CD, $08, $00, $FF, $FF, $9D, $CE, $05, $00, $3F, $CE, $07, $00, $6E, $CE
        .byte $0B, $00, $10, $CE, $05, $00, $FF, $FF, $59, $CF, $05, $00, $FB, $CE, $07, $00
        .byte $2A, $CF, $0B, $00, $CC, $CE, $05, $00, $FF, $FF, $41, $D0, $41, $D0, $42, $D0
        .byte $44, $D0, $8D, $12, $02, $41, $D0, $41, $D0, $42, $D0, $09, $D2, $8D, $12, $02
        .byte $41, $D0, $41, $D0, $42, $D0, $CE, $D3, $8D, $12, $02, $41, $D0, $41, $D0, $42
        .byte $D0, $93, $D5, $8D, $12, $02, $41, $D0, $41, $D0, $42, $D0, $58, $D7, $8D, $12
        .byte $02, $41, $D0, $41, $D0, $42, $D0, $1D, $D9, $8D, $12, $02, $41, $D0, $41, $D0
        .byte $42, $D0, $E2, $DA, $8D, $12, $02

        ; 8D/D041

    .endsection Data8DCF88Section


    .section Unsorted8DD041Section

      .al
      .xl

      rlUnknown8DD041 ; 8D/D041

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 8D/D042


      aUnknown8DD042 ; 8D/D042

        HDMA_HALT

      aUnknown8DD044 ; 8D/D044

        .byte $C0
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .byte $C0
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $00FB
        .word $00FB, $00FB, $00FB, $00FB, $00FB, $00FB, $00FB, $00FB
        .word $00FB, $00FB, $00FB, $00FB, $00FB, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .byte $C0
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .byte $A0
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .byte 0

      aUnknown8DD209 ; 8D/D209

        .byte $C0
        .word $00EB, $00EB, $00EB, $00EB, $00EB, $00EB, $00EB, $00EB
        .word $00EB, $00EB, $00EB, $00EB, $00EB, $00EB, $00EB, $00EB
        .word $00EB, $00EB, $00EB, $00EB, $00EB, $00EB, $00EB, $00EB
        .word $00EB, $00EB, $00EB, $00EB, $00EB, $00EB, $00EB, $00EB
        .word $00EB, $00EB, $00EB, $00EB, $00F1, $00F1, $00F1, $00F1
        .word $00F1, $00F1, $00F1, $00F1, $00F1, $00F1, $00F1, $00F1
        .word $00F1, $00F1, $00F1, $00F2, $00F2, $00F2, $00F2, $00F2
        .word $00F2, $00F2, $00F2, $00F2, $00F2, $00F8, $00F8, $00F8
        .byte $C0
        .word $00F8, $00F8, $00F8, $00F8, $00F8, $00F8, $00FC, $00FC
        .word $00FC, $00FC, $00FC, $00FC, $00FC, $00FC, $00FC, $00FC
        .word $00FC, $00FC, $00FC, $00FC, $00FC, $00FC, $00FC, $00FC
        .word $00FC, $00FC, $00FC, $00FC, $00FC, $00FC, $00FC, $00FC
        .word $00FC, $00FC, $00FC, $00FC, $00FC, $00FC, $00FC, $00FC
        .word $00FC, $00FC, $00FC, $00FC, $00FC, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .byte $C0
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0004, $0004, $0004, $0004, $0004, $0004, $0004, $0004
        .word $0004, $0004, $0004, $0004, $0004, $0004, $0004, $0004
        .word $0004, $0015, $0015, $0015, $0015, $0015, $0015, $0015
        .word $0015, $0015, $0015, $0015, $0015, $0015, $0015, $0015
        .word $0015, $0015, $0015, $0015, $0015, $0015, $0015, $0015
        .word $0015, $0015, $0015, $0015, $0015, $0015, $0015, $0015
        .byte $A0
        .word $0015, $0015, $0015, $0015, $0015, $0015, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .byte 0

      aUnknown8DD3CE ; 8D/D3CE

        .byte $C0
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $0000, $0000, $0000, $00ED, $00ED, $00ED, $00ED
        .word $00ED, $00ED, $00ED, $00ED, $00ED, $00ED, $00ED, $00ED
        .word $00ED, $00ED, $00ED, $00ED, $00ED, $00ED, $00ED, $00ED
        .byte $C0
        .word $00ED, $00ED, $00ED, $00ED, $00ED, $00ED, $00ED, $00ED
        .word $00ED, $00ED, $00ED, $00ED, $00ED, $00ED, $00ED, $00ED
        .word $00ED, $00ED, $00ED, $00ED, $00ED, $00ED, $00ED, $00ED
        .word $00ED, $00ED, $00ED, $00ED, $00F3, $00F3, $00F3, $00F3
        .word $00F3, $00F3, $00F3, $00F3, $00F9, $00F9, $00F9, $00F9
        .word $00F9, $00F9, $00F9, $00F9, $00F9, $00F9, $00F9, $00F9
        .word $00FC, $00FC, $00FC, $00FC, $00FC, $00FC, $00FC, $00FC
        .word $00FC, $00FC, $00FC, $0002, $0002, $0002, $0002, $0002
        .byte $C0
        .word $0002, $0002, $0002, $0008, $0008, $0008, $0008, $0008
        .word $0008, $0008, $0008, $0008, $0008, $0008, $0008, $0008
        .word $0008, $0008, $000B, $000B, $000B, $000B, $000B, $000B
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .byte $A0
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .byte 0

      aUnknown8DD593 ; 8D/D593

        .byte $C0
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $00F9
        .byte $C0
        .word $00F9, $00F9, $00F9, $00F9, $00F9, $00F9, $00F9, $00F9
        .word $00F9, $00F9, $00F9, $00F9, $00F9, $00F9, $00F9, $00F9
        .word $00F8, $00F6, $00F6, $00F6, $00F6, $00F6, $00F6, $00F6
        .word $00F6, $00F6, $00F6, $00F6, $00F6, $00F6, $00F6, $00F7
        .word $00FB, $00FB, $00FB, $00FB, $00FB, $00FB, $00FB, $00FB
        .word $00FB, $00FB, $00FB, $00FB, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0001, $0001, $0001, $0001, $0001, $0001, $0001
        .byte $C0
        .word $0001, $0001, $0001, $0001, $0001, $0001, $0007, $0007
        .word $0007, $0007, $0007, $0007, $0007, $0007, $0007, $0007
        .word $0007, $0007, $0007, $0007, $0007, $0007, $0007, $0007
        .word $0007, $0007, $0007, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .byte $A0
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .byte 0

      aUnknown8DD758 ; 8D/D758

        .byte $C0
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $00F4, $00F4, $00F4, $00F4
        .word $00F3, $00F3, $00F3, $00F3, $00F5, $00F5, $00F5, $00F5
        .word $00F0, $00F0, $00F0, $00F3, $00F3, $00F3, $00F3, $00F3
        .word $00F3, $00F3, $00F2, $00F3, $00F3, $00F3, $00F3, $00F3
        .word $00F3, $00F3, $00F3, $00F3, $00F3, $00F3, $00F4, $00F4
        .byte $C0
        .word $00F4, $00F4, $00F4, $00F4, $00F4, $00F4, $00F4, $00F4
        .word $00F4, $00F4, $00F4, $00F4, $00FA, $00FA, $00FA, $00FA
        .word $00FA, $00FA, $00FA, $00FA, $00FA, $00FA, $00FE, $00FE
        .word $00FE, $00FE, $00FE, $00FE, $00FE, $00FE, $00FE, $00FD
        .word $00FD, $00FD, $00FD, $00FD, $00FD, $00FD, $00FD, $00FD
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $0005, $0005, $0005, $0005, $0005, $0005, $0005, $0005
        .byte $C0
        .word $0005, $0005, $0005, $0005, $000B, $000B, $000B, $000B
        .word $000B, $000B, $000B, $000B, $0011, $0011, $0011, $0011
        .word $0011, $0011, $0011, $0011, $0011, $0011, $0011, $0017
        .word $0017, $0017, $0017, $0017, $0017, $0017, $0017, $0017
        .word $0017, $0017, $0017, $0017, $0017, $0017, $0017, $0017
        .word $0017, $0017, $0017, $0017, $000B, $000B, $000B, $000B
        .word $000B, $000B, $000B, $000B, $000B, $000B, $000B, $000B
        .word $000B, $000B, $0000, $0000, $0000, $0000, $0000, $0000
        .byte $A0
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .byte 0

      aUnknown8DD91D ; 8D/D91D

        .byte $C0
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .byte $C0
        .word $00EE, $00EE, $00EE, $00EE, $00EE, $00EE, $00EE, $00EE
        .word $00EE, $00EE, $00EE, $00EE, $00EE, $00EE, $00EE, $00EE
        .word $00EE, $00EE, $00EE, $00EE, $00EE, $00EE, $00EE, $00EE
        .word $00EE, $00F4, $00F4, $00F4, $00F4, $00F4, $00F4, $00F4
        .word $00F4, $00F4, $00F4, $00FA, $00FA, $00FA, $00FA, $00FA
        .word $00FA, $00FA, $00FA, $00FA, $00FA, $00FA, $00FA, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0006, $0006, $0006, $0006, $0006, $0006, $0006, $0006
        .byte $C0
        .word $000C, $000C, $000C, $000C, $000C, $000C, $000C, $000C
        .word $000C, $000C, $000C, $000C, $000C, $0012, $0012, $0012
        .word $0012, $0012, $0012, $0012, $0012, $0012, $0012, $001C
        .word $001C, $001C, $001C, $001C, $001C, $001C, $001C, $001C
        .word $001C, $001C, $001C, $001C, $001C, $001C, $001C, $001C
        .word $001C, $001C, $001C, $001C, $001C, $001C, $001C, $001C
        .word $001C, $001C, $001C, $001C, $001C, $001C, $001C, $001C
        .word $001C, $001C, $001C, $001C, $001C, $001C, $001C, $001C
        .byte $A0
        .word $001C, $001C, $001C, $001C, $001C, $001C, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .byte 0

      aUnknown8DDAE2 ; 8D/DAE2

        .byte $C0
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .byte $C0
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .byte $C0
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .byte $A0
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .byte 0

    .endsection Unsorted8DD041Section
