; Code from bank $87 not yet assigned to a game system.

    .section Unsorted878017Section

      .al
      .xl

      rlUnknown878017 ; 87/8017

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0000

        _801A
        lda rlUnknown8887EC._8880+8,x
        sta @l aSpriteExtBuffer,x
        inc x
        inc x
        cpx #$0080
        bne _801A

        _8029
        rtl

        .databank 0

        ; 87/802A

      rlUnknown87802A ; 87/802A

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0000

        _802D
        lda rlUnknown8887EC._8880+8,x
        cmp @l aSpriteExtBuffer,x
        bne rlUnknown878017._8029
        inc x
        inc x
        cpx #$0080
        bne _802D

        _803E
        jsl rlUnknown878017
        lda #$0000
        sta @l $001FFC
        sta @l $001FFE
        jsl rlUnknown91ECDF
        cmp #$6A19
        beq _8063
        lda #$6A19
        jsl rlUnknown91ECDA
        jsl rlUnknown91E8CC

        _8061
        bra _8061


        _8063
        lda #$0000
        sta @l $001FFC
        sta @l $001FFE
        jsl rlUnknown91E8C1

        _8072
        bra _8072

        .databank 0

        ; 87/8074

      rlUnknown878074 ; 87/8074

        ; Runs on into built code at the end.
        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        phx
        jsl rlUnknown87802A
        lda @l aCodeChecksumsCopy87.ChecksEnabled
        beq _809B
        lda #$0000
        ldx #<>rlReset

        _8089
        clc
        adc $800000,x
        inc x
        inc x
        cpx #<>rlColdResetClearMemory
        bcc _8089
        cmp @l aCodeChecksumsCopy87.Bank80Sum
        bne _80A6

        _809B
        lda #$0000
        jsl rlUnknown91ECDA
        plx
        plp
        plb
        .databank ?
        rtl


        _80A6
        jsl rlUnknown87802A._8063

        .databank 0

        ; 87/80AA

    .endsection Unsorted878017Section


    .section Unsorted8780AASection

      .al
      .xl

      rlUnknown8780AA ; 87/80AA

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        ldx #$0029
        sep #$20
        lda #0

          -
          sta $0516,b,x
          dec x
          bpl -

        rep #$20

        lda bBufferBG3SC
        and #BGSC_Address
        xba
        sta $0516,b
        lda #(`aBG3TilemapBuffer)<<8
        sta $0519,b
        lda #<>aBG3TilemapBuffer
        sta $0518,b
        lda #0
        sta wUnknown053E,b
        jsl rlUnknown87828D
        plp
        plb
        rtl

        .databank 0

    .endsection Unsorted8780AASection


    .section Unsorted8780DFSection

      .al
      .xl

      rlUnknown8780DF ; 87/80DF

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        lda #$0080
        tsb bUnknown000521,b
        plp
        plb
        rtl

        .databank 0

      rlUnknown8780EC ; 87/80EC

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        lda #$0080
        trb bUnknown000521,b
        plp
        plb
        rtl

        .databank 0

        ; 87/80F9

    .endsection Unsorted8780DFSection


    .section Unsorted878148Section

      .al
      .xl

      rlUnknown878148 ; 87/8148

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        phy
        ldy lMapMenuRAMEntryPointer,b
        sep #$20
        lda lMapMenuRAMEntryPointer+2,b
        pha
        rep #$20
        plb
        .databank ?
        lda structMapMenu.Unknown3,b,y
        sta lR20
        lda structMapMenu.Unknown3+1,b,y
        sta lR20+1
        jsl rlUnknown878852
        bcs _817F
        ldy lR19
        sep #$20
        lda lR19+2
        pha
        rep #$20
        plb
        .databank ?
        lda lR20
        sta $000C,b,y
        lda lR20+1
        sta $000D,b,y
        bra _818B


        _817F
        lda lR20
        sta @l lUnknown000522
        lda lR20+1
        sta @l lUnknown000522+1

        _818B
        lda @l bUnknown000521
        ora #$0008
        sta @l bUnknown000521
        ply
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 87/819A

    .endsection Unsorted878148Section


    .section Unsorted878256Section

      .al
      .xl

      rlUnknown878256 ; 87/8256

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        lda bUnknown000521,b
        and #$00FF
        bit #$0080
        beq _827A
        bit #$0020
        bne _827A
        pha
        sep #$20
        and #$E1
        sta bUnknown000521,b
        rep #$20
        pla
        bit #$001E
        bne _8283

        _827A
        plp
        plb
        .databank ?
        rtl

        .byte $22, $F8, $83, $87, $80, $00


        _8283
        jsr rsUnknown87840F
        jsl rlUnknown87828D
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 87/828D

      rlUnknown87828D ; 87/828D

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0020
        sta wUnknown00052A,b
        lda #$0000
        sta wUnknown00052C,b
        rtl

        .databank 0

        ; 87/829A

    .endsection Unsorted878256Section


    .section Unsorted87829ASection

      .al
      .xl

      rlUnknown87829A ; 87/829A

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb

        ; Get the height into wR13
        jsl rlGetMapMenuTilemapArea
        xba
        and #$00FF
        sta wR13

        jsl rlGetMapMenuPosition
        xba
        and #$00FF
        cmp #33
        bge +

          cmp wUnknown00052A,b
          bge +

            sta wUnknown00052A,b

        +
        sta wR12
        clc
        adc wR13
        cmp #33
        bge +

          cmp wUnknown00052C,b
          blt +

            sta wUnknown00052C,b

        +
        sta wR13
        plp
        plb
        rtl

        .databank 0

        ; 87/82D4

    .endsection Unsorted87829ASection


    .section Unsorted8782D4Section

      .al
      .xl

      rlUnknown8782D4 ; 87/82D4

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        phy
        lda #$0020
        sta wUnknown00052A,b
        lda #$0000
        sta wUnknown00052C,b
        lda lUnknown000522,b
        sta lMapMenuRAMEntryPointer,b
        lda lUnknown000522+1,b
        sta lMapMenuRAMEntryPointer+1,b

        _82F1
        phk
        plb
        .databank $87
        jsl rlGetMapMenuYPositions
        lda @l wR10
        cmp wUnknown00052A,b
        bcs _8303
        sta wUnknown00052A,b

        _8303
        lda @l wR11
        cmp wUnknown00052C,b
        bcc _830F
        sta wUnknown00052C,b

        _830F
        ldy lMapMenuRAMEntryPointer,b
        sep #$20
        lda lMapMenuRAMEntryPointer+2,b
        pha
        rep #$20
        plb
        .databank ?
        lda structMapMenu.Unknown3,b,y
        ora structMapMenu.Unknown3+1,b,y
        beq _8333
        lda structMapMenu.Unknown3,b,y
        sta @l lMapMenuRAMEntryPointer
        lda structMapMenu.Unknown3+1,b,y
        sta @l lMapMenuRAMEntryPointer+1
        bra _82F1


        _8333
        ply
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 87/8337

    .endsection Unsorted8782D4Section


    .section Unsorted878337Section

      .al
      .xl

      rlUnknown878337 ; 87/8337

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        phx
        phy
        lda wR13
        sec
        sbc wR12
        bcc _8395
        asl a
        tay
        lda wR12
        xba
        lsr a
        lsr a
        clc
        adc $0518,b
        tax
        sep #$20
        lda $051A,b
        pha
        rep #$20
        plb
        .databank ?

        _8359
        lda wUnknown053E,b
        sta $0000,b,x
        sta $0002,b,x
        sta $0004,b,x
        sta $0006,b,x
        sta $0008,b,x
        sta $000A,b,x
        sta $000C,b,x
        sta $000E,b,x
        sta $0010,b,x
        sta $0012,b,x
        sta $0014,b,x
        sta $0016,b,x
        sta $0018,b,x
        sta $001A,b,x
        sta $001C,b,x
        sta $001E,b,x
        txa
        clc
        adc #$0020
        tax
        dec y
        bne _8359

        _8395
        ply
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 87/839A

      rlUnknown87839A ; 87/839A

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        phx
        phy
        lda lUnknown000522,b
        ora lUnknown000522+1,b
        beq _83F3
        lda wR12
        cmp #$0020
        bcs _83F3
        lda wR13
        cmp #$0020
        bcs _83F3
        jsl rlUnknown878337
        lda lMapMenuRAMEntryPointer,b
        pha
        lda lMapMenuRAMEntryPointer+1,b
        pha
        phb
        lda lUnknown000522,b
        sta lMapMenuRAMEntryPointer,b
        lda lUnknown000522+1,b
        sta lMapMenuRAMEntryPointer+1,b

        _83CF
        jsr rsUnknown87862D
        lda $000C,b,y
        ora $000D,b,y
        beq _83EA
        lda $000C,b,y
        sta @l lMapMenuRAMEntryPointer
        lda $000D,b,y
        sta @l lMapMenuRAMEntryPointer+1
        bra _83CF


        _83EA
        plb
        .databank ?
        pla
        sta lMapMenuRAMEntryPointer+1,b
        pla
        sta lMapMenuRAMEntryPointer,b

        _83F3
        ply
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 87/83F8

    .endsection Unsorted878337Section


    .section Unsorted8783F8Section

      .al
      .xl

      rlUnknown8783F8 ; 87/83F8

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        lda lUnknown000522,b
        ora lUnknown000522+1,b
        beq _840C
        jsl rlUnknown8782D4
        jsl rlUnknown87839A

        _840C
        plp
        plb
        .databank $87
        rtl

        .databank 0

        ; 87/840F

    .endsection Unsorted8783F8Section


    .section Unsorted87840FSection

      .al
      .xl

      rsUnknown87840F ; 87/840F

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        lda wUnknown00052A,b
        cmp wUnknown00052C,b
        bcs _8456
        lda wUnknown00052A,b
        cmp #$0020
        bcs _8456
        lda wUnknown00052C,b
        cmp #$0020
        bcs _8456
        lda $0519,b
        sta lR18+1
        lda wUnknown00052A,b
        xba
        lsr a
        lsr a
        pha
        clc
        adc $0518,b
        sta lR18
        lda wUnknown00052C,b
        sec
        sbc wUnknown00052A,b
        inc a
        xba
        lsr a
        lsr a
        sta wR0
        pla
        lsr a
        clc
        adc $0516,b
        sta wR1
        jsl rlDMAByPointer

        _8456
        plp
        plb
        .databank ?
        rts

        .databank 0

        ; 87/8459

    .endsection Unsorted87840FSection


    .section Unsorted878459Section

      .al
      .xl

      rlUnknown878459 ; 87/8459

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        lda #0
        sta wUnknown00052A,b
        lda #$001F
        sta wUnknown00052C,b
        lda #$0002
        tsb bUnknown000521,b
        plp
        plb
        rtl

        .databank 0

        ; 87/8472

    .endsection Unsorted878459Section


    .section Unsorted878472Section

      .al
      .xl

      rlUnknown878472 ; 87/8472

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        phy
        jsl rlUnknown87829A
        ldy lMapMenuRAMEntryPointer,b
        sep #$20
        lda lMapMenuRAMEntryPointer+2,b
        pha
        rep #$20
        plb
        .databank ?
        lda @l $000534
        sta $000A,b,y
        phk
        plb
        .databank $87
        jsl rlUnknown87839A
        jsl rlGetMapMenuYPositions
        lda wR10
        cmp wR12
        bcc _84A4
        lda wR13
        cmp wR11
        bcs _84A8

        _84A4
        jsl rlUnknown8785E3

        _84A8
        lda @l bUnknown000521
        ora #$0004
        sta @l bUnknown000521
        ply
        plp
        plb
        .databank $87
        rtl

        .databank 0

        ; 87/84B7

      rlUnknown8784B7 ; 87/84B7

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        jsl rlGetMapMenuPosition
        ora #$8000
        sta $0534,b
        jsl rlUnknown878472
        plp
        plb
        .databank $87
        rtl

        .databank 0

        ; 87/84CC

    .endsection Unsorted878472Section


    .section Unsorted8784E1Section

      .al
      .xl

      rlUnknown8784E1 ; 87/84E1

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        phy
        pha
        jsl rlUnknown87829A
        pla
        jsl rlSetMapMenuTilemapArea
        jsl rlUnknown87839A
        jsl rlGetMapMenuYPositions
        lda wR10
        cmp wR12
        bcc _8504
        lda wR13
        cmp wR11
        bcs _8508

        _8504
        jsl rlUnknown8785E3

        _8508
        lda @l bUnknown000521
        ora #$0004
        sta @l bUnknown000521
        ply
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 87/8517

    .endsection Unsorted8784E1Section


    .section Unsorted878531Section

      .al
      .xl

      rlUnknown878531 ; 87/8531

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        phx
        phy
        lda #$0027
        jsl rlUnknown87819A
        ldx lR19
        cpx lMapMenuRAMEntryPointer,b
        beq _859F
        ldy lMapMenuRAMEntryPointer,b
        sep #$20
        lda lMapMenuRAMEntryPointer+2,b
        pha
        rep #$20
        plb
        .databank ?
        lda @l lMapMenuRAMEntryPointer
        sta $000C,b,x
        lda @l lMapMenuRAMEntryPointer+1
        sta $000D,b,x
        jsl rlUnknown878852
        bcs _8575
        ldx lR19
        lda $000C,b,y
        sta $000C,b,x
        lda $000D,b,y
        sta $000D,b,x
        bra _8583


        _8575
        lda $000C,b,y
        sta @l lUnknown000522
        lda $000D,b,y
        sta @l lUnknown000522+1

        _8583
        lda #$0000
        sta $000C,b,y
        sta $000D,b,y
        jsl rlUnknown87829A
        jsl rlUnknown87839A
        lda @l bUnknown000521
        ora #$0008
        sta @l bUnknown000521

        _859F
        ply
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 87/85A4

    .endsection Unsorted878531Section


    .section Unsorted8785A4Section

      .al
      .xl

      rlRemoveMapMenu ; 87/85A4

        .al
        .xl
        .autsiz
        .databank ?

        ; Frees the current map menu's tilemap entry and its RAM area entry, after
        ; rlUnknown8784B7 and rlUnknown878148.

        phb
        php
        phk
        plb
        .databank $87
        phy
        jsl rlUnknown8784B7
        jsl rlUnknown878148
        ldy lMapMenuRAMEntryPointer,b
        sep #$20
        lda lMapMenuRAMEntryPointer+2,b
        pha
        rep #$20
        plb
        .databank ?
        lda structMapMenu.TilemapDataPointer,b,y
        sta @l lMapMenuTilemapRAMEntryPointer
        lda structMapMenu.TilemapDataPointer+1,b,y
        sta @l lMapMenuTilemapRAMEntryPointer+1
        jsl rlRemoveMapMenuTilemapRAMEntry
        phk
        plb
        .databank $87
        lda lMapMenuRAMEntryPointer,b
        sta lR25
        lda lMapMenuRAMEntryPointer+1,b
        sta lR25+1
        jsl rlRemoveRAMAreaEntry
        ply
        plp
        plb
        .databank $87
        rtl

        .databank 0

        ; 87/85E3

      rlUnknown8785E3 ; 87/85E3

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        phx
        phy
        jsl rlUnknown87829A
        jsr rsUnknown87862D
        lda @l bUnknown000521
        bit #$0040
        beq _8628
        lda lMapMenuRAMEntryPointer,b
        pha
        lda lMapMenuRAMEntryPointer+1,b
        pha
        phb
        bra _8607


        _8604
        jsr rsUnknown87862D

        _8607
        lda $000C,b,y
        ora $000D,b,y
        beq _861F
        lda $000C,b,y
        sta @l lMapMenuRAMEntryPointer
        lda $000D,b,y
        sta @l lMapMenuRAMEntryPointer+1
        bra _8604


        _861F
        plb
        .databank ?
        pla
        sta lMapMenuRAMEntryPointer+1,b
        pla
        sta lMapMenuRAMEntryPointer,b

        _8628
        ply
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 87/862D

      rsUnknown87862D ; 87/862D

        .al
        .xl
        .autsiz
        .databank ?

        phk
        plb
        .databank $87
        ldy lMapMenuRAMEntryPointer,b
        sep #$20
        lda lMapMenuRAMEntryPointer+2,b
        pha
        rep #$20
        plb
        .databank ?
        lda $000A,b,y
        bmi _8696
        jsl rlGetMapMenuYPositions
        lda wR10
        cmp wR13
        beq _864C
        bcs _8696

        _864C
        lda wR11
        cmp wR12
        bcc _8696
        lda $0007,b,y
        sta @l lMapMenuTilemapRAMEntryPointer+1
        lda $0006,b,y
        sta @l lMapMenuTilemapRAMEntryPointer
        jsr rsUnknown878697
        bcs _8696
        lda $000A,b,y
        and #$00FF
        cmp #$0020
        bcs _8696
        sta wR0
        lda $000B,b,y
        and #$00FF
        cmp #$0020
        bcs _8696
        asl a
        asl a
        asl a
        asl a
        asl a
        clc
        adc wR0
        asl a
        tax
        jsl rlUnknown878AB5
        lda @l bUnknown000521
        ora #$0010
        sta @l bUnknown000521

        _8696
        rts

        .databank 0

        ; 87/8697

      rsUnknown878697 ; 87/8697

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        phy
        ldy lMapMenuTilemapRAMEntryPointer,b
        sep #$20
        lda lMapMenuTilemapRAMEntryPointer+2,b
        pha
        rep #$20
        plb
        .databank ?
        lda structMapMenuTilemapData.TilesPointer+1,b,y
        ora structMapMenuTilemapData.TilesPointer,b,y
        beq _86B5
        ply
        plp
        plb
        .databank ?
        clc
        rts


        _86B5
        ply
        plp
        plb
        .databank ?
        sec
        rts

        .databank 0

        ; 87/86BA

    .endsection Unsorted8785A4Section


    .section Unsorted87872BSection

      .al
      .xl

      rlUnknown87872B ; 87/872B

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        phy
        pha
        ldy lMapMenuRAMEntryPointer,b
        sep #$20
        lda lMapMenuRAMEntryPointer+2,b
        pha
        rep #$20
        plb
        .databank ?
        pla
        sep #$20
        sta structMapMenu.Type,b,y
        rep #$20
        ply
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 87/8749

    .endsection Unsorted87872BSection


    .section Unsorted878852Section

      .al
      .xl

      rlUnknown878852 ; 87/8852

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        phy
        lda lUnknown000522,b
        ora lUnknown000522+1,b
        beq _88A9
        lda lUnknown000522,b
        sta lR19
        lda lUnknown000522+1,b
        sta lR19+1
        lda lUnknown000522,b
        cmp lMapMenuRAMEntryPointer,b
        bne _8879
        lda lUnknown000522+1,b
        cmp lMapMenuRAMEntryPointer+1,b
        beq _88A9

        _8879
        ldy lR19
        sep #$20
        lda lR19+2
        pha
        rep #$20
        plb
        .databank ?
        lda $000C,b,y
        ora $000D,b,y
        beq _88A9
        lda $000C,b,y
        cmp @l lMapMenuRAMEntryPointer
        bne _889D
        lda $000D,b,y
        cmp @l lMapMenuRAMEntryPointer+1
        beq _88AE

        _889D
        lda $000C,b,y
        sta lR19
        lda $000D,b,y
        sta lR19+1
        bra _8879


        _88A9
        ply
        plp
        plb
        .databank ?
        sec
        rtl


        _88AE
        ply
        plp
        plb
        .databank ?
        clc
        rtl

        .databank 0

        ; 87/88B3

    .endsection Unsorted878852Section


    .section Unsorted8788F7Section

      .al
      .xl

      rlUnknown8788F7 ; 87/88F7

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlGetMapMenuTilemapRAMEntryPointer
        jsl rlUnknown878F6E
        rtl

        .databank 0

        ; 87/8900

    .endsection Unsorted8788F7Section


    .section Unsorted878900Section

      .al
      .xl

      rlUnknown878900 ; 87/8900

        .al
        .xl
        .autsiz
        .databank ?

        pha
        jsl rlGetMapMenuTilemapRAMEntryPointer
        pla
        jsl rlUnknown878FE7
        rtl

        .databank 0

        ; 87/890B

    .endsection Unsorted878900Section


    .section Unsorted878916Section

      .al
      .xl

      rlUnknown878916 ; 87/8916

        .al
        .xl
        .autsiz
        .databank ?

        pha
        jsl rlGetMapMenuTilemapRAMEntryPointer
        pla
        jsl rlUnknown8791EE
        rtl

        .databank 0

        ; 87/8921

    .endsection Unsorted878916Section


    .section Unsorted878921Section

      .al
      .xl

      rlDrawMapMenuTextLine ; 87/8921

        .al
        .autsiz
        .databank ?

        ; Draws a line of menu text (lR18, at X as in rlDrawMenuTextLine) into the
        ; current map menu's tilemap (lMapMenuRAMEntryPointer).

        jsl rlGetMapMenuTilemapRAMEntryPointer
        jsl rlDrawMenuTextLine
        rtl

        .databank 0

    .endsection Unsorted878921Section


    .section Unsorted878AB5Section

      .al
      .xl

      rlUnknown878AB5 ; 87/8AB5

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        phx
        phy
        ldy lMapMenuTilemapRAMEntryPointer,b
        sep #$20
        lda lMapMenuTilemapRAMEntryPointer+2,b
        pha
        rep #$20
        plb
        .databank ?
        lda structMapMenuTilemapData.TilesPointer+1,b,y
        sta lR19+1
        lda structMapMenuTilemapData.TilesPointer,b,y
        sta lR19
        lda structMapMenuTilemapData.Width,b,y
        and #$00FF
        sta wR0
        lda structMapMenuTilemapData.Height,b,y
        and #$00FF
        sta wR1
        sta wR3
        txa
        clc
        adc structMapMenuTilemapData.BGBuffer,b,y
        tax
        sep #$20
        lda structMapMenuTilemapData.BGBuffer+2,b,y
        pha
        rep #$20
        plb
        .databank ?
        ldy #$0000
        stx wR4

        _8AF7
        lda wR0
        sta wR2

        _8AFB
        lda [lR19],y
        cmp wUnknown053E,b
        beq _8B05
        sta $0000,b,x

        _8B05
        inc y
        inc y
        inc x
        inc x
        dec wR2
        bne _8AFB
        lda wR4
        clc
        adc #$0040
        sta wR4
        tax
        dec wR3
        bne _8AF7
        ply
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 87/8B1F

    .endsection Unsorted878AB5Section


    .section Unsorted878B1FSection

      .al
      .xl

      rlUnknown878B1F ; 87/8B1F

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        phy
        ldy lMapMenuTilemapRAMEntryPointer,b
        sep #$20
        lda lMapMenuTilemapRAMEntryPointer+2,b
        pha
        rep #$20
        plb
        .databank ?
        sep #$20
        lda structMapMenuTilemapData.Width,b,y
        sta @l WRMPYA
        lda structMapMenuTilemapData.Height,b,y
        sta @l WRMPYB
        nop
        nop
        nop
        rep #$20
        lda @l RDMPY
        asl a
        ply
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 87/8B4E

    .endsection Unsorted878B1FSection


    .section Unsorted878B4ESection

      .al
      .xl

      rlUnknown878B4E ; 87/8B4E

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        phy
        ldy lMapMenuTilemapRAMEntryPointer,b
        sep #$20
        lda lMapMenuTilemapRAMEntryPointer+2,b
        pha
        rep #$20
        plb
        .databank ?
        lda structMapMenuTilemapData.Width,b,y
        and #$00FF
        ply
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 87/8B69

      rlUnknown878B69 ; 87/8B69

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        phy
        pha
        ldy lMapMenuTilemapRAMEntryPointer,b
        sep #$20
        lda lMapMenuTilemapRAMEntryPointer+2,b
        pha
        rep #$20
        plb
        .databank ?
        pla
        sta structMapMenuTilemapData.Area,b,y
        ply
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 87/8B83

    .endsection Unsorted878B4ESection


    .section Unsorted878BF0Section

      .al
      .xl

      rlUnknown878BF0 ; 87/8BF0

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        phx
        phy
        lda aCurrentTilemapInfo,b
        sta wR8
        ldy lR18
        sep #$20
        lda lR18+2
        pha
        rep #$20
        plb
        .databank ?
        lda $0000,b,y
        and #$00FF
        sta wR3
        lda $0001,b,y
        and #$00FF
        sta wR4
        phk
        plb
        .databank $87
        ldy lMapMenuTilemapRAMEntryPointer,b
        sep #$20
        lda lMapMenuTilemapRAMEntryPointer+2,b
        pha
        rep #$20
        plb
        .databank ?
        lda structMapMenuTilemapData.TilesPointer,b,y
        sta lR19
        lda structMapMenuTilemapData.TilesPointer+1,b,y
        sta lR19+1
        lda structMapMenuTilemapData.Width,b,y
        and #$00FF
        sta wR5
        lda structMapMenuTilemapData.Height,b,y
        and #$00FF
        sta wR7
        ldx lR19
        sep #$20
        lda lR19+2
        pha
        rep #$20
        plb
        .databank ?
        stz wR0
        lda wR4
        sta wR2

        _8C4D
        ldy wR0
        lda wR3
        sta wR1
        lda wR5
        sta wR6

        _8C57
        lda [lR18],y
        clc
        adc wR8
        sta $0000,b,x
        dec wR1
        bne _8C69
        lda wR3
        sta wR1
        ldy wR0

        _8C69
        inc y
        inc y
        inc x
        inc x
        dec wR6
        bne _8C57
        lda wR3
        asl a
        clc
        adc wR0
        sta wR0
        dec wR2
        bne _8C83
        lda wR4
        sta wR2
        stz wR0

        _8C83
        dec wR7
        bne _8C4D
        ply
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 87/8C8C

    .endsection Unsorted878BF0Section


    .section Unsorted878C8CSection

      .al
      .xl

      rlUnknown878C8C ; 87/8C8C

        .al
        .autsiz
        .databank ?

        php
        phb
        phx
        phy

        sep #$20
        lda lR18+2
        pha
        rep #$20
        plb

        lda lR18
        clc
        adc #$000E
        tay

        ldx #$000E

          -
          lda $0000,b,y
          clc
          adc aCurrentTilemapInfo.wBaseTile,b
          sta wR1,x
          dec y
          dec y
          dec x
          dec x
          bpl -

        phk
        plb

        ldy lMapMenuTilemapRAMEntryPointer,b
        sep #$20
        lda lMapMenuTilemapRAMEntryPointer+2,b
        pha
        rep #$20
        plb

        lda structMapMenuTilemapData.TilesPointer,b,y
        sta lR18
        lda $0006+1,b,y
        sta lR18+1
        lda structMapMenuTilemapData.Width,b,y
        and #$00FF
        sta wR9
        lda structMapMenuTilemapData.Height,b,y
        and #$00FF
        sta wR10

        sep #$20
        lda lR18+2
        pha
        rep #$20
        plb

        sep #$20
        lda wR9
        sta WRMPYA
        lda wR10
        dec a
        sta WRMPYB
        nop
        nop
        nop
        rep #$20

        lda RDMPY
        asl a
        clc
        adc lR18
        tay

        ldx lR18
        lda wR1
        sta $0000,b,x
        inc x
        inc x
        lda wR6
        sta $0000,b,y
        inc y
        inc y
        lda wR9
        dec a
        dec a
        sta wR0

          -
          lda wR2
          sta $0000,b,x
          lda wR7
          sta $0000,b,y
          inc x
          inc x
          inc y
          inc y
          dec wR0
          bne -

        lda wR3
        sta $0000,b,x
        lda wR8
        sta $0000,b,y
        asl wR9

        lda wR9
        clc
        adc lR18
        tax

        clc
        adc wR9
        dec a
        dec a
        tay

        lda wR10
        dec a
        dec a
        sta wR0

          -
          lda wR4
          sta $0000,b,x
          lda wR5
          sta $0000,b,y

          txa
          clc
          adc wR9
          tax

          tya
          clc
          adc wR9
          tay
          dec wR0
          bne -

        ply
        plx
        plb
        plp
        rtl

        .databank 0

        ; 87/8D61

    .endsection Unsorted878C8CSection


    .section Unsorted878D61Section

      .al
      .xl

      rlUnknown878D61 ; 87/8D61

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        phx
        phy
        ldy lMapMenuTilemapRAMEntryPointer,b
        sep #$20
        lda lMapMenuTilemapRAMEntryPointer+2,b
        pha
        rep #$20
        plb
        .databank ?
        lda structMapMenuTilemapData.TilesPointer,b,y
        sta lR19
        lda structMapMenuTilemapData.TilesPointer+1,b,y
        sta lR19+1
        lda structMapMenuTilemapData.Width,b,y
        and #$00FF
        sta wR13
        lda structMapMenuTilemapData.Height,b,y
        and #$00FF
        sta wR14
        ldy lR18
        sep #$20
        lda lR18+2
        pha
        rep #$20
        plb
        .databank ?
        lda $0002,b,y
        clc
        adc aCurrentTilemapInfo,b
        sta wR1
        lda $0006,b,y
        clc
        adc aCurrentTilemapInfo,b
        sta wR2
        lda $000A,b,y
        clc
        adc aCurrentTilemapInfo,b
        sta wR3
        lda $000C,b,y
        clc
        adc aCurrentTilemapInfo,b
        sta wR4
        lda $000E,b,y
        clc
        adc aCurrentTilemapInfo,b
        sta wR5
        lda $0010,b,y
        clc
        adc aCurrentTilemapInfo,b
        sta wR6
        lda $0016,b,y
        clc
        adc aCurrentTilemapInfo,b
        sta wR7
        lda $0018,b,y
        clc
        adc aCurrentTilemapInfo,b
        sta wR8
        lda $001A,b,y
        clc
        adc aCurrentTilemapInfo,b
        sta wR9
        lda $001C,b,y
        clc
        adc aCurrentTilemapInfo,b
        sta wR10
        lda $0020,b,y
        clc
        adc aCurrentTilemapInfo,b
        sta wR11
        lda $0024,b,y
        clc
        adc aCurrentTilemapInfo,b
        sta wR12
        sep #$20
        lda lR19+2
        pha
        rep #$20
        plb
        .databank ?
        sep #$20
        lda wR13
        sta @l WRMPYA
        lda wR14
        dec a
        dec a
        sta @l WRMPYB
        nop
        nop
        nop
        rep #$20
        lda @l RDMPY
        asl a
        clc
        adc lR19
        tay
        ldx lR19
        lda wR1
        sta $0002,b,x
        txa
        clc
        adc wR13
        adc wR13
        tax
        lda wR3
        sta $0000,b,x
        lda wR4
        sta $0002,b,x
        dec x
        dec x
        dec x
        dec x
        lda wR2
        sta $0000,b,x
        txa
        clc
        adc wR13
        adc wR13
        tax
        lda wR5
        sta $0000,b,x
        lda wR6
        sta $0002,b,x
        lda wR7
        sta $0000,b,y
        lda wR8
        sta $0002,b,y
        tya
        clc
        adc wR13
        adc wR13
        tay
        lda wR11
        sta $0002,b,y
        dec y
        dec y
        dec y
        dec y
        lda wR9
        sta $0000,b,y
        lda wR10
        sta $0002,b,y
        tya
        clc
        adc wR13
        adc wR13
        tay
        lda wR12
        sta $0000,b,y
        ldy lR18
        sep #$20
        lda lR18+2
        pha
        rep #$20
        plb
        .databank ?
        lda $0000,b,y
        clc
        adc aCurrentTilemapInfo,b
        sta wR1
        lda $0004,b,y
        clc
        adc aCurrentTilemapInfo,b
        sta wR2
        lda $0008,b,y
        clc
        adc aCurrentTilemapInfo,b
        sta wR3
        lda $0012,b,y
        clc
        adc aCurrentTilemapInfo,b
        sta wR4
        lda $0014,b,y
        clc
        adc aCurrentTilemapInfo,b
        sta wR5
        lda $001E,b,y
        clc
        adc aCurrentTilemapInfo,b
        sta wR6
        lda $0022,b,y
        clc
        adc aCurrentTilemapInfo,b
        sta wR7
        lda $0026,b,y
        clc
        adc aCurrentTilemapInfo,b
        sta wR8
        sep #$20
        lda lR19+2
        pha
        rep #$20
        plb
        .databank ?
        sep #$20
        lda wR13
        sta @l WRMPYA
        lda wR14
        dec a
        sta @l WRMPYB
        nop
        nop
        nop
        rep #$20
        lda @l RDMPY
        asl a
        clc
        adc lR19
        tay
        ldx lR19
        lda wR1
        sta $0000,b,x
        lda wR6
        sta $0000,b,y
        lda wR13
        sec
        sbc #$0004
        beq _8F2C
        bcc _8F2C
        sta wR0

        _8F1A
        lda wR2
        sta $0004,b,x
        lda wR7
        sta $0004,b,y
        inc x
        inc x
        inc y
        inc y
        dec wR0
        bne _8F1A

        _8F2C
        lda wR3
        sta $0006,b,x
        lda wR8
        sta $0006,b,y
        asl wR13
        lda wR13
        asl a
        clc
        adc lR19
        tax
        clc
        adc wR13
        dec a
        dec a
        tay
        lda wR14
        sec
        sbc #$0004
        beq _8F69
        bcc _8F69
        sta wR0

        _8F51
        lda wR4
        sta $0000,b,x
        lda wR5
        sta $0000,b,y
        txa
        clc
        adc wR13
        tax
        tya
        clc
        adc wR13
        tay
        dec wR0
        bne _8F51

        _8F69
        ply
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 87/8F6E

    .endsection Unsorted878D61Section


    .section Unsorted878F6ESection

      .al
      .xl

      rlUnknown878F6E ; 87/8F6E

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        lda wR0
        pha
        lda wR1
        pha
        phx
        phy
        ldy lMapMenuTilemapRAMEntryPointer,b
        sep #$20
        lda lMapMenuTilemapRAMEntryPointer+2,b
        pha
        rep #$20
        plb
        .databank ?
        lda structMapMenuTilemapData.TilesPointer,b,y
        sta lR23
        lda structMapMenuTilemapData.TilesPointer+1,b,y
        sta lR23+1
        stz wR13
        stz wR1
        txa
        sep #$20
        sta wR1
        xba
        sta @l WRMPYA
        lda structMapMenuTilemapData.Width,b,y
        sta wR13
        sta @l WRMPYB
        nop
        nop
        nop
        rep #$20
        lda @l RDMPY
        clc
        adc wR1
        asl a
        tay
        lda wR13
        sec
        sbc wR1
        sta wR13
        ldx lR18
        sep #$20
        lda lR18+2
        pha
        rep #$20
        plb
        .databank ?

        _8FC6
        lda $0000,b,x
        and #$00FF
        beq _8FDC
        clc
        adc @l aCurrentTilemapInfo
        sta [lR23],y
        inc x
        inc y
        inc y
        dec wR13
        bne _8FC6

        _8FDC
        ply
        plx
        pla
        sta wR1
        pla
        sta wR0
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 87/8FE7

    .endsection Unsorted878F6ESection


    .section Unsorted878FE7Section

      .al
      .xl

      rlUnknown878FE7 ; 87/8FE7

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        phx
        phy
        ldy wR0
        phy
        and #$00FF
        cmp #$0064
        bcs _906C
        asl a
        pha
        ldy lMapMenuTilemapRAMEntryPointer,b
        sep #$20
        lda lMapMenuTilemapRAMEntryPointer+2,b
        pha
        rep #$20
        plb
        .databank ?
        lda structMapMenuTilemapData.TilesPointer,b,y
        sta lR23
        lda structMapMenuTilemapData.TilesPointer+1,b,y
        sta lR23+1
        stz wR0
        txa
        sep #$20
        sta wR0
        xba
        sta @l WRMPYA
        lda structMapMenuTilemapData.Width,b,y
        sta @l WRMPYB
        nop
        nop
        nop
        rep #$20
        lda @l RDMPY
        clc
        adc wR0
        asl a
        clc
        adc lR23
        sta lR23
        plx
        lda aUnknown879076+1,x
        and #$00FF
        clc
        adc @l aCurrentTilemapInfo
        clc
        adc #$0030
        ora #$2000
        sta [lR23]
        ldy #$0002
        lda aUnknown879076,x
        and #$00FF
        clc
        adc @l aCurrentTilemapInfo
        clc
        adc #$0030
        ora #$2000
        sta [lR23],y
        pla
        sta wR0
        ply
        plx
        plp
        plb
        .databank ?
        clc

        _906B
        rtl


        _906C
        plx
        stx wR0
        ply
        plx
        plp
        plb
        .databank ?
        sec
        bra _906B

        .databank 0

        ; 87/9076

    .endsection Unsorted878FE7Section


    .section Table879076Section

      .al
      .xl

      aUnknown879076 ; 87/9076

        ; Read by rlUnknown878FE7, rlUnknown87913E, rlUnknown8791EE.

        .word $0000, $0001, $0002, $0003, $0004, $0005, $0006, $0007
        .word $0008, $0009, $0100, $0101, $0102, $0103, $0104, $0105
        .word $0106, $0107, $0108, $0109, $0200, $0201, $0202, $0203
        .word $0204, $0205, $0206, $0207, $0208, $0209, $0300, $0301
        .word $0302, $0303, $0304, $0305, $0306, $0307, $0308, $0309
        .word $0400, $0401, $0402, $0403, $0404, $0405, $0406, $0407
        .word $0408, $0409, $0500, $0501, $0502, $0503, $0504, $0505
        .word $0506, $0507, $0508, $0509, $0600, $0601, $0602, $0603
        .word $0604, $0605, $0606, $0607, $0608, $0609, $0700, $0701
        .word $0702, $0703, $0704, $0705, $0706, $0707, $0708, $0709
        .word $0800, $0801, $0802, $0803, $0804, $0805, $0806, $0807
        .word $0808, $0809, $0900, $0901, $0902, $0903, $0904, $0905
        .word $0906, $0907, $0908, $0909

        ; 87/913E

    .endsection Table879076Section


    .section Unsorted87913ESection

      .al
      .xl

      rlUnknown87913E ; 87/913E

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        phx
        phy
        ldy wR0
        phy
        and #$00FF
        cmp #$0064
        bcc _9153
        jml _91E4


        _9153
        asl a
        pha
        ldy lMapMenuTilemapRAMEntryPointer,b
        sep #$20
        lda lMapMenuTilemapRAMEntryPointer+2,b
        pha
        rep #$20
        plb
        .databank ?
        lda structMapMenuTilemapData.TilesPointer,b,y
        sta lR23
        lda structMapMenuTilemapData.TilesPointer+1,b,y
        sta lR23+1
        stz wR0
        txa
        sep #$20
        sta wR0
        xba
        sta @l WRMPYA
        lda structMapMenuTilemapData.Width,b,y
        sta @l WRMPYB
        nop
        nop
        nop
        rep #$20
        lda @l RDMPY
        clc
        adc wR0
        asl a
        clc
        adc lR23
        sta lR23
        lda structMapMenuTilemapData.Width,b,y
        and #$00FF
        asl a
        sta wR0
        plx
        lda aUnknown879076+1,x
        and #$00FF
        clc
        adc @l aCurrentTilemapInfo
        clc
        adc #$0030
        ora #$2000
        sta [lR23]
        clc
        adc #$0010
        ldy wR0
        sta [lR23],y
        ldy #$0002
        lda aUnknown879076,x
        and #$00FF
        clc
        adc @l aCurrentTilemapInfo
        clc
        adc #$0030
        ora #$2000
        sta [lR23],y
        clc
        adc #$0010
        inc wR0
        inc wR0
        ldy wR0
        sta [lR23],y
        pla
        sta wR0
        ply
        plx
        plp
        plb
        .databank ?
        clc

        _91E3
        rtl


        _91E4
        plx
        stx wR0
        ply
        plx
        plp
        plb
        .databank ?
        sec
        bra _91E3

        .databank 0

        ; 87/91EE

    .endsection Unsorted87913ESection


    .section Unsorted8791EESection

      .al
      .xl

      rlUnknown8791EE ; 87/91EE

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        phx
        phy
        ldy wR0
        phy
        cmp #$03E8
        bmi _9200
        jml _934A


        _9200
        pha
        ldy lMapMenuTilemapRAMEntryPointer,b
        sep #$20
        lda lMapMenuTilemapRAMEntryPointer+2,b
        pha
        rep #$20
        plb
        .databank ?
        lda structMapMenuTilemapData.TilesPointer,b,y
        sta lR23
        lda structMapMenuTilemapData.TilesPointer+1,b,y
        sta lR23+1
        stz wR0
        txa
        dec a
        sep #$20
        sta wR0
        xba
        sta @l WRMPYA
        lda structMapMenuTilemapData.Width,b,y
        sta @l WRMPYB
        nop
        nop
        nop
        rep #$20
        lda @l RDMPY
        clc
        adc wR0
        asl a
        clc
        adc lR23
        sta lR23
        lda structMapMenuTilemapData.Width,b,y
        and #$00FF
        asl a
        sta wR0
        pla
        pha
        cmp #$0000
        bpl _9263
        lda #$20FF
        sta [lR23]
        lda #$0019
        clc
        adc @l aCurrentTilemapInfo
        ora #$2000
        ldy wR0
        sta [lR23],y
        bra _926C


        _9263
        lda #$20FF
        sta [lR23]
        ldy wR0
        sta [lR23],y

        _926C
        pla
        cmp #$0000
        bpl _9276
        eor #$FFFF
        inc a

        _9276
        cmp #$0064
        bmi _92D9
        sta wR13
        lda #$0064
        sta wR14
        jsl rlUnsignedDivide16By8
        lda wR13
        clc
        adc @l aCurrentTilemapInfo
        clc
        adc #$0030
        ora #$2000
        sta [lR23]
        clc
        adc #$0010
        ldy wR0
        sta [lR23],y
        lda wR10
        cmp #$000A
        bpl _92D9
        ldy #$0002
        lda #$0000
        clc
        adc @l aCurrentTilemapInfo
        clc
        adc #$0030
        ora #$2000
        sta [lR23],y
        inc y
        inc y
        sta [lR23],y
        sta wR13
        lda wR10
        bpl _92DE
        lda wR13
        clc
        adc #$0010
        inc wR0
        inc wR0
        ldy wR0
        sta [lR23],y
        inc y
        inc y
        sta [lR23],y
        jml _9341


        _92D9
        cmp #$000A
        bmi _9306

        _92DE
        asl a
        tax
        ldy #$0002
        lda aUnknown879076+1,x
        and #$00FF
        clc
        adc @l aCurrentTilemapInfo
        clc
        adc #$0030
        ora #$2000
        sta [lR23],y
        clc
        adc #$0010
        inc wR0
        inc wR0
        ldy wR0
        sta [lR23],y
        bra _931D


        _9306
        pha
        ldy #$0002
        lda #$00FF
        ora #$2000
        sta [lR23],y
        inc wR0
        inc wR0
        ldy wR0
        sta [lR23],y
        pla
        asl a
        tax

        _931D
        ldy #$0004
        lda aUnknown879076,x
        and #$00FF
        clc
        adc @l aCurrentTilemapInfo
        clc
        adc #$0030
        ora #$2000
        sta [lR23],y
        clc
        adc #$0010
        inc wR0
        inc wR0
        ldy wR0
        sta [lR23],y

        _9341
        pla
        sta wR0
        ply
        plx
        plp
        plb
        .databank ?
        clc

        _9349
        rtl


        _934A
        plx
        stx wR0
        ply
        plx
        plp
        plb
        .databank ?
        sec
        bra _9349

        .databank 0

        ; 87/9354

    .endsection Unsorted8791EESection


    .section Unsorted879EE7Section

      .al
      .xl

      rlUnknown879EE7 ; 87/9EE7

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        lda wSelectedUnitDataRAMPointer,b
        pha
        lda wRoutineVariable1,b
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitCharacterID
        sta wRoutineVariable1,b
        pla
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitLivingTalkTarget
        cmp wRoutineVariable1,b
        bne _9F0D
        plp
        plb
        .databank ?
        sec

        _9F0C
        rtl


        _9F0D
        plp
        plb
        .databank ?
        clc
        bra _9F0C

        .databank 0

        ; 87/9F12

    .endsection Unsorted879EE7Section


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


    .section Unsorted87A040Section

      .al
      .xl

      rlUnknown87A040 ; 87/A040

        .al
        .autsiz
        .databank ?

        ; Check if selected unit alive in home castle.

        phx
        ldx wSelectedUnitDataRAMPointer,b
        phx
        ldx wRoutineVariable1,b
        phx

        jsl rlGetUnitRAMDataPointerByID
        bcs _CLC

          jsl rlGetSelectedUnitStates
          bit #(UnitStateFielded | UnitStateDead)
          bne _CLC

            jsl rlGetSelectedUnitFactionSlot
            ora #FS_Player
            bne _CLC

              lda #0
              jsl rlGetFactionSlotLocationID
              sta wRoutineVariable1,b

              jsl rlGetSelectedUnitHomeCastle
              cmp wRoutineVariable1,b
              bne _CLC

                sec
                bra +

        _CLC
        clc

        +
        pla
        sta wRoutineVariable1,b
        pla
        sta wSelectedUnitDataRAMPointer,b
        plx
        rtl

        .databank 0

        ; 87/A082

    .endsection Unsorted87A040Section


    .section Unsorted87A082Section

      .al
      .xl

      rlUnknown87A082 ; 87/A082

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        phx
        lda wSelectedUnitDataRAMPointer,b
        pha
        jsl rlGetSelectedUnitArenaLevel
        cmp #$0007
        bcs _A0D5
        asl a
        sta wRoutineVariable1,b
        jsl rlUnknown81B4C5
        ldx lR18
        sep #$20
        lda lR18+2
        pha
        rep #$20
        plb
        .databank ?
        jsl rlGetSelectedItemRange
        lda wR10
        cmp #$0002
        bcs _A0B6
        lda $0000,b,x
        bra _A0B9


        _A0B6
        lda $0002,b,x

        _A0B9
        clc
        adc wRoutineVariable1,b
        tax
        lda $0000,b,x
        jsl rlGetUnitRAMDataPointerByID
        bcs _A0C9
        inc x
        inc x

        _A0C9
        lda $0000,b,x
        plx
        stx wSelectedUnitDataRAMPointer,b
        plx
        plp
        plb
        .databank ?
        clc

        _A0D4
        rtl


        _A0D5
        plx
        stx wSelectedUnitDataRAMPointer,b
        plx
        plp
        plb
        .databank ?
        sec
        bra _A0D4

        .databank 0

        ; 87/A0DF

      rlUnknown87A0DF ; 87/A0DF

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        phx
        phy
        jsl rlUnknown87A082
        bcs _A135
        tay
        stz wTempItemDataROMPointer,b
        ldx #$0002
        tya
        jsl rlGetCharacterEquipSlotItemROMPointer
        lda wCurrentItemDataROMPointer,b
        beq _A10B
        jsl rlGetItemEquipmentType
        cmp #$0002
        bne _A10B
        lda wCurrentItemDataROMPointer,b
        sta wTempItemDataROMPointer,b

        _A10B
        ldx #$0001

        _A10E
        tya
        jsl rlGetCharacterEquipSlotItemROMPointer
        lda wCurrentItemDataROMPointer,b
        beq _A129
        jsl rlGetItemMinimumRange
        dec a
        cmp wR10
        bcs _A129
        jsl rlGetItemMaximumRange
        cmp wR10
        bcs _A12F

        _A129
        inc x
        cpx #$0003
        bcc _A10E

        _A12F
        ply
        plx
        plp
        plb
        .databank ?
        clc

        _A134
        rtl


        _A135
        ply
        plx
        plp
        plb
        .databank ?
        sec
        bra _A134

        .databank 0

        ; 87/A13C

      rlUnknown87A13C ; 87/A13C

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        phx
        stz wRoutineVariable1,b
        lda wCurrentChapter,b
        cmp #$0006
        bcc _A152
        lda #$0018
        sta wRoutineVariable1,b

        _A152
        jsl rlGetSelectedUnitGenerationID
        dec a
        clc
        adc wRoutineVariable1,b
        asl a
        tax
        lda aUnitWinCounts,x
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 87/A165

      rlUnknown87A165 ; 87/A165

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        phx
        stz wRoutineVariable1,b
        lda wCurrentChapter,b
        cmp #$0006
        bcc _A17B
        lda #$0018
        sta wRoutineVariable1,b

        _A17B
        jsl rlGetSelectedUnitGenerationID
        dec a
        clc
        adc wRoutineVariable1,b
        jsl rlUnknown91EBBE
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 87/A18C

    .endsection Unsorted87A082Section


    .section Unsorted87A18CSection

      .al
      .xl

      rlUnknown87A18C ; 87/A18C

        .al
        .xl
        .autsiz
        .databank ?

        lda #SkillIDBargain
        jsl rlCheckIfUnitHasSpecifiedPersonalOrClassSkill
        bcs _A19C
        lda #SkillIDBargain
        jsl rlCheckIfInventoryItemsHaveSpecifiedSkill

        _A19C
        rtl

        .databank 0

        ; 87/A19D

    .endsection Unsorted87A18CSection


    .section Unsorted87AE88Section

      .al
      .xl

      rlUnknown87AE88 ; 87/AE88

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        phx
        phy
        ldx wSelectedUnitDataRAMPointer,b
        phx
        ldx wR0
        phx
        ldx wR1
        phx
        ldx wR2
        phx
        sta wR2
        jsl rlGetSelectedUnitLoverGenerationID
        ora #$0000
        beq _AEAA
        jml _AF34


        _AEAA
        lda #$0001
        sta wR0
        stz wR1
        jsl rlGetSelectedUnitGenerationID
        bcs _AF32
        cmp #$0010
        bcs _AEFB
        tay
        ldx #$0001

        _AEC0
        stx wRoutineVariable1,b
        lda #$0000
        jsl rlGetUnitRAMDataPointerByFactionSlotEntryID
        lda wSelectedUnitDataRAMPointer,b
        beq _AEF9
        jsl rlGetSelectedUnitGenerationID
        bcs _AEF6
        cmp #$0010
        bcc _AEF6
        sta wRoutineVariable1,b
        jsl rlGetSelectedUnitLoverGenerationID
        ora #$0000
        bne _AEF6
        tya
        jsl rlGetLoverPointsWithTarget
        cmp wR0
        bmi _AEF6
        sta wR0
        lda wRoutineVariable1,b
        sta wR1

        _AEF6
        inc x
        bra _AEC0


        _AEF9
        bra _AF32


        _AEFB
        jsl rlGetSelectedUnitLoverData
        cpx #$0000
        beq _AF32
        ldy #$0001

        _AF07
        sty wRoutineVariable1,b
        lda #$0000
        jsl rlFindGenerationIDInFactionSlotData
        lda wSelectedUnitDataRAMPointer,b
        beq _AF2A
        jsl rlGetSelectedUnitLoverGenerationID
        ora #$0000
        bne _AF2A
        lda $0000,b,x
        cmp wR0
        bmi _AF2A
        sta wR0
        sty wR1

        _AF2A
        inc x
        inc x
        inc y
        cpy #$0010
        bne _AF07

        _AF32
        lda wR1

        _AF34
        plx
        stx wR2
        plx
        stx wR1
        plx
        stx wR0
        plx
        stx wSelectedUnitDataRAMPointer,b
        ply
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 87/AF46

    .endsection Unsorted87AE88Section


    .section Unsorted87B01DSection

      .al
      .xl

      rlUnknown87B01D ; 87/B01D

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = EntryIndex
        ; wRoutineVariable1 = CharacterID

        phb
        php
        phk
        plb
        phx

        sta aEventMovement.wEntryIndex

        lda aEventMovement.wUnitXCoordinate
        bpl +

          lda wRoutineVariable1,b
          jsl rlGetUnitRAMDataPointerByID
          bcs _SEC

            jsl rlGetSelectedUnitDeploymentOffset
            tax
            lda aDeploymentTable._XTilePosition,x
            sta aEventMovement.wUnitXCoordinate
            lda aDeploymentTable._YTilePosition,x
            sta aEventMovement.wUnitYCoordinate

        +
        lda wRoutineVariable1,b
        jsl rlGetCharacterClass
        jsl rlGetClassDataROMPointer
        jsl rlGetClassMovementType
        asl a
        clc
        adc aMainDataOffsets.MovementCostOffsets
        tax
        lda aMainDataOffsets,x
        clc
        adc aMainDataOffsets.MovementCostOffsets
        adc #<>aMainDataOffsets
        sta aEventMovement.wMovementCostPointer
        jsl rlUnknown87B080
        bcs _SEC

          plx
          plp
          plb
          clc
          rtl

        _SEC
        plx
        plp
        plb
        sec
        rtl

        .databank 0

      rlUnknown87B080 ; 87/B080

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        phy
        jsl rlFillEventMovementMoveCostMap

        lda aEventMovement.wUnknown7EC494
        bne _B0F7

          lda #`aEventMovement.aTargetMap
          ldx #<>aEventMovement.aTargetMap
          jsl rlClearMapBufferAddBorders

          lda aEventMovement.wDestinationXCoordinate
          sta aEventMovement.wTargetXCoordinate
          lda aEventMovement.wDestinationYCoordinate
          sta aEventMovement.wTargetYCoordinate
          lda #0
          jsl rlSetEventMovementTargetTile

          ldx #len(aDeploymentTable._State)-2

            _Loop
            lda aDeploymentTable._State,x
            bit #DeploymentStateAlive
            beq _Next

              lda aDeploymentTable._XTilePosition,x
              sta aEventMovement.wTargetXCoordinate
              lda aDeploymentTable._YTilePosition,x
              sta aEventMovement.wTargetYCoordinate
              lda #$00FF
              jsl rlSetEventMovementTargetTile

            _Next
            dec x
            dec x
            bpl _Loop

          lda aEventMovement.wDestinationXCoordinate
          sta aEventMovement.wStartingXCoordinate
          lda aEventMovement.wDestinationYCoordinate
          sta aEventMovement.wStartingYCoordinate
          lda #0
          sta aEventMovement.wTargetXCoordinate
          jsl rlEventMovementBuildTargetDistanceMap
          bcc _SEC
          bra +

        _B0F7
        lda aEventMovement.wDestinationXCoordinate
        sta aEventMovement.wTargetXCoordinate
        lda aEventMovement.wDestinationYCoordinate
        sta aEventMovement.wTargetYCoordinate

        +
        lda aEventMovement.wEntryIndex
        asl a
        tax
        lda aEventMovement.wTargetXCoordinate
        sta aEventMovement.wStartingXCoordinate
        sta aEventMovement.aScriptEndXCoordinate,x
        lda aEventMovement.wTargetYCoordinate
        sta aEventMovement.wStartingYCoordinate
        sta aEventMovement.aScriptEndYCoordinate,x

        jsl rlClearEventMovementTargetMap

        lda aEventMovement.wUnitXCoordinate
        sta aEventMovement.wTargetXCoordinate
        sta aEventMovement.aScriptStartXCoordinate,x
        lda aEventMovement.wUnitYCoordinate
        sta aEventMovement.wTargetYCoordinate
        sta aEventMovement.aScriptStartYCoordinate,x
        lda #0
        jsl rlSetEventMovementTargetTile

        lda #1
        sta aEventMovement.wTargetXCoordinate
        jsl rlEventMovementBuildTargetDistanceMap
        bcc _SEC

        lda aEventMovement.wEntryIndex
        jsl rlEventMovementCreateMovementScriptFromTargetDistanceMap

        ply
        plx
        plp
        plb
        clc
        rtl

        _SEC
        ply
        plx
        plp
        plb
        sec
        rtl

        .databank 0

    .endsection Unsorted87B01DSection


    .section Unsorted87B512Section

      .al
      .xl

      rlUnknown87B512 ; 87/B512

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        lda wSelectedInventorySlot,b
        jsl rlGetItemROMDataByInventorySlot
        lda #$0001
        sta wR12
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitStates
        bit #UnitState0400
        beq _B537
        lda #$0004
        bra _B53A


        _B537
        lda #$0000

        _B53A
        jsl rlUnknown84FED2
        plp
        plb
        .databank $87
        rtl

        .databank 0

        ; 87/B541

    .endsection Unsorted87B512Section


    .section Unsorted87B541Section

      .al
      .xl

      rlUnknown87B541 ; 87/B541

        .al
        .autsiz
        .databank ?

        phx
        phy
        jsl rlGetSelectedUnitFactionSlot
        sta aAIAction.wMapPointer

        jsl rlGetSelectedUnitStates
        bit #UnitStateCanto
        beq +

          lda #0
          tay
          bra ++

          +
          jsl rlGetInventoryWeaponsRangeFlags

        +
        sta $1A
        sty $08
        cmp #4
        bcc +

          jsl rlUnknown87BA0B
          sec
          bra _End

        +
        jsl rlGetSelectedUnitMovementCostPointer
        sta aAIAction.wUnknown7F442C

        jsl rlGetSelectedUnitTotalFieldMovement
        sta $18

        jsl rlUnknown87B59D

        lda wActiveFactionSlot,b
        bne +

          lda aAIAction.wMapPointer
          beq +

            lda $08
            bit #$0004
            beq +

              jsl rlUnknown87BA82

        +
        jsl rlUnknown87BB27

        _End
        ply
        plx
        rtl

        .databank 0

      rlUnknown87B59D ; 87/B59D

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb

        sep #$20
        lda #$7F
        pha
        rep #$20
        plb
        .databank $7F

        jsr rsUnknown87B786
        jsr rsUnknown87B7A2
        jsr rsUnknown87B7B0
        jsr rsUnknown87B7BE
        jsr rsUnknown87B833
        stz $22
        jsr rsUnknown87B5DD

        lda $1A
        beq _End

        sep #$20
        ldx #$0100

          -
          cpx $06
          beq +

          ldy $894C,b,x
          jsr rsUnknown87B91C

          inc x
          inc x
          inc x
          inc x
          cpx $06
          bra -

        +
        rep #$20
        
        _End
        plp
        plb
        rtl

        .databank 0

    .endsection Unsorted87B541Section


    .section Unsorted87B5DDSection

      .al
      .xl

      rsUnknown87B5DD ; 87/B5DD

        .al
        .autsiz
        .databank $7F

        ldx #64 - 2
        lda #$FFFF
        
          -
          sta $894A + (64 * 0),b,x
          sta $894A + (64 * 1),b,x
          sta $894A + (64 * 2),b,x
          sta $894A + (64 * 3),b,x
          dec x
          dec x
          bpl -

        lda #32
        asl a
        asl a
        asl a
        asl a
        asl a
        asl a
        clc
        adc #32
        tay

        lda $18
        sep #$20
        sta aMovementMap,y
        rep #$20
        sta $04
        asl a
        tax
        lda #$0100
        sta $894A,b,x

        lda #$FFFF
        sta $894A,b + $100
        tya
        sta $894A,b + $102

        lda #$0104
        sta $06
        
          -
          lda $04
          cmp #7
          bcc _End

            asl 
            tax
            
              -
              lda $894A,b,x
              bmi +

                tax
                ldy $894A+2,b,x
                jsr rsUnknown87B63F
                bra -

          +
          dec $04
          bra --
        
        _End
        rts

        .databank 0

        ; 87/B63F

    .endsection Unsorted87B5DDSection


    .section Unsorted87B63FSection

      .al
      .xl

      rsUnknown87B63F ; 87/B63F

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        phx
        lda $750A,b,y
        bne _B692
        lda $650A,b,y
        bmi _B692
        rep #$20
        lda #$FFC0
        jsr rsUnknown87B8A7
        sep #$20
        bmi _B692
        lda wR2
        sec
        sbc wR0
        bcc _B692
        beq _B692
        pha
        jsr rsUnknown87B8FE
        pla
        bcc _B66A
        ora #$80

        _B66A
        sta $750A,b,y
        rep #$20
        and #$007F
        asl a
        tax
        lda $894A,b,x
        pha
        lda wR3
        sta $894A,b,x
        tax
        clc
        adc #$0004
        sta wR3
        pla
        sta $894A,b,x
        tya
        clc
        adc #$FFC0
        sta $894C,b,x
        sep #$20

        _B692
        lda $7549,b,y
        bne _B6E2
        lda $6549,b,y
        bmi _B6E2
        rep #$20
        lda #$FFFF
        jsr rsUnknown87B8A7
        sep #$20
        bmi _B6E2
        lda wR2
        sec
        sbc wR0
        bcc _B6E2
        beq _B6E2
        pha
        jsr rsUnknown87B8FE
        pla
        bcc _B6BA
        ora #$80

        _B6BA
        sta $7549,b,y
        rep #$20
        and #$007F
        asl a
        tax
        lda $894A,b,x
        pha
        lda wR3
        sta $894A,b,x
        tax
        clc
        adc #$0004
        sta wR3
        pla
        sta $894A,b,x
        tya
        clc
        adc #$FFFF
        sta $894C,b,x
        sep #$20

        _B6E2
        lda $754B,b,y
        bne _B732
        lda $654B,b,y
        bmi _B732
        rep #$20
        lda #$0001
        jsr rsUnknown87B8A7
        sep #$20
        bmi _B732
        lda wR2
        sec
        sbc wR0
        bcc _B732
        beq _B732
        pha
        jsr rsUnknown87B8FE
        pla
        bcc _B70A
        ora #$80

        _B70A
        sta $754B,b,y
        rep #$20
        and #$007F
        asl a
        tax
        lda $894A,b,x
        pha
        lda wR3
        sta $894A,b,x
        tax
        clc
        adc #$0004
        sta wR3
        pla
        sta $894A,b,x
        tya
        clc
        adc #$0001
        sta $894C,b,x
        sep #$20

        _B732
        lda $758A,b,y
        bne _B782
        lda $658A,b,y
        bmi _B782
        rep #$20
        lda #$0040
        jsr rsUnknown87B8A7
        sep #$20
        bmi _B782
        lda wR2
        sec
        sbc wR0
        bcc _B782
        beq _B782
        pha
        jsr rsUnknown87B8FE
        pla
        bcc _B75A
        ora #$80

        _B75A
        sta $758A,b,y
        rep #$20
        and #$007F
        asl a
        tax
        lda $894A,b,x
        pha
        lda wR3
        sta $894A,b,x
        tax
        clc
        adc #$0004
        sta wR3
        pla
        sta $894A,b,x
        tya
        clc
        adc #$0040
        sta $894C,b,x
        sep #$20

        _B782
        plx
        rep #$20
        rts

        .databank 0

        ; 87/B786

    .endsection Unsorted87B63FSection


    .section Unsorted87B786Section

      .al
      .xl

      rsUnknown87B786 ; 87/B786

        .al
        .autsiz
        .databank ?

        ; $14 = X pos
        ; $16 = Y pos

        lda $14
        sec
        sbc #$0020
        sta $1C

        lda $16
        sec
        sbc #$0020
        sta $1E
        asl a
        asl a
        asl a
        asl a
        asl a
        asl a
        clc
        adc $1C
        sta $20
        rts

        .databank 0

      rsUnknown87B7A2 ; 87/B7A2

        .al
        .autsiz
        .databank ?

        lda #`aMovementMap
        ldx #<>aMovementMap
        ldy #0
        jsl rlFillMapBuffer
        rts

        .databank 0

      rsUnknown87B7B0 ; 87/B7B0

        .al
        .autsiz
        .databank ?

        lda #`aRangeMap
        ldx #<>aRangeMap
        ldy #0
        jsl rlFillMapBuffer
        rts

        .databank 0

      rsUnknown87B7BE ; 87/B7BE

        .al
        .autsiz
        .databank $7F

        ; fills map buffer with enemy and ally values?

        ldx #(72 - 1) * size(word)
        
        -
        lda aDeploymentTable._State,x
        bit #DeploymentStateAlive
        beq _Next

          bit #DeploymentStateHidden
          bne _Next

            bit #DeploymentStateDefeated
            bne _Next

              lda aDeploymentTable._XTilePosition,x
              sec
              sbc $1C
              sta aAIAction.wTargetXPosition
              cmp #$0040
              bcs _Next

                lda aDeploymentTable._YTilePosition,x
                sec
                sbc $1E
                sta aAIAction.wTargetYPosition
                cmp #$0040
                bcs _Next

                  jsr rsUnknown87B811

                  pha
                  lda aAIAction.wTargetYPosition
                  asl a
                  asl a
                  asl a
                  asl a
                  asl a
                  asl a
                  clc
                  adc aAIAction.wTargetXPosition
                  tay
                  pla
                  sep #$20
                  sta aRangeMap,y
                  rep #$20

        _Next
        dec x
        dec x
        bpl -

        rts

        .databank 0

      rsUnknown87B811 ; 87/B811

        .al
        .autsiz
        .databank ?

        phx
        lda aDeploymentTable._FactionSlot,x
        tax

        lda $442A,b
        bmi ++

          jsl rlGetFactionRelation
          plx
          cmp #AllegianceNeutral
          beq +

            cmp #AllegianceEnemy
            bne ++

          ; neutral, enemy
          +
          lda #$00FF
          rts

        ; own, allied
        +
        lda #1
        rts

        .databank 0

      rsUnknown87B833 ; 87/B833

        .al
        .autsiz
        .databank ?

        ; write map boundaries?

        lda wR14
        bmi +

          lda #$003F
          sec
          sbc wR14
          jsr rsUnknown87B877

          lda wR14
          bne ++

        +
        eor #$FFFF
        inc a
        jsr rsUnknown87B877
        
        +
        lda wCurrentChapter
        beq +

          lda wR15
          bmi _B86D

            lda #$003F
            bne ++

        +
        lda #$001F

        +
        sec
        sbc wR15
        jsr rsUnknown87B88F

        lda wCurrentChapter
        beq _B86D

          lda wR15
          bne +

            _B86D
            lda wR15
            eor #$FFFF
            inc a
            jsr rsUnknown87B88F
        
        +
        rts

        .databank 0

    .endsection Unsorted87B786Section


    .section Unsorted87B877Section

      .al
      .xl

      rsUnknown87B877 ; 87/B877

        .al
        .autsiz
        .databank ?

        ; write vertical boundaries?

        tay
        ldx #64
        
          -
          lda #$00FE
          sep #$20
          sta $654A,b,y
          rep #$20
          tya
          clc
          adc #64
          tay
          dec x
          bne -

        rts

        .databank 0

      rsUnknown87B88F ; 87/B88F

        .al
        .autsiz
        .databank $7F

        ; write horizonal boundaries?

        asl a
        asl a
        asl a
        asl a
        asl a
        asl a
        tay

        sep #$20
        ldx #64
        
          -
          lda #$FE
          sta aRangeMap,y
          inc y
          dec x
          bne -

        rep #$20
        rts

        .databank 0

        ; 87/B8A7

    .endsection Unsorted87B877Section


    .section Unsorted87B8A7Section

      .al
      .xl

      rsUnknown87B8A7 ; 87/B8A7

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        sta wR0
        lda wR17
        bne _B8E6
        tya
        clc
        adc wR0
        clc
        adc wR16
        asl a
        tax
        lda $2400,b,x
        sta wR1
        and #$03FF
        tax
        lda $2000,b,x
        and #$00FF
        cmp #$001A
        bcc _B8CF
        lda #$0000

        _B8CF
        clc
        adc $442C,b
        tax
        lda $830000,x
        and #$00FF
        bit #$0080
        bne _B8E6
        asl a
        tax
        lda aUnknown87B8EE,x

        _B8E6
        ply
        plx
        sta wR0
        cmp #$0000
        rts

        .databank 0

        ; 87/B8EE

    .endsection Unsorted87B8A7Section


    .section Table87B8EESection

      .al
      .xl

      aUnknown87B8EE ; 87/B8EE

        ; Read by rsUnknown87B8A7.

        .word $0007, $000A, $0014, $001E, $0028, $0032, $003C, $0046

        ; 87/B8FE

    .endsection Table87B8EESection


    .section Unsorted87B8FESection

      .al
      .xl

      rsUnknown87B8FE ; 87/B8FE

        .as
        .xl
        .autsiz
        .databank ?

        lda wR17
        bne _B91A
        lda aAIAction.wMapPointer
        bne _B91A
        lda wR1+1
        and #$FC
        beq _B91A
        sta wR1+1
        and @l wAreaRestrictionBitfield
        cmp wR1+1
        beq _B91A
        sec
        rts


        _B91A
        clc
        rts

        .databank 0

        ; 87/B91C

      rsUnknown87B91C ; 87/B91C

        .as
        .xl
        .autsiz
        .databank ?

        lda $754A,b,y
        bpl _B925
        jml _BA0A


        _B925
        lda $654A,b,y
        beq _B92E
        jml _BA0A


        _B92E
        lda wR13
        and #$01
        beq _B978
        lda $750A,b,y
        bne _B945
        lda $650A,b,y
        cmp #$FE
        beq _B945
        lda #$80
        sta $750A,b,y

        _B945
        lda $758A,b,y
        bne _B956
        lda $658A,b,y
        cmp #$FE
        beq _B956
        lda #$80
        sta $758A,b,y

        _B956
        lda $7549,b,y
        bne _B967
        lda $6549,b,y
        cmp #$FE
        beq _B967
        lda #$80
        sta $7549,b,y

        _B967
        lda $754B,b,y
        bne _B978
        lda $654B,b,y
        cmp #$FE
        beq _B978
        lda #$80
        sta $754B,b,y

        _B978
        lda wR13
        and #$02
        bne _B982
        jml _BA0A


        _B982
        lda $7509,b,y
        bne _B993
        lda $6509,b,y
        cmp #$FE
        beq _B993
        lda #$80
        sta $7509,b,y

        _B993
        lda $750B,b,y
        bne _B9A4
        lda $650B,b,y
        cmp #$FE
        beq _B9A4
        lda #$80
        sta $750B,b,y

        _B9A4
        lda $7548,b,y
        bne _B9B5
        lda $6548,b,y
        cmp #$FE
        beq _B9B5
        lda #$80
        sta $7548,b,y

        _B9B5
        lda $754C,b,y
        bne _B9C6
        lda $654C,b,y
        cmp #$FE
        beq _B9C6
        lda #$80
        sta $754C,b,y

        _B9C6
        lda $7589,b,y
        bne _B9D7
        lda $6589,b,y
        cmp #$FE
        beq _B9D7
        lda #$80
        sta $7589,b,y

        _B9D7
        lda $758B,b,y
        bne _B9E8
        lda $658B,b,y
        cmp #$FE
        beq _B9E8
        lda #$80
        sta $758B,b,y

        _B9E8
        lda $74CA,b,y
        bne _B9F9
        lda $64CA,b,y
        cmp #$FE
        beq _B9F9
        lda #$80
        sta $74CA,b,y

        _B9F9
        lda $75CA,b,y
        bne _BA0A
        lda $65CA,b,y
        cmp #$FE
        beq _BA0A
        lda #$80
        sta $75CA,b,y

        _BA0A
        rts

        .databank 0

        ; 87/BA0B

      rlUnknown87BA0B ; 87/BA0B

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        sep #$20
        lda #$7F
        pha
        rep #$20
        plb
        .databank $7F
        jsr rsUnknown87B786
        jsr rsUnknown87B7A2
        jsr rsUnknown87B7B0
        jsr rsUnknown87B833
        lda #$0065
        sta wR12
        lda #$000A
        sta wR17
        jsr rsUnknown87B5DD
        lda #$0065
        sta wR2

        _BA35
        lda wR2
        asl a
        tax

        _BA39
        lda $894A,b,x
        bmi _BA47
        tax
        ldy $894C,b,x
        jsr rsUnknown87BA54
        bra _BA39


        _BA47
        lda wR2
        sec
        sbc wR17
        sta wR2
        bpl _BA35
        plp
        plb
        .databank $7F
        clc
        rtl

        .databank 0

        ; 87/BA54

      rsUnknown87BA54 ; 87/BA54

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda wR2
        cmp #$65
        beq _BA68
        cmp #$5B
        beq _BA6C
        cmp #$51
        beq _BA74

        _BA64
        lda #$80
        bra _BA7C


        _BA68
        lda #$01
        bra _BA7C


        _BA6C
        lda wR13
        and #$01
        bne _BA64
        bra _BA7A


        _BA74
        lda wR13
        and #$02
        bne _BA64

        _BA7A
        lda #$00

        _BA7C
        sta $754A,b,y
        rep #$20
        rts

        .databank 0

        ; 87/BA82

      rlUnknown87BA82 ; 87/BA82

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        sep #$20
        lda #$7F
        pha
        rep #$20
        plb
        .databank $7F
        ldx #$0000

        _BA91
        lda aUnknown87BAD1,x
        beq _BAB7
        tay
        lda aUnknown87BAD1+2,x
        inc x
        inc x
        inc x
        inc x
        phx
        tax
        phx
        phy

        _BAA4
        jsr rsUnknown87BABB
        inc x
        dec y
        bne _BAA4
        ply
        plx

        _BAAD
        jsr rsUnknown87BABB
        dec x
        dec y
        bne _BAAD
        plx
        bra _BA91


        _BAB7
        plp
        plb
        .databank ?
        clc
        rtl

        .databank 0

        ; 87/BABB

      rsUnknown87BABB ; 87/BABB

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda $754A,b,x
        bne _BACE
        lda $654A,b,x
        cmp #$FE
        beq _BACE
        lda #$FF
        sta $754A,b,x

        _BACE
        rep #$20
        rts

        .databank 0

        ; 87/BAD1

    .endsection Unsorted87B8FESection


    .section Table87BAD1Section

      .al
      .xl

      aUnknown87BAD1 ; 87/BAD1

        ; Read by rlUnknown87BA82.

        .word $0001, $05A0, $0002, $05E0, $0003, $0620, $0004, $0660
        .word $0005, $06A0, $0006, $06E0, $0007, $0720, $0008, $0760
        .word $0009, $07A0, $000A, $07E0, $000B, $0820, $000A, $0860
        .word $0009, $08A0, $0008, $08E0, $0007, $0920, $0006, $0960
        .word $0005, $09A0, $0004, $09E0, $0003, $0A20, $0002, $0A60
        .word $0001, $0AA0, $0000

        ; 87/BB27

    .endsection Table87BAD1Section


    .section Unsorted87BB27Section

      .al
      .xl

      rlUnknown87BB27 ; 87/BB27

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda $7F7D2A
        bmi _BB31
        bne _BB4C

        _BB31
        lda $7F7DAA
        bmi _BB39
        bne _BB4C

        _BB39
        lda $7F7D69
        bmi _BB41
        bne _BB4C

        _BB41
        lda $7F7D6B
        bmi _BB49
        bne _BB4C

        _BB49
        sec
        bra _BB4D


        _BB4C
        clc

        _BB4D
        rep #$20
        rtl

        .databank 0

        ; 87/BB50

    .endsection Unsorted87BB27Section


    .section Unsorted87BED7Section

      .al
      .xl

      rlUnknown87BED7 ; 87/BED7

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        ora #$0000
        bne _BEE8
        lda #$0004
        trb wOptionSettings,b
        bra _BEEE


        _BEE8
        lda #$0004
        tsb wOptionSettings,b

        _BEEE
        plp
        plb
        .databank $87
        rtl

        .databank 0

        ; 87/BEF1

    .endsection Unsorted87BED7Section


    .section Unsorted87BF01Section

      .al
      .xl

      rlUnknown87BF01 ; 87/BF01

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        and #$0007
        asl a
        asl a
        asl a
        sta wR0
        lda wOptionSettings,b
        and #$FFC7
        ora wR0
        sta wOptionSettings,b
        plp
        plb
        .databank $87
        rtl

        .databank 0

        ; 87/BF1B

    .endsection Unsorted87BF01Section


    .section Unsorted87BF1BSection

      .al
      .xl

      rlUnknown87BF1B ; 87/BF1B

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        lda wOptionSettings,b
        bit #$0040
        jml rlCheckIfTerrainWindowSettingOff._BEA2

        .databank 0

        ; 87/BF29

    .endsection Unsorted87BF1BSection


    .section Unsorted87BF29Section

      .al
      .xl

      rlUnknown87BF29 ; 87/BF29

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        ora #$0000
        bne _BF3A
        lda #$0040
        trb wOptionSettings,b
        bra _BF40


        _BF3A
        lda #$0040
        tsb wOptionSettings,b

        _BF40
        plp
        plb
        .databank $87
        rtl

        .databank 0

        ; 87/BF43

    .endsection Unsorted87BF29Section


    .section Unsorted87BF43Section

      .al
      .xl

      rlUnknown87BF43 ; 87/BF43

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        lda wOptionSettings,b
        and #$0180
        asl a
        xba
        plp
        plb
        .databank $87
        rtl

        .databank 0

        ; 87/BF52

    .endsection Unsorted87BF43Section


    .section Unsorted87BF52Section

      .al
      .xl

      rlUnknown87BF52 ; 87/BF52

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        and #$0003
        xba
        lsr a
        sta wR0
        lda wOptionSettings,b
        and #$FE7F
        ora wR0
        sta wOptionSettings,b
        jsl rlUnknown87BF6F
        plp
        plb
        .databank $87
        rtl

        .databank 0

        ; 87/BF6F

    .endsection Unsorted87BF52Section


    .section Unsorted87BF6FSection

      .al
      .xl

      rlUnknown87BF6F ; 87/BF6F

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        jsl rlUnknown87BF43
        cmp #$0002
        bne _BF8A
        sep #$20
        lda bSoundFlags,b
        ora #$10
        sta bSoundFlags,b
        rep #$20
        bra _BFAD


        _BF8A
        cmp #$0001
        bne _BF9F
        sep #$20
        lda bSoundFlags,b
        and #$EF
        ora #$40
        sta bSoundFlags,b
        rep #$20
        bra _BFAD


        _BF9F
        sep #$20
        lda bSoundFlags,b
        and #$AF
        sta bSoundFlags,b
        rep #$20
        bra _BFAD


        _BFAD
        plp
        plb
        .databank $87
        rtl

        .databank 0

        ; 87/BFB0

      rlUnknown87BFB0 ; 87/BFB0

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        lda wOptionSettings,b
        and #$0200
        xba
        lsr a
        plp
        plb
        .databank $87
        rtl

        .databank 0

        ; 87/BFBF

    .endsection Unsorted87BF6FSection


    .section Unsorted87BFBFSection

      .al
      .xl

      rlUnknown87BFBF ; 87/BFBF

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        ora #$0000
        bne _BFD0
        lda #$0200
        trb wOptionSettings,b
        bra _BFD6


        _BFD0
        lda #$0200
        tsb wOptionSettings,b

        _BFD6
        plp
        plb
        .databank $87
        rtl

        .databank 0

        ; 87/BFD9

    .endsection Unsorted87BFBFSection


    .section Unsorted87BFD9Section

      .al
      .xl

      rlUnknown87BFD9 ; 87/BFD9

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        lda wOptionSettings,b
        and #$0C00
        xba
        lsr a
        lsr a
        plp
        plb
        .databank $87
        rtl

        .databank 0

        ; 87/BFE9

    .endsection Unsorted87BFD9Section


    .section Unsorted87BFE9Section

      .al
      .xl

      rlUnknown87BFE9 ; 87/BFE9

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        and #$0003
        xba
        asl a
        asl a
        sta wR0
        lda wOptionSettings,b
        and #$F3FF
        ora wR0
        sta wOptionSettings,b
        plp
        plb
        .databank $87
        rtl

        .databank 0

        ; 87/C003

    .endsection Unsorted87BFE9Section


    .section Unsorted87C015Section

      .al
      .xl

      rlUnknown87C015 ; 87/C015

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        ora #$0000
        bne _C026
        lda #$1000
        trb wOptionSettings,b
        bra _C02C


        _C026
        lda #$1000
        tsb wOptionSettings,b

        _C02C
        plp
        plb
        .databank $87
        rtl

        .databank 0

        ; 87/C02F

    .endsection Unsorted87C015Section


    .section Unsorted87C02FSection

      .al
      .xl

      rlUnknown87C02F ; 87/C02F

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        lda wOptionSettings,b
        and #$0001
        plp
        plb
        .databank $87
        rtl

        .databank 0

        ; 87/C03C

    .endsection Unsorted87C02FSection


    .section Unsorted87C03CSection

      .al
      .xl

      rlUnknown87C03C ; 87/C03C

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        ora #$0000
        bne _C04D
        lda #$0001
        trb wOptionSettings,b
        bra _C053


        _C04D
        lda #$0001
        tsb wOptionSettings,b

        _C053
        plp
        plb
        .databank $87
        rtl

        .databank 0

        ; 87/C056

    .endsection Unsorted87C03CSection


    .section Unsorted87C056Section

      .al
      .xl

      procUnknown87C056 ; 87/C056

        .structProcInfo "TF", rlProcUnknown87C056Init, rlProcUnknown87C056Cycle, aProcUnknown87C056Code

      rlProcUnknown87C056Init ; 87/C05E

        .al
        .autsiz
        .databank ?

        ; wInput0 = LocationID
        ; wInput1 = old owner
        ; wInput2 = new owner

        lda aProcSystem.wInput0,b
        sta aProcSystem.aBody0,b,x
        lda aProcSystem.wInput1,b
        sta aProcSystem.aBody1,b,x
        lda aProcSystem.wInput2,b
        sta aProcSystem.aBody2,b,x
        lda #0
        sta aProcSystem.aBody3,b,x
        sta aProcSystem.aBody4,b,x
        jsl rlUnknown87C11D
        bcs +

          lda #<>aProcUnknown87C056Code._C23A
          sta aProcSystem.aHeaderCodeOffset,b,x
          lda #1
          sta aProcSystem.aHeaderSleepTimer,b,x
          bra ++

        +
        lda aProcSystem.aBody1,b,x
        jsl rlUnknown87C141
        cmp #0
        bne +

          lda #<>aProcUnknown87C056Code._C235
          sta aProcSystem.aHeaderCodeOffset,b,x
          lda #1
          sta aProcSystem.aHeaderSleepTimer,b,x

        +
        stz wGameStateRoutine1,b
        rtl

        .databank 0

      rlProcUnknown87C056Cycle ; 87/C0A9

        .al
        .autsiz
        .databank ?

        rtl

        .databank 0

    .endsection Unsorted87C056Section


    .section Unsorted87C38CSection

      aHDMAUnknown87C38C ; 87/C38C

        ; Created by rlUnknown81B32C. Writes WH0 indirectly from the buffer at
        ; $7E8B92, which rsUnknown87C442 fills from aUnknown87C4B2.
        .structHDMAIndirectEntryInfo rlUnknown87C398, rlUnknown87C3C4, aHDMAUnknown87C38CCode, aHDMAUnknown87C38CTableEven, WH0, DMAP_HDMA_Setting(DMAP_CPUToIO, true, DMAP_Mode0), $7E

      .al
      .xl

      rlUnknown87C398 ; 87/C398

        .al
        .xl
        .autsiz
        .databank ?

        lda #$FFE0
        sta $7E8B88
        lda #$0000
        sta $7E8B8A
        lda #$0010
        sta $7E8B8C
        lda #$0000
        sta $7E8B90
        jsr rsUnknown87C47A
        lda #$0000
        jsr rsUnknown87C442
        lda #$0064
        jsr rsUnknown87C442
        rtl

        .databank 0

        ; 87/C3C4

      rlUnknown87C3C4 ; 87/C3C4

        .al
        .xl
        .autsiz
        .databank ?

        lda wVBlankEnabledFramecount
        bit #$0001
        bne _C3D7
        lda #$0000
        sta $7E8B8E
        lda #<>aHDMAUnknown87C38CTableEven
        bra _C3E1


        _C3D7
        lda #$0100
        sta $7E8B8E
        lda #<>aHDMAUnknown87C38CTableOdd

        _C3E1
        sta aHDMASystem.aOffset,b,x
        lda $7E8B8E
        jsr rsUnknown87C442
        lda $7E8B8A
        clc
        adc #$4000
        sta $7E8B8A
        lda $7E8B8C
        adc #$0000
        sta $7E8B8C
        lda $7E8B88
        clc
        adc $7E8B8C
        sta $7E8B88
        cmp #$0100
        bmi _C41A
        lda #<>rlUnknown87C41B
        sta aHDMASystem.aOnCycle,b,x

        _C41A
        rtl

        .databank 0

        ; 87/C41B

    .endsection Unsorted87C38CSection


    .section Unsorted87C41BSection

      .al
      .xl

      rlUnknown87C41B ; 87/C41B

        .al
        .xl
        .autsiz
        .databank ?

        lda wMusicID,b
        bne _C43F
        lda bAPUStatus,b
        bit #$0030
        bne _C43F
        lda #<>rsOpenBattleScene
        sta wMainLoopPointer
        sei
        sep #$20
        lda bBufferNMITIMEN
        and #$CF
        sta bBufferNMITIMEN
        sta $4200,b
        rep #$20
        jsl rlHDMAEngineFreeEntryByOffset

        _C43F
        rtl

        .databank 0

      aHDMAUnknown87C38CCode ; 87/C440

        HDMA_HALT

        ; 87/C442

    .endsection Unsorted87C41BSection


    .section Unsorted87C442Section

      .al
      .xl

      rsUnknown87C442 ; 87/C442

        .al
        .xl
        .autsiz
        .databank ?

        phx
        clc
        adc #$00EF
        tax
        ldy #$00EF

        _C44B
        lda <>aUnknown87C4B2,b,y
        and #$00FF
        clc
        adc $7E8B88
        cmp #$0008
        bmi _C465
        cmp #$00F8
        bcc _C468
        lda #$00F8
        bra _C468


        _C465
        lda #$0008

        _C468
        sep #$20
        eor $7E8B90
        sta $7E8B92,x
        rep #$20
        dec x
        dec y
        bpl _C44B
        plx
        rts

        .databank 0

        ; 87/C47A

      rsUnknown87C47A ; 87/C47A

        .al
        .xl
        .autsiz
        .databank ?

        lda wBattleStatus
        bit #$0001
        bne _C49C
        lda #$006D
        jsl rlPlaySoundEffect2
        lda #$00FF
        sta $7E8B90
        sep #$20
        lda #$27
        sta $1670,b,x
        rep #$20
        bra _C4A3


        _C49C
        lda #$006C
        jsl rlPlaySoundEffect2

        _C4A3
        rts

        .databank 0

      aHDMAUnknown87C38CTableEven ; 87/C4A4

        ; Indirect HDMA tables: 120 lines from each address in bank $7E.
        ; rlUnknown87C3C4 switches between them every frame.
        .byte $F8
        .word $8B92
        .byte $F8
        .word $8C0A
        .byte $00

      aHDMAUnknown87C38CTableOdd ; 87/C4AB

        .byte $F8
        .word $8C92
        .byte $F8
        .word $8D0A
        .byte $00

      aUnknown87C4B2 ; 87/C4B2

        ; 240 offsets, one per line, that rsUnknown87C442 adds to $7E8B88.
        .byte $02, $03, $05, $07, $05, $03, $04, $05, $08, $06, $0A, $0C, $0A, $08, $04, $05
        .byte $06, $09, $0B, $0D, $0F, $12, $10, $0C, $0E, $0F, $0E, $0A, $0A, $0E, $10, $12
        .byte $0E, $0C, $08, $04, $03, $01, $00, $00, $04, $07, $0A, $0D, $0A, $08, $06, $06
        .byte $0A, $0E, $0F, $0C, $0A, $09, $0D, $10, $13, $11, $0D, $0A, $09, $08, $0C, $10
        .byte $14, $18, $13, $0E, $09, $06, $07, $09, $0A, $08, $0C, $0E, $12, $0E, $10, $14
        .byte $18, $12, $14, $16, $18, $1C, $19, $17, $15, $12, $17, $1B, $16, $12, $0E, $0A
        .byte $08, $06, $04, $08, $0A, $07, $03, $00, $02, $04, $08, $0C, $0A, $08, $0A, $0E
        .byte $0C, $0E, $10, $0C, $0A, $08, $0C, $10, $0E, $0C, $0A, $06, $04, $08, $06, $02
        .byte $04, $08, $0A, $06, $02, $00, $02, $04, $01, $03, $05, $04, $01, $00, $02, $06
        .byte $0A, $0E, $0C, $0D, $10, $0C, $08, $04, $02, $00, $03, $05, $07, $05, $03, $06
        .byte $09, $0C, $10, $14, $12, $0E, $0A, $06, $0A, $06, $0C, $10, $0C, $08, $04, $08
        .byte $06, $0A, $0C, $0A, $0E, $0C, $12, $10, $11, $0F, $0B, $07, $0A, $07, $0C, $11
        .byte $0E, $0B, $08, $03, $00, $02, $03, $05, $04, $07, $0A, $0E, $10, $0C, $10, $0C
        .byte $12, $0E, $10, $0C, $0A, $06, $02, $06, $0A, $08, $06, $0A, $0E, $0B, $0D, $0B
        .byte $07, $03, $02, $01, $00, $02, $03, $05, $07, $05, $03, $04, $05, $08, $0A, $04

      procUnknown87C5A2 ; 87/C5A2

        .structProcInfo "GO", rlUnknown87C5AA, rlUnknown87C646, aProcUnknown87C5A2Code

        ; 87/C5AA

    .endsection Unsorted87C442Section


    .section Unsorted87C5AASection

      .al
      .xl

      rlUnknown87C5AA ; 87/C5AA

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aUnknown87C5BF)<<8
        sta lR19+1
        lda #<>aUnknown87C5BF
        sta lR19
        jsl rlApplyMapMenuPaletteData
        lda #$0072
        sta wMusicID,b
        rtl

        .databank 0

        ; 87/C5BF

    .endsection Unsorted87C5AASection


    .section Table87C5BFSection

      .al
      .xl

      aUnknown87C5BF .dstruct structMapMenuPaletteData, $0040, 0, 0, aUnknown87C5C6 ; 87/C5BF

      aUnknown87C5C6 ; 87/C5C6
        .word $0000, $1CE7, $1DFE, $02FD, $03BC, $3BBD, $63BD, $77FF
        .word $7FFF, $63FB, $0955, $01B1, $0272, $42B5, $0C63, $35AD
        .word $3000, $1042, $1463, $1463, $1463, $1463, $1463, $1463
        .word $1463, $1463, $1463, $1463, $1463, $1463, $0C63, $1463
        .word $3000, $1CE7, $0C63, $2E4F, $3229, $25A7, $63BD, $77FF
        .word $7FFF, $639B, $5F7A, $5337, $4715, $4AEF, $3A4C, $35AD
        .word $7FFF, $1042, $0C63, $1463, $1463, $1463, $1463, $1463
        .word $1463, $1463, $1463, $1463, $1463, $1463, $1463, $1463

    .endsection Table87C5BFSection


    .section Unsorted87C646Section

      .al
      .xl

      rlUnknown87C646 ; 87/C646

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown87C6AA
        lda bBufferINIDISP
        bit #$0080
        bne _C65F
        eor #$FFFF
        bit #$000F
        bne _C65F
        lda wJoy1New
        bit #$1000
        bne _C660

        _C65F
        rtl


        _C660
        jsl rlProcEngineFreeProc
        sep #$20
        lda #$80
        sta $2100,b
        lda #$01
        sta $4200,b
        sta bBufferNMITIMEN
        stz bDMAPendingChannels,b
        stz bHDMAPendingChannels,b
        stz bBufferHDMAEN
        stz bDMAArrayFlag,b
        rep #$20
        stz wDMAArrayPosition,b
        jml rlSoftReset

        .databank 0

      aProcUnknown87C5A2Code ; 87/C686

        PROC_YIELD 32
        PROC_CALL rlUnknown87C695
        PROC_YIELD 1020
        PROC_SET_ONCYCLE rlUnknown87C646._C660
        PROC_HALT

        ; 87/C695

    .endsection Unsorted87C646Section


    .section Unsorted87C695Section

      .al
      .xl

      rlUnknown87C695 ; 87/C695

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0006
        sta wScreenFadingProcInput,b
        lda #(`procFadeInByScreenFadingTimer)<<8
        sta lR44+1
        lda #<>procFadeInByScreenFadingTimer
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 87/C6AA

      rsUnknown87C6AA ; 87/C6AA

        .al
        .xl
        .autsiz
        .databank ?

        phy
        txy
        lda aProcSystem.aBody0,b,x
        bmi _C6DA
        sec
        sbc #$0084
        bcc _C6D7
        phx
        asl a
        tax
        lda $C6DC,b,x
        bne _C6C6
        dec a
        sta aProcSystem.aBody0,b,y
        plx
        bra _C6DA


        _C6C6
        lda $C6DC,b,x
        ora #$FF80
        sta wBufferBG2HOFS
        lda $C6DD,b,x
        ora #$FF80
        sta wBufferBG2VOFS
        plx

        _C6D7
        inc aProcSystem.aBody0,b,x

        _C6DA
        ply
        rts

        .databank 0

        ; 87/C6DC

    .endsection Unsorted87C695Section


    .section Unsorted87C70ASection

      .al
      .xl

      procUnknown87C70A ; 87/C70A

        .structProcInfo "RP", rlUnknown87C712, rlUnknown87C7B4, aProcUnknown87C70ACode

    .endsection Unsorted87C70ASection


    .section Unsorted87C712Section

      .al
      .xl

      rlUnknown87C712 ; 87/C712

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.wInput0,b
        sta aProcSystem.aBody0,b,x
        lda #(`aUnknown87C784)<<8
        sta lR19+1
        lda #<>aUnknown87C784
        sta lR19
        jsl rlApplyMapMenuPaletteData
        lda #(`gcUnknownC0365A)<<8
        sta lR18+1
        lda #<>gcUnknownC0365A
        sta lR18
        lda #$7E00
        sta lR19+1
        lda #$EB88
        sta lR19
        jsl rlAppendDecompList
        stz wUnknown053C,b
        lda #$2370
        sta aCurrentTilemapInfo,b
        lda #(`aUnknown87C7AB)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aUnknown87C7AB
        sta lMapMenuTilemapRAMEntryPointer,b
        jsl rlUnknown878B98
        lda aProcSystem.aBody0,b,x
        bne _C761
        jsr rsUnknown87C821
        bra _C764


        _C761
        jsr rsUnknown87C87A

        _C764
        jsl rlDMAByStruct

          .structDMAToVRAM $7E7B88, $0800, $80, $A800

        lda #$0000
        sta wBufferBG2HOFS
        lda #$0000
        sta wBufferBG2VOFS
        sep #$20
        lda #$15
        sta bBufferTM
        rep #$20
        rtl

        .databank 0

        ; 87/C784

    .endsection Unsorted87C712Section


    .section Table87C784Section

      .al
      .xl

      aUnknown87C784 .dstruct structMapMenuPaletteData, $0010, 0, 0, aUnknown87C78B ; 87/C784

      aUnknown87C78B ; 87/C78B
        .word $0000, $7FFF, $6739, $41F0, $292A, $1485, $0C43, $1919
        .word $10B2, $0C49, $375F, $0000, $0000, $0000, $0000, $0000

      aUnknown87C7AB ; 87/C7AB
        .byte $20, $20, $88, $7B, $7E, $00, $88, $7B, $7E

    .endsection Table87C784Section


    .section Unsorted87C7B4Section

      .al
      .xl

      rlUnknown87C7B4 ; 87/C7B4

        .al
        .xl
        .autsiz
        .databank ?

        lda bDecompressionArrayFlag,b
        bne _C7CE
        phx
        jsl rlDMAByStruct

          .structDMAToVRAM $7EEB88, $0E00, $80, $7000

        plx
        lda #<>rlUnknown87C7CF
        sta aProcSystem.aHeaderOnCycle,b,x

        _C7CE
        rtl

        .databank 0

        ; 87/C7CF

      rlUnknown87C7CF ; 87/C7CF

        .al
        .xl
        .autsiz
        .databank ?

        lda #aUnknown87C91D >> 8
        sta lR44+1
        lda aProcSystem.aBody0,b,x
        bne _C7DE
        lda #<>aUnknown87C91D
        bra _C7E1


        _C7DE
        lda #<>aUnknown87CB47

        _C7E1
        sta lR44
        lda #$0001
        sta wR40
        jsl rlHDMAEngineCreateEntryByIndex
        lda #<>rlUnknown87C7F3
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 87/C7F3

    .endsection Unsorted87C7B4Section


    .section Unsorted87C7F3Section

      .al
      .xl

      rlUnknown87C7F3 ; 87/C7F3

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda $1611,b
        bit #$0001
        beq _C81E
        phx
        lda #(`aUnknown87C7AB)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aUnknown87C7AB
        sta lMapMenuTilemapRAMEntryPointer,b
        jsl rlUnknown878B98
        jsl rlDMAByStruct

          .structDMAToVRAM $7E7B88, $0800, $80, $A800

        plx
        jsl rlProcEngineFreeProc

        _C81E
        rtl

        .databank 0

        ; 87/C81F

    .endsection Unsorted87C7F3Section


    .section Unsorted87C81FSection

      .al
      .xl

      aProcUnknown87C70ACode ; 87/C81F

        PROC_HALT


        ; 87/C821

    .endsection Unsorted87C81FSection


    .section Unsorted87C821Section

      .al
      .xl

      rsUnknown87C821 ; 87/C821

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aUnknown87C866)<<8
        sta lR18+1
        lda #<>aUnknown87C866
        sta lR18
        ldx #$000F
        jsl rlUnknown878F6E
        lda #(`aUnknown87C86B)<<8
        sta lR18+1
        lda #<>aUnknown87C86B
        sta lR18
        ldx #$010F
        jsl rlUnknown878F6E
        lda #(`aUnknown87C870)<<8
        sta lR18+1
        lda #<>aUnknown87C870
        sta lR18
        ldx #$020F
        jsl rlUnknown878F6E
        lda #(`aUnknown87C875)<<8
        sta lR18+1
        lda #<>aUnknown87C875
        sta lR18
        ldx #$030F
        jsl rlUnknown878F6E
        rts

        .databank 0

        ; 87/C866

    .endsection Unsorted87C821Section


    .section Table87C866Section

      .al
      .xl

      aUnknown87C866 ; 87/C866
        .byte $10, $11, $12, $13, $00

      aUnknown87C86B ; 87/C86B
        .byte $20, $21, $22, $23, $00

      aUnknown87C870 ; 87/C870
        .byte $30, $31, $32, $33, $00

      aUnknown87C875 ; 87/C875
        .byte $40, $41, $42, $43, $00

    .endsection Table87C866Section


    .section Unsorted87C87ASection

      .al
      .xl

      rsUnknown87C87A ; 87/C87A

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aUnknown87C8E1)<<8
        sta lR18+1
        lda #<>aUnknown87C8E1
        sta lR18
        ldx #$000C
        jsl rlUnknown878F6E
        lda #(`aUnknown87C8EB)<<8
        sta lR18+1
        lda #<>aUnknown87C8EB
        sta lR18
        ldx #$010C
        jsl rlUnknown878F6E
        lda #(`aUnknown87C8F5)<<8
        sta lR18+1
        lda #<>aUnknown87C8F5
        sta lR18
        ldx #$020C
        jsl rlUnknown878F6E
        lda #(`aUnknown87C8FF)<<8
        sta lR18+1
        lda #<>aUnknown87C8FF
        sta lR18
        ldx #$030C
        jsl rlUnknown878F6E
        lda #(`aUnknown87C909)<<8
        sta lR18+1
        lda #<>aUnknown87C909
        sta lR18
        ldx #$040C
        jsl rlUnknown878F6E
        lda #(`aUnknown87C913)<<8
        sta lR18+1
        lda #<>aUnknown87C913
        sta lR18
        ldx #$050C
        jsl rlUnknown878F6E
        rts

        .databank 0

        ; 87/C8E1

    .endsection Unsorted87C87ASection


    .section Table87C8E1Section

      .al
      .xl

      aUnknown87C8E1 ; 87/C8E1
        .byte $14, $15, $16, $17, $18, $19, $1A, $1B, $1C, $00

      aUnknown87C8EB ; 87/C8EB
        .byte $24, $25, $26, $27, $28, $29, $2A, $2B, $2C, $00

      aUnknown87C8F5 ; 87/C8F5
        .byte $34, $35, $36, $37, $38, $39, $3A, $3B, $3C, $00

      aUnknown87C8FF ; 87/C8FF
        .byte $44, $45, $46, $47, $48, $49, $4A, $4B, $4C, $00

      aUnknown87C909 ; 87/C909
        .byte $54, $55, $56, $57, $58, $59, $5A, $5B, $5C, $00

      aUnknown87C913 ; 87/C913
        .byte $64, $65, $66, $67, $68, $69, $6A, $6B, $6C, $00

      aUnknown87C91D .dstruct structHDMAIndirectEntryInfo, rsUnknown87C929, rsUnknown87C989, aUnknown87C9C3, $7EEBEC, PPU_REG_BASE + $10, $42, $7E ; 87/C91D

      rsUnknown87C929 ; 87/C929

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0062
        lda #$008D

        _C92F
        sta $7EEB88,x
        dec x
        dec x
        bpl _C92F
        lda #$0000
        sta $7EF02C
        sta $7EF02E
        sta $7EF032
        lda #$0003
        sta $7EF030
        lda #$0001
        sta $7EF034
        lda #$8700
        sta $7EF037
        lda #$C96B
        sta $7EF036
        sep #$20
        lda #$17
        sta bBufferTM
        rep #$20
        rtl

        .databank 0

        ; 87/C96B

      aUnknown87C96B ; 87/C96B
        .byte $00, $0C, $00, $01, $00, $0A, $00, $01, $00, $08, $00, $01, $00, $06, $00, $01
        .byte $00, $04, $00, $01, $00, $02, $00, $01, $00, $01, $00, $20, $FF, $FF

      rsUnknown87C989 ; 87/C989

        .al
        .xl
        .autsiz
        .databank ?

        lda wVBlankEnabledFramecount
        bit #$0001
        bne _C99C
        lda #$0000
        sta $7EF02C
        lda #$EBEC
        bra _C9A6


        _C99C
        lda #$0200
        sta $7EF02C
        lda #$EC0C

        _C9A6
        sta aHDMASystem.aOffset,b,x
        lda wVBlankEnabledFramecount
        and $7EF034
        bne _C9B7
        jsr rsUnknown87C9CF
        jsr rsUnknown87CA4E

        _C9B7
        jsr rsUnknown87CA92
        lda $7EF02C
        tax
        jsr rsUnknown87CAF4
        rtl

        .databank 0

        ; 87/C9C3

      aUnknown87C9C3 ; 87/C9C3
        HDMA_SLEEP 1
        HDMA_JUMP_IF_BITS_UNSET aUnknown87C9C3, 1
        HDMA_END

      rsUnknown87C9CF ; 87/C9CF

        .al
        .xl
        .autsiz
        .databank ?

        phb
        phy
        lda $7EF030
        dec a
        sta $7EF030
        bne _CA38
        sep #$20
        lda $7EF038
        pha
        rep #$20
        plb
        .databank ?
        lda $7EF02E
        asl a
        asl a
        clc
        adc $7EF036
        tay
        lda $0000,b,y
        cmp #$FFFF
        beq _CA3B
        lda $0000,b,y
        and #$00FF
        sta $7EF032
        bne _CA19
        lda $7EEB88
        sec
        sbc $0001,b,y
        bpl _CA13
        lda #$0000

        _CA13
        sta $7EEB88
        bra _CA25


        _CA19
        lda $7EEBEA
        clc
        adc $0001,b,y
        sta $7EEBEA

        _CA25
        lda $0003,b,y
        and #$00FF
        sta $7EF030
        lda $7EF02E
        inc a
        sta $7EF02E

        _CA38
        ply
        plb
        .databank ?
        rts


        _CA3B
        sep #$20
        lda #$15
        sta bBufferTM
        rep #$20
        lda aHDMASystem.aBitfield,b,x
        ora #$0001
        sta aHDMASystem.aBitfield,b,x
        bra _CA38

        .databank 0

        ; 87/CA4E

      rsUnknown87CA4E ; 87/CA4E

        .al
        .xl
        .autsiz
        .databank ?

        lda $7EF032
        bne _CA73
        ldx #$0062

        _CA57
        lda $7EEB86,x
        inc a
        cmp $7EEB88,x
        beq _CA6D
        lda $7EEB86,x
        beq _CA69
        inc a

        _CA69
        sta $7EEB88,x

        _CA6D
        dec x
        dec x
        bne _CA57
        bra _CA91


        _CA73
        ldx #$0000

        _CA76
        lda $7EEB8A,x
        dec a
        cmp $7EEB88,x
        beq _CA8A
        lda $7EEB8A,x
        dec a
        sta $7EEB88,x

        _CA8A
        inc x
        inc x
        cpx #$0062
        bcc _CA76

        _CA91
        rts

        .databank 0

        ; 87/CA92

      rsUnknown87CA92 ; 87/CA92

        .al
        .xl
        .autsiz
        .databank ?

        lda #$7EEB
        sta lR18+1
        lda $7EF02C
        bne _CAA2
        lda #$EBEC
        bra _CAA5


        _CAA2
        lda #$EC0C

        _CAA5
        sta lR18
        lda $7EEB88
        dec a
        beq _CACA
        bmi _CACA
        sta wR10
        lda #$EC2C
        clc
        adc $7EF02C
        sta wR11
        lda #$0000
        sta wR12
        lda #$0000
        sta wR13
        jsl rlBuildHDMADirectTableEntries

        _CACA
        lda $7EEBEA
        sec
        sbc $7EEB88
        inc a
        sta wR10
        lda #$EC2E
        clc
        adc $7EF02C
        sta wR11
        lda #$0080
        sta wR12
        lda #$00F0
        sta wR13
        jsl rlBuildHDMADirectTableEntries
        lda #$0000
        sta [lR18]
        rts

        .databank 0

        ; 87/CAF4

      rsUnknown87CAF4 ; 87/CAF4

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
        lda #$0030
        sta @l $7EEC2C,x
        inc x
        inc x
        ldy #$0000

        _CB0B
        tya
        lsr a
        sec
        sbc $EB88,b,y
        sta wR2
        lda $EB88,b,y
        sta wR0
        lda $EB8A,b,y
        sta wR1
        lda wR0
        cmp wR1
        bcs _CB35

        _CB23
        lda wR2
        sta @l $7EEC2C,x
        inc x
        inc x
        dec wR2
        inc wR0
        lda wR0
        cmp wR1
        bcc _CB23

        _CB35
        inc y
        inc y
        cpy #$0062
        bcc _CB0B
        lda #$0000
        sta @l $7EEC2C,x
        plx
        plp
        plb
        .databank ?
        rts

        .databank 0

        ; 87/CB47

      aUnknown87CB47 .dstruct structHDMAIndirectEntryInfo, rsUnknown87CB53, rsUnknown87C989, aUnknown87C9C3, $7EEBEC, PPU_REG_BASE + $10, $42, $7E ; 87/CB47

      rsUnknown87CB53 ; 87/CB53

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0062
        lda #$0071

        _CB59
        sta $7EEB88,x
        dec a
        dec x
        dec x
        bpl _CB59
        lda #$0000
        sta $7EF02C
        sta $7EF02E
        sta $7EF032
        lda #$0001
        sta $7EF034
        lda #$0001
        sta $7EF030
        lda #$8700
        sta $7EF037
        lda #$CB9B
        sta $7EF036
        lda #$FFFD
        sta wBufferBG2HOFS
        sep #$20
        lda #$17
        sta bBufferTM
        rep #$20
        rtl

        .databank 0

        ; 87/CB9B

      aUnknown87CB9B ; 87/CB9B
        .byte $00, $01, $00, $01, $00, $02, $00, $01, $00, $04, $00, $01, $00, $06, $00, $01
        .byte $00, $08, $00, $01, $00, $0A, $00, $01, $00, $0C, $00, $01, $00, $0E, $00, $01
        .byte $00, $10, $00, $01, $00, $00, $00, $27, $FF, $FF

    .endsection Table87C8E1Section


    .section Unsorted87CBC5Section

      .al
      .xl

      rlUnknown87CBC5 ; 87/CBC5

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 87/CBC6

    .endsection Unsorted87CBC5Section


    .section Unsorted87D65ASection

      .al
      .xl

      rsUnknown87D65A ; 87/D65A

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ldx #$000A
        lda #$FFFF

        _D660
        sta $EC48,b,x
        dec x
        dec x
        bpl _D660
        lda wAITargetCounter
        bne _D671
        jml _D710


        _D671
        tay
        ldx #$0000

        _D675
        phx
        stz $441C,b
        stx $442A,b
        lda $7E5029,x
        and #$00FF
        tax
        lda aDeploymentTable._UnitRAMPointer,x
        beq _D702
        lda aDeploymentTable,x
        bit #$0020
        bne _D702
        jsr rsCheckIfAITargetWithinSpecifiedLeaderRange
        bcc _D702
        jsl rlAIGetClassTargetPriority
        clc
        adc $441C,b
        sta $441C,b
        lda $443C,b
        bmi _D6D3
        sta @l wAITemp000E98
        txa
        sta @l wAITemp000E96
        jsl rlAIGetWeaponTriangleScore
        clc
        adc $441C,b
        sta $441C,b
        lda $443C,b
        sta @l wAITemp000E98
        txa
        sta @l wAITemp000E96
        jsl rlAIGetEffectivenessScore
        clc
        adc $441C,b
        sta $441C,b

        _D6D3
        plx
        phx
        ldx #$0000

        _D6D8
        lda $441C,b
        cmp $EC48,b,x
        bmi _D6F9
        pha
        lda $EC48,b,x
        sta $441C,b
        pla
        sta $EC48,b,x
        lda $442A,b
        pha
        lda $EC4A,b,x
        sta $442A,b
        pla
        sta $EC4A,b,x

        _D6F9
        inc x
        inc x
        inc x
        inc x
        cpx #$000A
        bcc _D6D8

        _D702
        plx
        txa
        clc
        adc #$000D
        tax
        dec y
        beq _D710
        jml _D675


        _D710
        rts

        .databank 0

        ; 87/D711

    .endsection Unsorted87D65ASection


    .section Unsorted87E6D3Section

      .al
      .xl

      rsUnknown87E6D3 ; 87/E6D3

        .al
        .xl
        .autsiz
        .databank ?

        clc
        rts

        .databank 0

        ; 87/E6D5

    .endsection Unsorted87E6D3Section


    .section Unsorted87E6D7Section

      .al
      .xl

      rsUnknown87E6D7 ; 87/E6D7

        .al
        .xl
        .autsiz
        .databank ?

        lda wUnknown000D79,b
        bit #$0020
        bne rsUnknown87E6D3

      rsUnknown87E6DF ; 87/E6DF

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0008
        bra rsUnknown87E6FE

      rsUnknown87E6E4 ; 87/E6E4

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0009
        bra rsUnknown87E6FE

      rsUnknown87E6E9 ; 87/E6E9

        .al
        .xl
        .autsiz
        .databank ?

        lda wUnknown000D79,b
        bit #$0020
        bne rsUnknown87E6D3

      rsUnknown87E6F1 ; 87/E6F1

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0002
        bra rsUnknown87E6FE

      rsUnknown87E6F6 ; 87/E6F6

        .al
        .xl
        .autsiz
        .databank ?

        lda #$000C
        bra rsUnknown87E6FE

      rsUnknown87E6FB ; 87/E6FB

        .al
        .xl
        .autsiz
        .databank ?

        lda #$000D

      rsUnknown87E6FE ; 87/E6FE

        .al
        .xl
        .autsiz
        .databank ?

        stz wR12
        jsl rlUnknown87E689
        rts

        .databank 0

        ; 87/E705

    .endsection Unsorted87E6D7Section


    .section Unsorted87E705Section

      .al
      .xl

      rsUnknown87E705 ; 87/E705

        .al
        .xl
        .autsiz
        .databank ?

        clc
        rts

        .databank 0

        ; 87/E707

    .endsection Unsorted87E705Section


    .section Unsorted87E707Section

      .al
      .xl

      rsUnknown87E707 ; 87/E707

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

      rlUnknown87E709 ; 87/E709

        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsl rlGetItemStaffEffect
        asl a
        tax
        jsr (aUnknown87E715,x)
        plx
        rtl

        .databank 0

        ; 87/E715

    .endsection Unsorted87E709Section


    .section Table87E715Section

      .al
      .xl

      aUnknown87E715 ; 87/E715

        ; Jump table of rlUnknown87E709.
        .word <>rsUnknown87E75F
        .word <>rsUnknown87E737
        .word <>rsUnknown87E737
        .word <>rsUnknown87E737
        .word <>rsUnknown87E737
        .word <>rsUnknown87E737
        .word <>rsUnknown87E75F
        .word <>rsUnknown87E741
        .word <>rsUnknown87E75F
        .word <>rsUnknown87E75F
        .word <>rsUnknown87E73C
        .word <>rsUnknown87E75D
        .word <>rsUnknown87E75F
        .word <>rsUnknown87E75F
        .word <>rsUnknown87E75F
        .word <>rsUnknown87E75F
        .word <>rsUnknown87E75F

    .endsection Table87E715Section


    .section Unsorted87E737Section

      .al
      .xl

      rsUnknown87E737 ; 87/E737

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0008
        bra rsUnknown87E741._E744

        .databank 0

        ; 87/E73C

      rsUnknown87E73C ; 87/E73C

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0009
        bra rsUnknown87E741._E744

        .databank 0

        ; 87/E741

      rsUnknown87E741 ; 87/E741

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0002

        _E744
        sta wRoutineVariable1,b
        lda wUnknown000D79,b
        bit #$0020
        beq rsUnknown87E75F
        lda $7E4E77
        cmp #$FFFF
        beq rsUnknown87E75F
        jsl rlBuildCastleTargetList
        rts

        .databank 0

        ; 87/E75D

      rsUnknown87E75D ; 87/E75D

        .al
        .xl
        .autsiz
        .databank ?

        sec
        rts

        .databank 0

        ; 87/E75F

      rsUnknown87E75F ; 87/E75F

        .al
        .xl
        .autsiz
        .databank ?

        clc
        rts

        .databank 0

        ; 87/E761

    .endsection Unsorted87E737Section


    .section Unsorted87E762Section

      .al
      .xl

      rlUnknown87E762 ; 87/E762

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$0800
        trb wUnknown000D79,b
        lda #$0001
        sta wR12
        jsl rlGetItemStaffEffect
        asl a
        tax
        jsr (aUnknown87E779,x)
        plx
        rtl

        .databank 0

        ; 87/E779

    .endsection Unsorted87E762Section


    .section Unsorted87E779Section

      .al
      .xl

      aUnknown87E779 ; 87/E779

        ; One handler per staff effect (rlGetItemStaffEffect). (tools/sweep.py had
        ; decoded this table as code.)
        .word <>rsUnknown87E79B
        .word <>rsUnknown87E7A6
        .word <>rsUnknown87E7A6
        .word <>rsUnknown87E7A6
        .word <>rsUnknown87E7A6
        .word <>rsUnknown87E7B5
        .word <>rsUnknown87E7B0
        .word <>rsUnknown87E79C
        .word <>rsUnknown87E7B0
        .word <>rsUnknown87E7AB
        .word <>rsUnknown87E7AB
        .word <>rsUnknown87E79B
        .word <>rsUnknown87E7D9
        .word <>rsUnknown87E7DE
        .word <>rsUnknown87E7DE
        .word <>rsUnknown87E7DE
        .word <>rsUnknown87E7E3


      rsUnknown87E79B ; 87/E79B

        .al
        .xl
        .autsiz
        .databank ?

        rts

        .databank 0

        ; 87/E79C

      rsUnknown87E79C ; 87/E79C

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0800
        tsb wUnknown000D79,b
        jml rsUnknown87E7B0

        .databank 0

        ; 87/E7A6

      rsUnknown87E7A6 ; 87/E7A6

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0008
        bra rsUnknown87E7E4

        .databank 0

        ; 87/E7AB

      rsUnknown87E7AB ; 87/E7AB

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0009
        bra rsUnknown87E7E4

        .databank 0

        ; 87/E7B0

      rsUnknown87E7B0 ; 87/E7B0

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0002
        bra rsUnknown87E7E4

        .databank 0

        ; 87/E7B5

      rsUnknown87E7B5 ; 87/E7B5

        .al
        .xl
        .autsiz
        .databank ?

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

      rsUnknown87E7D9 ; 87/E7D9

        .al
        .xl
        .autsiz
        .databank ?

        lda #$000C
        bra rsUnknown87E7E4

        .databank 0

        ; 87/E7DE

      rsUnknown87E7DE ; 87/E7DE

        .al
        .xl
        .autsiz
        .databank ?

        lda #$000D
        bra rsUnknown87E7E4

        .databank 0

        ; 87/E7E3

      rsUnknown87E7E3 ; 87/E7E3

        .al
        .xl
        .autsiz
        .databank ?

        rts

        .databank 0

        ; 87/E7E4

      rsUnknown87E7E4 ; 87/E7E4

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown87E689
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

      rlUnknown87E801 ; 87/E801

        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsl rlUnknown87E709
        jsl rlGetItemStaffEffect
        asl a
        tax
        jsr (aUnknown87E811,x)
        plx
        rtl

        .databank 0

        ; 87/E811

    .endsection Unsorted87E801Section


    .section Table87E811Section

      .al
      .xl

      aUnknown87E811 ; 87/E811

        ; Jump table of rlUnknown87E801.
        .word <>rsUnknown87E833
        .word <>rsUnknown87E834
        .word <>rsUnknown87E834
        .word <>rsUnknown87E834
        .word <>rsUnknown87E834
        .word <>rsUnknown87E84A
        .word <>rsUnknown87E833
        .word <>rsUnknown87E83F
        .word <>rsUnknown87E833
        .word <>rsUnknown87E833
        .word <>rsUnknown87E834
        .word <>rsUnknown87E855
        .word <>rsUnknown87E833
        .word <>rsUnknown87E833
        .word <>rsUnknown87E833
        .word <>rsUnknown87E833
        .word <>rsUnknown87E833

    .endsection Table87E811Section


    .section Unsorted87E833Section

      .al
      .xl

      rsUnknown87E833 ; 87/E833

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

      rsUnknown87E834 ; 87/E834

        .al
        .xl
        .autsiz
        .databank ?

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

      rsUnknown87E83F ; 87/E83F

        .al
        .xl
        .autsiz
        .databank ?

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

      rsUnknown87E84A ; 87/E84A

        .al
        .xl
        .autsiz
        .databank ?

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

      rsUnknown87E855 ; 87/E855

        .al
        .xl
        .autsiz
        .databank ?

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

      rlUnknown87E86A ; 87/E86A

        .al
        .xl
        .autsiz
        .databank ?

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

      rlUnknown87E89A ; 87/E89A

        .al
        .xl
        .autsiz
        .databank ?

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
        jsr rsUnknown87E8BB
        bra _E8B3


        _E8B0
        jsr rsUnknown87E913

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

      rsUnknown87E8BB ; 87/E8BB

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
        jsl rlUnknown87E689
        jsl rlUnknown87E86A
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

      rsUnknown87E913 ; 87/E913

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown87E86A
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

      rlUnknown87E93F ; 87/E93F

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$000F
        sep #$20
        lda #$00

        _E947
        sta aChapterLocationRAMData,x
        dec x
        bpl _E947
        rep #$20
        plx
        rtl

        .databank 0

        ; 87/E952

      rlUnknown87E952 ; 87/E952

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        phx
        phy
        jsl rlGetChapterLocationDataPointer
        tax
        lda $0000,b,x
        and #$00FF
        dec a
        tay

        _E965
        lda $0001,b,x
        sta wEventLocationEntry,b
        jsl rlUnknown87EBC8
        inc x
        inc x
        dec y
        bpl _E965
        ply
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 87/E979

      rlUnknown87E979 ; 87/E979

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        phx
        jsl rlGetChapterLocationDataPointer
        tax
        lda $0000,b,x
        and #$00FF
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 87/E98D

    .endsection Unsorted87E86ASection


    .section Unsorted87E9E0Section

      .al
      .xl

      rlUnknown87E9E0 ; 87/E9E0

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        phx
        ldx wR0
        phx
        sta wR0
        ldx #$0000

        _E9ED
        txa
        jsl rlGetLocationEventDataEntry
        bcs _E9FF
        jsl rlGetEventLocationEntryNameID
        cmp wR0
        beq _EA02
        inc x
        bra _E9ED


        _E9FF
        stz wEventLocationEntry,b

        _EA02
        pla
        sta wR0
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 87/EA09

    .endsection Unsorted87E9E0Section


    .section Unsorted87EA09Section

      .al
      .xl

      rlUnknown87EA09 ; 87/EA09

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        phx
        phy
        lda wR2
        pha
        jsl rlGetChapterLocationDataPointer
        tay
        lda $0000,b,y
        and #$00FF
        sta wR2

        _EA1F
        phy
        ldx $0001,b,y
        stx wEventLocationEntry,b
        txy
        jsl rlGetEventLocationEntryType
        asl a
        tax
        lda @l aEventLocationTypeOffsets,x
        tax
        sep #$20
        lda @l aEventLocationTypeOffsets+2,x
        clc
        adc $0003,b,y
        dec a
        cmp wR0
        bpl _EA69
        lda @l aEventLocationTypeOffsets+3,x
        clc
        adc $0004,b,y
        dec a
        cmp wR1
        bpl _EA69
        lda @l aEventLocationTypeOffsets+4,x
        clc
        adc $0003,b,y
        cmp wR0
        bmi _EA69
        lda @l aEventLocationTypeOffsets+5,x
        clc
        adc $0004,b,y
        cmp wR1
        bmi _EA69
        ply
        bra _EA7B


        _EA69
        rep #$20
        ply
        inc y
        inc y
        dec wR2
        bne _EA1F
        pla
        sta wR2
        ply
        plx
        plp
        plb
        .databank ?
        sec

        _EA7A
        rtl


        _EA7B
        .as
        rep #$20
        pla
        sta wR2
        ply
        plx
        plp
        plb
        .databank ?
        clc
        bra _EA7A

        .databank 0

        ; 87/EA87

    .endsection Unsorted87EA09Section


    .section Unsorted87EBC8Section

      .al
      .xl

      rlUnknown87EBC8 ; 87/EBC8

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        phy

        ldy wEventLocationEntry,b
        sep #$20
        lda lChapterEventDataPointer+2,b
        pha
        rep #$20
        plb

        lda structChapterLocationEntry.ID,b,y
        and #$00FF
        sta wR3
        asl a
        tax

        lda structChapterLocationEntry.Type,b,y
        and #$00FF
        jsl rlGetEventLocationTypeBaseMoney
        sta aChapterLocationMoneyRewards,x

        lda structChapterLocationEntry.Type,b,y
        and #$00FF
        cmp #LocationTypeCastle
        bne _End

          lda lChapterEventDataPointer+1,b
          sta lR18+1
          lda structChapterCastleLocationEntry.ShopDataPointer,b,y
          beq _End

            sta lR18

            ldx lR18
            sep #$20
            lda lR18+2
            pha
            rep #$20
            plb

            _Loop
            lda $0000,b,x
            cmp #$FFFF
            beq _End

              and #$00FF
              jsl rlGetItemRAMStructEntryByPlayerItemIndex
              jsl rlGetItemRAMStateAndOwner

              lda wR0
              cmp #ItemStateUnobtained
              bne _Next

                lda #ItemStateShop
                sta wR0
                lda wR3
                sta wR1
                jsl rlSetItemRAMStateAndOwner

              _Next
              inc x
              bra _Loop

        _End
        ply
        plx
        plp
        plb
        rtl

        .databank 0

        ; 87/EC42

    .endsection Unsorted87EBC8Section


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


    .section Unsorted87F321Section

      .al
      .xl

      rlUnknown87F321 ; 87/F321

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        phx
        lda wR2
        pha
        jsl rlGetEventLocationEntryID
        and #$0003
        asl a
        sta wR2
        jsl rlGetEventLocationMoneyReward
        sta wR13
        lda #$01F4
        sta wR14
        jsl rlUnsignedDivide16By16R13
        lda wR13
        cmp #$000A
        bcs _F35A
        ldx wR2
        lda @l aUnknown87F361,x
        clc
        adc wR13
        tax
        lda @l aUnknown87F361,x
        and #$00FF

        _F35A
        plx
        stx wR2
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 87/F361

    .endsection Unsorted87F321Section


    .section Table87F361Section

      .al
      .xl

      aUnknown87F361 ; 87/F361

        ; Read by rlUnknown87F321.

        .word $0008, $0012, $001C, $0026, $0000, $0202, $0303, $0505
        .word $0101, $0101, $0000, $0202, $0303, $0505, $0505, $0101
        .word $0000, $0202, $0303, $0303, $0505, $0101, $0000, $0202

        ; 87/F391

    .endsection Table87F361Section
