; Code from bank $97 not yet assigned to a game system.

    .section Unsorted978000Section

      .al
      .xl

      rlUnknown978000 ; 97/8000

        .al
        .xl
        .autsiz
        .databank ?

        lda $0AF9,b,x
        and #$01FF
        sec
        sbc $7FE198
        jsl rlUnknown9EB4BB
        cpx #$0000
        bne _8018
        clc
        adc #$2000

        _8018
        pha
        lda #$0090
        ora #1,s
        jsl rlUnknown80900D
        pla
        rtl

        .databank 0

        ; 97/8024

    .endsection Unsorted978000Section
