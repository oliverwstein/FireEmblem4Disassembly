; Weapon traits and staff effects applied in battle (life steal, rescue, thief,
; Valkyrie, status), Sol healing, level-up and dropped-item results, and a
; percentage-chance roll.

    .section ActionStructStaffEffectRefreshSection

      .al
      .xl

      rsActionStructStaffEffectRefresh ; 84/EB24

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ; Unreferenced: aActionStructStaffEffects does not list it. Takes the staff's target out of the grayed state (DeploymentStateGrayed), so it can act again, sets wChapterFlags bit $04, and charges the staff's use like the other staff effects.

        ldx $CCD8,b
        ldy $CCDA,b
        lda #$0002
        tsb $CCDE,b
        jsr rsActionStructUseWeaponAndSteal
        phx
        lda $0000,b,y
        tax
        lda aDeploymentTable._StateBuffer,x
        and #$FFF7
        sta aDeploymentTable._StateBuffer,x
        lda #$0004
        tsb wChapterFlags,b
        plx
        lda $0006,b,x
        sta wSelectedUnitDataRAMPointer,b
        lda $0026,b,x
        and #$00FF
        jsl rlGetInventorySlotStaffCostValue
        sta $001A,b,x
        sep #$20
        lda #$00
        sta $7ECCDF
        rep #$20
        lda #$003A
        sta $4EB3,b
        clc
        rts

        .databank 0

        ; 84/EB6F

    .endsection ActionStructStaffEffectRefreshSection


    .section StaffEffectClearStatusSection

      .al
      .xl

      rsActionStructStaffEffectClearStatus ; 84/EB6F

        .al
        .xl
        .autsiz
        .databank ?

        ; Used by charm and restore. Clears the target's status and its duration.

        ldx $CCD8,b
        ldy $CCDA,b
        lda #$0002
        tsb $CCDE,b
        jsr rsActionStructUseWeaponAndSteal
        phx
        lda $0006,b,y
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitStatus
        cmp #StatusSleep
        bne _EBA1
        lda $0000,b,y
        tax
        lda $489B,b,x
        and #$DFFF
        sta $489B,b,x
        lda #$0004
        tsb wChapterFlags,b

        _EBA1
        plx
        lda #StatusHealthy
        jsl rlSetSelectedUnitStatus
        lda #$0000
        jsl rlSetSelectedUnitStatusDuration
        lda $0006,b,x
        sta wSelectedUnitDataRAMPointer,b
        lda $0026,b,x
        and #$00FF
        jsl rlGetInventorySlotStaffCostValue
        sta $001A,b,x
        sep #$20
        lda #$00
        sta $7ECCDF
        rep #$20
        lda #$003A
        sta $4EB3,b
        clc
        rts

        .databank 0

        ; 84/EBD5

      rsActionStructStaffEffectWarp ; 84/EBD5

        .al
        .xl
        .autsiz
        .databank ?

        ldx $CCD8,b
        ldy $CCDA,b
        lda #$0002
        tsb $CCDE,b
        jsr rsActionStructUseWeaponAndSteal
        lda $0006,b,y
        sta wSelectedUnitDataRAMPointer,b
        lda wTargetEventLocationEntry,b
        pha
        phx
        jsl rlGetSelectedUnitStates
        bit #UnitStateFielded
        bne _EC02
        lda #$FFFF
        sta wRoutineVariable1,b
        jsl rlDeploySelectedUnit

        _EC02
        lda $0006,b,y
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitFactionSlot
        jsl rlGetFactionSlotLocationID
        sta wBattleTempVariable
        lda $0000,b,y
        tax
        lda $7ECCCE
        sta wR0
        sta $7E4F77
        lda $7ECCD0
        sta wR1
        sta $7E4F79
        jsl rlCheckIfCoordsNotEventLocationTile
        bcs _EC46
        jsl rlGetEventLocationEntryID
        cmp wBattleTempVariable
        bne _EC46
        lda wBattleTempVariable
        jsl rlQueueUnitRelocationToCastle
        bra _EC56


        _EC46
        lda $7ECCD0
        xba
        ora $7ECCCE
        sta wRoutineVariable1,b
        jsl rlQueueRelocateUnitToCoords

        _EC56
        plx
        pla
        sta wTargetEventLocationEntry,b
        lda $0006,b,x
        sta wSelectedUnitDataRAMPointer,b
        lda $0026,b,x
        and #$00FF
        jsl rlGetInventorySlotStaffCostValue
        sta $001A,b,x
        sep #$20
        lda #$00
        sta $7ECCDF
        rep #$20
        lda #$003A
        sta $4EB3,b
        clc
        rts

        .databank 0

        ; 84/EC80

    .endsection StaffEffectClearStatusSection


    .section BattleEffectsSection

      .al
      .xl

      rsActionStructWeaponTraitLifeSteal ; 84/EC80

        .al
        .autsiz
        .databank `wActionStructAttacker

        ldx wActionStructAttacker
        ldy wActionStructDefender
        jsr rsSetBattleRoundRangedFlag

        sep #$20
        lda @l bBattleRoundFlags
        ora #$40
        sta @l bBattleRoundFlags
        rep #$20

        jsr rsActionStructRoundCheckIfHit
        bcc +

          jsr rsActionStructUseWeaponAndSteal
          lda structActionStructEntry.BattleBonusAtkDef,b,x
          sta wRoutineVariable1,b
          jsr rsActionStructRoundTryProcWrath
          jsr rsActionStructRoundTryProcCrit
          jsr rsActionStructRoundGetDamage
          jsr rsActionStructInflictDamageAndExp
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
        
        jsr rsActionStructUseWeaponAndSteal

        lda wChapterFlags,b
        bit #$0040
        bne _ED3A

        lda structActionStructEntry.UnitRAMPointer,b,x
        sta wSelectedUnitDataRAMPointer,b
        lda structActionStructEntry.XPosition,b,x
        sta @l aEventMovement.wDestinationXCoordinate
        lda structActionStructEntry.YPosition,b,x
        sta @l aEventMovement.wDestinationYCoordinate
        jsl rlGetSelectedUnitStates
        bit #UnitStateGuardingCastle
        beq +

          inc $C492,b
          inc $C492,b

        +
        lda structActionStructEntry.UnitRAMPointer,b,y
        sta wSelectedUnitDataRAMPointer,b
        jsl rlFindRescueDestinationTile
        bcc +

          jml _End
        
        +
        lda @l aEventMovement.wTargetYCoordinate
        xba
        ora @l aEventMovement.wTargetXCoordinate
        sta wRoutineVariable1,b

        phx
        lda structActionStructEntry.DeploymentNumber,b,y
        tax
        jsl rlQueueRelocateUnitToCoords
        plx
        jsr rsStopGuardingCastleIfGuarding

        lda @l aEventMovement.wTargetXCoordinate
        sta @l $7E4F77
        lda @l aEventMovement.wTargetYCoordinate
        sta @l $7E4F79
        phb
        phy
        jsl rlLoadMovingUnitSprite
        ply
        plb
        bra +

        _ED3A
        jsr rsStopGuardingCastleIfGuarding
        lda structActionStructEntry.DeploymentNumber,b,x
        sta wUnitRelocationDeploymentOffset,b
        lda #UNIT_RELOCATION_RESCUED
        sta wUnitRelocationType,b
        lda #0
        jsl rlGetFactionSlotLocationID
        sta wUnitRelocationLocationID,b
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

        lda aMapData,x
        and #$03FF
        tax
        lda aTerrainTileset,x
        and #$00FF
        sta structActionStructEntry.TerrainType,b,y
        plx

        lda structActionStructEntry.UnitRAMPointer,b,x
        sta wSelectedUnitDataRAMPointer,b
        lda structActionStructEntry.WeaponInventorySlot,b,x
        and #$00FF
        jsl rlGetInventorySlotStaffCostValue
        sta structActionStructEntry.GainedExperience,b,x

        sep #$20
        lda #0
        sta @l $7ECCDF
        rep #$20

        lda #SONG_BATTLE_STAFF
        sta wBattleSong
        clc
        
        _End
        rts

        .databank 0

      rsStopGuardingCastleIfGuarding ; 84/EDAE

        .al
        .autsiz
        .databank ?

        ; Clears UnitStateGuardingCastle if the selected unit is guarding a castle.

        jsl rlGetSelectedUnitStates
        bit #UnitStateGuardingCastle
        beq +

          jsl rlStopGuardingCastle

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
        jsr rsActionStructStealMoney

        lda structActionStructEntry.UnitRAMPointer,b,x
        sta wSelectedUnitDataRAMPointer,b
        lda structActionStructEntry.WeaponInventorySlot,b,x
        and #$00FF
        jsl rlGetInventorySlotStaffCostValue
        sta structActionStructEntry.GainedExperience,b,x
        
        sep #$20
        lda #0
        sta @l $7ECCDF
        rep #$20

        jsr rsSetStaffBattleSong

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
        jsr rsActionStructUseWeaponAndSteal

        lda structActionStructEntry.UnitRAMPointer,b,y
        sta wSelectedUnitDataRAMPointer,b
        jsl rlReviveSelectedCharacter

        lda structActionStructEntry.UnitRAMPointer,b,x
        sta wSelectedUnitDataRAMPointer,b
        lda structActionStructEntry.WeaponInventorySlot,b,x
        and #$00FF
        jsl rlGetInventorySlotStaffCostValue
        sta structActionStructEntry.GainedExperience,b,x

        lda structActionStructEntry.MaxHP,b,y
        sep #$20
        sta @l $7ECCDF
        rep #$20

        lda #SONG_BATTLE_VALKYRIE
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
        jsr rsActionStructUseWeaponAndSteal
        jsr rsActionStructInflictItemStatus

        lda structActionStructEntry.UnitRAMPointer,b,x
        sta wSelectedUnitDataRAMPointer,b
        lda structActionStructEntry.WeaponInventorySlot,b,x
        and #$00FF
        jsl rlGetInventorySlotStaffCostValue
        sta structActionStructEntry.GainedExperience,b,x
        
        +
        sep #$20
        lda #0
        sta @l $7ECCDF
        rep #$20

        jsr rsSetStaffBattleSong

        clc
        rts

        .databank 0

      rsSetStaffBattleSong ; 84/EE8F

        .al
        .autsiz
        .databank `aDeploymentTable

        phx
        lda structActionStructEntry.DeploymentNumber,b,x
        tax
        lda aDeploymentTable._State,x
        and #DeploymentAllegianceMask
        cmp #AllegianceEnemy
        beq +

        cmp #AllegianceNeutral
        beq +

        lda #SONG_BATTLE_PLAYER
        bra ++
        
        +
        lda #SONG_BATTLE_ENEMY
        
        +
        sta wBattleSong
        plx
        rts

        .databank 0

      rsActionStructInflictItemStatus ; 84/EEB1

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
        tsb wChapterFlags,b
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

      rsCaptureDefeatedUnitToCastle ; 84/EF13

        .al
        .autsiz
        .databank ?

        ; Relocates a defeated captive unit to the last chapter castle.

        phx
        jsl rlFindLastChapterCastleLocation
        jsl rlGetEventLocationEntryID
        sta wUnitRelocationLocationID,b
        lda $0000,b,y
        sta wUnitRelocationDeploymentOffset,b

        lda #UNIT_RELOCATION_CAPTURED
        sta wUnitRelocationType,b
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

      rlGetDefeatedUnitCharacterID ; 84/EFA5

        .al
        .autsiz
        .databank ?

        ; Returns the defeated combatant's character ID from wBattleStatus, or 0 if neither died.

        phb
        php

        sep #$20
        lda #$7E
        pha
        rep #$20
        plb

        lda wBattleStatus
        bit #$0010
        beq _EFCF

        lda wBattleStatus
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


    .section FindRescueDestinationTileSection

      .al
      .xl

      rlFindRescueDestinationTile ; 87/AF46

        .al
        .xl
        .autsiz
        .databank ?

        ; Finds the nearest valid tile around the caster for the Rescue staff.

        phb
        php
        phk
        plb
        .databank $87
        phx
        phy
        jsl rlGetSelectedUnitMovementCostPointer
        sta aEventMovement.wMovementCostPointer
        jsl rlFillEventMovementMoveCostMap
        lda #$007E
        ldx #$B448
        jsl rlClearMapBufferAddBorders
        ldx #$008E

        _AF65
        lda aDeploymentTable,x
        bit #$0080
        beq _AF85
        lda aDeploymentTable._XTilePosition,x
        sta aEventMovement.wTargetXCoordinate
        lda aDeploymentTable._YTilePosition,x
        sta aEventMovement.wTargetYCoordinate
        lda #$00FF
        jsl rlSetEventMovementTargetTile

        _AF85
        dec x
        dec x
        bpl _AF65
        jsl rlMaskRescueMovementCostMap
        lda aEventMovement.wDestinationXCoordinate
        sta aEventMovement.wStartingXCoordinate
        lda aEventMovement.wDestinationYCoordinate
        sta aEventMovement.wStartingYCoordinate
        lda #$0000
        sta aEventMovement.wTargetXCoordinate
        jsl rlEventMovementBuildTargetDistanceMap
        bcc _AFB0
        ply
        plx
        plp
        plb
        .databank ?
        clc
        rtl


        _AFB0
        ply
        plx
        plp
        plb
        .databank ?
        sec
        rtl

        .databank 0

        ; 87/AFB6

      rlMaskRescueMovementCostMap ; 87/AFB6

        .al
        .xl
        .autsiz
        .databank ?

        ; Marks area-restricted and impassable tiles as $FF in the Rescue movement cost map.

        phb
        php
        phk
        plb
        .databank $87
        phx
        phy
        ldy #$0FFF

        _AFBF
        tya
        asl a
        tax
        lda aMapData,x
        xba
        and #$00FC
        beq _AFD9
        sta aEventMovement.wStartingXCoordinate
        and wAreaRestrictionBitfield,b
        cmp aEventMovement.wStartingXCoordinate
        bne _B007

        _AFD9
        lda aMapData,x
        and #$03FF
        tax
        lda aTerrainTileset,x
        and #$00FF
        cmp #$000C
        beq _B007
        cmp #$0007
        bne _B013
        tya
        tax
        lda aEventMovement.aMovementCostMap,x
        and #$0080
        beq _B013
        sep #$20
        lda #$0A
        sta aEventMovement.aMovementCostMap,x
        rep #$20

        _B007
        tya
        tax
        sep #$20
        lda #$FF
        sta aEventMovement.aTargetMap,x
        rep #$20

        _B013
        dec y
        bpl _AFBF
        rep #$20
        ply
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 87/B01D

    .endsection FindRescueDestinationTileSection
