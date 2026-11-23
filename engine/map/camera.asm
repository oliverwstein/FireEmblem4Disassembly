; The map camera: converting between map tiles, map pixels and screen positions
; (rlGetMapDataIndex, rlGetTileScreenPixelPosition, rlGetTileAtScreenPosition),
; centring the camera on a location or the cursor (rlCenterCameraOnLocation,
; rlRestoreMapCamera, rlGetCameraCenteredOnTile), the event camera's target at
; $7F4BF5 (rlSetCameraTargetForCursor, rlStepCameraTowardsTarget), and L jumping
; between castles (rsJumpToNextCastle). Bank $88.
;
; wMapScrollXPixels/YPixels is the camera; wCursorXOffset/YOffset is the cursor
; on the screen. The cursor may move within 48 pixels of the screen edge (X
; $30-$C7, Y $28-$A7) before the map scrolls instead.


    .section Unsorted88BF37Section

      .al
      .xl

      rlGetMapDataIndex ; 88/BF37

        .al
        .xl
        .autsiz
        .databank ?

        ; A = the aMapData offset of tile (wR0, wR1); the row size depends on wMapWidthMode.

        phb
        php
        phk
        plb
        .databank $88
        lda wUnknown00075C,b
        cmp #$0004
        beq _BF56
        cmp #$0008
        beq _BF48

        _BF48
        lda wR1
        asl a
        asl a
        asl a
        asl a
        asl a
        asl a
        asl a
        asl a
        sta wR3
        bra _BF63


        _BF56
        lda wR1
        asl a
        asl a
        asl a
        asl a
        asl a
        asl a
        asl a
        sta wR3
        bra _BF63


        _BF63
        lda wR0
        asl a
        clc
        adc wR3
        plp
        plb
        .databank $88
        rtl

        .databank 0

        ; 88/BF6C

    .endsection Unsorted88BF37Section


    .section Unsorted88BF6CSection

      .al
      .xl

      rlGetTileScreenPosition ; 88/BF6C

        .al
        .xl
        .autsiz
        .databank ?

        ; Turns tile (wR10, wR11) into its screen position in 8-pixel units, or $FFFF in both if it is above or left of the screen.

        lda wR10
        asl a
        asl a
        asl a
        asl a
        sec
        sbc wMapScrollXPixels,b
        bmi _BF8F
        lsr a
        lsr a
        lsr a
        sta wR10
        lda wR11
        asl a
        asl a
        asl a
        asl a
        sec
        sbc wMapScrollYPixels,b
        bmi _BF8F
        lsr a
        lsr a
        lsr a
        sta wR11
        rtl


        _BF8F
        lda #$FFFF
        sta wR10
        sta wR11
        rtl

        .databank 0

        ; 88/BF97

    .endsection Unsorted88BF6CSection


    .section Unsorted88BF97Section

      .al
      .xl

      rlCheckPointInScreenMargins ; 88/BF97

        .al
        .xl
        .autsiz
        .databank ?

        ; Carry clear if (wCursorXOffset, wCursorYOffset) minus the camera is inside the area the cursor can move in without scrolling (X $30-$C7, Y $28-$A7); the offsets are left in wR10/wR11.

        lda wCursorXOffset,b
        sec
        sbc wMapScrollXPixels,b
        sta wR10
        cmp #$00C8
        bcs _BFC1
        sec
        sbc #$0030
        bmi _BFC1
        lda wCursorYOffset,b
        sec
        sbc wMapScrollYPixels,b
        sta wR11
        cmp #$00A8
        bcs _BFC1
        sec
        sbc #$0028
        bmi _BFC1
        clc
        rtl


        _BFC1
        sec
        rtl

        .databank 0

        ; 88/BFC3

      rlGetTileScreenPixelPosition ; 88/BFC3

        .al
        .xl
        .autsiz
        .databank ?

        ; Turns tile (wR10, wR11) into its screen position in pixels, or $FFFF in both if it is outside the area the cursor can move in without scrolling.

        lda wR10
        asl a
        asl a
        asl a
        asl a
        sec
        sbc wMapScrollXPixels,b
        sta wR10
        cmp #$00C8
        bcs _BFF2
        sec
        sbc #$0030
        bmi _BFF2
        lda wR11
        asl a
        asl a
        asl a
        asl a
        sec
        sbc wMapScrollYPixels,b
        sta wR11
        cmp #$00A8
        bcs _BFF2
        sec
        sbc #$0028
        bmi _BFF2
        rtl


        _BFF2
        lda #$FFFF
        sta wR10
        sta wR11
        rtl

        .databank 0

        ; 88/BFFA

    .endsection Unsorted88BF97Section


    .section Unsorted88BFFASection

      .al
      .xl

      rlGetTileScreenPixelPositionAtMapEdgeUnused ; 88/BFFA

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ; Nothing reaches this. Like rlGetTileScreenPixelPosition, but a tile near the screen edge counts as visible when the camera is at the map edge.

        lda wR10
        asl a
        asl a
        asl a
        asl a
        sec
        sbc wMapScrollXPixels,b
        sta wR10
        cmp #$00C8
        bcs _C03B
        sec
        sbc #$0030
        bmi _C031

        _C011
        lda wR11
        asl a
        asl a
        asl a
        asl a
        sec
        sbc wMapScrollYPixels,b
        sta wR11
        cmp #$00A8
        bcs _C04F
        sec
        sbc #$0028
        bmi _C045

        _C028
        rtl


        _C029
        lda #$FFFF
        sta wR10
        sta wR11
        rtl


        _C031
        lda wMapScrollXPixels,b
        cmp wMapMinXScroll,b
        beq _C011
        bra _C029


        _C03B
        lda wMapScrollXPixels,b
        cmp wMapMaxXScroll,b
        beq _C011
        bra _C029


        _C045
        lda wMapScrollYPixels,b
        cmp wMapMinYScroll,b
        beq _C028
        bra _C029


        _C04F
        lda wMapScrollYPixels,b
        cmp wMapMaxYScroll,b
        beq _C028
        bra _C029

        .databank 0

        ; 88/C059

    .endsection Unsorted88BFFASection


    .section Unsorted88C059Section

      .al
      .xl

      rlGetTileAtScreenPosition ; 88/C059

        .al
        .xl
        .autsiz
        .databank ?

        ; Turns screen position (wR10, wR11) into the map tile under it.

        lda wR10
        clc
        adc wMapScrollXPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR10
        lda wR11
        clc
        adc wMapScrollYPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR11
        rtl

        .databank 0

        ; 88/C072

    .endsection Unsorted88C059Section


    .section Unsorted88C072Section

      .al
      .xl

      rlGetCursorMapPositionUnused ; 88/C072

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ; Nothing reaches this. wR10/wR11 = the cursor's position on the map in pixels.

        lda wCursorXOffset,b
        clc
        adc wMapScrollXPixels,b
        sta wR10
        lda wCursorYOffset,b
        clc
        adc wMapScrollYPixels,b
        sta wR11
        rtl

        .databank 0

        ; 88/C085

    .endsection Unsorted88C072Section


    .section Unsorted88C1BFSection

      .al
      .xl

      rsJumpToNextCastle ; 88/C1BF

        .al
        .xl
        .autsiz
        .databank ?

        ; L on the map or minimap: centres the camera and cursor on the next castle (wCastleSubMenuStep counts through the locations); L and R together start again from the home castle.

        lda wJoy1Input
        cmp #$0030
        bne _C1D0
        lda #$0000
        jsl rlGetFactionSlotLocationID
        sta wCastleSubMenuStep,b

        _C1D0
        lda wCastleSubMenuStep,b
        jsl rlGetLocationEventDataEntry
        bcs _C247
        jsl rlGetEventLocationEntryType
        cmp #LocationTypeCastle
        bne _C24E
        jsl rlGetEventLocationEntryEffectiveXCoordinate
        asl a
        asl a
        asl a
        asl a
        sta wTempVariable1,b
        sec
        sbc #$0080
        bpl _C1F8
        lda #$0000
        bra _C200


        _C1F8
        cmp wMapMaxXScroll,b
        bcc _C200
        lda wMapMaxXScroll,b

        _C200
        sta wMapScrollXPixels,b
        jsl rlGetEventLocationEntryEffectiveYCoordinate
        asl a
        asl a
        asl a
        asl a
        sta wTempVariable2,b
        sec
        sbc #$0080
        bpl _C219
        lda #$0000
        bra _C221


        _C219
        cmp wMapMaxYScroll,b
        bcc _C221
        lda wMapMaxYScroll,b

        _C221
        sta wMapScrollYPixels,b
        lda wTempVariable1,b
        sec
        sbc wMapScrollXPixels,b
        sta wCursorXOffset,b
        lda wTempVariable2,b
        sec
        sbc wMapScrollYPixels,b
        sta wCursorYOffset,b
        jsl rlRedrawVisibleMapTilemap
        inc wCastleSubMenuStep,b
        lda #$8000
        tsb wMapSystemFlags,b
        bra _C255


        _C247
        stz wCastleSubMenuStep,b
        jml _C1D0


        _C24E
        inc wCastleSubMenuStep,b
        jml _C1D0


        _C255
        lda #$0026
        jsl rlPlaySoundEffect2
        rts

        .databank 0

        ; 88/C25D

    .endsection Unsorted88C1BFSection


    .section Unsorted88C25DSection

      .al
      .xl

      rlCenterCameraOnLocation ; 88/C25D

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Centres the camera (and wMapXOffset/wMapYOffset) on the location in wEventLocationEntry and puts the cursor on it.

        jsl rlGetEventLocationEntryEffectiveXCoordinate
        asl a
        asl a
        asl a
        asl a
        sta wTempVariable1,b
        sec
        sbc #$0080
        bpl _C273
        lda #$0000
        bra _C27B


        _C273
        cmp wMapMaxXScroll,b
        bcc _C27B
        lda wMapMaxXScroll,b

        _C27B
        sta wMapScrollXPixels,b
        sta wMapXOffset,b
        jsl rlGetEventLocationEntryEffectiveYCoordinate
        asl a
        asl a
        asl a
        asl a
        sta wTempVariable2,b
        sec
        sbc #$0080
        bpl _C297
        lda #$0000
        bra _C29F


        _C297
        cmp wMapMaxYScroll,b
        bcc _C29F
        lda wMapMaxYScroll,b

        _C29F
        sta wMapScrollYPixels,b
        sta wMapYOffset,b
        lda wTempVariable1,b
        sec
        sbc wMapScrollXPixels,b
        sta wCursorXOffset,b
        lda wTempVariable2,b
        sec
        sbc wMapScrollYPixels,b
        sta wCursorYOffset,b
        rtl

        .databank 0

        ; 88/C2BA

    .endsection Unsorted88C25DSection


    .section Unsorted88C2BASection

      .al
      .xl

      rlStepCameraTowardsTarget ; 88/C2BA

        .al
        .xl
        .autsiz
        .databank ?

        ; One scroll step (speed 4) towards the camera position at $7F4BF5/$7F4BF7; carry set when it is there.

        php
        phb
        lda #$0000
        sta wR2
        sta wR3
        lda #$0004
        sta wMapScrollSpeed,b
        lda $7F4BF5
        cmp wMapScrollXPixels,b
        beq _C2E2
        bcs _C2DB
        lda #$0001
        sta wR2
        bra _C2E2


        _C2DB
        lda #$FFFF
        sta wR2
        bra _C2E2


        _C2E2
        lda $7F4BF7
        cmp wMapScrollYPixels,b
        beq _C2FB
        bcs _C2F4
        lda #$0001
        sta wR3
        bra _C2FB


        _C2F4
        lda #$FFFF
        sta wR3
        bra _C2FB


        _C2FB
        lda wR2
        bne _C305
        lda wR3
        beq _C34D
        bra _C309


        _C305
        bpl _C30D
        bra _C327


        _C309
        bpl _C341
        bra _C347


        _C30D
        lda wR3
        beq _C315
        bpl _C31B
        bra _C321


        _C315
        jsl rlStartMapScrollLeft
        bra _C351


        _C31B
        jsl rlStartMapScrollUpLeft
        bra _C351


        _C321
        jsl rlStartMapScrollDownLeft
        bra _C351


        _C327
        lda wR3
        beq _C32F
        bpl _C335
        bra _C33B


        _C32F
        jsl rlStartMapScrollRight
        bra _C351


        _C335
        jsl rlStartMapScrollUpRight
        bra _C351


        _C33B
        jsl rlStartMapScrollDownRight
        bra _C351


        _C341
        jsl rlStartMapScrollUp
        bra _C351


        _C347
        jsl rlStartMapScrollDown
        bra _C351


        _C34D
        plb
        .databank ?
        plp
        sec
        rtl


        _C351
        plb
        .databank ?
        plp
        clc
        rtl

        .databank 0

        ; 88/C355

    .endsection Unsorted88C2BASection


    .section Unsorted88C355Section

      .al
      .xl

      rlSetCameraTargetForCursor ; 88/C355

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; If the cursor is outside the screen margins, sets the camera target ($7F4BF5/$7F4BF7) to centre it; else to $7F4BF9/$7F4BFB. Carry set if the camera has to move.

        lda wCursorXOffset,b
        sta wR10
        lda wCursorYOffset,b
        sta wR11
        jsl rlGetTileAtScreenPosition
        jsl rlGetTileScreenPixelPosition
        lda wR10
        cmp #$FFFF
        beq _C394
        lda $7F4BF9
        cmp wMapScrollXPixels,b
        bne _C382
        lda $7F4BFB
        cmp wMapScrollYPixels,b
        bne _C382
        clc
        rtl


        _C382
        lda $7F4BF9
        sta $7F4BF5
        lda $7F4BFB
        sta $7F4BF7
        sec
        rtl


        _C394
        lda wCursorXOffset,b
        clc
        adc $7F4BF9
        sta wTempVariable1,b
        sec
        sbc #$0080
        bpl _C3AA
        lda #$0000
        bra _C3B2


        _C3AA
        cmp wMapMaxXScroll,b
        bcc _C3B2
        lda wMapMaxXScroll,b

        _C3B2
        sta $7F4BF5
        lda wCursorYOffset,b
        clc
        adc $7F4BFB
        sta wTempVariable2,b
        sec
        sbc #$0080
        bpl _C3CC
        lda #$0000
        bra _C3D4


        _C3CC
        cmp wMapMaxYScroll,b
        bcc _C3D4
        lda wMapMaxYScroll,b

        _C3D4
        sta $7F4BF7
        lda wTempVariable1,b
        sec
        sbc $7F4BF5
        sta wCursorXOffset,b
        lda wTempVariable2,b
        sec
        sbc $7F4BF7
        sta wCursorYOffset,b
        sec
        rtl

        .databank 0

        ; 88/C3F0

    .endsection Unsorted88C355Section


    .section Unsorted88C3F0Section

      .al
      .xl

      rlRestoreMapCamera ; 88/C3F0

        .al
        .xl
        .autsiz
        .databank ?

        ; Puts the camera back at wMapXOffset/wMapYOffset; if the cursor would be outside the screen margins, centres the camera on it instead. Carry set if it moved.

        lda wMapXOffset,b
        sta wMapScrollXPixels,b
        lda wMapYOffset,b
        sta wMapScrollYPixels,b
        lda wCursorXOffset,b
        sta wR10
        lda wCursorYOffset,b
        sta wR11
        jsl rlGetTileAtScreenPosition
        jsl rlGetTileScreenPixelPosition
        lda wR10
        cmp #$FFFF
        beq _C417
        clc
        rtl


        _C417
        lda wCursorXOffset,b
        clc
        adc wMapScrollXPixels,b
        sta wTempVariable1,b
        sec
        sbc #$0080
        bpl _C42C
        lda #$0000
        bra _C434


        _C42C
        cmp wMapMaxXScroll,b
        bcc _C434
        lda wMapMaxXScroll,b

        _C434
        sta wMapScrollXPixels,b
        sta wMapXOffset,b
        lda wCursorYOffset,b
        clc
        adc wMapScrollYPixels,b
        sta wTempVariable2,b
        sec
        sbc #$0080
        bpl _C44F
        lda #$0000
        bra _C457


        _C44F
        cmp wMapMaxYScroll,b
        bcc _C457
        lda wMapMaxYScroll,b

        _C457
        sta wMapScrollYPixels,b
        sta wMapYOffset,b
        lda wTempVariable1,b
        sec
        sbc wMapScrollXPixels,b
        sta wCursorXOffset,b
        lda wTempVariable2,b
        sec
        sbc wMapScrollYPixels,b
        sta wCursorYOffset,b
        sec
        rtl

        .databank 0

        ; 88/C473

      rlGetCameraCenteredOnTile ; 88/C473

        .al
        .xl
        .autsiz
        .databank ?

        ; wR0/wR1 = the camera position (in tiles) that centres tile (wR0, wR1), clamped to the map, and the cursor offsets for it.

        lda wR0
        asl a
        asl a
        asl a
        asl a
        sta wTempVariable1,b
        lda wR1
        asl a
        asl a
        asl a
        asl a
        sta wTempVariable2,b
        lda wTempVariable1,b
        sec
        sbc #$0080
        bpl _C493
        lda #$0000
        bra _C49B


        _C493
        cmp wMapMaxXScroll,b
        bcc _C49B
        lda wMapMaxXScroll,b

        _C49B
        sta wR0
        lda wTempVariable2,b
        sec
        sbc #$0080
        bpl _C4AB
        lda #$0000
        bra _C4B3


        _C4AB
        cmp wMapMaxYScroll,b
        bcc _C4B3
        lda wMapMaxYScroll,b

        _C4B3
        sta wR1
        lda wTempVariable1,b
        sec
        sbc wR0
        sta wCursorXOffset,b
        lda wTempVariable2,b
        sec
        sbc wR1
        sta wCursorYOffset,b
        lda wR0
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR0
        lda wR1
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR1
        sec
        rtl

        .databank 0

        ; 88/C4D9

    .endsection Unsorted88C3F0Section


