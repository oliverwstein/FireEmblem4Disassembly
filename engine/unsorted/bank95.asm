; Code from bank $95 not yet assigned to a game system.

    .section Unsorted9599E7Section

      .al
      .xl

      rlUnknown9599E7 ; 95/99E7

        .al
        .autsiz
        .databank ?

        lda #$2940
        jsr $9594F8

        lda #$2940
        jsr $959537

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
        jsr $959B84

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
        jsr $959BC1
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
