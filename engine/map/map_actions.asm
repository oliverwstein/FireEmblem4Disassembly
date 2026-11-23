; What happens when a unit carries out a command on the map. rlRunMapAction (in
; engine/battle/battle.asm) runs the chosen action by wMapActionTargetType; the
; routines here are the effects of the other commands: entering a location,
; Return, visiting a town or village, seizing or raiding, guarding, returning into
; or departing a castle, talking, mounting and dismounting, helping and giving
; gold. Most end the unit's action with rlUnknown84CAA9 and then run the chapter's
; event conditions with an event action number (8 town, 9 village, 2 raid, $0A
; talk, $1A help). Bank $84.


    .section Unsorted84B32BSection

      .al
      .xl

      rlStartInventoryStaffTargetSelection ; 84/B32B

        .al
        .xl
        .autsiz
        .databank ?

        ; Starts choosing a target for the staff in wSelectedInventorySlot (from the castle when the slot is negative).

        lda wSelectedInventorySlot,b
        bmi _B33A
        jsl rlGetItemROMDataByInventorySlot
        jsl rlStartStaffTargetSelection
        bra _B348


        _B33A
        and #$7FFF
        sta wSelectedInventorySlot,b
        jsl rlGetItemROMDataByInventorySlot
        jsl rlStartCastleStaffTargetSelection

        _B348
        rtl

        .databank 0

        ; 84/B349

    .endsection Unsorted84B32BSection


    .section Unsorted84B9A3Section

      .al
      .xl

      rlCheckCanTalk ; 84/B9A3

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Carry set if the unit has someone to talk to in range 1 (filter 6), or a talk event with a unit at its castle; with carry in, also marks them as targets.

        phb
        php
        phk
        plb
        .databank $84
        phx
        stz wR12
        rol wR12
        lda #$0001
        sta wR10
        sta wR11
        lda #$0006
        jsl rlFindTargetsInRange
        ora #$0000
        bne _B9C9
        jsr rsCheckTalkTargetHere
        bcs _B9C9
        jsr rsCheckTalkTargetGuarding
        bcc _B9CF

        _B9C9
        plx
        plp
        plb
        .databank ?
        sec
        bra _B9D3


        _B9CF
        plx
        plp
        plb
        .databank ?
        clc

        _B9D3
        rtl

        .databank 0

        ; 84/B9D4

    .endsection Unsorted84B9A3Section


    .section Unsorted84B9D4Section

      .al
      .xl

      rsCheckTalkTargetHere ; 84/B9D4

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlGetSelectedUnitStates
        bit #UnitStateGuardingCastle
        beq _BA07
        lda $7F679A
        and #$00FF
        cmp #$00FF
        beq _BA07
        tax
        lda aDeploymentTable._UnitRAMPointer,x
        sta wRoutineVariable1,b
        jsl rlCheckTalkEventEntryAvailable
        bcc _BA07
        lda wR12
        beq _BA04
        txa
        sep #$20
        sta $7F879A
        rep #$20

        _BA04
        sec
        bra _BA08


        _BA07
        clc

        _BA08
        rts

        .databank 0

        ; 84/BA09

      rsCheckTalkTargetGuarding ; 84/BA09

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F671A
        and #$00FF
        cmp #$00FF
        beq _BA3C
        tax
        lda aDeploymentTable,x
        bit #$0004
        beq _BA3C
        lda aDeploymentTable._UnitRAMPointer,x
        sta wRoutineVariable1,b
        jsl rlCheckTalkEventEntryAvailable
        bcc _BA3C
        lda wR12
        beq _BA39
        txa
        sep #$20
        sta $7F871A
        rep #$20

        _BA39
        sec
        bra _BA3D


        _BA3C
        clc

        _BA3D
        rts

        .databank 0

        ; 84/BA3E

    .endsection Unsorted84B9D4Section


    .section Unsorted84BA3ESection

      .al
      .xl

      rlFindTalkTargets ; 84/BA3E

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Like rlCheckCanTalk with filter 3, for the talk command.

        phb
        php
        phk
        plb
        .databank $84
        phx
        stz wR12
        rol wR12
        lda #$0001
        sta wR10
        sta wR11
        lda #$0003
        jsl rlFindTargetsInRange
        ora #$0000
        bne _BA64
        jsr rsCheckTalkTargetHere
        bcs _BA64
        jsr rsCheckTalkTargetGuarding
        bcc _BA6A

        _BA64
        plx
        plp
        plb
        .databank ?
        sec
        bra _BA6E


        _BA6A
        plx
        plp
        plb
        .databank ?
        clc

        _BA6E
        rtl

        .databank 0

        ; 84/BA6F

    .endsection Unsorted84BA3ESection


    .section Unsorted84BA6FSection

      .al
      .xl

      rlStopGuardingCastle ; 84/BA6F

        .al
        .xl
        .autsiz
        .databank ?

        ; The selected unit stops guarding: clears its unit state and DeploymentStateGuardingCastle and unguards its home castle.

        phx
        lda #$2000
        jsl rlUnsetSelectedUnitStates
        jsl rlGetSelectedUnitDeploymentOffset
        tax
        lda aDeploymentTable._StateBuffer,x
        and #$FFFB
        sta aDeploymentTable._StateBuffer,x
        sta aDeploymentTable,x
        jsl rlGetSelectedUnitHomeCastle
        jsl rlGetLocationEventDataEntry
        bcs _BA9F
        jsl rlCheckIfCastleGuarded
        bcc _BA9F
        jsl rlUnsetCastleGuarded

        _BA9F
        plx
        rtl

        .databank 0

        ; 84/BAA1

    .endsection Unsorted84BA6FSection


    .section Unsorted84CC5DSection

      .al
      .xl

      rlEnterTargetLocation ; 84/CC5D

        .al
        .xl
        .autsiz
        .databank ?

        ; X = deployment: if wTargetEventLocationEntry is set, the unit enters that location: its home castle (it stays there; Y = 1) or another location (opens it, takes the unit off the map into the castle; Y = 0). Carry clear.

        lda wTargetEventLocationEntry,b
        beq _CC83
        sta wEventLocationEntry,b
        jsl rlGetEventLocationEntryID
        sta wRoutineVariable1,b
        lda aDeploymentTable._FactionSlot,x
        jsl rlGetFactionSlotLocationID
        cmp wRoutineVariable1,b
        bne _CC85
        jsl rlSetUnitResidingInCastle
        lda wRoutineVariable1,b
        ldy #$0001

        _CC83
        clc

        _CC84
        rtl


        _CC85
        phx
        jsl rlEnterLocationOfUnit
        plx
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        lda wRoutineVariable1,b
        jsl rlSetUnitUnfieldedInCastle
        jsl rlDeployedUnitSetHidden
        lda wMapStateFlags,b
        bit #$0008
        beq _CCA9
        jsl rlSaveDeploymentTile

        _CCA9
        jsr rsUnknown84CA22
        lda wRoutineVariable1,b
        ldy #$0000
        bra _CC84

        .databank 0

        ; 84/CCB4

    .endsection Unsorted84CC5DSection


    .section Unsorted84CD35Section

      .al
      .xl

      rlUnitReturnToHomeCastle ; 84/CD35

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; The Return skill: sends the unit to its army's castle (rlQueueUnitRelocationToCastle) with the warp scene.

        phb
        php
        phk
        plb
        .databank $84
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlUnknown84CAA9
        jsl rlGetSelectedUnitFactionSlot
        jsl rlGetFactionSlotLocationID
        jsl rlQueueUnitRelocationToCastle
        jsl rlGetSelectedUnitCharacterID
        sta aActionStructUnit1.UnitRAMPointer
        jsl rlGetSelectedUnitGender
        sta aActionStructUnit1.CharacterID
        txa
        sta $7E4EA9
        lda aDeploymentTable._XTilePosition,x
        sta wBattleDistance
        lda aDeploymentTable._YTilePosition,x
        sta wBattleQuotePointer
        jsl rlGetSelectedUnitClassID
        sta $7E4EAF
        jsl rlUnknown9ED07A
        lda #$0010
        tsb wMapSystemFlags,b
        plp
        plb
        .databank $84
        rtl

        .databank 0

        ; 84/CD8A

    .endsection Unsorted84CD35Section


    .section Unsorted84CD8ASection

      .al
      .xl

      rlQueueUnitRelocationToCastle ; 84/CD8A

        .al
        .xl
        .autsiz
        .databank ?

        ; Unless a relocation is already queued: unit X goes to location A (wUnitRelocationType 3).

        phb
        php
        phk
        plb
        .databank $84
        phy
        ldy wUnitRelocationDeploymentOffset,b
        bpl _CDA0
        sta wUnitRelocationLocationID,b
        stx wUnitRelocationDeploymentOffset,b
        lda #UNIT_RELOCATION_INTO_CASTLE
        sta wUnitRelocationType,b

        _CDA0
        ply
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 84/CDA4

    .endsection Unsorted84CD8ASection


    .section Unsorted84CDA4Section

      .al
      .xl

      rlUnitVisitTown ; 84/CDA4

        .al
        .autsiz
        .databank ?

        ; Ends the action and runs the town's event conditions (event action 8, the character and location).

        phb
        php
        phk
        plb
        lda wTargetEventLocationEntry,b
        beq _End

          sta wEventLocationEntry,b
          lda aDeploymentTable._UnitRAMPointer,x
          sta wSelectedUnitDataRAMPointer,b
          jsl rlUnknown84CAA9
          lda #8
          sta bEventActionIdentifier,b
          jsl rlGetSelectedUnitCharacterID
          sta wEventEngineArgument1,b
          jsl rlGetEventLocationEntryID
          sta wEventEngineArgument2,b
          jsl rlGetAndRunChapterMapEventConditions

        _End
        plp
        plb
        rtl

        .databank 0

        ; 84/CDD6

    .endsection Unsorted84CDA4Section


    .section Unsorted84CDD6Section

      .al
      .xl

      rlUnitVisitVillage ; 84/CDD6

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Closes the village, gives its gold to the unit, ends the action and runs its event conditions (event action 9).

        phb
        php
        phk
        plb
        .databank $84
        lda wTargetEventLocationEntry,b
        beq _CE1E
        sta wEventLocationEntry,b
        jsl rlSetVillageClosed
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetEventLocationMoneyReward
        sta wRoutineVariable1,b
        jsl rlAddSelectedCharacterMoney
        jsl rlUnknown84CAA9
        lda wRoutineVariable1,b
        sta wVillageGoldPopUpAmount,b
        lda #$0009
        sta bEventActionIdentifier,b
        jsl rlGetSelectedUnitCharacterID
        sta wEventEngineArgument1,b
        jsl rlGetEventLocationEntryID
        sta wEventEngineArgument2,b
        jsl rlGetAndRunChapterMapEventConditions
        jsl rlHandleEventLocationModification

        _CE1E
        plp
        plb
        .databank $84
        rtl

        .databank 0

        ; 84/CE21

    .endsection Unsorted84CDD6Section


    .section Unsorted84CE21Section

      .al
      .xl

      rlUnitSeizeCastle ; 84/CE21

        .al
        .autsiz
        .databank ?

        ; X = deployment: makes the unit's army the owner of the unguarded castle in wTargetEventLocationEntry and starts procCastleTakenOver. The player army also frees its captured characters; another army taking a player castle (not location 0) destroys it.

        ; X = deployment offset

        phb
        php
        phk
        plb
        lda wR0
        pha
        lda wR1
        pha

        lda wTargetEventLocationEntry,b
        bne +

          jml _End

        +
        sta wEventLocationEntry,b
        jsl rlCheckIfCastleGuarded
        bcc +

          jml _End

        +
        jsl rlGetLocationFactionSlotOwner
        sta wR0
        lda aDeploymentTable._FactionSlot,x
        cmp wR0
        bne +

          jml _End

        +
        lda aDeploymentTable._FactionSlot,x
        jsl rlSetLocationFactionSlotOwner
        jsl rlUnknown84CAA9
        jsr rsStartCastleTakenOverProc
        lda aDeploymentTable._FactionSlot,x
        bne +

          jsl rlUnknown87EE81
          jsr rsReviveCapturedPlayerCharacters
          bra _EC96

        +
        jsl rlGetEventLocationEntryID
        cmp #0
        beq _EC96

          lda wR0
          bne _EC96

            lda #$0049
            jsl rlPlaySoundEffect2

            jsl rlSetLocationDestroyed
            inc wDestroyedLocationsCount,b
            jsl rlHandleEventLocationModification
            jsl rlRedrawVisibleMapTilemap
            bra _End

        _EC96
        jsl rlHandleEventLocationModification

        _End
        pla
        sta wR1
        pla
        sta wR0
        plp
        plb
        rtl

        .databank 0

      rsStartCastleTakenOverProc ; 84/CEA3

        .al
        .autsiz
        .databank ?

        ; X = deployment offset
        ; wR0 = faction slot owner of location

        jsl rlGetEventLocationEntryID
        and #$00FF
        sta aProcSystem.wInput0,b
        lda wR0
        and #$00FF
        sta aProcSystem.wInput1,b
        lda aDeploymentTable._FactionSlot,x
        sta aProcSystem.wInput2,b

        lda #(`procCastleTakenOver)<<8
        sta lR44+1
        lda #<>procCastleTakenOver
        sta lR44
        jsl rlProcEngineCreateProc
        rts

        .databank 0

      rsReviveCapturedPlayerCharacters ; 84/CECB

        .al
        .autsiz
        .databank ?

        phx
        lda wEventLocationEntry,b
        pha

        jsl rlBuildCastleUnitList
        ldx #0

          _Loop
          lda aCastleUnitDeploymentOffsets,x
          bmi _End

            phx
            tax
            lda aDeploymentTable._UnitRAMPointer,x
            sta wSelectedUnitDataRAMPointer,b
            plx
            jsl rlGetSelectedUnitStatus
            cmp #StatusCaptive
            bne _Next

              jsl rlReviveSelectedCharacter

              lda #$001B
              sta bEventActionIdentifier,b
              jsl rlGetSelectedUnitCharacterID
              sta wEventEngineArgument1,b
              jsl rlGetAndRunChapterMapEventConditions

            _Next
            inc x
            inc x
            bra _Loop

        _End
        pla
        sta wEventLocationEntry,b
        plx
        rts

        .databank 0

      rlUnitRaidVillage ; 84/CF0F

        .al
        .autsiz
        .databank ?

        ; A computer unit raids the village in wTargetEventLocationEntry: takes 500 of its gold (destroying it, with event action 2, when nothing is left) and shows the raid scene.

        phb
        php
        phk
        plb
        lda wR0
        pha

        lda wTargetEventLocationEntry,b
        bne +

          jml _End

        +
        sta wEventLocationEntry,b
        jsl rlGetEventLocationEntryType
        cmp #LocationTypeVillage
        beq +

          jml _End

        +
        jsl rlUnknown84CAA9

        lda #500
        jsl rlSubtractEventLocationMoneyReward
        bcc +

          jsl rlSetLocationDestroyed
          lda aDeploymentTable._UnitRAMPointer,x
          sta wSelectedUnitDataRAMPointer,b
          jsl rlGetSelectedUnitFactionSlot
          sta wR0
          lda #2
          sta bEventActionIdentifier,b
          lda wR0
          sta wEventEngineArgument1,b
          jsl rlGetEventLocationEntryID
          sta wEventEngineArgument2,b
          jsl rlGetAndRunChapterMapEventConditions

        +
        jsl rlHandleEventLocationModification
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        txa
        sta $7E4EA9

        lda aDeploymentTable._XTilePosition,x
        sta wBattleDistance
        lda aDeploymentTable._YTilePosition,x
        sta wBattleQuotePointer
        jsl rlGetSelectedUnitClassID
        sta $7E4EAF

        jsl rlGetFirstEquippableWeaponInInventory
        jsl rlGetItemIDByInventorySlot
        sta wDeathQuotePointer+1

        jsl rlGetLocationMoneyLevel
        sta wBattleSong
        lda #5000
        sta aActionStructUnit1.DeploymentNumber
        jsl rlGetEventLocationMoneyReward
        sta aActionStructUnit1.XPosition
        lda #500
        sta aActionStructUnit1.YPosition
        jsl rlUnknown9E9A34
        
        _End
        pla
        sta wR0
        plp
        plb
        rtl

        .databank 0

        ; 84/CFBF

    .endsection Unsorted84CE21Section


    .section Unsorted84CFBFSection

      .al
      .xl

      rlStartGuardingCastleAtUnit ; 84/CFBF

        .al
        .autsiz
        .databank ?

        ; X = deployment: if the unit stands on an unguarded castle of its own army or an ally, it starts guarding it.

        phb
        php
        phk
        plb
        lda wR0
        pha
        lda wR1
        pha

        lda aDeploymentTable._XTilePosition,x
        sta wR0
        lda aDeploymentTable._YTilePosition,x
        sta wR1
        jsl rlFindLocationAtTile
        bcs +

          jsl rlCheckIfCastleGuarded
          bcs +

            jsl rlGetLocationFactionSlotOwner
            sta wR0

            lda aDeploymentTable._UnitRAMPointer,x
            sta wSelectedUnitDataRAMPointer,b

            phx
            ldx wR0
            jsl rlGetSelectedUnitFactionSlot
            jsl rlGetFactionRelation
            plx

            cmp #AllegianceEnemy
            beq +

              cmp #AllegianceNeutral
              beq +

                jsr rsSetUnitGuardingCastle

        +
        pla
        sta wR1
        pla
        sta wR0
        plp
        plb
        rtl

        .databank 0

      rsSetUnitGuardingCastle ; 84/D010

        .al
        .autsiz
        .databank ?

        lda aDeploymentTable._StateBuffer,x
        ora #DeploymentStateGuardingCastle
        sta aDeploymentTable._StateBuffer,x
        sta aDeploymentTable._State,x

        lda #UnitStateGuardingCastle
        jsl rlSetSelectedUnitStates
        jsl rlGetEventLocationEntryID
        jsl rlSetSelectedUnitResidingCastle
        jsl rlSetCastleGuarded
        jsl rlGetEventLocationEntryCoordinates
        sta wRoutineVariable1,b
        jsl rlUnknown84C996
        rts

        .databank 0

        ; 84/D03E

    .endsection Unsorted84CFBFSection


    .section Unsorted84D03ESection

      .al
      .xl

      rlUnitGuardCastle ; 84/D03E

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; The guard command (from the map, the castle or the AI): moves the unit onto the castle and, for a player move, sends the cursor to it.

        phb
        php
        phk
        plb
        .databank $84
        phy
        tay
        lda wTargetEventLocationEntry,b
        beq _D0AE
        sta wEventLocationEntry,b
        jsl rlCheckIfCastleGuarded
        bcs _D0AE
        jsl rlGetLocationFactionSlotOwner
        sta wR0
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        phx
        ldx wR0
        jsl rlGetSelectedUnitFactionSlot
        jsl rlGetFactionRelation
        plx
        cmp #$0001
        beq _D0AE
        cmp #$0003
        beq _D0AE
        jsl rlGetEventLocationEntryCoordinates
        sta wRoutineVariable1,b
        jsl rlUnknown84C996
        tya
        bne _D0A2
        lda wMapStateFlags,b
        bit #$0008
        bne _D098
        lda wMapActionMode,b
        cmp #$0001
        beq _D09C
        jsr rsSetMapActionModeGuard
        bra _D0AE


        _D098
        jsl rlSetMapCursorOriginToCursor

        _D09C
        jsl rlStartCursorToActiveUnitForAction
        bra _D0AE


        _D0A2
        jsl rlRequestUnitMenuMode2
        bcc _D0AE
        jsl rlUnknown84CAA9
        bra _D0AE


        _D0AE
        ply
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 84/D0B2

    .endsection Unsorted84D03ESection


    .section Unsorted84D0B2Section

      .al
      .xl

      rsSetMapActionModeGuard ; 84/D0B2

        .al
        .xl
        .autsiz
        .databank ?

        ; wMapActionMode = $8004.

        lda #$8004
        sta wMapActionMode,b
        rts

        .databank 0

        ; 84/D0B9

    .endsection Unsorted84D0B2Section


    .section Unsorted84D0B9Section

      .al
      .xl

      rlUnitReturnIntoCastle ; 84/D0B9

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Return command while guarding a castle: the unit stops guarding and goes inside.

        phb
        php
        phk
        plb
        .databank $84
        lda aDeploymentTable._XTilePosition,x
        sta wR0
        lda aDeploymentTable._YTilePosition,x
        sta wR1
        jsl rlFindLocationAtTile
        bcs _D10C
        jsl rlCheckIfCastleGuarded
        bcc _D10C
        jsl rlGetLocationFactionSlotOwner
        sta wR0
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        phx
        ldx wR0
        jsl rlGetSelectedUnitFactionSlot
        jsl rlGetFactionRelation
        plx
        cmp #$0001
        beq _D10C
        cmp #$0003
        beq _D10C
        jsl rlStopGuardingCastle
        jsl rlRefreshUnitWindow
        jsl rlGetEventLocationEntryID
        jsl rlSetUnitResidingInCastle
        jsl rlUnknown84CAA9

        _D10C
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 84/D10F

      rlUnitDepartCastle ; 84/D10F

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Depart command: the unit stops guarding and steps onto the castle's map tile (wMapActionMode $8002).

        phb
        php
        phk
        plb
        .databank $84
        lda aDeploymentTable._XTilePosition,x
        sta wR0
        lda aDeploymentTable._YTilePosition,x
        sta wR1
        jsl rlFindLocationAtTile
        bcs _D168
        jsl rlCheckIfCastleGuarded
        bcc _D168
        jsl rlGetLocationFactionSlotOwner
        sta wR0
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        phx
        ldx wR0
        jsl rlGetSelectedUnitFactionSlot
        jsl rlGetFactionRelation
        plx
        cmp #$0001
        beq _D168
        cmp #$0003
        beq _D168
        jsl rlStopGuardingCastle
        jsl rlGetEventLocationEntryEffectiveXCoordinate
        sta wR0
        jsl rlGetEventLocationEntryEffectiveYCoordinate
        sta wR1
        jsl rlMoveDeploymentToTile
        lda #$8002
        sta wMapActionMode,b

        _D168
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 84/D16B

    .endsection Unsorted84D0B9Section


    .section Unsorted84D16BSection

      .al
      .xl

      rlUnitTalk ; 84/D16B

        .al
        .autsiz
        .databank ?

        ; wR0 talks to wR1: ends the action, runs the talk event conditions (event action $0A) and clears the talk target once used.

        ; wR0 = initiator deployment offset
        ; wR1 = target deployment offset

        phb
        php
        phk
        plb
        phx
        ldx wR1
        lda aDeploymentTable._UnitRAMPointer,x
        sta wRoutineVariable1,b
        ldx wR0
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlUnknown84CAA9
        jsl rlCheckTalkEventEntryAvailable
        bcc +

          sta wEventEngineArgument3,b

        +
        lda wSelectedUnitDataRAMPointer,b
        pha

        lda #$000A
        sta bEventActionIdentifier,b
        jsl rlGetSelectedUnitCharacterID
        sta wEventEngineArgument1,b
        ldx wR1
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitCharacterID
        sta wEventEngineArgument2,b
        jsl rlGetAndRunChapterMapEventConditions

        pla
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitLivingTalkTarget
        cmp wEventEngineArgument2,b
        bne +

          lda #0
          jsl rlSetSelectedUnitTalkTarget

        +
        plx
        plp
        plb
        rtl

        .databank 0

        ; 84/D1CC

    .endsection Unsorted84D16BSection


    .section Unsorted84D1CCSection

      .al
      .xl

      rlUnitDismount ; 84/D1CC

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; With the Dismount skill and mounted: sets UnitStateDismounted, changes the class to JuniorLord, equips a usable weapon and redeploys the unit.

        phb
        php
        phk
        plb
        .databank $84
        phx
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        lda #SkillIDDismount
        jsl rlCheckIfUnitHasSpecifiedPersonalOrClassSkill
        bcc _D209
        jsl rlGetSelectedUnitStates
        bit #UnitStateDismounted
        bne _D209
        lda #$1000
        jsl rlSetSelectedUnitStates
        lda #$002C
        jsl rlSetSelectedUnitClass
        jsl rlGetFirstEquippableWeaponInInventory
        jsl rlCheckWeaponEquippable
        bcs _D206
        jsl rlEquipFirstWeaponInInventory

        _D206
        jsr rsRedeployUnitAfterClassChange

        _D209
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 84/D20D

      rsRedeployUnitAfterClassChange ; 84/D20D

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda aDeploymentTable._YTilePosition,x
        xba
        ora aDeploymentTable._XTilePosition,x
        sta wRoutineVariable1,b
        txa
        jsl rlClearUnitDeploymentData
        jsl rlDeployUnitCheckIfAsleep
        sta wActiveUnitDeploymentOffset,b
        tax
        jsl rlDeployedUnitSetHidden
        jsl rlGetSelectedUnitStates
        bit #UnitStateCanto
        beq _D242
        lda aDeploymentTable,x
        ora #$0010
        sta aDeploymentTable,x
        sta aDeploymentTable._StateBuffer,x

        _D242
        jsl rsStartMovingUnitSprite
        rts

        .databank 0

        ; 84/D247

      rlUnitMount ; 84/D247

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Dismounted: clears UnitStateDismounted, changes the class back to KnightLord and redeploys the unit.

        phb
        php
        phk
        plb
        .databank $84
        phx
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitStates
        bit #UnitStateDismounted
        beq _D26D
        lda #$1000
        jsl rlUnsetSelectedUnitStates
        lda #$0006
        jsl rlSetSelectedUnitClass
        jsr rsRedeployUnitAfterClassChange

        _D26D
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 84/D271

    .endsection Unsorted84D1CCSection


    .section Unsorted84D2BASection

      .al
      .xl

      rlUnitHelp ; 84/D2BA

        .al
        .xl
        .autsiz
        .databank ?

        ; The help command: queues relocation type 7 for wR0 (location wR1), gives 100 experience and runs event action $1A with wR1's formation ID.

        phb
        php
        phk
        plb
        .databank $84
        phx
        jsl rlClearBattleData
        lda wR0
        sta wUnitRelocationDeploymentOffset,b
        lda wR1
        sta wUnitRelocationLocationID,b
        lda #UNIT_RELOCATION_HELPED
        sta wUnitRelocationType,b
        lda wR0
        sta aActionStructUnit1
        tax
        jsl rlUnknown84CAA9
        lda aDeploymentTable._UnitRAMPointer,x
        sta aActionStructUnit1.UnitRAMPointer
        lda aDeploymentTable._XTilePosition,x
        sta aActionStructUnit1.XPosition
        lda aDeploymentTable._YTilePosition,x
        sta aActionStructUnit1.YPosition
        jsl rlGetSelectedUnitExperience
        sta $7E4ECD
        lda #$0064
        sta $7E4ECF
        phb
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb
        .databank $7E
        ldx #$4EB5
        jsr rsActionstructGetLevelUpAndDroppedItemData
        plb
        .databank $7E
        lda #$001A
        sta bEventActionIdentifier,b
        jsl rlGetSelectedUnitCharacterID
        sta wEventEngineArgument1,b
        ldx wR1
        jsl rlGetFormationIDByDeploymentOffset
        inc a
        sta wEventEngineArgument2,b
        jsl rlGetAndRunChapterMapEventConditions
        plx
        plp
        plb
        .databank $7E
        rtl

        .databank 0

        ; 84/D334

      rlUnitGiveGold ; 84/D334

        .al
        .xl
        .autsiz
        .databank ?

        ; wR0 gives all its gold to wR1 (what wR1 cannot hold goes back) and sets up the gold scene.

        phb
        php
        phk
        plb
        .databank $84
        phx
        ldx wR0
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitMoney
        sta wRoutineVariable1,b
        jsl rlSubtractSelectedCharacterMoney
        jsl rlUnknown84CAA9
        ldx wR1
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlAddSelectedCharacterMoney
        ora #$0000
        beq _D373
        sta wRoutineVariable1,b
        ldx wR0
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlAddSelectedCharacterMoney

        _D373
        jsl rlClearBattleData
        sep #$20
        lda #$00
        sta $7E4EA9
        rep #$20
        lda wR0
        sta aActionStructUnit1
        tax
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        sta aActionStructUnit1.UnitRAMPointer
        lda aDeploymentTable._XTilePosition,x
        sta aActionStructUnit1.XPosition
        lda aDeploymentTable._YTilePosition,x
        sta aActionStructUnit1.YPosition
        jsl rlGetSelectedUnitCharacterID
        sta aActionStructUnit1.CharacterID
        jsl rlGetSelectedUnitClassID
        sta aActionStructUnit1.ClassID
        jsl rlGetSelectedUnitGender
        sta aActionStructUnit1.Gender
        jsl rlGetFirstEquippableWeaponInInventory
        sta aActionStructUnit1.WeaponInventorySlot
        cmp #$0000
        bne _D3CD
        lda #$FFFF
        bra _D3D1


        _D3CD
        jsl rlGetItemIDByInventorySlot

        _D3D1
        sta aActionStructUnit1.WeaponID
        jsl rlGetSelectedUnitExperience
        sta $7E4ECD
        lda #SkillIDSteal
        jsl rlCheckIfUnitHasSpecifiedPersonalOrClassSkill
        bcc _D3EB
        lda #$000A
        bra _D3EE


        _D3EB
        lda #$0000

        _D3EE
        sta $7E4ECF
        lda #$FFFF
        sta $7E4ED1
        lda wR1
        sta aActionStructUnit2
        tax
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        sta aActionStructUnit2.UnitRAMPointer
        lda aDeploymentTable._XTilePosition,x
        sta aActionStructUnit2.XPosition
        lda aDeploymentTable._YTilePosition,x
        sta aActionStructUnit2.YPosition
        jsl rlGetSelectedUnitCharacterID
        sta aActionStructUnit2.CharacterID
        jsl rlGetSelectedUnitClassID
        sta aActionStructUnit2.ClassID
        jsl rlGetSelectedUnitGender
        sta aActionStructUnit2.Gender
        jsl rlGetFirstEquippableWeaponInInventory
        sta aActionStructUnit2.WeaponInventorySlot
        cmp #$0000
        bne _D445
        lda #$FFFF
        bra _D449


        _D445
        jsl rlGetItemIDByInventorySlot

        _D449
        sta aActionStructUnit2.WeaponID
        phb
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb
        .databank $7E
        ldx #$4EB5
        jsr rsActionstructGetLevelUpAndDroppedItemData
        plb
        .databank $7E
        plx
        plp
        plb
        .databank $7E
        rtl

        .databank 0

        ; 84/D461

      rlSaveDeploymentTile ; 84/D461

        .al
        .xl
        .autsiz
        .databank ?

        ; Saves the tile of the deployment at X for rlReturnDeploymentToSavedTile, without moving it.

        lda aDeploymentTable._XTilePosition,x
        sta wSavedDeploymentXTile
        lda aDeploymentTable._YTilePosition,x
        sta wSavedDeploymentYTile
        rtl

        .databank 0

        ; 84/D472

    .endsection Unsorted84D2BASection


    .section Unsorted84D483Section

      .al
      .xl

      rlRequestUnitMenuMode2 ; 84/D483

        .al
        .xl
        .autsiz
        .databank ?

        ; For a player unit: sets mode 2 in wMapStateFlags (with bit 15) so the unit menu opens again; carry clear. Carry set for other armies.

        phb
        php
        phk
        plb
        .databank $84
        lda aDeploymentTable._FactionSlot,x
        bne _D49D
        lda wMapStateFlags,b
        and #$FFFC
        ora #$8002
        sta wMapStateFlags,b
        plp
        plb
        .databank $84
        clc

        _D49C
        rtl


        _D49D
        plp
        plb
        .databank $84
        sec
        bra _D49C

        .databank 0

        ; 84/D4A2

    .endsection Unsorted84D483Section


    .section Unsorted84D4A2Section

      .al
      .xl

      rlRequestUnitMenuMode1 ; 84/D4A2

        .al
        .autsiz
        .databank ?

        ; For a player unit: sets mode 1 in wMapStateFlags (with bit 15) and bit 15 of wChapterFlags; carry clear. Carry set for other armies.

        phb
        php
        phk
        plb

        lda aDeploymentTable._FactionSlot,x
        bne +

        lda wMapStateFlags,b
        and #~(1 | 2) & $FFFF
        ora #$8001
        sta wMapStateFlags,b

        lda #$8000
        tsb wChapterFlags,b

        plp
        plb
        clc
        
        -
        rtl
        
        +
        plp
        plb
        sec
        bra -

        .databank 0

        ; 84/D4C7

    .endsection Unsorted84D4A2Section


