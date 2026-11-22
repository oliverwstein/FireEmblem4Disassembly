; Staves: whether a staff has a target (on the map and in the castle), starting
; to choose one by the staff's effect, the heal amount, and fortify.


    .section Unsorted87E6D3Section

      .al
      .xl

      rsStaffTargetCheckFail ; 87/E6D3

        .al
        .xl
        .autsiz
        .databank ?

        clc
        rts

        .databank 0

        ; 87/E6D5

      rsStaffTargetCheckPass ; 87/E6D5

        .al
        .xl
        .autsiz
        .databank ?

        ; Nothing in the build reaches this.

        sec
        rts

        .databank 0

        ; 87/E6D7

    .endsection Unsorted87E6D3Section


    .section Unsorted87E6D7Section

      .al
      .xl

      rsStaffTargetCheckHealOnMap ; 87/E6D7

        .al
        .xl
        .autsiz
        .databank ?

        ; Heal, mend, recover: not in the castle; then rsStaffTargetCheckHeal.

        lda wUnknown000D79,b
        bit #$0020
        bne rsStaffTargetCheckFail

      rsStaffTargetCheckHeal ; 87/E6DF

        .al
        .xl
        .autsiz
        .databank ?

        ; Target filter 8 (not at full HP) within the staff's range.

        lda #$0008
        bra rsCheckStaffTargetsWithFilter

      rsStaffTargetCheckRestore ; 87/E6E4

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0009
        bra rsCheckStaffTargetsWithFilter

      rsStaffTargetCheckAllyOnMap ; 87/E6E9

        .al
        .xl
        .autsiz
        .databank ?

        ; Return, warp, charm: not in the castle; then rsStaffTargetCheckAlly.

        lda wUnknown000D79,b
        bit #$0020
        bne rsStaffTargetCheckFail

      rsStaffTargetCheckAlly ; 87/E6F1

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0002
        bra rsCheckStaffTargetsWithFilter

      rsStaffTargetCheckSilence ; 87/E6F6

        .al
        .xl
        .autsiz
        .databank ?

        ; Target filter $C (a magic user with lower resistance).

        lda #$000C
        bra rsCheckStaffTargetsWithFilter

      rsStaffTargetCheckEnemy ; 87/E6FB

        .al
        .xl
        .autsiz
        .databank ?

        ; Target filter $D (an enemy with lower resistance): sleep, berserk, thief.

        lda #$000D

      rsCheckStaffTargetsWithFilter ; 87/E6FE

        .al
        .xl
        .autsiz
        .databank ?

        ; A = target filter, range from the staff (rlCheckStaffTargetsInRange).

        stz wR12
        jsl rlCheckStaffTargetsInRange
        rts

        .databank 0

        ; 87/E705

    .endsection Unsorted87E6D7Section


    .section Unsorted87E705Section

      .al
      .xl

      rsStaffTargetCheckValkyrie ; 87/E705

        .al
        .xl
        .autsiz
        .databank ?

        ; Carry clear: valkyrie has no target on the map.

        clc
        rts

        .databank 0

        ; 87/E707

    .endsection Unsorted87E705Section


    .section Unsorted87E707Section

      .al
      .xl

      rsStaffTargetCheckNone ; 87/E707

        .al
        .xl
        .autsiz
        .databank ?

        clc
        rts

        .databank 0

        ; 87/E709

    .endsection Unsorted87E707Section


    .section Unsorted87E709Section

      .as
      .xl

      rlCheckStaffHasCastleTargets ; 87/E709

        .al
        .xl
        .autsiz
        .databank ?

        ; wCurrentItemDataROMPointer = a staff: in the castle, carry set if someone there can be its target (aCastleStaffTargetChecks).

        phx
        jsl rlGetItemStaffEffect
        asl a
        tax
        jsr (aCastleStaffTargetChecks,x)
        plx
        rtl

        .databank 0

        ; 87/E715

    .endsection Unsorted87E709Section


    .section Table87E715Section

      .al
      .xl

      aCastleStaffTargetChecks ; 87/E715

        ; Jump table of rlCheckStaffHasCastleTargets.
        .word <>rsCastleStaffTargetCheckFail
        .word <>rsCastleStaffTargetCheckHeal
        .word <>rsCastleStaffTargetCheckHeal
        .word <>rsCastleStaffTargetCheckHeal
        .word <>rsCastleStaffTargetCheckHeal
        .word <>rsCastleStaffTargetCheckHeal
        .word <>rsCastleStaffTargetCheckFail
        .word <>rsCastleStaffTargetCheckAlly
        .word <>rsCastleStaffTargetCheckFail
        .word <>rsCastleStaffTargetCheckFail
        .word <>rsCastleStaffTargetCheckRestore
        .word <>rsCastleStaffTargetCheckPass
        .word <>rsCastleStaffTargetCheckFail
        .word <>rsCastleStaffTargetCheckFail
        .word <>rsCastleStaffTargetCheckFail
        .word <>rsCastleStaffTargetCheckFail
        .word <>rsCastleStaffTargetCheckFail

    .endsection Table87E715Section


    .section Unsorted87E737Section

      .al
      .xl

      rsCastleStaffTargetCheckHeal ; 87/E737

        .al
        .xl
        .autsiz
        .databank ?

        ; Target filter 8 (not at full HP).

        lda #$0008
        bra rsCastleStaffTargetCheckAlly._E744

        .databank 0

        ; 87/E73C

      rsCastleStaffTargetCheckRestore ; 87/E73C

        .al
        .xl
        .autsiz
        .databank ?

        ; Target filter 9 (has a status).

        lda #$0009
        bra rsCastleStaffTargetCheckAlly._E744

        .databank 0

        ; 87/E741

      rsCastleStaffTargetCheckAlly ; 87/E741

        .al
        .xl
        .autsiz
        .databank ?

        ; Target filter 2 (the same army).

        lda #$0002

        _E744
        sta wRoutineVariable1,b
        lda wUnknown000D79,b
        bit #$0020
        beq rsCastleStaffTargetCheckFail
        lda $7E4E77
        cmp #$FFFF
        beq rsCastleStaffTargetCheckFail
        jsl rlBuildCastleTargetList
        rts

        .databank 0

        ; 87/E75D

      rsCastleStaffTargetCheckPass ; 87/E75D

        .al
        .xl
        .autsiz
        .databank ?

        sec
        rts

        .databank 0

        ; 87/E75F

      rsCastleStaffTargetCheckFail ; 87/E75F

        .al
        .xl
        .autsiz
        .databank ?

        clc
        rts

        .databank 0

        ; 87/E761

      rlUnknown87E761 ; 87/E761

        .al
        .xl
        .autsiz
        .databank ?

        ; A lone rtl after rsCastleStaffTargetCheckFail. Nothing in the build reaches this.

        rtl

        .databank 0

        ; 87/E762

    .endsection Unsorted87E737Section


    .section Unsorted87E762Section

      .al
      .xl

      rlStartStaffTargetSelection ; 87/E762

        .al
        .xl
        .autsiz
        .databank ?

        ; wCurrentItemDataROMPointer = the staff: by its effect, finds the targets and starts choosing one (aStaffTargetSelectionHandlers).

        phx
        lda #$0800
        trb wUnknown000D79,b
        lda #$0001
        sta wR12
        jsl rlGetItemStaffEffect
        asl a
        tax
        jsr (aStaffTargetSelectionHandlers,x)
        plx
        rtl

        .databank 0

        ; 87/E779

    .endsection Unsorted87E762Section


    .section Unsorted87E779Section

      .al
      .xl

      aStaffTargetSelectionHandlers ; 87/E779

        ; One handler per staff effect (rlGetItemStaffEffect). (tools/sweep.py had
        ; decoded this table as code.)
        .word <>rsStaffTargetSelectionNone
        .word <>rsStaffTargetSelectionHeal
        .word <>rsStaffTargetSelectionHeal
        .word <>rsStaffTargetSelectionHeal
        .word <>rsStaffTargetSelectionHeal
        .word <>rsStaffTargetSelectionFortify
        .word <>rsStaffTargetSelectionAlly
        .word <>rsStaffTargetSelectionWarp
        .word <>rsStaffTargetSelectionAlly
        .word <>rsStaffTargetSelectionRestore
        .word <>rsStaffTargetSelectionRestore
        .word <>rsStaffTargetSelectionNone
        .word <>rsStaffTargetSelectionSilence
        .word <>rsStaffTargetSelectionEnemy
        .word <>rsStaffTargetSelectionEnemy
        .word <>rsStaffTargetSelectionEnemy
        .word <>rsStaffTargetSelectionNone2


      rsStaffTargetSelectionNone ; 87/E79B

        .al
        .xl
        .autsiz
        .databank ?

        rts

        .databank 0

        ; 87/E79C

      rsStaffTargetSelectionWarp ; 87/E79C

        .al
        .xl
        .autsiz
        .databank ?

        ; Sets bit 11 of wUnknown000D79, then as rsStaffTargetSelectionAlly.

        lda #$0800
        tsb wUnknown000D79,b
        jml rsStaffTargetSelectionAlly

        .databank 0

        ; 87/E7A6

      rsStaffTargetSelectionHeal ; 87/E7A6

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0008
        bra rsStartStaffTargetSelectionWithFilter

        .databank 0

        ; 87/E7AB

      rsStaffTargetSelectionRestore ; 87/E7AB

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0009
        bra rsStartStaffTargetSelectionWithFilter

        .databank 0

        ; 87/E7B0

      rsStaffTargetSelectionAlly ; 87/E7B0

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0002
        bra rsStartStaffTargetSelectionWithFilter

        .databank 0

        ; 87/E7B5

      rsStaffTargetSelectionFortify ; 87/E7B5

        .al
        .xl
        .autsiz
        .databank ?

        ; No target to choose: on the map, rlUnknown84DC1C on the user; in the castle, rlCastleUseStaffFromMapRaised.

        jsl rlGetSelectedUnitStates
        bit #UnitStateFielded
        beq _E7CE
        lda wActiveUnitDeploymentOffset,b
        tax
        sta wR0
        lda #$FFFF
        sta wR1
        jsl rlUnknown84DC1C
        rts


        _E7CE
        lda #$FFFF
        sta wMapTargetDeploymentOffset,b
        jsl rlCastleUseStaffFromMapRaised
        rts

        .databank 0

        ; 87/E7D9

      rsStaffTargetSelectionSilence ; 87/E7D9

        .al
        .xl
        .autsiz
        .databank ?

        lda #$000C
        bra rsStartStaffTargetSelectionWithFilter

        .databank 0

        ; 87/E7DE

      rsStaffTargetSelectionEnemy ; 87/E7DE

        .al
        .xl
        .autsiz
        .databank ?

        lda #$000D
        bra rsStartStaffTargetSelectionWithFilter

        .databank 0

        ; 87/E7E3

      rsStaffTargetSelectionNone2 ; 87/E7E3

        .al
        .xl
        .autsiz
        .databank ?

        rts

        .databank 0

        ; 87/E7E4

      rsStartStaffTargetSelectionWithFilter ; 87/E7E4

        .al
        .xl
        .autsiz
        .databank ?

        ; A = target filter: finds the targets (wMapActionTargetType 1), then on the map rlUnknown88AD46, in the castle rlCastleUseStaffFromMap.

        jsl rlCheckStaffTargetsInRange
        lda #$0001
        sta wMapActionTargetType,b
        jsl rlGetSelectedUnitStates
        bit #UnitStateFielded
        beq _E7FC
        jsl rlUnknown88AD46
        rts


        _E7FC
        jsl rlCastleUseStaffFromMap
        rts

        .databank 0

        ; 87/E801

    .endsection Unsorted87E779Section


    .section Unsorted87E801Section

      .al
      .xl

      rlStartCastleStaffTargetSelection ; 87/E801

        .al
        .xl
        .autsiz
        .databank ?

        ; In the castle: as aCastleStaffTargetSelectionHandlers says for the staff's effect.

        phx
        jsl rlCheckStaffHasCastleTargets
        jsl rlGetItemStaffEffect
        asl a
        tax
        jsr (aCastleStaffTargetSelectionHandlers,x)
        plx
        rtl

        .databank 0

        ; 87/E811

    .endsection Unsorted87E801Section


    .section Table87E811Section

      .al
      .xl

      aCastleStaffTargetSelectionHandlers ; 87/E811

        ; Jump table of rlStartCastleStaffTargetSelection.
        .word <>rsCastleStaffSelectionNone
        .word <>rsCastleStaffSelectTarget
        .word <>rsCastleStaffSelectTarget
        .word <>rsCastleStaffSelectTarget
        .word <>rsCastleStaffSelectTarget
        .word <>rsCastleStaffFortify
        .word <>rsCastleStaffSelectionNone
        .word <>rsCastleStaffSelectWarpTarget
        .word <>rsCastleStaffSelectionNone
        .word <>rsCastleStaffSelectionNone
        .word <>rsCastleStaffSelectTarget
        .word <>rsCastleStaffValkyrie
        .word <>rsCastleStaffSelectionNone
        .word <>rsCastleStaffSelectionNone
        .word <>rsCastleStaffSelectionNone
        .word <>rsCastleStaffSelectionNone
        .word <>rsCastleStaffSelectionNone

    .endsection Table87E811Section


    .section Unsorted87E833Section

      .al
      .xl

      rsCastleStaffSelectionNone ; 87/E833

        .al
        .xl
        .autsiz
        .databank ?

        rts

        .databank 0

        ; 87/E834

    .endsection Unsorted87E833Section


    .section Unsorted87E834Section

      .al
      .xl

      rsCastleStaffSelectTarget ; 87/E834

        .al
        .xl
        .autsiz
        .databank ?

        ; Clears bit 11 of wUnknown000D79 and starts rlCastleStartStaffTargetSelection.

        lda #$0800
        trb wUnknown000D79,b
        jsl rlCastleStartStaffTargetSelection
        rts

        .databank 0

        ; 87/E83F

    .endsection Unsorted87E834Section


    .section Unsorted87E83FSection

      .al
      .xl

      rsCastleStaffSelectWarpTarget ; 87/E83F

        .al
        .xl
        .autsiz
        .databank ?

        ; Sets bit 11 of wUnknown000D79 and starts rlCastleStartStaffTargetSelection.

        lda #$0800
        tsb wUnknown000D79,b
        jsl rlCastleStartStaffTargetSelection
        rts

        .databank 0

        ; 87/E84A

    .endsection Unsorted87E83FSection


    .section Unsorted87E84ASection

      .al
      .xl

      rsCastleStaffFortify ; 87/E84A

        .al
        .xl
        .autsiz
        .databank ?

        ; Everyone at once: rlBuildCastleActionRounds with wRoutineVariable1 = $FFFF.

        lda #$FFFF
        sta wRoutineVariable1,b
        jsl rlBuildCastleActionRounds
        rts

        .databank 0

        ; 87/E855

    .endsection Unsorted87E84ASection


    .section Unsorted87E855Section

      .al
      .xl

      rsCastleStaffValkyrie ; 87/E855

        .al
        .xl
        .autsiz
        .databank ?

        ; Fades to the revive screen (rsReviveScreenOpen).

        lda #<>rsReviveScreenOpen
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        rts

        .databank 0

        ; 87/E86A

    .endsection Unsorted87E855Section


    .section Unsorted87E86ASection

      .al
      .xl

      rlGetStaffHealAmount ; 87/E86A

        .al
        .xl
        .autsiz
        .databank ?

        ; wCurrentItemDataROMPointer = the staff: the user's magic + 10, doubled for mend; 80 for recover.

        phb
        php
        phk
        plb
        .databank $87
        phx
        jsl rlGetItemStaffEffect
        tax
        jsl rlGetSelectedUnitTotalMagic
        clc
        adc #$000A
        cpx #$0003
        beq _E893
        cpx #$0001
        beq _E896
        cpx #$0004
        beq _E896
        cpx #$0005
        beq _E896
        asl a
        bra _E896


        _E893
        lda #$0050

        _E896
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 87/E89A

      rlApplyFortify ; 87/E89A

        .al
        .xl
        .autsiz
        .databank ?

        ; Heals by rlGetStaffHealAmount every unit in range on the map (rsApplyFortifyOnMap), or every unit in the castle but the user (rsApplyFortifyInCastle).

        phb
        php
        phk
        plb
        .databank $87
        phx
        lda wSelectedUnitDataRAMPointer,b
        pha
        lda wUnknown000D79,b
        bit #$0020
        bne _E8B0
        jsr rsApplyFortifyOnMap
        bra _E8B3


        _E8B0
        jsr rsApplyFortifyInCastle

        _E8B3
        pla
        sta wSelectedUnitDataRAMPointer,b
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 87/E8BB

      rsApplyFortifyOnMap ; 87/E8BB

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`$7F654A)<<8
        sta lRoutineVariable+1,b
        lda #<>$7F654A
        sta lRoutineVariable,b
        jsl rlGetSelectedUnitDeploymentOffset
        tax
        lda aDeploymentTable._XTilePosition,x
        sta wR10
        lda aDeploymentTable._YTilePosition,x
        sta wR11
        jsl rlUnknown8483F3
        lda #$0001
        sta wR12
        lda #$0001
        jsl rlCheckStaffTargetsInRange
        jsl rlGetStaffHealAmount
        sta wRoutineVariable1,b
        ldx #$03FF

        _E8F2
        lda aTargetDistanceMap,x
        and #$00FF
        cmp #$00FF
        beq _E90F
        phx
        tax
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        lda wRoutineVariable1,b
        jsl rlHealSelectedUnitsHP
        plx

        _E90F
        dec x
        bpl _E8F2
        rts

        .databank 0

        ; 87/E913

      rsApplyFortifyInCastle ; 87/E913

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlGetStaffHealAmount
        sta wRoutineVariable1,b
        ldx #$0000

        _E91D
        lda aCastleUnitDeploymentOffsets,x
        bmi _E93E
        cmp aActionStructUnit1
        beq _E93A
        phx
        tax
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        lda wRoutineVariable1,b
        jsl rlHealSelectedUnitsHP
        plx

        _E93A
        inc x
        inc x
        bpl _E91D

        _E93E
        rts

        .databank 0

        ; 87/E93F

    .endsection Unsorted87E86ASection


