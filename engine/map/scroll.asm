; Scripted map camera scrolling.

    .section MapScrollScriptSection

      .al
      .xl

      rlCreateMapScrollScriptFromCoordinates ; 81/8ECB

        .al
        .autsiz
        .databank ?

        ; Takes in coordinates and turns them into a map scroll script.

        ; Input:
        ; wR1 = map scroll speed
        ; wR2 = Start x coord
        ; wR3 = Start y coord
        ; wR4 = Dest x coord
        ; wR5 = Dest y coord

        lda wR1
        sta wEventMapScrollSpeed,b

        lda #(`$7EDD88)<<8
        sta lR18+1
        lda #<>$7EDD88
        sta lR18
        jsr rsInitializeCreateMapScrollScript
        
          -
          jsr rsCreateMapScrollScriptFromCoordinatesEffect
          bcc -

        rtl

        .databank 0

      rsInitializeCreateMapScrollScript ; 81/8EE3

        .al
        .autsiz
        .databank ?

        ; Start with MAP_PAUSE 1

        ldy #0
        lda #9 +9
        sta [lR18],y
        inc y
        lda #1
        sta [lR18],y
        dec y
        rts

        .databank 0

      rsCreateMapScrollScriptFromCoordinatesEffect ; 81/8EF3

        .al
        .autsiz
        .databank ?

        ; Input:
        ; wR2 = Start x coord
        ; wR3 = Start y coord
        ; wR4 = Dest x coord
        ; wR5 = Dest y coord

        cpy #$007F
        bne +

          jml _WriteEndCommand

        +
        lda #0
        sta wR0
        ldx #0

        lda wR2
        cmp wR4
        beq +

          inc x

        +
        rol wR0

        lda wR3
        cmp wR5
        beq +

          inc x

        +
        rol wR0

        cpx #0
        beq _WriteEndCommand

        cpx #2
        bne _SingleDirectionScroll

        ; Scrolling in multiple directions needed
        lda wR0
        bit #$0002
        bne +

        inc wR2
        bra ++

        +
        dec wR2

        +
        bit #$0001
        bne +

        inc wR3
        bra ++

        +
        dec wR3

        +
        tax
        lda aDiagonalMapScrollLookupTable,x
        and #$00FF
        bra _WriteScrollCommand

        _SingleDirectionScroll
        lda wR2
        cmp wR4
        beq _CheckYScroll

          lda wR2
          cmp wR4
          bcc +

            ; Left multiple
            dec wR2
            lda #$0A
            bra _WriteScrollCommand

          ; Right multiple
          +
          inc wR2
          lda #$0B
          bra _WriteScrollCommand

        _CheckYScroll
        lda wR3
        cmp wR5
        bcc +

          ; Up multiple
          dec wR3
          lda #$0C
          bra _WriteScrollCommand

        ; Down multiple
        +
        inc wR3
        lda #$0D 
        bra _WriteScrollCommand

        _WriteEndCommand
        lda #$0080
        inc y
        inc y
        sta [lR18],y
        sec
        bra _End

        _WriteScrollCommand
        sta wR7
        lda [lR18],y
        and #$00FF
        cmp wR7
        bne _DifferentDirection

        ; If current direction matches last, increment the last ones
        ; scroll distance.
        inc y
        lda [lR18],y
        inc a
        sta [lR18],y
        dec y
        bra +

        _DifferentDirection
        lda wR7
        inc y
        inc y
        sta [lR18],y
        inc y
        lda #1
        sta [lR18],y
        dec y

        +
        clc

        _End
        rts

        .databank 0

      aDiagonalMapScrollLookupTable ; 81/8F9D

        .byte $11 ; bottom right
        .byte $10 ; top right
        .byte $0F ; bottom left
        .byte $0E ; top left

        ; 81/8FA1

    .endsection MapScrollScriptSection


    .section Unknown818FA1Section

      .al
      .xl

      rlUnknown818FA1 ; 81/8FA1

        .al
        .autsiz
        .databank ?

        ; wR0 = CharacterID
        ; wR1 = movement speed
        ; wR2 = spawn X coord
        ; wR3 = spawn y coord
        ; wR4 = dest X coordinate
        ; wR5 = dest Y coordinate
        ; wR6 = sprite color
        ; wR7 = 0 or 1 ?

        phx
        phx
        jsr rsCapSpawnDestinationCoordinates100

        lda wR0
        pha
        lda wR1
        pha
        lda wR2
        pha
        lda wR3
        pha
        lda wR4
        pha
        lda wR5
        pha
        lda wR6
        pha

        lda wR7
        sta wR6

        lda wR0
        sta wRoutineVariable1,b
        txa
        lsr a
        sta aMovingMapSprites.wEntryIndex,b

        lda wR0
        sta aMovingMapSprites.wCharacterID,b
        lda wR2
        sta aMovingMapSprites.wSpawnXCoordinate,b
        lda wR3
        sta aMovingMapSprites.wSpawnYCoordinate,b
        lda wR4
        sta aMovingMapSprites.wDestinationXCoordinate,b
        lda wR5
        sta aMovingMapSprites.wDestinationYCoordinate,b
        lda wR6
        sta aMovingMapSprites.wUnknown001830,b
        lda #1
        sta aMovingMapSprites.wState,b

        pla
        sta wR6
        pla
        sta wR5
        pla
        sta wR4
        pla
        sta wR3
        pla
        sta wR2
        pla
        sta wR1
        pla
        sta wR0
        plx

        phx
        lda #(`aMovingMapSpriteData[0])<<8
        sta lR18+1

        txa
        lsr a
        ora #len(aMovingMapSpriteData[0]) << 8
        jsl rlUnsignedMultiply8By8
        clc
        adc #<>aMovingMapSpriteData[0]
        sta lR18
        jsr rsFillMovingMapSpriteData
        plx

        phx
        lda #(`aEventMovement.aMovementScriptBuffer1)<<8
        sta lR19+1
        pla
        lsr a
        xba
        asl a
        clc
        adc #<>aEventMovement.aMovementScriptBuffer1
        sta lR19
        jsr rsFillMovingMapSpriteDataPathScriptPointer
        plx
        rtl

        .databank 0

    .endsection Unknown818FA1Section


    .section GetMapPixelScrollDistanceSection

      .al
      .xl

      rsGetMapPixelScrollDistance ; 81/91BE

        .al
        .autsiz
        .databank ?

        ; Evaluates a map scroll code: if $80, end the scolling
        ; If $84, change the map scrolling speed
        ; Values 1-8 control the direction of the scrolling
        ; Prior values +9 make a command scroll multiple tiles, 
        ; with the tile count being a byte argument that comes afterwards.

        ; Output: 
        ; wMapPixelScrollDistance
        ; CLC if scrolling, SEC if finished

        ldy wMapScrollScriptOffset,b
        bmi _EndScroll

          lda wEventMapScrollScript,b
          sta lR18
          lda wEventMapScrollScript+1,b
          sta lR18+1
          
            -
            lda [lR18],y
            and #$00FF
            cmp #$0080
            sta wR0
            beq _EndScroll

            cmp #$0084
            bne _KeepSpeed

              inc y
              lda [lR18],y
              and #$00FF
              sta wEventMapScrollSpeed,b
              inc wMapScrollScriptOffset,b
              inc wMapScrollScriptOffset,b
              ldy wMapScrollScriptOffset,b
              bra -

            _KeepSpeed
            cmp #10
            bcc +

              sbc #9

            +
            jsr rsGetMapScrollDirectionIdentifierFromCommand
            sta wMapScrollDirectionIdentifier,b

            lda [lR18],y
            and #$00FF
            cmp #10
            bcc _SingleTileScroll

            ; Multiple tiles
            jsr rsGetMapPixelScrollDistanceMultipleTiles
            bra +

            _SingleTileScroll
            jsr rsGetMapPixelScrollDistanceSingleTile

            +
            clc
            rts

        _EndScroll
        lda #16
        sta wMapPixelScrollDistance,b
        stz wUnknown0007D8,b
        stz wMapScrollScriptOffset,b
        stz wUnknown00073A,b
        sec
        rts

        .databank 0

      rsGetMapPixelScrollDistanceSingleTile ; 81/9225

        .al
        .autsiz
        .databank ?

        ; Adds 16 pixels to the scroll distance for a single tile command.
        ; If similar commands occur sequentially, continue to add 16 pixels 
        ; to the distance for each command.

        ; Input:
        ; wR0 = Scrolling command

        ; Output:
        ; wMapPixelScrollDistance

        _OuterLoop
        lda wMapPixelScrollDistance,b
        clc
        adc #16
        sta wMapPixelScrollDistance,b
        
          _InnerLoop
          inc y
          sty wMapScrollScriptOffset,b
          bmi _End

            lda [lR18],y
            and #$00FF
            cmp #$0080
            beq _End

              bit #$0080
              beq +

                cmp #$0084
                bne _InnerLoop

                  inc y
                  lda [lR18],y
                  and #$00FF
                  sta wEventMapScrollSpeed,b
                  bra _InnerLoop

              +
              cmp wR0
              beq _OuterLoop

        _End
        rts

        .databank 0

      rsGetMapPixelScrollDistanceMultipleTiles ; 81/9259

        .al
        .autsiz
        .databank ?

        phx
        lda [lR18],y
        and #$00FF
        tax
        inc y
        lda [lR18],y
        and #$00FF

        ; Check for pause command
        cpx #$12
        beq +

          ora #16 << 8
          jsl rlUnsignedMultiply8By8

        +
        clc
        adc wMapPixelScrollDistance,b
        sta wMapPixelScrollDistance,b

        inc y
        sty wMapScrollScriptOffset,b
        plx
        rts

        .databank 0

      rsGetMapScrollDirectionIdentifierFromCommand ; 81/927F

        .al
        .autsiz
        .databank ?

        cmp #4
        beq _Down

        cmp #3
        beq _Up

        cmp #2
        beq _Right

        cmp #1
        beq _Left

        cmp #5
        beq _TopLeft

        cmp #6
        beq _BottomLeft

        cmp #7
        beq _TopRight

        cmp #8
        beq _BottomRight

        lda #0
        bra _End
        
        _Down
        lda #$0018
        sta wUnknown0007E2,b
        lda #$0400
        bra _End
        
        _Up
        lda #$0010
        sta wUnknown0007E2,b
        lda #$0800
        bra _End
        
        _Right
        lda #$0008
        sta wUnknown0007E2,b
        lda #$0100
        bra _End
        
        _Left
        lda #0
        sta wUnknown0007E2,b
        lda #$0200
        bra _End
        
        _TopLeft
        lda #0
        sta wUnknown0007E2,b
        lda #$0A00
        bra _End
        
        _BottomLeft
        lda #0
        sta wUnknown0007E2,b
        lda #$0600
        bra _End
        
        _TopRight
        lda #$0008
        sta wUnknown0007E2,b
        lda #$0900
        bra _End
        
        _BottomRight
        lda #$0008
        sta wUnknown0007E2,b
        lda #$0500
        bra _End
        
        _End
        rts

        .databank 0

      rlUnknown819305 ; 81/9305

        .al
        .autsiz
        .databank ?

        and #$FFFF
        beq _End

        cmp #$0200
        beq _Left

        cmp #$0100
        beq _Right

        cmp #$0800
        beq _Up

        cmp #$0400
        beq _Down

        cmp #$0A00
        beq _UpLeft

        cmp #$0600
        beq _DownLeft

        cmp #$0900
        beq _UpRight

        cmp #$0500
        beq _DownRight

        _End
        rtl

        _Left
        jsr rsMapScrollLeft
        rtl

        _Right
        jsr rsMapScrollRight
        rtl

        _Up
        jsr rsMapScrollUp
        rtl

        _Down
        jsr rsMapScrollDown
        rtl

        _UpLeft
        jsr rsMapScrollUpLeft
        rtl

        _DownLeft
        jsr rsMapScrollDownLeft
        rtl

        _UpRight
        jsr rsMapScrollUpRight
        rtl

        _DownRight
        jsr rsMapScrollDownRight
        rtl

        .databank 0

      rsMapScrollUp ; 81/9353

        .al
        .autsiz
        .databank ?

        lda #1
        sta wUnknown00073A,b
        sta wMapEnableYScrollFlag,b
        jsl rlMapScrollStepUp
        rts

        .databank 0

      rsMapScrollDown ; 81/9361

        .al
        .autsiz
        .databank ?

        lda #1
        sta wUnknown00073A,b
        sta wMapEnableYScrollFlag,b
        jsl rlMapScrollStepDown
        rts

        .databank 0

      rsMapScrollLeft ; 81/936F

        .al
        .autsiz
        .databank ?

        lda #1
        sta wUnknown00073A,b
        sta wMapEnableXScrollFlag,b
        jsl rlMapScrollStepLeft
        rts

        .databank 0

      rsMapScrollRight ; 81/937D

        .al
        .autsiz
        .databank ?

        lda #1
        sta wUnknown00073A,b
        sta wMapEnableXScrollFlag,b
        jsl rlMapScrollStepRight
        rts

        .databank 0

      rsMapScrollUpLeft ; 81/938B

        .al
        .autsiz
        .databank ?

        lda #1
        sta wUnknown00073A,b
        sta wMapEnableXScrollFlag,b
        sta wMapEnableYScrollFlag,b
        jsl rlMapScrollStepUpLeft
        rts

        .databank 0

      rsMapScrollDownLeft ; 81/939C

        .al
        .autsiz
        .databank ?

        lda #1
        sta wUnknown00073A,b
        sta wMapEnableXScrollFlag,b
        sta wMapEnableYScrollFlag,b
        jsl rlMapScrollStepDownLeft
        rts

        .databank 0

      rsMapScrollUpRight ; 81/93AD

        .al
        .autsiz
        .databank ?

        lda #1
        sta wUnknown00073A,b
        sta wMapEnableXScrollFlag,b
        sta wMapEnableYScrollFlag,b
        jsl rlMapScrollStepUpRight
        rts

        .databank 0

      rsMapScrollDownRight ; 81/93BE

        .al
        .autsiz
        .databank ?

        lda #1
        sta wUnknown00073A,b
        sta wMapEnableXScrollFlag,b
        sta wMapEnableYScrollFlag,b
        jsl rlMapScrollStepDownRight
        rts

        .databank 0

        ; 81/93CF

    .endsection GetMapPixelScrollDistanceSection


    .section MapScrollRightSetBGOFSSection

      .al
      .xl

      rsMapScrollRightSetBGOFS ; 88/86FF

        .al
        .autsiz
        .databank ?

        lda wMapEnableXScrollFlag,b
        beq +

          lda wMapScrollXPixels,b
          clc
          adc wMapScrollSpeed,b
          sta wMapScrollXPixels,b
          sta wBufferBG1HOFS
          cmp wMapMaxXScroll,b
          bcc +

            lda wMapMaxXScroll,b
            sta wMapScrollXPixels,b
            sta wBufferBG1HOFS

        +
        rts

        .databank 0

      rsMapScrollLeftSetBGOFS ; 88/871E

        .al
        .autsiz
        .databank ?

        lda wMapEnableXScrollFlag,b
        beq _End

          lda wMapScrollXPixels,b
          sec
          sbc wMapScrollSpeed,b
          sta wMapScrollXPixels,b
          sta wBufferBG1HOFS
          bmi +

            cmp wMapMinXScroll,b
            bcs _End

          +
          lda wMapMinXScroll,b
          sta wMapScrollXPixels,b
          sta wBufferBG1HOFS

        _End
        rts

        .databank 0

      rsMapScrollDownSetBGOFS ; 88/873F

        .al
        .autsiz
        .databank ?

        lda wMapEnableYScrollFlag,b
        beq _End

          lda wMapScrollYPixels,b
          clc
          adc wMapScrollSpeed,b
          sta wMapScrollYPixels,b
          sta wBufferBG1VOFS

          cmp wMapMaxYScroll,b
          bcc _End

            lda wMapMaxYScroll,b
            sta wMapScrollYPixels,b
            sta wBufferBG1VOFS

        _End
        rts

        .databank 0

      rsMapScrollUpSetBGOFS ; 88/875E

        .al
        .autsiz
        .databank ?

        lda wMapEnableYScrollFlag,b
        beq _End

          lda wMapScrollYPixels,b
          sec
          sbc wMapScrollSpeed,b
          sta wMapScrollYPixels,b
          sta wBufferBG1VOFS
          bmi +

            cmp wMapMinYScroll,b
            bcs _End

          +
          lda wMapMinYScroll,b
          sta wMapScrollYPixels,b
          sta wBufferBG1VOFS
        
        _End
        rts

        .databank 0

      rlQueueMapBottomRowUpload ; 88/877F

        .al
        .autsiz
        .databank ?

        ; Builds the row entering at the bottom of the screen and flags it for rlUploadMapRowAndColumn.

        jsr rsBuildMapBottomRow

        lda wMapScrollYPixels,b
        sec
        sbc #$0020
        and #$00F8
        asl a
        asl a
        sta wUnknown000732,b

        lda #1
        sta wUnknown00072E,b
        rtl

        .databank 0

      rlQueueMapTopRowUpload ; 88/8798

        .al
        .autsiz
        .databank ?

        ; Builds the row entering at the top of the screen and flags it for rlUploadMapRowAndColumn.

        jsr rsBuildMapTopRow

        lda wMapScrollYPixels,b
        and #$00F8
        asl a
        asl a
        sta wUnknown000732,b

        lda #1
        sta wUnknown00072E,b
        rtl

        .databank 0

      rlBuildMapTopRow ; 88/87AD

        .al
        .autsiz
        .databank ?

        ; Like rlQueueMapTopRowUpload without the upload flag (used while redrawing the whole map).

        jsr rsBuildMapTopRow

        lda wMapScrollYPixels,b
        and #$00F8
        asl a
        asl a
        sta wUnknown000732,b
        rtl

        .databank 0

      rlQueueMapRightColumnUpload ; 88/87BC

        .al
        .autsiz
        .databank ?

        jsr rsBuildMapRightColumn

        lda wMapScrollXPixels,b
        sec
        sbc #7
        and #$00F8
        lsr a
        lsr a
        lsr a
        sta wUnknown000730,b

        lda #1
        sta wUnknown00072C,b
        rtl

        .databank 0

      rlQueueMapLeftColumnUpload ; 88/87D6

        .al
        .autsiz
        .databank ?

        jsr rsBuildMapLeftColumn

        lda wMapScrollXPixels,b
        and #$00F8
        lsr a
        lsr a
        lsr a
        sta wUnknown000730,b

        lda #1
        sta wUnknown00072C,b
        rtl

        .databank 0

        ; 88/87EC

    .endsection MapScrollRightSetBGOFSSection
