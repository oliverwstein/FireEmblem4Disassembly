; Menu text helpers: measuring a menu text string, drawing a line of menu text
; into a map menu's tilemap, and drawing a number into the BG3 tilemap.

    .section GetMenuTextStringLengthSection

      .al
      .xl

      rlGetMenuTextStringLength ; 85/A205

        .al
        .autsiz
        .databank ?

        ; Input:
        ; lR18 = string pointer

        ; Output:
        ; wR10 = length

        pha
        phx
        phb
        php
        phk
        plb

        stz wR10

        ldx lR18
        sep #$20
        lda lR18+2
        pha
        rep #$20
        plb
        
          _Loop
          lda $0000,b,x
          beq _End

            inc x
            inc x
            inc wR10
            bra _Loop

        _End
        plp
        plb
        plx
        pla
        rtl

        .databank 0

        ; 85/A227

    .endsection GetMenuTextStringLengthSection


    .section DrawMenuTextLineSection

      .al
      .xl

      rlDrawMenuTextLine ; 87/9354

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws a line of menu text into the map menu's tilemap. The table at
        ; $879471 and the one at $879D77 are not disassembled yet.

        phb
        php
        phk
        plb
        .databank $87
        lda wR0
        pha
        lda wR1
        pha
        lda wR2
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
        lda $0006,b,y
        sta lR23
        lda $0007,b,y
        sta lR23+1
        stz wR0
        txa
        sep #$20
        sta wR0
        xba
        sta @l WRMPYA
        lda $0000,b,y
        sta @l WRMPYB
        nop
        nop
        nop
        rep #$20
        lda @l RDMPY
        clc
        adc wR0
        asl a
        pha
        lda $0000,b,y
        and #$00FF
        asl a
        sta wR2
        ply
        ldx lR18
        sep #$20
        lda lR18+2
        pha
        rep #$20
        plb
        .databank ?

        _93AE
        lda $0000,b,x
        beq _93C3
        and #$00FF
        cmp #$0084
        bcs _941D
        bra _93D1


        _93BD
        inc x
        inc x
        inc y
        inc y
        bra _93AE


        _93C3
        ply
        plx
        pla
        sta wR2
        pla
        sta wR1
        pla
        sta wR0
        plp
        plb
        .databank ?
        rtl


        _93D1
        phx
        sec
        sbc #$0081
        asl a
        tax
        lda $879471,x
        sta wR0
        plx
        phx
        phy
        lda $0001,b,x
        and #$00FF
        sec
        sbc #$0040
        pha
        and #$0007
        sta wR1
        pla
        and #$FFF8
        asl a
        clc
        adc wR1
        asl a
        clc
        adc wR0
        tax
        lda @l aCurrentTilemapInfo
        clc
        adc $879471,x
        sta [lR23],y
        tya
        clc
        adc wR2
        tay
        lda @l aCurrentTilemapInfo
        clc
        adc $879481,x
        sta [lR23],y
        ply
        plx
        bra _93BD


        _941D
        phx
        lda $0000,b,x
        ldx #$0000

        _9424
        cmp $879D77,x
        beq _9437
        inc x
        inc x
        inc x
        inc x
        inc x
        inc x
        cpx #$005A
        bcc _9424
        bra _9459


        _9437
        phy
        lda @l aCurrentTilemapInfo
        clc
        adc $879D79,x
        sta [lR23],y
        tya
        clc
        adc wR2
        tay
        lda @l aCurrentTilemapInfo
        clc
        adc $879D7B,x
        sta [lR23],y
        ply
        plx
        jml _93BD


        _9459
        phy
        lda @l wUnknown053C
        sta [lR23],y
        tya
        clc
        adc wR2
        tay
        lda @l wUnknown053C
        sta [lR23],y
        ply
        plx
        jml _93BD

        .databank 0

        ; 87/9471

    .endsection DrawMenuTextLineSection


    .section DrawMenuTextNumberSection

      .al
      .xl

      rlDrawMenuTextNumber ; 89/A18C

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws a number of up to 5 digits into aBG3TilemapBuffer. Each digit
        ; is two tiles high: the tile for digit n is wR5 + n, and the tile
        ; below it (one row down) is $10 further on.

        ; Inputs:
        ; A = number
        ; X = tilemap offset
        ; wR5 = tile and attributes of digit 0
        ; wR6 = width in digits: the number is right-aligned in that many
        ;       tiles and padded with tile $00FF. 0 draws just the digits,
        ;       left-aligned.

        ; Output:
        ; A = number of digits, or 0 if the number did not fit in wR6 digits

        phb
        php
        phk
        plb
        .databank $89
        phx
        phk
        plb
        .databank $89
        sta wR0
        stz wR1
        stz wR2
        stz wR3
        stz wR4
        ldx #$0006

        _A1A0
        lda wR0
        sec
        sbc @l aMenuTextNumberPowersOfTen,x
        bcc _A1AF
        sta wR0
        inc wR1,x
        bra _A1A0


        _A1AF
        dec x
        dec x
        bpl _A1A0
        lda #$0005
        ldx wR4
        bne _A1CA
        dec a
        ldx wR3
        bne _A1CA
        dec a
        ldx wR2
        bne _A1CA
        dec a
        ldx wR1
        bne _A1CA
        dec a

        _A1CA
        sta wR8
        asl a
        sta wR9
        lda wR6
        beq _A225
        asl a
        sta wR7
        tay
        plx
        txa
        clc
        adc aMenuTextNumberWidthOffsets,y
        tax
        ldy #$0000

        _A1E1
        lda $0000,b,y
        clc
        adc wR5
        pha
        sta aBG3TilemapBuffer,x
        pla
        clc
        adc #$0010
        sta aBG3TilemapBuffer+$40,x
        dec x
        dec x
        inc y
        inc y
        cpy wR7
        beq _A219
        cpy wR9
        bne _A1E1

        _A201
        lda #$00FF
        sta aBG3TilemapBuffer,x
        sta aBG3TilemapBuffer+$40,x
        dec x
        dec x
        inc y
        inc y
        cpy wR7
        bne _A201
        lda wR8

        _A216
        plp
        plb
        .databank ?
        rtl


        _A219
        lda wR8
        cmp wR6
        beq _A216
        lda #$0000
        plp
        plb
        .databank ?
        rtl


        _A225
        plx
        ldy wR9

        _A228
        lda $FFFE,b,y
        clc
        adc wR5
        pha
        sta aBG3TilemapBuffer,x
        pla
        clc
        adc #$0010
        sta aBG3TilemapBuffer+$40,x
        inc x
        inc x
        dec y
        dec y
        bne _A228
        lda wR8
        bra _A216

        .databank 0

      aMenuTextNumberWidthOffsets ; 89/A246

        .word 0, 0, 2, 4, 6, 8

      aMenuTextNumberPowersOfTen ; 89/A252

        .word 10, 100, 1000, 10000

        ; 89/A25A

    .endsection DrawMenuTextNumberSection
