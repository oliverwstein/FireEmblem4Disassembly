; Code from bank $80 not yet assigned to a game system.

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


    .section Unsorted808C50Section

      .al
      .xl

      rlUnknown808C50 ; 80/8C50

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
        jsr rlUnknown808C50
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
        lda $F77C00
        tay
        lda $F77C01
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
        lda $F77C0E
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
        jsr rlUnknown8093C6
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
        adc $F77C0C
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

      rlUnknown8093C6 ; 80/93C6

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
        adc $F77C08
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
        adc $F77C12
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
        adc $F77C08
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
        adc $F77C12
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
        adc $F77C14
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


    .section Unsorted809654Section

      .al
      .xs

      rlUnknown809654 ; 80/9654

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
        pha
        phx
        phy
        lda $04BA,b
        bne _9667
        sta $04C6,b
        bra _9671


        _9667
        ldx #$0000
        jsr rlUnknown809677
        jsl rlUnknown809903

        _9671
        ply
        plx
        pla
        plb
        .databank ?
        plp
        rtl

        .databank 0

        ; 80/9677

      rlUnknown809677 ; 80/9677

        .al
        .xl
        .autsiz
        .databank ?

        ldy lR38
        phy
        ldy lR38+1
        phy
        ldy $04B8,b
        sty lR38+1
        stx $04EE,b
        cmp $04C6,b,x
        beq _96A3
        sta $04C6,b,x
        and #$00FF
        dec a
        asl a
        tay
        lda #$0001
        sta $04C2,b,x
        lda $F77C04
        sta lR38
        lda [lR38],y
        bra _96A6


        _96A3
        lda $04BE,b,x

        _96A6
        tay
        lda $04BA,b,x
        and #$8000
        xba
        sep #$20
        sta $04F5,b
        rep #$20
        dec $04C2,b,x
        bne _96E9
        stz lR38

        _96BC
        lda [lR38],y
        beq _96F0
        inc y
        inc y
        sta $04F8,b
        and #$FC00
        beq _96D7
        xba
        lsr a
        lsr a
        dec a
        asl a
        tax
        lda [lR38],y
        inc y
        inc y
        jsr ($809703,x)

        _96D7
        lda $04F8,b
        and #$03FF
        beq _96BC
        ldx $04EE,b
        sta $04C2,b,x
        tya
        sta $04BE,b,x

        _96E9
        pla
        sta lR38+1
        pla
        sta lR38
        rts


        _96F0
        ldx $04EE,b
        pha
        lda $04BA,b,x
        sta $0510,b,x
        pla
        sta $04BA,b,x
        sta $04C6,b,x
        bra _96E9

        .databank 0

        ; 80/9703

    .endsection Unsorted809654Section


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


    .section Unsorted80AF9BSection

      .al
      .xl

      rsUnknown80AF9B ; 80/AF9B

        .al
        .autsiz
        .databank ?

        jsl rlHardwareResetScreenPosMathHDMA
        jsl rlHardwareResetScreenRegisters
        lda #0
        jsl rlFillBG2Page0TilemapBuffer
        lda #$030F
        jsl rlFillBG2Page1TilemapBuffer
        lda #$00FF
        jsl rlFillBG3Page0TilemapBuffer

        ldx #$067E
        lda #0

          -
          sta $7FDD4A,x
          sta $7FE3CA,x
          dec x
          dec x
          bpl -

        lda #$0000 >> 1
        sta wR1
        sta wR2
        lda #$8000 >> 1
        sta wR3
        sta wR4
        lda #$C000 >> 1
        sta wR5
        lda #$A000 >> 1
        sta wR6
        lda #$A800 >> 1
        sta wR7
        lda #$B000 >> 1
        sta wR8
        jsl rlSetLayerPositionsAndSizes

        jsl rlClearSpriteExtBuffer
        jsl rlHideSprites
        jsl rlDMAPaletteAndOAMBuffer
        jsl rlDMAByStruct
          .structDMAToVRAM aBG2TilemapBuffer.Page1, $0800, $80, $A800

        jsl rlDMAByStruct
          .structDMAToVRAM aBG3TilemapBuffer.Page0, $0800, $80, $B000

        jsl rlClearUnitWindowAndTerrainWindowProcs
        jsl rlActiveSpriteEngineReset
        jsl rlEnableActiveSpriteEngine
        jsl rlResetHDMAEngine
        jsl rlUnknown82E073
        jsl rlUnknown82E400
        jsl rlUnknown8780AA
        jsl rlUnknown82F211
        lda #$00FF
        sta $053E,b
        jsl rlUnknown8780DF
        rts

        .databank 0

        ; 80/B041

    .endsection Unsorted80AF9BSection


    .section Unsorted80B041Section

      .as
      .xl

      rlUnknown80B041 ; 80/B041

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0010
        sta $0300,b
        lda #$AE68
        sta wVBlankPointer
        lda #$B301
        sta wMainLoopPointer
        rts

        .databank 0

        ; 80/B052

      rlUnknown80B052 ; 80/B052

        .al
        .xl
        .autsiz
        .databank ?

        lda #$8100
        sta lR44+1
        lda #$B522
        sta lR44
        jsl rlUnknown82E0C6
        jsl rlUnknown82E08D
        rts

        .databank 0

        ; 80/B065

      rlUnknown80B065 ; 80/B065

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown80B08C
        lda #$8000
        sta lR19+1
        lda #$B084
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        jsl rlUnknown80B0BC
        jsl rlUnknown80B0EE
        jsl rlUnknown80B0A3
        rts

        .databank 0

        ; 80/B084

    .endsection Unsorted80B041Section


    .section Unsorted80B08CSection

      .al
      .xl

      rlUnknown80B08C ; 80/B08C

        .al
        .xl
        .autsiz
        .databank ?

        lda #$8000
        sta lR19+1
        lda #$B09B
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        rtl

        .databank 0

        ; 80/B09B

    .endsection Unsorted80B08CSection


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


    .section Unsorted80B105Section

      .al
      .xl

      rlUnknown80B105 ; 80/B105

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$17
        sta bBufferTMW
        lda #$08
        sta bBufferWH0
        lda #$F7
        sta bBufferWH1
        lda #$33
        sta bBufferW12SEL
        lda #$03
        sta bBufferW34SEL
        lda #$15
        sta bBufferTM
        rep #$20
        rts

        .databank 0

        ; 80/B122

    .endsection Unsorted80B105Section


    .section Unsorted80B122Section

      .al
      .xl

      rsUnknown80B122 ; 80/B122

        .al
        .autsiz
        .databank ?

        ; a MainLoop routine

        php
        sei
        sep #$20
        lda #INIDISP_Setting(true, 0)
        sta bBufferINIDISP
        sta INIDISP,b
        rep #$20

        jsl rlDisableVBlank
        jsr rsUnknown80AF9B
        jsr rsUnknown80B16A
        jsl rlUnknown899FDC
        jsr rlUnknown80B065
        jsr rlUnknown80B105
        jsr rlUnknown80B052
        jsr rlUnknown80B041

        lda #$0012
        sta $0302,b
        lda $0D7B,b
        sta $0304,b
        jsr rsUnknown80B195

        sep #$20
        lda #INIDISP_Setting(false, 0)
        sta bBufferINIDISP
        sta INIDISP,b
        rep #$20

        jsl rlEnableVBlank
        plp
        cli
        rts

        .databank 0

      rsUnknown80B16A ; 80/B16A

        .al
        .autsiz
        .databank ?

        lda $0D77,b
        asl a
        tax
        jmp (+,x)

        +
        .addr rsUnknown80B17A
        .addr rsUnknown80B17F
        .addr rsUnknown80B184
        .addr rsUnknown80B184

        .databank 0

      rsUnknown80B17A ; 80/B17A

        .al
        .autsiz
        .databank ?

        jsl rlUnknown888082
        rts

        .databank 0

      rsUnknown80B17F ; 80/B17F

        .al
        .autsiz
        .databank ?

        jsl rlUnknown88821A
        rts

        .databank 0

      rsUnknown80B184 ; 80/B184

        .al
        .autsiz
        .databank ?

        jsl rlUnknown889268
        jsl rlUpdateAllLocationEvents
        jsl rlUnknown86C629
        jsl rlUnknown888082
        rts

        .databank 0

      rsUnknown80B195 ; 80/B195

        .al
        .autsiz
        .databank ?

        lda #$0020
        trb wUnknown000D79,b

        lda #(`aMapMenuRAMArea)<<8
        sta lR18+1
        lda #<>aMapMenuRAMArea
        sta lR18
        lda #1
        sta wStructIndex,b
        lda #size(aMapMenuRAMArea)
        jsl rlBuildRAMAreaHeaderAndGuidingEntry

        lda #11
        sta $0304,b
        jsl rlUnknown858728

        lda $0D77,b
        cmp #2
        bcc _End

          jsl rlUnknown81B088
          bcc +

            jsl rlGetVictoryThemeIfAllEnemiesDead
            bcc +

              sta $0DAB,b

          +
          lda wUnknown00171A,b
          bne _End

            jsl rlUnknown81AB26
            jsl rlUnknown809654

        _End
        rts

        .databank 0

        ; 80/B1E1

    .endsection Unsorted80B122Section


    .section Unsorted80B63FSection

      .al
      .xl

      rlUnknown80B63F ; 80/B63F

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 80/B640

    .endsection Unsorted80B63FSection


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

      rlUnknown80B9E1 ; 80/B9E1

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
        lda $D77000,x
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
        lda $8C9A00,x
        sta aBGPaletteBuffer,b,x
        dec x
        dec x
        bpl _BAF6
        ldx #$001E

        _BB04
        lda $8C9D00,x
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
        jsr rlUnknown80B9E1
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


    .section Unsorted80C32CSection

      .al
      .xl

      rlUnknown80C32C ; 80/C32C

        .al
        .autsiz
        .databank ?

        php
        sep #$20
        lda #$09
        sta bBufferBGMODE
        rep #$20

        lda #0
        sta wR1
        sta wR2
        lda #$8000 >> 1
        sta wR3
        sta wR4
        lda #$C000 >> 1
        sta wR5
        lda #$A000 >> 1
        sta wR6
        lda #$A800 >> 1
        sta wR7
        lda #$B000 >> 1
        sta wR8
        jsl rlSetLayerPositionsAndSizes
        plp
        rtl

        .databank 0

    .endsection Unsorted80C32CSection


    .section Unsorted80C35DSection

      .al
      .xl

      rlUnknown80C35D ; 80/C35D

        .al
        .autsiz
        .databank ?

        php
        sep #$20
        lda #3
        sta BGMODE,b
        sta bBufferBGMODE
        lda #0
        sta BG1SC,b
        sta bBufferBG1SC
        sta BG2SC,b
        sta bBufferBG2SC
        rep #$20

        lda #$2000 >> 1
        sta wR1
        sta wR2
        lda #$0000 >> 1
        sta wR3
        sta wR4
        lda #$0000 >> 1
        sta wR5
        lda #$E000 >> 1
        sta wR6
        sta wR7
        lda #$0000 >> 1
        sta wR8
        jsl rlSetLayerPositionsAndSizes
        plp
        rtl

        .databank 0

        ; 80/C39A

    .endsection Unsorted80C35DSection


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

        jsr rlUnknown80F340
        jsr rlUnknown80F392
        jsr rlUnknown80F4EB

        lda #$0024
        sta $0304,b
        lda #5
        sta $0302,b
        lda #4
        sta $0300,b

        lda #<>$809D4F
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

      rlUnknown80F340 ; 80/F340

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


    .section Unsorted80F392Section

      .al
      .xl

      rlUnknown80F392 ; 80/F392

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
        lda $DD7EAE,x
        sta wJoy2RepeatTimer,x
        dec x
        dec x
        bne _F3B1
        ldx #$0020

        _F3BE
        lda $DD7F6E,x
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

      rlUnknown80F4EB ; 80/F4EB

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
