; Code from bank $95 not yet assigned to a game system.

    .section Unsorted958000Section

      .al
      .xl

      rlUnknown958000 ; 95/8000

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown9695F5
        jsr rsUnknown958053
        jsl rlUnknown95A53E
        jsr rsUnknown95820C
        jsl rlUnknown9582D8
        jsr rsUnknown9580E6
        jsl rlUnknown95A649
        jsl rlUnknown9682F8
        jsr rsUnknown958308
        jsr rsUnknown95834B
        jsr rsUnknown9588E9
        jsl rlUnknown95DA1D
        jsl rlUnknown95DA1D
        jsl rlUnknown968DBD
        jsl rlUnknown968E7E
        jsl rlUnknown96C99E
        jsl rlUnknown96D659
        jsl rlUnknown959902
        jsl rlUnknown96D67B
        jsl rlUnknown969A26
        jsl rlUnknown969D01
        jsl rlUnknown969EBB
        rtl

        .databank 0

        ; 95/8053

      rsUnknown958053 ; 95/8053

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$09
        sta bBufferBGMODE
        sta $2105,b
        lda #$00
        sta bBufferMOSAIC
        sta $2106,b
        lda #$39
        sta bBufferBG1SC
        sta $2107,b
        lda #$61
        sta bBufferBG2SC
        sta $2108,b
        lda #$71
        sta bBufferBG3SC
        sta $2109,b
        lda #$02
        sta bBufferBG12NBA
        sta $210B,b
        lda #$77
        sta bBufferBG34NBA
        sta $210C,b
        lda #$00
        sta wBufferBG1HOFS
        sta $210D,b
        sta wBufferBG1VOFS
        sta $210E,b
        sta wBufferBG2HOFS
        sta $210F,b
        sta wBufferBG2VOFS
        sta $2110,b
        sta wBufferBG3HOFS
        sta $2111,b
        sta wBufferBG3VOFS
        sta $2112,b
        sta bBufferWH0
        sta $2126,b
        lda #$FF
        sta bBufferWH1
        sta $2127,b
        lda #$00
        sta bBufferWH2
        sta $2128,b
        lda #$FF
        sta bBufferWH3
        sta $2129,b
        lda #$00
        sta bBufferTMW
        sta $212E,b
        sta bBufferTSW
        sta $212F,b
        lda #$12
        sta bBufferTM
        sta $212C,b
        lda #$02
        sta bBufferOBSEL
        sta $2101,b
        lda #$00
        sta bBufferCGADSUB
        lda #$8F
        sta $0ADD,b
        rep #$20
        rts

        .databank 0

        ; 95/80E6

      rsUnknown9580E6 ; 95/80E6

        .al
        .xl
        .autsiz
        .databank ?

        stz $0CC7,b
        stz $0D3E,b
        lda #$0000
        sta $7FE197
        lda #$0100
        sta $7FE198
        stz $0D65,b
        stz $0D65,b
        lda #$0000
        sta $7FE09E
        sta $7FE1B4
        sep #$20
        sta $7FE1A6
        sta $7FE186
        sta $7FF5AF
        sta $7FFC77
        sta $7FFC9C
        sta $7FFC70
        sta $7FFC71
        sta $7FE191
        sta $7FE193
        sta $7FE195
        sta $7FE196
        sta bBufferCOLDATA_0
        sta bBufferCOLDATA_1
        sta bBufferCOLDATA_2
        sta bBufferCOLDATA_3
        sta $7FE4C2
        sta $7FE4C3
        sta $7FE4DB
        lda $7FE1B3
        ora #$08
        and #$FB
        sta $7FE1B3
        lda #$10
        sta $7FFC6F
        lda #$E0
        sta $7FE3EE
        sta $7FE3ED
        sta $7FE3EC
        lda #$03
        sta $7FE4CC
        stz $0AE0,b
        stz $0AE4,b
        stz $0CC4,b
        stz $0C45,b
        stz $0C78,b
        rep #$20
        jsl rlUnknown95A43C
        jsl rlUnknown96DD39
        jsl rlUnknown96EB02
        jsl rlUnknown96EBC9
        jsl rlUnknown96984A
        jsl rlUnknown96994B
        jsl rlUnknown96F7BF
        jsl rlUnknown969EF9
        lda #$0202
        sta $7FE1F0
        lda #$1212
        sta $7FE1F2
        lda #$0606
        sta $7FE1F4
        lda #$0080
        eor #$FFFF
        inc a
        and #$00FF
        sta $7FE1C8
        lda #$7E00
        sta $0AE2,b
        lda #$4F85
        sta $0AE1,b
        jsl rlUnknown95CA81
        jsl rlUnknown95DA0B
        jsl rlUnknown96A4FC
        jsl rlUnknown96CB0A
        jsl rlUnknown96EE8A
        jsl rlUnknown96A26F
        jsl rlUnknown96B93A
        jsl rlUnknown96BD74
        jsl rlUnknown95A1C6
        jsl rlUnknown95A247
        jsl rlUnknown95B81B
        jsl rlUnknown96957D
        jsl rlUnknown95A414
        jsl rlUnknown95A428
        rts

        .databank 0

        ; 95/820C

      rsUnknown95820C ; 95/820C

        .al
        .xl
        .autsiz
        .databank ?

        lda aActionStructUnit1.ClassID
        sta $0D4E,b
        lda aActionStructUnit2.ClassID
        sta $0D5C,b
        lda aActionStructUnit1.CharacterID
        sta $0D50,b
        lda aActionStructUnit2.CharacterID
        sta $0D5E,b
        lda aActionStructUnit1.WeaponID
        sta $0D52,b
        lda aActionStructUnit2.WeaponID
        sta $0D60,b
        lda $0D4E,b
        sta wR0
        lda aActionStructUnit1.Gender
        and #$00FF
        jsl rlUnknown9582F7
        sep #$20
        sta $0D5A,b
        rep #$20
        lda $0D5C,b
        sta wR0
        lda aActionStructUnit2.Gender
        and #$00FF
        jsl rlUnknown9582F7
        sep #$20
        sta $0D68,b
        lda aChildAverageLevelStats
        sta $0D55,b
        stz $0D54,b
        lda aActionStructUnit2.CurrentHP
        sta $0D63,b
        stz $0D62,b
        lda $7E4EC7
        sta $0D56,b
        lda aActionStructUnit2.MaxHP
        sta $0D64,b
        rep #$20
        lda wBattleStatus
        and #$0001
        beq _829C
        lda aActionStructUnit1.TerrainType
        sta $0D46,b
        lda aActionStructUnit2.TerrainType
        bra _82A7


        _829C
        lda aActionStructUnit2.TerrainType
        sta $0D46,b
        lda aActionStructUnit1.TerrainType

        _82A7
        sta $0D44,b
        lda wBattleDistance
        sep #$20
        sta $0D48,b
        rep #$20
        lda $7FFC59
        bit #$0002
        beq _82D7
        lda #$0000
        sta $7E4ED3
        lda #$FFFF
        sta $7E4ED1
        lda #$0000
        sta wBattleQuotePointer
        sta wDeathQuotePointer

        _82D7
        rts

        .databank 0

        ; 95/82D8

    .endsection Unsorted958000Section


    .section Unsorted9582D8Section

      .al
      .xl

      rlUnknown9582D8 ; 95/82D8

        .al
        .xl
        .autsiz
        .databank ?

        lda $7E4ECD
        sta $0D49,b
        lda $7E4ECF
        sta $0D4B,b
        sep #$20
        lda $7E4EC9
        clc
        adc $7E4ECB
        sta $0D4D,b
        rep #$20
        rtl

        .databank 0

        ; 95/82F7

    .endsection Unsorted9582D8Section


    .section Unsorted9582F7Section

      .al
      .xl

      rlUnknown9582F7 ; 95/82F7

        .al
        .xl
        .autsiz
        .databank ?

        phx
        cmp #$00FF
        bne _8306
        ldx wR0
        lda $99847F,x
        and #$00FF

        _8306
        plx
        rtl

        .databank 0

        ; 95/8308

      rsUnknown958308 ; 95/8308

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7FFC59
        bit #$0004
        bne _8338
        jsl rlUnknown9697FA
        bcs _8320
        ldx #$0043
        lda $0D52,b
        bra _8326


        _8320
        ldx #$0000
        lda $0D60,b

        _8326
        jsl rlUnknown9696AA
        bcs _833D
        cmp #$0000
        beq _8338
        cmp #$0001
        beq _8338
        bra _833D


        _8338
        lda $0D44,b
        bra _8340


        _833D
        lda $0D46,b

        _8340
        jsr rsUnknown958CB9
        jsr rsUnknown958CE5
        jsr rsUnknown958DDB
        plx
        rts

        .databank 0

        ; 95/834B

      rsUnknown95834B ; 95/834B

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown958353
        jsl rlUnknown958798
        rts

        .databank 0

        ; 95/8353

      rsUnknown958353 ; 95/8353

        .al
        .xl
        .autsiz
        .databank ?

        lda $0D50,b
        cmp #$0000
        beq _83A9
        lda $0D5B,b
        and #$00F0
        sta wR0
        lda $0D4E,b
        sta wR1
        lda $0D52,b
        and #$00FF
        clc
        jsl rlUnknown958697
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $0400, $80, $8800

        lda $7FE1B8
        and #$00FF
        clc
        jsr rsUnknown958400
        lda $7FE1B7
        and #$00FF
        clc
        jsr rsUnknown9584D7
        lda $7FE1B9
        and #$00FF
        clc
        jsr rsUnknown95858D
        lda $0D50,b
        clc
        jsl rlUnknown95A167

        _83A9
        lda $0D5E,b
        cmp #$0000
        beq _83FF
        lda $0D69,b
        and #$00F0
        sta wR0
        lda $0D5C,b
        sta wR1
        lda $0D60,b
        and #$00FF
        sec
        jsl rlUnknown958697
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $0400, $80, $A800

        lda $7FE1BC
        and #$00FF
        sec
        jsr rsUnknown958400
        lda $7FE1BB
        and #$00FF
        sec
        jsr rsUnknown9584D7
        lda $7FE1BD
        and #$00FF
        sec
        jsr rsUnknown95858D
        lda $0D5E,b
        sec
        jsl rlUnknown95A167

        _83FF
        rts

        .databank 0

        ; 95/8400

      rsUnknown958400 ; 95/8400

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        phy
        php
        inc a
        and #$00FF
        pha
        tax
        lda $97828B,x
        and #$00FF
        pha
        asl a
        asl a
        asl a
        sec
        sbc #1,s
        clc
        adc #$0048
        tax
        pla
        pla
        cmp #$0000
        bne _8432
        lda #$8600
        sta lR18+1
        lda #$E000
        sta lR18
        jml _84A9


        _8432
        lda $97828E,x
        sta lR45+1
        lda $97828D,x
        sta lR45
        lda #(`aDecompressionBuffer)<<8
        sta lR47+1
        lda #<>aDecompressionBuffer
        sta lR47
        phx
        jsl rlDecompressSingle
        plx
        lda $978290,x
        cmp #$FFFF
        beq _849F
        and #$F800
        cmp #$F800
        beq _849F
        lda $978290,x
        and #$07FF
        phx
        pha
        asl a
        adc #1,s
        tax
        pla
        lda $9784B7,x
        sta lR45+1
        lda $9784B6,x
        sta lR45
        plx
        lda #$7E00
        sta lR47+1
        lda #$AB88
        sta lR47
        jsl rlDecompressSingle
        lda #$7E00
        sta lR18+1
        lda #$AB88
        sta lR18
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        sta lR19
        jsr rsUnknown9590C6

        _849F
        lda #(`aDecompressionBuffer)<<8
        sta lR18+1
        lda #<>aDecompressionBuffer
        sta lR18

        _84A9
        lda $97828B,x
        and #$00FF
        asl a
        asl a
        asl a
        asl a
        plp
        bcs _84BD
        clc
        adc #$4000
        bra _84C1


        _84BD
        clc
        adc #$5000

        _84C1
        sta wR0
        lda $97828C,x
        and #$00FF
        asl a
        asl a
        asl a
        asl a
        asl a
        jsl rlUnknown958757
        ply
        plx
        pla
        rts

        .databank 0

        ; 95/84D7

      rsUnknown9584D7 ; 95/84D7

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        phy
        php
        inc a
        and #$00FF
        pha
        tax
        lda $978039,x
        and #$00FF
        pha
        asl a
        asl a
        clc
        adc #1,s
        clc
        adc #$0068
        tax
        pla
        lda $97803A,x
        sta lR45+1
        lda $978039,x
        sta lR45
        pla
        plp
        pha
        php
        bcs _8510
        lda #$7F00
        sta lR47+1
        lda #$0000
        bra _8518


        _8510
        lda #$7F00
        sta lR47+1
        lda #$6000

        _8518
        sta lR47
        pla
        cmp #$0000
        bne _8520

        _8520
        phx
        jsl rlDecompressSingle
        plx
        lda $97803C,x
        cmp #$FFFF
        beq _8588
        and #$F800
        cmp #$F800
        beq _8588
        lda $97803C,x
        and #$07FF
        phx
        pha
        asl a
        adc #1,s
        tax
        pla
        lda $9784B7,x
        sta lR45+1
        lda $9784B6,x
        sta lR45
        plx
        lda #(`aDecompressionBuffer)<<8
        sta lR47+1
        lda #<>aDecompressionBuffer
        sta lR47
        jsl rlDecompressSingle
        lda #(`aDecompressionBuffer)<<8
        sta lR18+1
        lda #<>aDecompressionBuffer
        sta lR18
        plp
        bcs _8579
        lda #$7F00
        sta lR19+1
        lda #$0000
        sta lR19
        bra _8583


        _8579
        lda #$7F00
        sta lR19+1
        lda #$6000
        sta lR19

        _8583
        jsr rsUnknown9590C6
        bra _8589


        _8588
        plp

        _8589
        ply
        plx
        pla
        rts

        .databank 0

        ; 95/858D

      rsUnknown95858D ; 95/858D

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        php
        pha
        bcs _859F
        lda $0D50,b
        sta wR0
        lda $0D4E,b
        sta wR1
        bra _85A9


        _859F
        lda $0D5E,b
        sta wR0
        lda $0D5C,b
        sta wR1

        _85A9
        ldx #$0000

        _85AC
        lda $9786AD,x
        cmp #$FFFF
        beq _85DD
        cmp wR0
        bne _85C4
        lda $9786AF,x
        and #$00FF
        cmp wR1
        beq _85CC

        _85C4
        txa
        clc
        adc #$0004
        tax
        bra _85AC


        _85CC
        lda $9786B0,x
        and #$00FF
        sta #1,s
        lda #$0001
        sta wR2
        pla
        bra _85E3


        _85DD
        lda #$0000
        sta wR2
        pla

        _85E3
        inc a
        and #$00FF
        tax
        lda $9784B6,x
        and #$00FF
        asl a
        asl a
        clc
        adc #$006B
        tax
        lda $9784B6,x
        sta lR18
        lda $9784B7,x
        sta lR18+1
        lda $9784B9,x
        and #$00FF
        plp
        bcs _8614
        ldx #$0002
        ldy #$0000
        bra _8618


        _8614
        ldx #$0082
        tay

        _8618
        pha
        lda wR2
        bne _8647
        pla
        pha
        lda $7E4EA9
        and #$00FF
        cmp #$0002
        beq _8647
        pla
        pha
        lda @l $000D5E
        cmp #$0040
        bcc _8647
        pla
        pha
        jsl rlUnknown9697FA
        bcs _864A
        lda $0D52,b
        jsl rlUnknown958678
        bcc _864A

        _8647
        ldy #$0000

        _864A
        pla

        _864B
        pha
        sep #$20
        lda [lR18],y
        sta aOAMPaletteBuffer,b,x
        rep #$20
        lda lR18
        inc a
        cmp #$0000
        bne _8664
        inc lR18+2
        lda #$8000
        bra _866E


        _8664
        cmp #$8000
        bne _866E
        inc lR18+2
        lda #$0000

        _866E
        sta lR18
        inc x
        pla
        dec a
        bne _864B
        plx
        pla
        rts

        .databank 0

        ; 95/8678

      rlUnknown958678 ; 95/8678

        .al
        .xl
        .autsiz
        .databank ?

        phx
        pha
        sep #$20
        ldx #$0000

        _867F
        lda $998F86,x
        cmp #$FF
        beq _8691
        cmp #1,s
        beq _868E
        inc x
        bra _867F


        _868E
        sec
        bra _8692


        _8691
        clc

        _8692
        rep #$20
        pla
        plx
        rtl

        .databank 0

        ; 95/8697

      rlUnknown958697 ; 95/8697

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        phy
        php
        pha
        lda wR0
        cmp #$0090
        beq _86AE
        cmp #$0070
        beq _86AE
        jsl rlUnknown958721
        bcc _86B5

        _86AE
        pla
        jsr rsUnknown958741
        plp
        bra _871D


        _86B5
        pla
        and #$00FF
        asl a
        tax
        lda $998725,x
        pha
        and #$00FF
        pha
        asl a
        clc
        adc #1,s
        tax
        pla
        lda $99881F,x
        sta lR45
        lda $998820,x
        sta lR45+1
        lda #(`aDecompressionBuffer)<<8
        sta lR47+1
        lda #<>aDecompressionBuffer
        sta lR47
        jsl rlDecompressSingle
        pla
        xba
        and #$00FF
        asl a
        pha
        asl a
        asl a
        asl a
        asl a
        sec
        sbc #1,s
        clc
        adc #$0F30
        sta lR18
        pla
        sep #$20
        lda #$E0
        sta lR18+2
        rep #$20
        plp
        bcs _8709
        ldx #$0142
        bra _870C


        _8709
        ldx #$01C2

        _870C
        ldy #$0000

        _870F
        lda [lR18],y
        sta aBGPaletteBuffer,b,x
        inc x
        inc x
        inc y
        inc y
        cpy #$001E
        bcc _870F

        _871D
        ply
        plx
        pla
        rtl

        .databank 0

        ; 95/8721

      rlUnknown958721 ; 95/8721

        .al
        .xl
        .autsiz
        .databank ?

        phx
        cmp #$0080
        bne _873E
        ldx #$0000

        _872A
        lda $998F91,x
        cmp #$FFFF
        beq _873E
        cmp wR1
        beq _873B
        inc x
        inc x
        bra _872A


        _873B
        sec
        bra _873F


        _873E
        clc

        _873F
        plx
        rtl

        .databank 0

        ; 95/8741

      rsUnknown958741 ; 95/8741

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        ldx #$0000
        lda #$0000

        _8749
        sta $7E8B88,x
        inc x
        inc x
        cpx #$0400
        bcc _8749
        plx
        pla
        rts

        .databank 0

        ; 95/8757

      rlUnknown958757 ; 95/8757

        .al
        .xl
        .autsiz
        .databank ?

        pha
        sep #$20
        stz $420B,b
        stz $420C,b
        sta $4315,b
        xba
        sta $4316,b
        lda lR18
        sta $4312,b
        lda lR18+1
        sta $4313,b
        lda lR18+2
        sta $4314,b
        lda #$80
        sta $2115,b
        lda wR0
        sta $2116,b
        lda wR0+1
        sta $2117,b
        lda #$01
        sta $4310,b
        lda #$18
        sta $4311,b
        lda #$02
        sta $420B,b
        rep #$20
        pla
        rtl

        .databank 0

        ; 95/8798

      rlUnknown958798 ; 95/8798

        .al
        .xl
        .autsiz
        .databank ?

        lda $0D50,b
        cmp #$0000
        beq _87DB
        lda $0D50,b
        sta wR0
        lda $0D4E,b
        jsl rlUnknown95881F
        bcs _87C5
        pha
        lda $0D5B,b
        and #$00F0
        cmp #$0030
        bne _87BD
        pla
        bra _87C5


        _87BD
        pla
        clc
        jsl rlUnknown95886E
        bra _87CE


        _87C5
        cmp #$0001
        beq _87DB
        jsl rlUnknown9588D3

        _87CE
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $0300, $80, $8C00


        _87DB
        lda $0D5E,b
        cmp #$0000
        beq _881E
        lda $0D5E,b
        sta wR0
        lda $0D5C,b
        jsl rlUnknown95881F
        bcs _8808
        pha
        lda $0D69,b
        and #$00F0
        cmp #$0030
        bne _8800
        pla
        bra _8808


        _8800
        pla
        sec
        jsl rlUnknown95886E
        bra _8811


        _8808
        cmp #$0001
        beq _881E
        jsl rlUnknown9588D3

        _8811
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $0300, $80, $AC00


        _881E
        rtl

        .databank 0

        ; 95/881F

      rlUnknown95881F ; 95/881F

        .al
        .xl
        .autsiz
        .databank ?

        phx
        pha
        ldx #$0000

        _8824
        lda $998194,x
        cmp #$FFFF
        beq _8861
        and #$00FF
        cmp #1,s
        beq _8839
        inc x
        inc x
        inc x
        bra _8824


        _8839
        pla
        inc x
        lda $998194,x
        cmp #$FFFF
        beq _8868
        tax

        _8845
        lda $998194,x
        cmp #$FFFF
        beq _8858
        cmp wR0
        beq _8858
        inc x
        inc x
        inc x
        inc x
        bra _8845


        _8858
        inc x
        inc x
        lda $998194,x
        clc
        bra _886C


        _8861
        pla
        lda #$0000
        sec
        bra _886C


        _8868
        lda #$0001
        sec

        _886C
        plx
        rtl

        .databank 0

        ; 95/886E

      rlUnknown95886E ; 95/886E

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        phy
        php
        pha
        and #$00FF
        pha
        asl a
        clc
        adc #1,s
        tax
        pla
        lda $9982AD,x
        sta lR45
        lda $9982AE,x
        sta lR45+1
        lda #(`aDecompressionBuffer)<<8
        sta lR47+1
        lda #<>aDecompressionBuffer
        sta lR47
        jsl rlDecompressSingle
        pla
        xba
        and #$00FF
        asl a
        pha
        asl a
        asl a
        asl a
        clc
        adc #1,s
        clc
        adc #$1368
        sta lR18
        pla
        sep #$20
        lda #$E0
        sta lR18+2
        rep #$20
        plp
        bcs _88BB
        ldx #$0162
        bra _88BE


        _88BB
        ldx #$01E2

        _88BE
        ldy #$0000

        _88C1
        lda [lR18],y
        sta aBGPaletteBuffer,b,x
        inc x
        inc x
        inc y
        inc y
        cpy #$0012
        bcc _88C1
        ply
        plx
        pla
        rtl

        .databank 0

        ; 95/88D3

      rlUnknown9588D3 ; 95/88D3

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        ldx #$0000
        lda #$0000

        _88DB
        sta $7E8B88,x
        inc x
        inc x
        cpx #$0300
        bcc _88DB
        plx
        pla
        rtl

        .databank 0

        ; 95/88E9

      rsUnknown9588E9 ; 95/88E9

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $0D50,b
        cmp #$0000
        bne _88FD
        sep #$20
        lda #$00
        sta $0AF3,b
        rep #$20
        bra _8919


        _88FD
        jsl rlUnknown95B993
        lda $7FE1B6
        and #$00FF
        jsl rlUnknown958AB7
        lda #$0180
        sta $0C05,b
        lda #$0000
        jsl rlUnknown95B9AC

        _8919
        lda $0D5E,b
        cmp #$0000
        bne _892C
        sep #$20
        lda #$00
        sta $0B36,b
        rep #$20
        bra _8969


        _892C
        jsl rlUnknown95B993
        lda $7FE1BA
        and #$00FF
        jsl rlUnknown958AB7
        lda #$0080
        sta $0C05,b
        lda #$5000
        sta $0C39,b
        lda #$7F00
        sta $0C34,b
        lda #$6000
        sta $0C33,b
        lda #$8100
        sta $0C30,b
        sep #$20
        lda #$08
        sta $0C32,b
        rep #$20
        lda #$0001
        jsl rlUnknown95B9AC

        _8969
        lda $7FFC59
        bit #$0004
        beq _8999
        lda #$0100
        sta $0AF9,b
        lda #$0100
        sta $0B3C,b
        lda #$0000
        sta $7FE197
        lda #$0100
        sta $7FE198
        sep #$20
        lda #$00
        sta $0AE8,b
        rep #$20
        jml _8A6A


        _8999
        jsl rlUnknown9697FA
        bcs _8A0B
        clc
        ldx #$0000
        jsl rlUnknown95B6D0
        sta wR0
        lda $0AF9,b
        sec
        sbc wR0
        bcs _89B9
        cmp #$0068
        bcs _89B9
        lda #$0068

        _89B9
        sta $0B3C,b
        lda $0D5B,b
        and #$00F0
        cmp #$0080
        beq _89EE
        ldx #$0000
        jsl rlUnknown969820
        bcs _89EE
        bra _89EE

        .byte $A2, $00, $00, $22, $CF, $B7, $95, $EB, $9D, $FD, $0A, $89, $FF, $FF, $F0, $0C
        .byte $E2, $20, $AD, $F3, $0A, $09, $20, $8D, $F3, $0A, $C2, $20


        _89EE
        clc
        jsr rsUnknown95E3DF
        lda #$0000
        sta $7FE197
        lda #$00C0
        sta $7FE198
        sep #$20
        lda #$00
        sta $0AE8,b
        rep #$20
        bra _8A6A


        _8A0B
        sec
        ldx #$0043
        jsl rlUnknown95B6D0
        sta wR0
        lda $0B3C,b
        clc
        adc wR0
        bcc _8A25
        cmp #$0198
        bcc _8A25
        lda #$0198

        _8A25
        sta $0AF9,b
        ldx #$0043
        jsl rlUnknown969820
        bcs _8A4F
        bra _8A4F

        .byte $A2, $43, $00, $22, $CF, $B7, $95, $EB, $9D, $FD, $0A, $89, $FF, $FF, $F0, $0C
        .byte $E2, $20, $AD, $36, $0B, $09, $20, $8D, $36, $0B, $C2, $20


        _8A4F
        sec
        jsr rsUnknown95E3DF
        lda #$0000
        sta $7FE197
        lda #$0040
        sta $7FE198
        sep #$20
        lda #$80
        sta $0AE8,b
        rep #$20

        _8A6A
        jsl rlUnknown95B050
        lda wR0
        cmp #$00C0
        bcs _8A93
        lda wR0
        lsr a
        pha
        lda #$0100
        clc
        adc #1,s
        sta $0AF9,b
        lda #$0100
        sec
        sbc #1,s
        sta $0B3C,b
        pla
        lda #$0080
        sta $7FE198

        _8A93
        lda $0D50,b
        cmp #$0000
        beq _8AA2
        ldx #$0000
        jsl rlUnknown95AAFF

        _8AA2
        lda $0D5E,b
        cmp #$0000
        beq _8AB1
        ldx #$0043
        jsl rlUnknown95AAFF

        _8AB1
        jsl rlUnknown969665
        plx
        rts

        .databank 0

        ; 95/8AB7

      rlUnknown958AB7 ; 95/8AB7

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        inc a
        and #$00FF
        tax
        lda $97874F,x
        and #$00FF
        asl a
        pha
        asl a
        clc
        adc #1,s
        clc
        adc #$0060
        tax
        pla
        lda $97874F,x
        sta $0C25,b
        lda $978750,x
        sta $0C26,b
        lda $978752,x
        sta $0C36,b
        lda $978753,x
        sta $0C37,b
        plx
        pla
        rtl

        .databank 0

        ; 95/8AF0

      rlUnknown958AF0 ; 95/8AF0

        .al
        .xl
        .autsiz
        .databank ?

        ldy #$0004
        ldx #$0000

        _8AF6
        sep #$20
        stz $0AF3,b,x
        rep #$20
        txa
        clc
        adc #$0043
        tax
        dec y
        bne _8AF6
        rtl

        .databank 0

        ; 95/8B07

    .endsection Unsorted9582F7Section


    .section Unsorted958B07Section

      .al
      .xl

      rsUnknown958B07 ; 95/8B07

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown96941C
        jsl rlUnknown958C3E
        jsr rsUnknown95A114
        jsr rsUnknown959C14
        jsl rlUnknown95A481
        lda $7FFC77
        bit #$0001
        beq _8B26
        jml _8B85


        _8B26
        lda $0AE0,b
        bit #$0001
        beq _8B36
        jsl rlUnknown95DA1D
        jsl rlUnknown95A65F

        _8B36
        jsl rlUnknown96F7D4
        jsr rsUnknown95C5E6
        ldx #$0000
        jsl rlUnknown95C6CD
        jsl rlUnknown95CBE4
        jsl rlUnknown95CC06
        jsl rlUnknown95CDA3
        ldx #$0043
        jsl rlUnknown95C6CD
        jsl rlUnknown95CBE4
        jsl rlUnknown95CC06
        jsl rlUnknown95CDA3
        ldx #$0086
        jsl rlUnknown95DE61
        jsl rlUnknown95E1C9
        jsl rlUnknown95E22C
        ldx #$00C9
        jsl rlUnknown95DE61
        jsl rlUnknown95E1C9
        jsl rlUnknown95E22C
        jsl rlUnknown95CAD5

        _8B85
        jsl rlUnknown96961F
        jsl rlUnknown96A0E2
        jsl rlUnknown95C0A6
        jsl rlUnknown96A28B
        jsl rlUnknown96CB44
        jsl rlUnknown96BBE2
        jsl rlUnknown96952C
        jsl rlUnknown96EBE3
        jsr rsUnknown95D580
        jsr rsUnknown95D670
        jsl rlUnknown96DE6F
        jsl rlUnknown96A532
        jsl rlUnknown96DD6E
        jsl rlUnknown95D721
        jsl rlUnknown96BE28
        jsl rlUnknown95BAEF
        jsl rlUnknown96A05C
        jsl rlUnknown95D863
        jsr rsUnknown95D77C
        jsr rsUnknown959292
        jsr rsUnknown95938C
        jsl rlUnknown96D695
        jsl rlUnknown95C508
        jsl rlUnknown95C47A
        jsl rlUnknown96C8A1
        jsr rsUnknown959CF8
        jsl rlUnknown969F1C
        jsl rlUnknown9598E7

        _8BEF
        lda $7FE1CF
        and #$00FF
        beq _8BEF
        jsr rsUnknown9590F2
        jsr rsUnknown959210
        jsr rsUnknown959197
        jsl rlUnknown95A086
        jsl rlUnknown96EE95
        jsl rlUnknown9698EF
        jsr rsUnknown959C64
        jsr rsUnknown958C52
        jsl rlUnknown96989E
        jsl rlUnknown9694C7
        bcc _8C22
        jsr rsUnknown958CA8
        bcc _8C22

        _8C22
        lda $7FFC56
        and #$00CF
        cmp #$0040
        bne _8C31
        sec
        bra _8C32


        _8C31
        clc

        _8C32
        php
        lda $7FE09E
        inc a
        sta $7FE09E
        plp
        rts

        .databank 0

        ; 95/8C3E

      rlUnknown958C3E ; 95/8C3E

        .al
        .xl
        .autsiz
        .databank ?

        bcc _8C51
        lda $04BA,b
        bne _8C51
        sep #$20
        lda $0AE0,b
        ora #$01
        sta $0AE0,b
        rep #$20

        _8C51
        rtl

        .databank 0

        ; 95/8C52

      rsUnknown958C52 ; 95/8C52

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda $0AE0,b
        bit #$0002
        beq _8CA4
        lda $0B08,b
        bit #$7FFF
        bne _8CA4
        lda $0B0E,b
        bne _8CA4
        lda $0AF3,b
        bit #$0004
        bne _8CA4
        lda $0D57,b
        bne _8CA4
        lda $0B4B,b
        bit #$7FFF
        bne _8CA4
        lda $0B51,b
        bne _8CA4
        lda $0B36,b
        bit #$0004
        bne _8CA4
        lda $0D65,b
        bne _8CA4
        lda $0AF1,b
        and #$003F
        bne _8CA4
        lda $7FE4B7
        bit #$0080
        bne _8CA4
        sec
        bra _8CA5


        _8CA4
        clc

        _8CA5
        ply
        plx
        rts

        .databank 0

        ; 95/8CA8

      rsUnknown958CA8 ; 95/8CA8

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda $0AE0,b
        bit #$0008
        bne _8CB5
        sec
        bra _8CB6


        _8CB5
        clc

        _8CB6
        ply
        plx
        rts

        .databank 0

        ; 95/8CB9

    .endsection Unsorted958B07Section


    .section Unsorted958CB9Section

      .al
      .xl

      rsUnknown958CB9 ; 95/8CB9

        .al
        .xl
        .autsiz
        .databank ?

        pha
        cmp #$0005
        beq _8CCB
        cmp #$0006
        beq _8CD8
        cmp #$0010
        beq _8CD8
        bra _8CE3


        _8CCB
        lda $7FFC59
        ora #$0010
        sta $7FFC59
        bra _8CE3


        _8CD8
        lda $7FFC59
        ora #$0020
        sta $7FFC59

        _8CE3
        pla
        rts

        .databank 0

        ; 95/8CE5

      rsUnknown958CE5 ; 95/8CE5

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        sec
        jsl rlUnknown958D4D
        lda lR18
        sta lR45
        lda lR18+1
        sta lR45+1
        lda #$7F00
        sta lR47+1
        lda #$0000
        sta lR47
        jsl rlDecompressSingle
        jsl rlDMAByStruct

          .structDMAToVRAM $7F0000, $6000, $80, $0000

        lda lR19
        sta lR45
        lda lR19+1
        sta lR45+1
        lda #$7F00
        sta lR47+1
        lda #$8000
        sta lR47
        jsl rlDecompressSingle
        jsl rlDMAByStruct

          .structDMAToVRAM $7F8000, $1000, $80, $C000

        ldy #$0000

        _8D35
        lda [lR20],y
        sta $0162,b,y
        inc y
        inc y
        cpy #$005E
        bcc _8D35
        lda #$0000
        sta $027E,b
        sta $02FE,b
        ply
        plx
        rts

        .databank 0

        ; 95/8D4D

      rlUnknown958D4D ; 95/8D4D

        .al
        .xl
        .autsiz
        .databank ?

        phx
        php
        pha
        lda $7E4EA9
        and #$00FF
        cmp #$0002
        bne _8D62
        ldx #$00E6
        pla
        bra _8D8B


        _8D62
        pla
        and #$00FF
        cmp #$001A
        bcc _8D6E
        lda #$0000

        _8D6E
        tax
        jsl rlUnknown9590B7
        bcc _8D7B
        txa
        clc
        adc #$001A
        tax

        _8D7B
        lda $98A9F0,x
        and #$00FF
        asl a
        pha
        asl a
        asl a
        clc
        adc #1,s
        tax
        pla

        _8D8B
        lda $98A900,x
        sta lR18
        lda $98A901,x
        sta lR18+1
        lda $98A903,x
        sta lR19
        lda $98A904,x
        sta lR19+1
        lda $98A906,x
        sta lR20
        lda $98A907,x
        sta lR20+1
        plp
        bcc _8DD9
        lda $98A909,x
        bit #$0001
        beq _8DCB
        sep #$20
        lda $7FE1B3
        ora #$01
        sta $7FE1B3
        rep #$20
        bra _8DD9


        _8DCB
        sep #$20
        lda $7FE1B3
        and #$FE
        sta $7FE1B3
        rep #$20

        _8DD9
        plx
        rtl

        .databank 0

        ; 95/8DDB

      rsUnknown958DDB ; 95/8DDB

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        jsr rsUnknown95901D
        bcc _8E0C
        sep #$20
        lda $7FE1B3
        and #$FD
        sta $7FE1B3
        rep #$20
        sep #$20
        lda bBufferTM
        and #$FE
        sta bBufferTM
        sta $212C,b
        rep #$20
        lda $7FE1F2
        and #$FEFE
        sta $7FE1F2
        jml _8FEE


        _8E0C
        pha
        and #$00FF
        dec a
        asl a
        asl a
        pha
        asl a
        clc
        adc #1,s
        tax
        pla
        lda #1,s
        and #$00FF
        cmp #$0000
        bne _8E4C
        jsr rsUnknown958FF1
        phx
        jsl rlDMAByStruct

          .structDMAToVRAM $7F0000, $1000, $80, $5000

        plx
        jsr rsUnknown959007
        phx
        jsl rlDMAByStruct

          .structDMAToVRAM $7F0000, $0800, $80, $7800

        plx
        jml _8F18


        _8E4C
        sep #$20
        lda $7FE1B3
        ora #$02
        sta $7FE1B3
        rep #$20
        sep #$20
        lda bBufferTM
        ora #$01
        sta bBufferTM
        sta $212C,b
        rep #$20
        lda $7FE1F2
        ora #$0101
        sta $7FE1F2
        lda #1,s
        and #$00FF
        cmp #$0003
        beq _8E81
        cmp #$0006
        bne _8EAB

        _8E81
        lda $98AA24,x
        sta lR45
        lda $98AA25,x
        sta lR45+1
        lda #$7F00
        sta lR47+1
        lda #$0000
        sta lR47
        phx
        jsl rlDecompressSingle
        jsl rlDMAByStruct

          .structDMAToVRAM $7F0000, $2000, $80, $4000

        bra _8ED3


        _8EAB
        lda $98AA24,x
        sta lR45
        lda $98AA25,x
        sta lR45+1
        lda #$7F00
        sta lR47+1
        lda #$0000
        sta lR47
        phx
        jsl rlDecompressSingle
        jsl rlDMAByStruct

          .structDMAToVRAM $7F0000, $1000, $80, $5000


        _8ED3
        plx
        lda $98AA2A,x
        sta lR45
        lda $98AA2B,x
        sta lR45+1
        lda #$7F00
        sta lR47+1
        lda #$0000
        sta lR47
        phx
        jsl rlDecompressSingle
        jsl rlDMAByStruct

          .structDMAToVRAM $7F0000, $0800, $80, $7800

        plx
        lda $98AA2D,x
        sta lR18
        lda $98AA2E,x
        sta lR18+1
        ldy #$0000

        _8F0C
        lda [lR18],y
        sta aBGPaletteBuffer.aPalette2,b,y
        inc y
        inc y
        cpy #$0020
        bcc _8F0C

        _8F18
        pla
        xba
        and #$00FF
        pha
        dec a
        asl a
        asl a
        pha
        asl a
        clc
        adc #1,s
        tax
        pla
        pla
        cmp #$0000
        bne _8F51
        jsr rsUnknown958FF1
        phx
        jsl rlDMAByStruct

          .structDMAToVRAM $7F0000, $1000, $80, $4000

        jsl rlDMAByStruct

          .structDMAToVRAM $7F0000, $0800, $80, $7000

        plx
        jml _8FEE


        _8F51
        cmp #$0003
        beq _8FAA
        cmp #$0006
        beq _8FAA
        sep #$20
        lda $7FE1B3
        ora #$02
        sta $7FE1B3
        rep #$20
        sep #$20
        lda bBufferTM
        ora #$01
        sta bBufferTM
        sta $212C,b
        rep #$20
        lda $7FE1F2
        ora #$0101
        sta $7FE1F2
        lda $98AA24,x
        sta lR45
        lda $98AA25,x
        sta lR45+1
        lda #$7F00
        sta lR47+1
        lda #$0000
        sta lR47
        phx
        jsl rlDecompressSingle
        jsl rlDMAByStruct

          .structDMAToVRAM $7F0000, $1000, $80, $4000

        plx

        _8FAA
        lda $98AA27,x
        sta lR45
        lda $98AA28,x
        sta lR45+1
        lda #$7F00
        sta lR47+1
        lda #$0000
        sta lR47
        phx
        jsl rlDecompressSingle
        jsl rlDMAByStruct

          .structDMAToVRAM $7F0000, $0800, $80, $7000

        plx
        lda $98AA2D,x
        sta lR18
        lda $98AA2E,x
        sta lR18+1
        ldy #$0000

        _8FE2
        lda [lR18],y
        sta aBGPaletteBuffer.aPalette1,b,y
        inc y
        inc y
        cpy #$0020
        bcc _8FE2

        _8FEE
        ply
        plx
        rts

        .databank 0

        ; 95/8FF1

      rsUnknown958FF1 ; 95/8FF1

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        lda #$0000
        ldx #$0000

        _8FF9
        sta $7F0000,x
        inc x
        inc x
        cpx #$1000
        bcc _8FF9
        plx
        pla
        rts

        .databank 0

        ; 95/9007

      rsUnknown959007 ; 95/9007

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        lda #$0080
        ldx #$0000

        _900F
        sta $7F0000,x
        inc x
        inc x
        cpx #$0800
        bcc _900F
        plx
        pla
        rts

        .databank 0

        ; 95/901D

      rsUnknown95901D ; 95/901D

        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsr rsUnknown959083
        bcs _9081
        lda aActionStructUnit1.TerrainType
        and #$00FF
        sta wR0
        lda aActionStructUnit2.TerrainType
        and #$00FF
        sta wR1
        jsl rlUnknown9590B7
        bcc _904B
        lda wR0
        clc
        adc #$001A
        sta wR0
        lda wR1
        clc
        adc #$001A
        sta wR1

        _904B
        ldx #$0000

        _904E
        lda $98AA6C,x
        and #$00FF
        cmp #$00FF
        beq _9080
        cmp #$00FE
        beq _9063
        cmp wR0
        bne _9073

        _9063
        lda $98AA6D,x
        and #$00FF
        cmp #$00FE
        beq _9079
        cmp wR1
        beq _9079

        _9073
        inc x
        inc x
        inc x
        inc x
        bra _904E


        _9079
        lda $98AA6E,x
        clc
        bra _9081


        _9080
        sec

        _9081
        plx
        rts

        .databank 0

        ; 95/9083

      rsUnknown959083 ; 95/9083

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7FFC59
        bit #$0002
        bne _90B4
        lda $0D52,b
        sta wR0
        lda $0D60,b
        sta wR1
        ldx #$0000

        _909A
        lda $98AAA1,x
        and #$00FF
        cmp #$00FF
        beq _90B1
        cmp wR0
        beq _90B4
        cmp wR1
        beq _90B4
        inc x
        bra _909A


        _90B1
        clc
        bra _90B5


        _90B4
        sec

        _90B5
        plx
        rts

        .databank 0

        ; 95/90B7

      rlUnknown9590B7 ; 95/90B7

        .al
        .xl
        .autsiz
        .databank ?

        pha
        lda wCurrentChapter,b
        cmp #$0004
        beq _90C3
        clc
        bra _90C4


        _90C3
        sec

        _90C4
        pla
        rtl

        .databank 0

        ; 95/90C6

      rsUnknown9590C6 ; 95/90C6

        .al
        .xl
        .autsiz
        .databank ?

        lda lR19+1
        sta $2182,b
        ldy #$0000
        lda [lR18],y
        inc y
        inc y

        _90D2
        pha
        lda [lR18],y
        clc
        adc lR19
        sta $2181,b
        inc y
        inc y
        sep #$20
        ldx #$0020

        _90E2
        lda [lR18],y
        sta $2180,b
        inc y
        dec x
        bne _90E2
        rep #$20
        pla
        dec a
        bne _90D2
        rts

        .databank 0

        ; 95/90F2

    .endsection Unsorted958CB9Section


    .section Unsorted9590F2Section

      .al
      .xl

      rsUnknown9590F2 ; 95/90F2

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FE1B3
        bit #$0004
        beq _90FF
        jml _9196


        _90FF
        ldx #$0000
        lda #$000F
        sta $7FE1F6,x
        inc x
        lda #$E1C2
        sta $7FE1F6,x
        inc x
        inc x
        lda $7FE1CA
        and #$00FF
        beq _912A
        sta $7FE1F6,x
        inc x
        lda #$E1C2
        sta $7FE1F6,x
        inc x
        inc x

        _912A
        lda $7FE1B3
        bit #$0001
        bne _9146
        lda #$0070
        sta $7FE1F6,x
        inc x
        lda #$E19B
        sta $7FE1F6,x
        inc x
        inc x
        bra _918C


        _9146
        lda $7FE19A
        and #$00FF
        clc
        adc #$0048
        cmp #$0071
        bcc _9159
        lda #$0070

        _9159
        sta $7FE1F6,x
        inc x
        lda #$E236
        sta $7FE1F6,x
        inc x
        inc x
        lda $7FE19A
        and #$00FF
        cmp #$0029
        bcs _918C
        pha
        lda #$0029
        sec
        sbc #1,s
        ora #$0080
        sta $7FE1F6,x
        pla
        inc x
        lda #$E23A
        sta $7FE1F6,x
        inc x
        inc x

        _918C
        sep #$20
        lda #$00
        sta $7FE1F6,x
        rep #$20

        _9196
        rts

        .databank 0

        ; 95/9197

      rsUnknown959197 ; 95/9197

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda $7FE1B3
        bit #$0001
        beq _920D
        lda $7FE198
        cmp #$00C0
        bcc _91AE
        lda #$00BF

        _91AE
        sec
        sbc #$0040
        phx
        phy
        pha
        lda $7FE1B3
        bit #$0001
        bne _91C1
        pla
        bra _91CF


        _91C1
        pla
        sta wR10
        lda #$0192
        sta wR11
        jsl rlUnsignedMultiply16By16
        lda wR12+1

        _91CF
        ply
        plx
        sta wR10
        lda #$0029
        sta wR11
        jsl rlUnsignedMultiply16By16
        lda #$9800
        sta lR18+1
        lda wR12
        clc
        adc #$8000
        sta lR18
        ldx #$0000
        ldy #$0000

        _91EF
        lda [lR18],y
        and #$00FF
        sta $7FE236,x
        inc x
        inc x
        inc y
        lda @l wBufferBG2VOFS
        and #$00FF
        sta $7FE236,x
        inc x
        inc x
        cpx #$00A4
        bcc _91EF

        _920D
        ply
        plx
        rts

        .databank 0

        ; 95/9210

      rsUnknown959210 ; 95/9210

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0000
        lda #$000F
        sta $7FE1D0,x
        inc x
        lda #$0000
        sta $7FE1D0,x
        inc x
        inc x
        lda $7FE1CA
        and #$00FF
        beq _923B
        sta $7FE1D0,x
        inc x
        lda #$E1F0
        sta $7FE1D0,x
        inc x
        inc x

        _923B
        lda $7FE1CB
        and #$00FF
        beq _9276
        cmp #$0080
        bcs _9253
        sta $7FE1D0,x
        inc x
        lda #$E1F2
        bra _9270


        _9253
        sec
        sbc #$007F
        sta $7FE1D0,x
        inc x
        lda #$E1F2
        sta $7FE1D0,x
        inc x
        inc x
        lda #$007F
        sta $7FE1D0,x
        inc x
        lda #$E1F2

        _9270
        sta $7FE1D0,x
        inc x
        inc x

        _9276
        sep #$20
        lda #$00
        sta $7FE1D0,x
        rep #$20
        lda #$E1D0
        sta wR1
        lda #$E1E0
        sta wR0
        lda #$0010
        jsl rlUnknown95A0C1
        rts

        .databank 0

        ; 95/9292

      rsUnknown959292 ; 95/9292

        .al
        .xl
        .autsiz
        .databank ?

        lda $0D57,b
        bne _929B
        jml _9352


        _929B
        lda $0D57,b
        bmi _9300
        lda #$2940
        pha
        lda $0D54,b
        clc
        adc $0D57,b
        and #$FF00
        pha
        lda $0D54,b
        and #$FF00
        cmp #1,s
        beq _92C0
        lda #$000D
        jsl rlPlaySoundEffect

        _92C0
        pla
        lda $0D54,b
        clc
        adc $0D57,b
        bcc _92D3
        lda $0D56,b
        and #$00FF
        xba
        bra _92F6


        _92D3
        sta $0D54,b
        xba
        sep #$20
        cmp $0D56,b
        bcc _92E6
        lda $0D56,b
        xba
        lda #$00
        bra _92F6


        _92E6
        cmp $0D59,b
        bcc _92F3
        lda $0D59,b
        xba
        lda #$00
        bra _92F6


        _92F3
        xba
        bra _9347


        _92F6
        .al
        rep #$20
        sta $0D54,b
        stz $0D57,b
        bra _934C


        _9300
        lda #$3540
        pha
        lda $0D57,b
        eor #$FFFF
        inc a
        sta wR0
        lda $0D54,b
        sec
        sbc wR0
        bcs _931B
        lda #$0000
        xba
        bra _9333


        _931B
        sta $0D54,b
        xba
        sep #$20
        cmp $0D59,b
        beq _9328
        bcs _9330

        _9328
        lda $0D59,b
        xba
        lda #$00
        bra _9333


        _9330
        xba
        bra _9347


        _9333
        rep #$20
        sta $0D54,b
        stz $0D57,b
        sep #$20
        lda #$10
        sta $7FE1C0
        rep #$20
        bra _934C


        _9347
        .as
        rep #$20
        sta $0D54,b

        _934C
        pla
        jsr rsUnknown9594F8
        bra _937B


        _9352
        lda $7FE1C0
        and #$00FF
        beq _937B
        dec a
        sep #$20
        sta $7FE1C0
        rep #$20
        beq _9375
        tax
        lda $95937C,x
        and #$00FF
        bne _9375
        lda #$3540
        bra _9378


        _9375
        lda #$2940

        _9378
        jsr rsUnknown9594F8

        _937B
        rts

        .databank 0

        ; 95/937C

    .endsection Unsorted9590F2Section


    .section Unsorted95938CSection

      .al
      .xl

      rsUnknown95938C ; 95/938C

        .al
        .xl
        .autsiz
        .databank ?

        lda $0D65,b
        bne _9395
        jml _944A


        _9395
        lda $0D65,b
        bmi _93FA
        lda #$2940
        pha
        lda $0D62,b
        clc
        adc $0D65,b
        and #$FF00
        pha
        lda $0D62,b
        and #$FF00
        cmp #1,s
        beq _93BA
        lda #$000D
        jsl rlPlaySoundEffect

        _93BA
        pla
        lda $0D62,b
        clc
        adc $0D65,b
        bcc _93CD
        lda $0D64,b
        and #$00FF
        xba
        bra _93F0


        _93CD
        sta $0D62,b
        xba
        sep #$20
        cmp $0D64,b
        bcc _93E0
        lda $0D64,b
        xba
        lda #$00
        bra _93F0


        _93E0
        cmp $0D67,b
        bcc _93ED
        lda $0D67,b
        xba
        lda #$00
        bra _93F0


        _93ED
        xba
        bra _9441


        _93F0
        .al
        rep #$20
        sta $0D62,b
        stz $0D65,b
        bra _9446


        _93FA
        lda #$3540
        pha
        lda $0D65,b
        eor #$FFFF
        inc a
        sta wR0
        lda $0D62,b
        sec
        sbc wR0
        bcs _9415
        lda #$0000
        xba
        bra _942D


        _9415
        sta $0D62,b
        xba
        sep #$20
        cmp $0D67,b
        beq _9422
        bcs _942A

        _9422
        lda $0D67,b
        xba
        lda #$00
        bra _942D


        _942A
        xba
        bra _9441


        _942D
        rep #$20
        sta $0D62,b
        stz $0D65,b
        sep #$20
        lda #$10
        sta $7FE1C1
        rep #$20
        bra _9446


        _9441
        .as
        rep #$20
        sta $0D62,b

        _9446
        pla
        jsr rsUnknown959537

        _944A
        lda $7FE1C1
        and #$00FF
        beq _9473
        dec a
        sep #$20
        sta $7FE1C1
        rep #$20
        beq _946D
        tax
        lda $95937C,x
        and #$00FF
        bne _946D
        lda #$3540
        bra _9470


        _946D
        lda #$2940

        _9470
        jsr rsUnknown959537

        _9473
        rts

        .databank 0

        ; 95/9474

      rsUnknown959474 ; 95/9474

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown9594E0
        sta $0D57,b
        sep #$20
        lda $0D55,b
        clc
        adc wR0
        bcc _9487
        lda #$FF

        _9487
        sta $0D59,b
        rep #$20
        rts

        .databank 0

        ; 95/948D

      rsUnknown95948D ; 95/948D

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown9594E0
        eor #$FFFF
        inc a
        sta $0D57,b
        sep #$20
        lda $0D55,b
        sec
        sbc wR0
        bcs _94A4
        lda #$00

        _94A4
        sta $0D59,b
        rep #$20
        rts

        .databank 0

        ; 95/94AA

      rsUnknown9594AA ; 95/94AA

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown9594E0
        sta $0D65,b
        sep #$20
        lda $0D63,b
        clc
        adc wR0
        bcc _94BD
        lda #$FF

        _94BD
        sta $0D67,b
        rep #$20
        rts

        .databank 0

        ; 95/94C3

      rsUnknown9594C3 ; 95/94C3

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown9594E0
        eor #$FFFF
        inc a
        sta $0D65,b
        sep #$20
        lda $0D63,b
        sec
        sbc wR0
        bcs _94DA
        lda #$00

        _94DA
        sta $0D67,b
        rep #$20
        rts

        .databank 0

        ; 95/94E0

      rlUnknown9594E0 ; 95/94E0

        .al
        .xl
        .autsiz
        .databank ?

        phx
        cmp #$0000
        bne _94E9
        lda #$0001

        _94E9
        sta wR14
        lda wR0
        xba
        sta wR13
        jsl rlUnsignedDivide16By16R13
        lda wR13
        plx
        rtl

        .databank 0

        ; 95/94F8

    .endsection Unsorted95938CSection


    .section Unsorted9594F8Section

      .al
      .xl

      rsUnknown9594F8 ; 95/94F8

        .al
        .xl
        .autsiz
        .databank ?

        pha
        lda $0D50,b
        cmp #$0000
        bne _9504
        pla
        bra _9536


        _9504
        lda #$0002
        sta wR0
        lda #$2C00
        sta wR1
        lda $0D54,b
        xba
        and #$00FF
        ldx #$0A62
        jsl rlUnknown959576
        lda $0D55,b
        and #$00FF
        sta wR0
        lda $0D56,b
        and #$00FF
        sta wR1
        pla
        sta wR3
        ldx #$0A66
        jsl rlUnknown9597FA

        _9536
        rts

        .databank 0

        ; 95/9537

      rsUnknown959537 ; 95/9537

        .al
        .xl
        .autsiz
        .databank ?

        pha
        lda $0D5E,b
        cmp #$0000
        bne _9543
        pla
        bra _9575


        _9543
        lda #$0002
        sta wR0
        lda #$2400
        sta wR1
        lda $0D62,b
        xba
        and #$00FF
        ldx #$0A44
        jsl rlUnknown959576
        lda $0D63,b
        and #$00FF
        sta wR0
        lda $0D64,b
        and #$00FF
        sta wR1
        pla
        sta wR3
        ldx #$0A48
        jsl rlUnknown9597FA

        _9575
        rts

        .databank 0

        ; 95/9576

      rlUnknown959576 ; 95/9576

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        pha
        lda wR0
        and #$007F
        bne _9583
        pla
        bra _95C7


        _9583
        sta wR0
        dec a
        asl a
        pha
        txa
        clc
        adc #1,s
        tax
        pla
        pla
        bra _95A4


        _9591
        bit #$FFFF
        bne _95A4
        lda #$01FF
        ora wR1
        sta $7FC800,x
        lda #$0000
        bra _95C1


        _95A4
        sta wR13
        pha
        lda #$000A
        sta wR14
        phx
        jsl rlUnknown959C3E
        plx
        pla
        lda wR10
        clc
        adc #$0150
        ora wR1
        sta $7FC800,x
        lda wR13

        _95C1
        dec x
        dec x
        dec wR0
        bne _9591

        _95C7
        plx
        pla
        rtl

        .databank 0

        ; 95/95CA

    .endsection Unsorted9594F8Section


    .section Unsorted9595CASection

      .al
      .xl

      rlUnknown9595CA ; 95/95CA

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        cmp #$00FF
        bcc _95E5
        lda #$015A
        ora wR1
        sta $7FC804,x
        lda #$015A
        ora wR1
        sta $7FC802,x
        bra _964D


        _95E5
        cmp #$0064
        bne _95FE
        lda #$015C
        ora wR1
        sta $7FC804,x
        lda #$015B
        ora wR1
        sta $7FC802,x
        bra _964D


        _95FE
        pha
        lda wR0
        and #$007F
        bne _9609
        pla
        bra _964D


        _9609
        sta wR0
        dec a
        asl a
        pha
        txa
        clc
        adc #1,s
        tax
        pla
        pla
        bra _962A


        _9617
        bit #$FFFF
        bne _962A
        lda #$01FF
        ora wR1
        sta $7FC800,x
        lda #$0000
        bra _9647


        _962A
        sta wR13
        pha
        lda #$000A
        sta wR14
        phx
        jsl rlUnknown959C3E
        plx
        pla
        lda wR10
        clc
        adc #$0150
        ora wR1
        sta $7FC800,x
        lda wR13

        _9647
        dec x
        dec x
        dec wR0
        bne _9617

        _964D
        plx
        pla
        rtl

        .databank 0

        ; 95/9650

    .endsection Unsorted9595CASection


    .section Unsorted95968ESection

      .al
      .xl

      rlUnknown95968E ; 95/968E

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        pha
        lda wR0
        and #$007F
        bne _969B
        pla
        bra _96EB


        _969B
        sta wR0
        dec a
        asl a
        pha
        txa
        clc
        adc #1,s
        tax
        pla
        pla
        bra _96BC


        _96A9
        bit #$FFFF
        bne _96BC
        lda #$00FF
        ora wR1
        sta $7FC800,x
        lda #$0000
        bra _96E5


        _96BC
        sta wR13
        pha
        lda #$000A
        sta wR14
        phx
        jsl rlUnknown959C3E
        plx
        pla
        lda wR10
        clc
        adc #$0022
        ora wR1
        sta $7FC800,x
        lda wR10
        clc
        adc #$0032
        ora wR1
        sta $7FC840,x
        lda wR13

        _96E5
        dec x
        dec x
        dec wR0
        bne _96A9

        _96EB
        plx
        pla
        rtl

        .databank 0

        ; 95/96EE

      rlUnknown9596EE ; 95/96EE

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        pha
        lda wR0
        and #$007F
        bne _96FB
        pla
        bra _973F


        _96FB
        sta wR0
        dec a
        asl a
        pha
        txa
        clc
        adc #1,s
        tax
        pla
        pla
        bra _971C


        _9709
        bit #$FFFF
        bne _971C
        lda #$00FF
        ora wR1
        sta $7FC800,x
        lda #$0000
        bra _9739


        _971C
        sta wR13
        pha
        lda #$000A
        sta wR14
        phx
        jsl rlUnknown959C3E
        plx
        pla
        lda wR10
        clc
        adc #$0040
        ora wR1
        sta $7FC800,x
        lda wR13

        _9739
        dec x
        dec x
        dec wR0
        bne _9709

        _973F
        plx
        pla
        rtl

        .databank 0

        ; 95/9742

      rlUnknown959742 ; 95/9742

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        lda wR0
        beq _975C
        sta wR10
        lda wR2
        sta wR11
        jsl rlUnsignedMultiply16By16
        lda wR12+1
        and #$00FF
        bne _975A
        inc a

        _975A
        sta wR0

        _975C
        lda wR1
        beq _9774
        sta wR10
        lda wR2
        sta wR11
        jsl rlUnsignedMultiply16By16
        lda wR12+1
        and #$00FF
        bne _9772
        inc a

        _9772
        sta wR1

        _9774
        lda #$0006
        sta wR2
        lda wR0
        cmp #$0007
        bcc _9782
        lda wR2

        _9782
        pha
        clc
        adc #$0000
        clc
        adc wR3
        sta $7FC800,x
        inc x
        inc x
        lda wR0
        sec
        sbc #1,s
        sta wR0
        pla

        _9798
        lda wR2
        clc
        adc #$0008
        cmp wR1
        beq _97A4
        bcs _97C8

        _97A4
        sta wR2
        lda wR0
        cmp #$0009
        bcc _97B0
        lda #$0008

        _97B0
        pha
        clc
        adc #$0007
        clc
        adc wR3
        sta $7FC800,x
        inc x
        inc x
        lda wR0
        sec
        sbc #1,s
        sta wR0
        pla
        bra _9798


        _97C8
        lda wR1
        sec
        sbc wR2
        pha
        phx
        tax
        lda $98ACB8,x
        and #$00FF
        plx
        clc
        adc wR0
        clc
        adc #$0010
        ora wR3
        sta $7FC800,x
        pla
        cmp #$0007
        bne _97F7
        inc x
        inc x
        lda #$0034
        clc
        adc wR3
        sta $7FC800,x

        _97F7
        plx
        pla
        rtl

        .databank 0

        ; 95/97FA

    .endsection Unsorted95968ESection


    .section Unsorted9597FASection

      .al
      .xl

      rlUnknown9597FA ; 95/97FA

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        lda wR1
        cmp #$0050
        bcc _9808
        lda #$0050
        sta wR1

        _9808
        lda wR0
        cmp wR1
        bcc _9812
        lda wR1
        sta wR0

        _9812
        stz wR9

        _9814
        lda wR9
        cmp #$000A
        bcc _9831
        lda aUnknown959890
        and #$00FF
        clc
        adc wR3
        sta $7FC800,x
        txa
        sec
        sbc #$0054
        tax
        stz wR9

        _9831
        lda wR1
        cmp #$0004
        bcc _986D
        lda aUnknown959894
        and #$00FF
        pha
        lda wR0
        cmp #$0004
        bcc _9852
        sec
        sbc #$0004
        sta wR0
        lda #$0004
        bra _9854


        _9852
        stz wR0

        _9854
        clc
        adc #1,s
        clc
        adc wR3
        sta $7FC800,x
        pla
        lda wR1
        sec
        sbc #$0004
        sta wR1
        inc wR9
        inc x
        inc x
        bra _9814


        _986D
        phx
        tax
        cmp #$0000
        bne _987B
        lda wR9
        bne _987B
        plx
        bra _988D


        _987B
        lda aUnknown959890,x
        and #$00FF
        clc
        adc wR0
        plx
        clc
        adc wR3
        sta $7FC800,x

        _988D
        plx
        pla
        rtl

        .databank 0

        ; 95/9890

    .endsection Unsorted9597FASection


    .section Table959890Section

      .al
      .xl

      aUnknown959890 ; 95/9890

        ; Read by rlUnknown9597FA.

        .word $0C0E, $0509

        ; 95/9894

    .endsection Table959890Section


    .section Unsorted959895Section

      .al
      .xl

      rsUnknown959895 ; 95/9895

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        phy
        ldy #$0000
        ldx #$0000
        lda #$000A

        _98A1
        pha
        cmp #$0006
        bcc _98AC
        lda #$2C00
        bra _98AF


        _98AC
        lda #$2400

        _98AF
        sta wR1
        lda #$0002
        sta wR0
        lda $98AC86,x
        inc x
        inc x
        pha
        lda $98AC86,x
        sta lR18
        inc x
        lda $98AC86,x
        sta lR18+1
        inc x
        inc x
        pla
        phx
        tax
        lda [lR18],y
        cmp #$0064
        bcc _98DA
        inc wR0
        dec x
        dec x

        _98DA
        jsl rlUnknown9595CA
        plx
        pla
        dec a
        bne _98A1
        ply
        plx
        pla
        rts

        .databank 0

        ; 95/98E7

    .endsection Unsorted959895Section


    .section Unsorted9598E7Section

      .al
      .xl

      rlUnknown9598E7 ; 95/98E7

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        phy
        lda #$7F00
        sta lR18+1
        lda #$D204
        sta lR18
        ldy #$6D02
        lda #$0078
        jsl rlUnknown95C43E
        ply
        plx
        pla
        rtl

        .databank 0

        ; 95/9902

    .endsection Unsorted9598E7Section


    .section Unsorted959902Section

      .al
      .xl

      rlUnknown959902 ; 95/9902

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        rep #$10
        ldx #$2EBD
        stx DecompressionVariables
        lda #$E0
        sta $CA
        ldx #$8B88
        stx $CB
        lda #$7E
        sta $CD
        jsl rlDecompressor
        rep #$30
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $0400, $80, $FC00

        sep #$20
        rep #$10
        ldx #$3539
        stx DecompressionVariables
        lda #$E0
        sta $CA
        ldx #$8B88
        stx $CB
        lda #$7E
        sta $CD
        jsl rlDecompressor
        rep #$30
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $0400, $80, $F400

        jsl rlUnknown9680C2
        sep #$20
        rep #$10
        ldx #$3A1D
        stx DecompressionVariables
        lda #$E0
        sta $CA
        ldx #$C800
        stx $CB
        lda #$7F
        sta $CD
        jsl rlDecompressor
        rep #$30
        lda #$7F00
        sta lR18+1
        lda #$C800
        sta lR18
        lda #$00FF
        jsl rlUnknown959B49
        jsl rlDMAByStruct

          .structDMAToVRAM $7FC800, $03C0, $80, $D000

        sep #$20
        rep #$10
        ldx #$3C68
        stx DecompressionVariables
        lda #$E0
        sta $CA
        ldx #$D0C0
        stx $CB
        lda #$7F
        sta $CD
        jsl rlDecompressor
        rep #$30
        jsr rsUnknown959895
        lda #$7F00
        sta lR18+1
        lda #$D0C0
        sta lR18
        lda #$01FF
        jsl rlUnknown959B49
        lda #$2940
        jsr rsUnknown9594F8
        lda #$2940
        jsr rsUnknown959537
        jsl rlUnknown9599E7
        jsl rlUnknown9699DD
        jsl rlDMAByStruct

          .structDMAToVRAM $7FD0C0, $03C0, $80, $D8C0

        jsr rsUnknown959A4D
        rtl

        .databank 0

        ; 95/99E7

    .endsection Unsorted959902Section


    .section Unsorted9599E7Section

      .al
      .xl

      rlUnknown9599E7 ; 95/99E7

        .al
        .autsiz
        .databank ?

        lda #$2940
        jsr rsUnknown9594F8

        lda #$2940
        jsr rsUnknown959537

        ldx #2
        
          -
          lda aUnknownE00060,x
          sta $0100,b,x
          inc x
          inc x
          cpx #32
          bcc -

        lda wBattleType
        and #$00FF
        cmp #$00FF
        bne +

        lda aActionStructUnit1.UnitRAMPointer
        bra ++
        
        +
        lda aActionStructUnit1.UnitRAMPointer
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitFactionSlot
        jsl rlGetFactionBattleHUDColorID

        +
        jsr rsUnknown959B84

        lda wBattleType
        and #$00FF
        cmp #$00FF
        bne +

        lda aActionStructUnit2.UnitRAMPointer
        bra ++
        
        +
        lda aActionStructUnit2.UnitRAMPointer
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitFactionSlot
        jsl rlGetFactionBattleHUDColorID
        
        +
        jsr rsUnknown959BC1
        rtl

        .databank 0

      rsUnknown959A4D ; 95/9A4D

        .al
        .autsiz
        .databank ?

        sep #$20
        rep #$10
        ldx #$EAEE
        stx DecompressionVariables.lSource
        lda #$9C
        sta DecompressionVariables.lSource+2
        ldx #<>aDecompressionBuffer
        stx $CB
        lda #`aDecompressionBuffer
        sta $CD
        jsl rlDecompressor
        rep #$30

        lda wBattleType
        and #$00FF
        cmp #$00FF
        bne +

        lda aActionStructUnit1.XPosition
        bra ++
        
        +
        lda aActionStructUnit1.UnitRAMPointer
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitFactionSlot
        jsl rlGetFactionBattleBannerID
        
        +
        asl a
        pha
        asl a
        clc
        adc #1,s
        tax
        pla

        lda aBattleBannerTable+1,x
        sta lR45+1
        lda aBattleBannerTable,x
        sta lR45
        lda #(`$7FC200)<<8
        sta lR47+1
        lda #<>$7FC200
        sta lR47
        phx
        jsl rlDecompressSingle
        plx

        lda aBattleBannerTable+3+1,x
        sta lR18+1
        lda aBattleBannerTable+3,x
        sta lR18
        ldx #0
        ldy #0
        
        -
        lda [lR18],y
        sta $01D2,b,x
        sta $7FC1F0,x
        inc y
        inc y
        inc x
        inc x
        cpx #14
        bcc -

        lda wBattleType
        and #$00FF
        cmp #$00FF
        bne +

        lda aActionStructUnit2.XPosition
        bra ++
        
        +
        lda aActionStructUnit2.UnitRAMPointer
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitFactionSlot
        jsl rlGetFactionBattleBannerID
        
        +
        asl a
        pha
        asl a
        clc
        adc #1,s
        tax
        pla

        lda aBattleBannerTable+1,x
        sta lR45+1
        lda aBattleBannerTable,x
        sta lR45
        lda #(`$7FC000)<<8
        sta lR47+1
        lda #<>$7FC000
        sta lR47
        phx
        jsl rlDecompressSingle
        plx

        lda aBattleBannerTable+3+1,x
        sta lR18+1
        lda aBattleBannerTable+3,x
        sta lR18

        ldx #0
        ldy #0
        
        -
        lda [lR18],y
        sta $01F2,b,x
        sta $7FC3F0,x
        inc y
        inc y
        inc x
        inc x
        cpx #14
        bcc -

        jsl rlDMAByStruct

          .structDMAToVRAM $7FC000, $0400, $80, $F000

        rts

        .databank 0

        ; 95/9B49

    .endsection Unsorted9599E7Section


    .section Unsorted959B49Section

      .al
      .xl

      rlUnknown959B49 ; 95/9B49

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        pha
        lda $0D50,b
        cmp #$0000
        beq _9B5E
        lda $0D5E,b
        cmp #$0000
        beq _9B63
        bra _9B80


        _9B5E
        ldy #$0020
        bra _9B66


        _9B63
        ldy #$0000

        _9B66
        lda #$000A

        _9B69
        pha
        ldx #$0010
        lda #3,s

        _9B6F
        sta [lR18],y
        inc y
        inc y
        dec x
        bne _9B6F
        tya
        clc
        adc #$0020
        tay
        pla
        dec a
        bne _9B69

        _9B80
        pla
        ply
        plx
        rtl

        .databank 0

        ; 95/9B84

    .endsection Unsorted959B49Section


    .section Unsorted959B84Section

      .al
      .xl

      rsUnknown959B84 ; 95/9B84

        .al
        .autsiz
        .databank ?

        phx
        phy
        and #$00FF
        asl a
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

        ldy #0

          -
          lda aUnknown998944,x
          sta $01C2,b,y
          inc x
          inc x
          inc y
          inc y
          cpy #16
          bcc -

        ldy #0
        
          -
          lda aUnknown998944,x
          sta $011A,b,y
          inc x
          inc x
          inc y
          inc y
          cpy #6
          bcc -

        ply
        plx
        rts

        .databank 0

        ; 95/9BC1

    .endsection Unsorted959B84Section


    .section Unsorted959BC1Section

      .al
      .xl

      rsUnknown959BC1 ; 95/9BC1

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        and #$00FF
        asl a
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

        _9BD8
        lda aUnknown998944,x
        sta $01E2,b,y
        inc x
        inc x
        inc y
        inc y
        cpy #$0010
        bcc _9BD8
        ldy #$0000

        _9BEB
        lda aUnknown998944,x
        sta $010A,b,y
        inc x
        inc x
        inc y
        inc y
        cpy #$0006
        bcc _9BEB
        ply
        plx
        rts

        .databank 0

        ; 95/9BFE

    .endsection Unsorted959BC1Section


    .section Unsorted959C14Section

      .al
      .xl

      rsUnknown959C14 ; 95/9C14

        .al
        .xl
        .autsiz
        .databank ?

        pha
        lda $7FED5A
        beq _9C29
        cmp #$0001
        beq _9C30
        lda $7FED5A
        dec a
        sta $7FED5A

        _9C29
        lda wJoy1New
        bit #$8000
        beq _9C3C

        _9C30
        sep #$20
        lda $0AE0,b
        and #$F7
        sta $0AE0,b
        rep #$20

        _9C3C
        pla
        rts

        .databank 0

        ; 95/9C3E

    .endsection Unsorted959C14Section


    .section Unsorted959C3ESection

      .al
      .xl

      rlUnknown959C3E ; 95/9C3E

        .al
        .xl
        .autsiz
        .databank ?

        php
        pha
        phx
        lda wR13
        sta $4204,b
        sep #$20
        lda wR14
        sta $4206,b
        rep #$20
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        lda $4214,b
        sta wR13
        lda $4216,b
        sta wR10
        plx
        pla
        plp
        rtl

        .databank 0

        ; 95/9C64

    .endsection Unsorted959C3ESection


    .section Unsorted959C64Section

      .al
      .xl

      rsUnknown959C64 ; 95/9C64

        .al
        .xl
        .autsiz
        .databank ?

        php
        lda $0AE4,b
        bit #$0080
        beq _9C90
        lda $0AE0,b
        bit #$0020
        bne _9C90
        lda $0AE8,b
        bit #$0080
        beq _9C80
        clc
        bra _9C81


        _9C80
        sec

        _9C81
        jsr rsUnknown959C92
        sep #$20
        lda $0AE0,b
        ora #$20
        sta $0AE0,b
        rep #$20

        _9C90
        plp
        rts

        .databank 0

        ; 95/9C92

      rsUnknown959C92 ; 95/9C92

        .al
        .xl
        .autsiz
        .databank ?

        bcs _9CBA
        sep #$20
        lda #$20
        sta $7FE191
        lda $0AF3,b
        and #$FE
        sta $0AF3,b
        lda $0B26,b
        bit #$08
        bne _9CAF
        lda #$81
        bra _9CB1


        _9CAF
        lda #$C1

        _9CB1
        sta $7FE192
        rep #$20
        clc
        bra _9CDE


        _9CBA
        sep #$20
        lda #$20
        sta $7FE193
        lda $0B36,b
        and #$FE
        sta $0B36,b
        lda $0B69,b
        bit #$08
        bne _9CD5
        lda #$81
        bra _9CD7


        _9CD5
        lda #$C1

        _9CD7
        sta $7FE194
        rep #$20
        sec

        _9CDE
        rts

        .databank 0

        ; 95/9CDF

      rlUnknown959CDF ; 95/9CDF

        .al
        .xl
        .autsiz
        .databank ?

        bcs _9CED
        sep #$20
        lda #$19
        sta $7FE195
        rep #$20
        bra _9CF7


        _9CED
        sep #$20
        lda #$19
        sta $7FE196
        rep #$20

        _9CF7
        rtl

        .databank 0

        ; 95/9CF8

      rsUnknown959CF8 ; 95/9CF8

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7FE195
        bne _9D03
        jml _9DAA


        _9D03
        and #$00FF
        beq _9D23
        dec a
        sep #$20
        sta $7FE195
        rep #$20
        asl a
        tax
        lda $98B3BA,x
        sta $2181,b
        sep #$20
        lda #$01
        sta $2183,b
        bra _9D43


        _9D23
        .al
        lda $7FE196
        and #$00FF
        dec a
        sep #$20
        sta $7FE196
        rep #$20
        asl a
        tax
        lda $98B3EC,x
        sta $2181,b
        sep #$20
        lda #$01
        sta $2183,b

        _9D43
        ldx #$0000

        _9D46
        lda $2180,b
        sta $0282,b,x
        lda $2180,b
        sta $0283,b,x
        lda $2180,b
        sta $02A2,b,x
        lda $2180,b
        sta $02A3,b,x
        lda $2180,b
        sta $02C2,b,x
        lda $2180,b
        sta $02C3,b,x
        lda $2180,b
        sta $02E2,b,x
        lda $2180,b
        sta $02E3,b,x
        inc x
        inc x
        cpx #$0012
        bcc _9D46

        _9D7D
        lda $2180,b
        sta $0282,b,x
        lda $2180,b
        sta $0283,b,x
        lda $2180,b
        sta $02A2,b,x
        lda $2180,b
        sta $02A3,b,x
        lda $2180,b
        sta $02C2,b,x
        lda $2180,b
        sta $02C3,b,x
        inc x
        inc x
        cpx #$001E
        bcc _9D7D
        rep #$20

        _9DAA
        plx
        rts

        .databank 0

        ; 95/9DAC

    .endsection Unsorted959C64Section


    .section Unsorted959DACSection

      .al
      .xl

      rlUnknown959DAC ; 95/9DAC

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        phy
        sty wR0
        asl a
        tax
        phx

        _9DB4
        lda aBGPaletteBuffer,b,x
        bit #$001F
        beq _9DE3
        bit #$03E0
        beq _9DD2
        bit #$7C00
        beq _9DCC
        sec
        sbc #$0421
        bra _9E02


        _9DCC
        sec
        sbc #$0021
        bra _9E02


        _9DD2
        bit #$7C00
        beq _9DDD
        sec
        sbc #$0401
        bra _9E02


        _9DDD
        sec
        sbc #$0001
        bra _9E02


        _9DE3
        bit #$03E0
        beq _9DF9
        bit #$7C00
        beq _9DF3
        sec
        sbc #$0420
        bra _9E02


        _9DF3
        sec
        sbc #$0020
        bra _9E02


        _9DF9
        bit #$7C00
        beq _9E02
        sec
        sbc #$0400

        _9E02
        sta aBGPaletteBuffer,b,x
        inc x
        inc x
        dec y
        bne _9DB4
        plx
        ldy #$0000

        _9E0E
        lda aBGPaletteBuffer,b,x
        bne _9E1D
        inc x
        inc x
        inc y
        cpy wR0
        bcc _9E0E
        sec
        bra _9E1E


        _9E1D
        clc

        _9E1E
        ply
        plx
        pla
        rtl

        .databank 0

        ; 95/9E22

    .endsection Unsorted959DACSection


    .section Unsorted959F43Section

      .al
      .xl

      rlUnknown959F43 ; 95/9F43

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        phy
        asl a
        tax
        phx
        tya
        asl a
        sta wR0
        ldy #$0000

        _9F50
        lda aBGPaletteBuffer,b,x
        pha
        and #$001F
        pha
        lda [lR18],y
        and #$001F
        cmp #1,s
        beq _9F73
        bcs _9F6B
        pla
        pla
        sec
        sbc #$0001
        bra _9F75


        _9F6B
        pla
        pla
        clc
        adc #$0001
        bra _9F75


        _9F73
        pla
        pla

        _9F75
        pha
        and #$03E0
        pha
        lda [lR18],y
        and #$03E0
        cmp #1,s
        beq _9F95
        bcs _9F8D
        pla
        pla
        sec
        sbc #$0020
        bra _9F97


        _9F8D
        pla
        pla
        clc
        adc #$0020
        bra _9F97


        _9F95
        pla
        pla

        _9F97
        pha
        and #$7C00
        pha
        lda [lR18],y
        and #$7C00
        cmp #1,s
        beq _9FB7
        bcs _9FAF
        pla
        pla
        sec
        sbc #$0400
        bra _9FB9


        _9FAF
        pla
        pla
        clc
        adc #$0400
        bra _9FB9


        _9FB7
        pla
        pla

        _9FB9
        sta aBGPaletteBuffer,b,x
        inc x
        inc x
        inc y
        inc y
        cpy wR0
        bcc _9F50
        plx
        ldy #$0000

        _9FC8
        lda aBGPaletteBuffer,b,x
        and #$7FFF
        pha
        lda [lR18],y
        and #$7FFF
        cmp #1,s
        bne _9FE4
        pla
        inc x
        inc x
        inc y
        inc y
        cpy wR0
        bcc _9FC8
        sec
        bra _9FE6


        _9FE4
        pla
        clc

        _9FE6
        ply
        plx
        pla
        rtl

        .databank 0

        ; 95/9FEA

    .endsection Unsorted959F43Section


    .section Unsorted95A086Section

      .al
      .xl

      rlUnknown95A086 ; 95/A086

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        phy
        ldy #$0008
        ldx #$0000

        _A08F
        lda $7FE441,x
        cmp #$FFFF
        beq _A0BD
        phx
        phy
        pha
        lda $7FE445,x
        tay
        lda $7FE443,x
        tax
        pla
        phb
        .byte $54, $7F, $7F ; mvn from bank $7F to bank $7F
        plb
        .databank ?
        ply
        plx
        lda #$FFFF
        sta $7FE441,x
        txa
        clc
        adc #$0006
        tax
        dec y
        bne _A08F

        _A0BD
        ply
        plx
        pla
        rtl

        .databank 0

        ; 95/A0C1

      rlUnknown95A0C1 ; 95/A0C1

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        pha
        ldy #$0008
        ldx #$0000

        _A0CA
        lda $7FE441,x
        cmp #$FFFF
        bne _A0E9
        lda #1,s
        dec a
        sta $7FE441,x
        lda wR0
        sta $7FE445,x
        lda wR1
        sta $7FE443,x
        clc
        bra _A0F3


        _A0E9
        txa
        clc
        adc #$0006
        tax
        dec y
        bne _A0CA
        sec

        _A0F3
        pla
        plx
        ply
        rtl

        .databank 0

        ; 95/A0F7

    .endsection Unsorted95A086Section


    .section Unsorted95A0F7Section

      .al
      .xl

      rlUnknown95A0F7 ; 95/A0F7

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        phy
        ldy #$0008
        ldx #$0000

        _A100
        lda #$FFFF
        sta $7FE441,x
        txa
        clc
        adc #$0006
        tax
        dec y
        bne _A100
        ply
        plx
        pla
        rtl

        .databank 0

        ; 95/A114

    .endsection Unsorted95A0F7Section


    .section Unsorted95A114Section

      .al
      .xl

      rsUnknown95A114 ; 95/A114

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        phy
        sep #$20
        ldx #$0000
        lda #$0F
        sta $7FE33A,x
        inc x
        lda $0ADD,b
        sta $7FE33A,x
        inc x
        lda #$70
        sta $7FE33A,x
        inc x
        lda $7FE4DD
        bit #$80
        beq _A13E
        lda bBufferINIDISP
        bra _A142


        _A13E
        lda $7FE4DD

        _A142
        sta $7FE33A,x
        inc x
        lda #$00
        sta $7FE33A,x
        rep #$20
        lda #$E33A
        sta wR1
        lda #$E36A
        sta wR0
        lda #$0030
        jsl rlUnknown95A0C1
        ply
        plx
        pla
        rts

        .databank 0

        ; 95/A164

      rlUnknown95A164 ; 95/A164

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 95/A165

      rlUnknown95A165 ; 95/A165

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 95/A166

    .endsection Unsorted95A114Section


    .section Unsorted95A167Section

      .al
      .xl

      rlUnknown95A167 ; 95/A167

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        php
        pha
        ldx #$0000

        _A16E
        lda $998DF8,x
        cmp #$FFFF
        beq _A1C1
        cmp #1,s
        beq _A180
        inc x
        inc x
        inc x
        bra _A16E


        _A180
        pla
        lda $998DFA,x
        and #$00FF
        asl a
        pha
        asl a
        clc
        adc #1,s
        tax
        pla
        plp
        bcs _A1AA
        lda $E0017C,x
        sta $0218,b
        lda $E0017E,x
        sta $021A,b
        lda $E00180,x
        sta $021C,b
        bra _A1C3


        _A1AA
        lda $E0017C,x
        sta $0298,b
        lda $E0017E,x
        sta $029A,b
        lda $E00180,x
        sta $029C,b
        bra _A1C3


        _A1C1
        pla
        plp

        _A1C3
        ply
        plx
        rtl

        .databank 0

        ; 95/A1C6

      rlUnknown95A1C6 ; 95/A1C6

        .al
        .xl
        .autsiz
        .databank ?

        lda $0D52,b
        jsl rlUnknown95A1ED
        bcc _A1D2
        lda #$0090

        _A1D2
        sep #$20
        sta $0D5B,b
        rep #$20
        lda $0D60,b
        jsl rlUnknown95A1ED
        bcc _A1E5
        lda #$0090

        _A1E5
        sep #$20
        sta $0D69,b
        rep #$20
        rtl

        .databank 0

        ; 95/A1ED

      rlUnknown95A1ED ; 95/A1ED

        ; Reads the stack above its return address, but in the emulator log every
        ; caller continues right after the call: no inline arguments.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        inc a
        cmp #$007F
        bcs _A244
        tax
        lda $9983B9,x
        and #$00FF
        cmp #$00FF
        beq _A244
        pha
        and #$00F0
        cmp #$0040
        beq _A214
        cmp #$0050
        beq _A214
        cmp #$0060
        bne _A240

        _A214
        lda @l $000D48
        and #$00FF
        cmp #$0002
        bcc _A22C
        lda #1,s
        and #$00F0
        ora #$0004
        sta #1,s
        bra _A240


        _A22C
        lda #1,s
        and #$000F
        pha
        lda #3,s
        and #$00F0
        sec
        sbc #$0040
        ora #1,s
        sta #3,s
        pla

        _A240
        pla
        clc
        bra _A245


        _A244
        sec

        _A245
        plx
        rtl

        .databank 0

        ; 95/A247

      rlUnknown95A247 ; 95/A247

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda $0D5C,b
        sta $7FE1B6
        lda $0D69,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta $7FE1B7
        lda $0D5E,b
        sta $7FE1B8
        lda $0D68,b
        sta $7FE1B9
        rep #$20
        jsl rlUnknown95A2C8
        bcc _A27F
        sep #$20
        lda $0D69,b
        and #$0F
        ora #$90
        sta $0D69,b
        rep #$20

        _A27F
        lda $7FE1B6
        sta $7FE1BA
        lda $7FE1B8
        sta $7FE1BC
        sep #$20
        lda $0D4E,b
        sta $7FE1B6
        lda $0D5B,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta $7FE1B7
        lda $0D50,b
        sta $7FE1B8
        lda $0D5A,b
        sta $7FE1B9
        rep #$20
        jsl rlUnknown95A2C8
        bcc _A2C7
        sep #$20
        lda $0D5B,b
        and #$0F
        ora #$90
        sta $0D5B,b
        rep #$20

        _A2C7
        rtl

        .databank 0

        ; 95/A2C8

      rlUnknown95A2C8 ; 95/A2C8

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        jsl rlUnknown95A3C1
        bcc _A2D5
        clc
        jml _A3BC


        _A2D5
        sep #$20
        ldx #$0000
        ldy #$0000

        _A2DD
        lda $7FE1B6
        cmp $9788C9,x
        beq _A2F2
        cpy #$0001
        bcc _A2F0
        jml _A378


        _A2F0
        bra _A344


        _A2F2
        cpy #$0001
        bcs _A2FA
        ldy #$0001

        _A2FA
        lda $7FE1B9
        cmp $9788CC,x
        beq _A30B
        cpy #$0002
        bcs _A378
        bra _A344


        _A30B
        cpy #$0002
        bcs _A313
        ldy #$0002

        _A313
        lda $9788CB,x
        cmp #$00
        beq _A32C
        lda $7FE1B8
        cmp $9788CB,x
        beq _A32C
        cpy #$0003
        bcs _A378
        bra _A344


        _A32C
        cpy #$0003
        bcs _A334
        ldy #$0003

        _A334
        lda $7FE1B7
        cmp #$09
        beq _A355
        cmp $9788CA,x
        bne _A344
        bra _A355


        _A344
        rep #$20
        txa
        clc
        adc #$0008
        tax
        sep #$20
        cpx #$0670
        bcc _A2DD
        bra _A39B


        _A355
        lda $9788CD,x
        sta $7FE1B6
        lda $9788CE,x
        sta $7FE1B7
        lda $9788CF,x
        sta $7FE1B8
        lda $9788D0,x
        sta $7FE1B9
        clc
        bra _A3BC


        _A378
        lda $9788C5,x
        sta $7FE1B6
        lda $9788C6,x
        sta $7FE1B7
        lda $9788C7,x
        sta $7FE1B8
        lda $9788C8,x
        sta $7FE1B9
        sec
        bra _A3BC


        _A39B
        lda $9788CD
        sta $7FE1B6
        lda $9788CE
        sta $7FE1B7
        lda $9788CF
        sta $7FE1B8
        lda $9788D0
        sta $7FE1B9
        sec

        _A3BC
        rep #$20
        ply
        plx
        rtl

        .databank 0

        ; 95/A3C1

      rlUnknown95A3C1 ; 95/A3C1

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda $7FE1B6
        and #$00FF
        cmp #$0032
        bne _A3D8
        lda $7FFC59
        bit #$0004
        bne _A3DB

        _A3D8
        clc
        bra _A3F8


        _A3DB
        sep #$20
        lda #$5E
        sta $7FE1B6
        lda #$66
        sta $7FE1B7
        lda #$46
        sta $7FE1B8
        lda #$2E
        sta $7FE1B9
        rep #$20
        sec

        _A3F8
        ply
        plx
        rtl

        .databank 0

        ; 95/A3FB

    .endsection Unsorted95A167Section


    .section Unsorted95A414Section

      .al
      .xl

      rlUnknown95A414 ; 95/A414

        .al
        .xl
        .autsiz
        .databank ?

        lda #$9500
        sta lR44+1
        lda #$E6EA
        sta lR44
        lda #$0004
        sta wR40
        jsl rlHDMAEngineCreateEntryByIndex
        rtl

        .databank 0

        ; 95/A428

      rlUnknown95A428 ; 95/A428

        .al
        .xl
        .autsiz
        .databank ?

        lda #$9500
        sta lR44+1
        lda #$E6D2
        sta lR44
        lda #$0007
        sta wR40
        jsl rlHDMAEngineCreateEntryByIndex
        rtl

        .databank 0

        ; 95/A43C

      rlUnknown95A43C ; 95/A43C

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$00
        sta $7FFC56
        sta $7FFC57
        sta $7FFC58
        rep #$20
        rtl

        .databank 0

        ; 95/A44F

      rlUnknown95A44F ; 95/A44F

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$80
        sta $7FFC56
        rep #$20
        rtl

        .databank 0

        ; 95/A45A

      rlUnknown95A45A ; 95/A45A

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$CF
        sta $7FFC56
        rep #$20
        lda $7E4EA9
        and #$00FF
        cmp #$00FF
        beq _A480
        lda $7FFC9D
        and #$00FF
        beq _A480
        lda #$00E0
        jsl rlSendSoundCommand

        _A480
        rtl

        .databank 0

        ; 95/A481

    .endsection Unsorted95A414Section


    .section Unsorted95A481Section

      .al
      .xl

      rlUnknown95A481 ; 95/A481

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FFC56
        bit #$0080
        bne _A48E
        jml _A52C


        _A48E
        bit #$0040
        bne _A4D2
        lda $7FFC56
        and #$000F
        cmp #$000F
        bcc _A4AF
        sep #$20
        lda $7FFC56
        and #$7F
        sta $7FFC56
        rep #$20
        bra _A52C


        _A4AF
        sep #$20
        lda $7FFC56
        inc a
        pha
        lda $7FFC56
        and #$F0
        ora #1,s
        sta $7FFC56
        pla
        and #$0F
        sta $7FE4DD
        sta $7FE4D5
        rep #$20
        bra _A52C


        _A4D2
        lda $7FFC58
        and #$00FF
        beq _A4E6
        sep #$20
        dec a
        sta $7FFC58
        rep #$20
        bra _A52C


        _A4E6
        sep #$20
        lda $7FFC57
        sta $7FFC58
        rep #$20
        lda $7FFC56
        and #$000F
        bne _A50B
        sep #$20
        lda $7FFC56
        and #$7F
        sta $7FFC56
        rep #$20
        bra _A52C


        _A50B
        sep #$20
        lda $7FFC56
        dec a
        pha
        lda $7FFC56
        and #$F0
        ora #1,s
        sta $7FFC56
        pla
        and #$0F
        sta $7FE4DD
        sta $7FE4D5
        rep #$20

        _A52C
        rtl

        .databank 0

        ; 95/A52D

      rlUnknown95A52D ; 95/A52D

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$80
        sta bBufferINIDISP
        sta $7FE4DD
        sta $7FE4D5
        rep #$20
        rtl

        .databank 0

        ; 95/A53E

    .endsection Unsorted95A481Section


    .section Unsorted95A53ESection

      .al
      .xl

      rlUnknown95A53E ; 95/A53E

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta $7FFC59
        lda wBattleDistance
        cmp #$0002
        bcs _A565
        lda $7E4EA9
        and #$00FF
        cmp #$0002
        beq _A565
        lda $7FFC59
        ora #$0001
        sta $7FFC59

        _A565
        lda $7E4EA9
        and #$00FF
        cmp #$0002
        bne _A57C
        lda $7FFC59
        ora #$0002
        sta $7FFC59

        _A57C
        lda aActionStructUnit1.Unknown
        cmp #$0008
        bne _A593
        lda $7FFC59
        ora #$0004
        ora #$0008
        sta $7FFC59

        _A593
        lda aActionStructUnit1.WeaponID
        jsr rsUnknown95A5E4
        bcc _A5A7
        lda $7FFC59
        ora #$0080
        sta $7FFC59

        _A5A7
        lda aActionStructUnit2.WeaponID
        jsr rsUnknown95A5E4
        bcc _A5BB
        lda $7FFC59
        ora #$0040
        sta $7FFC59

        _A5BB
        lda aActionStructUnit1.WeaponID
        jsr rsUnknown95A62A
        bcc _A5CF
        lda $7FFC59
        ora #$0100
        sta $7FFC59

        _A5CF
        lda aActionStructUnit2.WeaponID
        jsr rsUnknown95A62A
        bcc _A5E3
        lda $7FFC59
        ora #$0200
        sta $7FFC59

        _A5E3
        rtl

        .databank 0

        ; 95/A5E4

      rsUnknown95A5E4 ; 95/A5E4

        .al
        .xl
        .autsiz
        .databank ?

        cmp #$0015
        beq _A628
        cmp #$0014
        beq _A628
        cmp #$0016
        beq _A628
        cmp #$0023
        beq _A628
        cmp #$0024
        beq _A628
        cmp #$002C
        beq _A628
        cmp #$0036
        beq _A628
        cmp #$0041
        beq _A628
        cmp #$0046
        beq _A628
        cmp #$004B
        beq _A628
        cmp #$0054
        beq _A628
        cmp #$0050
        beq _A628
        cmp #$0062
        beq _A628
        clc
        bra _A629


        _A628
        sec

        _A629
        rts

        .databank 0

        ; 95/A62A

      rsUnknown95A62A ; 95/A62A

        .al
        .xl
        .autsiz
        .databank ?

        phx
        pha
        ldx #$0000

        _A62F
        lda $998F02,x
        cmp #$FFFF
        beq _A642
        and #$00FF
        cmp #1,s
        beq _A645
        inc x
        bra _A62F


        _A642
        clc
        bra _A646


        _A645
        sec

        _A646
        pla
        plx
        rts

        .databank 0

        ; 95/A649

      rlUnknown95A649 ; 95/A649

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FFC59
        bit #$0002
        beq _A657
        lda #$0070
        bra _A65A


        _A657
        lda #$0064

        _A65A
        sta $7FFC5B
        rtl

        .databank 0

        ; 95/A65F

    .endsection Unsorted95A53ESection


    .section Unsorted95A65FSection

      .al
      .xl

      rlUnknown95A65F ; 95/A65F

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown95A66A
        bcs _A669
        jsr rsUnknown95A761
        bcs _A669

        _A669
        rtl

        .databank 0

        ; 95/A66A

      rsUnknown95A66A ; 95/A66A

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FE144
        cmp #$FFFF
        beq _A677
        jml _A75F


        _A677
        lda $7FE164
        cmp #$FFFF
        beq _A684
        jml _A75F


        _A684
        lda $0AF3,b
        bit #$0020
        beq _A694
        lda $0AF4,b
        bit #$0040
        bne _A6A0

        _A694
        lda $0AF3,b
        bit #$0001
        beq _A6A0
        jml _A75F


        _A6A0
        lda $0B08,b
        ora $0B0E,b
        ora $0B13,b
        beq _A6AF
        jml _A75F


        _A6AF
        lda $0B36,b
        bit #$0020
        beq _A6BF
        lda $0B37,b
        bit #$0040
        bne _A6CB

        _A6BF
        lda $0B36,b
        bit #$0001
        beq _A6CB
        jml _A75F


        _A6CB
        lda $0B4B,b
        ora $0B51,b
        ora $0B56,b
        beq _A6DA
        jml _A75F


        _A6DA
        lda $0B79,b
        bit #$0080
        beq _A6F5
        lda $0B79,b
        bit #$0001
        bne _A75F
        lda $0B8E,b
        ora $0B94,b
        ora $0B99,b
        bne _A75F

        _A6F5
        lda $0BBC,b
        bit #$0080
        beq _A710
        lda $0BBC,b
        bit #$0001
        bne _A75F
        lda $0BD1,b
        ora $0BD7,b
        ora $0BDC,b
        bne _A75F

        _A710
        lda $0AF1,b
        and #$003F
        bne _A75F
        lda $7FFD9A
        bit #$0080
        beq _A75F
        lda $7FFDA4
        bit #$0080
        beq _A75F
        lda $7FE195
        bne _A75F
        lda $0D57,b
        ora $0D65,b
        bne _A75F
        lda $7FE1A6
        and #$00FF
        bne _A75F
        lda $7FE4B7
        bit #$0080
        bne _A75F
        lda $7FFC5D
        bit #$0001
        bne _A75F
        lda $7FE187
        bit #$0007
        bne _A75F
        clc
        bra _A760


        _A75F
        sec

        _A760
        rts

        .databank 0

        ; 95/A761

      rsUnknown95A761 ; 95/A761

        .al
        .xl
        .autsiz
        .databank ?

        lda $0AE2,b
        sta lR18+1
        lda $0AE1,b
        sec
        sbc #$0002
        sta lR18
        ldy #$0002
        lda [lR18],y
        cmp #$00FD
        bne _A792
        lda $0AE1,b
        clc
        adc #$0002
        sta $0AE1,b
        lda $0AE3,b
        adc #$0000
        sep #$20
        sta $0AE3,b
        rep #$20
        bra rsUnknown95A761


        _A792
        sep #$20
        cmp #$FE
        bne _A7A2
        rep #$20
        jsl rlUnknown96F697
        jml _AA53


        _A7A2
        .as
        rep #$20
        ldy #$0000
        lda $0AE0,b
        bit #$0002
        beq _A7B3
        jml _AA8C


        _A7B3
        lda $0AE0,b
        bit #$0020
        bne _A7D7
        lda [lR18],y
        bit #$0080
        bne _A7D7
        bit #$0010
        beq _A7D7
        sep #$20
        lda $0AE4,b
        ora #$80
        sta $0AE4,b
        rep #$20
        jml _AA8C


        _A7D7
        inc lR18
        ldy #$0002
        sep #$20
        lda [lR18],y
        sta $0AE7,b
        rep #$20
        ldy #$0000
        sep #$20
        lda $0AE4,b
        and #$80
        sta $0AE4,b
        rep #$20
        inc lR18
        lda [lR18],y
        cmp #$FFFF
        bne _A80E
        sep #$20
        lda $0AE0,b
        ora #$02
        sta $0AE0,b
        rep #$20
        sec
        jml _AA8C


        _A80E
        cmp #$FEFF
        bne _A836
        sep #$20
        lda $0AE0,b
        ora #$02
        sta $0AE0,b
        rep #$20
        jsl rlUnknown9698E0
        bcs _A831
        sep #$20
        lda $0AE0,b
        ora #$10
        sta $0AE0,b
        rep #$20

        _A831
        sec
        jml _AA8C


        _A836
        bit #$0001
        beq _A83F
        jml _A8AA


        _A83F
        lda $7FFC59
        bit #$0080
        beq _A865
        lda #$0043
        jsl rlUnknown96A4B2
        ldx #$0000
        jsl rlUnknown978000
        lda $7FFC59
        and #$FF7F
        sta $7FFC59
        jml _AA8C


        _A865
        lda #$0000
        sta $0AE9,b
        lda #$0043
        sta $0AEB,b
        sep #$20
        lda $0AE8,b
        and #$7F
        sta $0AE8,b
        clc
        jsr rsUnknown95E3DF
        .al
        lda #$0000
        sta $7FE1A8
        lda #$0AF9
        sta $7FE1A7
        lda #$0000
        sta $7FE1AE
        lda #$0B3C
        sta $7FE1AD
        jsl rlUnknown95D6B2
        bcs _A8A5
        jml _AA8C


        _A8A5
        ldx #$0000
        bra _A913


        _A8AA
        lda $7FFC59
        bit #$0040
        beq _A8D0
        lda #$0043
        jsl rlUnknown96A4B2
        ldx #$0043
        jsl rlUnknown978000
        lda $7FFC59
        and #$FFBF
        sta $7FFC59
        jml _AA8C


        _A8D0
        lda #$0043
        sta $0AE9,b
        lda #$0000
        sta $0AEB,b
        sep #$20
        lda $0AE8,b
        ora #$80
        sta $0AE8,b
        sec
        jsr rsUnknown95E3DF
        .al
        lda #$0000
        sta $7FE1AE
        lda #$0AF9
        sta $7FE1AD
        lda #$0000
        sta $7FE1A8
        lda #$0B3C
        sta $7FE1A7
        jsl rlUnknown95D6CF
        bcs _A910
        jml _AA8C


        _A910
        ldx #$0043

        _A913
        jsl rlUnknown95C097
        jsl rlUnknown95E47F
        lda $7FFC59
        bit #$0004
        bne _A92D
        lda [lR18],y
        bit #$0002
        beq _A958
        bra _A935


        _A92D
        jsl rlUnknown95ADEE
        jml _AA53


        _A935
        lda [lR18],y
        bit #$0008
        beq _A950
        sep #$20
        lda $0AE4,b
        ora #$08
        sta $0AE4,b
        lda $0AE0,b
        ora #$40
        sta $0AE0,b
        rep #$20

        _A950
        jsl rlUnknown95ADD6
        jml _AA53


        _A958
        sep #$20
        lda [lR18],y
        bit #$20
        beq _A969
        lda $0AE6,b
        ora #$01
        rep #$20
        bra _A9C3


        _A969
        .as
        lda $0AE6,b
        and #$FE
        sta $0AE6,b
        rep #$20
        lda [lR18],y
        bit #$0040
        beq _A98F
        cpx #$0000
        bne _A984
        lda $0D5B,b
        bra _A987


        _A984
        lda $0D69,b

        _A987
        and #$00F0
        cmp #$0000
        bne _A9C3

        _A98F
        jsl rlUnknown95B050
        lda wR1
        cmp #$0010
        bcc _A9C3
        lda wR1
        cmp #$003C
        bcs _A9AA
        lda #$0001
        sta $7FF5AD
        bra _A9CA


        _A9AA
        lda lR18
        pha
        lda lR18+1
        pha
        jsl rlUnknown95AE06
        pla
        sta lR18+1
        pla
        sta lR18
        lda #$0002
        sta $7FF5AD
        bra _A9CA


        _A9C3
        lda #$0000
        sta $7FF5AD

        _A9CA
        sep #$20
        lda $0AE0,b
        and #$BF
        sta $0AE0,b
        lda $0AE4,b
        and #$BF
        sta $0AE4,b
        rep #$20
        lda [lR18],y
        bit #$0008
        bne _A9E9
        jml _A9FD


        _A9E9
        sep #$20
        lda $0AE4,b
        ora #$08
        sta $0AE4,b
        lda $0AE0,b
        ora #$40
        sta $0AE0,b
        rep #$20

        _A9FD
        sep #$20
        lda $0AE4,b
        ora #$10
        sta $0AE4,b
        rep #$20
        jsl rlUnknown95B8F3
        bcs _AA53
        lda $0AF5,b,x
        bit #$0004
        beq _AA1D
        jsl rlUnknown95ACF6
        bra _AA53


        _AA1D
        lda [lR18],y
        bit #$0004
        beq _AA4D
        bit #$0010
        beq _AA3B
        jsl rlUnknown95ACAE
        sep #$20
        lda $0AE4,b
        ora #$40
        sta $0AE4,b
        rep #$20
        bra _AA53


        _AA3B
        jsl rlUnknown95AC41
        sep #$20
        lda $0AE4,b
        ora #$40
        sta $0AE4,b
        rep #$20
        bra _AA53


        _AA4D
        jsl rlUnknown95ABBB
        bra _AA53


        _AA53
        lda $0AE1,b
        clc
        adc #$0002
        sta $0AE1,b
        lda $0AE3,b
        adc #$0000
        sep #$20
        sta $0AE3,b
        rep #$20
        lda $0AE2,b
        sta lR18+1
        lda $0AE1,b
        sta lR18
        ldy #$0000
        lda [lR18],y
        cmp #$FFFF
        bne _AA8C
        sep #$20
        lda $7FE186
        ora #$01
        sta $7FE186
        rep #$20

        _AA8C
        rts

        .databank 0

        ; 95/AA8D

    .endsection Unsorted95A65FSection


    .section Unsorted95AAFFSection

      .al
      .xl

      rlUnknown95AAFF ; 95/AAFF

        .al
        .xl
        .autsiz
        .databank ?

        phx
        sep #$20
        lda @l $000AF5,x
        and #$FC
        ora #$00
        sta @l $000AF5,x
        rep #$20
        lda $0AFE,b,x
        and #$00FF
        beq _AB4A
        phx
        cpx #$0000
        bne _AB23
        ldx #$0000
        bra _AB26


        _AB23
        ldx #$000E

        _AB26
        lda $0D5B,b,x
        and #$000F
        cmp #$0000
        bne _AB36
        lda #$0038
        bra _AB43


        _AB36
        cmp #$0002
        bne _AB40
        lda #$003C
        bra _AB43


        _AB40
        plx
        bra _AB4A


        _AB43
        plx
        jsl rlUnknown95E3FE
        bra _AB51


        _AB4A
        lda #$0000
        jsl rlUnknown95E3FE

        _AB51
        plx
        rtl

        .databank 0

        ; 95/AB53

      rlUnknown95AB53 ; 95/AB53

        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsr rsUnknown95AE65
        lda $95AB80,x
        and #$00FF
        plx
        pha
        lda @l $000AF5,x
        and #$0003
        clc
        adc #1,s
        jsl rlUnknown95E3FE
        pla
        sep #$20
        lda @l $000AF5,x
        and #$FC
        ora #$01
        sta @l $000AF5,x
        rep #$20
        rtl

        .databank 0

        ; 95/AB80

    .endsection Unsorted95AAFFSection


    .section Unsorted95ABBBSection

      .al
      .xl

      rlUnknown95ABBB ; 95/ABBB

        .al
        .xl
        .autsiz
        .databank ?

        lda [lR18],y
        bit #$0010
        beq _ABCF
        sep #$20
        lda #$03
        sta $7FE189
        sec
        rep #$20
        bra _ABD0


        _ABCF
        clc

        _ABD0
        php
        phx
        jsr rsUnknown95AE65
        lda $95AC3B,x
        and #$00FF
        plx
        pha
        lda $7FF5AD
        beq _ABED
        lda #1,s
        sec
        sbc $7FF5AD
        bra _ABF7


        _ABED
        lda @l $000AF5,x
        and #$0003
        clc
        adc #1,s

        _ABF7
        jsl rlUnknown95E3FE
        pla
        plp
        bcs _AC3A
        jsr rsUnknown95AE7A
        cmp #$0010
        bne _AC0D
        sep #$20
        lda #$02
        bra _AC28


        _AC0D
        .al
        lda $7FF5AD
        beq _AC17
        sep #$20
        bra _AC22


        _AC17
        .al
        sep #$20
        lda $0AF5,b,x
        and #$03
        cmp #$03
        beq _AC26

        _AC22
        lda #$00
        bra _AC28


        _AC26
        lda #$01

        _AC28
        sta $7FE189
        lda @l $000AF5,x
        and #$FC
        ora #$02
        sta @l $000AF5,x
        rep #$20

        _AC3A
        rtl

        .databank 0

        ; 95/AC3B

    .endsection Unsorted95ABBBSection


    .section Unsorted95AC41Section

      .al
      .xl

      rlUnknown95AC41 ; 95/AC41

        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsr rsUnknown95AE65
        lda $95ACA8,x
        and #$00FF
        plx
        pha
        lda $7FF5AD
        beq _AC5D
        lda #1,s
        sec
        sbc $7FF5AD
        bra _AC67


        _AC5D
        lda @l $000AF5,x
        and #$0003
        clc
        adc #1,s

        _AC67
        jsl rlUnknown95E3FE
        pla
        jsr rsUnknown95AE7A
        cmp #$0010
        bne _AC7A
        sep #$20
        lda #$02
        bra _AC95


        _AC7A
        .al
        lda $7FF5AD
        beq _AC84
        sep #$20
        bra _AC8F


        _AC84
        .al
        sep #$20
        lda $0AF5,b,x
        and #$03
        cmp #$03
        beq _AC93

        _AC8F
        lda #$00
        bra _AC95


        _AC93
        lda #$01

        _AC95
        sta $7FE189
        lda @l $000AF5,x
        and #$FC
        ora #$02
        sta @l $000AF5,x
        rep #$20
        rtl

        .databank 0

        ; 95/ACA8

    .endsection Unsorted95AC41Section


    .section Unsorted95ACAESection

      .al
      .xl

      rlUnknown95ACAE ; 95/ACAE

        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsr rsUnknown95AE65
        lda $95ACF0,x
        and #$00FF
        plx
        pha
        lda $7FF5AD
        beq _ACCA
        lda #1,s
        sec
        sbc $7FF5AD
        bra _ACD4


        _ACCA
        lda @l $000AF5,x
        and #$0003
        clc
        adc #1,s

        _ACD4
        jsl rlUnknown95E3FE
        pla
        sep #$20
        lda @l $000AF5,x
        and #$FC
        ora #$02
        sta @l $000AF5,x
        lda #$03
        sta $7FE189
        rep #$20
        rtl

        .databank 0

        ; 95/ACF0

    .endsection Unsorted95ACAESection


    .section Unsorted95ACF6Section

      .al
      .xl

      rlUnknown95ACF6 ; 95/ACF6

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda [lR18],y
        bit #$10
        beq _AD02
        lda #$03
        bra _AD04


        _AD02
        lda #$00

        _AD04
        sta $7FE189
        rep #$20
        phx
        jsr rsUnknown95AE65
        lda $95AD8C,x
        and #$00FF
        plx
        pha
        lda @l $000AF5,x
        and #$0003
        clc
        adc #1,s
        jsl rlUnknown95E3FE
        pla
        phx
        lda $0AF5,b,x
        and #$0038
        lsr a
        lsr a
        lsr a
        sta wR10
        lda #$0005
        sta wR11
        jsl rlUnsignedMultiply16By16
        lda wR12
        pha
        jsr rsUnknown95AE65
        txa
        clc
        adc #1,s
        tax
        pla
        lda $95AD64,x
        and #$00FF
        plx
        jsl rlUnknown95E3FE
        sep #$20
        lda @l $000AF5,x
        and #$FC
        ora #$02
        sta @l $000AF5,x
        rep #$20
        rtl

        .databank 0

        ; 95/AD64

    .endsection Unsorted95ACF6Section


    .section Unsorted95ADD6Section

      .al
      .xl

      rlUnknown95ADD6 ; 95/ADD6

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0005
        jsl rlUnknown95E3FE
        sep #$20
        lda @l $000AF5,x
        and #$FC
        ora #$02
        sta @l $000AF5,x
        rep #$20
        rtl

        .databank 0

        ; 95/ADEE

      rlUnknown95ADEE ; 95/ADEE

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0001
        jsl rlUnknown95E3FE
        sep #$20
        lda @l $000AF5,x
        and #$FC
        ora #$02
        sta @l $000AF5,x
        rep #$20
        rtl

        .databank 0

        ; 95/AE06

      rlUnknown95AE06 ; 95/AE06

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $0AFE,b,x
        and #$00FF
        bne _AE63
        phx
        cpx #$0000
        bne _AE1A
        ldx #$0000
        bra _AE1D


        _AE1A
        ldx #$000E

        _AE1D
        lda $0D4E,b,x
        cmp #$000F
        beq _AE41
        cmp #$0010
        beq _AE41
        cmp #$0011
        beq _AE41
        cmp #$0012
        beq _AE41
        cmp #$0013
        beq _AE41
        cmp #$0014
        beq _AE41
        plx
        bra _AE63


        _AE41
        lda $0D5B,b,x
        and #$000F
        cmp #$0000
        bne _AE51
        lda #$0037
        bra _AE5E


        _AE51
        cmp #$0002
        bne _AE5B
        lda #$003B
        bra _AE5E


        _AE5B
        plx
        bra _AE63


        _AE5E
        plx
        jsl rlUnknown95E3FE

        _AE63
        plx
        rtl

        .databank 0

        ; 95/AE65

      rsUnknown95AE65 ; 95/AE65

        .al
        .xl
        .autsiz
        .databank ?

        cpx #$0000
        bne _AE6F
        ldx #$0000
        bra _AE72


        _AE6F
        ldx #$000E

        _AE72
        lda $0D5B,b,x
        and #$000F
        tax
        rts

        .databank 0

        ; 95/AE7A

      rsUnknown95AE7A ; 95/AE7A

        .al
        .xl
        .autsiz
        .databank ?

        cpx #$0000
        bne _AE84
        lda $0D5B,b
        bra _AE87


        _AE84
        lda $0D69,b

        _AE87
        and #$00F0
        rts

        .databank 0

        ; 95/AE8B

    .endsection Unsorted95ADD6Section


    .section Unsorted95AE8BSection

      .al
      .xl

      rlUnknown95AE8B ; 95/AE8B

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda $7FE189
        cmp #$03
        beq _AE9B
        lda #$02
        sta $7FE189

        _AE9B
        rep #$20
        jsl rlUnknown95AEA2
        rtl

        .databank 0

        ; 95/AEA2

    .endsection Unsorted95AE8BSection


    .section Unsorted95AEA2Section

      .al
      .xl

      rlUnknown95AEA2 ; 95/AEA2

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $0AE4,b
        bit #$0008
        beq _AEAF
        jml _AF45


        _AEAF
        lda $0AE4,b
        bit #$0010
        bne _AEBB
        jml _AF45


        _AEBB
        sep #$20
        lda $0AE4,b
        and #$F7
        sta $0AE4,b
        lda $0AE4,b
        and #$EF
        sta $0AE4,b
        rep #$20
        lda $0AF6,b,x
        and #$0003
        cmp #$0002
        beq _AEE6
        lda $0AE9,b
        clc
        adc #$0086
        tax
        jsl rlUnknown95DDFB

        _AEE6
        lda $0AE8,b
        bit #$0080
        beq _AF11
        lda $0AE7,b
        and #$00FF
        beq _AF00
        sta wR0
        jsr rsUnknown95948D
        clc
        jsl rlUnknown959CDF

        _AF00
        jsl rlUnknown95CA88
        jsl rlUnknown95AF55
        jsl rlUnknown969F6A
        lda $0D60,b
        bra _AF33


        _AF11
        lda $0AE7,b
        and #$00FF
        beq _AF23
        sta wR0
        jsr rsUnknown9594C3
        sec
        jsl rlUnknown959CDF

        _AF23
        jsl rlUnknown95CA88
        jsl rlUnknown95AF55
        jsl rlUnknown969F6A
        lda @l $000D52

        _AF33
        cmp #$0010
        beq _AF41
        lda $7FFC5D
        bit #$0004
        beq _AF45

        _AF41
        jsl rlUnknown95B02B

        _AF45
        sep #$20
        lda $7FFC5D
        and #$FB
        sta $7FFC5D
        rep #$20
        plx
        rtl

        .databank 0

        ; 95/AF55

      rlUnknown95AF55 ; 95/AF55

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $0AE7,b
        and #$00FF
        beq _AFBA
        lda $7FE189
        and #$00FF
        cmp #$0003
        beq _AF83
        cmp #$0002
        beq _AF7E
        cmp #$0001
        beq _AF79
        lda #$0091
        bra _AFBD


        _AF79
        lda #$0092
        bra _AFBD


        _AF7E
        lda #$0093
        bra _AFBD


        _AF83
        lda $0AE9,b
        cmp #$0000
        bne _AFB5
        lda $0D5E,b
        cmp #$01C6
        bne _AFB5
        lda $7E4EA9
        and #$00FF
        cmp #$00FF
        beq _AFB5
        lda #$1414
        sta $7FFC57
        lda $7FFC59
        ora #$0400
        sta $7FFC59
        jsl rlUnknown969603

        _AFB5
        lda #$0094
        bra _AFBD


        _AFBA
        lda #$0095

        _AFBD
        pha
        ldx $0AEB,b
        lda $0AF9,b,x
        and #$01FF
        sec
        sbc $7FE198
        bmi _AFD8
        cmp #$0100
        bcc _AFDD
        lda #$1F00
        bra _AFE1


        _AFD8
        lda #$0100
        bra _AFE1


        _AFDD
        jsl rlUnknown9EB4BB

        _AFE1
        cpx #$0000
        bne _AFEA
        clc
        adc #$2000

        _AFEA
        sta wR0
        ora #1,s
        jsl rlPlaySoundEffect2
        pla
        lda $0AE4,b
        bit #$0040
        beq _B004
        lda wR0
        ora #$0050
        jsl rlPlaySoundEffect2

        _B004
        plx
        rtl

        .databank 0

        ; 95/B006

      rlUnknown95B006 ; 95/B006

        .al
        .xl
        .autsiz
        .databank ?

        lda $0AE8,b
        bit #$0080
        beq _B01D
        lda $0AE7,b
        and #$00FF
        sta wR0
        asl a
        asl a
        jsr rsUnknown959474
        bra _B02A


        _B01D
        lda $0AE7,b
        and #$00FF
        sta wR0
        asl a
        asl a
        jsr rsUnknown9594AA

        _B02A
        rtl

        .databank 0

        ; 95/B02B

      rlUnknown95B02B ; 95/B02B

        .al
        .xl
        .autsiz
        .databank ?

        lda $0AE8,b
        bit #$0080
        bne _B042
        lda $0AE7,b
        and #$00FF
        sta wR0
        asl a
        asl a
        jsr rsUnknown959474
        bra _B04F


        _B042
        lda $0AE7,b
        and #$00FF
        sta wR0
        asl a
        asl a
        jsr rsUnknown9594AA

        _B04F
        rtl

        .databank 0

        ; 95/B050

      rlUnknown95B050 ; 95/B050

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        ldx $0AE9,b
        lda $0AF9,b,x
        ldx $0AEB,b
        sec
        sbc $0AF9,b,x
        bpl _B065
        eor #$FFFF
        inc a

        _B065
        sta wR0
        ldx $0AE9,b
        jsl rlUnknown95B626
        sta wR8
        ldx $0AEB,b
        jsl rlUnknown95B5D0
        sta wR9
        ldx $0AEB,b
        lda $0AF9,b,x
        sta wR1
        ldx $0AE9,b
        lda $0AF9,b,x
        sta wR2
        lda wR2
        cmp wR1
        bcc _B0AC
        lda wR8
        clc
        adc wR9
        clc
        adc wR1
        pha
        lda wR2
        sec
        sbc #1,s
        bcs _B0A7
        pla
        lda #$0000
        sta wR1
        bra _B0C7


        _B0A7
        sta wR1
        pla
        bra _B0C7


        _B0AC
        lda wR8
        clc
        adc wR9
        clc
        adc wR2
        pha
        lda wR1
        sec
        sbc #1,s
        bcs _B0C4
        pla
        lda #$0000
        sta wR1
        bra _B0C7


        _B0C4
        sta wR1
        pla

        _B0C7
        jsl rlUnknown95B0D7
        bcc _B0D4
        lda #$0000
        sta wR0
        sta wR1

        _B0D4
        ply
        plx
        rtl

        .databank 0

        ; 95/B0D7

      rlUnknown95B0D7 ; 95/B0D7

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        ldx $0AE9,b
        lda $0AF9,b,x
        ldx $0AEB,b
        sec
        sbc $0AF9,b,x
        bpl _B0EC
        eor #$FFFF
        inc a

        _B0EC
        sta wR9
        ldx $0AE9,b
        jsl rlUnknown95B5D0
        pha
        ldx $0AEB,b
        jsl rlUnknown95B5D0
        clc
        adc #1,s
        sta #1,s
        pla
        cmp wR9
        bcc _B10D
        sec
        sbc wR9
        sec
        bra _B111


        _B10D
        lda #$0000
        clc

        _B111
        ply
        plx
        rtl

        .databank 0

        ; 95/B114

    .endsection Unsorted95AEA2Section


    .section Unsorted95B184Section

      .al
      .xl

      rlUnknown95B184 ; 95/B184

        .al
        .xl
        .autsiz
        .databank ?

        lda $0AF9,b
        cmp $0B3C,b
        beq _B190
        bcc _B1A6
        bcs _B1A0

        _B190
        lda $0AF8,b
        cmp $0B3B,b
        bcc _B1A6
        bne _B1A0
        lda #$0000
        clc
        bra _B1AA


        _B1A0
        sec
        lda #$0001
        bra _B1AA


        _B1A6
        clc
        lda #$0001

        _B1AA
        rtl

        .databank 0

        ; 95/B1AB

      rlUnknown95B1AB ; 95/B1AB

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        bit #$0080
        bne _B1EF
        pha
        and #$007F
        cmp #$007E
        beq _B1C0
        cmp #$007D
        bne _B1C3

        _B1C0
        pla
        bra _B1D9


        _B1C3
        pla
        and #$007F
        phx
        phx
        asl a
        tax
        lda $97C860,x
        sta wR0
        pla
        ldx #$0000
        jsr ($950000,x)
        plx

        _B1D9
        sep #$20
        lda $0AF4,b,x
        and #$FE
        sta $0AF4,b,x
        lda $0AF4,b,x
        and #$FD
        sta $0AF4,b,x
        rep #$20
        bra _B24D


        _B1EF
        pha
        sep #$20
        lda $0AF4,b,x
        ora #$01
        sta $0AF4,b,x
        rep #$20
        pla
        pha
        bit #$8000
        beq _B20F
        sep #$20
        lda $0AF4,b,x
        ora #$02
        sta $0AF4,b,x
        rep #$20

        _B20F
        pla
        pha
        bit #$4000
        beq _B222
        sep #$20
        lda $0AF4,b,x
        ora #$04
        sta $0AF4,b,x
        rep #$20

        _B222
        pla
        pha
        and #$007F
        pha
        lda $0AF4,b,x
        and #$0006
        cmp #$0006
        pla
        asl a
        pha
        pla
        tay
        lda $0B2F,b,x
        sta lR18
        lda $0B30,b,x
        sta lR18+1
        lda [lR18],y
        clc
        adc $0B2F,b,x
        sta $0B32,b,x
        sta $0B34,b,x
        pla

        _B24D
        ply
        plx
        rtl

        .databank 0

        ; 95/B250

    .endsection Unsorted95B184Section


    .section Unsorted95B2DFSection

      .al
      .xl

      rsUnknown95B2DF ; 95/B2DF

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        tax
        lda #$0050
        sta wR0
        jsr rsUnknown95B554
        rts

        .databank 0

        ; 95/B2E9

      rsUnknown95B2E9 ; 95/B2E9

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        tax
        lda $0B0C,b,x
        and #$8000
        pha
        lda $0B0C,b,x
        and #$7FFF
        lsr a
        lsr a
        lsr a
        ora #1,s
        sta $0B0A,b,x
        pla
        bmi _B307
        lda #$0198
        bra _B30A


        _B307
        lda #$0068

        _B30A
        sta $0B00,b,x
        lda $0B0C,b,x
        sta $0B08,b,x
        rts

        .databank 0

        ; 95/B314

      rsUnknown95B314 ; 95/B314

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        tax
        lda #$FFFF
        sta $0B0A,b,x
        lda $0B0C,b,x
        bmi _B325
        lda #$0198
        bra _B328


        _B325
        lda #$0068

        _B328
        sta $0B00,b,x
        lda $0B0C,b,x
        sta $0B08,b,x
        rts

        .databank 0

        ; 95/B332

    .endsection Unsorted95B2DFSection


    .section Unsorted95B362Section

      .al
      .xl

      rsUnknown95B362 ; 95/B362

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        tax
        clc
        jsr rsUnknown95CEBF
        plx
        rts

        .databank 0

        ; 95/B36A

      rsUnknown95B36A ; 95/B36A

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        tax
        sec
        jsr rsUnknown95CEBF
        plx
        rts

        .databank 0

        ; 95/B372

      rsUnknown95B372 ; 95/B372

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        tax
        cpx #$0000
        bne _B37B
        clc
        bra _B37C


        _B37B
        sec

        _B37C
        jsl rlUnknown95DB55
        pha
        and #$00FF
        jsr rsUnknown95CFA0
        sep #$20
        lda $0AF3,b,x
        ora #$08
        sta $0AF3,b,x
        lda $0AF4,b,x
        ora #$08
        sta $0AF4,b,x
        rep #$20
        pla
        xba
        and #$00FF
        jsl rlUnknown95CE78
        lda wR1
        sta $0B0E,b,x
        lda wR0
        sta $0B10,b,x
        rts

        .databank 0

        ; 95/B3AF

    .endsection Unsorted95B362Section


    .section Unsorted95B475Section

      .al
      .xl

      rsUnknown95B475 ; 95/B475

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        tax
        sec
        jsl rlUnknown95D078
        sta wR0
        jsr rsUnknown95B554
        lda $0B0C,b,x
        and #$8000
        ora #$0800
        sta $0B0C,b,x
        rts

        .databank 0

        ; 95/B48D

    .endsection Unsorted95B475Section


    .section Unsorted95B530Section

      .al
      .xl

      rlUnknown95B530 ; 95/B530

        .al
        .xl
        .autsiz
        .databank ?

        phx
        pha
        bcs _B539
        jsr rsUnknown95B655
        bra _B53C


        _B539
        jsr rsUnknown95B67E

        _B53C
        sta wR14
        pla
        and #$01FF
        asl a
        asl a
        asl a
        sta wR13
        jsl rlUnsignedDivide16By16R13
        lda wR13
        bne _B552
        lda #$0001

        _B552
        plx
        rtl

        .databank 0

        ; 95/B554

    .endsection Unsorted95B530Section


    .section Unsorted95B554Section

      .al
      .xl

      rsUnknown95B554 ; 95/B554

        .al
        .xl
        .autsiz
        .databank ?

        phx
        cpx #$0000
        bne _B56F
        jsl rlUnknown95B184
        beq _B564
        bcc _B5A3
        bra _B577


        _B564
        jsr rsUnknown95C9C3
        lda lR18+1
        cmp lR19+1
        bcc _B5A3
        bra _B577


        _B56F
        jsl rlUnknown95B184
        beq _B564
        bcs _B5A3

        _B577
        jsr rsUnknown95C9C3
        lda lR18+1
        cmp wR0
        bcc _B582
        lda wR0

        _B582
        sta wR1
        jsr rsUnknown95B655
        xba
        ora #$8000
        sta $0B08,b,x
        sta $0B0C,b,x
        lda $0AF9,b,x
        sec
        sbc wR1
        bcc _B59E
        cmp #$0068
        bcs _B5C8

        _B59E
        lda #$0068
        bra _B5C8


        _B5A3
        jsr rsUnknown95C9C3
        lda lR19+1
        cmp wR0
        bcc _B5AE
        lda wR0

        _B5AE
        sta wR1
        jsr rsUnknown95B655
        xba
        sta $0B08,b,x
        sta $0B0C,b,x
        lda $0AF9,b,x
        clc
        adc wR1
        cmp #$0198
        bcc _B5C8
        lda #$0198

        _B5C8
        stz $0AFF,b,x
        sta $0B00,b,x
        plx
        rts

        .databank 0

        ; 95/B5D0

    .endsection Unsorted95B554Section


    .section Unsorted95B5D0Section

      .al
      .xl

      rlUnknown95B5D0 ; 95/B5D0

        .al
        .xl
        .autsiz
        .databank ?

        phx
        cpx #$0000
        bne _B5DC
        lda $7FE1BE
        bra _B5E0


        _B5DC
        lda $7FE1BF

        _B5E0
        and #$00FF
        sta wR10
        lda #$0008
        sta wR11
        jsl rlUnsignedMultiply16By16
        ldx wR12
        lda $97EA9A,x
        and #$00FF
        jsl rlUnknown95A165
        plx
        rtl

        .databank 0

        ; 95/B5FD

      rlUnknown95B5FD ; 95/B5FD

        .al
        .xl
        .autsiz
        .databank ?

        phx
        cpx #$0000
        bne _B609
        lda $7FE1BE
        bra _B60D


        _B609
        lda $7FE1BF

        _B60D
        and #$00FF
        sta wR10
        lda #$0008
        sta wR11
        jsl rlUnsignedMultiply16By16
        ldx wR12
        lda $97EA9B,x
        and #$00FF
        plx
        rtl

        .databank 0

        ; 95/B626

      rlUnknown95B626 ; 95/B626

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        cpx #$0000
        bne _B633
        lda $7FE1BE
        bra _B637


        _B633
        lda $7FE1BF

        _B637
        and #$00FF
        sta wR10
        lda #$0008
        sta wR11
        jsl rlUnsignedMultiply16By16
        ldx wR12
        lda $97EA9C,x
        and #$00FF
        jsl rlUnknown95A165
        ply
        plx
        rtl

        .databank 0

        ; 95/B655

      rsUnknown95B655 ; 95/B655

        .al
        .xl
        .autsiz
        .databank ?

        phx
        cpx #$0000
        bne _B661
        lda $7FE1BE
        bra _B665


        _B661
        lda $7FE1BF

        _B665
        and #$00FF
        sta wR10
        lda #$0008
        sta wR11
        jsl rlUnsignedMultiply16By16
        ldx wR12
        lda $97EA9D,x
        and #$00FF
        plx
        rts

        .databank 0

        ; 95/B67E

      rsUnknown95B67E ; 95/B67E

        .al
        .xl
        .autsiz
        .databank ?

        phx
        cpx #$0000
        bne _B68A
        lda $7FE1BE
        bra _B68E


        _B68A
        lda $7FE1BF

        _B68E
        and #$00FF
        sta wR10
        lda #$0008
        sta wR11
        jsl rlUnsignedMultiply16By16
        ldx wR12
        lda $97EA9E,x
        and #$00FF
        plx
        rts

        .databank 0

        ; 95/B6A7

    .endsection Unsorted95B5D0Section


    .section Unsorted95B6D0Section

      .al
      .xl

      rlUnknown95B6D0 ; 95/B6D0

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda wBattleDistance
        cmp #$0002
        bcc _B6F4
        cpx #$0000
        bne _B6E4
        lda $0D52,b
        bra _B6E7


        _B6E4
        lda $0D60,b

        _B6E7
        jsl rlUnknown95B7AE
        bcc _B6F4
        lda #$00C8
        jml _B7AC


        _B6F4
        lda wBattleDistance
        cmp #$0002
        bcs _B73C
        cpx #$0000
        bne _B720
        lda $0D5B,b
        and #$000F
        cmp #$0005
        bne _B73C
        lda $0D69,b
        and #$000F
        cmp #$0005
        beq _B73C
        jsl rlUnknown969F7D
        bcs _B781
        bra _B73C


        _B720
        lda $0D69,b
        and #$000F
        cmp #$0005
        bne _B73C
        lda $0D5B,b
        and #$000F
        cmp #$0005
        beq _B73C
        jsl rlUnknown969F7D
        bcs _B781

        _B73C
        cpx #$0000
        bne _B746
        lda $0D52,b
        bra _B749


        _B746
        lda $0D60,b

        _B749
        cmp #$005B
        beq _B762
        cmp #$0061
        beq _B762
        cmp #$0063
        beq _B762
        cmp #$0064
        beq _B762
        cmp #$0065
        bne _B770

        _B762
        lda wBattleDistance
        cmp #$0002
        bne _B770
        lda #$00E0
        bra _B7AC


        _B770
        cpx #$0000
        bne _B77B
        lda $7FE1BE
        bra _B77F


        _B77B
        lda $7FE1BF

        _B77F
        bra _B790


        _B781
        cpx #$0000
        bne _B78C
        lda $7FE1BF
        bra _B790


        _B78C
        lda $7FE1BE

        _B790
        and #$00FF
        sta wR10
        lda #$0008
        sta wR11
        jsl rlUnsignedMultiply16By16
        ldx wR12
        lda $97EAA0,x
        and #$00FF
        jsl rlUnknown95A165
        asl a

        _B7AC
        plx
        rtl

        .databank 0

        ; 95/B7AE

      rlUnknown95B7AE ; 95/B7AE

        .al
        .xl
        .autsiz
        .databank ?

        and #$00FF
        cmp #$000F
        beq _B7CD
        cmp #$0010
        beq _B7CD
        cmp #$0011
        beq _B7CD
        cmp #$0012
        beq _B7CD
        cmp #$0013
        beq _B7CD
        clc
        bra _B7CE


        _B7CD
        sec

        _B7CE
        rtl

        .databank 0

        ; 95/B7CF

    .endsection Unsorted95B6D0Section


    .section Unsorted95B7F8Section

      .al
      .xl

      rlUnknown95B7F8 ; 95/B7F8

        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsl rlUnknown95B80C
        sta wR14
        lda #$0762
        sta wR13
        jsl rlUnsignedDivide16By16R13
        lda wR13
        plx
        rtl

        .databank 0

        ; 95/B80C

      rlUnknown95B80C ; 95/B80C

        .al
        .xl
        .autsiz
        .databank ?

        phx
        inc a
        and #$00FF
        tax
        lda $97EC1A,x
        and #$00FF
        plx
        rtl

        .databank 0

        ; 95/B81B

    .endsection Unsorted95B7F8Section


    .section Unsorted95B81BSection

      .al
      .xl

      rlUnknown95B81B ; 95/B81B

        .al
        .xl
        .autsiz
        .databank ?

        phx
        sep #$20
        lda $0D5B,b
        lsr a
        lsr a
        lsr a
        lsr a
        xba
        lda $0D4E,b
        rep #$20
        jsr rsUnknown95B84E
        sep #$20
        sta $7FE1BE
        lda $0D69,b
        lsr a
        lsr a
        lsr a
        lsr a
        xba
        lda $0D5C,b
        rep #$20
        jsr rsUnknown95B84E
        sep #$20
        sta $7FE1BF
        rep #$20
        plx
        rtl

        .databank 0

        ; 95/B84E

      rsUnknown95B84E ; 95/B84E

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000
        sta wR0
        sep #$20

        _B856
        lda $97E8FB,x
        cmp #$FF
        beq _B873
        cmp wR0
        bne _B86E
        lda wR0+1
        cmp #$09
        beq _B87A
        cmp $97E8FC,x
        beq _B87A

        _B86E
        inc x
        inc x
        inc x
        bra _B856


        _B873
        rep #$20
        lda #$0000
        bra _B882


        _B87A
        .as
        rep #$20
        inc x
        inc x
        lda $97E8FB,x

        _B882
        plx
        rts

        .databank 0

        ; 95/B884

    .endsection Unsorted95B81BSection


    .section Unsorted95B884Section

      .al
      .xl

      rsUnknown95B884 ; 95/B884

        .al
        .xl
        .autsiz
        .databank ?

        phx
        clc
        adc $0B1E,b,x
        and #$00FF
        sep #$20
        pha
        cmp $0B1C,b,x
        bne _B899
        pla
        rep #$20
        bra _B8AE


        _B899
        .as
        pla
        rep #$20
        xba
        cpx #$0000
        bne _B8A7
        ora #$0000
        bra _B8AA


        _B8A7
        ora #$0001

        _B8AA
        jsl rlUnknown95BA05

        _B8AE
        plx
        rts

        .databank 0

        ; 95/B8B0

      rlUnknown95B8B0 ; 95/B8B0

        .al
        .xl
        .autsiz
        .databank ?

        phx
        pha
        lda wR2
        and #$00F0
        cmp #$0050
        bne _B8C1
        ldx #$0070
        bra _B8CE


        _B8C1
        cmp #$0060
        bne _B8CB
        ldx #$003E
        bra _B8CE


        _B8CB
        ldx #$0000

        _B8CE
        lda $98AFFD,x
        cmp #$FFFF
        beq _B8EA
        cmp #1,s
        bne _B8E4
        lda $98AFFF,x
        sta #1,s
        clc
        bra _B8F0


        _B8E4
        inc x
        inc x
        inc x
        inc x
        bra _B8CE


        _B8EA
        lda #$0000
        sta #1,s
        sec

        _B8F0
        pla
        plx
        rtl

        .databank 0

        ; 95/B8F3

      rlUnknown95B8F3 ; 95/B8F3

        .al
        .xl
        .autsiz
        .databank ?

        lda [lR18],y
        bit #$0040
        beq _B956
        cpx #$0000
        bne _B904
        lda $0D5B,b
        bra _B907


        _B904
        lda $0D69,b

        _B907
        and #$00F0
        cmp #$0000
        bne _B956
        cpx #$0000
        bne _B919
        lda $0D52,b
        bra _B91C


        _B919
        lda $0D60,b

        _B91C
        and #$00FF
        cmp #$0009
        beq _B959
        cmp #$000B
        beq _B959
        cmp #$000C
        beq _B959
        lda [lR18],y
        bit #$0020
        beq _B956
        lda [lR18],y
        bit #$0004
        beq _B948
        sep #$20
        lda $0AE4,b
        ora #$40
        sta $0AE4,b
        rep #$20

        _B948
        sep #$20
        lda $0AF5,b,x
        ora #$04
        and #$C7
        sta $0AF5,b,x
        rep #$20

        _B956
        clc
        bra _B96E


        _B959
        jsl rlUnknown96DC7C
        jsl rlUnknown96BCEC
        sep #$20
        lda $0AF3,b,x
        ora #$40
        sta $0AF3,b,x
        rep #$20
        sec

        _B96E
        rtl

        .databank 0

        ; 95/B96F

    .endsection Unsorted95B884Section


    .section Unsorted95B96FSection

      .al
      .xl

      rlUnknown95B96F ; 95/B96F

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        ldx #$0000

        _B974
        stz $0AF3,b,x
        rep #$20
        txa
        clc
        adc #$0043
        tax
        sep #$20
        cpx #$010C
        bcc _B974
        rep #$20
        lda #$0C00
        sta $0CC5,b
        jsl rlUnknown95C097
        rtl

        .databank 0

        ; 95/B993

    .endsection Unsorted95B96FSection


    .section Unsorted95B993Section

      .al
      .xl

      rlUnknown95B993 ; 95/B993

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        sep #$20
        ldx #$0000

        _B99A
        lda $978F3A,x
        sta $0BFF,b,x
        inc x
        cpx #$0043
        bcc _B99A
        rep #$20
        plx
        pla
        rtl

        .databank 0

        ; 95/B9AC

      rlUnknown95B9AC ; 95/B9AC

        .al
        .xl
        .autsiz
        .databank ?

        phy
        pha
        lda $0C26,b
        sta lR18+1
        lda $0C25,b
        sta lR18
        sta wR0
        ldy #$0000
        lda $0C28,b
        and #$00FF
        asl a
        clc
        adc [lR18],y
        clc
        adc lR18
        sta lR18
        lda [lR18],y
        clc
        adc wR0
        sta $0C2B,b
        sta $0C2D,b
        pla
        and #$00FF
        cmp #$0004
        bcs _BA03
        sep #$20
        sta $4202,b
        lda #$43
        sta $4203,b
        nop
        nop
        nop
        ldx #$0000
        ldy $4216,b

        _B9F3
        lda $0BFF,b,x
        sta $0AF3,b,y
        inc y
        inc x
        cpx #$0043
        bcc _B9F3
        rep #$20
        clc

        _BA03
        ply
        rtl

        .databank 0

        ; 95/BA05

      rlUnknown95BA05 ; 95/BA05

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        and #$3FFF
        sep #$20
        cmp #$04
        bcs _BA71
        sta $4202,b
        lda #$43
        sta $4203,b
        nop
        nop
        nop
        nop
        ldx $4216,b
        pha
        lda $0AF3,b,x
        bit #$04
        beq _BA2B
        pla
        sec
        bra _BA71


        _BA2B
        pla
        xba
        sta $0B1C,b,x
        stz $0B23,b,x
        pha
        lda $0AF3,b,x
        ora #$01
        sta $0AF3,b,x
        lda $0AF3,b,x
        ora #$04
        sta $0AF3,b,x
        lda $0AF4,b,x
        and #$9F
        sta $0AF4,b,x
        pla
        rep #$20
        pha
        lda $0B1A,b,x
        sta lR18+1
        lda $0B19,b,x
        sta lR18
        ldy #$0000
        pla
        and #$00FF
        asl a
        adc [lR18],y
        tay
        lda [lR18],y
        clc
        adc lR18
        sta $0B1F,b,x
        sta $0B21,b,x
        clc

        _BA71
        .as
        rep #$20
        ply
        plx
        rtl

        .databank 0

        ; 95/BA76

      rlUnknown95BA76 ; 95/BA76

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        and #$3FFF
        sep #$20
        cmp #$04
        bcs _BAE2
        sta $4202,b
        lda #$43
        sta $4203,b
        nop
        nop
        nop
        nop
        ldx $4216,b
        pha
        lda $0AF3,b,x
        bit #$04
        beq _BA9C
        pla
        sec
        bra _BAE2


        _BA9C
        pla
        xba
        sta $0B1C,b,x
        stz $0B23,b,x
        pha
        lda $0AF3,b,x
        ora #$01
        sta $0AF3,b,x
        lda $0AF3,b,x
        ora #$04
        sta $0AF3,b,x
        lda $0AF4,b,x
        and #$9F
        sta $0AF4,b,x
        pla
        rep #$20
        pha
        lda $0B1A,b,x
        sta lR18+1
        lda $0B19,b,x
        sta lR18
        ldy #$0000
        pla
        and #$00FF
        asl a
        adc [lR18],y
        tay
        lda [lR18],y
        clc
        adc lR18
        sta $0B1F,b,x
        sta $0B21,b,x
        clc

        _BAE2
        rep #$20
        ply
        plx
        rtl

        .databank 0

        ; 95/BAE7

      rlUnknown95BAE7 ; 95/BAE7

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        stz $0AF3,b,x
        rep #$20
        rtl

        .databank 0

        ; 95/BAEF

      rlUnknown95BAEF ; 95/BAEF

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FFC77
        bit #$0001
        bne _BB2D
        lda #$0000

        _BAFB
        sta $0C43,b
        ldx #$0000

        _BB01
        phx
        lda $0AF7,b,x
        and #$00FF
        cmp $0C43,b
        bne _BB18
        lda $0AF3,b,x
        bit #$0080
        beq _BB18
        jsr rsUnknown95BB2E

        _BB18
        plx
        txa
        clc
        adc #$0043
        tax
        cpx #$010C
        bcc _BB01
        lda $0C43,b
        inc a
        cmp #$0008
        bcc _BAFB

        _BB2D
        rtl

        .databank 0

        ; 95/BB2E

      rsUnknown95BB2E ; 95/BB2E

        .al
        .xl
        .autsiz
        .databank ?

        lda $0AF3,b,x
        bit #$0001
        bne _BB3D
        clc
        jsl rlUnknown95C1AB
        bra _BB40


        _BB3D
        jsr rsUnknown95BB41

        _BB40
        rts

        .databank 0

        ; 95/BB41

      rsUnknown95BB41 ; 95/BB41

        .al
        .xl
        .autsiz
        .databank ?

        lda $0B23,b,x
        and #$00FF
        beq _BB4D
        jml _BC9D


        _BB4D
        jsr rsUnknown95BFB3
        and #$00FF
        cmp #$00FE
        bne _BB5C
        jml _BCB6


        _BB5C
        cmp #$00FD
        bne _BB68
        jsr rsUnknown95BCBE
        jml _BC9D


        _BB68
        cmp #$00FC
        bne _BB74
        jsr rsUnknown95BCCB
        jml _BC65


        _BB74
        cmp #$00FB
        bne _BB80
        jsr rsUnknown95BCD5
        jml _BC65


        _BB80
        cmp #$00FA
        bne _BB8C
        jsr rsUnknown95BCEF
        jml _BC9D


        _BB8C
        cmp #$00F9
        bne _BB98
        jsr rsUnknown95BD10
        jml _BC65


        _BB98
        cmp #$00F8
        bne _BBA4
        jsr rsUnknown95BD6B
        jml _BC65


        _BBA4
        cmp #$00F7
        bne _BBB0
        jsr rsUnknown95BD76
        jml _BC65


        _BBB0
        cmp #$00F6
        bne _BBBC
        jsr rsUnknown95BD89
        jml _BC65


        _BBBC
        cmp #$00F5
        bne _BBC8
        jsr rsUnknown95BDA0
        jml _BC65


        _BBC8
        cmp #$00F4
        bne _BBD6
        jsr rsUnknown95BDB7
        bcs _BBD6
        jml _BC65


        _BBD6
        cmp #$00F3
        bne _BBE2
        jsr rsUnknown95BDD2
        jml _BC65


        _BBE2
        cmp #$00F2
        bne _BBEC
        jsr rsUnknown95BDF5
        bra _BC65


        _BBEC
        cmp #$00F1
        bne _BBFC
        jsr rsUnknown95BE04
        bcc _BBFA
        jml _BC9D


        _BBFA
        bra _BC65


        _BBFC
        cmp #$00F0
        bne _BC06
        jsr rsUnknown95BE17
        bra _BC65


        _BC06
        cmp #$00EF
        bne _BC10
        jsr rsUnknown95BE26
        bra _BC65


        _BC10
        cmp #$00EE
        bne _BC1A
        jsr rsUnknown95BE39
        bra _BC65


        _BC1A
        cmp #$00ED
        bne _BC24
        jsr rsUnknown95BEA4
        bra _BC65


        _BC24
        cmp #$00EC
        bne _BC2E
        jsr rsUnknown95BECE
        bra _BC65


        _BC2E
        cmp #$00EB
        bne _BC38
        jsr rsUnknown95BEED
        bra _BC65


        _BC38
        cmp #$00EA
        bne _BC42
        jsr rsUnknown95BF4A
        bra _BC65


        _BC42
        cmp #$00E9
        bne _BC4C
        jsr rsUnknown95BF8D
        bra _BC65


        _BC4C
        cmp #$00E8
        bne _BC56
        jsr rsUnknown95BFA4
        bra _BC65


        _BC56
        cmp #$00E7
        bne _BC60
        jsr rsUnknown95BF61
        bra _BC65


        _BC60
        jsr rsUnknown95E4D2
        bra _BC69


        _BC65
        jml _BB4D


        _BC69
        sep #$20
        lda $0AF3,b,x
        and #$FD
        sta $0AF3,b,x
        rep #$20
        jsr rsUnknown95BFB3
        pha
        lda $0B21,b,x
        clc
        adc #$0002
        sta $0B21,b,x
        pla
        sep #$20
        sta $0B1D,b,x
        xba
        jsr rsUnknown95BFC6
        sta $0B23,b,x
        rep #$20
        lda $0AF3,b,x
        bit #$0002
        bne _BCAA
        sec
        bra _BCA6


        _BC9D
        lda $0AF3,b,x
        bit #$0002
        bne _BCAA
        clc

        _BCA6
        jsl rlUnknown95C1AB

        _BCAA
        lda $0B23,b,x
        and #$00FF
        beq _BCB5
        dec $0B23,b,x

        _BCB5
        rts


        _BCB6
        sep #$20
        stz $0AF3,b,x
        rep #$20
        rts

        .databank 0

        ; 95/BCBE

      rsUnknown95BCBE ; 95/BCBE

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda $0AF3,b,x
        and #$FE
        sta $0AF3,b,x
        rep #$20
        rts

        .databank 0

        ; 95/BCCB

      rsUnknown95BCCB ; 95/BCCB

        .al
        .xl
        .autsiz
        .databank ?

        lda $0B1F,b,x
        sta $0B21,b,x
        jsr rsUnknown95E58C
        rts

        .databank 0

        ; 95/BCD5

      rsUnknown95BCD5 ; 95/BCD5

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown95BFB3
        xba
        and #$00FF
        bne _BCDF
        inc a

        _BCDF
        asl a
        pha
        lda $0B21,b,x
        sec
        sbc #1,s
        sta $0B21,b,x
        pla
        jsr rsUnknown95E59B
        rts

        .databank 0

        ; 95/BCEF

      rsUnknown95BCEF ; 95/BCEF

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown95BFB3
        sep #$20
        xba
        jsr rsUnknown95BFC6
        sta $0B23,b,x
        lda $0AF3,b,x
        ora #$02
        sta $0AF3,b,x
        rep #$20
        lda $0B21,b,x
        clc
        adc #$0002
        sta $0B21,b,x
        rts

        .databank 0

        ; 95/BD10

      rsUnknown95BD10 ; 95/BD10

        .al
        .xl
        .autsiz
        .databank ?

        lda @l $000AF5,x
        bit #$0040
        bne _BD60
        lda $0AF9,b,x
        and #$01FF
        sec
        sbc $7FE198
        bmi _BD30
        cmp #$0100
        bcc _BD35
        lda #$1F00
        bra _BD39


        _BD30
        lda #$0100
        bra _BD39


        _BD35
        jsl rlUnknown9EB4BB

        _BD39
        cpx #$0000
        bne _BD42
        clc
        adc #$2000

        _BD42
        pha
        jsr rsUnknown95BFB3
        inc a
        xba
        and #$00FF
        phx
        asl a
        tax
        lda $98ACC0,x
        plx
        jsr rsUnknown95C0F3
        jsr rsUnknown95C17A
        ora #1,s
        jsl rlPlaySoundEffect2
        pla

        _BD60
        lda $0B21,b,x
        clc
        adc #$0002
        sta $0B21,b,x
        rts

        .databank 0

        ; 95/BD6B

      rsUnknown95BD6B ; 95/BD6B

        .al
        .xl
        .autsiz
        .databank ?

        lda $0B21,b,x
        clc
        adc #$0002
        sta $0B21,b,x
        rts

        .databank 0

        ; 95/BD76

      rsUnknown95BD76 ; 95/BD76

        ; Probably a bug in the original: unlike its neighbours this has no
        ; rep #$20 after storing $0C42, so adc #$0002 runs as adc #$02 and the
        ; CPU then executes the $00 as brk. Command $F7 of rsUnknown95BB41; the
        ; prologue log never runs it.
        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$01
        sta $0C42,b
        lda $0B21,b,x
        clc
        adc #$02
        .byte $00 ; brk
        sta $0B21,b,x
        sec
        rts

        .databank 0

        ; 95/BD89

      rsUnknown95BD89 ; 95/BD89

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda $0AF3,b,x
        and #$FB
        sta $0AF3,b,x
        rep #$20
        lda $0B21,b,x
        clc
        adc #$0002
        sta $0B21,b,x
        rts

        .databank 0

        ; 95/BDA0

      rsUnknown95BDA0 ; 95/BDA0

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda $0AF3,b,x
        ora #$04
        sta $0AF3,b,x
        rep #$20
        lda $0B21,b,x
        clc
        adc #$0002
        sta $0B21,b,x
        rts

        .databank 0

        ; 95/BDB7

      rsUnknown95BDB7 ; 95/BDB7

        .al
        .xl
        .autsiz
        .databank ?

        lda $0C42,b
        bne _BDBF
        clc
        bra _BDD1


        _BDBF
        sep #$20
        stz $0C42,b
        rep #$20
        lda $0B21,b,x
        clc
        adc #$0002
        sta $0B21,b,x
        sec

        _BDD1
        rts

        .databank 0

        ; 95/BDD2

      rsUnknown95BDD2 ; 95/BDD2

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda $0AF3,b,x
        ora #$40
        sta $0AF3,b,x
        rep #$20
        jsr rsUnknown95BFB3
        xba
        and #$00FF
        bne _BDE8
        inc a

        _BDE8
        asl a
        pha
        lda $0B21,b,x
        sec
        sbc #1,s
        sta $0B21,b,x
        pla
        rts

        .databank 0

        ; 95/BDF5

      rsUnknown95BDF5 ; 95/BDF5

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown95C077
        lda $0B21,b,x
        clc
        adc #$0002
        sta $0B21,b,x
        rts

        .databank 0

        ; 95/BE04

      rsUnknown95BE04 ; 95/BE04

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown95AAFF
        sep #$20
        lda $0AF5,b,x
        and #$FC
        ora #$00
        sta $0AF5,b,x
        rep #$20
        rts

        .databank 0

        ; 95/BE17

      rsUnknown95BE17 ; 95/BE17

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown95AEA2
        lda $0B21,b,x
        clc
        adc #$0002
        sta $0B21,b,x
        rts

        .databank 0

        ; 95/BE26

      rsUnknown95BE26 ; 95/BE26

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown96DC7C
        jsl rlUnknown96BCEC
        lda $0B21,b,x
        clc
        adc #$0002
        sta $0B21,b,x
        rts

        .databank 0

        ; 95/BE39

      rsUnknown95BE39 ; 95/BE39

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown95BFB3
        phx
        cpx #$0000
        bne _BE6E
        pha
        lda $0D52,b
        sta wR0
        lda $0D5B,b
        jsl rlUnknown95DBDE
        sep #$20
        lda $0B7D,b
        sta $0C03,b
        rep #$20
        pla
        pha
        xba
        jsr rsUnknown95DCA3
        pla
        lda $0D52,b
        sta wR0
        lda $0D5B,b
        jsl rlUnknown95DBDE
        bra _BE98


        _BE6E
        pha
        lda $0D60,b
        sta wR0
        lda $0D69,b
        jsl rlUnknown95DBDE
        sep #$20
        lda $0BC0,b
        sta $0C03,b
        rep #$20
        pla
        pha
        xba
        jsr rsUnknown95DD4F
        pla
        lda $0D60,b
        sta wR0
        lda $0D69,b
        jsl rlUnknown95DBDE

        _BE98
        plx
        lda $0B21,b,x
        clc
        adc #$0002
        sta $0B21,b,x
        rts

        .databank 0

        ; 95/BEA4

      rsUnknown95BEA4 ; 95/BEA4

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown96F9BF
        lda $0AE4,b
        bit #$0008
        beq _BEC3
        phx
        cpx #$0000
        beq _BEBB
        ldx #$0000
        bra _BEBE


        _BEBB
        ldx #$0043

        _BEBE
        jsl rlUnknown95AB53
        plx

        _BEC3
        lda $0B21,b,x
        clc
        adc #$0002
        sta $0B21,b,x
        rts

        .databank 0

        ; 95/BECE

      rsUnknown95BECE ; 95/BECE

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown95BFB3
        xba
        pha
        sep #$20
        lda $0AF5,b,x
        and #$FC
        ora #1,s
        sta $0AF5,b,x
        rep #$20
        pla
        lda $0B21,b,x
        clc
        adc #$0002
        sta $0B21,b,x
        rts

        .databank 0

        ; 95/BEED

      rsUnknown95BEED ; 95/BEED

        .al
        .xl
        .autsiz
        .databank ?

        cpx #$0000
        bne _BEF7
        lda #$0000
        bra _BEFA


        _BEF7
        lda #$0001

        _BEFA
        pha
        jsr rsUnknown95BFB3
        xba
        and #$0003
        beq _BF13
        cmp #$0001
        beq _BF1A
        cmp #$0002
        beq _BF21
        cmp #$0003
        beq _BF30

        _BF13
        pla
        jsl rlUnknown95D9BE
        bra _BF3F


        _BF1A
        pla
        jsl rlUnknown95D963
        bra _BF3F


        _BF21
        pla
        sep #$20
        lda $0AF4,b,x
        and #$7F
        sta $0AF4,b,x
        rep #$20
        bra _BF3F


        _BF30
        pla
        sep #$20
        lda $0AF4,b,x
        ora #$80
        sta $0AF4,b,x
        rep #$20
        bra _BF3F


        _BF3F
        lda $0B21,b,x
        clc
        adc #$0002
        sta $0B21,b,x
        rts

        .databank 0

        ; 95/BF4A

      rsUnknown95BF4A ; 95/BF4A

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda $0AF4,b,x
        ora #$40
        sta $0AF4,b,x
        rep #$20
        lda $0B21,b,x
        clc
        adc #$0002
        sta $0B21,b,x
        rts

        .databank 0

        ; 95/BF61

      rsUnknown95BF61 ; 95/BF61

        .al
        .xl
        .autsiz
        .databank ?

        lda $0B08,b,x
        bne _BF76
        jsl rlUnknown95C057
        sep #$20
        lda $0AF3,b,x
        ora #$40
        sta $0AF3,b,x
        rep #$20

        _BF76
        sep #$20
        lda $0AF4,b,x
        ora #$40
        sta $0AF4,b,x
        rep #$20
        lda $0B21,b,x
        clc
        adc #$0002
        sta $0B21,b,x
        rts

        .databank 0

        ; 95/BF8D

      rsUnknown95BF8D ; 95/BF8D

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda $0AF3,b,x
        and #$FE
        sta $0AF3,b,x
        rep #$20
        lda $0B21,b,x
        clc
        adc #$0002
        sta $0B21,b,x
        rts

        .databank 0

        ; 95/BFA4

      rsUnknown95BFA4 ; 95/BFA4

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown95C697
        lda $0B21,b,x
        clc
        adc #$0002
        sta $0B21,b,x
        rts

        .databank 0

        ; 95/BFB3

      rsUnknown95BFB3 ; 95/BFB3

        .al
        .xl
        .autsiz
        .databank ?

        phy
        lda $0B1A,b,x
        sta lR18+1
        lda $0B21,b,x
        sta lR18
        ldy #$0000
        lda [lR18],y
        dec a
        ply
        rts

        .databank 0

        ; 95/BFC6

      rsUnknown95BFC6 ; 95/BFC6

        .as
        .xl
        .autsiz
        .databank ?

        pha
        sta $4202,b
        lda $0B15,b,x
        sta $4203,b
        nop
        nop
        nop
        lda $4216,b
        asl a
        lda #$00
        adc #$00
        sta wR12+1
        lda $4217,b
        sta wR12
        pla
        sta $4202,b
        lda $0B16,b,x
        sta $4203,b
        nop
        nop
        nop
        lda $4216,b
        clc
        adc wR12
        clc
        adc wR12+1
        rts

        .databank 0

        ; 95/BFF9

      rsUnknown95BFF9 ; 95/BFF9

        .al
        .xl
        .autsiz
        .databank ?

        phy
        lda $0B1A,b,x
        sta lR18+1
        lda $0B19,b,x
        sta lR18
        sta wR9
        ldy #$0002
        lda $0B1D,b,x
        and #$00FF
        asl a
        clc
        adc [lR18],y
        clc
        adc lR18
        sta lR18
        ldy #$0000
        lda [lR18],y
        clc
        adc wR9
        ply
        rts

        .databank 0

        ; 95/C022

      rlUnknown95C022 ; 95/C022

        .al
        .xl
        .autsiz
        .databank ?

        phx
        sep #$20
        lda $0AF3,b,x
        and #$BF
        sta $0AF3,b,x
        rep #$20

        _C02F
        jsr rsUnknown95BFB3
        and #$00FF
        cmp #$00FD
        beq _C055
        cmp #$00F3
        beq _C04B
        lda $0B21,b,x
        clc
        adc #$0002
        sta $0B21,b,x
        bra _C02F


        _C04B
        lda $0B21,b,x
        clc
        adc #$0002
        sta $0B21,b,x

        _C055
        plx
        rtl

        .databank 0

        ; 95/C057

      rlUnknown95C057 ; 95/C057

        .al
        .xl
        .autsiz
        .databank ?

        phx
        sep #$20
        cpx #$0000
        bne _C06A
        lda $7FE184
        inc a
        sta $7FE184
        bra _C073


        _C06A
        lda $7FE185
        inc a
        sta $7FE185

        _C073
        rep #$20
        plx
        rtl

        .databank 0

        ; 95/C077

      rlUnknown95C077 ; 95/C077

        .al
        .xl
        .autsiz
        .databank ?

        phx
        sep #$20
        cpx #$0000
        beq _C08A
        lda $7FE184
        inc a
        sta $7FE184
        bra _C093


        _C08A
        lda $7FE185
        inc a
        sta $7FE185

        _C093
        rep #$20
        plx
        rtl

        .databank 0

        ; 95/C097

      rlUnknown95C097 ; 95/C097

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$00
        sta $7FE184
        sta $7FE185
        rep #$20
        rtl

        .databank 0

        ; 95/C0A6

      rlUnknown95C0A6 ; 95/C0A6

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7FE184
        and #$00FF
        beq _C0CC
        ldx #$0000
        lda $0AF3,b,x
        bit #$0040
        beq _C0CC
        jsl rlUnknown95C022
        sep #$20
        lda $7FE184
        dec a
        sta $7FE184
        rep #$20

        _C0CC
        lda $7FE185
        and #$00FF
        beq _C0F1
        ldx #$0043
        lda $0AF3,b,x
        bit #$0040
        beq _C0F1
        jsl rlUnknown95C022
        sep #$20
        lda $7FE185
        dec a
        sta $7FE185
        rep #$20

        _C0F1
        plx
        rtl

        .databank 0

        ; 95/C0F3

      rsUnknown95C0F3 ; 95/C0F3

        ; Reads the stack above its return address, but in the emulator log every
        ; caller continues right after the call: no inline arguments.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        pha
        lda $7FFC59
        bit #$0020
        bne _C119
        lda $7FFC59
        bit #$0010
        beq _C177
        lda $0AF9,b,x
        lsr a
        lsr a
        lsr a
        phx
        tax
        lda $998B0E,x
        plx
        and #$00FF
        beq _C177

        _C119
        lda #1,s
        cmp #$0011
        bne _C125
        lda #$0021
        bra _C175


        _C125
        cmp #$0012
        bne _C12F
        lda #$0022
        bra _C175


        _C12F
        cmp #$0013
        bne _C139
        lda #$0023
        bra _C175


        _C139
        cmp #$0014
        bne _C143
        lda #$0024
        bra _C175


        _C143
        cmp #$0015
        bne _C14D
        lda #$0025
        bra _C175


        _C14D
        cmp #$0016
        bne _C157
        lda #$0026
        bra _C175


        _C157
        cmp #$0017
        bne _C161
        lda #$0027
        bra _C175


        _C161
        cmp #$0018
        bne _C16B
        lda #$0028
        bra _C175


        _C16B
        cmp #$0019
        bne _C175
        lda #$0029
        bra _C175


        _C175
        sta #1,s

        _C177
        pla
        plx
        rts

        .databank 0

        ; 95/C17A

      rsUnknown95C17A ; 95/C17A

        ; Reads the stack above its return address, but in the emulator log every
        ; caller continues right after the call: no inline arguments.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        pha
        lda $7FFC59
        cpx #$0000
        bne _C18A
        bit #$0100
        bra _C18D


        _C18A
        bit #$0200

        _C18D
        beq _C1A8
        lda #1,s
        cmp #$008C
        beq _C1A5
        cmp #$008E
        beq _C1A5
        cmp #$006D
        beq _C1A5
        cmp #$0047
        bne _C1A8

        _C1A5
        inc a
        sta #1,s

        _C1A8
        pla
        plx
        rts

        .databank 0

        ; 95/C1AB

      rlUnknown95C1AB ; 95/C1AB

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        php
        rep #$20
        lda $0B24,b,x
        sta wR6
        lda $0AF9,b,x
        and #$01FF
        jsl rlUnknown95D9DC
        bcc _C1CA
        pha
        lda wR6
        eor #$8000
        sta wR6
        pla

        _C1CA
        sec
        sbc $7FE198
        sta wR0
        sep #$20
        lda $0B17,b,x
        bmi _C1DF
        rep #$20
        and #$00FF
        bra _C1E4


        _C1DF
        .as
        rep #$20
        ora #$FF00

        _C1E4
        clc
        adc wR0
        jsl rlUnknown95A164
        sta wR0
        lda $0AFB,b,x
        sec
        sbc $0AFD,b,x
        xba
        clc
        adc $7FE19A
        and #$00FF
        sta wR1
        lda $0B18,b,x
        and #$00FF
        clc
        adc wR1
        and #$00FF
        sta wR1
        lda $0B1D,b,x
        and #$00FF
        cmp #$00FE
        bne _C21B
        plp
        bra _C272


        _C21B
        lda $0B24,b,x
        and #$7FFF
        sta wR4
        lda $0B25,b,x
        and #$FF00
        sta wR5
        phx
        sep #$20
        phb
        lda $0B1B,b,x
        pha
        plb
        .databank ?
        rep #$20
        jsr rsUnknown95BFF9
        pha
        inc a
        tay
        phx
        lda wR6
        bit #$8000
        bne _C247
        clc
        bra _C248


        _C247
        sec

        _C248
        php
        lda $0AF5,b,x
        bit #$0040
        beq _C256
        plp
        jml _C25B


        _C256
        plp
        jsl rlUnknown95C51F

        _C25B
        plx
        lda $0B1A,b,x
        sta lR18+1
        pla
        sta lR18
        ldy #$0000
        lda [lR18],y
        plb
        .databank ?
        plx
        plp
        bcc _C272
        jsl rlUnknown95C275

        _C272
        ply
        plx
        rtl

        .databank 0

        ; 95/C275

      rlUnknown95C275 ; 95/C275

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        phy
        cpx #$0000
        beq _C284
        cpx #$0043
        beq _C284
        bra _C2A5


        _C284
        pha
        lda $0B28,b,x
        sta lR18+1
        lda $0B27,b,x
        sta lR18
        lda $0B2B,b,x
        sta lR19+1
        lda $0B2A,b,x
        sta lR19
        lda $0B2D,b,x
        sta wR0
        pla
        jsl rlUnknown95C2A9
        bra _C2A5


        _C2A5
        ply
        plx
        pla
        rtl

        .databank 0

        ; 95/C2A9

      rlUnknown95C2A9 ; 95/C2A9

        .al
        .xl
        .autsiz
        .databank ?

        phy
        and #$00FF
        cmp #$00FF
        beq _C2BE
        asl a
        tay
        lda [lR19],y
        clc
        adc lR19
        sta lR19
        jsr rsUnknown95C2C0

        _C2BE
        ply
        rtl

        .databank 0

        ; 95/C2C0

      rsUnknown95C2C0 ; 95/C2C0

        .al
        .xl
        .autsiz
        .databank ?

        phy
        lda lR18
        sta lR20
        lda lR18+1
        sta lR20+1
        ldy #$0000
        lda [lR19],y
        and #$00FF
        inc lR19
        tax
        ldy wR0

        _C2D6
        phy
        ldy #$0000
        lda [lR19],y
        inc lR19
        inc lR19
        clc
        adc lR20
        sta lR18
        lda #$0000
        adc lR20+2
        sep #$20
        sta lR18+2
        rep #$20
        lda [lR19],y
        inc lR19
        inc lR19
        ply
        jsl rlUnknown95C43E
        tya
        clc
        adc #$0100
        tay
        dec x
        bne _C2D6
        ply
        rts

        .databank 0

        ; 95/C306

    .endsection Unsorted95B993Section


    .section Unsorted95C368Section

      .al
      .xl

      rlUnknown95C368 ; 95/C368

        .al
        .xl
        .autsiz
        .databank ?

        lda $0CC4,b
        and #$00FF
        beq _C3B8
        cmp #$0011
        bcc _C37F
        lda #$0010
        sep #$20
        sta $0CC4,b
        rep #$20

        _C37F
        tay
        dec a
        ora #$0700
        sta $4202,b
        nop
        nop
        nop
        ldx $4216,b
        lda $0CC5,b
        and #$FFFE
        sta $0CC5,b

        _C396
        lda $0CC5,b
        beq _C3B8
        sec
        sbc $0CCE,b,x
        bcs _C3A6
        jsr rsUnknown95C3EA
        bra _C3B8


        _C3A6
        sta $0CC5,b
        jsr rsUnknown95C3C2
        txa
        sec
        sbc #$0007
        tax
        dec $0CC4,b
        dec y
        bne _C396

        _C3B8
        lda #$0C00
        sta $0CC5,b
        stz $0CC7,b
        rtl

        .databank 0

        ; 95/C3C2

      rsUnknown95C3C2 ; 95/C3C2

        .al
        .xl
        .autsiz
        .databank ?

        lda $0CCC,b,x
        sta $2116,b
        lda #$1801
        sta $4300,b
        lda $0CC9,b,x
        sta $4302,b
        lda $0CCA,b,x
        sta $4303,b
        lda $0CCE,b,x
        sta $4305,b
        sep #$20
        lda #$01
        sta $420B,b
        rep #$20
        rts

        .databank 0

        ; 95/C3EA

      rsUnknown95C3EA ; 95/C3EA

        .al
        .xl
        .autsiz
        .databank ?

        lda $0CCC,b,x
        sta $2116,b
        lda #$1801
        sta $4310,b
        lda $0CC9,b,x
        sta $4312,b
        lda $0CCA,b,x
        sta $4313,b
        lda $0CC5,b
        sta $4315,b
        lda $0CC5,b
        lsr a
        clc
        adc $0CCC,b,x
        sta $0CCC,b,x
        lda $0CC9,b,x
        clc
        adc $0CC5,b
        sta $0CC9,b,x
        lda #$0000
        adc $0CCB,b,x
        sep #$20
        sta $0CCB,b,x
        rep #$20
        lda $0CCE,b,x
        sec
        sbc $0CC5,b
        sta $0CCE,b,x
        sep #$20
        lda #$02
        sta $420B,b
        rep #$20
        rts

        .databank 0

        ; 95/C43E

    .endsection Unsorted95C368Section


    .section Unsorted95C43ESection

      .al
      .xl

      rlUnknown95C43E ; 95/C43E

        .al
        .xl
        .autsiz
        .databank ?

        phx
        pha
        lda $0CC4,b
        and #$00FF
        cmp #$0010
        bcc _C44F
        pla
        sec
        bra _C478


        _C44F
        ora #$0700
        sta $4202,b
        nop
        nop
        nop
        ldx $4216,b
        pla
        sta $0CCE,b,x
        clc
        adc $0CC7,b
        sta $0CC7,b
        tya
        sta $0CCC,b,x
        lda lR18
        sta $0CC9,b,x
        lda lR18+1
        sta $0CCA,b,x
        inc $0CC4,b
        clc

        _C478
        plx
        rtl

        .databank 0

        ; 95/C47A

      rlUnknown95C47A ; 95/C47A

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phy
        lda $7FE18A
        beq _C4E0
        lda #$0800
        cmp $0CC7,b
        bcc _C4E0
        beq _C4E0
        pha
        lda $7FE18F
        tay
        lda $7FE18C
        sta lR18
        lda $7FE18D
        sta lR18+1
        pla
        sec
        sbc $0CC7,b
        cmp $7FE18A
        bcc _C4BA
        lda $7FE18A
        jsl rlUnknown95C43E
        lda #$0000
        sta $7FE18A
        bra _C4E0


        _C4BA
        pha
        jsl rlUnknown95C43E
        lda $7FE18A
        sec
        sbc #1,s
        sta $7FE18A
        lda $7FE18C
        clc
        adc #1,s
        sta $7FE18C
        pla
        lsr a
        clc
        adc $7FE18F
        sta $7FE18F

        _C4E0
        ply
        pla
        rtl

        .databank 0

        ; 95/C4E3

      rlUnknown95C4E3 ; 95/C4E3

        .al
        .xl
        .autsiz
        .databank ?

        phx
        pha
        lda $7FE18A
        beq _C4EF
        pla
        sec
        bra _C506


        _C4EF
        pla
        sta $7FE18A
        tya
        sta $7FE18F
        lda lR18
        sta $7FE18C
        lda lR18+1
        sta $7FE18D
        clc

        _C506
        plx
        rtl

        .databank 0

        ; 95/C508

      rlUnknown95C508 ; 95/C508

        .al
        .xl
        .autsiz
        .databank ?

        lda bDecompressionArrayFlag,b
        and #$00FF
        beq _C518
        sep #$20
        lda #$FF
        rep #$20
        bra _C51E


        _C518
        sep #$20
        lda #$00
        rep #$20

        _C51E
        rtl

        .databank 0

        ; 95/C51F

      rlUnknown95C51F ; 95/C51F

        .al
        .xl
        .autsiz
        .databank ?

        bcs _C52C
        lda wR5
        and #$BFFF
        sta wR5
        jml rlPushToOAMBuffer


        _C52C
        lda $0000,b,y
        bne _C532
        rtl


        _C532
        sta wR2
        inc y
        inc y
        lda wR5
        ora #$4000
        sta wR5
        ldx wNextFreeSpriteOffset,b
        clc

        _C541
        lda $0000,b,y
        bmi _C568
        lda wR0
        sec
        sbc $0000,b,y
        sec
        sbc #$0008
        sta aSpriteBuffer,b,x
        bit #$0100
        beq _C566
        lda aOAMSizeBitTable,x
        sta wR3
        lda (wR3)
        ora aOAMUpperXBitTable,x
        sta (wR3)

        _C566
        bra _C589


        _C568
        lda wR0
        sec
        sec
        sbc $0000,b,y
        sec
        sbc #$0010
        sta aSpriteBuffer,b,x
        bit #$0100
        beq _C589
        lda aOAMSizeBitTable,x
        sta wR3
        lda (wR3)
        ora aOAMUpperXBitTable,x
        sta (wR3)

        _C589
        clc
        lda $0002,b,y
        bit #$0080
        bne _C597
        and #$007F
        bra _C59A


        _C597
        ora #$FF80

        _C59A
        clc
        adc wR1
        sta $1C01,b,x
        clc
        adc #$0010
        cmp #$0100
        bcc _C5AF
        lda #$00F0
        sta $1C01,b,x

        _C5AF
        clc
        lda $0000,b,y
        bpl _C5C3
        lda aOAMSizeBitTable,x
        sta wR3
        lda (wR3)
        ora $8083C9,x
        sta (wR3)

        _C5C3
        lda $0003,b,y
        adc wR4
        eor wR5
        sta $1C02,b,x
        txa
        adc #$0004
        and #$01FF
        tax
        tya
        adc #$0005
        tay
        dec wR2
        beq _C5E2
        jml _C541


        _C5E2
        stx wNextFreeSpriteOffset,b
        rtl

        .databank 0

        ; 95/C5E6

      rsUnknown95C5E6 ; 95/C5E6

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx $0AE9,b
        lda $0AF9,b,x
        sta wR0
        ldx $0AEB,b
        lda $0AF9,b,x
        sta wR1
        lda wR0
        cmp wR1
        bcc _C609
        lda #$0000
        sta wR0
        lda #$8000
        sta wR1
        bra _C613


        _C609
        lda #$8000
        sta wR0
        lda #$0000
        sta wR1

        _C613
        ldx $0AE9,b
        jsr rsUnknown95C63B
        bcc _C639
        lda $0B24,b,x
        and #$7FFF
        ora wR0
        sta $0B24,b,x
        ldx $0AEB,b
        jsr rsUnknown95C63B
        bcc _C639
        lda $0B24,b,x
        and #$7FFF
        ora wR1
        sta $0B24,b,x

        _C639
        plx
        rts

        .databank 0

        ; 95/C63B

      rsUnknown95C63B ; 95/C63B

        .al
        .xl
        .autsiz
        .databank ?

        phy
        lda $0AF3,b,x
        bit #$0001
        bne _C694
        lda $0AFD,b,x
        bne _C694
        lda $0ADE,b
        and #$0003
        cmp #$0003
        bne _C694
        lda $7FE186
        bit #$0002
        bne _C694
        lda $7FE186
        bit #$0001
        beq _C670
        sep #$20
        ora #$02
        sta $7FE186
        rep #$20

        _C670
        cpx #$0000
        bne _C67A
        lda $0D4E,b
        bra _C67D


        _C67A
        lda $0D5C,b

        _C67D
        cmp #$0043
        beq _C694
        cmp #$0044
        beq _C694
        cmp #$0045
        beq _C694
        cmp #$0046
        beq _C694
        sec
        bra _C695


        _C694
        clc

        _C695
        ply
        rts

        .databank 0

        ; 95/C697

      rlUnknown95C697 ; 95/C697

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $0AF9,b,x
        sta wR0
        phx
        cpx #$0000
        bne _C6A8
        ldx #$0043
        bra _C6AB


        _C6A8
        ldx #$0000

        _C6AB
        lda $0AF9,b,x
        sta wR1
        plx
        lda wR0
        cmp wR1
        bcc _C6C2
        lda $0B24,b,x
        and #$7FFF
        sta $0B24,b,x
        bra _C6CB


        _C6C2
        lda $0B24,b,x
        ora #$8000
        sta $0B24,b,x

        _C6CB
        plx
        rtl

        .databank 0

        ; 95/C6CD

      rlUnknown95C6CD ; 95/C6CD

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda $0AF6,b,x
        bit #$0001
        beq _C6DB
        jml _C7C7


        _C6DB
        lda $0B08,b,x
        bne _C6E4
        jml _C7C1


        _C6E4
        bpl _C6EA
        jml _C73C


        _C6EA
        sta wR0
        lda $0AF9,b,x
        cmp $0B00,b,x
        beq _C6F8
        bcc _C718
        bcs _C700

        _C6F8
        lda $0AF8,b,x
        cmp $0AFF,b,x
        bcc _C718

        _C700
        lda $0AF8,b,x
        sec
        sbc $0AFF,b,x
        sta wR0
        lda $0AFF,b,x
        sta $0AF8,b,x
        lda $0B00,b,x
        sta $0AF9,b,x
        stz $0B08,b,x

        _C718
        lda wR0
        sec
        jsr rsUnknown95C858
        bcc _C738
        sta wR0
        lda $0AFF,b,x
        sec
        sbc wR0
        sta $0AFF,b,x
        lda $0B01,b,x
        sbc #$0000
        sep #$20
        sta $0B01,b,x
        rep #$20

        _C738
        jml _C78F


        _C73C
        and #$7FFF
        sta wR0
        lda $0AF9,b,x
        cmp $0B00,b,x
        beq _C74D
        bcc _C757
        bcs _C76F

        _C74D
        lda $0AF8,b,x
        cmp $0AFF,b,x
        beq _C757
        bcs _C76F

        _C757
        lda $0AFF,b,x
        sec
        sbc $0AF8,b,x
        sta wR0
        lda $0AFF,b,x
        sta $0AF8,b,x
        lda $0B00,b,x
        sta $0AF9,b,x
        stz $0B08,b,x

        _C76F
        lda wR0
        sec
        jsr rsUnknown95C90F
        bcc _C78F
        sta wR0
        lda $0AFF,b,x
        clc
        adc wR0
        sta $0AFF,b,x
        lda $0B01,b,x
        adc #$0000
        sep #$20
        sta $0B01,b,x
        rep #$20

        _C78F
        lda $0B08,b,x
        bne _C7C1
        lda $0B0E,b,x
        bne _C7AB
        lda $0AF4,b,x
        bit #$0040
        beq _C7AB
        sep #$20
        lda $0AF3,b,x
        and #$FE
        sta $0AF3,b,x

        _C7AB
        sep #$20
        lda $0AF4,b,x
        and #$FE
        sta $0AF4,b,x
        lda $0AF5,b,x
        and #$FC
        ora #$02
        sta $0AF5,b,x
        rep #$20

        _C7C1
        jsr rsUnknown95C802
        ply
        plx
        rtl


        _C7C7
        lda $0B08,b,x
        beq _C7FF
        bmi _C7E4
        clc
        adc $0AF8,b,x
        sta $0AF8,b,x
        lda $0AFA,b,x
        adc #$0000
        sep #$20
        sta $0AFA,b,x
        rep #$20
        bra _C7FF


        _C7E4
        and #$7FFF
        sta wR2
        lda $0AF8,b,x
        sec
        sbc wR2
        sta $0AF8,b,x
        lda $0AFA,b,x
        sbc #$0000
        sep #$20
        sta $0AFA,b,x
        rep #$20

        _C7FF
        ply
        plx
        rtl

        .databank 0

        ; 95/C802

      rsUnknown95C802 ; 95/C802

        .al
        .xl
        .autsiz
        .databank ?

        lda $0B0A,b,x
        cmp #$FFFF
        bne _C82A
        lda $0B08,b,x
        and #$8000
        pha
        lda $0B08,b,x
        and #$7FFF
        lsr a
        bne _C822
        lda #$0000
        sta $0B0A,b,x
        bra _C824


        _C822
        ora #1,s

        _C824
        sta $0B08,b,x
        pla
        bra _C857


        _C82A
        lda $0B0A,b,x
        bit #$7FFF
        beq _C857
        and #$8000
        pha
        lda $0B0A,b,x
        and #$7FFF
        pha
        lda $0B08,b,x
        and #$7FFF
        sec
        sbc #1,s
        bcs _C850
        lda #$0000
        sta $0B0A,b,x
        bra _C852


        _C850
        ora #3,s

        _C852
        sta $0B08,b,x
        pla
        pla

        _C857
        rts

        .databank 0

        ; 95/C858

      rsUnknown95C858 ; 95/C858

        ; Reads the stack above its return address, but in the emulator log every
        ; caller continues right after the call: no inline arguments.
        .al
        .xl
        .autsiz
        .databank ?

        php
        pha
        sec
        jsr rsUnknown95CA01
        bcc _C89B
        xba
        pha
        lda #3,s
        and #$FF00
        beq _C888
        cmp #1,s
        bcc _C888
        sec
        sbc #1,s
        sta #1,s
        lda $0AF8,b,x
        clc
        adc #1,s
        sta $0AF8,b,x
        lda $0AFA,b,x
        adc #$0000
        sep #$20
        sta $0AFA,b,x
        rep #$20

        _C888
        lda $0AF8,b,x
        sta $0AFF,b,x
        lda $0AF9,b,x
        sta $0B00,b,x
        stz $0B08,b,x
        pla
        pla
        bra _C8F1


        _C89B
        pla
        sta wR0
        sta wR2
        lda $0AF8,b,x
        clc
        adc wR2
        sta $0AF8,b,x
        lda $0AFA,b,x
        adc #$0000
        sep #$20
        sta $0AFA,b,x
        rep #$20
        jsr rsUnknown95C9C3
        lda lR19+1
        bpl _C8F1
        lda lR19
        eor #$FFFF
        inc a
        sta wR1
        lda $0AF8,b,x
        sec
        sbc wR1
        sta $0AF8,b,x
        lda $0AFA,b,x
        sbc #$0000
        sep #$20
        sta $0AFA,b,x
        rep #$20
        lda wR0
        sec
        sbc wR1
        sta wR0
        lda $0AF8,b,x
        sta $0AFF,b,x
        lda $0AF9,b,x
        sta $0B00,b,x
        stz $0B08,b,x

        _C8F1
        plp
        bcc _C8FE
        lda wR0
        and #$7FFF
        jsr rsUnknown95D2A4
        bra _C903


        _C8FE
        lda wR0
        jsr rsUnknown95D3A3

        _C903
        lda wR2
        sec
        sbc wR0
        beq _C90D
        sec
        bra _C90E


        _C90D
        clc

        _C90E
        rts

        .databank 0

        ; 95/C90F

      rsUnknown95C90F ; 95/C90F

        ; Reads the stack above its return address, but in the emulator log every
        ; caller continues right after the call: no inline arguments.
        .al
        .xl
        .autsiz
        .databank ?

        php
        pha
        clc
        jsr rsUnknown95CA01
        bcc _C952
        xba
        pha
        lda #3,s
        and #$FF00
        beq _C93F
        cmp #1,s
        bcc _C93F
        sec
        sbc #1,s
        sta #1,s
        lda $0AF8,b,x
        sec
        sbc #1,s
        sta $0AF8,b,x
        lda $0AFA,b,x
        sbc #$0000
        sep #$20
        sta $0AFA,b,x
        rep #$20

        _C93F
        lda $0AF8,b,x
        sta $0AFF,b,x
        lda $0AF9,b,x
        sta $0B00,b,x
        stz $0B08,b,x
        pla
        pla
        bra _C9A8


        _C952
        pla
        sta wR0
        sta wR2
        lda $0AF8,b,x
        sec
        sbc wR2
        sta $0AF8,b,x
        lda $0AFA,b,x
        sbc #$0000
        sep #$20
        sta $0AFA,b,x
        rep #$20
        jsr rsUnknown95C9C3
        lda lR18+1
        bpl _C9A8
        lda lR18
        eor #$FFFF
        inc a
        sta wR1
        lda $0AF8,b,x
        clc
        adc wR1
        sta $0AF8,b,x
        lda $0AFA,b,x
        adc #$0000
        sep #$20
        sta $0AFA,b,x
        rep #$20
        lda wR0
        sec
        sbc wR1
        sta wR0
        lda $0AF8,b,x
        sta $0AFF,b,x
        lda $0AF9,b,x
        sta $0B00,b,x
        stz $0B08,b,x

        _C9A8
        plp
        bcc _C9B2
        lda wR0
        jsr rsUnknown95D322
        bra _C9B7


        _C9B2
        lda wR0
        jsr rsUnknown95D420

        _C9B7
        lda wR2
        sec
        sbc wR0
        beq _C9C1
        sec
        bra _C9C2


        _C9C1
        clc

        _C9C2
        rts

        .databank 0

        ; 95/C9C3

      rsUnknown95C9C3 ; 95/C9C3

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $0AF8,b,x
        sta lR18
        lda $0AF9,b,x
        sta lR18+1
        jsl rlUnknown95B5D0
        pha
        clc
        adc lR18+1
        sta wR9
        lda lR18
        sta lR19
        lda #$0198
        sec
        sbc wR9
        sta lR19+1
        bpl _C9F1
        sep #$20
        lda lR19
        eor #$FF
        inc a
        sta lR19
        rep #$20

        _C9F1
        pla
        sta wR9
        lda lR18+1
        sec
        sbc wR9
        sec
        sbc #$0068
        sta lR18+1
        plx
        rts

        .databank 0

        ; 95/CA01

      rsUnknown95CA01 ; 95/CA01

        .al
        .xl
        .autsiz
        .databank ?

        phx
        php
        lda $0AF4,b,x
        bit #$0001
        beq _CA0E
        plp
        bra _CA11


        _CA0E
        plp
        bra _CA71


        _CA11
        php
        lda $0AFD,b,x
        bne _CA1A
        plp
        bra _CA1D


        _CA1A
        plp
        bra _CA71


        _CA1D
        php
        cpx #$0000
        bne _CA2B
        lda $0AF9,b,x
        ldx #$0043
        bra _CA34


        _CA2B
        ldx #$0043
        lda $0AF9,b,x
        ldx #$0000

        _CA34
        plp
        bcc _CA3E
        cmp $0AF9,b,x
        bcc _CA43
        bra _CA71


        _CA3E
        cmp $0AF9,b,x
        bcc _CA71

        _CA43
        ldx $0AE9,b
        lda $0AF9,b,x
        ldx $0AEB,b
        sec
        sbc $0AF9,b,x
        bpl _CA56
        eor #$FFFF
        inc a

        _CA56
        pha
        ldx $0AE9,b
        jsl rlUnknown95B5D0
        pha
        ldx $0AEB,b
        jsl rlUnknown95B5D0
        clc
        adc #1,s
        cmp #3,s
        beq _CA6F
        bcs _CA77

        _CA6F
        pla
        pla

        _CA71
        lda #$0000
        clc
        bra _CA7F


        _CA77
        sec
        sbc #3,s
        sta #3,s
        pla
        pla
        sec

        _CA7F
        plx
        rts

        .databank 0

        ; 95/CA81

    .endsection Unsorted95C43ESection


    .section Unsorted95CA81Section

      .al
      .xl

      rlUnknown95CA81 ; 95/CA81

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta $0AF1,b
        rtl

        .databank 0

        ; 95/CA88

    .endsection Unsorted95CA81Section


    .section Unsorted95CA88Section

      .al
      .xl

      rlUnknown95CA88 ; 95/CA88

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda $0AE8,b
        bit #$0080
        beq _CAAB
        lda $0D4E,b
        jsl rlUnknown95B7F8
        sta wR0
        jsl rlUnknown95B184
        bcc _CAA6
        lda #$0040
        bra _CAC2


        _CAA6
        lda #$0000
        bra _CAC2


        _CAAB
        lda $0D5C,b
        jsl rlUnknown95B7F8
        sta wR0
        jsl rlUnknown95B184
        bcc _CABF
        lda #$0080
        bra _CAC2


        _CABF
        lda #$00C0

        _CAC2
        sep #$20
        pha
        ora wR0
        sta $0AF1,b
        pla
        ora #$18
        sta $0AF2,b
        rep #$20
        ply
        plx
        rtl

        .databank 0

        ; 95/CAD5

      rlUnknown95CAD5 ; 95/CAD5

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $0AF1,b
        bit #$003F
        beq _CB3B
        jsl rlUnknown95CB97
        bit #$0080
        bne _CAEC
        ldx #$0000
        bra _CAEF


        _CAEC
        ldx #$0043

        _CAEF
        bit #$0040
        beq _CB0A
        and #$003F
        xba
        lsr a
        lsr a
        sec
        jsr rsUnknown95C858
        bcc _CB06
        stz $0B08,b,x
        stz $0B0A,b,x

        _CB06
        jml _CB1C


        _CB0A
        and #$003F
        xba
        lsr a
        lsr a
        sec
        jsr rsUnknown95C90F
        bcc _CB1C
        stz $0B08,b,x
        stz $0B0A,b,x

        _CB1C
        sep #$20
        lda $0AF1,b
        pha
        and #$C0
        xba
        pla
        and #$3F
        lsr a
        pha
        lsr a
        clc
        adc #1,s
        sta #1,s
        pla
        pha
        xba
        ora #1,s
        sta $0AF1,b
        pla
        rep #$20

        _CB3B
        lda $0AF2,b
        bit #$003F
        beq _CB95
        lda $0AF2,b
        bit #$003F
        beq _CB95
        bit #$0040
        bne _CB66
        and #$003F
        phx
        tax
        lda $98AD65,x
        and #$00FF
        plx
        sep #$20
        sta $0B17,b,x
        rep #$20
        bra _CB7E


        _CB66
        and #$003F
        phx
        tax
        lda $98AD65,x
        and #$00FF
        eor #$FFFF
        inc a
        plx
        sep #$20
        sta $0B17,b,x
        rep #$20

        _CB7E
        sep #$20
        lda $0AF2,b
        pha
        and #$C0
        xba
        pla
        and #$3F
        dec a
        pha
        xba
        ora #1,s
        sta $0AF2,b
        pla
        rep #$20

        _CB95
        plx
        rtl

        .databank 0

        ; 95/CB97

      rlUnknown95CB97 ; 95/CB97

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        lda $0AF1,b
        bit #$0080
        bne _CBB5
        jsl rlUnknown95B184
        bne _CBB1
        lda $0AF9,b
        cmp #$0100
        bcc _CBC9
        bra _CBD5


        _CBB1
        bcc _CBD5
        bra _CBC9


        _CBB5
        jsl rlUnknown95B184
        bne _CBC5
        lda $0AF9,b
        cmp #$0100
        bcc _CBC9
        bra _CBD5


        _CBC5
        bcc _CBC9
        bra _CBD5


        _CBC9
        sep #$20
        lda $0AF1,b
        ora #$40
        sta $0AF1,b
        bra _CBDF


        _CBD5
        .al
        sep #$20
        lda $0AF1,b
        and #$BF
        sta $0AF1,b

        _CBDF
        rep #$20
        plx
        pla
        rtl

        .databank 0

        ; 95/CBE4

      rlUnknown95CBE4 ; 95/CBE4

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda $0AF3,b,x
        bit #$0020
        bne _CC03
        lda $0AFD,b,x
        beq _CC03
        lda $0B13,b,x
        bne _CC03
        lda $0B10,b,x
        bne _CC03
        lda #$0018
        sta $0B10,b,x

        _CC03
        ply
        plx
        rtl

        .databank 0

        ; 95/CC06

      rlUnknown95CC06 ; 95/CC06

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda $0AF3,b,x
        bit #$0020
        beq _CC14
        jml _CCD2


        _CC14
        lda $0AF6,b,x
        bit #$0001
        beq _CC20
        jml rlUnknown95CE46


        _CC20
        lda $0AF5,b,x
        bit #$0080
        beq _CC2C
        jml _CD3E


        _CC2C
        lda $0AF4,b,x
        bit #$0008
        beq _CC38
        jml _CCD5


        _CC38
        lda $0AF3,b,x
        bit #$0010
        beq _CC44
        jml _CCD2


        _CC44
        lda $0B0E,b,x
        bne _CC52
        lda $0AFD,b,x
        bne _CC52
        jml _CCD2


        _CC52
        lda $0B0E,b,x
        bmi _CC62
        lda $0B0E,b,x
        clc
        adc $0AFD,b,x
        bcc _CC99
        bra _CC6B


        _CC62
        lda $0B0E,b,x
        clc
        adc $0AFD,b,x
        bcs _CC99

        _CC6B
        sep #$20
        lda $0AF3,b,x
        and #$F7
        sta $0AF3,b,x
        lda $0AF4,b,x
        and #$DF
        sta $0AF4,b,x
        lda $0AF5,b,x
        and #$FC
        ora #$02
        sta $0AF5,b,x
        rep #$20
        stz $0AFD,b,x
        stz $0B0E,b,x
        lda $0AF3,b,x
        bit #$0004
        bne _CC97

        _CC97
        bra _CCD2


        _CC99
        sta $0AFD,b,x
        beq _CCC8
        lda $0AF3,b,x
        bit #$0004
        bne _CCC8
        xba
        lda $0B12,b,x
        and #$00FF
        xba
        cmp $0AFD,b,x
        bcs _CCB8
        lda #$0001
        bra _CCC5


        _CCB8
        lda $0B0E,b,x
        bmi _CCC2
        lda #$0000
        bra _CCC5


        _CCC2
        lda #$0002

        _CCC5
        jsr rsUnknown95B884

        _CCC8
        lda $0B0E,b,x
        sec
        sbc $0B10,b,x
        sta $0B0E,b,x

        _CCD2
        ply
        plx
        rtl


        _CCD5
        lda $0AF3,b,x
        bit #$0010
        bne _CD3B
        lda $0B0E,b,x
        bne _CCE7
        lda $0AFD,b,x
        beq _CD3B

        _CCE7
        lda $0B0E,b,x
        bmi _CCF7
        lda $0B0E,b,x
        clc
        adc $0AFD,b,x
        bcc _CD2E
        bra _CD00


        _CCF7
        lda $0B0E,b,x
        clc
        adc $0AFD,b,x
        bcs _CD2E

        _CD00
        sep #$20
        lda $0AF3,b,x
        and #$F7
        sta $0AF3,b,x
        lda $0AF4,b,x
        and #$F7
        sta $0AF4,b,x
        lda $0AF4,b,x
        and #$DF
        sta $0AF4,b,x
        lda $0AF5,b,x
        and #$FC
        ora #$02
        sta $0AF5,b,x
        rep #$20
        stz $0AFD,b,x
        stz $0B0E,b,x
        bra _CD3B


        _CD2E
        sta $0AFD,b,x
        lda $0B0E,b,x
        sec
        sbc $0B10,b,x
        sta $0B0E,b,x

        _CD3B
        ply
        plx
        rtl


        _CD3E
        lda $0AF3,b,x
        bit #$0010
        bne _CDA0
        lda $0B0E,b,x
        bne _CD50
        lda $0AFD,b,x
        beq _CDA0

        _CD50
        lda $0B0E,b,x
        bmi _CD60
        lda $0B0E,b,x
        clc
        adc $0AFD,b,x
        bcc _CD93
        bra _CD60


        _CD60
        sep #$20
        lda $0AF3,b,x
        and #$F7
        sta $0AF3,b,x
        lda $0AF5,b,x
        and #$7F
        sta $0AF5,b,x
        lda $0AF4,b,x
        and #$DF
        sta $0AF4,b,x
        lda $0AF3,b,x
        ora #$20
        sta $0AF3,b,x
        lda $0AF5,b,x
        and #$FC
        ora #$02
        sta $0AF5,b,x
        rep #$20
        stz $0B0E,b,x
        bra _CDA0


        _CD93
        sta $0AFD,b,x
        lda $0B0E,b,x
        sec
        sbc $0B10,b,x
        sta $0B0E,b,x

        _CDA0
        ply
        plx
        rtl

        .databank 0

        ; 95/CDA3

      rlUnknown95CDA3 ; 95/CDA3

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda $0B13,b,x
        bne _CDC4
        lda $0AF3,b,x
        bit #$0010
        bne _CDB6
        jml _CE43


        _CDB6
        sep #$20
        lda $0AF3,b,x
        and #$EF
        sta $0AF3,b,x
        rep #$20
        bra _CE43


        _CDC4
        bmi _CDFB
        sta wR0
        lda $0AFD,b,x
        sec
        sbc wR0
        bcc _CDDE
        sta $0AFD,b,x
        xba
        and #$00FF
        cmp $0B04,b,x
        beq _CDDE
        bcs _CDF9

        _CDDE
        lda $0B04,b,x
        and #$00FF
        xba
        sta $0AFD,b,x
        stz $0B13,b,x
        sep #$20
        lda $0AF3,b,x
        and #$EF
        sta $0AF3,b,x
        rep #$20
        bra _CDF9


        _CDF9
        bra _CE43


        _CDFB
        and #$7FFF
        sta wR0
        lda $0AFD,b,x
        clc
        adc wR0
        bcs _CE16
        sta $0AFD,b,x
        xba
        and #$00FF
        cmp $0B04,b,x
        beq _CE16
        bcc _CE43

        _CE16
        lda $0B04,b,x
        and #$00FF
        xba
        sta $0AFD,b,x
        stz $0B13,b,x
        sep #$20
        lda $0AF3,b,x
        and #$EF
        sta $0AF3,b,x
        lda $0AF4,b,x
        and #$DF
        sta $0AF4,b,x
        lda $0AF5,b,x
        and #$FC
        ora #$02
        sta $0AF5,b,x
        rep #$20
        bra _CE43


        _CE43
        ply
        plx
        rtl

        .databank 0

        ; 95/CE46

      rlUnknown95CE46 ; 95/CE46

        .al
        .xl
        .autsiz
        .databank ?

        lda $0AFD,b,x
        clc
        adc $0B0E,b,x
        sta $0AFD,b,x
        cmp #$5800
        bcc _CE5B
        stz $0B0E,b,x
        stz $0B08,b,x

        _CE5B
        ply
        plx
        rtl

        .databank 0

        ; 95/CE5E

      rlUnknown95CE5E ; 95/CE5E

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        sta wR13
        stz wR12
        lda wR0
        sta wR14
        stz wR15
        jsl rlUnsignedDivide32By32
        lda wR12+1
        bne _CE75
        lda #$0100

        _CE75
        ply
        plx
        rtl

        .databank 0

        ; 95/CE78

      rlUnknown95CE78 ; 95/CE78

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        pha
        phx
        clc
        adc $0AFE,b,x
        and #$00FF
        sta wR10
        lda #$0099
        sta wR11
        jsl rlUnsignedMultiply16By16
        lda wR12+1
        plx
        sep #$20
        sta $0B12,b,x
        rep #$20
        pla
        asl a
        sta wR13
        stz wR12
        lda wR0
        lsr a
        sta wR14
        stz wR15
        jsl rlUnsignedDivide32By32
        lda wR12+1
        sta wR1
        lda wR0
        lsr a
        sta wR14
        stz wR15
        jsl rlUnsignedDivide32By32
        lda wR12+1
        sta wR0
        ply
        plx
        rtl

        .databank 0

        ; 95/CEBF

    .endsection Unsorted95CA88Section


    .section Unsorted95CEBFSection

      .al
      .xl

      rsUnknown95CEBF ; 95/CEBF

        .al
        .xl
        .autsiz
        .databank ?

        phx
        php
        jsl rlUnknown95D1C5
        lda wR0
        cmp wR1
        bcc _CED3
        sec
        sbc wR8
        sec
        sbc wR7
        bra _CED9


        _CED3
        clc
        adc wR8
        clc
        adc wR7

        _CED9
        sta wR0
        lda wR1
        sec
        sbc wR0
        bpl _CEED
        eor #$FFFF
        inc a
        sta wR2
        lda #$8000
        bra _CEF2


        _CEED
        sta wR2
        lda #$0000

        _CEF2
        sta wR3
        lda wR2
        sta wR4
        plp
        jsl rlUnknown95B530
        sta wR0
        lda wR2
        jsl rlUnknown95CE5E
        ora wR3
        sta $0B08,b,x
        sta $0B0C,b,x
        lda wR3
        bmi _CF19
        lda $0AF9,b,x
        clc
        adc wR2
        bra _CF1F


        _CF19
        lda $0AF9,b,x
        sec
        sbc wR2

        _CF1F
        pha
        lda $0AF8,b,x
        sta $0AFF,b,x
        pla
        sta $0B00,b,x
        lda wR4
        plx
        rts

        .databank 0

        ; 95/CF2E

    .endsection Unsorted95CEBFSection


    .section Unsorted95CFA0Section

      .al
      .xl

      rsUnknown95CFA0 ; 95/CFA0

        .al
        .xl
        .autsiz
        .databank ?

        phx
        pha
        jsl rlUnknown95D1C5
        lda wR0
        cmp wR1
        bcc _CFB4
        sec
        sbc wR8
        sec
        sbc wR7
        bra _CFBA


        _CFB4
        clc
        adc wR8
        clc
        adc wR7

        _CFBA
        sta wR0
        lda wR1
        sec
        sbc wR0
        bpl _CFCE
        eor #$FFFF
        inc a
        sta wR2
        lda #$8000
        bra _CFD3


        _CFCE
        sta wR2
        lda #$0000

        _CFD3
        sta wR3
        pla
        sta wR0
        lda wR2
        jsl rlUnknown95CE5E
        ora wR3
        sta $0B08,b,x
        sta $0B0C,b,x
        lda wR3
        bmi _CFF2
        lda $0AF9,b,x
        clc
        adc wR2
        bra _CFF8


        _CFF2
        lda $0AF9,b,x
        sec
        sbc wR2

        _CFF8
        pha
        lda $0AF8,b,x
        sta $0AFF,b,x
        pla
        sta $0B00,b,x
        lda wR4
        plx
        rts

        .databank 0

        ; 95/D007

    .endsection Unsorted95CFA0Section


    .section Unsorted95D078Section

      .al
      .xl

      rlUnknown95D078 ; 95/D078

        .al
        .xl
        .autsiz
        .databank ?

        phx
        php
        jsl rlUnknown95D1C5
        lda wR1
        cmp wR0
        bcs _D08C
        sec
        sbc wR8
        sec
        sbc wR7
        bra _D092


        _D08C
        clc
        adc wR8
        clc
        adc wR7

        _D092
        sta wR1
        lda wR1
        sec
        sbc wR0
        bpl _D0A6
        eor #$FFFF
        inc a
        sta wR2
        lda #$8000
        bra _D0AB


        _D0A6
        sta wR2
        lda #$0000

        _D0AB
        sta wR3
        lda wR2
        sta wR4
        plp
        jsl rlUnknown95B530
        sta wR0
        lda wR2
        jsl rlUnknown95CE5E
        ora wR3
        sta $0B08,b,x
        sta $0B0C,b,x
        lda wR3
        bmi _D0D2
        lda $0AF9,b,x
        clc
        adc wR2
        bra _D0D8


        _D0D2
        lda $0AF9,b,x
        sec
        sbc wR2

        _D0D8
        pha
        lda $0AF8,b,x
        sta $0AFF,b,x
        pla
        sta $0B00,b,x
        lda wR4
        plx
        rtl

        .databank 0

        ; 95/D0E7

    .endsection Unsorted95D078Section


    .section Unsorted95D1C5Section

      .al
      .xl

      rlUnknown95D1C5 ; 95/D1C5

        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsl rlUnknown95B626
        cmp #$0004
        bcc _D1D3
        sec
        sbc #$0004

        _D1D3
        sta wR8
        phx
        cpx #$0000
        bne _D1E0
        ldx #$0043
        bra _D1E3


        _D1E0
        ldx #$0000

        _D1E3
        jsl rlUnknown95B5D0
        sta wR7
        plx
        lda $0AF9,b,x
        sta wR0
        cpx #$0000
        beq _D1F9
        lda $0AF9,b
        bra _D1FC


        _D1F9
        lda $0B3C,b

        _D1FC
        sta wR1
        plx
        rtl

        .databank 0

        ; 95/D200

    .endsection Unsorted95D1C5Section


    .section Unsorted95D2A4Section

      .al
      .xl

      rsUnknown95D2A4 ; 95/D2A4

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        sta wR9
        ldy #$0000
        lda $7FE1A7
        sta lR18
        lda $7FE1A8
        sta lR18+1
        lda [lR18],y
        sta wR7
        lda $7FE1AD
        sta lR18
        lda $7FE1AE
        sta lR18+1
        lda [lR18],y
        sta wR8
        lda wR7
        cmp wR8
        bcc _D2DC
        lda wR7
        sec
        sbc wR8
        lsr a
        clc
        adc wR8
        bra _D2E5


        _D2DC
        lda wR8
        sec
        sbc wR7
        lsr a
        clc
        adc wR7

        _D2E5
        sec
        sbc #$0080
        bcc _D31E
        cmp $7FE198
        bcc _D31E
        lda $7FE197
        clc
        adc wR9
        sta $7FE197
        lda $7FE199
        adc #$0000
        sep #$20
        sta $7FE199
        rep #$20
        lda $7FE198
        cmp #$00C0
        bcc _D31E
        lda #$00C0
        sta $7FE198
        sec
        bra _D31F


        _D31E
        clc

        _D31F
        ply
        plx
        rts

        .databank 0

        ; 95/D322

      rsUnknown95D322 ; 95/D322

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        sta wR9
        ldy #$0000
        lda $7FE1A7
        sta lR18
        lda $7FE1A8
        sta lR18+1
        lda [lR18],y
        sta wR7
        lda $7FE1AD
        sta lR18
        lda $7FE1AE
        sta lR18+1
        lda [lR18],y
        sta wR8
        lda wR7
        cmp wR8
        bcc _D35A
        lda wR7
        sec
        sbc wR8
        lsr a
        clc
        adc wR8
        bra _D363


        _D35A
        lda wR8
        sec
        sbc wR7
        lsr a
        clc
        adc wR7

        _D363
        sec
        sbc #$0080
        cmp $7FE198
        beq _D36F
        bcs _D39F

        _D36F
        lda wR9
        bmi _D38C
        lda $7FE197
        sec
        sbc wR9
        sta $7FE197
        sep #$20
        lda $7FE199
        sbc #$00
        sta $7FE199
        rep #$20

        _D38C
        lda $7FE198
        cmp #$0040
        bcs _D39F
        lda #$0040
        sta $7FE198
        sec
        bra _D3A0


        _D39F
        clc

        _D3A0
        ply
        plx
        rts

        .databank 0

        ; 95/D3A3

      rsUnknown95D3A3 ; 95/D3A3

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        and #$7F00
        xba
        sta wR9
        lda $0AF4,b,x
        bit #$0040
        beq _D41D
        ldy #$0000
        lda $7FE1A7
        sta lR18
        lda $7FE1A8
        sta lR18+1
        lda [lR18],y
        sta wR7
        lda $7FE1A7
        sta lR18
        lda $7FE1A8
        sta lR18+1
        lda [lR18],y
        sta wR8
        lda wR7
        cmp wR8
        bcc _D3E7
        lda wR7
        sec
        sbc wR8
        lsr a
        clc
        adc wR8
        bra _D3F0


        _D3E7
        lda wR8
        sec
        sbc wR7
        lsr a
        clc
        adc wR7

        _D3F0
        sec
        sbc #$0080
        bcc _D41D
        cmp $7FE198
        bcc _D41D
        lda $7FE198
        clc
        adc wR9
        cmp #$00C0
        bcc _D412
        lda $7FE198
        sec
        sbc #$00C0
        sta wR9

        _D412
        lda $7FE1B4
        sec
        sbc wR9
        sta $7FE1B4

        _D41D
        ply
        plx
        rts

        .databank 0

        ; 95/D420

      rsUnknown95D420 ; 95/D420

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        and #$7F00
        xba
        sta wR9
        lda $0AF4,b,x
        bit #$0040
        beq _D49A
        ldy #$0000
        lda $7FE1A7
        sta lR18
        lda $7FE1A8
        sta lR18+1
        lda [lR18],y
        sta wR7
        lda $7FE1A7
        sta lR18
        lda $7FE1A8
        sta lR18+1
        lda [lR18],y
        sta wR8
        lda wR7
        cmp wR8
        bcc _D464
        lda wR7
        sec
        sbc wR8
        lsr a
        clc
        adc wR8
        bra _D46D


        _D464
        lda wR8
        sec
        sbc wR7
        lsr a
        clc
        adc wR7

        _D46D
        sec
        sbc #$0080
        cmp $7FE198
        beq _D479
        bcs _D49A

        _D479
        lda $7FE198
        sec
        sbc wR9
        cmp #$0040
        bcs _D48F
        lda #$0040
        sec
        sbc $7FE198
        sta wR9

        _D48F
        lda $7FE1B4
        clc
        adc wR9
        sta $7FE1B4

        _D49A
        ply
        plx
        rts

        .databank 0

        ; 95/D49D

      rsUnknown95D49D ; 95/D49D

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        sta wR9
        ldy #$0000
        lda $7FE1A7
        sta lR18
        lda $7FE1A8
        sta lR18+1
        lda [lR18],y
        sta wR7
        lda $7FE1AD
        sta lR18
        lda $7FE1AE
        sta lR18+1
        lda [lR18],y
        sta wR8
        lda wR7
        cmp wR8
        bcc _D4D5
        lda wR7
        sec
        sbc wR8
        lsr a
        clc
        adc wR8
        bra _D4DE


        _D4D5
        lda wR8
        sec
        sbc wR7
        lsr a
        clc
        adc wR7

        _D4DE
        lda $7FE197
        clc
        adc wR9
        sta $7FE197
        lda $7FE199
        adc #$0000
        sep #$20
        sta $7FE199
        rep #$20
        lda $7FE198
        cmp #$00C0
        bcc _D50B
        lda #$00C0
        sta $7FE198
        sec
        bra _D50C


        _D50B
        clc

        _D50C
        ply
        plx
        rts

        .databank 0

        ; 95/D50F

      rsUnknown95D50F ; 95/D50F

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        sta wR9
        ldy #$0000
        lda $7FE1A7
        sta lR18
        lda $7FE1A8
        sta lR18+1
        lda [lR18],y
        sta wR7
        lda $7FE1AD
        sta lR18
        lda $7FE1AE
        sta lR18+1
        lda [lR18],y
        sta wR8
        lda wR7
        cmp wR8
        bcc _D547
        lda wR7
        sec
        sbc wR8
        lsr a
        clc
        adc wR8
        bra _D550


        _D547
        lda wR8
        sec
        sbc wR7
        lsr a
        clc
        adc wR7

        _D550
        lda $7FE197
        sec
        sbc wR9
        sta $7FE197
        sep #$20
        lda $7FE199
        sbc #$00
        sta $7FE199
        rep #$20
        lda $7FE198
        cmp #$0040
        bcs _D57C
        lda #$0040
        sta $7FE198
        sec
        bra _D57D


        _D57C
        clc

        _D57D
        ply
        plx
        rts

        .databank 0

        ; 95/D580

      rsUnknown95D580 ; 95/D580

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FF5AF
        bit #$0001
        beq _D58D
        jml _D66F


        _D58D
        lda $7FE1B4
        beq _D5F7
        bmi _D5C7
        cmp #$0004
        bcc _D5AC
        sec
        sbc #$0002
        sta $7FE1B4
        lda $7FE198
        sec
        sbc #$0002
        bra _D5B6


        _D5AC
        dec a
        sta $7FE1B4
        lda $7FE198
        dec a

        _D5B6
        and #$01FF
        cmp #$0040
        bcs _D5C1
        lda #$0040

        _D5C1
        sta $7FE198
        bra _D5F7


        _D5C7
        cmp #$FFFD
        bcs _D5DE
        clc
        adc #$0002
        sta $7FE1B4
        lda $7FE198
        clc
        adc #$0002
        bra _D5E8


        _D5DE
        inc a
        sta $7FE1B4
        lda $7FE198
        inc a

        _D5E8
        and #$01FF
        cmp #$00C0
        bcc _D5F3
        lda #$00C0

        _D5F3
        sta $7FE198

        _D5F7
        lda $7FE1B3
        bit #$0004
        bne _D66F
        lda $7FE198
        clc
        adc $7FE19F
        sta wBufferBG2HOFS
        phx
        lda $0AE8,b
        bit #$0080
        bne _D619
        ldx #$0000
        bra _D61C


        _D619
        ldx #$0043

        _D61C
        lda $0AFD,b,x
        cmp #$1800
        bcs _D629
        lda #$0000
        bra _D638


        _D629
        cmp #$5000
        bcc _D633
        lda #$0038
        bra _D638


        _D633
        xba
        sec
        sbc #$0018

        _D638
        sep #$20
        sta $7FE19A
        eor #$FF
        inc a
        sta wBufferBG2VOFS
        beq _D64B
        lda #$01
        sta wBufferBG2VOFS+1
        bra _D64D


        _D64B
        stz wBufferBG2VOFS+1

        _D64D
        rep #$20
        lda wBufferBG2VOFS
        sec
        sbc #$0080
        and #$01FF
        eor #$0100
        clc
        adc $7FE1A1
        sta wBufferBG2VOFS
        plx
        lda wBufferBG2HOFS
        sta $7FE19B
        lda wBufferBG2VOFS
        sta $7FE19D

        _D66F
        rts

        .databank 0

        ; 95/D670

      rsUnknown95D670 ; 95/D670

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda $7FE1B3
        bit #$0002
        beq _D6AF
        lda $7FE198
        sec
        sbc #$0040
        pha
        sta wR13
        lda #$0001
        sta wR14
        jsl rlUnsignedDivide16By16R13
        lda wR13
        clc
        adc #1,s
        sta wBufferBG1HOFS
        pla
        lda #$0080
        sec
        sbc wBufferBG2VOFS
        sta wR13
        lda #$0007
        sta wR14
        jsl rlUnsignedDivide16By16R13
        lda wBufferBG2VOFS
        sec
        sbc wR13
        sta wBufferBG1VOFS

        _D6AF
        ply
        plx
        rts

        .databank 0

        ; 95/D6B2

      rlUnknown95D6B2 ; 95/D6B2

        .al
        .xl
        .autsiz
        .databank ?

        lda $0AF9,b
        sta $7FE1A4
        lda #$0003
        jsl rlUnknown95D6EC
        sep #$20
        lda $7FE1A3
        and #$FE
        sta $7FE1A3
        rep #$20
        rtl

        .databank 0

        ; 95/D6CF

      rlUnknown95D6CF ; 95/D6CF

        .al
        .xl
        .autsiz
        .databank ?

        lda $0B3C,b
        sta $7FE1A4
        lda #$0003
        jsl rlUnknown95D6EC
        sep #$20
        lda $7FE1A3
        and #$FE
        sta $7FE1A3
        rep #$20
        rtl

        .databank 0

        ; 95/D6EC

      rlUnknown95D6EC ; 95/D6EC

        .al
        .xl
        .autsiz
        .databank ?

        pha
        lda $7FE1A4
        and #$01FF
        sec
        sbc $7FE198
        bit #$8000
        bne _D710
        cmp #$00E1
        bcs _D70B
        cmp #$0020
        bcc _D710
        pla
        bra _D71F


        _D70B
        pla
        sep #$20
        bra _D716


        _D710
        .al
        pla
        sep #$20
        eor #$FF
        inc a

        _D716
        sta $7FE1A6
        rep #$20
        clc
        bra _D720


        _D71F
        sec

        _D720
        rtl

        .databank 0

        ; 95/D721

      rlUnknown95D721 ; 95/D721

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7FE1A6
        and #$00FF
        beq _D77A
        xba
        bit #$8000
        bne _D740
        pha
        xba
        and #$00FF
        pha
        pla
        pla
        jsr rsUnknown95D49D
        bcs _D75D
        bra _D77A


        _D740
        pha
        xba
        and #$00FF
        ora #$FF00
        eor #$FFFF
        inc a
        pha
        pla
        pla
        eor #$FF00
        clc
        adc #$0100
        jsr rsUnknown95D50F
        bcs _D75D
        bra _D77A


        _D75D
        sep #$20
        lda #$00
        sta $7FE1A6
        lda $7FE1A3
        bit #$01
        beq _D778
        lda $7FE4B8
        beq _D778
        dec a
        sta $7FE4B8

        _D778
        rep #$20

        _D77A
        plx
        rtl

        .databank 0

        ; 95/D77C

      rsUnknown95D77C ; 95/D77C

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda $7FFC77
        bit #$0001
        beq _D78E
        lda $7FFC7A
        sta wNextFreeSpriteOffset,b

        _D78E
        ldx #$0000

        _D791
        lda $0AF3,b,x
        bit #$0080
        bne _D79D
        jml _D851


        _D79D
        lda $0AF5,b,x
        bit #$0040
        beq _D7A9
        jml _D851


        _D7A9
        cpx #$0000
        bne _D7BD
        lda $7FE09E
        bit #$0001
        beq _D7BB
        jml _D851


        _D7BB
        bra _D7CA


        _D7BD
        lda $7FE09E
        bit #$0001
        bne _D7CA
        jml _D851


        _D7CA
        rep #$20
        lda $0AF9,b,x
        and #$01FF
        sec
        sbc $7FE198
        sta wR0
        sep #$20
        lda $0B17,b,x
        bmi _D7E7
        rep #$20
        and #$00FF
        bra _D7EC


        _D7E7
        .as
        rep #$20
        ora #$FF00

        _D7EC
        clc
        adc wR0
        jsl rlUnknown95A164
        sta wR0
        lda $0AFB,b,x
        xba
        clc
        adc $7FE19A
        and #$00FF
        sta wR1
        lda $0B24,b,x
        and #$7FFF
        sta wR4
        lda $0B26,b,x
        and #$00FF
        xba
        sta wR5
        sep #$20
        phb
        lda $0B1B,b,x
        pha
        plb
        .databank ?
        rep #$20
        lda $0B1A,b,x
        sta lR18+1
        lda $0B19,b,x
        sta lR18
        sta wR9
        ldy #$0002
        lda [lR18],y
        clc
        adc lR18
        sta lR18
        ldy #$0000
        lda [lR18],y
        clc
        adc wR9
        inc a
        tay
        phx
        lda $0B24,b,x
        bit #$8000
        bne _D84A
        clc
        bra _D84B


        _D84A
        sec

        _D84B
        jsl rlUnknown95C51F
        plx
        plb
        .databank ?

        _D851
        txa
        clc
        adc #$0043
        tax
        cpx #$0086
        bcs _D860
        jml _D791


        _D860
        ply
        plx
        rts

        .databank 0

        ; 95/D863

      rlUnknown95D863 ; 95/D863

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown95D867
        rtl

        .databank 0

        ; 95/D867

      rsUnknown95D867 ; 95/D867

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        ldx #$0000

        _D86C
        phx
        lda $0C45,b,x
        bit #$0001
        beq _D8C1
        lda #$0000
        sta lR18+1
        sta lR19+1
        txa
        clc
        adc #$0C48
        sta lR18
        clc
        adc #$0003
        sta lR19
        ldy #$0000

        _D88C
        lda [lR19],y
        sta [lR18],y
        inc y
        lda [lR19],y
        sta [lR18],y
        inc y
        inc y
        cpy #$002D
        bcc _D88C
        phx
        lda $0C46,b,x
        tax
        lda $0AF9,b,x
        sta lR18
        sep #$20
        lda $0AFC,b,x
        sec
        sbc $0AFE,b,x
        sta lR18+2
        rep #$20
        plx
        lda lR18
        sta $0C75,b,x
        lda lR18+1
        sta $0C76,b,x
        jsr rsUnknown95D8D0

        _D8C1
        plx
        txa
        clc
        adc #$0033
        tax
        cpx #$0066
        bcc _D86C
        ply
        plx
        rts

        .databank 0

        ; 95/D8D0

      rsUnknown95D8D0 ; 95/D8D0

        .al
        .xl
        .autsiz
        .databank ?

        phb
        phx
        phy
        rep #$20
        phx
        sep #$20
        lda $0C45,b,x
        eor #$02
        sta $0C45,b,x
        bit #$02
        bne _D8EE
        rep #$20
        txa
        clc
        adc #$0018
        tax
        bra _D8F6


        _D8EE
        .as
        rep #$20
        txa
        clc
        adc #$0024
        tax

        _D8F6
        lda $0C48,b,x
        and #$01FF
        sec
        sbc $7FE198
        sta wR0
        phx
        lda #3,s
        tax
        lda wR0
        jsl rlUnknown95A164
        sta wR0
        plx
        lda $0C49,b,x
        and #$FF00
        xba
        clc
        adc $7FE19A
        and #$00FF
        sta wR1
        plx
        lda $0C46,b,x
        tax
        lda $0B1D,b,x
        and #$00FF
        cmp #$00FE
        beq _D95F
        lda $0B24,b,x
        and #$7FFF
        sta wR4
        lda $0B25,b,x
        and #$FF00
        sta wR5
        sep #$20
        lda $0B1B,b,x
        pha
        plb
        .databank ?
        rep #$20
        jsr rsUnknown95BFF9
        inc a
        tay
        lda $0B24,b,x
        bit #$8000
        bne _D95A
        clc
        bra _D95B


        _D95A
        sec

        _D95B
        jsl rlUnknown95C51F

        _D95F
        ply
        plx
        plb
        .databank ?
        rts

        .databank 0

        ; 95/D963

      rlUnknown95D963 ; 95/D963

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        pha
        lda $0AF9,b,x
        sta lR18
        sep #$20
        lda $0AFC,b,x
        sec
        sbc $0AFE,b,x
        sta lR18+2
        rep #$20
        pla
        sep #$20
        sta $4202,b
        lda #$33
        sta $4203,b
        nop
        nop
        rep #$20
        lda #$0000
        sta lR19+1
        lda $4216,b
        clc
        adc #$0C48
        sta lR19
        txa
        ldx $4216,b
        sta $0C46,b,x
        ldy #$0000

        _D99F
        lda lR18
        sta [lR19],y
        inc y
        lda lR18+1
        sta [lR19],y
        inc y
        inc y
        cpy #$0030
        bcc _D99F
        sep #$20
        lda $0C45,b,x
        ora #$01
        sta $0C45,b,x
        rep #$20
        ply
        plx
        rtl

        .databank 0

        ; 95/D9BE

      rlUnknown95D9BE ; 95/D9BE

        .al
        .xl
        .autsiz
        .databank ?

        phx
        sep #$20
        sta $4202,b
        lda #$33
        sta $4203,b
        nop
        nop
        nop
        nop
        ldx $4216,b
        lda $0C45,b,x
        and #$FE
        sta $0C45,b,x
        rep #$20
        plx
        rtl

        .databank 0

        ; 95/D9DC

      rlUnknown95D9DC ; 95/D9DC

        .al
        .xl
        .autsiz
        .databank ?

        phx
        pha
        lda $0AF4,b,x
        bit #$0080
        beq _DA07
        lda $7FE09E
        bit #$0001
        beq _DA07
        ldx $0AEB,b
        lda $0AF9,b,x
        and #$01FF
        sec
        sbc #1,s
        clc
        adc $0AF9,b,x
        and #$01FF
        sta #1,s
        sec
        bra _DA08


        _DA07
        clc

        _DA08
        pla
        plx
        rtl

        .databank 0

        ; 95/DA0B

    .endsection Unsorted95D2A4Section


    .section Unsorted95DA0BSection

      .al
      .xl

      rlUnknown95DA0B ; 95/DA0B

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0000
        lda #$FFFF

        _DA11
        sta $7FE144,x
        inc x
        inc x
        cpx #$0040
        bcc _DA11
        rtl

        .databank 0

        ; 95/DA1D

    .endsection Unsorted95DA0BSection


    .section Unsorted95DA1DSection

      .al
      .xl

      rlUnknown95DA1D ; 95/DA1D

        .al
        .xl
        .autsiz
        .databank ?

        stz $0ADE,b
        jsr rsUnknown95DA98
        bcs _DA39
        pha
        ldx #$0000
        jsl rlUnknown95B1AB
        pla
        and #$FF00
        pha
        jsl rlUnknown95BA05
        pla
        bra _DA8F


        _DA39
        jsr rsUnknown95DAE1
        bcs _DA55
        pha
        ldx #$0043
        jsl rlUnknown95B1AB
        pla
        and #$FF00
        ora #$0001
        pha
        jsl rlUnknown95BA05
        pla
        bra _DA8F


        _DA55
        lda $0ADE,b
        and #$0003
        cmp #$0003
        bne _DA97
        phx
        ldx #$0086
        lda $0AF3,b,x
        bit #$0080
        beq _DA6F
        sec
        bra _DA7E


        _DA6F
        ldx #$00C9
        lda $0AF3,b,x
        bit #$0080
        beq _DA7D
        sec
        bra _DA7E


        _DA7D
        clc

        _DA7E
        plx
        bcs _DA97
        sep #$20
        lda $0AE4,b
        ora #$01
        sta $0AE4,b
        rep #$20
        bra _DA97


        _DA8F
        xba
        sep #$20
        sta $0B1E,b,x
        rep #$20

        _DA97
        rtl

        .databank 0

        ; 95/DA98

      rsUnknown95DA98 ; 95/DA98

        .al
        .xl
        .autsiz
        .databank ?

        lda $0AF3,b
        bit #$0080
        bne _DAA2
        bra _DADF


        _DAA2
        lda $0B08,b
        bit #$7FFF
        bne _DADF
        lda $0B0E,b
        bne _DADF
        lda $0AF4,b
        bit #$0020
        bne _DADF
        lda $0AF3,b
        bit #$0020
        beq _DAC7
        lda $0AF4,b
        bit #$0040
        bne _DACF

        _DAC7
        lda $0AF3,b
        bit #$0001
        bne _DADF

        _DACF
        clc
        jsl rlUnknown95DB55
        bcc _DAE0
        lda $0ADE,b
        ora #$0001
        sta $0ADE,b

        _DADF
        sec

        _DAE0
        rts

        .databank 0

        ; 95/DAE1

      rsUnknown95DAE1 ; 95/DAE1

        .al
        .xl
        .autsiz
        .databank ?

        lda $0B36,b
        bit #$0080
        bne _DAEB
        bra _DB28


        _DAEB
        lda $0B4B,b
        bit #$7FFF
        bne _DB28
        lda $0B51,b
        bne _DB28
        lda $0B37,b
        bit #$0020
        bne _DB28
        lda $0B36,b
        bit #$0020
        beq _DB10
        lda $0B37,b
        bit #$0040
        bne _DB18

        _DB10
        lda $0B36,b
        bit #$0001
        bne _DB28

        _DB18
        sec
        jsl rlUnknown95DB55
        bcc _DB29
        lda $0ADE,b
        ora #$0002
        sta $0ADE,b

        _DB28
        sec

        _DB29
        rts

        .databank 0

        ; 95/DB2A

      rlUnknown95DB2A ; 95/DB2A

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        bcs _DB33
        ldx #$0000
        bra _DB36


        _DB33
        ldx #$0020

        _DB36
        pha
        ldy #$0010

        _DB3A
        lda $7FE144,x
        cmp #$FFFF
        beq _DB4C
        inc x
        inc x
        dec y
        bne _DB3A
        pla
        sec
        bra _DB52


        _DB4C
        pla
        sta $7FE144,x
        clc

        _DB52
        ply
        plx
        rtl

        .databank 0

        ; 95/DB55

      rlUnknown95DB55 ; 95/DB55

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        bcs _DB5E
        ldx #$0000
        bra _DB61


        _DB5E
        ldx #$0020

        _DB61
        lda $7FE144,x
        cmp #$FFFF
        bne _DB6D
        sec
        bra _DB87


        _DB6D
        pha
        ldy #$000F

        _DB71
        lda $7FE146,x
        sta $7FE144,x
        inc x
        inc x
        dec y
        bne _DB71
        lda #$FFFF
        sta $7FE144,x
        pla
        clc

        _DB87
        ply
        plx
        rtl

        .databank 0

        ; 95/DB8A

      rlUnknown95DB8A ; 95/DB8A

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        asl a
        tay
        lda [lR19],y
        tay
        cpx #$0000
        bne _DBAB

        _DB96
        sep #$20
        lda [lR19],y
        cmp #$7F
        beq _DBC0
        rep #$20
        lda [lR19],y
        clc
        jsl rlUnknown95DB2A
        inc y
        inc y
        bra _DB96


        _DBAB
        sep #$20
        lda [lR19],y
        cmp #$7F
        beq _DBC0
        rep #$20
        lda [lR19],y
        sec
        jsl rlUnknown95DB2A
        inc y
        inc y
        bra _DBAB


        _DBC0
        .as
        rep #$20
        ply
        plx
        rtl

        .databank 0

        ; 95/DBC5

      rlUnknown95DBC5 ; 95/DBC5

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        xba
        sep #$20
        lda #$7E
        rep #$20
        cpx #$0000
        bne _DBD6
        clc
        bra _DBD7


        _DBD6
        sec

        _DBD7
        jsl rlUnknown95DB2A
        ply
        plx
        rtl

        .databank 0

        ; 95/DBDE

      rlUnknown95DBDE ; 95/DBDE

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        phy
        cpx #$0000
        bne _DBEB
        ldx #$0086
        bra _DBEE


        _DBEB
        ldx #$00C9

        _DBEE
        and #$00F0
        cmp #$0030
        bne _DC11
        lda wR0
        cmp #$003A
        beq _DC25
        cmp #$003B
        beq _DC25
        cmp #$003C
        beq _DC25
        cmp #$003D
        beq _DC25
        lda #$0000
        bra _DC28


        _DC11
        cmp #$0050
        bne _DC1B
        lda #$0001
        bra _DC28


        _DC1B
        cmp #$0060
        bne _DC25
        lda #$0002
        bra _DC28


        _DC25
        lda #$0003

        _DC28
        sep #$20
        pha
        lda $0AF6,b,x
        and #$FC
        ora #1,s
        sta $0AF6,b,x
        pla
        rep #$20
        sta wR0
        txy
        phb
        php
        phk
        plb
        .databank $95
        lda wR0
        asl a
        tax
        jsr ($95DC4C,x)
        plp
        plb
        .databank $95
        ply
        plx
        pla
        rtl

        .databank 0

        ; 95/DC4C

    .endsection Unsorted95DA1DSection


    .section Unsorted95DC54Section

      .al
      .xl

      rsUnknown95DC54 ; 95/DC54

        .al
        .xl
        .autsiz
        .databank ?

        phx
        tyx
        sep #$20
        lda #$01
        sta $0AF7,b,x
        rep #$20
        plx
        rts

        .databank 0

        ; 95/DC61

      rsUnknown95DC61 ; 95/DC61

        .al
        .xl
        .autsiz
        .databank ?

        phx
        tyx
        lda #$0000
        sta $0B2D,b,x
        jsl rlUnknown95B050
        lda wR0
        asl a
        asl a
        asl a
        asl a
        sta wR13
        lda #$0008
        sta wR14
        phx
        jsl rlUnsignedDivide16By16R13
        plx
        lda wR13
        sta $0B2A,b,x
        sep #$20
        lda #$01
        sta $0AF7,b,x
        rep #$20
        plx
        rts

        .databank 0

        ; 95/DC90

    .endsection Unsorted95DC54Section


    .section Unsorted95DCA3Section

      .al
      .xl

      rsUnknown95DCA3 ; 95/DCA3

        .al
        .xl
        .autsiz
        .databank ?

        phx
        and #$001F
        pha
        jsl rlUnknown95B993
        pla
        pha
        sep #$20
        sta $0C2A,b
        rep #$20
        lda $0B1A,b
        sta $0C26,b
        lda $0B19,b
        sta $0C25,b
        lda $0AF9,b
        sta wR0
        lda $0AF8,b
        sta $0C04,b
        lda $0AFB,b
        sta $0C07,b
        lda $0AFD,b
        sta wR1
        lda #$0000
        sta $0C30,b
        sep #$20
        lda $0B7D,b
        sta $0C03,b
        rep #$20
        lda $0D5B,b
        sta wR2
        lda $0D4E,b
        jsl rlUnknown95B8B0
        pha
        and #$00FF
        bit #$0080
        beq _DCFF
        ora #$FF00

        _DCFF
        pha
        jsl rlUnknown95B184
        pla
        bcs _DD0B
        eor #$FFFF
        inc a

        _DD0B
        clc
        adc wR0
        sta $0C05,b
        pla
        and #$FF00
        clc
        adc wR1
        sta $0C09,b
        lda #$0000
        jsr rsUnknown95DE0C
        lda #$0002
        jsl rlUnknown95B9AC
        lda $0B7D,b
        and #$00FF
        cmp #$0004
        bcc _DD41
        pla
        xba
        sep #$20
        lda #$02
        rep #$20
        jsl rlUnknown95BA76
        bra _DD4D


        _DD41
        pla
        xba
        sep #$20
        lda #$02
        rep #$20
        jsl rlUnknown95BA05

        _DD4D
        plx
        rts

        .databank 0

        ; 95/DD4F

      rsUnknown95DD4F ; 95/DD4F

        .al
        .xl
        .autsiz
        .databank ?

        phx
        and #$001F
        pha
        jsl rlUnknown95B993
        pla
        pha
        sep #$20
        sta $0C2A,b
        rep #$20
        lda $0B5D,b
        sta $0C26,b
        lda $0B5C,b
        sta $0C25,b
        lda $0B3C,b
        sta wR0
        lda $0B3B,b
        sta $0C04,b
        lda $0B3E,b
        sta $0C07,b
        lda $0B40,b
        sta wR1
        lda #$8100
        sta $0C30,b
        sep #$20
        lda $0BC0,b
        sta $0C03,b
        rep #$20
        lda $0D69,b
        sta wR2
        lda $0D5C,b
        jsl rlUnknown95B8B0
        pha
        and #$00FF
        bit #$0080
        beq _DDAB
        ora #$FF00

        _DDAB
        pha
        jsl rlUnknown95B184
        pla
        bcc _DDB7
        eor #$FFFF
        inc a

        _DDB7
        clc
        adc wR0
        sta $0C05,b
        pla
        and #$FF00
        clc
        adc wR1
        sta $0C09,b
        lda #$8000
        jsr rsUnknown95DE0C
        lda #$0003
        jsl rlUnknown95B9AC
        lda $0BC0,b
        and #$00FF
        cmp #$0004
        bcc _DDED
        pla
        xba
        sep #$20
        lda #$03
        rep #$20
        jsl rlUnknown95BA76
        bra _DDF9


        _DDED
        pla
        xba
        sep #$20
        lda #$03
        rep #$20
        jsl rlUnknown95BA05

        _DDF9
        plx
        rts

        .databank 0

        ; 95/DDFB

      rlUnknown95DDFB ; 95/DDFB

        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsl rlUnknown95BAE7
        txa
        sec
        sbc #$0086
        tax
        jsl rlUnknown95C077
        plx
        rtl

        .databank 0

        ; 95/DE0C

      rsUnknown95DE0C ; 95/DE0C

        .al
        .xl
        .autsiz
        .databank ?

        pha
        pha
        jsl rlUnknown95B050
        lda wR0
        sta wR1
        lda #1,s
        asl a
        jsl rlUnknown95E304
        pha
        sta wR0
        lda wR1
        jsl rlUnknown95CE5E
        sta wR0
        pla
        sta wR1
        jsl rlUnknown95B184
        bcc _DE37
        pla
        eor #$8000
        bra _DE38


        _DE37
        pla

        _DE38
        ora wR1
        sta $0C14,b
        pla
        pha
        sta wR1
        lda wR0
        pha
        lda wR1
        jsr rsUnknown95E291
        pla
        sta wR0
        pla
        asl a
        jsl rlUnknown95E33B
        jsl rlUnknown95CE78
        lda wR0
        sta $0C1C,b
        lda wR1
        sta $0C1A,b
        rts

        .databank 0

        ; 95/DE61

      rlUnknown95DE61 ; 95/DE61

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda $0AF3,b,x
        bit #$0080
        beq _DE81
        lda $0AF6,b,x
        and #$0003
        sta wR0
        txy
        phb
        php
        phk
        plb
        .databank $95
        lda wR0
        asl a
        tax
        jsr ($95DE84,x)
        plp
        plb
        .databank $95

        _DE81
        ply
        plx
        rtl

        .databank 0

        ; 95/DE84

    .endsection Unsorted95DCA3Section


    .section Unsorted95DE8CSection

      .al
      .xl

      rsUnknown95DE8C ; 95/DE8C

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        tyx
        jsr rsUnknown95E372
        lda $0B08,b,x
        bne _DE9B
        jml _DED2


        _DE9B
        bpl _DEA1
        jml _DEB9


        _DEA1
        sta wR0
        jsr rsUnknown95E0C5
        bit #$0001
        beq _DEB1
        php
        jsl rlUnknown95AE8B
        plp

        _DEB1
        bcc _DEB7
        jsl rlUnknown95DDFB

        _DEB7
        bra _DED2


        _DEB9
        and #$7FFF
        sta wR0
        jsr rsUnknown95E146
        bit #$0001
        beq _DECC
        php
        jsl rlUnknown95AE8B
        plp

        _DECC
        bcc _DED2
        jsl rlUnknown95DDFB

        _DED2
        ply
        plx
        rts

        .databank 0

        ; 95/DED5

      rsUnknown95DED5 ; 95/DED5

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        tyx
        lda $0B2D,b,x
        phx
        tax
        lda $98AAD4,x
        cmp #$8080
        bne _DEF4
        plx
        jsl rlUnknown95DDFB
        ldx $0AE9,b
        jsl rlUnknown95C057
        bra _DF73


        _DEF4
        plx
        pha
        and #$FF00
        pha
        lda $0AFD,b,x
        sec
        sbc #1,s
        sta $0AFD,b,x
        pla
        phx
        ldx $0AEB,b
        lda $0AF9,b,x
        ldx $0AE9,b
        cmp $0AF9,b,x
        bcs _DF17
        plx
        pla
        bra _DF1D


        _DF17
        plx
        pla
        eor #$FFFF
        inc a

        _DF1D
        and #$00FF
        bit #$0080
        bne _DF46
        sta wR10
        lda $0B2A,b,x
        sta wR11
        jsl rlUnsignedMultiply16By16
        lda wR12
        sta wR0
        jsr rsUnknown95E0C5
        bit #$0001
        beq _DF42
        php
        jsl rlUnknown95AE8B
        plp

        _DF42
        bcc _DF44

        _DF44
        bra _DF69


        _DF46
        eor #$00FF
        inc a
        sta wR10
        lda $0B2A,b,x
        sta wR11
        jsl rlUnsignedMultiply16By16
        lda wR12
        sta wR0
        jsr rsUnknown95E146
        bit #$0001
        beq _DF67
        php
        jsl rlUnknown95AE8B
        plp

        _DF67
        bcc _DF69

        _DF69
        lda $0B2D,b,x
        clc
        adc #$0002
        sta $0B2D,b,x

        _DF73
        ply
        plx
        rts

        .databank 0

        ; 95/DF76

    .endsection Unsorted95DE8CSection


    .section Unsorted95E0C5Section

      .al
      .xl

      rsUnknown95E0C5 ; 95/E0C5

        .al
        .xl
        .autsiz
        .databank ?

        phx
        sta wR2
        lda $0AF8,b,x
        clc
        adc wR2
        sta $0AF8,b,x
        lda $0AFA,b,x
        adc #$0000
        sep #$20
        sta $0AFA,b,x
        rep #$20
        lda $0AF9,b,x
        cmp #$0200
        bcs _E141
        pha
        lda $0AF9,b
        cmp $0B3C,b
        bcc _E0F4
        ldx #$0000
        bra _E0F7


        _E0F4
        ldx #$0043

        _E0F7
        pla
        cmp $0AF9,b,x
        bcc _E103
        lda #$0001
        clc
        bra _E144


        _E103
        cmp #$0140
        bcc _E10D
        lda #$0140
        bra _E140


        _E10D
        cmp #$00C0
        bcs _E117
        lda #$00C0
        bra _E140


        _E117
        lda $7FE197
        clc
        adc wR2
        sta $7FE197
        sep #$20
        lda $7FE199
        adc #$00
        sta $7FE199
        rep #$20
        lda $7FE198
        cmp #$00C0
        bcc _E13C
        lda #$00C0

        _E13C
        sta $7FE198

        _E140
        clc

        _E141
        lda #$0000

        _E144
        plx
        rts

        .databank 0

        ; 95/E146

      rsUnknown95E146 ; 95/E146

        .al
        .xl
        .autsiz
        .databank ?

        phx
        sta wR2
        lda $0AF8,b,x
        sec
        sbc wR2
        sta $0AF8,b,x
        lda $0AFA,b,x
        sbc #$0000
        sep #$20
        sta $0AFA,b,x
        rep #$20
        lda $0AF9,b,x
        bpl _E167
        sec
        bra _E1C4


        _E167
        pha
        lda $0AF9,b
        cmp $0B3C,b
        bcs _E175
        ldx #$0000
        bra _E178


        _E175
        ldx #$0043

        _E178
        pla
        cmp $0AF9,b,x
        beq _E186
        bcs _E186
        lda #$0001
        clc
        bra _E1C7


        _E186
        cmp #$0140
        bcc _E190
        lda #$0140
        bra _E1C3


        _E190
        cmp #$00C0
        bcs _E19A
        lda #$00C0
        bra _E1C3


        _E19A
        lda $7FE197
        sec
        sbc wR2
        sta $7FE197
        sep #$20
        lda $7FE199
        sbc #$00
        sta $7FE199
        rep #$20
        lda $7FE198
        cmp #$0040
        bcs _E1BF
        lda #$0040

        _E1BF
        sta $7FE198

        _E1C3
        clc

        _E1C4
        lda #$0000

        _E1C7
        plx
        rts

        .databank 0

        ; 95/E1C9

    .endsection Unsorted95E0C5Section


    .section Unsorted95E1C9Section

      .al
      .xl

      rlUnknown95E1C9 ; 95/E1C9

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda $0AF3,b,x
        bit #$0080
        beq _E229
        lda $0AF6,b,x
        and #$0003
        cmp #$0002
        beq _E229
        cmp #$0003
        beq _E229
        lda $0AF3,b,x
        bit #$0010
        bne _E229
        lda $0B0E,b,x
        bmi _E1FB
        lda $0B0E,b,x
        clc
        adc $0AFD,b,x
        bcc _E21C
        bra _E204


        _E1FB
        lda $0B0E,b,x
        clc
        adc $0AFD,b,x
        bcs _E21C

        _E204
        sep #$20
        lda $0AF3,b,x
        and #$F7
        sta $0AF3,b,x
        rep #$20
        stz $0AFD,b,x
        stz $0B0E,b,x
        jsl rlUnknown95DDFB
        bra _E229


        _E21C
        sta $0AFD,b,x
        lda $0B0E,b,x
        sec
        sbc $0B10,b,x
        sta $0B0E,b,x

        _E229
        ply
        plx
        rtl

        .databank 0

        ; 95/E22C

      rlUnknown95E22C ; 95/E22C

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda $0AF3,b,x
        bit #$0080
        beq _E28E
        lda $0AF6,b,x
        and #$0003
        cmp #$0002
        beq _E28E
        cmp #$0003
        beq _E28E
        lda $0B13,b,x
        bne _E261
        lda $0AF3,b,x
        bit #$0010
        beq _E28E
        sep #$20
        lda $0AF3,b,x
        and #$EF
        sta $0AF3,b,x
        rep #$20
        bra _E28E


        _E261
        bmi _E278
        sta wR0
        lda $0AFD,b,x
        sec
        sbc wR0
        bcs _E273
        jsl rlUnknown95DDFB
        bra _E276


        _E273
        sta $0AFD,b,x

        _E276
        bra _E28E


        _E278
        and #$7FFF
        sta wR0
        lda $0AFD,b,x
        clc
        adc wR0
        bcc _E28B
        jsl rlUnknown95DDFB
        bra _E28E


        _E28B
        sta $0AFD,b,x

        _E28E
        ply
        plx
        rtl

        .databank 0

        ; 95/E291

      rsUnknown95E291 ; 95/E291

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $0AE9,b
        clc
        adc #$0086
        tax
        lda $0AF6,b,x
        and #$0003
        cmp #$0001
        bne _E2AA
        lda #$0018
        bra _E2AD


        _E2AA
        lda #$0000

        _E2AD
        pha
        ldx $0AEB,b
        jsl rlUnknown95B5FD
        sta wR1
        ldx $0AE9,b
        jsl rlUnknown95B5FD
        clc
        adc #1,s
        sta wR2
        pla
        lda wR1
        sec
        sbc wR2
        bpl _E2D6
        eor #$FFFF
        inc a
        sta wR2
        lda #$0000
        bra _E2DB


        _E2D6
        sta wR2
        lda #$8000

        _E2DB
        sta wR3
        lda wR2
        jsl rlUnknown95E2EF
        ora wR3
        sta $0C1F,b
        lda wR1
        sta $0C10,b
        plx
        rts

        .databank 0

        ; 95/E2EF

      rlUnknown95E2EF ; 95/E2EF

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        sta wR13
        stz wR12
        lda wR0
        sta wR14
        stz wR15
        jsl rlUnsignedDivide32By32
        lda wR12+1
        ply
        plx
        rtl

        .databank 0

        ; 95/E304

      rlUnknown95E304 ; 95/E304

        .al
        .xl
        .autsiz
        .databank ?

        phx
        php
        bcs _E30D
        ldx #$0086
        bra _E310


        _E30D
        ldx #$00C9

        _E310
        lda $0AF6,b,x
        and #$0003
        cmp #$0001
        beq _E335
        plp
        bcc _E323
        ldx #$0043
        bra _E326


        _E323
        ldx #$0000

        _E326
        lda $0AFD,b,x
        beq _E330
        lda #$1000
        bra _E339


        _E330
        lda #$1200
        bra _E339


        _E335
        plp
        lda #$0800

        _E339
        plx
        rtl

        .databank 0

        ; 95/E33B

      rlUnknown95E33B ; 95/E33B

        .al
        .xl
        .autsiz
        .databank ?

        phx
        php
        bcs _E344
        ldx #$0086
        bra _E347


        _E344
        ldx #$00C9

        _E347
        lda $0AF6,b,x
        and #$0003
        cmp #$0001
        beq _E36C
        plp
        bcs _E35A
        ldx #$000E
        bra _E35D


        _E35A
        ldx #$0000

        _E35D
        lda $0AFD,b,x
        beq _E367
        lda #$0006
        bra _E370


        _E367
        lda #$0000
        bra _E370


        _E36C
        plp
        lda #$0018

        _E370
        plx
        rtl

        .databank 0

        ; 95/E372

    .endsection Unsorted95E1C9Section


    .section Unsorted95E372Section

      .al
      .xl

      rsUnknown95E372 ; 95/E372

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $0B08,b,x
        and #$7FFF
        sta wR10
        lda $0B0E,b,x
        beq _E3C2
        bmi _E3A0
        sta wR13
        phx
        jsl rlUnsignedDivide16By16R13
        plx
        lda wR13
        cmp #$0020
        bcc _E396
        lda #$0000
        bra _E3C5


        _E396
        cmp #$0010
        bcc _E3C2
        lda #$0002
        bra _E3C5


        _E3A0
        eor #$FFFF
        inc a
        sta wR13
        phx
        jsl rlUnsignedDivide16By16R13
        plx
        lda wR13
        cmp #$0020
        bcc _E3B8
        lda #$0004
        bra _E3C5


        _E3B8
        cmp #$0010
        bcc _E3C2
        lda #$0003
        bra _E3C5


        _E3C2
        lda #$0002

        _E3C5
        clc
        adc $0B1E,b,x
        sep #$20
        xba
        cpx #$0086
        bne _E3D5
        lda #$02
        bra _E3D7


        _E3D5
        lda #$03

        _E3D7
        rep #$20
        jsl rlUnknown95BA05
        plx
        rts

        .databank 0

        ; 95/E3DF

    .endsection Unsorted95E372Section


    .section Unsorted95E3DFSection

      .al
      .xl

      rsUnknown95E3DF ; 95/E3DF

        .as
        .xl
        .autsiz
        .databank ?

        bcs _E3EF
        sep #$20
        lda #$02
        sta $0AF7,b
        lda #$03
        sta $0B3A,b
        bra _E3FB


        _E3EF
        sep #$20
        lda #$03
        sta $0AF7,b
        lda #$02
        sta $0B3A,b

        _E3FB
        rep #$20
        rts

        .databank 0

        ; 95/E3FE

      rlUnknown95E3FE ; 95/E3FE

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        phy
        phx
        pha
        cpx #$0000
        bne _E411
        ldx #$0000
        lda $7FE1B6
        bra _E418


        _E411
        ldx #$000E
        lda $7FE1BA

        _E418
        inc a
        and #$00FF
        tax
        lda $97C884,x
        and #$00FF
        pha
        asl a
        asl a
        asl a
        clc
        adc #1,s
        clc
        adc #$0060
        tax
        pla
        lda $97C887,x
        sta lR18
        lda $97C888,x
        sta lR18+1
        lda $97C884,x
        sta lR19
        lda $97C885,x
        sta lR19+1
        lda $97C88A,x
        sta lR20
        lda $97C88B,x
        sta lR20+1
        ply
        plx
        lda lR20
        sta $0B2F,b,x
        lda lR20+1
        sta $0B30,b,x
        lda [lR18],y
        and #$00FF
        bit #$0080
        bne _E474
        and #$007F
        jsl rlUnknown95DBC5
        bra _E47B


        _E474
        and #$007F
        jsl rlUnknown95DB8A

        _E47B
        ply
        plx
        pla
        rtl

        .databank 0

        ; 95/E47F

      rlUnknown95E47F ; 95/E47F

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx $0AEB,b
        lda $0B26,b,x
        bit #$0008
        bne _E48F
        jsl rlUnknown95E491

        _E48F
        plx
        rtl

        .databank 0

        ; 95/E491

      rlUnknown95E491 ; 95/E491

        .al
        .xl
        .autsiz
        .databank ?

        phd
        pha
        phx
        phy
        lda #$01FE
        tcd
        ldx #$0074

        _E49C
        lda wR0,x
        ldy wBufferBG1HOFS+1,x
        sta wBufferBG1HOFS+1,x
        sty wR0,x
        dec x
        dec x
        bne _E49C
        sep #$20
        lda $0B26,b
        eor #$08
        sta $0B26,b
        lda $0B69,b
        eor #$08
        sta $0B69,b
        rep #$20
        ldx #$0000

        _E4BF
        lda aOAMPaletteBuffer,b,x
        sta $7FFF00,x
        inc x
        inc x
        cpx #$0100
        bcc _E4BF
        ply
        plx
        pla
        pld
        rtl

        .databank 0

        ; 95/E4D2

      rsUnknown95E4D2 ; 95/E4D2

        .al
        .xl
        .autsiz
        .databank ?

        phy
        lda $0AF4,b,x
        bit #$0001
        bne _E4DF
        jml _E58A


        _E4DF
        lda $0AF3,b,x
        bit #$0040
        beq _E4EB
        jml _E58A


        _E4EB
        lda $0B30,b,x
        sta lR18+1
        lda $0B34,b,x
        sta lR18
        ldy #$0000
        lda $0AF4,b,x
        bit #$0002
        beq _E547
        lda $0B24,b,x
        bmi _E523
        lda [lR18],y
        and #$00FF
        xba
        bit #$8000
        bne _E516
        clc
        jsr rsUnknown95C858
        bra _E53F


        _E516
        eor #$FF00
        clc
        adc #$0100
        clc
        jsr rsUnknown95C90F
        bra _E53F


        _E523
        lda [lR18],y
        and #$00FF
        xba
        bit #$8000
        bne _E534
        clc
        jsr rsUnknown95C90F
        bra _E53F


        _E534
        eor #$FF00
        clc
        adc #$0100
        clc
        jsr rsUnknown95C858

        _E53F
        inc y
        lda $0B34,b,x
        inc a
        sta $0B34,b,x

        _E547
        lda $0AF4,b,x
        bit #$0040
        beq _E58A
        phx
        ldx $0AEB,b
        jsl rlUnknown95B5D0
        pha
        jsl rlUnknown95B050
        lda wR1
        cmp #1,s
        pla
        plx
        bcs _E58A
        sep #$20
        lda $0AF3,b,x
        and #$FE
        sta $0AF3,b,x
        lda $0AF4,b,x
        and #$9F
        sta $0AF4,b,x
        lda $0AF4,b,x
        and #$FE
        sta $0AF4,b,x
        lda $0AF5,b,x
        and #$FC
        ora #$02
        sta $0AF5,b,x
        rep #$20

        _E58A
        ply
        rts

        .databank 0

        ; 95/E58C

      rsUnknown95E58C ; 95/E58C

        .al
        .xl
        .autsiz
        .databank ?

        lda $0AF4,b,x
        bit #$0001
        beq _E59A
        lda $0B32,b,x
        sta $0B34,b,x

        _E59A
        rts

        .databank 0

        ; 95/E59B

      rsUnknown95E59B ; 95/E59B

        .al
        .xl
        .autsiz
        .databank ?

        lda $0AF4,b,x
        bit #$0001
        beq _E5C8
        jsr rsUnknown95BFB3
        xba
        and #$00FF
        bne _E5AD
        inc a

        _E5AD
        pha
        lda $0AF4,b,x
        and #$0006
        cmp #$0006
        bne _E5BC
        pla
        asl a
        pha

        _E5BC
        pla
        pha
        lda $0B34,b,x
        sec
        sbc #1,s
        sta $0B34,b,x
        pla

        _E5C8
        rts

        .databank 0

        ; 95/E5C9

      rlUnknown95E5C9 ; 95/E5C9

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$80
        sta $2100,b
        sta bBufferINIDISP
        rep #$20
        inc wGameStateRoutine1,b
        stz wGameStateStep,b
        rtl

        .databank 0

        ; 95/E5DB

      rlUnknown95E5DB ; 95/E5DB

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$00
        sta $2100,b
        sta bBufferINIDISP
        rep #$20
        sep #$20
        lda bBufferNMITIMEN
        ora #$01
        sta $4200,b
        sta bBufferNMITIMEN
        rep #$20
        jsr rsUnknown958B07
        bcs _E5FC
        jml _E69D


        _E5FC
        lda $7FFC59
        bit #$0400
        beq _E616
        jsl rlUnknown95A52D
        lda #$0003
        sta $0D77,b
        lda #<>rsUnknown80B122
        sta wMainLoopPointer
        bra _E68B


        _E616
        lda $7E4EA9
        and #$00FF
        cmp #$0000
        bne _E633
        jsl rlUnknown95A52D
        lda #$0002
        sta $0D77,b
        lda #<>rsUnknown80B122
        sta wMainLoopPointer
        bra _E68B


        _E633
        cmp #$0001
        bne _E642
        jsl rlUnknown95A52D
        jsl rlUnknown80B74B
        bra _E68B


        _E642
        cmp #$0002
        bne _E658
        jsl rlUnknown95A52D
        lda #$0005
        sta $088B,b
        lda #<>rsUnknown80B6B6
        sta wMainLoopPointer
        bra _E68B


        _E658
        cmp #$0003
        bne _E66E
        jsl rlUnknown95A52D
        lda #$0005
        sta $088B,b
        lda #<>rsUnknown80B6B6
        sta wMainLoopPointer
        bra _E68B


        _E66E
        cmp #$00FF
        bne _E67C
        jsl rlUnknown95A52D
        stz wGameStateRoutine1,b
        bra _E69D


        _E67C
        jsl rlUnknown95A52D
        lda #$0002
        sta $0D77,b
        lda #<>rsUnknown80B122
        sta wMainLoopPointer

        _E68B
        jsl rlResetHDMAEngine
        lda bUnknown000E7B,b
        bit #$0001
        beq _E69D
        lda #$0001
        trb bUnknown000E7B,b

        _E69D
        rtl

        .databank 0

        ; 95/E69E

    .endsection Unsorted95E3DFSection


    .section Unsorted95E6AASection

      .al
      .xl

      rlUnknown95E6AA ; 95/E6AA

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 95/E6AB

      rlUnknown95E6AB ; 95/E6AB

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 95/E6AC

    .endsection Unsorted95E6AASection


    .section Unsorted95E7B3Section

      .al
      .xl

      rlUnknown95E7B3 ; 95/E7B3

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000
        lda #$01FF

        _E7BA
        sta $7E9F88,x
        inc x
        inc x
        cpx #$0280
        bcc _E7BA
        jsl rlUnknown95E9EF
        plx
        rtl

        .databank 0

        ; 95/E7CB

      rlUnknown95E7CB ; 95/E7CB

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown95E834
        lda $7FE4D7
        sta lR18+1
        lda $7FE4D6
        sta lR18
        jsl rlUnknown918102
        lda #$0000
        sta $7FE4D9
        lda #$0001
        sta aDialogue.wTextSound,b
        rtl

        .databank 0

        ; 95/E7EC

      rlUnknown95E7EC ; 95/E7EC

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown95E834
        lda $7FE4D7
        sta lR18+1
        lda $7FE4D6
        sta lR18
        jsl rlUnknown918102
        lda #$0000
        sta $7FE4D9
        lda #$0001
        sta aDialogue.wTextSound,b
        rtl

        .databank 0

        ; 95/E80D

    .endsection Unsorted95E7B3Section


    .section Unsorted95E834Section

      .al
      .xl

      rsUnknown95E834 ; 95/E834

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlResetDialogueEngine
        lda #$0003
        jsl rlHDMAEngineFreeEntryByIndex
        lda #$0006
        jsl rlHDMAEngineFreeEntryByIndex
        lda #$7000
        sta $18D7,b
        sta $18F0,b
        lda #$7E00
        sta $18D5,b
        sta $18EE,b
        lda #$A01C
        sta $18D4,b
        sta $18ED,b
        lda #$0614
        sta $18DB,b
        sta $18F4,b
        lda #$01FF
        sta aDialogue.wClearTile,b
        lda #$2000
        sta aDialogue.wBaseTile,b
        rts

        .databank 0

        ; 95/E877

    .endsection Unsorted95E834Section


    .section Unsorted95E888Section

      .al
      .xl

      rlUnknown95E888 ; 95/E888

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown9181F6
        jsl rlUnknown95E8B4
        jsl rlUnknown95EA03
        jsl rlUnknown96A21F
        lda $7FE4D9
        beq _E8A5
        dec a
        sta $7FE4D9
        bra _E8B3


        _E8A5
        lda aDialogue.wStatus,b
        and #$00FF
        bne _E8B3
        jsl rlUnknown96C9FE
        bra _E8B3


        _E8B3
        rtl

        .databank 0

        ; 95/E8B4

      rlUnknown95E8B4 ; 95/E8B4

        .al
        .xl
        .autsiz
        .databank ?

        lda #$7E00
        sta lR18+1
        lda #$A008
        sta lR18
        ldy #$7640
        lda #$0180
        jsl rlUnknown95C4E3
        rtl

        .databank 0

        ; 95/E8C9

      rlUnknown95E8C9 ; 95/E8C9

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlDialogueFreeHDMA
        rtl

        .databank 0

        ; 95/E8CE

      rlUnknown95E8CE ; 95/E8CE

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda aActionStructUnit1.WeaponInventorySlot
        bmi _E8E9
        lda $7E4ED1
        cmp #$FFFF
        bne _E8E9
        lda aActionStructUnit2.ObtainedStealMoney
        bne _E8E9
        lda $7E4ED3
        beq _E8FC

        _E8E9
        lda #$002A
        jsl rlUnknown96A4B2
        lda #$0000
        sta wBufferBG3VOFS
        lda #$0000
        sta $7FE4D9

        _E8FC
        rtl

        .databank 0

        ; 95/E8FD

      rlUnknown95E8FD ; 95/E8FD

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda $7E4ED1
        cmp #$FFFF
        beq _E930
        lda #$9800
        sta $7FE4D7
        lda #$FF87
        sta $7FE4D6
        lda $7E4ED1
        sta aDialogue.wItemID,b
        lda #$002C
        jsl rlUnknown96A4B2
        lda #$0092
        jsl rlPlaySoundEffect
        lda #$0057
        sta $7FE4D9

        _E930
        rtl

        .databank 0

        ; 95/E931

      rlUnknown95E931 ; 95/E931

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda $7E4ED3
        beq _E961
        lda #$9800
        sta $7FE4D7
        lda #$FF98
        sta $7FE4D6
        lda $7E4ED3
        sta aDialogue.wNumber1,b
        lda #$002F
        jsl rlUnknown96A4B2
        lda #$0092
        jsl rlPlaySoundEffect
        lda #$0057
        sta $7FE4D9

        _E961
        rtl

        .databank 0

        ; 95/E962

      rlUnknown95E962 ; 95/E962

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda aActionStructUnit2.ObtainedStealMoney
        beq _E992
        lda #$9800
        sta $7FE4D7
        lda #$FFAB
        sta $7FE4D6
        lda aActionStructUnit2.ObtainedStealMoney
        sta aDialogue.wNumber1,b
        lda #$002F
        jsl rlUnknown96A4B2
        lda #$0093
        jsl rlPlaySoundEffect
        lda #$0067
        sta $7FE4D9

        _E992
        rtl

        .databank 0

        ; 95/E993

      rlUnknown95E993 ; 95/E993

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda aActionStructUnit1.WeaponInventorySlot
        bpl _E9C3
        lda #$9800
        sta $7FE4D7
        lda #$FFBB
        sta $7FE4D6
        lda aActionStructUnit1.WeaponID
        sta aDialogue.wItemID,b
        lda #$0044
        jsl rlUnknown96A4B2
        lda #$0093
        jsl rlPlaySoundEffect
        lda #$0067
        sta $7FE4D9

        _E9C3
        rtl

        .databank 0

        ; 95/E9C4

      rlUnknown95E9C4 ; 95/E9C4

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda aActionStructUnit1.WeaponInventorySlot
        bmi _E9D9
        lda $7E4ED1
        cmp #$FFFF
        bne _E9D9
        lda $7E4ED3
        beq _E9EE

        _E9D9
        lda #$9800
        sta $7FE4D7
        lda #$FFB9
        sta $7FE4D6
        lda #$0030
        jsl rlUnknown96A4B2

        _E9EE
        rtl

        .databank 0

        ; 95/E9EF

      rlUnknown95E9EF ; 95/E9EF

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000

        _E9F3
        lda $E000D0,x
        sta $0274,b,x
        inc x
        inc x
        cpx #$000A
        bcc _E9F3
        plx
        rtl

        .databank 0

        ; 95/EA03

      rlUnknown95EA03 ; 95/EA03

        .al
        .xl
        .autsiz
        .databank ?

        lda aDialogue.wStatus,b
        bit #$4000
        bne _EA18
        lda aDialogue.wStatus,b
        bit #$8000
        beq _EA46
        ldy #$88EE
        bra _EA1B


        _EA18
        ldy #$88E2

        _EA1B
        lda $7FFC78
        sta wNextFreeSpriteOffset,b
        clc
        adc #$0008
        sta $7FFC7A
        phb
        sep #$20
        lda #$99
        pha
        plb
        .databank $99
        rep #$20
        lda #$00D8
        sta wR0
        lda #$00C0
        sta wR1
        stz wR4
        stz wR5
        jsl rlPushToOAMBuffer
        plb
        .databank $99

        _EA46
        rtl

        .databank 0

        ; 95/EA47

    .endsection Unsorted95E888Section


    .section Unsorted95EA47Section

      .al
      .xl

      rlUnknown95EA47 ; 95/EA47

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$00
        sta $7FD8AB
        sta $7FD8BA
        lda #$E0
        sta bBufferCOLDATA_3
        sta bBufferCOLDATA_1
        sta bBufferCOLDATA_2
        rep #$20
        jsl rlUnknown95EA6A
        jsl rlUnknown9BE1C0
        jsl rlUnknown9BE179
        rtl

        .databank 0

        ; 95/EA6A

      rlUnknown95EA6A ; 95/EA6A

        .al
        .xl
        .autsiz
        .databank ?

        lda #$9500
        sta lR18+1
        lda #$EA91
        sta lR18
        jsl rlUnknown96BD1A
        lda #$0000
        sta wBufferBG2HOFS
        sta wBufferBG2VOFS
        sta wBufferBG1HOFS
        lda #$00F0
        sta wBufferBG1VOFS
        sep #$20
        lda #$80
        sta $7FD073
        rep #$20
        rtl

        .databank 0

        ; 95/EA91

    .endsection Unsorted95EA47Section


    .section Unsorted95ED4ESection

      .al
      .xl

      rlUnknown95ED4E ; 95/ED4E

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda bBufferTS
        ora #$04
        sta bBufferTS
        rep #$20
        rtl

        .databank 0

        ; 95/ED59

      rlUnknown95ED59 ; 95/ED59

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda wR0
        sta bBufferTM
        sta bBufferTS
        rep #$20
        lda #$7FFF
        sta aBGPaletteBuffer,b
        rtl

        .databank 0

        ; 95/ED6A

      rlUnknown95ED6A ; 95/ED6A

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda wR0
        sta bBufferTM
        sta bBufferTS
        rep #$20
        lda #$0000
        sta aBGPaletteBuffer,b
        rtl

        .databank 0

        ; 95/ED7B

    .endsection Unsorted95ED4ESection


    .section Unsorted95EE73Section

      .al
      .xl

      rlUnknown95EE73 ; 95/EE73

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        rep #$10
        ldx #$5B0E
        stx DecompressionVariables
        lda #$F5
        sta $CA
        ldx #$0000
        stx $CB
        lda #$7F
        sta $CD
        rep #$30
        jsl rlDecompressor
        sep #$20
        rep #$10
        ldx #$E9EE
        stx DecompressionVariables
        lda #$94
        sta $CA
        ldx #$4000
        stx $CB
        lda #$7F
        sta $CD
        rep #$30
        jsl rlDecompressor
        sep #$20
        rep #$10
        ldx #$7599
        stx DecompressionVariables
        lda #$F5
        sta $CA
        ldx #$6000
        stx $CB
        lda #$7F
        sta $CD
        rep #$30
        jsl rlDecompressor
        sep #$20
        rep #$10
        ldx #$597A
        stx DecompressionVariables
        lda #$F5
        sta $CA
        ldx #$6800
        stx $CB
        lda #$7F
        sta $CD
        rep #$30
        jsl rlDecompressor
        ldx #$0000

        _EEE6
        lda $7F6000,x
        sta $7F7800,x
        inc x
        inc x
        cpx #$0800
        bcc _EEE6
        lda $7F6000
        sta $7F7BFA
        sta $7F7BFC
        ldx #$0000

        _EF04
        sta $7F7D80,x
        inc x
        inc x
        cpx #$00C0
        bcc _EF04
        ldx #$0000

        _EF12
        sta $7F7EA0,x
        inc x
        inc x
        cpx #$001A
        bcc _EF12
        sep #$20
        rep #$10
        ldx #$BFA1
        stx DecompressionVariables
        lda #$9C
        sta $CA
        ldx #$8B88
        stx $CB
        lda #$7E
        sta $CD
        rep #$30
        jsl rlDecompressor
        ldx #$0000

        _EF3C
        lda $7E8C2A,x
        sta $7F6700,x
        lda $7E8C4A,x
        sta $7F6720,x
        inc x
        inc x
        cpx #$001E
        bcc _EF3C
        rtl

        .databank 0

        ; 95/EF54

    .endsection Unsorted95EE73Section


    .section Unsorted95EF54Section

      .al
      .xl

      rlUnknown95EF54 ; 95/EF54

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        rep #$10
        ldx #$7765
        stx DecompressionVariables
        lda #$F5
        sta $CA
        ldx #$8B88
        stx $CB
        lda #$7E
        sta $CD
        rep #$30
        jsl rlDecompressor
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $0B00, $80, $A200

        sep #$20
        rep #$10
        ldx #$7B55
        stx DecompressionVariables
        lda #$F5
        sta $CA
        ldx #$8B88
        stx $CB
        lda #$7E
        sta $CD
        rep #$30
        jsl rlDecompressor
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $1000, $80, $B000

        sep #$20
        rep #$10
        ldx #$7C2D
        stx DecompressionVariables
        lda #$F5
        sta $CA
        ldx #$8B88
        stx $CB
        lda #$7E
        sta $CD
        rep #$30
        jsl rlDecompressor
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $0800, $80, $1800

        sep #$20
        rep #$10
        ldx #$8000
        stx DecompressionVariables
        lda #$9C
        sta $CA
        ldx #$8B88
        stx $CB
        lda #$7E
        sta $CD
        rep #$30
        jsl rlDecompressor
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $4000, $80, $4000

        sep #$20
        rep #$10
        ldx #$BBB7
        stx DecompressionVariables
        lda #$9C
        sta $CA
        ldx #$8B88
        stx $CB
        lda #$7E
        sta $CD
        rep #$30
        jsl rlDecompressor
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $0800, $80, $0000

        sep #$20
        rep #$10
        ldx #$7E44
        stx DecompressionVariables
        lda #$F5
        sta $CA
        ldx #$8B88
        stx $CB
        lda #$7E
        sta $CD
        rep #$30
        jsl rlDecompressor
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $2C80, $80, $C000

        jsl rlDMAByStruct

          .structDMAToVRAM $7F0000, $2200, $80, $8000

        jsl rlDMAByStruct

          .structDMAToVRAM $7F4000, $2000, $80, $2000

        jsl rlDMAByStruct

          .structDMAToVRAM $7F6000, $0800, $80, $F800

        jsl rlDMAByStruct

          .structDMAToVRAM $7F6800, $0800, $80, $1000

        ldx #$0000

        _F081
        lda $E026C3,x
        sta $0162,b,x
        lda $E026E1,x
        sta $0122,b,x
        lda $E026FF,x
        sta $0142,b,x
        lda $E0271D,x
        sta $0242,b,x
        lda $E02769,x
        sta $0282,b,x
        lda $E02667,x
        lsr a
        and #$3DEF
        sta $01E2,b,x
        inc x
        inc x
        cpx #$001E
        bcc _F081
        ldx #$0000

        _F0B9
        lda $E02759,x
        sta $0182,b,x
        inc x
        inc x
        cpx #$0012
        bcc _F0B9
        ldx #$0000

        _F0CA
        lda $7F6700,x
        sta $01A2,b,x
        lda $7F6720,x
        sta $01C2,b,x
        inc x
        inc x
        cpx #$001E
        bcc _F0CA
        stz aBGPaletteBuffer.aPalette2,b
        stz aBGPaletteBuffer.aPalette3,b
        stz aBGPaletteBuffer.aPalette4,b
        rtl

        .databank 0

        ; 95/F0E9

    .endsection Unsorted95EF54Section


    .section Unsorted95F0E9Section

      .al
      .xl

      rlUnknown95F0E9 ; 95/F0E9

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$11
        sta bBufferTM
        lda #$00
        sta bBufferTS
        lda #$00
        sta bBufferTMW
        lda #$00
        sta bBufferTSW
        lda #$04
        sta bBufferBG12NBA
        lda #$03
        sta bBufferOBSEL
        lda #$09
        sta bBufferBGMODE
        lda #$00
        sta bBufferMOSAIC
        lda #$68
        sta bBufferBG1SC
        lda #$6C
        sta bBufferBG2SC
        rep #$20
        lda #$0000
        sta wBufferBG1HOFS
        lda #$0000
        sta wBufferBG1VOFS
        lda #$0000
        sta wBufferBG2HOFS
        lda #$0000
        sta wBufferBG2VOFS
        rtl

        .databank 0

        ; 95/F12A

    .endsection Unsorted95F0E9Section


    .section Unsorted95F12ASection

      .al
      .xl

      rlUnknown95F12A ; 95/F12A

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 95/F12B

      rlUnknown95F12B ; 95/F12B

        .al
        .xl
        .autsiz
        .databank ?

        lda $04BA,b
        bne _F13A
        lda wJoy1New
        bit #$1000
        beq _F13A
        sec
        bra _F13B


        _F13A
        clc

        _F13B
        rtl

        .databank 0

        ; 95/F13C

      rlUnknown95F13C ; 95/F13C

        .al
        .xl
        .autsiz
        .databank ?

        lda $04BA,b
        bne _F14B
        lda wJoy1Input
        bit #$1000
        beq _F14B
        sec
        bra _F14C


        _F14B
        clc

        _F14C
        rtl

        .databank 0

        ; 95/F14D

      rlUnknown95F14D ; 95/F14D

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phy
        lda $7FE18A
        beq _F1A6
        lda $7FE18F
        tay
        lda $7FE18C
        sta lR18
        lda $7FE18D
        sta lR18+1
        lda #$0800
        cmp $7FE18A
        bcc _F180
        lda $7FE18A
        jsl rlUnknown95C43E
        lda #$0000
        sta $7FE18A
        bra _F1A6


        _F180
        pha
        jsl rlUnknown95C43E
        lda $7FE18A
        sec
        sbc #1,s
        sta $7FE18A
        lda $7FE18C
        clc
        adc #1,s
        sta $7FE18C
        pla
        lsr a
        clc
        adc $7FE18F
        sta $7FE18F

        _F1A6
        ply
        pla
        rtl

        .databank 0

        ; 95/F1A9

      rlUnknown95F1A9 ; 95/F1A9

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta $7FD08B
        lda #$9700
        sta $7FD08D
        lda #$F19B
        sta $7FD08C
        rtl

        .databank 0

        ; 95/F1BF

      rlUnknown95F1BF ; 95/F1BF

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta $7FD08B
        lda #$9700
        sta $7FD08D
        lda #$F45A
        sta $7FD08C
        rtl

        .databank 0

        ; 95/F1D5

      rlUnknown95F1D5 ; 95/F1D5

        .al
        .xl
        .autsiz
        .databank ?

        phy
        lda $7FD08B
        and #$00FF
        beq _F246
        lda $7FD08C
        sta lR18
        lda $7FD08D
        sta lR18+1
        ldy #$0000
        lda [lR18],y
        and #$00FF
        cmp #$0000
        beq _F204
        cmp #$0001
        beq _F225
        cmp #$0002
        beq _F227
        bra _F246


        _F204
        jsl rlUnknown95F256
        bcs _F246
        lda $7FD08C
        clc
        adc #$000B
        sta $7FD08C
        sep #$20
        lda $7FD08B
        dec a
        sta $7FD08B
        rep #$20
        bra _F246


        _F225
        bra _F246


        _F227
        jsl rlUnknown95F29B
        bcs _F246
        lda $7FD08C
        clc
        adc #$0008
        sta $7FD08C
        sep #$20
        lda $7FD08B
        dec a
        sta $7FD08B
        rep #$20

        _F246
        ply
        rtl

        .databank 0

        ; 95/F248

    .endsection Unsorted95F12ASection


    .section Unsorted95F248Section

      .al
      .xl

      rlUnknown95F248 ; 95/F248

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda $7FD08B
        inc a
        sta $7FD08B
        rep #$20
        rtl

        .databank 0

        ; 95/F256

    .endsection Unsorted95F248Section


    .section Unsorted95F256Section

      .al
      .xl

      rlUnknown95F256 ; 95/F256

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda $7FECF4
        and #$00FF
        sec
        bne _F298
        ldy #$0001
        ldx #$0000

        _F268
        lda [lR18],y
        sta $7FECF5,x
        inc y
        inc y
        inc x
        inc x
        cpx #$000A
        bne _F268
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
        clc

        _F298
        ply
        plx
        rtl

        .databank 0

        ; 95/F29B

      rlUnknown95F29B ; 95/F29B

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda $7FECF4
        and #$00FF
        sec
        bne _F2E2
        ldy #$0001
        ldx #$0000
        sep #$20

        _F2AF
        lda [lR18],y
        sta $7FECF8,x
        inc y
        inc x
        cpx #$0007
        bne _F2AF
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
        clc

        _F2E2
        ply
        plx
        rtl

        .databank 0

        ; 95/F2E5

    .endsection Unsorted95F256Section


    .section Unsorted95F426Section

      .al
      .xl

      rlUnknown95F426 ; 95/F426

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$5AD6
        sta $011A,b
        lda #$9900
        sta lR18+1
        lda #$FE18
        sta lR18
        lda #$0000
        sta wR0
        jsl rlUnknown96DB94
        rtl

        .databank 0

        ; 95/F440

      rlUnknown95F440 ; 95/F440

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$9900
        sta lR18+1
        lda #$FE20
        sta lR18
        lda #$0000
        sta wR0
        jsl rlUnknown96DB94
        lda #$9900
        sta lR18+1
        lda #$FE25
        sta lR18
        lda #$0000
        sta wR0
        jsl rlUnknown96DB94
        lda #$9900
        sta lR18+1
        lda #$FE2A
        sta lR18
        lda #$0000
        sta wR0
        jsl rlUnknown96DB94
        rtl

        .databank 0

        ; 95/F47A

      rlUnknown95F47A ; 95/F47A

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$9700
        sta lR18+1
        lda #$AE0A
        sta lR18
        lda #$0000
        sta wR0
        jsl rlUnknown96DB94
        rtl

        .databank 0

        ; 95/F48E

    .endsection Unsorted95F426Section


    .section Unsorted95F741Section

      .al
      .xl

      rlUnknown95F741 ; 95/F741

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
        lda #$08
        sta $7FEC65
        lda #$C0
        sta $7FEC66
        rep #$20
        lda #$0000
        sta aUnit2DataBuffer._Inventory.ItemCount
        sta aUnit2DataBuffer._Inventory.Items
        sta $7FEC5A
        sta $7FEC5C
        rtl

        .databank 0

        ; 95/F777

    .endsection Unsorted95F741Section


    .section Unsorted95F7B7Section

      .al
      .xl

      rlUnknown95F7B7 ; 95/F7B7

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$9700
        sta lR18+1
        lda #$F64E
        sta lR18
        ldx #$0000
        jsl rlUnknown96AC1F
        lda #$0000
        sta aUnit2DataBuffer._ROM.StrengthGrowth
        lda #$0080
        sta $7FEC1F
        lda #$9800
        sta $7FEC21
        lda #$0000
        sta $7FEC23
        rtl

        .databank 0

        ; 95/F7E5

      rlUnknown95F7E5 ; 95/F7E5

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$9700
        sta lR18+1
        lda #$A7C7
        sta lR18
        ldx #$0000
        jsl rlUnknown96AC1F
        rtl

        .databank 0

        ; 95/F7F7

    .endsection Unsorted95F7B7Section


    .section Unsorted95F7F7Section

      .al
      .xl

      rlUnknown95F7F7 ; 95/F7F7

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
        lda #$30
        sta $7FED6C
        lda #$7F
        sta $7FED6D
        rep #$20
        lda #$00FF
        sta $7FE51B
        rtl

        .databank 0

        ; 95/F831

    .endsection Unsorted95F7F7Section


    .section Unsorted95F87FSection

      .al
      .xl

      rlUnknown95F87F ; 95/F87F

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000

        _F883
        sep #$20
        lda #$00
        sta $7FD08F,x
        rep #$20
        txa
        clc
        adc #$0062
        tax
        cpx #$04FA
        bcc _F883
        plx
        rtl

        .databank 0

        ; 95/F89A

      rlUnknown95F89A ; 95/F89A

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000

        _F89E
        lda $7FD08F,x
        bit #$0080
        beq _F8AF
        jsl rlUnknown95F8BC
        jsl rlUnknown9BEAE8

        _F8AF
        txa
        clc
        adc #$0062
        tax
        cpx #$04FA
        bcc _F89E
        plx
        rtl

        .databank 0

        ; 95/F8BC

      rlUnknown95F8BC ; 95/F8BC

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda $7FD09A,x
        and #$00FF
        beq _F8D2
        sep #$20
        dec a
        sta $7FD09A,x
        rep #$20
        bra _F91D


        _F8D2
        lda $7FD094,x
        sta lR18
        lda $7FD095,x
        sta lR18+1
        ldy #$0000
        lda [lR18],y
        and #$00FF
        cmp #$0080
        bne _F901
        lda [lR18],y
        xba
        and #$00FF
        asl a
        pha
        lda $7FD094,x
        sec
        sbc #1,s
        sta $7FD094,x
        pla
        bra _F8D2


        _F901
        sep #$20
        dec a
        sta $7FD099,x
        inc y
        lda [lR18],y
        sta $7FD09A,x
        rep #$20
        lda $7FD094,x
        clc
        adc #$0002
        sta $7FD094,x

        _F91D
        lda $7FD095,x
        sta lR18+1
        lda $7FD097,x
        sta lR18
        lda $7FD099,x
        and #$00FF
        asl a
        tay
        lda [lR18],y
        clc
        adc $7FD097,x
        tay
        lda $7FD090,x
        sta wR0
        lda $7FD092,x
        sta wR1
        lda $7FD09B,x
        sta wR5
        lda $7FD09D,x
        sta wR4
        sep #$20
        phb
        lda $7FD096,x
        pha
        plb
        .databank ?
        rep #$20
        phx
        jsl rlPushToOAMBuffer
        plx
        plb
        .databank ?
        ply
        plx
        rtl

        .databank 0

        ; 95/F967

      rlUnknown95F967 ; 95/F967

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        ldy #$0000
        lda [lR18],y
        sta $7FD094,x
        inc y
        inc y
        sep #$20
        lda [lR18],y
        sta $7FD096,x
        inc y
        lda #$80
        sta $7FD08F,x
        lda #$00
        sta $7FD09A,x
        rep #$20
        lda [lR18],y
        sta $7FD097,x
        inc y
        inc y
        lda [lR18],y
        sta $7FD090,x
        inc y
        inc y
        lda [lR18],y
        sta $7FD092,x
        inc y
        inc y
        lda [lR18],y
        sta $7FD09D,x
        inc y
        inc y
        lda [lR18],y
        sta $7FD09B,x
        ply
        plx
        rtl

        .databank 0

        ; 95/F9B4

    .endsection Unsorted95F87FSection


    .section Unsorted95FCA4Section

      .al
      .xl

      rlUnknown95FCA4 ; 95/FCA4

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta $7FD04C
        lda #$9700
        sta $7FD053
        lda #$F48B
        sta $7FD052
        jsl rlUnknown95FD44
        lda #$9500
        sta $7FD008,x
        lda #$FD44
        sta $7FD007,x
        rtl

        .databank 0

        ; 95/FCCC

      rlUnknown95FCCC ; 95/FCCC

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta $7FD04C
        lda #$9700
        sta $7FD053
        lda #$F57D
        sta $7FD052
        jsl rlUnknown95FD44
        lda #$9500
        sta $7FD008,x
        lda #$FD44
        sta $7FD007,x
        rtl

        .databank 0

        ; 95/FCF4

      rlUnknown95FCF4 ; 95/FCF4

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta $7FD04C
        lda #$9700
        sta $7FD053
        lda #$F5C7
        sta $7FD052
        jsl rlUnknown95FD44
        lda #$9500
        sta $7FD008,x
        lda #$FD44
        sta $7FD007,x
        rtl

        .databank 0

        ; 95/FD1C

    .endsection Unsorted95FCA4Section


    .section Unsorted95FD44Section

      .al
      .xl

      rlUnknown95FD44 ; 95/FD44

        .al
        .xl
        .autsiz
        .databank ?

        phy
        lda $7FD8B7
        and #$00FF
        bne _FD84
        lda $7FD052
        sta lR18
        lda $7FD053
        sta lR18+1
        lda $7FD04C
        tay
        lda [lR18],y
        and #$00FF
        cmp #$00FF
        beq _FD7A
        sep #$20
        sta bBufferINIDISP
        rep #$20
        lda $7FD04C
        inc a
        sta $7FD04C
        bra _FD84


        _FD7A
        sep #$20
        lda #$00
        sta $7FD006,x
        rep #$20

        _FD84
        ply
        rtl

        .databank 0

        ; 95/FD86

      rlUnknown95FD86 ; 95/FD86

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$0000
        sta $7FD046
        sta $7FD048
        jsl rlUnknown95FDA6
        lda #$9500
        sta $7FD008,x
        lda #$FDA6
        sta $7FD007,x
        plx
        rtl

        .databank 0

        ; 95/FDA6

      rlUnknown95FDA6 ; 95/FDA6

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FD046
        bne _FDB1
        lda wBufferBG1VOFS
        dec a
        sta wBufferBG1VOFS

        _FDB1
        lda $7FD046
        inc a
        cmp #$0006
        bcc _FDBE
        lda #$0000

        _FDBE
        sta $7FD046
        lda $7FD048
        bne _FDD2
        lda wBufferBG2HOFS
        dec a
        sta wBufferBG2HOFS
        lda wBufferBG2VOFS
        inc a
        sta wBufferBG2VOFS

        _FDD2
        lda $7FD048
        inc a
        cmp #$0003
        bcc _FDDF
        lda #$0000

        _FDDF
        sta $7FD048
        rtl

        .databank 0

        ; 95/FDE4

    .endsection Unsorted95FD44Section


    .section Unsorted95FF51Section

      .al
      .xl

      rlUnknown95FF51 ; 95/FF51

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda $7FD046
        bne _FF5C
        lda wBufferBG1VOFS
        inc a
        sta wBufferBG1VOFS

        _FF5C
        lda $7FD046
        inc a
        cmp #$0002
        bcc _FF69
        lda #$0000

        _FF69
        sta $7FD046
        rtl

        .databank 0

        ; 95/FF6E

    .endsection Unsorted95FF51Section
