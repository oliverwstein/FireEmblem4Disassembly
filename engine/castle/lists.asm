; The lists and windows the castle facilities share: building the stock, stored
; item and weapon lists (aCastleListItemIndices and the arrays after it), drawing them with
; prices, repair costs and durability, item details and weapon stats, scrolling
; them, the yes/no prompt, the option menu, money and numbers, and the window HDMA.
; wCastleListItemState chooses which items a list collects. Bank $8A.


    .section Table8A9DD5Section

      .al
      .xl

      aCastleListRowY ; 8A/9DD5

        ; Read by arena & bank8A inventory setup routines.

        .byte $50, $60, $70, $80, $90, $A0, $B0, $C0

        ; 8A/9DDD

    .endsection Table8A9DD5Section


    .section Unsorted8A9DDDSection

      .al
      .xl

      rlAppendItemsFromList ; 8A/9DDD

        .al
        .xl
        .autsiz
        .databank ?

        ldy #$0000

        _9DE0
        lda [lR18],y
        and #$00FF
        cmp #$00FF
        beq _9DF1
        jsl rlAppendNewItemRAMEntry
        inc y
        bra _9DE0


        _9DF1
        rtl

        .databank 0

        ; 8A/9DF2


    .endsection Unsorted8A9DDDSection


    .section Unsorted8A9DF2Section

      .al
      .xl

      rlBuildStockList ; 8A/9DF2

        .al
        .xl
        .autsiz
        .databank ?

        ; Lists every item in state wCastleListItemState (the shop's or secondhand stock): item index, ID, ROM and RAM pointers; items the unit can't use (rlCheckSelectedUnitCanUseItem) are marked $FFFF.
        ; The owner is never compared, so every shop lists the items of every castle: all the shop
        ; lists put on sale so far in the generation, and everything sold anywhere. The compare
        ; with ItemStatePawnbroker below branches to the next instruction either way.

        stz wCastleListItemCount,b
        jsl rlGetItemRAMDataCount
        sta wTempVariable1,b
        ldy #$0001
        ldx #$0000

        _9E02
        tya
        jsl rlGetItemRAMStructEntryByPlayerItemIndex
        bcs _9E51
        jsl rlGetItemRAMStateAndOwner
        lda wR0
        cmp wCastleListItemState,b
        bne _9E51
        cmp #$0005
        beq _9E19

        _9E19
        tya
        sta aCastleListItemIndices,x
        jsl rlGetEffectiveItemIDByItemRAMStructEntry
        sta aCastleListItemIDs,x
        jsl rlGetEffectiveItemROMPointerByItemRAMStructEntry
        lda #$0000
        sta aCastleListItemUnavailable,x
        jsl rlCheckSelectedUnitCanUseItem
        bcs _9E3E
        lda #$FFFF
        sta aCastleListItemUnavailable,x

        _9E3E
        lda wCurrentItemDataROMPointer,b
        sta aCastleListItemROMPointers,x
        lda wCurrentItemDataRAMPointer,b
        sta aCastleListItemRAMPointers,x
        inc wCastleListItemCount,b
        inc x
        inc x

        _9E51
        cpy wTempVariable1,b
        beq _9E59
        inc y
        bra _9E02


        _9E59
        rtl

        .databank 0

        ; 8A/9E5A

      rlBuildUnitStoredItemList ; 8A/9E5A

        .al
        .xl
        .autsiz
        .databank ?

        ; Lists the items in state wCastleListItemState owned by the selected unit (the depot).

        stz wCastleListItemCount,b
        jsl rlGetItemRAMDataCount
        sta wTempVariable1,b
        ldy #$0001
        ldx #$0000

        _9E6A
        tya
        jsl rlGetItemRAMStructEntryByPlayerItemIndex
        bcs _9EAE
        jsl rlGetItemRAMStateAndOwner
        lda wR0
        cmp wCastleListItemState,b
        bne _9EAE
        lda wR1
        cmp wSelectedUnitDataRAMPointer,b
        bne _9EAE
        tya
        sta aCastleListItemIndices,x
        jsl rlGetEffectiveItemIDByItemRAMStructEntry
        sta aCastleListItemIDs,x
        jsl rlGetEffectiveItemROMPointerByItemRAMStructEntry
        lda #$0000
        sta aCastleListItemUnavailable,x
        lda wCurrentItemDataROMPointer,b
        sta aCastleListItemROMPointers,x
        lda wCurrentItemDataRAMPointer,b
        sta aCastleListItemRAMPointers,x
        inc wCastleListItemCount,b
        inc x
        inc x

        _9EAE
        cpy wTempVariable1,b
        beq _9EB6
        inc y
        bra _9E6A


        _9EB6
        rtl

        .databank 0

        ; 8A/9EB7

    .endsection Unsorted8A9DF2Section


    .section Unsorted8A9EB7Section

      .al
      .xl

      rlBuildEquippableWeaponList ; 8A/9EB7

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Lists the unit's equippable weapons, the equipped one first (the arena).

        ldx #$0000
        stz wCastleListItemCount,b
        jsl rlGetFirstEquippableWeaponInInventory
        sta aCastleListInventorySlots,x
        sta wTempVariable1,b
        lda wCurrentItemDataROMPointer,b
        beq _9EEC
        sta aCastleListItemROMPointers,x
        lda #$0000
        sta aCastleListItemUnavailable,x
        jsl rlGetEffectiveItemIDByItemRAMStructEntry
        sta aCastleListItemIDs,x
        lda wCurrentItemDataRAMPointer,b
        sta aCastleListItemRAMPointers,x
        inc wCastleListItemCount,b
        inc x
        inc x

        _9EEC
        ldy #$0007

        _9EEF
        tya
        sta wRoutineVariable1,b
        jsl rlGetItemROMDataByInventorySlot
        lda wCurrentItemDataROMPointer,b
        beq _9F2E
        jsl rlCheckWeaponEquippable
        bcc _9F2E
        lda #$0000
        sta aCastleListItemUnavailable,x
        lda wCurrentItemDataROMPointer,b
        sta aCastleListItemROMPointers,x
        jsl rlGetEffectiveItemIDByItemRAMStructEntry
        sta aCastleListItemIDs,x
        lda wCurrentItemDataRAMPointer,b
        sta aCastleListItemRAMPointers,x
        tya
        cmp wTempVariable1,b
        beq _9F2E
        sta aCastleListInventorySlots,x
        inc wCastleListItemCount,b
        inc x
        inc x

        _9F2E
        dec y
        bne _9EEF
        rtl

        .databank 0

        ; 8A/9F32

      rlBuildEquippableWeaponListSameRange ; 8A/9F32

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Like rlBuildEquippableWeaponList, but only weapons with the same minimum range as the equipped one.

        ldx #$0000
        stz wCastleListItemCount,b
        jsl rlGetFirstEquippableWeaponInInventory
        sta aCastleListInventorySlots,x
        sta wTempVariable1,b
        jsl rlGetItemMinimumRange
        sta wTempVariable2,b
        jsl rlGetSelectedUnitEquippedWeaponBitfield
        cmp #$0000
        bne _9F59
        lda #$0001
        sta wTempVariable2,b

        _9F59
        lda wCurrentItemDataROMPointer,b
        beq _9F7D
        sta aCastleListItemROMPointers,x
        lda #$0000
        sta aCastleListItemUnavailable,x
        jsl rlGetEffectiveItemIDByItemRAMStructEntry
        sta aCastleListItemIDs,x
        lda wCurrentItemDataRAMPointer,b
        sta aCastleListItemRAMPointers,x
        inc wCastleListItemCount,b
        inc x
        inc x

        _9F7D
        ldy #$0007

        _9F80
        tya
        sta wRoutineVariable1,b
        jsl rlGetItemROMDataByInventorySlot
        lda wCurrentItemDataROMPointer,b
        beq _9FC8
        jsl rlGetItemMinimumRange
        cmp wTempVariable2,b
        bne _9FC8
        jsl rlCheckWeaponEquippable
        bcc _9FC8
        lda #$0000
        sta aCastleListItemUnavailable,x
        lda wCurrentItemDataROMPointer,b
        sta aCastleListItemROMPointers,x
        jsl rlGetEffectiveItemIDByItemRAMStructEntry
        sta aCastleListItemIDs,x
        lda wCurrentItemDataRAMPointer,b
        sta aCastleListItemRAMPointers,x
        tya
        cmp wTempVariable1,b
        beq _9FC8
        sta aCastleListInventorySlots,x
        inc wCastleListItemCount,b
        inc x
        inc x

        _9FC8
        dec y
        bne _9F80
        rtl

        .databank 0

        ; 8A/9FCC

    .endsection Unsorted8A9EB7Section


    .section Unsorted8A9FCCSection

      .al
      .xl

      rlBuildItemListInState ; 8A/9FCC

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        stz wCastleListItemCount,b
        jsl rlGetItemRAMDataCount
        tay
        ldx #$0000

        _9FD7
        tya
        jsl rlGetItemRAMStructEntryByPlayerItemIndex
        bcs _A00F
        jsl rlGetItemRAMStateAndOwner
        lda wR0
        cmp wCastleListItemState,b
        bne _A00F
        bne _A00F
        tya
        sta aCastleListItemIndices,x
        jsl rlGetEffectiveItemIDByItemRAMStructEntry
        sta aCastleListItemIDs,x
        jsl rlGetEffectiveItemROMPointerByItemRAMStructEntry
        lda #$0000
        sta aCastleListItemUnavailable,x
        lda wCurrentItemDataROMPointer,b
        sta aCastleListItemROMPointers,x
        inc wCastleListItemCount,b
        inc x
        inc x

        _A00F
        dec y
        bne _9FD7
        rtl

        .databank 0

        ; 8A/A013

    .endsection Unsorted8A9FCCSection


    .section Unsorted8AA013Section

      .al
      .xl

      rlMoveItemToSecondhandStock ; 8A/A013

        .al
        .xl
        .autsiz
        .databank ?

        ; Sets the item's state to ItemStatePawnbroker, owned by the castle entered.

        lda #$0005
        sta wR0
        lda wEnteredCastleLocationID,b
        sta wR1
        jsl rlSetItemRAMStateAndOwner
        rtl

        .databank 0

        ; 8A/A022

    .endsection Unsorted8AA013Section


    .section Table8AA022Section

      .al
      .xl

      aUnknown8AA022 ; 8A/A022
        .byte $30, $01, $00, $00, $00, $00, $C3, $80, $7F

    .endsection Table8AA022Section


    .section Unsorted8AA02BSection

      .al
      .xl

      rsDrawItemDescription ; 8A/A02B

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aUnknown8AA022)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aUnknown8AA022
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$0000
        ldx #$00C0

        _A03D
        sta $7F80C1,x
        dec x
        dec x
        bne _A03D
        lda aCurrentTilemapInfo,b
        pha
        lda #$2000
        sta aCurrentTilemapInfo,b
        jsl rlGetItemDescriptionPointer
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$0000
        jsl rlDrawMenuTextLine
        pla
        sta aCurrentTilemapInfo,b
        lda #(`aCastleMenuTilemapData)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aCastleMenuTilemapData
        sta lMapMenuTilemapRAMEntryPointer,b
        ldx #$0000

        _A077
        lda $7F80C3,x
        sta $7E868A,x
        lda $7F8123,x
        sta $7E86CA,x
        inc x
        inc x
        cpx #$0010
        bne _A077
        ldx #$0000

        _A091
        lda $7F80D3,x
        sta $7E870A,x
        lda $7F8133,x
        sta $7E874A,x
        inc x
        inc x
        cpx #$0010
        bne _A091
        ldx #$0000

        _A0AB
        lda $7F80E3,x
        sta $7E878A,x
        lda $7F8143,x
        sta $7E87CA,x
        inc x
        inc x
        cpx #$0010
        bne _A0AB
        ldx #$0000

        _A0C5
        lda $7F80F3,x
        sta $7E880A,x
        lda $7F8153,x
        sta $7E884A,x
        inc x
        inc x
        cpx #$0010
        bne _A0C5
        ldx #$0000

        _A0DF
        lda $7F8103,x
        sta $7E888A,x
        lda $7F8163,x
        sta $7E88CA,x
        inc x
        inc x
        cpx #$0010
        bne _A0DF
        ldx #$0000

        _A0F9
        lda $7F8113,x
        sta $7E890A,x
        lda $7F8173,x
        sta $7E894A,x
        inc x
        inc x
        cpx #$0010
        bne _A0F9
        lda #(`aItemDescriptionBlankText)<<8
        sta lRoutineVariable+1,b
        lda #<>aItemDescriptionBlankText
        sta lRoutineVariable,b
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$1600
        jsl rlDrawMenuTextLine
        rts

        .databank 0

        ; 8A/A12E

    .endsection Unsorted8AA02BSection


    .section Table8AA12ESection

      .al
      .xl

      aItemDescriptionBlankText ; 8A/A12E

        .enc "SJIS"
        .text "　　　　　　　　　"
        .word $0000
        .enc "none"


    .endsection Table8AA12ESection


    .section Unsorted8AA142Section

      .al
      .xl

      rsCastleDrawListItemIcons ; 8A/A142

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Draws 8 item icons for the active castle list or unit inventory

        lda lKeeperOptionList+1
        sta lR20+1
        lda lKeeperOptionList
        sta lR20
        lda wCastleMenuOptionIndex,b
        tay
        lda [lR20],y
        and #$00FF
        beq _A177
        cmp #$0001
        beq _A17B
        cmp #$0002
        beq _A17B
        cmp #$0003
        beq _A17F
        cmp #$0004
        beq _A17F
        cmp #$0005
        beq _A17F
        cmp #$00FF
        beq _A177

        _A177
        jml _A180


        _A17B
        jml rsCastleDrawInventoryItemIcons


        _A17F
        rts


        _A180
        ldy #$000E
        lda wCastleListSelectedIndex,b
        sec
        sbc wCastleListWindowRow,b
        clc
        adc #$0007
        asl a
        tax

        _A190
        phx
        phy
        lda aCastleListItemIDs,x
        sta wR0
        txa
        and #$000E
        tay
        lda <>aUnknown8AA1B0,b,y
        tax
        lda wR0
        jsl rlCopyItemIcon
        ply
        plx
        dec x
        dec x
        dec y
        dec y
        bpl _A190
        rts

        .databank 0

      aUnknown8AA1B0 ; 8A/A1B0

        ; Tile positions of the item icons drawn by rsCastleDrawListItemIcons, as the two tables below.
        .word $0050, $0052, $0054, $0056, $0058, $005A, $005C, $005E

      rsCastleDrawTopRowListItemIcon ; 8A/A1C0

        .al
        .xl
        .autsiz
        .databank ?

        lda wCastleListSelectedIndex,b
        sec
        sbc wCastleListWindowRow,b
        asl a
        tax
        lda aCastleListItemIDs,x
        sta wR0
        txa
        and #$000E
        tay
        lda <>aUnknown8AA1DF,b,y
        tax
        lda wR0
        jsl rlCopyItemIcon
        rts

        .databank 0

      aUnknown8AA1DF ; 8A/A1DF

        .word $0050, $0052, $0054, $0056, $0058, $005A, $005C, $005E

      rsCastleDrawBottomRowListItemIcon ; 8A/A1EF

        .al
        .xl
        .autsiz
        .databank ?

        lda wCastleListSelectedIndex,b
        sec
        sbc wCastleListWindowRow,b
        clc
        adc #$0007
        asl a
        tax
        lda aCastleListItemIDs,x
        sta wR0
        txa
        and #$000E
        tay
        lda <>aUnknown8AA212,b,y
        tax
        lda wR0
        jsl rlCopyItemIcon
        rts

        .databank 0

      aUnknown8AA212 ; 8A/A212

        .word $0050, $0052, $0054, $0056, $0058, $005A, $005C, $005E

      rsCastleDrawInventoryItemIcons ; 8A/A222

        .al
        .xl
        .autsiz
        .databank ?

        _A222
        ldx #$000E
        ldy #$0007

        _A228
        phx
        phy
        lda aCastleListItemIconTiles,x
        tax
        tya
        inc a
        jsl rlGetItemIDByInventorySlot
        jsl rlCopyItemIcon
        ply
        plx
        dec x
        dec x
        dec y
        bpl _A228
        rts

        .databank 0

        ; 8A/A241

    .endsection Unsorted8AA142Section


    .section Table8AA241Section

      .al
      .xl

      aCastleListItemIconTiles ; 8A/A241

        ; Read by rsCastleDrawListItemIcons.

        .word $0050, $0052, $0054, $0056, $0058, $005A, $005C, $005E

        ; 8A/A251

    .endsection Table8AA241Section


    .section Unsorted8AA251Section

      .al
      .xl

      rlLoadItemIconGraphics ; 8A/A251

        .al
        .xl
        .autsiz
        .databank ?

        lda wCurrentItemDataROMPointer,b
        beq _A2CA
        jsl rlGetItemEquipmentType
        cmp #$0000
        bne _A279
        lda #(`g4bppItemIcons)<<8
        sta lR18+1
        lda #<>g4bppItemIcons
        sta lR18
        jsl rlGetItemWeaponType
        asl a
        tay
        lda <>aUnknown8AA2CB,b,y
        clc
        adc lR18
        sta lR18
        bra _A292


        _A279
        lda #(`g4bppItemIcons)<<8
        sta lR18+1
        lda #<>g4bppItemIcons
        sta lR18
        lda #$0000
        asl a
        tay
        lda <>aUnknown8AA2DB,b,y
        clc
        adc lR18
        sta lR18
        bra _A292


        _A292
        lda #$0040
        sta wR0
        lda wTempVariable1,b
        tay
        lda <>aUnknown8AA2DD,b,y
        clc
        adc #$6500
        sta wR1
        phx
        jsl rlDMAByPointer
        plx
        lda lR18
        clc
        adc #$0200
        sta lR18
        lda #$0040
        sta wR0
        lda wTempVariable1,b
        tay
        lda <>aUnknown8AA2DD,b,y
        clc
        adc #$6600
        sta wR1
        phx
        jsl rlDMAByPointer
        plx

        _A2CA
        rtl

        .databank 0

        ; 8A/A2CB


      aUnknown8AA2CB ; 8A/A2CB

        .word $0000, $05C0, $0D80, $0C00, $1540, $1580, $1800, $1880

      aUnknown8AA2DB ; 8A/A2DB

        .word $29C0

      aUnknown8AA2DD ; 8A/A2DD

        .word $0000, $0020, $0040, $0060, $0080, $00A0, $00C0, $00E0

        ; 8A/A2ED

    .endsection Unsorted8AA251Section


    .section Unsorted8AA2EDSection

      .al
      .xl

      rsDrawCastleUnitMoney ; 8A/A2ED

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$2800
        sta aCurrentTilemapInfo,b
        lda #(`aCastleMoneyGText)<<8
        sta lRoutineVariable+1,b
        lda #<>aCastleMoneyGText
        sta lRoutineVariable,b
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$1902
        jsl rlDrawMenuTextLine
        jsl rlGetSelectedUnitMoney
        ldx #$0646
        jsl rlDrawCastleNumber
        rts

        .databank 0

        ; 8A/A31C

    .endsection Unsorted8AA2EDSection


    .section Table8AA31CSection

      .al
      .xl

      aCastleMoneyGText ; 8A/A31C

        .enc "SJIS"
        .text "Ｇ"
        .word $0000
        .enc "none"

      aCastleListBlankLineText ; 8A/A320

        .enc "SJIS"
        .text "　　　　　　　　　　　　　　　　　　　"
        .word $0000
        .enc "none"

      aCastleYesNoText ; 8A/A348

        .enc "SJIS"
        .text "　はい　　　いいえ　　　　　　　　　　"
        .word $0000
        .enc "none"


      rsCastleOptionMenuInputOld ; 8A/A370

        .al
        .xl
        .autsiz
        .databank ?

        lda wJoy1New
        bit #$0200
        bne _A39B
        bit #$0100
        bne _A3B7

        _A37C
        lda wCastleMenuOptionIndex,b
        tax
        lda aUnknown8AA3FC,x
        and #$00FF
        sec
        sbc #$000D
        sta wR0
        lda #$0020
        clc
        adc #$0004
        clc
        adc #$0008
        sta wR1
        rts


        _A39B
        lda wCastleMenuOptionIndex,b
        beq _A37C
        sec
        sbc #$0001
        sta wCastleMenuOptionIndex,b
        lda #$0007
        jsl rlPlaySoundEffect
        lda #$FFFF
        sta wCastleRedrawIcons
        bra _A3D6


        _A3B7
        lda wCastleMenuOptionIndex,b
        cmp #$0003
        bcs _A37C
        clc
        adc #$0001
        sta wCastleMenuOptionIndex,b
        lda #$0007
        jsl rlPlaySoundEffect
        lda #$FFFF
        sta wCastleRedrawIcons
        bra _A3D6


        _A3D6
        lda wCastleMenuOptionIndex,b
        cmp #$0001
        beq _A3ED
        cmp #$0002
        beq _A3F2
        cmp #$0003
        beq _A3F7
        jsr rsDrawStockList
        bra _A37C


        _A3ED
        jsr rsDrawInventoryWithSellPrices
        bra _A37C


        _A3F2
        jsr rsDrawInventoryWithRepairCosts
        bra _A37C


        _A3F7
        jsr rsClearCastleList
        bra _A37C

        .databank 0

        ; 8A/A3FC

      aUnknown8AA3FC ; 8A/A3FC
        .byte $58, $78, $98, $C8

    .endsection Table8AA31CSection


    .section Unsorted8AA400Section

      .al
      .xl

      rsCastleStockListInput ; 8A/A400

        .al
        .xl
        .autsiz
        .databank ?

        lda wJoy1Repeated
        bit #$0800
        bne _A40D
        bit #$0400
        bne _A432
        rts


        _A40D
        lda wCastleListSelectedIndex,b
        sta wR0
        beq _A45D
        sec
        sbc #$0001
        sta wCastleListSelectedIndex,b
        lda #$0006
        jsl rlPlaySoundEffect
        lda wCastleListWindowRow,b
        sta wR1
        beq _A464
        sec
        sbc #$0001
        sta wCastleListWindowRow,b
        bra _A464


        _A432
        lda wCastleListSelectedIndex,b
        sta wR0
        clc
        adc #$0001
        cmp wCastleListItemCount,b
        bcs _A45D
        sta wCastleListSelectedIndex,b
        lda #$0006
        jsl rlPlaySoundEffect
        lda wCastleListWindowRow,b
        sta wR1
        cmp #$0007
        bcs _A469
        clc
        adc #$0001
        sta wCastleListWindowRow,b
        bra _A469


        _A45D
        jsr rsDrawStockItemDetails
        jsr rsDrawStockList
        rts


        _A464
        jsr rsCastleDrawTopRowListItemIcon
        bra _A45D


        _A469
        jsr rsCastleDrawBottomRowListItemIcon
        bra _A45D

        .databank 0

        ; 8A/A46E

      rsCastleYesNoInput ; 8A/A46E

        .al
        .xl
        .autsiz
        .databank ?

        lda wJoy1New
        bit #$0200
        bne _A499
        bit #$0100
        bne _A4AE

        _A47A
        lda wCastleConfirmCursorIndex,b
        tax
        lda aUnknown8AA4C6,x
        and #$00FF
        sec
        sbc #$000D
        sta wR0
        lda #$0028
        clc
        adc #$0004
        clc
        adc #$0008
        sta wR1
        rts


        _A499
        lda wCastleConfirmCursorIndex,b
        beq _A47A
        sec
        sbc #$0001
        sta wCastleConfirmCursorIndex,b
        lda #$0007
        jsl rlPlaySoundEffect
        bra _A47A


        _A4AE
        lda wCastleConfirmCursorIndex,b
        cmp #$0001
        bcs _A47A
        clc
        adc #$0001
        sta wCastleConfirmCursorIndex,b
        lda #$0007
        jsl rlPlaySoundEffect
        bra _A47A

        .databank 0

        ; 8A/A4C6

    .endsection Unsorted8AA400Section


    .section Data8AA4C6Section

      .al
      .xl

      aUnknown8AA4C6 ; 8A/A4C6

        ; Read by rsCastleYesNoInput.

        .word $7C54

        ; 8A/A4C8

    .endsection Data8AA4C6Section


    .section Unsorted8AA4C8Section

      .al
      .xl

      rsCastleInventoryListInput ; 8A/A4C8

        .al
        .xl
        .autsiz
        .databank ?

        lda wJoy1Repeated
        bit #$0800
        bne _A4D5
        bit #$0400
        bne _A4FA
        rts


        _A4D5
        lda wCastleListSelectedIndex,b
        sta wR0
        beq _A525
        sec
        sbc #$0001
        sta wCastleListSelectedIndex,b
        lda #$0006
        jsl rlPlaySoundEffect
        lda wCastleListWindowRow,b
        sta wR1
        beq _A52C
        sec
        sbc #$0001
        sta wCastleListWindowRow,b
        bra _A52C


        _A4FA
        lda wCastleListSelectedIndex,b
        sta wR0
        clc
        adc #$0001
        cmp wCastleListSubCount,b
        bcs _A525
        sta wCastleListSelectedIndex,b
        lda #$0006
        jsl rlPlaySoundEffect
        lda wCastleListWindowRow,b
        sta wR1
        cmp #$0007
        bcs _A52E
        clc
        adc #$0001
        sta wCastleListWindowRow,b
        bra _A52E


        _A525
        jsr rlDrawInventoryItemDetails
        jsr rsDrawInventoryWithSellPrices
        rts


        _A52C
        bra _A525


        _A52E
        bra _A525

        .databank 0

        ; 8A/A530

      rsCastleRepairListInput ; 8A/A530

        .al
        .xl
        .autsiz
        .databank ?

        lda wJoy1Repeated
        bit #$0800
        bne _A53D
        bit #$0400
        bne _A562
        rts


        _A53D
        lda wCastleListSelectedIndex,b
        sta wR0
        beq _A58D
        sec
        sbc #$0001
        sta wCastleListSelectedIndex,b
        lda #$0006
        jsl rlPlaySoundEffect
        lda wCastleListWindowRow,b
        sta wR1
        beq _A594
        sec
        sbc #$0001
        sta wCastleListWindowRow,b
        bra _A594


        _A562
        lda wCastleListSelectedIndex,b
        sta wR0
        clc
        adc #$0001
        cmp wCastleListSubCount,b
        bcs _A58D
        sta wCastleListSelectedIndex,b
        lda #$0006
        jsl rlPlaySoundEffect
        lda wCastleListWindowRow,b
        sta wR1
        cmp #$0007
        bcs _A596
        clc
        adc #$0001
        sta wCastleListWindowRow,b
        bra _A596


        _A58D
        jsr rlDrawInventoryItemDetails
        jsr rsDrawInventoryWithRepairCosts
        rts


        _A594
        bra _A58D


        _A596
        bra _A58D

        .databank 0

        ; 8A/A598

      rsAuguryTopicInput ; 8A/A598

        .al
        .xl
        .autsiz
        .databank ?

        lda wJoy1Repeated
        bit #$0800
        bne _A5A5
        bit #$0400
        bne _A5CA
        rts


        _A5A5
        lda wCastleListSelectedIndex,b
        sta wR0
        beq _A5F7
        sec
        sbc #$0001
        sta wCastleListSelectedIndex,b
        lda #$0006
        jsl rlPlaySoundEffect
        lda wCastleListWindowRow,b
        sta wR1
        beq _A5FB
        sec
        sbc #$0001
        sta wCastleListWindowRow,b
        bra _A5FB


        _A5CA
        lda wCastleListSelectedIndex,b
        sta wR0
        cmp wAuguryLastTopic
        bcs _A5F7
        clc
        adc #$0001
        sta wCastleListSelectedIndex,b
        lda #$0006
        jsl rlPlaySoundEffect
        lda wCastleListWindowRow,b
        sta wR1
        cmp wAuguryLastTopic
        bcs _A5FD
        clc
        adc #$0001
        sta wCastleListWindowRow,b
        bra _A5FD


        _A5F7
        jsr rsDrawAuguryTopics
        rts


        _A5FB
        bra _A5F7


        _A5FD
        bra _A5F7

        .databank 0

        ; 8A/A5FF

    .endsection Unsorted8AA4C8Section


    .section Unsorted8AA5FFSection

      .al
      .xl

      rlDrawWeaponRankTiles ; 8A/A5FF

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws the two tiles for weapon rank A at column X, row Y of the BG3 tilemap.

        pha
        tya
        asl a
        asl a
        asl a
        asl a
        asl a
        asl a
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
        phx
        lda aWeaponRankTiles,x
        tyx
        sta aBG3TilemapBuffer,x
        txy
        plx
        lda aWeaponRankTiles+2,x
        tyx
        sta $7E83C8,x
        rtl

        .databank 0

        ; 8A/A629

    .endsection Unsorted8AA5FFSection


    .section Data8AA629Section

      .al
      .xl

      aWeaponRankTiles ; 8A/A629

        ; Read by rlDrawWeaponRankTiles.

        .word $25E4, $25F4, $252A, $253A, $252B, $253B, $252C, $253C
        .word $24FF, $2509

        ; 8A/A63D

    .endsection Data8AA629Section


    .section Unsorted8AA63DSection

      .al
      .xl

      rsDrawStockItemDetails ; 8A/A63D

        .al
        .xl
        .autsiz
        .databank ?

        lda wCastleListItemCount,b
        beq _A6AE
        lda wCastleListSelectedIndex,b
        asl a
        tax
        lda aCastleListItemROMPointers,x
        sta wCurrentItemDataROMPointer,b
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda #(`aCastleMenuTilemapData)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aCastleMenuTilemapData
        sta lMapMenuTilemapRAMEntryPointer,b
        jsl rlGetItemEquipmentType
        cmp #$0001
        beq _A68F
        cmp #$0000
        beq _A6B2
        lda #(`aStockItemDetailsBlankText)<<8
        sta lRoutineVariable+1,b
        lda #<>aStockItemDetailsBlankText
        sta lRoutineVariable,b
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$0A00
        jsl rlDrawMenuTextLine
        jml rsDrawItemDescription


        _A68F
        ldx #$0282
        lda #$0002
        ldy #$0008
        jsr rsCopyBG3RectFromTemplate
        jsl rlGetItemWeaponRank
        ldx #$0008
        ldy #$000A
        inc a
        jsl rlDrawWeaponRankTiles
        jml rsDrawItemDescription


        _A6AE
        jml rsClearItemDetailsWindow


        _A6B2
        jml rsDrawWeaponStats

        .databank 0

      aStockItemDetailsBlankText ; 8A/A6B6

        ; Nine full-width spaces: blanks the line.
        .enc "SJIS"
        .text "　　　　　　　　　\n"

        .databank 0

        ; 8A/A6CA

    .endsection Unsorted8AA63DSection


    .section Unsorted8AA6CASection

      .al
      .xl

      rsDrawWeaponStats ; 8A/A6CA

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Draws a weapon's rank, hit, might, range, weight and description.

        ldx #$0282
        lda #$000A
        ldy #$0008
        jsr rsCopyBG3RectFromTemplate
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda #(`aCastleMenuTilemapData)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aCastleMenuTilemapData
        sta lMapMenuTilemapRAMEntryPointer,b
        jsl rlGetItemWeaponRank
        ldx #$0008
        ldy #$000A
        inc a
        jsl rlDrawWeaponRankTiles
        jsl rlGetItemAccuracy
        ldx #$2520
        stx wR5
        ldx #$0000
        stx wR6
        ldx #$030C
        jsl rlDrawMenuTextNumber
        jsl rlGetItemMight
        ldx #$24F0
        stx aCurrentTilemapInfo,b
        ldx #$0E06
        jsl rlDrawTallTwoDigitNumberToTilemapEntry
        jsl rlGetItemMinimumRange
        ldx #$2520
        stx wR5
        ldx #$0001
        stx wR6
        ldx #$040C
        jsl rlDrawMenuTextNumber
        jsl rlGetItemMaximumRange
        ldx #$2520
        stx wR5
        ldx #$0000
        stx wR6
        ldx #$0410
        jsl rlDrawMenuTextNumber
        jsl rlGetItemWeight
        ldx #$24F0
        stx aCurrentTilemapInfo,b
        ldx #$1206
        jsl rlDrawTallTwoDigitNumberToTilemapEntry
        lda #(`aWeaponStatsBlankText)<<8
        sta lRoutineVariable+1,b
        lda #<>aWeaponStatsBlankText
        sta lRoutineVariable,b
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$1400
        jsl rlDrawMenuTextLine
        lda #(`aWeaponStatsBlankText)<<8
        sta lRoutineVariable+1,b
        lda #<>aWeaponStatsBlankText
        sta lRoutineVariable,b
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$1600
        jsl rlDrawMenuTextLine
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda #(`aCastleMenuTilemapData)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aCastleMenuTilemapData
        sta lMapMenuTilemapRAMEntryPointer,b
        jsl rlGetItemDescriptionPointer
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$1501
        jsl rlDrawMenuTextLine
        lda #$2400
        sta aCurrentTilemapInfo,b
        lda #(`aWeaponStatsDashText)<<8
        sta lRoutineVariable+1,b
        lda #<>aWeaponStatsDashText
        sta lRoutineVariable,b
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$1007
        jsl rlDrawMenuTextLine
        rts

        .databank 0

        ; 8A/A7DD

    .endsection Unsorted8AA6CASection


    .section Table8AA7DDSection

      .al
      .xl

      aWeaponStatsBlankText ; 8A/A7DD

        .enc "SJIS"
        .text "　　　　　　　　　"
        .word $0000
        .enc "none"

      aWeaponStatsDashText ; 8A/A7F1

        .enc "SJIS"
        .text "ー"
        .word $0000
        .enc "none"


      aUnknown8AA7F5 ; 8A/A7F5
        .word <>rsCastleSetRankStringA, <>rsCastleSetRankStringB, <>rsCastleSetRankStringC, <>rsCastleSetRankStringA

      rsCastleSetRankStringA ; 8A/A7FD

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aCastleRankAText)<<8
        sta lRoutineVariable+1,b
        lda #<>aCastleRankAText
        sta lRoutineVariable,b
        rts

        .databank 0

        ; 8A/A80A

      rsCastleSetRankStringB ; 8A/A80A

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aCastleRankBText)<<8
        sta lRoutineVariable+1,b
        lda #<>aCastleRankBText
        sta lRoutineVariable,b
        rts

        .databank 0

        ; 8A/A817

      rsCastleSetRankStringC ; 8A/A817

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aCastleRankCText)<<8
        sta lRoutineVariable+1,b
        lda #<>aCastleRankCText
        sta lRoutineVariable,b
        rts

        .databank 0

        ; 8A/A824

      aCastleRankAText ; 8A/A824

        .enc "SJIS"
        .text "Ａ"
        .word $0000
        .enc "none"

      aCastleRankBText ; 8A/A828

        .enc "SJIS"
        .text "Ｂ"
        .word $0000
        .enc "none"

      aCastleRankCText ; 8A/A82C

        .enc "SJIS"
        .text "Ｃ"
        .word $0000
        .enc "none"


    .endsection Table8AA7DDSection


    .section Unsorted8AA830Section

      .al
      .xl

      rsClearItemDetailsWindow ; 8A/A830

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0282
        lda #$000E
        ldy #$0008
        jsr rsClearBG3Rect
        rts

        .databank 0

        ; 8A/A83D

    .endsection Unsorted8AA830Section


    .section Unsorted8AA83DSection

      .al
      .xl

      rlDrawInventoryItemDetails ; 8A/A83D

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda wCastleListSelectedIndex,b
        inc a
        sta wRoutineVariable1,b
        jsl rlGetItemROMDataByInventorySlot
        lda wCurrentItemDataROMPointer,b
        beq _A8AD
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda #(`aCastleMenuTilemapData)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aCastleMenuTilemapData
        sta lMapMenuTilemapRAMEntryPointer,b
        jsl rlGetItemEquipmentType
        cmp #$0001
        beq _A88E
        cmp #$0000
        beq _A8B1
        lda #(`aInventoryItemDetailsBlankText)<<8
        sta lRoutineVariable+1,b
        lda #<>aInventoryItemDetailsBlankText
        sta lRoutineVariable,b
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$0A00
        jsl rlDrawMenuTextLine
        jml rsDrawItemDescription


        _A88E
        ldx #$0282
        lda #$0002
        ldy #$0008
        jsr rsCopyBG3RectFromTemplate
        jsl rlGetItemWeaponRank
        ldx #$0008
        ldy #$000A
        inc a
        jsl rlDrawWeaponRankTiles
        jml rsDrawItemDescription


        _A8AD
        jml rsClearItemDetailsWindow


        _A8B1
        jml rsDrawWeaponStats

        .databank 0

        ; 8A/A8B5

    .endsection Unsorted8AA83DSection


    .section Table8AA8B5Section

      .al
      .xl

      aInventoryItemDetailsBlankText ; 8A/A8B5

        .enc "SJIS"
        .text "　　　　　　　　　"
        .word $0000
        .enc "none"


    .endsection Table8AA8B5Section


    .section Unsorted8AA8C9Section

      .al
      .xl

      rsPushStockItemTypeIcon ; 8A/A8C9

        .al
        .xl
        .autsiz
        .databank ?

        lda wCastleListItemCount,b
        beq _A916
        lda wCastleListSelectedIndex,b
        asl a
        tax
        lda aCastleListItemROMPointers,x
        sta wCurrentItemDataROMPointer,b
        jsl rlGetItemEquipmentType
        cmp #$0001
        beq _A8E8
        cmp #$0000
        bne _A916

        _A8E8
        jsl rlGetItemWeaponType
        tax
        sep #$20
        lda #$8A
        pha
        plb
        .databank $8A
        rep #$20
        ldy #$A921
        lda #$0030
        sta wR0
        lda #$0050
        sta wR1
        lda @l aCastleStockItemTypeIconTiles,x
        and #$00FF
        sta wR4
        lda #$0000
        sta wR5
        phx
        jsl rlPushToOAMBuffer
        plx

        _A916
        rts

        .databank 0

        ; 8A/A917

    .endsection Unsorted8AA8C9Section


    .section Data8AA917Section

      .al
      .xl

      aCastleStockItemTypeIconTiles ; 8A/A917

        ; Read by rsPushStockItemTypeIcon.

        .byte $00, $02, $04, $06, $08, $0A, $0C, $0E, $20, $22, $01, $00, $00, $C2, $00, $B0
        .byte $34

        ; 8A/A928

    .endsection Data8AA917Section


    .section Unsorted8AA928Section

      .al
      .xl

      rsPushInventoryItemTypeIcon ; 8A/A928

        .al
        .xl
        .autsiz
        .databank ?

        lda wCastleListSelectedIndex,b
        inc a
        sta wRoutineVariable1,b
        jsl rlGetItemROMDataByInventorySlot
        lda wCurrentItemDataROMPointer,b
        beq _A974
        jsl rlGetItemEquipmentType
        cmp #$0001
        beq _A946
        cmp #$0000
        bne _A974

        _A946
        jsl rlGetItemWeaponType
        tax
        sep #$20
        lda #$8A
        pha
        plb
        .databank $8A
        rep #$20
        ldy #$A921
        lda #$0030
        sta wR0
        lda #$0050
        sta wR1
        lda @l aCastleInventoryItemTypeIconTiles,x
        and #$00FF
        sta wR4
        lda #$0000
        sta wR5
        phx
        jsl rlPushToOAMBuffer
        plx

        _A974
        rts

        .databank 0

        ; 8A/A975

    .endsection Unsorted8AA928Section


    .section Data8AA975Section

      .al
      .xl

      aCastleInventoryItemTypeIconTiles ; 8A/A975

        ; Read by rsPushInventoryItemTypeIcon.

        .word $0200, $0604, $0A08, $0E0C, $2220

        ; 8A/A97F

    .endsection Data8AA975Section


    .section Unsorted8AA97FSection

      .al
      .xl

      rsClearBG3Rect ; 8A/A97F

        .al
        .xl
        .autsiz
        .databank ?

        ; Fills a rectangle of the BG3 tilemap with $00FF: X start, Y width in tiles, A height in rows.

        stx wR0
        sty wR1
        sty wR3
        sta wR2

        _A987
        lda #$00FF
        sta aBG3TilemapBuffer,x
        inc x
        inc x
        dec wR1
        bne _A987
        lda wR0
        clc
        adc #$0040
        sta wR0
        tax
        lda wR3
        sta wR1
        dec wR2
        bne _A987
        rts

        .databank 0

        ; 8A/A9A6

    .endsection Unsorted8AA97FSection


    .section Unsorted8AA9A6Section

      .al
      .xl

      rsCopyBG3RectFromTemplate ; 8A/A9A6

        .al
        .xl
        .autsiz
        .databank ?

        ; Copies a rectangle of the BG3 tilemap from aCastleListBG3Template: X start, Y width in tiles, A height in rows.

        stx wR0
        sty wR1
        sty wR3
        sta wR2

        _A9AE
        lda aCastleListBG3Template,x
        sta aBG3TilemapBuffer,x
        inc x
        inc x
        dec wR1
        bne _A9AE
        lda wR0
        clc
        adc #$0040
        sta wR0
        tax
        lda wR3
        sta wR1
        dec wR2
        bne _A9AE
        rts

        .databank 0

        ; 8A/A9CE

    .endsection Unsorted8AA9A6Section


    .section Unsorted8AA9CESection

      .al
      .xl

      rsDrawStockList ; 8A/A9CE

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$2000
        sta aCurrentTilemapInfo,b
        ldy #$000E
        lda wCastleListSelectedIndex,b
        sec
        sbc wCastleListWindowRow,b
        clc
        adc #$0007
        asl a
        tax

        _A9E4
        txa
        lsr a
        cmp wCastleListItemCount,b
        bcs _AA0F
        lda aCastleListItemUnavailable,x
        bmi _A9F9
        lda #$2000
        sta aCurrentTilemapInfo,b
        bra _A9FF


        _A9F9
        lda #$2C00
        sta aCurrentTilemapInfo,b

        _A9FF
        jsr rsDrawStockListRowPrice
        jsr rsDrawStockListRowDurability
        jsr rsDrawStockListRowName

        _AA08
        dec x
        dec x
        dec y
        dec y
        bpl _A9E4
        rts


        _AA0F
        lda #(`aCastleListBlankLineText)<<8
        sta lR18+1
        lda #<>aCastleListBlankLineText
        sta lR18
        phx
        lda $AA2A,b,y
        xba
        clc
        adc #$000D
        tax
        jsl rlDrawMenuTextLine
        plx
        bra _AA08

        .databank 0

        ; 8A/AA2A


      aUnknown8AAA2A ; 8A/AA2A

        .word $000A, $000C, $000E, $0010, $0012, $0014, $0016, $0018

    .endsection Unsorted8AA9CESection


    .section Unsorted8AAA3ASection

      .al
      .xl

      rsDrawStockListRowName ; 8A/AA3A

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aStockListRowNameBlankText)<<8
        sta lR18+1
        lda #<>aStockListRowNameBlankText
        sta lR18
        phx
        lda $AA2A,b,y
        xba
        clc
        adc #$000D
        tax
        jsl rlDrawMenuTextLine
        plx
        lda aCastleListItemROMPointers,x
        sta wCurrentItemDataROMPointer,b
        jsl rlGetItemNamePointer
        lda lRoutineVariable+1,b
        sta lR18+1
        lda lRoutineVariable,b
        sta lR18
        phx
        lda $AA2A,b,y
        xba
        clc
        adc #$000D
        tax
        jsl rlDrawMenuTextLine
        plx
        rts

        .databank 0

        ; 8A/AA78

    .endsection Unsorted8AAA3ASection


    .section Table8AAA78Section

      .al
      .xl

      aStockListRowNameBlankText ; 8A/AA78

        .enc "SJIS"
        .text "　　　　　　　　"
        .word $0000
        .enc "none"


    .endsection Table8AAA78Section


    .section Unsorted8AAA8ASection

      .al
      .xl

      rsDrawStockListRowPrice ; 8A/AA8A

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws a stock item's price, halved with Bargain; no price for keepers 3, 4 and 7.

        lda wKeeper
        cmp #KEEPER_DEPOT
        beq _AAE6
        cmp #$0004
        beq _AAE6
        cmp #KEEPER_ARENA
        beq _AAE6
        phy
        phx
        lda aCastleListItemRAMPointers,x
        sta wCurrentItemDataRAMPointer,b
        jsl rlGetItemBuyPrice
        sta wTempVariable1,b
        plx
        ply
        jsl rlCheckUnitHasBargain
        bcc _AABC
        lda wTempVariable1,b
        lsr a
        sta wTempVariable1,b

        _AABC
        phx
        lda $AA2A,b,y
        xba
        lsr a
        lsr a
        clc
        adc #$0032
        tax
        lda wTempVariable1,b
        jsl rlDrawCastleNumber
        plx
        rts

        .byte $DA, $B9, $2A, $AA, $EB, $4A, $4A, $18, $69, $32, $00, $AA, $AD, $8C, $07, $4A
        .byte $22, $11, $B1, $8A, $FA


        _AAE6
        rts

        .databank 0

        ; 8A/AAE7

      rsDrawStockListRowDurability ; 8A/AAE7

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda aCastleListItemRAMPointers,x
        sta wCurrentItemDataRAMPointer,b
        jsl rlGetItemCurrentDurability
        sta wR0
        plx
        ply
        lda aCastleListItemROMPointers,x
        sta wCurrentItemDataROMPointer,b
        phy
        phx
        jsl rlGetItemEquipmentType
        plx
        ply
        cmp #$0002
        beq _AB20
        phx
        lda $AA2A,b,y
        xba
        lsr a
        lsr a
        clc
        adc #$0026
        tax
        lda wR0
        jsl rlDrawCastleNumber
        plx
        rts


        _AB20
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda #(`aStockListRowDurabilityBlankText)<<8
        sta lR18+1
        lda #<>aStockListRowDurabilityBlankText
        sta lR18
        phx
        lda $AA2A,b,y
        xba
        clc
        adc #$0015
        tax
        jsl rlDrawMenuTextLine
        plx
        rts

        .databank 0

        ; 8A/AB40

    .endsection Unsorted8AAA8ASection


    .section Table8AAB40Section

      .al
      .xl

      aStockListRowDurabilityBlankText ; 8A/AB40

        .enc "SJIS"
        .text "　　　"
        .word $0000
        .enc "none"


    .endsection Table8AAB40Section


    .section Unsorted8AAB48Section

      .al
      .xl

      rsDrawInventoryWithSellPrices ; 8A/AB48

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$2000
        sta aCurrentTilemapInfo,b
        stz wCastleListSubCount,b
        ldx #$0007
        ldy #$000E

        _AB57
        txa
        inc a
        sta wRoutineVariable1,b
        jsl rlGetItemROMDataByInventorySlot
        lda wCurrentItemDataROMPointer,b
        beq _AB90
        inc wCastleListSubCount,b
        jsl rlCheckSelectedUnitCanUseItem
        bcc _AB76
        lda #$2000
        sta aCurrentTilemapInfo,b
        bra _AB7C


        _AB76
        lda #$2C00
        sta aCurrentTilemapInfo,b

        _AB7C
        txa
        inc a
        sta wRoutineVariable1,b
        jsr rsDrawInventoryRowSellPrice
        jsr rsDrawInventoryRowDurability
        jsr rsDrawInventoryRowName

        _AB8A
        dec x
        dec y
        dec y
        bpl _AB57
        rts


        _AB90
        lda #(`aCastleListBlankLineText)<<8
        sta lR18+1
        lda #<>aCastleListBlankLineText
        sta lR18
        phx
        lda $AA2A,b,y
        xba
        clc
        adc #$000D
        tax
        jsl rlDrawMenuTextLine
        plx
        bra _AB8A

        .databank 0

        ; 8A/ABAB

    .endsection Unsorted8AAB48Section


    .section Unsorted8AABABSection

      .al
      .xl

      rsDrawInventoryRowName ; 8A/ABAB

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aInventoryRowNameBlankText)<<8
        sta lR18+1
        lda #<>aInventoryRowNameBlankText
        sta lR18
        phx
        lda $AA2A,b,y
        xba
        clc
        adc #$000D
        tax
        jsl rlDrawMenuTextLine
        plx
        phx
        phy
        jsl rlGetEffectiveItemROMPointerByItemRAMStructEntry
        ply
        plx
        jsl rlGetItemNamePointer
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        phx
        lda $AA2A,b,y
        xba
        clc
        adc #$000D
        tax
        jsl rlDrawMenuTextLine
        plx
        rts

        .databank 0

        ; 8A/ABEA

    .endsection Unsorted8AABABSection


    .section Table8AABEASection

      .al
      .xl

      aInventoryRowNameBlankText ; 8A/ABEA

        .enc "SJIS"
        .text "　　　　　　　　"
        .word $0000
        .enc "none"


    .endsection Table8AABEASection


    .section Unsorted8AABFCSection

      .al
      .xl

      rsDrawInventoryRowSellPrice ; 8A/ABFC

        .al
        .xl
        .autsiz
        .databank ?

        lda wKeeper
        cmp #KEEPER_DEPOT
        beq _AC36
        cmp #KEEPER_ARENA
        beq _AC36
        txa
        inc a
        phx
        phy
        jsl rlGetItemROMDataByInventorySlot
        ply
        plx
        jsl rlGetItemWeaponRank
        ora #$0000
        bmi _AC37
        jsl rlGetInventorySlotItemSellPrice
        sta wR0
        phx
        lda $AA2A,b,y
        xba
        lsr a
        lsr a
        clc
        adc #$0032
        tax
        lda wR0
        jsl rlDrawCastleNumber
        plx

        _AC36
        rts


        _AC37
        lda #(`aCastleListBlankLineText)<<8
        sta lR18+1
        lda #<>aCastleListBlankLineText
        sta lR18
        phx
        lda $AA2A,b,y
        xba
        clc
        adc #$000D
        tax
        jsl rlDrawMenuTextLine
        plx
        rts

        .databank 0

        ; 8A/AC51

      rsDrawInventoryRowDurability ; 8A/AC51

        .al
        .xl
        .autsiz
        .databank ?

        txa
        inc a
        jsl rlGetItemDurabilityOfInventorySlot
        sta wR0
        txa
        inc a
        phy
        phx
        jsl rlGetItemROMDataByInventorySlot
        jsl rlGetItemEquipmentType
        plx
        ply
        cmp #$0002
        beq _AC80
        phx
        lda $AA2A,b,y
        xba
        lsr a
        lsr a
        clc
        adc #$0026
        tax
        lda wR0
        jsl rlDrawCastleNumber
        plx
        rts


        _AC80
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda #(`aInventoryRowDurabilityBlankText)<<8
        sta lR18+1
        lda #<>aInventoryRowDurabilityBlankText
        sta lR18
        phx
        lda $AA2A,b,y
        xba
        clc
        adc #$0015
        tax
        jsl rlDrawMenuTextLine
        plx
        rts

        .databank 0

        ; 8A/ACA0

    .endsection Unsorted8AABFCSection


    .section Table8AACA0Section

      .al
      .xl

      aInventoryRowDurabilityBlankText ; 8A/ACA0

        .enc "SJIS"
        .text "　　　"
        .word $0000
        .enc "none"


    .endsection Table8AACA0Section


    .section Unsorted8AACA8Section

      .al
      .xl

      rsDrawInventoryWithRepairCosts ; 8A/ACA8

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$2000
        sta aCurrentTilemapInfo,b
        stz wCastleListSubCount,b
        ldx #$0007
        ldy #$000E

        _ACB7
        txa
        inc a
        sta wRoutineVariable1,b
        jsl rlGetItemROMDataByInventorySlot
        lda wCurrentItemDataROMPointer,b
        beq _ACEA
        inc wCastleListSubCount,b
        jsr rsDrawInventoryRowRepairCost
        jsr rsDrawInventoryRowDurability
        lda wTempVariable1,b
        beq _ACDB
        lda #$2000
        sta aCurrentTilemapInfo,b
        bra _ACE1


        _ACDB
        lda #$2C00
        sta aCurrentTilemapInfo,b

        _ACE1
        jsr rsDrawInventoryRowName

        _ACE4
        dec x
        dec y
        dec y
        bpl _ACB7
        rts


        _ACEA
        lda #(`aCastleListBlankLineText)<<8
        sta lR18+1
        lda #<>aCastleListBlankLineText
        sta lR18
        phx
        lda $AA2A,b,y
        xba
        clc
        adc #$000D
        tax
        jsl rlDrawMenuTextLine
        plx
        bra _ACE4

        .databank 0

        ; 8A/AD05

    .endsection Unsorted8AACA8Section


    .section Unsorted8AAD05Section

      .al
      .xl

      rsDrawInventoryRowRepairCost ; 8A/AD05

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws an item's repair cost, halved with Bargain.

        lda wRoutineVariable1,b
        jsl rlGetInventorySlotItemRepairCost
        sta wTempVariable1,b
        txa
        inc a
        phy
        phx
        jsl rlGetItemROMDataByInventorySlot
        jsl rlGetItemEquipmentType
        plx
        ply
        cmp #$0002
        beq _AD43
        jsl rlCheckUnitHasBargain
        bcc _AD2F
        lda wTempVariable1,b
        lsr a
        sta wTempVariable1,b

        _AD2F
        phx
        lda $AA2A,b,y
        xba
        lsr a
        lsr a
        clc
        adc #$0032
        tax
        lda wTempVariable1,b
        jsl rlDrawCastleNumber
        plx

        _AD43
        rts

        .databank 0

        ; 8A/AD44

      rsClearCastleList ; 8A/AD44

        .al
        .xl
        .autsiz
        .databank ?

        lda #$2000
        sta aCurrentTilemapInfo,b
        ldx #$0007
        ldy #$000E

        _AD50
        lda #(`aCastleListBlankLineText)<<8
        sta lR18+1
        lda #<>aCastleListBlankLineText
        sta lR18
        phx
        lda $AA2A,b,y
        xba
        clc
        adc #$000D
        tax
        jsl rlDrawMenuTextLine
        plx
        dec x
        dec y
        dec y
        bpl _AD50
        rts

        .databank 0

        ; 8A/AD6F

    .endsection Unsorted8AAD05Section


    .section Unsorted8AAF0ASection

      .al
      .xl

      rsPushCastleListSprites ; 8A/AF0A

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws the sprites for the list of the option under the cursor (item icons for the stock list; rsPushInventoryListSprites for the inventory lists).

        lda lKeeperOptionList+1
        sta lR20+1
        lda lKeeperOptionList
        sta lR20
        lda wCastleMenuOptionIndex,b
        tay
        lda [lR20],y
        and #$00FF
        beq _AF3F
        cmp #$0001
        beq _AF43
        cmp #$0002
        beq _AF43
        cmp #$0003
        beq _AF4F
        cmp #$0004
        beq _AF4F
        cmp #$0005
        beq _AF4F
        cmp #$00FF
        beq _AF3F

        _AF3F
        jml _AF50


        _AF43
        lda wCastleListItemState,b
        cmp #$0003
        beq _AF4F
        jml rsPushInventoryListSprites


        _AF4F
        rts


        _AF50
        ldy #$0007
        sep #$20
        lda #$8A
        pha
        plb
        .databank $8A
        rep #$20
        lda wCastleListSelectedIndex,b
        sec
        sbc wCastleListWindowRow,b
        and #$0007
        clc
        adc #$0007
        tax
        lda wCastleListSelectedIndex,b
        sec
        sbc wCastleListWindowRow,b
        sta wR0
        clc
        adc #$0007
        cmp wCastleListItemCount,b
        bcs _AF7E
        bra _AF98


        _AF7E
        lda wCastleListItemCount,b
        sec
        sbc wR0
        dec a
        and #$0007
        tay
        sta wR0
        lda #$0007
        sec
        sbc wR0
        sta wR0
        txa
        sec
        sbc wR0
        tax

        _AF98
        cpy wCastleListItemCount,b
        bcs _AFC7
        lda #$0058
        sta wR0
        lda <>aUnknown8AAFCC,b,y
        and #$00FF
        clc
        adc #$0050
        sta wR1
        lda @l aUnknown8AAFD4,x
        and #$00FF
        sta wR4
        lda #$3200
        sta wR5
        phx
        phy
        ldy #<>aUnknown8AAFE4
        jsl rlPushToOAMBuffer
        ply
        plx

        _AFC7
        dec x
        dec y
        bpl _AF98
        rts

        .databank 0

      aUnknown8AAFCC ; 8A/AFCC
        .byte $00, $10, $20, $30, $40, $50, $60, $70

      aUnknown8AAFD4 ; 8A/AFD4
        .byte $20, $22, $24, $26, $28, $2A, $2C, $2E
        .byte $20, $22, $24, $26, $28, $2A, $2C, $2E

      aUnknown8AAFE4 ; 8A/AFE4
        .byte $01, $00, $00, $C2, $00, $30, $32

      rsPushInventoryListSprites ; 8A/AFEB

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0007
        ldy #$0007
        sep #$20
        lda #$8A
        pha
        plb
        .databank $8A
        rep #$20

        _AFF9
        txa
        inc a
        jsl rlGetItemROMDataByInventorySlot
        lda wCurrentItemDataROMPointer,b
        beq _B02E
        lda #$0058
        sta wR0
        lda $B033,b,y
        and #$00FF
        clc
        adc #$0050
        sta wR1
        lda @l aUnknown8AB03B,x
        and #$00FF
        sta wR4
        lda #$3200
        sta wR5
        phx
        phy
        ldy #<>aUnknown8AAFE4
        jsl rlPushToOAMBuffer
        ply
        plx

        _B02E
        dec x
        dec y
        bpl _AFF9
        rts

        .databank 0

        ; 8A/B033

    .endsection Unsorted8AAF0ASection


    .section Data8AB033Section

      .al
      .xl

      aUnknown8AB033 ; 8A/B033

        ; Read by rsPushCastleListSprites.

        .word $1000, $3020, $5040, $7060

        ; 8A/B03B

      aUnknown8AB03B ; 8A/B03B

        ; Read by rsPushCastleListSprites.

        .word $2220, $2624, $2A28, $2E2C

        ; 8A/B043

    .endsection Data8AB033Section


    .section Unsorted8AB043Section

      .al
      .xl

      rlPushCastleHandCursor ; 8A/B043

        .al
        .xl
        .autsiz
        .databank ?

        phb
        phx
        phy
        cmp #$0000
        beq _B04F
        lda wR0
        bra _B05D


        _B04F
        lda wVBlankEnabledFramecount
        and #$001C
        lsr a
        tax
        lda aCastleHandCursorOffsets,x
        clc
        adc wR0

        _B05D
        sta wR0
        sep #$20
        lda #$8A
        pha
        plb
        .databank $8A
        rep #$20
        ldy #$B08C
        lda #$0000
        sta wR4
        lda #$2000
        sta wR5
        jsl rlPushToOAMBuffer
        ply
        plx
        plb
        .databank $8A
        rtl

        .databank 0

        ; 8A/B07C

    .endsection Unsorted8AB043Section


    .section Data8AB07CSection

      .al
      .xl

      aCastleHandCursorOffsets ; 8A/B07C

        ; Read by rlPushCastleHandCursor.

        .byte $00, $00, $00, $00, $01, $00, $01, $00, $00, $00, $00, $00, $FF, $FF, $FF, $FF
        .byte $01, $00, $00, $C2, $00, $02, $30

        ; 8A/B093

    .endsection Data8AB07CSection


    .section Unsorted8AB093Section

      .al
      .xl

      rlPushStockListScrollArrows ; 8A/B093

        .al
        .xl
        .autsiz
        .databank ?

        phb
        phx
        phy
        lda wR0
        sta wTempVariable1,b
        lda wR1
        sta wTempVariable2,b
        sep #$20
        lda #$8A
        pha
        plb
        .databank $8A
        rep #$20
        lda wCastleListSelectedIndex,b
        cmp #$0008
        bcs _B0B7
        cmp wCastleListWindowRow,b
        bne _B0B7
        bra _B0D2


        _B0B7
        lda #$0098
        sta wR0
        lda #$0048
        sta wR1
        ldy #$B10A
        lda #$0000
        sta wR4
        lda #$A000
        sta wR5
        jsl rlPushToOAMBuffer

        _B0D2
        lda wCastleListItemCount,b
        lda wCastleListSelectedIndex,b
        clc
        adc #$0008
        sec
        sbc wCastleListWindowRow,b
        cmp wCastleListItemCount,b
        bcc _B0E7
        bra _B106


        _B0E7
        lda #$0098
        sta wR0
        lda #$00C8
        clc
        adc #$0006
        sta wR1
        ldy #$B10A
        lda #$0000
        sta wR4
        lda #$2000
        sta wR5
        jsl rlPushToOAMBuffer

        _B106
        ply
        plx
        plb
        .databank $8A
        rtl

        .databank 0

        ; 8A/B10A

      aUnknown8AB10A ; 8A/B10A

        ; Unreferenced.
        .byte $01, $00, $00, $C2, $00, $0C, $30

    .endsection Unsorted8AB093Section


    .section Unsorted8AB111Section

      .al
      .xl

      rlDrawCastleNumber ; 8A/B111

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws A as a number of up to five digits.

        sta wR0
        stz wR1
        stz wR2
        stz wR3
        stz wR4
        stz wR5
        lda wR0
        cmp #$2710
        bcs _B129
        lda #$00CF
        sta wR1

        _B129
        lda wR0
        cmp #$03E8
        bcs _B135
        lda #$00CF
        sta wR2

        _B135
        lda wR0
        cmp #$0064
        bcs _B141
        lda #$00CF
        sta wR3

        _B141
        lda wR0
        cmp #$000A
        bcs _B14D
        lda #$00CF
        sta wR4

        _B14D
        lda wR0
        cmp #$2710
        bcc _B164
        sec
        sbc #$2710
        sta wR0
        lda wR1
        clc
        adc #$0001
        sta wR1
        bra _B14D


        _B164
        lda wR0
        cmp #$03E8
        bcc _B17B
        sec
        sbc #$03E8
        sta wR0
        lda wR2
        clc
        adc #$0001
        sta wR2
        bra _B164


        _B17B
        lda wR0
        cmp #$0064
        bcc _B192
        sec
        sbc #$0064
        sta wR0
        lda wR3
        clc
        adc #$0001
        sta wR3
        bra _B17B


        _B192
        lda wR0
        cmp #$000A
        bcc _B1A9
        sec
        sbc #$000A
        sta wR0
        lda wR4
        clc
        adc #$0001
        sta wR4
        bra _B192


        _B1A9
        lda wR0
        sta wR5
        lda wR1
        clc
        adc #$0120
        ora #$2400
        sta aBG3TilemapBuffer,x
        lda wR1
        clc
        adc #$0130
        ora #$2400
        sta $7E83C8,x
        lda wR2
        clc
        adc #$0120
        ora #$2400
        sta $7E838A,x
        lda wR2
        clc
        adc #$0130
        ora #$2400
        sta $7E83CA,x
        lda wR3
        clc
        adc #$0120
        ora #$2400
        sta $7E838C,x
        lda wR3
        clc
        adc #$0130
        ora #$2400
        sta $7E83CC,x
        lda wR4
        clc
        adc #$0120
        ora #$2400
        sta $7E838E,x
        lda wR4
        clc
        adc #$0130
        ora #$2400
        sta $7E83CE,x
        lda wR5
        clc
        adc #$0120
        ora #$2400
        sta $7E8390,x
        lda wR5
        clc
        adc #$0130
        ora #$2400
        sta $7E83D0,x
        rtl

        .databank 0

        ; 8A/B230

    .endsection Unsorted8AB111Section


    .section Table8AB230Section

      .al
      .xl

      aCastleColorMathHDMAInfo .dstruct structHDMADirectEntryInfo, rlHDMACastleColorMath1, rlHDMACastleColorMath1, $B261, $0008C8, PPU_REG_BASE + $31, $00 ; 8A/B230

    .endsection Table8AB230Section


    .section Unsorted8AB23BSection

      .al
      .xl

      rlHDMACastleColorMath1 ; 8A/B23B

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$48
        sta $08C8,b
        lda #$00
        sta $08C9,b
        lda #$80
        sec
        sbc #$48
        sta $08CA,b
        lda #$82
        sta $08CB,b
        lda #$00
        sta $08CC,b
        lda #$00
        sta $08CD,b
        rep #$20
        rtl

        .databank 0

        ; 8A/B261


      aHDMAUnknown8AB261Code ; 8A/B261

        HDMA_HALT

      aUnknown8AB263 .dstruct structHDMADirectEntryInfo, rlHDMACastleColorMath2, rlHDMACastleColorMath2, aHDMAUnknown8AB294Code, $0008C8, PPU_REG_BASE + $31, DMAP_HDMA_Setting(DMAP_CPUToIO, false, DMAP_Mode0) ; 8A/B263

      rlHDMACastleColorMath2 ; 8A/B26E

              .al
              .xl
              .autsiz
              .databank ?

              sep #$20
              lda #$48
              sta $08C8,b
              lda #$00
              sta $08C9,b
              lda #$80
              sec
              sbc #$48
              sta $08CA,b
              lda #$81
              sta $08CB,b
              lda #$00
              sta $08CC,b
              lda #$00
              sta $08CD,b
              rep #$20
              rtl

              .databank 0

      aHDMAUnknown8AB294Code ; 8A/B294

        HDMA_HALT

      aUnknown8AB296 .dstruct structHDMADirectEntryInfo, rlHDMACastleColorData, rlHDMACastleColorData, aHDMAUnknown8AB2C2Code, $7F80A3, PPU_REG_BASE + $32, DMAP_HDMA_Setting(DMAP_CPUToIO, false, DMAP_Mode0) ; 8A/B296

      rlHDMACastleColorData ; 8A/B2A1

              .al
              .xl
              .autsiz
              .databank ?

              ldx #$0000
              ldy #$0000
              sep #$20

              _B2A9
              lda $B2C4,b,y
              sta $7F80A3,x
              beq _B2BF
              lda $9CAB,b,y
              sta $7F80A4,x
              inc x
              inc x
              inc y
              inc y
              bra _B2A9


              _B2BF
              rep #$20
              rtl

              .databank 0

      aHDMAUnknown8AB2C2Code ; 8A/B2C2

        HDMA_HALT

      aUnknown8AB2C4 ; 8A/B2C4

        .byte $60, $E0, $10, $E1, $10, $E2, $10, $E3, $10, $E4
        .byte $10, $E6, $10, $E7, $10, $E8, $10, $EA, $00, $00

      aUnknown8AB2D8 .dstruct structHDMADirectEntryInfo, rlHDMACastleSubscreenMask, rlHDMACastleSubscreenMask, aHDMAUnknown8AB315Code, $0008C8, PPU_REG_BASE + $2D, DMAP_HDMA_Setting(DMAP_CPUToIO, false, DMAP_Mode0) ; 8A/B2D8

      rlHDMACastleSubscreenMask ; 8A/B2E3

              .al
              .xl
              .autsiz
              .databank ?

              sep #$20
              lda #$48
              sta $08C8,b
              lda #$00
              sta $08C9,b
              lda #$80
              sec
              sbc #$48
              sta $08CA,b
              lda #$02
              sta $08CB,b
              lda #$00
              sta $08CC,b
              lda #$00
              sta $08CD,b
              rep #$20
              lda wGameStateStep,b
              cmp #$0001
              bne _B314
              jsl rlHDMAEngineFreeEntryByOffset

              _B314
              rtl

              .databank 0

      aHDMAUnknown8AB315Code ; 8A/B315

        HDMA_HALT

    .endsection Unsorted8AB23BSection


    .section Unsorted8AD092Section

      .al
      .xl

      rsDrawYesNo ; 8A/D092

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aCastleYesNoText)<<8
        sta lR18+1
        lda #<>aCastleYesNoText
        sta lR18
        lda $18DD,b
        cmp #$0100
        beq _D0AA
        clc
        adc #$0120
        bra _D0AE


        _D0AA
        sec
        sbc #$0040

        _D0AE
        clc
        adc #$000A
        tax
        jsl rlDrawMenuTextLine
        rts

        .databank 0

        ; 8A/D0B8

      rsDrawArenaChoice ; 8A/D0B8

        .al
        .xl
        .autsiz
        .databank ?

        lda $18DD,b
        cmp #$0100
        beq _D0C6
        clc
        adc #$0120
        bra _D0CA


        _D0C6
        sec
        sbc #$0040

        _D0CA
        clc
        adc #$000B
        tax
        jsl rlDrawMenuTextLine
        rts

        .databank 0

        ; 8A/D0D4

    .endsection Unsorted8AD092Section
