; Creating a generation 2 child from their parents: base stats, growths, holy blood,
; and which items and weapon ranks they inherit.

    .section InheritanceSection

      .al
      .xl

      rlFillChildExtendedPersonalData ; 87/A6E6

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        phy
        lda wR0
        pha
        lda wR1
        pha
        lda wR3
        pha

        jsl rlGetSelectedUnitGender
        sta wR3

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
        lda $830000+structDynamicCharacterROMEntry.Class,x
        sta structExtendedCharacterDataRAM.Class,b,y
        lda $830000+structDynamicCharacterROMEntry.Level,x
        sta structExtendedCharacterDataRAM.Level,b,y
        lda #0
        sta structExtendedCharacterDataRAM.LeadershipStars,b,y
        sta structExtendedCharacterDataRAM.Experience,b,y
        rep #$20

        ; So... FE4 just autopromotes player units on spawn 
        ; if they are above the needed class promo level... why?
        jsl rlGetPromotedClassIfAvailable

        lda $7E2000
        beq +

          lda $7E2000+2
          jsl rlSetSelectedUnitClass

        +
        lda aUnit1DataBuffer._Extended.Money
        clc
        adc aUnit2DataBuffer._Extended.Money
        sta wR12

        ; divide total money by 10
        lda #0
        adc #0
        sta wR13
        lda #10
        sta wR14
        stz wR15
        jsl rlUnsignedDivide32By32

        lda wR12
        clc
        adc #2000
        sta structExtendedCharacterDataRAM.Money,b,y

        jsl rlGetSelectedUnitLevel
        sta wR0
        jsl rlGetSelectedUnitTotalHPGrowth
        jsr rsGetAverageStatsForLevel
        clc
        adc #15
        sta aChildAverageLevelStats.HP

        jsl rlGetSelectedUnitTotalStrGrowth
        jsr rsGetAverageStatsForLevel
        sta aChildAverageLevelStats.Strength

        jsl rlGetSelectedUnitTotalMagGrowth
        jsr rsGetAverageStatsForLevel
        sta aChildAverageLevelStats.Magic

        jsl rlGetSelectedUnitTotalSklGrowth
        jsr rsGetAverageStatsForLevel
        sta aChildAverageLevelStats.Skill

        jsl rlGetSelectedUnitTotalSpdGrowth
        jsr rsGetAverageStatsForLevel
        sta aChildAverageLevelStats.Speed

        jsl rlGetSelectedUnitTotalDefGrowth
        jsr rsGetAverageStatsForLevel
        sta aChildAverageLevelStats.Defense

        jsl rlGetSelectedUnitTotalResGrowth
        jsr rsGetAverageStatsForLevel
        sta aChildAverageLevelStats.Resistance

        jsl rlGetSelectedUnitTotalLuckGrowth
        jsr rsGetAverageStatsForLevel
        sta aChildAverageLevelStats.Luck

        phy
        ldx #0

        -
        lda aUnit1DataBuffer._Extended.HP,x
        sta wR0
        lda aUnit2DataBuffer._Extended.HP,x
        sta wR1
        lda aChildAverageLevelStats.HP,x
        sta wR2
        jsr rsGetChildAdjustedBaseStat

        sep #$20
        sta structExtendedCharacterDataRAM.HP,b,y
        rep #$20
        inc x
        inc x
        inc y
        cpx #size(aChildAverageLevelStats)
        bcc -

        ; Add a random amount of 1-10 luck to a child
        ply
        lda #9 +1
        jsl rlGetRandomNumber100
        inc a
        clc
        adc structExtendedCharacterDataRAM.Luck,b,y
        sta structExtendedCharacterDataRAM.Luck,b,y

        pla
        sta wR3
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

      rsGetAverageStatsForLevel ; 87/A80A

        .al
        .autsiz
        .databank ?

        stz wR12
        cmp #101
        bcc +

          sec
          sbc #100
          sta wR12

          lda #100

        +
        jsl rlConvertChanceToFullByte
        sta wR10

        lda wR12
        beq +

          jsl rlConvertChanceToFullByte
          clc
          adc wR10
          sta wR10

        +
        lda wR0
        dec a
        xba
        sta wR11
        jsl rlUnsignedMultiply16By16
        lda wR13
        rts

        .databank 0

      rsGetChildAdjustedBaseStat ; 87/A83A

        .al
        .autsiz
        .databank ?

        ; wR3 = gender

        phb
        php
        phk
        plb
        lda wR3
        beq _Male

        asl wR0
        bra +
        
        _Male
        asl wR1
        
        +
        lda wR0
        clc
        adc wR1
        sta WRDIVA,b
        sep #$20
        lda #10
        sta WRDIVB,b
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        rep #$20
        lda RDDIV,b
        clc
        adc wR2
        plp
        plb
        rts

        .databank 0

      rlFillChildsConstantData ; 87/A869

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        phy

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

        phy

        ldx wSelectedUnitDataRAMPointer,b

        sep #$20
        lda $7E0000+structCharacterDataRAM.ConstantData+2,x
        pha
        rep #$20
        plb

        lda $7E0000+structCharacterDataRAM.ConstantData,x
        tay

        plx
        phx
        phy
        lda #structDynamicCharacterROMEntry.Equipment2-structDynamicCharacterROMEntry.CharacterID
        sta wR2

        sep #$20

        -
        lda $830000+structDynamicCharacterROMEntry.CharacterID,x
        sta structCharacterConstantData.CharacterID,b,y
        inc x
        inc y
        dec wR2
        bne -

        rep #$20
        ply
        lda aUnit2DataBuffer._ROM.CharacterID
        sep #$20
        sta structCharacterConstantData.FatherID,b,y
        rep #$20
        phy
        lda structCharacterConstantData.Gender,b,y
        and #$00FF
        sta wR2

        ldx #structCharacterROMDataBuffer.HPGrowth

        -
        lda aUnit1DataBuffer._ROM.HPGrowth - structCharacterROMDataBuffer.HPGrowth,x
        sta wR0
        lda aUnit2DataBuffer._ROM.HPGrowth - structCharacterROMDataBuffer.HPGrowth,x
        sta wR1
        jsr rsGetChildGrowthRate

        sep #$20
        sta structCharacterConstantData.HPGrowth,b,y
        rep #$20
        inc x
        inc x
        inc y
        cpx #size(structCharacterConstantData.Growths)*2 + structCharacterROMDataBuffer.HPGrowth
        bcc -

        ply
        lda structCharacterConstantData.CharacterID,b,y
        sec
        sbc #Seliph
        sta wR3

        asl a
        clc
        adc wR3
        tax
        lda aUnit1DataBuffer._ROM.Skills1
        ora aUnit2DataBuffer._ROM.Skills1
        and aValidInheritableSkills,x
        sta structCharacterConstantData.Skills1,b,y

        lda aUnit1DataBuffer._ROM.Skills2
        ora aUnit2DataBuffer._ROM.Skills2
        and aValidInheritableSkills+1,x
        sta structCharacterConstantData.Skills2,b,y

        plx
        lda $830000+structDynamicCharacterROMEntry.MajorInfluence,x
        and #$00FF
        beq +

        ; Father influence

        lda aUnit1DataBuffer._ROM.HolyBlood1
        sta wR0
        lda aUnit2DataBuffer._ROM.HolyBlood1
        sta wR1
        jsr rsGetChildHolyBlood
        sta structCharacterConstantData.HolyBlood1,b,y

        lda aUnit1DataBuffer._ROM.HolyBlood2
        sta wR0
        lda aUnit2DataBuffer._ROM.HolyBlood2
        sta wR1
        jsr rsGetChildHolyBlood
        sta structCharacterConstantData.HolyBlood2,b,y
        bra ++

        ; Mother influence
        +
        lda aUnit2DataBuffer._ROM.HolyBlood1
        sta wR0
        lda aUnit1DataBuffer._ROM.HolyBlood1
        sta wR1
        jsr rsGetChildHolyBlood
        sta structCharacterConstantData.HolyBlood1,b,y

        lda aUnit2DataBuffer._ROM.HolyBlood2
        sta wR0
        lda aUnit1DataBuffer._ROM.HolyBlood2
        sta wR1
        jsr rsGetChildHolyBlood
        sta structCharacterConstantData.HolyBlood2,b,y

        +
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

        ply
        plx
        plp
        plb
        rtl

        .databank 0

      aValidInheritableSkills .binclude "../../data/character/ValidInheritableSkills.asm"  ; 87/A975

      rsGetChildGrowthRate ; 87/A9EA

        .al
        .autsiz
        .databank ?

        ; In: 
        ; wR0 = mother growth
        ; wR1 = father growth
        ; wR2 = gender

        ; if male: double father growth, add mother and halve the total
        ; if female: double mother growth, add father and halve the total

        lda wR2
        beq +

        asl wR0
        bra ++
        
        +
        asl wR1
        
        +
        lda wR0
        clc
        adc wR1
        lsr a
        rts

        .databank 0

      rsGetChildHolyBlood ; 87/A9FB

        .al
        .autsiz
        .databank ?

        ; wR0 = minor blood influence
        ; wR1 = major blood influence

        lda wR0
        clc
        adc #$5555
        lsr a
        and #$5555
        sta wR0

        stz wR2
        stz wR3
        stz wR4

        ldx #8

        -
        lsr wR0
        ror wR2
        lsr wR0
        ror wR2
        lsr wR1
        ror wR3
        lsr wR1
        ror wR3
        lsr wR4
        lsr wR4

        lda wR2
        clc
        adc wR3
        bcc +

          lda #$8000

        +
        and #$C000
        ora wR4
        sta wR4
        dec x
        bne -

        rts

        .databank 0

      rlInheritInventoryToChild ; 87/AA39

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        phy
        jsr rsInheritParentInventory
        jsl rlGetSelectedUnitInventorySize
        sta wR3

        lda #1
        jsl rlGetItemROMDataByInventorySlot

        lda wCurrentItemDataROMPointer,b
        beq +

          jsl rlGetItemMight

        +
        sta wR4

        ldx wSelectedUnitDataRAMPointer,b

        -
        lda wR2
        sta wSelectedUnitDataRAMPointer,b
        lda #1
        jsl rlGetPlayerItemIndexByInventorySlot
        bcs +

          tay
          lda #1
          jsl rlRemoveItemInSpecifiedInventorySlot
          tya
          jsl rlGetItemRAMStructEntryByPlayerItemIndex
          jsl rlGetEffectiveItemROMPointerByItemRAMStructEntry
          stx wSelectedUnitDataRAMPointer,b
          jsr rsTryInheritItemToChild
          bra -
        
        +
        stx wSelectedUnitDataRAMPointer,b
        ldy #1

        ; Also inherit all the items that are in the supply
        -
        lda #(`aItemRAMData)<<8
        sta lStructPointer2+1,b
        lda #<>aItemRAMData
        sta lStructPointer2,b
        sty wStructIndex,b
        jsl rlGetRAMStructEntryPointerByStructIndex
        bcs _End

          lda lStructPointer1,b
          sta wCurrentItemDataRAMPointer,b
          jsl rlGetEffectiveItemROMPointerByItemRAMStructEntry
          jsl rlGetItemRAMStateAndOwner

          lda wR1
          cmp wR2
          bne +

            lda wR0
            cmp #ItemStateSupply
            bne +

              jsr rsTryInheritItemToChild

          +
          inc y
          bra -

        _End
        jsl rlEquipFirstWeaponInInventory
        ply
        plx
        plp
        plb
        rtl

        .databank 0

      rsInheritParentInventory ; 87/AAC9

        .al
        .autsiz
        .databank ?

        ; wR2 = major influence parent ram pointer

        phx
        phy
        ldx wSelectedUnitDataRAMPointer,b
        lda wR2
        sta wSelectedUnitDataRAMPointer,b
        ldy #1

        -
        tya
        jsl rlGetItemROMDataByInventorySlot

        lda wCurrentItemDataROMPointer,b
        beq _InventoryDone

          jsr rsCheckForInheritableWeaponRank
          bcc +

            ; is a holy weapon
            tya
            jsl rlRemoveItemInSpecifiedInventorySlot
            jsl rlGetItemRAMStateAndOwner
            cpx wR1
            beq +

              jsl rlRevertItemAcquirement
              bra -

          +
          inc y
          bra -


        _InventoryDone
        ldy #1

          _Loop
          lda wR2
          sta wSelectedUnitDataRAMPointer,b
          tya
          jsl rlGetItemIDByInventorySlot
          bcs _End

          sta wR0
          phy
          stx wSelectedUnitDataRAMPointer,b
          ldy #1

            -
            tya
            jsl rlGetItemIDByInventorySlot
            bcs _AB2C

              cmp wR0
              bne +

                tya
                jsl rlRemoveItemInSpecifiedInventorySlot
                jsl rlRevertItemAcquirement
                bra _AB2C

            +
            inc y
            bra -

          _AB2C
          ply
          inc y
          bra _Loop
        
        _End
        stx wSelectedUnitDataRAMPointer,b
        ply
        plx
        rts

        .databank 0

      rsCheckIfItemObtainableByType ; 87/AB36

        .al
        .autsiz
        .databank ?

        phx
        jsl rlGetItemEquipmentType
        asl a
        tax
        jsr (aItemObtainChecksByType,x)
        plx
        rts

        .databank 0

      aItemObtainChecksByType ; 87/AB42

        .addr rsCheckWeaponOrStaffObtainable
        .addr rsCheckWeaponOrStaffObtainable
        .addr rsCheckRingObtainable
        .addr rsCheckRingObtainable

      rsCheckWeaponOrStaffObtainable ; 87/AB4A

        .al
        .autsiz
        .databank ?

        jsl rlCheckItemObtainable
        rts

        .databank 0

      rsCheckRingObtainable ; 87/AB4F

        .al
        .autsiz
        .databank ?

        sec
        rts

        .databank 0

      rsCheckForInheritableWeaponRank ; 87/AB51

        .al
        .autsiz
        .databank ?

        ; Special holy weapon = 1 and clc
        ; normal weapon = 0 and clc
        ; holy weapon = $FF and sec

        jsl rlGetItemIDByItemRAMStructEntry
        cmp #Forseti
        beq +

        cmp #ValkyrieStaff
        beq +

        cmp #Yewfelle
        beq +

        jsl rlGetItemWeaponRank
        ora #0
        bmi ++

        lda #0
        clc
        
        -
        rts
        
        +
        lda #1
        clc
        bra -
        
        +
        sec
        bra -

        .databank 0

      rsTryInheritItemToChild ; 87/AB7B

        .al
        .autsiz
        .databank ?

        jsr rsCheckForInheritableWeaponRank
        bcs _NotInheritable
        bne +

        jsr rsCheckIfItemObtainableByType
        bcc _NotInheritable

        lda wR3
        cmp #size(structInventoryDataRAM.Slot)-1
        bcs _SendToUnitsSupply

        +
        inc wR3

        jsl rlGetItemMight
        cmp wR4
        bcc +

          sta wR4
          sty wRoutineVariable1,b
          jsl rlGivePlayerItemIDToSelectedUnitsFirstItemSlot
          bra _End

        +
        sty wRoutineVariable1,b
        jsl rlGivePlayerItemIDToSelectedUnit
        bra _End

        _SendToUnitsSupply
        lda #2
        sta wR0
        lda wSelectedUnitDataRAMPointer,b
        sta wR1
        jsl rlSetItemRAMStateAndOwner
        bra _End
        
        _NotInheritable
        jsl rlRevertItemAcquirement
        
        _End
        rts

        .databank 0

    .endsection InheritanceSection
