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
        ; wR5 = BG1TilemapPosition
        ; wR6 = BG2TilemapPosition
        ; wR7 = BG3TilemapPosition
        ; wR8 = BG4TilemapPosition

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
