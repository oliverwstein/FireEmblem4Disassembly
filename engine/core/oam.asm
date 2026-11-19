; The OAM (sprite) buffer: hiding sprites, clearing the extra-bits buffer, and pushing
; sprites into the buffer.

    .section HideSpritesSection

      .al
      .xs

      rlHideSprites ; 80/826E

        .al
        .autsiz
        .databank ?

        phd
        sep #$30
        lda wNextFreeSpriteOffset+1,b
        and #$03
        asl a
        tax
        jsr (_Table,x)
        rep #$30
        stz wNextFreeSpriteOffset,b
        pld
        rtl

        _Table
          .addr _Under64Sprites
          .addr _Over64Sprites
          .addr _HideNoSprites
          .addr _HideNoSprites

        _Under64Sprites ; 80/8282

        .xs
        rep #$20
        ldx #240
        phd
        lda #<>aSpriteBuffer+(size(structPPUOAMEntry)*64)
        tcd
        jsr _Clearer
        pld
        lda wNextFreeSpriteOffset,b
        lsr a
        clc
        adc #<>_Clearer
        sta wR0
        lda #<>aSpriteBuffer
        tcd
        jmp (wR0)

        _Over64Sprites ; 80/82A8
        .xs

        rep #$20
        ldx #240
        lda wNextFreeSpriteOffset,b
        and #$00FF
        lsr a
        clc
        adc #<>_Clearer
        sta wR0
        lda #<>aSpriteBuffer+(size(structPPUOAMEntry)*64)
        tcd
        jmp (wR0)

        _Clearer ; 80/82C0

        .xs

        .for i in range(0, 64*size(structPPUOAMEntry), size(structPPUOAMEntry))

          stx i+1

        .endfor

        _HideNoSprites ; 80/8340

        .xs

        rts

        .databank 0

      rlClearSpriteExtBuffer ; 80/8341

        .al
        .autsiz
        .databank ?

        .for i in range(0, size(aSpriteExtBuffer), size(word))

          stz aSpriteExtBuffer+i,b

        .endfor

        rtl

        .databank 0

        ; 80/8372

    .endsection HideSpritesSection


    .section OAMUpperXBitTableSection

      .al
      .xs

      aOAMUpperXBitTable ; 80/83C7

        .for i=0, i<16, i+=1

          .for n=0, n<16, n+=1

            .word 1 << n

          .endfor

        .endfor

      aOAMSizeBitTable ; 80/85C7

        .for i=0, i<16, i+=1

          .for n=0, n<16, n+=2

            .word <>aSpriteExtBuffer + (i*2)
            .word 3 << n

          .endfor

        .endfor

      rlPushToOAMBuffer ; 80/87C7

        .al
        .autsiz
        .databank ?

        ; Inputs:
        ; Y: Pointer to sprite array
        ; DB: Bank of sprite array
        ; wR0: X Coordinate base in pixels
        ; wR1: Y Coordinate base in pixels
        ; wR4: Sprite base
        ; wR5: Attribute base

        lda structSpriteArray.SpriteCount,b,y
        bne +

          rtl

        +
        sta wR2
        inc y
        inc y

        _87D1
        ldx wNextFreeSpriteOffset,b
        clc

        _Loop
        lda structSpriteEntry.X,b,y
        bpl _SmallSprite

        ; Large Sprite
        adc wR0
        sta aSpriteBuffer,b,x
        bit #$0100
        bne _LargeSpriteXNegative

        lda aOAMSizeBitTable,x
        sta wR3
        lda (wR3)
        ora aOAMUpperXBitTable+2,x
        bra _8808

        _SmallSprite
        adc wR0
        sta aSpriteBuffer,b,x
        bit #$0100
        beq _SmallSpriteXPositive

        lda aOAMSizeBitTable,x
        sta wR3
        lda (wR3)
        ora aOAMUpperXBitTable,x
        
        _8808
        sta (wR3)

        _SmallSpriteXPositive
        lda structSpriteEntry.Y,b,y
        bit #$0080
        bne +

        and #$007F
        bra ++

        +
        ora #$FF80

        +
        clc
        adc wR1
        sta aSpriteBuffer+1,b,x
        adc #$0010
        cmp #$0100
        bcs _8849

        lda structSpriteEntry.Attr,b,y
        clc
        adc wR4
        ora wR5
        sta aSpriteBuffer+2,b,x

        -
        txa
        clc
        adc #size(structPPUOAMEntry)
        and #$01FF
        tax

        tya
        adc #size(structSpriteEntry)
        tay

        dec wR2
        bne _Loop

        stx wNextFreeSpriteOffset,b
        rtl

        _8849
        lda #240
        sta aSpriteBuffer+1,b,x
        bra -

        _LargeSpriteXNegative
        lda aOAMSizeBitTable,x
        sta wR3
        lda (wR3)
        ora aOAMSizeBitTable+2,x
        bra _8808

        .databank 0

      rlPushToOAMBufferTimed ; 80/885F

        .al
        .autsiz
        .databank ?

        ; Inputs:
        ; Y: Pointer to sprite array
        ; DB: Bank of sprite array
        ; wR0: X Coordinate base in pixels
        ; wR1: Y Coordinate base in pixels
        ; wR2: Timer
        ; wR4: Sprite base
        ; wR5: Attribute base

        ; Only pushes sprite when timer >= sprite count

        lda wR2
        beq _End

          lda $0000,b,y
          bne +

        _End
        rtl

        +
        cmp wR2
        bcs +

          sta wR2

        +
        inc y
        inc y
        jml rlPushToOAMBuffer._87D1

        .databank 0

        ; 80/8875

    .endsection OAMUpperXBitTableSection
