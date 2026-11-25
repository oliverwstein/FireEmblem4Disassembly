; The chapter map's frame: its VBlank routine (rsMapVBlank) and main loop
; (rsMapMainLoop), starting a chapter (rsStartChapterMap), and returning to the map
; from another screen (rsReturnToMapMainLoop) with the setup both share: resetting
; the map's graphics and engines, the row-upload IRQ, the map's main loop and VBlank.

    .section MapVBlankAndStartSection

      .al
      .xl

      rsMapVBlank ; 80/AE68

        .al
        .xl
        .autsiz
        .databank ?

        ; VBlank routine for chapter map and Game Over (OAM/DMA/HDMA/animated tiles/map sprites/GameStates/sound)

        php
        sep #$20
        lda #$80
        sta $2100,b
        rep #$20
        jsl rlDMAPaletteAndOAMBuffer
        lda wChapterFlags,b
        bit #$0200
        bne _AE92
        lda bDMAArrayFlag,b
        and #$00FF
        bne _AE92
        lda #$0008
        trb wChapterFlags,b
        jsl rlUploadMapAnimations
        bra _AE98


        _AE92
        lda #$0008
        tsb wChapterFlags,b

        _AE98
        jsl rlProcessDMAStructArray
        jsl rlHandlePossibleHDMA
        jsl rlCopyPPURegisterBuffer
        jsl rlSendSoundQueuesToAPU
        jsl rlGetJoypadInput
        jsl rlIncreaseFrameCounters
        jsl rlIRQEngineSyncAndSort
        lda bAIEngineFlags,b
        bit #$0010
        bne _AEC0
        jsl rlClearSpriteExtBuffer

        _AEC0
        jsl rlRunGameStateRoutines
        jsl rlRunVBlankHooks
        jsl rlRedrawDialogueBoxTilemaps
        jsl rlRunMapMenuUploadIfEnabled
        lda bAIEngineFlags,b
        bit #$0010
        bne _AEE4
        jsl rlDrawMovingUnitSprite
        jsl rlDrawDeployedUnitMapSprites
        jsl rlHideSprites

        _AEE4
        jsl rlUpdateSound
        plp
        rts

        .databank 0

        ; 80/AEEA

      rsStartChapterMap ; 80/AEEA

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        ; Main-loop setup for starting or resuming a chapter (events, units, HUD, GameState $11/$00)

        php
        sei
        sep #$20
        lda #$80
        sta bBufferINIDISP
        sta $2100,b
        rep #$20
        jsl rlDisableVBlank
        jsr rsResetMapGraphicsAndSystems
        jsl rlProcEngineResetProcEngine
        jsl rlCheckCodeChecksumsCopy88._806A
        lda wCurrentChapter,b
        jsl rlSetChapterEventDataPointerByID
        jsl rlApplySoundOption
        lda wChapterFlags,b
        bit #$0100
        bne _AF33
        jsl rlResetUnitsForChapter
        lda wCurrentChapter,b
        jsl rlStartChapterEvents
        stz wCurrentTurn,b
        stz wSavedMapStep,b
        sep #$20
        stz wAreaRestrictionBitfield,b
        rep #$20
        bra _AF4C


        _AF33
        stz wPhaseSongID,b
        jsl rlRefreshChapterEventPointers
        lda #$0007
        sta wSavedMapStep,b
        jsl rlStartPhaseMusic
        jsl rlStepMusicScript
        jsl rlApplyAllActiveMapChanges

        _AF4C
        jsl rlUploadAllStandingMapSprites
        jsl rlUpdateAllLocationEvents
        jsl rlSetUpChapterMapDisplay
        jsl rlLoadWindowGraphics
        jsr rsLoadMapMenuAndFontGraphics
        jsr rsInitMapWindowRegisters
        jsr rsSetupMapRowUploadIRQ
        jsr rsSetMapMainLoopAndVBlank
        lda #GAMESTATE_MAP_SETUP
        sta wGameStateRoutine1,b
        stz wGameStateStep,b
        lda wChapterFlags,b
        bit #$0020
        beq _AF89
        stz wGameStateRoutine1,b
        lda #$0000
        jsl rlEnterCastleAtLocation
        lda #$0004
        tsb wMapSystemFlags,b

        _AF89
        jsl rlEnableVBlank
        sep #$20
        lda #$00
        sta bBufferINIDISP
        sta $2100,b
        rep #$20
        plp
        cli
        rts

        .databank 0

        ; 80/AF9B

    .endsection MapVBlankAndStartSection


    .section Unsorted80AF9BSection

      .al
      .xl

      rsResetMapGraphicsAndSystems ; 80/AF9B

        .al
        .autsiz
        .databank ?

        ; Resets screen registers, BG2/BG3 tilemaps, map window buffers, OAM, sprites, HDMA, IRQ, and map menus

        jsl rlHardwareResetScreenPosMathHDMA
        jsl rlHardwareResetScreenRegisters
        lda #0
        jsl rlFillBG2Page0TilemapBuffer
        lda #$030F
        jsl rlFillBG2Page1TilemapBuffer
        lda #$00FF
        jsl rlFillBG3Page0TilemapBuffer

        ldx #$067E
        lda #0

          -
          sta aMapWindowFrameBuffer,x
          sta aMapWindowTextBuffer,x
          dec x
          dec x
          bpl -

        lda #$0000 >> 1
        sta wR1
        sta wR2
        lda #$8000 >> 1
        sta wR3
        sta wR4
        lda #$C000 >> 1
        sta wR5
        lda #$A000 >> 1
        sta wR6
        lda #$A800 >> 1
        sta wR7
        lda #$B000 >> 1
        sta wR8
        jsl rlSetLayerPositionsAndSizes

        jsl rlClearSpriteExtBuffer
        jsl rlHideSprites
        jsl rlDMAPaletteAndOAMBuffer
        jsl rlDMAByStruct
          .structDMAToVRAM aBG2TilemapBuffer.Page1, $0800, $80, $A800

        jsl rlDMAByStruct
          .structDMAToVRAM aBG3TilemapBuffer.Page0, $0800, $80, $B000

        jsl rlClearUnitWindowAndTerrainWindowProcs
        jsl rlActiveSpriteEngineReset
        jsl rlEnableActiveSpriteEngine
        jsl rlResetHDMAEngine
        jsl rlResetIRQEngine
        jsl rlResetRAMStructAndAreaVariables
        jsl rlInitMapMenus
        jsl rlResetMenuOptionStack
        lda #$00FF
        sta wMapMenuTransparentTile,b
        jsl rlEnableMapMenuUploads
        rts

        .databank 0

        ; 80/B041

    .endsection Unsorted80AF9BSection


    .section Unsorted80B041Section

      .as
      .xl

      rsSetMapMainLoopAndVBlank ; 80/B041

        .al
        .xl
        .autsiz
        .databank ?

        ; Sets wGameStateRoutine2 to GAMESTATE_MAP_UPKEEP and installs rsMapVBlank and rsMapMainLoop

        lda #GAMESTATE_MAP_UPKEEP
        sta wGameStateRoutine2,b
        lda #<>rsMapVBlank
        sta wVBlankPointer
        lda #<>rsMapMainLoop
        sta wMainLoopPointer
        rts

        .databank 0

        ; 80/B052

      rsSetupMapRowUploadIRQ ; 80/B052

        .al
        .xl
        .autsiz
        .databank ?

        ; Installs aMapRowUploadIRQ

        lda #(`aMapRowUploadIRQ)<<8
        sta lR44+1
        lda #<>aMapRowUploadIRQ
        sta lR44
        jsl rlIRQEngineCreateEntry
        jsl rlEnableIRQEngine
        rts

        .databank 0

        ; 80/B065

      rsLoadMapMenuAndFontGraphics ; 80/B065

        .al
        .xl
        .autsiz
        .databank ?

        ; Decompresses map menu graphics and loads menu font, icons, and default border palette

        jsl rlLoadMapMenuDecompression80B09B
        lda #(`aDecompressionDMAEntry80B084)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry80B084
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        jsl rlLoadMenuFontGraphics
        jsl rlLoadMenuIconGraphics
        jsl rlLoadDefaultWindowBorderPalette
        rts

        .databank 0

        ; 80/B084

    .endsection Unsorted80B041Section


    .section Unsorted80B08CSection

      .al
      .xl

      rlLoadMapMenuDecompression80B09B ; 80/B08C

        .al
        .xl
        .autsiz
        .databank ?

        ; Runs rlHandleMapMenuDecompressionDMA for aDecompressionDMAEntry80B09B

        lda #(`aDecompressionDMAEntry80B09B)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry80B09B
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        rtl

        .databank 0

        ; 80/B09B

    .endsection Unsorted80B08CSection


    .section Unsorted80B105Section

      .al
      .xl

      rsInitMapWindowRegisters ; 80/B105

        .al
        .xl
        .autsiz
        .databank ?

        ; Initializes map windowing registers (TMW, WH0, WH1, W12SEL, W34SEL, TM)

        sep #$20
        lda #$17
        sta bBufferTMW
        lda #$08
        sta bBufferWH0
        lda #$F7
        sta bBufferWH1
        lda #$33
        sta bBufferW12SEL
        lda #$03
        sta bBufferW34SEL
        lda #$15
        sta bBufferTM
        rep #$20
        rts

        .databank 0

        ; 80/B122

    .endsection Unsorted80B105Section


    .section Unsorted80B122Section

      .al
      .xl

      rsReturnToMapMainLoop ; 80/B122

        .al
        .autsiz
        .databank ?

        ; Main loop routine that resets map graphics/systems, reloads map display, and resumes GAMESTATE_MAP_STEP

        ; a MainLoop routine

        php
        sei
        sep #$20
        lda #INIDISP_Setting(true, 0)
        sta bBufferINIDISP
        sta INIDISP,b
        rep #$20

        jsl rlDisableVBlank
        jsr rsResetMapGraphicsAndSystems
        jsr rsSetupMapDisplayByGameMode
        jsl rlLoadWindowGraphics
        jsr rsLoadMapMenuAndFontGraphics
        jsr rsInitMapWindowRegisters
        jsr rsSetupMapRowUploadIRQ
        jsr rsSetMapMainLoopAndVBlank

        lda #GAMESTATE_MAP_STEP
        sta wGameStateRoutine1,b
        lda wSavedMapStep,b
        sta wGameStateStep,b
        jsr rsResumeMapAfterMenu

        sep #$20
        lda #INIDISP_Setting(false, 0)
        sta bBufferINIDISP
        sta INIDISP,b
        rep #$20

        jsl rlEnableVBlank
        plp
        cli
        rts

        .databank 0

      rsSetupMapDisplayByGameMode ; 80/B16A

        .al
        .autsiz
        .databank ?

        ; Dispatches chapter map display setup by wMainGameMode (0-3)

        lda wMainGameMode,b
        asl a
        tax
        jmp (+,x)

        +
        .addr rsSetupChapterMapDisplayMode0
        .addr rsSetupChapterMapDisplayMode1
        .addr rsReloadChapterMapDisplay
        .addr rsReloadChapterMapDisplay

        .databank 0

      rsSetupChapterMapDisplayMode0 ; 80/B17A

        .al
        .autsiz
        .databank ?

        ; Calls rlSetUpChapterMapDisplay

        jsl rlSetUpChapterMapDisplay
        rts

        .databank 0

      rsSetupChapterMapDisplayMode1 ; 80/B17F

        .al
        .autsiz
        .databank ?

        ; Calls rlSetUpChapterMapDisplayAllFrames

        jsl rlSetUpChapterMapDisplayAllFrames
        rts

        .databank 0

      rsReloadChapterMapDisplay ; 80/B184

        .al
        .autsiz
        .databank ?

        ; Loads chapter map layout, updates location events, applies active map changes, and sets up map display

        jsl rlLoadChapterMapLayout
        jsl rlUpdateAllLocationEvents
        jsl rlApplyAllActiveMapChanges
        jsl rlSetUpChapterMapDisplay
        rts

        .databank 0

      rsResumeMapAfterMenu ; 80/B195

        .al
        .autsiz
        .databank ?

        ; Rebuilds map menu RAM area, runs upload, and handles defeated-unit/victory/phase music on return to map

        lda #$0020
        trb wChapterFlags,b

        lda #(`aMapMenuRAMArea)<<8
        sta lR18+1
        lda #<>aMapMenuRAMArea
        sta lR18
        lda #1
        sta wStructIndex,b
        lda #size(aMapMenuRAMArea)
        jsl rlBuildRAMAreaHeaderAndGuidingEntry

        lda #11
        sta wGameStateStep,b
        jsl rlRunMapMenuUploadIfEnabled

        lda wMainGameMode,b
        cmp #2
        bcc _End

          jsl rlHandleDefeatedUnit
          bcc +

            jsl rlGetVictoryThemeIfAllEnemiesDead
            bcc +

              sta wPhaseSongID,b

          +
          lda wEventEngineFlags,b
          bne _End

            jsl rlResumePhaseMusic
            jsl rlStepMusicScript

        _End
        rts

        .databank 0

        ; 80/B1E1

    .endsection Unsorted80B122Section


    .section MapMainLoopSection

      .al
      .xl

      rsMapMainLoop ; 80/B301

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Per-frame main loop for map and Game Over (reset combo, decomp list, AI cycle, deferred sound, moving sprites)

        jsl rlButtonCombinationResetCheck
        jsl rlDecompressByList
        jsl rlRunAIEngineCycle
        jsl rlRunDeferredSoundUpload
        jsl rlPlanQueuedMapSpriteMovement
        rts

        .databank 0

        ; 80/B316

    .endsection MapMainLoopSection


    .section Unreferenced80B316Section

      .al
      .xl

      rsPauseMapProcsAndHDMAUnused ; 80/B316

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$0200
        tsb wChapterFlags,b
        ldx #$001E

        _B320
        lda aProcSystem.aHeaderName,b,x
        cmp #$4F4E
        bne _B331
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$1000
        sta aProcSystem.aHeaderBitfield,b,x

        _B331
        dec x
        dec x
        bpl _B320
        ldx #$000E

        _B338
        lda aHDMASystem.aBitfield,b,x
        ora #$1000
        sta aHDMASystem.aBitfield,b,x
        dec x
        dec x
        bpl _B338
        plx
        rts

        .databank 0

        ; 80/B347

    .endsection Unreferenced80B316Section
