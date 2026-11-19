; TODO: describe this file.

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
