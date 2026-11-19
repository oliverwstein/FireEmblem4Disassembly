; Portraits shown on the world map.

    .section WorldMapPortraitSection

      .al
      .xl

      rlLoadWorldMapPortraitIntoSlot ; 8B/8345

        .al
        .autsiz
        .databank ?

        ldy $0302,b
        cpy #0
        bne +

          jml $88E33D

        +
        phx
        txy
        jsl $8AB49A
        plx

        phx
        lda aPortraitSlotPaletteOffsets,x
        sec
        sbc #2
        tax

        ldy #size(Palette) - size(word)

          -
          lda [lR19],y
          sta aPortraitSlotsPaletteBuffer + size(Palette),x
          dec x
          dec x
          dec y
          dec y
          bpl -

        lda #$35AD
        sta aPortraitSlotsPaletteBuffer + size(Palette) +$1E,x
        plx

        ; Portrait size
        lda #$0800
        sta wR0

        lda #$6000
        clc
        adc aPortraitSlotVRAMOffsets,x
        sta wR1
        phx
        jsl rlDMAByPointer
        plx
        rtl

        .databank 0

      aPortraitSlotPaletteOffsets ; 8B/838F

        .word size(Palette) * 2
        .word size(Palette) * 3
        .word size(Palette) * 4
        .word size(Palette) * 5
        .word size(Palette) * 6
        .word size(Palette) * 7

      aPortraitSlotVRAMOffsets ; 8B/839B

        .word $0800
        .word $0C00
        .word $1000
        .word $1400
        .word $1800
        .word $1C00

        ; 8B/83A7

    .endsection WorldMapPortraitSection
