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

        .al
        .xl
        .autsiz
        .databank ?

        lda $0D4B,b
        beq _830C
        lda #$0000
        jsl rlStartBattleSceneScript

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
        jsl rlPlaySoundEffect
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
        jsl rlPlaySoundEffect
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
        jsl rlStartBattleSceneScript
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
        jsl rlStartBattleSceneScript
        bra _86BA


        _86A2
        lda $0AE9,b
        cmp #$0000
        bne _86B3
        lda #$0032
        jsl rlStartBattleSceneScript
        bra _86BA


        _86B3
        lda #$003D
        jsl rlStartBattleSceneScript

        _86BA
        rtl

        .databank 0

        ; 96/86BB

      rlUnknown9686BB ; 96/86BB

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
        jsl rlStartBattleSceneScript
        bra _86E6


        _86DF
        lda #$003D
        jsl rlStartBattleSceneScript

        _86E6
        rtl

        .databank 0

        ; 96/86E7

      rlUnknown9686E7 ; 96/86E7

        .al
        .xl
        .autsiz
        .databank ?

        lda $7E4ECB
        beq _86FB
        lda #$00E0
        jsl rlSendSoundCommand
        lda #$0001
        jsl rlStartBattleSceneScript

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
        lda aUnknownE000B0+12
        sta $0108,b
        ldx #$0000

        _8713
        lda aUnknownE000B0,x
        sta $010A,b,x
        inc x
        inc x
        cpx #$0006
        bcc _8713
        ldx #$0000

        _8724
        lda aUnknown9984C6,x
        sta lR18
        lda aUnknown9984C6+1,x
        sta lR18+1
        ldy #$0000
        lda [lR18],y
        and #$00FF
        xba
        sta $7FED4B
        inc x
        inc x
        inc x
        lda aUnknown9984C6,x
        sta $7FED56
        inc x
        inc x
        lda aUnknown9984C6,x
        sta $7FED53
        inc x
        inc x
        sep #$20
        lda aUnknown9984C6,x
        sta $7FED4D
        inc x
        lda aUnknown9984C6,x
        sta $7FED52
        inc x
        lda aUnknown9984C6,x
        sta $7FED55
        inc x
        rep #$20
        lda aUnknown9984C6,x
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
        sta wMusicID,b
        rtl

        .databank 0

        ; 96/87B3

    .endsection Unsorted9680C2Section


    .section Unsorted96881FSection

      .al
      .xl

      rlUnknown96881F ; 96/881F

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
        jsl rlStartBattleSceneScript

        _883F
        rtl

        .databank 0

        ; 96/8840

      rlUnknown968840 ; 96/8840

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
        jsl rlStartBattleSceneScript

        _888F
        rtl

        .databank 0

        ; 96/8890

      rlUnknown968890 ; 96/8890

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
        jsl rlStartBattleSceneScript

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
        lda aUnknownE000DA,x
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
        lda aUnknownE000B0+6
        sta $2122,b
        lda aUnknownE000B0+7
        sta $2122,b
        lda aUnknownE000B0+8
        sta $2122,b
        lda aUnknownE000B0+9
        sta $2122,b
        lda aUnknownE000B0+10
        sta $2122,b
        lda aUnknownE000B0+11
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
        lda aUnknownE000B0
        sta $2122,b
        lda aUnknownE000B0+1
        sta $2122,b
        lda aUnknownE000B0+2
        sta $2122,b
        lda aUnknownE000B0+3
        sta $2122,b
        lda aUnknownE000B0+4
        sta $2122,b
        lda aUnknownE000B0+5
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
        lda aUnknownE000C8
        sta $2122,b
        lda aUnknownE000C8+1
        sta $2122,b
        lda aUnknownE000C8+2
        sta $2122,b
        lda aUnknownE000C8+3
        sta $2122,b
        lda aUnknownE000C8+4
        sta $2122,b
        lda aUnknownE000C8+5
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
        lda aUnknown998683,x
        cmp #$0080
        bne _8F89
        jsl rlUnknown96C9FE
        jml _9034


        _8F89
        lda aUnknown998683,x
        sta lR18
        lda aUnknown998683+1,x
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
        lda aUnknown998683+3,x
        sta lR18
        lda aUnknown998683+4,x
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
        lda aUnknown998683+6,x
        sta $7E530B
        lda aUnknown998683+8,x
        and #$00FF
        jsl rlUnknown969398
        lda $7E5313
        clc
        adc #$0009
        sta $7E5313
        lda #$0000
        sta $7E5311
        lda #$0023
        jsl rlPlaySoundEffect
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
        lda aUnknown998532,x
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
        lda aUnknown998532,x
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
        lda aUnknown998532+1,x
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
        lda bBattleAnimationY,b,x
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
        lda wBattleAnimationX,b,x
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
        lda aUnknown998586,x
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
        lda aUnknown998586+1,x
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
        lda aUnknown998586+1,x
        sta $7E52F4
        sta $7E52F9
        sta $7E52FE
        sta $7E5303
        sta $7E5308
        rep #$20
        lda aUnknown998586,x

        _9266
        and #$00FF
        bit #$0080
        beq _9271
        ora #$0100

        _9271
        sta $7E52F2
        phx
        pha
        lda aUnknown998586+2,x
        and #$00FF
        asl a
        asl a
        tax
        lda aUnknown99862F,x
        and #$00FF
        clc
        adc #1,s
        sta $7E52F7
        lda aUnknown99862F+1,x
        and #$00FF
        clc
        adc #1,s
        sta $7E52FC
        lda aUnknown99862F+2,x
        and #$00FF
        clc
        adc #1,s
        sta $7E5301
        lda aUnknown99862F+3,x
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
        lda aUnknown9986CD,x
        sta lR18
        lda aUnknown9986CD+1,x
        sta lR18+1
        lda [lR18],y
        and #$00FF
        sta wR0
        xba
        sta $7FED4B
        lda aUnknown9986CD+3,x
        sta lR18
        lda aUnknown9986CD+4,x
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
        lda aUnknown9986CD+6,x
        sta $7FED56
        lda #$2800
        sta $7FED58
        lda aUnknown9986CD+8,x
        sta $7FED53
        sep #$20
        lda aUnknown9986CD+10,x
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
        lda aUnknown998437,x
        sta lR23
        sep #$20
        lda aUnknown998437+2,x
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
        lda aUnknown998440,x
        sta lR23
        sep #$20
        lda aUnknown998440+2,x
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
        lda aUnknown98ABFC,x
        sta $7FE3F1,x
        lda aUnknown98ABFC+2,x
        sta $7FE3F3,x
        lda aUnknown98ABFC+4,x
        sta $7FE3F5,x
        lda aUnknown98ABFC+6,x
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
        lda aUnknown98AC4C,x
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
        sta wMusicID,b
        jsl rlStepMusicScript

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
        jsl rlQueueSoundCommand

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
        jsl rlSendSoundCommand
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
        lda wBattleAnimationX,b
        cmp $0B3C,b
        bcs _9664
        sep #$20
        lda $7FFC9C
        ora #$01
        sta $7FFC9C
        rep #$20
        lda #$01D1
        jsl rlSendSoundCommand
        bra _9664


        _9647
        lda $0B3C,b
        cmp wBattleAnimationX,b
        bcs _9664
        sep #$20
        lda $7FFC9C
        and #$FE
        sta $7FFC9C
        rep #$20
        lda #$00D1
        jsl rlSendSoundCommand

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
        jsr (aUnknown9696A0,x)
        plx

        _969D
        ply
        plx
        rtl

        .databank 0

        ; 96/96A0

    .endsection Unsorted969665Section


    .section Table9696A0Section

      .al
      .xl

      aUnknown9696A0 ; 96/96A0

        ; Jump table of rlUnknown969665.
        .word <>rsUnknown9696E6
        .word <>rsUnknown969707
        .word <>rsUnknown969727
        .word <>rsUnknown969735
        .word <>rsUnknown969765

    .endsection Table9696A0Section


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
        lda aUnknown9982E3,x
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
        lda aBattleCharacterPieces+52,x
        bra _96D5


        _96D1
        lda aBattleCharacterPieces+53,x

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


    .section Unsorted9696E6Section

      .al
      .xl

      rsUnknown9696E6 ; 96/96E6

        .al
        .xl
        .autsiz
        .databank ?

        tyx
        sep #$20
        lda $0AF5,b,x
        ora #$40
        sta $0AF5,b,x
        rep #$20
        lda #$0100
        sta wBattleAnimationX,b
        lda #$00FF
        sta $0B3C,b
        lda #$0080
        sta $7FE198
        rts

        .databank 0

        ; 96/9707

    .endsection Unsorted9696E6Section


    .section Unsorted969707Section

      .al
      .xl

      rsUnknown969707 ; 96/9707

        .al
        .xl
        .autsiz
        .databank ?

        tyx
        lda #$0100
        sta wBattleAnimationX,b
        lda #$00FF
        sta $0B3C,b
        lda #$0080
        sta $7FE198
        lda $7FFC59
        ora #$0008
        sta $7FFC59
        rts

        .databank 0

        ; 96/9727

    .endsection Unsorted969707Section


    .section Unsorted969727Section

      .al
      .xl

      rsUnknown969727 ; 96/9727

        .al
        .xl
        .autsiz
        .databank ?

        tyx
        sep #$20
        lda $0AF5,b,x
        ora #$40
        sta $0AF5,b,x
        rep #$20
        rts

        .databank 0

        ; 96/9735

    .endsection Unsorted969727Section


    .section Unsorted969735Section

      .al
      .xl

      rsUnknown969735 ; 96/9735

        .al
        .xl
        .autsiz
        .databank ?

        tyx
        sep #$20
        lda $0AF5,b,x
        ora #$40
        sta $0AF5,b,x
        rep #$20
        lda #$0100
        sta wBattleAnimationX,b
        sta $0B3C,b
        lda #$0000
        sta bBattleAnimationY,b
        sta $0B41,b
        lda #$7000
        sta $0AFB,b
        sta $0B3E,b
        lda #$0080
        sta $7FE198
        rts

        .databank 0

        ; 96/9765

    .endsection Unsorted969735Section


    .section Unsorted969765Section

      .al
      .xl

      rsUnknown969765 ; 96/9765

        .al
        .xl
        .autsiz
        .databank ?

        rts

        .databank 0

        ; 96/9766

    .endsection Unsorted969765Section


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
        jsl rlPlaySoundEffect
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
        adc aUnknown969BE3,x
        cmp #$0400
        bcc _9BC5
        lda #$03E0

        _9BC5
        ora #1,s
        sta #1,s
        lda #3,s
        and #$7C00
        clc
        adc aUnknown969C23,x
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


    .section Data969BE3Section

      .al
      .xl

      aUnknown969BE3 ; 96/9BE3

        ; Read by rlUnknown969B9C, rlUnknown969C63.

        .word $0000, $0020, $0040, $0060, $0080, $00A0, $00C0, $00E0
        .word $0100, $0120, $0140, $0160, $0180, $01A0, $01C0, $01E0
        .word $0200, $0220, $0240, $0260, $0280, $02A0, $02C0, $02E0
        .word $0300, $0320, $0340, $0360, $0380, $03A0, $03C0, $03E0

        ; 96/9C23

      aUnknown969C23 ; 96/9C23

        ; Read by rlUnknown969B9C, rlUnknown969C63.

        .word $0000, $0400, $0800, $0C00, $1000, $1400, $1800, $1C00
        .word $2000, $2400, $2800, $2C00, $3000, $3400, $3800, $3C00
        .word $4000, $4400, $4800, $4C00, $5000, $5400, $5800, $5C00
        .word $6000, $6400, $6800, $6C00, $7000, $7400, $7800, $7C00

        ; 96/9C63

    .endsection Data969BE3Section


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
        sbc aUnknown969BE3,x
        bcs _9C86
        lda #$0000

        _9C86
        ora #1,s
        sta #1,s
        lda #3,s
        and #$7C00
        sec
        sbc aUnknown969C23,x
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
        lda wBattleAnimationX,b,x
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
        jsl rlPlaySoundEffect2
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
        lda aUnknown98B388,x
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
        lda aUnknown98B388,x
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
        lda aUnknown998F0F,x
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
        lda aUnknown998F0F+1,x
        clc
        adc #$7F
        sta $7FFC74
        lda aUnknown998F0F+1,x
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

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FFC59
        bit #$0400
        beq _A21E
        lda #$004C
        jsl rlStartBattleSceneScript

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

      rlResetBattleSceneScript ; 96/A26F

        .al
        .xl
        .autsiz
        .databank ?

        ; Stops the script and clears its wait count and timer.

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
        lda wBattleAnimationXFixed,b,y
        sta aUnit2DataBuffer._ROM.StrengthGrowth,x
        lda wBattleAnimationX,b,y
        sta $7FEC1F,x
        lda $0AFB,b,y
        sta $7FEC21,x
        lda wBattleAnimationYFixed,b,y
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
        lda wBattleAnimationXFixed,b,y
        sta aUnit2DataBuffer._ROM.StrengthGrowth,x
        lda wBattleAnimationX,b,y
        sta $7FEC1F,x
        lda $0AFB,b,y
        sta $7FEC21,x
        lda wBattleAnimationYFixed,b,y
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
        lda wBattleAnimationXFixed,b,y
        sta aUnit2DataBuffer._ROM.StrengthGrowth,x
        lda wBattleAnimationX,b,y
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
        lda wBattleAnimationXFixed,b,y
        sta aUnit2DataBuffer._ROM.StrengthGrowth,x
        lda wBattleAnimationX,b,y
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
        lda wBattleAnimationXFixed,b,y
        sta aUnit2DataBuffer._ROM.StrengthGrowth,x
        lda wBattleAnimationX,b,y
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
        lda wBattleAnimationXFixed,b,y
        sta aUnit2DataBuffer._ROM.StrengthGrowth,x
        lda wBattleAnimationX,b,y
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
        lda aUnknown9AA30A,x
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
        lda aUnknown9AA30A,x
        clc
        adc #1,s
        dec a
        tax
        lda aUnknown9AA30A,x
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
        jsl rlBattleAnimationGetSpeed
        sta wR0
        pla
        sta wR1
        jsl rlBattleAnimationCompareCombatantX
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
        jsl rlBattleAnimationGetJumpArc
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
        cmp wBattleAnimationX,b,x
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
        cmp wBattleAnimationX,b,x
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
        lda bBattleAnimationY,b,x
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
        jsl rlBattleAnimationGetSpeed
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
        lda aUnknown97EA9A+2,x
        and #$00FF
        sta wR8
        ldx $0AEB,b
        lda wBattleAnimationX,b,x
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
        jsl rlBattleAnimationGetTravelFrames
        sta wR0
        lda wR2
        jsl rlBattleAnimationGetSpeed
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

      rlBattleSceneScriptClearLoading ; 96/B93A

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


    .section Unsorted96BCECSection

      .al
      .xl

      rlUnknown96BCEC ; 96/BCEC

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlStartBattleSceneScript
        rtl

        .databank 0

        ; 96/BCF1

    .endsection Unsorted96BCECSection


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

      rlBattleSceneCommandHDMAEffect ; 96/BD93

        .al
        .xl
        .autsiz
        .databank ?

        ; Command 3: arg 0-7 stops HDMA effect slot arg; arg 8 and up starts effect
        ; arg-8 from the offset table at $97/BD3E in a free slot of eight ($7FED03),
        ; waiting while none is free.

        phx
        phy
        tya
        and #$01FF
        cmp #$0008
        bcs _BDA4
        jsl rlBattleSceneStopHDMAEffect
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
        jsr rsBattleSceneScriptNextCommand

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
        lda aUnknown97C462,x
        cmp #$8001
        bne _C035
        lda #$0000
        jsl rlUnknown96C975
        bra _C04D


        _C035
        cmp #$8000
        bne _C05C
        lda #$0000
        jsl rlBattleSceneStopHDMAEffect
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
        lda aUnknown998000,x
        tay
        pla
        cpy #$0000
        beq _C901
        asl a
        asl a
        tax
        lda aUnknown998000+2,x
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

      rlBattleSceneStopHDMAEffect ; 96/C942

        .al
        .xl
        .autsiz
        .databank ?

        ; A = slot: frees it and its HDMA entry (A + 5).

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


    .section Unsorted96C9D9Section

      .al
      .xl

      rlBattleSceneCommandSetRoutine ; 96/C9D9

        .al
        .xl
        .autsiz
        .databank ?

        ; Command 8: sets routine arg from the table at $97/BDD4 as the one
        ; rlBattleSceneScriptRunRoutine runs every frame.

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
        lda aUnknown97BDD4+1,x
        sta $7FED00
        lda aUnknown97BDD4,x
        sta $7FECFF
        pla
        pha
        jsr rsBattleSceneScriptNextCommand
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

      rlBattleSceneCommandCallRoutine ; 96/CA1C

        .al
        .xl
        .autsiz
        .databank ?

        ; Command 4: calls routine arg from the table at $97/BDD4 (72 long pointers).

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
        lda aUnknown97BDD4,x
        sta lR23
        sep #$20
        lda aUnknown97BDD4+2,x
        sta lR23+2
        pha
        plb
        .databank ?
        rep #$20
        jml [lR23]


        _CA4E
        pla
        pha
        jsr rsBattleSceneScriptNextCommandNoWait
        ply
        plx
        rtl

        .databank 0

        ; 96/CA56

      rlBattleSceneCommandCallRoutineUntilDone ; 96/CA56

        .al
        .xl
        .autsiz
        .databank ?

        ; Command 5: calls routine arg from the table at $97/BDD4 every frame until it
        ; clears bit 0 of $7FE4B7.

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
        lda aUnknown97BDD4,x
        sta lR23
        sep #$20
        lda aUnknown97BDD4+2,x
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
        jsr rsBattleSceneScriptNextCommandNoWait

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
        lda wBattleAnimationXFixed,b,x
        sta aUnit2DataBuffer._ROM.StrengthGrowth
        lda wBattleAnimationX,b,x
        sta $7FEC1F
        lda $0AFB,b,x
        sta $7FEC21
        lda wBattleAnimationYFixed,b,x
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
        lda wBattleAnimationXFixed,b,x
        sta aUnit2DataBuffer._ROM.StrengthGrowth
        lda wBattleAnimationX,b,x
        sta $7FEC1F
        lda $0AFB,b,x
        sta $7FEC21
        lda wBattleAnimationYFixed,b,x
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
        jsr (aUnknown96D6DD,x)
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


    .section Table96D6DDSection

      .al
      .xl

      aUnknown96D6DD ; 96/D6DD

        ; Jump table of rlUnknown96D695.
        .word <>rsUnknown96D6F7
        .word <>rsUnknown96D774
        .word <>rsUnknown96D808
        .word <>rsUnknown96D89F
        .word <>rsUnknown96D8D7
        .word <>rsUnknown96D912
        .word <>rsUnknown96D938
        .word <>rsUnknown96D95E
        .word <>rsUnknown96D990
        .word <>rsUnknown96D9B4
        .word <>rsUnknown96D9D8
        .word <>rsUnknown96DA0F
        .word <>rsUnknown96DA34

    .endsection Table96D6DDSection


    .section Unsorted96D6F7Section

      .al
      .xl

      rsUnknown96D6F7 ; 96/D6F7

        .al
        .xl
        .autsiz
        .databank ?

        phx
        tyx
        lda $7FFD9C,x
        sta lR18+1
        lda $7FFD9E,x
        sta lR18

        _D705
        ldy #$0000
        lda [lR18],y
        and #$00FF
        cmp #$00FF
        beq _D721
        cmp #$00FE
        beq _D726
        bit #$0080
        beq _D733
        and #$007F
        bra _D730


        _D721
        jsr rsUnknown96DB36
        bra _D772


        _D726
        lda $7FFD9B,x
        sta $7FFD9E,x
        bra _D705


        _D730
        inc y
        bra _D737


        _D733
        lda $7FFDA2,x

        _D737
        sep #$20
        sta $7FFDA3,x
        sta $7FFDA2,x
        rep #$20
        lda $7FFDA1,x
        and #$00FF
        sta wR0
        phx
        lda $7FFDA0,x
        and #$00FF
        asl a
        tax
        lda wR0

        _D758
        pha
        lda [lR18],y
        xba
        sta aBGPaletteBuffer,b,x
        inc x
        inc x
        inc y
        inc y
        pla
        dec a
        bne _D758
        plx
        tya
        clc
        adc $7FFD9E,x
        sta $7FFD9E,x

        _D772
        plx
        rts

        .databank 0

        ; 96/D774

    .endsection Unsorted96D6F7Section


    .section Unsorted96D774Section

      .al
      .xl

      rsUnknown96D774 ; 96/D774

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


    .section Unsorted96D89FSection

      .al
      .xl

      rsUnknown96D89F ; 96/D89F

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
        dec a
        pha
        lda $7FFDA0,x
        and #$00FF
        asl a
        tax
        ply
        lda @l aBGPaletteBuffer,x
        pha

        _D8C4
        lda @l $000102,x
        sta @l aBGPaletteBuffer,x
        inc x
        inc x
        dec y
        bne _D8C4
        pla
        sta @l aBGPaletteBuffer,x
        rts

        .databank 0

        ; 96/D8D7

    .endsection Unsorted96D89FSection


    .section Unsorted96D8D7Section

      .al
      .xl

      rsUnknown96D8D7 ; 96/D8D7

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
        dec a
        pha
        lda $7FFDA0,x
        and #$00FF
        clc
        adc #1,s
        asl a
        tax
        ply
        lda @l aBGPaletteBuffer,x
        pha

        _D8FF
        lda @l wJoy2RepeatTimer,x
        sta @l aBGPaletteBuffer,x
        dec x
        dec x
        dec y
        bne _D8FF
        pla
        sta @l aBGPaletteBuffer,x
        rts

        .databank 0

        ; 96/D912

    .endsection Unsorted96D8D7Section


    .section Unsorted96D912Section

      .al
      .xl

      rsUnknown96D912 ; 96/D912

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


    .section Unsorted96D938Section

      .al
      .xl

      rsUnknown96D938 ; 96/D938

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
        jsl rlUnknown959E22
        bcc _D95D
        jsr rsUnknown96DB36

        _D95D
        rts

        .databank 0

        ; 96/D95E

    .endsection Unsorted96D938Section


    .section Unsorted96D95ESection

      .al
      .xl

      rsUnknown96D95E ; 96/D95E

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


    .section Unsorted96D990Section

      .al
      .xl

      rsUnknown96D990 ; 96/D990

        .al
        .xl
        .autsiz
        .databank ?

        tyx
        phx
        lda $7FFDA1,x
        and #$00FF
        tay
        lda $7FFDA0,x
        and #$00FF
        asl a
        tax
        lda #$0000

        _D9A6
        sta @l aBGPaletteBuffer,x
        inc x
        inc x
        dec y
        bne _D9A6
        plx
        jsr rsUnknown96DB36
        rts

        .databank 0

        ; 96/D9B4

    .endsection Unsorted96D990Section


    .section Unsorted96D9B4Section

      .al
      .xl

      rsUnknown96D9B4 ; 96/D9B4

        .al
        .xl
        .autsiz
        .databank ?

        tyx
        phx
        lda $7FFDA1,x
        and #$00FF
        tay
        lda $7FFDA0,x
        and #$00FF
        asl a
        tax
        lda #$7FFF

        _D9CA
        sta @l aBGPaletteBuffer,x
        inc x
        inc x
        dec y
        bne _D9CA
        plx
        jsr rsUnknown96DB36
        rts

        .databank 0

        ; 96/D9D8

    .endsection Unsorted96D9B4Section


    .section Unsorted96D9D8Section

      .al
      .xl

      rsUnknown96D9D8 ; 96/D9D8

        .al
        .xl
        .autsiz
        .databank ?

        tyx
        phx
        lda $7FFD9B,x
        sta lR18
        lda $7FFD9C,x
        sta lR18+1
        lda $7FFDA1,x
        and #$00FF
        pha
        lda $7FFDA0,x
        and #$00FF
        asl a
        tax
        pla
        ldy #$0000

        _D9FB
        pha
        lda [lR18],y
        sta @l aBGPaletteBuffer,x
        inc x
        inc x
        inc y
        inc y
        pla
        dec a
        bne _D9FB
        plx
        jsr rsUnknown96DB36
        rts

        .databank 0

        ; 96/DA0F

    .endsection Unsorted96D9D8Section


    .section Unsorted96DA0FSection

      .al
      .xl

      rsUnknown96DA0F ; 96/DA0F

        .al
        .xl
        .autsiz
        .databank ?

        tyx
        phx
        lda $7FFDA1,x
        and #$00FF
        tay
        lda $7FFDA0,x
        and #$00FF
        asl a
        tax

        _DA22
        lda $7FFE00,x
        sta @l aBGPaletteBuffer,x
        inc x
        inc x
        dec y
        bne _DA22
        plx
        jsr rsUnknown96DB36
        rts

        .databank 0

        ; 96/DA34

    .endsection Unsorted96DA0FSection


    .section Unsorted96DA34Section

      .al
      .xl

      rsUnknown96DA34 ; 96/DA34

        .al
        .xl
        .autsiz
        .databank ?

        tyx
        phx
        lda $7FFDA1,x
        and #$00FF
        dec a
        bne _DA4B
        lda $7FFDA0,x
        and #$00FF
        asl a
        tax
        bra _DA63


        _DA4B
        pha
        lda $7FFDA0,x
        and #$00FF
        asl a
        tax
        ply

        _DA56
        lda @l $000102,x
        sta @l aBGPaletteBuffer,x
        inc x
        inc x
        dec y
        bne _DA56

        _DA63
        phx
        lda #3,s
        tax

        _DA67
        lda $7FFD9C,x
        sta lR18+1
        lda $7FFD9E,x
        sta lR18
        ldy #$0000
        lda [lR18],y
        and #$00FF
        cmp #$00FF
        beq _DA8F
        cmp #$00FE
        beq _DA96
        bit #$0080
        beq _DAA3
        and #$007F
        bra _DAA0


        _DA8F
        jsr rsUnknown96DB36
        plx
        plx
        bra _DACA


        _DA96
        lda $7FFD9B,x
        sta $7FFD9E,x
        bra _DA67


        _DAA0
        inc y
        bra _DAA7


        _DAA3
        lda $7FFDA2,x

        _DAA7
        sep #$20
        sta $7FFDA3,x
        sta $7FFDA2,x
        rep #$20
        plx
        lda [lR18],y
        xba
        jsr rsUnknown96DACB
        sta aBGPaletteBuffer,b,x
        inc y
        inc y
        plx
        tya
        clc
        adc $7FFD9E,x
        sta $7FFD9E,x

        _DACA
        rts

        .databank 0

        ; 96/DACB

    .endsection Unsorted96DA34Section


    .section Unsorted96DACBSection

      .al
      .xl

      rsUnknown96DACB ; 96/DACB

        ; TRACE: stack-args
        .al
        .xl
        .autsiz
        .databank ?

        phx
        pha
        and #$7C00
        pha
        lda #3,s
        and #$03E0
        pha
        lda #5,s
        and #$001F
        pha
        lda $7FFDFE
        asl a
        tax
        lda aUnknown98B133,x
        clc
        adc #1,s
        cmp #$0020
        bcc _DAF2
        lda #$001F

        _DAF2
        sta #7,s
        lda aUnknown98B0F3,x
        clc
        adc #3,s
        cmp #$0400
        bcc _DB03
        lda #$03E0

        _DB03
        ora #7,s
        sta #7,s
        lda aUnknown98B0B3,x
        clc
        adc #5,s
        cmp #$8000
        bcc _DB16
        lda #$7C00

        _DB16
        ora #7,s
        sta #7,s
        pla
        pla
        pla
        pla
        plx
        rts

        .databank 0

        ; 96/DB20

    .endsection Unsorted96DACBSection


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
        lda aUnknown99832D,x
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
        lda aUnknown99832D+1,x
        bra _DCC0


        _DCBC
        lda aUnknown99832D+2,x

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
        jsr (aUnknown96DEAA,x)
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


    .section Table96DEAASection

      .al
      .xl

      aUnknown96DEAA ; 96/DEAA

        ; Jump table of rlUnknown96DE6F.
        .word <>rsUnknown96E6D7
        .word <>rsUnknown96E712
        .word <>rsUnknown96E716
        .word <>rsUnknown96E751
        .word <>rsUnknown96E798
        .word <>rlUnknown96E803
        .word <>rsUnknown96E8E1
        .word <>rsUnknown96E716
        .word <>rsUnknown96E91C
        .word <>rsUnknown96E92F
        .word <>rsUnknown96E716

    .endsection Table96DEAASection


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


    .section Unsorted96DFC7Section

      .al
      .xl

      rsUnknown96DFC7 ; 96/DFC7

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
        lda wBattleAnimationX,b,x
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

        ; 96/E01F

    .endsection Unsorted96DFC7Section


    .section Unsorted96E01FSection

      .al
      .xl

      rsUnknown96E01F ; 96/E01F

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
        lda wBattleAnimationX,b,x
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


    .section Unsorted96E077Section

      .al
      .xl

      rsUnknown96E077 ; 96/E077

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
        lda wBattleAnimationX,b,x
        clc
        adc #$0100
        clc
        adc #$0080
        plx
        sta $7FE477,x
        phx
        lda #$0000
        sta $7FE479,x
        ldx $0AE9,b
        jsl rlUnknown95B5FD
        clc
        adc #$0018
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

        ; 96/E0CF

    .endsection Unsorted96E077Section


    .section Unsorted96E0CFSection

      .al
      .xl

      rsUnknown96E0CF ; 96/E0CF

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
        lda wBattleAnimationX,b,x
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
        clc
        adc #$0018
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

        ; 96/E127

    .endsection Unsorted96E0CFSection


    .section Unsorted96E127Section

      .al
      .xl

      rsUnknown96E127 ; 96/E127

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
        ldx $0AEB,b
        lda wBattleAnimationX,b,x
        clc
        adc #$0100
        clc
        adc #$0080
        plx
        sta $7FE477,x
        phx
        lda #$0000
        sta $7FE479,x
        ldx $0AEB,b
        jsl rlUnknown95B5FD
        sec
        sbc #$0008
        pha
        lda #$0064
        sec
        sbc #1,s
        sta #1,s
        pla
        plx
        sta $7FE47A,x
        plx
        rts

        .databank 0

        ; 96/E17B

    .endsection Unsorted96E127Section


    .section Unsorted96E17BSection

      .al
      .xl

      rsUnknown96E17B ; 96/E17B

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
        ldx $0AEB,b
        lda wBattleAnimationX,b,x
        clc
        adc #$0100
        clc
        adc #$0100
        plx
        sta $7FE477,x
        phx
        lda #$0000
        sta $7FE479,x
        ldx $0AEB,b
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

        ; 96/E1D3

    .endsection Unsorted96E17BSection


    .section Unsorted96E1D3Section

      .al
      .xl

      rsUnknown96E1D3 ; 96/E1D3

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
        ora #$40
        sta $7FE475,x
        rep #$20
        lda #$0000
        sta $7FE476,x
        lda #$0100
        sta $7FE477,x
        lda #$0000
        sta $7FE479,x
        lda #$0048
        clc
        adc #$0080
        sta $7FE47A,x
        plx
        rts

        .databank 0

        ; 96/E20A

    .endsection Unsorted96E1D3Section


    .section Unsorted96E20ASection

      .al
      .xl

      rsUnknown96E20A ; 96/E20A

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
        ora #$40
        sta $7FE475,x
        rep #$20
        lda #$0000
        sta $7FE476,x
        lda #$0100
        clc
        adc #$0080
        sta $7FE477,x
        lda #$0000
        sta $7FE479,x
        lda #$0048
        clc
        adc #$0080
        sta $7FE47A,x
        plx
        rts

        .databank 0

        ; 96/E245

    .endsection Unsorted96E20ASection


    .section Unsorted96E245Section

      .al
      .xl

      rsUnknown96E245 ; 96/E245

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
        ora #$40
        sta $7FE475,x
        rep #$20
        lda #$0000
        sta $7FE476,x
        lda #$0100
        sta $7FE477,x
        lda #$0000
        sta $7FE479,x
        sta $7FE47A,x
        plx
        rts

        .databank 0

        ; 96/E275

    .endsection Unsorted96E245Section


    .section Unsorted96E275Section

      .al
      .xl

      rsUnknown96E275 ; 96/E275

        .al
        .xl
        .autsiz
        .databank ?

        phx
        tyx
        jsl rlUnknown96EA7A
        jsr rsUnknown96DFBB
        sep #$20
        lda $7FE475,x
        and #$7F
        ora #$40
        sta $7FE475,x
        rep #$20
        phx
        lda #$0000
        sta $7FE476,x
        ldx $0AEB,b
        lda wBattleAnimationX,b,x
        sec
        sbc $7FE198
        clc
        adc #$0100
        clc
        adc #$0030
        plx
        sta $7FE477,x
        phx
        lda #$0000
        sta $7FE479,x
        ldx $0AEB,b
        sec
        sbc #$0008
        pha
        lda #$0064
        sec
        sbc #1,s
        sta #1,s
        pla
        plx
        sta $7FE47A,x
        plx
        rts

        .databank 0

        ; 96/E2CE

    .endsection Unsorted96E275Section


    .section Unsorted96E2CESection

      .al
      .xl

      rsUnknown96E2CE ; 96/E2CE

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
        ldx $0AEB,b
        lda wBattleAnimationX,b,x
        clc
        adc #$0100
        clc
        adc #$0100
        plx
        sta $7FE477,x
        lda #$0000
        sta $7FE479,x
        lda #$0064
        clc
        adc #$0080
        sta $7FE47A,x
        plx
        rts

        .databank 0

        ; 96/E312

    .endsection Unsorted96E2CESection


    .section Unsorted96E312Section

      .al
      .xl

      rsUnknown96E312 ; 96/E312

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
        lda wBattleAnimationX,b,x
        clc
        adc #$0100
        clc
        adc #$0100
        plx
        sta $7FE477,x
        lda #$0000
        sta $7FE479,x
        lda #$0064
        clc
        adc #$0088
        sta $7FE47A,x
        plx
        rts

        .databank 0

        ; 96/E356

    .endsection Unsorted96E312Section


    .section Unsorted96E356Section

      .al
      .xl

      rsUnknown96E356 ; 96/E356

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
        ora #$40
        sta $7FE475,x
        rep #$20
        lda #$0000
        sta $7FE476,x
        lda #$0100
        sta $7FE477,x
        lda #$0000
        sta $7FE479,x
        lda #$0048
        clc
        adc #$00F0
        sta $7FE47A,x
        plx
        rts

        .databank 0

        ; 96/E38D

    .endsection Unsorted96E356Section


    .section Unsorted96E38DSection

      .al
      .xl

      rsUnknown96E38D ; 96/E38D

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
        ora #$40
        sta $7FE475,x
        rep #$20
        lda $7FE197
        sta $7FE476,x
        lda $7FE198
        sta $7FE477,x
        lda #$0000
        sta $7FE479,x
        lda $7FE19A
        sec
        sbc #$0080
        and #$00FF
        sta $7FE47A,x
        plx
        rts

        .databank 0

        ; 96/E3CA

    .endsection Unsorted96E38DSection


    .section Unsorted96E3CASection

      .al
      .xl

      rsUnknown96E3CA ; 96/E3CA

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        tyx
        sep #$20
        lda $7FE475,x
        and #$7F
        sta $7FE475,x
        rep #$20
        lda #$FFFF
        sta $7FE471
        ply
        plx
        rts

        .databank 0

        ; 96/E3E5

    .endsection Unsorted96E3CASection


    .section Unsorted96E3E5Section

      .al
      .xl

      rsUnknown96E3E5 ; 96/E3E5

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
        ldx $0AEB,b
        lda wBattleAnimationX,b,x
        clc
        adc #$0100
        clc
        adc #$0100
        plx
        sta $7FE477,x
        lda #$0000
        sta $7FE479,x
        lda #$0064
        clc
        adc #$0080
        clc
        adc #$000A
        sta $7FE47A,x
        plx
        rts

        .databank 0

        ; 96/E42D

    .endsection Unsorted96E3E5Section


    .section Unsorted96E42DSection

      .al
      .xl

      rsUnknown96E42D ; 96/E42D

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        tyx
        sep #$20
        lda $7FE475,x
        and #$7F
        ora #$40
        sta $7FE475,x
        rep #$20
        ldy #$0002
        lda #$0000
        sta $7FE476,x
        lda [lR18],y
        sta $7FE477,x
        ldy #$0004
        lda #$0000
        sta $7FE479,x
        lda [lR18],y
        sta $7FE47A,x
        ply
        plx
        rts

        .databank 0

        ; 96/E463

    .endsection Unsorted96E42DSection


    .section Unsorted96E463Section

      .al
      .xl

      rsUnknown96E463 ; 96/E463

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
        ldx $0AE9,b
        lda wBattleAnimationX,b,x
        sta wR0
        lda bBattleAnimationY,b,x
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

        ; 96/E49C

    .endsection Unsorted96E463Section


    .section Unsorted96E49CSection

      .al
      .xl

      rsUnknown96E49C ; 96/E49C

        .al
        .xl
        .autsiz
        .databank ?

        rts

        .databank 0

        ; 96/E49D

    .endsection Unsorted96E49CSection


    .section Unsorted96E49DSection

      .al
      .xl

      rsUnknown96E49D ; 96/E49D

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
        lda wBattleAnimationX,b,x
        sta wR0
        jsl rlUnknown95B5FD
        sec
        sbc #$0008
        clc
        adc bBattleAnimationY,b,x
        and #$00FF
        sta wR1
        plx
        ldy #$0002
        lda [lR18],y
        and #$00FF
        jsl rlUnknown96E654
        ply
        plx
        rts

        .databank 0

        ; 96/E4D8

    .endsection Unsorted96E49DSection


    .section Unsorted96E4D8Section

      .al
      .xl

      rsUnknown96E4D8 ; 96/E4D8

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
        lda wBattleAnimationX,b,x
        sta wR0
        lda bBattleAnimationY,b,x
        and #$00FF
        sec
        sbc #$0010
        sta wR1
        plx
        ldy #$0002
        lda [lR18],y
        and #$00FF
        jsl rlUnknown96E654
        ply
        plx
        rts

        .databank 0

        ; 96/E50E

    .endsection Unsorted96E4D8Section


    .section Unsorted96E50ESection

      .al
      .xl

      rsUnknown96E50E ; 96/E50E

        .al
        .xl
        .autsiz
        .databank ?

        rts

        .databank 0

        ; 96/E50F

    .endsection Unsorted96E50ESection


    .section Unsorted96E50FSection

      .al
      .xl

      rsUnknown96E50F ; 96/E50F

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
        lda wBattleAnimationX,b,x
        sta wR0
        jsl rlUnknown95B5FD
        sec
        sbc #$0008
        clc
        adc bBattleAnimationY,b,x
        and #$00FF
        sta wR1
        plx
        ldy #$0002
        lda [lR18],y
        and #$00FF
        jsl rlUnknown96E654
        inc y
        lda [lR18],y
        sta $7FE483,x
        inc y
        lda [lR18],y
        sta $7FE484,x
        ply
        plx
        rts

        .databank 0

        ; 96/E558

    .endsection Unsorted96E50FSection


    .section Unsorted96E558Section

      .al
      .xl

      rsUnknown96E558 ; 96/E558

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        tyx
        sep #$20
        lda $7FE475,x
        and #$7F
        sta $7FE475,x
        lda #$00
        sta $7FE482,x
        rep #$20
        ldy #$0002
        lda [lR18],y
        sta $7FE483,x
        inc y
        lda [lR18],y
        sta $7FE484,x
        lda #$0000
        sta $7FE473
        txa
        sta $7FE471
        ply
        plx
        rts

        .databank 0

        ; 96/E58E

    .endsection Unsorted96E558Section


    .section Unsorted96E58ESection

      .al
      .xl

      rsUnknown96E58E ; 96/E58E

        ; TRACE: stack-args
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        tyx
        sep #$20
        lda $7FE475,x
        ora #$80
        ora #$40
        sta $7FE475,x
        rep #$20
        ldy #$0002
        lda [lR18],y
        phx
        pha
        ldx $0AE9,b
        lda $0B24,b,x
        bit #$8000
        beq _E5BB
        lda #1,s
        eor #$FFFF
        inc a
        sta #1,s

        _E5BB
        pla
        plx
        and #$00FF
        xba
        sta $7FE47C,x
        inc y
        lda [lR18],y
        and #$00FF
        xba
        sta $7FE47E,x
        inc y
        lda [lR18],y
        sta $7FE480,x
        ply
        plx
        rts

        .databank 0

        ; 96/E5DA

    .endsection Unsorted96E58ESection


    .section Unsorted96E5DASection

      .al
      .xl

      rsUnknown96E5DA ; 96/E5DA

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        jsr rsUnknown96E58E
        lda $7FE476
        sta $7FE4B4
        lda $7FE477
        clc
        adc #$0060
        sta $7FE4B5
        ply
        plx
        rts

        .databank 0

        ; 96/E5F6

    .endsection Unsorted96E5DASection


    .section Unsorted96E5F6Section

      .al
      .xl

      rsUnknown96E5F6 ; 96/E5F6

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        jsr rsUnknown96E58E
        lda $7FE476
        sta $7FE4B4
        lda $7FE477
        clc
        adc #$0060
        sta $7FE4B5
        ply
        plx
        rts

        .databank 0

        ; 96/E612

    .endsection Unsorted96E5F6Section


    .section Unsorted96E612Section

      .al
      .xl

      rsUnknown96E612 ; 96/E612

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
        lda wBattleAnimationX,b,x
        sta wR0
        jsl rlUnknown95B5FD
        sec
        sbc #$0008
        clc
        adc bBattleAnimationY,b,x
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


    .section Unsorted96E6D7Section

      .al
      .xl

      rsUnknown96E6D7 ; 96/E6D7

        .al
        .xl
        .autsiz
        .databank ?

        phx
        tyx
        jsl rlUnknown96E9B8
        lda $7FE480,x
        bne _E70B
        sep #$20
        lda $7FE475,x
        and #$7F
        sta $7FE475,x
        rep #$20
        lda $7FE475,x
        bit #$0020
        beq _E709
        sep #$20
        lda $7FE4B8
        beq _E703
        dec a

        _E703
        sta $7FE4B8
        rep #$20

        _E709
        bra _E710


        _E70B
        dec a
        sta $7FE480,x

        _E710
        plx
        rts

        .databank 0

        ; 96/E712

    .endsection Unsorted96E6D7Section


    .section Unsorted96E712Section

      .al
      .xl

      rsUnknown96E712 ; 96/E712

        .al
        .xl
        .autsiz
        .databank ?

        phx
        tyx
        plx
        rts

        .databank 0

        ; 96/E716

    .endsection Unsorted96E712Section


    .section Unsorted96E716Section

      .al
      .xl

      rsUnknown96E716 ; 96/E716

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


    .section Unsorted96E798Section

      .al
      .xl

      rsUnknown96E798 ; 96/E798

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        tyx
        jsl rlUnknown96E9B8
        lda $7FE483,x
        sta lR18
        lda $7FE484,x
        sta lR18+1
        ldy #$0000
        lda [lR18],y
        and #$00FF
        cmp #$0080
        beq _E7CD
        bit #$0080
        beq _E7C0
        ora #$FF00

        _E7C0
        sta $7FE488,x
        lda $7FE483,x
        inc a
        sta $7FE483,x

        _E7CD
        lda $7FE480,x
        bne _E7FB
        sep #$20
        lda $7FE475,x
        and #$7F
        sta $7FE475,x
        rep #$20
        lda $7FE475,x
        bit #$0020
        beq _E7F9
        sep #$20
        lda $7FE4B8
        beq _E7F3
        dec a

        _E7F3
        sta $7FE4B8
        rep #$20

        _E7F9
        bra _E800


        _E7FB
        dec a
        sta $7FE480,x

        _E800
        ply
        plx
        rts

        .databank 0

        ; 96/E803

    .endsection Unsorted96E798Section


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


    .section Unsorted96E8E1Section

      .al
      .xl

      rsUnknown96E8E1 ; 96/E8E1

        .al
        .xl
        .autsiz
        .databank ?

        phx
        tyx
        jsl rlUnknown96E9B8
        lda $7FE480,x
        bne _E915
        sep #$20
        lda $7FE475,x
        and #$7F
        sta $7FE475,x
        rep #$20
        lda $7FE475,x
        bit #$0020
        beq _E913
        sep #$20
        lda $7FE4B8
        beq _E90D
        dec a

        _E90D
        sta $7FE4B8
        rep #$20

        _E913
        bra _E91A


        _E915
        dec a
        sta $7FE480,x

        _E91A
        plx
        rts

        .databank 0

        ; 96/E91C

    .endsection Unsorted96E8E1Section


    .section Unsorted96E91CSection

      .al
      .xl

      rsUnknown96E91C ; 96/E91C

        .al
        .xl
        .autsiz
        .databank ?

        phx
        tyx
        jsr rsUnknown96E936
        lda $7FE47E
        clc
        adc #$0010
        sta $7FE47E
        plx
        rts

        .databank 0

        ; 96/E92F

    .endsection Unsorted96E91CSection


    .section Unsorted96E92FSection

      .al
      .xl

      rsUnknown96E92F ; 96/E92F

        .al
        .xl
        .autsiz
        .databank ?

        phx
        tyx
        jsr rsUnknown96E936
        plx
        rts

        .databank 0

        ; 96/E936

    .endsection Unsorted96E92FSection


    .section Unsorted96E936Section

      .al
      .xl

      rsUnknown96E936 ; 96/E936

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7FE4B4
        pha
        lda $7FE4B5
        pha
        lda $7FE476
        pha
        lda $7FE477
        sta $7FE4B5
        pla
        sta $7FE4B4
        pla
        sta $7FE477
        pla
        sta $7FE476
        lda $7FE47C
        eor #$FFFF
        inc a
        sta $7FE47C
        sep #$20
        lda bBufferBG1SC
        eor #$08
        sta bBufferBG1SC
        lda bBufferCGADSUB
        eor #$10
        sta bBufferCGADSUB
        lda bBufferW12SEL
        eor #$08
        sta bBufferW12SEL
        rep #$20
        jsl rlUnknown96E9B8
        lda $7FE480,x
        bne _E9B1
        sep #$20
        lda $7FE475,x
        and #$7F
        sta $7FE475,x
        rep #$20
        lda $7FE475,x
        bit #$0020
        beq _E9AF
        sep #$20
        lda $7FE4B8
        beq _E9A9
        dec a

        _E9A9
        sta $7FE4B8
        rep #$20

        _E9AF
        bra _E9B6


        _E9B1
        dec a
        sta $7FE480,x

        _E9B6
        plx
        rts

        .databank 0

        ; 96/E9B8

    .endsection Unsorted96E936Section


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


    .section Unsorted96EA7ASection

      .al
      .xl

      rlUnknown96EA7A ; 96/EA7A

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7FE471
        cmp #$FFFF
        beq _EA97
        tax
        lda #$FFFF
        sta $7FE471
        lda #$0000
        sta $7FE486,x
        sta $7FE486,x

        _EA97
        plx
        rtl

        .databank 0

        ; 96/EA99

    .endsection Unsorted96EA7ASection


    .section Unsorted96EA99Section

      .al
      .xl

      rlBattleSceneCommandScrollToCombatant ; 96/EA99

        .al
        .xl
        .autsiz
        .databank ?

        ; Command 15: scrolls the camera to the acting combatant ($0AE9) or its opponent
        ; ($0AEB), by entry arg of the offset table at $97/C2A0.

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
        lda wBattleAnimationX,b,x
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
        jsr rsBattleSceneScriptNextCommand
        bra _EAFF


        _EAFC
        jsr rsBattleSceneScriptNextCommandNoWait

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
        jsl rlBattleSceneStopBG2Shake
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


    .section Unsorted96ECDCSection

      .al
      .xl

      rsUnknown96ECDC ; 96/ECDC

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000

        _ECE0
        lda $0162,b,x
        pha
        lsr a
        and #$3DE0
        pha
        lda #3,s
        and #$001F
        clc
        adc #$0010
        cmp #$0020
        bcc _ECFA
        lda #$001F

        _ECFA
        ora #1,s
        sta $7FF636,x
        pla
        pla
        inc x
        inc x
        cpx #$005E
        bcc _ECE0
        plx
        rts

        .databank 0

        ; 96/ED0B

    .endsection Unsorted96ECDCSection


    .section Unsorted96ED0BSection

      .al
      .xl

      rsUnknown96ED0B ; 96/ED0B

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000

        _ED0F
        lda $0162,b,x
        lsr a
        and #$3DEF
        sta $7FF636,x
        inc x
        inc x
        cpx #$005E
        bcc _ED0F
        plx
        rts

        .databank 0

        ; 96/ED23

    .endsection Unsorted96ED0BSection


    .section Unsorted96ED23Section

      .al
      .xl

      rsUnknown96ED23 ; 96/ED23

        ; TRACE: stack-args
        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000

        _ED27
        lda $7FFE62,x
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
        phx
        tax
        lda aUnknown96ED67,x
        plx
        sta $7FF636,x
        pla
        pla
        inc x
        inc x
        cpx #$005E
        bcc _ED27
        plx
        rts

        .databank 0

        ; 96/ED67

    .endsection Unsorted96ED23Section


    .section Data96ED67Section

      .al
      .xl

      aUnknown96ED67 ; 96/ED67

        ; Read by rsUnknown96ED23.

        .word $0000, $0401, $0802, $0C03, $1004, $1405, $1806, $1C07
        .word $2008, $2409, $280A, $2C0B, $300C, $340D, $380E, $3C0F
        .word $4010, $4411, $4812, $4C13, $5014, $5415, $5816, $5C17
        .word $6018, $6419, $681A, $6C1B, $701C, $741D, $781E, $7C1F

        ; 96/EDA7

    .endsection Data96ED67Section


    .section Unsorted96EDA7Section

      .al
      .xl

      rsUnknown96EDA7 ; 96/EDA7

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000

        _EDAB
        lda $7FFE62,x
        jsl rlUnknown96EDC0
        sta $7FF636,x
        inc x
        inc x
        cpx #$005E
        bcc _EDAB
        plx
        rts

        .databank 0

        ; 96/EDC0

    .endsection Unsorted96EDA7Section


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
        lda aUnknown96EDF2,x
        sta #3,s
        pla
        pla
        plx
        rtl

        .databank 0

        ; 96/EDF2

    .endsection Unsorted96EDC0Section


    .section Data96EDF2Section

      .al
      .xl

      aUnknown96EDF2 ; 96/EDF2

        ; Read by rlUnknown96EDC0.

        .word $0000, $0421, $0842, $0C63, $1084, $14A5, $18C6, $1CE7
        .word $2108, $2529, $294A, $2D6B, $318C, $35AD, $39CE, $3DEF
        .word $4210, $4631, $4A52, $4E73, $5294, $56B5, $5AD6, $5EF7
        .word $6318, $6739, $6B5A, $6F7B, $739C, $77BD, $7BDE, $7FFF

        ; 96/EE32

    .endsection Data96EDF2Section


    .section Unsorted96EE32Section

      .al
      .xl

      rsUnknown96EE32 ; 96/EE32

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


    .section Unsorted96EE4ASection

      .al
      .xl

      rsUnknown96EE4A ; 96/EE4A

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000
        lda #$7C00

        _EE51
        sta $7FF636,x
        inc x
        inc x
        cpx #$003E
        bcc _EE51
        plx
        rts

        .databank 0

        ; 96/EE5E

    .endsection Unsorted96EE4ASection


    .section Unsorted96EE5ESection

      .al
      .xl

      rsUnknown96EE5E ; 96/EE5E

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000
        lda #$7C00

        _EE65
        sta $0162,b,x
        inc x
        inc x
        cpx #$005E
        bcc _EE65
        plx
        rts

        .databank 0

        ; 96/EE71

    .endsection Unsorted96EE5ESection


    .section Unsorted96EE71Section

      .al
      .xl

      rsUnknown96EE71 ; 96/EE71

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000

        _EE75
        lda $0162,b,x
        lsr a
        lsr a
        and #$1CE7
        sta $7FF636,x
        inc x
        inc x
        cpx #$005E
        bcc _EE75
        plx
        rts

        .databank 0

        ; 96/EE8A

    .endsection Unsorted96EE71Section


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
        jsr (aUnknown96EEBD,x)
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


    .section Table96EEBDSection

      .al
      .xl

      aUnknown96EEBD ; 96/EEBD

        ; Jump table of rlUnknown96EE95.
        .word <>rsUnknown96EEC5
        .word <>rsUnknown96EEC6
        .word <>rsUnknown96EFC3
        .word <>rsUnknown96F0C4

    .endsection Table96EEBDSection


    .section Unsorted96EEC5Section

      .al
      .xl

      rsUnknown96EEC5 ; 96/EEC5

        .al
        .xl
        .autsiz
        .databank ?

        rts

        .databank 0

        ; 96/EEC6

    .endsection Unsorted96EEC5Section


    .section Unsorted96EEC6Section

      .al
      .xl

      rsUnknown96EEC6 ; 96/EEC6

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FEC6A
        clc
        adc $7FEC6B
        and #$00FF
        sta wR2
        lda $7FE4A1
        and #$03FF
        sec
        sbc $7FE198
        sec
        sbc #$0080
        sta wR0
        lda $7FEC68
        and #$00FF
        pha
        lda wR0
        sec
        sbc #1,s
        sta #1,s
        pla
        cmp #$0200
        bcc _EEFF
        jml _EFA6


        _EEFF
        cmp #$0100
        bcs _EF07
        lda #$0100

        _EF07
        sec
        sbc #$0100
        sep #$20
        sta $7FEC6E
        rep #$20
        lda $7FEC69
        and #$00FF
        clc
        adc wR0
        cmp #$0100
        bcs _EF26
        jml _EFA6


        _EF26
        cmp #$0200
        bcc _EF2E
        lda #$01FF

        _EF2E
        sec
        sbc #$0100
        sep #$20
        sta $7FEC6F
        rep #$20
        lda $7FEC65
        clc
        adc $7FEC66
        and #$00FF
        sta wR1
        lda $7FE4A4
        sta wR0
        lda $7FEC6A
        and #$00FF
        pha
        lda wR0
        sec
        sbc #1,s
        bcs _EF69
        pha
        lda wR2
        sec
        sbc #1,s
        sta wR2
        pla
        lda #$0000

        _EF69
        sta #1,s
        pla
        cmp wR1
        bcs _EFA6
        sep #$20
        sta $7FEC6C
        rep #$20
        lda $7FEC6C
        and #$00FF
        clc
        adc wR2
        cmp wR1
        bcc _EF9A
        beq _EF9A
        lda $7FEC6C
        and #$00FF
        pha
        lda wR1
        sec
        sbc #1,s
        sta #1,s
        pla
        bra _EF9C


        _EF9A
        lda wR2

        _EF9C
        sep #$20
        sta $7FEC6D
        rep #$20
        bra _EFC2


        _EFA6
        sep #$20
        lda #$FF
        sta $7FEC6E
        lda #$00
        sta $7FEC6F
        lda #$00
        sta $7FEC6C
        lda #$00
        sta $7FEC6D
        rep #$20

        _EFC2
        rts

        .databank 0

        ; 96/EFC3

    .endsection Unsorted96EEC6Section


    .section Unsorted96EFC3Section

      .al
      .xl

      rsUnknown96EFC3 ; 96/EFC3

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FEC6A
        clc
        adc $7FEC6B
        and #$00FF
        sta wR2
        lda $7FE4A1
        and #$03FF
        sec
        sbc $7FE198
        sec
        sbc #$0100
        sta wR0
        lda $7FEC68
        and #$00FF
        pha
        lda wR0
        sec
        sbc #1,s
        sta #1,s
        pla
        cmp #$0200
        bcc _EFFC
        jml _F0A7


        _EFFC
        cmp #$0100
        bcs _F004
        lda #$0100

        _F004
        sec
        sbc #$0100
        sep #$20
        sta $7FEC6E
        rep #$20
        lda $7FEC69
        and #$00FF
        clc
        adc wR0
        cmp #$0100
        bcs _F023
        jml _F0A7


        _F023
        cmp #$0200
        bcc _F02B
        lda #$01FF

        _F02B
        sec
        sbc #$0100
        sep #$20
        sta $7FEC6F
        rep #$20
        lda $7FEC65
        clc
        adc $7FEC66
        and #$00FF
        sta wR1
        lda $7FE4A4
        sec
        sbc #$0080
        sta wR0
        lda $7FEC6A
        and #$00FF
        pha
        lda wR0
        sec
        sbc #1,s
        bcs _F06A
        pha
        lda wR2
        sec
        sbc #1,s
        sta wR2
        pla
        lda #$0000

        _F06A
        sta #1,s
        pla
        cmp wR1
        bcs _F0A7
        sep #$20
        sta $7FEC6C
        rep #$20
        lda $7FEC6C
        and #$00FF
        clc
        adc wR2
        cmp wR1
        bcc _F09B
        beq _F09B
        lda $7FEC6C
        and #$00FF
        pha
        lda wR1
        sec
        sbc #1,s
        sta #1,s
        pla
        bra _F09D


        _F09B
        lda wR2

        _F09D
        sep #$20
        sta $7FEC6D
        rep #$20
        bra _F0C3


        _F0A7
        sep #$20
        lda #$FF
        sta $7FEC6E
        lda #$00
        sta $7FEC6F
        lda #$00
        sta $7FEC6C
        lda #$00
        sta $7FEC6D
        rep #$20

        _F0C3
        rts

        .databank 0

        ; 96/F0C4

    .endsection Unsorted96EFC3Section


    .section Unsorted96F0C4Section

      .al
      .xl

      rsUnknown96F0C4 ; 96/F0C4

        .al
        .xl
        .autsiz
        .databank ?

        lda #$EC6A
        clc
        adc #$EC6B
        and #$00FF
        sta wR2
        lda $7FE477
        and #$03FF
        sec
        sbc #$0100
        sec
        sbc #$0080
        sta wR0
        lda $7FEC68
        and #$00FF
        pha
        lda wR0
        sec
        sbc #1,s
        sta #1,s
        pla
        cmp #$0200
        bcc _F0FA
        jml _F1A5


        _F0FA
        cmp #$0100
        bcs _F102
        lda #$0100

        _F102
        sec
        sbc #$0100
        sep #$20
        sta $7FEC6E
        rep #$20
        lda $7FEC69
        and #$00FF
        clc
        adc wR0
        cmp #$0100
        bcs _F121
        jml _F1A5


        _F121
        cmp #$0200
        bcc _F129
        lda #$01FF

        _F129
        sec
        sbc #$0100
        sep #$20
        sta $7FEC6F
        rep #$20
        lda $7FEC65
        clc
        adc $7FEC66
        and #$00FF
        sta wR1
        lda $7FE47A
        sec
        sbc #$0080
        sta wR0
        lda $7FEC6A
        and #$00FF
        pha
        lda wR0
        sec
        sbc #1,s
        bcs _F168
        pha
        lda wR2
        sec
        sbc #1,s
        sta wR2
        pla
        lda #$0000

        _F168
        sta #1,s
        pla
        cmp wR1
        bcs _F1A5
        sep #$20
        sta $7FEC6C
        rep #$20
        lda $7FEC6C
        and #$00FF
        clc
        adc wR2
        cmp wR1
        bcc _F199
        beq _F199
        lda $7FEC6C
        and #$00FF
        pha
        lda wR1
        sec
        sbc #1,s
        sta #1,s
        pla
        bra _F19B


        _F199
        lda wR2

        _F19B
        sep #$20
        sta $7FEC6D
        rep #$20
        bra _F1C1


        _F1A5
        sep #$20
        lda #$FF
        sta $7FEC6E
        lda #$00
        sta $7FEC6F
        lda #$00
        sta $7FEC6C
        lda #$00
        sta $7FEC6D
        rep #$20

        _F1C1
        rts

        .databank 0

        ; 96/F1C2

    .endsection Unsorted96F0C4Section


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
        jsl rlStartBattleSceneScript

        _F32A
        rtl

        .databank 0

        ; 96/F32B

      rlUnknown96F32B ; 96/F32B

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
        jsl rlStartBattleSceneScript

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
        lda aUnknown99892A,x
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

        .al
        .xl
        .autsiz
        .databank ?

        lda $7E4EA9
        and #$00FF
        cmp #$0002
        bne _F56B
        lda #$0033
        jsl rlStartBattleSceneScript

        _F56B
        rtl

        .databank 0

        ; 96/F56C

      rlUnknown96F56C ; 96/F56C

        .al
        .xl
        .autsiz
        .databank ?

        lda $7E4EA9
        and #$00FF
        cmp #$0002
        bne _F57F
        lda #$0035
        jsl rlStartBattleSceneScript

        _F57F
        rtl

        .databank 0

        ; 96/F580

    .endsection Unsorted96F558Section


    .section Unsorted96F676Section

      .al
      .xl

      rlUnknown96F676 ; 96/F676

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7E4ECB
        beq _F695
        ldx #$0000

        _F680
        lda aUnknownE000B0+14,x
        sta $0274,b,x
        inc x
        inc x
        cpx #$000A
        bcc _F680
        lda #$003B
        jsl rlStartBattleSceneScript

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
        lda aUnknownE027C3,x
        sta $0274,b,x
        inc x
        inc x
        cpx #$000A
        bcc _F6E4
        lda #$0036
        jsl rlStartBattleSceneScript
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
        lda aUnknownE027CD,x
        sta $0274,b,x
        inc x
        inc x
        cpx #$000A
        bcc _F6FF
        lda #$0037
        jsl rlStartBattleSceneScript
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
        lda aUnknownE027D7,x
        sta $0274,b,x
        inc x
        inc x
        cpx #$000A
        bcc _F71A
        lda #$0038
        jsl rlStartBattleSceneScript
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
        lda aUnknownE027E1,x
        sta $02F4,b,x
        inc x
        inc x
        cpx #$000A
        bcc _F74B
        lda #$0039
        jsl rlStartBattleSceneScript
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
        lda aUnknownE027EB,x
        sta $02F4,b,x
        inc x
        inc x
        cpx #$000A
        bcc _F76E
        lda #$003A
        jsl rlStartBattleSceneScript
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
        lda aUnknownE027F5,x
        sta $02F4,b,x
        inc x
        inc x
        cpx #$000A
        bcc _F791
        lda #$003F
        jsl rlStartBattleSceneScript
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
        lda aUnknown98B231,x
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
        lda aUnknown98B173,x
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
        lda aUnknown98B173+2,x
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
        jsl rlBattleAnimationGetBodyWidth
        pha
        ldx $0AE9,b
        lda wBattleAnimationX,b,x
        ldx $0AEB,b
        cmp wBattleAnimationX,b,x
        bcs _FA0E
        lda wBattleAnimationX,b,x
        sec
        sbc #1,s
        sta $7FFC60
        pla
        lda #$0000
        sta $7FFC6C
        bra _FA20


        _FA0E
        lda wBattleAnimationX,b,x
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
        sbc wBattleAnimationYFixed,b,x
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
        jsl rlBattleSceneStartPaletteEffect

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
        lda wBattleAnimationX,b,x
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
        jsl rlPlaySoundEffect2
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


    .section Data97BDD4Section

      .al
      .xl

      aUnknown97BDD4 ; 97/BDD4

        ; Read by rlBattleSceneCommandCallRoutine, rlBattleSceneCommandCallRoutineUntilDone, rlBattleSceneCommandSetRoutine.

        .byte $D9, $85, $96, $60, $83, $96, $FC, $86, $96, $C8, $8D, $96, $22, $8E, $96, $A7
        .byte $CA, $96, $00, $8E, $96, $4C, $8E, $96, $E1, $8D, $96, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $0D, $83, $96, $50, $8F, $96, $C8, $DC, $96
        .byte $63, $91, $96, $73, $97, $96, $9F, $97, $96, $8F, $8E, $96, $E9, $8E, $96, $C7
        .byte $8E, $96, $13, $8F, $96, $A8, $8E, $96, $8C, $E0, $95, $BA, $88, $96, $E4, $88
        .byte $96, $0E, $89, $96, $0D, $E8, $95, $88, $E8, $95, $C9, $E8, $95, $B3, $E7, $95
        .byte $CB, $E7, $95, $EC, $E7, $95, $AD, $CA, $96, $77, $E8, $95, $56, $F3, $96, $1A
        .byte $F4, $96, $CB, $97, $96, $31, $F4, $96, $48, $F4, $96, $5F, $F4, $96, $12, $F5
        .byte $96, $2C, $F5, $96, $45, $8F, $96, $43, $F5, $96, $4F, $F5, $96, $A3, $F4, $96
        .byte $80, $F5, $96, $D7, $F5, $96, $1F, $F6, $96, $35, $F6, $96, $9B, $F8, $96, $DA
        .byte $FA, $96, $F9, $FB, $96, $EA, $97, $96, $DB, $FC, $96, $39, $FB, $96, $54, $FD
        .byte $96, $2C, $80, $97, $24, $80, $97, $8D, $87, $96, $49, $FC, $96, $99, $FB, $96
        .byte $C8, $9F, $96, $5C, $A0, $96, $03, $96, $96, $17, $96, $96, $8D, $B0, $96, $13
        .byte $FD, $96, $60, $A1, $96, $81, $FC, $96

        ; 97/BEAC

    .endsection Data97BDD4Section


    .section Data98B388Section

      .al
      .xl

      aUnknown98B388 ; 98/B388

        ; Read by rlUnknown969D01.

        .word $0000, $000A, $0015, $0020, $002A, $0035, $0040, $004A
        .word $0055, $0060, $006A, $0075, $0080, $008A, $0095, $00A0
        .word $00AA, $00B5, $00C0, $00CA, $00D5, $00E0, $00EA, $00F5
        .word $0100

        ; 98/B3BA

      aUnknown98B3BA ; 98/B3BA

        ; Read by rsUnknown959CF8.

        .word $5574, $55E0, $564C, $56B8, $5724, $5790, $57FC, $5868
        .word $58D4, $5940, $59AC, $5A18, $5A84, $5AF0, $5B5C, $5BC8
        .word $5C34, $5CA0, $5D0C, $5D78, $5DE4, $5E50, $5EBC, $5F28
        .word $5F94

        ; 98/B3EC

      aUnknown98B3EC ; 98/B3EC

        ; Read by rsUnknown959CF8.

        .word $B574, $B5E0, $B64C, $B6B8, $B724, $B790, $B7FC, $B868
        .word $B8D4, $B940, $B9AC, $BA18, <>aBattleAnimationSequencesWarMageSword, $BAF0, $BB5C, $BBC8
        .word $BC34, $BCA0, $BD0C, $BD78, $BDE4, $BE50, $BEBC, $BF28
        .word $BF94

        ; 98/B41E

    .endsection Data98B388Section


    .section Data9982E3Section

      .al
      .xl

      aUnknown9982E3 ; 99/82E3

        ; Read by rlUnknown9696AA.

        .word $0409, $0B04, $0404, $040C, $0F04, $0404, $0410, $1104
        .word $0404, $0412, $1304, $0404, $003A, $3B00, $0000, $003C
        .word $3D00, $0000, $0042, $4700, $0000, $004C, $5200, $0000
        .word $FF5B, $5C00, $0101, $025F, $6102, $00FF, $0262, $6302
        .word $00FF, $FF64, $6500, $00FF, $FFFF

        ; 99/832D

      aUnknown99832D ; 99/832D

        ; Read by rlUnknown96DC7C.

        .word $4109, $0B41, $3C3C, $420C, $0F42, $0202, $1210, $1112
        .word $0707, $0C12, $130C, $1111, $023E, $3F02, $0303, $0440
        .word $4104, $0505, $0642, $4306, $0707, $0844, $4508, $0909
        .word $0A46, $470A, $0B0B, $0C48, $490C, $0D0D, $0E4A, $4B0E
        .word $0F0F, $104C, $4D10, $1111, $124E, $4F12, $1313, $1450
        .word $5114, $1515, $1652, $5316, $1717, $1854, $5818, $1919
        .word $1A59, $5A1A, $1B1B, $455B, $5C1C, $1D1D, $1E5D, $5E1E
        .word $1F1F, $205F, $6020, $2121, $2261, $6246, $2323, $4763
        .word $6424, $4825, $2665, $6649, $2727, $FFFF

        ; 99/83B9

      aItemAnimationCategories ; 99/83B9

        ; Read by rlUnknown95A1ED. One byte per item ID plus 1 (entry 0 is for no
        ; item): the high nibble is the weapon category of the battle animation
        ; lookup (AnimCategory...), the low nibble is not read yet.

        .byte (AnimCategoryAny << 4) | 0  ; no item
        .byte (AnimCategorySword << 4) | 0  ; IronSword
        .byte (AnimCategorySword << 4) | 0  ; SteelSword
        .byte (AnimCategorySword << 4) | 0  ; SilverSword
        .byte (AnimCategorySword << 4) | 0  ; IronBlade
        .byte (AnimCategorySword << 4) | 0  ; SteelBlade
        .byte (AnimCategorySword << 4) | 0  ; SilverBlade
        .byte (AnimCategorySword << 4) | 0  ; MiracleSword
        .byte (AnimCategorySword << 4) | 0  ; ThiefSword
        .byte (AnimCategorySword << 4) | 0  ; BarrierBlade
        .byte (AnimCategorySword << 4) | 0  ; BerserkSword
        .byte (AnimCategorySword << 4) | 0  ; BraveSword
        .byte (AnimCategorySword << 4) | 0  ; SilenceSword
        .byte (AnimCategorySword << 4) | 0  ; SleepSword
        .byte (AnimCategorySword << 4) | 0  ; SlimSword
        .byte (AnimCategorySword << 4) | 0  ; Safeguard
        .byte (AnimCategorySword << 4) | 0  ; FireSword
        .byte (AnimCategorySword << 4) | 0  ; EarthSword
        .byte (AnimCategorySword << 4) | 0  ; ThunderSword
        .byte (AnimCategorySword << 4) | 0  ; WindSword
        .byte (AnimCategorySword << 4) | 0  ; LightBrand
        .byte (AnimCategorySword << 4) | 0  ; Mystletainn
        .byte (AnimCategorySword << 4) | 0  ; Tyrfing
        .byte (AnimCategorySword << 4) | 0  ; Balmung
        .byte (AnimCategorySword << 4) | 0  ; Armorslayer
        .byte (AnimCategorySword << 4) | 0  ; Wingclipper
        .byte (AnimCategorySword << 4) | 0  ; BrokenSwordA
        .byte (AnimCategorySword << 4) | 0  ; BrokenSwordB
        .byte (AnimCategorySword << 4) | 0  ; BrokenSwordC
        .byte (AnimCategoryLance << 4) | 2  ; IronLance
        .byte (AnimCategoryLance << 4) | 2  ; SteelLance
        .byte (AnimCategoryLance << 4) | 2  ; SilverLance
        .byte (AnimCategoryRangedLance << 4) | 2  ; Javelin
        .byte (AnimCategoryLance << 4) | 2  ; Ridersbane
        .byte (AnimCategoryLance << 4) | 2  ; BraveLance
        .byte (AnimCategoryLance << 4) | 2  ; SlimLance
        .byte (AnimCategoryLance << 4) | 2  ; Gungnir
        .byte (AnimCategoryLance << 4) | 2  ; GaeBolg
        .byte (AnimCategoryLance << 4) | 2  ; BrokenLanceA
        .byte (AnimCategoryLance << 4) | 2  ; BrokenLanceB
        .byte (AnimCategoryLance << 4) | 2  ; BrokenLanceC
        .byte (AnimCategoryAxe << 4) | 3  ; IronAxe
        .byte (AnimCategoryAxe << 4) | 3  ; SteelAxe
        .byte (AnimCategoryAxe << 4) | 3  ; SilverAxe
        .byte (AnimCategoryAxe << 4) | 3  ; BraveAxe
        .byte (AnimCategoryRangedAxe << 4) | 3  ; Helswath
        .byte (AnimCategoryRangedAxe << 4) | 3  ; HandAxe
        .byte (AnimCategoryAxe << 4) | 3  ; BrokenAxeA
        .byte (AnimCategoryAxe << 4) | 3  ; BrokenAxeB
        .byte (AnimCategoryAxe << 4) | 3  ; BrokenAxeC
        .byte (AnimCategoryBow << 4) | 4  ; IronBow
        .byte (AnimCategoryBow << 4) | 4  ; SteelBow
        .byte (AnimCategoryBow << 4) | 4  ; SilverBow
        .byte (AnimCategoryBow << 4) | 4  ; BraveBow
        .byte (AnimCategoryBow << 4) | 4  ; KillerBow
        .byte (AnimCategoryBow << 4) | 4  ; Yewfelle
        .byte (AnimCategoryBow << 4) | 4  ; BrokenBowA
        .byte (AnimCategoryBow << 4) | 4  ; BrokenBowB
        .byte (AnimCategoryBow << 4) | 4  ; BrokenBowC
        .byte (AnimCategoryBow << 4) | 4  ; Ballista
        .byte (AnimCategoryBow << 4) | 4  ; IronBallista
        .byte (AnimCategoryBow << 4) | 4  ; KillerBallista
        .byte (AnimCategoryBow << 4) | 4  ; GreatBallista
        .byte (AnimCategoryMagic << 4) | 5  ; Fire
        .byte (AnimCategoryMagic << 4) | 5  ; Elfire
        .byte (AnimCategoryMagic << 4) | 5  ; Bolganone
        .byte (AnimCategoryMagic << 4) | 5  ; Valflame
        .byte (AnimCategoryMagic << 4) | 5  ; Meteor
        .byte (AnimCategoryMagic << 4) | 5  ; Thunder
        .byte (AnimCategoryMagic << 4) | 5  ; Elthunder
        .byte (AnimCategoryMagic << 4) | 5  ; Thoron
        .byte (AnimCategoryMagic << 4) | 5  ; Mjolnir
        .byte (AnimCategoryMagic << 4) | 5  ; Bolting
        .byte (AnimCategoryMagic << 4) | 5  ; Wind
        .byte (AnimCategoryMagic << 4) | 5  ; Elwind
        .byte (AnimCategoryMagic << 4) | 5  ; Tornado
        .byte (AnimCategoryMagic << 4) | 5  ; Forseti
        .byte (AnimCategoryMagic << 4) | 5  ; Blizzard
        .byte (AnimCategoryMagic << 4) | 5  ; Light
        .byte (AnimCategoryMagic << 4) | 5  ; Nosferatu
        .byte (AnimCategoryMagic << 4) | 5  ; Aura
        .byte (AnimCategoryMagic << 4) | 5  ; Naga
        .byte (AnimCategoryMagic << 4) | 5  ; Jormungandr
        .byte (AnimCategoryMagic << 4) | 5  ; Fenrir
        .byte (AnimCategoryMagic << 4) | 5  ; Hel
        .byte (AnimCategoryMagic << 4) | 5  ; Loptous
        .byte (AnimCategoryMagic << 4) | 5  ; BrokenFireTomeA
        .byte (AnimCategoryMagic << 4) | 5  ; BrokenFireTomeB
        .byte (AnimCategoryMagic << 4) | 5  ; BrokenFireTomeC
        .byte (AnimCategoryStaff << 4) | 6  ; HealStaff
        .byte (AnimCategoryStaff << 4) | 6  ; MendStaff
        .byte (AnimCategoryStaff << 4) | 6  ; RecoverStaff
        .byte (AnimCategoryStaff << 4) | 6  ; PhysicStaff
        .byte (AnimCategoryStaff << 4) | 6  ; Fortify
        .byte (AnimCategoryStaff << 4) | 6  ; ReturnStaff
        .byte (AnimCategoryStaff << 4) | 6  ; WarpStaff
        .byte (AnimCategoryStaff << 4) | 6  ; RescueStaff
        .byte (AnimCategoryStaff << 4) | 6  ; CharmStaff
        .byte (AnimCategoryStaff << 4) | 6  ; RestoreStaff
        .byte (AnimCategoryStaff << 4) | 6  ; ValkyrieStaff
        .byte (AnimCategoryStaff << 4) | 6  ; SilenceStaff
        .byte (AnimCategoryStaff << 4) | 6  ; SleepStaff
        .byte (AnimCategoryStaff << 4) | 6  ; BerserkStaff
        .byte (AnimCategoryStaff << 4) | 6  ; ThiefStaff
        .byte (AnimCategoryStaff << 4) | 6  ; BrokenStaffA
        .byte (AnimCategoryStaff << 4) | 6  ; BrokenStaffB
        .byte (AnimCategoryStaff << 4) | 6  ; BrokenStaffC
        .byte (AnimCategoryAny << 4) | 0  ; RenewalBand
        .byte (AnimCategoryAny << 4) | 0  ; ParagonBand
        .byte (AnimCategoryAny << 4) | 0  ; ThiefBand
        .byte (AnimCategoryAny << 4) | 0  ; MiracleBand
        .byte (AnimCategoryAny << 4) | 0  ; PursuitRing
        .byte (AnimCategoryAny << 4) | 0  ; RecoverRing
        .byte (AnimCategoryAny << 4) | 0  ; BargainBand
        .byte (AnimCategoryAny << 4) | 0  ; KnightRing
        .byte (AnimCategoryAny << 4) | 0  ; ReturnBand
        .byte (AnimCategoryAny << 4) | 0  ; SpeedRing
        .byte (AnimCategoryAny << 4) | 0  ; MagicRing
        .byte (AnimCategoryAny << 4) | 0  ; PowerRing
        .byte (AnimCategoryAny << 4) | 0  ; ShieldRing
        .byte (AnimCategoryAny << 4) | 0  ; BarrierRing
        .byte (AnimCategoryAny << 4) | 0  ; LegRing
        .byte (AnimCategoryAny << 4) | 0  ; SkillRing
        .byte (AnimCategorySword << 4) | 0  ; BrokenHolySword
        .byte (AnimCategoryLance << 4) | 2  ; BrokenHolyLance
        .byte (AnimCategoryBow << 4) | 4  ; BrokenHolyBow

        ; 99/8437

      aUnknown998437 ; 99/8437

        ; Read by rlUnknown96941C: routines it calls.

        .long rlUnknown96947D
        .long rlUnknown96881F
        .long rlUnknown95A44F

        ; 99/8440

      aUnknown998440 ; 99/8440

        ; Read by rlUnknown9694C7: routines it calls.

        .long rlUnknown95A45A
        .long rlUnknown968890
        .long rlUnknown96A20E
        .long rlUnknown9686BB
        .long rlUnknown95E9C4
        .long rlUnknown95E993
        .long rlUnknown95E8FD
        .long rlUnknown95E962
        .long rlUnknown95E931
        .long rlUnknown95E8CE
        .long rlUnknown96F56C
        .long rlUnknown9686E7
        .long rlUnknown96865C
        .long rlUnknown96F676
        .long rlUnknown968300
        .long rlUnknown96F32B
        .long rlUnknown969CA1
        .long rlUnknown968840
        .long rlUnknown96F315
        .long rlUnknown96F558
        .long rlUnknown9694AE

        ; 99/847F

      aClassDefaultGenders ; 99/847F

        ; Read by rlUnknown9582F7: the gender a unit of this class gets in battle
        ; animations when its own is Genderless.

        .byte GenderMale   ; Cavalier
        .byte GenderMale   ; LanceKnight
        .byte GenderMale   ; BowKnight
        .byte GenderMale   ; AxeKnight
        .byte GenderMale   ; FreeKnight
        .byte GenderFemale ; Troubadour
        .byte GenderMale   ; KnightLord
        .byte GenderMale   ; DukeKnight
        .byte GenderMale   ; MasterKnight
        .byte GenderMale   ; Paladin
        .byte GenderFemale ; PaladinF
        .byte GenderMale   ; ArchKnight
        .byte GenderMale   ; Ranger
        .byte GenderMale   ; MageKnight
        .byte GenderMale   ; GreatKnight
        .byte GenderFemale ; PegasusRider
        .byte GenderFemale ; PegasusKnight
        .byte GenderFemale ; FalconKnight
        .byte GenderMale   ; Dragonrider
        .byte GenderMale   ; Dragonknight
        .byte GenderMale   ; Dragonmaster
        .byte GenderMale   ; Archer
        .byte GenderMale   ; Myrmidon
        .byte GenderMale   ; Swordmaster
        .byte GenderMale   ; Sniper
        .byte GenderMale   ; Hero
        .byte GenderMale   ; General
        .byte GenderMale   ; Emperor
        .byte GenderMale   ; Baron
        .byte GenderMale   ; Soldier
        .byte GenderMale   ; SpearSoldier
        .byte GenderMale   ; AxeSoldier
        .byte GenderMale   ; BowSoldier
        .byte GenderMale   ; SwordSoldier
        .byte GenderMale   ; LanceArmor
        .byte GenderMale   ; AxeArmor
        .byte GenderMale   ; BowArmor
        .byte GenderMale   ; SwordArmor
        .byte GenderMale   ; Barbarian
        .byte GenderMale   ; Fighter
        .byte GenderMale   ; Brigand
        .byte GenderMale   ; Warrior
        .byte GenderMale   ; Hunter
        .byte GenderMale   ; Pirate
        .byte GenderMale   ; JuniorLord
        .byte GenderMale   ; WarMage
        .byte GenderMale   ; Prince
        .byte GenderFemale ; Princess
        .byte GenderMale   ; WarMageF
        .byte GenderFemale ; Queen
        .byte GenderMale   ; Dancer
        .byte GenderFemale ; Priest
        .byte GenderMale   ; Mage
        .byte GenderMale   ; FireMage
        .byte GenderMale   ; ThunderMage
        .byte GenderMale   ; WindMage
        .byte GenderMale   ; HighPriest
        .byte GenderMale   ; Bishop
        .byte GenderMale   ; Sage
        .byte GenderMale   ; Bard
        .byte GenderMale   ; Priestess
        .byte GenderMale   ; DarkMage
        .byte GenderMale   ; DarkBishop
        .byte GenderMale   ; Thief
        .byte GenderMale   ; Rogue
        .byte GenderMale   ; Civilian
        .byte GenderMale   ; Child
        .byte GenderMale   ; Ballistician
        .byte GenderMale   ; IronBallistician
        .byte GenderMale   ; KillerBallistician
        .byte GenderMale   ; GreatBallistician

        ; 99/84C6

      aUnknown9984C6 ; 99/84C6

        ; Read by rlUnknown9686FC.

        .byte $4D, $0D, $00, $FF, $FF, $E4, $0C, $32, $02, $04, $00, $28, $F5, $4E, $7E, $5C
        .byte $00, $D8, $0D, $50, $02, $0C, $00, $28, $F7, $4E, $7E, $F7, $00, $18, $0E, $1E
        .byte $02, $0C, $00, $28, $F9, $4E, $7E, $F7, $00, $58, $0E, $1E, $02, $0C, $00, $28
        .byte $FF, $4E, $7E, $F7, $00, $98, $0E, $1E, $02, $0C, $00, $28, $FB, $4E, $7E, $F7
        .byte $00, $EE, $0D, $1E, $02, $0C, $00, $28, $FD, $4E, $7E, $F7, $00, $2E, $0E, $1E
        .byte $02, $0C, $00, $28, $03, $4F, $7E, $F7, $00, $6E, $0E, $1E, $02, $0C, $00, $28
        .byte $01, $4F, $7E, $F7, $00, $AE, $0E, $1E, $02, $0C, $00, $28

        ; 99/8532

      aUnknown998532 ; 99/8532

        ; Read by rlUnknown969037.

        .byte $01, $F8, $02, $F4, $03, $F2, $04, $F1, $05, $F0, $07, $EF, $09, $EF, $0B, $F0
        .byte $0C, $F1, $0D, $F3, $0E, $F5, $0E, $F7, $0E, $F9, $0E, $FB, $0D, $FD, $0C, $FE
        .byte $0A, $FF, $08, $00, $08, $00, $08, $00, $08, $00, $08, $00, $08, $00, $82, $08
        .byte $00, $08, $00, $08, $00, $08, $00, $08, $00, $08, $00, $08, $00, $08, $00, $08
        .byte $00, $08, $00, $08, $00, $08, $00, $08, $00, $08, $00, $81, $00, $08, $00, $81
        .byte $00, $08, $00, $80

        ; 99/8586

      aUnknown998586 ; 99/8586

        ; Read by rlUnknown9691C8.

        .byte $FC, $FC, $00, $F8, $F9, $01, $F5, $F7, $02, $F2, $F5, $03, $F1, $F3, $04, $F1
        .byte $F1, $05, $F1, $F0, $06, $F1, $F0, $07, $F1, $F1, $08, $F0, $F2, $09, $EE, $F3
        .byte $0A, $EF, $F4, $09, $F0, $F4, $08, $F1, $F3, $07, $ED, $F2, $09, $F0, $F1, $08
        .byte $F0, $F1, $08, $F0, $F1, $08, $F0, $F1, $08, $F0, $F1, $08, $F0, $F1, $08, $F0
        .byte $F1, $08, $F0, $F1, $08, $F0, $F1, $08, $F0, $F1, $08, $F0, $F1, $08, $F0, $F1
        .byte $08, $F0, $F1, $08, $F0, $F1, $08, $F0, $F1, $08, $F0, $F1, $08, $F0, $F1, $08
        .byte $F0, $F1, $08, $F0, $F1, $08, $F0, $F1, $08, $F0, $F1, $08, $F0, $F1, $08, $F0
        .byte $F1, $08, $F0, $F1, $08, $F0, $F1, $08, $F0, $F1, $08, $F0, $F1, $08, $F0, $F1
        .byte $08, $F0, $F1, $08, $F0, $F1, $08, $F0, $F1, $08, $F0, $F0, $08, $F0, $F0, $08
        .byte $F0, $EF, $08, $F0, $EF, $08, $F0, $EE, $08, $F0, $EE, $08, $81, $00, $08, $F0
        .byte $ED, $08, $81, $00, $08, $F0, $EC, $08, $80

        ; 99/862F

      aUnknown99862F ; 99/862F

        ; Read by rlUnknown9691C8.

        .word $0000, $0000, $0201, $0403, $0402, $0806, $0603, $0C09
        .word $0804, $100C, $0A05, $140F, $0C06, $1812, $0E07, $1C15
        .word $1008, $2018, $1209, $241B, $140A, $281E, $160B, $2C21
        .word $180C, $3024, $1A0D, $3427, $1C0E, $382A, $1E0F, $3C2D
        .word $2010, $4030, $2211, $4433, $2412, $4836, $2613, $4C39
        .word $2814, $503C

        ; 99/8683

      aUnknown998683 ; 99/8683

        ; Read by rlUnknown968F71.

        .word $4F05, $F57E, $7E4E, $A890, $0B00, $7E4F, $4EFB, $E87E
        .word $01A8, $4F07, $F77E, $7E4E, $B090, $0D02, $7E4F, $4EFD
        .word $E87E, $03B0, $4F09, $F97E, $7E4E, $B890, $1304, $7E4F
        .word $4F03, $E87E, $05B8, $4F0F, $FF7E, $7E4E, $C090, $1106
        .word $7E4F, $4F01, $E87E, $07C0, $0080

        ; 99/86CD

      aUnknown9986CD ; 99/86CD

        ; Read by rlUnknown969398.

        .byte $F5, $4E, $7E, $05, $4F, $7E, $5C, $00, $D8, $0D, $50, $FB, $4E, $7E, $0B, $4F
        .byte $7E, $F7, $00, $EE, $0D, $1E, $F7, $4E, $7E, $07, $4F, $7E, $F7, $00, $18, $0E
        .byte $1E, $FD, $4E, $7E, $0D, $4F, $7E, $F7, $00, $2E, $0E, $1E, $F9, $4E, $7E, $09
        .byte $4F, $7E, $F7, $00, $58, $0E, $1E, $03, $4F, $7E, $13, $4F, $7E, $F7, $00, $6E
        .byte $0E, $1E, $FF, $4E, $7E, $0F, $4F, $7E, $F7, $00, $98, $0E, $1E, $01, $4F, $7E
        .byte $11, $4F, $7E, $F7, $00, $AE, $0E, $1E

        ; 99/8725

    .endsection Data9982E3Section


    .section Data99892ASection

      .al
      .xl

      aUnknown99892A ; 99/892A

        ; Read by rlUnknown96F38F.

        .word $0380, $0380, $0280, $0280, $0180, $0180, $0080, $0080
        .word $0081, $0081, $0082, $0082, $FF85

        ; 99/8944

    .endsection Data99892ASection
