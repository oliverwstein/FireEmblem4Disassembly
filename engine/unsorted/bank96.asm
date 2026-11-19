; Code from bank $96 not yet assigned to a game system.

    .section Unsorted968008Section

      .al
      .xl

      rlUnknown968008 ; 96/8008

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown96892D
        rtl

        .databank 0

        ; 96/800D

    .endsection Unsorted968008Section


    .section Unsorted968017Section

      .al
      .xl

      rlUnknown968017 ; 96/8017

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda $7FE4C2
        and #$00FF
        cmp #$0004
        bcs _803F
        cmp #$0003
        bcs _8039
        cmp #$0002
        bcs _8033
        jsl rlUnknown968982
        bra _8043


        _8033
        jsl rlUnknown968BC2
        bra _8043


        _8039
        jsl rlUnknown968C97
        bra _8043


        _803F
        jsl rlUnknown968D22

        _8043
        sep #$20
        lda #$01
        sta $7FE1CF
        rep #$20
        rtl

        .databank 0

        ; 96/804E

    .endsection Unsorted968017Section


    .section Unsorted968058Section

      .al
      .xl

      rlUnknown968058 ; 96/8058

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda $7FE4C2
        and #$00FF
        cmp #$0003
        beq _806F
        cmp #$0001
        bne _8075
        jsl rlUnknown968A57
        bra _8075


        _806F
        jsl rlUnknown968DAA
        bra _8075


        _8075
        rtl

        .databank 0

        ; 96/8076

    .endsection Unsorted968058Section


    .section Unsorted968080Section

      .al
      .xl

      rlUnknown968080 ; 96/8080

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda $7FE4C2
        and #$00FF
        cmp #$0001
        bne _8092
        jsl rlUnknown968B16
        bra _8092


        _8092
        rtl

        .databank 0

        ; 96/8093

    .endsection Unsorted968080Section


    .section Unsorted96809DSection

      .al
      .xl

      rlUnknown96809D ; 96/809D

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown968943
        rtl

        .databank 0

        ; 96/80A2

    .endsection Unsorted96809DSection


    .section Unsorted9680ACSection

      .al
      .xl

      rlUnknown9680AC ; 96/80AC

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown9BEEB4
        rtl

        .databank 0

        ; 96/80B1

    .endsection Unsorted9680ACSection


    .section Unsorted9680BBSection

      .al
      .xl

      rlUnknown9680BB ; 96/80BB

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown9BEF88
        rtl

        .databank 0

        ; 96/80C0

    .endsection Unsorted9680BBSection


    .section Unsorted9680C2Section

      .al
      .xl

      rlUnknown9680C2 ; 96/80C2

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9680CC
        jsr rsUnknown9680F7
        jsr rsUnknown9680E9
        rtl

        .databank 0

        ; 96/80CC

      rsUnknown9680CC ; 96/80CC

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        rep #$10
        ldx #$0A2B
        stx DecompressionVariables
        lda #$C0
        sta $CA
        ldx #$8B88
        stx $CB
        lda #$7E
        sta $CD
        rep #$30
        jsl rlDecompressor
        rts

        .databank 0

        ; 96/80E9

      rsUnknown9680E9 ; 96/80E9

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlDMAByStruct

          .structDMAToVRAM $7EAC88, $0400, $80, $F800

        rts

        .databank 0

        ; 96/80F7

      rsUnknown9680F7 ; 96/80F7

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda $0D5E,b
        cmp #$0000
        beq _8128
        ldx #$0100
        jsl rlGetCharacterNamePointer
        jsr rsUnknown96815A
        jsr rsUnknown968179
        lda $0D60,b
        ldx #$0000
        cmp #$FFFF
        bne _811E
        jsr rsUnknown9682E8
        bra _8128


        _811E
        jsl rlGetItemNamePointerByItemID
        jsr rsUnknown96815A
        jsr rsUnknown9681B3

        _8128
        lda $0D50,b
        cmp #$0000
        beq _8157
        ldx #$0300
        jsl rlGetCharacterNamePointer
        jsr rsUnknown96815A
        jsr rsUnknown968196
        lda $0D52,b
        ldx #$0200
        cmp #$FFFF
        bne _814D
        jsr rsUnknown9682E8
        bra _8157


        _814D
        jsl rlGetItemNamePointerByItemID
        jsr rsUnknown96815A
        jsr rsUnknown9681D0

        _8157
        ply
        plx
        rts

        .databank 0

        ; 96/815A

      rsUnknown96815A ; 96/815A

        .al
        .xl
        .autsiz
        .databank ?

        phy
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldy #$0000

        _8168
        lda [lR18],y
        beq _8173
        inc y
        inc y
        cpy #$0010
        bcc _8168

        _8173
        tya
        lsr a
        sta wR0
        ply
        rts

        .databank 0

        ; 96/8179

      rsUnknown968179 ; 96/8179

        .al
        .xl
        .autsiz
        .databank ?

        pha
        lda #$0008
        sec
        sbc wR0
        beq _818A

        _8182
        pha
        jsr rsUnknown9682CD
        pla
        dec a
        bne _8182

        _818A
        lda wR0

        _818C
        pha
        jsr rsUnknown9681ED
        pla
        dec a
        bne _818C
        pla
        rts

        .databank 0

        ; 96/8196

      rsUnknown968196 ; 96/8196

        .al
        .xl
        .autsiz
        .databank ?

        pha
        lda wR0

        _8199
        pha
        jsr rsUnknown9681ED
        pla
        dec a
        bne _8199
        lda #$0008
        sec
        sbc wR0
        beq _81B1

        _81A9
        pha
        jsr rsUnknown9682CD
        pla
        dec a
        bne _81A9

        _81B1
        pla
        rts

        .databank 0

        ; 96/81B3

      rsUnknown9681B3 ; 96/81B3

        .al
        .xl
        .autsiz
        .databank ?

        pha
        lda #$0008
        sec
        sbc wR0
        beq _81C4

        _81BC
        pha
        jsr rsUnknown9682CD
        pla
        dec a
        bne _81BC

        _81C4
        lda wR0

        _81C6
        pha
        jsr rsUnknown96824C
        pla
        dec a
        bne _81C6
        pla
        rts

        .databank 0

        ; 96/81D0

      rsUnknown9681D0 ; 96/81D0

        .al
        .xl
        .autsiz
        .databank ?

        pha
        lda wR0

        _81D3
        pha
        jsr rsUnknown96824C
        pla
        dec a
        bne _81D3
        lda #$0008
        sec
        sbc wR0
        beq _81EB

        _81E3
        pha
        jsr rsUnknown9682CD
        pla
        dec a
        bne _81E3

        _81EB
        pla
        rts

        .databank 0

        ; 96/81ED

      rsUnknown9681ED ; 96/81ED

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phy
        ldy #$0000
        lda [lR18],y
        jsl rlUnknown879DD1
        lda #$7E00
        sta lR19+1
        lda wR10
        asl a
        asl a
        asl a
        asl a
        clc
        adc #$8B88
        sta lR19
        ldy #$0000

        _820C
        lda [lR19],y
        sta $7EAC88,x
        inc x
        inc x
        inc y
        inc y
        cpy #$0010
        bcc _820C
        phx
        lda wR11
        asl a
        asl a
        asl a
        asl a
        clc
        adc #$8B88
        sta lR19
        txa
        clc
        adc #$0070
        tax
        ldy #$0000

        _8231
        lda [lR19],y
        sta $7EAC88,x
        inc x
        inc x
        inc y
        inc y
        cpy #$0010
        bcc _8231
        plx
        lda lR18
        clc
        adc #$0002
        sta lR18
        ply
        pla
        rts

        .databank 0

        ; 96/824C

      rsUnknown96824C ; 96/824C

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phy
        ldy #$0000
        lda [lR18],y
        jsl rlUnknown879DD1
        lda #$7E00
        sta lR19+1
        lda wR10
        asl a
        asl a
        asl a
        asl a
        clc
        adc #$8B88
        sta lR19
        ldy #$0004

        _826B
        lda [lR19],y
        sta $7EAC88,x
        inc x
        inc x
        inc y
        inc y
        cpy #$0010
        bcc _826B
        lda wR11
        asl a
        asl a
        asl a
        asl a
        clc
        adc #$8B88
        sta lR19
        ldy #$0000
        lda [lR19],y
        sta $7EAC88,x
        ldy #$0002
        lda [lR19],y
        sta $7EAC8A,x
        txa
        clc
        adc #$0004
        pha
        txa
        clc
        adc #$0074
        tax
        ldy #$0004

        _82A7
        lda [lR19],y
        sta $7EAC88,x
        inc x
        inc x
        inc y
        inc y
        cpy #$0010
        bcc _82A7
        lda #$0000
        sta $7EAC88,x
        sta $7EAC8A,x
        plx
        lda lR18
        clc
        adc #$0002
        sta lR18
        ply
        pla
        rts

        .databank 0

        ; 96/82CD

      rsUnknown9682CD ; 96/82CD

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phy
        ldy #$0000
        lda #$0000

        _82D5
        sta $7EAC88,x
        sta $7EAD08,x
        inc x
        inc x
        inc y
        cpy #$0008
        bcc _82D5
        ply
        pla
        rts

        .databank 0

        ; 96/82E8

      rsUnknown9682E8 ; 96/82E8

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        phy
        lda #$0008

        _82EE
        jsr rsUnknown9682CD
        dec a
        bne _82EE
        ply
        plx
        pla
        rts

        .databank 0

        ; 96/82F8

      rlUnknown9682F8 ; 96/82F8

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta $7FED4E
        rtl

        .databank 0

        ; 96/8300

      rlUnknown968300 ; 96/8300

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda $0D4B,b
        beq _830C
        lda #$0000
        jsl rlUnknown96A4B2

        _830C
        rtl

        .databank 0

        ; 96/830D

      rlUnknown96830D ; 96/830D

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda $0D49,b
        and #$00FF
        xba
        sta $7FED4B
        lda $0D4B,b
        sta wR0
        jsl rlUnknown9594E0
        sta $7FED4E
        lda $0D49,b
        clc
        adc $0D4B,b
        sta $7FED50
        lda #$0191
        sta $7FED56
        lda #$3000
        sta $7FED58
        lda #$0BCE
        sta $7FED53
        sep #$20
        lda #$FF
        sta $7FED4D
        lda #$02
        sta $7FED52
        lda #$2C
        sta $7FED55
        rep #$20
        jsl rlUnknown9684AF
        rtl

        .databank 0

        ; 96/8360

      rlUnknown968360 ; 96/8360

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$000B
        jsl rlUnknown808FAD
        lda #$9600
        sta $7FED00
        lda #$8376
        sta $7FECFF
        rtl

        .databank 0

        ; 96/8376

      rlUnknown968376 ; 96/8376

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda $7FED4E
        bne _838D
        lda #$000C
        jsl rlUnknown808FAD
        jsl rlUnknown96C9FE
        jml _8415


        _838D
        lda $7FED4B
        clc
        adc $7FED4E
        bcc _83A2
        lda $7FED4D
        and #$00FF
        xba
        bra _83CA


        _83A2
        sta $7FED4B
        xba
        sep #$20
        cmp $7FED4D
        bcc _83B8
        lda $7FED4D
        xba
        lda #$00
        bra _83CA


        _83B8
        cmp $7FED50
        bcc _83C7
        lda $7FED50
        xba
        lda #$00
        bra _83CA


        _83C7
        xba
        bra _83F4


        _83CA
        rep #$20
        cmp #$6400
        bcc _83E3
        sec
        sbc #$6400
        pha
        lda $7FED50
        sec
        sbc #$0064
        sta $7FED50
        pla

        _83E3
        sta $7FED4B
        jsl rlUnknown9684AF
        lda #$0000
        sta $7FED4E
        bra _8415


        _83F4
        .as
        rep #$20
        cmp #$6400
        bcc _840D
        sec
        sbc #$6400
        pha
        lda $7FED50
        sec
        sbc #$0064
        sta $7FED50
        pla

        _840D
        sta $7FED4B
        jsl rlUnknown9684AF

        _8415
        ply
        plx
        rtl

        .databank 0

        ; 96/8418

      rlUnknown968418 ; 96/8418

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda $7FED4E
        bne _8424
        jml _84AC


        _8424
        lda $7FED4B
        clc
        adc $7FED4E
        bcc _8439
        lda $7FED4D
        and #$00FF
        xba
        bra _8461


        _8439
        sta $7FED4B
        xba
        sep #$20
        cmp $7FED4D
        bcc _844F
        lda $7FED4D
        xba
        lda #$00
        bra _8461


        _844F
        cmp $7FED50
        bcc _845E
        lda $7FED50
        xba
        lda #$00
        bra _8461


        _845E
        xba
        bra _848B


        _8461
        rep #$20
        cmp #$6400
        bcc _847A
        sec
        sbc #$6400
        pha
        lda $7FED50
        sec
        sbc #$0064
        sta $7FED50
        pla

        _847A
        sta $7FED4B
        jsl rlUnknown968530
        lda #$0000
        sta $7FED4E
        bra _84AC


        _848B
        .as
        rep #$20
        cmp #$6400
        bcc _84A4
        sec
        sbc #$6400
        pha
        lda $7FED50
        sec
        sbc #$0064
        sta $7FED50
        pla

        _84A4
        sta $7FED4B
        jsl rlUnknown968530

        _84AC
        ply
        plx
        rtl

        .databank 0

        ; 96/84AF

      rlUnknown9684AF ; 96/84AF

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FED52
        and #$00FF
        sta wR0
        lda #$2C00
        sta wR1
        lda $7FED53
        tax
        lda $7FED4B
        xba
        and #$00FF
        jsl rlUnknown959576
        lda $7FED4C
        and #$00FF
        sta wR0
        lda $7FED4D
        and #$00FF
        cmp #$00FF
        bne _84E6
        lda #$0063

        _84E6
        sta wR1
        lda $7FED56
        cmp #$FFFF
        beq _850B
        sta wR2
        lda $7FED58
        sta wR3
        lda $7FED52
        and #$00FF
        asl a
        clc
        adc $7FED53
        tax
        jsl rlUnknown959742

        _850B
        lda #$7F00
        sta lR18+1
        lda $7FED53
        clc
        adc #$C800
        sta lR18
        lda $7FED53
        lsr a
        clc
        adc #$6800
        tay
        lda $7FED55
        and #$00FF
        jsl rlUnknown95C43E
        rtl

        .databank 0

        ; 96/8530

      rlUnknown968530 ; 96/8530

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FED4C
        and #$00FF
        sta wR0
        lda $7FED4D
        and #$00FF
        sta wR1
        lda $7FED56
        cmp #$FFFF
        beq _855B
        sta wR2
        lda #$2400
        sta wR3
        lda $7FED53
        tax
        jsl rlUnknown959742

        _855B
        lda $7FED52
        and #$00FF
        sta wR0
        lda #$2000
        sta wR1
        lda $7FED53
        clc
        adc #$F9C8
        tax
        lda $7FED4B
        xba
        and #$00FF
        pha
        lda $7FED56
        cmp #$FFFF
        beq _858B
        pla
        jsl rlUnknown9596EE
        bra _8590


        _858B
        pla
        jsl rlUnknown95968E

        _8590
        lda #$7F00
        sta lR18+1
        lda $7FED53
        clc
        adc #$C1C0
        sta lR18
        lda $7FED53
        lsr a
        clc
        adc #$64E0
        tay
        lda $7FED55
        and #$00FF
        jsl rlUnknown95C43E
        lda #$7F00
        sta lR18+1
        lda $7FED53
        clc
        adc #$C800
        sta lR18
        lda $7FED53
        lsr a
        clc
        adc #$6800
        tay
        lda $7FED55
        and #$00FF
        jsl rlUnknown95C43E
        rtl

        .databank 0

        ; 96/85D9

      rlUnknown9685D9 ; 96/85D9

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$9C
        sta $7FE4C5
        lda #$A1
        sta $7FE4CB
        rep #$20
        lda #$FFC3
        sta $7FE4C6
        lda #$00DB
        sta $7FE4C8
        sep #$20
        lda #$01
        sta $7FE4C2
        rep #$20
        lda #$9800
        sta $7FE4D3
        lda #$AD7E
        sta $7FE4D2
        lda #$9600
        sta $7FED00
        lda #$861E
        sta $7FECFF
        rtl

        .databank 0

        ; 96/861E

      rlUnknown96861E ; 96/861E

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        phy
        lda $7FE4D2
        sta lR18
        lda $7FE4D3
        sta lR18+1
        ldy #$0000
        lda [lR18],y
        cmp #$FFFF
        bne _863B
        jsl rlUnknown96C9FE
        bra _865A


        _863B
        pha
        sep #$20
        sta $7FE4C5
        xba
        sta $7FE4CB
        rep #$20
        pla
        jsl rlUnknown9695AE
        lda $7FE4D2
        clc
        adc #$0002
        sta $7FE4D2

        _865A
        ply
        rtl

        .databank 0

        ; 96/865C

      rlUnknown96865C ; 96/865C

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda $7E4ECB
        beq _86BA
        lda $7FF5AF
        bit #$0001
        beq _8674
        lda #$0040
        jsl rlUnknown96A4B2
        bra _86BA


        _8674
        lda wBattleDistance
        cmp #$0003
        bcc _86A2
        lda $0D52,b
        cmp #$005B
        beq _8699
        cmp #$0061
        beq _8699
        cmp #$0063
        beq _8699
        cmp #$0064
        beq _8699
        cmp #$0065
        bne _86A2

        _8699
        lda #$003E
        jsl rlUnknown96A4B2
        bra _86BA


        _86A2
        lda $0AE9,b
        cmp #$0000
        bne _86B3
        lda #$0032
        jsl rlUnknown96A4B2
        bra _86BA


        _86B3
        lda #$003D
        jsl rlUnknown96A4B2

        _86BA
        rtl

        .databank 0

        ; 96/86BB

      rlUnknown9686BB ; 96/86BB

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda $7FFC59
        bit #$0400
        beq _86E6
        lda $7FF5AF
        bit #$0001
        beq _86DF
        lda $7E4ECB
        and #$00FF
        beq _86DF
        lda #$004B
        jsl rlUnknown96A4B2
        bra _86E6


        _86DF
        lda #$003D
        jsl rlUnknown96A4B2

        _86E6
        rtl

        .databank 0

        ; 96/86E7

      rlUnknown9686E7 ; 96/86E7

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda $7E4ECB
        beq _86FB
        lda #$00E0
        jsl rlUnknown808FA3
        lda #$0001
        jsl rlUnknown96A4B2

        _86FB
        rtl

        .databank 0

        ; 96/86FC

      rlUnknown9686FC ; 96/86FC

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$02
        sta $7FE4C2
        rep #$20
        stz aBGPaletteBuffer,b
        lda $E000BC
        sta $0108,b
        ldx #$0000

        _8713
        lda $E000B0,x
        sta $010A,b,x
        inc x
        inc x
        cpx #$0006
        bcc _8713
        ldx #$0000

        _8724
        lda $9984C6,x
        sta lR18
        lda $9984C7,x
        sta lR18+1
        ldy #$0000
        lda [lR18],y
        and #$00FF
        xba
        sta $7FED4B
        inc x
        inc x
        inc x
        lda $9984C6,x
        sta $7FED56
        inc x
        inc x
        lda $9984C6,x
        sta $7FED53
        inc x
        inc x
        sep #$20
        lda $9984C6,x
        sta $7FED4D
        inc x
        lda $9984C6,x
        sta $7FED52
        inc x
        lda $9984C6,x
        sta $7FED55
        inc x
        rep #$20
        lda $9984C6,x
        sta $7FED58
        inc x
        inc x
        phx
        jsl rlUnknown968530
        plx
        cpx #$006C
        bcc _8724
        jsl rlUnknown96957D
        rtl

        .databank 0

        ; 96/878D

      rlUnknown96878D ; 96/878D

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda $7FFC59
        bit #$0400
        bne _87AC
        lda $7E4EA9
        and #$00FF
        cmp #$0001
        beq _87A7
        lda #$0039
        bra _87AF


        _87A7
        lda #$003F
        bra _87AF


        _87AC
        lda #$0040

        _87AF
        sta $04BA,b
        rtl

        .databank 0

        ; 96/87B3

    .endsection Unsorted9680C2Section


    .section Unsorted96881FSection

      .al
      .xl

      rlUnknown96881F ; 96/881F

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda wBattleQuotePointer
        cmp #$0000
        beq _883F
        lda wBattleQuotePointer
        sta $7FE4D6
        lda wBattleQuotePointer+1
        sta $7FE4D7
        lda #$002D
        jsl rlUnknown96A4B2

        _883F
        rtl

        .databank 0

        ; 96/8840

      rlUnknown968840 ; 96/8840

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda $7FFC59
        bit #$0400
        bne _888F
        lda wDeathQuotePointer
        cmp #$0000
        beq _888F
        lda wDeathQuotePointer
        sta $7FE4D6
        lda wDeathQuotePointer+1
        sta $7FE4D7
        lda $7E4ECF
        bne _8888
        lda $7E4ED1
        cmp #$FFFF
        bne _8888
        lda $7E4ED3
        bne _8888
        lda aActionStructUnit2.ObtainedStealMoney
        bne _8888
        lda aActionStructUnit1.WeaponInventorySlot
        bmi _8888
        lda #$004A
        bra _888B


        _8888
        lda #$002E

        _888B
        jsl rlUnknown96A4B2

        _888F
        rtl

        .databank 0

        ; 96/8890

      rlUnknown968890 ; 96/8890

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda $7FFC59
        bit #$0400
        beq _88B9
        lda wDeathQuotePointer
        cmp #$0000
        beq _88B9
        lda wDeathQuotePointer
        sta $7FE4D6
        lda wDeathQuotePointer+1
        sta $7FE4D7
        lda #$004A
        jsl rlUnknown96A4B2

        _88B9
        rtl

        .databank 0

        ; 96/88BA

      rlUnknown9688BA ; 96/88BA

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$03
        sta $7FE4C2
        rep #$20
        stz aBGPaletteBuffer,b
        ldx #$0000

        _88CA
        lda $E000DA,x
        sta $0102,b,x
        inc x
        inc x
        cpx #$001E
        bcc _88CA
        lda #$0004
        jsl rlHDMAEngineFreeEntryByIndex
        jsl rlUnknown9695E3
        rtl

        .databank 0

        ; 96/88E4

    .endsection Unsorted96881FSection


    .section Unsorted96890ESection

      .al
      .xl

      rlUnknown96890E ; 96/890E

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$00
        sta $7FE4C2
        rep #$20
        stz aBGPaletteBuffer,b
        jsl rlUnknown9599E7
        jsl rlUnknown95A414
        jsl rlUnknown96957D
        jsl rlUnknown969EBB
        rtl

        .databank 0

        ; 96/892C

      rlUnknown96892C ; 96/892C

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 96/892D

      rlUnknown96892D ; 96/892D

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        stz $420C,b

        _8932
        lda $4212,b
        bit #$40
        beq _8932
        lda #$80
        sta $2100,b
        rep #$20
        rep #$20
        rtl

        .databank 0

        ; 96/8943

      rlUnknown968943 ; 96/8943

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20

        _8945
        lda $4212,b
        bit #$40
        beq _8945
        lda #$80
        lda $7FE4DD
        bit #$80
        bne _896A

        _8956
        lda $4212,b
        bit #$40
        bne _8956

        _895D
        lda $4212,b
        bit #$40
        beq _895D
        lda $7FE4DD
        bra _897C


        _896A
        lda $4212,b
        bit #$40
        bne _896A

        _8971
        lda $4212,b
        bit #$40
        beq _8971
        lda $7FE4DD

        _897C
        sta $2100,b
        rep #$20
        rtl

        .databank 0

        ; 96/8982

      rlUnknown968982 ; 96/8982

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20

        _8984
        lda $4212,b
        bit #$40
        beq _8984
        lda #$80
        sta $2100,b
        lda #$06
        sta $212C,b
        lda #$09
        sta $2105,b
        lda #$6A
        sta $2107,b
        sta $2108,b
        sta $2109,b
        lda #$77
        sta $210B,b
        lda #$77
        sta $210C,b
        lda $7FFC74
        sta $2110,b
        lda #$01
        sta $2110,b
        lda $7FFC73
        sta $210F,b
        stz $210F,b
        lda $7FFC76
        sta $2112,b
        stz $2112,b
        lda $7FFC75
        sta $2111,b
        stz $2111,b
        stz $2123,b
        stz $2124,b
        stz $420C,b
        rep #$20
        jsl rlUnknown9695D5
        sep #$20
        lda #$00
        sta $2121,b
        sta $2122,b
        sta $2122,b
        lda #$15
        sta $2121,b
        lda $E000B6
        sta $2122,b
        lda $E000B7
        sta $2122,b
        lda $E000B8
        sta $2122,b
        lda $E000B9
        sta $2122,b
        lda $E000BA
        sta $2122,b
        lda $E000BB
        sta $2122,b
        lda $7FFC6F
        sta $420C,b

        _8A2B
        lda $4212,b
        bit #$40
        bne _8A2B

        _8A32
        lda $4212,b
        bit #$40
        beq _8A32
        lda $7FE4D5
        bra _8A51

        .byte $AD, $12, $42, $89, $40, $D0, $F9, $AD, $12, $42, $89, $40, $F0, $F9, $AF, $DC
        .byte $E4, $7F


        _8A51
        sta $2100,b
        rep #$20
        rtl

        .databank 0

        ; 96/8A57

      rlUnknown968A57 ; 96/8A57

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20

        _8A59
        lda $4212,b
        bit #$40
        beq _8A59
        lda #$80
        sta $2100,b
        lda #$06
        sta $212C,b
        lda #$6A
        sta $2107,b
        sta $2108,b
        sta $2109,b
        lda #$77
        sta $210B,b
        lda #$77
        sta $210C,b
        lda $7FE4C6
        sta $2110,b
        lda $7FE4C7
        sta $2110,b
        lda #$04
        sta $210F,b
        stz $210F,b
        lda $7FE4C8
        clc
        adc #$04
        sta $2112,b
        lda $7FE4C9
        sta $2112,b
        stz $2111,b
        stz $2111,b
        lda $7FE4C5
        and #$FF
        sta $16DA,b,x
        lda #$11
        sta $2121,b
        lda $E000B0
        sta $2122,b
        lda $E000B1
        sta $2122,b
        lda $E000B2
        sta $2122,b
        lda $E000B3
        sta $2122,b
        lda $E000B4
        sta $2122,b
        lda $E000B5
        sta $2122,b
        lda $7FE4D5
        bit #$80

        _8AEA
        lda $4212,b
        bit #$40
        bne _8AEA

        _8AF1
        lda $4212,b
        bit #$40
        beq _8AF1
        lda $7FE4D5
        bra _8B10

        .byte $AD, $12, $42, $89, $40, $D0, $F9, $AD, $12, $42, $89, $40, $F0, $F9, $AF, $DC
        .byte $E4, $7F


        _8B10
        sta $2100,b
        rep #$20
        rtl

        .databank 0

        ; 96/8B16

      rlUnknown968B16 ; 96/8B16

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20

        _8B18
        lda $4212,b
        bit #$40
        beq _8B18
        lda #$80
        sta $2100,b
        lda #$06
        sta $212C,b
        lda #$6A
        sta $2107,b
        sta $2108,b
        sta $2109,b
        lda #$77
        sta $210B,b
        lda #$77
        sta $210C,b
        lda #$7F
        sta $2110,b
        lda #$01
        sta $2110,b
        stz $210F,b
        stz $210F,b
        lda #$97
        sta $2112,b
        stz $2112,b
        lda #$FC
        sta $2111,b
        stz $2111,b
        lda $7FE4CB
        and #$FF
        sta $16DA,b,x
        lda #$11
        sta $2121,b
        lda $0122,b
        sta $2122,b
        lda $0123,b
        sta $2122,b
        lda $0124,b
        sta $2122,b
        lda $0125,b
        sta $2122,b
        lda $0126,b
        sta $2122,b
        lda $0127,b
        sta $2122,b
        lda $7FE4D5
        bit #$80

        _8B96
        lda $4212,b
        bit #$40
        bne _8B96

        _8B9D
        lda $4212,b
        bit #$40
        beq _8B9D
        lda $7FE4D5
        bra _8BBC

        .byte $AD, $12, $42, $89, $40, $D0, $F9, $AD, $12, $42, $89, $40, $F0, $F9, $AF, $DC
        .byte $E4, $7F


        _8BBC
        sta $2100,b
        rep #$20
        rtl

        .databank 0

        ; 96/8BC2

      rlUnknown968BC2 ; 96/8BC2

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20

        _8BC4
        lda $4212,b
        bit #$40
        beq _8BC4
        lda #$80
        sta $2100,b
        lda #$17
        sta $212C,b
        lda #$03
        sta $2101,b
        lda #$6A
        sta $2107,b
        sta $2108,b
        sta $2109,b
        lda #$77
        sta $210B,b
        lda #$77
        sta $210C,b
        lda #$47
        sta $210E,b
        lda #$00
        sta $210E,b
        lda #$00
        sta $210D,b
        stz $210D,b
        lda #$F7
        sta $2110,b
        lda #$01
        sta $2110,b
        lda #$00
        sta $210F,b
        stz $210F,b
        lda #$0F
        sta $2112,b
        lda #$01
        sta $2112,b
        stz $2111,b
        stz $2111,b
        lda #$10
        sta $420C,b
        lda #$81
        sta $2121,b
        lda $E000C8
        sta $2122,b
        lda $E000C9
        sta $2122,b
        lda $E000CA
        sta $2122,b
        lda $E000CB
        sta $2122,b
        lda $E000CC
        sta $2122,b
        lda $E000CD
        sta $2122,b
        stz $2123,b
        stz $2124,b
        rep #$20
        jsl rlUnknown9695D5
        sep #$20
        lda $7FE4D5
        bit #$80

        _8C6B
        lda $4212,b
        bit #$40
        bne _8C6B

        _8C72
        lda $4212,b
        bit #$40
        beq _8C72
        lda $7FE4D5
        bra _8C91

        .byte $AD, $12, $42, $89, $40, $D0, $F9, $AD, $12, $42, $89, $40, $F0, $F9, $AF, $DC
        .byte $E4, $7F


        _8C91
        sta $2100,b
        rep #$20
        rtl

        .databank 0

        ; 96/8C97

      rlUnknown968C97 ; 96/8C97

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20

        _8C99
        lda $4212,b
        bit #$40
        beq _8C99
        lda #$80
        sta $2100,b
        lda #$06
        sta $212C,b
        lda #$03
        sta $2101,b
        lda #$6A
        sta $2107,b
        sta $2108,b
        lda #$74
        sta $2109,b
        lda #$77
        sta $210B,b
        sta $210C,b
        lda #$F7
        sta $2110,b
        lda #$01
        sta $2110,b
        lda #$00
        sta $210F,b
        stz $210F,b
        lda #$FF
        sta $2112,b
        sta $2112,b
        stz $2111,b
        stz $2111,b
        stz $2123,b
        stz $2124,b
        stz $2131,b
        stz $2125,b
        lda $7FE4D5
        bit #$80

        _8CF6
        lda $4212,b
        bit #$40
        bne _8CF6

        _8CFD
        lda $4212,b
        bit #$40
        beq _8CFD
        lda $7FE4D5
        bra _8D1C

        .byte $AD, $12, $42, $89, $40, $D0, $F9, $AD, $12, $42, $89, $40, $F0, $F9, $AF, $DC
        .byte $E4, $7F


        _8D1C
        sta $2100,b
        rep #$20
        rtl

        .databank 0

        ; 96/8D22

      rlUnknown968D22 ; 96/8D22

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20

        _8D24
        lda $4212,b
        bit #$40
        beq _8D24
        lda #$80
        sta $2100,b
        lda #$16
        sta $212C,b
        lda #$03
        sta $2101,b
        lda #$6A
        sta $2108,b
        lda #$74
        sta $2109,b
        lda #$77
        sta $210B,b
        sta $210C,b
        lda #$F7
        sta $2110,b
        lda #$01
        sta $2110,b
        lda #$00
        sta $210F,b
        stz $210F,b
        lda #$FF
        sta $2112,b
        sta $2112,b
        stz $2111,b
        stz $2111,b
        stz $2123,b
        stz $2124,b
        stz $2131,b
        stz $2125,b
        lda $7FE4D5
        bit #$80

        _8D7E
        lda $4212,b
        bit #$40
        bne _8D7E

        _8D85
        lda $4212,b
        bit #$40
        beq _8D85
        lda $7FE4D5
        bra _8DA4

        .byte $AD, $12, $42, $89, $40, $D0, $F9, $AD, $12, $42, $89, $40, $F0, $F9, $AF, $DC
        .byte $E4, $7F


        _8DA4
        sta $2100,b
        rep #$20
        rtl

        .databank 0

        ; 96/8DAA

      rlUnknown968DAA ; 96/8DAA

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20

        _8DAC
        lda $4212,b
        bit #$40
        beq _8DAC
        lda #$16
        sta $212C,b
        rep #$20
        rtl

        .databank 0

        ; 96/8DBB

    .endsection Unsorted96890ESection


    .section Unsorted968DBDSection

      .al
      .xl

      rlUnknown968DBD ; 96/8DBD

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$8F
        sta $7FE4D5
        rep #$20
        rtl

        .databank 0

        ; 96/8DC8

      rlUnknown968DC8 ; 96/8DC8

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda $7FE4D5
        and #$000F
        bne _8DD7
        jsl rlUnknown96C9FE
        bra _8DE0


        _8DD7
        sep #$20
        dec a
        sta $7FE4D5
        rep #$20

        _8DE0
        rtl

        .databank 0

        ; 96/8DE1

    .endsection Unsorted968DBDSection


    .section Unsorted968E4CSection

      .al
      .xl

      rlUnknown968E4C ; 96/8E4C

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda $7FE4D5
        and #$000F
        cmp #$000F
        bne _8E6C
        sep #$20
        sta $7FE4D5
        lda $7FE4B7
        and #$FE
        sta $7FE4B7
        rep #$20
        bra _8E7D


        _8E6C
        sep #$20
        clc
        adc #$03
        cmp #$0F
        bcc _8E77
        lda #$0F

        _8E77
        sta $7FE4D5
        rep #$20

        _8E7D
        rtl

        .databank 0

        ; 96/8E7E

      rlUnknown968E7E ; 96/8E7E

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$8F
        sta $7FE4DD
        lda #$0F
        sta $7FE4DC
        rep #$20
        rtl

        .databank 0

        ; 96/8E8F

    .endsection Unsorted968E4CSection


    .section Unsorted968F50Section

      .al
      .xl

      rlUnknown968F50 ; 96/8F50

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda #$0004
        sta $7E52F0
        lda #$0000
        sta $7E5313
        lda #$9600
        sta $7FED00
        lda #$8F71
        sta $7FECFF
        ply
        plx
        rtl

        .databank 0

        ; 96/8F71

      rlUnknown968F71 ; 96/8F71

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy

        _8F73
        lda $7E5313
        tax
        lda $998683,x
        cmp #$0080
        bne _8F89
        jsl rlUnknown96C9FE
        jml _9034


        _8F89
        lda $998683,x
        sta lR18
        lda $998684,x
        sta lR18+1
        ldy #$0000
        lda [lR18],y
        and #$00FF
        bne _8FAD
        lda $7E5313
        clc
        adc #$0009
        sta $7E5313
        bra _8F73


        _8FAD
        pha
        pha
        bit #$0080
        bne _8FBE
        lda #$015E
        sta $7E530D
        pla
        bra _8FCD


        _8FBE
        lda #$015F
        sta $7E530D
        pla
        eor #$FFFF
        inc a
        and #$00FF

        _8FCD
        jsr rsUnknown969137
        sta $7E530F
        lda $998686,x
        sta lR18
        lda $998687,x
        sta lR18+1
        ldy #$0000
        lda [lR18],y
        and #$00FF
        clc
        adc #1,s
        jsr rsUnknown969137
        sta $7E5304
        lda lR18
        sta $7E52FF
        pla
        lda $998689,x
        sta $7E530B
        lda $99868B,x
        and #$00FF
        jsl rlUnknown969398
        lda $7E5313
        clc
        adc #$0009
        sta $7E5313
        lda #$0000
        sta $7E5311
        lda #$0023
        jsl rlUnknown808FAD
        lda #$9600
        sta $7FED00
        lda #$9037
        sta $7FECFF

        _9034
        ply
        plx
        rtl

        .databank 0

        ; 96/9037

      rlUnknown969037 ; 96/9037

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy

        _9039
        lda $7E5311
        tax
        lda $998532,x
        and #$00FF
        cmp #$0082
        bne _9072
        lda $7E4EA9
        and #$00FF
        cmp #$0002
        beq _9064
        lda $7E5311
        clc
        adc #$0019
        sta $7E5311
        bra _9039


        _9064
        lda $7E5311
        clc
        adc #$0001
        sta $7E5311
        bra _9039


        _9072
        lda $998532,x
        and #$00FF
        cmp #$0080
        bne _9090
        lda #$9600
        sta $7FED00
        lda #$8F71
        sta $7FECFF
        jml _9130


        _9090
        cmp #$0081
        bne _90A2
        lda #$01FF
        sta $7E52F5
        sta $7E52FA
        bra _90B4


        _90A2
        pha
        lda $7E530D
        sta $7E52F5
        lda $7E530F
        sta $7E52FA
        pla

        _90B4
        sta $7E52F7
        sec
        sbc #$0008
        and #$01FF
        sta $7E52F2
        lda #$0000
        sec
        sbc #$0008
        and #$01FF
        sta $7E5301
        sec
        sbc #$0008
        and #$01FF
        sta $7E52FC
        sep #$20
        lda $998533,x
        sta $7E52F4
        sta $7E52F9
        lda #$00
        sta $7E52FE
        sta $7E5303
        rep #$20
        phb
        sep #$20
        lda #$7E
        pha
        plb
        .databank $7E
        rep #$20
        ldy #$52F0
        lda @l $7E530B
        and #$00FF
        sta wR0
        lda @l $7E530C
        and #$00FF
        sta wR1
        lda #$3000
        sta wR4
        lda #$0000
        sta wR5
        clc
        jsl rlUnknown95C51F
        plb
        .databank $7E
        lda @l $7E5311
        clc
        adc #$0002
        sta @l $7E5311

        _9130
        jsl rlUnknown968418
        ply
        plx
        rtl

        .databank 0

        ; 96/9137

      rsUnknown969137 ; 96/9137

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        cmp #$000A
        bcs _9147
        pha
        lda #$01FF
        sta lR18
        pla
        bra _915C


        _9147
        sta wR13
        lda #$000A
        sta wR14
        jsl rlUnknown959C3E
        lda wR13
        clc
        adc #$0154
        sta lR18
        lda wR10

        _915C
        clc
        adc #$0154
        ply
        plx
        rts

        .databank 0

        ; 96/9163

      rlUnknown969163 ; 96/9163

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda #$0005
        sta $7E52F0
        lda #$015E
        sta $7E530D
        ldx #$0000
        jsl rlUnknown95B5FD
        pha
        lda $0AFE,b,x
        and #$00FF
        clc
        adc #1,s
        pha
        lda #$0064
        sec
        sbc #1,s
        sep #$20
        sta $7E530C
        rep #$20
        pla
        pla
        lda $0AF9,b,x
        and #$01FF
        sec
        sbc $7FE198
        jsl rlUnknown95A164
        sec
        sbc #$0004
        sep #$20
        sta $7E530B
        rep #$20
        lda #$0000
        sta $7E5311
        lda #$9600
        sta $7FED00
        lda #$91C8
        sta $7FECFF
        ply
        plx
        rtl

        .databank 0

        ; 96/91C8

      rlUnknown9691C8 ; 96/91C8

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda $7E5311
        tax
        lda $998586,x
        and #$00FF
        cmp #$0080
        bne _91E3
        jsl rlUnknown96C9FE
        jml _92F5


        _91E3
        cmp #$0081
        bne _9223
        lda #$01FF
        sta $7E52F5
        sta $7E52FA
        sta $7E52FF
        sta $7E5304
        sta $7E5309
        sep #$20
        lda $998587,x
        clc
        adc #$80
        sta $7E52F4
        sta $7E52F9
        sta $7E52FE
        sta $7E5303
        sta $7E5308
        rep #$20
        lda #$0000
        bra _9266


        _9223
        lda #$067B
        sta $7E52F5
        lda #$067C
        sta $7E52FA
        lda #$067D
        sta $7E52FF
        lda #$067E
        sta $7E5304
        lda #$067F
        sta $7E5309
        sep #$20
        lda $998587,x
        sta $7E52F4
        sta $7E52F9
        sta $7E52FE
        sta $7E5303
        sta $7E5308
        rep #$20
        lda $998586,x

        _9266
        and #$00FF
        bit #$0080
        beq _9271
        ora #$0100

        _9271
        sta $7E52F2
        phx
        pha
        lda $998588,x
        and #$00FF
        asl a
        asl a
        tax
        lda $99862F,x
        and #$00FF
        clc
        adc #1,s
        sta $7E52F7
        lda $998630,x
        and #$00FF
        clc
        adc #1,s
        sta $7E52FC
        lda $998631,x
        and #$00FF
        clc
        adc #1,s
        sta $7E5301
        lda $998632,x
        and #$00FF
        clc
        adc #1,s
        sta $7E5306
        pla
        plx
        phb
        sep #$20
        lda #$7E
        pha
        plb
        .databank $7E
        rep #$20
        ldy #$52F0
        lda @l $7E530B
        and #$00FF
        sta wR0
        lda @l $7E530C
        and #$00FF
        sta wR1
        lda #$3000
        sta wR4
        lda #$0000
        sta wR5
        clc
        jsl rlUnknown95C51F
        plb
        .databank $7E
        lda @l $7E5311
        clc
        adc #$0003
        sta @l $7E5311

        _92F5
        ply
        plx
        rtl

        .databank 0

        ; 96/92F8

    .endsection Unsorted968F50Section


    .section Unsorted969398Section

      .al
      .xl

      rlUnknown969398 ; 96/9398

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        pha
        asl a
        pha
        asl a
        asl a
        clc
        adc #1,s
        clc
        adc #3,s
        tax
        pla
        pla
        ldy #$0000
        lda $9986CD,x
        sta lR18
        lda $9986CE,x
        sta lR18+1
        lda [lR18],y
        and #$00FF
        sta wR0
        xba
        sta $7FED4B
        lda $9986D0,x
        sta lR18
        lda $9986D1,x
        sta lR18+1
        lda [lR18],y
        and #$00FF
        clc
        adc wR0
        pha
        sta wR0
        jsl rlUnknown9594E0
        sta $7FED4E
        pla
        and #$00FF
        sta $7FED50
        lda $9986D3,x
        sta $7FED56
        lda #$2800
        sta $7FED58
        lda $9986D5,x
        sta $7FED53
        sep #$20
        lda $9986D7,x
        sta $7FED4D
        lda #$02
        sta $7FED52
        lda #$0C
        sta $7FED55
        rep #$20
        ply
        plx
        rtl

        .databank 0

        ; 96/941C

    .endsection Unsorted969398Section


    .section Unsorted96941CSection

      .al
      .xl

      rlUnknown96941C ; 96/941C

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FE4CC
        bit #$0080
        bne _947B
        and #$007F
        beq _947B
        lda $7FE4B7
        bit #$0080
        bne _9478
        lda $7FFC56
        bit #$0080
        bne _9478
        lda $7FE4CC
        dec a
        sep #$20
        sta $7FE4CC
        rep #$20
        and #$007F
        sta wR0
        phb
        jsl _9456
        plb
        .databank ?
        bra _9478


        _9456
        lda wR0
        cmp #$0003
        bmi _945F

        _945D
        bra _945D


        _945F
        asl a
        adc wR0
        tax
        lda $998437,x
        sta lR23
        sep #$20
        lda $998439,x
        sta lR23+2
        pha
        plb
        .databank ?
        rep #$20
        jml [lR23]


        _9478
        clc
        bra _947C


        _947B
        sec

        _947C
        rtl

        .databank 0

        ; 96/947D

    .endsection Unsorted96941CSection


    .section Unsorted96947DSection

      .al
      .xl

      rlUnknown96947D ; 96/947D

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda $7FE4B7
        lda $7FE4B8
        and #$00FF
        bne _94A0
        sep #$20
        lda #$95
        sta $7FE4CC
        lda $7FE1B3
        and #$F7
        sta $7FE1B3
        rep #$20
        bra _94AD


        _94A0
        sep #$20
        lda $7FE4CC
        inc a
        sta $7FE4CC
        rep #$20

        _94AD
        rtl

        .databank 0

        ; 96/94AE

      rlUnknown9694AE ; 96/94AE

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda $7FE1B3
        ora #$08
        sta $7FE1B3
        rep #$20
        lda #$0000
        sta wBufferBG3HOFS
        lda #$01FF
        sta wBufferBG3VOFS
        rtl

        .databank 0

        ; 96/94C7

    .endsection Unsorted96947DSection


    .section Unsorted9694C7Section

      .al
      .xl

      rlUnknown9694C7 ; 96/94C7

        .al
        .xl
        .autsiz
        .databank ?

        bcc _952B
        lda $7FFC56
        bit #$0080
        bne _9527
        lda $7FE4CC
        bit #$0080
        beq _952A
        and #$007F
        beq _952A
        dec a
        sep #$20
        pha
        ora #$80
        sta $7FE4CC
        pla
        rep #$20
        sta wR0
        phb
        jsl _94F7
        plb
        .databank ?
        bra _9519


        _94F7
        lda wR0
        cmp #$0015
        bmi _9500

        _94FE
        bra _94FE


        _9500
        asl a
        adc wR0
        tax
        lda $998440,x
        sta lR23
        sep #$20
        lda $998442,x
        sta lR23+2
        pha
        plb
        .databank ?
        rep #$20
        jml [lR23]


        _9519
        sep #$20
        lda $7FE4DB
        ora #$01
        sta $7FE4DB
        rep #$20

        _9527
        clc
        bra _952B


        _952A
        sec

        _952B
        rtl

        .databank 0

        ; 96/952C

      rlUnknown96952C ; 96/952C

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000
        lda #$000F
        sta $7FE3CA,x
        lda #$E3EE
        sta $7FE3CB,x
        inc x
        inc x
        inc x
        lda #$0070
        sta $7FE3CA,x
        lda #$E3EE
        sta $7FE3CB,x
        inc x
        inc x
        inc x
        txa
        sta $7FE3EA
        jsl rlUnknown96955D
        plx
        rtl

        .databank 0

        ; 96/955D

      rlUnknown96955D ; 96/955D

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7FE3EA
        tax
        lda #$00D0
        sta $7FE3CA,x
        lda #$E3F1
        sta $7FE3CB,x
        sep #$20
        lda #$00
        sta $7FE3CD,x
        rep #$20
        plx
        rtl

        .databank 0

        ; 96/957D

    .endsection Unsorted9694C7Section


    .section Unsorted96957DSection

      .al
      .xl

      rlUnknown96957D ; 96/957D

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000

        _9581
        lda $98ABFC,x
        sta $7FE3F1,x
        lda $98ABFE,x
        sta $7FE3F3,x
        lda $98AC00,x
        sta $7FE3F5,x
        lda $98AC02,x
        sta $7FE3F7,x
        txa
        clc
        adc #$0008
        tax
        cpx #$0050
        bcc _9581
        plx
        rtl

        .databank 0

        ; 96/95AE

      rlUnknown9695AE ; 96/95AE

        .al
        .xl
        .autsiz
        .databank ?

        phx
        sec
        sbc #$8A8A
        sep #$20
        xba
        inc a
        sta wR0
        stz wR0+1
        rep #$20
        xba
        and #$00FF
        tax
        sep #$20

        _95C4
        lda $98AC4C,x
        sta $7FE3FD,x
        inc x
        cpx wR0
        bcc _95C4
        rep #$20
        plx
        rtl

        .databank 0

        ; 96/95D5

      rlUnknown9695D5 ; 96/95D5

        .al
        .xl
        .autsiz
        .databank ?

        lda #$8200
        sta $2130,b
        sep #$20
        stz $2125,b
        rep #$20
        rtl

        .databank 0

        ; 96/95E3

      rlUnknown9695E3 ; 96/95E3

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7FE3EA
        tax
        sep #$20
        lda #$00
        sta $7FE3CA,x
        rep #$20
        plx
        rtl

        .databank 0

        ; 96/95F5

      rlUnknown9695F5 ; 96/95F5

        .al
        .xl
        .autsiz
        .databank ?

        lda wBattleSong
        beq _9602
        sta $04BA,b
        jsl rlUnknown809654

        _9602
        rtl

        .databank 0

        ; 96/9603

    .endsection Unsorted96957DSection


    .section Unsorted969603Section

      .al
      .xl

      rlUnknown969603 ; 96/9603

        .al
        .xl
        .autsiz
        .databank ?

        lda $7E4EA9
        and #$00FF
        cmp #$00FF
        beq _9616
        lda #$00C0
        jsl rlUnknown808F6F

        _9616
        rtl

        .databank 0

        ; 96/9617

    .endsection Unsorted969603Section


    .section Unsorted969617Section

      .al
      .xl

      rlUnknown969617 ; 96/9617

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$00E0
        jsl rlUnknown808FA3
        rtl

        .databank 0

        ; 96/961F

    .endsection Unsorted969617Section


    .section Unsorted96961FSection

      .al
      .xl

      rlUnknown96961F ; 96/961F

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FFC9C
        bit #$0001
        bne _9647
        lda $0AF9,b
        cmp $0B3C,b
        bcs _9664
        sep #$20
        lda $7FFC9C
        ora #$01
        sta $7FFC9C
        rep #$20
        lda #$01D1
        jsl rlUnknown808FA3
        bra _9664


        _9647
        lda $0B3C,b
        cmp $0AF9,b
        bcs _9664
        sep #$20
        lda $7FFC9C
        and #$FE
        sta $7FFC9C
        rep #$20
        lda #$00D1
        jsl rlUnknown808FA3

        _9664
        rtl

        .databank 0

        ; 96/9665

    .endsection Unsorted96961FSection


    .section Unsorted969665Section

      .al
      .xl

      rlUnknown969665 ; 96/9665

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda $7FFC59
        bit #$0002
        beq _9677
        lda #$0003
        sta wR0
        bra _9693


        _9677
        jsl rlUnknown9697FA
        bcs _9685
        ldx #$0043
        lda $0D52,b
        bra _968B


        _9685
        ldx #$0000
        lda $0D60,b

        _968B
        jsl rlUnknown9696AA
        bcs _969D
        sta wR0

        _9693
        txy
        phx
        lda wR0
        asl a
        tax
        jsr ($9696A0,x)
        plx

        _969D
        ply
        plx
        rtl

        .databank 0

        ; 96/96A0

    .endsection Unsorted969665Section


    .section Unsorted9696AASection

      .al
      .xl

      rlUnknown9696AA ; 96/96AA

        .al
        .xl
        .autsiz
        .databank ?

        phx
        pha
        ldx #$0000

        _96AF
        lda $9982E3,x
        inc x
        inc x
        inc x
        cmp #$FFFF
        beq _96E2
        and #$00FF
        cmp #1,s
        bne _96AF
        lda wBattleDistance
        cmp #$0003
        bcs _96D1
        lda $9982E1,x
        bra _96D5


        _96D1
        lda $9982E2,x

        _96D5
        and #$00FF
        cmp #$00FF
        beq _96E2
        sta #1,s
        clc
        bra _96E3


        _96E2
        sec

        _96E3
        pla
        plx
        rtl

        .databank 0

        ; 96/96E6

    .endsection Unsorted9696AASection


    .section Unsorted9697FASection

      .al
      .xl

      rlUnknown9697FA ; 96/97FA

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000

        _97FE
        lda $7E4F85,x
        cmp #$FFFF
        beq _981A
        cmp #$FEFF
        beq _981A
        bit #$0080
        beq _9815
        inc x
        inc x
        bra _97FE


        _9815
        bit #$0001
        bne _981D

        _981A
        clc
        bra _981E


        _981D
        sec

        _981E
        plx
        rtl

        .databank 0

        ; 96/9820

      rlUnknown969820 ; 96/9820

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        cpx #$0000
        bne _982C
        lda $0D52,b
        bra _982F


        _982C
        lda $0D60,b

        _982F
        jsl rlUnknown9696AA
        bcs _9846
        cmp #$0004
        bne _9846
        lda wBattleDistance
        cmp #$0002
        bcc _9846
        sec
        bra _9847


        _9846
        clc

        _9847
        ply
        plx
        rtl

        .databank 0

        ; 96/984A

      rlUnknown96984A ; 96/984A

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$00
        sta $7FE187
        sta $7FE188
        lda $0AE0,b
        and #$EF
        sta $0AE0,b
        rep #$20
        rtl

        .databank 0

        ; 96/9861

    .endsection Unsorted9697FASection


    .section Unsorted969861Section

      .al
      .xl

      rlUnknown969861 ; 96/9861

        .al
        .xl
        .autsiz
        .databank ?

        lda #$7E00
        sta $0AE2,b
        lda #$4F85
        sta $0AE1,b
        jsl rlUnknown9582D8
        rtl

        .databank 0

        ; 96/9872

    .endsection Unsorted969861Section


    .section Unsorted969872Section

      .al
      .xl

      rlUnknown969872 ; 96/9872

        .al
        .xl
        .autsiz
        .databank ?

        pha
        lda $7FE187
        bit #$0001
        beq _989C
        sep #$20
        and #$FE
        ora #$02
        sta $7FE187
        rep #$20
        jsl rlActionStructBuildBattleRounds
        sep #$20
        lda $7FE187
        and #$FD
        ora #$04
        sta $7FE187
        rep #$20

        _989C
        pla
        rtl

        .databank 0

        ; 96/989E

    .endsection Unsorted969872Section


    .section Unsorted96989ESection

      .al
      .xl

      rlUnknown96989E ; 96/989E

        .al
        .xl
        .autsiz
        .databank ?

        bcc _98DF
        lda $0AE0,b
        bit #$0010
        beq _98B7
        sep #$20
        and #$EF
        sta $0AE0,b
        lda #$01
        sta $7FE187
        rep #$20

        _98B7
        lda $7FE187
        bit #$0003
        bne _98DB
        bit #$0004
        beq _98DE
        sep #$20
        and #$FB
        sta $7FE187
        lda $0AE0,b
        and #$F9
        sta $0AE0,b
        rep #$20
        jsl rlUnknown969861

        _98DB
        clc
        bra _98DF


        _98DE
        sec

        _98DF
        rtl

        .databank 0

        ; 96/98E0

      rlUnknown9698E0 ; 96/98E0

        .al
        .xl
        .autsiz
        .databank ?

        pha
        lda $0AE0,b
        bit #$0080
        bne _98EC
        clc
        bra _98ED


        _98EC
        sec

        _98ED
        pla
        rtl

        .databank 0

        ; 96/98EF

      rlUnknown9698EF ; 96/98EF

        .al
        .xl
        .autsiz
        .databank ?

        pha
        lda $7E4EA9
        and #$00FF
        cmp #$0001
        bne _9949
        lda $7FE4DB
        bit #$0001
        bne _9949
        lda $7FE188
        bit #$0002
        bne _9934
        lda wJoy1Input
        bit #$8000
        beq _9949
        sep #$20
        lda $0AE0,b
        ora #$80
        sta $0AE0,b
        lda $7FE188
        ora #$02
        sta $7FE188
        rep #$20
        lda #$000A
        jsl rlUnknown808FAD
        bra _9949


        _9934
        lda wJoy1Input
        bit #$8000
        bne _9949
        sep #$20
        lda $7FE188
        and #$FD
        sta $7FE188
        rep #$20

        _9949
        pla
        rtl

        .databank 0

        ; 96/994B

    .endsection Unsorted96989ESection


    .section Unsorted96994BSection

      .al
      .xl

      rlUnknown96994B ; 96/994B

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        sep #$20
        lda $0AF5,b
        and #$FB
        sta $0AF5,b
        lda $0B38,b
        and #$FB
        sta $0B38,b
        rep #$20
        plx
        pla
        rtl

        .databank 0

        ; 96/9964

    .endsection Unsorted96994BSection


    .section Unsorted9699DDSection

      .al
      .xl

      rlUnknown9699DD ; 96/99DD

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7FFC59
        bit #$0002
        beq _9A24
        ldx #$0000
        lda #$000A

        _99ED
        pha
        lda #$0010

        _99F1
        pha
        lda $7FD0C0,x
        and #$1C00
        cmp #$0400
        bne _9A08
        lda $7FD0C0,x
        clc
        adc #$1800
        bra _9A10


        _9A08
        lda $7FD0C0,x
        clc
        adc #$1000

        _9A10
        sta $7FD0C0,x
        inc x
        inc x
        pla
        dec a
        bne _99F1
        txa
        clc
        adc #$0020
        tax
        pla
        dec a
        bne _99ED

        _9A24
        plx
        rtl

        .databank 0

        ; 96/9A26

      rlUnknown969A26 ; 96/9A26

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7FFC59
        bit #$0002
        bne _9A34
        jml _9B9A


        _9A34
        ldx #$0000

        _9A37
        lda $0102,b,x
        sta $7ECC08,x
        inc x
        inc x
        cpx #$001E
        bcc _9A37
        ldx #$0000

        _9A48
        lda $01C2,b,x
        sta $7ECC28,x
        inc x
        inc x
        cpx #$001E
        bcc _9A48
        ldx #$0000

        _9A59
        lda $0102,b,x
        sta $0122,b,x
        sta $7FFE22,x
        inc x
        inc x
        cpx #$0016
        bcc _9A59
        ldx #$0000

        _9A6D
        lda $0108,b,x
        sta $0138,b,x
        sta $7FFE38,x
        inc x
        inc x
        cpx #$0008
        bcc _9A6D
        ldx #$0000

        _9A81
        lda $01E2,b,x
        jsl rlUnknown96EDC0
        lsr a
        and #$3DEF
        sta $01E2,b,x
        inc x
        inc x
        cpx #$001E
        bcc _9A81
        ldx #$0000

        _9A99
        lda $0122,b,x
        jsl rlUnknown96EDC0
        lsr a
        and #$3DEF
        sta $0122,b,x
        inc x
        inc x
        cpx #$0006
        bcc _9A99
        ldx #$0000
        lda #$0001
        sta wR0

        _9AB6
        lda $0132,b,x
        jsl rlUnknown96EDC0
        lsr a
        and #$3DEF
        jsl rlUnknown969C63
        sta $0132,b,x
        inc x
        inc x
        cpx #$0006
        bcc _9AB6
        ldx #$0000
        lda #$0003
        sta wR0

        _9AD7
        lda $013A,b,x
        jsl rlUnknown96EDC0
        lsr a
        and #$3DEF
        jsl rlUnknown969C63
        sta $013A,b,x
        inc x
        inc x
        cpx #$0006
        bcc _9AD7
        ldx #$0000

        _9AF3
        lda $01C2,b,x
        jsl rlUnknown96EDC0
        lsr a
        and #$3DEF
        sta $7FFEC2,x
        inc x
        inc x
        cpx #$001E
        bcc _9AF3
        ldx #$0000

        _9B0C
        lda $0102,b,x
        jsl rlUnknown96EDC0
        lsr a
        and #$3DEF
        sta $7FFE02,x
        inc x
        inc x
        cpx #$0006
        bcc _9B0C
        ldx #$0000
        lda #$0001
        sta wR0

        _9B2A
        lda $0112,b,x
        jsl rlUnknown96EDC0
        lsr a
        and #$3DEF
        jsl rlUnknown969C63
        sta $7FFE12,x
        inc x
        inc x
        cpx #$0006
        bcc _9B2A
        ldx #$0000
        lda #$0003
        sta wR0

        _9B4C
        lda $011A,b,x
        jsl rlUnknown96EDC0
        lsr a
        and #$3DEF
        jsl rlUnknown969C63
        sta $7FFE1A,x
        inc x
        inc x
        cpx #$0006
        bcc _9B4C
        ldx #$0000
        lda #$0008
        sta wR0

        _9B6E
        lda $0162,b,x
        jsl rlUnknown969B9C
        sta aWorldMapMarkerPalette,x
        inc x
        inc x
        cpx #$003E
        bcc _9B6E
        ldx #$0000
        lda #$0014
        sta wR0

        _9B88
        lda $0162,b,x
        jsl rlUnknown969B9C
        sta $7ECBC8,x
        inc x
        inc x
        cpx #$003E
        bcc _9B88

        _9B9A
        plx
        rtl

        .databank 0

        ; 96/9B9C

      rlUnknown969B9C ; 96/9B9C

        ; Reads the stack above its return address, but in the emulator log every
        ; caller continues right after the call: no inline arguments.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        pha
        lda wR0
        asl a
        tax
        lda #1,s
        and #$001F
        clc
        adc wR0
        cmp #$0020
        bcc _9BB2
        lda #$001F

        _9BB2
        pha
        lda #3,s
        and #$03E0
        clc
        adc $969BE3,x
        cmp #$0400
        bcc _9BC5
        lda #$03E0

        _9BC5
        ora #1,s
        sta #1,s
        lda #3,s
        and #$7C00
        clc
        adc $969C23,x
        cmp #$8000
        bcc _9BDB
        lda #$7C00

        _9BDB
        ora #1,s
        sta #3,s
        pla
        pla
        plx
        rtl

        .databank 0

        ; 96/9BE3

    .endsection Unsorted9699DDSection


    .section Unsorted969C63Section

      .al
      .xl

      rlUnknown969C63 ; 96/9C63

        ; Reads the stack above its return address, but in the emulator log every
        ; caller continues right after the call: no inline arguments.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        pha
        lda wR0
        asl a
        tax
        lda #1,s
        and #$001F
        sec
        sbc wR0
        bcs _9C76
        lda #$0000

        _9C76
        pha
        lda #3,s
        and #$03E0
        sec
        sbc $969BE3,x
        bcs _9C86
        lda #$0000

        _9C86
        ora #1,s
        sta #1,s
        lda #3,s
        and #$7C00
        sec
        sbc $969C23,x
        bcs _9C99
        lda #$0000

        _9C99
        ora #1,s
        sta #3,s
        pla
        pla
        plx
        rtl

        .databank 0

        ; 96/9CA1

      rlUnknown969CA1 ; 96/9CA1

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $0AE4,b
        bit #$0080
        beq _9CFF
        jsl rlUnknown96F341
        bcs _9CFF
        lda $0AEB,b
        cmp #$0000
        bne _9CBD
        lda #$0000
        bra _9CC0


        _9CBD
        lda #$0001

        _9CC0
        jsl rlUnknown9EB0F2
        cmp #$0002
        beq _9CD8
        cmp #$0001
        beq _9CD3
        lda #$0089
        bra _9CDB


        _9CD3
        lda #$008A
        bra _9CDB


        _9CD8
        lda #$008B

        _9CDB
        pha
        ldx $0AEB,b
        lda $0AF9,b,x
        and #$01FF
        sec
        sbc $7FE198
        jsl rlUnknown9EB4BB
        cpx #$0000
        bne _9CF7
        clc
        adc #$2000

        _9CF7
        clc
        adc #1,s
        jsl rlUnknown80900D
        pla

        _9CFF
        plx
        rtl

        .databank 0

        ; 96/9D01

      rlUnknown969D01 ; 96/9D01

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$74
        sta $2181,b
        lda #$55
        sta $2182,b
        lda #$01
        sta $2183,b
        rep #$20
        lda #$0000

        _9D17
        sta wR0
        asl a
        tax
        lda $98B388,x
        sta wR1
        ldx #$0000

        _9D24
        lda $0202,b,x
        jsr rsUnknown969E6A
        sep #$20
        sta $2180,b
        xba
        sta $2180,b
        rep #$20
        lda $0222,b,x
        jsr rsUnknown969E6A
        sep #$20
        sta $2180,b
        xba
        sta $2180,b
        rep #$20
        lda $0242,b,x
        jsr rsUnknown969E6A
        sep #$20
        sta $2180,b
        xba
        sta $2180,b
        rep #$20
        lda $0262,b,x
        jsr rsUnknown969E6A
        sep #$20
        sta $2180,b
        xba
        sta $2180,b
        rep #$20
        inc x
        inc x
        cpx #$0012
        bcc _9D24

        _9D6F
        lda $0202,b,x
        jsr rsUnknown969E6A
        sep #$20
        sta $2180,b
        xba
        sta $2180,b
        rep #$20
        lda $0222,b,x
        jsr rsUnknown969E6A
        sep #$20
        sta $2180,b
        xba
        sta $2180,b
        rep #$20
        lda $0242,b,x
        jsr rsUnknown969E6A
        sep #$20
        sta $2180,b
        xba
        sta $2180,b
        rep #$20
        inc x
        inc x
        cpx #$001E
        bcc _9D6F
        lda wR0
        inc a
        cmp #$0019
        bcs _9DB5
        jml _9D17


        _9DB5
        sep #$20
        lda #$74
        sta $2181,b
        lda #$B5
        sta $2182,b
        lda #$01
        sta $2183,b
        rep #$20
        lda #$0000

        _9DCB
        sta wR0
        asl a
        tax
        lda $98B388,x
        sta wR1
        ldx #$0000

        _9DD8
        lda $0282,b,x
        jsr rsUnknown969E6A
        sep #$20
        sta $2180,b
        xba
        sta $2180,b
        rep #$20
        lda $02A2,b,x
        jsr rsUnknown969E6A
        sep #$20
        sta $2180,b
        xba
        sta $2180,b
        rep #$20
        lda $02C2,b,x
        jsr rsUnknown969E6A
        sep #$20
        sta $2180,b
        xba
        sta $2180,b
        rep #$20
        lda $02E2,b,x
        jsr rsUnknown969E6A
        sep #$20
        sta $2180,b
        xba
        sta $2180,b
        rep #$20
        inc x
        inc x
        cpx #$0012
        bcc _9DD8

        _9E23
        lda $0282,b,x
        jsr rsUnknown969E6A
        sep #$20
        sta $2180,b
        xba
        sta $2180,b
        rep #$20
        lda $02A2,b,x
        jsr rsUnknown969E6A
        sep #$20
        sta $2180,b
        xba
        sta $2180,b
        rep #$20
        lda $02C2,b,x
        jsr rsUnknown969E6A
        sep #$20
        sta $2180,b
        xba
        sta $2180,b
        rep #$20
        inc x
        inc x
        cpx #$001E
        bcc _9E23
        lda wR0
        inc a
        cmp #$0019
        bcs _9E69
        jml _9DCB


        _9E69
        rtl

        .databank 0

        ; 96/9E6A

      rsUnknown969E6A ; 96/9E6A

        .al
        .xl
        .autsiz
        .databank ?

        phx
        pha
        eor #$FFFF
        pha
        and #$001F
        sta wR10
        lda wR1
        sta wR11
        jsl rlUnsignedMultiply16By16
        lda wR12+1
        and #$001F
        sta wR2
        pla
        pha
        and #$03E0
        sta wR10
        lda wR1
        sta wR11
        jsl rlUnsignedMultiply16By16
        lda wR12+1
        and #$03E0
        ora wR2
        sta wR2
        pla
        pha
        and #$7C00
        sta wR10
        lda wR1
        sta wR11
        jsl rlUnsignedMultiply16By16
        lda wR12+1
        and #$7C00
        ora wR2
        sta wR2
        pla
        pla
        clc
        adc wR2
        plx
        rts

        .databank 0

        ; 96/9EBB

      rlUnknown969EBB ; 96/9EBB

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FFC59
        bit #$0008
        beq _9EF8
        sep #$20
        lda $7FFC6F
        ora #$48
        sta $7FFC6F
        rep #$20
        lda #$9500
        sta lR44+1
        lda #$E754
        sta lR44
        lda #$0003
        sta wR40
        jsl rlHDMAEngineCreateEntryByIndex
        lda #$9500
        sta lR44+1
        lda #$E760
        sta lR44
        lda #$0006
        sta wR40
        jsl rlHDMAEngineCreateEntryByIndex

        _9EF8
        rtl

        .databank 0

        ; 96/9EF9

    .endsection Unsorted969C63Section


    .section Unsorted969EF9Section

      .al
      .xl

      rlUnknown969EF9 ; 96/9EF9

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$FF
        sta $7FFC72
        lda #$00
        sta $7FFC73
        lda #$FC
        sta $7FFC75
        lda #$7F
        sta $7FFC74
        lda #$97
        sta $7FFC76
        rep #$20
        rtl

        .databank 0

        ; 96/9F1C

      rlUnknown969F1C ; 96/9F1C

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FFC72
        and #$00FF
        cmp #$00FF
        beq _9F69
        phx
        asl a
        tax
        lda $998F0F,x
        cmp #$8080
        bne _9F3A
        jsl rlUnknown969EF9
        bra _9F68


        _9F3A
        sep #$20
        sta $7FFC73
        clc
        adc #$FC
        sta $7FFC75
        lda $998F10,x
        clc
        adc #$7F
        sta $7FFC74
        lda $998F10,x
        clc
        adc #$97
        sta $7FFC76
        lda $7FFC72
        inc a
        sta $7FFC72
        rep #$20

        _9F68
        plx

        _9F69
        rtl

        .databank 0

        ; 96/9F6A

      rlUnknown969F6A ; 96/9F6A

        .al
        .xl
        .autsiz
        .databank ?

        lda $0AE4,b
        bit #$0040
        beq _9F7C
        sep #$20
        lda #$00
        sta $7FFC72
        rep #$20

        _9F7C
        rtl

        .databank 0

        ; 96/9F7D

    .endsection Unsorted969EF9Section


    .section Unsorted969F7DSection

      .al
      .xl

      rlUnknown969F7D ; 96/9F7D

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda wBattleDistance
        cmp #$0002
        bcs _9FC1
        ldx #$0000
        ldy #$0000

        _9F8E
        lda $7E4F85,x
        cmp #$FFFF
        beq _9FC1
        cmp #$FEFF
        beq _9FC1
        bit #$0080
        bne _9FBD
        bit #$0002
        bne _9FC1
        bit #$0001
        bne _9FB5
        cpy #$0002
        beq _9FC4
        ldy #$0001
        bra _9FBD


        _9FB5
        cpy #$0001
        beq _9FC4
        ldy #$0002

        _9FBD
        inc x
        inc x
        bra _9F8E


        _9FC1
        clc
        bra _9FC5


        _9FC4
        sec

        _9FC5
        ply
        plx
        rtl

        .databank 0

        ; 96/9FC8

      rlUnknown969FC8 ; 96/9FC8

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda $7FFC77
        ora #$02
        sta $7FFC77
        rep #$20
        rtl

        .databank 0

        ; 96/9FD7

      rlUnknown969FD7 ; 96/9FD7

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FFC77
        bit #$0002
        beq _9FEA
        sep #$20
        eor #$03
        sta $7FFC77
        rep #$20

        _9FEA
        rtl

        .databank 0

        ; 96/9FEB

      rlUnknown969FEB ; 96/9FEB

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FFC7C
        sta aSpriteExtBuffer,b
        lda $7FFC7E
        sta $1E02,b
        lda $7FFC80
        sta $1E04,b
        lda $7FFC82
        sta $1E06,b
        lda $7FFC84
        sta $1E08,b
        lda $7FFC86
        sta $1E0A,b
        lda $7FFC88
        sta $1E0C,b
        lda $7FFC8A
        sta $1E0E,b
        lda $7FFC8C
        sta $1E10,b
        lda $7FFC8E
        sta $1E12,b
        lda $7FFC90
        sta $1E14,b
        lda $7FFC92
        sta $1E16,b
        lda $7FFC94
        sta $1E18,b
        lda $7FFC96
        sta $1E1A,b
        lda $7FFC98
        sta $1E1C,b
        lda $7FFC9A
        sta $1E1E,b
        rtl

        .databank 0

        ; 96/A05C

    .endsection Unsorted969F7DSection


    .section Unsorted96A05CSection

      .al
      .xl

      rlUnknown96A05C ; 96/A05C

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FFC77
        bit #$0002
        beq _A0E1
        bit #$0001
        bne _A0E1
        lda wNextFreeSpriteOffset,b
        sta $7FFC78
        lda aSpriteExtBuffer,b
        sta $7FFC7C
        lda $1E02,b
        sta $7FFC7E
        lda $1E04,b
        sta $7FFC80
        lda $1E06,b
        sta $7FFC82
        lda $1E08,b
        sta $7FFC84
        lda $1E0A,b
        sta $7FFC86
        lda $1E0C,b
        sta $7FFC88
        lda $1E0E,b
        sta $7FFC8A
        lda $1E10,b
        sta $7FFC8C
        lda $1E12,b
        sta $7FFC8E
        lda $1E14,b
        sta $7FFC90
        lda $1E16,b
        sta $7FFC92
        lda $1E18,b
        sta $7FFC94
        lda $1E1A,b
        sta $7FFC96
        lda $1E1C,b
        sta $7FFC98
        lda $1E1E,b
        sta $7FFC9A

        _A0E1
        rtl

        .databank 0

        ; 96/A0E2

      rlUnknown96A0E2 ; 96/A0E2

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FFC78
        sta $7FFC7A
        rtl

        .databank 0

        ; 96/A0EB

    .endsection Unsorted96A05CSection


    .section Unsorted96A20ESection

      .al
      .xl

      rlUnknown96A20E ; 96/A20E

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda $7FFC59
        bit #$0400
        beq _A21E
        lda #$004C
        jsl rlUnknown96A4B2

        _A21E
        rtl

        .databank 0

        ; 96/A21F

      rlUnknown96A21F ; 96/A21F

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7FE4C2
        and #$00FF
        cmp #$0003
        bne _A26D
        lda @l $0018A5
        cmp #$0002
        bcc _A23A
        lda #$891A
        bra _A247


        _A23A
        cmp #$0001
        bne _A244
        lda #$890A
        bra _A247


        _A244
        lda #$88FA

        _A247
        sta lR18
        sep #$20
        lda #$99
        sta lR18+2
        rep #$20
        lda #$0008
        ldy #$6A83
        jsl rlUnknown95C43E
        lda lR18
        clc
        adc #$0008
        sta lR18
        lda #$0008
        ldy #$6AA3
        jsl rlUnknown95C43E

        _A26D
        plx
        rtl

        .databank 0

        ; 96/A26F

      rlUnknown96A26F ; 96/A26F

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda $7FE4B7
        and #$7F
        sta $7FE4B7
        lda #$00
        sta $7FE4B8
        rep #$20
        lda #$0000
        sta $7FE4BE
        rtl

        .databank 0

        ; 96/A28B

    .endsection Unsorted96A20ESection


    .section Unsorted96A28BSection

      .al
      .xl

      rlUnknown96A28B ; 96/A28B

        .al
        .xl
        .autsiz
        .databank ?

        phy
        lda $7FE4B7
        bit #$0080
        bne _A299
        jml _A32E


        _A299
        lda wJoy1Input
        cmp #$0080
        bne _A2A7
        lda #$0000
        sta $7FE4C0

        _A2A7
        lda $7FE4BE
        beq _A2B4
        dec a
        sta $7FE4BE
        bra _A32E


        _A2B4
        lda $7FE4C0
        beq _A2C1
        dec a
        sta $7FE4C0
        bra _A32E


        _A2C1
        lda $7FE4B8
        and #$00FF
        bne _A32E
        lda $7FE4BA
        sta lR18+1

        _A2D0
        lda $7FE4BC
        sta lR18
        ldy #$0000
        lda [lR18],y
        cmp #$FFFF
        bne _A2E5
        jsr rsUnknown96A334
        bra _A32E


        _A2E5
        cmp #$FFFE
        bne _A2EF
        jsr rsUnknown96A343
        bra _A32E


        _A2EF
        cmp #$FFFD
        bne _A2F9
        jsr rsUnknown96A359
        bra _A2D0


        _A2F9
        cmp #$FFFC
        bne _A303
        jsr rsUnknown96A36F
        bra _A2D0


        _A303
        cmp #$FFFB
        bne _A30D
        jsr rsUnknown96A3C5
        bra _A2D0


        _A30D
        cmp #$FFF8
        bne _A317
        jsr rsUnknown96A3D8
        bra _A2D0


        _A317
        cmp #$FFFA
        bne _A321
        jsr rsUnknown96A385
        bra _A2D0


        _A321
        cmp #$FFF9
        bne _A32B
        jsr rsUnknown96A396
        bra _A2D0


        _A32B
        jsr rsUnknown96A3F3

        _A32E
        jsl rlUnknown96C9AD
        ply
        rtl

        .databank 0

        ; 96/A334

      rsUnknown96A334 ; 96/A334

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda $7FE4B7
        and #$7F
        sta $7FE4B7
        rep #$20
        rts

        .databank 0

        ; 96/A343

      rsUnknown96A343 ; 96/A343

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FE4B8
        and #$00FF
        bne _A358
        lda $7FE4BC
        clc
        adc #$0002
        sta $7FE4BC

        _A358
        rts

        .databank 0

        ; 96/A359

      rsUnknown96A359 ; 96/A359

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx $0AE9,b
        jsl rlUnknown95C057
        lda $7FE4BC
        clc
        adc #$0002
        sta $7FE4BC
        plx
        rts

        .databank 0

        ; 96/A36F

      rsUnknown96A36F ; 96/A36F

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx $0AE9,b
        jsl rlUnknown95C077
        lda $7FE4BC
        clc
        adc #$0002
        sta $7FE4BC
        plx
        rts

        .databank 0

        ; 96/A385

      rsUnknown96A385 ; 96/A385

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown95AEA2
        lda $7FE4BC
        clc
        adc #$0002
        sta $7FE4BC
        rts

        .databank 0

        ; 96/A396

      rsUnknown96A396 ; 96/A396

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown96F9BF
        lda $0AE4,b
        bit #$0008
        beq _A3B8
        phx
        ldx $0AE9,b
        cpx #$0000
        beq _A3B0
        ldx #$0000
        bra _A3B3


        _A3B0
        ldx #$0043

        _A3B3
        jsl rlUnknown95AB53
        plx

        _A3B8
        lda $7FE4BC
        clc
        adc #$0002
        sta $7FE4BC
        rts

        .databank 0

        ; 96/A3C5

      rsUnknown96A3C5 ; 96/A3C5

        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsl rlUnknown95B006
        lda $7FE4BC
        clc
        adc #$0002
        sta $7FE4BC
        plx
        rts

        .databank 0

        ; 96/A3D8

      rsUnknown96A3D8 ; 96/A3D8

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $0AE0,b
        bit #$0040
        bne _A3E5
        jsl rlUnknown95B02B

        _A3E5
        lda $7FE4BC
        clc
        adc #$0002
        sta $7FE4BC
        plx
        rts

        .databank 0

        ; 96/A3F3

      rsUnknown96A3F3 ; 96/A3F3

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        pha
        and #$3E00
        xba
        lsr a
        sta wR0
        pla
        tay
        phb
        jsl _A407
        plb
        .databank ?
        bra _A429


        _A407
        lda wR0
        cmp #$0019
        bmi _A410

        _A40E
        bra _A40E


        _A410
        asl a
        adc wR0
        tax
        lda $96A42C,x
        sta lR23
        sep #$20
        lda $96A42E,x
        sta lR23+2
        pha
        plb
        .databank ?
        rep #$20
        jml [lR23]


        _A429
        ply
        plx
        rts

        .databank 0

        ; 96/A42C

    .endsection Unsorted96A28BSection


    .section Unsorted96A477Section

      .al
      .xl

      rsUnknown96A477 ; 96/A477

        .al
        .xl
        .autsiz
        .databank ?

        pha
        and #$C000
        cmp #$4000
        bne _A48D
        sep #$20
        lda $7FE4B8
        inc a
        sta $7FE4B8
        rep #$20

        _A48D
        lda $7FE4BC
        clc
        adc #$0002
        sta $7FE4BC
        pla
        rts

        .databank 0

        ; 96/A49B

      rsUnknown96A49B ; 96/A49B

        .al
        .xl
        .autsiz
        .databank ?

        pha
        and #$C000
        cmp #$4000
        bne _A4A4

        _A4A4
        lda $7FE4BC
        clc
        adc #$0002
        sta $7FE4BC
        pla
        rts

        .databank 0

        ; 96/A4B2

    .endsection Unsorted96A477Section


    .section Unsorted96A4B2Section

      .al
      .xl

      rlUnknown96A4B2 ; 96/A4B2

        .al
        .xl
        .autsiz
        .databank ?

        phy
        pha
        lda $7FE4B7
        bit #$0080
        bne _A4F9
        sep #$20
        lda $7FE4B7
        ora #$80
        sta $7FE4B7
        lda #$00
        sta $7FE4B8
        rep #$20
        pla
        asl a
        pha
        lda #$9700
        sta $7FE4BA
        sta lR18+1
        lda #$8F7D
        clc
        adc #1,s
        sta lR18
        pla
        ldy #$0000
        lda [lR18],y
        clc
        adc #$8F7D
        sta $7FE4B9
        sta $7FE4BC
        bra _A4FA


        _A4F9
        pla

        _A4FA
        ply
        rtl

        .databank 0

        ; 96/A4FC

    .endsection Unsorted96A4B2Section


    .section Unsorted96A4FCSection

      .al
      .xl

      rlUnknown96A4FC ; 96/A4FC

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$00
        sta $7FEC1D
        sta $7FEC41
        sta aUnit2DataBuffer._ROM.Skills1
        sta $7FEC50
        lda #$10
        sta $7FEC65
        lda #$70
        sta $7FEC66
        rep #$20
        lda #$0000
        sta aUnit2DataBuffer._Inventory.ItemCount
        sta aUnit2DataBuffer._Inventory.Items
        sta $7FEC5A
        sta $7FEC5C
        rtl

        .databank 0

        ; 96/A532

    .endsection Unsorted96A4FCSection


    .section Unsorted96A532Section

      .al
      .xl

      rlUnknown96A532 ; 96/A532

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0000
        jsl rlUnknown96A541
        ldx #$0024
        jsl rlUnknown96A541
        rtl

        .databank 0

        ; 96/A541

      rlUnknown96A541 ; 96/A541

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda $7FEC1D,x
        bit #$0080
        bne _A559
        lda $7FEC1D,x
        bit #$0020
        bne _A55F
        jml _A6F1


        _A559
        jsr rsUnknown96A715
        jsr rsUnknown96B719

        _A55F
        sep #$20
        phb
        lda #$7F
        pha
        plb
        .databank $7F
        rep #$20
        cpx #$0000
        bne _A572
        ldy #$0000
        bra _A575


        _A572
        ldy #$001C

        _A575
        lda @l $7FEC1D,x
        bit #$0010
        beq _A59E
        lda @l $7FEC1F,x
        sep #$20
        sta $E4DE,b,y
        lda @l aUnit2DataBuffer._ROM.SkillGrowth,x
        sec
        sbc @l aUnit2DataBuffer._ROM.SpeedGrowth,x
        sta $E4DF,b,y
        lda @l $7FEC25,x
        sta $E4E1,b,y
        rep #$20
        bra _A5C6


        _A59E
        lda @l $7FEC1F,x
        sec
        sbc @l $7FE198
        sep #$20
        sta $E4DE,b,y
        lda @l aUnit2DataBuffer._ROM.SkillGrowth,x
        sec
        sbc @l aUnit2DataBuffer._ROM.SpeedGrowth,x
        sec
        sbc @l $7FE19A
        sta $E4DF,b,y
        lda @l $7FEC25,x
        sta $E4E1,b,y
        rep #$20

        _A5C6
        plb
        .databank $7F
        lda @l $7FEC1D,x
        and #$000F
        cmp #$0009
        bne _A5D7
        jml _A6CE


        _A5D7
        cmp #$0001
        beq _A631
        cmp #$0002
        beq _A646
        cmp #$0003
        beq _A658
        cmp #$0004
        bne _A5EF
        jml _A671


        _A5EF
        cmp #$0005
        bne _A5F8
        jml _A688


        _A5F8
        cmp #$0006
        bne _A601
        jml _A69F


        _A601
        cmp #$0007
        bne _A60A
        jml _A6BB


        _A60A
        cmp #$000A
        bne _A613
        jml _A6E1


        _A613
        phx
        tyx
        lda @l $7FE4E1,x
        and #$00FF
        asl a
        sta @l $7FE4E2,x
        jsl rlUnknown96A6F7
        lda #$0078
        jsl rlUnknown96ADE9
        plx
        jml _A6F1


        _A631
        phx
        tyx
        jsr rsUnknown96B5D2
        jsl rlUnknown96A6F7
        lda #$0078
        jsl rlUnknown96ADE9
        plx
        jml _A6F1


        _A646
        phx
        tyx
        jsr rsUnknown96B5D2
        jsl rlUnknown96A6F7
        jsl rlUnknown96B317
        plx
        jml _A6F1


        _A658
        phx
        tyx
        lda @l $7FE4E1,x
        and #$00FF
        sta @l $7FE4E2,x
        jsl rlUnknown96A6F7
        jsr rsUnknown96B0E1
        plx
        jml _A6F1


        _A671
        phx
        tyx
        lda @l $7FE4E1,x
        and #$00FF
        sta @l $7FE4E2,x
        jsl rlUnknown96A6F7
        jsr rsUnknown96B1AE
        plx
        bra _A6F1


        _A688
        phx
        tyx
        lda @l $7FE4E1,x
        and #$00FF
        sta @l $7FE4E2,x
        jsl rlUnknown96A6F7
        jsr rsUnknown96B254
        plx
        bra _A6F1


        _A69F
        phx
        tyx
        lda @l $7FE4E1,x
        and #$00FF
        asl a
        sta @l $7FE4E2,x
        jsl rlUnknown96A6F7
        lda #$00C0
        jsl rlUnknown96ADE9
        plx
        bra _A6F1


        _A6BB
        phx
        tyx
        jsr rsUnknown96B623
        jsl rlUnknown96A6F7
        lda #$00C0
        jsl rlUnknown96AEDC
        plx
        bra _A6F1


        _A6CE
        phx
        tyx
        jsr rsUnknown96B623
        jsl rlUnknown96A6F7
        lda #$0070
        jsl rlUnknown96AFCF
        plx
        bra _A6F1


        _A6E1
        phx
        tyx
        jsr rsUnknown96B623
        jsl rlUnknown96A6F7
        lda #$0070
        jsr rsUnknown96B43B
        plx

        _A6F1
        jsr rsUnknown96B6E3
        ply
        plx
        rtl

        .databank 0

        ; 96/A6F7

      rlUnknown96A6F7 ; 96/A6F7

        .al
        .xl
        .autsiz
        .databank ?

        pha
        cpx #$0000
        bne _A709
        lda #$7F00
        sta lR18+1
        lda #$E51D
        sta lR18
        bra _A713


        _A709
        lda #$7F00
        sta lR18+1
        lda #$E6DD
        sta lR18

        _A713
        pla
        rtl

        .databank 0

        ; 96/A715

      rsUnknown96A715 ; 96/A715

        .al
        .xl
        .autsiz
        .databank ?

        phx
        sep #$20
        lda $7FEC2B,x
        beq _A727
        dec a
        sta $7FEC2B,x
        jml _A7DF


        _A727
        rep #$20

        _A729
        jsr rsUnknown96ABE2
        xba
        and #$00FF
        cmp #$00FF
        bne _A73C
        jsr rsUnknown96A7E3
        jml _A7DF


        _A73C
        cmp #$00FD
        bne _A748
        jsr rsUnknown96A81C
        jml _A7DF


        _A748
        cmp #$00FE
        bne _A754
        jsr rsUnknown96A843
        jml _A7DB


        _A754
        cmp #$00FC
        bne _A75E
        jsr rsUnknown96A87E
        bra _A7DB


        _A75E
        cmp #$00FB
        bne _A768
        jsr rsUnknown96A8B2
        bra _A7DB


        _A768
        cmp #$00FA
        bne _A772
        jsr rsUnknown96A913
        bra _A7DB


        _A772
        cmp #$00F9
        bne _A77C
        jsr rsUnknown96A928
        bra _A7DF


        _A77C
        cmp #$00F8
        bne _A786
        jsr rsUnknown96A937
        bra _A7DB


        _A786
        cmp #$00F7
        bne _A790
        jsr rsUnknown96A969
        bra _A7DB


        _A790
        cmp #$00F6
        bne _A79A
        jsr rsUnknown96A99B
        bra _A7DB


        _A79A
        cmp #$00F5
        bne _A7A4
        jsr rsUnknown96AA10
        bra _A7DB


        _A7A4
        cmp #$00F4
        bne _A7AE
        jsr rsUnknown96AA54
        bra _A7DB


        _A7AE
        cmp #$00F3
        bne _A7B8
        jsr rsUnknown96AAA4
        bra _A7DB


        _A7B8
        cmp #$00F2
        bne _A7C2
        jsr rsUnknown96AB0E
        bra _A7DB


        _A7C2
        cmp #$00F1
        bne _A7CC
        jsr rsUnknown96AB4B
        bra _A7DB


        _A7CC
        cmp #$00F0
        bne _A7D6
        jsr rsUnknown96AB88
        bra _A7DB


        _A7D6
        jsr rsUnknown96ABC5
        bra _A7DF


        _A7DB
        jml _A729


        _A7DF
        .as
        rep #$20
        plx
        rts

        .databank 0

        ; 96/A7E3

      rsUnknown96A7E3 ; 96/A7E3

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FEC1D,x
        bit #$0080
        beq _A81B
        jsr rsUnknown96ACAB
        sep #$20
        lda $7FEC1D,x
        and #$7F
        sta $7FEC1D,x
        rep #$20
        lda #$0000
        sta aUnit2DataBuffer._Inventory.ItemCount,x
        sta $7FEC3A,x
        sta $7FEC3F,x
        sep #$20
        lda $7FE4B8
        beq _A815
        dec a

        _A815
        sta $7FE4B8
        rep #$20

        _A81B
        rts

        .databank 0

        ; 96/A81C

      rsUnknown96A81C ; 96/A81C

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FEC1D,x
        bit #$0080
        beq _A842
        sep #$20
        lda $7FEC1D,x
        and #$7F
        sta $7FEC1D,x
        rep #$20
        sep #$20
        lda $7FE4B8
        beq _A83C
        dec a

        _A83C
        sta $7FE4B8
        rep #$20

        _A842
        rts

        .databank 0

        ; 96/A843

      rsUnknown96A843 ; 96/A843

        .al
        .xl
        .autsiz
        .databank ?

        lda aUnit2DataBuffer._ROM.Skills1,x
        and #$00FF
        beq _A865
        dec a
        sep #$20
        sta aUnit2DataBuffer._ROM.Skills1,x
        rep #$20
        bne _A875
        lda $7FEC29,x
        clc
        adc #$0002
        sta $7FEC29,x
        bra _A87D


        _A865
        jsr rsUnknown96ABE2
        and #$00FF
        beq _A875
        sep #$20
        sta aUnit2DataBuffer._ROM.Skills1,x
        rep #$20

        _A875
        lda aUnit2DataBuffer._ROM.DefenseGrowth,x
        sta $7FEC29,x

        _A87D
        rts

        .databank 0

        ; 96/A87E

      rsUnknown96A87E ; 96/A87E

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phy
        ldy $0AE9,b
        lda $0AF8,b,y
        sta aUnit2DataBuffer._ROM.StrengthGrowth,x
        lda $0AF9,b,y
        sta $7FEC1F,x
        lda $0AFB,b,y
        sta $7FEC21,x
        lda $0AFD,b,y
        clc
        adc #$3000
        sta $7FEC23,x
        lda $7FEC29,x
        clc
        adc #$0002
        sta $7FEC29,x
        ply
        pla
        rts

        .databank 0

        ; 96/A8B2

      rsUnknown96A8B2 ; 96/A8B2

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        phy
        ldy $0AEB,b
        lda $0AF8,b,y
        sta aUnit2DataBuffer._ROM.StrengthGrowth,x
        lda $0AF9,b,y
        sta $7FEC1F,x
        lda $0AFB,b,y
        sta $7FEC21,x
        lda $0AFD,b,y
        clc
        adc #$1000
        sta $7FEC23,x
        jsl rlUnknown95B050
        lda wR0
        cmp #$0100
        bcc _A903
        lda $7FEC1F
        cmp #$0180
        bcc _A8F1
        lda #$0180
        bra _A8FB


        _A8F1
        cmp #$0080
        bcs _A8FB
        lda #$0080
        bra _A8FB


        _A8FB
        sec
        sbc #$0080
        sta $7FE198

        _A903
        lda $7FEC29,x
        clc
        adc #$0002
        sta $7FEC29,x
        ply
        plx
        pla
        rts

        .databank 0

        ; 96/A913

      rsUnknown96A913 ; 96/A913

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        jsl rlUnknown96B672
        lda $7FEC29,x
        clc
        adc #$0002
        sta $7FEC29,x
        plx
        pla
        rts

        .databank 0

        ; 96/A928

      rsUnknown96A928 ; 96/A928

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        sep #$20
        lda #$01
        sta $7FEC2B,x
        rep #$20
        plx
        pla
        rts

        .databank 0

        ; 96/A937

      rsUnknown96A937 ; 96/A937

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        phy
        ldy $0AE9,b
        lda $0AF8,b,y
        sta aUnit2DataBuffer._ROM.StrengthGrowth,x
        lda $0AF9,b,y
        sta $7FEC1F,x
        lda $0AFB,b,y
        sta $7FEC21,x
        lda #$0000
        sta $7FEC23,x
        lda $7FEC29,x
        clc
        adc #$0002
        sta $7FEC29,x
        ply
        plx
        pla
        rts

        .databank 0

        ; 96/A969

      rsUnknown96A969 ; 96/A969

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        phy
        ldy $0AEB,b
        lda $0AF8,b,y
        sta aUnit2DataBuffer._ROM.StrengthGrowth,x
        lda $0AF9,b,y
        sta $7FEC1F,x
        lda $0AFB,b,y
        sta $7FEC21,x
        lda #$0000
        sta $7FEC23,x
        lda $7FEC29,x
        clc
        adc #$0002
        sta $7FEC29,x
        ply
        plx
        pla
        rts

        .databank 0

        ; 96/A99B

      rsUnknown96A99B ; 96/A99B

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        phy
        ldy $0AEB,b
        lda $0AF8,b,y
        sta aUnit2DataBuffer._ROM.StrengthGrowth,x
        lda $0AF9,b,y
        sta $7FEC1F,x
        lda $7FEC65
        and #$00FF
        xba
        pha
        lda $0AFB,b,y
        sec
        sbc #1,s
        sta $7FEC21,x
        pla
        phx
        ldx $0AEB,b
        jsl rlUnknown95B5FD
        sec
        sbc #$0010
        xba
        plx
        sta $7FEC23,x
        jsl rlUnknown95B050
        lda wR0
        cmp #$0100
        bcc _AA00
        lda $7FEC1F,x
        cmp #$0180
        bcc _A9EE
        lda #$0180
        bra _A9F8


        _A9EE
        cmp #$0080
        bcs _A9F8
        lda #$0080
        bra _A9F8


        _A9F8
        sec
        sbc #$0080
        sta $7FE198,x

        _AA00
        lda $7FEC29,x
        clc
        adc #$0002
        sta $7FEC29,x
        ply
        plx
        pla
        rts

        .databank 0

        ; 96/AA10

      rsUnknown96AA10 ; 96/AA10

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        phy
        ldy $0AEB,b
        lda #$0000
        sta aUnit2DataBuffer._ROM.StrengthGrowth,x
        lda $7FE198
        clc
        adc #$0080
        sta $7FEC1F,x
        lda $7FEC65
        and #$00FF
        xba
        pha
        lda $0AFB,b,y
        sec
        sbc #1,s
        sta $7FEC21,x
        pla
        lda #$F400
        sta $7FEC23,x
        lda $7FEC29,x
        clc
        adc #$0002
        sta $7FEC29,x
        ply
        plx
        pla
        rts

        .databank 0

        ; 96/AA54

      rsUnknown96AA54 ; 96/AA54

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        sep #$20
        lda $7FEC1D,x
        ora #$20
        sta $7FEC1D,x
        rep #$20
        lda #$0000
        sta aUnit2DataBuffer._ROM.StrengthGrowth,x
        lda $7FE477
        and #$03FF
        sec
        sbc #$0100
        clc
        adc #$0100
        sta $7FEC1F,x
        lda $7FE47A
        clc
        adc #$0080
        and #$00FF
        xba
        sta $7FEC23,x
        lda #$0064
        sta $7FEC21,x
        lda $7FEC29,x
        clc
        adc #$0002
        sta $7FEC29,x
        plx
        pla
        rts

        .databank 0

        ; 96/AAA4

      rsUnknown96AAA4 ; 96/AAA4

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        phy
        ldy $0AEB,b
        lda $0AF8,b,y
        sta aUnit2DataBuffer._ROM.StrengthGrowth,x
        lda $0AF9,b,y
        sta $7FEC1F,x
        lda $7FEC65
        and #$00FF
        xba
        pha
        lda $0AFB,b,y
        sec
        sbc #1,s
        sta $7FEC21,x
        pla
        lda #$F000
        sta $7FEC23,x
        jsl rlUnknown95B050
        lda wR0
        cmp #$0100
        bcc _AAFE
        lda $7FEC1F,x
        cmp #$0180
        bcc _AAEC
        lda #$0180
        bra _AAF6


        _AAEC
        cmp #$0080
        bcs _AAF6
        lda #$0080
        bra _AAF6


        _AAF6
        sec
        sbc #$0080
        sta $7FE198,x

        _AAFE
        lda $7FEC29,x
        clc
        adc #$0002
        sta $7FEC29,x
        ply
        plx
        pla
        rts

        .databank 0

        ; 96/AB0E

      rsUnknown96AB0E ; 96/AB0E

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        sep #$20
        lda $7FEC1D,x
        and #$DF
        ora #$10
        sta $7FEC1D,x
        rep #$20
        lda #$0000
        sta aUnit2DataBuffer._ROM.StrengthGrowth,x
        lda #$0080
        sta $7FEC1F,x
        lda #$4A00
        sta $7FEC21,x
        lda #$0000
        sta $7FEC23,x
        lda $7FEC29,x
        clc
        adc #$0002
        sta $7FEC29,x
        plx
        pla
        rts

        .databank 0

        ; 96/AB4B

      rsUnknown96AB4B ; 96/AB4B

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        sep #$20
        lda $7FEC1D,x
        and #$DF
        ora #$10
        sta $7FEC1D,x
        rep #$20
        lda #$0000
        sta aUnit2DataBuffer._ROM.StrengthGrowth,x
        lda #$0080
        sta $7FEC1F,x
        lda #$4A10
        sta $7FEC21,x
        lda #$0000
        sta $7FEC23,x
        lda $7FEC29,x
        clc
        adc #$0002
        sta $7FEC29,x
        plx
        pla
        rts

        .databank 0

        ; 96/AB88

      rsUnknown96AB88 ; 96/AB88

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        sep #$20
        lda $7FEC1D,x
        and #$DF
        ora #$10
        sta $7FEC1D,x
        rep #$20
        lda #$0000
        sta aUnit2DataBuffer._ROM.StrengthGrowth,x
        lda #$0080
        sta $7FEC1F,x
        lda #$3400
        sta $7FEC21,x
        lda #$0000
        sta $7FEC23,x
        lda $7FEC29,x
        clc
        adc #$0002
        sta $7FEC29,x
        plx
        pla
        rts

        .databank 0

        ; 96/ABC5

      rsUnknown96ABC5 ; 96/ABC5

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown96ABE2
        sep #$20
        sta $7FEC25,x
        xba
        sta $7FEC2B,x
        rep #$20
        lda $7FEC29,x
        clc
        adc #$0002
        sta $7FEC29,x
        rts

        .databank 0

        ; 96/ABE2

      rsUnknown96ABE2 ; 96/ABE2

        .al
        .xl
        .autsiz
        .databank ?

        phy
        lda $7FEC27,x
        sta lR18+1
        lda $7FEC29,x
        sta lR18
        ldy #$0000
        lda [lR18],y
        ply
        rts

        .databank 0

        ; 96/ABF6

    .endsection Unsorted96A532Section


    .section Unsorted96AC1FSection

      .al
      .xl

      rlUnknown96AC1F ; 96/AC1F

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        ldy #$0000
        sep #$20
        lda [lR18],y
        inc y
        bit #$40
        bne _AC32
        ldx #$0000
        bra _AC35


        _AC32
        ldx #$0024

        _AC35
        bit #$80
        beq _AC45
        ora #$80
        ora $7FEC1D,x
        sta $7FEC1D,x
        bra _AC8D


        _AC45
        ora #$80
        sta $7FEC1D,x
        lda [lR18],y
        ora bBufferW12SEL
        sta bBufferW12SEL
        sta $2123,b
        inc y
        lda [lR18],y
        ora bBufferW34SEL
        sta bBufferW34SEL
        sta $2124,b
        inc y
        lda [lR18],y
        ora bBufferWOBJSEL
        sta bBufferWOBJSEL
        sta $2125,b
        inc y
        lda #$00
        sta bBufferWH0
        lda #$FF
        sta bBufferWH1
        lda #$00
        sta bBufferWH2
        lda #$FF
        sta bBufferWH3
        lda [lR18],y
        sta bBufferWBGLOG
        inc y
        lda [lR18],y
        sta bBufferWBGLOG
        inc y
        lda [lR18],y
        sta bBufferTMW
        inc y
        lda [lR18],y
        sta bBufferTSW
        inc y

        _AC8D
        lda lR18+2
        sta aUnit2DataBuffer._ROM.ResistanceGrowth,x
        rep #$20
        tya
        clc
        adc lR18
        sta aUnit2DataBuffer._ROM.DefenseGrowth,x
        sta $7FEC29,x
        jsl rlUnknown96AD39
        jsr rsUnknown96AD07
        ply
        plx
        rtl

        .databank 0

        ; 96/ACAB

    .endsection Unsorted96AC1FSection


    .section Unsorted96ACABSection

      .al
      .xl

      rsUnknown96ACAB ; 96/ACAB

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$00
        sta bBufferW12SEL
        sta $2123,b
        sta bBufferW34SEL
        sta $2124,b
        sta bBufferWOBJSEL
        sta $2125,b
        sta bBufferTMW
        sta bBufferTSW
        rep #$20
        rts

        .databank 0

        ; 96/ACC5

    .endsection Unsorted96ACABSection


    .section Unsorted96AD07Section

      .al
      .xl

      rsUnknown96AD07 ; 96/AD07

        .al
        .xl
        .autsiz
        .databank ?

        phx
        cpx #$0000
        bne _AD22
        lda #$9500
        sta lR44+1
        lda #$E6BA
        sta lR44
        lda #$0003
        sta wR40
        jsl rlHDMAEngineCreateEntryByIndex
        bra _AD35


        _AD22
        lda #$9500
        sta lR44+1
        lda #$E6C6
        sta lR44
        lda #$0006
        sta wR40
        jsl rlHDMAEngineCreateEntryByIndex

        _AD35
        plx
        rts

        .databank 0

        ; 96/AD37

    .endsection Unsorted96AD07Section


    .section Unsorted96AD39Section

      .al
      .xl

      rlUnknown96AD39 ; 96/AD39

        .al
        .xl
        .autsiz
        .databank ?

        phx
        cpx #$0000
        bne _AD47
        lda #$E51D
        ldx #$0000
        bra _AD4D


        _AD47
        lda #$E6DD
        ldx #$001C

        _AD4D
        sta wR0
        lda $7FE09E
        bit #$0001
        beq _AD5D
        lda #$0380
        bra _AD60


        _AD5D
        lda #$0000

        _AD60
        clc
        adc wR0
        sta wR0
        lda $7FEC65
        and #$00FF
        beq _AD9C
        dec a
        cmp #$0080
        bcc _AD8B
        pha
        lda #$00FF
        sta $7FE4EA,x
        inc x
        lda #$E51B
        sta $7FE4EA,x
        inc x
        inc x
        pla
        sec
        sbc #$007F

        _AD8B
        ora #$0080
        sta $7FE4EA,x
        inc x
        lda #$E51B
        sta $7FE4EA,x
        inc x
        inc x

        _AD9C
        lda $7FEC66
        and #$00FF
        beq _ADE7
        cmp #$0080
        bcc _ADD9
        pha
        lda #$00FF
        sta $7FE4EA,x
        phx
        txa
        sec
        sbc #3,s
        pha
        lda #5,s
        tax
        pla
        sep #$20
        sta $7FE4E9,x
        rep #$20
        plx
        inc x
        lda wR0
        sta $7FE4EA,x
        inc x
        inc x
        clc
        adc #$00FE
        sta wR0
        pla
        sec
        sbc #$007F

        _ADD9
        ora #$0080
        sta $7FE4EA,x
        inc x
        lda wR0
        sta $7FE4EA,x

        _ADE7
        plx
        rtl

        .databank 0

        ; 96/ADE9

    .endsection Unsorted96AD39Section


    .section Unsorted96ADE9Section

      .al
      .xl

      rlUnknown96ADE9 ; 96/ADE9

        .al
        .xl
        .autsiz
        .databank ?

        phx
        sta wR0
        phd
        lda #$0000
        pha
        pld
        lda lR18+1
        and #$01FF
        sta $2182,b
        lda $7FE09E
        bit #$0001
        bne _AE08
        lda #$0380
        bra _AE0B


        _AE08
        lda #$0000

        _AE0B
        clc
        adc lR18
        sta $2181,b
        lda $7FE4DE,x
        and #$00FF
        sta wR1
        lda $7FE4DF,x
        sec
        sbc #$0010
        sta wR2
        lda $7FE4E1,x
        and #$00FF
        sta wR3
        lda $7FE4E2,x
        sta wR4
        jsl rlUnknown96B517
        ldy #$0000
        sep #$20
        lda wR2
        sec
        sbc wR3
        beq _AE7D
        bcc _AE68
        cmp #$64
        bcs _AEC7
        rep #$20
        and #$00FF
        tax
        sep #$20

        _AE51
        lda #$80
        sta $2180,b
        lda #$7F
        sta $2180,b
        dec wR0
        bne _AE63
        jml _AED7


        _AE63
        dec x
        bne _AE51
        bra _AE7D


        _AE68
        rep #$20
        eor #$FFFF
        inc a
        and #$00FF
        pha
        lda wR4
        sec
        sbc #1,s
        sta wR4
        pla
        tay
        sep #$20

        _AE7D
        jsr rsUnknown96B5B5
        dec wR0
        beq _AED7
        inc y
        cpy wR3
        bcs _AE93
        rep #$20
        dec wR4
        beq _AEAA
        sep #$20
        bra _AE7D


        _AE93
        dec y
        cpy #$0000
        bmi _AEC7
        jsr rsUnknown96B5B5
        dec wR0
        beq _AED7
        rep #$20
        dec wR4
        beq _AEAA
        sep #$20
        bra _AE93


        _AEAA
        .al
        and #$85FF
        asl $A8
        jsl rlUnknown96B517
        sep #$20

        _AEB5
        dec y
        dec y
        dec y
        dec y
        cpy #$0000
        bmi _AEC7
        jsr rsUnknown96B5B5
        dec wR0
        beq _AED7
        bra _AEB5


        _AEC7
        lda #$80
        sta $2180,b
        lda #$7F
        sta $2180,b
        dec wR0
        beq _AED7
        bra _AEC7


        _AED7
        rep #$20
        pld
        plx
        rtl

        .databank 0

        ; 96/AEDC

      rlUnknown96AEDC ; 96/AEDC

        .al
        .xl
        .autsiz
        .databank ?

        phx
        sta wR0
        phd
        lda #$0000
        pha
        pld
        lda lR18+1
        and #$01FF
        sta $2182,b
        lda $7FE09E
        bit #$0001
        bne _AEFB
        lda #$0380
        bra _AEFE


        _AEFB
        lda #$0000

        _AEFE
        clc
        adc lR18
        sta $2181,b
        lda $7FE4DE,x
        and #$00FF
        sta wR1
        lda $7FE4DF,x
        sec
        sbc #$0010
        sta wR2
        lda $7FE4E1,x
        and #$00FF
        sta wR3
        lda $7FE4E2,x
        sta wR4
        jsl rlUnknown96B517
        ldy #$0000
        sep #$20
        lda wR2
        sec
        sbc wR3
        beq _AF70
        bcc _AF5B
        cmp #$A0
        bcs _AFBA
        rep #$20
        and #$00FF
        tax
        sep #$20

        _AF44
        lda #$80
        sta $2180,b
        lda #$7F
        sta $2180,b
        dec wR0
        bne _AF56
        jml _AFCA


        _AF56
        dec x
        bne _AF44
        bra _AF70


        _AF5B
        rep #$20
        eor #$FFFF
        inc a
        and #$00FF
        pha
        lda wR4
        sec
        sbc #1,s
        sta wR4
        pla
        tay
        sep #$20

        _AF70
        jsr rsUnknown96B5B5
        dec wR0
        beq _AFCA
        inc y
        cpy wR3
        bcs _AF86
        rep #$20
        dec wR4
        beq _AF9D
        sep #$20
        bra _AF70


        _AF86
        dec y
        cpy #$0000
        bmi _AFBA
        jsr rsUnknown96B5B5
        dec wR0
        beq _AFCA
        rep #$20
        dec wR4
        beq _AF9D
        sep #$20
        bra _AF86


        _AF9D
        .al
        and #$85FF
        asl $A8
        jsl rlUnknown96B517
        sep #$20

        _AFA8
        dec y
        dec y
        dec y
        dec y
        cpy #$0000
        bmi _AFBA
        jsr rsUnknown96B5B5
        dec wR0
        beq _AFCA
        bra _AFA8


        _AFBA
        lda #$80
        sta $2180,b
        lda #$7F
        sta $2180,b
        dec wR0
        beq _AFCA
        bra _AFBA


        _AFCA
        rep #$20
        pld
        plx
        rtl

        .databank 0

        ; 96/AFCF

      rlUnknown96AFCF ; 96/AFCF

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phd
        lda #$0000
        pha
        pld
        lda lR18+1
        and #$01FF
        sta $2182,b
        lda $7FE09E
        bit #$0001
        bne _AFEC
        lda #$0380
        bra _AFEF


        _AFEC
        lda #$0000

        _AFEF
        clc
        adc lR18
        sta $2181,b
        lda $7FE4DF,x
        sec
        sbc #$0010
        sta wR2
        lda $7FE4E1,x
        and #$00FF
        sta wR3
        lda $7FE4E2,x
        sta wR4
        jsl rlUnknown96B517
        ldy #$0000
        sep #$20
        lda wR2
        sec
        sbc wR3
        beq _B04C
        bcc _B037
        rep #$20
        and #$00FF
        tax
        sep #$20

        _B028
        lda #$80
        sta $2180,b
        lda #$7F
        sta $2180,b
        dec x
        bne _B028
        bra _B04C


        _B037
        rep #$20
        eor #$FFFF
        inc a
        and #$00FF
        pha
        lda wR4
        sec
        sbc #1,s
        sta wR4
        pla
        tay
        sep #$20

        _B04C
        lda [lR19],y
        pha
        lda #$80
        sec
        sbc #1,s
        sta $2180,b
        lda #$80
        clc
        adc #1,s
        sta $2180,b
        pla
        inc y
        cpy wR3
        bcs _B069
        dec wR4
        bne _B04C

        _B069
        dec y
        dec y
        dec y
        dec y
        cpy #$0000
        bmi _B088
        lda [lR19],y
        pha
        lda #$80
        sec
        sbc #1,s
        sta $2180,b
        lda #$80
        clc
        adc #1,s
        sta $2180,b
        pla
        bra _B069


        _B088
        rep #$20
        pld
        plx
        rtl

        .databank 0

        ; 96/B08D

    .endsection Unsorted96ADE9Section


    .section Unsorted96B0E1Section

      .al
      .xl

      rsUnknown96B0E1 ; 96/B0E1

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$0078
        sta wR0
        phd
        lda #$0000
        pha
        pld
        lda lR18+1
        and #$01FF
        sta $2182,b
        lda $7FE09E
        bit #$0001
        bne _B103
        lda #$0380
        bra _B106


        _B103
        lda #$0000

        _B106
        clc
        adc lR18
        sta $2181,b
        lda $7FE4DE,x
        and #$00FF
        sta wR1
        lda $7FE4DF,x
        sta wR2
        lda $7FE4E1,x
        and #$00FF
        sta wR3
        lda $7FE4E2,x
        sta wR4
        jsl rlUnknown96B517
        ldy #$0000
        sep #$20
        lda wR3
        lsr a
        lsr a
        lsr a
        pha
        lda wR2
        sec
        sbc #1,s
        rep #$20
        and #$00FF
        tax
        sep #$20
        pla

        _B147
        lda #$80
        sta $2180,b
        lda #$7F
        sta $2180,b
        dec wR0
        bne _B159
        jml _B1A9


        _B159
        dec x
        bne _B147

        _B15C
        jsr rsUnknown96B5B5
        dec wR0
        beq _B1A9
        inc y
        inc y
        inc y
        inc y
        inc y
        inc y
        inc y
        inc y
        cpy wR3
        bcs _B179
        rep #$20
        dec wR4
        beq _B179
        sep #$20
        bra _B15C


        _B179
        dec y
        dec y
        dec y
        dec y
        dec y
        dec y
        dec y
        dec y
        cpy #$0000
        bmi _B197
        jsr rsUnknown96B5B5
        dec wR0
        beq _B1A9
        rep #$20
        dec wR4
        beq _B197
        sep #$20
        bra _B179


        _B197
        sep #$20
        lda #$80
        sta $2180,b
        lda #$7F
        sta $2180,b
        dec wR0
        beq _B1A9
        bra _B197


        _B1A9
        rep #$20
        pld
        plx
        rts

        .databank 0

        ; 96/B1AE

      rsUnknown96B1AE ; 96/B1AE

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$0078
        sta wR0
        phd
        lda #$0000
        pha
        pld
        lda lR18+1
        and #$01FF
        sta $2182,b
        lda $7FE09E
        bit #$0001
        bne _B1D0
        lda #$0380
        bra _B1D3


        _B1D0
        lda #$0000

        _B1D3
        clc
        adc lR18
        sta $2181,b
        lda $7FE4DE,x
        and #$00FF
        sta wR1
        lda $7FE4DF,x
        sta wR2
        lda $7FE4E1,x
        and #$00FF
        sta wR3
        lda $7FE4E2,x
        sta wR4
        jsl rlUnknown96B517
        lda wR3
        tay
        sep #$20
        lda wR2
        rep #$20
        and #$00FF
        tax
        sep #$20

        _B20A
        lda #$00
        sta $2180,b
        lda #$FF
        sta $2180,b
        dec wR0
        bne _B21C
        jml _B24F


        _B21C
        dec x
        bne _B20A

        _B21F
        dec y
        dec y
        dec y
        dec y
        dec y
        dec y
        dec y
        dec y
        cpy #$0000
        bmi _B23D
        jsr rsUnknown96B5B5
        dec wR0
        beq _B24F
        rep #$20
        dec wR4
        beq _B23D
        sep #$20
        bra _B21F


        _B23D
        sep #$20
        lda #$80
        sta $2180,b
        lda #$7F
        sta $2180,b
        dec wR0
        beq _B24F
        bra _B23D


        _B24F
        rep #$20
        pld
        plx
        rts

        .databank 0

        ; 96/B254

      rsUnknown96B254 ; 96/B254

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$0078
        sta wR0
        phd
        lda #$0000
        pha
        pld
        lda lR18+1
        and #$01FF
        sta $2182,b
        lda $7FE09E
        bit #$0001
        bne _B276
        lda #$0380
        bra _B279


        _B276
        lda #$0000

        _B279
        clc
        adc lR18
        sta $2181,b
        lda $7FE4DE,x
        and #$00FF
        sta wR1
        lda $7FE4DF,x
        sta wR2
        lda $7FE4E1,x
        and #$00FF
        sta wR3
        lda $7FE4E2,x
        sta wR4
        jsl rlUnknown96B517
        ldy #$0000
        sep #$20
        lda wR3
        lsr a
        pha
        lda wR2
        sec
        sbc #1,s
        rep #$20
        and #$00FF
        tax
        sep #$20
        pla

        _B2B8
        lda #$80
        sta $2180,b
        lda #$7F
        sta $2180,b
        dec wR0
        bne _B2CA
        jml _B312


        _B2CA
        dec x
        bne _B2B8

        _B2CD
        jsr rsUnknown96B5B5
        dec wR0
        beq _B312
        inc y
        inc y
        inc y
        inc y
        cpy wR3
        bcs _B2E6
        rep #$20
        dec wR4
        beq _B2E6
        sep #$20
        bra _B2CD


        _B2E6
        dec y
        dec y
        dec y
        dec y
        cpy #$0000
        bmi _B300
        jsr rsUnknown96B5B5
        dec wR0
        beq _B312
        rep #$20
        dec wR4
        beq _B300
        sep #$20
        bra _B2E6


        _B300
        sep #$20
        lda #$80
        sta $2180,b
        lda #$7F
        sta $2180,b
        dec wR0
        beq _B312
        bra _B300


        _B312
        rep #$20
        pld
        plx
        rts

        .databank 0

        ; 96/B317

      rlUnknown96B317 ; 96/B317

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$0070
        sta wR0
        phd
        lda #$0000
        pha
        pld
        lda lR18+1
        and #$01FF
        sta $2182,b
        lda $7FE09E
        bit #$0001
        bne _B339
        lda #$0380
        bra _B33C


        _B339
        lda #$0000

        _B33C
        clc
        adc lR18
        sta $2181,b
        lda $7FE4DE,x
        and #$00FF
        sta wR1
        lda $7FE4DF,x
        sec
        sbc #$0010
        sta wR2
        lda $7FE4E1,x
        and #$00FF
        sta wR3
        lda $7FE4E2,x
        sta wR4
        lda wR3
        jsr rsUnknown96B56F
        pha
        sep #$20
        lda wR1
        clc
        adc #1,s
        bcc _B375
        lda #$FF

        _B375
        xba
        lda wR1
        sec
        sbc #1,s
        bcs _B37F
        lda #$00

        _B37F
        rep #$20
        sta wR5
        pla
        jsl rlUnknown96B517
        ldy #$0000
        sep #$20
        lda wR2
        sec
        sbc wR3
        beq _B3D4
        bcc _B3BF
        cmp $7FFC5B
        bcc _B3A0
        jml _B426


        _B3A0
        rep #$20
        and #$00FF
        tax
        sep #$20

        _B3A8
        lda wR5
        sta $2180,b
        lda wR5+1
        sta $2180,b
        dec wR0
        bne _B3BA
        jml _B436


        _B3BA
        dec x
        bne _B3A8
        bra _B3D4


        _B3BF
        rep #$20
        eor #$FFFF
        inc a
        and #$00FF
        pha
        lda wR4
        sec
        sbc #1,s
        sta wR4
        pla
        tay
        sep #$20

        _B3D4
        lda wR5
        sta $2180,b
        lda wR5+1
        sta $2180,b
        dec wR0
        beq _B436
        inc y
        cpy wR3
        bcs _B3F1
        rep #$20
        dec wR4
        beq _B408
        sep #$20
        bra _B3D4


        _B3F1
        dec y
        cpy #$0000
        bmi _B426
        jsr rsUnknown96B5B5
        dec wR0
        beq _B436
        rep #$20
        dec wR4
        beq _B408
        sep #$20
        bra _B3F1


        _B408
        .al
        and #$85FF
        asl $A8
        jsl rlUnknown96B517
        sep #$20

        _B413
        dec y
        dec y
        dec y
        dec y
        dec y
        cpy #$0000
        bmi _B426
        jsr rsUnknown96B5B5
        dec wR0
        beq _B436
        bra _B413


        _B426
        lda #$80
        sta $2180,b
        lda #$7F
        sta $2180,b
        dec wR0
        beq _B436
        bra _B426


        _B436
        rep #$20
        pld
        plx
        rtl

        .databank 0

        ; 96/B43B

      rsUnknown96B43B ; 96/B43B

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$0078
        sta wR0
        phd
        lda #$0000
        pha
        pld
        lda lR18+1
        and #$01FF
        sta $2182,b
        lda $7FE09E
        bit #$0001
        bne _B45D
        lda #$0380
        bra _B460


        _B45D
        lda #$0000

        _B460
        clc
        adc lR18
        sta $2181,b
        lda $7FE4DE,x
        and #$00FF
        sta wR1
        lda $7FE4DF,x
        sta wR2
        lda $7FE4E1,x
        and #$00FF
        sta wR3
        lda $7FE4E2,x
        sta wR4
        jsl rlUnknown96B517
        ldy #$0000
        sep #$20
        lda wR3
        lsr a
        pha
        lda wR2
        sec
        sbc #1,s
        bcc _B4BA
        beq _B4D0
        rep #$20
        and #$00FF
        tax
        sep #$20
        pla

        _B4A3
        lda #$80
        sta $2180,b
        lda #$7F
        sta $2180,b
        dec wR0
        bne _B4B5
        jml _B512


        _B4B5
        dec x
        bne _B4A3
        bra _B4D1


        _B4BA
        rep #$20
        asl a
        eor #$FFFF
        inc a
        and #$00FF
        pha
        lda wR4
        sec
        sbc #1,s
        sta wR4
        pla
        tay
        sep #$20

        _B4D0
        pla

        _B4D1
        jsr rsUnknown96B5B5
        dec wR0
        beq _B512
        inc y
        inc y
        cpy wR3
        bcs _B4E8
        rep #$20
        dec wR4
        beq _B4E8
        sep #$20
        bra _B4D1


        _B4E8
        dec y
        dec y
        cpy #$0000
        bmi _B500
        jsr rsUnknown96B5B5
        dec wR0
        beq _B512
        rep #$20
        dec wR4
        beq _B500
        sep #$20
        bra _B4E8


        _B500
        sep #$20
        lda #$80
        sta $2180,b
        lda #$7F
        sta $2180,b
        dec wR0
        beq _B512
        bra _B500


        _B512
        rep #$20
        pld
        plx
        rts

        .databank 0

        ; 96/B517

      rlUnknown96B517 ; 96/B517

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$9A00
        sta lR19+1
        lda wR3
        bit #$0080
        beq _B536
        pha
        and #$FFF8
        sta wR3
        pla
        and #$FF78
        lsr a
        lsr a
        clc
        adc #$0080
        bra _B562


        _B536
        bit #$0040
        beq _B54C
        pha
        and #$FFFC
        sta wR3
        pla
        and #$FFBC
        lsr a
        clc
        adc #$0060
        bra _B562


        _B54C
        bit #$0020
        beq _B561
        pha
        and #$FFFE
        sta wR3
        pla
        and #$FFDE
        clc
        adc #$0040
        bra _B562


        _B561
        asl a

        _B562
        tax
        lda $9AA30A,x
        clc
        adc #$A30A
        sta lR19
        plx
        rtl

        .databank 0

        ; 96/B56F

      rsUnknown96B56F ; 96/B56F

        .al
        .xl
        .autsiz
        .databank ?

        phx
        pha
        bit #$0080
        beq _B581
        and #$FF78
        lsr a
        lsr a
        clc
        adc #$0080
        bra _B59F


        _B581
        bit #$0040
        beq _B590
        and #$FFBC
        lsr a
        clc
        adc #$0060
        bra _B59F


        _B590
        bit #$0020
        beq _B59E
        and #$FFDE
        clc
        adc #$0040
        bra _B59F


        _B59E
        asl a

        _B59F
        tax
        lda $9AA30A,x
        clc
        adc #1,s
        dec a
        tax
        lda $9AA30A,x
        and #$00FF
        sta #1,s
        pla
        plx
        rts

        .databank 0

        ; 96/B5B5

      rsUnknown96B5B5 ; 96/B5B5

        .as
        .xl
        .autsiz
        .databank ?

        lda [lR19],y
        pha
        lda wR1
        sec
        sbc #1,s
        bcs _B5C1
        lda #$00

        _B5C1
        sta $2180,b
        lda wR1
        clc
        adc #1,s
        bcc _B5CD
        lda #$FF

        _B5CD
        sta $2180,b
        pla
        rts

        .databank 0

        ; 96/B5D2

      rsUnknown96B5D2 ; 96/B5D2

        .al
        .xl
        .autsiz
        .databank ?

        pha
        lda $7FFC5B
        sec
        sbc $7FE4DF,x
        bcc _B5F7
        cmp $7FE4E1,x
        bcs _B613
        rep #$20
        and #$00FF
        sta wR0
        lda $7FE4E1,x
        and #$00FF
        clc
        adc wR0
        bra _B61D


        _B5F7
        rep #$20
        lda $7FE4DF,x
        and #$00FF
        sec
        sbc $7FFC5B
        sta wR0
        lda $7FE4E1,x
        and #$00FF
        sec
        sbc wR0
        bra _B61D


        _B613
        rep #$20
        lda $7FE4E1,x
        and #$00FF
        asl a

        _B61D
        sta $7FE4E2,x
        pla
        rts

        .databank 0

        ; 96/B623

      rsUnknown96B623 ; 96/B623

        .al
        .xl
        .autsiz
        .databank ?

        pha
        lda #$00A0
        sec
        sbc $7FE4DF,x
        bcc _B647
        cmp $7FE4E1,x
        bcs _B662
        rep #$20
        and #$00FF
        sta wR0
        lda $7FE4E1,x
        and #$00FF
        clc
        adc wR0
        bra _B66C


        _B647
        rep #$20
        lda $7FE4DF,x
        and #$00FF
        sec
        sbc #$00A0
        sta wR0
        lda $7FE4E1,x
        and #$00FF
        sec
        sbc wR0
        bra _B66C


        _B662
        rep #$20
        lda $7FE4E1,x
        and #$00FF
        asl a

        _B66C
        sta $7FE4E2,x
        pla
        rts

        .databank 0

        ; 96/B672

      rlUnknown96B672 ; 96/B672

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $0AE8,b
        bit #$0080
        bne _B680
        lda #$0000
        bra _B685


        _B680
        lda #$8000
        bra _B685


        _B685
        jsr rsUnknown96B68A
        plx
        rtl

        .databank 0

        ; 96/B68A

      rsUnknown96B68A ; 96/B68A

        .al
        .xl
        .autsiz
        .databank ?

        pha
        pha
        jsl rlUnknown95B050
        jsr rsUnknown96B894
        lda wR0
        sta wR1
        clc
        jsl rlUnknown95E304
        pha
        sta wR0
        lda wR1
        jsl rlUnknown95CE5E
        sta wR0
        pla
        sta wR1
        jsl rlUnknown95B184
        bcc _B6B6
        pla
        eor #$8000
        bra _B6B7


        _B6B6
        pla

        _B6B7
        ora wR1
        sta aUnit2DataBuffer._Inventory.ItemCount,x
        pla
        pha
        sta wR1
        lda wR0
        pha
        lda wR1
        jsr rsUnknown96B852
        pla
        sta wR0
        pla
        asl a
        jsl rlUnknown95E33B
        jsl rlUnknown95CE78
        lda wR0
        sta $7FEC3C,x
        lda wR1
        sta $7FEC3A,x
        rts

        .databank 0

        ; 96/B6E3

      rsUnknown96B6E3 ; 96/B6E3

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7FEC1D,x
        bit #$0020
        beq _B717
        lda #$0000
        sta aUnit2DataBuffer._ROM.StrengthGrowth,x
        lda $7FE477
        and #$03FF
        sec
        sbc #$0100
        clc
        adc #$0100
        sta $7FEC1F,x
        lda $7FE479
        clc
        adc #$8000
        eor #$FFFF
        inc a
        sta $7FEC23,x

        _B717
        plx
        rts

        .databank 0

        ; 96/B719

      rsUnknown96B719 ; 96/B719

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda aUnit2DataBuffer._Inventory.ItemCount
        bne _B724
        jml _B743


        _B724
        bpl _B72A
        jml _B736


        _B72A
        sta wR0
        jsr rsUnknown96B745
        bcc _B734
        jsr rsUnknown96A81C

        _B734
        bra _B743


        _B736
        and #$7FFF
        sta wR0
        jsr rsUnknown96B794
        bcc _B743
        jsr rsUnknown96A81C

        _B743
        plx
        rts

        .databank 0

        ; 96/B745

      rsUnknown96B745 ; 96/B745

        .al
        .xl
        .autsiz
        .databank ?

        phx
        sta wR2
        lda aUnit2DataBuffer._ROM.StrengthGrowth
        clc
        adc wR2
        sta aUnit2DataBuffer._ROM.StrengthGrowth
        lda aUnit2DataBuffer._ROM.MagicGrowth
        adc #$0000
        sep #$20
        sta aUnit2DataBuffer._ROM.MagicGrowth
        rep #$20
        lda $7FEC1F
        cmp #$0200
        bcs _B792
        ldx $0AEB,b
        cmp $0AF9,b,x
        bcc _B775
        bra _B792


        _B775
        cmp #$0180
        bcc _B77F
        lda #$0180
        bra _B789


        _B77F
        cmp #$0080
        bcs _B789
        lda #$0080
        bra _B789


        _B789
        sec
        sbc #$0080
        sta $7FE198
        clc

        _B792
        plx
        rts

        .databank 0

        ; 96/B794

      rsUnknown96B794 ; 96/B794

        .al
        .xl
        .autsiz
        .databank ?

        sta wR2
        lda aUnit2DataBuffer._ROM.StrengthGrowth
        sec
        sbc wR2
        sta aUnit2DataBuffer._ROM.StrengthGrowth
        lda aUnit2DataBuffer._ROM.MagicGrowth
        sbc #$0000
        sep #$20
        sta aUnit2DataBuffer._ROM.MagicGrowth
        rep #$20
        lda $7FEC1F
        bpl _B7B9
        sec
        bra _B7E1


        _B7B9
        ldx $0AEB,b
        cmp $0AF9,b,x
        bcs _B7C4
        sec
        bra _B7E1


        _B7C4
        cmp #$0180
        bcc _B7CE
        lda #$0180
        bra _B7D8


        _B7CE
        cmp #$0080
        bcs _B7D8
        lda #$0080
        bra _B7D8


        _B7D8
        sec
        sbc #$0080
        sta $7FE198
        clc

        _B7E1
        rts

        .databank 0

        ; 96/B7E2

    .endsection Unsorted96B0E1Section


    .section Unsorted96B852Section

      .al
      .xl

      rsUnknown96B852 ; 96/B852

        .al
        .xl
        .autsiz
        .databank ?

        phx
        pha
        ldx $0AEB,b
        lda $0AFE,b,x
        and #$00FF
        sta wR1
        lda aUnit2DataBuffer._ROM.SpeedGrowth
        and #$00FF
        sta wR2
        lda wR1
        sec
        sbc wR2
        bpl _B878
        eor #$FFFF
        inc a
        sta wR2
        pla
        bra _B87E


        _B878
        sta wR2
        pla
        eor #$8000

        _B87E
        sta wR3
        lda wR2
        jsl rlUnknown95CE5E
        ora wR3
        sta $7FEC3F
        lda wR1
        sta aUnit2DataBuffer._ROM.HolyBlood2
        plx
        rts

        .databank 0

        ; 96/B894

      rsUnknown96B894 ; 96/B894

        .al
        .xl
        .autsiz
        .databank ?

        phx
        sep #$20
        lda $0AE8,b
        bit #$80
        bne _B8A3
        ldx #$0000
        bra _B8A6


        _B8A3
        ldx #$000E

        _B8A6
        lda $0D4E,b,x
        sta wR9+1
        rep #$20
        and #$00FF
        sta wR10
        lda #$0008
        sta wR11
        jsl rlUnsignedMultiply16By16
        ldx wR12
        lda $97EA9C,x
        and #$00FF
        sta wR8
        ldx $0AEB,b
        lda $0AF9,b,x
        sta wR1
        lda $7FEC1F
        sta wR0
        lda wR0
        cmp wR1
        bcc _B8DF
        sec
        sbc wR8
        bra _B8E2


        _B8DF
        clc
        adc wR8

        _B8E2
        sta wR0
        lda wR1
        sec
        sbc wR0
        bpl _B8F6
        eor #$FFFF
        inc a
        sta wR2
        lda #$8000
        bra _B8FB


        _B8F6
        sta wR2
        lda #$0000

        _B8FB
        sta wR3
        lda wR2
        sta wR4
        sec
        jsl rlUnknown95B530
        sta wR0
        lda wR2
        jsl rlUnknown95CE5E
        ora wR3
        sta aUnit2DataBuffer._Inventory.ItemCount
        lda wR3
        bmi _B921
        lda $7FEC1F
        clc
        adc wR2
        bra _B928


        _B921
        lda $7FEC1F
        sec
        sbc wR2

        _B928
        pha
        lda aUnit2DataBuffer._ROM.StrengthGrowth
        sta aUnit2DataBuffer._ROM.Skills2
        pla
        sta aUnit2DataBuffer._ROM.Skills3
        lda wR4
        plx
        rts

        .databank 0

        ; 96/B93A

      rlUnknown96B93A ; 96/B93A

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$00
        sta $7FECF4
        rep #$20
        rtl

        .databank 0

        ; 96/B945

    .endsection Unsorted96B852Section


    .section Unsorted96B945Section

      .al
      .xl

      rlUnknown96B945 ; 96/B945

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda $7FECF4
        and #$00FF
        bne _B9A1
        lda #$9700
        sta lR18+1
        tya
        and #$01FF
        asl a
        pha
        asl a
        asl a
        clc
        adc #1,s
        clc
        adc #$B081
        sta lR18
        pla
        ldy #$0000
        ldx #$0000

        _B96D
        lda [lR18],y
        sta $7FECF5,x
        inc y
        inc y
        inc x
        inc x
        cpx #$000A
        bne _B96D
        lda $7FECF5
        sta lR18
        lda $7FECF7
        sta lR18+2
        lda $7FECF9
        sta lR19+1
        jsl rlAppendDecompList
        sep #$20
        lda #$01
        sta $7FECF4
        rep #$20
        pla
        pha
        jsr rsUnknown96A477

        _B9A1
        ply
        plx
        rtl

        .databank 0

        ; 96/B9A4

      rlUnknown96B9A4 ; 96/B9A4

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx $0AE9,b
        lda $0B24,b,x
        bit #$8000
        beq _B9B1
        inc y

        _B9B1
        jsl rlUnknown96B945
        plx
        rtl

        .databank 0

        ; 96/B9B7

      rlUnknown96B9B7 ; 96/B9B7

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda $7FECF4
        and #$00FF
        bne _BA12
        lda #$9700
        sta lR18+1
        tya
        and #$01FF
        asl a
        pha
        asl a
        clc
        adc #1,s
        clc
        adc #$B5D1
        sta lR18
        pla
        ldy #$0000
        ldx #$0000

        _B9DE
        lda [lR18],y
        sta $7FECF5,x
        inc y
        inc y
        inc x
        inc x
        cpx #$0006
        bne _B9DE
        lda $7FECF5
        sta lR18
        lda $7FECF7
        sta lR18+2
        lda $7FECF9
        sta lR19+1
        jsl rlAppendDecompList
        sep #$20
        lda #$03
        sta $7FECF4
        rep #$20
        pla
        pha
        jsr rsUnknown96A477

        _BA12
        ply
        plx
        rtl

        .databank 0

        ; 96/BA15

      rlUnknown96BA15 ; 96/BA15

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda $7FECF4
        and #$00FF
        bne _BA65
        tya
        and #$0002
        beq _BA37
        lda $7FE4D6
        sta lR18
        lda $7FE4D7
        sta lR18+1
        jsr rsUnknown96F7A8
        bra _BA44


        _BA37
        and #$0001
        bne _BA41
        lda $0D50,b
        bra _BA44


        _BA41
        lda $0D5E,b

        _BA44
        jsl rlGetCharacterPortraitData
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        sta lR19
        jsl rlAppendDecompList
        sep #$20
        lda #$03
        sta $7FECF4
        rep #$20
        pla
        pha
        jsr rsUnknown96A477

        _BA65
        ply
        plx
        rtl

        .databank 0

        ; 96/BA68

    .endsection Unsorted96B945Section


    .section Unsorted96BB0CSection

      .al
      .xl

      rlUnknown96BB0C ; 96/BB0C

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda $7FECF4
        and #$00FF
        bne _BB6D
        lda #$9700
        sta lR18+1
        tya
        and #$01FF
        pha
        asl a
        asl a
        asl a
        sec
        sbc #1,s
        clc
        adc #$B60D
        sta lR18
        pla
        ldy #$0000
        ldx #$0000
        sep #$20

        _BB36
        lda [lR18],y
        sta $7FECF8,x
        inc y
        inc x
        cpx #$0007
        bne _BB36
        rep #$20
        lda $7FECF9
        sta lR18+1
        lda $7FECF8
        sta lR18
        lda $7FECFB
        tay
        lda $7FECFD
        jsl rlUnknown95C4E3
        sep #$20
        lda #$02
        sta $7FECF4
        rep #$20
        pla
        pha
        jsr rsUnknown96A477

        _BB6D
        ply
        plx
        rtl

        .databank 0

        ; 96/BB70

    .endsection Unsorted96BB0CSection


    .section Unsorted96BBC2Section

      .al
      .xl

      rlUnknown96BBC2 ; 96/BBC2

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        phy
        tya
        and #$01FF
        sta $7FE4BE
        pla
        pha
        jsr rsUnknown96A49B
        ply
        rtl

        .databank 0

        ; 96/BBD2

      rlUnknown96BBD2 ; 96/BBD2

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        phy
        tya
        and #$01FF
        sta $7FE4C0
        pla
        pha
        jsr rsUnknown96A49B
        ply
        rtl

        .databank 0

        ; 96/BBE2

    .endsection Unsorted96BBC2Section


    .section Unsorted96BBE2Section

      .al
      .xl

      rlUnknown96BBE2 ; 96/BBE2

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda $7FECF4
        and #$00FF
        beq _BC49
        cmp #$0003
        bne _BBFC
        lda bDecompressionArrayFlag,b
        and #$00FF
        bne _BC49
        bra _BC34


        _BBFC
        cmp #$0001
        bne _BC2E
        lda bDecompressionArrayFlag,b
        and #$00FF
        bne _BC49
        lda $7FECF9
        sta lR18+1
        lda $7FECF8
        sta lR18
        lda $7FECFB
        tay
        lda $7FECFD
        jsl rlUnknown95C4E3
        sep #$20
        lda #$02
        sta $7FECF4
        rep #$20
        bra _BC49


        _BC2E
        lda $7FE18A
        bne _BC49

        _BC34
        sep #$20
        lda #$00
        sta $7FECF4
        lda $7FE4B8
        beq _BC47
        dec a
        sta $7FE4B8

        _BC47
        rep #$20

        _BC49
        ply
        plx
        rtl

        .databank 0

        ; 96/BC4C

    .endsection Unsorted96BBE2Section


    .section Unsorted96BC4CSection

      .al
      .xl

      rlUnknown96BC4C ; 96/BC4C

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        tya
        sta wR0
        and #$01FF
        asl a
        tax
        lda $98AD04,x
        ldx $0AE9,b
        cpx #$0000
        bne _BC66
        clc
        adc #$2000

        _BC66
        jsl rlUnknown80900D
        lda #1,s
        jsr rsUnknown96A477
        ply
        plx
        rtl

        .databank 0

        ; 96/BC72

      rlUnknown96BC72 ; 96/BC72

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        tya
        sta wR0
        and #$01FF
        asl a
        tax
        lda $98AD04,x
        pha
        ldx $0AE9,b
        lda $0AF9,b,x
        and #$01FF
        sec
        sbc $7FE198
        jsl rlUnknown9EB4BB
        ldx $0AE9,b
        cpx #$0000
        bne _BC9F
        clc
        adc #$2000

        _BC9F
        clc
        adc #1,s
        jsl rlUnknown80900D
        pla
        lda #1,s
        jsr rsUnknown96A477
        ply
        plx
        rtl

        .databank 0

        ; 96/BCAF

    .endsection Unsorted96BC4CSection


    .section Unsorted96BCECSection

      .al
      .xl

      rlUnknown96BCEC ; 96/BCEC

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown96A4B2
        rtl

        .databank 0

        ; 96/BCF1

    .endsection Unsorted96BCECSection


    .section Unsorted96BCF1Section

      .al
      .xl

      rlUnknown96BCF1 ; 96/BCF1

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda #$9700
        sta lR18+1
        tya
        and #$01FF
        asl a
        clc
        adc #$B67D
        sta lR18
        ldy #$0000
        lda [lR18],y
        clc
        adc #$B67D
        sta lR18
        jsl rlUnknown96BD1A
        lda #1,s
        jsr rsUnknown96A477
        ply
        plx
        rtl

        .databank 0

        ; 96/BD1A

    .endsection Unsorted96BCF1Section


    .section Unsorted96BD1ASection

      .al
      .xl

      rlUnknown96BD1A ; 96/BD1A

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        ldy #$0000

        _BD1F
        lda [lR18],y
        cmp #$FFFF
        beq _BD71
        inc y
        inc y
        pha
        and #$3FFF
        tax
        pla
        and #$C000
        cmp #$0000
        bne _BD41
        sep #$20
        lda [lR18],y
        sta wR0,x
        rep #$20
        inc y
        bra _BD1F


        _BD41
        cmp #$4000
        bne _BD4E
        lda [lR18],y
        sta wR0,x
        inc y
        inc y
        bra _BD1F


        _BD4E
        cmp #$8000
        bne _BD63
        sep #$20
        lda wR0,x
        and [lR18],y
        inc y
        ora [lR18],y
        sta wR0,x
        rep #$20
        inc y
        bra _BD1F


        _BD63
        lda wR0,x
        and [lR18],y
        inc y
        inc y
        ora [lR18],y
        sta wR0,x
        inc y
        inc y
        bra _BD1F


        _BD71
        ply
        plx
        rtl

        .databank 0

        ; 96/BD74

    .endsection Unsorted96BD1ASection


    .section Unsorted96BD74Section

      .al
      .xl

      rlUnknown96BD74 ; 96/BD74

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$0000
        sta $7FED02
        ldx #$0000

        _BD7F
        lda #$0000
        sta $7FED03,x
        txa
        clc
        adc #$0009
        tax
        cpx #$0048
        bcc _BD7F
        plx
        rtl

        .databank 0

        ; 96/BD93

      rlUnknown96BD93 ; 96/BD93

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        tya
        and #$01FF
        cmp #$0008
        bcs _BDA4
        jsl rlUnknown96C942
        bra _BE20


        _BDA4
        lda $7FED02
        and #$00FF
        cmp #$0008
        bcs _BE1D
        ldx #$0000

        _BDB3
        lda $7FED03,x
        bit #$0001
        bne _BE12
        sep #$20
        lda #$01
        sta $7FED03,x
        lda $7FED02
        inc a
        sta $7FED02
        rep #$20
        lda #$9700
        sta lR18+1
        tya
        and #$01FF
        sec
        sbc #$0008
        asl a
        clc
        adc #$BD3E
        sta lR18
        ldy #$0000
        lda [lR18],y
        clc
        adc #$BD3E
        sta lR18
        ldy #$0000
        lda [lR18],y
        sta $7FED04,x
        inc y
        inc y
        lda [lR18],y
        sta $7FED06,x
        inc y
        inc y
        lda [lR18],y
        sta $7FED08,x
        inc y
        inc y
        lda [lR18],y
        sta $7FED0A,x
        clc
        bra _BE20


        _BE12
        txa
        clc
        adc #$0009
        tax
        cpx #$0048
        bcc _BDB3

        _BE1D
        sec
        bra _BE25


        _BE20
        pla
        pha
        jsr rsUnknown96A477

        _BE25
        ply
        plx
        rtl

        .databank 0

        ; 96/BE28

    .endsection Unsorted96BD74Section


    .section Unsorted96BE28Section

      .al
      .xl

      rlUnknown96BE28 ; 96/BE28

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda $7FED02
        and #$00FF
        beq _BE50
        ldx #$0000

        _BE36
        lda $7FED03,x
        bit #$0001
        beq _BE45
        phb
        jsl rlUnknown96BE53
        plb
        .databank ?

        _BE45
        txa
        clc
        adc #$0009
        tax
        cpx #$0048
        bcc _BE36

        _BE50
        ply
        plx
        rtl

        .databank 0

        ; 96/BE53

      rlUnknown96BE53 ; 96/BE53

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FED04,x
        sta lR18
        sep #$20
        lda $7FED06,x
        sta lR18+2
        pha
        plb
        .databank ?
        rep #$20
        jml [lR18]

        .databank 0

        ; 96/BE68

    .endsection Unsorted96BE28Section


    .section Unsorted96BFE5Section

      .al
      .xl

      rlUnknown96BFE5 ; 96/BFE5

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        sep #$20
        lda $7FED03
        ora #$02
        sta $7FED03
        rep #$20
        jsl rlUnknown96C7DB
        lda #$9600
        sta $7FED05,x
        lda #$C008
        sta $7FED04,x
        plx
        rtl

        .databank 0

        ; 96/C008

      rlUnknown96C008 ; 96/C008

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda $7FED07
        and #$00FF
        beq _C01E
        sep #$20
        dec a
        sta $7FED07
        rep #$20
        bra _C078


        _C01E
        lda $7FED0A,x
        tax
        lda $97C462,x
        cmp #$8001
        bne _C035
        lda #$0000
        jsl rlUnknown96C975
        bra _C04D


        _C035
        cmp #$8000
        bne _C05C
        lda #$0000
        jsl rlUnknown96C942
        sep #$20
        lda $7FED03
        and #$FD
        sta $7FED03

        _C04D
        lda $7FE4B8
        beq _C058
        dec a
        sta $7FE4B8

        _C058
        rep #$20
        bra _C07C


        _C05C
        sep #$20
        sta $7FED07
        xba
        sta $7FF5AC
        rep #$20
        lda #3,s
        tax
        lda $7FED0A,x
        clc
        adc #$0002
        sta $7FED0A,x

        _C078
        jsl rlUnknown96C817

        _C07C
        ply
        plx
        rtl

        .databank 0

        ; 96/C07F

    .endsection Unsorted96BFE5Section


    .section Unsorted96C7DBSection

      .al
      .xl

      rlUnknown96C7DB ; 96/C7DB

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$000F
        sta $7FF6B4,x
        lda #$F714
        sta $7FF6B5,x
        lda #$00F0
        sta $7FF6B7,x
        lda #$F714
        sta $7FF6B8,x
        sep #$20
        lda #$00
        sta $7FF6BA,x
        rep #$20
        lda #$9500
        sta lR44+1
        lda #$E70E
        sta lR44
        lda #$0005
        sta wR40
        jsl rlHDMAEngineCreateEntryByIndex
        plx
        rtl

        .databank 0

        ; 96/C817

      rlUnknown96C817 ; 96/C817

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$7F00
        sta lR18+1
        lda #$F714
        sta lR18
        lda $7FE47A
        eor #$FFFF
        inc a
        clc
        adc #$000F
        and #$00FF
        asl a
        tax
        ldy #$0000
        lda $7FE47A
        pha

        _C83B
        lda $7FEDAA,x
        sec
        sbc #1,s
        sta [lR18],y
        inc y
        inc y
        lda $7FEDAC,x
        sec
        sbc #1,s
        sta [lR18],y
        inc y
        inc y
        lda $7FEDAE,x
        sec
        sbc #1,s
        sta [lR18],y
        inc y
        inc y
        lda $7FEDB0,x
        sec
        sbc #1,s
        sta [lR18],y
        inc y
        inc y
        lda $7FEDB2,x
        sec
        sbc #1,s
        sta [lR18],y
        inc y
        inc y
        lda $7FEDB4,x
        sec
        sbc #1,s
        sta [lR18],y
        inc y
        inc y
        lda $7FEDB6,x
        sec
        sbc #1,s
        sta [lR18],y
        inc y
        inc y
        lda $7FEDB8,x
        sec
        sbc #1,s
        sta [lR18],y
        inc y
        inc y
        txa
        clc
        adc #$0010
        tax
        cpy #$00E0
        bcc _C83B
        pla
        plx
        rtl

        .databank 0

        ; 96/C8A1

    .endsection Unsorted96C7DBSection


    .section Unsorted96C8A1Section

      .al
      .xl

      rlUnknown96C8A1 ; 96/C8A1

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda $7FED03
        bit #$0002
        bne _C8AE
        bra _C901


        _C8AE
        jsl rlUnknown96C904
        lda $7FF5AC
        and #$00FF
        pha
        asl a
        asl a
        tax
        lda $998000,x
        tay
        pla
        cpy #$0000
        beq _C901
        asl a
        asl a
        tax
        lda $998002,x
        pha
        tya
        pha
        lda #$0100
        sec
        sbc #1,s
        and #$FFFE
        tax
        pla
        txa
        lsr a
        eor #$FFFF
        inc a
        and #$00FF
        sta wR0
        lda #$0000

        _C8EB
        pha
        xba
        and #$00FF
        clc
        adc wR0
        sta $7FEDAA,x
        pla
        clc
        adc #1,s
        inc x
        inc x
        dec y
        bne _C8EB
        pla

        _C901
        ply
        plx
        rtl

        .databank 0

        ; 96/C904

      rlUnknown96C904 ; 96/C904

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000
        lda #$00FE

        _C90B
        sta $7FEDAA,x
        dec a
        sta $7FEDAC,x
        dec a
        sta $7FEDAE,x
        dec a
        sta $7FEDB0,x
        dec a
        sta $7FEDB2,x
        dec a
        sta $7FEDB4,x
        dec a
        sta $7FEDB6,x
        dec a
        sta $7FEDB8,x
        dec a
        pha
        txa
        clc
        adc #$0010
        tax
        pla
        cpx #$0200
        bcc _C90B
        plx
        rtl

        .databank 0

        ; 96/C942

    .endsection Unsorted96C8A1Section


    .section Unsorted96C942Section

      .al
      .xl

      rlUnknown96C942 ; 96/C942

        .al
        .xl
        .autsiz
        .databank ?

        phx
        pha
        sta wR10
        lda #$0009
        sta wR11
        jsl rlUnsignedMultiply16By16
        ldx wR12
        sep #$20
        lda $7FED03,x
        and #$FE
        sta $7FED03,x
        rep #$20
        lda $7FED02
        beq _C96A
        dec a
        sta $7FED02

        _C96A
        pla
        clc
        adc #$0005
        jsl rlHDMAEngineFreeEntryByIndex
        plx
        rtl

        .databank 0

        ; 96/C975

      rlUnknown96C975 ; 96/C975

        .al
        .xl
        .autsiz
        .databank ?

        phx
        sta wR10
        lda #$0009
        sta wR11
        jsl rlUnsignedMultiply16By16
        ldx wR12
        sep #$20
        lda $7FED03,x
        and #$FE
        sta $7FED03,x
        rep #$20
        lda $7FED02
        beq _C99C
        dec a
        sta $7FED02

        _C99C
        plx
        rtl

        .databank 0

        ; 96/C99E

      rlUnknown96C99E ; 96/C99E

        .al
        .xl
        .autsiz
        .databank ?

        lda #$FF00
        sta $7FED00
        lda #$FFFF
        sta $7FECFF
        rtl

        .databank 0

        ; 96/C9AD

    .endsection Unsorted96C942Section


    .section Unsorted96C9ADSection

      .al
      .xl

      rlUnknown96C9AD ; 96/C9AD

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda $7FECFF
        cmp #$FFFF
        bne _C9C1
        lda $7FED00
        cmp #$FFFF
        beq _C9D6

        _C9C1
        lda $7FECFF
        sta lR18
        lda $7FED00
        sta lR18+1
        jsl _C9D3
        bra _C9D6


        _C9D3
        jml [lR18]


        _C9D6
        ply
        plx
        rtl

        .databank 0

        ; 96/C9D9

    .endsection Unsorted96C9ADSection


    .section Unsorted96C9D9Section

      .al
      .xl

      rlUnknown96C9D9 ; 96/C9D9

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        tya
        and #$01FF
        pha
        asl a
        clc
        adc #1,s
        tax
        pla
        lda $97BDD5,x
        sta $7FED00
        lda $97BDD4,x
        sta $7FECFF
        pla
        pha
        jsr rsUnknown96A477
        ply
        plx
        rtl

        .databank 0

        ; 96/C9FE

      rlUnknown96C9FE ; 96/C9FE

        .al
        .xl
        .autsiz
        .databank ?

        lda #$FF00
        sta $7FED00
        lda #$FFFF
        sta $7FECFF
        sep #$20
        lda $7FE4B8
        beq _CA19
        dec a
        sta $7FE4B8

        _CA19
        rep #$20
        rtl

        .databank 0

        ; 96/CA1C

      rlUnknown96CA1C ; 96/CA1C

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        tya
        and #$01FF
        sta wR0
        phb
        jsl _CA2C
        plb
        .databank ?
        bra _CA4E


        _CA2C
        lda wR0
        cmp #$0048
        bmi _CA35

        _CA33
        bra _CA33


        _CA35
        asl a
        adc wR0
        tax
        lda $97BDD4,x
        sta lR23
        sep #$20
        lda $97BDD6,x
        sta lR23+2
        pha
        plb
        .databank ?
        rep #$20
        jml [lR23]


        _CA4E
        pla
        pha
        jsr rsUnknown96A49B
        ply
        plx
        rtl

        .databank 0

        ; 96/CA56

      rlUnknown96CA56 ; 96/CA56

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        sep #$20
        lda $7FE4B7
        ora #$01
        sta $7FE4B7
        rep #$20
        tya
        and #$01FF
        sta wR0
        phb
        jsl _CA74
        plb
        .databank ?
        bra _CA96


        _CA74
        lda wR0
        cmp #$0048
        bmi _CA7D

        _CA7B
        bra _CA7B


        _CA7D
        asl a
        adc wR0
        tax
        lda $97BDD4,x
        sta lR23
        sep #$20
        lda $97BDD6,x
        sta lR23+2
        pha
        plb
        .databank ?
        rep #$20
        jml [lR23]


        _CA96
        lda $7FE4B7
        bit #$0001
        bne _CAA4
        pla
        pha
        jsr rsUnknown96A49B

        _CAA4
        ply
        plx
        rtl

        .databank 0

        ; 96/CAA7

      rlUnknown96CAA7 ; 96/CAA7

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        clc
        jsl rlUnknown96CAB3
        rtl

        .databank 0

        ; 96/CAAD

      rlUnknown96CAAD ; 96/CAAD

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        sec
        jsl rlUnknown96CAB3
        rtl

        .databank 0

        ; 96/CAB3

      rlUnknown96CAB3 ; 96/CAB3

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        bcs _CADA
        lda $0D50,b
        jsl rlGetCharacterPortraitData
        ldy #$0000
        ldx #$0000

        _CAC4
        lda [lR19],y
        sta aBGPaletteBuffer.aPalette7,b,x
        inc x
        inc x
        inc y
        inc y
        cpx #$0020
        bcc _CAC4
        lda #$35AD
        sta $01FC,b
        bra _CB07


        _CADA
        lda $7FE4D6
        sta lR18
        lda $7FE4D7
        sta lR18+1
        jsr rsUnknown96F7A8
        jsl rlGetCharacterPortraitData
        ldy #$0000
        ldx #$0000

        _CAF3
        lda [lR19],y
        sta aBGPaletteBuffer.aPalette7,b,x
        inc x
        inc x
        inc y
        inc y
        cpx #$0020
        bcc _CAF3
        lda #$0000
        sta $01FC,b

        _CB07
        ply
        plx
        rtl

        .databank 0

        ; 96/CB0A

      rlUnknown96CB0A ; 96/CB0A

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$00
        sta $7FED5C
        sta $7FED64
        sta $7FED6E
        sta $7FED8A
        sta $7FED5D
        sta $7FED65
        sta $7FED63
        sta $7FED6B
        lda #$0F
        sta $7FED6C
        lda #$70
        sta $7FED6D
        rep #$20
        lda #$00FF
        sta $7FE51B
        rtl

        .databank 0

        ; 96/CB44

    .endsection Unsorted96C9D9Section


    .section Unsorted96CB44Section

      .al
      .xl

      rlUnknown96CB44 ; 96/CB44

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        ldx #$0000

        _CB49
        lda $7FED5C,x
        bit #$0001
        beq _CB5F
        bit #$0002
        bne _CB5C
        jsr rsUnknown96CB6D
        bra _CB5F


        _CB5C
        jsr rsUnknown96D43F

        _CB5F
        txa
        clc
        adc #$0008
        tax
        cpx #$0010
        bcc _CB49
        ply
        plx
        rtl

        .databank 0

        ; 96/CB6D

      rsUnknown96CB6D ; 96/CB6D

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda $7FED5D,x
        beq _CB7C
        dec a
        sta $7FED5D,x
        bra _CBD2


        _CB7C
        rep #$20

        _CB7E
        jsr rsUnknown96CDA3
        xba
        and #$00FF
        cmp #$00FF
        bne _CB8F
        jsr rsUnknown96CBE1
        bra _CBD2


        _CB8F
        cmp #$00FD
        bne _CB99
        jsr rsUnknown96CC1A
        bra _CBD2


        _CB99
        cmp #$00FE
        bne _CBA3
        jsr rsUnknown96CC40
        bra _CBD0


        _CBA3
        cmp #$00FC
        bne _CBAD
        jsr rsUnknown96CC7B
        bra _CBD0


        _CBAD
        cmp #$00FB
        bne _CBB7
        jsr rsUnknown96CCAF
        bra _CBD0


        _CBB7
        cmp #$00FA
        bne _CBC1
        jsr rsUnknown96CD23
        bra _CBD0


        _CBC1
        cmp #$00F9
        bne _CBCB
        jsr rsUnknown96CD32
        bra _CBD0


        _CBCB
        jsr rsUnknown96CD51
        bra _CBD2


        _CBD0
        bra _CB7E


        _CBD2
        .as
        rep #$20
        jsl rlUnknown96D256
        jsl rlUnknown96D05F
        jsl rlUnknown96CEE6
        rts

        .databank 0

        ; 96/CBE1

      rsUnknown96CBE1 ; 96/CBE1

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown96ACAB
        sep #$20
        phx
        cpx #$0000
        beq _CBEF
        ldx #$001C

        _CBEF
        lda $7FED6E,x
        and #$FE
        sta $7FED6E,x
        plx
        lda $7FED5C,x
        and #$FE
        sta $7FED5C,x
        rep #$20
        jsl rlUnknown96CECE
        sep #$20
        lda $7FE4B8
        beq _CC13
        dec a

        _CC13
        sta $7FE4B8
        rep #$20
        rts

        .databank 0

        ; 96/CC1A

      rsUnknown96CC1A ; 96/CC1A

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        phx
        cpx #$0000
        beq _CC25
        ldx #$001C

        _CC25
        lda $7FED6E,x
        and #$FE
        sta $7FED6E,x
        plx
        sep #$20
        lda $7FE4B8
        beq _CC39
        dec a

        _CC39
        sta $7FE4B8
        rep #$20
        rts

        .databank 0

        ; 96/CC40

      rsUnknown96CC40 ; 96/CC40

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FED63,x
        and #$00FF
        beq _CC62
        dec a
        sep #$20
        sta $7FED63,x
        rep #$20
        bne _CC72
        lda $7FED61,x
        clc
        adc #$0002
        sta $7FED61,x
        bra _CC7A


        _CC62
        jsr rsUnknown96CDA3
        and #$00FF
        beq _CC72
        sep #$20
        sta $7FED63,x
        rep #$20

        _CC72
        lda $7FED5E,x
        sta $7FED61,x

        _CC7A
        rts

        .databank 0

        ; 96/CC7B

      rsUnknown96CC7B ; 96/CC7B

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        ldx $0AE9,b
        lda $0AF8,b,x
        sta aUnit2DataBuffer._ROM.StrengthGrowth
        lda $0AF9,b,x
        sta $7FEC1F
        lda $0AFB,b,x
        sta $7FEC21
        lda $0AFD,b,x
        clc
        adc #$3000
        sta $7FEC23
        lda $7FEC29
        clc
        adc #$0002
        sta $7FEC29
        plx
        pla
        rts

        .databank 0

        ; 96/CCAF

      rsUnknown96CCAF ; 96/CCAF

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        ldx $0AEB,b
        lda $0AF8,b,x
        sta aUnit2DataBuffer._ROM.StrengthGrowth
        lda $0AF9,b,x
        sta $7FEC1F
        lda $0AFB,b,x
        sta $7FEC21
        lda $0AFD,b,x
        clc
        adc #$1000
        sta $7FEC23
        jsl rlUnknown95B050
        lda wR0
        cmp #$0100
        bcc _CCFF
        lda $7FEC1F
        cmp #$0180
        bcc _CCED
        lda #$0180
        bra _CCF7


        _CCED
        cmp #$0080
        bcs _CCF7
        lda #$0080
        bra _CCF7


        _CCF7
        sec
        sbc #$0080
        sta $7FE198

        _CCFF
        lda $7FEC29
        clc
        adc #$0002
        sta $7FEC29
        plx
        pla
        rts

        .databank 0

        ; 96/CD0E

    .endsection Unsorted96CB44Section


    .section Unsorted96CD23Section

      .al
      .xl

      rsUnknown96CD23 ; 96/CD23

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        sep #$20
        lda #$01
        sta $7FEC2B
        rep #$20
        plx
        pla
        rts

        .databank 0

        ; 96/CD32

      rsUnknown96CD32 ; 96/CD32

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        lda #$0100
        sta $7FED6F,x
        lda #$00C8
        sta $7FED71,x
        lda $7FED61,x
        clc
        adc #$0002
        sta $7FED61,x
        plx
        pla
        rts

        .databank 0

        ; 96/CD51

      rsUnknown96CD51 ; 96/CD51

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda $7FED5F,x
        sta lR18+1
        lda $7FED61,x
        sta lR18
        lda $7FED61,x
        clc
        adc #$0007
        sta $7FED61,x
        sep #$20
        ldy #$0000
        lda [lR18],y
        sta $7FED5D,x
        rep #$20
        cpx #$0000
        bne _CD82
        ldx #$0000
        bra _CD85


        _CD82
        ldx #$0008

        _CD85
        ldy #$0001
        lda [lR18],y
        sta $7FED73,x
        ldy #$0003
        lda [lR18],y
        sta $7FED75,x
        ldy #$0005
        lda [lR18],y
        sta $7FED77,x
        ply
        plx
        rts

        .databank 0

        ; 96/CDA3

      rsUnknown96CDA3 ; 96/CDA3

        .al
        .xl
        .autsiz
        .databank ?

        phy
        lda $7FED5F,x
        sta lR18+1
        lda $7FED61,x
        sta lR18
        ldy #$0000
        lda [lR18],y
        ply
        rts

        .databank 0

        ; 96/CDB7

    .endsection Unsorted96CD23Section


    .section Unsorted96CECESection

      .al
      .xl

      rlUnknown96CECE ; 96/CECE

        .al
        .xl
        .autsiz
        .databank ?

        phx
        cpx #$0000
        bne _CEDD
        lda #$0003
        jsl rlHDMAEngineFreeEntryByIndex
        bra _CEE4


        _CEDD
        lda #$0006
        jsl rlHDMAEngineFreeEntryByIndex

        _CEE4
        plx
        rtl

        .databank 0

        ; 96/CEE6

      rlUnknown96CEE6 ; 96/CEE6

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7FED5C
        bit #$0002
        bne _CF23
        lda $7FED6E
        bit #$0001
        beq _CF23
        ldx #$0000
        lda $7FE09E
        bit #$0001
        bne _CF0A
        ldy #$E51D
        bra _CF0D


        _CF0A
        ldy #$E6DD

        _CF0D
        lda $7FED79
        and #$00FF
        sta wR2
        lda $7FED74
        and #$00FF
        sta wR5
        jsl rlUnknown96CF58

        _CF23
        lda $7FED8A
        bit #$0001
        beq _CF56
        ldx #$001C
        lda $7FE09E
        bit #$00FF
        bne _CF3D
        ldy #$E89D
        bra _CF40


        _CF3D
        ldy #$EA5D

        _CF40
        lda $7FED95
        and #$00FF
        sta wR2
        lda $7FED90
        and #$00FF
        sta wR5
        jsl rlUnknown96CF58

        _CF56
        plx
        rtl

        .databank 0

        ; 96/CF58

      rlUnknown96CF58 ; 96/CF58

        ; TRACE: stack-args
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        phx
        lda $7FED6C
        and #$00FF
        sta wR3
        beq _CF74
        sta $7FED7A,x
        lda #$E51B
        sta $7FED7B,x
        inc x
        inc x
        inc x

        _CF74
        phx
        lda #3,s
        tax
        lda $7FED71,x
        plx
        sec
        sbc #$00FF
        clc
        adc wR5
        sec
        sbc wR3
        bmi _CFDF
        beq _CFDD
        pha
        lda $7FED6D
        and #$00FF
        cmp #1,s
        beq _CF99
        bcs _CF9E

        _CF99
        pla
        jml _D043


        _CF9E
        pla
        cmp #$0080
        bcc _CFCD
        pha
        lda #$007F
        sta $7FED7A,x
        lda #$E51B
        sta $7FED7B,x
        lda #1,s
        sec
        sbc #$007F
        inc x
        inc x
        inc x
        sta $7FED7A,x
        lda #$E51B
        sta $7FED7B,x
        pla
        inc x
        inc x
        inc x
        bra _CFFE


        _CFCD
        sta $7FED7A,x
        pha
        lda #$E51B
        sta $7FED7B,x
        pla
        inc x
        inc x
        inc x

        _CFDD
        bra _CFFE


        _CFDF
        pha
        clc
        adc wR2
        bmi _CFFB
        beq _CFFB
        sta wR2
        pla
        eor #$FFFF
        inc a
        asl a
        pha
        tya
        clc
        adc #1,s
        tay
        pla
        lda #$0000
        bra _CFFE


        _CFFB
        pla
        bra _D043


        _CFFE
        pha
        lda $7FED6D
        and #$00FF
        sec
        sbc #1,s
        cmp wR2
        bcs _D012
        sta #1,s
        pla
        bra _D015


        _D012
        pla
        lda wR2

        _D015
        cmp #$0080
        bcc _D034
        pha
        lda #$00FF
        sta $7FED7A,x
        tya
        sta $7FED7B,x
        clc
        adc #$00FE
        tay
        pla
        sec
        sbc #$007F
        inc x
        inc x
        inc x

        _D034
        ora #$0080
        sta $7FED7A,x
        tya
        sta $7FED7B,x
        inc x
        inc x
        inc x

        _D043
        lda #$0001
        sta $7FED7A,x
        lda #$E51B
        sta $7FED7B,x
        sep #$20
        lda #$00
        sta $7FED7D,x
        rep #$20
        plx
        ply
        plx
        rtl

        .databank 0

        ; 96/D05F

      rlUnknown96D05F ; 96/D05F

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7FED6E
        bit #$0001
        beq _D08A
        lda $7FED6F
        sta wR0
        lda $7FE09E
        bit #$0001
        bne _D082
        lda $7FED79
        jsl rlUnknown96D0B6
        bra _D08A


        _D082
        lda $7FED79
        jsl rlUnknown96D185

        _D08A
        lda $7FED8A
        bit #$0001
        beq _D0B4
        lda $7FED8B
        sta wR0
        lda $7FE09E
        bit #$0001
        bne _D0AC
        lda $7FED95
        jsl rlUnknown96D11D
        bra _D0B4


        _D0AC
        lda $7FED95
        jsl rlUnknown96D1EC

        _D0B4
        plx
        rtl

        .databank 0

        ; 96/D0B6

      rlUnknown96D0B6 ; 96/D0B6

        .al
        .xl
        .autsiz
        .databank ?

        phb
        phx
        phy
        and #$00FF
        bne _D0C1
        lda #$0100

        _D0C1
        asl a
        tax
        sep #$20
        lda #$7F
        pha
        plb
        .databank $7F
        rep #$20
        lda wR0
        sec
        sbc #$0100
        sta wR0

        _D0D3
        lda $EDA9,b,x
        and #$00FF
        clc
        adc wR0
        bpl _D0E3
        lda #$0000
        bra _D0F0


        _D0E3
        cmp #$0100
        bcc _D0F0
        lda #$00FF
        sta $E51B,b,x
        bra _D115


        _D0F0
        sta $E51B,b,x
        lda $EFA9,b,x
        and #$00FF
        clc
        adc wR0
        bpl _D106
        lda #$00FF
        sta $E51B,b,x
        bra _D115


        _D106
        cmp #$0100
        bcc _D10E
        lda #$00FF

        _D10E
        sep #$20
        sta $E51C,b,x
        rep #$20

        _D115
        dec x
        dec x
        bne _D0D3
        ply
        plx
        plb
        .databank $7F
        rtl

        .databank 0

        ; 96/D11D

      rlUnknown96D11D ; 96/D11D

        .al
        .xl
        .autsiz
        .databank ?

        phb
        phx
        phy
        and #$00FF
        bne _D128
        lda #$0100

        _D128
        asl a
        tax
        sep #$20
        lda #$7F
        pha
        plb
        .databank $7F
        rep #$20
        lda wR0
        sec
        sbc #$0100
        sta wR0

        _D13A
        lda $F1A9,b,x
        and #$00FF
        clc
        adc wR0
        bpl _D14A
        lda #$0000
        bra _D157


        _D14A
        cmp #$0100
        bcc _D157
        lda #$00FF
        sta $E89B,b,x
        bra _D17D


        _D157
        sta @l $7FE89B,x
        lda $F3A9,b,x
        and #$00FF
        clc
        adc wR0
        bpl _D16E
        lda #$00FF
        sta $E89B,b,x
        bra _D17D


        _D16E
        cmp #$0100
        bcc _D176
        lda #$00FF

        _D176
        sep #$20
        sta $E89C,b,x
        rep #$20

        _D17D
        dec x
        dec x
        bne _D13A
        ply
        plx
        plb
        .databank $7F
        rtl

        .databank 0

        ; 96/D185

      rlUnknown96D185 ; 96/D185

        .al
        .xl
        .autsiz
        .databank ?

        phb
        phx
        phy
        and #$00FF
        bne _D190
        lda #$0100

        _D190
        asl a
        tax
        sep #$20
        lda #$7F
        pha
        plb
        .databank $7F
        rep #$20
        lda wR0
        sec
        sbc #$0100
        sta wR0

        _D1A2
        lda $EDA9,b,x
        and #$00FF
        clc
        adc wR0
        bpl _D1B2
        lda #$0000
        bra _D1BF


        _D1B2
        cmp #$0100
        bcc _D1BF
        lda #$00FF
        sta $E6DB,b,x
        bra _D1E4


        _D1BF
        sta $E6DB,b,x
        lda $EFA9,b,x
        and #$00FF
        clc
        adc wR0
        bpl _D1D5
        lda #$00FF
        sta $E6DB,b,x
        bra _D1E4


        _D1D5
        cmp #$0100
        bcc _D1DD
        lda #$00FF

        _D1DD
        sep #$20
        sta $E6DC,b,x
        rep #$20

        _D1E4
        dec x
        dec x
        bne _D1A2
        ply
        plx
        plb
        .databank $7F
        rtl

        .databank 0

        ; 96/D1EC

      rlUnknown96D1EC ; 96/D1EC

        .al
        .xl
        .autsiz
        .databank ?

        phb
        phx
        phy
        and #$00FF
        bne _D1F7
        lda #$0100

        _D1F7
        asl a
        tax
        sep #$20
        lda #$7F
        pha
        plb
        .databank $7F
        rep #$20
        lda wR0
        sec
        sbc #$0100
        sta wR0

        _D209
        lda $F1A9,b,x
        and #$00FF
        clc
        adc wR0
        bpl _D219
        lda #$0000
        bra _D226


        _D219
        cmp #$0100
        bcc _D226
        lda #$00FF
        sta $EA5B,b,x
        bra _D24C


        _D226
        sta @l $7FEA5B,x
        lda $F3A9,b,x
        and #$00FF
        clc
        adc wR0
        bpl _D23D
        lda #$00FF
        sta $EA5B,b,x
        bra _D24C


        _D23D
        cmp #$0100
        bcc _D245
        lda #$00FF

        _D245
        sep #$20
        sta $EA5C,b,x
        rep #$20

        _D24C
        dec x
        dec x
        bne _D209
        ply
        plx
        plb
        .databank $7F
        rtl

        .databank 0

        ; 96/D254

    .endsection Unsorted96CECESection


    .section Unsorted96D256Section

      .al
      .xl

      rlUnknown96D256 ; 96/D256

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000
        ldy #$0000

        _D25D
        lda $7FED6E,x
        bit #$0001
        beq _D2C2
        lda $7FED72,x
        and #$FF00
        sta wR4
        lda $7FED73,x
        and #$FF00
        sta wR5
        lda $7FED74,x
        and #$FF00
        sta wR6
        lda $7FED75,x
        and #$FF00
        sta wR7
        lda $7FED76,x
        and #$FF00
        sta wR8
        lda $7FED77,x
        and #$FF00
        sta wR9
        cpx #$0000
        bne _D2A6
        ldy #$0000
        bra _D2A9


        _D2A6
        ldy #$0380

        _D2A9
        tya
        sta $7FEDA6
        clc
        adc #$0200
        sta $7FEDA8
        jsl rlUnknown96D2D7
        sep #$20
        sta $7FED79,x
        rep #$20

        _D2C2
        tya
        clc
        adc #$0400
        tay
        txa
        clc
        adc #$001C
        tax
        cpx #$0038
        bcc _D25D
        plx
        rtl

        .databank 0

        ; 96/D2D5

    .endsection Unsorted96D256Section


    .section Unsorted96D2D7Section

      .al
      .xl

      rlUnknown96D2D7 ; 96/D2D7

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda wR7
        sec
        sbc wR5
        xba
        and #$00FF
        inc a
        tay
        sta wR14
        lda wR6
        sec
        sbc wR4
        bcs _D2F1
        eor #$FFFF
        inc a

        _D2F1
        sta wR13
        jsl rlUnsignedDivide16By16R13
        lda wR13
        sta wR1
        lda wR4
        sta wR0
        lda $7FEDA6
        tax
        lda wR4
        cmp wR6
        bcs _D30F
        jsr rsUnknown96D417
        bra _D312


        _D30F
        jsr rsUnknown96D402

        _D312
        txa
        sta $7FEDA6
        lda wR9
        sec
        sbc wR5
        xba
        and #$00FF
        inc a
        tay
        sta wR14
        lda wR8
        sec
        sbc wR4
        bcs _D32F
        eor #$FFFF
        inc a

        _D32F
        sta wR13
        jsl rlUnsignedDivide16By16R13
        lda wR13
        sta wR1
        lda wR4
        sta wR0
        lda $7FEDA8
        tax
        lda wR4
        cmp wR8
        bcs _D34D
        jsr rsUnknown96D3ED
        bra _D350


        _D34D
        jsr rsUnknown96D42C

        _D350
        txa
        sta $7FEDA8
        lda wR7
        cmp wR9
        bne _D369
        sec
        sbc wR5
        xba
        and #$00FF
        inc a
        sta wR2
        jml _D3E8


        _D369
        lda wR9
        sec
        sbc wR7
        bcs _D374
        eor #$FFFF
        inc a

        _D374
        xba
        and #$00FF
        tay
        sta wR14
        lda wR8
        sec
        sbc wR6
        bcs _D386
        eor #$FFFF
        inc a

        _D386
        sta wR13
        jsl rlUnsignedDivide16By16R13
        lda wR13
        sta wR1
        lda wR7
        cmp wR9
        bcc _D3C0
        lda wR8
        sta wR0
        lda $7FEDA8
        tax
        lda wR6
        cmp wR8
        bcs _D3AA
        jsr rsUnknown96D402
        bra _D3AD


        _D3AA
        jsr rsUnknown96D3ED

        _D3AD
        txa
        sta $7FEDA8
        lda wR7
        sec
        sbc wR5
        xba
        and #$00FF
        inc a
        sta wR2
        bra _D3E8


        _D3C0
        lda wR6
        sta wR0
        lda $7FEDA6
        tax
        lda wR8
        cmp wR6
        bcs _D3D4
        jsr rsUnknown96D402
        bra _D3D7


        _D3D4
        jsr rsUnknown96D3ED

        _D3D7
        txa
        sta $7FEDA6
        lda wR9
        sec
        sbc wR5
        xba
        and #$00FF
        inc a
        sta wR2

        _D3E8
        ply
        plx
        rtl

        .databank 0

        ; 96/D3EB

    .endsection Unsorted96D2D7Section


    .section Unsorted96D3EDSection

      .al
      .xl

      rsUnknown96D3ED ; 96/D3ED

        .al
        .xl
        .autsiz
        .databank ?

        lda wR1
        pha
        lda wR0

        _D3F2
        clc
        adc #1,s
        sta $7FEDAA,x
        inc x
        inc x
        dec y
        bne _D3F2
        pla
        rts

        .databank 0

        ; 96/D400

    .endsection Unsorted96D3EDSection


    .section Unsorted96D402Section

      .al
      .xl

      rsUnknown96D402 ; 96/D402

        .al
        .xl
        .autsiz
        .databank ?

        lda wR1
        pha
        lda wR0

        _D407
        sec
        sbc #1,s
        sta $7FEDAA,x
        inc x
        inc x
        dec y
        bne _D407
        pla
        rts

        .databank 0

        ; 96/D415

    .endsection Unsorted96D402Section


    .section Unsorted96D417Section

      .al
      .xl

      rsUnknown96D417 ; 96/D417

        .al
        .xl
        .autsiz
        .databank ?

        lda wR1
        pha
        lda wR0

        _D41C
        sta $7FEDAA,x
        clc
        adc #1,s
        inc x
        inc x
        dec y
        bne _D41C
        pla
        rts

        .databank 0

        ; 96/D42A

    .endsection Unsorted96D417Section


    .section Unsorted96D42CSection

      .al
      .xl

      rsUnknown96D42C ; 96/D42C

        .al
        .xl
        .autsiz
        .databank ?

        lda wR1
        pha
        lda wR0

        _D431
        sta $7FEDAA,x
        sec
        sbc #1,s
        inc x
        inc x
        dec y
        bne _D431
        pla
        rts

        .databank 0

        ; 96/D43F

      rsUnknown96D43F ; 96/D43F

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda $7FED6E
        bit #$0001
        bne _D44E
        jml _D5D8


        _D44E
        lda $7FED5D
        and #$00FF
        beq _D464
        sep #$20
        dec a
        sta $7FED5D
        rep #$20
        jml _D5D8


        _D464
        sep #$20
        lda $7FED6E
        eor #$02
        sta $7FED6E
        rep #$20
        bit #$0002
        bne _D47C
        lda #$0000
        bra _D47F


        _D47C
        lda #$01C0

        _D47F
        sta $7FEDA6
        inc a
        sta $7FEDA8
        lda $7FED5F
        sta lR18+1
        lda $7FED61
        sta lR18
        clc
        adc #$000F
        sta $7FED61
        ldy #$0000
        lda [lR18],y
        xba
        and #$00FF
        cmp #$00FF
        bne _D4B1
        jsr rsUnknown96CBE1
        jml _D5D8


        _D4B1
        cmp #$00FD
        bne _D4BD
        jsr rsUnknown96CC1A
        jml _D5D8


        _D4BD
        sep #$20
        ldy #$0000
        lda [lR18],y
        sta $7FED5D
        inc y
        rep #$20
        lda [lR18],y
        sta $7FF5AA
        inc y
        inc y
        lda [lR18],y
        bit #$007F
        beq _D52A
        bit #$0080
        bne _D4F4
        and #$007F
        sta wR2
        asl a
        pha
        lda $7FEDA6
        tax
        clc
        adc #1,s
        sta $7FEDA6
        bra _D507


        _D4F4
        and #$007F
        sta wR2
        asl a
        pha
        lda $7FEDA8
        tax
        clc
        adc #1,s
        sta $7FEDA8

        _D507
        pla
        lda [lR18],y
        and #$FF00
        pha
        inc y
        inc y
        lda [lR18],y
        sta wR0
        pla
        inc y
        inc y

        _D517
        sep #$20
        xba
        sta $7FE51D,x
        xba
        rep #$20
        inc x
        inc x
        clc
        adc wR0
        dec wR2
        bne _D517

        _D52A
        lda [lR18],y
        bit #$007F
        beq _D581
        bit #$0080
        bne _D54B
        and #$007F
        sta wR2
        asl a
        pha
        lda $7FEDA6
        tax
        clc
        adc #1,s
        sta $7FEDA6
        bra _D55E


        _D54B
        and #$007F
        sta wR2
        asl a
        pha
        lda $7FEDA8
        tax
        clc
        adc #1,s
        sta $7FEDA8

        _D55E
        pla
        lda [lR18],y
        and #$FF00
        pha
        inc y
        inc y
        lda [lR18],y
        sta wR0
        pla
        inc y
        inc y

        _D56E
        sep #$20
        xba
        sta $7FE51D,x
        xba
        rep #$20
        inc x
        inc x
        clc
        adc wR0
        dec wR2
        bne _D56E

        _D581
        lda [lR18],y
        bit #$007F
        beq _D5D8
        bit #$0080
        bne _D5A2
        and #$007F
        sta wR2
        asl a
        pha
        lda $7FEDA6
        tax
        clc
        adc #1,s
        sta $7FEDA6
        bra _D5B5


        _D5A2
        and #$007F
        sta wR2
        asl a
        pha
        lda $7FEDA8
        tax
        clc
        adc #1,s
        sta $7FEDA8

        _D5B5
        pla
        lda [lR18],y
        and #$FF00
        pha
        inc y
        inc y
        lda [lR18],y
        sta wR0
        pla
        inc y
        inc y

        _D5C5
        sep #$20
        xba
        sta $7FE51D,x
        xba
        rep #$20
        inc x
        inc x
        clc
        adc wR0
        dec wR2
        bne _D5C5

        _D5D8
        ply
        plx
        rts

        .databank 0

        ; 96/D5DB

    .endsection Unsorted96D42CSection


    .section Unsorted96D5DBSection

      .al
      .xl

      rlUnknown96D5DB ; 96/D5DB

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7FED5C
        and #$0003
        cmp #$0003
        bne _D657
        ldx #$0000
        lda $7FED6C
        and #$00FF
        sta $7FED7A,x
        lda #$E51B
        sta $7FED7B,x
        inc x
        inc x
        inc x
        lda $7FF5AA
        and #$00FF
        beq _D617
        sta $7FED7A,x
        lda #$E51B
        sta $7FED7B,x
        inc x
        inc x
        inc x

        _D617
        lda $7FF5AB
        and #$00FF
        beq _D63F
        ora #$0080
        sta $7FED7A,x
        lda $7FED6E
        bit #$0002
        bne _D635
        lda #$E51D
        bra _D638


        _D635
        lda #$E6DD

        _D638
        sta $7FED7B,x
        inc x
        inc x
        inc x

        _D63F
        lda #$0001
        sta $7FED7A,x
        lda #$E51B
        sta $7FED7B,x
        sep #$20
        lda #$00
        sta $7FED7D,x
        rep #$20

        _D657
        plx
        rtl

        .databank 0

        ; 96/D659

    .endsection Unsorted96D5DBSection


    .section Unsorted96D659Section

      .al
      .xl

      rlUnknown96D659 ; 96/D659

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000

        _D65D
        sep #$20
        lda #$80
        sta $7FFD9A,x
        rep #$20
        txa
        clc
        adc #$000A
        tax
        cpx #$0064
        bcc _D65D
        lda #$0000
        sta $7FFDFE
        plx
        rtl

        .databank 0

        ; 96/D67B

    .endsection Unsorted96D659Section


    .section Unsorted96D67BSection

      .al
      .xl

      rlUnknown96D67B ; 96/D67B

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$0000
        sta aBGPaletteBuffer,b
        ldx #$0000

        _D685
        lda aBGPaletteBuffer,b,x
        sta $7FFE00,x
        inc x
        inc x
        cpx #$0200
        bcc _D685
        plx
        rtl

        .databank 0

        ; 96/D695

    .endsection Unsorted96D67BSection


    .section Unsorted96D695Section

      .al
      .xl

      rlUnknown96D695 ; 96/D695

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        ldx #$0000

        _D69A
        lda $7FFD9A,x
        bit #$0080
        bne _D6CE
        lda $7FFDA3,x
        and #$00FF
        beq _D6BB
        sep #$20
        lda $7FFDA3,x
        dec a
        sta $7FFDA3,x
        rep #$20
        bra _D6CE


        _D6BB
        lda $7FFD9A,x
        and #$003F
        sta wR0
        txy
        phx
        lda wR0
        asl a
        tax
        jsr ($96D6DD,x)
        plx

        _D6CE
        txa
        clc
        adc #$000A
        tax
        txy
        cpx #$0064
        bcc _D69A
        ply
        plx
        rtl

        .databank 0

        ; 96/D6DD

    .endsection Unsorted96D695Section


    .section Unsorted96D774Section

      .al
      .xl

      rsUnknown96D774 ; 96/D774

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        tyx
        phx
        lda $7FFDA1,x
        and #$00FF
        dec a
        bne _D78B
        lda $7FFDA0,x
        and #$00FF
        asl a
        tax
        bra _D7A3


        _D78B
        pha
        lda $7FFDA0,x
        and #$00FF
        asl a
        tax
        ply

        _D796
        lda @l $000102,x
        sta @l aBGPaletteBuffer,x
        inc x
        inc x
        dec y
        bne _D796

        _D7A3
        phx
        lda #3,s
        tax

        _D7A7
        lda $7FFD9C,x
        sta lR18+1
        lda $7FFD9E,x
        sta lR18
        ldy #$0000
        lda [lR18],y
        and #$00FF
        cmp #$00FF
        beq _D7CF
        cmp #$00FE
        beq _D7D6
        bit #$0080
        beq _D7E3
        and #$007F
        bra _D7E0


        _D7CF
        jsr rsUnknown96DB36
        plx
        plx
        bra _D807


        _D7D6
        lda $7FFD9B,x
        sta $7FFD9E,x
        bra _D7A7


        _D7E0
        inc y
        bra _D7E7


        _D7E3
        lda $7FFDA2,x

        _D7E7
        sep #$20
        sta $7FFDA3,x
        sta $7FFDA2,x
        rep #$20
        plx
        lda [lR18],y
        xba
        sta aBGPaletteBuffer,b,x
        inc y
        inc y
        plx
        tya
        clc
        adc $7FFD9E,x
        sta $7FFD9E,x

        _D807
        rts

        .databank 0

        ; 96/D808

      rsUnknown96D808 ; 96/D808

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        tyx
        phx
        lda $7FFDA1,x
        and #$00FF
        dec a
        bne _D81F
        lda $7FFDA0,x
        and #$00FF
        asl a
        tax
        bra _D83A


        _D81F
        pha
        lda $7FFDA0,x
        and #$00FF
        clc
        adc #1,s
        asl a
        tax
        ply

        _D82D
        lda @l wJoy2RepeatTimer,x
        sta @l aBGPaletteBuffer,x
        dec x
        dec x
        dec y
        bne _D82D

        _D83A
        phx
        lda #3,s
        tax

        _D83E
        lda $7FFD9C,x
        sta lR18+1
        lda $7FFD9E,x
        sta lR18
        ldy #$0000
        lda [lR18],y
        and #$00FF
        cmp #$00FF
        beq _D866
        cmp #$00FE
        beq _D86D
        bit #$0080
        beq _D87A
        and #$007F
        bra _D877


        _D866
        jsr rsUnknown96DB36
        plx
        plx
        bra _D89E


        _D86D
        lda $7FFD9B,x
        sta $7FFD9E,x
        bra _D83E


        _D877
        inc y
        bra _D87E


        _D87A
        lda $7FFDA2,x

        _D87E
        sep #$20
        sta $7FFDA3,x
        sta $7FFDA2,x
        rep #$20
        plx
        lda [lR18],y
        xba
        sta aBGPaletteBuffer,b,x
        inc y
        inc y
        plx
        tya
        clc
        adc $7FFD9E,x
        sta $7FFD9E,x

        _D89E
        rts

        .databank 0

        ; 96/D89F

    .endsection Unsorted96D774Section


    .section Unsorted96D912Section

      .al
      .xl

      rsUnknown96D912 ; 96/D912

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        tyx
        sep #$20
        lda $7FFDA2,x
        sta $7FFDA3,x
        rep #$20
        lda $7FFDA1,x
        and #$00FF
        tay
        lda $7FFDA0,x
        and #$00FF
        jsl rlUnknown959DAC
        bcc _D937
        jsr rsUnknown96DB36

        _D937
        rts

        .databank 0

        ; 96/D938

    .endsection Unsorted96D912Section


    .section Unsorted96D95ESection

      .al
      .xl

      rsUnknown96D95E ; 96/D95E

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        tyx
        sep #$20
        lda $7FFDA2,x
        sta $7FFDA3,x
        rep #$20
        lda $7FFD9B,x
        sta lR18
        lda $7FFD9C,x
        sta lR18+1
        lda $7FFDA1,x
        and #$00FF
        tay
        lda $7FFDA0,x
        and #$00FF
        jsl rlUnknown959F43
        bcc _D98F
        jsr rsUnknown96DB36

        _D98F
        rts

        .databank 0

        ; 96/D990

    .endsection Unsorted96D95ESection


    .section Unsorted96DB20Section

      .al
      .xl

      rlUnknown96DB20 ; 96/DB20

        .al
        .xl
        .autsiz
        .databank ?

        phx
        and #$00FF
        sta wR10
        lda #$000A
        sta wR11
        jsl rlUnsignedMultiply16By16
        ldx wR12
        jsr rsUnknown96DB36
        plx
        rtl

        .databank 0

        ; 96/DB36

      rsUnknown96DB36 ; 96/DB36

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda $7FFD9A,x
        ora #$80
        sta $7FFD9A,x
        lda $7FFD9A,x
        bit #$40
        beq _DB55
        lda $7FE4B8
        beq _DB51
        dec a

        _DB51
        sta $7FE4B8

        _DB55
        rep #$20
        rts

        .databank 0

        ; 96/DB58

    .endsection Unsorted96DB20Section


    .section Unsorted96DB58Section

      .al
      .xl

      rlUnknown96DB58 ; 96/DB58

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        tya
        and #$C000
        cmp #$4000
        bne _DB68
        lda #$0001
        bra _DB6B


        _DB68
        lda #$0000

        _DB6B
        sta wR0
        lda #$9700
        sta lR18+1
        tya
        and #$01FF
        asl a
        clc
        adc #$A9A8
        sta lR18
        ldy #$0000
        lda [lR18],y
        clc
        adc #$A9A8
        sta lR18
        jsl rlUnknown96DB94
        lda #1,s
        jsr rsUnknown96A477
        ply
        plx
        rtl

        .databank 0

        ; 96/DB94

    .endsection Unsorted96DB58Section


    .section Unsorted96DB94Section

      .al
      .xl

      rlUnknown96DB94 ; 96/DB94

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        ldy #$0000
        lda [lR18],y
        inc y
        and #$00FF
        sta wR10
        lda #$000A
        sta wR11
        jsl rlUnsignedMultiply16By16
        ldx wR12
        sep #$20
        lda [lR18],y
        and #$3F
        pha
        inc y
        sta $7FFD9A,x
        lda wR0
        beq _DBC6
        lda $7FFD9A,x
        ora #$40
        sta $7FFD9A,x

        _DBC6
        lda [lR18],y
        inc y
        sta $7FFDA0,x
        lda [lR18],y
        inc y
        sta $7FFDA1,x
        lda #$00
        sta $7FFDA3,x
        sta $7FFDA2,x
        pla
        cmp #$00
        beq _DC1B
        cmp #$01
        beq _DC1B
        cmp #$02
        beq _DC1B
        cmp #$03
        beq _DC3A
        cmp #$04
        beq _DC3A
        cmp #$05
        beq _DC3A
        cmp #$06
        beq _DC3A
        cmp #$07
        beq _DC42
        cmp #$08
        beq _DC60
        cmp #$09
        beq _DC60
        cmp #$0A
        beq _DC62
        cmp #$0B
        beq _DC60
        cmp #$0C
        beq _DC1B
        lda #$80
        sta $7FFD9A,x
        bra _DC77


        _DC1B
        lda [lR18],y
        inc y
        sta $7FFD9B,x
        sta $7FFD9E,x
        lda [lR18],y
        inc y
        sta $7FFD9C,x
        sta $7FFD9F,x
        lda [lR18],y
        inc y
        sta $7FFD9D,x
        bra _DC77


        _DC3A
        lda [lR18],y
        sta $7FFDA2,x
        bra _DC77


        _DC42
        lda [lR18],y
        inc y
        sta $7FFDA2,x
        lda [lR18],y
        inc y
        sta $7FFD9B,x
        lda [lR18],y
        inc y
        sta $7FFD9C,x
        lda [lR18],y
        inc y
        sta $7FFD9D,x
        bra _DC77


        _DC60
        bra _DC77


        _DC62
        lda [lR18],y
        inc y
        sta $7FFD9B,x
        lda [lR18],y
        inc y
        sta $7FFD9C,x
        lda [lR18],y
        inc y
        sta $7FFD9D,x

        _DC77
        rep #$20
        ply
        plx
        rtl

        .databank 0

        ; 96/DC7C

    .endsection Unsorted96DB94Section


    .section Unsorted96DC7CSection

      .al
      .xl

      rlUnknown96DC7C ; 96/DC7C

        .al
        .xl
        .autsiz
        .databank ?

        phx
        cpx #$0000
        bne _DC87
        ldx #$0000
        bra _DC8A


        _DC87
        ldx #$000E

        _DC8A
        lda $0D52,b,x
        pha
        ldx #$0000

        _DC91
        lda $99832D,x
        cmp #$FFFF
        bne _DCA1
        lda #$0000
        sta #1,s
        bra _DCC5


        _DCA1
        and #$00FF
        cmp #1,s
        beq _DCAD
        inc x
        inc x
        inc x
        bra _DC91


        _DCAD
        lda wBattleDistance
        cmp #$0003
        bcs _DCBC
        lda $99832E,x
        bra _DCC0


        _DCBC
        lda $99832F,x

        _DCC0
        and #$00FF
        sta #1,s

        _DCC5
        pla
        plx
        rtl

        .databank 0

        ; 96/DCC8

    .endsection Unsorted96DC7CSection


    .section Unsorted96DD39Section

      .al
      .xl

      rlUnknown96DD39 ; 96/DD39

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$00
        sta $7FE475
        sta $7FE475
        sta $7FE475
        rep #$20
        lda #$0000
        sta $7FE486
        sta $7FE488
        sta $7FE49B
        sta $7FE49D
        sta $7FE4B0
        sta $7FE4B2
        lda #$FFFF
        sta $7FE471
        rtl

        .databank 0

        ; 96/DD6E

    .endsection Unsorted96DD39Section


    .section Unsorted96DD6ESection

      .al
      .xl

      rlUnknown96DD6E ; 96/DD6E

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FE1B3
        bit #$0002
        bne _DDD9
        lda $7FE475
        bit #$0040
        beq _DDAB
        lda $7FE477
        and #$03FF
        sec
        sbc #$0100
        jsl rlUnknown95A164
        eor #$FFFF
        inc a
        sec
        sbc $7FE486
        sta wBufferBG1HOFS
        lda $7FE47A
        eor #$FFFF
        inc a
        sec
        sbc $7FE488
        sta wBufferBG1VOFS
        bra _DDD9


        _DDAB
        lda $7FE477
        and #$03FF
        sec
        sbc $7FE198
        sec
        sbc #$0100
        jsl rlUnknown95A164
        eor #$FFFF
        inc a
        sec
        sbc $7FE486
        sta wBufferBG1HOFS
        lda $7FE47A
        eor #$FFFF
        inc a
        sec
        sbc $7FE488
        sta wBufferBG1VOFS

        _DDD9
        lda $7FE1B3
        bit #$0004
        beq _DDF8
        lda $7FE48C
        sec
        sbc $7FE49B
        sta wBufferBG2HOFS
        lda $7FE48F
        sec
        sbc $7FE49D
        sta wBufferBG2VOFS

        _DDF8
        lda $7FE1B3
        bit #$0008
        bne _DE6E
        lda bBufferBGMODE
        and #$0007
        cmp #$0002
        beq _DE6E
        lda $7FE4C2
        and #$00FF
        cmp #$0004
        beq _DE1C
        cmp #$0003
        bne _DE23

        _DE1C
        lda #$0000
        sta wBufferBG3HOFS
        bra _DE6E


        _DE23
        lda $7FE49F
        bit #$0040
        beq _DE44
        lda $7FE4A1
        sec
        sbc $7FE4B0
        sta wBufferBG3HOFS
        lda $7FE4A4
        sec
        sbc $7FE4B2
        sta wBufferBG3VOFS
        bra _DE6E


        _DE44
        lda $7FE4A1
        and #$03FF
        sec
        sbc $7FE198
        sec
        sbc #$0100
        eor #$FFFF
        inc a
        sec
        sbc $7FE4B0
        sta wBufferBG3HOFS
        lda $7FE4A4
        eor #$FFFF
        inc a
        sec
        sbc $7FE4B2
        sta wBufferBG3VOFS

        _DE6E
        rtl

        .databank 0

        ; 96/DE6F

      rlUnknown96DE6F ; 96/DE6F

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        ldx #$0000

        _DE74
        lda $7FE475,x
        bit #$0080
        beq _DE98
        and #$001F
        sec
        sbc #$0011
        bcc _DE98
        sta wR0
        txy
        phx
        phb
        php
        phk
        plb
        .databank $96
        lda wR0
        asl a
        tax
        jsr ($96DEAA,x)
        plp
        plb
        .databank $96
        plx

        _DE98
        txa
        clc
        adc #$0015
        tax
        cpx #$003F
        bcc _DE74
        jsl rlUnknown96E803
        ply
        plx
        rtl

        .databank 0

        ; 96/DEAA

    .endsection Unsorted96DD6ESection


    .section Unsorted96DEC0Section

      .al
      .xl

      rlUnknown96DEC0 ; 96/DEC0

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        tya
        sta wR0
        and #$01FF
        asl a
        tax
        lda #$9700
        sta lR18+1
        lda $97BEAC,x
        clc
        adc #$BEAC
        sta lR18
        jsl rlUnknown96DEE5
        lda #1,s
        jsr rsUnknown96A477
        ply
        plx
        rtl

        .databank 0

        ; 96/DEE5

      rlUnknown96DEE5 ; 96/DEE5

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        ldy #$0000
        lda [lR18],y
        inc y
        and #$0003
        cmp #$0003
        bcs _DF5C
        sta wR10
        lda #$0015
        sta wR11
        jsl rlUnsignedMultiply16By16
        ldx wR12
        sep #$20
        lda $7FE475,x
        ora #$80
        sta $7FE475,x
        rep #$20
        lda wR0
        and #$C000
        cmp #$4000
        bne _DF24
        sep #$20
        lda $7FE475,x
        ora #$20
        bra _DF2C


        _DF24
        .al
        sep #$20
        lda $7FE475,x
        and #$DF

        _DF2C
        sta $7FE475,x
        rep #$20
        lda [lR18],y
        and #$00FF
        sta wR0
        sep #$20
        lda $7FE475,x
        and #$E0
        ora wR0
        sta $7FE475,x
        rep #$20
        txy
        phx
        phb
        php
        phk
        plb
        .databank $96
        lda wR0
        asl a
        tax
        jsr ($96DF60,x)
        plp
        plb
        .databank $96
        plx
        clc
        bra _DF5D


        _DF5C
        sec

        _DF5D
        ply
        plx
        rtl

        .databank 0

        ; 96/DF60

    .endsection Unsorted96DEC0Section


    .section Unsorted96DFBBSection

      .al
      .xl

      rsUnknown96DFBB ; 96/DFBB

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta $7FE486,x
        sta $7FE488,x
        rts

        .databank 0

        ; 96/DFC7

    .endsection Unsorted96DFBBSection


    .section Unsorted96E01FSection

      .al
      .xl

      rsUnknown96E01F ; 96/E01F

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        tyx
        jsr rsUnknown96DFBB
        sep #$20
        lda $7FE475,x
        and #$7F
        and #$BF
        sta $7FE475,x
        rep #$20
        phx
        lda #$0000
        sta $7FE476,x
        ldx $0AE9,b
        lda $0AF9,b,x
        clc
        adc #$0100
        clc
        adc #$0100
        plx
        sta $7FE477,x
        phx
        lda #$0000
        sta $7FE479,x
        ldx $0AE9,b
        jsl rlUnknown95B5FD
        sec
        sbc #$0008
        pha
        lda #$0064
        sec
        sbc #1,s
        sta #1,s
        pla
        clc
        adc #$0080
        plx
        sta $7FE47A,x
        plx
        rts

        .databank 0

        ; 96/E077

    .endsection Unsorted96E01FSection


    .section Unsorted96E50ESection

      .al
      .xl

      rsUnknown96E50E ; 96/E50E

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        rts

        .databank 0

        ; 96/E50F

    .endsection Unsorted96E50ESection


    .section Unsorted96E612Section

      .al
      .xl

      rsUnknown96E612 ; 96/E612

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        tyx
        sep #$20
        lda $7FE475,x
        and #$BF
        sta $7FE475,x
        rep #$20
        phx
        ldx $0AEB,b
        lda $0AF9,b,x
        sta wR0
        jsl rlUnknown95B5FD
        sec
        sbc #$0008
        clc
        adc $0AFE,b,x
        and #$00FF
        sta wR1
        plx
        ldy #$0002
        lda [lR18],y
        and #$00FF
        jsl rlUnknown96E654
        lda #$0000
        sta $7FE47E,x
        ply
        plx
        rts

        .databank 0

        ; 96/E654

      rlUnknown96E654 ; 96/E654

        ; Reads the stack above its return address, but in the emulator log every
        ; caller continues right after the call: no inline arguments.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        and #$00FF
        pha
        lda wR0
        clc
        adc #$0100
        clc
        adc #$0100
        sec
        sbc $7FE477,x
        bpl _E67A
        eor #$FFFF
        inc a
        sta wR13
        lda #1,s
        xba
        eor #$FFFF
        inc a
        bra _E67F


        _E67A
        sta wR13
        lda #1,s
        xba

        _E67F
        sta $7FE47C,x
        lda #1,s
        sta wR14
        jsl rlUnsignedDivide16By16R13
        lda wR13
        sta $7FE480,x
        sta wR14
        lda wR1
        and #$00FF
        pha
        lda #$0064
        sec
        sbc #1,s
        sta #1,s
        pla
        clc
        adc #$0080
        sec
        sbc $7FE47A,x
        bpl _E6BB
        and #$00FF
        xba
        sta wR13
        jsl rlUnsignedDivide16By16R13
        lda wR13
        bra _E6CF


        _E6BB
        eor #$FFFF
        inc a
        and #$00FF
        xba
        sta wR13
        jsl rlUnsignedDivide16By16R13
        lda wR13
        eor #$FFFF
        inc a

        _E6CF
        sta $7FE47E,x
        pla
        ply
        plx
        rtl

        .databank 0

        ; 96/E6D7

    .endsection Unsorted96E612Section


    .section Unsorted96E716Section

      .al
      .xl

      rsUnknown96E716 ; 96/E716

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        tyx
        jsl rlUnknown96E9B8
        lda $7FE480,x
        bne _E74A
        sep #$20
        lda $7FE475,x
        and #$7F
        sta $7FE475,x
        rep #$20
        lda $7FE475,x
        bit #$0020
        beq _E748
        sep #$20
        lda $7FE4B8
        beq _E742
        dec a

        _E742
        sta $7FE4B8
        rep #$20

        _E748
        bra _E74F


        _E74A
        dec a
        sta $7FE480,x

        _E74F
        plx
        rts

        .databank 0

        ; 96/E751

      rsUnknown96E751 ; 96/E751

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        tyx
        jsl rlUnknown96E9B8
        lda $7FE477,x
        sec
        sbc $7FE198
        sec
        sbc #$0100
        cmp #$00C0
        bcc _E76E
        cmp #$0240
        bcc _E796

        _E76E
        sep #$20
        lda $7FE475,x
        and #$7F
        sta $7FE475,x
        rep #$20
        lda $7FE475,x
        bit #$0020
        beq _E794
        sep #$20
        lda $7FE4B8
        beq _E78E
        dec a

        _E78E
        sta $7FE4B8
        rep #$20

        _E794
        bra _E796


        _E796
        plx
        rts

        .databank 0

        ; 96/E798

    .endsection Unsorted96E716Section


    .section Unsorted96E803Section

      .al
      .xl

      rlUnknown96E803 ; 96/E803

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda $7FE471
        cmp #$FFFF
        bne _E812
        jml _E8DE


        _E812
        tax
        lda $7FE482,x
        and #$00FF
        beq _E820
        jml _E8D5


        _E820
        lda $7FE483,x
        sta lR18
        lda $7FE484,x
        sta lR18+1
        ldy #$0000
        lda [lR18],y
        and #$00FF
        cmp #$00FF
        beq _E863
        cmp #$00FE
        beq _E884
        inc y
        sep #$20
        sta $7FE482,x
        rep #$20
        lda [lR18],y
        sta $7FE486,x
        inc y
        inc y
        lda [lR18],y
        sta $7FE488,x
        lda $7FE483,x
        clc
        adc #$0005
        sta $7FE483,x
        bra _E8DE


        _E863
        lda #$FFFF
        sta $7FE471
        lda $7FE475,x
        bit #$0020
        beq _E882
        sep #$20
        lda $7FE4B8
        beq _E87C
        dec a

        _E87C
        sta $7FE4B8
        rep #$20

        _E882
        bra _E8DE


        _E884
        lda $7FE473
        beq _E894
        dec a
        sta $7FE473
        beq _E8C5
        inc y
        bra _E8A2


        _E894
        sta $7FE473
        inc y
        lda [lR18],y
        and #$00FF
        sta $7FE473

        _E8A2
        inc y
        lda [lR18],y
        and #$00FF
        bne _E8AD
        lda #$0001

        _E8AD
        pha
        asl a
        asl a
        clc
        adc #1,s
        sta #1,s
        lda $7FE483,x
        sec
        sbc #1,s
        sta $7FE483,x
        pla
        jml _E820


        _E8C5
        lda $7FE483,x
        clc
        adc #$0003
        sta $7FE483,x
        jml _E820


        _E8D5
        dec a
        sep #$20
        sta $7FE482,x
        rep #$20

        _E8DE
        ply
        plx
        rtl

        .databank 0

        ; 96/E8E1

    .endsection Unsorted96E803Section


    .section Unsorted96E9B8Section

      .al
      .xl

      rlUnknown96E9B8 ; 96/E9B8

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FE47C,x
        bmi _E9DE
        lda $7FE476,x
        clc
        adc $7FE47C,x
        sta $7FE476,x
        bcc _EA00
        sep #$20
        lda $7FE478,x
        inc a
        and #$03
        sta $7FE478,x
        rep #$20
        bra _EA00


        _E9DE
        eor #$FFFF
        inc a
        pha
        lda $7FE476,x
        sec
        sbc #1,s
        sta $7FE476,x
        pla
        bcs _EA00
        sep #$20
        lda $7FE478,x
        dec a
        and #$03
        sta $7FE478,x
        rep #$20

        _EA00
        lda $7FE47E,x
        cmp #$8000
        bne _EA31
        lda $7FE09E
        bit #$0001
        beq _EA79
        lda $7FE479,x
        sec
        sbc #$0100
        sta $7FE479,x
        bcs _EA79
        sep #$20
        lda $7FE47B,x
        dec a
        and #$01
        sta $7FE47B,x
        rep #$20
        bra _EA79


        _EA31
        lda $7FE47E,x
        bmi _EA57
        lda $7FE479,x
        clc
        adc $7FE47E,x
        sta $7FE479,x
        bcc _EA79
        sep #$20
        lda $7FE47B,x
        inc a
        and #$01
        sta $7FE47B,x
        rep #$20
        bra _EA79


        _EA57
        eor #$FFFF
        inc a
        pha
        lda $7FE479,x
        sec
        sbc #1,s
        sta $7FE479,x
        pla
        bcs _EA79
        sep #$20
        lda $7FE47B,x
        dec a
        and #$01
        sta $7FE47B,x
        rep #$20

        _EA79
        rtl

        .databank 0

        ; 96/EA7A

    .endsection Unsorted96E9B8Section


    .section Unsorted96EA99Section

      .al
      .xl

      rlUnknown96EA99 ; 96/EA99

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda #$9700
        sta lR18+1
        tya
        and #$01FF
        asl a
        clc
        adc #$C2A0
        sta lR18
        ldy #$0000
        lda [lR18],y
        clc
        adc #$C2A0
        sta lR18
        ldy #$0000
        lda [lR18],y
        bit #$0001
        bne _EAC5
        ldx $0AE9,b
        bra _EAC8


        _EAC5
        ldx $0AEB,b

        _EAC8
        lda $0AF9,b,x
        sta $7FE1A4
        ldy #$0001
        lda [lR18],y
        and #$00FF
        jsl rlUnknown95D6EC
        bcs _EAFC
        lda #1,s
        and #$C000
        cmp #$4000
        bne _EAF5
        sep #$20
        lda $7FE1A3
        ora #$01
        sta $7FE1A3
        rep #$20

        _EAF5
        lda #1,s
        jsr rsUnknown96A477
        bra _EAFF


        _EAFC
        jsr rsUnknown96A49B

        _EAFF
        ply
        plx
        rtl

        .databank 0

        ; 96/EB02

      rlUnknown96EB02 ; 96/EB02

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta $7FEC70
        sta $7FEC72
        sta $7FEC74
        sta $7FEC76
        sta $7FEC78
        sta $7FEC7A
        rtl

        .databank 0

        ; 96/EB1E

      rlUnknown96EB1E ; 96/EB1E

        .al
        .xl
        .autsiz
        .databank ?

        phb
        pha
        phx
        sep #$20
        lda #$7F
        pha
        plb
        .databank $7F
        rep #$20
        lda @l $7FEC70
        beq _EB43
        tax
        lda @l $7FEC7C
        sta @l $7FEC94,x
        inc x
        inc x
        inc x
        lda @l $7FEC7C
        sta @l $7FEC94,x

        _EB43
        lda @l $7FEC72
        beq _EB5D
        tax
        lda @l $7FEC7E
        sta @l $7FECA4,x
        inc x
        inc x
        inc x
        lda @l $7FEC7E
        sta @l $7FECA4,x

        _EB5D
        lda @l $7FEC74
        beq _EB77
        tax
        lda @l $7FEC80
        sta @l $7FECB4,x
        inc x
        inc x
        inc x
        lda @l $7FEC80
        sta @l $7FECB4,x

        _EB77
        lda @l $7FEC76
        beq _EB91
        tax
        lda @l $7FEC82
        sta @l $7FECC4,x
        inc x
        inc x
        inc x
        lda @l $7FEC82
        sta @l $7FECC4,x

        _EB91
        lda @l $7FEC78
        beq _EBAB
        tax
        lda @l $7FEC84
        sta @l $7FECD4,x
        inc x
        inc x
        inc x
        lda @l $7FEC84
        sta @l $7FECD4,x

        _EBAB
        lda @l $7FEC7A
        beq _EBC5
        tax
        lda @l $7FEC86
        sta @l $7FECE4,x
        inc x
        inc x
        inc x
        lda @l $7FEC86
        sta @l $7FECE4,x

        _EBC5
        plx
        pla
        plb
        .databank $7F
        rtl

        .databank 0

        ; 96/EBC9

      rlUnknown96EBC9 ; 96/EBC9

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda $7FF630
        and #$7F
        sta $7FF630
        rep #$20
        lda #$0000
        sta $7FE19F
        sta $7FE1A1
        rtl

        .databank 0

        ; 96/EBE3

    .endsection Unsorted96EA99Section


    .section Unsorted96EBE3Section

      .al
      .xl

      rlUnknown96EBE3 ; 96/EBE3

        .al
        .xl
        .autsiz
        .databank ?

        phy
        lda $7FF630
        bit #$0080
        beq _EC48

        _EBED
        lda $7FF632
        sta lR18+1
        lda $7FF634
        sta lR18
        ldy #$0000
        lda [lR18],y
        cmp #$8080
        bne _EC0D
        lda $7FF631
        sta $7FF634
        bra _EBED


        _EC0D
        cmp #$8081
        bne _EC18
        jsl rlUnknown96EC91
        bra _EC48


        _EC18
        lda [lR18],y
        and #$00FF
        bit #$0080
        beq _EC25
        ora #$FF00

        _EC25
        sta $7FE19F
        inc y
        lda [lR18],y
        and #$00FF
        bit #$0080
        beq _EC37
        ora #$FF00

        _EC37
        sta $7FE1A1
        inc y
        lda $7FF634
        clc
        adc #$0002
        sta $7FF634

        _EC48
        ply
        rtl

        .databank 0

        ; 96/EC4A

    .endsection Unsorted96EBE3Section


    .section Unsorted96EC91Section

      .al
      .xl

      rlUnknown96EC91 ; 96/EC91

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda $7FF630
        and #$7F
        sta $7FF630
        rep #$20
        lda #$0000
        sta $7FE19F
        sta $7FE1A1
        rtl

        .databank 0

        ; 96/ECAB

    .endsection Unsorted96EC91Section


    .section Unsorted96ECABSection

      .al
      .xl

      rlUnknown96ECAB ; 96/ECAB

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        phy
        tya
        and #$01FF
        jsl rlUnknown96ECBB
        lda #1,s
        jsr rsUnknown96A477
        ply
        rtl

        .databank 0

        ; 96/ECBB

      rlUnknown96ECBB ; 96/ECBB

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        and #$00FF
        sta wR0
        lda wR0
        asl a
        tax
        jsr ($96ECCC,x)
        ply
        plx
        rtl

        .databank 0

        ; 96/ECCC

    .endsection Unsorted96ECABSection


    .section Unsorted96EDC0Section

      .al
      .xl

      rlUnknown96EDC0 ; 96/EDC0

        ; Reads the stack above its return address, but in the emulator log every
        ; caller continues right after the call: no inline arguments.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        pha
        and #$001F
        pha
        lda #3,s
        lsr a
        lsr a
        lsr a
        lsr a
        lsr a
        sta #3,s
        and #$001F
        clc
        adc #1,s
        sta #1,s
        lda #3,s
        lsr a
        lsr a
        lsr a
        lsr a
        and #$003E
        clc
        adc #1,s
        lsr a
        and #$FFFE
        tax
        lda $96EDF2,x
        sta #3,s
        pla
        pla
        plx
        rtl

        .databank 0

        ; 96/EDF2

    .endsection Unsorted96EDC0Section


    .section Unsorted96EE32Section

      .al
      .xl

      rsUnknown96EE32 ; 96/EE32

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000

        _EE36
        lda $0282,b,x
        lsr a
        and #$3DEF
        sta $7FF636,x
        inc x
        inc x
        cpx #$007E
        bcc _EE36
        plx
        rts

        .databank 0

        ; 96/EE4A

    .endsection Unsorted96EE32Section


    .section Unsorted96EE8ASection

      .al
      .xl

      rlUnknown96EE8A ; 96/EE8A

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$00
        sta $7FEC67
        rep #$20
        rtl

        .databank 0

        ; 96/EE95

    .endsection Unsorted96EE8ASection


    .section Unsorted96EE95Section

      .al
      .xl

      rlUnknown96EE95 ; 96/EE95

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda $7FEC67
        bit #$0080
        beq _EEBA
        and #$000F
        sta wR0
        phb
        php
        phk
        plb
        .databank $96
        lda wR0
        asl a
        tax
        jsr ($96EEBD,x)
        plp
        plb
        .databank $96
        jsl rlUnknown96F28D
        jsl rlUnknown96F275

        _EEBA
        ply
        plx
        rtl

        .databank 0

        ; 96/EEBD

    .endsection Unsorted96EE95Section


    .section Unsorted96F275Section

      .al
      .xl

      rlUnknown96F275 ; 96/F275

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$9500
        sta lR44+1
        lda #$E702
        sta lR44
        lda #$0006
        sta wR40
        jsl rlHDMAEngineCreateEntryByIndex
        plx
        rtl

        .databank 0

        ; 96/F28B

    .endsection Unsorted96F275Section


    .section Unsorted96F28DSection

      .al
      .xl

      rlUnknown96F28D ; 96/F28D

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000
        lda $7FEC6C
        and #$00FF
        beq _F2C5
        dec a
        cmp #$0080
        bcc _F2B7
        pha
        lda #$007F
        sta $7FE506,x
        inc x
        lda #$E51B
        sta $7FE506,x
        inc x
        inc x
        pla
        sec
        sbc #$007F

        _F2B7
        sta $7FE506,x
        inc x
        lda #$E51B
        sta $7FE506,x
        inc x
        inc x

        _F2C5
        lda $7FEC6D
        and #$00FF
        beq _F2F8
        cmp #$0080
        bcc _F2EA
        pha
        lda #$007F
        sta $7FE506,x
        inc x
        lda #$EC6E
        sta $7FE506,x
        inc x
        inc x
        pla
        sec
        sbc #$007F

        _F2EA
        sta $7FE506,x
        inc x
        lda #$EC6E
        sta $7FE506,x
        inc x
        inc x

        _F2F8
        lda #$0001
        sta $7FE506,x
        inc x
        lda #$E51B
        sta $7FE506,x
        inc x
        inc x
        sep #$20
        lda #$00
        sta $7FE506,x
        rep #$20
        plx
        rtl

        .databank 0

        ; 96/F315

    .endsection Unsorted96F28DSection


    .section Unsorted96F315Section

      .al
      .xl

      rlUnknown96F315 ; 96/F315

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda $0AE4,b
        bit #$0080
        beq _F32A
        jsl rlUnknown96F341
        bcs _F32A
        lda #$0034
        jsl rlUnknown96A4B2

        _F32A
        rtl

        .databank 0

        ; 96/F32B

      rlUnknown96F32B ; 96/F32B

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda $0AE4,b
        bit #$0080
        beq _F340
        jsl rlUnknown96F341
        bcs _F340
        lda #$0031
        jsl rlUnknown96A4B2

        _F340
        rtl

        .databank 0

        ; 96/F341

      rlUnknown96F341 ; 96/F341

        .al
        .xl
        .autsiz
        .databank ?

        lda $0AE9,b
        cmp #$0000
        bne _F354
        lda $0D5E,b
        cmp #$01C6
        bne _F354
        sec
        bra _F355


        _F354
        clc

        _F355
        rtl

        .databank 0

        ; 96/F356

      rlUnknown96F356 ; 96/F356

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$00
        sta $7FFC54
        sta $7FFC55
        lda #$00
        sta bBufferTMW
        sta bBufferTSW
        lda bBufferTM
        ora #$12
        sta bBufferTM
        lda bBufferTS
        and #$FF
        ora #$02
        sta bBufferTS
        lda #$02
        sta bBufferCGWSEL
        lda #$00
        sta bBufferCGADSUB
        rep #$20
        lda #$9600
        sta $7FED00
        lda #$F38F
        sta $7FECFF
        rtl

        .databank 0

        ; 96/F38F

      rlUnknown96F38F ; 96/F38F

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7FFC55
        and #$00FF
        beq _F3A4
        sep #$20
        dec a
        sta $7FFC55
        rep #$20
        bra _F3E0


        _F3A4
        lda $7FFC54
        and #$00FF
        tax
        lda $99892A,x
        and #$00FF
        cmp #$00FF
        bne _F3BE
        jsl rlUnknown96C9FE
        bra _F3E0


        _F3BE
        pha
        sep #$20
        and #$7F
        sta $7FFC55
        lda $7FFC54
        inc a
        sta $7FFC54
        rep #$20
        pla
        bit #$0080
        bne _F3DD
        jsr rsUnknown96F3E2
        bra _F3E0


        _F3DD
        jsr rsUnknown96F3FE

        _F3E0
        plx
        rtl

        .databank 0

        ; 96/F3E2

      rsUnknown96F3E2 ; 96/F3E2

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000

        _F3E6
        lda $7FFF82,x
        sta $0282,b,x
        inc x
        inc x
        cpx #$007E
        bcc _F3E6
        sep #$20
        lda #$00
        sta bBufferCGADSUB
        rep #$20
        plx
        rts

        .databank 0

        ; 96/F3FE

      rsUnknown96F3FE ; 96/F3FE

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000

        _F402
        lda $7FF636,x
        sta $0282,b,x
        inc x
        inc x
        cpx #$007E
        bcc _F402
        sep #$20
        lda #$10
        sta bBufferCGADSUB
        rep #$20
        plx
        rts

        .databank 0

        ; 96/F41A

    .endsection Unsorted96F315Section


    .section Unsorted96F558Section

      .al
      .xl

      rlUnknown96F558 ; 96/F558

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda $7E4EA9
        and #$00FF
        cmp #$0002
        bne _F56B
        lda #$0033
        jsl rlUnknown96A4B2

        _F56B
        rtl

        .databank 0

        ; 96/F56C

      rlUnknown96F56C ; 96/F56C

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda $7E4EA9
        and #$00FF
        cmp #$0002
        bne _F57F
        lda #$0035
        jsl rlUnknown96A4B2

        _F57F
        rtl

        .databank 0

        ; 96/F580

    .endsection Unsorted96F558Section


    .section Unsorted96F676Section

      .al
      .xl

      rlUnknown96F676 ; 96/F676

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7E4ECB
        beq _F695
        ldx #$0000

        _F680
        lda $E000BE,x
        sta $0274,b,x
        inc x
        inc x
        cpx #$000A
        bcc _F680
        lda #$003B
        jsl rlUnknown96A4B2

        _F695
        plx
        rtl

        .databank 0

        ; 96/F697

    .endsection Unsorted96F676Section


    .section Unsorted96F697Section

      .al
      .xl

      rlUnknown96F697 ; 96/F697

        .al
        .xl
        .autsiz
        .databank ?

        phy
        inc y
        lda [lR18],y
        and #$00FF
        cmp #$0013
        bne _F6A9
        jsl rlUnknown96F6E0
        bra _F6DE


        _F6A9
        cmp #$0014
        bne _F6B4
        jsl rlUnknown96F6FB
        bra _F6DE


        _F6B4
        cmp #$0015
        bne _F6BF
        jsl rlUnknown96F716
        bra _F6DE


        _F6BF
        cmp #$0016
        bne _F6CA
        jsl rlUnknown96F73F
        bra _F6DE


        _F6CA
        cmp #$0017
        bne _F6D5
        jsl rlUnknown96F762
        bra _F6DE


        _F6D5
        cmp #$0002
        bne _F6DE
        jsl rlUnknown96F785

        _F6DE
        ply
        rtl

        .databank 0

        ; 96/F6E0

      rlUnknown96F6E0 ; 96/F6E0

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000

        _F6E4
        lda $E027C3,x
        sta $0274,b,x
        inc x
        inc x
        cpx #$000A
        bcc _F6E4
        lda #$0036
        jsl rlUnknown96A4B2
        plx
        rtl

        .databank 0

        ; 96/F6FB

      rlUnknown96F6FB ; 96/F6FB

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000

        _F6FF
        lda $E027CD,x
        sta $0274,b,x
        inc x
        inc x
        cpx #$000A
        bcc _F6FF
        lda #$0037
        jsl rlUnknown96A4B2
        plx
        rtl

        .databank 0

        ; 96/F716

      rlUnknown96F716 ; 96/F716

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000

        _F71A
        lda $E027D7,x
        sta $0274,b,x
        inc x
        inc x
        cpx #$000A
        bcc _F71A
        lda #$0038
        jsl rlUnknown96A4B2
        sep #$20
        lda $7FFC5D
        ora #$04
        sta $7FFC5D
        rep #$20
        plx
        rtl

        .databank 0

        ; 96/F73F

      rlUnknown96F73F ; 96/F73F

        .al
        .xl
        .autsiz
        .databank ?

        phx
        sep #$20
        sta $7FFC5F
        rep #$20
        ldx #$0000

        _F74B
        lda $E027E1,x
        sta $02F4,b,x
        inc x
        inc x
        cpx #$000A
        bcc _F74B
        lda #$0039
        jsl rlUnknown96A4B2
        plx
        rtl

        .databank 0

        ; 96/F762

      rlUnknown96F762 ; 96/F762

        .al
        .xl
        .autsiz
        .databank ?

        phx
        sep #$20
        sta $7FFC5F
        rep #$20
        ldx #$0000

        _F76E
        lda $E027EB,x
        sta $02F4,b,x
        inc x
        inc x
        cpx #$000A
        bcc _F76E
        lda #$003A
        jsl rlUnknown96A4B2
        plx
        rtl

        .databank 0

        ; 96/F785

      rlUnknown96F785 ; 96/F785

        .al
        .xl
        .autsiz
        .databank ?

        phx
        sep #$20
        sta $7FFC5F
        rep #$20
        ldx #$0000

        _F791
        lda $E027F5,x
        sta $02F4,b,x
        inc x
        inc x
        cpx #$000A
        bcc _F791
        lda #$003F
        jsl rlUnknown96A4B2
        plx
        rtl

        .databank 0

        ; 96/F7A8

    .endsection Unsorted96F697Section


    .section Unsorted96F7A8Section

      .al
      .xl

      rsUnknown96F7A8 ; 96/F7A8

        .al
        .xl
        .autsiz
        .databank ?

        lda $7E4EA9
        and #$00FF
        cmp #$00FF
        beq _F7BA
        jsl rlUnknown9198B3
        bra _F7BE


        _F7BA
        jsl rlUnknown9198D6

        _F7BE
        rts

        .databank 0

        ; 96/F7BF

      rlUnknown96F7BF ; 96/F7BF

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$00
        sta $7FFC5D
        lda #$FF
        sta $7FFC5E
        sta $7FFC5F
        rep #$20
        rtl

        .databank 0

        ; 96/F7D4

    .endsection Unsorted96F7A8Section


    .section Unsorted96F7D4Section

      .al
      .xl

      rlUnknown96F7D4 ; 96/F7D4

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FFC5D
        bit #$0001
        beq _F7EA
        bit #$0002
        bne _F7E7
        jsr rsUnknown96F7EB
        bra _F7EA


        _F7E7
        jsr rsUnknown96F915

        _F7EA
        rtl

        .databank 0

        ; 96/F7EB

      rsUnknown96F7EB ; 96/F7EB

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda $7FFC69
        and #$00FF
        beq _F801
        sep #$20
        dec a
        sta $7FFC69
        rep #$20
        bra _F859


        _F801
        lda $7FFC65
        sta lR18+1
        lda $7FFC67
        sta lR18
        ldy #$0000
        lda [lR18],y
        cmp #$FFFF
        beq _F841
        sep #$20
        xba
        sta $7FFC69
        xba
        rep #$20
        and #$00FF
        dec a
        asl a
        tax
        lda $98B231,x
        clc
        adc #$B231
        sta $7FFC64
        lda $7FFC67
        clc
        adc #$0002
        sta $7FFC67
        bra _F859


        _F841
        sep #$20
        lda $7FFC5D
        and #$FE
        sta $7FFC5D
        lda #$FF
        sta $7FFC5E
        rep #$20
        jml _F898


        _F859
        lda $7FFC60
        and #$01FF
        sec
        sbc $7FE198
        sta wR0
        lda $7FFC62
        clc
        adc $7FE19A
        and #$00FF
        sta wR1
        lda #$0000
        sta wR5
        sta wR4
        phx
        sep #$20
        phb
        lda $7FFC66
        pha
        plb
        .databank ?
        rep #$20
        lda $7FFC64
        tay
        clc
        jsl rlUnknown95C51F
        sep #$20
        plb
        .databank ?
        rep #$20
        plx

        _F898
        ply
        plx
        rts

        .databank 0

        ; 96/F89B

    .endsection Unsorted96F7D4Section


    .section Unsorted96F915Section

      .al
      .xl

      rsUnknown96F915 ; 96/F915

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7FFC69
        and #$00FF
        asl a
        asl a
        tax
        lda $98B173,x
        cmp #$8080
        beq _F952
        pha
        lda $7FFC6C
        bit #$8000
        beq _F93A
        pla
        eor #$FFFF
        inc a
        bra _F93B


        _F93A
        pla

        _F93B
        sta wR8
        lda $98B175,x
        sta wR9
        sep #$20
        lda $7FFC69
        inc a
        sta $7FFC69
        rep #$20
        bra _F971


        _F952
        sep #$20
        lda $7FFC5D
        and #$FE
        sta $7FFC5D
        lda #$FF
        sta $7FFC5F
        rep #$20
        lda #$0009
        jsl rlUnknown96DB20
        jml _F9BD


        _F971
        lda $7FFC60
        clc
        adc wR8
        and #$01FF
        sec
        sbc $7FE198
        sta wR0
        lda $7FFC62
        clc
        adc $7FE19A
        and #$00FF
        clc
        adc wR9
        sta wR1
        lda #$0000
        sta wR5
        ora #$0100
        sta wR4
        phx
        sep #$20
        phb
        lda $7FFC66
        pha
        plb
        .databank ?
        rep #$20
        lda $7FFC67
        tay
        lda $7FFC6C
        asl a
        jsl rlUnknown95C51F
        sep #$20
        plb
        .databank ?
        rep #$20
        plx

        _F9BD
        plx
        rts

        .databank 0

        ; 96/F9BF

      rlUnknown96F9BF ; 96/F9BF

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7FFC5F
        and #$00FF
        cmp #$00FF
        bne _F9D0
        jml _FA90


        _F9D0
        sep #$20
        lda $7FFC5D
        ora #$03
        sta $7FFC5D
        lda #$00
        sta $7FFC69
        rep #$20
        ldx $0AEB,b
        jsl rlUnknown95B5D0
        pha
        ldx $0AE9,b
        lda $0AF9,b,x
        ldx $0AEB,b
        cmp $0AF9,b,x
        bcs _FA0E
        lda $0AF9,b,x
        sec
        sbc #1,s
        sta $7FFC60
        pla
        lda #$0000
        sta $7FFC6C
        bra _FA20


        _FA0E
        lda $0AF9,b,x
        clc
        adc #1,s
        sta $7FFC60
        pla
        lda #$8000
        sta $7FFC6C

        _FA20
        jsl rlUnknown95B5FD
        pha
        lda $0AFB,b,x
        sec
        sbc $0AFD,b,x
        xba
        sec
        sbc #1,s
        clc
        adc #$0008
        sta $7FFC62
        pla
        lda $7FFC5F
        and #$00FF
        cmp #$0017
        beq _FA5A
        cmp #$0002
        beq _FA6A
        lda #$9800
        sta $7FFC65
        lda #$B2FB
        sta $7FFC67
        bra _FA7D


        _FA5A
        lda #$9800
        sta $7FFC65
        lda #$B32F
        sta $7FFC67
        bra _FA7D


        _FA6A
        lda #$9800
        sta $7FFC65
        lda #$B363
        sta $7FFC67
        jsr rsUnknown96FAB6
        bra _FA90


        _FA7D
        lda #$9700
        sta lR18+1
        lda #$AF21
        sta lR18
        lda #$0000
        sta wR0
        jsl rlUnknown96DB94

        _FA90
        plx
        rtl

        .databank 0

        ; 96/FA92

    .endsection Unsorted96F915Section


    .section Unsorted96FAB6Section

      .al
      .xl

      rsUnknown96FAB6 ; 96/FAB6

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda $0AF9,b,x
        and #$01FF
        sec
        sbc $7FE198
        jsl rlUnknown9EB4BB
        cpx #$0000
        bne _FAD0
        clc
        adc #$2000

        _FAD0
        ora #$006F
        jsl rlUnknown80900D
        ply
        plx
        rts

        .databank 0

        ; 96/FADA

    .endsection Unsorted96FAB6Section


    .section Unsorted96FBF9Section

      .al
      .xl

      rlUnknown96FBF9 ; 96/FBF9

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown96A4FC
        jsl rlUnknown96BD74
        jsl rlUnknown96CB0A
        jsl rlUnknown96DD39
        jsl rlUnknown96EE8A
        jsl rlUnknown96EBC9
        jsl rlUnknown96C99E
        lda #$0003
        jsl rlHDMAEngineFreeEntryByIndex
        lda #$0005
        jsl rlHDMAEngineFreeEntryByIndex
        lda #$0006
        jsl rlHDMAEngineFreeEntryByIndex
        ldx #$0014

        _FC2D
        sep #$20
        lda #$80
        sta $7FFD9A,x
        rep #$20
        txa
        clc
        adc #$000A
        tax
        cpx #$0064
        bcc _FC2D
        lda #$0000
        sta aBGPaletteBuffer,b
        rtl

        .databank 0

        ; 96/FC49

    .endsection Unsorted96FBF9Section


    .section Unsorted96FD54Section

      .al
      .xl

      rlUnknown96FD54 ; 96/FD54

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000

        _FD58
        lda $7FC3F0,x
        sta $01F2,b,x
        lda $7FC1F0,x
        sta $01D2,b,x
        inc x
        inc x
        cpx #$000E
        bcc _FD58
        plx
        rtl

        .databank 0

        ; 96/FD6F

    .endsection Unsorted96FD54Section
