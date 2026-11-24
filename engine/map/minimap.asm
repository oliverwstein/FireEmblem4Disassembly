; The minimap ("MG" proc, opened with Start): the whole map drawn as 2x2-pixel
; dots, coloured by terrain (aMinimapTerrainColors) and by army for the units,
; with a box showing the visible part. While it is open (bit 5 of wMapSystemFlags)
; rlMinimapStep scrolls the map under it. The Warp staff uses it to choose a
; castle (bit 11 of wChapterFlags): the D-pad then steps through the player's
; castles. "MC" closes it. Bank $88.


    .section ProcScript889396Section

      .al
      .xl

      procMinimap ; 88/9396

        .structProcInfo "MG", rlProcMinimapInit, rlProcMinimapClear, aProcMinimapCode

    .endsection ProcScript889396Section


    .section Unsorted88939ESection

      .al
      .xl

      rlProcMinimapInit ; 88/939E

        .al
        .xl
        .autsiz
        .databank ?

        ; Sets up the colour math and the minimap palette (aMinimapPaletteData).

        lda #$8B88
        sta aProcSystem.aBody0,b,x
        lda #$3000
        sta aProcSystem.aBody1,b,x
        lda #$0004
        sta aProcSystem.aBody2,b,x
        lda #(`aMinimapPaletteData)<<8
        sta lR19+1
        lda #<>aMinimapPaletteData
        sta lR19
        jsl rlApplyMapMenuPaletteData
        sep #$20
        lda #$17
        sta bBufferTM
        lda #$00
        sta bBufferCGWSEL
        lda #$BD
        sta bBufferCGADSUB
        lda #$20
        sta bBufferCOLDATA_1
        lda #$40
        sta bBufferCOLDATA_2
        lda #$80
        sta bBufferCOLDATA_3
        rep #$20
        rtl

        .databank 0

        ; 88/93DB

    .endsection Unsorted88939ESection


    .section Table8893DBSection

      .al
      .xl

      aMinimapPaletteData .dstruct structMapMenuPaletteData, $000F, 6, 1, aMinimapPalette ; 88/93DB

      aMinimapPalette ; 88/93E2
        .word $08A5, $1DC9, $1168, $3DEF, $2657, $0D2F, $0089, $6978
        .word $6289, $3945, $7BFF, $7E00, $001F, $03E0, $03FF

    .endsection Table8893DBSection


    .section Unsorted889400Section

      .al
      .xl

      rlProcMinimapClear ; 88/9400

        .al
        .xl
        .autsiz
        .databank ?

        ; Clears the minimap pixels (rlClearMinimap).

        jsl rlClearMinimap
        lda #<>rlProcMinimapDrawTerrain
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$1FFE
        sta aProcSystem.aBody2,b,x
        rtl

        .databank 0

        ; 88/9411

    .endsection Unsorted889400Section


    .section Unsorted889411Section

      .al
      .xl

      rlProcMinimapDrawTerrain ; 88/9411

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws $200 map tiles a frame (rlDrawMinimapTerrain), fading the screen as it goes.

        sep #$20
        lda #$BD
        sta bBufferCGADSUB
        inc bBufferCOLDATA_1
        inc bBufferCOLDATA_2
        inc bBufferCOLDATA_3
        rep #$20
        lda aProcSystem.aBody2,b,x
        sec
        sbc #$0400
        bpl _942B
        lda #$0000

        _942B
        sta wTempVariable1,b
        phx
        lda aProcSystem.aBody2,b,x
        tax
        jsl rlDrawMinimapTerrain
        txa
        plx
        sta aProcSystem.aBody2,b,x
        lda aProcSystem.aBody2,b,x
        bpl _9447
        lda #<>rlProcMinimapDrawUnits
        sta aProcSystem.aHeaderOnCycle,b,x

        _9447
        rtl

        .databank 0

        ; 88/9448

      rlProcMinimapDrawUnits ; 88/9448

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws the units (rlDrawMinimapUnits); when choosing a warp destination, shows the first castle.

        jsl rlDrawMinimapUnits
        lda #<>rlProcMinimapUpload
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0004
        sta aProcSystem.aBody2,b,x
        lda #$0019
        jsl rlPlaySoundEffect
        lda wChapterFlags,b
        bit #$0800
        beq _946A
        jsr rsMinimapShowWarpCastle

        _946A
        rtl

        .databank 0

        ; 88/946B

      rlProcMinimapUpload ; 88/946B

        .al
        .xl
        .autsiz
        .databank ?

        ; Copies the minimap pixels to VRAM, $800 bytes a frame for four frames.

        lda #$7E8B
        sta lR18+1
        lda aProcSystem.aBody0,b,x
        sta lR18
        clc
        adc #$0800
        sta aProcSystem.aBody0,b,x
        lda aProcSystem.aBody1,b,x
        sta wR1
        clc
        adc #$0400
        sta aProcSystem.aBody1,b,x
        lda #$0800
        sta wR0
        phx
        jsl rlDMAByPointer
        plx
        dec aProcSystem.aBody2,b,x
        bne _949E
        lda #<>rlProcMinimapDrawTilemap
        sta aProcSystem.aHeaderOnCycle,b,x

        _949E
        rtl

        .databank 0

        ; 88/949F

      rlProcMinimapDrawTilemap ; 88/949F

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws the minimap's tilemap (16x16 tiles, 16x8 in the prologue) and ends the proc.

        sep #$20
        rep #$20
        phx
        lda #$3BFF
        sta wR0
        ldx #$01FE

        _94AC
        txa
        lda wR0
        sta aEpilogueUnitStates,x
        dec wR0
        dec x
        dec x
        bpl _94AC
        lda wCurrentChapter,b
        beq _94CC
        lda #(`aMinimapTilemapInfo)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aMinimapTilemapInfo
        sta lMapMenuTilemapRAMEntryPointer,b
        bra _94D8


        _94CC
        lda #(`aMinimapPrologueTilemapInfo)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aMinimapPrologueTilemapInfo
        sta lMapMenuTilemapRAMEntryPointer,b

        _94D8
        ldx #$0190
        jsl rlCopyTilemapEntryToBG
        jsl rlDMAByStruct

          .structDMAToVRAM $7E7B88, $0800, $80, $A800

        plx
        jsl rlProcEngineFreeProc
        rtl

        .databank 0

        ; 88/94F2

    .endsection Unsorted889411Section


    .section Table8894F2Section

      .al
      .xl

      aMinimapTilemapInfo ; 88/94F2
        .byte $10, $10, $88, $7B, $7E, $00, $4A, $C5, $7F

      aMinimapPrologueTilemapInfo ; 88/94FB
        .byte $10, $08, $88, $7B, $7E, $00, $4A, $C5, $7F

    .endsection Table8894F2Section


    .section ProcScript889504Section

      .al
      .xl

      aProcMinimapCode ; 88/9504

        PROC_HALT


        ; 88/9506

    .endsection ProcScript889504Section


    .section Unsorted889506Section

      .al
      .xl

      rsPutMinimapDot ; 88/9506

        .al
        .xl
        .autsiz
        .databank ?

        ; ORs a 2x2 pixel dot of colour wR2 into the minimap pixels ($7E8B88) for map tile (wR0, wR1).

        php
        phx
        lda wR1
        and #$FFFC
        xba
        lsr a
        sta wR3
        lda wR0
        and #$FFFC
        asl a
        asl a
        asl a
        clc
        adc wR3
        sta wR3
        lda wR1
        and #$0003
        asl a
        asl a
        clc
        adc wR3
        tay
        lda wR2
        asl a
        tax
        lda wR0
        and #$0003
        asl a
        asl a
        clc
        adc aMinimapDotColorBits,x
        tax
        sep #$20
        lda $8B88,b,y
        ora aMinimapDotColorBits,x
        sta $8B88,b,y
        lda $8B89,b,y
        ora aMinimapDotColorBits+1,x
        sta $8B89,b,y
        lda $8B98,b,y
        ora aMinimapDotColorBits+2,x
        sta $8B98,b,y
        lda $8B99,b,y
        ora aMinimapDotColorBits+3,x
        sta $8B99,b,y
        lda $8B8A,b,y
        ora aMinimapDotColorBits,x
        sta $8B8A,b,y
        lda $8B8B,b,y
        ora aMinimapDotColorBits+1,x
        sta $8B8B,b,y
        lda $8B9A,b,y
        ora aMinimapDotColorBits+2,x
        sta $8B9A,b,y
        lda $8B9B,b,y
        ora aMinimapDotColorBits+3,x
        sta $8B9B,b,y
        plx
        plp
        .al
        rts

        .databank 0

        ; 88/958F

    .endsection Unsorted889506Section


    .section Table88958FSection

      .al
      .xl

      aMinimapDotColorBits ; 88/958F

        ; Read by rsPutMinimapDot.

        .word $0020, $0030, $0040, $0050, $0060, $0070, $0080, $0090
        .word $00A0, $00B0, $00C0, $00D0, $00E0, $00F0, $0100, $0110

        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $C0, $00, $00, $00, $30, $00, $00, $00, $0C, $00, $00, $00, $03, $00, $00, $00
        .byte $00, $C0, $00, $00, $00, $30, $00, $00, $00, $0C, $00, $00, $00, $03, $00, $00
        .byte $C0, $C0, $00, $00, $30, $30, $00, $00, $0C, $0C, $00, $00, $03, $03, $00, $00
        .byte $00, $00, $C0, $00, $00, $00, $30, $00, $00, $00, $0C, $00, $00, $00, $03, $00
        .byte $C0, $00, $C0, $00, $30, $00, $30, $00, $0C, $00, $0C, $00, $03, $00, $03, $00
        .byte $00, $C0, $C0, $00, $00, $30, $30, $00, $00, $0C, $0C, $00, $00, $03, $03, $00
        .byte $C0, $C0, $C0, $00, $30, $30, $30, $00, $0C, $0C, $0C, $00, $03, $03, $03, $00
        .byte $00, $00, $00, $C0, $00, $00, $00, $30, $00, $00, $00, $0C, $00, $00, $00, $03
        .byte $C0, $00, $00, $C0, $30, $00, $00, $30, $0C, $00, $00, $0C, $03, $00, $00, $03
        .byte $00, $C0, $00, $C0, $00, $30, $00, $30, $00, $0C, $00, $0C, $00, $03, $00, $03
        .byte $C0, $C0, $00, $C0, $30, $30, $00, $30, $0C, $0C, $00, $0C, $03, $03, $00, $03
        .byte $00, $00, $C0, $C0, $00, $00, $30, $30, $00, $00, $0C, $0C, $00, $00, $03, $03
        .byte $C0, $00, $C0, $C0, $30, $00, $30, $30, $0C, $00, $0C, $0C, $03, $00, $03, $03
        .byte $00, $C0, $C0, $C0, $00, $30, $30, $30, $00, $0C, $0C, $0C, $00, $03, $03, $03
        .byte $C0, $C0, $C0, $C0, $30, $30, $30, $30, $0C, $0C, $0C, $0C, $03, $03, $03, $03

        ; 88/96AF

    .endsection Table88958FSection


    .section Unsorted8896AFSection

      .al
      .xl

      rsClearMinimapDot ; 88/96AF

        .al
        .xl
        .autsiz
        .databank ?

        ; Clears the 2x2 pixel dot of map tile (wR0, wR1).

        php
        phx
        lda wR1
        and #$FFFC
        xba
        lsr a
        sta wR3
        lda wR0
        and #$FFFC
        asl a
        asl a
        asl a
        clc
        adc wR3
        sta wR3
        lda wR1
        and #$0003
        asl a
        asl a
        clc
        adc wR3
        tay
        lda wR0
        and #$0003
        asl a
        asl a
        tax
        sep #$20
        lda $8B88,b,y
        and aMinimapDotClearMasks,x
        sta $8B88,b,y
        lda $8B89,b,y
        and aMinimapDotClearMasks+1,x
        sta $8B89,b,y
        lda $8B98,b,y
        and aMinimapDotClearMasks+2,x
        sta $8B98,b,y
        lda $8B99,b,y
        and aMinimapDotClearMasks+3,x
        sta $8B99,b,y
        lda $8B8A,b,y
        and aMinimapDotClearMasks,x
        sta $8B8A,b,y
        lda $8B8B,b,y
        and aMinimapDotClearMasks+1,x
        sta $8B8B,b,y
        lda $8B9A,b,y
        and aMinimapDotClearMasks+2,x
        sta $8B9A,b,y
        lda $8B9B,b,y
        and aMinimapDotClearMasks+3,x
        sta $8B9B,b,y
        plx
        plp
        .al
        rts

        .databank 0

        ; 88/972F

    .endsection Unsorted8896AFSection


    .section Data88972FSection

      .al
      .xl

      aMinimapDotClearMasks ; 88/972F

        ; Read by rsClearMinimapDot.

        .byte $3F, $3F, $3F, $3F, $CF, $CF, $CF, $CF, $F3, $F3, $F3, $F3, $FC, $FC, $FC, $FC

        ; 88/973F

    .endsection Data88972FSection


    .section Unsorted88973FSection

      .al
      .xl

      rlMinimapStep ; 88/973F

        .al
        .xl
        .autsiz
        .databank ?

        ; Runs while the minimap is open (bit 5 of wMapSystemFlags). The D-pad scrolls the map under it, B or Start closes it, holding R, X, A or Y makes it see-through and L jumps to the home castle. When choosing a warp destination (bit 11 of wChapterFlags) the D-pad picks a castle instead (rsMinimapChooseWarpCastle).

        lda #(`procMinimap)<<8
        sta lR44+1
        lda #<>procMinimap
        sta lR44
        jsl rlProcEngineFindProc
        bcc _9753
        jml _9840


        _9753
        lda #(`procMinimapClose)<<8
        sta lR44+1
        lda #<>procMinimapClose
        sta lR44
        jsl rlProcEngineFindProc
        bcc _9767
        jml _9840


        _9767
        lda wChapterFlags,b
        bit #$0800
        beq _9773
        jml _9841


        _9773
        lda wMapCursorStepping,b
        bne _97DA
        lda wJoy1New
        bit #$9000
        beq _978E
        lda #(`procMinimapClose)<<8
        sta lR44+1
        lda #<>procMinimapClose
        sta lR44
        jsl rlProcEngineCreateProc
        rtl


        _978E
        jsr rsMinimapHandleTransparency
        lda wJoy1Input
        and #$0F00
        sta wMapScrollDirectionIdentifier,b
        bne _97AC
        lda $0ADB,b
        beq _9801
        stz $0ADB,b
        lda #$001C
        jsl rlPlaySoundEffect
        bra _9801


        _97AC
        lda $0ADB,b
        bne _97C2
        inc $0ADB,b
        lda #$001A
        jsl rlPlaySoundEffect
        lda #$001B
        jsl rlPlaySoundEffect

        _97C2
        stz wMapScrollCurrentPixelDistance,b
        lda #$0001
        sta wMapCursorStepping,b
        stz wMapScrollingFlag,b
        stz wMapEnableXScrollFlag,b
        stz wMapEnableYScrollFlag,b
        lda #$0004
        sta wMapScrollSpeed,b

        _97DA
        lda wMapScrollCurrentPixelDistance,b
        clc
        adc wMapScrollSpeed,b
        sta wMapScrollCurrentPixelDistance,b
        cmp #$0010
        bcc _97F5
        stz wMapCursorStepping,b
        stz wMapScrollingFlag,b
        stz wMapEnableXScrollFlag,b
        stz wMapEnableYScrollFlag,b

        _97F5
        jsl rlMinimapScrollMap
        lda wMapScrollCurrentPixelDistance,b
        cmp wMapScrollSpeed,b
        bne _9801

        _9801
        sep #$20
        lda #$88
        pha
        plb
        .databank $88
        rep #$20
        ldy #<>aMinimapViewBoxSprite
        lda wMapScrollXPixels,b
        lsr a
        lsr a
        lsr a
        clc
        adc #$0040
        sta wR0
        lda wMapScrollYPixels,b
        lsr a
        lsr a
        lsr a
        clc
        adc #$0030
        sta wR1
        lda #$2000
        sta wR5
        lda #$0000
        sta wR4
        lda wVBlankEnabledFramecount
        and #$0018
        beq _9838
        ldy #<>aMinimapViewBoxSpriteWide

        _9838
        jsl rlPushToOAMBuffer
        jsl rlMinimapAnimateViewColors

        _9840
        rtl


        _9841
        jsr rsMinimapChooseWarpCastle
        lda wCastleCursorX,b
        asl a
        clc
        adc #$0040
        sec
        sbc #$0010
        sta wR0
        lda wCastleCursorY,b
        asl a
        clc
        adc #$0030
        sec
        sbc #$0006
        sta wR1
        lda #$0000
        jsl rlDrawHandCursor
        jsl rlMinimapAnimateViewColors
        rtl

        .databank 0

        ; 88/986C

      rsMinimapChooseWarpCastle ; 88/986C

        .al
        .xl
        .autsiz
        .databank ?

        ; Down or right goes to the next castle, up or left to the previous one, A chooses it (sets bit 14 of wMapSystemFlags) and B cancels; both close the minimap.

        lda wJoy1New
        bit #$0500
        bne _9883
        bit #$0A00
        bne _988A
        bit #$0080
        bne _98B4
        bit #$8000
        bne _98A1
        rts


        _9883
        inc wCastleSubMenuStep,b
        jml rsMinimapShowWarpCastle


        _988A
        dec wCastleSubMenuStep,b
        lda wCastleSubMenuStep,b
        bpl _989D
        jsl rlGetChapterLocationCount
        sec
        sbc #$0001
        sta wCastleSubMenuStep,b

        _989D
        jml rsMinimapShowWarpCastle


        _98A1
        lda #(`procMinimapClose)<<8
        sta lR44+1
        lda #<>procMinimapClose
        sta lR44
        jsl rlProcEngineCreateProc
        stz wMapCursorState,b
        rts

        .byte $60


        _98B4
        lda #$4000
        tsb wMapSystemFlags,b
        lda #(`procMinimapClose)<<8
        sta lR44+1
        lda #<>procMinimapClose
        sta lR44
        jsl rlProcEngineCreateProc
        rts

      aMinimapCastleNameTilemapInfo ; 88/98C9

        .byte $20, $20, $00, $00, $00, $00, $88, $83, $7E

        ; 88/98D2

      rsMinimapShowWarpCastle ; 88/98D2

        .al
        .xl
        .autsiz
        .databank ?

        ; Moves wCastleSubMenuStep on to a castle the player owns that is empty (or is the home castle), puts wCastleCursorX/Y on it and draws its name.

        lda wCastleSubMenuStep,b
        jsl rlGetLocationEventDataEntry
        bcs _992C
        jsl rlGetEventLocationEntryType
        cmp #LocationTypeCastle
        bne _9931
        jsl rlGetLocationFactionSlotOwner
        cmp #$0000
        bne _9931
        jsl rlGetEventLocationEntryEffectiveXCoordinate
        sta wTempVariable1,b
        jsl rlGetEventLocationEntryEffectiveYCoordinate
        sta wTempVariable2,b
        jsl rlGetEventLocationEntryID
        sta wUnknown000790,b
        lda #$0000
        jsl rlGetFactionSlotLocationID
        cmp wUnknown000790,b
        beq _991E
        lda wTempVariable1,b
        sta wR0
        lda wTempVariable2,b
        sta wR1
        jsl rlGetUnitByCoordinates
        bcc _9931

        _991E
        lda wTempVariable1,b
        sta wCastleCursorX,b
        lda wTempVariable2,b
        sta wCastleCursorY,b
        bra _9952


        _992C
        stz wCastleSubMenuStep,b
        bra rsMinimapShowWarpCastle


        _9931
        lda wJoy1New
        bit #$0A00
        bne _993D
        inc wCastleSubMenuStep,b
        bra rsMinimapShowWarpCastle


        _993D
        dec wCastleSubMenuStep,b
        lda wCastleSubMenuStep,b
        bpl rsMinimapShowWarpCastle
        jsl rlGetChapterLocationCount
        sec
        sbc #$0001
        sta wCastleSubMenuStep,b
        bra rsMinimapShowWarpCastle


        _9952
        lda #(`aMinimapCastleNameTilemapInfo)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aMinimapCastleNameTilemapInfo
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda #(`aMinimapBlankCastleNameText)<<8
        sta lRoutineVariable+1,b
        lda #<>aMinimapBlankCastleNameText
        sta lRoutineVariable,b
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$040D
        jsl rlDrawMenuTextLine
        jsl rlGetEventLocationEntryCastleName
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$040D
        jsl rlDrawMenuTextLine
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8488, $0080, $80, $B100

        rts

        .databank 0

        ; 88/99A4

    .endsection Unsorted88973FSection


    .section Table8899A4Section

      .al
      .xl

      aMinimapBlankCastleNameText ; 88/99A4

        .enc "SJIS"
        .text "　　　　　　　　　"
        .word $0000
        .enc "none"


    .endsection Table8899A4Section


    .section Unsorted8899B8Section

      .al
      .xl

      rlMinimapScrollMap ; 88/99B8

        .al
        .xl
        .autsiz
        .databank ?

        ; Scrolls the map in the D-pad direction and plays the scrolling sounds.

        lda wMapScrollXPixels,b
        sta wMapSavedScrollXPixels,b
        lda wMapScrollYPixels,b
        sta wMapSavedScrollYPixels,b
        lda wMapScrollDirectionIdentifier,b
        cmp #$0200
        beq _99F0
        cmp #$0100
        beq _99F6
        cmp #$0800
        beq _99FC
        cmp #$0400
        beq _9A02
        cmp #$0A00
        beq _9A08
        cmp #$0600
        beq _9A0E
        cmp #$0900
        beq _9A14
        cmp #$0500
        beq _9A1A

        _99EF
        rtl


        _99F0
        jsl rlStartMapScrollLeft
        bra _9A20


        _99F6
        jsl rlStartMapScrollRight
        bra _9A20


        _99FC
        jsl rlStartMapScrollUp
        bra _9A20


        _9A02
        jsl rlStartMapScrollDown
        bra _9A20


        _9A08
        jsl rlStartMapScrollUpLeft
        bra _9A20


        _9A0E
        jsl rlStartMapScrollDownLeft
        bra _9A20


        _9A14
        jsl rlStartMapScrollUpRight
        bra _9A20


        _9A1A
        jsl rlStartMapScrollDownRight
        bra _9A20


        _9A20
        lda wMapScrollXPixels,b
        cmp wMapSavedScrollXPixels,b
        bne _99EF
        lda wMapScrollYPixels,b
        cmp wMapSavedScrollYPixels,b
        bne _99EF
        lda $0ADB,b
        beq _99EF
        stz $0ADB,b
        lda #$001C
        jsl rlPlaySoundEffect
        bra _99EF

        .databank 0

        ; 88/9A41

      rsMinimapHandleTransparency ; 88/9A41

        .al
        .xl
        .autsiz
        .databank ?

        lda wJoy1Input
        bit #$0010
        bne _9A6F
        bit #$0040
        bne _9A6F
        bit #$0080
        bne _9A6F
        bit #$4000
        bne _9A6F
        lda wJoy1New
        bit #$0020
        bne _9A80

        _9A5E
        sep #$20
        lda #$00
        sta bBufferCGWSEL
        lda #$A9
        sta bBufferCGADSUB
        lda #$00
        sta bBufferTS
        rep #$20
        rts


        _9A6F
        sep #$20
        lda #$02
        sta bBufferCGWSEL
        lda #$52
        sta bBufferCGADSUB
        lda #$11
        sta bBufferTS
        rep #$20
        rts


        _9A80
        jsr rsJumpToNextCastle
        bra _9A5E

        .databank 0

        ; 88/9A85

      rlMinimapAnimateViewColors ; 88/9A85

        .al
        .xl
        .autsiz
        .databank ?

        ; Cycles four OAM colours by frame (aMinimapViewColorCycle) for the box that shows the visible part of the map.

        lda wVBlankEnabledFramecount
        and #$001E
        tax
        lda aMinimapViewColorCycle,x
        and #$03FF
        clc
        adc #$7C00
        sta $01D8,b
        lda aMinimapViewColorCycle,x
        and #$7FE0
        clc
        adc #$001F
        sta $01DA,b
        lda aMinimapViewColorCycle,x
        and #$7C1F
        clc
        adc #$03E0
        sta $01DC,b
        lda aMinimapViewColorCycle,x
        and #$7C00
        clc
        adc #$033F
        sta $01DE,b
        rtl

        .databank 0

        ; 88/9AC4

      aUnknown889AC4 ; 88/9AC4

        ; Unreferenced: 15 colours.

        .word $08A5, $1DC9, $1168, $4F9C, $2657, $0D2F, $0089, $6BF4
        .word $6289, $3945, $7BFF, $7E00, $001F, $03E0, $03FF

    .endsection Unsorted8899B8Section


    .section Table889AE2Section

      .al
      .xl

      aMinimapViewColorCycle ; 88/9AE2

        ; Read by rlMinimapAnimateViewColors.

        .word $0000, $0421, $0842, $1084, $18C6, $1CE7, $2529, $7DEF
        .word $7DEF, $2529, $1CE7, $18C6, $1084, $0842, $0421, $0000
        .word $0000, $0021, $0042, $0063, $0084, $00A5, $00C6, $00E7
        .word $00E7, $00C6, $00A5, $0084, $0063, $0042, $0021, $0000

        ; 88/9B22

    .endsection Table889AE2Section


    .section Unsorted889B22Section

      .al
      .xl

      rlClearMinimap ; 88/9B22

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb
        .databank $7E
        phx
        phy
        ldx #$01FE
        lda #$0000

        _9B34
        sta $8B88,b,x
        sta $8D88,b,x
        sta $8F88,b,x
        sta $9188,b,x
        sta $9388,b,x
        sta $9588,b,x
        sta $9788,b,x
        sta $9988,b,x
        sta $9B88,b,x
        sta $9D88,b,x
        sta $9F88,b,x
        sta $A188,b,x
        sta $A388,b,x
        sta $A588,b,x
        sta $A788,b,x
        sta $A988,b,x
        dec x
        dec x
        bpl _9B34
        ply
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 88/9B6D

    .endsection Unsorted889B22Section


    .section Unsorted889B6DSection

      .al
      .xl

      rlDrawMinimapTerrain ; 88/9B6D

        .al
        .xl
        .autsiz
        .databank ?

        ; Puts a dot for each map tile from X down to wTempVariable1, coloured by its terrain (aMinimapTerrainColors) or 9 for a closed village.

        phb
        php
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb
        .databank $7E

        _9B77
        txa
        and #$007E
        lsr a
        sta wR0
        txa
        and #$FF80
        asl a
        xba
        sta wR1
        phx
        lda aMapData,x
        and #$03FF
        tax
        lda aTerrainTileset,x
        and #$00FF
        tax
        jsr rsCheckMinimapClosedVillage
        bcs _9BA5
        lda aMinimapTerrainColors,x
        and #$00FF
        sta wR2

        _9BA5
        plx
        jsr rsPutMinimapDot
        dec x
        dec x
        cpx wTempVariable1,b
        bmi _9BB2
        bcs _9B77

        _9BB2
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 88/9BB5

    .endsection Unsorted889B6DSection


    .section Unsorted889BB5Section

      .al
      .xl

      aMinimapTerrainColors ; 88/9BB5

        ; One byte per terrain type (the index comes from aTerrainTileset), read by
        ; rlDrawMinimapTerrain unless rsCheckMinimapClosedVillage returns with carry set.

        .byte $06, $01, $06, $02, $03, $0A, $0A, $05, $04, $0B, $08, $08, $08
        .byte $08, $05, $0B, $07, $08, $08, $08, $08, $08, $08, $08, $08, $04

        ; 88/9BCF

      rsCheckMinimapClosedVillage ; 88/9BCF

        .al
        .xl
        .autsiz
        .databank ?

        ; For terrain $12 or $13: carry set and colour 9 when the tile is a village that is closed.

        cmp #TerrainVillage
        beq _9BD9
        cmp #TerrainVillageRuins
        bne _9BF5

        _9BD9
        jsl rlFindLocationAtTile
        bcs _9BF5
        jsl rlGetEventLocationEntryType
        cmp #LocationTypeVillage
        bne _9BF5
        jsl rlCheckIfVillageClosed
        bcc _9BF5
        lda #$0009
        sta wR2
        sec
        rts


        _9BF5
        clc
        rts

        .databank 0

        ; 88/9BF7

    .endsection Unsorted889BB5Section


    .section Unsorted889BF7Section

      .al
      .xl

      rlDrawMinimapUnits ; 88/9BF7

        .al
        .xl
        .autsiz
        .databank ?

        ; Puts a dot for each deployed, visible unit, coloured $0C plus its allegiance.

        phb
        php
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb
        .databank $7E
        phx
        phy
        ldx #$008E

        _9C06
        lda @l aDeploymentTable,x
        bit #$0080
        beq _9C2F
        bit #$0040
        bne _9C2F
        and #$0003
        clc
        adc #$000C
        sta wR2
        lda @l aDeploymentTable._XTilePosition,x
        sta wR0
        lda @l aDeploymentTable._YTilePosition,x
        sta wR1
        jsr rsClearMinimapDot
        jsr rsPutMinimapDot

        _9C2F
        dec x
        dec x
        bpl _9C06
        ply
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 88/9C38

      aUnknown889C38 ; 88/9C38

        ; Unreferenced.

        .byte $06, $01, $06, $02, $03, $0A, $0A, $05, $04, $0B, $08, $08, $08, $08, $05, $0B
        .byte $07, $08, $08, $08, $08, $08, $08, $08, $08, $04

    .endsection Unsorted889BF7Section


    .section ProcScript889C52Section

      .al
      .xl

      procMinimapClose ; 88/9C52

        .structProcInfo "MC", rlProcMinimapCloseInit, rlProcMinimapCloseLoadWindowGraphics, aProcMinimapCloseCode

    .endsection ProcScript889C52Section


    .section Unsorted889C5ASection

      .al
      .xl

      rlProcMinimapCloseInit ; 88/9C5A

        .al
        .xl
        .autsiz
        .databank ?

        ; Restores the colour math, clears the minimap tilemap and puts the cursor back on screen.

        phx
        sep #$20
        lda #$15
        sta bBufferTM
        lda #$00
        sta bBufferTS
        lda #$00
        sta bBufferCGWSEL
        lda #$00
        sta bBufferCGADSUB
        lda #$20
        sta bBufferCOLDATA_1
        lda #$40
        sta bBufferCOLDATA_2
        lda #$80
        sta bBufferCOLDATA_3
        rep #$20
        ldx #$07FE
        lda #$00FF

        _9C81
        sta aBG2TilemapBuffer.Page1,x
        dec x
        dec x
        bpl _9C81
        jsl rlDMAByStruct

          .structDMAToVRAM $7E7C88, $0500, $80, $A900

        lda #$001D
        jsl rlPlaySoundEffect
        lda wCursorXOffset,b
        clc
        adc wMapXOffset,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR10
        lda wCursorYOffset,b
        clc
        adc wMapYOffset,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR11
        lda wChapterFlags,b
        bit #$0800
        bne _9CDF
        jsl rlGetTileScreenPixelPosition
        lda wR10
        cmp #$FFFF
        beq _9CD6
        lda wR10
        sta wCursorXOffset,b
        lda wR11
        sta wCursorYOffset,b
        bra _9CDF


        _9CD6
        lda #$0080
        sta wCursorXOffset,b
        sta wCursorYOffset,b

        _9CDF
        plx
        rtl

        .databank 0

        ; 88/9CE1

      rlProcMinimapCloseLoadWindowGraphics ; 88/9CE1

        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsl rlLoadWindowGraphics
        plx
        lda #<>rlProcMinimapCloseLoadGraphics1
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 88/9CEE

    .endsection Unsorted889C5ASection


    .section Unsorted889CEESection

      .al
      .xl

      rlProcMinimapCloseLoadGraphics1 ; 88/9CEE

        .al
        .xl
        .autsiz
        .databank ?

        phx
        sep #$20
        rep #$10
        ldx #<>gcUnknownC01FBA
        stx DecompressionVariables
        lda #`gcUnknownC01FBA
        sta $CA
        ldx #$8B88
        stx $CB
        lda #$7E
        sta $CD
        rep #$30
        jsl rlDecompressor
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $0400, $80, $6800

        plx
        lda #<>rlProcMinimapCloseLoadGraphics2
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 88/9D20

    .endsection Unsorted889CEESection


    .section Unsorted889D20Section

      .al
      .xl

      rlProcMinimapCloseLoadGraphics2 ; 88/9D20

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        sep #$20
        rep #$10
        ldx #<>gcUnknownC02542
        stx DecompressionVariables
        lda #`gcUnknownC02542
        sta $CA
        ldx #$8F88
        stx $CB
        lda #$7E
        sta $CD
        rep #$30
        jsl rlDecompressor
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8F88, $0400, $80, $6C00

        jsl rlLoadDefaultWindowBorderPalette
        lda #(`aMinimapCastleNameTilemapInfo)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aMinimapCastleNameTilemapInfo
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda #(`aMinimapCloseBlankText)<<8
        sta lRoutineVariable+1,b
        lda #<>aMinimapCloseBlankText
        sta lRoutineVariable,b
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$040D
        jsl rlDrawMenuTextLine
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8488, $0080, $80, $B100

        plx
        lda #<>rlProcMinimapCloseFinish
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 88/9D92

    .endsection Unsorted889D20Section


    .section Table889D92Section

      .al
      .xl

      aMinimapCloseBlankText ; 88/9D92

        .enc "SJIS"
        .text "　　　　　　　　　"
        .word $0000
        .enc "none"


    .endsection Table889D92Section


    .section Unsorted889DA6Section

      .al
      .xl

      rlProcMinimapCloseFinish ; 88/9DA6

        .al
        .xl
        .autsiz
        .databank ?

        ; Clears the minimap flag and ends the proc. After a warp destination was chosen, uses the warp staff on it (rlRunMapAction), from the map or from the castle grid; after a cancel, reopens the unit menu or returns to the castle grid.

        lda #$0020
        trb wMapSystemFlags,b
        jsl rlProcEngineFreeProc
        lda wChapterFlags,b
        bit #$0800
        beq _9E0B
        lda wMapSystemFlags,b
        bit #$4000
        beq _9DF3
        lda #$4000
        trb wMapSystemFlags,b
        lda wActiveUnitDeploymentOffset,b
        sta wR0
        lda wMapTargetDeploymentOffset,b
        sta wR1
        lda wCastleCursorX,b
        sta wR2
        lda wCastleCursorY,b
        sta wR3
        lda wMapReturnFlags,b
        bit #MAP_RETURN_CASTLE_GRID_STAFF
        bne _9E0C
        jsl rlRunMapAction
        lda #$0800
        trb wChapterFlags,b
        lda #$0008
        tsb wMapSystemFlags,b
        rtl


        _9DF3
        lda #$0800
        trb wChapterFlags,b
        lda wMapReturnFlags,b
        bit #MAP_RETURN_CASTLE_GRID_STAFF
        bne _9E34
        lda #$0008
        tsb wMapSystemFlags,b
        jsl rlOpenUnitMenu

        _9E0B
        rtl


        _9E0C
        ldx wActiveUnitDeploymentOffset,b
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        lda wCastleGridSlot,b
        asl a
        tax
        lda $7F757A,x
        asl a
        tax
        lda $7F75AA,x
        beq _9DF3
        sta wRoutineVariable1,b
        jsl rlBuildCastleActionRounds
        lda #$0800
        trb wChapterFlags,b

        _9E34
        stz wCastleCursorState,b
        lda wCastleGridSavedSlot,b
        sta wCastleGridSlot,b
        asl a
        tax
        lda aCastleGridCursorX,x
        sta wCastleGridCursorXPixel,b
        lda aCastleGridCursorY,x
        sta wCastleGridCursorYPixel,b
        jsl rlCastleDrawInfoLine
        ldx #$00FE

        _9E54
        lda aCastleCourtyardBGPalettes,x
        sta aBGPaletteBuffer,b,x
        dec x
        dec x
        bpl _9E54
        stz wMovingUnitSpriteState,b
        lda #MAP_RETURN_CASTLE_GRID_STAFF
        trb wMapReturnFlags,b
        stz wMapActionMode,b
        rtl

        .databank 0

        ; 88/9E6C

    .endsection Unsorted889DA6Section


    .section ProcScript889E6CSection

      .al
      .xl

      aProcMinimapCloseCode ; 88/9E6C

        PROC_HALT


        ; 88/9E6E

    .endsection ProcScript889E6CSection


    .section Unreferenced889E6ESection

      .al
      .xl

      rsDebugAdjustBGPaletteRGBUnused ; 88/9E6E

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda wJoy1Input
        bit #$0010
        beq _9EC1
        lda wJoy1Repeated
        bit #$0800
        beq _9E9C
        lda wJoy1Input
        bit #$0080
        beq _9E86
        jsr rsIncBGPaletteRedUnused

        _9E86
        lda wJoy1Input
        bit #$4000
        beq _9E90
        jsr rsIncBGPaletteGreenUnused

        _9E90
        lda wJoy1Input
        bit #$0040
        beq _9E9C
        jsr rsIncBGPaletteBlueUnused
        bra _9EC1


        _9E9C
        lda wJoy1Repeated
        bit #$0400
        beq _9EC1
        lda wJoy1Input
        bit #$0080
        beq _9EAD
        jsr rsDecBGPaletteRedUnused

        _9EAD
        lda wJoy1Input
        bit #$4000
        beq _9EB7
        jsr rsDecBGPaletteGreenUnused

        _9EB7
        lda wJoy1Input
        bit #$0040
        beq _9EC1
        jsr rsDecBGPaletteBlueUnused

        _9EC1
        rts

        .databank 0

        ; 88/9EC2

      rsIncBGPaletteRedUnused ; 88/9EC2

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ldx #$009E

        _9EC5
        lda aBGPaletteBuffer.aPalette1,b,x
        and #$001F
        clc
        adc #$0001
        cmp #$001F
        bcc _9ED7
        lda #$001F

        _9ED7
        sta wR0
        lda aBGPaletteBuffer.aPalette1,b,x
        and #$FFE0
        ora wR0
        sta aBGPaletteBuffer.aPalette1,b,x
        dec x
        dec x
        bpl _9EC5
        rts

        .databank 0

        ; 88/9EE9

      rsIncBGPaletteGreenUnused ; 88/9EE9

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ldx #$009E

        _9EEC
        lda aBGPaletteBuffer.aPalette1,b,x
        and #$03E0
        lsr a
        lsr a
        lsr a
        lsr a
        lsr a
        clc
        adc #$0001
        cmp #$001F
        bcc _9F03
        lda #$001F

        _9F03
        asl a
        asl a
        asl a
        asl a
        asl a
        sta wR0
        lda aBGPaletteBuffer.aPalette1,b,x
        and #$FC1F
        ora wR0
        sta aBGPaletteBuffer.aPalette1,b,x
        dec x
        dec x
        bpl _9EEC
        rts

        .databank 0

        ; 88/9F1A

      rsIncBGPaletteBlueUnused ; 88/9F1A

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ldx #$009E

        _9F1D
        lda aBGPaletteBuffer.aPalette1,b,x
        and #$7C00
        xba
        lsr a
        lsr a
        clc
        adc #$0001
        cmp #$001F
        bcc _9F32
        lda #$001F

        _9F32
        xba
        asl a
        asl a
        sta wR0
        lda aBGPaletteBuffer.aPalette1,b,x
        and #$83FF
        ora wR0
        sta aBGPaletteBuffer.aPalette1,b,x
        dec x
        dec x
        bpl _9F1D
        rts

        .databank 0

        ; 88/9F47

      rsDecBGPaletteRedUnused ; 88/9F47

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ldx #$009E

        _9F4A
        lda aBGPaletteBuffer.aPalette1,b,x
        and #$001F
        sec
        sbc #$0001
        bpl _9F59
        lda #$0000

        _9F59
        sta wR0
        lda aBGPaletteBuffer.aPalette1,b,x
        and #$FFE0
        ora wR0
        sta aBGPaletteBuffer.aPalette1,b,x
        dec x
        dec x
        bpl _9F4A
        rts

        .databank 0

        ; 88/9F6B

      rsDecBGPaletteGreenUnused ; 88/9F6B

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ldx #$009E

        _9F6E
        lda aBGPaletteBuffer.aPalette1,b,x
        and #$03E0
        lsr a
        lsr a
        lsr a
        lsr a
        lsr a
        sec
        sbc #$0001
        bpl _9F82
        lda #$0000

        _9F82
        asl a
        asl a
        asl a
        asl a
        asl a
        sta wR0
        lda aBGPaletteBuffer.aPalette1,b,x
        and #$FC1F
        ora wR0
        sta aBGPaletteBuffer.aPalette1,b,x
        dec x
        dec x
        bpl _9F6E
        rts

        .databank 0

        ; 88/9F99

      rsDecBGPaletteBlueUnused ; 88/9F99

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ldx #$009E

        _9F9C
        lda aBGPaletteBuffer.aPalette1,b,x
        and #$7C00
        xba
        lsr a
        lsr a
        sec
        sbc #$0001
        bpl _9FAE
        lda #$0000

        _9FAE
        xba
        asl a
        asl a
        sta wR0
        lda aBGPaletteBuffer.aPalette1,b,x
        and #$83FF
        ora wR0
        sta aBGPaletteBuffer.aPalette1,b,x
        dec x
        dec x
        bpl _9F9C
        rts

        .databank 0

        ; 88/9FC3

    .endsection Unreferenced889E6ESection
