; The castle screen: the game state that runs while the player is inside a
; castle (states $0A-$0C, see include/GameStates.h). rsOpenCastleScreen sets the
; screen up and dispatches on wCastleScreenHandler (aCastleStateHandlers): the
; courtyard, the town, a conversation scene, the arena, or a reload after a battle.
; Every frame rlCastleScreenStep runs step wGameStateStep from
; aCastleScreenStepHandlers: the courtyard, the fade steps, the exits, and a
; setup/run pair for each facility (arena, augury, depot, class change,
; conversation, shop). Banks $80 and $8A.


    .section Unsorted80B641Section

      .al
      .xl

      rsRunCastleScreenVBlank ; 80/B641

        .al
        .xl
        .autsiz
        .databank ?

        ; The castle screen's VBlank routine: blanks the screen; sends the DMA queue (first
        ; calling rlUploadMapAnimations unless wCastleCursorState is 2 or the town), the palettes,
        ; OAM, HDMA and PPU registers and sound; reads the joypads; runs the game state
        ; routines and VBlank hooks; draws the courtyard unit sprites unless the town is up.

        sep #$20
        lda #$80
        sta $2100,b
        rep #$20
        lda bDMAArrayFlag,b
        and #$00FF
        bne _B663
        lda wCastleCursorState,b
        cmp #$0002
        beq _B663
        cmp #CASTLE_CURSOR_TOWN
        beq _B663
        jsl rlUploadMapAnimations

        _B663
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
        lda wCastleCursorState,b
        cmp #$0002
        beq _B69C
        cmp #CASTLE_CURSOR_TOWN
        beq _B69C
        jsl rlCastleDrawCourtyardUnitSprites

        _B69C
        jsl rlHideSprites
        jsl rlRunDialogueCycle
        jsl rlRunMapMenuUploadIfEnabled
        jsl rlUpdateSound
        rts

        .databank 0

        ; 80/B6AD

    .endsection Unsorted80B641Section


    .section Table80B6ADSection

      .al
      .xl

      aCastleMenuTilemapData ; 80/B6AD
        .byte $20, $20, $00, $00, $00, $00, $88, $83, $7E

    .endsection Table80B6ADSection


    .section Unsorted80B6B6Section

      .al
      .xl

      rsOpenCastleScreen ; 80/B6B6

        .al
        .xl
        .autsiz
        .databank ?

        ; The castle screen's opener: blanks the screen, resets the sprite, HDMA and IRQ
        ; engines, sets game state routines GAMESTATE_CASTLE_SCREEN_SETUP/UPKEEP and the
        ; castle VBlank routine, then sets up what wCastleScreenHandler asks for.

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
        lda #$0000
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
        jsl rlActiveSpriteEngineReset
        jsl rlResetHDMAEngine
        jsl rlResetIRQEngine
        jsl rlClearUnitWindowAndTerrainWindowProcs
        jsl rlResetRAMStructAndAreaVariables
        jsl rlInitMapMenus
        jsl rlResetMenuOptionStack
        lda #GAMESTATE_CASTLE_SCREEN_SETUP
        sta wGameStateRoutine1,b
        lda #GAMESTATE_CASTLE_SCREEN_UPKEEP
        sta wGameStateRoutine2,b
        lda #<>rsRunCastleScreenVBlank
        sta wVBlankPointer
        lda #<>rsRunFrameTasks
        sta wMainLoopPointer
        lda #$0002
        sta aDialogue.wUnknown0018D0,b
        lda #$0020
        tsb wChapterFlags,b
        jsl rlDispatchCastleState
        jsl rlPauseMapTileAnimation
        jsl rlEnableVBlank
        sep #$20
        lda #$00
        sta bBufferINIDISP
        rep #$20
        plp
        rts

        .databank 0

        ; 80/B74B

    .endsection Unsorted80B6B6Section


    .section Unsorted80B74BSection

      .al
      .xl

      rlReturnToCastleFromArena ; 80/B74B

        .al
        .xl
        .autsiz
        .databank ?

        ; After an arena battle: rebuilds the castle's unit lists if the castle entered is the
        ; player's home castle, restores the unit (wCastleSavedUnitRAMPointer) and reopens
        ; the castle screen at the arena (CASTLE_SCREEN_ARENA).

        lda #$0000
        jsl rlGetFactionSlotLocationID
        cmp wEnteredCastleLocationID,b
        bne _B76A
        lda #$0000
        jsl rlGetLocationEventDataEntry
        jsl rlBuildCastleUnitList
        jsl rlClearMovementMapBuffer
        jsl rlCastleBuildCourtyardTables

        _B76A
        lda #CASTLE_SCREEN_ARENA
        sta wCastleScreenHandler,b
        lda wCastleSavedUnitRAMPointer,b
        sta wSelectedUnitDataRAMPointer,b
        lda #<>rsOpenCastleScreen
        sta wMainLoopPointer
        clc
        rtl

        .databank 0

        ; 80/B77D

        ; Unreachable: it follows a return.
        sec
        rtl

    .endsection Unsorted80B74BSection


    .section Unsorted80B77FSection

      .al
      .xl

      rlDispatchCastleState ; 80/B77F

        .al
        .xl
        .autsiz
        .databank ?

        ; Jumps to the routine for wCastleScreenHandler (aCastleStateHandlers).

        lda wCastleScreenHandler,b
        asl a
        tax
        jmp (aCastleStateHandlers,x)

        .databank 0

        ; 80/B787

    .endsection Unsorted80B77FSection


    .section Table80B787Section

      .al
      .xl

      aCastleStateHandlers ; 80/B787

        ; Jump table of rlDispatchCastleState.
        .word <>rlOpenCastleCourtyard
        .word <>rlResumeCastleTown
        .word <>rlEnterCastleConversation
        .word <>rlEnterCastleArenaScreen
        .word <>rlOpenCastleCourtyard
        .word <>rlReloadChapterMapAndOpenCastle

    .endsection Table80B787Section


    .section Unsorted80B793Section

      .al
      .xl

      rlEnterCastleConversation ; 80/B793

        .al
        .xl
        .autsiz
        .databank ?

        ; CASTLE_SCREEN_CONVERSATION: clears the courtyard tables; if wLoverHomeCastleConversationPending is
        ; set, clears it and runs rlBuildLoverHomeCastleConversation; sets up the conversation scene.

        jsl rlClearMovementMapBuffer
        lda wLoverHomeCastleConversationPending,b
        beq _B7A3
        stz wLoverHomeCastleConversationPending,b
        jsl rlBuildLoverHomeCastleConversation

        _B7A3
        lda #CASTLE_CURSOR_TOWN
        sta wCastleCursorState,b
        jsr rsSetCastleCourtyardBGSettings
        jsl rlConversationSceneSetup
        rtl

        .databank 0

        ; 80/B7B1

    .endsection Unsorted80B793Section


    .section Unsorted80B7B1Section

      .al
      .xl

      rlEnterCastleArenaScreen ; 80/B7B1

        .al
        .xl
        .autsiz
        .databank ?

        ; CASTLE_SCREEN_ARENA: sets up the arena screen (arena sub-state 2); if the castle
        ; entered is not the player's home castle, the next reopen goes to the town.

        lda #CASTLE_CURSOR_TOWN
        sta wCastleCursorState,b
        jsr rsSetCastleCourtyardBGSettings
        lda #KEEPER_ARENA
        sta wKeeper
        jsl rlArenaScreenSetup
        lda #$0002
        sta wMenuState,b
        lda #$0000
        jsl rlGetFactionSlotLocationID
        cmp wEnteredCastleLocationID,b
        beq _B7DD
        lda #CASTLE_SCREEN_TOWN
        sta wCastleScreenHandler,b

        _B7DD
        rtl

        .databank 0

        ; 80/B7DE

    .endsection Unsorted80B7B1Section


    .section Unsorted80B7DESection

      .al
      .xl

      rlReloadChapterMapAndOpenCastle ; 80/B7DE

        ; Runs on into built code at the end.
        .al
        .xl
        .autsiz
        .databank ?

        ; CASTLE_SCREEN_RELOAD_MAP: reloads the chapter map, the location events and the
        ; music; rebuilds the unit lists for the player's home castle; then opens the courtyard.

        jsl rlLoadChapterMapLayout
        lda wEventLocationEntry,b
        pha
        jsl rlUpdateAllLocationEvents
        jsl rlApplyAllActiveMapChanges
        pla
        sta wEventLocationEntry,b
        lda #CASTLE_SCREEN_COURTYARD
        sta wCastleScreenHandler,b
        jsl rlResumePhaseMusic
        jsl rlStepMusicScript
        lda #$0000
        jsl rlGetFactionSlotLocationID
        cmp wEnteredCastleLocationID,b
        bne rlOpenCastleCourtyard
        lda #$0000
        jsl rlGetLocationEventDataEntry
        jsl rlBuildCastleUnitList
        jsl rlCastleBuildCourtyardTables

        .databank 0

        ; 80/B81B

    .endsection Unsorted80B7DESection


    .section Unsorted80B81BSection

      .al
      .xl

      rlOpenCastleCourtyard ; 80/B81B

        .al
        .xl
        .autsiz
        .databank ?

        ; CASTLE_SCREEN_COURTYARD: sets up the courtyard and queues sound command $F7.

        jsl rlSetupCastleCourtyardDisplay
        lda #$00F7
        jsl rlQueueSoundCommand
        rtl

        .databank 0

        ; 80/B827

      rlSetupCastleCourtyardDisplay ; 80/B827

        .al
        .xl
        .autsiz
        .databank ?

        ; Loads the courtyard's graphics, tilemaps and palettes, puts the grid cursor on its
        ; slot and draws the info line.

        rep #$20
        jsl rlClearVRAM6000
        jsl rlLoadMapMenuDecompression80B09B
        jsl rlDMAByStruct

          .structDMAToVRAM g4bppShopScreen, $4000, $80, $0000

        jsl rlDMAByStruct

          .structDMAToVRAM g4bppCursorSprites, $0400, $80, $C000

        jsl rlDMAByStruct

          .structDMAToVRAM gCastleCourtyardTilemap, $0800, $80, $A000

        ldx #$06FE
        lda #$00FF

        _B85E
        sta aBG2TilemapBuffer.Page1,x
        dec x
        dec x
        bpl _B85E
        jsl rlDMAByStruct

          .structDMAToVRAM $7E7B88, $0700, $80, $A800

        jsl rlDMAByStruct

          .structDMAToVRAM g2bppShopLabels, $0800, $80, $9800

        lda #(`aDecompressionDMAEntry80B99D)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry80B99D
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        lda #(`aDecompressionDMAEntry80B9A5)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry80B9A5
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        jsl rlGetEventLocationEntryID
        sta wEnteredCastleLocationID,b
        ldx #$00FE

        _B8A6
        lda aUnknown8C9800,x
        sta aBGPaletteBuffer,b,x
        dec x
        dec x
        bpl _B8A6
        ldx #$00FE

        _B8B4
        lda aCastleScreenOAMPalettes,x
        sta aOAMPaletteBuffer,b,x
        dec x
        dec x
        bpl _B8B4
        ldx #$001E

        _B8C2
        lda aMapAndCastleSpriteOAMPalettes,x
        sta aOAMPaletteBuffer,b,x
        dec x
        dec x
        bpl _B8C2
        jsl rlLoadWindowGraphics
        sep #$20
        rep #$10
        ldx #<>gcUnknownC02542
        stx DecompressionVariables
        lda #`gcUnknownC02542
        sta $CA
        ldx #$8F88
        stx $CB
        lda #$7E
        sta $CD
        rep #$30
        jsl rlDecompressor
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8F88, $0400, $80, $6C00

        sep #$20
        lda #$03
        sta bBufferWOBJSEL
        rep #$20
        stz wCastleCursorState,b
        ldx #$07FE
        lda #$00FF

        _B90B
        sta aBG3TilemapBuffer,x
        dec x
        dec x
        bpl _B90B
        jsl rlClearMovementMapBuffer
        jsl rlCastleBuildCourtyardTables
        jsl rlUploadAllStandingMapSprites
        lda wCastleGridSlot,b
        asl a
        tax
        lda aCastleGridCursorX,x
        sta wCastleGridCursorXPixel,b
        lda aCastleGridCursorY,x
        sta wCastleGridCursorYPixel,b
        ldx wActiveUnitDeploymentOffset,b
        lda aDeploymentTable._UnitRAMPointer,x
        beq _B97B
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitHomeCastle
        bcs _B97B
        cmp wEnteredCastleLocationID,b
        bne _B97B
        jsl rlGetSelectedUnitGenerationID
        sta wCastleGridSlot,b
        lda wCastleGridSlot,b
        dec a
        asl a
        tax
        lda wCurrentChapter,b
        cmp #$0006
        bcs _B964
        lda aCastleCourtyardSpotsGen1,x
        bra _B968


        _B964
        lda aCastleCourtyardSpotsGen2,x

        _B968
        sta wCastleGridSlot,b
        asl a
        tax
        lda aCastleGridCursorX,x
        sta wCastleGridCursorXPixel,b
        lda aCastleGridCursorY,x
        sta wCastleGridCursorYPixel,b

        _B97B
        jsl rlCastleDrawInfoLine
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0800, $80, $B000

        jsr rsSetCastleCourtyardBGSettings
        sep #$20
        lda #$00
        sta bBufferCGADSUB
        rep #$20
        stz wGameStateStep,b
        rtl

        .databank 0

        ; 80/B99B

        ; Unused: 2 zero bytes.
        .fill 2, $00

    .endsection Unsorted80B81BSection


    .section Unsorted80B9ADSection

      .al
      .xl

      rlClearMovementMapBuffer ; 80/B9AD

        .al
        .xl
        .autsiz
        .databank ?

        ; Zeroes $0C38 bytes from aMovementMap, which the castle's tables reuse.

        ldx #$0C37
        lda #$0000

        _B9B3
        sta aMovementMap,x
        dec x
        dec x
        bpl _B9B3
        rtl

        .databank 0

        ; 80/B9BC

    .endsection Unsorted80B9ADSection


    .section Unsorted80B9BCSection

      .al
      .xl

      rsSetCastleCourtyardBGSettings ; 80/B9BC

        .al
        .xl
        .autsiz
        .databank ?

        ; The courtyard's layer and color math settings: TM=$15, TS=0, CGWSEL=0, CGADSUB=$81, WH1=$FF, windows off.

        sep #$20
        stz bBufferW12SEL
        stz bBufferW34SEL
        stz bBufferWOBJSEL
        lda #$15
        sta bBufferTM
        lda #$00
        sta bBufferTS
        lda bBufferBGMODE
        and #$FF
        sta bBufferBGMODE
        lda #$00
        sta bBufferCGWSEL
        lda #$81
        sta bBufferCGADSUB
        lda #$FF
        sta bBufferWH1
        rep #$20
        rts

        .databank 0

        ; 80/B9E1

    .endsection Unsorted80B9BCSection


    .section Unsorted80B9E1Section

      .al
      .xl

      rsSetCastleTownBGSettings ; 80/B9E1

        .al
        .xl
        .autsiz
        .databank ?

        ; The town's layer and color math settings: TM=$16, TS=0, CGWSEL=0, CGADSUB=$82, windows off.

        sep #$20
        stz bBufferW12SEL
        stz bBufferW34SEL
        stz bBufferWOBJSEL
        lda #$16
        sta bBufferTM
        lda #$00
        sta bBufferTS
        lda bBufferBGMODE
        and #$FF
        sta bBufferBGMODE
        lda #$00
        sta bBufferCGWSEL
        lda #$82
        sta bBufferCGADSUB
        rep #$20
        rts

        .databank 0

        ; 80/BA02

    .endsection Unsorted80B9E1Section


    .section Unsorted80BA02Section

      .al
      .xl

      rlResumeCastleTown ; 80/BA02

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; CASTLE_SCREEN_TOWN: a unit entered the castle from the map. Runs chapter event action 6
        ; (character, castle); if an event runs, saves the unit in wCastleEventUnit and waits in
        ; step $02. Otherwise plays the castle's song and opens the town with the unit's portrait.

        lda wCastleSavedUnitRAMPointer,b
        cmp #$FFFF
        beq _BA36
        sta wSelectedUnitDataRAMPointer,b
        lda #$0006
        sta bEventActionIdentifier,b
        jsl rlGetSelectedUnitCharacterID
        sta wEventEngineArgument1,b
        lda wEnteredCastleLocationID,b
        sta wEventEngineArgument2,b
        jsl rlGetAndRunChapterMapEventConditions
        bcc _BA36
        lda wSelectedUnitDataRAMPointer,b
        sta wCastleEventUnit,b
        lda #CASTLE_STEP_WAIT
        sta wGameStateStep,b
        inc wGameStateRoutine1,b
        rtl


        _BA36
        lda @l wCastleSavedUnitRAMPointer
        sta wSelectedUnitDataRAMPointer,b
        jsl rlPlayCastleSong
        jsl rlSetupCastleTownDisplay
        jsl rlGetSelectedUnitCharacterID
        jsl rlLoadUnitPortrait
        jsl rlCastleFillVRAM2400
        rtl

        .databank 0

        ; 80/BA52

    .endsection Unsorted80BA02Section


    .section Unsorted80BA52Section

      .al
      .xl

      rlSetupCastleTownDisplay ; 80/BA52

        .al
        .xl
        .autsiz
        .databank ?

        ; Loads the town screen: graphics, the button tilemap (aCastleTownButtonTilemap), the castle's
        ; name, the missing facilities blanked, palettes and the window HDMA; puts the cursor
        ; on the buttons and moves to step $01.

        rep #$20
        jsl rlClearVRAM6000
        jsl rlDMAByStruct

          .structDMAToVRAM g4bppShopScreen, $2000, $80, $0000

        jsl rlDMAByStruct

          .structDMAToVRAM g4bppCursorSprites, $0400, $80, $C000

        jsl rlDMAByStruct

          .structDMAToVRAM g2bppShopLabels, $0800, $80, $9800

        lda #(`aDecompressionDMAEntry80BB45)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry80BB45
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        lda #(`aDecompressionDMAEntry80BB55)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry80BB55
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        lda #(`aDecompressionDMAEntry80BB4D)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry80BB4D
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        ldx #$07FE
        lda #$00FF

        _BAAF
        lda aCastleTownButtonTilemap,x
        sta aBG3TilemapBuffer,x
        dec x
        dec x
        bpl _BAAF
        lda #(`aCastleMenuTilemapData)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aCastleMenuTilemapData
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$3000
        sta aCurrentTilemapInfo,b
        jsl rlGetEventLocationEntryCastleName
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$010C
        jsl rlDrawMenuTextLine
        jsl rlCastleBlankMissingFacilities
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0700, $80, $B000

        ldx #$01FE

        _BAF6
        lda aCastleTownBGPalettes,x
        sta aBGPaletteBuffer,b,x
        dec x
        dec x
        bpl _BAF6
        ldx #$001E

        _BB04
        lda aMapAndCastleSpriteOAMPalettes,x
        sta aOAMPaletteBuffer,b,x
        dec x
        dec x
        bpl _BB04
        sep #$20
        lda #$03
        sta bBufferWOBJSEL
        lda #$16
        sta bBufferTM
        lda #$00
        sta bBufferTS
        lda #$82
        sta bBufferCGADSUB
        rep #$20
        stz wBufferBG2VOFS
        lda #CASTLE_CURSOR_TOWN
        sta wCastleCursorState,b
        lda #(`aUnknown8A9C56)<<8
        sta lR44+1
        lda #<>aUnknown8A9C56
        sta lR44
        jsl rlHDMAEngineCreateEntry
        jsr rsSetCastleTownBGSettings
        lda #CASTLE_STEP_COURTYARD
        sta wGameStateStep,b
        rtl

        .databank 0

        ; 80/BB43

        ; Unused: 2 zero bytes.
        .fill 2, $00

    .endsection Unsorted80BA52Section


    .section Unsorted80BB5DSection

      .al
      .xl

      rlReturnToCastleScreen ; 80/BB5D

        .al
        .xl
        .autsiz
        .databank ?

        ; Rebuilds the castle unit list for the player's home castle and reopens the castle
        ; screen at the courtyard.

        lda #$0000
        jsl rlGetFactionSlotLocationID
        jsl rlGetLocationEventDataEntry
        jsl rlCenterCameraOnLocation
        jsl rlBuildCastleUnitList
        lda #CASTLE_SCREEN_COURTYARD
        sta wCastleScreenHandler,b
        lda #<>rsOpenCastleScreen
        sta wMainLoopPointer
        rtl

        .databank 0

        ; 80/BB7C

    .endsection Unsorted80BB5DSection


    .section Unsorted80BB7CSection

      .al
      .xl

      rlFadeToCastleScreen ; 80/BB7C

        .al
        .xl
        .autsiz
        .databank ?

        ; Rebuilds the castle unit list and fades into the castle screen at the courtyard.

        lda #CASTLE_SCREEN_COURTYARD
        sta wCastleScreenHandler,b
        jsl rlBuildCastleUnitList
        lda #<>rsOpenCastleScreen
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 80/BB9B

    .endsection Unsorted80BB7CSection


    .section Unsorted8A8000Section

      .al
      .xl

      rlCastleScreenUpkeep ; 8A/8000

        .al
        .xl
        .autsiz
        .databank ?

        ; Game state routine $0A, every frame while the castle screen is up: does nothing in effect. It compares wCastleCursorState with 2 and 3, but every path returns.

        lda wCastleCursorState,b
        cmp #$0002
        beq _800D
        cmp #CASTLE_CURSOR_TOWN
        beq _800D

        _800D
        rtl

        .databank 0

        ; 8A/800E

    .endsection Unsorted8A8000Section


    .section Unsorted8A800ESection

      .al
      .xl

      rlCastleScreenSetup ; 8A/800E

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Game state routine $0B, once: builds the RAM area at $7FB16C; unless wCastleScreenHandler is 2, turns on active sprites and fades in (else stays blank); zeroes the BG scroll unless wConversationExitMode is 4; moves on to $0C.

        lda #$7F00
        sta lR18+1
        lda #$B16C
        sta lR18
        lda #$0001
        sta wStructIndex,b
        lda #$4E93
        jsl rlBuildRAMAreaHeaderAndGuidingEntry
        lda wCastleScreenHandler,b
        cmp #CASTLE_SCREEN_CONVERSATION
        beq _8041
        jsl rlEnableActiveSpriteEngine
        lda #(`procFadeIn)<<8
        sta lR44+1
        lda #<>procFadeIn
        sta lR44
        jsl rlProcEngineCreateProc
        bra _8049


        _8041
        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20

        _8049
        lda wConversationExitMode,b
        cmp #CONVERSATION_EXIT_CALLBACK
        beq _805D
        stz wBufferBG1VOFS
        stz wBufferBG2VOFS
        stz wBufferBG3VOFS
        stz wBufferBG1HOFS
        stz wBufferBG2HOFS
        stz wBufferBG3HOFS

        _805D
        inc wGameStateRoutine1,b
        rtl

        .databank 0

        ; 8A/8061

    .endsection Unsorted8A800ESection


    .section Unsorted8A8061Section

      .al
      .xl

      rlCastleScreenStep ; 8A/8061

        .al
        .xl
        .autsiz
        .databank ?

        ; Game state routine $0C, every frame: rlApplyBufferedDeploymentStates, rlRunQueuedUnitRelocation, then the routine for wGameStateStep from aCastleScreenStepHandlers.

        phb
        php
        phk
        plb
        .databank $8A
        jsl rlApplyBufferedDeploymentStates
        jsl rlRunQueuedUnitRelocation
        lda wGameStateStep,b
        asl a
        tax
        jsr (aCastleScreenStepHandlers,x)
        plp
        plb
        .databank $8A
        rtl

        .databank 0

        ; 8A/8078

    .endsection Unsorted8A8061Section


    .section Table8A8078Section

      .al
      .xl

      aCastleScreenStepHandlers ; 8A/8078

        ; Jump table of rlCastleScreenStep.
        .word <>rsCastleStepCourtyardStart
        .word <>rsCastleStepCourtyard
        .word <>rsCastleStepWait
        .word <>rsCastleStepArenaSetup
        .word <>rsCastleStepArena
        .word <>rsCastleStepAugurySetup
        .word <>rsCastleStepAugury
        .word <>rsCastleStepDepotSetup
        .word <>rsCastleStepDepot
        .word <>rsCastleStepClassChangeSetup
        .word <>rsCastleStepClassChange
        .word <>rsCastleStepConversationSetup
        .word <>rsCastleStepConversation
        .word <>rsCastleStepShopSetup
        .word <>rsCastleStepShop
        .word <>rsCastleStepFadeOut
        .word <>rsCastleStepFadeIn
        .word <>rsCastleStepReturnToCourtyard
        .word <>rsCastleStepReopenTownSameSong
        .word <>rsCastleStepExitToMapNoReset
        .word <>rsCastleStepReturnToCourtyard
        .word <>rsCastleStepReopenTown
        .word <>rsCastleStepExitToMap

    .endsection Table8A8078Section


    .section Unsorted8A80A6Section

      .al
      .xl

      rsCastleStepCourtyardStart ; 8A/80A6

        .al
        .xl
        .autsiz
        .databank ?

        ; Step $00: runs the courtyard; once no song is playing, queues sound command $F7 and moves to step $01.

        jsl rlCastleCourtyardStep
        lda wMusicID,b
        bne _80BC
        lda #$00F7
        jsl rlQueueSoundCommand
        lda #CASTLE_STEP_COURTYARD
        sta wGameStateStep,b

        _80BC
        rts

        .databank 0

        ; 8A/80BD

      rsCastleStepCourtyard ; 8A/80BD

        .al
        .xl
        .autsiz
        .databank ?

        ; Step $01: runs the courtyard (rlCastleCourtyardStep).

        jsl rlCastleCourtyardStep
        rts

        .databank 0

        ; 8A/80C2

      rsCastleStepWait ; 8A/80C2

        .al
        .xl
        .autsiz
        .databank ?

        ; Step $02: does nothing; used while a fade proc or another screen takes over.

        rts

        .databank 0

        ; 8A/80C3

    .endsection Unsorted8A80A6Section


    .section Unsorted8A80C3Section

      .al
      .xl

      rsCastleStepArenaSetup ; 8A/80C3

        .al
        .xl
        .autsiz
        .databank ?

        ; Step $03: sets up the arena screen.

        jsl rlArenaScreenSetup
        rts

        .databank 0

        ; 8A/80C8

    .endsection Unsorted8A80C3Section


    .section Unsorted8A80C8Section

      .al
      .xl

      rsCastleStepArena ; 8A/80C8

        .al
        .xl
        .autsiz
        .databank ?

        ; Step $04: runs the arena menu.

        jsl rlArenaMenuRunStep
        rts

        .databank 0

        ; 8A/80CD

    .endsection Unsorted8A80C8Section


    .section Unsorted8A80CDSection

      .al
      .xl

      rsCastleStepAugurySetup ; 8A/80CD

        .al
        .xl
        .autsiz
        .databank ?

        ; Step $05: sets up the augury (fortune teller) screen.

        jsl rlAuguryScreenSetup
        rts

        .databank 0

        ; 8A/80D2

      rsCastleStepAugury ; 8A/80D2

        .al
        .xl
        .autsiz
        .databank ?

        ; Step $06: runs the augury.

        jsl rlAuguryScreenStep
        rts

        .databank 0

        ; 8A/80D7

      rsCastleStepDepotSetup ; 8A/80D7

        .al
        .xl
        .autsiz
        .databank ?

        ; Step $07: sets up the depot screen.

        jsl rlDepotScreenSetup
        rts

        .databank 0

        ; 8A/80DC

      rsCastleStepDepot ; 8A/80DC

        .al
        .xl
        .autsiz
        .databank ?

        ; Step $08: runs the depot.

        jsl rlDepotScreenStep
        rts

        .databank 0

        ; 8A/80E1

      rsCastleStepClassChangeSetup ; 8A/80E1

        .al
        .xl
        .autsiz
        .databank ?

        ; Step $09: sets up the class change screen.

        jsl rlClassChangeScreenSetup
        rts

        .databank 0

        ; 8A/80E6

      rsCastleStepClassChange ; 8A/80E6

        .al
        .xl
        .autsiz
        .databank ?

        ; Step $0A: runs the class change screen.

        jsl rlClassChangeScreenStep
        rts

        .databank 0

        ; 8A/80EB

      rsCastleStepShopSetup ; 8A/80EB

        .al
        .xl
        .autsiz
        .databank ?

        ; Step $0D: sets up a shop screen (item shop, secondhand shop or repair shop).

        jsl rlShopScreenSetup
        rts

        .databank 0

        ; 8A/80F0

      rsCastleStepShop ; 8A/80F0

        .al
        .xl
        .autsiz
        .databank ?

        ; Step $0E: runs the shop.

        jsl rlShopScreenStep
        rts

        .databank 0

        ; 8A/80F5

    .endsection Unsorted8A80CDSection


    .section Unsorted8A80F5Section

      .al
      .xl

      rsCastleStepConversationSetup ; 8A/80F5

        .al
        .xl
        .autsiz
        .databank ?

        ; Step $0B: sets up the castle conversation scene.

        jsl rlConversationSceneSetup
        rts

        .databank 0

        ; 8A/80FA

    .endsection Unsorted8A80F5Section


    .section Unsorted8A80FASection

      .al
      .xl

      rsCastleStepConversation ; 8A/80FA

        .al
        .xl
        .autsiz
        .databank ?

        ; Step $0C: runs the castle conversation scene.

        jsl rlConversationSceneStep
        rts

        .databank 0

        ; 8A/80FF

      rsCastleStepFadeIn ; 8A/80FF

        .al
        .xl
        .autsiz
        .databank ?

        ; Step $10: raises the brightness one level a frame, then moves to the step in wNextMenuState.

        jsr rsCastleDrawFadingPortrait
        sep #$20
        lda bBufferINIDISP
        and #$0F
        cmp #$0F
        beq _8111
        inc bBufferINIDISP
        rep #$20
        rts


        _8111
        .as
        rep #$20
        lda wNextMenuState,b
        sta wGameStateStep,b
        rts

        .databank 0

        ; 8A/811A

      rsCastleStepFadeOut ; 8A/811A

        .al
        .xl
        .autsiz
        .databank ?

        ; Step $0F: lowers the brightness one level a frame, then blanks the screen and moves to the step in wNextMenuState.

        jsr rsCastleDrawFadingPortrait
        sep #$20
        lda bBufferINIDISP
        and #$0F
        beq _812A
        dec bBufferINIDISP
        rep #$20
        rts


        _812A
        .as
        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        lda wNextMenuState,b
        sta wGameStateStep,b
        rts

        .databank 0

        ; 8A/8139

      rsCastleStepReturnToCourtyard ; 8A/8139

        .al
        .xl
        .autsiz
        .databank ?

        ; Steps $11 and $14: reloads the courtyard screen and fades in to step $00.

        lda #$00F7
        jsl rlQueueSoundCommand
        jsr rsCastleLoadCourtyardScreen
        lda #$0000
        sta wCastleFadePortrait
        lda #CASTLE_STEP_FADE_IN
        sta wGameStateStep,b
        lda #CASTLE_STEP_COURTYARD_START
        sta wNextMenuState,b
        sep #$20
        lda #$00
        sta bBufferINIDISP
        rep #$20
        rts

        .databank 0

        ; 8A/815F

      rsCastleStepReopenTown ; 8A/815F

        .al
        .xl
        .autsiz
        .databank ?

        ; Step $15: starts the castle's song and reopens the town screen; step $12 enters at rsCastleStepReopenTownSameSong.

        jsl rlDisableVBlank
        jsl rlResetHDMAEngine
        jsl rlPlayCastleSong
        jsl rlEnableVBlank

      rsCastleStepReopenTownSameSong ; 8A/816F
        ; Step $12 enters here: reopens the town without changing the song.
        jsl rlCastleOpenTown
        rts

        .databank 0

        ; 8A/8174

      rsCastleStepExitToMap ; 8A/8174

        .al
        .xl
        .autsiz
        .databank ?

        ; Step $16: once the screen is fully bright, fades out (sound command $E8) and returns to the map (procMainLoopChangeFade into $80/B122); moves to step $02.

        jsl rlResumePhaseMusic

      rsCastleStepExitToMapNoReset ; 8A/8178
        ; Step $13 enters here, skipping rlResumePhaseMusic. Nothing found selects step $13.
        lda #$00E8
        jsl rlQueueSoundCommand
        sep #$20
        lda bBufferINIDISP
        rep #$20
        and #$000F
        cmp #$000F
        beq _8191
        jml _81C3


        _8191
        lda #(`procFadeIn)<<8
        sta lR44+1
        lda #<>procFadeIn
        sta lR44
        jsl rlProcEngineFindProc
        bcs _81C3
        lda #<>rsReturnToMapMainLoop
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        bcs _81C3
        lda #$0000
        sta wMainGameMode,b
        lda #CASTLE_STEP_WAIT
        sta wGameStateStep,b

        _81C3
        rts

        .databank 0

        ; 8A/81C4

      rsCastleDrawFadingPortrait ; 8A/81C4

        .al
        .xl
        .autsiz
        .databank ?

        ; During the fade steps, draws the portrait chosen by wCastleFadePortrait (1 rsPushUnitPortraitSprites, 2 rsPushCastleListSprites, 3 rsPushCourtyardPortraitSprites).

        rep #$20
        lda wCastleFadePortrait
        cmp #$0000
        beq _81DE
        cmp #$0001
        beq _81DF
        cmp #$0002
        beq _81F1
        cmp #$0003
        beq _81F6

        _81DE
        rts


        _81DF
        lda #$00A0
        sta wR0
        lda #$0060
        sta wR1
        ldx #$0000
        jsr rsPushUnitPortraitSprites
        bra _81DE


        _81F1
        jsr rsPushCastleListSprites
        bra _81DE


        _81F6
        lda #$00A0
        sta wR0
        lda #$0060
        sta wR1
        ldx #$0000
        jsr rsPushCourtyardPortraitSprites
        bra _81DE

        .databank 0

        ; 8A/8208

    .endsection Unsorted8A80FASection
