; The epilogue's screens. From bank $80: rsOpenEpilogueScreen, which starts the
; part in wEpiloguePart, the VBlank handler, and the setup of each part (the
; credits, the play record, the character endings). From bank $8D: the credits'
; scrolling (rlScrollEpilogueCredits), its sprites and HDMA effects, the text
; window the credits and the play record print into, the end screen
; (rlShowEpilogueEndScreen), and the credits' dialogue and sprite data.


    .section Unsorted80EB37Section

      .al
      .xl

      rsRunEpilogueVBlank ; 80/EB37

        .al
        .xl
        .autsiz
        .databank ?

        ; Epilogue/credits VBlank running OAM/DMA/HDMA/PPU/APU/joypad/counters/sprites/states/OAM scan/sound

        sep #$20
        lda #$80
        sta $2100,b
        rep #$20
        jsl rlProcessDMAStructArray
        jsl rlDMAPaletteAndOAMBuffer
        jsl rlHandlePossibleHDMA
        jsl rlCopyPPURegisterBuffer
        jsl rlSendSoundQueuesToAPU
        jsl rlGetJoypadInput
        jsl rlIncreaseFrameCounters
        jsl rlClearSpriteExtBuffer
        jsl rlRunGameStateRoutines
        jsl rlRunVBlankHooks
        jsl rlHideSprites
        jsl rlRunDialogueCycle
        jsl rlMapMenuVBlankUpload
        jsl rlUpdateSound
        rts

        .databank 0

        ; 80/EB79


      rlCheckOAMOverflowAndScanSpriteLines ; 80/EB79

        .al
        .xl
        .autsiz
        .databank ?

        ; Checks STAT77 ($213E & #$C0) and falls through to rlScanSpriteLineOverflow if overflow set

        sep #$20
        lda $213E,b
        and #$C0
        bne rlScanSpriteLineOverflow
        rep #$20
        rtl

        .databank 0

        ; 80/EB85


      rlScanSpriteLineOverflow ; 80/EB85

        .al
        .xl
        .autsiz
        .databank ?

        ; Scans aSpriteBuffer Y-coords across $10..$C0 bands in $08DE..$08E9; logs offending index to $08F0

        sep #$20
        lda #$20
        sta aOAMYBandCounters.bBand0,b
        sta aOAMYBandCounters.bBand1,b
        sta aOAMYBandCounters.bBand2,b
        sta aOAMYBandCounters.bBand3,b
        sta aOAMYBandCounters.bBand4,b
        sta aOAMYBandCounters.bBand5,b
        sta aOAMYBandCounters.bBand6,b
        sta aOAMYBandCounters.bBand7,b
        sta aOAMYBandCounters.bBand8,b
        sta aOAMYBandCounters.bBand9,b
        sta aOAMYBandCounters.bBand10,b
        sta aOAMYBandCounters.bBand11,b
        ldx #$0000

        _EBB0
        lda $1C01,b,x
        cmp #$10
        beq _EBE5
        cmp #$20
        beq _EBEC
        cmp #$30
        beq _EBF3
        cmp #$40
        beq _EBFA
        cmp #$50
        beq _EC01
        cmp #$60
        beq _EC08
        cmp #$70
        beq _EC0F
        cmp #$80
        beq _EC16
        cmp #$90
        beq _EC1D
        cmp #$A0
        beq _EC24
        cmp #$B0
        beq _EC2B
        cmp #$C0
        beq _EC32
        bra _EC39


        _EBE5
        jsr _EC51
        bne _EC39
        bra _EC46


        _EBEC
        jsr _EC5B
        bne _EC39
        bra _EC46


        _EBF3
        jsr _EC65
        bne _EC39
        bra _EC46


        _EBFA
        jsr _EC6F
        bne _EC39
        bra _EC46


        _EC01
        jsr _EC79
        bne _EC39
        bra _EC46


        _EC08
        jsr _EC83
        bne _EC39
        bra _EC46


        _EC0F
        jsr _EC8D
        bne _EC39
        bra _EC46


        _EC16
        jsr _EC97
        bne _EC39
        bra _EC46


        _EC1D
        jsr _ECA1
        bne _EC39
        bra _EC46


        _EC24
        jsr _ECAB
        bne _EC39
        bra _EC46


        _EC2B
        jsr _ECB5
        bne _EC39
        bra _EC46


        _EC32
        jsr _ECBF
        bne _EC39
        bra _EC46


        _EC39
        inc x
        inc x
        inc x
        inc x
        cpx #$0200
        beq _EC46
        jml _EBB0


        _EC46
        txa
        lsr a
        lsr a
        dec x
        dec x
        sta bOAMRenderedSpriteCount,b
        rep #$20
        rtl


        _EC51
        lda $1D00,b,x
        dec aOAMYBandCounters.bBand0,b
        dec aOAMYBandCounters.bBand0,b
        rts


        _EC5B
        lda $1D00,b,x
        dec aOAMYBandCounters.bBand1,b
        dec aOAMYBandCounters.bBand1,b
        rts


        _EC65
        lda $1D00,b,x
        dec aOAMYBandCounters.bBand2,b
        dec aOAMYBandCounters.bBand2,b
        rts


        _EC6F
        lda $1D00,b,x
        dec aOAMYBandCounters.bBand3,b
        dec aOAMYBandCounters.bBand3,b
        rts


        _EC79
        lda $1D00,b,x
        dec aOAMYBandCounters.bBand4,b
        dec aOAMYBandCounters.bBand4,b
        rts


        _EC83
        lda $1D00,b,x
        dec aOAMYBandCounters.bBand5,b
        dec aOAMYBandCounters.bBand5,b
        rts


        _EC8D
        lda $1D00,b,x
        dec aOAMYBandCounters.bBand6,b
        dec aOAMYBandCounters.bBand6,b
        rts


        _EC97
        lda $1D00,b,x
        dec aOAMYBandCounters.bBand7,b
        dec aOAMYBandCounters.bBand7,b
        rts


        _ECA1
        lda $1D00,b,x
        dec aOAMYBandCounters.bBand8,b
        dec aOAMYBandCounters.bBand8,b
        rts


        _ECAB
        lda $1D00,b,x
        dec aOAMYBandCounters.bBand9,b
        dec aOAMYBandCounters.bBand9,b
        rts


        _ECB5
        lda $1D00,b,x
        dec aOAMYBandCounters.bBand10,b
        dec aOAMYBandCounters.bBand10,b
        rts


        _ECBF
        lda $1D00,b,x
        dec aOAMYBandCounters.bBand11,b
        dec aOAMYBandCounters.bBand11,b
        rts

        .databank 0

        ; 80/ECC9


      rsOpenEpilogueScreen ; 80/ECC9

        .al
        .xl
        .autsiz
        .databank ?

        ; Opens epilogue/credits (game state $36/$35, rsRunEpilogueVBlank) and dispatches wEpiloguePart (0-3)

        php
        sep #$20
        lda #$80
        sta bBufferINIDISP
        sta $2100,b
        rep #$20
        jsl rlDisableVBlank
        jsl rlHardwareResetScreenPosMathHDMA
        jsl rlHardwareResetScreenRegisters
        lda #$3000
        sta wR1
        lda #$0000
        sta wR2
        lda #$4000
        sta wR3
        sta wR4
        lda #$6000
        sta wR5
        lda #$5000
        sta wR6
        lda #$5800
        sta wR7
        lda #$6800
        sta wR8
        jsl rlSetLayerPositionsAndSizes
        jsl rlActiveSpriteEngineReset
        jsl rlResetHDMAEngine
        jsl rlResetIRQEngine
        jsl rlClearUnitWindowAndTerrainWindowProcs
        jsl rlResetRAMStructAndAreaVariables
        jsl rlInitMapMenus
        jsl rlResetMenuOptionStack
        lda #GAMESTATE_EPILOGUE_SETUP
        sta wGameStateRoutine1,b
        lda #GAMESTATE_EPILOGUE_UPKEEP
        sta wGameStateRoutine2,b
        stz wGameStateStep,b
        lda #<>rsRunEpilogueVBlank
        sta wVBlankPointer
        lda #<>rsRunFrameTasks
        sta wMainLoopPointer
        jsl rlPauseMapTileAnimation
        lda wEpiloguePart,b
        beq _ED57
        cmp #EPILOGUE_PART_CREDITS
        beq _ED5D
        cmp #EPILOGUE_PART_RECORDS
        beq _ED63
        cmp #EPILOGUE_PART_CHARACTER_ENDINGS
        beq _ED69

        _ED57
        jsl rlBeginEpilogueEndingsEvaluation
        bra _ED6F


        _ED5D
        jsl rlSetupEpilogueCreditsDisplay
        bra _ED6F


        _ED63
        jsl rlSetupEpilogueRankingsDisplay
        bra _ED6F


        _ED69
        jsl rlStartEpilogueCharacterEndings
        bra _ED7B


        _ED6F
        jsl rlEnableVBlank
        sep #$20
        lda #$00
        sta bBufferINIDISP
        rep #$20

        _ED7B
        plp
        rts

        .databank 0

        ; 80/ED7D


      rlBeginEpilogueEndingsEvaluation ; 80/ED7D

        .al
        .xl
        .autsiz
        .databank ?

        ; wEpiloguePart 0: calls rlEvaluateEpilogueEndings and sets wGameStateStep=$0C

        jsl rlEvaluateEpilogueEndings
        lda #EPILOGUE_STEP_START_WORLD_MAP
        sta wGameStateStep,b
        rtl

        .databank 0

        ; 80/ED88


      rlStartAlternateEpilogueCreditsDialogue ; 80/ED88

        .al
        .xl
        .autsiz
        .databank ?

        ; Unreferenced credits setup loading dialogueEpilogueCredits8DC964, aEpilogueCreditsBGPalettes, callback rlSetUpEpilogueTextWindowUnused

        jsl rlEvaluateEpilogueEndings
        lda #$0002
        sta aDialogue.wUnknown0018D0,b
        ldx #$07FE
        lda #$00FF

        _ED98
        sta aBG3TilemapBuffer,x
        dec x
        dec x
        bpl _ED98
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0800, $80, $D000

        ldx #$01FE

        _EDB0
        lda aEpilogueCreditsBGPalettes,x
        sta aBGPaletteBuffer,b,x
        dec x
        dec x
        bpl _EDB0
        lda #$0000
        sta aBGPaletteBuffer,b
        sep #$20
        lda #$00
        sta bBufferWH0
        sta bBufferWH1
        stz bBufferWH2
        stz bBufferWH3
        lda #$00
        sta bBufferW12SEL
        sta bBufferW34SEL
        lda bBufferBG1SC
        ora #$02
        sta bBufferBG1SC
        lda bBufferBG2SC
        ora #$02
        sta bBufferBG2SC
        lda bBufferBG3SC
        and #$FC
        sta bBufferBG3SC
        lda #$03
        sta bBufferWOBJSEL
        rep #$20
        sep #$20
        lda #$04
        sta bBufferTM
        lda #$00
        sta bBufferTS
        lda #$04
        sta bBufferTMW
        lda #$00
        sta bBufferTSW
        lda #$A3
        sta bBufferCGWSEL
        lda #$42
        sta bBufferCGADSUB
        lda #$20
        sta bBufferCOLDATA_1
        lda #$40
        sta bBufferCOLDATA_2
        lda #$80
        sta bBufferCOLDATA_3
        rep #$20
        lda #$0000
        sta wBufferBG3HOFS
        sta wBufferBG3VOFS
        jsl rlResetDialogueEngine
        lda #(`dialogueEpilogueCredits8DC964)<<8
        sta lR18+1
        lda #<>dialogueEpilogueCredits8DC964
        sta lR18
        lda #$0002
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsl rlSetUpEpilogueTextWindowUnused
        rtl

        .databank 0

        ; 80/EE37


    .endsection Unsorted80EB37Section


    .section Unsorted80EE37Section

      .al
      .xl

      rlSetupEpilogueCreditsDisplay ; 80/EE37

        .al
        .xl
        .autsiz
        .databank ?

        ; wEpiloguePart 1/step 2: checks rlCalculateFinalRankingScore; loads credits thicket BG, 8CA200, dialogueEpilogueCredits8DC9A6

        jsl rlCalculateFinalRankingScore
        cmp #$0000
        beq _EE51
        lda #EPILOGUE_STEP_SHOW_END_SCREEN
        sta wGameStateStep,b
        lda #$005A
        sta wMusicID,b
        jsl rlStepMusicScript
        rtl


        _EE51
        phk
        plb
        .databank $80
        rep #$30
        lda #$1809
        sta $4300,b
        lda #$8000
        sta $4303,b
        lda #$EFA7
        sta $4302,b
        lda #$4000
        sta $4305,b
        lda #$4000
        sta $2116,b
        sep #$20
        lda #$01
        sta $420B,b
        rep #$20
        lda #$0002
        sta aDialogue.wUnknown0018D0,b
        lda #(`aDecompressionDMAEntry80EFA8)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry80EFA8
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        lda #(`aDecompressionDMAEntry80EFB0)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry80EFB0
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        lda #(`aDecompressionDMAEntry80EFB8)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry80EFB8
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        lda #(`aDecompressionDMAEntry80EFC8)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry80EFC8
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        lda #(`aDecompressionDMAEntry80EFD0)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry80EFD0
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        lda #(`aDecompressionDMAEntry80EFC0)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry80EFC0
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        ldx #$07FE
        lda #$00FF

        _EEDC
        sta aBG3TilemapBuffer,x
        dec x
        dec x
        bpl _EEDC
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0800, $80, $D000

        ldx #$01FE

        _EEF4
        lda aEpilogueCreditsBGPalettes,x
        sta aBGPaletteBuffer,b,x
        dec x
        dec x
        bpl _EEF4
        lda #$0000
        sta aBGPaletteBuffer,b
        sep #$20
        lda #$00
        sta bBufferWH0
        sta bBufferWH1
        stz bBufferWH2
        stz bBufferWH3
        lda #$00
        sta bBufferW12SEL
        sta bBufferW34SEL
        lda bBufferBG1SC
        ora #$02
        sta bBufferBG1SC
        lda bBufferBG2SC
        ora #$02
        sta bBufferBG2SC
        lda bBufferBG3SC
        and #$FC
        sta bBufferBG3SC
        lda #$03
        sta bBufferWOBJSEL
        rep #$20
        sep #$20
        lda #$17
        sta bBufferTM
        lda #$10
        sta bBufferTS
        lda #$03
        sta bBufferTMW
        lda #$00
        sta bBufferTSW
        lda #$A3
        sta bBufferCGWSEL
        lda #$42
        sta bBufferCGADSUB
        lda #$20
        sta bBufferCOLDATA_1
        lda #$40
        sta bBufferCOLDATA_2
        lda #$80
        sta bBufferCOLDATA_3
        rep #$20
        lda #$0000
        sta wBufferBG1HOFS
        sta wBufferBG2HOFS
        lda #$0140
        sta wBufferBG1VOFS
        sta wBufferBG2VOFS
        lda #$000D
        sta wMusicID,b
        jsl rlStepMusicScript
        jsl rlResetDialogueEngine
        lda #(`dialogueEpilogueCredits8DC9A6)<<8
        sta lR18+1
        lda #<>dialogueEpilogueCredits8DC9A6
        sta lR18
        lda #$0002
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsl rlSetUpEpilogueTextWindow
        lda #EPILOGUE_STEP_START_CREDITS
        sta wGameStateStep,b
        lda #$0004
        sta wScreenFadingProcInput,b
        lda #(`procFadeInByScreenFadingTimer)<<8
        sta lR44+1
        lda #<>procFadeInByScreenFadingTimer
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 80/EFA6

        ; Unused: 2 zero bytes.
        .fill 2, $00

    .endsection Unsorted80EE37Section


    .section Unsorted80EFD8Section

      .al
      .xl

      rlSetupEpilogueRankingsDisplay ; 80/EFD8

        .al
        .xl
        .autsiz
        .databank ?

        ; wEpiloguePart 2/step 6: clears VRAM, loads ranking gfx, aEpilogueRankingsBGPalettes, score-based song, dialogueEpilogueCredits8DC9FF

        sep #$20
        lda #$80
        sta $2100,b
        sta bBufferINIDISP
        rep #$20
        jsl rlDisableVBlank
        jsl rlResetHDMAEngine
        phk
        plb
        .databank $80
        rep #$30
        lda #$1809
        sta $4300,b
        lda #$8000
        sta $4303,b
        lda #$F186
        sta $4302,b
        lda #$4000
        sta $4305,b
        lda #$4000
        sta $2116,b
        sep #$20
        lda #$01
        sta $420B,b
        rep #$20
        phk
        plb
        .databank $80
        rep #$30
        lda #$1809
        sta $4300,b
        lda #$8000
        sta $4303,b
        lda #$F186
        sta $4302,b
        lda #$3000
        sta $4305,b
        lda #$1800
        sta $2116,b
        sep #$20
        lda #$01
        sta $420B,b
        rep #$20
        lda #$0002
        sta aDialogue.wUnknown0018D0,b
        ldx #$07FE
        lda #$03FF

        _F04D
        sta aBG3TilemapBuffer,x
        dec x
        dec x
        bpl _F04D
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0800, $80, $D000

        lda #(`aDecompressionDMAEntry80F187)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry80F187
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        lda #(`aDecompressionDMAEntry80F18F)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry80F18F
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        lda #(`aDecompressionDMAEntry80F197)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry80F197
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        lda #(`aDecompressionDMAEntry80F19F)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry80F19F
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        ldx #$01FE

        _F09D
        lda aEpilogueRankingsBGPalettes,x
        sta aBGPaletteBuffer,b,x
        dec x
        dec x
        bpl _F09D
        lda #$0000
        sta aBGPaletteBuffer,b
        sep #$20
        lda #$00
        sta bBufferWH0
        sta bBufferWH1
        stz bBufferWH2
        stz bBufferWH3
        lda #$00
        sta bBufferW12SEL
        sta bBufferW34SEL
        lda bBufferBG1SC
        and #$FC
        sta bBufferBG1SC
        lda bBufferBG2SC
        ora #$02
        sta bBufferBG2SC
        lda bBufferBG3SC
        and #$FC
        sta bBufferBG3SC
        lda #$03
        sta bBufferWOBJSEL
        rep #$20
        sep #$20
        lda #$16
        sta bBufferTM
        lda #$01
        sta bBufferTS
        lda #$00
        sta bBufferTMW
        lda #$00
        sta bBufferTSW
        lda #$02
        sta bBufferCGWSEL
        lda #$44
        sta bBufferCGADSUB
        lda #$20
        sta bBufferCOLDATA_1
        lda #$40
        sta bBufferCOLDATA_2
        lda #$80
        sta bBufferCOLDATA_3
        rep #$20
        lda #$0000
        sta wBufferBG1HOFS
        sta wBufferBG2HOFS
        sta wBufferBG3HOFS
        lda #$0000
        sta wBufferBG1VOFS
        sta wBufferBG3VOFS
        lda #$FFE0
        sta wBufferBG2VOFS
        jsl rlCalculateFinalRankingScore
        cmp #$0000
        beq _F125
        cmp #$0003
        bcc _F12D
        bra _F138


        _F125
        lda #$800E
        sta wMusicID,b
        bra _F13A


        _F12D
        lda #$800C
        lda #$800B
        sta wMusicID,b
        bra _F13A


        _F138
        bra _F13A


        _F13A
        lda #EPILOGUE_STEP_FADE_IN
        sta wGameStateStep,b
        lda #EPILOGUE_STEP_SCROLL_RECORDS
        sta wNextMenuState,b
        jsl rlResetDialogueEngine
        lda #(`dialogueEpilogueCredits8DC9FF)<<8
        sta lR18+1
        lda #<>dialogueEpilogueCredits8DC9FF
        sta lR18
        lda #$0002
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsl rlSetUpEpilogueRecordTextWindow
        lda #(`aEpilogueRecordLayerHDMAInfo)<<8
        sta lR44+1
        lda #<>aEpilogueRecordLayerHDMAInfo
        sta lR44
        lda #$0002
        sta wR40
        jsl rlHDMAEngineCreateEntryByIndex
        jsl rlEnableVBlank
        sep #$20
        lda #$00
        sta $2100,b
        sta bBufferINIDISP
        rep #$20
        rtl

        .databank 0

        ; 80/F185

        ; Unused: 2 zero bytes.
        .fill 2, $00

    .endsection Unsorted80EFD8Section


    .section Unsorted80F1A7Section

      .al
      .xl

      rlStartEpilogueCharacterEndings ; 80/F1A7

        .al
        .xl
        .autsiz
        .databank ?

        ; wEpiloguePart 3/step 8: sets wEpilogueCharacter to $18, calls rlShowNextEpilogueCharacterEnding, sets wMainLoopPointer=rsOpenCastleScreen

        sep #$20
        lda #$80
        sta $2100,b
        sta bBufferINIDISP
        rep #$20
        jsl rlDisableVBlank
        jsl rlResetHDMAEngine
        lda #$0018
        sta wEpilogueCharacter,b
        jsl rlShowNextEpilogueCharacterEnding
        stz wGameStateStep,b
        lda #<>rsOpenCastleScreen
        sta wMainLoopPointer
        jsl rlEnableVBlank
        sep #$20
        rep #$20
        rtl

        .databank 0

        ; 80/F1D5

    .endsection Unsorted80F1A7Section


    .section Unsorted8DA2AASection

      .al
      .xl

      rlScrollEpilogueCredits ; 8D/A2AA

        .al
        .xl
        .autsiz
        .databank ?

        ; Scrolls the credits' two backgrounds up at different speeds ($7F5490 and $7F5493 hold the fixed-point offsets), drawing the sprites and uploading the text rows; once BG2 is in place waits 64 frames and fades out to the end screen (step 13).

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
        jsr rsDrawEpilogueCreditsSprites

        _A305
        lda wBufferBG2VOFS
        cmp #$00E0
        bne _A310
        jsl rlInitEpilogueCreditsSprites

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
        lda wEpilogueTimer
        inc a
        sta wEpilogueTimer
        cmp #$0040
        bcc _A324
        lda #EPILOGUE_STEP_FADE_OUT
        sta wGameStateStep,b
        lda #EPILOGUE_STEP_SHOW_END_SCREEN
        sta wNextMenuState,b
        rtl

        .databank 0

        ; 8D/A34D

    .endsection Unsorted8DA2AASection


    .section Unsorted8DA34DSection

      .al
      .xl

      rsDrawEpilogueCreditsSprites ; 8D/A34D

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws the six credits sprites (rsDrawEpilogueCreditsSprite with X = 0-10).

        ldx #$0000
        jsr rsDrawEpilogueCreditsSprite
        ldx #$0002
        jsr rsDrawEpilogueCreditsSprite
        ldx #$0004
        jsr rsDrawEpilogueCreditsSprite
        ldx #$0006
        jsr rsDrawEpilogueCreditsSprite
        ldx #$0008
        jsr rsDrawEpilogueCreditsSprite
        ldx #$000A
        jsr rsDrawEpilogueCreditsSprite
        rts

        .databank 0

        ; 8D/A372

    .endsection Unsorted8DA34DSection


    .section Unsorted8DA3DESection

      .al
      .xl

      rlSetUpEpilogueTextWindow ; 8D/A3DE

        .al
        .xl
        .autsiz
        .databank ?

        ; Sets the dialogue engine up for the scrolling text of the credits and the play record: no box, text speed 1, the text drawn into the BG3 buffer at $7E8388 from tile (12, 21). X is the dialogue slot.

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

      rlSetUpEpilogueTextWindowUnused ; 8D/A449

        .al
        .xl
        .autsiz
        .databank ?

        ; A variant of rlSetUpEpilogueTextWindow (text at (9, 8)); its only caller in credits.asm is unreferenced.

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

      aEpilogueCreditsLayerHDMAInfo .dstruct structHDMADirectEntryInfo, rlEpilogueCreditsLayerHDMAInit, $A4B5, aUnknown8DA502, $0008BC, PPU_REG_BASE + $2C, $00 ; 8D/A4A8

    .endsection Unsorted8DA449Section


    .section Unsorted8DA4B3Section

      .al
      .xl

      rlEpilogueCreditsLayerHDMAInit ; 8D/A4B3

        .al
        .xl
        .autsiz
        .databank ?

        ; Fills the HDMA table at $0008BC that changes the main screen layers (TM) partway down the screen during the credits.

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

      aEpilogueCreditsWaveHDMAInfo .dstruct structHDMADirectEntryInfo, rlEpilogueCreditsWaveHDMACycle, rlEpilogueCreditsWaveHDMACycle, aEpilogueCreditsWaveHDMACode, $7F56C9, PPU_REG_BASE + $0F, $02 ; 8D/A504

    .endsection Table8DA502Section


    .section Unsorted8DA50FSection

      .al
      .xl

      rlEpilogueCreditsWaveHDMACycle ; 8D/A50F

        .al
        .xl
        .autsiz
        .databank ?

        ; Builds the HDMA table at $7F56C9 that makes BG2's lines sway left and right (a 16-step wave from $8D/A612) while the credits scroll; frees itself once $7F5493 reaches 100.

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
        lda <>aEpilogueCreditsWaveOffsets,b,y
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
        lda <>aEpilogueCreditsWaveOffsets,b,y
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
        lda <>aEpilogueCreditsWaveOffsets,b,y
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

      aEpilogueCreditsWaveOffsets ; 8D/A612

        ; The sway of BG2's lines, read 16 frames round.

        .byte 0, 1, 2, 1, 0, 1, 2, 1, 0, 1, 2, 1, 0, 1, 2, 1

      aEpilogueCreditsWaveHDMACode ; 8D/A622

        HDMA_HALT

    .endsection Unsorted8DA50FSection


    .section Unsorted8DA624Section

      .al
      .xl

      rsDrawEpilogueCreditsSprite ; 8D/A624

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws credits sprite X (position from $7F5420/$7F5430, the kind and frame from aWorldMapMarker/aWorldMapPortrait, which the credits reuse).

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

        ; Read by rsDrawEpilogueCreditsSprite.

        .word $0000, $0024, $0048

        ; 8D/A73D

      aUnknown8DA73D ; 8D/A73D

        ; Read by rsDrawEpilogueCreditsSprite.

        .word $0001, $0001, $0002

        ; 8D/A743

      aUnknown8DA743 ; 8D/A743

        ; Read by rsDrawEpilogueCreditsSprite.

        .word $0002, $0001, $0002

        ; 8D/A749

      aUnknown8DA749 ; 8D/A749

        ; Read by rsDrawEpilogueCreditsSprite.

        .word $0000, $0000, $0000

        ; 8D/A74F

      aUnknown8DA74F ; 8D/A74F

        ; Read by rsDrawEpilogueCreditsSprite.

        .word $0000, $0000, $0001

        ; 8D/A755

    .endsection Data8DA737Section


    .section Unsorted8DA755Section

      .al
      .xl

      rlInitEpilogueCreditsSprites ; 8D/A755

        .al
        .xl
        .autsiz
        .databank ?

        ; Sets the positions and kinds of the six credits sprites.

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


    .section Unsorted8DAF33Section

      .al
      .xl

      rlShowEpilogueEndScreen ; 8D/AF33

        .al
        .xl
        .autsiz
        .databank ?

        ; Blanks the screen, loads the end screen (aDecompressionDMAEntry8DAF95/9D and the palettes at aEpilogueRankingsBGPalettes) and shows BG2.

        sep #$20
        lda #$80
        sta $2100,b
        sta bBufferINIDISP
        rep #$20
        jsl rlDisableVBlank
        jsl rlResetHDMAEngine
        jsl rlClearDialogueStatusAndTimers
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
        lda aEpilogueRankingsBGPalettes,x
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

        ; Read by rsDrawEpilogueCreditsSprite.

        .word $CCF2, $0008, $CCC6, $000A, $CCDC, $000E, $CCB0, $0008
        .word $FFFF

        ; 8D/CF9A

      aUnknown8DCF9A ; 8D/CF9A

        ; Read by rsDrawEpilogueCreditsSprite.

        .byte $4A, $CD, $08, $00, $1E, $CD, $0A, $00, $34, $CD, $0E, $00, $08, $CD, $08, $00
        .byte $FF, $FF, $A2, $CD, $08, $00, $76, $CD, $0A, $00, $8C, $CD, $0E, $00, $60, $CD
        .byte $08, $00, $FF, $FF, $FA, $CD, $08, $00, $CE, $CD, $0A, $00, $E4, $CD, $0E, $00
        .byte $B8, $CD, $08, $00, $FF, $FF, $9D, $CE, $05, $00, $3F, $CE, $07, $00, $6E, $CE
        .byte $0B, $00, $10, $CE, $05, $00, $FF, $FF, $59, $CF, $05, $00, $FB, $CE, $07, $00
        .byte $2A, $CF, $0B, $00, $CC, $CE, $05, $00, $FF, $FF

      aOpeningCreditsVScrollHDMAInfo1 .dstruct structHDMADirectEntryInfo, rlOpeningCreditsVScrollHDMANoOp, rlOpeningCreditsVScrollHDMANoOp, aOpeningCreditsVScrollHDMACode, aOpeningCreditsVScrollTable1, PPU_REG_BASE + $12, $02 ; 8D/CFF4
      aOpeningCreditsVScrollHDMAInfo2 .dstruct structHDMADirectEntryInfo, rlOpeningCreditsVScrollHDMANoOp, rlOpeningCreditsVScrollHDMANoOp, aOpeningCreditsVScrollHDMACode, aOpeningCreditsVScrollTable2, PPU_REG_BASE + $12, $02 ; 8D/CFFF
      aOpeningCreditsVScrollHDMAInfo3 .dstruct structHDMADirectEntryInfo, rlOpeningCreditsVScrollHDMANoOp, rlOpeningCreditsVScrollHDMANoOp, aOpeningCreditsVScrollHDMACode, aOpeningCreditsVScrollTable3, PPU_REG_BASE + $12, $02 ; 8D/D00A
      aOpeningCreditsVScrollHDMAInfo4 .dstruct structHDMADirectEntryInfo, rlOpeningCreditsVScrollHDMANoOp, rlOpeningCreditsVScrollHDMANoOp, aOpeningCreditsVScrollHDMACode, aOpeningCreditsVScrollTable4, PPU_REG_BASE + $12, $02 ; 8D/D015
      aOpeningCreditsVScrollHDMAInfo5 .dstruct structHDMADirectEntryInfo, rlOpeningCreditsVScrollHDMANoOp, rlOpeningCreditsVScrollHDMANoOp, aOpeningCreditsVScrollHDMACode, aOpeningCreditsVScrollTable5, PPU_REG_BASE + $12, $02 ; 8D/D020
      aOpeningCreditsVScrollHDMAInfo6 .dstruct structHDMADirectEntryInfo, rlOpeningCreditsVScrollHDMANoOp, rlOpeningCreditsVScrollHDMANoOp, aOpeningCreditsVScrollHDMACode, aOpeningCreditsVScrollTable6, PPU_REG_BASE + $12, $02 ; 8D/D02B
      aOpeningCreditsVScrollHDMAInfo7 .dstruct structHDMADirectEntryInfo, rlOpeningCreditsVScrollHDMANoOp, rlOpeningCreditsVScrollHDMANoOp, aOpeningCreditsVScrollHDMACode, aOpeningCreditsVScrollTable7, PPU_REG_BASE + $12, $02 ; 8D/D036
        ; Nothing uses the seventh.

        ; 8D/D041

    .endsection Data8DCF88Section


