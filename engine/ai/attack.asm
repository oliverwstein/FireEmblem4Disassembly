; Choosing whom to attack and from which tile: attack tiles, attack chances (with
; special cases for silencable and injured foes), expected damage dealt and taken,
; and the nearest reachable target.

    .section AIAttackSection

      .al
      .xl

      rlAIEvaluateAttackTilesForTarget ; 86/9F35

        .al
        .autsiz
        .databank ?

        ; Iterate candidate attack tiles around target within min..max range

        phb
        php

        sep #$20
        lda #$7F
        pha
        rep #$20
        plb
        .databank $7F

        phx
        lda wSelectedUnitDataRAMPointer
        pha
        lda wCurrentItemDataROMPointer
        pha

        lda #63
        sta aAIAction.wMapWidth

        lda wCurrentChapter
        bne +

        lda #31
        bra ++

        +
        lda #63

        +
        sta aAIAction.wMapHeight

        lda aAIAction.wTargetXPosition
        sta aAIAction.wAttackTileXPosition

        lda aAIAction.wTargetYPosition
        clc
        adc aAIAction.wMinimumAttackRange
        sta aAIAction.wAttackTileYPosition

        lda aAIAction.wTargetYPosition
        clc
        adc aAIAction.wMinimumAttackRange
        xba
        lsr a
        lsr a
        clc
        adc aAIAction.wTargetXPosition
        sta aAIAction.wAttackTileMapTileIndex

        lda aAIAction.wTileEvaluationType
        asl a
        tax
        lda aAIAttackTileEvaluationRoutines,x
        sta lAITemp000E93

        ; Keep track of the max - min range.
        ; Eg for weapons with only 1 specified range, like an iron sword 
        ; or bow, it only needs to check all directions once.
        ; For a weapon with different ranges like a javelin, it needs to check
        ; all directions at 2 range, and then all directions at 1 range.

        lda aAIAction.wMaximumAttackRange
        sec
        sbc aAIAction.wMinimumAttackRange
        bcs +

          jml _End

        +
        sta aAIAction.wMaximumAttackRange

        _AdditionalRangeLoop
        lda #3
        sta aAIAction.wAttackDirection

          ; Here it sets up a counter for additional tiles in the 
          ; modified direction to check. For a sword, after checking down
          ; the next thing to check would be left, so no additional tiles
          ; are needed. For a bow though, after checking down, we also
          ; need to check an additional tile in the bottom left before
          ; advancing to the left check. Weapons with min 3 range need
          ; to check 2 additional tiles, etc.

          _DirectionLoop
          lda aAIAction.wMinimumAttackRange
          dec a
          sta aAIAction.wAdditionalAttackDirections

          lda aAIAction.wAttackDirection
          asl a
          tax
          lda aAttackMapTileIndexModifiers,x
          sta aAIAction.wAttackMapTileIndexModifier
          lda aAttackTileXPositionModifiers,x
          sta aAIAction.wAttackTileXPositionModifier
          lda aAttackTileYPositionModifiers,x
          sta aAIAction.wAttackTileYPositionModifier

            ; Check if attack tile is within the map boundaries
            _DirectionCounterLoop
            lda aAIAction.wAttackTileXPosition
            cmp #1
            bmi +

              cmp aAIAction.wMapWidth
              bpl +

                lda aAIAction.wAttackTileYPosition
                cmp #1
                bmi +

                  cmp aAIAction.wMapHeight
                  bpl +

                    pea #<>(+)-1
                    jmp (lAITemp000E93)

            +
            lda aAIAction.wAttackTileXPosition
            clc
            adc aAIAction.wAttackTileXPositionModifier
            sta aAIAction.wAttackTileXPosition

            lda aAIAction.wAttackTileYPosition
            clc
            adc aAIAction.wAttackTileYPositionModifier
            sta aAIAction.wAttackTileYPosition

            lda aAIAction.wAttackTileMapTileIndex
            clc
            adc aAIAction.wAttackMapTileIndexModifier
            sta aAIAction.wAttackTileMapTileIndex

            dec aAIAction.wAdditionalAttackDirections
            bpl _DirectionCounterLoop

          dec aAIAction.wAttackDirection
          bpl _DirectionLoop

        lda aAIAction.wAttackTileMapTileIndex
        clc
        adc #64
        sta aAIAction.wAttackTileMapTileIndex

        inc aAIAction.wAttackTileYPosition
        inc aAIAction.wMinimumAttackRange

        dec aAIAction.wMaximumAttackRange
        bmi _End

          jml _AdditionalRangeLoop

        _End
        pla
        sta wCurrentItemDataROMPointer
        pla
        sta wSelectedUnitDataRAMPointer
        plx
        plp
        plb
        rtl

        .databank 0

      aAIAttackTileEvaluationRoutines ; 86/A035

        .word <>rsAIEvaluateStatusStaffTile
        .word <>rsAIEvaluateHealingStaffTile
        .word <>rsAIEvaluateWeaponAttackTile

      aAttackMapTileIndexModifiers ; 86/A03B

        ; 1st attack is always down from target
        ; Then bottom left of target

        .sint  64 - 1
        .sint  64 + 1
        .sint -64 + 1
        .sint -64 - 1

      aAttackTileXPositionModifiers ; 86/A043

        .sint -1
        .sint  1
        .sint  1
        .sint -1

      aAttackTileYPositionModifiers ; 86/A04B

        .sint  1
        .sint  1
        .sint -1
        .sint -1

      rsAICheckIfAttackTileOccupied ; 86/A053

        .al
        .autsiz
        .databank $7F

        ; Output:
        ; CLC if tile free, SEC if occupied
        ; A = movement cost of the attack tile

        ; Check if unit already on attack tile

        ldx aAIAction.wAttackTileMapTileIndex
        lda aUnitMap,x
        and #$00FF
        cmp aAIAction.wUntDeploymentOffset
        beq _CLC

          ; Check if tile is blocked by anyone else
          cmp #$00FF
          bne _SEC

            ; Attack tile isnt occupied
            lda aAIAction.wAttackTileMapTileIndex
            asl a
            tax
            lda @l aMapData,x
            and #$03FF
            tax
            lda @l aTerrainTileset,x
            and #$00FF
            sta aAIAction.wAttackTileTerrainType
            clc
            adc aAIAction.wUnitMovementCostPointer
            tax
            lda $830000,x
            and #$00FF
            cmp #$007F
            bcs _SEC

        _CLC
        clc
        rts

        _SEC
        sec
        rts

        .databank 0

      rsAIEvaluateStatusStaffTile ; 86/A092

        .al
        .autsiz
        .databank ?

        ; Evaluate candidate tile for status staff (action 8)

        jsr rsAICheckIfAttackTileIsValid
        bcc +

          jsr rsCheckIfUnitOnAttackTile
          bcc +

            jsr rsAICalculateAttackChanceIfFoeSilencable
            bcc +

              jsr rsAICheckIfNewBestTarget
              bcc +

                lda #8
                sta $4440,b

        +
        rts

        .databank 0

      rsAICalculateAttackChanceIfFoeSilencable ; 86/A0AD

        .al
        .autsiz
        .databank $7F

        lda wSelectedUnitDataRAMPointer
        pha

        ldx aAIAction.wTargetDeploymentOffset
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer
        jsl rlGetSelectedUnitStatus
        cmp #StatusSilence
        bcs _CLC

          jsl rlGetSelectedUnitTotalResistance
          sta aAIAction.wTempValue
          jsl rlGetFirstWeaponBattleMight
          sta aAIAction.wTargetsBattleMight

          ldx aAIAction.wUntDeploymentOffset
          lda aDeploymentTable._UnitRAMPointer,x
          sta wSelectedUnitDataRAMPointer

          lda wAISelectedAITargetOffset
          tax
          jsl rlGetSelectedUnitTotalMagic
          sep #$20
          cmp aAIAction.wTempValue
          rep #$20
          beq _CLC
          bcc _CLC

            phx
            jsr rsAIGetAttackTileThreatValue
            sta aAIAction.wAttackTileThreatValue
            jsr rsAIGetUnitDistanceToAttackTile
            sta aAIAction.wUnitToAttackTileDistance
            plx

            lda aAIAction.wTargetsBattleMight
            and #$00FF
            sta aAIAction.wExpectedTakenDamage

            lda #300
            clc
            adc aAIAction.wExpectedTakenDamage
            sec
            sbc aAIAction.wAttackTileThreatValue
            sta aAIAction.wAttackChance

            pla
            sta wSelectedUnitDataRAMPointer
            sec
            rts

        _CLC
        pla
        sta wSelectedUnitDataRAMPointer
        clc
        rts

        .databank 0

      rsAIEvaluateHealingStaffTile ; 86/A126

        .al
        .autsiz
        .databank ?

        ; Evaluate candidate tile for healing staff (action 14)

        jsr rsAICheckIfAttackTileIsValid
        bcc +

          jsr rsAICheckIfAttackTileReachableByUnit
          bcc +

            jsr rsAICalculateAttackChanceIfFoeInjured
            bcc +

              jsr rsAICheckIfNewBestTarget
              bcc +

                lda #14
                sta $4440,b

        +
        rts

        .databank 0

      rsAICalculateAttackChanceIfFoeInjured ; 86/A141

        .al
        .autsiz
        .databank $7F

        ; Output:
        ; CLC if foe at full HP, SEC if injured

        jsr rsAIGetUnitDistanceToAttackTile
        sta aAIAction.wUnitToAttackTileDistance

        lda #$C000
        sta aAIAction.wAttackChance

        jsr rsAIGetAttackTileThreatValue
        sta aAIAction.wAttackTileThreatValue

        ldx aAIAction.wTargetDeploymentOffset
        jsl rlAIGetMissingHPRatio
        ora #0
        beq _CLC

          sta aAIAction.wTargetHPBonus

          lda #500
          clc
          adc aAIAction.wTargetHPBonus
          sec
          sbc aAIAction.wAttackTileThreatValue
          sta aAIAction.wAttackChance

          sec
          rts

        _CLC
        clc
        rts

        .databank 0

      rsAIEvaluateWeaponAttackTile ; 86/A174

        .al
        .autsiz
        .databank $7F

        jsr rsAICheckIfAttackTileIsValid
        bcc +

          lda aAIAction.wAttackType
          asl a
          tax
          jsr (aAIAttackTypeRoutines,x)
          bcc +

            jsr rsAICheckIfNewBestTarget
            bcc +

              lda #1
              sta $4440,b

        +
        rts

        .databank 0

      aAIAttackTypeRoutines ; 86/A18F

        .word <>rsAICheckAttackTypeIntimidate ; AttackTypeIntimidate
        .word <>rsAICheckAttackTypeReachable ; AttackTypeReachable
        .word <>rsAICheckAttackTypeRegular ; AttackTypeRegular
        .word <>rsAICheckAttackTypeNever ; never attacks
        .word <>rsAICheckAttackTypeCautious ; AttackTypeCautious
        .word <>rsAICheckAttackTypeDefendingCastle ; AttackTypeDefendingCastle
        .word <>rsAICheckAttackTypeNever ; never attacks
        .word <>rsAICheckAttackTypeRegular ; AttackTypeRegular
        .word <>rsAICheckAttackTypeRegular ; AttackTypeRegular

      rsAICheckAttackTypeIntimidate ; 86/A1A1

        .al
        .autsiz
        .databank $7F

        ; AttackTypeIntimidate

        ; Can be intimidated? Charge if far away from foe, may not attack if close by?

        ; Tile needs to be reachable
        ; Expected inflicted damage > 0
        ; Units HP/2 + turn/2 >= taken damage
        ; Nobody in groups threat range > charge, else
        ; something with move distance?

        jsr rsAICheckIfAttackTileReachableByUnit
        bcc _CLC

          jsr rsAICalculateAttackChance
          bcc _CLC

            lda aAIAction.wUnitCurrentHP
            lsr a
            clc
            adc aAIAction.wTurnValue
            cmp aAIAction.wExpectedTakenDamage
            bcc _CLC

              lda wAIGroupFlags
              bit #$0004
              beq _SEC

                lda aAIAction.wMovementDistanceToTarget
                cmp aAIAction.wAttackTileDistanceToGroupTarget
                bcc _CLC

              _SEC
              sec
              rts
        
        _CLC
        clc
        rts

        .databank 0

      rsAICheckAttackTypeReachable ; 86/A1CD

        .al
        .autsiz
        .databank ?

        ; AttackTypeReachable: require only that attack tile is reachable

        ; AttackTypeReachable

        ; Tile just needs to be reachable

        jsr rsAICheckIfAttackTileReachableByUnit
        rts

        .databank 0

      rsAICheckAttackTypeRegular ; 86/A1D1

        .al
        .autsiz
        .databank ?

        ; AttackTypeRegular: require reachable attack tile and expected dmg > 0

        ; AttackTypeRegular

        ; Tile needs to be reachable
        ; Expected inflicted damage > 0

        jsr rsAICheckIfAttackTileReachableByUnit
        bcc +

          jsr rsAICalculateAttackChance
          bcc +

            sec
            rts

        +
        clc
        rts

        .databank 0

      rsAICheckAttackTypeNever ; 86/A1DF

        .al
        .autsiz
        .databank ?

        ; Attack types 3 and 6: rejects every tile (carry clear), so a unit with this
        ; attack type never attacks; it only moves and interacts.

        clc
        rts

        .databank 0

      rsAICheckAttackTypeCautious ; 86/A1E1

        .al
        .autsiz
        .databank $7F

        ; AttackTypeCautious

        ; Tile needs to be reachable
        ; Expected inflicted damage > 0
        ; Units HP - 5 + turn/2 >= taken damge
        ; Inflicted Dmg/2 + turn/2 >= taken damge
        ; current HP *3 >= threat value

        jsr rsAICheckIfAttackTileReachableByUnit
        bcc _CLC

          jsr rsAICalculateAttackChance
          bcc _CLC

            lda aAIAction.wUnitCurrentHP
            sec
            sbc #5
            clc
            adc aAIAction.wTurnValue
            cmp aAIAction.wExpectedTakenDamage
            bcc _CLC

              lda aAIAction.wExpectedInflictedDamage
              lsr a
              eor #$FFFF
              inc a
              clc
              adc aAIAction.wExpectedInflictedDamage
              clc
              adc aAIAction.wTurnValue
              cmp aAIAction.wExpectedTakenDamage
              bcc _CLC

                lda aAIAction.wUnitCurrentHP
                asl a
                clc
                adc aAIAction.wUnitCurrentHP
                cmp aAIAction.wAttackTileThreatValue
                bcc _CLC

                  sec
                  rts

        _CLC
        clc
        rts

        .databank 0

      rsAICheckAttackTypeDefendingCastle ; 86/A221

        .al
        .autsiz
        .databank ?

        ; AttackTypeDefendingCastle: require unit already on tile and expected dmg > 0

        ; AttackTypeDefendingCastle

        ; Tile needs to be reachable
        ; Expected inflicted damage > 0

        jsr rsCheckIfUnitOnAttackTile
        bcc +

          jsr rsAICalculateAttackChance
          bcc +

            sec
            rts

        +
        clc
        rts

        .databank 0

      rsAICheckIfAttackTileReachableByUnit ; 86/A22F

        .al
        .autsiz
        .databank $7F

        ldx aAIAction.wAttackTileMapTileIndex
        lda aMovementMap,x
        and #$00FF
        beq +

          sec
          rts

        +
        clc
        rts

        .databank 0

      rsCheckIfUnitOnAttackTile ; 86/A23E

        .al
        .autsiz
        .databank ?

        jsr rsAIGetUnitDistanceToAttackTile
        bne +

          sec
          rts

        +
        clc
        rts

        .databank 0

      rsAICheckIfAttackTileIsValid ; 86/A247

        .al
        .autsiz
        .databank $7F

        jsr rsAICheckIfAttackTileOccupied
        bcs _CLC

          ; Tile is free
          lda aAIAction.wAttackTileTerrainType
          cmp #TerrainCastleGate
          beq _CLC

            sec
            rts

        _CLC
        clc
        rts

        .databank 0

      rsAICheckIfNewBestTarget ; 86/A258

        .al
        .autsiz
        .databank $7F

        ; SEC = target new unit, CLC not

        ; Check if the prior attack chance is the default value, if yes branch
        lda aAIAction.wBestAttackChance
        cmp #$C000
        beq +

          ; If a RN is equal or higher than the leadership power and an even value,
          ; Write the current attack chance over the best one, even if it makes it worse

          jsl rlGetRandomNumber
          cmp aAIAction.wLeadershipPower
          bcc +

            lsr a
            bcs _CLC

              lda aAIAction.wAttackChance
              sta aAIAction.wBestAttackChance
              lda aAIAction.wUnitToAttackTileDistance
              bra _UpdateDecidedTarget

        ; If the new attack chance is worse than the previous one, exit
        ; if its equal, overwrite the old data
        ; If its better, update the chance

        +
        lda aAIAction.wAttackChance
        cmp aAIAction.wBestAttackChance
        bmi _CLC
        beq +

          sta aAIAction.wBestAttackChance
          lda aAIAction.wUnitToAttackTileDistance
          bra _UpdateDecidedTarget

        +
        lda aAIAction.wUnitToAttackTileDistance
        cmp aAIAction.wUnitToChosenTargetDistance
        bcs _CLC

        _UpdateDecidedTarget
        sta aAIAction.wUnitToChosenTargetDistance
        lda aAIAction.wUnitInventorySlot
        sta wSelectedInventorySlot
        lda aAIAction.wAttackTileXPosition
        sta aAIAction.wDestinationXPosition
        lda aAIAction.wAttackTileYPosition
        sta aAIAction.wDestinationYPosition
        lda aAIAction.wTargetDeploymentOffset
        sta aAIAction.wChosenTargetDeploymentOffset
        sec
        rts

        _CLC
        clc
        rts

        .databank 0

      rsAICalculateAttackChance ; 86/A2B1

        .al
        .autsiz
        .databank $7F

        ; Output:
        ; SEC if there is a chance, CLC if the expected inflicted damage is 0

        phy
        jsr rsAIGetUnitDistanceToAttackTile
        sta aAIAction.wUnitToAttackTileDistance

        lda #$C000
        sta aAIAction.wAttackChance

        jsr rsAIGetTargetDistanceToAttackTile
        sta aAIAction.wTargetToAttackTileDistance

        jsr rsAIGetExpectedInflictedDamage
        sta aAIAction.wExpectedInflictedDamage
        bcc +

          jml _CLC

        +
        jsr rsAIGetAttackTileThreatValue
        sta aAIAction.wAttackTileThreatValue

        lda aTargetDistanceMap,x
        and #$00FF
        bne +

          lda #$00FF

        +
        sta $445C,b

        lda wCurrentTurn
        lsr a
        sta aAIAction.wTurnValue

        ldx aAIAction.wTargetDeploymentOffset
        jsl rlAICheckIfUnitOnLowHP
        sta aAIAction.wTargetHPBonus
        dec y
        tya
        cmp wAITemp000E9A
        bcs +

          ; If inflicted damage > target HP, add 20 points
          lda aAIAction.wTargetHPBonus
          clc
          adc #20
          sta aAIAction.wTargetHPBonus

        +
        lda aAIAction.wAttackTileTerrainType
        sta wAITemp000E96
        lda aAIAction.wTargetToAttackTileDistance
        sta wAITemp000E98
        jsr rsAIGetExpectedTakenDamage
        sta aAIAction.wExpectedTakenDamage

        ldx aAIAction.wUntDeploymentOffset
        jsl rlAICheckIfUnitOnLowHP
        sta aAIAction.wUnitHPPenalty
        sty aAIAction.wUnitCurrentHP

        lda #0
        clc
        adc aAIAction.wExpectedInflictedDamage
        clc
        adc aAIAction.wTargetHPBonus
        sec
        sbc aAIAction.wExpectedTakenDamage
        sec
        sbc aAIAction.wUnitHPPenalty
        sec
        sbc aAIAction.wAttackTileThreatValue
        sta aAIAction.wAttackChance
        ply
        sec

        -
        rts

        _CLC
        ply
        clc
        bra -

        .databank 0

        ; 86/A24A


      rsAIGetAttackTileThreatValue ; 86/A34A

        .al
        .autsiz
        .databank $7F

        ldx aAIAction.wAttackTileMapTileIndex
        lda aRangeMap,x
        and #$00FF
        cmp #8
        bcc +

          lda #7

        +
        rts

        .databank 0

      rsAIGetTargetDistanceToAttackTile ; 86/A35C

        .al
        .autsiz
        .databank $7F

        ldx aAIAction.wTargetDeploymentOffset
        lda aAIAction.wAttackTileXPosition
        sec
        sbc aDeploymentTable._XTilePosition,x
        bpl +

          eor #$FFFF
          inc a
        
        +
        sta aAIAction.wTempValue

        lda aAIAction.wAttackTileYPosition
        sec
        sbc aDeploymentTable._YTilePosition,x
        bpl +

          eor #$FFFF
          inc a

        +
        clc
        adc aAIAction.wTempValue
        rts

        .databank 0

      rsAIGetUnitDistanceToAttackTile ; 86/A383

        .al
        .autsiz
        .databank $7F

        ldx aAIAction.wUntDeploymentOffset
        lda aAIAction.wAttackTileXPosition
        sec
        sbc aDeploymentTable._XTilePosition,x
        bpl +

          eor #$FFFF
          inc a

        +
        sta aAIAction.wTempValue

        lda aAIAction.wAttackTileYPosition
        sec
        sbc aDeploymentTable._YTilePosition,x
        bpl +

          eor #$FFFF
          inc a

        +
        clc
        adc aAIAction.wTempValue
        rts

        .databank 0

      rsAIGetExpectedInflictedDamage ; 86/A3AA

        .al
        .autsiz
        .databank ?

        phb
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb
        .databank $7E

        phx
        phy
        lda wSelectedUnitDataRAMPointer,b
        pha

        lda wAISelectedAIUnitOffset,b
        clc
        adc #<>aAIUnitList[0]
        tax
        lda wAISelectedAITargetOffset,b
        bmi _CLC

          clc
          adc #<>aAITargetList[0]
          tay
          lda structAITargetEntry.TerrainType,b,y
          and #$00FF
          sta wAITemp000E96,b
          lda aAIAction.wTargetToAttackTileDistance
          sta wAITemp000E98,b
          jsr rsAIGetExpectedDamage

          -
          plx
          stx wSelectedUnitDataRAMPointer,b
          ply
          plx
          plb
          rts
        
        _CLC
        lda #0
        clc
        bra -

        .databank 0

      rsAIGetExpectedTakenDamage ; 86/A3EC

        .al
        .autsiz
        .databank ?

        phb

        sep #$20
        lda #$7E
        pha
        rep #$20
        plb
        .databank $7E

        phx
        phy
        lda wSelectedUnitDataRAMPointer,b
        pha

        lda wAISelectedAITargetOffset,b
        bmi +

          clc
          adc #<>aAITargetList[0]
          tax

          lda wAISelectedAIUnitOffset,b
          clc
          adc #<>aAIUnitList[0]
          tay

          lda aAIAction.wAttackTileTerrainType
          sta wAITemp000E96,b
          lda aAIAction.wTargetToAttackTileDistance
          sta wAITemp000E98,b
          jsr rsAIGetExpectedDamage

          -
          plx
          stx wSelectedUnitDataRAMPointer,b
          ply
          plx
          plb
          rts
        
        +
        lda #0
        clc
        bra -

        .databank 0

      rsAIGetExpectedDamage ; 86/A42C

        .al
        .autsiz
        .databank ?

        ; Input:
        ; X = attacker AI list pointer
        ; Y = defender AI list pointer
        ; wAITemp000E96 = attack tile terrain type
        ; wAITemp000E98 = distance of target to target tile

        ; Output:
        ; SEC if its not worth attacking foe
        ; CLC and expected damage in A

        lda structAIUnitEntry.ItemROMPointer,b,x
        bne +

          jml _CLC

        +
        sta wCurrentItemDataROMPointer,b

        lda wAITemp000E98,b
        beq _A45F

          jsl rlGetItemMinimumRange
          dec a
          cmp wAITemp000E98,b
          bcc +

            jml _SEC

          +
          jsl rlGetItemMaximumRange
          cmp wAITemp000E98,b
          bcs +

            jml _SEC

          +
          jsl rlGetItemEffectiveness
          sta wAITemp000EA2,b

        _A45F
        lda structAITargetEntry.ItemType,b,y
        and #$00FF
        xba
        sta wAITemp000EA0,b

        lda structAIUnitEntry.ItemType,b,x
        and #$00FF
        ora wAITemp000EA0,b
        jsl rlGetWeaponTriangleBonus
        sta wAITemp000EA0,b

        lda structAIUnitEntry.UnitRAMPointer,b,x
        sta wSelectedUnitDataRAMPointer,b
        lda structAIUnitEntry.ItemType,b,x
        and #$00FF
        cmp #WeaponTypeStaff
        bcs +

        lda structAITargetEntry.BattleDefense,b,y
        bra ++
        
        +
        lda structAITargetEntry.BattleResistance,b,y
        
        +
        and #$00FF
        sta wAITemp000E9C,b

        jsl rlGetSelectedUnitBattleHit
        clc
        adc wAITemp000EA0,b
        sta wAITemp000E9E,b

        lda structAITargetEntry.UnitRAMPointer,b,y
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetClassWeakness
        bit wAITemp000EA2,b
        bne _Effective

        lda structAIUnitEntry.BattleMight,b,x
        and #$00FF
        bra +

        _Effective
        lda structAIUnitEntry.BattleMight,b,x
        and #$00FF
        asl a

        +
        sec
        sbc wAITemp000E9C,b
        cmp #1
        bmi _SEC

          ; AI unit can do damage to target
          sta wAITemp000E9A,b

          lda structAIUnitEntry.ItemType,b,x
          and #$00FF
          xba
          sta wAITemp000EA0,b

          lda structAITargetEntry.ItemType,b,y
          and #$00FF
          ora wAITemp000EA0,b
          jsl rlGetWeaponTriangleBonus
          sta wAITemp000EA0,b

          lda structAITargetEntry.ItemROMPointer,b,y
          sta wCurrentItemDataROMPointer,b

          lda wAITemp000E96,b
          jsl rlGetSelectedUnitBattleAvoid
          clc
          adc wAITemp000EA0,b
          sta wAITemp000EA0,b

          lda wAITemp000E9E,b
          sec
          sbc wAITemp000EA0,b
          bmi _SEC
          beq _SEC

          cmp #101
          bmi +

            lda #100

          +
          jsl rlConvertChanceToFullByte
          sta wR34
          lda wAITemp000E9A,b
          and #$00FF
          xba
          sta wR35
          jsl rlUnsignedMultiply16By16High
          lda wR37

          _CLC
          clc
          rts

        _SEC
        lda #0
        sec
        rts

        .databank 0

      rlAIGetExpectedDamageWrapper ; 86/A52A

        .al
        .autsiz
        .databank ?

        jsr rsAIGetExpectedDamage
        rtl

        .databank 0

      rlGetNearestPossibleTarget ; 86/A52E

        .al
        .autsiz
        .databank ?

        ; Fills target distance map until it hits the first target set in aTargetMap.

        ; Input:
        ; wAITemp000E96 = Start X coord
        ; wAITemp000E98 = Start Y coord

        ; Output:
        ; SEC if success, CLC if not
        ; A = target value
        ; wAITemp000E9A = Target X coord
        ; wAITemp000E9C = Target Y coord

        phb
        php
        phk
        plb
        phx
        phy

        sep #$20
        lda #$7F
        pha
        rep #$20
        plb
        .databank $7F

        lda #`aTargetDistanceMap
        ldx #<>aTargetDistanceMap
        jsl rlClearMapBufferAddBorders

        ; Get map tile index
        lda wAITemp000E98
        xba
        lsr a
        lsr a
        clc
        adc wAITemp000E96
        tay

        lda aTargetMap,y
        bit #$0080
        bne +

          jml _UnitOnTarget

        +
        sep #$20
        lda #1
        sta aTargetDistanceMap,y
        rep #$20

        sty aMapTraversalList

        ; wR34 holds the running movement cost for the traversed distance
        ; wR35 holds the last offset of the map tile index that needs to be analyzed
        ; wR36 holds the current offset for aMapTraversalList

        stz wR35

        lda #2
        sta wR36
        lda #1
        sta wR34
        
        _Loop
        ldx wR35

        stz wR37
        sep #$20

          -
          ldy aMapTraversalList,x
          lda aTargetDistanceMap,y
          cmp wR34
          bne +
          bra _HandleUp

            _MarkFinishedMapTileIndex
            lda #$FF
            sta aMapTraversalList+1,x
            sta wR37

          +
          dec x
          dec x
          bpl -

        ; Done handling all previous entries.

        rep #$20
        lda wR37
        beq ++

        ; Overwrite marked entries and shift all following ones forward.

        ldx #0
        ldy #0

          -
          lda aMapTraversalList,x
          bmi +

            sta aMapTraversalList,y
            inc y
            inc y

          +
          inc x
          inc x
          cpx wR36
          bne -

        sty wR36

        +
        lda wR36
        beq +

          dec a
          dec a
          sta wR35

          inc wR34
          lda wR34
          cmp #$00FC
          bne _Loop

        +
        ply
        plx
        plp
        plb
        clc
        rtl

        _HandleUp
        phx
        ldx wR36

        lda aTargetDistanceMap - 64,y
        bne _HandleLeft

          ; The distance map in this direction is still empty.

          lda aMovementCostMap - 64,y
          bmi +

            ; Unit can move upwards.

            clc
            adc wR34
            sta aTargetDistanceMap - 64,y
            rep #$20
            tya
            clc
            adc #-64
            sta aMapTraversalList,x
            inc x
            inc x
            sep #$20
            bra ++

          +
          lda #$FF
          sta aTargetDistanceMap - 64,y

          +
          lda aTargetMap - 64,y
          bmi _HandleLeft

            jml _TargetIsUpwards

        _HandleLeft
        lda aTargetDistanceMap - 1,y
        bne _HandleRight

          lda aMovementCostMap - 1,y
          bmi +

          clc
          adc wR34
          sta aTargetDistanceMap - 1,y
          rep #$20
          tya
          clc
          adc #-1
          sta aMapTraversalList,x
          inc x
          inc x
          sep #$20
          bra ++

        +
        lda #$FF
        sta aTargetDistanceMap - 1,y
        
        +
        lda aTargetMap - 1,y
        bmi _HandleRight

          jml _TargetIsLeftwards

        _HandleRight
        lda aTargetDistanceMap + 1,y
        bne _HandleDown

          lda aMovementCostMap + 1,y
          bmi +

          clc
          adc wR34
          sta aTargetDistanceMap + 1,y
          rep #$20
          tya
          clc
          adc #1
          sta aMapTraversalList,x
          inc x
          inc x
          sep #$20
          bra ++
          
        +
        lda #$FF
        sta aTargetDistanceMap + 1,y
        
        +
        lda aTargetMap + 1,y
        bmi _HandleDown

          jml _TargetIsRightwards

        _HandleDown
        lda aTargetDistanceMap + 64,y
        bne _HandleNextTile

          lda aMovementCostMap + 64,y
          bmi +

          clc
          adc wR34
          sta aTargetDistanceMap + 64,y
          rep #$20
          tya
          clc
          adc #64
          sta aMapTraversalList,x
          inc x
          inc x
          sep #$20
          bra ++

        +
        lda #$FF
        sta aTargetDistanceMap + 64,y
        
        +
        lda aTargetMap + 64,y
        bmi _HandleNextTile

          jml _TargetIsDownwards

        _HandleNextTile
        stx wR36
        plx
        jml _MarkFinishedMapTileIndex

        _TargetIsUpwards
        plx
        ldx #-64
        bra +
        
        _TargetIsLeftwards
        plx
        ldx #-1
        bra +
        
        _TargetIsRightwards
        plx
        ldx #1
        bra +
        
        _TargetIsDownwards
        plx
        ldx #64
        bra +

        _UnitOnTarget
        ldx #0

        +
        rep #$20
        and #$00FF
        pha

        txa
        sta wR37
        tya
        clc
        adc wR37
        tay
        and #$003F
        sta wAITemp000E9A
        tya
        lsr a
        lsr a
        lsr a
        lsr a
        lsr a
        lsr a
        sta wAITemp000E9C

        pla
        ply
        plx
        plp
        plb
        sec
        rtl

        .databank 0

    .endsection AIAttackSection


    .section Unsorted86C333Section

      .al
      .xl

      rlAIGetClassWeight ; 86/C333

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ; Unused; look up class-based AI weight byte for unit at deployment offset X

        phb
        php
        phk
        plb
        .databank $86
        phx
        lda @l wSelectedUnitDataRAMPointer
        pha
        lda aDeploymentTable._UnitRAMPointer,x
        sta @l wSelectedUnitDataRAMPointer
        jsl rlGetSelectedUnitClassID
        tax
        lda @l aAIClassWeightTable,x
        and #$00FF
        plx
        stx wSelectedUnitDataRAMPointer,b
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 86/C359

    .endsection Unsorted86C333Section


    .section Table86C359Section

      .al
      .xl

      aAIClassWeightTable ; 86/C359

        ; Read by rlAIGetClassWeight.

        .byte $01, $01, $03, $01, $01, $00, $01, $00, $00, $00, $02, $00, $00, $00, $01, $00
        .byte $00, $01, $00, $00, $03, $01, $00, $02, $00, $00, $00, $00, $01, $01, $01, $05
        .byte $01, $00, $00, $00, $00, $01, $00, $00, $00, $03, $01, $05, $05, $03, $03, $05
        .byte $05, $05, $01, $01, $01, $01, $01, $06, $06, $06, $01, $01, $00, $00, $05, $01
        .byte $14, $14, $00, $00, $00, $00, $00

        ; 86/C3A0

    .endsection Table86C359Section


    .section Unsorted86C3A0Section

      .al
      .xl

      rlAIGetClassTargetPriority ; 86/C3A0

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Called only by rsAIScoreTargetsNearLeader, which nothing reaches. Looks up the class-based AI target priority score for unit at deployment offset X

        phb
        php
        phk
        plb
        .databank $86
        phx
        lda @l wSelectedUnitDataRAMPointer
        pha
        lda aDeploymentTable._UnitRAMPointer,x
        sta @l wSelectedUnitDataRAMPointer
        jsl rlGetSelectedUnitClassID
        tax
        lda @l aAIClassTargetPriorityTable,x
        and #$00FF
        plx
        stx wSelectedUnitDataRAMPointer,b
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 86/C3C6

    .endsection Unsorted86C3A0Section


    .section Table86C3C6Section

      .al
      .xl

      aAIClassTargetPriorityTable ; 86/C3C6

        ; Read by rlAIGetClassTargetPriority.

        .byte $14, $14, $14, $14, $14, $14, $50, $50, $50, $50, $28, $50, $50, $50, $14, $14
        .byte $50, $14, $14, $50, $14, $14, $14, $14, $50, $3C, $50, $50, $0A, $0A, $0A, $0A
        .byte $0A, $28, $28, $14, $28, $00, $14, $0A, $14, $00, $00, $28, $14, $14, $14, $14
        .byte $14, $00, $00, $14, $14, $14, $14, $50, $50, $50, $0A, $00, $00, $00, $0A, $14
        .byte $00, $00, $00, $00, $00, $00, $00

        ; 86/C40D

    .endsection Table86C3C6Section


    .section Unsorted86C40DSection

      .al
      .xl

      rlAIGetWeaponTriangleScore ; 86/C40D

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Called only by rsAIScoreTargetsNearLeader, which nothing reaches. Returns the weapon triangle bonus (0 or 20) for attacker vs defender offsets

        phb
        php
        phk
        plb
        .databank $86
        phx
        lda @l wSelectedUnitDataRAMPointer
        pha
        ldx wAITemp000E96,b
        lda aDeploymentTable._UnitRAMPointer,x
        sta @l wAITemp000E96
        ldx wAITemp000E98,b
        lda aDeploymentTable._UnitRAMPointer,x
        sta @l wAITemp000E98
        lda @l wAITemp000E96
        sta @l wSelectedUnitDataRAMPointer
        jsl rlGetFirstEquippableWeaponInInventory
        lda @l wCurrentItemDataROMPointer
        beq _C466
        jsl rlGetItemWeaponType
        sta @l wRoutineVariable1
        lda @l wAITemp000E98
        sta @l wSelectedUnitDataRAMPointer
        jsl rlGetFirstEquippableWeaponInInventory
        lda @l wCurrentItemDataROMPointer
        beq _C466
        jsl rlGetItemWeaponType
        xba
        ora @l wRoutineVariable1
        jsl rlGetWeaponTriangleBonus

        _C466
        plx
        stx wSelectedUnitDataRAMPointer,b
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 86/C46E

      rlAIGetEffectivenessScore ; 86/C46E

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Called only by rsAIScoreTargetsNearLeader, which nothing reaches. Returns 50 if the attacker's weapon is effective against defender class

        phb
        php
        phk
        plb
        .databank $86
        phx
        lda @l wSelectedUnitDataRAMPointer
        pha
        ldx wAITemp000E96,b
        lda aDeploymentTable._UnitRAMPointer,x
        sta @l wAITemp000E96
        ldx wAITemp000E98,b
        lda aDeploymentTable._UnitRAMPointer,x
        sta @l wAITemp000E98
        lda @l wAITemp000E98
        sta @l wSelectedUnitDataRAMPointer
        jsl rlGetClassWeakness
        sta @l wAITemp000E9A
        lda @l wAITemp000E96
        sta @l wSelectedUnitDataRAMPointer
        jsl rlGetFirstEquippableWeaponInInventory
        lda @l wCurrentItemDataROMPointer
        beq _C4BC
        jsl rlGetItemEffectiveness
        bit wAITemp000E9A,b
        beq _C4BC
        lda #$0032

        _C4BC
        plx
        stx wSelectedUnitDataRAMPointer,b
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 86/C4C4

    .endsection Unsorted86C40DSection

