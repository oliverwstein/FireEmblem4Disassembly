; The Jugdral history (ユグドラル大陸史): the scrolling timeline shown when a new
; game is chosen on the title file menu (save menu steps $1C-$21), before the
; prologue's world map events. Each entry of aJugdralHistoryEntries is a BG2 row
; pattern, a year (the era name for $FF) and a text; BG1 scrolls 1 pixel a frame
; while BG2, BG3, and the line counter advance 1 pixel every 2 frames, drawing one
; line every 16 text pixels (32 frames) in twelve steps (aJugdralHistoryLineSteps). Start skips it.

    .section JugdralHistoryTextSection

      .al
      .xl

      aJugdralHistoryHeadingText ; 8D/9CB8
        .byte $09, $C5, $C5, $84, $8F, $9B, $86, $88, $0A, $24, $90, $0C, $C3, $09, $C5, $01

      aJugdralHistoryText01 ; 8D/9CC8
        .byte $09, $84, $8C, $0D, $25, $09, $28, $0A, $8A, $09, $25, $8F, $86, $8C, $0A, $5E
        .byte $6A, $0B, $F4, $0A, $F6, $09, $C5, $01

      aJugdralHistoryText02 ; 8D/9CE0
        .byte $0B, $F5, $50, $9A, $09, $2C, $28, $0B, $4A, $0A, $63, $09, $C5, $01

      aJugdralHistoryText03 ; 8D/9CEE
        .byte $0A, $98, $96, $09, $28, $0D, $C1, $0A, $24, $09, $BB, $0D, $12, $0B, $CE, $09
        .byte $28, $0B, $4E, $0A, $DC, $09, $C5, $01

      aJugdralHistoryText04 ; 8D/9D06
        .byte $0A, $24, $0B, $35, $0C, $1C, $09, $8D, $89, $25, $0A, $56, $57, $20, $09, $3E
        .byte $0C, $D2, $0D, $DB, $09, $C5, $01

      aJugdralHistoryText05 ; 8D/9D1D
        .byte $09, $C0, $8A, $A4, $73, $0C, $1C, $0A, $3D, $09, $C1, $28, $0D, $CC, $0B, $33
        .byte $09, $C5, $01

      aJugdralHistoryText06 ; 8D/9D30
        .byte $09, $EA, $E2, $0A, $3A, $B6, $09, $28, $0B, $57, $09, $C5, $C5, $01

      aJugdralHistoryText07 ; 8D/9D3E
        .byte $09, $C5, $0B, $F5, $50, $0A, $6A, $09, $8F, $86, $8C, $28, $0B, $2D, $2E, $09
        .byte $C5, $01

      aJugdralHistoryText08 ; 8D/9D50
        .byte $09, $8D, $89, $0A, $24, $0B, $35, $0C, $1C, $09, $BB, $0A, $2C, $0B, $63, $09
        .byte $25, $21, $17, $C5, $01

      aJugdralHistoryText09 ; 8D/9D65
        .byte $09, $8A, $A4, $73, $0A, $2C, $6A, $09, $28, $0B, $F4, $0A, $F6, $09, $C5, $01

      aJugdralHistoryText10 ; 8D/9D75
        .byte $0A, $24, $0D, $CA, $0E, $17, $09, $C5, $01

      aJugdralHistoryText11 ; 8D/9D7E
        .byte $09, $C5, $0D, $91, $92, $0A, $31, $09, $EA, $0C, $F1, $0A, $5B, $94, $D8, $09
        .byte $C5, $01

      aJugdralHistoryText12 ; 8D/9D90
        .byte $09, $7F, $0A, $18, $09, $89, $73, $6C, $28, $0B, $8E, $09, $16, $C5, $01

      aJugdralHistoryText13 ; 8D/9D9F
        .byte $09, $C5, $0A, $56, $57, $20, $09, $2C, $28, $11, $18, $25, $13, $23, $1B, $22
        .byte $C5, $01

      aJugdralHistoryText14 ; 8D/9DB1
        .byte $09, $C5, $0A, $E3, $9E, $09, $28, $0A, $5F, $0C, $E8, $09, $3E, $0A, $53, $09
        .byte $25, $0D, $DC, $09, $44, $36, $39, $38, $C5, $01

      aJugdralHistoryText15 ; 8D/9DCB
        .byte $09, $63, $AC, $97, $28, $0D, $B9, $0A, $43, $09, $C5, $01

      aJugdralHistoryText16 ; 8D/9DD7
        .byte $09, $C5, $0D, $91, $92, $0A, $31, $09, $BB, $0A, $9E, $0C, $F1, $0A, $5B, $09
        .byte $25, $32, $14, $35, $4F, $C5, $01

      aJugdralHistoryText17 ; 8D/9DEE
        .byte $0A, $2B, $0B, $23, $09, $7E, $61, $86, $28, $0B, $79, $57, $09, $C5, $01

      aJugdralHistoryText18 ; 8D/9DFD
        .byte $0B, $AE, $0A, $55, $09, $25, $0A, $C3, $0B, $FF, $0A, $85, $86, $51, $09, $3E
        .byte $0C, $3C, $09, $38, $C5, $01

      aJugdralHistoryText19 ; 8D/9E13
        .byte $09, $97, $B0, $74, $0A, $B4, $09, $28, $0D, $CF, $D0, $09, $C5, $01

      aJugdralHistoryText20 ; 8D/9E21
        .byte $09, $C5, $0A, $85, $86, $51, $09, $28, $0A, $64, $4B, $09, $25, $0A, $20, $09
        .byte $3E, $0C, $D2, $0D, $DB, $09, $1B, $C5, $01

      aJugdralHistoryText21 ; 8D/9E3A
        .byte $09, $C5, $EA, $E2, $0A, $2D, $64, $4B, $09, $3E, $0D, $21, $0B, $48, $09, $1C
        .byte $38, $C5, $01

      aJugdralHistoryText22 ; 8D/9E4D
        .byte $0A, $2D, $64, $09, $28, $0A, $BB, $09, $2E, $37, $C5, $01

      aJugdralHistoryText23 ; 8D/9E59
        .byte $09, $8A, $A4, $73, $0A, $2C, $6A, $09, $28, $0B, $2D, $2E, $09, $C5, $01

      aJugdralHistoryText24 ; 8D/9E68
        .byte $09, $C5, $EA, $E2, $0A, $2D, $64, $4B, $09, $BB, $C5, $01

      aJugdralHistoryText25 ; 8D/9E74
        .byte $09, $C5, $8F, $86, $8C, $9F, $88, $E7, $0A, $9D, $6A, $09, $23, $C5, $01

      aJugdralHistoryText26 ; 8D/9E83
        .byte $09, $C5, $0D, $DD, $0A, $70, $09, $E5, $0A, $5E, $6A, $09, $3C, $0A, $93, $6A
        .byte $09, $1C, $38, $C5, $01

      aJugdralHistoryText27 ; 8D/9E98
        .byte $09, $8F, $86, $8C, $9F, $88, $0A, $5E, $6A, $09, $28, $0B, $F4, $0A, $F6, $09
        .byte $C5, $01

      aJugdralHistoryText28 ; 8D/9EAA
        .byte $09, $8F, $86, $8C, $9F, $88, $0A, $6A, $51, $02, $01

      aJugdralHistoryText29 ; 8D/9EB5
        .byte $0A, $6E, $6F, $09, $28, $0A, $6A, $09, $61, $92, $B0, $67, $2C, $0B, $8A, $8B
        .byte $09, $C5, $01

      aJugdralHistoryText30 ; 8D/9EC8
        .byte $0B, $33, $57, $09, $28, $0D, $CE, $0B, $22, $09, $18, $C5, $01

    .endsection JugdralHistoryTextSection


    .section JugdralHistoryStepsSection

      .al
      .xl

      rsJugdralHistorySetup ; 91/E6D8

        .al
        .xl
        .autsiz
        .databank ?

        ; Step $1C (new game chosen): clears the menu and sets up the Jugdral history scroll.

        stz wSaveMenuCommandRow,b
        stz wSaveMenuSlotRow,b
        inc wGameStateStep,b
        lda #$03FF
        jsl rlFillBG3Page0TilemapBuffer
        jsr rsSaveMenuUploadBG3Tilemap
        jsl rlResetDialogueEngine
        jsl rlDialogueFreeHDMA
        jsl rlResetHDMAEngine
        lda #$0080
        sta aDialogue._Slot[0].wVRAMTileOffset,b
        jsl rlQueueMenuFontDecompression
        jsl rlSetJugdralHistoryBackgroundColors
        jsl rlSetJugdralHistoryTextColors
        lda #$0004
        sta wMusicID,b
        rts

        .databank 0

        ; 91/E710

      rsJugdralHistoryUploadFont ; 91/E710

        .al
        .xl
        .autsiz
        .databank ?

        lda bDecompressionArrayFlag,b
        bne _E725
        jsl rlDMAByStruct

          .structDMAToVRAM aDecompressionBuffer+$1200, $0600, $80, $A000

        inc wGameStateStep,b

        _E725
        rts

        .databank 0

        ; 91/E726

      rsJugdralHistoryShow ; 91/E726

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$16
        sta bBufferTM
        rep #$20
        inc wGameStateStep,b
        rts

        .databank 0

        ; 91/E732

      rsJugdralHistoryFirstLine ; 91/E732

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlJugdralHistoryDrawLineStep
        lda wSaveMenuSlotRow,b
        inc a
        sta wSaveMenuSlotRow,b
        cmp #$0010
        bcc _E74D
        inc wSaveMenuCommandRow,b
        lda #$0020
        sta wBufferBG3VOFS
        inc wGameStateStep,b

        _E74D
        rts

        .databank 0

        ; 91/E74E

      rsJugdralHistoryScroll ; 91/E74E

        .al
        .xl
        .autsiz
        .databank ?

        lda wJoy1New
        bit #$1000
        beq _E764
        lda #$0022
        sta wGameStateStep,b
        lda #$00E0
        jsl rlSendSoundCommand
        bra _E77F


        _E764
        jsl rlScrollJugdralHistory
        bcc _E77F
        jsl rlResetDialogueEngine
        jsl rlDialogueFreeHDMA
        jsl rlResetHDMAEngine
        lda #$0080
        sta wSaveMenuCommandRow,b
        inc wGameStateStep,b

        _E77F
        rts

        .databank 0

        ; 91/E780

    .endsection JugdralHistoryStepsSection


    .section ScrollJugdralHistorySection

      .al
      .xl

      rlScrollJugdralHistory ; 91/B164

        .al
        .xl
        .autsiz
        .databank ?

        ; Scrolls BG1 one pixel a frame and BG2/BG3 one pixel every 2 frames, drawing the next line every 16 text pixels (32 frames). Carry set when Start is pressed or the last entry has scrolled in.

        lda wJoy1New
        bit #$1000
        bne _B1BF
        lda wBufferBG1VOFS
        inc a
        sta wBufferBG1VOFS
        lda wVBlankEnabledFramecount
        and #$0001
        bne _B1C2
        jsl rlJugdralHistoryDrawLineStep
        lda wSaveMenuSlotRow,b
        and #$000F
        cmp #$000F
        bne _B1AC
        lda wSaveMenuCommandRow,b
        sta wR0
        asl a
        clc
        adc wR0
        asl a
        tax
        lda aJugdralHistoryEntries,x
        cmp #$FFFF
        beq _B1BF
        lda wSaveMenuCommandRow,b
        inc a
        sta wSaveMenuCommandRow,b
        and #$001F
        bne _B1AC
        lda #$0080
        sta aDialogue._Slot[0].wVRAMTileOffset,b

        _B1AC
        lda wBufferBG3VOFS
        inc a
        sta wBufferBG3VOFS
        lda wBufferBG2VOFS
        inc a
        sta wBufferBG2VOFS
        lda wSaveMenuSlotRow,b
        inc a
        sta wSaveMenuSlotRow,b
        bra _B1C2


        _B1BF
        sec
        bra _B1C3


        _B1C2
        clc

        _B1C3
        rtl

        .databank 0

        ; 91/B1C4

      rlJugdralHistoryDrawLineStep ; 91/B1C4

        .al
        .xl
        .autsiz
        .databank ?

        ; One step of drawing a history line, chosen by the low 4 bits of the line counter (wSaveMenuSlotRow) from aJugdralHistoryLineSteps.

        ldy wSaveMenuCommandRow,b
        lda wSaveMenuSlotRow,b
        and #$000F
        cmp #$000C
        bcs _B1E2
        sta wR4
        lda wR4
        cmp #$000C
        bmi _B1DD

        _B1DB
        bra _B1DB


        _B1DD
        asl a
        tax
        jsr (aJugdralHistoryLineSteps,x)

        _B1E2
        rtl

        .databank 0

        ; 91/B1E3

    .endsection ScrollJugdralHistorySection


    .section JugdralHistoryLineStepsSection

      .al
      .xl

      aJugdralHistoryLineSteps ; 91/B1E3

        ; Jump table of rlJugdralHistoryDrawLineStep.
        .word <>rsJugdralHistoryCopyBG2Row
        .word <>rsJugdralHistoryUploadBG2Tilemap
        .word <>rsJugdralHistoryDrawEntry
        .word <>rsJugdralHistoryRunText
        .word <>rsJugdralHistoryRunText
        .word <>rsJugdralHistoryRunText
        .word <>rsJugdralHistoryRunText
        .word <>rsJugdralHistoryRunText
        .word <>rsJugdralHistoryRunText
        .word <>rsJugdralHistoryRunText
        .word <>rsJugdralHistoryUploadBG3Tilemap
        .word <>rsJugdralHistoryNextTextTiles

      rsJugdralHistoryNoOpUnused ; 91/B1FB

        ; Unreferenced: a lone rts.

        rts

    .endsection JugdralHistoryLineStepsSection


    .section JugdralHistoryDrawEntrySection

      .al
      .xl

      rsJugdralHistoryDrawEntry ; 91/B1FC

        .al
        .xl
        .autsiz
        .databank ?

        phy
        jsr rsJugdralHistoryClearLine
        ply
        phy
        jsr rsJugdralHistoryDrawYear
        ply
        jsr rsJugdralHistoryStartText
        rts

        .databank 0

        ; 91/B20A

      rsJugdralHistoryDrawYear ; 91/B20A

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws the entry's year as three digit tiles, or the era name (aJugdralHistoryEraTiles) for an entry whose year is $FF.

        tya
        pha
        jsr rsJugdralHistoryLineOffset
        pha
        lda #$7E00
        sta lR18+1
        pla
        clc
        adc #$9B88
        adc #$000A
        sta lR18
        pla
        sta wR0
        asl a
        clc
        adc wR0
        asl a
        inc a
        inc a
        tax
        lda aJugdralHistoryEntries,x
        cmp #$00FF
        beq _B27B
        cmp #$0000
        beq _B27A
        cmp #$FFFF
        beq _B27A
        jsl rlSplitNumberIntoDigits
        lda wR2
        ora #$2000
        ldy #$0000
        sta [lR18],y
        clc
        adc #$0010
        ldy #$0040
        sta [lR18],y
        lda wR1
        ora #$2000
        ldy #$0002
        sta [lR18],y
        clc
        adc #$0010
        ldy #$0042
        sta [lR18],y
        lda wR0
        ora #$2000
        ldy #$0004
        sta [lR18],y
        clc
        adc #$0010
        ldy #$0044
        sta [lR18],y

        _B27A
        rts


        _B27B
        lda lR18
        clc
        adc #$0008
        sta lR18
        lda lR18+1
        adc #$0000
        sta lR18+1
        lda lR18
        clc
        adc #$0040
        sta lR19
        lda lR18+1
        adc #$0000
        sta lR19+1
        ldx #$0000

        _B29C
        lda aJugdralHistoryEraTiles,x
        and #$00FF
        cmp #$003F
        bne _B2AD
        lda #$03FF
        bra _B2BA


        _B2AD
        pha
        and #$000F
        sta wR0
        pla
        and #$00F0
        asl a
        ora wR0

        _B2BA
        ora #$2000
        sta [lR18],y
        cmp #$23FF
        beq _B2C8
        clc
        adc #$0010

        _B2C8
        sta [lR19],y
        inc x
        inc y
        inc y
        cpx #$0012
        bne _B29C
        rts

        .databank 0

        ; 91/B2D3

    .endsection JugdralHistoryDrawEntrySection


    .section Data91B2D3Section

      .al
      .xl

      aJugdralHistoryEraTiles ; 91/B2D3

        ; Read by rsJugdralHistoryDrawYear.

        .word $1E13, $0D10, $0A1B, $3F15, $110C, $181B, $1817, $1815
        .word $2210

        ; 91/B2E5

    .endsection Data91B2D3Section


    .section JugdralHistoryStartTextSection

      .al
      .xl

      rsJugdralHistoryStartText ; 91/B2E5

        .al
        .xl
        .autsiz
        .databank ?

        phy
        ply
        lda #$8D00
        sta lR18+1
        tya
        sta wR0
        asl a
        clc
        adc wR0
        asl a
        inc a
        inc a
        inc a
        inc a
        tax
        lda aJugdralHistoryEntries,x
        beq _B33B
        cmp #$FFFF
        beq _B33B
        sta lR18
        tya
        pha
        jsr rsJugdralHistoryLineOffset
        adc #$0014
        tay
        pla
        ldx aDialogue._Slot[0].wVRAMTileOffset,b
        jsl rlStartTextToTiles
        lda #$5000
        sta aDialogue._Slot[0].wVRAMAddress,b
        lda #$9B88
        sta aDialogue._Slot[0].lBGBufferPosition,b
        lda #$401E
        sta aDialogue._Slot[0].wDisplayArea,b
        lda #$0003
        sta aDialogue.wCharLimit,b
        lda #$0200
        tsb aDialogue.wStatus,b
        lda #$03FF
        sta aDialogue.wClearTile,b

        _B33B
        rts

        .databank 0

        ; 91/B33C

      rsJugdralHistoryRunText ; 91/B33C

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlRunDialogueCycle
        rts

        .databank 0

        ; 91/B341

      rsJugdralHistoryNextTextTiles ; 91/B341

        .al
        .xl
        .autsiz
        .databank ?

        lda aDialogue._Slot[0].wVRAMTileOffset,b
        clc
        adc #$0008
        sta aDialogue._Slot[0].wVRAMTileOffset,b
        rts

        .databank 0

        ; 91/B34C

    .endsection JugdralHistoryStartTextSection


    .section JugdralHistoryEntriesSection

      .al
      .xl

      aJugdralHistoryEntries ; 91/B34C

        ; Read by rlScrollJugdralHistory, rsJugdralHistoryDrawYear, rsJugdralHistoryStartText, rsJugdralHistoryCopyBG2Row.

        .word $0000, $00FF, $0000
        .word $0001, $0000, <>aJugdralHistoryHeadingText
        .word $0002, $0000, $0000
        .word $0003, $0000, $0000
        .word $0000, $0001, <>aJugdralHistoryText01
        .word $0001, $0000, $0000
        .word $0002, $00E6, <>aJugdralHistoryText02
        .word $0003, $0000, $0000
        .word $0000, $0136, <>aJugdralHistoryText03
        .word $0001, $0000, $0000
        .word $0002, $01B8, <>aJugdralHistoryText04
        .word $0003, $0000, <>aJugdralHistoryText05
        .word $0000, $0000, $0000
        .word $0001, $01BF, <>aJugdralHistoryText06
        .word $0002, $0000, <>aJugdralHistoryText07
        .word $0003, $0000, $0000
        .word $0000, $01C0, <>aJugdralHistoryText08
        .word $0001, $0000, <>aJugdralHistoryText09
        .word $0002, $0000, $0000
        .word $0003, $01C1, <>aJugdralHistoryText10
        .word $0000, $0000, <>aJugdralHistoryText11
        .word $0001, $0000, $0000
        .word $0002, $01C4, <>aJugdralHistoryText12
        .word $0003, $0000, <>aJugdralHistoryText13
        .word $0000, $0000, <>aJugdralHistoryText14
        .word $0001, $0000, $0000
        .word $0002, $01C5, <>aJugdralHistoryText15
        .word $0003, $0000, <>aJugdralHistoryText16
        .word $0000, $0000, $0000
        .word $0001, $0217, <>aJugdralHistoryText17
        .word $0002, $0000, $0000
        .word $0003, $0263, <>aJugdralHistoryText18
        .word $0000, $0000, $0000
        .word $0001, $0278, <>aJugdralHistoryText19
        .word $0002, $0000, <>aJugdralHistoryText20
        .word $0003, $0000, <>aJugdralHistoryText21
        .word $0000, $0000, $0000
        .word $0001, $0279, <>aJugdralHistoryText22
        .word $0002, $0000, $0000
        .word $0003, $0288, <>aJugdralHistoryText23
        .word $0000, $0000, <>aJugdralHistoryText24
        .word $0001, $0000, <>aJugdralHistoryText25
        .word $0002, $0000, <>aJugdralHistoryText26
        .word $0003, $0000, $0000
        .word $0000, $0289, <>aJugdralHistoryText27
        .word $0001, $0000, $0000
        .word $0002, $02F5, <>aJugdralHistoryText28
        .word $0003, $0000, <>aJugdralHistoryText29
        .word $0004, $0000, $0000
        .word $0005, $0000, <>aJugdralHistoryText30
        .word $0006, $0000, $0000
        .word $0007, $0000, $0000
        .word $0008, $0000, $0000
        .word $0009, $0000, $0000
        .word $FFFF, $FFFF, $FFFF

        ; 91/B496

    .endsection JugdralHistoryEntriesSection


    .section JugdralHistoryClearLineSection

      .al
      .xl

      rsJugdralHistoryClearLine ; 91/B496

        .al
        .xl
        .autsiz
        .databank ?

        tya
        jsr rsJugdralHistoryLineOffset
        pha
        lda #$7E00
        sta lR18+1
        pla
        clc
        adc #$9B88
        sta lR18
        lda #$03FF
        ldy #$0000

        _B4AD
        sta [lR18],y
        inc y
        inc y
        cpy #$0080
        bne _B4AD
        rts

        .databank 0

        ; 91/B4B7

      rsJugdralHistoryLineOffset ; 91/B4B7

        .al
        .xl
        .autsiz
        .databank ?

        tya
        pha
        xba
        lsr a
        and #$0800
        eor #$0800
        sta wR0
        pla
        and #$000F
        xba
        lsr a
        clc
        adc wR0
        rts

        .databank 0

        ; 91/B4CD

      rsJugdralHistoryUploadBG2Tilemap ; 91/B4CD

        .al
        .xl
        .autsiz
        .databank ?

        tya
        and #$0010
        beq _B4E1
        jsl rlDMAByStruct

          .structDMAToVRAM aDecompressionBuffer, $0800, $80, $8000

        rts


        _B4E1
        jsl rlDMAByStruct

          .structDMAToVRAM aDecompressionBuffer+$0800, $0800, $80, $8800

        rts

        .databank 0

        ; 91/B4EF

      rsJugdralHistoryUploadBG3Tilemap ; 91/B4EF

        .al
        .xl
        .autsiz
        .databank ?

        tya
        and #$0010
        beq _B503
        jsl rlDMAByStruct

          .structDMAToVRAM aDecompressionBuffer+$1000, $0800, $80, $9000

        rts


        _B503
        jsl rlDMAByStruct

          .structDMAToVRAM aDecompressionBuffer+$1800, $0800, $80, $9800

        rts

        .databank 0

        ; 91/B511

      rsJugdralHistoryCopyBG2Row ; 91/B511

        .al
        .xl
        .autsiz
        .databank ?

        tya
        pha
        jsr rsJugdralHistoryLineOffset
        pha
        lda #$7E00
        sta lR18+1
        pla
        clc
        adc #$8B88
        sta lR18
        pla
        sta wR0
        asl a
        clc
        adc wR0
        asl a
        tax
        lda aJugdralHistoryEntries,x
        xba
        lsr a
        tax
        ldy #$0000

        _B536
        lda aJugdralHistoryBG2Rows,x
        sta [lR18],y
        inc x
        inc x
        inc y
        inc y
        cpy #$0080
        bne _B536
        rts

        .databank 0

        ; 91/B546

    .endsection JugdralHistoryClearLineSection


    .section JugdralHistoryBG2RowsSection

      .al
      .xl

      aJugdralHistoryBG2Rows ; 91/B546

        ; Read by rsJugdralHistoryCopyBG2Row.

        .word $19AF, $19E0, $19C2, $19C3, $19C4, $19C5, $19C6, $19C7
        .word $19C8, $19C9, $19CA, $19CB, $19CC, $19CD, $19CE, $19CF
        .word $59CF, $59CF, $59CE, $59CD, $59CC, $59CB, $59CA, $59C9
        .word $59C8, $59C7, $59C6, $59C5, $59C4, $59C3, $59C2, $59E0
        .word $19AF, $19D1, $19D2, $19D3, $19D4, $19D5, $19D6, $19D7
        .word $19D8, $19D9, $19DA, $19DB, $19DC, $19DD, $19DE, $19DF
        .word $59DF, $59DF, $59DE, $59DD, $59DC, $59DB, $59DA, $59D9
        .word $59D8, $59D7, $59D6, $59D5, $59D4, $59D3, $59D2, $59D1
        .word $19E0, $19E1, $19E2, $19E3, $19E4, $19E5, $19E6, $19E7
        .word $19E8, $19E9, $19EA, $19EB, $19EC, $19ED, $19EE, $19EF
        .word $59EF, $59EF, $19EE, $59ED, $59EC, $59EB, $59EA, $59E9
        .word $59E8, $59E7, $59E6, $59E5, $59E4, $59E3, $59E2, $59E1
        .word $19F0, $19F1, $19F2, $19F3, $19F4, $19F5, $19F6, $19F7
        .word $19F8, $19F9, $19FA, $19FB, $19FC, $19FD, $19FE, $19FF
        .word $59FF, $59FF, $19FE, $59FD, $59FC, $59FB, $59FA, $59F9
        .word $59F8, $59F7, $59F6, $59F5, $59F4, $59F3, $59F2, $59F1
        .word $99F0, $99F1, $99F2, $99F3, $99F4, $99F5, $99F6, $99F7
        .word $99F8, $99F9, $99FA, $99FB, $99FC, $99FD, $99FE, $99FF
        .word $D9FF, $D9FF, $99FE, $D9FD, $D9FC, $D9FB, $D9FA, $D9F9
        .word $D9F8, $D9F7, $D9F6, $D9F5, $D9F4, $D9F3, $D9F2, $D9F1
        .word $99E0, $99E1, $99E2, $99E3, $99E4, $99E5, $99E6, $99E7
        .word $99E8, $99E9, $99EA, $99EB, $99EC, $99ED, $99EE, $99EF
        .word $D9EF, $D9EF, $99EE, $D9ED, $D9EC, $D9EB, $D9EA, $D9E9
        .word $D9E8, $D9E7, $D9E6, $D9E5, $D9E4, $D9E3, $D9E2, $D9E1
        .word $99AF, $99D1, $99D2, $99D3, $99D4, $99D5, $99D6, $99D7
        .word $99D8, $99D9, $99DA, $99DB, $99DC, $99DD, $99DE, $99DF
        .word $D9DF, $D9DF, $D9DE, $D9DD, $D9DC, $D9DB, $D9DA, $D9D9
        .word $D9D8, $D9D7, $D9D6, $D9D5, $D9D4, $D9D3, $D9D2, $D9D1
        .word $99AF, $99E0, $99C2, $99C3, $99C4, $99C5, $99C6, $99C7
        .word $99C8, $99C9, $99CA, $99CB, $99CC, $99CD, $99CE, $99CF
        .word $D9CF, $D9CF, $D9CE, $D9CD, $D9CC, $D9CB, $D9CA, $D9C9
        .word $D9C8, $D9C7, $D9C6, $D9C5, $D9C4, $D9C3, $D9C2, $D9E0
        .word $19AF, $19F0, $19F1, $19F2, $19F3, $19F4, $19F5, $19F6
        .word $19F7, $19F8, $19F9, $19FA, $19FB, $19FC, $19FD, $19FE
        .word $19FF, $19FF, $59FF, $59FE, $59FC, $59FB, $59FA, $59F8
        .word $59F7, $D9C6, $D9C5, $D9C4, $59F3, $59E2, $59C1, $59C0
        .word $19AF, $19AF, $19C1, $19C2, $19C3, $19C4, $19C5, $19C6
        .word $19C7, $19C8, $19C9, $19CA, $19CB, $19CC, $19CD, $19CE
        .word $19CF, $19CF, $59CF, $59ED, $59EC, $59EB, $D9CB, $59F8
        .word $59C7, $59C6, $59C5, $59C4, $59C3, $59C2, $59C1, $59D0
        .word $19AF, $19AF, $19D0, $19D1, $19D3, $19D4, $19D4, $19D5
        .word $19D6, $19D7, $19D8, $19D9, $19DA, $19DB, $19DC, $19DD
        .word $19DE, $19DF, $59DF, $59FD, $59FC, $59FB, $59CB, $D9F8
        .word $59D7, $59D6, $59D5, $59D4, $59C3, $59C2, $59C1, $59E0
        .word $19AF, $19AF, $19E0, $19E1, $19E3, $19E4, $19E4, $19E5
        .word $19E6, $19E7, $19E8, $19E9, $19EA, $19EB, $19EC, $19ED
        .word $19EE, $19EF, $59ED, $59CC, $59CB, $59DB, $59DB, $59F8
        .word $59E7, $59E6, $59F4, $59F3, $D9C3, $59C2, $59C1, $59F0
        .word $19AF, $19AF, $19F0, $19F1, $19F2, $19F3, $19F4, $19F5
        .word $19F6, $19F7, $19F8, $19F9, $19FA, $19FB, $19FC, $19FD
        .word $19FE, $19FF, $59FD, $59FB, $59FA, $59F9, $59F8, $D9F6
        .word $59F6, $59F5, $59F4, $D9C3, $59C2, $59C2, $59F0, $19AF
        .word $19AF, $19AF, $19C0, $19C1, $19C2, $19C3, $19C4, $19C5
        .word $19C6, $19C7, $19C8, $19C9, $19CA, $19CB, $19CC, $19CD
        .word $D9CD, $D9CC, $D9CB, $D9CA, $D9C9, $D9C8, $59C7, $59C6
        .word $59C5, $59C4, $59F3, $59C3, $59C2, $59C1, $59F0, $19AF
        .word $19AF, $19AF, $19D0, $19D1, $19D2, $19D3, $19D4, $19D5
        .word $19C6, $19C7, $19C8, $19C8, $19CA, $19CB, $19CC, $19CD
        .word $59CD, $59CC, $59CB, $D9D9, $D9D8, $99D9, $59D9, $D9D7
        .word $D9D6, $D9D5, $59F3, $59C3, $59C2, $59C1, $59F0, $19AF
        .word $19AF, $19AF, $19AF, $19D1, $9812, $9813, $9814, $19C6
        .word $9816, $9816, $9816, $9817, $9818, $9819, $981A, $19EE
        .word $19EE, $D81A, $D819, $D818, $9818, $9819, $D819, $D818
        .word $D9D6, $D9D5, $D9D5, $59C3, $59C2, $59C1, $59F0, $19AF
        .word $19AF, $19AF, $19AF, $19AF, $9802, $9803, $9804, $9805
        .word $9806, $9806, $9806, $9807, $9808, $9809, $980A, $980B
        .word $D80B, $D80A, $D809, $D808, $9808, $9809, $D809, $D808
        .word $D807, $D806, $980F, $D804, $D803, $D802, $19AF, $19AF
        .word $013C, $013C, $013C, $013C, $013C, $013C, $013C, $013C
        .word $013C, $013C, $013C, $013C, $013C, $013C, $013C, $013C
        .word $013C, $013C, $013C, $013C, $013C, $013C, $013C, $013C
        .word $013C, $013C, $013C, $013C, $013C, $013C, $013C, $013C
        .word $013C, $013C, $013C, $013C, $013C, $013C, $013C, $013C
        .word $013C, $013C, $013C, $013C, $013C, $013C, $013C, $013C
        .word $013C, $013C, $013C, $013C, $013C, $013C, $013C, $013C
        .word $013C, $013C, $013C, $013C, $013C, $013C, $013C, $013C
        .word $013C, $013C, $013C, $013C, $013C, $013C, $013C, $013C
        .word $013C, $013C, $013C, $013C, $013C, $013C, $013C, $013C
        .word $013C, $013C, $013C, $013C, $013C, $013C, $013C, $013C
        .word $013C, $013C, $013C, $013C, $013C, $013C, $013C, $013C

        ; 91/BA46

    .endsection JugdralHistoryBG2RowsSection


    .section SetJugdralHistoryTextColorsSection

      .al
      .xl

      rlSetJugdralHistoryTextColors ; 91/BA46

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0000

        _BA49
        lda aJugdralHistoryTextColors,x
        sta @l aBGPaletteBuffer,x
        inc x
        inc x
        cpx #$0008
        bne _BA49
        rtl

        .databank 0

        ; 91/BA59

      rlSetJugdralHistoryBackgroundColors ; 91/BA59

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0000

        _BA5C
        lda aJugdralHistoryBackgroundColors,x
        sta @l aBGPaletteBuffer.aPalette4,x
        inc x
        inc x
        cpx #$0020
        bne _BA5C
        rtl

        .databank 0

        ; 91/BA6C

    .endsection SetJugdralHistoryTextColorsSection


    .section Data91BA6CSection

      .al
      .xl

      aJugdralHistoryTextColors ; 91/BA6C

        ; Read by rlSetJugdralHistoryTextColors.

        .word $0000, $318C, $7674, $24E7, $0000, $0000, $0000, $0000

        ; 91/BA7C

      aJugdralHistoryBackgroundColors ; 91/BA7C

        ; Read by rlSetJugdralHistoryBackgroundColors.

        .word $3000, $0800, $0C00, $1000, $1020, $1420, $1820, $1C20
        .word $1C20, $2040, $2440, $2840, $2C40, $2C40, $3060, $3460

        ; 91/BA9C

    .endsection Data91BA6CSection


    .section JugdralHistoryHoldSection

      .al
      .xl

      rsJugdralHistoryHold ; 91/E780

        .al
        .xl
        .autsiz
        .databank ?

        lda wJoy1New
        bit #$1000
        bne _E78C
        dec wSaveMenuCommandRow,b
        bne _E792

        _E78C
        lda #$0022
        sta wGameStateStep,b

        _E792
        rts

        .databank 0

        ; 91/E793

    .endsection JugdralHistoryHoldSection


