; World map VBlank handler, screen setup, and graphics/HDMA initialization.


    .section Unsorted80B347Section

      .al
      .xl

      rsWorldMapVBlank ; 80/B347

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; VBlank routine for World Map (OAM/DMA/HDMA/GameStates, BG1/BG3 scroll sync, map markers/sound)

        sep #$20
        lda #$80
        sta $2100,b
        rep #$20
        jsl rlUploadMapRowAndColumn
        jsl rlProcessDMAStructArray
        jsl rlDMAPaletteAndOAMBuffer
        jsl rlHandlePossibleHDMA
        jsl rlCopyPPURegisterBuffer
        jsl rlSendSoundQueuesToAPU
        jsl rlGetJoypadInput
        jsl rlIncreaseFrameCounters
        jsl rlClearSpriteExtBuffer
        jsl rlRunGameStateRoutines
        jsl rlRunVBlankHooks
        lda wMapScrollXPixels,b
        sta wBufferBG1HOFS
        and #$000F
        sec
        sbc #$0008
        sta wBufferBG3HOFS
        lda wMapScrollYPixels,b
        sta wBufferBG1VOFS
        sta wBufferBG3VOFS
        jsl rlHideSprites
        jsl rlUnknown9181F6
        jsl rlMapMenuVBlankUpload
        jsl rlUpdateSound
        rts

        .databank 0

        ; 80/B3A2

      rsSetupWorldMapScreen ; 80/B3A2

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; World Map main-loop setup: resets PPU/HDMA/dialogue, sets GameStates ($0E, $0D), calls rlInitWorldMapGraphics

        php
        sep #$20
        lda #$80
        sta bBufferINIDISP
        sta $2100,b
        rep #$20
        jsl rlDisableVBlank
        jsl rlHardwareResetScreenPosMathHDMA
        jsl rlHardwareResetScreenRegisters
        lda #$0000
        sta wR1
        lda #$3000
        sta wR2
        lda #$4000
        sta wR3
        sta wR4
        lda #$6000
        sta wR5
        lda #$5000
        sta wR6
        lda #$5400
        sta wR7
        lda #$5800
        sta wR8
        jsl rlSetLayerPositionsAndSizes
        jsl rlClearUnitWindowAndTerrainWindowProcs
        jsl rlActiveSpriteEngineReset
        jsl rlResetHDMAEngine
        jsl rlResetIRQEngine
        jsl rlResetRAMStructAndAreaVariables
        jsl rlInitMapMenus
        jsl rlResetMenuOptionStack
        jsl rlResetDialogueEngine
        lda #(`aUnknown8B9449)<<8
        sta lR44+1
        lda #<>aUnknown8B9449
        sta lR44
        jsl rlUnknown82E0C6
        lda #(`aUnknown8B9594)<<8
        sta lR44+1
        lda #<>aUnknown8B9594
        sta lR44
        jsl rlUnknown82E0C6
        jsl rlUnknown82E08D
        lda #GAMESTATE_WORLD_MAP_SETUP
        sta wGameStateRoutine1,b
        lda #GAMESTATE_WORLD_MAP_UPKEEP
        sta wGameStateRoutine2,b
        stz wGameStateStep,b
        lda #<>rsWorldMapVBlank
        sta wVBlankPointer
        lda #<>rsRunFrameTasks
        sta wMainLoopPointer
        jsl rlInitWorldMapGraphics
        jsl rlPauseMapTileAnimation
        jsl rlEnableVBlank
        sep #$20
        lda #$00
        sta bBufferINIDISP
        rep #$20
        plp
        rts

        .databank 0

        ; 80/B452

      rlInitWorldMapGraphics ; 80/B452

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Clears VRAM $3000/$4000 and loads World Map gfx/tilemaps/palettes/windows/scroll bounds/HDMA

        phk
        plb
        .databank $80
        rep #$30
        lda #$1809
        sta $4300,b
        lda #$8000
        sta $4303,b
        lda #$B61D
        sta $4302,b
        lda #$2000
        sta $4305,b
        lda #$3000
        sta $2116,b
        sep #$20
        lda #$01
        sta $420B,b
        rep #$20
        phk
        plb
        .databank $80
        rep #$30
        lda #$1809
        sta $4300,b
        lda #$8000
        sta $4303,b
        lda #$B61D
        sta $4302,b
        lda #$2000
        sta $4305,b
        lda #$4000
        sta $2116,b
        sep #$20
        lda #$01
        sta $420B,b
        rep #$20
        lda #$03FF
        sta wUnknown000596,b
        lda #$0002
        sta aDialogue.wUnknown0018D0,b
        lda #(`aDecompressionDMAEntry80B61E)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry80B61E
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        sep #$20
        rep #$10
        ldx #<>gcUnknownD10E19
        stx DecompressionVariables
        lda #`gcUnknownD10E19
        sta $CA
        ldx #$2400
        stx $CB
        lda #$7F
        sta $CD
        rep #$30
        jsl rlDecompressor
        sep #$20
        rep #$10
        ldx #<>gcUnknownD1173E
        stx DecompressionVariables
        lda #`gcUnknownD1173E
        sta $CA
        ldx #$0000
        stx $CB
        lda #$7F
        sta $CD
        rep #$30
        jsl rlDecompressor
        ldx #$07FE
        lda #$00FF

        _B500
        sta aBG2TilemapBuffer.Page1,x
        sta aBG3TilemapBuffer,x
        dec x
        dec x
        bpl _B500
        lda #(`aDecompressionDMAEntry80B626)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry80B626
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        jsl rlDMAByStruct

          .structDMAToVRAM $7E7B88, $0800, $80, $A800

        jsl rlDMAByStruct

          .structDMAToVRAM $7E7B88, $0800, $80, $9800

        jsl rlDMAByStruct

          .structDMAToVRAM gUnknownD97940, $01C0, $80, $9D40

        lda #(`aDecompressionDMAEntry80B62E)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry80B62E
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        jsl rlDMAByStruct

          .structDMAToVRAM gUnknownD96C00, $0800, $80, $B000

        lda #(`aDecompressionDMAEntry80B636)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry80B636
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        ldx #$01FE

        _B56D
        lda aWorldMapPartialBGPalettes,x
        sta aBGPaletteBuffer,b,x
        dec x
        dec x
        bpl _B56D
        lda #$0000
        sta aBGPaletteBuffer,b
        sep #$20
        lda #$08
        sta bBufferWH0
        lda #$F8
        sta bBufferWH1
        stz bBufferWH2
        stz bBufferWH3
        lda #$33
        sta bBufferW12SEL
        sta bBufferW34SEL
        lda #$11
        sta bBufferTM
        lda #$14
        sta bBufferTS
        lda bBufferBG1SC
        and #$FC
        sta bBufferBG1SC
        lda bBufferBG3SC
        and #$FC
        ora #$01
        sta bBufferBG3SC
        lda #$54
        sta bBufferBG2SC
        lda #$03
        sta bBufferWOBJSEL
        rep #$20
        sep #$20
        lda #$13
        sta bBufferTM
        sta bBufferTMW
        lda #$16
        sta bBufferTS
        sta bBufferTSW
        lda #$02
        sta bBufferCGWSEL
        lda #$81
        sta bBufferCGADSUB
        rep #$20
        lda wMapXOffset,b
        sta wMapScrollXPixels,b
        lda wMapYOffset,b
        sta wMapScrollYPixels,b
        lda #$0004
        sta wUnknown00075C,b
        sta $075E,b
        lda #$0000
        sta wMapMinXScroll,b
        sta wMapMinYScroll,b
        lda #$0400
        sec
        sbc #$0100
        sta wMapMaxXScroll,b
        lda #$0400
        sec
        sbc #$00E0
        sta wMapMaxYScroll,b
        lda #$0000
        sta wBufferBG2VOFS
        sta wBufferBG2VOFS
        stz wCastleSubMenuStep,b
        stz wMapScrollDirectionIdentifier,b
        jsl rlDrawVisibleMapToVRAM
        lda #(`aUnknown8B911F)<<8
        sta lR44+1
        lda #<>aUnknown8B911F
        sta lR44
        jsl rlHDMAEngineCreateEntry
        rtl

        .databank 0

        ; 80/B61C

    .endsection Unsorted80B347Section


