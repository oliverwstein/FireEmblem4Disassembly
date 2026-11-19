; Building the AI's list of its own units and its list of targets.

    .section AITargetListSection

      .al
      .xl

      rlBuildAITargetList ; 87/CBC6

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
        lda #$7E
        pha
        rep #$20
        plb
        .databank $7E

        ldy #<>aAITargetList[0]
        stz wAITargetCounter
        ldx #(len(aDeploymentTable._State) - 2)

          _Loop
          lda aDeploymentTable._State,x
          bit #DeploymentStateAlive
          bne +

            jml _Next

          +
          phx
          lda aDeploymentTable._FactionSlot,x
          tax
          lda wAIActiveFaction,b
          jsl rlGetFactionRelation
          plx
          cmp #AllegianceEnemy
          beq +

            jml _Next

          +
          lda aDeploymentTable._UnitRAMPointer,x
          sta wSelectedUnitDataRAMPointer,b
          sta structAITargetEntry.UnitRAMPointer,b,y
          txa
          sta structAITargetEntry.DeploymentOffset,b,y

          jsl rlGetFirstWeaponBattleMight
          ora #0
          bne +

            inc a

          +
          sep #$20
          sta structAITargetEntry.BattleMight,b,y
          rep #$20

          jsl rlGetSelectedUnitTotalDefense

          sep #$20
          sta structAITargetEntry.BattleDefense,b,y
          rep #$20

          jsl rlGetSelectedUnitTotalResistance

          sep #$20
          sta structAITargetEntry.BattleResistance,b,y
          rep #$20

          lda wCurrentItemDataROMPointer,b
          sta structAITargetEntry.ItemROMPointer,b,y
          beq +

            jsl rlGetItemMaximumRange
          
          +
          sta $7FEC48

          jsr rsGetSelectedUnitMovementThreatRange
          clc
          adc $7FEC48

          sep #$20
          sta structAITargetEntry.ThreatRange,b,y
          rep #$20

          jsl rlGetItemWeaponType
          sep #$20
          sta structAITargetEntry.ItemType,b,y
          lda @l aDeploymentTable._XTilePosition,x
          sta structAITargetEntry.XPosition,b,y
          lda @l aDeploymentTable._YTilePosition,x
          sta structAITargetEntry.YPosition,b,y
          rep #$20

          txa
          jsl rlGetTerrainTypeByDeploymentOffset

          sep #$20
          sta structAITargetEntry.TerrainType,b,y
          rep #$20

          inc wAITargetCounter

          tya
          clc
          adc #size(structAITargetEntry)
          tay

          _Next
          dec x
          dec x
          bmi +

            jml _Loop

        +
        ply
        plx
        plp
        plb
        rtl

        .databank 0

      rsGetSelectedUnitMovementThreatRange ; 87/CC8D

        .al
        .autsiz
        .databank ?

        phx
        jsl rlGetSelectedUnitTotalMovement
        tax
        lda _MovementThreatRangeLookupTable,x
        and #$00FF
        plx
        rts

        .databank 0

        _MovementThreatRangeLookupTable ; 87/CC9C

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

    .endsection AITargetListSection


    .section AIUnitListSection

      .al
      .xl

      rlBuildAIUnitList ; 87/D811

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = group ID

        phb
        php
        phk
        plb
        phx

        ldx wAITemp000E96,b
        phx
        ldx wAITemp000E98,b
        phx

        sta wAITemp000E96,b

        lda #$FFFF
        sta wAIGroupLeaderDeploymentOffset
        lda #0
        sta wAIGroupHighestItemRange

        ldx #0
        txa
        sta wAIUnitCounter

        lda wAIActiveFaction,b
        jsl rlGetFactionSlotUnitCount
        ora #0
        bne +

          jml _End

        +
        sta wAITemp000E98,b

          ; Now wAITemp000E98 holds the unit count/last faction entry ID and is decremented each loop.

          _Loop
          lda wAITemp000E98,b
          sta wRoutineVariable1,b

          lda wAIActiveFaction,b
          jsl rlGetUnitRAMDataPointerByFactionSlotEntryID

          lda wSelectedUnitDataRAMPointer,b
          beq _End

            jsl rlGetSelectedUnitAI
            cmp wAITemp000E96,b
            bne _Next

              jsl rlGetSelectedUnitStates
              bit #UnitStateDead
              beq _Alive

                bit #UnitStateGroupLeader
                beq _Next

                  lda wAIUnknownBitfield7E2000
                  ora #$0008
                  sta wAIUnknownBitfield7E2000
                  bra _Next

              _Alive
              phx
              jsl rlGetSelectedUnitDeploymentOffset
              tax
              lda aDeploymentTable._XTilePosition,x
              sta wAITemp000E9A,b
              lda aDeploymentTable._YTilePosition,x
              sta wAITemp000E9C,b
              txa

              plx
              jsr rsFillAIUnitListEntry

              jsl rlGetSelectedUnitStates
              bit #UnitStateGroupLeader
              beq _NotLeader

                bit #UnitStateFielded
                bne +

                  stx wAISelectedAIUnitOffset,b
                  lda wAIUnknownBitfield7E2000
                  ora #$0040
                  sta wAIUnknownBitfield7E2000

                +
                lda aAIUnitList[0].DeploymentOffset,x
                and #$00FF
                sta wAIGroupLeaderDeploymentOffset

              _NotLeader
              txa
              clc
              adc #size(structAIUnitEntry)
              tax

              lda wAIUnitCounter
              inc a
              sta wAIUnitCounter

          _Next
          dec wAITemp000E98,b
          beq _End

            jml _Loop

        _End
        plx
        stx wAITemp000E98,b
        plx
        stx wAITemp000E96,b
        plx
        plp
        plb
        rtl

        .databank 0

      rsFillAIUnitListEntry ; 87/D8E4

        .al
        .autsiz
        .databank ?

        ; Input:
        ; wAITemp000E9A = X coordinate
        ; wAITemp000E9C = Y coordinate

        sep #$20
        sta aAIUnitList[0].DeploymentOffset,x
        lda wAITemp000E9A,b
        sta aAIUnitList[0].XPosition,x
        lda wAITemp000E9C,b
        sta aAIUnitList[0].YPosition,x
        rep #$20

        lda wSelectedUnitDataRAMPointer,b
        sta aAIUnitList[0].UnitRAMPointer,x

        jsl rlGetFirstWeaponBattleMight
        sep #$20
        sta aAIUnitList[0].BattleMight,x
        rep #$20

        lda wCurrentItemDataROMPointer,b
        sta aAIUnitList[0].ItemROMPointer,x

        jsl rlGetSelectedUnitTotalDefense
        sep #$20
        sta aAIUnitList[0].BattleDefense,x
        rep #$20

        jsl rlGetSelectedUnitTotalResistance
        sep #$20
        sta aAIUnitList[0].BattleResistance,x
        rep #$20

        jsl rlGetItemWeaponType
        sep #$20
        sta aAIUnitList[0].ItemType,x
        rep #$20

        jsl rlGetSelectedUnitAttackThreatRange
        sep #$20
        sta aAIUnitList[0].ThreatRange,x
        rep #$20

        jsl rlGetItemMaximumRange
        cmp wAIGroupHighestItemRange
        bcc +

          sta wAIGroupHighestItemRange

        +
        rts

        .databank 0

    .endsection AIUnitListSection
