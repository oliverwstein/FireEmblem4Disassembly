; The castle keepers and portraits: loading a portrait into an OAM palette and
; VRAM, drawing it as sprites with the talking mouth frame (keeper, unit,
; courtyard), and setting up the keeper's dialogue box. Bank $8A.


    .section Unsorted8A946ASection

      .al
      .xl

      rsLoadPortraitToBGPalette2 ; 8A/946A

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlGetDecompressedPortraitDataPointers
        ldx #$001E
        ldy #$001E

        _9474
        lda [lR19],y
        sta aBGPaletteBuffer.aPalette2,b,y
        dec x
        dec x
        dec y
        dec y
        bpl _9474
        lda #$0800
        sta wR0
        lda #$2000
        sta wR1
        phx
        jsl rlDMAByPointer
        plx
        rts

        .databank 0

        ; 8A/9490


      rsLoadPortraitToBGPalette4 ; 8A/9490

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlGetDecompressedPortraitDataPointers
        ldx #$001E
        ldy #$001E

        _949A
        lda [lR19],y
        sta aBGPaletteBuffer.aPalette4,b,y
        dec x
        dec x
        dec y
        dec y
        bpl _949A
        lda #$0800
        sta wR0
        lda #$2000
        sta wR1
        phx
        jsl rlDMAByPointer
        plx
        rts

        .databank 0

        ; 8A/94B6


    .endsection Unsorted8A946ASection


    .section Unsorted8A94B6Section

      .al
      .xl

      rlCastleFillVRAM2000 ; 8A/94B6

        .al
        .xl
        .autsiz
        .databank ?

        ; DMAs $800 bytes from the fixed address $8A/94E1 (this routine's rtl byte, $6B) to VRAM word $2000.

        rep #$30
        lda #$1809
        sta $4300,b
        lda #$8A00
        sta $4303,b
        lda #$94E1
        sta $4302,b
        lda #$0800
        sta $4305,b
        lda #$2000
        sta $2116,b
        sep #$20
        lda #$01
        sta $420B,b
        rep #$20
        rtl

        .databank 0

        ; 8A/94E0

        ; Unused: 2 zero bytes.
        .fill 2, $00

    .endsection Unsorted8A94B6Section


    .section Unsorted8A94E2Section

      .al
      .xl

      rlCastleFillVRAM2400 ; 8A/94E2

        .al
        .xl
        .autsiz
        .databank ?

        ; DMAs $800 bytes from the fixed address $8A/950D (this routine's rtl byte, $6B) to VRAM word $2400.

        rep #$30
        lda #$1809
        sta $4300,b
        lda #$8A00
        sta $4303,b
        lda #$950D
        sta $4302,b
        lda #$0800
        sta $4305,b
        lda #$2400
        sta $2116,b
        sep #$20
        lda #$01
        sta $420B,b
        rep #$20
        rtl

        .databank 0

        ; 8A/950C

        ; Unused: 2 zero bytes.
        .fill 2, $00

    .endsection Unsorted8A94E2Section


    .section Unsorted8A950ESection

      .al
      .xl

      rsPushKeeperPortraitSprites ; 8A/950E

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws the keeper's portrait as sprites (OAM palette 5, mirrored), with the mouth frame of dialogue slot X.

        sep #$20
        lda #$8A
        pha
        plb
        .databank $8A
        rep #$20
        ldy #$964C
        lda #$0000
        sta wR5
        sta wR4
        lda aDialogue.wSlot0MouthFrame,b,x
        beq _9534
        cmp #$0001
        beq _952F
        ldy #$96C8
        bra _9534


        _952F
        ldy #$968A
        bra _9534


        _9534
        jsl rlPushToOAMBuffer
        rts

        .databank 0

        ; 8A/9539

      rsPushUnitPortraitSprites ; 8A/9539

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws the unit's portrait as sprites (OAM palette 4), with the mouth frame of dialogue slot X.

        sep #$20
        lda #$8A
        pha
        plb
        .databank $8A
        rep #$20
        ldy #$9586
        lda #$0000
        sta wR5
        lda #$0040
        sta wR4
        lda wCurrentChapter,b
        cmp #$FFFF
        beq _956A
        lda aDialogue.wSlot0MouthFrame,b,x
        beq _956A
        cmp #$0001
        beq _9565
        ldy #$9602
        bra _956A


        _9565
        ldy #$95C4
        bra _956A


        _956A
        jsl rlPushToOAMBuffer
        rts

        .databank 0

        ; 8A/956F

    .endsection Unsorted8A950ESection


    .section Unsorted8A956FSection

      .al
      .xl

      rsPushCourtyardPortraitSprites ; 8A/956F

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws the courtyard command menu's portrait as sprites (OAM palette 6), one frame.

        sep #$20
        lda #$8A
        pha
        plb
        .databank $8A
        rep #$20
        ldy #$9712
        lda #$0000
        sta wR5
        sta wR4
        jsl rlPushToOAMBuffer
        rts

        .databank 0

        ; 8A/9586


      aUnitPortraitSpritesFrame0 ; 8A/9586

        _Sprites := [[(  32,   48), $21, SpriteLarge, $09A, 2, 4, false, false]]
        _Sprites ..= [[(  16,   48), $21, SpriteLarge, $098, 2, 4, false, false]]
        _Sprites ..= [[(   0,   48), $21, SpriteLarge, $096, 2, 4, false, false]]
        _Sprites ..= [[(  32,   32), $21, SpriteLarge, $07A, 2, 4, false, false]]
        _Sprites ..= [[(  16,   32), $21, SpriteLarge, $078, 2, 4, false, false]]
        _Sprites ..= [[(   0,   32), $21, SpriteLarge, $076, 2, 4, false, false]]
        _Sprites ..= [[(  32,   16), $21, SpriteLarge, $094, 2, 4, false, false]]
        _Sprites ..= [[(  16,   16), $21, SpriteLarge, $092, 2, 4, false, false]]
        _Sprites ..= [[(   0,   16), $21, SpriteLarge, $090, 2, 4, false, false]]
        _Sprites ..= [[(  32,    0), $21, SpriteLarge, $074, 2, 4, false, false]]
        _Sprites ..= [[(  16,    0), $21, SpriteLarge, $072, 2, 4, false, false]]
        _Sprites ..= [[(   0,    0), $21, SpriteLarge, $070, 2, 4, false, false]]

        .structSpriteArray aUnitPortraitSpritesFrame0._Sprites

      aUnitPortraitSpritesFrame1 ; 8A/95C4

        _Sprites := [[(  32,   48), $21, SpriteLarge, $09A, 2, 4, false, false]]
        _Sprites ..= [[(  16,   48), $21, SpriteLarge, $098, 2, 4, false, false]]
        _Sprites ..= [[(   0,   48), $21, SpriteLarge, $096, 2, 4, false, false]]
        _Sprites ..= [[(  32,   32), $21, SpriteLarge, $07A, 2, 4, false, false]]
        _Sprites ..= [[(  16,   32), $21, SpriteLarge, $07E, 2, 4, false, false]]
        _Sprites ..= [[(   0,   32), $21, SpriteLarge, $07C, 2, 4, false, false]]
        _Sprites ..= [[(  32,   16), $21, SpriteLarge, $094, 2, 4, false, false]]
        _Sprites ..= [[(  16,   16), $21, SpriteLarge, $092, 2, 4, false, false]]
        _Sprites ..= [[(   0,   16), $21, SpriteLarge, $090, 2, 4, false, false]]
        _Sprites ..= [[(  32,    0), $21, SpriteLarge, $074, 2, 4, false, false]]
        _Sprites ..= [[(  16,    0), $21, SpriteLarge, $072, 2, 4, false, false]]
        _Sprites ..= [[(   0,    0), $21, SpriteLarge, $070, 2, 4, false, false]]

        .structSpriteArray aUnitPortraitSpritesFrame1._Sprites

      aUnitPortraitSpritesFrame2 ; 8A/9602

        _Sprites := [[(  32,   48), $21, SpriteLarge, $09A, 2, 4, false, false]]
        _Sprites ..= [[(  16,   48), $21, SpriteLarge, $098, 2, 4, false, false]]
        _Sprites ..= [[(   0,   48), $21, SpriteLarge, $096, 2, 4, false, false]]
        _Sprites ..= [[(  32,   32), $21, SpriteLarge, $07A, 2, 4, false, false]]
        _Sprites ..= [[(  16,   32), $21, SpriteLarge, $09E, 2, 4, false, false]]
        _Sprites ..= [[(   0,   32), $21, SpriteLarge, $09C, 2, 4, false, false]]
        _Sprites ..= [[(  32,   16), $21, SpriteLarge, $094, 2, 4, false, false]]
        _Sprites ..= [[(  16,   16), $21, SpriteLarge, $092, 2, 4, false, false]]
        _Sprites ..= [[(   0,   16), $21, SpriteLarge, $090, 2, 4, false, false]]
        _Sprites ..= [[(  32,    0), $21, SpriteLarge, $074, 2, 4, false, false]]
        _Sprites ..= [[(  16,    0), $21, SpriteLarge, $072, 2, 4, false, false]]
        _Sprites ..= [[(   0,    0), $21, SpriteLarge, $070, 2, 4, false, false]]

        .structSpriteArray aUnitPortraitSpritesFrame2._Sprites

      aUnitPortraitBottomSprites ; 8A/9640

        _Sprites := [[(  16,   32), $21, SpriteLarge, $07E, 3, 4, false, false]]
        _Sprites ..= [[(   0,   32), $21, SpriteLarge, $07C, 3, 4, false, false]]

        .structSpriteArray aUnitPortraitBottomSprites._Sprites

      aKeeperPortraitSpritesFrame0 ; 8A/964C

        _Sprites := [[(   0,   48), $21, SpriteLarge, $09A, 2, 5, true, false]]
        _Sprites ..= [[(  16,   48), $21, SpriteLarge, $098, 2, 5, true, false]]
        _Sprites ..= [[(  32,   48), $21, SpriteLarge, $096, 2, 5, true, false]]
        _Sprites ..= [[(   0,   32), $21, SpriteLarge, $07A, 2, 5, true, false]]
        _Sprites ..= [[(  16,   32), $21, SpriteLarge, $078, 2, 5, true, false]]
        _Sprites ..= [[(  32,   32), $21, SpriteLarge, $076, 2, 5, true, false]]
        _Sprites ..= [[(   0,   16), $21, SpriteLarge, $094, 2, 5, true, false]]
        _Sprites ..= [[(  16,   16), $21, SpriteLarge, $092, 2, 5, true, false]]
        _Sprites ..= [[(  32,   16), $21, SpriteLarge, $090, 2, 5, true, false]]
        _Sprites ..= [[(   0,    0), $21, SpriteLarge, $074, 2, 5, true, false]]
        _Sprites ..= [[(  16,    0), $21, SpriteLarge, $072, 2, 5, true, false]]
        _Sprites ..= [[(  32,    0), $21, SpriteLarge, $070, 2, 5, true, false]]

        .structSpriteArray aKeeperPortraitSpritesFrame0._Sprites

      aKeeperPortraitSpritesFrame1 ; 8A/968A

        _Sprites := [[(   0,   48), $21, SpriteLarge, $09A, 2, 5, true, false]]
        _Sprites ..= [[(  16,   48), $21, SpriteLarge, $098, 2, 5, true, false]]
        _Sprites ..= [[(  32,   48), $21, SpriteLarge, $096, 2, 5, true, false]]
        _Sprites ..= [[(   0,   32), $21, SpriteLarge, $07A, 2, 5, true, false]]
        _Sprites ..= [[(  16,   32), $21, SpriteLarge, $07E, 2, 5, true, false]]
        _Sprites ..= [[(  32,   32), $21, SpriteLarge, $07C, 2, 5, true, false]]
        _Sprites ..= [[(   0,   16), $21, SpriteLarge, $094, 2, 5, true, false]]
        _Sprites ..= [[(  16,   16), $21, SpriteLarge, $092, 2, 5, true, false]]
        _Sprites ..= [[(  32,   16), $21, SpriteLarge, $090, 2, 5, true, false]]
        _Sprites ..= [[(   0,    0), $21, SpriteLarge, $074, 2, 5, true, false]]
        _Sprites ..= [[(  16,    0), $21, SpriteLarge, $072, 2, 5, true, false]]
        _Sprites ..= [[(  32,    0), $21, SpriteLarge, $070, 2, 5, true, false]]

        .structSpriteArray aKeeperPortraitSpritesFrame1._Sprites

      aKeeperPortraitSpritesFrame2 ; 8A/96C8

        _Sprites := [[(   0,   48), $21, SpriteLarge, $09A, 2, 5, true, false]]
        _Sprites ..= [[(  16,   48), $21, SpriteLarge, $098, 2, 5, true, false]]
        _Sprites ..= [[(  32,   48), $21, SpriteLarge, $096, 2, 5, true, false]]
        _Sprites ..= [[(   0,   32), $21, SpriteLarge, $07A, 2, 5, true, false]]
        _Sprites ..= [[(  16,   32), $21, SpriteLarge, $09E, 2, 5, true, false]]
        _Sprites ..= [[(  32,   32), $21, SpriteLarge, $09C, 2, 5, true, false]]
        _Sprites ..= [[(   0,   16), $21, SpriteLarge, $094, 2, 5, true, false]]
        _Sprites ..= [[(  16,   16), $21, SpriteLarge, $092, 2, 5, true, false]]
        _Sprites ..= [[(  32,   16), $21, SpriteLarge, $090, 2, 5, true, false]]
        _Sprites ..= [[(   0,    0), $21, SpriteLarge, $074, 2, 5, true, false]]
        _Sprites ..= [[(  16,    0), $21, SpriteLarge, $072, 2, 5, true, false]]
        _Sprites ..= [[(  32,    0), $21, SpriteLarge, $070, 2, 5, true, false]]

        .structSpriteArray aKeeperPortraitSpritesFrame2._Sprites

      aKeeperPortraitBottomSprites ; 8A/9706

        _Sprites := [[(  16,   32), $21, SpriteLarge, $07E, 3, 5, true, false]]
        _Sprites ..= [[(  32,   32), $21, SpriteLarge, $07C, 3, 5, true, false]]

        .structSpriteArray aKeeperPortraitBottomSprites._Sprites

      aCourtyardPortraitSprites ; 8A/9712

        _Sprites := [[(  32,   48), $21, SpriteLarge, $06A, 3, 6, false, false]]
        _Sprites ..= [[(  16,   48), $21, SpriteLarge, $068, 3, 6, false, false]]
        _Sprites ..= [[(   0,   48), $21, SpriteLarge, $066, 3, 6, false, false]]
        _Sprites ..= [[(  32,   32), $21, SpriteLarge, $04A, 3, 6, false, false]]
        _Sprites ..= [[(  16,   32), $21, SpriteLarge, $048, 3, 6, false, false]]
        _Sprites ..= [[(   0,   32), $21, SpriteLarge, $046, 3, 6, false, false]]
        _Sprites ..= [[(  32,   16), $21, SpriteLarge, $064, 3, 6, false, false]]
        _Sprites ..= [[(  16,   16), $21, SpriteLarge, $062, 3, 6, false, false]]
        _Sprites ..= [[(   0,   16), $21, SpriteLarge, $060, 3, 6, false, false]]
        _Sprites ..= [[(  32,    0), $21, SpriteLarge, $044, 3, 6, false, false]]
        _Sprites ..= [[(  16,    0), $21, SpriteLarge, $042, 3, 6, false, false]]
        _Sprites ..= [[(   0,    0), $21, SpriteLarge, $040, 3, 6, false, false]]

        .structSpriteArray aCourtyardPortraitSprites._Sprites

    .endsection Unsorted8A956FSection


    .section Unsorted8A9750Section

      .al
      .xl

      rlLoadKeeperPortrait ; 8A/9750

        .al
        .autsiz
        .databank ?

        ; Loads portrait A to OAM palette 5 and VRAM $CE00.

        ; Input:
        ; A = PortraitID

        jsl rlGetDecompressedPortraitDataPointers

        ldx #size(Palette)-2
        ldy #size(Palette)-2

          -
          lda [lR19],y
          sta aOAMPaletteBuffer.aPalette5,b,y
          dec x
          dec x
          dec y
          dec y
          bpl -

        lda #16 * 4 * size(Tile4bpp)
        sta wR0
        lda #$CE00 >> 1
        sta wR1
        phx
        jsl rlDMAByPointer
        plx
        rtl

        .databank 0

        ; 8A/9776

    .endsection Unsorted8A9750Section


    .section Unsorted8A9776Section

      .al
      .xl

      rlLoadUnitPortrait ; 8A/9776

        .al
        .xl
        .autsiz
        .databank ?

        ; Loads portrait A (through rlDecompressCharacterPortrait) to OAM palette 4 and VRAM $6B00.

        jsl rlDecompressCharacterPortrait
        ldx #$001E
        ldy #$001E

        _9780
        lda [lR19],y
        sta aOAMPaletteBuffer.aPalette4,b,y
        dec x
        dec x
        dec y
        dec y
        bpl _9780
        lda #$0800
        sta wR0
        lda #$6B00
        sta wR1
        phx
        jsl rlDMAByPointer
        plx
        rtl

        .databank 0

        ; 8A/979C

    .endsection Unsorted8A9776Section


    .section Unsorted8A979CSection

      .al
      .xl

      rlLoadCourtyardPortrait ; 8A/979C

        .al
        .xl
        .autsiz
        .databank ?

        ; Loads portrait A to OAM palette 6 and VRAM $6400.

        jsl rlGetDecompressedPortraitDataPointers
        ldx #$001E
        ldy #$001E

        _97A6
        lda [lR19],y
        sta aOAMPaletteBuffer.aPalette6,b,y
        dec x
        dec x
        dec y
        dec y
        bpl _97A6
        lda #$0800
        sta wR0
        lda #$6400
        sta wR1
        phx
        jsl rlDMAByPointer
        plx
        rtl

        .databank 0

        ; 8A/97C2

    .endsection Unsorted8A979CSection


    .section Unsorted8AB3FESection

      .al
      .xl

      rlDecompressCharacterPortrait ; 8A/B3FE

        .al
        .xl
        .autsiz
        .databank ?

        ; Decompresses the portrait of character A (or its class portrait) to aDecompressionBuffer+$800.

        phk
        plb
        .databank $8A
        sta wTempVariable1,b
        jsl rlGetCharacterPortraitDataID
        jsr rlTryGetClassPortraitDataID
        sta wR0
        clc
        adc wR0
        clc
        adc wR0
        tax
        lda @l aPortraitGraphicPointers,x
        sta lR45
        lda @l aPortraitGraphicPointers+1,x
        sta lR45+1
        lda #(`aDecompressionBuffer)<<8
        sta lR47+1
        lda #<>aDecompressionBuffer
        clc
        adc #$0800
        sta lR47
        phx
        jsl rlDecompressSingle
        plx
        lda #(`aDecompressionBuffer)<<8
        sta lR18+1
        lda #<>aDecompressionBuffer
        sta lR18
        lda lR18
        clc
        adc #$0800
        sta lR18
        lda @l aPortraitPalettePointers+1,x
        sta lR19+1
        lda @l aPortraitPalettePointers,x
        sta lR19
        rtl

        .databank 0

        ; 8A/B452

    .endsection Unsorted8AB3FESection


    .section Unsorted8ACE50Section

      .al
      .xl

      rlSetupKeeperDialogueBox ; 8A/CE50

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsSetupKeeperDialogueBox
        rtl

        .databank 0

        ; 8A/CE54

      rsSetupKeeperDialogueBox ; 8A/CE54

        .al
        .xl
        .autsiz
        .databank ?

        ; Sets up the dialogue box for a castle keeper: text speed 2, text sound, buffer and VRAM targets.

        lda #$0003
        sta aDialogue.wMode,b
        lda #$0002
        sta aDialogue.wTextSpeed,b
        lda #$0001
        sta aDialogue.wTextSound,b
        lda #$061E
        sta $18DB,b,x
        lda #$5000
        sta $18D7,b,x
        lda #$7E00
        sta $18D5,b,x
        lda #$8388
        sta $18D4,b,x
        lda #$3200
        sta aDialogue.wBaseTile,b,x
        lda #$0212
        sta wR1
        sep #$20
        lda #$00
        sta wR0+1
        xba
        lda wR1
        sta wR0
        lda wR1+1
        xba
        rep #$20
        lsr a
        lsr a
        clc
        adc wR0
        sta wR0
        ldx aDialogue,b
        lda #$7E00
        sta $18D5,b,x
        lda #$8388
        clc
        adc wR0
        sta $18D4,b,x
        rts

        .databank 0

        ; 8A/CEB3

    .endsection Unsorted8ACE50Section


    .section Unsorted8AFC52Section

      .al
      .xl

      rlLoadKeeperPortraitData ; 8A/FC52

        .al
        .xl
        .autsiz
        .databank ?

        ; Loads portrait data A to OAM palette 5 and VRAM $6700.

        jsl rlGetDecompressedPortraitDataPointers._B45E
        ldx #$001E
        ldy #$001E

        _FC5C
        lda [lR19],y
        sta aOAMPaletteBuffer.aPalette5,b,y
        dec x
        dec x
        dec y
        dec y
        bpl _FC5C
        lda #$0800
        sta wR0
        lda #$6700
        sta wR1
        phx
        jsl rlDMAByPointer
        plx
        rtl

        .databank 0

        ; 8A/FC78

    .endsection Unsorted8AFC52Section
