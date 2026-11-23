; The chapter map's game state routines: rlMapSetup (state $11), rlMapStep ($12,
; every frame) and rlMapUpkeep ($10, every frame). Bank $81, with one routine from
; bank $84.
;
; The map step is the turn loop. wGameStateStep selects one of thirteen steps
; (aMapStepRoutines): a new turn (0), each army's phase (fade out the music 1,
; banner 2, phase start events 3, turn start effects 4, healing windows 5, auto save
; prompt 6, the phase itself 7), the next army (8), the end of the turn (9), and the
; status screen (10), the return from another screen (11) and game over (12).
;
; Before the step runs, rlMapStep handles what earlier actions queued, each of which
; may end the frame: buffered deployment states (rlApplyBufferedDeploymentStates), a
; defeated unit (rlHandleDefeatedUnit), the queued relocation (rlRunQueuedUnitRelocation
; and aUnitRelocationRoutines: a unit moved to a tile, escaping, captured, going into
; or leaving a castle, a popup or the save prompt), the queued unit menu, the gold
; popup, the inventory full menu, a canto move and the action-ended events.
; Nothing in this list runs while an event is running (wEventEngineFlags).


    .section Unsorted81A800Section

      .al
      .xl

      rlMapUpkeep ; 81/A800

        .al
        .xl
        .autsiz
        .databank ?

        ; Game state routine $10, every frame while the chapter map is up: rlAnimateMapSprites and rlAnimateRangeOverlayPalette, then copies the map scroll to the BG1 scroll registers.

        jsl rlAnimateMapSprites
        jsl rlAnimateRangeOverlayPalette
        lda wMapScrollXPixels,b
        sta wBufferBG1HOFS
        lda wMapScrollYPixels,b
        sta wBufferBG1VOFS
        rtl

        .databank 0

        ; 81/A813

      rlMapSetup ; 81/A813

        .al
        .xl
        .autsiz
        .databank ?

        ; Game state routine $11, once: builds aMapMenuRAMArea, turns on active sprites (flag $2000 set), fades in unless wEventEngineFlags, creates the unit and terrain window procs, and moves on to $12 at the step saved in wSavedMapStep.

        lda wChapterFlags,b
        and #$4005
        sta wChapterFlags,b
        lda #(`aMapMenuRAMArea)<<8
        sta lR18+1
        lda #<>aMapMenuRAMArea
        sta lR18
        lda #$0001
        sta wStructIndex,b
        lda #$0E57
        jsl rlBuildRAMAreaHeaderAndGuidingEntry
        jsl rlEnableActiveSpriteEngine
        jsl rlActiveSpriteEngineSetFlag2000
        lda wEventEngineFlags,b
        bne _A84E
        lda #(`procFadeIn)<<8
        sta lR44+1
        lda #<>procFadeIn
        sta lR44
        jsl rlProcEngineCreateProc

        _A84E
        jsl rlCreateUnitWindowAndTerrainWindowProcs
        inc wGameStateRoutine1,b
        lda wSavedMapStep,b
        sta wGameStateStep,b
        rtl

        .databank 0

        ; 81/A85C

    .endsection Unsorted81A800Section


    .section Unsorted81A85CSection

      .al
      .xl

      rlResetChapterProgress ; 81/A85C

        .al
        .xl
        .autsiz
        .databank ?

        ; New game, and loading a save before its data is read: clears the chapter, turn, saved map step, wChapterFlags, the queued relocation, defeat and action-end words, and sets the options to their default (8).

        phb
        php
        phk
        plb
        .databank $81
        stz wChapterFlags,b
        lda #$FFFF
        sta wUnitRelocationDeploymentOffset,b
        sta wDefeatedUnitDeploymentOffset,b
        sta wInventoryFullDeploymentOffset,b
        sta wActionEndedDeploymentOffset,b
        sta wVillageGoldPopUpAmount,b
        stz wMapStateFlags,b
        stz wActiveFactionSlot,b
        stz wMapBattleHPWindowLeftRequest,b
        stz $0DB1,b
        stz wCurrentChapter,b
        stz wCurrentTurn,b
        stz wSavedMapStep,b
        stz wDestroyedLocationsCount,b
        lda #$0008
        sta wOptionSettings,b
        sep #$20
        stz wAreaRestrictionBitfield,b
        rep #$20
        plp
        plb
        .databank $81
        rtl

        .databank 0

        ; 81/A89D

    .endsection Unsorted81A85CSection


    .section Unsorted81A89DSection

      .al
      .xl

      rlMapStep ; 81/A89D

        .al
        .autsiz
        .databank ?

        ; Game state routine $12, every frame: the chapter map. Runs a chain of checks (each may end the frame), then the routine for wGameStateStep from aMapStepRoutines (13 steps), and saves the step in wSavedMapStep. The AI engine only runs while wGameStateRoutine1 is $12.

        phb
        php
        phk
        plb

        jsl rlApplyBufferedDeploymentStates
        jsl rlHandleDefeatedUnit
        bcc +

          jsl rlCheckVictoryTheme
          bra _End

        +
        lda wEventEngineFlags,b
        bne +

          jsl rlRunQueuedUnitRelocation
          bcs _End

            jsr rsOpenQueuedUnitMenu
            bcs _End

              jsr rsShowQueuedGoldPopUp
              bcs _End

                jsr rsOpenQueuedInventoryFullMenu
                bcs _End

                  jsr rsResumeCantoMove
                  bcs _End

                    jsr rsRunActionEndedEvents

        +
        lda wGameStateStep,b
        cmp #MAP_STEP_COUNT
        bmi +

          -
          bra -

        +
        asl a
        tax
        jsr (aMapStepRoutines,x)

        lda wGameStateStep,b
        sta wSavedMapStep,b

        lda wEventEngineFlags,b
        beq _End

          jsl rlMapCursorStep
          jsl rlContinueMapScroll

        _End
        plp
        plb
        rtl

        .databank 0

      aMapStepRoutines ; 81/A8F8

        .word <>rsMapStepStartTurn ; 0
        .word <>rsMapStepFadeOutMusic ; 1
        .word <>rsMapStepPhaseBanner ; 2
        .word <>rsMapStepPhaseStartEvents ; 3
        .word <>rsMapStepStartPhase ; 4
        .word <>rsMapStepTurnStartHealing ; 5
        .word <>rsMapStepAutoSavePrompt ; 6
        .word <>rsMapStepPhase ; 7

        .word <>rsMapStepNextFaction ; 8
        .word <>rsMapStepEndTurn ; 9
        .word <>rsMapStepOpenStatusScreen ; 10
        .word <>rsMapStepResume ; 11
        .word <>rsMapStepGameOver ; 12

      rsMapStepStartTurn ; 81/A912

        .al
        .autsiz
        .databank ?

        ; Map step 0: a new turn. Counts the turn (up to 999), makes the player army active and counts down the status durations of armies 0-6.


        lda wEventEngineFlags,b
        bne _End

        lda wCurrentTurn,b
        inc a
        cmp #1000
        bcc +

          lda #999

        +
        sta wCurrentTurn,b

        lda #0
        sta wActiveFactionSlot,b

        ldy #6
        
          -
          tya
          jsl rlDecreaseFactionStatusDurations
          dec y
          bpl -

        inc wGameStateStep,b
        
        _End
        rts

        .databank 0

      rsMapStepFadeOutMusic ; 81/A93B

        .al
        .autsiz
        .databank ?

        ; Map step 1: fades the previous phase's music out before the next army's phase (wPhaseMusicFadeTimer: $FFFF start, then 32 frames), if the army takes a phase and has a phase song.

        lda wPhaseMusicFadeTimer,b
        beq _INC
        bpl _DEC

          lda wActiveFactionSlot,b
          jsl rlCheckFactionTakesPhase
          bcc _INC

            jsr rsGetActiveFactionSongID
            bcc _INC

              lda #$00E0
              jsl rlSendSoundCommand
              lda #$0020
              sta wPhaseMusicFadeTimer,b
              bra +

                _DEC
                dec wPhaseMusicFadeTimer,b
                bra + 

        _INC
        inc wGameStateStep,b

        +
        rts

        .databank 0

      rsMapStepPhaseBanner ; 81/A968

        .al
        .autsiz
        .databank ?

        ; Map step 2: clears the army-acted flag and, if the army takes a phase (rlCheckFactionTakesPhase), starts its music and shows the phase banner (procPhaseBanner).


        lda wEventEngineFlags,b
        bne _End

          lda #$1000
          trb wChapterFlags,b

          lda wActiveFactionSlot,b
          jsl rlCheckFactionTakesPhase
          bcc +

            lda #1
            sta wSoundUploadBusyFlag,b
            lda #1
            sta wSoundIndirectPending,b
            jsl rlStartPhaseMusic

            lda #(`procPhaseBanner)<<8
            sta $62+1
            lda #<>procPhaseBanner
            sta $62
            jsl rlProcEngineCreateProc

            lda #$0040
            trb wMapSystemFlags,b
            bra +

          +
          inc wGameStateStep,b
        
        _End
        rts

        .databank 0

      rsMapStepPhaseStartEvents ; 81/A9A6

        .al
        .autsiz
        .databank ?

        ; Map step 3: runs the chapter's event conditions with event action $21 (turn, army, 0, 0): the start of a phase.


        lda #0
        sta wSoundUploadBusyFlag,b
        lda #$0021
        sta bEventActionIdentifier,b

        lda wCurrentTurn,b
        sta wEventEngineArgument1,b

        lda wActiveFactionSlot,b
        sta wEventEngineArgument2,b
        lda #0
        sta wEventEngineArgument3,b
        lda #0
        sta wEventEngineArgument4,b
        jsl rlGetAndRunChapterMapEventConditions
        bcc +

        +
        inc wGameStateStep,b

        rts

        .databank 0

      rlStartPhaseMusic ; 81/A9D4

        .al
        .autsiz
        .databank ?

        ; Sets wPhaseSongID for the active army's phase and starts it. The first phase of a chapter (bit 14 of wChapterFlags clear) plays the chapter's first-phase song (rsStartChapterFirstPhaseSong). Sets wPhaseMusicFadeTimer to $FFFF.

        lda wChapterFlags,b
        bit #$4000
        beq +

          jsr rsGetActiveFactionSongID
          bcc _End

            sta wPhaseSongID,b
            jsl rlResumePhaseMusic
            bra _End

        +
        ora #$4000
        sta wChapterFlags,b

        jsr rsStartChapterFirstPhaseSong
        jsr rsGetActiveFactionSongID
        sta wPhaseSongID,b
        
        _End
        lda #$FFFF
        sta wPhaseMusicFadeTimer,b
        rtl

        .databank 0

    .endsection Unsorted81A89DSection


    .section MapStepStartPhaseSection

      .al
      .xl

      rsMapStepStartPhase ; 81/AB6B

        .al
        .autsiz
        .databank ?

        ; Map step 4: unless an event is running, the turn start love points (rlAddTurnStartLovePoints), the turn start effects of the army's units, the AI engine on, and the phase music if the army takes a phase.

        lda wEventEngineFlags,b
        bne _End

          jsl rlAddTurnStartLovePoints

          lda wActiveFactionSlot,b
          jsl rlRunTurnStartEffectsForAllUnitsInFaction
          jsl rlEnableAIEngineCycle

          lda wActiveFactionSlot,b
          jsl rlCheckFactionTakesPhase
          bcc +

            jsl rlStartPhaseMusic

          +
          inc wGameStateStep,b
        
        _End
        rts

        .databank 0

    .endsection MapStepStartPhaseSection


    .section Unknown81AB90Section

      .al
      .xl

      rsMapStepTurnStartHealing ; 81/AB90

        .al
        .autsiz
        .databank ?

        ; Map step 5: shows each entry of the turn start healing list in procMapExperienceWindow, one a step ($7E2002 entries of 5 bytes from $7E2004), then the map windows, and moves the cursor to the phase's start.


        lda $7E2002
        beq _ABF1

          lda $7E2000
          tax
          clc
          adc #5
          sta $7E2000

          lda $7E2006,x
          and #$00FF
          sta aProcSystem.wInput0,b

          lda aDebugMenuSkillFlags.bAdept,x
          and #$00FF
          xba
          ora aProcSystem.wInput0,b
          sta aProcSystem.wInput0,b

          lda $7E2008,x
          and #$00FF
          sta aProcSystem.wInput1,b

          lda aDebugMenuSkillFlags.bWrath,x
          and #$00FF
          sta aProcSystem.wInput2,b

          lda $7E2004,x
          and #$00FF
          sta aProcSystem.wInput3,b

          lda #(`procMapExperienceWindow)<<8
          sta $62+1
          lda #<>procMapExperienceWindow
          sta $62
          jsl rlProcEngineCreateProc

          lda $7E2002
          dec a
          sta $7E2002
          rts

        _ABF1
        jsl rlShowMapWindows

        lda #$0004
        tsb wMapSystemFlags,b

        jsr rsMoveCursorToPhaseStart
        inc wGameStateStep,b
        rts

        .databank 0

    .endsection Unknown81AB90Section


    .section Unsorted81AC02Section

      .al
      .xl

      rsMoveCursorToPhaseStart ; 81/AC02

        .al
        .autsiz
        .databank ?

        ; At the start of the player phase: the cursor goes to the saved cursor tile when the auto cursor option is on and the turn is not the first, otherwise to the army's first unit (generation ID 0 in faction slot 0).

        lda wActiveFactionSlot,b
        bne _End

          lda wCurrentTurn,b
          cmp #1
          beq +

            jsl rlGetAutoCursorOption
            cmp #0
            beq +

              lda bSavedPlayerCursorXTile,b
              and #$00FF
              sta $14
              lda bSavedPlayerCursorYTile,b
              and #$00FF
              sta $16
              jsl rlMoveCursorToTile
              bra _End
          
          +
          lda #1
          sta wRoutineVariable1,b
          lda #0
          jsl rlFindGenerationIDInFactionSlotData

          lda wSelectedUnitDataRAMPointer,b
          beq _End

            jsl rlGetSelectedUnitDeploymentOffset
            ora #0
            bmi _End

              jsl rlMoveCursorToUnit
        
        _End
        rts

        .databank 0

      rsMapStepAutoSavePrompt ; 81/AC4E

        .al
        .autsiz
        .databank ?

        ; Map step 6: from turn 2 of the player phase with the auto save option on, waits until no experience window is open and the cursor rests, then opens the save prompt (procSavePrompt).

        lda wCurrentTurn,b
        cmp #1
        beq _INC

          lda wActiveFactionSlot,b
          bne _INC

            jsl rlGetAutoSaveOption
            ora #0
            beq _INC

              lda #(`procMapExperienceWindow)<<8
              sta $62+1
              lda #<>procMapExperienceWindow
              sta $62
              jsl rlProcEngineFindProc
              bcs _End

                jsl rlMapCursorStep
                jsl rlContinueMapScroll

                lda wMapCursorState,b
                bne _End

                  lda #1
                  sta aProcSystem.wInput0,b
                  lda #(`procSavePrompt)<<8
                  sta $62+1
                  lda #<>procSavePrompt
                  sta $62
                  jsl rlProcEngineCreateProc
                  bra _INC
              
              _End
              rts
        
        _INC
        inc wGameStateStep,b
        rts

        .databank 0

      rsMapStepPhase ; 81/AC9C

        .al
        .autsiz
        .databank ?

        ; Map step 7: the phase itself. Runs the AI unit's queued event, moves the cursor and the camera, and moves on when bit 5 of wMapStateFlags (the phase is over) is set.


        lda wEventEngineFlags,b
        bne +

          jsr rsRunQueuedAIUnitEvent
          lda wMapCursorState,b
          bne +
        
        +
        lda wMapStateFlags,b
        bit #$0020
        bne +

          lda wChapterFlags,b
          bit #$0200
          bne +

            jsl rlMapCursorStep
            jsl rlContinueMapScroll
        
        +
        lda wMapStateFlags,b
        bit #$0020
        bne +

          rts
        
        +
        lda #$0020
        trb wMapStateFlags,b
        inc wGameStateStep,b
        rts

        .databank 0

      rsMapStepNextFaction ; 81/ACD4

        .al
        .autsiz
        .databank ?

        ; Map step 8: clears the army's moved flags and goes to the next army that exists (step 1), or after the last one back to the player army (step 9).

        lda wActiveFactionSlot,b
        jsl rlUnsetFactionUnitsMoved

          -
          lda wActiveFactionSlot,b
          inc a
          cmp wLoadedFactionCount,b
          bcs +

            sta wActiveFactionSlot,b
            jsl rlGetFactionSlotNameID
            cmp #$0080
            beq -

        lda #MAP_STEP_FADE_OUT_MUSIC
        sta wGameStateStep,b
        rts
        
        +
        stz wActiveFactionSlot,b
        inc wGameStateStep,b
        rts

        .databank 0

      rsMapStepEndTurn ; 81/ACFE

        .al
        .autsiz
        .databank ?

        ; Map step 9: the end of a turn. Stops the AI, sets bit 6 of wMapSystemFlags, runs the event conditions with event action $20 (turn) and goes back to step 0.

        jsl rlDisableAIEngineCycle

        lda #$0040
        tsb wMapSystemFlags,b

        lda #$0020
        sta bEventActionIdentifier,b
        lda wCurrentTurn,b
        sta wEventEngineArgument1,b
        jsl rlGetAndRunChapterMapEventConditions
        stz wGameStateStep,b
        rts

        .databank 0

      rsMapStepOpenStatusScreen ; 81/AD1C

        .al
        .autsiz
        .databank ?

        ; Map step 10: switches the main loop to the status screen and leaves step 7 for the return.

        lda #<>rsOpenStatusScreen
        sta wMainLoopPointer
        lda #MAP_STEP_PHASE
        sta wGameStateStep,b
        rts

        .databank 0

    .endsection Unsorted81AC02Section


    .section Unsorted81AD28Section

      .al
      .xl

      rsMapStepResume ; 81/AD28

        .al
        .autsiz
        .databank ?

        ; Map step 11: back on the map after another screen. Recreates the unit and terrain windows, fades in by wMainGameMode, gives the active unit its canto move if it has one (rlCheckActiveUnitCanto) and goes back to the saved step.

        jsl rlCreateUnitWindowAndTerrainWindowProcs

        lda wMainGameMode,b
        cmp #3
        beq ++

          cmp #1
          beq +

            lda #(`procFadeIn)<<8
            sta lR44+1
            lda #<>procFadeIn
            sta lR44
            lda #0
            jsl rlProcEngineCreateProcByIndex
            bra ++

          +
          sep #$20
          lda bBufferINIDISP
          ora #15
          sta bBufferINIDISP
          rep #$20

        +
        jsl rlCheckActiveUnitCanto
        bcc +

          ldx wActiveUnitDeploymentOffset,b
          jsl rlDeployedUnitUnsetHiddenIfAlive

        +
        lda wSavedMapStep,b
        sta wGameStateStep,b
        rts

        .databank 0

    .endsection Unsorted81AD28Section


    .section Unsorted81AD6ASection

      .al
      .xl

      rsMapStepGameOver ; 81/AD6A

        .al
        .autsiz
        .databank ?

        ; Map step 12 (rlStartGameOverEvent sets it): unless an event is running, stops the music and fades to the game over screen.

        lda wEventEngineFlags,b
        bne +

          lda #$00E0
          jsl rlSendSoundCommand

          stz wGameStateRoutine1,b

          lda #<>rsSetupGameOverScreen
          sta aProcSystem.wInput0,b

          lda #(`procMainLoopChangeFade)<<8
          sta lR44+1
          lda #<>procMainLoopChangeFade
          sta lR44
          jsl rlProcEngineCreateProc

        +
        rts

        .databank 0

    .endsection Unsorted81AD6ASection


    .section Unsorted81AD8ESection

      .al
      .xl

      rsRunQueuedAIUnitEvent ; 81/AD8E

        .al
        .autsiz
        .databank ?

        ; Runs event action $21 for the AI unit that is about to act (turn, army, its AI and its character), when the AI has queued one (bit 7 of wChapterFlags).

        lda bUnknown000E7B,b
        bit #$0040
        beq _End

          bit #$0020
          bne _End

            lda wChapterFlags,b
            bit #$0080
            beq _End

              lda #$0080
              trb wChapterFlags,b

              ldx wAISelectedAIUnitOffset,b
              lda aAIUnitList[0].UnitRAMPointer,x
              sta wSelectedUnitDataRAMPointer,b

              lda #$0021
              sta bEventActionIdentifier,b
              lda wCurrentTurn,b
              sta wEventEngineArgument1,b
              lda wActiveFactionSlot,b
              sta wEventEngineArgument2,b
              jsl rlGetSelectedUnitAI
              sta wEventEngineArgument3,b
              jsl rlGetSelectedUnitCharacterID
              sta wEventEngineArgument4,b
              jsl rlGetAndRunChapterMapEventConditions

        _End
        rts

        .databank 0

    .endsection Unsorted81AD8ESection


    .section Unsorted81ADD8Section

      .al
      .xl

      rlRunQueuedUnitRelocation ; 81/ADD8

        .al
        .autsiz
        .databank ?

        ; Runs the queued relocation (wUnitRelocationType, aUnitRelocationRoutines) for wUnitRelocationDeploymentOffset and clears it. SEC if one ran. Called by the map step and the castle screen.

        phb
        phk
        plb

        lda wEventEngineFlags,b
        bne _CLC

          lda wUnitRelocationDeploymentOffset,b
          bmi _CLC

            tax
            lda aDeploymentTable._UnitRAMPointer,x
            sta wSelectedUnitDataRAMPointer,b

            lda wUnitRelocationType,b
            bmi _CLC

              asl a
              tax
              jsr (aUnitRelocationRoutines,x)

              lda #$FFFF
              sta wUnitRelocationDeploymentOffset,b
              bra +

        _CLC
        clc
        
        +
        plb
        rtl

        .databank 0

    .endsection Unsorted81ADD8Section


    .section Unsorted81AE02Section

      .al
      .xl

      aUnitRelocationRoutines ; 81/AE02

        .word <>rsRelocateToTile
        .word <>rsRelocateEscapedUnit
        .word <>rsRelocateCapturedUnit
        .word <>rsRelocateIntoCastle
        .word <>rsRelocateSortieFromCastle
        .word <>rsRelocateShowSeizePopUp
        .word <>rsRelocateChapterEndSavePrompt
        .word <>rsRelocateRemoveHelpedUnit
        .word <>rsRelocateShowItemPopUp
        .word <>rsRelocateRescuedUnits

      rlCheckQueuedRelocationMovesUnit ; 81/AE16

        .al
        .autsiz
        .databank ?

        ; After a map battle: SEC if the queued relocation takes the unit off the map. A move to a tile (type 0) is done at once; rescue (9) and going into a castle (3, unless the castle screen is to open) only answer SEC.

        phb
        phk
        plb

        lda wEventEngineFlags,b
        bne _CLC

          lda wUnitRelocationDeploymentOffset,b
          bmi _CLC

            lda wUnitRelocationType,b
            cmp #UNIT_RELOCATION_TO_TILE
            beq +

              cmp #UNIT_RELOCATION_RESCUED
              beq _SEC

                cmp #UNIT_RELOCATION_INTO_CASTLE
                bne _CLC

                  lda wChapterFlags,b
                  bit #$0040
                  beq _SEC

        _CLC
        clc
        
        -
        plb
        rtl
        
        +
        jsr rsRelocateToTile
        
        _SEC
        sec
        bra -

        .databank 0

      rsRelocateToTile ; 81/AE46

        .al
        .autsiz
        .databank ?

        ; Relocation type 0: moves the unit to the tile in wUnitRelocationLocationID (X low byte, Y high) and shows it.

        ldx wUnitRelocationDeploymentOffset,b


        lda wUnitRelocationLocationID,b
        sta wRoutineVariable1,b
        jsl rlUnknown84C996

        stz wTargetEventLocationEntry,b

        jsl rlDeployedUnitUnsetHiddenIfAlive

        lda wChapterFlags,b
        bit #$0020
        beq +

          jsl rlCastleRefreshUnitsAfterMapAction
        
        +
        sec
        rts

        .databank 0

      rsRelocateEscapedUnit ; 81/AE68

        .al
        .autsiz
        .databank ?

        ; Relocation type 1: the unit leaves (faction 7), its deployment is cleared and event action $17 runs with its character.

        lda #7
        jsl rlSetSelectedUnitFaction
        jsl rlGetSelectedUnitDeploymentOffset
        cmp #$00FF
        beq _SEC

          jsl rlClearUnitDeploymentData

          lda #$00FF
          jsl rlSetSelectedUnitDeploymentOffset

          lda #$0017
          sta bEventActionIdentifier,b

          jsl rlGetSelectedUnitCharacterID
          sta wEventEngineArgument1,b
          jsl rlGetAndRunChapterMapEventConditions

        _SEC
        sec
        rts

        .databank 0

    .endsection Unsorted81AE02Section


    .section Unsorted81AE96Section

      .al
      .xl

      rsRelocateCapturedUnit ; 81/AE96

        .al
        .autsiz
        .databank ?

        ; Relocation type 2: the captured unit is put in the castle wUnitRelocationLocationID.

        lda wTargetEventLocationEntry,b
        pha

        ldx wUnitRelocationDeploymentOffset,b
        lda wUnitRelocationLocationID,b
        jsl rlSetUnitResidingInCastle

        pla
        sta wTargetEventLocationEntry,b

        sec
        rts

        .databank 0

    .endsection Unsorted81AE96Section


    .section Unsorted81AEAASection

      .al
      .xl

      rsRelocateIntoCastle ; 81/AEAA

        .al
        .autsiz
        .databank ?

        ; Relocation type 3: the unit goes into the castle. With bit 6 of wChapterFlags the castle screen opens; in the castle screen (bit 5) its units are refreshed; otherwise event action 4 runs (character, home castle).


        ldx wUnitRelocationDeploymentOffset,b
        lda wUnitRelocationLocationID,b
        jsl rlSetUnitResidingInCastle

        stz wTargetEventLocationEntry,b

        jsl rlRefreshUnitWindow

        lda wChapterFlags,b
        bit #$0040
        beq +

          and #~($40)
          sta wChapterFlags,b

          stz wGameStateRoutine1,b

          lda #0
          jsl rlEnterCastleAtLocation
          bra _End
        
        +
        lda wChapterFlags,b
        bit #$0020
        beq +

          jsl rlCastleRefreshUnitsAfterMapAction
          bra _End
        
        +
        lda #4
        sta bEventActionIdentifier,b
        jsl rlGetSelectedUnitCharacterID
        sta wEventEngineArgument1,b

        jsl rlGetSelectedUnitHomeCastle
        sta wEventEngineArgument2,b

        jsl rlGetAndRunChapterMapEventConditions
        bcs _End

          jsl rlTryStartLoverHomeCastleConversation

        _End
        sec
        rts

        .databank 0

      rsRelocateSortieFromCastle ; 81/AF03

        .al
        .autsiz
        .databank ?

        ; Relocation type 4: the AI's unit leaves its castle (rlSortieUnitFromCastle) with sound $1A.

        lda wUnitRelocationLocationID,b
        sta wSelectedUnitDataRAMPointer,b
        jsl rlSortieUnitFromCastle
        lda #$001A
        jsl rlPlaySoundEffect2
        sec
        rts

        .databank 0

      rsOpenQueuedInventoryFullMenu ; 81/AF16

        .al
        .autsiz
        .databank ?

        ; Opens the inventory full menu for wInventoryFullDeploymentOffset when $70 is nonzero. SEC if it opened.

        lda $70
        and #$00FF
        beq _CLC

          lda wInventoryFullDeploymentOffset,b
          bmi _CLC

            tax
            lda aDeploymentTable._UnitRAMPointer,x
            sta aProcSystem.wInput0,b

            jsl rlOpenInventoryFullMenu

            lda #$FFFF
            sta wInventoryFullDeploymentOffset,b
            sec
            rts
        
        _CLC
        clc
        rts

        .databank 0

      rsOpenQueuedUnitMenu ; 81/AF38

        .al
        .autsiz
        .databank ?

        ; When bit 15 of wMapStateFlags is set: picks up the active unit and opens its unit menu in the mode in bits 0-1 (aQueuedUnitMenuOpeners). SEC unless the map step is 11.

        lda wMapStateFlags,b
        bpl _CLC

          lda wEventEngineFlags,b
          bne _CLC

            lda wMapCursorState,b
            cmp #MAP_CURSOR_TO_UNIT
            beq _CLC

              ldx wActiveUnitDeploymentOffset,b
              jsl rsStartMovingUnitSprite

              ldx wActiveUnitDeploymentOffset,b
              lda aDeploymentTable._UnitRAMPointer,x
              sta wSelectedUnitDataRAMPointer,b

              jsl rlGetSelectedUnitStates
              bit #UnitStateFielded
              bne +

                lda #UnitStateFielded
                jsl rlSetSelectedUnitStates
              
              +
              lda #$0008
              tsb wMapSystemFlags,b

              lda wMapStateFlags,b
              and #$0003
              sta $00

              phb
              jsl _AF81
              plb
              bra +
              
                _AF81
                lda $00
                asl a
                adc $00
                tax
                lda aQueuedUnitMenuOpeners,x
                sta $33
                sep #$20
                lda aQueuedUnitMenuOpeners+2,x
                sta $33+2
                pha
                plb
                rep #$20
                jml [$0033]

              +
              lda #$8000
              trb wMapStateFlags,b

              lda wGameStateStep,b
              cmp #MAP_STEP_RESUME
              beq _CLC

                sec
                rts

        _CLC
        clc
        rts

        .databank 0

      aQueuedUnitMenuOpeners ; 81/AFAE

        .long rlOpenUnitMenu
        .long rlOpenUnitMenuMode1
        .long rlOpenUnitMenuMode2

    .endsection Unsorted81AEAASection


    .section Unsorted81AFB7Section

      .al
      .xl

      rsRelocateShowSeizePopUp ; 81/AFB7

        .al
        .autsiz
        .databank ?

        ; Relocation type 5: the seize popup for castle wUnitRelocationLocationID, unless the chapter has ended (bit 10 of wChapterFlags).

        lda wChapterFlags,b
        bit #$0400
        bne +

          ldx wUnitRelocationDeploymentOffset,b
          lda #1
          sta aProcSystem.wInput2,b
          lda wUnitRelocationLocationID,b
          sta aProcSystem.wInput3,b
          jsl rlOpenSeizePopUp

        +
        sec
        rts

        .databank 0

      rsShowQueuedGoldPopUp ; 81/AFD4

        .al
        .autsiz
        .databank ?

        ; Shows the gold popup for wVillageGoldPopUpAmount (a village's gold) and clears it. SEC if it showed.

        lda wVillageGoldPopUpAmount,b
        bmi _CLC

          jsl rlRedrawVisibleMapTilemap

          lda wVillageGoldPopUpAmount,b
          sta aProcSystem.wInput2,b
          lda #$0D00
          sta aProcSystem.wInput3,b
          jsl rlOpenGoldPopUp

          lda #$FFFF
          sta wVillageGoldPopUpAmount,b
          sec
          bra +

        _CLC
        clc
        
        +
        rts

        .databank 0

        ; 81/AFF8

    .endsection Unsorted81AFB7Section


    .section Unsorted81AFF8Section

      .al
      .xl

      rsRelocateChapterEndSavePrompt ; 81/AFF8

        .al
        .xl
        .autsiz
        .databank ?

        ; Relocation type 6 (rlSaveChapterTurncount, the end of a chapter): opens the save prompt.

        jsl rlOpenSavePrompt
        sec
        rts

        .databank 0

        ; 81/AFFE

    .endsection Unsorted81AFF8Section


    .section Unsorted81AFFESection

      .al
      .xl

      rsRelocateRemoveHelpedUnit ; 81/AFFE

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Relocation type 7 (rlUnitHelp): the unit in wUnitRelocationLocationID is undeployed and deleted, with the scene of rlStartMapActionRewards.

        ldx wUnitRelocationLocationID,b
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlUndeployUnit
        jsl rlDeleteUnit
        jsl rlStartMapActionRewards
        sec
        rts

        .databank 0

        ; 81/B016

    .endsection Unsorted81AFFESection


    .section Unsorted81B016Section

      .al
      .xl

      rsRelocateShowItemPopUp ; 81/B016

        .al
        .xl
        .autsiz
        .databank ?

        ; Relocation type 8 (an event gave an item): shows the item popup for the item in wUnitRelocationLocationID.

        lda wUnitRelocationLocationID,b
        jsl rlGetItemRAMStructEntryByPlayerItemIndex
        jsl rlGetEffectiveItemIDByItemRAMStructEntry
        sta aProcSystem.wInput2,b
        lda #$0D00
        sta aProcSystem.wInput3,b
        jsl rlOpenItemPopUp
        sec
        rts

        .databank 0

        ; 81/B030

      rsRelocateRescuedUnits ; 81/B030

        .al
        .xl
        .autsiz
        .databank ?

        ; Relocation type 9 (the Rescue staff): the unit and the target go into the castle wUnitRelocationLocationID and the castle screen opens. A piece of unreachable code follows (event action 4, as in rsRelocateIntoCastle).

        ldx wUnitRelocationDeploymentOffset,b
        lda wUnitRelocationLocationID,b
        jsl rlSetUnitResidingInCastle
        lda aActionStructUnit2
        tax
        lda wUnitRelocationLocationID,b
        jsl rlSetUnitResidingInCastle
        stz wTargetEventLocationEntry,b
        jsl rlRefreshUnitWindow
        lda #$0040
        trb wChapterFlags,b
        phx
        stz wGameStateRoutine1,b
        lda #$0000
        jsl rlEnterCastleAtLocation
        plx
        bra _B086

        .byte $BF, $EB, $46, $7E, $8D, $6F, $05, $A9, $04, $00, $8D, $BC, $0E, $22, $33, $A3
        .byte $84, $8D, $BD, $0E, $22, $DA, $96, $84, $8D, $BF, $0E, $22, $BC, $82, $86, $B0
        .byte $04, $22, $D0, $ED, $8C


        _B086
        sec
        rts

        .databank 0

        ; 81/B088

    .endsection Unsorted81B016Section


    .section Unsorted81B088Section

      .al
      .xl

      rlHandleDefeatedUnit ; 81/B088

        .al
        .autsiz
        .databank ?

        ; For wDefeatedUnitDeploymentOffset: a defeated player lord (generation ID 1) starts the game over event; the unit is hidden unless a battle skill (bit 0 of TriggerableSkills) saved it; event action $17 runs (character, army). SEC if there was one.

        lda wEventEngineFlags,b
        bne _CLC

          lda wDefeatedUnitDeploymentOffset,b
          bmi _CLC

            tax
            lda aDeploymentTable._UnitRAMPointer,x
            sta wSelectedUnitDataRAMPointer,b

            lda aDeploymentTable._FactionSlot,x
            bne +

              jsl rlGetSelectedUnitGenerationID
              cmp #1
              bne +

                lda #0
                jsl rlStartGameOverEvent

            +
            lda aActionStructUnit1.TriggerableSkills
            ora aActionStructUnit2.TriggerableSkills
            bit #$0001
            bne +

              txa
              jsl rlDeployedUnitSetHiddenUnsetAlive

            +
            lda #$0017
            sta bEventActionIdentifier,b
            jsl rlGetSelectedUnitCharacterID
            sta wEventEngineArgument1,b

            jsl rlGetSelectedUnitFactionSlot
            sta wEventEngineArgument2,b

            jsl rlGetAndRunChapterMapEventConditions

            lda #$FFFF
            sta wDefeatedUnitDeploymentOffset,b
            sec
            bra +
        
        _CLC
        clc
        
        +
        rtl

        .databank 0

      rsResumeCantoMove ; 81/B0E5

        .al
        .autsiz
        .databank ?

        ; When bit 13 of wChapterFlags is set (rlCheckActiveUnitCanto): picks up the unit under the cursor again for its canto move. SEC if it did.

        lda wChapterFlags,b
        bit #$2000
        beq _CLC

          jsl rlSelectUnitAtCursor

          ldx wActiveUnitDeploymentOffset,b
          lda aDeploymentTable._UnitRAMPointer,x
          sta wSelectedUnitDataRAMPointer,b

          jsl rlGetSelectedUnitStates
          bit #UnitStateFielded
          bne +

            lda #UnitStateFielded
            jsl rlSetSelectedUnitStates
          
          +
          lda #$2000
          trb wChapterFlags,b
          sec
          bra +
        
        _CLC
        clc
        
        +
        rts

        .databank 0

      rsRunActionEndedEvents ; 81/B116

        .al
        .autsiz
        .databank ?

        ; Runs event action 3 for wActionEndedDeploymentOffset (character, X, Y, army): a unit ended its action on a tile. SEC if there was one.


        lda wActionEndedDeploymentOffset,b
        bmi _CLC

          tax
          lda aDeploymentTable._UnitRAMPointer,x
          sta wSelectedUnitDataRAMPointer,b

          lda #3
          sta bEventActionIdentifier,b
          jsl rlGetSelectedUnitCharacterID
          sta wEventEngineArgument1,b

          lda aDeploymentTable._XTilePosition,x
          sta wEventEngineArgument2,b
          lda aDeploymentTable._YTilePosition,x
          sta wEventEngineArgument3,b
          lda aDeploymentTable._FactionSlot,x
          sta wEventEngineArgument4,b
          jsl rlGetAndRunChapterMapEventConditions

          lda #$FFFF
          sta wActionEndedDeploymentOffset,b

          lda #$8000
          trb wChapterFlags,b
          sec
          bra +

        _CLC
        clc
        
        +
        rts

        .databank 0

      rlApplyBufferedDeploymentStates ; 81/B15A

        .al
        .autsiz
        .databank ?

        ; When bit 2 of wChapterFlags is set: copies aDeploymentTable._StateBuffer to _State for all 72 units. SEC if it did. Not during an event or map step 11.


        lda wEventEngineFlags,b
        bne _CLC

          lda wGameStateStep,b
          cmp #MAP_STEP_RESUME
          beq _CLC

            lda wChapterFlags,b
            bit #$0004
            beq _CLC

              ldx #(72-1) * size(word)

                -
                lda aDeploymentTable._StateBuffer,x
                sta aDeploymentTable._State,x
                dec x
                dec x
                bpl -

              lda #4
              trb wChapterFlags,b
              sec
              bra +

        _CLC
        clc
        
        +
        rtl

        .databank 0

      rlCheckActiveUnitCanto ; 81/B189

        .al
        .autsiz
        .databank ?

        ; Whether the active unit moves again (canto): alive, not defeated, with DeploymentStateCanto. Builds its range maps; if it can move, sets bits 13 and 15 of wChapterFlags (rsResumeCantoMove), otherwise opens its unit menu in mode 1. SEC if it has canto.

        phx
        lda bUnknown000E7B,b
        bit #$0040
        bne _CLC

        ldx wActiveUnitDeploymentOffset,b
        lda wChapterFlags,b
        bit #$0004
        beq +

          lda aDeploymentTable._StateBuffer,x
          and #~DeploymentStateGrayed
          sta aDeploymentTable._State,x

        +
        lda aDeploymentTable._State,x
        bit #DeploymentStateAlive
        beq _CLC

        bit #DeploymentStateDefeated
        bne _CLC

        bit #DeploymentStateCanto
        beq _CLC

        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        lda aDeploymentTable._XTilePosition,x
        sta wR10
        lda aDeploymentTable._YTilePosition,x
        sta wR11
        jsl rlBuildSelectedUnitRangeMaps
        bcc +

          jsl rlRequestUnitMenuMode1
          bcc _SEC

        +
        lda #$2000
        tsb wChapterFlags,b
        lda #$8000
        tsb wChapterFlags,b
        
        _SEC
        plx
        sec
        bra +
        
        _CLC
        plx
        clc
        
        +
        rtl

        .databank 0

      rlShowQueuedSeizePopUpUnused ; 81/B1ED

        .al
        .autsiz
        .databank ?

        ; Nothing reaches this. A variant of rsRelocateShowSeizePopUp that creates the seize popup as an event proc.

        lda wUnitRelocationDeploymentOffset,b
        bmi _End

          lda wUnitRelocationType,b
          cmp #UNIT_RELOCATION_SEIZE_POPUP
          bne _End

            lda wChapterFlags,b
            bit #$0400
            bne _End

              lda #1
              sta aProcSystem.wInput2,b
              lda wUnitRelocationLocationID,b
              sta aProcSystem.wInput3,b

              lda #(`procSeizePopUp)<<8
              sta lR44+1
              lda #<>procSeizePopUp
              sta lR44
              jsl rlEventEngineCreateProc
              lda #$FFFF
              sta wUnitRelocationDeploymentOffset,b

        _End
        rtl

        .databank 0

    .endsection Unsorted81B088Section


    .section Unsorted81B301Section

      .al
      .xl

      rlAdvanceToNextChapter ; 81/B301

        .al
        .xl
        .autsiz
        .databank ?

        ; Stops the music, counts the chapter up, clears wChapterFlags and fades to the chapter save screen (rsOpenChapterSaveTransition).

        phb
        php
        phk
        plb
        .databank $81
        lda #$00E0
        jsl rlSendSoundCommand
        inc wCurrentChapter,b
        stz wChapterFlags,b
        stz wGameStateRoutine1,b
        lda #<>rsOpenChapterSaveTransition
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        plp
        plb
        .databank $81
        rtl

        .databank 0

        ; 81/B32C

    .endsection Unsorted81B301Section


    .section Unsorted81B32CSection

      .al
      .xl

      rlStartGameOverEvent ; 81/B32C

        .al
        .autsiz
        .databank ?

        ; Starts the game over event (aGameOverEventIDs) for A: 0 the lord fell, 1 the player army was removed; the second pair is for chapters 6 on. Sets map step 12.

        phb
        php
        phk
        plb
        phx

        asl a
        tax

        lda wCurrentChapter,b
        cmp #6
        bcc +

          txa
          clc
          adc #4
          tax

        +
        lda aGameOverEventIDs,x
        jsl rlStartChapterEventByID
        lda #MAP_STEP_GAME_OVER
        sta wGameStateStep,b

        plx
        plp
        plb
        rtl

        .databank 0

      aGameOverEventIDs ; 81/B353


        .word $022E
        .word $022F
        .word $0230
        .word $0231

    .endsection Unsorted81B32CSection


    .section Unsorted84C5D7Section

      .al
      .xl

      rlCheckFactionTakesPhase ; 84/C5D7

        .al
        .autsiz
        .databank ?

        ; SEC if army slot A takes a phase: the player army always does; another needs a name, fielded living units and, if the chapter lists it (rlGetChapterFactionPhaseFlagsPointer), its event flag set.

        phb
        phx
        phy

        tax
        ora #0
        beq _SEC

          jsl rlGetFactionSlotNameID
          cmp #$00FF
          beq _CLC

          txa
          jsl rlCountFactionFieldedLivingUnits
          ora #0
          beq _CLC

            jsl rlGetChapterFactionPhaseFlagsPointer

            lda $24
            beq _SEC

              txa
              asl a
              clc
              adc $24
              tay

              sep #$20
              lda $24+2
              pha
              rep #$20
              plb

              lda $0000,b,y
              cmp #$FFFF
              beq _SEC

                lda $0001,b,y
                and #$00FF
                sta wEventEngineParameter1,b
                lda $0000,b,y
                and #$00FF
                jsl rlCheckIfEventFlagOfSpecifiedChapterSet
                bcc _CLC
        
        _SEC
        sec
        bra +
        
        _CLC
        clc
        
        +
        ply
        plx
        plb
        rtl

        .databank 0

        ; 84/C62E

    .endsection Unsorted84C5D7Section
