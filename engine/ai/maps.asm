; The maps the AI works from: movement, movement cost, range and target maps, and
; maps of where allied and enemy units stand.

    .section AIMovementMapSection

      .al
      .xl

      rlFillMovementMap ; 86/A6CD

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        phy

        sep #$20
        lda #$7F
        pha
        rep #$20
        plb
        .databank $7F

        lda #`aMovementMap
        ldx #<>aMovementMap
        jsl rlClearMapBufferAddBorders

        stz wR36

        jsr rsFillMapData

        ply
        plx
        plp
        plb
        clc
        rtl

        .databank 0

      rsFillMapData ; 86/A6F0

        .al
        .autsiz
        .databank $7F

        ; wR36 = Special field movement cost, if 0 use regular movement cost
        ; wAITemp000E96 = X Pos
        ; wAITemp000E98 = Y Pos
        ; wAITemp000EA2 = field movement

        jsr rsGetMovementMapBuildingInfo

        ldx #64 - 2
        lda #$FFFF

          -
          sta aMapTraversalList,x
          sta aMapTraversalList + ($40 * 1),x
          sta aMapTraversalList + ($40 * 2),x
          sta aMapTraversalList + ($40 * 3),x
          dec x
          dec x
          bpl -

        lda wAITemp000E98
        xba
        lsr a
        lsr a
        clc
        adc wAITemp000E96
        tay

        ; Set units field movement at their starting position
        lda wAITemp000EA2
        sep #$20
        sta aMovementMap,y
        rep #$20
        sta wR34

        asl a
        tax
        lda #aNextTraversedTileIndexList - aMapTraversalList
        sta aMapTraversalList,x
        lda #$FFFF
        sta aNextTraversedTileIndexList
        tya
        sta aNextTraversedTileIndexList+2
        lda #aNextTraversedTileIndexList - aMapTraversalList + size(word) * 2
        sta wR35

          ; If remaining move is less than 0.7, exit
          -
          lda wR34
          cmp #7
          bcc _End

          asl a
          tax

            -
            lda aMapTraversalList,x
            bmi +

              tax
              ldy aMapTraversalList+2,x
              jsr rsAppendAdjacentTilesToMapTraversalList
              bra -

          +
          dec wR34
          bra --

        _End
        rts

        .databank 0

      rsAppendAdjacentTilesToMapTraversalList ; 86/A756

        .al
        .autsiz
        .databank $7F

        ; Checks 4 adjacent tiles to specified tile index
        ; If filled or too costly, skip
        ; Else update tile with value equal to remaining move if moved to the space

        ; Input:
        ; Y = units map tile index
        ; wR34 = units field movement
        ; wR36 = special field movement cost, if 0 use regular movement cost

        sep #$20
        phx
        lda aMovementMap - 64,y
        bne _HandleLeft

          lda wR36
          beq +

            lda wR34
            sec
            sbc wR36
            bra ++

          ; Check if the direction is traversable

          +
          rep #$20
          lda #-64
          jsr rsGetFieldMovementCostInSpecifiedDirection

          sep #$20
          bmi _HandleLeft

            ; Check if remaining movement would be able to move there

            lda wR34
            sec
            sbc wR37

            +
            bcc _HandleLeft

              sta aMovementMap - 64,y
              beq _HandleLeft

                ; There is still some move left over

                rep #$20
                and #$007F
                asl a
                tax
                lda aMapTraversalList,x
                pha

                lda wR35
                sta aMapTraversalList,x
                tax
                clc
                adc #4
                sta wR35

                pla
                sta aMapTraversalList,x
                tya
                clc
                adc #-64
                sta aMapTraversalList+2,x
                sep #$20
        
        _HandleLeft
        lda aMovementMap - 1,y
        bne _HandleRight

          lda wR36
          beq +

          lda wR34
          sec
          sbc wR36
          bra ++
          
          +
          rep #$20
          lda #-1
          jsr rsGetFieldMovementCostInSpecifiedDirection
          sep #$20
          bmi _HandleRight

            lda wR34
            sec
            sbc wR37

            +
            bcc _HandleRight

              sta aMovementMap - 1,y
              beq _HandleRight

                rep #$20
                and #$007F
                asl a
                tax
                lda aMapTraversalList,x
                pha

                lda wR35
                sta aMapTraversalList,x
                tax
                clc
                adc #4
                sta wR35

                pla
                sta aMapTraversalList,x
                tya
                clc
                adc #-1
                sta aMapTraversalList+2,x
                sep #$20
        
        _HandleRight
        lda aMovementMap + 1,y
        bne _HandleDown

          lda wR36
          beq +

          lda wR34
          sec
          sbc wR36
          bra ++
          
          +
          rep #$20
          lda #1
          jsr rsGetFieldMovementCostInSpecifiedDirection
          sep #$20
          bmi _HandleDown

            lda wR34
            sec
            sbc wR37
            
            +
            bcc _HandleDown

              sta aMovementMap +1,y
              beq _HandleDown

                rep #$20
                and #$007F
                asl a
                tax
                lda aMapTraversalList,x
                pha

                lda wR35
                sta aMapTraversalList,x
                tax
                clc
                adc #4
                sta wR35

                pla
                sta aMapTraversalList,x
                tya
                clc
                adc #1
                sta aMapTraversalList+2,x
                sep #$20
        
        _HandleDown
        lda aMovementMap + 64,y
        bne _End

          lda wR36
          beq +

          lda wR34
          sec
          sbc wR36
          bra ++


          +
          rep #$20
          lda #64
          jsr rsGetFieldMovementCostInSpecifiedDirection
          sep #$20
          bmi _End

            lda wR34
            sec
            sbc wR37
            
            +
            bcc _End

              sta aMovementMap + 64,y
              beq _End

                rep #$20
                and #$007F
                asl a
                tax
                lda aMapTraversalList,x
                pha

                lda wR35
                sta aMapTraversalList,x
                tax
                clc
                adc #4
                sta wR35

                pla
                sta aMapTraversalList,x
                tya
                clc
                adc #64
                sta aMapTraversalList+2,x
                sep #$20

        _End
        plx
        rep #$20
        rts

        .databank 0

      rsGetMovementMapBuildingInfo ; 86/A891

        .al
        .autsiz
        .databank $7F

        lda wAIActiveFaction
        tax

        jsl rlGetSelectedUnitFactionSlot
        jsl rlGetFactionRelation
        asl a
        tax
        lda aBlockingUnitMapPointers,x
        sta aAIAction.wMapPointer
        jsl rlGetSelectedUnitMovementCostPointer
        sta aAIAction.wUnitMovementCostPointer
        rts

        .databank 0

      aBlockingUnitMapPointers ; 86/A8AF

        .word <>aFoeUnitMap
        .word <>aAllyUnitMap
        .word <>aFoeUnitMap
        .word <>aFoeUnitMap

      aUnknown86A8B7 ; 86/A8B7

        ; Approximation of (Move * 10 [-1]) * 256/179)/10
        ; Leaving out the -1 part

        .byte ceil(( 0 * 10) * 256.0/179.0/10) ; =  0
        .byte ceil(( 1 * 10) * 256.0/179.0/10) ; =  2
        .byte ceil(( 2 * 10) * 256.0/179.0/10) ; =  3
        .byte ceil(( 3 * 10) * 256.0/179.0/10) ; =  5
        .byte ceil(( 4 * 10) * 256.0/179.0/10) ; =  6
        .byte ceil(( 5 * 10) * 256.0/179.0/10) ; =  8
        .byte ceil(( 6 * 10) * 256.0/179.0/10) ; =  9
        .byte ceil(( 7 * 10) * 256.0/179.0/10) ; = 11
        .byte ceil(( 8 * 10) * 256.0/179.0/10) ; = 12
        .byte ceil(( 9 * 10) * 256.0/179.0/10) ; = 13
        .byte ceil((10 * 10) * 256.0/179.0/10) ; = 15
        .byte ceil((11 * 10) * 256.0/179.0/10) ; = 16
        .byte ceil((12 * 10) * 256.0/179.0/10) ; = 18
        .byte ceil((13 * 10) * 256.0/179.0/10) ; = 19

      rsGetFieldMovementCostInSpecifiedDirection ; 86/A8C5

        .al
        .autsiz
        .databank $7F

        ; Gets field movement cost of map tile index in specified direction

        ; Input:
        ; A = offset from current map tile index
        ; Y = current map tile index
        ; aAIAction.wMapPointer
        ; aAIAction.wUnitMovementCostPointer

        ; Output:
        ; wR37 = field movement cost

        phx
        phy
        sty wR37
        clc
        adc wR37
        tay

        tya
        clc
        adc aAIAction.wMapPointer
        tax
        lda $0000,b,x
        and #$00FF
        cmp #$00FF
        beq +

          lda #$007F
          bra _End

        +
        tya
        asl a
        tax
        lda aMapData,x
        and #$03FF
        tax
        lda aTerrainTileset,x
        and #$00FF
        cmp #TerrainRoad+1
        bcc +

          lda #TerrainPeak

        +
        clc
        adc aAIAction.wUnitMovementCostPointer
        tax
        lda $830000,x
        and #$00FF
        bit #$0080
        bne _End

          asl a
          tax
          lda aFieldMovementCostLookupTable,x

        _End
        ply
        plx
        sta wR37
        cmp #0
        rts

        .databank 0

      aFieldMovementCostLookupTable ; 86/A91A

        ; Indexed by movement cost

        .word 7
        .word 10
        .word 20
        .word 30
        .word 40
        .word 50
        .word 60
        .word 70

      rlUnknown86A92A ; 86/A92A

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        phy

        sep #$20
        lda #$7F
        pha
        rep #$20
        plb
        .databank $7F

        lda #`aMovementMap
        ldx #<>aMovementMap
        jsl rlClearMapBufferAddBorders

        lda wAITemp000EA4
        cmp #10
        bcs _A96B

        stz wR36
        jsr rsFillMapData
        sep #$20
        ldx #$0100

          -
          cpx wR35
          beq +

          ldy aMapTraversalList+2,x
          jsr rsUnknown86A9A0
          inc x
          inc x
          inc x
          inc x
          cpx wR35
          bra -

        +
        rep #$20
        bra _End
        
        _A96B
        lda #101
        sta wAITemp000EA2
        lda #10
        sta wR36
        jsr rsFillMapData
        lda #101
        sta wR34

          -
          lda wR34
          asl a
          tax
          
            -
            lda aMapTraversalList,x
            bmi +

            tax
            ldy aMapTraversalList+2,x
            jsr rsUnknown86AA43
            bra -

          +
          lda wR34
          sec
          sbc wR36
          sta wR34
          bpl --

        _End
        ply
        plx
        plp
        plb
        clc
        rtl

        .databank 0

      rsUnknown86A9A0 ; 86/A9A0

        .as
        .autsiz
        .databank $7F

        lda wAITemp000EA4
        cmp #1
        bne +

          lda aMovementMap - 64,y
          ora #$80
          sta aMovementMap - 64,y
          lda aMovementMap -  1,y
          ora #$80
          sta aMovementMap -  1,y
          lda aMovementMap +  1,y
          ora #$80
          sta aMovementMap +  1,y
          lda aMovementMap + 64,y
          ora #$80
          sta aMovementMap + 64,y
          bra _End

        +
        cmp #2
        beq +

          rep #$20
          lda aMovementMap - 64 - 1,y
          ora #$8080
          sta aMovementMap - 64 - 1,y
          lda aMovementMap -  1 - 1,y
          ora #$8080
          sta aMovementMap -  1 - 1,y
          lda aMovementMap +  1,y
          ora #$8080
          sta aMovementMap +  1,y
          lda aMovementMap + 64 - 1,y
          ora #$8080
          sta aMovementMap + 64 - 1,y
          sep #$20
          bra ++

        +
        lda aMovementMap - 64 - 1,y
        ora #$80
        sta aMovementMap - 64 - 1,y
        lda aMovementMap -  1 - 1,y
        ora #$80
        sta aMovementMap -  1 - 1,y
        lda aMovementMap +  1 + 1,y
        ora #$80
        sta aMovementMap +  1 + 1,y
        lda aMovementMap + 64 - 1,y
        ora #$80
        sta aMovementMap + 64 - 1,y

        +
        lda aMovementMap + 64 + 1,y
        ora #$80
        sta aMovementMap + 64 + 1,y
        lda aMovementMap - 64 + 1,y
        ora #$80
        sta aMovementMap - 64 + 1,y
        cpy #$0080
        bmi +

          lda aMovementMap - 64 - 64,y
          ora #$80
          sta aMovementMap - 64 - 64,y

        +
        cpy #$0F80
        bpl _End

          lda aMovementMap + 64 + 64,y
          ora #$80
          sta aMovementMap + 64 + 64,y

        _End
        rts

        .databank 0

      rsUnknown86AA43 ; 86/AA43

        .al
        .autsiz
        .databank $7F

        sep #$20
        lda $4C
        cmp #101
        beq _AA5D

        lda $000EA4
        cmp #11
        beq +

        lda $4C
        cmp #81
        bcs _AA61
        
        +
        lda #$80
        bra +
        
        _AA5D
        lda #1
        bra +
        
        _AA61
        lda #0
        
        +
        sta aMovementMap,y
        rep #$20
        rts

        .databank 0

      rsFillRangeMap ; 86/AA69

        .al
        .autsiz
        .databank ?

        ; Input:
        ; wAITemp000E96 = X Pos
        ; wAITemp000E98 = Y Pos
        ; wAITemp000EA2 = field movement
        ; wAITemp000EA4 = weapon range

        phb
        php
        phk
        plb
        phx
        phy

        sep #$20
        lda #$7F
        pha
        rep #$20
        plb
        .databank $7F

        lda #`aMovementMap
        ldx #<>aMovementMap
        jsl rlClearMapBufferAddBorders

        ; Min + Max item range
        lda wAITemp000EA4
        cmp #3 + 10
        beq _SiegeWeapon

          stz wR36
          jsr rsFillMapData

          sep #$20
          ldx #$0100

            -
            cpx wR35
            beq +

              ldy aMapTraversalList+2,x
              jsr rsFlagNonSiegeAttackRangeOfSpecifiedTile
              inc x
              inc x
              inc x
              inc x
              cpx wR35
              bra -

          +
          rep #$20
          bra _End

        _SiegeWeapon
        lda #10 * 10 + 1
        sta wAITemp000EA2
        lda #10
        sta wR36
        jsr rsFillMapData

        lda #71
        sta wR34
        
          _Loop
          lda wR34
          asl a
          tax
          
            -
            lda aMapTraversalList,x
            bmi +

              tax
              ldy aMapTraversalList+2,x
              jsr rsFlagSiegeAttackRangeOfSpecifiedTile
              bra -

          +
          lda wR34
          sec
          sbc wR36
          sta wR34
          bpl _Loop

        _End
        ply
        plx
        plp
        plb
        clc
        rtl

        .databank 0

      rsFlagNonSiegeAttackRangeOfSpecifiedTile ; 86/AADF

        .as
        .autsiz
        .databank $7F

        ; Check all tiles within 2 tiles around a tile that can be moved to.
        ; After checking a tile, flag it so it doesnt get looked at again.

        ; Input:
        ; Y = map tile index from aMapTraversalList
        ; wAITemp000EA0 = value to write to the range map
        ; wAITemp000EA4 = weapon range

        lda wAITemp000EA4
        and #$01
        beq _CheckRanged

          lda aMovementMap - 64,y
          bmi ++

            ora #$80
            sta aMovementMap - 64,y
            lda aRangeMap - 64,y
            clc
            adc wAITemp000EA0
            bcc +

              lda #$FF

            +
            sta aRangeMap - 64,y
          
          +
          lda aMovementMap + 64,y
          bmi ++

            ora #$80
            sta aMovementMap + 64,y
            lda aRangeMap + 64,y
            clc
            adc wAITemp000EA0
            bcc +

              lda #$FF

            +
            sta aRangeMap + 64,y

          +
          lda aMovementMap - 1,y
          bmi ++

            ora #$80
            sta aMovementMap - 1,y
            lda aRangeMap - 1,y
            clc
            adc wAITemp000EA0
            bcc +

              lda #$FF

            +
            sta aRangeMap - 1,y

          +
          lda aMovementMap + 1,y
          bmi _CheckRanged

            ora #$80
            sta aMovementMap + 1,y
            lda aRangeMap + 1,y
            clc
            adc wAITemp000EA0
            bcc +

              lda #$FF

            +
            sta aRangeMap + 1,y

        _CheckRanged
        lda wAITemp000EA4
        and #$02
        bne +

          jml _End

        +
        lda aMovementMap - 64 - 1,y
        bmi ++

          ora #$80
          sta aMovementMap - 64 - 1,y
          lda aRangeMap - 64 - 1,y
          clc
          adc wAITemp000EA0
          bcc +

            lda #$FF

          +
          sta aRangeMap - 64 - 1,y

        +
        lda aMovementMap - 64 + 1,y
        bmi ++

          ora #$80
          sta aMovementMap - 64 + 1,y
          lda aRangeMap - 64 + 1,y
          clc
          adc wAITemp000EA0
          bcc +

            lda #$FF

          +
          sta aRangeMap - 64 + 1,y

        +
        lda aMovementMap - 2,y
        bmi ++

          ora #$80
          sta aMovementMap - 2,y
          lda aRangeMap - 2,y
          clc
          adc wAITemp000EA0
          bcc +

            lda #$FF

          +
          sta aRangeMap - 2,y

        +
        lda aMovementMap + 2,y
        bmi ++

          ora #$80
          sta aMovementMap + 2,y
          lda aRangeMap + 2,y
          clc
          adc wAITemp000EA0
          bcc +

            lda #$FF

          +
          sta aRangeMap + 2,y

        +
        lda aMovementMap + 64 - 1,y
        bmi ++

          ora #$80
          sta aMovementMap + 64 - 1,y
          lda aRangeMap + 64 - 1,y
          clc
          adc wAITemp000EA0
          bcc +

            lda #$FF

          +
          sta aRangeMap + 64 - 1,y

        +
        lda aMovementMap + 64 + 1,y
        bmi ++

          ora #$80
          sta aMovementMap + 64 + 1,y
          lda aRangeMap + 64 + 1,y
          clc
          adc wAITemp000EA0
          bcc +

            lda #$FF

          +
          sta aRangeMap + 64 + 1,y

        +
        cpy #64 * 2
        bmi ++

          lda aMovementMap - 64 - 64,y
          bmi ++

            ora #$80
            sta aMovementMap - 64 - 64,y
            lda aRangeMap - 64 - 64,y
            clc
            adc wAITemp000EA0
            bcc +

              lda #$FF

          +
          sta aRangeMap - 64 - 64,y

        +
        cpy #64 * 62
        bpl _End

          lda aMovementMap + 64 + 64,y
          bmi _End

            ora #$80
            sta aMovementMap + 64 + 64,y
            lda aRangeMap + 64 + 64,y
            clc
            adc wAITemp000EA0
            bcc +

              lda #$FF

            +
            sta aRangeMap + 64 + 64,y

        _End
        rts

        .databank 0

      rsFlagSiegeAttackRangeOfSpecifiedTile ; 86/AC2A

        .al
        .autsiz
        .databank $7F

        sep #$20
        lda aRangeMap,y
        clc
        adc wAITemp000EA0
        bcc +

          lda #$FF

        +
        sta aRangeMap,y
        rep #$20
        rts

        .databank 0

      rlFillMovementCostMapSpecial ; 86/AC3E

        .al
        .autsiz
        .databank ?

        ; Like the regular one, but makes ramparts and castle tiles passable 
        ; with a move cost of 16

        phb
        php

        sep #$20
        lda #`aMovementCostMap
        pha
        rep #$20
        plb
        .databank `aMovementCostMap

        phx
        phy

        jsl rlGetSelectedUnitMovementCostPointer
        sta @l aAIAction.wUnitMovementCostPointer

        sep #$20
        ldy #size(aMapData) / size(word) -1

          -
          jsr rlFillMovementCostMapSpecialEffect
          sta aMovementCostMap,y
          dec y
          bpl -

        rep #$20

        ply
        plx
        plp
        plb
        rtl

        .databank 0

      rlFillMovementCostMapSpecialEffect ; 86/AC67

        .as
        .autsiz
        .databank $7F

        ; Input:
        ; aAIAction.wUnitMovementCostPointer

        ; Output:
        ; A = movement cost

        php
        rep #$20

        .al

        tya
        asl
        tax
        lda aMapData,x
        and #$03FF
        tax
        lda aTerrainTileset,x
        and #$00FF
        cmp #TerrainRampart
        beq ++

        cmp #TerrainCastle
        beq ++

        cmp #TerrainRoad+1
        bcc +

          ; Any invalid terrain counts as a peak
          lda #TerrainPeak

        ; Get the terrain movement cost +1 fot that tile
        +
        clc
        adc @l aAIAction.wUnitMovementCostPointer
        tax
        plp

        .as

        lda $830000,x
        inc a

        -
        rts

        +
        plp
        lda #16
        bra -

        .databank 0

      rlFillMovementCostMap ; 86/AC9E

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`aMovementCostMap
        pha
        rep #$20
        plb
        .databank `aMovementCostMap

        phx
        phy

        jsl rlGetSelectedUnitMovementCostPointer
        sta @l aAIAction.wUnitMovementCostPointer

        sep #$20
        ldy #size(aMapData) / size(word) -1

        -
        jsr rsFillMovementCostMapEffect
        sta aMovementCostMap,y
        dec y
        bpl -

        ply
        plx
        plp
        plb
        rtl

        .databank 0

      rsFillMovementCostMapEffect ; 86/ACC5

        .as
        .autsiz
        .databank $7F

        php
        rep #$20
        tya
        asl a
        tax
        lda aMapData,x
        and #$03FF
        tax
        lda aTerrainTileset,x
        and #$00FF
        cmp #TerrainRoad +1
        bcc +

          lda #0
        
        +
        clc
        adc @l aAIAction.wUnitMovementCostPointer
        tax
        plp
        lda $830000,x
        inc a
        rts

        .databank 0

      rlIncreaseMoveCostOfFoesOccupiedTiles ; 86/ACED

        .al
        .autsiz
        .databank ?

        ; Add 24 to the move cost of any tile a foe is on?

        phb
        php
        phk
        plb
        phx
        phy

        jsl rlGetSelectedUnitFactionSlot
        sta $7F442C

        sep #$20
        lda #$7F
        pha
        rep #$20
        plb
        .databank $7F

        ldx #(len(aDeploymentTable._State) - 2)
        
          _Loop
          txa
          lda aDeploymentTable._State,x
          bit #DeploymentStateAlive
          beq _Next

            bit #DeploymentStateHidden
            bne _Next

              phx
              lda aDeploymentTable._FactionSlot,x
              ldx $442C,b
              jsl rlGetFactionRelation
              plx

              cmp #AllegianceOther
              beq +

                cmp #AllegianceEnemy
                bne _Next

              ; Target is a foe
              +
              lda aDeploymentTable._XTilePosition,x
              sta aAIAction.wAttackTileXPosition
              lda aDeploymentTable._YTilePosition,x
              sta aAIAction.wAttackTileYPosition

              lda aAIAction.wAttackTileYPosition
              and #$00FF
              xba
              lsr a
              lsr a
              clc
              adc aAIAction.wAttackTileXPosition
              tay

              sep #$20
              lda #24
              clc
              adc aMovementCostMap,y
              sta aMovementCostMap,y
              rep #$20

          _Next
          dec x
          dec x
          bpl _Loop

        ply
        plx
        plp
        plb
        rtl

        .databank 0

        ; 86/AD5E

    .endsection AIMovementMapSection


    .section FillMapBufferSection

      .al
      .xl

      rlFillMapBuffer ; 86/AE3E

        .al
        .autsiz
        .databank ?

        ; A = bank of buffer
        ; X = lower word of buffer
        ; Y = fill value

        phb

        sep #$20
        pha
        rep #$20
        plb

        tya
        ldy #256 >> 1
        
          -
          sta $0000,b,x
          sta $0100,b,x
          sta $0200,b,x
          sta $0300,b,x
          sta $0400,b,x
          sta $0500,b,x
          sta $0600,b,x
          sta $0700,b,x
          sta $0800,b,x
          sta $0900,b,x
          sta $0A00,b,x
          sta $0B00,b,x
          sta $0C00,b,x
          sta $0D00,b,x
          sta $0E00,b,x
          sta $0F00,b,x

          inc x
          inc x
          dec y
          bne -

        plb
        rtl

        .databank 0

      rlClearMapBufferAddBorders ; 86/AE80

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = map pointer bank
        ; X = map pointer lower word

        phb
        sep #$20
        pha
        rep #$20
        plb

        phx

        txa
        clc
        adc #64
        tax
        ldy #64 -2
        
        _Loop
        lda #$00FF
        sta $0000,b,x

        lda #0
        sta $0002,b,x
        sta $0004,b,x
        sta $0006,b,x
        sta $0008,b,x
        sta $000A,b,x
        sta $000C,b,x
        sta $000E,b,x
        sta $0010,b,x
        sta $0012,b,x
        sta $0014,b,x
        sta $0016,b,x
        sta $0018,b,x
        sta $001A,b,x
        sta $001C,b,x
        sta $001E,b,x
        sta $0020,b,x
        sta $0022,b,x
        sta $0024,b,x
        sta $0026,b,x
        sta $0028,b,x
        sta $002A,b,x
        sta $002C,b,x
        sta $002E,b,x
        sta $0030,b,x
        sta $0032,b,x
        sta $0034,b,x
        sta $0036,b,x
        sta $0038,b,x
        sta $003A,b,x
        sta $003C,b,x

        lda #$FF00
        sta $003E,b,x

        txa
        clc
        adc #64
        tax
        dec y
        bne _Loop

        plx
        ldy #64 >> 2

        lda wCurrentChapter
        beq +

          ; Prologue only gets half the buffer
          lda #$FFFF

          -
          sta $0000 +  0 * 64 + (0 * 64 / size(word)),b,x
          sta $0000 +  0 * 64 + (1 * 64 / size(word)),b,x
          sta $0000 + 63 * 64 + (0 * 64 / size(word)),b,x
          sta $0000 + 63 * 64 + (1 * 64 / size(word)),b,x
          inc x
          inc x
          dec y
          bne -
          bra _End

        +
        lda #$FFFF

        -
        sta $0000 +  0 * 64 + (0 * 64 / size(word)),b,x
        sta $0000 +  0 * 64 + (1 * 64 / size(word)),b,x
        sta $0000 + 31 * 64 + (0 * 64 / size(word)),b,x
        sta $0000 + 31 * 64 + (1 * 64 / size(word)),b,x
        inc x
        inc x
        dec y
        bne -
        
        _End
        plb
        rtl

        .databank 0

        ; 86/AF39

    .endsection FillMapBufferSection


    .section AIUnitMapSection

      .al
      .xl

      rlFillAllyUnitMap ; 86/C110

        .al
        .autsiz
        .databank ?

        lda #<>aAllyUnitMap
        sta aAIAction.wMapPointer
        lda #$FFFF
        sta $0EA2,b
        lda #FillUnitMapAllyFilter
        jsl rlFillUnitMap
        rtl

        .databank 0

      rlFillFoeUnitMap ; 86/C125

        .al
        .autsiz
        .databank ?

        lda #<>aFoeUnitMap
        sta aAIAction.wMapPointer
        lda #$FFFF
        sta $0EA2,b
        lda #FillUnitMapFoeFilter
        jsl rlFillUnitMap
        rtl

        .databank 0

      rlFillUnitMap ; 86/C13A

        .al
        .autsiz
        .databank ?

        ; Writes deployment offsets of units to their map tile index, depening on the filter setting.

        ; Input:
        ; aAIAction.wMapPointer
        ; $0EA2 = deployment offset AND value
        ; A = filter

        phb
        php
        phk
        plb
        .databank `*
        phx
        phy

        asl a
        tax
        lda aFillUnitMapFilter,x
        sta lAITemp000E90,b

        lda wAIActiveFaction,b
        sta $7F442C

        sep #$20
        lda #`aAllyUnitMap
        pha
        rep #$20
        plb
        .databank `aAllyUnitMap

        lda @l aAIAction.wMapPointer
        tay
        ldx #size(aAllyUnitMap)
        lda #$FFFF

          -
          sta $0000,b,y
          inc y
          inc y
          dec x
          dec x
          bne -

        ldx #(len(aDeploymentTable._State) - 2)

        _Loop
        txa
        lda aDeploymentTable._State,x
        bit #DeploymentStateAlive
        beq _Next

          bit #DeploymentStateHidden
          bne _Next

            jsr rsFillUnitMapApplyFilter
            bcc _Next

              lda aDeploymentTable._XTilePosition,x
              sta aAIAction.wAttackTileXPosition
              lda aDeploymentTable._YTilePosition,x
              sta aAIAction.wAttackTileYPosition

              lda aAIAction.wAttackTileYPosition
              and #$00FF
              xba
              lsr a
              lsr a
              clc
              adc aAIAction.wAttackTileXPosition
              adc aAIAction.wMapPointer
              tay

              txa
              and $000EA2
              sep #$20
              sta $0000,b,y
              rep #$20

        _Next
        dec x
        dec x
        bpl _Loop

        ply
        plx
        plp
        plb
        rtl

        .databank 0

      rsFillUnitMapApplyFilter ; 86/C1B6

        .al
        .autsiz
        .databank ?

        jmp (lAITemp000E90)

        .databank 0

      aFillUnitMapFilter .include "../../data/system/FillUnitMapFilters.csv.asm" ; 86/C1B9

      rsFillUnitMapAllyFilter ; 86/C1BF

        .al
        .autsiz
        .databank ?

        phx
        lda aDeploymentTable._FactionSlot,x
        ldx $442C,b
        jsl rlGetFactionRelation
        cmp #AllegianceEnemy
        beq rsFillUnitMapFoeFilter._CLC

        cmp #AllegianceOther
        beq rsFillUnitMapFoeFilter._CLC
        bra rsFillUnitMapFoeFilter._SEC

        .databank 0

      rsFillUnitMapFoeFilter ; 86/C1D7

        .al
        .autsiz
        .databank ?

        phx
        lda aDeploymentTable._FactionSlot,x
        ldx $442C,b
        jsl rlGetFactionRelation
        cmp #AllegianceOther
        beq _SEC

        cmp #AllegianceEnemy
        bne _CLC
        
        _SEC
        plx
        sec
        rts

        _CLC
        plx
        clc
        rts

        .databank 0

      rsFillUnitMapNoFilter ; 86/C1F3

        .al
        .autsiz
        .databank ?

        sec
        rts

        .databank 0

      rlUnknown86C1F5 ; 86/C1F5

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb

        jsl rlGetSelectedUnitTotalFieldMovement
        sta wAITemp000EA2

        jsr rsUnknown86C20B
        jsl rlFillMovementMap
        plp
        plb
        rtl

        .databank 0

      rsUnknown86C20B ; 86/C20B

        .al
        .autsiz
        .databank ?

        lda wAIUnknownBitfield7E2000
        bit #$0200
        beq +

          jsl rlGetSelectedUnitStates
          bit #UnitStateCanto
          bne +

            lsr wAITemp000EA2,b

        +
        rts

        .databank 0

      rlUnknown86C221 ; 86/C221

        .al
        .autsiz
        .databank ?

        ; Sets units position as the target tile and then checks if from the position
        ; of the target tile if the units tile is reachable.

        ; wAITemp000E96 / wAITemp000E98 = units coords
        ; wAITemp000E9A / wAITemp000E9C = target coords

        phb
        php
        phk
        plb
        lda wAITemp000E96
        pha
        lda wAITemp000E98
        pha
        lda wAITemp000E9A
        pha
        lda wAITemp000E9C
        pha

        jsl rlClearTargetMap

        lda #0
        jsl rlSetTargetMapTile
        jsl rlFillMovementCostMap
        jsl rlIncreaseMoveCostOfFoesOccupiedTiles

        lda wAITemp000E9A
        sta wAITemp000E96
        lda wAITemp000E9C
        sta wAITemp000E98

        jsl rlGetNearestPossibleTarget
        bcc _SEC

          pla
          sta wAITemp000E9C
          pla
          sta wAITemp000E9A
          pla
          sta wAITemp000E98
          pla
          sta wAITemp000E96
          plp
          plb
          clc
          bra +

        _SEC
        pla
        sta wAITemp000E9C
        pla
        sta wAITemp000E9A
        pla
        sta wAITemp000E98
        pla
        sta wAITemp000E96
        plp
        plb
        sec

        +
        rtl

        .databank 0

        ; 86/C293

    .endsection AIUnitMapSection


    .section AIRangeMapSection

      .al
      .xl

      rlGetHighestRangeItemInInventory ; 87/D546

        .al
        .autsiz
        .databank ?

        ; Output:
        ; $0EA2 = pointer of highest range item
        ; $0EA4 = highest range weapon in inv

        phy
        lda #0
        sta $0EA4,b
        sta $0EA2,b
        sta wCurrentItemDataROMPointer,b

        jsl rlGetSelectedUnitInventorySize
        cmp #0
        beq _End

          tay
          
            _Loop
            tya
            jsl rlGetItemROMDataByInventorySlot
            jsl rlGetItemEquipmentType
            cmp #EquipTypeWeapon
            beq +

              ; if: silence, sleep, berserk or thief staff effect, ok, else branch
              jsl rlGetItemStaffEffect
              cmp #$000C
              bcc _Next

            +
            jsl rlGetItemMaximumRange
            cmp $0EA4,b
            bcc _Next

              sta $0EA4,b
              lda wCurrentItemDataROMPointer,b
              sta $0EA2,b
            
            _Next
            dec y
            bne _Loop

          lda $0EA2,b
          sta wCurrentItemDataROMPointer,b
        
        _End
        ply
        rtl

        .databank 0

      rlClearRangeMap ; 87/D591

        .al
        .autsiz
        .databank ?

        phb
        sep #$20
        lda #`aRangeMap
        pha
        rep #$20
        plb
        .databank `aRangeMap

        ldx #size(aRangeMap) / 8 - 2
        lda #0

          -
          sta aRangeMap,x
          sta aRangeMap + $200,x
          sta aRangeMap + $400,x
          sta aRangeMap + $600,x
          sta aRangeMap + $800,x
          sta aRangeMap + $A00,x
          sta aRangeMap + $C00,x
          sta aRangeMap + $E00,x
          dec x
          dec x
          bpl -

        plb
        rtl

        .databank 0

      rlFillRangeMapOfAITargetsNearLeader ; 87/D5BE

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        phy

        sep #$20
        lda #$7F
        pha
        rep #$20
        plb
        .databank $7F

        jsl rlClearRangeMap

        lda wAIGroupLeaderXPosition
        sec
        sbc #16
        bcs +

          lda #1

        +
        sta wAITemp000E9A

        lda wAIGroupLeaderYPosition
        sec
        sbc #16
        bcs +

          lda #1
        
        +
        sta wAITemp000E9C

        lda wAIGroupLeaderXPosition
        clc
        adc #16
        cmp #64
        bcc +

          lda #63
        
        +
        sta wAITemp000E9E

        lda wAIGroupLeaderYPosition
        clc
        adc #16
        cmp #64
        bcc +

          lda #63
        
        +
        sta wAITemp000EA0

        lda wAITargetCounter
        beq ++

          tay
          ldx #0
          
          _Loop
          jsr rsCheckIfAITargetWithinSpecifiedLeaderRange
          bcc +

            jsr rsFillAITargetsRangeMap

          +
          txa
          clc
          adc #size(structAITargetEntry)
          tax
          dec y
          bne _Loop

        +
        bra _End

        ; 87/D637

        jsr $87D65A
        ldy #3
        ldx #0

        _Loop2
        phx
        lda $EC4A,b,x
        cmp #$FFFF
        beq +

          tax
          jsr rsFillAITargetsRangeMap

        +
        plx
        inc x
        inc x
        inc x
        inc x
        dec y
        bne _Loop2
        
        _End
        ply
        plx
        plp
        plb
        rtl

        .databank 0

        ; 87/D65A

    .endsection AIRangeMapSection


    .section AITargetMapSection

      .al
      .xl

      rsCheckIfAITargetWithinSpecifiedLeaderRange ; 87/D711

        .al
        .autsiz
        .databank ?

        ; Input:
        ; X = AITarget offset
        ; wAITemp000E9A = leader X coord - 16
        ; wAITemp000E9C = leader Y coord - 16
        ; wAITemp000E9E = leader X coord + 16
        ; wAITemp000EA0 = leader Y coord + 16
        ; All coords are exclusive

        lda aAITargetList[0].XPosition,x
        and #$00FF
        cmp wAITemp000E9A
        bcc _CLC

        cmp wAITemp000E9E
        bcs _CLC

        lda aAITargetList[0].YPosition,x
        and #$00FF
        cmp wAITemp000E9C
        bcc _CLC

        cmp wAITemp000EA0
        bcs _CLC
        bra _SEC

        _CLC
        clc
        bra +

        _SEC
        sec

        +
        rts

        .databank 0

      rsFillAITargetsRangeMap ; 87/D73E

        .al
        .autsiz
        .databank ?

        ; X = AI target list offset

        lda wAITemp000EA0
        pha
        phx

        lda aAITargetList[0].DeploymentOffset,x
        and #$00FF
        tax
        lda aDeploymentTable._State,x
        plx
        bit #DeploymentStateAlive
        beq _End

          lda aAITargetList[0].UnitRAMPointer,x
          sta wSelectedUnitDataRAMPointer
          lda aAITargetList[0].ItemROMPointer,x
          beq _End

            sta wCurrentItemDataROMPointer
            lda aAITargetList[0].XPosition,x
            and #$00FF
            sta wAITemp000E96
            lda aAITargetList[0].YPosition,x
            and #$00FF
            sta wAITemp000E98

            lda #1
            sta wAITemp000EA0

            jsl rlGetSelectedUnitTotalFieldMovement
            sta wAITemp000EA2

            jsl rlGetItemMinimumRange
            cmp #3
            bcs _End

              sta wAITemp000EA4
              jsl rlGetItemMaximumRange
              cmp wAITemp000EA4
              beq +

                clc
                adc wAITemp000EA4
                sta wAITemp000EA4

              +
              jsl rsFillRangeMap

        _End
        pla
        sta wAITemp000EA0
        rts

        .databank 0

      rlClearTargetMap ; 87/D7B7

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`aTargetMap
        pha
        rep #$20
        plb
        .databank `aTargetMap

        phx
        ldx #size(aTargetMap) / 8 - 2
        lda #$FFFF

          -
          sta aTargetMap,x
          sta aTargetMap + $200,x
          sta aTargetMap + $400,x
          sta aTargetMap + $600,x
          sta aTargetMap + $800,x
          sta aTargetMap + $A00,x
          sta aTargetMap + $C00,x
          sta aTargetMap + $E00,x
          dec x
          dec x
          bpl -

        plx
        plp
        plb
        rtl

        .databank 0

      rlSetTargetMapTile ; 87/D7E8

        .al
        .autsiz
        .databank ?

        ; A = value to write to TargetMap
        ; wAITemp000E96 = XPosition
        ; wAITemp000E98 = YPosition

        phb
        php
        phk
        plb
        phx
        pha

        ; Get tile index from coordinates
        lda wAITemp000E98,b
        xba
        lsr a
        lsr a
        clc
        adc wAITemp000E96,b
        tax

        pla
        sep #$20
        sta aTargetMap,x
        rep #$20

        lda wAIUnknownBitfield7E2000
        ora #$0020
        sta wAIUnknownBitfield7E2000

        plx
        plp
        plb
        rtl

        .databank 0

    .endsection AITargetMapSection
