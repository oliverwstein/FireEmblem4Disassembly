; The rules behind the castle unit commands: whether a unit can sortie, guard,
; dance or give money (rlCheckUnitCan*), the list of units in the castle a staff,
; dance or gift can target, and the actions themselves (deploying on or north of
; the castle tile, the castle action rounds, giving money). Banks $84 and $87.


    .section Unsorted84AF17Section

      .al
      .xl

      rlSortieUnitFromCastle ; 84/AF17

        .al
        .xl
        .autsiz
        .databank ?

        ; Deploys the unit on its home castle tile; carry set if it is already fielded.

        phb
        php
        phk
        plb
        .databank $84
        jsl rlGetSelectedUnitStates
        bit #UnitStateFielded
        bne _AF52
        jsl rlGetSelectedUnitHomeCastle
        jsl rlGetLocationEventDataEntry
        jsl rlGetEventLocationEntryEffectiveXCoordinate
        and #$00FF
        sta wRoutineVariable1,b
        jsl rlGetEventLocationEntryEffectiveYCoordinate
        and #$00FF
        xba
        ora wRoutineVariable1,b
        sta wRoutineVariable1,b
        jsl rlDeploySelectedUnit
        lda wEventLocationEntry,b
        sta wTargetEventLocationEntry,b
        plp
        plb
        .databank $84
        clc

        _AF51
        rtl


        _AF52
        plp
        plb
        .databank $84
        sec
        bra _AF51

        .databank 0

        ; 84/AF57

    .endsection Unsorted84AF17Section


    .section Unsorted84AF57Section

      .al
      .xl

      rlSortieUnitNorthOfCastle ; 84/AF57

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Deploys the unit one tile north of its home castle tile and sets bit $0040 of wUnknown000D79; carry set if already fielded.

        phb
        php
        phk
        plb
        .databank $84
        jsl rlGetSelectedUnitStates
        bit #UnitStateFielded
        bne _AF99
        jsl rlGetSelectedUnitHomeCastle
        jsl rlGetLocationEventDataEntry
        jsl rlGetEventLocationEntryEffectiveXCoordinate
        and #$00FF
        sta wRoutineVariable1,b
        jsl rlGetEventLocationEntryEffectiveYCoordinate
        and #$00FF
        dec a
        xba
        ora wRoutineVariable1,b
        sta wRoutineVariable1,b
        jsl rlDeploySelectedUnit
        lda wEventLocationEntry,b
        sta wTargetEventLocationEntry,b
        lda #$0040
        tsb wUnknown000D79,b
        plp
        plb
        .databank $84
        clc

        _AF98
        rtl


        _AF99
        plp
        plb
        .databank $84
        sec
        bra _AF98

        .databank 0

        ; 84/AF9E

    .endsection Unsorted84AF57Section


    .section Unsorted84B6A6Section

      .al
      .xl

      rlBuildCastleActionRounds ; 84/B6A6

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Sets up the action struct for a castle staff or dance on target wRoutineVariable1, with both units on castle terrain.

        phb
        php
        phk
        plb
        .databank $84
        phx
        jsl rlGetSelectedUnitDeploymentOffset
        tax
        stz wTargetEventLocationEntry,b
        jsl rlUnknown84CAA9
        lda wSelectedUnitDataRAMPointer,b
        sta wR0
        lda wRoutineVariable1,b
        sta wR1
        jsl rlUnknown84B72C
        sep #$20
        lda #$03
        sta $7E4EA9
        rep #$20
        lda #$0009
        sta aActionStructUnit1.TerrainType
        sta aActionStructUnit2.TerrainType
        jsl rlActionStructBuildBattleRounds
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 84/B6E2

    .endsection Unsorted84B6A6Section


    .section Unsorted84B6E2Section

      .al
      .xl

      rlBuildCastleDanceRounds ; 84/B6E2

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $84
        lda #$FFFF
        sta wRoutineVariable1,b
        stz wSelectedInventorySlot,b
        jsl rlBuildCastleActionRounds
        plp
        plb
        .databank $84
        rtl

        .databank 0

        ; 84/B6F6

    .endsection Unsorted84B6E2Section


    .section Unsorted84B6F6Section

      .al
      .xl

      rlCastleGiveMoney ; 84/B6F6

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Gives money from the unit to the unit in wRoutineVariable1 (rlUnknown84D334, then rlUnknown9EDAE7).

        phb
        php
        phk
        plb
        .databank $84
        phx
        lda wSelectedUnitDataRAMPointer,b
        pha
        jsl rlGetSelectedUnitDeploymentOffset
        tax
        sta wR0
        lda wRoutineVariable1,b
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitDeploymentOffset
        sta wR1
        jsl rlUnknown84D334
        sep #$20
        lda #$03
        sta $7E4EA9
        rep #$20
        jsl rlUnknown9EDAE7
        pla
        sta wSelectedUnitDataRAMPointer,b
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 84/B72C

      rlUnknown84B72C ; 84/B72C

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb
        .databank $7E
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
        jsl rlClearBattleData
        sep #$20
        lda #$00
        sta @l wBattleStatus
        rep #$20
        lda @l wBattleStatus
        and #$0001
        sta wR0
        ldx #$4EB5
        lda @l wActionStructAttackerDeploymentNumber
        jsl rlUnknown84B7EE
        lda @l aActionStructUnit1.WeaponMinRange
        sta @l wBattleDistance
        lda @l wBattleStatus
        and #$0001
        eor #$0001
        sta wR0
        ldx #$4F15
        lda @l wActionStructDefenderDeploymentNumber
        jsl rlUnknown84B7EE
        lda @l wBattleStatus
        and #$0001
        sta wR0
        ldx #$4EB5
        ldy #$4F15
        jsl rlApplyWeaponTriangleBonus
        lda @l wBattleStatus
        and #$0001
        eor #$0001
        sta wR0
        ldx #$4F15
        ldy #$4EB5
        jsl rlApplyWeaponTriangleBonus
        lda @l wBattleStatus
        and #$0001
        sta wR0
        ldx #$4EB5
        ldy #$4F15
        jsl rlActionStructAdjustFinalStats
        lda @l wBattleStatus
        and #$0001
        eor #$0001
        sta wR0
        ldx #$4F15
        ldy #$4EB5
        jsl rlActionStructAdjustFinalStats
        jsr rsActionStructGetBattleTriggerableSkillFlags
        jsr rsBattleHandleEffectiveness
        ply
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 84/B7EE

      rlUnknown84B7EE ; 84/B7EE

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        cmp #$0000
        bpl _B7F7
        jml _B8BD


        _B7F7
        sta $0006,b,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitDeploymentOffset
        tay
        sta $0000,b,x
        lda $441B,b,y
        sta $0002,b,x
        lda $44AB,b,y
        sta $0004,b,x
        lda #$0017
        sta $000E,b,x
        jsl rlGetSelectedUnitCharacterID
        sta $0008,b,x
        jsl rlGetSelectedUnitClassID
        sta $000A,b,x
        jsl rlGetSelectedUnitGender
        sta $000C,b,x
        jsl rlGetSelectedUnitCurrentHP
        sta $0010,b,x
        jsl rlGetSelectedUnitMaxHP
        sta $0012,b,x
        jsl rlGetSelectedUnitLevel
        sta $0014,b,x
        lda #$0000
        sta $0016,b,x
        jsl rlGetSelectedUnitExperience
        sta $0018,b,x
        lda #$0000
        sta $001A,b,x
        lda wR0
        beq _B867
        lda wBattleDistance
        jsl rlGetCounterableWeaponSlot
        ora #$0000
        beq _B86F
        bra _B86A


        _B867
        lda wSelectedInventorySlot,b

        _B86A
        sta $0026,b,x
        bne _B87D

        _B86F
        lda #$FFFF
        sta $0028,b,x
        lda #$0001
        sta $002C,b,x
        bra _B89D


        _B87D
        jsl rlGetItemIDByInventorySlot
        sta $0028,b,x
        jsl rlGetItemDataROMPointer
        jsl rlGetItemWeaponType
        sta $002A,b,x
        jsl rlGetItemMinimumRange
        sta $002C,b,x
        jsl rlGetItemMaximumRange
        sta $002E,b,x

        _B89D
        jsl rlUnknown84FEB5
        sta $0030,b,x
        jsl rlUnknown84FE98
        sta $0034,b,x
        lda $000E,b,x
        jsl rlUnknown84FEA1
        sta $0036,b,x
        jsl rlUnknown84FEAC
        sta $0038,b,x
        rtl


        _B8BD
        sta $0000,b,x
        rtl

        .databank 0

        ; 84/B8C1

    .endsection Unsorted84B6F6Section


    .section Unsorted879F12Section

      .al
      .xl

      rlCheckUnitCanSortie ; 87/9F12

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Carry set if the unit is not dead, moved or fielded, nothing stands on its home castle tile, and it is not Deirdre from chapter 3 on.

        lda wSelectedUnitDataRAMPointer,b
        pha
        lda wEventLocationEntry,b
        pha
        lda wR0
        pha
        lda wR1
        pha
        jsl rlGetSelectedUnitStates
        bit #UnitStateDead | UnitStateMoved | UnitStateFielded
        bne _9F54
        jsl rlGetSelectedUnitHomeCastle
        jsl rlGetLocationEventDataEntry
        jsl rlGetEventLocationEntryEffectiveXCoordinate
        sta wR0
        jsl rlGetEventLocationEntryEffectiveYCoordinate
        sta wR1
        jsl rlGetUnitByCoordinates
        bcc _9F54
        lda wCurrentChapter,b
        cmp #$0003
        bcc _9F57
        jsl rlGetSelectedUnitCharacterID
        cmp #$0010
        bne _9F57

        _9F54
        clc
        bra _9F58


        _9F57
        sec

        _9F58
        pla
        sta wR1
        pla
        sta wR0
        pla
        sta wEventLocationEntry,b
        pla
        sta wSelectedUnitDataRAMPointer,b
        rtl

        .databank 0

        ; 87/9F67

      rlCheckUnitCanGuard ; 87/9F67

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Carry set if the unit is not dead, moved or fielded, its home castle is not already guarded, and it is not Deirdre from chapter 3 on.

        lda wEventLocationEntry,b
        pha
        jsl rlGetSelectedUnitStates
        bit #UnitStateDead | UnitStateMoved | UnitStateFielded
        bne _9F93
        jsl rlGetSelectedUnitHomeCastle
        jsl rlGetLocationEventDataEntry
        jsl rlCheckIfCastleGuarded
        bcs _9F93
        lda wCurrentChapter,b
        cmp #$0003
        bcc _9F96
        jsl rlGetSelectedUnitCharacterID
        cmp #$0010
        bne _9F96

        _9F93
        clc
        bra _9F97


        _9F96
        sec

        _9F97
        pla
        sta wEventLocationEntry,b
        rtl

        .databank 0

        ; 87/9F9C

      rlCheckUnitCanGive ; 87/9F9C

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Carry set if the unit has money and a unit in the castle can take it (target list $0A for units with Steal, $0B otherwise).

        jsl rlGetSelectedUnitMoney
        cmp #$0001
        bcc _9FBD
        lda #SkillIDSteal
        jsl rlCheckIfUnitHasSpecifiedPersonalOrClassSkill
        bcc _9FB3
        lda #$000A
        bra _9FB6


        _9FB3
        lda #$000B

        _9FB6
        sta wRoutineVariable1,b
        jsl rlBuildCastleTargetList

        _9FBD
        rtl

        .databank 0

        ; 87/9FBE

      rlBuildCastleTargetList ; 87/9FBE

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Lists the units in aCastleUnitDeploymentOffsets that pass rlUnknown848BFE for target type wRoutineVariable1, at $7E2100 (count) and $7E2102.

        phx
        lda #$0000
        tax
        sta $7E2100

        _9FC7
        lda aCastleUnitDeploymentOffsets,x
        bmi _9FEC
        phx
        tax
        lda wRoutineVariable1,b
        jsl rlUnknown848BFE
        plx
        bcc _9FEC
        lda aCastleUnitDeploymentOffsets,x
        sta $7E2102,x
        lda $7E2100
        inc a
        sta $7E2100
        bra _9FF3


        _9FEC
        lda #$FFFF
        sta $7E2102,x

        _9FF3
        inc x
        inc x
        cpx #$0030
        bcc _9FC7
        lda $7E2100
        bne _A003
        clc
        bra _A004


        _A003
        sec

        _A004
        plx
        rtl

        .databank 0

        ; 87/A006

    .endsection Unsorted879F12Section


    .section Unsorted87A006Section

      .al
      .xl

      rlCheckUnitCanDance ; 87/A006

        .al
        .xl
        .autsiz
        .databank ?

        ; Carry set if the unit can dance and a unit in the castle is a dance target (target list $07).

        lda #SkillIDDance
        jsl rlCheckIfUnitHasSpecifiedPersonalOrClassSkill
        bcc _A019
        lda #$0007
        sta wRoutineVariable1,b
        jsl rlBuildCastleTargetList

        _A019
        rtl

        .databank 0

        ; 87/A01A

      rlCheckInCastleTargetList ; 87/A01A

        .al
        .xl
        .autsiz
        .databank ?

        ; Carry set if deployment offset wRoutineVariable1 is in the target list at $7E2102.

        phb
        phk
        plb
        .databank $87
        phx
        lda $7E2100
        beq _A039
        ldx #$0000

        _A027
        lda $7E2102,x
        bmi _A032
        cmp wRoutineVariable1,b
        beq _A03C

        _A032
        inc x
        inc x
        cpx #$0030
        bcc _A027

        _A039
        clc
        bra _A03D


        _A03C
        sec

        _A03D
        plx
        plb
        .databank ?
        rtl

        .databank 0

        ; 87/A040

    .endsection Unsorted87A006Section


    .section Unsorted87EF46Section

      .al
      .xl

      rlGetCastleFacilities ; 87/EF46

        .al
        .xl
        .autsiz
        .databank ?

        ; Returns the facility bits of the castle in wEventLocationEntry (the byte after YPosition in its location entry).

        phb
        php
        phk
        plb
        .databank $87
        phx
        ldx wEventLocationEntry,b
        sep #$20
        lda lChapterEventDataPointer+2,b
        pha
        rep #$20
        plb
        .databank ?
        lda structChapterLocationEntry.YPosition+1,b,x
        and #$00FF
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 87/EF61

    .endsection Unsorted87EF46Section
