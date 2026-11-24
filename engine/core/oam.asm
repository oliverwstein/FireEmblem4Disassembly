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


    .section Unreferenced808372Section

      .al
      .xl

      rlInlineDMATransferUnused ; 80/8372

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ; Unreferenced: reads inline channel mask + 7-byte DMA descriptors from stack and triggers $420B

        php
        phb
        sep #$20
        lda #5,s
        pha
        plb
        .databank ?
        rep #$30
        lda #3,s
        tax
        lda $0001,b,x
        and #$00FF
        sta wR34
        sta wR35
        inc x
        ldy #$0000

        _838D
        lsr wR34
        bcc _83AF
        lda $0001,b,x
        sta $4300,b,y
        lda $0003,b,x
        sta $4302,b,y
        lda $0005,b,x
        sta $4304,b,y
        lda $0006,b,x
        sta $4305,b,y
        txa
        clc
        adc #$0007
        tax

        _83AF
        tya
        clc
        adc #$0010
        tay
        cpy #$0080
        bne _838D
        txa
        sta #3,s
        sep #$20
        lda wR35
        sta $420B,b
        plb
        .databank ?
        plp
        rtl

        .databank 0

        ; 80/83C7

    .endsection Unreferenced808372Section
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


    .section Unsorted808875Section

      .al
      .xl

      rlEnableOAMScanlineFlicker ; 80/8875

        .al
        .xl
        .autsiz
        .databank ?

        ; Enables OAM per-band overflow eviction ($0E77=1, $0E75=$30) during scripted map battles

        lda #$0001
        sta wOAMStripOverflowMode,b
        lda #$0030
        sta wOAMStripCooldownReload,b
        rtl

        .databank 0

        ; 80/8882

      rlDisableOAMScanlineFlicker ; 80/8882

        .al
        .xl
        .autsiz
        .databank ?

        ; Resets OAM scanline flicker cooldowns ($0E77=0, $0E75=1, $0E53..$0E72=1)

        lda #$0000
        sta wOAMStripOverflowMode,b
        lda #$0001
        sta wOAMStripCooldownReload,b
        ldx #$0000

        _8891
        sta @l $000E53,x
        inc x
        inc x
        cpx #$0020
        bne _8891
        rtl

        .databank 0

        ; 80/889D

    .endsection Unsorted808875Section


    .section Unsorted80889DSection

      .as
      .xl

      rlPushToOAMBufferWithScanlineCulling ; 80/889D

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Pushes a 16x16 OAM sprite using per-16px-scanline-band overflow culling/flicker (has entry ._88D8)

        lda wR1
        lsr a
        lsr a
        lsr a
        and #$001E
        sta wR5
        tax
        lda aOAMStripTailOffsets,b,x
        cmp aOAMStripActiveCapacities,b,x
        beq _88D7
        adc #$0020
        sta aOAMStripTailOffsets,b,x
        sta aOAMStripOverflowOffsets,b,x
        adc wR5
        tax
        lda wNextFreeSpriteOffset,b
        ora #$8000
        sta $7FEC68,x
        lda wOAMStripOverflowMode,b
        beq _88D3
        lda #$0000
        ldx wR5
        sta aOAMStripOverflowOffsets,b,x

        _88D3
        jml _897F


        _88D7
        rtl

        _88D8
        lda wR1
        lsr a
        lsr a
        lsr a
        and #$001E
        sta wR5
        tax
        lda wR0
        cmp #$0010
        bcc _8909
        cmp #$00F0
        bcs _8909
        lda aOAMStripTailOffsets,b,x
        cmp aOAMStripActiveCapacities,b,x
        beq _8944
        adc #$0020
        sta aOAMStripTailOffsets,b,x
        adc wR5
        tax
        lda wNextFreeSpriteOffset,b
        sta $7FEC68,x
        bra _897F


        _8909
        lda aOAMStripTailOffsets,b,x
        cmp aOAMStripActiveCapacities,b,x
        beq _8967
        adc #$0020
        sta aOAMStripTailOffsets,b,x
        adc wR5
        sta wR3
        lda aOAMStripOverflowOffsets,b,x
        cmp aOAMStripActiveCapacities,b,x
        beq _8967
        adc #$0020
        sta aOAMStripOverflowOffsets,b,x
        adc wR5
        tax
        phx
        lda $7FEC68,x
        ldx wR3
        sta $7FEC68,x
        plx
        lda wNextFreeSpriteOffset,b
        ora #$8000
        sta $7FEC68,x
        bra _897F


        _8944
        lda aOAMStripReadOffsets,b,x
        cmp aOAMStripActiveCapacities,b,x
        bne _894F
        lda #$0000

        _894F
        clc
        adc #$0020
        sta aOAMStripReadOffsets,b,x
        adc wR5
        tax
        lda $7FEC68,x
        bmi _896A
        sta wR5
        lda wOAMStripFrameCounter,b
        lsr a
        bcs _8968

        _8967
        rtl


        _8968
        lda wR5

        _896A
        and #$01FF
        pha
        lda wNextFreeSpriteOffset,b
        sta $7FEC68,x
        pla
        tax
        lda #$00F0
        sta $1C01,b,x
        bra _897F


        _897F
        ldx wNextFreeSpriteOffset,b
        lda wR0
        sta aSpriteBuffer,b,x
        bit #$0100
        beq _899A
        lda aOAMSizeBitTable,x
        sta wR3
        lda (wR3)
        ora aOAMSizeBitTable+2,x
        sta (wR3)

        _899A
        lda wR1
        sta $1C01,b,x
        lda wR4
        sta $1C02,b,x
        txa
        clc
        adc #$0004
        sta wNextFreeSpriteOffset,b
        rtl

        .databank 0

        ; 80/89AD

      rlBeginOAMScanlineFrame ; 80/89AD

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Tallies active scanline OAM load, computes band limits, toggles flicker parity, and sets trailing ext bits

        jsr rsCountSpritesPerScanline
        jsr rsUpdateOAMBandSpriteLimits
        inc wOAMStripFrameCounter,b
        ldx #$0000
        txa

        _89BA
        sta @l $000DB3,x
        sta @l $000DD3,x
        sta @l $000E13,x
        inc x
        inc x
        cpx #$0020
        bne _89BA
        lda wNextFreeSpriteOffset,b
        lsr a
        sta wR0
        and #$000E
        tax
        lda wR0
        lsr a
        lsr a
        lsr a
        and #$001E
        tay
        lda aOAMScanlineTrailExtMaskTable,x
        ora aSpriteExtBuffer,b,y
        sta aSpriteExtBuffer,b,y
        ldx #$AAAA
        jsr rsFillTrailingSpriteExtBuffer
        rtl

        .databank 0

        ; 80/89F1

    .endsection Unsorted80889DSection


    .section Table8089F1Section

      .al
      .xl

      aOAMScanlineTrailExtMaskTable ; 80/89F1

        ; Read by rlBeginOAMScanlineFrame.

        .word $AAAA, $AAA8, $AAA0, $AA80, $AA00, $A800, $A000, $8000

        ; 80/8A01

    .endsection Table8089F1Section


    .section Unsorted808A01Section

      .al
      .xl

      rlFinishOAMScanlineFrame ; 80/8A01

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Masks partial OAM ext word via aOAMUnusedExtMaskTable and clears remaining slots

        lda wNextFreeSpriteOffset,b
        lsr a
        sta wR0
        and #$000E
        tax
        lda wR0
        lsr a
        lsr a
        lsr a
        and #$001E
        tay
        lda aOAMUnusedExtMaskTable,x
        and aSpriteExtBuffer,b,y
        sta aSpriteExtBuffer,b,y
        ldx #$0000
        jsr rsFillTrailingSpriteExtBuffer
        rtl

        .databank 0

        ; 80/8A25

    .endsection Unsorted808A01Section


    .section Table808A25Section

      .al
      .xl

      aOAMUnusedExtMaskTable ; 80/8A25

        ; Read by rlFinishOAMScanlineFrame.

        .word $0000, $0003, $000F, $003F, $00FF, $03FF, $0FFF, $3FFF

        ; 80/8A35

    .endsection Table808A25Section


    .section Unsorted808A35Section

      .as
      .xl

      rsFillTrailingSpriteExtBuffer ; 80/8A35

        .al
        .xl
        .autsiz
        .databank ?

        ; Fills trailing words of aSpriteExtBuffer ($1E00..$1E1E) with X via unrolled stx jump

        phd
        inc y
        inc y
        tya
        cmp #$0020
        bcs _8A6A
        adc #<>_8A4A
        sta wR0
        lda #$1E00
        tcd
        jmp (wR0)

        ; Stores X in the wR variables from the one Y selects up to wR15: the jump
        ; enters this run of stores partway.

        _8A4A
        stx wR0
        stx wR1
        stx wR2
        stx wR3
        stx wR4
        stx wR5
        stx wR6
        stx wR7
        stx wR8
        stx wR9
        stx wR10
        stx wR11
        stx wR12
        stx wR13
        stx wR14
        stx wR15

        _8A6A
        pld
        rts

        .databank 0

        ; 80/8A6C

    .endsection Unsorted808A35Section


    .section Unsorted808A6CSection

      .al
      .xl

      rsCountSpritesPerScanline ; 80/8A6C

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Counts sprites overlapping each scanline into $7FEC88..$7FED87 for already-pushed OAM entries

        lda wNextFreeSpriteOffset,b
        bne _8A72
        rts


        _8A72
        phb
        pea #$7F00
        plb
        .databank ?
        plb
        .databank ?
        lda #$0000
        ldx #$001E

        _8A7E
        sta $EC88,b,x
        sta $ECA8,b,x
        sta $ECC8,b,x
        sta $ECE8,b,x
        sta $ED08,b,x
        sta $ED28,b,x
        sta $ED48,b,x
        sta $ED68,b,x
        dec x
        dec x
        bpl _8A7E
        ldx #$0000

        _8A9D
        txa
        and #$001F
        bne _8AB1
        txa
        lsr a
        lsr a
        lsr a
        lsr a
        phx
        tax
        lda @l aSpriteExtBuffer,x
        sta wR0
        plx

        _8AB1
        lda @l $001C01,x
        and #$00FF
        cmp #$00E0
        bcs _8B0F
        lsr wR0
        lsr wR0
        bcc _8B1C
        phx
        tax
        clc
        lda $EC88,b,x
        adc #$0202
        sta $EC88,b,x
        lda $EC8A,b,x
        adc #$0202
        sta $EC8A,b,x
        lda $EC8C,b,x
        adc #$0202
        sta $EC8C,b,x
        lda $EC8E,b,x
        adc #$0202
        sta $EC8E,b,x
        lda $EC90,b,x
        adc #$0202
        sta $EC90,b,x
        lda $EC92,b,x
        adc #$0202
        sta $EC92,b,x
        lda $EC94,b,x
        adc #$0202
        sta $EC94,b,x
        lda $EC96,b,x
        adc #$0202
        sta $EC96,b,x
        plx

        _8B0F
        inc x
        inc x
        inc x
        inc x
        txa
        cmp @l wNextFreeSpriteOffset
        beq _8B46
        bra _8A9D


        _8B1C
        phx
        tax
        clc
        lda $EC88,b,x
        adc #$0101
        sta $EC88,b,x
        lda $EC8A,b,x
        adc #$0101
        sta $EC8A,b,x
        lda $EC8C,b,x
        adc #$0101
        sta $EC8C,b,x
        lda $EC8E,b,x
        adc #$0101
        sta $EC8E,b,x
        plx
        bra _8B0F


        _8B46
        plb
        .databank ?
        rts

        .databank 0

        ; 80/8B48

    .endsection Unsorted808A6CSection


    .section Unsorted808B48Section

      .al
      .xl

      rsUpdateOAMBandSpriteLimits ; 80/8B48

        .al
        .xl
        .autsiz
        .databank ?

        ; Computes peak sprite density per 16-scanline band and sets $0DF3 limits with $0E53 hysteresis

        phb
        pea #$7F00
        plb
        .databank ?
        plb
        .databank ?
        ldx #$0000
        ldy #$0000

        _8B54
        lda @l wNextFreeSpriteOffset
        bne _8B5E
        jml _8BF7


        _8B5E
        sep #$20
        lda $EC88,b,y
        cmp $EC89,b,y
        bcs _8B6B
        lda $EC89,b,y

        _8B6B
        cmp $EC8A,b,y
        bcs _8B73
        lda $EC8A,b,y

        _8B73
        cmp $EC8B,b,y
        bcs _8B7B
        lda $EC8B,b,y

        _8B7B
        cmp $EC8C,b,y
        bcs _8B83
        lda $EC8C,b,y

        _8B83
        cmp $EC8D,b,y
        bcs _8B8B
        lda $EC8D,b,y

        _8B8B
        cmp $EC8E,b,y
        bcs _8B93
        lda $EC8E,b,y

        _8B93
        cmp $EC8F,b,y
        bcs _8B9B
        lda $EC8F,b,y

        _8B9B
        cmp $EC90,b,y
        bcs _8BA3
        lda $EC90,b,y

        _8BA3
        cmp $EC91,b,y
        bcs _8BAB
        lda $EC91,b,y

        _8BAB
        cmp $EC92,b,y
        bcs _8BB3
        lda $EC92,b,y

        _8BB3
        cmp $EC93,b,y
        bcs _8BBB
        lda $EC93,b,y

        _8BBB
        cmp $EC94,b,y
        bcs _8BC3
        lda $EC94,b,y

        _8BC3
        cmp $EC95,b,y
        bcs _8BCB
        lda $EC95,b,y

        _8BCB
        cmp $EC96,b,y
        bcs _8BD3
        lda $EC96,b,y

        _8BD3
        cmp $EC97,b,y
        bcs _8BDB
        lda $EC97,b,y

        _8BDB
        rep #$20
        and #$00FF
        inc a
        lsr a
        beq _8BF7
        sta wR0
        lda #$0011
        sec
        sbc wR0
        bcs _8BF1
        lda #$0000

        _8BF1
        xba
        lsr a
        lsr a
        lsr a
        bra _8BFA


        _8BF7
        lda #$0220

        _8BFA
        sta @l $000DF3,x
        cmp @l $000E33,x
        beq _8C14
        bcs _8C1E
        sta @l $000E33,x

        _8C0A
        lda @l $000E75
        sta @l $000E53,x
        bra _8C3D


        _8C14
        lda @l $000E53,x
        cmp @l $000E75
        bcs _8C0A

        _8C1E
        lda @l $000E53,x
        beq _8C35
        dec a
        sta @l $000E53,x
        beq _8C35
        lda @l $000E33,x
        sta @l $000DF3,x
        bra _8C3D


        _8C35
        lda @l $000DF3,x
        sta @l $000E33,x

        _8C3D
        tya
        clc
        adc #$0010
        tay
        inc x
        inc x
        cpx #$0020
        beq _8C4E
        jml _8B54


        _8C4E
        plb
        .databank ?
        rts

        .databank 0

        ; 80/8C50

    .endsection Unsorted808B48Section


