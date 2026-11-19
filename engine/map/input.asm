; Handling controller input on the map.

    .section MapInputHandlerSection

      .al
      .xl

      rsMapInputHandler ; 88/AFB6

        .al
        .autsiz
        .databank ?

        lda $04BA,b
        bne _End

        lda wJoy1New
        bit #JOY_A
        bne _APressed

        bit #JOY_B
        bne _BPressed

        bit #JOY_Select
        bne _SelectPressed

        bit #JOY_X
        bne _XPressed

        bit #JOY_Start
        bne _StartPressed

        bit #JOY_R
        bne _RPressed

        bit #JOY_L
        bne _LPressed
        
        _End
        rts
        
        _APressed
        jsr rsUnknown88B028
        rts
        
        _SelectPressed
        lda wUnknown000770,b
        beq +

          rts

        +
        jsr rsUnknown88B10B
        rts
        
        _BPressed
        lda wUnknown000770,b
        beq +

          jsr rsUnknown88B133

        +
        rts
        
        _XPressed
        jsr rsUnknown88B1C2
        rts
        
        _StartPressed
        jsr rsUnknown88B20C
        rts
        
        _RPressed
        lda wUnknown000770,b
        beq +

          rts

        +
        lda wJoy1Input
        cmp #(JOY_L | JOY_R)
        beq +

        lda #5
        jsl rlUnknown808FAD

        lda #0
        sta $0790,b
        jsr rsUnknown88B51A
        rts
        
        _LPressed
        lda wUnknown000770,b
        beq +

          rts

        +
        jsr rsUnknown88C1BF
        rts

        .databank 0

        ; 88/B028

    .endsection MapInputHandlerSection
