; Chapter title/intro screen setup, graphics/DMA dispatch, and scroll HDMA entries.


    .section Unsorted80F2BESection

      .al
      .xl

      rsOpenChapterIntroScreen ; 80/F2BE

        .al
        .autsiz
        .databank ?

        ; Opens chapter title/intro display (state 5/4, step $24, calls HDMA/gfx/BG setup)

        ; Transition from WM to map?

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
        jsl rlUnknown8780AA
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

    .endsection Unsorted80F2BESection


    .section Unsorted80F340Section

      .al
      .xl

      rsCreateChapterIntroHDMA ; 80/F340

        .al
        .xl
        .autsiz
        .databank ?

        ; Zeroes $7F8183/85/8B and creates curved BG2VOFS and BG1HOFS HDMA entries

        lda #$0000
        sta $7F8183
        sta $7F8185
        sta $7F818B
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

        ; HDMA init forwarding to rlUnknown91F959

        jsl rlUnknown91F959
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

        ; HDMA init forwarding to rlUnknown91F9DD

        jsl rlUnknown91F9DD
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

        ; Loads aChapterIntroAndUIBGPalettes, decompresses gcUnknownDD629E, dispatches wCurrentChapter via aChapterIntroTitleDMATable

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

        lda #(`gcUnknownDD629E)<<8
        sta lR18+1
        lda #<>gcUnknownDD629E
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


    .section Unsorted80F443Section

      .al
      .xl

      rsDMAPrologueTitleGraphic ; 80/F443

        .al
        .xl
        .autsiz
        .databank ?

        ; DMAs $C0 bytes of Prologue title tilemap ($7E8B88) to VRAM $A300

        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $00C0, $80, $A300

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


