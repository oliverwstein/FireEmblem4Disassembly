; Picking up a unit and moving it. rsSelectUnitAtCursor shows its range;
; rsSetMoveDestinationAtCursor checks the chosen tile and rsBuildMovementPath
; writes the path (at $0794, from the destination back to the unit) by climbing
; aMovementMap. The cursor goes back to the unit (state 1) and the unit walks the
; path (state 2, rsWalkUnitAlongPath), then the unit menu opens. B in the unit
; menu undoes the move (rlUndoUnitMove).
;
; In a computer phase rlMapAIMoveStep does the same for the AI's chosen unit and
; destination and then runs the queued AI action. The walking sounds
; (rlStartWalkingSound...) follow the moving unit. Bank $88.

    .section WalkUnitAlongPathSection

      .al
      .xl

      rsMoveCursorBackToUnit ; 88/A9B4

        .al
        .xl
        .autsiz
        .databank ?

        ; Cursor states 1 and 8: one tile at a time towards the unit; there, sets state 2 to walk the unit along its path
        ; and sets wMapCursorXTile/YTile to the move's origin, which rlUndoUnitMove returns to. After the guard command the
        ; path is empty, so the walk ends at once.

        lda wMapCursorXTile,b
        beq _A9CB
        bpl _A9C3
        inc wMapCursorXTile,b
        lda #$0200
        bra _A9E2


        _A9C3
        dec wMapCursorXTile,b
        lda #$0100
        bra _A9E2


        _A9CB
        lda wMapCursorYTile,b
        beq _A9E6
        bpl _A9DA
        inc wMapCursorYTile,b
        lda #$0800
        bra _A9E2


        _A9DA
        dec wMapCursorYTile,b
        lda #$0400
        bra _A9E2


        _A9E2
        sta wMapScrollDirectionIdentifier,b
        rts


        _A9E6
        stz wMapScrollingFlag,b
        lda wMapScrollScriptOffset,b
        dec a
        dec a
        sta wMapScrollScriptOffset,b
        lda wMapCursorOriginXTile,b
        sta wMapCursorXTile,b
        lda wMapCursorOriginYTile,b
        sta wMapCursorYTile,b
        ldx wActiveUnitDeploymentOffset,b
        jsl rlDeployedUnitSetHidden
        lda #MAP_CURSOR_UNIT_WALKING
        sta wMapCursorState,b
        lda #$FFFF
        sta wMapScrollDirectionIdentifier,b
        jsl rlStartWalkingSound
        lda #$0002
        sta wMovingUnitSpriteState,b
        lda #$0000
        rts

        .databank 0

        ; 88/AA1E

      rsWalkUnitAlongPath ; 88/AA1E

        .al
        .xl
        .autsiz
        .databank ?

        ; Cursor state 2: takes the next direction from the path at $0794 (1 down, 2 up, 3 right, 4 left) and turns the moving sprite; at the end moves the unit to the cursor's tile and opens the unit menu (for a player move).
        ; In the guard modes (4, 5, 9) it requests unit menu mode 2 instead (another army's unit finishes its action); mode 4 is cleared.

        lda wMapScrollScriptOffset,b
        bmi _AA8A
        tax
        lda aMovementPath,b,x
        sta wR0
        beq _AA8A
        cmp #PATH_DOWN
        beq _AA3F
        cmp #PATH_UP
        beq _AA4A
        cmp #PATH_RIGHT
        beq _AA55
        cmp #PATH_LEFT
        beq _AA60

        _AA3F
        lda #$0018
        sta wMovingUnitSpriteFacing,b
        lda #$0400
        bra _AA6B


        _AA4A
        lda #$0010
        sta wMovingUnitSpriteFacing,b
        lda #$0800
        bra _AA6B


        _AA55
        lda #$0008
        sta wMovingUnitSpriteFacing,b
        lda #$0100
        bra _AA6B


        _AA60
        lda #$0000
        sta wMovingUnitSpriteFacing,b
        lda #$0200
        bra _AA6B


        _AA6B
        cmp wMapScrollDirectionIdentifier,b
        bne _AA7A
        sta wMapScrollDirectionIdentifier,b
        jsr rsMergePathSteps
        lda #$0001
        rts


        _AA7A
        sta wMapScrollDirectionIdentifier,b
        stz wMovingUnitSpriteFrame,b
        stz wMovingUnitSpriteTimer,b
        jsr rsMergePathSteps
        lda #$0001
        rts


        _AA8A
        lda #$0010
        sta wMapPixelScrollDistance,b
        jsl rlStopWalkingSound
        lda #$0002
        sta wMovingUnitSpriteState,b
        stz wMapCursorState,b
        stz wMapScrollScriptOffset,b
        stz wMapScrollingFlag,b
        lda wCursorXOffset,b
        clc
        adc wMapScrollXPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR0
        sta wTempVariable1,b
        lda wCursorYOffset,b
        clc
        adc wMapScrollYPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR1
        sta wTempVariable2,b
        ldx wActiveUnitDeploymentOffset,b
        jsl rlMoveDeploymentToTile
        lda wMapActionMode,b
        cmp #MAP_ACTION_MODE_GUARD
        beq _AAEF
        cmp #MAP_ACTION_MODE_GUARD_SORTIE
        beq _AAEF
        cmp #MAP_ACTION_MODE_GUARD_MENU_1
        beq _AAEF
        lda wMapActionActiveFlag,b
        bne _AAEB
        jsl rlOpenUnitMenu
        lda #$0008
        tsb wMapSystemFlags,b

        _AAEB
        lda #$0000
        rts


        _AAEF
        jsl rlRequestUnitMenuMode2
        bcc _AB00
        jsl rlFinishUnitAction
        stz wMapActionMode,b
        lda #$0000
        rts


        _AB00
        lda wMapActionMode,b
        cmp #MAP_ACTION_MODE_GUARD
        beq _AB0C
        lda #$0000
        rts


        _AB0C
        stz wMapActionMode,b
        lda #$0000
        rts

        .databank 0

        ; 88/AB13

      rsMergePathSteps ; 88/AB13

        .al
        .xl
        .autsiz
        .databank ?

        ; Adds 16 pixels of distance for each following step in the same direction.

        lda wMapPixelScrollDistance,b
        clc
        adc #$0010
        sta wMapPixelScrollDistance,b
        dec x
        dec x
        stx wMapScrollScriptOffset,b
        bmi _AB2B
        lda aMovementPath,b,x
        cmp wR0
        beq rsMergePathSteps

        _AB2B
        rts

        .databank 0

        ; 88/AB2C

    .endsection WalkUnitAlongPathSection


    .section MapCursorMoveStepSection

      .al
      .xl

      rlMapCursorMoveStep ; 88/A754

        .al
        .autsiz
        .databank $00

        lda wMapCursorStepping,b
        bne _A7BA

          lda wMapCursorState,b
          cmp #MAP_CURSOR_UNIT_WALKING
          beq _A788

            cmp #MAP_CURSOR_TO_UNIT
            beq _A795

              cmp #MAP_CURSOR_TO_UNIT_SELECT
              beq _A795

                cmp #MAP_CURSOR_TO_TARGET
                beq _A795

                  cmp #MAP_CURSOR_TO_UNIT_MENU
                  beq _A795

                    lda #16
                    sta wMapPixelScrollDistance,b
                    jsr rsMoveCursorBackToUnit
                    beq _End

                      lda #8
                      sta wMapScrollSpeed,b
                      bra +
          
          _A788
          stz wMapPixelScrollDistance,b
          jsr rsWalkUnitAlongPath
          beq _End

            jsr rsSetUnitWalkSpeed
            bra +

          _A795
          lda #16
          sta wMapPixelScrollDistance,b
          jsr rsMoveCursorTowardsTarget
          beq _End

            lda #8
            sta wMapScrollSpeed
            bra +

          +
          stz wMapScrollCurrentPixelDistance,b
          lda #1
          sta wMapCursorStepping,b
          stz wMapScrollingFlag,b
          stz wMapEnableXScrollFlag,b
          stz wMapEnableYScrollFlag,b

        _A7BA
        lda wMapScrollCurrentPixelDistance,b
        clc
        adc wMapScrollSpeed,b
        sta wMapScrollCurrentPixelDistance,b
        cmp wMapPixelScrollDistance,b
        bcc +

          sec
          sbc wMapPixelScrollDistance,b
          sta wR0
          lda wMapScrollSpeed,b
          sec
          sbc wR0
          sta wMapScrollSpeed,b

          stz wMapCursorStepping,b
          stz wMapScrollingFlag,b
          stz wMapEnableXScrollFlag,b
          stz wMapEnableYScrollFlag,b
        
        +
        jsl rlMoveMapCursorInDirection

        lda wMapCursorState,b
        cmp #MAP_CURSOR_UNIT_WALKING
        bne _End

          jsl rlUpdateWalkingSound

        _End
        rtl

        .databank 0

        ; 88/A7F5

    .endsection MapCursorMoveStepSection


    .section SetUnitWalkSpeedSection

      .al
      .xl

      rsSetUnitWalkSpeed ; 88/A7F5

        .al
        .xl
        .autsiz
        .databank ?

        ; The walking speed of the active unit: 3 pixels a frame with speed 5 or more, else 1.

        ldx wActiveUnitDeploymentOffset,b
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitTotalSpeed
        cmp #$0005
        bcc _A80F
        lda #$0003
        sta wMapScrollSpeed,b
        rts


        _A80F
        lda #$0001
        sta wMapScrollSpeed,b
        rts

        .databank 0

        ; 88/A816

    .endsection SetUnitWalkSpeedSection


    .section Unreferenced88A816Section

      .al
      .xl

      rsSetMapScrollSpeed2Unused ; 88/A816

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0002
        sta wMapScrollSpeed,b
        rts

        .databank 0

        ; 88/A81D

    .endsection Unreferenced88A816Section
    .section UndoUnitMoveSection

      .al
      .xl

      rlUndoUnitMove ; 88/ADE9

        .al
        .xl
        .autsiz
        .databank ?

        ; B in the unit menu (modes 0 and 2). By wMapActionMode:
        ;   0: back to the move's origin (wMapCursorXTile/YTile), unit put down; with canto, picked up again.
        ;   5: becomes 1; back to the origin and the cursor goes there (state 7), which picks the unit up again
        ;      or, with unit menu mode 1 open, reopens that menu.
        ;   Others: the same if unit menu mode 1 is open or the unit can still move (rlCheckSelectedUnitCannotMove).
        ;   If it cannot move: 1 goes back into the castle, 2 guards again, 3 goes back into the castle at the cursor,
        ;   4 is cleared and handled as 0, 9 stays on the cursor's tile, which becomes the origin.
        ;   (The walk's end already clears 4 for a player unit.)
        ; The move test reads aMovementMap, which is not rebuilt for a menu opened by rsOpenQueuedUnitMenu.

        lda wMapActionMode,b
        bne _AE41

        _ADEE
        ldx wActiveUnitDeploymentOffset,b
        lda aDeploymentTable,x
        bit #$0010
        bne _AE1F
        lda wMapCursorXTile,b
        sta wR0
        lda wMapCursorYTile,b
        sta wR1
        ldx wActiveUnitDeploymentOffset,b
        jsl rlDeployedUnitUnsetHiddenIfAlive
        stz wMovingUnitSpriteState,b
        jsl rlMoveDeploymentToTile
        lda wActiveUnitDeploymentOffset,b
        jsl rlMoveCursorToUnit
        rtl


        _AE1A
        stz wMapActionMode,b
        bra _ADEE


        _AE1F
        lda wMapCursorXTile,b
        sta wR0
        lda wMapCursorYTile,b
        sta wR1
        stz wMovingUnitSpriteState,b
        ldx wActiveUnitDeploymentOffset,b
        jsl rlMoveDeploymentToTile
        lda wActiveUnitDeploymentOffset,b
        jsl rlMoveCursorToUnit
        lda #MAP_CURSOR_TO_UNIT_MENU
        sta wMapCursorState,b
        rtl


        _AE41
        lda wMapActionMode,b
        cmp #MAP_ACTION_MODE_GUARD_SORTIE
        beq _AE70
        lda wMapStateFlags,b
        bit #$0008
        bne _AE76
        jsl rlCheckSelectedUnitCannotMove
        bcc _AE76
        lda wMapActionMode,b
        cmp #MAP_ACTION_MODE_DEPARTED
        beq _AEB3
        cmp #MAP_ACTION_MODE_CASTLE_GUARD
        beq _AEC8
        cmp #MAP_ACTION_MODE_GUARD
        beq _AE1A
        cmp #MAP_ACTION_MODE_GUARD_MENU_1
        beq _AEB1
        bra _AE9C


        _AE70
        lda #MAP_ACTION_MODE_SORTIE
        sta wMapActionMode,b

        _AE76
        lda wMapCursorXTile,b
        sta wR0
        lda wMapCursorYTile,b
        sta wR1
        ldx wActiveUnitDeploymentOffset,b
        jsl rlDeployedUnitUnsetHiddenIfAlive
        stz wMovingUnitSpriteState,b
        jsl rlMoveDeploymentToTile
        lda wActiveUnitDeploymentOffset,b
        jsl rlMoveCursorToUnit
        lda #MAP_CURSOR_TO_UNIT_MENU
        sta wMapCursorState,b
        rtl


        _AE9C
        ldx wActiveUnitDeploymentOffset,b
        jsl rlDeployedUnitUnsetHiddenIfAlive
        stz wMovingUnitSpriteState,b
        ldx wActiveUnitDeploymentOffset,b
        jsl rlEnterTargetLocation
        stz wMapActionMode,b
        rtl


        _AEB1
        bra _AEFE


        _AEB3
        ldx wActiveUnitDeploymentOffset,b
        jsl rlDeployedUnitUnsetHiddenIfAlive
        stz wMovingUnitSpriteState,b
        ldx wActiveUnitDeploymentOffset,b
        jsl rlStartGuardingCastleAtUnit
        stz wMapActionMode,b
        rtl


        _AEC8
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
        lda wEventLocationEntry,b
        sta wTargetEventLocationEntry,b
        jsl rlDeployedUnitUnsetHiddenIfAlive
        stz wMovingUnitSpriteState,b
        ldx wActiveUnitDeploymentOffset,b
        jsl rlEnterTargetLocation
        stz wMapActionMode,b
        rtl


        _AEFE
        ldx wActiveUnitDeploymentOffset,b
        stz wMovingUnitSpriteState,b
        lda wCursorXOffset,b
        clc
        adc wMapScrollXPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR0
        sta wMapCursorXTile,b
        sta wMapCursorOriginXTile,b
        lda wCursorYOffset,b
        clc
        adc wMapScrollYPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR1
        sta wMapCursorYTile,b
        sta wMapCursorOriginYTile,b
        jsl rlMoveDeploymentToTile
        stz wMapActionMode,b
        lda wActiveUnitDeploymentOffset,b
        jsl rlMoveCursorToUnit
        ldx wActiveUnitDeploymentOffset,b
        lda aDeploymentTable,x
        bit #$0010
        bne _AF45
        rtl


        _AF45
        lda #MAP_CURSOR_TO_UNIT_MENU
        sta wMapCursorState,b
        rtl

        .databank 0

        ; 88/AF4C

    .endsection UndoUnitMoveSection


    .section StartMovingUnitSpriteSection

      .al
      .xl

      rsStartMovingUnitSprite ; 88/AF4C

        .al
        .autsiz
        .databank ?

        ; X = deployment offset: hides the unit, saves the cursor's map position and loads its moving map sprite (state 1).

        ; X = deployment offset

        stx wActiveUnitDeploymentOffset,b

        lda wCursorXOffset,b
        clc
        adc wMapScrollXPixels,b
        sta wMovingUnitXPixel,b

        lda wCursorYOffset,b
        clc
        adc wMapScrollYPixels,b
        sta wMovingUnitYPixel,b

        lda #1
        sta wMovingUnitSpriteState,b
        stz wMovingUnitSpriteFrame,b
        stz wMovingUnitSpriteTimer,b

        jsl rlDeployedUnitSetHidden

        stz wMovingUnitSpriteFacing,b
        jsl rlLoadMovingUnitSprite
        rtl

        .databank 0

    .endsection StartMovingUnitSpriteSection


    .section EndUnitActionSection

      .al
      .xl

      rlEndUnitAction ; 88/AF7B

        .al
        .autsiz
        .databank ?

        ; Clears the moving sprite and wMapActionMode, shows the unit again and, unless it has canto or a computer phase is running, sends the cursor to it.

        phx
        stz wMovingUnitSpriteState,b
        stz wMapActionMode,b

        ldx wActiveUnitDeploymentOffset,b
        lda aDeploymentTable._UnitRAMPointer,x
        beq +

          sta @l wCastleSavedUnitRAMPointer ; the town opened next (an allied castle's) is this unit's
        
        +
        ldx wActiveUnitDeploymentOffset,b
        jsl rlDeployedUnitUnsetHiddenIfAlive

        ldx wActiveUnitDeploymentOffset,b
        lda aDeploymentTable._State,x
        bit #DeploymentStateCanto
        bne +

          lda bAIEngineFlags,b
          and #$00FF
          bit #$0041
          bne +

            lda wActiveUnitDeploymentOffset,b
            jsl rlMoveCursorToUnit

        +
        plx
        rtl

        .databank 0

    .endsection EndUnitActionSection


    .section SelectUnitAtCursorSection

      .al
      .xl

      rlSelectUnitAtCursor ; 88/B6FD

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsSelectUnitAtCursor
        rtl

        .databank 0

        ; 88/B701

      rsSelectUnitAtCursor ; 88/B701

        .al
        .xl
        .autsiz
        .databank ?

        ; Picks up the unit under the cursor: shows its range (wUnitSelectedFlag), loads its moving sprite and builds its range maps. A player unit that cannot move opens its unit menu at once.

        lda wCursorXOffset,b
        clc
        adc wMapScrollXPixels,b
        sta wMovingUnitXPixel,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR0
        sta wMapCursorXTile,b
        sta wMapCursorOriginXTile,b
        lda wCursorYOffset,b
        clc
        adc wMapScrollYPixels,b
        sta wMovingUnitYPixel,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR1
        sta wMapCursorYTile,b
        sta wMapCursorOriginYTile,b
        ldx #$0000

        _B730
        lda aDeploymentTable,x
        beq _B799
        inc wDeployedUnitScanCounter,b
        lda aDeploymentTable,x
        bit #$0008
        bne _B799
        bit #$2000
        bne _B799
        bit #$0080
        beq _B799
        lda aDeploymentTable._XTilePosition,x
        cmp wR0
        bne _B799
        sta wR10
        lda aDeploymentTable._YTilePosition,x
        cmp wR1
        bne _B799
        sta wR11
        inc wUnitSelectedFlag,b
        lda #$0002
        tsb wMapSystemFlags,b
        jsl rlMapMenuEmptyHook
        lda #$0001
        sta wMovingUnitSpriteState,b
        stz wMovingUnitSpriteFrame,b
        stz wMovingUnitSpriteTimer,b
        stx wActiveUnitDeploymentOffset,b
        jsl rlDeployedUnitSetHidden
        stz wMovingUnitSpriteFacing,b
        jsl rlLoadMovingUnitSprite
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlBuildSelectedUnitRangeMaps
        bcs _B7A9

        _B794
        jsr rsShowRangeOverlay
        bra _B7A4


        _B799
        inc x
        inc x
        lda wDeployedUnitScanCounter,b
        cmp @l wDeployedUnitsCount
        bcc _B730

        _B7A4
        stz wDeployedUnitScanCounter,b
        clc
        rts


        _B7A9
        lda bAIEngineFlags,b
        and #$00FF
        bit #$0041
        bne _B794
        ldx wActiveUnitDeploymentOffset,b
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitFactionSlot
        cmp wActiveFactionSlot,b
        bne _B794
        lda wMapCursorXTile,b
        sta wR0
        lda wMapCursorYTile,b
        sta wR1
        ldx wActiveUnitDeploymentOffset,b
        jsl rlMoveDeploymentToTile
        lda #$0002
        trb wMapSystemFlags,b
        stz wUnitSelectedFlag,b
        lda #$0002
        sta wMovingUnitSpriteState,b
        stz wMapCursorState,b
        stz wMapScrollScriptOffset,b
        stz wMapScrollingFlag,b
        lda wCursorXOffset,b
        clc
        adc wMapScrollXPixels,b
        sta wMapSavedCursorXPixel,b
        lda wCursorYOffset,b
        clc
        adc wMapScrollYPixels,b
        sta wMapSavedCursorYPixel,b
        jsl rlOpenUnitMenu
        lda #$0008
        tsb wMapSystemFlags,b
        stz wDeployedUnitScanCounter,b
        sec
        rts

        .databank 0

        ; 88/B813

      rlCheckUnitAtCursor ; 88/B813

        .al
        .xl
        .autsiz
        .databank ?

        ; Carry set if a deployed unit stands on the cursor's tile (only when the cursor is on a tile boundary).

        lda wCursorXOffset,b
        clc
        adc wMapScrollXPixels,b
        bit #$000F
        bne _B869
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR0
        lda wCursorYOffset,b
        clc
        adc wMapScrollYPixels,b
        bit #$000F
        bne _B869
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR1
        ldx #$0000

        _B83A
        lda aDeploymentTable,x
        beq _B85E
        inc wDeployedUnitScanCounter,b
        lda aDeploymentTable,x
        bit #$0080
        beq _B85E
        lda aDeploymentTable._XTilePosition,x
        cmp wR0
        bne _B85E
        lda aDeploymentTable._YTilePosition,x
        cmp wR1
        bne _B85E
        bra _B86E


        _B85E
        inc x
        inc x
        lda wDeployedUnitScanCounter,b
        cmp @l wDeployedUnitsCount
        bcc _B83A

        _B869
        stz wDeployedUnitScanCounter,b
        clc
        rtl


        _B86E
        stz wDeployedUnitScanCounter,b
        sec
        rtl

        .databank 0

        ; 88/B873

      rsShowRangeOverlay ; 88/B873

        .al
        .xl
        .autsiz
        .databank ?

        ; Turns on the colour math for the range overlay and draws it.

        sep #$20
        lda #$11
        sta bBufferTM
        lda #$04
        sta bBufferTS
        lda #$02
        sta bBufferCGWSEL
        lda #$41
        sta bBufferCGADSUB
        rep #$20
        jsr rsSetMovementMapWindowAndRedraw
        rts

        .databank 0

        ; 88/B88B

      rsSetMovementMapWindowAndRedraw ; 88/B88B

        .al
        .xl
        .autsiz
        .databank ?

        ; Centres the 64x64 movement map window on the cursor and redraws the range overlay.

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
        lda wTempVariable1,b
        sec
        sbc #$0020
        sta wMovementMapWindowLeft,b
        clc
        adc #$0040
        sta wMovementMapWindowRight,b
        lda wTempVariable2,b
        sec
        sbc #$0020
        sta wMovementMapWindowTop,b
        clc
        adc #$0040
        sta wMovementMapWindowBottom,b
        lda wMovementMapWindowLeft,b
        bpl _B8D1
        stz wMovementMapWindowLeft,b

        _B8D1
        lda wMovementMapWindowTop,b
        bpl _B8D9
        stz wMovementMapWindowTop,b

        _B8D9
        lda bAIEngineFlags,b
        and #$00FF
        bit #$0041
        bne _B8E8
        jsl rlRedrawRangeOverlayTilemap

        _B8E8
        rts

        .databank 0

        ; 88/B8E9

      rsSetMoveDestinationAtCursor ; 88/B8E9

        .al
        .xl
        .autsiz
        .databank ?

        ; Carry clear if the cursor's tile is a place the active unit can move to (inside its movement, not attack only, no other unit there); then hides the range overlay and builds the path (rsBuildMovementPath).

        lda wCursorXOffset,b
        clc
        adc wMapScrollXPixels,b
        sta wMapSavedCursorXPixel,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wTempVariable1,b
        sta wR0
        lda wCursorYOffset,b
        clc
        adc wMapScrollYPixels,b
        sta wMapSavedCursorYPixel,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wTempVariable2,b
        sta wR1
        jsl rlGetMapDataIndex
        tax
        lda aMapData,x
        and #$03FF
        tax
        lda aTerrainTileset,x
        and #$00FF
        lda wTempVariable2,b
        cmp wMovementMapWindowTop,b
        bcc _B95E
        cmp wMovementMapWindowBottom,b
        bcs _B95E
        lda wTempVariable1,b
        cmp wMovementMapWindowLeft,b
        bcc _B95E
        cmp wMovementMapWindowRight,b
        bcs _B95E
        jsr rsGetMovementMapRowIndex
        lda aMovementMap,x
        bit #$0080
        bne _B95E
        and #$007F
        beq _B95E
        sta $0792,b
        jsr rsCheckTileHasOtherUnit
        bmi _B95E
        jsr rsHideRangeOverlay
        jsr rsBuildMovementPath
        clc
        rts


        _B95E
        sec
        rts

        .databank 0

        ; 88/B960

      rsCheckTileHasOtherUnit ; 88/B960

        .al
        .xl
        .autsiz
        .databank ?

        ; A = $FFFF if a deployed unit other than the active one stands on tile (wTempVariable1, wTempVariable2), else 0.

        ldx #$008E

        _B963
        cpx wActiveUnitDeploymentOffset,b
        beq _B98A
        lda aDeploymentTable,x
        beq _B98A
        bit #$0080
        beq _B98A
        lda aDeploymentTable._XTilePosition,x
        cmp wTempVariable1,b
        bne _B98A
        lda aDeploymentTable._YTilePosition,x
        cmp wTempVariable2,b
        bne _B98A
        lda #$FFFF
        bra _B991


        _B98A
        dec x
        dec x
        bpl _B963
        lda #$0000

        _B991
        rts

        .databank 0

        ; 88/B992

      rsBuildMovementPath ; 88/B992

        .al
        .xl
        .autsiz
        .databank ?

        ; From the destination, steps to the neighbour with the most movement left until the unit's tile, writing the directions (1 down, 2 up, 3 right, 4 left) to the path at $0794; then sends the cursor back to the unit (state 1). Each step tries the neighbours in a different order on odd and even frames.

        lda wVBlankEnabledFramecount
        and #$0001
        beq _B99D
        jml _BAB8


        _B99D
        ldx #$0040

        _B9A0
        stz aMovementPath,b,x
        dec x
        dec x
        bpl _B9A0
        stz wMapScrollScriptOffset,b
        lda wTempVariable1,b
        sta wR4
        lda wTempVariable2,b
        sta wR5
        ldy #$0000

        _B9B7
        lda wR4
        sta wR2
        lda wR5
        sta wR3
        lda wR2
        sta wTempVariable1,b
        lda wR3
        sec
        sbc #$0001
        sta wTempVariable2,b
        jsr rsGetMovementMapRowIndex
        lda aMovementMap,x
        and #$007F
        cmp $0792,b
        bcc _B9F4
        beq _B9F4
        sta $0792,b
        lda #PATH_DOWN
        sta aMovementPath,b,y
        inc wMapScrollScriptOffset,b
        lda wTempVariable1,b
        sta wR4
        lda wTempVariable2,b
        sta wR5

        _B9F4
        lda wR2
        sta wTempVariable1,b
        lda wR3
        clc
        adc #$0001
        sta wTempVariable2,b
        jsr rsGetMovementMapRowIndex
        lda aMovementMap,x
        and #$007F
        cmp $0792,b
        bcc _BA29
        beq _BA29
        sta $0792,b
        lda #PATH_UP
        sta aMovementPath,b,y
        inc wMapScrollScriptOffset,b
        lda wTempVariable1,b
        sta wR4
        lda wTempVariable2,b
        sta wR5

        _BA29
        lda wR2
        sec
        sbc #$0001
        sta wTempVariable1,b
        lda wR3
        sta wTempVariable2,b
        jsr rsGetMovementMapRowIndex
        lda aMovementMap,x
        and #$007F
        cmp $0792,b
        bcc _BA5E
        beq _BA5E
        sta $0792,b
        lda #PATH_RIGHT
        sta aMovementPath,b,y
        inc wMapScrollScriptOffset,b
        lda wTempVariable1,b
        sta wR4
        lda wTempVariable2,b
        sta wR5

        _BA5E
        lda wR2
        clc
        adc #$0001
        sta wTempVariable1,b
        lda wR3
        sta wTempVariable2,b
        jsr rsGetMovementMapRowIndex
        lda aMovementMap,x
        and #$007F
        cmp $0792,b
        bcc _BA9C
        beq _BA9C
        sta $0792,b
        lda #PATH_LEFT
        sta aMovementPath,b,y
        inc wMapScrollScriptOffset,b
        lda wTempVariable1,b
        sta wR4
        lda wTempVariable2,b
        sta wR5

        _BA93
        inc y
        inc y
        stz wMapScrollScriptOffset,b
        jml _B9B7


        _BA9C
        lda wMapScrollScriptOffset,b
        bne _BA93
        sty wSavedMapScrollScriptOffset,b
        stz wMapScrollScriptOffset,b
        sty wMapScrollScriptOffset,b
        lda wActiveUnitDeploymentOffset,b
        jsl rlMoveCursorToUnit
        lda #MAP_CURSOR_BACK_TO_UNIT
        sta wMapCursorState,b
        rts


        _BAB8
        ldx #$0040

        _BABB
        stz aMovementPath,b,x
        dec x
        dec x
        bpl _BABB
        stz wMapScrollScriptOffset,b
        lda wTempVariable1,b
        sta wR4
        lda wTempVariable2,b
        sta wR5
        ldy #$0000

        _BAD2
        lda wR4
        sta wR2
        lda wR5
        sta wR3
        lda wR2
        sec
        sbc #$0001
        sta wTempVariable1,b
        lda wR3
        sta wTempVariable2,b
        jsr rsGetMovementMapRowIndex
        lda aMovementMap,x
        and #$007F
        cmp $0792,b
        bcc _BB0F
        beq _BB0F
        sta $0792,b
        lda #PATH_RIGHT
        sta aMovementPath,b,y
        inc wMapScrollScriptOffset,b
        lda wTempVariable1,b
        sta wR4
        lda wTempVariable2,b
        sta wR5

        _BB0F
        lda wR2
        clc
        adc #$0001
        sta wTempVariable1,b
        lda wR3
        sta wTempVariable2,b
        jsr rsGetMovementMapRowIndex
        lda aMovementMap,x
        and #$007F
        cmp $0792,b
        bcc _BB44
        beq _BB44
        sta $0792,b
        lda #PATH_LEFT
        sta aMovementPath,b,y
        inc wMapScrollScriptOffset,b
        lda wTempVariable1,b
        sta wR4
        lda wTempVariable2,b
        sta wR5

        _BB44
        lda wR2
        sta wTempVariable1,b
        lda wR3
        sec
        sbc #$0001
        sta wTempVariable2,b
        jsr rsGetMovementMapRowIndex
        lda aMovementMap,x
        and #$007F
        cmp $0792,b
        bcc _BB79
        beq _BB79
        sta $0792,b
        lda #PATH_DOWN
        sta aMovementPath,b,y
        inc wMapScrollScriptOffset,b
        lda wTempVariable1,b
        sta wR4
        lda wTempVariable2,b
        sta wR5

        _BB79
        lda wR2
        sta wTempVariable1,b
        lda wR3
        clc
        adc #$0001
        sta wTempVariable2,b
        jsr rsGetMovementMapRowIndex
        lda aMovementMap,x
        and #$007F
        cmp $0792,b
        bcc _BBB7
        beq _BBB7
        sta $0792,b
        lda #PATH_UP
        sta aMovementPath,b,y
        inc wMapScrollScriptOffset,b
        lda wTempVariable1,b
        sta wR4
        lda wTempVariable2,b
        sta wR5

        _BBAE
        inc y
        inc y
        stz wMapScrollScriptOffset,b
        jml _BAD2


        _BBB7
        lda wMapScrollScriptOffset,b
        bne _BBAE
        sty wSavedMapScrollScriptOffset,b
        stz wMapScrollScriptOffset,b
        sty wMapScrollScriptOffset,b
        lda wActiveUnitDeploymentOffset,b
        jsl rlMoveCursorToUnit
        lda #MAP_CURSOR_BACK_TO_UNIT
        sta wMapCursorState,b
        rts

        .databank 0

        ; 88/BBD3

      rsHideRangeOverlay ; 88/BBD3

        .al
        .xl
        .autsiz
        .databank ?

        ; Clears the range overlay (BG3) and its colour math and clears wUnitSelectedFlag.

        sep #$20
        lda #$15
        sta bBufferTM
        lda #$00
        sta bBufferTS
        lda #$00
        sta bBufferCGWSEL
        lda #$00
        sta bBufferCGADSUB
        rep #$20
        stz wBufferBG3HOFS
        stz wBufferBG3VOFS
        ldx #$07FE
        lda #$00FF

        _BBF1
        sta aBG3TilemapBuffer,x
        dec x
        dec x
        bpl _BBF1
        jsl rlMarkAllMapMenuRowsDirty
        jsl rlLoadMapWindowPalettes
        stz wUnitSelectedFlag,b
        rts

        .databank 0

        ; 88/BC05

    .endsection SelectUnitAtCursorSection


    .section StartWalkingSoundSection

      .al
      .xl

      rlStartWalkingSound ; 88/C085

        .al
        .xl
        .autsiz
        .databank ?

        ; Starts the active unit's walking sound (by its map sprite, rlGetMapSpriteMovementSound), panned by the cursor's X and with the water flag of rlGetWalkingSoundTerrainFlag.

        ldx wActiveUnitDeploymentOffset,b
        lda aDeploymentTable._MapSpriteSlot,x
        tax
        lda aDeploymentTable._MapSpriteID,x
        jsl rlGetMapSpriteMovementSound
        sep #$20
        sta aSoundChannelFadeState.bMode,b
        stz aSoundChannelFadeTarget,b
        lda wCursorXOffset,b
        sta aSoundChannelFadeState.bLevel,b
        rep #$20
        jsl rlGetWalkingSoundTerrainFlag
        sep #$20
        lda wR0
        sta aSoundChannelFadeState.bFlags,b
        rep #$20
        rtl

        .databank 0

        ; 88/C0B3

      rlUpdateWalkingSound ; 88/C0B3

        .al
        .xl
        .autsiz
        .databank ?

        ; Updates the walking sound's panning and water flag as the unit moves.

        jsl rlGetWalkingSoundTerrainFlag
        sep #$20
        lda wCursorXOffset,b
        sta aSoundChannelFadeState.bLevel,b
        lda wR0
        sta aSoundChannelFadeState.bFlags,b
        rep #$20
        ldx #$0000
        jsl rlUpdateMapSpriteSoundPanning
        ldx #$0003
        jsl rlUpdateMapSpriteSoundPanning
        rtl

        .databank 0

        ; 88/C0D5

      rlGetWalkingSoundTerrainFlag ; 88/C0D5

        .al
        .xl
        .autsiz
        .databank ?

        ; wR0 = $20 if the cursor's tile is sea, river or swamp and the unit does not fly, else 0.

        jsl rlGetClassWeakness
        bit #$0002
        bne _C11B
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
        jsl rlGetMapDataIndex
        tax
        lda aMapData,x
        and #$03FF
        tax
        lda aTerrainTileset,x
        and #$00FF
        cmp #TerrainSea
        beq _C120
        cmp #TerrainRiver
        beq _C120
        cmp #TerrainSwamp
        beq _C120

        _C11B
        lda #$0000
        bra _C123


        _C120
        lda #$0020

        _C123
        sta wR0
        rtl

        .databank 0

        ; 88/C126

      rlStopWalkingSound ; 88/C126

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$10
        sta aSoundChannelFadeState.bMode,b
        rep #$20
        ldx #$0000
        jsl rlUpdateMapSpriteSoundPanning
        ldx #$0003
        jsl rlUpdateMapSpriteSoundPanning
        rtl

        .databank 0

        ; 88/C13E

    .endsection StartWalkingSoundSection


    .section MapAIMoveStepSection

      .al
      .xl

      rlMapAIMoveStep ; 88/C4D9

        .al
        .xl
        .autsiz
        .databank ?

        ; The computer phase's version of the cursor states: 1 cursor to the acting unit, then picks it up and starts its walk (rsStartAIUnitWalk); 2 walking (speed by the enemy speed option); 3 cursor to its target; 4 a short wait; then the queued AI action runs (rlAIExecuteQueuedAction).

        ; Reached with jml from rlMapCursorStepInner. Steps through states 0-4 in
        ; wMapCursorState and sets up the map scroll distance and speed, then
        ; draws a sprite at the cursor. What the states mean is not known yet.

        lda wMapCursorStepping,b
        beq _C4E2
        jml _C61E


        _C4E2
        lda wMapCursorState,b
        beq _C4FF
        cmp #MAP_AI_CURSOR_TO_UNIT
        beq _C507
        cmp #MAP_AI_UNIT_WALKING
        beq _C53B
        cmp #MAP_AI_CURSOR_TO_TARGET
        beq _C503
        cmp #MAP_AI_WAIT
        bne _C4FF
        jml _C5D2


        _C4FF
        jml _C658


        _C503
        jml _C5AA


        _C507
        lda #$0010
        sta wMapPixelScrollDistance,b
        jsr rsMoveCursorTowardsTarget
        beq _C51C
        lda #$0008
        sta wMapScrollSpeed,b
        jml _C60C


        _C51C
        lda bAIEngineFlags,b
        and #$00FF
        bit #$0002
        bne _C52E
        jsr rsStartAIUnitWalk
        jml _C658


        _C52E
        lda #MAP_CURSOR_FREE
        sta wMapCursorState,b
        sta wMapActionActiveFlag,b
        jml _C658


        _C53B
        jsl rlUpdateWalkingSound
        stz wMapPixelScrollDistance,b
        jsr rsWalkUnitAlongPath
        beq _C564
        jsl rlGetEnemySpeedOption
        cmp #$0000
        bne _C55A
        lda #$0002
        sta wMapScrollSpeed,b
        jml _C60C


        _C55A
        lda #$0004
        sta wMapScrollSpeed,b
        jml _C60C


        _C564
        lda wActiveActionUnit2DeploymentOffset,b
        cmp #$FFFF
        beq _C592
        jsl rlMoveCursorToUnit
        lda #MAP_AI_CURSOR_TO_TARGET
        sta wMapCursorState,b
        lda wCursorXOffset,b
        clc
        adc wMapScrollXPixels,b
        sta wMovingUnitXPixel,b
        lda wCursorYOffset,b
        clc
        adc wMapScrollYPixels,b
        sta wMovingUnitYPixel,b
        lda #$0001
        sta wMovingUnitSpriteState,b
        bra _C5AA


        _C592
        lda #MAP_CURSOR_FREE
        sta wMapCursorState,b
        sta wMapActionActiveFlag,b
        jsl rlEndUnitAction
        lda wActiveActionID,b
        jsl rlAIExecuteQueuedAction
        jml _C658


        _C5AA
        lda #$0010
        sta wMapPixelScrollDistance,b
        jsr rsMoveCursorTowardsTarget
        beq _C5C2
        lda #$0004
        lda #$0008
        sta wMapScrollSpeed,b
        jml _C60C


        _C5C2
        lda #$0018
        sta wMapScrollScriptOffset,b
        lda #MAP_AI_WAIT
        sta wMapCursorState,b
        jml _C658


        _C5D2
        lda wMapScrollScriptOffset,b
        sec
        sbc #$0001
        sta wMapScrollScriptOffset,b
        bmi _C5E0
        bra _C659


        _C5E0
        lda #MAP_CURSOR_FREE
        sta wMapCursorState,b
        sta wMapActionActiveFlag,b
        jsl rlEndUnitAction
        lda wMapScrollXPixels,b
        sta wMapXOffset,b
        lda wMapScrollYPixels,b
        sta wMapYOffset,b
        lda wActiveActionUnit1DeploymentOffset,b
        sta wR0
        lda wActiveActionUnit2DeploymentOffset,b
        sta wR1
        lda wActiveActionID,b
        jsl rlAIExecuteQueuedAction
        bra _C659


        _C60C
        stz wMapScrollCurrentPixelDistance,b
        lda #$0001
        sta wMapCursorStepping,b
        stz wMapScrollingFlag,b
        stz wMapEnableXScrollFlag,b
        stz wMapEnableYScrollFlag,b

        _C61E
        lda wMapScrollCurrentPixelDistance,b
        clc
        adc wMapScrollSpeed,b
        sta wMapScrollCurrentPixelDistance,b
        cmp wMapPixelScrollDistance,b
        bcc _C648
        sec
        sbc wMapPixelScrollDistance,b
        sta wR0
        lda wMapScrollSpeed,b
        sec
        sbc wR0
        sta wMapScrollSpeed,b
        stz wMapCursorStepping,b
        stz wMapScrollingFlag,b
        stz wMapEnableXScrollFlag,b
        stz wMapEnableYScrollFlag,b

        _C648
        jsl rlMoveMapCursorInDirection
        lda wMapCursorState,b
        cmp #MAP_AI_UNIT_WALKING
        bne _C658
        jsl rlUpdateWalkingSound

        _C658
        rtl


        _C659
        sep #$20
        lda #$88
        pha
        plb
        .databank $88
        rep #$20
        ldy #<>aMapCursorSprite
        lda wCursorXOffset,b
        sta wR0
        lda wCursorYOffset,b
        sta wR1
        lda #$0006
        sta wR4
        lda #$2000
        sta wR5
        jsl rlPushToOAMBuffer
        rtl

        .databank 0

        ; 88/C67D

    .endsection MapAIMoveStepSection


    .section StartAIUnitWalkSection

      .al
      .xl

      rsStartAIUnitWalk ; 88/C67D

        ; TRACE: odd-opcode
        .al
        .xl
        .autsiz
        .databank ?

        ; Builds the path to wActiveActionDestinationX/Y (rsSetMoveDestinationAtCursor with the camera moved there) and starts the walk (state 2).

        jsr rsSelectAIUnitAtCursor
        lda wMapScrollXPixels,b
        sta wMapSavedScrollXPixels,b
        lda wMapScrollYPixels,b
        sta wMapSavedScrollYPixels,b
        lda wCursorXOffset,b
        sta wMovingUnitXPixel,b
        lda wCursorYOffset,b
        sta wMovingUnitYPixel,b
        lda #$0000
        sta wCursorXOffset,b
        lda wActiveActionDestinationX,b
        sta wMapScrollXPixels,b
        lda #$0000
        sta wCursorYOffset,b
        lda wActiveActionDestinationY,b
        sta wMapScrollYPixels,b
        jsr rsSetMoveDestinationAtCursor
        bcc _C6B6
        .byte $00 ; brk

        _C6B6
        lda wMapSavedScrollXPixels,b
        sta wMapScrollXPixels,b
        lda wMapSavedScrollYPixels,b
        sta wMapScrollYPixels,b
        lda wMovingUnitXPixel,b
        sta wCursorXOffset,b
        lda wMovingUnitYPixel,b
        sta wCursorYOffset,b
        lda #MAP_AI_UNIT_WALKING
        sta wMapCursorState,b
        lda #$FFFF
        sta wMapScrollDirectionIdentifier,b
        jsl rlStartWalkingSound
        lda wSavedMapScrollScriptOffset,b
        dec a
        dec a
        sta wMapScrollScriptOffset,b
        lda #$0002
        sta wMovingUnitSpriteState,b
        rts

        .databank 0

        ; 88/C6ED

    .endsection StartAIUnitWalkSection


    .section StartTestAIMoveUnusedSection

      .al
      .xl

      rlStartTestAIMoveUnused ; 88/C6ED

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ; Nothing reaches this. Starts an AI move with fixed values (deployment $88 to tile (20, 23), target $0C), apparently a test.

        lda #$FFFF
        sta wMapActionActiveFlag,b
        lda #$0140
        sta wActiveActionDestinationX,b
        lda #$0170
        sta wActiveActionDestinationY,b
        lda #$0088
        sta wActiveActionUnit1DeploymentOffset,b
        lda #$000C
        sta wActiveActionUnit2DeploymentOffset,b
        lda wActiveActionUnit1DeploymentOffset,b
        sta wActiveUnitDeploymentOffset,b
        jsl rlMoveCursorToUnit
        lda #MAP_AI_CURSOR_TO_UNIT
        sta wMapCursorState,b
        rtl

        .databank 0

        ; 88/C71C

    .endsection StartTestAIMoveUnusedSection


    .section StartAIUnitMoveSection

      .al
      .xl

      rsStartAIUnitMove ; 88/C71C

        .al
        .xl
        .autsiz
        .databank ?

        ; Makes wActiveActionUnit1DeploymentOffset the active unit and sends the cursor to it (state 1).

        lda #$0001
        sta wMapActionActiveFlag,b
        lda wActiveActionUnit1DeploymentOffset,b
        sta wActiveUnitDeploymentOffset,b
        jsl rlMoveCursorToUnit
        lda #MAP_AI_CURSOR_TO_UNIT
        sta wMapCursorState,b
        rts

        .databank 0

        ; 88/C733

      rsSelectAIUnitAtCursor ; 88/C733

        .al
        .xl
        .autsiz
        .databank ?

        ; Like rsSelectUnitAtCursor for the computer phase: picks up the acting unit and shows its range.

        lda wCursorXOffset,b
        clc
        adc wMapScrollXPixels,b
        sta wMovingUnitXPixel,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR0
        sta wMapCursorXTile,b
        sta wMapCursorOriginXTile,b
        lda wCursorYOffset,b
        clc
        adc wMapScrollYPixels,b
        sta wMovingUnitYPixel,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR1
        sta wMapCursorYTile,b
        sta wMapCursorOriginYTile,b
        ldx wActiveActionUnit1DeploymentOffset,b

        _C762
        lda aDeploymentTable,x
        beq _C7BF
        inc wDeployedUnitScanCounter,b
        lda aDeploymentTable,x
        bit #$0080
        beq _C7BF
        lda aDeploymentTable._XTilePosition,x
        cmp wR0
        bne _C7BF
        sta wR10
        lda aDeploymentTable._YTilePosition,x
        cmp wR1
        bne _C7BF
        sta wR11
        inc wUnitSelectedFlag,b
        lda #$0002
        tsb wMapSystemFlags,b
        jsl rlMapMenuEmptyHook
        lda #$0001
        sta wMovingUnitSpriteState,b
        stz wMovingUnitSpriteFrame,b
        stz wMovingUnitSpriteTimer,b
        stx wActiveUnitDeploymentOffset,b
        jsl rlDeployedUnitSetHidden
        stz wMovingUnitSpriteFacing,b
        jsl rlLoadMovingUnitSprite
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlBuildSelectedUnitRangeMaps
        jsr rsShowRangeOverlay
        bra _C7CA


        _C7BF
        inc x
        inc x
        lda wDeployedUnitScanCounter,b
        cmp @l wDeployedUnitsCount
        bcc _C762

        _C7CA
        stz wDeployedUnitScanCounter,b
        clc
        rts

        .databank 0

        ; 88/C7CF

    .endsection StartAIUnitMoveSection


