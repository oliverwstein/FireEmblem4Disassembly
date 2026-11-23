; The map's buttons while the cursor is free (rsMapInputHandler): A selects a unit,
; sets its destination or opens the map menu; B puts a selected unit down; X opens
; the status screen; Start the minimap; R sends the cursor to the next unit that
; can act; L jumps between castles. Also entering the castle courtyard or town
; from the map. Bank $88.

    .section MapInputHandlerSection

      .al
      .xl

      rsMapInputHandler ; 88/AFB6

        .al
        .autsiz
        .databank ?

        lda wMusicID,b
        bne _End

        lda wJoy1New
        bit #JOY_A
        bne _APressed

        bit #JOY_B
        bne _BPressed

        bit #JOY_Select
        bne _SelectPressed

        bit #JOY_X
        bne _XPressed

        bit #JOY_Start
        bne _StartPressed

        bit #JOY_R
        bne _RPressed

        bit #JOY_L
        bne _LPressed
        
        _End
        rts
        
        _APressed
        jsr rsMapPressA
        rts
        
        _SelectPressed
        lda wUnknown000770,b
        beq +

          rts

        +
        jsr rsOpenMainMapMenu
        rts
        
        _BPressed
        lda wUnknown000770,b
        beq +

          jsr rsMapPressBWithUnitSelected

        +
        rts
        
        _XPressed
        jsr rsMapPressX
        rts
        
        _StartPressed
        jsr rsMapPressStart
        rts
        
        _RPressed
        lda wUnknown000770,b
        beq +

          rts

        +
        lda wJoy1Input
        cmp #(JOY_L | JOY_R)
        beq +

        lda #5
        jsl rlPlaySoundEffect

        lda #0
        sta wUnknown000790,b
        jsr rsCursorToNextReadyUnit
        rts
        
        _LPressed
        lda wUnknown000770,b
        beq +

          rts

        +
        jsr rsJumpToNextCastle
        rts

        .databank 0

        ; 88/B028

    .endsection MapInputHandlerSection


    .section Unsorted88B028Section

      .al
      .xl

      rsMapPressA ; 88/B028

        .al
        .xl
        .autsiz
        .databank ?

        ; A on the map. With no unit selected: picks up the unit at the cursor; with none there, enters the home castle if the cursor is on it, else opens the map menu. With a unit selected: in warp mode acts at the cursor (rsMapConfirmWarpAtCursor); for a unit of the active army sets its destination (sound $0A, or $22 if it cannot go there); for any other unit puts it down.

        lda wUnknown000770,b
        bne _B03F
        jsr rsSelectUnitAtCursor
        bcs _B037
        lda wUnknown000770,b
        beq _B06F

        _B037
        lda #$0008
        jsl rlPlaySoundEffect
        rts


        _B03F
        lda wUnknown000D79,b
        bit #$0800
        bne _B079
        ldx wActiveUnitDeploymentOffset,b
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitFactionSlot
        cmp wActiveFactionSlot,b
        bne _B081
        jsr rsSetMoveDestinationAtCursor
        bcs _B067
        lda #$000A
        jsl rlPlaySoundEffect
        rts


        _B067
        lda #$0022
        jsl rlPlaySoundEffect
        rts


        _B06F
        jsl rlEnterHomeCastleAtCursor
        bcc _B080
        jsr rsOpenMainMapMenu
        rts


        _B079
        jsr rsMapConfirmWarpAtCursor
        rts

        .byte $20, $33, $B1


        _B080
        rts


        _B081
        lda #$0021
        jsl rlPlaySoundEffect
        stz wMovingUnitSpriteState,b
        ldx wActiveUnitDeploymentOffset,b
        jsl rlDeployedUnitUnsetHiddenIfAlive
        jsr rsHideRangeOverlay
        rts

        .databank 0

        ; 88/B096

      rsMapConfirmWarpAtCursor ; 88/B096

        .al
        .xl
        .autsiz
        .databank ?

        ; With bit 11 of wUnknown000D79 set and a unit selected: hides the range, puts the cursor back on the active unit and acts (rlRunMapAction) with the cursor's tile in wR2/wR3.

        lda #$0000
        sta wUnknown0007D8,b
        stz wMovingUnitSpriteState,b
        jsr rsHideRangeOverlay
        lda wActiveUnitDeploymentOffset,b
        sta wR0
        lda wMapTargetDeploymentOffset,b
        sta wR1
        lda wMapCursorOriginXTile,b
        sta wMapCursorXTile,b
        lda wMapCursorOriginYTile,b
        sta wMapCursorYTile,b
        lda wActiveUnitDeploymentOffset,b
        tax
        lda aDeploymentTable._XTilePosition,x
        asl a
        asl a
        asl a
        asl a
        sec
        sbc wMapScrollXPixels,b
        sta wCursorXOffset,b
        lda aDeploymentTable._YTilePosition,x
        asl a
        asl a
        asl a
        asl a
        sec
        sbc wMapScrollYPixels,b
        sta wCursorYOffset,b
        lda wMapScrollXPixels,b
        sta wMapXOffset,b
        lda wMapScrollYPixels,b
        sta wMapYOffset,b
        lda wCursorXOffset,b
        clc
        adc wMapScrollXPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR2
        lda wCursorYOffset,b
        clc
        adc wMapScrollYPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR3
        jsl rlRunMapAction
        lda #$0800
        trb wUnknown000D79,b
        rts

        .databank 0

        ; 88/B10B

      rsOpenMainMapMenu ; 88/B10B

        .al
        .xl
        .autsiz
        .databank ?

        ; Saves the camera and opens the map menu (procMainMapMenu).

        lda wMapScrollXPixels,b
        sta wMapXOffset,b
        lda wMapScrollYPixels,b
        sta wMapYOffset,b
        lda #$0009
        jsl rlPlaySoundEffect
        lda #(`procMainMapMenu)<<8
        sta lR44+1
        lda #<>procMainMapMenu
        sta lR44
        jsl rlProcEngineCreateProc
        lda #$0008
        tsb wMapSystemFlags,b
        rts

        .databank 0

        ; 88/B133

      rsMapPressBWithUnitSelected ; 88/B133

        .al
        .xl
        .autsiz
        .databank ?

        ; B with a unit selected: puts it down and sends the cursor back to it (by wMapActionMode, with canto the cursor goes to it in state 7); in warp mode goes back to the unit menu.

        ldx wActiveUnitDeploymentOffset,b
        lda aDeploymentTable,x
        bit #$0010
        bne _B183
        lda wUnknown000D79,b
        bit #$0800
        bne _B198
        lda #$0021
        jsl rlPlaySoundEffect
        stz wMovingUnitSpriteState,b
        lda wActiveUnitDeploymentOffset,b
        jsl rlMoveCursorToUnit
        jsl rlDeployedUnitUnsetHiddenIfAlive
        jsr rsHideRangeOverlay
        lda wMapActionMode,b
        cmp #$0001
        beq _B16D
        cmp #$0002
        beq _B178
        rts


        _B16D
        ldx wActiveUnitDeploymentOffset,b
        jsl rlEnterTargetLocation
        stz wMapActionMode,b
        rts


        _B178
        ldx wActiveUnitDeploymentOffset,b
        jsl rlStartGuardingCastleAtUnit
        stz wMapActionMode,b
        rts


        _B183
        stz wMovingUnitSpriteState,b
        jsl rlDeployedUnitUnsetHiddenIfAlive
        lda wActiveUnitDeploymentOffset,b
        jsl rlMoveCursorToUnit
        lda #$0007
        sta wUnknown0007D8,b
        rts


        _B198
        lda wMapCursorOriginXTile,b
        sta wMapCursorXTile,b
        lda wMapCursorOriginYTile,b
        sta wMapCursorYTile,b
        lda #$0005
        jsl rlPlaySoundEffect
        jsr rsHideRangeOverlay
        stz wUnknown0007D8,b
        jsl rlOpenUnitMenu
        lda #$0008
        tsb wMapSystemFlags,b
        lda #$0800
        trb wUnknown000D79,b
        rts

        .databank 0

        ; 88/B1C2

      rsMapPressX ; 88/B1C2

        .al
        .xl
        .autsiz
        .databank ?

        ; X: on a unit, opens its status screen; elsewhere enters the home castle if the cursor is on it.

        lda wUnknown000770,b
        bne _B1D0
        lda wUnknown000766,b
        beq _B1D1

        _B1CC
        jsl rlEnterHomeCastleAtCursor

        _B1D0
        rts


        _B1D1
        jsl rlCheckUnitAtCursor
        bcc _B1CC
        stx wActiveUnitDeploymentOffset,b
        ldx wActiveUnitDeploymentOffset,b
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        lda #$0008
        jsl rlPlaySoundEffect
        jsl rlSaveMapCameraAndLockCursor
        lda #<>rsUnknown80B122
        sta wStatusScreenCaller
        lda #$0000
        sta wStatusScreenReopenMode
        lda #$000A
        sta wGameStateStep,b
        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        rts

        .databank 0

        ; 88/B20C

      rsMapPressStart ; 88/B20C

        .al
        .xl
        .autsiz
        .databank ?

        ; Start alone, with no unit selected: opens the minimap, or closes it.

        lda wJoy1Input
        cmp #$1000
        bne _B248
        lda wUnknown000770,b
        bne _B248
        lda wMapSystemFlags,b
        bit #$0020
        bne _B241
        lda #$0020
        tsb wMapSystemFlags,b
        lda wMapScrollXPixels,b
        sta wMapXOffset,b
        lda wMapScrollYPixels,b
        sta wMapYOffset,b
        lda #(`procMinimap)<<8
        sta lR44+1
        lda #<>procMinimap
        sta lR44
        jsl rlProcEngineCreateProc
        rts


        _B241
        lda #$0020
        trb wMapSystemFlags,b
        rts


        _B248
        rts

        .databank 0

        ; 88/B249

      rlEnterHomeCastleAtCursor ; 88/B249

        .al
        .xl
        .autsiz
        .databank ?

        ; Carry clear and the castle screen opens if the cursor is on the home castle of the player army; carry set otherwise.

        lda wCursorXOffset,b
        clc
        adc wMapScrollXPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR0
        lda wCursorYOffset,b
        clc
        adc wMapScrollYPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR1
        jsl rlFindLocationAtTile
        bcs _B2A3
        jsl rlGetEventLocationEntryType
        cmp #LocationTypeCastle
        bne _B2A3
        jsl rlGetLocationFactionSlotOwner
        bmi _B2A3
        cmp #$0000
        bne _B2A3
        jsl rlGetEventLocationEntryID
        sta wEnteredCastleLocationID,b
        lda #$0000
        jsl rlGetFactionSlotLocationID
        cmp wEnteredCastleLocationID,b
        bne _B2A3
        lda #$FFFF
        sta wCastleSavedUnitRAMPointer,b
        lda #$0009
        jsl rlPlaySoundEffect
        jml rlOpenCastleCourtyardFromMap

        clc
        rtl


        _B2A3
        sec
        rtl

        .databank 0

        ; 88/B2A5

      rlEnterLocationOfUnit ; 88/B2A5

        .al
        .xl
        .autsiz
        .databank ?

        ; X = deployment: puts the cursor on the unit and opens the castle courtyard if it stands on the home castle, or the town screen at another location.

        lda aDeploymentTable._XTilePosition,x
        asl a
        asl a
        asl a
        asl a
        sec
        sbc wMapScrollXPixels,b
        sta wCursorXOffset,b
        lda aDeploymentTable._YTilePosition,x
        asl a
        asl a
        asl a
        asl a
        sec
        sbc wMapScrollYPixels,b
        sta wCursorYOffset,b
        lda wCursorXOffset,b
        clc
        adc wMapScrollXPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR0
        lda wCursorYOffset,b
        clc
        adc wMapScrollYPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR1
        jsl rlCheckIfCoordsNotEventLocationTile
        bcs _B30B
        jsl rlGetEventLocationEntryType
        cmp #$0001
        beq _B305
        jsl rlGetEventLocationEntryID
        sta wEnteredCastleLocationID,b
        lda #$0000
        jsl rlGetFactionSlotLocationID
        cmp wEnteredCastleLocationID,b
        bne _B305
        jml rlOpenCastleCourtyardFromMap

        clc
        rtl


        _B305
        jml rlOpenCastleTownFromMap

        clc
        rtl


        _B30B
        sec
        rtl

        .databank 0

      rlEnterCastleAtLocation ; 88/B30D

        .al
        .xl
        .autsiz
        .databank ?

        ; A = location: opens the castle courtyard for it.

        jsl rlGetLocationEventDataEntry
        jml rlOpenCastleCourtyardFromMap
        rtl

        .databank 0

      rlOpenCastleCourtyardFromMap ; 88/B316

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlSaveMapCameraAndLockCursor
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

        ; 88/B339

      rlOpenCastleTownFromMap ; 88/B339

        .al
        .xl
        .autsiz
        .databank ?

        lda #$00F0
        jsl rlSendSoundCommand
        lda #$00E0
        jsl rlQueueSoundCommand
        jsl rlSaveMapCameraAndLockCursor
        lda #CASTLE_SCREEN_TOWN
        sta wCastleScreenHandler,b
        lda #<>rsOpenCastleScreen
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 88/B366

    .endsection Unsorted88B028Section


    .section Unsorted88B51ASection

      .al
      .xl

      rsCursorToNextReadyUnit ; 88/B51A

        .al
        .xl
        .autsiz
        .databank ?

        ; R: sends the cursor to the next unit of the active army that can still act (alive, not grayed or asleep), going through the deployment table up or down (wUnknown000790); the home castle counts as a stop while units inside it can act.

        lda wCursorXOffset,b
        clc
        adc wMapScrollXPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wTempVariable1,b
        lda wCursorYOffset,b
        clc
        adc wMapScrollYPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wTempVariable2,b
        ldy #$0090
        jsr rsCheckCycleStartsAtCastle
        bcs _B561
        lda wUnknown000790,b
        bne _B54F
        ldx wMapPanTargetDeploymentOffset,b
        dec x
        dec x
        bpl _B55C
        ldx #$008E
        bra _B55C


        _B54F
        ldx wMapPanTargetDeploymentOffset,b
        inc x
        inc x
        cpx #$0090
        bcc _B55C
        ldx #$0000

        _B55C
        jsr rsCheckCycleStopsAtCastle
        bcs _B5C9

        _B561
        lda aDeploymentTable,x
        beq _B5A7
        bit #$0008
        bne _B5A7
        bit #$2000
        bne _B5A7
        bit #$0080
        beq _B5A7
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitFactionSlot
        cmp wActiveFactionSlot,b
        bne _B5A7
        lda aDeploymentTable._XTilePosition,x
        sec
        sbc wTempVariable1,b
        sta wMapCursorXTile,b
        lda aDeploymentTable._YTilePosition,x
        sec
        sbc wTempVariable2,b
        sta wMapCursorYTile,b
        lda #$0004
        sta wUnknown0007D8,b
        stx wMapPanTargetDeploymentOffset,b
        bra _B5C9


        _B5A7
        lda wUnknown000790,b
        bne _B5B5
        dec x
        dec x
        bpl _B5BF
        ldx #$008E
        bra _B5BF


        _B5B5
        inc x
        inc x
        cpx #$0090
        bcc _B5BF
        ldx #$0000

        _B5BF
        dec y
        dec y
        bpl _B55C
        stz wMapCursorXTile,b
        stz wMapCursorYTile,b

        _B5C9
        rts

        .databank 0

        ; 88/B5CA

      rsCheckCycleStartsAtCastle ; 88/B5CA

        .al
        .xl
        .autsiz
        .databank ?

        lda wMapPanTargetDeploymentOffset,b
        cmp #$FFFF
        beq _B5D4
        clc
        rts


        _B5D4
        lda #$0000
        sta wMapPanTargetDeploymentOffset,b
        tax
        sec
        rts

        .databank 0

        ; 88/B5DD

      rsCheckCycleStopsAtCastle ; 88/B5DD

        .al
        .xl
        .autsiz
        .databank ?

        lda wMapPanTargetDeploymentOffset,b
        cmp #$FFFF
        bne _B5E7
        clc
        rts


        _B5E7
        txa
        cmp #$0000
        bne _B625
        lda #$0000
        jsl rlGetFactionSlotLocationID
        jsl rlGetLocationEventDataEntry
        jsl rlBuildCastleUnitList
        jsr rsCheckCastleUnitsCanAct
        bcc _B625
        jsl rlGetEventLocationEntryEffectiveXCoordinate
        sec
        sbc wTempVariable1,b
        sta wMapCursorXTile,b
        jsl rlGetEventLocationEntryEffectiveYCoordinate
        sec
        sbc wTempVariable2,b
        sta wMapCursorYTile,b
        lda #$0004
        sta wUnknown0007D8,b
        lda #$FFFF
        sta wMapPanTargetDeploymentOffset,b
        sec
        rts


        _B625
        clc
        rts

        .databank 0

        ; 88/B627

      rsCheckCastleUnitsCanAct ; 88/B627

        .al
        .xl
        .autsiz
        .databank ?

        ; Carry set if a unit in aCastleUnitDeploymentOffsets is neither grayed nor asleep.

        phx
        ldx #$002E

        _B62B
        lda aCastleUnitDeploymentOffsets,x
        cmp #$FFFF
        beq _B648
        phx
        tax
        lda aDeploymentTable,x
        plx
        bit #$0008
        bne _B648
        bit #$2000
        bne _B648
        plx
        sec
        rts


        _B648
        dec x
        dec x
        bpl _B62B
        plx
        clc
        rts

        .databank 0

        ; 88/B64F

    .endsection Unsorted88B51ASection


    .section Unsorted88B366Section

      .al
      .xl

      rlOpenSoloConversationFromMap ; 88/B366

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0001
        tsb wConversationFlags,b
        lda #$0002
        tsb wConversationFlags,b
        lda #$0004
        tsb wConversationFlags,b
        lda #$0008
        tsb wConversationFlags,b
        lda wSelectedUnitDataRAMPointer,b
        sta wConversationLeftUnit,b
        lda wSelectedUnitDataRAMPointer,b
        sta wConversationRightUnit,b
        lda #CONVERSATION_EXIT_MAP
        sta wConversationExitMode,b
        jsl rlSaveMapCameraAndLockCursor
        lda #CASTLE_SCREEN_CONVERSATION
        sta wCastleScreenHandler,b
        lda #<>rsOpenCastleScreen
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 88/B3AF

    .endsection Unsorted88B366Section


    .section Unsorted88B3DFSection

      .al
      .xl

      rlGetTileEntriesAtCursor ; 88/B3DF

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phb
        lda wCursorXOffset,b
        sta wR10
        lda wCursorYOffset,b
        sta wR11
        jsl rlGetTileAtScreenPosition
        lda wR10
        sta wR0
        lda wR11
        sta wR1
        jsl rlGetMapDataIndex
        tax
        lda aMapData,x
        and #$03FF
        asl a
        asl a
        asl a
        tax
        lda $7F0000,x
        and #$DFFF
        sta wR0
        lda $7F0002,x
        and #$DFFF
        sta wR1
        lda $7F0004,x
        and #$DFFF
        sta wR2
        lda $7F0006,x
        and #$DFFF
        sta wR3
        plb
        .databank ?
        rtl

        .databank 0

        ; 88/B42C

    .endsection Unsorted88B3DFSection


