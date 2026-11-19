; Code from bank $80 not yet assigned to a game system.


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
        jsl rlCopyINIDISPBuffer
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


    .section Unsorted8081FDSection

      .al
      .xl

      rlUnknown8081FD ; 80/81FD

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .as
        .xs
        .autsiz
        .databank ?

        rep #$30
        jml _8203


        _8203
        phb
        phd
        pha
        phx
        phy
        phk
        plb
        .databank $80
        lda #$0000
        tcd
        lda $4211,b
        bit #$0080
        beq _821C
        pea #<>_821C - 1
        jmp (wIRQPointer)


        _821C
        ply
        plx
        pla
        pld
        plb
        .databank $80
        rti

        .databank 0

        ; 80/8222

      rsUnknown808222 ; 80/8222

        .al
        .xl
        .autsiz
        .databank ?

        rts

        .databank 0

        ; 80/8223

    .endsection Unsorted8081FDSection


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
        jsr rsUnknown808B48
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
        lda aUnknown8089F1,x
        ora aSpriteExtBuffer,b,y
        sta aSpriteExtBuffer,b,y
        ldx #$AAAA
        jsr rsUnknown808A35
        rtl

        .databank 0

        ; 80/89F1

    .endsection Unsorted80889DSection


    .section Table8089F1Section

      .al
      .xl

      aUnknown8089F1 ; 80/89F1

        ; Read by rlUnknown8089AD.

        .word $AAAA, $AAA8, $AAA0, $AA80, $AA00, $A800, $A000, $8000

        ; 80/8A01

    .endsection Table8089F1Section


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
        lda aUnknown808A25,x
        and aSpriteExtBuffer,b,y
        sta aSpriteExtBuffer,b,y
        ldx #$0000
        jsr rsUnknown808A35
        rtl

        .databank 0

        ; 80/8A25

    .endsection Unsorted808A01Section


    .section Table808A25Section

      .al
      .xl

      aUnknown808A25 ; 80/8A25

        ; Read by rlUnknown808A01.

        .word $0000, $0003, $000F, $003F, $00FF, $03FF, $0FFF, $3FFF

        ; 80/8A35

    .endsection Table808A25Section


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
        adc #<>_8A4A
        sta wR0
        lda #$1E00
        tcd
        jmp (wR0)

        ; Stores X in the wR variables from the one Y selects up to wR15: the jump
        ; enters this run of stores partway.

        _8A4A
        stx wR0
        stx wR1
        stx wR2
        stx wR3
        stx wR4
        stx wR5
        stx wR6
        stx wR7
        stx wR8
        stx wR9
        stx wR10
        stx wR11
        stx wR12
        stx wR13
        stx wR14
        stx wR15

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


    .section Unsorted808D56Section

      .al
      .xl

      rlReset ; 80/8D56

        ; The reset vector ($00/FFFC) points here. Switches the CPU to native mode
        ; and jumps on into rlUnknown808D6C in bank $80, checking on the way that
        ; the reset vector still points at this routine. Part of the code that the
        ; checksums in include/Checksums.h cover.
        .as
        .xs
        .autsiz
        .databank ?

        sei
        clc
        xce
        bcc rlUnknown808D6C
        rep #$30
        tdc
        bne rlUnknown808D6C
        ldx #<>rlReset
        cpx $FFFC,b
        bne rlUnknown808D6C
        jml rlUnknown808D6C

        .databank 0

        ; 80/8D6C

    .endsection Unsorted808D56Section


    .section Unsorted808D6CSection

      .al
      .xl

      rlUnknown808D6C ; 80/8D6C

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        ; Runs on into built code at the end.
        .al
        .xl
        .autsiz
        .databank ?

        rep #$30
        tsx
        txy
        ldx #$1FF7
        txs
        sep #$20
        lda #$01
        sta $420D,b
        lda #$80
        sta $2100,b
        stz $4200,b
        stz $420B,b
        stz $420C,b
        rep #$30
        lda $1FFC,b
        cmp #$4C45
        bne _8D9B
        lda $1FFE,b
        cmp #$304D
        beq _8DC3

        _8D9B
        dec y
        lda $0000,b,y
        inc a
        cmp $FFFC,b
        beq _8DCA
        ldx #$0000

        _8DA8
        lda $0000,b,x
        and #$00FF
        cmp #$006C
        beq _8DD2
        cmp #$004C
        beq _8DE9
        cmp #$0060
        beq _8DF3

        _8DBD
        inc x
        cpx #$1FFE
        bne _8DA8

        _8DC3
        phk
        phk
        pla
        beq _8DCA
        bra _8E13


        _8DCA
        lda #$0000
        tcd
        jsl $87803E

        _8DD2
        ldy $0001,b,x
        cpy #$FFFC
        beq _8DCA
        cpy #$1FFF
        bcs _8DBD
        lda $0000,b,y
        cmp #$8D56
        beq _8DCA
        bra _8DBD


        _8DE9
        ldy $0001,b,x
        cpy #$8D56
        beq _8DCA
        bra _8DBD


        _8DF3
        txa
        tcd
        ldy #$0000
        lda #$6160

        _8DFB
        cmp $0000,b,x
        bne _8E0F
        clc
        adc #$0202
        inc x
        inc x
        inc y
        inc y
        cpy #$0020
        bne _8DFB
        bra _8DCA


        _8E0F
        tdc
        tax
        bra _8DBD


        _8E13
        lda #$0000
        tcd
        jsl rlUnknown878074
        sta $1FF8,b
        sta $1FFA,b
        lda #$4C45
        sta $1FFC,b
        lda #$304D
        sta $1FFE,b

        .databank 0

        ; 80/8E2D

    .endsection Unsorted808D6CSection


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
        jsr rsInitPPURegisters
        jsl rlUnknown808EF6
        jsl rlUnknown878074
        lda #$0028
        sta wJoyRepeatDelay
        lda #$000A
        sta wJoyRepeatInterval
        lda #<>rsDefaultVBlankRoutine
        sta wVBlankPointer
        lda #<>rsUnknown808222
        sta wIRQPointer
        lda #<>rlUnknown809CD6
        sta wMainLoopPointer
        jml _8EEE

        .byte $C2, $30, $A2, $F7, $1F, $9A, $E2, $20, $A9, $80, $8D, $00, $21, $9C, $00, $42
        .byte $9C, $0B, $42, $9C, $0C, $42, $C2, $30, $5C, $2D, $8E, $80


        _8EE8
        rep #$30
        jsl rlHaltUntilVBlank

        _8EEE
        rep #$30
        pea #<>_8EE8 - 1
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
        pea #<>_91E7 - 1
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


        _91E7
        cpx $2140,b
        bne _91E7
        sta $2142,b
        sty $2140,b
        inc x
        inc x

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
        .xl
        rtl


        _92C9
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


    .section Unsorted809382Section

      .al
      .xl

      rsUnknown809382 ; 80/9382

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .as
        .xs
        .autsiz
        .databank ?

        rep #$20
        lda [lR39]
        sta $04F2,b
        inc lR39
        inc lR39
        stz $04F0,b
        rts

        .databank 0

        ; 80/9391

    .endsection Unsorted809382Section


    .section Unsorted8093B0Section

      .al
      .xs

      rsUnknown8093B0 ; 80/93B0

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .as
        .xs
        .autsiz
        .databank ?

        rep #$20
        stz $0502,b
        stz $0504,b
        sep #$20
        stz $04FE,b
        stz $04FF,b
        rep #$20
        stz $04F0,b
        rts

        .databank 0

        ; 80/93C6

    .endsection Unsorted8093B0Section


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


    .section Unsorted8094E2Section

      .al
      .xs

      rsUnknown8094E2 ; 80/94E2

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .as
        .xs
        .autsiz
        .databank ?

        rep #$30
        lda wBattleStatus
        and #$0001
        sta $04F0,b
        beq _94F6
        lda aActionStructUnit1.TerrainType
        bra _94FA


        _94F6
        lda aActionStructUnit2.TerrainType

        _94FA
        and #$001F
        sta $050C,b
        sta $050E,b
        lda wBattleDistance
        tax
        lda $04F0,b
        bne _9513
        lda aActionStructUnit1.WeaponID
        bra _9517


        _9513
        lda aActionStructUnit2.WeaponID

        _9517
        cmp #$005C
        beq _954E
        cpx #$0003
        bcc _9569
        cmp #$005B
        beq _954E
        cmp #$0061
        beq _954E
        cmp #$0063
        beq _954E
        cmp #$0064
        beq _954E
        cmp #$0065
        beq _954E
        cmp #$0042
        beq _954E
        cmp #$0047
        beq _954E
        cmp #$004C
        beq _954E
        cmp #$0052
        bne _9569

        _954E
        lda $04F0,b
        bne _955F
        lda aActionStructUnit1.TerrainType
        and #$001F
        sta $050E,b
        bra _9569


        _955F
        lda aActionStructUnit2.TerrainType
        and #$001F
        sta $050C,b

        _9569
        ldx $050C,b
        jsr rsUnknown809583
        stx $050C,b
        ldx $050E,b
        jsr rsUnknown809583
        inc x
        inc x
        stx $050E,b
        stz $04F0,b
        sep #$30
        rts

        .databank 0

        ; 80/9583

      rsUnknown809583 ; 80/9583

        .al
        .xl
        .autsiz
        .databank ?

        lda $95AD,b,x
        and #$001C
        tax
        lda @l wCurrentChapter
        cmp #$0004
        bne _95A0
        cpx #$000C
        beq _95A0
        cpx #$0014
        beq _95A0
        ldx #$0010

        _95A0
        rts

        .databank 0

        ; 80/95A1

    .endsection Unsorted8094E2Section


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
        jsl rlUnknown80908A
        bra _960B


        _9604
        trb $04EC,b
        jsl rlUnknown809072

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
        jsl rlUnknown80905A
        bra _962F


        _9628
        trb $04EC,b
        jsl rlUnknown80903D

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


    .section Unsorted809733Section

      .al
      .xl

      rsUnknown809733 ; 80/9733

        .al
        .xl
        .autsiz
        .databank ?

        pha
        ldx $04EE,b
        lda $04BA,b,x
        cmp #$0100
        bcc _9753
        and #$0F00
        cmp #$0900
        bcs _9753
        sta $04F0,b
        pla
        and #$80FF
        ora $04F0,b
        bra _9754


        _9753
        pla

        _9754
        jsl rlUnknown808F6F
        rts

        .databank 0

        ; 80/9759

    .endsection Unsorted809733Section


    .section Unsorted8097E0Section

      .al
      .xl

      rsUnknown8097E0 ; 80/97E0

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        tax
        lda $04F4,b
        and #$00FF
        bne _97F6
        sep #$20
        lda #$FD
        sta $04FC,b
        stx $04FA,b
        rep #$20
        rts


        _97F6
        lda #$0001
        sta $04F8,b
        dec y
        dec y
        dec y
        dec y
        rts

        .databank 0

        ; 80/9801

    .endsection Unsorted8097E0Section


    .section Unsorted809846Section

      .al
      .xl

      rsUnknown809846 ; 80/9846

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        tax
        lda $0508,b
        bne _9851
        lda $04FA,b
        beq _985C

        _9851
        lda #$0001
        sta $04F8,b
        dec y
        dec y
        dec y
        dec y
        rts


        _985C
        cpx #$00CB
        bcc _9866
        cpx #$00CE
        bcc _9871

        _9866
        txa
        ora $050A,b
        stz $050A,b
        jml rsUnknown809733


        _9871
        sep #$20
        lda $0507,b
        beq _98A0
        cmp $0506,b
        bne _98A0
        rep #$20
        lda $0500,b
        bne _989B
        txa
        sep #$20
        sta $04EB,b
        rep #$20
        lda $0507,b
        and #$00FF
        xba
        ora #$00F1
        jsl rlUnknown808FA3
        rts


        _989B
        sep #$20
        stz $0507,b

        _98A0
        rep #$20
        stz $0500,b
        txa
        jsl rlUnknown808F6F
        rts

        .databank 0

        ; 80/98AB

      rsUnknown8098AB ; 80/98AB

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        rep #$20
        ldx $04FA,b
        bne $809851
        dec a
        bne _98C0
        lda wBattleStatus
        and #$0001
        bne _98CF
        bra _98C9


        _98C0
        lda wBattleStatus
        and #$0001
        beq _98CF

        _98C9
        lda aActionStructUnit1.TerrainType
        bra _98D3


        _98CF
        lda aActionStructUnit2.TerrainType

        _98D3
        and #$001F
        cmp #$0001
        beq _98EA
        cmp #$0004
        beq _98EA
        cmp #$0017
        beq _98F5
        lda #$00C2
        bra _98FE


        _98EA
        lda #$8000
        sta $050A,b
        lda #$80C3
        bra _98FE


        _98F5
        lda #$8000
        sta $050A,b
        lda #$80C4

        _98FE
        jsl rlUnknown808F6F
        rts

        .databank 0

        ; 80/9903

    .endsection Unsorted809846Section


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


    .section Unsorted809B00Section

      .al
      .xl

      rlUnknown809B00 ; 80/9B00

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 80/9B01

    .endsection Unsorted809B00Section


    .section Unsorted809B01Section

      .al
      .xl

      aGameStateRoutines ; 80/9B01

        .long rlUnknown809B00
        .long rlUnknown868010
        .long rlUnknown868011
        .long rlUnknown86803E
        .long rlUnknown91D616
        .long rlUnknown91D617
        .long rlUnknown91D61B
        .long rlUnknown898000
        .long rlUnknown898004
        .long rlUnknown8980E0
        .long rlUnknown8A8000
        .long rlUnknown8A800E
        .long rlUnknown8A8061
        .long rlUnknown8B96CF
        .long rlUnknown8B96E5
        .long rlUnknown8B9717
        .long rlUnknown81A800
        .long rlUnknown81A813
        .long rlUnknown81A89D ; event main loop routine?
        .long rlUnknown8BA7CB
        .long rlUnknown8BA7CC
        .long rlUnknown8BA7CD
        .long rlUnknown80C1A0
        .long rlUnknown80C1CA
        .long rlUnknown95E5C9
        .long rlUnknown95E5DB
        .long rlUnknown9BDC24
        .long rlUnknown9BDCBB
        .long $9FFACC ; unused: points into zero padding
        .long $9FFACC ; unused: points into zero padding
        .long $9FFACC ; unused: points into zero padding
        .long $9FFACC ; unused: points into zero padding
        .long rlUnitWindowHandleInput
        .long rlUnitWindowShow
        .long rlUnitWindowRunPageTurnInput
        .long rlItemWindowRender
        .long rlItemWindowShow
        .long rlItemWindowRunStep
        .long rlDebugMenuTabInputHandler
        .long rlUnknown89E7BD
        .long rlDebugMenuPageInputHandler
        .long rlUnknown89ECC7
        .long rlUnknown89EB26
        .long rlUnknown89EB40
        .long rlSkillWindowRender
        .long rlSkillWindowShow
        .long rlSkillWindowRunStep
        .long rlDataWindowRender
        .long rlDataWindowShow
        .long rlDataWindowRunStep
        .long rlUnknown89B0AA
        .long rlUnknown89ACCE
        .long rlUnknown89ACE7
        .long rlUnknown8DA06A
        .long rlUnknown8DA06B
        .long rlUnknown8DA0B7

      rlRunGameStateRoutines ; 80/9BA9

        .al
        .autsiz
        .databank ?

        phb

        lda wGameStateRoutine1,b
        asl a
        adc wGameStateRoutine1,b
        jsr rsUnknown809BC0

        lda wGameStateRoutine2,b
        asl a
        adc wGameStateRoutine2,b
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
        lda aGameStateRoutines+2,x
        cmp #$7D
        beq +

          sta $24+2

          pha
          plb

          rep #$20
          lda aGameStateRoutines,x
          sta $24
          jsl rlUnknown809BEB
          rep #$30
          rts

        +
        rep #$20
        lda aGameStateRoutines,x
        sta wGameStateRoutine1,b
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


    .section Unsorted809BEESection

      .as
      .xl

      rlUnknown809BEE ; 80/9BEE

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
        ldx #$002F
        lda #$00

        _9BF9
        sta $0309,b,x
        dec x
        bpl _9BF9
        rep #$20
        plb
        .databank $80
        plp
        rtl

        .databank 0

        ; 80/9C04

      rlUnknown809C04 ; 80/9C04

        .al
        .xl
        .autsiz
        .databank ?

        phb
        phk
        plb
        .databank $80
        phx
        phy
        ldx #$002D

        _9C0C
        lda $0309,b,x
        beq _9C1B
        dec x
        dec x
        dec x
        bpl _9C0C
        ply
        plx
        plb
        .databank ?
        sec
        rtl


        _9C1B
        ldy #$0000
        lda lR44+1
        sta $030A,b,x
        sta $0307,b
        lda [lR44],y
        sta $0306,b
        inc y
        inc y
        lda [lR44],y
        sta $0309,b,x
        jsl rlUnknown809C3B
        ply
        plx
        plb
        .databank ?
        clc
        rtl

        .databank 0

        ; 80/9C3B

      rlUnknown809C3B ; 80/9C3B

        .al
        .xl
        .autsiz
        .databank ?

        jml [$0306]

        .databank 0

        ; 80/9C3E

    .endsection Unsorted809BEESection


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
        jsl rlUnknown809C9D

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

      rsDefaultVBlankRoutine ; 80/9CA0

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; The VBlank routine rlReset installs. FE5: rsDefaultVBlankRoutine.

        sep #$20
        lda #$80
        sta $2100,b
        rep #$20
        jsl rlProcessDMAStructArray
        jsl rlDMAPaletteAndOAMBuffer
        jsl rlCopyPPURegisterBuffer
        jsl rlUnknown8090A2
        jsl rlGetJoypadInput
        jsl rlIncreaseFrameCounters
        jsl rlClearSpriteExtBuffer
        jsl rlRunGameStateRoutines
        jsl rlUnknown809C7A
        jsl rlHideSprites
        jsl rlUnknown8095CD
        rts

        .databank 0

        ; 80/9CD6

      rlUnknown809CD6 ; 80/9CD6

        ; Found by tools/sweep.py.
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
        jsr rsUnknown80A836
        jsl rlUnknown809BEE
        lda #(`aProcEngineMainProcActionTable)<<8
        sta lR44+1
        lda #<>aProcEngineMainProcActionTable
        sta lR44
        jsl rlUnknown809C04
        lda #(`aActiveSpriteEngineMainActionTable)<<8
        sta lR44+1
        lda #<>aActiveSpriteEngineMainActionTable
        sta lR44
        jsl rlUnknown809C04
        lda #(`aHDMAEngineMainActionTable)<<8
        sta lR44+1
        lda #<>aHDMAEngineMainActionTable
        sta lR44
        jsl rlUnknown809C04
        lda #$8200
        sta lR44+1
        lda #$E000
        sta lR44
        jsl rlUnknown809C04
        lda #$9100
        sta lR44+1
        lda #$A3A5
        sta lR44
        jsl rlUnknown809C04
        stz wGameStateRoutine2,b
        stz wGameStateRoutine1,b
        jml rsUnknown80AD24

        .databank 0

        ; 80/9D4F

    .endsection Unsorted809CA0Section


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

      rlHandlePossibleHDMA ; 80/A328

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ; Starts the pending DMA channels, runs the HDMA engine and enables its channels. FE5: rlHandlePossibleHDMA.

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


    .section Unsorted80A836Section

      .al
      .xl

      rsUnknown80A836 ; 80/A836

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
        ldx #$0003

        _A83F
        lda @l aUnknown80A859,x
        sta rsBlockCopyMVNRAM,b,x
        dec x
        bpl _A83F
        ldx #$0004

        _A84C
        lda @l aUnknown80A85D,x
        sta rsBlockCopyMVPRAM,b,x
        dec x
        bpl _A84C
        plp
        plb
        .databank $80
        rts

        .databank 0

        ; 80/A859

    .endsection Unsorted80A836Section


    .section Table80A859Section

      .al
      .xl

      aUnknown80A859 ; 80/A859

        ; Read by rsUnknown80A836.

        .byte $54, $00, $00, $60

        ; 80/A85D

    .endsection Table80A859Section


    .section Table80A85DSection

      .al
      .xl

      aUnknown80A85D ; 80/A85D

        ; Read by rsUnknown80A836.

        .byte $44, $00, $00, $60

        ; 80/A861

    .endsection Table80A85DSection


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


    .section Unsorted80AD24Section

      .as
      .xl

      rsUnknown80AD24 ; 80/AD24

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
        lda #$000A
        sta wJoyRepeatDelay
        lda #$0006
        sta wJoyRepeatInterval
        lda #$0000
        jsl rlFillBG2Page0TilemapBuffer
        lda #$030F
        jsl rlFillBG2Page1TilemapBuffer
        lda #$00FF
        jsl rlFillBG3Page0TilemapBuffer
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
        jsl rlProcEngineResetProcEngine
        jsl rlActiveSpriteEngineReset
        jsl rlEnableActiveSpriteEngine
        jsl rlResetHDMAEngine
        jsl rlResetIRQEngine
        jsl rlUnknown82E400
        jsl rlUnknown8780AA
        jsl rlUnknown82F211
        lda #$00FF
        sta wUnknown053E,b
        jsl rlInitializeUnitRAM
        jsl rlInitiateChapterEventRAMData
        jsl rlUnknown869CCC
        jsl rlUnknown80A773
        jsl rlUnknown91EC8E
        jsl rlUnknown87BF43
        cmp #$0001
        bne _ADD0
        sep #$20
        lda $04EA,b
        ora #$40
        sta $04EA,b
        rep #$20

        _ADD0
        lda #$00C0
        jsl rlUnknown808F6F
        jsl rlUnknown9BFBC0
        jsl rlUnknown81A85C
        lda #$0001
        sta wGameStateRoutine2,b
        lda #$0002
        sta wGameStateRoutine1,b
        stz wGameStateStep,b
        lda #<>rsUnknown80AE25
        sta wVBlankPointer
        lda #<>rsUnknown809D4F
        sta wMainLoopPointer
        jsl rlEnableVBlank
        plp
        cli
        rts

        .databank 0

        ; 80/ADFF

    .endsection Unsorted80AD24Section


    .section Unsorted80AE25Section

      .al
      .xl

      rsUnknown80AE25 ; 80/AE25

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
        jsl rlHandlePossibleHDMA
        jsl rlCopyPPURegisterBuffer
        jsl rlUnknown8090A2
        jsl rlGetJoypadInput
        jsl rlIncreaseFrameCounters
        jsl rlClearSpriteExtBuffer
        jsl rlRunGameStateRoutines
        jsl rlUnknown809C7A
        jsl rlHideSprites
        jsl rlUnknown858728
        jsl rlUnknown8095CD
        rts

        .databank 0

        ; 80/AE63

      rsUnknown80AE63 ; 80/AE63

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown82E250
        rts

        .databank 0

        ; 80/AE68

      rsUnknown80AE68 ; 80/AE68

        .al
        .xl
        .autsiz
        .databank ?

        php
        sep #$20
        lda #$80
        sta $2100,b
        rep #$20
        jsl rlDMAPaletteAndOAMBuffer
        lda wUnknown000D79,b
        bit #$0200
        bne _AE92
        lda bDMAArrayFlag,b
        and #$00FF
        bne _AE92
        lda #$0008
        trb wUnknown000D79,b
        jsl rlUnknown88CD68
        bra _AE98


        _AE92
        lda #$0008
        tsb wUnknown000D79,b

        _AE98
        jsl rlProcessDMAStructArray
        jsl rlHandlePossibleHDMA
        jsl rlCopyPPURegisterBuffer
        jsl rlUnknown8090A2
        jsl rlGetJoypadInput
        jsl rlIncreaseFrameCounters
        jsl rlUnknown82E147
        lda bUnknown000E7B,b
        bit #$0010
        bne _AEC0
        jsl rlClearSpriteExtBuffer

        _AEC0
        jsl rlRunGameStateRoutines
        jsl rlUnknown809C7A
        jsl rlUnknown81B3A6
        jsl rlUnknown858728
        lda bUnknown000E7B,b
        bit #$0010
        bne _AEE4
        jsl rlUnknown88C844
        jsl rlUnknown88D084
        jsl rlHideSprites

        _AEE4
        jsl rlUnknown8095CD
        plp
        rts

        .databank 0

        ; 80/AEEA

      rsUnknown80AEEA ; 80/AEEA

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        php
        sei
        sep #$20
        lda #$80
        sta bBufferINIDISP
        sta $2100,b
        rep #$20
        jsl rlDisableVBlank
        jsr rsUnknown80AF9B
        jsl rlProcEngineResetProcEngine
        jsl $88806A
        lda wCurrentChapter,b
        jsl rlSetChapterEventDataPointerByID
        jsl rlUnknown87BF6F
        lda wUnknown000D79,b
        bit #$0100
        bne _AF33
        jsl rlResetUnitsForChapter
        lda wCurrentChapter,b
        jsl rlUnknown86C4C4
        stz wCurrentTurn,b
        stz $0D7B,b
        sep #$20
        stz wAreaRestrictionBitfield,b
        rep #$20
        bra _AF4C


        _AF33
        stz $0DAB,b
        jsl rlUnknown86C4EB
        lda #$0007
        sta $0D7B,b
        jsl rlUnknown81A9D4
        jsl rlUnknown809654
        jsl rlUnknown86C629

        _AF4C
        jsl rlUnknown88DE1B
        jsl rlUpdateAllLocationEvents
        jsl rlUnknown888082
        jsl rlUnknown899FDC
        jsr rsUnknown80B065
        jsr rsUnknown80B105
        jsr rsUnknown80B052
        jsr rsUnknown80B041
        lda #$0011
        sta wGameStateRoutine1,b
        stz wGameStateStep,b
        lda wUnknown000D79,b
        bit #$0020
        beq _AF89
        stz wGameStateRoutine1,b
        lda #$0000
        jsl $88B30D
        lda #$0004
        tsb $0788,b

        _AF89
        jsl rlEnableVBlank
        sep #$20
        lda #$00
        sta bBufferINIDISP
        sta $2100,b
        rep #$20
        plp
        cli
        rts

        .databank 0

        ; 80/AF9B

    .endsection Unsorted80AE25Section


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
        jsl rlResetIRQEngine
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
        lda #<>rsUnknown80AE68
        sta wVBlankPointer
        lda #<>rsUnknown80B301
        sta wMainLoopPointer
        stz wGameStateRoutine2,b
        stz wGameStateRoutine1,b
        stz wGameStateStep,b
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

        ; Found by tools/sweep.py.
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

        ; Found by tools/sweep.py.
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
        jsl rlHandlePossibleHDMA
        jsl rlCopyPPURegisterBuffer
        jsl rlUnknown8090A2
        jsl rlGetJoypadInput
        jsl rlIncreaseFrameCounters
        jsl rlClearSpriteExtBuffer
        jsl rlRunGameStateRoutines
        jsl rlUnknown809C7A
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
        jsl rlUnknown8095CD
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
        jsl rlResetIRQEngine
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
        sta wGameStateRoutine1,b
        lda #$000D
        sta wGameStateRoutine2,b
        stz wGameStateStep,b
        lda #<>rsUnknown80B347
        sta wVBlankPointer
        lda #<>rsUnknown809D4F
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
        sta aDialogue.wUnknown0018D0,b
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
        sta aBG2TilemapBuffer.Page1,x
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
        lda aUnknown8CDC00,x
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


    .section Unsorted80B641Section

      .al
      .xl

      rsUnknown80B641 ; 80/B641

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$80
        sta $2100,b
        rep #$20
        lda bDMAArrayFlag,b
        and #$00FF
        bne _B663
        lda $0891,b
        cmp #$0002
        beq _B663
        cmp #$0003
        beq _B663
        jsl rlUnknown88CD68

        _B663
        jsl rlProcessDMAStructArray
        jsl rlDMAPaletteAndOAMBuffer
        jsl rlHandlePossibleHDMA
        jsl rlCopyPPURegisterBuffer
        jsl rlUnknown8090A2
        jsl rlGetJoypadInput
        jsl rlIncreaseFrameCounters
        jsl rlClearSpriteExtBuffer
        jsl rlRunGameStateRoutines
        jsl rlUnknown809C7A
        lda $0891,b
        cmp #$0002
        beq _B69C
        cmp #$0003
        beq _B69C
        jsl rlUnknown8A98D0

        _B69C
        jsl rlHideSprites
        jsl rlUnknown9181F6
        jsl rlUnknown858728
        jsl rlUnknown8095CD
        rts

        .databank 0

        ; 80/B6AD

    .endsection Unsorted80B641Section


    .section Unsorted80B6B6Section

      .al
      .xl

      rsUnknown80B6B6 ; 80/B6B6

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
        lda #$0000
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
        jsl rlActiveSpriteEngineReset
        jsl rlResetHDMAEngine
        jsl rlResetIRQEngine
        jsl rlClearUnitWindowAndTerrainWindowProcs
        jsl rlUnknown82E400
        jsl rlUnknown8780AA
        jsl rlUnknown82F211
        lda #$000B
        sta wGameStateRoutine1,b
        lda #$000A
        sta wGameStateRoutine2,b
        lda #<>rsUnknown80B641
        sta wVBlankPointer
        lda #<>rsUnknown809D4F
        sta wMainLoopPointer
        lda #$0002
        sta aDialogue.wUnknown0018D0,b
        lda #$0020
        tsb wUnknown000D79,b
        jsl rlUnknown80B77F
        jsl rlUnknown88CD61
        jsl rlEnableVBlank
        sep #$20
        lda #$00
        sta bBufferINIDISP
        rep #$20
        plp
        rts

        .databank 0

        ; 80/B74B

    .endsection Unsorted80B6B6Section


    .section Unsorted80B74BSection

      .al
      .xl

      rlUnknown80B74B ; 80/B74B

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        jsl rlGetFactionSlotLocationID
        cmp $089F,b
        bne _B76A
        lda #$0000
        jsl rlGetLocationEventDataEntry
        jsl rlBuildDeadPlayerCharacterList
        jsl rlUnknown80B9AD
        jsl rlUnknown8A9A56

        _B76A
        lda #$0003
        sta $088B,b
        lda $089B,b
        sta wSelectedUnitDataRAMPointer,b
        lda #<>rsUnknown80B6B6
        sta wMainLoopPointer
        clc
        rtl

        .databank 0

        ; 80/B77D

    .endsection Unsorted80B74BSection


    .section Unsorted80B77FSection

      .al
      .xl

      rlUnknown80B77F ; 80/B77F

        .al
        .xl
        .autsiz
        .databank ?

        lda $088B,b
        asl a
        tax
        jmp ($80B787,x)

        .databank 0

        ; 80/B787

    .endsection Unsorted80B77FSection


    .section Unsorted80B793Section

      .al
      .xl

      rlUnknown80B793 ; 80/B793

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown80B9AD
        lda $089D,b
        beq _B7A3
        stz $089D,b
        jsl rlUnknown8CED4F

        _B7A3
        lda #$0003
        sta $0891,b
        jsr rsUnknown80B9BC
        jsl rlUnknown8AD81B
        rtl

        .databank 0

        ; 80/B7B1

    .endsection Unsorted80B793Section


    .section Unsorted80B81BSection

      .al
      .xl

      rlUnknown80B81B ; 80/B81B

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown80B827
        lda #$00F7
        jsl rlUnknown808F6F
        rtl

        .databank 0

        ; 80/B827

      rlUnknown80B827 ; 80/B827

        .al
        .xl
        .autsiz
        .databank ?

        rep #$20
        jsl rlUnknown8881EC
        jsl rlUnknown80B08C
        jsl rlDMAByStruct

          .structDMAToVRAM $D80000, $4000, $80, $0000

        jsl rlDMAByStruct

          .structDMAToVRAM $DE40C0, $0400, $80, $C000

        jsl rlDMAByStruct

          .structDMAToVRAM $D77800, $0800, $80, $A000

        ldx #$06FE
        lda #$00FF

        _B85E
        sta aBG2TilemapBuffer.Page1,x
        dec x
        dec x
        bpl _B85E
        jsl rlDMAByStruct

          .structDMAToVRAM $7E7B88, $0700, $80, $A800

        jsl rlDMAByStruct

          .structDMAToVRAM $D76800, $0800, $80, $9800

        lda #$8000
        sta lR19+1
        lda #$B99D
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        lda #$8000
        sta lR19+1
        lda #$B9A5
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        jsl rlGetEventLocationEntryID
        sta $089F,b
        ldx #$00FE

        _B8A6
        lda $8C9800,x
        sta aBGPaletteBuffer,b,x
        dec x
        dec x
        bpl _B8A6
        ldx #$00FE

        _B8B4
        lda $8C9500,x
        sta aOAMPaletteBuffer,b,x
        dec x
        dec x
        bpl _B8B4
        ldx #$001E

        _B8C2
        lda $8C9D00,x
        sta aOAMPaletteBuffer,b,x
        dec x
        dec x
        bpl _B8C2
        jsl rlUnknown899FDC
        sep #$20
        rep #$10
        ldx #$2542
        stx DecompressionVariables
        lda #$C0
        sta $CA
        ldx #$8F88
        stx $CB
        lda #$7E
        sta $CD
        rep #$30
        jsl rlDecompressor
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8F88, $0400, $80, $6C00

        sep #$20
        lda #$03
        sta bBufferWOBJSEL
        rep #$20
        stz $0891,b
        ldx #$07FE
        lda #$00FF

        _B90B
        sta aBG3TilemapBuffer,x
        dec x
        dec x
        bpl _B90B
        jsl rlUnknown80B9AD
        jsl rlUnknown8A9A56
        jsl rlUnknown88DE1B
        lda $0897,b
        asl a
        tax
        lda aUnknown8A99DB,x
        sta $088D,b
        lda aUnknown8A9A0B,x
        sta $088F,b
        ldx wActiveUnitDeploymentOffset,b
        lda aDeploymentTable._UnitRAMPointer,x
        beq _B97B
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitHomeCastle
        bcs _B97B
        cmp $089F,b
        bne _B97B
        jsl rlGetSelectedUnitGenerationID
        sta $0897,b
        lda $0897,b
        dec a
        asl a
        tax
        lda wCurrentChapter,b
        cmp #$0006
        bcs _B964
        lda aUnknown8A9BF4,x
        bra _B968


        _B964
        lda aUnknown8A9C24,x

        _B968
        sta $0897,b
        asl a
        tax
        lda aUnknown8A99DB,x
        sta $088D,b
        lda aUnknown8A9A0B,x
        sta $088F,b

        _B97B
        jsl rlUnknown8A8496
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0800, $80, $B000

        jsr rsUnknown80B9BC
        sep #$20
        lda #$00
        sta bBufferCGADSUB
        rep #$20
        stz wGameStateStep,b
        rtl

        .databank 0

        ; 80/B99B

    .endsection Unsorted80B81BSection


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


    .section Unsorted80B9BCSection

      .al
      .xl

      rsUnknown80B9BC ; 80/B9BC

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        stz bBufferW12SEL
        stz bBufferW34SEL
        stz bBufferWOBJSEL
        lda #$15
        sta bBufferTM
        lda #$00
        sta bBufferTS
        lda bBufferBGMODE
        and #$FF
        sta bBufferBGMODE
        lda #$00
        sta bBufferCGWSEL
        lda #$81
        sta bBufferCGADSUB
        lda #$FF
        sta bBufferWH1
        rep #$20
        rts

        .databank 0

        ; 80/B9E1

    .endsection Unsorted80B9BCSection


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
        sta wGameStateStep,b
        inc wGameStateRoutine1,b
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
        sta wGameStateStep,b
        rtl

        .databank 0

        ; 80/BB43

    .endsection Unsorted80BA52Section


    .section Unsorted80BB5DSection

      .al
      .xl

      rlUnknown80BB5D ; 80/BB5D

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        jsl rlGetFactionSlotLocationID
        jsl rlGetLocationEventDataEntry
        jsl rlUnknown88C25D
        jsl rlBuildDeadPlayerCharacterList
        lda #$0000
        sta $088B,b
        lda #<>rsUnknown80B6B6
        sta wMainLoopPointer
        rtl

        .databank 0

        ; 80/BB7C

    .endsection Unsorted80BB5DSection


    .section Unsorted80BB7CSection

      .al
      .xl

      rlUnknown80BB7C ; 80/BB7C

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta $088B,b
        jsl rlBuildDeadPlayerCharacterList
        lda #$B6B6
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 80/BB9B

    .endsection Unsorted80BB7CSection


    .section Unsorted80BB9BSection

      .al
      .xl

      rsUnknown80BB9B ; 80/BB9B

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
        jsl rlHandlePossibleHDMA
        jsl rlCopyPPURegisterBuffer
        jsl rlUnknown8090A2
        jsl rlGetJoypadInput
        jsl rlIncreaseFrameCounters
        jsl rlClearSpriteExtBuffer
        jsl rlUnknown809C7A
        jsl rlRunGameStateRoutines
        jsl rlHideSprites
        jsl rlUnknown878256
        jsl rlUnknown8095CD
        rts

        .databank 0

        ; 80/BBD9

      rsUnknown80BBD9 ; 80/BBD9

        .al
        .xl
        .autsiz
        .databank ?

        php
        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        lda #<>rsUnknown80BB9B
        sta wVBlankPointer
        jsl rlHaltUntilVBlank
        jsl rlDisableVBlank
        jsl rlHardwareResetScreenPosMathHDMA
        jsl rlHardwareResetScreenRegisters
        lda #$0000
        sta wR1
        lda #$0000
        sta wR2
        lda #$4000
        sta wR3
        lda #$6000
        sta wR5
        lda #$2000
        sta wR6
        lda #$2800
        sta wR7
        lda #$5800
        sta wR8
        jsl rlSetLayerPositionsAndSizes
        jsl rlClearUnitWindowAndTerrainWindowProcs
        jsl rlActiveSpriteEngineReset
        jsl rlResetIRQEngine
        jsl rlResetHDMAEngine
        jsr rsUnknown80BC52
        jsl rlUnknown80BD27
        jsr rsUnknown80BF01
        lda #$0008
        sta wGameStateRoutine1,b
        lda #$0007
        sta wGameStateRoutine2,b
        stz wGameStateStep,b
        lda #<>rsUnknown809D4F
        sta wMainLoopPointer
        jsl rlEnableVBlank
        plp
        rts

        .databank 0

        ; 80/BC52

      rsUnknown80BC52 ; 80/BC52

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F819D
        cmp #$1111
        beq _BC66
        lda #$0000
        sta $7F8187
        sta $7F8189

        _BC66
        lda #$0000
        sta $7F81A1
        sta $7F8185
        lda #$0050
        sta $0885,b
        lda #$FFFF
        sta wTempVariable1,b
        lda #$0000
        tax

        _BC81
        sta $7F81ED,x
        sta $7F8255,x
        inc x
        inc x
        cpx #$0068
        bne _BC81
        jsl rlGetSelectedUnitCharacterID
        sta $7F8195
        jsl rlUnknown8990BD
        jsl rlUnknown849FC4
        sta $7F8199
        cmp #$0000
        bne _BCB1
        jsl rlGetSelectedUnitLeadershipStars
        sta $7F8197

        _BCB1
        lda #$000C
        jsl rlCheckForSpecifiedHolyBlood
        sta $7F818D
        jsl rlGetSelectedUnitFactionSlot
        sta $7F8193
        jsl rlGetUnitType
        sta $7F818B
        jsl rlUnknown89A376
        lda #$0000
        sta $7F819B
        lda $7F8193
        bne _BCE9
        jsl rlGetPromotedClassIfAvailable
        lda $7E2000
        sta $7F819B

        _BCE9
        jsl rlCheckForValidUniqueItemOrDrops
        bcc _BCF2
        lda #$0000

        _BCF2
        sta $7F81A7
        jsl rlGetSelectedUnitStates
        sta $7F81A9
        jsl rlGetSelectedUnitStatus
        sta $7F81AB
        lda #$0000
        sta $7F81D1
        lda $7F81A9
        bit #$0200
        bne _BD1F
        lda $7F81AB
        cmp #$0003
        bne _BD26

        _BD1F
        lda #$0008
        sta $7F81D1

        _BD26
        rts

        .databank 0

        ; 80/BD27

      rlUnknown80BD27 ; 80/BD27

        .al
        .xl
        .autsiz
        .databank ?

        lda #$8900
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$ACB3
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$0001
        sta $7F81AD
        lda $7F819D
        beq _BD44
        jml _BE18


        _BD44
        lda #$0000
        sta $7F81AD
        lda #$0000
        sta $7F818F
        jsl rlDMAByStruct

          .structDMAToVRAM $DE44C0, $0400, $80, $C000

        jsl rlDMAByStruct

          .structDMAToVRAM $DE0200, $0800, $80, $E000

        jsl rlDMAByStruct

          .structDMAToVRAM $DE34C0, $0C00, $80, $D000

        jsl rlDMAByStruct

          .structDMAToVRAM $DE0A00, $0C00, $80, $E800

        jsl rlDMAByStruct

          .structDMAToVRAM $DD72B0, $0C00, $80, $6000

        jsl rlDMAByStruct

          .structDMAToVRAM $DE48C0, $1800, $80, $9800

        lda #$8000
        sta lR19+1
        lda #$BEF9
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        lda #$030F
        jsl rlUnitWindowFillBG3Buffer
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $1000, $80, $4000

        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $1000, $80, $5000

        jsl rlDMAByStruct

          .structDMAToVRAM $DD6730, $02C0, $80, $4000

        jsl rlDMAByStruct

          .structDMAToVRAM $DD69F0, $08C0, $80, $5280

        jsl rlDMAByStruct

          .structDMAToVRAM $DE1A40, $0440, $80, $5B40

        ldx #$0200

        _BDF9
        lda $DE2ABE,x
        sta wJoy2RepeatTimer,x
        dec x
        dec x
        bne _BDF9
        lda #$0006
        jsl rlUnitWindowCopySpritePalette2
        ldx #$0020

        _BE0D
        lda $DE00BE,x
        sta $02DE,b,x
        dec x
        dec x
        bne _BE0D

        _BE18
        lda $7F818D
        cmp #$0002
        beq _BE30
        jsl rlDMAByStruct

          .structDMAToVRAM $DE1600, $0440, $80, $4800

        bra _BE3D


        _BE30
        jsl rlDMAByStruct

          .structDMAToVRAM $DE1E80, $0440, $80, $4800


        _BE3D
        lda #$004E
        jsl rlUnitWindowFillBG3Buffer
        jsl rlUnknown899BA5
        jsl rlUnknown899C7C
        jsl rlUnknown899D72
        jsl rlUnknown899510
        jsl rlUnknown89970D
        jsl rlUnknown8998E1
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $1000, $80, $B000

        sep #$20
        lda #$00
        pha
        plb
        .databank $00
        rep #$20
        lda $7F81AB
        cmp #$0005
        beq _BE92
        lda $7F81D1
        beq _BE83
        tax
        bra _BEA4


        _BE83
        lda $7F8193
        bne _BE97
        lda $7F81A9
        bit #$4000
        beq _BE97

        _BE92
        ldx #$0008
        bra _BEA4


        _BE97
        lda $7F8193
        ldx #$0000
        jsl rlGetFactionRelation
        asl a
        tax

        _BEA4
        lda $80BEEF,x
        tax
        ldy #$0000

        _BEAC
        lda $8C9400,x
        sta aOAMPaletteBuffer.aPalette1,b,y
        inc x
        inc x
        inc y
        inc y
        cpy #$0020
        bne _BEAC
        jsl rlUnknown89A138
        jsl rlUnknown8990DA
        lda #$8900
        sta lR44+1
        lda #$9140
        sta lR44
        jsl rlHDMAEngineCreateEntry
        lda #$8900
        sta lR44+1
        lda #$917A
        sta lR44
        jsl rlHDMAEngineCreateEntry
        lda #$8900
        sta lR44+1
        lda #$91B9
        sta lR44
        jsl rlHDMAEngineCreateEntry
        rtl

        .databank 0

        ; 80/BEEF

    .endsection Unsorted80BB9BSection


    .section Unsorted80BF01Section

      .al
      .xl

      rsUnknown80BF01 ; 80/BF01

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        stz bBufferW12SEL
        stz bBufferW34SEL
        stz bBufferWOBJSEL
        lda #$17
        sta bBufferTM
        lda #$00
        sta bBufferTS
        lda bBufferBG1SC
        and #$FC
        ora #$02
        sta bBufferBG1SC
        lda bBufferBG2SC
        and #$FC
        ora #$02
        sta bBufferBG2SC
        lda bBufferBG3SC
        and #$FC
        ora #$02
        sta bBufferBG3SC
        lda #$00
        sta bBufferCGWSEL
        lda #$83
        sta bBufferCGADSUB
        rep #$20
        stz wBufferBG1VOFS
        stz wBufferBG2VOFS
        stz wBufferBG3VOFS
        stz wBufferBG1HOFS
        stz wBufferBG2HOFS
        stz wBufferBG3HOFS
        rts

        .databank 0

        ; 80/BF40

      rsUnknown80BF40 ; 80/BF40

        .al
        .xl
        .autsiz
        .databank ?

        php
        sep #$20
        lda #$80
        sta $2100,b
        rep #$20
        jsl rlUnknown95C368
        jsl rlUnknown969FD7
        jsl rlUnknown96D5DB
        jsl rlUnknown95A086
        jsl rlUnknown96EB1E
        jsl rlProcessDMAStructArray
        jsl rlDMAPaletteAndOAMBuffer
        jsl rlHandlePossibleHDMA
        jsl rlCopyPPURegisterBuffer
        jsl rlUnknown8090A2
        jsl rlGetJoypadInput
        jsl rlUnknown82E147
        lda $7FFC77
        bit #$0001
        beq _BF89
        jsl rlUnknown969FEB
        bra _BF8D


        _BF89
        jsl rlClearSpriteExtBuffer

        _BF8D
        sep #$20
        lda #$00
        sta $7FE1CF
        rep #$20
        jsl rlRunGameStateRoutines
        jsl rlUnknown809C7A
        jsl rlHideSprites
        jsl rlUnknown8095CD
        plp
        rts

        .databank 0

        ; 80/BFA9

      rsUnknown80BFA9 ; 80/BFA9

        .al
        .xl
        .autsiz
        .databank ?

        php
        sep #$20
        lda #$80
        sta $2100,b
        rep #$20
        jsl rlUnknown95C368
        jsl rlUnknown96D5DB
        jsl rlUnknown9BEAB1
        jsl rlProcessDMAStructArray
        jsl rlDMAPaletteAndOAMBuffer
        jsl rlHandlePossibleHDMA
        jsl rlCopyPPURegisterBuffer
        jsl rlUnknown8090A2
        jsl rlGetJoypadInput
        jsl rlUnknown82E147
        jsl rlClearSpriteExtBuffer
        sep #$20
        lda #$00
        sta $7FE1CF
        rep #$20
        jsl rlRunGameStateRoutines
        jsl rlUnknown809C7A
        jsl rlHideSprites
        jsl rlUnknown8095CD
        plp
        rts

        .databank 0

        ; 80/BFFB

      rsUnknown80BFFB ; 80/BFFB

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
        jsl rlClearUnitWindowAndTerrainWindowProcs
        jsl rlActiveSpriteEngineReset
        jsl rlResetHDMAEngine
        jsl rlResetIRQEngine
        jsl rlUnknown95B96F
        jsl rlUnknown958AF0
        jsl rlUnknown95A0F7
        lda #$0000
        sta $0AE9,b
        lda #$0043
        sta $0AEB,b
        sep #$20
        lda #$18
        sta $0B06,b
        sta $0B49,b
        rep #$20
        jsl rlUnknown958000
        lda #$9600
        sta lR44+1
        lda #$8095
        sta lR44
        jsl rlUnknown82E0C6
        lda #$9600
        sta lR44+1
        lda #$8000
        sta lR44
        jsl rlUnknown82E0C6
        lda #$9600
        sta lR44+1
        lda #$800F
        sta lR44
        jsl rlUnknown82E0C6
        lda #$9600
        sta lR44+1
        lda #$8050
        sta lR44
        jsl rlUnknown82E0C6
        lda #$9600
        sta lR44+1
        lda #$8078
        sta lR44
        jsl rlUnknown82E0C6
        jsl rlUnknown82E08D
        lda #$0018
        sta wGameStateRoutine1,b
        lda #<>rsUnknown80BF40
        sta wVBlankPointer
        lda #<>rsUnknown80C144
        sta wMainLoopPointer
        stz wGameStateRoutine2,b
        jsl rlEnableVBlank
        sep #$20
        lda #$00
        sta bBufferINIDISP
        sta $2100,b
        rep #$20
        plp
        jsl rlUnknown96892C
        cli
        rts

        .databank 0

        ; 80/C0B6

      rsUnknown80C0B6 ; 80/C0B6

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        php
        lda #$0000
        bra _C0C0

        .byte $08, $A9, $01, $00


        _C0C0
        sep #$20
        sta $7FD8B9
        rep #$20
        sep #$20
        lda #$80
        sta bBufferINIDISP
        sta $2100,b
        rep #$20
        jsl rlDisableVBlank
        jsl rlUnknown95F13C
        bcc _C0E7
        sep #$20
        lda #$01
        sta $7FD8B9
        rep #$20

        _C0E7
        jsl rlProcEngineResetProcEngine
        jsl rlActiveSpriteEngineReset
        jsl rlResetHDMAEngine
        jsl rlResetIRQEngine
        jsl rlUnknown95EE73
        jsl rlUnknown95F0E9
        lda #$9600
        sta lR44+1
        lda #$80A4
        sta lR44
        jsl rlUnknown82E0C6
        lda #$9600
        sta lR44+1
        lda #$80B3
        sta lR44
        jsl rlUnknown82E0C6
        jsl rlUnknown82E08D
        lda #$001A
        sta wGameStateRoutine1,b
        lda #<>rsUnknown80BFA9
        sta wVBlankPointer
        lda #<>rsUnknown80C155
        sta wMainLoopPointer
        stz wGameStateRoutine2,b
        jsl rlEnableVBlank
        sep #$20
        lda #$80
        sta bBufferINIDISP
        sta $2100,b
        rep #$20
        plp
        cli
        rts

        .databank 0

        ; 80/C144

      rsUnknown80C144 ; 80/C144

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlButtonCombinationResetCheck
        jsl rlDecompressByList
        jsl rlUnknown809903
        jsl rlUnknown969872
        rts

        .databank 0

        ; 80/C155

      rsUnknown80C155 ; 80/C155

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlButtonCombinationResetCheck
        jsl rlDecompressByList
        jsl rlUnknown809903
        rts

        .databank 0

        ; 80/C162

    .endsection Unsorted80BF01Section


    .section Unsorted80C1A0Section

      .al
      .xl

      rlUnknown80C1A0 ; 80/C1A0

        .al
        .xl
        .autsiz
        .databank ?

        php
        lda #$7F00
        sta lR18+1
        lda #$A500
        sta lR18
        lda #$5AFF
        jsl rlBuildRAMAreaHeaderAndGuidingEntry
        inc wGameStateRoutine1,b
        stz wGameStateStep,b
        plp
        rtl

        .databank 0

        ; 80/C1BA

    .endsection Unsorted80C1A0Section


    .section Unsorted80C1CASection

      .al
      .xl

      rlUnknown80C1CA ; 80/C1CA

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 80/C1CB

    .endsection Unsorted80C1CASection


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
        sta wGameStateRoutine1,b
        stz wGameStateStep,b
        stz wGameStateRoutine2,b
        lda #$C162
        sta wVBlankPointer
        lda #<>rsUnknown809D4F
        sta wMainLoopPointer
        jsl rlEnableVBlank
        jsl rlDisableForcedBlank
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

        jsl rlHaltUntilVBlank
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
        jsl rlResetIRQEngine
        jsl rlUnknown82E400
        jsl rlUnknown8780AA
        jsl rlUnknown82F211

        jsr rsUnknown80E4B3
        jsr rsUnknown80E4EB
        jsr rsUnknown80E54D

        lda $7F8400
        sta wGameStateStep,b

        lda #$0027
        sta wGameStateRoutine1,b
        lda #$0026
        sta wGameStateRoutine2,b

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
        sta wDebugMenuScreenIndex
        sta wDebugMenuTemp1
        sta wDebugMenuTemp2
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
        jsl rlUnitWindowFillBG3Buffer

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


    .section Unsorted80E598Section

      .al
      .xl

      rsUnknown80E598 ; 80/E598

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        php
        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        lda #<>rsUnknown80BB9B
        sta wVBlankPointer
        jsl rlHaltUntilVBlank
        jsl rlDisableVBlank
        jsl rlHardwareResetScreenPosMathHDMA
        jsl rlHardwareResetScreenRegisters
        lda #$0000
        sta wR1
        lda #$0000
        sta wR3
        lda #$4000
        sta wR5
        lda #$2000
        sta wR6
        lda #$2800
        sta wR8
        jsl rlSetLayerPositionsAndSizes
        jsl rlProcEngineResetProcEngine
        jsl rlActiveSpriteEngineReset
        jsl rlResetHDMAEngine
        jsl rlResetIRQEngine
        jsl rlUnknown82E400
        jsl rlUnknown8780AA
        jsl rlUnknown82F211
        jsr rsUnknown80E627
        jsr rsUnknown80E6C9
        jsr rsUnknown80E8F0
        jsr rsUnknown80E951
        jsr rsUnknown80E746
        jsl rlUnknown89ED12
        jsl rlUnknown89F246
        jsl rlUnknown89F065
        lda #$0000
        sta wGameStateStep,b
        lda #$002A
        sta wGameStateRoutine1,b
        lda #$0029
        sta wGameStateRoutine2,b
        lda #<>rsUnknown809D4F
        sta wMainLoopPointer
        jsl rlEnableVBlank
        plp
        rts

        .databank 0

        ; 80/E627

      rsUnknown80E627 ; 80/E627

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta $7F8400
        sta $7F8428
        lda #$0023
        sta $7F8426
        lda #$0000
        sta $7F842C
        jsl rlGetCurrentSaveCompletionCount
        cmp #$0000
        beq _E650
        lda #$0001
        sta $7F842C

        _E650
        jsl rlGetAnimationOptionSetting
        sta wDebugMenuScreenIndex
        sta wDebugMenuTemp3
        jsl rlCheckIfTerrainWindowSettingOff
        sta $7F8404
        sta $7F8416
        jsl rlCheckIfUnitWindowSettingOff
        sta $7F8406
        sta $7F8418
        jsl rlGetTextSpeedOption
        sta $7F8408
        sta $7F841A
        jsl rlUnknown87BF1B
        sta $7F840A
        sta $7F841C
        jsl rlUnknown87BF43
        sta $7F840C
        sta $7F841E
        jsl rlUnknown87BFB0
        sta wR0
        cmp #$0000
        beq _E6A8
        jsl rlUnknown87BFD9
        inc a

        _E6A8
        sta $7F840E
        sta $7F8420
        jsl rlUnknown87C02F
        sta wDebugMenuTemp1
        sta $7F8422
        jsl rlGetCleverModeFlag
        sta wDebugMenuTemp2
        sta $7F8424
        rts

        .databank 0

        ; 80/E6C9

      rsUnknown80E6C9 ; 80/E6C9

        .al
        .xl
        .autsiz
        .databank ?

        lda #$8000
        sta lR19+1
        lda #$E72E
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        jsl rlDMAByStruct

          .structDMAToVRAM $DE48C0, $1800, $80, $1800

        jsl rlDMAByStruct

          .structDMAToVRAM $DD72B0, $0C00, $80, $6000

        jsl rlDMAByStruct

          .structDMAToVRAM $DE40C0, $0400, $80, $8000

        lda #$8000
        sta lR19+1
        lda #$E736
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        ldx #$0200

        _E70F
        lda $DDFFFE,x
        sta wJoy2RepeatTimer,x
        dec x
        dec x
        bne _E70F
        lda #$0000
        sta aBGPaletteBuffer,b
        lda #$8000
        sta lR19+1
        lda #$E73E
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        rts

        .databank 0

        ; 80/E72E

    .endsection Unsorted80E598Section


    .section Unsorted80E746Section

      .al
      .xl

      rsUnknown80E746 ; 80/E746

        .al
        .xl
        .autsiz
        .databank ?

        lda #$8000
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$E586
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$02EF
        jsl rlUnitWindowFillBG3Buffer
        lda #$3C00
        sta wR1
        lda #$02E2
        sta wR2
        lda #$0004
        sta wR0
        ldx #$0048
        jsl rlDrawBG3TileRun
        lda #$3C00
        sta wR1
        lda #$02E0
        sta wR2
        lda #$0002
        sta wR0
        ldx #$005C
        jsl rlDrawBG3TileRun
        lda #$3000
        sta wR1
        lda #$02CB
        sta wR2
        lda #$0005
        sta wR0
        ldx #$006E
        jsl rlDrawBG3TileRun
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda #$8000
        sta lR18+1
        lda #$E84E
        sta lR18
        ldx #$0404
        jsl rlDrawMenuTextLine
        lda #$8000
        sta lR18+1
        lda #$E85E
        sta lR18
        ldx #$0604
        jsl rlDrawMenuTextLine
        lda #$8000
        sta lR18+1
        lda #$E870
        sta lR18
        ldx #$0804
        jsl rlDrawMenuTextLine
        lda #$8000
        sta lR18+1
        lda #$E884
        sta lR18
        ldx #$0A04
        jsl rlDrawMenuTextLine
        lda #$8000
        sta lR18+1
        lda #$E898
        sta lR18
        ldx #$0C04
        jsl rlDrawMenuTextLine
        lda #$8000
        sta lR18+1
        lda #$E8AC
        sta lR18
        ldx #$0E04
        jsl rlDrawMenuTextLine
        lda #$8000
        sta lR18+1
        lda #$E8BE
        sta lR18
        ldx #$1004
        jsl rlDrawMenuTextLine
        lda #$8000
        sta lR18+1
        lda #$E8CC
        sta lR18
        ldx #$1204
        jsl rlDrawMenuTextLine
        lda $7F842C
        beq _E840
        lda #$8000
        sta lR18+1
        lda #$E8DC
        sta lR18
        ldx #$1404
        jsl rlDrawMenuTextLine

        _E840
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0800, $80, $5000

        rts

        .databank 0

        ; 80/E84E

    .endsection Unsorted80E746Section


    .section Unsorted80E8F0Section

      .al
      .xl

      rsUnknown80E8F0 ; 80/E8F0

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda bBufferBG1SC
        and #$FC
        ora #$02
        sta bBufferBG1SC
        lda bBufferBG2SC
        and #$FC
        ora #$02
        sta bBufferBG2SC
        lda bBufferBG3SC
        and #$FC
        ora #$02
        sta bBufferBG3SC
        lda #$15
        sta bBufferTM
        lda #$00
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
        lda #$00
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

        ; 80/E951

      rsUnknown80E951 ; 80/E951

        .al
        .xl
        .autsiz
        .databank ?

        lda #$8000
        sta lR44+1
        lda #$E96E
        sta lR44
        jsl rlHDMAEngineCreateEntry
        lda #$8000
        sta lR44+1
        lda #$E9A4
        sta lR44
        jsl rlHDMAEngineCreateEntry
        rts

        .databank 0

        ; 80/E96E

    .endsection Unsorted80E8F0Section


    .section Unsorted80E979Section

      .al
      .xl

      rlUnknown80E979 ; 80/E979

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 80/E97A

    .endsection Unsorted80E979Section


    .section Unsorted80E97CSection

      .al
      .xl

      rlUnknown80E97C ; 80/E97C

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0000

        _E97F
        lda $80E98E,x
        sta $7F855A,x
        beq _E98D
        inc x
        inc x
        bra _E97F


        _E98D
        rtl

        .databank 0

        ; 80/E98E

    .endsection Unsorted80E97CSection


    .section Unsorted80E9AFSection

      .al
      .xl

      rlUnknown80E9AF ; 80/E9AF

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 80/E9B0

    .endsection Unsorted80E9AFSection


    .section Unsorted80E9B2Section

      .al
      .xl

      rlUnknown80E9B2 ; 80/E9B2

        .al
        .xl
        .autsiz
        .databank ?

        phk
        plb
        .databank $80
        ldx #$0000
        lda $7F842C
        beq _E9D8

        _E9BD
        sep #$20
        lda $E9F3,b,x
        sta $7F875A,x
        rep #$20
        lda $E9F4,b,x
        sta $7F875B,x
        inc x
        inc x
        inc x
        cpx #$008D
        bne _E9BD
        rtl


        _E9D8
        sep #$20
        lda $EA80,b,x
        sta $7F875A,x
        rep #$20
        lda $EA81,b,x
        sta $7F875B,x
        inc x
        inc x
        inc x
        cpx #$00B7
        bne _E9D8
        rtl

        .databank 0

        ; 80/E9F3

    .endsection Unsorted80E9B2Section


    .section Unsorted80F222Section

      .al
      .xl

      rsUnknown80F222 ; 80/F222

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
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
        stz aSave.wMenuOperation,b
        jsl rlUnknown91E52B
        jsl rlUnknown91D6EC
        lda #$0004
        sta wGameStateRoutine2,b
        lda #$0005
        sta wGameStateRoutine1,b
        lda #$0002
        sta wGameStateStep,b
        lda #$0001
        sta $1864,b
        lda #<>rsUnknown80F560
        sta wVBlankPointer
        lda #<>rsUnknown80F542
        sta wMainLoopPointer
        lda #(`procFadeIn)<<8
        sta lR44+1
        lda #<>procFadeIn
        sta lR44
        jsl rlProcEngineCreateProc
        jsl rlEnableVBlank
        sep #$20
        lda #$00
        sta bBufferINIDISP
        rep #$20
        plp
        cli
        rts

        .databank 0

        ; 80/F27C

      rsUnknown80F27C ; 80/F27C

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        php
        jsl rlProcEngineResetProcEngine
        jsl rlActiveSpriteEngineReset
        jsl rlEnableActiveSpriteEngine
        jsl rlResetHDMAEngine
        jsl rlResetIRQEngine
        jsl rlUnknown8780AA
        jsl rlUnknown82F211
        lda #$00FF
        sta wUnknown053E,b
        lda #$0004
        sta wGameStateRoutine2,b
        lda #$0006
        sta wGameStateRoutine1,b
        lda #$0023
        sta wGameStateStep,b
        lda #<>rsUnknown80F560
        sta wVBlankPointer
        lda #<>rsUnknown809D4F
        sta wMainLoopPointer
        plp
        cli
        rts

        .databank 0

        ; 80/F2BE

    .endsection Unsorted80F222Section


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

        lda #<>rsUnknown80BB9B
        sta wVBlankPointer
        jsl rlHaltUntilVBlank
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
        jsl rlResetIRQEngine
        jsl rlUnknown82E400
        jsl rlUnknown8780AA
        jsl rlUnknown82F211

        jsr rsUnknown80F340
        jsr rsUnknown80F392
        jsr rsUnknown80F4EB

        lda #$0024
        sta wGameStateStep,b
        lda #5
        sta wGameStateRoutine1,b
        lda #4
        sta wGameStateRoutine2,b

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
        jsl rlUnitWindowFillBG3Buffer
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


    .section Unsorted80F443Section

      .al
      .xl

      rsUnknown80F443 ; 80/F443

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $00C0, $80, $A300

        rts

        .databank 0

        ; 80/F451

    .endsection Unsorted80F443Section


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

        ; Found by tools/sweep.py.
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

        ; Found by tools/sweep.py.
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

        ; Found by tools/sweep.py.
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
        jsl rlHandlePossibleHDMA
        jsl rlCopyPPURegisterBuffer
        jsl rlUnknown8090A2
        jsl rlGetJoypadInput
        jsl rlIncreaseFrameCounters
        jsl rlClearSpriteExtBuffer
        jsl rlRunGameStateRoutines
        jsl rlUnknown809C7A
        jsl rlHideSprites
        jsl rlUnknown8095CD
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

        ; Found by tools/sweep.py.
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
        jsl rlHandlePossibleHDMA
        jsl rlCopyPPURegisterBuffer
        jsl rlUnknown8090A2
        jsl rlGetJoypadInput
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


    .section Table8CDC00Section

      .al
      .xl

      aUnknown8CDC00 ; 8C/DC00

        ; Read by rlUnknown80B452.

        .word $5F37, $1CE7, $7FFD, $0400, $7FFF, $0000, $0000, $0000
        .word $110A, $0CC8, $08A7, $0465, $0044, $0002, $0000, $0993
        .word $577E, $041F, $0000, $0000, $0000, $1CC5, $2526, $0000

        ; 8C/DC30

    .endsection Table8CDC00Section


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


