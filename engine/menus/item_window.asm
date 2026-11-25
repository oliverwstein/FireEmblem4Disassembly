; The item window: map menu option アイテム (Item). Lists every item the player's
; units hold, sorted by owner, type or name (wItemWindowSortMode, kept between visits), with
; the selected item's details; A jumps to the unit holding it. Opened by
; rsItemWindowOpen, then run by game state routines $23 (rlItemWindowRender), $24
; (rlItemWindowShow) and $25 (rlItemWindowRunStep), with wGameStateStep as the
; step. Code in banks $80 and $89; its variables are at $7F8467 (include/WRAM.h).


    .section Unsorted80CD2ESection

      .al
      .xl

      rsItemWindowOpen ; 80/CD2E

        .al
        .xl
        .autsiz
        .databank ?

        ; Main loop routine that opens the item window (map menu option アイテム, through
        ; rlMapMenuOpenItemWindow): resets the screen and the engines, builds the list
        ; and draws it, then runs game state routines $23-$25. Built like
        ; rsUnitWindowOpen; FE5's rsUnitWindowMainLoopUpdater only resembles it.

        php
        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        lda #<>rsRunMenuScreenVBlank
        sta wVBlankPointer
        jsl rlHaltUntilVBlank
        jsl rlDisableVBlank
        jsl rlHardwareResetScreenPosMathHDMA
        jsl rlHardwareResetScreenRegisters
        lda #$0000
        sta wR1
        lda #$0000
        sta wR2
        lda #$0000
        sta wR3
        lda #$4000
        sta wR5
        lda #$2000
        sta wR6
        lda #$2800
        sta wR7
        lda #$1800
        sta wR8
        jsl rlSetLayerPositionsAndSizes
        jsl rlClearUnitWindowAndTerrainWindowProcs
        jsl rlActiveSpriteEngineReset
        jsl rlResetHDMAEngine
        jsl rlResetIRQEngine
        jsr rsItemWindowInitializeLineVariables
        jsr rsItemWindowCopyGraphics
        jsr rsItemWindowSetBGSettings
        jsr rsItemWindowCreateHDMA
        jsr rsItemWindowBuildItemList
        jsr rsItemWindowDrawHeader
        phk
        plb
        .databank $80
        lda #GAMESTATE_ITEM_WINDOW_SETUP
        sta wGameStateRoutine1,b
        lda #GAMESTATE_ITEM_WINDOW_UPKEEP
        sta wGameStateRoutine2,b
        lda #<>rsRunFrameTasks
        sta wMainLoopPointer
        jsl rlEnableVBlank
        plp
        rts

        .databank 0

        ; 80/CDAE

      rsItemWindowInitializeLineVariables ; 80/CDAE

        .al
        .xl
        .autsiz
        .databank ?

        ; Line 1 selected, at the top, no scrolling.

        lda #$0000
        sta wGameStateStep,b
        sta wItemWindowScrollOffset
        sta wItemWindowCursorRow
        sta $7F8475
        sta $7F8477
        sta wItemWindowScrollDirection
        sta wItemWindowSortPanelRow
        sta $7F847B
        lda #$0001
        sta wItemWindowCurrentLine
        lda #$001C
        sta wItemWindowCursorYCoordinate
        rts

        .databank 0

        ; 80/CDDF

      rsItemWindowCopyGraphics ; 80/CDDF

        .al
        .xl
        .autsiz
        .databank ?

        ; Copies the window's tiles to VRAM, its palettes, and decompresses its BG2 tilemaps.

        jsl rlDMAByStruct

          .structDMAToVRAM g4bppMenuCursorSprites, $0400, $80, $8000

        jsl rlDMAByStruct

          .structDMAToVRAM g4bppItemIcons, $4000, $80, $8400

        jsl rlDMAByStruct

          .structDMAToVRAM g4bppWindowFrames, $0C00, $80, $6000

        lda #(`aDecompressionDMAEntry80CE8E)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry80CE8E
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        jsl rlDMAByStruct

          .structDMAToVRAM g2bppMenuLabels, $1800, $80, $1800

        ldx #$0200

        _CE24
        lda aWindowPalette-2,x
        sta aBGPaletteBuffer-2,x
        dec x
        dec x
        bne _CE24
        lda #$0000
        sta aBGPaletteBuffer,b
        lda #$0003
        jsl rlUnitWindowCopySpritePalette1
        lda #$0004
        jsl rlUnitWindowCopySpritePalette2
        lda #(`acItemWindowBG1Tilemap)<<8
        sta lR18+1
        lda #<>acItemWindowBG1Tilemap
        sta lR18
        lda #(`aBG2TilemapBuffer)<<8
        sta lR19+1
        lda #<>aBG2TilemapBuffer
        sta lR19
        jsl rlAppendDecompList
        lda #(`acItemWindowBG2Tilemap)<<8
        sta lR18+1
        lda #<>acItemWindowBG2Tilemap
        sta lR18
        lda #$7E00
        sta lR19+1
        lda #$7B88
        sta lR19
        jsl rlAppendDecompList
        jsl rlDMAByStruct

          .structDMAToVRAM aBG2TilemapBuffer, $0700, $80, $4000

        lda #(`aDecompressionDMAEntry80CE96)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry80CE96
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        rts

        .databank 0

        ; 80/CE8E

    .endsection Unsorted80CD2ESection


    .section Unsorted80CE9ESection

      .al
      .xl

      rsItemWindowSetBGSettings ; 80/CE9E

        .al
        .xl
        .autsiz
        .databank ?

        ; Layers, windows and colour math.

        sep #$20
        lda #$17
        sta bBufferTM
        lda #$00
        sta bBufferTS
        lda #$00
        sta bBufferTMW
        lda #$00
        sta bBufferTSW
        lda #$00
        sta bBufferW12SEL
        lda #$00
        sta bBufferW34SEL
        lda #$00
        sta bBufferWOBJSEL
        lda #$00
        sta bBufferWH0
        lda #$FF
        sta bBufferWH1
        lda #$00
        sta bBufferWH2
        sta bBufferWH3
        lda #$00
        sta bBufferWBGLOG
        sta bBufferWOBJLOG
        lda #$00
        sta bBufferCGWSEL
        lda #$83
        sta bBufferCGADSUB
        rep #$20
        stz wBufferBG1HOFS
        stz wBufferBG2HOFS
        stz wBufferBG3HOFS
        stz wBufferBG1VOFS
        stz wBufferBG2VOFS
        stz wBufferBG3VOFS
        rts

        .databank 0

        ; 80/CEE7

      rsItemWindowCreateHDMA ; 80/CEE7

        .al
        .xl
        .autsiz
        .databank ?

        ; Creates the COLDATA HDMA entry whose header is at $80/D07E (rlMapMenuWindowCOLDATAHDMAInit, rlMapMenuWindowCOLDATAHDMACycle).

        lda #(`aMapMenuWindowCOLDATAHDMAInfo)<<8
        sta lR44+1
        lda #<>aMapMenuWindowCOLDATAHDMAInfo
        sta lR44
        jsl rlHDMAEngineCreateEntry
        rts

        .databank 0

        ; 80/CEF6

      rsItemWindowDrawHeader ; 80/CEF6

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws the item count and the column labels, or the "no items" text when the list is empty.

        lda #$00CE
        jsl rlUnitWindowFillBG3Buffer
        lda wItemWindowItemCount
        bne _CF3F
        lda #$0002
        sta wGameStateStep,b
        lda #(`aItemWindowBG3TilemapEntry)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aItemWindowBG3TilemapEntry
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda #(`aItemWindowNoItemsText)<<8
        sta lR18+1
        lda #<>aItemWindowNoItemsText
        sta lR18
        ldx #$0A02
        jsl rlDrawMenuTextLine
        lda #(`aItemWindowPressBText)<<8
        sta lR18+1
        lda #<>aItemWindowPressBText
        sta lR18
        ldx #$0D03
        jsl rlDrawMenuTextLine
        bra _CF4A


        _CF3F
        lda #$0000
        jsl rlItemWindowCopyVisibleRows
        jsl rlItemWindowDrawItemInfo

        _CF4A
        lda wItemWindowItemCount
        ldx #$3920
        stx wR5
        ldx #$0000
        stx wR6
        ldx #$0672
        jsl rlDrawMenuTextNumber
        lda #$3800
        sta wR1
        lda #$00CD
        sta wR2
        lda #$0001
        sta wR0
        ldx #$0670
        jsl rlDrawBG3TileRun
        lda #$3C00
        sta wR1
        lda #$0289
        sta wR2
        lda #$0004
        sta wR0
        ldx #$0048
        jsl rlDrawBG3TileRun
        lda #$3C00
        sta wR1
        lda #$028D
        sta wR2
        lda #$0001
        sta wR0
        ldx #$0058
        jsl rlDrawBG3TileRun
        lda #$3C00
        sta wR1
        lda #$01C5
        sta wR2
        lda #$0001
        sta wR0
        ldx #$005A
        jsl rlDrawBG3TileRun
        lda #$3000
        sta wR1
        lda #$0205
        sta wR2
        lda #$0007
        sta wR0
        ldx #$006C
        jsl rlDrawBG3TileRun
        lda wItemWindowSortMode
        beq _CFD8
        dec a
        beq _D00A
        bra _CFDC


        _CFD8
        jml _D022


        _CFDC
        lda #$2000
        sta wR1
        lda #$01E0
        sta wR2
        lda #$0003
        sta wR0
        ldx #$012E
        jsl rlDrawBG3TileRun
        lda #$2000
        sta wR1
        lda #$01CF
        sta wR2
        lda #$0001
        sta wR0
        ldx #$0134
        jsl rlDrawBG3TileRun
        bra _D038


        _D00A
        lda #$2000
        sta wR1
        lda #$01CC
        sta wR2
        lda #$0004
        sta wR0
        ldx #$012E
        jsl rlDrawBG3TileRun
        bra _D038


        _D022
        lda #$2000
        sta wR1
        lda #$01C8
        sta wR2
        lda #$0004
        sta wR0
        ldx #$012E
        jsl rlDrawBG3TileRun

        _D038
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0700, $80, $3000

        rts

        .databank 0

        ; 80/D046

    .endsection Unsorted80CE9ESection


    .section Table80D046Section

      .al
      .xl

      aItemWindowNoItemsText ; 80/D046

        .enc "SJIS"
        .text "わが軍のアイテムはありません"
        .word $0000
        .enc "none"

      aItemWindowPressBText ; 80/D064

        .enc "SJIS"
        .text "Ｂボタンをおしてください"
        .word $0000
        .enc "none"


      aMapMenuWindowCOLDATAHDMAInfo .dstruct structHDMADirectEntryInfo, rlMapMenuWindowCOLDATAHDMAInit, rlMapMenuWindowCOLDATAHDMACycle, $D0B2, $7FB0B6, PPU_REG_BASE + $32, $00 ; 80/D07E

    .endsection Table80D046Section


    .section Unsorted80D089Section

      .al
      .xl

      rlMapMenuWindowCOLDATAHDMAInit ; 80/D089

        .al
        .xl
        .autsiz
        .databank ?

        ; Copies the HDMA table at $80/D09B to $7FB0B6.

        ldx #$0000

        _D08C
        lda aMapMenuWindowCOLDATAHDMATable,x
        sta $7FB0B6,x
        beq _D09A
        inc x
        inc x
        bra _D08C


        _D09A
        rtl

        .databank 0

        ; 80/D09B

    .endsection Unsorted80D089Section


    .section Data80D09BSection

      .al
      .xl

      aMapMenuWindowCOLDATAHDMATable ; 80/D09B

        ; Read by rlMapMenuWindowCOLDATAHDMAInit.

        .word $E018, $E118, $E218, $E318, $E418, $E510, $E610, $E718
        .word $E818, $E918, $0000

        ; 80/D0B1

    .endsection Data80D09BSection


    .section Unsorted80D0B1Section

      .al
      .xl

      rlMapMenuWindowCOLDATAHDMACycle ; 80/D0B1

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 80/D0B2


      aMapMenuWindowCOLDATAHDMACode ; 80/D0B2

        HDMA_HALT

    .endsection Unsorted80D0B1Section


    .section Unsorted80D0B4Section

      .al
      .xl

      rsItemWindowBuildItemList ; 80/D0B4

        .al
        .xl
        .autsiz
        .databank ?

        ; Lists every item held by a living, non-captive unit of faction slot 0 in aItemWindowList, sets the count and the furthest scroll, then gets the items' data and sorts the list.

        lda #$0000
        ldx #$0096

        _D0BA
        sta $7F8481,x
        dec x
        dec x
        bne _D0BA
        jsl rlGetItemRAMDataCount
        inc a
        sta wR15
        ldx #$0000
        lda #$0001

        _D0CF
        sta wR14
        jsl rlGetItemRAMStructEntryByPlayerItemIndex
        jsl rlGetEffectiveItemROMPointerByItemRAMStructEntry
        jsl rlGetItemRAMStateAndOwner
        lda wR0
        cmp #$0001
        beq _D0E9
        cmp #$0002
        bne _D117

        _D0E9
        lda wR1
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitFactionSlot
        cmp #$0000
        bne _D117
        jsl rlGetSelectedUnitStates
        bit #UnitStateDead
        bne _D117
        jsl rlGetSelectedUnitStatus
        cmp #StatusCaptive
        beq _D117
        lda wR14
        and #$00FF
        sep #$20
        sta aItemWindowList,x
        rep #$20
        inc x

        _D117
        lda wR14
        inc a
        cmp wR15
        beq _D122
        jml _D0CF


        _D122
        txa
        sta wItemWindowItemCount
        sec
        sbc #$000C
        bpl _D130
        lda #$0000

        _D130
        sta wItemWindowMaxScroll
        lda wItemWindowItemCount
        beq _D142
        jsl rlItemWindowGetItemData
        jsl rlItemWindowSort

        _D142
        rts

        .databank 0

        ; 80/D143

    .endsection Unsorted80D0B4Section


    .section Unsorted80D143Section

      .al
      .xl

      rlItemWindowGetItemData ; 80/D143

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; For each listed item: its icon (from aItemWindowIconIndices by item ID), its RAM data pointer and its ROM data pointer.

        lda #$0000
        ldx #$0200

        _D149
        sta $7F8518,x
        sta $7F8646,x
        sta $7F8774,x
        dec x
        dec x
        bne _D149
        lda wItemWindowItemCount
        sta wItemWindowLoopCount
        lda #$0000

        _D164
        sta wItemWindowLoopIndex
        tax
        lda aItemWindowList,x
        and #$00FF
        pha
        jsl rlGetItemRAMStructEntryByPlayerItemIndex
        jsl rlGetEffectiveItemIDByItemRAMStructEntry
        sta wItemWindowCurrentItemID
        jsl rlGetItemDataROMPointer
        lda wItemWindowCurrentItemID
        asl a
        tax
        lda aItemWindowIconIndices,x
        tay
        pla
        asl a
        tax
        tya
        sta aItemWindowItemIcons,x
        lda wCurrentItemDataRAMPointer,b
        sta aItemWindowItemRAMPointers,x
        lda wCurrentItemDataROMPointer,b
        sta aItemWindowItemROMPointers,x
        lda wItemWindowLoopIndex
        inc a
        cmp wItemWindowLoopCount
        bne _D164
        rtl

        .databank 0

        ; 80/D1AE

    .endsection Unsorted80D143Section


    .section Table80D1AESection

      .al
      .xl

      aItemWindowIconIndices ; 80/D1AE

        ; Read by rlItemWindowGetItemData (item ID -> icon index, zero-terminated).

        .word $0000, $0002, $0004, $0006, $0008, $000A, $000C, $000E
        .word $0020, $0022, $0024, $0026, $0028, $002A, $002C, $002E
        .word $0040, $0042, $0044, $0046, $0048, $004A, $004C, $004E
        .word $0060, $0062, $0062, $0062, $0064, $0066, $0068, $006A
        .word $006C, $006E, $0080, $0082, $0084, $0086, $0086, $0086
        .word $0088, $008A, $008C, $008E, $00A0, $00A2, $00A4, $00A4
        .word $00A4, $00A6, $00A8, $00AA, $00AC, $00AE, $00C0, $00C2
        .word $00C2, $00C2, $01A2, $01A4, $01A6, $01A8, $00C4, $00C6
        .word $00C8, $00CA, $00CC, $00CE, $00E0, $00E2, $00E4, $00E6
        .word $00E8, $00EA, $00EC, $00EE, $0100, $0102, $0104, $0106
        .word $0108, $010A, $010C, $010E, $0120, $0122, $0122, $0122
        .word $0124, $0126, $0128, $012A, $012C, $012E, $0140, $0142
        .word $0144, $0146, $01AA, $0148, $014A, $014C, $014E, $0160
        .word $0160, $0160, $0162, $0164, $0166, $0168, $016A, $016C
        .word $016E, $0180, $0182, $0184, $0186, $0188, $018A, $018C
        .word $018E, $01A0, $0062, $0086, $00C2, $0122, $0122, $0122
        .word $0122, $0122, $0122, $0122, $0122, $0122, $0122, $0122
        .word $0160, $01AC, $0000, $0000

        ; 80/D2C6

    .endsection Table80D1AESection


    .section Unsorted89B3D7Section

      .al
      .xl

      rlItemWindowShow ; 89/B3D7

        .al
        .xl
        .autsiz
        .databank ?

        ; Game state routine $24, once: turns on the active sprite engine and the screen.

        jsl rlEnableActiveSpriteEngine
        inc wGameStateRoutine1,b
        sep #$20
        lda #$0F
        sta bBufferINIDISP
        rep #$20
        rtl

        .databank 0

        ; 89/B3E7

      rlItemWindowRunStep ; 89/B3E7

        .al
        .xl
        .autsiz
        .databank ?

        ; Game state routine $25, every frame: runs the routine for wGameStateStep from the table after this routine (0 input, 1 sort panel, 2 no items, 3 close to the map, 4 back to the castle).

        phb
        php
        phk
        plb
        .databank $89
        lda wGameStateStep,b
        asl a
        tax
        jsr (aItemWindowSteps,x)
        plp
        plb
        .databank $89
        rtl

        .databank 0

        ; 89/B3F6

    .endsection Unsorted89B3D7Section


    .section Table89B3F6Section

      .al
      .xl

      aItemWindowSteps ; 89/B3F6

        ; Jump table of rlItemWindowRunStep.
        .word <>rsItemWindowHandleInput
        .word <>rsItemWindowSortPanel
        .word <>rsItemWindowNoItems
        .word <>rsItemWindowCloseToMap
        .word <>rsItemWindowFadeToCastle

    .endsection Table89B3F6Section


    .section Unsorted89B400Section

      .al
      .xl

      rsItemWindowHandleInput ; 89/B400

        .al
        .xl
        .autsiz
        .databank ?

        ; Step 0. B closes, A goes to the unit holding the item (rsItemWindowGoToOwner), Y or right opens the sort panel (rsItemWindowOpenSortPanel), up and down move and scroll, L and R move a page, Select and Start go to the first and last item.

        jsr rsItemWindowRenderCursor
        lda wItemWindowScrollDirection
        bmi _B45E
        bne _B462
        lda wJoy1New
        bit #$8000
        bne _B476
        bit #$0020
        bne _B456
        bit #$0010
        bne _B45A
        bit #$0080
        bne _B472
        lda wJoy1Repeated
        bit #$0020
        bne _B456
        bit #$0010
        bne _B45A
        bit #$0800
        bne _B4A3
        bit #$0400
        bne _B452
        lda wJoy1New
        bit #$2000
        bne _B466
        bit #$1000
        bne _B46A
        lda wJoy1Input
        bit #$0C00
        bne _B451
        lda wJoy1New
        bit #$4100
        bne _B46E

        _B451
        rts


        _B452
        jml _B4FC


        _B456
        jml _B556


        _B45A
        jml _B5A9


        _B45E
        jml _B630


        _B462
        jml _B6AF


        _B466
        jml _B568


        _B46A
        jml _B5BE


        _B46E
        jml rsItemWindowOpenSortPanel


        _B472
        jml rsItemWindowGoToOwner


        _B476
        lda #$0021
        jsl rlPlaySoundEffect
        lda wChapterFlags,b
        bit #$0020
        bne _B494
        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        lda #$0003
        sta wGameStateStep,b
        rts


        _B494
        sep #$20
        lda #$0E
        sta bBufferINIDISP
        rep #$20
        lda #$0004
        sta wGameStateStep,b
        rts


        _B4A3
        lda wItemWindowCurrentLine
        cmp #$0001
        beq _B4BD
        lda wItemWindowCursorRow
        cmp #$0000
        beq _B4B9
        jml _B4C2


        _B4B9
        jml _B4DF


        _B4BD
        jsl rlItemWindowDrawItemInfo
        rts


        _B4C2
        lda #$FFFF
        sta wItemWindowScrollDirection
        lda #$0000
        sta $7F8475
        sta $7F8477
        lda #$0006
        jsl rlPlaySoundEffect
        jml _B630


        _B4DF
        lda #$0001
        sta wItemWindowScrollDirection
        lda #$0000
        sta $7F847B
        sta $7F8477
        lda #$0006
        jsl rlPlaySoundEffect
        jml _B6AF


        _B4FC
        lda wItemWindowCurrentLine
        cmp wItemWindowItemCount
        beq _B517
        lda wItemWindowCursorRow
        cmp #$000B
        beq _B513
        jml _B51C


        _B513
        jml _B539


        _B517
        jsl rlItemWindowDrawItemInfo
        rts


        _B51C
        lda #$FFFF
        sta wItemWindowScrollDirection
        sta $7F8475
        lda #$0000
        sta $7F8477
        lda #$0006
        jsl rlPlaySoundEffect
        jml _B630


        _B539
        lda #$0001
        sta wItemWindowScrollDirection
        sta $7F847B
        lda #$0000
        sta $7F8477
        lda #$0006
        jsl rlPlaySoundEffect
        jml _B6AF


        _B556
        lda wItemWindowCurrentLine
        dec a
        beq _B567
        lda #$0006
        jsl rlPlaySoundEffect
        jsr rsItemWindowMoveToPreviousPage

        _B567
        rts


        _B568
        lda wItemWindowCurrentLine
        dec a
        beq _B5A8
        lda #$0006
        jsl rlPlaySoundEffect
        lda wItemWindowCurrentLine
        cmp #$000D
        bcc _B587
        lda wBufferBG2VOFS
        clc
        adc #$0008
        sta wBufferBG2VOFS

        _B587
        lda #$0001
        sta wItemWindowCurrentLine
        lda #$0000
        sta wItemWindowScrollOffset
        sta wItemWindowCursorRow
        lda #$001C
        sta wItemWindowCursorYCoordinate
        jsl rlItemWindowDrawItemInfo
        jsl rlItemWindowCopyVisibleRows

        _B5A8
        rts


        _B5A9
        lda wItemWindowCurrentLine
        cmp wItemWindowItemCount
        beq _B5BD
        lda #$0006
        jsl rlPlaySoundEffect
        jsr rsItemWindowMoveToNextPage

        _B5BD
        rts


        _B5BE
        lda wItemWindowCurrentLine
        cmp wItemWindowItemCount
        beq _B5F1
        lda wItemWindowItemCount
        sta wItemWindowCurrentLine
        lda wItemWindowItemCount
        cmp #$000D
        bpl _B5F2
        dec a
        sta wItemWindowCursorRow
        asl a
        asl a
        asl a
        asl a
        clc
        adc #$001C
        sta wItemWindowCursorYCoordinate
        lda #$0006
        jsl rlPlaySoundEffect

        _B5F1
        rts


        _B5F2
        lda #$0006
        jsl rlPlaySoundEffect
        lda wItemWindowScrollOffset
        lsr a
        cmp wItemWindowMaxScroll
        beq _B60C
        lda wBufferBG2VOFS
        clc
        adc #$0008
        sta wBufferBG2VOFS

        _B60C
        lda #$000B
        sta wItemWindowCursorRow
        lda wItemWindowItemCount
        sec
        sbc #$000C
        asl a
        sta wItemWindowScrollOffset
        lda #$00CC
        sta wItemWindowCursorYCoordinate
        jsl rlItemWindowCopyVisibleRows
        jsl rlItemWindowDrawItemInfo
        rts


        _B630
        lda $7F8475
        bne _B674
        lda wItemWindowCursorYCoordinate
        sec
        sbc #$0008
        sta wItemWindowCursorYCoordinate
        lda $7F8477
        clc
        adc #$0001
        sta $7F8477
        cmp #$0002
        bne _B6AE
        lda #$0000
        sta wItemWindowScrollDirection
        lda wItemWindowCursorRow
        dec a
        sta wItemWindowCursorRow
        lda wItemWindowCurrentLine
        dec a
        sta wItemWindowCurrentLine
        jsl rlItemWindowDrawItemInfo
        jml _B6AE


        _B674
        lda wItemWindowCursorYCoordinate
        clc
        adc #$0008
        sta wItemWindowCursorYCoordinate
        lda $7F8477
        clc
        adc #$0001
        sta $7F8477
        cmp #$0002
        bne _B6AE
        lda #$0000
        sta wItemWindowScrollDirection
        lda wItemWindowCursorRow
        inc a
        sta wItemWindowCursorRow
        lda wItemWindowCurrentLine
        inc a
        sta wItemWindowCurrentLine
        jsl rlItemWindowDrawItemInfo

        _B6AE
        rts


        _B6AF
        lda $7F847B
        bne _B6EB
        lda wBufferBG2VOFS
        sec
        sbc #$0008
        sta wBufferBG2VOFS
        lda wItemWindowScrollOffset
        dec a
        sta wItemWindowScrollOffset
        lda $7F8477
        clc
        adc #$0001
        sta $7F8477
        cmp #$0002
        bne _B71A
        lda #$0000
        sta wItemWindowScrollDirection
        lda wItemWindowCurrentLine
        dec a
        sta wItemWindowCurrentLine
        jml _B71A


        _B6EB
        lda wBufferBG2VOFS
        clc
        adc #$0008
        sta wBufferBG2VOFS
        lda wItemWindowScrollOffset
        inc a
        sta wItemWindowScrollOffset
        lda $7F8477
        inc a
        sta $7F8477
        cmp #$0002
        bne _B71A
        lda #$0000
        sta wItemWindowScrollDirection
        lda wItemWindowCurrentLine
        inc a
        sta wItemWindowCurrentLine

        _B71A
        jsl rlItemWindowCopyVisibleRows
        jsl rlItemWindowDrawItemInfo
        rts

        .databank 0

        ; 89/B723

      rsItemWindowOpenSortPanel ; 89/B723

        .al
        .xl
        .autsiz
        .databank ?

        ; Moves to step 1 and draws the panel for choosing the sort order.

        lda #$0008
        jsl rlPlaySoundEffect
        lda #$0001
        sta wGameStateStep,b
        ldx #$01EA
        lda #$0004
        ldy #$0009
        jsl rlClearTilemapRect
        jsr rsItemWindowDrawSortPanel
        jsl rlDMAByStruct

          .structDMAToVRAM $7E7B88, $02C0, $80, $4000

        rts

        .databank 0

        ; 89/B74E

      rsItemWindowGoToOwner ; 89/B74E

        .al
        .xl
        .autsiz
        .databank ?

        ; A: makes the item's owner the active unit; closes to the map with the cursor on it if it is on the map (step 3), else fades out to the unit's screen (step 4).

        lda #$000A
        jsl rlPlaySoundEffect
        jsl rlGetItemRAMStateAndOwner
        lda wR1
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitStates
        bit #UnitStateFielded
        beq _B787
        jsl rlGetSelectedUnitDeploymentOffset
        cmp #$0000
        bmi _B778
        sta @l wActiveUnitDeploymentOffset
        jsl rlSetMapReturnCenterOnUnit

        _B778
        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        lda #$0003
        sta wGameStateStep,b
        rts


        _B787
        jsl rlGetSelectedUnitDeploymentOffset
        sta wActiveUnitDeploymentOffset,b
        sep #$20
        lda #$0E
        sta bBufferINIDISP
        rep #$20
        lda #$0004
        sta wGameStateStep,b
        rts

        .databank 0

        ; 89/B79D

    .endsection Unsorted89B400Section


    .section Unsorted89B856Section

      .al
      .xl

      rsItemWindowCloseToMap ; 89/B856

        .al
        .xl
        .autsiz
        .databank ?

        ; Step 3, like rlUnitWindowCloseToMap.

        lda #$0001
        sta wMainGameMode,b
        lda #<>rsReturnToMapMainLoop
        sta wMainLoopPointer
        lda #$00E8
        jsl rlQueueSoundCommand
        rts

        .databank 0

        ; 89/B869

    .endsection Unsorted89B856Section


    .section Unsorted89B883Section

      .al
      .xl

      rlItemWindowRender ; 89/B883

        .al
        .xl
        .autsiz
        .databank ?

        ; Game state routine $23, every frame: the item icons, the selected item's sprites, the scroll arrows and the number of the current line.

        lda wGameStateStep,b
        cmp #$0003
        beq _B8BC
        lda wItemWindowItemCount
        beq _B89E
        jsr rsItemWindowRenderItemIcons
        jsr rsItemWindowRenderSelectedItemSprites
        jsr rsItemWindowRenderScrollArrows
        lda wItemWindowCurrentLine

        _B89E
        ldx #$3920
        stx wR5
        ldx #$0003
        stx wR6
        ldx #$066A
        jsl rlDrawMenuTextNumber
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8448, $0600, $80, $30C0


        _B8BC
        rtl

        .databank 0

        ; 89/B8BD

    .endsection Unsorted89B883Section


    .section Unsorted89B8BDSection

      .al
      .xl

      rlItemWindowCopyVisibleRows ; 89/B8BD

        .al
        .xl
        .autsiz
        .databank ?

        ; Copies the 12 visible rows of the list tilemap, from the scroll position, into BG3.

        lda wItemWindowScrollOffset
        sta wR0
        asl a
        asl a
        asl a
        asl a
        asl a
        sta wR1
        lda #$00C4
        sta wR0
        stz wR4

        _B8D1
        lda #$000F
        sta wR15
        sta wR14
        ldx wR1
        ldy wR0
        lda #$007E
        sep #$20
        pha
        rep #$20
        plb
        .databank $7E

        _B8E5
        lda aItemWindowListTilemap,x
        sta aBG3TilemapBuffer,y
        inc x
        inc x
        inc y
        inc y
        dec wR15
        bpl _B8E5
        ldx wR1
        ldy wR0

        _B8F8
        lda $7F89F0,x
        sta $83C8,b,y
        inc x
        inc x
        inc y
        inc y
        dec wR14
        bpl _B8F8
        txa
        clc
        adc #$0020
        sta wR1
        tya
        clc
        adc #$0060
        sta wR0
        inc wR4
        lda wR4
        cmp #$000C
        bne _B8D1
        rtl

        .databank 0

        ; 89/B91F

    .endsection Unsorted89B8BDSection


    .section Unsorted89B91FSection

      .al
      .xl

      rlItemWindowDrawItemInfo ; 89/B91F

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Draws the selected item's name, durability, weapon rank and description.

        jsr rsItemWindowClearItemInfo
        lda wItemWindowCurrentLine
        dec a
        tax
        lda aItemWindowList,x
        and #$00FF
        asl a
        tax
        lda aItemWindowItemRAMPointers,x
        sta wCurrentItemDataRAMPointer,b
        lda aItemWindowItemROMPointers,x
        sta wCurrentItemDataROMPointer,b
        lda aItemWindowItemIcons,x
        sta wItemWindowSelectedItemIcon
        jsl rlGetItemNamePointer
        lda lRoutineVariable+1,b
        sta lR18+1
        lda lRoutineVariable,b
        sta lR18
        ldx #$0715
        jsl rlDrawMenuTextLine
        jsl rlGetItemEquipmentType
        cmp #$0000
        bne _B969
        jml _B9A6


        _B969
        cmp #$0001
        beq _B975
        jsr rsItemWindowDrawItemDescription
        jml _BAC0


        _B975
        jsl rlGetItemCurrentDurability
        ldx #$3920
        stx wR5
        ldx #$0002
        stx wR6
        ldx #$01F8
        jsl rlDrawMenuTextNumber
        jsl rlGetItemWeaponRank
        cmp #$FFFF
        bne _B996
        lda #$0004

        _B996
        ldx #$0016
        ldy #$0009
        jsr rsItemWindowDrawWeaponRank
        jsr rsItemWindowDrawItemDescription
        jml _BAC0


        _B9A6
        lda #$2400
        sta aCurrentTilemapInfo,b
        lda #(`aItemWindowHitLabelText)<<8
        sta lR18+1
        lda #<>aItemWindowHitLabelText
        sta lR18
        ldx #$0B14
        jsl rlDrawMenuTextLine
        lda #(`aItemWindowMightLabelText)<<8
        sta lR18+1
        lda #<>aItemWindowMightLabelText
        sta lR18
        ldx #$0D15
        jsl rlDrawMenuTextLine
        lda #(`aItemWindowRangeLabelText)<<8
        sta lR18+1
        lda #<>aItemWindowRangeLabelText
        sta lR18
        ldx #$0F15
        jsl rlDrawMenuTextLine
        lda #(`aItemWindowWeightLabelText)<<8
        sta lR18+1
        lda #<>aItemWindowWeightLabelText
        sta lR18
        ldx #$1116
        jsl rlDrawMenuTextLine
        lda #$3800
        sta wR1
        lda #$02A0
        sta wR2
        lda #$0001
        sta wR0
        ldx #$03F6
        jsl rlDrawBG3TileRun
        lda #$2000
        sta aCurrentTilemapInfo,b
        jsl rlGetItemRAMStateAndOwner
        lda wR1
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetItemCurrentDurability
        ldx #$3920
        stx wR5
        ldx #$0002
        stx wR6
        ldx #$01F8
        jsl rlDrawMenuTextNumber
        jsl rlGetItemWeaponRank
        cmp #$FFFF
        bne _BA36
        lda #$0004

        _BA36
        ldx #$0016
        ldy #$0009
        jsr rsItemWindowDrawWeaponRank
        jsl rlGetItemAccuracy
        ldx #$3920
        stx wR5
        ldx #$0000
        stx wR6
        ldx #$02F4
        jsl rlDrawMenuTextNumber
        jsl rlGetItemMight
        ldx #$3920
        stx wR5
        ldx #$0000
        stx wR6
        ldx #$0374
        jsl rlDrawMenuTextNumber
        jsl rlGetItemMinimumRange
        ldx #$3920
        stx wR5
        ldx #$0001
        stx wR6
        ldx #$03F4
        jsl rlDrawMenuTextNumber
        jsl rlGetItemMaximumRange
        ldx #$3920
        stx wR5
        ldx #$0000
        stx wR6
        ldx #$03F8
        jsl rlDrawMenuTextNumber
        jsl rlGetItemWeight
        ldx #$3920
        stx wR5
        ldx #$0000
        stx wR6
        ldx #$0474
        jsl rlDrawMenuTextNumber
        jsl rlGetItemRAMKillCountAndCritAbility
        ldx #$3920
        stx wR5
        ldx #$0000
        stx wR6
        ldx #$0274
        jsl rlDrawMenuTextNumber
        jsr rsItemWindowDrawItemDescription2

        _BAC0
        rtl

        .databank 0

        ; 89/BAC1

    .endsection Unsorted89B91FSection


    .section Table89BAC1Section

      .al
      .xl

      aItemWindowHitLabelText ; 89/BAC1

        .enc "SJIS"
        .text "めいちゅう"
        .word $0000
        .enc "none"

      aItemWindowMightLabelText ; 89/BACD

        .enc "SJIS"
        .text "いりょく"
        .word $0000
        .enc "none"

      aItemWindowRangeLabelText ; 89/BAD7

        .enc "SJIS"
        .text "しゃてい"
        .word $0000
        .enc "none"

      aItemWindowWeightLabelText ; 89/BAE1

        .enc "SJIS"
        .text "おもさ"
        .word $0000
        .enc "none"

      aItemWindowItemLabelText ; 89/BAE9

        .enc "SJIS"
        .text "アイテム"
        .word $0000
        .enc "none"


    .endsection Table89BAC1Section


    .section Unsorted89BAF3Section

      .al
      .xl

      rsItemWindowClearItemInfo ; 89/BAF3

        .al
        .xl
        .autsiz
        .databank ?

        lda #$00CE
        ldx #$0016

        _BAF9
        sta $7E856E,x
        dec x
        dec x
        bne _BAF9
        ldx #$0016

        _BB04
        sta $7E85AE,x
        dec x
        dec x
        bne _BB04
        ldx #$0016

        _BB0F
        sta $7E85EE,x
        dec x
        dec x
        bne _BB0F
        ldx #$0016

        _BB1A
        sta $7E862E,x
        dec x
        dec x
        bne _BB1A
        ldx #$0016

        _BB25
        sta $7E866E,x
        dec x
        dec x
        bne _BB25
        ldx #$0016

        _BB30
        sta $7E86AE,x
        dec x
        dec x
        bne _BB30
        ldx #$0016

        _BB3B
        sta $7E86EE,x
        dec x
        dec x
        bne _BB3B
        ldx #$0016

        _BB46
        sta $7E872E,x
        dec x
        dec x
        bne _BB46
        ldx #$0016

        _BB51
        sta $7E876E,x
        dec x
        dec x
        bne _BB51
        ldx #$0016

        _BB5C
        sta $7E87AE,x
        dec x
        dec x
        bne _BB5C
        ldx #$0016

        _BB67
        sta $7E87EE,x
        dec x
        dec x
        bne _BB67
        ldx #$0016

        _BB72
        sta $7E882E,x
        dec x
        dec x
        bne _BB72
        ldx #$0016

        _BB7D
        sta $7E886E,x
        dec x
        dec x
        bne _BB7D
        ldx #$0016

        _BB88
        sta $7E88AE,x
        dec x
        dec x
        bne _BB88
        ldx #$0016

        _BB93
        sta $7E88EE,x
        dec x
        dec x
        bne _BB93
        ldx #$0016

        _BB9E
        sta $7E892E,x
        dec x
        dec x
        bne _BB9E
        ldx #$0016

        _BBA9
        sta $7E896E,x
        dec x
        dec x
        bne _BBA9
        rts

        .databank 0

        ; 89/BBB2

    .endsection Unsorted89BAF3Section


    .section Unsorted89BBB2Section

      .al
      .xl

      rsItemWindowRenderItemIcons ; 89/BBB2

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; The icon sprites of the visible rows.

        lda wItemWindowItemCount
        cmp #$000D
        bpl _BC07
        lda #$0000
        sta wItemWindowLoopIndex

        _BBC2
        lda wItemWindowLoopIndex
        tax
        lda aItemWindowList,x
        and #$00FF
        beq _BC06
        asl a
        tax
        lda aItemWindowItemIcons,x
        sta wR4
        lda #$0000
        sta wR5
        lda #$000F
        sta wR0
        lda wItemWindowLoopIndex
        asl a
        tax
        lda aItemWindowRowYCoordinates,x
        clc
        adc #$0002
        sta wR1
        phk
        plb
        .databank $89
        ldy #<>aItemWindowItemIconSprite
        jsl rlPushToOAMBuffer
        lda wItemWindowLoopIndex
        inc a
        sta wItemWindowLoopIndex
        bra _BBC2


        _BC06
        rts


        _BC07
        lda wItemWindowScrollOffset
        and #$0001
        bne _BC6F
        lda wItemWindowScrollOffset
        lsr a
        sta wItemWindowLoopIndex
        lda #$0000
        sta wItemWindowLoopCount

        _BC20
        lda wItemWindowLoopIndex
        tax
        lda aItemWindowList,x
        and #$00FF
        asl a
        tax
        lda aItemWindowItemIcons,x
        sta wR4
        lda #$0000
        sta wR5
        lda #$000F
        sta wR0
        lda wItemWindowLoopCount
        asl a
        tax
        lda @l aItemWindowRowYCoordinates,x
        clc
        adc #$0002
        sta wR1
        phk
        plb
        .databank $89
        ldy #<>aItemWindowItemIconSprite
        jsl rlPushToOAMBuffer
        lda wItemWindowLoopIndex
        inc a
        sta wItemWindowLoopIndex
        lda wItemWindowLoopCount
        inc a
        sta wItemWindowLoopCount
        cmp #$000C
        bne _BC20
        rts


        _BC6F
        lda wItemWindowScrollOffset
        lsr a
        sta wItemWindowLoopIndex
        lda #$0000
        sta wItemWindowLoopCount

        _BC7F
        lda wItemWindowLoopIndex
        tax
        lda aItemWindowList,x
        and #$00FF
        asl a
        tax
        lda aItemWindowItemIcons,x
        sta wR4
        lda #$0000
        sta wR5
        lda #$000F
        sta wR0
        lda wItemWindowLoopCount
        asl a
        tax
        lda @l aItemWindowIconRowY,x
        sec
        sbc #$0006
        sta wR1
        phk
        plb
        .databank $89
        ldy #<>aItemWindowItemIconSprite
        jsl rlPushToOAMBuffer
        lda wItemWindowLoopIndex
        inc a
        sta wItemWindowLoopIndex
        lda wItemWindowLoopCount
        inc a
        sta wItemWindowLoopCount
        cmp #$000D
        bne _BC7F
        rts

        .databank 0

        ; 89/BCCE

    .endsection Unsorted89BBB2Section


    .section Table89BCCESection

      .al
      .xl

      aItemWindowRowYCoordinates ; 89/BCCE

        ; Read by rsItemWindowRenderItemIcons.

        .word $0018, $0028, $0038, $0048, $0058, $0068, $0078, $0088
        .word $0098, $00A8, $00B8, $00C8

        ; 89/BCE6

    .endsection Table89BCCESection


    .section Data89BCE6Section

      .al
      .xl

      aItemWindowIconRowY ; 89/BCE6

        ; Read by rsItemWindowRenderItemIcons.

        .word $0018, $0028, $0038, $0048, $0058, $0068, $0078, $0088
        .word $0098, $00A8, $00B8, $00C8, $00D8

        ; 89/BD00

    .endsection Data89BCE6Section


    .section Unsorted89BD00Section

      .al
      .xl

      rsItemWindowRenderSelectedItemSprites ; 89/BD00

        .al
        .xl
        .autsiz
        .databank ?

        ; The selected item's icon and weapon rank sprites.

        phk
        plb
        .databank $89
        lda wGameStateStep,b
        cmp #$0000
        beq _BD24
        cmp #$0004
        beq _BD24
        jsl rlGetItemWeaponType
        sta wItemWindowLoopIndex
        jsl rlGetItemEquipmentType
        cmp #$0000
        beq _BD82
        jml _BE48


        _BD24
        lda wItemWindowSelectedItemIcon
        sta wR4
        lda #$0000
        sta wR5
        lda #$0098
        sta wR0
        lda #$003A
        sta wR1
        ldy #<>aItemWindowSelectedItemIconSprite
        jsl rlPushToOAMBuffer
        jsl rlGetItemEquipmentType
        cmp #$0000
        beq _BD52
        cmp #$0001
        beq _BD61
        jml _BE48


        _BD52
        stz wR0
        stz wR1
        stz wR4
        stz wR5
        ldy #<>aItemWindowWeaponBadgeSprite
        jsl rlPushToOAMBuffer

        _BD61
        jsl rlGetItemWeaponType
        sta wItemWindowLoopIndex
        ldx #$0004
        jsl rlUnitWindowCopyWeaponRankIcon
        lda #$0004
        sta wR4
        stz wR5
        stz wR0
        stz wR1
        ldy #<>aItemWindowWeaponTypeIconSprite
        jsl rlPushToOAMBuffer

        _BD82
        lda wItemWindowLoopIndex
        cmp #$0005
        bpl _BDD2
        cmp #$0003
        bmi _BD94
        jml _BE48


        _BD94
        lda wItemWindowLoopIndex
        asl a
        asl a
        sta wItemWindowLoopIndex
        tax
        lda @l aItemWindowWeaponTriangleTypes,x
        ldx #$0006
        jsl rlUnitWindowCopyWeaponRankIcon
        lda wItemWindowLoopIndex
        tax
        lda @l aItemWindowWeaponTriangleTypes+2,x
        ldx #$0008
        jsl rlUnitWindowCopyWeaponRankIcon
        lda #$009A
        sta wR1
        lda #$0000
        sta wR0
        sta wR4
        sta wR5
        phk
        plb
        .databank $89
        ldy #<>aItemWindowWeaponTriangleSprites
        jsl rlPushToOAMBuffer
        rts


        _BDD2
        cmp #$0008
        bpl _BE14
        lda wItemWindowLoopIndex
        sec
        sbc #$0005
        asl a
        asl a
        sta wItemWindowLoopIndex
        tax
        lda @l aItemWindowMagicTriangleTypes,x
        ldx #$0006
        jsl rlUnitWindowCopyWeaponRankIcon
        lda wItemWindowLoopIndex
        tax
        lda @l aItemWindowMagicTriangleTypes+2,x
        ldx #$0008
        jsl rlUnitWindowCopyWeaponRankIcon
        lda #$009A
        sta wR1
        stz wR0
        stz wR4
        stz wR5
        ldy #<>aItemWindowMagicTriangleSprites
        jsl rlPushToOAMBuffer
        rts


        _BE14
        lda #$0005
        ldx #$0006
        jsl rlUnitWindowCopyWeaponRankIcon
        lda #$0006
        ldx #$0008
        jsl rlUnitWindowCopyWeaponRankIcon
        lda #$0007
        ldx #$000A
        jsl rlUnitWindowCopyWeaponRankIcon
        lda #$009A
        sta wR1
        lda #$0080
        sta wR0
        stz wR4
        stz wR5
        ldy #<>aItemWindowAnimaIconsSprites
        jsl rlPushToOAMBuffer
        rts


        _BE48
        rts

        .databank 0

        ; 89/BE49


      aItemWindowSelectedItemIconSprite ; 89/BE49

        _Sprites := [[(   0,    0), $21, SpriteLarge, $020, 3, 3, false, false]]

        .structSpriteArray aItemWindowSelectedItemIconSprite._Sprites

      aItemWindowWeaponBadgeSprite ; 89/BE50

        ; Pushed only when the selected item is a weapon (equipment type 0); one
        ; large sprite, tile $0E, at (195, 76). What it shows is not known.

        _Sprites := [[( 195,   76), $21, SpriteLarge, $00E, 3, 0, false, false]]

        .structSpriteArray aItemWindowWeaponBadgeSprite._Sprites

    .endsection Unsorted89BD00Section


    .section Data89BE57Section

      .al
      .xl

      aItemWindowWeaponTriangleTypes ; 89/BE57

        ; For a selected sword, lance or axe (weapon types 0-2), the two other
        ; types, each shown as a weapon rank icon in aItemWindowWeaponTriangleSprites
        ; (two words per type). Read by rsItemWindowRenderSelectedItemSprites.

        .word $0002, $0001, $0000, $0002, $0001, $0000

        ; 89/BE63

      aItemWindowMagicTriangleTypes ; 89/BE63

        ; Like aItemWindowWeaponTriangleTypes for fire, thunder and wind (weapon
        ; types 5-7): two weapon types per type, read by rsItemWindowRenderSelectedItemSprites.

        .word $0007, $0006, $0005, $0007, $0006, $0005

      aItemWindowWeaponTypeIconSprite ; 89/BE6F

        _Sprites := [[( 159,   73), $21, SpriteLarge, $000, 3, 4, false, false]]

        .structSpriteArray aItemWindowWeaponTypeIconSprite._Sprites

        ; 89/BE76

      aItemWindowWeaponTriangleSprites ; 89/BE76

        _Sprites := [[( 165,    0), $21, SpriteLarge, $000, 3, 0, false, false]]
        _Sprites ..= [[( 204,    0), $21, SpriteLarge, $000, 3, 0, false, true]]
        _Sprites ..= [[( 181,    0), $21, SpriteLarge, $006, 3, 4, false, false]]
        _Sprites ..= [[( 220,    0), $21, SpriteLarge, $008, 3, 4, false, false]]

        .structSpriteArray aItemWindowWeaponTriangleSprites._Sprites

        ; 89/BE8C

      aItemWindowMagicTriangleSprites ; 89/BE8C

        _Sprites := [[( 165,    0), $21, SpriteLarge, $000, 3, 0, false, false]]
        _Sprites ..= [[( 204,    0), $21, SpriteLarge, $000, 3, 0, false, true]]
        _Sprites ..= [[( 181,    0), $21, SpriteLarge, $006, 3, 4, false, false]]
        _Sprites ..= [[( 220,    0), $21, SpriteLarge, $008, 3, 4, false, false]]

        .structSpriteArray aItemWindowMagicTriangleSprites._Sprites

        ; 89/BEA2

      aItemWindowAnimaIconsSprites ; 89/BEA2

        _Sprites := [[(  37,    0), $21, SpriteLarge, $000, 3, 0, false, false]]
        _Sprites ..= [[(  55,    0), $21, SpriteLarge, $006, 3, 4, false, false]]
        _Sprites ..= [[(  73,    0), $21, SpriteLarge, $008, 3, 4, false, false]]
        _Sprites ..= [[(  91,    0), $21, SpriteLarge, $00A, 3, 4, false, false]]

        .structSpriteArray aItemWindowAnimaIconsSprites._Sprites

        ; 89/BEB8

    .endsection Data89BE57Section


    .section Unsorted89BEB8Section

      .al
      .xl

      rsItemWindowRenderCursor ; 89/BEB8

        .al
        .xl
        .autsiz
        .databank ?

        lda wItemWindowCursorYCoordinate
        dec a
        sta wR1
        lda #$0001
        sta wR0
        lda wGameStateStep,b
        jsl rlDrawHandCursor
        rts

        .databank 0

        ; 89/BECC

    .endsection Unsorted89BEB8Section


    .section Unsorted89BEEBSection

      .al
      .xl

      rsItemWindowMoveToNextPage ; 89/BEEB

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda wItemWindowScrollOffset
        clc
        adc #$0018
        lsr a
        cmp wItemWindowMaxScroll
        beq _BEFC
        bcs _BF25

        _BEFC
        lda wItemWindowScrollOffset
        clc
        adc #$0018
        sta wItemWindowScrollOffset
        lda wItemWindowCurrentLine
        clc
        adc #$000C
        sta wItemWindowCurrentLine
        jsl rlItemWindowCopyVisibleRows
        jsl rlItemWindowDrawItemInfo
        lda wBufferBG2VOFS
        clc
        adc #$0008
        sta wBufferBG2VOFS
        rts


        _BF25
        lda wItemWindowScrollOffset
        lsr a
        cmp wItemWindowMaxScroll
        beq _BF5C
        lda wItemWindowMaxScroll
        asl a
        sta wItemWindowScrollOffset
        lda wItemWindowScrollOffset
        lsr a
        clc
        adc wItemWindowCursorRow
        clc
        adc #$0001
        sta wItemWindowCurrentLine
        jsl rlItemWindowCopyVisibleRows
        jsl rlItemWindowDrawItemInfo
        lda wBufferBG2VOFS
        clc
        adc #$0008
        sta wBufferBG2VOFS
        rts


        _BF5C
        lda wItemWindowItemCount
        sta wItemWindowCurrentLine
        lda wItemWindowItemCount
        cmp #$000D
        bcs _BF8B
        lda wItemWindowItemCount
        dec a
        sta wItemWindowCursorRow
        asl a
        asl a
        asl a
        asl a
        clc
        adc #$001C
        sta wItemWindowCursorYCoordinate
        jsl rlItemWindowCopyVisibleRows
        jsl rlItemWindowDrawItemInfo
        rts


        _BF8B
        lda #$000B
        sta wItemWindowCursorRow
        asl a
        asl a
        asl a
        asl a
        clc
        adc #$001C
        sta wItemWindowCursorYCoordinate
        jsl rlItemWindowCopyVisibleRows
        jsl rlItemWindowDrawItemInfo
        rts

        .databank 0

        ; 89/BFA7

      rsItemWindowMoveToPreviousPage ; 89/BFA7

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda wItemWindowScrollOffset
        sec
        sbc #$0018
        beq _BFF8
        bpl _BFF8
        lda wItemWindowScrollOffset
        beq _BFDA
        lda #$0000
        sta wItemWindowScrollOffset
        lda wItemWindowCursorRow
        inc a
        sta wItemWindowCurrentLine
        jsl rlItemWindowCopyVisibleRows
        jsl rlItemWindowDrawItemInfo
        lda wBufferBG2VOFS
        clc
        adc #$0008
        sta wBufferBG2VOFS
        rts


        _BFDA
        lda #$0001
        sta wItemWindowCurrentLine
        lda #$0000
        sta wItemWindowCursorRow
        lda #$001C
        sta wItemWindowCursorYCoordinate
        jsl rlItemWindowCopyVisibleRows
        jsl rlItemWindowDrawItemInfo
        rts


        _BFF8
        lda wItemWindowScrollOffset
        sec
        sbc #$0018
        sta wItemWindowScrollOffset
        lda wItemWindowCurrentLine
        sec
        sbc #$000C
        sta wItemWindowCurrentLine
        jsl rlItemWindowCopyVisibleRows
        jsl rlItemWindowDrawItemInfo
        lda wBufferBG2VOFS
        clc
        adc #$0008
        sta wBufferBG2VOFS
        rts

        .databank 0

        ; 89/C021

    .endsection Unsorted89BEEBSection


    .section Unsorted89C021Section

      .al
      .xl

      rlItemWindowDrawList ; 89/C021

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Builds the tilemap of the whole list in aItemWindowListTilemap.

        lda #$0000
        ldx #$2580

        _C027
        sta $7F89CE,x
        dec x
        dec x
        bne _C027
        lda #(`aItemWindowListTilemapEntry)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aItemWindowListTilemapEntry
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$0000
        sta wItemWindowLoopIndex

        _C042
        lda wItemWindowLoopIndex
        tax
        lda aItemWindowList,x
        and #$00FF
        asl a
        tax
        lda aItemWindowItemRAMPointers,x
        sta wCurrentItemDataRAMPointer,b
        lda aItemWindowItemROMPointers,x
        sta wCurrentItemDataROMPointer,b
        jsl rlGetItemRAMStateAndOwner
        lda wR0
        cmp #$0001
        beq _C08E
        cmp #$0002
        beq _C072
        jml _C0F9


        _C072
        lda wItemWindowLoopIndex
        asl a
        asl a
        asl a
        asl a
        asl a
        asl a
        ora #$001E
        tax
        lda #$3DE3
        sta aItemWindowListTilemap,x
        lda #$3DF3
        sta $7F89F0,x

        _C08E
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda wR1
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitNamePointer
        lda lRoutineVariable+1,b
        sta lR18+1
        lda lRoutineVariable,b
        sta lR18
        lda wItemWindowLoopIndex
        asl a
        and #$00FF
        xba
        ora #$000A
        tax
        jsl rlDrawMenuTextLine
        jsl rlGetItemEquipmentType
        cmp #$0000
        beq _C0CE
        cmp #$0001
        bne _C0DA
        jsl rlCheckStaffEquippable
        bcs _C0DA
        bra _C0D4


        _C0CE
        jsl rlCheckWeaponEquippable
        bcs _C0DA

        _C0D4
        lda #$2400
        sta aCurrentTilemapInfo,b

        _C0DA
        jsl rlGetItemNamePointer
        lda wItemWindowLoopIndex
        asl a
        and #$00FF
        xba
        ora #$0002
        tax
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        jsl rlDrawMenuTextLine

        _C0F9
        lda wItemWindowLoopIndex
        inc a
        sta wItemWindowLoopIndex
        cmp wItemWindowItemCount
        beq _C10C
        jml _C042


        _C10C
        lda #(`aItemWindowBG3TilemapEntry)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aItemWindowBG3TilemapEntry
        sta lMapMenuTilemapRAMEntryPointer,b
        rtl

        .databank 0

        ; 89/C119

    .endsection Unsorted89C021Section


    .section Unsorted89C144Section

      .al
      .xl

      rsItemWindowRenderScrollArrows ; 89/C144

        .al
        .xl
        .autsiz
        .databank ?

        lda wItemWindowItemCount
        cmp #$000D
        bmi _C180
        lda wVBlankEnabledFramecount
        and #$0008
        beq _C180
        stz wR0
        stz wR4
        stz wR5
        lda #$0080
        sta wR1
        ldy #$0000
        lda wItemWindowScrollOffset
        lsr a
        cmp wItemWindowMaxScroll
        beq _C176
        inc y
        inc y
        cmp #$0000
        bne _C176
        inc y
        inc y

        _C176
        phk
        plb
        .databank $89
        lda $C181,b,y
        tay
        jsl rlPushToOAMBuffer

        _C180
        rts

        .databank 0

        ; 89/C181

    .endsection Unsorted89C144Section


    .section Data89C181Section

      .al
      .xl

      aItemWindowScrollArrowSprites ; 89/C181

        ; Read by rsItemWindowRenderScrollArrows.

        .word $C187, $C18E, $C19A, $0001, $C241, $0C8F, $02B0, $4100
        .word $8FC2, $B00C, $C241, $0C52, $0130, $4100, $52C2, $300C

        ; 89/C1A1

    .endsection Data89C181Section


    .section Unsorted89C1A1Section

      .al
      .xl

      rsItemWindowDrawItemDescription ; 89/C1A1

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aItemWindowDescTilemapEntry)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aItemWindowDescTilemapEntry
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$0000
        ldx #$00C0

        _C1B3
        sta $7FAF4E,x
        dec x
        dec x
        bne _C1B3
        jsl rlGetItemDescriptionPointer
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$0000
        jsl rlDrawMenuTextLine
        lda #(`aItemWindowBG3TilemapEntry)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aItemWindowBG3TilemapEntry
        sta lMapMenuTilemapRAMEntryPointer,b
        ldx #$0000

        _C1DF
        lda $7FAF50,x
        sta $7E8672,x
        lda $7FAFB0,x
        sta $7E86B2,x
        inc x
        inc x
        cpx #$0010
        bne _C1DF
        ldx #$0000

        _C1F9
        lda $7FAF60,x
        sta $7E86F2,x
        lda $7FAFC0,x
        sta $7E8732,x
        inc x
        inc x
        cpx #$0010
        bne _C1F9
        ldx #$0000

        _C213
        lda $7FAF70,x
        sta $7E8772,x
        lda $7FAFD0,x
        sta $7E87B2,x
        inc x
        inc x
        cpx #$0010
        bne _C213
        ldx #$0000

        _C22D
        lda $7FAF80,x
        sta $7E87F2,x
        lda $7FAFE0,x
        sta $7E8832,x
        inc x
        inc x
        cpx #$0010
        bne _C22D
        ldx #$0000

        _C247
        lda $7FAF90,x
        sta $7E8872,x
        lda $7FAFF0,x
        sta $7E88B2,x
        inc x
        inc x
        cpx #$0010
        bne _C247
        ldx #$0000

        _C261
        lda $7FAFA0,x
        sta $7E88F2,x
        lda $7FB000,x
        sta $7E8932,x
        inc x
        inc x
        cpx #$0010
        bne _C261
        rts

        .databank 0

        ; 89/C279

      rsItemWindowDrawItemDescription2 ; 89/C279

        .al
        .xl
        .autsiz
        .databank ?

        ; The same text as rsItemWindowDrawItemDescription, drawn lower in the window.

        lda #(`aItemWindowDescTilemapEntry)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aItemWindowDescTilemapEntry
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$0000
        ldx #$00C0

        _C28B
        sta $7FAF4E,x
        dec x
        dec x
        bne _C28B
        jsl rlGetItemDescriptionPointer
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$0000
        jsl rlDrawMenuTextLine
        lda #(`aItemWindowBG3TilemapEntry)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aItemWindowBG3TilemapEntry
        sta lMapMenuTilemapRAMEntryPointer,b
        ldx #$0000

        _C2B7
        lda $7FAF50,x
        sta $7E88F2,x
        lda $7FAFB0,x
        sta $7E8932,x
        inc x
        inc x
        cpx #$0010
        bne _C2B7
        rts

        .databank 0

        ; 89/C2CF

    .endsection Unsorted89C1A1Section


    .section Unsorted89C2CFSection

      .al
      .xl

      rlItemWindowSort ; 89/C2CF

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Picks the sort mode (wItemWindowSortMode: 0 owner, 1 type, 2 name) from aItemWindowNextSortModes, scores and sorts the list, then redraws it.

        lda wItemWindowSortMode
        asl a
        asl a
        ora wItemWindowSortPanelRow
        tax
        lda aItemWindowNextSortModes,x
        and #$00FF
        sta wItemWindowSortMode
        lda wItemWindowSortMode
        cmp #$0003
        bmi _C2F0

        _C2EE
        bra _C2EE


        _C2F0
        asl a
        tax
        jsr (aItemWindowSortScoreRoutines,x)
        jsl rlItemWindowSortList
        jsl rlItemWindowGetItemData
        jsl rlItemWindowDrawList
        lda wGameStateStep,b
        beq _C325
        lda #$0000
        sta wItemWindowSortPanelRow
        jsl rlItemWindowDrawItemInfo
        ldx #$01EA
        lda #$0004
        ldy #$0009
        jsl rlClearTilemapRect
        jsl rlItemWindowCopyVisibleRows
        jsr rsItemWindowDrawSortPanel

        _C325
        rtl

        .databank 0

        ; 89/C326

      aItemWindowSortScoreRoutines ; 89/C326

        .word <>rsItemWindowGetOwnerSortScores
        .word <>rsItemWindowGetTypeSortScores
        .word <>rsItemWindowGetNameSortScores

        ; 89/C32C

      aItemWindowNextSortModes ; 89/C32C

        ; Three rows of four, read by rlItemWindowSort at (A * 4) | $7F847D. The byte read
        ; picks the routine in aItemWindowSortScoreRoutines; $FF (or anything from 3 up) makes it hang.

        .byte $00, $01, $02, $FF
        .byte $01, $02, $00, $FF
        .byte $02, $00, $01, $FF

        ; 89/C338

      rsItemWindowGetOwnerSortScores ; 89/C338

        .al
        .xl
        .autsiz
        .databank ?

        ; Scores by the owner's character ID.

        ldy #$0000

        _C33B
        tyx
        lda aItemWindowList,x
        and #$00FF
        asl a
        tax
        lda aItemWindowItemRAMPointers,x
        sta wCurrentItemDataRAMPointer,b
        jsl rlGetItemRAMStateAndOwner
        lda wR0
        cmp #$0001
        beq _C368
        lda wR1
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitCharacterID
        asl a
        ora #$0001
        sta wR0
        bra _C374


        _C368
        lda wR1
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitCharacterID
        asl a
        sta wR0

        _C374
        tya
        asl a
        tax
        lda wR0
        eor #$FFFF
        inc a
        sta aItemWindowSortScores,x
        inc y
        tya
        cmp wItemWindowItemCount
        bne _C33B
        rts

        .databank 0

        ; 89/C38A

      rsItemWindowGetTypeSortScores ; 89/C38A

        .al
        .xl
        .autsiz
        .databank ?

        ; Scores by the item's place in the game's item order (table at $89C66E, by item ID).

        ldy #$0000

        _C38D
        tyx
        lda aItemWindowList,x
        and #$00FF
        asl a
        tax
        lda aItemWindowItemRAMPointers,x
        sta wCurrentItemDataRAMPointer,b
        jsl rlGetEffectiveItemIDByItemRAMStructEntry
        tax
        lda aItemTypeSortRanks,x
        and #$00FF
        pha
        tya
        asl a
        tax
        pla
        sta aItemWindowSortScores,x
        inc y
        tya
        cmp wItemWindowItemCount
        bne _C38D
        rts

        rts

        .databank 0

        ; 89/C3BD

      rsItemWindowGetNameSortScores ; 89/C3BD

        .al
        .xl
        .autsiz
        .databank ?

        ; Scores by the table at $89C5E4, by item ID, which looks like the kana order of the names (the broken weapons share a value).

        ldy #$0000

        _C3C0
        tyx
        lda aItemWindowList,x
        and #$00FF
        asl a
        tax
        lda aItemWindowItemRAMPointers,x
        sta wCurrentItemDataRAMPointer,b
        jsl rlGetEffectiveItemIDByItemRAMStructEntry
        tax
        lda aItemWindowNameSortScores,x
        and #$00FF
        eor #$FFFF
        inc a
        pha
        tya
        asl a
        tax
        pla
        sta aItemWindowSortScores,x
        inc y
        tya
        cmp wItemWindowItemCount
        bne _C3C0
        rts

        .databank 0

        ; 89/C3F3

    .endsection Unsorted89C2CFSection


    .section Unsorted89C3F3Section

      .al
      .xl

      rlItemWindowSortList ; 89/C3F3

        .al
        .xl
        .autsiz
        .databank ?

        ; Sorts aItemWindowList by aItemWindowSortScores.

        lda wItemWindowItemCount
        cmp #$0001
        beq _C435
        asl a
        sta wR15
        sec
        sbc #$0002
        sta wR14
        lda #$007F
        sep #$20
        pha
        rep #$20
        plb
        .databank $7F
        ldx #$0000

        _C411
        txy
        inc y
        inc y

        _C414
        lda @l aItemWindowSortScores,x
        cmp $88A4,b,y
        bcs _C429
        phx
        phy
        txa
        lsr a
        tax
        tya
        lsr a
        jsr rsItemWindowMoveListEntry
        ply
        plx

        _C429
        inc y
        inc y
        cpy wR15
        bne _C414
        inc x
        inc x
        cpx wR14
        bne _C411

        _C435
        phk
        plb
        .databank $89
        rtl

        .databank 0

        ; 89/C438

      rsItemWindowMoveListEntry ; 89/C438

        .al
        .xl
        .autsiz
        .databank ?

        ; Moves one entry of the list and of the scores, shifting the ones between.

        sta wR0
        cpx wR0
        bpl _C441
        tay
        txa
        tyx

        _C441
        sta wR1
        asl a
        sta wR3
        txa
        sta wR2
        asl a
        sta wR4
        sep #$20
        ldx wR2
        lda aItemWindowList,x
        sta wR0

        _C456
        lda $7F8482,x
        sta aItemWindowList,x
        dec x
        cpx wR1
        bne _C456
        lda wR0
        sta aItemWindowList,x
        rep #$20
        ldx wR4
        lda aItemWindowSortScores,x
        sta wR0

        _C473
        lda $7F88A2,x
        sta aItemWindowSortScores,x
        dec x
        dec x
        cpx wR3
        bne _C473
        lda wR0
        sta aItemWindowSortScores,x
        rts

        .databank 0

        ; 89/C488

    .endsection Unsorted89C3F3Section


    .section Unsorted89C488Section

      .al
      .xl

      rsItemWindowDrawSortPanel ; 89/C488

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Draws the sort panel for the current mode.

        lda wItemWindowSortMode
        beq _C493
        dec a
        beq _C4F0
        bra _C497


        _C493
        jml _C549


        _C497
        lda #$2000
        sta wR1
        lda #$01E0
        sta wR2
        lda #$0003
        sta wR0
        ldx #$012E
        jsl rlDrawBG3TileRun
        lda #$2000
        sta wR1
        lda #$01CF
        sta wR2
        lda #$0001
        sta wR0
        ldx #$0134
        jsl rlDrawBG3TileRun
        lda #$2000
        sta wR1
        lda #$01C8
        sta wR2
        lda #$0004
        sta wR0
        ldx #$01AE
        jsl rlDrawBG3TileRun
        lda #$2000
        sta wR1
        lda #$01CC
        sta wR2
        lda #$0004
        sta wR0
        ldx #$022E
        jsl rlDrawBG3TileRun
        rts


        _C4F0
        lda #$2000
        sta wR1
        lda #$01CC
        sta wR2
        lda #$0004
        sta wR0
        ldx #$012E
        jsl rlDrawBG3TileRun
        lda #$2000
        sta wR1
        lda #$01E0
        sta wR2
        lda #$0003
        sta wR0
        ldx #$01AE
        jsl rlDrawBG3TileRun
        lda #$2000
        sta wR1
        lda #$01CF
        sta wR2
        lda #$0001
        sta wR0
        ldx #$01B4
        jsl rlDrawBG3TileRun
        lda #$2000
        sta wR1
        lda #$01C8
        sta wR2
        lda #$0004
        sta wR0
        ldx #$022E
        jsl rlDrawBG3TileRun
        rts


        _C549
        lda #$2000
        sta wR1
        lda #$01C8
        sta wR2
        lda #$0004
        sta wR0
        ldx #$012E
        jsl rlDrawBG3TileRun
        lda #$2000
        sta wR1
        lda #$01CC
        sta wR2
        lda #$0004
        sta wR0
        ldx #$01AE
        jsl rlDrawBG3TileRun
        lda #$2000
        sta wR1
        lda #$01E0
        sta wR2
        lda #$0003
        sta wR0
        ldx #$022E
        jsl rlDrawBG3TileRun
        lda #$2000
        sta wR1
        lda #$01CF
        sta wR2
        lda #$0001
        sta wR0
        ldx #$0234
        jsl rlDrawBG3TileRun
        rts

        .databank 0

        ; 89/C5A2

    .endsection Unsorted89C488Section


    .section Unsorted89C5A2Section

      .al
      .xl

      rsItemWindowDrawWeaponRank ; 89/C5A2

        .al
        .xl
        .autsiz
        .databank ?

        ; A: weapon rank (4 for none), X, Y: tile position. Draws its 2x2 letter from aItemWindowWeaponRankTiles.

        pha
        tya
        xba
        lsr a
        lsr a
        sta wR0
        txa
        asl a
        clc
        adc wR0
        tay
        pla
        asl a
        asl a
        tax
        lda aItemWindowWeaponRankTiles,x
        phx
        tyx
        sta aBG3TilemapBuffer,x
        txy
        plx
        lda aItemWindowWeaponRankTiles+2,x
        tyx
        sta $7E83C8,x
        rts

        .databank 0

        ; 89/C5C9

    .endsection Unsorted89C5A2Section


    .section Data89C5C9Section

      .al
      .xl

      aItemWindowWeaponRankTiles ; 89/C5C9

        ; Read by rsItemWindowDrawWeaponRank.

        .byte $2A, $39, $3A, $39, $2B, $39, $3B, $39, $2C, $39, $3C, $39, $FF, $38, $09, $39
        .byte $E4, $39, $F4, $39

      aItemWindowItemIconSprite ; 89/C5DD

        _Sprites := [[(   0,    0), $21, SpriteLarge, $020, 2, 3, false, false]]

        .structSpriteArray aItemWindowItemIconSprite._Sprites

        ; 89/C5E4

      aItemWindowNameSortScores ; 89/C5E4

        ; Read by rsItemWindowGetNameSortScores.

        .word $4133, $3211, $1040, $3704, $452A, $1E5A, $5128, $5356
        .word $012B, $4A0B, $2F57, $2148, $192E, $1919, $4234, $3612
        .word $5B3C, $1452, $1A16, $1A1A, $3F31, $590F, $3029, $1717
        .word $3517, $1343, $0E5C, $1B02, $1B1B, $006D, $150D, $094B
        .word $4C54, $1F58, $3A08, $2038, $0705, $4E39, $5E4F, $0A64
        .word $5D3B, $504D, $0C6C, $0C0C, $6860, $6761, $6563, $696E
        .word $6A2C, $1D47, $4427, $1822, $1818, $065F, $0323, $622D
        .word $3D3E, $2666, $4955, $4624, $256B, $1A19, $0C1B, $0C0C
        .word $0C0C, $0C0C, $0C0C, $0C0C, $1C18

        ; 89/C66E

      aItemTypeSortRanks ; 89/C66E

        ; Read by rsItemWindowGetTypeSortScores, rsUnitWindowGetWeaponSortScores.

        .byte $FF, $FE, $FD, $FC, $FB, $FA, $F9, $F8, $F7, $F6, $F5, $F4, $F3, $F2, $F1, $F0
        .byte $EF, $EE, $ED, $EC, $EB, $EA, $E9, $E8, $E7, $E5, $E4, $E3, $E2, $E1, $E0, $DF
        .byte $DE, $DD, $DC, $DB, $DA, $D8, $D7, $D6, $D5, $D4, $D3, $D2, $D1, $D0, $CF, $CE
        .byte $CD, $CC, $CB, $CA, $C9, $C8, $C7, $C5, $C4, $C3, $C2, $C1, $C0, $BF, $BE, $BD
        .byte $BC, $BB, $BA, $B9, $B8, $B7, $B6, $B5, $B4, $B3, $B2, $B1, $B0, $AF, $AE, $AD
        .byte $AC, $AB, $AA, $A9, $A8, $A7, $A6, $A5, $99, $98, $97, $96, $95, $94, $93, $92
        .byte $91, $90, $8F, $8E, $8D, $8C, $8B, $89, $88, $87, $86, $85, $84, $83, $82, $81
        .byte $80, $7F, $7E, $7D, $7C, $7B, $7A, $79, $78, $77, $E6, $D9, $C6, $A4, $A3, $A2
        .byte $A1, $A0, $9F, $9E, $9D, $9C, $9B, $9A, $8A, $76, $75

        ; 89/C6F9

    .endsection Data89C5C9Section


    .section Unsorted89B79DSection

      .al
      .xl

      rsItemWindowSortPanel ; 89/B79D

        .al
        .xl
        .autsiz
        .databank ?

        ; Step $01, the sort panel: Up and Down choose a sort order (wItemWindowSortPanelRow), A sorts the list by it (rlItemWindowSort), B, Y or Left close the panel (step $00).

        jsr rsItemWindowRenderCursor
        lda wJoy1New
        bit #$C200
        bne _B7BC
        bit #$0080
        bne _B7EC
        lda wJoy1Repeated
        bit #$0800
        bne _B7FB
        bit #$0400
        bne _B818
        jsr rsItemWindowDrawSortCursor
        rts


        _B7BC
        lda #$0000
        sta wGameStateStep,b
        sta wItemWindowSortPanelRow
        ldx #$01AA
        lda #$0004
        ldy #$0009
        jsl rlClearTilemapRect
        jsl rlItemWindowDrawItemInfo
        jsl rlDMAByStruct

          .structDMAToVRAM aBG2TilemapBuffer, $02C0, $80, $4000

        lda #$0021
        jsl rlPlaySoundEffect
        rts


        _B7EC
        lda #$000A
        jsl rlPlaySoundEffect
        jsl rlItemWindowSort
        jsr rsItemWindowDrawSortCursor
        rts


        _B7FB
        lda wItemWindowSortPanelRow
        beq _B814
        dec a
        sta wItemWindowSortPanelRow
        lda #$0002
        sta wUnitWindowScrollingFlag
        lda #$0006
        jsl rlPlaySoundEffect

        _B814
        jsr rsItemWindowDrawSortCursor
        rts


        _B818
        lda wItemWindowSortPanelRow
        cmp #$0002
        beq _B834
        inc a
        sta wItemWindowSortPanelRow
        lda #$0004
        sta wUnitWindowScrollingFlag
        lda #$0006
        jsl rlPlaySoundEffect

        _B834
        jsr rsItemWindowDrawSortCursor
        rts

        .databank 0

        ; 89/B838

    .endsection Unsorted89B79DSection


    .section Unsorted89B838Section

      .al
      .xl

      rsItemWindowNoItems ; 89/B838

        .al
        .xl
        .autsiz
        .databank ?

        ; Step $02, with no items to list: B blanks the screen and closes to the map (step $03).

        lda wJoy1New
        bit #$8000
        bne _B840
        rts


        _B840
        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        lda #$0003
        sta wGameStateStep,b
        lda #$0021
        jsl rlPlaySoundEffect
        rts

        .databank 0

        ; 89/B856

    .endsection Unsorted89B838Section


    .section Unsorted89B869Section

      .al
      .xl

      rsItemWindowFadeToCastle ; 89/B869

        .al
        .xl
        .autsiz
        .databank ?

        ; Step $04: darkens one level a frame, then returns to the castle screen.

        sep #$20
        lda bBufferINIDISP
        sec
        sbc #$01
        sta bBufferINIDISP
        rep #$20
        bne _B882
        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        jsl rlReturnToCastleScreen

        _B882
        rts

        .databank 0

        ; 89/B883

    .endsection Unsorted89B869Section


    .section Unsorted89C119Section

      .al
      .xl

      rsItemWindowDrawSortCursor ; 89/C119

        .al
        .xl
        .autsiz
        .databank ?

        ; The hand cursor on the sort panel row, nudged up or down for one frame after a move (wUnitWindowScrollingFlag 2 or 4).

        lda wUnitWindowScrollingFlag
        tax
        lda wItemWindowSortPanelRow
        asl a
        asl a
        asl a
        asl a
        clc
        adc aItemWindowSortCursorY,x
        sta wR1
        lda #$00A5
        sta wR0
        lda #$0000
        sta wUnitWindowScrollingFlag
        jsl rlDrawHandCursor
        rts

        .databank 0

        ; 89/C13E

    .endsection Unsorted89C119Section


    .section Data89C13ESection

      .al
      .xl

      aItemWindowSortCursorY ; 89/C13E

        ; Read by rsItemWindowDrawSortCursor.

        .word $0022, $002A, $001A

        ; 89/C144

    .endsection Data89C13ESection


