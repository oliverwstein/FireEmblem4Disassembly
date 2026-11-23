; Menu text helpers: measuring a menu text string, drawing a line of menu text
; into a map menu's tilemap, drawing a number into the BG3 tilemap, and drawing a
; run of two-row tiles into it (rlDrawBG3TileRun).

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
        lda @l wMapMenuClearTile
        sta [lR23],y
        tya
        clc
        adc wR2
        tay
        lda @l wMapMenuClearTile
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

      aUnknown879481 ; 87/9481

        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00CE, $00FF, $00FF, $01AF, $00CF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $01BF, $00DF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00CD, $40CD, $00FF, $00FF, $00FF, $0109, $0109
        .word $0109, $00DD, $40DD, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $0164, $0165, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $0174, $0175, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $011A, $0109
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $0107, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $010C, $811C, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $011C, $810C, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $0120, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $0130, $0121, $0122, $0123, $0124, $0125
        .word $0126, $0127, $0128, $0131, $0132, $0133, $0134, $0135
        .word $0136, $0137, $0138, $0129, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $0139, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $012A, $012B, $012C, $012D, $012E
        .word $012F, $0140, $0141, $013A, $013B, $013C, $013D, $013E
        .word $013F, $0150, $0151, $0142, $0143, $0144, $0145, $0146
        .word $0147, $0148, $0149, $0152, $0153, $0154, $0155, $0156
        .word $0157, $0158, $0159, $014A, $014B, $014C, $014D, $014E
        .word $014F, $0160, $0161, $015A, $015B, $015C, $015D, $015E
        .word $015F, $0170, $0171, $0162, $0163, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $0172, $0173, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00F3, $0000, $00FF, $0001, $00FF, $0002
        .word $00FF, $0003, $00FF, $0010, $00F3, $0011, $00F4, $0012
        .word $00F5, $0013, $00F6, $0004, $0005, $0060, $0006, $0061
        .word $0007, $0062, $0008, $0014, $0015, $0015, $0016, $0016
        .word $0017, $0017, $0018, $0063, $0009, $0064, $000A, $0065
        .word $000B, $0066, $000C, $0018, $0019, $0019, $001A, $001A
        .word $001B, $001B, $001C, $0067, $000D, $0068, $000E, $0069
        .word $000F, $006A, $0020, $001C, $001D, $001D, $001E, $001E
        .word $001F, $001F, $0030, $006B, $00FF, $0021, $006C, $0022
        .word $006D, $0023, $006E, $0030, $00F9, $0031, $0031, $0032
        .word $0032, $0033, $0033, $0024, $0025, $0026, $0027, $0028
        .word $0029, $006F, $0074, $0034, $0035, $0036, $0037, $0038
        .word $0039, $0039, $0039, $002A, $0070, $0075, $002B, $0071
        .word $0076, $002C, $0072, $003A, $003A, $003A, $003B, $003B
        .word $003B, $003C, $003C, $0077, $002D, $0073, $0078, $002E
        .word $002F, $0040, $0041, $003C, $003D, $003D, $003D, $003E
        .word $003F, $0050, $0051, $0042, $00FF, $0043, $00FF, $0044
        .word $00FF, $0045, $0046, $0052, $00F8, $0053, $00FA, $0054
        .word $00FB, $0055, $0056, $0047, $0048, $0049, $004A, $00FF
        .word $004B, $00FF, $00FF, $0057, $0058, $0059, $005A, $00FF
        .word $005B, $00FF, $00FF, $004C, $004D, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $005C, $005D, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $0080, $00FF, $0081, $00FF
        .word $0082, $00FF, $0083, $00FC, $0090, $00FD, $0091, $00FE
        .word $0092, $0100, $0093, $00FF, $0084, $0085, $0079, $0086
        .word $007A, $0087, $007B, $0101, $0094, $0095, $0095, $0096
        .word $0096, $0097, $0097, $0088, $007C, $0089, $007D, $008A
        .word $007E, $008B, $007F, $0098, $0098, $0099, $0099, $009A
        .word $009A, $009B, $009B, $008C, $00E0, $008D, $00E1, $008E
        .word $00E2, $008F, $00E3, $009C, $009C, $009D, $009D, $009E
        .word $009E, $009F, $009F, $00A0, $00E4, $00FF, $00A1, $00E5
        .word $00A2, $00E6, $00A3, $00B0, $00B0, $0103, $00B1, $00B1
        .word $00B2, $00B2, $00B3, $00E7, $00A4, $00A5, $00A6, $00A7
        .word $00A8, $00A9, $00E8, $00B3, $00B4, $00B5, $00B6, $00B7
        .word $00B8, $00B9, $00B9, $00ED, $00AA, $00E9, $00EE, $00AB
        .word $00EA, $00EF, $00AC, $00B9, $00BA, $00BA, $00BA, $00BB
        .word $00BB, $00BB, $00BC, $00EB, $00F0, $00AD, $00EC, $00F1
        .word $00AE, $00AF, $00FF, $00BC, $00BC, $00BD, $00BD, $00BD
        .word $00BE, $00BF, $00FF, $00C0, $00C1, $00C2, $00FF, $00C3
        .word $00FF, $00C4, $00FF, $00D0, $00D1, $00D2, $0102, $00D3
        .word $0104, $00D4, $0105, $00C5, $00C6, $00C7, $00C8, $00C9
        .word $00CA, $00FF, $00CB, $00D5, $00D6, $00D7, $00D8, $00D9
        .word $00DA, $00FF, $00DB, $00FF, $00FF, $00FF, $00CC, $00F2
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00DC, $0092
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF

        ; 87/9D77

    .endsection Table879471Section


    .section Table879D77Section

      .al
      .xl

      aUnknown879D77 ; 87/9D77

        ; Fifteen 6-byte records. Read by rlDrawMenuTextLine.

        .byte $8C, $95, $0F, $01, $1F, $01
        .byte $8C, $C9, $A1, $02, $B1, $02
        .byte $89, $F1, $6E, $01, $7E, $01
        .byte $8F, $E9, $6B, $01, $7B, $01
        .byte $95, $BA, $66, $01, $76, $01
        .byte $91, $E5, $0E, $01, $1E, $01
        .byte $8F, $91, $0D, $01, $1D, $01
        .byte $8F, $F1, $6A, $01, $7A, $01
        .byte $8D, $91, $69, $01, $79, $01
        .byte $8C, $52, $6C, $01, $7C, $01
        .byte $92, $E9, $68, $01, $78, $01
        .byte $8C, $6E, $6D, $01, $7D, $01
        .byte $93, $C1, $0B, $01, $1B, $01
        .byte $8C, $F8, $67, $01, $77, $01
        .byte $95, $94, $A4, $01, $B4, $01

        ; 87/9DD1

      rlUnknown879DD1 ; 87/9DD1

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        phx
        pha
        and #$00FF
        cmp #$0084
        pla
        bcs _9E19
        pha
        and #$00FF
        sec
        sbc #$0081
        asl a
        tax
        lda aUnknown879471,x
        sta wR10
        pla
        xba
        and #$00FF
        sec
        sbc #$0040
        pha
        and #$0007
        sta wR11
        pla
        and #$FFF8
        asl a
        clc
        adc wR11
        asl a
        clc
        adc wR10
        tax
        lda aUnknown879471,x
        sta wR10
        lda aUnknown879481,x
        sta wR11
        plx
        plp
        plb
        .databank ?
        rtl


        _9E19
        ldx #$0000

        _9E1C
        cmp $9D77,b,x
        beq _9E2E
        inc x
        inc x
        inc x
        inc x
        inc x
        inc x
        cpx #$005A
        bcc _9E1C
        bra _9E3C


        _9E2E
        lda $9D79,b,x
        sta wR10
        lda $9D7B,b,x
        sta wR11

        _9E38
        plx
        plp
        plb
        .databank ?
        rtl


        _9E3C
        stz wR10
        stz wR11
        bra _9E38

        .databank 0

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


    .section Unsorted80B0A3Section

      .al
      .xl

      rlLoadDefaultWindowBorderPalette ; 80/B0A3

        .al
        .xl
        .autsiz
        .databank ?

        ; Sets default window border palette colors in $0108..$010F

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

      rlLoadMenuFontGraphics ; 80/B0BC

        .al
        .xl
        .autsiz
        .databank ?

        ; Decompresses and DMAs gcUnknownC00A2B ($1800 bytes) to VRAM $4000

        lda #(`aDecompressionDMAEntry80B0CB)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry80B0CB
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        rtl

        .databank 0

        ; 80/B0CB

    .endsection Unsorted80B0A3Section


    .section Unsorted80B0D3Section

      .al
      .xl

      rlQueueMenuFontDecompression ; 80/B0D3

        .al
        .xl
        .autsiz
        .databank ?

        ; Queues gcUnknownC00A2B decompression into aDecompressionBuffer via rlAppendDecompList

        phx
        lda #(`gcUnknownC00A2B)<<8
        sta lR18+1
        lda #<>gcUnknownC00A2B
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

      rlLoadMenuIconGraphics ; 80/B0EE

        .al
        .xl
        .autsiz
        .databank ?

        ; Decompresses and DMAs gcUnknownC0197B ($0800 bytes) to VRAM $4C00

        lda #(`aDecompressionDMAEntry80B0FD)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry80B0FD
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        rtl

        .databank 0

        ; 80/B0FD

    .endsection Unsorted80B0D3Section


    .section Unsorted89BECCSection

      .al
      .xl

      rlDrawBG3TileRun ; 89/BECC

        .al
        .xl
        .autsiz
        .databank ?

        ; wR0 tiles, starting at tile wR2 with attributes wR1, at X in the BG3 tilemap buffer; each tile has the tile $10 after it on the row below. Used by many menus.

        lda wR2
        ora wR1
        sta wR2

        _BED2
        lda wR2
        sta aBG3TilemapBuffer,x
        lda wR2
        clc
        adc #$0010
        sta $7E83C8,x
        inc x
        inc x
        inc wR2
        dec wR0
        bne _BED2
        rtl

        .databank 0

        ; 89/BEEB

    .endsection Unsorted89BECCSection


    .section Unsorted91AA15Section

      .as
      .xl

      rsSplitNumberIntoFiveDigits ; 91/AA15

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ; Splits A into five decimal digits at [lR19].

        php
        phx
        phy
        ldy #$0000
        sta wR13
        lda #$2710
        sta wR14
        jsl rlUnsignedDivide16By16R13
        lda wR13
        sta [lR19],y
        inc x
        inc y
        lda wR10
        sta wR13
        lda #$03E8
        sta wR14
        jsl rlUnsignedDivide16By16R13
        lda wR13
        sta [lR19],y
        inc x
        inc y
        lda wR10
        sta wR13
        lda #$0064
        sta wR14
        jsl rlUnsignedDivide16By16R13
        lda wR13
        sta [lR19],y
        inc x
        inc y
        lda wR10
        sta wR13
        lda #$000A
        sta wR14
        jsl rlUnsignedDivide16By8
        lda wR13
        sta [lR19],y
        inc x
        inc y
        sep #$20
        lda wR10
        sta [lR19],y
        ply
        plx
        plp
        rts

        .databank 0

        ; 91/AA6F

    .endsection Unsorted91AA15Section


    .section Unsorted91AA6FSection

      .al
      .xl

      rsDrawFiveDigitNumber ; 91/AA6F

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ; Draws the five digits at [lR19] as map menu tiles at X, leading zeros blank.

        phx
        phy
        ldy #$0000
        sty wR0
        lda [lR19],y
        and #$00FF
        bne _AA86
        cmp wR0
        bne _AA86
        jsr rsDrawBlankDigit
        bra _AA8C


        _AA86
        jsl rlDrawDigitTile
        inc wR0

        _AA8C
        inc x
        inc y
        lda [lR19],y
        and #$00FF
        bne _AA9E
        cmp wR0
        bne _AA9E
        jsr rsDrawBlankDigit
        bra _AAA4


        _AA9E
        jsl rlDrawDigitTile
        inc wR0

        _AAA4
        inc x
        inc y
        lda [lR19],y
        and #$00FF
        bne _AAB6
        cmp wR0
        bne _AAB6
        jsr rsDrawBlankDigit
        bra _AABC


        _AAB6
        jsl rlDrawDigitTile
        inc wR0

        _AABC
        inc x
        inc y
        lda [lR19],y
        and #$00FF
        bne _AACE
        cmp wR0
        bne _AACE
        jsr rsDrawBlankDigit
        bra _AAD4


        _AACE
        jsl rlDrawDigitTile
        inc wR0

        _AAD4
        inc x
        inc y
        lda [lR19],y
        and #$00FF
        jsl rlDrawDigitTile
        ply
        plx
        rts

        .databank 0

        ; 91/AAE2

    .endsection Unsorted91AA6FSection


    .section Unsorted91AAE2Section

      .as
      .xl

      rsDrawBlankDigit ; 91/AAE2

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #(`aBlankDigitTileString)<<8
        sta lR18+1
        lda #<>aBlankDigitTileString
        sta lR18
        lda aCurrentTilemapInfo,b
        pha
        lda #$2000
        sta aCurrentTilemapInfo,b
        jsl rlDrawMapMenuTileString
        txa
        clc
        adc #$0100
        tax
        jsl rlDrawMapMenuTileString
        pla
        sta aCurrentTilemapInfo,b
        plx
        rts

        .databank 0

        ; 91/AB0B

      aBlankDigitTileString ; 91/AB0B

        .word $00FF

      rlDrawDigitTile ; 91/AB0D

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws digit A (0-9) as a two-tile-high number in the active map menu tilemap at X (column low byte, row high byte). Carry set if A is not a digit.

        phb
        php
        phk
        plb
        .databank $91
        phx
        phy
        ldy wR0
        phy
        and #$00FF
        cmp #$000A
        bcc _AB22
        jml _AB87


        _AB22
        pha
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
        clc
        adc lR23
        sta lR23
        lda structMapMenuTilemapData.Width,b,y
        and #$00FF
        asl a
        sta wR0
        pla
        clc
        adc @l aCurrentTilemapInfo
        clc
        adc #$0030
        ora #$2000
        sta [lR23]
        clc
        adc #$0010
        ldy wR0
        sta [lR23],y
        pla
        sta wR0
        ply
        plx
        plp
        plb
        .databank ?
        clc

        _AB86
        rtl


        _AB87
        plx
        stx wR0
        ply
        plx
        plp
        plb
        .databank ?
        sec
        bra _AB86

        .databank 0

    .endsection Unsorted91AAE2Section


