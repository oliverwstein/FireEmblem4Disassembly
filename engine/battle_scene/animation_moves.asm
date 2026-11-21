; Battle animation move routines: the moves below $80 in a combatant's queue
; (see aBattleAnimationPrograms) run one of these, through
; aBattleAnimationMoveRoutines (rlUnknown95B1AB). Not built before; what each
; does is not read yet.

    .section BattleAnimationMoves95B250Section

      .al
      .xl

      rsUnknown95B250 ; 95/B250

        .al
        .xl
        .autsiz
        .databank ?

        tax
        cpx #$0000
        bne _B259
        clc
        bra _B25A


        _B259
        sec

        _B25A
        jsl rlUnknown95DB55
        pha
        and #$00FF
        clc
        jsl rlUnknown95D0E7
        sep #$20
        lda $0AF3,b,x
        ora #$08
        sta $0AF3,b,x
        lda $0AF4,b,x
        ora #$08
        sta $0AF4,b,x
        rep #$20
        pla
        xba
        and #$00FF
        jsl rlUnknown95CE78
        lda wR1
        sta $0B0E,b,x
        lda wR0
        sta $0B10,b,x
        rts

        .databank 0

        ; 95/B28F

      rsUnknown95B28F ; 95/B28F

        .al
        .xl
        .autsiz
        .databank ?

        tax
        sec
        jsr rsUnknown95CEBF
        sep #$20
        lda $0AF3,b,x
        ora #$08
        sta $0AF3,b,x
        rep #$20
        lda #$0004
        jsl rlUnknown95CE78
        lda wR1
        sta $0B0E,b,x
        lda wR0
        sta $0B10,b,x
        rts

        .databank 0

        ; 95/B2B2

      rsUnknown95B2B2 ; 95/B2B2

        .al
        .xl
        .autsiz
        .databank ?

        tax
        sec
        jsr rsUnknown95CF2E
        sec
        jsl rlUnknown95B530
        lda wR0
        lsr a
        sta wR0
        sep #$20
        lda $0AF3,b,x
        ora #$08
        sta $0AF3,b,x
        rep #$20
        lda #$0008
        jsl rlUnknown95CE78
        lda wR1
        sta $0B0E,b,x
        lda wR0
        sta $0B10,b,x
        rts

        .databank 0

        ; 95/B2DF

    .endsection BattleAnimationMoves95B250Section


    .section BattleAnimationMoves95B332Section

      .al
      .xl

      rsUnknown95B332 ; 95/B332

        .al
        .xl
        .autsiz
        .databank ?

        phx
        tax
        sec
        jsr rsUnknown95D14E
        sec
        jsr rsUnknown95D23C
        sep #$20
        lda $0AF3,b,x
        ora #$10
        sta $0AF3,b,x
        lda $0AF3,b,x
        and #$DF
        sta $0AF3,b,x
        rep #$20
        plx
        rts

        .databank 0

        ; 95/B352

      rsUnknown95B352 ; 95/B352

        .al
        .xl
        .autsiz
        .databank ?

        phx
        tax
        sep #$20
        lda $0AF3,b,x
        ora #$20
        sta $0AF3,b,x
        rep #$20
        plx
        rts

        .databank 0

        ; 95/B362

    .endsection BattleAnimationMoves95B332Section


    .section BattleAnimationMoves95B3AFSection

      .al
      .xl

      rsUnknown95B3AF ; 95/B3AF

        .al
        .xl
        .autsiz
        .databank ?

        tax
        cpx #$0000
        bne _B3B8
        clc
        bra _B3B9


        _B3B8
        sec

        _B3B9
        jsl rlUnknown95DB55
        pha
        sep #$20
        lda $0AF3,b,x
        ora #$08
        sta $0AF3,b,x
        lda $0AF4,b,x
        ora #$08
        sta $0AF4,b,x
        rep #$20
        lda #1,s
        and #$00FF
        sta wR0
        pla
        xba
        and #$00FF
        jsl rlUnknown95CE78
        lda wR1
        sta $0B0E,b,x
        lda wR0
        sta $0B10,b,x
        rts

        .databank 0

        ; 95/B3ED

      rsUnknown95B3ED ; 95/B3ED

        .al
        .xl
        .autsiz
        .databank ?

        tax
        cpx #$0000
        bne _B3F6
        clc
        bra _B3F7


        _B3F6
        sec

        _B3F7
        jsl rlUnknown95DB55
        pha
        and #$00FF
        pha
        lda #$0028
        sta wR8
        pla
        jsr rsUnknown95D007
        sep #$20
        lda $0AF3,b,x
        ora #$08
        sta $0AF3,b,x
        lda $0AF4,b,x
        ora #$08
        sta $0AF4,b,x
        rep #$20
        pla
        xba
        and #$00FF
        jsl rlUnknown95CE78
        lda wR1
        sta $0B0E,b,x
        lda wR0
        sta $0B10,b,x
        rts

        .databank 0

        ; 95/B431

      rsUnknown95B431 ; 95/B431

        .al
        .xl
        .autsiz
        .databank ?

        tax
        cpx #$0000
        bne _B43A
        clc
        bra _B43B


        _B43A
        sec

        _B43B
        jsl rlUnknown95DB55
        pha
        and #$00FF
        pha
        lda #$0050
        sta wR8
        pla
        jsr rsUnknown95D007
        sep #$20
        lda $0AF3,b,x
        ora #$08
        sta $0AF3,b,x
        lda $0AF4,b,x
        ora #$08
        sta $0AF4,b,x
        rep #$20
        pla
        xba
        and #$00FF
        jsl rlUnknown95CE78
        lda wR1
        sta $0B0E,b,x
        lda wR0
        sta $0B10,b,x
        rts

        .databank 0

        ; 95/B475

    .endsection BattleAnimationMoves95B3AFSection


    .section BattleAnimationMoves95B48DSection

      .al
      .xl

      rsUnknown95B48D ; 95/B48D

        .al
        .xl
        .autsiz
        .databank ?

        tax
        cpx #$0000
        bne _B496
        clc
        bra _B497


        _B496
        sec

        _B497
        jsl rlUnknown95DB55
        pha
        and #$00FF
        pha
        lda #$0010
        sta wR8
        pla
        jsr rsUnknown95D007
        sep #$20
        lda $0AF3,b,x
        ora #$08
        sta $0AF3,b,x
        lda $0AF5,b,x
        ora #$80
        sta $0AF5,b,x
        lda $0AF3,b,x
        and #$DF
        sta $0AF3,b,x
        rep #$20
        pla
        xba
        and #$00FF
        pha
        lda wR0
        asl a
        sta wR0
        pla
        jsl rlUnknown95CE78
        lda wR1
        sta $0B0E,b,x
        lda wR0
        sta $0B10,b,x
        rts

        .databank 0

        ; 95/B4E0

      rsUnknown95B4E0 ; 95/B4E0

        .al
        .xl
        .autsiz
        .databank ?

        tax
        sep #$20
        lda $0AF6,b,x
        ora #$01
        sta $0AF6,b,x
        lda $7FF5AF
        ora #$01
        sta $7FF5AF
        rep #$20
        phx
        ldx $0AE9,b
        lda $0AF9,b,x
        ldx $0AEB,b
        cmp $0AF9,b,x
        plx
        bcs _B50C
        lda #$0800
        bra _B50F


        _B50C
        lda #$8800

        _B50F
        sta $0B08,b,x
        lda #$0600
        sta $0B0E,b,x
        rts

        .databank 0

        ; 95/B519

      rsUnknown95B519 ; 95/B519

        .al
        .xl
        .autsiz
        .databank ?

        tax
        sep #$20
        lda $0AF6,b,x
        ora #$01
        sta $0AF6,b,x
        rep #$20
        stz $0B08,b,x
        lda #$0600
        sta $0B08,b,x
        rts

        .databank 0

        ; 95/B530

    .endsection BattleAnimationMoves95B48DSection


    .section BattleAnimationMoves95CF2ESection

      .al
      .xl

      rsUnknown95CF2E ; 95/CF2E

        .al
        .xl
        .autsiz
        .databank ?

        phx
        php
        jsl rlUnknown95D1C5
        lda wR0
        cmp wR1
        bcc _CF42
        sec
        sbc wR8
        sec
        sbc wR7
        bra _CF48


        _CF42
        clc
        adc wR8
        clc
        adc wR7

        _CF48
        sta wR0
        lda wR1
        sec
        sbc wR0
        bpl _CF5D
        eor #$FFFF
        inc a
        lsr a
        sta wR2
        lda #$8000
        bra _CF63


        _CF5D
        lsr a
        sta wR2
        lda #$0000

        _CF63
        sta wR3
        lda wR2
        sta wR4
        plp
        jsl rlUnknown95B530
        lsr a
        sta wR0
        lda wR2
        jsl rlUnknown95CE5E
        ora wR3
        sta $0B08,b,x
        sta $0B0C,b,x
        lda wR3
        bmi _CF8B
        lda $0AF9,b,x
        clc
        adc wR2
        bra _CF91


        _CF8B
        lda $0AF9,b,x
        sec
        sbc wR2

        _CF91
        pha
        lda $0AF8,b,x
        sta $0AFF,b,x
        pla
        sta $0B00,b,x
        lda wR4
        plx
        rts

        .databank 0

        ; 95/CFA0

    .endsection BattleAnimationMoves95CF2ESection


    .section BattleAnimationMoves95D007Section

      .al
      .xl

      rsUnknown95D007 ; 95/D007

        .al
        .xl
        .autsiz
        .databank ?

        phx
        pha
        lda $0AF9,b,x
        sta wR0
        cpx #$0000
        beq _D018
        lda $0AF9,b
        bra _D01B


        _D018
        lda $0B3C,b

        _D01B
        sta wR1
        lda wR0
        cmp wR1
        bcc _D028
        clc
        adc wR8
        bra _D02B


        _D028
        sec
        sbc wR8

        _D02B
        sta wR1
        lda wR1
        sec
        sbc wR0
        bpl _D03F
        eor #$FFFF
        inc a
        sta wR2
        lda #$8000
        bra _D044


        _D03F
        sta wR2
        lda #$0000

        _D044
        sta wR3
        pla
        sta wR0
        lda wR2
        jsl rlUnknown95CE5E
        ora wR3
        sta $0B08,b,x
        sta $0B0C,b,x
        lda wR3
        bmi _D063
        lda $0AF9,b,x
        clc
        adc wR2
        bra _D069


        _D063
        lda $0AF9,b,x
        sec
        sbc wR2

        _D069
        pha
        lda $0AF8,b,x
        sta $0AFF,b,x
        pla
        sta $0B00,b,x
        lda wR4
        plx
        rts

        .databank 0

        ; 95/D078

    .endsection BattleAnimationMoves95D007Section


    .section BattleAnimationMoves95D0E7Section

      .al
      .xl

      rlUnknown95D0E7 ; 95/D0E7

        .al
        .xl
        .autsiz
        .databank ?

        phx
        pha
        jsl rlUnknown95D1C5
        lda wR1
        cmp wR0
        bcs _D0FB
        sec
        sbc wR8
        sec
        sbc wR7
        bra _D101


        _D0FB
        clc
        adc wR8
        clc
        adc wR7

        _D101
        sta wR1
        lda wR1
        sec
        sbc wR0
        bpl _D115
        eor #$FFFF
        inc a
        sta wR2
        lda #$8000
        bra _D11A


        _D115
        sta wR2
        lda #$0000

        _D11A
        sta wR3
        pla
        sta wR0
        lda wR2
        jsl rlUnknown95CE5E
        ora wR3
        sta $0B08,b,x
        sta $0B0C,b,x
        lda wR3
        bmi _D139
        lda $0AF9,b,x
        clc
        adc wR2
        bra _D13F


        _D139
        lda $0AF9,b,x
        sec
        sbc wR2

        _D13F
        pha
        lda $0AF8,b,x
        sta $0AFF,b,x
        pla
        sta $0B00,b,x
        lda wR4
        plx
        rtl

        .databank 0

        ; 95/D14E
      rsUnknown95D14E ; 95/D14E

        .al
        .xl
        .autsiz
        .databank ?

        phx
        php
        jsl rlUnknown95D1C5
        lda wR0
        cmp wR1
        bcc _D162
        sec
        sbc wR8
        sec
        sbc wR7
        bra _D168


        _D162
        clc
        adc wR8
        clc
        adc wR7

        _D168
        sta wR0
        lda wR1
        sec
        sbc wR0
        bpl _D17C
        eor #$FFFF
        inc a
        sta wR2
        lda #$8000
        bra _D181


        _D17C
        sta wR2
        lda #$0000

        _D181
        sta wR3
        lda wR2
        sta wR4
        plp
        jsl rlUnknown95B530
        cmp #$0008
        bcs _D194
        lda #$0008

        _D194
        sta wR0
        lda wR2
        jsl rlUnknown95CE5E
        ora wR3
        sta $0B08,b,x
        sta $0B0C,b,x
        lda wR3
        bmi _D1B0
        lda $0AF9,b,x
        clc
        adc wR2
        bra _D1B6


        _D1B0
        lda $0AF9,b,x
        sec
        sbc wR2

        _D1B6
        pha
        lda $0AF8,b,x
        sta $0AFF,b,x
        pla
        sta $0B00,b,x
        lda wR4
        plx
        rts

        .databank 0

        ; 95/D1C5

    .endsection BattleAnimationMoves95D0E7Section


    .section BattleAnimationMoves95D23CSection

      .al
      .xl

      rsUnknown95D23C ; 95/D23C

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown95B530
        cmp #$0008
        bcs _D248
        lda #$0008

        _D248
        pha
        phx
        ldx $0AEB,b
        lda $0AFE,b,x
        and #$00FF
        sta wR1
        ldx $0AE9,b
        lda $0AFE,b,x
        and #$00FF
        sta wR0
        plx
        lda wR1
        sec
        sbc wR0
        bpl _D26C
        eor #$FFFF
        inc a

        _D26C
        sta wR2
        pla
        sta wR0
        lda wR2
        jsl rlUnknown95CE5E
        sta $0B13,b,x
        lda wR1
        sta $0B04,b,x
        rts

        .databank 0

        ; 95/D280

    .endsection BattleAnimationMoves95D23CSection
