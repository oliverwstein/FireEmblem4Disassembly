; Palette fading: moving buffered colors toward black, white or target colors a
; step at a time, and the fixed color (COLDATA) fades.

    .section SavePaletteBufferColorsToRAMSection

      .al
      .xl

      rlSavePaletteBufferColorsToRAM ; 9F/8E6C

        .al
        .autsiz
        .databank ?

        ; Takes 7 bytes of arguments after call.
        ; - a long pointer to a RAM address
        ; - a word color count
        ; - a word palette offset

        phx
        phy
        lda #5,s
        tay
        lda $0001,b,y
        sta lR18
        lda $0002,b,y
        sta lR18+1
        lda $0004,b,y
        sta wR0
        lda $0006,b,y
        tax
        tya
        clc
        adc #7
        sta #5,s

        ldy #0

          -
          lda aBGPaletteBuffer,b,x
          sta [lR18],y
          inc x
          inc x
          inc y
          inc y
          dec wR0
          bne -

        ply
        plx
        rtl

        .databank 0

      rlFadeBGPaletteColorsToDesired ; 9F/8E9E

        .al
        .autsiz
        .databank ?

        ; Fade A colors of aBGPaletteBuffer from X toward wDesiredColor by current step

        ; A = color count

        sta wR2

        -
        lda aPaletteFading.wDesiredColor,b
        cmp aBGPaletteBuffer,b,x
        beq +

          phx
          tay
          lda aBGPaletteBuffer,b,x
          tax
          lda aPaletteFading.wCurrentStep,b
          jsl rlFadeFromToColorByStep
          plx
          sta aBGPaletteBuffer,b,x

        +
        inc x
        inc x
        dec wR2
        bne -

        rtl

        .databank 0

        ; 9F/8EC0

    .endsection SavePaletteBufferColorsToRAMSection

    .section FadePaletteToColorsSection

      .al
      .xl

      rlFadePaletteToColors ; 9F/8EE1

        .al
        .autsiz
        .databank ?

        ; Call followed by:
        ; .addr palette source in bank $7E
        ; .word color count
        ; .word palette destination offset

        lda aPaletteFading.wMaxSteps,b
        bcc +

          lsr a

        +
        inc a
        cmp aPaletteFading.wCurrentStep,b
        bcs +

          lda #1,s
          adc #6
          sta #1,s
          stz aPaletteFading.wCurrentStep,b
          sec
          rtl

        +
        phx
        phy
        lda #5,s
        tay
        lda $0001,b,y
        sta wR3
        lda $0003,b,y
        sta wR5
        lda $0005,b,y
        tax
        tya
        clc
        adc #6
        sta #5,s

        phb
        pea #$7E7E
        plb
        plb

        ldy #0

          -
          stx aPaletteFading.wCurrentPaletteBufferOffset,b
          sty wR4,b
          lda (wR3),y
          cmp aBGPaletteBuffer,b,x
          beq +

            tay
            lda aBGPaletteBuffer,b,x
            tax
            lda aPaletteFading.wCurrentStep,b
            jsl rlFadeFromToColorByStep
            ldy wR4,b
            ldx aPaletteFading.wCurrentPaletteBufferOffset,b
            sta aBGPaletteBuffer,b,x

          +
          inc y
          inc y
          inc x
          inc x
          dec wR5,b
          bne -

        inc aPaletteFading.wCurrentStep,b
        plb
        ply
        plx
        clc
        rtl

        .databank 0

    .endsection FadePaletteToColorsSection

    .section FadePaletteToBlackSection

      .al
      .xl

      rlFadePaletteToBlack ; 9F/8F4F

        .al
        .autsiz
        .databank ?

        ; Call followed by:
        ; .addr fade data

        ; Fade data contains:
        ; .word palette destination offset
        ; .word color count
        ; $FFFF terminator

        lda aPaletteFading.wMaxSteps,b
        bcc +

          lsr a

        +
        inc a
        cmp aPaletteFading.wCurrentStep,b
        bcs +

          lda #1,s
          adc #2
          sta #1,s
          stz aPaletteFading.wCurrentStep,b
          sec
          rtl

        +
        phx
        lda #3,s
        tay
        lda $0001,b,y
        tax
        tya
        clc
        adc #2
        sta #3,s

        txy
        bra +
        
          -
          phy
          tax
          lda $0002,b,y
          jsl rlFadeBGPaletteColorsToDesired
          ply
          inc y
          inc y
          inc y
          inc y

        +
        lda $0000,b,y
        cmp #$FFFF
        bne -

        inc aPaletteFading.wCurrentStep,b
        plx
        clc
        rtl

        .databank 0

      rlFadeBGPaletteColorRanges ; 9F/8F95

        .al
        .xl
        .autsiz
        .databank ?

        ; Fade inline (offset, count, targetColor) list terminated by $FFFF

        lda aPaletteFading.wMaxSteps,b
        bcc _8F9B
        lsr a

        _8F9B
        inc a
        cmp aPaletteFading.wCurrentStep,b
        bcs _8FAD
        lda #1,s
        adc #2
        sta #1,s
        stz aPaletteFading.wCurrentStep,b
        sec
        rtl

        _8FAD
        phx
        lda #3,s
        tay
        lda $0001,b,y
        tax
        tya
        clc
        adc #2
        sta #3,s
        txy
        bra _8FD5

        _8FBF
        phy
        tax
        lda $0002,b,y
        pha
        lda $0004,b,y
        tay
        pla
        jsl rlDarkenBGPaletteRange
        ply
        inc y
        inc y
        inc y
        inc y
        inc y
        inc y

        _8FD5
        lda $0000,b,y
        cmp #$FFFF
        bne _8FBF
        inc aPaletteFading.wCurrentStep,b
        plx
        clc
        rtl

        .databank 0

        ; 9F/8FE3

    .endsection FadePaletteToBlackSection

    .section FadeFromToColorByStepSection

      .al
      .xl

      rlFadeFromToColorByStep ; 9F/8FE3

        .al
        .autsiz
        .databank ?

        ; Adjusts the input colors to the destination color

        ; Input:
        ; A = step index
        ; X = current color word
        ; Y = desired color word

        ; Output:
        ; A = adjusted color

        pha
        pha
        phx
        phy
        lda #1,s
        and #$001F
        tay

        ; Desired red value in Y

        lda #3,s
        and #$001F
        tax

        ; Current red value in X

        lda #5,s
        jsr rsInterpolateColorChannel
        sta #7,s

        lda #1,s
        asl a
        asl a
        asl a
        xba
        and #$001F
        tay

        ; Desired green value in Y

        lda #3,s
        asl a
        asl a
        asl a
        xba
        and #$001F
        tax

        ; Current green value in X

        lda #5,s
        jsr rsInterpolateColorChannel
        asl a
        asl a
        asl a
        asl a
        asl a
        ora #7,s
        sta #7,s

        lda #1,s
        lsr a
        lsr a
        xba
        and #$001F
        tay

        ; Desired blue value in Y

        lda #3,s
        lsr a
        lsr a
        xba
        and #$001F
        tax

        ; Current blue value in X

        lda #5,s
        jsr rsInterpolateColorChannel
        asl a
        asl a
        xba
        ora #7,s
        sta #7,s

        ply
        plx
        pla
        pla
        rtl

        .databank 0

      rsInterpolateColorChannel ; 9F/903F

        .al
        .autsiz
        .databank ?

        ; One 5-bit channel, from the current value X toward the target Y, at step A of
        ; aPaletteFading.wMaxSteps (N). Step 0 returns X and step N + 1 returns Y; step k
        ; in between returns X + (Y - X) / (N - k + 1), in 8.8 fixed point on the hardware
        ; divider and truncated. The callers pass the buffer's current color as X, so each
        ; step covers an equal share of what is left: the fade is linear and step N lands
        ; on Y.

        cmp #0
        bne +

          txa
          rts

        +
        dec a
        cmp aPaletteFading.wMaxSteps,b
        bne +

          tya
          rts

        +
        phx
        inc a
        sta wR1
        tya
        sec
        sbc #1,s
        sta wR0
        bpl +

          eor #$FFFF
          inc a

        +
        xba
        and #$FF00
        sta WRDIVA
        sep #$21
        lda aPaletteFading.wMaxSteps,b
        sbc wR1
        inc a
        sta WRDIVB
        rep #$20
        xba
        xba
        nop
        nop
        lda RDDIV
        bit wR0
        bpl +

          eor #$FFFF
          inc a

        +
        sta wR0
        pla
        xba
        clc
        adc wR0
        xba
        and #$00FF
        rts

        .databank 0

        ; 9F/9090


    .endsection FadeFromToColorByStepSection

    .section Unsorted80A29ASection

      .al
      .xs

      rlFadeOutCOLDATAByTimer ; 80/A29A

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ; Decrements COLDATA brightness $1F->0 by timer in A; returns SEC when complete

        phb
        php
        phk
        plb
        .databank $80
        sep #$20
        sta wScreenFadingTimeIncrement,b
        lda wScreenFadingFlag,b
        bpl _A2B9
        lda wScreenFadingTimeIncrement,b
        sta wScreenFadingTimer,b
        lda #$FF
        sta bBufferCOLDATA_0
        stz bBufferCOLDATA_1
        stz bBufferCOLDATA_2
        stz wScreenFadingFlag,b

        _A2B9
        lda bBufferCOLDATA_0
        and #$1F
        beq _A2D7
        dec wScreenFadingTimer,b
        bne _A2D3
        lda wScreenFadingTimeIncrement,b
        sta wScreenFadingTimer,b
        lda bBufferCOLDATA_0
        and #$1F
        dec a
        ora #$E0
        sta bBufferCOLDATA_0

        _A2D3
        plp
        plb
        .databank $80
        clc
        rtl


        _A2D7
        lda #$FF
        sta wScreenFadingFlag,b
        plp
        plb
        .databank $80
        sec
        rtl

        .databank 0

        ; 80/A2E0

      rlFadeInCOLDATAByTimer ; 80/A2E0

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ; Increments COLDATA brightness 0->$1F by timer in A; returns SEC when complete

        phb
        php
        phk
        plb
        .databank $80
        sep #$20
        sta wScreenFadingTimeIncrement,b
        lda wScreenFadingFlag,b
        bpl _A2FF
        lda wScreenFadingTimeIncrement,b
        sta wScreenFadingTimer,b
        lda #$E0
        sta bBufferCOLDATA_0
        stz bBufferCOLDATA_1
        stz bBufferCOLDATA_2
        stz wScreenFadingFlag,b

        _A2FF
        lda bBufferCOLDATA_0
        and #$1F
        cmp #$1F
        beq _A31F
        dec wScreenFadingTimer,b
        bne _A31B
        lda wScreenFadingTimeIncrement,b
        sta wScreenFadingTimer,b
        lda bBufferCOLDATA_0
        and #$1F
        inc a
        ora #$E0
        sta bBufferCOLDATA_0

        _A31B
        plp
        plb
        .databank $80
        clc
        rtl


        _A31F
        lda #$FF
        sta wScreenFadingFlag,b
        plp
        plb
        .databank $80
        sec
        rtl

        .databank 0

        ; 80/A328

    .endsection Unsorted80A29ASection
