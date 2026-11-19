; Code from bank $8D not yet assigned to a game system.

    .section Unsorted8DA06ASection

      .al
      .xl

      rlUnknown8DA06A ; 8D/A06A

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 8D/A06B

      rlUnknown8DA06B ; 8D/A06B

        .al
        .xl
        .autsiz
        .databank ?

        lda #$7F00
        sta lR18+1
        lda #$5709
        sta lR18
        lda #$A8F6
        jsl rlBuildRAMAreaHeaderAndGuidingEntry
        ldx #$1308
        lda #$0000

        _A082
        sta $7F4400,x
        dec x
        bpl _A082
        jsl rlEnableActiveSpriteEngine
        inc wGameStateRoutine1,b
        lda $08DA,b
        cmp #$0001
        beq _A0B6
        cmp #$0000
        beq _A0B6
        cmp #$0002
        beq _A0B6
        lda #$0004
        sta wScreenFadingProcInput,b
        lda #(`procFadeInByScreenFadingTimer)<<8
        sta lR44+1
        lda #<>procFadeInByScreenFadingTimer
        sta lR44
        jsl rlProcEngineCreateProc

        _A0B6
        rtl

        .databank 0

        ; 8D/A0B7

      rlUnknown8DA0B7 ; 8D/A0B7

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $8D
        lda wGameStateStep,b
        asl a
        tax
        jsr ($8DA0C6,x)
        plp
        plb
        .databank $8D
        rtl

        .databank 0

        ; 8D/A0C6

    .endsection Unsorted8DA06ASection


    .section Unsorted8DB4F6Section

      .al
      .xl

      rsUnknown8DB4F6 ; 8D/B4F6

        .al
        .xl
        .autsiz
        .databank ?

        lda wJoy1Input
        bit #$8000
        bne _B503
        bit #$2000
        bne _B52B
        rts


        _B503
        lda #$0000
        sta wCurrentChapter,b
        lda #$0021
        jsl rlUnknown808FAD
        lda #$0002
        sta $0D77,b
        lda #$B122
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        rts


        _B52B
        rts

        .databank 0

        ; 8D/B52C

      rlUnknown8DB52C ; 8D/B52C

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown8DB53A
        jsr rsUnknown8DB4F6
        lda #$000B
        sta wGameStateStep,b
        rtl

        .databank 0

        ; 8D/B539

    .endsection Unsorted8DB4F6Section


    .section Unsorted8DB53ASection

      .al
      .xl

      rsUnknown8DB53A ; 8D/B53A

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0002
        tsb $08AD,b
        lda #$FFFF
        sta $7F7670
        lda #$0004
        trb $08AD,b
        lda #$0008
        trb $08AD,b
        lda #$0001
        trb $08AD,b
        lda $08DC,b
        cmp #$003F
        bcc _B563
        bra _B5A9


        _B563
        inc $08DC,b
        lda $08DC,b
        sta aDialogue.wUnit1,b
        sta $08B4,b
        lda $08DC,b
        sec
        sbc #$0019
        sta wR0
        clc
        adc wR0
        clc
        adc wR0
        tax
        lda $8DB5C9,x
        sta $08B0,b
        lda $8DB5C8,x
        sta $08AF,b
        lda $08DC,b
        and #$0003
        sta $08B6,b
        lda #$0004
        sta $08B8,b
        lda #$0002
        sta $088B,b
        lda #$0002
        sta wScreenFadingProcInput,b
        rts


        _B5A9
        lda #$0001
        sta $08DA,b
        lda #$ECC9
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        jsl rlUnknown88B3AF
        rts

        .databank 0

        ; 8D/B5C8

    .endsection Unsorted8DB53ASection


    .section Unsorted8DD041Section

      .al
      .xl

      rlUnknown8DD041 ; 8D/D041

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 8D/D042

    .endsection Unsorted8DD041Section
