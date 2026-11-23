; Setting up the chapter map's display: rlSetUpChapterMapDisplay loads the map's
; graphics and palettes, sets the windows, restores the camera, draws the visible
; map and the unit sprites and restarts the animations; it then acts on
; wMapOverlayFlags, the flags that tell the map what to do on return from the
; castle or a menu (rlSetMapReturn*, rsHandleMapReturnFlags). Also rlClearMapRAM
; for a new game or a loaded save. Bank $88.


    .section Unsorted888082Section

      .al
      .xl

      rlSetUpChapterMapDisplay ; 88/8082

        .al
        .xl
        .autsiz
        .databank ?

        ; A = wUnknown00075A and wMapTileIDMask. Loads the map's graphics, palettes and window settings, restores the camera (rlRestoreMapCamera), clears the cursor and moving unit state, draws the visible map, uploads the standing map sprites, handles the return flags and restarts the animations.

        lda #$0001
        sta wUnknown00075A,b
        lda #$03FF
        sta wUnknown000596,b
        phk
        plb
        .databank $88
        rep #$30
        lda #$1809
        sta $4350,b
        lda #$8800
        sta $4353,b
        lda #$8189
        sta $4352,b
        lda #$4000
        sta $4355,b
        lda #$6000
        sta $2116,b
        sep #$20
        lda #$20
        sta $420B,b
        rep #$20
        stz wDMAArrayPosition,b
        jsl rlDMAByStruct

          .structDMAToVRAM g4bppCursorSprites, size(g4bppCursorSprites), $80, $C000

        jsl rlDMAByStruct

          .structDMAToVRAM g4bppMapTiles, size(g4bppMapTiles), $80, $0000

        jsl rlLoadChapterMapGraphics
        ldx #size(aUnknownD95000) - 2

        _80DD
        lda aUnknownD95000,x
        sta $7F0800,x
        dec x
        dec x
        bpl _80DD
        ldx #$00DE

        _80EC
        lda aPortraitAndMapUIOAMPalettes+2,x
        sta aOAMPaletteBuffer.aPalette1,b,x
        dec x
        dec x
        bpl _80EC
        ldx #$001E

        _80FA
        lda aMapAndCastleSpriteOAMPalettes,x
        sta aOAMPaletteBuffer,b,x
        dec x
        dec x
        bpl _80FA
        sep #$20
        lda #$08
        sta bBufferWH0
        lda #$F8
        sta bBufferWH1
        stz bBufferWH2
        stz bBufferWH3
        lda #$03
        sta bBufferW12SEL
        sta bBufferW34SEL
        lda #$15
        sta bBufferTM
        lda bBufferBG1SC
        and #$FC
        sta bBufferBG1SC
        lda bBufferBG3SC
        and #$FC
        sta bBufferBG3SC
        lda #$54
        sta bBufferBG2SC
        lda #$03
        sta bBufferWOBJSEL
        rep #$20
        lda #$000A
        sta wJoyRepeatDelay
        lda #$0002
        sta wJoyRepeatInterval
        jsl rlRestoreMapCamera
        lda wMapXOffset,b
        sta wMapScrollXPixels,b
        sta wBufferBG1HOFS
        sta wBufferBG3HOFS
        lda wMapYOffset,b
        sta wMapScrollYPixels,b
        sta wBufferBG1VOFS
        sta wBufferBG3VOFS
        lda #$0020
        trb wMapSystemFlags,b
        stz wUnknown000770,b
        stz wUnknown000766,b
        stz wUnknown0007D8,b
        stz wMovingUnitSpriteState,b
        stz wMapActionActiveFlag,b
        stz wMapScrollSpeed,b
        stz wMapScrollDirectionIdentifier,b
        jsl rlDrawVisibleMapToVRAM
        jsl rlUploadAllStandingMapSprites
        jsr rsHandleMapReturnFlags
        jsl rlResumeMapSpriteAnimation
        jsl rlResumeMapTileAnimation
        jsl rlUploadMapTileAnimations
        rtl

        .databank 0

        ; 88/8188

    .endsection Unsorted888082Section


    .section Unsorted88818ASection

      .al
      .xl

      rlClearMapRAM ; 88/818A

        .al
        .xl
        .autsiz
        .databank ?

        ; Clears the map engine's RAM from wMenuState ($000592) to $000ADD. Called when a save is loaded and when a new game starts.

        ldx #$054A
        lda #$0000

        _8190
        sta wMenuState,b,x
        dec x
        bpl _8190
        rtl

        .databank 0

        ; 88/8197

    .endsection Unsorted88818ASection


    .section Unsorted888197Section

      .al
      .xl

      rlLoadCursorSpriteGraphics ; 88/8197

        .al
        .xl
        .autsiz
        .databank ?

        ; Copies g4bppCursorSprites to VRAM.

        phx
        jsl rlDMAByStruct

          .structDMAToVRAM g4bppCursorSprites, $0400, $80, $C000

        plx
        rtl

        .databank 0

        ; 88/81A7

      rlLoadMapSpriteOAMPalettes ; 88/81A7

        .al
        .xl
        .autsiz
        .databank ?

        ; Copies aMapAndCastleSpriteOAMPalettes into the first OAM palettes of aOAMPaletteBuffer.

        phx
        ldx #$001E

        _81AB
        lda aMapAndCastleSpriteOAMPalettes,x
        sta aOAMPaletteBuffer,b,x
        dec x
        dec x
        bpl _81AB
        plx
        rtl

        .databank 0

        ; 88/81B8

    .endsection Unsorted888197Section


    .section Unsorted8881B8Section

      .al
      .xl

      rsHandleMapReturnFlags ; 88/81B8

        .al
        .xl
        .autsiz
        .databank ?

        ; With MAP_RETURN_CENTER_ON_UNIT set, sends the cursor to the active unit and clears the flag.

        lda wMapOverlayFlags,b
        bit #$0001
        bne _81C6
        bit #$0002
        bne _81D5

        _81C5
        rts


        _81C6
        lda wActiveUnitDeploymentOffset,b
        jsl rlMoveCursorToUnit
        lda #$0001
        trb wMapOverlayFlags,b
        bra _81C5


        _81D5
        bra _81C5

        .databank 0

        ; 88/81D7

    .endsection Unsorted8881B8Section


    .section Unsorted8881D7Section

      .al
      .xl

      rlSetMapReturnCenterOnUnit ; 88/81D7

        .al
        .xl
        .autsiz
        .databank ?

        ; Sets MAP_RETURN_CENTER_ON_UNIT: back on the map, the cursor travels to the active unit.

        lda #$0001
        tsb wMapOverlayFlags,b
        rtl

        .databank 0

        ; 88/81DE

    .endsection Unsorted8881D7Section


    .section Unsorted8881DESection

      .al
      .xl

      rlSetMapReturnStartCastleStaff ; 88/81DE

        .al
        .xl
        .autsiz
        .databank ?

        ; Sets MAP_RETURN_START_CASTLE_STAFF: back on the map, the active unit's staff target selection starts.

        lda #$0002
        tsb wMapOverlayFlags,b
        rtl

        .databank 0

        ; 88/81E5

    .endsection Unsorted8881DESection


    .section Unsorted8881E5Section

      .al
      .xl

      rlSetMapReturnCastleGridStaff ; 88/81E5

        .al
        .xl
        .autsiz
        .databank ?

        ; Sets MAP_RETURN_CASTLE_GRID_STAFF: the staff was chosen from the castle grid, so finishing or cancelling the target selection goes back to the castle screen.

        lda #$0008
        tsb wMapOverlayFlags,b
        rtl

        .databank 0

        ; 88/81EC

    .endsection Unsorted8881E5Section


    .section Unsorted8881ECSection

      .al
      .xl

      rlClearVRAM6000 ; 88/81EC

        .al
        .xl
        .autsiz
        .databank ?

        ; Fills $4000 bytes of VRAM from word $6000 with the zero byte at 88/8219 (a fixed-source DMA).

        phk
        plb
        .databank $88
        rep #$30
        lda #$1809
        sta $4300,b
        lda #$8800
        sta $4303,b
        lda #$8219
        sta $4302,b
        lda #$4000
        sta $4305,b
        lda #$6000
        sta $2116,b
        sep #$20
        lda #$01
        sta $420B,b
        rep #$20
        rtl

        .databank 0

        ; 88/8218

    .endsection Unsorted8881ECSection


    .section Unsorted88821ASection

      .al
      .xl

      rlSetUpChapterMapDisplayAllFrames ; 88/821A

        .al
        .xl
        .autsiz
        .databank ?

        ; Like rlSetUpChapterMapDisplay (with wUnknown00075A = 1 and the mask $03FF), but queues and uploads all 16 standing map sprite steps at once.

        lda #$0001
        sta wUnknown00075A,b
        lda #$03FF
        sta wUnknown000596,b
        rep #$30
        lda #$1809
        sta $4300,b
        lda #$8800
        sta $4303,b
        lda #$83C5
        sta $4302,b
        lda #$2000
        sta $4305,b
        lda #$7000
        sta $2116,b
        sep #$20
        lda #$01
        sta $420B,b
        rep #$20
        stz wDMAArrayPosition,b
        jsl rlDMAByStruct

          .structDMAToVRAM g4bppMapTiles, size(g4bppMapTiles), $80, $0000

        jsl rlLoadChapterMapGraphics
        ldx #size(aUnknownD95000) - 2

        _8266
        lda aUnknownD95000,x
        sta $7F0800,x
        dec x
        dec x
        bpl _8266
        jsl rlDMAByStruct

          .structDMAToVRAM g4bppCursorSprites, size(g4bppCursorSprites), $80, $C000

        ldx #$00DE

        _8282
        lda aPortraitAndMapUIOAMPalettes+2,x
        sta aOAMPaletteBuffer.aPalette1,b,x
        dec x
        dec x
        bpl _8282
        ldx #$001E

        _8290
        lda aMapAndCastleSpriteOAMPalettes,x
        sta aOAMPaletteBuffer,b,x
        dec x
        dec x
        bpl _8290
        sep #$20
        lda #$08
        sta bBufferWH0
        lda #$F8
        sta bBufferWH1
        stz bBufferWH2
        stz bBufferWH3
        lda #$03
        sta bBufferW12SEL
        sta bBufferW34SEL
        lda #$15
        sta bBufferTM
        lda bBufferBG1SC
        and #$FC
        sta bBufferBG1SC
        lda bBufferBG3SC
        and #$FC
        sta bBufferBG3SC
        lda #$54
        sta bBufferBG2SC
        lda #$03
        sta bBufferWOBJSEL
        rep #$20
        lda #$000A
        sta wJoyRepeatDelay
        lda #$0002
        sta wJoyRepeatInterval
        jsl rlRestoreMapCamera
        lda wMapXOffset,b
        sta wMapScrollXPixels,b
        sta wBufferBG1HOFS
        sta wBufferBG3HOFS
        lda wMapYOffset,b
        sta wMapScrollYPixels,b
        sta wBufferBG1VOFS
        sta wBufferBG3VOFS
        stz wUnknown000770,b
        stz wUnknown000766,b
        stz wUnknown0007D8,b
        stz wMovingUnitSpriteState,b
        stz wMapActionActiveFlag,b
        stz wMapScrollSpeed,b
        stz wMapScrollDirectionIdentifier,b
        jsl rlDrawVisibleMapToVRAM
        lda #$0000
        jsl rlQueueStandingMapSpriteFrames
        jsl rlUploadMapAnimations
        lda #$0001
        jsl rlQueueStandingMapSpriteFrames
        jsl rlUploadMapAnimations
        lda #$0002
        jsl rlQueueStandingMapSpriteFrames
        jsl rlUploadMapAnimations
        lda #$0003
        jsl rlQueueStandingMapSpriteFrames
        jsl rlUploadMapAnimations
        lda #$0004
        jsl rlQueueStandingMapSpriteFrames
        jsl rlUploadMapAnimations
        lda #$0005
        jsl rlQueueStandingMapSpriteFrames
        jsl rlUploadMapAnimations
        lda #$0006
        jsl rlQueueStandingMapSpriteFrames
        jsl rlUploadMapAnimations
        lda #$0007
        jsl rlQueueStandingMapSpriteFrames
        jsl rlUploadMapAnimations
        lda #$0008
        jsl rlQueueStandingMapSpriteFrames
        jsl rlUploadMapAnimations
        lda #$0009
        jsl rlQueueStandingMapSpriteFrames
        jsl rlUploadMapAnimations
        lda #$000A
        jsl rlQueueStandingMapSpriteFrames
        jsl rlUploadMapAnimations
        lda #$000B
        jsl rlQueueStandingMapSpriteFrames
        jsl rlUploadMapAnimations
        lda #$000C
        jsl rlQueueStandingMapSpriteFrames
        jsl rlUploadMapAnimations
        lda #$000D
        jsl rlQueueStandingMapSpriteFrames
        jsl rlUploadMapAnimations
        lda #$000E
        jsl rlQueueStandingMapSpriteFrames
        jsl rlUploadMapAnimations
        lda #$000F
        jsl rlQueueStandingMapSpriteFrames
        jsl rlUploadMapAnimations
        jsr rsHandleMapReturnFlags
        jsl rlResumeMapSpriteAnimation
        jsl rlResumeMapTileAnimation
        jsl rlUploadMapTileAnimations
        rtl

        .databank 0

        ; 88/83C4


        .byte $00, $00
        rtl

    .endsection Unsorted88821ASection


    .section Unsorted8883C7Section

      .al
      .xl

      rlMapEmptyRoutine ; 88/83C7

        .al
        .xl
        .autsiz
        .databank ?

        ; Only returns.

        rtl

        .databank 0

        ; 88/83C8

      rlDrawVisibleMapToVRAM ; 88/83C8

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws every visible map row straight to VRAM, bottom to top, uploading each as it goes.

        lda #$0001
        sta wMapEnableXScrollFlag,b
        sta wMapEnableYScrollFlag,b
        lda wMapScrollXPixels,b
        sta wUnknown000734,b
        lda wMapScrollYPixels,b
        sta wUnknown000736,b
        clc
        adc #$0100
        sta wMapScrollYPixels,b
        lda #$0008
        sta wMapScrollSpeed,b

        _83EA
        jsr rsMapScrollUpSetBGOFS
        jsl rlQueueMapTopRowUpload
        jsl rlUploadMapRowAndColumn
        lda wUnknown000736,b
        cmp wMapScrollYPixels,b
        bcc _83EA
        lda wUnknown000734,b
        sta wMapScrollXPixels,b
        lda wUnknown000736,b
        sta wMapScrollYPixels,b
        stz wMapEnableXScrollFlag,b
        stz wMapEnableYScrollFlag,b
        rtl

        .databank 0

        ; 88/8410

    .endsection Unsorted8883C7Section


