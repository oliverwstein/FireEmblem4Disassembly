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
        pha
        lda structMapMenuTilemapData.Width,b,y
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
        lda aUnknown879471,x
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
        adc aUnknown879471,x
        sta [lR23],y
        tya
        clc
        adc wR2
        tay
        lda @l aCurrentTilemapInfo
        clc
        adc aUnknown879481,x
        sta [lR23],y
        ply
        plx
        bra _93BD


        _941D
        phx
        lda $0000,b,x
        ldx #$0000

        _9424
        cmp aUnknown879D77,x
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
        adc aUnknown879D77+2,x
        sta [lR23],y
        tya
        clc
        adc wR2
        tay
        lda @l aCurrentTilemapInfo
        clc
        adc aUnknown879D77+4,x
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


    .section Table879471Section

      .al
      .xl

      aUnknown879471 ; 87/9471

        ; Read by rlDrawMenuTextLine.

        .word $0006, $0306, $0606, $00FF, $00FF, $00FF, $00FF, $00FF

        ; 87/9481

    .endsection Table879471Section


    .section Table879D77Section

      .al
      .xl

      aUnknown879D77 ; 87/9D77

        ; Read by rlDrawMenuTextLine.

        .byte $8C, $95, $0F, $01, $1F, $01, $8C, $C9, $A1, $02, $B1, $02, $89, $F1, $6E, $01
        .byte $7E, $01, $8F, $E9, $6B, $01, $7B, $01, $95, $BA, $66, $01, $76, $01, $91, $E5
        .byte $0E, $01, $1E, $01, $8F, $91, $0D, $01, $1D, $01, $8F, $F1, $6A, $01, $7A, $01
        .byte $8D, $91, $69, $01, $79, $01, $8C, $52, $6C, $01, $7C, $01, $92, $E9, $68, $01
        .byte $78, $01, $8C, $6E, $6D, $01, $7D, $01, $93, $C1, $0B, $01, $1B, $01, $8C, $F8
        .byte $67, $01, $77, $01, $95, $94, $A4, $01, $B4, $01, $8B, $08, $4B, $AB, $DA, $48
        .byte $29, $FF, $00, $C9, $84, $00, $68, $B0, $39, $48, $29, $FF, $00, $38, $E9, $81
        .byte $00, $0A, $AA, $BD, $71, $94, $85, $14, $68, $EB, $29, $FF, $00, $38, $E9, $40
        .byte $00, $48, $29, $07, $00, $85, $16, $68, $29, $F8, $FF, $0A, $18, $65, $16, $0A
        .byte $18, $65, $14, $AA, $BD, $71, $94, $85, $14, $BD, $81, $94, $85, $16, $FA, $28
        .byte $AB, $6B, $A2, $00, $00, $DD, $77, $9D, $F0, $0D, $E8, $E8, $E8, $E8, $E8, $E8
        .byte $E0, $5A, $00, $90, $F0, $80, $0E, $BD, $79, $9D, $85, $14, $BD, $7B, $9D, $85
        .byte $16, $FA, $28, $AB, $6B, $64, $14, $64, $16, $80, $F6

        ; 87/9E42

    .endsection Table879D77Section


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
