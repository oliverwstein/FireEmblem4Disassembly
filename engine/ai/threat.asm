; Threat ranges: whether any foe can reach a unit's allies, and how far a unit
; can attack.

    .section AIThreatSection

      .al
      .xl

      rlAIUpdateModeIfFoeInThreatRange ; 86/AF39

        .al
        .autsiz
        .databank ?

        ; If any foe is in group threat range ($04), update wAIGroupMode via jump table

        phb
        php

        sep #$20
        lda #`wAIGroupFlags
        pha
        rep #$20
        plb
        .databank `wAIGroupFlags

        lda @l wAIGroupFlags
        bit #$0004
        beq +

          lda wAIGroupMode
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

        ; Leave wAIGroupMode unchanged

        rts

        .databank 0

      rsAIThreatSwitchMode1To2 ; 86/AF6A

        .al
        .autsiz
        .databank $7E

        lda #2
        sta wAIGroupMode
        rts

        .databank 0

      rlAICheckIfAnyFoeInAlliesThreatRange ; 86/AF71

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`wAIGroupFlags
        pha
        rep #$20
        plb
        .databank `wAIGroupFlags

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
        tsb wAIGroupFlags

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
        lda #`wAIGroupFlags
        pha
        rep #$20
        plb
        .databank `wAIGroupFlags

        phx
        lda wAIGroupFlags
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
        sta wAIGroupWaypointXPosition
        sta wAITemp000E96,b

        lda wAIGroupLeaderYPosition
        sta wAIGroupWaypointYPosition
        sta wAITemp000E98,b

        jsl rlFillMovementCostMapSpecial

        jsl rlGetNearestPossibleTarget
        bcs +

          jml _End

        +
        sta wAIGroupTargetValue

        ; Get the targets coords
        lda wAITemp000E9A,b
        sta wAIGroupTargetXPosition
        lda wAITemp000E9C,b
        sta wAIGroupTargetYPosition

        lda wAIGroupObjective
        cmp #6
        bne +

          lda wAIGroupMode
          cmp #4
          beq _B0A6

            jml _End

        +
        lda wAIGroupFlags
        bit #$0008
        bne _B0B6

        ; Group leader isnt dead
        bit #$0110
        bne _B0A6

        lda wAIGroupLeaderDeploymentOffset
        bpl _B0B6

        lda wAIGroupMode
        cmp #4
        bne +

          jml _End

        +
        cmp #5
        bne _B0A6

          jml _End

        ; Write target coords to other ram values
        _B0A6
        lda wAIGroupTargetXPosition
        sta wAIGroupWaypointXPosition
        lda wAIGroupTargetYPosition
        sta wAIGroupWaypointYPosition
        jml +

          _B0B6
          lda @l wAIGroupLeaderFieldMovement
          sta wAITemp000EA2,b
          jsl rlTryGetAIFactionGroupLeader
          jsl rlFillMovementMap
          jsl rlTraceTargetPathToReachableTile

          lda wAITemp000E96,b
          sta wAIGroupWaypointXPosition
          lda wAITemp000E98,b
          sta wAIGroupWaypointYPosition

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

        ; How far the selected unit could attack: its longest-reaching weapon's maximum range plus
        ; (movement + 1) x 10/7 tiles, rounded up (the reach on roads, which cost 7 tenths). With mode 5
        ; it would be the weapon range alone, but cycle 2 sets the mode to 0 before rlBuildAIUnitList,
        ; and every command that sets mode 5 ends the script, so AI_REINFORCE_EVERY_N_TURNS's rebuild
        ; never sees it either.

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
        sta wAIQueuedActionID,b
        lda #$FFFF
        sta wAIQueuedActionTarget,b

        ; Fill movement map
        jsl rlFillSelectedUnitMovementMap

        lda aAIUnitList[0].DeploymentOffset,x
        and #$00FF
        tax
        sta aAIAction.wUntDeploymentOffset
        lda #$FFFF
        sta aAIAction.wChosenActionID

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
            lda aAIAction.wChosenActionID
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

        ; Builds the threat map (aRangeMap: how many foes can attack each tile) unless wAIGroupMode
        ; is 4 or 5. Those modes then read whatever aRangeMap last held: usually the range map
        ; input (1, $FE, $FF, centered on that unit) built when the previous computer unit was picked
        ; up to walk (rlBuildSelectedUnitRangeMaps), so their tile threat values are not threat counts.

        lda wAIGroupMode
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

            lda wAIQueuedActionID,b
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
              jsl rlFinishUnitAction
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

          lda wAIGroupTargetXPosition
          sta wAITemp000E9A,b
          lda wAIGroupTargetYPosition
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

            lda wAIQueuedActionID,b
            sta wActiveActionID,b
            lda wAIQueuedActionTarget,b
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
        tsb bAIEngineFlags,b

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
        .word <>rsAIActionGuardCastle
        .word <>rsAIActionEnterGuardedCastle
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


    .section AIActionWaitSection

      .al
      .xl

      rsAIActionWait ; 86/B335

        .al
        .xl
        .autsiz
        .databank ?

        ; Action 0: finish unit move via rlFinishUnitAction and clear bit $01 of $0E7B

        ldx wActiveActionUnit1DeploymentOffset,b
        jsl rlFinishUnitAction
        lda #$0001
        trb bAIEngineFlags,b
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

        ; Action 2: set UnitStateAssault (siege attack) via rlSetSelectedUnitStateAssault and start battle

        ldx wActiveActionUnit1DeploymentOffset,b
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlSetSelectedUnitStateAssault
        jml rsAIActionStartBattle

        .databank 0

        ; 86/B36A

    .endsection AIActionWaitSection


    .section AIActionNoOp9Section

      .al
      .xl

      rsAIActionNoOp9 ; 86/B36A

        .al
        .xl
        .autsiz
        .databank ?

        ; Action 9: clear bit $01 of bAIEngineFlags and return

        lda #$0001
        trb bAIEngineFlags,b
        rts

        .databank 0

        ; 86/B371

    .endsection AIActionNoOp9Section


    .section AIActionEnterHomeCastleSection

      .al
      .xl

      rsAIActionEnterHomeCastle ; 86/B371

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Action 3: finish the move and queue the unit's relocation into the castle it stands on
        ; (wTargetEventLocationEntry). Chosen by objectives 9 and 12 (the leader, or everyone, goes
        ; home). tools/sweep.py found it before aAIActionRoutines was decoded.

        ldx wActiveActionUnit1DeploymentOffset,b
        jsl rlFinishUnitAction
        lda wTargetEventLocationEntry,b
        beq _B388
        sta wEventLocationEntry,b
        jsl rlGetEventLocationEntryID
        jsl rlQueueUnitRelocationToCastle

        _B388
        lda #$0001
        trb bAIEngineFlags,b
        rts

        .databank 0

        ; 86/B38F

    .endsection AIActionEnterHomeCastleSection


    .section AIActionRaidVillageSection

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
        trb bAIEngineFlags,b
        rts

        .databank 0

        ; 86/B39D

    .endsection AIActionRaidVillageSection


    .section AIActionSeizeCastleSection

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
        trb bAIEngineFlags,b
        rts

        .databank 0

        ; 86/B3AB

    .endsection AIActionSeizeCastleSection


    .section AIActionGuardCastleSection

      .al
      .xl

      rsAIActionGuardCastle ; 86/B3AB

        .al
        .xl
        .autsiz
        .databank ?

        ; Action 6: guard a castle (rlUnitGuardCastle, with A = 12, so the action is finished at once) and clear bit $01 of $0E7B

        ldx wActiveActionUnit1DeploymentOffset,b
        jsl rlUnitGuardCastle
        lda #$0001
        trb bAIEngineFlags,b
        rts

        .databank 0

        ; 86/B3B9

      rsAIActionEnterGuardedCastle ; 86/B3B9

        .al
        .xl
        .autsiz
        .databank ?

        ; Action 7: a unit guarding a castle stops guarding and goes inside (rlUnitReturnIntoCastle), and clear bit $01 of $0E7B

        ldx wActiveUnitDeploymentOffset,b
        jsl rlUnitReturnIntoCastle
        lda #$0001
        trb bAIEngineFlags,b
        rts

        .databank 0

        ; 86/B3C7

      rsAIActionNoOp10 ; 86/B3C7

        .al
        .xl
        .autsiz
        .databank ?

        ; Action 10: clear bit $01 of bAIEngineFlags and return

        lda #$0001
        trb bAIEngineFlags,b
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

    .endsection AIActionGuardCastleSection


    .section AIActionTalkSection

      .al
      .xl

      rsAIActionTalk ; 86/B3DD

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Action 12: announce event action $0A (a talk) between the acting unit and its target.
        ; Chosen by objective 8 when AI_INTERACT_WITH_UNIT's action is 12: the Prologue, Chapter 5
        ; and Chapter 9 scripts send a leader to talk to Sigurd or Seliph. tools/sweep.py found it
        ; before aAIActionRoutines was decoded.

        lda #$0001
        trb bAIEngineFlags,b
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

        ; Action 13: revive the group's dead into the home castle, then action 3 (enter it).
        ; Chosen for the leader by objective 10 (AI_LEADER_RETREAT_IF_GROUP_BELOW). tools/sweep.py
        ; found it before aAIActionRoutines was decoded.

        lda wAICurrentAISetting,b
        sta wRoutineVariable1,b
        lda wAIActiveFaction,b
        jsl rlReviveFactionsUnitsOfAISetting
        jsr rsAIActionEnterHomeCastle
        rts

        .databank 0

        ; 86/B421

    .endsection AIActionTalkSection


