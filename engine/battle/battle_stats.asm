; Equipping weapons, unique equipment and drops, and the battle stats (might, hit,
; avoid, crit, attack speed, defense, resistance) of units and enemies.

    .section BattleStatsSection

      .al
      .xl

      rlEquipFirstWeaponInInventory ; 84/F939

        .al
        .autsiz
        .databank ?

        phb
        phk
        plb
        phy
        lda wCurrentItemDataROMPointer,b
        pha
        lda wCurrentItemDataRAMPointer,b
        pha

        lda #0
        sta wRoutineVariable1,b
        jsl rlSetSelectedUnitEquippedWeaponBitfield

        ldy #1

        -
        tya
        jsl rlFlagEquippedInventorySlotAndGetStatBonus
        bcc +

        inc y
        cpy #size(structInventoryDataRAM.Slot)+1
        bcc -

        sec
        
        -
        pla
        sta wCurrentItemDataRAMPointer,b
        pla
        sta wCurrentItemDataROMPointer,b
        ply
        plb
        rtl
        
        +
        clc
        bra -

        .databank 0

      rlUnknown84F96E ; 84/F96E

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb

        lda wRoutineVariable1,b
        jsl rlGetItemRAMStructEntryByInventorySlot
        bcs +

        jsl rlUnknown87E230
        
        -
        plp
        plb
        rtl
        
        +
        lda #0
        bra -

        .databank 0

      rlUnknown84F987 ; 84/F987

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb

        jsl rlGetItemRAMStructEntryByInventorySlot
        bcs +

        jsl rlUnknown87E25D
        
        -
        plp
        plb
        rtl

        +
        lda #0
        bra -

        .databank 0

      rlUnknown84F99D ; 84/F99D

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        ldx wRoutineVariable1,b
        phx

        cmp #0
        beq _F9E3

        jsl rlGetItemRAMStructEntryByInventorySlot
        jsl rlGetItemROMPointerByItemRAMStructEntry
        jsl rlUnknown87E3D6 ; get item cost
        sta $1A
        jsl rlGetItemMaxDurability2
        sta $1C
        jsl rlUnknown80A1AB ; divide
        lda #20
        sta $1C
        jsl rlUnknown80A1AB

        lda $1A
        clc
        adc #10
        bmi +

        cmp #101
        bmi _End

        lda #100
        bra _End
        
        +
        lda #0
        bra _End
        
        _F9E3
        lda #10
        
        _End
        plx
        stx wRoutineVariable1,b
        plx
        plp
        plb
        rtl

        .databank 0

      rlUnknown84F9EE ; 84/F9EE

        .al
        .autsiz
        .databank ?

        jsr rsAddItemStatBonusIfRingByItemRAMStructEntry
        rtl

        .databank 0

      rlSaveEquippedWeaponStatBonus ; 84/F9F2

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        lda wCurrentItemDataROMPointer,b
        pha
        lda wCurrentItemDataRAMPointer,b
        pha

        jsl rlGetFirstEquippableWeaponInInventory

        lda wCurrentItemDataROMPointer,b
        beq +

        jsl rlGetItemStatBonus
        jsl rlSetActiveWeaponStatBonus
        
        -
        pla
        sta wCurrentItemDataRAMPointer,b
        pla
        sta wCurrentItemDataROMPointer,b
        plp
        plb
        rtl

        +
        lda #0
        jsl rlSetActiveWeaponStatBonus
        bra -

        .databank 0 

      rlGetUniqueEquipmentOrDrops ; 84/FA23

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phy

        jsl rlGetSelectedUnitFactionSlot
        ora #0
        beq _FA5D

        jsl rlGetSelectedUnitCharacterID
        jsl rlSwapToMainDataBank
        jsl rlGetCharacterDataROMPointer
        tay
        lda structCharacterROMEntry.Type,b,y
        and #$00FF
        cmp #UnitTypeEnemy
        beq +

        cmp #UnitTypeDynamic
        beq _FA5D

        lda structStaticCharacterROMEntry.UniqueEquipment,b,y
        bra _End

        +
        lda structEnemyCharacterROMEntry.Drops,b,y

        _End
        and #$00FF
        ply
        plp
        plb
        rtl

        _FA5D
        lda #$00FF
        bra _End

        .databank 0

      rlCheckForValidUniqueItemOrDrops ; 84/FA62

        .al
        .autsiz
        .databank ?

        phb
        phk
        plb
        phx
        phy
        ldx wR0
        phx
        ldx wR1
        phx

        ldx #0
        jsl rlGetUniqueEquipmentOrDrops
        cmp #$00FF
        beq _FAB1

        jsl rlGetItemRAMStructEntryByPlayerItemIndex
        jsl rlGetEffectiveItemIDByItemRAMStructEntry
        sta wRoutineVariable1,b

        ldy wCurrentItemDataRAMPointer,b
        ldx #1

        -
        txa
        jsl rlGetItemIDByInventorySlot
        bcs +

        ; Inventory slot is filled
        cmp wRoutineVariable1,b
        beq ++

        inc x
        bra -

        +
        ldx #0

        +
        sty wCurrentItemDataRAMPointer,b
        jsl rlGetItemRAMStateAndOwner

        lda wR1
        cmp wSelectedUnitDataRAMPointer,b
        beq _FAB1

        lda wR0
        cmp #ItemStateUnobtained
        bne +

        _FAB1
        txa     
        clc

        -
        plx
        stx wR1
        plx
        stx wR0
        ply
        plx
        plb
        rtl

        +
        txa
        sec
        bra -

        .databank 0

      rlUnknown84FAC1 ; 84/FAC1

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        lda #$000F
        jsl rlCheckIfUnitHasSpecifiedPersonalOrClassSkill
        bcs +

        lda #$000F
        jsl rlCheckIfInventoryItemsHaveSpecifiedSkill
        bcc _FAFA
        
        +
        jsl rlGetSelectedUnitCurrentHP
        cmp #$000B
        bcs _FAFA

        eor #$FFFF
        inc a
        clc
        adc #$000B
        sta $4C

        lda #$000A
        sta $4E
        jsl rlUnsignedMultiply16By16High
        lda $50
        
        -
        plx
        plp
        plb
        rtl
        
        _FAFA
        lda #0
        bra -

        .databank 0

      rlGetWeaponTriangleBonus ; 84/FAFF

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = weapon type of defender in high byte, attacker in low byte

        phb
        php
        phk
        plb
        phx
        pha
        xba
        and #$00FF
        asl a
        tax
        lda aWeaponDisadvantageOffsets,x
        tax

        pla
        and #$00FF
        sta wRoutineVariable1,b

        -
        lda aWeaponDisadvantageOffsets,x
        and #$00FF
        cmp #$00FF
        beq +

        cmp wRoutineVariable1,b
        beq ++

        inc x
        bra -

        +
        lda #0

        -
        plx
        plp
        plb
        rtl

        +
        lda #20
        bra -

        .databank 0

      aWeaponDisadvantageOffsets ; 84/FB37

        .word <>aSwordWeaponDisdvantage   - aWeaponDisadvantageOffsets
        .word <>aLanceWeaponDisdvantage   - aWeaponDisadvantageOffsets
        .word <>aAxeWeaponDisdvantage     - aWeaponDisadvantageOffsets
        .word <>aBowWeaponDisdvantage     - aWeaponDisadvantageOffsets
        .word <>aStaffWeaponDisdvantage   - aWeaponDisadvantageOffsets
        .word <>aFireWeaponDisdvantage    - aWeaponDisadvantageOffsets
        .word <>aThunderWeaponDisdvantage - aWeaponDisadvantageOffsets
        .word <>aWindWeaponDisdvantage    - aWeaponDisadvantageOffsets
        .word <>aLightWeaponDisdvantage   - aWeaponDisadvantageOffsets
        .word <>aDarkWeaponDisdvantage    - aWeaponDisadvantageOffsets

      aSwordWeaponDisdvantage   .char WeaponTypeLance, -1
      aLanceWeaponDisdvantage   .char WeaponTypeAxe, -1
      aAxeWeaponDisdvantage     .char WeaponTypeSword, -1
      aBowWeaponDisdvantage     .char -1
      aStaffWeaponDisdvantage   .char -1
      aFireWeaponDisdvantage    .char WeaponTypeThunder, WeaponTypeLight, WeaponTypeDark, -1
      aThunderWeaponDisdvantage .char WeaponTypeWind, WeaponTypeLight, WeaponTypeDark, -1
      aWindWeaponDisdvantage    .char WeaponTypeFire, WeaponTypeLight, WeaponTypeDark, -1
      aLightWeaponDisdvantage   .char -1
      aDarkWeaponDisdvantage    .char -1

      rsGetEnemyTotalSpecifiedStat ; 84/FB61

        .al
        .autsiz
        .databank ?

        phx
        lda wR36
        pha
        lda wR37
        pha
        lda wR35
        pha

        lda wR34
        sta wR34
        jsl rlGetEnemyUnitConstantDataPointer
        lda $0006,b,x
        and #$00FF
        sta wR35
        jsl rlUnsignedMultiply16By16High
        lda #100
        sta wR37
        jsl rlUnsignedDivide16By16

        pla
        sta wR35

        lda wR36
        clc
        adc wR35

        plx
        stx wR37
        plx 
        stx wR36
        plx
        rts

        .databank 0

      rlGetEnemyMaxHP ; 84/FB98

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        lda wR34
        pha
        lda wR35
        pha

        jsl rlGetEnemyClassHPGrowth
        sta wR34

        jsl rlGetSelectedUnitClassDataPointer
        jsl rlGetClassBaseHP
        sta wR35

        jsr rsGetEnemyTotalSpecifiedStat

        plx
        stx wR35
        plx
        stx wR34
        plx
        plp
        plb
        rtl

        .databank 0

      rlGetEnemyStrength ; 84/FBC0

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        lda wR34
        pha
        lda wR35
        pha

        jsl rlGetEnemyClassStrGrowth
        sta wR34
        jsl rlGetSelectedUnitClassDataPointer
        jsl rlGetClassStrength
        sta wR35
        jsr rsGetEnemyTotalSpecifiedStat

        plx
        stx wR35
        plx
        stx wR34
        plx
        plp
        plb
        rtl

        .databank 0

      rlGetEnemyMagic ; 84/FBE8

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        lda wR34
        pha
        lda wR35
        pha

        jsl rlGetEnemyClassMagGrowth
        sta wR34
        jsl rlGetSelectedUnitClassDataPointer
        jsl rlGetClassMagic
        sta wR35
        jsr rsGetEnemyTotalSpecifiedStat

        plx
        stx wR35
        plx
        stx wR34
        plx
        plp
        plb
        rtl

        .databank 0

      rlGetEnemySkill ; 84/FC10

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        lda wR34
        pha
        lda wR35
        pha

        jsl rlGetEnemyClassSklGrowth
        sta wR34
        jsl rlGetSelectedUnitClassDataPointer
        jsl rlGetClassSkill
        sta wR35
        jsr rsGetEnemyTotalSpecifiedStat

        plx
        stx wR35
        plx
        stx wR34
        plx
        plp
        plb
        rtl

        .databank 0

      rlGetEnemySpeed ; 84/FC38

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        lda wR34
        pha
        lda wR35
        pha

        jsl rlGetEnemyClassSpdGrowth
        sta wR34
        jsl rlGetSelectedUnitClassDataPointer
        jsl rlGetClassSpeed
        sta wR35
        jsr rsGetEnemyTotalSpecifiedStat

        plx
        stx wR35
        plx
        stx wR34
        plx
        plp
        plb
        rtl

        .databank 0

      rlGetEnemyDefense ; 84/FC60

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        lda wR34
        pha
        lda wR35
        pha

        jsl rlGetEnemyClassDefGrowth
        sta wR34
        jsl rlGetSelectedUnitClassDataPointer
        jsl rlGetClassDefense
        sta wR35
        jsr rsGetEnemyTotalSpecifiedStat

        plx
        stx wR35
        plx
        stx wR34
        plx
        plp
        plb
        rtl

        .databank 0

      rlGetEnemyResistance ; 84/FC88

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        lda wR34
        pha
        lda wR35
        pha

        jsl rlGetEnemyClassResGrowth
        sta wR34
        jsl rlGetSelectedUnitClassDataPointer
        jsl rlGetClassResistance
        sta wR35
        jsr rsGetEnemyTotalSpecifiedStat

        plx
        stx wR35
        plx
        stx wR34
        plx
        plp
        plb
        rtl

        .databank 0

      rlGetSelectedUnitBattleMight ; 84/FCB0

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        lda wCurrentItemDataROMPointer,b
        beq _End

        jsl rlGetItemEquipmentType
        cmp #EquipTypeWeapon
        bne _NoWeapon

        jsl rlGetItemMight
        sta wRoutineVariable1,b

        jsl rlGetActiveWeaponStatBonus
        pha

        jsl rlGetItemStatBonus
        jsl rlSetActiveWeaponStatBonus
        jsl rlGetItemWeaponType
        cmp #WeaponTypeFire
        bcs _MagicWeapon

        jsl rlGetSelectedUnitTotalStrength
        bra +

        _MagicWeapon
        jsl rlGetSelectedUnitTotalMagic
        
        +
        clc
        adc wRoutineVariable1,b
        sta wRoutineVariable1,b

        pla
        jsl rlSetActiveWeaponStatBonus

        lda wRoutineVariable1,b
        
        _End
        plp
        plb
        rtl
        
        _NoWeapon
        lda #0
        bra _End

        .databank 0

      rlGetSelectedUnitBattleHit ; 84/FD00

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        lda wCurrentItemDataROMPointer,b
        beq _End

        jsl rlGetItemEquipmentType
        cmp #EquipTypeWeapon
        bne _FD47

        jsl rlGetActiveWeaponStatBonus
        pha

        jsl rlGetItemStatBonus
        jsl rlSetActiveWeaponStatBonus
        jsl rlGetItemAccuracy
        sta wRoutineVariable1,b

        jsl rlGetSelectedUnitTotalSkill
        asl a
        clc
        adc wRoutineVariable1,b
        cmp #0
        bmi +
        bra ++

        +
        lda #0

        +
        sta wRoutineVariable1,b

        pla
        jsl rlSetActiveWeaponStatBonus
        lda wRoutineVariable1,b
        
        _End
        plp
        plb
        rtl
        
        _FD47
        lda #$00FF
        bra _End

        .databank 0

      rlGetSelectedUnitBattleAvoid ; 84/FD4C

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx

        sta wRoutineVariable1,b
        ora #0
        bpl +

          stz wRoutineVariable1,b
          bra _FD7B

        +
        jsl rlGetSelectedUnitTerrainAvoidPointer
        clc
        adc wRoutineVariable1,b
        tax
        lda $830000,x
        bit #$0080
        bne +

        and #$007F
        bra ++

        +
        ora #$FF80

        +
        sta wRoutineVariable1,b

        _FD7B
        jsl rlGetSelectedUnitLuck
        ora #0
        bmi +

          clc
          adc wRoutineVariable1,b
          sta wRoutineVariable1,b

        +
        jsl rlGetSelectedUnitBattleAttackSpeed
        asl a
        clc
        adc wRoutineVariable1,b

        plx
        plp
        plb
        rtl

        .databank 0

      rlGetSelectedUnitBattleCrit ; 84/FD98

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        lda wCurrentItemDataROMPointer,b
        beq _End

        jsl rlGetUnitType
        cmp #UnitTypeHoly
        bcs +

          jsl rlGetItemRAMKillCountAndCritAbility
          bcc +

            sec
            sbc #50
            sta wRoutineVariable1,b
            bra _FDD4

        +
        stz wRoutineVariable1,b
        lda #SkillIDCritical
        jsl rlCheckIfUnitHasSpecifiedPersonalOrClassSkill
        bcs _FDD4

        jsl rlGetItemSkills
        bit #ItemSkillCritical
        bne _FDD4

        jsl rlUnknown87E513
        beq _End

        _FDD4
        jsl rlGetActiveWeaponStatBonus
        pha

        jsl rlGetItemStatBonus
        jsl rlSetActiveWeaponStatBonus
        jsl rlGetSelectedUnitTotalSkill
        clc
        adc wRoutineVariable1,b
        sta wRoutineVariable1,b

        pla
        jsl rlSetActiveWeaponStatBonus
        lda wRoutineVariable1,b
        
        _End
        plp
        plb
        rtl

        _FDF7
        lda #0
        bra _End

        .databank 0

      rlGetSelectedUnitBattleAttackSpeed ; 84/FDFC

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        lda wR35
        pha

        lda wCurrentItemDataROMPointer,b
        beq +

          jsl rlGetItemWeight

        +
        sta wR35

        jsl rlGetActiveWeaponStatBonus
        pha

        jsl rlGetItemStatBonus
        jsl rlSetActiveWeaponStatBonus
        jsl rlGetSelectedUnitTotalSpeed
        sec
        sbc wR35
        sta wR35

        pla
        jsl rlSetActiveWeaponStatBonus
        lda wR35

        plx
        stx wR35
        plx
        plp
        plb
        rtl

        .databank 0

      rlGetSelectedUnitBattleDefense ; 84/FE33

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        lda wCurrentItemDataROMPointer,b
        bne +

        jsl rlGetSelectedUnitTotalDefense
        bra ++
        
        +
        jsl rlGetActiveWeaponStatBonus
        pha

        jsl rlGetItemStatBonus
        jsl rlSetActiveWeaponStatBonus
        jsl rlGetSelectedUnitTotalDefense
        sta wRoutineVariable1,b

        pla
        jsl rlSetActiveWeaponStatBonus

        lda wRoutineVariable1,b
        
        +
        plp
        plb
        rtl

        .databank 0

      rlGetSelectedUnitBattleResistance ; 84/FE61

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        lda wCurrentItemDataROMPointer,b
        bne +

        jsl rlGetSelectedUnitTotalResistance
        bra ++
        
        +
        jsl rlGetActiveWeaponStatBonus
        pha

        jsl rlGetItemStatBonus
        jsl rlSetActiveWeaponStatBonus
        jsl rlGetSelectedUnitTotalResistance
        sta wRoutineVariable1,b

        pla
        jsl rlSetActiveWeaponStatBonus

        lda wRoutineVariable1,b

        +
        plp
        plb
        rtl

        .databank 0

      rlGetFirstWeaponBattleMight ; 84/FE8F

        .al
        .autsiz
        .databank ?

        jsl rlGetFirstEquippableWeaponInInventory
        jsl rlGetSelectedUnitBattleMight
        rtl

        .databank 0

        ; 84/FE98

    .endsection BattleStatsSection
