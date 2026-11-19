; Weapon traits and staff effects applied during battle.

    .section BattleEffectsSection

      .al
      .xl

      rsActionStructWeaponTraitLifeSteal ; 84/EC80

        .al
        .autsiz
        .databank `wActionStructAttacker

        ldx wActionStructAttacker
        ldy wActionStructDefender
        jsr rsUnknown84E51D

        sep #$20
        lda @l bBattleRoundFlags
        ora #$40
        sta @l bBattleRoundFlags
        rep #$20

        jsr rsActionStructRoundCheckIfHit
        bcc +

          jsr rsUnknown84E62C
          lda structActionStructEntry.BattleBonusAtkDef,b,x
          sta wRoutineVariable1,b
          jsr rsActionStructRoundTryProcWrath
          jsr rsActionStructRoundTryProcCrit
          jsr rsActionStructRoundGetDamage
          jsr rsUnknown84E6F6
          lda structActionStructEntry.UnitRAMPointer,b,x
          sta wSelectedUnitDataRAMPointer,b
          jsl rlHealSelectedUnitsHP
        
        +
        clc
        rts

        .databank 0

      rsActionStructStaffEffectRescue ; 84/ECBD

        .al
        .autsiz
        .databank `wActionStructAttacker

        ldx wActionStructAttacker
        ldy wActionStructDefender

        lda #2
        tsb bBattleRoundFlags
        
        jsr rsUnknown84E62C

        lda wUnknown000D79,b
        bit #$0040
        bne _ED3A

        lda structActionStructEntry.UnitRAMPointer,b,x
        sta wSelectedUnitDataRAMPointer,b
        lda structActionStructEntry.XPosition,b,x
        sta @l $7EC490
        lda structActionStructEntry.YPosition,b,x
        sta @l $7EC492
        jsl rlGetSelectedUnitStates
        bit #UnitStateGuardingCastle
        beq +

          inc $C492,b
          inc $C492,b

        +
        lda structActionStructEntry.UnitRAMPointer,b,y
        sta wSelectedUnitDataRAMPointer,b
        jsl $87AF46
        bcc +

          jml _End
        
        +
        lda @l $7EC49C
        xba
        ora @l $7EC49A
        sta wRoutineVariable1,b

        phx
        lda structActionStructEntry.DeploymentNumber,b,y
        tax
        jsl $84C9BF
        plx
        jsr rsUnknown84EDAE

        lda @l $7EC49A
        sta @l $7E4F77
        lda @l $7EC49C
        sta @l $7E4F79
        phb
        phy
        jsl $88C9A6
        ply
        plb
        bra +

        _ED3A
        jsr rsUnknown84EDAE
        lda structActionStructEntry.DeploymentNumber,b,x
        sta wUnknownDeploymentOffset000D7F,b
        lda #9
        sta $0D81,b
        lda #0
        jsl rlGetFactionSlotLocationID
        sta $0D83,b
        jsl rlGetLocationEventDataEntry
        jsl rlGetEventLocationEntryEffectiveXCoordinate
        sta @l $7E4F77
        jsl rlGetEventLocationEntryEffectiveYCoordinate
        sta @l $7E4F79
        
        +
        phx
        lda @l $7E4F79
        xba
        lsr a
        lsr a
        clc
        adc @l $7E4F77
        asl a
        tax

        lda $7F2400,x
        and #$03FF
        tax
        lda $7F2000,x
        and #$00FF
        sta structActionStructEntry.TerrainType,b,y
        plx

        lda structActionStructEntry.UnitRAMPointer,b,x
        sta wSelectedUnitDataRAMPointer,b
        lda structActionStructEntry.WeaponInventorySlot,b,x
        and #$00FF
        jsl $84F99D
        sta structActionStructEntry.GainedExperience,b,x

        sep #$20
        lda #0
        sta @l $7ECCDF
        rep #$20

        lda #$003A
        sta wBattleSong
        clc
        
        _End
        rts

        .databank 0

      rsUnknown84EDAE ; 84/EDAE

        .al
        .autsiz
        .databank ?

        jsl rlGetSelectedUnitStates
        bit #UnitStateGuardingCastle
        beq +

          jsl $84BA6F

        +
        rts

        .databank 0

      rsActionStructStaffEffectThief ; 84/EDBC

        .al
        .autsiz
        .databank `wActionStructAttacker

        ldx wActionStructAttacker
        ldy wActionStructDefender

        lda structActionStructEntry.UnitRAMPointer,b,y
        sta wSelectedUnitDataRAMPointer,b
        jsr rsUnknown84EAD9

        lda structActionStructEntry.UnitRAMPointer,b,x
        sta wSelectedUnitDataRAMPointer,b
        lda structActionStructEntry.WeaponInventorySlot,b,x
        and #$00FF
        jsl $84F99D
        sta structActionStructEntry.GainedExperience,b,x
        
        sep #$20
        lda #0
        sta @l $7ECCDF
        rep #$20

        jsr rsUnknown84EE8F

        clc
        rts

        .databank 0

      rsActionStructStaffEffectValkyrie ; 84/EDED

        .al
        .autsiz
        .databank `wActionStructAttacker

        ldx wActionStructAttacker
        ldy wActionStructDefender

        lda #2
        tsb bBattleRoundFlags

        lda structActionStructEntry.UnitRAMPointer,b,x
        sta wSelectedUnitDataRAMPointer,b
        jsr rsUnknown84E62C

        lda structActionStructEntry.UnitRAMPointer,b,y
        sta wSelectedUnitDataRAMPointer,b
        jsl rlReviveSelectedCharacter

        lda structActionStructEntry.UnitRAMPointer,b,x
        sta wSelectedUnitDataRAMPointer,b
        lda structActionStructEntry.WeaponInventorySlot,b,x
        and #$00FF
        jsl $84F99D
        sta structActionStructEntry.GainedExperience,b,x

        lda structActionStructEntry.MaxHP,b,y
        sep #$20
        sta @l $7ECCDF
        rep #$20

        lda #$003D
        sta wBattleSong
        clc
        rts

        .databank 0

      rsActionStructStaffEffectStatus ; 84/EE32

        .al
        .autsiz
        .databank `wActionStructAttacker

        ldx wActionStructAttacker
        ldy wActionStructDefender

        lda #2
        tsb bBattleRoundFlags

        lda structActionStructEntry.UnitRAMPointer,b,y
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitTotalResistance
        sta wRoutineVariable1,b

        lda structActionStructEntry.UnitRAMPointer,b,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitTotalMagic
        cmp wRoutineVariable1,b
        beq +
        bcs ++
        
        +
        sep #$20
        lda #8
        tsb bBattleRoundFlags
        rep #$20
        bra ++
        
        +
        jsr rsUnknown84E62C
        jsr rsUnknown84EEB1

        lda structActionStructEntry.UnitRAMPointer,b,x
        sta wSelectedUnitDataRAMPointer,b
        lda structActionStructEntry.WeaponInventorySlot,b,x
        and #$00FF
        jsl $84F99D
        sta structActionStructEntry.GainedExperience,b,x
        
        +
        sep #$20
        lda #0
        sta @l $7ECCDF
        rep #$20

        jsr rsUnknown84EE8F

        clc
        rts

        .databank 0

      rsUnknown84EE8F ; 84/EE8F

        .al
        .autsiz
        .databank `aDeploymentTable

        phx
        lda structActionStructEntry.DeploymentNumber,b,x
        tax
        lda aDeploymentTable._State,x
        and #DeploymentAllegianceMask
        cmp #1
        beq +

        cmp #3
        beq +

        lda #$0031
        bra ++
        
        +
        lda #$0032
        
        +
        sta wBattleSong
        plx
        rts

        .databank 0

      rsUnknown84EEB1 ; 84/EEB1

        .al
        .autsiz
        .databank `aDeploymentTable

        lda structActionStructEntry.WeaponID,b,x
        jsl rlGetItemDataROMPointer

        lda structActionStructEntry.UnitRAMPointer,b,y
        sta wSelectedUnitDataRAMPointer,b

        phx
        lda structActionStructEntry.DeploymentNumber,b,y
        tax
        jsl rlGetItemAdditionalInfo
        cmp #StatusSleep
        bne +

          lda aDeploymentTable._StateBuffer,x
          ora #DeploymentStateAsleep
          sta aDeploymentTable._StateBuffer,x
          bra ++

          +
          lda aDeploymentTable._StateBuffer,x
          and #~DeploymentStateAsleep
          sta aDeploymentTable._StateBuffer,x

        +
        lda #$0004
        tsb wUnknown000D79,b
        plx

        jsl rlGetItemAdditionalInfo
        jsl rlSetSelectedUnitStatus

        lda #2 +1
        jsl rlGetRandomNumber100
        clc
        adc #4
        jsl rlSetSelectedUnitStatusDuration
        rts

        .databank 0

      rsActionStructCheckForSolHealing ; 84/EEFF

        .al
        .autsiz
        .databank ?

        lda wBattleActivatedSkill
        cmp #SkillIDSol
        bne +

          lda structActionStructEntry.UnitRAMPointer,b,x
          sta wSelectedUnitDataRAMPointer,b
          jsl rlHealSelectedUnitsHP

        +
        rts

        .databank 0

      rsUnknown84EF13 ; 84/EF13

        .al
        .autsiz
        .databank ?

        phx
        jsl rlUnknown87EB24
        jsl rlGetEventLocationEntryID
        sta $0D83,b
        lda $0000,b,y
        sta wUnknownDeploymentOffset000D7F,b

        lda #2
        sta $0D81,b
        plx
        rts

        .databank 0

      rsActionstructGetLevelUpAndDroppedItemData ; 84/EF2D

        .al
        .autsiz
        .databank ?

        lda structActionStructEntry.UnitRAMPointer,b,x
        beq _End

        sta wSelectedUnitDataRAMPointer,b
        lda #SkillIDParagon
        jsl rlCheckIfUnitHasSpecifiedPersonalOrClassSkill
        bcs +

        lda #SkillIDParagon
        jsl rlCheckIfInventoryItemsHaveSpecifiedSkill
        bcc ++
        
        +
        asl structActionStructEntry.GainedExperience,b,x

        +
        lda structActionStructEntry.GainedExperience,b,x
        bmi +

        cmp #101
        bmi ++

        lda #100
        bra ++
        
        +
        lda #0
        
        +
        sta wRoutineVariable1,b

        txa
        clc
        adc #structActionStructEntry.LevelUpData
        sta lRoutineVariable,b

        jsl rlActionStructLevelUp
        bcs +

          sta structActionStructEntry.GainedLevels,b,x
          lda wRoutineVariable1,b
          sta structActionStructEntry.GainedExperience,b,x
          bra ++
          
          +
          lda #0
          sta structActionStructEntry.GainedExperience,b,x
          sta structActionStructEntry.GainedLevels,b,x

        +
        lda structActionStructEntry.ObtainedItem,b,x
        bmi _End

          sta wRoutineVariable1,b
          jsl rlGiveItemToUnitCheckEncumbered

          lda structActionStructEntry.ObtainedItem,b,x
          jsl rlGetItemRAMStructEntryByPlayerItemIndex
          jsl rlGetEffectiveItemIDByItemRAMStructEntry
          sta structActionStructEntry.ObtainedItem,b,x

        _End
        rts

        .databank 0

      rlRollForChance ; 84/EF9C

        .al
        .autsiz
        .databank ?

        pha
        jsl rlGetRandomNumber
        cmp #1,s
        pla
        rtl

        .databank 0

      rlUnknown84EFA5 ; 84/EFA5

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #$7E
        pha
        rep #$20
        plb

        lda $7E4EAA
        bit #$0010
        beq _EFCF

        lda $7E4EAA
        bit #$0020
        bne +

        ldx #$4EB5
        bra ++
        
        +
        ldx #$4F15
        
        +
        lda $0008,b,x
        
        -
        plp
        plb
        rtl
        
        _EFCF
        lda #0
        bra -

        .databank 0

      rlGetSelectedUnitInventoryRAMPointer ; 84/EFD4

        .al
        .autsiz
        .databank ?

        ldx wSelectedUnitDataRAMPointer,b
        sep #$20
        lda $7E0000+structCharacterDataRAM.InventoryData+2,x
        pha
        rep #$20
        plb
        lda $7E0000+structCharacterDataRAM.InventoryData,x
        tax
        rtl

        .databank 0

      rlSaveCharacterInventoryToBuffer ; 84/EFE7

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        phy
        lda lR18
        pha
        lda lR18+1
        pha
        lda wR0
        pha

        lda lRAMBufferPointer+1,b
        sta lR18+1
        lda lRAMBufferPointer,b
        sta lR18

        jsl rlGetSelectedUnitInventoryRAMPointer

        ldy #structInventoryDataBuffer.EquippedWeaponBitfield
        lda structInventoryDataRAM.EquippedWeaponBitfield,b,x
        and #$00FF
        sta [lR18],y

        ldy #structInventoryDataBuffer.ItemCount
        lda structInventoryDataRAM.CurrentStructCount,b,x
        and #$00FF
        sta [lR18],y
        sta wR0
        beq _End

          ldy #structInventoryDataBuffer.Items

            -
            lda structInventoryDataRAM.Slot,b,x
            and #$00FF
            sta [lR18],y
            inc x
            inc y
            inc y
            dec wR0
            bne -

        _End
        pla
        sta wR0
        pla
        sta lR18+1
        pla
        sta lR18
        ply
        plx
        plp
        plb
        rtl

        .databank 0

      rlLoadEquipmentDataIntoSpecifiedInventory ; 84/F03E

        .al
        .autsiz
        .databank ?

        ; A = character rom pointer + equip offset

        phb
        php

        phk
        plb

        phx
        phy

        ldx wR0
        phx
        ldx wR1
        phx
        ldx wRoutineVariable1,b
        phx

        tay

        ldx wSelectedUnitDataRAMPointer,b
        lda $7E0000+structCharacterDataRAM.InventoryData+1,x
        sta lStructPointer2+1,b
        sta lR18+1
        lda $7E0000+structCharacterDataRAM.InventoryData,x
        clc
        adc #structInventoryDataRAM.CurrentStructCount
        sta lStructPointer2,b
        sta lR18
        lda #size(structInventoryDataRAM.Slot)
        sta wR0
        lda #1
        sta wR1
        jsl rlBuildRAMStructHeader

        ldx #size(structCharacterEquipmentROMEntry)

        lda #0
        sta wRoutineVariable1,b
        jsl rlSetSelectedUnitEquippedWeaponBitfield

        sep #$20
        lda #`aCharacterData
        pha
        rep #$20
        plb

        ; Get equipment data
        -
        lda structCharacterEquipmentROMEntry.Equipment1,b,y
        and #$00FF
        cmp #$00FF
        beq +

          sta wRoutineVariable1,b
          jsl rlGiveItemToUnit

        +
        inc y
        dec x
        bne -

        jsl rlGetUnitType
        cmp #UnitTypeDynamic
        beq _End

          ; Handle unique equipment
          lda $0000,b,y
          and #$00FF
          cmp #$00FF
          beq _End

            jsl rlCheckForValidUniqueItemOrDrops
            ora #0
            bne _End

            ; Nobody has it yet.
            jsl rlGetUnitType
            ora #UnitTypeStatic
            bne +
            bcs _End

              lda $0000,b,y
              and #$00FF
              sta wRoutineVariable1,b

            +
            jsl rlGiveItemToUnit

        _End
        jsl rlEquipFirstWeaponInInventory

        pla
        sta wRoutineVariable1,b
        pla
        sta wR1
        pla
        sta wR0

        ply
        plx
        plp
        plb
        rtl

        .databank 0

      rlGiveItemToUnit ; 84/F0E9

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx

        jsl rlGetUnitType
        asl a
        tax
        jsr (aUnitTypeItemGivingPointers,x)

        plx
        plp
        plb
        rtl

        .databank 0

      aUnitTypeItemGivingPointers ; 84/F0FB

        .addr rsGivePlayerItemIDToSelectedUnit
        .addr rsGivePlayerItemIDToSelectedUnit
        .addr rsGiveItemToSelectedEnemyUnit
        .addr rsGiveItemToSelectedEnemyUnit

      rsGivePlayerItemIDToSelectedUnit ; 84/F103

        .al
        .autsiz
        .databank ?

        jsl rlGivePlayerItemIDToSelectedUnit
        rts

        .databank 0

      rsUnknown84F108 ; 84/F108

        .al
        .autsiz
        .databank ?

        lda wRoutineVariable1,b
        jsl rlGetItemRAMStructEntryByPlayerItemIndex
        jsl rlGetEffectiveItemIDByItemRAMStructEntry
        sta lStructPointer1,b
        bra +

      rsGiveItemToSelectedEnemyUnit ; 84/F118

        .al
        .autsiz
        .databank ?

        lda wRoutineVariable1,b
        sta lStructPointer1,b

        +
        ldx wSelectedUnitDataRAMPointer,b
        lda $7E0000+structCharacterDataRAM.InventoryData+1,x
        sta lStructPointer2+1,b
        lda $7E0000+structCharacterDataRAM.InventoryData,x
        clc
        adc #structInventoryDataRAM.CurrentStructCount
        sta lStructPointer2,b

        jsl rlAppendNewStructEntry

        lda wRoutineVariable1,b
        jsl rlGetItemDataROMPointer
        jsr rsAddItemStatBonusIfRingByItemROMPointer
        rts

        .databank 0

      rlGivePlayerItemIDToSelectedUnit ; 84/F142

        .al
        .autsiz
        .databank ?

        ; wRoutineVariable1 = player item ID

        phb
        php
        phk
        plb
        phx

        lda wR0
        pha
        lda wR1
        pha
        lda wRoutineVariable1,b
        pha

        lda wRoutineVariable1,b
        jsl rlGetItemRAMStructEntryByPlayerItemIndex

        lda wRoutineVariable1,b
        sta lStructPointer1,b

        ldx wSelectedUnitDataRAMPointer,b
        lda $7E0000+structCharacterDataRAM.InventoryData+1,x
        sta lStructPointer2+1,b
        lda $7E0000+structCharacterDataRAM.InventoryData,x
        clc
        adc #structInventoryDataRAM.CurrentStructCount
        sta lStructPointer2,b
        jsl rlAppendNewStructEntry
        bcs +

          ; successful
          lda #1 ; item state?
          sta wR0
          lda wSelectedUnitDataRAMPointer,b
          sta wR1
          jsl rlSetItemRAMStateAndOwner
          jsr rsAddItemStatBonusIfRingByItemRAMStructEntry
          jsl rlGetSelectedUnitInventoryRAMPointer

          lda structInventoryDataRAM.EquippedWeaponBitfield,b,x
          and #$00FF
          bne +

            jsl rlEquipFirstWeaponInInventory

        +
        pla
        sta wRoutineVariable1,b
        pla
        sta wR1
        pla
        sta wR0

        plx
        plp
        plb
        rtl

        .databank 0

      rsAddItemStatBonusIfRingByItemRAMStructEntry ; 84/F1A8

        .al
        .autsiz
        .databank ?

        jsl rlGetEffectiveItemROMPointerByItemRAMStructEntry

      rsAddItemStatBonusIfRingByItemROMPointer ; 84/F1AC

        .al
        .autsiz
        .databank ?

        jsl rlGetItemEquipmentType
        cmp #EquipTypeRing
        bne +

          jsl rlGetItemStatBonus
          ora #0
          beq +

            tax
            lda aRingStatBonusTable,x
            jsl rlAddRingStatBonusToSelectedUnit

        +
        rts

        .databank 0

      rsRemoveItemStatBonusIfRing ; 84/F1C8

        .al
        .autsiz
        .databank ?

        jsl rlGetEffectiveItemROMPointerByItemRAMStructEntry
        jsl rlGetItemEquipmentType
        cmp #EquipTypeRing
        bne +

          jsl rlGetItemStatBonus
          ora #0
          beq +

            tax
            lda aRingStatBonusTable,x
            jsl rlRemoveRingStatBonusFromSelectedUnit

        +
        rts

        .databank 0

      aRingStatBonusTable ; 84/F1E8

        .byte $00
        .byte $10
        .byte $40
        .byte $80
        .byte $08
        .byte $04
        .byte $02
        .byte $20

      rlGivePlayerItemIDToSelectedUnitsFirstItemSlot ; 84/F1F0

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx

        lda wR0
        pha
        lda wR1
        pha

        lda wRoutineVariable1,b
        jsl rlGetItemRAMStructEntryByPlayerItemIndex

        lda wRoutineVariable1,b
        sta lStructPointer1,b

        ldx wSelectedUnitDataRAMPointer,b
        lda $7E0000+structCharacterDataRAM.InventoryData+1,x
        sta lStructPointer2+1,b
        lda $7E0000+structCharacterDataRAM.InventoryData,x
        clc
        adc #structInventoryDataRAM.CurrentStructCount
        sta lStructPointer2,b
        jsl rlWriteToFirstStructEntry
        bcs +

          lda #1
          sta wR0
          lda wSelectedUnitDataRAMPointer,b
          sta wR1
          jsl rlSetItemRAMStateAndOwner
          jsr rsAddItemStatBonusIfRingByItemRAMStructEntry

        +
        pla
        sta wR1
        pla
        sta wR0
        plx
        plp
        plb
        rtl

        .databank 0

      rlRemoveItemInSpecifiedInventorySlot ; 84/F23E

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = inv slot

        phb
        phk
        plb
        phx
        ldx wRoutineVariable1,b
        phx

        sta wStructIndex,b
        sta wRoutineVariable1,b

        ldx wSelectedUnitDataRAMPointer,b
        lda $7E0000+structCharacterDataRAM.InventoryData+1,x
        sta lStructPointer2+1,b
        lda $7E0000+structCharacterDataRAM.InventoryData,x
        clc
        adc #structInventoryDataRAM.CurrentStructCount
        sta lStructPointer2,b

        jsl rlLoadRAMStructDataByIndex
        bcs +

        jsl rlRemoveRAMStructEntryByID
        bcs +

        lda lStructPointer1,b
        and #$00FF
        jsl rlGetItemRAMStructEntryByPlayerItemIndex
        jsr rsRemoveItemStatBonusIfRing
        jsr rsUpdateEquippedWeaponBitfieldIfSlotChanged
        clc

        -
        plx
        stx wRoutineVariable1,b
        plx
        plb
        rtl
        
        +
        sec
        bra -

        .databank 0

      rsUpdateEquippedWeaponBitfieldIfSlotChanged ; 84/F288

        .al
        .autsiz
        .databank ?

        ; Input:
        ; wRoutineVariable1 = inventory slot

        phb
        phx
        ldx wRoutineVariable1,b
        dec x
        lda _EquippedWeaponBitfield,x
        and #$00FF
        sta wRoutineVariable1,b

        jsl rlGetSelectedUnitInventoryRAMPointer
        lda structInventoryDataRAM.EquippedWeaponBitfield,b,x
        and #$00FF
        cmp wRoutineVariable1,b
        beq +
        bcs _End

          asl a
          sep #$20
          sta structInventoryDataRAM.EquippedWeaponBitfield,b,x
          rep #$20
          bra _End

        +
        jsl rlEquipFirstWeaponInInventory
        jsl rlSaveEquippedWeaponStatBonus
        
        _End
        plx
        plb
        rts

        .databank 0

        _EquippedWeaponBitfield ; 84/F2BE
        .byte $80 
        .byte $40 
        .byte $20 
        .byte $10 
        .byte $08 
        .byte $04 
        .byte $02 
        .byte $01 

      rlUnknown84F2C6 ; 84/F2C6

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx

        sta lStructPointer1,b
        ldx wSelectedUnitDataRAMPointer,b
        lda $7E000E,x
        sta lStructPointer2+1,b
        lda $7E000D,x
        clc
        adc #1
        sta lStructPointer2,b
        jsl rlFindRAMStructEntry

        plx
        plp
        plb
        rtl

        .databank 0

      rlGetSelectedUnitEquippedWeaponBitfield ; 84/F2EB

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx

        jsl rlGetSelectedUnitInventoryRAMPointer

        lda structInventoryDataRAM.EquippedWeaponBitfield,b,x
        and #$00FF

        plx
        plp
        plb
        rtl

        .databank 0

      rlSetSelectedUnitEquippedWeaponBitfield ; 84/F2FE

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx

        jsl rlGetSelectedUnitInventoryRAMPointer

        sep #$20
        lda wRoutineVariable1
        sta structInventoryDataRAM.EquippedWeaponBitfield,b,x
        rep #$20

        plx
        plp
        plb
        rtl

        .databank 0

      rlGetSelectedUnitInventorySize ; 84/F316

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        ldx wSelectedUnitDataRAMPointer,b
        lda $7E0000+structCharacterDataRAM.InventoryData+1,x
        sta lStructPointer2+1,b
        lda $7E0000+structCharacterDataRAM.InventoryData,x
        clc
        adc #structInventoryDataRAM.CurrentStructCount
        sta lStructPointer2,b
        jsl rlGetRAMStructCurrentStructCount
        plx
        plp
        plb
        rtl

        .databank 0

      rlGetPlayerItemIndexByInventorySlot ; 84/F338

        .al
        .autsiz
        .databank ?

        phb

        phk
        plb

        phx

        ora #0
        beq +

          sta wStructIndex,b

          jsl rlGetUnitType
          cmp #UnitTypeHoly
          bcs +

            ldx wSelectedUnitDataRAMPointer,b
            lda $7E0000+structCharacterDataRAM.InventoryData+1,x
            sta lStructPointer2+1,b
            lda $7E0000+structCharacterDataRAM.InventoryData,x
            clc
            adc #structInventoryDataRAM.CurrentStructCount
            sta lStructPointer2,b
            jsl rlLoadRAMStructDataByIndex
            bcs +

              lda lStructPointer1,b
              and #$00FF
              clc

              -
              plx
              plb
              rtl

        +
        lda #0
        sec
        bra -

        .databank 0

      rlGetItemRAMStructEntryByInventorySlot ; 84/F378

        .al
        .autsiz
        .databank ?

        phb

        phk
        plb

        stz wCurrentItemDataRAMPointer,b

        jsl rlGetPlayerItemIndexByInventorySlot
        bcs +

          jsl rlGetItemRAMStructEntryByPlayerItemIndex
          clc
        
        +
        plb
        rtl

        .databank 0

      rlGetItemIDByInventorySlot ; 84/F38B

        .al
        .autsiz
        .databank ?

        phb

        phk
        plb

        sta $0585,b

        jsl rlGetUnitType
        cmp #UnitTypeHoly
        bcs +

        lda $0585,b
        jsl rlGetItemRAMStructEntryByInventorySlot
        bcs _End

        jsl rlGetEffectiveItemIDByItemRAMStructEntry

        _End
        plb
        rtl

        +
        stz wCurrentItemDataRAMPointer,b
        lda $0585,b
        jsl rlGetEnemyItemIndexByInventorySlot
        bra _End

        .databank 0

      rlGetItemROMDataByInventorySlot ; 84/F3B5

        .al
        .autsiz
        .databank ?

        ; In:
        ; A = inventory slot, 1 indexed

        ; Returns the item ROM pointer in A and wCurrentItemDataRAMPointer

        phb
        php

        phk
        plb

        sta $0585,b

        jsl rlGetUnitType
        cmp #UnitTypeHoly
        bcs _NotPlayer

        lda $0585,b
        jsl rlGetItemRAMStructEntryByInventorySlot
        bcs +

          jsl rlGetEffectiveItemROMPointerByItemRAMStructEntry

          -
          plp
          plb
          rtl

        +
        stz wCurrentItemDataROMPointer,b
        bra -

        _NotPlayer
        stz wCurrentItemDataRAMPointer,b
        lda $0585,b
        jsl rlGetEnemyItemDataByInventorySlot
        bra -
  
      rlGetEnemyItemIndexByInventorySlot ; 84/F3E6

        .al
        .autsiz
        .databank ?
        
        phb

        phk
        plb

        phx
        sta wStructIndex,b

        ldx wSelectedUnitDataRAMPointer,b
        lda $7E0000+structCharacterDataRAM.InventoryData+1,x
        sta lStructPointer2+1,b
        lda $7E0000+structCharacterDataRAM.InventoryData,x
        clc
        adc #structInventoryDataRAM.CurrentStructCount
        sta lStructPointer2,b
        jsl rlLoadRAMStructDataByIndex
        bcs _End

          lda lStructPointer1,b
          and #$00FF
          cmp #$00FF
          beq +

            clc
        
        _End
        plx
        plb
        rtl

        +
        sec
        bra _End

        .databank 0

      rlGetEnemyItemDataByInventorySlot ; 84/F41A

        .al
        .autsiz
        .databank ?

        jsl rlGetEnemyItemIndexByInventorySlot
        bcs +

          jsl rlGetItemDataROMPointer

          -
          rtl

        +
        stz wCurrentItemDataROMPointer,b
        bra -

        .databank 0

      rlCheckIfWeaponEquipped ; 84/F42A

        .al
        .autsiz
        .databank `aEquippedWeaponBitfield

        phb

        phk
        plb

        phx
        phy

        ldx wR0
        phx

        dec a
        tay
        lda aEquippedWeaponBitfield,y
        and #$00FF
        sta wR0

        jsl rlGetSelectedUnitInventoryRAMPointer

        lda structInventoryDataRAM.EquippedWeaponBitfield,b,x
        and #$00FF
        bit wR0
        beq +

        sec

        -
        plx
        stx wR0
        ply
        plx
        plb
        rtl
        
        +
        clc
        bra -

        .databank 0

      aEquippedWeaponBitfield ; 84/F455

        .byte $80
        .byte $40
        .byte $20
        .byte $10
        .byte $08
        .byte $04
        .byte $02
        .byte $01

      rlFlagEquippedInventorySlotAndGetStatBonus ; 84/F45D

        .al
        .autsiz
        .databank ?

        ; A = inventory slot

        phb
        phk
        plb
        phx
        phy

        tay
        jsl rlCheckWeaponInInventorySlotEquippable
        bcc _SEC

        lda #0
        sta wRoutineVariable1,b
        jsl rlSetSelectedUnitEquippedWeaponBitfield

        jsl rlGetSelectedUnitInventoryRAMPointer

        sep #$20
        lda #$80
        
        -
        dec y
        beq +

        lsr a
        bra -

        +
        ora structInventoryDataRAM.EquippedWeaponBitfield,b,x
        sta structInventoryDataRAM.EquippedWeaponBitfield,b,x
        rep #$20

        jsl rlSaveEquippedWeaponStatBonus

        clc

        -
        ply
        plx
        plb
        rtl
        
        _SEC
        sec
        bra -

        .databank 0

      rlGetItemDurabilityOfInventorySlot ; 84/F495

        .al
        .autsiz
        .databank ?

        jsl rlGetItemRAMStructEntryByInventorySlot
        bcs +

        jsl rlGetItemCurrentDurability
        
        -
        rtl

        +
        lda #$FFFF
        bra -

        .databank 0

      rlGetFirstEquippableWeaponInInventory ; 84/F4A5

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
        lda wRoutineVariable2,b
        pha

        stz wCurrentItemDataROMPointer,b

        jsl rlGetSelectedUnitInventorySize
        inc a
        sta wRoutineVariable2,b
        jsl rlGetSelectedUnitInventoryRAMPointer

        lda $0000,b,x
        xba
        sta wRoutineVariable1,b

        ldx #1

        -
        asl wRoutineVariable1,b
        bcc +

          ; slot is filled
          txa
          jsl rlGetItemROMDataByInventorySlot
          jsl rlGetItemEquipmentType
          cmp #EquipTypeWeapon
          beq ++

            stz wCurrentItemDataROMPointer,b

        +
        inc x
        cpx wRoutineVariable2,b
        bcc -

        ldx #0

        +
        pla
        sta wRoutineVariable2,b
        pla
        sta wRoutineVariable1,b
        txa
        plx
        plp
        plb
        rtl

        .databank 0

      rlUnknown84F4F7 ; 84/F4F7

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        lda wSelectedInventorySlot,b
        jsl rlGetItemROMDataByInventorySlot

        lda wCurrentItemDataROMPointer,b
        beq +

          jsl rlGetItemMinimumRange
          sta wR10
          jsl rlGetItemMaximumRange
          sta wR11
          jsl rlGetSelectedUnitStates
          bit #UnitState0400
          beq +

            inc wR11

        +
        plp
        plb
        rtl

        .databank 0

      rlGetInventoryWeaponsRangeFlags ; 84/F521

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        lda wR10
        pha
        lda wR2
        pha

        stz wR10
        stz wR2
        ldx #1

        _Loop
        txa
        jsl rlGetItemROMDataByInventorySlot

        lda wCurrentItemDataROMPointer,b
        beq _End

          jsl rlCheckItemObtainable
          bcc _Next

            jsl rlGetItemEquipmentType
            cmp #EquipTypeRing
            bcs _Next

              cmp #EquipTypeStaff
              beq +

                jsl rlCheckWeaponEquippable
                bcc _Next

                  jsl rlGetItemMinimumRange
                  jsr rsGetWeaponRangeFlags
                  tsb wR10
                  jsl rlGetItemMaximumRange
                  jsr rsGetWeaponRangeFlags
                  tsb wR10
                  bra _Next

              +
              jsl rlGetSelectedUnitStatus
              cmp #StatusSilence
              beq _Next

                jsl rlGetItemStaffEffect
                cmp #$000C
                bcc _Next

                  ; everything but silence, sleep, berserk and thief
                  jsl rlGetItemMinimumRange
                  jsr rsGetWeaponRangeFlags
                  tsb wR2
                  jsl rlGetItemMaximumRange
                  jsr rsGetWeaponRangeFlags
                  tsb wR2

          _Next
          inc x
          cpx #7+1+1
          bcc _Loop

        _End
        lda wR10
        ldy wR2

        plx
        stx wR2
        plx
        stx wR10
        plx
        plp
        plb
        rtl

        .databank 0

      rsGetWeaponRangeFlags ; 84/F5A3

        .al
        .autsiz
        .databank `aWeaponRangeFlags

        asl a
        tay
        lda aWeaponRangeFlags,y
        rts

        .databank 0

      aWeaponRangeFlags ; 84/F5A9

        .word $0000
        .word $0001
        .word $0002
        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $0004

      rlGetCounterableWeaponSlot ; 84/F5BF

        .al
        .autsiz
        .databank ?

        ; In:
        ; A = range

        ; Out:
        ; X = inv slot

        phb
        php
        phk
        plb
        phx
        ldx wRoutineVariable1,b
        phx

        sta wRoutineVariable1,b
        ldx #1
        
        -
        txa
        jsl rlGetItemROMDataByInventorySlot

        lda wCurrentItemDataROMPointer,b
        beq _Next

          jsl rlGetItemEquipmentType
          cmp #EquipTypeWeapon
          bne _Next

            jsl rlGetItemMinimumRange
            dec a
            cmp wRoutineVariable1,b
            bcs _Next

              jsl rlGetItemMaximumRange
              cmp wRoutineVariable1,b
              bcs +

                stz wCurrentItemDataROMPointer,b

        _Next
        inc x
        cpx #size(structInventoryDataRAM.Slot)+1
        bcc -

        jsl rlGetFirstEquippableWeaponInInventory
        bra ++
        
        +
        txa
        
        +
        plx
        stx wRoutineVariable1,b
        plx
        plp
        plb
        rtl

        .databank 0

      rlCheckWeaponEquippable ; 84/F60C

        .al
        .autsiz
        .databank ?

        phb
        phk
        plb
        phx

        lda wCurrentItemDataROMPointer,b
        beq _CLC

        jsl rlGetItemEquipmentType
        cmp #EquipTypeWeapon
        bne _CLC

        jsl rlGetItemWeaponTraits
        cmp #WeaponTraitFemaleOnly
        bne +

          jsl rlGetSelectedUnitGender
          cmp #GenderFemale
          bne _CLC

        +
        jsl rlGetItemWeaponType
        tax
        cmp #WeaponTypeStaff
        bcc +

          ; Is magical weapon
          jsl rlGetItemMaxDurability2
          ora #0
          beq _CLC

          jsl rlGetSelectedUnitStatus
          cmp #StatusSilence
          beq _CLC

        +
        txa
        jsl rlGetSelectedUnitWeaponRank
        cmp #WeaponRankNone
        bcs _CLC

        sta wRoutineVariable1,b
        jsl rlGetItemWeaponRank
        ora #0
        bmi _HolyWeapon

        cmp wRoutineVariable1,b
        bmi _CLC

        ; Equippable
        sec
        
        -
        plx
        plb
        rtl
        
        _CLC
        clc
        bra -

        _HolyWeapon
        sep #$20
        lda #`aItemData
        pha
        rep #$20
        plb

        jsl rlGetItemMaxDurability1
        ora #0
        beq _SEC

        ldx #(size(aHolyBloodGrowthBoostsOffsets)/2)-1

        -
        txa
        jsl rlUnknown84A69F
        ora #0
        beq +

          jsr rsGetItemDataROMPointer
          cmp wCurrentItemDataROMPointer,b
          bne +

            txa
            jsl rlCheckForSpecifiedHolyBlood
            cmp #MajorHolyBlood
            bcs _SEC
        
        +
        dec x
        bpl -

        clc
        bra +
        
        _SEC
        sec
        
        +
        plx
        plb
        rtl

        .databank 0

      rsGetItemDataROMPointer ; 84/F6A8

        .al
        .autsiz
        .databank ?

        phx
        asl a
        clc
        adc aMainDataOffsets.ItemDataOffsets
        tax
        lda aMainDataOffsets,x
        clc
        adc aMainDataOffsets.ItemDataOffsets
        adc #<>aMainDataOffsets
        plx
        rts

        .databank 0

      rlCheckStaffEquippable ; 84/F6BE

        .al
        .autsiz
        .databank ?

        phb
        phk
        plb
        phx

        lda wCurrentItemDataROMPointer,b
        beq _CLC

          jsl rlGetSelectedUnitStatus
          cmp #StatusSilence
          beq _CLC

            jsl rlGetItemEquipmentType
            cmp #EquipTypeStaff
            bne _CLC

              jsl rlGetItemMaxDurability2
              ora #0
              beq _CLC

                lda #WeaponTypeStaff
                jsl rlGetSelectedUnitWeaponRank
                cmp #WeaponRankNone
                bcs _CLC

                  sta wRoutineVariable1,b
                  jsl rlGetItemWeaponRank
                  ora #0
                  bpl +

                    jml rlCheckWeaponEquippable._HolyWeapon

                  +
                  cmp wRoutineVariable1,b
                  bmi _CLC

                    sec

                    -
                    plx
                    plb
                    rtl

        _CLC
        clc
        bra -

        .databank 0

      rlCheckItemObtainable ; 84/F70A

        .al
        .autsiz
        .databank ?

        phb
        phk
        plb
        phx
        lda wCurrentItemDataROMPointer,b
        beq _CLC

        jsl rlGetItemEquipmentType
        cmp #EquipTypeRing
        bcs _SEC

        cmp #EquipTypeWeapon
        bne +

        jsl rlGetItemWeaponTraits
        cmp #WeaponTraitFemaleOnly
        bne +
        
        jsl rlGetSelectedUnitGender
        cmp #GenderFemale
        bne _CLC

        +
        jsl rlGetItemWeaponType
        jsl rlGetSelectedUnitWeaponRank
        sta wRoutineVariable1,b

        jsl rlGetItemWeaponRank
        ora #0
        bmi _SEC

        cmp wRoutineVariable1,b
        bmi _CLC

        _SEC
        sec

        -
        plx
        plb
        rtl

        _CLC
        clc
        bra -

        .databank 0

      rlCheckWeaponInInventorySlotEquippable ; 84/F753

        .al
        .autsiz
        .databank ?

        ; sec if true

        jsl rlGetItemROMDataByInventorySlot
        jsl rlCheckWeaponEquippable
        rtl

        .databank 0

        ; 84/F75C

    .endsection BattleEffectsSection
