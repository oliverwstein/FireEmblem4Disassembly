; The epilogue's game state routines (bank $8D): rlEpilogueSetup ($36),
; rlEpilogueStep ($37) and its steps (aEpilogueStepRoutines, EPILOGUE_STEP_*).
; rsOpenEpilogueScreen (credits.asm) starts a part by wEpiloguePart
; (EPILOGUE_PART_*): the endings and the world map epilogue (steps 12, 5, 0-1),
; the credits (2-4, then the end screen 13-14), the play record and the ranking
; screen (6-7, 15-18) and the character endings (8-9). Steps 10 and 11 fade out
; and in and then go to the step in wNextMenuState. rlStartEpilogue is called by
; the final chapter's ending event.


    .section Unsorted8DA06ASection

      .al
      .xl

      rlEpilogueUpkeep ; 8D/A06A

        .al
        .xl
        .autsiz
        .databank ?

        ; Game state routine $35, every frame while the epilogue is up: does nothing.

        rtl

        .databank 0

        ; 8D/A06B

      rlEpilogueSetup ; 8D/A06B

        .al
        .xl
        .autsiz
        .databank ?

        ; Game state routine $36, once: builds the RAM area at $7F5709, clears $7F4400-$7F5708, turns on active sprites and, unless $08DA is 0-2, starts a fade-in; moves on to $37.

        lda #$7F00
        sta lR18+1
        lda #$5709
        sta lR18
        lda #$A8F6
        jsl rlBuildRAMAreaHeaderAndGuidingEntry
        ldx #$1308
        lda #$0000

        _A082
        sta $7F4400,x
        dec x
        bpl _A082
        jsl rlEnableActiveSpriteEngine
        inc wGameStateRoutine1,b
        lda wEpiloguePart,b
        cmp #$0001
        beq _A0B6
        cmp #$0000
        beq _A0B6
        cmp #$0002
        beq _A0B6
        lda #$0004
        sta wScreenFadingProcInput,b
        lda #(`procFadeInByScreenFadingTimer)<<8
        sta lR44+1
        lda #<>procFadeInByScreenFadingTimer
        sta lR44
        jsl rlProcEngineCreateProc

        _A0B6
        rtl

        .databank 0

        ; 8D/A0B7

      rlEpilogueStep ; 8D/A0B7

        .al
        .xl
        .autsiz
        .databank ?

        ; Game state routine $37, every frame: runs the routine for wGameStateStep from aEpilogueStepRoutines.

        phb
        php
        phk
        plb
        .databank $8D
        lda wGameStateStep,b
        asl a
        tax
        jsr (aEpilogueStepRoutines,x)
        plp
        plb
        .databank $8D
        rtl

        .databank 0

        ; 8D/A0C6

    .endsection Unsorted8DA06ASection


    .section Unsorted8DA0C6Section

      .al
      .xl

      aEpilogueStepRoutines ; 8D/A0C6

        ; Step handlers of rlEpilogueStep, by wGameStateStep.
        .word <>rsEpilogueStepShowText, <>rsEpilogueStepHoldText, <>rsEpilogueStepSetUpCredits, <>rsEpilogueStepStartCredits, <>rsEpilogueStepScrollCredits, <>rsEpilogueStepWorldMap, <>rsEpilogueStepSetUpRecords, <>rsEpilogueStepScrollRecords, <>rsEpilogueStepStartCharacterEndings, <>rsEpilogueStepNextCharacterEnding, <>rsEpilogueStepFadeOut, <>rsEpilogueStepFadeIn, <>rsEpilogueStepStartWorldMapEvent, <>rsEpilogueStepShowEndScreen, <>rsEpilogueStepWaitEndScreen, <>rsEpilogueStepShowRankingScreen, <>rsEpilogueStepWaitRankingScreen, <>rsEpilogueStepSecretCode, <>rsEpilogueStepEnd


      rsEpilogueStepShowText ; 8D/A0EC

        .al
        .xl
        .autsiz
        .databank ?

        ; Epilogue step 0: once the dialogue has finished, uploads the BG3 text and fades in (step 11), then step 1.

        lda aDialogue.wStatus,b
        beq _A0F2
        rts


        _A0F2
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0800, $80, $D000

        lda #EPILOGUE_STEP_FADE_IN
        sta wGameStateStep,b
        lda #EPILOGUE_STEP_HOLD_TEXT
        sta wNextMenuState,b
        lda #$0000
        sta wEpilogueTimer
        rts

        .databank 0

        ; 8D/A113

      rsEpilogueStepHoldText ; 8D/A113

        .al
        .xl
        .autsiz
        .databank ?

        ; Epilogue step 1: waits 192 frames, then fades out (step 10) and starts the world map epilogue (step 12).

        lda wEpilogueTimer
        cmp #$00C0
        bcs _A122
        inc a
        sta wEpilogueTimer
        rts


        _A122
        lda #$0000
        sta wEpilogueTimer
        lda #EPILOGUE_STEP_FADE_OUT
        sta wGameStateStep,b
        lda #EPILOGUE_STEP_START_WORLD_MAP
        sta wNextMenuState,b
        rts

        .databank 0

        ; 8D/A136

      rsEpilogueStepSetUpCredits ; 8D/A136

        .al
        .xl
        .autsiz
        .databank ?

        ; Epilogue step 2: rlSetupEpilogueCreditsDisplay.

        jsl rlSetupEpilogueCreditsDisplay
        rts

        .databank 0

        ; 8D/A13B

      rsEpilogueStepStartCredits ; 8D/A13B

        .al
        .xl
        .autsiz
        .databank ?

        ; Epilogue step 3: on its first frame starts the credits' HDMA effects and sprites (rlInitEpilogueCreditsSprites); draws the sprites for 96 frames, then step 4.

        lda wEpilogueTimer
        bne _A161
        lda #(`aEpilogueCreditsWaveHDMAInfo)<<8
        sta lR44+1
        lda #<>aEpilogueCreditsWaveHDMAInfo
        sta lR44
        jsl rlHDMAEngineCreateEntry
        lda #(`aEpilogueCreditsLayerHDMAInfo)<<8
        sta lR44+1
        lda #<>aEpilogueCreditsLayerHDMAInfo
        sta lR44
        jsl rlHDMAEngineCreateEntry
        jsl rlInitEpilogueCreditsSprites

        _A161
        jsr rsDrawEpilogueCreditsSprites
        lda wEpilogueTimer
        inc a
        sta wEpilogueTimer
        cmp #$0060
        bcc _A17F
        lda #$0000
        sta wEpilogueTimer
        lda #EPILOGUE_STEP_SCROLL_CREDITS
        sta wGameStateStep,b

        _A17F
        rts

        .databank 0

        ; 8D/A180

      rsEpilogueStepScrollCredits ; 8D/A180

        .al
        .xl
        .autsiz
        .databank ?

        ; Epilogue step 4: rlScrollEpilogueCredits.

        jsl rlScrollEpilogueCredits
        rts

        .databank 0

        ; 8D/A185

      rsEpilogueStepWorldMap ; 8D/A185

        .al
        .xl
        .autsiz
        .databank ?

        ; Epilogue step 5, while the world map epilogue event runs: draws three of the credits sprites (parts of rsDrawEpilogueCreditsSprite).

        jsr rsDrawEpilogueCreditsSprite
        jsr rsDrawEpilogueCreditsSprite._A676
        jsr rsDrawEpilogueCreditsSprite._A6E9
        rts

        .databank 0

        ; 8D/A18F

      rsEpilogueStepSetUpRecords ; 8D/A18F

        .al
        .xl
        .autsiz
        .databank ?

        ; Epilogue step 6: rlSetupEpilogueRankingsDisplay (the play record: turns per chapter, each unit's wins and losses).

        jsl rlSetupEpilogueRankingsDisplay
        rts

        .databank 0

        ; 8D/A194

      rsEpilogueStepScrollRecords ; 8D/A194

        .al
        .xl
        .autsiz
        .databank ?

        ; Epilogue step 7: rlScrollEpilogueRecordText.

        jsl rlScrollEpilogueRecordText
        rts

        .databank 0

        ; 8D/A199

      rsEpilogueStepStartCharacterEndings ; 8D/A199

        .al
        .xl
        .autsiz
        .databank ?

        ; Epilogue step 8: rlStartEpilogueCharacterEndings.

        jsl rlStartEpilogueCharacterEndings
        rts

        .databank 0

        ; 8D/A19E

      rsEpilogueStepNextCharacterEnding ; 8D/A19E

        .al
        .xl
        .autsiz
        .databank ?

        ; Epilogue step 9: rlNextEpilogueCharacterEnding.

        jsl rlNextEpilogueCharacterEnding
        rts

        .databank 0

        ; 8D/A1A3

      rsEpilogueStepFadeOut ; 8D/A1A3

        .al
        .xl
        .autsiz
        .databank ?

        ; Epilogue step 10: fades the screen out one level every 8 frames, then goes to the step in wNextMenuState.

        lda wVBlankEnabledFramecount
        and #$0007
        bne _A1B4
        sep #$20
        lda bBufferINIDISP
        and #$0F
        beq _A1B7
        dec bBufferINIDISP

        _A1B4
        rep #$20
        rts


        _A1B7
        .as
        rep #$20
        lda wNextMenuState,b
        sta wGameStateStep,b
        rts

        .databank 0

        ; 8D/A1C0

      rsEpilogueStepFadeIn ; 8D/A1C0

        .al
        .xl
        .autsiz
        .databank ?

        ; Epilogue step 11: fades the screen in one level every 8 frames, then goes to the step in wNextMenuState.

        lda wVBlankEnabledFramecount
        and #$0007
        bne _A1D3
        sep #$20
        lda bBufferINIDISP
        and #$0F
        cmp #$0F
        beq _A1D6
        inc bBufferINIDISP

        _A1D3
        rep #$20
        rts


        _A1D6
        .as
        rep #$20
        lda wNextMenuState,b
        sta wGameStateStep,b
        rts

        .databank 0

        ; 8D/A1DF

      rsEpilogueStepStartWorldMapEvent ; 8D/A1DF

        .al
        .xl
        .autsiz
        .databank ?

        ; Epilogue step 12: starts the world map epilogue event (aEventChapterEpilogueWorldMap), then step 5.

        lda #$FFFF
        sta wCurrentChapter,b
        lda #(`aEventChapterEpilogueWorldMap)<<8
        sta lR18+1
        lda #<>aEventChapterEpilogueWorldMap
        sta lR18
        jsl rlStartEventScript
        lda #EPILOGUE_STEP_WORLD_MAP
        sta wGameStateStep,b
        rts

        .databank 0

        ; 8D/A1FA

      rsEpilogueStepShowEndScreen ; 8D/A1FA

        .al
        .xl
        .autsiz
        .databank ?

        ; Epilogue step 13: rlShowEpilogueEndScreen, fade in, then step 14.

        jsl rlShowEpilogueEndScreen
        lda #EPILOGUE_STEP_FADE_IN
        sta wGameStateStep,b
        lda #EPILOGUE_STEP_WAIT_END_SCREEN
        sta wNextMenuState,b
        rts

        .databank 0

        ; 8D/A20B

      rsEpilogueStepWaitEndScreen ; 8D/A20B

        .al
        .xl
        .autsiz
        .databank ?

        ; Epilogue step 14: shows the end screen for 2,880 frames, or until a button after 256; then fades out to the play record (step 6), with sound command $E3 when the final ranking score is below 3.

        lda wEpilogueTimer
        inc a
        sta wEpilogueTimer
        cmp #$0B40
        bcs _A223
        cmp #$0100
        bcs _A21F

        _A21E
        rts


        _A21F
        lda wJoy1New
        beq _A21E

        _A223
        lda #EPILOGUE_STEP_FADE_OUT
        sta wGameStateStep,b
        lda #EPILOGUE_STEP_SET_UP_RECORDS
        sta wNextMenuState,b
        jsl rlCalculateFinalRankingScore
        cmp #$0003
        bcs _A23F
        lda #$00E3
        jsl rlQueueSoundCommand

        _A23F
        rts

        .databank 0

        ; 8D/A240

      rsEpilogueStepShowRankingScreen ; 8D/A240

        .al
        .xl
        .autsiz
        .databank ?

        ; Epilogue step 15: rlShowEpilogueRankingScreen, fade in, then step 16.

        jsl rlShowEpilogueRankingScreen
        lda #$0000
        sta wEpilogueTimer
        lda #EPILOGUE_STEP_FADE_IN
        sta wGameStateStep,b
        lda #EPILOGUE_STEP_WAIT_RANKING
        sta wNextMenuState,b
        rts

        .databank 0

        ; 8D/A258

      rsEpilogueStepWaitRankingScreen ; 8D/A258

        .al
        .xl
        .autsiz
        .databank ?

        ; Epilogue step 16: after 384 frames uploads one more row of the ranking screen and goes to step 17.

        lda wEpilogueTimer
        cmp #$0180
        bcs _A267
        inc a
        sta wEpilogueTimer
        rts


        _A267
        lda #$0000
        sta wEpilogueTimer
        lda #EPILOGUE_STEP_SECRET_CODE
        sta wGameStateStep,b
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8088, $0040, $80, $D500

        rts

        .databank 0

        ; 8D/A282

      rsEpilogueStepSecretCode ; 8D/A282

        .al
        .xl
        .autsiz
        .databank ?

        ; Epilogue step 17: rlCheckEpilogueSecretCode.

        jsl rlCheckEpilogueSecretCode
        rts

        .databank 0

        ; 8D/A287

      rsEpilogueStepEnd ; 8D/A287

        .al
        .xl
        .autsiz
        .databank ?

        ; Epilogue step 18: nothing; the game stays on the ranking screen.

        rts

        .databank 0

        ; 8D/A288

    .endsection Unsorted8DA0C6Section


    .section Unsorted8DA288Section

      .al
      .xl

      rlStartEpilogue ; 8D/A288

        .al
        .xl
        .autsiz
        .databank ?

        ; The final chapter's ending event: wEpiloguePart 0, no chapter, fades to the epilogue screen (rsOpenEpilogueScreen).

        stz wEpiloguePart,b
        lda #$FFFF
        sta wCurrentChapter,b
        lda #<>rsOpenEpilogueScreen
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        jsl rlSaveMapCameraAndLockCursor
        rtl

        .databank 0

        ; 8D/A2AA

    .endsection Unsorted8DA288Section


    .section Unsorted8DA372Section

      .al
      .xl

      rsEpilogueDebugButtonsUnused ; 8D/A372

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ; Nothing reaches this. Select goes to the credits (wEpiloguePart 1), B back to the title (rsUnknown80B122), X to the play record, Y fades out to the ranking screen.

        lda wJoy1New
        bit #$2000
        bne _A389
        bit #$8000
        bne _A3A4
        bit #$0040
        bne _A3CC
        bit #$4000
        bne _A3D1
        rts


        _A389
        lda #EPILOGUE_PART_CREDITS
        sta wEpiloguePart,b
        lda #<>rsOpenEpilogueScreen
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        rts


        _A3A4
        lda #$0000
        sta wCurrentChapter,b
        lda #$0021
        jsl rlPlaySoundEffect
        lda #$0002
        sta wMainGameMode,b
        lda #<>rsUnknown80B122
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        rts


        _A3CC
        jsl rlSetupEpilogueRankingsDisplay
        rts


        _A3D1
        lda #EPILOGUE_STEP_FADE_OUT
        sta wGameStateStep,b
        lda #EPILOGUE_STEP_SHOW_RANKING
        sta wNextMenuState,b
        rts

        .databank 0

        ; 8D/A3DE

    .endsection Unsorted8DA372Section


    .section Unsorted8DAD9ESection

      .al
      .xl

      rsEpilogueDebugButtons2Unused ; 8D/AD9E

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ; Nothing reaches this. B back to the title (rsUnknown80B122), Select restarts the credits text, X the character endings.

        lda wJoy1New
        bit #$8000
        bne _ADB0
        bit #$2000
        bne _ADD8
        bit #$0040
        bne _ADF5
        rts


        _ADB0
        lda #$0000
        sta wCurrentChapter,b
        lda #$0021
        jsl rlPlaySoundEffect
        lda #$0002
        sta wMainGameMode,b
        lda #<>rsUnknown80B122
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        rts


        _ADD8
        jsl rlResetDialogueEngine
        lda #(`dialogueEpilogueCredits8DC9A6)<<8
        sta lR18+1
        lda #<>dialogueEpilogueCredits8DC9A6
        sta lR18
        lda #$0002
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsl rlSetUpEpilogueTextWindow
        rts


        _ADF5
        jsl rlStartEpilogueCharacterEndings
        rts

        .databank 0

        ; 8D/ADFA

    .endsection Unsorted8DAD9ESection


