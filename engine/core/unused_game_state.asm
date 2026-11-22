; Unused screen (BG mode $09 setup, game states $16/$17), reached by nothing.


    .section Unsorted80C162Section

      .al
      .xl

      rsRunVBlankWithoutSound ; 80/C162

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; VBlank routine omitting rlUpdateSound, installed by rsOpenUnusedScreen

        sep #$20
        lda #$80
        sta $2100,b
        rep #$20
        jsl rlUnknown8887EC
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
        jsl rlMapMenuVBlankUpload
        rts

        .databank 0

        ; 80/C1A0

    .endsection Unsorted80C162Section


    .section Unsorted80C1A0Section

      .al
      .xl

      rlUnusedScreenSetup ; 80/C1A0

        .al
        .xl
        .autsiz
        .databank ?

        ; Game state routine $16, once: builds a $5AFF-byte RAM area at $7FA500 and moves on to $17. Only rsOpenUnusedScreen, itself unreferenced, selects it.

        php
        lda #$7F00
        sta lR18+1
        lda #$A500
        sta lR18
        lda #$5AFF
        jsl rlBuildRAMAreaHeaderAndGuidingEntry
        inc wGameStateRoutine1,b
        stz wGameStateStep,b
        plp
        rtl

        .databank 0

        ; 80/C1BA

    .endsection Unsorted80C1A0Section


    .section Unsorted80C1CASection

      .al
      .xl

      rlUnusedScreenStep ; 80/C1CA

        .al
        .xl
        .autsiz
        .databank ?

        ; Game state routine $17, every frame: does nothing.

        rtl

        .databank 0

        ; 80/C1CB

    .endsection Unsorted80C1CASection


    .section Unsorted80C39ASection

      .as
      .xs

      rsOpenUnusedScreen ; 80/C39A

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ; Unused opener resetting PPU Mode $09, engines, game state $16, installing rsRunVBlankWithoutSound

        php
        sep #$20
        lda #$80
        sta bBufferINIDISP
        sta $2100,b
        rep #$20
        jsl rlDisableVBlank
        jsl rlHardwareResetScreenPosMathHDMA
        jsr rsResetPPUAndBuffersMode09
        jsl rlUnknown80C32C
        jsl rlResetRAMStructAndAreaVariables
        jsl rlInitMapMenus
        lda #GAMESTATE_UNUSED_SCREEN_SETUP
        sta wGameStateRoutine1,b
        stz wGameStateStep,b
        stz wGameStateRoutine2,b
        lda #<>rsRunVBlankWithoutSound
        sta wVBlankPointer
        lda #<>rsRunFrameTasks
        sta wMainLoopPointer
        jsl rlEnableVBlank
        jsl rlDisableForcedBlank
        plp
        rts

        .databank 0

        ; 80/C3DD

    .endsection Unsorted80C39ASection


