; Code from bank $80 not yet assigned to a game system.

    .section Unsorted808002Section

      .al
      .xl

      rlUnknown808002 ; 80/8002

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        php
        sep #$20

        _8005
        lda $4212,b
        and #$01
        bne _8005
        rep #$20
        lda $4218,b
        sta wJoy1Input
        and #$000F
        beq _801C
        lda wJoy1Old
        sta wJoy1Input

        _801C
        lda wJoy1Input
        eor wJoy1Old
        and wJoy1Input
        sta wJoy1New
        sta wJoy1Repeated
        lda wJoy1Input
        beq _803C
        cmp wJoy1Old
        bne _803C
        dec wJoy1RepeatTimer
        bne _8040
        lda wJoy1Input
        sta wJoy1Repeated
        lda wJoyRepeatInterval
        sta wJoy1RepeatTimer
        bra _8040


        _803C
        lda wJoyRepeatDelay
        sta wJoy1RepeatTimer

        _8040
        lda wJoy1Input
        sta wJoy1Old
        lda $421A,b
        sta wJoy2Input
        and #$000F
        beq _8052
        lda wJoy2Old
        sta wJoy2Input

        _8052
        lda wJoy2Input
        eor wJoy2Old
        and wJoy2Input
        sta wJoy2New
        sta wJoy2Repeated
        lda wJoy2Input
        beq _8072
        cmp wJoy2Old
        bne _8072
        dec wJoy2RepeatTimer
        bne _8076
        lda wJoy2Input
        sta wJoy2Repeated
        lda wJoyRepeatInterval
        sta wJoy2RepeatTimer
        bra _8076


        _8072
        lda wJoyRepeatDelay
        sta wJoy2RepeatTimer

        _8076
        lda wJoy2Input
        sta wJoy2Old
        plp
        rtl

        .databank 0

        ; 80/807C

    .endsection Unsorted808002Section


    .section Unsorted8080C3Section

      .al
      .xl

      rlUnknown8080C3 ; 80/80C3

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        php
        phb
        phk
        plb
        .databank $80
        sep #$20
        lda bBufferINIDISP
        sta $2100,b
        lda bBufferOBSEL
        sta $2101,b
        lda bBufferBGMODE
        sta $2105,b
        lda bBufferMOSAIC
        sta $2106,b
        lda bBufferBG1SC
        sta $2107,b
        lda bBufferBG2SC
        sta $2108,b
        lda bBufferBG3SC
        sta $2109,b
        lda bBufferBG4SC
        sta $210A,b
        lda bBufferBG12NBA
        sta $210B,b
        lda bBufferBG34NBA
        sta $210C,b
        lda bBufferW12SEL
        sta $2123,b
        lda bBufferW34SEL
        sta $2124,b
        lda bBufferWOBJSEL
        sta $2125,b
        lda bBufferWH0
        sta $2126,b
        lda bBufferWH1
        sta $2127,b
        lda bBufferWH2
        sta $2128,b
        lda bBufferWH3
        sta $2129,b
        lda bBufferWBGLOG
        sta $212A,b
        lda bBufferWOBJLOG
        sta $212B,b
        lda bBufferTM
        sta $212C,b
        lda bBufferTMW
        sta $212E,b
        lda bBufferTS
        sta $212D,b
        lda bBufferTSW
        sta $212F,b
        lda bBufferCGWSEL
        sta $2130,b
        lda bBufferCGADSUB
        sta $2131,b
        lda bBufferCOLDATA_1
        sta $2132,b
        lda bBufferCOLDATA_2
        sta $2132,b
        lda bBufferCOLDATA_3
        sta $2132,b
        lda bBufferSETINI
        sta $2133,b
        lda wBufferBG1HOFS
        sta $210D,b
        lda wBufferBG1HOFS+1
        sta $210D,b
        lda wBufferBG1VOFS
        sec
        sbc #$01
        sta $210E,b
        lda wBufferBG1VOFS+1
        sbc #$00
        sta $210E,b
        lda wBufferBG2HOFS
        sta $210F,b
        lda wBufferBG2HOFS+1
        sta $210F,b
        lda wBufferBG2VOFS
        sec
        sbc #$01
        sta $2110,b
        lda wBufferBG2VOFS+1
        sbc #$00
        sta $2110,b
        lda wBufferBG3HOFS
        sta $2111,b
        lda wBufferBG3HOFS+1
        sta $2111,b
        lda wBufferBG3VOFS
        sec
        sbc #$01
        sta $2112,b
        lda wBufferBG3VOFS+1
        sbc #$00
        sta $2112,b
        plb
        .databank $80
        plp
        rtl

        .databank 0

        ; 80/81A8

    .endsection Unsorted8080C3Section


    .section Unsorted8081B6Section

      .al
      .xl

      rlUnknown8081B6 ; 80/81B6

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        cli
        rep #$30
        jml _81BD


        _81BD
        phb
        phd
        pha
        phx
        phy
        lda #$0000
        tcd
        phk
        plb
        .databank $80
        lda $4210,b
        lda wVBlankFlag
        bmi _81E9
        ora #$8000
        sta wVBlankFlag
        pea #$81D9
        jmp (wVBlankPointer)

        jsl rlUnknown91EB76
        inc wVBlankEnabledFramecount
        ply
        plx
        pla
        pld
        stz wVBlankFlag,b
        plb
        .databank $80
        rti


        _81E9
        inc wVBlankDisabledFramecount
        jsl rlUnknown8090A2
        jsl $8081A8
        jsl rlUnknown91EB76
        ply
        plx
        pla
        pld
        plb
        .databank $80
        rti

        .databank 0

        ; 80/81FD

    .endsection Unsorted8081B6Section


    .section Unsorted80823FSection

      .al
      .xl

      rlUnknown80823F ; 80/823F

        .al
        .xl
        .autsiz
        .databank ?

        php
        lda wVBlankEnabledFramecount

        _8242
        cmp wVBlankEnabledFramecount
        beq _8242
        plp
        rtl

        .databank 0

        ; 80/8248

    .endsection Unsorted80823FSection


    .section Unsorted80825BSection

      .al
      .xl

      rlUnknown80825B ; 80/825B

        .al
        .xl
        .autsiz
        .databank ?

        php
        phb
        phk
        plb
        .databank $80
        sep #$20
        lda bBufferINIDISP
        and #$7F
        sta bBufferINIDISP
        jsl rlUnknown80823F
        plb
        .databank $80
        plp
        rtl

        .databank 0

        ; 80/826E

    .endsection Unsorted80825BSection


    .section Unsorted808875Section

      .al
      .xl

      rlUnknown808875 ; 80/8875

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0001
        sta $0E77,b
        lda #$0030
        sta $0E75,b
        rtl

        .databank 0

        ; 80/8882

      rlUnknown808882 ; 80/8882

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta $0E77,b
        lda #$0001
        sta $0E75,b
        ldx #$0000

        _8891
        sta @l $000E53,x
        inc x
        inc x
        cpx #$0020
        bne _8891
        rtl

        .databank 0

        ; 80/889D

    .endsection Unsorted808875Section


    .section Unsorted80889DSection

      .as
      .xl

      rlUnknown80889D ; 80/889D

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda wR1
        lsr a
        lsr a
        lsr a
        and #$001E
        sta wR5
        tax
        lda $0DB3,b,x
        cmp $0DF3,b,x
        beq _88D7
        adc #$0020
        sta $0DB3,b,x
        sta $0E13,b,x
        adc wR5
        tax
        lda wNextFreeSpriteOffset,b
        ora #$8000
        sta $7FEC68,x
        lda $0E77,b
        beq _88D3
        lda #$0000
        ldx wR5
        sta $0E13,b,x

        _88D3
        jml _897F


        _88D7
        rtl

        lda wR1
        lsr a
        lsr a
        lsr a
        and #$001E
        sta wR5
        tax
        lda wR0
        cmp #$0010
        bcc _8909
        cmp #$00F0
        bcs _8909
        lda $0DB3,b,x
        cmp $0DF3,b,x
        beq _8944
        adc #$0020
        sta $0DB3,b,x
        adc wR5
        tax
        lda wNextFreeSpriteOffset,b
        sta $7FEC68,x
        bra _897F


        _8909
        lda $0DB3,b,x
        cmp $0DF3,b,x
        beq _8967
        adc #$0020
        sta $0DB3,b,x
        adc wR5
        sta wR3
        lda $0E13,b,x
        cmp $0DF3,b,x
        beq _8967
        adc #$0020
        sta $0E13,b,x
        adc wR5
        tax
        phx
        lda $7FEC68,x
        ldx wR3
        sta $7FEC68,x
        plx
        lda wNextFreeSpriteOffset,b
        ora #$8000
        sta $7FEC68,x
        bra _897F


        _8944
        lda $0DD3,b,x
        cmp $0DF3,b,x
        bne _894F
        lda #$0000

        _894F
        clc
        adc #$0020
        sta $0DD3,b,x
        adc wR5
        tax
        lda $7FEC68,x
        bmi _896A
        sta wR5
        lda $0E73,b
        lsr a
        bcs _8968

        _8967
        rtl


        _8968
        lda wR5

        _896A
        and #$01FF
        pha
        lda wNextFreeSpriteOffset,b
        sta $7FEC68,x
        pla
        tax
        lda #$00F0
        sta $1C01,b,x
        bra _897F


        _897F
        ldx wNextFreeSpriteOffset,b
        lda wR0
        sta aSpriteBuffer,b,x
        bit #$0100
        beq _899A
        lda aOAMSizeBitTable,x
        sta wR3
        lda (wR3)
        ora $8085C9,x
        sta (wR3)

        _899A
        lda wR1
        sta $1C01,b,x
        lda wR4
        sta $1C02,b,x
        txa
        clc
        adc #$0004
        sta wNextFreeSpriteOffset,b
        rtl

        .databank 0

        ; 80/89AD

      rlUnknown8089AD ; 80/89AD

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown808A6C
        jsr $808B48
        inc $0E73,b
        ldx #$0000
        txa

        _89BA
        sta @l $000DB3,x
        sta @l $000DD3,x
        sta @l $000E13,x
        inc x
        inc x
        cpx #$0020
        bne _89BA
        lda wNextFreeSpriteOffset,b
        lsr a
        sta wR0
        and #$000E
        tax
        lda wR0
        lsr a
        lsr a
        lsr a
        and #$001E
        tay
        lda $8089F1,x
        ora aSpriteExtBuffer,b,y
        sta aSpriteExtBuffer,b,y
        ldx #$AAAA
        jsr $808A35
        rtl

        .databank 0

        ; 80/89F1

    .endsection Unsorted80889DSection


    .section Unsorted808A01Section

      .al
      .xl

      rlUnknown808A01 ; 80/8A01

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda wNextFreeSpriteOffset,b
        lsr a
        sta wR0
        and #$000E
        tax
        lda wR0
        lsr a
        lsr a
        lsr a
        and #$001E
        tay
        lda $808A25,x
        and aSpriteExtBuffer,b,y
        sta aSpriteExtBuffer,b,y
        ldx #$0000
        jsr $808A35
        rtl

        .databank 0

        ; 80/8A25

    .endsection Unsorted808A01Section


    .section Unsorted808A35Section

      .as
      .xl

      rsUnknown808A35 ; 80/8A35

        .al
        .xl
        .autsiz
        .databank ?

        phd
        inc y
        inc y
        tya
        cmp #$0020
        bcs _8A6A
        adc #$8A4A
        sta wR0
        lda #$1E00
        tcd
        jmp (wR0)

        .byte $86, $00, $86, $02, $86, $04, $86, $06, $86, $08, $86, $0A, $86, $0C, $86, $0E
        .byte $86, $10, $86, $12, $86, $14, $86, $16, $86, $18, $86, $1A, $86, $1C, $86, $1E


        _8A6A
        pld
        rts

        .databank 0

        ; 80/8A6C

    .endsection Unsorted808A35Section


    .section Unsorted808A6CSection

      .al
      .xl

      rsUnknown808A6C ; 80/8A6C

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda wNextFreeSpriteOffset,b
        bne _8A72
        rts


        _8A72
        phb
        pea #$7F00
        plb
        .databank ?
        plb
        .databank ?
        lda #$0000
        ldx #$001E

        _8A7E
        sta $EC88,b,x
        sta $ECA8,b,x
        sta $ECC8,b,x
        sta $ECE8,b,x
        sta $ED08,b,x
        sta $ED28,b,x
        sta $ED48,b,x
        sta $ED68,b,x
        dec x
        dec x
        bpl _8A7E
        ldx #$0000

        _8A9D
        txa
        and #$001F
        bne _8AB1
        txa
        lsr a
        lsr a
        lsr a
        lsr a
        phx
        tax
        lda @l aSpriteExtBuffer,x
        sta wR0
        plx

        _8AB1
        lda @l $001C01,x
        and #$00FF
        cmp #$00E0
        bcs _8B0F
        lsr wR0
        lsr wR0
        bcc _8B1C
        phx
        tax
        clc
        lda $EC88,b,x
        adc #$0202
        sta $EC88,b,x
        lda $EC8A,b,x
        adc #$0202
        sta $EC8A,b,x
        lda $EC8C,b,x
        adc #$0202
        sta $EC8C,b,x
        lda $EC8E,b,x
        adc #$0202
        sta $EC8E,b,x
        lda $EC90,b,x
        adc #$0202
        sta $EC90,b,x
        lda $EC92,b,x
        adc #$0202
        sta $EC92,b,x
        lda $EC94,b,x
        adc #$0202
        sta $EC94,b,x
        lda $EC96,b,x
        adc #$0202
        sta $EC96,b,x
        plx

        _8B0F
        inc x
        inc x
        inc x
        inc x
        txa
        cmp @l wNextFreeSpriteOffset
        beq _8B46
        bra _8A9D


        _8B1C
        phx
        tax
        clc
        lda $EC88,b,x
        adc #$0101
        sta $EC88,b,x
        lda $EC8A,b,x
        adc #$0101
        sta $EC8A,b,x
        lda $EC8C,b,x
        adc #$0101
        sta $EC8C,b,x
        lda $EC8E,b,x
        adc #$0101
        sta $EC8E,b,x
        plx
        bra _8B0F


        _8B46
        plb
        .databank ?
        rts

        .databank 0

        ; 80/8B48

    .endsection Unsorted808A6CSection


    .section Unsorted808B48Section

      .al
      .xl

      rsUnknown808B48 ; 80/8B48

        .al
        .xl
        .autsiz
        .databank ?

        phb
        pea #$7F00
        plb
        .databank ?
        plb
        .databank ?
        ldx #$0000
        ldy #$0000

        _8B54
        lda @l wNextFreeSpriteOffset
        bne _8B5E
        jml _8BF7


        _8B5E
        sep #$20
        lda $EC88,b,y
        cmp $EC89,b,y
        bcs _8B6B
        lda $EC89,b,y

        _8B6B
        cmp $EC8A,b,y
        bcs _8B73
        lda $EC8A,b,y

        _8B73
        cmp $EC8B,b,y
        bcs _8B7B
        lda $EC8B,b,y

        _8B7B
        cmp $EC8C,b,y
        bcs _8B83
        lda $EC8C,b,y

        _8B83
        cmp $EC8D,b,y
        bcs _8B8B
        lda $EC8D,b,y

        _8B8B
        cmp $EC8E,b,y
        bcs _8B93
        lda $EC8E,b,y

        _8B93
        cmp $EC8F,b,y
        bcs _8B9B
        lda $EC8F,b,y

        _8B9B
        cmp $EC90,b,y
        bcs _8BA3
        lda $EC90,b,y

        _8BA3
        cmp $EC91,b,y
        bcs _8BAB
        lda $EC91,b,y

        _8BAB
        cmp $EC92,b,y
        bcs _8BB3
        lda $EC92,b,y

        _8BB3
        cmp $EC93,b,y
        bcs _8BBB
        lda $EC93,b,y

        _8BBB
        cmp $EC94,b,y
        bcs _8BC3
        lda $EC94,b,y

        _8BC3
        cmp $EC95,b,y
        bcs _8BCB
        lda $EC95,b,y

        _8BCB
        cmp $EC96,b,y
        bcs _8BD3
        lda $EC96,b,y

        _8BD3
        cmp $EC97,b,y
        bcs _8BDB
        lda $EC97,b,y

        _8BDB
        rep #$20
        and #$00FF
        inc a
        lsr a
        beq _8BF7
        sta wR0
        lda #$0011
        sec
        sbc wR0
        bcs _8BF1
        lda #$0000

        _8BF1
        xba
        lsr a
        lsr a
        lsr a
        bra _8BFA


        _8BF7
        lda #$0220

        _8BFA
        sta @l $000DF3,x
        cmp @l $000E33,x
        beq _8C14
        bcs _8C1E
        sta @l $000E33,x

        _8C0A
        lda @l $000E75
        sta @l $000E53,x
        bra _8C3D


        _8C14
        lda @l $000E53,x
        cmp @l $000E75
        bcs _8C0A

        _8C1E
        lda @l $000E53,x
        beq _8C35
        dec a
        sta @l $000E53,x
        beq _8C35
        lda @l $000E33,x
        sta @l $000DF3,x
        bra _8C3D


        _8C35
        lda @l $000DF3,x
        sta @l $000E33,x

        _8C3D
        tya
        clc
        adc #$0010
        tay
        inc x
        inc x
        cpx #$0020
        beq _8C4E
        jml _8B54


        _8C4E
        plb
        .databank ?
        rts

        .databank 0

        ; 80/8C50

    .endsection Unsorted808B48Section


    .section Unsorted808C50Section

      .al
      .xl

      rsUnknown808C50 ; 80/8C50

        .al
        .xl
        .autsiz
        .databank ?

        php
        sep #$20
        lda #$01
        sta $4200,b
        sta bBufferNMITIMEN
        stz $4201,b
        stz $4202,b
        stz $4203,b
        stz $4204,b
        stz $4205,b
        stz $4206,b
        stz $4207,b
        stz $4208,b
        stz $4209,b
        stz $420A,b
        stz $420B,b
        stz $420C,b
        stz $2140,b
        stz $2141,b
        stz $2142,b
        stz $2143,b
        lda #$01
        sta $420D,b
        sta bBufferMEMSEL
        lda #$80
        sta $2100,b
        sta bBufferINIDISP
        stz $2101,b
        stz $2102,b
        stz wBufferOAMADD
        lda #$80
        sta $2103,b
        sta wBufferOAMADD+1
        stz $2104,b
        stz $2104,b
        stz $2105,b
        stz $2106,b
        stz bBufferMOSAIC
        stz $2107,b
        stz $2108,b
        stz $2109,b
        stz $210A,b
        stz $210B,b
        stz $210C,b
        stz $210D,b
        stz $210D,b
        stz $210E,b
        stz $210E,b
        stz $210F,b
        stz $210F,b
        stz $2110,b
        stz $2110,b
        stz $2111,b
        stz $2111,b
        stz $2112,b
        stz $2112,b
        stz $2113,b
        stz $2113,b
        stz $2114,b
        stz $2114,b
        stz $2115,b
        stz $211A,b
        stz $211B,b
        stz $211C,b
        stz $211D,b
        stz $211E,b
        stz $211F,b
        stz $2120,b
        stz $2123,b
        stz $2124,b
        stz $2125,b
        stz $2126,b
        stz $2127,b
        stz $2128,b
        stz $2129,b
        stz $212A,b
        stz $212B,b
        stz $212C,b
        stz $212E,b
        stz $212D,b
        stz $212F,b
        stz $2130,b
        stz $2131,b
        lda #$80
        sta $2132,b
        sta bBufferCOLDATA_1
        lda #$40
        sta $2132,b
        sta bBufferCOLDATA_2
        lda #$20
        sta $2132,b
        sta bBufferCOLDATA_3
        stz $2133,b
        plp
        rts

        .databank 0

        ; 80/8D56

    .endsection Unsorted808C50Section


    .section Unsorted808E2DSection

      .as
      .xl

      rlUnknown808E2D ; 80/8E2D

        .al
        .xl
        .autsiz
        .databank ?

        pea #$7E00
        plb
        .databank ?
        plb
        .databank ?
        ldx #$1FF6

        _8E35
        stz $0000,b,x
        dec x
        dec x
        bpl _8E35
        ldx #$1FFE

        _8E3F
        stz $2000,b,x
        stz $4000,b,x
        stz $6000,b,x
        stz $8000,b,x
        stz $A000,b,x
        stz $C000,b,x
        stz $E000,b,x
        dec x
        dec x
        bpl _8E3F
        pea #$7F00
        plb
        .databank ?
        plb
        .databank ?
        ldx #$1FFE

        _8E60
        stz $0000,b,x
        stz $2000,b,x
        stz $4000,b,x
        stz $6000,b,x
        stz $8000,b,x
        stz $A000,b,x
        stz $C000,b,x
        stz $E000,b,x
        dec x
        dec x
        bpl _8E60
        phk
        plb
        .databank $80
        rep #$30
        lda #$1809
        sta $4300,b
        lda #$8000
        sta $4303,b
        lda #$8E93
        sta $4302,b
        lda #$0000
        sta $4305,b
        stz $2116,b
        sep #$20
        lda #$01
        sta $420B,b
        rep #$20
        jsr rsUnknown808C50
        jsl rlUnknown808EF6
        jsl rlUnknown878074
        lda #$0028
        sta wJoyRepeatDelay
        lda #$000A
        sta wJoyRepeatInterval
        lda #$9CA0
        sta wVBlankPointer
        lda #$8222
        sta wIRQPointer
        lda #$9CD6
        sta wMainLoopPointer
        jml _8EEE

        .byte $C2, $30, $A2, $F7, $1F, $9A, $E2, $20, $A9, $80, $8D, $00, $21, $9C, $00, $42
        .byte $9C, $0B, $42, $9C, $0C, $42, $C2, $30, $5C, $2D, $8E, $80, $C2, $30, $22, $3F
        .byte $82, $80


        _8EEE
        rep #$30
        pea #$8EE7
        jmp (wMainLoopPointer)

        .databank 0

        ; 80/8EF6

      rlUnknown808EF6 ; 80/8EF6

        .al
        .xl
        .autsiz
        .databank ?

        php
        phb
        phk
        plb
        .databank $80
        rep #$30
        phx
        phy
        lda lR38
        pha
        lda lR38+1
        pha
        lda lR39
        pha
        lda lR39+1
        pha
        ldx #$005E
        lda #$0000

        _8F10
        sta $04B6,b,x
        dec x
        dec x
        bpl _8F10
        lda #$F700
        sta $04B8,b
        lda #$7C00
        sta $04B6,b
        lda aUnknownF77C00
        tay
        lda aUnknownF77C00+1
        clc
        adc $04B8,b
        sta lR38+1
        stz lR38
        sep #$20
        lda #$FE
        sta $04F4,b
        jsl rlUnknown809124
        sep #$20
        stz $04F5,b
        lda #$FD
        sta $04F4,b
        rep #$20
        lda $04B8,b
        sta lR39+1
        lda aUnknownF77C0C+2
        sta lR39
        lda [lR39]
        sta lR39
        jsl rlUnknown8091B3
        pla
        sta lR39+1
        pla
        sta lR39
        pla
        sta lR38+1
        pla
        sta lR38
        ply
        plx
        plb
        .databank ?
        plp
        rtl

        .databank 0

        ; 80/8F6F

      rlUnknown808F6F ; 80/8F6F

        ; Runs on into built code at the end.
        .al
        .xl
        .autsiz
        .databank ?

        php
        phb
        phk
        plb
        .databank $80
        rep #$30
        phx
        pha
        and #$00FF
        cmp #$00C8
        bcc $808FC6
        cmp #$00E0
        bcs $808FC6
        sep #$20
        stz $04EB,b
        cmp #$CE
        bcs _8F94
        cmp #$CB
        bcc _8F94
        sta $04EB,b

        _8F94
        rep #$20
        lda $04EA,b
        and #$0010
        beq $808FC6
        pla
        plx
        plb
        .databank ?
        plp
        rtl

        .databank 0

        ; 80/8FA3

    .endsection Unsorted808E2DSection


    .section Unsorted808FA3Section

      .al
      .xs

      rlUnknown808FA3 ; 80/8FA3

        .al
        .autsiz
        .databank ?

        php
        phb
        phk
        plb
        rep #$30
        phx
        pha
        bra +

      rlUnknown808FAD ; 80/8FAD

        .al
        .autsiz
        .databank ?

        php
        phb
        phk
        plb
        rep #$30
        phx
        tax
        lda $04F4,b
        and #$00FF
        bne _End

          lda $04EA,b
          and #$0001
          bne _End

            phx

            +
            ldx #0

              -
              lda $04D8,b,x
              beq +

                inc x
                inc x
                cpx #6
                bcc -

            +
            pla
            sta $04D8,b,x
        
        _End
        plx
        plb
        plp
        rtl

        .databank 0

    .endsection Unsorted808FA3Section


    .section Unsorted808FDDSection

      .al
      .xl

      rlUnknown808FDD ; 80/8FDD

        .al
        .autsiz
        .databank ?

        php
        phb
        phk
        plb
        rep #$30
        phx

        tax
        lda $04F4,b
        and #$00FF
        beq rlUnknown80900D._901D

        cpx #$0010
        beq +

        cpx #$0020
        bne rlUnknown80900D._End
        
        +
        cpx $04E2,b
        beq rlUnknown80900D._End

        cpx $04E4,b
        beq rlUnknown80900D._End

        cpx $04E6,b
        beq rlUnknown80900D._End

        cpx $04E8,b
        beq rlUnknown80900D._End
        bra rlUnknown80900D._901D

      rlUnknown80900D ; 80/900D

        .al
        .autsiz
        .databank ?

        php
        phb
        phk
        plb
        rep #$30
        phx
        tax
        lda $04F4,b
        and #$00FF
        bne _End

          _901D
          lda $04EA,b
          and #$0004
          bne _End

          phx
          ldx #0

          -
          lda $04E2,b,x
          beq +

            inc x
            inc x
            cpx #6
            bcc -

          +
          pla
          sta $04E2,b,x

        _End
        plx
        plb
        plp
        rtl

        .databank 0

        ; 80/903D

    .endsection Unsorted808FDDSection


    .section Unsorted80903DSection

      .al
      .xl

      rlUnknown80903D ; 80/903D

        .as
        .xl
        .autsiz
        .databank ?

        php
        phb
        phk
        plb
        .databank $80
        rep #$20
        lda $04F6,b
        and #$0002
        bne _9057
        lda $04EB,b
        and #$00FF
        beq _9057
        jsl rlUnknown808F6F

        _9057
        plb
        .databank $80
        plp
        rtl

        .databank 0

        ; 80/905A

      rlUnknown80905A ; 80/905A

        .as
        .xl
        .autsiz
        .databank ?

        php
        phb
        phk
        plb
        .databank $80
        rep #$20
        lda $04F6,b
        and #$0002
        beq _906F
        lda #$00F8
        jsl rlUnknown808FA3

        _906F
        plb
        .databank $80
        plp
        rtl

        .databank 0

        ; 80/9072

      rlUnknown809072 ; 80/9072

        .as
        .xl
        .autsiz
        .databank ?

        php
        phb
        phk
        plb
        .databank $80
        rep #$20
        lda $04F6,b
        and #$0080
        beq _9087
        lda #$00F3
        jsl rlUnknown808FA3

        _9087
        plb
        .databank $80
        plp
        rtl

        .databank 0

        ; 80/908A

      rlUnknown80908A ; 80/908A

        .as
        .xl
        .autsiz
        .databank ?

        php
        phb
        phk
        plb
        .databank $80
        rep #$20
        lda $04F6,b
        and #$0080
        bne _909F
        lda #$00F2
        jsl rlUnknown808FA3

        _909F
        plb
        .databank $80
        plp
        rtl

        .databank 0

        ; 80/90A2

    .endsection Unsorted80903DSection


    .section Unsorted8090A2Section

      .al
      .xl

      rlUnknown8090A2 ; 80/90A2

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        php
        phb
        phk
        plb
        .databank $80
        sep #$10
        rep #$20
        ldy $04F4,b
        bne _9121

        _90AF
        ldx $2141,b
        cpx $2141,b
        bne _90AF
        stx $0506,b

        _90BA
        ldx $2140,b
        cpx $2140,b
        bne _90BA
        cpx $04D6,b
        bne _90E2
        lda $04D8,b
        sta $04D6,b
        lda $04DA,b
        sta $04D8,b
        lda $04DC,b
        sta $04DA,b
        lda $04DE,b
        sta $04DC,b
        stz $04DE,b

        _90E2
        lda $04D6,b
        sta $2140,b

        _90E8
        ldx $2143,b
        cpx $2143,b
        bne _90E8
        stx $04F6,b

        _90F3
        ldx $2142,b
        cpx $2142,b
        bne _90F3
        cpx $04E0,b
        bne _911B
        lda $04E2,b
        sta $04E0,b
        lda $04E4,b
        sta $04E2,b
        lda $04E6,b
        sta $04E4,b
        lda $04E8,b
        sta $04E6,b
        stz $04E8,b

        _911B
        lda $04E0,b
        sta $2142,b

        _9121
        plb
        .databank $80
        plp
        rtl

        .databank 0

        ; 80/9124

    .endsection Unsorted8090A2Section


    .section Unsorted809124Section

      .al
      .xl

      rlUnknown809124 ; 80/9124

        .as
        .xl
        .autsiz
        .databank ?

        php
        phb
        phk
        plb
        .databank $80
        sep #$20
        rep #$10

        _912C
        lda #$CC
        ldx #$BBAA
        cpx $2140,b
        beq _916E
        lda $04F4,b
        sta $2140,b
        bra _912C


        _913E
        lda [lR38],y
        inc y
        bne _9147
        inc lR38+2
        ldy lR38

        _9147
        rts


        _9148
        jsr _913E
        xba
        lda #$00
        bra _915B


        _9150
        xba
        jsr _913E
        xba

        _9155
        cmp $2140,b
        bne _9155
        inc a

        _915B
        rep #$20
        sta $2140,b
        sep #$20
        dec x
        bne _9150

        _9165
        cmp $2140,b
        bne _9165

        _916A
        adc #$03
        beq _916A

        _916E
        pha
        jsr _913E
        xba
        jsr _913E
        xba
        rep #$20
        tax
        sep #$20
        jsr _913E
        sta $2142,b
        jsr _913E
        sta $2143,b
        cpx #$0001
        lda #$00
        rol a
        sta $2141,b
        adc #$7F
        pla
        sta $2140,b

        _9197
        cmp $2140,b
        bne _9197
        bvs _9148
        stz $04F4,b
        rep #$30

        _91A3
        lda $2140,b
        cmp $2140,b
        bne _91A3
        cmp #$0000
        bne _91A3
        plb
        .databank ?
        plp
        rtl

        .databank 0

        ; 80/91B3

      rlUnknown8091B3 ; 80/91B3

        .al
        .xl
        .autsiz
        .databank ?

        php
        phb
        phk
        plb
        .databank $80
        sep #$10
        rep #$20
        lda $04F4,b
        and #$00FF
        sta $2140,b
        ldx #$00
        stx $04FD,b
        ldx $04F5,b
        beq _91D2
        jsl rlDisableVBlank

        _91D2
        ldx $04F4,b
        bra _91F9


        _91D7
        pea #$91E6
        inc y
        inc y

        _91DC
        lda [lR38]
        inc lR38
        inc lR38
        bne _91E6
        inc lR38+2

        _91E6
        rts

        .byte $EC, $40, $21, $D0, $FB, $8D, $42, $21, $8C, $40, $21, $E8, $E8


        _91F4
        dec $04F0,b
        bne _91D7

        _91F9
        phx

        _91FA
        lda [lR39]
        beq _927C
        cmp #$0064
        bcs _920B
        jsr rsUnknown8093C6
        ldx $04FD,b
        bne _920F

        _920B
        inc lR39
        inc lR39

        _920F
        sta $04F0,b
        xba
        sep #$20
        and #$F0
        beq _9220
        lsr a
        lsr a
        lsr a
        tax
        jsr ($809357,x)

        _9220
        rep #$20
        lda $04F0,b
        beq _91FA
        phb
        ldx $04B9,b
        phx
        plb
        .databank ?
        rep #$10
        and #$07FF
        sec
        sbc #$0064
        asl a
        asl a
        asl a
        clc
        adc aUnknownF77C0C
        tax
        lda $0007,b,x
        lsr a
        bcc _9249
        jml _92C9


        _9249
        lda $0002,b,x
        xba
        clc
        adc @l $0004B8
        sta lR38+1
        lda $0000,b,x
        sta lR38
        ldy $0005,b,x
        bne _9263
        lda @l $0004F2
        tay

        _9263
        lda $0003,b,x
        pha
        inc a
        lsr a
        sta @l $0004F0
        pla
        plb
        .databank ?
        sty $04F2,b
        clc
        adc $04F2,b
        sta $04F2,b
        tya
        sep #$10

        _927C
        plx
        txy
        inc y
        inc y
        inc y

        _9281
        inc y
        beq _9281

        _9284
        cpx $2140,b
        bne _9284
        sta $2142,b
        sty $2141,b
        sty $2140,b
        cmp #$0000
        beq _92B0
        jsr _91DC

        _929A
        cpy $2140,b
        bne _929A
        ldy #$02
        ldx #$00
        sta $2142,b
        sty $2140,b
        stx $2141,b
        jml _91F4


        _92B0
        ldx $2141,b
        cpx $04F4,b
        beq _92B0
        ldx #$00
        stx $04F4,b
        ldx $04F5,b
        beq _92C6
        jsl rlEnableVBlank

        _92C6
        plb
        .databank ?
        plp
        rtl


        _92C9
        .xl
        ldy DecompressionVariables
        phy
        ldy $CA
        phy
        ldy $CC
        phy
        ldy $CE
        phy
        ldy $D0
        phy
        ldy $D1
        phy
        lsr a
        bcc _92F8
        lda #$7E00
        sta $CC
        sta lR38+1
        lda #$6358
        sta $CB
        sta lR38
        txa
        cmp @l $000504
        beq _9334
        pea #$0001
        bra _9310


        _92F8
        lda #$7E00
        sta $CC
        sta lR38+1
        lda #$5358
        sta $CB
        sta lR38
        txa
        cmp @l $000502
        beq _9334
        pea #$0000

        _9310
        lda $0002,b,x
        xba
        clc
        adc @l $0004B8
        sta $C9
        lda $0000,b,x
        sta DecompressionVariables
        phx
        jsl rlUnknown80A9F2
        plx
        txa
        ply
        beq _9330
        sta @l $000504
        bra _9334


        _9330
        sta @l $000502

        _9334
        sep #$20
        lda [lR38]
        sta @l $000507
        rep #$20
        ply
        sty $D1
        ply
        sty $D0
        ply
        sty $CE
        ply
        sty $CC
        ply
        sty $CA
        ply
        sty DecompressionVariables
        ldy $0005,b,x
        jml _9263

        .databank 0

        ; 80/9357

    .endsection Unsorted809124Section


    .section Unsorted8093C6Section

      .al
      .xl

      rsUnknown8093C6 ; 80/93C6

        .al
        .xs
        .autsiz
        .databank ?

        cmp #$0005
        bcc _9412
        ldx $04FD,b
        bne _93E7
        sep #$20
        ldy #$00
        cmp #$3C
        bcs _93D9
        inc y

        _93D9
        cmp $04FE,b,y
        sta $04FE,b,y
        bne _93E7
        rep #$20
        lda #$0000
        rts


        _93E7
        inc x
        phx
        rep #$20
        asl a
        clc
        adc aUnknownF77C08
        sta lR38
        ldy $04B9,b
        sty lR38+2
        lda [lR38]

        _93FA
        dec x
        beq _9401
        inc a
        inc a
        bra _93FA


        _9401
        sta lR38
        plx
        ldy #$02
        lda [lR38],y
        bne _940C
        ldx #$00

        _940C
        lda [lR38]
        stx $04FD,b
        rts


        _9412
        cmp #$0003
        bcs _9477
        ldx $04B9,b
        stx lR38+2
        rep #$10
        dec a
        asl a
        tax
        lda $95A9,b,x
        tay
        lda $95A1,b,x
        tax
        lda $7E4EA9,x
        cmp #$FFFF
        bne _9435
        inc a
        bra _9441


        _9435
        and #$00FF
        clc
        adc aUnknownF77C12
        sta lR38
        lda [lR38],y

        _9441
        sep #$10
        and #$00FF
        bne _944C
        ldx #$00
        bra _9473


        _944C
        dec a
        asl a
        clc
        adc aUnknownF77C08
        sta lR38
        lda [lR38]
        sta lR38
        lda $04FD,b
        ldx $04FD,b
        inc x
        and #$000F
        asl a
        clc
        adc lR38
        sta lR38
        ldy #$02
        lda [lR38],y
        bne _9471
        ldx #$00

        _9471
        lda [lR38]

        _9473
        stx $04FD,b
        rts


        _9477
        ldx $04B9,b
        stx lR38+2
        pha
        rep #$10
        cmp #$0004
        bne _9489
        lda $050E,b
        bra _948C


        _9489
        lda $050C,b

        _948C
        sta $04F0,b
        pla
        dec a
        asl a
        tax
        lda $95A1,b,x
        tax
        ldy #$0140
        lda $7E4EA9,x
        and #$007F
        clc
        adc aUnknownF77C12
        sta lR38
        lda [lR38],y
        sep #$10
        and #$00FF
        bne _94B5
        ldx #$00
        bra _94DE


        _94B5
        dec a
        clc
        adc aUnknownF77C12+2
        adc $04F0,b
        sta lR38
        lda [lR38]
        sta lR38
        lda $04FD,b
        ldx $04FD,b
        inc x
        and #$000F
        asl a
        clc
        adc lR38
        sta lR38
        ldy #$02
        lda [lR38],y
        bne _94DC
        ldx #$00

        _94DC
        lda [lR38]

        _94DE
        stx $04FD,b
        rts

        .databank 0

        ; 80/94E2

    .endsection Unsorted8093C6Section


    .section Unsorted8095CDSection

      .al
      .xl

      rlUnknown8095CD ; 80/95CD

        .al
        .xl
        .autsiz
        .databank ?

        php
        phb
        phk
        plb
        .databank $80
        sep #$20
        lda $04F7,b
        clc
        adc #$03
        cmp #$09
        bcc _95DF
        lda #$00

        _95DF
        sta $04F7,b
        lda $04EA,b
        cmp $04EC,b
        beq _962F
        clc
        and #$40
        beq _95F0
        sec

        _95F0
        eor $04EC,b
        and #$40
        beq _960B
        lda #$40
        bcc _9604
        tsb $04EC,b
        jsl $80908A
        bra _960B


        _9604
        trb $04EC,b
        jsl $809072

        _960B
        clc
        lda $04EA,b
        and #$10
        beq _9614
        sec

        _9614
        eor $04EC,b
        and #$10
        beq _962F
        lda #$10
        bcc _9628
        tsb $04EC,b
        jsl $80905A
        bra _962F


        _9628
        trb $04EC,b
        jsl $80903D

        _962F
        rep #$30
        lda $04BA,b
        bne _963B
        sta $04C6,b
        bra _9641


        _963B
        ldx #$0000
        jsr rsUnknown809677

        _9641
        lda $04BC,b
        bne _964B
        sta $04C8,b
        bra _9651


        _964B
        ldx #$0002
        jsr rsUnknown809677

        _9651
        plb
        .databank $80
        plp
        rtl

        .databank 0

        ; 80/9654

    .endsection Unsorted8095CDSection


    .section Unsorted809903Section

      .al
      .xl

      rlUnknown809903 ; 80/9903

        .al
        .xl
        .autsiz
        .databank ?

        php
        phb
        phk
        plb
        .databank $80
        sep #$10
        rep #$20
        lda $04FA,b
        beq _9930
        ldx $04F4,b
        bne _9930
        ldx #$00
        stx $04F5,b
        ldx $04FC,b
        stx $04F4,b
        rep #$10
        ldx $04B8,b
        stx lR39+1
        sta lR39
        jsl rlUnknown8091B3
        stz $04FA,b

        _9930
        plb
        .databank $80
        plp
        rtl

        .databank 0

        ; 80/9933

    .endsection Unsorted809903Section


    .section Unsorted809933Section

      .al
      .xl

      rlUnknown809933 ; 80/9933

        .al
        .autsiz
        .databank ?

        php
        phb
        phk
        plb
        sep #$20
        lda $04CA,b,x
        beq _End

        cmp $04D0,b,x
        beq _995D

        cmp #$10
        bne +

        stz $04CA,b,x
        bra _9976

        +
        sta $04D0,b,x
        xba
        lda $04CB,b,x
        lsr a
        lsr a
        lsr a
        cmp #$10
        bcs _9975

        inc a
        bra _9975
        
        _995D
        cpx $04F7,b
        bne _End

        lda #1
        xba
        lda $04CB,b,x
        lsr a
        lsr a
        lsr a
        cmp #$10
        bcs +

        inc a
        
        +
        ora #$80
        ora $04CC,b,x

        _9975
        xba
        
        _9976
        rep #$20
        cpx #0
        beq +

          clc
          adc #$0010

        +
        jsl rlUnknown808FDD
        
        _End
        plb
        plp
        rtl

        .databank 0

        ; 80/9988

    .endsection Unsorted809933Section


    .section Unsorted809B01Section

      .al
      .xl

      aUnknown809B01 ; 80/9B01

        .long $809B00
        .long $868010
        .long $868011
        .long $86803E
        .long $91D616
        .long $91D617
        .long $91D61B
        .long $898000
        .long $898004
        .long $8980E0
        .long $8A8000
        .long $8A800E
        .long $8A8061
        .long $8B96CF
        .long $8B96E5
        .long $8B9717
        .long $81A800
        .long $81A813
        .long $81A89D ; event main loop routine?
        .long $8BA7CB
        .long $8BA7CC
        .long $8BA7CD
        .long $80C1A0
        .long $80C1CA
        .long $95E5C9
        .long $95E5DB
        .long $9BDC24
        .long $9BDCBB
        .long $9FFACC
        .long $9FFACC
        .long $9FFACC
        .long $9FFACC
        .long $8BA851
        .long $8BA7F2
        .long $8BA81F
        .long $89B883
        .long $89B3D7
        .long $89B3E7
        .long $89E7EA
        .long $89E7BD
        .long $89E7CC
        .long $89ECC7
        .long $89EB26
        .long $89EB40
        .long $8BD8FE
        .long $8BD794
        .long $8BD7AA
        .long $8BD13D
        .long $8BCF0A
        .long $8BCF20
        .long $89B0AA
        .long $89ACCE
        .long $89ACE7
        .long $8DA06A
        .long $8DA06B
        .long $8DA0B7

      rlUnknown809BA9 ; 80/9BA9

        .al
        .autsiz
        .databank ?

        phb

        lda $0302,b
        asl a
        adc $0302,b
        jsr rsUnknown809BC0

        lda $0300,b
        asl a
        adc $0300,b
        jsr rsUnknown809BC0

        plb
        rtl

        .databank 0

      rsUnknown809BC0 ; 80/9BC0

        .al
        .autsiz
        .databank ?

        tax
        sep #$20
        lda aUnknown809B01+2,x
        cmp #$7D
        beq +

          sta $24+2

          pha
          plb

          rep #$20
          lda aUnknown809B01,x
          sta $24
          jsl rlUnknown809BEB
          rep #$30
          rts

        +
        rep #$20
        lda aUnknown809B01,x
        sta $0302,b
        jml $809BDB

        .databank 0

      rlUnknown809BEB ; 80/9BEB

        .al
        .autsiz
        .databank ?

        jml [$24]

        .databank 0

        ; 80/9BEE

    .endsection Unsorted809B01Section


    .section Unsorted809C7ASection

      .al
      .xl

      rlUnknown809C7A ; 80/9C7A

        .al
        .xl
        .autsiz
        .databank ?

        php
        phb
        phk
        plb
        .databank $80
        ldx #$002D

        _9C81
        phx
        lda $0309,b,x
        beq _9C94
        sta $0306,b
        lda $030A,b,x
        sta $0307,b
        jsl $809C9D

        _9C94
        plx
        dec x
        dec x
        dec x
        bpl _9C81
        plb
        .databank ?
        plp
        rtl

        .databank 0

        ; 80/9C9D

      rlUnknown809C9D ; 80/9C9D

        .al
        .xl
        .autsiz
        .databank ?

        jml [$0306]

        .databank 0

        ; 80/9CA0

    .endsection Unsorted809C7ASection


    .section Unsorted809CA0Section

      .al
      .xl

      rsUnknown809CA0 ; 80/9CA0

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$80
        sta $2100,b
        rep #$20
        jsl rlProcessDMAStructArray
        jsl rlDMAPaletteAndOAMBuffer
        jsl rlUnknown8080C3
        jsl rlUnknown8090A2
        jsl rlUnknown808002
        jsl rlIncreaseFrameCounters
        jsl rlClearSpriteExtBuffer
        jsl rlUnknown809BA9
        jsl rlUnknown809C7A
        jsl rlHideSprites
        jsl rlUnknown8095CD
        rts

        .databank 0

        ; 80/9CD6

      rlUnknown809CD6 ; 80/9CD6

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        sep #$30
        stz $4200,b
        stz bBufferNMITIMEN
        lda #$80
        sta bBufferINIDISP
        sta $2100,b
        stz wNextFreeSpriteOffset,b
        stz $1E22,b
        jsl rlClearSpriteExtBuffer
        jsl rlHideSprites
        rep #$30
        jsl rlUnknown80A5D9
        jsr $80A836
        jsl $809BEE
        lda #(`aProcEngineMainProcActionTable)<<8
        sta lR44+1
        lda #<>aProcEngineMainProcActionTable
        sta lR44
        jsl $809C04
        lda #(`aActiveSpriteEngineMainActionTable)<<8
        sta lR44+1
        lda #<>aActiveSpriteEngineMainActionTable
        sta lR44
        jsl $809C04
        lda #(`aHDMAEngineMainActionTable)<<8
        sta lR44+1
        lda #<>aHDMAEngineMainActionTable
        sta lR44
        jsl $809C04
        lda #$8200
        sta lR44+1
        lda #$E000
        sta lR44
        jsl $809C04
        lda #$9100
        sta lR44+1
        lda #$A3A5
        sta lR44
        jsl $809C04
        stz $0300,b
        stz $0302,b
        jml $80AD24

        .databank 0

        ; 80/9D4F

    .endsection Unsorted809CA0Section


    .section Unsorted80A1ABSection

      .al
      .xl

      rlUnknown80A1AB ; 80/A1AB

        .al
        .xl
        .autsiz
        .databank ?

        phx
        php
        phb
        phk
        plb
        .databank $80
        rep #$30
        stz wR10
        lda wR14
        bne _A1BC
        stz wR13
        bra _A1D4


        _A1BC
        ldx #$0011
        clc

        _A1C0
        rol wR13
        dec x
        beq _A1D4
        rol wR10
        lda wR10
        beq _A1C0
        sec
        sbc wR14
        bcc _A1C0
        sta wR10
        bra _A1C0


        _A1D4
        plb
        .databank $80
        plp
        plx
        rtl

        .databank 0

        ; 80/A1D8

      rlUnknown80A1D8 ; 80/A1D8

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        php
        phb
        phk
        plb
        .databank $80
        rep #$30
        stz wR11
        stz wR10
        lda wR15
        ora wR14
        bne _A1F0
        stz wR13
        stz wR12
        bra _A217


        _A1F0
        ldx #$0021
        clc

        _A1F4
        rol wR12
        rol wR13
        dec x
        beq _A217
        rol wR10
        rol wR11
        lda wR11
        ora wR10
        beq _A1F4
        lda wR10
        sec
        sbc wR14
        tay
        lda wR11
        sbc wR15
        bcc _A1F4
        sta wR11
        sty wR10
        bra _A1F4


        _A217
        plb
        .databank $80
        plp
        ply
        plx
        rtl

        .databank 0

        ; 80/A21C

    .endsection Unsorted80A1ABSection


    .section Unsorted80A29ASection

      .al
      .xs

      rlUnknown80A29A ; 80/A29A

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $80
        sep #$20
        sta wScreenFadingTimeIncrement,b
        lda wScreenFadingFlag,b
        bpl _A2B9
        lda wScreenFadingTimeIncrement,b
        sta wScreenFadingTimer,b
        lda #$FF
        sta bBufferCOLDATA_0
        stz bBufferCOLDATA_1
        stz bBufferCOLDATA_2
        stz wScreenFadingFlag,b

        _A2B9
        lda bBufferCOLDATA_0
        and #$1F
        beq _A2D7
        dec wScreenFadingTimer,b
        bne _A2D3
        lda wScreenFadingTimeIncrement,b
        sta wScreenFadingTimer,b
        lda bBufferCOLDATA_0
        and #$1F
        dec a
        ora #$E0
        sta bBufferCOLDATA_0

        _A2D3
        plp
        plb
        .databank $80
        clc
        rtl


        _A2D7
        lda #$FF
        sta wScreenFadingFlag,b
        plp
        plb
        .databank $80
        sec
        rtl

        .databank 0

        ; 80/A2E0

      rlUnknown80A2E0 ; 80/A2E0

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $80
        sep #$20
        sta wScreenFadingTimeIncrement,b
        lda wScreenFadingFlag,b
        bpl _A2FF
        lda wScreenFadingTimeIncrement,b
        sta wScreenFadingTimer,b
        lda #$E0
        sta bBufferCOLDATA_0
        stz bBufferCOLDATA_1
        stz bBufferCOLDATA_2
        stz wScreenFadingFlag,b

        _A2FF
        lda bBufferCOLDATA_0
        and #$1F
        cmp #$1F
        beq _A31F
        dec wScreenFadingTimer,b
        bne _A31B
        lda wScreenFadingTimeIncrement,b
        sta wScreenFadingTimer,b
        lda bBufferCOLDATA_0
        and #$1F
        inc a
        ora #$E0
        sta bBufferCOLDATA_0

        _A31B
        plp
        plb
        .databank $80
        clc
        rtl


        _A31F
        lda #$FF
        sta wScreenFadingFlag,b
        plp
        plb
        .databank $80
        sec
        rtl

        .databank 0

        ; 80/A328

      rlUnknown80A328 ; 80/A328

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $80
        sep #$20
        lda bDMAPendingChannels,b
        sta $420B,b
        stz bDMAPendingChannels,b
        lda bBufferHDMAEN
        ora bHDMAPendingChannels,b
        sta bBufferHDMAEN
        jsl rlHDMAArrayEngineProcessHDMAArray
        lda bBufferHDMAEN
        sta $420C,b
        stz bBufferHDMAEN
        stz bHDMAPendingChannels,b
        plp
        plb
        .databank $80
        rtl

        .databank 0

        ; 80/A34F

    .endsection Unsorted80A29ASection


    .section Unsorted80A5D9Section

      .as
      .xl

      rlUnknown80A5D9 ; 80/A5D9

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        php
        rep #$20
        stz aDecompressionArray,b
        stz wDecompressionArrayPosition,b
        sep #$20
        stz bDecompressionArrayFlag,b
        plp
        rtl

        .databank 0

        ; 80/A5E9

    .endsection Unsorted80A5D9Section


    .section Unsorted80A861Section

      .al
      .xl

      rlUnknown80A861 ; 80/A861

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phy

        clc
        adc $0000,b,x
        tay
        sep #$20
        lda $0002,b,x
        pha
        rep #$20
        plb

        lda $0000,b,y
        ora $0001,b,y
        beq +

          lda $0000,b,y
          sta lR23
          lda $0001,b,y
          sta lR23+1
          jsl rlUnknown80A88E

        +
        ply
        plp
        plb
        rtl

        .databank 0

      rlUnknown80A88E ; 80/A88E

        .al
        .autsiz
        .databank ?

        sep #$20
        lda lR23+2
        pha
        rep #$20
        plb
        jml [lR23]

        ora #0
        beq +

          phx
          dec a
          asl a
          tax
          lda $80A8A8,x
          plx

        +
        rtl

        .databank 0

        ; 80/A8A8

    .endsection Unsorted80A861Section


    .section Unsorted80A9F2Section

      .al
      .xl

      rlUnknown80A9F2 ; 80/A9F2

        ; Runs on into built code at the end.
        .al
        .xl
        .autsiz
        .databank ?

        php
        phb
        rep #$30
        ldy DecompressionVariables
        stz DecompressionVariables
        sep #$20
        lda #$01
        sta $D2
        bra $80AA21

        .databank 0

        ; 80/AA02

    .endsection Unsorted80A9F2Section


    .section Unsorted80B0A3Section

      .al
      .xl

      rlUnknown80B0A3 ; 80/B0A3

        .al
        .xl
        .autsiz
        .databank ?

        lda #$5AFA
        sta $0108,b
        lda #$4695
        sta $010A,b
        lda #$0C85
        sta $010C,b
        lda #$5AF8
        sta $010E,b
        rtl

        .databank 0

        ; 80/B0BC

      rlUnknown80B0BC ; 80/B0BC

        .al
        .xl
        .autsiz
        .databank ?

        lda #$8000
        sta lR19+1
        lda #$B0CB
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        rtl

        .databank 0

        ; 80/B0CB

    .endsection Unsorted80B0A3Section


    .section Unsorted80B0D3Section

      .al
      .xl

      rlUnknown80B0D3 ; 80/B0D3

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$C000
        sta lR18+1
        lda #$0A2B
        sta lR18
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        sta lR19
        jsl rlAppendDecompList
        plx
        rtl

        .databank 0

        ; 80/B0EE

      rlUnknown80B0EE ; 80/B0EE

        .al
        .xl
        .autsiz
        .databank ?

        lda #$8000
        sta lR19+1
        lda #$B0FD
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        rtl

        .databank 0

        ; 80/B0FD

    .endsection Unsorted80B0D3Section


    .section Unsorted80B1E1Section

      .as
      .xl

      rsUnknown80B1E1 ; 80/B1E1

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        php
        sep #$20
        lda #$80
        sta bBufferINIDISP
        sta $2100,b
        rep #$20
        jsl rlDisableVBlank
        jsl rlHardwareResetScreenPosMathHDMA
        jsl rlHardwareResetScreenRegisters
        lda #$0000
        sta wR1
        sta wR2
        lda #$4000
        sta wR3
        sta wR4
        lda #$6000
        sta wR5
        lda #$5000
        sta wR6
        lda #$5400
        sta wR7
        lda #$5800
        sta wR8
        jsl rlSetLayerPositionsAndSizes
        jsl rlClearSpriteExtBuffer
        jsl rlHideSprites
        jsl rlDMAPaletteAndOAMBuffer
        jsl rlProcEngineResetProcEngine
        jsl rlActiveSpriteEngineReset
        jsl rlResetHDMAEngine
        jsl rlUnknown82E073
        jsl rlUnknown82E400
        jsl rlUnknown8780AA
        sep #$20
        rep #$10
        ldx #$2B6B
        stx DecompressionVariables
        lda #$C0
        sta $CA
        ldx #$8B88
        stx $CB
        lda #$7E
        sta $CD
        rep #$30
        jsl rlDecompressor
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $0DC0, $80, $0000

        sep #$20
        rep #$10
        ldx #$3455
        stx DecompressionVariables
        lda #$C0
        sta $CA
        ldx #$8B88
        stx $CB
        lda #$7E
        sta $CD
        rep #$30
        jsl rlDecompressor
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $0800, $80, $A000

        sep #$20
        rep #$10
        ldx #$3558
        stx DecompressionVariables
        lda #$C0
        sta $CA
        ldx #$8B88
        stx $CB
        lda #$7E
        sta $CD
        rep #$30
        jsl rlDecompressor
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $0800, $80, $A800

        stz wBufferBG1HOFS
        stz wBufferBG1VOFS
        stz wBufferBG2HOFS
        stz wBufferBG2VOFS
        sep #$20
        lda #$03
        sta bBufferTM
        rep #$20
        lda #$8700
        sta lR44+1
        lda #$C5A2
        sta lR44
        jsl rlProcEngineCreateProc
        lda #$AE68
        sta wVBlankPointer
        lda #$B301
        sta wMainLoopPointer
        stz $0300,b
        stz $0302,b
        stz $0304,b
        sep #$20
        lda #$00
        sta bBufferINIDISP
        sta $2100,b
        rep #$20
        jsl rlEnableVBlank
        plp
        cli
        rts

        .databank 0

        ; 80/B301

      rsUnknown80B301 ; 80/B301

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlButtonCombinationResetCheck
        jsl rlDecompressByList
        jsl rlUnknown869D1B
        jsl rlUnknown809903
        jsl rlUnknown91A80D
        rts

        .databank 0

        ; 80/B316

    .endsection Unsorted80B1E1Section


    .section Unsorted80B347Section

      .al
      .xl

      rsUnknown80B347 ; 80/B347

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$80
        sta $2100,b
        rep #$20
        jsl rlUnknown8887EC
        jsl rlProcessDMAStructArray
        jsl rlDMAPaletteAndOAMBuffer
        jsl rlUnknown80A328
        jsl rlUnknown8080C3
        jsl rlUnknown8090A2
        jsl rlUnknown808002
        jsl rlIncreaseFrameCounters
        jsl rlClearSpriteExtBuffer
        jsl rlUnknown809BA9
        jsl $809C7A
        lda wMapScrollXPixels,b
        sta wBufferBG1HOFS
        and #$000F
        sec
        sbc #$0008
        sta wBufferBG3HOFS
        lda wMapScrollYPixels,b
        sta wBufferBG1VOFS
        sta wBufferBG3VOFS
        jsl rlHideSprites
        jsl rlUnknown9181F6
        jsl rlUnknown878256
        jsl $8095CD
        rts

        .databank 0

        ; 80/B3A2

      rsUnknown80B3A2 ; 80/B3A2

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        php
        sep #$20
        lda #$80
        sta bBufferINIDISP
        sta $2100,b
        rep #$20
        jsl rlDisableVBlank
        jsl rlHardwareResetScreenPosMathHDMA
        jsl rlHardwareResetScreenRegisters
        lda #$0000
        sta wR1
        lda #$3000
        sta wR2
        lda #$4000
        sta wR3
        sta wR4
        lda #$6000
        sta wR5
        lda #$5000
        sta wR6
        lda #$5400
        sta wR7
        lda #$5800
        sta wR8
        jsl rlSetLayerPositionsAndSizes
        jsl rlClearUnitWindowAndTerrainWindowProcs
        jsl rlActiveSpriteEngineReset
        jsl rlResetHDMAEngine
        jsl rlUnknown82E073
        jsl rlUnknown82E400
        jsl rlUnknown8780AA
        jsl rlUnknown82F211
        jsl rlResetDialogueEngine
        lda #$8B00
        sta lR44+1
        lda #$9449
        sta lR44
        jsl rlUnknown82E0C6
        lda #$8B00
        sta lR44+1
        lda #$9594
        sta lR44
        jsl rlUnknown82E0C6
        jsl rlUnknown82E08D
        lda #$000E
        sta $0302,b
        lda #$000D
        sta $0300,b
        stz $0304,b
        lda #$B347
        sta wVBlankPointer
        lda #$9D4F
        sta wMainLoopPointer
        jsl rlUnknown80B452
        jsl rlUnknown88CD61
        jsl rlEnableVBlank
        sep #$20
        lda #$00
        sta bBufferINIDISP
        rep #$20
        plp
        rts

        .databank 0

        ; 80/B452

      rlUnknown80B452 ; 80/B452

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phk
        plb
        .databank $80
        rep #$30
        lda #$1809
        sta $4300,b
        lda #$8000
        sta $4303,b
        lda #$B61D
        sta $4302,b
        lda #$2000
        sta $4305,b
        lda #$3000
        sta $2116,b
        sep #$20
        lda #$01
        sta $420B,b
        rep #$20
        phk
        plb
        .databank $80
        rep #$30
        lda #$1809
        sta $4300,b
        lda #$8000
        sta $4303,b
        lda #$B61D
        sta $4302,b
        lda #$2000
        sta $4305,b
        lda #$4000
        sta $2116,b
        sep #$20
        lda #$01
        sta $420B,b
        rep #$20
        lda #$03FF
        sta wUnknown000596,b
        lda #$0002
        sta $18D0,b
        lda #$8000
        sta lR19+1
        lda #$B61E
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        sep #$20
        rep #$10
        ldx #$0E19
        stx DecompressionVariables
        lda #$D1
        sta $CA
        ldx #$2400
        stx $CB
        lda #$7F
        sta $CD
        rep #$30
        jsl rlDecompressor
        sep #$20
        rep #$10
        ldx #$173E
        stx DecompressionVariables
        lda #$D1
        sta $CA
        ldx #$0000
        stx $CB
        lda #$7F
        sta $CD
        rep #$30
        jsl rlDecompressor
        ldx #$07FE
        lda #$00FF

        _B500
        sta $7E7B88,x
        sta aBG3TilemapBuffer,x
        dec x
        dec x
        bpl _B500
        lda #$8000
        sta lR19+1
        lda #$B626
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        jsl rlDMAByStruct

          .structDMAToVRAM $7E7B88, $0800, $80, $A800

        jsl rlDMAByStruct

          .structDMAToVRAM $7E7B88, $0800, $80, $9800

        jsl rlDMAByStruct

          .structDMAToVRAM $D97940, $01C0, $80, $9D40

        lda #$8000
        sta lR19+1
        lda #$B62E
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        jsl rlDMAByStruct

          .structDMAToVRAM $D96C00, $0800, $80, $B000

        lda #$8000
        sta lR19+1
        lda #$B636
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        ldx #$01FE

        _B56D
        lda $8CDC00,x
        sta aBGPaletteBuffer,b,x
        dec x
        dec x
        bpl _B56D
        lda #$0000
        sta aBGPaletteBuffer,b
        sep #$20
        lda #$08
        sta bBufferWH0
        lda #$F8
        sta bBufferWH1
        stz bBufferWH2
        stz bBufferWH3
        lda #$33
        sta bBufferW12SEL
        sta bBufferW34SEL
        lda #$11
        sta bBufferTM
        lda #$14
        sta bBufferTS
        lda bBufferBG1SC
        and #$FC
        sta bBufferBG1SC
        lda bBufferBG3SC
        and #$FC
        ora #$01
        sta bBufferBG3SC
        lda #$54
        sta bBufferBG2SC
        lda #$03
        sta bBufferWOBJSEL
        rep #$20
        sep #$20
        lda #$13
        sta bBufferTM
        sta bBufferTMW
        lda #$16
        sta bBufferTS
        sta bBufferTSW
        lda #$02
        sta bBufferCGWSEL
        lda #$81
        sta bBufferCGADSUB
        rep #$20
        lda wMapXOffset,b
        sta wMapScrollXPixels,b
        lda wMapYOffset,b
        sta wMapScrollYPixels,b
        lda #$0004
        sta wUnknown00075C,b
        sta $075E,b
        lda #$0000
        sta wMapMinXScroll,b
        sta wMapMinYScroll,b
        lda #$0400
        sec
        sbc #$0100
        sta wMapMaxXScroll,b
        lda #$0400
        sec
        sbc #$00E0
        sta wMapMaxYScroll,b
        lda #$0000
        sta wBufferBG2VOFS
        sta wBufferBG2VOFS
        stz $087B,b
        stz wMapScrollDirectionIdentifier,b
        jsl rlUnknown8883C8
        lda #$8B00
        sta lR44+1
        lda #$911F
        sta lR44
        jsl rlHDMAEngineCreateEntry
        rtl

        .databank 0

        ; 80/B61C

    .endsection Unsorted80B347Section


    .section Unsorted80B9ADSection

      .al
      .xl

      rlUnknown80B9AD ; 80/B9AD

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0C37
        lda #$0000

        _B9B3
        sta aMovementMap,x
        dec x
        dec x
        bpl _B9B3
        rtl

        .databank 0

        ; 80/B9BC

    .endsection Unsorted80B9ADSection


    .section Unsorted80B9E1Section

      .al
      .xl

      rsUnknown80B9E1 ; 80/B9E1

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        stz bBufferW12SEL
        stz bBufferW34SEL
        stz bBufferWOBJSEL
        lda #$16
        sta bBufferTM
        lda #$00
        sta bBufferTS
        lda bBufferBGMODE
        and #$FF
        sta bBufferBGMODE
        lda #$00
        sta bBufferCGWSEL
        lda #$82
        sta bBufferCGADSUB
        rep #$20
        rts

        .databank 0

        ; 80/BA02

    .endsection Unsorted80B9E1Section


    .section Unsorted80BA02Section

      .al
      .xl

      rlUnknown80BA02 ; 80/BA02

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda $089B,b
        cmp #$FFFF
        beq _BA36
        sta wSelectedUnitDataRAMPointer,b
        lda #$0006
        sta bEventActionIdentifier,b
        jsl rlGetSelectedUnitCharacterID
        sta wEventEngineArgument1,b
        lda $089F,b
        sta wEventEngineArgument2,b
        jsl rlGetAndRunChapterMapEventConditions
        bcc _BA36
        lda wSelectedUnitDataRAMPointer,b
        sta $08BA,b
        lda #$0002
        sta $0304,b
        inc $0302,b
        rtl


        _BA36
        lda @l $00089B
        sta wSelectedUnitDataRAMPointer,b
        jsl rlUnknown8A9D39
        jsl rlUnknown80BA52
        jsl rlGetSelectedUnitCharacterID
        jsl rlUnknown8A9776
        jsl rlUnknown8A94E2
        rtl

        .databank 0

        ; 80/BA52

    .endsection Unsorted80BA02Section


    .section Unsorted80BA52Section

      .al
      .xl

      rlUnknown80BA52 ; 80/BA52

        .al
        .xl
        .autsiz
        .databank ?

        rep #$20
        jsl rlUnknown8881EC
        jsl rlDMAByStruct

          .structDMAToVRAM $D80000, $2000, $80, $0000

        jsl rlDMAByStruct

          .structDMAToVRAM $DE40C0, $0400, $80, $C000

        jsl rlDMAByStruct

          .structDMAToVRAM $D76800, $0800, $80, $9800

        lda #$8000
        sta lR19+1
        lda #$BB45
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        lda #$8000
        sta lR19+1
        lda #$BB55
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        lda #$8000
        sta lR19+1
        lda #$BB4D
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        ldx #$07FE
        lda #$00FF

        _BAAF
        lda aUnknownD77000,x
        sta aBG3TilemapBuffer,x
        dec x
        dec x
        bpl _BAAF
        lda #$8000
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$B6AD
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$3000
        sta aCurrentTilemapInfo,b
        jsl rlGetEventLocationEntryCastleName
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$010C
        jsl rlDrawMenuTextLine
        jsl rlUnknown8A9858
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0700, $80, $B000

        ldx #$01FE

        _BAF6
        lda aUnknown8C9A00,x
        sta aBGPaletteBuffer,b,x
        dec x
        dec x
        bpl _BAF6
        ldx #$001E

        _BB04
        lda aUnknown8C9D00,x
        sta aOAMPaletteBuffer,b,x
        dec x
        dec x
        bpl _BB04
        sep #$20
        lda #$03
        sta bBufferWOBJSEL
        lda #$16
        sta bBufferTM
        lda #$00
        sta bBufferTS
        lda #$82
        sta bBufferCGADSUB
        rep #$20
        stz wBufferBG2VOFS
        lda #$0003
        sta $0891,b
        lda #$8A00
        sta lR44+1
        lda #$9C56
        sta lR44
        jsl rlHDMAEngineCreateEntry
        jsr rsUnknown80B9E1
        lda #$0001
        sta $0304,b
        rtl

        .databank 0

        ; 80/BB43

    .endsection Unsorted80BA52Section


    .section Unsorted80C1CBSection

      .al
      .xs

      rlUnknown80C1CB ; 80/C1CB

        .al
        .autsiz
        .databank ?

        phb
        sta wR0

        lda wUnknown00171A,b
        bne _SEC

          stz wUnknown00171C,b

          lda wR0
          cmp #$0232
          bcs _SEC

            sta wUnknown001732,b
            asl a
            clc
            adc wUnknown001732,b
            tax

            lda $8FE8BF,x
            sta lR18
            lda $8FE8BF+1,x
            sta lR18+1
            jsl rlUnknown80C1FC
            clc
            bra +

        _SEC
        sec

        +
        plb
        rtl

        .databank 0

      rlUnknown80C1FC ; 80/C1FC

        .al
        .autsiz
        .databank ?

        phb
        lda lR18
        sta lActiveEventPointer,b
        lda lR18+1
        sta lActiveEventPointer+1,b

        stz wActiveEventOffset,b

        lda #9
        sta wUnknown00171A,b
        plb
        rtl

        .databank 0

        ; 80/C212

    .endsection Unsorted80C1CBSection


    .section Unsorted80C212Section

      .al
      .xl

      rsUnknown80C212 ; 80/C212

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $80
        sep #$30
        lda #$80
        sta bBufferINIDISP
        sta $2100,b
        lda #$00
        sta $2101,b
        sta bBufferOBSEL
        lda #$10
        sta $2102,b
        sta wBufferOAMADD
        lda #$00
        sta $2103,b
        sta wBufferOAMADD+1
        stz $2104,b
        stz $2104,b
        lda #$09
        sta $2105,b
        sta bBufferBGMODE
        stz $2106,b
        stz bBufferMOSAIC
        lda #$00
        sta $2107,b
        sta bBufferBG1SC
        sta $2108,b
        sta bBufferBG2SC
        lda #$00
        sta $2109,b
        sta bBufferBG3SC
        stz $210A,b
        stz bBufferBG4SC
        stz $210B,b
        stz bBufferBG12NBA
        stz $210C,b
        stz bBufferBG34NBA
        stz $210D,b
        stz $210D,b
        stz $210E,b
        stz $210E,b
        stz $210F,b
        stz $210F,b
        stz $2110,b
        stz $2110,b
        stz $2111,b
        stz $2111,b
        stz $2112,b
        stz $2112,b
        stz $2113,b
        stz $2113,b
        stz $2114,b
        stz $2114,b
        stz $2115,b
        stz $211A,b
        stz bBufferM7SEL
        stz $211B,b
        stz $211C,b
        stz $211D,b
        stz $211E,b
        stz $211F,b
        stz $2120,b
        lda #$00
        sta $2123,b
        sta bBufferW12SEL
        lda #$00
        sta $2124,b
        sta bBufferW34SEL
        stz $2125,b
        stz bBufferWOBJSEL
        lda #$00
        sta $2126,b
        sta bBufferWH0
        lda #$F8
        sta $2127,b
        sta bBufferWH1
        stz $2128,b
        stz bBufferWH2
        stz $2129,b
        stz bBufferWH3
        stz $212A,b
        stz bBufferWBGLOG
        stz $212B,b
        stz bBufferWOBJLOG
        lda #$00
        sta $212C,b
        sta bBufferTM
        sta $212E,b
        sta bBufferTMW
        lda #$00
        sta $212D,b
        sta bBufferTS
        sta $212F,b
        sta bBufferTSW
        lda #$02
        sta $2130,b
        sta bBufferCGWSEL
        lda #$A1
        sta $2131,b
        sta bBufferCGADSUB
        lda #$20
        sta $2132,b
        sta bBufferCOLDATA_1
        lda #$40
        sta $2132,b
        sta bBufferCOLDATA_2
        lda #$80
        sta $2132,b
        sta bBufferCOLDATA_3
        lda #$00
        sta $2133,b
        sta bBufferSETINI
        plp
        plb
        .databank $80
        rts

        .databank 0

        ; 80/C32C

    .endsection Unsorted80C212Section


    .section Unsorted80C39ASection

      .as
      .xs

      rsUnknown80C39A ; 80/C39A

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        php
        sep #$20
        lda #$80
        sta bBufferINIDISP
        sta $2100,b
        rep #$20
        jsl rlDisableVBlank
        jsl rlHardwareResetScreenPosMathHDMA
        jsr rsUnknown80C212
        jsl rlUnknown80C32C
        jsl rlUnknown82E400
        jsl rlUnknown8780AA
        lda #$0016
        sta $0302,b
        stz $0304,b
        stz $0300,b
        lda #$C162
        sta wVBlankPointer
        lda #$9D4F
        sta wMainLoopPointer
        jsl rlEnableVBlank
        jsl $80825B
        plp
        rts

        .databank 0

        ; 80/C3DD

    .endsection Unsorted80C39ASection


    .section Unsorted80E42BSection

      .al
      .xs

      rsUnknown80E42B ; 80/E42B

        .al
        .autsiz
        .databank ?

        php
        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20

        lda #<>$80BB9B
        sta $D3

        jsl rlUnknown80823F
        jsl rlDisableVBlank

        jsl rlHardwareResetScreenPosMathHDMA
        jsl rlHardwareResetScreenRegisters

        stz wR0
        stz wR2
        stz wR4
        stz wR7
        stz wR9

        lda #0
        sta wR5
        lda #0
        sta wR1
        lda #$4000
        sta wR3
        lda #$6000
        sta wR6
        lda #$7000
        sta wR8

        jsl rlSetLayerPositionsAndSizes
        jsl rlProcEngineResetProcEngine
        jsl rlActiveSpriteEngineReset
        jsl rlResetHDMAEngine
        jsl rlUnknown82E073
        jsl rlUnknown82E400
        jsl rlUnknown8780AA
        jsl rlUnknown82F211

        jsr rsUnknown80E4B3
        jsr rsUnknown80E4EB
        jsr rsUnknown80E54D

        lda $7F8400
        sta $0304,b

        lda #$0027
        sta $0302,b
        lda #$0026
        sta $0300,b

        lda #<>rsUnknown809D4F
        sta $D7

        jsl rlEnableVBlank

        plp
        rts

        .databank 0

      rsUnknown80E4B3 ; 80/E4B3

        .al
        .autsiz
        .databank ?

        lda $7F8183
        sta $7F8404

        lda #0
        sta $7F8402
        sta $7F8410
        sta $7F8412
        sta $7F840A
        sta $7F840C
        sta $7F8408

        lda #(`$80E422)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>$80E422
        sta lMapMenuTilemapRAMEntryPointer,b
        jsl rlGetSelectedUnitFactionSlot
        sta $7F840E
        rts

        .databank 0

      rsUnknown80E4EB ; 80/E4EB

        .al
        .xl
        .autsiz
        .databank ?

        ; Gets debug BG, pal and tilemap

        ; DMA graphics with pointing hand, promotion indicator, droppable item icon, arrows and a star

        jsl rlDMAByStruct

          .dstruct structDMAToVRAM, $DE44C0, $0400, $80, $0000

        lda #(`aUnknown80E53D)<<8
        sta lR19+1
        lda #<>aUnknown80E53D
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        jsl rlUnknown899FDC

        ldx #$0200  
        
        -
        lda $DDFFFE,x
        sta $FE,x
        dec x
        dec x
        bne -

        ; Clear the tilemap
        lda #0
        sta $0100,b
        jsl rlUnknown8BB45D

         ; DMA clean tilemap
        jsl rlDMAByStruct

          .dstruct structDMAToVRAM, aBG3TilemapBuffer, $0800, $80, $E000

        lda #(`aUnknown80E545)<<8
        sta lR19+1
        lda #<>aUnknown80E545
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        rts

        .databank 0

      aUnknown80E53D ; 80/E53D

        .word $1800
        .word $4000
        .word $2B01
        .word $C00A

      aUnknown80E545 ; 80/E545

        .word $0800
        .word $6000
        .word $2001
        .word $DD3F

      rsUnknown80E54D ; 80/E54D

        .al
        .autsiz
        .databank ?

        sep #$20
        lda bBufferBG1SC
        and #$FC
        ora #$02
        sta bBufferBG1SC

        lda bBufferBG3SC
        and #$FC
        ora #$02
        sta bBufferBG3SC

        lda #$15
        sta bBufferTM
        lda #0
        sta bBufferWH0
        sta bBufferWH2
        sta bBufferWH3
        lda #$FF
        sta bBufferWH1
        lda #0
        sta bBufferCGWSEL
        lda #$81
        sta bBufferCGADSUB
        rep #$20

        stz wBufferBG1HOFS
        stz wBufferBG1VOFS
        stz wBufferBG2HOFS
        stz wBufferBG2VOFS
        stz wBufferBG3HOFS
        stz wBufferBG3VOFS
        rts

        .databank 0

        ; 80/E586

    .endsection Unsorted80E42BSection


    .section Unsorted80F2BESection

      .al
      .xl

      rsUnknown80F2BE ; 80/F2BE

        .al
        .autsiz
        .databank ?

        ; Transition from WM to map?

        php
        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20

        lda #$BB9B
        sta wVBlankPointer
        jsl rlUnknown80823F
        jsl rlDisableVBlank
        jsl rlHardwareResetScreenPosMathHDMA
        jsl rlHardwareResetScreenRegisters

        lda #0
        sta wR1
        lda #$4000
        sta wR2
        lda #$5000
        sta wR6
        lda #$6000
        sta wR7
        jsl rlSetLayerPositionsAndSizes

        jsl rlProcEngineResetProcEngine
        jsl rlActiveSpriteEngineReset
        jsl rlResetHDMAEngine
        jsl rlUnknown82E073
        jsl rlUnknown82E400
        jsl rlUnknown8780AA
        jsl rlUnknown82F211

        jsr rsUnknown80F340
        jsr rsUnknown80F392
        jsr rsUnknown80F4EB

        lda #$0024
        sta $0304,b
        lda #5
        sta $0302,b
        lda #4
        sta $0300,b

        lda #<>rsUnknown809D4F
        sta wMainLoopPointer

        jsl rlEnableVBlank

        plp
        cli
        rts

        .databank 0

        ; 80/F337

    .endsection Unsorted80F2BESection


    .section Unsorted80F340Section

      .al
      .xl

      rsUnknown80F340 ; 80/F340

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta $7F8183
        sta $7F8185
        sta $7F818B
        lda #$8000
        sta lR44+1
        lda #$F36C
        sta lR44
        jsl rlHDMAEngineCreateEntry
        lda #$8000
        sta lR44+1
        lda #$F37F
        sta lR44
        jsl rlHDMAEngineCreateEntry
        rts

        .databank 0

        ; 80/F36C

    .endsection Unsorted80F340Section


    .section Unsorted80F377Section

      .al
      .xl

      rlUnknown80F377 ; 80/F377

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown91F959
        rtl

        .databank 0

        ; 80/F37C

      rlUnknown80F37C ; 80/F37C

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 80/F37D

    .endsection Unsorted80F377Section


    .section Unsorted80F38ASection

      .al
      .xl

      rlUnknown80F38A ; 80/F38A

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown91F9DD
        rtl

        .databank 0

        ; 80/F38F

      rlUnknown80F38F ; 80/F38F

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 80/F390

    .endsection Unsorted80F38ASection


    .section Unsorted80F392Section

      .al
      .xl

      rsUnknown80F392 ; 80/F392

        .al
        .xl
        .autsiz
        .databank ?

        lda #$8000
        sta lR19+1
        lda #$F42B
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        lda #$8000
        sta lR19+1
        lda #$F433
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        ldx #$0100

        _F3B1
        lda aUnknownDD7EAE,x
        sta wJoy2RepeatTimer,x
        dec x
        dec x
        bne _F3B1
        ldx #$0020

        _F3BE
        lda aUnknownDD7F6E,x
        sta $01DE,b,x
        dec x
        dec x
        bne _F3BE
        lda #$0053
        jsl rlUnknown8BB45D
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $1000, $80, $A000

        lda #$DD00
        sta lR18+1
        lda #$629E
        sta lR18
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        sta lR19
        jsl rlAppendDecompList
        lda wCurrentChapter,b
        cmp #$000C
        bmi _F3FF

        _F3FD
        bra _F3FD


        _F3FF
        asl a
        tax
        jsr ($80F413,x)
        lda #$8000
        sta lR19+1
        lda #$F43B
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        rts

        .databank 0

        ; 80/F413

    .endsection Unsorted80F392Section


    .section Unsorted80F4EBSection

      .al
      .xl

      rsUnknown80F4EB ; 80/F4EB

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda bBufferBG1SC
        and #$FC
        ora #$01
        sta bBufferBG1SC
        lda bBufferBG2SC
        and #$FC
        sta bBufferBG2SC
        lda #$01
        sta bBufferTM
        lda #$02
        sta bBufferTS
        lda #$00
        sta bBufferTMW
        lda #$00
        sta bBufferTSW
        lda #$00
        sta bBufferW12SEL
        lda #$00
        sta bBufferW34SEL
        lda #$00
        sta bBufferWOBJSEL
        lda #$00
        sta bBufferWH0
        lda #$FF
        sta bBufferWH1
        lda #$00
        sta bBufferWH2
        sta bBufferWH3
        lda #$00
        sta bBufferWBGLOG
        sta bBufferWOBJLOG
        lda #$02
        sta bBufferCGWSEL
        lda #$01
        sta bBufferCGADSUB
        rep #$20
        stz wBufferBG1HOFS
        stz wBufferBG2HOFS
        stz wBufferBG2VOFS
        stz wBufferBG3HOFS
        stz wBufferBG3VOFS
        stz wBufferBG1VOFS
        rts

        .databank 0

        ; 80/F542

    .endsection Unsorted80F4EBSection


    .section Unsorted80F542Section

      .al
      .xl

      rsUnknown80F542 ; 80/F542

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlButtonCombinationResetCheck
        jsl rlDecompressByList
        jsl rlUnknown809903
        jsl rlHandleSaveFile
        rts

        .databank 0

        ; 80/F553

      rsUnknown80F553 ; 80/F553

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlDecompressByList
        jsl rlUnknown809903
        jsl rlHandleSaveFile
        rts

        .databank 0

        ; 80/F560

      rsUnknown80F560 ; 80/F560

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda wR0
        pha
        lda wR1
        pha
        lda wR2
        pha
        lda wR3
        pha
        lda wR4
        pha
        lda wR5
        pha
        lda lR18
        pha
        lda lR18+2
        pha
        lda lR19+1
        pha
        sep #$20
        lda #$80
        sta $2100,b
        rep #$20
        jsl rlProcessDMAStructArray
        jsl rlDMAPaletteAndOAMBuffer
        jsl rlUnknown80A328
        jsl rlUnknown8080C3
        jsl rlUnknown8090A2
        jsl rlUnknown808002
        jsl rlIncreaseFrameCounters
        jsl rlClearSpriteExtBuffer
        jsl rlUnknown809BA9
        jsl $809C7A
        jsl rlHideSprites
        jsl $8095CD
        pla
        sta lR19+1
        pla
        sta lR18+2
        pla
        sta lR18
        pla
        sta wR5
        pla
        sta wR4
        pla
        sta wR3
        pla
        sta wR2
        pla
        sta wR1
        pla
        sta wR0
        rts

        .databank 0

        ; 80/F5D0

      rsUnknown80F5D0 ; 80/F5D0

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda wR0
        pha
        lda wR1
        pha
        lda wR2
        pha
        lda wR3
        pha
        lda wR4
        pha
        lda wR5
        pha
        lda lR18
        pha
        lda lR18+2
        pha
        lda lR19+1
        pha
        sep #$20
        lda #$80
        sta $2100,b
        rep #$20
        jsl rlProcessDMAStructArray
        jsl rlDMAPaletteAndOAMBuffer
        jsl rlUnknown80A328
        jsl rlUnknown8080C3
        jsl rlUnknown8090A2
        jsl rlUnknown808002
        pla
        sta lR19+1
        pla
        sta lR18+2
        pla
        sta lR18
        pla
        sta wR5
        pla
        sta wR4
        pla
        sta wR3
        pla
        sta wR2
        pla
        sta wR1
        pla
        sta wR0
        rts

        .databank 0

        ; 80/F628

    .endsection Unsorted80F542Section


    .section TableDD7EAESection

      .al
      .xl

      aUnknownDD7EAE ; DD/7EAE

        ; Read by rsUnknown80F392.

        .word $0000, $0001, $318B, $7FFF, $1484, $420F, $296E, $56D6
        .word $0C84, $0000, $02FC, $5AF1, $528F, $524E, $4E2D, $4A0C
        .word $04A7, $3000, $41EE, $04A2, $7314, $7EF8, $3DAC, $1CA2
        .word $7314, $7FFF, $2E29, $77FC, $0441, $7FFF, $35CF, $0086
        .word $4252, $3000, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF, $62B1
        .word $5A8F, $0000, $02FC, $4EAE, $52CF, $528E, $4E6D, $4A4C
        .word $04A7, $7FFF, $420F, $7FFF, $7FFA, $7FFF, $7FFF, $7FFF
        .word $7FFF, $0000, $02FC, $0D4C, $092A, $0509, $04E8, $04C8
        .word $10A6, $3000, $0000, $1084, $1CE7, $35AD, $3DEF, $4210
        .word $4A52, $5294, $5EF7, $6318, $7FFF, $5000, $5000, $5000
        .word $5000, $4001, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF
        .word $7FFF, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF

        ; DD/7F6E

    .endsection TableDD7EAESection


    .section TableDD7F6ESection

      .al
      .xl

      aUnknownDD7F6E ; DD/7F6E

        ; Read by rsUnknown80F392.

        .word $7FFF, $0001, $00AF, $00AE, $008D, $008C, $008B, $006A
        .word $0069, $0068, $0047, $0045, $0044, $0023, $0022, $0001
        .word $0000, $4001, $4C00, $5400, $5C00, $6400, $6C00, $7400
        .word $7C00, $0800, $1000, $1800, $2000, $2800, $3000, $3800
        .word $4000

        ; DD/7FB0

    .endsection TableDD7F6ESection


    .section TableF77C08Section

      .al
      .xl

      aUnknownF77C08 ; F7/7C08

        ; Read by rsUnknown8093C6.

        .word $9B32, $9C62

        ; F7/7C0C

    .endsection TableF77C08Section


    .section TableF77C0CSection

      .al
      .xl

      aUnknownF77C0C ; F7/7C0C

        ; Read by rlUnknown808EF6, rlUnknown8091B3.

        .word $7C16, $AF2C, $AD8C

        ; F7/7C12

    .endsection TableF77C0CSection
