; Options menu setup, labels, BG settings, and COLDATA/BG3VOFS HDMA tables.


    .section Table80E586Section

      .al
      .xl

      aOptionsMenuTilemapEntry ; 80/E586
        .byte $20, $20, $00, $00, $00, $00, $88, $83, $7E

      aOptionsMenuDescriptionTilemapEntry ; 80/E58F
        .byte $3C, $01, $00, $00, $00, $00, $2E, $84, $7F

    .endsection Table80E586Section


    .section Unsorted80E598Section

      .al
      .xl

      rsOpenOptionsMenu ; 80/E598

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        ; Opens options menu (game state $2A/$29), loads state/gfx/BG/HDMAs/labels, calls bank $89 setup

        php
        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        lda #<>rsRunMenuScreenVBlank
        sta wVBlankPointer
        jsl rlHaltUntilVBlank
        jsl rlDisableVBlank
        jsl rlHardwareResetScreenPosMathHDMA
        jsl rlHardwareResetScreenRegisters
        lda #$0000
        sta wR1
        lda #$0000
        sta wR3
        lda #$4000
        sta wR5
        lda #$2000
        sta wR6
        lda #$2800
        sta wR8
        jsl rlSetLayerPositionsAndSizes
        jsl rlProcEngineResetProcEngine
        jsl rlActiveSpriteEngineReset
        jsl rlResetHDMAEngine
        jsl rlResetIRQEngine
        jsl rlResetRAMStructAndAreaVariables
        jsl rlUnknown8780AA
        jsl rlResetMenuOptionStack
        jsr rsInitializeOptionsMenuVariables
        jsr rsLoadOptionsMenuGraphics
        jsr rsSetOptionsMenuBGSettings
        jsr rsCreateOptionsMenuHDMA
        jsr rsDrawOptionsMenuLabels
        jsl rlUnknown89ED12
        jsl rlUnknown89F246
        jsl rlUnknown89F065
        lda #$0000
        sta wGameStateStep,b
        lda #$002A
        sta wGameStateRoutine1,b
        lda #$0029
        sta wGameStateRoutine2,b
        lda #<>rsRunFrameTasks
        sta wMainLoopPointer
        jsl rlEnableVBlank
        plp
        rts

        .databank 0

        ; 80/E627

      rsInitializeOptionsMenuVariables ; 80/E627

        .al
        .xl
        .autsiz
        .databank ?

        ; Checks completion count ($7F842C) and loads current option settings into $7F8400..$7F8424

        lda #$0000
        sta $7F8400
        sta $7F8428
        lda #$0023
        sta $7F8426
        lda #$0000
        sta $7F842C
        jsl rlGetCurrentSaveCompletionCount
        cmp #$0000
        beq _E650
        lda #$0001
        sta $7F842C

        _E650
        jsl rlGetAnimationOptionSetting
        sta wDebugMenuScreenIndex
        sta wDebugMenuTemp3
        jsl rlCheckIfTerrainWindowSettingOff
        sta $7F8404
        sta $7F8416
        jsl rlCheckIfUnitWindowSettingOff
        sta $7F8406
        sta $7F8418
        jsl rlGetTextSpeedOption
        sta $7F8408
        sta $7F841A
        jsl rlUnknown87BF1B
        sta $7F840A
        sta $7F841C
        jsl rlUnknown87BF43
        sta $7F840C
        sta $7F841E
        jsl rlUnknown87BFB0
        sta wR0
        cmp #$0000
        beq _E6A8
        jsl rlUnknown87BFD9
        inc a

        _E6A8
        sta $7F840E
        sta $7F8420
        jsl rlUnknown87C02F
        sta wDebugMenuTemp1
        sta $7F8422
        jsl rlGetCleverModeFlag
        sta wDebugMenuTemp2
        sta $7F8424
        rts

        .databank 0

        ; 80/E6C9

      rsLoadOptionsMenuGraphics ; 80/E6C9

        .al
        .xl
        .autsiz
        .databank ?

        ; Loads options gfx (80E72E/36/3E, g2bppMenuLabels, g4bppWindowFrames, cursor sprites) and aWindowPalette

        lda #(`aDecompressionDMAEntry80E72E)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry80E72E
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        jsl rlDMAByStruct

          .structDMAToVRAM g2bppMenuLabels, $1800, $80, $1800

        jsl rlDMAByStruct

          .structDMAToVRAM g4bppWindowFrames, $0C00, $80, $6000

        jsl rlDMAByStruct

          .structDMAToVRAM g4bppCursorSprites, $0400, $80, $8000

        lda #(`aDecompressionDMAEntry80E736)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry80E736
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        ldx #$0200

        _E70F
        lda aWindowPalette-2,x
        sta aBGPaletteBuffer-2,x
        dec x
        dec x
        bne _E70F
        lda #$0000
        sta aBGPaletteBuffer,b
        lda #(`aDecompressionDMAEntry80E73E)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry80E73E
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        rts

        .databank 0

        ; 80/E72E

    .endsection Unsorted80E598Section


    .section Unsorted80E746Section

      .al
      .xl

      rsDrawOptionsMenuLabels ; 80/E746

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws the 8-9 Shift-JIS option labels to aBG3TilemapBuffer and DMAs to VRAM $5000

        lda #(`aOptionsMenuTilemapEntry)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aOptionsMenuTilemapEntry
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$02EF
        jsl rlUnitWindowFillBG3Buffer
        lda #$3C00
        sta wR1
        lda #$02E2
        sta wR2
        lda #$0004
        sta wR0
        ldx #$0048
        jsl rlDrawBG3TileRun
        lda #$3C00
        sta wR1
        lda #$02E0
        sta wR2
        lda #$0002
        sta wR0
        ldx #$005C
        jsl rlDrawBG3TileRun
        lda #$3000
        sta wR1
        lda #$02CB
        sta wR2
        lda #$0005
        sta wR0
        ldx #$006E
        jsl rlDrawBG3TileRun
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda #(`aOptionsMenuAnimationLabel)<<8
        sta lR18+1
        lda #<>aOptionsMenuAnimationLabel
        sta lR18
        ldx #$0404
        jsl rlDrawMenuTextLine
        lda #(`aOptionsMenuTerrainWindowLabel)<<8
        sta lR18+1
        lda #<>aOptionsMenuTerrainWindowLabel
        sta lR18
        ldx #$0604
        jsl rlDrawMenuTextLine
        lda #(`aOptionsMenuUnitWindowLabel)<<8
        sta lR18+1
        lda #<>aOptionsMenuUnitWindowLabel
        sta lR18
        ldx #$0804
        jsl rlDrawMenuTextLine
        lda #(`aOptionsMenuMessageSpeedLabel)<<8
        sta lR18+1
        lda #<>aOptionsMenuMessageSpeedLabel
        sta lR18
        ldx #$0A04
        jsl rlDrawMenuTextLine
        lda #(`aOptionsMenuEnemySpeedLabel)<<8
        sta lR18+1
        lda #<>aOptionsMenuEnemySpeedLabel
        sta lR18
        ldx #$0C04
        jsl rlDrawMenuTextLine
        lda #(`aOptionsMenuSoundSettingLabel)<<8
        sta lR18+1
        lda #<>aOptionsMenuSoundSettingLabel
        sta lR18
        ldx #$0E04
        jsl rlDrawMenuTextLine
        lda #(`aOptionsMenuAutoSaveLabel)<<8
        sta lR18+1
        lda #<>aOptionsMenuAutoSaveLabel
        sta lR18
        ldx #$1004
        jsl rlDrawMenuTextLine
        lda #(`aOptionsMenuAutoCursorLabel)<<8
        sta lR18+1
        lda #<>aOptionsMenuAutoCursorLabel
        sta lR18
        ldx #$1204
        jsl rlDrawMenuTextLine
        lda $7F842C
        beq _E840
        lda #(`aOptionsMenuCleverModeLabel)<<8
        sta lR18+1
        lda #<>aOptionsMenuCleverModeLabel
        sta lR18
        ldx #$1404
        jsl rlDrawMenuTextLine

        _E840
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0800, $80, $5000

        rts

        .databank 0

        ; 80/E84E

    .endsection Unsorted80E746Section


    .section Table80E84ESection

      .al
      .xl

      aOptionsMenuAnimationLabel ; 80/E84E

        .enc "SJIS"
        .text "アニメせってい"
        .word $0000
        .enc "none"

      aOptionsMenuTerrainWindowLabel ; 80/E85E

        .enc "SJIS"
        .text "ちけいウィンドウ"
        .word $0000
        .enc "none"

      aOptionsMenuUnitWindowLabel ; 80/E870

        .enc "SJIS"
        .text "ユニットウィンドウ"
        .word $0000
        .enc "none"

      aOptionsMenuMessageSpeedLabel ; 80/E884

        .enc "SJIS"
        .text "メッセージスピード"
        .word $0000
        .enc "none"

      aOptionsMenuEnemySpeedLabel ; 80/E898

        .enc "SJIS"
        .text "てきいどうスピード"
        .word $0000
        .enc "none"

      aOptionsMenuSoundSettingLabel ; 80/E8AC

        .enc "SJIS"
        .text "サウンドせってい"
        .word $0000
        .enc "none"

      aOptionsMenuAutoSaveLabel ; 80/E8BE

        .enc "SJIS"
        .text "オートセーブ"
        .word $0000
        .enc "none"

      aOptionsMenuAutoCursorLabel ; 80/E8CC

        .enc "SJIS"
        .text "オートカーソル"
        .word $0000
        .enc "none"

      aOptionsMenuCleverModeLabel ; 80/E8DC

        .enc "SJIS"
        .text "てきのあたまのよさ"
        .word $0000
        .enc "none"


    .endsection Table80E84ESection


    .section Unsorted80E8F0Section

      .al
      .xl

      rsSetOptionsMenuBGSettings ; 80/E8F0

        .al
        .xl
        .autsiz
        .databank ?

        ; Sets BG1-3SC |= 2, TM=$15, CGADSUB=$81, clears BG1-3 H/V scrolls for options menu

        sep #$20
        lda bBufferBG1SC
        and #$FC
        ora #$02
        sta bBufferBG1SC
        lda bBufferBG2SC
        and #$FC
        ora #$02
        sta bBufferBG2SC
        lda bBufferBG3SC
        and #$FC
        ora #$02
        sta bBufferBG3SC
        lda #$15
        sta bBufferTM
        lda #$00
        sta bBufferTS
        lda #$00
        sta bBufferTMW
        lda #$00
        sta bBufferTSW
        lda #$00
        sta bBufferW12SEL
        lda #$00
        sta bBufferW34SEL
        lda #$00
        sta bBufferWOBJSEL
        lda #$00
        sta bBufferWH0
        lda #$FF
        sta bBufferWH1
        lda #$00
        sta bBufferWH2
        sta bBufferWH3
        lda #$00
        sta bBufferWBGLOG
        sta bBufferWOBJLOG
        lda #$00
        sta bBufferCGWSEL
        lda #$81
        sta bBufferCGADSUB
        rep #$20
        stz wBufferBG1HOFS
        stz wBufferBG1VOFS
        stz wBufferBG2HOFS
        stz wBufferBG2VOFS
        stz wBufferBG3HOFS
        stz wBufferBG3VOFS
        rts

        .databank 0

        ; 80/E951

      rsCreateOptionsMenuHDMA ; 80/E951

        .al
        .xl
        .autsiz
        .databank ?

        ; Creates options COLDATA and BG3VOFS HDMA entries

        lda #(`aOptionsMenuCOLDATAHDMA)<<8
        sta lR44+1
        lda #<>aOptionsMenuCOLDATAHDMA
        sta lR44
        jsl rlHDMAEngineCreateEntry
        lda #(`aOptionsMenuBG3VOFSHDMA)<<8
        sta lR44+1
        lda #<>aOptionsMenuBG3VOFSHDMA
        sta lR44
        jsl rlHDMAEngineCreateEntry
        rts

        .databank 0

        ; 80/E96E

    .endsection Unsorted80E8F0Section


    .section Table80E96ESection

      .al
      .xl

      aOptionsMenuCOLDATAHDMA .dstruct structHDMADirectEntryInfo, rlInitOptionsMenuCOLDATAHDMA, rlCycleOptionsMenuCOLDATAHDMA, $E97A, $7F855A, PPU_REG_BASE + $32, $00 ; 80/E96E

    .endsection Table80E96ESection


    .section Unsorted80E979Section

      .al
      .xl

      rlCycleOptionsMenuCOLDATAHDMA ; 80/E979

        .al
        .xl
        .autsiz
        .databank ?

        ; HDMA onCycle rtl stub for aOptionsMenuCOLDATAHDMA

        rtl

        .databank 0

        ; 80/E97A


      aOptionsMenuCOLDATAHDMACode ; 80/E97A

        HDMA_HALT

    .endsection Unsorted80E979Section


    .section Unsorted80E97CSection

      .al
      .xl

      rlInitOptionsMenuCOLDATAHDMA ; 80/E97C

        .al
        .xl
        .autsiz
        .databank ?

        ; Copies aOptionsMenuCOLDATAHDMATable into $7F855A

        ldx #$0000

        _E97F
        lda aOptionsMenuCOLDATAHDMATable,x
        sta $7F855A,x
        beq _E98D
        inc x
        inc x
        bra _E97F


        _E98D
        rtl

        .databank 0

        ; 80/E98E

    .endsection Unsorted80E97CSection


    .section Data80E98ESection

      .al
      .xl

      aOptionsMenuCOLDATAHDMATable ; 80/E98E

        ; Read by rlInitOptionsMenuCOLDATAHDMA.

        .byte $18, $E0, $18, $E1, $18, $E2, $18, $E3, $18, $E4, $18, $E5, $10, $E6, $10, $E7
        .byte $18, $E8, $18, $E9, $00, $00

      aOptionsMenuBG3VOFSHDMA ; 80/E9A4
        .byte $B2, $E9, $AF, $E9, $B0, $E9, $5A, $87, $7F, $12, $02

        ; 80/E9AF

    .endsection Data80E98ESection


    .section Unsorted80E9AFSection

      .al
      .xl

      rlCycleOptionsMenuBG3VOFSHDMA ; 80/E9AF

        .al
        .xl
        .autsiz
        .databank ?

        ; HDMA onCycle rtl stub for aOptionsMenuBG3VOFSHDMA

        rtl

        .databank 0

        ; 80/E9B0


      aOptionsMenuBG3VOFSHDMACode ; 80/E9B0

        HDMA_HALT

    .endsection Unsorted80E9AFSection


    .section Unsorted80E9B2Section

      .al
      .xl

      rlInitOptionsMenuBG3VOFSHDMA ; 80/E9B2

        .al
        .xl
        .autsiz
        .databank ?

        ; Copies $8D-byte 9-option ($7F842C!=0) or $B7-byte 8-option BG3VOFS HDMA table into $7F875A

        phk
        plb
        .databank $80
        ldx #$0000
        lda $7F842C
        beq _E9D8

        _E9BD
        sep #$20
        lda $E9F3,b,x
        sta $7F875A,x
        rep #$20
        lda $E9F4,b,x
        sta $7F875B,x
        inc x
        inc x
        inc x
        cpx #$008D
        bne _E9BD
        rtl


        _E9D8
        sep #$20
        lda <>aOptionsMenuBG3VOFS8OptionsHDMATable,b,x
        sta $7F875A,x
        rep #$20
        lda <>aOptionsMenuBG3VOFS8OptionsHDMATable+1,b,x
        sta $7F875B,x
        inc x
        inc x
        inc x
        cpx #$00B7
        bne _E9D8
        rtl

        .databank 0

        ; 80/E9F3

    .endsection Unsorted80E9B2Section


    .section Data80E9F3Section

      .al
      .xl

      aOptionsMenuBG3VOFS9OptionsHDMATable ; 80/E9F3

        ; Read by rlInitOptionsMenuBG3VOFSHDMA.

        .byte $1D, $FF, $FF, $13, $00, $00, $01, $00, $00, $01, $FF, $FF, $01, $FE, $FF, $01
        .byte $FD, $FF, $11, $FC, $FF, $01, $FB, $FF, $01, $FA, $FF, $01, $F8, $FF, $01, $F8
        .byte $FF, $10, $F7, $FF, $01, $F6, $FF, $01, $F6, $FF, $01, $F5, $FF, $01, $F4, $FF
        .byte $01, $F2, $FF, $01, $F2, $FF, $10, $F2, $FF, $01, $F0, $FF, $01, $F0, $FF, $01
        .byte $EF, $FF, $01, $EE, $FF, $01, $EC, $FF, $10, $ED, $FF, $01, $EB, $FF, $01, $EC
        .byte $FF, $01, $E9, $FF, $01, $E9, $FF, $10, $E8, $FF, $01, $E7, $FF, $01, $E6, $FF
        .byte $01, $E5, $FF, $01, $E4, $FF, $01, $E3, $FF, $11, $E3, $FF, $01, $E1, $FF, $01
        .byte $E2, $FF, $01, $E0, $FF, $01, $DF, $FF, $11, $DE, $FF, $01, $DD, $FF, $01, $DD
        .byte $FF, $01, $DB, $FF, $01, $DB, $FF, $13, $D9, $FF, $00, $00, $00

        ; 80/EA80

    .endsection Data80E9F3Section


    .section Data80EA80Section

      .al
      .xl

      aOptionsMenuBG3VOFS8OptionsHDMATable ; 80/EA80

        ; Read by rlInitOptionsMenuBG3VOFSHDMA.

        .byte $1D, $FF, $FF, $13, $FE, $FF, $01, $FE, $FF, $01, $FE, $FF, $01, $FE, $FF
        .byte $01, $FE, $FF, $01, $FB, $FF, $01, $FA, $FF, $01, $F9, $FF, $01, $F8, $FF
        .byte $10, $F7, $FF, $01, $F7, $FF, $01, $F7, $FF, $01, $F6, $FF, $01, $F4, $FF
        .byte $01, $F3, $FF, $01, $F2, $FF, $01, $F1, $FF, $10, $F0, $FF, $01, $F0, $FF
        .byte $01, $F0, $FF, $01, $EF, $FF, $01, $ED, $FF, $01, $EC, $FF, $01, $EB, $FF
        .byte $01, $EA, $FF, $10, $E9, $FF, $01, $E9, $FF, $01, $E9, $FF, $01, $E8, $FF
        .byte $01, $E6, $FF, $01, $E5, $FF, $01, $E4, $FF, $01, $E3, $FF, $10, $E2, $FF
        .byte $01, $E2, $FF, $01, $E2, $FF, $01, $E1, $FF, $01, $DF, $FF, $01, $DE, $FF
        .byte $01, $DD, $FF, $01, $DC, $FF, $10, $DB, $FF, $01, $DB, $FF, $01, $DB, $FF
        .byte $01, $DA, $FF, $01, $D8, $FF, $01, $D7, $FF, $01, $D6, $FF, $01, $D5, $FF
        .byte $10, $D4, $FF, $01, $D4, $FF, $01, $D4, $FF, $01, $D3, $FF, $01, $D1, $FF
        .byte $01, $D0, $FF, $01, $CF, $FF, $01, $CE, $FF, $13, $CD, $FF, $01, $00, $00
        .byte $00, $00, $00

        ; 80/EB37

    .endsection Data80EA80Section


