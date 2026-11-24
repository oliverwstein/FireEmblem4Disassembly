; Chapter map VBlank handler, per-frame main loop, and chapter map initialization.

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
        jsl rlUnknown82E147
        lda bUnknown000E7B,b
        bit #$0010
        bne _AEC0
        jsl rlClearSpriteExtBuffer

        _AEC0
        jsl rlRunGameStateRoutines
        jsl rlRunVBlankHooks
        jsl rlRedrawDialogueBoxTilemaps
        jsl rlUnknown858728
        lda bUnknown000E7B,b
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
        jsr rsUnknown80AF9B
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
        jsl rlUnknown86C629

        _AF4C
        jsl rlUploadAllStandingMapSprites
        jsl rlUpdateAllLocationEvents
        jsl rlSetUpChapterMapDisplay
        jsl rlLoadWindowGraphics
        jsr rsUnknown80B065
        jsr rsUnknown80B105
        jsr rsUnknown80B052
        jsr rsUnknown80B041
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

      rsUnknown80B316 ; 80/B316

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
