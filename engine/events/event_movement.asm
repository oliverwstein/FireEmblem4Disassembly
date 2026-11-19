; Moving units along paths during events: the target map and the movement
; scripts it produces.

    .section ClearEventMovementTargetMapSection

      .al
      .xl

      rlClearEventMovementTargetMap ; 87/B169

        .al
        .autsiz
        .databank ?

        phx
        phy
        ldy #$FFFF
        lda #`aEventMovement.aTargetMap
        ldx #<>aEventMovement.aTargetMap
        jsl rlFillMapBuffer
        ply
        plx
        rtl

        .databank 0

      rlSetEventMovementTargetTile ; 87/B17B

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = value to write to aEventMovement.aTargetMap to specified tile

        php
        phx
        pha
        lda aEventMovement.wTargetYCoordinate
        xba
        lsr a
        lsr a
        clc
        adc aEventMovement.wTargetXCoordinate
        tax

        pla
        sep #$20
        sta aEventMovement.aTargetMap,x
        rep #$20
        plx
        plp
        rtl

        .databank 0

    .endsection ClearEventMovementTargetMapSection


    .section EventMovementTargetDistanceMapSection

      .al
      .xl

      rlEventMovementBuildTargetDistanceMap ; 87/B197

        .al
        .autsiz
        .databank ?

        ; Similar to rlGetNearestPossibleTarget of the AI routine but
        ; builds the map traversal list in the decomp buffer.

        phb
        php
        phk
        plb
        phx
        phy
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb
        .databank $7E

        lda #`aEventMovement.aTargetDistanceMap
        ldx #<>aEventMovement.aTargetDistanceMap
        jsl rlClearMapBufferAddBorders

        ; Clear the row of map tile above and below the map buffers

        ldx #(64 >> 1) - 2
        lda #$FFFF

          -
          sta aEventMovement.aTargetDistanceMap - 64,x
          sta aEventMovement.aTargetDistanceMap - 32,x
          sta aEventMovement.aTargetDistanceMap + size(aTargetDistanceMap),x
          sta aEventMovement.aTargetDistanceMap + size(aTargetDistanceMap) + 32,x

          sta aEventMovement.aTargetMap - 64,x
          sta aEventMovement.aTargetMap - 32,x
          sta aEventMovement.aTargetMap + size(aTargetMap),x
          sta aEventMovement.aTargetMap + size(aTargetMap) + 32,x

          dec x
          dec x
          bpl -

        ; Get map tile index
        lda aEventMovement.wStartingYCoordinate
        xba
        lsr a
        lsr a
        clc
        adc aEventMovement.wStartingXCoordinate
        tay

        lda aEventMovement.aTargetMap,y
        bit #$0080
        bne +

          jml _UnitOnTarget

        +
        sep #$20
        lda #1
        sta aEventMovement.aTargetDistanceMap,y
        rep #$20

        sty aEventMovement.aMapTraversalList

        stz aEventMovement.wAnalyzeTraversalOffset

        lda #2
        sta aEventMovement.wMapTraversalListOffset
        lda #1
        sta aEventMovement.wRunningMovementCost

        _Loop
        ldx aEventMovement.wAnalyzeTraversalOffset

        stz aEventMovement.wFilledMapTraversalListFlag
        sep #$20

          -
          ldy aEventMovement.aMapTraversalList,x
          lda aEventMovement.aTargetDistanceMap,y
          cmp aEventMovement.wRunningMovementCost
          bne +
          bra _CheckDirections

            _MarkFinishedMapTileIndex
            lda #$FF
            sta aEventMovement.aMapTraversalList + 1,x
            sta aEventMovement.wFilledMapTraversalListFlag

          +
          dec x
          dec x
          bpl -

        ; Done handling all previous entries.

        rep #$20
        lda aEventMovement.wFilledMapTraversalListFlag
        beq _EmptyList

          ; Overwrite marked entries and shift all following ones forward.

          ldx #0
          ldy #0
          
            -
            lda aEventMovement.aMapTraversalList,x
            bmi +

              sta aEventMovement.aMapTraversalList,y
              inc y
              inc y

            +
            inc x
            inc x
            cpx aEventMovement.wMapTraversalListOffset
            bne -

          sty aEventMovement.wMapTraversalListOffset

        _EmptyList
        lda aEventMovement.wMapTraversalListOffset
        beq _CLC

          dec a
          dec a
          sta aEventMovement.wAnalyzeTraversalOffset
          inc aEventMovement.wRunningMovementCost
          lda aEventMovement.wRunningMovementCost
          cmp #$00FC
          bne _Loop

        _CLC
        ply
        plx
        plp
        plb
        clc
        rtl

        _CheckDirections
        phx
        ldx aEventMovement.wMapTraversalListOffset

        ; Check up
        lda aEventMovement.aMovementCostMap - 64,y
        bmi _UpUntraversable

          xba
          lda aEventMovement.aTargetDistanceMap - 64,y
          bne +

            xba
            clc
            adc aEventMovement.wRunningMovementCost
            sta aEventMovement.aTargetDistanceMap - 64,y
            rep #$20
            tya
            clc
            adc #-64
            sta aEventMovement.aMapTraversalList,x
            inc x
            inc x
            sep #$20
            bra +

        _UpUntraversable
        lda #$FF
        sta aEventMovement.aTargetDistanceMap - 64,y
        lda aEventMovement.wTargetXCoordinate
        beq _CheckLeft

        +
        lda aEventMovement.aTargetMap - 64,y
        bmi _CheckLeft

          jml _TargetIsUpwards

        _CheckLeft
        lda aEventMovement.aMovementCostMap - 1,y
        bmi _LeftUntraversable

          xba
          lda aEventMovement.aTargetDistanceMap - 1,y
          bne +

            xba
            clc
            adc aEventMovement.wRunningMovementCost
            sta aEventMovement.aTargetDistanceMap - 1,y
            rep #$20
            tya
            clc
            adc #$FFFF
            sta aEventMovement.aMapTraversalList,x
            inc x
            inc x
            sep #$20
            bra +
        
        _LeftUntraversable
        lda #$FF
        sta aEventMovement.aTargetDistanceMap - 1,y
        lda aEventMovement.wTargetXCoordinate
        beq _CheckDown
        
        +
        lda aEventMovement.aTargetMap - 1,y
        bmi _CheckDown

          jml _TargetIsLeftwards

        _CheckDown
        lda aEventMovement.aMovementCostMap + 64,y
        bmi _DownUntraversable

          xba
          lda aEventMovement.aTargetDistanceMap + 64,y
          bne +

            xba
            clc
            adc aEventMovement.wRunningMovementCost
            sta aEventMovement.aTargetDistanceMap + 64,y
            rep #$20
            tya
            clc
            adc #64
            sta aEventMovement.aMapTraversalList,x
            inc x
            inc x
            sep #$20
            bra +
        
        _DownUntraversable
        lda #$FF
        sta aEventMovement.aTargetDistanceMap + 64,y
        lda aEventMovement.wTargetXCoordinate
        beq _CheckRight
        
        +
        lda aEventMovement.aTargetMap + 64,y
        bmi _CheckRight

          jml _TargetIsDownwards

        _CheckRight
        lda aEventMovement.aMovementCostMap + 1,y
        bmi _RightUntraversable

          xba
          lda aEventMovement.aTargetDistanceMap + 1,y
          bne +

            xba
            clc
            adc aEventMovement.wRunningMovementCost
            sta aEventMovement.aTargetDistanceMap + 1,y
            rep #$20
            tya
            clc
            adc #1
            sta aEventMovement.aMapTraversalList,x
            inc x
            inc x
            sep #$20
            bra +

        _RightUntraversable
        lda #$FF
        sta aEventMovement.aTargetDistanceMap + 1,y
        lda aEventMovement.wTargetXCoordinate
        beq _DoneChecking

        +
        lda aEventMovement.aTargetMap + 1,y
        bmi _DoneChecking

          jml _TargetIsRightwards

        _DoneChecking
        stx aEventMovement.wMapTraversalListOffset
        plx
        jml _MarkFinishedMapTileIndex

        _TargetIsUpwards
        plx
        ldx #-64
        bra +
        
        _TargetIsLeftwards
        plx
        ldx #-1
        bra +
        
        _TargetIsRightwards
        plx
        ldx #1
        bra +

        _TargetIsDownwards
        plx
        ldx #64
        bra +

        _UnitOnTarget
        ldx #0

        +
        rep #$20
        and #$00FF
        pha

        ; The traversal is finished, so its flag word is reused to hold
        ; the step (0, 1 or 64 tiles) from the current tile to the target.

        txa
        sta aEventMovement.wFilledMapTraversalListFlag
        tya
        clc
        adc aEventMovement.wFilledMapTraversalListFlag
        tay
        and #$003F
        sta aEventMovement.wTargetXCoordinate
        tya
        lsr a
        lsr a
        lsr a
        lsr a
        lsr a
        lsr a
        sta aEventMovement.wTargetYCoordinate

        pla
        ply
        plx
        plp
        plb
        sec
        rtl

        .databank 0


      rlFillEventMovementMoveCostMap ; 87/B386

        .al
        .autsiz
        .databank ?

        phb
        php
        sep #$20
        lda #`aEventMovement
        pha
        rep #$20
        plb
        .databank `aEventMovement

        phx
        phy
        sep #$20
        ldy #(size(aMapData)-2) >> 1

          -
          rep #$20
          tya
          asl a
          tax
          lda aMapData,x
          and #$03FF
          tax
          lda aTerrainTileset,x
          and #$00FF
          clc
          adc aEventMovement.wMovementCostPointer
          tax
          sep #$20
          lda aMainDataOffsets & $FF0000,x
          inc a
          sta aEventMovement.aMovementCostMap,y
          dec y
          bpl -

        rep #$20
        ldx #(len(aDeploymentTable._State) - 2)

          -
          lda aDeploymentTable._State,x
          bit #DeploymentStateAlive
          beq _Next

            bit #DeploymentStateHidden
            bne _Next

              lda aDeploymentTable._YTilePosition,x
              and #$00FF
              xba
              lsr a
              lsr a
              clc
              adc aDeploymentTable._XTilePosition,x
              tay
              sep #$20
              lda #8
              clc
              adc aEventMovement.aMovementCostMap,y
              sta aEventMovement.aMovementCostMap,y
              rep #$20

          _Next
          dec x
          dec x
          bpl -

        ply
        plx
        plp
        plb
        rtl

        .databank 0


      rlEventMovementCreateMovementScriptFromTargetDistanceMap ; 87/B3F3

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        phy
        asl a
        tax
        lda aEventMovementMovementScriptBufferAddresses,x
        sta aEventMovement.wMovementScriptBufferAddress

        sep #$20
        lda #`aEventMovement
        pha
        rep #$20
        plb
        .databank `aEventMovement

        ; Get map tile index of the targeted unit thats about to move
        lda aEventMovement.wTargetYCoordinate
        xba
        lsr a
        lsr a
        clc
        adc aEventMovement.wTargetXCoordinate
        tay

        sty aEventMovement.wMapTileIndex
        lda #$01FE
        sta aEventMovement.wMaxScriptCommandsCount
        
        _Loop
        sep #$20
        lda aEventMovement.aTargetDistanceMap,y
        cmp #1
        bcs +

          jml _End

        +
        sta aEventMovement.wLowestMovementDistance
        lda #$FE
        sta aEventMovement.aTargetDistanceMap,y
        ldx #8

        lda aEventMovement.wMapTileIndex
        lsr a
        bcs _CounterClockwise

        lda aEventMovement.aTargetDistanceMap - 64,y
        beq +

          cmp aEventMovement.wLowestMovementDistance
          bcs +

            sta aEventMovement.wLowestMovementDistance
            ldx #0

        +
        lda aEventMovement.aTargetDistanceMap + 1,y
        beq +

          cmp aEventMovement.wLowestMovementDistance
          bcs +

            sta aEventMovement.wLowestMovementDistance
            ldx #2

        +
        lda aEventMovement.aTargetDistanceMap + 64,y 
        beq +

          cmp aEventMovement.wLowestMovementDistance
          bcs +

            sta aEventMovement.wLowestMovementDistance
            ldx #4

        +
        lda aEventMovement.aTargetDistanceMap - 1,y
        beq +

          cmp aEventMovement.wLowestMovementDistance
          bcs +

            ldx #6

        +
        bra _Continue
        
        _CounterClockwise
        lda aEventMovement.aTargetDistanceMap - 1,y
        beq +

          cmp aEventMovement.wLowestMovementDistance
          bcs +

            sta aEventMovement.wLowestMovementDistance
            ldx #6

        +
        lda aEventMovement.aTargetDistanceMap + 64,y
        beq +

          cmp aEventMovement.wLowestMovementDistance
          bcs +

            sta aEventMovement.wLowestMovementDistance
            ldx #4

        +
        lda aEventMovement.aTargetDistanceMap + 1,y
        beq +

          cmp aEventMovement.wLowestMovementDistance
          bcs +

            sta aEventMovement.wLowestMovementDistance
            ldx #2

        +
        lda aEventMovement.aTargetDistanceMap - 64,y
        beq _Continue

          cmp aEventMovement.wLowestMovementDistance
          bcs _Continue

            sta aEventMovement.wLowestMovementDistance
            ldx #0

        _Continue
        cpx #8
        beq _End

          rep #$20
          tya
          clc
          adc aEventMovementMapTileDirectionOffsets,x
          tay
          sep #$20
          lda aEventMovementDirectionLookupTable,x
          jsr rsEventMovementWriteToMovementScriptBuffer
          inc aEventMovement.wMapTileIndex
          rep #$20
          dec aEventMovement.wMaxScriptCommandsCount
          beq _End

            jml _Loop

        _End
        sep #$20
        lda #MAP_CMD_END
        jsr rsEventMovementWriteToMovementScriptBuffer
        ply
        plx
        plp
        plb
        rtl

        .databank 0

    .endsection EventMovementTargetDistanceMapSection


    .section EventMovementMovementScriptBufferAddressesSection

      .al
      .xl

      aEventMovementMovementScriptBufferAddresses ; 87/B4ED

        .word <>aEventMovement.aMovementScriptBuffer1
        .word <>aEventMovement.aMovementScriptBuffer2
        .word <>aEventMovement.aMovementScriptBuffer3
        .word <>aEventMovement.aMovementScriptBuffer4

      aEventMovementMapTileDirectionOffsets ; 87/B4F5

        .sint -64
        .sint 1
        .sint 64
        .sint -1

    .endsection EventMovementMovementScriptBufferAddressesSection


    .section EventMovementDirectionLookupSection

      .as
      .xl

      aEventMovementDirectionLookupTable ; 87/B4FD

        .word MAP_CMD_UP
        .word MAP_CMD_RIGHT
        .word MAP_CMD_DOWN
        .word MAP_CMD_LEFT

    .endsection EventMovementDirectionLookupSection


    .section EventMovementWriteToMovementScriptBufferSection

      .al
      .xl

      rsEventMovementWriteToMovementScriptBuffer ; 87/B505

        .al
        .autsiz
        .databank $7E

        phy
        ldy aEventMovement.wMovementScriptBufferAddress
        sta $0000,b,y
        inc y
        sty aEventMovement.wMovementScriptBufferAddress
        ply
        rts

        .databank 0

        ; 87/B512

    .endsection EventMovementWriteToMovementScriptBufferSection
