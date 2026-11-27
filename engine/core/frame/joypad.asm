; Reading the joypads each frame: held, new and repeated presses.


    .section Unused808000Section

      ; 80/8000: two unreferenced bytes before the first routine.
      aUnused808000 .byte $02, $FE

      .al
      .xl

      rlGetJoypadInput ; 80/8002

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Reads both joypads each frame and works out new and repeated presses. FE5: rlGetJoypadInput.

        php
        sep #$20

        _8005
        lda $4212,b
        and #$01
        bne _8005
        rep #$20
        lda $4218,b
        sta wJoy1Input
        and #$000F
        beq _801C
        lda wJoy1Old
        sta wJoy1Input

        _801C
        lda wJoy1Input
        eor wJoy1Old
        and wJoy1Input
        sta wJoy1New
        sta wJoy1Repeated
        lda wJoy1Input
        beq _803C
        cmp wJoy1Old
        bne _803C
        dec wJoy1RepeatTimer
        bne _8040
        lda wJoy1Input
        sta wJoy1Repeated
        lda wJoyRepeatInterval
        sta wJoy1RepeatTimer
        bra _8040


        _803C
        lda wJoyRepeatDelay
        sta wJoy1RepeatTimer

        _8040
        lda wJoy1Input
        sta wJoy1Old
        lda $421A,b
        sta wJoy2Input
        and #$000F
        beq _8052
        lda wJoy2Old
        sta wJoy2Input

        _8052
        lda wJoy2Input
        eor wJoy2Old
        and wJoy2Input
        sta wJoy2New
        sta wJoy2Repeated
        lda wJoy2Input
        beq _8072
        cmp wJoy2Old
        bne _8072
        dec wJoy2RepeatTimer
        bne _8076
        lda wJoy2Input
        sta wJoy2Repeated
        lda wJoyRepeatInterval
        sta wJoy2RepeatTimer
        bra _8076


        _8072
        lda wJoyRepeatDelay
        sta wJoy2RepeatTimer

        _8076
        lda wJoy2Input
        sta wJoy2Old
        plp
        rtl

        .databank 0

        ; 80/807C

    .endsection Unused808000Section


