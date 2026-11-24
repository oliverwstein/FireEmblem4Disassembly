; The depot (steps $07/$08): a unit deposits items from its inventory
; (ItemStateSupply, owned by the unit) and takes them back. Bank $8A.


    .section DepotScreenSetupSection

      .al
      .xl

      rlDepotScreenSetup ; 8A/F0F2

        .al
        .xl
        .autsiz
        .databank ?

        ; Blanks the screen and loads the depot: graphics, keeper portrait, the unit's stored items and inventory, money; moves to step $08.

        phk
        plb
        .databank $8A
        sep #$20
        lda #$80
        sta $2100,b
        sta bBufferINIDISP
        rep #$20
        jsl rlDisableVBlank
        jsl rlResetHDMAEngine
        jsr rsSetKeeperOptionList
        lda #$0000
        sta wR1
        lda #$0000
        sta wR2
        lda #$4000
        sta wR3
        sta wR4
        lda #$6000
        sta wR5
        lda #$2800
        sta wR6
        lda #$2C00
        sta wR7
        lda #$3800
        sta wR8
        jsl rlSetLayerPositionsAndSizes
        jsl rlResetDialogueEngine
        lda #(`aDecompressionDMAEntry8AF26B)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry8AF26B
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        jsl rlDMAByStruct

          .structDMAToVRAM g4bppCursorSprites, $0400, $80, $C000

        jsl rlDMAByStruct

          .structDMAToVRAM g4bppWeaponTypeIcons, $0800, $80, $D600

        lda #(`aDecompressionDMAEntry8AF273)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry8AF273
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        lda #(`aDecompressionDMAEntry8AF27B)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry8AF27B
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        jsl rlDMAByStruct

          .structDMAToVRAM g2bppItemStatLabels, $0800, $80, $9800

        lda #(`aDecompressionDMAEntry8AF263)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry8AF263
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        jsl rlGetDialogueBoxGraphicsAndPalette
        ldx #$0800
        lda #$00FF

        _F1A0
        sta aBG3TilemapBuffer,x
        dec x
        dec x
        bne _F1A0
        ldx #$01FE

        _F1AB
        lda aUnknown8CD800,x
        sta aBGPaletteBuffer,b,x
        dec x
        dec x
        bpl _F1AB
        lda #$0001
        jsl rlUnitWindowCopySpritePalette1
        lda #$0002
        jsl rlUnitWindowCopySpritePalette2
        lda #$00B2
        jsl rlLoadKeeperPortraitData
        jsl rlCastleFillVRAM2000
        sep #$20
        lda #$17
        sta bBufferTM
        lda #$00
        sta bBufferTS
        lda #$00
        sta bBufferCGWSEL
        lda #$00
        sta bBufferCGADSUB
        lda #$03
        ora #$20
        sta bBufferCOLDATA_1
        lda #$03
        ora #$40
        sta bBufferCOLDATA_2
        lda #$03
        ora #$80
        sta bBufferCOLDATA_3
        rep #$20
        stz wMenuState,b
        stz wCastleMenuOptionIndex,b
        stz wCastleConfirmCursorIndex,b
        stz wCastleListWindowRow,b
        stz wCastleListSelectedIndex,b
        jsl rlBuildUnitStoredItemList
        jsr rsCastleDrawListItemIcons
        lda #(`aCastleMenuTilemapData)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aCastleMenuTilemapData
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$2000
        sta aCurrentTilemapInfo,b
        jsr rsClearCastleList
        jsr rsDrawInventoryWithSellPrices
        jsr rsClearItemDetailsWindow
        jsr rsDrawCastleUnitMoney
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0700, $80, $7000

        lda #(`aUnknown8AB230)<<8
        sta lR44+1
        lda #<>aUnknown8AB230
        sta lR44
        jsl rlHDMAEngineCreateEntry
        lda #CASTLE_STEP_DEPOT
        sta wGameStateStep,b
        rep #$20
        jsl rlEnableVBlank
        sep #$20
        lda #$00
        sta bBufferINIDISP
        rep #$20
        rtl

        .databank 0

        ; 8A/F259

      aUnknown8AF259 ; 8A/F259

        ; Unreferenced.

        .word $0000, $001A, $0017, $001C, $001A

    .endsection DepotScreenSetupSection


    .section Unsorted8AF283Section

      .al
      .xl

      rlDepotScreenStep ; 8A/F283

        .al
        .xl
        .autsiz
        .databank ?

        ; Runs depot sub-state wMenuState (aDepotStepHandlers), then redraws the list sprites, money and the keeper's portrait.

        phb
        php
        phk
        plb
        .databank $8A
        lda wMenuState,b
        asl a
        tax
        jsr (aDepotStepHandlers,x)
        lda wCastleRedrawIcons
        bne _F2A4
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0700, $80, $7000

        bra _F2AE


        _F2A4
        lda #$0000
        sta wCastleRedrawIcons
        jsr rsCastleDrawListItemIcons

        _F2AE
        jsr rsPushCastleListSprites
        jsr rsDrawCastleUnitMoney
        lda #$0008
        sta wR0
        lda #$0008
        sta wR1
        ldx #$0000
        jsr rsPushKeeperPortraitSprites
        plp
        plb
        .databank $8A
        rtl

        .databank 0

        ; 8A/F2C7

    .endsection Unsorted8AF283Section


    .section Table8AF2C7Section

      .al
      .xl

      aDepotStepHandlers ; 8A/F2C7

        ; Jump table of rlDepotScreenStep.
        .word <>rsDepotGreet
        .word <>rsDepotWaitForText
        .word <>rsDepotChooseOption
        .word <>rsDepotOpenWithdrawList
        .word <>rsDepotWithdrawListInput
        .word <>rsDepotConfirmWithdraw
        .word <>rsDepotAfterWithdraw
        .word <>rsDepotLeaveWithdrawList
        .word <>rsDepotOpenDepositList
        .word <>rsDepotDepositListInput
        .word <>rsDepotConfirmDeposit
        .word <>rsDepotAfterDeposit
        .word <>rsDepotLeave

    .endsection Table8AF2C7Section


    .section Unsorted8AF2E1Section

      .al
      .xl

      rsDepotGreet ; 8A/F2E1

        .al
        .xl
        .autsiz
        .databank ?

        ; Sub-state $00.

        lda #$0009
        tax
        lda aShopDialoguePointers+1,x
        sta lR18+1
        lda aShopDialoguePointers,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsSetupKeeperDialogueBox
        lda #$0001
        sta wMenuState,b
        lda #$0002
        sta wNextMenuState,b
        sep #$20
        lda #$0F
        sta bBufferINIDISP
        rep #$20
        rts

        .databank 0

        ; 8A/F313

      rsDepotWaitForText ; 8A/F313

        .al
        .xl
        .autsiz
        .databank ?

        ; Sub-state $01.

        lda wNextMenuState,b
        cmp #$0005
        beq _F33B
        cmp #$000A
        beq _F340

        _F320
        lda aDialogue.wStatus,b
        beq _F334
        lda #$00E8
        sta wR0
        lda #$0036
        sta wR1
        jsl rlDisplayDialogueAPressArrows
        rts


        _F334
        lda wNextMenuState,b
        sta wMenuState,b
        rts


        _F33B
        jsr rsPushStockItemTypeIcon
        bra _F343


        _F340
        jsr rsPushInventoryItemTypeIcon

        _F343
        lda wCastleListWindowRow,b
        tax
        lda #$004C
        sta wR0
        lda aCastleListRowY,x
        and #$00FF
        clc
        adc #$0004
        sta wR1
        lda #$0000
        jsl rlPushCastleHandCursor
        bra _F320

        .databank 0

        ; 8A/F362

      rsDepotChooseOption ; 8A/F362

        .al
        .xl
        .autsiz
        .databank ?

        ; Sub-state $02: deposit (needs an item in the inventory) or withdraw (needs a stored item).

        lda #(`aCastleMenuTilemapData)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aCastleMenuTilemapData
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda #(`aDepotOptionsText)<<8
        sta lR18+1
        lda #<>aDepotOptionsText
        sta lR18
        lda $18DD,b
        cmp #$0100
        beq _F38C
        clc
        adc #$0120
        bra _F390


        _F38C
        sec
        sbc #$0040

        _F390
        clc
        adc #$000B
        tax
        jsl rlDrawMenuTextLine
        stz wCastleListWindowRow,b
        stz wCastleListSelectedIndex,b
        lda #(`aDepotOptionX)<<8
        sta lR19+1
        lda #<>aDepotOptionX
        sta lR19
        lda #(`aDepotOptions)<<8
        sta lR20+1
        lda #<>aDepotOptions
        sta lR20
        lda #$0002
        jsr rsCastleOptionMenuInput
        lda #$0000
        jsl rlPushCastleHandCursor
        lda wJoy1New
        cmp #$8000
        beq _F3DE
        cmp #$0080
        bne _F3DD
        lda #$0009
        tax
        lda wCastleMenuOptionIndex,b
        cmp #$0000
        beq _F40F
        cmp #$0001
        beq _F425

        _F3DD
        rts


        _F3DE
        lda #$0009
        tax
        lda aShopDialoguePointers+55,x
        sta lR18+1
        lda aShopDialoguePointers+54,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsSetupKeeperDialogueBox
        lda #$0001
        sta wMenuState,b
        lda #$000C
        sta wNextMenuState,b
        lda #$0021
        jsl rlPlaySoundEffect
        rts


        _F40F
        lda wCastleListSubCount,b
        beq _F459
        lda aShopDialoguePointers+163,x
        sta lR18+1
        lda aShopDialoguePointers+162,x
        sta lR18
        lda #$0008
        bra _F43B


        _F425
        lda wCastleListItemCount,b
        beq _F467
        lda aShopDialoguePointers+73,x
        sta lR18+1
        lda aShopDialoguePointers+72,x
        sta lR18
        lda #$0003
        bra _F43B


        _F43B
        sta wNextMenuState,b
        lda #$0001
        sta wMenuState,b
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsSetupKeeperDialogueBox
        lda #$000A
        jsl rlPlaySoundEffect
        rts


        _F459
        lda #(`dialogueShopUnknown8AD418)<<8
        sta lR18+1
        lda #<>dialogueShopUnknown8AD418
        sta lR18
        jml rsShopSayAndStay


        _F467
        lda #(`dialogueShopUnknown8AD46F)<<8
        sta lR18+1
        lda #<>dialogueShopUnknown8AD46F
        sta lR18
        jml rsShopSayAndStay

        .databank 0

        ; 8A/F475

    .endsection Unsorted8AF2E1Section


    .section Table8AF475Section

      .al
      .xl

      aDepotOptionsText ; 8A/F475

        .enc "SJIS"
        .text "あずける　　ひきだす　　　　　　　　　　　"
        .word $0000
        .enc "none"


    .endsection Table8AF475Section


    .section Unsorted8AF4A1Section

      .al
      .xl

      rsDepotOpenWithdrawList ; 8A/F4A1

        .al
        .xl
        .autsiz
        .databank ?

        lda #$FFFF
        sta wCastleRedrawIcons
        jsr rsDrawStockItemDetails
        jsr rsPushStockItemTypeIcon
        jsr rsDrawStockList
        lda #$0004
        sta wMenuState,b
        rts

        .databank 0

        ; 8A/F4B8

    .endsection Unsorted8AF4A1Section


    .section Unsorted8AF4B8Section

      .al
      .xl

      rsDepotWithdrawListInput ; 8A/F4B8

        .al
        .xl
        .autsiz
        .databank ?

        ; Sub-state $04.

        jsr rsPushStockItemTypeIcon
        lda wCastleListWindowRow,b
        tax
        lda #$004C
        sta wR0
        lda aCastleListRowY,x
        and #$00FF
        clc
        adc #$0004
        sta wR1
        lda #$0000
        jsl rlPushCastleHandCursor
        jsl rlPushStockListScrollArrows
        jsr rsCastleStockListInput
        lda wJoy1New
        cmp #$0080
        beq _F4EC
        cmp #$8000
        beq _F522

        _F4EB
        rts


        _F4EC
        lda wCastleListItemCount,b
        beq _F4EB
        lda #$000A
        jsl rlPlaySoundEffect
        lda #$0009
        tax
        lda aShopDialoguePointers+88,x
        sta lR18+1
        lda aShopDialoguePointers+87,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsSetupKeeperDialogueBox
        lda #$0001
        sta wMenuState,b
        lda #$0005
        sta wNextMenuState,b
        rts


        _F522
        lda #$0021
        jsl rlPlaySoundEffect
        lda #$0009
        tax
        lda aShopDialoguePointers+37,x
        sta lR18+1
        lda aShopDialoguePointers+36,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsSetupKeeperDialogueBox
        lda #$0001
        sta wMenuState,b
        lda #$0002
        sta wNextMenuState,b
        jsr rsClearItemDetailsWindow
        rts

        .databank 0

        ; 8A/F556

    .endsection Unsorted8AF4B8Section


    .section Unsorted8AF556Section

      .al
      .xl

      rsDepotConfirmWithdraw ; 8A/F556

        .al
        .xl
        .autsiz
        .databank ?

        ; Sub-state $05: yes gives the stored item back to the unit, unless its inventory is full.

        lda #$2000
        sta aCurrentTilemapInfo,b
        jsr rsPushStockItemTypeIcon
        lda wCastleListWindowRow,b
        tax
        lda #$004C
        sta wR0
        lda aCastleListRowY,x
        and #$00FF
        clc
        adc #$0004
        sta wR1
        lda #$0001
        jsl rlPushCastleHandCursor
        jsr rsDrawYesNo
        jsr rsCastleYesNoInput
        lda #$0000
        jsl rlPushCastleHandCursor
        lda wJoy1New
        cmp #$8000
        beq _F5A3
        cmp #$0080
        bne _F5A2
        lda wCastleConfirmCursorIndex,b
        cmp #$0000
        beq _F5B7
        cmp #$0001
        beq _F5A3

        _F5A2
        rts


        _F5A3
        lda #$0021
        jsl rlPlaySoundEffect
        stz wCastleConfirmCursorIndex,b
        lda #$0006
        sta wMenuState,b
        jsr rsClearItemDetailsWindow
        rts


        _F5B7
        ldy #$0000
        stz wTempVariable1,b

        _F5BD
        tya
        clc
        adc #$0001
        jsl rlGetItemROMDataByInventorySlot
        lda wCurrentItemDataROMPointer,b
        beq _F5D4
        inc wTempVariable1,b
        inc y
        cpy #$0007
        bcc _F5BD

        _F5D4
        lda wTempVariable1,b
        cmp #$0007
        beq _F600
        lda wCastleListSelectedIndex,b
        asl a
        tax
        lda aCastleListItemIndices,x
        sta wRoutineVariable1,b
        jsl rlGiveItemToUnitCheckEncumbered
        lda #$000A
        jsl rlPlaySoundEffect
        stz wCastleConfirmCursorIndex,b
        lda #$0006
        sta wMenuState,b
        jsr rsClearItemDetailsWindow
        rts


        _F600
        lda #$0021
        jsl rlPlaySoundEffect
        lda #$0009
        tax
        lda aShopDialoguePointers+133,x
        sta lR18+1
        lda aShopDialoguePointers+132,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsSetupKeeperDialogueBox
        lda #$0001
        sta wMenuState,b
        lda #$0007
        sta wNextMenuState,b
        jsr rsClearItemDetailsWindow
        rts

        .databank 0

        ; 8A/F634

    .endsection Unsorted8AF556Section


    .section Unsorted8AF634Section

      .al
      .xl

      rsDepotAfterWithdraw ; 8A/F634

        .al
        .xl
        .autsiz
        .databank ?

        ; Sub-state $06.

        jsl rlBuildUnitStoredItemList
        jsr rsDrawStockList
        lda #$FFFF
        sta wCastleRedrawIcons
        stz wCastleListWindowRow,b
        stz wCastleListSelectedIndex,b
        lda wCastleListItemCount,b
        beq _F677
        lda #$0009
        tax
        lda aShopDialoguePointers+103,x
        sta lR18+1
        lda aShopDialoguePointers+102,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsSetupKeeperDialogueBox
        lda #$0001
        sta wMenuState,b
        lda #$0003
        sta wNextMenuState,b
        rts


        _F677
        lda #$0009
        tax
        lda aShopDialoguePointers+37,x
        sta lR18+1
        lda aShopDialoguePointers+36,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsSetupKeeperDialogueBox
        lda #$0001
        sta wMenuState,b
        lda #$0002
        sta wNextMenuState,b
        rts

        .databank 0

        ; 8A/F6A1

    .endsection Unsorted8AF634Section


    .section Unsorted8AF6A1Section

      .al
      .xl

      rsDepotLeaveWithdrawList ; 8A/F6A1

        .al
        .xl
        .autsiz
        .databank ?

        ; Sub-state $07.

        stz wCastleConfirmCursorIndex,b
        lda #$0021
        jsl rlPlaySoundEffect
        lda #$0009
        tax
        lda aShopDialoguePointers+37,x
        sta lR18+1
        lda aShopDialoguePointers+36,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsSetupKeeperDialogueBox
        lda #$0001
        sta wMenuState,b
        lda #$0002
        sta wNextMenuState,b
        rts

        .databank 0

        ; 8A/F6D5

    .endsection Unsorted8AF6A1Section


    .section Unsorted8AF6D5Section

      .al
      .xl

      rsDepotOpenDepositList ; 8A/F6D5

        .al
        .xl
        .autsiz
        .databank ?

        lda #$FFFF
        sta wCastleRedrawIcons
        jsr rlDrawInventoryItemDetails
        jsr rsPushInventoryItemTypeIcon
        jsr rsDrawInventoryWithSellPrices
        lda #$0009
        sta wMenuState,b
        rts

        .databank 0

        ; 8A/F6EC

    .endsection Unsorted8AF6D5Section


    .section Unsorted8AF6ECSection

      .al
      .xl

      rsDepotDepositListInput ; 8A/F6EC

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsPushInventoryItemTypeIcon
        lda wCastleListWindowRow,b
        tax
        lda #$004C
        sta wR0
        lda aCastleListRowY,x
        and #$00FF
        clc
        adc #$0004
        sta wR1
        lda #$0000
        jsl rlPushCastleHandCursor
        jsr rsCastleInventoryListInput
        lda wJoy1New
        cmp #$0080
        beq _F71C
        cmp #$8000
        beq _F75D

        _F71B
        rts


        _F71C
        lda wCastleListSelectedIndex,b
        inc a
        sta wRoutineVariable1,b
        jsl rlGetItemROMDataByInventorySlot
        lda wCurrentItemDataROMPointer,b
        beq _F71B
        lda #$000A
        jsl rlPlaySoundEffect
        lda #$0009
        tax
        lda aShopDialoguePointers+178,x
        sta lR18+1
        lda aShopDialoguePointers+177,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsSetupKeeperDialogueBox
        lda #$0001
        sta wMenuState,b
        lda #$000A
        sta wNextMenuState,b
        rts


        _F75D
        lda #$0021
        jsl rlPlaySoundEffect
        lda #$0009
        tax
        lda aShopDialoguePointers+37,x
        sta lR18+1
        lda aShopDialoguePointers+36,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsSetupKeeperDialogueBox
        lda #$0001
        sta wMenuState,b
        lda #$0002
        sta wNextMenuState,b
        jsr rsClearItemDetailsWindow
        rts

        .databank 0

        ; 8A/F791

    .endsection Unsorted8AF6ECSection


    .section Unsorted8AF791Section

      .al
      .xl

      rsDepotConfirmDeposit ; 8A/F791

        .al
        .xl
        .autsiz
        .databank ?

        ; Sub-state $0A: yes stores the item (rlSendInventorySlotItemToSupply).

        jsr rsPushInventoryItemTypeIcon
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda wCastleListWindowRow,b
        tax
        lda #$004C
        sta wR0
        lda aCastleListRowY,x
        and #$00FF
        clc
        adc #$0004
        sta wR1
        lda #$0001
        jsl rlPushCastleHandCursor
        jsr rsDrawYesNo
        jsr rsCastleYesNoInput
        lda #$0000
        jsl rlPushCastleHandCursor
        lda wJoy1New
        cmp #$8000
        beq _F804
        cmp #$0080
        bne _F7DD
        lda wCastleConfirmCursorIndex,b
        cmp #$0000
        beq _F7DE
        cmp #$0001
        beq _F804

        _F7DD
        rts


        _F7DE
        jsl rlSendInventorySlotItemToSupply
        jsl rlBuildUnitStoredItemList
        jsr rsDrawInventoryWithSellPrices
        lda #$FFFF
        sta wCastleRedrawIcons
        lda #$000A
        jsl rlPlaySoundEffect
        stz wCastleConfirmCursorIndex,b
        lda #$000B
        sta wMenuState,b
        jsr rsClearItemDetailsWindow
        rts


        _F804
        lda #$0021
        jsl rlPlaySoundEffect
        stz wCastleConfirmCursorIndex,b
        lda #$000B
        sta wMenuState,b
        jsr rsClearItemDetailsWindow
        rts

        .databank 0

        ; 8A/F818

    .endsection Unsorted8AF791Section


    .section Unsorted8AF818Section

      .al
      .xl

      rsDepotAfterDeposit ; 8A/F818

        .al
        .xl
        .autsiz
        .databank ?

        ; Sub-state $0B.

        stz wCastleListWindowRow,b
        stz wCastleListSelectedIndex,b
        lda wCastleListSubCount,b
        beq _F84D
        lda #$0009
        tax
        lda aShopDialoguePointers+193,x
        sta lR18+1
        lda aShopDialoguePointers+192,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsSetupKeeperDialogueBox
        lda #$0001
        sta wMenuState,b
        lda #$0008
        sta wNextMenuState,b
        rts


        _F84D
        lda wKeeper
        clc
        adc wKeeper
        clc
        adc wKeeper
        tax
        lda aShopDialoguePointers+37,x
        sta lR18+1
        lda aShopDialoguePointers+36,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsSetupKeeperDialogueBox
        lda #$0001
        sta wMenuState,b
        lda #$0002
        sta wNextMenuState,b
        jsr rsDrawInventoryWithSellPrices
        rts

        .databank 0

        ; 8A/F885

    .endsection Unsorted8AF818Section


    .section Unsorted8AF885Section

      .al
      .xl

      rsDepotLeave ; 8A/F885

        .al
        .xl
        .autsiz
        .databank ?

        ; Sub-state $0C: blanks the screen and returns to the town (step $12).

        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        lda #CASTLE_STEP_REOPEN_TOWN_SAME_SONG
        sta wGameStateStep,b
        rts

        .databank 0

        ; 8A/F894

    .endsection Unsorted8AF885Section
