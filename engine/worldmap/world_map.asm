; The world map screen: its VBlank handler and setup (rsSetupWorldMapScreen, bank
; $80), and its game states (bank $8B): rlWorldMapSetup once, rlWorldMapUpkeep and
; rlWorldMapStep every frame. The steps (aWorldMapStepHandlers) fade in, run and
; fade out; each running frame (rlWorldMapRunFrame) handles Start, the portraits,
; the markers and the dialogue. Two IRQs fade the map's top and bottom edges and
; switch BG2 to the panel below it, and an HDMA table (rlWorldMapBuildLayersHDMATable)
; changes the layers shown down the screen. Events drive what the map shows.


    .section Unsorted80B347Section

      .al
      .xl

      rsWorldMapVBlank ; 80/B347

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; VBlank routine for World Map (OAM/DMA/HDMA/GameStates, BG1/BG3 scroll sync, map markers/sound)

        sep #$20
        lda #$80
        sta $2100,b
        rep #$20
        jsl rlUploadMapRowAndColumn
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
        lda wMapScrollXPixels,b
        sta wBufferBG1HOFS
        and #$000F
        sec
        sbc #$0008
        sta wBufferBG3HOFS
        lda wMapScrollYPixels,b
        sta wBufferBG1VOFS
        sta wBufferBG3VOFS
        jsl rlHideSprites
        jsl rlRunDialogueCycle
        jsl rlMapMenuVBlankUpload
        jsl rlUpdateSound
        rts

        .databank 0

        ; 80/B3A2

      rsSetupWorldMapScreen ; 80/B3A2

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; World Map main-loop setup: resets PPU/HDMA/dialogue, sets GameStates ($0E, $0D), calls rlInitWorldMapGraphics

        php
        sep #$20
        lda #$80
        sta bBufferINIDISP
        sta $2100,b
        rep #$20
        jsl rlDisableVBlank
        jsl rlHardwareResetScreenPosMathHDMA
        jsl rlHardwareResetScreenRegisters
        lda #$0000
        sta wR1
        lda #$3000
        sta wR2
        lda #$4000
        sta wR3
        sta wR4
        lda #$6000
        sta wR5
        lda #$5000
        sta wR6
        lda #$5400
        sta wR7
        lda #$5800
        sta wR8
        jsl rlSetLayerPositionsAndSizes
        jsl rlClearUnitWindowAndTerrainWindowProcs
        jsl rlActiveSpriteEngineReset
        jsl rlResetHDMAEngine
        jsl rlResetIRQEngine
        jsl rlResetRAMStructAndAreaVariables
        jsl rlInitMapMenus
        jsl rlResetMenuOptionStack
        jsl rlResetDialogueEngine
        lda #(`aWorldMapTopIRQInfo)<<8
        sta lR44+1
        lda #<>aWorldMapTopIRQInfo
        sta lR44
        jsl rlIRQEngineCreateEntry
        lda #(`aWorldMapBottomIRQInfo)<<8
        sta lR44+1
        lda #<>aWorldMapBottomIRQInfo
        sta lR44
        jsl rlIRQEngineCreateEntry
        jsl rlEnableIRQEngine
        lda #GAMESTATE_WORLD_MAP_SETUP
        sta wGameStateRoutine1,b
        lda #GAMESTATE_WORLD_MAP_UPKEEP
        sta wGameStateRoutine2,b
        stz wGameStateStep,b
        lda #<>rsWorldMapVBlank
        sta wVBlankPointer
        lda #<>rsRunFrameTasks
        sta wMainLoopPointer
        jsl rlInitWorldMapGraphics
        jsl rlPauseMapTileAnimation
        jsl rlEnableVBlank
        sep #$20
        lda #$00
        sta bBufferINIDISP
        rep #$20
        plp
        rts

        .databank 0

        ; 80/B452

      rlInitWorldMapGraphics ; 80/B452

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Clears VRAM $3000/$4000 and loads World Map gfx/tilemaps/palettes/windows/scroll bounds/HDMA

        phk
        plb
        .databank $80
        rep #$30
        lda #$1809
        sta $4300,b
        lda #$8000
        sta $4303,b
        lda #$B61D
        sta $4302,b
        lda #$2000
        sta $4305,b
        lda #$3000
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
        lda #$B61D
        sta $4302,b
        lda #$2000
        sta $4305,b
        lda #$4000
        sta $2116,b
        sep #$20
        lda #$01
        sta $420B,b
        rep #$20
        lda #$03FF
        sta wMapTileIDMask,b
        lda #$0002
        sta aDialogue.wMode,b
        lda #(`aDecompressionDMAEntry80B61E)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry80B61E
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        sep #$20
        rep #$10
        ldx #<>gcWorldMapTilemap
        stx DecompressionVariables
        lda #`gcWorldMapTilemap
        sta $CA
        ldx #$2400
        stx $CB
        lda #$7F
        sta $CD
        rep #$30
        jsl rlDecompressor
        sep #$20
        rep #$10
        ldx #<>gcWorldMapTileset
        stx DecompressionVariables
        lda #`gcWorldMapTileset
        sta $CA
        ldx #$0000
        stx $CB
        lda #$7F
        sta $CD
        rep #$30
        jsl rlDecompressor
        ldx #$07FE
        lda #$00FF

        _B500
        sta aBG2TilemapBuffer.Page1,x
        sta aBG3TilemapBuffer,x
        dec x
        dec x
        bpl _B500
        lda #(`aDecompressionDMAEntry80B626)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry80B626
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        jsl rlDMAByStruct

          .structDMAToVRAM $7E7B88, $0800, $80, $A800

        jsl rlDMAByStruct

          .structDMAToVRAM $7E7B88, $0800, $80, $9800

        jsl rlDMAByStruct

          .structDMAToVRAM gWorldMapDataD97940, $01C0, $80, $9D40

        lda #(`aDecompressionDMAEntry80B62E)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry80B62E
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        jsl rlDMAByStruct

          .structDMAToVRAM gWorldMapTilemap, $0800, $80, $B000

        lda #(`aDecompressionDMAEntry80B636)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry80B636
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        ldx #$01FE

        _B56D
        lda aWorldMapPartialBGPalettes,x
        sta aBGPaletteBuffer,b,x
        dec x
        dec x
        bpl _B56D
        lda #$0000
        sta aBGPaletteBuffer,b
        sep #$20
        lda #$08
        sta bBufferWH0
        lda #$F8
        sta bBufferWH1
        stz bBufferWH2
        stz bBufferWH3
        lda #$33
        sta bBufferW12SEL
        sta bBufferW34SEL
        lda #$11
        sta bBufferTM
        lda #$14
        sta bBufferTS
        lda bBufferBG1SC
        and #$FC
        sta bBufferBG1SC
        lda bBufferBG3SC
        and #$FC
        ora #$01
        sta bBufferBG3SC
        lda #$54
        sta bBufferBG2SC
        lda #$03
        sta bBufferWOBJSEL
        rep #$20
        sep #$20
        lda #$13
        sta bBufferTM
        sta bBufferTMW
        lda #$16
        sta bBufferTS
        sta bBufferTSW
        lda #$02
        sta bBufferCGWSEL
        lda #$81
        sta bBufferCGADSUB
        rep #$20
        lda wMapXOffset,b
        sta wMapScrollXPixels,b
        lda wMapYOffset,b
        sta wMapScrollYPixels,b
        lda #$0004
        sta wMapWidthMode,b
        sta $075E,b
        lda #$0000
        sta wMapMinXScroll,b
        sta wMapMinYScroll,b
        lda #$0400
        sec
        sbc #$0100
        sta wMapMaxXScroll,b
        lda #$0400
        sec
        sbc #$00E0
        sta wMapMaxYScroll,b
        lda #$0000
        sta wBufferBG2VOFS
        sta wBufferBG2VOFS
        stz wCastleSubMenuStep,b
        stz wMapScrollDirectionIdentifier,b
        jsl rlDrawVisibleMapToVRAM
        lda #(`aWorldMapLayersHDMAInfo)<<8
        sta lR44+1
        lda #<>aWorldMapLayersHDMAInfo
        sta lR44
        jsl rlHDMAEngineCreateEntry
        rtl

        .databank 0

        ; 80/B61C

        ; Unused: 2 zero bytes.
        .fill 2, $00

    .endsection Unsorted80B347Section


    .section Unsorted8B96CFSection

      .al
      .xl

      rlWorldMapUpkeep ; 8B/96CF

        .al
        .xl
        .autsiz
        .databank ?

        ; Game state routine $0D, every frame while the world map is up: copies the map scroll to the BG1 and BG3 scroll registers (BG3 X only by its low 4 bits, less 8).

        lda wMapScrollXPixels,b
        sta wBufferBG1HOFS
        and #$000F
        sec
        sbc #$0008
        sta wBufferBG3HOFS
        lda wMapScrollYPixels,b
        sta wBufferBG1VOFS
        sta wBufferBG3VOFS
        rtl

        .databank 0

        ; 8B/96E5

      rlWorldMapSetup ; 8B/96E5

        .al
        .xl
        .autsiz
        .databank ?

        ; Game state routine $0E, once: builds the RAM area at $7F5709, clears $7F4400-$7F5708, turns on active sprites and moves on to $0F at step 0.

        lda #$7F00
        sta lR18+1
        lda #$5709
        sta lR18
        lda #$A8F6
        jsl rlBuildRAMAreaHeaderAndGuidingEntry
        ldx #$1308
        lda #$0000

        _96FC
        sta $7F4400,x
        dec x
        bpl _96FC
        jsl rlEnableActiveSpriteEngine
        inc wGameStateRoutine1,b
        stz wGameStateStep,b
        stz wEpilogueRecordCharacter,b
        lda #$0001
        sta wNextMenuState,b
        rtl

        .databank 0

        ; 8B/9717

      rlWorldMapStep ; 8B/9717

        .al
        .xl
        .autsiz
        .databank ?

        ; Game state routine $0F, every frame: runs the routine for wGameStateStep from aWorldMapStepHandlers.

        phb
        php
        phk
        plb
        .databank $8B
        lda wGameStateStep,b
        asl a
        tax
        jsr (aWorldMapStepHandlers,x)
        plp
        plb
        .databank $8B
        rtl

        .databank 0

        ; 8B/9726

    .endsection Unsorted8B96CFSection


    .section Table8B9726Section

      .al
      .xl

      aWorldMapStepHandlers ; 8B/9726

        ; Jump table of rlWorldMapStep.
        .word <>rsWorldMapStepFadeIn
        .word <>rsWorldMapStepRun
        .word <>rsWorldMapStepFadeOut

    .endsection Table8B9726Section


    .section Unsorted8B9759Section

      .al
      .xl

      rsWorldMapStepFadeIn ; 8B/9759

        .al
        .xl
        .autsiz
        .databank ?

        ; Step 0: raises the brightness by one every 8 frames, running the frame (rlWorldMapRunFrame); at full brightness goes to step wNextMenuState.

        lda wVBlankEnabledFramecount
        and #$0007
        bne _976C
        sep #$20
        lda bBufferINIDISP
        and #$0F
        cmp #$0F
        beq _9773
        inc bBufferINIDISP

        _976C
        rep #$20
        jsl rlWorldMapRunFrame
        rts


        _9773
        .as
        rep #$20
        lda wNextMenuState,b
        sta wGameStateStep,b
        bra _976C

        .databank 0

        ; 8B/977D

    .endsection Unsorted8B9759Section


    .section Unsorted8B972CSection

      .al
      .xl

      rsWorldMapStepRun ; 8B/972C

        .al
        .xl
        .autsiz
        .databank ?

        ; Step 1: runs the frame (rlWorldMapRunFrame). In the epilogue (wCurrentChapter $FFFF) counts the frames in wEpilogueRecordCharacter, which the epilogue's world map ASMCs compare.

        jsl rlWorldMapRunFrame
        lda wCurrentChapter,b
        cmp #$FFFF
        bne _973B
        inc wEpilogueRecordCharacter,b

        _973B
        rts

        .databank 0

        ; 8B/973C

    .endsection Unsorted8B972CSection


    .section Unsorted8B973CSection

      .al
      .xl

      rsWorldMapStepFadeOut ; 8B/973C

        .al
        .xl
        .autsiz
        .databank ?

        ; Step 2: lowers the brightness by one every 8 frames; at black goes to step wNextMenuState.

        lda wVBlankEnabledFramecount
        and #$0007
        bne _974D
        sep #$20
        lda bBufferINIDISP
        and #$0F
        beq _9750
        dec bBufferINIDISP

        _974D
        rep #$20
        rts


        _9750
        .as
        rep #$20
        lda wNextMenuState,b
        sta wGameStateStep,b
        rts

        .databank 0

        ; 8B/9759

    .endsection Unsorted8B973CSection


    .section Unsorted8B8000Section

      .al
      .xl

      rlWorldMapRunFrame ; 8B/8000

        .al
        .autsiz
        .databank ?

        ; World map steps 0 and 1, every frame. Start (outside the epilogue, where wCurrentChapter is $FFFF) fades out to the chapter intro unless a fade proc is running. Runs the portraits and markers, shows the dialogue's A-press arrows and uploads its text, and cycles two sprite colours (rsCycleWorldMapSpriteColors).

        lda #(`procMainLoopChangeFadeByTimer)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFadeByTimer
        sta lR44
        jsl rlProcEngineFindProc
        bcs +

          lda wCurrentChapter,b
          cmp #$FFFF
          beq +

            lda wJoy1New
            cmp #JOY_Start
            bne +

              lda #2
              sta wScreenFadingProcInput,b

              lda #<>rsOpenChapterIntroScreen
              sta aProcSystem.wInput0,b

              lda #(`procMainLoopChangeFadeByTimer)<<8
              sta lR44+1
              lda #<>procMainLoopChangeFadeByTimer
              sta lR44
              jsl rlProcEngineCreateProc

              lda #2
              sta wEventEngineState,b
              jsl rlClearDialogueStatusAndTimers

        +
        jsr rsHandleWorldMapPortraits
        jsr rsHandleWorldMapMarkers

        lda aDialogue.wStatus,b
        beq +

          lda #$00E2
          sta wR0
          lda #$00C4
          sta wR1
          jsl rlDisplayDialogueAPressArrows

          jsl rlDMAByStruct

            .structDMAToVRAM $7E8908, $0140, $80, $BD80

        +
        jsr rsCycleWorldMapSpriteColors
        rtl

        .databank 0

        ; 8B/806D

    .endsection Unsorted8B8000Section


    .section WorldMapSpriteColorsSection

      .al
      .xl

      rsCycleWorldMapSpriteColors ; 8B/8114

        .al
        .xl
        .autsiz
        .databank ?

        ; Sets colour 5 of sprite palettes 1 and 2 from aWorldMapSpriteColorCycle1 and 2: a 16-step loop that moves every 4 frames, from orange to pale yellow and back.

        lda wVBlankEnabledFramecount
        and #$003C
        lsr a
        tax
        lda aWorldMapSpriteColorCycle1,x
        sta aOAMPaletteBuffer.aPalette1.Colors[5],b
        lda aWorldMapSpriteColorCycle2,x
        sta aOAMPaletteBuffer.aPalette2.Colors[5],b
        rts

        .databank 0

        ; 8B/812A

    .endsection WorldMapSpriteColorsSection


    .section Unreferenced8B812ASection

      .al
      .xl

      rsCycleWorldMapSpritePalettesUnused ; 8B/812A

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda aWorldMapSpriteColorCycle1,x
        sta $022C,b
        lda aWorldMapSpriteColorCycle2,x
        sta $024C,b
        txa
        inc a
        inc a
        and #$000E
        tax
        lda aWorldMapSpriteColorCycle1,x
        sta $022E,b
        lda aWorldMapSpriteColorCycle2,x
        sta $024E,b
        txa
        inc a
        inc a
        and #$000E
        tax
        lda aWorldMapSpriteColorCycle1,x
        sta $0230,b
        lda aWorldMapSpriteColorCycle2,x
        sta $0250,b
        txa
        inc a
        inc a
        and #$000E
        tax
        lda aWorldMapSpriteColorCycle1,x
        sta $0232,b
        lda aWorldMapSpriteColorCycle2,x
        sta $0252,b
        txa
        inc a
        inc a
        and #$000E
        tax
        lda aWorldMapSpriteColorCycle1,x
        sta $0234,b
        lda aWorldMapSpriteColorCycle2,x
        sta $0254,b
        rts

        .databank 0

        ; 8B/818D

    .endsection Unreferenced8B812ASection
    .section Table8CDE00Section

      .al
      .xl

      aWorldMapSpriteColorCycle1 ; 8C/DE00

        ; Read by rsCycleWorldMapSpriteColors.

        .word $031F, $133F, $235F, $337F, $3F7F, $4F9F, $5FBF, $6FDF
        .word $6FDF, $5FBF, $4F9F, $3F7F, $337F, $235F, $133F, $031F

        ; 8C/DE20

    .endsection Table8CDE00Section


    .section Data8CDE20Section

      .al
      .xl

      aWorldMapSpriteColorCycle2 ; 8C/DE20

        ; Read by rsCycleWorldMapSpriteColors, which reads only the first 16 words;
        ; the six copies after them are not read by anything.

        .word $031F, $133F, $235F, $337F, $3F7F, $4F9F, $5FBF, $6FDF
        .word $6FDF, $5FBF, $4F9F, $3F7F, $337F, $235F, $133F, $031F
        .word $031F, $133F, $235F, $337F, $3F7F, $4F9F, $5FBF, $6FDF
        .word $6FDF, $5FBF, $4F9F, $3F7F, $337F, $235F, $133F, $031F
        .word $031F, $133F, $235F, $337F, $3F7F, $4F9F, $5FBF, $6FDF
        .word $6FDF, $5FBF, $4F9F, $3F7F, $337F, $235F, $133F, $031F
        .word $031F, $133F, $235F, $337F, $3F7F, $4F9F, $5FBF, $6FDF
        .word $6FDF, $5FBF, $4F9F, $3F7F, $337F, $235F, $133F, $031F
        .word $031F, $133F, $235F, $337F, $3F7F, $4F9F, $5FBF, $6FDF
        .word $6FDF, $5FBF, $4F9F, $3F7F, $337F, $235F, $133F, $031F
        .word $031F, $133F, $235F, $337F, $3F7F, $4F9F, $5FBF, $6FDF
        .word $6FDF, $5FBF, $4F9F, $3F7F, $337F, $235F, $133F, $031F
        .word $031F, $133F, $235F, $337F, $3F7F, $4F9F, $5FBF, $6FDF
        .word $6FDF, $5FBF, $4F9F, $3F7F, $337F, $235F, $133F, $031F

        ; 8C/DF00

    .endsection Data8CDE20Section


    .section Table8B9449Section

      .al
      .xl

      aWorldMapTopIRQInfo ; 8B/9449
        .word $00A0, $0000, <>rlWorldMapTopIRQ, <>aWorldMapTopIRQCode

    .endsection Table8B9449Section


    .section Unsorted8B9451Section

      .al
      .xl

      rlWorldMapTopIRQ ; 8B/9451

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlWorldMapTopEdgeFadeIn
        rtl

        .databank 0

        ; 8B/9456


      aWorldMapTopIRQCode ; 8B/9456
        .word <>rsIRQCodeHalt

    .endsection Unsorted8B9451Section


    .section Unsorted8B9458Section

      .al
      .xl

      rlWorldMapTopEdgeFadeIn ; 8B/9458

        .al
        .xl
        .autsiz
        .databank ?

        ; IRQ at line 0: switches BG2 to the tilemap at $5400 with the map's scroll, then raises the brightness over the next 8 lines (2, 4, ... 15, never above bBufferINIDISP), so the map's top edge fades in from black. Does nothing during forced blank.

        sep #$20
        lda bBufferINIDISP
        bpl _9462
        jml _9591


        _9462
        lda $4212,b
        bit #$40
        beq _9462
        lda #$00
        sta $2100,b
        lda #$80
        sta $2100,b
        lda #$54
        sta $2108,b
        lda wBufferBG2HOFS
        sta $210F,b
        lda wBufferBG2HOFS+1
        sta $210F,b
        lda wBufferBG2VOFS
        sec
        sbc #$01
        sta $2110,b
        lda wBufferBG2VOFS+1
        sbc #$00
        sta $2110,b

        _9491
        lda $4212,b
        bit #$40
        bne _9491

        _9498
        lda $4212,b
        bit #$40
        beq _9498
        lda #$02
        cmp @l bBufferINIDISP
        bcc _94AB
        lda @l bBufferINIDISP

        _94AB
        sta $2100,b

        _94AE
        lda $4212,b
        bit #$40
        bne _94AE

        _94B5
        lda $4212,b
        bit #$40
        beq _94B5
        lda #$04
        cmp @l bBufferINIDISP
        bcc _94C8
        lda @l bBufferINIDISP

        _94C8
        sta $2100,b

        _94CB
        lda $4212,b
        bit #$40
        bne _94CB

        _94D2
        lda $4212,b
        bit #$40
        beq _94D2
        lda #$06
        cmp @l bBufferINIDISP
        bcc _94E5
        lda @l bBufferINIDISP

        _94E5
        sta $2100,b

        _94E8
        lda $4212,b
        bit #$40
        bne _94E8

        _94EF
        lda $4212,b
        bit #$40
        beq _94EF
        lda #$08
        cmp @l bBufferINIDISP
        bcc _9502
        lda @l bBufferINIDISP

        _9502
        sta $2100,b

        _9505
        lda $4212,b
        bit #$40
        bne _9505

        _950C
        lda $4212,b
        bit #$40
        beq _950C
        lda #$0A
        cmp @l bBufferINIDISP
        bcc _951F
        lda @l bBufferINIDISP

        _951F
        sta $2100,b

        _9522
        lda $4212,b
        bit #$40
        bne _9522

        _9529
        lda $4212,b
        bit #$40
        beq _9529
        lda #$0C
        cmp @l bBufferINIDISP
        bcc _953C
        lda @l bBufferINIDISP

        _953C
        sta $2100,b

        _953F
        lda $4212,b
        bit #$40
        bne _953F

        _9546
        lda $4212,b
        bit #$40
        beq _9546
        lda #$0E
        cmp @l bBufferINIDISP
        bcc _9559
        lda @l bBufferINIDISP

        _9559
        sta $2100,b

        _955C
        lda $4212,b
        bit #$40
        bne _955C

        _9563
        lda $4212,b
        bit #$40
        beq _9563
        lda #$0F
        cmp @l bBufferINIDISP
        bcc _9576
        lda @l bBufferINIDISP

        _9576
        sta $2100,b

        _9579
        lda $4212,b
        bit #$40
        beq _9579
        lda bBufferINIDISP
        lda #$0F
        cmp @l bBufferINIDISP
        bcc _958E
        lda @l bBufferINIDISP

        _958E
        sta $2100,b

        _9591
        rep #$20
        rtl

        .databank 0

        ; 8B/9594

    .endsection Unsorted8B9458Section


    .section Table8B9594Section

      .al
      .xl

      aWorldMapBottomIRQInfo ; 8B/9594
        .word $0060, $00A0, <>rlWorldMapBottomIRQ, <>aWorldMapBottomIRQCode

    .endsection Table8B9594Section


    .section Unsorted8B959CSection

      .al
      .xl

      rlWorldMapBottomIRQ ; 8B/959C

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlWorldMapBottomEdgeFadeOut
        rtl

        .databank 0

        ; 8B/95A1


      aWorldMapBottomIRQCode ; 8B/95A1
        .word <>rsIRQCodeHalt

    .endsection Unsorted8B959CSection


    .section Unsorted8B95A3Section

      .al
      .xl

      rlWorldMapBottomEdgeFadeOut ; 8B/95A3

        .al
        .xl
        .autsiz
        .databank ?

        ; IRQ at line 160: lowers the brightness to black over 8 lines, then switches BG2 to the tilemap at $4C00, unscrolled, at full brightness for the panel below the map.

        sep #$20
        lda bBufferINIDISP
        bpl _95AD
        jml _96CC


        _95AD
        lda $4212,b
        bit #$40
        beq _95AD
        lda #$0F
        lda @l bBufferINIDISP
        sta $2100,b

        _95BD
        lda $4212,b
        bit #$40
        bne _95BD

        _95C4
        lda $4212,b
        bit #$40
        beq _95C4
        lda #$0E
        cmp @l bBufferINIDISP
        bcc _95D7
        lda @l bBufferINIDISP

        _95D7
        sta $2100,b

        _95DA
        lda $4212,b
        bit #$40
        bne _95DA

        _95E1
        lda $4212,b
        bit #$40
        beq _95E1
        lda #$0C
        cmp @l bBufferINIDISP
        bcc _95F4
        lda @l bBufferINIDISP

        _95F4
        sta $2100,b

        _95F7
        lda $4212,b
        bit #$40
        bne _95F7

        _95FE
        lda $4212,b
        bit #$40
        beq _95FE
        lda #$0A
        cmp @l bBufferINIDISP
        bcc _9611
        lda @l bBufferINIDISP

        _9611
        sta $2100,b

        _9614
        lda $4212,b
        bit #$40
        bne _9614

        _961B
        lda $4212,b
        bit #$40
        beq _961B
        lda #$08
        cmp @l bBufferINIDISP
        bcc _962E
        lda @l bBufferINIDISP

        _962E
        sta $2100,b

        _9631
        lda $4212,b
        bit #$40
        bne _9631

        _9638
        lda $4212,b
        bit #$40
        beq _9638
        lda #$06
        cmp @l bBufferINIDISP
        bcc _964B
        lda @l bBufferINIDISP

        _964B
        sta $2100,b

        _964E
        lda $4212,b
        bit #$40
        bne _964E

        _9655
        lda $4212,b
        bit #$40
        beq _9655
        lda #$04
        cmp @l bBufferINIDISP
        bcc _9668
        lda @l bBufferINIDISP

        _9668
        sta $2100,b

        _966B
        lda $4212,b
        bit #$40
        bne _966B

        _9672
        lda $4212,b
        bit #$40
        beq _9672
        lda #$02
        cmp @l bBufferINIDISP
        bcc _9685
        lda @l bBufferINIDISP

        _9685
        sta $2100,b

        _9688
        lda $4212,b
        bit #$40
        bne _9688

        _968F
        lda $4212,b
        bit #$40
        beq _968F
        lda #$80
        sta $2100,b
        lda #$4C
        sta $2108,b
        lda #$00
        sta $210F,b
        lda #$00
        sta $210F,b
        lda #$FF
        sta $2110,b
        lda #$FF
        sta $2110,b

        _96B4
        lda $4212,b
        bit #$40
        beq _96B4
        lda bBufferINIDISP
        lda #$0F
        cmp @l bBufferINIDISP
        bcc _96C9
        lda @l bBufferINIDISP

        _96C9
        sta $2100,b

        _96CC
        rep #$20
        rtl

        .databank 0

        ; 8B/96CF

    .endsection Unsorted8B95A3Section


    .section Table8B911FSection

      .al
      .xl

      aWorldMapLayersHDMAInfo .dstruct structHDMADirectEntryInfo, rlWorldMapBuildLayersHDMATable, rlWorldMapBuildLayersHDMATable, aWorldMapLayersHDMACode, $0008BC, PPU_REG_BASE + $2C, $00 ; 8B/911F

    .endsection Table8B911FSection


    .section Unsorted8B912ASection

      .al
      .xl

      rlWorldMapBuildLayersHDMATable ; 8B/912A

        .al
        .xl
        .autsiz
        .databank ?

        ; Writes the HDMA table at $0008BC that changes the main screen layers (TM) down the screen: nothing on line 0, the usual layers to line 168, BG2 alone for 8 lines, then 32 lines of BG2 and sprites, with BG3 (the text) too if a dialogue was up last frame (wWorldMapLayersDialogueStatus), then BG2 and sprites.

        lda wWorldMapLayersDialogueStatus
        bne _9134
        jml rlWorldMapLayersHDMATableNoText


        _9134
        lda aDialogue.wStatus,b
        sta wWorldMapLayersDialogueStatus
        sep #$20
        lda #$01
        sta @l $0008BC
        lda #$00
        sta @l $0008BD
        lda #$7F
        sta @l $0008BE
        lda bBufferTM
        sta @l $0008BF
        lda #$28
        sta @l $0008C0
        lda bBufferTM
        sta @l $0008C1
        lda #$08
        sta @l $0008C2
        lda #$02
        sta @l $0008C3
        lda #$20
        sta @l $0008C4
        lda #$16
        sta @l $0008C5
        lda #$08
        sta @l $0008C6
        lda #$12
        sta @l $0008C7
        lda #$00
        sta @l $0008C8
        lda #$00
        sta @l $0008C9
        rep #$20
        rtl

      aWorldMapLayersHDMACode ; 8B/9194

        HDMA_HALT


      rlWorldMapLayersHDMATableNoText ; 8B/9196
        lda aDialogue.wStatus,b
        sta wWorldMapLayersDialogueStatus
        sep #$20
        lda #$01
        sta @l $0008BC
        lda #$00
        sta @l $0008BD
        lda #$7F
        sta @l $0008BE
        lda bBufferTM
        sta @l $0008BF
        lda #$28
        sta @l $0008C0
        lda bBufferTM
        sta @l $0008C1
        lda #$08
        sta @l $0008C2
        lda #$02
        sta @l $0008C3
        lda #$20
        sta @l $0008C4
        lda #$12
        sta @l $0008C5
        lda #$08
        sta @l $0008C6
        lda #$12
        sta @l $0008C7
        lda #$00
        sta @l $0008C8
        lda #$00
        sta @l $0008C9
        rep #$20
        rtl

        .databank 0

        ; 8B/91F6

    .endsection Unsorted8B912ASection
