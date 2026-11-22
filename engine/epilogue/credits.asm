; Epilogue, credits, and final ranking screen setup and VBlank overflow checks.


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
        jsl rlUnknown9181F6
        jsl rlUnknown878256
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

        ; Opens epilogue/credits (game state $36/$35, rsRunEpilogueVBlank) and dispatches $08DA (0..3)

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
        jsl rlUnknown8780AA
        jsl rlResetMenuOptionStack
        lda #$0036
        sta wGameStateRoutine1,b
        lda #$0035
        sta wGameStateRoutine2,b
        stz wGameStateStep,b
        lda #<>rsRunEpilogueVBlank
        sta wVBlankPointer
        lda #<>rsRunFrameTasks
        sta wMainLoopPointer
        jsl rlUnknown88CD61
        lda $08DA,b
        beq _ED57
        cmp #$0001
        beq _ED5D
        cmp #$0002
        beq _ED63
        cmp #$0003
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

        ; $08DA=0: calls rlEvaluateEpilogueEndings and sets wGameStateStep=$0C

        jsl rlEvaluateEpilogueEndings
        lda #$000C
        sta wGameStateStep,b
        rtl

        .databank 0

        ; 80/ED88


      rlStartAlternateEpilogueCreditsDialogue ; 80/ED88

        .al
        .xl
        .autsiz
        .databank ?

        ; Unreferenced credits setup loading dialogueEpilogueCredits8DC964, aUnknown8CA200, callback rlUnknown8DA449

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
        lda aUnknown8CA200,x
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
        jsl rlUnknown8DA449
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

        ; $08DA=1/step 2: checks rlCalculateFinalRankingScore; loads credits thicket BG, 8CA200, dialogueEpilogueCredits8DC9A6

        jsl rlCalculateFinalRankingScore
        cmp #$0000
        beq _EE51
        lda #$000D
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
        lda aUnknown8CA200,x
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
        jsl rlUnknown8DA3DE
        lda #$0003
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

    .endsection Unsorted80EE37Section


    .section Unsorted80EFD8Section

      .al
      .xl

      rlSetupEpilogueRankingsDisplay ; 80/EFD8

        .al
        .xl
        .autsiz
        .databank ?

        ; $08DA=2/step 6: clears VRAM, loads ranking gfx, aUnknown8CA400, score-based song, dialogueEpilogueCredits8DC9FF

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
        lda aUnknown8CA400,x
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
        lda #$000B
        sta wGameStateStep,b
        lda #$0007
        sta wNextMenuState,b
        jsl rlResetDialogueEngine
        lda #(`dialogueEpilogueCredits8DC9FF)<<8
        sta lR18+1
        lda #<>dialogueEpilogueCredits8DC9FF
        sta lR18
        lda #$0002
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsl rlUnknown8DAEC2
        lda #(`aUnknown8DAE7A)<<8
        sta lR44+1
        lda #<>aUnknown8DAE7A
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

    .endsection Unsorted80EFD8Section


    .section Unsorted80F1A7Section

      .al
      .xl

      rlStartEpilogueCharacterEndings ; 80/F1A7

        .al
        .xl
        .autsiz
        .databank ?

        ; $08DA=3/step 8: sets $08DC=$18, calls rlUnknown8DB52C, sets wMainLoopPointer=rsOpenCastleScreen

        sep #$20
        lda #$80
        sta $2100,b
        sta bBufferINIDISP
        rep #$20
        jsl rlDisableVBlank
        jsl rlResetHDMAEngine
        lda #$0018
        sta $08DC,b
        jsl rlUnknown8DB52C
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


