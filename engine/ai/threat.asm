; Threat ranges: whether any foe can reach a unit's allies, and how far a unit
; can attack.

    .section AIThreatSection

      .al
      .xl

      rlAIUpdateModeIfFoeInThreatRange ; 86/AF39

        .al
        .autsiz
        .databank ?

        ; If any foe is in group threat range ($04), update wAIUnknown7E2002 via jump table

        phb
        php

        sep #$20
        lda #`wAIUnknownBitfield7E2000
        pha
        rep #$20
        plb
        .databank `wAIUnknownBitfield7E2000

        lda @l wAIUnknownBitfield7E2000
        bit #$0004
        beq +

          lda wAIUnknown7E2002
          asl a
          tax
          jsr (aAIThreatUpdateModeRoutines,x)

        +
        plp
        plb
        rtl

        .databank 0

      aAIThreatUpdateModeRoutines ; 86/AF57

        .word <>rsAIThreatKeepMode
        .word <>rsAIThreatSwitchMode1To2
        .word <>rsAIThreatKeepMode
        .word <>rsAIThreatKeepMode
        .word <>rsAIThreatKeepMode
        .word <>rsAIThreatKeepMode
        .word <>rsAIThreatKeepMode
        .word <>rsAIThreatKeepMode
        .word <>rsAIThreatKeepMode

      rsAIThreatKeepMode ; 86/AF69

        .al
        .autsiz
        .databank ?

        ; Leave wAIUnknown7E2002 unchanged

        rts

        .databank 0

      rsAIThreatSwitchMode1To2 ; 86/AF6A

        .al
        .autsiz
        .databank $7E

        lda #2
        sta wAIUnknown7E2002
        rts

        .databank 0

      rlAICheckIfAnyFoeInAlliesThreatRange ; 86/AF71

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`wAIUnknownBitfield7E2000
        pha
        rep #$20
        plb
        .databank `wAIUnknownBitfield7E2000

        phx
        phy

        lda wAITargetCounter
        bne +

          jml _End

        +
        sta wAITemp000E9A,b

        ldx #<>aAITargetList[0]

          ; Outer loop goes over all targets, inner loop over all allies

          _OuterLoop
          phx
          lda structAITargetEntry.DeploymentOffset,b,x
          and #$00FF
          tax
          lda aDeploymentTable._State,x
          plx

          bit #(DeploymentStateDefeated | DeploymentStateHidden)
          bne _Next

            lda structAITargetEntry.XPosition,b,x
            and #$00FF
            sta wAITemp000E96,b
            lda structAITargetEntry.YPosition,b,x
            and #$00FF
            sta wAITemp000E98,b

            lda wAIUnitCounter
            bne +

              jml _End
            
            +
            sta wAITemp000E9C,b

            ldy #<>aAIUnitList[0]

              _InnerLoop
              lda structAIUnitEntry.XPosition,b,y
              and #$00FF
              sec
              sbc wAITemp000E96,b
              bpl +

                eor #$FFFF
                inc a

              +
              sta wR35

              lda structAIUnitEntry.YPosition,b,y
              and #$00FF
              sec
              sbc wAITemp000E98,b
              bpl +

                eor #$FFFF
                inc a

              +
              clc
              adc wR35
              sta wR35

              ; wR35 holds distance to target

              lda structAIUnitEntry.ThreatRange,b,y
              and #$00FF
              cmp wR35
              bcs _SEC

              tya
              clc
              adc #size(structAIUnitEntry)
              tay
              dec wAITemp000E9C,b
              bne _InnerLoop

          _Next
          txa
          clc
          adc #size(structAITargetEntry)
          tax
          dec wAITemp000E9A,b
          bne _OuterLoop
        
        _End
        ply
        plx
        plp
        plb
        clc

        -
        rtl

        _SEC
        lda #$0004
        tsb wAIUnknownBitfield7E2000

        ply
        plx
        plp
        plb
        sec
        bra -

        .databank 0

      rlAIUpdateGroupTargetAndWaypoint ; 86/B018

        .al
        .autsiz
        .databank ?

        ; Find nearest group target tile, compute leader's turn waypoint, and orient formation

        ; Builds target distance map around group leader

        phb
        php

        sep #$20
        lda #`wAIUnknownBitfield7E2000
        pha
        rep #$20
        plb
        .databank `wAIUnknownBitfield7E2000

        phx
        lda wAIUnknownBitfield7E2000
        bit #$0020
        bne +

          jml _End

        +
        lda wAIGroupObjective
        bne +

          jml _End

        +
        jsl rlTryGetAIFactionGroupLeader

        lda wAIGroupLeaderXPosition
        sta wAIUnknown7E2010
        sta wAITemp000E96,b

        lda wAIGroupLeaderYPosition
        sta wAIUnknown7E2012
        sta wAITemp000E98,b

        jsl rlFillMovementCostMapSpecial

        jsl rlGetNearestPossibleTarget
        bcs +

          jml _End

        +
        sta wAIUnknown7E2018

        ; Get the targets coords
        lda wAITemp000E9A,b
        sta wAIUnknown7E2014
        lda wAITemp000E9C,b
        sta wAIUnknown7E2016

        lda wAIGroupObjective
        cmp #6
        bne +

          lda wAIUnknown7E2002
          cmp #4
          beq _B0A6

            jml _End

        +
        lda wAIUnknownBitfield7E2000
        bit #$0008
        bne _B0B6

        ; Group leader isnt dead
        bit #$0110
        bne _B0A6

        lda wAIGroupLeaderDeploymentOffset
        bpl _B0B6

        lda wAIUnknown7E2002
        cmp #4
        bne +

          jml _End

        +
        cmp #5
        bne _B0A6

          jml _End

        ; Write target coords to other ram values
        _B0A6
        lda wAIUnknown7E2014
        sta wAIUnknown7E2010
        lda wAIUnknown7E2016
        sta wAIUnknown7E2012
        jml +

          _B0B6
          lda @l wAIGroupLeaderFieldMovement
          sta wAITemp000EA2,b
          jsl rlTryGetAIFactionGroupLeader
          jsl rlFillMovementMap
          jsl rlTraceTargetPathToReachableTile

          lda wAITemp000E96,b
          sta wAIUnknown7E2010
          lda wAITemp000E98,b
          sta wAIUnknown7E2012

        +
        jsl rlAIUpdateFormationDirectionTowardTarget

        lda wAICurrentAISetting,b
        jsl rlAISetGroupTargetReadyFlag

        _End
        plx
        plp
        plb
        rtl

        .databank 0

      rlGetSelectedUnitAttackThreatRange ; 86/B0E4

        .al
        .autsiz
        .databank ?

        phx
        jsl rlGetHighestRangeItemInInventory

        lda wCurrentItemDataROMPointer,b
        beq +

          jsl rlGetItemMaximumRange
          bra ++

          +
          lda #0

        +
        sta wAITemp000EA4,b

        lda $7E2002
        cmp #5
        bne +

          lda wAITemp000EA4,b
          bra _END

        +
        jsl rlGetSelectedUnitTotalMovement
        inc a
        tax
        lda _MovementThreatRangeLookupTable,x
        and #$00FF
        clc
        adc wAITemp000EA4,b
        
        _END
        plx
        rtl

        .databank 0

        _MovementThreatRangeLookupTable ; 86/B11B

        ; Approximation of (Move * 10 [-1]) * 256/179)/10
        ; Leaving out the -1 part

        .byte ceil(( 0 * 10) * 256.0/179.0/10) ; =  0
        .byte ceil(( 1 * 10) * 256.0/179.0/10) ; =  2
        .byte ceil(( 2 * 10) * 256.0/179.0/10) ; =  3
        .byte ceil(( 3 * 10) * 256.0/179.0/10) ; =  5
        .byte ceil(( 4 * 10) * 256.0/179.0/10) ; =  6
        .byte ceil(( 5 * 10) * 256.0/179.0/10) ; =  8
        .byte ceil(( 6 * 10) * 256.0/179.0/10) ; =  9
        .byte ceil(( 7 * 10) * 256.0/179.0/10) ; = 11
        .byte ceil(( 8 * 10) * 256.0/179.0/10) ; = 12
        .byte ceil(( 9 * 10) * 256.0/179.0/10) ; = 13
        .byte ceil((10 * 10) * 256.0/179.0/10) ; = 15
        .byte ceil((11 * 10) * 256.0/179.0/10) ; = 16
        .byte ceil((12 * 10) * 256.0/179.0/10) ; = 18
        .byte ceil((13 * 10) * 256.0/179.0/10) ; = 19

      rlAIRunSelectedUnitTurn ; 86/B129

        .al
        .autsiz
        .databank ?

        ; Decide and initiate movement/action for the currently selected AI unit

        phb
        php
        phk
        plb

        jsr rsAIUpdateThreatRangeMap

        ldx wAISelectedAIUnitOffset,b
        lda aAIUnitList[0].UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b

        lda aAIUnitList[0].XPosition,x
        and #$00FF
        sta wAITemp000E96,b

        lda aAIUnitList[0].YPosition,x
        and #$00FF
        sta wAITemp000E98,b

        jsl rlGetSelectedUnitAI
        cmp wAICurrentAISetting,b
        beq +

          jml _End

        +
        lda aAIUnitList[0].XTargetPosition,x
        and #$00FF
        sta wAITargetXPosition,b

        lda aAIUnitList[0].YTargetPosition,x
        and #$00FF
        sta wAITargetYPosition,b

        lda #0
        sta wAIUnknown000E8E,b
        lda #$FFFF
        sta wAIUnknown000E8C,b

        ; Fill movement map
        jsl rlFillSelectedUnitMovementMap

        lda aAIUnitList[0].DeploymentOffset,x
        and #$00FF
        tax
        sta aAIAction.wUntDeploymentOffset
        lda #$FFFF
        sta aAIAction.wUnknown7F4440

        jsl rlGetSelectedUnitStates
        bit #UnitStateFielded
        bne +

          jsr rsAITryDeployUnitFromCastle
          bcc +

            jml _End

        +
        jsl rlGetSelectedUnitStatus
        cmp #StatusBerserk
        beq _Berserked

          jsr rsCheckIfCastlesCapturable
          bcs _B1E0

            lda aDeploymentTable._State,x
            bit #DeploymentStateGuardingCastle
            beq +

              jsr rsAICastleGuardAttackUnitOnGate
              bra ++

            +
            lda wAIGroupObjective
            asl a
            tax
            jsr (aAIGroupObjectiveRoutines,x)
            bcs _B1E0

            +
            lda aAIAction.wUnknown7F4440
            cmp #$FFFF
            bne _B1E0

        _Berserked
        jsl rlGetSelectedUnitStates
        bit #UnitStateCanto
        bne _B1E0

          jsr rsAIEvaluateInventoryActions

        _B1E0
        jsr rsAIMoveSelectedUnitTowardTarget
        
        _End
        plp
        plb
        rtl

        .databank 0

      aAIGroupObjectiveRoutines ; 86/B1E6

        .word <>rsAIObjectiveNoOp
        .word <>rsAIObjectiveNoOp
        .word <>rsAIObjectiveTargetVillage
        .word <>rsCheckAnyFoeInGroupRangeFlagUnset
        .word <>rsCheckAnyFoeInGroupRangeFlagUnset
        .word <>rsCheckAnyFoeInGroupRangeFlagUnset
        .word <>rsAICastleGuardAttackUnitOnGate
        .word <>rsAIObjectiveNoOp
        .word <>rsAIObjectiveInteractWithUnit
        .word <>rsAIObjectiveLeaderEnterHomeCastle
        .word <>rsAIObjectiveLeaderRetreatAndRevive
        .word <>rsAIObjectiveLeaderHoldPosition
        .word <>rsAIObjectiveAllEnterHomeCastle

      rsAIUpdateThreatRangeMap ; 86/B200

        .al
        .autsiz
        .databank ?

        ; Build aRangeMap of nearby enemy threats unless wAIUnknown7E2002 is 4 or 5

        lda wAIUnknown7E2002
        cmp #4
        beq +

          cmp #5
          beq +

            ldx wAISelectedAIUnitOffset,b
            lda aAIUnitList[0].DeploymentOffset,x
            and #$00FF
            sta aAIAction.wDestinationYPosition
            jsl rlFillRangeMapOfAITargetsNearLeader

        +
        rts

        .databank 0

      rsAIMoveSelectedUnitTowardTarget ; 86/B221

        .al
        .autsiz
        .databank ?

        ; Pathfind AI unit toward target tile and queue map sprite movement

        phb
        php
        phk
        plb

        ldx wAISelectedAIUnitOffset,b
        lda #0
        sta wActiveActionID,b
        lda #$FFFF
        sta wActiveActionUnit2DeploymentOffset,b
        lda aAIUnitList[0].XPosition,x
        and #$00FF
        cmp wAITargetXPosition,b
        bne _B270

          lda aAIUnitList[0].YPosition,x
          and #$00FF
          cmp wAITargetYPosition,b
          bne _B270

            lda wAIUnknown000E8E,b
            bne _B270
            
              -
              jsl rlGetSelectedUnitStates
              bit #UnitStateCanto
              bne +

                jml _End

              +
              phx
              lda aAIUnitList[0].DeploymentOffset,x
              and #$00FF
              tax
              jsl rlUnknown84CAA9
              plx
              jml _End

        _B270
        lda aAIUnitList[0].XPosition,x
        and #$00FF
        sta wAITemp000E96,b
        lda aAIUnitList[0].YPosition,x
        and #$00FF
        sta wAITemp000E98,b

        lda wAITargetXPosition,b
        sta wAITemp000E9A,b
        lda wAITargetYPosition,b
        sta wAITemp000E9C,b
        jsl rlAIFindBestMoveTowardTarget
        bcc +

          lda wAIUnknown7E2014
          sta wAITemp000E9A,b
          lda wAIUnknown7E2016
          sta wAITemp000E9C,b
          jsl rlAIFindBestMoveTowardTarget
          bcs -

        +
        lda wAITemp000E9E,b
        cmp wAITemp000E9A,b
        bne +

          lda wAITemp000EA0,b
          cmp wAITemp000E9C,b
          bne +

            lda wAIUnknown000E8E,b
            sta wActiveActionID,b
            lda wAIUnknown000E8C,b
            bmi +

              sta wActiveActionUnit2DeploymentOffset,b

        ; Update units position with the post movement positions
        +
        sep #$20
        lda wAITemp000E9E,b
        sta aAIUnitList[0].XPosition,x
        lda wAITemp000EA0,b
        sta aAIUnitList[0].YPosition,x
        rep #$20

        lda wAITemp000E9E,b
        asl a
        asl a
        asl a
        asl a
        sta wActiveActionDestinationX,b
        lda wAITemp000EA0,b
        asl a
        asl a
        asl a
        asl a
        sta wActiveActionDestinationY,b

        lda aAIUnitList[0].DeploymentOffset,x
        and #$00FF
        sta wActiveActionUnit1DeploymentOffset,b
        lda #$FFFF
        sta wMapActionActiveFlag,b

        lda #$0001
        tsb bUnknown000E7B,b

        _End
        plp
        plb
        rts

        .databank 0

      rlAIExecuteQueuedAction ; 86/B307

        .al
        .autsiz
        .databank ?

        ; Dispatch post-movement map action ID (0-15) via _B315 jump table

        phb
        php
        phk
        plb
        phx

        asl a
        tax
        jsr (_B315,x)

        plx
        plp
        plb
        rtl

        .databank 0

        _B315
        .word <>rsAIActionWait
        .word <>rsAIActionStartBattle
        .word <>rsAIActionStartSiegeBattle
        .word <>rsAIActionEnterHomeCastle
        .word <>rsAIActionSeizeCastle
        .word <>rsAIActionRaidVillage
        .word <>rsAIActionEnterLocation
        .word <>rsAIActionGuardCastle
        .word <>rsAIActionStartBattle
        .word <>rsAIActionNoOp9
        .word <>rsAIActionNoOp10
        .word <>rsAIActionStartScriptedBattle
        .word <>rsAIActionTalk
        .word <>rsAIActionReviveAndEnterCastle
        .word <>rsAIActionStartBattle
        .word <>rsAIActionStartBattle

        ; 86/B335

    .endsection AIThreatSection


    .section Unsorted86B335Section

      .al
      .xl

      rsAIActionWait ; 86/B335

        .al
        .xl
        .autsiz
        .databank ?

        ; Action 0: finish unit move via rlUnknown84CAA9 and clear bit $01 of $0E7B

        ldx wActiveActionUnit1DeploymentOffset,b
        jsl rlUnknown84CAA9
        lda #$0001
        trb bUnknown000E7B,b
        rts

        .databank 0

        ; 86/B343

      rsAIActionStartBattle ; 86/B343

        .al
        .xl
        .autsiz
        .databank ?

        ; Actions 1/8/14/15: clear $057C and run rlRunMapAction between $0871 and $0873

        lda #MAP_ACTION_BATTLE
        sta wMapActionTargetType,b
        lda wActiveActionUnit1DeploymentOffset,b
        sta wR0
        lda wActiveActionUnit2DeploymentOffset,b
        sta wR1
        jsl rlRunMapAction
        rts

        .databank 0

        ; 86/B358

      rsAIActionStartSiegeBattle ; 86/B358

        .al
        .xl
        .autsiz
        .databank ?

        ; Action 2: set UnitState0400 (siege attack) via rlUnknown84B474 and start battle

        ldx wActiveActionUnit1DeploymentOffset,b
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlUnknown84B474
        jml rsAIActionStartBattle

        .databank 0

        ; 86/B36A

    .endsection Unsorted86B335Section


    .section Unsorted86B36ASection

      .al
      .xl

      rsAIActionNoOp9 ; 86/B36A

        .al
        .xl
        .autsiz
        .databank ?

        ; Action 9: clear bit $01 of bUnknown000E7B and return

        lda #$0001
        trb bUnknown000E7B,b
        rts

        .databank 0

        ; 86/B371

    .endsection Unsorted86B36ASection


    .section Unsorted86B371Section

      .al
      .xl

      rsAIActionEnterHomeCastle ; 86/B371

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Action 3 (unused): finish move and relocate unit into castle if on location

        ldx wActiveActionUnit1DeploymentOffset,b
        jsl rlUnknown84CAA9
        lda wTargetEventLocationEntry,b
        beq _B388
        sta wEventLocationEntry,b
        jsl rlGetEventLocationEntryID
        jsl rlQueueUnitRelocationToCastle

        _B388
        lda #$0001
        trb bUnknown000E7B,b
        rts

        .databank 0

        ; 86/B38F

    .endsection Unsorted86B371Section


    .section Unsorted86B38FSection

      .al
      .xl

      rsAIActionRaidVillage ; 86/B38F

        .al
        .xl
        .autsiz
        .databank ?

        ; Action 5: raid/destroy village ($84/CF0F) and clear bit $01 of $0E7B

        ldx wActiveActionUnit1DeploymentOffset,b
        jsl rlUnitRaidVillage
        lda #$0001
        trb bUnknown000E7B,b
        rts

        .databank 0

        ; 86/B39D

    .endsection Unsorted86B38FSection


    .section Unsorted86B39DSection

      .al
      .xl

      rsAIActionSeizeCastle ; 86/B39D

        .al
        .autsiz
        .databank ?

        ; Action 4: seize/capture castle ($84/CE21) and clear bit $01 of $0E7B

        ldx wActiveActionUnit1DeploymentOffset,b
        jsl rlUnitSeizeCastle
        lda #1
        trb bUnknown000E7B,b
        rts

        .databank 0

        ; 86/B3AB

    .endsection Unsorted86B39DSection


    .section Unsorted86B3ABSection

      .al
      .xl

      rsAIActionEnterLocation ; 86/B3AB

        .al
        .xl
        .autsiz
        .databank ?

        ; Action 6: run castle entry/seize handler ($84/D03E) and clear bit $01 of $0E7B

        ldx wActiveActionUnit1DeploymentOffset,b
        jsl rlUnitGuardCastle
        lda #$0001
        trb bUnknown000E7B,b
        rts

        .databank 0

        ; 86/B3B9

      rsAIActionGuardCastle ; 86/B3B9

        .al
        .xl
        .autsiz
        .databank ?

        ; Action 7: enter/guard occupied friendly castle ($84/D0B9) and clear bit $01 of $0E7B

        ldx wActiveUnitDeploymentOffset,b
        jsl rlUnitReturnIntoCastle
        lda #$0001
        trb bUnknown000E7B,b
        rts

        .databank 0

        ; 86/B3C7

      rsAIActionNoOp10 ; 86/B3C7

        .al
        .xl
        .autsiz
        .databank ?

        ; Action 10: clear bit $01 of bUnknown000E7B and return

        lda #$0001
        trb bUnknown000E7B,b
        rts

        .databank 0

        ; 86/B3CE

      rsAIActionStartScriptedBattle ; 86/B3CE

        .al
        .xl
        .autsiz
        .databank ?

        ; Action 11: run scripted battle from lAITemp000E90 ($84/B613)

        lda lAITemp000E90+1,b
        sta lR18+1
        lda lAITemp000E90,b
        sta lR18
        jsl rlSetupScriptedBattleActionStruct
        rts

        .databank 0

        ; 86/B3DD

    .endsection Unsorted86B3ABSection


    .section Unsorted86B3DDSection

      .al
      .xl

      rsAIActionTalk ; 86/B3DD

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Action 12 (unused): clear bit $01 of $0E7B and run talk event ($0A) for $0871/$0873

        lda #$0001
        trb bUnknown000E7B,b
        lda #$000A
        sta bEventActionIdentifier,b
        ldx wActiveActionUnit2DeploymentOffset,b
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitCharacterID
        sta wEventEngineArgument2,b
        ldx wActiveUnitDeploymentOffset,b
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitCharacterID
        sta wEventEngineArgument1,b
        jsl rlGetAndRunChapterMapEventConditions
        rts

        .databank 0

        ; 86/B410

      rsAIActionReviveAndEnterCastle ; 86/B410

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Action 13 (unused): revive group units of wAICurrentAISetting and enter castle

        lda wAICurrentAISetting,b
        sta wRoutineVariable1,b
        lda wAIActiveFaction,b
        jsl rlReviveFactionsUnitsOfAISetting
        jsr rsAIActionEnterHomeCastle
        rts

        .databank 0

        ; 86/B421

    .endsection Unsorted86B3DDSection


