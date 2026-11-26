; The chapter intro title card: the chapter's number and title sliding in over a
; waving background. rsOpenChapterIntroScreen (bank $80) loads the screen and
; enters the save menu's game state at step $24; the steps (bank $91) fade in
; with the chapter's intro song (aChapterIntroSongs), hold for
; aChapterIntroHoldFrames, fade out and start the chapter map. The two HDMA
; tables (aChapterIntroBG2VOFSTable, aChapterIntroBG1HOFSTable) make the wave and
; the slide.


    .section Unsorted80F2BESection

      .al
      .xl

      rsOpenChapterIntroScreen ; 80/F2BE

        .al
        .autsiz
        .databank ?

        ; Opens chapter title/intro display (state 5/4, step $24, calls HDMA/gfx/BG setup)

        ; Reached from the world map (Start skips it: bank $8B) and from an event command (event_scripts.asm), both through a main-loop fade.

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

        lda #0
        sta wR1
        lda #$4000
        sta wR2
        lda #$5000
        sta wR6
        lda #$6000
        sta wR7
        jsl rlSetLayerPositionsAndSizes

        jsl rlProcEngineResetProcEngine
        jsl rlActiveSpriteEngineReset
        jsl rlResetHDMAEngine
        jsl rlResetIRQEngine
        jsl rlResetRAMStructAndAreaVariables
        jsl rlInitMapMenus
        jsl rlResetMenuOptionStack

        jsr rsCreateChapterIntroHDMA
        jsr rsLoadChapterIntroGraphics
        jsr rsSetChapterIntroBGSettings

        lda #$0024
        sta wGameStateStep,b
        lda #GAMESTATE_SAVE_MENU_SETUP
        sta wGameStateRoutine1,b
        lda #GAMESTATE_SAVE_MENU_UPKEEP
        sta wGameStateRoutine2,b

        lda #<>rsRunFrameTasks
        sta wMainLoopPointer

        jsl rlEnableVBlank

        plp
        cli
        rts

        .databank 0

        ; 80/F337

      aChapterIntroTilemapEntryUnused ; 80/F337

        ; Unreferenced. The same nine bytes follow an rts at both 80/F337 and
        ; 88/A6CA; nothing reads either copy.
        .byte $20, $20, $00, $00, $00, $00, $88, $83, $7E

    .endsection Unsorted80F2BESection


    .section Unsorted80F340Section

      .al
      .xl

      rsCreateChapterIntroHDMA ; 80/F340

        .al
        .xl
        .autsiz
        .databank ?

        ; Zeroes wChapterIntroFrames, wChapterIntroPhaseFrames and wChapterIntroPhase and creates the BG2VOFS and BG1HOFS HDMA entries

        lda #$0000
        sta wChapterIntroFrames
        sta wChapterIntroPhaseFrames
        sta wChapterIntroPhase
        lda #(`aChapterIntroBG2VOFSHDMA)<<8
        sta lR44+1
        lda #<>aChapterIntroBG2VOFSHDMA
        sta lR44
        jsl rlHDMAEngineCreateEntry
        lda #(`aChapterIntroBG1HOFSHDMA)<<8
        sta lR44+1
        lda #<>aChapterIntroBG1HOFSHDMA
        sta lR44
        jsl rlHDMAEngineCreateEntry
        rts

        .databank 0

        ; 80/F36C

    .endsection Unsorted80F340Section


    .section Table80F36CSection

      .al
      .xl

      aChapterIntroBG2VOFSHDMA .dstruct structHDMADirectEntryInfo, rlInitChapterIntroBG2VOFSHDMA, rlCycleChapterIntroBG2VOFSHDMA, aChapterIntroBG2VOFSHDMACode, $7F828F, PPU_REG_BASE + $0F, $02 ; 80/F36C

    .endsection Table80F36CSection


    .section Unsorted80F377Section

      .al
      .xl

      rlInitChapterIntroBG2VOFSHDMA ; 80/F377

        .al
        .xl
        .autsiz
        .databank ?

        ; HDMA init forwarding to rlFillChapterIntroBG2VOFSTable

        jsl rlFillChapterIntroBG2VOFSTable
        rtl

        .databank 0

        ; 80/F37C

      rlCycleChapterIntroBG2VOFSHDMA ; 80/F37C

        .al
        .xl
        .autsiz
        .databank ?

        ; HDMA onCycle rtl stub for aChapterIntroBG2VOFSHDMA

        rtl

        .databank 0

        ; 80/F37D

    .endsection Unsorted80F377Section


    .section Table80F37DSection

      .al
      .xl

      aChapterIntroBG2VOFSHDMACode ; 80/F37D
        HDMA_HALT

      aChapterIntroBG1HOFSHDMA .dstruct structHDMADirectEntryInfo, rlInitChapterIntroBG1HOFSHDMA, rlCycleChapterIntroBG1HOFSHDMA, $F390, $7F838F, PPU_REG_BASE + $0D, $02 ; 80/F37F

    .endsection Table80F37DSection


    .section Unsorted80F38ASection

      .al
      .xl

      rlInitChapterIntroBG1HOFSHDMA ; 80/F38A

        .al
        .xl
        .autsiz
        .databank ?

        ; HDMA init forwarding to rlFillChapterIntroBG1HOFSTable

        jsl rlFillChapterIntroBG1HOFSTable
        rtl

        .databank 0

        ; 80/F38F

      rlCycleChapterIntroBG1HOFSHDMA ; 80/F38F

        .al
        .xl
        .autsiz
        .databank ?

        ; HDMA onCycle rtl stub for aChapterIntroBG1HOFSHDMA

        rtl

        .databank 0

        ; 80/F390


      aChapterIntroBG1HOFSHDMACode ; 80/F390

        HDMA_HALT

    .endsection Unsorted80F38ASection


    .section Unsorted80F392Section

      .al
      .xl

      rsLoadChapterIntroGraphics ; 80/F392

        .al
        .xl
        .autsiz
        .databank ?

        ; Loads aChapterIntroAndUIBGPalettes, decompresses g4bppcChapterIntroBannerTiles, dispatches wCurrentChapter via aChapterIntroTitleDMATable

        lda #(`aDecompressionDMAEntry80F42B)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry80F42B
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        lda #(`aDecompressionDMAEntry80F433)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry80F433
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        ldx #$0100

        _F3B1
        lda aChapterIntroAndUIBGPalettes-2,x
        sta wJoy2RepeatTimer,x
        dec x
        dec x
        bne _F3B1
        ldx #$0020

        _F3BE
        lda aChapterIntroAndUIBGPalettes+$C0-2,x
        sta $01DE,b,x
        dec x
        dec x
        bne _F3BE
        lda #$0053
        jsl rlUnitWindowFillBG3Buffer
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $1000, $80, $A000

        lda #(`g4bppcChapterIntroBannerTiles)<<8
        sta lR18+1
        lda #<>g4bppcChapterIntroBannerTiles
        sta lR18
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        sta lR19
        jsl rlAppendDecompList
        lda wCurrentChapter,b
        cmp #$000C
        bmi _F3FF

        _F3FD
        bra _F3FD


        _F3FF
        asl a
        tax
        jsr (aChapterIntroTitleDMATable,x)
        lda #(`aDecompressionDMAEntry80F43B)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry80F43B
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        rts

        .databank 0

        ; 80/F413

    .endsection Unsorted80F392Section


    .section Table80F413Section

      .al
      .xl

      aChapterIntroTitleDMATable ; 80/F413

        ; Jump table of rsLoadChapterIntroGraphics.
        .word <>rsDMAPrologueTitleGraphic
        .word <>rsDMAChapter01TitleGraphic
        .word <>rsDMAChapter02TitleGraphic
        .word <>rsDMAChapter03TitleGraphic
        .word <>rsDMAChapter04TitleGraphic
        .word <>rsDMAChapter05TitleGraphic
        .word <>rsDMAChapter06TitleGraphic
        .word <>rsDMAChapter07TitleGraphic
        .word <>rsDMAChapter08TitleGraphic
        .word <>rsDMAChapter09TitleGraphic
        .word <>rsDMAChapter10TitleGraphic
        .word <>rsDMAChapterFinalTitleGraphic

    .endsection Table80F413Section


    .section ChapterIntroDecompressionDMAEntriesSection

      ; Entries for rlHandleMapMenuDecompressionDMA.
      aDecompressionDMAEntry80F42B .structDecompressionDMAEntry g4bppcChapterIntroBG1Tiles, $4000, $0000 ; 80/F42B
      aDecompressionDMAEntry80F433 .structDecompressionDMAEntry g4bppcReviveScreenTiles, $1200, $4000 ; 80/F433
      aDecompressionDMAEntry80F43B .structDecompressionDMAEntry acReviveScreenBG2Tilemap, $0800, $6000 ; 80/F43B

    .endsection ChapterIntroDecompressionDMAEntriesSection


    .section Unsorted80F443Section

      .al
      .xl

      rsDMAPrologueTitleGraphic ; 80/F443

        .al
        .xl
        .autsiz
        .databank ?

        ; DMAs $C0 bytes of Prologue title tilemap (aDecompressionBuffer) to VRAM $A300

        jsl rlDMAByStruct

          .structDMAToVRAM aDecompressionBuffer, $00C0, $80, $A300

        rts

        .databank 0

        ; 80/F451

    .endsection Unsorted80F443Section


    .section Unsorted80F451Section

      .al
      .xl

      rsDMAChapter01TitleGraphic ; 80/F451

        .al
        .xl
        .autsiz
        .databank ?

        ; DMAs $C0 bytes of Chapter 1 title tilemap ($7E8C48) to VRAM $A300

        jsl rlDMAByStruct

          .structDMAToVRAM $7E8C48, $00C0, $80, $A300

        rts

        .databank 0

        ; 80/F45F

    .endsection Unsorted80F451Section


    .section Unsorted80F45FSection

      .al
      .xl

      rsDMAChapter02TitleGraphic ; 80/F45F

        .al
        .xl
        .autsiz
        .databank ?

        ; DMAs $C0 bytes of Chapter 2 title tilemap ($7E8D08) to VRAM $A300

        jsl rlDMAByStruct

          .structDMAToVRAM $7E8D08, $00C0, $80, $A300

        rts

        .databank 0

        ; 80/F46D

    .endsection Unsorted80F45FSection


    .section Unsorted80F46DSection

      .al
      .xl

      rsDMAChapter03TitleGraphic ; 80/F46D

        .al
        .xl
        .autsiz
        .databank ?

        ; DMAs $C0 bytes of Chapter 3 title tilemap ($7E8DC8) to VRAM $A300

        jsl rlDMAByStruct

          .structDMAToVRAM $7E8DC8, $00C0, $80, $A300

        rts

        .databank 0

        ; 80/F47B

    .endsection Unsorted80F46DSection


    .section Unsorted80F47BSection

      .al
      .xl

      rsDMAChapter04TitleGraphic ; 80/F47B

        .al
        .xl
        .autsiz
        .databank ?

        ; DMAs $C0 bytes of Chapter 4 title tilemap ($7E8E88) to VRAM $A300

        jsl rlDMAByStruct

          .structDMAToVRAM $7E8E88, $00C0, $80, $A300

        rts

        .databank 0

        ; 80/F489

    .endsection Unsorted80F47BSection


    .section Unsorted80F489Section

      .al
      .xl

      rsDMAChapter05TitleGraphic ; 80/F489

        .al
        .xl
        .autsiz
        .databank ?

        ; DMAs $C0 bytes of Chapter 5 titlemap ($7E8F48) to VRAM $A300

        jsl rlDMAByStruct

          .structDMAToVRAM $7E8F48, $00C0, $80, $A300

        rts

        .databank 0

        ; 80/F497

    .endsection Unsorted80F489Section


    .section Unsorted80F497Section

      .al
      .xl

      rsDMAChapter06TitleGraphic ; 80/F497

        .al
        .xl
        .autsiz
        .databank ?

        ; DMAs $C0 bytes of Chapter 6 titlemap ($7E9008) to VRAM $A300

        jsl rlDMAByStruct

          .structDMAToVRAM $7E9008, $00C0, $80, $A300

        rts

        .databank 0

        ; 80/F4A5

    .endsection Unsorted80F497Section


    .section Unsorted80F4A5Section

      .al
      .xl

      rsDMAChapter07TitleGraphic ; 80/F4A5

        .al
        .xl
        .autsiz
        .databank ?

        ; DMAs $C0 bytes of Chapter 7 titlemap ($7E90C8) to VRAM $A300

        jsl rlDMAByStruct

          .structDMAToVRAM $7E90C8, $00C0, $80, $A300

        rts

        .databank 0

        ; 80/F4B3

    .endsection Unsorted80F4A5Section


    .section Unsorted80F4B3Section

      .al
      .xl

      rsDMAChapter08TitleGraphic ; 80/F4B3

        .al
        .xl
        .autsiz
        .databank ?

        ; DMAs $C0 bytes of Chapter 8 titlemap ($7E9188) to VRAM $A300

        jsl rlDMAByStruct

          .structDMAToVRAM $7E9188, $00C0, $80, $A300

        rts

        .databank 0

        ; 80/F4C1

    .endsection Unsorted80F4B3Section


    .section Unsorted80F4C1Section

      .al
      .xl

      rsDMAChapter09TitleGraphic ; 80/F4C1

        .al
        .xl
        .autsiz
        .databank ?

        ; DMAs $C0 bytes of Chapter 9 titlemap ($7E9248) to VRAM $A300

        jsl rlDMAByStruct

          .structDMAToVRAM $7E9248, $00C0, $80, $A300

        rts

        .databank 0

        ; 80/F4CF

    .endsection Unsorted80F4C1Section


    .section Unsorted80F4CFSection

      .al
      .xl

      rsDMAChapter10TitleGraphic ; 80/F4CF

        .al
        .xl
        .autsiz
        .databank ?

        ; DMAs $C0 bytes of Chapter 10 titlemap ($7E9308) to VRAM $A300

        jsl rlDMAByStruct

          .structDMAToVRAM $7E9308, $00C0, $80, $A300

        rts

        .databank 0

        ; 80/F4DD

    .endsection Unsorted80F4CFSection


    .section Unsorted80F4DDSection

      .al
      .xl

      rsDMAChapterFinalTitleGraphic ; 80/F4DD

        .al
        .xl
        .autsiz
        .databank ?

        ; DMAs $C0 bytes of Final Chapter titlemap ($7E93C8) to VRAM $A300

        jsl rlDMAByStruct

          .structDMAToVRAM $7E93C8, $00C0, $80, $A300

        rts

        .databank 0

        ; 80/F4EB

    .endsection Unsorted80F4DDSection


    .section Unsorted80F4EBSection

      .al
      .xl

      rsSetChapterIntroBGSettings ; 80/F4EB

        .al
        .xl
        .autsiz
        .databank ?

        ; Sets BG1SC |= 1, TM=1, TS=2, CGWSEL=2, CGADSUB=1, clears BG1-3 H/V scrolls for chapter intro

        sep #$20
        lda bBufferBG1SC
        and #$FC
        ora #$01
        sta bBufferBG1SC
        lda bBufferBG2SC
        and #$FC
        sta bBufferBG2SC
        lda #$01
        sta bBufferTM
        lda #$02
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
        lda #$02
        sta bBufferCGWSEL
        lda #$01
        sta bBufferCGADSUB
        rep #$20
        stz wBufferBG1HOFS
        stz wBufferBG2HOFS
        stz wBufferBG2VOFS
        stz wBufferBG3HOFS
        stz wBufferBG3VOFS
        stz wBufferBG1VOFS
        rts

        .databank 0

        ; 80/F542

    .endsection Unsorted80F4EBSection


    .section ChapterIntroStepsSection

      .al
      .xl

      rsChapterIntroStart ; 91/D6BC

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$00
        sta bBufferINIDISP
        rep #$20
        inc wGameStateStep,b
        rts

        .databank 0

        ; 91/D6C8

      rsChapterIntroFadeIn ; 91/D6C8

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlChapterIntroFadeInStep
        jsl rlChapterIntroUpdate
        rts

        .databank 0

        ; 91/D6D1

      rsChapterIntroHold ; 91/D6D1

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlChapterIntroHold
        jsl rlChapterIntroUpdate
        rts

        .databank 0

        ; 91/D6DA

      rsChapterIntroFadeOut ; 91/D6DA

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlChapterIntroFadeOutStep
        jsl rlChapterIntroUpdate
        rts

        .databank 0

        ; 91/D6E3

    .endsection ChapterIntroStepsSection


    .section Unsorted91D6E3Section

      .al
      .xl

      rsChapterIntroSkip ; 91/D6E3

        .al
        .xl
        .autsiz
        .databank ?

        ; Step $28: no code seen sets it.

        jsl rlChapterIntroSkipToMap
        jsl rlChapterIntroUpdate
        rts

        .databank 0

        ; 91/D6EC

    .endsection Unsorted91D6E3Section


    .section Unsorted91F748Section

      .al
      .xl

      rlChapterIntroFadeInStep ; 91/F748

        .al
        .xl
        .autsiz
        .databank ?

        lda wChapterIntroPhase
        cmp #$0003
        bmi _F753

        _F751
        bra _F751


        _F753
        asl a
        tax
        jsr (aChapterIntroFadeInPhases,x)
        rtl

        .databank 0

        ; 91/F759

    .endsection Unsorted91F748Section


    .section Unsorted91F759Section

      .al
      .xl

      aChapterIntroFadeInPhases ; 91/F759

        .word <>rsChapterIntroBegin, <>rsChapterIntroBrighten, <>rsChapterIntroFadePaletteIn

      rsChapterIntroBegin ; 91/F75F

        .al
        .xl
        .autsiz
        .databank ?

        ; Saves and blacks out the first BG palette, starts the chapter's intro song (aChapterIntroSongs) and the palette fade.

        ldx #$0020

        _F762
        lda @l aBGPaletteBuffer.aPalette4-2,x
        sta $7ECFFE,x
        dec x
        dec x
        bne _F762
        lda #$0000
        ldx #$0020

        _F774
        sta aBGPaletteBuffer.aPalette4-2,b,x
        dec x
        dec x
        bne _F774
        lda #$0001
        sta wChapterIntroPhase
        lda #$0000
        sta wChapterIntroPhaseFrames
        sta wChapterIntroTitleSettled
        sta wChapterIntroFadeFrames
        lda #$0002
        sta wChapterIntroFadeInterval
        lda #$0044
        sta aPaletteFading,b
        stz aPaletteFading.wCurrentStep,b
        lda #$00E2
        jsl rlQueueSoundCommand
        lda wCurrentChapter,b
        asl a
        tax
        lda aChapterIntroSongs,x
        beq _F7B6
        sta wMusicID,b

        _F7B6
        rts

        .databank 0

        ; 91/F7B7

      aChapterIntroSongs ; 91/F7B7

        ; One word per chapter, read by rsChapterIntroBegin: if it is not 0, it is stored in $04BA.

        .word $006B, $0055, $0055, $0063, $0056, $0066, $0026, $006B
        .word $0063, $0081, $007A, $0000

        ; 91/F7CF

      rsChapterIntroBrighten ; 91/F7CF

        .al
        .xl
        .autsiz
        .databank ?

        lda wChapterIntroPhaseFrames
        cmp #$0006
        bne _F7FE
        lda #$0000
        sta wChapterIntroPhaseFrames
        sep #$20
        lda bBufferINIDISP
        inc a
        sta bBufferINIDISP
        rep #$20
        and #$000F
        cmp #$000F
        bne _F7FE
        lda #$0002
        sta wChapterIntroPhase
        lda #$0000
        sta wChapterIntroPhaseFrames

        _F7FE
        lda wChapterIntroFadeFrames
        cmp wChapterIntroFadeInterval
        bne _F812
        lda #$0000
        sta wChapterIntroFadeFrames
        jsr rsChapterIntroFadePaletteStep

        _F812
        rts

        .databank 0

    .endsection Unsorted91F759Section


    .section Unsorted91F813Section

      .al
      .xl

      rsChapterIntroFadePaletteIn ; 91/F813

        .al
        .xl
        .autsiz
        .databank ?

        lda wChapterIntroFadeFrames
        cmp wChapterIntroFadeInterval
        bne _F837
        lda #$0000
        sta wChapterIntroFadeFrames
        jsr rsChapterIntroFadePaletteStep
        bcc _F837
        inc wGameStateStep,b
        lda #$0000
        sta wChapterIntroPhaseFrames
        sta wChapterIntroPhase

        _F837
        rts

        .databank 0

        ; 91/F838

      rlChapterIntroHold ; 91/F838

        .al
        .xl
        .autsiz
        .databank ?

        ; Waits aChapterIntroHoldFrames[chapter] frames, then starts the fade out (step $27).

        lda @l wCurrentChapter
        asl a
        tax
        lda wChapterIntroPhaseFrames
        cmp aChapterIntroHoldFrames,x
        bne _F871
        ldx #$0020
        lda #$0000

        _F84E
        sta $7ECFFE,x
        dec x
        dec x
        bne _F84E
        lda #$005F
        sta aPaletteFading,b
        stz aPaletteFading.wCurrentStep,b
        inc wGameStateStep,b
        lda #$0000
        sta wChapterIntroPhase
        sta wChapterIntroPhaseFrames
        sta wChapterIntroFadeFrames

        _F871
        rtl

        .databank 0

        ; 91/F872

    .endsection Unsorted91F813Section


    .section Data91F872Section

      .al
      .xl

      aChapterIntroHoldFrames ; 91/F872

        ; Read by rlChapterIntroHold.

        .word $00C8, $00BE, $00B4, $00C8, $00B4, $00D2, $00B4, $00B4
        .word $00B4, $00B4, $00B4, $00D2

        ; 91/F88A

    .endsection Data91F872Section


    .section Unsorted91F88ASection

      .al
      .xl

      rlChapterIntroFadeOutStep ; 91/F88A

        .al
        .xl
        .autsiz
        .databank ?

        lda wChapterIntroPhase
        cmp #$0002
        bmi _F895

        _F893
        bra _F893


        _F895
        asl a
        tax
        jsr (aChapterIntroFadeOutPhases,x)
        rtl

        .databank 0

        ; 91/F89B

    .endsection Unsorted91F88ASection


    .section Table91F89BSection

      .al
      .xl

      aChapterIntroFadeOutPhases ; 91/F89B

        ; Jump table of rlChapterIntroFadeOutStep.
        .word <>rsChapterIntroDarken
        .word <>rsChapterIntroStartMap

    .endsection Table91F89BSection


    .section Unsorted91F89FSection

      .al
      .xl

      rsChapterIntroDarken ; 91/F89F

        .al
        .xl
        .autsiz
        .databank ?

        lda wChapterIntroPhaseFrames
        cmp #$0007
        bne _F8C4
        lda #$0000
        sta wChapterIntroPhaseFrames
        sep #$20
        lda bBufferINIDISP
        dec a
        sta bBufferINIDISP
        rep #$20
        and #$000F
        bne _F8C4
        lda #$0001
        sta wChapterIntroPhase

        _F8C4
        lda wChapterIntroFadeFrames
        cmp #$0002
        bne _F8D7
        jsr rsChapterIntroFadePaletteStep
        lda #$0000
        sta wChapterIntroFadeFrames

        _F8D7
        rts

        .databank 0

        ; 91/F8D8

      rsChapterIntroStartMap ; 91/F8D8

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        lda #GAMESTATE_NONE
        sta wGameStateRoutine1,b
        lda #<>rsStartChapterMap
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        lda #$0029
        sta wGameStateStep,b
        stz aPaletteFading,b
        stz aPaletteFading.wCurrentStep,b
        rts

        .databank 0

        ; 91/F907

    .endsection Unsorted91F89FSection


    .section Unsorted91F907Section

      .al
      .xl

      rlChapterIntroSkipToMap ; 91/F907

        .al
        .xl
        .autsiz
        .databank ?

        lda wChapterIntroPhaseFrames
        bne _F917
        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        bra _F934


        _F917
        stz wGameStateRoutine1,b
        lda #<>rsStartChapterMap
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        stz aPaletteFading,b
        stz aPaletteFading.wCurrentStep,b

        _F934
        rtl

        .databank 0

        ; 91/F935

    .endsection Unsorted91F907Section


    .section Unsorted91F935Section

      .al
      .xl

      rlChapterIntroUpdate ; 91/F935

        .al
        .xl
        .autsiz
        .databank ?

        ; Every frame of the intro: slides the title in, counts the timers, waves BG2.

        jsr rsSlideChapterIntroTitle
        lda wChapterIntroFrames
        inc a
        sta wChapterIntroFrames
        lda wChapterIntroFadeFrames
        inc a
        sta wChapterIntroFadeFrames
        lda wChapterIntroPhaseFrames
        inc a
        sta wChapterIntroPhaseFrames
        lda wVBlankEnabledFramecount
        lsr a
        sta wBufferBG2VOFS
        rtl

        .databank 0

        ; 91/F959

    .endsection Unsorted91F935Section


    .section Unsorted91F959Section

      .al
      .xl

      rlFillChapterIntroBG2VOFSTable ; 91/F959

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $91
        phk
        plb
        .databank $91
        ldx #$0000
        sep #$20
        lda #$5D
        sta aChapterIntroBG2VOFSTable,x
        rep #$20
        lda #$0000
        sta $7F8290,x
        inc x
        inc x
        inc x
        ldy #$0000

        _F979
        sep #$20
        lda #$01
        sta aChapterIntroBG2VOFSTable,x
        rep #$20
        lda $7F8290,x
        clc
        adc <>aChapterIntroWaveOffsets,b,y
        sta $7F8290,x
        inc y
        inc y
        inc x
        inc x
        inc x
        cpy #$0030
        bne _F979
        sep #$20
        lda #$00
        sta aChapterIntroBG2VOFSTable,x
        rep #$20
        lda #$0000
        sta $7F8290,x
        plp
        plb
        .databank $91
        rtl

        .databank 0

        ; 91/F9AD

    .endsection Unsorted91F959Section


    .section Table91F9ADSection

      .al
      .xl

      aChapterIntroWaveOffsets ; 91/F9AD

        ; Read by rlFillChapterIntroBG2VOFSTable.

        .word $0000, $0006, $000D, $0013, $0018, $001E, $0023, $0029
        .word $002E, $0033, $0039, $003E, $0042, $0045, $0046, $0046
        .word $0045, $0044, $0041, $003D, $0037, $0030, $0029, $0023

        ; 91/F9DD

    .endsection Table91F9ADSection


    .section Unsorted91F9DDSection

      .al
      .xl

      rlFillChapterIntroBG1HOFSTable ; 91/F9DD

        .al
        .xl
        .autsiz
        .databank ?

        phk
        plb
        .databank $91
        ldx #$0000
        sep #$20
        lda #$60
        sta aChapterIntroBG1HOFSTable,x
        rep #$20
        inc x
        lda #$0000
        sta aChapterIntroBG1HOFSTable,x
        inc x
        inc x
        ldy #$0000

        _F9F9
        sep #$20
        lda #$01
        sta aChapterIntroBG1HOFSTable,x
        rep #$20
        inc x
        lda <>aChapterIntroTitleSlideOffsets,b,y
        sta aChapterIntroBG1HOFSTable,x
        inc x
        inc x
        inc y
        inc y
        cpx #$004B
        bne _F9F9
        sep #$20
        lda #$00
        sta aChapterIntroBG1HOFSTable,x
        rep #$20
        inc x
        lda #$0000
        sta aChapterIntroBG1HOFSTable,x
        rtl

        .databank 0

        ; 91/FA27

    .endsection Unsorted91F9DDSection


    .section Table91FA27Section

      .al
      .xl

      aChapterIntroTitleSlideOffsets ; 91/FA27

        ; Read by rlFillChapterIntroBG1HOFSTable.
        ; Pairs of signed words; code follows at 91/FA57.

        .word $0027, $FFDC, $0030, $FFE4, $0036, $FFBA, $0025, $FFCD
        .word $003A, $FFC5, $002F, $FFBF, $0024, $FFD0, $0035, $FFCE
        .word $003E, $FFC2, $003A, $FFBC, $0032, $FFD3, $002E, $FFC5

        ; 91/FA57

    .endsection Table91FA27Section


    .section Unsorted91FA57Section

      .al
      .xl

      rsSlideChapterIntroTitle ; 91/FA57

        .al
        .xl
        .autsiz
        .databank ?

        lda wChapterIntroTitleSettled
        bne _FA99
        ldx #$0003

        _FA60
        inc x
        lda aChapterIntroBG1HOFSTable,x
        beq _FA6C
        dec a
        sta aChapterIntroBG1HOFSTable,x

        _FA6C
        inc x
        inc x
        inc x
        lda aChapterIntroBG1HOFSTable,x
        beq _FA7A
        inc a
        sta aChapterIntroBG1HOFSTable,x

        _FA7A
        inc x
        inc x
        cpx #$004B
        bne _FA60
        ldx #$0003

        _FA84
        inc x
        lda aChapterIntroBG1HOFSTable,x
        bne _FA99
        inc x
        inc x
        cpx #$004B
        bne _FA84
        lda #$0001
        sta wChapterIntroTitleSettled

        _FA99
        rts

        .databank 0

        ; 91/FA9A

    .endsection Unsorted91FA57Section


    .section Unsorted91FA9ASection

      .al
      .xl

      rsChapterIntroFadePaletteStep ; 91/FA9A

        .al
        .xl
        .autsiz
        .databank ?

        clc
        jsl rlFadePaletteToColors

          .byte $00, $D0, $20, $00, $80, $00

        rts

        .databank 0

        ; 91/FAA6

        ; Unused: 7 zero bytes.
        .fill 7, $00

    .endsection Unsorted91FA9ASection

