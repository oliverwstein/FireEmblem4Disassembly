; Window graphics: rlLoadWindowGraphics, which the map, the castle, dialogue,
; events and the debug menu call to load the window frames and palette, and
; rlGetDialogueBoxGraphicsAndPalette with its palette. Bank $89.


    .section Unsorted899FDCSection

      .al
      .xl

      rlLoadWindowGraphics ; 89/9FDC

        .al
        .autsiz
        .databank ?

        ; Sends the window frame tiles to VRAM $6000 and the window palette to BG palette 0, by the window style in $0756. All four styles load the same frames and palette.

        ; DMA background and border tiles based on index $0756
        ; Also gets palette
        ; Different backgrounds were probably planned at some point
        ; but regardless of the index, the code is always the same 

        lda $0756,b
        asl a
        tax
        jsr (aLoadWindowGraphicsStyles,x)
        lda #0
        sta aBGPaletteBuffer,b
        rtl

        .databank 0

      aLoadWindowGraphicsStyles ; 89/9FEB

        .word <>rsLoadWindowGraphicsStyle0
        .word <>rsLoadWindowGraphicsStyle1
        .word <>rsLoadWindowGraphicsStyle2
        .word <>rsLoadWindowGraphicsStyle3

      rsLoadWindowGraphicsStyle0 ; 89/9FF3

        .al
        .autsiz
        .databank ?

        jsl rlDMAByStruct

          .structDMAToVRAM g4bppWindowFrames, $0600, $80, $6000

        ldx #size(Palette)-2
        
          _Loop
          lda aWindowPalette,x
          sta aBGPaletteBuffer,b,x
          dec x
          dec x
          bpl _Loop

        rts

        .databank 0

      rsLoadWindowGraphicsStyle1 ; 89/A00F

        .al
        .autsiz
        .databank ?

        jsl rlDMAByStruct

          .structDMAToVRAM g4bppWindowFrames, $0600, $80, $6000

        ldx #size(Palette)-2
        
          _Loop
          lda aWindowPalette,x
          sta aBGPaletteBuffer,b,x
          dec x
          dec x
          bpl _Loop

        rts

        .databank 0

      rsLoadWindowGraphicsStyle2 ; 89/A02B

        .al
        .autsiz
        .databank ?

        jsl rlDMAByStruct

          .structDMAToVRAM g4bppWindowFrames, $0600, $80, $6000

        ldx #size(Palette)-2
        
          _Loop
          lda aWindowPalette,x
          sta aBGPaletteBuffer,b,x
          dec x
          dec x
          bpl _Loop

        rts

        .databank 0

      rsLoadWindowGraphicsStyle3 ; 89/A047

        .al
        .autsiz
        .databank ?

        jsl rlDMAByStruct

          .structDMAToVRAM g4bppWindowFrames, $0600, $80, $6000

        ldx #size(Palette)-2
        
          _Loop
          lda aWindowPalette,x
          sta aBGPaletteBuffer,b,x
          dec x
          dec x
          bpl _Loop

        rts

        .databank 0

      rlGetDialogueBoxGraphicsAndPalette ; 89/A063

        .al
        .autsiz
        .databank ?

        jsl rlDMAByStruct

          .structDMAToVRAM g4bppDialogueBoxFrames, $0800, $80, $6000

        ldx #size(Palette)-2
        
          _Loop
          lda aDialogueBoxPalette,x
          sta aBGPaletteBuffer,b,x
          dec x
          dec x
          bpl _Loop

        lda #0
        sta aBGPaletteBuffer,b
        rtl

        .databank 0

        ; 89/A085

    .endsection Unsorted899FDCSection


    .section DataDE6200Section

      .al
      .xl

      aDialogueBoxPalette ; DE/6200

        ; Read by rlGetDialogueBoxGraphicsAndPalette.

        .word $2253, $2D8C, $7FFF, $0C41, $7FFF, $4651, $7FFF, $2129
        .word $4E69, $28C4, $1042, $10E4, $14E6, $2504, $1CE4, $14C4
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000

        ; DE/6230

    .endsection DataDE6200Section

