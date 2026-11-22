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
        lda wUnknown000D79,b
        bit #$0200
        bne _AE92
        lda bDMAArrayFlag,b
        and #$00FF
        bne _AE92
        lda #$0008
        trb wUnknown000D79,b
        jsl rlUnknown88CD68
        bra _AE98


        _AE92
        lda #$0008
        tsb wUnknown000D79,b

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
        jsl rlUnknown81B3A6
        jsl rlUnknown858728
        lda bUnknown000E7B,b
        bit #$0010
        bne _AEE4
        jsl rlUnknown88C844
        jsl rlUnknown88D084
        jsl rlHideSprites

        _AEE4
        jsl rlUpdateSound
        plp
        rts

        .databank 0

        ; 80/AEEA

      rsStartChapterMap ; 80/AEEA

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
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
        jsl rlUnknown87BF6F
        lda wUnknown000D79,b
        bit #$0100
        bne _AF33
        jsl rlResetUnitsForChapter
        lda wCurrentChapter,b
        jsl rlUnknown86C4C4
        stz wCurrentTurn,b
        stz wSavedEventCycle,b
        sep #$20
        stz wAreaRestrictionBitfield,b
        rep #$20
        bra _AF4C


        _AF33
        stz $0DAB,b
        jsl rlUnknown86C4EB
        lda #$0007
        sta wSavedEventCycle,b
        jsl rlUnknown81A9D4
        jsl rlStepMusicScript
        jsl rlUnknown86C629

        _AF4C
        jsl rlUnknown88DE1B
        jsl rlUpdateAllLocationEvents
        jsl rlUnknown888082
        jsl rlUnknown899FDC
        jsr rsUnknown80B065
        jsr rsUnknown80B105
        jsr rsUnknown80B052
        jsr rsUnknown80B041
        lda #$0011
        sta wGameStateRoutine1,b
        stz wGameStateStep,b
        lda wUnknown000D79,b
        bit #$0020
        beq _AF89
        stz wGameStateRoutine1,b
        lda #$0000
        jsl rlUnknown88B30D
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
        jsl rlUnknown91A80D
        rts

        .databank 0

        ; 80/B316

    .endsection MapMainLoopSection
