; Code from bank $88 not yet assigned to a game system.


    .section Unsorted88818ASection

      .al
      .xl

      rlClearMapRAM ; 88/818A

        .al
        .xl
        .autsiz
        .databank ?

        ; Clears the map engine's RAM from wMenuState ($000592) to $000ADD. Called when a save is loaded and when a new game starts.

        ldx #$054A
        lda #$0000

        _8190
        sta wMenuState,b,x
        dec x
        bpl _8190
        rtl

        .databank 0

        ; 88/8197

    .endsection Unsorted88818ASection


    .section Unsorted888197Section

      .al
      .xl

      rlLoadCursorSpriteGraphics ; 88/8197

        .al
        .xl
        .autsiz
        .databank ?

        ; Copies g4bppCursorSprites to VRAM.

        phx
        jsl rlDMAByStruct

          .structDMAToVRAM g4bppCursorSprites, $0400, $80, $C000

        plx
        rtl

        .databank 0

        ; 88/81A7

      rlLoadMapSpriteOAMPalettes ; 88/81A7

        .al
        .xl
        .autsiz
        .databank ?

        ; Copies aMapAndCastleSpriteOAMPalettes into the first OAM palettes of aOAMPaletteBuffer.

        phx
        ldx #$001E

        _81AB
        lda aMapAndCastleSpriteOAMPalettes,x
        sta aOAMPaletteBuffer,b,x
        dec x
        dec x
        bpl _81AB
        plx
        rtl

        .databank 0

        ; 88/81B8

    .endsection Unsorted888197Section


    .section Unsorted8881D7Section

      .al
      .xl

      rlSetMapReturnCenterOnUnit ; 88/81D7

        .al
        .xl
        .autsiz
        .databank ?

        ; Sets MAP_RETURN_CENTER_ON_UNIT: back on the map, the cursor travels to the active unit.

        lda #$0001
        tsb wMapOverlayFlags,b
        rtl

        .databank 0

        ; 88/81DE

    .endsection Unsorted8881D7Section


    .section Unsorted8881DESection

      .al
      .xl

      rlSetMapReturnStartCastleStaff ; 88/81DE

        .al
        .xl
        .autsiz
        .databank ?

        ; Sets MAP_RETURN_START_CASTLE_STAFF: back on the map, the active unit's staff target selection starts.

        lda #$0002
        tsb wMapOverlayFlags,b
        rtl

        .databank 0

        ; 88/81E5

    .endsection Unsorted8881DESection


    .section Unsorted8881E5Section

      .al
      .xl

      rlSetMapReturnCastleGridStaff ; 88/81E5

        .al
        .xl
        .autsiz
        .databank ?

        ; Sets MAP_RETURN_CASTLE_GRID_STAFF: the staff was chosen from the castle grid, so finishing or cancelling the target selection goes back to the castle screen.

        lda #$0008
        tsb wMapOverlayFlags,b
        rtl

        .databank 0

        ; 88/81EC

    .endsection Unsorted8881E5Section


    .section Unsorted8881ECSection

      .al
      .xl

      rlClearVRAM6000 ; 88/81EC

        .al
        .xl
        .autsiz
        .databank ?

        ; Fills $4000 bytes of VRAM from word $6000 with the zero byte at 88/8219 (a fixed-source DMA).

        phk
        plb
        .databank $88
        rep #$30
        lda #$1809
        sta $4300,b
        lda #$8800
        sta $4303,b
        lda #$8219
        sta $4302,b
        lda #$4000
        sta $4305,b
        lda #$6000
        sta $2116,b
        sep #$20
        lda #$01
        sta $420B,b
        rep #$20
        rtl

        .databank 0

        ; 88/8218

    .endsection Unsorted8881ECSection


    .section Unsorted888410Section

      .al
      .xl

      rlRedrawVisibleMapTilemap ; 88/8410

        .al
        .autsiz
        .databank ?

        ; Rebuilds every row of the visible map (wMapScrollXPixels, wMapScrollYPixels) into aBG2TilemapBuffer, bottom to top, and copies it to VRAM. Used after map tiles change (map change events, a location taken over).

        lda #1
        sta wMapEnableXScrollFlag,b
        sta wMapEnableYScrollFlag,b

        lda wMapScrollXPixels,b
        sta wUnknown000734,b
        lda wMapScrollYPixels,b
        sta wUnknown000736,b
        clc
        adc #$0100
        sta wMapScrollYPixels,b
        lda #8
        sta wMapScrollSpeed,b

        stz wUnknown00072C,b
        stz wUnknown00072E,b

        lda wUnknown000736,b
        and #$00F8
        asl a
        asl a
        asl a
        clc
        adc #$07C0
        and #$07FF
        sta $0724,b
        
          -
          jsr rsMapScrollUpSetBGOFS
          jsl rlBuildMapTopRow
          jsr rsCopyMapRowToTilemapBuffer

          lda wUnknown000736,b
          cmp wMapScrollYPixels,b
          bcc -

        jsl rlDMAByStruct
          .structDMAToVRAM $7E7388, $0800, $80, $A000

        lda wUnknown000734,b
        sta wMapScrollXPixels,b
        lda wUnknown000736,b
        sta wMapScrollYPixels,b

        stz wMapEnableXScrollFlag,b
        stz wMapEnableYScrollFlag,b
        rtl

        .databank 0

        ; 88/847D

    .endsection Unsorted888410Section


    .section Unsorted88847DSection

      .al
      .xl

      rsCopyMapRowToTilemapBuffer ; 88/847D

        .al
        .xl
        .autsiz
        .databank ?

        ; Copies the row built in $05DC into aBG2TilemapBuffer at $0724 and moves $0724 up one row (wrapping at the top).

        ldx $0724,b
        ldy #$0000

        _8483
        lda $05DC,b,y
        sta aBG2TilemapBuffer,x
        inc x
        inc x
        inc y
        inc y
        cpy #$0040
        bcc _8483
        lda $0724,b
        sec
        sbc #$0040
        sta $0724,b
        bpl _84A5
        lda #$07C0
        sta $0724,b

        _84A5
        rts

        .databank 0

        ; 88/84A6

      rlRedrawRangeOverlayTilemap ; 88/84A6

        .al
        .xl
        .autsiz
        .databank ?

        ; Rebuilds every row of the range overlay (BG3, built from aMovementMap) into aBG3TilemapBuffer, bottom to top, and marks the rows for upload.

        lda #$0001
        sta wMapEnableXScrollFlag,b
        sta wMapEnableYScrollFlag,b
        lda wMapScrollXPixels,b
        sta wUnknown000734,b
        lda wMapScrollYPixels,b
        sta wUnknown000736,b
        clc
        adc #$0100
        sta wMapScrollYPixels,b
        lda #$0008
        sta wMapScrollSpeed,b
        lda wUnknown000736,b
        and #$00F8
        asl a
        asl a
        asl a
        clc
        adc #$07C0
        and #$07FF
        sta $0724,b

        _84DB
        jsr rsMapScrollUpSetBGOFS
        jsl rlBuildRangeOverlayRowIntoTilemap
        lda wUnknown000736,b
        cmp wMapScrollYPixels,b
        bcc _84DB
        jsl rlMarkAllMapMenuRowsDirty
        lda wUnknown000734,b
        sta wMapScrollXPixels,b
        sta wBufferBG3HOFS
        lda wUnknown000736,b
        sta wMapScrollYPixels,b
        sta wBufferBG3VOFS
        stz wMapEnableXScrollFlag,b
        stz wMapEnableYScrollFlag,b
        rtl

        .databank 0

        ; 88/8505

      rlBuildRangeOverlayRowIntoTilemap ; 88/8505

        .al
        .xl
        .autsiz
        .databank ?

        ; Builds one range overlay row into $06DC and copies it into aBG3TilemapBuffer at $0724, moving $0724 up one row.

        stz wR2
        lda wMapScrollYPixels,b
        and #$0008
        beq _8514
        lda #$0002
        sta wR2

        _8514
        jsr rsGetMapTopRowIndex
        lda wR3
        sec
        sbc #$0000
        tax
        stz wUnknown00072A,b
        lda wMapScrollXPixels,b
        and #$0008
        bne _8531
        lda #$0000
        jsr rsBuildRangeOverlayRow
        bra _8537


        _8531
        lda #$0000
        jsr rsBuildRangeOverlayRowHalfOffset

        _8537
        ldx $0724,b
        ldy #$0000

        _853D
        lda $06DC,b,y
        sta aBG3TilemapBuffer,x
        inc x
        inc x
        inc y
        inc y
        cpy #$0040
        bcc _853D
        lda $0724,b
        sec
        sbc #$0040
        sta $0724,b
        bpl _855F
        lda #$07C0
        sta $0724,b

        _855F
        rtl

        .databank 0

        ; 88/8560

    .endsection Unsorted88847DSection


    .section Unsorted888560Section

      .al
      .xl

      rlContinueMapScroll ; 88/8560

        .al
        .autsiz
        .databank ?

        ; Each frame while wMapScrollingFlag is set: scrolls one more step in wMapScrollDirectionIdentifier and, unless the minimap is open, keeps wMapXOffset/wMapYOffset with the scroll.

        lda wUnknown00073A,b
        beq +

          jsl rlMapScrollStepInDirection

          lda wMapSystemFlags,b
          bit #$0020
          bne +

            lda wMapScrollXPixels,b
            sta wMapXOffset,b
            lda wMapScrollYPixels,b
            sta wMapYOffset,b

        +
        rtl

        .databank 0

        ; 88/857E

    .endsection Unsorted888560Section


    .section Unsorted8885D3Section

      .al
      .xl

      rlStartMapScrollUp ; 88/85D3

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0001
        sta wUnknown00073A,b
        sta wMapEnableYScrollFlag,b
        jsl rlMapScrollStepUp
        rtl

        .databank 0

        ; 88/85E1

      rlStartMapScrollDown ; 88/85E1

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0001
        sta wUnknown00073A,b
        sta wMapEnableYScrollFlag,b
        jsl rlMapScrollStepDown
        rtl

        .databank 0

        ; 88/85EF

    .endsection Unsorted8885D3Section


    .section Unsorted8885EFSection

      .al
      .xl

      rlStartMapScrollLeft ; 88/85EF

        .al
        .autsiz
        .databank ?

        lda #1
        sta wUnknown00073A,b
        sta wMapEnableXScrollFlag,b

        jsl rlMapScrollStepLeft
        rtl

        .databank 0

      rlStartMapScrollRight ; 88/85FD
      
        .al
        .autsiz
        .databank ?

        lda #1
        sta wUnknown00073A,b
        sta wMapEnableXScrollFlag,b

        jsl rlMapScrollStepRight
        rtl

        .databank 0

    .endsection Unsorted8885EFSection


    .section Unsorted88860BSection

      .al
      .xl

      rlStartMapScrollUpLeft ; 88/860B

        .al
        .autsiz
        .databank ?

        lda #1
        sta wUnknown00073A,b
        sta wMapEnableXScrollFlag,b
        sta wMapEnableYScrollFlag,b

        jsl rlMapScrollStepUpLeft
        rtl

        .databank 0

    .endsection Unsorted88860BSection


    .section Unsorted88861CSection

      .al
      .xl

      rlStartMapScrollDownLeft ; 88/861C

        .al
        .autsiz
        .databank ?

        lda #1
        sta wUnknown00073A,b
        sta wMapEnableXScrollFlag,b
        sta wMapEnableYScrollFlag,b

        jsl rlMapScrollStepDownLeft
        rtl

        .databank 0

      rlStartMapScrollUpRight ; 88/862D

        .al
        .autsiz
        .databank ?

        lda #1
        sta wUnknown00073A,b
        sta wMapEnableXScrollFlag,b
        sta wMapEnableYScrollFlag,b

        jsl rlMapScrollStepUpRight
        rtl

        .databank 0

      rlStartMapScrollDownRight ; 88/863E

        .al
        .autsiz
        .databank ?

        lda #1
        sta wUnknown00073A,b
        sta wMapEnableXScrollFlag,b
        sta wMapEnableYScrollFlag,b

        jsl rlMapScrollStepDownRight
        rtl

        .databank 0

      rlMapScrollStepInDirection ; 88/864F
      
        .al
        .autsiz
        .databank ?

        ; One scroll step in wMapScrollDirectionIdentifier (the JOY_ direction bits: $0100 right, $0200 left, $0400 down, $0800 up and their diagonals).

        lda wMapScrollDirectionIdentifier,b
        cmp #$0200
        beq _867B

        cmp #$0100
        beq _8680

        cmp #$0800
        beq _8685

        cmp #$0400
        beq _868A

        cmp #$0A00
        beq _868F

        cmp #$0600
        beq _8694

        cmp #$0900
        beq _8699

        cmp #$0500
        beq _869E

        rtl

        _867B
        jsl rlMapScrollStepLeft
        rtl
        
        _8680
        jsl rlMapScrollStepRight
        rtl
        
        _8685
        jsl rlMapScrollStepUp
        rtl
        
        _868A
        jsl rlMapScrollStepDown
        rtl
        
        _868F
        jsl rlMapScrollStepUpLeft
        rtl
        
        _8694
        jsl rlMapScrollStepDownLeft
        rtl
        
        _8699
        jsl rlMapScrollStepUpRight
        rtl
        
        _869E
        jsl rlMapScrollStepDownRight
        rtl

        .databank 0

      rlMapScrollStepLeft ; 88/86A3

        .al
        .autsiz
        .databank ?

        ; Moves the camera left by wMapScrollSpeed and builds the new left column.

        jsr rsMapScrollLeftSetBGOFS
        jsl rlQueueMapLeftColumnUpload
        rtl

        .databank 0

      rlMapScrollStepRight ; 88/86AB

        .al
        .autsiz
        .databank ?

        jsr rsMapScrollRightSetBGOFS
        jsl rlQueueMapRightColumnUpload
        rtl

        .databank 0

      rlMapScrollStepUp ; 88/86B3

        .al
        .autsiz
        .databank ?

        jsr rsMapScrollUpSetBGOFS
        jsl rlQueueMapTopRowUpload
        rtl

        .databank 0

      rlMapScrollStepDown ; 88/86BB

        .al
        .autsiz
        .databank ?

        jsr rsMapScrollDownSetBGOFS
        jsl rlQueueMapBottomRowUpload
        rtl

        .databank 0

      rlMapScrollStepUpLeft ; 88/86C3

        .al
        .autsiz
        .databank ?

        jsr rsMapScrollLeftSetBGOFS
        jsr rsMapScrollUpSetBGOFS
        jsl rlQueueMapLeftColumnUpload
        jsl rlQueueMapTopRowUpload
        rtl

        .databank 0

      rlMapScrollStepUpRight ; 88/86D2

        .al
        .autsiz
        .databank ?

        jsr rsMapScrollRightSetBGOFS
        jsr rsMapScrollUpSetBGOFS
        jsl rlQueueMapRightColumnUpload
        jsl rlQueueMapTopRowUpload
        rtl

        .databank 0

      rlMapScrollStepDownLeft ; 88/86E1

        .al
        .autsiz
        .databank ?

        jsr rsMapScrollLeftSetBGOFS
        jsr rsMapScrollDownSetBGOFS
        jsl rlQueueMapLeftColumnUpload
        jsl rlQueueMapBottomRowUpload
        rtl

        .databank 0

      rlMapScrollStepDownRight ; 88/86F0
      
        .al
        .autsiz
        .databank ?

        jsr rsMapScrollRightSetBGOFS
        jsr rsMapScrollDownSetBGOFS
        jsl rlQueueMapRightColumnUpload
        jsl rlQueueMapBottomRowUpload
        rtl

        .databank 0

    .endsection Unsorted88861CSection


    .section Unsorted888901Section

      .al
      .xl

      rsGetMapBottomRowIndex ; 88/8901

        .al
        .autsiz
        .databank ?

        ; Adds 14 rows (the screen height in map tiles) to the aMapData index in wR3; the row size depends on wMapWidthMode.

        lda wUnknown00075C,b
        cmp #4
        beq ++

          cmp #8
          beq +

          +
          lda wR3
          clc
          adc #$0E00
          rts

        +
        lda wR3
        clc
        adc #$0700
        rts

        .databank 0

      rsBuildMapBottomRow ; 88/891C

        .al
        .autsiz
        .databank ?

        stz wR2
        lda wMapScrollYPixels,b
        and #$0008
        beq +

          lda #2
          sta wR2

        +
        jsr rsGetMapTopRowIndex
        jsr rsGetMapBottomRowIndex
        tax
        stz wUnknown00072A,b
        
        lda wMapScrollXPixels,b
        and #$0008
        bne +

          jsr rsBuildMapRowTiles

          lda wUnknown000770,b
          beq _End

            lda #$00E0
            jsr rsBuildRangeOverlayRow
            bra _End

        +
        jsr rsBuildMapRowTilesHalfOffset

        lda wUnknown000770,b
        beq _End

          lda #$00E0
          jsr rsBuildRangeOverlayRowHalfOffset

        _End
        rts

        .databank 0

      rsBuildMapTopRow ; 88/895C

        .al
        .autsiz
        .databank ?

        stz $04
        lda wMapScrollYPixels,b
        and #$0008
        beq +

          lda #2
          sta $04

        +
        jsr rsGetMapTopRowIndex

        lda $06
        sec
        sbc #0
        tax

        stz wUnknown00072A,b

        lda wMapScrollXPixels,b
        and #$0008
        bne +

          jsr rsBuildMapRowTiles

          lda wUnknown000770,b
          beq _End

            lda #0
            jsr rsBuildRangeOverlayRow
            bra _End

        +
        jsr rsBuildMapRowTilesHalfOffset

        lda wUnknown000770,b
        beq _End

          lda #0
          jsr rsBuildRangeOverlayRowHalfOffset

        _End
        rts

        .databank 0

      rsBuildMapRowTiles ; 88/899F

        .al
        .autsiz
        .databank ?

        ; Builds a row of 8x8 tilemap entries from the map tiles in aMapData (each tile is four entries at $7F0000), for a camera X on a tile boundary. wR2 picks the top or bottom half of the tiles. With bit 1 of wUnknown00075A it also builds a second row at $065C from $7F6400.

        _Loop
        lda aMapData,x
        and wUnknown000596,b
        asl a
        asl a
        asl a
        clc
        adc wR2
        phx
        tax

        lda $7F0000,x
        and #$DFFF
        sta $05DC,b,y
        lda $7F0004,x
        and #$DFFF
        sta $05DE,b,y

        plx
        lda wUnknown00075A,b
        bit #$0002
        beq +

          lda $7F6400,x
          and #$03FF
          asl a
          asl a
          asl a
          clc
          adc wR2
          phx
          tax

          lda $7F0000,x
          and #$DFFF
          ora #$2000
          sta $065C,b,y
          lda $7F0004,x
          and #$DFFF
          ora #$2000
          sta $065E,b,y

          plx
        
        +
        inc y
        inc y
        inc y
        inc y
        inx
        inc x
        
        -
        lda wUnknown00072A,b
        beq +

          cpy wR8
          bcs _End
          bra _Loop

        +
        cpy #64
        bcc _Loop

          inc wUnknown00072A,b
          ldy #0
          bra -

        _End
        rts

        .databank 0

        ; 88/8A14

    .endsection Unsorted888901Section


    .section Unsorted888A14Section

      .al
      .xl

      rsBuildRangeOverlayRow ; 88/8A14

        .al
        .xl
        .autsiz
        .databank ?

        ; Builds a row of the range overlay into $06DC from aMovementMap, inside the window wMovementMapWindowLeft-Bottom; tiles outside it are blank ($FF).

        clc
        adc wMapScrollYPixels,b
        sta $0792,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wTempVariable2,b
        lda wMapScrollYPixels,b
        sta wBufferBG3VOFS
        lda wMapScrollXPixels,b
        sta wBufferBG3HOFS
        lsr a
        lsr a
        lsr a
        lsr a
        sta wTempVariable1,b
        jsr rsGetMovementMapRowIndex
        stz wUnknown00072A,b
        ldy wR8

        _8A3B
        lda wTempVariable2,b
        cmp $071E,b
        bcc _8A66
        cmp $0722,b
        bcs _8A66
        lda wTempVariable1,b
        cmp $071C,b
        bcc _8A66
        cmp $0720,b
        bcs _8A66
        jsr rsGetMovementMapIndexInRow
        lda aMovementMap,x
        and #$00FF
        beq _8A66
        jsr rsPutRangeOverlayRowTiles
        bra _8A6F


        _8A66
        lda #$00FF
        sta $06DC,b,y
        sta $06DE,b,y

        _8A6F
        inc wTempVariable1,b
        inc y
        inc y
        inc y
        inc y

        _8A76
        lda wUnknown00072A,b
        beq _8A81
        cpy wR8
        bcs _8A92
        bra _8A3B


        _8A81
        cpy #$0040
        bcc _8A8E
        inc wUnknown00072A,b
        ldy #$0000
        bra _8A76


        _8A8E
        jml _8A3B


        _8A92
        rts

        .databank 0

        ; 88/8A93

      rsPutRangeOverlayRowTiles ; 88/8A93

        .al
        .xl
        .autsiz
        .databank ?

        ; Puts the two tiles of one range overlay square: palette 2 for a square the unit can move to, palette 1 for a movement value with bit 7 set, palette 3 for $80 alone (reachable only by attack).

        bit #$0080
        beq _8A9C
        jml rsPutRangeOverlayRowLeftTile._8AFC


        _8A9C
        lda $0792,b
        and #$0008
        bne _8AB1
        lda #$284E
        sta $06DC,b,y
        lda #$284F
        sta $06DE,b,y
        rts


        _8AB1
        lda #$285E
        sta $06DC,b,y
        lda #$285F
        sta $06DE,b,y
        rts

        .databank 0

        ; 88/8ABE

      rsPutRangeOverlayRowRightTile ; 88/8ABE

        .al
        .xl
        .autsiz
        .databank ?

        bit #$0080
        beq _8AC7
        jml rsPutRangeOverlayRowLeftTile._8B27


        _8AC7
        lda $0792,b
        and #$0008
        bne _8AD6
        lda #$284F
        sta $06DC,b,y
        rts


        _8AD6
        lda #$285F
        sta $06DC,b,y
        rts

        .databank 0

        ; 88/8ADD

      rsPutRangeOverlayRowLeftTile ; 88/8ADD

        .al
        .xl
        .autsiz
        .databank ?

        bit #$0080
        beq _8AE6
        jml _8B46


        _8AE6
        lda $0792,b
        and #$0008
        bne _8AF5
        lda #$284E
        sta $06DC,b,y
        rts


        _8AF5
        lda #$285E
        sta $06DC,b,y
        rts

        _8AFC
        cmp #$0080
        bne _8B05
        jml _8B65


        _8B05
        lda $0792,b
        and #$0008
        bne _8B1A
        lda #$244E
        sta $06DC,b,y
        lda #$244F
        sta $06DE,b,y
        rts


        _8B1A
        lda #$245E
        sta $06DC,b,y
        lda #$245F
        sta $06DE,b,y
        rts

        _8B27
        cmp #$0080
        bne _8B30
        jml rsPutRangeOverlayRowRightAttackTile


        _8B30
        lda $0792,b
        and #$0008
        bne _8B3F
        lda #$244F
        sta $06DC,b,y
        rts


        _8B3F
        lda #$245F
        sta $06DC,b,y
        rts


        _8B46
        cmp #$0080
        bne _8B4F
        jml rsPutRangeOverlayRowLeftAttackTile


        _8B4F
        lda $0792,b
        and #$0008
        bne _8B5E
        lda #$244E
        sta $06DC,b,y
        rts


        _8B5E
        lda #$245E
        sta $06DC,b,y
        rts


        _8B65
        lda $0792,b
        and #$0008
        bne _8B7A
        lda #$2C4E
        sta $06DC,b,y
        lda #$2C4F
        sta $06DE,b,y
        rts


        _8B7A
        lda #$2C5E
        sta $06DC,b,y
        lda #$2C5F
        sta $06DE,b,y
        rts

        .databank 0

        ; 88/8B87

      rsPutRangeOverlayRowRightAttackTile ; 88/8B87

        .al
        .xl
        .autsiz
        .databank ?

        lda $0792,b
        and #$0008
        bne _8B96
        lda #$2C4F
        sta $06DC,b,y
        rts


        _8B96
        lda #$2C5F
        sta $06DC,b,y
        rts

        .databank 0

        ; 88/8B9D

      rsPutRangeOverlayRowLeftAttackTile ; 88/8B9D

        .al
        .xl
        .autsiz
        .databank ?

        lda $0792,b
        and #$0008
        bne _8BAC
        lda #$2C4E
        sta $06DC,b,y
        rts


        _8BAC
        lda #$2C5E
        sta $06DC,b,y
        rts

        .databank 0

        ; 88/8BB3

    .endsection Unsorted888A14Section


    .section Unsorted888BB3Section

      .al
      .xl

      rsBuildMapRowTilesHalfOffset ; 88/8BB3

        .al
        .autsiz
        .databank ?

        ; Like rsBuildMapRowTiles for a camera X halfway into a tile: each tile's right half comes first.

        ; Grabs the next row of map tiles when scrolling down?

        _Loop
        lda aMapData,x
        and wUnknown000596,b
        asl a
        asl a
        asl a
        clc
        adc wR2
        phx
        tax
        lda $7F0004,x
        and #$DFFF
        sta $05DC,b,y
        plx

        lda wUnknown00075A,b
        bit #$0002
        beq +

          lda $7F6400,x
          and #$03FF
          asl a
          asl a
          asl a
          clc
          adc wR2
          phx
          tax
          lda $7F0004,x
          and #$DFFF
          ora #$2000
          sta $065C,b,y
          plx

        +
        inc x
        inc x
        inc y
        inc y
        cpy #64
        bcc +

          inc wUnknown00072A,b
          ldy #0

        +
        lda aMapData,x
        and wUnknown000596,b
        asl a
        asl a
        asl a
        clc
        adc wR2
        phx
        tax
        lda $7F0000,x
        and #$DFFF
        sta $05DC,b,y
        plx

        lda wUnknown00075A,b
        bit #$0002
        beq +

          lda $7F6400,x
          and #$03FF
          asl a
          asl a
          asl a
          clc
          adc wR2
          phx
          tax
          lda $7F0000,x
          and #$DFFF
          ora #$2000
          sta $065C,b,y
          plx

        +
        inc y
        inc y
        
        -
        lda wUnknown00072A,b
        beq +

          cpy wR8
          bcs _End
          bra _8C5B

        +
        cpy #64
        bcc _8C5B

          inc wUnknown00072A,b
          ldy #0
          bra -

        _End
        rts
        
        _8C5B
        jml _Loop

        .databank 0

        ; 88/8C5F

    .endsection Unsorted888BB3Section


    .section Unsorted888C5FSection

      .al
      .xl

      rsBuildRangeOverlayRowHalfOffset ; 88/8C5F

        .al
        .xl
        .autsiz
        .databank ?

        clc
        adc wMapScrollYPixels,b
        sta $0792,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wTempVariable2,b
        lda wMapScrollYPixels,b
        sta wBufferBG3VOFS
        lda wMapScrollXPixels,b
        sta wBufferBG3HOFS
        lsr a
        lsr a
        lsr a
        lsr a
        sta wTempVariable1,b
        jsr rsGetMovementMapRowIndex
        stz wR9
        stz wUnknown00072A,b
        ldy wR8

        _8C88
        lda wTempVariable2,b
        cmp $071E,b
        bcc _8CD2
        cmp $0722,b
        bcs _8CD2
        lda wTempVariable1,b
        cmp $071C,b
        bcc _8CD2
        cmp $0720,b
        bcs _8CD2
        jsr rsGetMovementMapIndexInRow
        lda aMovementMap,x
        and #$00FF
        beq _8CED
        jsr rsPutRangeOverlayRowRightTile

        _8CB1
        inc wTempVariable1,b
        inc y
        inc y
        cpy #$0040
        bcc _8CC1
        inc wUnknown00072A,b
        ldy #$0000

        _8CC1
        jsr rsGetMovementMapIndexInRow
        lda aMovementMap,x
        and #$00FF
        beq _8CF5
        jsr rsPutRangeOverlayRowLeftTile
        bra _8CFB


        _8CD2
        inc wTempVariable1,b
        lda #$00FF
        sta $06DC,b,y
        inc y
        inc y
        cpy #$0040
        bcc _8CE8
        inc wUnknown00072A,b
        ldy #$0000

        _8CE8
        sta $06DC,b,y
        bra _8CFB


        _8CED
        lda #$00FF
        sta $06DC,b,y
        bra _8CB1


        _8CF5
        lda #$00FF
        sta $06DC,b,y

        _8CFB
        inc y
        inc y

        _8CFD
        inc wR9
        lda wR9
        cmp #$0010
        bcs _8D22
        lda wUnknown00072A,b
        beq _8D11
        cpy wR8
        bcs _8D22
        bra _8D1E


        _8D11
        cpy #$0040
        bcc _8D1E
        inc wUnknown00072A,b
        ldy #$0000
        bra _8CFD


        _8D1E
        jml _8C88


        _8D22
        rts

        .databank 0

        ; 88/8D23

      rsGetMovementMapRowIndex ; 88/8D23

        .al
        .xl
        .autsiz
        .databank ?

        ; X = the aMovementMap index of tile (wTempVariable1, wTempVariable2); also keeps the row part in wUnknown000790.

        lda wTempVariable1,b
        sec
        sbc $0720,b
        and #$003F
        sta wR0
        lda wTempVariable2,b
        sec
        sbc $0722,b
        and #$003F
        asl a
        asl a
        asl a
        asl a
        asl a
        asl a
        sta wUnknown000790,b
        clc
        adc wR0
        tax
        rts

        .databank 0

        ; 88/8D47

      rsGetMovementMapIndexInRow ; 88/8D47

        .al
        .xl
        .autsiz
        .databank ?

        ; X = the aMovementMap index of column wTempVariable1 in the row kept by rsGetMovementMapRowIndex.

        lda wTempVariable1,b
        sec
        sbc $0720,b
        and #$003F
        clc
        adc wUnknown000790,b
        tax
        rts

        .databank 0

        ; 88/8D57

    .endsection Unsorted888C5FSection


    .section Unsorted888D57Section

      .al
      .xl

      rsGetMapTopRowIndex ; 88/8D57

        .al
        .autsiz
        .databank ?

        ; X = the aMapData index of the top left visible tile (wR3 too), Y = the buffer offset of its column (wR8).

        lda wUnknown00075C,b
        cmp #4
        beq ++

          cmp #8
          beq +
          
          +
          lda wMapScrollYPixels,b
          and #$FFF0
          asl a
          asl a
          asl a
          asl a
          sta wR3
          bra _8D7F

        +
        lda wMapScrollYPixels,b
        and #$FFF0
        asl a
        asl a
        asl a
        sta wR3
        bra _8D7F

        _8D7F
        lda wMapScrollXPixels,b
        and #$FFF0
        lsr a
        lsr a
        lsr a
        clc
        adc wR3
        sta wR3
        tax

        lda wMapScrollXPixels,b
        and #$00F8
        lsr a
        lsr a
        and #$003E
        sta wR8
        tay
        rts

        .databank 0

      rsGetMapColumnEndIndex ; 88/8D9D

        .al
        .autsiz
        .databank ?

        ; Adds 16 rows to the aMapData index in wR0.

        lda wUnknown00075C,b
        cmp #4
        beq ++

          cmp #8
          beq +

          +
          lda wR0
          clc
          adc #$1000
          rts

        +
        lda wR0
        clc
        adc #$0800
        rts

        .databank 0

      rsBuildMapRightColumn ; 88/8DB8

        .al
        .autsiz
        .databank ?

        jsr rsGetMapLeftColumnIndex
        clc
        adc #32
        sta wR0

        jsr rsGetMapColumnEndIndex
        sta wR8
        stz wR2

        lda wMapScrollXPixels,b
        and #$0008
        bne +

        lda wR0
        sec
        sbc #2
        sta wR0

        lda wR8
        sec
        sbc #2
        sta wR8
        bra ++

        +
        lda #$FFFC
        sta wR2

        +
        lda wMapScrollYPixels,b
        and #$0008
        bne +

          lda #4
          jsr rsBuildMapColumnTiles

          lda wUnknown000770,b
          beq _End

            lda #$00F8
            jsr rsBuildRangeOverlayColumn
            bra _End

        +
        lda #4
        jsr rsBuildMapColumnTilesHalfOffset

        lda wUnknown000770,b
        beq _End

          lda #$00F8
          jsr rsBuildRangeOverlayColumnHalfOffset

        _End
        rts

        .databank 0

      rsBuildMapLeftColumn ; 88/8E14

        .al
        .autsiz
        .databank ?

        ; Gets map tile index from camera position?
        jsr rsGetMapLeftColumnIndex
        sta wR0

        jsr rsGetMapColumnEndIndex
        sta wR8

        stz wR2

        lda wMapScrollXPixels,b
        and #$0008
        beq +

          lda #4
          sta wR2

        +
        lda wMapScrollYPixels,b
        and #$0008
        bne +

          lda #0
          jsr rsBuildMapColumnTiles

          lda wUnknown000770,b
          beq _End

            lda #0
            jsr rsBuildRangeOverlayColumn
            bra _End

        +
        lda #0
        jsr rsBuildMapColumnTilesHalfOffset

        lda wUnknown000770,b
        beq _End

          lda #0
          jsr rsBuildRangeOverlayColumnHalfOffset

        _End
        rts

        .databank 0

      rsGetNextMapRowIndex ; 88/8E5A

        .al
        .autsiz
        .databank ?

        ; A = X plus one row of aMapData.

        lda wUnknown00075C,b
        cmp #4
        beq ++

        cmp #8
        beq +
        
        +
        txa
        clc
        adc #$0100
        rts
        
        +
        txa
        clc
        adc #$0080
        rts

        .databank 0

      rsGetMapLeftColumnIndex ; 88/8E73

        .al
        .autsiz
        .databank ?

        ; A = the aMapData index of the top left visible tile; wR3 = the buffer offset of its row.

        lda wMapScrollYPixels,b
        and #$00F8
        lsr a
        lsr a
        and #62
        sta wR3

        lda wUnknown00075C,b
        cmp #4
        beq ++

          cmp #8
          beq +

          +
          lda wMapScrollYPixels,b
          and #$FFF0
          asl a
          asl a
          asl a
          asl a
          sta wR0
          bra ++
        
        +
        lda wMapScrollYPixels,b
        and #$FFF0
        asl a
        asl a
        asl a
        sta wR0
        bra +
        
        +
        lda wMapScrollXPixels,b
        and #$FFF0
        lsr a
        lsr a
        lsr a
        clc
        adc wR0
        rts

        .databank 0

      rsBuildMapColumnTiles ; 88/8EB5

        .al
        .autsiz
        .databank ?

        sta wR1
        ldy wR3
        ldx wR0

          _Loop
          lda aMapData,x
          and wUnknown000596,b
          asl a
          asl a
          asl a
          clc
          adc wR2
          phx
          clc
          adc wR1
          tax
          lda $7F0000,x
          and #$DFFF
          sta $059C,b,y
          lda $7F0002,x
          and #$DFFF
          sta $059E,b,y
          plx

          lda wUnknown00075A,b
          bit #$0002
          beq +

            lda $7F6400,x
            and #$03FF
            asl a
            asl a
            asl a
            clc
            adc wR2
            phx
            clc
            adc wR1
            tax
            lda $7F0000,x
            and #$DFFF
            ora #$2000
            sta $061C,b,y
            lda $7F0002,x
            and #$DFFF
            ora #$2000
            sta $061E,b,y
            plx

          +
          inc y
          inc y
          inc y
          inc y
          cpy #64
          bcc +

            ldy #0

          +
          jsr rsGetNextMapRowIndex
          cmp wR8
          bmi +
          bcs _End

          +
          tax
          jml _Loop
        
        _End
        rts

        .databank 0

        ; 88/8F32

    .endsection Unsorted888D57Section


    .section Unsorted888F32Section

      .al
      .xl

      rsBuildRangeOverlayColumn ; 88/8F32

        .al
        .xl
        .autsiz
        .databank ?

        clc
        adc wMapScrollXPixels,b
        sta $0792,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wTempVariable1,b
        lda wMapScrollXPixels,b
        sta wBufferBG3HOFS
        lda wMapScrollYPixels,b
        sta wBufferBG3VOFS
        lsr a
        lsr a
        lsr a
        lsr a
        sta wTempVariable2,b
        jsr rsGetMovementMapColumnIndex
        stz wR9
        stz wUnknown00072A,b
        lda wR3
        sta wR8
        tay

        _8F5E
        lda wTempVariable2,b
        cmp $071E,b
        bcc _8F89
        cmp $0722,b
        bcs _8F89
        lda wTempVariable1,b
        cmp $071C,b
        bcc _8F89
        cmp $0720,b
        bcs _8F89
        jsr rsGetMovementMapIndexInColumn
        lda aMovementMap,x
        and #$00FF
        beq _8F89
        jsr rsPutRangeOverlayColumnTiles
        bra _8F92


        _8F89
        lda #$00FF
        sta $069C,b,y
        sta $069E,b,y

        _8F92
        inc wTempVariable2,b
        inc y
        inc y
        inc y
        inc y
        inc wR9
        lda wR9
        cmp #$0010
        bcs _8FAE
        cpy #$0040
        bcc _8FAA
        ldy #$0000

        _8FAA
        jml _8F5E


        _8FAE
        rts

        .databank 0

        ; 88/8FAF

      rsPutRangeOverlayColumnTiles ; 88/8FAF

        .al
        .xl
        .autsiz
        .databank ?

        bit #$0080
        beq _8FB8
        jml rsPutRangeOverlayColumnFlaggedTiles


        _8FB8
        lda $0792,b
        and #$0008
        bne _8FCD
        lda #$284E
        sta $069C,b,y
        lda #$285E
        sta $069E,b,y
        rts


        _8FCD
        lda #$284F
        sta $069C,b,y
        lda #$285F
        sta $069E,b,y
        rts

        .databank 0

      rsPutRangeOverlayColumnBottomTile ; 88/8FDA

        .al
        .xl
        .autsiz
        .databank ?

        bit #$0080
        beq _8FE3
        jml rsPutRangeOverlayColumnFlaggedBottomTile


        _8FE3
        lda $0792,b
        and #$0008
        bne _8FF2
        lda #$285E
        sta $069C,b,y
        rts


        _8FF2
        lda #$285F
        sta $069C,b,y
        rts

        .databank 0

      rsPutRangeOverlayColumnTopTile ; 88/8FF9

        .al
        .xl
        .autsiz
        .databank ?

        bit #$0080
        beq _9002
        jml rsPutRangeOverlayColumnFlaggedTopTile


        _9002
        lda $0792,b
        and #$0008
        bne _9011
        lda #$284E
        sta $069C,b,y
        rts


        _9011
        lda #$284F
        sta $069C,b,y
        rts

        .databank 0

      rsPutRangeOverlayColumnFlaggedTiles ; 88/9018

        .al
        .xl
        .autsiz
        .databank ?

        cmp #$0080
        bne _9021
        jml rsPutRangeOverlayColumnAttackTiles


        _9021
        lda $0792,b
        and #$0008
        bne _9036
        lda #$244E
        sta $069C,b,y
        lda #$245E
        sta $069E,b,y
        rts


        _9036
        lda #$244F
        sta $069C,b,y
        lda #$245F
        sta $069E,b,y
        rts

        .databank 0

      rsPutRangeOverlayColumnFlaggedBottomTile ; 88/9043

        .al
        .xl
        .autsiz
        .databank ?

        cmp #$0080
        bne _904C
        jml rsPutRangeOverlayColumnAttackBottomTile


        _904C
        lda $0792,b
        and #$0008
        bne _905B
        lda #$245E
        sta $069C,b,y
        rts


        _905B
        lda #$245F
        sta $069C,b,y
        rts

        .databank 0

      rsPutRangeOverlayColumnFlaggedTopTile ; 88/9062

        .al
        .xl
        .autsiz
        .databank ?

        cmp #$0080
        bne _906B
        jml rsPutRangeOverlayColumnAttackTopTile


        _906B
        lda $0792,b
        and #$0008
        bne _907A
        lda #$244E
        sta $069C,b,y
        rts


        _907A
        lda #$244F
        sta $069C,b,y
        rts

        .databank 0

      rsPutRangeOverlayColumnAttackTiles ; 88/9081

        .al
        .xl
        .autsiz
        .databank ?

        lda $0792,b
        and #$0008
        bne _9096
        lda #$2C4E
        sta $069C,b,y
        lda #$2C5E
        sta $069E,b,y
        rts


        _9096
        lda #$2C4F
        sta $069C,b,y
        lda #$2C5F
        sta $069E,b,y
        rts

        .databank 0

        ; 88/90A3

      rsPutRangeOverlayColumnAttackBottomTile ; 88/90A3

        .al
        .xl
        .autsiz
        .databank ?

        lda $0792,b
        and #$0008
        bne _90B2
        lda #$2C5E
        sta $069C,b,y
        rts


        _90B2
        lda #$2C5F
        sta $069C,b,y
        rts

        .databank 0

        ; 88/90B9

      rsPutRangeOverlayColumnAttackTopTile ; 88/90B9

        .al
        .xl
        .autsiz
        .databank ?

        lda $0792,b
        and #$0008
        bne _90C8
        lda #$2C4E
        sta $069C,b,y
        rts


        _90C8
        lda #$2C4F
        sta $069C,b,y
        rts

        .databank 0

        ; 88/90CF

      rsGetMovementMapColumnIndex ; 88/90CF

        .al
        .xl
        .autsiz
        .databank ?

        lda wTempVariable1,b
        sec
        sbc $0720,b
        and #$003F
        sta wUnknown000790,b
        lda wTempVariable2,b
        sec
        sbc $0722,b
        and #$003F
        asl a
        asl a
        asl a
        asl a
        asl a
        asl a
        clc
        adc wUnknown000790,b
        tax
        rts

        .databank 0

        ; 88/90F2

      rsGetMovementMapIndexInColumn ; 88/90F2

        .al
        .xl
        .autsiz
        .databank ?

        lda wTempVariable2,b
        sec
        sbc $0722,b
        and #$003F
        asl a
        asl a
        asl a
        asl a
        asl a
        asl a
        clc
        adc wUnknown000790,b
        tax
        rts

        .databank 0

        ; 88/9108

      rsBuildMapColumnTilesHalfOffset ; 88/9108

        .al
        .xl
        .autsiz
        .databank ?

        sta wR1
        ldy wR3
        ldx wR0

        _910E
        lda aMapData,x
        and wUnknown000596,b
        asl a
        asl a
        asl a
        clc
        adc wR2
        phx
        clc
        adc wR1
        tax
        lda $7F0002,x
        and #$DFFF
        sta $059C,b,y
        plx
        lda wUnknown00075A,b
        bit #$0002
        beq _9153
        lda $7F6400,x
        and #$03FF
        asl a
        asl a
        asl a
        clc
        adc wR2
        phx
        clc
        adc wR1
        tax
        lda $7F0002,x
        and #$DFFF
        ora #$2000
        sta $061C,b,y
        plx

        _9153
        inc y
        inc y
        cpy #$0040
        bcc _915D
        ldy #$0000

        _915D
        jsr rsGetNextMapRowIndex
        tax
        lda aMapData,x
        and wUnknown000596,b
        asl a
        asl a
        asl a
        clc
        adc wR2
        phx
        clc
        adc wR1
        tax
        lda $7F0000,x
        and #$DFFF
        sta $059C,b,y
        plx
        lda wUnknown00075A,b
        bit #$0002
        beq _91A6
        lda $7F6400,x
        and #$03FF
        asl a
        asl a
        asl a
        clc
        adc wR2
        phx
        clc
        adc wR1
        tax
        lda $7F0000,x
        and #$DFFF
        ora #$2000
        sta $061C,b,y
        plx

        _91A6
        inc y
        inc y
        cpy #$0040
        bcc _91B0
        ldy #$0000

        _91B0
        txa
        cmp wR8
        bmi _91B7
        bcs _91BB

        _91B7
        jml _910E


        _91BB
        rts

        .databank 0

        ; 88/91BC

      rsBuildRangeOverlayColumnHalfOffset ; 88/91BC

        .al
        .xl
        .autsiz
        .databank ?

        clc
        adc wMapScrollXPixels,b
        sta $0792,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wTempVariable1,b
        lda wMapScrollXPixels,b
        sta wBufferBG3HOFS
        lda wMapScrollYPixels,b
        sta wBufferBG3VOFS
        lsr a
        lsr a
        lsr a
        lsr a
        sta wTempVariable2,b
        jsr rsGetMovementMapColumnIndex
        stz wR9
        stz wUnknown00072A,b
        lda wR3
        sta wR8
        tay

        _91E8
        lda wTempVariable2,b
        cmp $071E,b
        bcc _9232
        cmp $0722,b
        bcs _9232
        lda wTempVariable1,b
        cmp $071C,b
        bcc _9232
        cmp $0720,b
        bcs _9232
        jsr rsGetMovementMapIndexInColumn
        lda aMovementMap,x
        and #$00FF
        beq _9242
        jsr rsPutRangeOverlayColumnBottomTile

        _9211
        inc wTempVariable2,b
        inc y
        inc y
        cpy #$0040
        bcc _9221
        inc wUnknown00072A,b
        ldy #$0000

        _9221
        jsr rsGetMovementMapIndexInColumn
        lda aMovementMap,x
        and #$00FF
        beq _924A
        jsr rsPutRangeOverlayColumnTopTile
        bra _9250


        _9232
        inc wTempVariable2,b
        lda #$00FF
        sta $069C,b,y
        inc y
        inc y
        sta $069C,b,y
        bra _9250


        _9242
        lda #$00FF
        sta $069C,b,y
        bra _9211


        _924A
        lda #$00FF
        sta $069C,b,y

        _9250
        inc y
        inc y
        inc wR9
        lda wR9
        cmp #$0010
        bcs _9267
        cpy #$0040
        bcc _9263
        ldy #$0000

        _9263
        jml _91E8


        _9267
        rts

        .databank 0

        ; 88/9268

      rlLoadChapterMapLayout ; 88/9268

        .al
        .xl
        .autsiz
        .databank ?

        ; Decompresses wCurrentChapter's map layout to aMapData and its tile entries to $7F0000, sets wMapWidthMode, $075E and the scroll limits, and decompresses the terrain table.

        lda wCurrentChapter,b
        asl a
        clc
        adc wCurrentChapter,b
        tax
        lda aChapterMapPointers+1,x
        sta lR19+1
        lda aChapterMapPointers,x
        sta lR19
        ldy #$0000
        lda [lR19],y
        sta lR45
        ldy #$0001
        lda [lR19],y
        sta lR45+1
        lda #(`aMapData)<<8
        sta lR47+1
        lda #<>aMapData
        sta lR47
        jsl rlDecompressSingle
        ldy #$0003
        lda [lR19],y
        sta lR45
        ldy #$0004
        lda [lR19],y
        sta lR45+1
        lda #$7F00
        sta lR47+1
        lda #$0000
        sta lR47
        jsl rlDecompressSingle
        ldy #$000C
        lda [lR19],y
        sta wUnknown00075C,b
        inc y
        inc y
        lda [lR19],y
        sta $075E,b
        inc y
        inc y
        lda [lR19],y
        sta wMapMinXScroll,b
        inc y
        inc y
        lda [lR19],y
        sta wMapMinYScroll,b
        inc y
        inc y
        lda [lR19],y
        sec
        sbc #$0100
        sta wMapMaxXScroll,b
        inc y
        inc y
        lda [lR19],y
        sec
        sbc #$00E0
        sta wMapMaxYScroll,b
        ldy #$0018
        lda [lR19],y
        sta lR45
        ldy #$0019
        lda [lR19],y
        sta lR45+1
        lda #(`aTerrainTileset)<<8
        sta lR47+1
        lda #<>aTerrainTileset
        sta lR47
        jsl rlDecompressSingle
        rtl

        .databank 0

        ; 88/9305

      rlLoadChapterMapGraphics ; 88/9305

        .al
        .xl
        .autsiz
        .databank ?

        ; Decompresses wCurrentChapter's map tile graphics and copies them to VRAM $2800, then copies its palettes into BG palettes 1-7.

        lda wCurrentChapter,b
        asl a
        clc
        adc wCurrentChapter,b
        tax
        lda aChapterMapPointers+1,x
        sta lR19+1
        lda aChapterMapPointers,x
        sta lR19
        ldy #$0006
        lda [lR19],y
        sta lR45
        ldy #$0007
        lda [lR19],y
        sta lR45+1
        lda #(`aDecompressionBuffer)<<8
        sta lR47+1
        lda #<>aDecompressionBuffer
        sta lR47
        jsl rlDecompressSingle
        lda #(`aDecompressionBuffer)<<8
        sta lR20+1
        lda #<>aDecompressionBuffer
        sta lR20
        sep #$20
        lda #$80
        sta $2115,b
        lda #$00
        sta $4315,b
        lda #$20
        sta $4316,b
        lda #$18
        sta $4311,b
        lda lR20
        sta $4312,b
        lda lR20+1
        sta $4313,b
        lda lR20+2
        sta $4314,b
        lda #$00
        sta $2116,b
        lda #$28
        sta $2117,b
        lda #$01
        sta $4310,b
        lda #$02
        sta $420B,b
        rep #$20
        ldy #$000A
        lda [lR19],y
        sta lR20+1
        ldy #$0009
        lda [lR19],y
        sta lR20
        ldy #$00DE

        _938C
        lda [lR20],y
        sta aBGPaletteBuffer.aPalette1,b,y
        dec y
        dec y
        bpl _938C
        rtl

        .databank 0

        ; 88/9396

    .endsection Unsorted888F32Section


    .section ProcScript889396Section

      .al
      .xl

      procMinimap ; 88/9396

        .structProcInfo "MG", rlProcMinimapInit, rlProcMinimapClear, aProcMinimapCode

    .endsection ProcScript889396Section


    .section Unsorted88939ESection

      .al
      .xl

      rlProcMinimapInit ; 88/939E

        .al
        .xl
        .autsiz
        .databank ?

        ; Sets up the colour math and the minimap palette (aMinimapPaletteData).

        lda #$8B88
        sta aProcSystem.aBody0,b,x
        lda #$3000
        sta aProcSystem.aBody1,b,x
        lda #$0004
        sta aProcSystem.aBody2,b,x
        lda #(`aMinimapPaletteData)<<8
        sta lR19+1
        lda #<>aMinimapPaletteData
        sta lR19
        jsl rlApplyMapMenuPaletteData
        sep #$20
        lda #$17
        sta bBufferTM
        lda #$00
        sta bBufferCGWSEL
        lda #$BD
        sta bBufferCGADSUB
        lda #$20
        sta bBufferCOLDATA_1
        lda #$40
        sta bBufferCOLDATA_2
        lda #$80
        sta bBufferCOLDATA_3
        rep #$20
        rtl

        .databank 0

        ; 88/93DB

    .endsection Unsorted88939ESection


    .section Table8893DBSection

      .al
      .xl

      aMinimapPaletteData .dstruct structMapMenuPaletteData, $000F, 6, 1, aMinimapPalette ; 88/93DB

      aMinimapPalette ; 88/93E2
        .word $08A5, $1DC9, $1168, $3DEF, $2657, $0D2F, $0089, $6978
        .word $6289, $3945, $7BFF, $7E00, $001F, $03E0, $03FF

    .endsection Table8893DBSection


    .section Unsorted889400Section

      .al
      .xl

      rlProcMinimapClear ; 88/9400

        .al
        .xl
        .autsiz
        .databank ?

        ; Clears the minimap pixels (rlClearMinimap).

        jsl rlClearMinimap
        lda #<>rlProcMinimapDrawTerrain
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$1FFE
        sta aProcSystem.aBody2,b,x
        rtl

        .databank 0

        ; 88/9411

    .endsection Unsorted889400Section


    .section Unsorted889411Section

      .al
      .xl

      rlProcMinimapDrawTerrain ; 88/9411

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws $200 map tiles a frame (rlDrawMinimapTerrain), fading the screen as it goes.

        sep #$20
        lda #$BD
        sta bBufferCGADSUB
        inc bBufferCOLDATA_1
        inc bBufferCOLDATA_2
        inc bBufferCOLDATA_3
        rep #$20
        lda aProcSystem.aBody2,b,x
        sec
        sbc #$0400
        bpl _942B
        lda #$0000

        _942B
        sta wTempVariable1,b
        phx
        lda aProcSystem.aBody2,b,x
        tax
        jsl rlDrawMinimapTerrain
        txa
        plx
        sta aProcSystem.aBody2,b,x
        lda aProcSystem.aBody2,b,x
        bpl _9447
        lda #<>rlProcMinimapDrawUnits
        sta aProcSystem.aHeaderOnCycle,b,x

        _9447
        rtl

        .databank 0

        ; 88/9448

      rlProcMinimapDrawUnits ; 88/9448

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws the units (rlDrawMinimapUnits); when choosing a warp destination, shows the first castle.

        jsl rlDrawMinimapUnits
        lda #<>rlProcMinimapUpload
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0004
        sta aProcSystem.aBody2,b,x
        lda #$0019
        jsl rlPlaySoundEffect
        lda wUnknown000D79,b
        bit #$0800
        beq _946A
        jsr rsMinimapShowWarpCastle

        _946A
        rtl

        .databank 0

        ; 88/946B

      rlProcMinimapUpload ; 88/946B

        .al
        .xl
        .autsiz
        .databank ?

        ; Copies the minimap pixels to VRAM, $800 bytes a frame for four frames.

        lda #$7E8B
        sta lR18+1
        lda aProcSystem.aBody0,b,x
        sta lR18
        clc
        adc #$0800
        sta aProcSystem.aBody0,b,x
        lda aProcSystem.aBody1,b,x
        sta wR1
        clc
        adc #$0400
        sta aProcSystem.aBody1,b,x
        lda #$0800
        sta wR0
        phx
        jsl rlDMAByPointer
        plx
        dec aProcSystem.aBody2,b,x
        bne _949E
        lda #<>rlProcMinimapDrawTilemap
        sta aProcSystem.aHeaderOnCycle,b,x

        _949E
        rtl

        .databank 0

        ; 88/949F

      rlProcMinimapDrawTilemap ; 88/949F

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws the minimap's tilemap (16x16 tiles, 16x8 in the prologue) and ends the proc.

        sep #$20
        rep #$20
        phx
        lda #$3BFF
        sta wR0
        ldx #$01FE

        _94AC
        txa
        lda wR0
        sta aEpilogueUnitStates,x
        dec wR0
        dec x
        dec x
        bpl _94AC
        lda wCurrentChapter,b
        beq _94CC
        lda #(`aMinimapTilemapInfo)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aMinimapTilemapInfo
        sta lMapMenuTilemapRAMEntryPointer,b
        bra _94D8


        _94CC
        lda #(`aMinimapPrologueTilemapInfo)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aMinimapPrologueTilemapInfo
        sta lMapMenuTilemapRAMEntryPointer,b

        _94D8
        ldx #$0190
        jsl rlCopyTilemapEntryToBG
        jsl rlDMAByStruct

          .structDMAToVRAM $7E7B88, $0800, $80, $A800

        plx
        jsl rlProcEngineFreeProc
        rtl

        .databank 0

        ; 88/94F2

    .endsection Unsorted889411Section


    .section Table8894F2Section

      .al
      .xl

      aMinimapTilemapInfo ; 88/94F2
        .byte $10, $10, $88, $7B, $7E, $00, $4A, $C5, $7F

      aMinimapPrologueTilemapInfo ; 88/94FB
        .byte $10, $08, $88, $7B, $7E, $00, $4A, $C5, $7F

    .endsection Table8894F2Section


    .section ProcScript889504Section

      .al
      .xl

      aProcMinimapCode ; 88/9504

        PROC_HALT


        ; 88/9506

    .endsection ProcScript889504Section


    .section Unsorted889506Section

      .al
      .xl

      rsPutMinimapDot ; 88/9506

        .al
        .xl
        .autsiz
        .databank ?

        ; ORs a 2x2 pixel dot of colour wR2 into the minimap pixels ($7E8B88) for map tile (wR0, wR1).

        php
        phx
        lda wR1
        and #$FFFC
        xba
        lsr a
        sta wR3
        lda wR0
        and #$FFFC
        asl a
        asl a
        asl a
        clc
        adc wR3
        sta wR3
        lda wR1
        and #$0003
        asl a
        asl a
        clc
        adc wR3
        tay
        lda wR2
        asl a
        tax
        lda wR0
        and #$0003
        asl a
        asl a
        clc
        adc aMinimapDotColorBits,x
        tax
        sep #$20
        lda $8B88,b,y
        ora aMinimapDotColorBits,x
        sta $8B88,b,y
        lda $8B89,b,y
        ora aMinimapDotColorBits+1,x
        sta $8B89,b,y
        lda $8B98,b,y
        ora aMinimapDotColorBits+2,x
        sta $8B98,b,y
        lda $8B99,b,y
        ora aMinimapDotColorBits+3,x
        sta $8B99,b,y
        lda $8B8A,b,y
        ora aMinimapDotColorBits,x
        sta $8B8A,b,y
        lda $8B8B,b,y
        ora aMinimapDotColorBits+1,x
        sta $8B8B,b,y
        lda $8B9A,b,y
        ora aMinimapDotColorBits+2,x
        sta $8B9A,b,y
        lda $8B9B,b,y
        ora aMinimapDotColorBits+3,x
        sta $8B9B,b,y
        plx
        plp
        .al
        rts

        .databank 0

        ; 88/958F

    .endsection Unsorted889506Section


    .section Table88958FSection

      .al
      .xl

      aMinimapDotColorBits ; 88/958F

        ; Read by rsPutMinimapDot.

        .word $0020, $0030, $0040, $0050, $0060, $0070, $0080, $0090
        .word $00A0, $00B0, $00C0, $00D0, $00E0, $00F0, $0100, $0110

        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $C0, $00, $00, $00, $30, $00, $00, $00, $0C, $00, $00, $00, $03, $00, $00, $00
        .byte $00, $C0, $00, $00, $00, $30, $00, $00, $00, $0C, $00, $00, $00, $03, $00, $00
        .byte $C0, $C0, $00, $00, $30, $30, $00, $00, $0C, $0C, $00, $00, $03, $03, $00, $00
        .byte $00, $00, $C0, $00, $00, $00, $30, $00, $00, $00, $0C, $00, $00, $00, $03, $00
        .byte $C0, $00, $C0, $00, $30, $00, $30, $00, $0C, $00, $0C, $00, $03, $00, $03, $00
        .byte $00, $C0, $C0, $00, $00, $30, $30, $00, $00, $0C, $0C, $00, $00, $03, $03, $00
        .byte $C0, $C0, $C0, $00, $30, $30, $30, $00, $0C, $0C, $0C, $00, $03, $03, $03, $00
        .byte $00, $00, $00, $C0, $00, $00, $00, $30, $00, $00, $00, $0C, $00, $00, $00, $03
        .byte $C0, $00, $00, $C0, $30, $00, $00, $30, $0C, $00, $00, $0C, $03, $00, $00, $03
        .byte $00, $C0, $00, $C0, $00, $30, $00, $30, $00, $0C, $00, $0C, $00, $03, $00, $03
        .byte $C0, $C0, $00, $C0, $30, $30, $00, $30, $0C, $0C, $00, $0C, $03, $03, $00, $03
        .byte $00, $00, $C0, $C0, $00, $00, $30, $30, $00, $00, $0C, $0C, $00, $00, $03, $03
        .byte $C0, $00, $C0, $C0, $30, $00, $30, $30, $0C, $00, $0C, $0C, $03, $00, $03, $03
        .byte $00, $C0, $C0, $C0, $00, $30, $30, $30, $00, $0C, $0C, $0C, $00, $03, $03, $03
        .byte $C0, $C0, $C0, $C0, $30, $30, $30, $30, $0C, $0C, $0C, $0C, $03, $03, $03, $03

        ; 88/96AF

    .endsection Table88958FSection


    .section Unsorted8896AFSection

      .al
      .xl

      rsClearMinimapDot ; 88/96AF

        .al
        .xl
        .autsiz
        .databank ?

        ; Clears the 2x2 pixel dot of map tile (wR0, wR1).

        php
        phx
        lda wR1
        and #$FFFC
        xba
        lsr a
        sta wR3
        lda wR0
        and #$FFFC
        asl a
        asl a
        asl a
        clc
        adc wR3
        sta wR3
        lda wR1
        and #$0003
        asl a
        asl a
        clc
        adc wR3
        tay
        lda wR0
        and #$0003
        asl a
        asl a
        tax
        sep #$20
        lda $8B88,b,y
        and aMinimapDotClearMasks,x
        sta $8B88,b,y
        lda $8B89,b,y
        and aMinimapDotClearMasks+1,x
        sta $8B89,b,y
        lda $8B98,b,y
        and aMinimapDotClearMasks+2,x
        sta $8B98,b,y
        lda $8B99,b,y
        and aMinimapDotClearMasks+3,x
        sta $8B99,b,y
        lda $8B8A,b,y
        and aMinimapDotClearMasks,x
        sta $8B8A,b,y
        lda $8B8B,b,y
        and aMinimapDotClearMasks+1,x
        sta $8B8B,b,y
        lda $8B9A,b,y
        and aMinimapDotClearMasks+2,x
        sta $8B9A,b,y
        lda $8B9B,b,y
        and aMinimapDotClearMasks+3,x
        sta $8B9B,b,y
        plx
        plp
        .al
        rts

        .databank 0

        ; 88/972F

    .endsection Unsorted8896AFSection


    .section Data88972FSection

      .al
      .xl

      aMinimapDotClearMasks ; 88/972F

        ; Read by rsClearMinimapDot.

        .byte $3F, $3F, $3F, $3F, $CF, $CF, $CF, $CF, $F3, $F3, $F3, $F3, $FC, $FC, $FC, $FC

        ; 88/973F

    .endsection Data88972FSection


    .section Unsorted88973FSection

      .al
      .xl

      rlMinimapStep ; 88/973F

        .al
        .xl
        .autsiz
        .databank ?

        ; Runs while the minimap is open (bit 5 of wMapSystemFlags). The D-pad scrolls the map under it, B or Start closes it, holding R, X, A or Y makes it see-through and L jumps to the home castle. When choosing a warp destination (bit 11 of wUnknown000D79) the D-pad picks a castle instead (rsMinimapChooseWarpCastle).

        lda #(`procMinimap)<<8
        sta lR44+1
        lda #<>procMinimap
        sta lR44
        jsl rlProcEngineFindProc
        bcc _9753
        jml _9840


        _9753
        lda #(`procMinimapClose)<<8
        sta lR44+1
        lda #<>procMinimapClose
        sta lR44
        jsl rlProcEngineFindProc
        bcc _9767
        jml _9840


        _9767
        lda wUnknown000D79,b
        bit #$0800
        beq _9773
        jml _9841


        _9773
        lda wUnknown000766,b
        bne _97DA
        lda wJoy1New
        bit #$9000
        beq _978E
        lda #(`procMinimapClose)<<8
        sta lR44+1
        lda #<>procMinimapClose
        sta lR44
        jsl rlProcEngineCreateProc
        rtl


        _978E
        jsr rsMinimapHandleTransparency
        lda wJoy1Input
        and #$0F00
        sta wMapScrollDirectionIdentifier,b
        bne _97AC
        lda $0ADB,b
        beq _9801
        stz $0ADB,b
        lda #$001C
        jsl rlPlaySoundEffect
        bra _9801


        _97AC
        lda $0ADB,b
        bne _97C2
        inc $0ADB,b
        lda #$001A
        jsl rlPlaySoundEffect
        lda #$001B
        jsl rlPlaySoundEffect

        _97C2
        stz wMapScrollCurrentPixelDistance,b
        lda #$0001
        sta wUnknown000766,b
        stz wUnknown00073A,b
        stz wMapEnableXScrollFlag,b
        stz wMapEnableYScrollFlag,b
        lda #$0004
        sta wMapScrollSpeed,b

        _97DA
        lda wMapScrollCurrentPixelDistance,b
        clc
        adc wMapScrollSpeed,b
        sta wMapScrollCurrentPixelDistance,b
        cmp #$0010
        bcc _97F5
        stz wUnknown000766,b
        stz wUnknown00073A,b
        stz wMapEnableXScrollFlag,b
        stz wMapEnableYScrollFlag,b

        _97F5
        jsl rlMinimapScrollMap
        lda wMapScrollCurrentPixelDistance,b
        cmp wMapScrollSpeed,b
        bne _9801

        _9801
        sep #$20
        lda #$88
        pha
        plb
        .databank $88
        rep #$20
        ldy #$EE94
        lda wMapScrollXPixels,b
        lsr a
        lsr a
        lsr a
        clc
        adc #$0040
        sta wR0
        lda wMapScrollYPixels,b
        lsr a
        lsr a
        lsr a
        clc
        adc #$0030
        sta wR1
        lda #$2000
        sta wR5
        lda #$0000
        sta wR4
        lda wVBlankEnabledFramecount
        and #$0018
        beq _9838
        ldy #$EE7E

        _9838
        jsl rlPushToOAMBuffer
        jsl rlMinimapAnimateViewColors

        _9840
        rtl


        _9841
        jsr rsMinimapChooseWarpCastle
        lda wCastleCursorX,b
        asl a
        clc
        adc #$0040
        sec
        sbc #$0010
        sta wR0
        lda wCastleCursorY,b
        asl a
        clc
        adc #$0030
        sec
        sbc #$0006
        sta wR1
        lda #$0000
        jsl rlDrawHandCursor
        jsl rlMinimapAnimateViewColors
        rtl

        .databank 0

        ; 88/986C

      rsMinimapChooseWarpCastle ; 88/986C

        .al
        .xl
        .autsiz
        .databank ?

        ; Down or right goes to the next castle, up or left to the previous one, A chooses it (sets bit 14 of wMapSystemFlags) and B cancels; both close the minimap.

        lda wJoy1New
        bit #$0500
        bne _9883
        bit #$0A00
        bne _988A
        bit #$0080
        bne _98B4
        bit #$8000
        bne _98A1
        rts


        _9883
        inc wCastleSubMenuStep,b
        jml rsMinimapShowWarpCastle


        _988A
        dec wCastleSubMenuStep,b
        lda wCastleSubMenuStep,b
        bpl _989D
        jsl rlGetChapterLocationCount
        sec
        sbc #$0001
        sta wCastleSubMenuStep,b

        _989D
        jml rsMinimapShowWarpCastle


        _98A1
        lda #(`procMinimapClose)<<8
        sta lR44+1
        lda #<>procMinimapClose
        sta lR44
        jsl rlProcEngineCreateProc
        stz wUnknown0007D8,b
        rts

        .byte $60


        _98B4
        lda #$4000
        tsb wMapSystemFlags,b
        lda #(`procMinimapClose)<<8
        sta lR44+1
        lda #<>procMinimapClose
        sta lR44
        jsl rlProcEngineCreateProc
        rts

      aMinimapCastleNameTilemapInfo ; 88/98C9

        .byte $20, $20, $00, $00, $00, $00, $88, $83, $7E

        ; 88/98D2

      rsMinimapShowWarpCastle ; 88/98D2

        .al
        .xl
        .autsiz
        .databank ?

        ; Moves wCastleSubMenuStep on to a castle the player owns that is empty (or is the home castle), puts wCastleCursorX/Y on it and draws its name.

        lda wCastleSubMenuStep,b
        jsl rlGetLocationEventDataEntry
        bcs _992C
        jsl rlGetEventLocationEntryType
        cmp #LocationTypeCastle
        bne _9931
        jsl rlGetLocationFactionSlotOwner
        cmp #$0000
        bne _9931
        jsl rlGetEventLocationEntryEffectiveXCoordinate
        sta wTempVariable1,b
        jsl rlGetEventLocationEntryEffectiveYCoordinate
        sta wTempVariable2,b
        jsl rlGetEventLocationEntryID
        sta wUnknown000790,b
        lda #$0000
        jsl rlGetFactionSlotLocationID
        cmp wUnknown000790,b
        beq _991E
        lda wTempVariable1,b
        sta wR0
        lda wTempVariable2,b
        sta wR1
        jsl rlGetUnitByCoordinates
        bcc _9931

        _991E
        lda wTempVariable1,b
        sta wCastleCursorX,b
        lda wTempVariable2,b
        sta wCastleCursorY,b
        bra _9952


        _992C
        stz wCastleSubMenuStep,b
        bra rsMinimapShowWarpCastle


        _9931
        lda wJoy1New
        bit #$0A00
        bne _993D
        inc wCastleSubMenuStep,b
        bra rsMinimapShowWarpCastle


        _993D
        dec wCastleSubMenuStep,b
        lda wCastleSubMenuStep,b
        bpl rsMinimapShowWarpCastle
        jsl rlGetChapterLocationCount
        sec
        sbc #$0001
        sta wCastleSubMenuStep,b
        bra rsMinimapShowWarpCastle


        _9952
        lda #(`aMinimapCastleNameTilemapInfo)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aMinimapCastleNameTilemapInfo
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda #(`aMinimapBlankCastleNameText)<<8
        sta lRoutineVariable+1,b
        lda #<>aMinimapBlankCastleNameText
        sta lRoutineVariable,b
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$040D
        jsl rlDrawMenuTextLine
        jsl rlGetEventLocationEntryCastleName
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$040D
        jsl rlDrawMenuTextLine
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8488, $0080, $80, $B100

        rts

        .databank 0

        ; 88/99A4

    .endsection Unsorted88973FSection


    .section Table8899A4Section

      .al
      .xl

      aMinimapBlankCastleNameText ; 88/99A4

        .enc "SJIS"
        .text "　　　　　　　　　"
        .word $0000
        .enc "none"


    .endsection Table8899A4Section


    .section Unsorted8899B8Section

      .al
      .xl

      rlMinimapScrollMap ; 88/99B8

        .al
        .xl
        .autsiz
        .databank ?

        ; Scrolls the map in the D-pad direction and plays the scrolling sounds.

        lda wMapScrollXPixels,b
        sta wUnknown000734,b
        lda wMapScrollYPixels,b
        sta wUnknown000736,b
        lda wMapScrollDirectionIdentifier,b
        cmp #$0200
        beq _99F0
        cmp #$0100
        beq _99F6
        cmp #$0800
        beq _99FC
        cmp #$0400
        beq _9A02
        cmp #$0A00
        beq _9A08
        cmp #$0600
        beq _9A0E
        cmp #$0900
        beq _9A14
        cmp #$0500
        beq _9A1A

        _99EF
        rtl


        _99F0
        jsl rlStartMapScrollLeft
        bra _9A20


        _99F6
        jsl rlStartMapScrollRight
        bra _9A20


        _99FC
        jsl rlStartMapScrollUp
        bra _9A20


        _9A02
        jsl rlStartMapScrollDown
        bra _9A20


        _9A08
        jsl rlStartMapScrollUpLeft
        bra _9A20


        _9A0E
        jsl rlStartMapScrollDownLeft
        bra _9A20


        _9A14
        jsl rlStartMapScrollUpRight
        bra _9A20


        _9A1A
        jsl rlStartMapScrollDownRight
        bra _9A20


        _9A20
        lda wMapScrollXPixels,b
        cmp wUnknown000734,b
        bne _99EF
        lda wMapScrollYPixels,b
        cmp wUnknown000736,b
        bne _99EF
        lda $0ADB,b
        beq _99EF
        stz $0ADB,b
        lda #$001C
        jsl rlPlaySoundEffect
        bra _99EF

        .databank 0

        ; 88/9A41

      rsMinimapHandleTransparency ; 88/9A41

        .al
        .xl
        .autsiz
        .databank ?

        lda wJoy1Input
        bit #$0010
        bne _9A6F
        bit #$0040
        bne _9A6F
        bit #$0080
        bne _9A6F
        bit #$4000
        bne _9A6F
        lda wJoy1New
        bit #$0020
        bne _9A80

        _9A5E
        sep #$20
        lda #$00
        sta bBufferCGWSEL
        lda #$A9
        sta bBufferCGADSUB
        lda #$00
        sta bBufferTS
        rep #$20
        rts


        _9A6F
        sep #$20
        lda #$02
        sta bBufferCGWSEL
        lda #$52
        sta bBufferCGADSUB
        lda #$11
        sta bBufferTS
        rep #$20
        rts


        _9A80
        jsr rsUnknown88C1BF
        bra _9A5E

        .databank 0

        ; 88/9A85

      rlMinimapAnimateViewColors ; 88/9A85

        .al
        .xl
        .autsiz
        .databank ?

        ; Cycles four OAM colours by frame (aMinimapViewColorCycle) for the box that shows the visible part of the map.

        lda wVBlankEnabledFramecount
        and #$001E
        tax
        lda aMinimapViewColorCycle,x
        and #$03FF
        clc
        adc #$7C00
        sta $01D8,b
        lda aMinimapViewColorCycle,x
        and #$7FE0
        clc
        adc #$001F
        sta $01DA,b
        lda aMinimapViewColorCycle,x
        and #$7C1F
        clc
        adc #$03E0
        sta $01DC,b
        lda aMinimapViewColorCycle,x
        and #$7C00
        clc
        adc #$033F
        sta $01DE,b
        rtl

        .databank 0

        ; 88/9AC4

    .endsection Unsorted8899B8Section


    .section Table889AE2Section

      .al
      .xl

      aMinimapViewColorCycle ; 88/9AE2

        ; Read by rlMinimapAnimateViewColors.

        .word $0000, $0421, $0842, $1084, $18C6, $1CE7, $2529, $7DEF
        .word $7DEF, $2529, $1CE7, $18C6, $1084, $0842, $0421, $0000
        .word $0000, $0021, $0042, $0063, $0084, $00A5, $00C6, $00E7
        .word $00E7, $00C6, $00A5, $0084, $0063, $0042, $0021, $0000

        ; 88/9B22

    .endsection Table889AE2Section


    .section Unsorted889B22Section

      .al
      .xl

      rlClearMinimap ; 88/9B22

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb
        .databank $7E
        phx
        phy
        ldx #$01FE
        lda #$0000

        _9B34
        sta $8B88,b,x
        sta $8D88,b,x
        sta $8F88,b,x
        sta $9188,b,x
        sta $9388,b,x
        sta $9588,b,x
        sta $9788,b,x
        sta $9988,b,x
        sta $9B88,b,x
        sta $9D88,b,x
        sta $9F88,b,x
        sta $A188,b,x
        sta $A388,b,x
        sta $A588,b,x
        sta $A788,b,x
        sta $A988,b,x
        dec x
        dec x
        bpl _9B34
        ply
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 88/9B6D

    .endsection Unsorted889B22Section


    .section Unsorted889B6DSection

      .al
      .xl

      rlDrawMinimapTerrain ; 88/9B6D

        .al
        .xl
        .autsiz
        .databank ?

        ; Puts a dot for each map tile from X down to wTempVariable1, coloured by its terrain (aMinimapTerrainColors) or 9 for a closed village.

        phb
        php
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb
        .databank $7E

        _9B77
        txa
        and #$007E
        lsr a
        sta wR0
        txa
        and #$FF80
        asl a
        xba
        sta wR1
        phx
        lda aMapData,x
        and #$03FF
        tax
        lda aTerrainTileset,x
        and #$00FF
        tax
        jsr rsCheckMinimapClosedVillage
        bcs _9BA5
        lda aMinimapTerrainColors,x
        and #$00FF
        sta wR2

        _9BA5
        plx
        jsr rsPutMinimapDot
        dec x
        dec x
        cpx wTempVariable1,b
        bmi _9BB2
        bcs _9B77

        _9BB2
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 88/9BB5

    .endsection Unsorted889B6DSection


    .section Unsorted889BB5Section

      .al
      .xl

      aMinimapTerrainColors ; 88/9BB5

        ; One byte per terrain type (the index comes from aTerrainTileset), read by
        ; rlDrawMinimapTerrain unless rsCheckMinimapClosedVillage returns with carry set.

        .byte $06, $01, $06, $02, $03, $0A, $0A, $05, $04, $0B, $08, $08, $08
        .byte $08, $05, $0B, $07, $08, $08, $08, $08, $08, $08, $08, $08, $04

        ; 88/9BCF

      rsCheckMinimapClosedVillage ; 88/9BCF

        .al
        .xl
        .autsiz
        .databank ?

        ; For terrain $12 or $13: carry set and colour 9 when the tile is a village that is closed.

        cmp #$0012
        beq _9BD9
        cmp #$0013
        bne _9BF5

        _9BD9
        jsl rlFindLocationAtTile
        bcs _9BF5
        jsl rlGetEventLocationEntryType
        cmp #LocationTypeVillage
        bne _9BF5
        jsl rlCheckIfVillageClosed
        bcc _9BF5
        lda #$0009
        sta wR2
        sec
        rts


        _9BF5
        clc
        rts

        .databank 0

        ; 88/9BF7

    .endsection Unsorted889BB5Section


    .section Unsorted889BF7Section

      .al
      .xl

      rlDrawMinimapUnits ; 88/9BF7

        .al
        .xl
        .autsiz
        .databank ?

        ; Puts a dot for each deployed, visible unit, coloured $0C plus its allegiance.

        phb
        php
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb
        .databank $7E
        phx
        phy
        ldx #$008E

        _9C06
        lda @l aDeploymentTable,x
        bit #$0080
        beq _9C2F
        bit #$0040
        bne _9C2F
        and #$0003
        clc
        adc #$000C
        sta wR2
        lda @l aDeploymentTable._XTilePosition,x
        sta wR0
        lda @l aDeploymentTable._YTilePosition,x
        sta wR1
        jsr rsClearMinimapDot
        jsr rsPutMinimapDot

        _9C2F
        dec x
        dec x
        bpl _9C06
        ply
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 88/9C38

    .endsection Unsorted889BF7Section


    .section ProcScript889C52Section

      .al
      .xl

      procMinimapClose ; 88/9C52

        .structProcInfo "MC", rlProcMinimapCloseInit, rlProcMinimapCloseLoadWindowGraphics, aProcMinimapCloseCode

    .endsection ProcScript889C52Section


    .section Unsorted889C5ASection

      .al
      .xl

      rlProcMinimapCloseInit ; 88/9C5A

        .al
        .xl
        .autsiz
        .databank ?

        ; Restores the colour math, clears the minimap tilemap and puts the cursor back on screen.

        phx
        sep #$20
        lda #$15
        sta bBufferTM
        lda #$00
        sta bBufferTS
        lda #$00
        sta bBufferCGWSEL
        lda #$00
        sta bBufferCGADSUB
        lda #$20
        sta bBufferCOLDATA_1
        lda #$40
        sta bBufferCOLDATA_2
        lda #$80
        sta bBufferCOLDATA_3
        rep #$20
        ldx #$07FE
        lda #$00FF

        _9C81
        sta aBG2TilemapBuffer.Page1,x
        dec x
        dec x
        bpl _9C81
        jsl rlDMAByStruct

          .structDMAToVRAM $7E7C88, $0500, $80, $A900

        lda #$001D
        jsl rlPlaySoundEffect
        lda wCursorXOffset,b
        clc
        adc wMapXOffset,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR10
        lda wCursorYOffset,b
        clc
        adc wMapYOffset,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR11
        lda wUnknown000D79,b
        bit #$0800
        bne _9CDF
        jsl rlUnknown88BFC3
        lda wR10
        cmp #$FFFF
        beq _9CD6
        lda wR10
        sta wCursorXOffset,b
        lda wR11
        sta wCursorYOffset,b
        bra _9CDF


        _9CD6
        lda #$0080
        sta wCursorXOffset,b
        sta wCursorYOffset,b

        _9CDF
        plx
        rtl

        .databank 0

        ; 88/9CE1

      rlProcMinimapCloseLoadWindowGraphics ; 88/9CE1

        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsl rlLoadWindowGraphics
        plx
        lda #<>rlProcMinimapCloseLoadGraphics1
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 88/9CEE

    .endsection Unsorted889C5ASection


    .section Unsorted889CEESection

      .al
      .xl

      rlProcMinimapCloseLoadGraphics1 ; 88/9CEE

        .al
        .xl
        .autsiz
        .databank ?

        phx
        sep #$20
        rep #$10
        ldx #<>gcUnknownC01FBA
        stx DecompressionVariables
        lda #`gcUnknownC01FBA
        sta $CA
        ldx #$8B88
        stx $CB
        lda #$7E
        sta $CD
        rep #$30
        jsl rlDecompressor
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $0400, $80, $6800

        plx
        lda #<>rlProcMinimapCloseLoadGraphics2
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 88/9D20

    .endsection Unsorted889CEESection


    .section Unsorted889D20Section

      .al
      .xl

      rlProcMinimapCloseLoadGraphics2 ; 88/9D20

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phx
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

        jsl rlLoadDefaultWindowBorderPalette
        lda #(`aMinimapCastleNameTilemapInfo)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aMinimapCastleNameTilemapInfo
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda #(`aMinimapCloseBlankText)<<8
        sta lRoutineVariable+1,b
        lda #<>aMinimapCloseBlankText
        sta lRoutineVariable,b
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$040D
        jsl rlDrawMenuTextLine
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8488, $0080, $80, $B100

        plx
        lda #<>rlProcMinimapCloseFinish
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 88/9D92

    .endsection Unsorted889D20Section


    .section Table889D92Section

      .al
      .xl

      aMinimapCloseBlankText ; 88/9D92

        .enc "SJIS"
        .text "　　　　　　　　　"
        .word $0000
        .enc "none"


    .endsection Table889D92Section


    .section Unsorted889DA6Section

      .al
      .xl

      rlProcMinimapCloseFinish ; 88/9DA6

        .al
        .xl
        .autsiz
        .databank ?

        ; Clears the minimap flag and ends the proc. After a warp destination was chosen, uses the warp staff on it (rlUnknown84DC1C), from the map or from the castle grid; after a cancel, reopens the unit menu or returns to the castle grid.

        lda #$0020
        trb wMapSystemFlags,b
        jsl rlProcEngineFreeProc
        lda wUnknown000D79,b
        bit #$0800
        beq _9E0B
        lda wMapSystemFlags,b
        bit #$4000
        beq _9DF3
        lda #$4000
        trb wMapSystemFlags,b
        lda wActiveUnitDeploymentOffset,b
        sta wR0
        lda wMapTargetDeploymentOffset,b
        sta wR1
        lda wCastleCursorX,b
        sta wR2
        lda wCastleCursorY,b
        sta wR3
        lda wMapOverlayFlags,b
        bit #$0008
        bne _9E0C
        jsl rlUnknown84DC1C
        lda #$0800
        trb wUnknown000D79,b
        lda #$0008
        tsb wMapSystemFlags,b
        rtl


        _9DF3
        lda #$0800
        trb wUnknown000D79,b
        lda wMapOverlayFlags,b
        bit #$0008
        bne _9E34
        lda #$0008
        tsb wMapSystemFlags,b
        jsl rlOpenUnitMenu

        _9E0B
        rtl


        _9E0C
        ldx wActiveUnitDeploymentOffset,b
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        lda wCastleGridSlot,b
        asl a
        tax
        lda $7F757A,x
        asl a
        tax
        lda $7F75AA,x
        beq _9DF3
        sta wRoutineVariable1,b
        jsl rlBuildCastleActionRounds
        lda #$0800
        trb wUnknown000D79,b

        _9E34
        stz wCastleCursorState,b
        lda wCastleGridSavedSlot,b
        sta wCastleGridSlot,b
        asl a
        tax
        lda aCastleGridCursorX,x
        sta wCastleGridCursorXPixel,b
        lda aCastleGridCursorY,x
        sta wCastleGridCursorYPixel,b
        jsl rlCastleDrawInfoLine
        ldx #$00FE

        _9E54
        lda aUnknown8C9800,x
        sta aBGPaletteBuffer,b,x
        dec x
        dec x
        bpl _9E54
        stz wMovingUnitSpriteState,b
        lda #$0008
        trb wMapOverlayFlags,b
        stz wMapActionMode,b
        rtl

        .databank 0

        ; 88/9E6C

    .endsection Unsorted889DA6Section


    .section ProcScript889E6CSection

      .al
      .xl

      aProcMinimapCloseCode ; 88/9E6C

        PROC_HALT


        ; 88/9E6E

    .endsection ProcScript889E6CSection


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

        stz wUnknown000758,b
        jsr rsUpdateMapSystemFlags

        stz wUnknown00073A,b
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

        lda bUnknown000E7B,b
        and #$00FF
        bit #$0041
        beq ++

          lda wMapActionActiveFlag,b
          bpl +

            jsr rsUnknown88C71C
          
          +
          jml rlUnknown88C4D9

        +
        lda wUnknown00171A,b
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
        lda wMapOverlayFlags,b
        bit #$0002
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

          stz wUnknown0007E2,b

          jsl rlUnknown88C9A6

          lda wMapOverlayFlags,b
          bit #$0008
          bne +

            jsl rlUnknown84B32B

            lda #$0002
            trb wMapOverlayFlags,b

            lda #$0004
            tsb wMapOverlayFlags,b
            bra _A234

          +
          lda #$0002
          trb wMapOverlayFlags,b

          jsl rlUseCastleGridStaff

        _A234
        lda wUnknown0007D8,b
        beq _A24F

          cmp #$FFFF
          beq ++

            cmp #$0003
            beq +

              jml rlMapCursorMoveStep
            
            +
            jml rlMapChooseTargetStep
          
          +
          jml _A2BD

        _A24F
        lda wUnknown000766,b
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
            sta wUnknown000766,b
            stz wUnknown00073A,b
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

          stz wUnknown000766,b
          stz wUnknown00073A,b
          stz wMapEnableXScrollFlag,b
          stz wMapEnableYScrollFlag,b
          lda #1
          sta wUnknown000758,b

        +
        jsl rlUnknown88BC05

        lda wMapScrollCurrentPixelDistance,b
        cmp wMapScrollSpeed,b
        bne _A2BD

          jsr rsUnknown88BEEF

        _A2BD
        sep #$20
        lda #$88
        pha
        plb
        rep #$20

        ldy #$EE52
        lda wCursorXOffset,b
        sta $00
        lda wCursorYOffset,b
        sta $02
        lda #$2000
        sta $0A
        lda #0
        sta $08

        lda wUnknown000770,b
        beq +

          lda #4
          sta $08
        
        +
        lda $DB
        and #$0018
        beq +

          ldy #$EE3C

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

        ; For a staff chosen on the castle grid (target already picked): uses it at once (rlUnknown84DC1C) and clears the castle flags.

        lda #$0000
        sta wUnknown0007D8,b
        lda wActiveUnitDeploymentOffset,b
        sta wR0
        lda wMapTargetDeploymentOffset,b
        sta wR1
        lda #$0004
        trb wMapOverlayFlags,b
        lda wMapScrollXPixels,b
        sta wMapXOffset,b
        lda wMapScrollYPixels,b
        sta wMapYOffset,b
        lda #$0008
        trb wMapOverlayFlags,b
        jsl rlCloseBattleForecast
        jsl rlUnknown84DC1C
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
          sta wUnknown000758,b
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
        lda wUnknown000770,b
        bne +

          lda wMapOverlayFlags,b
          bne +

            lda wMapActionMode,b
            beq ++
        
        +
        lda #$0002
        tsb wMapSystemFlags,b

        +
        lda wUnknown0007D8,b
        beq +

          lda #$0004
          tsb wMapSystemFlags,b
        
        +
        lda wUnknown00171A,b
        beq +

          lda #$0010
          tsb wMapSystemFlags,b

        +
        rts

        .databank 0

        ; 88/A383

    .endsection Unsorted88A32DSection


    .section Unsorted88A38CSection

      .al
      .xl

      rlCheckMapCursorResting ; 88/A38C

        .al
        .xl
        .autsiz
        .databank ?

        ; Carry set if the cursor has just come to rest on a tile (wMapCursorResting).

        lda wUnknown000758,b
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

        stz wUnknown000758,b
        lda wUnknown000766,b
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
        sta wUnknown000766,b
        stz wUnknown00073A,b
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
        stz wUnknown000766,b
        stz wUnknown00073A,b
        stz wMapEnableXScrollFlag,b
        stz wMapEnableYScrollFlag,b
        lda #$0001
        sta wUnknown000758,b

        _A407
        jsl rlUnknown88BC05

        _A40B
        sep #$20
        lda #$88
        pha
        plb
        .databank $88
        rep #$20
        ldy #$EE52
        lda wCursorXOffset,b
        sta wR0
        lda wCursorYOffset,b
        sta wR1
        lda #$2000
        sta wR5
        lda #$0000
        sta wR4
        lda wUnknown000770,b
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

        lda wUnknown000770,b
        beq _A4BB
        lda wVBlankEnabledFramecount
        and #$0078
        lsr a
        lsr a
        tax
        lda aUnknown88A4BC,x
        clc
        adc #$2E29
        sta $0112,b
        lda aUnknown88A4BC,x
        clc
        adc #$00C1
        sta $0114,b
        lda aUnknown88A4DC,x
        clc
        adc #$1E18
        sta $011A,b
        lda aUnknown88A4DC,x
        clc
        adc #$0018
        sta $011C,b
        lda aAIAction.wMapPointer
        bne _A4A3
        lda aUnknown88A4DC,x
        clc
        adc #$1318
        sta $010A,b
        lda aUnknown88A4DC,x
        clc
        adc #$0210
        sta $010C,b
        bra _A4BB


        _A4A3
        lda aUnknown88A4DC,x
        clc
        adc #$1940
        sta $010A,b
        lda aUnknown88A4DC,x
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

      aUnknown88A4BC ; 88/A4BC

        ; Read by rlAnimateRangeOverlayPalette.

        .word $0000, $0421, $0842, $0C63, $1084, $14A5, $18C6, $1CE7
        .word $1CE7, $18C6, $14A5, $1084, $0C63, $0842, $0421, $0000

        ; 88/A4DC

      aUnknown88A4DC ; 88/A4DC

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

    .endsection Unsorted88A4FCSection


    .section Unsorted88A551Section

      .al
      .xl

      rsGetMapCursorMove ; 88/A551

        .al
        .xl
        .autsiz
        .databank ?

        ; Puts the D-pad direction in wMapScrollDirectionIdentifier and returns carry set if the cursor moves (Y held skips the repeat delay). While a unit is selected, a held (not newly pressed) direction stops at the edge of its movement range. | Moves the cursor one tile in the D-pad direction, scrolling the map when the cursor is near the edge; returns carry set when the map has to scroll.

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
        lda wUnknown000770,b
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
        cmp $071E,b
        bcc _A696
        cmp $0722,b
        bcs _A696
        lda wTempVariable1,b
        cmp $071C,b
        bcc _A696
        cmp $0720,b
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

      rsUnknown88A698 ; 88/A698

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

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
        ldy #$A74D
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

        .byte $00, $00, $00, $00, $01, $00, $01, $00, $00, $00, $00, $00, $FF, $FF, $FF, $FF
        .byte $01, $00, $00, $C2, $00, $02, $30

        ; 88/A754

    .endsection Table88A73DSection


    .section Unsorted88A754Section

      .al
      .xl

      rlMapCursorMoveStep ; 88/A754

        .al
        .autsiz
        .databank $00

        lda wUnknown000766,b
        bne _A7BA

          lda wUnknown0007D8,b
          cmp #2
          beq _A788

            cmp #4
            beq _A795

              cmp #5
              beq _A795

                cmp #6
                beq _A795

                  cmp #7
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
          sta wUnknown000766,b
          stz wUnknown00073A,b
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

          stz wUnknown000766,b
          stz wUnknown00073A,b
          stz wMapEnableXScrollFlag,b
          stz wMapEnableYScrollFlag,b
        
        +
        jsl rlUnknown88BC05

        lda wUnknown0007D8,b
        cmp #2
        bne _End

          jsl rlUnknown88C0B3

        _End
        rtl

        .databank 0

        ; 88/A7F5

    .endsection Unsorted88A754Section


    .section Unsorted88A7F5Section

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

    .endsection Unsorted88A7F5Section


    .section Unsorted88A81DSection

      .al
      .xl

      rlMapChooseTargetStep ; 88/A81D

        .al
        .xl
        .autsiz
        .databank ?

        ; Cursor state 3, choosing a target: the D-pad picks the next target (rsSelectNextTarget) and shows the battle forecast, A acts (rlUnknown84DC1C, or the minimap for a warp destination), B goes back to the unit menu or, for a castle staff, puts the unit back in the castle.

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
        stz wUnknown0007D8,b
        lda wMapOverlayFlags,b
        bit #$0004
        bne _A85D
        lda #$0008
        tsb wMapSystemFlags,b
        jsl rlCloseBattleForecast
        jsl rlOpenUnitMenu
        lda #$0800
        trb wUnknown000D79,b
        rtl


        _A85D
        lda #$0040
        trb wUnknown000D79,b
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
        lda #$0004
        trb wMapOverlayFlags,b
        ldx wActiveUnitDeploymentOffset,b
        jsl rlUnknown84CC5D
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
        jsl rlUnknown88BFC3
        lda wR10
        bmi _A8DD
        sta wCursorXOffset,b
        lda wR11
        sta wCursorYOffset,b
        bra _A8EB


        _A8DD
        lda wMapTargetDeploymentOffset,b
        jsl rlMoveCursorToUnit
        lda #$0006
        sta wUnknown0007D8,b
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
        ldy #$EE52
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
        lda #$0000
        sta wUnknown0007D8,b
        lda wActiveUnitDeploymentOffset,b
        sta wR0
        lda wMapTargetDeploymentOffset,b
        sta wR1
        lda #$0004
        trb wMapOverlayFlags,b
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
        lda wUnknown000D79,b
        bit #$0800
        bne _A994
        jsl rlCloseBattleForecast
        jsl rlUnknown84DC1C
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

      rsMoveCursorBackToUnit ; 88/A9B4

        .al
        .xl
        .autsiz
        .databank ?

        ; Cursor state 1: one tile at a time towards the unit's start; there, sets state 2 to walk the unit along its path.

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
        stz wUnknown00073A,b
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
        lda #$0002
        sta wUnknown0007D8,b
        lda #$FFFF
        sta wMapScrollDirectionIdentifier,b
        jsl rlUnknown88C085
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

        lda wMapScrollScriptOffset,b
        bmi _AA8A
        tax
        lda $0794,b,x
        sta wR0
        beq _AA8A
        cmp #$0001
        beq _AA3F
        cmp #$0002
        beq _AA4A
        cmp #$0003
        beq _AA55
        cmp #$0004
        beq _AA60

        _AA3F
        lda #$0018
        sta wUnknown0007E2,b
        lda #$0400
        bra _AA6B


        _AA4A
        lda #$0010
        sta wUnknown0007E2,b
        lda #$0800
        bra _AA6B


        _AA55
        lda #$0008
        sta wUnknown0007E2,b
        lda #$0100
        bra _AA6B


        _AA60
        lda #$0000
        sta wUnknown0007E2,b
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
        jsl rlUnknown88C126
        lda #$0002
        sta wMovingUnitSpriteState,b
        stz wUnknown0007D8,b
        stz wMapScrollScriptOffset,b
        stz wUnknown00073A,b
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
        cmp #$0004
        beq _AAEF
        cmp #$0005
        beq _AAEF
        cmp #$0009
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
        jsl rlUnknown84D483
        bcc _AB00
        jsl rlUnknown84CAA9
        stz wMapActionMode,b
        lda #$0000
        rts


        _AB00
        lda wMapActionMode,b
        cmp #$0004
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
        lda $0794,b,x
        cmp wR0
        beq rsMergePathSteps

        _AB2B
        rts

        .databank 0

        ; 88/AB2C

    .endsection Unsorted88A81DSection


    .section Unsorted88AB2CSection

      .al
      .xl

      rsUnknown88AB2C ; 88/AB2C

        ; Found by tools/sweep.py: nothing in the build reaches this.
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

      rsUnknown88AC5B ; 88/AC5B

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

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
        jsr rsUnknown88ACA6
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

      rsUnknown88ACA6 ; 88/ACA6

        .al
        .xl
        .autsiz
        .databank ?

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

        lda #$0003
        sta wUnknown0007D8,b
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
        jsl rlUnknown88BFC3
        lda wR10
        bmi _AD94
        sta wCursorXOffset,b
        lda wR11
        sta wCursorYOffset,b
        bra _ADA1


        _AD94
        lda wMapTargetDeploymentOffset,b
        jsl rlMoveCursorToUnit
        lda #$0006
        sta wUnknown0007D8,b

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

        stz wUnknown0007D8,b
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
        lda #$0008
        sta wUnknown0007D8,b
        lda wMapActionMode,b
        beq _ADE2
        lda #$0005
        sta wMapActionMode,b
        rtl


        _ADE2
        lda #$0009
        sta wMapActionMode,b
        rtl

        .databank 0

        ; 88/ADE9

    .endsection Unsorted88ADC9Section


    .section Unsorted88ADE9Section

      .al
      .xl

      rlUndoUnitMove ; 88/ADE9

        .al
        .xl
        .autsiz
        .databank ?

        ; B in the unit menu: puts the active unit back on its start tile (wMapCursorXTile/YTile) and sends the cursor to it, by wMapActionMode.

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
        lda #$0007
        sta wUnknown0007D8,b
        rtl


        _AE41
        lda wMapActionMode,b
        cmp #$0005
        beq _AE70
        lda wMapStateFlags,b
        bit #$0008
        bne _AE76
        jsl rlUnknown87BB27
        bcc _AE76
        lda wMapActionMode,b
        cmp #$0002
        beq _AEB3
        cmp #$0003
        beq _AEC8
        cmp #$0004
        beq _AE1A
        cmp #$0009
        beq _AEB1
        bra _AE9C


        _AE70
        lda #$0001
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
        lda #$0007
        sta wUnknown0007D8,b
        rtl


        _AE9C
        ldx wActiveUnitDeploymentOffset,b
        jsl rlDeployedUnitUnsetHiddenIfAlive
        stz wMovingUnitSpriteState,b
        ldx wActiveUnitDeploymentOffset,b
        jsl rlUnknown84CC5D
        stz wMapActionMode,b
        rtl


        _AEB1
        bra _AEFE


        _AEB3
        ldx wActiveUnitDeploymentOffset,b
        jsl rlDeployedUnitUnsetHiddenIfAlive
        stz wMovingUnitSpriteState,b
        ldx wActiveUnitDeploymentOffset,b
        jsl rlUnknown84CFBF
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
        jsl rlUnknown84CC5D
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
        lda #$0007
        sta wUnknown0007D8,b
        rtl

        .databank 0

        ; 88/AF4C

    .endsection Unsorted88ADE9Section


    .section Unsorted88AF4CSection

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
        sta wUnknown00076C,b

        lda wCursorYOffset,b
        clc
        adc wMapScrollYPixels,b
        sta wUnknown00076E,b

        lda #1
        sta wMovingUnitSpriteState,b
        stz wMovingUnitSpriteFrame,b
        stz wMovingUnitSpriteTimer,b

        jsl rlDeployedUnitSetHidden

        stz wUnknown0007E2,b
        jsl rlUnknown88C9A6
        rtl

        .databank 0

    .endsection Unsorted88AF4CSection


    .section Unsorted88AF7BSection

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

          sta $00089B
        
        +
        ldx wActiveUnitDeploymentOffset,b
        jsl rlDeployedUnitUnsetHiddenIfAlive

        ldx wActiveUnitDeploymentOffset,b
        lda aDeploymentTable._State,x
        bit #DeploymentStateCanto
        bne +

          lda bUnknown000E7B,b
          and #$00FF
          bit #$0041
          bne +

            lda wActiveUnitDeploymentOffset,b
            jsl rlMoveCursorToUnit

        +
        plx
        rtl

        .databank 0

    .endsection Unsorted88AF7BSection


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


    .section Unsorted88B3AFSection

      .al
      .xl

      rlSaveMapCameraAndLockCursor ; 88/B3AF

        .al
        .xl
        .autsiz
        .databank ?

        ; Sets wMapCursorState to $FFFF (the cursor only draws) and saves the camera in wMapXOffset/wMapYOffset, before leaving the map for a conversation.

        lda #$FFFF
        sta wUnknown0007D8,b
        lda wMapScrollXPixels,b
        sta wMapXOffset,b
        lda wMapScrollYPixels,b
        sta wMapYOffset,b
        rtl

        .databank 0

        ; 88/B3C2

    .endsection Unsorted88B3AFSection


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
        jsl rlUnknown88C059
        lda wR10
        sta wR0
        lda wR11
        sta wR1
        jsl rlUnknown88BF37
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
        lda #$0005
        sta wUnknown0007D8,b
        lda wMapActionMode,b
        cmp #$8002
        beq _B44F
        cmp #$8003
        beq _B456
        cmp #$8004
        beq _B45D
        lda #$0001
        sta wMapActionMode,b
        rtl


        _B44F
        lda #$0002
        sta wMapActionMode,b
        rtl


        _B456
        lda #$0003
        sta wMapActionMode,b
        rtl


        _B45D
        lda #$0004
        sta wMapActionMode,b
        lda #$0008
        sta wUnknown0007D8,b
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
        lda bUnknown000E7B,b
        and #$00FF
        bit #$0041
        beq _B48D
        lda wMapPanTargetDeploymentOffset,b
        sta wActiveActionUnit1DeploymentOffset,b
        sta wActiveUnitDeploymentOffset,b
        lda #$0001
        sta wMapActionActiveFlag,b
        lda #$0002
        tsb bUnknown000E7B,b

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
        lda #$0004
        sta wUnknown0007D8,b
        lda bUnknown000E7B,b
        and #$00FF
        bit #$0041
        bne _B4D4
        rtl


        _B4D4
        lda #$0001
        sta wUnknown0007D8,b
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

        lda #$0004
        sta wUnknown0007D8,b
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
        lda wUnknown0007D8,b
        cmp #5
        beq _B6A6

          cmp #6
          beq _B6B6

            cmp #7
            beq _B6D4

              stz wUnknown00073A,b
              stz wMapScrollScriptOffset,b
              stz wUnknown0007D8,b
              lda #$0004
              trb wMapSystemFlags,b
              lda #0
              rts
        
        _B6A6
        stz wUnknown00073A,b
        stz wMapScrollScriptOffset,b
        stz wUnknown0007D8,b
        jsr rsSelectUnitAtCursor
        lda #0
        rts

        _B6B6
        stz wUnknown00073A,b
        stz wMapScrollScriptOffset,b
        lda #3
        sta wUnknown0007D8,b
        lda wActiveUnitDeploymentOffset,b
        sta $00
        lda wMapTargetDeploymentOffset,b
        sta $02
        jsl rlShowBattleForecast
        lda #0
        rts

        _B6D4
        stz wUnknown00073A,b
        stz wMapScrollScriptOffset,b
        stz wUnknown0007D8,b
        lda wMapStateFlags,b
        bit #$0008
        bne +

          jsr rsSelectUnitAtCursor
          lda #0
          rts

        +
        ldx wActiveUnitDeploymentOffset,b
        jsl rlUnknown84D4A2
        lda #$0008
        tsb wMapSystemFlags,b
        lda #0
        rts

        .databank 0

        ; 88/B6FD

    .endsection Unsorted88B64FSection


    .section Unsorted88B6FDSection

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
        sta wUnknown00076C,b
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
        sta wUnknown00076E,b
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
        inc wUnknown000770,b
        lda #$0002
        tsb wMapSystemFlags,b
        jsl rlMapMenuEmptyHook
        lda #$0001
        sta wMovingUnitSpriteState,b
        stz wMovingUnitSpriteFrame,b
        stz wMovingUnitSpriteTimer,b
        stx wActiveUnitDeploymentOffset,b
        jsl rlDeployedUnitSetHidden
        stz wUnknown0007E2,b
        jsl rlUnknown88C9A6
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
        lda bUnknown000E7B,b
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
        stz wUnknown000770,b
        lda #$0002
        sta wMovingUnitSpriteState,b
        stz wUnknown0007D8,b
        stz wMapScrollScriptOffset,b
        stz wUnknown00073A,b
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
        sta $071C,b
        clc
        adc #$0040
        sta $0720,b
        lda wTempVariable2,b
        sec
        sbc #$0020
        sta $071E,b
        clc
        adc #$0040
        sta $0722,b
        lda $071C,b
        bpl _B8D1
        stz $071C,b

        _B8D1
        lda $071E,b
        bpl _B8D9
        stz $071E,b

        _B8D9
        lda bUnknown000E7B,b
        and #$00FF
        bit #$0041
        bne _B8E8
        jsl rlRedrawRangeOverlayTilemap

        _B8E8
        rts

        .databank 0

        ; 88/B8E9

      rsUnknown88B8E9 ; 88/B8E9

        .al
        .xl
        .autsiz
        .databank ?

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
        jsl rlUnknown88BF37
        tax
        lda aMapData,x
        and #$03FF
        tax
        lda aTerrainTileset,x
        and #$00FF
        lda wTempVariable2,b
        cmp $071E,b
        bcc _B95E
        cmp $0722,b
        bcs _B95E
        lda wTempVariable1,b
        cmp $071C,b
        bcc _B95E
        cmp $0720,b
        bcs _B95E
        jsr rsGetMovementMapRowIndex
        lda aMovementMap,x
        bit #$0080
        bne _B95E
        and #$007F
        beq _B95E
        sta $0792,b
        jsr rsUnknown88B960
        bmi _B95E
        jsr rsUnknown88BBD3
        jsr rsUnknown88B992
        clc
        rts


        _B95E
        sec
        rts

        .databank 0

        ; 88/B960

      rsUnknown88B960 ; 88/B960

        .al
        .xl
        .autsiz
        .databank ?

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

      rsUnknown88B992 ; 88/B992

        .al
        .xl
        .autsiz
        .databank ?

        lda wVBlankEnabledFramecount
        and #$0001
        beq _B99D
        jml _BAB8


        _B99D
        ldx #$0040

        _B9A0
        stz $0794,b,x
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
        lda #$0001
        sta $0794,b,y
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
        lda #$0002
        sta $0794,b,y
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
        lda #$0003
        sta $0794,b,y
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
        lda #$0004
        sta $0794,b,y
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
        lda #$0001
        sta wUnknown0007D8,b
        rts


        _BAB8
        ldx #$0040

        _BABB
        stz $0794,b,x
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
        lda #$0003
        sta $0794,b,y
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
        lda #$0004
        sta $0794,b,y
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
        lda #$0001
        sta $0794,b,y
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
        lda #$0002
        sta $0794,b,y
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
        lda #$0001
        sta wUnknown0007D8,b
        rts

        .databank 0

        ; 88/BBD3

      rsUnknown88BBD3 ; 88/BBD3

        .al
        .xl
        .autsiz
        .databank ?

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
        stz wUnknown000770,b
        rts

        .databank 0

        ; 88/BC05

    .endsection Unsorted88B6FDSection


    .section Unsorted88BC05Section

      .al
      .xl

      rlUnknown88BC05 ; 88/BC05

        .al
        .autsiz
        .databank ?

        lda #$0001
        trb $0764,b

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
        jsr rsUnknown88BC63
        rtl
        
        _0100
        jsr rsUnknown88BD09
        rtl
        
        _0800
        jsr rsUnknown88BDA1
        rtl
        
        _0400
        jsr rsUnknown88BE57
        rtl
        
        _0A00
        jsr rsUnknown88BC63
        jsr rsUnknown88BDA1
        rtl
        
        _0600
        jsr rsUnknown88BC63
        jsr rsUnknown88BE57
        rtl
        
        _0900
        jsr rsUnknown88BD09
        jsr rsUnknown88BDA1
        rtl
        
        _0500
        jsr rsUnknown88BD09
        jsr rsUnknown88BE57
        rtl

        .databank 0

      rsUnknown88BC63 ; 88/BC63

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
        tsb $0764,b
        rts
        
        +
        lda wCursorXOffset,b
        sec
        sbc wMapScrollSpeed,b
        cmp #$0010
        bcc _BCF4

        sta wCursorXOffset,b
        lda #$0001
        tsb $0764,b
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
        sta wUnknown00073A,b
        sta wMapEnableXScrollFlag,b
        lda #$0001
        tsb $0764,b
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

      rsUnknown88BD09 ; 88/BD09

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
            tsb $0764,b
            rts

        +
        lda wCursorXOffset,b
        clc
        adc wMapScrollSpeed,b
        cmp #$00E1
        bcs _BD8C

          sta wCursorXOffset,b
          lda #$0001
          tsb $0764,b
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
        sta wUnknown00073A,b
        sta wMapEnableXScrollFlag,b
        lda #$0001
        tsb $0764,b
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

      rsUnknown88BDA1 ; 88/BDA1

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
        tsb $0764,b
        rts


        _BDBF
        lda wCursorYOffset,b
        sec
        sbc wMapScrollSpeed,b
        cmp #$0010
        bcc _BE42
        sta wCursorYOffset,b
        lda #$0001
        tsb $0764,b
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
        sta wUnknown00073A,b
        sta wMapEnableYScrollFlag,b
        lda #$0001
        tsb $0764,b
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

      rsUnknown88BE57 ; 88/BE57

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
        tsb $0764,b
        rts


        _BE75
        lda wCursorYOffset,b
        clc
        adc wMapScrollSpeed,b
        cmp #$00C1
        bcs _BEDA
        sta wCursorYOffset,b
        lda #$0001
        tsb $0764,b
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
        sta wUnknown00073A,b
        sta wMapEnableYScrollFlag,b
        lda #$0001
        tsb $0764,b
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

      rsUnknown88BEEF ; 88/BEEF

        .al
        .xl
        .autsiz
        .databank ?

        lda $0764,b
        bit #$0001
        beq _BEFE
        lda #$0005
        jsl rlPlaySoundEffect

        _BEFE
        rts

        .databank 0

        ; 88/BEFF

    .endsection Unsorted88BDA1Section


    .section Unsorted88BF37Section

      .al
      .xl

      rlUnknown88BF37 ; 88/BF37

        .al
        .xl
        .autsiz
        .databank ?

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

      rlUnknown88BF6C ; 88/BF6C

        .al
        .xl
        .autsiz
        .databank ?

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

      rlUnknown88BF97 ; 88/BF97

        .al
        .xl
        .autsiz
        .databank ?

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

      rlUnknown88BFC3 ; 88/BFC3

        .al
        .xl
        .autsiz
        .databank ?

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

      rlUnknown88BFFA ; 88/BFFA

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

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


    .section Unsorted88C072Section

      .al
      .xl

      rlUnknown88C072 ; 88/C072

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

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


    .section Unsorted88C085Section

      .al
      .xl

      rlUnknown88C085 ; 88/C085

        .al
        .xl
        .autsiz
        .databank ?

        ldx wActiveUnitDeploymentOffset,b
        lda aDeploymentTable._DeploymentOffsets,x
        tax
        lda aDeploymentTable._MapSpriteID,x
        jsl rlGetMapSpriteMovementSound
        sep #$20
        sta aSoundChannelFadeState.bMode,b
        stz aSoundChannelFadeTarget,b
        lda wCursorXOffset,b
        sta aSoundChannelFadeState.bLevel,b
        rep #$20
        jsl rlUnknown88C0D5
        sep #$20
        lda wR0
        sta aSoundChannelFadeState.bFlags,b
        rep #$20
        rtl

        .databank 0

        ; 88/C0B3

      rlUnknown88C0B3 ; 88/C0B3

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown88C0D5
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

      rlUnknown88C0D5 ; 88/C0D5

        .al
        .xl
        .autsiz
        .databank ?

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
        jsl rlUnknown88BF37
        tax
        lda aMapData,x
        and #$03FF
        tax
        lda aTerrainTileset,x
        and #$00FF
        cmp #$0005
        beq _C120
        cmp #$0006
        beq _C120
        cmp #$0010
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

      rlUnknown88C126 ; 88/C126

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

    .endsection Unsorted88C085Section


    .section Unsorted88C1BFSection

      .al
      .xl

      rsUnknown88C1BF ; 88/C1BF

        .al
        .xl
        .autsiz
        .databank ?

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

      rlUnknown88C25D ; 88/C25D

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

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

      rlUnknown88C2BA ; 88/C2BA

        .al
        .xl
        .autsiz
        .databank ?

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

      rlUnknown88C355 ; 88/C355

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda wCursorXOffset,b
        sta wR10
        lda wCursorYOffset,b
        sta wR11
        jsl rlUnknown88C059
        jsl rlUnknown88BFC3
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


    .section Unsorted88C4D9Section

      .al
      .xl

      rlUnknown88C4D9 ; 88/C4D9

        .al
        .xl
        .autsiz
        .databank ?

        ; Reached with jml from rlMapCursorStepInner. Steps through states 0-4 in
        ; wUnknown0007D8 and sets up the map scroll distance and speed, then
        ; draws a sprite at the cursor. What the states mean is not known yet.

        lda wUnknown000766,b
        beq _C4E2
        jml _C61E


        _C4E2
        lda wUnknown0007D8,b
        beq _C4FF
        cmp #$0001
        beq _C507
        cmp #$0002
        beq _C53B
        cmp #$0003
        beq _C503
        cmp #$0004
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
        lda bUnknown000E7B,b
        and #$00FF
        bit #$0002
        bne _C52E
        jsr rsUnknown88C67D
        jml _C658


        _C52E
        lda #$0000
        sta wUnknown0007D8,b
        sta wMapActionActiveFlag,b
        jml _C658


        _C53B
        jsl rlUnknown88C0B3
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
        lda #$0003
        sta wUnknown0007D8,b
        lda wCursorXOffset,b
        clc
        adc wMapScrollXPixels,b
        sta wUnknown00076C,b
        lda wCursorYOffset,b
        clc
        adc wMapScrollYPixels,b
        sta wUnknown00076E,b
        lda #$0001
        sta wMovingUnitSpriteState,b
        bra _C5AA


        _C592
        lda #$0000
        sta wUnknown0007D8,b
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
        lda #$0004
        sta wUnknown0007D8,b
        jml _C658


        _C5D2
        lda wMapScrollScriptOffset,b
        sec
        sbc #$0001
        sta wMapScrollScriptOffset,b
        bmi _C5E0
        bra _C659


        _C5E0
        lda #$0000
        sta wUnknown0007D8,b
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
        sta wUnknown000766,b
        stz wUnknown00073A,b
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
        stz wUnknown000766,b
        stz wUnknown00073A,b
        stz wMapEnableXScrollFlag,b
        stz wMapEnableYScrollFlag,b

        _C648
        jsl rlUnknown88BC05
        lda wUnknown0007D8,b
        cmp #$0002
        bne _C658
        jsl rlUnknown88C0B3

        _C658
        rtl


        _C659
        sep #$20
        lda #$88
        pha
        plb
        .databank $88
        rep #$20
        ldy #$EE52
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

    .endsection Unsorted88C4D9Section


    .section Unsorted88C67DSection

      .al
      .xl

      rsUnknown88C67D ; 88/C67D

        ; TRACE: odd-opcode
        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown88C733
        lda wMapScrollXPixels,b
        sta wUnknown000734,b
        lda wMapScrollYPixels,b
        sta wUnknown000736,b
        lda wCursorXOffset,b
        sta wUnknown00076C,b
        lda wCursorYOffset,b
        sta wUnknown00076E,b
        lda #$0000
        sta wCursorXOffset,b
        lda wActiveActionDestinationX,b
        sta wMapScrollXPixels,b
        lda #$0000
        sta wCursorYOffset,b
        lda wActiveActionDestinationY,b
        sta wMapScrollYPixels,b
        jsr rsUnknown88B8E9
        bcc _C6B6
        .byte $00 ; brk

        _C6B6
        lda wUnknown000734,b
        sta wMapScrollXPixels,b
        lda wUnknown000736,b
        sta wMapScrollYPixels,b
        lda wUnknown00076C,b
        sta wCursorXOffset,b
        lda wUnknown00076E,b
        sta wCursorYOffset,b
        lda #$0002
        sta wUnknown0007D8,b
        lda #$FFFF
        sta wMapScrollDirectionIdentifier,b
        jsl rlUnknown88C085
        lda wSavedMapScrollScriptOffset,b
        dec a
        dec a
        sta wMapScrollScriptOffset,b
        lda #$0002
        sta wMovingUnitSpriteState,b
        rts

        .databank 0

        ; 88/C6ED

    .endsection Unsorted88C67DSection


    .section Unsorted88C6EDSection

      .al
      .xl

      rlUnknown88C6ED ; 88/C6ED

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

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
        lda #$0001
        sta wUnknown0007D8,b
        rtl

        .databank 0

        ; 88/C71C

    .endsection Unsorted88C6EDSection


    .section Unsorted88C71CSection

      .al
      .xl

      rsUnknown88C71C ; 88/C71C

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0001
        sta wMapActionActiveFlag,b
        lda wActiveActionUnit1DeploymentOffset,b
        sta wActiveUnitDeploymentOffset,b
        jsl rlMoveCursorToUnit
        lda #$0001
        sta wUnknown0007D8,b
        rts

        .databank 0

        ; 88/C733

      rsUnknown88C733 ; 88/C733

        .al
        .xl
        .autsiz
        .databank ?

        lda wCursorXOffset,b
        clc
        adc wMapScrollXPixels,b
        sta wUnknown00076C,b
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
        sta wUnknown00076E,b
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
        inc wUnknown000770,b
        lda #$0002
        tsb wMapSystemFlags,b
        jsl rlMapMenuEmptyHook
        lda #$0001
        sta wMovingUnitSpriteState,b
        stz wMovingUnitSpriteFrame,b
        stz wMovingUnitSpriteTimer,b
        stx wActiveUnitDeploymentOffset,b
        jsl rlDeployedUnitSetHidden
        stz wUnknown0007E2,b
        jsl rlUnknown88C9A6
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

    .endsection Unsorted88C71CSection


    .section Unsorted88C7CFSection

      .al
      .xl

      rlUnknown88C7CF ; 88/C7CF

        .al
        .xl
        .autsiz
        .databank ?

        phb
        lda wVBlankEnabledFramecount
        jsl rlUnknown88CC75
        plb
        .databank ?
        rtl

        .databank 0

        ; 88/C7D8

    .endsection Unsorted88C7CFSection


    .section Unsorted88C7D8Section

      .al
      .xl

      rsUnknown88C7D8 ; 88/C7D8

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta aMovingMapSpritesMapSprites,b
        lda #$8000
        sta $0869,b
        lda #$0002
        sta $086B,b
        lda #$8002
        sta $086D,b
        lda wUnknown0007E2,b
        sta @l wUnknown000911
        sta @l $000913
        sta @l $000915
        sta @l $000917
        ldx #$0006

        _C806
        lda #$0400
        sta wR5
        jsl rlUnknown88D7FE
        lda wR0
        clc
        adc wCursorXOffset,b
        clc
        adc aUnknown88C834,x
        sta wR0
        lda wR1
        clc
        adc wCursorYOffset,b
        clc
        adc aUnknown88C83C,x
        sta wR1
        phx
        jsl rlPushToOAMBuffer
        plx
        dec x
        dec x
        bpl _C806
        rts

        .databank 0

        ; 88/C834

    .endsection Unsorted88C7D8Section


    .section Table88C834Section

      .al
      .xl

      aUnknown88C834 ; 88/C834

        ; Read by rsUnknown88C7D8.

        .word $0000, $0020, $0030, $0040

        ; 88/C83C

    .endsection Table88C834Section


    .section Data88C83CSection

      .al
      .xl

      aUnknown88C83C ; 88/C83C

        ; Read by rsUnknown88C7D8.

        .word $0000, $0020, $0030, $0040

        ; 88/C844

    .endsection Data88C83CSection


    .section Unsorted88C844Section

      .al
      .xl

      rlUnknown88C844 ; 88/C844

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda wMovingUnitSpriteState,b
        beq _C873
        cmp #$0001
        beq _C89A
        cmp #$0003
        beq _C876
        lda wCursorXOffset,b
        sta wR0
        lda wCursorYOffset,b
        sta wR1
        lda #$0000
        sta wR4
        stz wR5
        jsr rsUnknown88C8FF
        phx
        jsl rlPushToOAMBuffer
        plx
        jml _C8F9


        _C873
        plx
        ply
        rtl


        _C876
        lda wMapSavedCursorXPixel,b
        sec
        sbc wMapScrollXPixels,b
        sta wR0
        lda wMapSavedCursorYPixel,b
        sec
        sbc wMapScrollYPixels,b
        sta wR1
        lda #$0000
        sta wR4
        stz wR5
        jsr rsUnknown88C8FF
        phx
        jsl rlPushToOAMBuffer
        plx
        bra _C8F9


        _C89A
        ldx wActiveUnitDeploymentOffset,b
        lda wMapScrollXPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sec
        sbc #$0001
        sta wTempVariable1,b
        lda wMapScrollYPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sec
        sbc #$0001
        sta wTempVariable2,b
        lda aDeploymentTable._XTilePosition,x
        sec
        sbc wTempVariable1,b
        bmi _C873
        cmp #$0012
        bcs _C873
        lda aDeploymentTable._YTilePosition,x
        sec
        sbc wTempVariable2,b
        bmi _C873
        cmp #$0011
        bcs _C873
        lda wUnknown00076C,b
        sec
        sbc wMapScrollXPixels,b
        sta wR0
        lda wUnknown00076E,b
        sec
        sbc wMapScrollYPixels,b
        sta wR1
        lda #$0000
        sta wR4
        stz wR5
        jsr rsUnknown88C8FF
        phx
        jsl rlPushToOAMBuffer
        plx

        _C8F9
        jsr rsUnknown88CA28
        plx
        ply
        rtl

        .databank 0

        ; 88/C8FF

      rsUnknown88C8FF ; 88/C8FF

        .al
        .xl
        .autsiz
        .databank ?

        lda wMovingUnitSpriteTimer,b
        bne _C91E
        lda bDMAArrayFlag,b
        and #$00FF
        bne _C91E
        lda wMovingUnitSpriteFrame,b
        clc
        adc #$0001
        cmp #$0004
        bcc _C91B
        lda #$0000

        _C91B
        sta wMovingUnitSpriteFrame,b

        _C91E
        ldx wActiveUnitDeploymentOffset,b
        lda aDeploymentTable._DeploymentOffsets,x
        cmp #$0060
        bcs _C939
        sep #$20
        lda #$88
        pha
        plb
        .databank $88
        rep #$20
        ldy #$CC5F
        jml _C97E


        _C939
        sep #$20
        lda #$88
        pha
        plb
        .databank $88
        rep #$20
        phx
        lda aDeploymentTable._DeploymentOffsets,x
        tax
        lda aDeploymentTable._MapSpriteID,x
        and #$7FFF
        asl a
        tax
        lda @l aUnknown88D488,x
        sta wR3
        lda wMovingUnitSpriteFrame,b
        asl a
        clc
        adc wUnknown0007E2,b
        clc
        adc wR3
        tax
        lda @l aUnknown88D4C6,x
        and #$00FF
        clc
        adc wR0
        sta wR0
        lda @l aUnknown88D4C6+1,x
        and #$00FF
        clc
        adc wR1
        sta wR1
        ldy #$CC49
        plx

        _C97E
        lda aDeploymentTable,x
        and #$0003
        asl a
        phx
        tax
        lda @l aUnknown88C990,x
        sta wR5
        plx
        rts

        .databank 0

        ; 88/C990

    .endsection Unsorted88C844Section


    .section Data88C990Section

      .al
      .xl

      aUnknown88C990 ; 88/C990

        ; Read by rlUnknown88D084, rsUnknown88C8FF.

        .word $0200, $0400, $0600, $0800, $0000, $0200, $0400, $0600
        .word $0800, $0800, $0800

        ; 88/C9A6

    .endsection Data88C990Section


    .section Unsorted88C9A6Section

      .al
      .xl

      rlUnknown88C9A6 ; 88/C9A6

        .al
        .autsiz
        .databank ?

        phx
        phk
        plb

        lda #$FFFF
        sta $0865,b

        ldx wActiveUnitDeploymentOffset,b
        lda aDeploymentTable._DeploymentOffsets,x
        tax
        lda aDeploymentTable._MapSpriteID,x
        and #$8000
        bne _Tall

          ldx wActiveUnitDeploymentOffset,b
          lda aDeploymentTable._DeploymentOffsets,x
          tax
          lda aDeploymentTable._MapSpriteID,x
          and #~$8000
          sta wR0
          clc
          adc wR0
          clc
          adc wR0
          tax
          lda aMapMovementShortSpritePointers,x
          sta lR45
          lda aMapMovementShortSpritePointers+1,x
          sta lR45+1
          lda #(`$7EAB88)<<8
          sta lR47+1
          lda #<>$7EAB88
          sta lR47
          jsl rlDecompressSingle

          plx
          rtl
        
        _Tall
        ldx wActiveUnitDeploymentOffset,b
        lda aDeploymentTable._DeploymentOffsets,x
        tax
        lda aDeploymentTable._MapSpriteID,x
        and #~$8000
        sta wR0
        clc
        adc wR0
        clc
        adc wR0
        tax
        lda aMapMovementTallSpritePointers,x
        sta lR45
        lda aMapMovementTallSpritePointers+1,x
        sta lR45+1
        lda #(`$7EAB88)<<8
        sta lR47+1
        lda #<>$7EAB88
        sta lR47
        jsl rlDecompressSingle

        plx
        rtl

        .databank 0

        ; 88/CA28

    .endsection Unsorted88C9A6Section


    .section Unsorted88CA28Section

      .al
      .xl

      rsUnknown88CA28 ; 88/CA28

        .al
        .xl
        .autsiz
        .databank ?

        lda $0865,b
        bmi _CA30
        stz $0865,b

        _CA30
        lda wMovingUnitSpriteState,b
        beq _CA73
        lda wMovingUnitSpriteTimer,b
        bne _CA73
        ldx wActiveUnitDeploymentOffset,b
        lda aDeploymentTable._DeploymentOffsets,x
        tax
        lda aDeploymentTable._MapSpriteID,x
        and #$7FFF
        tax
        lda aUnknown88CBE8,x
        and #$00FF
        sta wMovingUnitSpriteTimer,b
        ldx wActiveUnitDeploymentOffset,b
        lda aDeploymentTable._DeploymentOffsets,x
        tax
        lda aDeploymentTable._MapSpriteID,x
        and #$8000
        bne _CA6C
        jsr rsUnknown88CA77
        inc $0865,b
        rts


        _CA6C
        jsr rsUnknown88CB43
        inc $0865,b
        rts


        _CA73
        dec wMovingUnitSpriteTimer,b
        rts

        .databank 0

        ; 88/CA77

    .endsection Unsorted88CA28Section


    .section Unsorted88CA77Section

      .al
      .xl

      rsUnknown88CA77 ; 88/CA77

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda wMovingUnitSpriteFrame,b
        cmp #$0000
        beq _CA8E
        cmp #$0001
        beq _CA93
        cmp #$0002
        beq _CA98
        cmp #$0003
        beq _CA9D

        _CA8E
        lda #$0000
        bra _CAA2


        _CA93
        lda #$0140
        bra _CAA2


        _CA98
        lda #$0280
        bra _CAA2


        _CA9D
        lda #$03C0
        bra _CAA2


        _CAA2
        sta wMapSpriteFrameByteOffset,b
        lda wUnknown0007E2,b
        cmp #$0000
        beq _CABC
        cmp #$0008
        beq _CAC1
        cmp #$0010
        beq _CAC6
        cmp #$0018
        beq _CACB

        _CABC
        lda #$0000
        bra _CAD0


        _CAC1
        lda #$0500
        bra _CAD0


        _CAC6
        lda #$0A00
        bra _CAD0


        _CACB
        lda #$0F00
        bra _CAD0


        _CAD0
        clc
        adc wMapSpriteFrameByteOffset,b
        sta wMapSpriteFrameByteOffset,b
        lda #$7E00
        sta lR18+1
        lda #$AB88
        sta lR18
        lda #$7E00
        sta lMapSpriteGraphicsPointer+1,b
        lda #$AB88
        sta lMapSpriteGraphicsPointer,b
        lda #$7E00
        sta $084E,b
        lda #$AB88
        sta $084D,b
        lda lMapSpriteGraphicsPointer,b
        clc
        adc wMapSpriteFrameByteOffset,b
        sta lR18
        sta $084D,b
        lda #$00A0
        sta wR0
        lda #$6200
        sta wR1
        lda $0865,b
        beq _CB1A
        phx
        jsl rlDMAByPointer
        plx

        _CB1A
        lda lMapSpriteGraphicsPointer,b
        clc
        adc #$00A0
        clc
        adc wMapSpriteFrameByteOffset,b
        sta lR18
        sta $0850,b
        lda #$00A0
        sta wR0
        lda #$6300
        sta wR1
        lda $0865,b
        beq _CB42
        phx
        jsl rlDMAByPointer
        plx
        stz $0865,b

        _CB42
        rts

        .databank 0

        ; 88/CB43

      rsUnknown88CB43 ; 88/CB43

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda wMovingUnitSpriteFrame,b
        cmp #$0000
        beq _CB5A
        cmp #$0001
        beq _CB5F
        cmp #$0002
        beq _CB64
        cmp #$0003
        beq _CB69

        _CB5A
        lda #$0000
        bra _CB6E


        _CB5F
        lda #$0200
        bra _CB6E


        _CB64
        lda #$0400
        bra _CB6E


        _CB69
        lda #$0600
        bra _CB6E


        _CB6E
        sta wMapSpriteFrameByteOffset,b
        lda wUnknown0007E2,b
        xba
        clc
        adc wMapSpriteFrameByteOffset,b
        sta wMapSpriteFrameByteOffset,b
        lda #$7E00
        sta lR18+1
        lda #$AB88
        sta lR18
        lda #$7E00
        sta lMapSpriteGraphicsPointer+1,b
        lda #$AB88
        sta lMapSpriteGraphicsPointer,b
        lda #$7E00
        sta $084E,b
        lda #$AB88
        sta $084D,b
        lda lMapSpriteGraphicsPointer,b
        clc
        adc wMapSpriteFrameByteOffset,b
        sta lR18
        sta $084D,b
        lda #$0100
        sta wR0
        lda #$6200
        sta wR1
        lda $0865,b
        beq _CBBF
        phx
        jsl rlDMAByPointer
        plx

        _CBBF
        lda lMapSpriteGraphicsPointer,b
        clc
        adc #$0100
        clc
        adc wMapSpriteFrameByteOffset,b
        sta lR18
        sta $0850,b
        lda #$0100
        sta wR0
        lda #$6300
        sta wR1
        lda $0865,b
        beq _CBE7
        phx
        jsl rlDMAByPointer
        plx
        stz $0865,b

        _CBE7
        rts

        .databank 0

        ; 88/CBE8

    .endsection Unsorted88CA77Section


    .section Unsorted88CBE8Section

      .al
      .xl

      aUnknown88CBE8 ; 88/CBE8

        ; Indexed by map sprite ID (without the tall flag $8000).
        ; 65 bytes of 9 and then 32 bytes of 14: the same counts as the
        ; short and tall map sprite tables.

        .fill 65, 9
        .fill 32, 14

        ; 88/CC49


      aUnknown88CC49 ; 88/CC49

        _Sprites := [[(   8,    0), $21, SpriteLarge, $026, 2, 0, false, false]]
        _Sprites ..= [[(  -8,    0), $21, SpriteLarge, $024, 2, 0, false, false]]
        _Sprites ..= [[(   8,  -16), $21, SpriteLarge, $022, 2, 0, false, false]]
        _Sprites ..= [[(  -8,  -16), $21, SpriteLarge, $020, 2, 0, false, false]]

        .structSpriteArray aUnknown88CC49._Sprites

      aUnknown88CC5F ; 88/CC5F

        _Sprites := [[(  -4,    8), $00, SpriteSmall, $034, 2, 0, false, false]]
        _Sprites ..= [[(   4,    0), $21, SpriteLarge, $022, 2, 0, false, false]]
        _Sprites ..= [[(  12,   -8), $00, SpriteSmall, $024, 2, 0, false, false]]
        _Sprites ..= [[(  -4,   -8), $21, SpriteLarge, $020, 2, 0, false, false]]

        .structSpriteArray aUnknown88CC5F._Sprites

    .endsection Unsorted88CBE8Section


    .section Unsorted88CC75Section

      .al
      .xl

      rlUnknown88CC75 ; 88/CC75

        .al
        .xl
        .autsiz
        .databank ?

        lda wMapSpriteFrameCounter,b
        and #$000F
        cmp #$0002
        bcc _CC97
        cmp #$0008
        beq _CC97
        cmp #$0009
        beq _CC97
        cmp #$000A
        bcc _CC93
        jsr rsUnknown88CE81
        rtl


        _CC93
        jsr rsUnknown88CC98
        rtl


        _CC97
        rtl

        .databank 0

        ; 88/CC98

      rsUnknown88CC98 ; 88/CC98

        .al
        .xl
        .autsiz
        .databank ?

        lda wMapSpriteFrameCounter,b
        clc
        adc #$0002
        and #$000F
        asl a
        xba
        sta wTempVariable2,b
        lda wMapSpriteFrameCounter,b
        and #$000F
        sec
        sbc #$0002
        asl a
        asl a
        asl a
        asl a
        sta wTempVariable1,b
        lda wMapSpriteFrameCounter,b
        and #$0030
        cmp #$0000
        beq _CCD2
        cmp #$0010
        beq _CCD7
        cmp #$0020
        beq _CCDC
        cmp #$0030
        beq _CCE1

        _CCD2
        lda #$0000
        bra _CCE6


        _CCD7
        lda #$0080
        bra _CCE6


        _CCDC
        lda #$0100
        bra _CCE6


        _CCE1
        lda #$0080
        bra _CCE6


        _CCE6
        sta wMapSpriteFrameByteOffset,b
        sta wUnknown000790,b
        ldx wTempVariable1,b
        ldy #$0000

        _CCF2
        lda aDeploymentTable._MapSpriteID,x
        and #$7FFF
        sta wR0
        clc
        adc wR0
        clc
        adc wR0
        phx
        tax
        lda aUnknown88D526+1,x
        sta aDynamicMapSpriteDMASources.lTopHalf+1,b,y
        sta aDynamicMapSpriteDMASources.lBottomHalf+1,b,y
        lda aUnknown88D526,x
        plx
        sta lMapSpriteGraphicsPointer,b
        clc
        adc wMapSpriteFrameByteOffset,b
        sta aDynamicMapSpriteDMASources.lTopHalf,b,y
        clc
        adc #$0040
        sta aDynamicMapSpriteDMASources.lBottomHalf,b,y
        lda #$6000
        clc
        adc wTempVariable2,b
        sta aDynamicMapSpriteVRAMDestinations.wTopHalf,b,y
        clc
        adc #$0100
        sta aDynamicMapSpriteVRAMDestinations.wBottomHalf,b,y
        lda wTempVariable2,b
        clc
        adc #$0020
        sta wTempVariable2,b
        inc x
        inc x
        tya
        clc
        adc #$0006
        tay
        cpy #$0030
        bcc _CCF2
        rts

        .databank 0

        ; 88/CD4C

      rlUnknown88CD4C ; 88/CD4C

        .al
        .xl
        .autsiz
        .databank ?

        lda #$8000
        trb wMapSpriteAnimationPauseFlags,b
        rtl

        .databank 0

        ; 88/CD53

    .endsection Unsorted88CC75Section


    .section Unsorted88CD53Section

      .al
      .xl

      rlUnknown88CD53 ; 88/CD53

        .al
        .autsiz
        .databank ?

        lda #$8000
        tsb wMapSpriteAnimationPauseFlags,b
        rtl

        .databank 0

      rlUnknown88CD5A ; 88/CD5A

        .al
        .autsiz
        .databank ?

        lda #$0001
        trb wMapSpriteAnimationPauseFlags,b
        rtl

        .databank 0

      rlUnknown88CD61 ; 88/CD61

        .al
        .autsiz
        .databank ?

        lda #$0001
        tsb wMapSpriteAnimationPauseFlags,b
        rtl

        .databank 0

        ; 88/CD68

    .endsection Unsorted88CD53Section


    .section Unsorted88CD68Section

      .al
      .xl

      rlUnknown88CD68 ; 88/CD68

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $88
        jsl rlUnknown88DB0C
        lda wMapSpriteFrameCounter,b
        and #$0007
        beq _CD97
        cmp #$0001
        beq _CD9D
        lda wMapSpriteAnimationPauseFlags,b
        bmi _CD94
        lda wMapSpriteFrameCounter,b
        and #$000F
        cmp #$0008
        bcc _CDA3
        jml _CE11


        _CD91
        inc wMapSpriteFrameCounter,b

        _CD94
        plp
        plb
        .databank $88
        rtl


        _CD97
        jsl rlUnknown88CF31
        bra _CD91


        _CD9D
        jsl rlUnknown88CFBA
        bra _CD91


        _CDA3
        sep #$20
        rep #$10
        lda #$80
        sta $2115,b
        lda #$00
        sta $4316,b
        sta $4326,b
        lda #$18
        sta $4311,b
        sta $4321,b
        ldy #$0000

        _CDBF
        lda #$40
        sta $4315,b
        sta $4325,b
        ldx aDynamicMapSpriteDMASources.lTopHalf,b,y
        stx $4312,b
        lda aDynamicMapSpriteDMASources.lTopHalf+2,b,y
        sta $4314,b
        ldx aDynamicMapSpriteVRAMDestinations.wTopHalf,b,y
        stx $2116,b
        lda #$01
        sta $4310,b
        sta $4320,b
        lda #$02
        sta $420B,b
        ldx aDynamicMapSpriteDMASources.lBottomHalf,b,y
        stx $4322,b
        lda aDynamicMapSpriteDMASources.lBottomHalf+2,b,y
        sta $4324,b
        ldx aDynamicMapSpriteVRAMDestinations.wBottomHalf,b,y
        stx $2116,b
        lda #$04
        sta $420B,b
        tya
        clc
        adc #$06
        tay
        cpy #$0030
        beq _CE0B
        jml _CDBF


        _CE0B
        rep #$20
        jml _CD91


        _CE11
        sep #$20
        rep #$10
        lda #$80
        sta $2115,b
        lda #$18
        sta $4311,b
        sta $4321,b
        lda #$00
        sta $4316,b
        sta $4326,b
        ldy #$0000

        _CE2D
        lda #$40
        sta $4315,b
        ldx aDynamicMapSpriteDMASources.lTopHalf,b,y
        stx $4312,b
        lda aDynamicMapSpriteDMASources.lTopHalf+2,b,y
        sta $4314,b
        ldx aDynamicMapSpriteVRAMDestinations.wTopHalf,b,y
        stx $2116,b
        lda #$01
        sta $4310,b
        sta $4320,b
        lda #$02
        sta $420B,b
        lda #$80
        sta $4325,b
        ldx aDynamicMapSpriteDMASources.lBottomHalf,b,y
        stx $4322,b
        lda aDynamicMapSpriteDMASources.lBottomHalf+2,b,y
        sta $4324,b
        ldx aDynamicMapSpriteVRAMDestinations.wBottomHalf,b,y
        stx $2116,b
        lda #$04
        sta $420B,b
        tya
        clc
        adc #$06
        tay
        cpy #$0018
        beq _CE7B
        jml _CE2D


        _CE7B
        rep #$20
        jml _CD91

        .databank 0

        ; 88/CE81

      rsUnknown88CE81 ; 88/CE81

        .al
        .xl
        .autsiz
        .databank ?

        lda wMapSpriteFrameCounter,b
        and #$000F
        asl a
        xba
        sta wTempVariable2,b
        lda wMapSpriteFrameCounter,b
        and #$000F
        sec
        sbc #$000A
        asl a
        asl a
        asl a
        clc
        adc #$0060
        sta wTempVariable1,b
        lda wMapSpriteFrameCounter,b
        and #$0030
        cmp #$0000
        beq _CEBA
        cmp #$0010
        beq _CEBF
        cmp #$0020
        beq _CEC4
        cmp #$0030
        beq _CEC9

        _CEBA
        lda #$0000
        bra _CECE


        _CEBF
        lda #$00C0
        bra _CECE


        _CEC4
        lda #$0180
        bra _CECE


        _CEC9
        lda #$00C0
        bra _CECE


        _CECE
        sta wMapSpriteFrameByteOffset,b
        sta wUnknown000790,b
        ldx wTempVariable1,b
        ldy #$0000

        _CEDA
        lda aDeploymentTable._MapSpriteID,x
        and #$7FFF
        sta wR0
        clc
        adc wR0
        clc
        adc wR0
        phx
        tax
        lda aUnknown88D5E3+1,x
        sta aDynamicMapSpriteDMASources.lTopHalf+1,b,y
        sta aDynamicMapSpriteDMASources.lBottomHalf+1,b,y
        lda aUnknown88D5E3,x
        clc
        adc wMapSpriteFrameByteOffset,b
        sta aDynamicMapSpriteDMASources.lTopHalf,b,y
        clc
        adc #$0040
        sta aDynamicMapSpriteDMASources.lBottomHalf,b,y
        plx
        lda #$6000
        clc
        adc wTempVariable2,b
        sta aDynamicMapSpriteVRAMDestinations.wTopHalf,b,y
        clc
        adc #$0100
        sta aDynamicMapSpriteVRAMDestinations.wBottomHalf,b,y
        lda wTempVariable2,b
        clc
        adc #$0040
        sta wTempVariable2,b
        inc x
        inc x
        tya
        clc
        adc #$0006
        tay
        cpy #$0018
        bcc _CEDA
        rts

        .databank 0

        ; 88/CF31

      rlUnknown88CF31 ; 88/CF31

        .al
        .xl
        .autsiz
        .databank ?

        lda wMapSpriteAnimationPauseFlags,b
        bit #$0001
        bne _CF89
        sep #$20
        lda wMapSpriteFrameCounter,b
        and #$78
        lsr a
        lsr a
        lsr a
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda #$80
        sta $2115,b
        lda #$00
        sta $4315,b
        lda #$08
        sta $4316,b
        lda #$18
        sta $4311,b
        lda aUnknown88CF8A,x
        sta $4312,b
        lda aUnknown88CF8A+1,x
        sta $4313,b
        lda aUnknown88CF8A+2,x
        sta $4314,b
        lda #$00
        sta $2116,b
        lda #$0C
        sta $2117,b
        lda #$01
        sta $4310,b
        lda #$02
        sta $420B,b
        rep #$20

        _CF89
        rtl

        .databank 0

        ; 88/CF8A

    .endsection Unsorted88CD68Section


    .section Table88CF8ASection

      .al
      .xl

      aUnknown88CF8A ; 88/CF8A

        ; Read by rlUnknown88CF31.

        .for i in range(16)
          .long g4bppMapTileAnimations1 + (i * $0800)
        .endfor

        ; 88/CFBA

    .endsection Table88CF8ASection


    .section Unsorted88CFBASection

      .al
      .xl

      rlUnknown88CFBA ; 88/CFBA

        .al
        .xl
        .autsiz
        .databank ?

        lda wMapSpriteAnimationPauseFlags,b
        bit #$0001
        bne _D012
        sep #$20
        lda wMapSpriteFrameCounter,b
        and #$F8
        lsr a
        lsr a
        lsr a
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda #$80
        sta $2115,b
        lda #$00
        sta $4315,b
        lda #$04
        sta $4316,b
        lda #$18
        sta $4311,b
        lda aUnknown88D013,x
        sta $4312,b
        lda aUnknown88D013+1,x
        sta $4313,b
        lda aUnknown88D013+2,x
        sta $4314,b
        lda #$00
        sta $2116,b
        lda #$0A
        sta $2117,b
        lda #$01
        sta $4310,b
        lda #$02
        sta $420B,b
        rep #$20

        _D012
        rtl

        .databank 0

        ; 88/D013

    .endsection Unsorted88CFBASection


    .section Table88D013Section

      .al
      .xl

      aUnknown88D013 ; 88/D013

        ; Read by rlUnknown88CFBA.

        .for i in range(32)
          .long g4bppMapTileAnimations2 + (i * $0400)
        .endfor

        ; 88/D073

    .endsection Table88D013Section


    .section Unsorted88D084Section

      .al
      .xl

      rlUnknown88D084 ; 88/D084

        .al
        .xl
        .autsiz
        .databank ?

        phb
        sep #$20
        lda #$7E
        pha
        plb
        .databank $7E
        rep #$20
        jsl rlBeginOAMScanlineFrame
        ldy #$008E
        bra _D0A0


        _D096
        lda #$0000
        sta $0A43,b,y
        jml _D10F


        _D0A0
        lda aDeploymentTable,y
        beq _D096
        bit #$0040
        bne _D096
        lda $453B,b,y
        sec
        sbc wMapScrollXPixels,b
        sta $0923,b,y
        sta wR0
        clc
        adc #$0007
        cmp #$00FF
        bcs _D096
        lda $45CB,b,y
        sec
        sbc wMapScrollYPixels,b
        sta $09B3,b,y
        clc
        adc #$000F
        cmp #$00F1
        bcs _D096
        sec
        sbc #$001F
        sta wR1
        lda aDeploymentTable,y
        bit #$2000
        bne _D0EA
        bit #$0008
        beq _D0EF
        bit #$0003
        bne _D0EF

        _D0EA
        lda #$0E00
        bra _D0F8


        _D0EF
        and #$0003
        asl a
        tax
        lda aUnknown88C990,x

        _D0F8
        ldx $465B,b,y
        ora aUnknown88D135,x
        sta $0A43,b,y
        cpx #$0060
        bcc _D10F
        inc a
        inc a
        sta wR4
        jsl rlPushToOAMBufferWithScanlineCulling

        _D10F
        dec y
        dec y
        bpl _D0A0
        ldy #$008E

        _D116
        lda $0A43,b,y
        beq _D12B
        sta wR4
        lda $0923,b,y
        sta wR0
        lda $09B3,b,y
        sta wR1
        jsl rlPushToOAMBufferWithScanlineCulling._88D8

        _D12B
        dec y
        dec y
        bpl _D116
        jsl rlFinishOAMScanlineFrame
        plb
        .databank $7E
        rtl

        .databank 0

        ; 88/D135

    .endsection Unsorted88D084Section


    .section Data88D135Section

      .al
      .xl

      aUnknown88D135 ; 88/D135

        ; Read by rlUnknown88D084.

        .word $2080, $2082, $2084, $2086, $2088, $208A, $208C, $208E
        .word $20A0, $20A2, $20A4, $20A6, $20A8, $20AA, $20AC, $20AE
        .word $20C0, $20C2, $20C4, $20C6, $20C8, $20CA, $20CC, $20CE
        .word $20E0, $20E2, $20E4, $20E6, $20E8, $20EA, $20EC, $20EE
        .word $2100, $2102, $2104, $2106, $2108, $210A, $210C, $210E
        .word $2120, $2122, $2124, $2126, $2128, $212A, $212C, $212E
        .word $2140, $2144, $2148, $214C, $2160, $2164, $2168, $216C
        .word $2180, $2184, $2188, $218C, $21A0, $21A4, $21A8, $21AC
        .word $21C0, $21C4, $21C8, $21CC, $21E0, $21E4, $21E8, $21EC

        ; 88/D1C5

      aUnknown88D1C5 ; 88/D1C5

        ; Read by rlCastleDrawCourtyardUnitSprites, rsUnitWindowRenderSprites.

        .word $0000, $0002, $0004, $0006, $0008, $000A, $000C, $000E
        .word $0020, $0022, $0024, $0026, $0028, $002A, $002C, $002E
        .word $0040, $0042, $0044, $0046, $0048, $004A, $004C, $004E
        .word $0060, $0062, $0064, $0066, $0068, $006A, $006C, $006E
        .word $0080, $0082, $0084, $0086, $0088, $008A, $008C, $008E
        .word $00A0, $00A2, $00A4, $00A6, $00A8, $00AA, $00AC, $00AE
        .word $0000, $0004, $0008, $000C, $0020, $0024, $0028, $002C
        .word $0040, $0044, $0048, $004C, $0060, $0064, $0068, $006C
        .word $0080, $0084, $0088, $008C, $00A0, $00A4, $00A8, $00AC

        ; 88/D255

      aUnknown88D255 ; 88/D255

        ; Read by rlCastleDrawCourtyardUnitSprites.

        .word $0000, $0002, $0004, $0006, $0008, $000A, $000C, $000E
        .word $0000, $0002, $0004, $0006, $0008, $000A, $000C, $000E
        .word $0000, $0002, $0004, $0006, $0008, $000A, $000C, $000E
        .word $0000, $0002, $0004, $0006, $0008, $000A, $000C, $000E
        .word $0000, $0002, $0004, $0006, $0008, $000A, $000C, $000E
        .word $0000, $0002, $0004, $0006, $0008, $000A, $000C, $000E

        ; 88/D2B5

      aUnknown88D2B5 ; 88/D2B5

        ; Read by rsUnitWindowRenderSprites.

        .word $0000, $0004, $0008, $000C, $0020, $0024, $0028, $002C
        .word $0040, $0044, $0048, $004C, $0060, $0064, $0068, $006C
        .word $0080, $0084, $0088, $008C, $00A0, $00A4, $00A8, $00AC
        .word $0000, $0010, $0020, $0030, $0040, $0050, $0060, $0070
        .word $0080, $0090, $00A0, $00B0, $00C0, $00D0, $00E0, $00F0
        .word $0100, $0110, $0120, $0130, $0140, $0150, $0160, $0170
        .word $0180, $0190, $01A0, $01B0, $01C0, $01D0, $01E0, $01F0
        .word $0200, $0210, $0220, $0230, $0240, $0250, $0260, $0270
        .word $0280, $0290, $02A0, $02B0, $02C0, $02D0, $02E0, $02F0
        .word $0300, $0310, $0320, $0330, $0340, $0350, $0360, $0370
        .word $0380, $0390, $03A0, $03B0, $03C0, $03D0, $03E0, $03F0

        ; 88/D365

    .endsection Data88D135Section


    .section Table88D488Section

      .al
      .xl

      aUnknown88D488 ; 88/D488

        ; Read by rsUnknown88D963.

        .word $0020, $0000, $0040, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0020, $0000, $0000, $0000
        .word $0020, $0040, $0040, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0020, $0020, $0020, $0000, $0000, $0000

        ; 88/D4C6

    .endsection Table88D488Section


    .section Table88D4C6Section

      .al
      .xl

      aUnknown88D4C6 ; 88/D4C6

        ; Read by rsUnknown88D963.

        .word $0800, $0800, $0800, $0800, $0800, $0800, $0800, $0800
        .word $0800, $0800, $0800, $0800, $0800, $0800, $0800, $0800
        .word $0100, $0000, $0C00, $0000, $0100, $0000, $0C00, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0300, $0A00, $0700, $0000, $0300, $0A00, $0700
        .word $0000, $0000, $0600, $0000, $0000, $0000, $0600, $0000

        ; 88/D526

    .endsection Table88D4C6Section


    .section Unsorted88D731Section

      .al
      .xl

      rlUnknown88D731 ; 88/D731

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda lR18
        pha
        lda lR18+1
        pha
        phx
        phk
        plb
        .databank $88
        lda aMovingMapSpritesMapSprites,b,x
        and #$8000
        bne _D786
        lda aMovingMapSpritesMapSprites,b,x
        phx
        and #$7FFF
        sta wR0
        clc
        adc wR0
        clc
        adc wR0
        tax
        lda @l aMapMovementShortSpritePointers,x
        sta lR45
        lda @l aMapMovementShortSpritePointers+1,x
        sta lR45+1
        plx
        jsr (aUnknown88D7B2,x)
        jsl rlDecompressSingle
        lda #(`g4bppcMageFemaleMapMovementSprite)<<8
        sta lR18+1
        lda #<>g4bppcMageFemaleMapMovementSprite
        sta lR18
        lda #(`aMapAction)<<8
        sta lR19+1
        lda #<>aMapAction
        sta lR19
        jsl rlAppendDecompList
        plx
        pla
        sta lR18+1
        pla
        sta lR18
        rtl


        _D786
        lda aMovingMapSpritesMapSprites,b,x
        phx
        and #$7FFF
        sta wR0
        clc
        adc wR0
        clc
        adc wR0
        tax
        lda @l aMapMovementTallSpritePointers,x
        sta lR45
        lda @l aMapMovementTallSpritePointers+1,x
        sta lR45+1
        plx
        jsr (aUnknown88D7B2,x)
        jsl rlDecompressSingle
        plx
        pla
        sta lR18+1
        pla
        sta lR18
        rtl

        .databank 0

        ; 88/D7B2

    .endsection Unsorted88D731Section


    .section Table88D7B2Section

      .al
      .xl

      aUnknown88D7B2 ; 88/D7B2

        ; Jump table of rlUnknown88D731.
        .word <>rsUnknown88D7BA
        .word <>rsUnknown88D7C5
        .word <>rsUnknown88D7D8
        .word <>rsUnknown88D7EB

    .endsection Table88D7B2Section


    .section Unsorted88D7BASection

      .al
      .xl

      rsUnknown88D7BA ; 88/D7BA

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aMapAction)<<8
        sta lR47+1
        lda #<>aMapAction
        sta lR47
        rts

        .databank 0

        ; 88/D7C5

    .endsection Unsorted88D7BASection


    .section Unsorted88D7C5Section

      .al
      .xl

      rsUnknown88D7C5 ; 88/D7C5

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aMapAction)<<8
        sta lR47+1
        lda #<>aMapAction
        sta lR47
        lda lR47
        clc
        adc #$2000
        sta lR47
        rts

        .databank 0

        ; 88/D7D8

    .endsection Unsorted88D7C5Section


    .section Unsorted88D7D8Section

      .al
      .xl

      rsUnknown88D7D8 ; 88/D7D8

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aMapAction)<<8
        sta lR47+1
        lda #<>aMapAction
        sta lR47
        lda lR47
        clc
        adc #$4000
        sta lR47
        rts

        .databank 0

        ; 88/D7EB

    .endsection Unsorted88D7D8Section


    .section Unsorted88D7EBSection

      .al
      .xl

      rsUnknown88D7EB ; 88/D7EB

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aMapAction)<<8
        sta lR47+1
        lda #<>aMapAction
        sta lR47
        lda lR47
        clc
        adc #$6000
        sta lR47
        rts

        .databank 0

        ; 88/D7FE

    .endsection Unsorted88D7EBSection


    .section Unsorted88D7FESection

      .al
      .xl

      rlUnknown88D7FE ; 88/D7FE

        .al
        .autsiz
        .databank ?

        ; X = active mover offset

        phk
        plb
        lda aUnknown88D837,x
        trb wUnknown000921,b
        lda aUnknown88D83F,x
        trb wUnknown000921,b

        lda aMovingMapSpritesMapSprites,b,x
        and #$8000
        bne +

        ; Short
        jsr rsUnknown88D847
        lda wUnknown000901,x
        sec
        sbc #1
        sta wUnknown000901,x
        bra ++

        ; Tall
        +
        jsr rsUnknown88D963
        lda wUnknown000901,x
        sec
        sbc #1
        sta wUnknown000901,x

        +
        rtl

        .databank 0

      aUnknown88D837 ; 88/D837

        .word $0001
        .word $0002
        .word $0004
        .word $0008

      aUnknown88D83F ; 88/D83F

        .word $8000
        .word $4000
        .word $2000
        .word $1000

    .endsection Unsorted88D7FESection


    .section Unsorted88D847Section

      .al
      .xl

      rsUnknown88D847 ; 88/D847

        .al
        .autsiz
        .databank $88

        ; X = active mover offset

        ; For short map sprites

        lda wUnknown000901,x
        beq +

          jml _End

        +
        lda wUnknown000921,b
        beq ++

          and #$FF00
          beq +

            inc wUnknown000901,b,x
            jml _End

          +
          lda @l aUnknown88D95B,x
          tsb wUnknown000921,b

        +
        lda @l aUnknown88D953,x
        tsb wUnknown000921,b

        lda aMovingMapSpritesMapSprites,b,x
        and #$7FFF
        tay
        lda aUnknown88CBE8,y
        and #$00FF
        sta wUnknown000901,x

        lda wUnknown0008F1,x
        clc
        adc #1
        and #$0003
        sta wUnknown0008F1,x

        lda wUnknown0008F1,x
        cmp #0
        beq _D8A8

        cmp #1
        beq _D8AD

        cmp #2
        beq _D8B2

        cmp #3
        beq _D8B7

        _D8A8
        lda #size(Tile4bpp) * 0
        bra +

        _D8AD
        lda #size(Tile4bpp) * 10
        bra +

        _D8B2
        lda #size(Tile4bpp) * 20
        bra +

        _D8B7
        lda #size(Tile4bpp) * 30
        bra +

        +
        sta wMapSpriteFrameByteOffset,b

        ; Check for direction of movement
        lda wUnknown000911,x
        cmp #0
        beq _D8D7

        cmp #8
        beq _D8DC

        cmp #$0010
        beq _D8E1

        cmp #$0018
        beq _D8E6

        _D8D7
        lda #0
        bra +

        _D8DC
        lda #$0500
        bra +

        _D8E1
        lda #$0A00
        bra +

        _D8E6
        lda #$0F00
        bra +

        +
        clc
        adc wMapSpriteFrameByteOffset,b
        sta wMapSpriteFrameByteOffset,b

        jsr (aUnknown88D94B,x)

        lda lMapSpriteGraphicsPointer,b
        clc
        adc wMapSpriteFrameByteOffset,b
        sta lR18

        lda #$00A0
        sta wR0

        lda #$C400 >> 1
        clc
        adc @l aUnknown88DB04,x
        sta wR1
        phx
        jsl rlDMAByPointer
        plx

        lda lMapSpriteGraphicsPointer,b
        clc
        adc #$00A0
        clc
        adc wMapSpriteFrameByteOffset,b
        sta lR18

        lda #$00A0
        sta wR0

        lda #$C600 >> 1
        clc
        adc @l aUnknown88DB04,x
        sta wR1
        phx
        jsl rlDMAByPointer
        plx

        _End
        sep #$20
        lda #$88
        pha
        plb
        rep #$20

        stz wR0
        stz wR1
        lda @l aUnknown88DAFC,x
        sta wR4
        ldy #$CC5F
        rts

        .databank 0

    .endsection Unsorted88D847Section


    .section Unsorted88D94BSection

      .al
      .xl

      aUnknown88D94B ; 88/D94B

        .word <>rsUnknown88DA82
        .word <>rsUnknown88DA99
        .word <>rsUnknown88DABA
        .word <>rsUnknown88DADB

      aUnknown88D953 ; 88/D953

        .word $0001
        .word $0002
        .word $0004
        .word $0008

      aUnknown88D95B ; 88/D95B

        .word $8000
        .word $4000
        .word $2000
        .word $1000

    .endsection Unsorted88D94BSection


    .section Unsorted88D963Section

      .al
      .xl

      rsUnknown88D963 ; 88/D963

        .al
        .autsiz
        .databank $88

        lda wUnknown000901,x
        beq +

          jml _End

        +
        lda wUnknown000921,b
        beq ++

          and #$FF00
          beq +

            inc wUnknown000901,b,x
            jml _End

          +
          lda @l aUnknown88DA7A,x
          tsb wUnknown000921,b

        +
        lda @l aUnknown88DA72,x
        tsb wUnknown000921,b

        lda aMovingMapSpritesMapSprites,b,x
        and #$7FFF
        tay
        lda aUnknown88CBE8,y
        and #$00FF
        sta wUnknown000901,x

        lda wUnknown0008F1,x
        clc
        adc #1
        and #$0003
        sta wUnknown0008F1,x

        lda wUnknown0008F1,x
        cmp #0
        beq _D9C4

        cmp #1
        beq _D9C9

        cmp #2
        beq _D9CE

        cmp #3
        beq _D9D3
        
        _D9C4
        lda #0
        bra +

        _D9C9
        lda #$0200
        bra +

        _D9CE
        lda #$0400
        bra +

        _D9D3
        lda #$0600
        bra +

        +
        sta wMapSpriteFrameByteOffset,b

        lda wUnknown000911,x
        xba
        clc
        adc wMapSpriteFrameByteOffset,b
        sta wMapSpriteFrameByteOffset,b

        jsr (aUnknown88DA6A,x)

        lda lMapSpriteGraphicsPointer,b
        clc
        adc wMapSpriteFrameByteOffset,b
        sta lR18

        lda #size(Tile4bpp) * 8
        sta wR0

        lda #$C400 >> 1
        clc
        adc @l aUnknown88DB04,x
        sta wR1
        phx
        jsl rlDMAByPointer
        plx

        lda lMapSpriteGraphicsPointer,b
        clc
        adc #$0100
        clc
        adc wMapSpriteFrameByteOffset,b
        sta lR18

        lda #size(Tile4bpp) * 8
        sta wR0

        lda #$C600 >> 1
        clc
        adc @l aUnknown88DB04,x
        sta wR1
        phx
        jsl rlDMAByPointer
        plx

        _End
        sep #$20
        lda #$88
        pha
        plb
        rep #$20

        phx
        lda aMovingMapSpritesMapSprites,b,x
        and #$7FFF
        asl a
        tax
        lda @l aUnknown88D488,x
        sta wR3
        plx

        lda wUnknown0008F1,x
        asl a
        clc
        adc wUnknown000911,x
        clc
        adc wR3
        tay
        lda $D4C6,b,y
        and #$00FF
        sta wR0
        lda $D4C7,b,y
        and #$00FF
        sta wR1
        lda @l aUnknown88DAFC,x
        sta wR4
        ldy #$CC49
        rts

        .databank 0

    .endsection Unsorted88D963Section


    .section Unsorted88DA6ASection

      .al
      .xl

      aUnknown88DA6A ; 88/DA6A

        .word <>rsUnknown88DA82
        .word <>rsUnknown88DA99
        .word <>rsUnknown88DABA
        .word <>rsUnknown88DADB

      aUnknown88DA72 ; 88/DA72

        .word $0001
        .word $0002
        .word $0004
        .word $0008

      aUnknown88DA7A ; 88/DA7A

        .word $8000
        .word $4000
        .word $2000
        .word $1000

    .endsection Unsorted88DA6ASection


    .section Unsorted88DA82Section

      .al
      .xl

      rsUnknown88DA82 ; 88/DA82

        .al
        .autsiz
        .databank ?

        lda #(`aMovingMapSpriteBuffers[0])<<8
        sta lR18+1
        lda #<>aMovingMapSpriteBuffers[0]
        sta lR18
        lda #(`aMovingMapSpriteBuffers[0])<<8
        sta $07EA+1,b
        lda #<>aMovingMapSpriteBuffers[0]
        sta lMapSpriteGraphicsPointer,b
        rts

        .databank 0

      rsUnknown88DA99 ; 88/DA99

        .al
        .autsiz
        .databank ?

        lda #(`aMovingMapSpriteBuffers[0])<<8
        sta lR18+1
        lda #<>aMovingMapSpriteBuffers[0]
        sta lR18
        lda #(`aMovingMapSpriteBuffers[0])<<8
        sta $07EA+1,b
        lda #<>aMovingMapSpriteBuffers[0]
        sta lMapSpriteGraphicsPointer,b

        lda lMapSpriteGraphicsPointer,b
        clc
        adc #$2000
        sta lMapSpriteGraphicsPointer,b
        rts

        .databank 0

      rsUnknown88DABA ; 88/DABA

        .al
        .autsiz
        .databank ?

        lda #(`aMovingMapSpriteBuffers[0])<<8
        sta lR18+1
        lda #<>aMovingMapSpriteBuffers[0]
        sta lR18
        lda #(`aMovingMapSpriteBuffers[0])<<8
        sta lMapSpriteGraphicsPointer+1,b
        lda #<>aMovingMapSpriteBuffers[0]
        sta lMapSpriteGraphicsPointer,b

        lda lMapSpriteGraphicsPointer,b
        clc
        adc #$4000
        sta lMapSpriteGraphicsPointer,b
        rts

        .databank 0

      rsUnknown88DADB ; 88/DADB

        .al
        .autsiz
        .databank ?

        lda #(`aMovingMapSpriteBuffers[0])<<8
        sta lR18+1
        lda #<>aMovingMapSpriteBuffers[0]
        sta lR18
        lda #(`aMovingMapSpriteBuffers[0])<<8
        sta lMapSpriteGraphicsPointer+1,b
        lda #<>aMovingMapSpriteBuffers[0]
        sta lMapSpriteGraphicsPointer,b

        lda lMapSpriteGraphicsPointer,b
        clc
        adc #$6000
        sta lMapSpriteGraphicsPointer,b
        rts

        .databank 0

    .endsection Unsorted88DA82Section


    .section Unsorted88DAFCSection

      .al
      .xl

      aUnknown88DAFC ; 88/DAFC

        .word $0000
        .word $0008
        .word $0020
        .word $0028

      aUnknown88DB04 ; 88/DB04

        .word $0000 >> 1
        .word $0100 >> 1
        .word $0400 >> 1
        .word $0500 >> 1

        ; 88/DB0C

    .endsection Unsorted88DAFCSection


    .section Unsorted88DB0CSection

      .al
      .xl

      rlUnknown88DB0C ; 88/DB0C

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $88
        lda wMovingUnitSpriteState,b
        beq _DB2F
        lda $0865,b
        beq _DB2F
        ldx wActiveUnitDeploymentOffset,b
        lda aDeploymentTable._DeploymentOffsets,x
        tax
        lda aDeploymentTable._MapSpriteID,x
        and #$8000
        beq _DB32
        jml _DB90


        _DB2F
        plp
        plb
        .databank $88
        rtl


        _DB32
        sep #$20
        rep #$10
        lda #$80
        sta $2115,b
        lda #$00
        sta $4316,b
        sta $4326,b
        lda #$18
        sta $4311,b
        sta $4321,b
        lda #$01
        sta $4310,b
        sta $4320,b
        lda #$A0
        sta $4315,b
        ldx $084D,b
        stx $4312,b
        lda $084F,b
        sta $4314,b
        ldx #$6200
        stx $2116,b
        lda #$02
        sta $420B,b
        lda #$A0
        sta $4325,b
        ldx $0850,b
        stx $4322,b
        lda $084F,b
        sta $4324,b
        ldx #$6300
        stx $2116,b
        lda #$04
        sta $420B,b
        rep #$20
        plp
        plb
        .databank $88
        rtl


        _DB90
        sep #$20
        rep #$10
        lda #$80
        sta $2115,b
        lda #$18
        sta $4311,b
        sta $4321,b
        lda #$00
        sta $4315,b
        sta $4325,b
        lda #$01
        sta $4310,b
        sta $4320,b
        lda #$01
        sta $4316,b
        ldx $084D,b
        stx $4312,b
        lda $084F,b
        sta $4314,b
        ldx #$6200
        stx $2116,b
        lda #$02
        sta $420B,b
        lda #$01
        sta $4326,b
        ldx $0850,b
        stx $4322,b
        lda $084F,b
        sta $4324,b
        ldx #$6300
        stx $2116,b
        lda #$04
        sta $420B,b
        sep #$20
        plp
        plb
        .databank $88
        rtl

        .databank 0

        ; 88/DBEE

    .endsection Unsorted88DB0CSection


    .section Unsorted88DBEESection

      .al
      .xl

      rlUnknown88DBEE ; 88/DBEE

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $88
        jsl rlGetSelectedUnitMapSprite
        and #$8000
        bne _DC01
        jsr rsUnknown88DC07
        plp
        plb
        .databank $88
        rtl


        _DC01
        jsr rsUnknown88DC8B
        plp
        plb
        .databank $88
        rtl

        .databank 0

        ; 88/DC07

    .endsection Unsorted88DBEESection


    .section Unsorted88DC07Section

      .al
      .xl

      rsUnknown88DC07 ; 88/DC07

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda wVBlankEnabledFramecount
        and #$0030
        cmp #$0000
        beq _DC20
        cmp #$0010
        beq _DC25
        cmp #$0020
        beq _DC2A
        cmp #$0030
        beq _DC2F

        _DC20
        lda #$0000
        bra _DC34


        _DC25
        lda #$0080
        bra _DC34


        _DC2A
        lda #$0100
        bra _DC34


        _DC2F
        lda #$0080
        bra _DC34


        _DC34
        sta wMapSpriteFrameByteOffset,b
        jsl rlGetSelectedUnitMapSprite
        and #$7FFF
        sta wR0
        clc
        adc wR0
        clc
        adc wR0
        tax
        lda aUnknown88D526+1,x
        sta lR18+1
        lda aUnknown88D526,x
        sta lMapSpriteGraphicsPointer,b
        lda lMapSpriteGraphicsPointer,b
        clc
        adc wMapSpriteFrameByteOffset,b
        sta lR18
        lda #$0040
        sta wR0
        lda #$6E00
        sta wR1
        phx
        jsl rlDMAByPointer
        plx
        lda lMapSpriteGraphicsPointer,b
        clc
        adc #$0040
        clc
        adc wMapSpriteFrameByteOffset,b
        sta lR18
        lda #$0040
        sta wR0
        lda #$6F00
        sta wR1
        phx
        jsl rlDMAByPointer
        plx
        rts

        .databank 0

        ; 88/DC8B

      rsUnknown88DC8B ; 88/DC8B

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda wVBlankEnabledFramecount
        and #$0030
        cmp #$0000
        beq _DCA4
        cmp #$0010
        beq _DCA9
        cmp #$0020
        beq _DCAE
        cmp #$0030
        beq _DCB3

        _DCA4
        lda #$0000
        bra _DCB8


        _DCA9
        lda #$00C0
        bra _DCB8


        _DCAE
        lda #$0180
        bra _DCB8


        _DCB3
        lda #$00C0
        bra _DCB8


        _DCB8
        sta wMapSpriteFrameByteOffset,b
        jsl rlGetSelectedUnitMapSprite
        and #$7FFF
        sta wR0
        clc
        adc wR0
        clc
        adc wR0
        tax
        lda aUnknown88D5E3+1,x
        sta lR18+1
        lda aUnknown88D5E3,x
        sta lMapSpriteGraphicsPointer,b
        lda lMapSpriteGraphicsPointer,b
        clc
        adc wMapSpriteFrameByteOffset,b
        sta lR18
        lda #$0040
        sta wR0
        lda #$6E00
        sta wR1
        phx
        jsl rlDMAByPointer
        plx
        lda lMapSpriteGraphicsPointer,b
        clc
        adc #$0040
        clc
        adc wMapSpriteFrameByteOffset,b
        sta lR18
        lda #$0080
        sta wR0
        lda #$6F00
        sta wR1
        phx
        jsl rlDMAByPointer
        plx
        rts

        .databank 0

        ; 88/DD0F

    .endsection Unsorted88DC07Section


    .section Unsorted88DD0FSection

      .al
      .xl

      rlUnknown88DD0F ; 88/DD0F

        ; Nothing in the build reaches this. Draws a sprite array at the active
        ; unit (wR0 = $68, wR1 = $0885 + 6): aUnknown88DD57, or aUnknown88DD77
        ; when its map sprite has bit 15 set.

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $88
        lda #$0068
        sta wR0
        lda wUnknown000885,b
        clc
        adc #$0006
        sta wR1
        stz wR4
        ldx wActiveUnitDeploymentOffset,b
        lda #$0000
        sta wR5
        jsl rlGetSelectedUnitMapSprite
        and #$8000
        bne _DD42
        sep #$20
        lda #$88
        pha
        plb
        .databank $88
        rep #$20
        lda #<>aUnknown88DD57
        tay
        bra _DD4E


        _DD42
        sep #$20
        lda #$88
        pha
        plb
        .databank $88
        rep #$20
        lda #<>aUnknown88DD77
        tay

        _DD4E
        phx
        jsl rlPushToOAMBuffer
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 88/DD57

      aUnknown88DD57 ; 88/DD57

        ; Drawn by rlUnknown88DD0F when the active unit's map sprite has bit 15 clear.
        _Sprites := [[(   4,    4), $21, SpriteLarge, $00E0, 3, 1, false, false]]
        _Sprites..= [[(  16,   16), $00, SpriteSmall, $0022, 3, 2, false, false]]
        _Sprites..= [[(   8,   16), $00, SpriteSmall, $0021, 3, 2, false, false]]
        _Sprites..= [[(   0,   16), $00, SpriteSmall, $0020, 3, 2, false, false]]
        _Sprites..= [[(  16,    0), $21, SpriteLarge, $0002, 3, 2, false, false]]
        _Sprites..= [[(   0,    0), $21, SpriteLarge, $0000, 3, 2, false, false]]

        .structSpriteArray aUnknown88DD57._Sprites


      aUnknown88DD77 ; 88/DD77

        ; Drawn by rlUnknown88DD0F when the active unit's map sprite has bit 15 set.
        _Sprites := [[(   4,    6), $21, SpriteLarge, $00E0, 3, 1, false, false]]
        _Sprites..= [[(   4,  -10), $21, SpriteLarge, $00E2, 3, 1, false, false]]
        _Sprites..= [[(  16,   16), $00, SpriteSmall, $0022, 3, 2, false, false]]
        _Sprites..= [[(   8,   16), $00, SpriteSmall, $0021, 3, 2, false, false]]
        _Sprites..= [[(   0,   16), $00, SpriteSmall, $0020, 3, 2, false, false]]
        _Sprites..= [[(  16,    0), $21, SpriteLarge, $0002, 3, 2, false, false]]
        _Sprites..= [[(   0,    0), $21, SpriteLarge, $0000, 3, 2, false, false]]

        .structSpriteArray aUnknown88DD77._Sprites

    .endsection Unsorted88DD0FSection


    .section Unsorted88DD9CSection

      .as
      .xl

      rlUnknown88DD9C ; 88/DD9C

        .al
        .xl
        .autsiz
        .databank ?

        phb
        phk
        plb
        .databank $88
        lda wR0
        bne _DDA8
        jsr rsUnknown88DDAD
        bra _DDAB


        _DDA8
        jsr rsUnknown88DDD4

        _DDAB
        plb
        .databank $88
        rtl

        .databank 0

        ; 88/DDAD

      rsUnknown88DDAD ; 88/DDAD

        .al
        .xl
        .autsiz
        .databank ?

        lda #$00A0
        sta wR0
        phx
        jsl rlDMAByPointer
        plx
        lda lR18
        clc
        adc #$00A0
        sta lR18
        lda #$00A0
        sta wR0
        lda wR1
        clc
        adc #$0100
        sta wR1
        phx
        jsl rlDMAByPointer
        plx
        rts

        .databank 0

        ; 88/DDD4

      rsUnknown88DDD4 ; 88/DDD4

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0100
        sta wR0
        phx
        jsl rlDMAByPointer
        plx
        lda lR18
        clc
        adc #$0100
        sta lR18
        lda #$0100
        sta wR0
        lda wR1
        clc
        adc #$0100
        sta wR1
        phx
        jsl rlDMAByPointer
        plx
        rts

        .databank 0

        ; 88/DDFB

    .endsection Unsorted88DD9CSection


    .section Unsorted88DDFBSection

      .al
      .xl

      rlUnknown88DDFB ; 88/DDFB

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$008E

        _DDFE
        lda aDeploymentTable._MapSpriteID,x
        sta $7E4DB5,x
        dec x
        dec x
        bpl _DDFE
        rtl

        .databank 0

        ; 88/DE0B

    .endsection Unsorted88DDFBSection


    .section Unsorted88DE0BSection

      .al
      .xl

      rlUnknown88DE0B ; 88/DE0B

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$008E

        _DE0E
        lda $7E4DB5,x
        sta aDeploymentTable._MapSpriteID,x
        dec x
        dec x
        bpl _DE0E
        rtl

        .databank 0

        ; 88/DE1B

    .endsection Unsorted88DE0BSection


    .section Unsorted88DF8CSection

      .al
      .xl

      rlUnknown88DF8C ; 88/DF8C

        .al
        .xl
        .autsiz
        .databank ?

        lda $7E486B,x
        cmp #$FFFF
        beq _DFA0
        txa
        clc
        adc #$0060
        tax
        jsr rsUnknown88DFDA
        bra _DFA5


        _DFA0
        jsr rsUnknown88DFA6
        bra _DFA5


        _DFA5
        rtl

        .databank 0

        ; 88/DFA6

      rsUnknown88DFA6 ; 88/DFA6

        .al
        .xl
        .autsiz
        .databank ?

        lda wVBlankEnabledFramecount
        and #$0030
        cmp #$0000
        beq _DFBF
        cmp #$0010
        beq _DFC4
        cmp #$0020
        beq _DFC9
        cmp #$0030
        beq _DFCE

        _DFBF
        lda #$0000
        bra _DFD3


        _DFC4
        lda #$0080
        bra _DFD3


        _DFC9
        lda #$0100
        bra _DFD3


        _DFCE
        lda #$0080
        bra _DFD3


        _DFD3
        sta wMapSpriteFrameByteOffset,b
        jsr rsUnknown88DE40
        rts

        .databank 0

        ; 88/DFDA

      rsUnknown88DFDA ; 88/DFDA

        .al
        .xl
        .autsiz
        .databank ?

        lda wVBlankEnabledFramecount
        and #$0030
        cmp #$0000
        beq _DFF3
        cmp #$0010
        beq _DFF8
        cmp #$0020
        beq _DFFD
        cmp #$0030
        beq _E002

        _DFF3
        lda #$0000
        bra _E007


        _DFF8
        lda #$00C0
        bra _E007


        _DFFD
        lda #$0180
        bra _E007


        _E002
        lda #$00C0
        bra _E007


        _E007
        sta wMapSpriteFrameByteOffset,b
        jsr rsUnknown88DE9E
        rts

        .databank 0

        ; 88/E00E

    .endsection Unsorted88DF8CSection


    .section Unsorted88E02BSection

      .al
      .xl

      procUnknown88E02B ; 88/E02B

        .structProcInfo "MS", rlUnknown88E033, rlUnknown88E0DF, aProcUnknown88E02BCode

    .endsection Unsorted88E02BSection


    .section Unsorted88E033Section

      .al
      .xl

      rlUnknown88E033 ; 88/E033

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$01DE

        _E036
        lda aUnknown8CA620,x
        sta $7E9B88,x
        dec x
        dec x
        bpl _E036
        lda #$0000
        sta $7F8089
        ldx #$001C

        _E04C
        lda aWindowPalette+2,x
        sta $0102,b,x
        dec x
        dec x
        bpl _E04C
        jsl rlLoadDefaultWindowBorderPalette
        ldx #$07FE
        lda #$01FF

        _E061
        sta aBG3TilemapBuffer,x
        dec x
        dec x
        bpl _E061
        ldx #$05FE
        lda #$030F

        _E06F
        sta $7E7D88,x
        dec x
        dec x
        bpl _E06F
        ldx #$01FE

        _E07A
        lda aUnknownD97C00,x
        sta aBG2TilemapBuffer.Page1,x
        dec x
        dec x
        bpl _E07A
        ldx #$07FE
        lda #$0000

        _E08C
        sta $7E8B88,x
        dec x
        dec x
        bpl _E08C
        lda #(`aDecompressionBuffer)<<8
        sta lR18+1
        lda #<>aDecompressionBuffer
        sta lR18
        lda #$3800
        sta wR1
        lda #$0800
        sta wR0
        jsl rlDMAByPointer
        sep #$20
        lda #$17
        sta bBufferTM
        rep #$20
        stz wGameStateRoutine1,b
        stz wBufferBG3VOFS
        stz wBufferBG3HOFS
        lda #$FFD0
        sta wBufferBG2VOFS
        lda #$FFE0
        sta wBufferBG2HOFS
        jsl rlUnknown88CD53
        jsl rlUnknown88CD61
        stz $0AD3,b
        lda #(`aUnknown88E2DE)<<8
        sta lR44+1
        lda #<>aUnknown88E2DE
        sta lR44
        jsl rlHDMAEngineCreateEntry
        rtl

        .databank 0

        ; 88/E0DF

      rlUnknown88E0DF ; 88/E0DF

        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsl rlDMAByStruct

          .structDMAToVRAM $7E7B88, $0500, $80, $A800

        plx
        lda #<>rlUnknown88E0F5
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 88/E0F5

      rlUnknown88E0F5 ; 88/E0F5

        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsl rlDMAByStruct

          .structDMAToVRAM $7E7B88, $0800, $80, $A800

        plx
        lda #<>rlUnknown88E10B
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 88/E10B

    .endsection Unsorted88E033Section


    .section Unsorted88E10BSection

      .al
      .xl

      rlUnknown88E10B ; 88/E10B

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda $0AD3,b
        cmp #$0040
        bcs _E116
        inc $0AD3,b

        _E116
        lda wVBlankEnabledFramecount
        and #$0007
        bne _E130
        lda #$0008
        sta aPaletteFading,b
        clc
        jsl rlFadePaletteToColors

          .byte $88, $9B, $F0, $00, $20, $00

        bcs _E131

        _E130
        rtl


        _E131
        lda #<>rlUnknown88E154
        sta aProcSystem.aHeaderOnCycle,b,x
        jsl rlResetDialogueEngine
        lda #(`dialogueEpilogueMemorial88E9E5)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88E9E5
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsl rlUnknown88E38A
        rtl

        .databank 0

        ; 88/E154

      rlUnknown88E154 ; 88/E154

        .al
        .xl
        .autsiz
        .databank ?

        lda aDialogue.wStatus,b
        beq _E172
        jsl rlDMAByStruct

          .structDMAToVRAM $7E87C8, $0300, $80, $B440

        lda wVBlankEnabledFramecount
        and #$0001
        bne _E171
        jsl rlUnknown9181F6

        _E171
        rtl


        _E172
        lda #<>rlUnknown88E179
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 88/E179

    .endsection Unsorted88E10BSection


    .section Unsorted88E179Section

      .al
      .xl

      rlUnknown88E179 ; 88/E179

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda bBufferINIDISP
        and #$0F
        beq _E186
        dec bBufferINIDISP
        rep #$20
        rtl


        _E186
        .as
        rep #$20
        jsl rlProcEngineFreeProc
        ldx #$01DE
        lda #$0000

        _E192
        sta aBGPaletteBuffer.aPalette1,b,x
        dec x
        dec x
        bpl _E192
        ldx #$001E

        _E19C
        lda aMapAndCastleSpriteOAMPalettes,x
        sta aOAMPaletteBuffer,b,x
        dec x
        dec x
        bpl _E19C
        ldx #$07FE
        lda #$033F

        _E1AD
        sta aBG2TilemapBuffer.Page1,x
        dec x
        dec x
        bpl _E1AD
        ldx #$07FE
        lda #$01FF

        _E1BB
        sta aBG3TilemapBuffer,x
        dec x
        dec x
        bpl _E1BB
        stz wBufferBG2VOFS
        stz wBufferBG2HOFS
        sep #$20
        lda #$80
        sta $2100,b
        sta bBufferINIDISP
        rep #$20
        jsl rlDisableVBlank
        jsl rlResetHDMAEngine
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0800, $80, $B000

        jsl rlLoadMenuFontGraphics
        jsl rlEnableVBlank
        sep #$20
        lda #$0F
        sta bBufferINIDISP
        rep #$20
        lda #GAMESTATE_MAP_STEP
        sta wGameStateRoutine1,b
        rtl

        .databank 0

        ; 88/E1FE

    .endsection Unsorted88E179Section


    .section Unsorted88E1FESection

      .al
      .xl

      aProcUnknown88E02BCode ; 88/E1FE

        PROC_HALT


        ; 88/E200

    .endsection Unsorted88E1FESection

    .section Table88E2DESection

      .al
      .xl

      aUnknown88E2DE .dstruct structHDMADirectEntryInfo, rlUnknown88E2E9, rlUnknown88E2E9, $E33B, $0008BC, PPU_REG_BASE + $2C, $00 ; 88/E2DE

    .endsection Table88E2DESection


    .section Unsorted88E2E9Section

      .al
      .xl

      rlUnknown88E2E9 ; 88/E2E9

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$01
        sta @l $0008BC
        lda #$00
        sta @l $0008BD
        lda #$7F
        sta @l $0008BE
        lda bBufferTM
        sta @l $0008BF
        lda #$48
        sec
        sbc $0AD3,b
        sta @l $0008C0
        lda bBufferTM
        sta @l $0008C1
        lda $0AD3,b
        sta @l $0008C2
        lda #$04
        sta @l $0008C3
        lda #$10
        sta @l $0008C4
        lda #$00
        sta @l $0008C5
        lda #$00
        sta @l $0008C6
        lda #$00
        sta @l $0008C7
        rep #$20
        rtl

        .databank 0

        ; 88/E33B

    .endsection Unsorted88E2E9Section


    .section Unsorted88E38ASection

      .al
      .xl

      rlUnknown88E38A ; 88/E38A

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0003
        sta aDialogue.wUnknown0018D0,b
        lda #$0480
        tsb aDialogue.wStatus,b
        lda #$0001
        sta aDialogue.wTextSpeed,b
        lda #$0004
        sta aDialogue.wUnknown00188C,b
        lda #$0040
        sta $18E1,b,x
        lda #$0200
        sta $18DD,b
        lda #$0A1E
        sta $18DB,b,x
        lda #$4000
        sta $18D7,b,x
        lda #$7E00
        sta $18D5,b,x
        lda #$8388
        sta $18D4,b,x
        lda #$2000
        sta aDialogue.wBaseTile,b,x
        lda #$01FF
        sta aDialogue.wClearTile,b
        lda #$1208
        sta wR1
        sep #$20
        lda #$00
        sta wR0+1
        xba
        lda wR1
        sta wR0
        lda wR1+1
        xba
        rep #$20
        lsr a
        lsr a
        clc
        adc wR0
        sta wR0
        ldx aDialogue,b
        lda #$7E00
        sta $18D5,b,x
        lda #$8388
        clc
        adc wR0
        sta $18D4,b,x
        rtl

        .databank 0

        ; 88/E401

    .endsection Unsorted88E38ASection


    .section Unsorted88E401Section

      .al
      .xl

      rsUnknown88E401 ; 88/E401

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        sta wRoutineVariable1,b
        stz wR10
        lda #$0000
        jsl rlFindFactionUnitByCharacterID
        lda wSelectedUnitDataRAMPointer,b
        rts

        .databank 0

        ; 88/E411

      rlUnknown88E411 ; 88/E411

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0002

        _E414
        sta wRoutineVariable1,b
        lda #$0000
        jsl rlFindGenerationIDInFactionSlotData
        lda wSelectedUnitDataRAMPointer,b
        beq _E42C
        jsl rlGetSelectedUnitStates
        bit #UnitStateDead
        beq _E436

        _E42C
        lda wRoutineVariable1,b
        inc a
        cmp #$0019
        bne _E414
        rtl


        _E436
        lda #$EBFD
        sta lR18
        jsl rlDialoguePushToActivePointerStack
        rtl

        .databank 0

        ; 88/E440

      rlUnknown88E440 ; 88/E440

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0002
        jsr rsUnknown88E401
        beq _E465
        lda #$0014
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcc _E465
        lda #(`dialogueEpilogueMemorial88EC34)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88EC34
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E465
        rtl

        .databank 0

        ; 88/E466

      rlUnknown88E466 ; 88/E466

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0003
        jsr rsUnknown88E401
        beq _E48B
        lda #$0015
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcc _E48B
        lda #(`dialogueEpilogueMemorial88EC51)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88EC51
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E48B
        rtl

        .databank 0

        ; 88/E48C

      rlUnknown88E48C ; 88/E48C

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0004
        jsr rsUnknown88E401
        beq _E4B1
        lda #$0016
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcc _E4B1
        lda #(`dialogueEpilogueMemorial88EC6C)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88EC6C
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E4B1
        rtl

        .databank 0

        ; 88/E4B2

      rlUnknown88E4B2 ; 88/E4B2

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$000E
        jsr rsUnknown88E401
        beq _E4D7
        lda #$001E
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcc _E4D7
        lda #(`dialogueEpilogueMemorial88EC8A)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88EC8A
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E4D7
        rtl

        .databank 0

        ; 88/E4D8

      rlUnknown88E4D8 ; 88/E4D8

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$000A
        jsr rsUnknown88E401
        beq _E4FD
        lda #$001A
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcc _E4FD
        lda #(`dialogueEpilogueMemorial88ECA4)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88ECA4
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E4FD
        rtl

        .databank 0

        ; 88/E4FE

      rlUnknown88E4FE ; 88/E4FE

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0013
        jsr rsUnknown88E401
        beq _E523
        lda #$0021
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcc _E523
        lda #(`dialogueEpilogueMemorial88ECC0)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88ECC0
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E523
        rtl

        .databank 0

        ; 88/E524

      rlUnknown88E524 ; 88/E524

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0017
        jsr rsUnknown88E401
        beq _E549
        lda #$002A
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcc _E549
        lda #(`dialogueEpilogueMemorial88ECDA)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88ECDA
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E549
        rtl

        .databank 0

        ; 88/E54A

      rlUnknown88E54A ; 88/E54A

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0007
        jsr rsUnknown88E401
        beq _E56F
        lda #$0017
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcc _E56F
        lda #(`dialogueEpilogueMemorial88ECF7)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88ECF7
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E56F
        rtl

        .databank 0

        ; 88/E570

      rlUnknown88E570 ; 88/E570

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$000B
        jsr rsUnknown88E401
        beq _E595
        lda #$001B
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcc _E595
        lda #(`dialogueEpilogueMemorial88ED16)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88ED16
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E595
        rtl

        .databank 0

        ; 88/E596

      rlUnknown88E596 ; 88/E596

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0012
        jsr rsUnknown88E401
        beq _E5BB
        lda #$0020
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcc _E5BB
        lda #(`dialogueEpilogueMemorial88ED32)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88ED32
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E5BB
        rtl

        .databank 0

        ; 88/E5BC

      rlUnknown88E5BC ; 88/E5BC

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$000D
        jsr rsUnknown88E401
        beq _E5E1
        lda #$001D
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcc _E5E1
        lda #(`dialogueEpilogueMemorial88ED4E)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88ED4E
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E5E1
        rtl

        .databank 0

        ; 88/E5E2

      rlUnknown88E5E2 ; 88/E5E2

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0009
        jsr rsUnknown88E401
        beq _E607
        lda #$0019
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcc _E607
        lda #(`dialogueEpilogueMemorial88ED68)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88ED68
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E607
        rtl

        .databank 0

        ; 88/E608

      rlUnknown88E608 ; 88/E608

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$000F
        jsr rsUnknown88E401
        beq _E62D
        lda #$001F
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcc _E62D
        lda #(`dialogueEpilogueMemorial88ED7D)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88ED7D
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E62D
        rtl

        .databank 0

        ; 88/E62E

      rlUnknown88E62E ; 88/E62E

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0008
        jsr rsUnknown88E401
        beq _E653
        lda #$0018
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcc _E653
        lda #(`dialogueEpilogueMemorial88ED92)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88ED92
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E653
        rtl

        .databank 0

        ; 88/E654

      rlUnknown88E654 ; 88/E654

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0014
        jsr rsUnknown88E401
        beq _E679
        lda #$0025
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcc _E679
        lda #(`dialogueEpilogueMemorial88EDAD)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88EDAD
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E679
        rtl

        .databank 0

        ; 88/E67A

      rlUnknown88E67A ; 88/E67A

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0016
        jsr rsUnknown88E401
        beq _E69F
        lda #$0029
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcc _E69F
        lda #(`dialogueEpilogueMemorial88EDCC)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88EDCC
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E69F
        rtl

        .databank 0

        ; 88/E6A0

      rlUnknown88E6A0 ; 88/E6A0

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$000C
        jsr rsUnknown88E401
        beq _E6C5
        lda #$001C
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcc _E6C5
        lda #(`dialogueEpilogueMemorial88EDE9)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88EDE9
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E6C5
        rtl

        .databank 0

        ; 88/E6C6

      rlUnknown88E6C6 ; 88/E6C6

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0015
        jsr rsUnknown88E401
        beq _E6EB
        lda #$002C
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcc _E6EB
        lda #(`dialogueEpilogueMemorial88EE03)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88EE03
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E6EB
        rtl

        .databank 0

        ; 88/E6EC

      rlUnknown88E6EC ; 88/E6EC

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0018
        jsr rsUnknown88E401
        beq _E711
        lda #$002B
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcc _E711
        lda #(`dialogueEpilogueMemorial88EE1F)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88EE1F
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E711
        rtl

        .databank 0

        ; 88/E712

      rlUnknown88E712 ; 88/E712

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0002
        jsr rsUnknown88E401
        beq _E737
        lda #$0014
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcs _E737
        lda #(`dialogueEpilogueMemorial88EC34)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88EC34
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E737
        rtl

        .databank 0

        ; 88/E738

      rlUnknown88E738 ; 88/E738

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0003
        jsr rsUnknown88E401
        beq _E75D
        lda #$0015
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcs _E75D
        lda #(`dialogueEpilogueMemorial88EC51)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88EC51
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E75D
        rtl

        .databank 0

        ; 88/E75E

      rlUnknown88E75E ; 88/E75E

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0004
        jsr rsUnknown88E401
        beq _E783
        lda #$0016
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcs _E783
        lda #(`dialogueEpilogueMemorial88EC6C)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88EC6C
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E783
        rtl

        .databank 0

        ; 88/E784

      rlUnknown88E784 ; 88/E784

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$000E
        jsr rsUnknown88E401
        beq _E7A9
        lda #$001E
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcs _E7A9
        lda #(`dialogueEpilogueMemorial88EC8A)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88EC8A
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E7A9
        rtl

        .databank 0

        ; 88/E7AA

      rlUnknown88E7AA ; 88/E7AA

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$000A
        jsr rsUnknown88E401
        beq _E7CF
        lda #$001A
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcs _E7CF
        lda #(`dialogueEpilogueMemorial88ECA4)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88ECA4
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E7CF
        rtl

        .databank 0

        ; 88/E7D0

      rlUnknown88E7D0 ; 88/E7D0

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0013
        jsr rsUnknown88E401
        beq _E7F5
        lda #$0021
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcs _E7F5
        lda #(`dialogueEpilogueMemorial88ECC0)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88ECC0
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E7F5
        rtl

        .databank 0

        ; 88/E7F6

      rlUnknown88E7F6 ; 88/E7F6

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0017
        jsr rsUnknown88E401
        beq _E81B
        lda #$002A
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcs _E81B
        lda #(`dialogueEpilogueMemorial88ECDA)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88ECDA
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E81B
        rtl

        .databank 0

        ; 88/E81C

      rlUnknown88E81C ; 88/E81C

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0007
        jsr rsUnknown88E401
        beq _E841
        lda #$0017
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcs _E841
        lda #(`dialogueEpilogueMemorial88ECF7)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88ECF7
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E841
        rtl

        .databank 0

        ; 88/E842

      rlUnknown88E842 ; 88/E842

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$000B
        jsr rsUnknown88E401
        beq _E867
        lda #$001B
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcs _E867
        lda #(`dialogueEpilogueMemorial88ED16)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88ED16
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E867
        rtl

        .databank 0

        ; 88/E868

      rlUnknown88E868 ; 88/E868

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0012
        jsr rsUnknown88E401
        beq _E88D
        lda #$0020
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcs _E88D
        lda #(`dialogueEpilogueMemorial88ED32)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88ED32
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E88D
        rtl

        .databank 0

        ; 88/E88E

      rlUnknown88E88E ; 88/E88E

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$000D
        jsr rsUnknown88E401
        beq _E8B3
        lda #$001D
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcs _E8B3
        lda #(`dialogueEpilogueMemorial88ED4E)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88ED4E
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E8B3
        rtl

        .databank 0

        ; 88/E8B4

      rlUnknown88E8B4 ; 88/E8B4

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0009
        jsr rsUnknown88E401
        beq _E8D9
        lda #$0019
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcs _E8D9
        lda #(`dialogueEpilogueMemorial88ED68)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88ED68
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E8D9
        rtl

        .databank 0

        ; 88/E8DA

      rlUnknown88E8DA ; 88/E8DA

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$000F
        jsr rsUnknown88E401
        beq _E8FF
        lda #$001F
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcs _E8FF
        lda #(`dialogueEpilogueMemorial88ED7D)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88ED7D
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E8FF
        rtl

        .databank 0

        ; 88/E900

      rlUnknown88E900 ; 88/E900

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0008
        jsr rsUnknown88E401
        beq _E925
        lda #$0018
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcs _E925
        lda #(`dialogueEpilogueMemorial88ED92)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88ED92
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E925
        rtl

        .databank 0

        ; 88/E926

      rlUnknown88E926 ; 88/E926

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0014
        jsr rsUnknown88E401
        beq _E94B
        lda #$0025
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcs _E94B
        lda #(`dialogueEpilogueMemorial88EDAD)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88EDAD
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E94B
        rtl

        .databank 0

        ; 88/E94C

      rlUnknown88E94C ; 88/E94C

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0016
        jsr rsUnknown88E401
        beq _E971
        lda #$0029
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcs _E971
        lda #(`dialogueEpilogueMemorial88EDCC)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88EDCC
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E971
        rtl

        .databank 0

        ; 88/E972

      rlUnknown88E972 ; 88/E972

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$000C
        jsr rsUnknown88E401
        beq _E997
        lda #$001C
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcs _E997
        lda #(`dialogueEpilogueMemorial88EDE9)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88EDE9
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E997
        rtl

        .databank 0

        ; 88/E998

      rlUnknown88E998 ; 88/E998

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0015
        jsr rsUnknown88E401
        beq _E9BD
        lda #$002C
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcs _E9BD
        lda #(`dialogueEpilogueMemorial88EE03)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88EE03
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E9BD
        rtl

        .databank 0

        ; 88/E9BE

      rlUnknown88E9BE ; 88/E9BE

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0018
        jsr rsUnknown88E401
        beq _E9E3
        lda #$002B
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcs _E9E3
        lda #(`dialogueEpilogueMemorial88EE1F)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88EE1F
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E9E3
        rtl

        .databank 0

        ; 88/E9E4

    .endsection Unsorted88E401Section


    .section Table88E9E4Section

      .al
      .xl

        .byte $01 ; 88/E9E4

      dialogueEpilogueMemorial88E9E5 .include "../../text/dialogue/Epilogue/Memorial88E9E5.dialogue.txt" ; 88/E9E5
      dialogueEpilogueMemorial88EBFD .include "../../text/dialogue/Epilogue/Memorial88EBFD.dialogue.txt" ; 88/EBFD
      dialogueEpilogueMemorial88EC34 .include "../../text/dialogue/Epilogue/Memorial88EC34.dialogue.txt" ; 88/EC34
      dialogueEpilogueMemorial88EC51 .include "../../text/dialogue/Epilogue/Memorial88EC51.dialogue.txt" ; 88/EC51
      dialogueEpilogueMemorial88EC6C .include "../../text/dialogue/Epilogue/Memorial88EC6C.dialogue.txt" ; 88/EC6C
      dialogueEpilogueMemorial88EC8A .include "../../text/dialogue/Epilogue/Memorial88EC8A.dialogue.txt" ; 88/EC8A
      dialogueEpilogueMemorial88ECA4 .include "../../text/dialogue/Epilogue/Memorial88ECA4.dialogue.txt" ; 88/ECA4
      dialogueEpilogueMemorial88ECC0 .include "../../text/dialogue/Epilogue/Memorial88ECC0.dialogue.txt" ; 88/ECC0
      dialogueEpilogueMemorial88ECDA .include "../../text/dialogue/Epilogue/Memorial88ECDA.dialogue.txt" ; 88/ECDA
      dialogueEpilogueMemorial88ECF7 .include "../../text/dialogue/Epilogue/Memorial88ECF7.dialogue.txt" ; 88/ECF7
      dialogueEpilogueMemorial88ED16 .include "../../text/dialogue/Epilogue/Memorial88ED16.dialogue.txt" ; 88/ED16
      dialogueEpilogueMemorial88ED32 .include "../../text/dialogue/Epilogue/Memorial88ED32.dialogue.txt" ; 88/ED32
      dialogueEpilogueMemorial88ED4E .include "../../text/dialogue/Epilogue/Memorial88ED4E.dialogue.txt" ; 88/ED4E
      dialogueEpilogueMemorial88ED68 .include "../../text/dialogue/Epilogue/Memorial88ED68.dialogue.txt" ; 88/ED68
      dialogueEpilogueMemorial88ED7D .include "../../text/dialogue/Epilogue/Memorial88ED7D.dialogue.txt" ; 88/ED7D
      dialogueEpilogueMemorial88ED92 .include "../../text/dialogue/Epilogue/Memorial88ED92.dialogue.txt" ; 88/ED92
      dialogueEpilogueMemorial88EDAD .include "../../text/dialogue/Epilogue/Memorial88EDAD.dialogue.txt" ; 88/EDAD
      dialogueEpilogueMemorial88EDCC .include "../../text/dialogue/Epilogue/Memorial88EDCC.dialogue.txt" ; 88/EDCC
      dialogueEpilogueMemorial88EDE9 .include "../../text/dialogue/Epilogue/Memorial88EDE9.dialogue.txt" ; 88/EDE9
      dialogueEpilogueMemorial88EE03 .include "../../text/dialogue/Epilogue/Memorial88EE03.dialogue.txt" ; 88/EE03
      dialogueEpilogueMemorial88EE1F .include "../../text/dialogue/Epilogue/Memorial88EE1F.dialogue.txt" ; 88/EE1F

      aUnknown88EE3C ; 88/EE3C
        .word 4 ; sprite count
        .structSpriteEntry (  -3,   -3), $00, SpriteSmall, $000, 3, 0, false, false
        .structSpriteEntry (  11,   -3), $00, SpriteSmall, $001, 3, 0, false, false
        .structSpriteEntry (  -3,   11), $00, SpriteSmall, $010, 3, 0, false, false
        .structSpriteEntry (  11,   11), $00, SpriteSmall, $011, 3, 0, false, false

      aUnknown88EE52 ; 88/EE52
        .word 4 ; sprite count
        .structSpriteEntry (  -2,   -2), $00, SpriteSmall, $000, 3, 0, false, false
        .structSpriteEntry (  10,   -2), $00, SpriteSmall, $001, 3, 0, false, false
        .structSpriteEntry (  -2,   10), $00, SpriteSmall, $010, 3, 0, false, false
        .structSpriteEntry (  10,   10), $00, SpriteSmall, $011, 3, 0, false, false

      aUnknown88EE68 ; 88/EE68
        .word 4 ; sprite count
        .structSpriteEntry (  -3,   -3), $00, SpriteSmall, $000, 3, 0, false, false
        .structSpriteEntry (  11,   -3), $00, SpriteSmall, $001, 3, 0, false, false
        .structSpriteEntry (  -3,   11), $00, SpriteSmall, $010, 2, 0, false, false
        .structSpriteEntry (  11,   11), $00, SpriteSmall, $011, 2, 0, false, false

      aUnknown88EE7E ; 88/EE7E
        .word 4 ; sprite count
        .structSpriteEntry (  -3,   -3), $00, SpriteSmall, $000, 3, 0, false, false
        .structSpriteEntry (  27,   -3), $00, SpriteSmall, $001, 3, 0, false, false
        .structSpriteEntry (  -3,   23), $00, SpriteSmall, $010, 3, 0, false, false
        .structSpriteEntry (  27,   23), $00, SpriteSmall, $011, 3, 0, false, false

      aUnknown88EE94 ; 88/EE94
        .word 4 ; sprite count
        .structSpriteEntry (  -2,   -2), $00, SpriteSmall, $000, 3, 0, false, false
        .structSpriteEntry (  26,   -2), $00, SpriteSmall, $001, 3, 0, false, false
        .structSpriteEntry (  -2,   22), $00, SpriteSmall, $010, 3, 0, false, false
        .structSpriteEntry (  26,   22), $00, SpriteSmall, $011, 3, 0, false, false

      aUnknown88EEAA ; 88/EEAA
        .word 1 ; sprite count
        .structSpriteEntry (   0,    0), $21, SpriteLarge, $080, 3, 0, false, false


    .endsection Table88E9E4Section


    .section Unsorted88EEB1Section

      .al
      .xl

      rlUnknown88EEB1 ; 88/EEB1

        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsl rlGetKeptRanking
        beq _EEC2
        cmp #$0006
        bcs _EEC2
        sta wR0,b
        bra _EEC8


        _EEC2
        lda #$0006
        sta wR0,b

        _EEC8
        lda #$0007
        sec
        sbc wR0,b
        asl a
        dec a
        sta $1B49,b
        sta $1B4B,b
        plx
        rtl

        .databank 0

      rlUnknown88EED9 ; 88/EED9

        .al
        .xl
        .autsiz
        .databank ?

        lda $1B49,b
        ora #$0001
        sta $1B49,b
        phx
        lda $1B49,b
        asl a
        clc
        adc $1B49,b
        tax
        lda @l aUnknown88EF0D,x
        sta lR18
        lda @l aUnknown88EF0D+1,x
        sta lR18+1
        phk
        pea #<>(+)-1
        jml [lR18]
        +
        lda $1B49,b
        dec a
        bpl +
        lda $1B4B,b
        +
        sta $1B49,b
        plx
        rtl

        .databank 0

    .endsection Unsorted88EEB1Section


    .section Unsorted88EF0DSection

      .al
      .xl

      aUnknown88EF0D ; 88/EF0D

        ; 12 long pointers to routines.

        .long rlUnknown9EEED3, rlUnknown9EEDB5, rlUnknown88F47C
        .long rlUnknown88EF31, rlUnknown88F5B3, rlUnknown88F01D
        .long rlUnknown88F6D1, rlUnknown88F13B, rlUnknown88F7EF
        .long rlUnknown88F259, rlUnknown88F8F4, rlUnknown88F35E

      rlUnknown88EF31 ; 88/EF31

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phb
        jsl rlClearBattleData
        pea #$7F00
        plb
        .databank ?
        plb
        .databank ?
        lda #$0002
        sta aActionStructUnit1.ClassID
        lda #$0000
        sta aActionStructUnit1.Gender
        lda #$0021
        sta aActionStructUnit1.XPosition
        lda #$0017
        sta aActionStructUnit1.YPosition
        lda #$0031
        sta aActionStructUnit1.WeaponID
        lda #$0000
        sta aActionStructUnit1.Unknown
        lda #$0000
        sta aMapAction.wUnknown7F4562
        sta aActionStructUnit1
        lda #$0029
        sta aActionStructUnit2.ClassID
        lda #$0000
        sta aActionStructUnit2.Gender
        lda #$0021
        sta aActionStructUnit2.XPosition
        lda #$0019
        sta aActionStructUnit2.YPosition
        lda #$002D
        sta aActionStructUnit2.WeaponID
        lda #$0000
        sta aActionStructUnit2.Unknown
        lda #$0001
        sta aMapAction.wDefenderAllegiance
        sta aActionStructUnit2
        lda #$0002
        sta wBattleDistance
        sep #$20
        lda #$00
        sta $7E4EA9
        rep #$20
        lda #(`aBattleRoundsData)<<8
        sta lR18+1
        lda #<>aBattleRoundsData
        sta lR18
        lda #$0020
        sta wR0
        lda #$0002
        sta wR1
        jsl rlBuildRAMStructHeader
        lda #$0135
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$7F00
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$FFFF
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        plb
        .databank ?
        plx
        rtl

        .databank 0

      rlUnknown88F01D ; 88/F01D

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phb
        jsl rlClearBattleData
        pea #$7F00
        plb
        .databank ?
        plb
        .databank ?
        lda #$0000
        sta aActionStructUnit1.ClassID
        lda #$0000
        sta aActionStructUnit1.Gender
        lda #$0034
        sta aActionStructUnit1.XPosition
        lda #$0022
        sta aActionStructUnit1.YPosition
        lda #$0001
        sta aActionStructUnit1.WeaponID
        lda #$0000
        sta aActionStructUnit1.Unknown
        lda #$0000
        sta aMapAction.wUnknown7F4562
        sta aActionStructUnit1
        lda #$0016
        sta aActionStructUnit2.ClassID
        lda #$0001
        sta aActionStructUnit2.Gender
        lda #$0034
        sta aActionStructUnit2.XPosition
        lda #$0023
        sta aActionStructUnit2.YPosition
        lda #$0003
        sta aActionStructUnit2.WeaponID
        lda #$0000
        sta aActionStructUnit2.Unknown
        lda #$0001
        sta aMapAction.wDefenderAllegiance
        sta aActionStructUnit2
        lda #$0001
        sta wBattleDistance
        sep #$20
        lda #$00
        sta $7E4EA9
        rep #$20
        lda #(`aBattleRoundsData)<<8
        sta lR18+1
        lda #<>aBattleRoundsData
        sta lR18
        lda #$0020
        sta wR0
        lda #$0002
        sta wR1
        jsl rlBuildRAMStructHeader
        lda #$0008
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$0105
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$0009
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$7F00
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$FFFF
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        plb
        .databank ?
        plx
        rtl

        .databank 0

        ; 88/F13B

      rlUnknown88F13B ; 88/F13B

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phb
        jsl rlClearBattleData
        pea #$7F00
        plb
        .databank ?
        plb
        .databank ?
        lda #$0011
        sta aActionStructUnit1.ClassID
        lda #$0001
        sta aActionStructUnit1.Gender
        lda #$0023
        sta aActionStructUnit1.XPosition
        lda #$0032
        sta aActionStructUnit1.YPosition
        lda #$0002
        sta aActionStructUnit1.WeaponID
        lda #$0000
        sta aActionStructUnit1.Unknown
        lda #$0003
        sta aMapAction.wUnknown7F4562
        sta aActionStructUnit1
        lda #$0011
        sta aActionStructUnit2.ClassID
        lda #$0001
        sta aActionStructUnit2.Gender
        lda #$0024
        sta aActionStructUnit2.XPosition
        lda #$0032
        sta aActionStructUnit2.YPosition
        lda #$001E
        sta aActionStructUnit2.WeaponID
        lda #$0000
        sta aActionStructUnit2.Unknown
        lda #$0001
        sta aMapAction.wDefenderAllegiance
        sta aActionStructUnit2
        lda #$0001
        sta wBattleDistance
        sep #$20
        lda #$00
        sta $7E4EA9
        rep #$20
        lda #(`aBattleRoundsData)<<8
        sta lR18+1
        lda #<>aBattleRoundsData
        sta lR18
        lda #$0020
        sta wR0
        lda #$0002
        sta wR1
        jsl rlBuildRAMStructHeader
        lda #$0008
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$0101
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$0115
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$7F00
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$FFFF
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        plb
        .databank ?
        plx
        rtl

        .databank 0

        ; 88/F259

      rlUnknown88F259 ; 88/F259

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phb
        jsl rlClearBattleData
        pea #$7F00
        plb
        .databank ?
        plb
        .databank ?
        lda #$0007
        sta aActionStructUnit1.ClassID
        lda #$0000
        sta aActionStructUnit1.Gender
        lda #$001E
        sta aActionStructUnit1.XPosition
        lda #$0036
        sta aActionStructUnit1.YPosition
        lda #$0024
        sta aActionStructUnit1.WeaponID
        lda #$0000
        sta aActionStructUnit1.Unknown
        lda #$0000
        sta aMapAction.wUnknown7F4562
        sta aActionStructUnit1
        lda #$0009
        sta aActionStructUnit2.ClassID
        lda #$0000
        sta aActionStructUnit2.Gender
        lda #$001D
        sta aActionStructUnit2.XPosition
        lda #$0036
        sta aActionStructUnit2.YPosition
        lda #$0014
        sta aActionStructUnit2.WeaponID
        lda #$0000
        sta aActionStructUnit2.Unknown
        lda #$0001
        sta aMapAction.wDefenderAllegiance
        sta aActionStructUnit2
        lda #$0001
        sta wBattleDistance
        sep #$20
        lda #$00
        sta $7E4EA9
        rep #$20
        lda #(`aBattleRoundsData)<<8
        sta lR18+1
        lda #<>aBattleRoundsData
        sta lR18
        lda #$0020
        sta wR0
        lda #$0002
        sta wR1
        jsl rlBuildRAMStructHeader
        lda #$0009
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$0008
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$7F00
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$FFFF
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        plb
        .databank ?
        plx
        rtl

        .databank 0

        ; 88/F35E

      rlUnknown88F35E ; 88/F35E

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phb
        jsl rlClearBattleData
        pea #$7F00
        plb
        .databank ?
        plb
        .databank ?
        lda #$0006
        sta aActionStructUnit1.ClassID
        lda #$0000
        sta aActionStructUnit1.Gender
        lda #$0037
        sta aActionStructUnit1.XPosition
        lda #$0007
        sta aActionStructUnit1.YPosition
        lda #$0015
        sta aActionStructUnit1.WeaponID
        lda #$0000
        sta aActionStructUnit1.Unknown
        lda #$0000
        sta aMapAction.wUnknown7F4562
        sta aActionStructUnit1
        lda #$001C
        sta aActionStructUnit2.ClassID
        lda #$0000
        sta aActionStructUnit2.Gender
        lda #$0037
        sta aActionStructUnit2.XPosition
        lda #$0006
        sta aActionStructUnit2.YPosition
        lda #$002C
        sta aActionStructUnit2.WeaponID
        lda #$0000
        sta aActionStructUnit2.Unknown
        lda #$0001
        sta aMapAction.wDefenderAllegiance
        sta aActionStructUnit2
        lda #$0001
        sta wBattleDistance
        sep #$20
        lda #$00
        sta $7E4EA9
        rep #$20
        lda #(`aBattleRoundsData)<<8
        sta lR18+1
        lda #<>aBattleRoundsData
        sta lR18
        lda #$0020
        sta wR0
        lda #$0002
        sta wR1
        jsl rlBuildRAMStructHeader
        lda #$0101
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$0100
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$0114
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$7F00
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$FFFF
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        plb
        .databank ?
        plx
        rtl

        .databank 0

        ; 88/F47C

      rlUnknown88F47C ; 88/F47C

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phb
        jsl rlClearBattleData
        pea #$7F00
        plb
        .databank ?
        plb
        .databank ?
        lda #$0003
        sta aActionStructUnit1.ClassID
        lda #$0000
        sta aActionStructUnit1.Gender
        lda #$002E
        sta aActionStructUnit1.XPosition
        lda #$001D
        sta aActionStructUnit1.YPosition
        lda #$0029
        sta aActionStructUnit1.WeaponID
        lda #$0000
        sta aActionStructUnit1.Unknown
        lda #$0000
        sta aMapAction.wUnknown7F4562
        sta aActionStructUnit1
        lda #$0027
        sta aActionStructUnit2.ClassID
        lda #$0000
        sta aActionStructUnit2.Gender
        lda #$002D
        sta aActionStructUnit2.XPosition
        lda #$001D
        sta aActionStructUnit2.YPosition
        lda #$0029
        sta aActionStructUnit2.WeaponID
        lda #$0000
        sta aActionStructUnit2.Unknown
        lda #$0001
        sta aMapAction.wDefenderAllegiance
        sta aActionStructUnit2
        lda #$0001
        sta wBattleDistance
        sep #$20
        lda #$00
        sta $7E4EA9
        rep #$20
        lda #(`aBattleRoundsData)<<8
        sta lR18+1
        lda #<>aBattleRoundsData
        sta lR18
        lda #$0020
        sta wR0
        lda #$0002
        sta wR1
        jsl rlBuildRAMStructHeader
        lda #$0100
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$0101
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$0100
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$0101
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$7F00
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$FFFF
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        plb
        .databank ?
        plx
        rtl

        .databank 0

        ; 88/F5B3

      rlUnknown88F5B3 ; 88/F5B3

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phb
        jsl rlClearBattleData
        pea #$7F00
        plb
        .databank ?
        plb
        .databank ?
        lda #$003C
        sta aActionStructUnit1.ClassID
        lda #$0000
        sta aActionStructUnit1.Gender
        lda #$000D
        sta aActionStructUnit1.XPosition
        lda #$000A
        sta aActionStructUnit1.YPosition
        lda #$004E
        sta aActionStructUnit1.WeaponID
        lda #$0000
        sta aActionStructUnit1.Unknown
        lda #$0000
        sta aMapAction.wUnknown7F4562
        sta aActionStructUnit1
        lda #$0035
        sta aActionStructUnit2.ClassID
        lda #$0000
        sta aActionStructUnit2.Gender
        lda #$000E
        sta aActionStructUnit2.XPosition
        lda #$000A
        sta aActionStructUnit2.YPosition
        lda #$003F
        sta aActionStructUnit2.WeaponID
        lda #$0000
        sta aActionStructUnit2.Unknown
        lda #$0001
        sta aMapAction.wDefenderAllegiance
        sta aActionStructUnit2
        lda #$0001
        sta wBattleDistance
        sep #$20
        lda #$00
        sta $7E4EA9
        rep #$20
        lda #(`aBattleRoundsData)<<8
        sta lR18+1
        lda #<>aBattleRoundsData
        sta lR18
        lda #$0020
        sta wR0
        lda #$0002
        sta wR1
        jsl rlBuildRAMStructHeader
        lda #$0141
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$0140
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$0140
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$7F00
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$FFFF
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        plb
        .databank ?
        plx
        rtl

        .databank 0

        ; 88/F6D1

      rlUnknown88F6D1 ; 88/F6D1

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phb
        jsl rlClearBattleData
        pea #$7F00
        plb
        .databank ?
        plb
        .databank ?
        lda #$0013
        sta aActionStructUnit1.ClassID
        lda #$0000
        sta aActionStructUnit1.Gender
        lda #$002B
        sta aActionStructUnit1.XPosition
        lda #$002F
        sta aActionStructUnit1.YPosition
        lda #$0024
        sta aActionStructUnit1.WeaponID
        lda #$0000
        sta aActionStructUnit1.Unknown
        lda #$0000
        sta aMapAction.wUnknown7F4562
        sta aActionStructUnit1
        lda #$0014
        sta aActionStructUnit2.ClassID
        lda #$0000
        sta aActionStructUnit2.Gender
        lda #$002C
        sta aActionStructUnit2.XPosition
        lda #$002F
        sta aActionStructUnit2.YPosition
        lda #$0023
        sta aActionStructUnit2.WeaponID
        lda #$0000
        sta aActionStructUnit2.Unknown
        lda #$0001
        sta aMapAction.wDefenderAllegiance
        sta aActionStructUnit2
        lda #$0001
        sta wBattleDistance
        sep #$20
        lda #$00
        sta $7E4EA9
        rep #$20
        lda #(`aBattleRoundsData)<<8
        sta lR18+1
        lda #<>aBattleRoundsData
        sta lR18
        lda #$0020
        sta wR0
        lda #$0002
        sta wR1
        jsl rlBuildRAMStructHeader
        lda #$0109
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$0104
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$0114
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$7F00
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$FFFF
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        plb
        .databank ?
        plx
        rtl

        .databank 0

        ; 88/F7EF

      rlUnknown88F7EF ; 88/F7EF

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phb
        jsl rlClearBattleData
        pea #$7F00
        plb
        .databank ?
        plb
        .databank ?
        lda #$002D
        sta aActionStructUnit1.ClassID
        lda #$0000
        sta aActionStructUnit1.Gender
        lda #$0023
        sta aActionStructUnit1.XPosition
        lda #$0013
        sta aActionStructUnit1.YPosition
        lda #$004B
        sta aActionStructUnit1.WeaponID
        lda #$0000
        sta aActionStructUnit1.Unknown
        lda #$0000
        sta aMapAction.wUnknown7F4562
        sta aActionStructUnit1
        lda #$003A
        sta aActionStructUnit2.ClassID
        lda #$0001
        sta aActionStructUnit2.Gender
        lda #$0024
        sta aActionStructUnit2.XPosition
        lda #$0013
        sta aActionStructUnit2.YPosition
        lda #$0046
        sta aActionStructUnit2.WeaponID
        lda #$0000
        sta aActionStructUnit2.Unknown
        lda #$0001
        sta aMapAction.wDefenderAllegiance
        sta aActionStructUnit2
        lda #$0001
        sta wBattleDistance
        sep #$20
        lda #$00
        sta $7E4EA9
        rep #$20
        lda #(`aBattleRoundsData)<<8
        sta lR18+1
        lda #<>aBattleRoundsData
        sta lR18
        lda #$0020
        sta wR0
        lda #$0002
        sta wR1
        jsl rlBuildRAMStructHeader
        lda #$0144
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$0154
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$7F00
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$FFFF
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        plb
        .databank ?
        plx
        rtl

        .databank 0

        ; 88/F8F4

      rlUnknown88F8F4 ; 88/F8F4

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phb
        jsl rlClearBattleData
        pea #$7F00
        plb
        .databank ?
        plb
        .databank ?
        lda #$0006
        sta aActionStructUnit1.ClassID
        lda #$0000
        sta aActionStructUnit1.Gender
        lda #$000F
        sta aActionStructUnit1.XPosition
        lda #$0005
        sta aActionStructUnit1.YPosition
        lda #$0015
        sta aActionStructUnit1.WeaponID
        lda #$0000
        sta aActionStructUnit1.Unknown
        lda #$0019
        sta aActionStructUnit1.CharacterID
        lda #$0000
        sta aMapAction.wUnknown7F4562
        sta aActionStructUnit1
        lda #$001B
        sta aActionStructUnit2.ClassID
        lda #$0000
        sta aActionStructUnit2.Gender
        lda #$000F
        sta aActionStructUnit2.XPosition
        lda #$0004
        sta aActionStructUnit2.YPosition
        lda #$0041
        sta aActionStructUnit2.WeaponID
        lda #$0000
        sta aActionStructUnit2.Unknown
        lda #$0001
        sta aMapAction.wDefenderAllegiance
        sta aActionStructUnit2
        lda #$0001
        sta wBattleDistance
        sep #$20
        lda #$00
        sta $7E4EA9
        rep #$20
        lda #(`aBattleRoundsData)<<8
        sta lR18+1
        lda #<>aBattleRoundsData
        sta lR18
        lda #$0020
        sta wR0
        lda #$0002
        sta wR1
        jsl rlBuildRAMStructHeader
        lda #$0149
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$0100
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$0104
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$7F00
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$FFFF
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        plb
        .databank ?
        plx
        rtl

        .databank 0

        ; 88/FA19

    .endsection Unsorted88EF0DSection
