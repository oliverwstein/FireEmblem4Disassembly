; Code from bank $9B not yet assigned to a game system.

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
