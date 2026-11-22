; Castle interior screen VBlank, substate dispatch, courtyard/unit menu setup, and exits.


    .section Unsorted80B641Section

      .al
      .xl

      rsRunCastleScreenVBlank ; 80/B641

        .al
        .xl
        .autsiz
        .databank ?

        ; Castle screen VBlank checking $0891, DMA, OAM, HDMA, PPU, sprites, game state, sound

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
        cmp #$0003
        beq _B663
        jsl rlUnknown88CD68

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
        cmp #$0003
        beq _B69C
        jsl rlUnknown8A98D0

        _B69C
        jsl rlHideSprites
        jsl rlUnknown9181F6
        jsl rlUnknown858728
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

        ; Resets engines/PPU, sets game state $0B/$0A, installs rsRunCastleScreenVBlank, dispatches $088B

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
        jsl rlUnknown8780AA
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
        tsb wUnknown000D79,b
        jsl rlDispatchCastleState
        jsl rlUnknown88CD61
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

        ; Restores home castle/$089B unit, sets $088B=3, installs rsOpenCastleScreen after arena battle

        lda #$0000
        jsl rlGetFactionSlotLocationID
        cmp wEnteredCastleLocationID,b
        bne _B76A
        lda #$0000
        jsl rlGetLocationEventDataEntry
        jsl rlBuildDeadPlayerCharacterList
        jsl rlClearMovementMapBuffer
        jsl rlUnknown8A9A56

        _B76A
        lda #$0003
        sta wCastleScreenHandler,b
        lda wCastleSavedUnitRAMPointer,b
        sta wSelectedUnitDataRAMPointer,b
        lda #<>rsOpenCastleScreen
        sta wMainLoopPointer
        clc
        rtl

        .databank 0

        ; 80/B77D

    .endsection Unsorted80B74BSection


    .section Unsorted80B77FSection

      .al
      .xl

      rlDispatchCastleState ; 80/B77F

        .al
        .xl
        .autsiz
        .databank ?

        ; Dispatches castle substate $088B via jmp (aCastleStateHandlers,x)

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
        .word <>rlResumeCastleUnitMenu
        .word <>rlEnterCastleFacilityScreen
        .word <>rlEnterCastleArenaScreen
        .word <>rlOpenCastleCourtyard
        .word <>rlReloadChapterMapAndOpenCastle

    .endsection Table80B787Section


    .section Unsorted80B793Section

      .al
      .xl

      rlEnterCastleFacilityScreen ; 80/B793

        .al
        .xl
        .autsiz
        .databank ?

        ; $088B=2: clears movement map, handles $089D augury lover names, sets BG, runs 8AD81B

        jsl rlClearMovementMapBuffer
        lda wCastleReturnEventFlag,b
        beq _B7A3
        stz wCastleReturnEventFlag,b
        jsl rlUnknown8CED4F

        _B7A3
        lda #$0003
        sta wCastleCursorState,b
        jsr rsSetCastleCourtyardBGSettings
        jsl rlUnknown8AD81B
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

        ; $088B=3: sets $0891=3, BG settings, $7F8082=7, runs arena 8AE2F8, sets $088B=1 if away castle

        lda #$0003
        sta wCastleCursorState,b
        jsr rsSetCastleCourtyardBGSettings
        lda #$0007
        sta $7F8082
        jsl rlUnknown8AE2F8
        lda #$0002
        sta wMenuState,b
        lda #$0000
        jsl rlGetFactionSlotLocationID
        cmp wEnteredCastleLocationID,b
        beq _B7DD
        lda #$0001
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

        ; $088B=5: reloads map 889268, locations, music, $088B=0, unit lists; falls through to courtyard

        jsl rlUnknown889268
        lda wEventLocationEntry,b
        pha
        jsl rlUpdateAllLocationEvents
        jsl rlUnknown86C629
        pla
        sta wEventLocationEntry,b
        lda #$0000
        sta wCastleScreenHandler,b
        jsl rlUnknown81AB26
        jsl rlStepMusicScript
        lda #$0000
        jsl rlGetFactionSlotLocationID
        cmp wEnteredCastleLocationID,b
        bne rlOpenCastleCourtyard
        lda #$0000
        jsl rlGetLocationEventDataEntry
        jsl rlBuildDeadPlayerCharacterList
        jsl rlUnknown8A9A56

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

        ; $088B=0/4: calls rlSetupCastleCourtyardDisplay and queues sound $00F7

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

        ; Loads castle courtyard VRAM/tilemaps/palettes, builds unit lists, sets $088D/$088F, draws UI 8A8496

        rep #$20
        jsl rlUnknown8881EC
        jsl rlUnknown80B08C
        jsl rlDMAByStruct

          .structDMAToVRAM g4bppShopScreen, $4000, $80, $0000

        jsl rlDMAByStruct

          .structDMAToVRAM g4bppCursorSprites, $0400, $80, $C000

        jsl rlDMAByStruct

          .structDMAToVRAM gUnknownD77800, $0800, $80, $A000

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
        jsl rlUnknown899FDC
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
        jsl rlUnknown8A9A56
        jsl rlUnknown88DE1B
        lda wCastlePrepUnitSlot,b
        asl a
        tax
        lda aUnknown8A99DB,x
        sta wCastlePrepCursorXPixel,b
        lda aUnknown8A9A0B,x
        sta wCastlePrepCursorYPixel,b
        ldx wActiveUnitDeploymentOffset,b
        lda aDeploymentTable._UnitRAMPointer,x
        beq _B97B
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitHomeCastle
        bcs _B97B
        cmp wEnteredCastleLocationID,b
        bne _B97B
        jsl rlGetSelectedUnitGenerationID
        sta wCastlePrepUnitSlot,b
        lda wCastlePrepUnitSlot,b
        dec a
        asl a
        tax
        lda wCurrentChapter,b
        cmp #$0006
        bcs _B964
        lda aUnknown8A9BF4,x
        bra _B968


        _B964
        lda aUnknown8A9C24,x

        _B968
        sta wCastlePrepUnitSlot,b
        asl a
        tax
        lda aUnknown8A99DB,x
        sta wCastlePrepCursorXPixel,b
        lda aUnknown8A9A0B,x
        sta wCastlePrepCursorYPixel,b

        _B97B
        jsl rlUnknown8A8496
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

    .endsection Unsorted80B81BSection


    .section Unsorted80B9ADSection

      .al
      .xl

      rlClearMovementMapBuffer ; 80/B9AD

        .al
        .xl
        .autsiz
        .databank ?

        ; Zeroes $0C38 bytes at aMovementMap ($7F754A..$7F8181)

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

        ; Sets PPU buffers TM=$15, TS=0, CGWSEL=0, CGADSUB=$81, WH1=$FF, windows off

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

      rsSetCastleUnitMenuBGSettings ; 80/B9E1

        .al
        .xl
        .autsiz
        .databank ?

        ; Sets PPU buffers TM=$16, TS=0, CGWSEL=0, CGADSUB=$82, windows off

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

      rlResumeCastleUnitMenu ; 80/BA02

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; $088B=1: validates $089B, checks action-6 event, else opens castle unit menu, portrait, window

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
        sta $08BA,b
        lda #$0002
        sta wGameStateStep,b
        inc wGameStateRoutine1,b
        rtl


        _BA36
        lda @l $00089B
        sta wSelectedUnitDataRAMPointer,b
        jsl rlUnknown8A9D39
        jsl rlSetupCastleUnitMenuDisplay
        jsl rlGetSelectedUnitCharacterID
        jsl rlUnknown8A9776
        jsl rlUnknown8A94E2
        rtl

        .databank 0

        ; 80/BA52

    .endsection Unsorted80BA02Section


    .section Unsorted80BA52Section

      .al
      .xl

      rlSetupCastleUnitMenuDisplay ; 80/BA52

        .al
        .xl
        .autsiz
        .databank ?

        ; Loads castle unit menu gfx, aUnknownD77000, castle name, 8A9858 flags, HDMA 8A9C56, step=1

        rep #$20
        jsl rlUnknown8881EC
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
        lda aUnknownD77000,x
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
        jsl rlUnknown8A9858
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0700, $80, $B000

        ldx #$01FE

        _BAF6
        lda aUnknown8C9A00,x
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
        lda #$0003
        sta wCastleCursorState,b
        lda #(`aUnknown8A9C56)<<8
        sta lR44+1
        lda #<>aUnknown8A9C56
        sta lR44
        jsl rlHDMAEngineCreateEntry
        jsr rsSetCastleUnitMenuBGSettings
        lda #$0001
        sta wGameStateStep,b
        rtl

        .databank 0

        ; 80/BB43

    .endsection Unsorted80BA52Section


    .section Unsorted80BB5DSection

      .al
      .xl

      rlReturnToCastleScreen ; 80/BB5D

        .al
        .xl
        .autsiz
        .databank ?

        ; Reloads player castle location events, rebuilds dead list, sets $088B=0 and rsOpenCastleScreen

        lda #$0000
        jsl rlGetFactionSlotLocationID
        jsl rlGetLocationEventDataEntry
        jsl rlUnknown88C25D
        jsl rlBuildDeadPlayerCharacterList
        lda #$0000
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

        ; Sets $088B=0, rebuilds dead list, spawns procMainLoopChangeFade into rsOpenCastleScreen

        lda #$0000
        sta wCastleScreenHandler,b
        jsl rlBuildDeadPlayerCharacterList
        lda #$B6B6
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


