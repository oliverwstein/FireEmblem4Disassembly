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
        lda wChapterFlags,b
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
        jsl rlStartBattleScene

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
        jsl rlStartBattleScene
        bra +

        _Off
        jsl rlStartMapBattle

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

    .endsection Unsorted84EB24Section


