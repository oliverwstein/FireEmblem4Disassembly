; Checking which skills a unit has from character, class and items.

    .section SkillsSection

      .al
      .xl

      rlCheckIfUnitHasSpecifiedPersonalOrClassSkill ; 87/A19D

        .al
        .autsiz
        .databank `aValidPersonalSkillTable

        ; A = skill ID

        phb
        php
        phk
        plb
        phx
        ldx wRoutineVariable1,b
        phx

        sta wRoutineVariable1,b

        lda wRoutineVariable1,b
        asl a
        clc
        adc wRoutineVariable1,b
        tax
        jsl rlGetSelectedUnitSkills

        lda lRoutineVariable,b
        bit aValidPersonalSkillTable,x
        bne +

        lda lRoutineVariable+1,b
        bit aValidPersonalSkillTable+1,x
        bne +

        lda wRoutineVariable1,b
        asl a
        tax
        jsl rlGetSelectedUnitClassDataPointer
        jsl rlGetClassSkills
        bit aValidClassSkillTable,x
        bne +

        plx
        stx wRoutineVariable1,b
        plx
        plp
        plb
        clc
        rtl

        +
        plx
        stx wRoutineVariable1,b
        plx
        plp
        plb
        sec
        rtl

        .databank 0

      aValidPersonalSkillTable .block ; 87/A1EA

        .long 0                               ; SkillIDDummy
        .long 0                               ; SkillIDCanto
        .long 0                               ; SkillIDPavise
        .long UnitSkill1Wrath
        .long UnitSkill1Pursuit
        .long UnitSkill1Adept
        .long 0                               ; SkillIDSteal
        .long 0                               ; SkillIDUnknown2
        .long 0                               ; SkillIDDance
        .long 0                               ; SkillIDUnknown3
        .long 0                               ; SkillIDUnknown4
        .long UnitSkill1Dismount
        .long UnitSkill1Charm
        .long UnitSkill1PoW
        .long UnitSkill1Nihil
        .long UnitSkill1Miracle
        .long UnitSkill2Critical << 8
        .long UnitSkill2Vantage  << 8
        .long UnitSkill2Accost   << 8
        .long UnitSkill2Astra    << 8
        .long UnitSkill2Luna     << 8
        .long UnitSkill2Sol      << 8
        .long UnitSkill2Holy     << 8
        .long UnitSkill2Darkness << 8
        .long UnitSkill3Renewal  << 16
        .long UnitSkill3Paragon  << 16
        .long UnitSkill3Escape   << 16
        .long UnitSkill3Recover  << 16
        .long UnitSkill3Bargain  << 16
        .long UnitSkill3Return   << 16

      .bend

      aValidClassSkillTable .block ; 87/A244

        .word 0                       ; SkillIDDummy
        .word ClassSkillCanto
        .word ClassSkillPavise
        .word ClassSkillWrath
        .word ClassSkillPursuit
        .word ClassSkillAdept
        .word ClassSkillSteal
        .word ClassSkillUnknown1      ; SkillIDUnknown2
        .word ClassSkillDance
        .word ClassSkillUnknown2      ; SkillIDUnknown3
        .word ClassSkillUnknown3      ; SkillIDUnknown4
        .word ClassSkillDismount
        .word ClassSkillCharm
        .word 0                       ; SkillIDPoW
        .word 0                       ; SkillIDNihil
        .word 0                       ; SkillIDMiracle
        .word ClassSkillCritical
        .word 0                       ; SkillIDVantage
        .word 0                       ; SkillIDAccost
        .word 0                       ; SkillIDAstra
        .word 0                       ; SkillIDLuna
        .word 0                       ; SkillIDSol
        .word 0                       ; SkillIDHoly
        .word 0                       ; SkillIDDarkness
        .word 0                       ; SkillIDRenewal
        .word 0                       ; SkillIDParagon
        .word 0                       ; SkillIDEscape
        .word 0                       ; SkillIDRecover
        .word 0                       ; SkillIDBargain
        .word 0                       ; SkillIDReturn

      .bend

      aValidItemSkillTable .block; 87/A280

        .word 0                 ; SkillIDDummy
        .word ItemSkillCanto
        .word 0                 ; SkillIDPavise
        .word 0                 ; SkillIDWrath
        .word ItemSkillPursuit
        .word 0                 ; SkillIDAdept
        .word ItemSkillSteal
        .word 0                 ; SkillIDUnknown2
        .word 0                 ; SkillIDDance
        .word 0                 ; SkillIDUnknown3
        .word ItemSkillUnknown1 ; SkillIDUnknown4
        .word 0                 ; SkillIDDismount
        .word 0                 ; SkillIDCharm
        .word 0                 ; SkillIDPoW
        .word 0                 ; SkillIDNihil
        .word ItemSkillMiracle
        .word ItemSkillCritical
        .word 0                 ; SkillIDVantage
        .word 0                 ; SkillIDAccost
        .word 0                 ; SkillIDAstra
        .word 0                 ; SkillIDLuna
        .word 0                 ; SkillIDSol
        .word 0                 ; SkillIDHoly
        .word 0                 ; SkillIDDarkness
        .word ItemSkillRenewal
        .word ItemSkillParagon
        .word ItemSkillEscape
        .word ItemSkillRecover
        .word ItemSkillBargain
        .word ItemSkillReturn

      .bend

      rlCheckIfUnitHasSpecifiedPersonalSkill ; 87/A2BC

        .al
        .autsiz
        .databank `aValidPersonalSkillTable

        ; A = skill ID

        phb
        phk
        plb
        phx
        ldx wRoutineVariable1,b
        phx

        sta wRoutineVariable1,b
        lda wRoutineVariable1,b
        asl a
        clc
        adc wRoutineVariable1,b
        tax
        jsl rlGetSelectedUnitSkills

        lda lRoutineVariable,b
        bit aValidPersonalSkillTable,x
        bne +

        lda lRoutineVariable+1,b
        bit aValidPersonalSkillTable+1,x
        bne +

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

      rlCheckIfInventoryItemsHaveSpecifiedSkill ; 87/A2EF

        .al
        .autsiz
        .databank `aValidItemSkillTable

        phb
        php
        phk
        plb
        phx
        phy

        asl a
        tax
        ldy #1

        -
        tya
        jsl rlGetItemROMDataByInventorySlot

        lda wCurrentItemDataROMPointer,b
        beq _CLC

        jsl rlGetItemEquipmentType
        cmp #EquipTypeWeapon
        bne +

          tya
          jsl rlCheckIfWeaponEquipped
          bcc ++

        +
        jsl rlGetItemSkills
        bit aValidItemSkillTable,x
        bne _SEC

        +
        inc y
        bra -

        _CLC
        ply
        plx
        plp
        plb
        clc
        rtl

        _SEC
        ply
        plx
        plp
        plb
        sec
        rtl

        .databank 0

      rlDebugGetSkillList ; 87/A32C

        .al
        .autsiz
        .databank ?

        phb
        php

        phk
        plb

        phx
        lda #0
        sta wDebugMenuSkillCounter

        ldx #size(aDebugMenuSkillFlags)-1
        lda #0

        -
        sta aDebugMenuSkillFlags,x
        dec x
        bpl -

        jsr rsDebugGetClassSkills
        jsr rsDebugGetPersonalSkills
        jsr rsDebugGetItemSkills
        plx

        plp
        plb
        rtl

        .databank 0

      rsDebugFlagSkillPossesstion ; 87/A352

        .al
        .autsiz
        .databank ?

        ; wR0 = skill ID

        phx
        ldx wR0
        lda aDebugMenuSkillFlags,x
        and #$00FF
        bne +

          sep #$20
          lda #1
          sta aDebugMenuSkillFlags,x
          rep #$20

          lda wDebugMenuSkillCounter
          inc a
          sta wDebugMenuSkillCounter

        +
        plx
        rts

        .databank 0

      rsDebugGetClassSkills ; 87/A373

        .al
        .autsiz
        .databank ?

        jsl rlGetSelectedUnitClassDataPointer
        jsl rlGetClassSkills
        ora #0
        beq _End

          sta wR1

          lda #size(aDebugMenuSkillFlags)-1
          sta wR0

          ldx #size(aValidClassSkillTable)-2

          -
          lda aValidClassSkillTable,x
          bit wR1
          beq +

            jsr rsDebugFlagSkillPossesstion

          +
          dec wR0
          dec x
          dec x
          bpl -

        _End
        rts

        .databank 0

      rsDebugGetPersonalSkills ; 87/A39C

        .al
        .autsiz
        .databank ?

        jsl rlGetSelectedUnitSkills

        ; ora all skills together to see if we have minimum 1

        lda lRoutineVariable,b
        ora lRoutineVariable+1,b
        beq _End

          lda #size(aDebugMenuSkillFlags)-1
          sta wR0

          ldx #size(aValidPersonalSkillTable)-3

          -
          lda aValidPersonalSkillTable,x
          bit lRoutineVariable,b
          bne +

          lda aValidPersonalSkillTable+1,x
          bit lRoutineVariable+1,b
          beq ++

            +
            jsr rsDebugFlagSkillPossesstion
          
          +
          dec wR0
          dec x
          dec x
          dec x
          bpl -
        
        _End
        rts

        .databank 0

      rsDebugGetItemSkills ; 87/A3CD

        .al
        .autsiz
        .databank ?

        ldx #1
        
        _Loop
        txa
        jsl rlGetItemROMDataByInventorySlot

        lda wCurrentItemDataROMPointer
        beq _End

          jsl rlGetItemEquipmentType
          cmp #EquipTypeWeapon
          bne +

            tya
            jsl rlCheckIfWeaponEquipped
            bcc _A411
          
          +
          jsl rlGetItemSkills
          ora #0
          beq _A411

          sta wR1

          lda #size(aDebugMenuSkillFlags)-1
          sta wR0

          phx
          ldx #size(aValidItemSkillTable)-2
          
          -
          lda aValidItemSkillTable,x
          bit wR1
          beq +

            jsr rsDebugFlagSkillPossesstion

          +
          dec wR0
          dec x
          dec x
          bpl -

          plx

          _A411
          inc x
          bra _Loop
        
        _End
        rts

        .databank 0

      rlUnknown87A415 ; 87/A415

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx

        lda #0
        sta $7E2000
        ldx #$001D
        lda #0
        
        -
        sta $7E2002,x
        dec x
        bpl -

        jsr $87A373
        jsr $87A39C

        plx
        plp
        plb
        rtl

        .databank 0

      rlGetPromotedClassIfAvailable ; 87/A438

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        phy

        lda #0
        sta $7E2000

        jsl rlGetSelectedUnitStates
        bit #UnitState1000
        bne _SEC

        jsl rlGetSelectedUnitClassID
        sta wRoutineVariable1,b

        jsl rlGetSelectedUnitCharacterID
        dec a
        tax
        lda aPromotionTable,x
        and #$00FF
        cmp #$00FF
        beq _SEC

        cmp wRoutineVariable1,b
        beq _SEC

        jsl rlGetClassDataROMPointer
        jsl rlGetSelectedUnitLevel
        sta wRoutineVariable1,b

        jsl rlGetClassPromotionLevel
        dec a
        cmp wRoutineVariable1,b
        bpl +

          lda aPromotionTable,x
          sta $7E2000+2
          lda #1
          sta $7E2000

        +
        ply
        plx
        plp
        plb
        clc
        
        -
        rtl
        
        _SEC
        ply
        plx
        plp
        plb
        sec
        bra -

        .databank 0

      rlGetClassDataROMPointer ; 87/A49D

        .al
        .autsiz
        .databank ?

        phb
        php

        phk
        plb

        phx
        asl a
        clc
        adc aMainDataOffsets.ClassDataOffsets
        tax
        lda aMainDataOffsets,x
        clc
        adc aMainDataOffsets.ClassDataOffsets
        adc #<>aMainDataOffsets
        sta wCurrentClassDataROMPointer,b
        plx

        plp
        plb
        rtl

        .databank 0

      rlGetClassNamePointer ; 87/A4BC

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx

        asl a
        clc
        adc aMainDataOffsets.ClassNameOffsets
        tax
        lda #(`aMainDataOffsets)<<8
        sta lRoutineVariable+1,b
        lda aMainDataOffsets,x
        clc
        adc aMainDataOffsets.ClassNameOffsets
        adc #<>aMainDataOffsets
        sta lRoutineVariable,b
        plx
        plp
        plb
        rtl

        .databank 0

      rlGetClassPromotionLevel ; 87/A4E1

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`aClassData
        pha
        rep #$20
        plb

        phx
        ldx wCurrentClassDataROMPointer,b
        lda structClassROMEntry.PromotionLevel,b,x
        and #$00FF
        plx

        plp
        plb
        rtl

        .databank 0

      rlGetClassBaseHP ; 87/A4F9

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`aClassData
        pha
        rep #$20
        plb

        phx
        ldx wCurrentClassDataROMPointer,b
        lda structClassROMEntry.HP,b,x
        and #$00FF
        plx

        plp
        plb
        rtl

        .databank 0

      rlGetClassStrength ; 87/A511

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`aClassData
        pha
        rep #$20
        plb

        phx
        ldx wCurrentClassDataROMPointer,b
        lda structClassROMEntry.Strength,b,x
        and #$00FF
        plx

        plp
        plb
        rtl

        .databank 0

      rlGetClassMagic ; 87/A529

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`aClassData
        pha
        rep #$20
        plb

        phx
        ldx wCurrentClassDataROMPointer,b
        lda structClassROMEntry.Magic,b,x
        and #$00FF
        plx

        plp
        plb
        rtl

        .databank 0

      rlGetClassSkill ; 87/A541

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`aClassData
        pha
        rep #$20
        plb

        phx
        ldx wCurrentClassDataROMPointer,b
        lda structClassROMEntry.Skill,b,x
        and #$00FF
        plx

        plp
        plb
        rtl

        .databank 0

      rlGetClassSpeed ; 87/A559

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`aClassData
        pha
        rep #$20
        plb

        phx
        ldx wCurrentClassDataROMPointer,b
        lda structClassROMEntry.Speed,b,x
        and #$00FF
        plx

        plp
        plb
        rtl

        .databank 0

      rlGetClassDefense ; 87/A571

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`aClassData
        pha
        rep #$20
        plb

        phx
        ldx wCurrentClassDataROMPointer,b
        lda structClassROMEntry.Defense,b,x
        and #$00FF
        plx

        plp
        plb
        rtl

        .databank 0

      rlGetClassResistance ; 87/A589

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`aClassData
        pha
        rep #$20
        plb

        phx
        ldx wCurrentClassDataROMPointer,b
        lda structClassROMEntry.Resistance,b,x
        and #$00FF
        plx

        plp
        plb
        rtl

        .databank 0

      rlGetClassWeaponRank ; 87/A5A1

        .al
        .autsiz
        .databank ?

        ; A = weapon type

        phb
        php

        phk
        plb

        phx

        pha

        sep #$20
        lda #`aClassData
        pha
        rep #$20
        plb

        pla
        clc
        adc wCurrentClassDataROMPointer,b
        tax
        lda structClassROMEntry.WeaponRanks,b,x
        bit #$0080
        bne +

        and #$007F
        bra ++

        +
        ora #$FF80
        
        +
        plx
        plp
        plb
        rtl

        .databank 0

      rlGetClassHPGrowth ; 87/A5C9

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`aClassData
        pha
        rep #$20
        plb

        phx
        ldx wCurrentClassDataROMPointer,b
        lda structClassROMEntry.HPGrowth,b,x
        and #$00FF
        plx

        plp
        plb
        rtl

        .databank 0

      rlGetClassStrGrowth ; 87/A5E1

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`aClassData
        pha
        rep #$20
        plb

        phx
        ldx wCurrentClassDataROMPointer,b
        lda structClassROMEntry.StrengthGrowth,b,x
        and #$00FF
        plx

        plp
        plb
        rtl

        .databank 0

      rlGetClassMagGrowth ; 87/A5F9

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`aClassData
        pha
        rep #$20
        plb

        phx
        ldx wCurrentClassDataROMPointer,b
        lda structClassROMEntry.MagicGrowth,b,x
        and #$00FF
        plx

        plp
        plb
        rtl

        .databank 0

      rlGetClassSklGrowth ; 87/A611

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`aClassData
        pha
        rep #$20
        plb

        phx
        ldx wCurrentClassDataROMPointer,b
        lda structClassROMEntry.SkillGrowth,b,x
        and #$00FF
        plx

        plp
        plb
        rtl

        .databank 0

      rlGetClassSpdGrowth ; 87/A629

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`aClassData
        pha
        rep #$20
        plb

        phx
        ldx wCurrentClassDataROMPointer,b
        lda structClassROMEntry.SpeedGrowth,b,x
        and #$00FF
        plx

        plp
        plb
        rtl

        .databank 0

      rlGetClassDefGrowth ; 87/A641

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`aClassData
        pha
        rep #$20
        plb

        phx
        ldx wCurrentClassDataROMPointer,b
        lda structClassROMEntry.DefenseGrowth,b,x
        and #$00FF
        plx

        plp
        plb
        rtl

        .databank 0

      rlGetClassResGrowth ; 87/A659

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`aClassData
        pha
        rep #$20
        plb

        phx
        ldx wCurrentClassDataROMPointer,b
        lda structClassROMEntry.ResistanceGrowth,b,x 
        and #$00FF
        plx

        plp
        plb
        rtl

        .databank 0

      rlGetClassMovement ; 87/A671

        .al
        .autsiz
        .databank ?

        phb
        php
        sep #$20
        lda #`aClassData
        pha
        rep #$20
        plb

        phx
        ldx wCurrentClassDataROMPointer,b
        lda structClassROMEntry.Movement,b,x
        and #$00FF
        plx

        plp
        plb
        rtl

        .databank 0

      rlGetClassMovementType ; 87/A689

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`aClassData
        pha
        rep #$20
        plb

        phx
        ldx wCurrentClassDataROMPointer,b
        lda structClassROMEntry.MovementType,b,x
        and #$00FF
        plx

        plp
        plb
        rtl

        .databank 0

      rlGetClassTerrainBonusType ; 87/A6A1

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`aClassData
        pha
        rep #$20
        plb

        phx
        ldx wCurrentClassDataROMPointer,b
        lda structClassROMEntry.TerrainBonusType,b,x 
        and #$00FF
        plx

        plp
        plb
        rtl

        .databank 0

      rlGetClassMoney ; 87/A6B9

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`aClassData
        pha
        rep #$20
        plb

        phx
        ldx wCurrentClassDataROMPointer,b
        lda structClassROMEntry.Money,b,x
        and #$00FF
        plx

        plp
        plb
        rtl

        .databank 0

      rlGetClassSkills ; 87/A6D1

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`aClassData
        pha
        rep #$20
        plb

        phx
        ldx wCurrentClassDataROMPointer,b
        lda structClassROMEntry.Skills,b,x
        plx

        plp
        plb
        rtl

        .databank 0

      rsFillChildExtendedPersonalData ; 87/A6E6

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
        jsl $80A1D8

        lda wR12
        clc
        adc #2000
        sta structExtendedCharacterDataRAM.Money,b,y

        jsl rlGetSelectedUnitLevel
        sta wR0
        jsl rlGetSelectedUnitTotalHPGrowth
        jsr rlGetAverageStatsForLevel
        clc
        adc #15
        sta aChildAverageLevelStats.HP

        jsl rlGetSelectedUnitTotalStrGrowth
        jsr rlGetAverageStatsForLevel
        sta aChildAverageLevelStats.Strength

        jsl rlGetSelectedUnitTotalMagGrowth
        jsr rlGetAverageStatsForLevel
        sta aChildAverageLevelStats.Magic

        jsl rlGetSelectedUnitTotalSklGrowth
        jsr rlGetAverageStatsForLevel
        sta aChildAverageLevelStats.Skill

        jsl rlGetSelectedUnitTotalSpdGrowth
        jsr rlGetAverageStatsForLevel
        sta aChildAverageLevelStats.Speed

        jsl rlGetSelectedUnitTotalDefGrowth
        jsr rlGetAverageStatsForLevel
        sta aChildAverageLevelStats.Defense

        jsl rlGetSelectedUnitTotalResGrowth
        jsr rlGetAverageStatsForLevel
        sta aChildAverageLevelStats.Resistance

        jsl rlGetSelectedUnitTotalLuckGrowth
        jsr rlGetAverageStatsForLevel
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
        jsr rlGetChildAdjustedBaseStat

        sep #$20
        sta structExtendedCharacterDataRAM.HP,b,y
        rep #$20
        inc x
        inc x
        inc y
        cpx #size(aChildAverageLevelStats)
        bcc -

        ; Add a random amount of 0-9 luck to a child
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

      rlGetAverageStatsForLevel ; 87/A80A

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

      rlGetChildAdjustedBaseStat ; 87/A83A

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
        jsr rlGetChildGrowthRate

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
        jsr rlGetChildHolyBlood
        sta structCharacterConstantData.HolyBlood1,b,y

        lda aUnit1DataBuffer._ROM.HolyBlood2
        sta wR0
        lda aUnit2DataBuffer._ROM.HolyBlood2
        sta wR1
        jsr rlGetChildHolyBlood
        sta structCharacterConstantData.HolyBlood2,b,y
        bra ++

        ; Mother influence
        +
        lda aUnit2DataBuffer._ROM.HolyBlood1
        sta wR0
        lda aUnit1DataBuffer._ROM.HolyBlood1
        sta wR1
        jsr rlGetChildHolyBlood
        sta structCharacterConstantData.HolyBlood1,b,y

        lda aUnit2DataBuffer._ROM.HolyBlood2
        sta wR0
        lda aUnit1DataBuffer._ROM.HolyBlood2
        sta wR1
        jsr rlGetChildHolyBlood
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

      aValidInheritableSkills .binclude "../../TABLES/CHARACTER/ValidInheritableSkills.asm"  ; 87/A975

      rlGetChildGrowthRate ; 87/A9EA

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

      rlGetChildHolyBlood ; 87/A9FB

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
        jsr rsUnknown87AAC9
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
          sta $0587,b
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

      rsUnknown87AAC9 ; 87/AAC9

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

              jsl rlRevertItemAquirement
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
                jsl rlRevertItemAquirement
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
        jsl rlRevertItemAquirement
        
        _End
        rts

        .databank 0

      rlGetUnitLoveBaseWithTarget ; 87/ABC1

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        ldx wSelectedUnitDataRAMPointer,b
        phx
        ldx wR0
        phx
        ldx wR1
        phx

        jsl rlGetSelectedUnitGenerationID
        bcs _AC3E

        cmp #$10
        bcs +

          ; male unit
          jsl rlGetSelectedUnitLoveDataID
          sta wR0
          lda wRoutineVariable1,b
          sta wSelectedUnitDataRAMPointer,b
          jsl rlGetSelectedUnitLoveDataID
          asl a
          sta wR1
          bra ++

          ; female unit
          +
          jsl rlGetSelectedUnitLoveDataID
          asl a
          sta wR1
          lda wRoutineVariable1,b
          sta wSelectedUnitDataRAMPointer,b
          jsl rlGetSelectedUnitLoveDataID
          sta wR0

        +
        ldx wR1
        lda aLoveBaseOffsets,x
        clc
        adc wR0
        tax
        lda aLoveBaseOffsets,x
        and #$00FF
        cmp #$00FF
        beq ++

        cmp #$00FE
        beq +

        asl a
        sta wR0
        asl a
        asl a
        clc
        adc wR0
        bra _End
        
        +
        lda #499
        bra _End

        +
        lda #$FFFF
        
        _End
        plx
        stx wR1
        plx
        stx wR0
        plx
        stx wSelectedUnitDataRAMPointer,b
        plx
        plp
        plb
        rtl

        _AC3E
        lda #0
        bra _End

        .databank 0

      rlGetSelectedUnitLoverData ; 87/AC43

        .al
        .autsiz
        .databank ?

        ldx wSelectedUnitDataRAMPointer,b
        sep #$20
        lda $7E0000+structCharacterDataRAM.LoverData+2,x
        pha
        rep #$20
        plb
        lda $7E0000+structCharacterDataRAM.LoverData,x
        tax
        rtl

        .databank 0

      rlSaveLoverDataToBuffer ; 87/AC56

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

        jsl rlGetSelectedUnitLoverData
        lda lRAMBufferPointer+1,b
        sta lR18+1
        lda lRAMBufferPointer,b
        sta lR18
        ldy #0

          -
          lda $0000,b,x
          sta [lR18],y
          inc x
          inc x
          inc y
          inc y
          cpy #size(structLoverDataRAM)
          bne -

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

      rlUnknown87AC8C ; 87/AC8C

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        phy
        lda $24
        pha
        lda $24+1
        pha

        jsl rlGetSelectedUnitLoverData
        lda lRAMBufferPointer+1,b
        sta $24+1
        lda lRAMBufferPointer,b
        sta $24
        ldy #0
        
        -
        lda [$24],y
        sta $0000,b,x
        inc x
        inc x
        inc y
        inc y
        cpy #$001E
        bne -

        pla
        sta $24+1
        pla
        sta $24
        ply
        plx
        plp
        plb
        rtl

        .databank 0

      rlGetSelectedUnitLoveDataIDByCharacterID ; 87/ACC2

        .al
        .autsiz
        .databank ?

        phx
        phy
        lda wRoutineVariable1,b
        pha

        jsl rlGetSelectedUnitCharacterID
        cmp #Gerrard
        bcs _Enemy

          sta wRoutineVariable1,b

          jsl rlGetSelectedUnitGender
          cmp #GenderMale
          bmi _Enemy
          bne _Female

          ; Male
          ldx #<>aMaleLoveDataIDs
          bra +

          _Female
          ldx #<>aFemaleLoveDataIDs
          
          +
          ldy #0
          
          -
          lda $830000,x
          bmi _End

          cmp wRoutineVariable1,b
          beq _Match

          inc y
          inc x
          inc x
          bra -
          
          _End
          plx
          stx wRoutineVariable1,b
          ply
          plx
          rtl

          _Match
          tya
          plx
          stx wRoutineVariable1,b
          ply
          plx
          rtl

        _Enemy
        lda #$FFFF
        bra _End

        .databank 0

      rlGetUnitLoveGrowthWithTarget ; 87/AD0E

        .al
        .autsiz
        .databank ?

        phb
        php

        phk
        plb

        phx
        ldx wSelectedUnitDataRAMPointer,b
        phx
        ldx wR0
        phx
        ldx wR1
        phx

        jsl rlGetSelectedUnitGenerationID
        bcs _AD79

        cmp #$10
        bcs +

        jsl rlGetSelectedUnitLoveDataID
        sta wR0
        lda wRoutineVariable1,b
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitLoveDataID
        asl a
        sta wR1
        bra ++

        +
        jsl rlGetSelectedUnitLoveDataID
        asl a
        sta wR1
        lda wRoutineVariable1,b
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitLoveDataID
        sta wR0
        
        +
        ldx wR1
        lda aLoveGrowthOffsets,x
        clc
        adc wR0
        tax
        lda aLoveGrowthOffsets,x
        bit #$0080
        bne +

        and #$007F
        bra _End
        
        +
        ora #$FF80
        
        _End
        plx
        stx wR1
        plx
        stx wR0
        plx
        stx wSelectedUnitDataRAMPointer,b
        plx

        plp
        plb
        rtl
        
        _AD79
        lda #0
        bra _End

        .databank 0

      rlGetLoverPointsWithTarget ; 87/AD7E

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

        dec a
        asl a
        sta wRoutineVariable1,b
        jsl rlGetSelectedUnitLoverData
        cpx #0
        beq +

          txa
          clc
          adc wRoutineVariable1,b
          tax
          lda $0000,b,x

        +
        plx 
        stx wRoutineVariable1,b

        plx
        plp
        plb
        rtl

        .databank 0

      rlSaveUnitLoveValueWithTarget ; 87/ADA6

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        phy
        ldx wSelectedUnitDataRAMPointer,b
        phx
        ldx wR0
        phx
        ldx wR1
        phx

        sta wR0
        ldy wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitGenerationID
        cmp #$10
        bcs +

          ; male
          dec a
          sta wR1
          lda wRoutineVariable1,b
          sta wSelectedUnitDataRAMPointer,b
          bra ++
          
          ; female
          +
          lda wRoutineVariable1,b
          sta wSelectedUnitDataRAMPointer,b
          jsl rlGetSelectedUnitGenerationID
          bcs _End

          dec a
          sta wR1
          sty wSelectedUnitDataRAMPointer,b

        ; male number-1 in wR1, female pointer in wSelectedUnitDataRAMPointer
        +
        jsl rlGetSelectedUnitLoverData
        cpx #0
        beq _End

          txa
          asl wR1
          clc
          adc wR1
          tax
          lda wR0
          sta $0000,b,x

        _End
        plx
        stx wR1
        plx
        stx wR0
        plx
        stx wSelectedUnitDataRAMPointer,b
        ply
        plx
        plp
        plb
        rtl

        .databank 0

      rlModifyUnitsLovePoints ; 87/AE05

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = male GenerationID
        ; wSelectedUnitDataRAMPointer = female character data
        ; wRoutineVariable1 = love points amount, can be negative

        ; If love points are 500 or more, marry units to each other.

        phb
        php
        phk
        plb
        phx
        phy
        ldx wRoutineVariable2,b
        phx
        ldx wRoutineVariable3,b
        phx

        cmp #$0010
        bcs _End

          sta wRoutineVariable2,b
          jsl rlGetSelectedUnitGenerationID
          bcs _End

            sta wRoutineVariable3,b
            jsl rlGetSelectedUnitLoverGenerationID
            ora #0
            bne _End

              jsl rlGetSelectedUnitLoverData
              txa
              clc
              adc wRoutineVariable2,b
              clc
              adc wRoutineVariable2,b
              dec a
              dec a
              tay

              lda $0000,b,y
              and #$01FF
              cmp #$01FF
              beq _End

                lda wRoutineVariable1,b
                beq _End
                bmi _Negative

                  lda $0000,b,y
                  clc
                  adc wRoutineVariable1,b
                  cmp #500
                  bcs +

                    sta $0000,b,y
                    bra _End

                  +
                  lda #500
                  sta $0000,b,y
                  jsl rlSetUnitsAsLoversByGenerationIDs
                  bra _End

                _Negative
                lda $0000,b,y
                clc
                adc wRoutineVariable1,b
                bpl +

                  lda #0

                +
                sta $0000,b,y

        _End
        plx
        stx wRoutineVariable3,b
        plx
        stx wRoutineVariable2,b
        ply
        plx
        plp
        plb
        rtl

        .databank 0

        ; 87/AE88

    .endsection SkillsSection
