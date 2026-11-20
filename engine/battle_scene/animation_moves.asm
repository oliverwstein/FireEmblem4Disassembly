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
        jsl $95D0E7
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
        jsr $95CF2E
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
        jsr $95D14E
        sec
        jsr $95D23C
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
        jsr $95D007
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
        jsr $95D007
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
        jsr $95D007
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
