; Code from bank $86 not yet assigned to a game system.

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
        adc $86AE36,x
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
        trb $0E7B,b
        rts

        .databank 0

        ; 86/B3AB

    .endsection Unsorted86B39DSection


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
        bit #$0100
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
        lda $7E46EB,x
        sta wAITemp000E96,b
        ldx wAITemp000E98,b
        lda $7E46EB,x
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
        sta $7FEC48
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
        lda $7FEC48

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
        sta $7F442E
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
        cmp #$0002
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
        lda aFoeUnitMap,x
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


