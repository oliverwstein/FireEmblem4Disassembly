; A leftover world map test mode (bank $8B). Nothing in the game reaches it:
; rlUnusedWorldMapTestFrame moves a cursor and scrolls the map with the control
; pad and gives each button a test action (portraits, markers, region highlights,
; a dialogue box), and Select returns to the chapter map.


    .section Unsorted8B806DSection

      .al
      .xl

      rlUnusedWorldMapTestFrame ; 8B/806D

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ; Unreferenced: a world map test mode's frame. The buttons do test actions (rsUnusedWorldMapTestButtons); the control pad moves a cursor (wCastleCursorX/Y) and scrolls the map (rsUnusedWorldMapTestMoveCursor), faster with Y held. Sets up a cursor sprite but never draws it.

        lda wJoy1New
        jsr rsUnusedWorldMapTestButtons
        lda wJoy1Input
        and #$0F00
        sta wMapScrollDirectionIdentifier,b
        beq _8092
        lda #$0002
        sta wMapScrollSpeed,b
        lda wJoy1Input
        bit #$4000
        beq _808F
        lda #$0004
        sta wMapScrollSpeed,b

        _808F
        jsr rsUnusedWorldMapTestMoveCursor

        _8092
        sep #$20
        lda #$88
        pha
        plb
        .databank $88
        rep #$20
        ldy #<>aMapCursorSprite
        lda wCastleCursorX,b
        sta wR0
        lda wCastleCursorY,b
        sta wR1
        lda #$0000
        sta wR4
        lda #$2000
        sta wR5
        lda aDialogue.wStatus,b
        beq _80C3
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8908, $0140, $80, $BD80


        _80C3
        lda wVBlankEnabledFramecount
        and #$000F
        bne _80CA

        _80CA
        rtl

        .databank 0

        ; 8B/80CB

    .endsection Unsorted8B806DSection


    .section Unsorted8B818DSection

      .al
      .xl

      rsUnusedWorldMapTestShowPortraits ; 8B/818D

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ; Unreferenced: loads world map portraits 1 and 2 into slots 0 and 1 and fades them in at (128, 128) and (160, 160), and puts markers 2 and 4 at (64, 64) and (128, 96).

        ldx #$0000
        lda #$0001
        jsl rlLoadWorldMapPortraitIntoSlot
        ldx #$0000
        lda #$0080
        sta wR0
        lda #$0080
        sta wR1
        jsl rlFadeInWorldMapPortraitSlot
        ldx #$0002
        lda #$0002
        jsl rlLoadWorldMapPortraitIntoSlot
        ldx #$0002
        lda #$00A0
        sta wR0
        lda #$00A0
        sta wR1
        jsl rlFadeInWorldMapPortraitSlot
        lda #$0040
        sta wR0
        lda #$0040
        sta wR1
        ldx #$0000
        ldy #$0002
        jsl rlLoadWorldMapMarkerData
        lda #$0080
        sta wR0
        lda #$0060
        sta wR1
        ldx #$0002
        ldy #$0004
        jsl rlLoadWorldMapMarkerData
        rts

        .databank 0

        ; 8B/81EC

    .endsection Unsorted8B818DSection


    .section Unreferenced8B81ECSection

      .al
      .xl

      rsUnknown8B81EC ; 8B/81EC

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlDMAByStruct

          .structDMAToVRAM $7E8908, $0140, $80, $B580

        lda #(`aBG3TilemapBuffer)<<8
        sta lMapSpriteGraphicsPointer+1,b
        lda #<>aBG3TilemapBuffer
        sta lMapSpriteGraphicsPointer,b
        lda lMapSpriteGraphicsPointer,b
        clc
        adc #$0580
        sta lR18
        lda #$0040
        sta wR0
        lda $5800,b
        sta wR1
        phx
        jsl rlDMAByPointer
        plx
        rts

        .databank 0

        ; 8B/821F

    .endsection Unreferenced8B81ECSection
    .section Unsorted8B87E5Section

      .al
      .xl

      rsUnusedWorldMapTestButtons ; 8B/87E5

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Called only by the unreferenced rlUnusedWorldMapTestFrame, with the buttons pressed this frame. A: loads the next four world map portraits (counting with aWorldMapMarker.wID[0]). B: clears marker 0's timer. X: highlights a region (rlHighlightWorldMapPart, by the frame count). R: opens a dialogue box. L: uploads gUnknownD96C00 to VRAM. Select: returns to the chapter map (rsUnknown80B122).

        bit #$0080
        bne _8804
        bit #$8000
        bne _8808
        bit #$0040
        bne _8810
        bit #$0010
        bne _881A
        bit #$0020
        bne _883D
        bit #$2000
        bne _884F
        rts


        _8804
        jml _8871


        _8808
        lda #$0000
        sta aWorldMapMarker.wTimer[0]
        rts


        _8810
        lda wVBlankEnabledFramecount
        and #$0007
        jsl rlHighlightWorldMapPart
        rts


        _881A
        jsl rlUnknown8B87A0
        jsl rlResetDialogueEngine
        lda #$0002
        jsl rlDialogueStartTextAndHDMA
        lda #(`rlUnknown8B9275)<<8
        sta aDialogue.lHDMARoutine+1,b
        lda #<>rlUnknown8B9275
        sta aDialogue.lHDMARoutine,b
        ldx #$0000
        jsl rlUnknown8B91F6
        rts


        _883D
        jsl rlDMAByStruct

          .structDMAToVRAM gUnknownD96C00, $0800, $80, $B000

        jsl rlResetHDMAEngine
        rts


        _884F
        lda #$0021
        jsl rlPlaySoundEffect
        lda #$0000
        sta wMainGameMode,b
        lda #<>rsUnknown80B122
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        rts


        _8871
        lda aWorldMapMarker.wID[0]
        lda wVBlankEnabledFramecount
        and #$002F
        lda aWorldMapMarker.wID[0]
        ldx #$0000
        jsl rlLoadWorldMapPortraitIntoSlot
        lda wVBlankEnabledFramecount
        and #$002F
        lda aWorldMapMarker.wID[0]
        clc
        adc #$0001
        ldx #$0002
        jsl rlLoadWorldMapPortraitIntoSlot
        lda wVBlankEnabledFramecount
        and #$002F
        lda aWorldMapMarker.wID[0]
        clc
        adc #$0002
        ldx #$0004
        jsl rlLoadWorldMapPortraitIntoSlot
        lda wVBlankEnabledFramecount
        and #$002F
        lda aWorldMapMarker.wID[0]
        clc
        adc #$0003
        ldx #$0006
        jsl rlLoadWorldMapPortraitIntoSlot
        lda aWorldMapMarker.wID[0]
        clc
        adc #$0004
        sta aWorldMapMarker.wID[0]
        rts

        .databank 0

        ; 8B/88CE

    .endsection Unsorted8B87E5Section


    .section Unsorted8B8AABSection

      .al
      .xl

      rsUnusedWorldMapTestMoveCursor ; 8B/8AAB

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Called only by the unreferenced rlUnusedWorldMapTestFrame: scrolls the map in the held direction (diagonals too) and moves the cursor by wMapScrollSpeed, within X 0-240 and Y 0-208.

        lda wMapScrollDirectionIdentifier,b
        cmp #$0200
        beq _8AD7
        cmp #$0100
        beq _8ADB
        cmp #$0800
        beq _8ADF
        cmp #$0400
        beq _8AE3
        cmp #$0A00
        beq _8AE7
        cmp #$0600
        beq _8AEE
        cmp #$0900
        beq _8AF5
        cmp #$0500
        beq _8AFC
        rts


        _8AD7
        jml _8B03


        _8ADB
        jml _8B17


        _8ADF
        jml _8B2E


        _8AE3
        jml _8B42


        _8AE7
        jsr _8B03
        jml _8B2E


        _8AEE
        jsr _8B03
        jml _8B42


        _8AF5
        jsr _8B17
        jml _8B2E


        _8AFC
        jsr _8B17
        jml _8B42


        _8B03
        jsl rlStartMapScrollLeft
        lda wCastleCursorX,b
        sec
        sbc wMapScrollSpeed,b
        bpl _8B13
        lda #$0000

        _8B13
        sta wCastleCursorX,b
        rts


        _8B17
        jsl rlStartMapScrollRight
        lda wCastleCursorX,b
        clc
        adc wMapScrollSpeed,b
        cmp #$00F1
        bcc _8B2A
        lda #$00F0

        _8B2A
        sta wCastleCursorX,b
        rts


        _8B2E
        jsl rlStartMapScrollUp
        lda wCastleCursorY,b
        sec
        sbc wMapScrollSpeed,b
        bpl _8B3E
        lda #$0000

        _8B3E
        sta wCastleCursorY,b
        rts


        _8B42
        jsl rlStartMapScrollDown
        lda wCastleCursorY,b
        clc
        adc wMapScrollSpeed,b
        cmp #$00D1
        bcc _8B55
        lda #$00D0

        _8B55
        sta wCastleCursorY,b
        rts

        .databank 0

        ; 8B/8B59

    .endsection Unsorted8B8AABSection


