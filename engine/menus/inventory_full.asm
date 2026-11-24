; A full inventory: choosing an item to send to the supply.


    .section Unsorted85B14FSection

      .al
      .xl

      rlOpenInventoryFullMenu ; 85/B14F

        .al
        .xl
        .autsiz
        .databank ?

        ; wInput0 = unit RAM pointer whose new item is in slot 8: opens the message, the new item's window and procInventoryFullMenu.

        lda aProcSystem.wInput0,b
        sta wSelectedUnitDataRAMPointer,b
        lda #$0008
        jsl rlGetItemIDByInventorySlot
        jsl rlGetItemDataROMPointer
        lda wCurrentItemDataROMPointer,b
        sta aProcSystem.wInput0,b
        lda wSelectedUnitDataRAMPointer,b
        sta aProcSystem.wInput3,b
        jsl rlOpenInventoryFullNewItem
        jsl rlOpenInventoryFullMessage
        lda wSelectedUnitDataRAMPointer,b
        sta aProcSystem.wInput0,b
        lda wCurrentItemDataROMPointer,b
        sta aProcSystem.wInput1,b
        lda #(`procInventoryFullMenu)<<8
        sta lR44+1
        lda #<>procInventoryFullMenu
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 85/B18F

    .endsection Unsorted85B14FSection


    .section Unsorted85B18FSection

      .al
      .xl

      procInventoryFullMenu .structProcInfo "PW", rlProcInventoryFullMenuInit, rlProcInventoryFullMenuFirstCycle, aProcInventoryFullMenuCode ; 85/B18F

        .long aInventoryFullMenuData
        .byte 1

      aInventoryFullMenuTilemapData ; 85/B19B

        .structMapMenuTilemapData 14, 16, aBG3TilemapBuffer, 0, $7FC54A

      aInventoryFullMenuData ; 85/B1A4

        .long 0, 0, aInventoryFullMenuTilemapData
        .byte 0, 2, 5

    .endsection Unsorted85B18FSection


    .section Unsorted85B1B0Section

      .al
      .xl

      rlProcInventoryFullMenuInit ; 85/B1B0

        .al
        .autsiz
        .databank ?

        ; Lists the eight items (rsInventoryFullMenuGetItems), the new one first; aBody6 = cursor.

        phx
        lda aProcSystem.wInput0,b
        sta aProcSystem.aBody4,b,x
        lda aProcSystem.wInput1,b
        sta aProcSystem.aBody5,b,x
        lda #1
        sta aProcSystem.aBody6,b,x
        jsl rlInitMapMenuProc
        plx
        lda aProcSystem.aBody4,b,x
        sta wSelectedUnitDataRAMPointer,b
        lda aProcSystem.aBody5,b,x
        sta wCurrentItemDataROMPointer,b
        jsr rsInventoryFullMenuGetItems
        bcs +

          lda #$2000
          sta aCurrentTilemapInfo.wBaseTile,b
          jsr rsInventoryFullMenuDrawItems
          jsl rlDrawMapMenu
          jsl rlHideMapMenuLayers
          jsl rlFreeHDMAEntry0

        +
        rtl

        .databank 0

      rlProcInventoryFullMenuFirstCycle ; 85/B1EF

        .al
        .autsiz
        .databank ?

        lda #<>rlProcInventoryFullMenuShow
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

      rlProcInventoryFullMenuShow ; 85/B1F6

        .al
        .autsiz
        .databank ?

        jsr rsInventoryFullMenuLoadIcons
        jsr rsInventoryFullMenuDrawIcons
        jsl rlShowMapMenuLayers
        lda #<>rlProcInventoryFullMenuCycle
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 85/B207

    .endsection Unsorted85B1B0Section


    .section Unsorted85B207Section

      .al
      .xl

      rlProcInventoryFullMenuCycle ; 85/B207

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Up and Down choose (wrapping over 8), A goes on to the confirmation.

        jsr rsInventoryFullMenuDrawIcons
        lda wJoy1New
        bit #$0080
        beq _B220
        lda #$000A
        jsl rlPlaySoundEffect
        lda #<>rlProcInventoryFullMenuHide
        sta aProcSystem.aHeaderOnCycle,b,x
        bra _B254


        _B220
        lda wJoy1Repeated
        bit #$0800
        beq _B239
        lda #$0006
        jsl rlPlaySoundEffect
        lda aProcSystem.aBody6,b,x
        dec a
        bpl _B251
        lda #$0007
        bra _B251


        _B239
        bit #$0400
        beq _B254
        lda #$0006
        jsl rlPlaySoundEffect
        lda aProcSystem.aBody6,b,x
        inc a
        cmp #$0008
        bcc _B251
        lda #$0000

        _B251
        sta aProcSystem.aBody6,b,x

        _B254
        lda #$0100
        sta wR0
        lda #$0010
        sta wR1
        lda aProcSystem.aBody6,b,x
        bne _B264
        dec a

        _B264
        phx
        jsl rlDrawListCursorAtIndex
        plx
        rtl

        .databank 0

        ; 85/B26B

      rlProcInventoryFullMenuHide ; 85/B26B

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsInventoryFullMenuHideWindows
        lda #<>rlProcInventoryFullMenuAsk
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 85/B275

      rlProcInventoryFullMenuAsk ; 85/B275

        .al
        .xl
        .autsiz
        .databank ?

        ; Opens the chosen item's window and "deposit this item?" (procInventoryFullConfirm).

        jsr rsInventoryFullMenuOpenChosenItem
        jsr rsOpenInventoryFullConfirm
        lda #<>rlProcInventoryFullMenuWaitAnswer
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 85/B282

    .endsection Unsorted85B207Section


    .section Unsorted85B282Section

      .al
      .xl

      rlProcInventoryFullMenuWaitAnswer ; 85/B282

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Yes: the item goes to the supply (rlDumpInventorySlotIntoSupplyIfFilled) and everything closes. No or B: back to the list.

        lda wJoy1New
        bit #$0080
        beq _B29F
        lda #$000A
        jsl rlPlaySoundEffect
        jsr rsInventoryFullMenuGetAnswer
        pha
        jsr rsInventoryFullMenuCloseQuestion
        pla
        ora #$0000
        beq _B2BB
        bra _B2B2


        _B29F
        bit #$8000
        beq _B2B0
        lda #$0021
        jsl rlPlaySoundEffect
        jsr rsInventoryFullMenuCloseQuestion
        bra _B2B2


        _B2B0
        bra _B2C9


        _B2B2
        jsr rsInventoryFullMenuShowWindows
        jsl rlHideMapMenuLayers
        bra _B2C3


        _B2BB
        jsr rsInventoryFullMenuDeposit
        jsr rsInventoryFullMenuCloseAll
        bra _B2C9


        _B2C3
        lda #<>rlProcInventoryFullMenuBack
        sta aProcSystem.aHeaderOnCycle,b,x

        _B2C9
        rtl

        .databank 0

        ; 85/B2CA

      rlProcInventoryFullMenuBack ; 85/B2CA

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlShowMapMenuLayers
        jsr rsInventoryFullMenuDrawIcons
        lda #<>rlProcInventoryFullMenuCycle
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 85/B2D8

    .endsection Unsorted85B282Section


    .section ProcScript85B2D8Section

      .al
      .xl

      aProcInventoryFullMenuCode ; 85/B2D8

        PROC_HALT


        ; 85/B2DA

    .endsection ProcScript85B2D8Section


    .section Unsorted85B2DASection

      .al
      .xl

      rsInventoryFullMenuLoadIcons ; 85/B2DA

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda aProcSystem.aBody4,b,x
        sta wSelectedUnitDataRAMPointer,b
        ldy #$0007

        _B2E5
        phy
        tya
        asl a
        and #$000F
        ora #$0040
        tax
        tya
        inc a
        jsl rlGetItemIDByInventorySlot
        jsl rlCopyItemIcon
        lda #$0006
        jsl rlUnitWindowCopySpritePalette1
        ply
        dec y
        bpl _B2E5
        ply
        plx
        rts

        .databank 0

        ; 85/B307

      rsInventoryFullMenuDrawIcons ; 85/B307

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda wR0
        pha
        lda wR1
        pha
        lda wR2
        pha
        jsl rlLoadMapMenuEntryPointerFromProcBody
        jsl rlGetMapMenuPosition
        pha
        and #$FF00
        xba
        asl a
        asl a
        asl a
        clc
        adc #$0008
        sta wR1
        pla
        and #$00FF
        asl a
        asl a
        asl a
        clc
        adc #$0010
        sta wR0
        ldx #$000C
        stz wR4
        stz wR5

        _B33C
        phx
        ldy <>aMapItemListIconSprites,b,x
        jsl rlPushToOAMBuffer
        plx
        dec x
        dec x
        bpl _B33C
        lda wR1
        sec
        sbc #$0020
        sta wR1
        ldx #$000E
        ldy <>aMapItemListIconSprites,b,x
        jsl rlPushToOAMBuffer
        pla
        sta wR2
        pla
        sta wR1
        pla
        sta wR0
        plx
        ply
        rts

        .databank 0

        ; 85/B367

    .endsection Unsorted85B2DASection


    .section Unsorted85B367Section

      .al
      .xl

      rsInventoryFullMenuDeposit ; 85/B367

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Cursor 0 is the new item (slot 8).

        lda aProcSystem.aBody6,b,x
        bne _B36F
        lda #$0008

        _B36F
        sta wSelectedInventorySlot,b
        lda aProcSystem.aBody4,b,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlDumpInventorySlotIntoSupplyIfFilled
        rts

        .databank 0

        ; 85/B37D

    .endsection Unsorted85B367Section


    .section Unsorted85B37DSection

      .al
      .xl

      rsInventoryFullMenuHideWindows ; 85/B37D

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsl rlLoadMapMenuEntryPointerFromProcBody
        jsl rlHideMapMenu
        lda #(`procInventoryFullMessage)<<8
        sta lR44+1
        lda #<>procInventoryFullMessage
        sta lR44
        jsr rsHideProcMapMenu
        lda #(`procInventoryFullNewItem)<<8
        sta lR44+1
        lda #<>procInventoryFullNewItem
        sta lR44
        jsr rsHideProcMapMenu
        plx
        rts

        .databank 0

        ; 85/B3A2

    .endsection Unsorted85B37DSection


    .section Unsorted85B3A2Section

      .al
      .xl

      rsHideProcMapMenu ; 85/B3A2

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; lR44 = proc definition: hides its map menu if the proc exists.

        jsl rlProcEngineFindProc
        bcc _B3B0
        jsl rlLoadMapMenuEntryPointerFromProcBody
        jsl rlHideMapMenu

        _B3B0
        rts

        .databank 0

        ; 85/B3B1

      rsInventoryFullMenuCloseAll ; 85/B3B1

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsl rlLoadMapMenuEntryPointerFromProcBody
        jsl rlCloseMapMenuFromProc
        jsl rlProcEngineFreeProc
        lda #(`procInventoryFullMessage)<<8
        sta lR44+1
        lda #<>procInventoryFullMessage
        sta lR44
        jsr rsCloseProcMapMenu
        lda #(`procInventoryFullNewItem)<<8
        sta lR44+1
        lda #<>procInventoryFullNewItem
        sta lR44
        jsr rsCloseProcMapMenu
        plx
        rts

        .databank 0

        ; 85/B3DA

    .endsection Unsorted85B3A2Section


    .section Unsorted85B3DASection

      .al
      .xl

      rsInventoryFullMenuShowWindows ; 85/B3DA

        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsl rlLoadMapMenuEntryPointerFromProcBody
        jsl rlShowMapMenu
        lda #(`procInventoryFullMessage)<<8
        sta lR44+1
        lda #<>procInventoryFullMessage
        sta lR44
        jsr rsShowProcMapMenu
        lda #(`procInventoryFullNewItem)<<8
        sta lR44+1
        lda #<>procInventoryFullNewItem
        sta lR44
        jsr rsShowProcMapMenu
        plx
        rts

        .databank 0

        ; 85/B3FF

    .endsection Unsorted85B3DASection


    .section Unsorted85B3FFSection

      .al
      .xl

      rsShowProcMapMenu ; 85/B3FF

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; lR44 = proc definition: shows its map menu if the proc exists.

        jsl rlProcEngineFindProc
        bcc _B40D
        jsl rlLoadMapMenuEntryPointerFromProcBody
        jsl rlShowMapMenu

        _B40D
        rts

        .databank 0

        ; 85/B40E

    .endsection Unsorted85B3FFSection


    .section Unsorted85B40ESection

      .al
      .xl

      rsInventoryFullMenuCloseQuestion ; 85/B40E

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #(`procInventoryFullChosenItem)<<8
        sta lR44+1
        lda #<>procInventoryFullChosenItem
        sta lR44
        jsr rsCloseProcMapMenu
        lda #(`procInventoryFullConfirm)<<8
        sta lR44+1
        lda #<>procInventoryFullConfirm
        sta lR44
        jsr rsCloseProcMapMenu
        plx
        rts

        .databank 0

        ; 85/B42B

    .endsection Unsorted85B40ESection


    .section Unsorted85B42BSection

      .al
      .xl

      rsCloseProcMapMenu ; 85/B42B

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; lR44 = proc definition: closes its map menu and frees it if it exists.

        jsl rlProcEngineFindProc
        bcc _B43D
        jsl rlLoadMapMenuEntryPointerFromProcBody
        jsl rlCloseMapMenuFromProc
        jsl rlProcEngineFreeProc

        _B43D
        rts

        .databank 0

        ; 85/B43E

    .endsection Unsorted85B42BSection


    .section Unsorted85B43ESection

      .al
      .xl

      rsInventoryFullMenuGetAnswer ; 85/B43E

        .al
        .xl
        .autsiz
        .databank ?

        ; A = 1 for yes (aBody7 of procInventoryFullConfirm), 0 for no or none.

        phx
        lda #(`procInventoryFullConfirm)<<8
        sta lR44+1
        lda #<>procInventoryFullConfirm
        sta lR44
        jsl rlProcEngineFindProc
        bcc _B457
        lda aProcSystem.aBody7,b,x
        and #$0001
        bra _B45A


        _B457
        lda #$0000

        _B45A
        plx
        rts

        .databank 0

        ; 85/B45C

    .endsection Unsorted85B43ESection


    .section Unsorted85B45CSection

      .al
      .xl

      rsInventoryFullMenuGetItems ; 85/B45C

        .al
        .xl
        .autsiz
        .databank ?

        ; Item ROM pointers at $7FEABA: wCurrentItemDataROMPointer (the new item), then slots 1-7. Carry set if a slot is empty.

        phx
        lda wCurrentItemDataROMPointer,b
        pha
        lda wCurrentItemDataROMPointer,b
        sta $7FEABA
        ldx #$000C

        _B46B
        txa
        lsr a
        inc a
        jsl rlGetItemROMDataByInventorySlot
        lda wCurrentItemDataROMPointer,b
        beq _B486
        sta $7FEABC,x
        dec x
        dec x
        bpl _B46B
        clc

        _B480
        pla
        sta wCurrentItemDataROMPointer,b
        plx
        rts


        _B486
        sec
        bra _B480

        .databank 0

        ; 85/B489

      rsInventoryFullMenuDrawItems ; 85/B489

        .al
        .xl
        .autsiz
        .databank ?

        ; The names, with "Ｅ" by the equipped weapon.

        phx
        phy
        jsl rlGetFirstEquippableWeaponInInventory
        sta wR1
        ldy #$000C
        lda #$0D04
        sta wR0

        _B499
        lda #$2000
        sta aCurrentTilemapInfo,b
        tya
        lsr a
        inc a
        cmp wR1
        bne _B4BB
        lda #(`aInventoryFullMenuEquippedText)<<8
        sta lR18+1
        lda #<>aInventoryFullMenuEquippedText
        sta lR18
        lda wR0
        clc
        adc #$0008
        tax
        jsl rlDrawMapMenuTextLine

        _B4BB
        tyx
        lda $7FEABC,x
        sta wCurrentItemDataROMPointer,b
        jsr rsSetTileBaseForObtainableItem
        jsl rlGetItemNamePointer
        lda lRoutineVariable+1,b
        sta lR18+1
        lda lRoutineVariable,b
        sta lR18
        ldx wR0
        jsl rlDrawMapMenuTextLine
        lda wR0
        sec
        sbc #$0200
        sta wR0
        dec y
        dec y
        bpl _B499
        ply
        plx
        rts

        .databank 0

        ; 85/B4E9

    .endsection Unsorted85B45CSection


    .section Table85B4E9Section

      .al
      .xl

      aInventoryFullMenuEquippedText ; 85/B4E9

        .enc "SJIS"
        .text "Ｅ"
        .word $0000
        .enc "none"


    .endsection Table85B4E9Section


    .section Unsorted85B4EDSection

      .al
      .xl

      rsSetTileBaseForObtainableItem ; 85/B4ED

        .al
        .xl
        .autsiz
        .databank ?

        ; Grey text (tile base $2400) unless rlCheckSelectedUnitCanUseItem.

        jsl rlCheckSelectedUnitCanUseItem
        bcs _B4F9
        lda #$2400
        sta aCurrentTilemapInfo,b

        _B4F9
        rts

        .databank 0

        ; 85/B4FA

      rsInventoryFullMenuOpenChosenItem ; 85/B4FA

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda aProcSystem.aBody6,b,x
        sta aProcSystem.wInput2,b
        asl a
        tax
        lda $7FEABA,x
        sta aProcSystem.wInput0,b
        lda #$0909
        sta aProcSystem.wInput1,b
        lda #(`procInventoryFullChosenItem)<<8
        sta lR44+1
        lda #<>procInventoryFullChosenItem
        sta lR44
        jsl rlProcEngineCreateProc
        plx
        rts

        .databank 0

        ; 85/B520

    .endsection Unsorted85B4EDSection


    .section Unsorted85B520Section

      .al
      .xl

      rlOpenInventoryFullMessage ; 85/B520

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`procInventoryFullMessage)<<8
        sta lR44+1
        lda #<>procInventoryFullMessage
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 85/B52F

      rlOpenInventoryFullNewItem ; 85/B52F

        .al
        .xl
        .autsiz
        .databank ?

        lda #$FFFF
        sta aProcSystem.wInput1,b
        sta aProcSystem.wInput2,b
        lda #(`procInventoryFullNewItem)<<8
        sta lR44+1
        lda #<>procInventoryFullNewItem
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 85/B547

    .endsection Unsorted85B520Section


    .section Table85B547Section

      .al
      .xl

      procInventoryFullConfirm ; 85/B547
        .structProcInfo "PW", rlProcInventoryFullConfirmInit, rlProcInventoryFullConfirmCycle, aProcInventoryFullConfirmCode
        .long aInventoryFullConfirmData
        .byte $01

      aInventoryFullConfirmTilemapData ; 85/B553
        .byte $10, $06, $88, $83, $7E, $00, $4A, $C7, $7F

      aInventoryFullConfirmData ; 85/B55C
        .long $000000
        .long $000000
        .long aInventoryFullConfirmTilemapData
        .byte $00, $08, $0F

      rlProcInventoryFullConfirmInit ; 85/B568

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlInitMapMenuProc
        lda #$0000
        sta aProcSystem.aBody7,b,x
        lda #$2000
        sta aCurrentTilemapInfo,b
        phx
        lda #(`aInventoryFullConfirmText)<<8
        sta lR18+1
        lda #<>aInventoryFullConfirmText
        sta lR18
        ldx #$0101
        jsl rlDrawMapMenuTextLine
        lda #(`aInventoryFullConfirmYesText)<<8
        sta lR18+1
        lda #<>aInventoryFullConfirmYesText
        sta lR18
        ldx #$0303
        jsl rlDrawMapMenuTextLine
        lda #(`aInventoryFullConfirmNoText)<<8
        sta lR18+1
        lda #<>aInventoryFullConfirmNoText
        sta lR18
        ldx #$0308
        jsl rlDrawMapMenuTextLine
        plx
        jsl rlDrawMapMenu
        rtl

        .databank 0

        ; 85/B5B2

      aInventoryFullConfirmText ; 85/B5B2

        .enc "SJIS"
        .text "このアイテムをあずけますか？"
        .word $0000
        .enc "none"

      aInventoryFullConfirmYesText ; 85/B5D0

        .enc "SJIS"
        .text "はい"
        .word $0000
        .enc "none"

      aInventoryFullConfirmNoText ; 85/B5D6

        .enc "SJIS"
        .text "いいえ"
        .word $0000
        .enc "none"


      rlProcInventoryFullConfirmCycle ; 85/B5DE

        .al
        .xl
        .autsiz
        .databank ?

        ; Left and Right choose (aBody7 bit 0: yes); A or B stops the proc.

        lda wJoy1Repeated
        bit #$0300
        beq _B5F7
        lda #$0007
        jsl rlPlaySoundEffect
        lda aProcSystem.aBody7,b,x
        eor #$0001
        sta aProcSystem.aBody7,b,x
        bra _B5FE


        _B5F7
        lda wJoy1New
        bit #$8080
        bne _B620

        _B5FE
        lda aProcSystem.aBody7,b,x
        bit #$0001
        bne _B60B
        lda #$0002
        bra _B60E


        _B60B
        lda #$0007

        _B60E
        ora #$0400
        sta wR0
        lda #$0000
        sta wR1
        phx
        jsl rlDrawListCursorAtIndex
        plx
        bra _B626


        _B620
        lda #<>rlProcInventoryFullConfirmDone
        sta aProcSystem.aHeaderOnCycle,b,x

        _B626
        rtl

        .databank 0

        ; 85/B627

      rlProcInventoryFullConfirmDone ; 85/B627

        .al
        .xl
        .autsiz
        .databank ?

        ; procInventoryFullMenu reads the answer and frees this proc.

        rtl

        .databank 0

      aProcInventoryFullConfirmCode ; 85/B628
        PROC_HALT

      rsOpenInventoryFullConfirm ; 85/B62A

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #(`procInventoryFullConfirm)<<8
        sta lR44+1
        lda #<>procInventoryFullConfirm
        sta lR44
        jsl rlProcEngineCreateProc
        plx
        rts

        .databank 0

        ; 85/B63B

    .endsection Table85B547Section


    .section ProcScript85B63BSection

      .al
      .xl

      procInventoryFullMessage ; 85/B63B

        .structProcInfo "PW", rlProcInventoryFullMessageInit, rlProcInventoryFullMessageCycle, aProcInventoryFullMessageCode
        .long aInventoryFullMessageData
        .byte 0

      aInventoryFullMessageTilemapData ; 85/B647

        .structMapMenuTilemapData 14, 8, aBG3TilemapBuffer, 0, $7FC84A

      aInventoryFullMessageData ; 85/B650

        .long 0, 0, aInventoryFullMessageTilemapData
        .byte 0, 16, 1

    .endsection ProcScript85B63BSection


    .section Unsorted85B65CSection

      .al
      .xl

      rlProcInventoryFullMessageInit ; 85/B65C

        .al
        .xl
        .autsiz
        .databank ?

        ; "もちものが　いっぱいです　あずけるアイテムをえらんでください" (the inventory is full; choose an item to deposit).

        jsl rlInitMapMenuProc
        lda #$2000
        sta aCurrentTilemapInfo,b
        phx
        lda #(`aInventoryFullMessageText1)<<8
        sta lR18+1
        lda #<>aInventoryFullMessageText1
        sta lR18
        ldx #$0101
        jsl rlDrawMapMenuTextLine
        lda #(`aInventoryFullMessageText2)<<8
        sta lR18+1
        lda #<>aInventoryFullMessageText2
        sta lR18
        ldx #$0301
        jsl rlDrawMapMenuTextLine
        lda #(`aInventoryFullMessageText3)<<8
        sta lR18+1
        lda #<>aInventoryFullMessageText3
        sta lR18
        ldx #$0501
        jsl rlDrawMapMenuTextLine
        plx
        jsl rlDrawMapMenu
        rtl

        .databank 0

        ; 85/B6A0

    .endsection Unsorted85B65CSection


    .section Table85B6A0Section

      .al
      .xl

      aInventoryFullMessageText1 ; 85/B6A0

        .enc "SJIS"
        .text "もちものが　いっぱいです"
        .word $0000
        .enc "none"

      aInventoryFullMessageText2 ; 85/B6BA

        .enc "SJIS"
        .text "あずけるアイテムをえらん"
        .word $0000
        .enc "none"

      aInventoryFullMessageText3 ; 85/B6D4

        .enc "SJIS"
        .text "でください"
        .word $0000
        .enc "none"


    .endsection Table85B6A0Section


    .section Unsorted85B6E0Section

      .al
      .xl

      rlProcInventoryFullMessageCycle ; 85/B6E0

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 85/B6E1

    .endsection Unsorted85B6E0Section


    .section ProcScript85B6E1Section

      .al
      .xl

      aProcInventoryFullMessageCode ; 85/B6E1

        PROC_HALT


        ; 85/B6E3

      procInventoryFullNewItem ; 85/B6E3

        .structProcInfo "PW", rlProcInventoryItemWindowInit, rlProcInventoryItemWindowCycle, aProcInventoryItemWindowCode

    .endsection ProcScript85B6E1Section


    .section Table85B6EBSection

      .al
      .xl

        ; trailing args for procInventoryFullNewItem
        .long aInventoryFullNewItemData
        .byte $00

      aInventoryFullNewItemTilemapData ; 85/B6EF
        .byte $0E, $04, $88, $83, $7E, $00, $4A, $C9, $7F

      aInventoryFullNewItemData ; 85/B6F8
        .long $000000
        .long $000000
        .long aInventoryFullNewItemTilemapData
        .byte $00, $02, $01

      procInventoryFullChosenItem ; 85/B704
        .structProcInfo "PW", rlProcInventoryItemWindowInit, rlProcInventoryItemWindowCycle, aProcInventoryItemWindowCode
        .long aInventoryFullChosenItemData
        .byte $00

      aInventoryFullChosenItemTilemapData ; 85/B710
        .byte $0E, $04, $88, $83, $7E, $00, $4A, $CA, $7F

      aInventoryFullChosenItemData ; 85/B719
        .long $000000
        .long $000000
        .long aInventoryFullChosenItemTilemapData
        .byte $00, $02, $01

    .endsection Table85B6EBSection


    .section Unsorted85B725Section

      .al
      .xl

      rlProcInventoryItemWindowInit ; 85/B725

        .al
        .xl
        .autsiz
        .databank ?

        ; wInput0 = item ROM pointer, wInput1 = position (negative: keep), wInput2 = slot (aBody7; negative: none), wInput3 = unit RAM pointer. Draws the name, and "Ｅ" if it is the equipped weapon.

        jsl rlInitMapMenuProc
        lda aProcSystem.wInput0,b
        sta wCurrentItemDataROMPointer,b
        lda aProcSystem.wInput1,b
        bmi _B738
        jsl rlSetMapMenuPosition

        _B738
        lda aProcSystem.wInput2,b
        sta aProcSystem.aBody7,b,x
        lda aProcSystem.wInput3,b
        sta wSelectedUnitDataRAMPointer,b
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda aProcSystem.wInput2,b
        bpl _B769
        lda #$0008
        jsl rlCheckIfWeaponEquipped
        bcc _B769
        lda #(`aInventoryItemWindowEquippedText)<<8
        sta lR18+1
        lda #<>aInventoryItemWindowEquippedText
        sta lR18
        ldx #$010C
        jsl rlDrawMapMenuTextLine

        _B769
        jsr rsSetTileBaseForObtainableItem
        jsl rlGetItemNamePointer
        lda lRoutineVariable+1,b
        sta lR18+1
        lda lRoutineVariable,b
        sta lR18
        ldx #$0104
        jsl rlDrawMapMenuTextLine
        jsl rlDrawMapMenu
        rtl

        .databank 0

        ; 85/B786

    .endsection Unsorted85B725Section


    .section Table85B786Section

      .al
      .xl

      aInventoryItemWindowEquippedText ; 85/B786

        .enc "SJIS"
        .text "Ｅ"
        .word $0000
        .enc "none"


    .endsection Table85B786Section


    .section Unsorted85B78ASection

      .al
      .xl

      rlProcInventoryItemWindowCycle ; 85/B78A

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws the item's icon beside the window.

        phx
        lda aProcSystem.aBody7,b,x
        bmi _B7CD
        jsl rlLoadMapMenuEntryPointerFromProcBody
        jsl rlGetMapMenuPosition
        cmp #$0000
        bmi _B7CD
        pha
        and #$00FF
        clc
        adc #$0002
        asl a
        asl a
        asl a
        sta wR0
        pla
        xba
        and #$00FF
        clc
        adc #$0001
        asl a
        asl a
        asl a
        sta wR1
        lda aProcSystem.aBody7,b,x
        beq _B7C2
        sec
        sbc #$0008
        asl a

        _B7C2
        sta wR4
        stz wR5
        ldy <>aMapItemListIconSprites+(7*2),b
        jsl rlPushToOAMBuffer

        _B7CD
        plx
        rtl

        .databank 0

        ; 85/B7CF

    .endsection Unsorted85B78ASection


    .section ProcScript85B7CFSection

      .al
      .xl

      aProcInventoryItemWindowCode ; 85/B7CF

        PROC_HALT


        ; 85/B7D1

    .endsection ProcScript85B7CFSection


