; Code from bank $86 not yet assigned to a game system.

    .section Unsorted869CCCSection

      .al
      .xl

      rlUnknown869CCC ; 86/9CCC

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $86
        phx
        ldx #$002A
        sep #$20
        lda #$00

        _9CD8
        sta bUnknown000E7B,b,x
        dec x
        bpl _9CD8
        rep #$20
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 86/9CE4

    .endsection Unsorted869CCCSection


    .section Unsorted869CE4Section

      .al
      .xl

      rlUnknown869CE4 ; 86/9CE4

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb

        lda wActiveFactionSlot,b
        beq +

          lda #$0040
          tsb bUnknown000E7B,b
          stz wAIEngineCycleType,b

        +
        plp
        plb
        rtl

        .databank 0

      rlUnknown869CF9 ; 86/9CF9

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        lda bUnknown000E7B,b
        bit #$0001
        beq +

          lda #$0001
          trb bUnknown000E7B,b

        +
        plp
        plb
        rtl

        .databank 0

      rlUnknown869D0E ; 86/9D0E

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb

        lda #$0040
        trb bUnknown000E7B,b

        plp
        plb
        rtl

        .databank 0

        ; 86/9D1B

    .endsection Unsorted869CE4Section


    .section Unsorted86AD5ESection

      .al
      .xl

      rlUnknown86AD5E ; 86/AD5E

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $86
        phx
        phy
        lda wAITemp000E9C,b
        xba
        lsr a
        lsr a
        clc
        adc wAITemp000E9A,b
        tay
        sty wR36
        sep #$20
        lda #$7F
        pha
        rep #$20
        plb
        .databank $7F
        sep #$20

        _AD7B
        lda aMovementMap,y
        beq _AD84
        jml _AE1C


        _AD84
        lda aTargetDistanceMap,y
        sta wR34
        lda #$FE
        sta aTargetDistanceMap,y
        ldx #$0008
        lda wR36
        lsr a
        bcs _ADCE
        lda $850A,b,y
        beq _ADA4
        cmp wR34
        bcs _ADA4
        sta wR34
        ldx #$0000

        _ADA4
        lda $854B,b,y
        beq _ADB2
        cmp wR34
        bcs _ADB2
        sta wR34
        ldx #$0002

        _ADB2
        lda $858A,b,y
        beq _ADC0
        cmp wR34
        bcs _ADC0
        sta wR34
        ldx #$0004

        _ADC0
        lda $8549,b,y
        beq _ADCC
        cmp wR34
        bcs _ADCC
        ldx #$0006

        _ADCC
        bra _AE06


        _ADCE
        lda $8549,b,y
        beq _ADDC
        cmp wR34
        bcs _ADDC
        sta wR34
        ldx #$0006

        _ADDC
        lda $858A,b,y
        beq _ADEA
        cmp wR34
        bcs _ADEA
        sta wR34
        ldx #$0004

        _ADEA
        lda $854B,b,y
        beq _ADF8
        cmp wR34
        bcs _ADF8
        sta wR34
        ldx #$0002

        _ADF8
        lda $850A,b,y
        beq _AE06
        cmp wR34
        bcs _AE06
        sta wR34
        ldx #$0000

        _AE06
        cpx #$0008
        beq _AE1C
        rep #$20
        tya
        clc
        adc aUnknown86AE36,x
        tay
        sep #$20
        inc wR36
        jml _AD7B


        _AE1C
        rep #$20
        tya
        and #$003F
        sta @l wAITemp000E96
        tya
        lsr a
        lsr a
        lsr a
        lsr a
        lsr a
        lsr a
        sta @l wAITemp000E98
        ply
        plx
        plp
        plb
        .databank $7F
        rtl

        .databank 0

        ; 86/AE36

    .endsection Unsorted86AD5ESection


    .section Table86AE36Section

      .al
      .xl

      aUnknown86AE36 ; 86/AE36

        ; Read by rlUnknown86AD5E.

        .word $FFC0, $0001, $0040, $FFFF

        ; 86/AE3E

    .endsection Table86AE36Section


    .section Unsorted86B335Section

      .al
      .xl

      rsUnknown86B335 ; 86/B335

        .al
        .xl
        .autsiz
        .databank ?

        ldx $0871,b
        jsl rlUnknown84CAA9
        lda #$0001
        trb bUnknown000E7B,b
        rts

        .databank 0

        ; 86/B343

      rsUnknown86B343 ; 86/B343

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta $057C,b
        lda $0871,b
        sta wR0
        lda $0873,b
        sta wR1
        jsl rlUnknown84DC1C
        rts

        .databank 0

        ; 86/B358

      rlUnknown86B358 ; 86/B358

        .al
        .xl
        .autsiz
        .databank ?

        ldx $0871,b
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlUnknown84B474
        jml rsUnknown86B343

        .databank 0

        ; 86/B36A

    .endsection Unsorted86B335Section


    .section Unsorted86B36ASection

      .al
      .xl

      rsUnknown86B36A ; 86/B36A

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0001
        trb bUnknown000E7B,b
        rts

        .databank 0

        ; 86/B371

    .endsection Unsorted86B36ASection


    .section Unsorted86B371Section

      .al
      .xl

      rsUnknown86B371 ; 86/B371

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ldx $0871,b
        jsl rlUnknown84CAA9
        lda $0580,b
        beq _B388
        sta wEventLocationEntry,b
        jsl rlGetEventLocationEntryID
        jsl rlUnknown84CD8A

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

      rsUnknown86B38F ; 86/B38F

        .al
        .xl
        .autsiz
        .databank ?

        ldx $0871,b
        jsl rlUnknown84CF0F
        lda #$0001
        trb bUnknown000E7B,b
        rts

        .databank 0

        ; 86/B39D

    .endsection Unsorted86B38FSection


    .section Unsorted86B39DSection

      .al
      .xl

      rsUnknown86B39D ; 86/B39D

        .al
        .autsiz
        .databank ?

        ldx $0871,b
        jsl rlUnknown84CE21
        lda #1
        trb bUnknown000E7B,b
        rts

        .databank 0

        ; 86/B3AB

    .endsection Unsorted86B39DSection


    .section Unsorted86B3ABSection

      .al
      .xl

      rsUnknown86B3AB ; 86/B3AB

        .al
        .xl
        .autsiz
        .databank ?

        ldx $0871,b
        jsl rlUnknown84D03E
        lda #$0001
        trb bUnknown000E7B,b
        rts

        .databank 0

        ; 86/B3B9

      rsUnknown86B3B9 ; 86/B3B9

        .al
        .xl
        .autsiz
        .databank ?

        ldx wActiveUnitDeploymentOffset,b
        jsl rlUnknown84D0B9
        lda #$0001
        trb bUnknown000E7B,b
        rts

        .databank 0

        ; 86/B3C7

      rsUnknown86B3C7 ; 86/B3C7

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0001
        trb bUnknown000E7B,b
        rts

        .databank 0

        ; 86/B3CE

      rsUnknown86B3CE ; 86/B3CE

        .al
        .xl
        .autsiz
        .databank ?

        lda lAITemp000E90+1,b
        sta lR18+1
        lda lAITemp000E90,b
        sta lR18
        jsl rlUnknown84B613
        rts

        .databank 0

        ; 86/B3DD

    .endsection Unsorted86B3ABSection


    .section Unsorted86B3DDSection

      .al
      .xl

      rsUnknown86B3DD ; 86/B3DD

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0001
        trb bUnknown000E7B,b
        lda #$000A
        sta bEventActionIdentifier,b
        ldx $0873,b
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

      rsUnknown86B410 ; 86/B410

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda wAICurrentAISetting,b
        sta wRoutineVariable1,b
        lda wAIActiveFaction,b
        jsl rlReviveFactionsUnitsOfAISetting
        jsr rsUnknown86B371
        rts

        .databank 0

        ; 86/B421

    .endsection Unsorted86B3DDSection


    .section Unsorted86BA3BSection

      .al
      .xl

      rsUnknown86BA3B ; 86/BA3B

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $86
        lda #$FFFF
        sta wAITemp000EA0,b
        ldx wAISelectedAIUnitOffset,b
        lda $7E2026,x
        and #$00FF
        jsl rlUnknown86C293
        ora #$0000
        beq _BA80
        lda $7E2024,x
        sta wSelectedUnitDataRAMPointer,b
        lda $7E202D,x
        and #$00FF
        sta wAITemp000E96,b
        lda $7E202E,x
        and #$00FF
        sta wAITemp000E98,b
        jsl rlFillMovementCostMap
        jsl rlGetNearestPossibleTarget
        bcc _BA80
        sta wAITemp000EA0,b

        _BA80
        lda wAITemp000EA0,b
        plp
        plb
        .databank $86
        rts

        .databank 0

        ; 86/BA86

    .endsection Unsorted86BA3BSection


    .section Unsorted86BC64Section

      .al
      .xl

      rsUnknown86BC64 ; 86/BC64

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda $443C,b
        xba
        lsr a
        lsr a
        clc
        adc $443A,b
        tay
        asl a
        tax
        lda aMapData,x
        and #$03FF
        tax
        lda aTerrainTileset,x
        and #$00FF
        cmp #$000C
        beq _BCAB
        lda $554A,b,y
        and #$00FF
        cmp #$00FF
        bne _BCAB
        lda $454A,b,y
        and #$00FF
        cmp #$00FF
        beq _BCA2
        cmp $444A,b
        bne _BCAB

        _BCA2
        lda $754A,b,y
        ply
        plx
        and #$00FF
        rts


        _BCAB
        ply
        plx
        lda #$0000
        rts

        .databank 0

        ; 86/BCB1

      rsUnknown86BCB1 ; 86/BCB1

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlGetSelectedUnitStates
        bit #UnitStateGroupLeader
        bne _BCC5
        lda wAIUnknown7E201C
        cmp #$000C
        bne _BCC5
        sec
        rts


        _BCC5
        clc
        rts

        .databank 0

        ; 86/BCC7

      rsUnknown86BCC7 ; 86/BCC7

        .al
        .xl
        .autsiz
        .databank ?

        lda wAIUnknown7E201C
        cmp #$0001
        bne _BCE1
        jsl rlGetFirstEquippableWeaponInInventory
        ora #$0000
        beq _BCDF
        jsl rlCheckWeaponEquippable
        bcs _BCE1

        _BCDF
        sec
        rts


        _BCE1
        clc
        rts

        .databank 0

        ; 86/BCE3

    .endsection Unsorted86BC64Section


    .section Unsorted86BFE6Section

      .al
      .xl

      rlUnknown86BFE6 ; 86/BFE6

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $86
        phx
        lda wSelectedUnitDataRAMPointer,b
        pha
        ldx wAITemp000E96,b
        lda aDeploymentTable._UnitRAMPointer,x
        sta wAITemp000E96,b
        ldx wAITemp000E98,b
        lda aDeploymentTable._UnitRAMPointer,x
        sta wAITemp000E98,b
        lda wAITemp000E96,b
        sta wSelectedUnitDataRAMPointer,b
        lda wAITemp000E9E,b
        beq _C014
        jsl rlGetItemROMDataByInventorySlot
        bra _C018


        _C014
        jsl rlGetFirstEquippableWeaponInInventory

        _C018
        lda wCurrentItemDataROMPointer,b
        bne _C021
        jml _C0A2


        _C021
        jsl rlGetItemMinimumRange
        dec a
        cmp wAITemp000E9C,b
        bcc _C02F
        jml _C0AA


        _C02F
        jsl rlGetItemMaximumRange
        cmp wAITemp000E9C,b
        bcs _C03C
        jml _C0AA


        _C03C
        lda wAITemp000E98,b
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetItemWeaponType
        cmp #$0004
        bcs _C051
        jsl rlGetSelectedUnitTotalDefense
        bra _C055


        _C051
        jsl rlGetSelectedUnitTotalResistance

        _C055
        sta $7FEC4A
        lda wAITemp000E96,b
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetFirstWeaponBattleMight
        sec
        sbc $7FEC4A
        cmp #$0001
        bpl _C071
        jml _C0AA


        _C071
        and #$00FF
        sta aUnit2DataBuffer._Lover.LoveValue
        jsl rlUnknown84FE98
        sta $7FEC4C
        lda wAITemp000E98,b
        sta wSelectedUnitDataRAMPointer,b
        lda wAITemp000E9A,b
        jsl rlUnknown84FEA1
        sta $7FEC4E
        lda $7FEC4C
        sec
        sbc $7FEC4E
        bmi _C0AA
        beq _C0AA
        lda aUnit2DataBuffer._Lover.LoveValue

        _C0A2
        plx
        stx wSelectedUnitDataRAMPointer,b
        plx
        plp
        plb
        .databank ?
        rtl


        _C0AA
        lda #$0000
        bra _C0A2

        .databank 0

        ; 86/C0AF

    .endsection Unsorted86BFE6Section


    .section Unsorted86C293Section

      .al
      .xl

      rlUnknown86C293 ; 86/C293

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $86
        phx
        phy
        sta aAIAction.wUnitFaction
        sep #$20
        lda #$7F
        pha
        rep #$20
        plb
        .databank $7F
        ldx #$01FE
        lda #$FFFF

        _C2AB
        sta aTargetMap,x
        sta $974A,b,x
        sta $994A,b,x
        sta $9B4A,b,x
        sta $9D4A,b,x
        sta $9F4A,b,x
        sta $A14A,b,x
        sta $A34A,b,x
        dec x
        dec x
        bpl _C2AB
        stz $4430,b
        ldy #$0000

        _C2CD
        tya
        jsl rlGetLocationEventDataEntry
        bcs _C32B
        jsl rlGetEventLocationEntryType
        cmp #LocationTypeVillage
        bne _C328
        jsl rlCheckIfVillageClosed
        bcs _C328
        jsl rlCheckLocationDestroyed
        bcs _C328
        jsl rlGetEventLocationEntryEffectiveXCoordinate
        sta $442A,b
        jsl rlGetEventLocationEntryEffectiveYCoordinate
        sta $442C,b
        lda $442C,b
        xba
        lsr a
        lsr a
        clc
        adc $442A,b
        tax
        lda $454A,b,x
        and #$00FF
        cmp $442E,b
        beq _C31D
        cmp #$00FF
        bne _C328
        lda aUnfriendlyUnitMap,x
        and #$00FF
        cmp #$00FF
        bne _C328

        _C31D
        tya
        sep #$20
        sta aTargetMap,x
        rep #$20
        inc $4430,b

        _C328
        inc y
        bra _C2CD


        _C32B
        lda $4430,b
        ply
        plx
        plp
        plb
        .databank $7F
        rtl

        .databank 0

        ; 86/C333

    .endsection Unsorted86C293Section


    .section Unsorted86C333Section

      .al
      .xl

      rlUnknown86C333 ; 86/C333

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

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
        lda @l aUnknown86C359,x
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

      aUnknown86C359 ; 86/C359

        ; Read by rlUnknown86C333.

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

      rlUnknown86C3A0 ; 86/C3A0

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

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
        lda @l aUnknown86C3C6,x
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

      aUnknown86C3C6 ; 86/C3C6

        ; Read by rlUnknown86C3A0.

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

      rlUnknown86C40D ; 86/C40D

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

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

      rlUnknown86C46E ; 86/C46E

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

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
