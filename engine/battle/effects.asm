; Weapon traits and staff effects applied in battle (life steal, rescue, thief,
; Valkyrie, status), Sol healing, level-up and dropped-item results, and a
; percentage-chance roll.

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
        jsl rlUnknown87AF46
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
        jsl rlUnknown84C9BF
        plx
        jsr rsUnknown84EDAE

        lda @l $7EC49A
        sta @l $7E4F77
        lda @l $7EC49C
        sta @l $7E4F79
        phb
        phy
        jsl rlUnknown88C9A6
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
        jsl rlUnknown84F99D
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

          jsl rlUnknown84BA6F

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
        jsl rlUnknown84F99D
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
        jsl rlUnknown84F99D
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
        jsl rlUnknown84F99D
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

    .endsection BattleEffectsSection
