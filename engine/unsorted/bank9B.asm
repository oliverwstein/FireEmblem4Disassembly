; Code from bank $9B not yet assigned to a game system.

    .section Unsorted9BFBC0Section

      .al
      .xl

      rlUnknown9BFBC0 ; 9B/FBC0

        .al
        .xl
        .autsiz
        .databank ?

        phx
        sep #$20
        lda #$00
        sta $7FD000
        lda #$01
        sta bBufferTM
        sta bBufferBGMODE
        sta bBufferOBSEL
        lda #$10
        sta bBufferBG1SC
        rep #$20
        jsl rlUnknown88EEB1
        jsl rlGetHighestCompletionCount
        cmp #$0010
        bcc _FBE7
        lda #$000F

        _FBE7
        sta $0CC2,b
        stz aBGPaletteBuffer,b
        lda #$0000
        sta $7FD001
        stz wBufferBG1HOFS
        stz wBufferBG1VOFS
        sep #$20
        rep #$10
        ldx #$2AFE
        stx DecompressionVariables
        lda #$DF
        sta $CA
        ldx #$8B88
        stx $CB
        lda #$7E
        sta $CD
        jsl rlDecompressor
        rep #$30
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $0820, $80, $0000

        sep #$20
        rep #$10
        ldx #$30CC
        stx DecompressionVariables
        lda #$DF
        sta $CA
        ldx #$8B88
        stx $CB
        lda #$7E
        sta $CD
        jsl rlDecompressor
        rep #$30
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $0060, $80, $4000

        sep #$20
        rep #$10
        ldx #$30E9
        stx DecompressionVariables
        lda #$DF
        sta $CA
        ldx #$8B88
        stx $CB
        lda #$7E
        sta $CD
        jsl rlDecompressor
        rep #$30
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $0700, $80, $2000

        ldx #$0000

        _FC76
        lda aUnknownE0283F,x
        sta $0122,b,x
        lda aUnknownE0285D,x
        sta $0222,b,x
        inc x
        inc x
        cpx #$001E
        bcc _FC76
        plx
        rtl

        .databank 0

        ; 9B/FC8D

    .endsection Unsorted9BFBC0Section


    .section Unsorted9BFC8DSection

      .al
      .xl

      rlUnknown9BFC8D ; 9B/FC8D

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FD000
        and #$00FF
        cmp #$0001
        beq _FCB9
        cmp #$0002
        beq _FCC4
        cmp #$0003
        beq _FCE4
        cmp #$0004
        beq _FD18
        cmp #$0005
        beq _FD28
        sep #$20
        lda #$0F
        sta bBufferINIDISP
        rep #$20
        jml _FD43


        _FCB9
        lda $04BA,b
        beq _FCC2
        jml _FD50


        _FCC2
        bra _FD43


        _FCC4
        sep #$20
        lda #$10
        sta bBufferTS
        lda #$02
        sta bBufferCGWSEL
        lda #$01
        sta bBufferCGADSUB
        rep #$20
        lda #$0028
        sta $7FD046
        lda #$0084
        jsl rlUnknown808FAD
        bra _FD43


        _FCE4
        lda $7FD001
        inc a
        sta $7FD001
        cmp #$0023
        bcc _FD01
        sep #$20
        stz bBufferTS
        rep #$20
        lda #$0000
        sta $7FD001
        bra _FD43


        _FD01
        lda $7FD046
        sta wR0
        jsr rsUnknown9BFD52
        lda $7FD046
        clc
        adc #$0005
        sta $7FD046
        bra _FD50


        _FD18
        lda $7FD001
        inc a
        sta $7FD001
        cmp #$0028
        bcs _FD43
        bra _FD50


        _FD28
        lda bBufferINIDISP
        and #$00FF
        beq _FD38
        sep #$20
        dec a
        sta bBufferINIDISP
        rep #$20
        bra _FD50


        _FD38
        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        sec
        bra _FD51


        _FD43
        sep #$20
        lda $7FD000
        inc a
        sta $7FD000
        rep #$20

        _FD50
        clc

        _FD51
        rtl

        .databank 0

        ; 9B/FD52

      rsUnknown9BFD52 ; 9B/FD52

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        phb
        sep #$20
        lda #$99
        pha
        plb
        .databank $99
        rep #$20
        lda #$0070
        sta wR1
        stz wR4
        stz wR5
        ldy #$FF6D
        jsl rlPushToOAMBuffer
        plb
        .databank $99
        ply
        plx
        rts

        .databank 0

        ; 9B/FD71

    .endsection Unsorted9BFC8DSection


    .section TableE0283FSection

      .al
      .xl

      aUnknownE0283F ; E0/283F

        ; Read by rlUnknown9BFBC0.

        .word $7FFF, $637C, $6739, $435E, $2F1D, $42B8, $4631, $2A33
        .word $15D2, $096F, $00EA, $00A7, $0443, $0421, $0400

        ; E0/285D

    .endsection TableE0283FSection
