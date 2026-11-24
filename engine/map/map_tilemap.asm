; Streaming the map into VRAM as the camera moves. The map is 16x16-pixel tiles:
; aMapData holds a tile ID for each (wMapTileIDMask masks it), and each ID is four
; 8x8 tilemap entries at $7F0000. When the camera moves a row or column of the
; screen, it is built into a buffer ($05DC for a row, $059C for a column) and
; rlUploadMapRowAndColumn copies it to the map's tilemap at VRAM $5000 in VBlank.
;
; The range overlay (the blue and red squares of a selected unit, on BG3) is built
; the same way from aMovementMap into $06DC/$069C and copied to $5800. aMovementMap
; is a 64x64 window around the unit (wMovementMapWindow* at $071C-$0722).
;
; rlRedrawVisibleMapTilemap and rlRedrawRangeOverlayTilemap rebuild the whole
; screen at once. Bank $88. At the end, from bank $81, an IRQ (aMapRowUploadIRQ)
; that does the upload in forced blank partway down the screen during some events.


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
        sta wMapSavedScrollXPixels,b
        lda wMapScrollYPixels,b
        sta wMapSavedScrollYPixels,b
        clc
        adc #$0100
        sta wMapScrollYPixels,b
        lda #8
        sta wMapScrollSpeed,b

        stz wMapColumnUploadFlag,b
        stz wMapRowUploadFlag,b

        lda wMapSavedScrollYPixels,b
        and #$00F8
        asl a
        asl a
        asl a
        clc
        adc #$07C0
        and #$07FF
        sta wTilemapRedrawOffset,b
        
          -
          jsr rsMapScrollUpSetBGOFS
          jsl rlBuildMapTopRow
          jsr rsCopyMapRowToTilemapBuffer

          lda wMapSavedScrollYPixels,b
          cmp wMapScrollYPixels,b
          bcc -

        jsl rlDMAByStruct
          .structDMAToVRAM $7E7388, $0800, $80, $A000

        lda wMapSavedScrollXPixels,b
        sta wMapScrollXPixels,b
        lda wMapSavedScrollYPixels,b
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

        ldx wTilemapRedrawOffset,b
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
        lda wTilemapRedrawOffset,b
        sec
        sbc #$0040
        sta wTilemapRedrawOffset,b
        bpl _84A5
        lda #$07C0
        sta wTilemapRedrawOffset,b

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
        sta wMapSavedScrollXPixels,b
        lda wMapScrollYPixels,b
        sta wMapSavedScrollYPixels,b
        clc
        adc #$0100
        sta wMapScrollYPixels,b
        lda #$0008
        sta wMapScrollSpeed,b
        lda wMapSavedScrollYPixels,b
        and #$00F8
        asl a
        asl a
        asl a
        clc
        adc #$07C0
        and #$07FF
        sta wTilemapRedrawOffset,b

        _84DB
        jsr rsMapScrollUpSetBGOFS
        jsl rlBuildRangeOverlayRowIntoTilemap
        lda wMapSavedScrollYPixels,b
        cmp wMapScrollYPixels,b
        bcc _84DB
        jsl rlMarkAllMapMenuRowsDirty
        lda wMapSavedScrollXPixels,b
        sta wMapScrollXPixels,b
        sta wBufferBG3HOFS
        lda wMapSavedScrollYPixels,b
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
        stz wMapTileBufferWrapped,b
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
        ldx wTilemapRedrawOffset,b
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
        lda wTilemapRedrawOffset,b
        sec
        sbc #$0040
        sta wTilemapRedrawOffset,b
        bpl _855F
        lda #$07C0
        sta wTilemapRedrawOffset,b

        _855F
        rtl

        .databank 0

        ; 88/8560

    .endsection Unsorted88847DSection


    .section Unsorted8887ECSection

      .al
      .xl

      rlUploadMapRowAndColumn ; 88/87EC

        .al
        .xl
        .autsiz
        .databank ?

        ; VBlank: copies the flagged map row ($05DC) and column ($059C) to the map tilemap at VRAM $5000, and while the range overlay is shown its row ($06DC) and column ($069C) to $5800.

        phb
        php
        phk
        plb
        .databank $88
        lda wMapRowUploadFlag,b
        bne _87F9
        jml _8877


        _87F9
        stz wMapRowUploadFlag,b
        lda wMapRowUploadVRAMOffset,b
        clc
        adc #$5000
        sta $2116,b
        sep #$20
        lda #$80
        sta $2115,b
        lda #$01
        sta $4310,b
        lda #$18
        sta $4311,b
        lda #$DC
        sta $4312,b
        lda #$05
        sta $4313,b
        lda #$00
        sta $4314,b
        lda #$40
        sta $4315,b
        lda #$00
        sta $4316,b
        lda #$02
        sta $420B,b
        rep #$20
        lda wUnitSelectedFlag,b
        beq _8877
        lda wMapRowUploadVRAMOffset,b
        clc
        adc #$5800
        sta $2116,b
        sep #$20
        lda #$80
        sta $2115,b
        lda #$01
        sta $4320,b
        lda #$18
        sta $4321,b
        lda #$DC
        sta $4322,b
        lda #$06
        sta $4323,b
        lda #$00
        sta $4324,b
        lda #$40
        sta $4325,b
        lda #$00
        sta $4326,b
        lda #$04
        sta $420B,b
        rep #$20

        _8877
        lda wMapColumnUploadFlag,b
        bne _8880
        jml _88FE


        _8880
        stz wMapColumnUploadFlag,b
        lda wMapColumnUploadVRAMOffset,b
        clc
        adc #$5000
        sta $2116,b
        sep #$20
        lda #$81
        sta $2115,b
        lda #$01
        sta $4300,b
        lda #$18
        sta $4301,b
        lda #$9C
        sta $4302,b
        lda #$05
        sta $4303,b
        lda #$00
        sta $4304,b
        lda #$40
        sta $4305,b
        lda #$00
        sta $4306,b
        lda #$01
        sta $420B,b
        rep #$20
        lda wUnitSelectedFlag,b
        beq _88FE
        lda wMapColumnUploadVRAMOffset,b
        clc
        adc #$5800
        sta $2116,b
        sep #$20
        lda #$81
        sta $2115,b
        lda #$01
        sta $4320,b
        lda #$18
        sta $4321,b
        lda #$9C
        sta $4322,b
        lda #$06
        sta $4323,b
        lda #$00
        sta $4324,b
        lda #$40
        sta $4325,b
        lda #$00
        sta $4326,b
        lda #$04
        sta $420B,b
        rep #$20

        _88FE
        plp
        plb
        .databank $88
        rtl

        .databank 0

        ; 88/8901

    .endsection Unsorted8887ECSection


    .section Unsorted888901Section

      .al
      .xl

      rsGetMapBottomRowIndex ; 88/8901

        .al
        .autsiz
        .databank ?

        ; Adds 14 rows (the screen height in map tiles) to the aMapData index in wR3; the row size depends on wMapWidthMode.

        lda wMapWidthMode,b
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
        stz wMapTileBufferWrapped,b
        
        lda wMapScrollXPixels,b
        and #$0008
        bne +

          jsr rsBuildMapRowTiles

          lda wUnitSelectedFlag,b
          beq _End

            lda #$00E0
            jsr rsBuildRangeOverlayRow
            bra _End

        +
        jsr rsBuildMapRowTilesHalfOffset

        lda wUnitSelectedFlag,b
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

        stz wMapTileBufferWrapped,b

        lda wMapScrollXPixels,b
        and #$0008
        bne +

          jsr rsBuildMapRowTiles

          lda wUnitSelectedFlag,b
          beq _End

            lda #0
            jsr rsBuildRangeOverlayRow
            bra _End

        +
        jsr rsBuildMapRowTilesHalfOffset

        lda wUnitSelectedFlag,b
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
        and wMapTileIDMask,b
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
        lda wMapTileBufferWrapped,b
        beq +

          cpy wR8
          bcs _End
          bra _Loop

        +
        cpy #64
        bcc _Loop

          inc wMapTileBufferWrapped,b
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
        stz wMapTileBufferWrapped,b
        ldy wR8

        _8A3B
        lda wTempVariable2,b
        cmp wMovementMapWindowTop,b
        bcc _8A66
        cmp wMovementMapWindowBottom,b
        bcs _8A66
        lda wTempVariable1,b
        cmp wMovementMapWindowLeft,b
        bcc _8A66
        cmp wMovementMapWindowRight,b
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
        lda wMapTileBufferWrapped,b
        beq _8A81
        cpy wR8
        bcs _8A92
        bra _8A3B


        _8A81
        cpy #$0040
        bcc _8A8E
        inc wMapTileBufferWrapped,b
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
        and wMapTileIDMask,b
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

          inc wMapTileBufferWrapped,b
          ldy #0

        +
        lda aMapData,x
        and wMapTileIDMask,b
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
        lda wMapTileBufferWrapped,b
        beq +

          cpy wR8
          bcs _End
          bra _8C5B

        +
        cpy #64
        bcc _8C5B

          inc wMapTileBufferWrapped,b
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
        stz wMapTileBufferWrapped,b
        ldy wR8

        _8C88
        lda wTempVariable2,b
        cmp wMovementMapWindowTop,b
        bcc _8CD2
        cmp wMovementMapWindowBottom,b
        bcs _8CD2
        lda wTempVariable1,b
        cmp wMovementMapWindowLeft,b
        bcc _8CD2
        cmp wMovementMapWindowRight,b
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
        inc wMapTileBufferWrapped,b
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
        inc wMapTileBufferWrapped,b
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
        lda wMapTileBufferWrapped,b
        beq _8D11
        cpy wR8
        bcs _8D22
        bra _8D1E


        _8D11
        cpy #$0040
        bcc _8D1E
        inc wMapTileBufferWrapped,b
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
        ; The grid has the unit at (32, 32), so the index is tile - unit + 32 in each coordinate, mod 64. Subtracting
        ; the window's right/bottom edge (unit + 32, never clamped, unlike left/top) gives the same value mod 64.

        lda wTempVariable1,b
        sec
        sbc wMovementMapWindowRight,b
        and #$003F
        sta wR0
        lda wTempVariable2,b
        sec
        sbc wMovementMapWindowBottom,b
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
        sbc wMovementMapWindowRight,b
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

        lda wMapWidthMode,b
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

        lda wMapWidthMode,b
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

          lda wUnitSelectedFlag,b
          beq _End

            lda #$00F8
            jsr rsBuildRangeOverlayColumn
            bra _End

        +
        lda #4
        jsr rsBuildMapColumnTilesHalfOffset

        lda wUnitSelectedFlag,b
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

          lda wUnitSelectedFlag,b
          beq _End

            lda #0
            jsr rsBuildRangeOverlayColumn
            bra _End

        +
        lda #0
        jsr rsBuildMapColumnTilesHalfOffset

        lda wUnitSelectedFlag,b
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

        lda wMapWidthMode,b
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

        lda wMapWidthMode,b
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
          and wMapTileIDMask,b
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
        stz wMapTileBufferWrapped,b
        lda wR3
        sta wR8
        tay

        _8F5E
        lda wTempVariable2,b
        cmp wMovementMapWindowTop,b
        bcc _8F89
        cmp wMovementMapWindowBottom,b
        bcs _8F89
        lda wTempVariable1,b
        cmp wMovementMapWindowLeft,b
        bcc _8F89
        cmp wMovementMapWindowRight,b
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
        sbc wMovementMapWindowRight,b
        and #$003F
        sta wUnknown000790,b
        lda wTempVariable2,b
        sec
        sbc wMovementMapWindowBottom,b
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
        sbc wMovementMapWindowBottom,b
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
        and wMapTileIDMask,b
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
        and wMapTileIDMask,b
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
        stz wMapTileBufferWrapped,b
        lda wR3
        sta wR8
        tay

        _91E8
        lda wTempVariable2,b
        cmp wMovementMapWindowTop,b
        bcc _9232
        cmp wMovementMapWindowBottom,b
        bcs _9232
        lda wTempVariable1,b
        cmp wMovementMapWindowLeft,b
        bcc _9232
        cmp wMovementMapWindowRight,b
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
        inc wMapTileBufferWrapped,b
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

    .endsection Unsorted888F32Section


    .section Table81B522Section

      .al
      .xl

      aMapRowUploadIRQ ; 81/B522
        .word $0068, $00D7, <>rlIRQUploadMapRowAndColumn, <>aMapRowUploadIRQNext

    .endsection Table81B522Section


    .section Unsorted81B52ASection

      .al
      .xl

      rlIRQUploadMapRowAndColumn ; 81/B52A

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        ; IRQ routine: waits for HBlank, forces blank, uploads the map row and column (rlUploadMapRowAndColumn) and restores the screen.

        sep #$20

        _B52C
        lda $4212,b
        bit #$40
        beq _B52C
        lda #$80
        sta $2100,b
        rep #$20
        jsl rlUploadMapRowAndColumn
        sep #$20
        lda bBufferINIDISP
        and #$80
        sta $2100,b
        rep #$20
        rtl

        .databank 0

        ; 81/B54A

    .endsection Unsorted81B52ASection


    .section Table81B54ASection

      .al
      .xl

      aMapRowUploadIRQNext ; 81/B54A
        .word <>rsIRQCodeHalt

    .endsection Table81B54ASection

