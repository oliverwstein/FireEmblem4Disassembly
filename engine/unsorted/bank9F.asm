; Code from bank $9F not yet assigned to a game system.

    .section Unsorted9F86B0Section

      .al
      .xl

      rlUnknown9F86B0 ; 9F/86B0

        .al
        .autsiz
        .databank ?

        lda bDecompressionArrayFlag,b
        bne +

          lda aProcSystem.aHeaderBitfield,b,x
          ora #1
          sta aProcSystem.aHeaderBitfield,b,x

        +
        rtl

        .databank 0

        ; 9F/86BF

    .endsection Unsorted9F86B0Section


    .section Unsorted9FF3EDSection

      .al
      .xl

      rlUnknown9FF3ED ; 9F/F3ED

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000
        lda wR0
        bpl _F3FC
        ldx #$0004
        eor #$FFFF
        inc a

        _F3FC
        sta wR0
        lda wR1
        bpl _F408
        inc x
        inc x
        eor #$FFFF
        inc a

        _F408
        sta wR1
        cmp wR0
        bpl _F42F
        sep #$20
        stz $4204,b
        lda wR1
        sta $4205,b
        lda wR0
        sta $4206,b
        nop
        nop
        nop
        rep #$20
        jsr ($9FF427,x)
        plx
        rtl

        .byte $50, $F4, $5E, $F4, $68, $F4, $76, $F4


        _F42F
        sep #$20
        stz $4204,b
        lda wR0
        sta $4205,b
        lda wR1
        sta $4206,b
        nop
        nop
        nop
        rep #$20
        jsr ($9FF448,x)
        plx
        rtl

        .databank 0

        ; 9F/F448

    .endsection Unsorted9FF3EDSection
