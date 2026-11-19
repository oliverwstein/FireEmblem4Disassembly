; Unsigned multiplication and division helpers.

    .section MathSection

      .as
      .xs

      rlUnsignedMultiply16By16High ; 80/A096

        .al
        .autsiz
        .databank ?

        ; Inputs:
        ; wR34: 16-bit unsigned multiplier
        ; wR35: 16-bit unsigned multiplicand

        ; Outputs:
        ; wR36: 32-bit unsigned result

        phx
        php
        phb
        phk
        plb

        rep #$30
        stz wR36
        stz wR37

        ldx #16

        -
        lsr wR34
        bcc +

          lda wR35
          clc
          adc wR37
          sta wR37

        +
        ror wR37
        ror wR36
        dec x
        bne -

        plb
        plp
        plx
        rtl

        .databank 0

      rlUnsignedMultiply16By16 ; 80/A0BA
      
        .autsiz
        .databank ?
      
        ; Multiplies two 16-bit unsigned numbers
        ; and returns a 32-bit unsigned number
      
        ; Inputs:
        ; wR10: 16-bit unsigned multiplier
        ; wR11: 16-bit unsigned multiplicand
      
        ; Outputs:
        ; wR12: 32-bit unsigned result

        phb
        phk
        plb
        phx
        phy
        pha
        php

        rep #$20
        sep #$10

        ldx wR10
        stx WRMPYA,b
        ldx wR11
        stx WRMPYB,b
        nop
        nop
        nop
        lda RDMPY,b
        sta wR12

        ldx wR10+1
        stx WRMPYA,b
        ldx wR11+1
        stx WRMPYB,b
        nop
        nop
        nop
        ldx RDMPY,b
        stx wR13

        ldy RDMPY+1,b

        ldx wR10+1
        stx WRMPYA,b
        ldx wR11
        stx WRMPYB,b
        nop
        nop
        lda wR12+1
        clc
        adc RDMPY,b
        sta wR12+1
        bcc +

          inc y

        +
        ldx wR10
        stx WRMPYA,b
        ldx wR11+1
        stx WRMPYB,b
        nop
        nop
        lda wR12+1
        clc
        adc RDMPY,b
        sta wR12+1
        bcc +

          inc y

        +
        sty wR13+1

        plp
        pla
        ply
        plx
        plb
        rtl

        .databank 0

      rlUnsignedMultiply32By32 ; 80/A122
      
        .autsiz
        .databank ?
      
        ; Multiply two 32-bit unsigned numbers
        ; and return a 64-bit unsigned number
      
        ; Inputs:
        ; wR11: 32-bit unsigned multiplier
        ; wR12: 32-bit unsigned multiplicand
      
        ; Outputs:
        ; wR14: 64-bit unsigned result

        phx
        php
        phb
        phk
        plb
        rep #$30
        stz wR14
        stz wR15
        stz wR16
        stz wR17

        ldx #32
        
        -
        lsr wR11
        ror wR10
        bcc +

          lda wR12
          clc
          adc wR16
          sta wR16
          lda wR13
          adc wR17
          sta wR17

        +
        ror wR17
        ror wR16
        ror wR15
        ror wR14
        dec x
        bne -

        plb
        plp
        plx
        rtl

        .databank 0

      rlUnsignedDivide16By8 ; 80/A156
      
        .autsiz
        .databank ?
      
        ; Divides a 16-bit number by an 8-bit number
      
        ; Inputs:
        ; wR13: 16-bit unsigned dividend
        ; wR14: 8-bit unsigned divisor
      
        ; Outputs:
        ; wR10: 16-bit unsigned remainder
        ; wR13: 16-bit unsigned result

        phb
        php
        phk
        plb
        rep #$30
        lda wR13
        sta WRDIVA,b
        sep #$20
        lda wR14
        sta WRDIVB,b
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        rep #$20
        lda RDMPY,b
        sta wR10
        lda RDDIV,b
        sta wR13
        plp
        plb
        rtl

        .databank 0

      rlUnsignedDivide16By16 ; 80/A17E

        .al
        .autsiz
        .databank ?

        ; Inputs:
        ; wR36: 16-bit unsigned dividend
        ; wR37: 16-bit unsigned divisor

        ; Outputs:
        ; wR36: 16-bit unsigned result
        ; wR34: 16-bit unsigned remainder

        phx
        php
        phb
        phk
        plb
        rep #$30
        stz wR34

        lda wR37
        bne +

          stz wR36
          bra _End

        +
        ldx #17
        clc

        -
        rol wR36
        dec x
        beq _End

        rol wR34
        lda wR34
        beq -

        sec
        sbc wR37
        bcc -

        sta wR34
        bra -
        
        _End
        plb
        plp
        plx
        rtl

        .databank 0

        ; 80/A1AB

    .endsection MathSection


    .section SplitNumberIntoDigitsSection

      .al
      .xl

      rlSplitNumberIntoDigits ; 89/A107

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phk
        plb
        sta wR0
        stz wR1
        stz wR2
        stz wR3
        stz wR4

        ldx #6

          _Loop
          lda wR0
          sec
          sbc aSplitNumberIntoDigitsTable,x
          bcc _Next

            sta wR0
            inc wR1,x
            bra _Loop

          _Next
          dec x
          dec x
          bpl _Loop

        plp
        plb
        rtl

        .databank 0

      aSplitNumberIntoDigitsTable ; 89/A130

        .word 10
        .word 100
        .word 1000
        .word 10000

    .endsection SplitNumberIntoDigitsSection
