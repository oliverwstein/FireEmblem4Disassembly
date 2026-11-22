; The options menu: nine settings (animation, terrain and unit windows, message
; and enemy speed, sound, auto save, auto cursor, and the enemy AI once the game
; has been finished). rsOpenOptionsMenu (bank $80) copies the settings into
; aOptionsMenuValues and draws the screen; game state routines $2A
; (rlOptionsMenuSetup, once), $2B (rlOptionsMenuStep, aOptionsMenuSteps) and $29
; (rlOptionsMenuUpkeep, every frame) run it. A or B writes the values back
; (rlOptionsMenuApplyValues) and leaves to the map or the castle. Banks $80 and $89;
; variables at $7F8400 (include/WRAM.h), constants in include/Menus.h.


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
        jsl rlInitMapMenus
        jsl rlResetMenuOptionStack
        jsr rsInitializeOptionsMenuVariables
        jsr rsLoadOptionsMenuGraphics
        jsr rsSetOptionsMenuBGSettings
        jsr rsCreateOptionsMenuHDMA
        jsr rsDrawOptionsMenuLabels
        jsl rlOptionsMenuDrawChoices
        jsl rlOptionsMenuDrawDescription
        jsl rlOptionsMenuDrawValues
        lda #OPTIONS_MENU_STEP_CHOOSE
        sta wGameStateStep,b
        lda #GAMESTATE_OPTIONS_MENU_SETUP
        sta wGameStateRoutine1,b
        lda #GAMESTATE_OPTIONS_MENU_UPKEEP
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

        ; Cursor on the first option; shows the enemy AI option (wOptionsMenuShowEnemyAI) if the save has finished the game; copies each setting into aOptionsMenuValues and aOptionsMenuOpeningValues. Auto save is stored as 0 for off or the file plus 1.

        lda #$0000
        sta wOptionsMenuCursor
        sta wOptionsMenuCursorMove
        lda #$0023
        sta $7F8426
        lda #$0000
        sta wOptionsMenuShowEnemyAI
        jsl rlGetCurrentSaveCompletionCount
        cmp #$0000
        beq _E650
        lda #$0001
        sta wOptionsMenuShowEnemyAI

        _E650
        jsl rlGetAnimationOptionSetting
        sta aOptionsMenuValues.wAnimation
        sta aOptionsMenuOpeningValues.wAnimation
        jsl rlCheckIfTerrainWindowSettingOff
        sta aOptionsMenuValues.wTerrainWindow
        sta aOptionsMenuOpeningValues.wTerrainWindow
        jsl rlCheckIfUnitWindowSettingOff
        sta aOptionsMenuValues.wUnitWindow
        sta aOptionsMenuOpeningValues.wUnitWindow
        jsl rlGetTextSpeedOption
        sta aOptionsMenuValues.wMessageSpeed
        sta aOptionsMenuOpeningValues.wMessageSpeed
        jsl rlUnknown87BF1B
        sta aOptionsMenuValues.wEnemySpeed
        sta aOptionsMenuOpeningValues.wEnemySpeed
        jsl rlUnknown87BF43
        sta aOptionsMenuValues.wSound
        sta aOptionsMenuOpeningValues.wSound
        jsl rlUnknown87BFB0
        sta wR0
        cmp #$0000
        beq _E6A8
        jsl rlUnknown87BFD9
        inc a

        _E6A8
        sta aOptionsMenuValues.wAutoSave
        sta aOptionsMenuOpeningValues.wAutoSave
        jsl rlUnknown87C02F
        sta aOptionsMenuValues.wAutoCursor
        sta aOptionsMenuOpeningValues.wAutoCursor
        jsl rlGetCleverModeFlag
        sta aOptionsMenuValues.wEnemyAI
        sta aOptionsMenuOpeningValues.wEnemyAI
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
        lda wOptionsMenuShowEnemyAI
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

      aOptionsMenuCOLDATAHDMA .dstruct structHDMADirectEntryInfo, rlInitOptionsMenuCOLDATAHDMA, rlCycleOptionsMenuCOLDATAHDMA, aOptionsMenuCOLDATAHDMACode, aOptionsMenuCOLDATAHDMABuffer, PPU_REG_BASE + $32, $00 ; 80/E96E

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

        ; Copies aOptionsMenuCOLDATAHDMATable into aOptionsMenuCOLDATAHDMABuffer.

        ldx #$0000

        _E97F
        lda aOptionsMenuCOLDATAHDMATable,x
        sta aOptionsMenuCOLDATAHDMABuffer,x
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

      aOptionsMenuBG3VOFSHDMA .dstruct structHDMADirectEntryInfo, rlInitOptionsMenuBG3VOFSHDMA, rlCycleOptionsMenuBG3VOFSHDMA, aOptionsMenuBG3VOFSHDMACode, aOptionsMenuBG3VOFSHDMABuffer, PPU_REG_BASE + $12, $02 ; 80/E9A4

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

        ; Copies the BG3 scroll HDMA table for nine options (wOptionsMenuShowEnemyAI) or eight into aOptionsMenuBG3VOFSHDMABuffer.

        phk
        plb
        .databank $80
        ldx #$0000
        lda wOptionsMenuShowEnemyAI
        beq _E9D8

        _E9BD
        sep #$20
        lda <>aOptionsMenuBG3VOFS9OptionsHDMATable,b,x
        sta aOptionsMenuBG3VOFSHDMABuffer,x
        rep #$20
        lda <>aOptionsMenuBG3VOFS9OptionsHDMATable+1,b,x
        sta aOptionsMenuBG3VOFSHDMABuffer+1,x
        inc x
        inc x
        inc x
        cpx #$008D
        bne _E9BD
        rtl


        _E9D8
        sep #$20
        lda <>aOptionsMenuBG3VOFS8OptionsHDMATable,b,x
        sta aOptionsMenuBG3VOFSHDMABuffer,x
        rep #$20
        lda <>aOptionsMenuBG3VOFS8OptionsHDMATable+1,b,x
        sta aOptionsMenuBG3VOFSHDMABuffer+1,x
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


    .section Unsorted89EB26Section

      .al
      .xl

      rlOptionsMenuSetup ; 89/EB26

        .al
        .xl
        .autsiz
        .databank ?

        ; Game state routine $2A, once: starts a fade-in, rlOptionsMenuDrawIcons and rlOptionsMenuDrawSelectedIcon, and moves on to $2B.

        inc wGameStateRoutine1,b
        lda #(`procFadeIn)<<8
        sta lR44+1
        lda #<>procFadeIn
        sta lR44
        jsl rlProcEngineCreateProc
        jsl rlOptionsMenuDrawIcons
        jsl rlOptionsMenuDrawSelectedIcon
        rtl

        .databank 0

        ; 89/EB40

      rlOptionsMenuStep ; 89/EB40

        .al
        .xl
        .autsiz
        .databank ?

        ; Game state routine $2B, every frame: runs the routine for wGameStateStep from aOptionsMenuSteps.

        phb
        php
        phk
        plb
        .databank $89
        lda wGameStateStep,b
        cmp #$0004
        bmi _EB4E

        _EB4C
        bra _EB4C


        _EB4E
        asl a
        tax
        jsr (aOptionsMenuSteps,x)
        plp
        plb
        .databank $89
        rtl

        .databank 0

        ; 89/EB56

    .endsection Unsorted89EB26Section


    .section Table89EB56Section

      .al
      .xl

      aOptionsMenuSteps ; 89/EB56

        ; Jump table of rlOptionsMenuStep.
        .word <>rsOptionsMenuChooseOption
        .word <>rsOptionsMenuLeave
        .word <>rsOptionsMenuReturnToMap
        .word <>rsOptionsMenuWait

    .endsection Table89EB56Section


    .section Unsorted89EB5ESection

      .al
      .xl

      rsOptionsMenuChooseOption ; 89/EB5E

        .al
        .xl
        .autsiz
        .databank ?

        ; Step $00. Up and Down move to another option (one frame later, wOptionsMenuCursorMove), Right or R and Left or L change its value, Y puts back the values the menu opened with. A and B (rlOptionsMenuUpkeep) keep the values and leave.

        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0700, $80, $5000

        lda wOptionsMenuCursorMove
        bmi _EBD7
        bne _EB91
        lda wJoy1Repeated
        bit #$0800
        bne _EBA1
        bit #$0400
        bne _EBB6
        bit #$0110
        bne _EB95
        bit #$0220
        bne _EB99
        lda wJoy1New
        bit #$4000
        bne _EB9D
        rts


        _EB91
        jml _EC01


        _EB95
        jml _EC1A


        _EB99
        jml rsOptionsMenuDecreaseValue


        _EB9D
        jml rsOptionsMenuRestoreValues


        _EBA1
        lda wOptionsMenuCursor
        beq _EBB5
        lda #$0006
        jsl rlPlaySoundEffect
        lda #$F000
        sta wOptionsMenuCursorMove

        _EBB5
        rts


        _EBB6
        lda #$0007
        clc
        adc wOptionsMenuShowEnemyAI
        sta wR0
        lda wOptionsMenuCursor
        cmp wR0
        beq _EBD6
        lda #$0006
        jsl rlPlaySoundEffect
        lda #$1000
        sta wOptionsMenuCursorMove

        _EBD6
        rts


        _EBD7
        lda wOptionsMenuCursorMove
        inc a
        sta wOptionsMenuCursorMove
        and #$000F
        cmp #$0001
        bne _EC00
        lda #$0000
        sta wOptionsMenuCursorMove
        lda wOptionsMenuCursor
        dec a
        sta wOptionsMenuCursor
        jsl rlOptionsMenuDrawChoices
        jsl rlOptionsMenuDrawDescription

        _EC00
        rts


        _EC01
        lda #$0000
        sta wOptionsMenuCursorMove
        lda wOptionsMenuCursor
        inc a
        sta wOptionsMenuCursor
        jsl rlOptionsMenuDrawChoices
        jsl rlOptionsMenuDrawDescription
        rts


        _EC1A
        lda wOptionsMenuCursor
        tax
        lda aOptionsMenuValueCounts,x
        and #$00FF
        sta wR0
        txa
        asl a
        tax
        lda aOptionsMenuValues,x
        inc a
        cmp wR0
        beq _EC47
        sta aOptionsMenuValues,x
        lda #$0007
        jsl rlPlaySoundEffect
        jsl rlOptionsMenuDrawChoices
        jsl rlOptionsMenuDrawValues

        _EC47
        rts

        .databank 0

      aOptionsMenuValueCounts ; 89/EC48
        .byte $03, $02, $02, $05, $02, $03, $05, $02, $02

      rsOptionsMenuDecreaseValue ; 89/EC51

        .al
        .xl
        .autsiz
        .databank ?

        lda wOptionsMenuCursor
        asl a
        tax
        lda aOptionsMenuValues,x
        beq _EC71
        dec a
        sta aOptionsMenuValues,x
        lda #$0007
        jsl rlPlaySoundEffect
        jsl rlOptionsMenuDrawChoices
        jsl rlOptionsMenuDrawValues

        _EC71
        rts

        .databank 0

      rsOptionsMenuRestoreValues ; 89/EC72

        .al
        .xl
        .autsiz
        .databank ?

        ; Y: puts back the values the menu opened with and redraws.

        lda #$0021
        jsl rlPlaySoundEffect
        jsl rlOptionsMenuRestoreValues
        jsl rlOptionsMenuDrawChoices
        jsl rlOptionsMenuDrawValues
        rts

        .databank 0

        ; 89/EC86

      rsOptionsMenuLeave ; 89/EC86

        .al
        .xl
        .autsiz
        .databank ?

        ; Step $01: back to the map, or to the castle screen if the menu was opened from there (bit 5 of wUnknown000D79).

        lda #OPTIONS_MENU_STEP_WAIT
        sta wGameStateStep,b
        lda wUnknown000D79,b
        bit #$0020
        bne _ECAF
        lda #$0000
        sta wMainGameMode,b
        lda #<>rsUnknown80B122
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        rts


        _ECAF
        jsl rlFadeToCastleScreen
        rts

        .databank 0

        ; 89/ECB4

    .endsection Unsorted89EB5ESection


    .section Unsorted89ECB4Section

      .al
      .xl

      rsOptionsMenuReturnToMap ; 89/ECB4

        .al
        .xl
        .autsiz
        .databank ?

        ; Step $02: no code sets it. Goes straight back to the map (rsUnknown80B122).

        lda #OPTIONS_MENU_STEP_WAIT
        sta wGameStateStep,b
        lda #$0001
        sta wMainGameMode,b
        lda #<>rsUnknown80B122
        sta wMainLoopPointer
        rts

        .databank 0

        ; 89/ECC6

    .endsection Unsorted89ECB4Section


    .section Unsorted89ECC6Section

      .al
      .xl

      rsOptionsMenuWait ; 89/ECC6

        .al
        .xl
        .autsiz
        .databank ?

        ; Step $03: nothing, while the fade runs.

        rts

        .databank 0

        ; 89/ECC7

    .endsection Unsorted89ECC6Section


    .section Unsorted89ECC7Section

      .al
      .xl

      rlOptionsMenuUpkeep ; 89/ECC7

        .al
        .xl
        .autsiz
        .databank ?

        ; Game state routine $29, every frame while the options menu is up: draws its sprites; once fully bright, B or A (checked here) leave or select.

        jsl rlOptionsMenuDrawCursor
        jsl rlOptionsMenuDrawValueMarker
        jsl rlOptionsMenuDrawIcons
        jsl rlOptionsMenuDrawSelectedIcon
        lda bBufferINIDISP
        and #$000F
        cmp #$000F
        bne _ECED
        lda wJoy1New
        bit #$8000
        bne _ECEE
        bit #$0080
        bne _ED00

        _ECED
        rtl


        _ECEE
        lda #$0021
        jsl rlPlaySoundEffect
        jsl rlOptionsMenuApplyValues
        lda #OPTIONS_MENU_STEP_LEAVE
        sta wGameStateStep,b
        rtl


        _ED00
        lda #$000A
        jsl rlPlaySoundEffect
        jsl rlOptionsMenuApplyValues
        lda #OPTIONS_MENU_STEP_LEAVE
        sta wGameStateStep,b
        rtl

        .databank 0

        ; 89/ED12

    .endsection Unsorted89ECC7Section


    .section Unsorted89ED12Section

      .al
      .xl

      rlOptionsMenuDrawChoices ; 89/ED12

        .al
        .xl
        .autsiz
        .databank ?

        ; The choices of the option under the cursor ("1 2 3", "ON OFF"...) under its caption, and the chosen one highlighted (a routine from aOptionsMenuHighlightRoutines).

        lda #$2400
        sta aCurrentTilemapInfo,b
        lda wOptionsMenuCursor
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda aOptionsMenuChoiceLists+1,x
        sta lR18+1
        lda aOptionsMenuChoiceLists,x
        sta lR18
        lda wOptionsMenuShowEnemyAI
        beq _ED3A
        ldx #$1415
        bra _ED3D


        _ED3A
        ldx #$1215

        _ED3D
        jsl rlDrawMenuTextLine
        lda #$3800
        sta aCurrentTilemapInfo,b
        lda wOptionsMenuCursor
        cmp #$0009
        bmi _ED52

        _ED50
        bra _ED50


        _ED52
        asl a
        tax
        jsr (aOptionsMenuHighlightRoutines,x)
        rtl

        .databank 0

        ; 89/ED58

    .endsection Unsorted89ED12Section


    .section Table89ED58Section

      .al
      .xl

      aOptionsMenuHighlightRoutines ; 89/ED58

        ; Jump table of rlOptionsMenuDrawChoices.
        .word <>rsOptionsMenuHighlightAnimation
        .word <>rsOptionsMenuHighlightOnOff
        .word <>rsOptionsMenuHighlightOnOff
        .word <>rsOptionsMenuHighlightMessageSpeed
        .word <>rsOptionsMenuHighlightEnemySpeed
        .word <>rsOptionsMenuHighlightSound
        .word <>rsOptionsMenuHighlightAutoSave
        .word <>rsOptionsMenuHighlightOnOff
        .word <>rsOptionsMenuHighlightEnemyAI

    .endsection Table89ED58Section


    .section Data89ED6ASection

      .al
      .xl

      aOptionsMenuChoiceLists ; 89/ED6A

        ; A long pointer per option to the line of its choices.

        .long aOptionsMenuChoices123
        .long aOptionsMenuChoicesOnOff
        .long aOptionsMenuChoicesOnOff
        .long aOptionsMenuChoices12345
        .long aOptionsMenuChoicesRealFast
        .long aOptionsMenuChoices123
        .long aOptionsMenuChoices01234
        .long aOptionsMenuChoicesOnOff
        .long aOptionsMenuChoicesNormalClever

      aOptionsMenuChoices123 ; 89/ED85

        .enc "SJIS"
        .text "　１　　２　　３　"
        .word $0000
        .enc "none"

      aOptionsMenuChoicesOnOff ; 89/ED99

        .enc "SJIS"
        .text "ＯＮ　　　　ＯＦＦ"
        .word $0000
        .enc "none"

      aOptionsMenuChoices12345 ; 89/EDAD

        .enc "SJIS"
        .text "１　２　３　４　５"
        .word $0000
        .enc "none"

      aOptionsMenuChoicesRealFast ; 89/EDC1

        .enc "SJIS"
        .text "リアル　　　はやい"
        .word $0000
        .enc "none"

      aOptionsMenuChoices01234 ; 89/EDD5

        .enc "SJIS"
        .text "０　１　２　３　４"
        .word $0000
        .enc "none"

      aOptionsMenuChoicesNormalClever ; 89/EDE9

        .enc "SJIS"
        .text "ふつう　　かしこい"
        .word $0000
        .enc "none"

        ; 89/EDFD

    .endsection Data89ED6ASection
    .section Unsorted89EDFDSection

      .al
      .xl

      rsOptionsMenuHighlightAnimation ; 89/EDFD

        .al
        .xl
        .autsiz
        .databank ?

        lda aOptionsMenuValues.wAnimation
        cmp #$0003
        bmi _EE08

        _EE06
        bra _EE06


        _EE08
        asl a
        tax
        jsr (aOptionsMenuAnimationHighlights,x)
        rts

        .databank 0

        ; 89/EE0E

    .endsection Unsorted89EDFDSection


    .section Table89EE0ESection

      .al
      .xl

      aOptionsMenuAnimationHighlights ; 89/EE0E

        ; Jump table of rsOptionsMenuHighlightAnimation.
        .word <>rsOptionsMenuHighlightAnimation1
        .word <>rsOptionsMenuHighlightAnimation2
        .word <>rsOptionsMenuHighlightAnimation3

    .endsection Table89EE0ESection


    .section Unsorted89EE14Section

      .al
      .xl

      rsOptionsMenuHighlightAnimation1 ; 89/EE14

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aOptionsMenuText1)<<8
        sta lR18+1
        lda #<>aOptionsMenuText1
        sta lR18
        ldx #$1416
        bra rsOptionsMenuHighlightAnimation3._EE3F

        .databank 0

        ; 89/EE23

      rsOptionsMenuHighlightAnimation2 ; 89/EE23

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aOptionsMenuText2)<<8
        sta lR18+1
        lda #<>aOptionsMenuText2
        sta lR18
        ldx #$1419
        bra rsOptionsMenuHighlightAnimation3._EE3F

        .databank 0

        ; 89/EE32

    .endsection Unsorted89EE14Section


    .section Unsorted89EE32Section

      .al
      .xl

      rsOptionsMenuHighlightAnimation3 ; 89/EE32

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aOptionsMenuText3)<<8
        sta lR18+1
        lda #<>aOptionsMenuText3
        sta lR18
        ldx #$141C

        _EE3F
        lda wOptionsMenuShowEnemyAI
        bne _EE4B
        txa
        sec
        sbc #$0200
        tax

        _EE4B
        jsl rlDrawMenuTextLine
        rts

        .databank 0

        ; 89/EE50

    .endsection Unsorted89EE32Section


    .section Unsorted89EE50Section

      .al
      .xl

      rsOptionsMenuHighlightOnOff ; 89/EE50

        .al
        .xl
        .autsiz
        .databank ?

        ; For the three ON/OFF options: highlights ON or OFF.

        lda wOptionsMenuCursor
        asl a
        tax
        lda aOptionsMenuValues,x
        beq _EE6B
        lda #(`aOptionsMenuOffText)<<8
        sta lR18+1
        lda #<>aOptionsMenuOffText
        sta lR18
        ldx #$141B
        bra _EE78


        _EE6B
        lda #(`aOptionsMenuOnText)<<8
        sta lR18+1
        lda #<>aOptionsMenuOnText
        sta lR18
        ldx #$1415

        _EE78
        lda wOptionsMenuShowEnemyAI
        bne _EE84
        txa
        sec
        sbc #$0200
        tax

        _EE84
        jsl rlDrawMenuTextLine
        rts

        .databank 0

        ; 89/EE89

    .endsection Unsorted89EE50Section


    .section Unsorted89EE89Section

      .al
      .xl

      rsOptionsMenuHighlightMessageSpeed ; 89/EE89

        .al
        .xl
        .autsiz
        .databank ?

        lda aOptionsMenuValues.wMessageSpeed
        cmp #$0005
        bmi _EE94

        _EE92
        bra _EE92


        _EE94
        asl a
        tax
        jsr (aOptionsMenuMessageSpeedHighlights,x)
        rts

        .databank 0

        ; 89/EE9A

    .endsection Unsorted89EE89Section


    .section Table89EE9ASection

      .al
      .xl

      aOptionsMenuMessageSpeedHighlights ; 89/EE9A

        ; Jump table of rsOptionsMenuHighlightMessageSpeed.
        .word <>rsOptionsMenuHighlightMessageSpeedText
        .word <>rsOptionsMenuHighlightMessageSpeedText._EEB3
        .word <>rsOptionsMenuHighlightMessageSpeedText._EEC2
        .word <>rsOptionsMenuHighlightMessageSpeedText._EED1
        .word <>rsOptionsMenuHighlightMessageSpeedText._EEE0

    .endsection Table89EE9ASection


    .section Unsorted89EEA4Section

      .al
      .xl

      rsOptionsMenuHighlightMessageSpeedText ; 89/EEA4

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aOptionsMenuText1)<<8
        sta lR18+1
        lda #<>aOptionsMenuText1
        sta lR18
        ldx #$1415
        bra _EEED


        _EEB3
        lda #(`aOptionsMenuText2)<<8
        sta lR18+1
        lda #<>aOptionsMenuText2
        sta lR18
        ldx #$1417
        bra _EEED


        _EEC2
        lda #(`aOptionsMenuText3)<<8
        sta lR18+1
        lda #<>aOptionsMenuText3
        sta lR18
        ldx #$1419
        bra _EEED


        _EED1
        lda #(`aOptionsMenuText4)<<8
        sta lR18+1
        lda #<>aOptionsMenuText4
        sta lR18
        ldx #$141B
        bra _EEED


        _EEE0
        lda #(`aOptionsMenuText5)<<8
        sta lR18+1
        lda #<>aOptionsMenuText5
        sta lR18
        ldx #$141D

        _EEED
        lda wOptionsMenuShowEnemyAI
        bne _EEF9
        txa
        sec
        sbc #$0200
        tax

        _EEF9
        jsl rlDrawMenuTextLine
        rts

        .databank 0

        ; 89/EEFE

    .endsection Unsorted89EEA4Section


    .section Unsorted89EEFESection

      .al
      .xl

      rsOptionsMenuHighlightEnemySpeed ; 89/EEFE

        .al
        .xl
        .autsiz
        .databank ?

        lda aOptionsMenuValues.wEnemySpeed
        cmp #$0002
        bmi _EF09

        _EF07
        bra _EF07


        _EF09
        asl a
        tax
        jsr (aOptionsMenuEnemySpeedHighlights,x)
        rts

        .databank 0

        ; 89/EF0F

    .endsection Unsorted89EEFESection


    .section Table89EF0FSection

      .al
      .xl

      aOptionsMenuEnemySpeedHighlights ; 89/EF0F

        ; Jump table of rsOptionsMenuHighlightEnemySpeed.
        .word <>rsOptionsMenuHighlightEnemySpeedText
        .word <>rsOptionsMenuHighlightEnemySpeedText._EF22

    .endsection Table89EF0FSection


    .section Unsorted89EF13Section

      .al
      .xl

      rsOptionsMenuHighlightEnemySpeedText ; 89/EF13

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aOptionsMenuRealText)<<8
        sta lR18+1
        lda #<>aOptionsMenuRealText
        sta lR18
        ldx #$1415
        bra _EF2F


        _EF22
        lda #(`aOptionsMenuFastText)<<8
        sta lR18+1
        lda #<>aOptionsMenuFastText
        sta lR18
        ldx #$141B

        _EF2F
        lda wOptionsMenuShowEnemyAI
        bne _EF3B
        txa
        sec
        sbc #$0200
        tax

        _EF3B
        jsl rlDrawMenuTextLine
        rts

        .databank 0

        ; 89/EF40

    .endsection Unsorted89EF13Section


    .section Table89EF40Section

      .al
      .xl

      aOptionsMenuRealText ; 89/EF40

        .enc "SJIS"
        .text "リアル"
        .word $0000
        .enc "none"

      aOptionsMenuFastText ; 89/EF48

        .enc "SJIS"
        .text "はやい"
        .word $0000
        .enc "none"


    .endsection Table89EF40Section


    .section Unsorted89EF50Section

      .al
      .xl

      rsOptionsMenuHighlightSound ; 89/EF50

        .al
        .xl
        .autsiz
        .databank ?

        lda aOptionsMenuValues.wSound
        cmp #$0003
        bmi _EF5B

        _EF59
        bra _EF59


        _EF5B
        asl a
        tax
        jsr (aOptionsMenuSoundHighlights,x)
        rts

        .databank 0

        ; 89/EF61

    .endsection Unsorted89EF50Section


    .section Table89EF61Section

      .al
      .xl

      aOptionsMenuSoundHighlights ; 89/EF61

        ; Jump table of rsOptionsMenuHighlightSound.
        .word <>rsOptionsMenuHighlightSoundText
        .word <>rsOptionsMenuHighlightSoundText._EF76
        .word <>rsOptionsMenuHighlightSoundText._EF85

    .endsection Table89EF61Section


    .section Unsorted89EF67Section

      .al
      .xl

      rsOptionsMenuHighlightSoundText ; 89/EF67

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aOptionsMenuText1)<<8
        sta lR18+1
        lda #<>aOptionsMenuText1
        sta lR18
        ldx #$1416
        bra _EF92


        _EF76
        lda #(`aOptionsMenuText2)<<8
        sta lR18+1
        lda #<>aOptionsMenuText2
        sta lR18
        ldx #$1419
        bra _EF92


        _EF85
        lda #(`aOptionsMenuText3)<<8
        sta lR18+1
        lda #<>aOptionsMenuText3
        sta lR18
        ldx #$141C

        _EF92
        lda wOptionsMenuShowEnemyAI
        bne _EF9E
        txa
        sec
        sbc #$0200
        tax

        _EF9E
        jsl rlDrawMenuTextLine
        rts

        .databank 0

        ; 89/EFA3

    .endsection Unsorted89EF67Section


    .section Unsorted89EFA3Section

      .al
      .xl

      rsOptionsMenuHighlightAutoSave ; 89/EFA3

        .al
        .xl
        .autsiz
        .databank ?

        lda aOptionsMenuValues.wAutoSave
        cmp #$0005
        bmi _EFAE

        _EFAC
        bra _EFAC


        _EFAE
        asl a
        tax
        jsr (aOptionsMenuAutoSaveHighlights,x)
        rts

        .databank 0

        ; 89/EFB4

    .endsection Unsorted89EFA3Section


    .section Table89EFB4Section

      .al
      .xl

      aOptionsMenuAutoSaveHighlights ; 89/EFB4

        ; Jump table of rsOptionsMenuHighlightAutoSave.
        .word <>rsOptionsMenuHighlightAutoSaveText
        .word <>rsOptionsMenuHighlightAutoSaveText._EFCD
        .word <>rsOptionsMenuHighlightAutoSaveText._EFDC
        .word <>rsOptionsMenuHighlightAutoSaveText._EFEB
        .word <>rsOptionsMenuHighlightAutoSaveText._EFFA

    .endsection Table89EFB4Section


    .section Unsorted89EFBESection

      .al
      .xl

      rsOptionsMenuHighlightAutoSaveText ; 89/EFBE

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aOptionsMenuText0)<<8
        sta lR18+1
        lda #<>aOptionsMenuText0
        sta lR18
        ldx #$1415
        bra _F007


        _EFCD
        lda #(`aOptionsMenuText1)<<8
        sta lR18+1
        lda #<>aOptionsMenuText1
        sta lR18
        ldx #$1417
        bra _F007


        _EFDC
        lda #(`aOptionsMenuText2)<<8
        sta lR18+1
        lda #<>aOptionsMenuText2
        sta lR18
        ldx #$1419
        bra _F007


        _EFEB
        lda #(`aOptionsMenuText3)<<8
        sta lR18+1
        lda #<>aOptionsMenuText3
        sta lR18
        ldx #$141B
        bra _F007


        _EFFA
        lda #(`aOptionsMenuText4)<<8
        sta lR18+1
        lda #<>aOptionsMenuText4
        sta lR18
        ldx #$141D

        _F007
        lda wOptionsMenuShowEnemyAI
        bne _F013
        txa
        sec
        sbc #$0200
        tax

        _F013
        jsl rlDrawMenuTextLine
        rts

        .databank 0

        ; 89/F018

    .endsection Unsorted89EFBESection


    .section Unsorted89F018Section

      .al
      .xl

      rsOptionsMenuHighlightEnemyAI ; 89/F018

        .al
        .xl
        .autsiz
        .databank ?

        lda aOptionsMenuValues.wEnemyAI
        cmp #$0002
        bmi _F023

        _F021
        bra _F021


        _F023
        asl a
        tax
        jsr (aOptionsMenuEnemyAIHighlights,x)
        rts

        .databank 0

        ; 89/F029

    .endsection Unsorted89F018Section


    .section Table89F029Section

      .al
      .xl

      aOptionsMenuEnemyAIHighlights ; 89/F029

        ; Jump table of rsOptionsMenuHighlightEnemyAI.
        .word <>rsOptionsMenuHighlightNormalAI
        .word <>rsOptionsMenuHighlightCleverAI

    .endsection Table89F029Section


    .section Unsorted89F02DSection

      .al
      .xl

      rsOptionsMenuHighlightNormalAI ; 89/F02D

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aOptionsMenuNormalText)<<8
        sta lR18+1
        lda #<>aOptionsMenuNormalText
        sta lR18
        ldx #$1415
        jsl rlDrawMenuTextLine
        rts

        .databank 0

        ; 89/F03F

      rsOptionsMenuHighlightCleverAI ; 89/F03F

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aOptionsMenuCleverText)<<8
        sta lR18+1
        lda #<>aOptionsMenuCleverText
        sta lR18
        ldx #$141A
        jsl rlDrawMenuTextLine
        rts

        .databank 0

        ; 89/F051

    .endsection Unsorted89F02DSection


    .section Table89F051Section

      .al
      .xl

      aOptionsMenuCleverText ; 89/F051

        .enc "SJIS"
        .text "かしこい"
        .word $0000
        .enc "none"

      aOptionsMenuNormalText ; 89/F05B

        .enc "SJIS"
        .text "ふつう　"
        .word $0000
        .enc "none"


    .endsection Table89F051Section


    .section Unsorted89F065Section

      .al
      .xl

      rlOptionsMenuDrawValues ; 89/F065

        .al
        .xl
        .autsiz
        .databank ?

        ; The value of each option beside its label; the enemy AI line only when it is shown (wOptionsMenuShowEnemyAI).

        lda #$3800
        sta aCurrentTilemapInfo,b
        lda aOptionsMenuValues.wAnimation
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda aOptionsMenuAnimationValues+1,x
        sta lR18+1
        lda aOptionsMenuAnimationValues,x
        sta lR18
        ldx #$040E
        jsl rlDrawMenuTextLine
        lda aOptionsMenuValues.wTerrainWindow
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda aOptionsMenuOnOffValues+1,x
        sta lR18+1
        lda aOptionsMenuOnOffValues,x
        sta lR18
        ldx #$060E
        jsl rlDrawMenuTextLine
        lda aOptionsMenuValues.wUnitWindow
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda aOptionsMenuOnOffValues+1,x
        sta lR18+1
        lda aOptionsMenuOnOffValues,x
        sta lR18
        ldx #$080E
        jsl rlDrawMenuTextLine
        lda aOptionsMenuValues.wMessageSpeed
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda aOptionsMenuMessageSpeedValues+1,x
        sta lR18+1
        lda aOptionsMenuMessageSpeedValues,x
        sta lR18
        ldx #$0A0E
        jsl rlDrawMenuTextLine
        lda aOptionsMenuValues.wEnemySpeed
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda aOptionsMenuEnemySpeedValues+1,x
        sta lR18+1
        lda aOptionsMenuEnemySpeedValues,x
        sta lR18
        ldx #$0C0E
        jsl rlDrawMenuTextLine
        lda aOptionsMenuValues.wSound
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda aOptionsMenuSoundValues+1,x
        sta lR18+1
        lda aOptionsMenuSoundValues,x
        sta lR18
        ldx #$0E0E
        jsl rlDrawMenuTextLine
        lda aOptionsMenuValues.wAutoSave
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda aOptionsMenuAutoSaveValues+1,x
        sta lR18+1
        lda aOptionsMenuAutoSaveValues,x
        sta lR18
        ldx #$100E
        jsl rlDrawMenuTextLine
        lda aOptionsMenuValues.wAutoCursor
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda aOptionsMenuAutoCursorValues+1,x
        sta lR18+1
        lda aOptionsMenuAutoCursorValues,x
        sta lR18
        ldx #$120E
        jsl rlDrawMenuTextLine
        lda wOptionsMenuShowEnemyAI
        beq _F17F
        lda aOptionsMenuValues.wEnemyAI
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda aOptionsMenuEnemyAIValues+1,x
        sta lR18+1
        lda aOptionsMenuEnemyAIValues,x
        sta lR18
        ldx #$140E
        jsl rlDrawMenuTextLine

        _F17F
        rtl

        .databank 0

        ; 89/F180

    .endsection Unsorted89F065Section


    .section Data89F180Section

      .al
      .xl

      aOptionsMenuOnOffValues ; 89/F180

        ; Long pointers to the text of each value, one table per option, read by
        ; rlOptionsMenuDrawValues.

        .long aOptionsMenuOnText
        .long aOptionsMenuOffText

      aOptionsMenuMessageSpeedValues ; 89/F186

        .long aOptionsMenuText1
        .long aOptionsMenuText2
        .long aOptionsMenuText3
        .long aOptionsMenuText4
        .long aOptionsMenuText5

      aOptionsMenuEnemySpeedValues ; 89/F195

        .long aOptionsMenuRealValueText
        .long aOptionsMenuFastValueText

      aOptionsMenuSoundValues ; 89/F19B

        .long aOptionsMenuStereoText
        .long aOptionsMenuMonoText
        .long aOptionsMenuOffText

      aOptionsMenuAutoSaveValues ; 89/F1A4

        .long aOptionsMenuOffText
        .long aOptionsMenuSaveFile1Text
        .long aOptionsMenuSaveFile2Text
        .long aOptionsMenuSaveFile3Text
        .long aOptionsMenuSaveFile4Text

      aOptionsMenuAnimationValues ; 89/F1B3

        .long aOptionsMenuAnimationRealText
        .long aOptionsMenuAnimationMapText
        .long aOptionsMenuAnimationEachText

      aOptionsMenuEnemyAIValues ; 89/F1BC

        .long aOptionsMenuNormalValueText
        .long aOptionsMenuCleverValueText

      aOptionsMenuAutoCursorValues ; 89/F1C2

        .long aOptionsMenuOnText
        .long aOptionsMenuOffText

      aOptionsMenuFastValueText ; 89/F1C8

        .enc "SJIS"
        .text "はやい"
        .word $0000
        .enc "none"

      aOptionsMenuRealValueText ; 89/F1D0

        .enc "SJIS"
        .text "リアル"
        .word $0000
        .enc "none"

      aOptionsMenuStereoText ; 89/F1D8

        .enc "SJIS"
        .text "ステレオ"
        .word $0000
        .enc "none"

      aOptionsMenuMonoText ; 89/F1E2

        .enc "SJIS"
        .text "モノラル"
        .word $0000
        .enc "none"

      aOptionsMenuAnimationRealText ; 89/F1EC

        .enc "SJIS"
        .text "リアル　"
        .word $0000
        .enc "none"

      aOptionsMenuAnimationMapText ; 89/F1F6

        .enc "SJIS"
        .text "マップ　"
        .word $0000
        .enc "none"

      aOptionsMenuAnimationEachText ; 89/F200

        .enc "SJIS"
        .text "こ部つ　"
        .word $0000
        .enc "none"

      aOptionsMenuSaveFile1Text ; 89/F20A

        .enc "SJIS"
        .text "セーブ１"
        .word $0000
        .enc "none"

      aOptionsMenuSaveFile2Text ; 89/F214

        .enc "SJIS"
        .text "セーブ２"
        .word $0000
        .enc "none"

      aOptionsMenuSaveFile3Text ; 89/F21E

        .enc "SJIS"
        .text "セーブ３"
        .word $0000
        .enc "none"

      aOptionsMenuSaveFile4Text ; 89/F228

        .enc "SJIS"
        .text "セーブ４"
        .word $0000
        .enc "none"

      aOptionsMenuCleverValueText ; 89/F232

        .enc "SJIS"
        .text "かしこい"
        .word $0000
        .enc "none"

      aOptionsMenuNormalValueText ; 89/F23C

        .enc "SJIS"
        .text "ふつう　"
        .word $0000
        .enc "none"

        ; 89/F246

    .endsection Data89F180Section
    .section Unsorted89F246Section

      .al
      .xl

      rlOptionsMenuDrawDescription ; 89/F246

        .al
        .xl
        .autsiz
        .databank ?

        ; The description of the option under the cursor in the box at the top, drawn into aOptionsMenuDescriptionBuffer and copied into five rows of the BG3 tilemap buffer, and the caption over its choices.

        lda #(`aOptionsMenuDescriptionTilemapEntry)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aOptionsMenuDescriptionTilemapEntry
        sta lMapMenuTilemapRAMEntryPointer,b
        jsr rsOptionsMenuClearDescription
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda wOptionsMenuCursor
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda aOptionsMenuDescriptionPointers+1,x
        sta lR18+1
        lda aOptionsMenuDescriptionPointers,x
        sta lR18
        ldx #$0000
        jsl rlDrawMenuTextLine
        ldx #$0000

        _F27C
        lda aOptionsMenuDescriptionBuffer,x
        sta aBG3TilemapBuffer+$12C,x
        lda aOptionsMenuDescriptionBuffer+$78,x
        sta aBG3TilemapBuffer+$16C,x
        inc x
        inc x
        cpx #$0012
        bne _F27C
        ldx #$0000

        _F296
        lda aOptionsMenuDescriptionBuffer+$12,x
        sta aBG3TilemapBuffer+$1AA,x
        lda aOptionsMenuDescriptionBuffer+$8A,x
        sta aBG3TilemapBuffer+$1EA,x
        inc x
        inc x
        cpx #$0012
        bne _F296
        ldx #$0000

        _F2B0
        lda aOptionsMenuDescriptionBuffer+$24,x
        sta aBG3TilemapBuffer+$22A,x
        lda aOptionsMenuDescriptionBuffer+$9C,x
        sta aBG3TilemapBuffer+$26A,x
        inc x
        inc x
        cpx #$0012
        bne _F2B0
        ldx #$0000

        _F2CA
        lda aOptionsMenuDescriptionBuffer+$36,x
        sta aBG3TilemapBuffer+$2AA,x
        lda aOptionsMenuDescriptionBuffer+$AE,x
        sta aBG3TilemapBuffer+$2EA,x
        inc x
        inc x
        cpx #$0012
        bne _F2CA
        ldx #$0000

        _F2E4
        lda aOptionsMenuDescriptionBuffer+$48,x
        sta aBG3TilemapBuffer+$32A,x
        lda aOptionsMenuDescriptionBuffer+$C0,x
        sta aBG3TilemapBuffer+$36A,x
        inc x
        inc x
        cpx #$0012
        bne _F2E4
        lda #(`aOptionsMenuTilemapEntry)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aOptionsMenuTilemapEntry
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda wOptionsMenuCursor
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda aOptionsMenuChoiceCaptions+1,x
        sta lR18+1
        lda aOptionsMenuChoiceCaptions,x
        sta lR18
        ldx #$1215
        lda wOptionsMenuShowEnemyAI
        bne _F333
        txa
        sec
        sbc #$0200
        tax

        _F333
        jsl rlDrawMenuTextLine
        rtl

        .databank 0

        ; 89/F338

    .endsection Unsorted89F246Section


    .section Table89F338Section

      .al
      .xl

      aOptionsMenuDescriptionPointers ; 89/F338

        ; Read by rlOptionsMenuDrawDescription.

        .long aOptionsMenuAnimationDescription
        .long aOptionsMenuTerrainWindowDescription
        .long aOptionsMenuUnitWindowDescription
        .long aOptionsMenuMessageSpeedDescription
        .long aOptionsMenuEnemySpeedDescription
        .long aOptionsMenuSoundDescription
        .long aOptionsMenuAutoSaveDescription
        .long aOptionsMenuAutoCursorDescription
        .long aOptionsMenuEnemyAIDescription

      aOptionsMenuAnimationDescription ; 89/F353
        .enc "SJIS"
          .text "アニメせってい　　　１ーリアル　　　　２ーマップ　　　　３ーこ部つ\n"

      aOptionsMenuTerrainWindowDescription ; 89/F397
        .enc "SJIS"
          .text "ちけいウィンドウ　ちけいウィンドウのひょうじ\n"

      aOptionsMenuUnitWindowDescription ; 89/F3C5
        .enc "SJIS"
          .text "ユニットウィンドウユニットウィンドウのひょうじ\n"

      aOptionsMenuMessageSpeedDescription ; 89/F3F5
        .enc "SJIS"
          .text "メッセージスピードメッセージを　　　ひょうじするはやさ\n"

      aOptionsMenuEnemySpeedDescription ; 89/F42D
        .enc "SJIS"
          .text "てきいどうスピードてきのいどうする　スピード\n"

      aOptionsMenuSoundDescription ; 89/F45B
        .enc "SJIS"
          .text "サウンドせってい　ＢＧＭのせってい　　１ーステレオ　　　２ーモノラル　　　３ーオフ\n"

      aOptionsMenuAutoSaveDescription ; 89/F4AF
        .enc "SJIS"
          .text "オートセーブ　　　ターンのはじめに　えらんだファイルへじどうてきにセーブする\n"

      aOptionsMenuEnemyAIDescription ; 89/F4FD
        .enc "SJIS"
          .text "てきのあたまのよさてきユニットの　　あたまのよさ\n"

      aOptionsMenuAutoCursorDescription ; 89/F52F
        .enc "SJIS"
          .text "オートカーソル　　ターンのはじめに　しゅじんこうに　　カーソルをあわせる\n"

        ; 89/F579

    .endsection Table89F338Section


    .section Data89F579Section

      .al
      .xl

      aOptionsMenuChoiceCaptions ; 89/F579

        ; A long pointer per option to the caption over its choices.

        .long aOptionsMenuCaptionAnimation
        .long aOptionsMenuCaptionOnOff
        .long aOptionsMenuCaptionOnOff
        .long aOptionsMenuCaptionMessageSpeed
        .long aOptionsMenuCaptionEnemySpeed
        .long aOptionsMenuCaptionSound
        .long aOptionsMenuCaptionAutoSave
        .long aOptionsMenuCaptionOnOff
        .long aOptionsMenuCaptionEnemyAI

      aOptionsMenuCaptionEnemySpeed ; 89/F594

        .enc "SJIS"
        .text "　いどうスピード　"
        .word $0000
        .enc "none"

      aOptionsMenuCaptionOnOff ; 89/F5A8

        .enc "SJIS"
        .text "する　　　　しない"
        .word $0000
        .enc "none"

      aOptionsMenuCaptionAnimation ; 89/F5BC

        .enc "SJIS"
        .text "リアル　　　こ部つ"
        .word $0000
        .enc "none"

      aOptionsMenuCaptionMessageSpeed ; 89/F5D0

        .enc "SJIS"
        .text "おそい　　　はやい"
        .word $0000
        .enc "none"

      aOptionsMenuCaptionSound ; 89/F5E4

        .enc "SJIS"
        .text "ステレオ　　　オフ"
        .word $0000
        .enc "none"

      aOptionsMenuCaptionAutoSave ; 89/F5F8

        .enc "SJIS"
        .text "オフ　　ファイル　"
        .word $0000
        .enc "none"

      aOptionsMenuCaptionEnemyAI ; 89/F60C

        .enc "SJIS"
        .text "　あたまのよさ　　"
        .word $0000
        .enc "none"

        ; 89/F620

    .endsection Data89F579Section
    .section Unsorted89F620Section

      .al
      .xl

      rsOptionsMenuClearDescription ; 89/F620

        .al
        .xl
        .autsiz
        .databank ?

        ; Clears aOptionsMenuDescriptionBuffer.

        lda #$0000
        tax

        _F624
        sta aOptionsMenuDescriptionBuffer,x
        inc x
        inc x
        cpx #$011A
        bne _F624
        rts

        .databank 0

        ; 89/F630

    .endsection Unsorted89F620Section


    .section Unsorted89F630Section

      .al
      .xl

      rlOptionsMenuDrawCursor ; 89/F630

        .al
        .xl
        .autsiz
        .databank ?

        ; The hand cursor at the option's row, 10 pixels up or down during a move.

        lda wOptionsMenuCursor
        tax
        lda wOptionsMenuShowEnemyAI
        beq _F641
        lda aOptionsMenuCursorYWithAI,x
        bra _F645


        _F641
        lda aOptionsMenuCursorY,x

        _F645
        and #$00FF
        sta wR1
        lda wOptionsMenuCursorMove
        bmi _F65C
        beq _F664
        lda wR1
        clc
        adc #$000A
        sta wR1
        bra _F664


        _F65C
        lda wR1
        sec
        sbc #$000A
        sta wR1

        _F664
        stz wR0
        lda #$0000
        jsl rlUnknown88A704
        rtl

        .databank 0

        ; 89/F66E

    .endsection Unsorted89F630Section


    .section Data89F66ESection

      .al
      .xl

      aOptionsMenuCursorYWithAI ; 89/F66E

        ; Read by rlOptionsMenuDrawCursor.

        .byte $23, $38, $4D, $62, $76, $8B, $A1, $B5, $CA

        ; 89/F677

      aOptionsMenuCursorY ; 89/F677

        ; Read by rlOptionsMenuDrawCursor.

        .word $3B24, $6952, $9780, $C5AE

        ; 89/F67F

    .endsection Data89F66ESection


    .section Unsorted89F67FSection

      .al
      .xl

      rlOptionsMenuDrawValueMarker ; 89/F67F

        .al
        .xl
        .autsiz
        .databank ?

        ; A marker under the chosen value in the choices line, at its X from aOptionsMenuValueMarkerX (also kept in wOptionsMenuValueMarkerX).

        phk
        plb
        .databank $89
        lda wOptionsMenuCursor
        asl a
        tax
        asl a
        asl a
        sta wR0
        lda aOptionsMenuValues,x
        clc
        adc wR0
        tax
        lda @l aOptionsMenuValueMarkerX,x
        and #$00FF
        sta wR0
        sta wOptionsMenuValueMarkerX
        lda #$00BD
        sta wR1
        lda wOptionsMenuShowEnemyAI
        bne _F6B0
        lda #$00B8
        sta wR1

        _F6B0
        stz wR4
        stz wR5
        ldy #<>aOptionsMenuValueMarker
        jsl rlPushToOAMBuffer
        rtl

        .databank 0

        ; 89/F6BC

    .endsection Unsorted89F67FSection


    .section Data89F6BCSection

      .al
      .xl

      aOptionsMenuValueMarkerX ; 89/F6BC

        ; Eight bytes per option: the X of the marker under each of its values.

        .byte $AC, $C4, $DC, $00, $00, $00, $00, $00
        .byte $A8, $DC, $00, $00, $00, $00, $00, $00
        .byte $A8, $DC, $00, $00, $00, $00, $00, $00
        .byte $A4, $B4, $C4, $D4, $E4, $00, $00, $00
        .byte $AC, $DC, $00, $00, $00, $00, $00, $00
        .byte $AC, $C4, $DC, $00, $00, $00, $00, $00
        .byte $A4, $B4, $C4, $D4, $E4, $00, $00, $00
        .byte $A8, $DC, $00, $00, $00, $00, $00, $00
        .byte $AC, $D8, $00, $00, $00, $00, $00, $00

      aUnknown89F704 ; 89/F704

        ; Nothing reads these eight bytes.

        .byte $B1, $B2, $B1, $B0, $C7, $C6, $C7, $C8

      aOptionsMenuValueMarker ; 89/F70C

        _Sprites := [[(   0,    0), $21, SpriteLarge, $00C, 3, 1, false, false]]

        .structSpriteArray aOptionsMenuValueMarker._Sprites

        ; 89/F713

    .endsection Data89F6BCSection
    .section Unsorted89F713Section

      .al
      .xl

      rlOptionsMenuDrawIcons ; 89/F713

        .al
        .xl
        .autsiz
        .databank ?

        ; The column of option icons beside the labels; the enemy AI icon only when that option is shown.

        phk
        plb
        .databank $89
        stz wR0
        lda #$0062
        sta wR1
        stz wR4
        stz wR5
        lda wOptionsMenuShowEnemyAI
        beq _F72B
        ldy #<>aOptionsMenuIconsWithAI
        bra _F72E


        _F72B
        ldy #<>aOptionsMenuIcons

        _F72E
        jsl rlPushToOAMBuffer
        lda wOptionsMenuShowEnemyAI
        beq _F74A
        stz wR0
        lda #$0052
        sta wR1
        stz wR4
        stz wR5
        ldy #<>aOptionsMenuEnemyAIIcon
        jsl rlPushToOAMBuffer

        _F74A
        rtl

        .databank 0

        ; 89/F74B


      aOptionsMenuIconsWithAI ; 89/F74B

        _Sprites := [[(  14,  -65), $21, SpriteLarge, $020, 3, 2, false, false]]
        _Sprites ..= [[(  14,  -44), $21, SpriteLarge, $022, 3, 2, false, false]]
        _Sprites ..= [[(  14,  -23), $21, SpriteLarge, $024, 3, 2, false, false]]
        _Sprites ..= [[(  14,   -2), $21, SpriteLarge, $026, 3, 2, false, false]]
        _Sprites ..= [[(  14,   18), $21, SpriteLarge, $02C, 3, 2, false, false]]
        _Sprites ..= [[(  14,   39), $21, SpriteLarge, $02A, 3, 2, false, false]]
        _Sprites ..= [[(  14,   61), $21, SpriteLarge, $02E, 3, 2, false, false]]
        _Sprites ..= [[(  14,   81), $21, SpriteLarge, $042, 3, 2, false, false]]

        .structSpriteArray aOptionsMenuIconsWithAI._Sprites

      aOptionsMenuIcons ; 89/F775

        _Sprites := [[(  14,  -63), $21, SpriteLarge, $020, 3, 2, false, false]]
        _Sprites ..= [[(  14,  -40), $21, SpriteLarge, $022, 3, 2, false, false]]
        _Sprites ..= [[(  14,  -16), $21, SpriteLarge, $024, 3, 2, false, false]]
        _Sprites ..= [[(  14,    7), $21, SpriteLarge, $026, 3, 2, false, false]]
        _Sprites ..= [[(  14,   29), $21, SpriteLarge, $02C, 3, 2, false, false]]
        _Sprites ..= [[(  14,   52), $21, SpriteLarge, $02A, 3, 2, false, false]]
        _Sprites ..= [[(  14,   75), $21, SpriteLarge, $02E, 3, 2, false, false]]
        _Sprites ..= [[(  14,   98), $21, SpriteLarge, $042, 3, 2, false, false]]

        .structSpriteArray aOptionsMenuIcons._Sprites

      aOptionsMenuEnemyAIIcon ; 89/F79F

        _Sprites := [[(  14,  118), $21, SpriteLarge, $040, 3, 2, false, false]]

        .structSpriteArray aOptionsMenuEnemyAIIcon._Sprites

    .endsection Unsorted89F713Section


    .section Unsorted89F7A6Section

      .al
      .xl

      rlOptionsMenuDrawSelectedIcon ; 89/F7A6

        .al
        .xl
        .autsiz
        .databank ?

        ; The icon of the option under the cursor, in the description box.

        phk
        plb
        .databank $89
        lda wOptionsMenuCursor
        asl a
        tax
        lda @l aOptionsMenuIconTiles,x
        sta wR4
        stz wR0
        stz wR1
        stz wR5
        lda wOptionsMenuShowEnemyAI
        bne _F7C5
        lda #$0002
        sta wR1

        _F7C5
        ldy #<>aOptionsMenuSelectedIcon
        jsl rlPushToOAMBuffer
        rtl

        .databank 0

        ; 89/F7CD

    .endsection Unsorted89F7A6Section


    .section Data89F7CDSection

      .al
      .xl

      aOptionsMenuIconTiles ; 89/F7CD

        ; A word per option: the tile of its icon.

        .word $0020, $0022, $0024, $0026, $002C, $002A, $002E, $0042
        .word $0040

      aOptionsMenuSelectedIcon ; 89/F7DF

        _Sprites := [[( 159,   33), $21, SpriteLarge, $000, 3, 2, false, false]]

        .structSpriteArray aOptionsMenuSelectedIcon._Sprites

        ; 89/F7E6

    .endsection Data89F7CDSection
    .section Unsorted89F7E6Section

      .al
      .xl

      rlOptionsMenuApplyValues ; 89/F7E6

        .al
        .xl
        .autsiz
        .databank ?

        ; Writes the values into the settings, as the menu leaves.

        lda aOptionsMenuValues.wAnimation
        jsl rlSetBattleAnimationOption
        lda aOptionsMenuValues.wTerrainWindow
        jsl rlSetTerrainWindowSetting
        lda aOptionsMenuValues.wUnitWindow
        jsl rlUnknown87BED7
        lda aOptionsMenuValues.wMessageSpeed
        jsl rlUnknown87BF01
        lda aOptionsMenuValues.wEnemySpeed
        jsl rlUnknown87BF29
        lda aOptionsMenuValues.wSound
        jsl rlUnknown87BF52
        lda aOptionsMenuValues.wAutoSave
        cmp #$0000
        beq _F822
        lda #$0001

        _F822
        jsl rlUnknown87BFBF
        lda aOptionsMenuValues.wAutoSave
        beq _F831
        dec a
        jsl rlUnknown87BFE9

        _F831
        lda aOptionsMenuValues.wAutoCursor
        jsl rlUnknown87C03C
        lda aOptionsMenuValues.wEnemyAI
        jsl rlUnknown87C015
        rtl

        .databank 0

        ; 89/F842

    .endsection Unsorted89F7E6Section


    .section Unsorted89F842Section

      .al
      .xl

      rlOptionsMenuRestoreValues ; 89/F842

        .al
        .xl
        .autsiz
        .databank ?

        ; Copies the values the menu opened with back over the current ones.

        lda aOptionsMenuOpeningValues.wAnimation
        sta aOptionsMenuValues.wAnimation
        lda aOptionsMenuOpeningValues.wTerrainWindow
        sta aOptionsMenuValues.wTerrainWindow
        lda aOptionsMenuOpeningValues.wUnitWindow
        sta aOptionsMenuValues.wUnitWindow
        lda aOptionsMenuOpeningValues.wMessageSpeed
        sta aOptionsMenuValues.wMessageSpeed
        lda aOptionsMenuOpeningValues.wEnemySpeed
        sta aOptionsMenuValues.wEnemySpeed
        lda aOptionsMenuOpeningValues.wSound
        sta aOptionsMenuValues.wSound
        lda aOptionsMenuOpeningValues.wAutoSave
        sta aOptionsMenuValues.wAutoSave
        lda aOptionsMenuOpeningValues.wAutoCursor
        sta aOptionsMenuValues.wAutoCursor
        lda aOptionsMenuOpeningValues.wEnemyAI
        sta aOptionsMenuValues.wEnemyAI
        rtl

        .databank 0

        ; 89/F88B

    .endsection Unsorted89F842Section


    .section Table89F88BSection

      .al
      .xl

      aOptionsMenuText0 ; 89/F88B

        .enc "SJIS"
        .text "０"
        .word $0000
        .enc "none"

      aOptionsMenuText1 ; 89/F88F

        .enc "SJIS"
        .text "１"
        .word $0000
        .enc "none"

      aOptionsMenuText2 ; 89/F893

        .enc "SJIS"
        .text "２"
        .word $0000
        .enc "none"

      aOptionsMenuText3 ; 89/F897

        .enc "SJIS"
        .text "３"
        .word $0000
        .enc "none"

      aOptionsMenuText4 ; 89/F89B

        .enc "SJIS"
        .text "４"
        .word $0000
        .enc "none"

      aOptionsMenuText5 ; 89/F89F

        .enc "SJIS"
        .text "５"
        .word $0000
        .enc "none"

      aOptionsMenuOnText ; 89/F8A3

        .enc "SJIS"
        .text "ＯＮ　　"
        .word $0000
        .enc "none"

      aOptionsMenuOffText ; 89/F8AD

        .enc "SJIS"
        .text "ＯＦＦ　"
        .word $0000
        .enc "none"


    .endsection Table89F88BSection


