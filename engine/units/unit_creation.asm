; Creating units: filling a new unit's RAM data from its character and class data,
; loading a unit, and clearing a unit's RAM data.

    .section UnitCreationSection

      .al
      .xl

      rsCreateStaticUnitRAMData ; 84/8F17

        .al
        .autsiz
        .databank ?

        phx
        lda #(`aStaticUnitRAMArea)<<8
        sta lR18+1
        lda #<>aStaticUnitRAMArea
        sta lR18
        jsl rlLoadRAMAreaPointer

        ldx wSelectedUnitDataRAMPointer,b
        sep #$20
        lda #UnitTypeStatic
        sta $7E0000+structCharacterDataRAM.Type,x
        rep #$20

        lda #size(structPersonalCharacterDataRAM) + size(structExtendedCharacterDataRAM)
        jsl rlAllocateRAMArea

        lda lR25+1
        sta $7E0000+structCharacterDataRAM.PersonalData+1,x
        lda lR25
        clc
        adc #0
        sta $7E0000+structCharacterDataRAM.PersonalData,x

        lda lR25+1
        sta $7E0000+structCharacterDataRAM.ExtendedPersonalData+1,x
        lda lR25
        clc
        adc #size(structPersonalCharacterDataRAM)
        sta $7E0000+structCharacterDataRAM.ExtendedPersonalData,x

        lda #>`aCharacterDataOffsets
        sta $7E0000+structCharacterDataRAM.ConstantData+1,x

        tya
        clc
        adc #structStaticCharacterROMEntry.CharacterID
        sta $7E0000+structCharacterDataRAM.ConstantData,x

        lda #0
        sta $7E0000+structCharacterDataRAM.EnemyROMData+1,x
        sta $7E0000+structCharacterDataRAM.EnemyROMData,x

        jsr rsFillUnitRAMExtendedPersonalData
        jsr rsFillUnitRAMPersonalData
        jsr rsFillUnitRAMInventoryData
        jsr rsInitUnitLoverData
        plx
        rts

        .databank 0

      rsCreateDynamicUnitRAMData ; 84/8F83

        .al
        .autsiz
        .databank ?

        ; wR0 = father ram pointer
        ; wR1 = mother ram pointer

        phx
        ldx wSelectedUnitDataRAMPointer,b

        lda wR1
        sta wSelectedUnitDataRAMPointer,b
        lda #(`aUnit1DataBuffer._Extended)<<8
        sta lRAMBufferPointer+1,b
        lda #<>aUnit1DataBuffer._Extended
        sta lRAMBufferPointer,b
        jsl rlSaveExtendedCharacterDataToBuffer

        lda #(`aUnit1DataBuffer._ROM)<<8
        sta lRAMBufferPointer+1,b
        lda #<>aUnit1DataBuffer._ROM
        sta lRAMBufferPointer,b
        jsl rlSaveCharacterROMDataToBuffer

        lda wR0
        sta wSelectedUnitDataRAMPointer,b
        lda #(`aUnit2DataBuffer._Extended)<<8
        sta lRAMBufferPointer+1,b
        lda #<>aUnit2DataBuffer._Extended
        sta lRAMBufferPointer,b
        jsl rlSaveExtendedCharacterDataToBuffer

        lda #(`aUnit2DataBuffer._ROM)<<8
        sta lRAMBufferPointer+1,b
        lda #<>aUnit2DataBuffer._ROM
        sta lRAMBufferPointer,b
        jsl rlSaveCharacterROMDataToBuffer

        stx wSelectedUnitDataRAMPointer,b

        lda wR1
        pha
        lda wR0
        pha

        lda #(`aDynamicUnitRAMArea)<<8
        sta lR18+1
        lda #<>aDynamicUnitRAMArea
        sta lR18
        jsl rlLoadRAMAreaPointer

        sep #$20
        lda #UnitTypeDynamic
        sta $7E0000+structCharacterDataRAM.Type,x
        rep #$20

        lda #size(structPersonalCharacterDataRAM) + size(structExtendedCharacterDataRAM) + size(structCharacterConstantData)
        jsl rlAllocateRAMArea

        lda lR25+1
        sta $7E0000+structCharacterDataRAM.PersonalData+1,x
        lda lR25
        clc
        adc #0
        sta $7E0000+structCharacterDataRAM.PersonalData,x

        lda lR25+1
        sta $7E0000+structCharacterDataRAM.ExtendedPersonalData+1,x
        lda lR25
        clc
        adc #size(structPersonalCharacterDataRAM)
        sta $7E0000+structCharacterDataRAM.ExtendedPersonalData,x

        lda lR25+1
        sta $7E0000+structCharacterDataRAM.ConstantData+1,x
        lda lR25
        clc
        adc #size(structPersonalCharacterDataRAM) + size(structExtendedCharacterDataRAM)
        sta $7E0000+structCharacterDataRAM.ConstantData,x

        lda #0
        sta $7E0000+structCharacterDataRAM.EnemyROMData+1,x
        sta $7E0000+structCharacterDataRAM.EnemyROMData,x

        jsl rlFillChildsConstantData
        jsl rsFillChildExtendedPersonalData
        jsr rsFillUnitRAMPersonalData
        jsr rsFillUnitRAMInventoryData
        jsr rsInitUnitLoverData

        pla
        sta wR0
        pla
        sta wR1

        lda structDynamicCharacterROMEntry.MajorInfluence,b,y
        and #$00FF
        bne +

          lda wR1
          sta wR2
          bra ++

          +
          lda wR0
          sta wR2

        +
        jsl rlInheritInventoryToChild

        plx
        rts

        .databank 0

      rsCreateHolyUnitRAMData ; 84/9063

        .al
        .autsiz
        .databank ?

        phx
        lda #(`aHolyAndEnemyRAMArea)<<8
        sta lR18+1
        lda #<>aHolyAndEnemyRAMArea
        sta lR18
        jsl rlLoadRAMAreaPointer

        ldx wSelectedUnitDataRAMPointer,b
        sep #$20
        lda #UnitTypeHoly
        sta $7E0000+structCharacterDataRAM.Type,x
        rep #$20

        lda #size(structPersonalCharacterDataRAM)
        jsl rlAllocateRAMArea

        lda lR25+1
        sta $7E0000+structCharacterDataRAM.PersonalData+1,x
        lda lR25
        clc
        adc #0
        sta $7E0000+structCharacterDataRAM.PersonalData,x

        lda #>`aCharacterDataOffsets
        sta $7E0000+structCharacterDataRAM.ExtendedPersonalData+1,x
        tya
        clc
        adc #structStaticCharacterROMEntry.HP
        sta $7E0000+structCharacterDataRAM.ExtendedPersonalData,x

        lda #>`aCharacterDataOffsets
        sta $7E0000+structCharacterDataRAM.ConstantData+1,x
        tya
        clc
        adc #structStaticCharacterROMEntry.CharacterID
        sta $7E0000+structCharacterDataRAM.ConstantData,x

        lda #0
        sta $7E0000+structCharacterDataRAM.EnemyROMData+1,x
        sta $7E0000+structCharacterDataRAM.EnemyROMData,x

        lda #0
        sta $7E0000+structCharacterDataRAM.LoverData+1,x
        sta $7E0000+structCharacterDataRAM.LoverData,x

        jsr rsFillUnitRAMPersonalData
        jsr rsFillUnitRAMInventoryData

        plx
        rts

        .databank 0

      rsCreateEnemyUnitRAMData ; 84/90D4

        .al
        .autsiz
        .databank ?

        phx
        lda wRoutineVariable1,b
        pha

        lda #(`aHolyAndEnemyRAMArea)<<8
        sta lR18+1
        lda #<>aHolyAndEnemyRAMArea
        sta lR18
        jsl rlLoadRAMAreaPointer

        ldx wSelectedUnitDataRAMPointer,b
        sep #$20
        lda #UnitTypeEnemy
        sta $7E0000+structCharacterDataRAM.Type,x
        rep #$20

        lda #size(structPersonalCharacterDataRAM)
        jsl rlAllocateRAMArea

        lda lR25+1
        sta $7E0000+structCharacterDataRAM.PersonalData+1,x
        lda lR25
        clc
        adc #0
        sta $7E0000+structCharacterDataRAM.PersonalData,x

        lda #0
        sta $7E0000+structCharacterDataRAM.ExtendedPersonalData+1,x
        sta $7E0000+structCharacterDataRAM.ExtendedPersonalData,x

        lda #0
        sta $7E0000+structCharacterDataRAM.ConstantData+1,x
        sta $7E0000+structCharacterDataRAM.ConstantData,x

        lda #>`aCharacterDataOffsets
        sta $7E0000+structCharacterDataRAM.EnemyROMData+1,x
        tya
        clc
        adc #structEnemyCharacterROMEntry.CharacterID
        sta $7E0000+structCharacterDataRAM.EnemyROMData,x

        lda #0
        sta $7E0000+structCharacterDataRAM.LoverData+1,x
        sta $7E0000+structCharacterDataRAM.LoverData,x

        jsr rsFillUnitRAMPersonalData
        jsr rsFillUnitRAMInventoryData

        pla
        sta wRoutineVariable1,b
        plx
        rts

        .databank 0

      rsFillUnitRAMPersonalData ; 84/9148

        .al
        .autsiz
        .databank ?

        phb
        php

        phk
        plb

        phx
        phy
        phy

        ldx wSelectedUnitDataRAMPointer,b
        sep #$20
        lda $7E0000+structCharacterDataRAM.PersonalData+2,x
        pha
        rep #$20
        plb

        lda $7E0000+structCharacterDataRAM.PersonalData,x
        tay
        plx

        lda #0
        sta structPersonalCharacterDataRAM.UnitStates,b,y
        sep #$20
        sta structPersonalCharacterDataRAM.LoverGenerationID,b,y
        sta structPersonalCharacterDataRAM.ResidingCastle,b,y
        sta structPersonalCharacterDataRAM.AI,b,y
        sta structPersonalCharacterDataRAM.CantoMovement,b,y
        sta structPersonalCharacterDataRAM.RingStatBonusBitfield,b,y
        sta structPersonalCharacterDataRAM.WeaponStatBonus,b,y
        sta structPersonalCharacterDataRAM.StatusDuration,b,y
        sta structPersonalCharacterDataRAM.Status,b,y

        lda #Factionless
        sta structPersonalCharacterDataRAM.FactionSlot,b,y
        lda #NoDeploymentOffset
        sta structPersonalCharacterDataRAM.DeploymentOffset,b,y
        rep #$20

        jsl rlGetSelectedUnitLoveDataIDByCharacterID

        sep #$20
        sta structPersonalCharacterDataRAM.LoveDataID,b,y
        rep #$20

        jsl rlGetSelectedUnitMaxHP

        sep #$20
        sta structPersonalCharacterDataRAM.CurrentHP,b,y
        rep #$20

        jsl rlGetSelectedUnitClassDataPointer
        jsl rlGetClassMoney

        sep #$20
        sta structPersonalCharacterDataRAM.ClassMoney,b,y
        rep #$20

        ply
        plx
        plp
        plb
        rts

        .databank 0

      rsFillUnitRAMExtendedPersonalData ; 84/91B8

        .al
        .autsiz
        .databank ?

        phb
        php

        phk
        plb

        phx
        phy

        phy

        ldx wSelectedUnitDataRAMPointer,b

        sep #$20
        lda $7E0000+structCharacterDataRAM.ExtendedPersonalData+2,x
        pha
        rep #$20
        plb

        lda $7E0000+structCharacterDataRAM.ExtendedPersonalData,x
        tay
        plx

        sep #$20
        lda $830000+structStaticCharacterROMEntry.HP,x
        sta structExtendedCharacterDataRAM.HP,b,y
        lda $830000+structStaticCharacterROMEntry.Strength,x
        sta structExtendedCharacterDataRAM.Strength,b,y
        lda $830000+structStaticCharacterROMEntry.Magic,x
        sta structExtendedCharacterDataRAM.Magic,b,y
        lda $830000+structStaticCharacterROMEntry.Skill,x
        sta structExtendedCharacterDataRAM.Skill,b,y
        lda $830000+structStaticCharacterROMEntry.Speed,x
        sta structExtendedCharacterDataRAM.Speed,b,y
        lda $830000+structStaticCharacterROMEntry.Defense,x
        sta structExtendedCharacterDataRAM.Defense,b,y
        lda $830000+structStaticCharacterROMEntry.Resistance,x
        sta structExtendedCharacterDataRAM.Resistance,b,y
        lda $830000+structStaticCharacterROMEntry.Luck,x
        sta structExtendedCharacterDataRAM.Luck,b,y
        lda $830000+structStaticCharacterROMEntry.Class,x
        sta structExtendedCharacterDataRAM.Class,b,y
        lda $830000+structStaticCharacterROMEntry.Level,x
        sta structExtendedCharacterDataRAM.Level,b,y
        lda $830000+structStaticCharacterROMEntry.LeadershipStars,x
        sta structExtendedCharacterDataRAM.LeadershipStars,b,y

        lda #0
        sta structExtendedCharacterDataRAM.TalkTarget,b,y
        sta structExtendedCharacterDataRAM.Experience,b,y
        rep #$20

        lda $830000+structStaticCharacterROMEntry.Money,x
        and #$00FF
        sta wR10

        lda #1000
        sta wR11

        jsl rlUnsignedMultiply16By16

        lda wR12
        sta structExtendedCharacterDataRAM.Money,b,y

        ply
        plx
        plp
        plb
        rts

        .databank 0

      rsFillUnitRAMInventoryData ; 84/9247

        .al
        .autsiz
        .databank ?

        ldx wSelectedUnitDataRAMPointer,b
        lda #(`aInventoryRAMArea)<<8
        sta lR18+1
        lda #<>aInventoryRAMArea
        sta lR18
        jsl rlLoadRAMAreaPointer

        lda #size(structInventoryDataRAM)
        jsl rlAllocateRAMArea

        lda lR25+1
        sta $7E0000+structCharacterDataRAM.InventoryData+1,x
        lda lR25
        sta $7E0000+structCharacterDataRAM.InventoryData,x

        lda $7E0000+structCharacterDataRAM.Type,x
        and #$00FF
        cmp #UnitTypeEnemy
        beq _Enemy

        cmp #UnitTypeDynamic
        beq _Dynamic

        ; static or holy
        tya
        clc
        adc #structStaticCharacterROMEntry.Equipment1
        bra _End

        _Enemy
        tya
        clc
        adc #structEnemyCharacterROMEntry.Equipment1
        bra _End

        _Dynamic
        tya
        clc
        adc #structDynamicCharacterROMEntry.Equipment1
        
        _End
        jsl rlLoadEquipmentDataIntoSpecifiedInventory
        rts

        .databank 0

      rsInitUnitLoverData ; 84/9294

        .al
        .autsiz
        .databank ?

        phy
        lda wR0
        pha
        lda wRoutineVariable1,b
        pha

        jsl rlBuildAlivePlayerCharacterMap
        jsl rlGetSelectedUnitGenerationID
        bcs _9304

        cmp #Deirdre
        bcs +

          lda #0
          sta $7E0000 + structCharacterDataRAM.LoverData+1,x
          sta $7E0000 + structCharacterDataRAM.LoverData,x
          ldx #$002E
          lda #9
          sta wR0
          bra _92EC

        +
        ldx wSelectedUnitDataRAMPointer,b
        lda #(`aLoverRAMArea)<<8
        sta lR18+1
        lda #<>aLoverRAMArea
        sta lR18
        jsl rlLoadRAMAreaPointer

        lda #size(structLoverDataRAM)
        jsl rlAllocateRAMArea

        lda lR25+1
        sta $7E0000 + structCharacterDataRAM.LoverData+1,x
        lda lR25
        sta $7E0000 + structCharacterDataRAM.LoverData,x
        ldx #$001C
        lda #$0010
        sta wR0
        
        _92EC
        lda $7E2000,x
        beq +

          sta wRoutineVariable1
          jsl rlGetUnitLoveBaseWithTarget
          jsl rlSaveUnitLoveValueWithTarget

        +
        dec x
        dec x
        dec wR0
        bne _92EC

        -
        pla
        sta wRoutineVariable1,b
        pla
        sta wR0
        ply
        rts

        _9304
        lda #0
        sta $7E0000 + structCharacterDataRAM.LoverData+1,x
        sta $7E0000 + structCharacterDataRAM.LoverData,x
        bra -

        .databank 0

      rlLoadUnit ; 84/931A

        .al
        .autsiz
        .databank ?

        ; A = CharacterID

        ; for children:
        ; wR0 = father RAM pointer
        ; wR1 = mother RAM pointer

        phb
        php

        phk
        plb

        phx
        phy

        tay

        lda #(`aUnitRAMArea)<<8
        sta lR18+1
        lda #<>aUnitRAMArea
        sta lR18
        jsl rlBufferAndLoadNewRAMAreaPointer

        lda #size(structCharacterDataRAM)
        jsl rlAllocateRAMArea

        lda lR25
        sta wSelectedUnitDataRAMPointer,b

        lda #(`aUnitRAMPointers)<<8
        sta lStructPointer2+1,b
        lda #<>aUnitRAMPointers
        sta lStructPointer2,b

        lda lR25
        sta lStructPointer1,b

        jsl rlAppendNewStructEntry

        tya
        jsl rlCreateUnit

        inc wLoadedUnitCount,b
        jsl rlLoadBufferedRAMAreaPointer

        ply
        plx

        plp
        plb
        rtl

        .databank 0

      rlClearSelectedUnitRAMAreaData ; 84/9361

        .al
        .autsiz
        .databank ?

        ; Clears the selected units item data (if not an enemy),
        ; their personal, inventory, lover data and their unit RAM pointer.

        ; Input:
        ; filled wSelectedUnitDataRAMPointer

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
        lda wR1
        pha

        ldx wSelectedUnitDataRAMPointer,b
        lda $7E0000 + structCharacterDataRAM.Type,x
        and #$00FF
        cmp #UnitTypeHoly
        bcs _ItemsDone

          ; Enemies dont need their items messed with
          ldy #1

          _Loop
          tya

          jsl rlGetItemRAMStructEntryByPlayerItemIndex
          bcs _ItemsDone

          jsl rlGetItemRAMStateAndOwner
          lda wR1
          cmp wSelectedUnitDataRAMPointer,b
          bne _Next

            lda wR0
            cmp #ItemStateInventory
            beq +

              cmp #ItemStateSupply
              bne _Next

            +
            jsl rlRevertItemAquirement

          _Next
          inc y
          bra _Loop

        _ItemsDone
        ldx wSelectedUnitDataRAMPointer,b
        lda $7E0000 + structCharacterDataRAM.Type,x
        and #$00FF
        asl a
        tax
        lda #(`aStaticUnitRAMArea)<<8
        sta lR18+1
        lda aRemoveUnitRAMAreaPointers,x
        sta lR18
        jsl rlBufferAndLoadNewRAMAreaPointer

        ldx wSelectedUnitDataRAMPointer,b
        lda $7E0000 + structCharacterDataRAM.PersonalData+1,x
        sta lR25+1
        lda $7E0000 + structCharacterDataRAM.PersonalData,x
        sta lR25
        jsl rlRemoveRAMAreaEntry

        lda #(`aInventoryRAMArea)<<8
        sta lR18+1
        lda #<>aInventoryRAMArea
        sta lR18
        jsl rlLoadRAMAreaPointer

        lda $7E0000 + structCharacterDataRAM.InventoryData+1,x
        sta lR25+1
        lda $7E0000 + structCharacterDataRAM.InventoryData,x
        sta lR25
        jsl rlRemoveRAMAreaEntry

        lda $7E0000 + structCharacterDataRAM.LoverData+1,x
        ora $7E0000 + structCharacterDataRAM.LoverData,x
        beq +

          lda #(`aLoverRAMArea)<<8
          sta lR18+1
          lda #<>aLoverRAMArea
          sta lR18
          jsl rlLoadRAMAreaPointer

          lda $7E0000 + structCharacterDataRAM.LoverData+1,x
          sta lR25+1
          lda $7E0000 + structCharacterDataRAM.LoverData,x
          sta lR25
          jsl rlRemoveRAMAreaEntry

        +
        ldx wSelectedUnitDataRAMPointer,b
        lda #$FFFF
        sta $7E0000 + structCharacterDataRAM.Type,x

        lda #(`aUnitRAMArea)<<8
        sta lR18+1
        lda #<>aUnitRAMArea
        sta lR18
        jsl rlLoadRAMAreaPointer

        lda #(`aUnitRAMArea)<<8
        sta lR25+1
        lda wSelectedUnitDataRAMPointer,b
        sta lR25
        jsl rlRemoveRAMAreaEntry

        jsl rlLoadBufferedRAMAreaPointer

        pla
        sta wR1
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

      aRemoveUnitRAMAreaPointers ; 84/9459

        .word <>aStaticUnitRAMArea
        .word <>aDynamicUnitRAMArea
        .word <>aHolyAndEnemyRAMArea
        .word <>aHolyAndEnemyRAMArea

    .endsection UnitCreationSection
