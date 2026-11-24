; Changing a unit's state: damage, healing, death and revival, faction slot, money,
; inventory and supply, capture, arena winnings and residing castle.

    .section UnitHPAndDeathSection

      .al
      .xl

      rlActionStructInflictDamage ; 84/A8C7

        .al
        .autsiz
        .databank ?

        ; A = attacker character ID
        ; wRoutineVariable1 = damage dealt

        ; sec if fatal

        phb
        phk
        plb
        phx
        phy
        ldx wR10
        phx
        ldx wR1
        phx

        sta wR10

        lda wRoutineVariable1,b
        beq _CLC

        cmp #80
        bcc +

        lda #80
        sta wRoutineVariable1,b

        +
        jsl rlGetSelectedUnitPersonalDataPointer

        sep #$20
        lda structPersonalCharacterDataRAM.CurrentHP,b,x
        cmp wRoutineVariable1
        bcs +

          sta wRoutineVariable1

        +
        lda structPersonalCharacterDataRAM.CurrentHP,b,x
        sec
        sbc wRoutineVariable1
        sta structPersonalCharacterDataRAM.CurrentHP,b,x
        rep #$20

        and #$00FF
        beq +

        cmp #11
        bcs _CLC

        lda #UnitStateMiracleActive
        jsl rlSetSelectedUnitStates
        
        _CLC
        clc
        
        -
        plx
        stx wR1
        plx
        stx wR10
        ply
        plx
        plb
        rtl

        +
        jsl rlActionStructHandleUnitDeath
        sec
        bra -

        .databank 0

      rlHealSelectedUnitsHP ; 84/A927

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        lda wRoutineVariable1,b
        pha

        lda wRoutineVariable1,b
        beq _CLC

        cmp #80
        bcc +

          lda #80
          sta wRoutineVariable1,b

        +
        jsl rlGetSelectedUnitPersonalDataPointer

        sep #$20
        lda structPersonalCharacterDataRAM.CurrentHP,b,x
        and #$FF
        clc
        adc wRoutineVariable1
        pha
        rep #$20

        jsl rlGetSelectedUnitMaxHP
        sta wRoutineVariable1,b

        sep #$20
        pla
        cmp wRoutineVariable1,b
        bcc +

          lda wRoutineVariable1,b
          sta structPersonalCharacterDataRAM.CurrentHP,b,x
          rep #$20

          pla
          sta wRoutineVariable1,b
          plx
          plp
          plb
          sec
          bra _End

        +
        sta structPersonalCharacterDataRAM.CurrentHP,b,x
        rep #$20
        
        _CLC
        pla
        sta wRoutineVariable1,b
        plx
        plp
        plb
        clc
        
        _End
        rtl

        .databank 0

      rlActionStructSetUnitDeath ; 84/A982

        .al
        .autsiz
        .databank ?

        ; Run when a unit doesnt have the escape skill or the PoW skill + its not ch11

        phb
        php
        phk
        plb
        lda wRoutineVariable1,b
        pha

        jsl rlGetSelectedUnitDeploymentOffset
        sta wDefeatedUnitDeploymentOffset,b

        tax
        lda aDeploymentTable._StateBuffer,x
        ora #DeploymentStateDefeated
        sta aDeploymentTable._StateBuffer,x
        lda aDeploymentTable._State,x
        ora #DeploymentStateDefeated
        sta aDeploymentTable._State,x

        lda #UnitStateDead
        jsl rlSetSelectedUnitStates

        pla
        sta wRoutineVariable1,b
        plp
        plb
        rtl

        .databank 0

      rlReviveSelectedCharacter ; 84/A9B6

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        jsl rlGetSelectedUnitFactionSlot
        jsl rlGetFactionSlotLocationID
        sta wRoutineVariable1,b

        jsl rlGetSelectedUnitDeploymentOffset
        tax

        lda wRoutineVariable1,b
        jsl rlSetUnitResidingInCastle
        lda aDeploymentTable._StateBuffer,x
        and #~(DeploymentStateAsleep | DeploymentStateDefeated | DeploymentStateGrayed)
        sta aDeploymentTable._StateBuffer,x
        sta aDeploymentTable._State,x

        lda #(UnitStateMoved | UnitStateDead)
        jsl rlUnsetSelectedUnitStates

        lda #StatusHealthy
        jsl rlSetSelectedUnitStatus
        lda #0
        jsl rlSetSelectedUnitStatusDuration

        jsl rlGetSelectedUnitMaxHP
        jsl rlSetSelectedUnitCurrentHP
        jsl rlGetSelectedUnitPersonalDataPointer
        jsl rlGetSelectedUnitClassDataPointer
        jsl rlGetClassMoney

        sep #$20
        sta structPersonalCharacterDataRAM.ClassMoney,b,x
        rep #$20
        plx
        plp
        plb
        rtl

        .databank 0

    .endsection UnitHPAndDeathSection


    .section UnitStateSection

      .al
      .xl

      rlAssignUnitToNewFactionSlot ; 84/B1B8

        .al
        .autsiz
        .databank ?

        ; Input:
        ; wRoutineVariable1 = FactionSlot

        phb
        php
        phk
        plb
        phx

        lda wRoutineVariable1,b
        jsl rlAssignUnitToFactionSlot

        plx
        plp
        plb
        rtl

        .databank 0

      rlActionStructSetUnitDefeatedEscape ; 84/B1C8

        .al
        .autsiz
        .databank ?

        jsl rlGetSelectedUnitDeploymentOffset
        jsl rlDeployedUnitSetDefeated

        lda #UNIT_RELOCATION_ESCAPED
        sta wUnitRelocationType,b

        jsl rlGetSelectedUnitFactionSlot
        cmp #7
        bcs +

          jsl rlRemoveSelectedUnitFromFactionSlot

        +
        rtl

        .databank 0

      rlUndeployUnit ; 84/B1E4

        .al
        .autsiz
        .databank ?

        phx
        jsl rlGetSelectedUnitStates
        bit #UnitStateGuardingCastle
        beq +

          lda #UnitStateGuardingCastle
          jsl rlUnsetSelectedUnitStates

          jsl rlGetSelectedUnitHomeCastle
          bcc +

            jsl rlGetLocationEventDataEntry
            bcs +

              jsl rlUnsetCastleGuarded

        +
        jsl rlGetSelectedUnitDeploymentOffset
        jsl rlGetSelectedUnitFactionSlot
        cmp #7
        bcs _End

          jsl rlRemoveSelectedUnitFromFactionSlot

          lda #7
          jsl rlSetSelectedUnitFaction

          jsl rlGetSelectedUnitDeploymentOffset
          cmp #$00FF
          beq _End

            tax
            jsl rlClearUnitDeploymentData
            lda aDeploymentTable._StateBuffer,x
            sta aDeploymentTable._State,x

            lda #$00FF
            jsl rlSetSelectedUnitDeploymentOffset

        _End
        plx
        rtl

        .databank 0

      rlAddSelectedCharacterMoney ; 84/B23C

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        phy

        ldy #0

        jsl rlGetSelectedUnitExtendedPersonalDataPointer

        lda structExtendedCharacterDataRAM.Money,b,x
        clc
        adc wRoutineVariable1,b
        bcs +

        cmp #50000+1
        bcc ++
        
        +
        sec
        sbc #50000
        tay

        lda #50000

        +
        sta structExtendedCharacterDataRAM.Money,b,x
        tya
        ply
        plx
        plp
        plb
        rtl

        .databank 0

      rlSubtractSelectedCharacterMoney ; 84/B268

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx

        jsl rlGetSelectedUnitMoney
        sec
        sbc wRoutineVariable1,b
        bcs +

          lda #0
        
        +
        jsl rlSetSelectedUnitMoney

        plx
        plp
        plb
        rtl

        .databank 0

      rlBuyItemForSelectedUnit ; 84/B282

        .al
        .autsiz
        .databank ?

        ; Buys the item with player item index wRoutineVariable1 at rlGetItemBuyPrice,
        ; half with Bargain. Carry set if the unit cannot pay.

        phb
        phk
        plb
        lda wR0
        pha

        lda wRoutineVariable1,b
        jsl rlGetItemRAMStructEntryByPlayerItemIndex
        jsl rlGetItemBuyPrice
        sta wR0

        lda #SkillIDBargain
        jsl rlCheckIfUnitHasSpecifiedPersonalOrClassSkill
        bcs +

        lda #SkillIDBargain
        jsl rlCheckIfInventoryItemsHaveSpecifiedSkill
        bcc ++
        
        +
        lsr wR0

        +
        jsl rlGetSelectedUnitMoney
        cmp wR0
        bcc _SEC

        jsl rlGivePlayerItemIDToSelectedUnit

        lda wR0
        sta wRoutineVariable1,b
        jsl rlSubtractSelectedCharacterMoney
        clc

        -
        pla
        sta wR0
        plb
        rtl

        _SEC
        sec
        bra -

        .databank 0

      rlSellInventorySlotItem ; 84/B2C7

        .al
        .autsiz
        .databank ?

        ; Sells the item in inventory slot wRoutineVariable1 at rlGetItemSellPrice.
        ; Carry set for holy weapons (weapon rank $FFFF), which cannot be sold.

        phb
        phk
        plb
        lda wR0
        pha

        lda wRoutineVariable1,b
        cmp #8
        bcs _End

        jsl rlGetInventorySlotItemSellPrice
        sta wR0
        jsl rlGetItemROMPointerByItemRAMStructEntry
        jsl rlGetItemWeaponRank
        cmp #$FFFF
        beq _SEC

        lda wRoutineVariable1,b
        jsl rlRemoveItemInSpecifiedInventorySlot
        lda wR0
        sta wRoutineVariable1,b
        jsl rlAddSelectedCharacterMoney
        clc

        _End
        pla
        sta wR0
        plb
        rtl

        _SEC
        sec
        bra _End

        .databank 0

      rlDiscardSelectedInventoryItem ; 84/B301

        .al
        .autsiz
        .databank ?

        ; Removes the item in wSelectedInventorySlot. Carry set for holy weapons,
        ; which cannot be thrown away.

        phb
        phk
        plb

        lda wSelectedInventorySlot,b
        jsl rlGetItemROMDataByInventorySlot
        jsl rlGetItemWeaponRank
        cmp #$FFFF
        beq _SEC

        lda wSelectedInventorySlot,b
        jsl rlRemoveItemInSpecifiedInventorySlot
        clc
        
        -
        plb
        rtl
        
        _SEC
        sec
        bra -

        .databank 0

      rlApplySelectedInventorySlotBonus ; 84/B321

        .al
        .autsiz
        .databank ?

        lda wSelectedInventorySlot,b
        beq +

          jsl rlFlagEquippedInventorySlotAndGetStatBonus
        
        +
        rtl

        .databank 0

        ; 84/B32B

    .endsection UnitStateSection


    .section UnitInventoryStateSection

      .al
      .xl

      rlDumpInventorySlotIntoSupplyIfFilled ; 84/B3E4

        .al
        .autsiz
        .databank ?

        phb
        phk
        plb
        lda wSelectedInventorySlot,b
        jsl rlGetItemRAMStructEntryByInventorySlot
        bcs +

          lda #2
          sta wR0
          lda wSelectedUnitDataRAMPointer,b
          sta wR1
          jsl rlSetItemRAMStateAndOwner

          lda wSelectedInventorySlot,b
          jsl rlRemoveItemInSpecifiedInventorySlot

        +
        plb
        rtl

        .databank 0

      rlChangeFactionSlotOfSelectedUnit ; 84/B407

        .al
        .autsiz
        .databank ?

        ; Input:
        ; filled wSelectedUnitDataRAMPointer
        ; wRoutineVariable1 = FactionSlot

        phb
        php
        phk
        plb

        jsl rlGetSelectedUnitFactionSlot
        cmp wRoutineVariable1,b
        beq +

          jsl rlRemoveSelectedUnitFromFactionSlot
          jsl rlAssignUnitToNewFactionSlot

          lda #UnitStateGroupLeader
          jsl rlUnsetSelectedUnitStates

        +
        plp
        plb
        rtl

        .databank 0

      rlSendInventorySlotItemToSupply ; 84/B426

        .al
        .autsiz
        .databank ?

        ; Moves the item in inventory slot wRoutineVariable1 to the supply
        ; (ItemStateSupply, owned by the selected unit).

        phb 
        php
        phk
        plb

        lda wR0
        pha
        lda wR1
        pha

        lda wRoutineVariable1,b
        jsl rlGetItemRAMStructEntryByInventorySlot
        bcs +

          lda #ItemStateSupply
          sta wR0
          lda wSelectedUnitDataRAMPointer,b
          sta wR1
          jsl rlSetItemRAMStateAndOwner

          lda wRoutineVariable1,b
          jsl rlRemoveItemInSpecifiedInventorySlot

        +
        pla
        sta wR1
        pla
        sta wR0

        plp
        plb
        rtl

        .databank 0

      rlGiveItemToUnitCheckEncumbered ; 84/B457

        .al
        .autsiz
        .databank ?

        ; Input:
        ; wRoutineVariable1 = player item ID

        phb
        php
        phk
        plb
        phx
        jsl rlGiveItemToUnit
        jsl rlGetSelectedUnitInventorySize
        cmp #8
        bcc +

          jsl rlGetSelectedUnitDeploymentOffset
          sta wInventoryFullDeploymentOffset,b

        +
        plx
        plp
        plb
        rtl

        .databank 0

      rlSetSelectedUnitStateAssault ; 84/B474

        .al
        .autsiz
        .databank ?

        lda #UnitStateAssault
        jsl rlSetSelectedUnitStates
        rtl

        .databank 0

      rlActionStructSetUnitDefeatedPoW ; 84/B47C

        .al
        .autsiz
        .databank ?

        jsl rlGetSelectedUnitDeploymentOffset
        jsl rlDeployedUnitSetDefeated

        lda #UNIT_RELOCATION_CAPTURED
        sta wUnitRelocationType,b

        lda #StatusCaptive
        jsl rlSetSelectedUnitStatus
        rtl

        .databank 0

      rlActionStructHandleArenaDefeat ; 84/B492

        .al
        .autsiz
        .databank ?

        ; A unit defeated in the arena keeps 1 HP and is marked as defeated.

        ; Unit died in the arena

        phb
        php
        phk
        plb
        phx

        lda #1
        jsl rlSetSelectedUnitCurrentHP

        jsl rlGetSelectedUnitDeploymentOffset
        bcs +

          tax
          lda aDeploymentTable._StateBuffer,x
          ora #DeploymentStateDefeated
          sta aDeploymentTable._StateBuffer,x
          sta aDeploymentTable._State,x

          lda wChapterFlags,b
          bit #$0020
          bne +

            stx wDefeatedUnitDeploymentOffset,b

        +
        plx
        plp
        plb
        rtl

        .databank 0

      rlDoNothing84B4C3 ; 84/B4C3

        .al
        .autsiz
        .databank ?

        rtl

        .databank 0

      rlActionStructArenaWinResults ; 84/B4C4

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        lda wRoutineVariable1,b
        pha

        jsl rlGetSelectedUnitArenaLevel
        cmp #7
        bcs +

          pha
          asl a
          tax
          lda aArenaMoneyRewards,x
          sta wRoutineVariable1,b

          jsl rlAddSelectedCharacterMoney
          pla

          inc a
          jsl rlSetSelectedUnitArenaLevel
          lda wRoutineVariable1,b

          -
          plx
          stx wRoutineVariable1,b
          plx
          plp
          plb
          rtl

        +
        lda #0
        bra -

        .databank 0

      aArenaMoneyRewards ; 84/B4FA

        .word 1000
        .word 1500
        .word 2000
        .word 2500
        .word 3000
        .word 3500
        .word 4000

        ; 84/B508

    .endsection UnitInventoryStateSection


    .section UnitDeathSection

      .al
      .xl

      rlActionStructHandleUnitDeath ; 84/B8C1

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        phy
        ldx lR18
        phx
        ldx lR18+1
        phx

        jsl rlGetSelectedUnitStates
        bit #UnitStateGuardingCastle
        beq +

          lda #UnitStateGuardingCastle
          jsl rlUnsetSelectedUnitStates

          jsl rlGetSelectedUnitHomeCastle
          bcc +

            jsl rlGetLocationEventDataEntry
            bcs +

              jsl rlUnsetCastleGuarded

        +
        lda wChapterFlags,b
        bit #$0010
        beq _B916

        lda wBattleType
        and #$00FF
        cmp #1
        bne _B916

          jsl rlGetSelectedUnitCurrentHP
          cmp #0
          beq +

            jml _BRK

          +
          jsl rlActionStructHandleArenaDefeat
          jml _End

        _B916
        lda #UnitStateCanto
        jsl rlUnsetSelectedUnitStates

        lda #0
        jsl rlSetSelectedUnitCantoMovement

        lda #SkillIDEscape
        jsl rlCheckIfUnitHasSpecifiedPersonalOrClassSkill
        bcs _Escape

          lda #SkillIDPoW
          jsl rlCheckIfUnitHasSpecifiedPersonalOrClassSkill
          bcc _Regular

            lda wCurrentChapter,b
            cmp #11
            beq _Regular

              jsl rlActionStructSetUnitDefeatedPoW
              bra +

          _Regular
          jsl rlActionStructSetUnitDeath
          bra +

          _Escape
          jsl rlActionStructSetUnitDefeatedEscape
        
        +
        jsl rlGetSelectedUnitCharacterID
        jsl rlGetDeathQuote

        lda #1
        jsl rlSetBattleDeathQuotes

        jsl rlGetSelectedUnitFactionSlot
        ora #0
        bne _B981

          stz lR18

          lda wCurrentChapter,b
          cmp #6
          bcc +

            lda #24
            sta lR18

          +
          jsl rlGetSelectedUnitGenerationID
          dec a
          clc
          adc lR18
          jsl rlRecordUnitLoss

        _B981
        lda #$18
        sta bEventActionIdentifier,b
        jsl rlGetSelectedUnitCharacterID
        sta wEventEngineArgument1,b
        lda wR10
        sta wEventEngineArgument2,b
        jsl rlGetAndRunChapterMapEventConditions

        _End
        pla
        sta lR18+1
        pla
        sta lR18
        ply
        plx
        plp
        plb
        rtl

        _BRK
        brk

        .databank 0

        ; 84/B9A3

    .endsection UnitDeathSection


    .section UnitCastleSection

      .al
      .xl

      rlSetUnitResidingInCastle ; 84/CCB4

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = castle ID
        ; X = deployment offset

        phy
        ldy wRoutineVariable1,b
        phy

        tay
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        tya

        jsl rlSetUnitUnfieldedInCastle

        lda aDeploymentTable._StateBuffer,x
        and #~DeploymentStateAlive
        ora #DeploymentStateHidden
        sta aDeploymentTable._StateBuffer,x
        sta aDeploymentTable._State,x
        tya

        jsl rlGetLocationEventDataEntry
        jsl rlGetEventLocationEntryEffectiveXCoordinate
        and #$00FF
        sta wRoutineVariable1,b

        jsl rlGetEventLocationEntryEffectiveYCoordinate
        and #$00FF
        xba
        ora wRoutineVariable1,b
        sta wRoutineVariable1,b

        ; Effective event coord in wRoutineVariable1

        lda aDeploymentTable._XTilePosition,x
        sta wSavedDeploymentXTile
        lda aDeploymentTable._YTilePosition,x
        sta wSavedDeploymentYTile

        lda wRoutineVariable1,b
        and #$00FF
        sta aDeploymentTable._XTilePosition,x
        asl a
        asl a
        asl a
        asl a
        sta aDeploymentTable._XPixelPosition,x

        lda wRoutineVariable1+1,b
        and #$00FF
        sta aDeploymentTable._YTilePosition,x
        asl a
        asl a
        asl a
        asl a
        sta aDeploymentTable._YPixelPosition,x

        lda wEventLocationEntry,b
        sta wTargetEventLocationEntry,b

        ply
        sty wRoutineVariable1,b
        ply
        rtl

        .databank 0

        ; 84/CD35

    .endsection UnitCastleSection


    .section FieldedUnitFactionSection

      .al
      .xl

      rlChangeFactionSlotOfFieldedSelectedUnit ; 84/D271

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = FactionSlot
        ; X = deployment offset

        phb
        php
        phk
        plb
        phy

        ldy wRoutineVariable1,b
        phy

        sta wRoutineVariable1,b

        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b

        jsl rlChangeFactionSlotOfSelectedUnit

        lda wRoutineVariable1,b
        sta aDeploymentTable._FactionSlot,x

        lda aDeploymentTable._StateBuffer,x
        and #~DeploymentAllegianceMask
        sta aDeploymentTable._StateBuffer,x

        phx
        lda #0
        ldx wRoutineVariable1,b
        jsl rlGetFactionRelation
        plx

        ora aDeploymentTable._StateBuffer,x
        sta aDeploymentTable._StateBuffer,x
        sta aDeploymentTable._State,x

        ply
        sty wRoutineVariable1,b

        ply
        plp
        plb
        rtl

        .databank 0

        ; 84/D2BA

    .endsection FieldedUnitFactionSection


    .section CheckCharacterWaitingInHomeCastleSection

      .al
      .xl

      rlCheckCharacterWaitingInHomeCastle ; 87/A040

        .al
        .autsiz
        .databank ?

        ; A = character ID: carry set if that unit exists, is alive and not on the map, is a player unit, and its home castle is the player's castle.

        ; Check if selected unit alive in home castle.

        phx
        ldx wSelectedUnitDataRAMPointer,b
        phx
        ldx wRoutineVariable1,b
        phx

        jsl rlGetUnitRAMDataPointerByID
        bcs _CLC

          jsl rlGetSelectedUnitStates
          bit #(UnitStateFielded | UnitStateDead)
          bne _CLC

            jsl rlGetSelectedUnitFactionSlot
            ora #FS_Player
            bne _CLC

              lda #0
              jsl rlGetFactionSlotLocationID
              sta wRoutineVariable1,b

              jsl rlGetSelectedUnitHomeCastle
              cmp wRoutineVariable1,b
              bne _CLC

                sec
                bra +

        _CLC
        clc

        +
        pla
        sta wRoutineVariable1,b
        pla
        sta wSelectedUnitDataRAMPointer,b
        plx
        rtl

        .databank 0

        ; 87/A082

    .endsection CheckCharacterWaitingInHomeCastleSection


    .section RepairSelectedUnitItemSection

      .al
      .xl

      rlRepairSelectedUnitItem ; 84/B349

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Repairs the item in inventory slot wRoutineVariable1 for rlGetItemRepairCost (half with Bargain). If the unit cannot pay for all of it, buys as many uses as its money pays for at rlGetItemRepairCostPerUse. Carry set and A = 1 if it cannot pay for one use.

        phb
        php
        phk
        plb
        .databank $84
        lda wRoutineVariable1,b
        jsl rlGetItemROMDataByInventorySlot
        jsl rlGetItemRepairCost
        sta wRoutineVariable1,b
        jsr rsCheckSelectedUnitHasBargain
        bcc _B363
        lsr wRoutineVariable1,b

        _B363
        jsl rlGetSelectedUnitMoney
        cmp wRoutineVariable1,b
        bcc _B37A
        jsl rlSubtractSelectedCharacterMoney
        jsl rlGetItemMaxDurability2
        jsl rlSetItemRAMStructEntryDurability
        bra _B3AE


        _B37A
        jsl rlGetItemRepairCostPerUse
        sta wRoutineVariable1,b
        jsr rsCheckSelectedUnitHasBargain
        bcc _B389
        lsr wRoutineVariable1,b

        _B389
        jsl rlGetSelectedUnitMoney
        cmp wRoutineVariable1,b
        bcc _B3BB
        sta wR13
        lda wRoutineVariable1,b
        sta wR14
        jsl rlUnsignedDivide16By16R13
        jsl rlGetItemCurrentDurability
        clc
        adc wR13
        jsl rlSetItemRAMStructEntryDurability
        lda wR10
        jsl rlSetSelectedUnitMoney

        _B3AE
        jsl rlSaveEquippedWeaponStatBonus
        plp
        plb
        .databank $84
        clc

        _B3B5
        rtl

        lda #$0000
        bra _B3BE


        _B3BB
        lda #$0001

        _B3BE
        plp
        plb
        .databank $84
        sec
        bra _B3B5

        .databank 0

        ; 84/B3C3

      rsCheckSelectedUnitHasBargain ; 84/B3C3

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Carry set if the unit, its class or an item it holds has Bargain (as rlCheckUnitHasBargain), keeping the current item pointers.

        lda wCurrentItemDataROMPointer,b
        pha
        lda wCurrentItemDataRAMPointer,b
        pha
        lda #SkillIDBargain
        jsl rlCheckIfUnitHasSpecifiedPersonalOrClassSkill
        bcs _B3DB
        lda #SkillIDBargain
        jsl rlCheckIfInventoryItemsHaveSpecifiedSkill

        _B3DB
        pla
        sta wCurrentItemDataRAMPointer,b
        pla
        sta wCurrentItemDataROMPointer,b
        rts

        .databank 0

        ; 84/B3E4

    .endsection RepairSelectedUnitItemSection


