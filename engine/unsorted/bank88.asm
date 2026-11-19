; Code from bank $88 not yet assigned to a game system.

    .section Unsorted888082Section

      .al
      .xl

      rlUnknown888082 ; 88/8082

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0001
        sta wUnknown00075A,b
        lda #$03FF
        sta wUnknown000596,b
        phk
        plb
        .databank $88
        rep #$30
        lda #$1809
        sta $4350,b
        lda #$8800
        sta $4353,b
        lda #$8189
        sta $4352,b
        lda #$4000
        sta $4355,b
        lda #$6000
        sta $2116,b
        sep #$20
        lda #$20
        sta $420B,b
        rep #$20
        stz wDMAArrayPosition,b
        jsl rlDMAByStruct

          .structDMAToVRAM $DE40C0, $0400, $80, $C000

        jsl rlDMAByStruct

          .structDMAToVRAM $D90000, $5000, $80, $0000

        jsl rlUnknown889305
        ldx #$17FE

        _80DD
        lda $D95000,x
        sta $7F0800,x
        dec x
        dec x
        bpl _80DD
        ldx #$00DE

        _80EC
        lda $8C9520,x
        sta $0220,b,x
        dec x
        dec x
        bpl _80EC
        ldx #$001E

        _80FA
        lda $8C9D00,x
        sta aOAMPaletteBuffer,b,x
        dec x
        dec x
        bpl _80FA
        sep #$20
        lda #$08
        sta bBufferWH0
        lda #$F8
        sta bBufferWH1
        stz bBufferWH2
        stz bBufferWH3
        lda #$03
        sta bBufferW12SEL
        sta bBufferW34SEL
        lda #$15
        sta bBufferTM
        lda bBufferBG1SC
        and #$FC
        sta bBufferBG1SC
        lda bBufferBG3SC
        and #$FC
        sta bBufferBG3SC
        lda #$54
        sta bBufferBG2SC
        lda #$03
        sta bBufferWOBJSEL
        rep #$20
        lda #$000A
        sta wJoyRepeatDelay
        lda #$0002
        sta wJoyRepeatInterval
        jsl rlUnknown88C3F0
        lda wMapXOffset,b
        sta wMapScrollXPixels,b
        sta wBufferBG1HOFS
        sta wBufferBG3HOFS
        lda wMapYOffset,b
        sta wMapScrollYPixels,b
        sta wBufferBG1VOFS
        sta wBufferBG3VOFS
        lda #$0020
        trb $0788,b
        stz wUnknown000770,b
        stz wUnknown000766,b
        stz wUnknown0007D8,b
        stz $07DA,b
        stz $086F,b
        stz wMapScrollSpeed,b
        stz wMapScrollDirectionIdentifier,b
        jsl rlUnknown8883C8
        jsl rlUnknown88DE1B
        jsr rlUnknown8881B8
        jsl rlUnknown88CD4C
        jsl rlUnknown88CD5A
        jsl rlUnknown88D073
        rtl

        .databank 0

        ; 88/8188

    .endsection Unsorted888082Section


    .section Unsorted88818ASection

      .al
      .xl

      rlUnknown88818A ; 88/818A

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$054A
        lda #$0000

        _8190
        sta $0592,b,x
        dec x
        bpl _8190
        rtl

        .databank 0

        ; 88/8197

    .endsection Unsorted88818ASection


    .section Unsorted8881B8Section

      .al
      .xl

      rlUnknown8881B8 ; 88/81B8

        .al
        .xl
        .autsiz
        .databank ?

        lda $0786,b
        bit #$0001
        bne _81C6
        bit #$0002
        bne _81D5

        _81C5
        rts


        _81C6
        lda $0772,b
        jsl rlUnknown88B4DB
        lda #$0001
        trb $0786,b
        bra _81C5


        _81D5
        bra _81C5

        .databank 0

        ; 88/81D7

    .endsection Unsorted8881B8Section


    .section Unsorted8881ECSection

      .al
      .xl

      rlUnknown8881EC ; 88/81EC

        .al
        .xl
        .autsiz
        .databank ?

        phk
        plb
        .databank $88
        rep #$30
        lda #$1809
        sta $4300,b
        lda #$8800
        sta $4303,b
        lda #$8219
        sta $4302,b
        lda #$4000
        sta $4305,b
        lda #$6000
        sta $2116,b
        sep #$20
        lda #$01
        sta $420B,b
        rep #$20
        rtl

        .databank 0

        ; 88/8218

    .endsection Unsorted8881ECSection


    .section Unsorted88821ASection

      .al
      .xl

      rlUnknown88821A ; 88/821A

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0001
        sta wUnknown00075A,b
        lda #$03FF
        sta wUnknown000596,b
        rep #$30
        lda #$1809
        sta $4300,b
        lda #$8800
        sta $4303,b
        lda #$83C5
        sta $4302,b
        lda #$2000
        sta $4305,b
        lda #$7000
        sta $2116,b
        sep #$20
        lda #$01
        sta $420B,b
        rep #$20
        stz wDMAArrayPosition,b
        jsl rlDMAByStruct

          .structDMAToVRAM $D90000, $5000, $80, $0000

        jsl rlUnknown889305
        ldx #$17FE

        _8266
        lda $D95000,x
        sta $7F0800,x
        dec x
        dec x
        bpl _8266
        jsl rlDMAByStruct

          .structDMAToVRAM $DE40C0, $0400, $80, $C000

        ldx #$00DE

        _8282
        lda $8C9520,x
        sta $0220,b,x
        dec x
        dec x
        bpl _8282
        ldx #$001E

        _8290
        lda $8C9D00,x
        sta aOAMPaletteBuffer,b,x
        dec x
        dec x
        bpl _8290
        sep #$20
        lda #$08
        sta bBufferWH0
        lda #$F8
        sta bBufferWH1
        stz bBufferWH2
        stz bBufferWH3
        lda #$03
        sta bBufferW12SEL
        sta bBufferW34SEL
        lda #$15
        sta bBufferTM
        lda bBufferBG1SC
        and #$FC
        sta bBufferBG1SC
        lda bBufferBG3SC
        and #$FC
        sta bBufferBG3SC
        lda #$54
        sta bBufferBG2SC
        lda #$03
        sta bBufferWOBJSEL
        rep #$20
        lda #$000A
        sta wJoyRepeatDelay
        lda #$0002
        sta wJoyRepeatInterval
        jsl rlUnknown88C3F0
        lda wMapXOffset,b
        sta wMapScrollXPixels,b
        sta wBufferBG1HOFS
        sta wBufferBG3HOFS
        lda wMapYOffset,b
        sta wMapScrollYPixels,b
        sta wBufferBG1VOFS
        sta wBufferBG3VOFS
        stz wUnknown000770,b
        stz wUnknown000766,b
        stz wUnknown0007D8,b
        stz $07DA,b
        stz $086F,b
        stz wMapScrollSpeed,b
        stz wMapScrollDirectionIdentifier,b
        jsl rlUnknown8883C8
        lda #$0000
        jsl rlUnknown88CC75
        jsl rlUnknown88CD68
        lda #$0001
        jsl rlUnknown88CC75
        jsl rlUnknown88CD68
        lda #$0002
        jsl rlUnknown88CC75
        jsl rlUnknown88CD68
        lda #$0003
        jsl rlUnknown88CC75
        jsl rlUnknown88CD68
        lda #$0004
        jsl rlUnknown88CC75
        jsl rlUnknown88CD68
        lda #$0005
        jsl rlUnknown88CC75
        jsl rlUnknown88CD68
        lda #$0006
        jsl rlUnknown88CC75
        jsl rlUnknown88CD68
        lda #$0007
        jsl rlUnknown88CC75
        jsl rlUnknown88CD68
        lda #$0008
        jsl rlUnknown88CC75
        jsl rlUnknown88CD68
        lda #$0009
        jsl rlUnknown88CC75
        jsl rlUnknown88CD68
        lda #$000A
        jsl rlUnknown88CC75
        jsl rlUnknown88CD68
        lda #$000B
        jsl rlUnknown88CC75
        jsl rlUnknown88CD68
        lda #$000C
        jsl rlUnknown88CC75
        jsl rlUnknown88CD68
        lda #$000D
        jsl rlUnknown88CC75
        jsl rlUnknown88CD68
        lda #$000E
        jsl rlUnknown88CC75
        jsl rlUnknown88CD68
        lda #$000F
        jsl rlUnknown88CC75
        jsl rlUnknown88CD68
        jsr rlUnknown8881B8
        jsl rlUnknown88CD4C
        jsl rlUnknown88CD5A
        jsl rlUnknown88D073
        rtl

        .databank 0

        ; 88/83C4

    .endsection Unsorted88821ASection


    .section Unsorted8883C7Section

      .al
      .xl

      rlUnknown8883C7 ; 88/83C7

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 88/83C8

      rlUnknown8883C8 ; 88/83C8

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0001
        sta wMapEnableXScrollFlag,b
        sta wMapEnableYScrollFlag,b
        lda wMapScrollXPixels,b
        sta wUnknown000734,b
        lda wMapScrollYPixels,b
        sta wUnknown000736,b
        clc
        adc #$0100
        sta wMapScrollYPixels,b
        lda #$0008
        sta wMapScrollSpeed,b

        _83EA
        jsr rsMapScrollUpSetBGOFS
        jsl rlUnknown888798
        jsl rlUnknown8887EC
        lda wUnknown000736,b
        cmp wMapScrollYPixels,b
        bcc _83EA
        lda wUnknown000734,b
        sta wMapScrollXPixels,b
        lda wUnknown000736,b
        sta wMapScrollYPixels,b
        stz wMapEnableXScrollFlag,b
        stz wMapEnableYScrollFlag,b
        rtl

        .databank 0

        ; 88/8410

    .endsection Unsorted8883C7Section


    .section Unsorted888410Section

      .al
      .xl

      rlUnknown888410 ; 88/8410

        .al
        .autsiz
        .databank ?

        lda #1
        sta wMapEnableXScrollFlag,b
        sta wMapEnableYScrollFlag,b

        lda wMapScrollXPixels,b
        sta wUnknown000734,b
        lda wMapScrollYPixels,b
        sta wUnknown000736,b
        clc
        adc #$0100
        sta wMapScrollYPixels,b
        lda #8
        sta wMapScrollSpeed,b

        stz wUnknown00072C,b
        stz wUnknown00072E,b

        lda wUnknown000736,b
        and #$00F8
        asl a
        asl a
        asl a
        clc
        adc #$07C0
        and #$07FF
        sta $0724,b
        
          -
          jsr rsMapScrollUpSetBGOFS
          jsl rlUnknown8887AD
          jsr rlUnknown88847D

          lda wUnknown000736,b
          cmp wMapScrollYPixels,b
          bcc -

        jsl rlDMAByStruct
          .structDMAToVRAM $7E7388, $0800, $80, $A000

        lda wUnknown000734,b
        sta wMapScrollXPixels,b
        lda wUnknown000736,b
        sta wMapScrollYPixels,b

        stz wMapEnableXScrollFlag,b
        stz wMapEnableYScrollFlag,b
        rtl

        .databank 0

        ; 88/847D

    .endsection Unsorted888410Section


    .section Unsorted88847DSection

      .al
      .xl

      rlUnknown88847D ; 88/847D

        .al
        .xl
        .autsiz
        .databank ?

        ldx $0724,b
        ldy #$0000

        _8483
        lda $05DC,b,y
        sta aBG2TilemapBuffer,x
        inc x
        inc x
        inc y
        inc y
        cpy #$0040
        bcc _8483
        lda $0724,b
        sec
        sbc #$0040
        sta $0724,b
        bpl _84A5
        lda #$07C0
        sta $0724,b

        _84A5
        rts

        .databank 0

        ; 88/84A6

      rlUnknown8884A6 ; 88/84A6

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0001
        sta wMapEnableXScrollFlag,b
        sta wMapEnableYScrollFlag,b
        lda wMapScrollXPixels,b
        sta wUnknown000734,b
        lda wMapScrollYPixels,b
        sta wUnknown000736,b
        clc
        adc #$0100
        sta wMapScrollYPixels,b
        lda #$0008
        sta wMapScrollSpeed,b
        lda wUnknown000736,b
        and #$00F8
        asl a
        asl a
        asl a
        clc
        adc #$07C0
        and #$07FF
        sta $0724,b

        _84DB
        jsr rsMapScrollUpSetBGOFS
        jsl rlUnknown888505
        lda wUnknown000736,b
        cmp wMapScrollYPixels,b
        bcc _84DB
        jsl rlUnknown878459
        lda wUnknown000734,b
        sta wMapScrollXPixels,b
        sta wBufferBG3HOFS
        lda wUnknown000736,b
        sta wMapScrollYPixels,b
        sta wBufferBG3VOFS
        stz wMapEnableXScrollFlag,b
        stz wMapEnableYScrollFlag,b
        rtl

        .databank 0

        ; 88/8505

      rlUnknown888505 ; 88/8505

        .al
        .xl
        .autsiz
        .databank ?

        stz wR2
        lda wMapScrollYPixels,b
        and #$0008
        beq _8514
        lda #$0002
        sta wR2

        _8514
        jsr rsUnknown888D57
        lda wR3
        sec
        sbc #$0000
        tax
        stz wUnknown00072A,b
        lda wMapScrollXPixels,b
        and #$0008
        bne _8531
        lda #$0000
        jsr rlUnknown888A14
        bra _8537


        _8531
        lda #$0000
        jsr rlUnknown888C5F

        _8537
        ldx $0724,b
        ldy #$0000

        _853D
        lda $06DC,b,y
        sta aBG3TilemapBuffer,x
        inc x
        inc x
        inc y
        inc y
        cpy #$0040
        bcc _853D
        lda $0724,b
        sec
        sbc #$0040
        sta $0724,b
        bpl _855F
        lda #$07C0
        sta $0724,b

        _855F
        rtl

        .databank 0

        ; 88/8560

    .endsection Unsorted88847DSection


    .section Unsorted888560Section

      .al
      .xl

      rlUnknown888560 ; 88/8560

        .al
        .autsiz
        .databank ?

        lda wUnknown00073A,b
        beq +

          jsl rlUnknown88864F

          lda $0788,b
          bit #$0020
          bne +

            lda wMapScrollXPixels,b
            sta wMapXOffset,b
            lda wMapScrollYPixels,b
            sta wMapYOffset,b

        +
        rtl

        .databank 0

        ; 88/857E

    .endsection Unsorted888560Section


    .section Unsorted8885D3Section

      .al
      .xl

      rlUnknown8885D3 ; 88/85D3

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0001
        sta wUnknown00073A,b
        sta wMapEnableYScrollFlag,b
        jsl rlUnknown8886B3
        rtl

        .databank 0

        ; 88/85E1

      rlUnknown8885E1 ; 88/85E1

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0001
        sta wUnknown00073A,b
        sta wMapEnableYScrollFlag,b
        jsl rlUnknown8886BB
        rtl

        .databank 0

        ; 88/85EF

    .endsection Unsorted8885D3Section


    .section Unsorted8885EFSection

      .al
      .xl

      rlUnknown8885EF ; 88/85EF

        .al
        .autsiz
        .databank ?

        lda #1
        sta wUnknown00073A,b
        sta wMapEnableXScrollFlag,b

        jsl rlUnknown8886A3
        rtl

        .databank 0

      rlUnknown8885FD ; 88/85FD
      
        .al
        .autsiz
        .databank ?

        lda #1
        sta wUnknown00073A,b
        sta wMapEnableXScrollFlag,b

        jsl rlUnknown8886AB
        rtl

        .databank 0

    .endsection Unsorted8885EFSection


    .section Unsorted88860BSection

      .al
      .xl

      rlUnknown88860B ; 88/860B

        .al
        .autsiz
        .databank ?

        lda #1
        sta wUnknown00073A,b
        sta wMapEnableXScrollFlag,b
        sta wMapEnableYScrollFlag,b

        jsl rlUnknown8886C3
        rtl

        .databank 0

    .endsection Unsorted88860BSection


    .section Unsorted88861CSection

      .al
      .xl

      rlUnknown88861C ; 88/861C

        .al
        .autsiz
        .databank ?

        lda #1
        sta wUnknown00073A,b
        sta wMapEnableXScrollFlag,b
        sta wMapEnableYScrollFlag,b

        jsl rlUnknown8886E1
        rtl

        .databank 0

      rlUnknown88862D ; 88/862D

        .al
        .autsiz
        .databank ?

        lda #1
        sta wUnknown00073A,b
        sta wMapEnableXScrollFlag,b
        sta wMapEnableYScrollFlag,b

        jsl rlUnknown8886D2
        rtl

        .databank 0

      rlUnknown88863E ; 88/863E

        .al
        .autsiz
        .databank ?

        lda #1
        sta wUnknown00073A,b
        sta wMapEnableXScrollFlag,b
        sta wMapEnableYScrollFlag,b

        jsl rlUnknown8886F0
        rtl

        .databank 0

      rlUnknown88864F ; 88/864F
      
        .al
        .autsiz
        .databank ?

        lda wMapScrollDirectionIdentifier,b
        cmp #$0200
        beq _867B

        cmp #$0100
        beq _8680

        cmp #$0800
        beq _8685

        cmp #$0400
        beq _868A

        cmp #$0A00
        beq _868F

        cmp #$0600
        beq _8694

        cmp #$0900
        beq _8699

        cmp #$0500
        beq _869E

        rtl

        _867B
        jsl rlUnknown8886A3
        rtl
        
        _8680
        jsl rlUnknown8886AB
        rtl
        
        _8685
        jsl rlUnknown8886B3
        rtl
        
        _868A
        jsl rlUnknown8886BB
        rtl
        
        _868F
        jsl rlUnknown8886C3
        rtl
        
        _8694
        jsl rlUnknown8886E1
        rtl
        
        _8699
        jsl rlUnknown8886D2
        rtl
        
        _869E
        jsl rlUnknown8886F0
        rtl

        .databank 0

      rlUnknown8886A3 ; 88/86A3

        .al
        .autsiz
        .databank ?

        jsr rsMapScrollLeftSetBGOFS
        jsl rlUnknown8887D6
        rtl

        .databank 0

      rlUnknown8886AB ; 88/86AB

        .al
        .autsiz
        .databank ?

        jsr rsMapScrollRightSetBGOFS
        jsl rlUnknown8887BC
        rtl

        .databank 0

      rlUnknown8886B3 ; 88/86B3

        .al
        .autsiz
        .databank ?

        jsr rsMapScrollUpSetBGOFS
        jsl rlUnknown888798
        rtl

        .databank 0

      rlUnknown8886BB ; 88/86BB

        .al
        .autsiz
        .databank ?

        jsr rsMapScrollDownSetBGOFS
        jsl rlUnknown88877F
        rtl

        .databank 0

      rlUnknown8886C3 ; 88/86C3

        .al
        .autsiz
        .databank ?

        jsr rsMapScrollLeftSetBGOFS
        jsr rsMapScrollUpSetBGOFS
        jsl rlUnknown8887D6
        jsl rlUnknown888798
        rtl

        .databank 0

      rlUnknown8886D2 ; 88/86D2

        .al
        .autsiz
        .databank ?

        jsr rsMapScrollRightSetBGOFS
        jsr rsMapScrollUpSetBGOFS
        jsl rlUnknown8887BC
        jsl rlUnknown888798
        rtl

        .databank 0

      rlUnknown8886E1 ; 88/86E1

        .al
        .autsiz
        .databank ?

        jsr rsMapScrollLeftSetBGOFS
        jsr rsMapScrollDownSetBGOFS
        jsl rlUnknown8887D6
        jsl rlUnknown88877F
        rtl

        .databank 0

      rlUnknown8886F0 ; 88/86F0
      
        .al
        .autsiz
        .databank ?

        jsr rsMapScrollRightSetBGOFS
        jsr rsMapScrollDownSetBGOFS
        jsl rlUnknown8887BC
        jsl rlUnknown88877F
        rtl

        .databank 0

    .endsection Unsorted88861CSection


    .section Unsorted8887ECSection

      .al
      .xl

      rlUnknown8887EC ; 88/87EC

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $88
        lda wUnknown00072E,b
        bne _87F9
        jml _8877


        _87F9
        stz wUnknown00072E,b
        lda wUnknown000732,b
        clc
        adc #$5000
        sta $2116,b
        sep #$20
        lda #$80
        sta $2115,b
        lda #$01
        sta $4310,b
        lda #$18
        sta $4311,b
        lda #$DC
        sta $4312,b
        lda #$05
        sta $4313,b
        lda #$00
        sta $4314,b
        lda #$40
        sta $4315,b
        lda #$00
        sta $4316,b
        lda #$02
        sta $420B,b
        rep #$20
        lda wUnknown000770,b
        beq _8877
        lda wUnknown000732,b
        clc
        adc #$5800
        sta $2116,b
        sep #$20
        lda #$80
        sta $2115,b
        lda #$01
        sta $4320,b
        lda #$18
        sta $4321,b
        lda #$DC
        sta $4322,b
        lda #$06
        sta $4323,b
        lda #$00
        sta $4324,b
        lda #$40
        sta $4325,b
        lda #$00
        sta $4326,b
        lda #$04
        sta $420B,b
        rep #$20

        _8877
        lda wUnknown00072C,b
        bne _8880
        jml _88FE


        _8880
        stz wUnknown00072C,b
        lda wUnknown000730,b
        clc
        adc #$5000
        sta $2116,b
        sep #$20
        lda #$81
        sta $2115,b
        lda #$01
        sta $4300,b
        lda #$18
        sta $4301,b
        lda #$9C
        sta $4302,b
        lda #$05
        sta $4303,b
        lda #$00
        sta $4304,b
        lda #$40
        sta $4305,b
        lda #$00
        sta $4306,b
        lda #$01
        sta $420B,b
        rep #$20
        lda wUnknown000770,b
        beq _88FE
        lda wUnknown000730,b
        clc
        adc #$5800
        sta $2116,b
        sep #$20
        lda #$81
        sta $2115,b
        lda #$01
        sta $4320,b
        lda #$18
        sta $4321,b
        lda #$9C
        sta $4322,b
        lda #$06
        sta $4323,b
        lda #$00
        sta $4324,b
        lda #$40
        sta $4325,b
        lda #$00
        sta $4326,b
        lda #$04
        sta $420B,b
        rep #$20

        _88FE
        plp
        plb
        .databank $88
        rtl

        .databank 0

        ; 88/8901

    .endsection Unsorted8887ECSection


    .section Unsorted888901Section

      .al
      .xl

      rsUnknown888901 ; 88/8901

        .al
        .autsiz
        .databank ?

        lda wUnknown00075C,b
        cmp #4
        beq ++

          cmp #8
          beq +

          +
          lda wR3
          clc
          adc #$0E00
          rts

        +
        lda wR3
        clc
        adc #$0700
        rts

        .databank 0

      rsUnknown88891C ; 88/891C

        .al
        .autsiz
        .databank ?

        stz wR2
        lda wMapScrollYPixels,b
        and #$0008
        beq +

          lda #2
          sta wR2

        +
        jsr rsUnknown888D57
        jsr rsUnknown888901
        tax
        stz wUnknown00072A,b
        
        lda wMapScrollXPixels,b
        and #$0008
        bne +

          jsr rsUnknown88899F

          lda wUnknown000770,b
          beq _End

            lda #$00E0
            jsr rlUnknown888A14
            bra _End

        +
        jsr rsUnknown888BB3

        lda wUnknown000770,b
        beq _End

          lda #$00E0
          jsr rlUnknown888C5F

        _End
        rts

        .databank 0

      rsUnknown88895C ; 88/895C

        .al
        .autsiz
        .databank ?

        stz $04
        lda $059A,b
        and #$0008
        beq +

          lda #2
          sta $04

        +
        jsr rsUnknown888D57

        lda $06
        sec
        sbc #0
        tax

        stz wUnknown00072A,b

        lda $0598,b
        and #$0008
        bne +

          jsr rsUnknown88899F

          lda wUnknown000770,b
          beq _End

            lda #0
            jsr rlUnknown888A14
            bra _End

        +
        jsr rsUnknown888BB3

        lda wUnknown000770,b
        beq _End

          lda #0
          jsr rlUnknown888C5F

        _End
        rts

        .databank 0

      rsUnknown88899F ; 88/899F

        .al
        .autsiz
        .databank ?

        _Loop
        lda aMapData,x
        and wUnknown000596,b
        asl a
        asl a
        asl a
        clc
        adc wR2
        phx
        tax

        lda $7F0000,x
        and #$DFFF
        sta $05DC,b,y
        lda $7F0004,x
        and #$DFFF
        sta $05DE,b,y

        plx
        lda wUnknown00075A,b
        bit #$0002
        beq +

          lda $7F6400,x
          and #$03FF
          asl a
          asl a
          asl a
          clc
          adc wR2
          phx
          tax

          lda $7F0000,x
          and #$DFFF
          ora #$2000
          sta $065C,b,y
          lda $7F0004,x
          and #$DFFF
          ora #$2000
          sta $065E,b,y

          plx
        
        +
        inc y
        inc y
        inc y
        inc y
        inx
        inc x
        
        -
        lda wUnknown00072A,b
        beq +

          cpy wR8
          bcs _End
          bra _Loop

        +
        cpy #64
        bcc _Loop

          inc wUnknown00072A,b
          ldy #0
          bra -

        _End
        rts

        .databank 0

        ; 88/8A14

    .endsection Unsorted888901Section


    .section Unsorted888A14Section

      .al
      .xl

      rlUnknown888A14 ; 88/8A14

        .al
        .xl
        .autsiz
        .databank ?

        clc
        adc wMapScrollYPixels,b
        sta $0792,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta $078E,b
        lda wMapScrollYPixels,b
        sta wBufferBG3VOFS
        lda wMapScrollXPixels,b
        sta wBufferBG3HOFS
        lsr a
        lsr a
        lsr a
        lsr a
        sta $078C,b
        jsr rlUnknown888D23
        stz wUnknown00072A,b
        ldy wR8

        _8A3B
        lda $078E,b
        cmp $071E,b
        bcc _8A66
        cmp $0722,b
        bcs _8A66
        lda $078C,b
        cmp $071C,b
        bcc _8A66
        cmp $0720,b
        bcs _8A66
        jsr rlUnknown888D47
        lda aMovementMap,x
        and #$00FF
        beq _8A66
        jsr rlUnknown888A93
        bra _8A6F


        _8A66
        lda #$00FF
        sta $06DC,b,y
        sta $06DE,b,y

        _8A6F
        inc $078C,b
        inc y
        inc y
        inc y
        inc y

        _8A76
        lda wUnknown00072A,b
        beq _8A81
        cpy wR8
        bcs _8A92
        bra _8A3B


        _8A81
        cpy #$0040
        bcc _8A8E
        inc wUnknown00072A,b
        ldy #$0000
        bra _8A76


        _8A8E
        jml _8A3B


        _8A92
        rts

        .databank 0

        ; 88/8A93

      rlUnknown888A93 ; 88/8A93

        .al
        .xl
        .autsiz
        .databank ?

        bit #$0080
        beq _8A9C
        jml _8AFC


        _8A9C
        lda $0792,b
        and #$0008
        bne _8AB1
        lda #$284E
        sta $06DC,b,y
        lda #$284F
        sta $06DE,b,y
        rts


        _8AB1
        lda #$285E
        sta $06DC,b,y
        lda #$285F
        sta $06DE,b,y
        rts

        .byte $89, $80, $00, $F0, $04, $5C, $27, $8B, $88, $AD, $92, $07, $29, $08, $00, $D0
        .byte $07, $A9, $4F, $28, $99, $DC, $06, $60, $A9, $5F, $28, $99, $DC, $06, $60, $89
        .byte $80, $00, $F0, $04, $5C, $46, $8B, $88, $AD, $92, $07, $29, $08, $00, $D0, $07
        .byte $A9, $4E, $28, $99, $DC, $06, $60, $A9, $5E, $28, $99, $DC, $06, $60


        _8AFC
        cmp #$0080
        bne _8B05
        jml _8B65


        _8B05
        lda $0792,b
        and #$0008
        bne _8B1A
        lda #$244E
        sta $06DC,b,y
        lda #$244F
        sta $06DE,b,y
        rts


        _8B1A
        lda #$245E
        sta $06DC,b,y
        lda #$245F
        sta $06DE,b,y
        rts

        .byte $C9, $80, $00, $D0, $04, $5C, $87, $8B, $88, $AD, $92, $07, $29, $08, $00, $D0
        .byte $07, $A9, $4F, $24, $99, $DC, $06, $60, $A9, $5F, $24, $99, $DC, $06, $60, $C9
        .byte $80, $00, $D0, $04, $5C, $9D, $8B, $88, $AD, $92, $07, $29, $08, $00, $D0, $07
        .byte $A9, $4E, $24, $99, $DC, $06, $60, $A9, $5E, $24, $99, $DC, $06, $60


        _8B65
        lda $0792,b
        and #$0008
        bne _8B7A
        lda #$2C4E
        sta $06DC,b,y
        lda #$2C4F
        sta $06DE,b,y
        rts


        _8B7A
        lda #$2C5E
        sta $06DC,b,y
        lda #$2C5F
        sta $06DE,b,y
        rts

        .databank 0

        ; 88/8B87

      rlUnknown888B87 ; 88/8B87

        .al
        .xl
        .autsiz
        .databank ?

        lda $0792,b
        and #$0008
        bne _8B96
        lda #$2C4F
        sta $06DC,b,y
        rts


        _8B96
        lda #$2C5F
        sta $06DC,b,y
        rts

        .databank 0

        ; 88/8B9D

      rlUnknown888B9D ; 88/8B9D

        .al
        .xl
        .autsiz
        .databank ?

        lda $0792,b
        and #$0008
        bne _8BAC
        lda #$2C4E
        sta $06DC,b,y
        rts


        _8BAC
        lda #$2C5E
        sta $06DC,b,y
        rts

        .databank 0

        ; 88/8BB3

    .endsection Unsorted888A14Section


    .section Unsorted888BB3Section

      .al
      .xl

      rsUnknown888BB3 ; 88/8BB3

        .al
        .autsiz
        .databank ?

        ; Grabs the next row of map tiles when scrolling down?

        _Loop
        lda aMapData,x
        and wUnknown000596,b
        asl a
        asl a
        asl a
        clc
        adc wR2
        phx
        tax
        lda $7F0004,x
        and #$DFFF
        sta $05DC,b,y
        plx

        lda wUnknown00075A,b
        bit #$0002
        beq +

          lda $7F6400,x
          and #$03FF
          asl a
          asl a
          asl a
          clc
          adc wR2
          phx
          tax
          lda $7F0004,x
          and #$DFFF
          ora #$2000
          sta $065C,b,y
          plx

        +
        inc x
        inc x
        inc y
        inc y
        cpy #64
        bcc +

          inc wUnknown00072A,b
          ldy #0

        +
        lda aMapData,x
        and wUnknown000596,b
        asl a
        asl a
        asl a
        clc
        adc wR2
        phx
        tax
        lda $7F0000,x
        and #$DFFF
        sta $05DC,b,y
        plx

        lda $075A,b
        bit #$0002
        beq +

          lda $7F6400,x
          and #$03FF
          asl a
          asl a
          asl a
          clc
          adc wR2
          phx
          tax
          lda $7F0000,x
          and #$DFFF
          ora #$2000
          sta $065C,b,y
          plx

        +
        inc y
        inc y
        
        -
        lda wUnknown00072A,b
        beq +

          cpy wR8
          bcs _End
          bra _8C5B

        +
        cpy #64
        bcc _8C5B

          inc wUnknown00072A,b
          ldy #0
          bra -

        _End
        rts
        
        _8C5B
        jml _Loop

        .databank 0

        ; 88/8C5F

    .endsection Unsorted888BB3Section


    .section Unsorted888C5FSection

      .al
      .xl

      rlUnknown888C5F ; 88/8C5F

        .al
        .xl
        .autsiz
        .databank ?

        clc
        adc wMapScrollYPixels,b
        sta $0792,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta $078E,b
        lda wMapScrollYPixels,b
        sta wBufferBG3VOFS
        lda wMapScrollXPixels,b
        sta wBufferBG3HOFS
        lsr a
        lsr a
        lsr a
        lsr a
        sta $078C,b
        jsr rlUnknown888D23
        stz wR9
        stz wUnknown00072A,b
        ldy wR8

        _8C88
        lda $078E,b
        cmp $071E,b
        bcc _8CD2
        cmp $0722,b
        bcs _8CD2
        lda $078C,b
        cmp $071C,b
        bcc _8CD2
        cmp $0720,b
        bcs _8CD2
        jsr rlUnknown888D47
        lda aMovementMap,x
        and #$00FF
        beq _8CED
        jsr $888ABE

        _8CB1
        inc $078C,b
        inc y
        inc y
        cpy #$0040
        bcc _8CC1
        inc wUnknown00072A,b
        ldy #$0000

        _8CC1
        jsr rlUnknown888D47
        lda aMovementMap,x
        and #$00FF
        beq _8CF5
        jsr $888ADD
        bra _8CFB


        _8CD2
        inc $078C,b
        lda #$00FF
        sta $06DC,b,y
        inc y
        inc y
        cpy #$0040
        bcc _8CE8
        inc wUnknown00072A,b
        ldy #$0000

        _8CE8
        sta $06DC,b,y
        bra _8CFB


        _8CED
        lda #$00FF
        sta $06DC,b,y
        bra _8CB1


        _8CF5
        lda #$00FF
        sta $06DC,b,y

        _8CFB
        inc y
        inc y

        _8CFD
        inc wR9
        lda wR9
        cmp #$0010
        bcs _8D22
        lda wUnknown00072A,b
        beq _8D11
        cpy wR8
        bcs _8D22
        bra _8D1E


        _8D11
        cpy #$0040
        bcc _8D1E
        inc wUnknown00072A,b
        ldy #$0000
        bra _8CFD


        _8D1E
        jml _8C88


        _8D22
        rts

        .databank 0

        ; 88/8D23

      rlUnknown888D23 ; 88/8D23

        .al
        .xl
        .autsiz
        .databank ?

        lda $078C,b
        sec
        sbc $0720,b
        and #$003F
        sta wR0
        lda $078E,b
        sec
        sbc $0722,b
        and #$003F
        asl a
        asl a
        asl a
        asl a
        asl a
        asl a
        sta $0790,b
        clc
        adc wR0
        tax
        rts

        .databank 0

        ; 88/8D47

      rlUnknown888D47 ; 88/8D47

        .al
        .xl
        .autsiz
        .databank ?

        lda $078C,b
        sec
        sbc $0720,b
        and #$003F
        clc
        adc $0790,b
        tax
        rts

        .databank 0

        ; 88/8D57

    .endsection Unsorted888C5FSection


    .section Unsorted888D57Section

      .al
      .xl

      rsUnknown888D57 ; 88/8D57

        .al
        .autsiz
        .databank ?

        lda wUnknown00075C,b
        cmp #4
        beq ++

          cmp #8
          beq +
          
          +
          lda wMapScrollYPixels,b
          and #$FFF0
          asl a
          asl a
          asl a
          asl a
          sta wR3
          bra _8D7F

        +
        lda wMapScrollYPixels,b
        and #$FFF0
        asl a
        asl a
        asl a
        sta wR3
        bra _8D7F

        _8D7F
        lda wMapScrollXPixels,b
        and #$FFF0
        lsr a
        lsr a
        lsr a
        clc
        adc wR3
        sta wR3
        tax

        lda wMapScrollXPixels,b
        and #$00F8
        lsr a
        lsr a
        and #$003E
        sta wR8
        tay
        rts

        .databank 0

      rsUnknown888D9D ; 88/8D9D

        .al
        .autsiz
        .databank ?

        lda wUnknown00075C,b
        cmp #4
        beq ++

          cmp #8
          beq +

          +
          lda wR0
          clc
          adc #$1000
          rts

        +
        lda wR0
        clc
        adc #$0800
        rts

        .databank 0

      rsUnknown888DB8 ; 88/8DB8

        .al
        .autsiz
        .databank ?

        jsr rsUnknown888E73
        clc
        adc #32
        sta wR0

        jsr rsUnknown888D9D
        sta wR8
        stz wR2

        lda wMapScrollXPixels,b
        and #$0008
        bne +

        lda wR0
        sec
        sbc #2
        sta wR0

        lda wR8
        sec
        sbc #2
        sta wR8
        bra ++

        +
        lda #$FFFC
        sta wR2

        +
        lda wMapScrollYPixels,b
        and #$0008
        bne +

          lda #4
          jsr rsUnknown888EB5

          lda wUnknown000770,b
          beq _End

            lda #$00F8
            jsr rlUnknown888F32
            bra _End

        +
        lda #4
        jsr rlUnknown889108

        lda wUnknown000770,b
        beq _End

          lda #$00F8
          jsr rlUnknown8891BC

        _End
        rts

        .databank 0

      rsUnknown888E14 ; 88/8E14

        .al
        .autsiz
        .databank ?

        ; Gets map tile index from camera position?
        jsr rsUnknown888E73
        sta wR0

        jsr rsUnknown888D9D
        sta wR8

        stz wR2

        lda wMapScrollXPixels,b
        and #$0008
        beq +

          lda #4
          sta wR2

        +
        lda wMapScrollYPixels,b
        and #$0008
        bne +

          lda #0
          jsr rsUnknown888EB5

          lda wUnknown000770,b
          beq _End

            lda #0
            jsr rlUnknown888F32
            bra _End

        +
        lda #0
        jsr rlUnknown889108

        lda wUnknown000770,b
        beq _End

          lda #0
          jsr rlUnknown8891BC

        _End
        rts

        .databank 0

      rsUnknown888E5A ; 88/8E5A

        .al
        .autsiz
        .databank ?

        lda wUnknown00075C,b
        cmp #4
        beq ++

        cmp #8
        beq +
        
        +
        txa
        clc
        adc #$0100
        rts
        
        +
        txa
        clc
        adc #$0080
        rts

        .databank 0

      rsUnknown888E73 ; 88/8E73

        .al
        .autsiz
        .databank ?

        lda wMapScrollYPixels,b
        and #$00F8
        lsr a
        lsr a
        and #62
        sta wR3

        lda wUnknown00075C,b
        cmp #4
        beq ++

          cmp #8
          beq +

          +
          lda wMapScrollYPixels,b
          and #$FFF0
          asl a
          asl a
          asl a
          asl a
          sta wR0
          bra ++
        
        +
        lda wMapScrollYPixels,b
        and #$FFF0
        asl a
        asl a
        asl a
        sta wR0
        bra +
        
        +
        lda wMapScrollXPixels,b
        and #$FFF0
        lsr a
        lsr a
        lsr a
        clc
        adc wR0
        rts

        .databank 0

      rsUnknown888EB5 ; 88/8EB5

        .al
        .autsiz
        .databank ?

        sta wR1
        ldy wR3
        ldx wR0

          _Loop
          lda aMapData,x
          and wUnknown000596,b
          asl a
          asl a
          asl a
          clc
          adc wR2
          phx
          clc
          adc wR1
          tax
          lda $7F0000,x
          and #$DFFF
          sta $059C,b,y
          lda $7F0002,x
          and #$DFFF
          sta $059E,b,y
          plx

          lda wUnknown00075A,b
          bit #$0002
          beq +

            lda $7F6400,x
            and #$03FF
            asl a
            asl a
            asl a
            clc
            adc wR2
            phx
            clc
            adc wR1
            tax
            lda $7F0000,x
            and #$DFFF
            ora #$2000
            sta $061C,b,y
            lda $7F0002,x
            and #$DFFF
            ora #$2000
            sta $061E,b,y
            plx

          +
          inc y
          inc y
          inc y
          inc y
          cpy #64
          bcc +

            ldy #0

          +
          jsr rsUnknown888E5A
          cmp wR8
          bmi +
          bcs _End

          +
          tax
          jml _Loop
        
        _End
        rts

        .databank 0

        ; 88/8F32

    .endsection Unsorted888D57Section


    .section Unsorted888F32Section

      .al
      .xl

      rlUnknown888F32 ; 88/8F32

        .al
        .xl
        .autsiz
        .databank ?

        clc
        adc wMapScrollXPixels,b
        sta $0792,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta $078C,b
        lda wMapScrollXPixels,b
        sta wBufferBG3HOFS
        lda wMapScrollYPixels,b
        sta wBufferBG3VOFS
        lsr a
        lsr a
        lsr a
        lsr a
        sta $078E,b
        jsr rlUnknown8890CF
        stz wR9
        stz wUnknown00072A,b
        lda wR3
        sta wR8
        tay

        _8F5E
        lda $078E,b
        cmp $071E,b
        bcc _8F89
        cmp $0722,b
        bcs _8F89
        lda $078C,b
        cmp $071C,b
        bcc _8F89
        cmp $0720,b
        bcs _8F89
        jsr rlUnknown8890F2
        lda aMovementMap,x
        and #$00FF
        beq _8F89
        jsr rlUnknown888FAF
        bra _8F92


        _8F89
        lda #$00FF
        sta $069C,b,y
        sta $069E,b,y

        _8F92
        inc $078E,b
        inc y
        inc y
        inc y
        inc y
        inc wR9
        lda wR9
        cmp #$0010
        bcs _8FAE
        cpy #$0040
        bcc _8FAA
        ldy #$0000

        _8FAA
        jml _8F5E


        _8FAE
        rts

        .databank 0

        ; 88/8FAF

      rlUnknown888FAF ; 88/8FAF

        .al
        .xl
        .autsiz
        .databank ?

        bit #$0080
        beq _8FB8
        jml _9018


        _8FB8
        lda $0792,b
        and #$0008
        bne _8FCD
        lda #$284E
        sta $069C,b,y
        lda #$285E
        sta $069E,b,y
        rts


        _8FCD
        lda #$284F
        sta $069C,b,y
        lda #$285F
        sta $069E,b,y
        rts

        .byte $89, $80, $00, $F0, $04, $5C, $43, $90, $88, $AD, $92, $07, $29, $08, $00, $D0
        .byte $07, $A9, $5E, $28, $99, $9C, $06, $60, $A9, $5F, $28, $99, $9C, $06, $60, $89
        .byte $80, $00, $F0, $04, $5C, $62, $90, $88, $AD, $92, $07, $29, $08, $00, $D0, $07
        .byte $A9, $4E, $28, $99, $9C, $06, $60, $A9, $4F, $28, $99, $9C, $06, $60


        _9018
        cmp #$0080
        bne _9021
        jml _9081


        _9021
        lda $0792,b
        and #$0008
        bne _9036
        lda #$244E
        sta $069C,b,y
        lda #$245E
        sta $069E,b,y
        rts


        _9036
        lda #$244F
        sta $069C,b,y
        lda #$245F
        sta $069E,b,y
        rts

        .byte $C9, $80, $00, $D0, $04, $5C, $A3, $90, $88, $AD, $92, $07, $29, $08, $00, $D0
        .byte $07, $A9, $5E, $24, $99, $9C, $06, $60, $A9, $5F, $24, $99, $9C, $06, $60, $C9
        .byte $80, $00, $D0, $04, $5C, $B9, $90, $88, $AD, $92, $07, $29, $08, $00, $D0, $07
        .byte $A9, $4E, $24, $99, $9C, $06, $60, $A9, $4F, $24, $99, $9C, $06, $60


        _9081
        lda $0792,b
        and #$0008
        bne _9096
        lda #$2C4E
        sta $069C,b,y
        lda #$2C5E
        sta $069E,b,y
        rts


        _9096
        lda #$2C4F
        sta $069C,b,y
        lda #$2C5F
        sta $069E,b,y
        rts

        .databank 0

        ; 88/90A3

      rlUnknown8890A3 ; 88/90A3

        .al
        .xl
        .autsiz
        .databank ?

        lda $0792,b
        and #$0008
        bne _90B2
        lda #$2C5E
        sta $069C,b,y
        rts


        _90B2
        lda #$2C5F
        sta $069C,b,y
        rts

        .databank 0

        ; 88/90B9

      rlUnknown8890B9 ; 88/90B9

        .al
        .xl
        .autsiz
        .databank ?

        lda $0792,b
        and #$0008
        bne _90C8
        lda #$2C4E
        sta $069C,b,y
        rts


        _90C8
        lda #$2C4F
        sta $069C,b,y
        rts

        .databank 0

        ; 88/90CF

      rlUnknown8890CF ; 88/90CF

        .al
        .xl
        .autsiz
        .databank ?

        lda $078C,b
        sec
        sbc $0720,b
        and #$003F
        sta $0790,b
        lda $078E,b
        sec
        sbc $0722,b
        and #$003F
        asl a
        asl a
        asl a
        asl a
        asl a
        asl a
        clc
        adc $0790,b
        tax
        rts

        .databank 0

        ; 88/90F2

      rlUnknown8890F2 ; 88/90F2

        .al
        .xl
        .autsiz
        .databank ?

        lda $078E,b
        sec
        sbc $0722,b
        and #$003F
        asl a
        asl a
        asl a
        asl a
        asl a
        asl a
        clc
        adc $0790,b
        tax
        rts

        .databank 0

        ; 88/9108

      rlUnknown889108 ; 88/9108

        .al
        .xl
        .autsiz
        .databank ?

        sta wR1
        ldy wR3
        ldx wR0

        _910E
        lda aMapData,x
        and wUnknown000596,b
        asl a
        asl a
        asl a
        clc
        adc wR2
        phx
        clc
        adc wR1
        tax
        lda $7F0002,x
        and #$DFFF
        sta $059C,b,y
        plx
        lda wUnknown00075A,b
        bit #$0002
        beq _9153
        lda $7F6400,x
        and #$03FF
        asl a
        asl a
        asl a
        clc
        adc wR2
        phx
        clc
        adc wR1
        tax
        lda $7F0002,x
        and #$DFFF
        ora #$2000
        sta $061C,b,y
        plx

        _9153
        inc y
        inc y
        cpy #$0040
        bcc _915D
        ldy #$0000

        _915D
        jsr rsUnknown888E5A
        tax
        lda aMapData,x
        and wUnknown000596,b
        asl a
        asl a
        asl a
        clc
        adc wR2
        phx
        clc
        adc wR1
        tax
        lda $7F0000,x
        and #$DFFF
        sta $059C,b,y
        plx
        lda wUnknown00075A,b
        bit #$0002
        beq _91A6
        lda $7F6400,x
        and #$03FF
        asl a
        asl a
        asl a
        clc
        adc wR2
        phx
        clc
        adc wR1
        tax
        lda $7F0000,x
        and #$DFFF
        ora #$2000
        sta $061C,b,y
        plx

        _91A6
        inc y
        inc y
        cpy #$0040
        bcc _91B0
        ldy #$0000

        _91B0
        txa
        cmp wR8
        bmi _91B7
        bcs _91BB

        _91B7
        jml _910E


        _91BB
        rts

        .databank 0

        ; 88/91BC

      rlUnknown8891BC ; 88/91BC

        .al
        .xl
        .autsiz
        .databank ?

        clc
        adc wMapScrollXPixels,b
        sta $0792,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta $078C,b
        lda wMapScrollXPixels,b
        sta wBufferBG3HOFS
        lda wMapScrollYPixels,b
        sta wBufferBG3VOFS
        lsr a
        lsr a
        lsr a
        lsr a
        sta $078E,b
        jsr rlUnknown8890CF
        stz wR9
        stz wUnknown00072A,b
        lda wR3
        sta wR8
        tay

        _91E8
        lda $078E,b
        cmp $071E,b
        bcc _9232
        cmp $0722,b
        bcs _9232
        lda $078C,b
        cmp $071C,b
        bcc _9232
        cmp $0720,b
        bcs _9232
        jsr rlUnknown8890F2
        lda aMovementMap,x
        and #$00FF
        beq _9242
        jsr $888FDA

        _9211
        inc $078E,b
        inc y
        inc y
        cpy #$0040
        bcc _9221
        inc wUnknown00072A,b
        ldy #$0000

        _9221
        jsr rlUnknown8890F2
        lda aMovementMap,x
        and #$00FF
        beq _924A
        jsr $888FF9
        bra _9250


        _9232
        inc $078E,b
        lda #$00FF
        sta $069C,b,y
        inc y
        inc y
        sta $069C,b,y
        bra _9250


        _9242
        lda #$00FF
        sta $069C,b,y
        bra _9211


        _924A
        lda #$00FF
        sta $069C,b,y

        _9250
        inc y
        inc y
        inc wR9
        lda wR9
        cmp #$0010
        bcs _9267
        cpy #$0040
        bcc _9263
        ldy #$0000

        _9263
        jml _91E8


        _9267
        rts

        .databank 0

        ; 88/9268

      rlUnknown889268 ; 88/9268

        .al
        .xl
        .autsiz
        .databank ?

        lda wCurrentChapter,b
        asl a
        clc
        adc wCurrentChapter,b
        tax
        lda $889FC4,x
        sta lR19+1
        lda $889FC3,x
        sta lR19
        ldy #$0000
        lda [lR19],y
        sta lR45
        ldy #$0001
        lda [lR19],y
        sta lR45+1
        lda #(`aMapData)<<8
        sta lR47+1
        lda #<>aMapData
        sta lR47
        jsl rlDecompressSingle
        ldy #$0003
        lda [lR19],y
        sta lR45
        ldy #$0004
        lda [lR19],y
        sta lR45+1
        lda #$7F00
        sta lR47+1
        lda #$0000
        sta lR47
        jsl rlDecompressSingle
        ldy #$000C
        lda [lR19],y
        sta wUnknown00075C,b
        inc y
        inc y
        lda [lR19],y
        sta $075E,b
        inc y
        inc y
        lda [lR19],y
        sta wMapMinXScroll,b
        inc y
        inc y
        lda [lR19],y
        sta wMapMinYScroll,b
        inc y
        inc y
        lda [lR19],y
        sec
        sbc #$0100
        sta wMapMaxXScroll,b
        inc y
        inc y
        lda [lR19],y
        sec
        sbc #$00E0
        sta wMapMaxYScroll,b
        ldy #$0018
        lda [lR19],y
        sta lR45
        ldy #$0019
        lda [lR19],y
        sta lR45+1
        lda #(`aTerrainTileset)<<8
        sta lR47+1
        lda #<>aTerrainTileset
        sta lR47
        jsl rlDecompressSingle
        rtl

        .databank 0

        ; 88/9305

      rlUnknown889305 ; 88/9305

        .al
        .xl
        .autsiz
        .databank ?

        lda wCurrentChapter,b
        asl a
        clc
        adc wCurrentChapter,b
        tax
        lda $889FC4,x
        sta lR19+1
        lda $889FC3,x
        sta lR19
        ldy #$0006
        lda [lR19],y
        sta lR45
        ldy #$0007
        lda [lR19],y
        sta lR45+1
        lda #(`aDecompressionBuffer)<<8
        sta lR47+1
        lda #<>aDecompressionBuffer
        sta lR47
        jsl rlDecompressSingle
        lda #(`aDecompressionBuffer)<<8
        sta lR20+1
        lda #<>aDecompressionBuffer
        sta lR20
        sep #$20
        lda #$80
        sta $2115,b
        lda #$00
        sta $4315,b
        lda #$20
        sta $4316,b
        lda #$18
        sta $4311,b
        lda lR20
        sta $4312,b
        lda lR20+1
        sta $4313,b
        lda lR20+2
        sta $4314,b
        lda #$00
        sta $2116,b
        lda #$28
        sta $2117,b
        lda #$01
        sta $4310,b
        lda #$02
        sta $420B,b
        rep #$20
        ldy #$000A
        lda [lR19],y
        sta lR20+1
        ldy #$0009
        lda [lR19],y
        sta lR20
        ldy #$00DE

        _938C
        lda [lR20],y
        sta $0120,b,y
        dec y
        dec y
        bpl _938C
        rtl

        .databank 0

        ; 88/9396

    .endsection Unsorted888F32Section


    .section Unsorted88973FSection

      .al
      .xl

      rlUnknown88973F ; 88/973F

        .al
        .xl
        .autsiz
        .databank ?

        lda #$8800
        sta lR44+1
        lda #$9396
        sta lR44
        jsl rlProcEngineFindProc
        bcc _9753
        jml _9840


        _9753
        lda #$8800
        sta lR44+1
        lda #$9C52
        sta lR44
        jsl rlProcEngineFindProc
        bcc _9767
        jml _9840


        _9767
        lda wUnknown000D79,b
        bit #$0800
        beq _9773
        jml _9841


        _9773
        lda wUnknown000766,b
        bne _97DA
        lda wJoy1New
        bit #$9000
        beq _978E
        lda #$8800
        sta lR44+1
        lda #$9C52
        sta lR44
        jsl rlProcEngineCreateProc
        rtl


        _978E
        jsr rlUnknown889A41
        lda wJoy1Input
        and #$0F00
        sta wMapScrollDirectionIdentifier,b
        bne _97AC
        lda $0ADB,b
        beq _9801
        stz $0ADB,b
        lda #$001C
        jsl rlUnknown808FAD
        bra _9801


        _97AC
        lda $0ADB,b
        bne _97C2
        inc $0ADB,b
        lda #$001A
        jsl rlUnknown808FAD
        lda #$001B
        jsl rlUnknown808FAD

        _97C2
        stz wMapScrollCurrentPixelDistance,b
        lda #$0001
        sta wUnknown000766,b
        stz wUnknown00073A,b
        stz wMapEnableXScrollFlag,b
        stz wMapEnableYScrollFlag,b
        lda #$0004
        sta wMapScrollSpeed,b

        _97DA
        lda wMapScrollCurrentPixelDistance,b
        clc
        adc wMapScrollSpeed,b
        sta wMapScrollCurrentPixelDistance,b
        cmp #$0010
        bcc _97F5
        stz wUnknown000766,b
        stz wUnknown00073A,b
        stz wMapEnableXScrollFlag,b
        stz wMapEnableYScrollFlag,b

        _97F5
        jsl rlUnknown8899B8
        lda wMapScrollCurrentPixelDistance,b
        cmp wMapScrollSpeed,b
        bne _9801

        _9801
        sep #$20
        lda #$88
        pha
        plb
        .databank $88
        rep #$20
        ldy #$EE94
        lda wMapScrollXPixels,b
        lsr a
        lsr a
        lsr a
        clc
        adc #$0040
        sta wR0
        lda wMapScrollYPixels,b
        lsr a
        lsr a
        lsr a
        clc
        adc #$0030
        sta wR1
        lda #$2000
        sta wR5
        lda #$0000
        sta wR4
        lda wVBlankEnabledFramecount
        and #$0018
        beq _9838
        ldy #$EE7E

        _9838
        jsl rlPushToOAMBuffer
        jsl rlUnknown889A85

        _9840
        rtl


        _9841
        jsr rlUnknown88986C
        lda $087D,b
        asl a
        clc
        adc #$0040
        sec
        sbc #$0010
        sta wR0
        lda $087F,b
        asl a
        clc
        adc #$0030
        sec
        sbc #$0006
        sta wR1
        lda #$0000
        jsl rlUnknown88A704
        jsl rlUnknown889A85
        rtl

        .databank 0

        ; 88/986C

      rlUnknown88986C ; 88/986C

        .al
        .xl
        .autsiz
        .databank ?

        lda wJoy1New
        bit #$0500
        bne _9883
        bit #$0A00
        bne _988A
        bit #$0080
        bne _98B4
        bit #$8000
        bne _98A1
        rts


        _9883
        inc $087B,b
        jml _98D2


        _988A
        dec $087B,b
        lda $087B,b
        bpl _989D
        jsl rlUnknown87E979
        sec
        sbc #$0001
        sta $087B,b

        _989D
        jml _98D2


        _98A1
        lda #$8800
        sta lR44+1
        lda #$9C52
        sta lR44
        jsl rlProcEngineCreateProc
        stz wUnknown0007D8,b
        rts

        .byte $60


        _98B4
        lda #$4000
        tsb $0788,b
        lda #$8800
        sta lR44+1
        lda #$9C52
        sta lR44
        jsl rlProcEngineCreateProc
        rts

        .byte $20, $20, $00, $00, $00, $00, $88, $83, $7E


        _98D2
        lda $087B,b
        jsl rlGetLocationEventDataEntry
        bcs _992C
        jsl rlGetEventLocationEntryType
        cmp #$0000
        bne _9931
        jsl rlGetLocationFactionSlotOwner
        cmp #$0000
        bne _9931
        jsl rlGetEventLocationEntryEffectiveXCoordinate
        sta $078C,b
        jsl rlGetEventLocationEntryEffectiveYCoordinate
        sta $078E,b
        jsl rlGetEventLocationEntryID
        sta $0790,b
        lda #$0000
        jsl rlGetFactionSlotLocationID
        cmp $0790,b
        beq _991E
        lda $078C,b
        sta wR0
        lda $078E,b
        sta wR1
        jsl rlGetUnitByCoordinates
        bcc _9931

        _991E
        lda $078C,b
        sta $087D,b
        lda $078E,b
        sta $087F,b
        bra _9952


        _992C
        stz $087B,b
        bra _98D2


        _9931
        lda wJoy1New
        bit #$0A00
        bne _993D
        inc $087B,b
        bra _98D2


        _993D
        dec $087B,b
        lda $087B,b
        bpl _98D2
        jsl rlUnknown87E979
        sec
        sbc #$0001
        sta $087B,b
        bra _98D2


        _9952
        lda #$8800
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$98C9
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda #$8800
        sta lRoutineVariable+1,b
        lda #$99A4
        sta lRoutineVariable,b
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$040D
        jsl rlDrawMenuTextLine
        jsl rlGetEventLocationEntryCastleName
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$040D
        jsl rlDrawMenuTextLine
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8488, $0080, $80, $B100

        rts

        .databank 0

        ; 88/99A4

    .endsection Unsorted88973FSection


    .section Unsorted8899B8Section

      .al
      .xl

      rlUnknown8899B8 ; 88/99B8

        .al
        .xl
        .autsiz
        .databank ?

        lda wMapScrollXPixels,b
        sta wUnknown000734,b
        lda wMapScrollYPixels,b
        sta wUnknown000736,b
        lda wMapScrollDirectionIdentifier,b
        cmp #$0200
        beq _99F0
        cmp #$0100
        beq _99F6
        cmp #$0800
        beq _99FC
        cmp #$0400
        beq _9A02
        cmp #$0A00
        beq _9A08
        cmp #$0600
        beq _9A0E
        cmp #$0900
        beq _9A14
        cmp #$0500
        beq _9A1A

        _99EF
        rtl


        _99F0
        jsl rlUnknown8885EF
        bra _9A20


        _99F6
        jsl rlUnknown8885FD
        bra _9A20


        _99FC
        jsl rlUnknown8885D3
        bra _9A20


        _9A02
        jsl rlUnknown8885E1
        bra _9A20


        _9A08
        jsl rlUnknown88860B
        bra _9A20


        _9A0E
        jsl rlUnknown88861C
        bra _9A20


        _9A14
        jsl rlUnknown88862D
        bra _9A20


        _9A1A
        jsl rlUnknown88863E
        bra _9A20


        _9A20
        lda wMapScrollXPixels,b
        cmp wUnknown000734,b
        bne _99EF
        lda wMapScrollYPixels,b
        cmp wUnknown000736,b
        bne _99EF
        lda $0ADB,b
        beq _99EF
        stz $0ADB,b
        lda #$001C
        jsl rlUnknown808FAD
        bra _99EF

        .databank 0

        ; 88/9A41

      rlUnknown889A41 ; 88/9A41

        .al
        .xl
        .autsiz
        .databank ?

        lda wJoy1Input
        bit #$0010
        bne _9A6F
        bit #$0040
        bne _9A6F
        bit #$0080
        bne _9A6F
        bit #$4000
        bne _9A6F
        lda wJoy1New
        bit #$0020
        bne _9A80

        _9A5E
        sep #$20
        lda #$00
        sta bBufferCGWSEL
        lda #$A9
        sta bBufferCGADSUB
        lda #$00
        sta bBufferTS
        rep #$20
        rts


        _9A6F
        sep #$20
        lda #$02
        sta bBufferCGWSEL
        lda #$52
        sta bBufferCGADSUB
        lda #$11
        sta bBufferTS
        rep #$20
        rts


        _9A80
        jsr rlUnknown88C1BF
        bra _9A5E

        .databank 0

        ; 88/9A85

      rlUnknown889A85 ; 88/9A85

        .al
        .xl
        .autsiz
        .databank ?

        lda wVBlankEnabledFramecount
        and #$001E
        tax
        lda $889AE2,x
        and #$03FF
        clc
        adc #$7C00
        sta $01D8,b
        lda $889AE2,x
        and #$7FE0
        clc
        adc #$001F
        sta $01DA,b
        lda $889AE2,x
        and #$7C1F
        clc
        adc #$03E0
        sta $01DC,b
        lda $889AE2,x
        and #$7C00
        clc
        adc #$033F
        sta $01DE,b
        rtl

        .databank 0

        ; 88/9AC4

    .endsection Unsorted8899B8Section


    .section Unsorted88A12BSection

      .al
      .xl

      rlUnknown88A12B ; 88/A12B

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb

        jsl rlUnknown88A136

        plp
        plb
        rtl

        .databank 0

      rlUnknown88A136 ; 88/A136

        .al
        .autsiz
        .databank ?

        stz wUnknown000758,b
        jsr rsUnknown88A32D

        stz wUnknown00073A,b
        stz wMapEnableXScrollFlag,b
        stz wMapEnableYScrollFlag,b

        sep #$20
        lda $70
        rep #$20
        and #$000F
        cmp #$000F
        beq +
        
          -
          jml _End

        +
        lda #(`procFadeIn)<<8
        sta $62+1
        lda #<>procFadeIn
        sta $62
        jsl rlProcEngineFindProc
        bcs -

        lda #(`procFadeInByScreenFadingTimer)<<8
        sta $62+1
        lda #<>procFadeInByScreenFadingTimer
        sta $62
        jsl rlProcEngineFindProc
        bcs -

        lda $0E7B,b
        and #$00FF
        bit #$0041
        beq ++

          lda $086F,b
          bpl +

            jsr rlUnknown88C71C
          
          +
          jml rlUnknown88C4D9

        +
        lda wUnknown00171A,b
        beq +

          jml _End
        
        +
        lda $0788,b
        bit #$0020
        beq +

          jml rlUnknown88973F

        +
        lda $07E0,b
        bpl +

          lda $0772,b
          jsl rlUnknown88B42C
          jml _End
        
        +
        lda $0786,b
        bit #$0002
        beq _A234

          ldx $0772,b
          lda $7E46EB,x
          sta $056F,b

          ldx $0772,b
          lda wCursorXOffset,b
          clc
          adc wMapScrollXPixels,b
          sta $0780,b

          lda $7E44AB,x
          asl a
          asl a
          asl a
          asl a
          sta $0782,b

          lda wCursorXOffset,b
          clc
          adc wMapScrollXPixels,b
          lsr a
          lsr a
          lsr a
          lsr a
          sta $0778,b

          lda wCursorYOffset,b
          clc
          adc wMapScrollYPixels,b
          lsr a
          lsr a
          lsr a
          lsr a
          sta $077A,b

          lda #3
          sta $07DA,b

          stz $07DC,b
          stz $07DE,b
          jsl rlDeployedUnitSetHidden

          stz wUnknown0007E2,b

          jsl rlUnknown88C9A6

          lda $0786,b
          bit #$0008
          bne +

            jsl rlUnknown84B32B

            lda #$0002
            trb $0786,b

            lda #$0004
            tsb $0786,b
            bra _A234

          +
          lda #$0002
          trb $0786,b

          jsl rlUnknown88A2F5

        _A234
        lda wUnknown0007D8,b
        beq _A24F

          cmp #$FFFF
          beq ++

            cmp #$0003
            beq +

              jml rlUnknown88A754
            
            +
            jml rlUnknown88A81D
          
          +
          jml _A2BD

        _A24F
        lda wUnknown000766,b
        bne _A28D

          lda wJoy1New
          bit #~(JOY_Y | JOY_Directions | JOY_ID)
          beq +

            jsr rsMapInputHandler
            stz wMapScrollDirectionIdentifier,b
            bra _A2BD
          
          +
          jsr rlUnknown88A551
          bcc _A2BD

            stz wMapScrollCurrentPixelDistance,b
            lda #1
            sta wUnknown000766,b
            stz wUnknown00073A,b
            stz wMapEnableXScrollFlag,b
            stz wMapEnableYScrollFlag,b
            lda #4
            sta wMapScrollSpeed,b

            lda wJoy1Input
            bit #JOY_Y
            beq _A28D

              lda #8
              sta wMapScrollSpeed,b
        
        _A28D
        lda wMapScrollCurrentPixelDistance,b
        clc
        adc wMapScrollSpeed,b
        sta wMapScrollCurrentPixelDistance,b
        cmp #16
        bcc +

          stz wUnknown000766,b
          stz wUnknown00073A,b
          stz wMapEnableXScrollFlag,b
          stz wMapEnableYScrollFlag,b
          lda #1
          sta wUnknown000758,b

        +
        jsl rlUnknown88BC05

        lda wMapScrollCurrentPixelDistance,b
        cmp wMapScrollSpeed,b
        bne _A2BD

          jsr rlUnknown88BEEF

        _A2BD
        sep #$20
        lda #$88
        pha
        plb
        rep #$20

        ldy #$EE52
        lda wCursorXOffset,b
        sta $00
        lda wCursorYOffset,b
        sta $02
        lda #$2000
        sta $0A
        lda #0
        sta $08

        lda wUnknown000770,b
        beq +

          lda #4
          sta $08
        
        +
        lda $DB
        and #$0018
        beq +

          ldy #$EE3C

        +
        jsl rlPushToOAMBuffer

        _End
        rtl

        .databank 0

        ; 88/A2F5

    .endsection Unsorted88A12BSection


    .section Unsorted88A2F5Section

      .al
      .xl

      rlUnknown88A2F5 ; 88/A2F5

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta wUnknown0007D8,b
        lda $0772,b
        sta wR0
        lda $0774,b
        sta wR1
        lda #$0004
        trb $0786,b
        lda wMapScrollXPixels,b
        sta wMapXOffset,b
        lda wMapScrollYPixels,b
        sta wMapYOffset,b
        lda #$0008
        trb $0786,b
        jsl rlUnknown85921D
        jsl rlUnknown84DC1C
        lda #$0008
        jsl rlUnknown808FAD
        rtl

        .databank 0

        ; 88/A32D

    .endsection Unsorted88A2F5Section


    .section Unsorted88A32DSection

      .al
      .xl

      rsUnknown88A32D ; 88/A32D

        .al
        .autsiz
        .databank ?

        lda $0788,b
        bit #$8000
        beq +

          lda #1
          sta wUnknown000758,b
          lda #$8000
          trb $0788,b
        
        +
        lda $0788,b
        and #$FFE0
        sta $0788,b

        lda wJoy1Input
        bit #$4000 ; JOY_Y
        beq +

          lda #$0001
          tsb $0788,b
        
        +
        lda wUnknown000770,b
        bne +

          lda $0786,b
          bne +

            lda $07E0,b
            beq ++
        
        +
        lda #$0002
        tsb $0788,b

        +
        lda wUnknown0007D8,b
        beq +

          lda #$0004
          tsb $0788,b
        
        +
        lda wUnknown00171A,b
        beq +

          lda #$0010
          tsb $0788,b

        +
        rts

        .databank 0

        ; 88/A383

    .endsection Unsorted88A32DSection


    .section Unsorted88A4FCSection

      .al
      .xl

      rlUnknown88A4FC ; 88/A4FC

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown80B0A3
        jsl rlUnknown859BBD
        rtl

        .databank 0

        ; 88/A505

    .endsection Unsorted88A4FCSection


    .section Unsorted88A551Section

      .al
      .xl

      rlUnknown88A551 ; 88/A551

        .al
        .xl
        .autsiz
        .databank ?

        lda wJoy1Input
        bit #$4000
        bne _A564
        lda wJoy1Repeated
        and #$0F00
        sta wMapScrollDirectionIdentifier,b
        beq _A5C0
        bra _A570


        _A564
        lda wJoy1Input
        and #$0F00
        sta wMapScrollDirectionIdentifier,b
        beq _A5C0
        bra _A5C2


        _A570
        lda wUnknown000770,b
        beq _A5C2
        lda wJoy1New
        and #$0F00
        bne _A5C2
        lda wCursorXOffset,b
        sta wR0
        lda wCursorYOffset,b
        sta wR1
        jsr _A650
        bcc _A5C2
        lda wCursorXOffset,b
        sta wR0
        lda wCursorYOffset,b
        sta wR1
        lda wMapScrollDirectionIdentifier,b
        cmp #$0200
        beq _A5C4
        cmp #$0100
        beq _A5D1
        cmp #$0800
        beq _A5DE
        cmp #$0400
        beq _A5EB
        cmp #$0A00
        beq _A5F8
        cmp #$0600
        beq _A60E
        cmp #$0900
        beq _A624
        cmp #$0500
        beq _A63A

        _A5C0
        clc
        rts


        _A5C2
        sec
        rts


        _A5C4
        lda wCursorXOffset,b
        sec
        sbc #$0010
        sta wR0
        jml _A650


        _A5D1
        lda wCursorXOffset,b
        clc
        adc #$0010
        sta wR0
        jml _A650


        _A5DE
        lda wCursorYOffset,b
        sec
        sbc #$0010
        sta wR1
        jml _A650


        _A5EB
        lda wCursorYOffset,b
        clc
        adc #$0010
        sta wR1
        jml _A650


        _A5F8
        lda wCursorXOffset,b
        sec
        sbc #$0010
        sta wR0
        lda wCursorYOffset,b
        sec
        sbc #$0010
        sta wR1
        jml _A650


        _A60E
        lda wCursorXOffset,b
        sec
        sbc #$0010
        sta wR0
        lda wCursorYOffset,b
        clc
        adc #$0010
        sta wR1
        jml _A650


        _A624
        lda wCursorXOffset,b
        clc
        adc #$0010
        sta wR0
        lda wCursorYOffset,b
        sec
        sbc #$0010
        sta wR1
        jml _A650


        _A63A
        lda wCursorXOffset,b
        clc
        adc #$0010
        sta wR0
        lda wCursorYOffset,b
        clc
        adc #$0010
        sta wR1
        jml _A650


        _A650
        lda wR0
        clc
        adc wMapScrollXPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta $078C,b
        sta wR0
        lda wR1
        clc
        adc wMapScrollYPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta $078E,b
        sta wR1
        lda $078E,b
        cmp $071E,b
        bcc _A696
        cmp $0722,b
        bcs _A696
        lda $078C,b
        cmp $071C,b
        bcc _A696
        cmp $0720,b
        bcs _A696
        jsr rlUnknown888D23
        lda aMovementMap,x
        and #$007F
        beq _A696
        sec
        rts


        _A696
        clc
        rts

        .databank 0

        ; 88/A698

    .endsection Unsorted88A551Section


    .section Unsorted88A704Section

      .al
      .xl

      rlUnknown88A704 ; 88/A704

        .al
        .xl
        .autsiz
        .databank ?

        phb
        phx
        phy
        cmp #$0000
        beq _A710
        lda wR0
        bra _A71E


        _A710
        lda wVBlankEnabledFramecount
        and #$001C
        lsr a
        tax
        lda $88A73D,x
        clc
        adc wR0

        _A71E
        sta wR0
        sep #$20
        lda #$88
        pha
        plb
        .databank $88
        rep #$20
        ldy #$A74D
        lda #$0000
        sta wR4
        lda #$2000
        sta wR5
        jsl rlPushToOAMBuffer
        ply
        plx
        plb
        .databank $88
        rtl

        .databank 0

        ; 88/A73D

    .endsection Unsorted88A704Section


    .section Unsorted88A754Section

      .al
      .xl

      rlUnknown88A754 ; 88/A754

        .al
        .autsiz
        .databank $00

        lda wUnknown000766,b
        bne _A7BA

          lda wUnknown0007D8,b
          cmp #2
          beq _A788

            cmp #4
            beq _A795

              cmp #5
              beq _A795

                cmp #6
                beq _A795

                  cmp #7
                  beq _A795

                    lda #16
                    sta wMapPixelScrollDistance,b
                    jsr rlUnknown88A9B4
                    beq _End

                      lda #8
                      sta wMapScrollSpeed,b
                      bra +
          
          _A788
          stz wMapPixelScrollDistance,b
          jsr rlUnknown88AA1E
          beq _End

            jsr rlUnknown88A7F5
            bra +

          _A795
          lda #16
          sta wMapPixelScrollDistance,b
          jsr rsUnknown88B64F
          beq _End

            lda #8
            sta wMapScrollSpeed
            bra +

          +
          stz wMapScrollCurrentPixelDistance,b
          lda #1
          sta wUnknown000766,b
          stz wUnknown00073A,b
          stz wMapEnableXScrollFlag,b
          stz wMapEnableYScrollFlag,b

        _A7BA
        lda wMapScrollCurrentPixelDistance,b
        clc
        adc wMapScrollSpeed,b
        sta wMapScrollCurrentPixelDistance,b
        cmp wMapPixelScrollDistance,b
        bcc +

          sec
          sbc wMapPixelScrollDistance,b
          sta wR0
          lda wMapScrollSpeed,b
          sec
          sbc wR0
          sta wMapScrollSpeed,b

          stz wUnknown000766,b
          stz wUnknown00073A,b
          stz wMapEnableXScrollFlag,b
          stz wMapEnableYScrollFlag,b
        
        +
        jsl rlUnknown88BC05

        lda wUnknown0007D8,b
        cmp #2
        bne _End

          jsl rlUnknown88C0B3

        _End
        rtl

        .databank 0

        ; 88/A7F5

    .endsection Unsorted88A754Section


    .section Unsorted88A7F5Section

      .al
      .xl

      rlUnknown88A7F5 ; 88/A7F5

        .al
        .xl
        .autsiz
        .databank ?

        ldx $0772,b
        lda $7E46EB,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitTotalSpeed
        cmp #$0005
        bcc _A80F
        lda #$0003
        sta wMapScrollSpeed,b
        rts


        _A80F
        lda #$0001
        sta wMapScrollSpeed,b
        rts

        .databank 0

        ; 88/A816

    .endsection Unsorted88A7F5Section


    .section Unsorted88A81DSection

      .al
      .xl

      rlUnknown88A81D ; 88/A81D

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0003
        sta $07DA,b
        lda wJoy1New
        bit #$8000
        beq _A89A
        lda $077C,b
        sta $0778,b
        lda $077E,b
        sta $077A,b
        lda #$0005
        jsl rlUnknown808FAD
        stz wUnknown0007D8,b
        lda $0786,b
        bit #$0004
        bne _A85D
        lda #$0008
        tsb $0788,b
        jsl rlUnknown85921D
        jsl rlUnknown85E85D
        lda #$0800
        trb wUnknown000D79,b
        rtl


        _A85D
        lda #$0040
        trb wUnknown000D79,b
        lda $0772,b
        tax
        lda $7E441B,x
        asl a
        asl a
        asl a
        asl a
        sec
        sbc wMapScrollXPixels,b
        sta wCursorXOffset,b
        lda $7E44AB,x
        asl a
        asl a
        asl a
        asl a
        sec
        sbc wMapScrollYPixels,b
        sta wCursorYOffset,b
        jsl rlUnknown85921D
        stz $07DA,b
        lda #$0004
        trb $0786,b
        ldx $0772,b
        jsl rlUnknown84CC5D
        rtl


        _A89A
        lda wJoy1Repeated
        bit #$0F00
        bne _A8A3
        bra _A8EB


        _A8A3
        lda #$0005
        jsl rlUnknown808FAD
        jsr rlUnknown88AB47
        lda $0772,b
        sta wR0
        lda $0774,b
        sta wR1
        jsl rlUnknown8591B2
        lda $0774,b
        tax
        lda $7E441B,x
        sta wR10
        lda $7E44AB,x
        sta wR11
        jsl rlUnknown88BFC3
        lda wR10
        bmi _A8DD
        sta wCursorXOffset,b
        lda wR11
        sta wCursorYOffset,b
        bra _A8EB


        _A8DD
        lda $0774,b
        jsl rlUnknown88B4DB
        lda #$0006
        sta wUnknown0007D8,b
        rtl


        _A8EB
        lda $0774,b
        tax
        lda $7E441B,x
        asl a
        asl a
        asl a
        asl a
        sec
        sbc wMapScrollXPixels,b
        sta wR0
        lda $7E44AB,x
        asl a
        asl a
        asl a
        asl a
        sec
        sbc wMapScrollYPixels,b
        sta wR1
        sep #$20
        lda #$88
        pha
        plb
        .databank $88
        rep #$20
        ldy #$EE52
        lda #$0006
        sta wR4
        lda #$2000
        sta wR5
        jsl rlPushToOAMBuffer
        lda wJoy1New
        bit #$0080
        bne _A92C
        rtl


        _A92C
        lda #$0000
        sta wUnknown0007D8,b
        lda $0772,b
        sta wR0
        lda $0774,b
        sta wR1
        lda #$0004
        trb $0786,b
        lda $077C,b
        sta $0778,b
        lda $077E,b
        sta $077A,b
        lda $0772,b
        tax
        lda $7E441B,x
        asl a
        asl a
        asl a
        asl a
        sec
        sbc wMapScrollXPixels,b
        sta wCursorXOffset,b
        lda $7E44AB,x
        asl a
        asl a
        asl a
        asl a
        sec
        sbc wMapScrollYPixels,b
        sta wCursorYOffset,b
        lda wMapScrollXPixels,b
        sta wMapXOffset,b
        lda wMapScrollYPixels,b
        sta wMapYOffset,b
        lda wUnknown000D79,b
        bit #$0800
        bne _A994
        jsl rlUnknown85921D
        jsl rlUnknown84DC1C
        lda #$000A
        jsl rlUnknown808FAD
        rtl


        _A994
        jsl rlUnknown85921D
        stz $087B,b
        lda #$0020
        tsb $0788,b
        jsl rlUnknown85EA64
        lda #$8800
        sta lR44+1
        lda #$9396
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 88/A9B4

      rlUnknown88A9B4 ; 88/A9B4

        .al
        .xl
        .autsiz
        .databank ?

        lda $0778,b
        beq _A9CB
        bpl _A9C3
        inc $0778,b
        lda #$0200
        bra _A9E2


        _A9C3
        dec $0778,b
        lda #$0100
        bra _A9E2


        _A9CB
        lda $077A,b
        beq _A9E6
        bpl _A9DA
        inc $077A,b
        lda #$0800
        bra _A9E2


        _A9DA
        dec $077A,b
        lda #$0400
        bra _A9E2


        _A9E2
        sta wMapScrollDirectionIdentifier,b
        rts


        _A9E6
        stz wUnknown00073A,b
        lda wMapScrollScriptOffset,b
        dec a
        dec a
        sta wMapScrollScriptOffset,b
        lda $077C,b
        sta $0778,b
        lda $077E,b
        sta $077A,b
        ldx $0772,b
        jsl rlDeployedUnitSetHidden
        lda #$0002
        sta wUnknown0007D8,b
        lda #$FFFF
        sta wMapScrollDirectionIdentifier,b
        jsl rlUnknown88C085
        lda #$0002
        sta $07DA,b
        lda #$0000
        rts

        .databank 0

        ; 88/AA1E

      rlUnknown88AA1E ; 88/AA1E

        .al
        .xl
        .autsiz
        .databank ?

        lda wMapScrollScriptOffset,b
        bmi _AA8A
        tax
        lda $0794,b,x
        sta wR0
        beq _AA8A
        cmp #$0001
        beq _AA3F
        cmp #$0002
        beq _AA4A
        cmp #$0003
        beq _AA55
        cmp #$0004
        beq _AA60

        _AA3F
        lda #$0018
        sta wUnknown0007E2,b
        lda #$0400
        bra _AA6B


        _AA4A
        lda #$0010
        sta wUnknown0007E2,b
        lda #$0800
        bra _AA6B


        _AA55
        lda #$0008
        sta wUnknown0007E2,b
        lda #$0100
        bra _AA6B


        _AA60
        lda #$0000
        sta wUnknown0007E2,b
        lda #$0200
        bra _AA6B


        _AA6B
        cmp wMapScrollDirectionIdentifier,b
        bne _AA7A
        sta wMapScrollDirectionIdentifier,b
        jsr rlUnknown88AB13
        lda #$0001
        rts


        _AA7A
        sta wMapScrollDirectionIdentifier,b
        stz $07DC,b
        stz $07DE,b
        jsr rlUnknown88AB13
        lda #$0001
        rts


        _AA8A
        lda #$0010
        sta wMapPixelScrollDistance,b
        jsl rlUnknown88C126
        lda #$0002
        sta $07DA,b
        stz wUnknown0007D8,b
        stz wMapScrollScriptOffset,b
        stz wUnknown00073A,b
        lda wCursorXOffset,b
        clc
        adc wMapScrollXPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR0
        sta $078C,b
        lda wCursorYOffset,b
        clc
        adc wMapScrollYPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR1
        sta $078E,b
        ldx $0772,b
        jsl rlUnknown84C94C
        lda $07E0,b
        cmp #$0004
        beq _AAEF
        cmp #$0005
        beq _AAEF
        cmp #$0009
        beq _AAEF
        lda $086F,b
        bne _AAEB
        jsl rlUnknown85E85D
        lda #$0008
        tsb $0788,b

        _AAEB
        lda #$0000
        rts


        _AAEF
        jsl rlUnknown84D483
        bcc _AB00
        jsl rlUnknown84CAA9
        stz $07E0,b
        lda #$0000
        rts


        _AB00
        lda $07E0,b
        cmp #$0004
        beq _AB0C
        lda #$0000
        rts


        _AB0C
        stz $07E0,b
        lda #$0000
        rts

        .databank 0

        ; 88/AB13

      rlUnknown88AB13 ; 88/AB13

        .al
        .xl
        .autsiz
        .databank ?

        lda wMapPixelScrollDistance,b
        clc
        adc #$0010
        sta wMapPixelScrollDistance,b
        dec x
        dec x
        stx wMapScrollScriptOffset,b
        bmi _AB2B
        lda $0794,b,x
        cmp wR0
        beq $88AB13

        _AB2B
        rts

        .databank 0

        ; 88/AB2C

    .endsection Unsorted88A81DSection


    .section Unsorted88AB47Section

      .al
      .xl

      rlUnknown88AB47 ; 88/AB47

        .al
        .xl
        .autsiz
        .databank ?

        ldx $0772,b
        lda $7E46EB,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlUnknown84F4F7
        cmp #$0000
        beq _AB61
        lda wR11
        cmp #$0003
        bcs _AB65

        _AB61
        jml _ABD4


        _AB65
        lda wJoy1Repeated
        bit #$0A00
        bne _AB82
        lda $0776,b
        clc
        adc #$0001
        cmp #$0400
        bcc _AB7B
        lda #$0000

        _AB7B
        sta $0776,b
        jml _AB95


        _AB82
        lda $0776,b
        sec
        sbc #$0001
        bpl _AB8E
        lda #$03FF

        _AB8E
        sta $0776,b
        jml _ABB6


        _AB95
        ldx $0776,b

        _AB98
        lda aTargetDistanceMap,x
        and #$00FF
        cmp #$00FF
        bne _ABAF
        inc x
        cpx #$0400
        bcc _AB98
        ldx #$0000
        bra _AB98


        _ABAF
        sta $0774,b
        stx $0776,b
        rts


        _ABB6
        ldx $0776,b

        _ABB9
        lda aTargetDistanceMap,x
        and #$00FF
        cmp #$00FF
        bne _ABCD
        dec x
        bpl _ABB9
        ldx #$03FF
        bra _ABB9


        _ABCD
        sta $0774,b
        stx $0776,b
        rts


        _ABD4
        lda wJoy1Repeated
        bit #$0A00
        bne _ABF1
        lda $0776,b
        clc
        adc #$0001
        cmp #$000C
        bcc _ABEA
        lda #$0000

        _ABEA
        sta $0776,b
        jml _AC2E


        _ABF1
        lda $0776,b
        sec
        sbc #$0001
        bpl _ABFD
        lda #$000B

        _ABFD
        sta $0776,b
        jml _AC04


        _AC04
        lda $0776,b
        asl a
        tax

        _AC09
        phx
        lda $88ACF1,x
        tax
        lda aTargetDistanceMap,x
        plx
        and #$00FF
        cmp #$00FF
        bne _AC25
        dec x
        dec x
        bpl _AC09
        ldx #$0016
        bra _AC09


        _AC25
        sta $0774,b
        txa
        lsr a
        sta $0776,b
        rts


        _AC2E
        lda $0776,b
        asl a
        tax

        _AC33
        phx
        lda $88ACF1,x
        tax
        lda aTargetDistanceMap,x
        plx
        and #$00FF
        cmp #$00FF
        bne _AC52
        inc x
        inc x
        cpx #$0018
        bcc _AC33
        ldx #$0000
        bra _AC33


        _AC52
        sta $0774,b
        txa
        lsr a
        sta $0776,b
        rts

        .databank 0

        ; 88/AC5B

    .endsection Unsorted88AB47Section


    .section Unsorted88ADE9Section

      .al
      .xl

      rlUnknown88ADE9 ; 88/ADE9

        .al
        .xl
        .autsiz
        .databank ?

        lda $07E0,b
        bne _AE41

        _ADEE
        ldx $0772,b
        lda aDeploymentTable,x
        bit #$0010
        bne _AE1F
        lda $0778,b
        sta wR0
        lda $077A,b
        sta wR1
        ldx $0772,b
        jsl rlDeployedUnitUnsetHiddenIfAlive
        stz $07DA,b
        jsl rlUnknown84C94C
        lda $0772,b
        jsl rlUnknown88B4DB
        rtl


        _AE1A
        stz $07E0,b
        bra _ADEE


        _AE1F
        lda $0778,b
        sta wR0
        lda $077A,b
        sta wR1
        stz $07DA,b
        ldx $0772,b
        jsl rlUnknown84C94C
        lda $0772,b
        jsl rlUnknown88B4DB
        lda #$0007
        sta wUnknown0007D8,b
        rtl


        _AE41
        lda $07E0,b
        cmp #$0005
        beq _AE70
        lda $0D87,b
        bit #$0008
        bne _AE76
        jsl rlUnknown87BB27
        bcc _AE76
        lda $07E0,b
        cmp #$0002
        beq _AEB3
        cmp #$0003
        beq _AEC8
        cmp #$0004
        beq _AE1A
        cmp #$0009
        beq _AEB1
        bra _AE9C


        _AE70
        lda #$0001
        sta $07E0,b

        _AE76
        lda $0778,b
        sta wR0
        lda $077A,b
        sta wR1
        ldx $0772,b
        jsl rlDeployedUnitUnsetHiddenIfAlive
        stz $07DA,b
        jsl rlUnknown84C94C
        lda $0772,b
        jsl rlUnknown88B4DB
        lda #$0007
        sta wUnknown0007D8,b
        rtl


        _AE9C
        ldx $0772,b
        jsl rlDeployedUnitUnsetHiddenIfAlive
        stz $07DA,b
        ldx $0772,b
        jsl rlUnknown84CC5D
        stz $07E0,b
        rtl


        _AEB1
        bra _AEFE


        _AEB3
        ldx $0772,b
        jsl rlDeployedUnitUnsetHiddenIfAlive
        stz $07DA,b
        ldx $0772,b
        jsl rlUnknown84CFBF
        stz $07E0,b
        rtl


        _AEC8
        lda wCursorXOffset,b
        clc
        adc wMapScrollXPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR0
        lda wCursorYOffset,b
        clc
        adc wMapScrollYPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR1
        jsl rlUnknown87EA09
        lda wEventLocationEntry,b
        sta $0580,b
        jsl rlDeployedUnitUnsetHiddenIfAlive
        stz $07DA,b
        ldx $0772,b
        jsl rlUnknown84CC5D
        stz $07E0,b
        rtl


        _AEFE
        ldx $0772,b
        stz $07DA,b
        lda wCursorXOffset,b
        clc
        adc wMapScrollXPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR0
        sta $0778,b
        sta $077C,b
        lda wCursorYOffset,b
        clc
        adc wMapScrollYPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR1
        sta $077A,b
        sta $077E,b
        jsl rlUnknown84C94C
        stz $07E0,b
        lda $0772,b
        jsl rlUnknown88B4DB
        ldx $0772,b
        lda aDeploymentTable,x
        bit #$0010
        bne _AF45
        rtl


        _AF45
        lda #$0007
        sta wUnknown0007D8,b
        rtl

        .databank 0

        ; 88/AF4C

    .endsection Unsorted88ADE9Section


    .section Unsorted88AF4CSection

      .al
      .xl

      rsUnknown88AF4C ; 88/AF4C

        .al
        .autsiz
        .databank ?

        ; X = deployment offset

        stx $0772,b

        lda wCursorXOffset,b
        clc
        adc wMapScrollXPixels,b
        sta wUnknown00076C,b

        lda wCursorYOffset,b
        clc
        adc wMapScrollYPixels,b
        sta wUnknown00076E,b

        lda #1
        sta $07DA,b
        stz $07DC,b
        stz $07DE,b

        jsl rlDeployedUnitSetHidden

        stz wUnknown0007E2,b
        jsl rlUnknown88C9A6
        rtl

        .databank 0

    .endsection Unsorted88AF4CSection


    .section Unsorted88AF7BSection

      .al
      .xl

      rlUnknown88AF7B ; 88/AF7B

        .al
        .autsiz
        .databank ?

        phx
        stz $07DA,b
        stz $07E0,b

        ldx $0772,b
        lda aDeploymentTable._UnitRAMPointer,x
        beq +

          sta $00089B
        
        +
        ldx $0772,b
        jsl rlDeployedUnitUnsetHiddenIfAlive

        ldx $0772,b
        lda aDeploymentTable._State,x
        bit #DeploymentStateCanto
        bne +

          lda bUnknown000E7B,b
          and #$00FF
          bit #$0041
          bne +

            lda $0772,b
            jsl rlUnknown88B4DB

        +
        plx
        rtl

        .databank 0

    .endsection Unsorted88AF7BSection


    .section Unsorted88B028Section

      .al
      .xl

      rlUnknown88B028 ; 88/B028

        .al
        .xl
        .autsiz
        .databank ?

        lda wUnknown000770,b
        bne _B03F
        jsr rlUnknown88B701
        bcs _B037
        lda wUnknown000770,b
        beq _B06F

        _B037
        lda #$0008
        jsl rlUnknown808FAD
        rts


        _B03F
        lda wUnknown000D79,b
        bit #$0800
        bne _B079
        ldx $0772,b
        lda $7E46EB,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitFactionSlot
        cmp wActiveFactionSlot,b
        bne _B081
        jsr rlUnknown88B8E9
        bcs _B067
        lda #$000A
        jsl rlUnknown808FAD
        rts


        _B067
        lda #$0022
        jsl rlUnknown808FAD
        rts


        _B06F
        jsl rlUnknown88B249
        bcc _B080
        jsr rlUnknown88B10B
        rts


        _B079
        jsr rlUnknown88B096
        rts

        .byte $20, $33, $B1


        _B080
        rts


        _B081
        lda #$0021
        jsl rlUnknown808FAD
        stz $07DA,b
        ldx $0772,b
        jsl rlDeployedUnitUnsetHiddenIfAlive
        jsr rlUnknown88BBD3
        rts

        .databank 0

        ; 88/B096

      rlUnknown88B096 ; 88/B096

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta wUnknown0007D8,b
        stz $07DA,b
        jsr rlUnknown88BBD3
        lda $0772,b
        sta wR0
        lda $0774,b
        sta wR1
        lda $077C,b
        sta $0778,b
        lda $077E,b
        sta $077A,b
        lda $0772,b
        tax
        lda $7E441B,x
        asl a
        asl a
        asl a
        asl a
        sec
        sbc wMapScrollXPixels,b
        sta wCursorXOffset,b
        lda $7E44AB,x
        asl a
        asl a
        asl a
        asl a
        sec
        sbc wMapScrollYPixels,b
        sta wCursorYOffset,b
        lda wMapScrollXPixels,b
        sta wMapXOffset,b
        lda wMapScrollYPixels,b
        sta wMapYOffset,b
        lda wCursorXOffset,b
        clc
        adc wMapScrollXPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR2
        lda wCursorYOffset,b
        clc
        adc wMapScrollYPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR3
        jsl rlUnknown84DC1C
        lda #$0800
        trb wUnknown000D79,b
        rts

        .databank 0

        ; 88/B10B

      rlUnknown88B10B ; 88/B10B

        .al
        .xl
        .autsiz
        .databank ?

        lda wMapScrollXPixels,b
        sta wMapXOffset,b
        lda wMapScrollYPixels,b
        sta wMapYOffset,b
        lda #$0009
        jsl rlUnknown808FAD
        lda #$8500
        sta lR44+1
        lda #$DDDB
        sta lR44
        jsl rlProcEngineCreateProc
        lda #$0008
        tsb $0788,b
        rts

        .databank 0

        ; 88/B133

      rlUnknown88B133 ; 88/B133

        .al
        .xl
        .autsiz
        .databank ?

        ldx $0772,b
        lda aDeploymentTable,x
        bit #$0010
        bne _B183
        lda wUnknown000D79,b
        bit #$0800
        bne _B198
        lda #$0021
        jsl rlUnknown808FAD
        stz $07DA,b
        lda $0772,b
        jsl rlUnknown88B4DB
        jsl rlDeployedUnitUnsetHiddenIfAlive
        jsr rlUnknown88BBD3
        lda $07E0,b
        cmp #$0001
        beq _B16D
        cmp #$0002
        beq _B178
        rts


        _B16D
        ldx $0772,b
        jsl rlUnknown84CC5D
        stz $07E0,b
        rts


        _B178
        ldx $0772,b
        jsl rlUnknown84CFBF
        stz $07E0,b
        rts


        _B183
        stz $07DA,b
        jsl rlDeployedUnitUnsetHiddenIfAlive
        lda $0772,b
        jsl rlUnknown88B4DB
        lda #$0007
        sta wUnknown0007D8,b
        rts


        _B198
        lda $077C,b
        sta $0778,b
        lda $077E,b
        sta $077A,b
        lda #$0005
        jsl rlUnknown808FAD
        jsr rlUnknown88BBD3
        stz wUnknown0007D8,b
        jsl rlUnknown85E85D
        lda #$0008
        tsb $0788,b
        lda #$0800
        trb wUnknown000D79,b
        rts

        .databank 0

        ; 88/B1C2

      rlUnknown88B1C2 ; 88/B1C2

        .al
        .xl
        .autsiz
        .databank ?

        lda wUnknown000770,b
        bne _B1D0
        lda wUnknown000766,b
        beq _B1D1

        _B1CC
        jsl rlUnknown88B249

        _B1D0
        rts


        _B1D1
        jsl rlUnknown88B813
        bcc _B1CC
        stx $0772,b
        ldx $0772,b
        lda $7E46EB,x
        sta wSelectedUnitDataRAMPointer,b
        lda #$0008
        jsl rlUnknown808FAD
        jsl rlUnknown88B3AF
        lda #$B122
        sta $7F8183
        lda #$0000
        sta $7F819D
        lda #$000A
        sta $0304,b
        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        rts

        .databank 0

        ; 88/B20C

      rlUnknown88B20C ; 88/B20C

        .al
        .xl
        .autsiz
        .databank ?

        lda wJoy1Input
        cmp #$1000
        bne _B248
        lda wUnknown000770,b
        bne _B248
        lda $0788,b
        bit #$0020
        bne _B241
        lda #$0020
        tsb $0788,b
        lda wMapScrollXPixels,b
        sta wMapXOffset,b
        lda wMapScrollYPixels,b
        sta wMapYOffset,b
        lda #$8800
        sta lR44+1
        lda #$9396
        sta lR44
        jsl rlProcEngineCreateProc
        rts


        _B241
        lda #$0020
        trb $0788,b
        rts


        _B248
        rts

        .databank 0

        ; 88/B249

      rlUnknown88B249 ; 88/B249

        .al
        .xl
        .autsiz
        .databank ?

        lda wCursorXOffset,b
        clc
        adc wMapScrollXPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR0
        lda wCursorYOffset,b
        clc
        adc wMapScrollYPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR1
        jsl rlUnknown87EA09
        bcs _B2A3
        jsl rlGetEventLocationEntryType
        cmp #$0000
        bne _B2A3
        jsl rlGetLocationFactionSlotOwner
        bmi _B2A3
        cmp #$0000
        bne _B2A3
        jsl rlGetEventLocationEntryID
        sta $089F,b
        lda #$0000
        jsl rlGetFactionSlotLocationID
        cmp $089F,b
        bne _B2A3
        lda #$FFFF
        sta $089B,b
        lda #$0009
        jsl rlUnknown808FAD
        jml _B316

        .byte $18, $6B


        _B2A3
        sec
        rtl

        .byte $BF, $1B, $44, $7E, $0A, $0A, $0A, $0A, $38, $ED, $98, $05, $8D, $68, $07, $BF
        .byte $AB, $44, $7E, $0A, $0A, $0A, $0A, $38, $ED, $9A, $05, $8D, $6A, $07, $AD, $68
        .byte $07, $18, $6D, $98, $05, $4A, $4A, $4A, $4A, $85, $00, $AD, $6A, $07, $18, $6D
        .byte $9A, $05, $4A, $4A, $4A, $4A, $85, $02, $22, $87, $EA, $87, $B0, $28, $22, $78
        .byte $EC, $87, $C9, $01, $00, $F0, $19, $22, $42, $EC, $87, $8D, $9F, $08, $A9, $00
        .byte $00, $22, $3D, $BE, $84, $CD, $9F, $08, $D0, $06, $5C, $16, $B3, $88, $18, $6B
        .byte $5C, $39, $B3, $88, $18, $6B, $38, $6B, $22, $8D, $E9, $87, $5C, $16, $B3, $88
        .byte $6B


        _B316
        jsl rlUnknown88B3AF
        lda #$0000
        sta $088B,b
        jsl rlBuildDeadPlayerCharacterList
        lda #$B6B6
        sta $0ECF,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 88/B339

      rlUnknown88B339 ; 88/B339

        .al
        .xl
        .autsiz
        .databank ?

        lda #$00F0
        jsl rlUnknown808FA3
        lda #$00E0
        jsl rlUnknown808F6F
        jsl rlUnknown88B3AF
        lda #$0001
        sta $088B,b
        lda #$B6B6
        sta $0ECF,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 88/B366

    .endsection Unsorted88B028Section


    .section Unsorted88B3AFSection

      .al
      .xl

      rlUnknown88B3AF ; 88/B3AF

        .al
        .xl
        .autsiz
        .databank ?

        lda #$FFFF
        sta wUnknown0007D8,b
        lda wMapScrollXPixels,b
        sta wMapXOffset,b
        lda wMapScrollYPixels,b
        sta wMapYOffset,b
        rtl

        .databank 0

        ; 88/B3C2

    .endsection Unsorted88B3AFSection


    .section Unsorted88B42CSection

      .al
      .xl

      rlUnknown88B42C ; 88/B42C

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown88B4DB
        lda #$0005
        sta wUnknown0007D8,b
        lda $07E0,b
        cmp #$8002
        beq _B44F
        cmp #$8003
        beq _B456
        cmp #$8004
        beq _B45D
        lda #$0001
        sta $07E0,b
        rtl


        _B44F
        lda #$0002
        sta $07E0,b
        rtl


        _B456
        lda #$0003
        sta $07E0,b
        rtl


        _B45D
        lda #$0004
        sta $07E0,b
        lda #$0008
        sta wUnknown0007D8,b
        rtl

        .databank 0

        ; 88/B46A

    .endsection Unsorted88B42CSection


    .section Unsorted88B4DBSection

      .al
      .xl

      rlUnknown88B4DB ; 88/B4DB

        .al
        .autsiz
        .databank ?

        sta $0784,b

        lda wCursorXOffset,b
        clc
        adc wMapScrollXPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta $078C,b

        lda wCursorYOffset,b
        clc
        adc wMapScrollYPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta $078E,b

        ldx $0784,b
        lda aDeploymentTable._XTilePosition,x
        sec
        sbc $078C,b
        sta $0778,b

        lda aDeploymentTable._YTilePosition,x
        sec
        sbc $078E,b
        sta $077A,b

        lda #$0004
        sta wUnknown0007D8,b
        rtl

        .databank 0

        ; 88/B51A

    .endsection Unsorted88B4DBSection


    .section Unsorted88B51ASection

      .al
      .xl

      rlUnknown88B51A ; 88/B51A

        .al
        .xl
        .autsiz
        .databank ?

        lda wCursorXOffset,b
        clc
        adc wMapScrollXPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta $078C,b
        lda wCursorYOffset,b
        clc
        adc wMapScrollYPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta $078E,b
        ldy #$0090
        jsr rlUnknown88B5CA
        bcs _B561
        lda $0790,b
        bne _B54F
        ldx $0784,b
        dec x
        dec x
        bpl _B55C
        ldx #$008E
        bra _B55C


        _B54F
        ldx $0784,b
        inc x
        inc x
        cpx #$0090
        bcc _B55C
        ldx #$0000

        _B55C
        jsr rlUnknown88B5DD
        bcs _B5C9

        _B561
        lda aDeploymentTable,x
        beq _B5A7
        bit #$0008
        bne _B5A7
        bit #$2000
        bne _B5A7
        bit #$0080
        beq _B5A7
        lda $7E46EB,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitFactionSlot
        cmp wActiveFactionSlot,b
        bne _B5A7
        lda $7E441B,x
        sec
        sbc $078C,b
        sta $0778,b
        lda $7E44AB,x
        sec
        sbc $078E,b
        sta $077A,b
        lda #$0004
        sta wUnknown0007D8,b
        stx $0784,b
        bra _B5C9


        _B5A7
        lda $0790,b
        bne _B5B5
        dec x
        dec x
        bpl _B5BF
        ldx #$008E
        bra _B5BF


        _B5B5
        inc x
        inc x
        cpx #$0090
        bcc _B5BF
        ldx #$0000

        _B5BF
        dec y
        dec y
        bpl _B55C
        stz $0778,b
        stz $077A,b

        _B5C9
        rts

        .databank 0

        ; 88/B5CA

      rlUnknown88B5CA ; 88/B5CA

        .al
        .xl
        .autsiz
        .databank ?

        lda $0784,b
        cmp #$FFFF
        beq _B5D4
        clc
        rts


        _B5D4
        lda #$0000
        sta $0784,b
        tax
        sec
        rts

        .databank 0

        ; 88/B5DD

      rlUnknown88B5DD ; 88/B5DD

        .al
        .xl
        .autsiz
        .databank ?

        lda $0784,b
        cmp #$FFFF
        bne _B5E7
        clc
        rts


        _B5E7
        txa
        cmp #$0000
        bne _B625
        lda #$0000
        jsl rlGetFactionSlotLocationID
        jsl rlGetLocationEventDataEntry
        jsl rlBuildDeadPlayerCharacterList
        jsr rlUnknown88B627
        bcc _B625
        jsl rlGetEventLocationEntryEffectiveXCoordinate
        sec
        sbc $078C,b
        sta $0778,b
        jsl rlGetEventLocationEntryEffectiveYCoordinate
        sec
        sbc $078E,b
        sta $077A,b
        lda #$0004
        sta wUnknown0007D8,b
        lda #$FFFF
        sta $0784,b
        sec
        rts


        _B625
        clc
        rts

        .databank 0

        ; 88/B627

      rlUnknown88B627 ; 88/B627

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$002E

        _B62B
        lda aDeadPlayerCharacterList,x
        cmp #$FFFF
        beq _B648
        phx
        tax
        lda aDeploymentTable,x
        plx
        bit #$0008
        bne _B648
        bit #$2000
        bne _B648
        plx
        sec
        rts


        _B648
        dec x
        dec x
        bpl _B62B
        plx
        clc
        rts

        .databank 0

        ; 88/B64F

    .endsection Unsorted88B51ASection


    .section Unsorted88B64FSection

      .al
      .xl

      rsUnknown88B64F ; 88/B64F

        .al
        .autsiz
        .databank ?

        lda $0778,b
        beq ++
        bpl +

          inc $0778,b
          lda #$0200
          bra _End
          
            +
            dec $0778,b
            lda #$0100
            bra _End

        +
        lda $077A,b
        beq _B681
        bpl +

          inc $077A,b
          lda #$0800
          bra _End

        +
        dec $077A,b
        lda #$0400
        bra _End
        
        _End
        sta wMapScrollDirectionIdentifier,b
        rts

        _B681
        lda wUnknown0007D8,b
        cmp #5
        beq _B6A6

          cmp #6
          beq _B6B6

            cmp #7
            beq _B6D4

              stz wUnknown00073A,b
              stz wMapScrollScriptOffset,b
              stz wUnknown0007D8,b
              lda #$0004
              trb $0788,b
              lda #0
              rts
        
        _B6A6
        stz wUnknown00073A,b
        stz wMapScrollScriptOffset,b
        stz wUnknown0007D8,b
        jsr rlUnknown88B701
        lda #0
        rts

        _B6B6
        stz wUnknown00073A,b
        stz wMapScrollScriptOffset,b
        lda #3
        sta wUnknown0007D8,b
        lda $0772,b
        sta $00
        lda $0774,b
        sta $02
        jsl rlUnknown8591B2
        lda #0
        rts

        _B6D4
        stz wUnknown00073A,b
        stz wMapScrollScriptOffset,b
        stz wUnknown0007D8,b
        lda $0D87,b
        bit #$0008
        bne +

          jsr rlUnknown88B701
          lda #0
          rts

        +
        ldx $0772,b
        jsl rlUnknown84D4A2
        lda #$0008
        tsb $0788,b
        lda #0
        rts

        .databank 0

        ; 88/B6FD

    .endsection Unsorted88B64FSection


    .section Unsorted88B6FDSection

      .al
      .xl

      rlUnknown88B6FD ; 88/B6FD

        .al
        .xl
        .autsiz
        .databank ?

        jsr rlUnknown88B701
        rtl

        .databank 0

        ; 88/B701

      rlUnknown88B701 ; 88/B701

        .al
        .xl
        .autsiz
        .databank ?

        lda wCursorXOffset,b
        clc
        adc wMapScrollXPixels,b
        sta wUnknown00076C,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR0
        sta $0778,b
        sta $077C,b
        lda wCursorYOffset,b
        clc
        adc wMapScrollYPixels,b
        sta wUnknown00076E,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR1
        sta $077A,b
        sta $077E,b
        ldx #$0000

        _B730
        lda aDeploymentTable,x
        beq _B799
        inc $078A,b
        lda aDeploymentTable,x
        bit #$0008
        bne _B799
        bit #$2000
        bne _B799
        bit #$0080
        beq _B799
        lda $7E441B,x
        cmp wR0
        bne _B799
        sta wR10
        lda $7E44AB,x
        cmp wR1
        bne _B799
        sta wR11
        inc wUnknown000770,b
        lda #$0002
        tsb $0788,b
        jsl rlUnknown85EA64
        lda #$0001
        sta $07DA,b
        stz $07DC,b
        stz $07DE,b
        stx $0772,b
        jsl rlDeployedUnitSetHidden
        stz wUnknown0007E2,b
        jsl rlUnknown88C9A6
        lda $7E46EB,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlUnknown87B541
        bcs _B7A9

        _B794
        jsr rlUnknown88B873
        bra _B7A4


        _B799
        inc x
        inc x
        lda $078A,b
        cmp @l wDeployedUnitsCount
        bcc _B730

        _B7A4
        stz $078A,b
        clc
        rts


        _B7A9
        lda bUnknown000E7B,b
        and #$00FF
        bit #$0041
        bne _B794
        ldx $0772,b
        lda $7E46EB,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitFactionSlot
        cmp wActiveFactionSlot,b
        bne _B794
        lda $0778,b
        sta wR0
        lda $077A,b
        sta wR1
        ldx $0772,b
        jsl rlUnknown84C94C
        lda #$0002
        trb $0788,b
        stz wUnknown000770,b
        lda #$0002
        sta $07DA,b
        stz wUnknown0007D8,b
        stz wMapScrollScriptOffset,b
        stz wUnknown00073A,b
        lda wCursorXOffset,b
        clc
        adc wMapScrollXPixels,b
        sta $0780,b
        lda wCursorYOffset,b
        clc
        adc wMapScrollYPixels,b
        sta $0782,b
        jsl rlUnknown85E85D
        lda #$0008
        tsb $0788,b
        stz $078A,b
        sec
        rts

        .databank 0

        ; 88/B813

      rlUnknown88B813 ; 88/B813

        .al
        .xl
        .autsiz
        .databank ?

        lda wCursorXOffset,b
        clc
        adc wMapScrollXPixels,b
        bit #$000F
        bne _B869
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR0
        lda wCursorYOffset,b
        clc
        adc wMapScrollYPixels,b
        bit #$000F
        bne _B869
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR1
        ldx #$0000

        _B83A
        lda aDeploymentTable,x
        beq _B85E
        inc $078A,b
        lda aDeploymentTable,x
        bit #$0080
        beq _B85E
        lda $7E441B,x
        cmp wR0
        bne _B85E
        lda $7E44AB,x
        cmp wR1
        bne _B85E
        bra _B86E


        _B85E
        inc x
        inc x
        lda $078A,b
        cmp @l wDeployedUnitsCount
        bcc _B83A

        _B869
        stz $078A,b
        clc
        rtl


        _B86E
        stz $078A,b
        sec
        rtl

        .databank 0

        ; 88/B873

      rlUnknown88B873 ; 88/B873

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$11
        sta bBufferTM
        lda #$04
        sta bBufferTS
        lda #$02
        sta bBufferCGWSEL
        lda #$41
        sta bBufferCGADSUB
        rep #$20
        jsr rlUnknown88B88B
        rts

        .databank 0

        ; 88/B88B

      rlUnknown88B88B ; 88/B88B

        .al
        .xl
        .autsiz
        .databank ?

        lda wCursorXOffset,b
        clc
        adc wMapScrollXPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta $078C,b
        lda wCursorYOffset,b
        clc
        adc wMapScrollYPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta $078E,b
        lda $078C,b
        sec
        sbc #$0020
        sta $071C,b
        clc
        adc #$0040
        sta $0720,b
        lda $078E,b
        sec
        sbc #$0020
        sta $071E,b
        clc
        adc #$0040
        sta $0722,b
        lda $071C,b
        bpl _B8D1
        stz $071C,b

        _B8D1
        lda $071E,b
        bpl _B8D9
        stz $071E,b

        _B8D9
        lda bUnknown000E7B,b
        and #$00FF
        bit #$0041
        bne _B8E8
        jsl rlUnknown8884A6

        _B8E8
        rts

        .databank 0

        ; 88/B8E9

      rlUnknown88B8E9 ; 88/B8E9

        .al
        .xl
        .autsiz
        .databank ?

        lda wCursorXOffset,b
        clc
        adc wMapScrollXPixels,b
        sta $0780,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta $078C,b
        sta wR0
        lda wCursorYOffset,b
        clc
        adc wMapScrollYPixels,b
        sta $0782,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta $078E,b
        sta wR1
        jsl rlUnknown88BF37
        tax
        lda aMapData,x
        and #$03FF
        tax
        lda aTerrainTileset,x
        and #$00FF
        lda $078E,b
        cmp $071E,b
        bcc _B95E
        cmp $0722,b
        bcs _B95E
        lda $078C,b
        cmp $071C,b
        bcc _B95E
        cmp $0720,b
        bcs _B95E
        jsr rlUnknown888D23
        lda aMovementMap,x
        bit #$0080
        bne _B95E
        and #$007F
        beq _B95E
        sta $0792,b
        jsr rlUnknown88B960
        bmi _B95E
        jsr rlUnknown88BBD3
        jsr rlUnknown88B992
        clc
        rts


        _B95E
        sec
        rts

        .databank 0

        ; 88/B960

      rlUnknown88B960 ; 88/B960

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$008E

        _B963
        cpx $0772,b
        beq _B98A
        lda aDeploymentTable,x
        beq _B98A
        bit #$0080
        beq _B98A
        lda $7E441B,x
        cmp $078C,b
        bne _B98A
        lda $7E44AB,x
        cmp $078E,b
        bne _B98A
        lda #$FFFF
        bra _B991


        _B98A
        dec x
        dec x
        bpl _B963
        lda #$0000

        _B991
        rts

        .databank 0

        ; 88/B992

      rlUnknown88B992 ; 88/B992

        .al
        .xl
        .autsiz
        .databank ?

        lda wVBlankEnabledFramecount
        and #$0001
        beq _B99D
        jml _BAB8


        _B99D
        ldx #$0040

        _B9A0
        stz $0794,b,x
        dec x
        dec x
        bpl _B9A0
        stz wMapScrollScriptOffset,b
        lda $078C,b
        sta wR4
        lda $078E,b
        sta wR5
        ldy #$0000

        _B9B7
        lda wR4
        sta wR2
        lda wR5
        sta wR3
        lda wR2
        sta $078C,b
        lda wR3
        sec
        sbc #$0001
        sta $078E,b
        jsr rlUnknown888D23
        lda aMovementMap,x
        and #$007F
        cmp $0792,b
        bcc _B9F4
        beq _B9F4
        sta $0792,b
        lda #$0001
        sta $0794,b,y
        inc wMapScrollScriptOffset,b
        lda $078C,b
        sta wR4
        lda $078E,b
        sta wR5

        _B9F4
        lda wR2
        sta $078C,b
        lda wR3
        clc
        adc #$0001
        sta $078E,b
        jsr rlUnknown888D23
        lda aMovementMap,x
        and #$007F
        cmp $0792,b
        bcc _BA29
        beq _BA29
        sta $0792,b
        lda #$0002
        sta $0794,b,y
        inc wMapScrollScriptOffset,b
        lda $078C,b
        sta wR4
        lda $078E,b
        sta wR5

        _BA29
        lda wR2
        sec
        sbc #$0001
        sta $078C,b
        lda wR3
        sta $078E,b
        jsr rlUnknown888D23
        lda aMovementMap,x
        and #$007F
        cmp $0792,b
        bcc _BA5E
        beq _BA5E
        sta $0792,b
        lda #$0003
        sta $0794,b,y
        inc wMapScrollScriptOffset,b
        lda $078C,b
        sta wR4
        lda $078E,b
        sta wR5

        _BA5E
        lda wR2
        clc
        adc #$0001
        sta $078C,b
        lda wR3
        sta $078E,b
        jsr rlUnknown888D23
        lda aMovementMap,x
        and #$007F
        cmp $0792,b
        bcc _BA9C
        beq _BA9C
        sta $0792,b
        lda #$0004
        sta $0794,b,y
        inc wMapScrollScriptOffset,b
        lda $078C,b
        sta wR4
        lda $078E,b
        sta wR5

        _BA93
        inc y
        inc y
        stz wMapScrollScriptOffset,b
        jml _B9B7


        _BA9C
        lda wMapScrollScriptOffset,b
        bne _BA93
        sty $07D6,b
        stz wMapScrollScriptOffset,b
        sty wMapScrollScriptOffset,b
        lda $0772,b
        jsl rlUnknown88B4DB
        lda #$0001
        sta wUnknown0007D8,b
        rts


        _BAB8
        ldx #$0040

        _BABB
        stz $0794,b,x
        dec x
        dec x
        bpl _BABB
        stz wMapScrollScriptOffset,b
        lda $078C,b
        sta wR4
        lda $078E,b
        sta wR5
        ldy #$0000

        _BAD2
        lda wR4
        sta wR2
        lda wR5
        sta wR3
        lda wR2
        sec
        sbc #$0001
        sta $078C,b
        lda wR3
        sta $078E,b
        jsr rlUnknown888D23
        lda aMovementMap,x
        and #$007F
        cmp $0792,b
        bcc _BB0F
        beq _BB0F
        sta $0792,b
        lda #$0003
        sta $0794,b,y
        inc wMapScrollScriptOffset,b
        lda $078C,b
        sta wR4
        lda $078E,b
        sta wR5

        _BB0F
        lda wR2
        clc
        adc #$0001
        sta $078C,b
        lda wR3
        sta $078E,b
        jsr rlUnknown888D23
        lda aMovementMap,x
        and #$007F
        cmp $0792,b
        bcc _BB44
        beq _BB44
        sta $0792,b
        lda #$0004
        sta $0794,b,y
        inc wMapScrollScriptOffset,b
        lda $078C,b
        sta wR4
        lda $078E,b
        sta wR5

        _BB44
        lda wR2
        sta $078C,b
        lda wR3
        sec
        sbc #$0001
        sta $078E,b
        jsr rlUnknown888D23
        lda aMovementMap,x
        and #$007F
        cmp $0792,b
        bcc _BB79
        beq _BB79
        sta $0792,b
        lda #$0001
        sta $0794,b,y
        inc wMapScrollScriptOffset,b
        lda $078C,b
        sta wR4
        lda $078E,b
        sta wR5

        _BB79
        lda wR2
        sta $078C,b
        lda wR3
        clc
        adc #$0001
        sta $078E,b
        jsr rlUnknown888D23
        lda aMovementMap,x
        and #$007F
        cmp $0792,b
        bcc _BBB7
        beq _BBB7
        sta $0792,b
        lda #$0002
        sta $0794,b,y
        inc wMapScrollScriptOffset,b
        lda $078C,b
        sta wR4
        lda $078E,b
        sta wR5

        _BBAE
        inc y
        inc y
        stz wMapScrollScriptOffset,b
        jml _BAD2


        _BBB7
        lda wMapScrollScriptOffset,b
        bne _BBAE
        sty $07D6,b
        stz wMapScrollScriptOffset,b
        sty wMapScrollScriptOffset,b
        lda $0772,b
        jsl rlUnknown88B4DB
        lda #$0001
        sta wUnknown0007D8,b
        rts

        .databank 0

        ; 88/BBD3

      rlUnknown88BBD3 ; 88/BBD3

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$15
        sta bBufferTM
        lda #$00
        sta bBufferTS
        lda #$00
        sta bBufferCGWSEL
        lda #$00
        sta bBufferCGADSUB
        rep #$20
        stz wBufferBG3HOFS
        stz wBufferBG3VOFS
        ldx #$07FE
        lda #$00FF

        _BBF1
        sta aBG3TilemapBuffer,x
        dec x
        dec x
        bpl _BBF1
        jsl rlUnknown878459
        jsl rlUnknown88A4FC
        stz wUnknown000770,b
        rts

        .databank 0

        ; 88/BC05

    .endsection Unsorted88B6FDSection


    .section Unsorted88BC05Section

      .al
      .xl

      rlUnknown88BC05 ; 88/BC05

        .al
        .autsiz
        .databank ?

        lda #$0001
        trb $0764,b

        lda wMapScrollDirectionIdentifier,b
        cmp #$0200
        beq _0200

        cmp #$0100
        beq _0100

        cmp #$0800
        beq _0800

        cmp #$0400
        beq _0400

        cmp #$0A00
        beq _0A00

        cmp #$0600
        beq _0600

        cmp #$0900
        beq _0900

        cmp #$0500
        beq _0500

        rtl

        _0200
        jsr rsUnknown88BC63
        rtl
        
        _0100
        jsr rsUnknown88BD09
        rtl
        
        _0800
        jsr rlUnknown88BDA1
        rtl
        
        _0400
        jsr rlUnknown88BE57
        rtl
        
        _0A00
        jsr rsUnknown88BC63
        jsr rlUnknown88BDA1
        rtl
        
        _0600
        jsr rsUnknown88BC63
        jsr rlUnknown88BE57
        rtl
        
        _0900
        jsr rsUnknown88BD09
        jsr rlUnknown88BDA1
        rtl
        
        _0500
        jsr rsUnknown88BD09
        jsr rlUnknown88BE57
        rtl

        .databank 0

      rsUnknown88BC63 ; 88/BC63

        .al
        .autsiz
        .databank ?

        lda wMapScrollXPixels,b
        cmp wMapMinXScroll,b
        beq +

        lda wCursorXOffset,b
        sec
        sbc wMapScrollSpeed,b
        cmp #$0030
        bcc ++

        sta wCursorXOffset,b
        lda #$0001
        tsb $0764,b
        rts
        
        +
        lda wCursorXOffset,b
        sec
        sbc wMapScrollSpeed,b
        cmp #$0010
        bcc _BCF4

        sta wCursorXOffset,b
        lda #$0001
        tsb $0764,b
        rts
        
        +
        lda wMapScrollXPixels,b
        sec
        sbc wMapScrollSpeed,b
        sec
        sbc #1
        cmp wMapMinXScroll,b
        bmi +
        bcs ++
        
        +
        clc
        adc #1
        sta $00

        lda wMapMinXScroll,b
        sec
        sbc $00
        sta $00

        lda wCursorXOffset,b
        sec
        sbc #$0030
        clc
        adc wMapScrollCurrentPixelDistance,b
        sta wMapScrollCurrentPixelDistance,b

        lda #$0030
        sec
        sbc $00
        sta wCursorXOffset,b
        bra ++
        
        +
        lda wCursorXOffset,b
        sec
        sbc #$0030
        clc
        adc wMapScrollCurrentPixelDistance,b
        sta wMapScrollCurrentPixelDistance,b

        lda #$0030
        sta wCursorXOffset,b
        
        +
        lda #1
        sta wUnknown00073A,b
        sta wMapEnableXScrollFlag,b
        lda #$0001
        tsb $0764,b
        rts

        _BCF4
        lda wCursorXOffset,b
        sec
        sbc #$0010
        clc
        adc wMapScrollCurrentPixelDistance,b
        sta wMapScrollCurrentPixelDistance,b
        lda #$0010
        sta wCursorXOffset,b
        rts

        .databank 0

      rsUnknown88BD09 ; 88/BD09

        .al
        .autsiz
        .databank ?

        lda wMapScrollXPixels,b
        cmp wMapMaxXScroll,b
        bcs +

          lda wCursorXOffset,b
          clc
          adc wMapScrollSpeed,b
          cmp #$00C1
          bcs ++

            sta wCursorXOffset,b
            lda #$0001
            tsb $0764,b
            rts

        +
        lda wCursorXOffset,b
        clc
        adc wMapScrollSpeed,b
        cmp #$00E1
        bcs _BD8C

          sta wCursorXOffset,b
          lda #$0001
          tsb $0764,b
          rts

        +
        lda wMapScrollXPixels,b
        clc
        adc wMapScrollSpeed,b
        cmp wMapMaxXScroll,b
        bcc +

          sec
          sbc wMapMaxXScroll,b
          sta $00
          lda #$00C0
          sec
          sbc wCursorXOffset,b
          clc
          adc wMapScrollCurrentPixelDistance,b
          sta wMapScrollCurrentPixelDistance,b

          lda $00
          clc
          adc #$00C0
          sta wCursorXOffset,b
          bra ++
        
        +
        lda #$00C0
        sec
        sbc wCursorXOffset,b
        clc
        adc wMapScrollCurrentPixelDistance,b
        sta wMapScrollCurrentPixelDistance,b
        lda #$00C0
        sta wCursorXOffset,b
        
        +
        lda #1
        sta wUnknown00073A,b
        sta wMapEnableXScrollFlag,b
        lda #$0001
        tsb $0764,b
        rts

        _BD8C
        lda #$00E0
        sec
        sbc wCursorXOffset,b
        clc
        adc wMapScrollCurrentPixelDistance,b
        sta wMapScrollCurrentPixelDistance,b
        lda #$00E0
        sta wCursorXOffset,b
        rts

        .databank 0

        ; 88/BDA1

    .endsection Unsorted88BC05Section


    .section Unsorted88BDA1Section

      .al
      .xl

      rlUnknown88BDA1 ; 88/BDA1

        .al
        .xl
        .autsiz
        .databank ?

        lda wMapScrollYPixels,b
        cmp wMapMinYScroll,b
        beq _BDBF
        lda wCursorYOffset,b
        sec
        sbc wMapScrollSpeed,b
        cmp #$0030
        bcc _BDE5
        sta wCursorYOffset,b
        lda #$0001
        tsb $0764,b
        rts


        _BDBF
        lda wCursorYOffset,b
        sec
        sbc wMapScrollSpeed,b
        cmp #$0010
        bcc _BE42
        sta wCursorYOffset,b
        lda #$0001
        tsb $0764,b
        rts

        .byte $A9, $01, $00, $8D, $3A, $07, $8D, $3E, $07, $A9, $01, $00, $0C, $64, $07, $60


        _BDE5
        lda wMapScrollYPixels,b
        sec
        sbc wMapScrollSpeed,b
        sec
        sbc #$0001
        cmp wMapMinYScroll,b
        bmi _BDF7
        bcs _BE1E

        _BDF7
        clc
        adc #$0001
        sta wR0
        lda wMapMinYScroll,b
        sec
        sbc wR0
        sta wR0
        lda wCursorYOffset,b
        sec
        sbc #$0030
        clc
        adc wMapScrollCurrentPixelDistance,b
        sta wMapScrollCurrentPixelDistance,b
        lda #$0030
        sec
        sbc wR0
        sta wCursorYOffset,b
        bra _BE32


        _BE1E
        lda wCursorYOffset,b
        sec
        sbc #$0030
        clc
        adc wMapScrollCurrentPixelDistance,b
        sta wMapScrollCurrentPixelDistance,b
        lda #$0030
        sta wCursorYOffset,b

        _BE32
        lda #$0001
        sta wUnknown00073A,b
        sta wMapEnableYScrollFlag,b
        lda #$0001
        tsb $0764,b
        rts


        _BE42
        lda wCursorYOffset,b
        sec
        sbc #$0010
        clc
        adc wMapScrollCurrentPixelDistance,b
        sta wMapScrollCurrentPixelDistance,b
        lda #$0010
        sta wCursorYOffset,b
        rts

        .databank 0

        ; 88/BE57

      rlUnknown88BE57 ; 88/BE57

        .al
        .xl
        .autsiz
        .databank ?

        lda wMapScrollYPixels,b
        cmp wMapMaxYScroll,b
        bcs _BE75
        lda wCursorYOffset,b
        clc
        adc wMapScrollSpeed,b
        cmp #$00A1
        bcs _BE8B
        sta wCursorYOffset,b
        lda #$0001
        tsb $0764,b
        rts


        _BE75
        lda wCursorYOffset,b
        clc
        adc wMapScrollSpeed,b
        cmp #$00C1
        bcs _BEDA
        sta wCursorYOffset,b
        lda #$0001
        tsb $0764,b
        rts


        _BE8B
        lda wMapScrollYPixels,b
        clc
        adc wMapScrollSpeed,b
        cmp wMapMaxYScroll,b
        bcc _BEB6
        sec
        sbc wMapMaxYScroll,b
        sta wR0
        lda #$00A0
        sec
        sbc wCursorYOffset,b
        clc
        adc wMapScrollCurrentPixelDistance,b
        sta wMapScrollCurrentPixelDistance,b
        lda wR0
        clc
        adc #$00A0
        sta wCursorYOffset,b
        bra _BECA


        _BEB6
        lda #$00A0
        sec
        sbc wCursorYOffset,b
        clc
        adc wMapScrollCurrentPixelDistance,b
        sta wMapScrollCurrentPixelDistance,b
        lda #$00A0
        sta wCursorYOffset,b

        _BECA
        lda #$0001
        sta wUnknown00073A,b
        sta wMapEnableYScrollFlag,b
        lda #$0001
        tsb $0764,b
        rts


        _BEDA
        lda #$00C0
        sec
        sbc wCursorYOffset,b
        clc
        adc wMapScrollCurrentPixelDistance,b
        sta wMapScrollCurrentPixelDistance,b
        lda #$00C0
        sta wCursorYOffset,b
        rts

        .databank 0

        ; 88/BEEF

      rlUnknown88BEEF ; 88/BEEF

        .al
        .xl
        .autsiz
        .databank ?

        lda $0764,b
        bit #$0001
        beq _BEFE
        lda #$0005
        jsl rlUnknown808FAD

        _BEFE
        rts

        .databank 0

        ; 88/BEFF

    .endsection Unsorted88BDA1Section


    .section Unsorted88BF37Section

      .al
      .xl

      rlUnknown88BF37 ; 88/BF37

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $88
        lda wUnknown00075C,b
        cmp #$0004
        beq _BF56
        cmp #$0008
        beq _BF48

        _BF48
        lda wR1
        asl a
        asl a
        asl a
        asl a
        asl a
        asl a
        asl a
        asl a
        sta wR3
        bra _BF63


        _BF56
        lda wR1
        asl a
        asl a
        asl a
        asl a
        asl a
        asl a
        asl a
        sta wR3
        bra _BF63


        _BF63
        lda wR0
        asl a
        clc
        adc wR3
        plp
        plb
        .databank $88
        rtl

        .databank 0

        ; 88/BF6C

    .endsection Unsorted88BF37Section


    .section Unsorted88BF97Section

      .al
      .xl

      rlUnknown88BF97 ; 88/BF97

        .al
        .xl
        .autsiz
        .databank ?

        lda wCursorXOffset,b
        sec
        sbc wMapScrollXPixels,b
        sta wR10
        cmp #$00C8
        bcs _BFC1
        sec
        sbc #$0030
        bmi _BFC1
        lda wCursorYOffset,b
        sec
        sbc wMapScrollYPixels,b
        sta wR11
        cmp #$00A8
        bcs _BFC1
        sec
        sbc #$0028
        bmi _BFC1
        clc
        rtl


        _BFC1
        sec
        rtl

        .databank 0

        ; 88/BFC3

      rlUnknown88BFC3 ; 88/BFC3

        .al
        .xl
        .autsiz
        .databank ?

        lda wR10
        asl a
        asl a
        asl a
        asl a
        sec
        sbc wMapScrollXPixels,b
        sta wR10
        cmp #$00C8
        bcs _BFF2
        sec
        sbc #$0030
        bmi _BFF2
        lda wR11
        asl a
        asl a
        asl a
        asl a
        sec
        sbc wMapScrollYPixels,b
        sta wR11
        cmp #$00A8
        bcs _BFF2
        sec
        sbc #$0028
        bmi _BFF2
        rtl


        _BFF2
        lda #$FFFF
        sta wR10
        sta wR11
        rtl

        .databank 0

        ; 88/BFFA

    .endsection Unsorted88BF97Section


    .section Unsorted88C059Section

      .al
      .xl

      rlUnknown88C059 ; 88/C059

        .al
        .xl
        .autsiz
        .databank ?

        lda wR10
        clc
        adc wMapScrollXPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR10
        lda wR11
        clc
        adc wMapScrollYPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR11
        rtl

        .databank 0

        ; 88/C072

    .endsection Unsorted88C059Section


    .section Unsorted88C085Section

      .al
      .xl

      rlUnknown88C085 ; 88/C085

        .al
        .xl
        .autsiz
        .databank ?

        ldx $0772,b
        lda $7E465B,x
        tax
        lda $7E480B,x
        jsl rlGetMapSpriteMovementSound
        sep #$20
        sta $04CA,b
        stz $04D0,b
        lda wCursorXOffset,b
        sta $04CB,b
        rep #$20
        jsl rlUnknown88C0D5
        sep #$20
        lda wR0
        sta $04CC,b
        rep #$20
        rtl

        .databank 0

        ; 88/C0B3

      rlUnknown88C0B3 ; 88/C0B3

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown88C0D5
        sep #$20
        lda wCursorXOffset,b
        sta $04CB,b
        lda wR0
        sta $04CC,b
        rep #$20
        ldx #$0000
        jsl rlUnknown809933
        ldx #$0003
        jsl rlUnknown809933
        rtl

        .databank 0

        ; 88/C0D5

      rlUnknown88C0D5 ; 88/C0D5

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlGetClassWeakness
        bit #$0002
        bne _C11B
        lda wCursorXOffset,b
        clc
        adc wMapScrollXPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR0
        lda wCursorYOffset,b
        clc
        adc wMapScrollYPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR1
        jsl rlUnknown88BF37
        tax
        lda aMapData,x
        and #$03FF
        tax
        lda aTerrainTileset,x
        and #$00FF
        cmp #$0005
        beq _C120
        cmp #$0006
        beq _C120
        cmp #$0010
        beq _C120

        _C11B
        lda #$0000
        bra _C123


        _C120
        lda #$0020

        _C123
        sta wR0
        rtl

        .databank 0

        ; 88/C126

      rlUnknown88C126 ; 88/C126

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$10
        sta $04CA,b
        rep #$20
        ldx #$0000
        jsl rlUnknown809933
        ldx #$0003
        jsl rlUnknown809933
        rtl

        .databank 0

        ; 88/C13E

    .endsection Unsorted88C085Section


    .section Unsorted88C1BFSection

      .al
      .xl

      rlUnknown88C1BF ; 88/C1BF

        .al
        .xl
        .autsiz
        .databank ?

        lda wJoy1Input
        cmp #$0030
        bne _C1D0
        lda #$0000
        jsl rlGetFactionSlotLocationID
        sta $087B,b

        _C1D0
        lda $087B,b
        jsl rlGetLocationEventDataEntry
        bcs _C247
        jsl rlGetEventLocationEntryType
        cmp #$0000
        bne _C24E
        jsl rlGetEventLocationEntryEffectiveXCoordinate
        asl a
        asl a
        asl a
        asl a
        sta $078C,b
        sec
        sbc #$0080
        bpl _C1F8
        lda #$0000
        bra _C200


        _C1F8
        cmp wMapMaxXScroll,b
        bcc _C200
        lda wMapMaxXScroll,b

        _C200
        sta wMapScrollXPixels,b
        jsl rlGetEventLocationEntryEffectiveYCoordinate
        asl a
        asl a
        asl a
        asl a
        sta $078E,b
        sec
        sbc #$0080
        bpl _C219
        lda #$0000
        bra _C221


        _C219
        cmp wMapMaxYScroll,b
        bcc _C221
        lda wMapMaxYScroll,b

        _C221
        sta wMapScrollYPixels,b
        lda $078C,b
        sec
        sbc wMapScrollXPixels,b
        sta wCursorXOffset,b
        lda $078E,b
        sec
        sbc wMapScrollYPixels,b
        sta wCursorYOffset,b
        jsl rlUnknown888410
        inc $087B,b
        lda #$8000
        tsb $0788,b
        bra _C255


        _C247
        stz $087B,b
        jml _C1D0


        _C24E
        inc $087B,b
        jml _C1D0


        _C255
        lda #$0026
        jsl rlUnknown80900D
        rts

        .databank 0

        ; 88/C25D

    .endsection Unsorted88C1BFSection


    .section Unsorted88C3F0Section

      .al
      .xl

      rlUnknown88C3F0 ; 88/C3F0

        .al
        .xl
        .autsiz
        .databank ?

        lda wMapXOffset,b
        sta wMapScrollXPixels,b
        lda wMapYOffset,b
        sta wMapScrollYPixels,b
        lda wCursorXOffset,b
        sta wR10
        lda wCursorYOffset,b
        sta wR11
        jsl rlUnknown88C059
        jsl rlUnknown88BFC3
        lda wR10
        cmp #$FFFF
        beq _C417
        clc
        rtl


        _C417
        lda wCursorXOffset,b
        clc
        adc wMapScrollXPixels,b
        sta $078C,b
        sec
        sbc #$0080
        bpl _C42C
        lda #$0000
        bra _C434


        _C42C
        cmp wMapMaxXScroll,b
        bcc _C434
        lda wMapMaxXScroll,b

        _C434
        sta wMapScrollXPixels,b
        sta wMapXOffset,b
        lda wCursorYOffset,b
        clc
        adc wMapScrollYPixels,b
        sta $078E,b
        sec
        sbc #$0080
        bpl _C44F
        lda #$0000
        bra _C457


        _C44F
        cmp wMapMaxYScroll,b
        bcc _C457
        lda wMapMaxYScroll,b

        _C457
        sta wMapScrollYPixels,b
        sta wMapYOffset,b
        lda $078C,b
        sec
        sbc wMapScrollXPixels,b
        sta wCursorXOffset,b
        lda $078E,b
        sec
        sbc wMapScrollYPixels,b
        sta wCursorYOffset,b
        sec
        rtl

        .databank 0

        ; 88/C473

      rlUnknown88C473 ; 88/C473

        .al
        .xl
        .autsiz
        .databank ?

        lda wR0
        asl a
        asl a
        asl a
        asl a
        sta $078C,b
        lda wR1
        asl a
        asl a
        asl a
        asl a
        sta $078E,b
        lda $078C,b
        sec
        sbc #$0080
        bpl _C493
        lda #$0000
        bra _C49B


        _C493
        cmp wMapMaxXScroll,b
        bcc _C49B
        lda wMapMaxXScroll,b

        _C49B
        sta wR0
        lda $078E,b
        sec
        sbc #$0080
        bpl _C4AB
        lda #$0000
        bra _C4B3


        _C4AB
        cmp wMapMaxYScroll,b
        bcc _C4B3
        lda wMapMaxYScroll,b

        _C4B3
        sta wR1
        lda $078C,b
        sec
        sbc wR0
        sta wCursorXOffset,b
        lda $078E,b
        sec
        sbc wR1
        sta wCursorYOffset,b
        lda wR0
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR0
        lda wR1
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR1
        sec
        rtl

        .databank 0

        ; 88/C4D9

    .endsection Unsorted88C3F0Section


    .section Unsorted88C4D9Section

      .al
      .xl

      rlUnknown88C4D9 ; 88/C4D9

        .al
        .xl
        .autsiz
        .databank ?

        ; Reached with jml from rlUnknown88A136. Steps through states 0-4 in
        ; wUnknown0007D8 and sets up the map scroll distance and speed, then
        ; draws a sprite at the cursor. What the states mean is not known yet.

        lda wUnknown000766,b
        beq _C4E2
        jml _C61E


        _C4E2
        lda wUnknown0007D8,b
        beq _C4FF
        cmp #$0001
        beq _C507
        cmp #$0002
        beq _C53B
        cmp #$0003
        beq _C503
        cmp #$0004
        bne _C4FF
        jml _C5D2


        _C4FF
        jml _C658


        _C503
        jml _C5AA


        _C507
        lda #$0010
        sta wMapPixelScrollDistance,b
        jsr rsUnknown88B64F
        beq _C51C
        lda #$0008
        sta wMapScrollSpeed,b
        jml _C60C


        _C51C
        lda bUnknown000E7B,b
        and #$00FF
        bit #$0002
        bne _C52E
        jsr rlUnknown88C67D
        jml _C658


        _C52E
        lda #$0000
        sta wUnknown0007D8,b
        sta $086F,b
        jml _C658


        _C53B
        jsl rlUnknown88C0B3
        stz wMapPixelScrollDistance,b
        jsr rlUnknown88AA1E
        beq _C564
        jsl rlUnknown87BF1B
        cmp #$0000
        bne _C55A
        lda #$0002
        sta wMapScrollSpeed,b
        jml _C60C


        _C55A
        lda #$0004
        sta wMapScrollSpeed,b
        jml _C60C


        _C564
        lda $0873,b
        cmp #$FFFF
        beq _C592
        jsl rlUnknown88B4DB
        lda #$0003
        sta wUnknown0007D8,b
        lda wCursorXOffset,b
        clc
        adc wMapScrollXPixels,b
        sta wUnknown00076C,b
        lda wCursorYOffset,b
        clc
        adc wMapScrollYPixels,b
        sta wUnknown00076E,b
        lda #$0001
        sta $07DA,b
        bra _C5AA


        _C592
        lda #$0000
        sta wUnknown0007D8,b
        sta $086F,b
        jsl rlUnknown88AF7B
        lda $0879,b
        jsl rlUnknown86B307
        jml _C658


        _C5AA
        lda #$0010
        sta wMapPixelScrollDistance,b
        jsr rsUnknown88B64F
        beq _C5C2
        lda #$0004
        lda #$0008
        sta wMapScrollSpeed,b
        jml _C60C


        _C5C2
        lda #$0018
        sta wMapScrollScriptOffset,b
        lda #$0004
        sta wUnknown0007D8,b
        jml _C658


        _C5D2
        lda wMapScrollScriptOffset,b
        sec
        sbc #$0001
        sta wMapScrollScriptOffset,b
        bmi _C5E0
        bra _C659


        _C5E0
        lda #$0000
        sta wUnknown0007D8,b
        sta $086F,b
        jsl rlUnknown88AF7B
        lda wMapScrollXPixels,b
        sta wMapXOffset,b
        lda wMapScrollYPixels,b
        sta wMapYOffset,b
        lda $0871,b
        sta wR0
        lda $0873,b
        sta wR1
        lda $0879,b
        jsl rlUnknown86B307
        bra _C659


        _C60C
        stz wMapScrollCurrentPixelDistance,b
        lda #$0001
        sta wUnknown000766,b
        stz wUnknown00073A,b
        stz wMapEnableXScrollFlag,b
        stz wMapEnableYScrollFlag,b

        _C61E
        lda wMapScrollCurrentPixelDistance,b
        clc
        adc wMapScrollSpeed,b
        sta wMapScrollCurrentPixelDistance,b
        cmp wMapPixelScrollDistance,b
        bcc _C648
        sec
        sbc wMapPixelScrollDistance,b
        sta wR0
        lda wMapScrollSpeed,b
        sec
        sbc wR0
        sta wMapScrollSpeed,b
        stz wUnknown000766,b
        stz wUnknown00073A,b
        stz wMapEnableXScrollFlag,b
        stz wMapEnableYScrollFlag,b

        _C648
        jsl rlUnknown88BC05
        lda wUnknown0007D8,b
        cmp #$0002
        bne _C658
        jsl rlUnknown88C0B3

        _C658
        rtl


        _C659
        sep #$20
        lda #$88
        pha
        plb
        .databank $88
        rep #$20
        ldy #$EE52
        lda wCursorXOffset,b
        sta wR0
        lda wCursorYOffset,b
        sta wR1
        lda #$0006
        sta wR4
        lda #$2000
        sta wR5
        jsl rlPushToOAMBuffer
        rtl

        .databank 0

        ; 88/C67D

    .endsection Unsorted88C4D9Section


    .section Unsorted88C67DSection

      .al
      .xl

      rlUnknown88C67D ; 88/C67D

        ; TRACE: odd-opcode
        .al
        .xl
        .autsiz
        .databank ?

        jsr rlUnknown88C733
        lda wMapScrollXPixels,b
        sta wUnknown000734,b
        lda wMapScrollYPixels,b
        sta wUnknown000736,b
        lda wCursorXOffset,b
        sta wUnknown00076C,b
        lda wCursorYOffset,b
        sta wUnknown00076E,b
        lda #$0000
        sta wCursorXOffset,b
        lda $0875,b
        sta wMapScrollXPixels,b
        lda #$0000
        sta wCursorYOffset,b
        lda $0877,b
        sta wMapScrollYPixels,b
        jsr rlUnknown88B8E9
        bcc _C6B6
        .byte $00 ; brk

        _C6B6
        lda wUnknown000734,b
        sta wMapScrollXPixels,b
        lda wUnknown000736,b
        sta wMapScrollYPixels,b
        lda wUnknown00076C,b
        sta wCursorXOffset,b
        lda wUnknown00076E,b
        sta wCursorYOffset,b
        lda #$0002
        sta wUnknown0007D8,b
        lda #$FFFF
        sta wMapScrollDirectionIdentifier,b
        jsl rlUnknown88C085
        lda $07D6,b
        dec a
        dec a
        sta wMapScrollScriptOffset,b
        lda #$0002
        sta $07DA,b
        rts

        .databank 0

        ; 88/C6ED

    .endsection Unsorted88C67DSection


    .section Unsorted88C71CSection

      .al
      .xl

      rlUnknown88C71C ; 88/C71C

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0001
        sta $086F,b
        lda $0871,b
        sta $0772,b
        jsl rlUnknown88B4DB
        lda #$0001
        sta wUnknown0007D8,b
        rts

        .databank 0

        ; 88/C733

      rlUnknown88C733 ; 88/C733

        .al
        .xl
        .autsiz
        .databank ?

        lda wCursorXOffset,b
        clc
        adc wMapScrollXPixels,b
        sta wUnknown00076C,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR0
        sta $0778,b
        sta $077C,b
        lda wCursorYOffset,b
        clc
        adc wMapScrollYPixels,b
        sta wUnknown00076E,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR1
        sta $077A,b
        sta $077E,b
        ldx $0871,b

        _C762
        lda aDeploymentTable,x
        beq _C7BF
        inc $078A,b
        lda aDeploymentTable,x
        bit #$0080
        beq _C7BF
        lda $7E441B,x
        cmp wR0
        bne _C7BF
        sta wR10
        lda $7E44AB,x
        cmp wR1
        bne _C7BF
        sta wR11
        inc wUnknown000770,b
        lda #$0002
        tsb $0788,b
        jsl rlUnknown85EA64
        lda #$0001
        sta $07DA,b
        stz $07DC,b
        stz $07DE,b
        stx $0772,b
        jsl rlDeployedUnitSetHidden
        stz wUnknown0007E2,b
        jsl rlUnknown88C9A6
        lda $7E46EB,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlUnknown87B541
        jsr rlUnknown88B873
        bra _C7CA


        _C7BF
        inc x
        inc x
        lda $078A,b
        cmp @l wDeployedUnitsCount
        bcc _C762

        _C7CA
        stz $078A,b
        clc
        rts

        .databank 0

        ; 88/C7CF

    .endsection Unsorted88C71CSection


    .section Unsorted88C9A6Section

      .al
      .xl

      rlUnknown88C9A6 ; 88/C9A6

        .al
        .autsiz
        .databank ?

        phx
        phk
        plb

        lda #$FFFF
        sta $0865,b

        ldx $0772,b
        lda aDeploymentTable._DeploymentOffsets,x
        tax
        lda aDeploymentTable._MapSpriteID,x
        and #$8000
        bne _Tall

          ldx $0772,b
          lda aDeploymentTable._DeploymentOffsets,x
          tax
          lda aDeploymentTable._MapSpriteID,x
          and #~$8000
          sta wR0
          clc
          adc wR0
          clc
          adc wR0
          tax
          lda aMapMovementShortSpritePointers,x
          sta lR45
          lda aMapMovementShortSpritePointers+1,x
          sta lR45+1
          lda #(`$7EAB88)<<8
          sta lR47+1
          lda #<>$7EAB88
          sta lR47
          jsl rlDecompressSingle

          plx
          rtl
        
        _Tall
        ldx $0772,b
        lda aDeploymentTable._DeploymentOffsets,x
        tax
        lda aDeploymentTable._MapSpriteID,x
        and #~$8000
        sta wR0
        clc
        adc wR0
        clc
        adc wR0
        tax
        lda aMapMovementTallSpritePointers,x
        sta lR45
        lda aMapMovementTallSpritePointers+1,x
        sta lR45+1
        lda #(`$7EAB88)<<8
        sta lR47+1
        lda #<>$7EAB88
        sta lR47
        jsl rlDecompressSingle

        plx
        rtl

        .databank 0

        ; 88/CA28

    .endsection Unsorted88C9A6Section


    .section Unsorted88CBE8Section

      .al
      .xl

      aUnknown88CBE8 ; 88/CBE8

        ; Indexed by map sprite ID (without the tall flag $8000).
        ; 65 bytes of 9 and then 32 bytes of 14: the same counts as the
        ; short and tall map sprite tables.

        .fill 65, 9
        .fill 32, 14

        ; 88/CC49

    .endsection Unsorted88CBE8Section


    .section Unsorted88CC75Section

      .al
      .xl

      rlUnknown88CC75 ; 88/CC75

        .al
        .xl
        .autsiz
        .databank ?

        lda $07E4,b
        and #$000F
        cmp #$0002
        bcc _CC97
        cmp #$0008
        beq _CC97
        cmp #$0009
        beq _CC97
        cmp #$000A
        bcc _CC93
        jsr rlUnknown88CE81
        rtl


        _CC93
        jsr rlUnknown88CC98
        rtl


        _CC97
        rtl

        .databank 0

        ; 88/CC98

      rlUnknown88CC98 ; 88/CC98

        .al
        .xl
        .autsiz
        .databank ?

        lda $07E4,b
        clc
        adc #$0002
        and #$000F
        asl a
        xba
        sta $078E,b
        lda $07E4,b
        and #$000F
        sec
        sbc #$0002
        asl a
        asl a
        asl a
        asl a
        sta $078C,b
        lda $07E4,b
        and #$0030
        cmp #$0000
        beq _CCD2
        cmp #$0010
        beq _CCD7
        cmp #$0020
        beq _CCDC
        cmp #$0030
        beq _CCE1

        _CCD2
        lda #$0000
        bra _CCE6


        _CCD7
        lda #$0080
        bra _CCE6


        _CCDC
        lda #$0100
        bra _CCE6


        _CCE1
        lda #$0080
        bra _CCE6


        _CCE6
        sta $07E6,b
        sta $0790,b
        ldx $078C,b
        ldy #$0000

        _CCF2
        lda $7E480B,x
        and #$7FFF
        sta wR0
        clc
        adc wR0
        clc
        adc wR0
        phx
        tax
        lda $88D527,x
        sta $07EE,b,y
        sta $07F1,b,y
        lda $88D526,x
        plx
        sta $07EA,b
        clc
        adc $07E6,b
        sta $07ED,b,y
        clc
        adc #$0040
        sta $07F0,b,y
        lda #$6000
        clc
        adc $078E,b
        sta $081D,b,y
        clc
        adc #$0100
        sta $0820,b,y
        lda $078E,b
        clc
        adc #$0020
        sta $078E,b
        inc x
        inc x
        tya
        clc
        adc #$0006
        tay
        cpy #$0030
        bcc _CCF2
        rts

        .databank 0

        ; 88/CD4C

      rlUnknown88CD4C ; 88/CD4C

        .al
        .xl
        .autsiz
        .databank ?

        lda #$8000
        trb $07E8,b
        rtl

        .databank 0

        ; 88/CD53

    .endsection Unsorted88CC75Section


    .section Unsorted88CD53Section

      .al
      .xl

      rlUnknown88CD53 ; 88/CD53

        .al
        .autsiz
        .databank ?

        lda #$8000
        tsb $07E8,b
        rtl

        .databank 0

      rlUnknown88CD5A ; 88/CD5A

        .al
        .autsiz
        .databank ?

        lda #$0001
        trb $07E8,b
        rtl

        .databank 0

      rlUnknown88CD61 ; 88/CD61

        .al
        .autsiz
        .databank ?

        lda #$0001
        tsb $07E8,b
        rtl

        .databank 0

        ; 88/CD68

    .endsection Unsorted88CD53Section


    .section Unsorted88CD68Section

      .al
      .xl

      rlUnknown88CD68 ; 88/CD68

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $88
        jsl rlUnknown88DB0C
        lda $07E4,b
        and #$0007
        beq _CD97
        cmp #$0001
        beq _CD9D
        lda $07E8,b
        bmi _CD94
        lda $07E4,b
        and #$000F
        cmp #$0008
        bcc _CDA3
        jml _CE11


        _CD91
        inc $07E4,b

        _CD94
        plp
        plb
        .databank $88
        rtl


        _CD97
        jsl rlUnknown88CF31
        bra _CD91


        _CD9D
        jsl rlUnknown88CFBA
        bra _CD91


        _CDA3
        sep #$20
        rep #$10
        lda #$80
        sta $2115,b
        lda #$00
        sta $4316,b
        sta $4326,b
        lda #$18
        sta $4311,b
        sta $4321,b
        ldy #$0000

        _CDBF
        lda #$40
        sta $4315,b
        sta $4325,b
        ldx $07ED,b,y
        stx $4312,b
        lda $07EF,b,y
        sta $4314,b
        ldx $081D,b,y
        stx $2116,b
        lda #$01
        sta $4310,b
        sta $4320,b
        lda #$02
        sta $420B,b
        ldx $07F0,b,y
        stx $4322,b
        lda $07F2,b,y
        sta $4324,b
        ldx $0820,b,y
        stx $2116,b
        lda #$04
        sta $420B,b
        tya
        clc
        adc #$06
        tay
        cpy #$0030
        beq _CE0B
        jml _CDBF


        _CE0B
        rep #$20
        jml _CD91


        _CE11
        sep #$20
        rep #$10
        lda #$80
        sta $2115,b
        lda #$18
        sta $4311,b
        sta $4321,b
        lda #$00
        sta $4316,b
        sta $4326,b
        ldy #$0000

        _CE2D
        lda #$40
        sta $4315,b
        ldx $07ED,b,y
        stx $4312,b
        lda $07EF,b,y
        sta $4314,b
        ldx $081D,b,y
        stx $2116,b
        lda #$01
        sta $4310,b
        sta $4320,b
        lda #$02
        sta $420B,b
        lda #$80
        sta $4325,b
        ldx $07F0,b,y
        stx $4322,b
        lda $07F2,b,y
        sta $4324,b
        ldx $0820,b,y
        stx $2116,b
        lda #$04
        sta $420B,b
        tya
        clc
        adc #$06
        tay
        cpy #$0018
        beq _CE7B
        jml _CE2D


        _CE7B
        rep #$20
        jml _CD91

        .databank 0

        ; 88/CE81

      rlUnknown88CE81 ; 88/CE81

        .al
        .xl
        .autsiz
        .databank ?

        lda $07E4,b
        and #$000F
        asl a
        xba
        sta $078E,b
        lda $07E4,b
        and #$000F
        sec
        sbc #$000A
        asl a
        asl a
        asl a
        clc
        adc #$0060
        sta $078C,b
        lda $07E4,b
        and #$0030
        cmp #$0000
        beq _CEBA
        cmp #$0010
        beq _CEBF
        cmp #$0020
        beq _CEC4
        cmp #$0030
        beq _CEC9

        _CEBA
        lda #$0000
        bra _CECE


        _CEBF
        lda #$00C0
        bra _CECE


        _CEC4
        lda #$0180
        bra _CECE


        _CEC9
        lda #$00C0
        bra _CECE


        _CECE
        sta $07E6,b
        sta $0790,b
        ldx $078C,b
        ldy #$0000

        _CEDA
        lda $7E480B,x
        and #$7FFF
        sta wR0
        clc
        adc wR0
        clc
        adc wR0
        phx
        tax
        lda $88D5E4,x
        sta $07EE,b,y
        sta $07F1,b,y
        lda $88D5E3,x
        clc
        adc $07E6,b
        sta $07ED,b,y
        clc
        adc #$0040
        sta $07F0,b,y
        plx
        lda #$6000
        clc
        adc $078E,b
        sta $081D,b,y
        clc
        adc #$0100
        sta $0820,b,y
        lda $078E,b
        clc
        adc #$0040
        sta $078E,b
        inc x
        inc x
        tya
        clc
        adc #$0006
        tay
        cpy #$0018
        bcc _CEDA
        rts

        .databank 0

        ; 88/CF31

      rlUnknown88CF31 ; 88/CF31

        .al
        .xl
        .autsiz
        .databank ?

        lda $07E8,b
        bit #$0001
        bne _CF89
        sep #$20
        lda $07E4,b
        and #$78
        lsr a
        lsr a
        lsr a
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda #$80
        sta $2115,b
        lda #$00
        sta $4315,b
        lda #$08
        sta $4316,b
        lda #$18
        sta $4311,b
        lda $88CF8A,x
        sta $4312,b
        lda $88CF8B,x
        sta $4313,b
        lda $88CF8C,x
        sta $4314,b
        lda #$00
        sta $2116,b
        lda #$0C
        sta $2117,b
        lda #$01
        sta $4310,b
        lda #$02
        sta $420B,b
        rep #$20

        _CF89
        rtl

        .databank 0

        ; 88/CF8A

    .endsection Unsorted88CD68Section


    .section Unsorted88CFBASection

      .al
      .xl

      rlUnknown88CFBA ; 88/CFBA

        .al
        .xl
        .autsiz
        .databank ?

        lda $07E8,b
        bit #$0001
        bne _D012
        sep #$20
        lda $07E4,b
        and #$F8
        lsr a
        lsr a
        lsr a
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda #$80
        sta $2115,b
        lda #$00
        sta $4315,b
        lda #$04
        sta $4316,b
        lda #$18
        sta $4311,b
        lda $88D013,x
        sta $4312,b
        lda $88D014,x
        sta $4313,b
        lda $88D015,x
        sta $4314,b
        lda #$00
        sta $2116,b
        lda #$0A
        sta $2117,b
        lda #$01
        sta $4310,b
        lda #$02
        sta $420B,b
        rep #$20

        _D012
        rtl

        .databank 0

        ; 88/D013

    .endsection Unsorted88CFBASection


    .section Unsorted88D073Section

      .al
      .xl

      rlUnknown88D073 ; 88/D073

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $88
        phk
        plb
        .databank $88
        jsl rlUnknown88CF31
        jsl rlUnknown88CFBA
        plp
        plb
        .databank $88
        rtl

        .databank 0

        ; 88/D084

    .endsection Unsorted88D073Section


    .section Unsorted88D7FESection

      .al
      .xl

      rlUnknown88D7FE ; 88/D7FE

        .al
        .autsiz
        .databank ?

        ; X = active mover offset

        phk
        plb
        lda aUnknown88D837,x
        trb wUnknown000921,b
        lda aUnknown88D83F,x
        trb wUnknown000921,b

        lda aMovingMapSpritesMapSprites,b,x
        and #$8000
        bne +

        ; Short
        jsr rsUnknown88D847
        lda wUnknown000901,x
        sec
        sbc #1
        sta wUnknown000901,x
        bra ++

        ; Tall
        +
        jsr rsUnknown88D963
        lda wUnknown000901,x
        sec
        sbc #1
        sta wUnknown000901,x

        +
        rtl

        .databank 0

      aUnknown88D837 ; 88/D837

        .word $0001
        .word $0002
        .word $0004
        .word $0008

      aUnknown88D83F ; 88/D83F

        .word $8000
        .word $4000
        .word $2000
        .word $1000

    .endsection Unsorted88D7FESection


    .section Unsorted88D847Section

      .al
      .xl

      rsUnknown88D847 ; 88/D847

        .al
        .autsiz
        .databank $88

        ; X = active mover offset

        ; For short map sprites

        lda wUnknown000901,x
        beq +

          jml _End

        +
        lda wUnknown000921,b
        beq ++

          and #$FF00
          beq +

            inc wUnknown000901,b,x
            jml _End

          +
          lda @l aUnknown88D95B,x
          tsb wUnknown000921,b

        +
        lda @l aUnknown88D953,x
        tsb wUnknown000921,b

        lda aMovingMapSpritesMapSprites,b,x
        and #$7FFF
        tay
        lda aUnknown88CBE8,y
        and #$00FF
        sta wUnknown000901,x

        lda wUnknown0008F1,x
        clc
        adc #1
        and #$0003
        sta wUnknown0008F1,x

        lda wUnknown0008F1,x
        cmp #0
        beq _D8A8

        cmp #1
        beq _D8AD

        cmp #2
        beq _D8B2

        cmp #3
        beq _D8B7

        _D8A8
        lda #size(Tile4bpp) * 0
        bra +

        _D8AD
        lda #size(Tile4bpp) * 10
        bra +

        _D8B2
        lda #size(Tile4bpp) * 20
        bra +

        _D8B7
        lda #size(Tile4bpp) * 30
        bra +

        +
        sta $07E6,b

        ; Check for direction of movement
        lda wUnknown000911,x
        cmp #0
        beq _D8D7

        cmp #8
        beq _D8DC

        cmp #$0010
        beq _D8E1

        cmp #$0018
        beq _D8E6

        _D8D7
        lda #0
        bra +

        _D8DC
        lda #$0500
        bra +

        _D8E1
        lda #$0A00
        bra +

        _D8E6
        lda #$0F00
        bra +

        +
        clc
        adc $07E6,b
        sta $07E6,b

        jsr (aUnknown88D94B,x)

        lda $07EA,b
        clc
        adc $07E6,b
        sta lR18

        lda #$00A0
        sta wR0

        lda #$C400 >> 1
        clc
        adc @l aUnknown88DB04,x
        sta wR1
        phx
        jsl rlDMAByPointer
        plx

        lda $07EA,b
        clc
        adc #$00A0
        clc
        adc $07E6,b
        sta lR18

        lda #$00A0
        sta wR0

        lda #$C600 >> 1
        clc
        adc @l aUnknown88DB04,x
        sta wR1
        phx
        jsl rlDMAByPointer
        plx

        _End
        sep #$20
        lda #$88
        pha
        plb
        rep #$20

        stz wR0
        stz wR1
        lda @l aUnknown88DAFC,x
        sta wR4
        ldy #$CC5F
        rts

        .databank 0

    .endsection Unsorted88D847Section


    .section Unsorted88D94BSection

      .al
      .xl

      aUnknown88D94B ; 88/D94B

        .word <>rsUnknown88DA82
        .word <>rsUnknown88DA99
        .word <>rsUnknown88DABA
        .word <>rsUnknown88DADB

      aUnknown88D953 ; 88/D953

        .word $0001
        .word $0002
        .word $0004
        .word $0008

      aUnknown88D95B ; 88/D95B

        .word $8000
        .word $4000
        .word $2000
        .word $1000

    .endsection Unsorted88D94BSection


    .section Unsorted88D963Section

      .al
      .xl

      rsUnknown88D963 ; 88/D963

        .al
        .autsiz
        .databank $88

        lda wUnknown000901,x
        beq +

          jml _End

        +
        lda wUnknown000921,b
        beq ++

          and #$FF00
          beq +

            inc wUnknown000901,b,x
            jml _End

          +
          lda @l $88DA7A,x
          tsb wUnknown000921,b

        +
        lda @l aUnknown88DA72,x
        tsb wUnknown000921,b

        lda $0867,b,x
        and #$7FFF
        tay
        lda aUnknown88CBE8,y
        and #$00FF
        sta wUnknown000901,x

        lda wUnknown0008F1,x
        clc
        adc #1
        and #$0003
        sta wUnknown0008F1,x

        lda wUnknown0008F1,x
        cmp #0
        beq _D9C4

        cmp #1
        beq _D9C9

        cmp #2
        beq _D9CE

        cmp #3
        beq _D9D3
        
        _D9C4
        lda #0
        bra +

        _D9C9
        lda #$0200
        bra +

        _D9CE
        lda #$0400
        bra +

        _D9D3
        lda #$0600
        bra +

        +
        sta $07E6,b

        lda wUnknown000911,x
        xba
        clc
        adc $07E6,b
        sta $07E6,b

        jsr (aUnknown88DA6A,x)

        lda $07EA,b
        clc
        adc $07E6,b
        sta lR18

        lda #size(Tile4bpp) * 8
        sta wR0

        lda #$C400 >> 1
        clc
        adc @l aUnknown88DB04,x
        sta wR1
        phx
        jsl rlDMAByPointer
        plx

        lda $07EA,b
        clc
        adc #$0100
        clc
        adc $07E6,b
        sta lR18

        lda #size(Tile4bpp) * 8
        sta wR0

        lda #$C600 >> 1
        clc
        adc @l aUnknown88DB04,x
        sta wR1
        phx
        jsl rlDMAByPointer
        plx

        _End
        sep #$20
        lda #$88
        pha
        plb
        rep #$20

        phx
        lda $0867,b,x
        and #$7FFF
        asl a
        tax
        lda @l $88D488,x
        sta wR3
        plx

        lda wUnknown0008F1,x
        asl a
        clc
        adc wUnknown000911,x
        clc
        adc wR3
        tay
        lda $D4C6,b,y
        and #$00FF
        sta wR0
        lda $D4C7,b,y
        and #$00FF
        sta wR1
        lda @l aUnknown88DAFC,x
        sta wR4
        ldy #$CC49
        rts

        .databank 0

    .endsection Unsorted88D963Section


    .section Unsorted88DA6ASection

      .al
      .xl

      aUnknown88DA6A ; 88/DA6A

        .word <>rsUnknown88DA82
        .word <>rsUnknown88DA99
        .word <>rsUnknown88DABA
        .word <>rsUnknown88DADB

      aUnknown88DA72 ; 88/DA72

        .word $0001
        .word $0002
        .word $0004
        .word $0008

      aUnknown88DA7A ; 88/DA7A

        .word $8000
        .word $4000
        .word $2000
        .word $1000

    .endsection Unsorted88DA6ASection


    .section Unsorted88DA82Section

      .al
      .xl

      rsUnknown88DA82 ; 88/DA82

        .al
        .autsiz
        .databank ?

        lda #(`aMovingMapSpriteBuffers[0])<<8
        sta lR18+1
        lda #<>aMovingMapSpriteBuffers[0]
        sta lR18
        lda #(`aMovingMapSpriteBuffers[0])<<8
        sta $07EA+1,b
        lda #<>aMovingMapSpriteBuffers[0]
        sta $07EA,b
        rts

        .databank 0

      rsUnknown88DA99 ; 88/DA99

        .al
        .autsiz
        .databank ?

        lda #(`aMovingMapSpriteBuffers[0])<<8
        sta lR18+1
        lda #<>aMovingMapSpriteBuffers[0]
        sta lR18
        lda #(`aMovingMapSpriteBuffers[0])<<8
        sta $07EA+1,b
        lda #<>aMovingMapSpriteBuffers[0]
        sta $07EA,b

        lda $07EA,b
        clc
        adc #$2000
        sta $07EA,b
        rts

        .databank 0

      rsUnknown88DABA ; 88/DABA

        .al
        .autsiz
        .databank ?

        lda #(`aMovingMapSpriteBuffers[0])<<8
        sta lR18+1
        lda #<>aMovingMapSpriteBuffers[0]
        sta lR18
        lda #(`aMovingMapSpriteBuffers[0])<<8
        sta $07EB,b
        lda #<>aMovingMapSpriteBuffers[0]
        sta $07EA,b

        lda $07EA,b
        clc
        adc #$4000
        sta $07EA,b
        rts

        .databank 0

      rsUnknown88DADB ; 88/DADB

        .al
        .autsiz
        .databank ?

        lda #(`aMovingMapSpriteBuffers[0])<<8
        sta lR18+1
        lda #<>aMovingMapSpriteBuffers[0]
        sta lR18
        lda #(`aMovingMapSpriteBuffers[0])<<8
        sta $07EB,b
        lda #<>aMovingMapSpriteBuffers[0]
        sta $07EA,b

        lda $07EA,b
        clc
        adc #$6000
        sta $07EA,b
        rts

        .databank 0

    .endsection Unsorted88DA82Section


    .section Unsorted88DAFCSection

      .al
      .xl

      aUnknown88DAFC ; 88/DAFC

        .word $0000
        .word $0008
        .word $0020
        .word $0028

      aUnknown88DB04 ; 88/DB04

        .word $0000 >> 1
        .word $0100 >> 1
        .word $0400 >> 1
        .word $0500 >> 1

        ; 88/DB0C

    .endsection Unsorted88DAFCSection


    .section Unsorted88DB0CSection

      .al
      .xl

      rlUnknown88DB0C ; 88/DB0C

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $88
        lda $07DA,b
        beq _DB2F
        lda $0865,b
        beq _DB2F
        ldx $0772,b
        lda $7E465B,x
        tax
        lda $7E480B,x
        and #$8000
        beq _DB32
        jml _DB90


        _DB2F
        plp
        plb
        .databank $88
        rtl


        _DB32
        sep #$20
        rep #$10
        lda #$80
        sta $2115,b
        lda #$00
        sta $4316,b
        sta $4326,b
        lda #$18
        sta $4311,b
        sta $4321,b
        lda #$01
        sta $4310,b
        sta $4320,b
        lda #$A0
        sta $4315,b
        ldx $084D,b
        stx $4312,b
        lda $084F,b
        sta $4314,b
        ldx #$6200
        stx $2116,b
        lda #$02
        sta $420B,b
        lda #$A0
        sta $4325,b
        ldx $0850,b
        stx $4322,b
        lda $084F,b
        sta $4324,b
        ldx #$6300
        stx $2116,b
        lda #$04
        sta $420B,b
        rep #$20
        plp
        plb
        .databank $88
        rtl


        _DB90
        sep #$20
        rep #$10
        lda #$80
        sta $2115,b
        lda #$18
        sta $4311,b
        sta $4321,b
        lda #$00
        sta $4315,b
        sta $4325,b
        lda #$01
        sta $4310,b
        sta $4320,b
        lda #$01
        sta $4316,b
        ldx $084D,b
        stx $4312,b
        lda $084F,b
        sta $4314,b
        ldx #$6200
        stx $2116,b
        lda #$02
        sta $420B,b
        lda #$01
        sta $4326,b
        ldx $0850,b
        stx $4322,b
        lda $084F,b
        sta $4324,b
        ldx #$6300
        stx $2116,b
        lda #$04
        sta $420B,b
        sep #$20
        plp
        plb
        .databank $88
        rtl

        .databank 0

        ; 88/DBEE

    .endsection Unsorted88DB0CSection


    .section Unsorted88DD9CSection

      .as
      .xl

      rlUnknown88DD9C ; 88/DD9C

        .al
        .xl
        .autsiz
        .databank ?

        phb
        phk
        plb
        .databank $88
        lda wR0
        bne _DDA8
        jsr rlUnknown88DDAD
        bra _DDAB


        _DDA8
        jsr rlUnknown88DDD4

        _DDAB
        plb
        .databank $88
        rtl

        .databank 0

        ; 88/DDAD

      rlUnknown88DDAD ; 88/DDAD

        .al
        .xl
        .autsiz
        .databank ?

        lda #$00A0
        sta wR0
        phx
        jsl rlDMAByPointer
        plx
        lda lR18
        clc
        adc #$00A0
        sta lR18
        lda #$00A0
        sta wR0
        lda wR1
        clc
        adc #$0100
        sta wR1
        phx
        jsl rlDMAByPointer
        plx
        rts

        .databank 0

        ; 88/DDD4

      rlUnknown88DDD4 ; 88/DDD4

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0100
        sta wR0
        phx
        jsl rlDMAByPointer
        plx
        lda lR18
        clc
        adc #$0100
        sta lR18
        lda #$0100
        sta wR0
        lda wR1
        clc
        adc #$0100
        sta wR1
        phx
        jsl rlDMAByPointer
        plx
        rts

        .databank 0

        ; 88/DDFB

    .endsection Unsorted88DD9CSection


    .section Unsorted88DE1BSection

      .al
      .xl

      rlUnknown88DE1B ; 88/DE1B

        .al
        .xl
        .autsiz
        .databank ?

        phk
        plb
        .databank $88
        stz $07E6,b
        ldx #$008E

        _DE23
        lda $7E480B,x
        cmp #$FFFF
        beq _DE3B
        and #$8000
        beq _DE36
        jsr rlUnknown88DE9E
        bra _DE3B


        _DE36
        jsr rlUnknown88DE40
        bra _DE3B


        _DE3B
        dec x
        dec x
        bpl _DE23
        rtl

        .databank 0

        ; 88/DE40

      rlUnknown88DE40 ; 88/DE40

        .al
        .xl
        .autsiz
        .databank ?

        lda $88DEFC,x
        sta $078E,b
        lda $7E480B,x
        and #$7FFF
        sta wR0
        clc
        adc wR0
        clc
        adc wR0
        phx
        tax
        lda $88D527,x
        sta lR18+1
        lda $88D526,x
        clc
        adc $07E6,b
        sta $07EA,b
        sta lR18
        plx
        lda #$0040
        sta wR0
        lda #$6000
        clc
        adc $078E,b
        sta wR1
        phx
        jsl rlDMAByPointer
        plx
        lda $07EA,b
        clc
        adc #$0040
        sta lR18
        lda #$0040
        sta wR0
        lda #$6100
        clc
        adc $078E,b
        sta wR1
        phx
        jsl rlDMAByPointer
        plx
        rts

        .databank 0

        ; 88/DE9E

      rlUnknown88DE9E ; 88/DE9E

        .al
        .xl
        .autsiz
        .databank ?

        lda $88DEFC,x
        sta $078E,b
        lda $7E480B,x
        and #$7FFF
        sta wR0
        clc
        adc wR0
        clc
        adc wR0
        phx
        tax
        lda $88D5E4,x
        sta lR18+1
        lda $88D5E3,x
        clc
        adc $07E6,b
        sta $07EA,b
        sta lR18
        plx
        lda #$0040
        sta wR0
        lda #$6000
        clc
        adc $078E,b
        sta wR1
        phx
        jsl rlDMAByPointer
        plx
        lda $07EA,b
        clc
        adc #$0040
        sta lR18
        lda #$0080
        sta wR0
        lda #$6100
        clc
        adc $078E,b
        sta wR1
        phx
        jsl rlDMAByPointer
        plx
        rts

        .databank 0

        ; 88/DEFC

    .endsection Unsorted88DE1BSection


    .section Unsorted88E33DSection

      .al
      .xl

      rlUnknown88E33D ; 88/E33D

        .al
        .xl
        .autsiz
        .databank ?

        php
        phx
        jsl rlDecompressWorldMapPortraitToSlot
        lda #$0000
        sta lR20+1
        lda #$01C0
        sta lR20
        ldy #$001E

        _E350
        lda [lR19],y
        sta [lR20],y
        dec y
        dec y
        bpl _E350
        lda #$3800
        sta wR1
        lda #$0800
        sta wR0
        jsl rlDMAByPointer
        lda #$8800
        sta lR44+1
        lda #$E200
        sta lR44
        jsl rlProcEngineCreateProc
        plx
        plp
        rtl

        .databank 0

        ; 88/E377

      rlUnknown88E377 ; 88/E377

        .al
        .xl
        .autsiz
        .databank ?

        php
        phx
        lda #$8800
        sta lR44+1
        lda #$E26A
        sta lR44
        jsl rlProcEngineCreateProc
        plx
        plp
        rtl

        .databank 0

        ; 88/E38A

    .endsection Unsorted88E33DSection
