; Level-up stat growth rolls.

    .section LevelUpSection

      .al
      .xl

      rsRollForStatGrowth ; 84/ACE7

        .al
        .autsiz
        .databank ?

        stz wRoutineVariable1,b
        cmp #100
        bcc +

          inc wRoutineVariable1,b
          sec
          sbc #100

        +
        jsl rlRollForChance
        bcs +

          inc wRoutineVariable1,b

        +
        rts

        .databank 0

      rsApplyLevelUpHPGain ; 84/AD00

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        jsl rlGetSelectedUnitTotalHPGrowth
        jsr rsRollForStatGrowth
        jsl rlGetSelectedUnitExtendedPersonalDataPointer

        sep #$20
        lda structExtendedCharacterDataRAM.HP,b,x
        cmp #80
        bcs ++

          clc
          adc wRoutineVariable1,b
          cmp #80 +1
          bcc +

            lda #80

          +
          sta structExtendedCharacterDataRAM.HP,b,x
          rep #$20
          plx
          plp
          plb
          lda wRoutineVariable1,b
          rts

        +
        rep #$20
        plx
        plp
        plb
        lda #0
        rts

        .databank 0

      rsApplyLevelUpStrengthGain ; 84/AD38

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        jsl rlGetSelectedUnitTotalStrGrowth
        jsr rsRollForStatGrowth
        jsl rlGetSelectedUnitExtendedPersonalDataPointer

        sep #$20
        lda structExtendedCharacterDataRAM.Strength,b,x
        cmp #15
        bcs ++

          clc
          adc wRoutineVariable1,b
          cmp #15 +1
          bcc +

            lda #15

          +
          sta structExtendedCharacterDataRAM.Strength,b,x
          rep #$20
          plx
          plp
          plb
          lda wRoutineVariable1,b
          rts

        +
        rep #$20
        plx
        plp
        plb
        lda #0
        rts

        .databank 0

      rsApplyLevelUpMagicGain ; 84/AD70

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        jsl rlGetSelectedUnitTotalMagGrowth
        jsr rsRollForStatGrowth
        jsl rlGetSelectedUnitExtendedPersonalDataPointer

        sep #$20
        lda structExtendedCharacterDataRAM.Magic,b,x
        cmp #15
        bcs ++

          clc
          adc wRoutineVariable1,b
          cmp #15+1
          bcc +

            lda #15

          +
          sta structExtendedCharacterDataRAM.Magic,b,x
          rep #$20
          plx
          plp
          plb
          lda wRoutineVariable1,b
          rts

        +
        rep #$20
        plx
        plp
        plb
        lda #0
        rts

        .databank 0

      rsApplyLevelUpSkillGain ; 84/ADA8

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        jsl rlGetSelectedUnitTotalSklGrowth
        jsr rsRollForStatGrowth
        jsl rlGetSelectedUnitExtendedPersonalDataPointer

        sep #$20
        lda structExtendedCharacterDataRAM.Skill,b,x
        cmp #15
        bcs ++

          clc
          adc wRoutineVariable1,b
          cmp #15+1
          bcc +

            lda #15

          +
          sta structExtendedCharacterDataRAM.Skill,b,x
          rep #$20
          plx
          plp
          plb
          lda wRoutineVariable1,b
          rts

        +
        rep #$20
        plx
        plp
        plb
        lda #0
        rts

        .databank 0

      rsApplyLevelUpSpeedGain ; 84/ADE0

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        jsl rlGetSelectedUnitTotalSpdGrowth
        jsr rsRollForStatGrowth
        jsl rlGetSelectedUnitExtendedPersonalDataPointer

        sep #$20
        lda structExtendedCharacterDataRAM.Speed,b,x
        cmp #15
        bcs ++

          clc
          adc wRoutineVariable1,b
          cmp #15+1
          bcc +

            lda #15

          +
          sta structExtendedCharacterDataRAM.Speed,b,x
          rep #$20
          plx
          plp
          plb
          lda wRoutineVariable1,b
          rts

        +
        rep #$20
        plx
        plp
        plb
        lda #0
        rts

        .databank 0

      rsApplyLevelUpDefenseGain ; 84/AE18

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        jsl rlGetSelectedUnitTotalDefGrowth
        jsr rsRollForStatGrowth
        jsl rlGetSelectedUnitExtendedPersonalDataPointer

        sep #$20
        lda structExtendedCharacterDataRAM.Defense,b,x
        cmp #15
        bcs ++

          clc
          adc wRoutineVariable1,b
          cmp #15+1
          bcc +

            lda #15

          +
          sta structExtendedCharacterDataRAM.Defense,b,x
          rep #$20
          plx
          plp
          plb
          lda wRoutineVariable1,b
          rts

        +
        rep #$20
        plx
        plp
        plb
        lda #0
        rts

        .databank 0

      rsApplyLevelUpResistanceGain ; 84/AE50

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        jsl rlGetSelectedUnitTotalResGrowth
        jsr rsRollForStatGrowth
        jsl rlGetSelectedUnitExtendedPersonalDataPointer

        sep #$20
        lda structExtendedCharacterDataRAM.Resistance,b,x
        cmp #15
        bcs ++

          clc
          adc wRoutineVariable1,b
          cmp #15+1
          bcc +

            lda #15

          +
          sta structExtendedCharacterDataRAM.Resistance,b,x
          rep #$20
          plx
          plp
          plb
          lda wRoutineVariable1,b
          rts

        +
        rep #$20
        plx
        plp
        plb
        lda #0
        rts

        .databank 0

      rsApplyLevelUpLuckGain ; 84/AE88

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        jsl rlGetSelectedUnitTotalLuckGrowth
        jsr rsRollForStatGrowth
        jsl rlGetSelectedUnitExtendedPersonalDataPointer

        sep #$20
        lda structExtendedCharacterDataRAM.Luck,b,x
        cmp #30
        bcs ++

          clc
          adc wRoutineVariable1,b
          cmp #30+1
          bcc +

            lda #30

          +
          sta structExtendedCharacterDataRAM.Luck,b,x
          rep #$20
          plx
          plp
          plb
          lda wRoutineVariable1,b
          rts

        +
        rep #$20
        plx
        plp
        plb
        lda #0
        rts

        .databank 0

      rlUnknown84AEC0 ; 84/AEC0

        .al
        .autsiz
        .databank ?

        ; Input:
        ; filled wSelectedUnitDataRAMPointer

        phb
        php
        phk
        plb
        phx

        jsl rlGetSelectedUnitStates
        bit #UnitStateFielded
        bne +

          lda #UnitStateFielded
          jsl rlSetSelectedUnitStates

        +
        jsl rlGetSelectedUnitDeploymentOffset
        bcs +

          ; already deployed

          tax
          jsl rlGetSelectedUnitFactionSlot

          jsl rlChangeFactionSlotOfFieldedSelectedUnit
          jsl rlDeployedUnitSetAliveUnsetHidden
          jsl rlUnknown84C996
          stx wRoutineVariable1,b
          bra ++

          +
          jsl rlDeployUnitCheckIfAsleep

          sta wRoutineVariable1,b
          jsl rlSetSelectedUnitDeploymentOffset
        
        +
        plx
        plp
        plb
        rtl

        .databank 0

      rlSetUnitUnfieldedInCastle ; 84/AF00

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = castle ID

        phb
        php
        phk
        plb
        phx

        and #$001F
        jsl rlSetSelectedUnitResidingCastle
        lda #UnitStateFielded
        jsl rlUnsetSelectedUnitStates

        plx
        plp
        plb
        rtl

        .databank 0

        ; 84/AF17

    .endsection LevelUpSection
