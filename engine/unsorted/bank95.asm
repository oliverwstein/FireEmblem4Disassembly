; Code from bank $95 not yet assigned to a game system.

    .section Unsorted9594F8Section

      .al
      .xl

      rlUnknown9594F8 ; 95/94F8

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

      rlUnknown959537 ; 95/9537

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
        lda $959890
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
        lda $959894
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
        lda $959890,x
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


    .section Unsorted9599E7Section

      .al
      .xl

      rlUnknown9599E7 ; 95/99E7

        .al
        .autsiz
        .databank ?

        lda #$2940
        jsr rlUnknown9594F8

        lda #$2940
        jsr rlUnknown959537

        ldx #2
        
          -
          lda $E00060,x
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
        jsr rlUnknown959BC1
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
          lda $998944,x
          sta $01C2,b,y
          inc x
          inc x
          inc y
          inc y
          cpy #16
          bcc -

        ldy #0
        
          -
          lda $998944,x
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

      rlUnknown959BC1 ; 95/9BC1

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
        lda $998944,x
        sta $01E2,b,y
        inc x
        inc x
        inc y
        inc y
        cpy #$0010
        bcc _9BD8
        ldy #$0000

        _9BEB
        lda $998944,x
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
