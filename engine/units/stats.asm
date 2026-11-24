; Unit stats: totals including equipment and skill bonuses, movement, and simple
; fields such as level, experience, leadership stars and money.

    .section UnitStatsSection

      .al
      .xl

      rlGetSelectedUnitMaxHP ; 84/9AE5

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        ldx wSelectedUnitDataRAMPointer,b
        lda $7E0000+structCharacterDataRAM.Type,x
        and #$00FF
        cmp #UnitTypeEnemy
        beq +

          jsl rlGetSelectedUnitExtendedPersonalDataPointer
          lda structExtendedCharacterDataRAM.HP,b,x
          and #$00FF
          cmp #81
          bcc _End

            lda #80

          _End
          plx
          plp
          plb
          rtl

        +
        jsl rlGetEnemyMaxHP
        bra _End

        .databank 0

      rlGetSelectedUnitTotalStrength ; 84/9B15

        .al
        .autsiz
        .databank ?

        jsl rlGetSelectedUnitTotalStrengthEffect
        clc
        adc wR34
        rtl

        .databank 0

      rlGetSelectedUnitTotalStrengthEffect ; 84/9B1D

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        lda #structHolyBloodDataEntry.StrBoost-structHolyBloodDataEntry.StrBoost+1
        jsl rlGetWeaponStatBoostForSpecifiedStat
        sta wR34

        jsl rlGetActiveRingStatBonusBitfield
        bit #$0080
        beq +

          lda wR34
          clc
          adc #5
          sta wR34
        
        +
        ldx wSelectedUnitDataRAMPointer,b
        lda $7E0000+structCharacterDataRAM.Type,x
        and #$00FF
        cmp #UnitTypeEnemy
        beq +

        jsl rlGetSelectedUnitClassDataPointer
        jsl rlGetSelectedUnitExtendedPersonalDataPointer
        jsl rlGetClassStrength
        clc
        adc structExtendedCharacterDataRAM.Strength,b,x
        and #$00FF
        cmp #31
        bcc _End

          lda #30

        _End
        plx
        plp
        plb
        rtl
        
        +
        jsl rlGetEnemyStrength
        bra _End

        .databank 0

      rlGetSelectedUnitTotalMagic ; 84/9B70

        .al
        .autsiz
        .databank ?

        jsl rlGetSelectedUnitTotalMagicEffect
        clc
        adc wR34
        rtl

        .databank 0

      rlGetSelectedUnitTotalMagicEffect ; 84/9B78

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        lda #structHolyBloodDataEntry.MagBoost-structHolyBloodDataEntry.StrBoost+1
        jsl rlGetWeaponStatBoostForSpecifiedStat
        sta wR34

        jsl rlGetActiveRingStatBonusBitfield
        bit #$0040
        beq +

          lda wR34
          clc
          adc #5
          sta wR34

        +
        ldx wSelectedUnitDataRAMPointer,b
        lda $7E0000+structCharacterDataRAM.Type,x
        and #$00FF
        cmp #UnitTypeEnemy
        beq +

        jsl rlGetSelectedUnitClassDataPointer
        jsl rlGetSelectedUnitExtendedPersonalDataPointer
        jsl rlGetClassMagic
        clc
        adc structExtendedCharacterDataRAM.Magic,b,x
        and #$00FF
        cmp #31
        bcc _End

          lda #30
        
        _End
        plx
        plp
        plb
        rtl
        
        +
        jsl rlGetEnemyMagic
        bra _End

        .databank 0

      rlGetSelectedUnitTotalSkill ; 84/9BCB

        .al
        .autsiz
        .databank ?

        jsl rlGetSelectedUnitTotalSkillEffect
        clc
        adc wR34
        rtl

        .databank 0

      rlGetSelectedUnitTotalSkillEffect ; 84/9BD3

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        lda #structHolyBloodDataEntry.SklBoost-structHolyBloodDataEntry.StrBoost+1
        jsl rlGetWeaponStatBoostForSpecifiedStat
        sta wR34

        jsl rlGetActiveRingStatBonusBitfield
        bit #$0020
        beq +

          lda wR34
          clc
          adc #5
          sta wR34

        +
        ldx wSelectedUnitDataRAMPointer,b
        lda $7E0000+structCharacterDataRAM.Type,x
        and #$00FF
        cmp #UnitTypeEnemy
        beq +

        jsl rlGetSelectedUnitClassDataPointer
        jsl rlGetSelectedUnitExtendedPersonalDataPointer
        jsl rlGetClassSkill
        clc
        adc structExtendedCharacterDataRAM.Skill,b,x
        and #$00FF
        cmp #31
        bcc _End

          lda #30
        
        _End
        plx
        plp
        plb
        rtl
        
        +
        jsl rlGetEnemySkill
        bra _End

        .databank 0

      rlGetSelectedUnitTotalSpeed ; 84/9C26

        .al
        .autsiz
        .databank ?

        jsl rlGetSelectedUnitTotalSpeedEffect
        clc
        adc wR34
        rtl

        .databank 0

      rlGetSelectedUnitTotalSpeedEffect ; 84/9C2E

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        lda #structHolyBloodDataEntry.SpdBoost-structHolyBloodDataEntry.StrBoost+1
        jsl rlGetWeaponStatBoostForSpecifiedStat
        sta wR34

        jsl rlGetActiveRingStatBonusBitfield
        bit #$0010
        beq +

          lda wR34
          clc
          adc #5
          sta wR34

        +
        ldx wSelectedUnitDataRAMPointer,b
        lda $7E0000+structCharacterDataRAM.Type,x
        and #$00FF
        cmp #UnitTypeEnemy
        beq +

          jsl rlGetSelectedUnitClassDataPointer
          jsl rlGetSelectedUnitExtendedPersonalDataPointer
          jsl rlGetClassSpeed
          clc
          adc structExtendedCharacterDataRAM.Speed,b,x
          and #$00FF
          cmp #31
          bcc _End

           lda #30

        _End
        plx
        plp
        plb
        rtl

        +
        jsl rlGetEnemySpeed
        bra _End

        .databank 0

      rlGetSelectedUnitTotalDefense ; 84/9C81

        .al
        .autsiz
        .databank ?

        jsl rlGetSelectedUnitTotalDefenseEffect
        clc
        adc wR34
        rtl

        .databank 0

      rlGetSelectedUnitTotalDefenseEffect ; 84/9C89

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        lda #structHolyBloodDataEntry.DefBoost-structHolyBloodDataEntry.StrBoost+1
        jsl rlGetWeaponStatBoostForSpecifiedStat
        sta wR34

        jsl rlGetActiveWeaponStatBonus
        cmp #SafeguardStatBoost
        bne +

          lda wR34
          clc
          adc #7
          sta wR34

        +
        jsl rlGetActiveRingStatBonusBitfield
        bit #$0008
        beq +

          lda wR34
          clc
          adc #5
          sta wR34

        +
        ldx wSelectedUnitDataRAMPointer,b
        lda $7E0000+structCharacterDataRAM.Type,x
        and #$00FF
        cmp #UnitTypeEnemy
        beq +

        jsl rlGetSelectedUnitClassDataPointer
        jsl rlGetSelectedUnitExtendedPersonalDataPointer
        jsl rlGetClassDefense
        clc
        adc structExtendedCharacterDataRAM.Defense,b,x
        and #$00FF
        cmp #31
        bcc _End

          lda #30

        _End
        plx
        plp
        plb
        rtl
        
        +
        jsl rlGetEnemyDefense
        bra _End

        .databank 0

      rlGetSelectedUnitTotalResistance ; 84/9CED

        .al
        .autsiz
        .databank ?

        jsl rlGetSelectedUnitTotalResistanceEffect
        clc
        adc wR34
        rtl

        .databank 0

      rlGetSelectedUnitTotalResistanceEffect ; 84/9CF5

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        lda #structHolyBloodDataEntry.ResBoost-structHolyBloodDataEntry.StrBoost+1
        jsl rlGetWeaponStatBoostForSpecifiedStat
        sta wR34

        jsl rlGetActiveWeaponStatBonus
        cmp #BarrierBladeStatBoost
        bne +

          lda wR34
          clc
          adc #7
          sta wR34
        
        +
        jsl rlGetActiveRingStatBonusBitfield
        bit #$0004
        beq +

          lda wR34
          clc
          adc #5
          sta wR34

        +
        ldx wSelectedUnitDataRAMPointer,b
        lda $7E0000+structCharacterDataRAM.Type,x
        and #$00FF
        cmp #UnitTypeEnemy
        beq +

        jsl rlGetSelectedUnitClassDataPointer
        jsl rlGetSelectedUnitExtendedPersonalDataPointer
        jsl rlGetClassResistance
        clc
        adc structExtendedCharacterDataRAM.Resistance,b,x
        and #$00FF
        cmp #31
        bcc _End

          lda #30

        _End
        plx
        plp
        plb
        rtl
        
        +
        jsl rlGetEnemyResistance
        bra _End

        .databank 0

      rlGetSelectedUnitTotalMovement ; 84/9D59

        .al
        .autsiz
        .databank ?

        jsl rlGetSelectedUnitTotalMovementEffect
        clc
        adc wR34
        rtl

        .databank 0

      rlGetSelectedUnitTotalFieldMovement ; 84/9D61

        .al
        .autsiz
        .databank ?

        ; Gets movement * 10 +1

        phb
        php
        phk
        plb
        phx
        jsl rlGetSelectedUnitStates
        bit #UnitStateCanto
        bne ++

          stz wR34

          jsl rlGetActiveRingStatBonusBitfield
          bit #$0002 ; move
          beq +

            lda #3
            sta wR34

          +
          jsl rlGetSelectedUnitClassDataPointer
          jsl rlGetClassMovement
          clc
          adc wR34
          tax
          lda _FieldMovementLookupTable,x
          and #$00FF
          bra ++

        +
        jsl rlGetSelectedUnitCantoMovement

        +
        plx
        plp
        plb
        rtl

        .databank 0

        _FieldMovementLookupTable ; 84/9D9C

          .byte ( 0 * 10) +1
          .byte ( 1 * 10) +1
          .byte ( 2 * 10) +1
          .byte ( 3 * 10) +1
          .byte ( 4 * 10) +1
          .byte ( 5 * 10) +1
          .byte ( 6 * 10) +1
          .byte ( 7 * 10) +1
          .byte ( 8 * 10) +1
          .byte ( 9 * 10) +1
          .byte (10 * 10) +1
          .byte (11 * 10) +1
          .byte (12 * 10) +1

      rlGetSelectedUnitTotalMovementEffect ; 84/9DA9

        .al
        .autsiz
        .databank ?

        ; returns class movement + filled wR34 with possible leg ring
        ; or canto movement as number

        phb
        php
        phk
        plb
        phx

        stz wR34

        jsl rlGetActiveRingStatBonusBitfield
        bit #$0002 ; leg ring
        beq +

          lda #3
          sta wR34

        +
        jsl rlGetSelectedUnitStates
        bit #UnitStateCanto
        bne +

          jsl rlGetSelectedUnitClassDataPointer
          jsl rlGetClassMovement
          bra ++

        +
        jsl rlGetSelectedUnitCantoMovement
        sta wR36
        lda #10
        sta wR37
        jsl rlUnsignedDivide16By16

        lda wR36
        stz wR34

        +
        plx
        plp
        plb
        rtl

        .databank 0

      rlGetSelectedUnitLuck ; 84/9DE8

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        ldx wSelectedUnitDataRAMPointer,b
        lda $7E0000+structCharacterDataRAM.Type,x
        and #$00FF
        cmp #UnitTypeEnemy
        beq +

        jsl rlGetSelectedUnitExtendedPersonalDataPointer
        lda structExtendedCharacterDataRAM.Luck,b,x
        and #$00FF
        
        -
        plx
        plp
        plb
        rtl

        +
        lda #$FFFF
        bra -

        .databank 0

      rlSetSelectedUnitAIUnused ; 84/9E0F

        .al
        .autsiz
        .databank ?

        ; I hope this routine isn't used

        phb
        php
        phk
        plb
        phx

        pha
        jsl rlGetSelectedUnitPersonalDataPointer
        pla

        sep #$20
        sta structPersonalCharacterDataRAM.AI,b,x

        plx
        plp
        plb
        rtl

        .databank 0

      rlGetSelectedUnitLevel ; 84/9E23

        .al
        .autsiz
        .databank ?

        phb
        php

        phk
        plb

        phx
        ldx wSelectedUnitDataRAMPointer,b
        lda $7E0000+structCharacterDataRAM.Type,x
        and #$00FF
        cmp #UnitTypeEnemy
        beq +

        jsl rlGetSelectedUnitExtendedPersonalDataPointer
        lda structExtendedCharacterDataRAM.Level,b,x
        and #$00FF

        -
        plx
        plp
        plb
        rtl
        
        +
        jsl rlGetEnemyUnitLevel
        bra -

        .databank 0

      rlGetSelectedUnitLeadershipStars ; 84/9E4B

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        ldx wSelectedUnitDataRAMPointer,b
        lda $7E0000+structCharacterDataRAM.Type,x
        and #$00FF
        cmp #UnitTypeEnemy
        beq +

        jsl rlGetSelectedUnitExtendedPersonalDataPointer
        lda structExtendedCharacterDataRAM.LeadershipStars,b,x
        and #$00FF
        
        -
        plx
        plp
        plb
        rtl
        
        +
        jsl rlGetEnemyUnitLeadershipStars
        bra -

        .databank 0

      rlGetSelectedUnitExperience ; 84/9E73

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        ldx wSelectedUnitDataRAMPointer,b
        lda $7E0000+structCharacterDataRAM.Type,x
        and #$00FF
        cmp #UnitTypeEnemy
        beq +

        jsl rlGetSelectedUnitFactionSlot
        ora #0
        bne +

          jsl rlGetSelectedUnitExtendedPersonalDataPointer
          lda structExtendedCharacterDataRAM.Experience,b,x
          and #$00FF

          -
          plx
          plp
          plb
          rtl
        
        +
        lda #$FFFF
        bra -

        .databank 0

      rlGetSelectedUnitLivingTalkTarget ; 84/9EA3

        .al
        .autsiz
        .databank ?

        ; Returns the character ID of the unit's talk target if that unit is alive,
        ; otherwise 0. Always 0 for enemy units.

        phb
        php
        phk
        plb
        phx
        lda wSelectedUnitDataRAMPointer,b
        pha
        lda wRoutineVariable1,b
        pha

        ldx wSelectedUnitDataRAMPointer,b
        lda $7E0000+structCharacterDataRAM.Type,x
        and #$00FF
        cmp #UnitTypeEnemy
        beq +

          jsl rlGetSelectedUnitExtendedPersonalDataPointer
          lda structExtendedCharacterDataRAM.TalkTarget,b,x
          and #$00FF
          sta wRoutineVariable1,b
          stz wR10

          lda #0
          jsl rlFindFactionUnitByCharacterID

          lda wSelectedUnitDataRAMPointer,b
          beq +

            jsl rlGetSelectedUnitStates
            bit #UnitStateDead
            bne +

              lda wRoutineVariable1,b

              -
              plx
              stx wRoutineVariable1,b
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

      rlSetSelectedUnitTalkTarget ; 84/9EF7

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx

        pha
        jsl rlGetSelectedUnitExtendedPersonalDataPointer
        pla

        sep #$20
        sta structExtendedCharacterDataRAM.TalkTarget,b,x
        rep #$20

        plx
        plp
        plb
        rtl

        .databank 0

      rlGetSelectedUnitMoney ; 84/9F0D

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        ldx wSelectedUnitDataRAMPointer,b
        lda $7E0000+structCharacterDataRAM.Type,x
        and #$00FF
        cmp #UnitTypeHoly
        bcs +

        jsl rlGetSelectedUnitExtendedPersonalDataPointer
        lda structExtendedCharacterDataRAM.Money,b,x
        
        -
        plx
        plp
        plb
        rtl
        
        +
        jsl rlGetEnemyClassMoney
        bra -

        .databank 0

      rlSetSelectedUnitMoney ; 84/9F32

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        pha
        ldx wSelectedUnitDataRAMPointer,b
        lda $7E0000+structCharacterDataRAM.Type,x
        and #$00FF
        cmp #UnitTypeHoly
        bcs +

        jsl rlGetSelectedUnitExtendedPersonalDataPointer
        pla
        sta structExtendedCharacterDataRAM.Money,b,x
        
        -
        plx
        plp
        plb
        rtl
        
        +
        pla
        jsl rlSetEnemyClassMoney
        bra -

        .databank 0

      rlAddSelectedUnitStat ; 84/9F5A

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = stat increase
        ; wRoutineVariable1 = stat index

        ; Output:
        ; wR0 = actual stat increase, accounts for hitting caps

        phb
        php
        phk
        plb
        phx
        phy
        sta wR0
        lda wRoutineVariable1,b
        cmp #8
        bcs _End

          ldx wSelectedUnitDataRAMPointer,b
          lda $7E0000 + structCharacterDataRAM.Type,x
          and #$00FF
          cmp #UnitTypeHoly
          bcs _End

            jsl rlGetSelectedUnitExtendedPersonalDataPointer
            txa
            clc
            adc wRoutineVariable1,b
            tay

            ldx wRoutineVariable1,b
            sep #$20
            lda $0000,b,y
            clc
            adc wR0
            cmp _StatCaps,x
            bcc +

              lda _StatCaps,x
              sec
              sbc $0000,b,y
              sta wR0
              lda _StatCaps,x

            +
            sta $0000,b,y
            rep #$20

        _End
        lda wR0
        and #$00FF
        ply
        plx
        plp
        plb
        rtl

        .databank 0

        _StatCaps ; 84/9FB1
        .byte 80 ; HP
        .byte 15 ; Strength
        .byte 15 ; Magic
        .byte 15 ; Skill
        .byte 15 ; Speed
        .byte 15 ; Defense
        .byte 15 ; Resistance
        .byte 30 ; Luck

        ; 84/9FB9

    .endsection UnitStatsSection


    .section StatsUnusedStubsSection

      .al
      .xl

      rlStatsUnusedStub1 ; 84/9FB9

        ; Only rtl, as is the next routine.

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 84/9FBA

      rlStatsUnusedStub2 ; 84/9FBA

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 84/9FBB

    .endsection StatsUnusedStubsSection
