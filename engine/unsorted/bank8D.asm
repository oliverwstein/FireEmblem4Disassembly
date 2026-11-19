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
