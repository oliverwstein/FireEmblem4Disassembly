; Deciding whether and how an AI unit acts: silence targets, capturable castles,
; the closest tile to a target, and low-HP checks.

    .section AIActionSection

      .al
      .xl

      rlCheckIfAIUnitCanAct ; 86/B421

        .al
        .autsiz
        .databank ?

        phx
        ldx wAISelectedAIUnitOffset,b
        lda aAIUnitList[0].UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        tax
        lda $7E0000,x
        cmp #$FFFF
        beq _SEC

          jsl rlGetSelectedUnitStates
          bit #(UnitStateMoved | UnitStateDead)
          bne _SEC

            jsl rlGetSelectedUnitStatus
            cmp #StatusCured
            beq _SEC

              cmp #StatusFreelancer
              beq _SEC

                cmp #StatusCaptive
                beq _SEC

                  cmp #StatusSleep
                  beq _SEC

                    clc

                    -
                    plx
                    rtl

        _SEC
        sec
        bra -

        .databank 0

      rlUnknown86B45D ; 86/B45D

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        lda aAIAction.wDestinationXPosition
        sta wAITargetXPosition,b
        lda aAIAction.wDestinationYPosition
        sta wAITargetYPosition,b
        lda $7F4440
        sta wAIUnknown000E8E,b
        lda aAIAction.wChosenTargetDeploymentOffset
        sta wAIUnknown000E8C,b
        plp
        plb
        rtl

        .databank 0

      rsUnknown86B480 ; 86/B480

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx

        ldx wAISelectedAIUnitOffset,b
        bit #$2000
        bne ++

          lda wAIUnknownBitfield7E2000
          bit #$0004
          beq ++

            ; foes in threat range
            lda aAIUnitList[0].XPosition,x
            and #$00FF
            sta wAITemp000E96,b
            lda aAIUnitList[0].YPosition,x
            and #$00FF
            sta wAITemp000E98,b

            lda wAIUnknown7E2014
            sta wAITemp000E9A,b
            lda wAIUnknown7E2016
            sta wAITemp000E9C,b
            jsl rlUnknown86C221

            phx
            lda wAITemp000E98,b
            xba
            lsr a
            lsr a
            clc
            adc wAITemp000E96,b
            tax

            lda aTargetDistanceMap,x
            and #$00FF
            bne +

              lda #$00FF

            ; Save distance to target
            +
            sta aAIAction.wMovementDistanceToTarget
            plx

        +
        sep #$20
        lda #$7F
        pha
        rep #$20
        plb
        .databank $7F

        lda #1
        sta aAIAction.wUnitInventorySlot
        lda aAIUnitList[0].XPosition,x
        and #$00FF
        sta aAIAction.wDestinationXPosition
        lda aAIUnitList[0].YPosition,x
        and #$00FF
        sta aAIAction.wDestinationYPosition
        lda #$FFFF
        sta aAIAction.wChosenTargetDeploymentOffset
        lda #$C000
        sta aAIAction.wBestAttackChance
        lda #$4000
        sta aAIAction.wUnitToChosenTargetDistance

        jsl rlGetCleverModeFlag
        cmp #1
        beq _CleverModeEnabled

          lda wAICurrentAISetting
          jsl rlGetAIGroupsLeadershipPower
          bra +

        _CleverModeEnabled
        lda #100

        +
        sta aAIAction.wLeadershipPower

        lda wAIUnknown7E2002
        sta aAIAction.wUnknown7F4448

        jsl rlGetSelectedUnitStates
        bit #UnitStateGuardingCastle
        beq +

          lda #5
          sta aAIAction.wUnknown7F4448

        +
        lda #$FFFF
        sta $000EA2
        lda #<>aUnitMap
        sta @l aAIAction.wMapPointer
        lda #FillUnitMapNoFilter
        jsl rlFillUnitMap

        jsl rlGetSelectedUnitFactionSlot
        sta aAIAction.wUnitFaction
        jsl rlGetSelectedUnitMovementCostPointer
        sta aAIAction.wUnitMovementCostPointer
        lda aAIUnitList[0].DeploymentOffset,x
        and #$00FF
        sta aAIAction.wUntDeploymentOffset

          _Loop
          lda aAIAction.wUnitInventorySlot
          jsl rlGetItemROMDataByInventorySlot
          lda wCurrentItemDataROMPointer
          beq _End

          jsl rlGetItemMinimumRange
          sta aAIAction.wUnitItemMinimumRange
          jsl rlGetItemMaximumRange
          sta aAIAction.wUnitItemMaximumRange

          lda wCurrentItemDataROMPointer
          sta aAIUnitList[0].ItemROMPointer,x
          jsl rlGetSelectedUnitBattleMight
          cmp #256
          bcc +

            lda #255

          +
          sep #$20
          sta aAIUnitList[0].BattleMight,x
          rep #$20

          jsl rlGetItemWeaponType
          sep #$20
          sta aAIUnitList[0].ItemType,x
          rep #$20

          jsl rlGetItemEquipmentType
          cmp #EquipTypeWeapon
          beq _Weapon

            cmp #EquipTypeStaff
            beq _Staff
            bra _Next
          
          _Weapon
          jsl rlCheckWeaponEquippable
          bcc _Next

            jsr rsUnknown86B5E7
            bra _Next
          
          _Staff
          jsl rlCheckStaffEquippable
          bcc _Next

            phx
            jsr rsUnknown86B60B
            plx

          _Next
          inc aAIAction.wUnitInventorySlot
          bra _Loop

        _End
        lda aAIAction.wChosenTargetDeploymentOffset
        cmp #$FFFF
        beq +

          jsl rlUnknown86B45D

        +
        plx
        plp
        plb
        rts

        .databank 0

      rsUnknown86B5E7 ; 86/B5E7

        .al
        .autsiz
        .databank $7F

        jsl rlGetSelectedUnitStatus
        cmp #StatusBerserk
        beq +

        lda #2
        sta aAIAction.wUnknown7F4402
        jsr rsUnknown86B666
        bra ++
        
        +
        lda #0
        sta aAIAction.wLeadershipPower
        lda #2
        sta aAIAction.wUnknown7F4402
        jsr rsUnknown86B73E

        +
        rts

        .databank 0

      rsUnknown86B60B ; 86/B60B

        .al
        .autsiz
        .databank $7F

        jsl rlGetItemStaffEffect
        cmp #$0C
        bcs _StatusStaff

          ; Branch if utility staff
          cmp #6
          bcs _End

            ; Only healing staves left
            tax
            jsl rlGetSelectedUnitStatus
            cmp #StatusBerserk
            beq _End

              lda #1
              sta aAIAction.wUnknown7F4402
              jsr rsUnknown86B73E
              cpx #5
              bne _End

                lda aAIAction.wChosenTargetDeploymentOffset
                cmp #$FFFF
                beq _End

                  lda $4440,b
                  cmp #14
                  bne _End

                    lda #$FFFE
                    sta aAIAction.wChosenTargetDeploymentOffset

          _End
          rts
        
        _StatusStaff
        jsl rlGetSelectedUnitStatus
        cmp #StatusBerserk
        beq +

        lda #0
        sta aAIAction.wUnknown7F4402
        jsr rsUnknown86B666
        bra ++

        +
        lda #0
        sta aAIAction.wUnknown7F4402
        jsr rsUnknown86B73E
        
        +
        rts

        .databank 0

      rsUnknown86B666 ; 86/B666

        .al
        .autsiz
        .databank $7F

        phx
        lda wAITargetCounter
        beq _End

          tay
          lda #0
          sta wAISelectedAITargetOffset
          
            _Loop
            lda wAISelectedAITargetOffset
            tax
            lda aAITargetList[0].DeploymentOffset,x
            and #$00FF
            sta aAIAction.wTargetDeploymentOffset
            tax
            jsr rsCheckIfPossibleSilenceTarget
            bcs _Next

              jsr rsUnknown86B6BE
              bcs _Next

                lda aDeploymentTable._State,x
                bit #DeploymentStateAlive
                beq _Next

                  lda wAIUnknown7E2002
                  cmp #7
                  bne +

                    lda aDeploymentTable._State,x
                    bit #DeploymentStateGuardingCastle
                    bne _Next

                  +
                  jsr rsUnknown86B771

            _Next
            lda wAISelectedAITargetOffset
            clc
            adc #size(structAITargetEntry)
            sta wAISelectedAITargetOffset
            dec y
            bne _Loop
        
        _End
        plx
        rts

        .databank 0

      rsUnknown86B6BE ; 86/B6BE

        .al
        .autsiz
        .databank $7F

        phx
        lda wSelectedUnitDataRAMPointer
        pha

        lda wAIIgnoredGenerationID
        beq _CLC

          lda aAIAction.wUntDeploymentOffset
          cmp wAIGroupLeaderDeploymentOffset
          bne _CLC

            ldx aAIAction.wTargetDeploymentOffset
            lda aDeploymentTable._UnitRAMPointer,x
            sta wSelectedUnitDataRAMPointer
            jsl rlGetSelectedUnitFactionSlot
            cmp #0
            bne _CLC

              jsl rlGetSelectedUnitGenerationID
              cmp wAIIgnoredGenerationID
              bne _CLC

                sec
                pla
                sta wSelectedUnitDataRAMPointer
                plx
                rts
        
        _CLC
        clc
        pla
        sta wSelectedUnitDataRAMPointer
        plx
        rts

        .databank 0

      rsCheckIfPossibleSilenceTarget ; 86/B701

        .al
        .autsiz
        .databank $7F

        ; Input:
        ; X = offset into target AI list
        ; aAIAction.wTargetDeploymentOffset

        phx
        lda wSelectedUnitDataRAMPointer
        pha

        jsl rlGetItemStaffEffect
        cmp #$000C
        bne _CLC

          ; Is silence
          ldx aAIAction.wTargetDeploymentOffset
          lda aDeploymentTable._UnitRAMPointer,x
          sta wSelectedUnitDataRAMPointer

          ldx #structClassROMEntry.StaffRank - structClassROMEntry.SwordRank

            -
            txa
            jsl rlGetSelectedUnitWeaponRank
            cmp #WeaponRankNone
            bcc _CLC

            inc x
            cpx #size(structClassROMEntry.WeaponRanks)
            bcc -

          sec
          pla
          sta wSelectedUnitDataRAMPointer
          plx
          rts
        
        _CLC
        clc
        pla
        sta wSelectedUnitDataRAMPointer
        plx
        rts

        .databank 0

      rsUnknown86B73E ; 86/B73E

        .al
        .autsiz
        .databank $7F

        phx
        lda #$FFFF
        sta wAISelectedAITargetOffset

        ldx #(len(aDeploymentTable._State) - 2)

          _Loop
          cpx aAIAction.wUntDeploymentOffset
          beq _Next

            lda aDeploymentTable._State,x
            bit #DeploymentStateAlive
            beq _Next

              txa
              jsl rlCheckIfTargetFoeOfOwnFaction
              bcc _Next

                stx aAIAction.wTargetDeploymentOffset
                jsr rsCheckIfPossibleSilenceTarget
                bcs _Next

                  phx
                  jsr rsUnknown86B771
                  plx

          _Next
          dec x
          dec x
          bpl _Loop

        plx
        rts

        .databank 0

      rsUnknown86B771 ; 86/B771

        .al
        .autsiz
        .databank $7F

        ; Check if target within units threat range?

        ; X = AI target deployment offset

        lda aDeploymentTable._XTilePosition,x
        sta aAIAction.wTargetXPosition
        lda aDeploymentTable._YTilePosition,x
        sta aAIAction.wTargetYPosition

        lda wAISelectedAIUnitOffset
        tax
        lda aAIUnitList[0].XPosition,x
        and #$00FF
        sec
        sbc aAIAction.wTargetXPosition
        bpl +

          eor #$FFFF
          inc a

        +
        sta wAITemp000E9E

        lda aAIUnitList[0].YPosition,x
        and #$00FF
        sec
        sbc aAIAction.wTargetYPosition
        bpl +

          eor #$FFFF
          inc a
        
        +
        clc 
        adc wAITemp000E9E
        sta wAITemp000E9E

        lda aAIUnitList[0].ThreatRange,x
        and #$00FF
        cmp wAITemp000E9E
        bcc +

          lda aAIAction.wUnitItemMinimumRange
          sta aAIAction.wMinimumAttackRange
          lda aAIAction.wUnitItemMaximumRange
          sta aAIAction.wMaximumAttackRange
          jsl rlUnknown869F35

        +
        rts

        .databank 0

      rsUnknown86B7D1 ; 86/B7D1

        .al
        .autsiz
        .databank ?

        clc
        rts

        .databank 0

      rsCheckAnyFoeInGroupRangeFlagUnset ; 86/B7D3

        .al
        .autsiz
        .databank ?

        lda wAIUnknownBitfield7E2000
        bit #$0004
        beq +

          clc
          rts

        +
        sec
        rts

        .databank 0

      rsCheckIfCastlesCapturable ; 86/B7E0

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        phy

        lda wSelectedUnitDataRAMPointer,b
        pha

        lda wAIUnknown7E2002
        cmp #7
        beq _CLC

        cmp #3
        beq _CLC

        cmp #6
        beq _CLC

          ldx wAISelectedAIUnitOffset,b
          lda aAIUnitList[0].UnitRAMPointer,x
          sta wSelectedUnitDataRAMPointer,b

          jsl rlGetSelectedUnitStatus
          cmp #StatusBerserk
          beq _CLC

            lda wAIUnknown7E201A
            cmp #7
            beq _CLC

              jsl rlGetSelectedUnitStates
              bit #UnitStateGroupLeader
              beq +

                lda wAIUnknown7E201A
                cmp #10
                beq _CLC

                  cmp #11
                  beq _CLC

              +
              lda aAIUnitList[0].DeploymentOffset,x
              and #$00FF
              sta aAIAction.wUntDeploymentOffset

              sep #$20
              lda #$7F
              pha
              rep #$20
              plb
              .databank $7F

              ldy #0

              -
              tya
              jsl rlGetLocationEventDataEntry
              bcs _CLC

                jsl rlGetEventLocationEntryType
                cmp #0
                bne _Next

                  ; Is a castle
                  jsr rsCheckIfFoesCastleUnblockedReachable
                  bcc _Next

                    jsr rsUnknown86B8CB
                    bcs _SEC

                    jsr rsUnknown86B8E5
                    bcs _SEC

                _Next
                inc y
                bra -

        _CLC
        pla
        sta wSelectedUnitDataRAMPointer
        ply
        plx
        plp
        plb
        clc
        rts
        
        _SEC
        pla
        sta wSelectedUnitDataRAMPointer
        ply
        plx
        plp
        plb
        sec
        rts

        .databank 0

      rsCheckIfFoesCastleUnblockedReachable ; 86/B87E

        .al
        .autsiz
        .databank $7F

        ; Check if foes castle is within move range
        ; and not blocked or blocked by own unit

        lda wAIActiveFaction
        tax
        jsl rlGetLocationFactionSlotOwner
        jsl rlGetFactionRelation
        cmp #AllegianceEnemy
        bne _CLC
        
          jsl rlCheckLocationDestroyed
          bcs _CLC

            jsl rlGetEventLocationEntryEffectiveXCoordinate
            sta aAIAction.wDestinationXPosition
            jsl rlGetEventLocationEntryEffectiveYCoordinate
            sta aAIAction.wDestinationYPosition

            lda aAIAction.wDestinationYPosition
            xba
            lsr a
            lsr a
            clc
            adc aAIAction.wDestinationXPosition
            tax

            lda aMovementMap,x
            and #$00FF
            beq _CLC

              lda aAllyUnitMap,x
              and #$00FF
              cmp aAIAction.wUntDeploymentOffset
              beq _SEC

                cmp #$00FF
                bne _CLC

              _SEC
              sec
              rts
        
        _CLC
        clc
        rts

        .databank 0

      rsUnknown86B8CB ; 86/B8CB

        .al
        .autsiz
        .databank $7F

        jsl rlCheckIfCastleGuarded
        bcs +

          lda #4
          sta $4440,b
          lda #$FFFF
          sta aAIAction.wChosenTargetDeploymentOffset
          jsl rlUnknown86B45D
          sec
          rts
        
        +
        clc
        rts

        .databank 0

      rsUnknown86B8E5 ; 86/B8E5

        .al
        .autsiz
        .databank $7F

        jsl rlGetSelectedUnitStates
        bit #UnitStateCanto
        beq +

          jml _CLC
        
        +
        jsl rlGetFirstEquippableWeaponInInventory
        sta aAIAction.wUnitInventorySlot

        jsl rlCheckWeaponEquippable
        bcs +

          jml _CLC
        
        +
        lda wCurrentItemDataROMPointer
        bne +

          jml _CLC
        
        +
        jsl rlGetItemMinimumRange
        cmp #2
        bcc +

          jml _CLC
        
        +
        jsl rlGetEventLocationEntryCoordinates
        pha
        and #$00FF
        sta $EC48,b
        pla

        and #$FF00
        lsr a
        lsr a
        clc
        adc $EC48,b
        tax
        lda $554A,b,x
        and #$00FF
        sta aAIAction.wTargetDeploymentOffset
        jsr rsUnknown86B6BE
        bcc +

          jml _CLC
        
        +
        lda wCurrentTurn
        and #$FFC0
        sta aAIAction.wTurnValue
        lda aAIAction.wUntDeploymentOffset
        sta wAITemp000E96

        lda aAIAction.wTargetDeploymentOffset
        sta wAITemp000E98
        lda #9
        sta $000E9A
        lda #1
        sta $000E9C
        lda aAIAction.wUnitInventorySlot
        sta $000E9E
        jsl rlUnknown86BFE6
        clc
        adc aAIAction.wTurnValue
        ora #0
        beq _CLC

        ldx aAIAction.wTargetDeploymentOffset
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer
        jsl rlGetFirstEquippableWeaponInInventory

        lda wCurrentItemDataROMPointer
        beq +

          jsl rlGetItemMaximumRange
          cmp #2
          beq +

            lda wAISelectedAIUnitOffset
            tax
            lda aAIUnitList[0].ItemROMPointer,x
            sta wCurrentItemDataROMPointer
            jsl rlGetItemMaximumRange
            cmp #2
            beq ++
        
        +
        lda aAIAction.wUnitInventorySlot
        sta wSelectedInventorySlot
        lda #2
        sta $4440,b
        lda aAIAction.wTargetDeploymentOffset
        sta aAIAction.wChosenTargetDeploymentOffset
        jsl rlUnknown86B45D
        bra _SEC

        +
        lda aAIAction.wUnitInventorySlot
        sta wSelectedInventorySlot
        lda #15
        sta $4440,b
        lda aAIAction.wTargetDeploymentOffset
        sta aAIAction.wChosenTargetDeploymentOffset
        jsl rlUnknown86B45D
        bra _SEC
        
        _SEC
        sec
        rts
        
        _CLC
        clc
        rts

        .databank 0

      rsUnknown86B9E6 ; 86/B9E6

        .al
        .autsiz
        .databank ?

        clc
        rts

      rsUnknown86B9E8 ; 86/B9E8

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx

        sep #$20
        lda #$7F
        pha
        rep #$20
        plb
        .databank $7F

        lda wAIUnknown7E2018
        cmp #$FFFF
        bne +

          jsr rlUnknown86BA3B
          cmp #$FFFF
          beq ++

        +
        jsl rlGetLocationEventDataEntry
        bcs _End

          jsl rlGetEventLocationEntryType
          cmp #2
          bne _End

            jsl rlGetEventLocationEntryEffectiveXCoordinate
            sta aAIAction.wDestinationXPosition
            jsl rlGetEventLocationEntryEffectiveYCoordinate
            sta aAIAction.wDestinationYPosition

            lda #5
            sta $4440,b
            lda #$FFFF
            sta aAIAction.wChosenTargetDeploymentOffset
            jsl rlUnknown86B45D
            bra _End
            
            +
            nop

        _End
        plx
        plp
        plb
        clc
        rts

        .databank 0

        ; 86/BA3B

    .endsection AIActionSection


    .section AIAction86BA86Section

      .al
      .xl

      rsUnknown86BA86 ; 86/BA86

        .al
        .autsiz
        .databank ?

        phx
        jsl rlGetSelectedUnitStates
        bit #UnitStateGuardingCastle
        bne +

          jml _End
        
        +
        bit #UnitStateCanto
        beq +

          jml _End
        
        +
        jsl rlGetSelectedUnitStatus
        cmp #StatusBerserk
        bne +

          jml _End
        
        +
        lda wAITemp000E96,b
        sta aAIAction.wDestinationXPosition
        lda wAITemp000E98,b
        sta aAIAction.wDestinationYPosition
        jsl rlGetFirstEquippableWeaponInInventory
        sta aAIAction.wUnitInventorySlot
        jsl rlCheckWeaponEquippable
        bcc _End

          lda wCurrentItemDataROMPointer,b
          beq _End

            jsl rlGetItemMinimumRange
            cmp #2
            bcs _End

              lda wAITemp000E98,b
              inc a
              inc a
              xba
              lsr a
              lsr a
              clc
              adc wAITemp000E96,b
              tax

              lda aFoeUnitMap,x
              and #$00FF
              cmp #$00FF
              beq _End

                sta aAIAction.wTargetDeploymentOffset

                lda aAIAction.wUntDeploymentOffset
                sta wAITemp000E96,b
                lda aAIAction.wTargetDeploymentOffset
                sta wAITemp000E98,b
                lda #9
                sta wAITemp000E9A,b
                lda #1
                sta wAITemp000E9C,b
                lda aAIAction.wUnitInventorySlot
                sta wAITemp000E9E,b
                jsl rlUnknown86BFE6
                ora #0
                beq _End

                  lda aAIAction.wUnitInventorySlot
                  sta wSelectedInventorySlot,b
                  lda #2
                  sta $7F4440
                  lda aAIAction.wTargetDeploymentOffset
                  sta aAIAction.wChosenTargetDeploymentOffset
                  jsl rlUnknown86B45D

        _End
        plx
        sec
        rts

        .databank 0

      rsUnknown86BB38 ; 86/BB38

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx

        ldx wAISelectedAIUnitOffset,b
        lda aAIUnitList[0].UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitStates
        bit #UnitStateCanto
        beq +

          jml _End
        
        +
        jsr rlUnknown86BCB1
        bcc +

          jml _End
        
        +
        jsr rlUnknown86BCC7
        bcc +

          jml _End
        
        +
        jsl rlGetSelectedUnitStates
        bit #UnitStateCanto
        beq +

          jml _End
        
        +
        bit #UnitStateGroupLeader
        bne +

        lda wAIUnknown7E201C
        cmp #12
        bne +

          jml _End
        
        +
        sep #$20
        lda #$7F
        pha
        rep #$20
        plb
        .databank $7F

        lda wAIUnknown7E2018
        asl a
        tax
        lda aDeploymentTable._State,x
        bit #DeploymentStateAlive
        bne +

          jml _End
        
        +
        bit #DeploymentStateHidden
        beq +

          jml _End
        
        +
        lda wCurrentChapter
        bne +

        lda #31
        bra ++
        
        +
        lda #63
        
        +
        sta wAITemp000EA2
        lda aDeploymentTable._XTilePosition,x
        sta aAIAction.wDestinationXPosition
        lda aDeploymentTable._YTilePosition,x
        dec a
        cmp #1
        bcc +

          sta aAIAction.wDestinationYPosition
          jsr rlUnknown86BC64
          bne _BC3E
        
        +
        lda aDeploymentTable._XTilePosition,x
        dec a
        cmp #1
        bcc +

          sta aAIAction.wDestinationXPosition
          lda aDeploymentTable._YTilePosition,x
          sta aAIAction.wDestinationYPosition
          jsr rlUnknown86BC64
          bne _BC3E
        
        +
        lda aDeploymentTable._XTilePosition,x
        inc a
        cmp #63
        bcs +

          sta aAIAction.wDestinationXPosition
          lda aDeploymentTable._YTilePosition,x
          sta aAIAction.wDestinationYPosition
          jsr rlUnknown86BC64
          bne _BC3E
        
        +
        lda aDeploymentTable._XTilePosition,x
        sta aAIAction.wDestinationXPosition
        lda aDeploymentTable._YTilePosition,x
        inc a
        cmp $000EA2
        bcs +

          sta aAIAction.wDestinationYPosition
          jsr rlUnknown86BC64
          bne _BC3E
        
        +
        lda aDeploymentTable._State,x
        bit #DeploymentStateGuardingCastle
        beq _End

          lda aDeploymentTable._XTilePosition,x
          sta aAIAction.wDestinationXPosition
          lda aDeploymentTable._YTilePosition,x
          inc a
          inc a
          sta aAIAction.wDestinationYPosition
          jsr rlUnknown86BC64
          beq _End
          
            _BC3E
            lda wAIUnknown7E201C
            sta $4440,b
            bne +

            lda #$FFFF
            bra ++
            
            +
            lda wAIUnknown7E2018
            asl a

            +
            sta aAIAction.wChosenTargetDeploymentOffset
            lda #1
            sta wSelectedInventorySlot
            jsl rlUnknown86B45D
        
        _End
        plx
        plp
        plb
        clc
        rts

        .databank 0

        ; 86/BC64

    .endsection AIAction86BA86Section


    .section AIClosestTileSection

      .al
      .xl

      rsUnknown86BCE3 ; 86/BCE3

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx

        jsl rlGetSelectedUnitStates
        bit #UnitStateGroupLeader
        beq +

          jsr rsUnknown86BD06
          bcs +

            lda #3
            sta $7F4440
            jsl rlUnknown86B45D
        
        +
        plx
        plp
        plb
        clc
        rts

        .databank 0

      rsUnknown86BD06 ; 86/BD06

        .al
        .autsiz
        .databank ?

        lda wAIActiveFaction,b
        jsl rlGetFactionSlotLocationID
        jsl rlGetLocationEventDataEntry
        bcs _SEC

          jsl rlGetEventLocationEntryType
          cmp #0
          bne _SEC

            jsl rlGetEventLocationEntryEffectiveXCoordinate
            sta aAIAction.wDestinationXPosition
            jsl rlGetEventLocationEntryEffectiveYCoordinate
            sta aAIAction.wDestinationYPosition
            lda #$FFFF
            sta aAIAction.wChosenTargetDeploymentOffset
            clc
            rts

        _SEC
        sec
        rts

        .databank 0

      rsUnknown86BD37 ; 86/BD37

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx

        jsl rlGetSelectedUnitStates
        bit #UnitStateGroupLeader
        beq +

          jsr rsUnknown86BD06
          bcs +

            lda #13
            sta $7F4440
            jsl rlUnknown86B45D

        +
        plx
        plp
        plb
        clc
        rts

        .databank 0

      rsUnknown86BD5A ; 86/BD5A

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb

        jsl rlGetSelectedUnitStates
        bit #UnitStateGroupLeader
        beq +

          lda wAITemp000E96,b
          sta aAIAction.wDestinationXPosition
          lda wAITemp000E98,b
          sta aAIAction.wDestinationYPosition
          lda #$FFFF
          sta aAIAction.wChosenTargetDeploymentOffset
          lda #0
          sta $7F4440
          jsl rlUnknown86B45D

        +
        plp
        plb
        clc
        rts

        .databank 0

      rsUnknown86BD8B ; 86/BD8B

        .al
        .autsiz
        .databank ?

        jsr rsUnknown86BD06
        bcs +

          lda #3
          sta $7F4440
          jsl rlUnknown86B45D

        +
        clc
        rts

        .databank 0

      rsUnknown86BD9D ; 86/BD9D

        .al
        .autsiz
        .databank ?

        phx
        lda wAIUnknown7E201A
        cmp #9
        beq _SEC

          cmp #11
          beq _SEC

            cmp #12
            beq _SEC

              lda wAITemp000E98,b
              and #$00FF
              xba
              lsr a
              lsr a
              clc
              adc wAITemp000E96,b
              tax

              lda aFoeUnitMap,x
              and #$00FF
              cmp #$00FF
              bne _SEC 

                lda #4
                sta $0D81,b
                lda $056F,b
                sta $0D83,b
                lda #0
                sta wUnknownDeploymentOffset000D7F,b

                  -
                  lda wUnknownDeploymentOffset000D7F,b
                  beq -

                clc
                bra +

        _SEC
        sec
        
        +
        plx
        rts

        .databank 0

      rlUnknown86BDE8 ; 86/BDE8

        .al
        .autsiz
        .databank ?

        ; wAITemp000E96 = unit X
        ; wAITemp000E98 = unit Y

        ; wAITemp000E9A = target X
        ; wAITemp000E9C = target Y

        phb
        php
        phk
        plb
        phx

        ldx wAITemp000E9A,b
        cpx #1
        bmi _SEC

        cpx #63
        bpl _SEC

        ldx wAITemp000E9C,b
        cpx #1
        bmi _SEC

        cpx #63
        bpl _SEC

        ldx wAITemp000E96,b
        cpx wAITemp000E9A,b
        bne +

          ldx wAITemp000E98,b
          cpx wAITemp000E9C,b
          beq _CLC

        +
        jsl rlUnknown86C221
        bcs _SEC

        jsr rsGetClosestTileToTarget
        bcs _CLC

        ldx wAITemp000E96,b
        cpx wAITemp000E9E,b
        bne _End

        ldx wAITemp000E98,b
        cpx wAITemp000EA0,b
        beq +
        
        _End
        plx
        plp
        plb
        clc
        
        -
        rtl
        
        _CLC
        lda wAITemp000E96,b
        sta wAITemp000E9E,b
        lda wAITemp000E98,b
        sta wAITemp000EA0,b
        bra _End
        
        _SEC
        lda wAITemp000E96,b
        sta wAITemp000E9E,b
        lda wAITemp000E98,b
        sta wAITemp000EA0,b
        
        +
        plx
        plp
        plb
        sec
        bra -

        .databank 0

      rsGetClosestTileToTarget ; 86/BE57

        .al
        .autsiz
        .databank ?

        ; Makes a box around units with length = threat range lookup * 2 + 1

        ; Input:
        ; wAITemp000E96 = starting X pos
        ; wAITemp000E98 = starting Y pos

        ; Output:
        ; wAITemp000E9E = ending X pos
        ; wAITemp000EA0 = ending Y pos

        phb
        php
        phk
        plb

        jsl rlGetSelectedUnitTotalMovement
        inc a
        tax
        lda _MovementThreatRangeLookupTable,x
        and #$00FF
        sta wAITemp000E9E,b

        lda wAITemp000E98,b
        sec
        sbc wAITemp000E9E,b
        cmp #1
        bmi +
        bra ++

          +
          lda #1

        +
        xba
        lsr a
        lsr a
        sta wR37

        lda wAITemp000E96,b
        sec
        sbc wAITemp000E9E,b
        cmp #1
        bpl +

          lda #1

        +
        clc
        adc wR37
        tay

        ; Tile index of top left corner in Y

        stz wR36
        lda wAITemp000E96,b
        sec
        sbc wAITemp000E9E,b
        sec
        sbc #1
        bpl +

          eor #$FFFF
          inc a
          sta wR36
          bra ++

        +
        lda wAITemp000E96,b
        clc
        adc wAITemp000E9E,b
        sec
        sbc #63
        bmi +

          inc a
          sta wR36

        +
        lda wAITemp000E9E,b
        asl a
        inc a
        sec
        sbc wR36
        sta wR34

        stz wR36
        lda wAITemp000E98,b
        sec
        sbc wAITemp000E9E,b
        sec
        sbc #1
        bpl +

          eor #$FFFF
          inc a
          sta wR36
          bra ++
        
        +
        lda wAITemp000E98,b
        clc
        adc wAITemp000E9E,b
        sec
        sbc #63
        bmi +

          inc a
          sta wR36

        +
        lda wAITemp000E9E,b
        asl a
        inc a
        sec
        sbc wR36
        sta wR35

        sep #$20
        lda #$7F
        pha
        rep #$20
        plb
        .databank $7F

        lda #$00FF
        sta $442A,b
        lda #$7FFF
        sta aAIAction.wDestinationXPosition
        lda #0
        sta $442C,b

        ; Starts in the top left corner, offset by class move loopup stuff
        ; wR34 = width, wR35 = height

        sep #$20
        lda wR35
        sta wR37

          -
          lda wR34
          sta wR36

            -
            jsr rsCheckIfTileCloserToTarget
            inc y
            dec wR36
            bne -

          rep #$20
          tya
          clc
          adc #64
          sec
          sbc wR34
          tay

          sep #$20
          dec wR37
          bne --

        rep #$20
        lda $442C,b
        beq _SEC

        ; Get target X and Y coordinates
        and #$003F
        sta wAITemp000E9E
        lda $442C,b
        lsr a
        lsr a
        lsr a
        lsr a
        lsr a
        lsr a
        sta wAITemp000EA0
        plp
        plb
        clc

        -
        rts

        _SEC
        plp
        plb
        sec
        bra -

        .databank 0

        _MovementThreatRangeLookupTable ; 86/BF57

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

      rsCheckIfTileCloserToTarget ; 86/BF65

        .al
        .autsiz
        .databank $7F

        ; Y = map tile index / 2

        ; Output:
        ; $442A best movement distance
        ; $442C best tile index

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
        cmp #TerrainCastleGate
        bne +

          lda wAIUnknown000E8E
          bmi +

          cmp #2
          beq +

          cmp #15
          beq +

          cmp #4
          beq +

          cmp #3
          beq +

          cmp #13
          beq +
          bra _End
        
        +
        lda aAllyUnitMap,y
        and #$00FF
        cmp aAIAction.wUntDeploymentOffset
        beq +

          cmp #$00FF
          bne _End

        +
        lda aMovementMap,y
        and #$00FF
        beq _End

          ; found a tile unit can move to
          lda aRangeMap,y
          and #$00FF
          sta aAIAction.wAttackTileThreatValue

          lda aTargetDistanceMap,y
          and #$00FF
          beq _End

            ; Tile had an entry on the distance map
            cmp $442A,b
            beq _SameDistance
            bcs _End

            ; Is newest closest tile
            sta $442A,b

            lda aAIAction.wAttackTileThreatValue
            bra +

            _SameDistance
            lda aAIAction.wAttackTileThreatValue
            cmp aAIAction.wDestinationXPosition
            bcs _End

            +
            sta aAIAction.wDestinationXPosition
            sty $442C,b
        
        _End
        plp
        rts

        .databank 0

        ; 86/BFE6

    .endsection AIClosestTileSection


    .section AILowHPSection

      .al
      .xl

      rlAICheckIfUnitOnLowHP ; 86/C0AF

        .al
        .autsiz
        .databank ?

        ; Input:
        ; X = deployment offset

        ; Output:
        ; A = 21 - current HP, if HP is above 21 = 0
        ; Y = current HP
        ; SEC if HP is 21 or above, else CLC

        phb
        php
        phk
        plb
        phx
        lda wSelectedUnitDataRAMPointer,b
        pha

        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitCurrentHP
        tay
        cmp #21
        bcs +

        eor #$FFFF
        inc a
        clc
        adc #21

        -
        plx
        stx wSelectedUnitDataRAMPointer,b
        plx
        plp
        plb
        rtl
        
        +
        lda #0
        bra -

        .databank 0

      rlAIGetMissingHPRatio ; 86/C0DE

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx

        lda wSelectedUnitDataRAMPointer,b
        pha

        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b

        jsl rlGetSelectedUnitCurrentHP
        and #$00FF
        xba
        sta wR36
        jsl rlGetSelectedUnitMaxHP
        sta wR37
        jsl rlUnsignedDivide16By16

        lda #256
        sec
        sbc wR36

        plx
        stx wSelectedUnitDataRAMPointer,b
        plx
        plp
        plb
        rtl

        .databank 0

    .endsection AILowHPSection
