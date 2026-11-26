; The unit window: the sortable list of units opened from the map menu, with pages,
; sort orders (by stat, weapon rank, skill...), unit swapping, item and weapon rank
; icons, map sprites and its own HDMA effects. Code in banks $80 and $8B.
;
; rsUnitWindowOpen sets it up as a main loop routine; then game state routines
; $20 (rlUnitWindowHandleInput), $21 (rlUnitWindowShow) and $22
; (rlUnitWindowRunPageTurnInput) run it, with wGameStateStep as the page (0-5).
; Its variables are at $7F82C7-$7F8438 (include/WRAM.h); other screens reuse
; that RAM, such as the item, skill and data windows (item_window.asm,
; skill_window.asm, data_window.asm).
;
; FE5 kept this code, and the FE5 disassembly (github.com/ZaneAvernathy/FireEmblem5)
; names it UnitWindowFE4...; the routines named here were matched with it by their code.
; Its descriptions of the FE4 behaviour are a good guide to these routines.
; rlAddToUnitJoinOrder and rlRemoveFromUnitJoinOrder sit in the middle of this code
; but are in engine/units/join_order.asm.


    .section Unsorted80C3E6Section

      .al
      .xl

      rsUnitWindowOpen ; 80/C3E6

        .al
        .xl
        .autsiz
        .databank ?

        ; Main loop routine that opens the unit window (rlMapMenuOpenUnitWindow in the map menu installs it): resets the screen and the engines, sets up the window's variables, BG and HDMA, then hands the main loop on. Not matched in FE5; named from its callees.

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
        lda #$4000
        sta wR3
        lda #$6000
        sta wR5
        lda #$2800
        sta wR6
        lda #$1000
        sta wR7
        lda #$5800
        sta wR8
        jsl rlSetLayerPositionsAndSizes
        jsl rlClearUnitWindowAndTerrainWindowProcs
        jsl rlActiveSpriteEngineReset
        jsl rlResetHDMAEngine
        jsl rlResetIRQEngine
        lda wUnitWindowCaller
        cmp #<>rsOpenStatusScreen
        beq _C447
        jsr rsUnitWindowInitializeLineVariables

        _C447
        jsr rsUnitWindowInitializeVariables
        jsr rsUnitWindowCopyGraphics
        jsr rsUnitWindowSetBGSettings
        jsr rsUnitWindowSetHDMA
        jsr rsUnitWindowBuildList
        jsl rlUploadAllStandingMapSprites
        lda #GAMESTATE_UNIT_WINDOW_SETUP
        sta wGameStateRoutine1,b
        lda #GAMESTATE_UNIT_WINDOW_UPKEEP
        sta wGameStateRoutine2,b
        lda #<>rsRunFrameTasks
        sta wMainLoopPointer
        jsl rlEnableVBlank
        plp
        rts

        .databank 0

        ; 80/C471

      rsUnitWindowInitializeVariables ; 80/C471

        .al
        .xl
        .autsiz
        .databank ?

        ; FE5: rsUnitWindowInitializeVariables.

        lda wUnitWindowPage
        sta wGameStateStep,b
        lda #$0000
        sta wUnitWindowCurrentNameLine
        sta $7F83F7
        sta $7F83F9
        sta wUnitWindowProcessingHighlightLine
        sta wUnitWindowProcessingHighlightOffset
        sta wUnitWindowCurrentLineSlotOffset
        sta $7F8401
        sta wDebugMenuScreenIndex+1
        sta wUnitWindowCurrentItemIconSlot
        sta wUnitWindowLastScrolledFlag
        sta $7F82D7
        sta wUnitWindowScrollingStep
        sta wUnitWindowScrollingFlag
        sta wUnitWindowHighlightCounter
        sta wUnitWindowPageScrollFlag
        sta wUnitWindowAction
        sta wUnitWindowSortTypeFlag
        sta wUnitWindowUnitSwapStep
        sta wUnitWindowUnitSwapStartSlot
        sta wUnitWindowUnitSwapStartCursorYCoordinate
        lda #$0000
        tax

        _C4CF
        sta aUnitWindowSpriteSlots,x
        inc a
        inc x
        inc x
        cmp #$0018
        bne _C4CF
        lda #$0000
        ldx #$0000

        _C4E1
        sta aUnitWindowSortScores,x
        inc x
        inc x
        cpx #$0030
        bne _C4E1
        jsr rsUnitWindowGetUnits
        jsl rlUnitWindowGetPromotionFlagsAndWeapons
        rts

        .databank 0

        ; 80/C4F4

      rsUnitWindowInitializeLineVariables ; 80/C4F4

        .al
        .xl
        .autsiz
        .databank ?

        ; FE5: rsUnitWindowInitializeFE4LineVariables.

        jsl rlSaveDeploymentMapSprites
        lda #$0000
        sta wUnitWindowCaller
        sta wStatusScreenCaller
        sta wUnitWindowCurrentHighlightLine
        sta wUnitWindowScrolledLines
        sta wUnitWindowScrollPixels
        sta wUnitWindowCurrentColumn
        lda #$0001
        sta wUnitWindowCurrentLine
        lda #$003A
        sta wUnitWindowCursorYCoordinate
        lda #$0000
        sta wUnitWindowHighlightStep
        lda #$00E8
        sta aUnitWindowHighlightColors
        rts

        .databank 0

        ; 80/C530

      rsUnitWindowCopyGraphics ; 80/C530

        .al
        .xl
        .autsiz
        .databank ?

        ; Copies the window's tiles and tilemaps to VRAM and its palettes to the palette buffer, then the equipped weapon icons. FE5: rlUnitWindowCopyGraphics.

        jsl rlDMAByStruct

          .structDMAToVRAM g4bppWindowFrames, $0C00, $80, $6000

        lda #(`aDecompressionDMAEntry80C5BE)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry80C5BE
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        jsl rlDMAByStruct

          .structDMAToVRAM g2bppMenuLabels, $1800, $80, $9800

        jsl rlClearVRAM6000
        jsl rlDMAByStruct

          .structDMAToVRAM g4bppMenuCursorSprites, $0400, $80, $C000

        jsl rlDMAByStruct

          .structDMAToVRAM g4bppWeaponTypeIcons, $0800, $80, $C800

        jsl rlDMAByStruct

          .structDMAToVRAM g4bppSkillIcons, $0C00, $80, $0000

        ldx #$0200

        _C586
        lda aWindowPalette-2,x
        sta aBGPaletteBuffer-2,x
        dec x
        dec x
        bne _C586
        lda #$0000
        sta aBGPaletteBuffer,b
        ldx #$001E

        _C599
        lda aPortraitAndMapUIOAMPalettes+2,x
        sta aOAMPaletteBuffer.aPalette6,b,x
        dec x
        dec x
        bpl _C599
        ldx #$001E

        _C5A7
        lda aMenuSpritePalette7Slice+2,x
        sta aOAMPaletteBuffer.aPalette7,b,x
        dec x
        dec x
        bpl _C5A7
        lda #$0005
        jsl rlUnitWindowCopySpritePalette2
        jsl rlUnitWindowCopyAllEquippedWeaponIcons
        rts

        .databank 0

        ; 80/C5BE

    .endsection Unsorted80C3E6Section


    .section Unsorted80C5C6Section

      .al
      .xl

      rlUnitWindowCopyAllEquippedWeaponIcons ; 80/C5C6

        .al
        .xl
        .autsiz
        .databank ?

        ; FE5: rlUnitWindowFE4CopyAllEquippedWeaponIcons.

        lda #$0000

        _C5C9
        sta wUnitWindowCurrentItemIconSlot
        asl a
        tax
        lda aUnitWindowDeploymentSlots,x
        beq _C5F7
        sta wSelectedUnitDataRAMPointer,b
        jsl rlUnitWindowGetEquippedWeaponID
        pha
        lda wUnitWindowCurrentItemIconSlot
        asl a
        tax
        lda aUnitWindowWeaponIconTiles,x
        tax
        pla
        jsl rlCopyItemIcon
        lda wUnitWindowCurrentItemIconSlot
        inc a
        cmp #$0018
        bne _C5C9

        _C5F7
        rtl

        .databank 0

        ; 80/C5F8

    .endsection Unsorted80C5C6Section


    .section Data80C5F8Section

      .al
      .xl

      aUnitWindowWeaponIconTiles ; 80/C5F8

        ; Read by rlUnitWindowCopyAllEquippedWeaponIcons.

        .word $00E0, $00E2, $00E4, $00E6, $00E8, $00EA, $00EC, $00EE
        .word $0100, $0102, $0104, $0106, $0108, $010A, $010C, $010E
        .word $0120, $0122, $0124, $0126, $0128, $012A, $012C, $012E

        ; 80/C628

    .endsection Data80C5F8Section


    .section Unsorted80C628Section

      .al
      .xl

      rsUnitWindowSetBGSettings ; 80/C628

        .al
        .xl
        .autsiz
        .databank ?

        ; FE5: rsUnitWindowSetBGSettings.

        sep #$20
        lda bBufferBG1SC
        and #$FC
        ora #$02
        sta bBufferBG1SC
        lda bBufferBG2SC
        and #$FC
        ora #$02
        sta bBufferBG2SC
        lda bBufferBG3SC
        and #$FC
        ora #$02
        sta bBufferBG3SC
        lda #$15
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
        lda #$81
        sta bBufferCGADSUB
        lda #$E0
        sta bBufferCOLDATA_1
        sta bBufferCOLDATA_2
        sta bBufferCOLDATA_3
        rep #$20
        stz wBufferBG1HOFS
        stz wBufferBG3HOFS
        stz wBufferBG2HOFS
        stz wBufferBG2VOFS
        lda #$0000
        sta wBufferBG1VOFS
        sta wBufferBG3VOFS
        rts

        .databank 0

        ; 80/C694

      rsUnitWindowSetHDMA ; 80/C694

        .al
        .xl
        .autsiz
        .databank ?

        ; Sets up the HDMA that scrolls the BG layers. FE5: rlUnitWindowFE4SetHDMA.

        lda #(`aUnitWindowBG3VOFSHDMAInfo)<<8
        sta lR44+1
        lda #<>aUnitWindowBG3VOFSHDMAInfo
        sta lR44
        jsl rlHDMAEngineCreateEntry
        lda #(`aUnitWindowBG1VOFSHDMAInfo)<<8
        sta lR44+1
        lda #<>aUnitWindowBG1VOFSHDMAInfo
        sta lR44
        jsl rlHDMAEngineCreateEntry
        lda #(`aUnitWindowCGADSUBHDMAInfo)<<8
        sta lR44+1
        lda #<>aUnitWindowCGADSUBHDMAInfo
        sta lR44
        jsl rlHDMAEngineCreateEntry
        lda #(`aUnitWindowBG2VOFSHDMAInfo)<<8
        sta lR44+1
        lda #<>aUnitWindowBG2VOFSHDMAInfo
        sta lR44
        jsl rlHDMAEngineCreateEntry
        rts

        .databank 0

        ; 80/C6CD

    .endsection Unsorted80C628Section


    .section Table80C6CDSection

      .al
      .xl

      aUnitWindowBG3VOFSHDMAInfo .dstruct structHDMADirectEntryInfo, rlUnitWindowBG3VOFSHDMAInit, rlUnitWindowBG3VOFSHDMACycle, aUnitWindowBG3VOFSHDMACode, $7FB038, PPU_REG_BASE + $12, $02 ; 80/C6CD

    .endsection Table80C6CDSection


    .section Unsorted80C6D8Section

      .al
      .xl

      rlUnitWindowBG3VOFSHDMAInit ; 80/C6D8

        .al
        .xl
        .autsiz
        .databank ?

        ; FE5: rlUnitWindowBG3VOFSHDMAInit.

        rtl

        .databank 0

        ; 80/C6D9

      rlUnitWindowBG3VOFSHDMACycle ; 80/C6D9

        .al
        .xl
        .autsiz
        .databank ?

        ; FE5: rlUnitWindowBG3VOFSHDMAOnCycle.

        lda wUnitWindowPageScrollFlag
        bne _C715
        sep #$20
        lda #$35
        sta $7FB038
        rep #$20
        lda #$0000
        sta $7FB039
        sep #$20
        lda #$01
        sta $7FB03B
        rep #$20
        lda wUnitWindowScrollPixels
        inc a
        inc a
        sta $7FB03C
        sep #$20
        lda #$00
        sta $7FB03E
        rep #$20
        lda #$0000
        sta $7FB03F

        _C715
        rtl

        .databank 0

        ; 80/C716

    .endsection Unsorted80C6D8Section


    .section Table80C716Section

      .al
      .xl

      aUnitWindowBG3VOFSHDMACode ; 80/C716
        HDMA_HALT

      aUnitWindowBG1VOFSHDMAInfo .dstruct structHDMADirectEntryInfo, rlUnitWindowBG1VOFSHDMAInit, rlUnitWindowBG1VOFSHDMACycle, aUnitWindowBG1VOFSHDMACode, $7FB020, PPU_REG_BASE + $0E, $02 ; 80/C718

    .endsection Table80C716Section


    .section Unsorted80C723Section

      .al
      .xl

      rlUnitWindowBG1VOFSHDMAInit ; 80/C723

        .al
        .xl
        .autsiz
        .databank ?

        ; FE5: rlUnitWindowBG1VOFSHDMAInit.

        rtl

        .databank 0

        ; 80/C724

      rlUnitWindowBG1VOFSHDMACycle ; 80/C724

        .al
        .xl
        .autsiz
        .databank ?

        ; FE5: rlUnitWindowBG1VOFSHDMAOnCycle.

        lda wUnitWindowPageScrollFlag
        bne _C75F
        sep #$20
        lda #$35
        sta $7FB020
        rep #$20
        lda #$FFFF
        sta $7FB021
        sep #$20
        lda #$01
        sta $7FB023
        rep #$20
        lda wUnitWindowScrollPixels
        dec a
        sta $7FB024
        sep #$20
        lda #$00
        sta $7FB026
        rep #$20
        lda #$0000
        sta $7FB027

        _C75F
        rtl

        .databank 0

        ; 80/C760

    .endsection Unsorted80C723Section


    .section Table80C760Section

      .al
      .xl

      aUnitWindowBG1VOFSHDMACode ; 80/C760
        HDMA_HALT

      aUnitWindowCGADSUBHDMAInfo .dstruct structHDMADirectEntryInfo, rlUnitWindowCGADSUBHDMAInit, rlUnitWindowCGADSUBHDMACycle, aUnitWindowCGADSUBHDMACode, $7FB0B6, PPU_REG_BASE + $31, $03 ; 80/C762

    .endsection Table80C760Section


    .section Unsorted80C76DSection

      .al
      .xl

      rlUnitWindowCGADSUBHDMAInit ; 80/C76D

        .al
        .xl
        .autsiz
        .databank ?

        ; FE5: rlUnitWindowCGADSUBHDMAInit.

        rtl

        .databank 0

        ; 80/C76E

      rlUnitWindowCGADSUBHDMACycle ; 80/C76E

        .al
        .xl
        .autsiz
        .databank ?

        ; FE5: rlUnitWindowCGADSUBHDMAOnCycle.

        lda wUnitWindowPageScrollFlag
        beq _C778
        jml _C889


        _C778
        ldx #$0000
        sep #$20
        lda #$08
        sta $7FB0B6
        rep #$20
        lda #$0000
        sta $7FB0B7
        lda #$E000
        sta $7FB0B9
        inc x
        inc x
        inc x
        inc x
        inc x
        sep #$20
        lda #$10
        sta $7FB0B6,x
        rep #$20
        lda #$8181
        sta $7FB0B7,x
        lda #$E000
        sta $7FB0B9,x
        inc x
        inc x
        inc x
        inc x
        inc x
        sep #$20
        lda #$0A
        sta $7FB0B6,x
        rep #$20
        lda #$8181
        sta $7FB0B7,x
        lda #$E100
        sta $7FB0B9,x
        inc x
        inc x
        inc x
        inc x
        inc x
        sep #$20
        lda #$10
        sta $7FB0B6,x
        rep #$20
        lda #$8181
        sta $7FB0B7,x
        lda #$E100
        sta $7FB0B9,x
        inc x
        inc x
        inc x
        inc x
        inc x
        sep #$20
        lda #$05
        sta $7FB0B6,x
        rep #$20
        lda #$8181
        sta $7FB0B7,x
        lda #$E200
        sta $7FB0B9,x
        inc x
        inc x
        inc x
        inc x
        inc x
        lda #$0000
        sta wUnitWindowProcessingHighlightLine
        lda #$0000
        sta wUnitWindowProcessingHighlightOffset

        _C81A
        phx
        lda wUnitWindowProcessingHighlightLine
        tax
        lda $7FB044,x
        sta wR0
        inc x
        txa
        sta wUnitWindowProcessingHighlightLine
        plx
        lda wR0
        and #$00FF
        sep #$20
        sta $7FB0B6,x
        rep #$20
        phx
        lda wUnitWindowProcessingHighlightOffset
        tax
        tay
        lda $7FB062,x
        plx
        sep #$20
        sta $7FB0B7,x
        sta $7FB0B8,x
        rep #$20
        phx
        tyx
        lda $7FB063,x
        sta @l wR0
        txa
        clc
        adc #$0003
        sta wUnitWindowProcessingHighlightOffset
        plx
        lda @l wR0
        sta $7FB0B9,x
        inc x
        inc x
        inc x
        inc x
        inc x
        cpx #$00A0
        bne _C81A
        sep #$20
        lda #$00
        sta $7FB0B6,x
        rep #$20
        lda #$0000
        sta $7FB0B7,x

        _C889
        rtl

        .databank 0

        ; 80/C88A

    .endsection Unsorted80C76DSection


    .section Table80C88ASection

      .al
      .xl

      aUnitWindowCGADSUBHDMACode ; 80/C88A
        HDMA_HALT

      aUnitWindowBG2VOFSHDMAInfo .dstruct structHDMADirectEntryInfo, rlUnitWindowBG2VOFSHDMAInit, rlUnitWindowBG2VOFSHDMACycle, $C8D3, $7FB02C, PPU_REG_BASE + $10, $02 ; 80/C88C

    .endsection Table80C88ASection


    .section Unsorted80C897Section

      .al
      .xl

      rlUnitWindowBG2VOFSHDMAInit ; 80/C897

        .al
        .xl
        .autsiz
        .databank ?

        ; FE5: rlUnitWindowBG2VOFSHDMAInit.

        rtl

        .databank 0

        ; 80/C898

      rlUnitWindowBG2VOFSHDMACycle ; 80/C898

        .al
        .xl
        .autsiz
        .databank ?

        ; FE5: rlUnitWindowBG2VOFSHDMAOnCycle.

        lda wUnitWindowPageScrollFlag
        bne _C8D2
        sep #$20
        lda #$35
        sta $7FB02C
        rep #$20
        lda #$FFFF
        sta $7FB02D
        sep #$20
        lda #$01
        sta $7FB02F
        rep #$20
        lda wUnitWindowScrollPixels
        sta $7FB030
        sep #$20
        lda #$00
        sta $7FB032
        rep #$20
        lda #$0000
        sta $7FB033

        _C8D2
        rtl

        .databank 0

        ; 80/C8D3


      aUnitWindowBG2VOFSHDMACode ; 80/C8D3

        HDMA_HALT

    .endsection Unsorted80C897Section


    .section Unsorted80C8D5Section

      .al
      .xl

      rsUnitWindowGetUnits ; 80/C8D5

        .al
        .xl
        .autsiz
        .databank ?

        ; Gets the unit count and deployment slots for the list. FE5: rsUnitWindowFE4GetUnits.

        lda #$0000
        sta wR0
        sta wR1
        jsl rlGetFactionSlotUnitCount
        sta wUnitWindowMaxRows
        lda #$0001
        sta wRoutineVariable1,b

        _C8EA
        lda #$0000
        jsl rlGetUnitRAMDataPointerByFactionSlotEntryID
        lda wSelectedUnitDataRAMPointer,b
        beq _C919
        jsl rlGetSelectedUnitStatus
        cmp #StatusCaptive
        beq _C908
        jsl rlGetSelectedUnitStates
        bit #UnitStateDead
        beq _C90C

        _C908
        inc wR1
        bra _C919


        _C90C
        lda wR0
        asl a
        tax
        lda wSelectedUnitDataRAMPointer,b
        sta aUnitWindowDeploymentSlots,x
        inc wR0

        _C919
        lda wRoutineVariable1,b
        inc a
        sta wRoutineVariable1,b
        cmp #$0019
        bne _C8EA
        lda wR1
        sta wUnitWindowSkippedUnitCount
        lda wUnitWindowMaxRows
        sec
        sbc wR1
        sta wUnitWindowMaxRows
        sec
        sbc #$000A
        bpl _C93F
        lda #$0000

        _C93F
        sta wUnitWindowCanScrollDownFlag
        lda wUnitWindowMaxRows
        asl a
        tax
        lda #$0000
        sta aUnitWindowDeploymentSlots,x
        rts

        .databank 0

        ; 80/C951

      rsUnitWindowBuildList ; 80/C951

        .al
        .xl
        .autsiz
        .databank ?

        ; Builds the list: draws the window's BG3 and row tilemaps for wUnitWindowMaxRows rows, restores the order saved by rlUnitWindowSaveListOrder if the window was open before, sorts by wUnitWindowSortType and wUnitWindowSortDirection, then draws names and skills.

        lda #$00CE
        jsl rlUnitWindowFillBG3Buffer
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $1000, $80, $B000

        jsl rlDMAByStruct

          .structDMAToVRAM gUnitWindowListTilemap, $01C0, $80, $5000

        lda wUnitWindowMaxRows
        cmp #$000A
        bcs _C97E
        lda #$000A

        _C97E
        xba
        lsr a
        sec
        sbc #$0040
        sta wR0
        phk
        plb
        .databank $80
        ldx #$0000
        ldy #$0000

        _C98E
        cpy #$00C0
        bne _C996
        ldy #$0000

        _C996
        lda <>aUnitWindowListHeaderTiles0,b,y
        sta $7E7548,x
        inc x
        inc x
        inc y
        inc y
        txa
        cmp @l wR0
        bne _C98E
        phk
        plb
        .databank $80
        ldy #$0000

        _C9AD
        lda <>aUnitWindowListHeaderTiles1,b,y
        sta $7E7548,x
        inc x
        inc x
        inc y
        inc y
        cpy #$0080
        bne _C9AD
        jsl rlUnitWindowGetUnitSpriteInfos
        lda bUnitWindowHasSavedOrder
        and #$00FF
        beq _C9E9
        lda wUnitWindowSortType
        sta $7F82F7
        lda #UNIT_WINDOW_SORT_SAVED_ORDER
        sta wUnitWindowSortType
        jsl rlUnitWindowGetSortScores
        jsl rlUnitWindowSetSortDescending
        lda $7F82F7
        sta wUnitWindowSortType

        _C9E9
        jsl rlUnitWindowGetSortScores
        lda wUnitWindowSortDirection
        bne _C9F9
        jsl rlUnitWindowSetSortDescending
        bra _C9FD


        _C9F9
        jsl rlUnitWindowSetSortAscending

        _C9FD
        sep #$20
        lda #$01
        sta bUnitWindowHasSavedOrder
        rep #$20
        jsl rlUnitWindowGetPromotionFlagsAndWeapons
        jsl rlUnitWindowDrawUnitNames
        jsl rlUnitWindowDrawPage
        jsl rlDMAByStruct

          .structDMAToVRAM $7E7548, $0E40, $80, $51C0

        jsl rlUnitWindowDrawUnitSkills
        rts

        .databank 0

        ; 80/CA25

    .endsection Unsorted80C8D5Section


    .section Data80CA25Section

      .al
      .xl

      aUnitWindowListHeaderTiles0 ; 80/CA25

        ; Read by rsUnitWindowBuildList.

        .word $0322, $0308, $0309, $030A, $030B, $030C, $030D, $030E
        .word $0308, $0309, $030A, $030B, $030C, $030D, $030E, $0308
        .word $0309, $030A, $030B, $030C, $030D, $030E, $0308, $0309
        .word $030A, $030B, $030C, $030D, $030E, $0308, $0309, $0323
        .word $0322, $0318, $0319, $031A, $031B, $031C, $031D, $031E
        .word $0318, $0319, $031A, $031B, $031C, $031D, $031E, $0318
        .word $0319, $031A, $031B, $031C, $031D, $031E, $0318, $0319
        .word $031A, $031B, $031C, $031D, $031E, $0318, $0319, $0323
        .word $0322, $0328, $0329, $032A, $032B, $032C, $032D, $032E
        .word $0328, $0329, $032A, $032B, $032C, $032D, $032E, $0328
        .word $0329, $032A, $032B, $032C, $032D, $032E, $0328, $0329
        .word $032A, $032B, $032C, $032D, $032E, $0328, $0329, $0323
        .word $0322, $0338, $0339, $033A, $033B, $033C, $033D, $033E
        .word $0338, $0339, $033A, $033B, $033C, $033D, $033E, $0338
        .word $0339, $033A, $033B, $033C, $033D, $033E, $0338, $0339
        .word $033A, $033B, $033C, $033D, $033E, $0338, $0339, $0323

        ; 80/CB25

      aUnitWindowListHeaderTiles1 ; 80/CB25

        ; Read by rsUnitWindowBuildList.

        .word $0304, $0305, $0308, $0309, $030A, $030B, $030C, $030D
        .word $030C, $030D, $030E, $0308, $0309, $030A, $030B, $030C
        .word $030D, $030E, $0308, $0309, $030A, $030B, $030C, $030D
        .word $030E, $0308, $0309, $030A, $030B, $030C, $0306, $0307
        .word $0314, $0315, $0321, $0321, $0321, $0321, $0321, $0321
        .word $0321, $0321, $0321, $0321, $0321, $0321, $0321, $0321
        .word $0321, $0321, $0321, $0321, $0321, $0321, $0321, $0321
        .word $0321, $0321, $0321, $0321, $0321, $0321, $0316, $0317

        ; 80/CBA5

    .endsection Data80CA25Section


    .section Unsorted80CBA5Section

      .al
      .xl

      rlUnitWindowDrawUnitNames ; 80/CBA5

        .al
        .xl
        .autsiz
        .databank ?

        ; FE5: rlUnitWindowFE4DrawUnitNames.

        phk
        plb
        .databank $80
        lda #(`aUnitWindowBG3TilemapEntry)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aUnitWindowBG3TilemapEntry
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$0000

        _CBB6
        sta wUnitWindowCurrentNameLine
        tax
        lda aUnitWindowDeploymentSlots,x
        beq _CC04
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitNamePointer
        lda #$2000
        sta aCurrentTilemapInfo,b
        jsl rlGetSelectedUnitStates
        bit #UnitStateMoved
        bne _CBE0
        jsl rlGetSelectedUnitStatus
        cmp #StatusSleep
        bne _CBE6

        _CBE0
        lda #$2400
        sta aCurrentTilemapInfo,b

        _CBE6
        lda wUnitWindowCurrentNameLine
        tay
        ldx <>aUnitWindowUnitNamePositions,b,y
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        jsl rlDrawMenuTextLine
        lda wUnitWindowCurrentNameLine
        inc a
        inc a
        bra _CBB6


        _CC04
        rtl

        .databank 0

        ; 80/CC05

    .endsection Unsorted80CBA5Section


    .section Data80CC05Section

      .al
      .xl

      aUnitWindowUnitNamePositions ; 80/CC05

        ; Read by rlUnitWindowDrawUnitNames.

        .word $0704, $0904, $0B04, $0D04, $0F04, $1104, $1304, $1504
        .word $1704, $1904, $1B04, $1D04, $1F04, $2104, $2304, $2504
        .word $2704, $2904, $2B04, $2D04, $2F04, $3104, $3304, $3504

        ; 80/CC35

    .endsection Data80CC05Section


    .section Unsorted80CC35Section

      .al
      .xl

      rlUnitWindowDrawUnitSkills ; 80/CC35

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws the units' skill icons. FE5: rlUnitWindowFE4DrawUnitSkills.

        lda #$0324
        ldx #$1000

        _CC3B
        sta $7E7386,x
        dec x
        dec x
        bne _CC3B
        lda #$0000

        _CC46
        sta wR15
        asl a
        tax
        lda aUnitWindowDeploymentSlots,x
        beq _CCC5
        sta wSelectedUnitDataRAMPointer,b
        jsl rlCollectSelectedUnitIconSkills
        lda $7E2000
        beq _CCBD
        lda #$0000
        sta wR12

        _CC62
        sta wR14
        tax
        lda $7E2002,x
        and #$00FF
        sta wR13
        beq _CCB5
        txa
        asl a
        tax
        lda aUnitWindowSkillIconTiles,x
        beq _CCB5
        sta wR13
        lda wR12
        asl a
        tax
        lda aUnitWindowSkillIconColumnOffsets,x
        sta wR0
        lda wR15
        asl a
        tax
        lda aUnitWindowSkillIconRowOffsets,x
        ora wR0
        sta wR0
        lda wR13
        ldx wR0
        sta aBG2TilemapBuffer,x
        inc a
        sta $7E738A,x
        txa
        clc
        adc #$0040
        tax
        lda wR13
        clc
        adc #$0010
        sta aBG2TilemapBuffer,x
        inc a
        sta $7E738A,x
        inc wR12

        _CCB5
        lda wR14
        inc a
        cmp #$001D
        bne _CC62

        _CCBD
        lda wR15
        inc a
        cmp #$0018
        bne _CC46

        _CCC5
        jsl rlDMAByStruct

          .structDMAToVRAM $7E7548, $0C80, $80, $21C0

        rtl

        .databank 0

        ; 80/CCD3

    .endsection Unsorted80CC35Section


    .section Data80CCD3Section

      .al
      .xl

      aUnitWindowSkillIconColumnOffsets ; 80/CCD3

        ; Read by rlUnitWindowDrawUnitSkills.

        .word $001A, $0020, $0026, $002C, $0032, $0038, $003A, $003C

        ; 80/CCE3

      aUnitWindowSkillIconRowOffsets ; 80/CCE3

        ; Read by rlUnitWindowDrawUnitSkills.

        .byte $C0, $01, $40, $02, $C0, $02, $40, $03, $C0, $03, $40, $04, $C0, $04, $40, $05
        .byte $C0, $05, $40, $06, $C0, $06, $40, $07, $C0, $07, $40, $08, $C0, $08, $40, $09
        .byte $C0, $09, $40, $0A, $C0, $0A, $40, $0B, $C0, $0B, $40, $0C, $C0, $0C, $40, $0D

      aItemWindowBG3TilemapEntry ; 80/CD13
        .byte $20, $20, $00, $00, $00, $00, $88, $83, $7E

      aItemWindowListTilemapEntry ; 80/CD1C
        .byte $10, $00, $00, $00, $00, $00, $D0, $89, $7F

      aItemWindowDescTilemapEntry ; 80/CD25
        .byte $30, $01, $00, $00, $00, $00, $50, $AF, $7F

        ; 80/CD2E

    .endsection Data80CCD3Section


    .section Table8BA845Section

      .al
      .xl

      aUnitWindowPageTurnInputHandlers ; 8B/A845

        ; One per page (wGameStateStep).
        .word <>rsUnitWindowHandlePage0Turn
        .word <>rsUnitWindowHandlePage1Turn
        .word <>rsUnitWindowHandlePage2Turn
        .word <>rsUnitWindowHandlePage3Turn
        .word <>rsUnitWindowHandlePage4Turn
        .word <>rsUnitWindowHandlePage5Turn

    .endsection Table8BA845Section


    .section UnitWindowPageTurnHandlersSection

      .al
      .xl

      rsUnitWindowHandlePage1Turn ; 8B/ACAD

        .al
        .xl
        .autsiz
        .databank ?

        ; Entry 1 of the page-turn table: right turns to page 2, left to page 0.

        lda wJoy1Input
        bit #$0C00
        bne _ACC0
        lda wJoy1Repeated
        bit #$0100
        bne _ACC1
        bit #$0200
        bne _ACD7

        _ACC0
        rts


        _ACC1
        inc wGameStateStep,b
        jsl rlUnitWindowDrawPage
        lda #$FFFF
        sta wUnitWindowPageScrollFlag
        lda #$0007
        jsl rlPlaySoundEffect
        rts


        _ACD7
        dec wGameStateStep,b
        jsl rlUnitWindowDrawPage
        lda #$FFFF
        sta wUnitWindowPageScrollFlag
        lda #$0007
        jsl rlPlaySoundEffect
        rts

        .databank 0

        ; 8B/ACED

      rsUnitWindowHandlePage2Turn ; 8B/ACED

        .al
        .xl
        .autsiz
        .databank ?

        ; Entry 2 of the page-turn table: right turns to page 3; left redraws the item icons and turns to page 1.

        lda wJoy1Input
        bit #$0C00
        bne _AD00
        lda wJoy1Repeated
        bit #$0100
        bne _AD01
        bit #$0200
        bne _AD17

        _AD00
        rts


        _AD01
        inc wGameStateStep,b
        jsl rlUnitWindowDrawPage
        lda #$FFFF
        sta wUnitWindowPageScrollFlag
        lda #$0007
        jsl rlPlaySoundEffect
        rts


        _AD17
        jsr rsUnitWindowRenderItemIcons
        dec wGameStateStep,b
        jsl rlUnitWindowDrawPage
        lda #$FFFF
        sta wUnitWindowPageScrollFlag
        lda #$0007
        jsl rlPlaySoundEffect
        rts

        .databank 0

        ; 8B/AD30

      rsUnitWindowHandlePage3Turn ; 8B/AD30

        .al
        .xl
        .autsiz
        .databank ?

        ; Entry 3 of the page-turn table: right draws the weapon rank icons and turns to page 4; left turns to page 2.

        lda wJoy1Input
        bit #$0C00
        bne _AD43
        lda wJoy1Repeated
        bit #$0100
        bne _AD44
        bit #$0200
        bne _AD5D

        _AD43
        rts


        _AD44
        jsr rsUnitWindowRenderWeaponRankIcons
        inc wGameStateStep,b
        jsl rlUnitWindowDrawPage
        lda #$FFFF
        sta wUnitWindowPageScrollFlag
        lda #$0007
        jsl rlPlaySoundEffect
        rts


        _AD5D
        dec wGameStateStep,b
        jsl rlUnitWindowDrawPage
        lda #$FFFF
        sta wUnitWindowPageScrollFlag
        lda #$0007
        jsl rlPlaySoundEffect
        rts

        .databank 0

        ; 8B/AD73

      rsUnitWindowHandlePage4Turn ; 8B/AD73

        .al
        .xl
        .autsiz
        .databank ?

        ; Entry 4 of the page-turn table: right sets the main screen layers to $17 and turns to page 5; left turns to page 3.

        lda wJoy1Input
        bit #$0C00
        bne _AD86
        lda wJoy1Repeated
        bit #$0100
        bne _AD87
        bit #$0200
        bne _ADA5

        _AD86
        rts


        _AD87
        sep #$20
        lda #$17
        sta bBufferTM
        rep #$20
        inc wGameStateStep,b
        jsl rlUnitWindowDrawPage
        lda #$FFFF
        sta wUnitWindowPageScrollFlag
        lda #$0007
        jsl rlPlaySoundEffect
        rts


        _ADA5
        dec wGameStateStep,b
        jsl rlUnitWindowDrawPage
        lda #$FFFF
        sta wUnitWindowPageScrollFlag
        lda #$0007
        jsl rlPlaySoundEffect
        rts

        .databank 0

        ; 8B/ADBB

      rsUnitWindowHandlePage5Turn ; 8B/ADBB

        .al
        .xl
        .autsiz
        .databank ?

        ; Entry 5 of the page-turn table: right does nothing (last page); left sets the main screen layers back to $15, draws the weapon rank icons and turns to page 4.

        lda wJoy1Input
        bit #$0C00
        bne _ADCE
        lda wJoy1Repeated
        bit #$0100
        bne _ADCF
        bit #$0200
        bne _ADD0

        _ADCE
        rts


        _ADCF
        rts


        _ADD0
        sep #$20
        lda #$15
        sta bBufferTM
        rep #$20
        jsr rsUnitWindowRenderWeaponRankIcons
        dec wGameStateStep,b
        jsl rlUnitWindowDrawPage
        lda #$FFFF
        sta wUnitWindowPageScrollFlag
        lda #$0007
        jsl rlPlaySoundEffect
        rts

        .databank 0

        ; 8B/ADF1

    .endsection UnitWindowPageTurnHandlersSection


    .section UnitWindowPageDrawersSection

      .al
      .xl

      aUnitWindowPageDrawers .word <>rsUnitWindowDrawPage0, <>rsUnitWindowDrawPage1, <>rsUnitWindowDrawPage2, <>rsUnitWindowDrawPage3, <>rsUnitWindowDrawPage4, <>rsUnitWindowDrawPage5 ; 8B/AE12

    .endsection UnitWindowPageDrawersSection


    .section UnitWindowDrawPagesSection

      .al
      .xl

      aUnitWindowHPSlashText ; 8B/AF3B

        .enc "SJIS"
        .text "／\n"


      rsUnitWindowDrawPage1 ; 8B/AF3F

        .al
        .xl
        .autsiz
        .databank ?

        ; Entry 1 of aUnitWindowPageDrawers: each line's equipped weapon and its battle stats (might and the rest); dashes for a unit with no weapon.

        lda #$0007
        sta wR14
        stz wR15

        _AF46
        ldx wR15
        lda aUnitWindowDeploymentSlots,x
        bne _AF52
        jml _B0AA


        _AF52
        sta wSelectedUnitDataRAMPointer,b
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda aUnitWindowEquippedWeaponPointers,x
        sta wCurrentItemDataROMPointer,b
        beq _AF82
        jsl rlGetItemNamePointer
        lda wR14
        and #$00FF
        xba
        ora #$000C
        tax
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        jsl rlDrawMenuTextLine
        bra _AF9A


        _AF82
        lda #(`aUnitWindowNoValueText6)<<8
        sta lR18+1
        lda #<>aUnitWindowNoValueText6
        sta lR18
        lda wR14
        and #$00FF
        xba
        ora #$000C
        tax
        jsl rlDrawMenuTextLine

        _AF9A
        lda wCurrentItemDataROMPointer,b
        beq _AFC8
        lda #$0000
        sta wRoutineVariable1,b
        jsl rlGetFirstWeaponBattleMight
        tay
        lda wR14
        and #$00FF
        xba
        lsr a
        lsr a
        clc
        adc #$0028
        tax
        lda #$3920
        sta wR5
        lda #$0002
        sta wR6
        tya
        jsl rlDrawMenuTextNumber
        bra _AFE6


        _AFC8
        lda #$3800
        sta aCurrentTilemapInfo,b
        lda #(`aUnitWindowNoValueText2)<<8
        sta lR18+1
        lda #<>aUnitWindowNoValueText2
        sta lR18
        lda wR14
        and #$00FF
        xba
        ora #$0014
        tax
        jsl rlDrawMenuTextLine

        _AFE6
        lda wCurrentItemDataROMPointer,b
        beq _B00E
        jsl rlGetSelectedUnitFirstWeaponHit
        tay
        lda wR14
        and #$00FF
        xba
        lsr a
        lsr a
        clc
        adc #$002E
        tax
        lda #$3520
        sta wR5
        lda #$0003
        sta wR6
        tya
        jsl rlDrawMenuTextNumber
        bra _B02C


        _B00E
        lda #$3400
        sta aCurrentTilemapInfo,b
        lda #(`aUnitWindowNoValueText3)<<8
        sta lR18+1
        lda #<>aUnitWindowNoValueText3
        sta lR18
        lda wR14
        and #$00FF
        xba
        ora #$0017
        tax
        jsl rlDrawMenuTextLine

        _B02C
        lda #$FFFF
        jsl rlGetSelectedUnitFirstWeaponAvoid
        tay
        cmp #$0000
        bpl _B082
        lda wR14
        and #$00FF
        xba
        lsr a
        lsr a
        clc
        adc #$0036
        tax
        lda #$3920
        sta wR5
        lda #$0003
        sta wR6
        tya
        eor #$FFFF
        inc a
        jsl rlDrawMenuTextNumber
        sta wR5
        lda #$001D
        sec
        sbc wR5
        sta wR5
        lda #$3800
        sta aCurrentTilemapInfo,b
        lda #(`aUnitWindowNoValueText1)<<8
        sta lR18+1
        lda #<>aUnitWindowNoValueText1
        sta lR18
        lda wR14
        and #$00FF
        xba
        ora wR5
        tax
        jsl rlDrawMenuTextLine
        bra _B09E


        _B082
        lda wR14
        and #$00FF
        xba
        lsr a
        lsr a
        clc
        adc #$0036
        tax
        lda #$3920
        sta wR5
        lda #$0003
        sta wR6
        tya
        jsl rlDrawMenuTextNumber

        _B09E
        inc wR14
        inc wR14
        inc wR15
        inc wR15
        jml _AF46


        _B0AA
        jsl rlDMAByStruct

          .structDMAToVRAM gUnitWindowPage1Tilemap, $0140, $80, $B040

        jsl rlDMAByStruct

          .structDMAToVRAM $7E8548, $0C00, $80, $B1C0

        rts

        .databank 0

        ; 8B/B0C5

      aUnitWindowNoValueText2 ; 8B/B0C5

        .enc "SJIS"
        .text "ーー\n"

      aUnitWindowNoValueText6 ; 8B/B0CB

        .text "ーーーーーー\n"

      aUnitWindowNoValueText1 ; 8B/B0D9

        .text "ー\n"

      aUnitWindowNoValueText3 ; 8B/B0DD

        .text "ーーー\n"


      rsUnitWindowDrawPage2 ; 8B/B0E5

        .al
        .xl
        .autsiz
        .databank ?

        ; Entry 2 of aUnitWindowPageDrawers: each line's strength, magic, skill, speed, luck, defense and resistance.

        lda #$0007
        sta wR14
        stz wR15

        _B0EC
        ldx wR15
        lda aUnitWindowDeploymentSlots,x
        bne _B0F8
        jml _B1EE


        _B0F8
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitTotalStrength
        tay
        lda wR14
        and #$00FF
        xba
        lsr a
        lsr a
        clc
        adc #$0014
        tax
        lda #$3920
        sta wR5
        lda #$0002
        sta wR6
        tya
        jsl rlDrawMenuTextNumber
        jsl rlGetSelectedUnitTotalMagic
        tay
        lda wR14
        and #$00FF
        xba
        lsr a
        lsr a
        clc
        adc #$001A
        tax
        lda #$3520
        sta wR5
        lda #$0002
        sta wR6
        tya
        jsl rlDrawMenuTextNumber
        jsl rlGetSelectedUnitTotalSkill
        tay
        lda wR14
        and #$00FF
        xba
        lsr a
        lsr a
        clc
        adc #$0020
        tax
        lda #$3920
        sta wR5
        lda #$0002
        sta wR6
        tya
        jsl rlDrawMenuTextNumber
        jsl rlGetSelectedUnitTotalSpeed
        tay
        lda wR14
        and #$00FF
        xba
        lsr a
        lsr a
        clc
        adc #$0026
        tax
        lda #$3520
        sta wR5
        lda #$0002
        sta wR6
        tya
        jsl rlDrawMenuTextNumber
        jsl rlGetSelectedUnitLuck
        tay
        lda wR14
        and #$00FF
        xba
        lsr a
        lsr a
        clc
        adc #$002C
        tax
        lda #$3920
        sta wR5
        lda #$0002
        sta wR6
        tya
        jsl rlDrawMenuTextNumber
        jsl rlGetSelectedUnitTotalDefense
        tay
        lda wR14
        and #$00FF
        xba
        lsr a
        lsr a
        clc
        adc #$0032
        tax
        lda #$3520
        sta wR5
        lda #$0002
        sta wR6
        tya
        jsl rlDrawMenuTextNumber
        jsl rlGetSelectedUnitTotalResistance
        tay
        lda wR14
        and #$00FF
        xba
        lsr a
        lsr a
        clc
        adc #$0038
        tax
        lda #$3920
        sta wR5
        lda #$0002
        sta wR6
        tya
        jsl rlDrawMenuTextNumber
        inc wR14
        inc wR14
        inc wR15
        inc wR15
        jml _B0EC


        _B1EE
        jsl rlDMAByStruct

          .structDMAToVRAM gUnitWindowPage2Tilemap, $0140, $80, $B040

        jsl rlDMAByStruct

          .structDMAToVRAM $7E8548, $0C00, $80, $B1C0

        rts

        .databank 0

        ; 8B/B209

      rsUnitWindowDrawPage3 ; 8B/B209

        .al
        .xl
        .autsiz
        .databank ?

        ; Entry 3 of aUnitWindowPageDrawers: each line's movement, money, arena level and talk target.

        lda #$2000
        sta aCurrentTilemapInfo,b
        lda #$0007
        sta wR14
        lda #$0000
        sta wR15

        _B219
        ldx wR15
        lda aUnitWindowDeploymentSlots,x
        bne _B225
        jml _B30E


        _B225
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitTotalMovement
        tay
        lda wR14
        and #$00FF
        xba
        lsr a
        lsr a
        clc
        adc #$0016
        tax
        lda #$3920
        sta wR5
        lda #$0002
        sta wR6
        tya
        jsl rlDrawMenuTextNumber
        jsl rlGetSelectedUnitMoney
        tay
        lda wR14
        and #$00FF
        xba
        lsr a
        lsr a
        clc
        adc #$001E
        tax
        lda #$3520
        sta wR5
        lda #$0005
        sta wR6
        tya
        jsl rlDrawMenuTextNumber
        jsl rlGetSelectedUnitArenaLevel
        inc a
        cmp #$0008
        beq _B293
        tay
        lda wR14
        and #$00FF
        xba
        lsr a
        lsr a
        clc
        adc #$002C
        tax
        lda #$3920
        sta wR5
        lda #$0001
        sta wR6
        tya
        jsl rlDrawMenuTextNumber
        bra _B2AF


        _B293
        lda wR14
        xba
        lsr a
        lsr a
        sta wR0
        lda #$002C
        clc
        adc wR0
        tax
        lda #$39E4
        sta aBG3TilemapBuffer,x
        lda #$39F4
        sta $7E83C8,x

        _B2AF
        lda @l wSelectedUnitDataRAMPointer
        pha
        jsl rlGetSelectedUnitLivingTalkTarget
        cmp #$0000
        beq _B2D9
        jsl rlGetUnitRAMDataPointerByID
        jsl rlGetSelectedUnitStates
        bit #UnitStateDead
        bne _B2D9
        jsl rlGetSelectedUnitStatus
        cmp #StatusCaptive
        beq _B2D9
        jsl rlGetSelectedUnitNamePointer
        bra _B2E5


        _B2D9
        lda #(`aUnitWindowNoValueText4)<<8
        sta lRoutineVariable+1,b
        lda #<>aUnitWindowNoValueText4
        sta lRoutineVariable,b

        _B2E5
        lda wR14
        and #$00FF
        xba
        ora #$0019
        tax
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        jsl rlDrawMenuTextLine
        pla
        sta @l wSelectedUnitDataRAMPointer
        inc wR14
        inc wR14
        inc wR15
        inc wR15
        jml _B219


        _B30E
        jsl rlDMAByStruct

          .structDMAToVRAM gUnitWindowPage3Tilemap, $0140, $80, $B040

        jsl rlDMAByStruct

          .structDMAToVRAM $7E8548, $0C00, $80, $B1C0

        rts

        .databank 0

        ; 8B/B329

      aUnitWindowNoValueText4 ; 8B/B329

        .enc "SJIS"
        .text "ーーーー\n"


      rsUnitWindowDrawPage4 ; 8B/B333

        .al
        .xl
        .autsiz
        .databank ?

        ; Entry 4 of aUnitWindowPageDrawers: each line's weapon ranks (rsUnitWindowDrawWeaponRank).

        lda #$0007
        sta wR14
        stz wR15

        _B33A
        ldx wR15
        lda aUnitWindowDeploymentSlots,x
        bne _B346
        jml _B427


        _B346
        sta wSelectedUnitDataRAMPointer,b
        lda #$0000
        jsl rlGetSelectedUnitWeaponRank
        ldx #$000B
        ldy wR14
        bcc _B35A
        lda #$0004

        _B35A
        clc
        jsr rsUnitWindowDrawWeaponRank
        lda #$0001
        jsl rlGetSelectedUnitWeaponRank
        ldx #$000D
        ldy wR14
        bcc _B36F
        lda #$0004

        _B36F
        sec
        jsr rsUnitWindowDrawWeaponRank
        lda #$0002
        jsl rlGetSelectedUnitWeaponRank
        ldx #$000F
        ldy wR14
        bcc _B384
        lda #$0004

        _B384
        clc
        jsr rsUnitWindowDrawWeaponRank
        lda #$0003
        jsl rlGetSelectedUnitWeaponRank
        ldx #$0011
        ldy wR14
        bcc _B399
        lda #$0004

        _B399
        sec
        jsr rsUnitWindowDrawWeaponRank
        lda #$0004
        jsl rlGetSelectedUnitWeaponRank
        ldx #$0013
        ldy wR14
        bcc _B3AE
        lda #$0004

        _B3AE
        clc
        jsr rsUnitWindowDrawWeaponRank
        lda #$0005
        jsl rlGetSelectedUnitWeaponRank
        ldx #$0015
        ldy wR14
        bcc _B3C3
        lda #$0004

        _B3C3
        sec
        jsr rsUnitWindowDrawWeaponRank
        lda #$0006
        jsl rlGetSelectedUnitWeaponRank
        ldx #$0017
        ldy wR14
        bcc _B3D8
        lda #$0004

        _B3D8
        clc
        jsr rsUnitWindowDrawWeaponRank
        lda #$0007
        jsl rlGetSelectedUnitWeaponRank
        ldx #$0019
        ldy wR14
        bcc _B3ED
        lda #$0004

        _B3ED
        sec
        jsr rsUnitWindowDrawWeaponRank
        lda #$0008
        jsl rlGetSelectedUnitWeaponRank
        ldx #$001B
        ldy wR14
        bcc _B402
        lda #$0004

        _B402
        clc
        jsr rsUnitWindowDrawWeaponRank
        lda #$0009
        jsl rlGetSelectedUnitWeaponRank
        ldx #$001D
        ldy wR14
        bcc _B417
        lda #$0000

        _B417
        sec
        jsr rsUnitWindowDrawWeaponRank
        inc wR14
        inc wR14
        inc wR15
        inc wR15
        jml _B33A


        _B427
        jsl rlDMAByStruct

          .structDMAToVRAM gUnitWindowPage4Tilemap, $0140, $80, $B040

        jsl rlDMAByStruct

          .structDMAToVRAM $7E8548, $0C00, $80, $B1C0

        rts

        .databank 0

        ; 8B/B442

      rsUnitWindowDrawPage5 ; 8B/B442

        .al
        .xl
        .autsiz
        .databank ?

        ; Entry 5 of aUnitWindowPageDrawers: only copies two blocks to VRAM.

        jsl rlDMAByStruct

          .structDMAToVRAM gUnitWindowPage5Tilemap, $0140, $80, $B040

        jsl rlDMAByStruct

          .structDMAToVRAM $7E8548, $0C00, $80, $B1C0

        rts

        .databank 0

        ; 8B/B45D

    .endsection UnitWindowDrawPagesSection


    .section Unsorted8BB45DSection

      .al
      .xl

      rlUnitWindowFillBG3Buffer ; 8B/B45D

        .al
        .xl
        .autsiz
        .databank ?

        ; FE5: rlUnitWindowFillBG3Buffer.

        ldx #$1000

        _B460
        sta $7E8386,x
        dec x
        dec x
        bne _B460
        rtl

        .databank 0

        ; 8B/B469

    .endsection Unsorted8BB45DSection


    .section Unsorted8BB469Section

      .al
      .xl

      rlUnitWindowRenderPageSprites ; 8B/B469

        .al
        .xl
        .autsiz
        .databank ?

        ; Renders the sort icon, the current page's blinking sprite, and the scroll arrows when the list is longer than the window.

        jsr rsUnitWindowRenderWeaponRankSortIcon
        lda wVBlankEnabledFramecount
        and #$0018
        beq _B48B
        stz wR0
        stz wR1
        stz wR4
        stz wR5
        phk
        plb
        .databank $8B
        lda wGameStateStep,b
        asl a
        tax
        lda @l aUnitWindowPageSprites1,x
        tay
        jsl rlPushToOAMBuffer

        _B48B
        lda wUnitWindowMaxRows
        cmp #$000B
        bcc _B4C6
        lda wVBlankEnabledFramecount
        and #$0008
        beq _B4C6
        stz wR0
        stz wR4
        stz wR5
        lda #$0080
        sta wR1
        ldy #$0000
        lda wUnitWindowScrolledLines
        cmp wUnitWindowCanScrollDownFlag
        beq _B4BC
        inc y
        inc y
        cmp #$0000
        bne _B4BC
        inc y
        inc y

        _B4BC
        phk
        plb
        .databank $8B
        lda <>aUnitWindowPageSprites2,b,y
        tay
        jsl rlPushToOAMBuffer

        _B4C6
        rtl

        .databank 0

        ; 8B/B4C7

    .endsection Unsorted8BB469Section


    .section Data8BB4C7Section

      .al
      .xl

      aUnitWindowPageSprites1 ; 8B/B4C7

        ; Read by rlUnitWindowRenderPageSprites.

        .word $B4D3, $B4DA, $B4DA, $B4DA, $B4DA, $B4E6, $0001, $C2F1
        .word $0A21, $0270, $0000, $21C2, $300A, $C2F1, $0A21, $0170
        .word $0000, $21C2, $300A

        ; 8B/B4ED

      aUnitWindowPageSprites2 ; 8B/B4ED

        ; Read by rlUnitWindowRenderPageSprites.

        .word $B4F3, $B4FA, $B506, $0001, $C201, $0CAF, $02B0, $0100
        .word $AFC2, $B00C, $C201, $0C52, $0130, $0100, $52C2, $300C

        ; 8B/B50D

    .endsection Data8BB4C7Section


    .section Unsorted8BB50DSection

      .al
      .xl

      rsUnitWindowRenderWeaponRankSortIcon ; 8B/B50D

        .al
        .xl
        .autsiz
        .databank ?

        ; Renders the icon of the weapon type being sorted by. FE5: rlUnitWindowRenderWeaponRankWeaponRankSortIcon.

        lda wUnitWindowSortType
        sec
        sbc #UNIT_WINDOW_SORT_WEAPON_RANK
        bmi _B533
        cmp #$000A
        bpl _B533
        asl a
        tax
        lda aUnitWindowWeaponRankSortIconTiles,x
        sta wR4
        stz wR0
        stz wR1
        stz wR5
        phk
        plb
        .databank $8B
        ldy #<>aUnitWindowWeaponRankSortIconSprite
        jsl rlPushToOAMBuffer

        _B533
        rts

        .databank 0

        ; 8B/B534

      aUnitWindowWeaponRankSortIconSprite ; 8B/B534

        _Sprites := [[(  29,    8), $21, SpriteLarge, $040, 3, 5, false, false]]

        .structSpriteArray aUnitWindowWeaponRankSortIconSprite._Sprites

    .endsection Unsorted8BB50DSection


    .section Data8BB53BSection

      .al
      .xl

      aUnitWindowWeaponRankSortIconTiles ; 8B/B53B

        ; Read by rsUnitWindowRenderWeaponRankSortIcon.

        .word $0000, $0002, $0004, $0006, $0008, $000A, $000C, $000E
        .word $0020, $0022

        ; 8B/B54F

    .endsection Data8BB53BSection


    .section Unsorted8BB54FSection

      .al
      .xl

      rlUnitWindowRenderUnitSwapCursors ; 8B/B54F

        .al
        .xl
        .autsiz
        .databank ?

        ; The cursors shown while swapping two units' places in the list. FE5: rlUnitWindowFE4RenderUnitSwapCursors.

        lda wUnitWindowCursorYCoordinate
        dec a
        sta wR1
        lda #$0000
        sta wR0
        lda wUnitWindowSortTypeFlag
        jsl rlDrawHandCursor
        lda wUnitWindowUnitSwapStep
        beq _B58E
        lda wVBlankEnabledFramecount
        and #$0001
        bne _B58E
        lda wUnitWindowUnitSwapStartCursorYCoordinate
        dec a
        sec
        sbc wUnitWindowScrollPixels
        sta wR1
        lda #$0000
        sta wR0
        stz wR4
        stz wR5
        phk
        plb
        .databank $8B
        ldy #<>aUnitWindowUnitSwapCursorSprite
        jsl rlPushToOAMBuffer

        _B58E
        rtl

        .databank 0

        ; 8B/B58F

      aUnitWindowUnitSwapCursorSprite ; 8B/B58F

        _Sprites := [[(   0,    0), $21, SpriteLarge, $002, 2, 0, false, false]]

        .structSpriteArray aUnitWindowUnitSwapCursorSprite._Sprites

    .endsection Unsorted8BB54FSection


    .section Unsorted8BB596Section

      .al
      .xl

      rsUnitWindowMoveToLastUnit ; 8B/B596

        .al
        .xl
        .autsiz
        .databank ?

        ; FE5: rlUnitWindowFE4MoveToLastUnit.

        phk
        plb
        .databank $8B
        lda wUnitWindowCurrentLine
        sta wR0
        lda wUnitWindowMaxRows
        sta wUnitWindowCurrentLine
        cmp #$000A
        bpl _B5E3
        lda #$0000
        sta wUnitWindowScrolledLines
        lda wUnitWindowMaxRows
        dec a
        sta wUnitWindowCurrentHighlightLine
        asl a
        tax
        lda @l aUnitWindowPageCursorYPositions,x
        sta wUnitWindowCursorYCoordinate
        lda wUnitWindowScrolledLines
        asl a
        tax
        lda @l aUnitWindowRowScrollOffsets,x
        sta wUnitWindowScrollPixels
        lda wR0
        cmp wUnitWindowMaxRows
        beq _B5E2
        lda #$0006
        jsl rlPlaySoundEffect

        _B5E2
        rts


        _B5E3
        lda wUnitWindowMaxRows
        sec
        sbc #$000A
        sta wUnitWindowScrolledLines
        lda #$0009
        sta wUnitWindowCurrentHighlightLine
        lda #$00CA
        sta wUnitWindowCursorYCoordinate
        lda wUnitWindowScrolledLines
        asl a
        tax
        lda @l aUnitWindowRowScrollOffsets,x
        sta wUnitWindowScrollPixels
        lda wR0
        cmp wUnitWindowMaxRows
        beq _B61A
        lda #$0006
        jsl rlPlaySoundEffect

        _B61A
        rts

        .databank 0

        ; 8B/B61B

    .endsection Unsorted8BB596Section


    .section Data8BB61BSection

      .al
      .xl

      aUnitWindowRowScrollOffsets ; 8B/B61B

        ; Read by rsUnitWindowMoveToLastUnit, rsUnitWindowMoveToNextPage, rsUnitWindowMoveToPreviousPage.

        .word $0000, $0010, $0020, $0030, $0040, $0050, $0060, $0070
        .word $0080, $0090, $00A0, $00B0, $00C0, $00D0, $00E0, $00F0

        ; 8B/B63B

    .endsection Data8BB61BSection


    .section Unsorted8BB63BSection

      .al
      .xl

      rsUnitWindowMoveToNextPage ; 8B/B63B

        .al
        .xl
        .autsiz
        .databank ?

        ; FE5: rsUnitWindowFE4MoveToNextPage.

        lda wUnitWindowCurrentLine
        sta wR0
        lda wUnitWindowScrolledLines
        clc
        adc #$000A
        cmp wUnitWindowCanScrollDownFlag
        beq _B655
        bcc _B655
        jml _B659


        _B655
        jml _B6E1


        _B659
        lda wUnitWindowScrolledLines
        cmp wUnitWindowCanScrollDownFlag
        beq _B68F
        lda wUnitWindowCanScrollDownFlag
        sta wUnitWindowScrolledLines
        lda wUnitWindowScrolledLines
        clc
        adc wUnitWindowCurrentHighlightLine
        inc a
        sta wUnitWindowCurrentLine
        lda wUnitWindowScrolledLines
        asl a
        tax
        lda aUnitWindowRowScrollOffsets,x
        sta wUnitWindowScrollPixels
        lda #$0006
        jsl rlPlaySoundEffect
        rts


        _B68F
        lda wUnitWindowMaxRows
        sta wUnitWindowCurrentLine
        lda wUnitWindowMaxRows
        cmp #$000B
        bmi _B6BE
        lda #$0009
        sta wUnitWindowCurrentHighlightLine
        lda #$00CA
        sta wUnitWindowCursorYCoordinate
        lda wR0
        cmp wUnitWindowMaxRows
        beq _B6BD
        lda #$0006
        jsl rlPlaySoundEffect

        _B6BD
        rts


        _B6BE
        lda wUnitWindowMaxRows
        dec a
        sta wUnitWindowCurrentHighlightLine
        asl a
        tax
        lda aUnitWindowPageCursorYPositions,x
        sta wUnitWindowCursorYCoordinate
        lda wR0
        cmp wUnitWindowMaxRows
        beq _B6E0
        lda #$0006
        jsl rlPlaySoundEffect

        _B6E0
        rts


        _B6E1
        lda wUnitWindowCurrentLine
        clc
        adc #$000A
        sta wUnitWindowCurrentLine
        lda wUnitWindowScrolledLines
        clc
        adc #$000A
        sta wUnitWindowScrolledLines
        asl a
        tax
        lda aUnitWindowRowScrollOffsets,x
        sta wUnitWindowScrollPixels
        lda #$0006
        jsl rlPlaySoundEffect
        rts

        .databank 0

        ; 8B/B70B

    .endsection Unsorted8BB63BSection


    .section Data8BB70BSection

      .al
      .xl

      aUnitWindowPageCursorYPositions ; 8B/B70B

        ; Read by rsUnitWindowMoveToLastUnit, rsUnitWindowMoveToNextPage.

        .word $003A, $004A, $005A, $006A, $007A, $008A, $009A, $00AA
        .word $00BA, $00CA

        ; 8B/B71F

    .endsection Data8BB70BSection


    .section Unsorted8BB71FSection

      .al
      .xl

      rsUnitWindowMoveToFirstUnit ; 8B/B71F

        .al
        .xl
        .autsiz
        .databank ?

        ; FE5: rsUnitWindowFE4MoveToFirstUnit.

        lda wUnitWindowCurrentLine
        sta wR0
        lda #$0000
        sta wUnitWindowScrolledLines
        sta wUnitWindowCurrentHighlightLine
        sta wUnitWindowScrollPixels
        lda #$003A
        sta wUnitWindowCursorYCoordinate
        lda #$0001
        sta wUnitWindowCurrentLine
        lda wR0
        cmp #$0001
        beq _B750
        lda #$0006
        jsl rlPlaySoundEffect

        _B750
        rts

        .databank 0

        ; 8B/B751

      rsUnitWindowMoveToPreviousPage ; 8B/B751

        .al
        .xl
        .autsiz
        .databank ?

        ; FE5: rsUnitWindowFE4MoveToPreviousPage.

        lda wUnitWindowScrolledLines
        sec
        sbc #$000A
        beq _B7A9
        bpl _B7A9
        lda wUnitWindowScrolledLines
        beq _B77F
        lda #$0000
        sta wUnitWindowScrolledLines
        sta wUnitWindowScrollPixels
        lda wUnitWindowCurrentHighlightLine
        inc a
        sta wUnitWindowCurrentLine
        lda #$0006
        jsl rlPlaySoundEffect
        rts


        _B77F
        lda wUnitWindowCurrentLine
        sta wR0
        lda #$0001
        sta wUnitWindowCurrentLine
        lda #$0000
        sta wUnitWindowCurrentHighlightLine
        lda #$003A
        sta wUnitWindowCursorYCoordinate
        lda wR0
        cmp #$0001
        beq _B7A8
        lda #$0006
        jsl rlPlaySoundEffect

        _B7A8
        rts


        _B7A9
        lda wUnitWindowCurrentLine
        sec
        sbc #$000A
        sta wUnitWindowCurrentLine
        lda wUnitWindowScrolledLines
        sec
        sbc #$000A
        sta wUnitWindowScrolledLines
        asl a
        tax
        lda aUnitWindowRowScrollOffsets,x
        sta wUnitWindowScrollPixels
        lda #$0006
        jsl rlPlaySoundEffect
        rts

        .databank 0

        ; 8B/B7D3

      rsUnitWindowRenderItemIcons ; 8B/B7D3

        .al
        .xl
        .autsiz
        .databank ?

        ; Renders the units' equipped weapon icons. FE5: rsUnitWindowFE4RenderItemIcons.

        phk
        plb
        .databank $8B
        stz wR15
        stz wR5
        stz wR0

        _B7DB
        lda wR15
        cmp wUnitWindowMaxRows
        beq _B809
        lda wR15
        asl a
        tax
        lda @l aUnitWindowItemIconYCoordinates,x
        sec
        sbc wUnitWindowScrollPixels
        sta wR1
        lda aUnitWindowSpriteSlots,x
        asl a
        tax
        lda @l aUnitWindowItemIconTiles,x
        sta wR4
        ldy #<>aUnitWindowItemIconSprite
        jsl rlPushToOAMBuffer
        inc wR15
        bra _B7DB


        _B809
        rts

        .databank 0

        ; 8B/B80A

      aUnitWindowItemIconSprite ; 8B/B80A

        _Sprites := [[(  79,    0), $21, SpriteLarge, $000, 2, 3, false, false]]

        .structSpriteArray aUnitWindowItemIconSprite._Sprites

    .endsection Unsorted8BB71FSection


    .section Data8BB811Section

      .al
      .xl

      aUnitWindowItemIconTiles ; 8B/B811

        ; Read by rsUnitWindowRenderItemIcons.

        .word $00E0, $00E2, $00E4, $00E6, $00E8, $00EA, $00EC, $00EE
        .word $0100, $0102, $0104, $0106, $0108, $010A, $010C, $010E
        .word $0120, $0122, $0124, $0126, $0128, $012A, $012C, $012E

        ; 8B/B841

      aUnitWindowItemIconYCoordinates ; 8B/B841

        ; Read by rsUnitWindowRenderItemIcons.

        .word $0037, $0047, $0057, $0067, $0077, $0087, $0097, $00A7
        .word $00B7, $00C7, $00D7, $00E7, $00F7, $0107, $0117, $0127
        .word $0137, $0147, $0157, $0167, $0177, $0187, $0197, $01A7

        ; 8B/B871

    .endsection Data8BB811Section


    .section Unsorted8BB871Section

      .al
      .xl

      rsUnitWindowRenderWeaponRankIcons ; 8B/B871

        .al
        .xl
        .autsiz
        .databank ?

        ; Renders the weapon type icons of the weapon rank page (page 4). FE5: rsUnitWindowRenderWeaponRankIcons.

        stz wR0
        stz wR1
        stz wR4
        stz wR5
        lda #<>aUnitWindowWeaponRankIconSprites
        tay
        jsl rlPushToOAMBuffer
        rts

        .databank 0

        ; 8B/B882

      aUnitWindowWeaponRankIconSprites ; 8B/B882

        ; The ten weapon type icons of the weapon rank page (rsUnitWindowRenderWeaponRankIcons).

        _Sprites := [[(  84,   33), $21, SpriteLarge, $040, 3, 5, false, false]]
        _Sprites ..= [[( 100,   33), $21, SpriteLarge, $042, 3, 5, false, false]]
        _Sprites ..= [[( 116,   33), $21, SpriteLarge, $044, 3, 5, false, false]]
        _Sprites ..= [[( 132,   33), $21, SpriteLarge, $046, 3, 5, false, false]]
        _Sprites ..= [[( 148,   33), $21, SpriteLarge, $048, 3, 5, false, false]]
        _Sprites ..= [[( 164,   33), $21, SpriteLarge, $04A, 3, 5, false, false]]
        _Sprites ..= [[( 180,   33), $21, SpriteLarge, $04C, 3, 5, false, false]]
        _Sprites ..= [[( 196,   33), $21, SpriteLarge, $04E, 3, 5, false, false]]
        _Sprites ..= [[( 212,   33), $21, SpriteLarge, $060, 3, 5, false, false]]
        _Sprites ..= [[( 228,   33), $21, SpriteLarge, $062, 3, 5, false, false]]

        .structSpriteArray aUnitWindowWeaponRankIconSprites._Sprites

        ; 8B/B8B6

    .endsection Unsorted8BB871Section


    .section Unsorted8BB8B6Section

      .al
      .xl

      rsUnitWindowCopyLineHighlightColors ; 8B/B8B6

        .al
        .xl
        .autsiz
        .databank ?

        ; Copies the colours of the highlight on the selected line; runs every frame. FE5: rsUnitWindowFE4CopyLineHighlightColors.

        lda wUnitWindowSortTypeFlag
        ora wUnitWindowUnitSwapStep
        beq _B8C4
        jml _B9C5


        _B8C4
        phk
        plb
        .databank $8B
        sep #$20
        ldx #$001A
        lda #$10

        _B8CD
        sta $7FB044,x
        dec x
        bpl _B8CD
        rep #$20
        lda wUnitWindowCurrentHighlightLine
        and #$00FF
        tax
        sep #$20
        ldy #$0010
        lda #$01

        _B8E5
        sta $7FB044,x
        inc x
        dec y
        bne _B8E5
        rep #$20
        stz wR3
        stz wR4

        _B8F3
        lda wUnitWindowCurrentHighlightLine
        cmp wR3
        beq _B926
        lda wR3
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda <>aUnitWindowLineHighlightColors2+1,b,x
        phx
        pha
        lda wR4
        tax
        pla
        sta $7FB063,x
        txy
        plx
        lda @l aUnitWindowLineHighlightColors2,x
        tyx
        sta $7FB062,x
        lda wR4
        clc
        adc #$0003
        sta wR4
        bra _B95A


        _B926
        ldx #$0000

        _B929
        lda aUnitWindowHighlightColors+1,x
        phx
        pha
        lda wR4
        tax
        pla
        sta $7FB063,x
        plx
        lda aUnitWindowHighlightColors,x
        phx
        pha
        lda wR4
        tax
        pla
        sta $7FB062,x
        txa
        clc
        adc #$0003
        sta wR4
        plx
        inc x
        inc x
        inc x
        cpx #$0030
        beq _B95A
        jml _B929


        _B95A
        lda wR3
        inc a
        sta wR3
        cmp #$000B
        beq _B968
        jml _B8F3


        _B968
        lda wUnitWindowHighlightCounter
        bne _B9B3
        lda wUnitWindowHighlightStep
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda #$0000
        sta wR0
        ldy #$0010

        _B981
        phx
        lda <>aUnitWindowLineHighlightColors1+1,b,x
        ldx wR0
        sta aUnitWindowHighlightColors+1,x
        plx
        lda <>aUnitWindowLineHighlightColors1,b,x
        phx
        ldx wR0
        sta aUnitWindowHighlightColors,x
        inc x
        inc x
        inc x
        stx wR0
        plx
        inc x
        inc x
        inc x
        dec y
        bne _B981
        lda wUnitWindowHighlightStep
        inc a
        cmp #$0016
        bne _B9AF
        lda #$0000

        _B9AF
        sta wUnitWindowHighlightStep

        _B9B3
        lda wUnitWindowHighlightCounter
        inc a
        cmp #$0006
        bne _B9C0
        lda #$0000

        _B9C0
        sta wUnitWindowHighlightCounter
        rts


        _B9C5
        sep #$20
        ldx #$001A
        lda #$10

        _B9CC
        sta $7FB044,x
        dec x
        bpl _B9CC
        rep #$20
        ldx #$0000

        _B9D8
        lda @l aUnitWindowLineHighlightColors2+1,x
        sta $7FB063,x
        lda @l aUnitWindowLineHighlightColors2,x
        sta $7FB062,x
        inc x
        inc x
        inc x
        cpx #$0024
        bne _B9D8
        lda #$0000
        sta $7FB063,x
        sta $7FB062,x
        rts

        .databank 0

        ; 8B/B9FC

    .endsection Unsorted8BB8B6Section


    .section Data8BB9FCSection

      .al
      .xl

      aUnitWindowLineHighlightColors1 ; 8B/B9FC

        ; Read by rsUnitWindowCopyLineHighlightColors.

        .word $8001, $0163, $6280, $8001, $0162, $6280, $8001, $0161
        .word $6180, $8001, $8160, $6081, $8281, $8160, $6083, $8381
        .word $8160, $6084, $8481, $8160, $6083, $8381, $8160, $6082
        .word $8181, $0160, $6080, $8001, $0161, $6180, $8001, $0162
        .word $6280, $8001, $0163, $6280, $8001, $0162, $6280, $8001
        .word $0161, $6180, $8001, $8160, $6081, $8281, $8160, $6083
        .word $8381, $8160, $6084, $8481, $8160, $6083, $8381, $8160
        .word $6082, $8181, $0160, $6080, $8001, $0161, $6180, $8001
        .word $0162, $6280

        ; 8B/BA80

      aUnitWindowLineHighlightColors2 ; 8B/BA80

        ; Read by rsUnitWindowCopyLineHighlightColors.

        .word $0081, $81E1, $E200, $0081, $81E3, $E400, $0081, $81E5
        .word $E600, $0081, $81E7, $E800, $0081, $81E9, $EA00, $0081
        .word $01EB, $EF00

        ; 8B/BAA4

    .endsection Data8BB9FCSection


    .section Unsorted8BBAA4Section

      .al
      .xl

      rlUnitWindowGetUnitSpriteInfos ; 8B/BAA4

        .al
        .xl
        .autsiz
        .databank ?

        ; FE5: rlUnitWindowFE4GetUnitSpriteInfos.

        ldx #$008E

        _BAA7
        lda #$FFFF
        sta aDeploymentTable._MapSpriteID,x
        dec x
        dec x
        bpl _BAA7
        lda #$0017
        sta wRoutineVariable1,b
        ldx #$002E

        _BABB
        phx
        lda wRoutineVariable1,b
        asl a
        tax
        lda aUnitWindowDeploymentSlots,x
        sta wSelectedUnitDataRAMPointer,b
        plx
        lda wSelectedUnitDataRAMPointer,b
        beq _BAE1
        jsl rlGetSelectedUnitMapSprite
        bit #$8000
        bne _BADD
        sta aDeploymentTable._MapSpriteID,x
        bra _BAE1


        _BADD
        sta $7E486B,x

        _BAE1
        dec wRoutineVariable1,b
        dec x
        dec x
        bpl _BABB
        rtl

        .databank 0

        ; 8B/BAE9

    .endsection Unsorted8BBAA4Section


    .section Unsorted8BBAE9Section

      .al
      .xl

      rsUnitWindowRenderSprites ; 8B/BAE9

        .al
        .xl
        .autsiz
        .databank ?

        ; Renders the sort direction cursor, the "ready to promote" sprites and the map sprites. FE5: rsUnitWindowFE4RenderSprites.

        stz wR0
        stz wR1
        stz wR4
        stz wR5
        lda wUnitWindowSortDirection
        bne _BAFC
        ldy #<>aUnitWindowSortDescendingArrowSprite
        bra _BAFF


        _BAFC
        ldy #<>aUnitWindowSortAscendingArrowSprite

        _BAFF
        jsl rlPushToOAMBuffer
        lda wVBlankEnabledFramecount
        and #$0018
        beq _BB38
        lda #$0000

        _BB0D
        sta wR15
        asl a
        tax
        lda aUnitWindowReadyToPromoteFlags,x
        beq _BB2F
        lda aUnitWindowRowYCoordinates,x
        sec
        sbc wUnitWindowScrollPixels
        sta wR1
        stz wR0
        stz wR4
        stz wR5
        ldy #<>aUnitWindowReadyToPromoteSprite
        jsl rlPushToOAMBuffer

        _BB2F
        lda wR15
        inc a
        cmp wUnitWindowMaxRows
        bne _BB0D

        _BB38
        jsr rsUnitWindowGetCurrentLineUnit
        phk
        plb
        .databank $8B
        ldx #$002E
        lda wUnitWindowCurrentLine
        dec a
        asl a
        sta wR0

        _BB48
        cpx wR0
        beq _BB50
        dec x
        dec x
        bra _BB48


        _BB50
        lda wUnitWindowUnitSwapStartSlot
        dec a
        asl a
        sta wR0
        cpx wR0
        bne _BB67
        lda wVBlankEnabledFramecount
        and #$0001
        beq _BB67
        jml _BBE1


        _BB67
        phx
        lda aUnitWindowSpriteSlots,x
        asl a
        tax
        lda $7E486B,x
        cmp #$FFFF
        beq _BB83
        lda aTallMapSpriteSlotTiles2,x
        sta wR4
        lda #<>aUnitWindowTallMapSprite
        tay
        bra _BB8D


        _BB83
        lda aShortMapSpriteSlotTiles,x
        sta wR4
        lda #<>aUnitWindowMapSprite
        tay

        _BB8D
        plx
        phx
        phy
        ldy #$2C00
        cpx #$0000
        bne _BBA1
        lda wUnitWindowScrollPixels
        bne _BBA1
        ldy #$3C00

        _BBA1
        tya
        sta wR5
        lda wUnitWindowCurrentLine
        dec a
        asl a
        tax
        lda aUnitWindowDeploymentSlots,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitStates
        bit #UnitStateMoved
        bne _BBC4
        jsl rlGetSelectedUnitStatus
        cmp #StatusSleep
        bne _BBCE

        _BBC4
        lda wR5
        and #$F1FF
        ora #$0E00
        sta wR5

        _BBCE
        ply
        plx
        stz wR0
        lda @l aUnitWindowRowYCoordinates,x
        sec
        sbc wUnitWindowScrollPixels
        sta wR1
        jsl rlPushToOAMBuffer

        _BBE1
        lda wUnitWindowMaxRows
        dec a
        asl a
        tax

        _BBE8
        phx
        lda wUnitWindowCurrentLine
        dec a
        asl a
        sta wR0
        cpx wR0
        bne _BBF9
        jml _BC7D


        _BBF9
        lda wUnitWindowUnitSwapStartSlot
        dec a
        asl a
        sta wR0
        cpx wR0
        bne _BC10
        lda wVBlankEnabledFramecount
        and #$0001
        beq _BC10
        jml _BC7D


        _BC10
        phx
        lda aUnitWindowSpriteSlots,x
        asl a
        tax
        lda $7E486B,x
        plx
        cmp #$FFFF
        beq _BC7D
        ldy #$2C00
        cpx #$0000
        bne _BC32
        lda wUnitWindowScrollPixels
        bne _BC32
        ldy #$3C00

        _BC32
        tya
        sta wR5
        lda aUnitWindowDeploymentSlots,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitStates
        bit #UnitStateMoved
        bne _BC4E
        jsl rlGetSelectedUnitStatus
        cmp #StatusSleep
        bne _BC58

        _BC4E
        lda wR5
        and #$F1FF
        ora #$0E00
        sta wR5

        _BC58
        plx
        phx
        lda aUnitWindowSpriteSlots,x
        asl a
        tax
        lda aTallMapSpriteSlotTiles2,x
        plx
        sta wR4
        lda #<>aUnitWindowTallMapSprite
        tay
        stz wR0
        lda @l aUnitWindowRowYCoordinates,x
        sec
        sbc wUnitWindowScrollPixels
        sta wR1
        phx
        jsl rlPushToOAMBuffer

        _BC7D
        plx
        dec x
        dec x
        bmi _BC86
        jml _BBE8


        _BC86
        lda wUnitWindowMaxRows
        dec a
        asl a
        tax

        _BC8D
        lda wUnitWindowCurrentLine
        dec a
        asl a
        sta wR0
        cpx wR0
        bne _BC9D
        jml _BD29


        _BC9D
        lda wUnitWindowUnitSwapStartSlot
        dec a
        asl a
        sta wR0
        cpx wR0
        bne _BCB4
        lda wVBlankEnabledFramecount
        and #$0001
        beq _BCB4
        jml _BD29


        _BCB4
        phx
        lda aUnitWindowSpriteSlots,x
        asl a
        tax
        lda aDeploymentTable._MapSpriteID,x
        plx
        cmp #$FFFF
        beq _BD29
        phy
        phx
        ldy #$2C00
        cpx #$0000
        bne _BCD8
        lda wUnitWindowScrollPixels
        bne _BCD8
        ldy #$3C00

        _BCD8
        tya
        sta wR5
        plx
        lda aUnitWindowDeploymentSlots,x
        sta wSelectedUnitDataRAMPointer,b
        phx
        jsl rlGetSelectedUnitStates
        bit #UnitStateMoved
        bne _BCF6
        jsl rlGetSelectedUnitStatus
        cmp #StatusSleep
        bne _BD00

        _BCF6
        lda wR5
        and #$F1FF
        ora #$0E00
        sta wR5

        _BD00
        plx
        ply
        phx
        lda aUnitWindowSpriteSlots,x
        asl a
        tax
        lda aShortMapSpriteSlotTiles,x
        plx
        sta wR4
        lda #<>aUnitWindowMapSprite
        tay
        stz wR0
        lda @l aUnitWindowRowYCoordinates,x
        sec
        sbc wUnitWindowScrollPixels
        sta wR1
        phy
        phx
        jsl rlPushToOAMBuffer
        plx
        ply

        _BD29
        dec x
        dec x
        bmi _BD31
        jml _BC8D


        _BD31
        lda wUnitWindowCurrentLine
        dec a
        asl a
        tax
        lda aUnitWindowDeploymentSlots,x
        sta wSelectedUnitDataRAMPointer,b
        rts

        .databank 0

        ; 8B/BD40

    .endsection Unsorted8BBAE9Section


    .section Data8BBD40Section

      .al
      .xl

      aUnitWindowRowYCoordinates ; 8B/BD40

        ; Read by rsUnitWindowRenderSprites.

        .byte $38, $00, $48, $00, $58, $00, $68, $00, $78, $00, $88, $00, $98, $00, $A8, $00
        .byte $B8, $00, $C8, $00, $D8, $00, $E8, $00, $F8, $00, $08, $01, $18, $01, $28, $01
        .byte $38, $01, $48, $01, $58, $01, $68, $01, $78, $01, $88, $01, $98, $01, $A8, $01

      aUnitWindowMapSprite ; 8B/BD70

        _Sprites := [[(  16,    0), $21, SpriteLarge, $080, 0, 0, false, false]]

        .structSpriteArray aUnitWindowMapSprite._Sprites

        ; 8B/BD77

      aUnitWindowTallMapSprite ; 8B/BD77

        _Sprites := [[(  16,    0), $21, SpriteLarge, $140, 0, 0, false, false]]
        _Sprites ..= [[(  16,  -16), $21, SpriteLarge, $142, 0, 0, false, false]]

        .structSpriteArray aUnitWindowTallMapSprite._Sprites

        ; 8B/BD83

      aUnitWindowReadyToPromoteSprite ; 8B/BD83

        _Sprites := [[(  12,    6), $21, SpriteLarge, $004, 2, 4, false, false]]
        _Sprites ..= [[(  28,    6), $00, SpriteSmall, $006, 2, 4, false, false]]

        .structSpriteArray aUnitWindowReadyToPromoteSprite._Sprites

        ; 8B/BD8F

      aUnitWindowSortAscendingArrowSprite ; 8B/BD8F

        _Sprites := [[(  58,    9), $00, SpriteSmall, $009, 3, 4, false, false]]
        _Sprites ..= [[(  58,   17), $00, SpriteSmall, $019, 3, 4, false, false]]

        .structSpriteArray aUnitWindowSortAscendingArrowSprite._Sprites

        ; 8B/BD9B

      aUnitWindowSortDescendingArrowSprite ; 8B/BD9B

        _Sprites := [[(  58,   17), $00, SpriteSmall, $009, 3, 4, false, true]]
        _Sprites ..= [[(  58,    9), $00, SpriteSmall, $019, 3, 4, false, true]]

        .structSpriteArray aUnitWindowSortDescendingArrowSprite._Sprites

        ; 8B/BDA7

    .endsection Data8BBD40Section


    .section Unsorted8BBDA7Section

      .al
      .xl

      rsUnitWindowGetCurrentLineUnit ; 8B/BDA7

        .al
        .xl
        .autsiz
        .databank ?

        ; FE5: rsUnitWindowFE4GetCurrentLineUnit.

        lda wUnitWindowPageScrollFlag
        bne _BDEF
        lda wUnitWindowSortTypeFlag
        bne _BDEF
        ora wUnitWindowUnitSwapStep
        bne _BDEF
        lda wUnitWindowCurrentLine
        dec a
        asl a
        sta wUnitWindowCurrentLineSlotOffset
        tax
        lda aUnitWindowDeploymentSlots,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitStates
        bit #UnitStateMoved
        bne _BDEF
        jsl rlGetSelectedUnitStatus
        cmp #StatusSleep
        beq _BDEF
        lda wUnitWindowCurrentLineSlotOffset
        lda aUnitWindowSpriteSlots,x
        asl a
        sta wUnitWindowCurrentLineSlotOffset
        tax
        jsl rlAnimateUnitWindowLineSprite

        _BDEF
        rts

        .databank 0

        ; 8B/BDF0

    .endsection Unsorted8BBDA7Section


    .section UnitWindowDrawWeaponRankSection

      .al
      .xl

      rsUnitWindowDrawWeaponRank ; 8B/BDF0

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws a weapon rank's two tiles from aUnitWindowWeaponRankTiles, or from aUnitWindowWeaponRankTiles2 when carry is set.

        bcs _BE19
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
        lda aUnitWindowWeaponRankTiles,x
        phx
        tyx
        sta aBG3TilemapBuffer,x
        txy
        plx
        lda aUnitWindowWeaponRankTiles+2,x
        tyx
        sta $7E83C8,x
        rts


        _BE19
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
        lda aUnitWindowWeaponRankTiles2,x
        phx
        tyx
        sta aBG3TilemapBuffer,x
        txy
        plx
        lda aUnitWindowWeaponRankTiles2+2,x
        tyx
        sta $7E83C8,x
        rts

        .databank 0

        ; 8B/BE40

      aUnitWindowWeaponRankTiles ; 8B/BE40

        .word $392A, $393A, $392B, $393B, $392C, $393C, $38FF, $3909, $39E4, $39F4


      aUnitWindowWeaponRankTiles2 ; 8B/BE54

        .word $352A, $353A, $352B, $353B, $352C, $353C, $34FF, $3509, $35E4, $35F4

    .endsection UnitWindowDrawWeaponRankSection


    .section Unsorted8BBE68Section

      .al
      .xl

      rlCopyItemIcon ; 8B/BE68

        .al
        .xl
        .autsiz
        .databank ?

        ; A: item ID ($FFFF for none, which copies a blank icon), X: icon slot. Copies the item's 16x16 icon to the sprite tiles for that slot. Used by the unit window, shops and status screens. FE5: rlUnitWindowFE4CopyItemIcon.

        phx
        phy
        php
        tay
        txa
        asl a
        asl a
        asl a
        asl a
        sta wR0
        lda bBufferOBSEL
        and #$001F
        asl a
        tax
        lda aItemIconBlankAndVRAMBases+3,x
        clc
        adc wR0
        pha
        tya
        cmp #$FFFF
        bne _BE96
        lda aItemIconBlankAndVRAMBases+1
        sta lR18+1
        lda aItemIconBlankAndVRAMBases
        sta lR18
        bra _BEAC


        _BE96
        lda #(`g4bppItemIcons)<<8
        sta lR18+1
        lda #<>g4bppItemIcons
        sta lR18
        tya
        asl a
        tax
        lda aItemIconOffsets,x
        clc
        adc lR18
        sta lR18

        _BEAC
        lda #$0040
        sta wR0
        pla
        sta wR1
        pha
        jsl rlDMAByPointer
        lda lR18
        clc
        adc #$0200
        sta lR18
        lda #$0040
        sta wR0
        pla
        clc
        adc #$0100
        sta wR1
        jsl rlDMAByPointer
        plp
        ply
        plx
        rtl

        .databank 0

        ; 8B/BED5

    .endsection Unsorted8BBE68Section


    .section Table8BBFEDSection

      .al
      .xl

      aItemIconBlankAndVRAMBases ; 8B/BFED

        ; Read by rlCopyItemIcon.

        .byte $80, $06, $DE, $00, $00, $00, $20, $00, $40, $00, $60, $00, $00, $00, $20, $00
        .byte $40, $00, $60, $00, $08, $00, $28, $00, $48, $00, $68, $00, $08, $00, $28, $00
        .byte $48, $00, $68, $00, $10, $00, $30, $00, $50, $00, $70, $00, $10, $00, $30, $00
        .byte $50, $00, $70, $00, $18, $00, $38, $00, $58, $00, $78, $00, $18, $00, $38, $00
        .byte $58, $00, $78

        ; 8B/C030

    .endsection Table8BBFEDSection


    .section Unsorted8BC030Section

      .al
      .xl

      rlUnitWindowCopyWeaponRankIcon ; 8B/C030

        .al
        .xl
        .autsiz
        .databank ?

        ; FE5: rlUnitWindowFE4CopyWeaponRankIcon.

        phx
        phy
        php
        cmp #$FFFF
        bne _C03B
        lda #$000A

        _C03B
        tay
        txa
        asl a
        asl a
        asl a
        asl a
        sta wR0
        lda bBufferOBSEL
        and #$001F
        asl a
        tax
        lda aUnitWindowWeaponRankIconOffsets,x
        clc
        adc wR0
        pha
        tya
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda aUnitWindowWeaponRankIconPointers+1,x
        sta lR18+1
        lda aUnitWindowWeaponRankIconPointers,x
        sta lR18
        lda #$0040
        sta wR0
        pla
        sta wR1
        pha
        jsl rlDMAByPointer
        lda lR18
        clc
        adc #$0200
        sta lR18
        lda #$0040
        sta wR0
        pla
        clc
        adc #$0100
        sta wR1
        jsl rlDMAByPointer
        plp
        ply
        plx
        rtl

        .databank 0

        ; 8B/C08F

    .endsection Unsorted8BC030Section


    .section Table8BC08FSection

      .al
      .xl

      aUnitWindowWeaponRankIconPointers ; 8B/C08F

        ; Read by rlUnitWindowCopyWeaponRankIcon.

        .byte $00, $02, $DE, $40, $02, $DE, $80, $02, $DE, $C0, $02, $DE, $00, $03, $DE, $40
        .byte $03, $DE, $80, $03, $DE, $C0, $03, $DE, $00, $06, $DE, $40, $06, $DE, $80, $06
        .byte $DE

        ; 8B/C0B0

    .endsection Table8BC08FSection


    .section Data8BC0B0Section

      .al
      .xl

      aUnitWindowWeaponRankIconOffsets ; 8B/C0B0

        ; Read by rlUnitWindowCopyWeaponRankIcon.

        .word $0000, $2000, $4000, $6000, $0000, $2000, $4000, $6000
        .word $0800, $2800, $4800, $6800, $0800, $2800, $4800, $6800
        .word $1000, $3000, $5000, $7000, $1000, $3000, $5000, $7000
        .word $1800, $3800, $5800, $7800, $1800, $3800, $5800, $7800

        ; 8B/C0F0

    .endsection Data8BC0B0Section


    .section Unsorted8BC0F0Section

      .al
      .xl

      rsUnitWindowRenderSortSelectorCursor ; 8B/C0F0

        .al
        .xl
        .autsiz
        .databank ?

        ; The cursor over the column being picked as the sort. FE5: rlUnitWindowRenderSortSelectorCursor.

        phk
        plb
        .databank $8B
        lda wGameStateStep,b
        xba
        lsr a
        lsr a
        lsr a
        sta wR0
        lda wUnitWindowCurrentColumn
        asl a
        clc
        adc wR0
        tax
        lda @l aUnitWindowSortCursorXPositions,x
        sta wR0
        lda #$0011
        sta wR1
        stz wR4
        stz wR5
        lda wVBlankEnabledFramecount
        lsr a
        lsr a
        lsr a
        and #$0003
        asl a
        tax
        lda @l aUnitWindowSortCursorSprites,x
        tay
        jsl rlPushToOAMBuffer
        rts

        .databank 0

        ; 8B/C127

    .endsection Unsorted8BC0F0Section


    .section Data8BC127Section

      .al
      .xl

      aUnitWindowSortCursorSprites ; 8B/C127

        ; Read by rsUnitWindowRenderSortSelectorCursor.

        .word $C12F, $C13B, $C147, $C153, $0002, $C200, $0C05, $0032
        .word $1BC2, $B20C, $0002, $C200, $0C04, $0032, $1CC2, $B20C
        .word $0002, $C200, $0C05, $0032, $1BC2, $B20C, $0002, $C200
        .word $0C06, $0032, $1AC2, $B20C

        ; 8B/C15F

      aUnitWindowSortCursorXPositions ; 8B/C15F

        ; Read by rsUnitWindowRenderSortSelectorCursor.

        .word $0020, $005C, $0098, $00B0, $00C8, $00E0, $0000, $0000
        .word $00A0, $00B0, $00C0, $00D0, $00E0, $00F0, $0100, $0110
        .word $0020, $0063, $00A0, $00BC, $00DC, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0020, $0050, $0068, $0080, $0098, $00B0, $00C8, $00E0
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0020, $0058, $0084, $00AC, $00D0, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0020, $0055, $0065, $0075, $0085, $0095, $00A5, $00B5
        .word $00C5, $00D5, $00E5, $0000, $0000, $0000, $0000, $0000
        .word $0020, $0068, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000

        ; 8B/C21F

    .endsection Data8BC127Section


    .section Unsorted8BC21FSection

      .al
      .xl

      rsUnitWindowHandleSortSelection ; 8B/C21F

        .al
        .xl
        .autsiz
        .databank ?

        ; Input while picking a sort: left and right move between columns and pages, A sorts descending and X ascending (rsUnitWindowUpdateSort), B and down leave.

        jsl rlUnitWindowRenderPageSprites
        lda wUnitWindowSortTypeFlag
        cmp #$0002
        beq _C238
        cmp #$0003
        beq _C23C
        cmp #$0004
        beq _C240
        bra _C250


        _C238
        jml _C34B


        _C23C
        jml _C36B


        _C240
        jml _C37A


        _C244
        jml _C317


        _C248
        jml _C32B


        _C24C
        jml _C33F


        _C250
        lda wJoy1New
        bit #$0400
        bne _C244
        bit #$8000
        bne _C248
        bit #$00C0
        bne _C24C
        lda wJoy1Repeated
        bit #$0100
        bne _C271
        bit #$0200
        bne _C2B6
        jml _C2EE


        _C271
        lda wUnitWindowCurrentColumn
        inc a
        sta wUnitWindowCurrentColumn
        lda wGameStateStep,b
        asl a
        tax
        lda aUnitWindowSortColumnCounts,x
        cmp wUnitWindowCurrentColumn
        bcs _C2E7
        sta wUnitWindowCurrentColumn
        lda wGameStateStep,b
        inc a
        cmp #$0006
        beq _C2EE
        sta wGameStateStep,b
        lda #$0000
        sta wUnitWindowCurrentColumn
        jsl rlUnitWindowDrawPage
        lda wGameStateStep,b
        cmp #$0005
        bne _C2B4
        sep #$20
        lda #$17
        sta bBufferTM
        rep #$20

        _C2B4
        bra _C2E7


        _C2B6
        lda wUnitWindowCurrentColumn
        dec a
        sta wUnitWindowCurrentColumn
        bpl _C2E7
        sep #$20
        lda #$15
        sta bBufferTM
        rep #$20
        lda #$0000
        sta wUnitWindowCurrentColumn
        lda wGameStateStep,b
        dec a
        bmi _C2EE
        sta wGameStateStep,b
        asl a
        tax
        lda aUnitWindowSortColumnCounts,x
        sta wUnitWindowCurrentColumn
        jsl rlUnitWindowDrawPage

        _C2E7
        lda #$0007
        jsl rlPlaySoundEffect

        _C2EE
        lda #$0001
        sta wR0
        lda #$000A
        sta wR1
        lda #$0000
        jsl rlDrawHandCursor
        jsr rsUnitWindowRenderSortSelectorCursor

        _C302
        lda wGameStateStep,b
        dec a
        bne _C30B
        jsr rsUnitWindowRenderItemIcons

        _C30B
        lda wGameStateStep,b
        cmp #$0004
        bne _C316
        jsr rsUnitWindowRenderWeaponRankIcons

        _C316
        rts


        _C317
        lda #$0006
        jsl rlPlaySoundEffect
        lda #UNIT_WINDOW_SORT_JOIN_ORDER
        sta wUnitWindowSortTypeFlag
        sta wUnitWindowCurrentColumn
        bra _C302


        _C32B
        lda #$0021
        jsl rlPlaySoundEffect
        lda #UNIT_WINDOW_SORT_JOIN_ORDER
        sta wUnitWindowSortTypeFlag
        sta wUnitWindowCurrentColumn
        bra _C302


        _C33F
        lda #$000A
        jsl rlPlaySoundEffect
        jsr rsUnitWindowUpdateSort
        bra _C2EE


        _C34B
        ldx #$01C8
        lda #$0030
        ldy #$0005
        jsl rlClearTilemapRect
        jsl rlUnitWindowDrawUnitNames
        jsl rlUnitWindowDrawPage
        lda #$0003
        sta wUnitWindowSortTypeFlag
        jml _C2EE


        _C36B
        jsl rlUnitWindowDrawUnitSkills
        lda #$0001
        sta wUnitWindowSortTypeFlag
        jml _C2EE


        _C37A
        lda #$0001
        sta wUnitWindowSortTypeFlag
        jml _C2EE

        .databank 0

        ; 8B/C385

    .endsection Unsorted8BC21FSection


    .section Data8BC385Section

      .al
      .xl

      aUnitWindowSortColumnCounts ; 8B/C385

        ; Read by rsUnitWindowHandleSortSelection.

        .word $0005, $0004, $0007, $0004, $000A, $0001

        ; 8B/C391

    .endsection Data8BC385Section


    .section Unsorted8BC391Section

      .al
      .xl

      rsUnitWindowHandleUnitSwap ; 8B/C391

        .al
        .xl
        .autsiz
        .databank ?

        ; Input while swapping two units: A or Y swaps the selected unit with the one picked first (rsUnitWindowSwapUnits) and resets the sort, B cancels.

        lda wUnitWindowUnitSwapStep
        cmp #$0002
        beq _C3A3
        cmp #$0003
        beq _C3A7
        jml _C3AB


        _C3A3
        jml _C40B


        _C3A7
        jml _C42B


        _C3AB
        lda wJoy1New
        bit #$8000
        bne _C3F1
        bit #$4080
        bne _C3B8

        _C3B7
        rts


        _C3B8
        lda wUnitWindowCurrentLine
        cmp wUnitWindowUnitSwapStartSlot
        beq _C3F1
        lda #$000A
        jsl rlPlaySoundEffect
        lda wUnitWindowCurrentLine
        dec a
        tax
        lda wUnitWindowUnitSwapStartSlot
        dec a
        jsr rsUnitWindowSwapUnits
        jsl rlUnitWindowGetPromotionFlagsAndWeapons
        lda #UNIT_WINDOW_SORT_JOIN_ORDER
        sta wUnitWindowSortType
        sta wUnitWindowSortDirection
        lda #$0002
        sta wUnitWindowUnitSwapStep
        jml _C3B7


        _C3F1
        lda #$0021
        jsl rlPlaySoundEffect

        _C3F8
        lda #$0000
        sta wUnitWindowUnitSwapStep
        sta wUnitWindowUnitSwapStartCursorYCoordinate
        sta wUnitWindowUnitSwapStartSlot
        jml _C3B7


        _C40B
        ldx #$01C8
        lda #$0030
        ldy #$0005
        jsl rlClearTilemapRect
        jsl rlUnitWindowDrawUnitNames
        jsl rlUnitWindowDrawPage
        lda #$0003
        sta wUnitWindowUnitSwapStep
        jml _C3B7


        _C42B
        jsl rlUnitWindowDrawUnitSkills
        lda #$0000
        sta wUnitWindowUnitSwapStep
        jml _C3F8

        .databank 0

        ; 8B/C43A

    .endsection Unsorted8BC391Section


    .section Unsorted8BC43ASection

      .al
      .xl

      rlUnitWindowCopySpritePalette1 ; 8B/C43A

        .al
        .xl
        .autsiz
        .databank ?

        ; A: sprite palette. Copies aItemIconPalette (the item icons' colours) into that sprite palette of the palette buffer.

        asl a
        tax
        lda aUnitWindowSpritePaletteOffsets,x
        tay
        ldx #$001E

        _C444
        lda aItemIconPalette,x
        dec x
        dec x
        phx
        tyx
        sta @l aBGPaletteBuffer,x
        dec x
        dec x
        txy
        plx
        bpl _C444
        rtl

        .databank 0

        ; 8B/C457

    .endsection Unsorted8BC43ASection


    .section Table8BC457Section

      .al
      .xl

      aUnitWindowSpritePaletteOffsets ; 8B/C457

        ; Read by rlUnitWindowCopySpritePalette1, rlUnitWindowCopySpritePalette2.

        .word $011E, $013E, $015E, $017E, $019E, $01BE, $01DE, $01FE

        ; 8B/C467

    .endsection Table8BC457Section


    .section Unsorted8BC467Section

      .al
      .xl

      rlUnitWindowCopySpritePalette2 ; 8B/C467

        .al
        .xl
        .autsiz
        .databank ?

        ; A: sprite palette. Copies aUnitWindowSpritePalette2 (what it colours is not known) into that sprite palette of the palette buffer.

        asl a
        tax
        lda aUnitWindowSpritePaletteOffsets,x
        tay
        ldx #$001E

        _C471
        lda aUnitWindowSpritePalette2,x
        dec x
        dec x
        phx
        tyx
        sta @l aBGPaletteBuffer,x
        dec x
        dec x
        txy
        plx
        bpl _C471
        rtl

        .databank 0

        ; 8B/C484

    .endsection Unsorted8BC467Section


    .section Unsorted8BC484Section

      .al
      .xl

      rlUnitWindowGetEquippedWeaponID ; 8B/C484

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Returns the selected unit's equipped weapon's item ID with carry clear, or $FFFF with carry set if it has none.

        phx
        jsl rlGetFirstEquippableWeaponInInventory
        tax
        lda wCurrentItemDataROMPointer,b
        beq _C499
        txa
        jsl rlGetItemIDByInventorySlot
        bcs _C499
        clc
        plx
        rtl


        _C499
        lda #$FFFF
        sec
        plx
        rtl

        .databank 0

        ; 8B/C49F

      rsUnitWindowUpdateSort ; 8B/C49F

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Sets wUnitWindowSortType from the column picked (aUnitWindowPageSortTypePointers) and the direction from the button (X ascending), then sorts. FE5: rlUnitWindowUpdateSort.

        lda wGameStateStep,b
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda aUnitWindowPageSortTypePointers+1,x
        sta lR18+1
        lda aUnitWindowPageSortTypePointers,x
        sta lR18
        lda wUnitWindowCurrentColumn
        tay
        lda [lR18],y
        and #$00FF
        sta wUnitWindowSortType
        ldx #$0000
        lda wJoy1New
        bit #$0040
        beq _C4CE
        inc x

        _C4CE
        txa
        sta wUnitWindowSortDirection
        jsl rlUnitWindowGetSortScores
        lda wUnitWindowSortDirection
        bne _C4E3
        jsl rlUnitWindowSetSortDescending
        bra _C4E7


        _C4E3
        jsl rlUnitWindowSetSortAscending

        _C4E7
        jsl rlUnitWindowGetPromotionFlagsAndWeapons
        lda #$0002
        sta wUnitWindowSortTypeFlag
        rts

        .databank 0

        ; 8B/C4F3

      ; The sort type (wUnitWindowSortType) of each column on each page, one byte
      ; per column (wUnitWindowCurrentColumn); aUnitWindowPageSortTypePointers points
      ; at the list for each page. Column 0 is the unit's name, which sorts by type 0.

      aUnitWindowPage0SortTypes ; 8B/C4F3
        .byte UNIT_WINDOW_SORT_JOIN_ORDER, UNIT_WINDOW_SORT_CLASS, UNIT_WINDOW_SORT_LEVEL, UNIT_WINDOW_SORT_EXPERIENCE, UNIT_WINDOW_SORT_HP, UNIT_WINDOW_SORT_MAX_HP
      aUnitWindowPage1SortTypes ; 8B/C4F9
        .byte UNIT_WINDOW_SORT_JOIN_ORDER, UNIT_WINDOW_SORT_WEAPON, UNIT_WINDOW_SORT_MIGHT, UNIT_WINDOW_SORT_HIT, UNIT_WINDOW_SORT_AVOID
      aUnitWindowPage2SortTypes ; 8B/C4FE
        .byte UNIT_WINDOW_SORT_JOIN_ORDER, UNIT_WINDOW_SORT_STRENGTH, UNIT_WINDOW_SORT_MAGIC, UNIT_WINDOW_SORT_SKILL, UNIT_WINDOW_SORT_SPEED, UNIT_WINDOW_SORT_LUCK, UNIT_WINDOW_SORT_DEFENSE, UNIT_WINDOW_SORT_RESISTANCE
      aUnitWindowPage3SortTypes ; 8B/C506
        .byte UNIT_WINDOW_SORT_JOIN_ORDER, UNIT_WINDOW_SORT_MOVEMENT, UNIT_WINDOW_SORT_GOLD, UNIT_WINDOW_SORT_ARENA_LEVEL, UNIT_WINDOW_SORT_TALK_TARGET
      aUnitWindowPage4SortTypes ; 8B/C50B
        .byte UNIT_WINDOW_SORT_JOIN_ORDER, UNIT_WINDOW_SORT_WEAPON_RANK, UNIT_WINDOW_SORT_WEAPON_RANK+1, UNIT_WINDOW_SORT_WEAPON_RANK+2, UNIT_WINDOW_SORT_WEAPON_RANK+3, UNIT_WINDOW_SORT_WEAPON_RANK+4, UNIT_WINDOW_SORT_WEAPON_RANK+5, UNIT_WINDOW_SORT_WEAPON_RANK+6, UNIT_WINDOW_SORT_WEAPON_RANK+7, UNIT_WINDOW_SORT_WEAPON_RANK+8, UNIT_WINDOW_SORT_WEAPON_RANK+9
      aUnitWindowPage5SortTypes ; 8B/C516
        .byte UNIT_WINDOW_SORT_JOIN_ORDER, UNIT_WINDOW_SORT_SKILLS

        ; 8B/C518

    .endsection Unsorted8BC484Section


    .section Table8BC518Section

      .al
      .xl

      aUnitWindowPageSortTypePointers ; 8B/C518

        ; One long pointer per page (wGameStateStep) to its column sort types; read by rsUnitWindowUpdateSort.

        .long aUnitWindowPage0SortTypes
        .long aUnitWindowPage1SortTypes
        .long aUnitWindowPage2SortTypes
        .long aUnitWindowPage3SortTypes
        .long aUnitWindowPage4SortTypes
        .long aUnitWindowPage5SortTypes

        ; 8B/C52A

    .endsection Table8BC518Section


    .section Unsorted8BC52ASection

      .al
      .xl

      rlUnitWindowSetSortDescending ; 8B/C52A

        .al
        .xl
        .autsiz
        .databank ?

        ; FE5: rlUnitWindowSetSortDescending.

        lda wUnitWindowMaxRows
        cmp #$0001
        beq _C56C
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
        ldy #$0000

        _C548
        tyx
        inc x
        inc x

        _C54B
        lda $8407,b,y
        cmp @l aUnitWindowSortScores,x
        bcs _C560
        phx
        phy
        txa
        lsr a
        tax
        tya
        lsr a
        jsr rsUnitWindowSwapSortSlots
        ply
        plx

        _C560
        inc x
        inc x
        cpx wR15
        bne _C54B
        inc y
        inc y
        cpy wR14
        bne _C548

        _C56C
        phk
        plb
        .databank $8B
        rtl

        .databank 0

        ; 8B/C56F

      rlUnitWindowSetSortAscending ; 8B/C56F

        .al
        .xl
        .autsiz
        .databank ?

        ; FE5: rlUnitWindowSetSortAscending.

        lda wUnitWindowMaxRows
        cmp #$0001
        beq _C5C3
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
        ldy #$0000

        _C58D
        tyx
        inc x
        inc x

        _C590
        lda $8407,b,y
        inc a
        eor #$FFFF
        inc a
        sta wR12
        lda @l aUnitWindowSortScores,x
        inc a
        eor #$FFFF
        inc a
        sta wR11
        lda wR12
        cmp wR11
        bcs _C5B7
        phx
        phy
        txa
        lsr a
        tax
        tya
        lsr a
        jsr rsUnitWindowSwapSortSlots
        ply
        plx

        _C5B7
        inc x
        inc x
        cpx wR15
        bne _C590
        inc y
        inc y
        cpy wR14
        bne _C58D

        _C5C3
        phk
        plb
        .databank $8B
        rtl

        .databank 0

        ; 8B/C5C6

    .endsection Unsorted8BC52ASection


    .section Unsorted8BC5C6Section

      .al
      .xl

      rlUnitWindowDrawSortLabel ; 8B/C5C6

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws the label of wUnitWindowSortType through the jump table after this routine. FE5: rlUnitWindowFE4DrawSortLabels.

        lda #$0000
        sta aBG3TilemapBuffer
        sta $7E838A
        sta $7E838C
        sta $7E838E
        sta $7E8390
        sta $7E83C8
        sta $7E83CA
        sta $7E83CC
        sta $7E83CE
        sta $7E83D0
        lda wUnitWindowSortType
        cmp #$0026
        bmi _C5FC

        _C5FA
        bra _C5FA


        _C5FC
        asl a
        tax
        jsr (aUnitWindowSortLabelDrawers,x)
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $000A, $80, $B044

        jsl rlDMAByStruct

          .structDMAToVRAM $7E83C8, $000C, $80, $B084

        rtl

        .databank 0

        ; 8B/C61C

    .endsection Unsorted8BC5C6Section


    .section Table8BC61CSection

      .al
      .xl

      aUnitWindowSortLabelDrawers ; 8B/C61C

        ; One per sort type (wUnitWindowSortType); $0000 marks an unused type.
        .word <>rsUnitWindowDrawJoinOrderSortLabel
        .word <>rsUnitWindowDrawClassSortLabel
        .word <>rsUnitWindowDrawLevelSortLabel
        .word <>rsUnitWindowDrawExperienceSortLabel
        .word <>rsUnitWindowDrawCurrentHPSortLabel
        .word <>rsUnitWindowDrawMaxHPSortLabel
        .word <>rsUnitWindowDrawWeaponSortLabel
        .word <>rsUnitWindowDrawMightSortLabel
        .word <>rsUnitWindowDrawHitSortLabel
        .word <>rsUnitWindowDrawAvoidSortLabel
        .word <>rsUnitWindowDrawStrengthSortLabel
        .word <>rsUnitWindowDrawMagicSortLabel
        .word <>rsUnitWindowDrawSkillSortLabel
        .word <>rsUnitWindowDrawSpeedSortLabel
        .word <>rsUnitWindowDrawLuckSortLabel
        .word <>rsUnitWindowDrawDefenseSortLabel
        .word <>rsUnitWindowDrawResistanceSortLabel
        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word <>rsUnitWindowDrawMoneySortLabel
        .word $0000
        .word <>rsUnitWindowDrawMovementSortLabel
        .word <>rsUnitWindowDrawNoSortLabel
        .word <>rsUnitWindowDrawNoSortLabel
        .word <>rsUnitWindowDrawNoSortLabel
        .word <>rsUnitWindowDrawNoSortLabel
        .word <>rsUnitWindowDrawNoSortLabel
        .word <>rsUnitWindowDrawNoSortLabel
        .word <>rsUnitWindowDrawNoSortLabel
        .word <>rsUnitWindowDrawNoSortLabel
        .word <>rsUnitWindowDrawNoSortLabel
        .word <>rsUnitWindowDrawNoSortLabel
        .word <>rsUnitWindowDrawSkillsSortLabel
        .word <>rsUnitWindowDrawArenaLevelSortLabel
        .word <>rsUnitWindowDrawTalkTargetSortLabel

    .endsection Table8BC61CSection


    .section Unsorted8BC668Section

      .al
      .xl

      rsUnitWindowDrawJoinOrderSortLabel ; 8B/C668

        .al
        .xl
        .autsiz
        .databank ?

        ; Entry 0 (sort type 0) of rlUnitWindowDrawSortLabel's table.

        lda #$3000
        sta wR1
        lda #$024C
        sta wR2
        lda #$0004
        sta wR0
        ldx #$0002
        jsl rlDrawBG3TileRun
        rts

        .databank 0

        ; 8B/C67F

    .endsection Unsorted8BC668Section


    .section UnitWindowSortLabelDrawersSection

      .al
      .xl

      rsUnitWindowDrawClassSortLabel ; 8B/C67F

        .al
        .xl
        .autsiz
        .databank ?

        ; Sort type 1 (class).

        lda #$3000
        sta wR1
        lda #$0260
        sta wR2
        lda #$0005
        sta wR0
        ldx #$0000
        jsl rlDrawBG3TileRun
        rts

        .databank 0

        ; 8B/C696

      rsUnitWindowDrawLevelSortLabel ; 8B/C696

        .al
        .xl
        .autsiz
        .databank ?

        ; Sort type 2 (level).

        lda #$3000
        sta wR1
        lda #$020C
        sta wR2
        lda #$0001
        sta wR0
        ldx #$0002
        jsl rlDrawBG3TileRun
        lda #$3000
        sta wR1
        lda #$020D
        sta wR2
        lda #$0001
        sta wR0
        ldx #$0006
        jsl rlDrawBG3TileRun
        rts

        .databank 0

        ; 8B/C6C3

      rsUnitWindowDrawExperienceSortLabel ; 8B/C6C3

        .al
        .xl
        .autsiz
        .databank ?

        ; Sort type 3 (experience).

        lda #$3000
        sta wR1
        lda #$020E
        sta wR2
        lda #$0001
        sta wR0
        ldx #$0002
        jsl rlDrawBG3TileRun
        lda #$3000
        sta wR1
        lda #$020F
        sta wR2
        lda #$0001
        sta wR0
        ldx #$0006
        jsl rlDrawBG3TileRun
        rts

        .databank 0

        ; 8B/C6F0

      rsUnitWindowDrawCurrentHPSortLabel ; 8B/C6F0

        .al
        .xl
        .autsiz
        .databank ?

        ; Sort type 4 (current HP).

        lda #$3000
        sta wR1
        lda #$0220
        sta wR2
        lda #$0001
        sta wR0
        ldx #$0002
        jsl rlDrawBG3TileRun
        lda #$3000
        sta wR1
        lda #$0221
        sta wR2
        lda #$0001
        sta wR0
        ldx #$0006
        jsl rlDrawBG3TileRun
        rts

        .databank 0

        ; 8B/C71D

      rsUnitWindowDrawMaxHPSortLabel ; 8B/C71D

        .al
        .xl
        .autsiz
        .databank ?

        ; Sort type 5 (maximum HP).

        lda #$3000
        sta wR1
        lda #$01C1
        sta wR2
        lda #$0003
        sta wR0
        ldx #$0002
        jsl rlDrawBG3TileRun
        rts

        .databank 0

        ; 8B/C734

      rsUnitWindowDrawWeaponSortLabel ; 8B/C734

        .al
        .xl
        .autsiz
        .databank ?

        ; Sort type 6 (equipped weapon).

        lda #$3000
        sta wR1
        lda #$01A9
        sta wR2
        lda #$0001
        sta wR0
        ldx #$0002
        jsl rlDrawBG3TileRun
        lda #$3000
        sta wR1
        lda #$01AA
        sta wR2
        lda #$0001
        sta wR0
        ldx #$0006
        jsl rlDrawBG3TileRun
        rts

        .databank 0

        ; 8B/C761

      rsUnitWindowDrawMightSortLabel ; 8B/C761

        .al
        .xl
        .autsiz
        .databank ?

        ; Sort type 7 (might).

        lda #$3000
        sta wR1
        lda #$0180
        sta wR2
        lda #$0001
        sta wR0
        ldx #$0002
        jsl rlDrawBG3TileRun
        lda #$3000
        sta wR1
        lda #$0181
        sta wR2
        lda #$0001
        sta wR0
        ldx #$0006
        jsl rlDrawBG3TileRun
        rts

        .databank 0

        ; 8B/C78E

      rsUnitWindowDrawHitSortLabel ; 8B/C78E

        .al
        .xl
        .autsiz
        .databank ?

        ; Sort type 8 (hit).

        lda #$3000
        sta wR1
        lda #$0182
        sta wR2
        lda #$0002
        sta wR0
        ldx #$0002
        jsl rlDrawBG3TileRun
        lda #$3000
        sta wR1
        lda #$0188
        sta wR2
        lda #$0001
        sta wR0
        ldx #$0006
        jsl rlDrawBG3TileRun
        rts

        .databank 0

        ; 8B/C7BB

      rsUnitWindowDrawAvoidSortLabel ; 8B/C7BB

        .al
        .xl
        .autsiz
        .databank ?

        ; Sort type 9 (avoid).

        lda #$3000
        sta wR1
        lda #$0184
        sta wR2
        lda #$0002
        sta wR0
        ldx #$0002
        jsl rlDrawBG3TileRun
        lda #$3000
        sta wR1
        lda #$0188
        sta wR2
        lda #$0001
        sta wR0
        ldx #$0006
        jsl rlDrawBG3TileRun
        rts

        .databank 0

        ; 8B/C7E8

      rsUnitWindowDrawStrengthSortLabel ; 8B/C7E8

        .al
        .xl
        .autsiz
        .databank ?

        ; Sort type 10 (strength).

        lda #$3000
        sta wR1
        lda #$01C4
        sta wR2
        lda #$0001
        sta wR0
        ldx #$0004
        jsl rlDrawBG3TileRun
        rts

        .databank 0

        ; 8B/C7FF

      rsUnitWindowDrawMagicSortLabel ; 8B/C7FF

        .al
        .xl
        .autsiz
        .databank ?

        ; Sort type 11 (magic).

        lda #$3000
        sta wR1
        lda #$018D
        sta wR2
        lda #$0001
        sta wR0
        ldx #$0002
        jsl rlDrawBG3TileRun
        lda #$3000
        sta wR1
        lda #$018E
        sta wR2
        lda #$0001
        sta wR0
        ldx #$0006
        jsl rlDrawBG3TileRun
        rts

        .databank 0

        ; 8B/C82C

      rsUnitWindowDrawSkillSortLabel ; 8B/C82C

        .al
        .xl
        .autsiz
        .databank ?

        ; Sort type 12 (skill stat).

        lda #$3000
        sta wR1
        lda #$01C6
        sta wR2
        lda #$0001
        sta wR0
        ldx #$0002
        jsl rlDrawBG3TileRun
        lda #$3000
        sta wR1
        lda #$01C7
        sta wR2
        lda #$0001
        sta wR0
        ldx #$0006
        jsl rlDrawBG3TileRun
        rts

        .databank 0

        ; 8B/C859

      rsUnitWindowDrawSpeedSortLabel ; 8B/C859

        .al
        .xl
        .autsiz
        .databank ?

        ; Sort type 13 (speed).

        lda #$3000
        sta wR1
        lda #$018F
        sta wR2
        lda #$0001
        sta wR0
        ldx #$0002
        jsl rlDrawBG3TileRun
        lda #$3000
        sta wR1
        lda #$01A0
        sta wR2
        lda #$0001
        sta wR0
        ldx #$0006
        jsl rlDrawBG3TileRun
        rts

        .databank 0

        ; 8B/C886

      rsUnitWindowDrawLuckSortLabel ; 8B/C886

        .al
        .xl
        .autsiz
        .databank ?

        ; Sort type 14 (luck).

        lda #$3000
        sta wR1
        lda #$0189
        sta wR2
        lda #$0001
        sta wR0
        ldx #$0002
        jsl rlDrawBG3TileRun
        lda #$3000
        sta wR1
        lda #$018A
        sta wR2
        lda #$0001
        sta wR0
        ldx #$0006
        jsl rlDrawBG3TileRun
        rts

        .databank 0

        ; 8B/C8B3

      rsUnitWindowDrawDefenseSortLabel ; 8B/C8B3

        .al
        .xl
        .autsiz
        .databank ?

        ; Sort type 15 (defense).

        lda #$3000
        sta wR1
        lda #$01A1
        sta wR2
        lda #$0001
        sta wR0
        ldx #$0002
        jsl rlDrawBG3TileRun
        lda #$3000
        sta wR1
        lda #$01A2
        sta wR2
        lda #$0001
        sta wR0
        ldx #$0006
        jsl rlDrawBG3TileRun
        rts

        .databank 0

        ; 8B/C8E0

      rsUnitWindowDrawResistanceSortLabel ; 8B/C8E0

        .al
        .xl
        .autsiz
        .databank ?

        ; Sort type 16 (resistance).

        lda #$3000
        sta wR1
        lda #$018D
        sta wR2
        lda #$0001
        sta wR0
        ldx #$0002
        jsl rlDrawBG3TileRun
        lda #$3000
        sta wR1
        lda #$01A3
        sta wR2
        lda #$0001
        sta wR0
        ldx #$0006
        jsl rlDrawBG3TileRun
        rts

        .databank 0

        ; 8B/C90D

      rsUnitWindowDrawMoneySortLabel ; 8B/C90D

        .al
        .xl
        .autsiz
        .databank ?

        ; Sort type 22 (gold).

        lda #$3000
        sta wR1
        lda #$01A6
        sta wR2
        lda #$0003
        sta wR0
        ldx #$0002
        jsl rlDrawBG3TileRun
        rts

        .databank 0

        ; 8B/C924

      rsUnitWindowDrawMovementSortLabel ; 8B/C924

        .al
        .xl
        .autsiz
        .databank ?

        ; Sort type 24 (movement).

        lda #$3000
        sta wR1
        lda #$0186
        sta wR2
        lda #$0001
        sta wR0
        ldx #$0002
        jsl rlDrawBG3TileRun
        lda #$3000
        sta wR1
        lda #$0187
        sta wR2
        lda #$0001
        sta wR0
        ldx #$0006
        jsl rlDrawBG3TileRun
        rts

        .databank 0

        ; 8B/C951

      rsUnitWindowDrawNoSortLabel ; 8B/C951

        .al
        .xl
        .autsiz
        .databank ?

        ; Sort types 25-34 (the weapon ranks): no label; the weapon rank icon is drawn as a sprite instead (rsUnitWindowRenderWeaponRankSortIcon).

        rts

        .databank 0

        ; 8B/C952

      rsUnitWindowDrawSkillsSortLabel ; 8B/C952

        .al
        .xl
        .autsiz
        .databank ?

        ; Sort type 35 (skills): draws the text スキル.

        lda #$3000
        sta aCurrentTilemapInfo,b
        lda #(`aUnitWindowSkillsSortLabelText)<<8
        sta lR18+1
        lda #<>aUnitWindowSkillsSortLabelText
        sta lR18
        ldx #$0001
        jsl rlDrawMenuTextLine
        rts

        .databank 0

        ; 8B/C96A

    .endsection UnitWindowSortLabelDrawersSection


    .section Table8BC96ASection

      .al
      .xl

      aUnitWindowSkillsSortLabelText ; 8B/C96A

        .enc "SJIS"
        .text "スキル"
        .word $0000
        .enc "none"


    .endsection Table8BC96ASection


    .section UnitWindowSortLabelDrawers2Section

      .al
      .xl

      rsUnitWindowDrawArenaLevelSortLabel ; 8B/C972

        .al
        .xl
        .autsiz
        .databank ?

        ; Sort type 36 (arena level).

        lda #$3000
        sta wR1
        lda #$02EC
        sta wR2
        lda #$0004
        sta wR0
        ldx #$0002
        jsl rlDrawBG3TileRun
        rts

        .databank 0

        ; 8B/C989

      rsUnitWindowDrawTalkTargetSortLabel ; 8B/C989

        .al
        .xl
        .autsiz
        .databank ?

        ; Sort type 37 (talk target, the lover).

        lda #$3000
        sta wR1
        lda #$01AF
        sta wR2
        lda #$0001
        sta wR0
        ldx #$0002
        jsl rlDrawBG3TileRun
        lda #$3000
        sta wR1
        lda #$01C0
        sta wR2
        lda #$0001
        sta wR0
        ldx #$0006
        jsl rlDrawBG3TileRun
        rts

        .databank 0

        ; 8B/C9B6

    .endsection UnitWindowSortLabelDrawers2Section


    .section Unsorted8BC9B6Section

      .al
      .xl

      rsUnitWindowSwapUnits ; 8B/C9B6

        .al
        .xl
        .autsiz
        .databank ?

        ; A, X: two lines, counted from 0. Swaps their deployment and sprite slots, then renumbers aUnitJoinOrder from the new order.

        asl a
        tay
        txa
        asl a
        tax
        sta wR1
        lda aUnitWindowDeploymentSlots,x
        sta wR0
        tyx
        lda aUnitWindowDeploymentSlots,x
        ldx wR1
        sta aUnitWindowDeploymentSlots,x
        lda wR0
        tyx
        sta aUnitWindowDeploymentSlots,x
        ldx wR1
        lda aUnitWindowSpriteSlots,x
        sta wR0
        tyx
        lda aUnitWindowSpriteSlots,x
        ldx wR1
        sta aUnitWindowSpriteSlots,x
        lda wR0
        tyx
        sta aUnitWindowSpriteSlots,x
        lda #$0001
        sta wR0
        stz wR2

        _C9F6
        lda wR2
        asl a
        tax
        lda aUnitWindowDeploymentSlots,x
        beq _CA19
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitGenerationID
        dec a
        tax
        sep #$20
        lda wR0
        sta $7E531B,x
        rep #$20
        inc wR0
        inc wR2
        bra _C9F6


        _CA19
        rts

        .databank 0

        ; 8B/CA1A

    .endsection Unsorted8BC9B6Section


    .section Unsorted8BCA1ASection

      .al
      .xl

      rlUnitWindowGetSortScores ; 8B/CA1A

        .al
        .xl
        .autsiz
        .databank ?

        ; Fills the sort scores for wUnitWindowSortType through aUnitWindowSortScoreGetters. FE5: rlUnitWindowGetSortScores.

        lda wUnitWindowSortType
        bmi _CA30
        lda wUnitWindowSortType
        cmp #$0027
        bmi _CA2B

        _CA29
        bra _CA29


        _CA2B
        asl a
        tax
        jsr (aUnitWindowSortScoreGetters,x)

        _CA30
        rtl

        .databank 0

        ; 8B/CA31

    .endsection Unsorted8BCA1ASection


    .section Table8BCA31Section

      .al
      .xl

      aUnitWindowSortScoreGetters ; 8B/CA31

        ; One per sort type (wUnitWindowSortType); $0000 marks an unused type.
        .word <>rsUnitWindowGetJoinOrderSortScores
        .word <>rsUnitWindowGetClassSortScores
        .word <>rsUnitWindowGetLevelSortScores
        .word <>rsUnitWindowGetStatSortScores
        .word <>rsUnitWindowGetStatSortScores
        .word <>rsUnitWindowGetStatSortScores
        .word <>rsUnitWindowGetWeaponSortScores
        .word <>rsUnitWindowGetMightSortScores
        .word <>rsUnitWindowGetStatSortScores
        .word <>rsUnitWindowGetAvoidSortScores
        .word <>rsUnitWindowGetStatSortScores
        .word <>rsUnitWindowGetStatSortScores
        .word <>rsUnitWindowGetStatSortScores
        .word <>rsUnitWindowGetStatSortScores
        .word <>rsUnitWindowGetStatSortScores
        .word <>rsUnitWindowGetStatSortScores
        .word <>rsUnitWindowGetStatSortScores
        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word <>rsUnitWindowGetStatSortScores
        .word $0000
        .word <>rsUnitWindowGetStatSortScores
        .word <>rsUnitWindowGetWeaponRankSortScores
        .word <>rsUnitWindowGetWeaponRankSortScores
        .word <>rsUnitWindowGetWeaponRankSortScores
        .word <>rsUnitWindowGetWeaponRankSortScores
        .word <>rsUnitWindowGetWeaponRankSortScores
        .word <>rsUnitWindowGetWeaponRankSortScores
        .word <>rsUnitWindowGetWeaponRankSortScores
        .word <>rsUnitWindowGetWeaponRankSortScores
        .word <>rsUnitWindowGetWeaponRankSortScores
        .word <>rsUnitWindowGetWeaponRankSortScores
        .word <>rsUnitWindowGetSkillsSortScores
        .word <>rsUnitWindowGetStatSortScores
        .word <>rsUnitWindowGetTalkTargetSortScores
        .word <>rsUnitWindowGetSavedOrderSortScores

    .endsection Table8BCA31Section


    .section Unsorted8BCA7FSection

      .al
      .xl

      rsUnitWindowGetJoinOrderSortScores ; 8B/CA7F

        .al
        .xl
        .autsiz
        .databank ?

        ; Sort type 0: scores are each unit's place in aUnitJoinOrder, negated.

        lda wUnitWindowMaxRows
        asl a
        sta wR15
        ldx #$0000

        _CA89
        stx wR14
        lda aUnitWindowDeploymentSlots,x
        beq _CAB3
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitGenerationID
        dec a
        tax
        lda $7E531B,x
        and #$00FF
        eor #$FFFF
        inc a
        ldx wR14
        sta aUnitWindowSortScores,x
        ldx wR14
        inc x
        inc x
        cpx wR15
        bne _CA89

        _CAB3
        rts

        .databank 0

        ; 8B/CAB4

    .endsection Unsorted8BCA7FSection


    .section Unsorted8BCAB4Section

      .al
      .xl

      rsUnitWindowGetSavedOrderSortScores ; 8B/CAB4

        .al
        .xl
        .autsiz
        .databank ?

        ; Sort type $26: scores are the order rlUnitWindowSaveListOrder saved.

        lda wUnitWindowMaxRows
        asl a
        sta wR15
        ldx #$0000

        _CABE
        stx wR14
        lda aUnitWindowDeploymentSlots,x
        beq _CAE4
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitGenerationID
        dec a
        tax
        lda aUnitWindowSavedOrder[0],x
        and #$00FF
        ldx wR14
        sta aUnitWindowSortScores,x
        ldx wR14
        inc x
        inc x
        cpx wR15
        bne _CABE

        _CAE4
        rts

        .databank 0

        ; 8B/CAE5

    .endsection Unsorted8BCAB4Section


    .section UnitWindowLevelSortScoresSection

      .al
      .xl

      rsUnitWindowGetLevelSortScores ; 8B/CAE5

        .al
        .xl
        .autsiz
        .databank ?

        ; Sort type 2: sorts by experience first, then scores by level, so units of the same level stay in experience order.

        lda #UNIT_WINDOW_SORT_EXPERIENCE
        sta wUnitWindowSortType
        jsr rsUnitWindowGetStatSortScores
        lda wUnitWindowSortDirection
        bne _CAFB
        jsl rlUnitWindowSetSortDescending
        bra _CAFF


        _CAFB
        jsl rlUnitWindowSetSortAscending

        _CAFF
        lda #UNIT_WINDOW_SORT_LEVEL
        sta wUnitWindowSortType
        jsr rsUnitWindowGetStatSortScores
        rts

        .databank 0

        ; 8B/CB0A

      rsUnitWindowGetStatSortScores ; 8B/CB0A

        .al
        .xl
        .autsiz
        .databank ?

        ; Sort types that score by one stat: each unit's score is what rlUnitWindowGetSortStat returns.

        lda wUnitWindowMaxRows
        asl a
        sta wR15
        ldx #$0000

        _CB14
        lda aUnitWindowDeploymentSlots,x
        beq _CB2D
        sta wSelectedUnitDataRAMPointer,b
        phx
        jsl rlUnitWindowGetSortStat
        plx
        sta aUnitWindowSortScores,x
        inc x
        inc x
        cpx wR15
        bne _CB14

        _CB2D
        rts

        .databank 0

        ; 8B/CB2E

      rlUnitWindowGetSortStat ; 8B/CB2E

        .al
        .xl
        .autsiz
        .databank ?

        ; Jumps to wUnitWindowSortType's getter in aUnitWindowSortStatGetters for the selected unit.

        lda wUnitWindowSortType
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda aUnitWindowSortStatGetters+1,x
        sta lR18+1
        lda aUnitWindowSortStatGetters,x
        sta lR18
        jml [lR18]

        .databank 0

      aUnitWindowSortStatGetters ; 8B/CB48

        ; One long pointer per sort type (wUnitWindowSortType) for the types
        ; whose score is one getter's value for the unit; $000000 for the rest.
        .long $000000
        .long $000000
        .long rlGetSelectedUnitLevel
        .long rlGetSelectedUnitExperience
        .long rlGetSelectedUnitCurrentHP
        .long rlGetSelectedUnitMaxHP
        .long $000000
        .long $000000
        .long rlGetSelectedUnitFirstWeaponHit
        .long $000000
        .long rlGetSelectedUnitTotalStrength
        .long rlGetSelectedUnitTotalMagic
        .long rlGetSelectedUnitTotalSkill
        .long rlGetSelectedUnitTotalSpeed
        .long rlGetSelectedUnitLuck
        .long rlGetSelectedUnitTotalDefense
        .long rlGetSelectedUnitTotalResistance
        .long $000000
        .long $000000
        .long $000000
        .long $000000
        .long $000000
        .long rlGetSelectedUnitMoney
        .long rlGetSelectedUnitStatus
        .long rlGetSelectedUnitTotalMovement
        .long $000000
        .long $000000
        .long $000000
        .long $000000
        .long $000000
        .long $000000
        .long $000000
        .long $000000
        .long $000000
        .long $000000
        .long $000000
        .long rlGetSelectedUnitArenaLevel
        .long $000000

        ; 8B/CBBA

    .endsection UnitWindowLevelSortScoresSection


    .section UnitWindowSortScoreGettersSection

      .al
      .xl

      rsUnitWindowGetWeaponSortScores ; 8B/CBBA

        .al
        .xl
        .autsiz
        .databank ?

        ; Sort type 6: each unit's score is its equipped weapon's entry in aItemTypeSortRanks (bank $89), or $75 with no weapon.

        phb
        php
        phk
        plb
        .databank $8B
        sep #$20
        lda #$89
        pha
        plb
        .databank $89
        rep #$20
        lda wUnitWindowMaxRows
        asl a
        sta wR15
        ldx #$0000

        _CBD0
        lda aUnitWindowDeploymentSlots,x
        beq _CBF5
        sta wSelectedUnitDataRAMPointer,b
        jsl rlUnitWindowGetEquippedWeaponID
        bcc _CBE4
        lda #$0075
        bra _CBEB


        _CBE4
        tay
        lda <>aItemTypeSortRanks,b,y
        and #$00FF

        _CBEB
        sta aUnitWindowSortScores,x
        inc x
        inc x
        cpx wR15
        bne _CBD0

        _CBF5
        plp
        plb
        .databank $89
        rts

        .databank 0

        ; 8B/CBF8

      rsUnitWindowGetWeaponRankSortScores ; 8B/CBF8

        .al
        .xl
        .autsiz
        .databank ?

        ; Sort types 25-34: the score is the weapon rank of type (sort type - 25), negated so better ranks sort first.

        lda wUnitWindowMaxRows
        asl a
        sta wR15
        lda wUnitWindowSortType
        sec
        sbc #UNIT_WINDOW_SORT_WEAPON_RANK
        sta wR14
        ldx #$0000

        _CC0C
        lda aUnitWindowDeploymentSlots,x
        beq _CC30
        sta wSelectedUnitDataRAMPointer,b
        lda wR14
        jsl rlGetSelectedUnitWeaponRank
        php
        inc a
        inc a
        eor #$FFFF
        inc a
        plp
        adc #$0000
        sta aUnitWindowSortScores,x
        inc x
        inc x
        cpx wR15
        bne _CC0C

        _CC30
        rts

        .databank 0

        ; 8B/CC31

      rsUnitWindowGetClassSortScores ; 8B/CC31

        .al
        .xl
        .autsiz
        .databank ?

        ; Sort type 1: the score is the negated class ID + 1, so classes sort in ID order.

        lda wUnitWindowMaxRows
        asl a
        sta wR15
        ldx #$0000

        _CC3B
        lda aUnitWindowDeploymentSlots,x
        beq _CC57
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitClassID
        inc a
        eor #$FFFF
        inc a
        sta aUnitWindowSortScores,x
        inc x
        inc x
        cpx wR15
        bne _CC3B

        _CC57
        rts

        .databank 0

        ; 8B/CC58

      rsUnitWindowGetSkillsSortScores ; 8B/CC58

        .al
        .xl
        .autsiz
        .databank ?

        ; Sort type 35: the score is how many of the unit's skills have an icon in aUnitWindowSkillIconTiles.

        lda wUnitWindowMaxRows
        asl a
        sta wR15
        ldx #$0000

        _CC62
        lda aUnitWindowDeploymentSlots,x
        beq _CCA8
        sta wSelectedUnitDataRAMPointer,b
        jsl rlCollectSelectedUnitIconSkills
        lda $7E2000
        beq _CC9E
        phx
        lda #$0000
        sta wR13
        sta wR14

        _CC7D
        tax
        lda $7E2002,x
        and #$00FF
        beq _CC92
        txa
        asl a
        tax
        lda aUnitWindowSkillIconTiles,x
        beq _CC92
        inc wR14

        _CC92
        inc wR13
        lda wR13
        cmp #$001F
        bne _CC7D
        lda wR14
        plx

        _CC9E
        sta aUnitWindowSortScores,x
        inc x
        inc x
        cpx wR15
        bne _CC62

        _CCA8
        rts

        .databank 0

        ; 8B/CCA9

      rsUnitWindowGetMightSortScores ; 8B/CCA9

        .al
        .xl
        .autsiz
        .databank ?

        ; Sort type 7: the score is the battle might of the unit's first weapon.

        lda wUnitWindowMaxRows
        asl a
        sta wR15
        ldx #$0000

        _CCB3
        lda aUnitWindowDeploymentSlots,x
        beq _CCD0
        sta wSelectedUnitDataRAMPointer,b
        lda #$0000
        sta wRoutineVariable1,b
        jsl rlGetFirstWeaponBattleMight
        sta aUnitWindowSortScores,x
        inc x
        inc x
        cpx wR15
        bne _CCB3

        _CCD0
        rts

        .databank 0

        ; 8B/CCD1

      rsUnitWindowGetAvoidSortScores ; 8B/CCD1

        .al
        .xl
        .autsiz
        .databank ?

        ; Sort type 9: the score is the unit's battle avoid + $80, keeping it positive.

        lda wUnitWindowMaxRows
        asl a
        sta wR15
        ldx #$0000

        _CCDB
        lda aUnitWindowDeploymentSlots,x
        beq _CCF9
        sta wSelectedUnitDataRAMPointer,b
        lda #$FFFF
        jsl rlGetSelectedUnitFirstWeaponAvoid
        clc
        adc #$0080
        sta aUnitWindowSortScores,x
        inc x
        inc x
        cpx wR15
        bne _CCDB

        _CCF9
        rts

        .databank 0

        ; 8B/CCFA

      rsUnitWindowGetTalkTargetSortScores ; 8B/CCFA

        .al
        .xl
        .autsiz
        .databank ?

        ; Sort type 37: the score is the negated character ID of the unit's living talk target.

        lda wUnitWindowMaxRows
        asl a
        sta wR15
        ldx #$0000

        _CD04
        lda aUnitWindowDeploymentSlots,x
        beq _CD1F
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitLivingTalkTarget
        eor #$FFFF
        inc a
        sta aUnitWindowSortScores,x
        inc x
        inc x
        cpx wR15
        bne _CD04

        _CD1F
        rts

        .databank 0

        ; 8B/CD20

    .endsection UnitWindowSortScoreGettersSection


    .section Unsorted8BCD20Section

      .al
      .xl

      rsUnitWindowSwapSortSlots ; 8B/CD20

        .al
        .xl
        .autsiz
        .databank ?

        ; FE5: rsUnitWindowSwapSortSlots (FE4's version handles two lists).

        sta wR0
        cpx wR0
        bpl _CD29
        tay
        txa
        tyx

        _CD29
        sta wR3
        stx wR4
        asl a
        sta wR1
        txa
        asl a
        sta wR2
        ldx wR2
        lda aUnitWindowDeploymentSlots,x
        sta wR0

        _CD3C
        lda aUnitWindowDeploymentSlots-2,x
        sta aUnitWindowDeploymentSlots,x
        dec x
        dec x
        cpx wR1
        bne _CD3C
        lda wR0
        sta aUnitWindowDeploymentSlots,x
        ldx wR2
        lda aUnitWindowSpriteSlots,x
        sta wR0

        _CD58
        lda aUnitWindowSpriteSlots-2,x
        sta aUnitWindowSpriteSlots,x
        dec x
        dec x
        cpx wR1
        bne _CD58
        lda wR0
        sta aUnitWindowSpriteSlots,x
        ldx wR2
        lda aUnitWindowSortScores,x
        sta wR0

        _CD74
        lda wUnitWindowCurrentItemIconSlot,x
        sta aUnitWindowSortScores,x
        dec x
        dec x
        cpx wR1
        bne _CD74
        lda wR0
        sta aUnitWindowSortScores,x
        rts

        .databank 0

        ; 8B/CD89

    .endsection Unsorted8BCD20Section


    .section Unsorted8BCD89Section

      .al
      .xl

      rlUnitWindowGetPromotionFlagsAndWeapons ; 8B/CD89

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; For each line: whether the unit can promote now (aUnitWindowReadyToPromoteFlags) and its equipped weapon's data pointer ($7F835F).

        ldx #$0000

        _CD8C
        lda aUnitWindowDeploymentSlots,x
        beq _CDB4
        sta wSelectedUnitDataRAMPointer,b
        ldy #$0000
        jsl rlGetPromotedClassIfAvailable
        lda $7E2000
        cmp #$0001
        bne _CDA8
        ldy #$0001

        _CDA8
        tya
        sta aUnitWindowReadyToPromoteFlags,x
        inc x
        inc x
        cpx #$0030
        bne _CD8C

        _CDB4
        lda #$0000
        sta wR15

        _CDB9
        ldx wR15
        lda aUnitWindowDeploymentSlots,x
        beq _CDD7
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetFirstEquippableWeaponInInventory
        ldx wR15
        lda wCurrentItemDataROMPointer,b
        sta aUnitWindowEquippedWeaponPointers,x
        inc wR15
        inc wR15
        bra _CDB9


        _CDD7
        rtl

        .databank 0

        ; 8B/CDD8

    .endsection Unsorted8BCD89Section


    .section Unsorted8BCE29Section

      .al
      .xl

      rlUnitWindowSaveListOrder ; 8B/CE29

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Saves each listed unit's place, negated, at aUnitWindowSavedOrder by generation ID, so the list can reopen in the same order. FE5: 90/DF80.

        lda wSelectedUnitDataRAMPointer,b
        sta wR1
        sep #$20
        lda #$00
        ldx #$0017

        _CE35
        sta aUnitWindowSavedOrder[0],x
        dec x
        bne _CE35
        rep #$20
        lda #$0001

        _CE41
        sta wR0
        dec a
        asl a
        tax
        lda aUnitWindowDeploymentSlots,x
        beq _CE6B
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitGenerationID
        dec a
        tax
        lda wR0
        eor #$FFFF
        inc a
        sep #$20
        sta aUnitWindowSavedOrder[0],x
        rep #$20
        lda wR0
        inc a
        cmp #$0019
        bne _CE41

        _CE6B
        lda wR1
        sta wSelectedUnitDataRAMPointer,b
        rtl

        .databank 0

        ; 8B/CE71

    .endsection Unsorted8BCE29Section


    .section Unsorted8BCE71Section

      .al
      .xl

      rlResetUnitWindowSettings ; 8B/CE71

        .al
        .xl
        .autsiz
        .databank ?

        ; Clears the saved page, sort, list order and saved order. Run for a new game and when units are reset for a chapter.

        phb
        php
        phk
        plb
        .databank $8B
        lda #$0000
        sta wUnitWindowPage
        sta wUnitWindowSortType
        sta wUnitWindowSortDirection
        sta wItemWindowSortMode
        sep #$20
        lda #$00
        ldx #$0017

        _CE8F
        sta $7E531B,x
        dec x
        bpl _CE8F
        lda #$00
        ldx #$0017

        _CE9B
        sta aUnitWindowSavedOrder[0],x
        dec x
        bne _CE9B
        lda #$00
        sta bUnitWindowHasSavedOrder
        rep #$20
        plp
        plb
        .databank $8B
        rtl

        .databank 0

        ; 8B/CEAD

      rlUnitWindowClearSavedListOrder ; 8B/CEAD

        .al
        .xl
        .autsiz
        .databank ?

        ; Clears the order rlUnitWindowSaveListOrder saved. Run after loading a save.

        phb
        php
        phk
        plb
        .databank $8B
        sep #$20
        lda #$00
        sta bUnitWindowHasSavedOrder
        lda #$00
        ldx #$0017

        _CEBE
        sta aUnitWindowSavedOrder[0],x
        dec x
        bne _CEBE
        rep #$20
        plp
        plb
        .databank $8B
        rtl

        .databank 0

        ; 8B/CECA

    .endsection Unsorted8BCE71Section


    .section Unsorted8BA7F2Section

      .al
      .xl

      rlUnitWindowShow ; 8B/A7F2

        .al
        .xl
        .autsiz
        .databank ?

        ; Game state routine $21, once: starts the fade-in, sets up the line highlight and the current page's extras, turns the screen on and moves on to rlUnitWindowRunPageTurnInput.

        inc wGameStateRoutine1,b
        lda #$0001
        sta wUnitWindowAction
        jsr rsUnitWindowCopyLineHighlightColors
        lda wGameStateStep,b
        cmp #$0004
        bne _A80C
        jsr rsUnitWindowRenderWeaponRankIcons
        bra _A816


        _A80C
        cmp #$0005
        bne _A816
        lda #$0017
        sta bBufferTM

        _A816
        sep #$20
        lda #$0F
        sta bBufferINIDISP
        rep #$20
        rtl

        .databank 0

        ; 8B/A81F

      rlUnitWindowRunPageTurnInput ; 8B/A81F

        .al
        .xl
        .autsiz
        .databank ?

        ; Game state routine $22, every frame: unless an action, sort selection or swap is under way, runs the current page's page-turn input from aUnitWindowPageTurnInputHandlers.

        phb
        php
        phk
        plb
        .databank $8B
        lda wUnitWindowAction
        bne _A842
        lda wUnitWindowSortTypeFlag
        ora wUnitWindowUnitSwapStep
        bne _A842
        lda wGameStateStep,b
        cmp #$0006
        bmi _A83D

        _A83B
        bra _A83B


        _A83D
        asl a
        tax
        jsr (aUnitWindowPageTurnInputHandlers,x)

        _A842
        plp
        plb
        .databank $8B
        rtl

        .databank 0

        ; 8B/A845

    .endsection Unsorted8BA7F2Section


    .section Unsorted8BA851Section

      .al
      .xl

      rlUnitWindowHandleInput ; 8B/A851

        .al
        .xl
        .autsiz
        .databank ?

        ; Game state routine $20, every frame while the unit window is open. Runs wUnitWindowAction (1 fade in, 2 fade out and rlUnitWindowCloseWithLocationReload, 3 rlUnitWindowCloseToMap, 4 fade out and rlUnitWindowOpenSelectedUnitScreen), scrolling, sort selection and unit swapping; otherwise the buttons: B closes, A picks the unit (rlUnitWindowCloseToMap with the cursor on it if it is on the map, else rlUnitWindowOpenSelectedUnitScreen), Y starts a swap, Select and Start go to the first and last unit, L and R turn a page of lines, up and down move.

        lda wUnitWindowPageScrollFlag
        bne _A85A
        jsr rsUnitWindowCopyLineHighlightColors

        _A85A
        lda wUnitWindowSortTypeFlag
        bne _A86B
        jsl rlUnitWindowRenderUnitSwapCursors
        jsl rlUnitWindowRenderPageSprites
        jsr rsUnitWindowRenderSprites

        _A86B
        lda wUnitWindowSortTypeFlag
        bne _A886
        lda wGameStateStep,b
        cmp #$0004
        bne _A87E
        jsr rsUnitWindowRenderWeaponRankIcons
        bra _A886


        _A87E
        cmp #$0001
        bne _A886
        jsr rsUnitWindowRenderItemIcons

        _A886
        lda wUnitWindowAction
        cmp #$0001
        beq _A8A0
        cmp #$0002
        beq _A8C1
        cmp #$0003
        beq _A8DA
        cmp #$0004
        beq _A8DE
        bra _A8F8


        _A8A0
        sep #$20
        lda bBufferINIDISP
        clc
        adc #$05
        sta bBufferINIDISP
        rep #$20
        cmp #$000F
        bcc _A8F7
        sep #$20
        lda #$0F
        sta bBufferINIDISP
        rep #$20
        lda #$0000
        sta wUnitWindowAction
        bra _A8F7


        _A8C1
        sep #$20
        lda bBufferINIDISP
        sec
        sbc #$01
        sta bBufferINIDISP
        rep #$20
        bpl _A8F7
        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        jml rlUnitWindowCloseWithLocationReload


        _A8DA
        jml rlUnitWindowCloseToMap


        _A8DE
        sep #$20
        lda bBufferINIDISP
        sec
        sbc #$05
        sta bBufferINIDISP
        rep #$20
        bpl _A8F7
        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        jml rlUnitWindowOpenSelectedUnitScreen


        _A8F7
        rtl


        _A8F8
        lda wUnitWindowScrollingFlag
        bmi _A963
        bne _A967
        lda wUnitWindowSortTypeFlag
        beq _A90A
        jml _A97B


        _A90A
        lda wUnitWindowUnitSwapStep
        beq _A914
        jml rlUnitWindowUnitSwapStep


        _A914
        lda #$0000
        sta wUnitWindowPageScrollFlag
        lda wJoy1New
        bmi _A94F
        bit #$0080
        bne _A953
        bit #$0040
        bne _A957
        bit #$2000
        bne _A96B
        bit #$1000
        bne _A96F
        bit #$4000
        bne _A97F
        bit #$0020
        bne _A973
        bit #$0010
        bne _A977

        _A942
        lda wJoy1Repeated
        bit #$0800
        bne _A95B
        bit #$0400
        bne _A95F
        rtl


        _A94F
        jml _A983


        _A953
        jml _A9BD


        _A957
        jml _AA10


        _A95B
        jml _AA31


        _A95F
        jml _AAA1


        _A963
        jml _AAF7


        _A967
        jml _AB6E


        _A96B
        jml rlUnitWindowMoveToFirstUnitWrapper


        _A96F
        jml rlUnitWindowMoveToLastUnitWrapper


        _A973
        jml rlUnitWindowMoveToPreviousPageWrapper


        _A977
        jml rlUnitWindowMoveToNextPageWrapper


        _A97B
        jml rlUnitWindowSortSelectionStep


        _A97F
        jml rlUnitWindowStartUnitSwap


        _A983
        lda #$0021
        jsl rlPlaySoundEffect
        jsl rlUnitWindowSaveListOrder
        lda wGameStateStep,b
        sta wUnitWindowPage
        lda wChapterFlags,b
        bit #$0020
        bne _A9AD
        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        lda #$0003
        sta wUnitWindowAction
        rtl


        _A9AD
        sep #$20
        lda #$0E
        sta bBufferINIDISP
        rep #$20
        lda #$0002
        sta wUnitWindowAction
        rtl


        _A9BD
        lda #$000A
        jsl rlPlaySoundEffect
        jsl rlUnitWindowSaveListOrder
        lda wGameStateStep,b
        sta wUnitWindowPage
        jsl rlGetSelectedUnitStates
        bit #UnitStateFielded
        beq _A9F9
        jsl rlGetSelectedUnitDeploymentOffset
        cmp #$0000
        bmi _A9E9
        sta @l wActiveUnitDeploymentOffset
        jsl rlSetMapReturnCenterOnUnit

        _A9E9
        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        lda #$0003
        sta wUnitWindowAction
        rtl


        _A9F9
        jsl rlGetSelectedUnitDeploymentOffset
        sta wActiveUnitDeploymentOffset,b
        sep #$20
        lda #$0E
        sta bBufferINIDISP
        rep #$20
        lda #$0002
        sta wUnitWindowAction
        rtl


        _AA10
        lda #$0008
        jsl rlPlaySoundEffect
        jsl rlUnitWindowSaveListOrder
        lda wGameStateStep,b
        sta wUnitWindowPage
        lda #$0000
        sta wStatusScreenReopenMode
        lda #$0004
        sta wUnitWindowAction
        rtl


        _AA31
        lda wUnitWindowCurrentLine
        cmp #$0001
        beq _AA4B
        lda wUnitWindowCurrentHighlightLine
        cmp #$0000
        beq _AA47
        jml _AA67


        _AA47
        jml _AA84


        _AA4B
        lda wJoy1New
        bit #$0800
        beq _AA66
        lda wUnitWindowUnitSwapStep
        bne _AA66
        lda #$0001
        sta wUnitWindowSortTypeFlag
        lda #$0006
        jsl rlPlaySoundEffect

        _AA66
        rtl


        _AA67
        lda #$FFFF
        sta wUnitWindowScrollingFlag
        lda #$0000
        sta wUnitWindowLastScrolledFlag
        sta wUnitWindowScrollingStep
        lda #$0006
        jsl rlPlaySoundEffect
        jml _AAF7


        _AA84
        lda #$0001
        sta wUnitWindowScrollingFlag
        lda #$0000
        sta $7F82D7
        sta wUnitWindowScrollingStep
        lda #$0006
        jsl rlPlaySoundEffect
        jml _AB6E


        _AAA1
        lda wUnitWindowCurrentLine
        cmp wUnitWindowMaxRows
        beq _AABC
        lda wUnitWindowCurrentHighlightLine
        cmp #$0009
        beq _AAB8
        jml _AABD


        _AAB8
        jml _AADA


        _AABC
        rtl


        _AABD
        lda #$FFFF
        sta wUnitWindowScrollingFlag
        sta wUnitWindowLastScrolledFlag
        lda #$0000
        sta wUnitWindowScrollingStep
        lda #$0006
        jsl rlPlaySoundEffect
        jml _AAF7


        _AADA
        lda #$0001
        sta wUnitWindowScrollingFlag
        sta $7F82D7
        lda #$0000
        sta wUnitWindowScrollingStep
        lda #$0006
        jsl rlPlaySoundEffect
        jml _AB6E


        _AAF7
        lda wUnitWindowLastScrolledFlag
        bne _AB37
        lda wUnitWindowCursorYCoordinate
        sec
        sbc #$0008
        sta wUnitWindowCursorYCoordinate
        lda wUnitWindowScrollingStep
        clc
        adc #$0001
        sta wUnitWindowScrollingStep
        cmp #$0002
        bne _AB6D
        lda #$0000
        sta wUnitWindowScrollingFlag
        lda wUnitWindowCurrentHighlightLine
        dec a
        sta wUnitWindowCurrentHighlightLine
        lda wUnitWindowCurrentLine
        dec a
        sta wUnitWindowCurrentLine
        jml _AB6D


        _AB37
        lda wUnitWindowCursorYCoordinate
        clc
        adc #$0008
        sta wUnitWindowCursorYCoordinate
        lda wUnitWindowScrollingStep
        clc
        adc #$0001
        sta wUnitWindowScrollingStep
        cmp #$0002
        bne _AB6D
        lda #$0000
        sta wUnitWindowScrollingFlag
        lda wUnitWindowCurrentHighlightLine
        inc a
        sta wUnitWindowCurrentHighlightLine
        lda wUnitWindowCurrentLine
        inc a
        sta wUnitWindowCurrentLine

        _AB6D
        rtl


        _AB6E
        lda $7F82D7
        bne _ABAE
        lda wUnitWindowScrollPixels
        sec
        sbc #$0008
        sta wUnitWindowScrollPixels
        lda wUnitWindowScrollingStep
        clc
        adc #$0001
        sta wUnitWindowScrollingStep
        cmp #$0002
        bne _ABE4
        lda #$0000
        sta wUnitWindowScrollingFlag
        lda wUnitWindowScrolledLines
        dec a
        sta wUnitWindowScrolledLines
        lda wUnitWindowCurrentLine
        dec a
        sta wUnitWindowCurrentLine
        jml _ABE4


        _ABAE
        lda wUnitWindowScrollPixels
        clc
        adc #$0008
        sta wUnitWindowScrollPixels
        lda wUnitWindowScrollingStep
        clc
        adc #$0001
        sta wUnitWindowScrollingStep
        cmp #$0002
        bne _ABE4
        lda #$0000
        sta wUnitWindowScrollingFlag
        lda wUnitWindowScrolledLines
        inc a
        sta wUnitWindowScrolledLines
        lda wUnitWindowCurrentLine
        inc a
        sta wUnitWindowCurrentLine

        _ABE4
        rtl

        .databank 0

        ; 8B/ABE5

      rlUnitWindowMoveToFirstUnitWrapper ; 8B/ABE5

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnitWindowMoveToFirstUnit
        rtl

        .databank 0

        ; 8B/ABE9

      rlUnitWindowMoveToPreviousPageWrapper ; 8B/ABE9

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnitWindowMoveToPreviousPage
        rtl

        .databank 0

        ; 8B/ABED

      rlUnitWindowMoveToLastUnitWrapper ; 8B/ABED

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnitWindowMoveToLastUnit
        rtl

        .databank 0

        ; 8B/ABF1

      rlUnitWindowMoveToNextPageWrapper ; 8B/ABF1

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnitWindowMoveToNextPage
        rtl

        .databank 0

        ; 8B/ABF5

      rlUnitWindowSortSelectionStep ; 8B/ABF5

        .al
        .xl
        .autsiz
        .databank ?

        ; One frame of picking a sort: input, then the sprites.

        jsr rsUnitWindowHandleSortSelection
        jsr rsUnitWindowRenderSprites
        rtl

        .databank 0

        ; 8B/ABFC

      rlUnitWindowStartUnitSwap ; 8B/ABFC

        .al
        .xl
        .autsiz
        .databank ?

        ; Y: remembers the selected line and its cursor position as the first unit of a swap.

        lda #$0001
        sta wUnitWindowUnitSwapStep
        lda wUnitWindowCursorYCoordinate
        clc
        adc wUnitWindowScrollPixels
        sta wUnitWindowUnitSwapStartCursorYCoordinate
        lda wUnitWindowCurrentLine
        sta wUnitWindowUnitSwapStartSlot
        lda #$000A
        jsl rlPlaySoundEffect
        rtl

        .databank 0

        ; 8B/AC20

      rlUnitWindowUnitSwapStep ; 8B/AC20

        .al
        .xl
        .autsiz
        .databank ?

        ; One frame of a swap: input (rsUnitWindowHandleUnitSwap), and while the second unit is still being picked, the up and down input of rlUnitWindowHandleInput (a raw jml to $8BA942).

        jsr rsUnitWindowHandleUnitSwap
        lda wUnitWindowUnitSwapStep
        cmp #$0001
        bne _AC30
        jml rlUnitWindowHandleInput._A942


        _AC30
        rtl

        .databank 0

        ; 8B/AC31

      rlUnitWindowCloseToMap ; 8B/AC31

        .al
        .xl
        .autsiz
        .databank ?

        ; Installs rsReturnToMapMainLoop, which restarts game state $12 at the step saved in $0D7B. B uses it, and A on a unit that is on the map after making it the active unit.

        jsl rlRestoreDeploymentMapSprites
        lda #$0000
        sta wUnitWindowCaller
        sta wStatusScreenCaller
        lda #$0001
        sta wMainGameMode,b
        lda #<>rsReturnToMapMainLoop
        sta wMainLoopPointer
        lda #$00E8
        jsl rlQueueSoundCommand
        rtl

        .databank 0

        ; 8B/AC53

      rlUnitWindowCloseWithLocationReload ; 8B/AC53

        .al
        .xl
        .autsiz
        .databank ?

        ; B uses this instead of rlUnitWindowCloseToMap when bit 5 of wChapterFlags is set: loads the event data of faction slot 0's location, builds the dead character list and installs rsOpenCastleScreen. Where that returns to is not known yet.

        jsl rlRestoreDeploymentMapSprites
        lda #$0000
        sta wUnitWindowCaller
        sta wStatusScreenCaller
        jsl rlReturnToCastleScreen
        rtl

        .databank 0

        ; 8B/AC67

      rlUnitWindowOpenSelectedUnitScreen ; 8B/AC67

        .al
        .xl
        .autsiz
        .databank ?

        ; A on a unit that is not on the map: installs rsOpenStatusScreen, which opens a screen run from bank $89 (game states $07 and $08) for the active unit, with $7F8183 set to return to rsUnitWindowOpen.

        jsl rlRestoreDeploymentMapSprites
        lda #$0000
        sta wUnitWindowCaller
        lda #<>rsUnitWindowOpen
        sta wStatusScreenCaller
        lda #<>rsOpenStatusScreen
        sta wMainLoopPointer
        rtl

        .databank 0

        ; 8B/AC7F

    .endsection Unsorted8BA851Section


    .section Unsorted8BAC7FSection

      .al
      .xl

      rsUnitWindowHandlePage0Turn ; 8B/AC7F

        .al
        .xl
        .autsiz
        .databank ?

        ; Entry 0 of the page-turn table: right turns to the next page (page 0 has no page to its left).

        lda wJoy1Input
        bit #$0C00
        bne _AC92
        lda wJoy1Repeated
        bit #$0100
        bne _AC93
        bit #$0200
        bne _ACAC

        _AC92
        rts


        _AC93
        inc wGameStateStep,b
        jsl rlUnitWindowDrawPage
        lda #$FFFF
        sta wUnitWindowPageScrollFlag
        jsr rsUnitWindowRenderItemIcons
        lda #$0007
        jsl rlPlaySoundEffect
        rts


        _ACAC
        rts

        .databank 0

        ; 8B/ACAD

    .endsection Unsorted8BAC7FSection


    .section Unsorted8BADF1Section

      .al
      .xl

      rlUnitWindowDrawPage ; 8B/ADF1

        .al
        .xl
        .autsiz
        .databank ?

        ; Clears the page area and draws the current page (wGameStateStep) from aUnitWindowPageDrawers, then the sort label.

        ldx #$01D4
        lda #$0030
        ldy #$0016
        jsl rlClearTilemapRect
        lda wGameStateStep,b
        cmp #$0006
        bmi _AE08

        _AE06
        bra _AE06


        _AE08
        asl a
        tax
        jsr (aUnitWindowPageDrawers,x)
        jsl rlUnitWindowDrawSortLabel
        rtl

        .databank 0

        ; 8B/AE12

    .endsection Unsorted8BADF1Section


    .section Unsorted8BAE1ESection

      .al
      .xl

      rsUnitWindowDrawPage0 ; 8B/AE1E

        .al
        .xl
        .autsiz
        .databank ?

        ; Entry 0 of aUnitWindowPageDrawers: class, level, experience and HP of each line.

        lda #$0007
        sta wR14
        stz wR15

        _AE25
        lda wR15
        asl a
        tax
        lda aUnitWindowDeploymentSlots,x
        bne _AE33
        jml _AF20


        _AE33
        sta wSelectedUnitDataRAMPointer,b
        lda #$2000
        sta aCurrentTilemapInfo,b
        jsl rlGetSelectedUnitClassNamePointer
        lda wR14
        and #$00FF
        xba
        ora #$000A
        tax
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        jsl rlDrawMenuTextLine
        jsl rlGetSelectedUnitLevel
        tay
        lda wR14
        and #$00FF
        xba
        lsr a
        lsr a
        clc
        adc #$0026
        tax
        lda #$3920
        sta wR5
        lda #$0002
        sta wR6
        tya
        jsl rlDrawMenuTextNumber
        jsl rlGetSelectedUnitExperience
        tay
        lda wR14
        and #$00FF
        xba
        lsr a
        lsr a
        clc
        adc #$002C
        tax
        lda #$3520
        sta wR5
        lda #$0002
        sta wR6
        tya
        pha
        jsl rlDrawMenuTextNumber
        pla
        cmp #$005A
        bmi _AEB6
        lda wR14
        xba
        lsr a
        lsr a
        sta wR0
        lda #$0030
        clc
        adc wR0
        tax
        lda #$3508
        sta $7E83C8,x

        _AEB6
        jsl rlGetSelectedUnitCurrentHP
        tay
        lda wR14
        and #$00FF
        xba
        lsr a
        lsr a
        clc
        adc #$0032
        tax
        lda #$3920
        sta wR5
        lda #$0002
        sta wR6
        tya
        jsl rlDrawMenuTextNumber
        lda #$3400
        sta aCurrentTilemapInfo,b
        lda #(`aUnitWindowHPSlashText)<<8
        sta lR18+1
        lda #<>aUnitWindowHPSlashText
        sta lR18
        lda wR14
        and #$00FF
        xba
        ora #$001B
        tax
        jsl rlDrawMenuTextLine
        jsl rlGetSelectedUnitMaxHP
        tay
        lda wR14
        and #$00FF
        xba
        lsr a
        lsr a
        clc
        adc #$0038
        tax
        lda #$3520
        sta wR5
        lda #$0002
        sta wR6
        tya
        jsl rlDrawMenuTextNumber
        inc wR14
        inc wR14
        inc wR15
        jml _AE25


        _AF20
        jsl rlDMAByStruct

          .structDMAToVRAM gUnitWindowPage0Tilemap, $0140, $80, $B040

        jsl rlDMAByStruct

          .structDMAToVRAM $7E8548, $0C00, $80, $B1C0

        rts

        .databank 0

        ; 8B/AF3B

    .endsection Unsorted8BAE1ESection


    .section Data8BCECASection

      .al
      .xl

      aUnitWindowSkillIconTiles ; 8B/CECA

        ; Read by rlUnitWindowDrawUnitSkills, rsUnitWindowGetSkillsSortScores.

        .word $0000, $0000, $3806, $3800, $3802, $3804, $3844, $0000
        .word $3846, $0000, $0000, $0000, $3808, $0000, $380C, $380E
        .word $3820, $3822, $3824, $3826, $3828, $382A, $382C, $382E
        .word $3840, $3842, $0000, $0000, $3848, $384A, $0000, $0000

        ; 8B/CF0A

    .endsection Data8BCECASection


    .section Table80C3DDSection

      .al
      .xl

      aUnitWindowBG3TilemapEntry ; 80/C3DD
        .byte $20, $40, $00, $00, $00, $00, $88, $83, $7E

    .endsection Table80C3DDSection


    .section TableDD7FB0Section

      .al
      .xl

      aItemIconPalette ; DD/7FB0

        ; The colours of g4bppItemIcons. Copied into a sprite palette by
        ; rlUnitWindowCopySpritePalette1.

        .word $3800, $7BFF, $56D7, $35EF, $0462, $02FB, $000B, $5C40
        .word $6D25, $7E0F, $0140, $1EC5, $10EA, $298F, $0487, $0134

      aUnitWindowSpritePalette2 ; DD/7FD0

        ; Copied into a sprite palette by rlUnitWindowCopySpritePalette2; it
        ; does not colour the item icons properly, so it is for something else.

        .word $3800, $0012, $013A, $02FB, $7E6A, $7504, $0120, $0280
        .word $7FFF, $56D7, $35EF, $08A6, $190A, $256C, $4232, $0842

        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000

        ; DD/8000

    .endsection TableDD7FB0Section

