; Level-ups: gaining a level, rolling each stat's growth and applying the gains. Also
; holds rlSetUnitUnfieldedInCastle, which does not seem to be about level-ups.

    .section ActionLevelUpSection

      .al
      .xl

      rlActionStructLevelUp ; 84/AA15

        .al
        .autsiz
        .databank ?

        ; wRoutineVariable1 = gained exp

        phb
        php
        phk
        plb
        phx
        ldx wSelectedUnitDataRAMPointer,b
        lda $7E0000+structCharacterDataRAM.Type,x
        and #$00FF
        cmp #UnitTypeHoly
        bcc +

          jml _NoEXP

        +
        jsl rlGetSelectedUnitFactionSlot
        ora #0
        bne _NoEXP

        jsl rlGetSelectedUnitCurrentHP
        ora #0
        beq _NoEXP

        lda wRoutineVariable1,b
        beq +

          jsl rlGetSelectedUnitExtendedPersonalDataPointer
          lda structExtendedCharacterDataRAM.Level,b,x
          and #$00FF
          cmp #30
          bcs _NoEXP

            sep #$20
            lda structExtendedCharacterDataRAM.Experience,b,x
            clc
            adc wRoutineVariable1
            cmp #100
            bcs ++

              sta structExtendedCharacterDataRAM.Experience,b,x
              rep #$20

        +
        lda #0
        plx
        plp
        plb
        clc
        rtl
        
        .as

        +
        sec
        sbc #100
        sta structExtendedCharacterDataRAM.Experience,b,x
        rep #$20

        lda structExtendedCharacterDataRAM.Level,b,x
        and #$00FF
        inc a
        cmp #30
        bcc +

          sep #$20
          lda wRoutineVariable1
          sec
          sbc structExtendedCharacterDataRAM.Experience,b,x
          sta wRoutineVariable1
          lda #0
          sta structExtendedCharacterDataRAM.Experience,b,x
          rep #$20

        +
        lda wRoutineVariable1
        pha
        jsl rlGetLevelUpStats
        pla
        sta wRoutineVariable1

        lda #1
        plx
        plp
        plb
        clc
        
        -
        rtl

        _NoEXP
        lda #0
        sta wRoutineVariable1
        plx
        plp
        plb
        sec
        bra -

        .databank 0

      rlGetLevelUpStats ; 84/AABA

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        phy
        jsl rlGetSelectedUnitExtendedPersonalDataPointer
        lda structExtendedCharacterDataRAM.Level,b,x
        and #$00FF
        inc a
        cmp #31
        bcc +

          jml _End

        +
        sep #$20
        sta structExtendedCharacterDataRAM.Level,b,x
        rep #$20

        lda wTotalLevelUpCount
        inc a
        sta wTotalLevelUpCount

        sep #$20
        lda #$7E
        pha
        rep #$20
        plb

        ldy lRoutineVariable,b
        jsl rlGetSelectedUnitMaxHP
        sta structLevelUpStats.HP,b,y
        jsr rsApplyLevelUpHPGain
        sta structLevelUpStats.HPGain,b,y

        jsl rlGetSelectedUnitTotalStrengthEffect
        sta structLevelUpStats.Strength,b,y
        jsr rsApplyLevelUpStrengthGain
        sta structLevelUpStats.StrengthGain,b,y

        jsl rlGetSelectedUnitTotalMagicEffect
        sta structLevelUpStats.Magic,b,y
        jsr rsApplyLevelUpMagicGain
        sta structLevelUpStats.MagicGain,b,y

        jsl rlGetSelectedUnitTotalSkillEffect
        sta structLevelUpStats.Skill,b,y
        jsr rsApplyLevelUpSkillGain
        sta structLevelUpStats.SkillGain,b,y

        jsl rlGetSelectedUnitTotalSpeedEffect
        sta structLevelUpStats.Speed,b,y
        jsr rsApplyLevelUpSpeedGain
        sta structLevelUpStats.SpeedGain,b,y

        jsl rlGetSelectedUnitLuck
        sta structLevelUpStats.Luck,b,y
        jsr rsApplyLevelUpLuckGain
        sta structLevelUpStats.LuckGain,b,y

        jsl rlGetSelectedUnitTotalDefenseEffect
        sta structLevelUpStats.Defense,b,y
        jsr rsApplyLevelUpDefenseGain
        sta structLevelUpStats.DefenseGain,b,y

        jsl rlGetSelectedUnitTotalResistanceEffect
        sta structLevelUpStats.Resistance,b,y
        jsr rsApplyLevelUpResistanceGain
        sta structLevelUpStats.ResistanceGain,b,y
        
        _End
        ply
        plx
        plp
        plb
        rtl

        .databank 0

      rlAddWinToSelectedUnitAndWeapon ; 84/AB5C

        .al
        .autsiz
        .databank ?

        ; For player units: adds a kill to the weapon in inventory slot A and a win to
        ; the unit's entry in aUnitWinCounts (the second half is for chapter 6 on).

        phb
        php
        phk
        plb
        phx
        ldx wRoutineVariable1,b
        phx

        sta wRoutineVariable1,b
        jsl rlGetSelectedUnitFactionSlot
        ora #0
        bne _End

          lda wRoutineVariable1,b
          beq _End

            jsl rlGetItemRAMStructEntryByInventorySlot
            bcs _End

              lda #1
              jsl rlAddToItemRAMKillCount
              stz wRoutineVariable1,b

              lda wCurrentChapter,b
              cmp #6
              bcc +

                lda #24
                sta wRoutineVariable1,b

              +
              jsl rlGetSelectedUnitGenerationID
              dec a
              clc
              adc wRoutineVariable1,b
              asl a
              tax
              lda aUnitWinCounts,x
              inc a
              sta aUnitWinCounts,x

        _End
        pla
        sta wRoutineVariable1,b
        plx
        plp
        plb
        rtl

        .databank 0

        ; 84/ABB0

    .endsection ActionLevelUpSection


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

      rlDeploySelectedUnit ; 84/AEC0

        .al
        .autsiz
        .databank ?

        ; Sets UnitStateFielded and gives the unit a deployment slot, or updates the
        ; one it has.

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
          jsl rlMoveDeploymentToCoords
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
