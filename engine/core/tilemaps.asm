; Filling the BG2 and BG3 tilemap buffers, and setting the layers' positions and sizes.

    .section FillBG2Page0TilemapBufferSection

      .al
      .xl

      rlFillBG2Page0TilemapBuffer ; 80/9ED9

        .al
        .autsiz
        .databank ?

        ; Input
        ; A = Filling tile index

        phb
        php
        phk
        plb
        phx

        ldx #size(aBG2TilemapBuffer.Page0)-2

          -
          sta aBG2TilemapBuffer.Page0,x
          dec x
          dec x
          bpl -

        plx
        plp
        plb
        rtl

        .databank 0

      rlFillBG2Page1TilemapBuffer ; 80/9EED

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx

        ldx #size(aBG2TilemapBuffer.Page1)-2
        
          -
          sta aBG2TilemapBuffer.Page1,x
          dec x
          dec x
          bpl -

        plx
        plp
        plb
        rtl

        .databank 0

      rlFillBG3Page0TilemapBuffer ; 80/9F01

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx

        ldx #size(aBG3TilemapBuffer.Page0)-2

          -
          sta aBG3TilemapBuffer.Page0,x
          dec x
          dec x
          bpl -

        plx
        plp
        plb
        rtl

        .databank 0

      rlSetLayerPositionsAndSizes ; 80/9F15

        .al
        .autsiz
        .databank ?

        ; Input:
        ; wR1 = BG1Base
        ; wR2 = BG2Base
        ; wR3 = BG3Base
        ; wR4 = BG4Base
        ; wR5 = OBJBase
        ; wR6 = BG1TilemapPosition
        ; wR7 = BG2TilemapPosition
        ; wR8 = BG3TilemapPosition
        ; wR9 = BG4TilemapPosition
        ; All are VRAM word addresses.

        phb
        php
        phk
        plb
        sep #$20
        lda bBufferINIDISP
        bmi +

          jml _End

        +
        lda wR1+1
        and #BG12NBA_BG1_Address << 4
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR1+1

        lda wR2+1
        and #BG12NBA_BG2_Address
        ora wR1+1
        sta wR1

        lda wR3+1
        and #BG34NBA_BG3_Address << 4
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR3+1

        lda wR4+1
        and #BG34NBA_BG4_Address
        ora wR3+1
        sta wR3

        lda wR5+1
        and #OBSEL_Base << 5
        lsr a
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR5

        lda wR6+1
        and #BGSC_Address
        sta wR6
        lda wR7+1
        and #BGSC_Address
        sta wR7
        lda wR8+1
        and #BGSC_Address
        sta wR8
        lda wR9+1
        and #BGSC_Address
        sta wR9

        lda bBufferBG1SC
        and #BGSC_Size
        ora wR6
        sta BG1SC,b
        sta bBufferBG1SC

        lda bBufferBG2SC
        and #BGSC_Size
        ora wR7
        sta BG2SC,b
        sta bBufferBG2SC

        lda bBufferBG3SC
        and #BGSC_Size
        ora wR8
        sta BG3SC,b
        sta bBufferBG3SC

        lda bBufferBG4SC
        and #BGSC_Size
        ora wR9
        sta BG4SC,b
        sta bBufferBG4SC

        lda bBufferOBSEL
        and #~OBSEL_Base
        ora wR5
        sta OBSEL,b
        sta bBufferOBSEL

        lda wR1
        sta BG12NBA,b
        sta bBufferBG12NBA

        lda wR3
        sta BG34NBA,b
        sta bBufferBG34NBA
        
        _End
        plp
        plb
        rtl

        .databank 0

        ; 80/9FB2

    .endsection FillBG2Page0TilemapBufferSection


    .section Unreferenced809FB2Section

      .al
      .xl

      rlSignedMultiply32By32Unused ; 80/9FB2

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ; Unreferenced: signed 32x32 multiply using rlUnsignedMultiply32By32

        lda wR11
        eor wR13
        php
        lda wR11
        bpl _9FD0
        clc
        lda wR10
        eor #$FFFF
        adc #$0001
        sta wR10
        lda wR11
        eor #$FFFF
        adc #$0000
        sta wR11

        _9FD0
        lda wR13
        bpl _9FE9
        clc
        lda wR12
        eor #$FFFF
        adc #$0001
        sta wR12
        lda wR13
        eor #$FFFF
        adc #$0000
        sta wR13

        _9FE9
        jsl rlUnsignedMultiply32By32
        plp
        bpl _A019
        clc
        lda wR14
        eor #$FFFF
        adc #$0001
        sta wR14
        lda wR15
        eor #$FFFF
        adc #$0000
        sta wR15
        lda wR16
        eor #$FFFF
        adc #$0000
        sta wR16
        lda wR17
        eor #$FFFF
        adc #$0000
        sta wR17

        _A019
        rtl

        .databank 0

        ; 80/A01A

      rlSignedDivide32By32Unused ; 80/A01A

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ; Unreferenced: signed shifted 32/32 divide using rlUnsignedDivide32By32

        lda wR13
        eor wR15
        php
        lda wR13
        bpl _A038
        clc
        lda wR12
        eor #$FFFF
        adc #$0001
        sta wR12
        lda wR13
        eor #$FFFF
        adc #$0000
        sta wR13

        _A038
        lda wR15
        bpl _A051
        clc
        lda wR14
        eor #$FFFF
        adc #$0001
        sta wR14
        lda wR15
        eor #$FFFF
        adc #$0000
        sta wR15

        _A051
        sep #$20
        lda wR13
        sta wR13+1
        lda wR12+1
        sta wR13
        lda wR12
        sta wR12+1
        lda #$00
        sta wR12
        rep #$20
        jsl rlUnsignedDivide32By32
        sep #$20
        lda wR13
        sta wR13+1
        lda wR12+1
        sta wR13
        lda wR12
        sta wR12+1
        lda #$00
        sta wR12
        rep #$20
        plp
        bpl _A095
        clc
        lda wR12
        eor #$FFFF
        adc #$0001
        sta wR12
        lda wR13
        eor #$FFFF
        adc #$0000
        sta wR13

        _A095
        rtl

        .databank 0

        ; 80/A096

    .endsection Unreferenced809FB2Section
