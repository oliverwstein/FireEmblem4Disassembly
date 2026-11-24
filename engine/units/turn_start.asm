; Effects at the start of a turn: healing from status, skills and castles,
; castle healing costs, and curing status.

    .section GetTurnStartEffectsByStatusSection

      .al
      .xl

      rlGetTurnStartEffectsByStatus ; 84/AF9E

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        phy

        jsl rlGetSelectedUnitStates
        bit #UnitStateDead
        bne +

          jsl rlGetSelectedUnitStatus
          asl a
          tax
          jsr (aTurnStartEffectsByStatus,x)
        
        +
        ply
        plx
        plp
        plb
        rtl

        .databank 0

      aTurnStartEffectsByStatus ; 84/AFBB

        .word <>rsGetTurnStartNormalEffect
        .word <>rsGetTurnStartCuredEffect
        .word <>rsGetTurnStartFreelancerEffect
        .word <>rsGetTurnStartCaptiveEffect
        .word <>rsGetTurnStartNormalEffect
        .word <>rsGetTurnStartNormalEffect
        .word <>rsGetTurnStartNormalEffect

      rsGetTurnStartNormalEffect ; 84/AFC9

        .al
        .autsiz
        .databank ?

        ; For healthy, silence, sleep and berserk

        jsl rlGetSelectedUnitMaxHP
        sta wRoutineVariable1,b

        jsl rlGetSelectedUnitCurrentHP
        cmp wRoutineVariable1,b
        bcs _End

          jsr rsGetChurchHealing
          bcs +

            jsr rsGetRecoverHealing
            bcs +

              jsr rsGetInsideCastleHealing
              bcs +

                jsr rsGetGuardingCastleHealing
                bcs +

                  jsr rsGetRenewalHealing
                  bcs +
                  bra _End

          +
          jsl rlHealSelectedUnitsHP
        
        _End
        rts

        .databank 0

      rsGetRenewalHealing ; 84/AFF9

        .al
        .autsiz
        .databank ?

        lda #SkillIDRenewal
        jsl rlCheckIfUnitHasSpecifiedPersonalOrClassSkill
        bcs +

          lda #SkillIDRenewal
          jsl rlCheckIfInventoryItemsHaveSpecifiedSkill
          bcs +

            rts
        
        +
        lda #6
        jsl rlGetRandomNumber100
        clc
        adc #5
        sta wRoutineVariable1,b

        ldy #3
        jsr rsAddTurnStartHealingEntry
        sec
        rts

        .databank 0

      rsGetRecoverHealing ; 84/B022

        .al
        .autsiz
        .databank ?

        lda #SkillIDRecover
        jsl rlCheckIfUnitHasSpecifiedPersonalOrClassSkill
        bcs +

          lda #SkillIDRecover
          jsl rlCheckIfInventoryItemsHaveSpecifiedSkill
          bcs +

            rts
        
        +
        jsl rlGetSelectedUnitMaxHP
        sta wRoutineVariable1,b

        ldy #3
        jsr rsAddTurnStartHealingEntry
        sec
        rts

        .databank 0

      rsGetInsideCastleHealing ; 84/B044

        .al
        .autsiz
        .databank ?

        jsl rlGetSelectedUnitStates
        bit #UnitStateFielded
        beq +
        
          _CLC
          clc
          rts

        ; Inside a castle
        +
        jsl rlGetSelectedUnitFactionSlot
        ora #0
        bne +

          jsr rsGetCastleHealingAmount
          jsr rsGetCastleHealingCost
          bcs _CLC

            jsl rlSubtractSelectedCharacterMoney
            stx wRoutineVariable1,b
            sec
            rts
        
        +
        jsl rlGetSelectedUnitMaxHP
        sta wRoutineVariable1,b
        sec
        rts

        .databank 0

      rsGetGuardingCastleHealing ; 84/B072

        .al
        .autsiz
        .databank ?

        jsl rlGetSelectedUnitStates
        bit #UnitStateGuardingCastle
        bne +
        
          _CLC
          clc
          rts
        
        +
        jsr rsGetCastleHealingAmount
        jsr rsGetCastleHealingCost
        bcs _CLC

        jsl rlSubtractSelectedCharacterMoney
        stx wRoutineVariable1,b

        ldy #1
        jsr rsAddTurnStartHealingEntry
        sec
        rts

        .databank 0

    .endsection GetTurnStartEffectsByStatusSection


    .section GetChurchHealingSection

      .al
      .xl

      rsGetChurchHealing ; 84/B094

        .al
        .autsiz
        .databank ?

        jsl rlGetSelectedUnitDeploymentOffset
        jsl rlGetTerrainTypeByDeploymentOffset
        cmp #TerrainChurch
        beq +
        
          _CLC
          clc
          rts

        +
        jsl rlGetSelectedUnitCurrentHP
        sta wRoutineVariable1,b

        jsl rlGetSelectedUnitMaxHP
        sec
        sbc wRoutineVariable1,b
        sta wRoutineVariable1,b
        jsr rsGetCastleHealingCost
        bcs _CLC

        jsl rlSubtractSelectedCharacterMoney
        stx wRoutineVariable1,b

        ldy #2
        jsr rsAddTurnStartHealingEntry
        sec
        rts

        .databank 0

    .endsection GetChurchHealingSection


    .section GetCastleHealingAmountSection

      .al
      .xl

      rsGetCastleHealingAmount ; 84/B0C9

        .al
        .autsiz
        .databank ?

        ; Castle healing is 20% of max hp

        jsl rlGetSelectedUnitMaxHP
        xba
        sta $1A
        lda #100
        sta $1C
        jsl rlUnsignedDivide16By8

        lda $1A
        sta $14
        lda #20
        sta $16
        jsl rlUnsignedMultiply16By16

        lda $18
        xba
        and #$00FF
        sta wRoutineVariable1,b
        rts

        .databank 0

      rsGetCastleHealingCost ; 84/B0F0

        .al
        .autsiz
        .databank ?

        ldx wRoutineVariable1,b
        jsl rlGetSelectedUnitFactionSlot
        ora #0
        bne _End

          jsl rlGetSelectedUnitMoney
          cmp #5
          bcc _SEC

            sta $4204,b
            sep #$20
            lda #5
            sta $4206,b
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            rep #$20

            lda $4214,b
            sta $00
            lda $4216,b
            sta $02

            lda wRoutineVariable1,b
            asl a
            asl a
            clc
            adc wRoutineVariable1,b
            sta wRoutineVariable1,b

            jsl rlGetSelectedUnitMoney
            cmp wRoutineVariable1,b
            bcs _CLC

              sec
              sbc $02
              sta wRoutineVariable1,b
              ldx $00
              bra _CLC

        _End
        stz wRoutineVariable1,b
        
        _CLC
        clc
        rts
        
        _SEC
        sec
        rts

        .databank 0

      rsAddTurnStartHealingEntry ; 84/B148

        .al
        .autsiz
        .databank ?

        ; Records the unit (deployment slot, HP, maximum HP and the healing in
        ; wRoutineVariable1) in the turn start healing list (aTurnStartHealingList), unless its HP
        ; is full.

        phx
        lda wTurnStartHealingCount
        asl a
        asl a
        clc
        adc wTurnStartHealingCount
        tax
        cpx #$00FF
        bcs _End

          tya
          sta aTurnStartHealingList.bType,x

          jsl rlGetSelectedUnitDeploymentOffset
          sta aTurnStartHealingList.bDeploymentOffset,x

          jsl rlGetSelectedUnitCurrentHP
          sta aTurnStartHealingList.bCurrentHP,x

          jsl rlGetSelectedUnitMaxHP
          sep #$20
          sta aTurnStartHealingList.bMaxHP,x
          rep #$20

          cmp aTurnStartHealingList.bCurrentHP,x
          beq _End

            lda wRoutineVariable1,b
            sep #$20
            sta aTurnStartHealingList.bHealing,x
            rep #$20

            lda wTurnStartHealingCount
            inc a
            sta wTurnStartHealingCount
        
        _End
        plx
        rts

        .databank 0

      rsGetTurnStartCuredEffect ; 84/B197

        .al
        .autsiz
        .databank ?

        jsl rlDecreaseStatusDuration
        bcc +

          ; status ran out
          jsl rlGetSelectedUnitMaxHP
          jsl rlSetSelectedUnitCurrentHP

        +
        rts

        .databank 0

      rsGetTurnStartFreelancerEffect ; 84/B1A6

        .al
        .autsiz
        .databank ?

        jsl rlDecreaseStatusDuration
        bcc +

          ; Status ran out
          lda #3000
          sta wRoutineVariable1,b
          jsl rlAddSelectedCharacterMoney

        +
        rts

        .databank 0

      rsGetTurnStartCaptiveEffect ; 84/B1B7

        .al
        .autsiz
        .databank ?

        rts

        .databank 0

        ; 84/B1B8

    .endsection GetCastleHealingAmountSection


    .section RunTurnStartEffectsForAllUnitsInFactionSection

      .al
      .xl

      rlRunTurnStartEffectsForAllUnitsInFaction ; 84/C0D6

        .al
        .autsiz
        .databank ?

        ; A = FactionSlot

        phb
        php
        phk
        plb
        phx

        sta $04
        lda #0
        sta wTurnStartHealingShownOffset
        sta wTurnStartHealingCount

        ldx #1

          -
          stx wRoutineVariable1,b
          lda $04
          jsl rlGetUnitRAMDataPointerByFactionSlotEntryID
          lda wSelectedUnitDataRAMPointer,b
          beq +

            jsl rlGetTurnStartEffectsByStatus
            inc x
            bra -

        +
        plx
        plp
        plb
        rtl

        .databank 0

        ; 84/C104


      rlDecreaseFactionStatusDurations ; 84/C104

        .al
        .autsiz
        .databank ?

        ; For each unit of faction slot A: lowers its status duration and clears
        ; UnitStateMiracleActive.

        ; Ran for every unit in a faction, decrements status and unsets miracle.

        ; A = FactionSlot

        phb
        php
        phk
        plb
        phx
        phy
        tay

        ldx #1
        
          -
          stx wRoutineVariable1,b
          tya
          jsl rlGetUnitRAMDataPointerByFactionSlotEntryID

          lda wSelectedUnitDataRAMPointer,b
          beq +

            jsl rlDecreaseStatusDuration

            lda #UnitStateMiracleActive
            jsl rlUnsetSelectedUnitStates
            inc x
            bra -

        +
        ply
        plx
        plp
        plb
        rtl

        .databank 0

        ; 84/C12E


      rlUnsetFactionUnitsMoved ; 84/C12E

        .al
        .autsiz
        .databank ?

        ; For each unit of faction slot A: clears UnitStateMoved (and calls
        ; rlClearUnitGrayedState for its deployment slot).

        ; Unset grayed and moved status of all units in a faction?

        ; Input:
        ; A = FactionSlot

        phb
        php
        phk
        plb
        phx
        phy

        tay
        ldx #1
        
          -
          stx wRoutineVariable1,b
          tya
          jsl rlGetUnitRAMDataPointerByFactionSlotEntryID

          lda wSelectedUnitDataRAMPointer,b
          beq +

            phx
            jsl rlGetSelectedUnitDeploymentOffset
            tax
            jsl rlClearUnitGrayedState
            plx

            lda #UnitStateMoved
            jsl rlUnsetSelectedUnitStates
            inc x
            bra -

        +
        ply
        plx
        plp
        plb
        rtl

        .databank 0

        ; 84/C15F

    .endsection RunTurnStartEffectsForAllUnitsInFactionSection
