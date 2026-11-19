; Code from bank $96 not yet assigned to a game system.

    .section Unsorted96D659Section

      .al
      .xl

      rlUnknown96D659 ; 96/D659

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000

        _D65D
        sep #$20
        lda #$80
        sta $7FFD9A,x
        rep #$20
        txa
        clc
        adc #$000A
        tax
        cpx #$0064
        bcc _D65D
        lda #$0000
        sta $7FFDFE
        plx
        rtl

        .databank 0

        ; 96/D67B

    .endsection Unsorted96D659Section


    .section Unsorted96D695Section

      .al
      .xl

      rlUnknown96D695 ; 96/D695

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        ldx #$0000

        _D69A
        lda $7FFD9A,x
        bit #$0080
        bne _D6CE
        lda $7FFDA3,x
        and #$00FF
        beq _D6BB
        sep #$20
        lda $7FFDA3,x
        dec a
        sta $7FFDA3,x
        rep #$20
        bra _D6CE


        _D6BB
        lda $7FFD9A,x
        and #$003F
        sta wR0
        txy
        phx
        lda wR0
        asl a
        tax
        jsr ($96D6DD,x)
        plx

        _D6CE
        txa
        clc
        adc #$000A
        tax
        txy
        cpx #$0064
        bcc _D69A
        ply
        plx
        rtl

        .databank 0

        ; 96/D6DD

    .endsection Unsorted96D695Section


    .section Unsorted96DB94Section

      .al
      .xl

      rlUnknown96DB94 ; 96/DB94

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        ldy #$0000
        lda [lR18],y
        inc y
        and #$00FF
        sta wR10
        lda #$000A
        sta wR11
        jsl rlUnsignedMultiply16By16
        ldx wR12
        sep #$20
        lda [lR18],y
        and #$3F
        pha
        inc y
        sta $7FFD9A,x
        lda wR0
        beq _DBC6
        lda $7FFD9A,x
        ora #$40
        sta $7FFD9A,x

        _DBC6
        lda [lR18],y
        inc y
        sta $7FFDA0,x
        lda [lR18],y
        inc y
        sta $7FFDA1,x
        lda #$00
        sta $7FFDA3,x
        sta $7FFDA2,x
        pla
        cmp #$00
        beq _DC1B
        cmp #$01
        beq _DC1B
        cmp #$02
        beq _DC1B
        cmp #$03
        beq _DC3A
        cmp #$04
        beq _DC3A
        cmp #$05
        beq _DC3A
        cmp #$06
        beq _DC3A
        cmp #$07
        beq _DC42
        cmp #$08
        beq _DC60
        cmp #$09
        beq _DC60
        cmp #$0A
        beq _DC62
        cmp #$0B
        beq _DC60
        cmp #$0C
        beq _DC1B
        lda #$80
        sta $7FFD9A,x
        bra _DC77


        _DC1B
        lda [lR18],y
        inc y
        sta $7FFD9B,x
        sta $7FFD9E,x
        lda [lR18],y
        inc y
        sta $7FFD9C,x
        sta $7FFD9F,x
        lda [lR18],y
        inc y
        sta $7FFD9D,x
        bra _DC77


        _DC3A
        lda [lR18],y
        sta $7FFDA2,x
        bra _DC77


        _DC42
        lda [lR18],y
        inc y
        sta $7FFDA2,x
        lda [lR18],y
        inc y
        sta $7FFD9B,x
        lda [lR18],y
        inc y
        sta $7FFD9C,x
        lda [lR18],y
        inc y
        sta $7FFD9D,x
        bra _DC77


        _DC60
        bra _DC77


        _DC62
        lda [lR18],y
        inc y
        sta $7FFD9B,x
        lda [lR18],y
        inc y
        sta $7FFD9C,x
        lda [lR18],y
        inc y
        sta $7FFD9D,x

        _DC77
        rep #$20
        ply
        plx
        rtl

        .databank 0

        ; 96/DC7C

    .endsection Unsorted96DB94Section
