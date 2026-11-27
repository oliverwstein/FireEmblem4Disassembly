; The shop screen (steps $0D/$0E), shared by the item shop, the secondhand shop
; and the repair shop; keeper wKeeper chooses the options and lines
; (aShopDialoguePointers). Buying halves the price with Bargain; a sold item goes
; into the castle's secondhand stock. Banks $87 and $8A.


    .section CheckUnitHasBargainSection

      .al
      .xl

      rlCheckUnitHasBargain ; 87/A18C

        .al
        .xl
        .autsiz
        .databank ?

        ; Carry set if the unit, its class or an item it holds has Bargain.

        lda #SkillIDBargain
        jsl rlCheckIfUnitHasSpecifiedPersonalOrClassSkill
        bcs _A19C
        lda #SkillIDBargain
        jsl rlCheckIfInventoryItemsHaveSpecifiedSkill

        _A19C
        rtl

        .databank 0

        ; 87/A19D

    .endsection CheckUnitHasBargainSection


    .section ShopScreenSetupSection

      .al
      .xl

      rlShopScreenSetup ; 8A/BCF8

        .al
        .xl
        .autsiz
        .databank ?

        ; Blanks the screen and loads the shop: graphics, the keeper's background and portrait, the unit's inventory count, the stock list and money; moves to step $0E.

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
        jsl rlDMAByStruct

          .structDMAToVRAM g4bppCursorSprites, $0400, $80, $C000

        jsl rlDMAByStruct

          .structDMAToVRAM g4bppWeaponTypeIcons, $0800, $80, $D600

        lda #(`aDecompressionDMAEntry8ABE53)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry8ABE53
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        lda #(`aDecompressionDMAEntry8ABE5B)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry8ABE5B
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        jsl rlDMAByStruct

          .structDMAToVRAM g2bppItemStatLabels, $0800, $80, $9800

        lda #(`aDecompressionDMAEntry8ABE4B)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry8ABE4B
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        jsl rlGetDialogueBoxGraphicsAndPalette
        jsr rsLoadShopBackground
        ldx #$0800
        lda #$00FF

        _BD9B
        sta aBG3TilemapBuffer,x
        dec x
        dec x
        bne _BD9B
        lda #$0001
        jsl rlUnitWindowCopySpritePalette1
        lda #$0002
        jsl rlUnitWindowCopySpritePalette2
        jsr rsLoadKeeperPortrait
        ldy #$0000
        stz wCastleListSubCount,b

        _BDBA
        tya
        clc
        adc #$0001
        jsl rlGetItemROMDataByInventorySlot
        lda wCurrentItemDataROMPointer,b
        beq _BDD1
        inc wCastleListSubCount,b
        inc y
        cpy #$0007
        bcc _BDBA

        _BDD1
        sep #$20
        lda #$17
        sta bBufferTM
        lda #$00
        sta bBufferTS
        lda #$00
        sta bBufferCGWSEL
        lda #$00
        sta bBufferCGADSUB
        rep #$20
        stz wMenuState,b
        stz wCastleMenuOptionIndex,b
        stz wCastleConfirmCursorIndex,b
        stz wCastleListWindowRow,b
        stz wCastleListSelectedIndex,b
        jsl rlBuildStockList
        jsr rsCastleDrawListItemIcons
        lda #(`aCastleMenuTilemapData)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aCastleMenuTilemapData
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$2000
        sta aCurrentTilemapInfo,b
        jsr rsClearCastleList
        jsr rsDrawShopStartList
        jsr rsClearItemDetailsWindow
        jsr rsDrawCastleUnitMoney
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0700, $80, $7000

        lda #(`aCastleColorMathHDMAInfo)<<8
        sta lR44+1
        lda #<>aCastleColorMathHDMAInfo
        sta lR44
        jsl rlHDMAEngineCreateEntry
        lda #CASTLE_STEP_SHOP
        sta wGameStateStep,b
        rep #$20
        jsl rlEnableVBlank
        sep #$20
        lda #$00
        sta bBufferINIDISP
        rep #$20
        rtl

        .databank 0

        ; 8A/BE49

        ; Unused: 2 zero bytes.
        .fill 2, $00


      ; Entries for rlHandleMapMenuDecompressionDMA.
      aDecompressionDMAEntry8ABE4B .structDecompressionDMAEntry gcHiraganaFont, $1800, $4000 ; 8A/BE4B
      aDecompressionDMAEntry8ABE53 .structDecompressionDMAEntry acCastleShopAndArenaBG1Tilemap, $0800, $2800 ; 8A/BE53
      aDecompressionDMAEntry8ABE5B .structDecompressionDMAEntry acCastleFacilityBG2Tilemap, $0800, $2C00 ; 8A/BE5B

    .endsection ShopScreenSetupSection


    .section LoadShopBackgroundSection

      .al
      .xl

      rsLoadShopBackground ; 8A/BE63

        .al
        .xl
        .autsiz
        .databank ?

        ; Loads the background and palette for keeper wKeeper (0 item shop, 1 secondhand shop, 2 repair shop).

        lda wKeeper
        cmp #KEEPER_ITEM_SHOP
        beq _BE76
        cmp #KEEPER_SECONDHAND_SHOP
        beq _BEA9
        cmp #KEEPER_REPAIR_SHOP
        beq _BEDC

        _BE76
        lda #(`aDecompressionDMAEntry8ABF0F)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry8ABF0F
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        ldx #$01FE

        _BE87
        lda aCastleShopBGPalettes,x
        sta aBGPaletteBuffer,b,x
        dec x
        dec x
        bpl _BE87
        sep #$20
        lda #$04
        ora #$20
        sta bBufferCOLDATA_1
        lda #$04
        ora #$40
        sta bBufferCOLDATA_2
        lda #$04
        ora #$80
        sta bBufferCOLDATA_3
        rep #$20
        rts


        _BEA9
        lda #(`aDecompressionDMAEntry8ABF17)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry8ABF17
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        ldx #$01FE

        _BEBA
        lda aCastleSecondhandShopBGPalettes,x
        sta aBGPaletteBuffer,b,x
        dec x
        dec x
        bpl _BEBA
        sep #$20
        lda #$02
        ora #$20
        sta bBufferCOLDATA_1
        lda #$02
        ora #$40
        sta bBufferCOLDATA_2
        lda #$02
        ora #$80
        sta bBufferCOLDATA_3
        rep #$20
        rts


        _BEDC
        lda #(`aDecompressionDMAEntry8ABF1F)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry8ABF1F
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        ldx #$01FE

        _BEED
        lda aCastleRepairShopBGPalettes,x
        sta aBGPaletteBuffer,b,x
        dec x
        dec x
        bpl _BEED
        sep #$20
        lda #$06
        ora #$20
        sta bBufferCOLDATA_1
        lda #$03
        ora #$40
        sta bBufferCOLDATA_2
        lda #$02
        ora #$80
        sta bBufferCOLDATA_3
        rep #$20
        rts

        .databank 0

        ; 8A/BF0F


      ; Entries for rlHandleMapMenuDecompressionDMA.
      aDecompressionDMAEntry8ABF0F .structDecompressionDMAEntry g4bppcCastleArmoryBGTiles, $1000, $0000 ; 8A/BF0F
      aDecompressionDMAEntry8ABF17 .structDecompressionDMAEntry g4bppcCastleRepairShopBGTiles, $1000, $0000 ; 8A/BF17
      aDecompressionDMAEntry8ABF1F .structDecompressionDMAEntry g4bppcCastlePawnShopBGTiles, $1000, $0000 ; 8A/BF1F

    .endsection LoadShopBackgroundSection


    .section SetKeeperOptionListSection

      .al
      .xl

      rsSetKeeperOptionList ; 8A/BF27

        .al
        .xl
        .autsiz
        .databank ?

        ; Points lKeeperOptionList at keeper wKeeper's option list (aItemShopOptions and the lists after it).

        lda wKeeper
        beq _BF50
        cmp #KEEPER_SECONDHAND_SHOP
        beq _BF60
        cmp #KEEPER_REPAIR_SHOP
        beq _BF70
        cmp #KEEPER_DEPOT
        beq _BF80
        cmp #$0004
        beq _BF90
        cmp #KEEPER_CLASS_CHANGE
        beq _BFA0
        cmp #$0006
        beq _BFB0
        cmp #KEEPER_ARENA
        beq _BFC0

        _BF50
        lda #(`aItemShopOptions)<<8
        sta lKeeperOptionList+1
        lda #<>aItemShopOptions
        sta lKeeperOptionList
        bra _BFD0


        _BF60
        lda #(`aSecondhandShopOptions)<<8
        sta lKeeperOptionList+1
        lda #<>aSecondhandShopOptions
        sta lKeeperOptionList
        bra _BFD0


        _BF70
        lda #(`aSecondhandShopOptions)<<8
        sta lKeeperOptionList+1
        lda #<>(aSecondhandShopOptions + 5)
        sta lKeeperOptionList
        bra _BFD0


        _BF80
        lda #(`aDepotOptions)<<8
        sta lKeeperOptionList+1
        lda #<>aDepotOptions
        sta lKeeperOptionList
        bra _BFD0


        _BF90
        lda #(`aDepotOptions)<<8
        sta lKeeperOptionList+1
        lda #<>(aDepotOptions + 2)
        sta lKeeperOptionList
        bra _BFD0


        _BFA0
        lda #(`aDepotOptions)<<8
        sta lKeeperOptionList+1
        lda #<>(aDepotOptions + 3)
        sta lKeeperOptionList
        bra _BFD0


        _BFB0
        lda #(`aDepotOptions)<<8
        sta lKeeperOptionList+1
        lda #<>(aDepotOptions + 4)
        sta lKeeperOptionList
        bra _BFD0


        _BFC0
        lda #(`aArenaOptions)<<8
        sta lKeeperOptionList+1
        lda #<>aArenaOptions
        sta lKeeperOptionList
        bra _BFD0


        _BFD0
        rts

        .databank 0

        ; 8A/BFD1

      rsLoadKeeperPortrait ; 8A/BFD1

        .al
        .xl
        .autsiz
        .databank ?

        ; Loads the portrait for keeper wKeeper (aKeeperPortraits).

        lda wSelectedUnitDataRAMPointer,b
        pha
        lda #$FFFF
        sta $7F8084
        lda wKeeper
        asl a
        tax
        lda aKeeperPortraits,x
        jsl rlLoadKeeperPortraitData
        jsl rlCastleFillVRAM2000
        pla
        sta wSelectedUnitDataRAMPointer,b
        rts

        .databank 0

        ; 8A/BFF3

    .endsection SetKeeperOptionListSection


    .section Data8ABFF3Section

      .al
      .xl

      aKeeperPortraits ; 8A/BFF3

        ; Read by rsLoadKeeperPortrait.

        .word $00A9, $00B1, $00AB, $00B2, $00F4, $00F4, $00F4, $00AD

        ; 8A/C003

    .endsection Data8ABFF3Section


    .section DrawShopStartListSection

      .al
      .xl

      rsDrawShopStartList ; 8A/C003

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws the list the keeper opens with: the stock, the inventory with sell prices, or with repair costs.

        lda wKeeper
        beq _C027
        cmp #KEEPER_SECONDHAND_SHOP
        beq _C02C
        cmp #KEEPER_REPAIR_SHOP
        beq _C031
        cmp #KEEPER_DEPOT
        beq _C036
        cmp #$0004
        beq _C03B
        cmp #KEEPER_CLASS_CHANGE
        beq _C040
        cmp #$0006
        beq _C045

        _C027
        jsr rsDrawStockList
        bra _C04A


        _C02C
        jsr rsDrawInventoryWithSellPrices
        bra _C04A


        _C031
        jsr rsDrawInventoryWithRepairCosts
        bra _C04A


        _C036
        jsr rsDrawInventoryWithSellPrices
        bra _C04A


        _C03B
        jsr rsDrawStockList
        bra _C04A


        _C040
        jsr rsClearCastleList
        bra _C04A


        _C045
        jsr rsClearCastleList
        bra _C04A


        _C04A
        rts

        .databank 0

        ; 8A/C04B

      rlShopScreenStep ; 8A/C04B

        .al
        .xl
        .autsiz
        .databank ?

        ; Runs shop sub-state wMenuState (aShopStepHandlers), then redraws the list sprites, money and the keeper's portrait.

        phb
        php
        phk
        plb
        .databank $8A
        lda wMenuState,b
        asl a
        tax
        jsr (aShopStepHandlers,x)
        lda wCastleRedrawIcons
        bne _C06C
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0700, $80, $7000

        bra _C076


        _C06C
        lda #$0000
        sta wCastleRedrawIcons
        jsr rsCastleDrawListItemIcons

        _C076
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

        ; 8A/C08F

    .endsection DrawShopStartListSection


    .section ShopStepHandlersSection

      .al
      .xl

      aShopStepHandlers ; 8A/C08F

        ; Jump table of rlShopScreenStep.
        .word <>rsShopGreet
        .word <>rsShopWaitForText
        .word <>rsShopChooseOption
        .word <>rsShopOpenBuyList
        .word <>rsShopBuyListInput
        .word <>rsShopConfirmBuy
        .word <>rsShopAfterBuy
        .word <>rsShopBuyAgain
        .word <>rsShopLeaveBuyList
        .word <>rsShopOpenSellList
        .word <>rsShopSellListInput
        .word <>rsShopConfirmSell
        .word <>rsShopAfterSell
        .word <>rsShopOpenRepairList
        .word <>rsShopRepairListInput
        .word <>rsShopConfirmRepair
        .word <>rsShopAfterRepair
        .word <>rsShopOpenBelongingsList
        .word <>rsShopBelongingsListInput
        .word <>rsShopLeave
        .word <>rsShopLeaveToCourtyard

    .endsection ShopStepHandlersSection


    .section ShopGreetSection

      .al
      .xl

      rsShopGreet ; 8A/C0B9

        .al
        .xl
        .autsiz
        .databank ?

        ; Sub-state $00: the keeper's greeting. The repair shop sends a unit with no items away; the secondhand shop says it only buys when its stock is empty.

        lda wKeeper
        cmp #KEEPER_SECONDHAND_SHOP
        beq _C130
        cmp #KEEPER_REPAIR_SHOP
        beq _C104

        _C0C7
        lda wKeeper
        clc
        adc wKeeper
        clc
        adc wKeeper
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

        _C0FB
        sep #$20
        lda #$0F
        sta bBufferINIDISP
        rep #$20
        rts


        _C104
        lda wCastleListSubCount,b
        beq _C10B
        bra _C0C7


        _C10B
        lda #(`dialogueShopRepairShopNothingToRepair)<<8
        sta lR18+1
        lda #<>dialogueShopRepairShopNothingToRepair
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsSetupKeeperDialogueBox
        lda #$0001
        sta wMenuState,b
        lda #$0013
        sta wNextMenuState,b
        bra _C0FB


        _C130
        lda wCastleListItemCount,b
        beq _C137
        bra _C143


        _C137
        lda #(`dialogueShopSecondhandShopSellOnlyGreeting)<<8
        sta lR18+1
        lda #<>dialogueShopSecondhandShopSellOnlyGreeting
        sta lR18
        bra _C14D


        _C143
        lda #(`dialogueShop01)<<8
        sta lR18+1
        lda #<>dialogueShop01
        sta lR18

        _C14D
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsSetupKeeperDialogueBox
        lda #$0001
        sta wMenuState,b
        lda #$0002
        sta wNextMenuState,b
        bra _C0FB

        .databank 0

        ; 8A/C168

      rsShopWaitForText ; 8A/C168

        .al
        .xl
        .autsiz
        .databank ?

        ; Sub-state $01: shows the A-press arrows until the dialogue finishes, then moves to wNextMenuState.

        lda wNextMenuState,b
        cmp #$0005
        beq _C195
        cmp #$000B
        beq _C19A
        cmp #$000F
        beq _C19A

        _C17A
        lda aDialogue.wStatus,b
        beq _C18E
        lda #$00E8
        sta wR0
        lda #$0036
        sta wR1
        jsl rlDisplayDialogueAPressArrows
        rts


        _C18E
        lda wNextMenuState,b
        sta wMenuState,b
        rts


        _C195
        jsr rsPushStockItemTypeIcon
        bra _C19D


        _C19A
        jsr rsPushInventoryItemTypeIcon

        _C19D
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
        bra _C17A

        .databank 0

        ; 8A/C1BC

      rsShopChooseOption ; 8A/C1BC

        .al
        .xl
        .autsiz
        .databank ?

        ; Sub-state $02: the option menu. The item shop's options are buy and belongings; the secondhand and repair shops go to their own routines.

        lda #(`aCastleMenuTilemapData)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aCastleMenuTilemapData
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda wKeeper
        beq _C1E6
        cmp #KEEPER_SECONDHAND_SHOP
        beq _C1E2
        cmp #KEEPER_REPAIR_SHOP
        beq _C1DE

        _C1DE
        jml rsRepairShopStart


        _C1E2
        jml rsSecondhandShopChooseOption


        _C1E6
        jml _C1EA


        _C1EA
        lda #$0002
        sta wTempVariable1,b
        lda #(`aItemShopOptionsText)<<8
        sta lR18+1
        lda #<>aItemShopOptionsText
        sta lR18
        lda $18DD,b
        cmp #$0100
        beq _C208
        clc
        adc #$0120
        bra _C20C


        _C208
        sec
        sbc #$0040

        _C20C
        clc
        adc #$000B
        tax
        lda #$2000
        sta aCurrentTilemapInfo,b
        jsl rlDrawMenuTextLine
        lda #(`aItemShopOptionX)<<8
        sta lR19+1
        lda #<>aItemShopOptionX
        sta lR19
        lda #(`aItemShopOptions)<<8
        sta lR20+1
        lda #<>aItemShopOptions
        sta lR20
        lda wTempVariable1,b
        jsr rsCastleOptionMenuInput
        lda #$0000
        jsl rlPushCastleHandCursor
        lda wJoy1New
        cmp #$8000
        beq _C256
        cmp #$0080
        bne _C255
        lda wCastleMenuOptionIndex,b
        cmp #$0000
        beq _C292
        cmp #$0001
        beq _C2AB

        _C255
        rts


        _C256
        lda wKeeper
        clc
        adc wKeeper
        clc
        adc wKeeper
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
        lda #$0013
        sta wNextMenuState,b
        lda #$0021
        jsl rlPlaySoundEffect
        rts


        _C292
        lda wCastleListItemCount,b
        beq _C2E2
        ldx #$0000
        lda aShopDialoguePointers+73,x
        sta lR18+1
        lda aShopDialoguePointers+72,x
        sta lR18
        lda #$0003
        bra _C2C4


        _C2AB
        lda wCastleListSubCount,b
        beq _C2F0
        ldx #$0000
        lda aShopDialoguePointers+163,x
        sta lR18+1
        lda aShopDialoguePointers+162,x
        sta lR18
        lda #$0011
        bra _C2C4


        _C2C4
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


        _C2E2
        lda #(`dialogueShopItemShopSoldOut)<<8
        sta lR18+1
        lda #<>dialogueShopItemShopSoldOut
        sta lR18
        jml rsShopSayAndStay


        _C2F0
        lda #(`dialogueShopSecondhandShopNothingToSell)<<8
        sta lR18+1
        lda #<>dialogueShopSecondhandShopNothingToSell
        sta lR18
        jml rsShopSayAndStay

        .databank 0

      aItemShopOptionsText ; 8A/C2FE
        .byte $82, $A9, $82, $A4, $81, $40, $81, $40, $81, $40, $82, $E0, $82, $BF, $82, $E0
        .byte $82, $CC, $00, $00


      rsShopSayAndStay ; 8A/C312

        .al
        .xl
        .autsiz
        .databank ?

        ; Starts the dialogue in lR18 and comes back to the current sub-state when it ends.

        lda #$000A
        jsl rlPlaySoundEffect
        lda wMenuState,b
        sta wNextMenuState,b
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsSetupKeeperDialogueBox
        lda #$0001
        sta wMenuState,b
        rts

        .databank 0


      rsSecondhandShopChooseOption ; 8A/C333

        .al
        .xl
        .autsiz
        .databank ?

        ; The secondhand shop's option menu: sell or buy.

        lda #$0002
        sta wTempVariable1,b
        lda #(`aSecondhandShopOptionsText)<<8
        sta lR18+1
        lda #<>aSecondhandShopOptionsText
        sta lR18
        lda $18DD,b
        cmp #$0100
        beq _C351
        clc
        adc #$0120
        bra _C355


        _C351
        sec
        sbc #$0040

        _C355
        clc
        adc #$000B
        tax
        jsl rlDrawMenuTextLine
        stz wCastleListWindowRow,b
        stz wCastleListSelectedIndex,b
        lda #(`aSecondhandShopOptionX)<<8
        sta lR19+1
        lda #<>aSecondhandShopOptionX
        sta lR19
        lda #(`aSecondhandShopOptions)<<8
        sta lR20+1
        lda #<>aSecondhandShopOptions
        sta lR20
        lda wTempVariable1,b
        jsr rsCastleOptionMenuInput
        lda #$0000
        jsl rlPushCastleHandCursor
        lda wJoy1New
        cmp #$8000
        beq _C39F
        cmp #$0080
        bne _C39E
        lda wCastleMenuOptionIndex,b
        cmp #$0000
        beq _C3DB
        cmp #$0001
        beq _C3F4

        _C39E
        rts


        _C39F
        lda wKeeper
        clc
        adc wKeeper
        clc
        adc wKeeper
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
        lda #$0013
        sta wNextMenuState,b
        lda #$0021
        jsl rlPlaySoundEffect
        rts


        _C3DB
        lda wCastleListSubCount,b
        beq _C42B
        ldx #$0003
        lda aShopDialoguePointers+163,x
        sta lR18+1
        lda aShopDialoguePointers+162,x
        sta lR18
        lda #$0009
        bra _C40D


        _C3F4
        lda wCastleListItemCount,b
        beq _C439
        ldx #$0003
        lda aShopDialoguePointers+73,x
        sta lR18+1
        lda aShopDialoguePointers+72,x
        sta lR18
        lda #$0003
        bra _C40D


        _C40D
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


        _C42B
        lda #(`dialogueShopSecondhandShopNothingToSell)<<8
        sta lR18+1
        lda #<>dialogueShopSecondhandShopNothingToSell
        sta lR18
        jml rsShopSayAndStay


        _C439
        lda #(`dialogueShopSecondhandShopSoldOut)<<8
        sta lR18+1
        lda #<>dialogueShopSecondhandShopSoldOut
        sta lR18
        jml rsShopSayAndStay

        .databank 0

        ; 8A/C447

    .endsection ShopGreetSection


    .section SecondhandShopOptionsTextSection

      .al
      .xl

      aSecondhandShopOptionsText ; 8A/C447

        .enc "SJIS"
        .text "うる　　　かう"
        .word $0000
        .enc "none"


    .endsection SecondhandShopOptionsTextSection


    .section RepairShopStartSection

      .al
      .xl

      rsRepairShopStart ; 8A/C457

        .al
        .xl
        .autsiz
        .databank ?

        ; The repair shop: sends a unit with no items away, otherwise opens the repair list (sub-state $0D).

        lda wCastleListSubCount,b
        beq _C4B7
        jml _C4F3

        .byte $AD, $DD, $18, $C9, $00, $01, $F0, $06, $18, $69, $20, $01, $80, $04, $38, $E9
        .byte $40, $00, $18, $69, $0B, $00, $AA, $22, $54, $93, $87, $9C, $A5, $08, $9C, $A7
        .byte $08, $A9, $00, $8A, $85, $28, $A9, $7D, $D0, $85, $27, $A9, $00, $8A, $85, $2B
        .byte $A9, $7F, $D0, $85, $2A, $A9, $02, $00, $20, $BE, $CF, $A9, $00, $00, $22, $43
        .byte $B0, $8A, $A5, $E8, $C9, $00, $80, $F0, $0E, $C9, $80, $00, $D0, $08, $AD, $A1
        .byte $08, $C9, $00, $00, $F0, $3D, $60


        _C4B7
        lda wKeeper
        clc
        adc wKeeper
        clc
        adc wKeeper
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
        lda #$0013
        sta wNextMenuState,b
        lda #$0021
        jsl rlPlaySoundEffect
        rts


        _C4F3
        lda wCastleListSubCount,b
        beq _C4FF
        lda #$000D
        sta wMenuState,b
        rts


        _C4FF
        lda #(`dialogueShopSecondhandShopNothingToSell)<<8
        sta lR18+1
        lda #<>dialogueShopSecondhandShopNothingToSell
        sta lR18
        jml rsShopSayAndStay

        .databank 0

        ; 8A/C50D

    .endsection RepairShopStartSection


    .section ShopOpenBuyListSection

      .al
      .xl

      rsShopOpenBuyList ; 8A/C50D

        .al
        .xl
        .autsiz
        .databank ?

        ; Sub-state $03.

        lda #$FFFF
        sta wCastleRedrawIcons
        jsr rsDrawStockItemDetails
        jsr rsPushStockItemTypeIcon
        jsr rsDrawStockList
        lda #$0004
        sta wMenuState,b
        rts

        .databank 0

        ; 8A/C524

    .endsection ShopOpenBuyListSection


    .section ShopBuyListInputSection

      .al
      .xl

      rsShopBuyListInput ; 8A/C524

        .al
        .xl
        .autsiz
        .databank ?

        ; Sub-state $04: A buys if the item can be had, the inventory has room and the unit can pay; B goes back to the options.

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
        beq _C560
        cmp #$8000
        beq _C5C1

        _C557
        rts


        _C558
        lda #$0022
        jsl rlPlaySoundEffect
        rts


        _C560
        lda wCastleListSelectedIndex,b
        asl a
        tax
        lda aCastleListItemUnavailable,x
        bmi _C558
        lda wCastleListItemCount,b
        beq _C557
        lda wCastleListSubCount,b
        cmp #$0007
        bne _C57C
        jml _C610


        _C57C
        jsr rsShopCompareMoneyWithPrice
        bcs _C585
        jml _C64F


        _C585
        lda #$000A
        jsl rlPlaySoundEffect
        lda wKeeper
        clc
        adc wKeeper
        clc
        adc wKeeper
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


        _C5C1
        lda #$0021
        jsl rlPlaySoundEffect
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
        jsr rsClearItemDetailsWindow
        stz wCastleListWindowRow,b
        stz wCastleListSelectedIndex,b
        jsr rsDrawStockList
        lda #$FFFF
        sta wCastleRedrawIcons
        rts


        _C610
        lda #$0021
        jsl rlPlaySoundEffect
        lda wKeeper
        clc
        adc wKeeper
        clc
        adc wKeeper
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
        lda #$0008
        sta wNextMenuState,b
        jsr rsClearItemDetailsWindow
        rts


        _C64F
        lda #$0021
        jsl rlPlaySoundEffect
        lda wKeeper
        clc
        adc wKeeper
        clc
        adc wKeeper
        tax
        lda aShopDialoguePointers+118,x
        sta lR18+1
        lda aShopDialoguePointers+117,x
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

        ; 8A/C68E

    .endsection ShopBuyListInputSection


    .section ShopCompareMoneyWithPriceSection

      .al
      .xl

      rsShopCompareMoneyWithPrice ; 8A/C68E

        .al
        .xl
        .autsiz
        .databank ?

        ; Compares the unit's money with the selected item's price (halved with Bargain); carry set if the unit can pay.

        lda wCastleListSelectedIndex,b
        asl a
        tax
        lda aCastleListItemIndices,x
        sta wRoutineVariable1,b
        jsl rlGetItemRAMStructEntryByPlayerItemIndex
        jsl rlGetItemBuyPrice
        sta wTempVariable1,b
        jsl rlCheckUnitHasBargain
        bcc _C6B2
        lda wTempVariable1,b
        lsr a
        sta wTempVariable1,b

        _C6B2
        jsl rlGetSelectedUnitMoney
        cmp wTempVariable1,b
        rts

        .databank 0

        ; 8A/C6BA

    .endsection ShopCompareMoneyWithPriceSection


    .section ShopConfirmBuySection

      .al
      .xl

      rsShopConfirmBuy ; 8A/C6BA

        .al
        .xl
        .autsiz
        .databank ?

        ; Sub-state $05: yes buys the item (rlBuyItemForSelectedUnit).

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
        beq _C707
        cmp #$0080
        bne _C706
        lda wCastleConfirmCursorIndex,b
        cmp #$0000
        beq _C71B
        cmp #$0001
        beq _C707

        _C706
        rts


        _C707
        lda #$0021
        jsl rlPlaySoundEffect
        stz wCastleConfirmCursorIndex,b
        lda #$0006
        sta wMenuState,b
        jsr rsClearItemDetailsWindow
        rts


        _C71B
        lda wCastleListSelectedIndex,b
        asl a
        tax
        lda aCastleListItemIndices,x
        sta wRoutineVariable1,b
        jsl rlBuyItemForSelectedUnit
        bcs _C744
        inc wCastleListSubCount,b
        lda #$0070
        jsl rlPlaySoundEffect2
        stz wCastleConfirmCursorIndex,b
        lda #$0006
        sta wMenuState,b
        jsr rsClearItemDetailsWindow
        rts


        _C744
        bra _C746


        _C746
        lda #$0021
        jsl rlPlaySoundEffect
        lda wKeeper
        clc
        adc wKeeper
        clc
        adc wKeeper
        tax
        lda aShopDialoguePointers+118,x
        sta lR18+1
        lda aShopDialoguePointers+117,x
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

        ; 8A/C785

    .endsection ShopConfirmBuySection


    .section ShopAfterBuySection

      .al
      .xl

      rsShopAfterBuy ; 8A/C785

        .al
        .xl
        .autsiz
        .databank ?

        ; Sub-state $06: rebuilds the stock list; asks whether to buy more, or goes back to the options if the stock is empty.

        jsl rlBuildStockList
        jsr rsDrawStockList
        lda #$FFFF
        sta wCastleRedrawIcons
        lda wCastleListItemCount,b
        beq _C7DC
        lda wCastleListSelectedIndex,b
        cmp wCastleListItemCount,b
        bcc _C7A7
        dec a
        sta wCastleListSelectedIndex,b
        dec wCastleListWindowRow,b

        _C7A7
        lda wKeeper
        clc
        adc wKeeper
        clc
        adc wKeeper
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


        _C7DC
        lda #$0021
        jsl rlPlaySoundEffect
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
        stz wCastleListWindowRow,b
        stz wCastleListSelectedIndex,b
        rts

        .databank 0

        ; 8A/C81E

    .endsection ShopAfterBuySection


    .section ShopBuyAgainSection

      .al
      .xl

      rsShopBuyAgain ; 8A/C81E

        .al
        .xl
        .autsiz
        .databank ?

        ; Sub-state $07: asks whether to buy more and goes straight to sub-state $03.

        lda wKeeper
        clc
        adc wKeeper
        clc
        adc wKeeper
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
        sta wMenuState,b
        rts

        .databank 0

        ; 8A/C853

    .endsection ShopBuyAgainSection


    .section ShopLeaveBuyListSection

      .al
      .xl

      rsShopLeaveBuyList ; 8A/C853

        .al
        .xl
        .autsiz
        .databank ?

        ; Sub-state $08.

        stz wCastleConfirmCursorIndex,b
        lda #$0021
        jsl rlPlaySoundEffect
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
        stz wCastleListWindowRow,b
        stz wCastleListSelectedIndex,b
        jsr rsDrawStockList
        lda #$FFFF
        sta wCastleRedrawIcons
        rts

        .databank 0

        ; 8A/C8A2

    .endsection ShopLeaveBuyListSection


    .section ShopOpenSellListSection

      .al
      .xl

      rsShopOpenSellList ; 8A/C8A2

        .al
        .xl
        .autsiz
        .databank ?

        ; Sub-state $09.

        lda #$FFFF
        sta wCastleRedrawIcons
        jsr rlDrawInventoryItemDetails
        jsr rsPushInventoryItemTypeIcon
        jsr rsDrawInventoryWithSellPrices
        lda #$000A
        sta wMenuState,b
        rts

        .databank 0

        ; 8A/C8B9

      rsShopSellListInput ; 8A/C8B9

        .al
        .xl
        .autsiz
        .databank ?

        ; Sub-state $0A.

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
        beq _C8E9
        cmp #$8000
        beq _C935

        _C8E8
        rts


        _C8E9
        lda wCastleListSelectedIndex,b
        inc a
        sta wRoutineVariable1,b
        jsl rlGetItemROMDataByInventorySlot
        lda wCurrentItemDataROMPointer,b
        beq _C8E8
        lda #$000A
        jsl rlPlaySoundEffect
        lda wKeeper
        clc
        adc wKeeper
        clc
        adc wKeeper
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
        lda #$000B
        sta wNextMenuState,b
        rts


        _C935
        lda #$0021
        jsl rlPlaySoundEffect
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
        jsr rsClearItemDetailsWindow
        stz wCastleListWindowRow,b
        stz wCastleListSelectedIndex,b
        jsr rsDrawInventoryWithSellPrices
        lda #$FFFF
        sta wCastleRedrawIcons
        rts

        .databank 0

        ; 8A/C984

    .endsection ShopOpenSellListSection


    .section ShopConfirmSellSection

      .al
      .xl

      rsShopConfirmSell ; 8A/C984

        .al
        .xl
        .autsiz
        .databank ?

        ; Sub-state $0B: yes sells the item (rlSellInventorySlotItem) and moves it into this castle's secondhand stock.

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
        beq _C9FD
        cmp #$0080
        bne _C9D0
        lda wCastleConfirmCursorIndex,b
        cmp #$0000
        beq _C9D1
        cmp #$0001
        beq _C9FD

        _C9D0
        rts


        _C9D1
        jsl rlSellInventorySlotItem
        bcs _CA11
        jsl rlMoveItemToSecondhandStock
        jsl rlBuildStockList
        jsr rsDrawInventoryWithSellPrices
        lda #$FFFF
        sta wCastleRedrawIcons
        lda #$0070
        jsl rlPlaySoundEffect2
        stz wCastleConfirmCursorIndex,b
        lda #$000C
        sta wMenuState,b
        jsr rsClearItemDetailsWindow
        rts


        _C9FD
        lda #$0021
        jsl rlPlaySoundEffect
        stz wCastleConfirmCursorIndex,b
        lda #$000C
        sta wMenuState,b
        jsr rsClearItemDetailsWindow
        rts


        _CA11
        lda #$0021
        jsl rlPlaySoundEffect
        stz wCastleConfirmCursorIndex,b
        lda wKeeper
        clc
        adc wKeeper
        clc
        adc wKeeper
        tax
        lda aShopDialoguePointers+148,x
        sta lR18+1
        lda aShopDialoguePointers+147,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsSetupKeeperDialogueBox
        lda #$0001
        sta wMenuState,b
        lda #$000C
        sta wNextMenuState,b
        jsr rsClearItemDetailsWindow
        rts

        .databank 0

        ; 8A/CA53

    .endsection ShopConfirmSellSection


    .section ShopAfterSellSection

      .al
      .xl

      rsShopAfterSell ; 8A/CA53

        .al
        .xl
        .autsiz
        .databank ?

        ; Sub-state $0C: asks whether to sell more, or goes back to the options if the unit has nothing left.

        stz wCastleListWindowRow,b
        stz wCastleListSelectedIndex,b
        lda wCastleListSubCount,b
        beq _CA93
        lda wKeeper
        clc
        adc wKeeper
        clc
        adc wKeeper
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
        lda #$0009
        sta wNextMenuState,b
        rts


        _CA93
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
        lda #$FFFF
        sta wCastleRedrawIcons
        rts

        .databank 0

        ; 8A/CAD2

    .endsection ShopAfterSellSection


    .section ShopOpenRepairListSection

      .al
      .xl

      rsShopOpenRepairList ; 8A/CAD2

        .al
        .xl
        .autsiz
        .databank ?

        ; Sub-state $0D.

        lda #$FFFF
        sta wCastleRedrawIcons
        jsr rlDrawInventoryItemDetails
        jsr rsPushInventoryItemTypeIcon
        jsr rsDrawInventoryWithRepairCosts
        lda #$000E
        sta wMenuState,b
        rts

        .databank 0

        ; 8A/CAE9

      rsShopRepairListInput ; 8A/CAE9

        .al
        .xl
        .autsiz
        .databank ?

        ; Sub-state $0E: only items with a repair cost can be chosen; an item with 50 or more kills gets a different line.

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
        jsr rsCastleRepairListInput
        lda wJoy1New
        cmp #$0080
        beq _CB21
        cmp #$8000
        beq _CB7E

        _CB18
        rts


        _CB19
        lda #$0022
        jsl rlPlaySoundEffect
        rts


        _CB21
        lda wCastleListSelectedIndex,b
        inc a
        sta wRoutineVariable1,b
        jsl rlGetItemROMDataByInventorySlot
        lda wCurrentItemDataROMPointer,b
        beq _CB18
        lda wRoutineVariable1,b
        jsl rlGetInventorySlotItemRepairCost
        cmp #$0000
        beq _CB19
        lda #$000A
        jsl rlPlaySoundEffect
        jsr rsCheckItemHasFiftyKills
        bcs _CBBD
        lda wKeeper
        clc
        adc wKeeper
        clc
        adc wKeeper
        tax
        lda aShopDialoguePointers+223,x
        sta lR18+1
        lda aShopDialoguePointers+222,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsSetupKeeperDialogueBox
        lda #$0001
        sta wMenuState,b
        lda #$000F
        sta wNextMenuState,b
        rts


        _CB7E
        lda #$0021
        jsl rlPlaySoundEffect
        lda wKeeper
        clc
        adc wKeeper
        clc
        adc wKeeper
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
        lda #$0013
        sta wNextMenuState,b
        jsr rsClearItemDetailsWindow
        rts


        _CBBD
        lda wKeeper
        clc
        adc wKeeper
        clc
        adc wKeeper
        tax
        lda aShopDialoguePointers+253,x
        sta lR18+1
        lda aShopDialoguePointers+252,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsSetupKeeperDialogueBox
        lda #$0001
        sta wMenuState,b
        lda #$000F
        sta wNextMenuState,b
        rts

        .databank 0

        ; 8A/CBF2

    .endsection ShopOpenRepairListSection


    .section ShopRepairCancelSection

      .al
      .xl

      rsShopRepairCancel ; 8A/CBF2

        ; Nothing in the build reaches this. Plays sound $21 and starts the shop
        ; dialogue picked by wKeeper from the table at $8A/CF28 (not built).

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0021
        jsl rlPlaySoundEffect
        lda wKeeper
        clc
        adc wKeeper
        clc
        adc wKeeper
        tax
        lda aShopDialoguePointers+118,x
        sta lR18+1
        lda aShopDialoguePointers+117,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsSetupKeeperDialogueBox
        lda #$0001
        sta wMenuState,b
        lda #$000D
        sta wNextMenuState,b
        jsr rsClearItemDetailsWindow
        rts

        .databank 0

        ; 8A/CC31

      rsCompareMoneyWithRepairCost ; 8A/CC31

        ; Nothing in the build reaches this. Compares the selected unit's money with
        ; the repair cost of inventory slot wRoutineVariable1 (kept in wTempVariable1).

        .al
        .xl
        .autsiz
        .databank ?

        lda wRoutineVariable1,b
        jsl rlGetInventorySlotItemRepairCost
        sta wTempVariable1,b
        jsl rlGetSelectedUnitMoney
        cmp wTempVariable1,b
        rts

        .databank 0

        ; 8A/CC43

    .endsection ShopRepairCancelSection


    .section CheckItemHasFiftyKillsSection

      .al
      .xl

      rsCheckItemHasFiftyKills ; 8A/CC43

        .al
        .xl
        .autsiz
        .databank ?

        ; Carry set if the selected inventory item has 50 or more kills.

        lda wCastleListSelectedIndex,b
        inc a
        jsl rlGetItemRAMStructEntryByInventorySlot
        jsl rlGetItemRAMKillCountAndCritAbility
        cmp #$0032
        bcs _CC56
        clc
        rts


        _CC56
        sec
        rts

        .databank 0

        ; 8A/CC58

    .endsection CheckItemHasFiftyKillsSection


    .section ShopConfirmRepairSection

      .al
      .xl

      rsShopConfirmRepair ; 8A/CC58

        .al
        .xl
        .autsiz
        .databank ?

        ; Sub-state $0F: yes repairs the item (rlRepairSelectedUnitItem).

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
        beq _CCA5
        cmp #$0080
        bne _CCA4
        lda wCastleConfirmCursorIndex,b
        cmp #$0000
        beq _CCB6
        cmp #$0001
        beq _CCA5

        _CCA4
        rts


        _CCA5
        lda #$0021
        jsl rlPlaySoundEffect
        stz wCastleConfirmCursorIndex,b
        lda #$0010
        sta wMenuState,b
        rts


        _CCB6
        jsl rlRepairSelectedUnitItem
        bcs _CCCD
        lda #$0070
        jsl rlPlaySoundEffect2
        stz wCastleConfirmCursorIndex,b
        lda #$0010
        sta wMenuState,b
        rts


        _CCCD
        cmp #$0000
        bne _CD14
        lda #$0021
        jsl rlPlaySoundEffect
        stz wCastleConfirmCursorIndex,b
        lda wKeeper
        clc
        adc wKeeper
        clc
        adc wKeeper
        tax
        lda aShopDialoguePointers+148,x
        sta lR18+1
        lda aShopDialoguePointers+147,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsSetupKeeperDialogueBox
        lda #$0001
        sta wMenuState,b
        lda #$0010
        sta wNextMenuState,b
        jsr rsClearItemDetailsWindow
        rts


        _CD14
        lda #$0021
        jsl rlPlaySoundEffect
        lda wKeeper
        clc
        adc wKeeper
        clc
        adc wKeeper
        tax
        lda aShopDialoguePointers+118,x
        sta lR18+1
        lda aShopDialoguePointers+117,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsSetupKeeperDialogueBox
        lda #$0001
        sta wMenuState,b
        lda #$000D
        sta wNextMenuState,b
        jsr rsClearItemDetailsWindow
        rts

        .databank 0

        ; 8A/CD53

    .endsection ShopConfirmRepairSection


    .section ShopAfterRepairSection

      .al
      .xl

      rsShopAfterRepair ; 8A/CD53

        .al
        .xl
        .autsiz
        .databank ?

        ; Sub-state $10.

        stz wCastleListWindowRow,b
        stz wCastleListSelectedIndex,b
        jsr rsDrawInventoryWithRepairCosts
        jsr rsClearItemDetailsWindow
        lda wKeeper
        clc
        adc wKeeper
        clc
        adc wKeeper
        tax
        lda aShopDialoguePointers+238,x
        sta lR18+1
        lda aShopDialoguePointers+237,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsSetupKeeperDialogueBox
        lda #$0001
        sta wMenuState,b
        lda #$000D
        sta wNextMenuState,b
        rts

        .databank 0

        ; 8A/CD94

    .endsection ShopAfterRepairSection


    .section ShopOpenBelongingsListSection

      .al
      .xl

      rsShopOpenBelongingsList ; 8A/CD94

        .al
        .xl
        .autsiz
        .databank ?

        ; Sub-state $11: the item shop's belongings option.

        lda #$FFFF
        sta wCastleRedrawIcons
        jsr rlDrawInventoryItemDetails
        jsr rsPushInventoryItemTypeIcon
        jsr rsDrawInventoryWithSellPrices
        lda #$0012
        sta wMenuState,b
        rts

        .databank 0

        ; 8A/CDAB

    .endsection ShopOpenBelongingsListSection


    .section ShopBelongingsListInputSection

      .al
      .xl

      rsShopBelongingsListInput ; 8A/CDAB

        .al
        .xl
        .autsiz
        .databank ?

        ; Sub-state $12: the list can be scrolled but not chosen from; B goes back to the options.

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
        beq _CDDB
        cmp #$8000
        beq _CDDC
        rts


        _CDDB
        rts


        _CDDC
        lda #$0021
        jsl rlPlaySoundEffect
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
        jsr rsClearItemDetailsWindow
        stz wCastleListWindowRow,b
        stz wCastleListSelectedIndex,b
        jsr rsDrawInventoryWithSellPrices
        lda #$FFFF
        sta wCastleRedrawIcons
        rts

        .databank 0

        ; 8A/CE2B

    .endsection ShopBelongingsListInputSection


    .section ShopLeaveSection

      .al
      .xl

      rsShopLeave ; 8A/CE2B

        .al
        .xl
        .autsiz
        .databank ?

        ; Sub-state $13: blanks the screen and returns to the town (step $12).

        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        lda #CASTLE_STEP_REOPEN_TOWN_SAME_SONG
        sta wGameStateStep,b
        rts

        .databank 0

        ; 8A/CE3A

    .endsection ShopLeaveSection


    .section ShopLeaveToCourtyardSection

      .al
      .xl

      rsShopLeaveToCourtyard ; 8A/CE3A

        .al
        .xl
        .autsiz
        .databank ?

        ; Sub-state $14: blanks the screen and returns to the courtyard (step $11).

        lda #CASTLE_CURSOR_GRID
        sta wCastleCursorState,b
        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        lda #CASTLE_STEP_RETURN_TO_COURTYARD
        sta wGameStateStep,b
        rts

        .databank 0

        ; 8A/CE4F

        ; Unreachable: it follows a return.
        rts

    .endsection ShopLeaveToCourtyardSection


    .section ShopDialoguePointersSection

      .al
      .xl

      aShopDialoguePointers ; 8A/CEB3

        ; One per shop message (indexed by wKeeper * 3): the item shop, secondhand
        ; shop, repair shop, depot and arena keepers. Text in text/dialogue/Shops.

        .long dialogueShop00
        .long dialogueShop01
        .long dialogueShop02
        .long dialogueShop03
        .long dialogueShop04
        .long dialogueShop05
        .long dialogueShop06
        .long dialogueShop06
        .long dialogueShop06
        .long dialogueShop06
        .long dialogueShop06
        .long dialogueShop06
        .long dialogueShop0C
        .long dialogueShop0D
        .long dialogueShop0E
        .long dialogueShop0F
        .long dialogueShop10
        .long dialogueShop0C
        .long dialogueShop12
        .long dialogueShop13
        .long dialogueShop14
        .long dialogueShop15
        .long dialogueShop10
        .long dialogueShop17
        .long dialogueShop18
        .long dialogueShop19
        .long dialogueShop18
        .long dialogueShop1B
        .long dialogueShop10
        .long dialogueShop1D
        .long dialogueShop1E
        .long dialogueShop1D
        .long dialogueShop20
        .long dialogueShop10
        .long dialogueShop22
        .long dialogueShop23
        .long dialogueShop10
        .long dialogueShop25
        .long dialogueShop10
        .long dialogueShop27
        .long dialogueShop28
        .long dialogueShop29
        .long dialogueShop27
        .long dialogueShop27
        .long dialogueShop2C
        .long dialogueShop2D
        .long dialogueShop2C
        .long dialogueShop2F
        .long dialogueShop2C
        .long dialogueShop31
        .long dialogueShop31
        .long dialogueShop33
        .long dialogueShop31
        .long dialogueShop31
        .long dialogueShop36
        .long dialogueShop37
        .long dialogueShop10
        .long dialogueShop39
        .long dialogueShop10
        .long dialogueShop10
        .long dialogueShop3C
        .long dialogueShop10
        .long dialogueShop20
        .long dialogueShop10
        .long dialogueShop10
        .long dialogueShop41
        .long dialogueShop10
        .long dialogueShop43
        .long dialogueShop10
        .long dialogueShop45
        .long dialogueShop45
        .long dialogueShop47
        .long dialogueShop45
        .long dialogueShop10
        .long dialogueShop4A
        .long dialogueShop4A
        .long dialogueShop4A
        .long dialogueShop4A
        .long dialogueShop4E
        .long dialogueShop4F
        .long dialogueShop4F
        .long dialogueShop4F
        .long dialogueShop4F
        .long dialogueShop4F
        .long dialogueShop54
        .long dialogueShop54
        .long dialogueShop54
        .long dialogueShop54
        .long dialogueShop4E

    .endsection ShopDialoguePointersSection


    .section CastleOptionMenuInputSection

      .al
      .xl

      rsCastleOptionMenuInput ; 8A/CFBE

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Left and right over the keeper's options; redraws the list for the option under the cursor.

        sec
        sbc #$0001
        sta wR0
        lda wJoy1New
        bit #$0200
        bne _CFD2
        bit #$0100
        bne _CFEE
        bra _D00C


        _CFD2
        lda wCastleMenuOptionIndex,b
        beq _D00C
        sec
        sbc #$0001
        sta wCastleMenuOptionIndex,b
        lda #$0007
        jsl rlPlaySoundEffect
        lda #$FFFF
        sta wCastleRedrawIcons
        bra _D02D


        _CFEE
        lda wCastleMenuOptionIndex,b
        cmp wR0
        bcs _D00C
        clc
        adc #$0001
        sta wCastleMenuOptionIndex,b
        lda #$0007
        jsl rlPlaySoundEffect
        lda #$FFFF
        sta wCastleRedrawIcons
        bra _D02D


        _D00C
        lda wCastleMenuOptionIndex,b
        tay
        lda [lR19],y
        and #$00FF
        sec
        sbc #$000D
        sta wR0
        lda #$0020
        clc
        adc #$0004
        clc
        adc #$0008
        clc
        adc #$0008
        sta wR1
        rts


        _D02D
        lda wCastleMenuOptionIndex,b
        tay
        lda [lR20],y
        and #$00FF
        cmp #$00FF
        beq _D00C
        cmp #$0000
        beq _D059
        cmp #$0001
        beq _D05E
        cmp #$0002
        beq _D063
        cmp #$0003
        beq _D068
        cmp #$0004
        beq _D06D
        cmp #$0005
        beq _D06F

        _D059
        jsr rsDrawStockList
        bra _D00C


        _D05E
        jsr rsDrawInventoryWithSellPrices
        bra _D00C


        _D063
        jsr rsDrawInventoryWithRepairCosts
        bra _D00C


        _D068
        jsr rsClearCastleList
        bra _D00C


        _D06D
        bra _D00C


        _D06F
        bra _D00C

        .databank 0

        ; 8A/D071

    .endsection CastleOptionMenuInputSection


    .section ItemShopOptionXSection

      .al
      .xl

      aItemShopOptionX ; 8A/D071
        .byte $54, $7C, $A4

      aItemShopOptions ; 8A/D074
        .byte $00, $01, $03

      aSecondhandShopOptionX ; 8A/D077
        .byte $54, $7C, $A4

      aSecondhandShopOptions ; 8A/D07A
        .byte $01, $00, $03, $54, $84, $02, $03

      aDepotOptionX ; 8A/D081
        .byte $54, $84

      aDepotOptions ; 8A/D083
        .byte $01, $00, $00, $04, $05

      aArenaOptionCursorXPositions ; 8A/D088
        .byte $54, $8C

      aArenaOptions ; 8A/D08A
        .byte $FF, $03

      aArenaSubmenuCursorXPositions ; 8A/D08C
        .byte $54, $84, $BC

      aArenaSubmenuOptions ; 8A/D08F
        .byte $FF, $FF, $FF


    .endsection ItemShopOptionXSection
