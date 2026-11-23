; Setting up and resolving a battle: the combatants' stats, battle music, boss checks,
; weapon triangle, leadership and charm, combat skills (vantage, accost, sword skills,
; dance), effectiveness, doubling, and each round's hit, crit and damage.
; First, from bank $81: starting a battle from the map, as a map battle with the
; animations off (rlStartMapBattle) or the battle scene (rlStartBattleScene).

    .section StartBattleFromMapSection

      .al
      .xl

      rlStartMapBattle ; 81/B35B

        .al
        .autsiz
        .databank ?

        ; A battle with the animations off: ends the unit's action and starts the map battle (rlStartMapBattleAnimation).

        jsl rlClearAIActionActiveFlag
        jsl rlEndUnitAction
        jsl rlStartMapBattleAnimation
        rtl

        .databank 0

      rlStartBattleScene ; 81/B368

        .al
        .autsiz
        .databank ?

        ; A battle with the animations on: stops the music and fades to the battle scene, or for battle type 0 starts the battle transition HDMA.

        lda #$00E0
        jsl rlSendSoundCommand

        stz wMapActionMode,b
        stz wGameStateRoutine1,b

        lda wBattleType
        and #$00FF
        cmp #0
        beq +

        lda #<>rsOpenBattleScene
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        bra ++

        +
        lda #(`aBattleTransitionHDMAInfo)<<8
        sta lR44+1
        lda #<>aBattleTransitionHDMAInfo
        sta lR44
        jsl rlHDMAEngineCreateEntry
        
        +
        rtl

        .databank 0

        ; 81/B3A6

    .endsection StartBattleFromMapSection


    .section BattleSection

      .al
      .xl

      rlGetUnitsDistance ; 84/D4C7

        .al
        .autsiz
        .databank ?

        ; Input:
        ; wR0 = Unit 1 deployment offset
        ; wR1 = Unit 2 deployment offset

        ; Output:
        ; A = distance

        phx
        ldx wR0
        lda aDeploymentTable._XTilePosition,x
        ldx wR1
        sec
        sbc aDeploymentTable._XTilePosition,x
        bpl +

          eor #$FFFF
          inc a

        +
        sta wR17

        ldx wR0
        lda aDeploymentTable._YTilePosition,x
        ldx wR1
        sec
        sbc aDeploymentTable._YTilePosition,x
        bpl +
        
          eor #$FFFF
          inc a

        +
        clc
        adc wR17
        plx
        rtl

        .databank 0

      rlCheckIfTargetBelongsToOwnFaction ; 84/D4F5

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = deployment offset

        phx
        tax
        lda aDeploymentTable._FactionSlot,x
        tax
        jsl rlGetSelectedUnitFactionSlot
        jsl rlGetFactionRelation
        cmp #AllegianceOwn
        bne +

          plx
          sec
          rtl

        +
        plx
        clc
        rtl

        .databank 0

      rlCheckIfDeployedUnitIsFriendly ; 84/D50F

        .al
        .autsiz
        .databank ?

        ; Input: A = deployment number.
        ; Output: carry set if that unit's faction is the selected unit's own
        ; faction or allied with it (AllegianceOwn, AllegianceAllied). Healing
        ; and status staffs use it to pick targets.

        phx
        tax
        lda aDeploymentTable._FactionSlot,x
        tax
        jsl rlGetSelectedUnitFactionSlot
        jsl rlGetFactionRelation
        cmp #AllegianceEnemy
        beq +

          cmp #AllegianceNeutral
          beq +

            plx
            sec
            rtl

        +
        plx
        clc
        rtl

        .databank 0

      rlCheckIfDeployedUnitIsEnemy ; 84/D52E

        .al
        .autsiz
        .databank ?

        ; Input: A = deployment number.
        ; Output: carry set if that unit's faction is an enemy (AllegianceEnemy) of the
        ; selected unit's faction.

        phx
        tax
        lda aDeploymentTable._FactionSlot,x
        tax
        jsl rlGetSelectedUnitFactionSlot
        jsl rlGetFactionRelation
        cmp #AllegianceEnemy
        bne _CLC

        plx
        sec
        rtl
        
        _CLC
        plx
        clc
        rtl

        .databank 0


      rlActionStructGetBattleStats ; 84/D548

        .al
        .autsiz
        .databank `wActionStructAttackerDeploymentNumber

        phb
        php

        sep #$20
        lda #`wActionStructAttackerDeploymentNumber
        pha
        rep #$20
        plb

        phx
        phy
        lda wR0
        sta @l wActionStructAttackerDeploymentNumber
        lda wR1
        sta @l wActionStructDefenderDeploymentNumber
        lda wR2
        sta @l $7ECCCE
        lda wR3
        sta @l $7ECCD0

        ldx #$017B
        sep #$20
        lda #0
        
          -
          sta wBattleType,x
          dec x
          bpl -

        rep #$20

        lda #$FFFF
        sta aActionStructUnit2.ObtainedItem
        sta aActionStructUnit1.ObtainedItem

        ldx wActionStructAttackerDeploymentNumber
        lda aDeploymentTable._State,x
        and #DeploymentAllegianceMask
        cmp #AllegianceOwn
        beq +

        cmp #AllegianceAllied
        beq +

        ldx wActionStructDefenderDeploymentNumber
        bmi +

        lda aDeploymentTable._State,x
        and #DeploymentAllegianceMask
        cmp #AllegianceEnemy
        beq +

        cmp #AllegianceNeutral
        beq +

        .databank ?

        lda wActionStructDefenderDeploymentNumber
        sta wActionStructUnit1DeploymentNumber
        lda wActionStructAttackerDeploymentNumber
        sta wActionStructUnit2DeploymentNumber
        lda #2+1
        bra ++

        +
        lda wActionStructAttackerDeploymentNumber
        sta wActionStructUnit1DeploymentNumber
        lda wActionStructDefenderDeploymentNumber
        sta wActionStructUnit2DeploymentNumber
        lda #0

        +
        sep #$20
        sta wBattleStatus
        rep #$20

        ldx #<>aActionStructUnit1
        lda wActionStructUnit1DeploymentNumber
        jsl rsActionStructGetBattleCoordinates

        ldx #<>aActionStructUnit2
        lda wActionStructUnit2DeploymentNumber
        jsl rsActionStructGetBattleCoordinates

        jsl rlGetBattleDistance

        lda wBattleStatus
        and #$0001
        sta wR0
        ldx #<>aActionStructUnit1
        jsl rlActionStructGetBasicBattleData

        lda wBattleStatus
        and #$0001
        eor #$0001
        sta wR0
        ldx #<>aActionStructUnit2
        jsl rlActionStructGetBasicBattleData

        jsr rsActionStructGetBattleTriggerableSkillFlags
        jsr rsBattleHandleEffectiveness
        jsl rlGetBattleSong

        lda wActionStructUnit1DeploymentNumber
        bmi +

        lda wActionStructUnit2DeploymentNumber
        bmi +

          lda wBattleStatus
          and #$0001
          sta wR0
          ldx #<>aActionStructUnit1
          ldy #<>aActionStructUnit2
          jsl rlApplyWeaponTriangleBonus

          lda wBattleStatus
          and #$0001
          eor #$0001
          sta wR0
          ldx #<>aActionStructUnit2
          ldy #<>aActionStructUnit1
          jsl rlApplyWeaponTriangleBonus

          ldy #<>aActionStructUnit1
          jsl rlApplyCharmAndLeadershipHitAvoidBonus
          ldy #<>aActionStructUnit2
          jsl rlApplyCharmAndLeadershipHitAvoidBonus

        +
        lda wBattleStatus
        and #$0001
        sta wR0
        ldx #<>aActionStructUnit1
        ldy #<>aActionStructUnit2
        jsl rlActionStructAdjustFinalStats

        lda wBattleStatus
        and #$0001
        eor #$0001
        sta wR0
        ldx #<>aActionStructUnit2
        ldy #<>aActionStructUnit1
        jsl rlActionStructAdjustFinalStats

        ply
        plx
        plp
        plb
        rtl

        .databank 0

      rlGetBattleSong ; 84/D694

        .al
        .autsiz
        .databank `wActionStructAttackerDeploymentNumber

        jsr rsCheckForSeliphJuliaVSJuliusFight
        bcs _Julius

        ldx wActionStructUnit2DeploymentNumber
        jsr rsCheckIfFightingJulia
        bcs _Julia

        jsr rsCheckIfFightingArvis
        bcs _Arvis

        jsr rsCheckIfFightingMajorBoss
        bcs _MajorBoss

        jsr rsCheckIfFightingRecruitableEnemy
        bcs _RecruitableEnemy

        jsr rsCheckIfFightingBoss
        bcs _Boss

        ldx wActionStructAttackerDeploymentNumber
        lda aDeploymentTable._State,x
        and #DeploymentAllegianceMask
        cmp #AllegianceEnemy
        beq _EnemyAttack

        cmp #AllegianceNeutral
        beq _EnemyAttack

        ; Player attack
        lda #SONG_BATTLE_PLAYER
        bra _End
        
        _EnemyAttack
        lda #SONG_BATTLE_ENEMY
        bra _End
        
        _RecruitableEnemy
        lda #SONG_BATTLE_RECRUITABLE
        bra _End

        _Boss
        lda #SONG_BATTLE_BOSS
        bra _End
        
        _MajorBoss
        lda #SONG_BATTLE_MAJOR_BOSS
        bra _End
        
        _Arvis
        lda #SONG_BATTLE_ARVIS
        bra _End

        _Julia
        lda #SONG_BATTLE_JULIA
        bra _End
        
        _Julius
        lda #SONG_BATTLE_JULIUS

        _End
        sta wBattleSong
        rtl

        .databank 0

      rsCheckIfFightingRecruitableEnemy ; 84/D6F2

        .al
        .autsiz
        .databank `aDeploymentTable

        lda aDeploymentTable._State,x
        and #DeploymentAllegianceMask
        cmp #1
        bne rsCheckIfFightingBoss._CLC

        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetUnitType
        cmp #UnitTypeHoly
        bcs rsCheckIfFightingBoss._CLC

        jsl rlGetSelectedUnitGenerationID
        sta wRoutineVariable1,b

        lda #0
        jsl rlFindGenerationIDInFactionSlotData
        lda wSelectedUnitDataRAMPointer,b
        bne rsCheckIfFightingBoss._CLC
        bra rsCheckIfFightingBoss._SEC

        .databank 0

      rsCheckIfFightingBoss ; 84/D721

        .al
        .autsiz
        .databank `aDeploymentTable

        lda aDeploymentTable._State,x
        and #DeploymentAllegianceMask
        cmp #1
        bne _CLC

          lda @l aActionStructUnit2.CharacterID
          jsl rlGetCharacterPortraitDataID
          cmp #$00F3
          bne _SEC

        _CLC
        clc
        rts
        
        _SEC
        sec
        rts

        .databank 0

      rsCheckIfFightingMajorBoss ; 84/D73D

        .al
        .autsiz
        .databank ?

        lda aActionStructUnit2.CharacterID
        cmp #ChagallCh02
        beq rsCheckIfFightingBoss._SEC

        cmp #EldiganCh03
        beq rsCheckIfFightingBoss._SEC

        cmp #ChagallCh03
        beq rsCheckIfFightingBoss._SEC

        cmp #LombardCh05
        beq rsCheckIfFightingBoss._SEC

        cmp #TravantCh05
        beq rsCheckIfFightingBoss._SEC

        cmp #ReptorCh05
        beq rsCheckIfFightingBoss._SEC

        cmp #Danann
        beq rsCheckIfFightingBoss._SEC

        cmp #BloomCh07
        beq rsCheckIfFightingBoss._SEC

        cmp #IshtarCh08
        beq rsCheckIfFightingBoss._SEC

        cmp #BloomCh08
        beq rsCheckIfFightingBoss._SEC

        cmp #TravantCh09
        beq rsCheckIfFightingBoss._SEC

        cmp #ArionCh09
        beq rsCheckIfFightingBoss._SEC

        cmp #HildaCh10
        beq rsCheckIfFightingBoss._SEC

        cmp #IshtarCh10
        beq rsCheckIfFightingBoss._SEC

        cmp #Brian
        beq rsCheckIfFightingBoss._SEC

        cmp #HildaChFinal
        beq rsCheckIfFightingBoss._SEC

        cmp #Manfroy
        beq rsCheckIfFightingBoss._SEC

        cmp #ArionChFinal
        beq rsCheckIfFightingBoss._SEC

        cmp #IshtarChFinal
        beq rsCheckIfFightingBoss._SEC

        cmp #JuliusChFinal
        beq rsCheckIfFightingBoss._SEC
        bra rsCheckIfFightingBoss._CLC

        .databank 0

      rsCheckIfFightingArvis ; 84/D7A7

        .al
        .autsiz
        .databank ?

        lda aActionStructUnit2.CharacterID
        cmp #ArvisCh10
        beq rsCheckIfFightingBoss._SEC
        bra rsCheckIfFightingBoss._CLC

        .databank 0

      rsCheckIfFightingJulia ; 84/D7B2

        .al
        .autsiz
        .databank ?

        lda aActionStructUnit2.CharacterID
        cmp #Julia
        beq rsCheckIfFightingBoss._SEC
        jml rsCheckIfFightingBoss._CLC

        .databank 0

      rsCheckForSeliphJuliaVSJuliusFight ; 84/D7BF

        .al
        .autsiz
        .databank ?

        lda aActionStructUnit1.CharacterID
        cmp #Seliph
        beq +

        cmp #Julia
        bne _CLC

        +
        lda aActionStructUnit2.CharacterID
        cmp #JuliusCh10
        beq _SEC

        cmp #JuliusChFinal
        beq _SEC

        _CLC
        clc
        rts
        
        _SEC
        sec
        rts

        .databank 0

      rsActionStructGetBattleCoordinates ; 84/D7DF

        .al
        .autsiz
        .databank `aDeploymentTable

        sta structActionStructEntry.DeploymentNumber,b,x
        bmi _End

        tay
        lda aDeploymentTable._UnitRAMPointer,y
        sta structActionStructEntry.UnitRAMPointer,b,x
        sta wSelectedUnitDataRAMPointer,b

        lda aDeploymentTable._XTilePosition,y
        sta structActionStructEntry.XPosition,b,x
        lda aDeploymentTable._YTilePosition,y
        sta structActionStructEntry.YPosition,b,x

        jsl rlGetSelectedUnitStates
        bit #UnitState0400
        beq _End

        bit #UnitStateGuardingCastle
        bne +

        ; attacker gets shifted up a tile
        dec structActionStructEntry.YPosition,b,x
        bra ++

        ; defender one down
        +
        inc structActionStructEntry.YPosition,b,x
        lda #8
        tsb wBattleStatus
        
        +
        lda #4
        tsb wBattleStatus

        _End
        rtl

        .databank 0

      rlActionStructGetBasicBattleData ; 84/D81D

        .al
        .autsiz
        .databank ?

        lda structActionStructEntry.DeploymentNumber,b,x
        bpl +

          jml _End
        
        +
        tay
        lda structActionStructEntry.UnitRAMPointer,b,x
        sta wSelectedUnitDataRAMPointer,b

        jsl rlGetSelectedUnitCharacterID
        sta structActionStructEntry.CharacterID,b,x

        jsl rlGetSelectedUnitClassID
        sta structActionStructEntry.ClassID,b,x

        jsl rlGetSelectedUnitGender
        sta structActionStructEntry.Gender,b,x

        tya
        jsl rlGetTerrainTypeByDeploymentOffset
        sta structActionStructEntry.TerrainType,b,x

        jsl rlGetSelectedUnitCurrentHP
        sta structActionStructEntry.CurrentHP,b,x

        jsl rlGetSelectedUnitMaxHP
        sta structActionStructEntry.MaxHP,b,x

        jsl rlGetSelectedUnitLevel
        sta structActionStructEntry.Level,b,x

        lda #0
        sta structActionStructEntry.GainedLevels,b,x

        jsl rlGetSelectedUnitExperience
        sta structActionStructEntry.StartingExperience,b,x

        lda #0
        sta structActionStructEntry.GainedExperience,b,x

        lda wR0
        beq +

        jsr rsActionStructGetEnemyAutoCounterWeapon
        bra ++
        
        +
        lda wSelectedInventorySlot,b

        +
        sta structActionStructEntry.WeaponInventorySlot,b,x

        cmp #0
        bne +

          lda #$FFFF
          sta structActionStructEntry.WeaponID,b,x
          stz wCurrentItemDataROMPointer,b
          bra ++

        +
        jsl rlGetItemIDByInventorySlot
        sta structActionStructEntry.WeaponID,b,x

        jsr rsGetBattleRangedAlternateWeapon

        jsl rlGetItemMinimumRange
        sta structActionStructEntry.WeaponMinRange,b,x

        jsl rlGetItemMaximumRange
        sta structActionStructEntry.WeaponMaxRange,b,x

        jsl rlGetItemWeaponType
        sta structActionStructEntry.WeaponType,b,x

        +
        jsl rlGetSelectedUnitBattleAttackSpeed
        sta structActionStructEntry.BattleAttackSpeed,b,x

        jsl rlGetSelectedUnitBattleHit
        sta structActionStructEntry.BattleHit,b,x

        lda structActionStructEntry.TerrainType,b,x
        jsl rlGetSelectedUnitBattleAvoid
        sta structActionStructEntry.BattleAvoid,b,x

        jsl rlGetSelectedUnitBattleCrit
        sta structActionStructEntry.BattleCrit,b,x

        _End
        rtl

        .databank 0

      rsActionStructGetEnemyAutoCounterWeapon ; 84/D8D0

        .al
        .autsiz
        .databank ?

        jsl rlGetSelectedUnitFactionSlot
        ora #0
        bne +

          jsl rlGetFirstEquippableWeaponInInventory
          rts
        
        +
        lda wBattleDistance
        jsl rlGetCounterableWeaponSlot
        rts

        .databank 0

      rlGetBattleDistance ; 84/D8E7

        .al
        .autsiz
        .databank `aActionStructUnit1

        lda aActionStructUnit1.DeploymentNumber
        bmi _D917

        lda aActionStructUnit2.DeploymentNumber
        bmi _D917

        lda aActionStructUnit1.XPosition
        sec
        sbc aActionStructUnit2.XPosition
        bpl +

          eor #$FFFF
          inc a

        +
        sta wBattleDistance

        lda aActionStructUnit1.YPosition
        sec
        sbc aActionStructUnit2.YPosition
        bpl +

          eor #$FFFF
          inc a

        +
        clc
        adc @l wBattleDistance
        sta wBattleDistance
        rtl

        _D917
        lda #1
        sta wBattleDistance
        rtl

        .databank 0

      rlApplyWeaponTriangleBonus ; 84/D91E

        .al
        .autsiz
        .databank ?

        lda structActionStructEntry.WeaponID,b,x
        bmi +

        lda structActionStructEntry.WeaponType,b,x
        sta wRoutineVariable1,b

        lda structActionStructEntry.WeaponID,b,y
        bmi +

        lda structActionStructEntry.WeaponType,b,y
        xba
        ora wRoutineVariable1,b
        jsl rlGetWeaponTriangleBonus

        ora #0
        beq +

          sta wRoutineVariable1,b

          lda structActionStructEntry.BattleHit,b,x
          clc
          adc wRoutineVariable1,b
          sta structActionStructEntry.BattleHit,b,x

          lda structActionStructEntry.BattleAvoid,b,x
          clc
          adc wRoutineVariable1,b
          sta structActionStructEntry.BattleAvoid,b,x

        +
        rtl

        .databank 0

      rlApplyCharmAndLeadershipHitAvoidBonus ; 84/D956

        .al
        .autsiz
        .databank ?

        ldx structActionStructEntry.DeploymentNumber,b,y
        jsl rlGetTotalCharmAndLeadershipBonus
        sta $7ECCE4

        jsr rsActionStructAddLeadershipBonus

        lda $7ECCE4
        clc
        adc structActionStructEntry.BattleHit,b,y
        sta structActionStructEntry.BattleHit,b,y

        lda $7ECCE4
        clc
        adc structActionStructEntry.BattleAvoid,b,y
        sta structActionStructEntry.BattleAvoid,b,y
        rtl

        .databank 0

      rsActionStructAddLeadershipBonus ; 84/D97B

        .al
        .autsiz
        .databank ?

        ; Adds the leadership bonus for the unit's leadership stars to $7ECCE4 if the
        ; unit is Sigurd, Seliph or a group leader.

        phx
        lda structActionStructEntry.UnitRAMPointer,b,y
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitCharacterID
        cmp #Sigurd
        beq +

        cmp #Seliph
        beq +

        jsl rlGetSelectedUnitStates
        bit #UnitStateGroupLeader
        beq ++

        +
        jsl rlGetSelectedUnitLeadershipStars
        tax
        lda aLeaderShipBonusTable,x
        and #$00FF
        clc
        adc $7ECCE4
        sta $7ECCE4
        
        +
        plx
        rts

        .databank 0

      aLeaderShipBonusTable ; 84/D9B0

        .byte  0
        .byte  0
        .byte 10
        .byte 20
        .byte 30
        .byte 40

      rlActionStructAdjustFinalStats ; 84/D9B6

        .al
        .autsiz
        .databank $7E

        lda wR0
        beq _D9FF

        lda structActionStructEntry.WeaponInventorySlot,b,y
        beq +

        lda structActionStructEntry.WeaponID,b,y
        jsl rlGetItemDataROMPointer
        jsl rlGetItemEquipmentType
        cmp #EquipTypeWeapon
        bne +

        jsl rlGetItemWeaponTraits
        cmp #WeaponTraitUncounterable
        bne _D9FF

        lda #0
        sta structActionStructEntry.WeaponInventorySlot,b,x
        bra _DA0B

        +
        lda #0
        sta structActionStructEntry.WeaponInventorySlot,b,x
        lda #$00FF
        sta structActionStructEntry.BattleMight,b,x
        sta structActionStructEntry.BattleDefense,b,x
        sta structActionStructEntry.BattleAdjustedHit,b,x
        sta structActionStructEntry.BattleMight,b,y
        sta structActionStructEntry.BattleDefense,b,y
        sta structActionStructEntry.BattleAdjustedHit,b,y
        jml _End

        _D9FF
        lda structActionStructEntry.BattleMight,b,x
        cmp #$00FF
        bne _DA0B

          jml _End
        
        _DA0B
        lda structActionStructEntry.UnitRAMPointer,b,x
        bne +

          jml _End

        +
        sta wSelectedUnitDataRAMPointer,b

        lda structActionStructEntry.WeaponID,b,x
        jsr rsGetBattleRangedAlternateWeapon
        jsl rlGetSelectedUnitBattleMight
        sta structActionStructEntry.BattleMight,b,x

        jsr rsSetHalvedBattleMight

        lda structActionStructEntry.WeaponID,b,y
        bmi +

        jsr rsGetBattleRangedAlternateWeapon
        jsl rlGetItemWeaponType
        cmp #WeaponTypeStaff
        bcs ++
        
        +
        lda structActionStructEntry.WeaponID,b,x
        jsl rlGetItemDataROMPointer
        jsl rlGetSelectedUnitBattleDefense
        bra ++
        
        +
        lda structActionStructEntry.WeaponID,b,x
        jsl rlGetItemDataROMPointer
        jsl rlGetSelectedUnitBattleResistance

        +
        sta structActionStructEntry.BattleDefense,b,x

        lda structActionStructEntry.BattleHit,b,x
        sec
        sbc structActionStructEntry.BattleAvoid,b,y
        cmp #0
        bmi _FloorHit

        cmp #101
        bpl _CapHit
        bra +
        
        _FloorHit
        lda #0
        bra +
        
        _CapHit
        lda #100

        +
        sta structActionStructEntry.BattleAdjustedHit,b,x

        lda @l wActionStructAttackerDeploymentNumber
        cmp structActionStructEntry.DeploymentNumber,b,x
        bne _End

        sta wR10
        lda @l wActionStructDefenderDeploymentNumber
        sta wR11
        jsl rlActionStructGetScriptedCritPossibility
        sta wBattleCriticalType
        ora #0
        beq _End

          phx
          dec a
          tax
          lda aUnknown84DAE8,x
          and #$00FF
          sta $4F77,b

          lda aAIAction.wMapPointer
          jsr rsGetUnitCoordinatesByDeploymentNumber
          lda wR10
          sta $4F79,b
          lda wR11
          sta $4F7B,b

          lda aAIAction.wUnknown7F442C
          cmp #$00FF
          beq +

            jsr rsGetUnitCoordinatesByDeploymentNumber
            lda wR10
            sta $4F7D,b
            lda wR11
            sta $4F7F,b

          +
          lda aScriptedCritChanceBoosts,x
          and #$00FF
          plx

          clc
          adc structActionStructEntry.BattleCrit,b,x
          cmp #101
          bcc +

            lda #100

          +
          sta structActionStructEntry.BattleCrit,b,x
        
        _End
        rtl

        .databank 0

      rsGetUnitCoordinatesByDeploymentNumber ; 84/DADA

        .al
        .autsiz
        .databank `aDeploymentTable

        phx
        tax
        lda aDeploymentTable._XTilePosition,x
        sta wR10
        lda aDeploymentTable._YTilePosition,x
        sta wR11
        plx
        rts

        .databank 0

      aUnknown84DAE8 ; 84/DAE8

        ; scripted crit types?

        .byte $01 ; sibling
        .byte $01 ; lover
        .byte $02 ; triangle attack
        .byte $02 ; ?

      aScriptedCritChanceBoosts ; 84/DAEC

        .byte 20
        .byte 20
        .byte 100
        .byte 100

      rsSetHalvedBattleMight ; 84/DAF0

        .al
        .autsiz
        .databank ?

        lda structActionStructEntry.WeaponID,b,x
        bmi _End

        jsl rlGetItemDataROMPointer
        jsl rlGetItemWeaponTraits
        cmp #WeaponTraitNegateHalveAttack
        bne +

        jsl rlGetItemAdditionalInfo
        cmp structActionStructEntry.WeaponID,b,y
        beq _End
        
        +
        lda structActionStructEntry.WeaponID,b,y
        bmi _End

        jsl rlGetItemDataROMPointer
        jsl rlGetItemWeaponTraits
        cmp #WeaponTraitHalveAttack
        bne _End

        lda structActionStructEntry.BattleMight,b,x
        lsr a
        sta structActionStructEntry.BattleMight,b,x
        
        _End
        rts

        .databank 0

      rsGetBattleRangedAlternateWeapon ; 84/DB25

        .al
        .autsiz
        .databank `wBattleDistance

        ; A = item ID

        cmp #0
        bmi _DB4D

        jsl rlGetItemDataROMPointer
        jsl rlGetItemWeaponTraits
        cmp #WeaponTraitRangedMagicSword
        beq +

        cmp #WeaponTraitPermanentMagicSword
        bne _End
        
        +
        lda wBattleDistance
        cmp #2
        bcc _End

        jsl rlGetItemAdditionalInfo
        jsl rlGetItemDataROMPointer
        
        _End
        rts
        
        _DB4D
        stz wCurrentItemDataROMPointer,b
        bra _End

        .databank 0

      rlGetTotalCharmAndLeadershipBonus ; 84/DB52

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

        stx wR0
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitLoverGenerationID
        sta wR3
        jsl rlUnknown849FC4
        sta wR4

        lda aDeploymentTable._FactionSlot,x
        sta wR5
        stz wR2
        ldx #(len(aDeploymentTable._State) - 2)
        
        -
        lda aDeploymentTable._State,x
        bit #DeploymentStateAlive
        beq +

          stx wR1
          jsl rlGetUnitsDistance
          cmp #0
          beq +

            cmp #4
            bcs +

              ; get unit within 3 tiles
              phx
              lda aDeploymentTable._FactionSlot,x
              tax
              lda wR5
              jsl rlGetFactionRelation
              plx
              cmp #AllegianceEnemy
              beq +

                lda aDeploymentTable._UnitRAMPointer,x
                sta wSelectedUnitDataRAMPointer,b

                jsr rsGetCharmBonus
                jsr rsGetUnit1LeadershipBonus
                jsr rsGetUnit2LeadershipBonus

        +
        dec x
        dec x
        bpl -

        lda wR2

        plx
        stx wR0
        plx
        stx wR1
        ply
        plx
        plp
        plb
        rtl

        .databank 0

      rsGetCharmBonus ; 84/DBCA

        .al
        .autsiz
        .databank ?

        lda #SkillIDCharm
        jsl rlCheckIfUnitHasSpecifiedPersonalOrClassSkill
        bcs +

        lda #SkillIDCharm
        jsl rlCheckIfInventoryItemsHaveSpecifiedSkill
        bcc rsGetUnit2LeadershipBonus._SEC
        
        +
        lda #10
        bra rsGetUnit2LeadershipBonus._CLC

        .databank 0

      rsGetUnit1LeadershipBonus ; 84/DBE1

        .al
        .autsiz
        .databank ?

        lda wR3
        beq rsGetUnit2LeadershipBonus._SEC

        jsl rlGetSelectedUnitGenerationID
        bcs rsGetUnit2LeadershipBonus._SEC

        cmp wR3
        bne rsGetUnit2LeadershipBonus._SEC

        lda #10
        bra rsGetUnit2LeadershipBonus._CLC

        .databank 0

      rsGetUnit2LeadershipBonus ; 84/DBF4

        .al
        .autsiz
        .databank `_LeadershipBonus

        lda wR4
        beq _SEC

        jsl rlGetSelectedUnitCharacterID
        cmp wR4
        bne _SEC

        jsl rlGetSelectedUnitLeadershipStars
        tay
        lda _LeadershipBonus,y
        and #$00FF
        bra _CLC

          _LeadershipBonus
          .byte 0
          .byte 0
          .byte 10
          .byte 20
          .byte 30
          .byte 40

        _CLC
        clc
        adc wR2
        sta wR2
        clc
        rts
        
        _SEC
        sec
        rts

        .databank 0

      rlRunMapAction ; 84/DC1C

        .al
        .autsiz
        .databank ?

        ; Runs the chosen action by wMapActionTargetType (aMapActionRoutines) with wR0 = the acting unit and wR1 = the target, then clears the type.

        phb
        php
        phk
        plb
        phx
        lda $00
        pha
        lda $02
        pha

        lda wMapActionTargetType,b
        asl a
        tax
        jsr (aMapActionRoutines,x)

        lda #MAP_ACTION_BATTLE
        sta wMapActionTargetType,b

        pla
        sta $02
        pla
        sta $00
        plx
        plp
        plb
        rtl

        .databank 0

      aMapActionRoutines ; 84/DC3F

        .word <>rsMapActionBattle
        .word <>rsMapActionBattle
        .word <>rsMapActionHelp
        .word <>rsMapActionGiveGold
        .word <>rsMapActionTalk

      rsMapActionBattle ; 84/DC49

        .al
        .autsiz
        .databank ?

        ; Types 0 and 1 (attack, staff): builds the battle (battle type 3 while bit 5 of wChapterFlags is set, else 0) and its rounds.

        jsl rlActionStructGetBattleStats

        lda wChapterFlags,b
        bit #$0020

        sep #$20
        bne +

        lda #0
        sta wBattleType
        bra ++
        
        +
        lda #3
        sta wBattleType
        
        +
        rep #$20
        
        lda wActionStructAttackerDeploymentNumber
        tax
        lda aDeploymentTable._FactionSlot,x
        bne +

          lda aDeploymentTable._UnitRAMPointer,x
          sta wSelectedUnitDataRAMPointer,b
          jsl rlUnknown84B321

        +
        jsl rlActionStructBuildBattleRounds
        rts

        .databank 0

      rsMapActionHelp ; 84/DC82

        .al
        .autsiz
        .databank ?

        ; Type 2 (help): ends the unit's action and runs rlUnitHelp.

        ldx $00
        jsl rlEndUnitAction
        jsl rlUnitHelp
        rts

        .databank 0

      rsMapActionGiveGold ; 84/DC8D

        .al
        .autsiz
        .databank ?

        ; Type 3 (give gold): ends the unit's action, runs rlUnitGiveGold and shows the gold scene.

        jsl rlEndUnitAction
        jsl rlUnitGiveGold
        jsl rlStartGiveGoldAnimation
        rts

        .databank 0

      rsMapActionTalk ; 84/DC9A

        .al
        .autsiz
        .databank ?

        ; Type 4 (talk).

        jsl rlEndUnitAction
        jsl rlUnitTalk
        rts

        .databank 0

      rlActionStructBuildBattleRounds ; 84/DCA3

        .al
        .autsiz
        .databank `aBattleRoundsData

        phb
        php

        sep #$20
        lda #`aBattleRoundsData
        pha
        rep #$20
        plb

        phx
        phy
        lda #(`aBattleRoundsData)<<8
        sta lR18+1
        lda #<>aBattleRoundsData
        sta lR18
        lda #len(aBattleRoundsData._Entry)
        sta wR0
        lda #size(aBattleRoundsData._Entry[0])
        sta wR1
        jsl rlBuildRAMStructHeader

        stz $CCE0,b

        ; Get initiator. 0=player 1=opponent
        lda @l wBattleStatus
        and #$0001
        sta @l wBattleAttackerIndex

        jsr rsActionStructGetBattleInitiatorIfArena

        lda wChapterFlags,b
        bit #$0010
        bne _Loop

          lda #$0010
          tsb wChapterFlags,b

          jsr rsActionStructGetBattleTriggerableSkillFlags
          jsr rsActionStructAdjustVantageRoundOrder
          jsr rsActionStructCheckForDance
          jsr rsActionStructClearMagicEquipmentIfSilenced
          stz $CCE2,b

        _Loop
        lda #2
        sta @l $7ECCD2
        
        -
        lda @l wBattleAttackerIndex
        jsr rsActionStructAddStrikes
        bcs _DD37

        lda @l wBattleAttackerIndex
        eor #$0001
        sta @l wBattleAttackerIndex

        dec $CCD2,b
        bne -

        jsr rsActionStructCheckIfCombatantsCanDouble
        bcc +

        jsr rsActionStructAddStrikes
        bcs _DD37

        +
        inc $CCE2,b

        lda @l wBattleType
        and #$00FF
        cmp #1
        bne +

          ; Arena
          jml _DDFD

        +
        jsr rsActionStructCheckForAccostBattleRound
        bcs _Loop

        _DD37
        lda #$FFFF
        sta lStructPointer1,b
        lda #(`aBattleRoundsData)<<8
        sta lStructPointer2+1,b
        lda #<>aBattleRoundsData
        sta lStructPointer2,b
        jsl rlAppendNewStructEntry

        ldx #<>aActionStructUnit1
        jsr rsActionstructGetLevelUpAndDroppedItemData
        ldx #<>aActionStructUnit2
        jsr rsActionstructGetLevelUpAndDroppedItemData

        lda #$0010
        trb wChapterFlags,b

        lda @l wBattleType
        and #$00FF
        cmp #0
        bne +

          ; normal battle
          ldx wActiveUnitDeploymentOffset,b
          lda aDeploymentTable._UnitRAMPointer,x
          sta wSelectedUnitDataRAMPointer,b
          lda #UnitState0400
          jsl rlUnsetSelectedUnitStates
          jsl rlUnknown84C9E3
          bcs +

            jsl rlUnknown84CAA9

        +
        jsr rsSetBattleStatusAnimation
        
        lda wBattleCriticalType
        bit #$7FFF
        beq _NoSpecialCrit

          bit #$8000
          beq _NoSpecialCrit

            ; If unit performed a special crit, run the event engine and see if any
            ; events try to catch this.

            and #$7FFF
            sta wEventEngineArgument1,b

            lda wBattleStatus
            bit #$0001
            bne +

            lda aActionStructUnit1.CharacterID
            bra ++

            +
            lda aActionStructUnit2.CharacterID
            
            +
            sta wEventEngineArgument2,b

            sep #$20
            lda #$1D
            sta bEventActionIdentifier,b
            rep #$20

            jsl rlGetAndRunChapterMapEventConditions

        _NoSpecialCrit
        lda aActionStructUnit1.WeaponType
        cmp #WeaponTypeStaff
        beq _DDF7

          lda #$0014
          sta bEventActionIdentifier,b

          lda aActionStructUnit1.UnitRAMPointer
          sta wSelectedUnitDataRAMPointer,b
          jsl rlGetSelectedUnitFactionSlot
          sta wEventEngineArgument1,b
          jsl rlGetSelectedUnitCharacterID
          sta wEventEngineArgument2,b

          lda aActionStructUnit2.UnitRAMPointer
          sta wSelectedUnitDataRAMPointer,b
          jsl rlGetSelectedUnitFactionSlot
          sta wEventEngineArgument3,b
          jsl rlGetSelectedUnitCharacterID
          sta wEventEngineArgument4,b

          jsl rlGetAndRunChapterMapEventConditions
          bcs _End

        _DDF7
        jsl rlUnknown84DE36
        bra _End

        _DDFD
        lda #$FEFF
        sta lStructPointer1,b
        lda #(`aBattleRoundsData)<<8
        sta lStructPointer2+1,b
        lda #<>aBattleRoundsData
        sta lStructPointer2,b
        jsl rlAppendNewStructEntry

        _End
        ply
        plx
        plp
        plb
        rtl

        .databank 0

      rlClearBattleData ; 84/DE18

        .al
        .autsiz
        .databank ?

        phx
        ldx #(wAITargetCounter - wBattleType) -1
        sep #$20
        lda #0

          -
          sta wBattleType,x
          dec x
          bpl -

        rep #$20
        lda #$FFFF
        sta aActionStructUnit2.ObtainedItem
        sta aActionStructUnit1.ObtainedItem
        plx
        rtl

        .databank 0

      rlUnknown84DE36 ; 84/DE36

        .al
        .autsiz
        .databank $7E

        phb
        php

        sep #$20
        lda #$7E
        pha
        rep #$20
        plb

        lda wBattleType
        and #$00FF
        cmp #1
        beq _End

          lda aActionStructUnit1.WeaponID
          cmp #ValkyrieStaff
          beq _DE91

          cmp #Naga
          beq _DE91

          lda aActionStructUnit2.WeaponID
          cmp #Loptous
          beq _DE91

          lda wBattleType
          and #$00FF
          cmp #0
          beq +

          cmp #3
          bne _DE91

          +
          lda aActionStructUnit1.WeaponType
          cmp #WeaponTypeStaff
          beq +

            lda wBattleCriticalType
            bit #$7FFF
            beq +

            bit #$8000
            bne _DE97

          +
          lda aActionStructUnit1.UnitRAMPointer
          sta wSelectedUnitDataRAMPointer,b
          jsl rlStartBattleSceneOrMapBattle
          bra _End

          _DE91
          jsl rlStartBattleScene
          bra _End

          _DE97
          and #$7FFF
          sta wBattleCriticalType
          jsl rlStartScriptedCritEffect
          bra _End
        
        _End
        plp
        plb
        rtl

        .databank 0

      rsSetBattleStatusAnimation ; 84/DEA6

        .al
        .autsiz
        .databank $7E

        lda wBattleType
        and #$00FF
        cmp #1
        beq _End

          lda aActionStructUnit1.WeaponID
          cmp #ValkyrieStaff
          beq _End

          cmp #Naga
          beq _End

          lda aActionStructUnit2.WeaponID
          cmp #Loptous
          beq _End

          lda wBattleType
          and #$00FF
          cmp #0
          beq +

            cmp #3
            bne _End

          +
          lda aActionStructUnit1.UnitRAMPointer
          sta wSelectedUnitDataRAMPointer,b
          jsl rlCheckIfBattleAnimationOFF
          bcc _End

            lda #$0040
            tsb wBattleStatus
            bra _End
        
        _End
        rts

        .databank 0

      rsActionStructAddStrikes ; 84/DEEB

        .al
        .autsiz
        .databank ?

        ; Adds the strikes of one side to aBattleRoundsData.
        ; Input: A = side (0 = player, 1 = opponent).

        ; acting unit in A
        ; 0 = player
        ; 1 = enemy

        asl a
        tax
        lda aUnknown84DF35,x
        sta wActionStructAttacker
        lda aUnknown84DF35+2,x
        sta wActionStructDefender

        jsr rsActionStructTryProcSwordSkills
        jsr rsActionStructGetNumberOfStrikes
        sta $7ECCD4
        
          -
          lda #0
          jsr rsActionStructResolveStrike
          bcs _CLC

            lda #(`aBattleRoundsData)<<8
            sta lStructPointer2+1,b
            lda #<>aBattleRoundsData
            sta lStructPointer2,b
            lda bBattleRoundFlags
            sta lStructPointer1,b
            jsl rlAppendNewStructEntry

            lda $7ECCE0
            bne _SEC

            dec $CCD4,b
            bne -

        _CLC
        clc
        rts

        _SEC
        sec
        rts

        .databank 0

      aUnknown84DF35 ; 84/DF35

        .word <>aActionStructUnit1
        .word <>aActionStructUnit2
        .word <>aActionStructUnit1

      rsCheckIfUnitHasWeaponEquipped ; 84/DF3B

        .al
        .autsiz
        .databank ?

        lda structActionStructEntry.DeploymentNumber,b,x
        bmi +

          jsr rsCheckForWeaponInventorySlot
          bcc +

            lda structActionStructEntry.UnitRAMPointer,b,x
            sta wSelectedUnitDataRAMPointer,b
            jsl rlGetSelectedUnitStatus
            cmp #StatusSleep
            beq +

              lda structActionStructEntry.WeaponID,b,x
              bmi +

                jsl rlGetItemDataROMPointer
                jsl rlGetItemEquipmentType
                cmp #EquipTypeWeapon
                bne +

                  sec
                  rts

        +
        clc
        rts

        .databank 0

      rsCheckForWeaponInventorySlot ; 84/DF6A

        .al
        .autsiz
        .databank `wBattleType

        lda wBattleType
        and #$00FF
        cmp #1
        beq +

          ; normal battle
          lda structActionStructEntry.WeaponInventorySlot,b,x
          beq _CLC
          bmi _CLC
          bra _SEC
        
        +
        lda structActionStructEntry.WeaponInventorySlot,b,x
        beq _CLC
        
        _SEC
        sec
        rts
        
        _CLC
        clc
        rts

        .databank 0

      rlActionStructBuildScriptedBattleRounds ; 84/DF87

        .al
        .autsiz
        .databank ?

        ; Like rlActionStructBuildBattleRounds, but takes the strikes from a list at
        ; lR18 that ends with $FFFF.

        phb
        php

        sep #$20
        lda #`aBattleRoundsData
        pha
        rep #$20
        plb

        phx
        phy
        lda lR18
        pha
        lda lR18+1
        pha

        lda #(`aBattleRoundsData)<<8
        sta lR18+1
        lda #<>aBattleRoundsData
        sta lR18
        lda #$0020
        sta wR0
        lda #2
        sta wR1
        jsl rlBuildRAMStructHeader

        pla
        sta lR18+1
        pla
        sta lR18

        lda #$0010
        tsb wChapterFlags,b
        ldy #0

          _Loop
          lda [lR18],y
          cmp #$FFFF
          beq _E007

            and #$0001
            sta wBattleAttackerIndex
            asl a
            tax
            lda aUnknown84E033,x
            sta wActionStructAttacker
            lda aUnknown84E033+2,x
            sta wActionStructDefender

            lda [lR18],y
            and #$00FF
            ora #SB_ApplyGuarantees
            jsr rsActionStructResolveStrike
            bcs +

              lda #(`aBattleRoundsData)<<8
              sta lStructPointer2+1,b
              lda #<>aBattleRoundsData
              sta lStructPointer2,b
              lda bBattleRoundFlags
              sta lStructPointer1,b
              jsl rlAppendNewStructEntry

            +
            inc y
            bra _Loop

        _E007
        lda #$FFFF
        sta lStructPointer1,b
        lda #(`aBattleRoundsData)<<8
        sta lStructPointer2+1,b
        lda #<>aBattleRoundsData
        sta lStructPointer2,b
        jsl rlAppendNewStructEntry

        lda #$0010
        trb wChapterFlags,b
        lda #SONG_BATTLE_BOSS
        sta wBattleSong
        jsl rlStartBattleScene

        ply
        plx
        plp
        plb
        rtl

        .databank 0

      aUnknown84E033 ; 84/E033

        .word <>aActionStructUnit1
        .word <>aActionStructUnit2
        .word <>aActionStructUnit1

      rlSetBattleDeathQuotes ; 84/E039

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = if 0: set battle quote, else set death quote
        ; lR18 = dialogue pointer

        phb
        php
        phk
        plb
        ora #0
        bne +

        lda lR18+1
        sta wBattleQuotePointer+1
        lda lR18
        sta wBattleQuotePointer
        bra ++

        +
        lda lR18+1
        sta wDeathQuotePointer+1
        lda lR18
        sta wDeathQuotePointer
        
        +
        plp
        plb
        rtl

        .databank 0

      rsActionStructGetBattleTriggerableSkillFlags ; 84/E05F

        .al
        .autsiz
        .databank ?

        ldy #<>aActionStructUnit1
        jsr rsGetUnitsBattleTriggerableSkillFlags
        ldy #<>aActionStructUnit2
        jsr rsGetUnitsBattleTriggerableSkillFlags
        rts

        .databank 0

      rsGetUnitsBattleTriggerableSkillFlags ; 84/E06C

        .al
        .autsiz
        .databank ?

        lda #0
        sta structActionStructEntry.TriggerableSkills,b,y

        lda structActionStructEntry.UnitRAMPointer,b,y
        beq _End

        sta wSelectedUnitDataRAMPointer,b
        ldx #size(aCombatSkillsTable)-2

        -
        lda aCombatSkillsTable,x
        jsl rlCheckIfUnitHasSpecifiedPersonalOrClassSkill
        bcs +

        lda aCombatSkillsTable,x
        jsl rlCheckIfInventoryItemsHaveSpecifiedSkill
        bcc ++

        +
        lda structActionStructEntry.TriggerableSkills,b,y
        ora aCombatSkillsFlags,x
        sta structActionStructEntry.TriggerableSkills,b,y

        +
        dec x
        dec x
        bpl -

        _End
        rts

        .databank 0

      aCombatSkillsTable .block ; 84/E0A0

        .word SkillIDWrath
        .word SkillIDPursuit
        .word SkillIDAdept
        .word SkillIDNihil
        .word SkillIDMiracle
        .word SkillIDVantage
        .word SkillIDAccost
        .word SkillIDPavise
        .word SkillIDSteal
        .word SkillIDAstra
        .word SkillIDLuna
        .word SkillIDSol
        .word SkillIDHoly
        .word SkillIDDarkness
        .word SkillIDDance

      .bend

      aCombatSkillsFlags ; 84/E0BE

        .word CombatSkillFlagWrath
        .word CombatSkillFlagPursuit
        .word CombatSkillFlagAdept
        .word CombatSkillFlagNihil
        .word CombatSkillFlagMiracle
        .word CombatSkillFlagVantage
        .word CombatSkillFlagAccost
        .word CombatSkillFlagPavise
        .word CombatSkillFlagSteal
        .word CombatSkillFlagAstra
        .word CombatSkillFlagLuna
        .word CombatSkillFlagSol
        .word CombatSkillFlagHoly
        .word CombatSkillFlagDarkness
        .word CombatSkillFlagDance
        .word CombatSkillFlagStayOnMap

      rsActionStructTryProcSwordSkills ; 84/E0DE

        .al
        .autsiz
        .databank ?

        lda #0
        sta wBattleActivatedSkill
        lda #0
        sta wBattleTempVariable

        ldx #<>aActionStructUnit1
        ldy #<>aActionStructUnit2
        jsr rsActionStructTryProcSwordSkillsEffect

        lda #1
        sta wBattleTempVariable

        ldx #<>aActionStructUnit2
        ldy #<>aActionStructUnit1
        jsr rsActionStructTryProcSwordSkillsEffect
        rts

        .databank 0

      rsActionStructTryProcSwordSkillsEffect ; 84/E106

        .al
        .autsiz
        .databank `wBattleAttackerIndex

        lda #0
        sta structActionStructEntry.BattleBonusAtkDef,b,x

        lda structActionStructEntry.DeploymentNumber,b,x
        bpl +

          jml _End

        +
        lda $0022,b,x
        cmp #8
        beq _End

          jsr rsCheckIfUnitHasWeaponEquipped
          bcc _End

            jsr rsCheckIfBattleDistanceInWeaponRange
            bcc _End

              lda structActionStructEntry.UnitRAMPointer,b,y
              sta wSelectedUnitDataRAMPointer,b
              lda #SkillIDNihil
              jsl rlCheckIfUnitHasSpecifiedPersonalOrClassSkill
              bcs _End

                lda structActionStructEntry.WeaponID,b,x
                jsl rlGetItemDataROMPointer
                jsl rlGetItemWeaponType
                cmp #WeaponTypeSword
                bne _End

                  lda structActionStructEntry.UnitRAMPointer,b,x
                  sta wSelectedUnitDataRAMPointer,b

                  ldy #SkillIDAstra

                    -
                    tya
                    jsl rlCheckIfUnitHasSpecifiedPersonalOrClassSkill
                    bcc + 

                    jsl rlGetSelectedUnitTotalSkill
                    jsl rlRollForChance
                    bcc ++

                    +
                    inc y
                    cpy #SkillIDRenewal
                    bcc -

                  _End
                  rts
        
        +
        cpy #SkillIDHoly
        beq +

          cpy #SkillIDDarkness
          beq +

            lda @l wBattleTempVariable
            cmp @l wBattleAttackerIndex
            bne _End

              sty wBattleActivatedSkill
              bra ++

        +
        lda #20
        sta structActionStructEntry.BattleBonusAtkDef,b,x

        +
        tya
        xba
        ora #$00FE
        sta lStructPointer1,b

        lda #(`aBattleRoundsData)<<8
        sta lStructPointer2+1,b
        lda #<>aBattleRoundsData
        sta lStructPointer2,b
        jsl rlAppendNewStructEntry
        rts

        .databank 0

      rsActionStructCheckForDance ; 84/E19F

        .al
        .autsiz
        .databank `wBattleStatus

        ldx #<>aActionStructUnit1
        ldy #<>aActionStructUnit2
        lda structActionStructEntry.TriggerableSkills,b,x
        bit #CombatSkillFlagDance
        beq _End

          lda wBattleStatus
          and #$0001
          bne +

          ; If song would be player attack, overwrite it with dancer attack
          lda wBattleSong
          cmp #SONG_BATTLE_PLAYER
          bne +

            lda #SONG_BATTLE_DANCE
            sta wBattleSong

          +
          lda structActionStructEntry.DeploymentNumber,b,y
          bpl _End

            jsr rsCheckIfUnitHasWeaponEquipped
            bcs _End

              lda #8
              sta $0022,b,x
              lda #1
              sta structActionStructEntry.WeaponMinRange,b,x
              sta structActionStructEntry.WeaponMaxRange,b,x

        _End
        rts

        .databank 0

      rsActionStructClearMagicEquipmentIfSilenced ; 84/E1DD

        .al
        .autsiz
        .databank ?

        ldx #<>aActionStructUnit1
        jsr rsActionStructClearMagicEquipmentIfSilencedEffect
        ldx #<>aActionStructUnit2
        jsr rsActionStructClearMagicEquipmentIfSilencedEffect
        rts

        .databank 0

      rsActionStructClearMagicEquipmentIfSilencedEffect ; 84/E1EA

        .al
        .autsiz
        .databank ?

        lda structActionStructEntry.WeaponID,b,x
        jsl rlGetItemDataROMPointer
        jsl rlGetItemWeaponType
        cmp #WeaponTypeStaff
        bcc +

          lda structActionStructEntry.UnitRAMPointer,b,x
          sta wSelectedUnitDataRAMPointer,b
          jsl rlGetSelectedUnitStatus
          cmp #StatusSilence
          bne +

            lda #0
            sta structActionStructEntry.WeaponInventorySlot,b,x

        +
        rts

        .databank 0

      rsActionStructAdjustVantageRoundOrder ; 84/E210

        .al
        .autsiz
        .databank ?

        ldx #<>aActionStructUnit1
        jsr rsActionStructCheckForVantageActivation
        bcc +

        lda #0
        sta wBattleAttackerIndex
        bra _End
        
        +
        ldx #<>aActionStructUnit2
        jsr rsActionStructCheckForVantageActivation
        bcc _End

        lda #1
        sta wBattleAttackerIndex
        
        _End
        rts

        .databank 0

      rsActionStructCheckForVantageActivation ; 84/E231

        .al
        .autsiz
        .databank ?

        jsr rsCheckIfUnitHasWeaponEquipped
        bcc _CLC

        lda #SkillIDVantage
        jsl rlCheckIfUnitHasSpecifiedPersonalOrClassSkill
        bcc _CLC

        lda structActionStructEntry.MaxHP,b,x
        lsr a
        cmp structActionStructEntry.CurrentHP,b,x
        bcc _CLC

        sec
        rts
        
        _CLC
        clc
        rts

        .databank 0

      rsActionStructGetBattleInitiatorIfArena ; 84/E24C

        .al
        .autsiz
        .databank `aActionStructUnit1

        ; Check if arena fight

        lda wBattleType
        and #$00FF
        cmp #1
        bne _End

          lda aActionStructUnit1.BattleAttackSpeed
          cmp aActionStructUnit2.BattleAttackSpeed
          bmi +

          lda #0
          bra ++

          +
          lda #1

          +
          sta @l wBattleAttackerIndex
        
        _End
        rts

        .databank 0

      rsBattleHandleEffectiveness ; 84/E26C

        .al
        .autsiz
        .databank ?

        ldx #<>aActionStructUnit1
        ldy #<>aActionStructUnit2
        jsr rsSetBattleCritIfEffective

        ldx #<>aActionStructUnit2
        ldy #<>aActionStructUnit1
        jsr rsSetBattleCritIfEffective
        rts

        .databank 0

      rsSetBattleCritIfEffective ; 84/E27F

        .al
        .autsiz
        .databank ?

        jsr rsCheckIfUnitHasWeaponEquipped
        bcc +

          lda structActionStructEntry.UnitRAMPointer,b,y
          beq +

            sta wSelectedUnitDataRAMPointer,b
            jsl rlGetClassWeakness
            sta wBattleTempVariable

            lda structActionStructEntry.WeaponID,b,x
            jsl rlGetItemDataROMPointer
            jsl rlGetItemEffectiveness
            bit $CCE8,b
            beq +

              lda #100
              sta structActionStructEntry.BattleCrit,b,x

        +
        rts

        .databank 0

      rsActionStructGetNumberOfStrikes ; 84/E2AB

        .al
        .autsiz
        .databank `wActionStructAttacker

        ldx wActionStructAttacker

        lda #1
        sta @l wBattleTempVariable

        jsr rsCheckIfUnitHasWeaponEquipped
        bcc _End
        
        -
        lda @l wBattleActivatedSkill
        cmp #SkillIDAstra
        bne +

          lda #5
          sta @l wBattleTempVariable
          bra _E2ED

        +
        lda structActionStructEntry.TriggerableSkills,b,x
        bit #CombatSkillFlagAdept
        beq _E2ED

        lda structActionStructEntry.BattleAttackSpeed,b,x
        clc
        adc #20
        bmi -

        cmp #100
        bcs +

          jsl rlRollForChance
          bcs _E2ED
        
        +
        asl $CCE8,b
        bra _End

        _E2ED
        lda structActionStructEntry.WeaponID,b,x
        jsl rlGetItemDataROMPointer
        jsl rlGetItemWeaponTraits
        cmp #WeaponTraitBrave
        bne _End

          asl $CCE8,b

        _End
        lda @l wBattleTempVariable
        rts

        .databank 0

      rsActionStructCheckIfCombatantsCanDouble ; 84/E305

        .al
        .autsiz
        .databank `wActionStructAttacker

        ; sec if true

        lda @l wBattleStatus
        and #$0001
        sta @l wBattleTempVariable
        asl a
        tax
        lda aUnknown84E35E,x
        sta @l wActionStructAttacker
        lda aUnknown84E35E+2,x
        sta @l wActionStructDefender

        lda @l wBattleStatus
        and #$0001
        sta @l wBattleTempVariable

        ldx wActionStructAttacker
        ldy wActionStructDefender
        jsr rsActionStructCheckIfDoubling
        bcs +

        lda @l wBattleStatus
        and #$0001
        eor #$0001
        sta @l wBattleTempVariable

        ldx wActionStructDefender
        ldy wActionStructAttacker
        jsr rsActionStructCheckIfDoubling
        bcs +

        clc

        -
        rts

        +
        lda @l wBattleTempVariable
        sta @l wBattleAttackerIndex
        sec
        bra -

        .databank 0

      aUnknown84E35E ; 84/E35E

        .word <>aActionStructUnit1
        .word <>aActionStructUnit2
        .word <>aActionStructUnit1

      rsActionStructCheckIfDoubling ; 84/E364

        .al
        .autsiz
        .databank ?

        ; sec if doubling
        ; clc if not

        jsr rsCheckIfUnitHasWeaponEquipped
        bcc +

          lda structActionStructEntry.TriggerableSkills,b,x
          bit #CombatSkillFlagPursuit
          beq +

            lda structActionStructEntry.BattleAttackSpeed,b,y
            cmp structActionStructEntry.BattleAttackSpeed,b,x
            bpl +

              sec
              rts

        +
        clc
        rts

        .databank 0

      rsActionStructCheckForAccostBattleRound ; 84/E37D

        .al
        .autsiz
        .databank `wActionStructAttacker

        lda #(`aBattleRoundsData)<<8
        sta lStructPointer2+1,b
        lda #<>aBattleRoundsData
        sta lStructPointer2,b
        jsl rlGetRAMStructCurrentStructCount
        cmp #40
        bcs _CLC

          lda @l wBattleStatus
          and #$0001
          sta @l wBattleTempVariable
          asl a
          tax
          lda aUnknown84E3F2,x
          sta @l wActionStructAttacker
          lda aUnknown84E3F2+2,x
          sta @l wActionStructDefender
          
          lda @l wBattleStatus
          and #$0001
          sta @l wBattleTempVariable

          ldx wActionStructAttacker
          ldy wActionStructDefender
          jsr rsActionStructCheckForAccost
          bcs _SEC

          lda @l wBattleStatus
          and #$0001
          eor #$0001
          sta @l wBattleTempVariable

          ldx wActionStructDefender
          ldy wActionStructAttacker
          jsr rsActionStructCheckForAccost
          bcs _SEC

          _CLC
          clc
        
        -
        rts
        
        _SEC
        lda #2
        sta @l $7ECCD2
        lda @l wBattleTempVariable
        sta @l wBattleAttackerIndex
        sec
        bra -

        .databank 0

      aUnknown84E3F2 ; 84/E3F2

        .word <>aActionStructUnit1
        .word <>aActionStructUnit2
        .word <>aActionStructUnit1

      rsActionStructCheckForAccost ; 84/E3F8

        .al
        .autsiz
        .databank ?

        ; if hp =>25
        ; hp/2 + as - enemy as% chance 

        jsr rsCheckIfUnitHasWeaponEquipped
        bcc _CLC

          jsr rsCheckIfBattleDistanceInWeaponRange
          bcc _CLC

            lda structActionStructEntry.TriggerableSkills,b,x
            bit #CombatSkillFlagAccost
            beq _CLC

              lda structActionStructEntry.UnitRAMPointer,b,x
              sta wSelectedUnitDataRAMPointer,b
              jsl rlGetSelectedUnitCurrentHP
              cmp #25
              bcc _CLC

                lsr a
                clc
                adc structActionStructEntry.BattleAttackSpeed,b,x
                sec
                sbc structActionStructEntry.BattleAttackSpeed,b,y
                bmi _CLC

                  cmp #100
                  bcs +

                  jsl rlRollForChance
                  bcc +
        
        _CLC
        clc
        rts
        
        +
        sec
        rts

        .databank 0

      rsActionStructResolveStrike ; 84/E433

        .al
        .autsiz
        .databank `wActionStructAttacker

        phx
        phy
        sta @l wScriptedCombatFlags
        stz bBattleRoundFlags

        ldx wActionStructAttacker
        ldy wActionStructDefender
        jsr rsCheckIfBattleDistanceInWeaponRange
        bcc _SEC

        lda structActionStructEntry.UnitRAMPointer,b,x
        sta wSelectedUnitDataRAMPointer,b

        jsl rlGetSelectedUnitStatus
        cmp #StatusSleep
        beq _SEC

        lda @l wBattleAttackerIndex
        tsb bBattleRoundFlags

        lda structActionStructEntry.UnitRAMPointer,b,x
        sta wSelectedUnitDataRAMPointer,b

        lda structActionStructEntry.Unknown,b,x
        cmp #8
        bne +

          jsr rsActionStructDance
          bra _End

        +
        jsr rsCheckForWeaponInventorySlot
        bcc _SEC

        lda structActionStructEntry.WeaponID,b,x
        jsl rlGetItemDataROMPointer
        jsl rlGetItemEquipmentType
        cmp #EquipTypeWeapon
        bne +

          jsl rlGetItemWeaponTraits
          asl a
          tax
          jsr (aActionStructWeaponTraitEffects,x)
          bra _End

        +
        jsl rlGetItemStaffEffect
        asl a
        tax
        jsr (aActionStructStaffEffects,x)

        _End
        ply
        plx
        rts
        
        _SEC
        sec
        bra _End

        .databank 0

      aActionStructWeaponTraitEffects ; 84/E49F

        .addr rsActionStructWeaponTraitNormal       ; none
        .addr rsActionStructWeaponTraitRangedMagic  ; WeaponTraitRangedMagicSword   
        .addr rsActionStructWeaponTraitLifeSteal    ; WeaponTraitPermanentMagicSword
        .addr rsActionStructWeaponTraitLifeSteal    ; WeaponTraitLifeSteal          
        .addr rsActionStructWeaponTraitNormal       ; WeaponTraitBrave              
        .addr rsActionStructWeaponTraitNormal       ; WeaponTraitUncounterable      
        .addr rsActionStructWeaponTraitStatusSword  ; WeaponTraitStatusSword        
        .addr rsActionStructWeaponTraitNormal       ; WeaponTraitHalveAttack        
        .addr rsActionStructWeaponTraitNormal       ; WeaponTraitNegateHalveAttack  
        .addr rsActionStructWeaponTraitHel          ; WeaponTraitHelEffect          
        .addr rsActionStructWeaponTraitNormal       ; WeaponTraitFemaleOnly         

      aActionStructStaffEffects ; 84/E4B5

        .addr rsActionStructStaffEffectNone
        .addr rsActionStructStaffEffectHeal ; heal
        .addr rsActionStructStaffEffectHeal ; mend
        .addr rsActionStructStaffEffectHeal ; recover
        .addr rsActionStructStaffEffectHeal ; physic
        .addr rsActionStructStaffEffectFortify ; fortify
        .addr rsActionStructStaffEffectReturn ; return
        .addr rsActionStructStaffEffectWarp ; warp
        .addr rsActionStructStaffEffectRescue ; rescue
        .addr rsActionStructStaffEffectClearStatus ; charm
        .addr rsActionStructStaffEffectClearStatus ; restore
        .addr rsActionStructStaffEffectValkyrie ; valkyrie
        .addr rsActionStructStaffEffectStatus ; silence
        .addr rsActionStructStaffEffectStatus ; sleep
        .addr rsActionStructStaffEffectStatus ; berserk
        .addr rsActionStructStaffEffectThief ; thief

      rsActionStructStaffEffectNone ; 84/E4D5

        .al
        .autsiz
        .databank ?

        clc
        rts

        .databank 0

      rsCheckIfBattleDistanceInWeaponRange ; 84/E4D7

        .al
        .autsiz
        .databank ?

        sec
        lda wBattleDistance
        beq +

        cmp structActionStructEntry.WeaponMinRange,b,x
        bcc +

        lda structActionStructEntry.WeaponMaxRange,b,x
        cmp wBattleDistance
        bcc +
        
        +
        rts

        .databank 0

      rsActionStructWeaponTraitNormal ; 84/E4ED

        .al
        .autsiz
        .databank `wActionStructAttacker

        ldx wActionStructAttacker
        ldy wActionStructDefender
        jsr rsSetBattleRoundRangedFlag
        jsr rsSetBattleRoundMagicFlag
        jsr rsActionStructRoundCheckIfHit
        bcc +

          jsr rsActionStructRoundTryProcPavise
          bcc +

            jsr rsUnknown84E62C
            lda structActionStructEntry.BattleBonusAtkDef,b,x
            sta wRoutineVariable1,b
            jsr rsActionStructRoundTryProcWrath
            jsr rsActionStructRoundTryProcCrit
            jsr rsActionStructRoundGetDamage
            jsr rsActionStructCheckForSolHealing
            jsr rsUnknown84E6F6

        +
        clc
        rts

        .databank 0

      rsSetBattleRoundRangedFlag ; 84/E51D

        .al
        .autsiz
        .databank ?

        lda wBattleDistance
        cmp #2
        bcc +

          sep #$20
          lda bBattleRoundFlags
          ora #BattleRoundFlagRanged
          sta bBattleRoundFlags
          rep #$20

        +
        rts

        .databank 0

      rsSetBattleRoundMagicFlag ; 84/E535

        .al
        .autsiz
        .databank ?

        lda structActionStructEntry.WeaponID,b,x
        jsl rlGetItemDataROMPointer
        jsl rlGetItemWeaponType
        cmp #WeaponTypeStaff
        bcc +

          sep #$20
          lda bBattleRoundFlags
          ora #BattleRoundFlagMagic
          sta bBattleRoundFlags
          rep #$20

        +
        rts

        .databank 0

      rsActionStructRoundCheckIfHit ; 84/E554

        .al
        .autsiz
        .databank `bBattleRoundFlags

        lda @l wScriptedCombatFlags
        bit #SB_ApplyGuarantees
        beq +

        bit #SB_GuaranteedHit
        bne _SEC
        bra _E5CF

        +
        lda @l wBattleActivatedSkill
        cmp #SkillIDLuna
        beq _SEC

        cmp #SkillIDSol
        beq _SEC

        stz wRoutineVariable1,b

        lda structActionStructEntry.TriggerableSkills,b,y
        bit #CombatSkillFlagMiracle
        beq +

          lda structActionStructEntry.UnitRAMPointer,b,y
          sta wSelectedUnitDataRAMPointer,b
          jsl rlGetSelectedUnitStates
          bit #UnitStateMiracleActive
          beq +

            jsl rlGetSelectedUnitCurrentHP
            cmp #11
            bcs +

              eor #$FFFF
              inc a
              clc
              adc #10
              phx

              tax
              lda aActionStructMiracleAvoidBoostTable,x
              and #$00FF
              sta wRoutineVariable1,b
              plx

        +
        lda structActionStructEntry.BattleHit,b,x
        sec
        sbc structActionStructEntry.BattleAvoid,b,y
        sec
        sbc wRoutineVariable1,b
        cmp #0
        bmi _FloorHit

        cmp #101
        bpl _CapHit
        bra +
        
        _FloorHit
        lda #0
        bra +
        
        _CapHit
        lda #100
        
        +
        jsl rlRollForChance
        bcc _SEC
        
        _E5CF
        sep #$20
        lda #8
        tsb bBattleRoundFlags
        lda #0
        sta @l $7ECCDF
        rep #$20

        clc
        
        -
        rts
        
        _SEC
        sec
        bra -

        .databank 0

      aActionStructMiracleAvoidBoostTable ; 84/E5E3

        .byte 10
        .byte 20
        .byte 30
        .byte 40
        .byte 50
        .byte 60
        .byte 70
        .byte 80
        .byte 90
        .byte 100

      rsActionStructRoundTryProcPavise ; 84/E5ED

        .al
        .autsiz
        .databank ?

        lda wScriptedCombatFlags
        bit #SB_ApplyGuarantees
        bne _SEC

          lda structActionStructEntry.TriggerableSkills,b,y
          bit #CombatSkillFlagPavise
          beq _SEC

            lda structActionStructEntry.Level,b,y
            jsl rlRollForChance
            bcs _SEC

              lda #$02FE
              sta lStructPointer1,b
              lda #(`aBattleRoundsData)<<8
              sta lStructPointer2+1,b
              lda #<>aBattleRoundsData
              sta lStructPointer2,b
              jsl rlAppendNewStructEntry

              sep #$20
              lda #0
              sta $7ECCDF
              rep #$20

              clc

              -
              rts

        _SEC
        sec
        bra -

        .databank 0

      rsUnknown84E62C ; 84/E62C

        .al
        .autsiz
        .databank ?

        lda structActionStructEntry.UnitRAMPointer,b,x
        sta wSelectedUnitDataRAMPointer,b
        lda structActionStructEntry.WeaponInventorySlot,b,x
        sta wRoutineVariable1,b
        jsl rlUseInventorySlotItem
        bcc +

          lda structActionStructEntry.WeaponInventorySlot,b,x
          ora #$8000
          sta structActionStructEntry.WeaponInventorySlot,b,x

        +
        lda structActionStructEntry.WeaponID,b,x
        jsl rlGetItemDataROMPointer
        jsl rlGetItemEquipmentType
        cmp #EquipTypeStaff
        beq +

          lda structActionStructEntry.TriggerableSkills,b,x
          bit #CombatSkillFlagSteal
          beq +

            jsr rsActionStructStealMoney

        +
        rts

        .databank 0

      rsActionStructRoundTryProcWrath ; 84/E663

        .al
        .autsiz
        .databank ?

        lda #SkillIDWrath
        jsl rlCheckIfUnitHasSpecifiedPersonalOrClassSkill
        bcc +

          jsl rlGetSelectedUnitCurrentHP
          sta wBattleTempVariable
          lda structActionStructEntry.MaxHP,b,x
          lsr a
          inc a
          cmp wBattleTempVariable
          bcc +

            lda #100
            sta structActionStructEntry.BattleCrit,b,x

        +
        rts

        .databank 0

      rsActionStructRoundTryProcCrit ; 84/E686

        .al
        .autsiz
        .databank `bBattleRoundFlags

        lda @l wScriptedCombatFlags
        bit #SB_ApplyGuarantees
        beq +

        bit #SB_GuaranteedCrit
        bne ++
        bra _End
        
        +
        lda structActionStructEntry.TriggerableSkills,b,y
        bit #CombatSkillFlagNihil
        bne _End

        lda structActionStructEntry.BattleCrit,b,x
        beq _End

        jsl rlRollForChance
        bcs _End

        +
        lda wBattleCriticalType
        ora #$8000
        sta wBattleCriticalType

        lda #4
        tsb bBattleRoundFlags

        lda wRoutineVariable1,b
        asl a
        clc
        adc structActionStructEntry.BattleMight,b,x
        sta wRoutineVariable1,b
        
        _End
        rts

        .databank 0

      rsActionStructRoundGetDamage ; 84/E6C4

        .al
        .autsiz
        .databank ?

        lda structActionStructEntry.BattleMight,b,x
        clc
        adc wRoutineVariable1,b
        sta wRoutineVariable1,b

        lda wBattleActivatedSkill
        cmp #SkillIDLuna
        beq +

          lda wRoutineVariable1,b
          sec
          sbc structActionStructEntry.BattleDefense,b,y
          sec
          sbc structActionStructEntry.BattleBonusAtkDef,b,y
          cmp #1
          bpl ++

          lda #1
          bra ++

        +
        lda wRoutineVariable1,b

        +
        and #$00FF
        sta wRoutineVariable1,b

        rts

        .databank 0

      rsUnknown84E6F6 ; 84/E6F6

        .al
        .autsiz
        .databank `bBattleRoundFlags

        lda @l wScriptedCombatFlags
        bit #SB_ApplyGuarantees
        beq ++

        bit #SB_Unknown02
        bne +

          jml _E82C

        +
        lda #BattleRoundFlagFatal
        tsb bBattleRoundFlags

        lda #80
        sta wRoutineVariable1,b

        +
        lda structActionStructEntry.UnitRAMPointer,b,y
        sta wSelectedUnitDataRAMPointer,b
        lda structActionStructEntry.CharacterID,b,x
        jsl rlActionStructInflictDamage
        bcs +

          jml _E803

        ; fatal hit
        +
        jsl rlGetSelectedUnitStatus
        cmp #StatusCaptive
        bne +

          jsr rsUnknown84EF13

        +
        lda @l wBattleType
        and #$00FF
        cmp #1
        beq +

        lda @l aActionStructUnit2.CharacterID
        cmp #JuliusChFinal
        beq +

        lda structActionStructEntry.TriggerableSkills,b,y
        bit #CombatSkillFlagStayOnMap
        bne ++

        ; Is arena, vs julius or not captive
        +
        lda #BattleRoundFlagFatal
        tsb bBattleRoundFlags

        +
        lda #1
        sta @l $7ECCE0

        lda @l wBattleStatus
        ora #$0010
        sta @l wBattleStatus

        lda @l wBattleAttackerIndex
        bne +

          lda @l wBattleStatus
          ora #$0020
          sta @l wBattleStatus

        +
        lda @l wBattleAttackerIndex
        beq +

          lda #0
          sta structActionStructEntry.ObtainedStealMoney,b,y

        +
        sta structActionStructEntry.GainedExperience,b,y

        lda wRoutineVariable1,b
        pha

        lda structActionStructEntry.UnitRAMPointer,b,y
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetUniqueEquipmentOrDrops
        cmp #$00FF
        beq _E7CC

          sta wRoutineVariable1,b

          lda structActionStructEntry.UnitRAMPointer,b,x
          sta wSelectedUnitDataRAMPointer,b

          jsl rlGetSelectedUnitFactionSlot
          ora #0
          bne _E7CC

            lda wRoutineVariable1,b
            jsl rlGetItemRAMStructEntryByPlayerItemIndex
            jsl rlGetItemRAMStateAndOwner
            lda structActionStructEntry.UnitRAMPointer,b,y
            cmp wR1
            beq +

              lda wR0
              cmp #ItemStateUnobtained
              bne _E7CC

            +
            lda wRoutineVariable1,b
            sta structActionStructEntry.ObtainedItem,b,x

        _E7CC
        pla
        sta wRoutineVariable1,b

        lda structActionStructEntry.UnitRAMPointer,b,x
        sta wSelectedUnitDataRAMPointer,b

        lda @l wBattleType
        and #$00FF
        cmp #1
        beq +

        lda structActionStructEntry.WeaponInventorySlot,b,x
        and #$00FF
        jsl rlAddWinToSelectedUnitAndWeapon
        bra ++

        ; Arena
        +
        jsl rlActionStructArenaWinResults
        sta structActionStructEntry.ObtainedArenaMoney,b,x

        +
        lda structActionStructEntry.Level,b,y
        sec
        sbc structActionStructEntry.Level,b,x
        asl a
        clc
        adc #30
        bra +

        _E803
        lda @l wBattleType
        and #$00FF
        cmp #1
        beq _E82C

        lda structActionStructEntry.Level,b,y
        sec
        sbc structActionStructEntry.Level,b,x
        clc
        adc #10
        
        +
        bmi +

        cmp #101
        bmi ++

        lda #100
        bra ++
        
        +
        lda #0

        +
        sta structActionStructEntry.GainedExperience,b,x

        _E82C
        lda wRoutineVariable1,b

        sep #$20
        sta @l $7ECCDF
        rep #$20

        rts

        .databank 0

      rsActionStructWeaponTraitRangedMagic ; 84/E838

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

          jsr rsActionStructRoundTryProcPavise
          bcc +

            jsr rsUnknown84E62C
            lda structActionStructEntry.BattleBonusAtkDef,b,x
            sta wRoutineVariable1,b
            jsr rsActionStructRoundTryProcWrath
            jsr rsActionStructRoundTryProcCrit
            jsr rsActionStructRoundGetDamage
            jsr rsActionStructCheckForSolHealing
            jsr rsUnknown84E6F6
        
        +
        clc
        rts

        .databank 0

      rsActionStructWeaponTraitStatusSword ; 84/E873

        .al
        .autsiz
        .databank `wActionStructAttacker

        ldx wActionStructAttacker
        ldy wActionStructDefender
        jsr rsSetBattleRoundRangedFlag
        jsr rsSetBattleRoundMagicFlag
        jsr rsActionStructRoundCheckIfHit
        bcc _End

          jsr rsActionStructRoundTryProcPavise
          bcc _End
          
            jsr rsUnknown84E62C
            lda structActionStructEntry.BattleBonusAtkDef,b,x
            sta wRoutineVariable1,b
            jsr rsActionStructRoundTryProcWrath
            jsr rsActionStructRoundTryProcCrit
            jsr rsActionStructRoundGetDamage
            jsr rsActionStructCheckForSolHealing
            jsr rsUnknown84E6F6

            lda structActionStructEntry.UnitRAMPointer,b,y
            sta wSelectedUnitDataRAMPointer,b
            jsl rlGetSelectedUnitStatus
            sta @l wBattleTempVariable

            lda structActionStructEntry.WeaponID,b,x
            jsl rlGetItemDataROMPointer
            jsl rlGetItemAdditionalInfo
            cmp @l wBattleTempVariable
            beq _End

              jsl rlGetSelectedUnitTotalResistance
              sta wRoutineVariable1,b
              lda #30
              sec
              sbc wRoutineVariable1,b
              jsl rlRollForChance
              bcs _End

                jsr rsActionStructInflictItemStatus

                lda #(`aBattleRoundsData)<<8
                sta lStructPointer2+1,b
                lda #<>aBattleRoundsData
                sta lStructPointer2,b
                lda @l bBattleRoundFlags
                and #~BattleRoundFlagFatal
                sta lStructPointer1,b
                jsl rlAppendNewStructEntry

                lda #0
                sep #$20
                sta @l $7ECCDF
                rep #$20

                lda #$0040
                tsb bBattleRoundFlags

        _End
        clc
        rts

        .databank 0

      rsActionStructWeaponTraitHel ; 84/E904

        .al
        .autsiz
        .databank `wActionStructAttacker

        ldx wActionStructAttacker
        ldy wActionStructDefender
        jsr rsSetBattleRoundRangedFlag
        jsr rsSetBattleRoundMagicFlag
        jsr rsActionStructRoundCheckIfHit
        bcc +

          jsr rsUnknown84E62C
          lda structActionStructEntry.UnitRAMPointer,b,y
          sta wSelectedUnitDataRAMPointer,b
          lda structActionStructEntry.CurrentHP,b,y
          dec a
          sta wRoutineVariable1,b

          lda #1
          jsl rlSetSelectedUnitCurrentHP

          lda wRoutineVariable1,b
          sep #$20
          sta @l $7ECCDF
          rep #$20
        
        +
        clc
        rts

        .databank 0

      rsActionStructStaffEffectHeal ; 84/E939

        .al
        .autsiz
        .databank `wActionStructAttacker

        ldx wActionStructAttacker
        ldy wActionStructDefender

        lda #2
        tsb bBattleRoundFlags
        
        jsr rsUnknown84E62C

        lda structActionStructEntry.UnitRAMPointer,b,x
        sta wSelectedUnitDataRAMPointer,b
        lda structActionStructEntry.WeaponInventorySlot,b,x
        and #$00FF
        jsl rlGetItemROMDataByInventorySlot
        jsl rlGetStaffHealAmount
        sta wRoutineVariable1,b

        lda structActionStructEntry.UnitRAMPointer,b,y
        sta wSelectedUnitDataRAMPointer,b

        lda structActionStructEntry.MaxHP,b,y
        sec
        sbc structActionStructEntry.CurrentHP,b,y
        cmp wRoutineVariable1,b
        bcs +

          sta wRoutineVariable1,b
        
        +
        jsl rlHealSelectedUnitsHP

        lda structActionStructEntry.UnitRAMPointer,b,x
        sta wSelectedUnitDataRAMPointer,b
        lda structActionStructEntry.WeaponInventorySlot,b,x
        and #$00FF
        jsl rlGetInventorySlotStaffCostValue
        sta structActionStructEntry.GainedExperience,b,x

        lda wRoutineVariable1,b
        sep #$20
        sta @l $7ECCDF
        rep #$20

        lda #SONG_BATTLE_STAFF
        sta wBattleSong
        clc
        rts

        .databank 0

      rsActionStructStaffEffectFortify ; 84/E99E

        .al
        .autsiz
        .databank `wActionStructAttacker

        ldx wActionStructAttacker

        lda #2
        tsb bBattleRoundFlags

        lda structActionStructEntry.UnitRAMPointer,b,x
        sta wSelectedUnitDataRAMPointer,b
        lda structActionStructEntry.WeaponInventorySlot,b,x
        and #$00FF
        jsl rlGetItemROMDataByInventorySlot
        jsl rlApplyFortify
        jsr rsUnknown84E62C

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
        rts

        .databank 0

      rsActionStructStaffEffectReturn ; 84/E9E3

        .al
        .autsiz
        .databank `wActionStructAttacker

        ldx wActionStructAttacker
        ldy wActionStructDefender

        lda #2
        tsb bBattleRoundFlags
        
        jsr rsUnknown84E62C

        phx
        lda wTargetEventLocationEntry,b
        pha

        lda structActionStructEntry.UnitRAMPointer,b,y
        sta wSelectedUnitDataRAMPointer,b
        lda structActionStructEntry.DeploymentNumber,b,y
        tax
        jsl rlGetSelectedUnitFactionSlot
        jsl rlGetFactionSlotLocationID
        jsl rlQueueUnitRelocationToCastle

        pla
        sta wTargetEventLocationEntry,b
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
        rts

        .databank 0

      rsActionStructDance ; 84/EA37

        .al
        .autsiz
        .databank `wActionStructAttacker

        ldx wActionStructAttacker
        ldy wActionStructDefender

        lda #2
        tsb bBattleRoundFlags

        lda wChapterFlags,b
        bit #$0020
        bne _EA76

        phx
        ldx #$03FF
        
        -
        lda aTargetDistanceMap,x
        and #$00FF
        cmp #$00FF
        beq +

        phx
        tax
        jsl rlUnknown84CA97
        lda @l aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        lda #UnitStateMoved
        jsl rlUnsetSelectedUnitStates
        plx

        +
        dec x
        bpl -

        plx
        bra _EAC0

        _EA76
        phx
        lda structActionStructEntry.DeploymentNumber,b,x
        sta @l wBattleTempVariable
        lda structActionStructEntry.UnitRAMPointer,b,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitHomeCastle
        jsl rlGetLocationEventDataEntry
        jsl rlBuildCastleUnitList
        ldx #0

        -
        lda aCastleUnitDeploymentOffsets,x
        bmi _EABF

        cmp @l wBattleTempVariable
        beq +

        phx
        tax
        jsl rlUnknown84CA97
        lda @l aDeploymentTable._StateBuffer,x
        sta @l aDeploymentTable._State,x
        lda @l aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b

        lda #UnitStateMoved
        jsl rlUnsetSelectedUnitStates
        plx
        
        +
        inc x
        inc x
        bra -
        
        _EABF
        plx

        _EAC0
        lda #10
        sta structActionStructEntry.GainedExperience,b,x

        sep #$20
        lda #0
        sta @l $7ECCDF
        rep #$20

        lda #$0037
        sta wBattleSong
        clc
        rts

        .databank 0

      rsActionStructDoNothing ; 84/EAD8

        .al
        .autsiz
        .databank ?

        rts

        .databank 0

      rsActionStructStealMoney ; 84/EAD9

        .al
        .autsiz
        .databank ?

        ; Moves the defender's money to the attacker, unless this is the arena, the
        ; attacker already has 50000 or the defender has none.

        ; check if its an arena fight

        lda wBattleType
        and #$00FF
        cmp #1
        beq _End

          ; check if unit already has capped money
          lda structActionStructEntry.UnitRAMPointer,b,x
          sta wSelectedUnitDataRAMPointer,b
          jsl rlGetSelectedUnitMoney
          cmp #50000
          bcs _End

            ; check if target is broke
            lda structActionStructEntry.UnitRAMPointer,b,y
            sta wSelectedUnitDataRAMPointer,b
            jsl rlGetSelectedUnitMoney
            ora #0
            beq _End

              sta wBattleTempVariable
              sta wRoutineVariable1,b
              jsl rlSubtractSelectedCharacterMoney

              lda structActionStructEntry.UnitRAMPointer,b,x
              sta wSelectedUnitDataRAMPointer,b
              jsl rlAddSelectedCharacterMoney

              lda structActionStructEntry.ObtainedStealMoney,b,x
              clc
              adc wBattleTempVariable
              sta structActionStructEntry.ObtainedStealMoney,b,x

        _End
        rts

        .databank 0

        ; 84/EB24

    .endsection BattleSection


    .section Unsorted84BB54Section

      .al
      .xl

      rlStartBattleSceneOrMapBattle ; 84/BB54

        .al
        .autsiz
        .databank ?

        ; Starts the battle as the battle scene, or as a map battle when battle animations are off (rlCheckIfBattleAnimationOFF).

        jsl rlCheckIfBattleAnimationOFF
        bcs _Off

        ; On
        jsl rlStartBattleScene
        bra +

        _Off
        jsl rlStartMapBattle

        +
        rtl

        .databank 0

    .endsection Unsorted84BB54Section


