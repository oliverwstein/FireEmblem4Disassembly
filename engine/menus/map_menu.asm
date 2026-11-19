; Map menus: loading their data, building their tilemaps and palettes, and
; their position and size on screen.

    .section MapMenuSaveMapStateSection

      .al
      .xl

      rlMapMenuSaveMapState ; 85/82A2

        .al
        .autsiz
        .databank ?

        ; At least i think $0302 is the map state...

        lda $0302,b
        sta aProcSystem.aBody3,b,x
        stz $0302,b
        rtl

        .databank 0

      rlLoadMapMenuEntryPointerFromProcBody ; 85/82AC

        .al
        .autsiz
        .databank ?

        lda aProcSystem.aBody1,b,x
        xba
        sta lMapMenuRAMEntryPointer+1,b
        lda aProcSystem.aBody0,b,x
        sta lMapMenuRAMEntryPointer,b
        rtl

        .databank 0

      rlUnknown8582BA ; 85/82BA

        .al
        .autsiz
        .databank ?

        jsl rlLoadMapMenuEntryPointerFromProcBody
        jsl $858882
        lda $1037,b,x
        beq +

          sta $0302,b

        +
        rtl

        .databank 0

        ; 85/82CB

    .endsection MapMenuSaveMapStateSection


    .section StallProcUntilMapMenuDataLoadedSection

      .al
      .xl

      rlStallProcUntilMapMenuDataLoaded ; 85/8341

        .al
        .autsiz
        .databank ?

        ; Loads the long and byte after a proc struct that belongs to map menu data,
        ; handles its palette/decomp/dma stuff by changing the proc cycle and writes
        ; the original proc cycle back once this is done.

        jsl rlLoadMapMenuDataFromProc

        lda aProcSystem.aHeaderOnCycle,b,x
        sta aProcSystem.aBody2,b,x

        lda #<>rlProcCycleMapMenuWaitForPaletteGraphicFinish
        sta aProcSystem.aHeaderOnCycle,b,x

        lda $0003 + size(structProcInfo),b,y
        and #$00FF
        beq +

          jsl rlMapMenuSaveMapState
          bra _End

        +
        lda #0
        sta aProcSystem.aBody3,b,x

        _End
        rtl

        .databank 0

    .endsection StallProcUntilMapMenuDataLoadedSection


    .section MapMenuBuildTilemapSection

      .al
      .xl

      rlMapMenuBuildTilemap ; 85/895C

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        lda wR10
        pha
        lda wR11
        pha
        lda wR12
        pha
        lda wR13
        pha

        lda #$0001
        tsb wUnknown000D79,b

        ldy lMapMenuRAMEntryPointer,b
        sep #$20
        lda lMapMenuRAMEntryPointer+2,b
        pha
        rep #$20
        plb

        lda structMapMenu.Position,b,y
        bmi _End

          jsl rlGetMapMenuYPositions

          lda wR10
          cmp wR13
          beq +
          bge _End

          +
          lda wR11
          cmp wR12
          blt _End

            phb
            php
            phk
            plb
            jsl rlGetMapMenuType
            asl a
            tax
            jsr (aMapMenuTypePointers,x)
            plp
            plb

        _End
        pla
        sta wR13
        pla
        sta wR12
        pla
        sta wR11
        pla
        sta wR10
        plx
        plp
        plb
        rtl

        .databank 0

      aMapMenuTypePointers ; 85/89B5

        .word $89F5
        .word $8A6F
        .word $8AD7
        .word $8B51
        .word $8B59
        .word $8C4E
        .word $8C56
        .word <>rsMapMenuTypeDialogue

        ; 85/89C5

    .endsection MapMenuBuildTilemapSection


    .section DialogueBoxMapMenuTilemapDataSection

      .al
      .xl

      aDialogueBoxMapMenuTilemapData ; 85/9BD1

        .structMapMenuTilemapData 8, 10, aBG3TilemapBuffer, 0, None

    .endsection DialogueBoxMapMenuTilemapDataSection


    .section LoadMapMenuDataSection

      .al
      .xl

      rlLoadMapMenuData ; 87/81EA

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        phy
        lda #size(structMapMenu) ; 15
        jsl rlAllocateRAMArea

        lda #size(structMapMenu)
        ldx #lR18
        jsl rlCopyDataToRAMArea

        lda lR25
        sta lMapMenuRAMEntryPointer,b
        lda lR25+1
        sta lMapMenuRAMEntryPointer+1,b

        ldy lMapMenuRAMEntryPointer,b
        sep #$20
        lda lMapMenuRAMEntryPointer+2,b
        pha
        rep #$20
        plb

        lda structMapMenu.TilemapDataPointer,b,y
        sta lR18
        lda structMapMenu.TilemapDataPointer+1,b,y
        sta lR18+1
        jsl rlLoadMapMenuTilemapData

        jsl rlReplaceMapMenuTilemapROMWithRAMPointer
        jsl rlUnknown8780F9
        ply
        plx
        plp
        plb
        rtl

        .databank 0

    .endsection LoadMapMenuDataSection


    .section GetMapMenuYPositionsSection

      .al
      .xl

      rlGetMapMenuYPositions ; 87/8517

        .al
        .autsiz
        .databank ?

        ; Output:
        ; wR10 = Y pos
        ; wR11 = Y pos + height

        jsl rlGetMapMenuTilemapArea
        xba
        and #$00FF
        sta wR11
        jsl rlGetMapMenuPosition
        xba
        and #$00FF
        sta wR10
        clc
        adc wR11
        sta wR11
        rtl

        .databank 0

        ; 87/8531







; 85839A

; 09 ; width?
; 02 ; height?
; 88 83 7E 
; 00 
; 4A CD 7F


; 8583A3

; .long $000000
; .long $000000
; .long $85839A
; .byte $02 ; type
; .byte $04 ; x pos
; .byte $06 ; y pos


; mapunitmenuproc 85E1CC

; 50 57 
; DB E1 
; ED E1 
; AA 84 

; A3 83 85 
; 01






; 85DCE2
; 09 
; 10 
; 88 83 7E 
; 00 
; 4A CD 7F



; 85DCEB

; .long $000000
; .long $000000
; .long $85DCE2
; .byte $02 
; .byte $04 
; .byte $06


; mapmenuproc 85DDDB

; 50 4D 
; F9 DD 
; 13 DE 
; AA 84 
; EB DC 85 
; 01





; 8D9892

; 22 99 
; 2B 99 
; 33 99 
; 3B 99 43 99 4B 99 53 99 5B 99 64 99 6D 99 6D 99 74 99 7B 99 85 99 8D 99 96 99 A0 99 A9 99 B3 99 BD 99 C6 99 D0 99 D9 99 E3 99 EC 99 F3 99 FB 99 02 9A 09 9A 0E 9A 15 9A 1F 9A 29 9A 30 9A 3A 9A 40 9A 49 9A 51 9A 5A 9A 62 9A 6C 9A 76 9A 7D 9A 83 9A 8A 9A 93 9A 9D 9A A3 9A AA 9A B4 9A BA 9A C3 9A CA 9A CF 9A D8 9A E4 9A ED 9A F6 9A FD 9A 02 9B 07 9B 0E 9B 16 9B 1D 9B 22 9B 2C 9B 33 9B 3A 9B 42 9B 4B 9B 53 9B 5C 9B


; 8D9922 dialogueClassCavalier

    .endsection GetMapMenuYPositionsSection


    .section HandleMapMenuPaletteGraphicsDataSection

      .al
      .xl

      rlHandleMapMenuPaletteGraphicsData ; 87/86BA

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phy

        ldy lMapMenuRAMEntryPointer,b
        sep #$20
        lda lMapMenuRAMEntryPointer+2,b
        pha
        rep #$20
        plb

        ; Handles copying palettes
        lda structMapMenu.PaletteDataPointer+1,b,y
        beq +

          sta lR19+1
          lda structMapMenu.PaletteDataPointer,b,y
          sta lR19
          jsl rlApplyMapMenuPaletteData

        ; Handles decompression and dma of graphics
        +
        lda structMapMenu.GraphicsDataPointer+1,b,y
        beq +

          sta lR19+1
          lda structMapMenu.GraphicsDataPointer,b,y
          sta lR19
          jsl rlHandleMapMenuDecompressionDMA
          bcs _SEC

        +
        sep #$20
        lda bUnknown000521
        and #~$20
        sta bUnknown000521
        rep #$20
        ply
        plp
        plb
        clc
        rtl

        _SEC
        lda bUnknown000521
        ora #$0020
        sta bUnknown000521
        ply
        plp
        plb
        sec
        rtl

        .databank 0

      rlGetMapMenuType ; 87/8710

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phy

        ldy lMapMenuRAMEntryPointer,b
        sep #$20
        lda lMapMenuRAMEntryPointer+2,b
        pha
        rep #$20
        plb

        lda structMapMenu.Type,b,y
        and #$00FF
        ply
        plp
        plb
        rtl

        .databank 0

        ; 87/872B

    .endsection HandleMapMenuPaletteGraphicsDataSection


    .section GetMapMenuPositionSection

      .al
      .xl

      rlGetMapMenuPosition ; 87/8749

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phy

        ldy lMapMenuRAMEntryPointer,b
        sep #$20
        lda lMapMenuRAMEntryPointer+2,b
        pha
        rep #$20
        plb

        lda structMapMenu.Position,b,y
        ply
        plp
        plb
        rtl

        .databank 0

      rlSetMapMenuPosition ; 87/8761

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phy
        pha

        ldy lMapMenuRAMEntryPointer,b
        sep #$20
        lda lMapMenuRAMEntryPointer+2,b
        pha
        rep #$20
        plb

        pla
        sta structMapMenu.Position,b,y

        ply
        plp
        plb
        rtl

        .databank 0

      rlGetMapMenuTilemapArea ; 87/877B

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phy
        jsl rlGetMapMenuTilemapRAMEntryPointer

        ldy lMapMenuTilemapRAMEntryPointer,b
        sep #$20
        lda lMapMenuTilemapRAMEntryPointer+2,b
        pha
        rep #$20
        plb

        lda structMapMenuTilemapData.Area,b,y
        ply
        plp
        plb
        rtl

        .databank 0

      rlSetMapMenuTilemapArea ; 87/8797

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phy

        pha
        jsl rlGetMapMenuTilemapRAMEntryPointer

        ldy lMapMenuTilemapRAMEntryPointer,b
        sep #$20
        lda lMapMenuTilemapRAMEntryPointer+2,b
        pha
        rep #$20
        plb

        pla
        sta structMapMenuTilemapData.Area,b,y

        ply
        plp
        plb
        rtl

        .databank 0

    .endsection GetMapMenuPositionSection


    .section GetMapMenuTileIndexSection

      .al
      .xl

      rlGetMapMenuTileIndex ; 87/88B3

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phy
        lda wR0
        pha

        ldy lMapMenuRAMEntryPointer,b
        sep #$20
        lda lMapMenuRAMEntryPointer+2,b
        pha
        rep #$20
        plb

        lda structMapMenu.XPosition,b,y
        and #$00FF
        sta wR0
        lda structMapMenu.YPosition,b,y
        and #$00FF
        asl a
        asl a
        asl a
        asl a
        asl a
        clc
        adc wR0
        asl a
        ply
        sty wR0
        ply
        plp
        plb
        rtl

        .databank 0

      rlUnknown8788E5 ; 87/88E5

        .al
        .autsiz
        .databank ?

        jsl rlGetMapMenuTilemapRAMEntryPointer
        jsl rlUnknown878B98
        rtl

        .databank 0

      rlUnknown8788EE ; 87/88EE

        .al
        .autsiz
        .databank ?

        jsl rlGetMapMenuTilemapRAMEntryPointer
        jsl rlUnknown878C8C
        rtl

        .databank 0

        ; 87/88F7

    .endsection GetMapMenuTileIndexSection


    .section ApplyMapMenuPaletteDataSection

      .al
      .xl

      rlApplyMapMenuPaletteData ; 87/892A

        .al
        .autsiz
        .databank ?

        php
        phb
        phx
        phy

        ldy lR19
        sep #$20
        lda lR19+2
        pha
        rep #$20
        plb

        lda structMapMenuPaletteData.Size,b,y
        sta wR0
        lda structMapMenuPaletteData.Palette,b,y
        and #$00FF
        asl a
        asl a
        asl a
        asl a
        asl a
        sta wR1
        lda structMapMenuPaletteData.Color,b,y
        and #$00FF
        asl a
        clc
        adc wR1
        sta wR1
        tax

        lda structMapMenuPaletteData.Source,b,y
        pha
        sep #$20
        lda structMapMenuPaletteData.Source+2,b,y
        pha
        rep #$20
        plb
        ply

          _Loop
          lda $0000,b,y
          sta aBGPaletteBuffer,x
          inc y
          inc y
          inc x
          inc x
          dec wR0
          bne _Loop

        ply
        plx
        plb
        plp
        rtl

        .databank 0

    .endsection ApplyMapMenuPaletteDataSection


    .section RemoveMapMenuTilemapRAMEntrySection

      .al
      .xl

      rlRemoveMapMenuTilemapRAMEntry ; 87/8B83

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        lda lMapMenuTilemapRAMEntryPointer,b
        sta lR25
        lda lMapMenuTilemapRAMEntryPointer+1,b
        sta lR25+1
        jsl rlRemoveRAMAreaEntry
        plp
        plb
        rtl

        .databank 0

      rlUnknown878B98 ; 87/8B98

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        phy
        lda wUnknown053C,b
        sta wR0

        ldy lMapMenuTilemapRAMEntryPointer,b
        sep #$20
        lda lMapMenuTilemapRAMEntryPointer+2,b
        pha
        rep #$20
        plb

        lda $0006,b,y
        sta lR20
        lda $0007,b,y
        sta lR20+1

        ; Width * Height
        sep #$20
        lda $0000,b,y
        sta WRMPYA
        lda $0001,b,y
        sta WRMPYB
        nop
        nop
        nop
        rep #$20
        lda RDMPY
        dec a
        tax

        asl a
        clc
        adc lR20
        tay

        sep #$20
        lda lR20+2
        pha
        rep #$20
        plb

        lda wR0

          -
          sta $0000,b,y
          dec y
          dec y
          dec x
          bpl -

        ply
        plx
        plp
        plb
        rtl

        .databank 0

        ; 87/8BF0

    .endsection RemoveMapMenuTilemapRAMEntrySection
