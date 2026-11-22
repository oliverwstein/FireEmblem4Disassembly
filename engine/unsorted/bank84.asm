; Code from bank $84 not yet assigned to a game system.

    .section Unsorted8486A0Section

      .al
      .xl

      rlUnknown8486A0 ; 84/86A0

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $84
        phx
        phy
        pha
        stz wRoutineVariable1,b
        cmp #$0019
        bcc _86B5
        lda #$0018
        sta wRoutineVariable1,b

        _86B5
        pla
        jsl rlSwapToMainDataBank
        jsl rlGetCharacterDataROMPointer
        tay
        lda $0000,b,y
        and #$00FF
        cmp #$0001
        beq _86CF
        lda $0011,b,y
        bra _86D2


        _86CF
        lda $0007,b,y

        _86D2
        and #$00FF
        dec a
        clc
        adc wRoutineVariable1,b
        asl a
        tax
        lda aUnitWinCounts,x
        ply
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 84/86E5

      rlUnknown8486E5 ; 84/86E5

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $84
        phy
        pha
        stz wRoutineVariable1,b
        cmp #$0019
        bcc _86F9
        lda #$0018
        sta wRoutineVariable1,b

        _86F9
        pla
        jsl rlSwapToMainDataBank
        jsl rlGetCharacterDataROMPointer
        tay
        lda $0000,b,y
        and #$00FF
        cmp #$0001
        beq _8713
        lda $0011,b,y
        bra _8716


        _8713
        lda $0007,b,y

        _8716
        and #$00FF
        dec a
        clc
        adc wRoutineVariable1,b
        jsl rlGetLossCountByIndex
        ply
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 84/8726

    .endsection Unsorted8486A0Section


    .section Unsorted848BFESection

      .al
      .xl

      rlUnknown848BFE ; 84/8BFE

        .al
        .xl
        .autsiz
        .databank ?

        phb
        phk
        plb
        .databank $84
        phx
        phy
        ldy wR0
        phy
        phx
        asl a
        tax
        lda aTargetFilterRoutines,x
        sta wR0
        plx
        lda aDeploymentTable._UnitRAMPointer,x
        cmp wSelectedUnitDataRAMPointer,b
        beq _8C2E
        sep #$20
        lda #$7F
        pha
        rep #$20
        plb
        .databank $7F
        txa
        pea #<>_8C27 - 1
        jmp (wR0)


        _8C27
        plx
        stx wR0
        ply
        plx
        plb
        .databank $7F
        rtl


        _8C2E
        clc
        bra _8C27

        .databank 0

        ; 84/8C31

    .endsection Unsorted848BFESection


    .section Unsorted848E5DSection

      .al
      .xl

      rlUnknown848E5D ; 84/8E5D

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $84
        lda wR12
        pha
        lda wR13
        pha
        lda wCursorXOffset,b
        clc
        adc wMapScrollXPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR12
        lda wCursorYOffset,b
        clc
        adc wMapScrollYPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR13
        lda wR10
        sec
        sbc wR12
        sta wMapCursorXTile,b
        lda wR11
        sec
        sbc wR13
        sta wMapCursorYTile,b
        lda #$0004
        sta wUnknown0007D8,b
        pla
        sta wR13
        pla
        sta wR12
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 84/8EA0

    .endsection Unsorted848E5DSection


    .section Unsorted8499B5Section

      .al
      .xl

      rlUnknown8499B5 ; 84/99B5

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $84
        phx
        phy
        lda lR18
        pha
        lda lR18+1
        pha
        jsl rlGetSelectedUnitClassDataPointer
        jsl rlGetSelectedUnitExtendedPersonalDataPointer
        lda lRAMBufferPointer+1,b
        sta lR18+1
        lda lRAMBufferPointer,b
        sta lR18
        ldy #$0018
        lda $000D,b,x
        and #$00FF
        sta [lR18],y
        ldy #$0000
        jsl rlGetSelectedUnitMaxHP
        sta [lR18],y
        ldy #$0002
        jsl rlGetSelectedUnitTotalStrength
        sta [lR18],y
        ldy #$0004
        jsl rlGetSelectedUnitTotalMagic
        sta [lR18],y
        ldy #$0006
        jsl rlGetSelectedUnitTotalSkill
        sta [lR18],y
        ldy #$0008
        jsl rlGetSelectedUnitTotalSpeed
        sta [lR18],y
        ldy #$000A
        jsl rlGetSelectedUnitTotalDefense
        sta [lR18],y
        ldy #$000C
        jsl rlGetSelectedUnitTotalResistance
        sta [lR18],y
        ldy #$000E
        jsl rlGetSelectedUnitLuck
        sta [lR18],y
        ldy #$0012
        jsl rlGetSelectedUnitLevel
        sta [lR18],y
        ldy #$0016
        jsl rlGetSelectedUnitMoney
        sta [lR18],y
        ldy #$001C
        jsl rlGetSelectedUnitTotalMovement
        sta [lR18],y
        pla
        sta lR18+1
        pla
        sta lR18
        ply
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 84/9A4C

    .endsection Unsorted8499B5Section


    .section Unsorted84AC24Section

      .al
      .xl

      rsUnknown84AC24 ; 84/AC24

        .al
        .xl
        .autsiz
        .databank ?

        phb
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb
        .databank $7E
        lda #$0000
        sta $0000,b,x
        lda wSelectedUnitDataRAMPointer,b
        sta $0006,b,x
        lda #$0001
        sta wR0
        jsl rlActionStructGetBasicBattleData
        lda #$00FF
        sta $003A,b,x
        sta $003C,b,x
        sta $0032,b,x
        plb
        .databank $7E
        rts

        .databank 0

        ; 84/AC50

      rsUnknown84AC50 ; 84/AC50

        .al
        .xl
        .autsiz
        .databank ?

        phb
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb
        .databank $7E
        lda aUnit1DataBuffer._Extended.HP
        sta $0000,b,x
        lda #$0000
        sta $0010,b,x
        lda aUnit1DataBuffer._Extended.Strength
        sta $0002,b,x
        lda aUnit2DataBuffer._Extended.Strength
        sec
        sbc aUnit1DataBuffer._Extended.Strength
        sta $0012,b,x
        lda aUnit1DataBuffer._Extended.Magic
        sta $0004,b,x
        lda aUnit2DataBuffer._Extended.Magic
        sec
        sbc aUnit1DataBuffer._Extended.Magic
        sta $0014,b,x
        lda aUnit1DataBuffer._Extended.Skill
        sta $0006,b,x
        lda aUnit2DataBuffer._Extended.Skill
        sec
        sbc aUnit1DataBuffer._Extended.Skill
        sta $0016,b,x
        lda aUnit1DataBuffer._Extended.Speed
        sta $0008,b,x
        lda aUnit2DataBuffer._Extended.Speed
        sec
        sbc aUnit1DataBuffer._Extended.Speed
        sta $0018,b,x
        lda aUnit1DataBuffer._Extended.Defense
        sta $000A,b,x
        lda aUnit2DataBuffer._Extended.Defense
        sec
        sbc aUnit1DataBuffer._Extended.Defense
        sta $001A,b,x
        lda aUnit1DataBuffer._Extended.Resistance
        sta $000C,b,x
        lda aUnit2DataBuffer._Extended.Resistance
        sec
        sbc aUnit1DataBuffer._Extended.Resistance
        sta $001C,b,x
        lda aUnit1DataBuffer._Extended.Luck
        sta $000E,b,x
        lda #$0000
        sta $001E,b,x
        plb
        .databank $7E
        rts

        .databank 0

        ; 84/ACE7

    .endsection Unsorted84AC24Section


    .section Unsorted84B32BSection

      .al
      .xl

      rlUnknown84B32B ; 84/B32B

        .al
        .xl
        .autsiz
        .databank ?

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


    .section Unsorted84B349Section

      .al
      .xl

      rlUnknown84B349 ; 84/B349

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $84
        lda wRoutineVariable1,b
        jsl rlGetItemROMDataByInventorySlot
        jsl rlGetItemRepairCost
        sta wRoutineVariable1,b
        jsr rsUnknown84B3C3
        bcc _B363
        lsr wRoutineVariable1,b

        _B363
        jsl rlGetSelectedUnitMoney
        cmp wRoutineVariable1,b
        bcc _B37A
        jsl rlSubtractSelectedCharacterMoney
        jsl rlGetItemMaxDurability2
        jsl rlSetItemRAMStructEntryDurability
        bra _B3AE


        _B37A
        jsl rlGetItemRepairCostPerUse
        sta wRoutineVariable1,b
        jsr rsUnknown84B3C3
        bcc _B389
        lsr wRoutineVariable1,b

        _B389
        jsl rlGetSelectedUnitMoney
        cmp wRoutineVariable1,b
        bcc _B3BB
        sta wR13
        lda wRoutineVariable1,b
        sta wR14
        jsl rlUnsignedDivide16By16R13
        jsl rlGetItemCurrentDurability
        clc
        adc wR13
        jsl rlSetItemRAMStructEntryDurability
        lda wR10
        jsl rlSetSelectedUnitMoney

        _B3AE
        jsl rlSaveEquippedWeaponStatBonus
        plp
        plb
        .databank $84
        clc

        _B3B5
        rtl

        lda #$0000
        bra _B3BE


        _B3BB
        lda #$0001

        _B3BE
        plp
        plb
        .databank $84
        sec
        bra _B3B5

        .databank 0

        ; 84/B3C3

      rsUnknown84B3C3 ; 84/B3C3

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda wCurrentItemDataROMPointer,b
        pha
        lda wCurrentItemDataRAMPointer,b
        pha
        lda #SkillIDBargain
        jsl rlCheckIfUnitHasSpecifiedPersonalOrClassSkill
        bcs _B3DB
        lda #SkillIDBargain
        jsl rlCheckIfInventoryItemsHaveSpecifiedSkill

        _B3DB
        pla
        sta wCurrentItemDataRAMPointer,b
        pla
        sta wCurrentItemDataROMPointer,b
        rts

        .databank 0

        ; 84/B3E4

    .endsection Unsorted84B349Section


    .section Unsorted84B508Section

      .al
      .xl

      rlUnknown84B508 ; 84/B508

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $84
        lda wSelectedUnitDataRAMPointer,b
        sta wR0
        lda #$2100
        sta wR1
        lda wUnknown000D79,b
        bit #$0010
        bne _B530
        jsl rlUnknown87A082
        bcs _B54D
        pha
        lda #$2100
        sta wSelectedUnitDataRAMPointer,b
        pla
        jsl rlCreateUnit

        _B530
        jsl rlUnknown84B72C
        sep #$20
        lda #$01
        sta $7E4EA9
        rep #$20
        jsl rlActionStructBuildBattleRounds
        lda #$003B
        sta wBattleSong
        jsl rlUnknown81B368

        _B54D
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 84/B550

    .endsection Unsorted84B508Section


    .section Unsorted84B550Section

      .al
      .xl

      rlUnknown84B550 ; 84/B550

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $84
        phx
        jsl rlGetSelectedUnitDeploymentOffset
        tax
        lda aDeploymentTable._StateBuffer,x
        bit #$0020
        bne _B56E
        lda aActionStructUnit1.ObtainedArenaMoney
        beq _B573
        lda #$0000
        bra _B576


        _B56E
        lda #$0001
        bra _B576


        _B573
        lda #$0002

        _B576
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 84/B57A

    .endsection Unsorted84B550Section


    .section Unsorted84B9A3Section

      .al
      .xl

      rlUnknown84B9A3 ; 84/B9A3

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

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
        jsr rsUnknown84B9D4
        bcs _B9C9
        jsr rsUnknown84BA09
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

      rsUnknown84B9D4 ; 84/B9D4

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

      rsUnknown84BA09 ; 84/BA09

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

      rlUnknown84BA3E ; 84/BA3E

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

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
        jsr rsUnknown84B9D4
        bcs _BA64
        jsr rsUnknown84BA09
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

      rlUnknown84BA6F ; 84/BA6F

        .al
        .xl
        .autsiz
        .databank ?

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


    .section Unsorted84BB54Section

      .al
      .xl

      rlUnknown84BB54 ; 84/BB54

        .al
        .autsiz
        .databank ?

        jsl rlCheckIfBattleAnimationOFF
        bcs _Off

        ; On
        jsl rlUnknown81B368
        bra +

        _Off
        jsl rlUnknown81B35B

        +
        rtl

        .databank 0

    .endsection Unsorted84BB54Section


    .section Unsorted84C398Section

      .al
      .xl

      rsUnknown84C398 ; 84/C398

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        ldy wSelectedUnitDataRAMPointer,b
        ldx #$001C

        _C3A0
        lda $7E2000,x
        beq _C3BA
        sta wRoutineVariable1,b
        sty wSelectedUnitDataRAMPointer,b
        jsl rlGetUnitLoveGrowthWithTarget
        sta wRoutineVariable1,b
        txa
        lsr a
        inc a
        jsl rlModifyUnitsLovePoints

        _C3BA
        dec x
        dec x
        bpl _C3A0
        ply
        plx
        rts

        .databank 0

        ; 84/C3C1

      rsUnknown84C3C1 ; 84/C3C1

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        stx wR0
        ldx #$008E

        _C3C8
        lda aDeploymentTable,x
        bit #$0080
        beq _C40B
        lda aDeploymentTable._FactionSlot,x
        bne _C40B
        stx wR1
        jsl rlGetUnitsDistance
        cmp #$0002
        bcs _C40B
        sta wRoutineVariable1,b
        lda #$0006
        sec
        sbc wRoutineVariable1,b
        sta wRoutineVariable1,b
        ldy wSelectedUnitDataRAMPointer,b
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitGenerationID
        bcs _C40B
        cmp #$0010
        bcs _C40B
        sty wSelectedUnitDataRAMPointer,b
        jsl rlModifyUnitsLovePoints

        _C40B
        dec x
        dec x
        bpl _C3C8
        ply
        plx
        rts

        .databank 0

        ; 84/C412

    .endsection Unsorted84C398Section


    .section Unsorted84C412Section

      .al
      .xl

      rlUnknown84C412 ; 84/C412

        .al
        .autsiz
        .databank ?

        ; A = FactionSlot?

        phb
        php
        phk
        plb
        phx
        phy

        ldx wSelectedUnitDataRAMPointer,b
        phx
        ldx wRoutineVariable1,b
        phx

        tay
        ldx #(24 - 1) * size(word)
        lda #0
        
          -
          sta $7E2000,x
          dec x
          dec x
          bpl -

        ldx #1
        
          -
          stx wRoutineVariable1,b
          tya
          jsl rlGetUnitRAMDataPointerByFactionSlotEntryID

          lda wSelectedUnitDataRAMPointer,b
          beq _End

            jsl rlGetSelectedUnitGenerationID
            bcs +

              phx
              dec a
              asl a
              tax
              lda wSelectedUnitDataRAMPointer,b
              sta $7E2000,x
              plx

          +
          inc x
          bra -
        
        _End
        plx
        stx wRoutineVariable1,b
        plx
        stx wSelectedUnitDataRAMPointer,b

        ply
        plx
        plp
        plb
        rtl

        .databank 0

        ; 84/C461

    .endsection Unsorted84C412Section


    .section Unsorted84C5D7Section

      .al
      .xl

      rlUnknown84C5D7 ; 84/C5D7

        .al
        .autsiz
        .databank ?

        phb
        phx
        phy

        tax
        ora #0
        beq _SEC

          jsl rlGetFactionSlotNameID
          cmp #$00FF
          beq _CLC

          txa
          jsl rlCountFactionFieldedLivingUnits
          ora #0
          beq _CLC

            jsl rlUnknown81B503

            lda $24
            beq _SEC

              txa
              asl a
              clc
              adc $24
              tay

              sep #$20
              lda $24+2
              pha
              rep #$20
              plb

              lda $0000,b,y
              cmp #$FFFF
              beq _SEC

                lda $0001,b,y
                and #$00FF
                sta wEventEngineParameter1,b
                lda $0000,b,y
                and #$00FF
                jsl rlCheckIfEventFlagOfSpecifiedChapterSet
                bcc _CLC
        
        _SEC
        sec
        bra +
        
        _CLC
        clc
        
        +
        ply
        plx
        plb
        rtl

        .databank 0

        ; 84/C62E

    .endsection Unsorted84C5D7Section


    .section Unsorted84C62ESection

      .al
      .xl

      rlUnknown84C62E ; 84/C62E

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $84
        phx
        phy
        ldx wR0
        phx
        tay
        lda wRoutineVariable1,b
        sta wR0
        ldx #$0001

        _C640
        stx wRoutineVariable1,b
        tya
        jsl rlGetUnitRAMDataPointerByFactionSlotEntryID
        lda wSelectedUnitDataRAMPointer,b
        beq _C656
        lda wR0
        jsl rlSetSelectedUnitMapAnimation
        inc x
        bra _C640


        _C656
        plx
        stx wR0
        ply
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 84/C65E

    .endsection Unsorted84C62ESection


    .section Unsorted84CC5DSection

      .al
      .xl

      rlUnknown84CC5D ; 84/CC5D

        .al
        .xl
        .autsiz
        .databank ?

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
        jsl rlUnknown88B2A5
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

      rlUnknown84CD35 ; 84/CD35

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

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
        jsl rlUnknown84CD8A
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

      rlUnknown84CD8A ; 84/CD8A

        .al
        .xl
        .autsiz
        .databank ?

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
        lda #$0003
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

      rlUnknown84CDA4 ; 84/CDA4

        .al
        .autsiz
        .databank ?

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

      rlUnknown84CDD6 ; 84/CDD6

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

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
        sta wPhaseScratch000D8D,b
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

      rlUnknown84CE21 ; 84/CE21

        .al
        .autsiz
        .databank ?

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
        jsr rsUnknown84CEA3
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
            jsl rlUnknown888410
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

      rsUnknown84CEA3 ; 84/CEA3

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

      rlUnknown84CF0F ; 84/CF0F

        .al
        .autsiz
        .databank ?

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

      rlUnknown84CFBF ; 84/CFBF

        .al
        .autsiz
        .databank ?

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

                jsr rsUnknown84D010

        +
        pla
        sta wR1
        pla
        sta wR0
        plp
        plb
        rtl

        .databank 0

      rsUnknown84D010 ; 84/D010

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

      rlUnknown84D03E ; 84/D03E

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

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
        jsr rsUnknown84D0B2
        bra _D0AE


        _D098
        jsl rlUnknown88ADA6

        _D09C
        jsl rlUnknown88ADC9
        bra _D0AE


        _D0A2
        jsl rlUnknown84D483
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

      rsUnknown84D0B2 ; 84/D0B2

        .al
        .xl
        .autsiz
        .databank ?

        lda #$8004
        sta wMapActionMode,b
        rts

        .databank 0

        ; 84/D0B9

    .endsection Unsorted84D0B2Section


    .section Unsorted84D0B9Section

      .al
      .xl

      rlUnknown84D0B9 ; 84/D0B9

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

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
        jsl rlUnknown84BA6F
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

      rlUnknown84D10F ; 84/D10F

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

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
        jsl rlUnknown84BA6F
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

      rlUnknown84D16B ; 84/D16B

        .al
        .autsiz
        .databank ?

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

      rlUnknown84D1CC ; 84/D1CC

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

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
        jsr rsUnknown84D20D

        _D209
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 84/D20D

      rsUnknown84D20D ; 84/D20D

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
        jsl rsUnknown88AF4C
        rts

        .databank 0

        ; 84/D247

      rlUnknown84D247 ; 84/D247

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

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
        jsr rsUnknown84D20D

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

      rlUnknown84D2BA ; 84/D2BA

        .al
        .xl
        .autsiz
        .databank ?

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
        lda #$0007
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

      rlUnknown84D334 ; 84/D334

        .al
        .xl
        .autsiz
        .databank ?

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

      rlUnknown84D483 ; 84/D483

        .al
        .xl
        .autsiz
        .databank ?

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

      rlUnknown84D4A2 ; 84/D4A2

        .al
        .autsiz
        .databank ?

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
        tsb wUnknown000D79,b

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


    .section Unsorted84EB24Section

      .al
      .xl

      rsUnknown84EB24 ; 84/EB24

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ldx $CCD8,b
        ldy $CCDA,b
        lda #$0002
        tsb $CCDE,b
        jsr rsUnknown84E62C
        phx
        lda $0000,b,y
        tax
        lda aDeploymentTable._StateBuffer,x
        and #$FFF7
        sta aDeploymentTable._StateBuffer,x
        lda #$0004
        tsb wUnknown000D79,b
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

    .endsection Unsorted84EB24Section


    .section Unsorted84F75CSection

      .al
      .xl

      rlUnknown84F75C ; 84/F75C

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlGetItemROMDataByInventorySlot
        jsl rlCheckStaffEquippable
        rtl

        .databank 0

        ; 84/F765

      rlUnknown84F765 ; 84/F765

        .al
        .xl
        .autsiz
        .databank ?

        phb
        phk
        plb
        .databank $84
        jsl rlGetItemROMDataByInventorySlot
        lda wCurrentItemDataROMPointer,b
        beq _F783
        jsl rlGetItemEquipmentType
        cmp #$0001
        beq _F783
        jsl rlCheckStaffHasTargets
        bcc _F783
        sec

        _F781
        plb
        .databank $84
        rtl


        _F783
        clc
        bra _F781

        .databank 0

        ; 84/F786

      rlUnknown84F786 ; 84/F786

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $84
        phx
        phy
        lda wR0
        pha
        lda wR1
        pha
        lda #(`$7F654A)<<8
        sta lRoutineVariable+1,b
        lda #<>$7F654A
        sta lRoutineVariable,b
        jsl rlUnknown8483F3
        lda #$0400
        jsl rlUnsetSelectedUnitStates
        lda #$0000
        sta aUnitMenuWeaponSlots
        sta aUnitMenuStaffSlots
        sta aUnitMenuAssaultSlots
        sta aUnitMenuItemSlots
        sta aUnitMenuEquipSlots
        lda #$0001
        sta wR0

        _F7C5
        jsl rlGetSelectedUnitStates
        bit #UnitStateCanto
        bne _F7DA
        jsr rsUnknown84F7F5
        jsr rsUnknown84F815
        jsr rsUnknown84F845
        jsr rsUnknown84F865

        _F7DA
        jsr rsUnknown84F877
        inc wR0
        lda wR0
        cmp #$0008
        bcs _F7EA
        jml _F7C5


        _F7EA
        pla
        sta wR1
        pla
        sta wR0
        ply
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 84/F7F5

      rsUnknown84F7F5 ; 84/F7F5

        .al
        .xl
        .autsiz
        .databank ?

        lda #<>aUnitMenuWeaponSlots
        sta wR1
        lda wR0
        jsl rlCheckWeaponInInventorySlotEquippable
        bcc _F814
        stz wR12
        lda #$0000
        jsl rlUnknown84FED2
        ora #$0000
        beq _F814
        jml rsUnknown84F877._F889


        _F814
        rts

        .databank 0

        ; 84/F815

      rsUnknown84F815 ; 84/F815

        .al
        .xl
        .autsiz
        .databank ?

        lda #<>aUnitMenuStaffSlots
        sta wR1
        lda wR0
        jsl rlUnknown84F75C
        bcc _F82C
        jsl rlCheckStaffHasTargets
        bcc _F82C
        jml rsUnknown84F877._F889


        _F82C
        rts

        .databank 0

        ; 84/F82D

      rsUnknown84F82D ; 84/F82D

        .al
        .xl
        .autsiz
        .databank ?

        lda #<>aUnitMenuCastleStaffSlots
        sta wR1
        lda wR0
        jsl rlUnknown84F75C
        bcc _F844
        jsl rlCheckStaffHasCastleTargets
        bcc _F844
        jml rsUnknown84F877._F889


        _F844
        rts

        .databank 0

        ; 84/F845

      rsUnknown84F845 ; 84/F845

        .al
        .xl
        .autsiz
        .databank ?

        lda #<>aUnitMenuAssaultSlots
        sta wR1
        lda wR0
        jsl rlCheckWeaponInInventorySlotEquippable
        bcc _F864
        stz wR12
        lda #$0004
        jsl rlUnknown84FED2
        ora #$0000
        beq _F864
        jml rsUnknown84F877._F889


        _F864
        rts

        .databank 0

        ; 84/F865

      rsUnknown84F865 ; 84/F865

        .al
        .xl
        .autsiz
        .databank ?

        lda #<>aUnitMenuItemSlots
        sta wR1
        lda wR0
        jsl rlUnknown84F765
        bcc _F876
        jml rsUnknown84F877._F889


        _F876
        rts

        .databank 0

        ; 84/F877

      rsUnknown84F877 ; 84/F877

        .al
        .xl
        .autsiz
        .databank ?

        lda #<>aUnitMenuEquipSlots
        sta wR1
        lda wR0
        jsl rlCheckWeaponInInventorySlotEquippable
        bcc _F888
        jml _F889


        _F888
        rts


        _F889
        phb
        php
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb
        .databank $7E
        ldx wR1
        lda wR0
        jsl rlCheckIfWeaponEquipped
        bcs _F8B0
        lda $0000,b,x
        and #$00FF

        _F8A3
        clc
        adc wR1
        tay
        sep #$20
        lda wR0
        sta $0001,b,y
        bra _F8D1


        _F8B0
        .al
        lda $0000,b,x
        and #$00FF
        beq _F8A3
        phx
        tax
        clc
        adc wR1
        dec a
        tay
        sep #$20

        _F8C1
        lda $0001,b,y
        sta $0002,b,y
        dec y
        dec x
        bne _F8C1
        plx
        lda wR0
        sta $0002,b,y

        _F8D1
        inc $0000,b,x
        rep #$20
        plp
        plb
        .databank ?
        rts

        .databank 0

        ; 84/F8D9

    .endsection Unsorted84F75CSection


    .section Unsorted84F8D9Section

      .al
      .xl

      rlUnknown84F8D9 ; 84/F8D9

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $84
        phx
        phy
        lda wR0
        pha
        lda wR1
        pha
        lda wEventLocationEntry,b
        beq _F92E
        jsl rlGetEventLocationEntryEffectiveXCoordinate
        sta wR10
        jsl rlGetEventLocationEntryEffectiveYCoordinate
        dec a
        sta wR11
        lda #(`aRangeMap)<<8
        sta lRoutineVariable+1,b
        lda #<>aRangeMap
        sta lRoutineVariable,b
        jsl rlUnknown8483F3
        lda #$0000
        sta aUnitMenuStaffSlots
        sta aUnitMenuItemSlots
        sta aUnitMenuCastleStaffSlots
        lda #$0001
        sta wR0

        _F91B
        jsr rsUnknown84F815
        jsr rsUnknown84F82D
        inc wR0
        lda wR0
        cmp #$0008
        bcs _F92E
        jml _F91B


        _F92E
        pla
        sta wR1
        pla
        sta wR0
        ply
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 84/F939

    .endsection Unsorted84F8D9Section


    .section Unsorted84FE98Section

      .al
      .xl

      rlUnknown84FE98 ; 84/FE98

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlGetFirstEquippableWeaponInInventory
        jsl rlGetSelectedUnitBattleHit
        rtl

        .databank 0

        ; 84/FEA1

      rlUnknown84FEA1 ; 84/FEA1

        .al
        .xl
        .autsiz
        .databank ?

        pha
        jsl rlGetFirstEquippableWeaponInInventory
        pla
        jsl rlGetSelectedUnitBattleAvoid
        rtl

        .databank 0

        ; 84/FEAC

    .endsection Unsorted84FE98Section


    .section Unsorted84FEACSection

      .al
      .xl

      rlUnknown84FEAC ; 84/FEAC

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlGetFirstEquippableWeaponInInventory
        jsl rlGetSelectedUnitBattleCrit
        rtl

        .databank 0

        ; 84/FEB5

      rlUnknown84FEB5 ; 84/FEB5

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlGetFirstEquippableWeaponInInventory
        jsl rlGetSelectedUnitBattleAttackSpeed
        rtl

        .databank 0

        ; 84/FEBE

    .endsection Unsorted84FEACSection


    .section Unsorted84FEBESection

      .al
      .xl

      rlUnknown84FEBE ; 84/FEBE

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $84
        jsl rlGetFirstEquippableWeaponInInventory
        lda wCurrentItemDataROMPointer,b
        beq _FECF
        jsl rlGetItemWeight

        _FECF
        plp
        plb
        .databank $84
        rtl

        .databank 0

        ; 84/FED2

    .endsection Unsorted84FEBESection


    .section Unsorted84FED2Section

      .al
      .xl

      rlUnknown84FED2 ; 84/FED2

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $84
        pha
        cmp #$0004
        beq _FEEA
        jsl rlGetItemMinimumRange
        sta wR10
        jsl rlGetItemMaximumRange
        sta wR11
        bra _FEFD


        _FEEA
        jsl rlGetItemMinimumRange
        ora #$0000
        beq _FF05
        cmp #$0002
        bcs _FF05
        inc a
        sta wR10
        sta wR11

        _FEFD
        pla
        jsl rlFindTargetsInRange

        _FF02
        plp
        plb
        .databank ?
        rtl


        _FF05
        pla
        lda #$0000
        bra _FF02

        .databank 0

        ; 84/FF0B

    .endsection Unsorted84FED2Section
