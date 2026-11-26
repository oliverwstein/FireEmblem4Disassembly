; The map cursor during the player phase. rlMapCursorStep runs it every frame:
; with nothing in progress the D-pad moves it a tile at a time (rsGetMapCursorMove,
; rlMoveMapCursorInDirection), otherwise wMapCursorState says what it is doing:
;   0       free (buttons go to rsMapInputHandler)
;   1, 2    a unit's move: back to the unit's tile, then the unit walks its path
;           (engine/map/unit_movement.asm)
;   3       choosing a target (rlMapChooseTargetStep)
;   4-8     travelling to a unit or tile, then 5 selects the unit there, 6 starts
;           choosing a target, 7 selects it or opens its command menu
;   $FFFF   only drawn (the map is being left)
; Also the target cycling over aTargetDistanceMap, the hand cursor used by many
; menus (rlDrawHandCursor) and the cursor's sprite arrays. Bank $88.

    .section MapCursorSpritesSection

      .al
      .xl

      aMapCursorSpriteWide ; 88/EE3C
        .word 4 ; sprite count
        .structSpriteEntry (  -3,   -3), $00, SpriteSmall, $000, 3, 0, false, false
        .structSpriteEntry (  11,   -3), $00, SpriteSmall, $001, 3, 0, false, false
        .structSpriteEntry (  -3,   11), $00, SpriteSmall, $010, 3, 0, false, false
        .structSpriteEntry (  11,   11), $00, SpriteSmall, $011, 3, 0, false, false

      aMapCursorSprite ; 88/EE52
        .word 4 ; sprite count
        .structSpriteEntry (  -2,   -2), $00, SpriteSmall, $000, 3, 0, false, false
        .structSpriteEntry (  10,   -2), $00, SpriteSmall, $001, 3, 0, false, false
        .structSpriteEntry (  -2,   10), $00, SpriteSmall, $010, 3, 0, false, false
        .structSpriteEntry (  10,   10), $00, SpriteSmall, $011, 3, 0, false, false

      aMapCursorSpriteWideTwoPalettes ; 88/EE68
        .word 4 ; sprite count
        .structSpriteEntry (  -3,   -3), $00, SpriteSmall, $000, 3, 0, false, false
        .structSpriteEntry (  11,   -3), $00, SpriteSmall, $001, 3, 0, false, false
        .structSpriteEntry (  -3,   11), $00, SpriteSmall, $010, 2, 0, false, false
        .structSpriteEntry (  11,   11), $00, SpriteSmall, $011, 2, 0, false, false

      aMinimapViewBoxSpriteWide ; 88/EE7E
        .word 4 ; sprite count
        .structSpriteEntry (  -3,   -3), $00, SpriteSmall, $000, 3, 0, false, false
        .structSpriteEntry (  27,   -3), $00, SpriteSmall, $001, 3, 0, false, false
        .structSpriteEntry (  -3,   23), $00, SpriteSmall, $010, 3, 0, false, false
        .structSpriteEntry (  27,   23), $00, SpriteSmall, $011, 3, 0, false, false

      aMinimapViewBoxSprite ; 88/EE94
        .word 4 ; sprite count
        .structSpriteEntry (  -2,   -2), $00, SpriteSmall, $000, 3, 0, false, false
        .structSpriteEntry (  26,   -2), $00, SpriteSmall, $001, 3, 0, false, false
        .structSpriteEntry (  -2,   22), $00, SpriteSmall, $010, 3, 0, false, false
        .structSpriteEntry (  26,   22), $00, SpriteSmall, $011, 3, 0, false, false

      aMapCursorSpriteUnused ; 88/EEAA
        ; Unreferenced.
        .word 1 ; sprite count
        .structSpriteEntry (   0,    0), $21, SpriteLarge, $080, 3, 0, false, false

    .endsection MapCursorSpritesSection


    .section Unsorted848E5DSection

      .al
      .xl

      rlMoveCursorToTile ; 84/8E5D

        .al
        .xl
        .autsiz
        .databank ?

        ; Starts cursor state 4 towards tile (wR10, wR11).

        phb
        php
        phk
        plb
        .databank $84
        lda wR12
        pha
        lda wR13
        pha
        lda wCursorXOffset,b
        clc
        adc wMapScrollXPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR12
        lda wCursorYOffset,b
        clc
        adc wMapScrollYPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR13
        lda wR10
        sec
        sbc wR12
        sta wMapCursorXTile,b
        lda wR11
        sec
        sbc wR13
        sta wMapCursorYTile,b
        lda #MAP_CURSOR_TO_UNIT
        sta wMapCursorState,b
        pla
        sta wR13
        pla
        sta wR12
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 84/8EA0

    .endsection Unsorted848E5DSection


    .section Unsorted88A12BSection

      .al
      .xl

      rlMapCursorStep ; 88/A12B

        .al
        .autsiz
        .databank ?

        ; Runs the map cursor each frame of the map (rlMapStep); see rlMapCursorStepInner.

        phb
        php
        phk
        plb

        jsl rlMapCursorStepInner

        plp
        plb
        rtl

        .databank 0

      rlMapCursorStepInner ; 88/A136

        .al
        .autsiz
        .databank ?

        ; Does nothing while a fade runs or not every input layer is on. Hands over to the AI movement (rlMapAIMoveStep) in a computer phase, to the minimap, or to the cursor state (wMapCursorState); otherwise moves the free cursor with the D-pad and draws it.

        stz wMapCursorResting,b
        jsr rsUpdateMapSystemFlags

        stz wMapScrollingFlag,b
        stz wMapEnableXScrollFlag,b
        stz wMapEnableYScrollFlag,b

        sep #$20
        lda $70
        rep #$20
        and #$000F
        cmp #$000F
        beq +
        
          -
          jml _End

        +
        lda #(`procFadeIn)<<8
        sta $62+1
        lda #<>procFadeIn
        sta $62
        jsl rlProcEngineFindProc
        bcs -

        lda #(`procFadeInByScreenFadingTimer)<<8
        sta $62+1
        lda #<>procFadeInByScreenFadingTimer
        sta $62
        jsl rlProcEngineFindProc
        bcs -

        lda bAIEngineFlags,b
        and #$00FF
        bit #$0041
        beq ++

          lda wMapActionActiveFlag,b
          bpl +

            jsr rsStartAIUnitMove
          
          +
          jml rlMapAIMoveStep

        +
        lda wEventEngineFlags,b
        beq +

          jml _End
        
        +
        lda wMapSystemFlags,b
        bit #$0020
        beq +

          jml rlMinimapStep

        +
        lda wMapActionMode,b
        bpl +

          lda wActiveUnitDeploymentOffset,b
          jsl rlStartCursorToUnitAfterMove
          jml _End
        
        +
        lda wMapReturnFlags,b
        bit #MAP_RETURN_START_CASTLE_STAFF
        beq _A234

          ldx wActiveUnitDeploymentOffset,b
          lda aDeploymentTable._UnitRAMPointer,x
          sta wSelectedUnitDataRAMPointer,b

          ldx wActiveUnitDeploymentOffset,b
          lda wCursorXOffset,b
          clc
          adc wMapScrollXPixels,b
          sta wMapSavedCursorXPixel,b

          lda aDeploymentTable._YTilePosition,x
          asl a
          asl a
          asl a
          asl a
          sta wMapSavedCursorYPixel,b

          lda wCursorXOffset,b
          clc
          adc wMapScrollXPixels,b
          lsr a
          lsr a
          lsr a
          lsr a
          sta wMapCursorXTile,b

          lda wCursorYOffset,b
          clc
          adc wMapScrollYPixels,b
          lsr a
          lsr a
          lsr a
          lsr a
          sta wMapCursorYTile,b

          lda #3
          sta wMovingUnitSpriteState,b

          stz wMovingUnitSpriteFrame,b
          stz wMovingUnitSpriteTimer,b
          jsl rlDeployedUnitSetHidden

          stz wMovingUnitSpriteFacing,b

          jsl rlLoadMovingUnitSprite

          lda wMapReturnFlags,b
          bit #MAP_RETURN_CASTLE_GRID_STAFF
          bne +

            jsl rlStartInventoryStaffTargetSelection

            lda #MAP_RETURN_START_CASTLE_STAFF
            trb wMapReturnFlags,b

            lda #MAP_RETURN_CASTLE_STAFF_ACTIVE
            tsb wMapReturnFlags,b
            bra _A234

          +
          lda #MAP_RETURN_START_CASTLE_STAFF
          trb wMapReturnFlags,b

          jsl rlUseCastleGridStaff

        _A234
        lda wMapCursorState,b
        beq _A24F

          cmp #MAP_CURSOR_LOCKED
          beq ++

            cmp #MAP_CURSOR_CHOOSE_TARGET
            beq +

              jml rlMapCursorMoveStep
            
            +
            jml rlMapChooseTargetStep
          
          +
          jml _A2BD

        _A24F
        lda wMapCursorStepping,b
        bne _A28D

          lda wJoy1New
          bit #~(JOY_Y | JOY_Directions | JOY_ID)
          beq +

            jsr rsMapInputHandler
            stz wMapScrollDirectionIdentifier,b
            bra _A2BD
          
          +
          jsr rsGetMapCursorMove
          bcc _A2BD

            stz wMapScrollCurrentPixelDistance,b
            lda #1
            sta wMapCursorStepping,b
            stz wMapScrollingFlag,b
            stz wMapEnableXScrollFlag,b
            stz wMapEnableYScrollFlag,b
            lda #4
            sta wMapScrollSpeed,b

            lda wJoy1Input
            bit #JOY_Y
            beq _A28D

              lda #8
              sta wMapScrollSpeed,b
        
        _A28D
        lda wMapScrollCurrentPixelDistance,b
        clc
        adc wMapScrollSpeed,b
        sta wMapScrollCurrentPixelDistance,b
        cmp #16
        bcc +

          stz wMapCursorStepping,b
          stz wMapScrollingFlag,b
          stz wMapEnableXScrollFlag,b
          stz wMapEnableYScrollFlag,b
          lda #1
          sta wMapCursorResting,b

        +
        jsl rlMoveMapCursorInDirection

        lda wMapScrollCurrentPixelDistance,b
        cmp wMapScrollSpeed,b
        bne _A2BD

          jsr rsPlayMapCursorMoveSound

        _A2BD
        sep #$20
        lda #$88
        pha
        plb
        rep #$20

        ldy #<>aMapCursorSprite
        lda wCursorXOffset,b
        sta $00
        lda wCursorYOffset,b
        sta $02
        lda #$2000
        sta $0A
        lda #0
        sta $08

        lda wUnitSelectedFlag,b
        beq +

          lda #4
          sta $08
        
        +
        lda $DB
        and #$0018
        beq +

          ldy #<>aMapCursorSpriteWide

        +
        jsl rlPushToOAMBuffer

        _End
        rtl

        .databank 0

        ; 88/A2F5

    .endsection Unsorted88A12BSection


    .section Unsorted88A2F5Section

      .al
      .xl

      rlUseCastleGridStaff ; 88/A2F5

        .al
        .xl
        .autsiz
        .databank ?

        ; For a staff chosen on the castle grid (target already picked): uses it at once (rlRunMapAction) and clears the castle flags.

        lda #MAP_CURSOR_FREE
        sta wMapCursorState,b
        lda wActiveUnitDeploymentOffset,b
        sta wR0
        lda wMapTargetDeploymentOffset,b
        sta wR1
        lda #MAP_RETURN_CASTLE_STAFF_ACTIVE
        trb wMapReturnFlags,b
        lda wMapScrollXPixels,b
        sta wMapXOffset,b
        lda wMapScrollYPixels,b
        sta wMapYOffset,b
        lda #MAP_RETURN_CASTLE_GRID_STAFF
        trb wMapReturnFlags,b
        jsl rlCloseBattleForecast
        jsl rlRunMapAction
        lda #$0008
        jsl rlPlaySoundEffect
        rtl

        .databank 0

        ; 88/A32D

    .endsection Unsorted88A2F5Section


    .section Unsorted88A32DSection

      .al
      .xl

      rsUpdateMapSystemFlags ; 88/A32D

        .al
        .autsiz
        .databank ?

        ; Recomputes the low bits of wMapSystemFlags each frame: Y held, a unit selected, the cursor state busy, an event running.

        lda wMapSystemFlags,b
        bit #$8000
        beq +

          lda #1
          sta wMapCursorResting,b
          lda #$8000
          trb wMapSystemFlags,b
        
        +
        lda wMapSystemFlags,b
        and #$FFE0
        sta wMapSystemFlags,b

        lda wJoy1Input
        bit #$4000 ; JOY_Y
        beq +

          lda #$0001
          tsb wMapSystemFlags,b
        
        +
        lda wUnitSelectedFlag,b
        bne +

          lda wMapReturnFlags,b
          bne +

            lda wMapActionMode,b
            beq ++
        
        +
        lda #$0002
        tsb wMapSystemFlags,b

        +
        lda wMapCursorState,b
        beq +

          lda #$0004
          tsb wMapSystemFlags,b
        
        +
        lda wEventEngineFlags,b
        beq +

          lda #$0010
          tsb wMapSystemFlags,b

        +
        rts

        .databank 0

        ; 88/A383

    .endsection Unsorted88A32DSection


    .section Unreferenced88A383Section

      .al
      .xl

      rlCheckMapScrollingFlagUnused ; 88/A383

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda wMapScrollingFlag,b
        beq _A38A
        sec
        rtl


        _A38A
        clc
        rtl

        .databank 0

        ; 88/A38C

    .endsection Unreferenced88A383Section
    .section Unsorted88A38CSection

      .al
      .xl

      rlCheckMapCursorResting ; 88/A38C

        .al
        .xl
        .autsiz
        .databank ?

        ; Carry set if the cursor has just come to rest on a tile (wMapCursorResting).

        lda wMapCursorResting,b
        beq _A393
        sec
        rtl


        _A393
        clc
        rtl

        .databank 0

        ; 88/A395

    .endsection Unsorted88A38CSection


    .section Unsorted88A395Section

      .al
      .xl

      rlMoveFreeMapCursorUnused ; 88/A395

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ; Nothing reaches this. An older free cursor movement: moves the cursor 16 pixels in the D-pad direction (faster with Y) and draws it.

        stz wMapCursorResting,b
        lda wMapCursorStepping,b
        bne _A3E6
        lda wJoy1Input
        bit #$4000
        bne _A3B0
        lda wJoy1Repeated
        and #$0F00
        sta wMapScrollDirectionIdentifier,b
        beq _A40B
        bra _A3BA


        _A3B0
        lda wJoy1Input
        and #$0F00
        sta wMapScrollDirectionIdentifier,b
        beq _A40B

        _A3BA
        stz wMapScrollCurrentPixelDistance,b
        lda #$0001
        sta wMapCursorStepping,b
        stz wMapScrollingFlag,b
        stz wMapEnableXScrollFlag,b
        stz wMapEnableYScrollFlag,b
        lda #$0005
        jsl rlPlaySoundEffect
        lda #$0004
        sta wMapScrollSpeed,b
        lda wJoy1Input
        bit #$4000
        beq _A3E6
        lda #$0008
        sta wMapScrollSpeed,b

        _A3E6
        lda wMapScrollCurrentPixelDistance,b
        clc
        adc wMapScrollSpeed,b
        sta wMapScrollCurrentPixelDistance,b
        cmp #$0010
        bcc _A407
        stz wMapCursorStepping,b
        stz wMapScrollingFlag,b
        stz wMapEnableXScrollFlag,b
        stz wMapEnableYScrollFlag,b
        lda #$0001
        sta wMapCursorResting,b

        _A407
        jsl rlMoveMapCursorInDirection

        _A40B
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
        lda #$2000
        sta wR5
        lda #$0000
        sta wR4
        lda wUnitSelectedFlag,b
        beq _A447
        cmp #$0001
        beq _A439
        cmp #$0002
        beq _A440

        _A439
        lda #$0004
        sta wR4
        bra _A447


        _A440
        lda #$0006
        sta wR4
        bra _A447


        _A447
        jsl rlPushToOAMBuffer
        rtl

        .databank 0

        ; 88/A44C

    .endsection Unsorted88A395Section


    .section Unsorted88A44CSection

      .al
      .xl

      rlAnimateRangeOverlayPalette ; 88/A44C

        .al
        .xl
        .autsiz
        .databank ?

        ; While a unit is selected, pulses the range overlay colours by frame.

        lda wUnitSelectedFlag,b
        beq _A4BB
        lda wVBlankEnabledFramecount
        and #$0078
        lsr a
        lsr a
        tax
        lda aRangeOverlayPulseColors,x
        clc
        adc #$2E29
        sta $0112,b
        lda aRangeOverlayPulseColors,x
        clc
        adc #$00C1
        sta $0114,b
        lda aRangeOverlayPulseColors2,x
        clc
        adc #$1E18
        sta $011A,b
        lda aRangeOverlayPulseColors2,x
        clc
        adc #$0018
        sta $011C,b
        lda aAIAction.wMapPointer
        bne _A4A3
        lda aRangeOverlayPulseColors2,x
        clc
        adc #$1318
        sta $010A,b
        lda aRangeOverlayPulseColors2,x
        clc
        adc #$0210
        sta $010C,b
        bra _A4BB


        _A4A3
        lda aRangeOverlayPulseColors2,x
        clc
        adc #$1940
        sta $010A,b
        lda aRangeOverlayPulseColors2,x
        clc
        adc #$1020
        sta $010C,b
        bra _A4BB


        _A4BB
        rtl

        .databank 0

        ; 88/A4BC

    .endsection Unsorted88A44CSection


    .section Data88A4BCSection

      .al
      .xl

      aRangeOverlayPulseColors ; 88/A4BC

        ; Read by rlAnimateRangeOverlayPalette.

        .word $0000, $0421, $0842, $0C63, $1084, $14A5, $18C6, $1CE7
        .word $1CE7, $18C6, $14A5, $1084, $0C63, $0842, $0421, $0000

        ; 88/A4DC

      aRangeOverlayPulseColors2 ; 88/A4DC

        ; Read by rlAnimateRangeOverlayPalette.

        .word $0000, $0421, $0842, $0C63, $1084, $14A5, $18C6, $1CE7
        .word $1CE7, $18C6, $14A5, $1084, $0C63, $0842, $0421, $0000

        ; 88/A4FC

    .endsection Data88A4BCSection


    .section Unsorted88A4FCSection

      .al
      .xl

      rlLoadMapWindowPalettes ; 88/A4FC

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlLoadDefaultWindowBorderPalette
        jsl rlLoadWindowPaletteColors
        rtl

        .databank 0

        ; 88/A505

      rlDispatchUnusedWindowPalette88A505 ; 88/A505

        .al
        .xl
        .autsiz
        .databank ?

        ; Unreferenced: runs the entry of aCopyWindowPaletteTailJumpTableUnused for $0756.

        lda $0756,b
        asl a
        tax
        jmp (aCopyWindowPaletteTailJumpTableUnused,x)

        .databank 0

      aCopyWindowPaletteTailJumpTableUnused ; 88/A50D

        ; Read only by the unreferenced rlDispatchUnusedWindowPalette88A505.

        .word <>rlCopyWindowPaletteTail2Unused
        .word <>rlCopyWindowPaletteTail4Unused
        .word <>rlCopyWindowPaletteTail1Unused
        .word <>rlCopyWindowPaletteTail3Unused

      rlCopyWindowPaletteTail1Unused ; 88/A515

        .al
        .xl
        .autsiz
        .databank ?

        ; Copies the words at $DE0012 and $DE0014 to $0112 and $0114 (all four
        ; entries of aCopyWindowPaletteTailJumpTableUnused are the same code).

        lda aWindowPalette+18
        sta $0112,b
        lda aWindowPalette+20
        sta $0114,b
        rtl

        .databank 0

      rlCopyWindowPaletteTail2Unused ; 88/A524

        .al
        .xl
        .autsiz
        .databank ?

        ; Copies the words at $DE0012 and $DE0014 to $0112 and $0114 (all four
        ; entries of aCopyWindowPaletteTailJumpTableUnused are the same code).

        lda aWindowPalette+18
        sta $0112,b
        lda aWindowPalette+20
        sta $0114,b
        rtl

        .databank 0

      rlCopyWindowPaletteTail3Unused ; 88/A533

        .al
        .xl
        .autsiz
        .databank ?

        ; Copies the words at $DE0012 and $DE0014 to $0112 and $0114 (all four
        ; entries of aCopyWindowPaletteTailJumpTableUnused are the same code).

        lda aWindowPalette+18
        sta $0112,b
        lda aWindowPalette+20
        sta $0114,b
        rtl

        .databank 0

      rlCopyWindowPaletteTail4Unused ; 88/A542

        .al
        .xl
        .autsiz
        .databank ?

        ; Copies the words at $DE0012 and $DE0014 to $0112 and $0114 (all four
        ; entries of aCopyWindowPaletteTailJumpTableUnused are the same code).

        lda aWindowPalette+18
        sta $0112,b
        lda aWindowPalette+20
        sta $0114,b
        rtl

        .databank 0

    .endsection Unsorted88A4FCSection


    .section Unsorted88A551Section

      .al
      .xl

      rsGetMapCursorMove ; 88/A551

        .al
        .xl
        .autsiz
        .databank ?

        ; Puts the D-pad direction in wMapScrollDirectionIdentifier and returns carry set if the cursor moves.
        ; With Y held, the held direction moves at once (no repeat delay) and nothing else is checked. Otherwise,
        ; while a unit is selected, a held (not newly pressed) direction moves only from a tile of its movement to
        ; another (aMovementMap & $7F nonzero, so closed areas count), stopping the cursor at the edge.

        lda wJoy1Input
        bit #$4000
        bne _A564
        lda wJoy1Repeated
        and #$0F00
        sta wMapScrollDirectionIdentifier,b
        beq _A5C0
        bra _A570


        _A564
        lda wJoy1Input
        and #$0F00
        sta wMapScrollDirectionIdentifier,b
        beq _A5C0
        bra _A5C2


        _A570
        lda wUnitSelectedFlag,b
        beq _A5C2
        lda wJoy1New
        and #$0F00
        bne _A5C2
        lda wCursorXOffset,b
        sta wR0
        lda wCursorYOffset,b
        sta wR1
        jsr _A650
        bcc _A5C2
        lda wCursorXOffset,b
        sta wR0
        lda wCursorYOffset,b
        sta wR1
        lda wMapScrollDirectionIdentifier,b
        cmp #$0200
        beq _A5C4
        cmp #$0100
        beq _A5D1
        cmp #$0800
        beq _A5DE
        cmp #$0400
        beq _A5EB
        cmp #$0A00
        beq _A5F8
        cmp #$0600
        beq _A60E
        cmp #$0900
        beq _A624
        cmp #$0500
        beq _A63A

        _A5C0
        clc
        rts


        _A5C2
        sec
        rts


        _A5C4
        lda wCursorXOffset,b
        sec
        sbc #$0010
        sta wR0
        jml _A650


        _A5D1
        lda wCursorXOffset,b
        clc
        adc #$0010
        sta wR0
        jml _A650


        _A5DE
        lda wCursorYOffset,b
        sec
        sbc #$0010
        sta wR1
        jml _A650


        _A5EB
        lda wCursorYOffset,b
        clc
        adc #$0010
        sta wR1
        jml _A650


        _A5F8
        lda wCursorXOffset,b
        sec
        sbc #$0010
        sta wR0
        lda wCursorYOffset,b
        sec
        sbc #$0010
        sta wR1
        jml _A650


        _A60E
        lda wCursorXOffset,b
        sec
        sbc #$0010
        sta wR0
        lda wCursorYOffset,b
        clc
        adc #$0010
        sta wR1
        jml _A650


        _A624
        lda wCursorXOffset,b
        clc
        adc #$0010
        sta wR0
        lda wCursorYOffset,b
        sec
        sbc #$0010
        sta wR1
        jml _A650


        _A63A
        lda wCursorXOffset,b
        clc
        adc #$0010
        sta wR0
        lda wCursorYOffset,b
        clc
        adc #$0010
        sta wR1
        jml _A650


        _A650
        lda wR0
        clc
        adc wMapScrollXPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wTempVariable1,b
        sta wR0
        lda wR1
        clc
        adc wMapScrollYPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wTempVariable2,b
        sta wR1
        lda wTempVariable2,b
        cmp wMovementMapWindowTop,b
        bcc _A696
        cmp wMovementMapWindowBottom,b
        bcs _A696
        lda wTempVariable1,b
        cmp wMovementMapWindowLeft,b
        bcc _A696
        cmp wMovementMapWindowRight,b
        bcs _A696
        jsr rsGetMovementMapRowIndex
        lda aMovementMap,x
        and #$007F
        beq _A696
        sec
        rts


        _A696
        clc
        rts

        .databank 0

        ; 88/A698

    .endsection Unsorted88A551Section


    .section Unsorted88A698Section

      .al
      .xl

      rsSetCursorScrollSpeedUnused ; 88/A698

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ; Nothing reaches this. Sets wMapScrollSpeed to 8 with Y held, 4 while a direction is held after the first step, else 1.

        lda wJoy1Input
        bit #$4000
        bne _A6B3
        lda $0752,b
        beq _A6BB
        lda wJoy1New
        and #$0F00
        bne _A6BB
        lda #$0004
        sta wMapScrollSpeed,b
        bra _A6C3


        _A6B3
        lda #$0008
        sta wMapScrollSpeed,b
        bra _A6C3


        _A6BB
        lda #$0001
        sta wMapScrollSpeed,b
        bra _A6C3


        _A6C3
        lda #$0001
        sta $0752,b
        rts

        .databank 0

        ; 88/A6CA

      aMapCursorTilemapEntryUnused ; 88/A6CA

        ; Unreferenced. The same nine bytes follow an rts at both 80/F337 and
        ; 88/A6CA; nothing reads either copy.
        .byte $20, $20, $00, $00, $00, $00, $88, $83, $7E

      rsDrawCursorTileCoordsUnused ; 88/A6D3

        .al
        .xl
        .autsiz
        .databank ?

        ; Unreferenced.

        lda wCursorXOffset,b
        clc
        adc wMapScrollXPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        ldx #$20F0
        stx aCurrentTilemapInfo,b
        ldx #$0407
        jsl rlDrawTallTwoDigitNumberToTilemapEntry
        lda wCursorYOffset,b
        clc
        adc wMapScrollYPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        ldx #$20F0
        stx aCurrentTilemapInfo,b
        ldx #$040A
        jsl rlDrawTallTwoDigitNumberToTilemapEntry
        rts

        .databank 0

        ; 88/A704

    .endsection Unsorted88A698Section


    .section Unsorted88A704Section

      .al
      .xl

      rlDrawHandCursor ; 88/A704

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws the hand cursor at (wR0, wR1); with A = 0 it bobs sideways by frame (aHandCursorOffsets). Used by many menus.

        phb
        phx
        phy
        cmp #$0000
        beq _A710
        lda wR0
        bra _A71E


        _A710
        lda wVBlankEnabledFramecount
        and #$001C
        lsr a
        tax
        lda aHandCursorOffsets,x
        clc
        adc wR0

        _A71E
        sta wR0
        sep #$20
        lda #$88
        pha
        plb
        .databank $88
        rep #$20
        ldy #<>aHandCursorSprite
        lda #$0000
        sta wR4
        lda #$2000
        sta wR5
        jsl rlPushToOAMBuffer
        ply
        plx
        plb
        .databank $88
        rtl

        .databank 0

        ; 88/A73D

    .endsection Unsorted88A704Section


    .section Table88A73DSection

      .al
      .xl

      aHandCursorOffsets ; 88/A73D

        ; Read by rlDrawHandCursor.

        .word $0000, $0000, $0001, $0001, $0000, $0000, $FFFF, $FFFF

      aHandCursorSprite ; 88/A74D

        _Sprites := [[(   0,    0), $21, SpriteLarge, $002, 3, 0, false, false]]

        .structSpriteArray aHandCursorSprite._Sprites

        ; 88/A754

    .endsection Table88A73DSection


    .section Unsorted88A81DSection

      .al
      .xl

      rlMapChooseTargetStep ; 88/A81D

        .al
        .xl
        .autsiz
        .databank ?

        ; Cursor state 3, choosing a target: the D-pad picks the next target (rsSelectNextTarget) and shows the battle forecast, A acts (rlRunMapAction, or the minimap for a warp destination), B goes back to the unit menu or, for a castle staff, puts the unit back in the castle.

        lda #$0003
        sta wMovingUnitSpriteState,b
        lda wJoy1New
        bit #$8000
        beq _A89A
        lda wMapCursorOriginXTile,b
        sta wMapCursorXTile,b
        lda wMapCursorOriginYTile,b
        sta wMapCursorYTile,b
        lda #$0005
        jsl rlPlaySoundEffect
        stz wMapCursorState,b
        lda wMapReturnFlags,b
        bit #MAP_RETURN_CASTLE_STAFF_ACTIVE
        bne _A85D
        lda #$0008
        tsb wMapSystemFlags,b
        jsl rlCloseBattleForecast
        jsl rlOpenUnitMenu
        lda #$0800
        trb wChapterFlags,b
        rtl


        _A85D
        lda #$0040
        trb wChapterFlags,b
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
        jsl rlCloseBattleForecast
        stz wMovingUnitSpriteState,b
        lda #MAP_RETURN_CASTLE_STAFF_ACTIVE
        trb wMapReturnFlags,b
        ldx wActiveUnitDeploymentOffset,b
        jsl rlEnterTargetLocation
        rtl


        _A89A
        lda wJoy1Repeated
        bit #$0F00
        bne _A8A3
        bra _A8EB


        _A8A3
        lda #$0005
        jsl rlPlaySoundEffect
        jsr rsSelectNextTarget
        lda wActiveUnitDeploymentOffset,b
        sta wR0
        lda wMapTargetDeploymentOffset,b
        sta wR1
        jsl rlShowBattleForecast
        lda wMapTargetDeploymentOffset,b
        tax
        lda aDeploymentTable._XTilePosition,x
        sta wR10
        lda aDeploymentTable._YTilePosition,x
        sta wR11
        jsl rlGetTileScreenPixelPosition
        lda wR10
        bmi _A8DD
        sta wCursorXOffset,b
        lda wR11
        sta wCursorYOffset,b
        bra _A8EB


        _A8DD
        lda wMapTargetDeploymentOffset,b
        jsl rlMoveCursorToUnit
        lda #MAP_CURSOR_TO_TARGET
        sta wMapCursorState,b
        rtl


        _A8EB
        lda wMapTargetDeploymentOffset,b
        tax
        lda aDeploymentTable._XTilePosition,x
        asl a
        asl a
        asl a
        asl a
        sec
        sbc wMapScrollXPixels,b
        sta wR0
        lda aDeploymentTable._YTilePosition,x
        asl a
        asl a
        asl a
        asl a
        sec
        sbc wMapScrollYPixels,b
        sta wR1
        sep #$20
        lda #$88
        pha
        plb
        .databank $88
        rep #$20
        ldy #<>aMapCursorSprite
        lda #$0006
        sta wR4
        lda #$2000
        sta wR5
        jsl rlPushToOAMBuffer
        lda wJoy1New
        bit #$0080
        bne _A92C
        rtl


        _A92C
        lda #MAP_CURSOR_FREE
        sta wMapCursorState,b
        lda wActiveUnitDeploymentOffset,b
        sta wR0
        lda wMapTargetDeploymentOffset,b
        sta wR1
        lda #MAP_RETURN_CASTLE_STAFF_ACTIVE
        trb wMapReturnFlags,b
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
        lda wChapterFlags,b
        bit #$0800
        bne _A994
        jsl rlCloseBattleForecast
        jsl rlRunMapAction
        lda #$000A
        jsl rlPlaySoundEffect
        rtl


        _A994
        jsl rlCloseBattleForecast
        stz wCastleSubMenuStep,b
        lda #$0020
        tsb wMapSystemFlags,b
        jsl rlMapMenuEmptyHook
        lda #(`procMinimap)<<8
        sta lR44+1
        lda #<>procMinimap
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 88/A9B4

    .endsection Unsorted88A81DSection


    .section Unsorted88AB2CSection

      .al
      .xl

      rsGetCursorTileUnused ; 88/AB2C

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ; Nothing reaches this. wR10/wR11 = the cursor's map tile.

        lda wCursorXOffset,b
        clc
        adc wMapScrollXPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR10
        lda wCursorYOffset,b
        clc
        adc wMapScrollYPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR11
        rts

        .databank 0

        ; 88/AB47

    .endsection Unsorted88AB2CSection


    .section Unsorted88AB47Section

      .al
      .xl

      rsSelectNextTarget ; 88/AB47

        .al
        .xl
        .autsiz
        .databank ?

        ; Picks the next or previous target in aTargetDistanceMap: all 1,024 tiles for a weapon with range 3 or more, else the 12 tiles of aNearTargetOffsets.

        ldx wActiveUnitDeploymentOffset,b
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedItemRange
        cmp #$0000
        beq _AB61
        lda wR11
        cmp #$0003
        bcs _AB65

        _AB61
        jml _ABD4


        _AB65
        lda wJoy1Repeated
        bit #$0A00
        bne _AB82
        lda wMapTargetSearchIndex,b
        clc
        adc #$0001
        cmp #$0400
        bcc _AB7B
        lda #$0000

        _AB7B
        sta wMapTargetSearchIndex,b
        jml _AB95


        _AB82
        lda wMapTargetSearchIndex,b
        sec
        sbc #$0001
        bpl _AB8E
        lda #$03FF

        _AB8E
        sta wMapTargetSearchIndex,b
        jml _ABB6


        _AB95
        ldx wMapTargetSearchIndex,b

        _AB98
        lda aTargetDistanceMap,x
        and #$00FF
        cmp #$00FF
        bne _ABAF
        inc x
        cpx #$0400
        bcc _AB98
        ldx #$0000
        bra _AB98


        _ABAF
        sta wMapTargetDeploymentOffset,b
        stx wMapTargetSearchIndex,b
        rts


        _ABB6
        ldx wMapTargetSearchIndex,b

        _ABB9
        lda aTargetDistanceMap,x
        and #$00FF
        cmp #$00FF
        bne _ABCD
        dec x
        bpl _ABB9
        ldx #$03FF
        bra _ABB9


        _ABCD
        sta wMapTargetDeploymentOffset,b
        stx wMapTargetSearchIndex,b
        rts


        _ABD4
        lda wJoy1Repeated
        bit #$0A00
        bne _ABF1
        lda wMapTargetSearchIndex,b
        clc
        adc #$0001
        cmp #$000C
        bcc _ABEA
        lda #$0000

        _ABEA
        sta wMapTargetSearchIndex,b
        jml _AC2E


        _ABF1
        lda wMapTargetSearchIndex,b
        sec
        sbc #$0001
        bpl _ABFD
        lda #$000B

        _ABFD
        sta wMapTargetSearchIndex,b
        jml _AC04


        _AC04
        lda wMapTargetSearchIndex,b
        asl a
        tax

        _AC09
        phx
        lda aNearTargetOffsets,x
        tax
        lda aTargetDistanceMap,x
        plx
        and #$00FF
        cmp #$00FF
        bne _AC25
        dec x
        dec x
        bpl _AC09
        ldx #$0016
        bra _AC09


        _AC25
        sta wMapTargetDeploymentOffset,b
        txa
        lsr a
        sta wMapTargetSearchIndex,b
        rts


        _AC2E
        lda wMapTargetSearchIndex,b
        asl a
        tax

        _AC33
        phx
        lda aNearTargetOffsets,x
        tax
        lda aTargetDistanceMap,x
        plx
        and #$00FF
        cmp #$00FF
        bne _AC52
        inc x
        inc x
        cpx #$0018
        bcc _AC33
        ldx #$0000
        bra _AC33


        _AC52
        sta wMapTargetDeploymentOffset,b
        txa
        lsr a
        sta wMapTargetSearchIndex,b
        rts

        .databank 0

        ; 88/AC5B

    .endsection Unsorted88AB47Section


    .section Unsorted88AC5BSection

      .al
      .xl

      rsSelectNextTargetInOrderUnused ; 88/AC5B

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ; Nothing reaches this. Steps wMapTargetSearchIndex left or right through aTargetDistanceMap to the next target.

        lda wJoy1New
        bit #$0200
        bne _AC6A
        lda #$0001
        sta wTempVariable1,b
        bra _AC70


        _AC6A
        lda #$FFFF
        sta wTempVariable1,b

        _AC70
        lda #$0400
        sta wTempVariable2,b

        _AC76
        jsr rsGetTargetAtSearchIndexUnused
        bne _ACA2
        lda wMapTargetSearchIndex,b
        clc
        adc wTempVariable1,b
        sta wMapTargetSearchIndex,b
        bmi _AC94
        cmp wTempVariable2,b
        bcc _ACA0
        lda #$0000
        sta wMapTargetSearchIndex,b
        bra _ACA0


        _AC94
        lda wTempVariable2,b
        sec
        sbc #$0001
        sta wMapTargetSearchIndex,b
        bra _ACA0


        _ACA0
        bra _AC76


        _ACA2
        sta wMapTargetDeploymentOffset,b
        rts

        .databank 0

        ; 88/ACA6

    .endsection Unsorted88AC5BSection


    .section Unsorted88ACA6Section

      .al
      .xl

      rsGetTargetAtSearchIndexUnused ; 88/ACA6

        .al
        .xl
        .autsiz
        .databank ?

        ; The deployment offset in aTargetDistanceMap at wMapTargetSearchIndex, or 0 for none.

        lda wMapTargetSearchIndex,b
        tax
        lda aTargetDistanceMap,x
        and #$00FF
        cmp #$00FF
        beq _ACB7
        rts


        _ACB7
        lda #$0000
        rts

        .databank 0

        ; 88/ACBB

      aNearTargetOffsetsUnused ; 88/ACBB

        ; Unreferenced: signed pixel offsets, like aNearTargetOffsets after it.

        .word $000C, $000C, $000C, $0000, $0010, $0000, $FFF0, $0000
        .word $0010, $0020, $0010, $0000, $FFF0, $FFE0, $FFF0, $FFF0
        .word $0000, $0010, $0000, $FFE0, $FFF0, $0000, $0010, $0020
        .word $0010, $0000, $FFF0

    .endsection Unsorted88ACA6Section


    .section Table88ACF1Section

      .al
      .xl

      aNearTargetOffsets ; 88/ACF1

        ; Read by rsSelectNextTarget, which reads 12 words.

        .word $01D0, $01F0, $01F1, $0212, $0211, $0231, $0250, $0230
        .word $022F, $020E, $020F, $01EF

        ; 88/AD09

    .endsection Table88ACF1Section


    .section Unreferenced88AD09Section

      .al
      .xl

      rsFindOtherFactionUnitAtTileUnused ; 88/AD09

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ldx #$008E

        _AD0C
        lda aDeploymentTable,x
        beq _AD33
        and #$0003
        cmp wActiveFactionSlot,b
        beq _AD33
        lda aDeploymentTable._XTilePosition,x
        cmp wR0
        bne _AD33
        sta wR10
        lda aDeploymentTable._YTilePosition,x
        cmp wR1
        bne _AD33
        sta wR11
        stx wMapTargetDeploymentOffset,b
        bra _AD3F


        _AD33
        dec x
        dec x
        bmi _AD3B
        jml _AD0C


        _AD3B
        lda $0792,b
        rts


        _AD3F
        lda #$0001
        sta $0792,b
        rts

        .databank 0

        ; 88/AD46

    .endsection Unreferenced88AD09Section
    .section Unsorted88AD46Section

      .al
      .xl

      rlStartChoosingTarget ; 88/AD46

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Sets cursor state 3, picks the first target, shows the battle forecast and moves the cursor to it (state 6 when the map has to scroll).

        lda #MAP_CURSOR_CHOOSE_TARGET
        sta wMapCursorState,b
        lda #$0003
        sta wMovingUnitSpriteState,b
        stz wMapTargetSearchIndex,b
        jsr rsSelectNextTarget
        lda wMapCursorXTile,b
        sta wMapCursorOriginXTile,b
        lda wMapCursorYTile,b
        sta wMapCursorOriginYTile,b
        lda wActiveUnitDeploymentOffset,b
        sta wR0
        lda wMapTargetDeploymentOffset,b
        sta wR1
        jsl rlShowBattleForecast
        lda wMapTargetDeploymentOffset,b
        tax
        lda aDeploymentTable._XTilePosition,x
        sta wR10
        lda aDeploymentTable._YTilePosition,x
        sta wR11
        jsl rlGetTileScreenPixelPosition
        lda wR10
        bmi _AD94
        sta wCursorXOffset,b
        lda wR11
        sta wCursorYOffset,b
        bra _ADA1


        _AD94
        lda wMapTargetDeploymentOffset,b
        jsl rlMoveCursorToUnit
        lda #MAP_CURSOR_TO_TARGET
        sta wMapCursorState,b

        _ADA1
        rtl

        .databank 0

        ; 88/ADA2

    .endsection Unsorted88AD46Section


    .section Unsorted88ADA2Section

      .al
      .xl

      rlSetMapCursorFree ; 88/ADA2

        .al
        .xl
        .autsiz
        .databank ?

        stz wMapCursorState,b
        rtl

        .databank 0

        ; 88/ADA6

    .endsection Unsorted88ADA2Section


    .section Unsorted88ADA6Section

      .al
      .xl

      rlSetMapCursorOriginToCursor ; 88/ADA6

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda wCursorXOffset,b
        clc
        adc wMapScrollXPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wMapCursorXTile,b
        sta wMapCursorOriginXTile,b
        lda wCursorYOffset,b
        clc
        adc wMapScrollYPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wMapCursorYTile,b
        sta wMapCursorOriginYTile,b
        rtl

        .databank 0

        ; 88/ADC9

    .endsection Unsorted88ADA6Section


    .section Unsorted88ADC9Section

      .al
      .xl

      rlStartCursorToActiveUnitForAction ; 88/ADC9

        .al
        .xl
        .autsiz
        .databank ?

        ; Sends the cursor to the active unit (state 8) and sets wMapActionMode to 5, or 9 when it was 0.

        lda wActiveUnitDeploymentOffset,b
        jsl rlMoveCursorToUnit
        lda #MAP_CURSOR_TO_UNIT_ACTION
        sta wMapCursorState,b
        lda wMapActionMode,b
        beq _ADE2
        lda #MAP_ACTION_MODE_GUARD_SORTIE
        sta wMapActionMode,b
        rtl


        _ADE2
        lda #MAP_ACTION_MODE_GUARD_MENU_1
        sta wMapActionMode,b
        rtl

        .databank 0

        ; 88/ADE9

    .endsection Unsorted88ADC9Section


    .section Unsorted88B3AFSection

      .al
      .xl

      rlSaveMapCameraAndLockCursor ; 88/B3AF

        .al
        .xl
        .autsiz
        .databank ?

        ; Sets wMapCursorState to $FFFF (the cursor only draws) and saves the camera in wMapXOffset/wMapYOffset, before leaving the map for a conversation.

        lda #MAP_CURSOR_LOCKED
        sta wMapCursorState,b
        lda wMapScrollXPixels,b
        sta wMapXOffset,b
        lda wMapScrollYPixels,b
        sta wMapYOffset,b
        rtl

        .databank 0

        ; 88/B3C2

    .endsection Unsorted88B3AFSection


    .section Unreferenced88B3C2Section

      .al
      .xl

      rlClearMapDataTileUnused ; 88/B3C2

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phb
        jsl rlGetMapDataIndex
        tax
        lda #$0000
        sta aMapData,x
        plb
        .databank ?
        rtl

        .databank 0

        ; 88/B3D1

      rlSetMapDataTileUnused ; 88/B3D1

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phb
        jsl rlGetMapDataIndex
        tax
        lda wR2
        sta aMapData,x
        plb
        .databank ?
        rtl

        .databank 0

        ; 88/B3DF

    .endsection Unreferenced88B3C2Section
    .section Unsorted88B42CSection

      .al
      .xl

      rlStartCursorToUnitAfterMove ; 88/B42C

        .al
        .xl
        .autsiz
        .databank ?

        ; Sends the cursor to unit A (state 5) and turns wMapActionMode $8002-$8004 into 2-4 (4 also uses state 8), anything else into 1.

        jsl rlMoveCursorToUnit
        lda #MAP_CURSOR_TO_UNIT_SELECT
        sta wMapCursorState,b
        lda wMapActionMode,b
        cmp #MAP_ACTION_MODE_PENDING | MAP_ACTION_MODE_DEPARTED
        beq _B44F
        cmp #MAP_ACTION_MODE_PENDING | MAP_ACTION_MODE_CASTLE_GUARD
        beq _B456
        cmp #MAP_ACTION_MODE_PENDING | MAP_ACTION_MODE_GUARD
        beq _B45D
        lda #MAP_ACTION_MODE_SORTIE
        sta wMapActionMode,b
        rtl


        _B44F
        lda #MAP_ACTION_MODE_DEPARTED
        sta wMapActionMode,b
        rtl


        _B456
        lda #MAP_ACTION_MODE_CASTLE_GUARD
        sta wMapActionMode,b
        rtl


        _B45D
        lda #MAP_ACTION_MODE_GUARD
        sta wMapActionMode,b
        lda #MAP_CURSOR_TO_UNIT_ACTION
        sta wMapCursorState,b
        rtl

        .databank 0

        ; 88/B46A

    .endsection Unsorted88B42CSection


    .section Unsorted88B46ASection

      .al
      .xl

      rlStartCursorToUnit ; 88/B46A

        .al
        .xl
        .autsiz
        .databank ?

        ; Sends the cursor to unit A (state 4). In a computer phase also makes it the acting unit and uses state 1.

        sta wMapPanTargetDeploymentOffset,b
        lda bAIEngineFlags,b
        and #$00FF
        bit #$0041
        beq _B48D
        lda wMapPanTargetDeploymentOffset,b
        sta wActiveActionUnit1DeploymentOffset,b
        sta wActiveUnitDeploymentOffset,b
        lda #$0001
        sta wMapActionActiveFlag,b
        lda #$0002
        tsb bAIEngineFlags,b

        _B48D
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
        ldx wMapPanTargetDeploymentOffset,b
        lda aDeploymentTable._XTilePosition,x
        sec
        sbc wTempVariable1,b
        sta wMapCursorXTile,b
        lda aDeploymentTable._YTilePosition,x
        sec
        sbc wTempVariable2,b
        sta wMapCursorYTile,b
        lda #MAP_CURSOR_TO_UNIT
        sta wMapCursorState,b
        lda bAIEngineFlags,b
        and #$00FF
        bit #$0041
        bne _B4D4
        rtl


        _B4D4
        lda #MAP_AI_CURSOR_TO_UNIT
        sta wMapCursorState,b
        rtl

        .databank 0

        ; 88/B4DB

    .endsection Unsorted88B46ASection


    .section Unsorted88B4DBSection

      .al
      .xl

      rlMoveCursorToUnit ; 88/B4DB

        .al
        .autsiz
        .databank ?

        ; Sets wMapCursorXTile/YTile to the distance from the cursor to unit A and starts cursor state 4 (travelling to it).

        sta wMapPanTargetDeploymentOffset,b

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

        ldx wMapPanTargetDeploymentOffset,b
        lda aDeploymentTable._XTilePosition,x
        sec
        sbc wTempVariable1,b
        sta wMapCursorXTile,b

        lda aDeploymentTable._YTilePosition,x
        sec
        sbc wTempVariable2,b
        sta wMapCursorYTile,b

        lda #MAP_CURSOR_TO_UNIT
        sta wMapCursorState,b
        rtl

        .databank 0

        ; 88/B51A

    .endsection Unsorted88B4DBSection


    .section Unsorted88B64FSection

      .al
      .xl

      rsMoveCursorTowardsTarget ; 88/B64F

        .al
        .autsiz
        .databank ?

        ; Cursor states 4-7: one tile towards the target; on arrival state 5 selects the unit there, 6 starts choosing a target, 7 selects the unit or opens its command menu.

        lda wMapCursorXTile,b
        beq ++
        bpl +

          inc wMapCursorXTile,b
          lda #$0200
          bra _End
          
            +
            dec wMapCursorXTile,b
            lda #$0100
            bra _End

        +
        lda wMapCursorYTile,b
        beq _B681
        bpl +

          inc wMapCursorYTile,b
          lda #$0800
          bra _End

        +
        dec wMapCursorYTile,b
        lda #$0400
        bra _End
        
        _End
        sta wMapScrollDirectionIdentifier,b
        rts

        _B681
        lda wMapCursorState,b
        cmp #MAP_CURSOR_TO_UNIT_SELECT
        beq _B6A6

          cmp #MAP_CURSOR_TO_TARGET
          beq _B6B6

            cmp #MAP_CURSOR_TO_UNIT_MENU
            beq _B6D4

              stz wMapScrollingFlag,b
              stz wMapScrollScriptOffset,b
              stz wMapCursorState,b
              lda #$0004
              trb wMapSystemFlags,b
              lda #0
              rts
        
        _B6A6
        stz wMapScrollingFlag,b
        stz wMapScrollScriptOffset,b
        stz wMapCursorState,b
        jsr rsSelectUnitAtCursor
        lda #0
        rts

        _B6B6
        stz wMapScrollingFlag,b
        stz wMapScrollScriptOffset,b
        lda #MAP_CURSOR_CHOOSE_TARGET
        sta wMapCursorState,b
        lda wActiveUnitDeploymentOffset,b
        sta $00
        lda wMapTargetDeploymentOffset,b
        sta $02
        jsl rlShowBattleForecast
        lda #0
        rts

        _B6D4
        stz wMapScrollingFlag,b
        stz wMapScrollScriptOffset,b
        stz wMapCursorState,b
        lda wMapStateFlags,b
        bit #$0008
        bne +

          jsr rsSelectUnitAtCursor
          lda #0
          rts

        +
        ldx wActiveUnitDeploymentOffset,b
        jsl rlRequestUnitMenuMode1
        lda #$0008
        tsb wMapSystemFlags,b
        lda #0
        rts

        .databank 0

        ; 88/B6FD

    .endsection Unsorted88B64FSection


    .section Unsorted88BC05Section

      .al
      .xl

      rlMoveMapCursorInDirection ; 88/BC05

        .al
        .autsiz
        .databank ?

        ; Moves the cursor by wMapScrollSpeed in wMapScrollDirectionIdentifier; within 48 pixels of the screen edge (16 at the map edge) the map scrolls instead. Bit 0 of $0764 is set if the cursor moved.

        lda #$0001
        trb wMapCursorMoved,b

        lda wMapScrollDirectionIdentifier,b
        cmp #$0200
        beq _0200

        cmp #$0100
        beq _0100

        cmp #$0800
        beq _0800

        cmp #$0400
        beq _0400

        cmp #$0A00
        beq _0A00

        cmp #$0600
        beq _0600

        cmp #$0900
        beq _0900

        cmp #$0500
        beq _0500

        rtl

        _0200
        jsr rsMoveMapCursorLeft
        rtl
        
        _0100
        jsr rsMoveMapCursorRight
        rtl
        
        _0800
        jsr rsMoveMapCursorUp
        rtl
        
        _0400
        jsr rsMoveMapCursorDown
        rtl
        
        _0A00
        jsr rsMoveMapCursorLeft
        jsr rsMoveMapCursorUp
        rtl
        
        _0600
        jsr rsMoveMapCursorLeft
        jsr rsMoveMapCursorDown
        rtl
        
        _0900
        jsr rsMoveMapCursorRight
        jsr rsMoveMapCursorUp
        rtl
        
        _0500
        jsr rsMoveMapCursorRight
        jsr rsMoveMapCursorDown
        rtl

        .databank 0

      rsMoveMapCursorLeft ; 88/BC63

        .al
        .autsiz
        .databank ?

        lda wMapScrollXPixels,b
        cmp wMapMinXScroll,b
        beq +

        lda wCursorXOffset,b
        sec
        sbc wMapScrollSpeed,b
        cmp #$0030
        bcc ++

        sta wCursorXOffset,b
        lda #$0001
        tsb wMapCursorMoved,b
        rts
        
        +
        lda wCursorXOffset,b
        sec
        sbc wMapScrollSpeed,b
        cmp #$0010
        bcc _BCF4

        sta wCursorXOffset,b
        lda #$0001
        tsb wMapCursorMoved,b
        rts
        
        +
        lda wMapScrollXPixels,b
        sec
        sbc wMapScrollSpeed,b
        sec
        sbc #1
        cmp wMapMinXScroll,b
        bmi +
        bcs ++
        
        +
        clc
        adc #1
        sta $00

        lda wMapMinXScroll,b
        sec
        sbc $00
        sta $00

        lda wCursorXOffset,b
        sec
        sbc #$0030
        clc
        adc wMapScrollCurrentPixelDistance,b
        sta wMapScrollCurrentPixelDistance,b

        lda #$0030
        sec
        sbc $00
        sta wCursorXOffset,b
        bra ++
        
        +
        lda wCursorXOffset,b
        sec
        sbc #$0030
        clc
        adc wMapScrollCurrentPixelDistance,b
        sta wMapScrollCurrentPixelDistance,b

        lda #$0030
        sta wCursorXOffset,b
        
        +
        lda #1
        sta wMapScrollingFlag,b
        sta wMapEnableXScrollFlag,b
        lda #$0001
        tsb wMapCursorMoved,b
        rts

        _BCF4
        lda wCursorXOffset,b
        sec
        sbc #$0010
        clc
        adc wMapScrollCurrentPixelDistance,b
        sta wMapScrollCurrentPixelDistance,b
        lda #$0010
        sta wCursorXOffset,b
        rts

        .databank 0

      rsMoveMapCursorRight ; 88/BD09

        .al
        .autsiz
        .databank ?

        lda wMapScrollXPixels,b
        cmp wMapMaxXScroll,b
        bcs +

          lda wCursorXOffset,b
          clc
          adc wMapScrollSpeed,b
          cmp #$00C1
          bcs ++

            sta wCursorXOffset,b
            lda #$0001
            tsb wMapCursorMoved,b
            rts

        +
        lda wCursorXOffset,b
        clc
        adc wMapScrollSpeed,b
        cmp #$00E1
        bcs _BD8C

          sta wCursorXOffset,b
          lda #$0001
          tsb wMapCursorMoved,b
          rts

        +
        lda wMapScrollXPixels,b
        clc
        adc wMapScrollSpeed,b
        cmp wMapMaxXScroll,b
        bcc +

          sec
          sbc wMapMaxXScroll,b
          sta $00
          lda #$00C0
          sec
          sbc wCursorXOffset,b
          clc
          adc wMapScrollCurrentPixelDistance,b
          sta wMapScrollCurrentPixelDistance,b

          lda $00
          clc
          adc #$00C0
          sta wCursorXOffset,b
          bra ++
        
        +
        lda #$00C0
        sec
        sbc wCursorXOffset,b
        clc
        adc wMapScrollCurrentPixelDistance,b
        sta wMapScrollCurrentPixelDistance,b
        lda #$00C0
        sta wCursorXOffset,b
        
        +
        lda #1
        sta wMapScrollingFlag,b
        sta wMapEnableXScrollFlag,b
        lda #$0001
        tsb wMapCursorMoved,b
        rts

        _BD8C
        lda #$00E0
        sec
        sbc wCursorXOffset,b
        clc
        adc wMapScrollCurrentPixelDistance,b
        sta wMapScrollCurrentPixelDistance,b
        lda #$00E0
        sta wCursorXOffset,b
        rts

        .databank 0

        ; 88/BDA1

    .endsection Unsorted88BC05Section


    .section Unsorted88BDA1Section

      .al
      .xl

      rsMoveMapCursorUp ; 88/BDA1

        .al
        .xl
        .autsiz
        .databank ?

        lda wMapScrollYPixels,b
        cmp wMapMinYScroll,b
        beq _BDBF
        lda wCursorYOffset,b
        sec
        sbc wMapScrollSpeed,b
        cmp #$0030
        bcc _BDE5
        sta wCursorYOffset,b
        lda #$0001
        tsb wMapCursorMoved,b
        rts


        _BDBF
        lda wCursorYOffset,b
        sec
        sbc wMapScrollSpeed,b
        cmp #$0010
        bcc _BE42
        sta wCursorYOffset,b
        lda #$0001
        tsb wMapCursorMoved,b
        rts

        .byte $A9, $01, $00, $8D, $3A, $07, $8D, $3E, $07, $A9, $01, $00, $0C, $64, $07, $60


        _BDE5
        lda wMapScrollYPixels,b
        sec
        sbc wMapScrollSpeed,b
        sec
        sbc #$0001
        cmp wMapMinYScroll,b
        bmi _BDF7
        bcs _BE1E

        _BDF7
        clc
        adc #$0001
        sta wR0
        lda wMapMinYScroll,b
        sec
        sbc wR0
        sta wR0
        lda wCursorYOffset,b
        sec
        sbc #$0030
        clc
        adc wMapScrollCurrentPixelDistance,b
        sta wMapScrollCurrentPixelDistance,b
        lda #$0030
        sec
        sbc wR0
        sta wCursorYOffset,b
        bra _BE32


        _BE1E
        lda wCursorYOffset,b
        sec
        sbc #$0030
        clc
        adc wMapScrollCurrentPixelDistance,b
        sta wMapScrollCurrentPixelDistance,b
        lda #$0030
        sta wCursorYOffset,b

        _BE32
        lda #$0001
        sta wMapScrollingFlag,b
        sta wMapEnableYScrollFlag,b
        lda #$0001
        tsb wMapCursorMoved,b
        rts


        _BE42
        lda wCursorYOffset,b
        sec
        sbc #$0010
        clc
        adc wMapScrollCurrentPixelDistance,b
        sta wMapScrollCurrentPixelDistance,b
        lda #$0010
        sta wCursorYOffset,b
        rts

        .databank 0

        ; 88/BE57

      rsMoveMapCursorDown ; 88/BE57

        .al
        .xl
        .autsiz
        .databank ?

        lda wMapScrollYPixels,b
        cmp wMapMaxYScroll,b
        bcs _BE75
        lda wCursorYOffset,b
        clc
        adc wMapScrollSpeed,b
        cmp #$00A1
        bcs _BE8B
        sta wCursorYOffset,b
        lda #$0001
        tsb wMapCursorMoved,b
        rts


        _BE75
        lda wCursorYOffset,b
        clc
        adc wMapScrollSpeed,b
        cmp #$00C1
        bcs _BEDA
        sta wCursorYOffset,b
        lda #$0001
        tsb wMapCursorMoved,b
        rts


        _BE8B
        lda wMapScrollYPixels,b
        clc
        adc wMapScrollSpeed,b
        cmp wMapMaxYScroll,b
        bcc _BEB6
        sec
        sbc wMapMaxYScroll,b
        sta wR0
        lda #$00A0
        sec
        sbc wCursorYOffset,b
        clc
        adc wMapScrollCurrentPixelDistance,b
        sta wMapScrollCurrentPixelDistance,b
        lda wR0
        clc
        adc #$00A0
        sta wCursorYOffset,b
        bra _BECA


        _BEB6
        lda #$00A0
        sec
        sbc wCursorYOffset,b
        clc
        adc wMapScrollCurrentPixelDistance,b
        sta wMapScrollCurrentPixelDistance,b
        lda #$00A0
        sta wCursorYOffset,b

        _BECA
        lda #$0001
        sta wMapScrollingFlag,b
        sta wMapEnableYScrollFlag,b
        lda #$0001
        tsb wMapCursorMoved,b
        rts


        _BEDA
        lda #$00C0
        sec
        sbc wCursorYOffset,b
        clc
        adc wMapScrollCurrentPixelDistance,b
        sta wMapScrollCurrentPixelDistance,b
        lda #$00C0
        sta wCursorYOffset,b
        rts

        .databank 0

        ; 88/BEEF

      rsPlayMapCursorMoveSound ; 88/BEEF

        .al
        .xl
        .autsiz
        .databank ?

        ; Sound $05 if the cursor moved this step.

        lda wMapCursorMoved,b
        bit #$0001
        beq _BEFE
        lda #$0005
        jsl rlPlaySoundEffect

        _BEFE
        rts

        .databank 0

        ; 88/BEFF

    .endsection Unsorted88BDA1Section


    .section Unreferenced88BEFFSection

      .al
      .xl

      rlComputeMapRowOffsetUnused ; 88/BEFF

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $88
        lda wMapWidthMode,b
        cmp #$0004
        beq _BF1D
        cmp #$0008
        beq _BF10

        _BF10
        lda wR1
        and #$FFF0
        asl a
        asl a
        asl a
        asl a
        sta wR3
        bra _BF29


        _BF1D
        lda wR1
        and #$FFF0
        asl a
        asl a
        asl a
        sta wR3
        bra _BF29


        _BF29
        lda wR0
        and #$FFF0
        lsr a
        lsr a
        lsr a
        clc
        adc wR3
        plp
        plb
        .databank $88
        rtl

        .databank 0

        ; 88/BF37

    .endsection Unreferenced88BEFFSection
