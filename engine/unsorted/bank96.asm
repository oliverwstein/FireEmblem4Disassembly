; Code from bank $96 not yet assigned to a game system.

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
