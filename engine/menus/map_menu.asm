; Map menus: the windows drawn on BG3 over the map. Loading their data, the list
; of open menus (lMapMenuListHead), drawing, moving, hiding and redrawing them,
; their frames (aMapMenuTypePointers), the option list menu procs, numbers and
; gauges, the window gradient and opening animation, text boxes and the item
; description box. See docs/reference/menus.md.

    .section LoadMapMenuDataFromProcSection

      .al
      .xl

      rlLoadMapMenuDataFromProc ; 85/8280

        .al
        .autsiz
        .databank ?

        jsl rlEnableMapMenuUploads

        lda $0000+size(structProcInfo),b,y
        sta lR18
        lda $0001+size(structProcInfo),b,y
        sta lR18+1
        jsl rlLoadMapMenuData

        lda lMapMenuRAMEntryPointer,b
        sta aProcSystem.aBody0,b,x
        lda lMapMenuRAMEntryPointer+2,b
        and #$00FF
        sta aProcSystem.aBody1,b,x
        rtl

        .databank 0

        ; 85/82A1

    .endsection LoadMapMenuDataFromProcSection


    .section MapMenuSaveMapStateSection

      .al
      .xl

      rlMapMenuSaveMapState ; 85/82A2

        .al
        .autsiz
        .databank ?

        ; At least i think $0302 is the map state...

        lda wGameStateRoutine1,b
        sta aProcSystem.aBody3,b,x
        stz wGameStateRoutine1,b
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

      rlMapMenuCloseAndRestoreMapState ; 85/82BA

        .al
        .autsiz
        .databank ?

        ; X = proc: closes the proc's map menu and puts back the wGameStateRoutine1 that
        ; rlMapMenuSaveMapState kept in its body.

        jsl rlLoadMapMenuEntryPointerFromProcBody
        jsl rlCloseMapMenu
        lda aProcSystem.aBody3,b,x
        beq +

          sta wGameStateRoutine1,b

        +
        rtl

        .databank 0

        ; 85/82CB

      rlBringProcMapMenuToFront ; 85/82CB

        .al
        .xl
        .autsiz
        .databank ?

        ; X = proc: brings its map menu to the front. Nothing in the build reaches this.

        jsl rlLoadMapMenuEntryPointerFromProcBody
        jsl rlBringMapMenuToFront
        rtl

        .databank 0

        ; 85/82D4

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


    .section ProcCycleMapMenuWaitForPaletteGraphicFinishSection

      .al
      .xl

      rlProcCycleMapMenuWaitForPaletteGraphicFinish ; 85/8366

        .al
        .autsiz
        .databank ?

        jsl rlLoadMapMenuEntryPointerFromProcBody
        jsl rlHandleMapMenuPaletteGraphicsData
        bcc +

          rtl

        +
        lda aProcSystem.aBody2,b,x
        sta aProcSystem.aHeaderOnCycle,b,x
        sta wR40
        jmp (wR40)

        .databank 0

        ; 85/837C

      rlProcMapMenuWaitForButtonDraw ; 85/837C

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws the proc's map menu and goes on to rlProcMapMenuWaitForButtonCycle.

        jsl rlLoadMapMenuEntryPointerFromProcBody
        jsl rlDrawMapMenuBG3
        lda #$838B
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 85/838B

      rlProcMapMenuWaitForButtonCycle ; 85/838B

        .al
        .xl
        .autsiz
        .databank ?

        ; Any button closes the menu (and puts back the game state) and frees the proc.

        lda wJoy1New
        beq _8397
        jsl rlMapMenuCloseAndRestoreMapState
        jsl rlProcEngineFreeProc

        _8397
        rtl

        .databank 0

        ; 85/8398

    .endsection ProcCycleMapMenuWaitForPaletteGraphicFinishSection


    .section ProcScript858398Section

      .al
      .xl

      aProcDialogueBoxCode ; 85/8398

        PROC_HALT


        ; 85/839A


      aUnitMenuTilemapData ; 85/839A

        .structMapMenuTilemapData 9, 2, aBG3TilemapBuffer, 0, $7FCD4A

      aUnitMenuData ; 85/83A3

        .long 0, 0, aUnitMenuTilemapData
        .byte 2, 4, 6

      aUnknown8583AF ; 85/83AF

        .word 0, 1

      procUnknown8583B3 ; 85/83B3

        .structProcInfo "PM", rlListMenuProcInit, rlListMenuProcSetUp, aProcListMenuCode
        .long aUnitMenuData
        .byte 1
        .long aUnknown8583AF

    .endsection ProcScript858398Section


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
        tsb wChapterFlags,b

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

        .word <>rsDrawMapMenuFrameType0
        .word <>rsDrawMapMenuFrameType1
        .word <>rsDrawMapMenuFrameType2
        .word <>rsDrawMapMenuFrameType3
        .word <>rsDrawMapMenuFrameType4
        .word <>rsDrawMapMenuFrameType5
        .word <>rsDrawMapMenuFrameType6
        .word <>rsMapMenuTypeDialogue

        ; 85/89C5

    .endsection MapMenuBuildTilemapSection


    .section DialogueBoxMapMenuTilemapDataSection

      .al
      .xl

      aDialogueBoxMapMenuTilemapData ; 85/9BD1

        .structMapMenuTilemapData 8, 10, aBG3TilemapBuffer, 0, None

    .endsection DialogueBoxMapMenuTilemapDataSection


    .section DialogueBoxMapMenuDataSection

      .al
      .xl

      aDialogueBoxMapMenuData ; 85/9BDA

        ; A structMapMenu without its last field (Next): no palette or graphics data,
        ; tilemap aDialogueBoxMapMenuTilemapData, type 7, position (1, 1).
        .long 0, 0, aDialogueBoxMapMenuTilemapData
        .byte 7, 1, 1


; lands at 7ffcf0

; .long 0
; .long 0
; .long $859BD1
; .byte 7 ; index for aUnknown8589B5
; .byte 1
; .byte 1

; size 12

    .endsection DialogueBoxMapMenuDataSection


    .section MapMenu8780F9Section

      .al
      .xl

      rlAppendMapMenuToList ; 87/80F9

        .al
        .autsiz
        .databank ?

        ; Adds the current map menu at the end of the list of open menus (lMapMenuListHead, linked through structMapMenu.Next); the end is drawn last, in front.

        phb
        php
        phk
        plb
        phy
        lda #$0027
        jsl rlFindLastMapMenu
        bcs +

          ldy lR19
          sep #$20
          lda lR19+2
          pha
          rep #$20
          plb

          lda lMapMenuRAMEntryPointer
          sta structMapMenu.Next,b,y
          lda lMapMenuRAMEntryPointer+1
          sta structMapMenu.Next+1,b,y
          bra ++

        +
        lda lMapMenuRAMEntryPointer,b
        sta lMapMenuListHead,b
        lda lMapMenuRAMEntryPointer+1,b
        sta lMapMenuListHead+1,b

        +
        phk
        plb

        ldy lMapMenuRAMEntryPointer,b
        sep #$20
        lda lMapMenuRAMEntryPointer+2,b
        pha
        rep #$20
        plb

        lda #0
        sta structMapMenu.Next,b,y
        sta structMapMenu.Next+1,b,y
        ply
        plp
        plb
        rtl

        .databank 0

        ; 87/8148

    .endsection MapMenu8780F9Section


    .section Unknown87819ASection

      .al
      .xl

      rlFindLastMapMenu ; 87/819A

        .al
        .autsiz
        .databank ?

        ; A = direct page address to receive a long pointer: the last open map menu. Carry set if none is open.

        phb
        php
        phk
        plb
        phx
        phy

        tax
        lda lMapMenuListHead,b
        ora lMapMenuListHead+1,b
        beq _SEC

        lda lMapMenuListHead,b
        sta @l $000000,x
        lda lMapMenuListHead+1,b
        sta @l $000000+1,x
        
          _Loop
          lda @l $000000,x
          tay
          sep #$20
          lda @l $000000+2,x
          pha
          rep #$20
          plb

          lda $000C,b,y
          ora $000C+1,b,y
          beq _CLC

          lda $000C,b,y
          sta @l $000000,x
          lda $000C+1,b,y
          sta @l $000000+1,x
          bra _Loop

        _CLC
        ply
        plx
        plp
        plb
        clc
        rtl
        
        _SEC
        ply
        plx
        plp
        plb
        sec
        rtl

        .databank 0

    .endsection Unknown87819ASection


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
        jsl rlAppendMapMenuToList
        ply
        plx
        plp
        plb
        rtl

        .databank 0

    .endsection LoadMapMenuDataSection


    .section LoadMapMenuTilemapDataSection

      .al
      .xl

      rlLoadMapMenuTilemapData ; 87/8232

        .al
        .autsiz
        .databank ?

        ; Input:
        ; lR18 = map menu tilemap data source

        ; Output:
        ; lR25 = RAM entry pointer

        phb
        php
        phk
        plb
        phx

        lda #size(structMapMenuTilemapData)
        jsl rlAllocateRAMArea

        lda #size(structMapMenuTilemapData)
        ldx #lR18
        jsl rlCopyDataToRAMArea

        lda lR25
        sta lMapMenuTilemapRAMEntryPointer,b
        lda lR25+1
        sta lMapMenuTilemapRAMEntryPointer+1,b
        plx
        plp
        plb
        rtl

        .databank 0

        ; 87/8256

    .endsection LoadMapMenuTilemapDataSection


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
        lda bMapMenuFlags
        and #~$20
        sta bMapMenuFlags
        rep #$20
        ply
        plp
        plb
        clc
        rtl

        _SEC
        lda bMapMenuFlags
        ora #$0020
        sta bMapMenuFlags
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


    .section GetMapMenuTilemapRAMEntryPointerSection

      .al
      .xl

      rlGetMapMenuTilemapRAMEntryPointer ; 87/87B5

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

        lda structMapMenu.TilemapDataPointer,b,y
        sta lMapMenuTilemapRAMEntryPointer
        lda structMapMenu.TilemapDataPointer+1,b,y
        sta lMapMenuTilemapRAMEntryPointer+1

        ply
        plp
        plb
        rtl

        .databank 0

      rlReplaceMapMenuTilemapROMWithRAMPointer ; 87/87D8

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        lda lMapMenuTilemapRAMEntryPointer,b
        pha
        lda lMapMenuTilemapRAMEntryPointer+1,b
        pha
        lda lR18
        pha
        lda lR18+1
        pha
        phy

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

        lda lMapMenuTilemapRAMEntryPointer
        sta structMapMenu.TilemapDataPointer,b,y
        lda lMapMenuTilemapRAMEntryPointer+1
        sta structMapMenu.TilemapDataPointer+1,b,y

        lda lR18
        sta lMapMenuTilemapRAMEntryPointer
        lda lR18+1
        sta lMapMenuTilemapRAMEntryPointer+1
        jsl rlRemoveMapMenuTilemapRAMEntry

        ply
        pla
        sta lR18+1
        pla
        sta lR18
        pla
        sta lMapMenuTilemapRAMEntryPointer+1
        pla
        sta lMapMenuTilemapRAMEntryPointer
        plp
        plb
        rtl

        .databank 0

        ; 87/8833

      rlGetNextMapMenu ; 87/8833

        .al
        .xl
        .autsiz
        .databank ?

        ; lR19 = the open map menu after the current one (structMapMenu.Next).
        ; Nothing in the build reaches this.

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
        lda structMapMenu.Next,b,y
        sta lR19
        lda structMapMenu.Next+1,b,y
        sta lR19+1
        ply
        plp
        plb
        rtl

        .databank 0

        ; 87/8852

    .endsection GetMapMenuTilemapRAMEntryPointerSection


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

      rlClearMapMenuTiles ; 87/88E5

        .al
        .autsiz
        .databank ?

        ; Fills the current map menu's tiles with wMapMenuClearTile.

        jsl rlGetMapMenuTilemapRAMEntryPointer
        jsl rlClearTilemapEntryTiles
        rtl

        .databank 0

      rlDrawMapMenuSimpleFrame ; 87/88EE

        .al
        .autsiz
        .databank ?

        ; lR18 = 8 tiles (corners and edges): draws them round the edge of the current map menu's tiles.

        jsl rlGetMapMenuTilemapRAMEntryPointer
        jsl rlDrawSimpleFrameToTilemapEntry
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


    .section HandleMapMenuDecompressionDMASection

      .al
      .xl

      rlHandleMapMenuDecompressionDMA ; 87/8979

        .al
        .autsiz
        .databank $00

        phb
        php
        phk
        plb
        phx
        phy
        lda bUnknown0536,b
        and #$00FF
        beq _Free

          lda #7,s
          cmp lUnknown0537,b
          bne +

            lda #7+1,s
            cmp lUnknown0537+1
            bne +

              lda bUnknown0536,b
              bit #$0001
              bne _8A17

              bit #$0002
              beq +

                jml _8A98

          +
          ply
          plx
          plp
          plb
          sec
          rtl

        _Free ; 87/89AC
        lda #7,s
        sta lUnknown0537,b
        lda #7+1,s
        sta lUnknown0537+1,b
        lda bUnknown0536,b
        ora #$0080
        sta bUnknown0536,b

        ldy lR19
        sep #$20
        lda lR19+2
        pha
        rep #$20
        plb

        lda $0004,b,y
        and #$00FF
        beq _CheckDMA

          ldx wDecompressionArrayPosition,b
          lda $0005,b,y
          sta aDecompressionArray + structDecompressionEntry.Source,b,x
          lda $0005+1,b,y
          sta aDecompressionArray + structDecompressionEntry.Source+1,b,x
          lda #<>aDecompressionBuffer
          sta aDecompressionArray + structDecompressionEntry.Dest,b,x
          lda #aDecompressionBuffer >> 8
          sta aDecompressionArray + structDecompressionEntry.Dest+1,b,x
          lda #0
          sta aDecompressionArray + size(structDecompressionEntry),b,x
          sta aDecompressionArray + size(structDecompressionEntry)+1,b,x
          txa
          clc
          adc #size(structDecompressionEntry)
          sta wDecompressionArrayPosition,b
          sep #$20
          lda #1
          sta bDecompressionArrayFlag,b

          lda bBufferINIDISP
          bpl +

            jsl rlDecompressByList

          +
          rep #$20
          lda bUnknown0536,b
          ora #$0001
          sta bUnknown0536,b

          _8A17
          lda bDecompressionArrayFlag,b
          and #$00FF
          beq _CheckDMA

            ply
            plx
            plp
            plb
            sec
            rtl

        _CheckDMA ; 87/8A25
        sep #$20
        lda lR19+2
        pha
        rep #$20
        plb
        ldy lR19

        ldx wDMAArrayPosition,b
        sep #$20
        lda #DMAToVRAM
        sta aDMAArray + structDMAToVRAM.TransferType,b,x
        rep #$20

        lda $0004,b,y
        bne +

          lda $0005,b,y
          sta aDMAArray + structDMAToVRAM.Source,b,x
          lda $0005+1,b,y
          sta aDMAArray + structDMAToVRAM.Source+1,b,x
          bra ++

        +
        lda #<>aDecompressionBuffer
        sta aDMAArray + structDMAToVRAM.Source,b,x
        lda #aDecompressionBuffer >> 8
        sta aDMAArray + structDMAToVRAM.Source+1,b,x

        +
        lda $0000,b,y
        sta aDMAArray + structDMAToVRAM.Count,b,x

        sep #$20
        lda #$80
        sta aDMAArray + structDMAToVRAM.Mode,b,x
        rep #$20

        lda $0002,b,y
        sta aDMAArray + structDMAToVRAM.Destination,b,x
        lda #0
        sta aDMAArray + size(structDMAToVRAM),b,x
        txa
        clc
        adc #size(structDMAToVRAM)
        sta wDMAArrayPosition,b
        sep #$20
        lda #1
        sta bDMAArrayFlag,b

        lda bBufferINIDISP
        bpl +

          jsl rlProcessDMAStructArray

        +
        lda bUnknown0536,b
        and #~$01
        ora #$02
        sta bUnknown0536,b
        rep #$20

        _8A98
        lda bDMAArrayFlag,b
        and #$00FF
        beq _CLC

          ply
          plx
          plp
          plb
          sec
          rtl

        _CLC
        lda bUnknown0536,b
        and #$FF00
        sta bUnknown0536,b
        ply
        plx
        plp
        plb
        clc
        rtl

        .databank 0

        ; 87/8AB5

    .endsection HandleMapMenuDecompressionDMASection


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

      rlClearTilemapEntryTiles ; 87/8B98

        .al
        .autsiz
        .databank ?

        ; Fills the tiles of lMapMenuTilemapRAMEntryPointer with wMapMenuClearTile.

        phb
        php
        phk
        plb
        phx
        phy
        lda wMapMenuClearTile,b
        sta wR0

        ldy lMapMenuTilemapRAMEntryPointer,b
        sep #$20
        lda lMapMenuTilemapRAMEntryPointer+2,b
        pha
        rep #$20
        plb

        lda structMapMenuTilemapData.TilesPointer,b,y
        sta lR20
        lda structMapMenuTilemapData.TilesPointer+1,b,y
        sta lR20+1

        ; Width * Height
        sep #$20
        lda structMapMenuTilemapData.Width,b,y
        sta WRMPYA
        lda structMapMenuTilemapData.Height,b,y
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


    .section Unsorted858000Section

      .al
      .xl

      aDialogueBoxTilemap .binary "../../gfx/ui/tilemaps/DialogueBoxTilemap.bin" ; 85/8000

    .endsection Unsorted858000Section


    .section Unsorted858CD3Section

      .al
      .xl

      rsMapMenuTypeDialogue ; 85/8CD3

        .al
        .autsiz
        .databank ?

        phy
        jsl rlBuildMapMenuDialogueBox

        lda aProcSystem.wInput0,b
        bmi _End
        bne _Bottom

          ; Copy the 2x2 dialogue box tail to the correct spot

          ; Top
          jsl rlGetMapMenuTileIndex
          clc
          adc #C2I((10, 8), 32) * size(word)
          tax

          ; Load downwards facing tail
          ldy #TilemapEntry(C2I((10, 2)) + C2I((0, 48)), 0, true, false, false) 
          bra +

          _Bottom
          jsl rlGetMapMenuTileIndex
          clc
          adc #C2I((18, 0), 32) * size(word) ; $0024
          tax

          ; Load upwards facing tail
          ldy #TilemapEntry(C2I((8, 2)) + C2I((0, 48)), 0, true, false, false) 

          +
          tya
          sta aBG2TilemapBuffer.Page1,x
          tya
          inc a
          sta aBG2TilemapBuffer.Page1+2,x
          tya
          clc
          adc #C2I((0, 1))
          sta aBG2TilemapBuffer.Page1+$40,x
          tya
          clc
          adc #C2I((1, 1))
          sta aBG2TilemapBuffer.Page1+$40+2,x
        
        _End
        ply
        rts

        .databank 0

        ; 85/8D18

    .endsection Unsorted858CD3Section


    .section Unsorted85B81DSection

      .al
      .xl

      rlBuildMapMenuDialogueBox ; 85/B81D

        .al
        .autsiz
        .databank ?

        phy
        phx
        jsl rlGetMapMenuTilemapArea
        and #$00FF
        sta wR5
        cmp #32
        beq _FullWidth

        lda aProcSystem.wInput0,b
        bne _Bottom

        ; Top
        lda #32
        sec
        sbc wR5
        pha
        sta wR13
        lda #3
        sta wR14
        jsl rlUnsignedDivide16By8
        pla
        lsr a
        sta wR10

        lda wR13
        sec
        sbc wR10
        bra _B870

        _FullWidth
        lda #0
        bra _B870

        _Bottom
        lda #32
        sec
        sbc wR5
        pha
        sta wR13
        lda #3
        sta wR14
        jsl rlUnsignedDivide16By8
        pla
        lsr a
        sta wR10
        lda wR13
        asl a
        sec
        sbc wR10

        _B870
        ; Get the middle of the box as the destination tile
        asl a
        sta wR3
        jsl rlGetMapMenuTileIndex
        clc
        adc #size(aDialogueBoxTilemap) - 2
        sec
        sbc #32
        clc
        adc wR5
        clc
        adc wR3
        sta wR7

        ; Source offset
        lda #size(aDialogueBoxTilemap) - 2
        sta wR6

          _Loop
          ; Write the right part to the tilemap
          lda wR6
          tay

          lda wR5
          lsr a
          dec a
          sta wR4
          ldx wR7
          jsr rsDialogueBoxWriteToBG2

          ; Write the left part to the tilemap
          lda wR6
          sec
          sbc #32 * size(word)
          clc
          adc wR5
          tay

          lda wR5
          lsr a
          dec a
          sta wR4
          jsr rsDialogueBoxWriteToBG2

          lda wR7
          sec
          sbc #32 * size(word)
          sta wR7
          lda wR6
          sec
          sbc #32 * size(word)
          sta wR6
          bpl _Loop

        plx
        ply
        rtl

        .databank 0

      rsDialogueBoxWriteToBG2 ; 85/B8C2

        .al
        .autsiz
        .databank $85

        ; Y = source offset
        ; X = destination offset
        ; wR4 = count

          _Loop
          lda aDialogueBoxTilemap,y
          clc
          adc #$0300
          sta aBG2TilemapBuffer.Page1,x
          dec x
          dec x
          dec y
          dec y
          dec wR4
          bpl _Loop

        rts

        .databank 0

        ; 85/B8D6

    .endsection Unsorted85B81DSection


    .section Unsorted82F211Section

      .al
      .xl

      rlResetMenuOptionStack ; 82/F211

        .al
        .autsiz
        .databank ?

        ; Empties the menu option stack: zeroes lMenuOptionPointer..lMenuOptionListTop ($0540-$0549).

        phb
        php
        phk
        plb
        sep #$20
        ldx #9
        lda #0
        
          -
          sta lMenuOptionPointer,b,x
          dec x
          bpl -

        rep #$20
        plp
        plb
        rtl

        .databank 0

        ; 82/F227

    .endsection Unsorted82F211Section


    .section Unsorted82F227Section

      .al
      .xl

      rlPushMenuOptionList ; 82/F227

        .al
        .xl
        .autsiz
        .databank ?

        ; Pushes a new menu option list. lMenuOptionPointer points at its template: +0 a word kept in the block,
        ; +2 the capacity, +3 the number of initial options, then 5 bytes per option (X, Y, a long pointer
        ; to its definition). The new block (allocated RAM) holds the word, the previous lMenuOptionListTop
        ; and a RAM struct of 3-byte entries; it becomes lMenuOptionListTop and gets the initial options.

        phb
        php
        phk
        plb
        .databank $82
        lda wR0
        pha
        lda wR1
        pha
        phx
        phy
        ldx lMenuOptionPointer,b
        sep #$20
        lda lMenuOptionPointer+2,b
        pha
        rep #$20
        plb
        .databank ?
        sep #$20
        lda $0002,b,x
        asl a
        clc
        adc $0002,b,x
        rep #$20
        and #$00FF
        clc
        adc #$0009
        jsl rlAllocateRAMArea
        sep #$20
        ldy #$0000
        lda $0000,b,x
        sta [lR25],y
        ldy #$0001
        lda $0001,b,x
        sta [lR25],y
        rep #$20
        ldy #$0002
        lda lMenuOptionListTop,b
        sta [lR25],y
        ldy #$0003
        lda lMenuOptionListTop+1,b
        sta [lR25],y
        lda lR25+1
        sta lR18+1
        lda lR25
        clc
        adc #$0005
        sta lR18
        lda $0002,b,x
        and #$00FF
        sta wR0
        lda #$0003
        sta wR1
        jsl rlBuildRAMStructHeader
        lda lR25
        sta @l lMenuOptionListTop
        lda lR25+1
        sta @l lMenuOptionListTop+1
        lda $0003,b,x
        and #$00FF
        beq _F2D8
        sta wR0

        _F2AD
        lda $0004,b,x
        and #$00FF
        sta wMenuOptionX,b
        lda $0005,b,x
        and #$00FF
        sta wMenuOptionY,b
        lda $0006,b,x
        sta lMenuOptionPointer,b
        lda $0007,b,x
        sta lMenuOptionPointer+1,b
        jsl rlAddMenuOption
        inc x
        inc x
        inc x
        inc x
        inc x
        dec wR0
        bne _F2AD

        _F2D8
        ply
        plx
        pla
        sta wR1
        pla
        sta wR0
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 82/F2E3

    .endsection Unsorted82F227Section


    .section Unsorted82F2E3Section

      .al
      .xl

      rlPopMenuOptionList ; 82/F2E3

        .al
        .xl
        .autsiz
        .databank ?

        ; Pops the top menu option list: frees its options and its block, and makes the block's saved
        ; previous top the current lMenuOptionListTop.

        phb
        php
        phk
        plb
        .databank $82
        lda wR0
        pha
        lda lMenuOptionListTop,b
        ora lMenuOptionListTop+1,b
        beq _F33D
        jsl rlGetCurrentMenuOptionCount
        ora #$0000
        beq _F315
        sta wR0

        _F2FD
        lda wR0
        jsl rlSelectMenuOptionByIndex
        lda lMenuOptionPointer,b
        sta lR25
        lda lMenuOptionPointer+1,b
        sta lR25+1
        jsl rlRemoveRAMAreaEntry
        dec wR0
        bne _F2FD

        _F315
        lda lMenuOptionListTop,b
        sta lR25
        lda lMenuOptionListTop+1,b
        sta lR25+1
        jsl rlRemoveRAMAreaEntry
        ldy lMenuOptionListTop,b
        sep #$20
        lda lMenuOptionListTop+2,b
        pha
        rep #$20
        plb
        .databank ?
        lda $0002,b,y
        sta @l lMenuOptionListTop
        lda $0003,b,y
        sta @l lMenuOptionListTop+1

        _F33D
        pla
        sta wR0
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 82/F343

    .endsection Unsorted82F2E3Section


    .section Unsorted82F343Section

      .al
      .xl

      rlAddMenuOption ; 82/F343

        .al
        .xl
        .autsiz
        .databank ?

        ; Allocate 7-byte menu option (handlerPtr, X, Y, W, H) and append to current list

        phb
        php
        phk
        plb
        .databank $82
        phx
        phy
        lda #$0007
        jsl rlAllocateRAMArea
        ldx lMenuOptionPointer,b
        sep #$20
        lda lMenuOptionPointer+2,b
        pha
        rep #$20
        plb
        .databank ?
        ldy #$0000
        lda lMenuOptionPointer,b
        sta [lR25],y
        ldy #$0001
        lda lMenuOptionPointer+1,b
        sta [lR25],y
        sep #$20
        ldy #$0003
        lda wMenuOptionX,b
        sta [lR25],y
        ldy #$0004
        lda wMenuOptionY,b
        sta [lR25],y
        ldy #$0005
        lda $0003,b,x
        sta [lR25],y
        ldy #$0006
        lda $0004,b,x
        sta [lR25],y
        rep #$20
        jsl rlLoadCurrentMenuOptionRAMStruct
        lda lR25
        sta lStructPointer1,b
        lda lR25+1
        sta lStructPointer1+1,b
        jsl rlAppendNewStructEntry
        ply
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 82/F3A7

    .endsection Unsorted82F343Section


    .section Unsorted82F3A7Section

      .al
      .xl

      rlLoadCurrentMenuOptionRAMStruct ; 82/F3A7

        .al
        .xl
        .autsiz
        .databank ?

        ; Set lStructPointer2 to $0547 + 5 (current container option RAMStruct)

        phb
        php
        phk
        plb
        .databank $82
        lda lMenuOptionListTop+1,b
        sta lStructPointer2+1,b
        lda lMenuOptionListTop,b
        clc
        adc #$0005
        sta lStructPointer2,b
        plp
        plb
        .databank $82
        rtl

        .databank 0

        ; 82/F3BE

      rlGetCurrentMenuOptionCount ; 82/F3BE

        .al
        .xl
        .autsiz
        .databank ?

        ; Return option count of current menu container

        jsl rlLoadCurrentMenuOptionRAMStruct
        jsl rlGetRAMStructCurrentStructCount
        rtl

        .databank 0

        ; 82/F3C7

      rlSelectMenuOptionByIndex ; 82/F3C7

        .al
        .xl
        .autsiz
        .databank ?

        ; Load 1-based option index A pointer into lMenuOptionPointer

        phb
        php
        phk
        plb
        .databank $82
        sta wStructIndex,b
        jsl rlLoadCurrentMenuOptionRAMStruct
        jsl rlLoadRAMStructDataByIndex
        lda lStructPointer1,b
        sta lMenuOptionPointer,b
        lda lStructPointer1+1,b
        sta lMenuOptionPointer+1,b
        plp
        plb
        .databank $82
        rtl

        .databank 0

        ; 82/F3E5

    .endsection Unsorted82F3A7Section


    .section Unsorted82F3E5Section

      .al
      .xl

      rlHandleMenuOptionInput ; 82/F3E5

        .al
        .autsiz
        .databank ?

        ; Find option containing (wR0, wR1) + container origin and invoke its handler

        phb
        php
        phk
        plb
        phx
        phy
        ldy lMenuOptionListTop,b
        sep #$20
        lda $0547+2,b
        pha
        rep #$20
        plb

        sep #$20
        lda $0000,b,y
        sta wR2
        lda $0001,b,y
        sta wR2+1
        rep #$20

        jsl rlGetCurrentMenuOptionCount
        ora #$0000
        beq _F463

        sta wR5
        ldx #1
        
        _Loop
        txa
        jsl rlSelectMenuOptionByIndex
        phk
        plb

        ldy lMenuOptionPointer,b
        sep #$20
        lda lMenuOptionPointer+2,b
        pha
        rep #$20
        plb

        sep #$20
        lda $0003,b,y
        clc
        adc wR2
        sta wR3

        lda $0004,b,y
        clc
        adc wR2+1
        sta wR4

        lda $0005,b,y
        sta wR3+1
        lda $0006,b,y
        sta wR4+1

        lda wR0
        sec
        sbc wR3
        cmp wR3+1
        bcs +

        lda wR1
        sec
        sbc wR4
        cmp wR4+1
        bcs +

        rep #$20
        jsl rlRunSelectedMenuOptionHandler
        bra _F468

        +
        rep #$20
        inc x
        dec wR5
        bne _Loop

        _F463
        ply
        plx
        plp
        plb
        rtl
        
        _F468
        ply
        plx
        plp
        plb
        rtl

        .databank 0

      rlRunSelectedMenuOptionHandler ; 82/F46D

        .al
        .autsiz
        .databank ?

        ; Call selected option callback from lMenuOptionPointer via rlCallIndirectRoutineFromTable (preserving lR18)

        lda lR18
        pha
        lda lR18+1
        pha

        jsl rlGetSelectedMenuOptionHandlerPointer
        ldx #$0024
        lda #0
        jsl rlCallIndirectRoutineFromTable

        pla
        sta lR18+1
        pla
        sta lR18
        rtl

        .databank 0

      rlGetSelectedMenuOptionHandlerPointer ; 82/F488

        .al
        .autsiz
        .databank ?

        ; Load 24-bit handler pointer pointer at [lMenuOptionPointer]+0 into lR18

        phb
        php
        phk
        plb
        phx

        ldx lMenuOptionPointer,b
        sep #$20
        lda $0540+2,b
        pha
        rep #$20
        plb

        lda $0000,b,x
        sta lR18
        lda $0001,b,x
        sta lR18+1

        plx
        plp
        plb
        rtl

        .databank 0

        ; 82/F4A7

    .endsection Unsorted82F3E5Section


    .section Unsorted82F4A7Section

      .al
      .xl

      rlGetSelectedMenuOptionCoordinates ; 82/F4A7

        .al
        .xl
        .autsiz
        .databank ?

        ; Load packed X/Y coordinate word at [lMenuOptionPointer]+3 into A

        phb
        php
        phk
        plb
        .databank $82
        phx
        ldx lMenuOptionPointer,b
        sep #$20
        lda lMenuOptionPointer+2,b
        pha
        rep #$20
        plb
        .databank ?
        lda $0003,b,x
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 82/F4BF

    .endsection Unsorted82F4A7Section


    .section Unsorted8582D4Section

      .al
      .xl

      rlMoveMapMenuToCursor ; 85/82D4

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ; X = proc. Moves its map menu to the cursor's tile, kept on screen (30x28 tiles) for its size; nothing in the build reaches this.

        lda lR18
        pha
        lda lR18+1
        pha
        lda wR40
        pha
        lda wR41
        pha
        lda wR42
        pha
        jsl rlLoadMapMenuEntryPointerFromProcBody
        jsl rlGetMapMenuTilemapArea
        sta wR42
        sep #$20
        lda #$1E
        sec
        sbc wR42
        sta wR40
        lda #$1C
        sec
        sbc wR42+1
        sta wR41
        lda @l wCursorXOffset
        lsr a
        lsr a
        lsr a
        cmp wR40
        bcc _830A
        lda wR40

        _830A
        sta @l $000534
        lda @l wCursorYOffset
        lsr a
        lsr a
        lsr a
        cmp wR41
        bcc _831B
        lda wR41

        _831B
        sta @l $000535
        rep #$20
        jsl rlMoveMapMenuBG3
        pla
        sta wR42
        pla
        sta wR41
        pla
        sta wR40
        pla
        sta lR18+1
        pla
        sta lR18
        rtl

        .databank 0

        ; 85/8335

      procMapMenuWaitForButton ; 85/8335

        ; A proc that shows a map menu (none given here: the menu data pointer
        ; is 0) and closes it on any button. Nothing in the build creates it.
        .structProcInfo "PW", rlStallProcUntilMapMenuDataLoaded, rlProcMapMenuWaitForButtonDraw, aProcDialogueBoxCode
        .long 0
        .byte 0

    .endsection Unsorted8582D4Section


    .section Unsorted8583C2Section

      .al
      .xl

      rlListMenuProcInit ; 85/83C2

        .al
        .xl
        .autsiz
        .databank ?

        ; Init of a list menu proc: saves the game state (rlMapMenuSaveMapState) and holds the on-cycle routine back for one frame.

        jsl rlMapMenuSaveMapState
        lda aProcSystem.aHeaderOnCycle,b,x
        sta aProcSystem.aBody2,b,x
        lda #<>rlListMenuProcFirstCycle
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 85/83D3

    .endsection Unsorted8583C2Section


    .section Unsorted8583D3Section

      .al
      .xl

      rlListMenuProcFirstCycle ; 85/83D3

        .al
        .xl
        .autsiz
        .databank ?

        ; Puts back the on-cycle routine that rlListMenuProcInit held back.

        lda aProcSystem.aBody2,b,x
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 85/83DA

    .endsection Unsorted8583D3Section


    .section Unsorted8583DASection

      .al
      .xl

      rlListMenuProcSetUp ; 85/83DA

        .al
        .xl
        .autsiz
        .databank ?

        ; Loads the menu named in the proc's header, pushes its option list, draws the options and goes on to rlListMenuProcHandleInput.

        lda #$0009
        jsl rlPlaySoundEffect
        lda aProcSystem.aHeaderTypeOffset,b,x
        tay
        jsl rlLoadMapMenuDataFromProc
        jsl rlListMenuProcPushOptions
        jsl rlDrawMenuOptions
        lda #<>rlListMenuProcHandleInput
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 85/83F8

    .endsection Unsorted8583DASection


    .section Unsorted8583F8Section

      .al
      .xl

      rlListMenuProcHandleInput ; 85/83F8

        .al
        .autsiz
        .databank ?

        ; While the menu is on top: A closes it and runs the option under the cursor (aBody6, 1-based), B closes it, Up and Down move the cursor (wrapping on a new press).

        php
        phb
        phy
        jsl rlLoadMapMenuEntryPointerFromProcBody
        jsl rlCheckListMenuIdle
        beq +

          jml _849A

        +
        lda wJoy1New
        bit #JOY_A
        beq +

          lda #$000A
          jsl rlPlaySoundEffect
          
          jsl rlMapMenuCloseAndRestoreMapState
          lda #1
          sta $00
          lda aProcSystem.aBody6,b,x
          sta $02
          jsl rlHandleMenuOptionInput
          jsr rsListMenuProcEnd
          bra _End

        +
        lda wJoy1New
        bit #JOY_B
        beq +

          lda #$0021
          jsl rlPlaySoundEffect

          jsl rlMapMenuCloseAndRestoreMapState
          jsr rsListMenuProcEnd
          bra _End
        
        +
        jsl rlGetCurrentMenuOptionCount
        asl a
        sta $00

        lda wJoy1Repeated
        bit #JOY_Up
        beq _8472

          lda aProcSystem.aBody6,b,x
          sec
          sbc #2
          bpl +

            lda wJoy1New
            bit #JOY_Up
            beq _8472

              lda $00
              dec a

          +
          sta aProcSystem.aBody6,b,x
          lda #6
          jsl rlPlaySoundEffect
          bra _849A
        
        _8472
        lda wJoy1Repeated
        bit #JOY_Down
        beq _849A

          lda aProcSystem.aBody6,b,x
          clc
          adc #2
          cmp $00
          beq +
          bcc +

            lda wJoy1New
            bit #JOY_Down
            beq _849A

              lda #1

          +
          sta aProcSystem.aBody6,b,x
          lda #6
          jsl rlPlaySoundEffect
        
        _849A
        jsr rsListMenuDrawCursor
        
        _End
        ply
        plb
        plp
        rtl

        .databank 0

        ; 85/84A1

    .endsection Unsorted8583F8Section


    .section Unsorted8584A1Section

      .al
      .xl

      rsListMenuProcEnd ; 85/84A1

        .al
        .xl
        .autsiz
        .databank ?

        ; Pops the option list and frees the proc.

        jsl rlListMenuPopOptions
        jsl rlProcEngineFreeProc
        rts

        .databank 0

        ; 85/84AA

    .endsection Unsorted8584A1Section


    .section ProcScript8584AASection

      .al
      .xl

      aProcListMenuCode ; 85/84AA

        PROC_HALT


        ; 85/84AC

    .endsection ProcScript8584AASection


    .section Unsorted8584ACSection

      .al
      .xl

      rlListMenuProcPushOptions ; 85/84AC

        .al
        .xl
        .autsiz
        .databank ?

        ; Y = proc header: pushes the option list at +$0C, keeps it in aBody4/aBody5 and puts the cursor (aBody6) on option 1.

        lda $000C,b,y
        sta lMenuOptionPointer,b
        lda $000D,b,y
        sta lMenuOptionPointer+1,b
        jsl rlPushMenuOptionList
        lda lMenuOptionListTop,b
        sta aProcSystem.aBody4,b,x
        lda lMenuOptionListTop+1,b
        sta aProcSystem.aBody5,b,x
        lda #$0001
        sta aProcSystem.aBody6,b,x
        rtl

        .databank 0

        ; 85/84CF

      rlListMenuProcRestoreOptions ; 85/84CF

        .al
        .xl
        .autsiz
        .databank ?

        ; Makes the proc's option list (aBody4/aBody5) the top one again. Nothing in the build reaches this.

        lda aProcSystem.aBody4,b,x
        sta lMenuOptionListTop,b
        lda aProcSystem.aBody5,b,x
        sta lMenuOptionListTop+1,b
        rtl

        .databank 0

        ; 85/84DC

    .endsection Unsorted8584ACSection


    .section Unsorted8584DCSection

      .al
      .xl

      rlKeepUnitMenuAwayFromCursor ; 85/84DC

        .al
        .xl
        .autsiz
        .databank ?

        ; Moves the current map menu to column $13 when the cursor is on the left side of the screen (bit 2 of wMapStateFlags remembers which side).

        lda wCursorXOffset,b
        cmp #$0070
        bcc _84F1
        cmp #$0090
        bcs _8503
        lda wMapStateFlags,b
        bit #$0004
        beq _8503

        _84F1
        lda #$0004
        tsb wMapStateFlags,b
        jsl rlGetMapMenuPosition
        and #$FF00
        ora #$0013
        bra _850B


        _8503
        lda #$0004
        trb wMapStateFlags,b
        bra _8515


        _850B
        sta wMapMenuNewPosition,b
        jsl rlMoveMapMenu
        jsr rsListMenuDrawCursor

        _8515
        rtl

        .databank 0

        ; 85/8516

    .endsection Unsorted8584DCSection


    .section Unsorted858516Section

      .al
      .xl

      rlCheckListMenuIdle ; 85/8516

        .al
        .xl
        .autsiz
        .databank ?

        ; A = 1 (nonzero) while the screen is blanked or dimmed or another option list is above this proc's (aBody4/aBody5), else 0.

        lda bBufferINIDISP
        bit #$0080
        bne _8539
        eor #$FFFF
        bit #$000F
        bne _8539
        lda aProcSystem.aBody5,b,x
        cmp lMenuOptionListTop+1,b
        bne _8539
        lda aProcSystem.aBody4,b,x
        cmp lMenuOptionListTop,b
        bne _8539
        lda #$0000
        rtl


        _8539
        lda #$0001
        rtl

        .databank 0

        ; 85/853D

      rlListMenuPopOptions ; 85/853D

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlPopMenuOptionList
        rtl

        .databank 0

        ; 85/8542

      rsListMenuDrawCursor ; 85/8542

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws the pointing hand at option aBody6 of the current map menu.

        phx
        jsl rlGetMapMenuPosition
        sep #$20
        asl a
        asl a
        asl a
        sta wR0
        xba
        clc
        adc aProcSystem.aBody6,b,x
        asl a
        asl a
        asl a
        clc
        adc #$02
        sta wR1
        rep #$20
        lda #$FF00
        trb wR0
        trb wR1
        jsl rlCheckListMenuIdle
        jsl rlDrawHandCursor
        plx
        rts

        .databank 0

        ; 85/856E

    .endsection Unsorted858516Section


    .section Unsorted85856ESection

      .al
      .xl

      rlDrawMenuOptions ; 85/856E

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws the text of each option of the current list into the current map menu, draws the menu, and turns on BG2 and BG3.

        phx
        phy
        jsl rlClearMapMenuTiles
        jsl rlGetCurrentMenuOptionCount
        ora #$0000
        beq _859B
        tay

        _857E
        tya
        jsl rlSelectMenuOptionByIndex
        jsl rlGetSelectedMenuOptionHandlerPointer
        lda lR18
        clc
        adc #$0005
        sta lR18
        jsl rlGetSelectedMenuOptionCoordinates
        tax
        jsl rlDrawMapMenuTextLine
        dec y
        bne _857E

        _859B
        ply
        plx
        jsl rlDrawMapMenu
        lda wChapterFlags,b
        bit #$0020
        bne _85AD
        jsl rlFreeHDMAEntry0

        _85AD
        lda #$0006
        tsb bBufferTM
        rtl

        .databank 0

        ; 85/85B3

      rlDrawMapMenuFourDigitNumber ; 85/85B3

        .al
        .xl
        .autsiz
        .databank ?

        ; A = 0-9999, X = row and column: two pairs of two-row digits. Nothing in the build reaches this.

        sta wR13
        lda #$0064
        sta wR14
        jsl rlUnsignedDivide16By8
        lda wR13
        jsl rlDrawMapMenuTallTwoDigitNumber
        txa
        clc
        adc #$0002
        tax
        lda wR10
        and #$00FF
        jsl rlDrawMapMenuTallTwoDigitNumber
        rtl

        .databank 0

        ; 85/85D4

      rlDrawMapMenuSixDigitNumber ; 85/85D4

        .al
        .xl
        .autsiz
        .databank ?

        ; A = a number, X = row and column: three pairs of two-row digits. Nothing in the build reaches this.

        sta wR13
        lda #$2710
        sta wR14
        jsl rlUnsignedDivide16By16R13
        lda wR13
        jsl rlDrawMapMenuTallTwoDigitNumber
        txa
        clc
        adc #$0002
        tax
        lda wR10
        sta wR13
        lda #$0064
        sta wR14
        jsl rlUnsignedDivide16By8
        lda wR13
        jsl rlDrawMapMenuTallTwoDigitNumber
        txa
        clc
        adc #$0002
        tax
        lda wR10
        and #$00FF
        jsl rlDrawMapMenuTallTwoDigitNumber
        rtl

        .databank 0

        ; 85/860E

    .endsection Unsorted85856ESection


    .section Unsorted85860ESection

      .al
      .xl

      rsDrawMapMenuNumber100 ; 85/860E

        .al
        .xl
        .autsiz
        .databank ?

        ; X = row and column: draws the three-tile "100" (two rows), for a hit or critical rate of 100.

        phx
        lda aCurrentTilemapInfo,b
        pha
        lda #$2500
        sta aCurrentTilemapInfo,b
        lda #(`aMapMenuNumber100Tiles)<<8
        sta lR18+1
        lda #<>aMapMenuNumber100Tiles
        sta lR18
        jsl rlDrawMapMenuTileString
        txa
        clc
        adc #$0100
        tax
        lda #$2510
        sta aCurrentTilemapInfo,b
        lda #(`aMapMenuNumber100Tiles)<<8
        sta lR18+1
        lda #<>aMapMenuNumber100Tiles
        sta lR18
        jsl rlDrawMapMenuTileString
        pla
        sta aCurrentTilemapInfo,b
        plx
        rts

        .databank 0

        ; 85/8647

    .endsection Unsorted85860ESection


    .section Table858647Section

      .al
      .xl

      aMapMenuNumber100Tiles ; 85/8647
        .byte $AC, $AD, $AE, $00

    .endsection Table858647Section


    .section Unsorted85864BSection

      .al
      .xl

      rlDrawSelectedUnitNameInMapMenu ; 85/864B

        .al
        .xl
        .autsiz
        .databank ?

        ; X = row and column.

        jsl rlGetSelectedUnitNamePointer
        lda lRoutineVariable+1,b
        sta lR18+1
        lda lRoutineVariable,b
        sta lR18
        jsl rlDrawMapMenuTextLine
        rtl

        .databank 0

        ; 85/865E

      rlDrawSelectedUnitClassInMapMenu ; 85/865E

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlGetSelectedUnitClassNamePointer
        lda lRoutineVariable+1,b
        sta lR18+1
        lda lRoutineVariable,b
        sta lR18
        jsl rlDrawMapMenuTextLine
        rtl

        .databank 0

        ; 85/8671

    .endsection Unsorted85864BSection


    .section Unsorted858671Section

      .al
      .xl

      rlDrawSelectedUnitFactionInMapMenu ; 85/8671

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ; X = row and column. Nothing in the build reaches this.

        jsl rlGetSelectedUnitFactionNamePointer
        lda lRoutineVariable+1,b
        sta lR18+1
        lda lRoutineVariable,b
        sta lR18
        jsl rlDrawMapMenuTextLine
        rtl

        .databank 0

        ; 85/8684

    .endsection Unsorted858671Section


    .section Unsorted858684Section

      .al
      .xl

      rlDrawItemNameInMapMenu ; 85/8684

        .al
        .xl
        .autsiz
        .databank ?

        ; X = row and column; the item in wCurrentItemDataROMPointer.

        jsl rlGetItemNamePointer
        lda lRoutineVariable+1,b
        sta lR18+1
        lda lRoutineVariable,b
        sta lR18
        jsl rlDrawMapMenuTextLine
        rtl

        .databank 0

        ; 85/8697

    .endsection Unsorted858684Section


    .section Unsorted858697Section

      .al
      .xl

      rlDrawCastleNameInMapMenu ; 85/8697

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ; X = row and column; the location in wEventLocationEntry. Nothing in the build reaches this.

        jsl rlGetEventLocationEntryCastleName
        lda lRoutineVariable+1,b
        sta lR18+1
        lda lRoutineVariable,b
        sta lR18
        jsl rlDrawMapMenuTextLine
        rtl

        .databank 0

        ; 85/86AA

    .endsection Unsorted858697Section


    .section Unsorted8586AASection

      .al
      .xl

      rlDrawListCursorAtIndex ; 85/86AA

        .al
        .xl
        .autsiz
        .databank ?

        ; A = 1-based entry, wR0/wR1 = column step and entries per column: draws the pointing hand at that entry of the current map menu.

        phx
        sta wR13
        jsl rlLoadMapMenuEntryPointerFromProcBody
        lda wR1
        sta wR14
        jsl rlUnsignedDivide16By8
        lda wR10
        bne _86BF
        lda wR1

        _86BF
        dec a
        asl a
        xba
        clc
        adc wR0
        sta wR0
        jsl rlGetMapMenuPosition
        clc
        adc wR0
        sep #$20
        asl a
        asl a
        asl a
        sta wR0
        xba
        asl a
        asl a
        asl a
        clc
        adc #$02
        sta wR1
        rep #$20
        lda #$FF00
        trb wR0
        trb wR1
        lda #$0027
        jsl rlFindLastMapMenu
        lda lR19
        sec
        sbc lMapMenuRAMEntryPointer,b
        jsl rlDrawHandCursor
        plx
        rtl

        .databank 0

        ; 85/86FA

    .endsection Unsorted8586AASection


    .section Unsorted8586FASection

      .al
      .xl

      rlCloseMapMenuFromProc ; 85/86FA

        .al
        .xl
        .autsiz
        .databank ?

        ; Calls rlMapMenuCloseAndRestoreMapState; map menu procs call it just before
        ; freeing themselves.

        jsl rlMapMenuCloseAndRestoreMapState
        rtl

        .databank 0

        ; 85/86FF

    .endsection Unsorted8586FASection


    .section Unsorted8586FFSection

      .al
      .xl

      rlInitMapMenuProcAndTileBase ; 85/86FF

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Like rlInitMapMenuProc, and sets the tile base to $20F0 (the number tiles).

        jsl rlStallProcUntilMapMenuDataLoaded
        lda #$20F0
        sta aCurrentTilemapInfo,b
        lda #$20FF
        sta wMapMenuClearTile,b
        jsl rlClearMapMenuTiles
        lda #$0000
        sta wBufferBG3VOFS
        sta wBufferBG3HOFS
        rtl

        .databank 0

        ; 85/871B

      rlCloseMapMenuOnAnyButton ; 85/871B

        ; Nothing in the build reaches this; it did not run in fe4.cdl.
        ; Closes the map menu and frees the proc when a button is pressed.
        .al
        .xl
        .autsiz
        .databank ?

        ; Nothing in the build reaches this; it did not run in fe4.cdl. Closes the map menu and frees the proc when a button is pressed.

        lda wJoy1New
        beq _8727
        jsl rlCloseMapMenuFromProc
        jsl rlProcEngineFreeProc

        _8727
        rtl

        .databank 0

        ; 85/8728

    .endsection Unsorted8586FFSection


    .section Unsorted858751Section

      .al
      .xl

      rlMoveMapMenu ; 85/8751

        .al
        .xl
        .autsiz
        .databank ?

        ; Moves the current map menu to wMapMenuNewPosition (bit 15 set hides it) and redraws the rows it left and entered on both layers: BG3 (text) and the frames in aBG2TilemapBuffer.Page1.

        jsl rlGetMapMenuRows
        lda wR12
        pha
        lda wR13
        pha
        jsl rlMoveMapMenuBG3
        pla
        sta wR13
        pla
        sta wR12
        jsl rlRedrawMapMenuFrameRows
        lda wR10
        cmp @l wR12
        bcc _8779
        lda @l wR13
        cmp wR11
        bcs _877D

        _8779
        jsl rlDrawMapMenu

        _877D
        rtl

        .databank 0

        ; 85/877E

      rlHideMapMenu ; 85/877E

        .al
        .xl
        .autsiz
        .databank ?

        ; Sets bit 15 of the current map menu's position (hidden) and redraws.

        phb
        php
        phk
        plb
        .databank $85
        jsl rlGetMapMenuPosition
        ora #$8000
        sta wMapMenuNewPosition,b
        jsl rlMoveMapMenu
        plp
        plb
        .databank $85
        rtl

        .databank 0

        ; 85/8793

    .endsection Unsorted858751Section


    .section Unsorted858793Section

      .al
      .xl

      rlShowMapMenu ; 85/8793

        .al
        .xl
        .autsiz
        .databank ?

        ; Clears bit 15 of the current map menu's position and redraws.

        phb
        php
        phk
        plb
        .databank $85
        jsl rlGetMapMenuPosition
        and #$7FFF
        sta wMapMenuNewPosition,b
        jsl rlMoveMapMenu
        plp
        plb
        .databank $85
        rtl

        .databank 0

        ; 85/87A8

    .endsection Unsorted858793Section


    .section Unsorted8587A8Section

      .al
      .xl

      rlResizeMapMenu ; 85/87A8

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ; A = new width and height of the current map menu; redraws both layers. Nothing in the build reaches this.

        phb
        php
        phk
        plb
        .databank $85
        sta wMapMenuNewPosition,b
        jsl rlGetMapMenuRows
        lda wR12
        pha
        lda wR13
        pha
        lda wMapMenuNewPosition,b
        jsl rlResizeMapMenuBG3
        pla
        sta wR13
        pla
        sta wR12
        jsl rlRedrawMapMenuFrameRows
        lda wR10
        cmp @l wR12
        bcc _87DA
        lda @l wR13
        cmp wR11
        bcs _87DE

        _87DA
        jsl rlDrawMapMenu

        _87DE
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 85/87E1

    .endsection Unsorted8587A8Section


    .section Unsorted8587E1Section

      .al
      .xl

      rlDrawMapMenu ; 85/87E1

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws the current map menu: its tiles on BG3 and its frame on BG2.

        phb
        php
        phk
        plb
        .databank $85
        phy
        jsl rlDrawMapMenuBG3
        jsl rlMapMenuBuildTilemap
        ply
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 85/87F2

    .endsection Unsorted8587E1Section


    .section Unsorted8587F2Section

      .al
      .xl

      rlMoveMapMenuFrame ; 85/87F2

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Sets the current map menu's position to wMapMenuNewPosition and redraws only the frame layer. Nothing in the build reaches this.

        phb
        php
        phk
        plb
        .databank $85
        jsl rlGetMapMenuRows
        lda wMapMenuNewPosition,b
        jsl rlSetMapMenuPosition
        jsl rlRedrawMapMenuFrameRows
        jsl rlGetMapMenuYPositions
        lda wR10
        cmp @l wR12
        bcc _8819
        lda @l wR13
        cmp wR11
        bcs _881D

        _8819
        jsl rlDrawMapMenuFrame

        _881D
        plp
        plb
        .databank $85
        rtl

        .databank 0

        ; 85/8820

      rlHideMapMenuFrame ; 85/8820

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $85
        jsl rlGetMapMenuPosition
        ora #$8000
        sta wMapMenuNewPosition,b
        jsl rlMoveMapMenuFrame
        plp
        plb
        .databank $85
        rtl

        .databank 0

        ; 85/8835

      rlShowMapMenuFrame ; 85/8835

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $85
        jsl rlGetMapMenuPosition
        and #$7FFF
        sta wMapMenuNewPosition,b
        jsl rlMoveMapMenuFrame
        plp
        plb
        .databank $85
        rtl

        .databank 0

        ; 85/884A

    .endsection Unsorted8587F2Section


    .section Unsorted85884ASection

      .al
      .xl

      rlResizeMapMenuFrame ; 85/884A

        .al
        .xl
        .autsiz
        .databank ?

        ; A = new width and height of the current map menu; redraws only the frame layer.

        phb
        php
        phk
        plb
        .databank $85
        phy
        pha
        jsl rlGetMapMenuRows
        pla
        jsl rlSetMapMenuTilemapArea
        jsl rlRedrawMapMenuFrameRows
        jsl rlGetMapMenuYPositions
        lda wR10
        cmp @l wR12
        bcc _8871
        lda @l wR13
        cmp wR11
        bcs _8875

        _8871
        jsl rlDrawMapMenuFrame

        _8875
        ply
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 85/8879

      rlDrawMapMenuFrame ; 85/8879

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws the current map menu's frame on BG2 (rlMapMenuBuildTilemap).

        jsl rlGetMapMenuRows
        jsl rlMapMenuBuildTilemap
        rtl

        .databank 0

        ; 85/8882

      rlCloseMapMenu ; 85/8882

        .al
        .xl
        .autsiz
        .databank ?

        ; Sets $0534 to $FFFF, runs rlMoveMapMenu (works with the menu's rectangle in
        ; wR10-wR13), then rlRemoveMapMenu.

        lda #$FFFF
        sta wMapMenuNewPosition,b
        jsl rlMoveMapMenu
        jsl rlRemoveMapMenu
        rtl

        .databank 0

        ; 85/8891

      rlClearMapMenuFrameRows ; 85/8891

        .al
        .xl
        .autsiz
        .databank ?

        ; Fills rows wR12-wR13 of the frame layer (aBG2TilemapBuffer.Page1) with tile $030F.

        phb
        php
        phk
        plb
        .databank $85
        phx
        phy
        lda wR13
        sec
        sbc wR12
        bcc _88EE
        asl a
        tay
        lda wR12
        xba
        lsr a
        lsr a
        clc
        adc #$7B88
        tax
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb
        .databank $7E

        _88B2
        lda #$030F
        sta $0000,b,x
        sta $0002,b,x
        sta $0004,b,x
        sta $0006,b,x
        sta $0008,b,x
        sta $000A,b,x
        sta $000C,b,x
        sta $000E,b,x
        sta $0010,b,x
        sta $0012,b,x
        sta $0014,b,x
        sta $0016,b,x
        sta $0018,b,x
        sta $001A,b,x
        sta $001C,b,x
        sta $001E,b,x
        txa
        clc
        adc #$0020
        tax
        dec y
        bne _88B2

        _88EE
        ply
        plx
        plp
        plb
        .databank $7E
        rtl

        .databank 0

        ; 85/88F3

      rlRedrawMapMenuFrameRows ; 85/88F3

        .al
        .xl
        .autsiz
        .databank ?

        ; Clears rows wR12-wR13 of the frame layer and draws the frame of every open map menu, back to front.

        phb
        php
        phk
        plb
        .databank $85
        phx
        phy
        lda lMapMenuListHead,b
        ora lMapMenuListHead+1,b
        beq _8957
        lda wR12
        cmp #$0020
        bcs _8957
        lda wR13
        cmp #$0020
        bcs _8957
        jsl rlClearMapMenuFrameRows
        lda lMapMenuRAMEntryPointer,b
        pha
        lda lMapMenuRAMEntryPointer+1,b
        pha
        phb
        lda lMapMenuListHead,b
        sta lMapMenuRAMEntryPointer,b
        lda lMapMenuListHead+1,b
        sta lMapMenuRAMEntryPointer+1,b

        _8928
        jsl rlMapMenuBuildTilemap
        sep #$20
        lda @l lMapMenuRAMEntryPointer+2
        pha
        rep #$20
        plb
        .databank ?
        lda $000C,b,y
        ora $000D,b,y
        beq _894E
        lda $000C,b,y
        sta @l lMapMenuRAMEntryPointer
        lda $000D,b,y
        sta @l lMapMenuRAMEntryPointer+1
        bra _8928


        _894E
        plb
        .databank ?
        pla
        sta lMapMenuRAMEntryPointer+1,b
        pla
        sta lMapMenuRAMEntryPointer,b

        _8957
        ply
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 85/895C

    .endsection Unsorted85884ASection


    .section Unsorted8589C5Section

      .al
      .xl

      rsBeginMapMenuFrame ; 85/89C5

        .al
        .xl
        .autsiz
        .databank ?

        ; Creates a tilemap entry for the frame, as large as the menu, from aMapMenuFrameTilemapData.

        jsl rlGetMapMenuTilemapArea
        pha
        lda #(`aMapMenuFrameTilemapData)<<8
        sta lR18+1
        lda #<>aMapMenuFrameTilemapData
        sta lR18
        jsl rlLoadMapMenuTilemapData
        pla
        jsl rlSetTilemapEntryArea
        rts

        .databank 0

        ; 85/89DE

    .endsection Unsorted8589C5Section


    .section Table8589DESection

      .al
      .xl

      aMapMenuFrameTilemapData ; 85/89DE
        .byte $00, $00, $88, $7B, $7E, $00, $4A, $D5, $7F

    .endsection Table8589DESection


    .section Unsorted8589E7Section

      .al
      .xl

      rsEndMapMenuFrame ; 85/89E7

        .al
        .xl
        .autsiz
        .databank ?

        ; Copies the frame's tiles into the frame layer at the menu's position and frees its tilemap entry.

        jsl rlGetMapMenuTileIndex
        tax
        jsl rlCopyTilemapEntryToBG
        jsl rlRemoveMapMenuTilemapRAMEntry
        rts

        .databank 0

        ; 85/89F5

      rsDrawMapMenuFrameType0 ; 85/89F5

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsBeginMapMenuFrame
        stz aCurrentTilemapInfo,b
        lda #(`aMapMenuFrameType0Fill)<<8
        sta lR18+1
        lda #<>aMapMenuFrameType0Fill
        sta lR18
        jsl rlFillTilemapEntryWithPattern
        lda #(`aMapMenuFrameType0Border)<<8
        sta lR18+1
        lda #<>aMapMenuFrameType0Border
        sta lR18
        jsl rlDrawFancyFrameToTilemapEntry
        jsr rsEndMapMenuFrame
        rts

        .databank 0

        ; 85/8A1B

    .endsection Unsorted8589E7Section


    .section Table858A1BSection

      .al
      .xl

      aMapMenuFrameType0Fill ; 85/8A1B
        .byte $07, $03
        .word $236C, $236D, $236C, $236D, $236D, $236C, $236D, $236C
        .word $236C, $236D, $236C, $236C, $236D, $236C, $236C, $236C
        .word $236D, $236C, $236D, $236D, $236C

      aMapMenuFrameType0Border ; 85/8A47
        .word $2368, $2369, $2369, $2369, $236A, $236B, $236C, $236D
        .word $2376, $2377, $2376, $2377, $236C, $236D, $236E, $2378
        .word $236F, $236F, $2379, $237A

    .endsection Table858A1BSection


    .section Unsorted858A6FSection

      .al
      .xl

      rsDrawMapMenuFrameType1 ; 85/8A6F

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsBeginMapMenuFrame
        stz aCurrentTilemapInfo,b
        lda #(`aMapMenuFrameType1Fill)<<8
        sta lR18+1
        lda #<>aMapMenuFrameType1Fill
        sta lR18
        jsl rlFillTilemapEntryWithPattern
        lda #(`aMapMenuFrameType1Border)<<8
        sta lR18+1
        lda #<>aMapMenuFrameType1Border
        sta lR18
        jsl rlDrawFancyFrameToTilemapEntry
        jsr rsEndMapMenuFrame
        rts

        .databank 0

        ; 85/8A95

    .endsection Unsorted858A6FSection


    .section Table858A95Section

      .al
      .xl

      aMapMenuFrameType1Fill ; 85/8A95
        .byte $04, $03
        .word $236C, $236D, $236C, $236D, $236C, $236C, $236D, $236C
        .word $236C, $236C, $236D, $236C

      aMapMenuFrameType1Border ; 85/8AAF
        .word $237B, $237C, $2369, $2369, $236A, $237D, $236C, $236D
        .word $2376, $2377, $2376, $2377, $236C, $236D, $236E, $237E
        .word $237F, $236F, $2379, $237A

    .endsection Table858A95Section


    .section Unsorted858AD7Section

      .al
      .xl

      rsDrawMapMenuFrameType2 ; 85/8AD7

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsBeginMapMenuFrame
        stz aCurrentTilemapInfo,b
        lda #(`aMapMenuFrameType2Fill)<<8
        sta lR18+1
        lda #<>aMapMenuFrameType2Fill
        sta lR18
        jsl rlFillTilemapEntryWithPattern
        lda #(`aMapMenuFrameType2Border)<<8
        sta lR18+1
        lda #<>aMapMenuFrameType2Border
        sta lR18
        jsl rlDrawFancyFrameToTilemapEntry
        jsr rsEndMapMenuFrame
        rts

        .databank 0

        ; 85/8AFD

    .endsection Unsorted858AD7Section


    .section Table858AFDSection

      .al
      .xl

      aMapMenuFrameType2Fill ; 85/8AFD
        .byte $07, $03
        .word $236C, $236D, $236C, $236D, $236D, $236C, $236D, $236C
        .word $236C, $236D, $236C, $236C, $236D, $236C, $236C, $236C
        .word $236D, $236C, $236D, $236D, $236C

      aMapMenuFrameType2Border ; 85/8B29
        .word $2368, $2369, $2369, $2369, $236A, $236B, $236C, $236D
        .word $2376, $2377, $2376, $2377, $236C, $236D, $236E, $2378
        .word $236F, $236F, $2379, $237A

    .endsection Table858AFDSection


    .section Unsorted858B51Section

      .al
      .xl

      rsDrawMapMenuFrameType3 ; 85/8B51

        .al
        .xl
        .autsiz
        .databank ?

        lda #$1800
        sta aCurrentTilemapInfo,b
        bra rsDrawMapMenuFrameType4._8B5F

        .databank 0

        ; 85/8B59

      rsDrawMapMenuFrameType4 ; 85/8B59

        .al
        .xl
        .autsiz
        .databank ?

        lda #$1C00
        sta aCurrentTilemapInfo,b

        _8B5F
        jsr rsBeginMapMenuFrame
        lda #(`aMapMenuFrameType3Fill)<<8
        sta lR18+1
        lda #<>aMapMenuFrameType3Fill
        sta lR18
        jsl rlFillTilemapEntryWithPattern
        lda #$2340
        tsb aCurrentTilemapInfo,b
        lda #(`aMapMenuFrameType3TopEdge)<<8
        sta lR18+1
        lda #<>aMapMenuFrameType3TopEdge
        sta lR18
        ldx #$0101
        jsl rlDrawTileStringToTilemapEntry
        lda #$23FF
        trb aCurrentTilemapInfo,b
        lda #(`aMapMenuFrameType3Border)<<8
        sta lR18+1
        lda #<>aMapMenuFrameType3Border
        sta lR18
        jsl rlDrawFancyFrameToTilemapEntry
        jsl rlGetTilemapEntryWidth
        and #$00FF
        cmp #$000C
        bcc _8BCF
        lda #$2340
        tsb aCurrentTilemapInfo,b
        lda #(`aMapMenuFrameType3WideEdge1)<<8
        sta lR18+1
        lda #<>aMapMenuFrameType3WideEdge1
        sta lR18
        ldx #$0001
        jsl rlDrawTileStringToTilemapEntry
        lda #(`aMapMenuFrameType3WideEdge2)<<8
        sta lR18+1
        lda #<>aMapMenuFrameType3WideEdge2
        sta lR18
        ldx #$0101
        jsl rlDrawTileStringToTilemapEntry

        _8BCF
        jsr rsEndMapMenuFrame
        rts

        .databank 0

        ; 85/8BD3

    .endsection Unsorted858B51Section


    .section Table858BD3Section

      .al
      .xl

      aMapMenuFrameType3Fill ; 85/8BD3
        .byte $06, $03
        .word $2345, $2346, $2347, $2348, $2349, $234A, $2348, $2349
        .word $234A, $2355, $2356, $2357, $2355, $2356, $2357, $2345
        .word $2346, $2347

      aMapMenuFrameType3WideEdge1 ; 85/8BF9
        .byte $0B, $0C, $0D, $0E, $0E, $0C, $0E, $0D, $0F, $00

      aMapMenuFrameType3WideEdge2 ; 85/8C03
        .byte $1B, $1C, $1D, $1E, $1D, $1C, $1E, $1D, $1F, $00

      aMapMenuFrameType3TopEdge ; 85/8C0D
        .byte $18, $19, $18, $14, $19, $14, $18, $14, $19, $18, $19, $14, $18, $19, $14, $19
        .byte $14, $18, $19, $14, $18, $19, $14, $19, $00

      aMapMenuFrameType3Border ; 85/8C26
        .word $2343, $2344, $2344, $6344, $6343, $2353, $2354, $6354
        .word $6353, $2350, $2352, $A350, $A351, $E351, $A352, $A340
        .word $A341, $A341, $A341, $A342

    .endsection Table858BD3Section


    .section Unsorted858C4ESection

      .al
      .xl

      rsDrawMapMenuFrameType5 ; 85/8C4E

        .al
        .xl
        .autsiz
        .databank ?

        lda #$1800
        sta aCurrentTilemapInfo,b
        bra rsDrawMapMenuFrameType6._8C5C

      rsDrawMapMenuFrameType6 ; 85/8C56

        .al
        .xl
        .autsiz
        .databank ?

        ; Type 5's frame with the tile base $1C00. No menu found uses type 6.

        lda #$1C00
        sta aCurrentTilemapInfo,b

        _8C5C
        jsr rsBeginMapMenuFrame
        lda #(`aMapMenuFrameType5Fill)<<8
        sta lR18+1
        lda #<>aMapMenuFrameType5Fill
        sta lR18
        jsl rlFillTilemapEntryWithPattern
        lda #$23FF
        trb aCurrentTilemapInfo,b
        lda #(`aMapMenuFrameType5Border)<<8
        sta lR18+1
        lda #<>aMapMenuFrameType5Border
        sta lR18
        jsl rlDrawFancyFrameToTilemapEntry
        jsr rsEndMapMenuFrame
        rts

        .databank 0

        ; 85/8C85

    .endsection Unsorted858C4ESection


    .section Table858C85Section

      .al
      .xl

      aMapMenuFrameType5Fill ; 85/8C85
        .byte $06, $03
        .word $2345, $2346, $2347, $2348, $2349, $234A, $2348, $2349
        .word $234A, $2355, $2356, $2357, $2355, $2356, $2357, $2345
        .word $2346, $2347

      aMapMenuFrameType5Border ; 85/8CAB
        .word $2340, $2341, $2341, $6341, $2342, $2350, $2351, $6351
        .word $2352, $2350, $2352, $A350, $A351, $E351, $A352, $A340
        .word $A341, $A341, $A341, $A342

    .endsection Table858C85Section


    .section Unsorted859B2ASection

      .al
      .xl

      rlSetMapMenuTextColors ; 85/9B2A

        .al
        .xl
        .autsiz
        .databank ?

        ; Saves BG colours 5-7 (in $7FEB0A) and sets aMapMenuTextColors.

        phx
        ldx #$0004

        _9B2E
        lda $010A,b,x
        sta $7FEB0A,x
        lda aMapMenuTextColors,x
        sta $010A,b,x
        dec x
        dec x
        bpl _9B2E
        plx
        rtl

        .databank 0

        ; 85/9B42

    .endsection Unsorted859B2ASection


    .section Table859B42Section

      .al
      .xl

      aMapMenuTextColors ; 85/9B42

        ; Read by rlSetMapMenuTextColors.

        .word $39AA, $7BDA, $0C21

        ; 85/9B48

    .endsection Table859B42Section


    .section Unsorted859B48Section

      .al
      .xl

      rlRestoreMapMenuTextColors ; 85/9B48

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0004

        _9B4C
        lda $7FEB0A,x
        sta $010A,b,x
        dec x
        dec x
        bpl _9B4C
        plx
        rtl

        .databank 0

        ; 85/9B59

    .endsection Unsorted859B48Section


    .section Unsorted859BBDSection

      .al
      .xl

      rlLoadWindowPaletteColors ; 85/9BBD

        .al
        .xl
        .autsiz
        .databank ?

        ; Copies colours 8-15 of aWindowPalette into BG palette 0.

        phx
        ldx #$0010

        _9BC1
        lda aWindowPalette,x
        sta aBGPaletteBuffer,b,x
        inc x
        inc x
        cpx #$0020
        bmi _9BC1
        plx
        rtl

        .databank 0

        ; 85/9BD1

    .endsection Unsorted859BBDSection


    .section Table859D88Section

      .al
      .xl

      aMapMenuGradientHDMAInfo .dstruct structHDMAIndirectEntryInfo, rlMapMenuGradientHDMAInit, rlMapMenuGradientHDMACycle, aMapMenuGradientHDMACode, wDialogueBoxHDMAYPixelPosition, PPU_REG_BASE + $32, $40, $85 ; 85/9D88

    .endsection Table859D88Section


    .section Unsorted859D94Section

      .al
      .xl

      rlMapMenuGradientHDMAInit ; 85/9D94

        .al
        .xl
        .autsiz
        .databank ?

        ; Subtracts the fixed colour from BG2 and builds a COLDATA table in wDialogueBoxHDMA: wR43 = first line and height, wR42 = steps and shape.

        sep #$20
        lda #$00
        sta bBufferCGWSEL
        lda #$82
        sta bBufferCGADSUB
        rep #$20
        lda wR43
        xba
        and #$00FF
        sta wR7
        lda wR43
        and #$00FF
        sta wR5
        lda wR42
        xba
        and #$00FF
        sta wR6
        lda wR42
        and #$00FF
        sta wR4
        phx
        ldx #$0000
        jsr rsMapMenuGradientSkipLines
        jsr rsMapMenuGradientBuild
        plx
        rtl

        .databank 0

        ; 85/9DCA

      rlMapMenuGradientHDMACycle ; 85/9DCA

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 85/9DCB


      aMapMenuGradientHDMACode ; 85/9DCB

        HDMA_HALT

    .endsection Unsorted859D94Section


    .section Unsorted859DCDSection

      .al
      .xl

      rsMapMenuGradientSkipLines ; 85/9DCD

        .al
        .xl
        .autsiz
        .databank ?

        lda wR7
        beq _9E06
        cmp #$0080
        bmi _9DF2
        lda wR7
        sec
        sbc #$007F
        sta wR7
        sep #$20
        lda #$7F
        sta wDialogueBoxHDMAYPixelPosition,x
        rep #$20
        inc x
        lda #<>aMapMenuGradientNone
        sta wDialogueBoxHDMAYPixelPosition,x
        inc x
        inc x

        _9DF2
        sep #$20
        lda wR7
        sta wDialogueBoxHDMAYPixelPosition,x
        rep #$20
        inc x
        lda #<>aMapMenuGradientNone
        sta wDialogueBoxHDMAYPixelPosition,x
        inc x
        inc x

        _9E06
        rts

        .databank 0

        ; 85/9E07


      aMapMenuGradientNone ; 85/9E07

        .byte $E0

    .endsection Unsorted859DCDSection


    .section Unsorted859E08Section

      .al
      .xl

      rsMapMenuGradientBuild ; 85/9E08

        .al
        .xl
        .autsiz
        .databank ?

        lda wR5
        sta wR13
        lda wR4
        and #$00FF
        sta wR14
        jsl rlUnsignedDivide16By8
        lda wR13
        sta wR3
        jsr rsMapMenuGradientChooseShape
        rts

        .databank 0

        ; 85/9E1F

      rsMapMenuGradientChooseShape ; 85/9E1F

        .al
        .xl
        .autsiz
        .databank ?

        ldy #$0000
        lda wR6
        cmp #$0003
        beq _9E58
        cmp #$0002
        beq _9E41
        cmp #$0001
        beq _9E3A
        jsr rsUnknown859E5F
        jsr rsUnknown859ECB
        rts


        _9E3A
        jsr rsUnknown859E7E
        jsr rsUnknown859ECB
        rts


        _9E41
        lda wR3
        lsr a
        sta wR3
        lda wR4
        sta wR0
        jsr rsUnknown859E7E
        lda wR0
        sta wR4
        jsr rsUnknown859E5F
        jsr rsUnknown859ECB
        rts


        _9E58
        jsr rsUnknown859EA2
        jsr rsUnknown859ECB
        rts

        .databank 0

        ; 85/9E5F

      rsUnknown859E5F ; 85/9E5F

        .al
        .xl
        .autsiz
        .databank ?

        ldy #$0000
        stz wR2
        stz wR1

        _9E66
        jsr rsUnknown859FA3
        jsr rsUnknown859F97
        lda <>aMapMenuGradientSteps,b,y
        sta wDialogueBoxHDMAYPixelPosition,x
        inc x
        inc x
        dec wR4
        beq _9E7D
        inc y
        inc y
        bra _9E66


        _9E7D
        rts

        .databank 0

        ; 85/9E7E

      rsUnknown859E7E ; 85/9E7E

        .al
        .xl
        .autsiz
        .databank ?

        stz wR2
        stz wR1
        lda #$0014
        sec
        sbc wR4
        asl a
        tay

        _9E8A
        jsr rsUnknown859FA3
        jsr rsUnknown859F97
        lda <>aMapMenuGradientSteps+$40,b,y
        sta wDialogueBoxHDMAYPixelPosition,x
        inc x
        inc x
        dec wR4
        beq _9EA1
        inc y
        inc y
        bra _9E8A


        _9EA1
        rts

        .databank 0

        ; 85/9EA2

      rsUnknown859EA2 ; 85/9EA2

        .al
        .xl
        .autsiz
        .databank ?

        stz wR2
        stz wR1
        lda wR4
        lsr a
        sta wR0
        lda #$000A
        sec
        sbc wR0
        asl a
        tay

        _9EB3
        jsr rsUnknown859FA3
        jsr rsUnknown859F97
        lda <>aMapMenuGradientSteps+$68,b,y
        sta wDialogueBoxHDMAYPixelPosition,x
        inc x
        inc x
        dec wR4
        beq _9ECA
        inc y
        inc y
        bra _9EB3


        _9ECA
        rts

        .databank 0

        ; 85/9ECB

      rsUnknown859ECB ; 85/9ECB

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$01
        sta wDialogueBoxHDMAYPixelPosition,x
        rep #$20
        inc x
        lda #<>aMapMenuGradientColors
        sta wDialogueBoxHDMAYPixelPosition,x
        inc x
        inc x
        lda #$0000
        sta wDialogueBoxHDMAYPixelPosition,x
        rts

        .databank 0

        ; 85/9EE7


      aMapMenuGradientSteps ; 85/9EE7

        .word <>aMapMenuGradientColors, <>aMapMenuGradientColors+1, <>aMapMenuGradientColors+2, <>aMapMenuGradientColors+3, <>aMapMenuGradientColors+4, <>aMapMenuGradientColors+5, <>aMapMenuGradientColors+6, <>aMapMenuGradientColors+7
        .word <>aMapMenuGradientColors+8, <>aMapMenuGradientColors+9, <>aMapMenuGradientColors+10, <>aMapMenuGradientColors+11, <>aMapMenuGradientColors+12, <>aMapMenuGradientColors+13, <>aMapMenuGradientColors+14, <>aMapMenuGradientColors+15
        .word <>aMapMenuGradientColors+16, <>aMapMenuGradientColors+17, <>aMapMenuGradientColors+18, <>aMapMenuGradientColors+19, <>aMapMenuGradientColors+20, <>aMapMenuGradientColors+21, <>aMapMenuGradientColors+22, <>aMapMenuGradientColors+23
        .word <>aMapMenuGradientColors+24, <>aMapMenuGradientColors+25, <>aMapMenuGradientColors+26, <>aMapMenuGradientColors+27, <>aMapMenuGradientColors+28, <>aMapMenuGradientColors+29, <>aMapMenuGradientColors+30, <>aMapMenuGradientColors+31
        .word <>aMapMenuGradientColors+19, <>aMapMenuGradientColors+18, <>aMapMenuGradientColors+17, <>aMapMenuGradientColors+16, <>aMapMenuGradientColors+15, <>aMapMenuGradientColors+14, <>aMapMenuGradientColors+13, <>aMapMenuGradientColors+12
        .word <>aMapMenuGradientColors+11, <>aMapMenuGradientColors+10, <>aMapMenuGradientColors+9, <>aMapMenuGradientColors+8, <>aMapMenuGradientColors+7, <>aMapMenuGradientColors+6, <>aMapMenuGradientColors+5, <>aMapMenuGradientColors+4
        .word <>aMapMenuGradientColors+3, <>aMapMenuGradientColors+2, <>aMapMenuGradientColors+1, <>aMapMenuGradientColors, <>aMapMenuGradientColors+19, <>aMapMenuGradientColors+16, <>aMapMenuGradientColors+13, <>aMapMenuGradientColors+10
        .word <>aMapMenuGradientColors+7, <>aMapMenuGradientColors+5, <>aMapMenuGradientColors+3, <>aMapMenuGradientColors+2, <>aMapMenuGradientColors+1, <>aMapMenuGradientColors, <>aMapMenuGradientColors, <>aMapMenuGradientColors+1
        .word <>aMapMenuGradientColors+2, <>aMapMenuGradientColors+3, <>aMapMenuGradientColors+5, <>aMapMenuGradientColors+7, <>aMapMenuGradientColors+10, <>aMapMenuGradientColors+13, <>aMapMenuGradientColors+16, <>aMapMenuGradientColors+19

      aMapMenuGradientColors ; 85/9F77

        .byte $E0, $E1, $E2, $E3, $E4, $E5, $E6, $E7, $E8, $E9, $EA, $EB, $EC, $ED, $EE, $EF
        .byte $F0, $F1, $F2, $F3, $F4, $F5, $F6, $F7, $F8, $F9, $FA, $FB, $FC, $FD, $FE, $FF

    .endsection Unsorted859E08Section


    .section Unsorted859F97Section

      .al
      .xl

      rsUnknown859F97 ; 85/9F97

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda wR3
        sta wDialogueBoxHDMAYPixelPosition,x
        rep #$20
        inc x
        rts

        .databank 0

        ; 85/9FA3

      rsUnknown859FA3 ; 85/9FA3

        .al
        .xl
        .autsiz
        .databank ?

        lda wR1
        beq _9FAB
        dec wR3
        stz wR1

        _9FAB
        lda wR2
        clc
        adc wR10
        sta wR2
        cmp #$000A
        bmi _9FC4
        sec
        sbc #$000A
        sta wR2
        inc wR3
        lda #$FFFF
        sta wR1

        _9FC4
        rts

        .databank 0

        ; 85/9FC5

    .endsection Unsorted859F97Section


    .section Unsorted859FCDSection

      .al
      .xl

      rlStartMapMenuGradient ; 85/9FCD

        .al
        .xl
        .autsiz
        .databank ?

        ; wR42/wR43 as rlMapMenuGradientHDMAInit: replaces HDMA entry 0 with the gradient.

        jsl rlFreeHDMAEntry0
        lda #$0000
        sta wR40
        lda #(`aMapMenuGradientHDMAInfo)<<8
        sta lR44+1
        lda #<>aMapMenuGradientHDMAInfo
        sta lR44
        jsl rlHDMAEngineCreateEntryByIndex
        rtl

        .databank 0

        ; 85/9FE5

      rlFreeHDMAEntryByIndex2 ; 85/9FE5

        .al
        .xl
        .autsiz
        .databank ?

        ; The same as rlFreeHDMAEntryByIndex. Nothing in the build reaches this.

        jsl rlHDMAEngineFreeEntryByIndex
        rtl

        .databank 0

        ; 85/9FEA

    .endsection Unsorted859FCDSection


    .section Unsorted859FEASection

      .al
      .xl

      rlBeginMapMenuOpening ; 85/9FEA

        .al
        .xl
        .autsiz
        .databank ?

        ; A = style: 0 widens from the right edge, 1 and 2 from the left; the window starts 4 tiles wide.

        pha
        lda #$0000
        sta @l $001057,x
        pla
        asl a
        phx
        tax
        jsr (aMapMenuOpeningStyles,x)
        plx
        rtl

        .databank 0

        ; 85/9FFB

    .endsection Unsorted859FEASection


    .section Unsorted859FFBSection

      .al
      .xl

      aMapMenuOpeningStyles ; 85/9FFB

        ; Jump table of rlBeginMapMenuOpening. (tools/sweep.py had started a routine at
        ; $85/A004, three bytes into this table.)
        .word <>rsBeginMapMenuOpeningFromRight
        .word <>rsBeginMapMenuOpeningFromLeft
        .word <>rsBeginMapMenuOpeningStyle2
        .word <>rsBeginMapMenuOpeningNone
        .word <>rsBeginMapMenuOpeningNone
        .word <>rsBeginMapMenuOpeningNone

      rsBeginMapMenuOpeningFromRight ; 85/A007

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlGetMapMenuTilemapArea
        sta wR0
        and #$FF00
        ora #$0004
        jsl rlSetMapMenuTilemapArea
        lda wR0
        and #$00FF
        sec
        sbc #$0004
        sta wR0
        jsl rlGetMapMenuPosition
        clc
        adc wR0
        jsl rlSetMapMenuPosition
        rts

        .databank 0

        ; 85/A02E

    .endsection Unsorted859FFBSection


    .section Unsorted85A02ESection

      .al
      .xl

      rsBeginMapMenuOpeningFromLeft ; 85/A02E

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlGetMapMenuTilemapArea
        and #$FF00
        ora #$0004
        jsl rlSetMapMenuTilemapArea
        rts

        .databank 0

        ; 85/A03D

    .endsection Unsorted85A02ESection


    .section Unsorted85A03DSection

      .al
      .xl

      rsBeginMapMenuOpeningStyle2 ; 85/A03D

        .al
        .xl
        .autsiz
        .databank ?

        bra rsBeginMapMenuOpeningFromLeft

        .databank 0

        ; 85/A03F

      rsBeginMapMenuOpeningUnused ; 85/A03F

        .al
        .xl
        .autsiz
        .databank ?

        ; An rts nothing reaches, between two opening styles.

        rts

        .databank 0

        ; 85/A040

    .endsection Unsorted85A03DSection


    .section Unsorted85A040Section

      .al
      .xl

      rsBeginMapMenuOpeningNone ; 85/A040

        .al
        .xl
        .autsiz
        .databank ?

        rts

        .databank 0

        ; 85/A041

    .endsection Unsorted85A040Section


    .section Unsorted85A041Section

      .al
      .xl

      rlStepMapMenuOpening ; 85/A041

        .al
        .xl
        .autsiz
        .databank ?

        ; A = full width and height, Y = steps and style: widens the window one step (aBody4 counts). Carry set (and A = full size) once done.

        phx
        sta wR7
        tya
        and #$00FF
        sta wR5
        tya
        xba
        and #$00FF
        sta wR6
        lda wR5
        cmp aProcSystem.aBody4,b,x
        bmi _A074
        lda aProcSystem.aBody4,b,x
        sta wR3
        lda wR6
        asl a
        phx
        tax
        jsr (aMapMenuOpeningStepStyles,x)
        plx
        inc aProcSystem.aBody4,b,x
        lda wR4
        pha
        jsl rlSetMapMenuTilemapArea
        pla
        plx
        clc
        rtl


        _A074
        plx
        lda wR7
        sec
        rtl

        .databank 0

        ; 85/A079

    .endsection Unsorted85A041Section


    .section Unsorted85A079Section

      .al
      .xl

      aMapMenuOpeningStepStyles ; 85/A079

        .word <>rsStepMapMenuOpeningFromRight, <>rsGetMapMenuOpeningWidth, <>rsStepMapMenuOpeningFromLeft
        .word <>rsGetMapMenuClosingWidth, <>rsStepMapMenuClosingFromRight, <>rsStepMapMenuOpeningNone

      rsStepMapMenuOpeningFromRight ; 85/A085

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlGetMapMenuTilemapArea
        sta wR0
        jsr rsGetMapMenuOpeningWidth
        lda wR4
        sec
        sbc wR0
        sta wR0
        jsl rlGetMapMenuPosition
        sec
        sbc wR0
        jsl rlSetMapMenuPosition
        rts

        .databank 0

    .endsection Unsorted85A079Section


    .section Unsorted85A0A1Section

      .al
      .xl

      rsGetMapMenuOpeningWidth ; 85/A0A1

        .al
        .xl
        .autsiz
        .databank ?

        lda wR7
        and #$00FF
        sec
        sbc #$0004
        sta wR10
        lda wR3
        sta wR11
        jsl rlUnsignedMultiply16By16
        lda wR12
        sta wR13
        lda wR5
        sta wR14
        jsl rlUnsignedDivide16By8
        lda wR7
        and #$FF00
        ora wR13
        clc
        adc #$0004
        sta wR4
        rts

        .databank 0

        ; 85/A0CE

    .endsection Unsorted85A0A1Section


    .section Unsorted85A0CESection

      .al
      .xl

      rsStepMapMenuOpeningFromLeft ; 85/A0CE

        .al
        .xl
        .autsiz
        .databank ?

        bra rsGetMapMenuOpeningWidth

        .databank 0

        ; 85/A0D0

    .endsection Unsorted85A0CESection


    .section Unsorted85A0D0Section

      .al
      .xl

      rsGetMapMenuClosingWidth ; 85/A0D0

        .al
        .xl
        .autsiz
        .databank ?

        lda wR5
        sec
        sbc wR3
        sta wR3
        bra rsGetMapMenuOpeningWidth

        .databank 0

        ; 85/A0D9

      rsStepMapMenuClosingFromRight ; 85/A0D9

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlGetMapMenuTilemapArea
        sta wR0
        jsr rsGetMapMenuClosingWidth
        lda wR0
        sec
        sbc wR4
        sta wR0
        jsl rlGetMapMenuPosition
        clc
        adc wR0
        jsl rlSetMapMenuPosition
        rts

        .databank 0

        ; 85/A0F5

    .endsection Unsorted85A0D0Section


    .section Unsorted85A0F5Section

      .al
      .xl

      rsStepMapMenuOpeningNone ; 85/A0F5

        .al
        .xl
        .autsiz
        .databank ?

        rts

        .databank 0

      aMapTextBoxTilemapData ; 85/A0F6

        .structMapMenuTilemapData 32, 4, aBG3TilemapBuffer, 0, $7FCE4A

      aMapTextBoxData ; 85/A0FF

        .long 0, 0, aMapTextBoxTilemapData
        .byte 0, 1, 1

      procMapTextBox ; 85/A10B

        .structProcInfo "PW", rlProcMapTextBoxInit, rlProcMapTextBoxDraw, aProcDialogueBoxCode
        .long aMapTextBoxData
        .byte 0

    .endsection Unsorted85A0F5Section


    .section Unsorted85A117Section

      .al
      .xl

      rlProcMapTextBoxInit ; 85/A117

        .al
        .xl
        .autsiz
        .databank ?

        ; lR18, lR19 = two texts (kept at $7FEAAA, $7FEAAE); wInput0 = tile base, wInput1 = flags (bit 15: keep the tiles), wInput2 = size, wInput3 = position.

        phx
        lda lR18
        sta $7FEAAA
        lda lR18+1
        sta $7FEAAB
        lda lR19
        sta $7FEAAE
        lda lR19+1
        sta $7FEAAF
        jsl rlStallProcUntilMapMenuDataLoaded
        lda aProcSystem.wInput1,b
        sta aProcSystem.aBody7,b,x
        lda aProcSystem.wInput3,b
        jsl rlSetMapMenuPosition
        lda aProcSystem.wInput2,b
        jsl rlSetMapMenuTilemapArea
        jsl rlHideMapMenu
        plx
        phx
        lda aProcSystem.wInput0,b
        sta aProcSystem.aBody6,b,x
        lda aProcSystem.aBody7,b,x
        bit #$8000
        bne _A166
        lda #$20FF
        sta wMapMenuClearTile,b
        jsl rlClearMapMenuTiles

        _A166
        plx
        rtl

        .databank 0

        ; 85/A168

      rlProcMapTextBoxDraw ; 85/A168

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws the two texts on one line, shows the window, and goes on to rlProcMapTextBoxCycle.

        phx
        jsl rlLoadMapMenuEntryPointerFromProcBody
        lda aProcSystem.aBody6,b,x
        sta aCurrentTilemapInfo,b
        lda aProcSystem.aBody7,b,x
        bit #$8000
        bne _A19A
        lda $7FEAAA
        sta lR18
        lda $7FEAAB
        sta lR18+1
        lda $7FEAAE
        sta lR19
        lda $7FEAAF
        sta lR19+1
        ldx #$0101
        jsl rlDrawTwoMapMenuTextLines

        _A19A
        jsl rlShowMapMenu
        jsl rlShowMapMenuLayers
        plx
        lda #<>rlProcMapTextBoxCycle
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 85/A1AA

    .endsection Unsorted85A117Section


    .section Unsorted85A1AASection

      .al
      .xl

      rlProcMapTextBoxCycle ; 85/A1AA

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Bit 1 of the proc's bitfield: close; bit 2: clear and draw the texts again.

        lda aProcSystem.aHeaderBitfield,b,x
        bit #$0002
        bne _A1B8
        bit #$0004
        bne _A1C5
        rtl


        _A1B8
        jsl rlCloseMapMenuFromProc
        jsl rlProcEngineFreeProc
        jsl rlFreeHDMAEntry0
        rtl


        _A1C5
        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFB
        sta aProcSystem.aHeaderBitfield,b,x
        lda #<>rlProcMapTextBoxDraw
        sta aProcSystem.aHeaderOnCycle,b,x
        jsl rlLoadMapMenuEntryPointerFromProcBody
        lda #$20FF
        sta wMapMenuClearTile,b
        jsl rlClearMapMenuTiles
        jsl rlDrawMapMenuBG3
        rtl

        .databank 0

        ; 85/A1E7

    .endsection Unsorted85A1AASection


    .section Unsorted85A1E7Section

      .al
      .xl

      rlDrawTwoMapMenuTextLines ; 85/A1E7

        .al
        .autsiz
        .databank ?

        ; X = row and column: draws lR18, then lR19 right after it.

        phx
        jsl rlDrawMapMenuTextLine
        jsl rlGetMenuTextStringLength
        plx
        phx
        txa
        clc
        adc wR10
        tax
        lda lR19
        sta lR18
        lda lR19+1
        sta lR18+1
        jsl rlDrawMapMenuTextLine
        plx
        rtl

        .databank 0

    .endsection Unsorted85A1E7Section


    .section Unsorted85A227Section

      .al
      .xl

      rlHideMapMenuLayers ; 85/A227

        .al
        .xl
        .autsiz
        .databank ?

        ; Turns BG2 and BG3 off on the main screen.

        pha
        sep #$20
        lda bBufferTM
        and #$F9
        sta bBufferTM
        rep #$20
        pla
        rtl

        .databank 0

        ; 85/A234

      rlShowMapMenuLayers ; 85/A234

        .al
        .xl
        .autsiz
        .databank ?

        ; Turns BG2 and BG3 on on the main screen.

        pha
        sep #$20
        lda bBufferTM
        ora #$06
        sta bBufferTM
        rep #$20
        pla
        rtl

        .databank 0

        ; 85/A241


      rlOpenMapTextBoxWithGradient ; 85/A241

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        and #$FF00
        asl a
        asl a
        asl a
        sta wR0
        txa
        and #$FF00
        asl a
        asl a
        asl a
        xba
        ora wR0
        sta wR43
        lda #$000F
        sta wR42
        jsl rlStartMapMenuGradient
        plx
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda #(`aUnknown85A284)<<8
        sta lR18+1
        lda #<>aUnknown85A284
        sta lR18
        lda #(`aUnknown85A284)<<8
        sta lR19+1
        lda #<>aUnknown85A284
        sta lR19
        ldy #$8000
        pla
        jsl rlCreateMapTextBox
        rtl

        .databank 0

      aUnknown85A284 ; 85/A284

        .enc "SJIS"
        .text "　\n"
        .enc "none"

      rlOpenMapTextBox ; 85/A288

        .al
        .xl
        .autsiz
        .databank ?

        pha
        lda #$2000
        sta aCurrentTilemapInfo,b
        pla
        jsl rlCreateMapTextBox
        rtl

        .databank 0

      rlCreateMapTextBox ; 85/A295

        .al
        .xl
        .autsiz
        .databank ?

        sta aProcSystem.wInput3,b
        stx aProcSystem.wInput2,b
        sty aProcSystem.wInput1,b
        lda aCurrentTilemapInfo,b
        sta aProcSystem.wInput0,b
        lda #(`procMapTextBox)<<8
        sta lR44+1
        lda #<>procMapTextBox
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

      rlCloseMapTextBox ; 85/A2B3

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`procMapTextBox)<<8
        sta lR44+1
        lda #<>procMapTextBox
        sta lR44
        jsl rlProcEngineFindProc
        bcc _A2CC
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0002
        sta aProcSystem.aHeaderBitfield,b,x

        _A2CC
        rtl

        .databank 0

      rlChangeMapTextBox ; 85/A2CD

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`procMapTextBox)<<8
        sta lR44+1
        lda #<>procMapTextBox
        sta lR44
        jsl rlProcEngineFindProc
        bcc _A2FE
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0004
        sta aProcSystem.aHeaderBitfield,b,x
        lda lR18
        sta $7FEAAA
        lda lR18+1
        sta $7FEAAB
        lda lR19
        sta $7FEAAE
        lda lR19+1
        sta $7FEAAF

        _A2FE
        rtl

        .databank 0

      aItemDescriptionBoxTilemapData ; 85/A2FF

        .structMapMenuTilemapData 10, 11, aBG3TilemapBuffer, 0, $7FCD4A

      aItemDescriptionBoxData ; 85/A308

        .long 0, 0, aItemDescriptionBoxTilemapData
        .byte 0, 1, 1

    .endsection Unsorted85A227Section


    .section Unsorted85A314Section

      .al
      .xl

      procItemDescriptionBox ; 85/A314

        .structProcInfo "PW", rlProcItemDescriptionBoxInit, rlProcItemDescriptionBoxCycle, aProcDialogueBoxCode


        .long aItemDescriptionBoxData
        .byte 0

    .endsection Unsorted85A314Section


    .section Unsorted85A320Section

      .al
      .xl

      rlProcItemDescriptionBoxInit ; 85/A320

        .al
        .xl
        .autsiz
        .databank ?

        ; lR18 = the description, wInput3 = position.

        phx
        lda lR18
        sta aProcSystem.aBody5,b,x
        lda lR18+1
        sta aProcSystem.aBody6,b,x
        jsl rlStallProcUntilMapMenuDataLoaded
        lda aProcSystem.wInput3,b
        jsl rlSetMapMenuPosition
        plx
        phx
        lda #$4000
        sta aProcSystem.aBody7,b,x
        lda #$0000
        sta wBufferBG3VOFS
        sta wBufferBG3HOFS
        plx
        rtl

        .databank 0

        ; 85/A347

      rlProcItemDescriptionBoxCycle ; 85/A347

        .al
        .xl
        .autsiz
        .databank ?

        ; aBody7 bit 15: close; bit 14: draw the description in aBody5/aBody6.

        phx
        jsl rlLoadMapMenuEntryPointerFromProcBody
        lda aProcSystem.aBody7,b,x
        bit #$8000
        bne _A35B
        bit #$4000
        bne _A365

        _A359
        plx
        rtl


        _A35B
        jsl rlCloseMapMenuFromProc
        jsl rlProcEngineFreeProc
        bra _A359


        _A365
        eor #$4000
        sta aProcSystem.aBody7,b,x
        phx
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda #$20FF
        sta wMapMenuClearTile,b
        jsl rlClearMapMenuTiles
        plx
        lda aProcSystem.aBody5,b,x
        sta lR18
        lda aProcSystem.aBody6,b,x
        sta lR18+1
        ldx #$0101
        jsl rlDrawItemDescription
        jsl rlDrawMapMenu
        bra _A359

        .databank 0

        ; 85/A394

      rlOpenItemDescriptionBox ; 85/A394

        .al
        .xl
        .autsiz
        .databank ?

        ; A = position, lR18 = the description.

        sta aProcSystem.wInput3,b
        lda #(`procItemDescriptionBox)<<8
        sta lR44+1
        lda #<>procItemDescriptionBox
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 85/A3A6

    .endsection Unsorted85A320Section


    .section Unsorted85A3A6Section

      .al
      .xl

      rlCloseItemDescriptionBox ; 85/A3A6

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #(`procItemDescriptionBox)<<8
        sta lR44+1
        lda #<>procItemDescriptionBox
        sta lR44
        jsl rlProcEngineFindProc
        bcc _A3D3
        lda lMapMenuRAMEntryPointer,b
        pha
        lda lMapMenuRAMEntryPointer+1,b
        pha
        jsl rlLoadMapMenuEntryPointerFromProcBody
        jsl rlCloseMapMenuFromProc
        jsl rlProcEngineFreeProc
        pla
        sta lMapMenuRAMEntryPointer+1,b
        pla
        sta lMapMenuRAMEntryPointer,b

        _A3D3
        plx
        rtl

        .databank 0

        ; 85/A3D5

    .endsection Unsorted85A3A6Section


    .section Unsorted85A3D5Section

      .al
      .xl

      rlChangeItemDescriptionBox ; 85/A3D5

        .al
        .xl
        .autsiz
        .databank ?

        ; lR18 = the new description.

        phx
        lda #(`procItemDescriptionBox)<<8
        sta lR44+1
        lda #<>procItemDescriptionBox
        sta lR44
        jsl rlProcEngineFindProc
        bcc _A3F6
        lda #$4000
        sta aProcSystem.aBody7,b,x
        lda lR18
        sta aProcSystem.aBody5,b,x
        lda lR18+1
        sta aProcSystem.aBody6,b,x

        _A3F6
        plx
        rtl

        .databank 0

        ; 85/A3F8

      rlDrawItemDescription ; 85/A3F8

        .al
        .xl
        .autsiz
        .databank ?

        ; X = row and column: draws the text 8 characters to a line, two rows apart, through a buffer at $7E8BF6.

        stx wR7
        stz wR6
        phb
        php
        phk
        plb
        .databank $85
        phx
        ldx lR18
        sep #$20
        lda lR18+2
        pha
        rep #$20
        plb
        .databank ?

        _A40B
        ldy #$0000

        _A40E
        lda $0000,b,x
        sta wR5
        phb
        sep #$20
        lda #$7E
        pha
        plb
        .databank $7E
        rep #$20
        lda wR5
        sta $8BF6,b,y
        plb
        .databank $7E
        cmp #$0000
        bne _A42C
        lda #$FFFF
        sta wR6

        _A42C
        inc x
        inc x
        inc y
        inc y
        cpy #$0010
        bmi _A40E
        phx
        phb
        sep #$20
        lda #$7E
        pha
        plb
        .databank $7E
        rep #$20
        lda #$0000
        sta $8BF6,b,y
        plb
        .databank $7E
        lda #$7E00
        sta lR18+1
        lda #$8BF6
        sta lR18
        ldx wR7
        jsl rlDrawMapMenuTextLine
        lda wR7
        clc
        adc #$0200
        sta wR7
        plx
        lda wR6
        cmp #$0000
        beq _A40B
        plx
        plp
        plb
        .databank $7E
        rtl

        .databank 0

        ; 85/A46A

    .endsection Unsorted85A3D5Section


    .section Unsorted85B7D1Section

      .al
      .xl

      rlGetCenteredTextBoxPlacement ; 85/B7D1

        .al
        .xl
        .autsiz
        .databank ?

        ; A = row, X = height, lR18 and lR19 = two texts: A = position and X = size of a box that holds both on one line, centred.

        and #$FF00
        sta wR7
        txa
        and #$FF00
        sta wR6
        lda lR18
        pha
        lda lR18+1
        pha
        jsl rlGetMenuTextStringLength
        lda wR10
        pha
        lda lR19
        sta lR18
        lda lR19+1
        sta lR18+1
        jsl rlGetMenuTextStringLength
        pla
        clc
        adc #$0002
        clc
        adc wR10
        pha
        and #$00FF
        tsb wR6
        pla
        sta wR0
        lda #$0020
        sec
        sbc wR0
        lsr a
        and #$00FF
        tsb wR7
        pla
        sta lR18+1
        pla
        sta lR18
        lda wR7
        ldx wR6
        rtl

        .databank 0

        ; 85/B81D

    .endsection Unsorted85B7D1Section


    .section Unsorted85BC9ESection

      .al
      .xl

      rlInitMapMenuProc ; 85/BC9E

        .al
        .autsiz
        .databank ?

        ; Waits for the proc's map menu to load (rlStallProcUntilMapMenuDataLoaded), clears its tiles to $20FF and zeroes BG3's scroll.

        jsl rlStallProcUntilMapMenuDataLoaded
        lda #0
        sta wBufferBG3VOFS
        sta wBufferBG3HOFS
        lda #$20FF
        sta wMapMenuClearTile,b
        jsl rlClearMapMenuTiles
        jsl rlShowMapMenuLayers
        rtl

        .databank 0

        ; 85/BCB8

    .endsection Unsorted85BC9ESection


    .section Unsorted85D9FCSection

      .al
      .xl

      rlDrawMapMenuGauge ; 85/D9FC

        .al
        .xl
        .autsiz
        .databank ?

        ; A = value, Y = maximum, X = row and column: a bar of 60 steps (6 tiles) with end caps.

        phx
        sta wR10
        lda #$003C
        sta wR11
        jsl rlUnsignedMultiply16By16
        stz wR15
        sty wR14
        jsl rlUnsignedDivide32By32
        lda wR12
        sta wR0
        stx wR1
        lda #$0005
        sta wR2
        jsr rsDrawGaugeStart

        _DA1E
        jsr rsDrawGaugeTile
        dec wR2
        bpl _DA1E
        jsr rsDrawGaugeEnd
        plx
        rtl

        .databank 0

        ; 85/DA2A

      rlDrawMapMenuLongGauge ; 85/DA2A

        .al
        .xl
        .autsiz
        .databank ?

        ; A = value in steps, X = row and column: a bar 11 tiles long.

        phx
        sta wR0
        stx wR1
        lda #$000A
        sta wR2
        jsr rsDrawGaugeStart

        _DA37
        jsr rsDrawGaugeTile
        dec wR2
        bpl _DA37
        jsr rsDrawGaugeEnd
        plx
        rtl

        .databank 0

        ; 85/DA43

      rsDrawGaugeStart ; 85/DA43

        .al
        .xl
        .autsiz
        .databank ?

        lda wR0
        cmp #$0006
        bpl _DA5C
        tax
        lda aUnknown85DA77,x
        and #$00FF
        ldx wR1
        jsl rlUnknown85D81F
        stz wR0
        bra _DA74


        _DA5C
        ldx #$0006
        lda aUnknown85DA77,x
        and #$00FF
        ldx wR1
        jsl rlUnknown85D81F
        lda wR0
        sec
        sbc #$0006
        sta wR0

        _DA74
        inc wR1
        rts

        .databank 0

        ; 85/DA77

    .endsection Unsorted85D9FCSection


    .section Table85DA77Section

      .al
      .xl

      aUnknown85DA77 ; 85/DA77

        ; Read by rsDrawGaugeStart.

        .byte $00, $01, $02, $03, $04, $05, $06

        ; 85/DA7E

    .endsection Table85DA77Section


    .section Unsorted85DA7ESection

      .al
      .xl

      rsDrawGaugeTile ; 85/DA7E

        .al
        .xl
        .autsiz
        .databank ?

        lda wR0
        cmp #$0008
        bpl _DA97
        tax
        lda aUnknown85DAB2,x
        and #$00FF
        ldx wR1
        jsl rlUnknown85D81F
        stz wR0
        bra _DAAF


        _DA97
        ldx #$0008
        lda aUnknown85DAB2,x
        and #$00FF
        ldx wR1
        jsl rlUnknown85D81F
        lda wR0
        sec
        sbc #$0008
        sta wR0

        _DAAF
        inc wR1
        rts

        .databank 0

        ; 85/DAB2

    .endsection Unsorted85DA7ESection


    .section Table85DAB2Section

      .al
      .xl

      aUnknown85DAB2 ; 85/DAB2

        ; Read by rsDrawGaugeTile.

        .byte $07, $08, $09, $0A, $0B, $0C, $0D, $0E, $0F

        ; 85/DABB

    .endsection Table85DAB2Section


    .section Unsorted85DABBSection

      .al
      .xl

      rsDrawGaugeEnd ; 85/DABB

        .al
        .xl
        .autsiz
        .databank ?

        ldx wR0
        lda aGaugeEndTiles,x
        and #$00FF
        ldx wR1
        jsl rlUnknown85D81F
        rts

        .databank 0

        ; 85/DACB

    .endsection Unsorted85DABBSection


    .section Table85DACBSection

      .al
      .xl

      aGaugeEndTiles ; 85/DACB

        ; Read by rsDrawGaugeEnd.

        .byte $18, $19, $1A, $1B, $1C, $1D, $1E

      rlCheckMapBattleHPWindowRightIdle ; 85/DAD2

        .al
        .xl
        .autsiz
        .databank ?

        ; Carry set if wMapBattleHPWindowRightRequest is $FFFF.
        ; Nothing in the build reaches this.

        lda wMapBattleHPWindowRightRequest,b
        cmp #$FFFF
        beq +

          clc
          rtl

        +
        sec
        rtl

        .databank 0

      aMapBattleTextBoxData ; 85/DADE

        ; A structMapMenu without its last field: frame type 5 at (1, 1), the text
        ; box's tilemap data.
        .long 0, 0, aMapTextBoxTilemapData
        .byte 5, 1, 1

        ; 85/DAEA

    .endsection Table85DACBSection


    .section Unsorted85EA64Section

      .al
      .xl

      rlMapMenuEmptyHook ; 85/EA64

        .al
        .xl
        .autsiz
        .databank ?

        ; Does nothing (rtl); bank $88 calls it at three places.

        rtl

        .databank 0

        ; 85/EA65

    .endsection Unsorted85EA64Section


    .section Unsorted8780AASection

      .al
      .xl

      rlInitMapMenus ; 87/80AA

        .al
        .autsiz
        .databank ?

        ; Clears the map menu variables ($0516-$053F), and points them at aBG3TilemapBuffer and BG3's VRAM tilemap.

        phb
        php
        phk
        plb
        ldx #$0029
        sep #$20
        lda #0

          -
          sta wMapMenuVRAMTilemap,b,x
          dec x
          bpl -

        rep #$20

        lda bBufferBG3SC
        and #BGSC_Address
        xba
        sta wMapMenuVRAMTilemap,b
        lda #(`aBG3TilemapBuffer)<<8
        sta lMapMenuBGBuffer+1,b
        lda #<>aBG3TilemapBuffer
        sta lMapMenuBGBuffer,b
        lda #0
        sta wMapMenuTransparentTile,b
        jsl rlResetMapMenuDirtyRows
        plp
        plb
        rtl

        .databank 0

    .endsection Unsorted8780AASection


    .section Unsorted8780DFSection

      .al
      .xl

      rlEnableMapMenuUploads ; 87/80DF

        .al
        .autsiz
        .databank ?

        ; Sets bit 7 of bMapMenuFlags.

        phb
        php
        phk
        plb
        lda #$0080
        tsb bMapMenuFlags,b
        plp
        plb
        rtl

        .databank 0

      rlDisableMapMenuUploads ; 87/80EC

        .al
        .autsiz
        .databank ?

        ; Clears bit 7 of bMapMenuFlags.

        phb
        php
        phk
        plb
        lda #$0080
        trb bMapMenuFlags,b
        plp
        plb
        rtl

        .databank 0

        ; 87/80F9

    .endsection Unsorted8780DFSection


    .section Unsorted878148Section

      .al
      .xl

      rlUnlinkMapMenu ; 87/8148

        .al
        .xl
        .autsiz
        .databank ?

        ; Takes the current map menu out of the list of open menus.

        phb
        php
        phk
        plb
        .databank $87
        phy
        ldy lMapMenuRAMEntryPointer,b
        sep #$20
        lda lMapMenuRAMEntryPointer+2,b
        pha
        rep #$20
        plb
        .databank ?
        lda structMapMenu.Next,b,y
        sta lR20
        lda structMapMenu.Next+1,b,y
        sta lR20+1
        jsl rlFindPreviousMapMenu
        bcs _817F
        ldy lR19
        sep #$20
        lda lR19+2
        pha
        rep #$20
        plb
        .databank ?
        lda lR20
        sta $000C,b,y
        lda lR20+1
        sta $000D,b,y
        bra _818B


        _817F
        lda lR20
        sta @l lMapMenuListHead
        lda lR20+1
        sta @l lMapMenuListHead+1

        _818B
        lda @l bMapMenuFlags
        ora #$0008
        sta @l bMapMenuFlags
        ply
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 87/819A

    .endsection Unsorted878148Section


    .section Unsorted878256Section

      .al
      .xl

      rlMapMenuVBlankUpload ; 87/8256

        .al
        .xl
        .autsiz
        .databank ?

        ; Called by the VBlank routines: while map menus are on (bit 7 of bMapMenuFlags) and not held (bit 5), uploads the dirty rows if bits 1-4 say something changed.

        phb
        php
        phk
        plb
        .databank $87
        lda bMapMenuFlags,b
        and #$00FF
        bit #$0080
        beq _827A
        bit #$0020
        bne _827A
        pha
        sep #$20
        and #$E1
        sta bMapMenuFlags,b
        rep #$20
        pla
        bit #$001E
        bne _8283

        _827A
        plp
        plb
        .databank ?
        rtl

        .byte $22, $F8, $83, $87, $80, $00


        _8283
        jsr rsUploadMapMenuDirtyRows
        jsl rlResetMapMenuDirtyRows
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 87/828D

      rlResetMapMenuDirtyRows ; 87/828D

        .al
        .xl
        .autsiz
        .databank ?

        ; Sets the rows to upload to none (top 32, bottom 0).

        lda #$0020
        sta wMapMenuDirtyTop,b
        lda #$0000
        sta wMapMenuDirtyBottom,b
        rtl

        .databank 0

        ; 87/829A

    .endsection Unsorted878256Section


    .section Unsorted87829ASection

      .al
      .xl

      rlGetMapMenuRows ; 87/829A

        .al
        .autsiz
        .databank ?

        ; wR12 = the current map menu's top row, wR13 = its bottom row; widens the rows to upload (wMapMenuDirtyTop/wMapMenuDirtyBottom) to include them.

        phb
        php
        phk
        plb

        ; Get the height into wR13
        jsl rlGetMapMenuTilemapArea
        xba
        and #$00FF
        sta wR13

        jsl rlGetMapMenuPosition
        xba
        and #$00FF
        cmp #33
        bge +

          cmp wMapMenuDirtyTop,b
          bge +

            sta wMapMenuDirtyTop,b

        +
        sta wR12
        clc
        adc wR13
        cmp #33
        bge +

          cmp wMapMenuDirtyBottom,b
          blt +

            sta wMapMenuDirtyBottom,b

        +
        sta wR13
        plp
        plb
        rtl

        .databank 0

        ; 87/82D4

    .endsection Unsorted87829ASection


    .section Unsorted8782D4Section

      .al
      .xl

      rlGetAllMapMenuRows ; 87/82D4

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Sets the rows to upload to those that any open map menu covers.

        phb
        php
        phk
        plb
        .databank $87
        phy
        lda #$0020
        sta wMapMenuDirtyTop,b
        lda #$0000
        sta wMapMenuDirtyBottom,b
        lda lMapMenuListHead,b
        sta lMapMenuRAMEntryPointer,b
        lda lMapMenuListHead+1,b
        sta lMapMenuRAMEntryPointer+1,b

        _82F1
        phk
        plb
        .databank $87
        jsl rlGetMapMenuYPositions
        lda @l wR10
        cmp wMapMenuDirtyTop,b
        bcs _8303
        sta wMapMenuDirtyTop,b

        _8303
        lda @l wR11
        cmp wMapMenuDirtyBottom,b
        bcc _830F
        sta wMapMenuDirtyBottom,b

        _830F
        ldy lMapMenuRAMEntryPointer,b
        sep #$20
        lda lMapMenuRAMEntryPointer+2,b
        pha
        rep #$20
        plb
        .databank ?
        lda structMapMenu.Next,b,y
        ora structMapMenu.Next+1,b,y
        beq _8333
        lda structMapMenu.Next,b,y
        sta @l lMapMenuRAMEntryPointer
        lda structMapMenu.Next+1,b,y
        sta @l lMapMenuRAMEntryPointer+1
        bra _82F1


        _8333
        ply
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 87/8337

    .endsection Unsorted8782D4Section


    .section Unsorted878337Section

      .al
      .xl

      rlClearMapMenuRows ; 87/8337

        .al
        .xl
        .autsiz
        .databank ?

        ; Fills rows wR12-wR13 of the BG3 buffer (lMapMenuBGBuffer) with the transparent tile wMapMenuTransparentTile.

        phb
        php
        phk
        plb
        .databank $87
        phx
        phy
        lda wR13
        sec
        sbc wR12
        bcc _8395
        asl a
        tay
        lda wR12
        xba
        lsr a
        lsr a
        clc
        adc lMapMenuBGBuffer,b
        tax
        sep #$20
        lda lMapMenuBGBuffer+2,b
        pha
        rep #$20
        plb
        .databank ?

        _8359
        lda wMapMenuTransparentTile,b
        sta $0000,b,x
        sta $0002,b,x
        sta $0004,b,x
        sta $0006,b,x
        sta $0008,b,x
        sta $000A,b,x
        sta $000C,b,x
        sta $000E,b,x
        sta $0010,b,x
        sta $0012,b,x
        sta $0014,b,x
        sta $0016,b,x
        sta $0018,b,x
        sta $001A,b,x
        sta $001C,b,x
        sta $001E,b,x
        txa
        clc
        adc #$0020
        tax
        dec y
        bne _8359

        _8395
        ply
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 87/839A

      rlRedrawMapMenuRows ; 87/839A

        .al
        .xl
        .autsiz
        .databank ?

        ; Clears rows wR12-wR13 of BG3 and copies the tiles of every open map menu that overlaps them, back to front.

        phb
        php
        phk
        plb
        .databank $87
        phx
        phy
        lda lMapMenuListHead,b
        ora lMapMenuListHead+1,b
        beq _83F3
        lda wR12
        cmp #$0020
        bcs _83F3
        lda wR13
        cmp #$0020
        bcs _83F3
        jsl rlClearMapMenuRows
        lda lMapMenuRAMEntryPointer,b
        pha
        lda lMapMenuRAMEntryPointer+1,b
        pha
        phb
        lda lMapMenuListHead,b
        sta lMapMenuRAMEntryPointer,b
        lda lMapMenuListHead+1,b
        sta lMapMenuRAMEntryPointer+1,b

        _83CF
        jsr rsDrawMapMenuIfInRows
        lda $000C,b,y
        ora $000D,b,y
        beq _83EA
        lda $000C,b,y
        sta @l lMapMenuRAMEntryPointer
        lda $000D,b,y
        sta @l lMapMenuRAMEntryPointer+1
        bra _83CF


        _83EA
        plb
        .databank ?
        pla
        sta lMapMenuRAMEntryPointer+1,b
        pla
        sta lMapMenuRAMEntryPointer,b

        _83F3
        ply
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 87/83F8

    .endsection Unsorted878337Section


    .section Unsorted8783F8Section

      .al
      .xl

      rlRedrawAllMapMenus ; 87/83F8

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ; Redraws every open map menu on BG3. Nothing in the build reaches this.

        phb
        php
        phk
        plb
        .databank $87
        lda lMapMenuListHead,b
        ora lMapMenuListHead+1,b
        beq _840C
        jsl rlGetAllMapMenuRows
        jsl rlRedrawMapMenuRows

        _840C
        plp
        plb
        .databank $87
        rtl

        .databank 0

        ; 87/840F

    .endsection Unsorted8783F8Section


    .section Unsorted87840FSection

      .al
      .xl

      rsUploadMapMenuDirtyRows ; 87/840F

        .al
        .xl
        .autsiz
        .databank ?

        ; DMAs the rows wMapMenuDirtyTop-wMapMenuDirtyBottom of the BG3 buffer to VRAM.

        phb
        php
        phk
        plb
        .databank $87
        lda wMapMenuDirtyTop,b
        cmp wMapMenuDirtyBottom,b
        bcs _8456
        lda wMapMenuDirtyTop,b
        cmp #$0020
        bcs _8456
        lda wMapMenuDirtyBottom,b
        cmp #$0020
        bcs _8456
        lda lMapMenuBGBuffer+1,b
        sta lR18+1
        lda wMapMenuDirtyTop,b
        xba
        lsr a
        lsr a
        pha
        clc
        adc lMapMenuBGBuffer,b
        sta lR18
        lda wMapMenuDirtyBottom,b
        sec
        sbc wMapMenuDirtyTop,b
        inc a
        xba
        lsr a
        lsr a
        sta wR0
        pla
        lsr a
        clc
        adc wMapMenuVRAMTilemap,b
        sta wR1
        jsl rlDMAByPointer

        _8456
        plp
        plb
        .databank ?
        rts

        .databank 0

        ; 87/8459

    .endsection Unsorted87840FSection


    .section Unsorted878459Section

      .al
      .xl

      rlMarkAllMapMenuRowsDirty ; 87/8459

        .al
        .autsiz
        .databank ?

        ; Marks rows 0-31 for upload (bit 1 of bMapMenuFlags).

        phb
        php
        phk
        plb
        lda #0
        sta wMapMenuDirtyTop,b
        lda #$001F
        sta wMapMenuDirtyBottom,b
        lda #$0002
        tsb bMapMenuFlags,b
        plp
        plb
        rtl

        .databank 0

        ; 87/8472

    .endsection Unsorted878459Section


    .section Unsorted878472Section

      .al
      .xl

      rlMoveMapMenuBG3 ; 87/8472

        .al
        .xl
        .autsiz
        .databank ?

        ; The BG3 half of rlMoveMapMenu: writes wMapMenuNewPosition into the menu, redraws the rows it covered and draws it at its new place.

        phb
        php
        phk
        plb
        .databank $87
        phy
        jsl rlGetMapMenuRows
        ldy lMapMenuRAMEntryPointer,b
        sep #$20
        lda lMapMenuRAMEntryPointer+2,b
        pha
        rep #$20
        plb
        .databank ?
        lda @l $000534
        sta $000A,b,y
        phk
        plb
        .databank $87
        jsl rlRedrawMapMenuRows
        jsl rlGetMapMenuYPositions
        lda wR10
        cmp wR12
        bcc _84A4
        lda wR13
        cmp wR11
        bcs _84A8

        _84A4
        jsl rlDrawMapMenuBG3

        _84A8
        lda @l bMapMenuFlags
        ora #$0004
        sta @l bMapMenuFlags
        ply
        plp
        plb
        .databank $87
        rtl

        .databank 0

        ; 87/84B7

      rlHideMapMenuBG3 ; 87/84B7

        .al
        .xl
        .autsiz
        .databank ?

        ; Hides the current map menu on BG3 (bit 15 of its position) and redraws the rows it covered.

        phb
        php
        phk
        plb
        .databank $87
        jsl rlGetMapMenuPosition
        ora #$8000
        sta wMapMenuNewPosition,b
        jsl rlMoveMapMenuBG3
        plp
        plb
        .databank $87
        rtl

        .databank 0

        ; 87/84CC

      rlShowMapMenuBG3 ; 87/84CC

        .al
        .xl
        .autsiz
        .databank ?

        ; Clears bit 15 of the current map menu's position and redraws BG3.
        ; Nothing in the build reaches this.

        phb
        php
        phk
        plb

        .databank $87

        jsl rlGetMapMenuPosition
        and #$7FFF
        sta wMapMenuNewPosition,b
        jsl rlMoveMapMenuBG3
        plp
        plb
        rtl

        .databank 0

        ; 87/84E1

    .endsection Unsorted878472Section


    .section Unsorted8784E1Section

      .al
      .xl

      rlResizeMapMenuBG3 ; 87/84E1

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; A = new width and height of the current map menu; redraws BG3.

        phb
        php
        phk
        plb
        .databank $87
        phy
        pha
        jsl rlGetMapMenuRows
        pla
        jsl rlSetMapMenuTilemapArea
        jsl rlRedrawMapMenuRows
        jsl rlGetMapMenuYPositions
        lda wR10
        cmp wR12
        bcc _8504
        lda wR13
        cmp wR11
        bcs _8508

        _8504
        jsl rlDrawMapMenuBG3

        _8508
        lda @l bMapMenuFlags
        ora #$0004
        sta @l bMapMenuFlags
        ply
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 87/8517

    .endsection Unsorted8784E1Section


    .section Unsorted878531Section

      .al
      .xl

      rlBringMapMenuToFront ; 87/8531

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Moves the current map menu to the end of the list (drawn last, in front) and redraws it.

        phb
        php
        phk
        plb
        .databank $87
        phx
        phy
        lda #$0027
        jsl rlFindLastMapMenu
        ldx lR19
        cpx lMapMenuRAMEntryPointer,b
        beq _859F
        ldy lMapMenuRAMEntryPointer,b
        sep #$20
        lda lMapMenuRAMEntryPointer+2,b
        pha
        rep #$20
        plb
        .databank ?
        lda @l lMapMenuRAMEntryPointer
        sta $000C,b,x
        lda @l lMapMenuRAMEntryPointer+1
        sta $000D,b,x
        jsl rlFindPreviousMapMenu
        bcs _8575
        ldx lR19
        lda $000C,b,y
        sta $000C,b,x
        lda $000D,b,y
        sta $000D,b,x
        bra _8583


        _8575
        lda $000C,b,y
        sta @l lMapMenuListHead
        lda $000D,b,y
        sta @l lMapMenuListHead+1

        _8583
        lda #$0000
        sta $000C,b,y
        sta $000D,b,y
        jsl rlGetMapMenuRows
        jsl rlRedrawMapMenuRows
        lda @l bMapMenuFlags
        ora #$0008
        sta @l bMapMenuFlags

        _859F
        ply
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 87/85A4

    .endsection Unsorted878531Section


    .section Unsorted8785A4Section

      .al
      .xl

      rlRemoveMapMenu ; 87/85A4

        .al
        .xl
        .autsiz
        .databank ?

        ; Frees the current map menu's tilemap entry and its RAM area entry, after
        ; rlHideMapMenuBG3 and rlUnlinkMapMenu.

        phb
        php
        phk
        plb
        .databank $87
        phy
        jsl rlHideMapMenuBG3
        jsl rlUnlinkMapMenu
        ldy lMapMenuRAMEntryPointer,b
        sep #$20
        lda lMapMenuRAMEntryPointer+2,b
        pha
        rep #$20
        plb
        .databank ?
        lda structMapMenu.TilemapDataPointer,b,y
        sta @l lMapMenuTilemapRAMEntryPointer
        lda structMapMenu.TilemapDataPointer+1,b,y
        sta @l lMapMenuTilemapRAMEntryPointer+1
        jsl rlRemoveMapMenuTilemapRAMEntry
        phk
        plb
        .databank $87
        lda lMapMenuRAMEntryPointer,b
        sta lR25
        lda lMapMenuRAMEntryPointer+1,b
        sta lR25+1
        jsl rlRemoveRAMAreaEntry
        ply
        plp
        plb
        .databank $87
        rtl

        .databank 0

        ; 87/85E3

      rlDrawMapMenuBG3 ; 87/85E3

        .al
        .xl
        .autsiz
        .databank ?

        ; Copies the current map menu's tiles to BG3, and the menus after it in the list (in front of it) when bit 6 of bMapMenuFlags is set.

        phb
        php
        phk
        plb
        .databank $87
        phx
        phy
        jsl rlGetMapMenuRows
        jsr rsDrawMapMenuIfInRows
        lda @l bMapMenuFlags
        bit #$0040
        beq _8628
        lda lMapMenuRAMEntryPointer,b
        pha
        lda lMapMenuRAMEntryPointer+1,b
        pha
        phb
        bra _8607


        _8604
        jsr rsDrawMapMenuIfInRows

        _8607
        lda $000C,b,y
        ora $000D,b,y
        beq _861F
        lda $000C,b,y
        sta @l lMapMenuRAMEntryPointer
        lda $000D,b,y
        sta @l lMapMenuRAMEntryPointer+1
        bra _8604


        _861F
        plb
        .databank ?
        pla
        sta lMapMenuRAMEntryPointer+1,b
        pla
        sta lMapMenuRAMEntryPointer,b

        _8628
        ply
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 87/862D

      rsDrawMapMenuIfInRows ; 87/862D

        .al
        .xl
        .autsiz
        .databank ?

        ; Copies the current map menu's tiles to BG3 if it is shown, has tiles, and overlaps rows wR12-wR13.

        phk
        plb
        .databank $87
        ldy lMapMenuRAMEntryPointer,b
        sep #$20
        lda lMapMenuRAMEntryPointer+2,b
        pha
        rep #$20
        plb
        .databank ?
        lda $000A,b,y
        bmi _8696
        jsl rlGetMapMenuYPositions
        lda wR10
        cmp wR13
        beq _864C
        bcs _8696

        _864C
        lda wR11
        cmp wR12
        bcc _8696
        lda $0007,b,y
        sta @l lMapMenuTilemapRAMEntryPointer+1
        lda $0006,b,y
        sta @l lMapMenuTilemapRAMEntryPointer
        jsr rsCheckMapMenuHasNoTiles
        bcs _8696
        lda $000A,b,y
        and #$00FF
        cmp #$0020
        bcs _8696
        sta wR0
        lda $000B,b,y
        and #$00FF
        cmp #$0020
        bcs _8696
        asl a
        asl a
        asl a
        asl a
        asl a
        clc
        adc wR0
        asl a
        tax
        jsl rlCopyTilemapEntryToBG
        lda @l bMapMenuFlags
        ora #$0010
        sta @l bMapMenuFlags

        _8696
        rts

        .databank 0

        ; 87/8697

      rsCheckMapMenuHasNoTiles ; 87/8697

        .al
        .xl
        .autsiz
        .databank ?

        ; Carry set if the current tilemap entry has no tile buffer.

        phb
        php
        phk
        plb
        .databank $87
        phy
        ldy lMapMenuTilemapRAMEntryPointer,b
        sep #$20
        lda lMapMenuTilemapRAMEntryPointer+2,b
        pha
        rep #$20
        plb
        .databank ?
        lda structMapMenuTilemapData.TilesPointer+1,b,y
        ora structMapMenuTilemapData.TilesPointer,b,y
        beq _86B5
        ply
        plp
        plb
        .databank ?
        clc
        rts


        _86B5
        ply
        plp
        plb
        .databank ?
        sec
        rts

        .databank 0

        ; 87/86BA

    .endsection Unsorted8785A4Section


    .section Unsorted87872BSection

      .al
      .xl

      rlSetMapMenuType ; 87/872B

        .al
        .xl
        .autsiz
        .databank ?

        ; A = the current map menu's type (its frame style, aMapMenuTypePointers).

        phb
        php
        phk
        plb
        .databank $87
        phy
        pha
        ldy lMapMenuRAMEntryPointer,b
        sep #$20
        lda lMapMenuRAMEntryPointer+2,b
        pha
        rep #$20
        plb
        .databank ?
        pla
        sep #$20
        sta structMapMenu.Type,b,y
        rep #$20
        ply
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 87/8749

    .endsection Unsorted87872BSection


    .section Unsorted878852Section

      .al
      .xl

      rlFindPreviousMapMenu ; 87/8852

        .al
        .xl
        .autsiz
        .databank ?

        ; lR19 = the open map menu before the current one. Carry set if the current one is first or not in the list.

        phb
        php
        phk
        plb
        .databank $87
        phy
        lda lMapMenuListHead,b
        ora lMapMenuListHead+1,b
        beq _88A9
        lda lMapMenuListHead,b
        sta lR19
        lda lMapMenuListHead+1,b
        sta lR19+1
        lda lMapMenuListHead,b
        cmp lMapMenuRAMEntryPointer,b
        bne _8879
        lda lMapMenuListHead+1,b
        cmp lMapMenuRAMEntryPointer+1,b
        beq _88A9

        _8879
        ldy lR19
        sep #$20
        lda lR19+2
        pha
        rep #$20
        plb
        .databank ?
        lda $000C,b,y
        ora $000D,b,y
        beq _88A9
        lda $000C,b,y
        cmp @l lMapMenuRAMEntryPointer
        bne _889D
        lda $000D,b,y
        cmp @l lMapMenuRAMEntryPointer+1
        beq _88AE

        _889D
        lda $000C,b,y
        sta lR19
        lda $000D,b,y
        sta lR19+1
        bra _8879


        _88A9
        ply
        plp
        plb
        .databank ?
        sec
        rtl


        _88AE
        ply
        plp
        plb
        .databank ?
        clc
        rtl

        .databank 0

        ; 87/88B3

    .endsection Unsorted878852Section


    .section Unsorted8788F7Section

      .al
      .xl

      rlDrawMapMenuTileString ; 87/88F7

        .al
        .xl
        .autsiz
        .databank ?

        ; lR18 = a string of tile numbers ending in 0, X = row and column: draws it into the current map menu, plus aCurrentTilemapInfo.

        jsl rlGetMapMenuTilemapRAMEntryPointer
        jsl rlDrawTileStringToTilemapEntry
        rtl

        .databank 0

        ; 87/8900

    .endsection Unsorted8788F7Section


    .section Unsorted878900Section

      .al
      .xl

      rlDrawMapMenuSmallNumber ; 87/8900

        .al
        .xl
        .autsiz
        .databank ?

        ; A = 0-99, X = row and column: draws two digit tiles into the current map menu. Carry set if A is 100 or more.

        pha
        jsl rlGetMapMenuTilemapRAMEntryPointer
        pla
        jsl rlDrawSmallNumberToTilemapEntry
        rtl

        .databank 0

        ; 87/890B

      rlDrawMapMenuTallTwoDigitNumber ; 87/890B

        .al
        .xl
        .autsiz
        .databank ?

        ; A = 0-99, X = row and column: two two-row digits in the current map menu.
        ; Nothing in the build reaches this.

        pha
        jsl rlGetMapMenuTilemapRAMEntryPointer
        pla
        jsl rlDrawTallTwoDigitNumberToTilemapEntry
        rtl

        .databank 0

        ; 87/8916

    .endsection Unsorted878900Section


    .section Unsorted878916Section

      .al
      .xl

      rlDrawMapMenuNumber ; 87/8916

        .al
        .xl
        .autsiz
        .databank ?

        ; A = a signed number below 1000, X = row and column (of the last digit): draws it in two-row digits, with a minus sign for a negative. Carry set if A is 1000 or more.

        pha
        jsl rlGetMapMenuTilemapRAMEntryPointer
        pla
        jsl rlDrawNumberToTilemapEntry
        rtl

        .databank 0

        ; 87/8921

    .endsection Unsorted878916Section


    .section Unsorted878921Section

      .al
      .xl

      rlDrawMapMenuTextLine ; 87/8921

        .al
        .autsiz
        .databank ?

        ; Draws a line of menu text (lR18, at X as in rlDrawMenuTextLine) into the
        ; current map menu's tilemap (lMapMenuRAMEntryPointer).

        jsl rlGetMapMenuTilemapRAMEntryPointer
        jsl rlDrawMenuTextLine
        rtl

        .databank 0

    .endsection Unsorted878921Section


    .section Unsorted878AB5Section

      .al
      .xl

      rlCopyTilemapEntryToBG ; 87/8AB5

        .al
        .xl
        .autsiz
        .databank ?

        ; X = offset into the entry's BG buffer: copies its tiles there, skipping wMapMenuTransparentTile.

        phb
        php
        phk
        plb
        .databank $87
        phx
        phy
        ldy lMapMenuTilemapRAMEntryPointer,b
        sep #$20
        lda lMapMenuTilemapRAMEntryPointer+2,b
        pha
        rep #$20
        plb
        .databank ?
        lda structMapMenuTilemapData.TilesPointer+1,b,y
        sta lR19+1
        lda structMapMenuTilemapData.TilesPointer,b,y
        sta lR19
        lda structMapMenuTilemapData.Width,b,y
        and #$00FF
        sta wR0
        lda structMapMenuTilemapData.Height,b,y
        and #$00FF
        sta wR1
        sta wR3
        txa
        clc
        adc structMapMenuTilemapData.BGBuffer,b,y
        tax
        sep #$20
        lda structMapMenuTilemapData.BGBuffer+2,b,y
        pha
        rep #$20
        plb
        .databank ?
        ldy #$0000
        stx wR4

        _8AF7
        lda wR0
        sta wR2

        _8AFB
        lda [lR19],y
        cmp wMapMenuTransparentTile,b
        beq _8B05
        sta $0000,b,x

        _8B05
        inc y
        inc y
        inc x
        inc x
        dec wR2
        bne _8AFB
        lda wR4
        clc
        adc #$0040
        sta wR4
        tax
        dec wR3
        bne _8AF7
        ply
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 87/8B1F

    .endsection Unsorted878AB5Section


    .section Unsorted878B1FSection

      .al
      .xl

      rlGetTilemapEntrySize ; 87/8B1F

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ; Width times height times 2. Nothing in the build reaches this.

        phb
        php
        phk
        plb
        .databank $87
        phy
        ldy lMapMenuTilemapRAMEntryPointer,b
        sep #$20
        lda lMapMenuTilemapRAMEntryPointer+2,b
        pha
        rep #$20
        plb
        .databank ?
        sep #$20
        lda structMapMenuTilemapData.Width,b,y
        sta @l WRMPYA
        lda structMapMenuTilemapData.Height,b,y
        sta @l WRMPYB
        nop
        nop
        nop
        rep #$20
        lda @l RDMPY
        asl a
        ply
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 87/8B4E

    .endsection Unsorted878B1FSection


    .section Unsorted878B4ESection

      .al
      .xl

      rlGetTilemapEntryWidth ; 87/8B4E

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        phy
        ldy lMapMenuTilemapRAMEntryPointer,b
        sep #$20
        lda lMapMenuTilemapRAMEntryPointer+2,b
        pha
        rep #$20
        plb
        .databank ?
        lda structMapMenuTilemapData.Width,b,y
        and #$00FF
        ply
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 87/8B69

      rlSetTilemapEntryArea ; 87/8B69

        .al
        .xl
        .autsiz
        .databank ?

        ; A = width and height of lMapMenuTilemapRAMEntryPointer.

        phb
        php
        phk
        plb
        .databank $87
        phy
        pha
        ldy lMapMenuTilemapRAMEntryPointer,b
        sep #$20
        lda lMapMenuTilemapRAMEntryPointer+2,b
        pha
        rep #$20
        plb
        .databank ?
        pla
        sta structMapMenuTilemapData.Area,b,y
        ply
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 87/8B83

    .endsection Unsorted878B4ESection


    .section Unsorted878BF0Section

      .al
      .xl

      rlFillTilemapEntryWithPattern ; 87/8BF0

        .al
        .xl
        .autsiz
        .databank ?

        ; lR18 = width, height (bytes), then width x height tiles: repeats the pattern over the current tilemap entry's tiles, plus aCurrentTilemapInfo.

        phb
        php
        phk
        plb
        .databank $87
        phx
        phy
        lda aCurrentTilemapInfo,b
        sta wR8
        ldy lR18
        sep #$20
        lda lR18+2
        pha
        rep #$20
        plb
        .databank ?
        lda $0000,b,y
        and #$00FF
        sta wR3
        lda $0001,b,y
        and #$00FF
        sta wR4
        phk
        plb
        .databank $87
        ldy lMapMenuTilemapRAMEntryPointer,b
        sep #$20
        lda lMapMenuTilemapRAMEntryPointer+2,b
        pha
        rep #$20
        plb
        .databank ?
        lda structMapMenuTilemapData.TilesPointer,b,y
        sta lR19
        lda structMapMenuTilemapData.TilesPointer+1,b,y
        sta lR19+1
        lda structMapMenuTilemapData.Width,b,y
        and #$00FF
        sta wR5
        lda structMapMenuTilemapData.Height,b,y
        and #$00FF
        sta wR7
        ldx lR19
        sep #$20
        lda lR19+2
        pha
        rep #$20
        plb
        .databank ?
        stz wR0
        lda wR4
        sta wR2

        _8C4D
        ldy wR0
        lda wR3
        sta wR1
        lda wR5
        sta wR6

        _8C57
        lda [lR18],y
        clc
        adc wR8
        sta $0000,b,x
        dec wR1
        bne _8C69
        lda wR3
        sta wR1
        ldy wR0

        _8C69
        inc y
        inc y
        inc x
        inc x
        dec wR6
        bne _8C57
        lda wR3
        asl a
        clc
        adc wR0
        sta wR0
        dec wR2
        bne _8C83
        lda wR4
        sta wR2
        stz wR0

        _8C83
        dec wR7
        bne _8C4D
        ply
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 87/8C8C

    .endsection Unsorted878BF0Section


    .section Unsorted878C8CSection

      .al
      .xl

      rlDrawSimpleFrameToTilemapEntry ; 87/8C8C

        .al
        .autsiz
        .databank ?

        php
        phb
        phx
        phy

        sep #$20
        lda lR18+2
        pha
        rep #$20
        plb

        lda lR18
        clc
        adc #$000E
        tay

        ldx #$000E

          -
          lda $0000,b,y
          clc
          adc aCurrentTilemapInfo.wBaseTile,b
          sta wR1,x
          dec y
          dec y
          dec x
          dec x
          bpl -

        phk
        plb

        ldy lMapMenuTilemapRAMEntryPointer,b
        sep #$20
        lda lMapMenuTilemapRAMEntryPointer+2,b
        pha
        rep #$20
        plb

        lda structMapMenuTilemapData.TilesPointer,b,y
        sta lR18
        lda $0006+1,b,y
        sta lR18+1
        lda structMapMenuTilemapData.Width,b,y
        and #$00FF
        sta wR9
        lda structMapMenuTilemapData.Height,b,y
        and #$00FF
        sta wR10

        sep #$20
        lda lR18+2
        pha
        rep #$20
        plb

        sep #$20
        lda wR9
        sta WRMPYA
        lda wR10
        dec a
        sta WRMPYB
        nop
        nop
        nop
        rep #$20

        lda RDMPY
        asl a
        clc
        adc lR18
        tay

        ldx lR18
        lda wR1
        sta $0000,b,x
        inc x
        inc x
        lda wR6
        sta $0000,b,y
        inc y
        inc y
        lda wR9
        dec a
        dec a
        sta wR0

          -
          lda wR2
          sta $0000,b,x
          lda wR7
          sta $0000,b,y
          inc x
          inc x
          inc y
          inc y
          dec wR0
          bne -

        lda wR3
        sta $0000,b,x
        lda wR8
        sta $0000,b,y
        asl wR9

        lda wR9
        clc
        adc lR18
        tax

        clc
        adc wR9
        dec a
        dec a
        tay

        lda wR10
        dec a
        dec a
        sta wR0

          -
          lda wR4
          sta $0000,b,x
          lda wR5
          sta $0000,b,y

          txa
          clc
          adc wR9
          tax

          tya
          clc
          adc wR9
          tay
          dec wR0
          bne -

        ply
        plx
        plb
        plp
        rtl

        .databank 0

        ; 87/8D61

    .endsection Unsorted878C8CSection


    .section Unsorted878D61Section

      .al
      .xl

      rlDrawFancyFrameToTilemapEntry ; 87/8D61

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; lR18 = 20 tiles: draws a frame with two-tile corners round the edge of the current tilemap entry's tiles.

        phb
        php
        phk
        plb
        .databank $87
        phx
        phy
        ldy lMapMenuTilemapRAMEntryPointer,b
        sep #$20
        lda lMapMenuTilemapRAMEntryPointer+2,b
        pha
        rep #$20
        plb
        .databank ?
        lda structMapMenuTilemapData.TilesPointer,b,y
        sta lR19
        lda structMapMenuTilemapData.TilesPointer+1,b,y
        sta lR19+1
        lda structMapMenuTilemapData.Width,b,y
        and #$00FF
        sta wR13
        lda structMapMenuTilemapData.Height,b,y
        and #$00FF
        sta wR14
        ldy lR18
        sep #$20
        lda lR18+2
        pha
        rep #$20
        plb
        .databank ?
        lda $0002,b,y
        clc
        adc aCurrentTilemapInfo,b
        sta wR1
        lda $0006,b,y
        clc
        adc aCurrentTilemapInfo,b
        sta wR2
        lda $000A,b,y
        clc
        adc aCurrentTilemapInfo,b
        sta wR3
        lda $000C,b,y
        clc
        adc aCurrentTilemapInfo,b
        sta wR4
        lda $000E,b,y
        clc
        adc aCurrentTilemapInfo,b
        sta wR5
        lda $0010,b,y
        clc
        adc aCurrentTilemapInfo,b
        sta wR6
        lda $0016,b,y
        clc
        adc aCurrentTilemapInfo,b
        sta wR7
        lda $0018,b,y
        clc
        adc aCurrentTilemapInfo,b
        sta wR8
        lda $001A,b,y
        clc
        adc aCurrentTilemapInfo,b
        sta wR9
        lda $001C,b,y
        clc
        adc aCurrentTilemapInfo,b
        sta wR10
        lda $0020,b,y
        clc
        adc aCurrentTilemapInfo,b
        sta wR11
        lda $0024,b,y
        clc
        adc aCurrentTilemapInfo,b
        sta wR12
        sep #$20
        lda lR19+2
        pha
        rep #$20
        plb
        .databank ?
        sep #$20
        lda wR13
        sta @l WRMPYA
        lda wR14
        dec a
        dec a
        sta @l WRMPYB
        nop
        nop
        nop
        rep #$20
        lda @l RDMPY
        asl a
        clc
        adc lR19
        tay
        ldx lR19
        lda wR1
        sta $0002,b,x
        txa
        clc
        adc wR13
        adc wR13
        tax
        lda wR3
        sta $0000,b,x
        lda wR4
        sta $0002,b,x
        dec x
        dec x
        dec x
        dec x
        lda wR2
        sta $0000,b,x
        txa
        clc
        adc wR13
        adc wR13
        tax
        lda wR5
        sta $0000,b,x
        lda wR6
        sta $0002,b,x
        lda wR7
        sta $0000,b,y
        lda wR8
        sta $0002,b,y
        tya
        clc
        adc wR13
        adc wR13
        tay
        lda wR11
        sta $0002,b,y
        dec y
        dec y
        dec y
        dec y
        lda wR9
        sta $0000,b,y
        lda wR10
        sta $0002,b,y
        tya
        clc
        adc wR13
        adc wR13
        tay
        lda wR12
        sta $0000,b,y
        ldy lR18
        sep #$20
        lda lR18+2
        pha
        rep #$20
        plb
        .databank ?
        lda $0000,b,y
        clc
        adc aCurrentTilemapInfo,b
        sta wR1
        lda $0004,b,y
        clc
        adc aCurrentTilemapInfo,b
        sta wR2
        lda $0008,b,y
        clc
        adc aCurrentTilemapInfo,b
        sta wR3
        lda $0012,b,y
        clc
        adc aCurrentTilemapInfo,b
        sta wR4
        lda $0014,b,y
        clc
        adc aCurrentTilemapInfo,b
        sta wR5
        lda $001E,b,y
        clc
        adc aCurrentTilemapInfo,b
        sta wR6
        lda $0022,b,y
        clc
        adc aCurrentTilemapInfo,b
        sta wR7
        lda $0026,b,y
        clc
        adc aCurrentTilemapInfo,b
        sta wR8
        sep #$20
        lda lR19+2
        pha
        rep #$20
        plb
        .databank ?
        sep #$20
        lda wR13
        sta @l WRMPYA
        lda wR14
        dec a
        sta @l WRMPYB
        nop
        nop
        nop
        rep #$20
        lda @l RDMPY
        asl a
        clc
        adc lR19
        tay
        ldx lR19
        lda wR1
        sta $0000,b,x
        lda wR6
        sta $0000,b,y
        lda wR13
        sec
        sbc #$0004
        beq _8F2C
        bcc _8F2C
        sta wR0

        _8F1A
        lda wR2
        sta $0004,b,x
        lda wR7
        sta $0004,b,y
        inc x
        inc x
        inc y
        inc y
        dec wR0
        bne _8F1A

        _8F2C
        lda wR3
        sta $0006,b,x
        lda wR8
        sta $0006,b,y
        asl wR13
        lda wR13
        asl a
        clc
        adc lR19
        tax
        clc
        adc wR13
        dec a
        dec a
        tay
        lda wR14
        sec
        sbc #$0004
        beq _8F69
        bcc _8F69
        sta wR0

        _8F51
        lda wR4
        sta $0000,b,x
        lda wR5
        sta $0000,b,y
        txa
        clc
        adc wR13
        tax
        tya
        clc
        adc wR13
        tay
        dec wR0
        bne _8F51

        _8F69
        ply
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 87/8F6E

    .endsection Unsorted878D61Section


    .section Unsorted878F6ESection

      .al
      .xl

      rlDrawTileStringToTilemapEntry ; 87/8F6E

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        lda wR0
        pha
        lda wR1
        pha
        phx
        phy
        ldy lMapMenuTilemapRAMEntryPointer,b
        sep #$20
        lda lMapMenuTilemapRAMEntryPointer+2,b
        pha
        rep #$20
        plb
        .databank ?
        lda structMapMenuTilemapData.TilesPointer,b,y
        sta lR23
        lda structMapMenuTilemapData.TilesPointer+1,b,y
        sta lR23+1
        stz wR13
        stz wR1
        txa
        sep #$20
        sta wR1
        xba
        sta @l WRMPYA
        lda structMapMenuTilemapData.Width,b,y
        sta wR13
        sta @l WRMPYB
        nop
        nop
        nop
        rep #$20
        lda @l RDMPY
        clc
        adc wR1
        asl a
        tay
        lda wR13
        sec
        sbc wR1
        sta wR13
        ldx lR18
        sep #$20
        lda lR18+2
        pha
        rep #$20
        plb
        .databank ?

        _8FC6
        lda $0000,b,x
        and #$00FF
        beq _8FDC
        clc
        adc @l aCurrentTilemapInfo
        sta [lR23],y
        inc x
        inc y
        inc y
        dec wR13
        bne _8FC6

        _8FDC
        ply
        plx
        pla
        sta wR1
        pla
        sta wR0
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 87/8FE7

    .endsection Unsorted878F6ESection


    .section Unsorted878FE7Section

      .al
      .xl

      rlDrawSmallNumberToTilemapEntry ; 87/8FE7

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        phx
        phy
        ldy wR0
        phy
        and #$00FF
        cmp #$0064
        bcs _906C
        asl a
        pha
        ldy lMapMenuTilemapRAMEntryPointer,b
        sep #$20
        lda lMapMenuTilemapRAMEntryPointer+2,b
        pha
        rep #$20
        plb
        .databank ?
        lda structMapMenuTilemapData.TilesPointer,b,y
        sta lR23
        lda structMapMenuTilemapData.TilesPointer+1,b,y
        sta lR23+1
        stz wR0
        txa
        sep #$20
        sta wR0
        xba
        sta @l WRMPYA
        lda structMapMenuTilemapData.Width,b,y
        sta @l WRMPYB
        nop
        nop
        nop
        rep #$20
        lda @l RDMPY
        clc
        adc wR0
        asl a
        clc
        adc lR23
        sta lR23
        plx
        lda aTwoDigitDecimalTable+1,x
        and #$00FF
        clc
        adc @l aCurrentTilemapInfo
        clc
        adc #$0030
        ora #$2000
        sta [lR23]
        ldy #$0002
        lda aTwoDigitDecimalTable,x
        and #$00FF
        clc
        adc @l aCurrentTilemapInfo
        clc
        adc #$0030
        ora #$2000
        sta [lR23],y
        pla
        sta wR0
        ply
        plx
        plp
        plb
        .databank ?
        clc

        _906B
        rtl


        _906C
        plx
        stx wR0
        ply
        plx
        plp
        plb
        .databank ?
        sec
        bra _906B

        .databank 0

        ; 87/9076

    .endsection Unsorted878FE7Section


    .section Table879076Section

      .al
      .xl

      aTwoDigitDecimalTable ; 87/9076

        ; Read by rlDrawSmallNumberToTilemapEntry, rlDrawTallTwoDigitNumberToTilemapEntry, rlDrawNumberToTilemapEntry.

        .word $0000, $0001, $0002, $0003, $0004, $0005, $0006, $0007
        .word $0008, $0009, $0100, $0101, $0102, $0103, $0104, $0105
        .word $0106, $0107, $0108, $0109, $0200, $0201, $0202, $0203
        .word $0204, $0205, $0206, $0207, $0208, $0209, $0300, $0301
        .word $0302, $0303, $0304, $0305, $0306, $0307, $0308, $0309
        .word $0400, $0401, $0402, $0403, $0404, $0405, $0406, $0407
        .word $0408, $0409, $0500, $0501, $0502, $0503, $0504, $0505
        .word $0506, $0507, $0508, $0509, $0600, $0601, $0602, $0603
        .word $0604, $0605, $0606, $0607, $0608, $0609, $0700, $0701
        .word $0702, $0703, $0704, $0705, $0706, $0707, $0708, $0709
        .word $0800, $0801, $0802, $0803, $0804, $0805, $0806, $0807
        .word $0808, $0809, $0900, $0901, $0902, $0903, $0904, $0905
        .word $0906, $0907, $0908, $0909

        ; 87/913E

    .endsection Table879076Section


    .section Unsorted87913ESection

      .al
      .xl

      rlDrawTallTwoDigitNumberToTilemapEntry ; 87/913E

        .al
        .xl
        .autsiz
        .databank ?

        ; A = 0-99, X = row and column: draws two two-row digits. Carry set if A is 100 or more.

        phb
        php
        phk
        plb
        .databank $87
        phx
        phy
        ldy wR0
        phy
        and #$00FF
        cmp #$0064
        bcc _9153
        jml _91E4


        _9153
        asl a
        pha
        ldy lMapMenuTilemapRAMEntryPointer,b
        sep #$20
        lda lMapMenuTilemapRAMEntryPointer+2,b
        pha
        rep #$20
        plb
        .databank ?
        lda structMapMenuTilemapData.TilesPointer,b,y
        sta lR23
        lda structMapMenuTilemapData.TilesPointer+1,b,y
        sta lR23+1
        stz wR0
        txa
        sep #$20
        sta wR0
        xba
        sta @l WRMPYA
        lda structMapMenuTilemapData.Width,b,y
        sta @l WRMPYB
        nop
        nop
        nop
        rep #$20
        lda @l RDMPY
        clc
        adc wR0
        asl a
        clc
        adc lR23
        sta lR23
        lda structMapMenuTilemapData.Width,b,y
        and #$00FF
        asl a
        sta wR0
        plx
        lda aTwoDigitDecimalTable+1,x
        and #$00FF
        clc
        adc @l aCurrentTilemapInfo
        clc
        adc #$0030
        ora #$2000
        sta [lR23]
        clc
        adc #$0010
        ldy wR0
        sta [lR23],y
        ldy #$0002
        lda aTwoDigitDecimalTable,x
        and #$00FF
        clc
        adc @l aCurrentTilemapInfo
        clc
        adc #$0030
        ora #$2000
        sta [lR23],y
        clc
        adc #$0010
        inc wR0
        inc wR0
        ldy wR0
        sta [lR23],y
        pla
        sta wR0
        ply
        plx
        plp
        plb
        .databank ?
        clc

        _91E3
        rtl


        _91E4
        plx
        stx wR0
        ply
        plx
        plp
        plb
        .databank ?
        sec
        bra _91E3

        .databank 0

        ; 87/91EE

    .endsection Unsorted87913ESection


    .section Unsorted8791EESection

      .al
      .xl

      rlDrawNumberToTilemapEntry ; 87/91EE

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        phx
        phy
        ldy wR0
        phy
        cmp #$03E8
        bmi _9200
        jml _934A


        _9200
        pha
        ldy lMapMenuTilemapRAMEntryPointer,b
        sep #$20
        lda lMapMenuTilemapRAMEntryPointer+2,b
        pha
        rep #$20
        plb
        .databank ?
        lda structMapMenuTilemapData.TilesPointer,b,y
        sta lR23
        lda structMapMenuTilemapData.TilesPointer+1,b,y
        sta lR23+1
        stz wR0
        txa
        dec a
        sep #$20
        sta wR0
        xba
        sta @l WRMPYA
        lda structMapMenuTilemapData.Width,b,y
        sta @l WRMPYB
        nop
        nop
        nop
        rep #$20
        lda @l RDMPY
        clc
        adc wR0
        asl a
        clc
        adc lR23
        sta lR23
        lda structMapMenuTilemapData.Width,b,y
        and #$00FF
        asl a
        sta wR0
        pla
        pha
        cmp #$0000
        bpl _9263
        lda #$20FF
        sta [lR23]
        lda #$0019
        clc
        adc @l aCurrentTilemapInfo
        ora #$2000
        ldy wR0
        sta [lR23],y
        bra _926C


        _9263
        lda #$20FF
        sta [lR23]
        ldy wR0
        sta [lR23],y

        _926C
        pla
        cmp #$0000
        bpl _9276
        eor #$FFFF
        inc a

        _9276
        cmp #$0064
        bmi _92D9
        sta wR13
        lda #$0064
        sta wR14
        jsl rlUnsignedDivide16By8
        lda wR13
        clc
        adc @l aCurrentTilemapInfo
        clc
        adc #$0030
        ora #$2000
        sta [lR23]
        clc
        adc #$0010
        ldy wR0
        sta [lR23],y
        lda wR10
        cmp #$000A
        bpl _92D9
        ldy #$0002
        lda #$0000
        clc
        adc @l aCurrentTilemapInfo
        clc
        adc #$0030
        ora #$2000
        sta [lR23],y
        inc y
        inc y
        sta [lR23],y
        sta wR13
        lda wR10
        bpl _92DE
        lda wR13
        clc
        adc #$0010
        inc wR0
        inc wR0
        ldy wR0
        sta [lR23],y
        inc y
        inc y
        sta [lR23],y
        jml _9341


        _92D9
        cmp #$000A
        bmi _9306

        _92DE
        asl a
        tax
        ldy #$0002
        lda aTwoDigitDecimalTable+1,x
        and #$00FF
        clc
        adc @l aCurrentTilemapInfo
        clc
        adc #$0030
        ora #$2000
        sta [lR23],y
        clc
        adc #$0010
        inc wR0
        inc wR0
        ldy wR0
        sta [lR23],y
        bra _931D


        _9306
        pha
        ldy #$0002
        lda #$00FF
        ora #$2000
        sta [lR23],y
        inc wR0
        inc wR0
        ldy wR0
        sta [lR23],y
        pla
        asl a
        tax

        _931D
        ldy #$0004
        lda aTwoDigitDecimalTable,x
        and #$00FF
        clc
        adc @l aCurrentTilemapInfo
        clc
        adc #$0030
        ora #$2000
        sta [lR23],y
        clc
        adc #$0010
        inc wR0
        inc wR0
        ldy wR0
        sta [lR23],y

        _9341
        pla
        sta wR0
        ply
        plx
        plp
        plb
        .databank ?
        clc

        _9349
        rtl


        _934A
        plx
        stx wR0
        ply
        plx
        plp
        plb
        .databank ?
        sec
        bra _9349

        .databank 0

        ; 87/9354

    .endsection Unsorted8791EESection


