; The item list a unit command opens (attack, assault, staff, items, equip), the
; weapon stats window beside it, and the unit's portrait.

    .section MapItemListDataSection

      .al
      .xl

      aMapItemListTilemapData ; 85/926C

        .structMapMenuTilemapData 16, 16, aBG3TilemapBuffer, 0, $7FC64A

      aMapItemListData ; 85/9275

        .long 0, 0, aMapItemListTilemapData
        .byte 0, 2, 9

    .endsection MapItemListDataSection


    .section Unsorted859281Section

      .al
      .xl

      procMapItemList ; 85/9281

        .structProcInfo "PW", rlProcMapItemListInit, rlProcMapItemListSetUp, aProcDialogueBoxCode


        .long aMapItemListData
        .byte 1

    .endsection Unsorted859281Section


    .section Unsorted85928DSection

      .al
      .xl

      rlProcMapItemListInit ; 85/928D

        .al
        .xl
        .autsiz
        .databank ?

        ; wInput0 = unit RAM pointer (aBody4), wInput1 = a list of inventory slots in bank $7E (aBody5): a count byte, then the slots ($7E2000-$7E2028, rlBuildUnitMenuSlotLists).

        jsl rlInitMapMenuProcAndTileBase
        lda aProcSystem.wInput0,b
        sta aProcSystem.aBody4,b,x
        lda aProcSystem.wInput1,b
        sta aProcSystem.aBody5,b,x
        lda #$0001
        sta aProcSystem.aBody6,b,x
        lda #$0000
        sta wMapItemListRequest
        sta wMapItemListHoveredSlot
        jsl rlSetMapMenuTextColors
        lda wChapterFlags,b
        bit #$0020
        bne _92BC
        bra _92C3


        _92BC
        lda #$0102
        jsl rlSetMapMenuPosition

        _92C3
        rtl

        .databank 0

        ; 85/92C4

      rlProcMapItemListSetUp ; 85/92C4

        .al
        .xl
        .autsiz
        .databank ?

        ; Sizes the window to the list.

        phx
        phy
        phx
        lda aProcSystem.aBody5,b,x
        tax
        lda $7E0000,x
        and #$00FF
        sta wR0
        plx
        jsl rlGetMapMenuTilemapArea
        and #$00FF
        xba
        ora wR0
        sep #$20
        asl a
        rep #$20
        clc
        adc #$0002
        xba
        jsl rlSetMapMenuTilemapArea
        jsl rlHideMapMenuLayers
        lda #<>rlMapItemListDrawItems
        sta aProcSystem.aHeaderOnCycle,b,x
        ply
        plx
        rtl

        .databank 0

        ; 85/92FA

    .endsection Unsorted85928DSection


    .section Unsorted8592FASection

      .al
      .xl

      rlMapItemListDrawItems ; 85/92FA

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Each item's name and uses.

        phx
        phy
        jsl rlLoadMapMenuEntryPointerFromProcBody
        lda aProcSystem.aBody4,b,x
        sta wSelectedUnitDataRAMPointer,b
        lda aProcSystem.aBody5,b,x
        sta wR2
        tax
        lda $7E0000,x
        and #$00FF
        sta wR0
        ldy #$0000

        _9318
        lda #$20F0
        sta aCurrentTilemapInfo,b
        tya
        clc
        adc wR2
        tax
        lda $7E0001,x
        and #$00FF
        sta wR1
        tya
        asl a
        xba
        clc
        adc #$0104
        tax
        lda wR1
        jsl rlGetItemROMDataByInventorySlot
        lda wCurrentItemDataROMPointer,b
        bne _9343
        jml _936C


        _9343
        lda aCurrentTilemapInfo,b
        and #$FC00
        sta aCurrentTilemapInfo,b
        jsl rlDrawItemNameInMapMenu
        lda aCurrentTilemapInfo,b
        and #$FFC0
        ora #$24F0
        sta aCurrentTilemapInfo,b
        txa
        clc
        adc #$0008
        tax
        lda wR1
        jsl rlGetItemDurabilityOfInventorySlot
        jsl rlDrawMapMenuNumber

        _936C
        inc y
        cpy wR0
        bcs _9375
        jml _9318


        _9375
        ply
        plx
        lda #<>rlProcMapItemListShowPortrait
        sta aProcSystem.aHeaderOnCycle,b,x
        jsl rlDrawMapMenu
        jsl rlHideMapMenuLayers
        rtl

        .databank 0

        ; 85/9386

    .endsection Unsorted8592FASection


    .section Unsorted859386Section

      .al
      .xl

      rlProcMapItemListShowPortrait ; 85/9386

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsMapItemListShowPortrait
        lda #<>rlProcMapItemListShowDetails
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 85/9390

    .endsection Unsorted859386Section


    .section Unsorted859390Section

      .al
      .xl

      rlProcMapItemListShowDetails ; 85/9390

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; For a weapon list ($7E2000, $7E2010, $7E2020): opens procMapItemWeaponStats on the item under the cursor; otherwise opens the item's description box.

        jsl rlLoadMapMenuEntryPointerFromProcBody
        lda aProcSystem.aBody5,b,x
        sta wR2
        lda aProcSystem.aBody6,b,x
        phx
        dec a
        clc
        adc wR2
        tax
        lda $7E0001,x
        and #$00FF
        sta aProcSystem.wInput1,b
        plx
        lda wR2
        cmp #$2000
        beq _93F7
        cmp #$2010
        beq _93F7
        cmp #$2020
        beq _93F7
        lda wR1
        pha
        lda wR2
        pha
        lda aProcSystem.wInput1,b
        phx
        jsl rlGetItemROMDataByInventorySlot
        jsl rlGetItemDescriptionPointer
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        lda wChapterFlags,b
        bit #$0020
        bne _93E7
        lda #$0213
        bra _93EA


        _93E7
        lda #$0113

        _93EA
        jsl rlOpenItemDescriptionBox
        plx
        pla
        sta wR2
        pla
        sta wR1
        bra _9414


        _93F7
        lda aProcSystem.aBody4,b,x
        sta aProcSystem.wInput0,b
        phx
        lda #(`procMapItemWeaponStats)<<8
        sta lR44+1
        lda #<>procMapItemWeaponStats
        sta lR44
        jsl rlProcEngineCreateProc
        plx
        lda #$0000
        sta wMapItemListRequest

        _9414
        jsl rlLoadMapMenuEntryPointerFromProcBody
        jsl rlBringMapMenuToFront
        jsl rlHideMapMenuLayers
        lda #<>rlProcMapItemListLoadIcons
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 85/9427

    .endsection Unsorted859390Section


    .section Unsorted859427Section

      .al
      .xl

      rlProcMapItemListLoadIcons ; 85/9427

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsMapItemListLoadIcons
        lda #<>rlProcMapItemListBeginInput
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 85/9431

    .endsection Unsorted859427Section


    .section Unsorted859431Section

      .al
      .xl

      rlProcMapItemListBeginInput ; 85/9431

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlShowMapMenuLayers
        lda #<>rlProcMapItemListCycle
        sta aProcSystem.aHeaderOnCycle,b,x

      rlProcMapItemListCycle ; 85/943B

        .al
        .xl
        .autsiz
        .databank ?

        ; Up and Down move the cursor (aBody6) and update the stats or description; A chooses (rsMapItemListChoose); B closes everything and reopens the unit menu.

        phx
        lda aProcSystem.aBody5,b,x
        tax
        lda $7E0000,x
        and #$00FF
        sta wR1
        plx
        lda aProcSystem.aBody5,b,x
        sta wR2
        lda wJoy1Repeated
        bit #$0800
        beq _9473
        lda aProcSystem.aBody6,b,x
        dec a
        bne _9465
        lda wJoy1New
        bit #$0800
        beq _9473
        lda wR1

        _9465
        sta aProcSystem.aBody6,b,x
        lda #$0006
        jsl rlPlaySoundEffect
        jml _94EC


        _9473
        bit #$0400
        beq _949A
        lda aProcSystem.aBody6,b,x
        inc a
        cmp wR1
        beq _948C
        bcc _948C
        lda wJoy1New
        bit #$0400
        beq _949A
        lda #$0001

        _948C
        sta aProcSystem.aBody6,b,x
        lda #$0006
        jsl rlPlaySoundEffect
        jml _94EC


        _949A
        lda wJoy1New
        bit #$0080
        beq _94AF
        lda #$000A
        jsl rlPlaySoundEffect
        jsr rsMapItemListChoose
        jml _957A


        _94AF
        lda wJoy1New
        bit #$8000
        beq _94E8
        lda #$0021
        jsl rlPlaySoundEffect
        jsr rsMapItemListHidePortrait
        jsl rlCloseMapMenuFromProc
        jsl rlProcEngineFreeProc
        jsl rlRestoreMapMenuTextColors
        jsl rlCloseItemDescriptionBox
        lda #$8000
        sta wMapItemListRequest
        jsr rsCloseMapItemWeaponStats
        phx
        jsl rlSetMapCursorFree
        jsl rlOpenUnitMenu
        plx
        jml _957A


        _94E8
        jml _9551


        _94EC
        phx
        lda aProcSystem.aBody6,b,x
        dec a
        clc
        adc wR2
        tax
        lda $7E0001,x
        and #$00FF
        sta wMapItemListHoveredSlot
        plx
        lda wR2
        cmp #$2000
        beq _9542
        cmp #$2010
        beq _9542
        cmp #$2020
        beq _9542
        lda wR1
        pha
        lda wR2
        pha
        lda aProcSystem.aBody4,b,x
        sta wSelectedUnitDataRAMPointer,b
        lda wMapItemListHoveredSlot
        phx
        jsl rlGetItemROMDataByInventorySlot
        jsl rlGetItemDescriptionPointer
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        jsl rlChangeItemDescriptionBox
        plx
        pla
        sta wR2
        pla
        sta wR1
        bra _9551


        _9542
        lda #$4000
        sta wMapItemListRequest
        jsl rlLoadMapMenuEntryPointerFromProcBody
        jsl rlBringMapMenuToFront

        _9551
        lda #$0100
        sta wR0
        lda wR1
        inc a
        sta wR1
        lda aProcSystem.aBody6,b,x
        jsl rlDrawListCursorAtIndex
        jsr rsMapItemListDrawIcons
        lda aProcSystem.aBody5,b,x
        cmp #$2008
        beq _957A
        cmp #$2018
        beq _957A
        cmp #$2028
        beq _957A
        jsr rsMapItemWeaponStatsDrawRankIcon

        _957A
        rtl

        .databank 0

        ; 85/957B

      rlProcMapItemListWaitForItemUseMenu ; 85/957B

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        jsr rsMapItemListDrawIcons
        lda wJoy1New
        bit #$0080
        beq _959A
        lda #$000A
        jsl rlPlaySoundEffect
        jsl rlCloseMapMenuFromProc
        jsl rlProcEngineFreeProc
        jsl rlRestoreMapMenuTextColors
        bra _95AE


        _959A
        lda wJoy1New
        bit #$8000
        beq _95AE
        lda #$0021
        jsl rlPlaySoundEffect
        lda #<>rlProcMapItemListCycle
        sta aProcSystem.aHeaderOnCycle,b,x

        _95AE
        lda #$0100
        sta wR0
        lda wR1
        inc a
        sta wR1
        lda aProcSystem.aBody6,b,x
        jsl rlDrawListCursorAtIndex
        rtl

        .databank 0

        ; 85/95C0

      rsMapItemListChoose ; 85/95C0

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Attack or assault: the item becomes wSelectedInventorySlot and target selection starts (rlFindTargetsForSelectedWeapon, rlStartChoosingTarget). Items: opens procItemUseMenu. Staves: wSelectedInventorySlot (bit 15 for the castle's list) and rlUseItemFromMap. Equip: equips it and reopens the unit menu.

        phx
        jsr rsMapItemListHidePortrait
        phx
        lda aProcSystem.aBody4,b,x
        sta wSelectedUnitDataRAMPointer,b
        lda aProcSystem.aBody6,b,x
        dec a
        clc
        adc wR2
        tax
        lda wR2
        cmp #$2000
        beq _95F2
        cmp #$2008
        beq _9642
        cmp #$2010
        beq _95F2
        cmp #$2018
        beq _960F
        cmp #$2028
        beq _9636
        jml _9668


        _95F2
        lda $7E0001,x
        and #$00FF
        sta wSelectedInventorySlot,b
        jsr _9682
        ldx wActiveUnitDeploymentOffset,b
        jsl rlFindTargetsForSelectedWeapon
        jsl rlStartChoosingTarget
        plx
        jml _969C


        _960F
        lda $7E0001,x
        and #$00FF
        sta wSelectedInventorySlot,b
        lda #(`procItemUseMenu)<<8
        sta lR44+1
        lda #<>procItemUseMenu
        sta lR44
        jsl rlProcEngineCreateProc
        plx
        lda #<>rlProcMapItemListWaitForItemUseMenu
        sta aProcSystem.aHeaderOnCycle,b,x
        jsl rlCloseItemDescriptionBox
        jml _969C


        _9636
        lda $7E0001,x
        and #$00FF
        ora #$8000
        bra _9649


        _9642
        lda $7E0001,x
        and #$00FF

        _9649
        sta wSelectedInventorySlot,b
        ldx aProcSystem.wOffset,b
        jsl rlCloseMapMenuFromProc
        jsl rlProcEngineFreeProc
        jsl rlRestoreMapMenuTextColors
        jsl rlCloseItemDescriptionBox
        jsl rlUseItemFromMap
        plx
        jml _969C


        _9668
        lda $7E0001,x
        and #$00FF
        sta wSelectedInventorySlot,b
        jsl rlFlagEquippedInventorySlotAndGetStatBonus
        jsr _9682
        jsl rlOpenUnitMenu
        plx
        jml _969C


        _9682
        ldx aProcSystem.wOffset,b
        jsl rlCloseMapMenuFromProc
        jsl rlProcEngineFreeProc
        jsl rlRestoreMapMenuTextColors
        lda #$8000
        sta wMapItemListRequest
        jsr rsCloseMapItemWeaponStats
        rts


        _969C
        plx
        rts

        .databank 0

        ; 85/969E

      rsMapItemListShowPortrait ; 85/969E

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Draws the unit's portrait beside the list (rlDialogueLoadAndDrawPortrait), except in the castle (bit 5 of wChapterFlags).

        lda wChapterFlags,b
        bit #$0020
        bne _96F9
        phx
        lda aProcSystem.aBody4,b,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitCharacterID
        ldx #$0000
        jsl rlDialogueLoadAndDrawPortrait
        plx
        phx
        ldx #$005E
        lda #$0000

        _96C0
        sta $7FC5B2,x
        dec x
        dec x
        bpl _96C0
        plx
        lda #$0005
        sta aEpilogueUnitStates
        lda #$0001
        sta $7FC54C
        lda #$000B
        sta $7FC5AE
        lda #$0001
        sta $7FC5B0
        lda wMapMenuDirtyBottom,b
        cmp #$0009
        bpl _96F3
        lda #$0009
        sta wMapMenuDirtyBottom,b

        _96F3
        lda #$0001
        sta wMapMenuDirtyTop,b

        _96F9
        rts

        .databank 0

        ; 85/96FA

      rsMapItemListHidePortrait ; 85/96FA

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda wChapterFlags,b
        bit #$0020
        bne _9736
        phy
        phx
        phx
        ldx #$000C
        lda #$0000

        _970B
        sta $7E7BD2,x
        sta $7E7C12,x
        sta $7E7C52,x
        dec x
        dec x
        bpl _970B
        plx
        lda wMapMenuDirtyBottom,b
        cmp #$0009
        bpl _972A
        lda #$0009
        sta wMapMenuDirtyBottom,b

        _972A
        lda #$0001
        sta wMapMenuDirtyTop,b
        jsl rlGetMapMenuRows
        plx
        ply

        _9736
        rts

        .databank 0

        ; 85/9737

      rsCloseMapItemWeaponStats ; 85/9737

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda lMapMenuRAMEntryPointer,b
        pha
        lda lMapMenuRAMEntryPointer+1,b
        pha
        lda #(`procMapItemWeaponStats)<<8
        sta lR44+1
        lda #<>procMapItemWeaponStats
        sta lR44
        jsl rlProcEngineFindProc
        bcc _975C
        jsl rlLoadMapMenuEntryPointerFromProcBody
        jsl rlCloseMapMenuFromProc
        jsl rlProcEngineFreeProc

        _975C
        pla
        sta lMapMenuRAMEntryPointer+1,b
        pla
        sta lMapMenuRAMEntryPointer,b
        plx
        rts

        .databank 0

        ; 85/9766

      rsMapItemListLoadIcons ; 85/9766

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Copies each item's icon into sprite tiles $40+ (rlCopyItemIcon).

        phx
        phy
        lda aProcSystem.aBody4,b,x
        sta wSelectedUnitDataRAMPointer,b
        lda aProcSystem.aBody5,b,x
        sta wR2
        tax
        lda $7E0000,x
        and #$00FF
        sta wR0
        ldy #$0000

        _9780
        tya
        clc
        adc wR2
        tax
        lda $7E0001,x
        and #$00FF
        sta wR1
        lda wR1
        jsl rlGetItemROMDataByInventorySlot
        lda wCurrentItemDataROMPointer,b
        bne _979D
        jml _97C1


        _979D
        phx
        phy
        lda wR0
        pha
        tya
        asl a
        and #$000F
        ora #$0040
        tax
        lda wR1
        jsl rlGetItemIDByInventorySlot
        jsl rlCopyItemIcon
        lda #$0006
        jsl rlUnitWindowCopySpritePalette1
        pla
        sta wR0
        ply
        plx

        _97C1
        inc y
        cpy wR0
        bcs _97CA
        jml _9780


        _97CA
        ply
        plx
        rts

        .databank 0

        ; 85/97CD

      rsMapItemListDrawIcons ; 85/97CD

        ; Found by tools/sweep.py.
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
        lda aProcSystem.aBody5,b,x
        sta wR2
        tax
        lda $7E0000,x
        and #$00FF
        asl a
        sta wR7
        ldx #$0000
        stz wR4
        stz wR5

        _9812
        phx
        ldy <>aMapItemListIconSprites,b,x
        jsl rlPushToOAMBuffer
        plx
        inc x
        inc x
        cpx wR7
        bcs _9825
        jml _9812


        _9825
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

        ; 85/9831


      aMapItemListIconSprites ; 85/9831

        .word <>aUnknown859841
        .word <>aUnknown859848
        .word <>aUnknown85984F
        .word <>aUnknown859856
        .word <>aUnknown85985D
        .word <>aUnknown859864
        .word <>aUnknown85986B
        .word <>aUnknown859872

      aUnknown859841 ; 85/9841

        _Sprites := [[(   0,    0), $21, SpriteLarge, $040, 3, 6, false, false]]

        .structSpriteArray aUnknown859841._Sprites

      aUnknown859848 ; 85/9848

        _Sprites := [[(   0,   16), $21, SpriteLarge, $042, 3, 6, false, false]]

        .structSpriteArray aUnknown859848._Sprites

      aUnknown85984F ; 85/984F

        _Sprites := [[(   0,   32), $21, SpriteLarge, $044, 3, 6, false, false]]

        .structSpriteArray aUnknown85984F._Sprites

      aUnknown859856 ; 85/9856

        _Sprites := [[(   0,   48), $21, SpriteLarge, $046, 3, 6, false, false]]

        .structSpriteArray aUnknown859856._Sprites

      aUnknown85985D ; 85/985D

        _Sprites := [[(   0,   64), $21, SpriteLarge, $048, 3, 6, false, false]]

        .structSpriteArray aUnknown85985D._Sprites

      aUnknown859864 ; 85/9864

        _Sprites := [[(   0,   80), $21, SpriteLarge, $04A, 3, 6, false, false]]

        .structSpriteArray aUnknown859864._Sprites

      aUnknown85986B ; 85/986B

        _Sprites := [[(   0,   96), $21, SpriteLarge, $04C, 3, 6, false, false]]

        .structSpriteArray aUnknown85986B._Sprites

      aUnknown859872 ; 85/9872

        _Sprites := [[(   0,    0), $21, SpriteLarge, $04E, 3, 6, false, false]]

        .structSpriteArray aUnknown859872._Sprites

      aMapItemWeaponStatsTilemapData ; 85/9879

        .structMapMenuTilemapData 11, 10, aBG3TilemapBuffer, 0, $7FC94A

      aMapItemWeaponStatsData ; 85/9882

        .long 0, 0, aMapItemWeaponStatsTilemapData
        .byte 0, 19, 4

    .endsection Unsorted859431Section


    .section Unsorted85988ESection

      .al
      .xl

      procMapItemWeaponStats ; 85/988E

        .structProcInfo "PW", rlProcMapItemWeaponStatsInit, rlProcMapItemWeaponStatsDraw, aProcMapItemWeaponStatsCode


        .long aMapItemWeaponStatsData
        .byte 0

    .endsection Unsorted85988ESection


    .section Unsorted85989ASection

      .al
      .xl

      rlProcMapItemWeaponStatsInit ; 85/989A

        .al
        .xl
        .autsiz
        .databank ?

        ; wInput0 = unit RAM pointer, wInput1 = inventory slot. Draws the stat labels.

        jsl rlInitMapMenuProcAndTileBase
        lda aProcSystem.wInput0,b
        sta aProcSystem.aBody4,b,x
        sta wSelectedUnitDataRAMPointer,b
        lda aProcSystem.wInput1,b
        jsl rlGetItemROMDataByInventorySlot
        lda wCurrentItemDataROMPointer,b
        sta aProcSystem.aBody5,b,x
        jsl rlDrawMapMenu
        lda aProcSystem.aBody4,b,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlHideMapMenuLayers
        phx
        lda #$2140
        sta aCurrentTilemapInfo,b
        lda #(`aUnknown85996B)<<8
        sta lR18+1
        lda #<>aUnknown85996B
        sta lR18
        ldx #$0102
        jsl rlDrawMapMenuTileString
        lda #(`aUnknown85996F)<<8
        sta lR18+1
        lda #<>aUnknown85996F
        sta lR18
        ldx #$0202
        jsl rlDrawMapMenuTileString
        lda #(`aUnknown859953)<<8
        sta lR18+1
        lda #<>aUnknown859953
        sta lR18
        ldx #$0302
        jsl rlDrawMapMenuTileString
        lda #(`aUnknown859957)<<8
        sta lR18+1
        lda #<>aUnknown859957
        sta lR18
        ldx #$0402
        jsl rlDrawMapMenuTileString
        lda #(`aUnknown85995B)<<8
        sta lR18+1
        lda #<>aUnknown85995B
        sta lR18
        ldx #$0502
        jsl rlDrawMapMenuTileString
        lda #(`aUnknown85995F)<<8
        sta lR18+1
        lda #<>aUnknown85995F
        sta lR18
        ldx #$0602
        jsl rlDrawMapMenuTileString
        lda #(`aUnknown859963)<<8
        sta lR18+1
        lda #<>aUnknown859963
        sta lR18
        ldx #$0702
        jsl rlDrawMapMenuTileString
        lda #(`aUnknown859967)<<8
        sta lR18+1
        lda #<>aUnknown859967
        sta lR18
        ldx #$0802
        jsl rlDrawMapMenuTileString
        plx
        rtl

        .databank 0

        ; 85/9953

    .endsection Unsorted85989ASection


    .section Table859953Section

      .al
      .xl

      aUnknown859953 ; 85/9953
        .byte $44, $45, $46, $00

      aUnknown859957 ; 85/9957
        .byte $54, $55, $56, $00

      aUnknown85995B ; 85/995B
        .byte $4A, $4B, $4C, $00

      aUnknown85995F ; 85/995F
        .byte $5A, $5B, $5C, $00

      aUnknown859963 ; 85/9963
        .byte $4D, $4E, $4F, $00

      aUnknown859967 ; 85/9967
        .byte $5D, $5E, $5F, $00

      aUnknown85996B ; 85/996B
        .byte $40, $41, $42, $00

      aUnknown85996F ; 85/996F
        .byte $50, $51, $52, $00

    .endsection Table859953Section


    .section Unsorted859973Section

      .al
      .xl

      rlProcMapItemWeaponStatsDraw ; 85/9973

        .al
        .xl
        .autsiz
        .databank ?

        ; Might, hit and avoid with the weapon, each with an arrow up or down against the first usable weapon; the weapon rank icon.

        phx
        jsl rlLoadMapMenuEntryPointerFromProcBody
        lda aProcSystem.aBody4,b,x
        sta wSelectedUnitDataRAMPointer,b
        lda #$0000
        sta wRoutineVariable1,b
        plx
        phx
        lda aProcSystem.aBody5,b,x
        sta wCurrentItemDataROMPointer,b
        jsl rlGetItemWeaponType
        ldx #$004E
        jsl rlUnitWindowCopyWeaponRankIcon
        lda #$0005
        jsl rlUnitWindowCopySpritePalette2
        plx
        phx
        lda aProcSystem.aBody5,b,x
        sta wCurrentItemDataROMPointer,b
        jsl rlGetSelectedUnitBattleMight
        sta wR0
        jsl rlGetFirstWeaponBattleMight
        sec
        sbc wR0
        phx
        pha
        lda #$0003
        and #$00FF
        xba
        ora #$0008
        tax
        pla
        jsr rsDrawStatChangeArrow
        plx
        lda wR0
        ldx #$24F0
        stx aCurrentTilemapInfo,b
        ldx #$0306
        jsl rlDrawMapMenuNumber
        plx
        phx
        lda aProcSystem.aBody5,b,x
        sta wCurrentItemDataROMPointer,b
        jsl rlGetSelectedUnitBattleHit
        sta wR0
        jsl rlGetSelectedUnitFirstWeaponHit
        sec
        sbc wR0
        phx
        pha
        lda #$0005
        and #$00FF
        xba
        ora #$0008
        tax
        pla
        jsr rsDrawStatChangeArrow
        plx
        lda wR0
        ldx #$24F0
        stx aCurrentTilemapInfo,b
        ldx #$0506
        jsl rlDrawMapMenuNumber
        plx
        phx
        lda aProcSystem.aBody5,b,x
        sta wCurrentItemDataROMPointer,b
        jsl rlGetSelectedUnitDeploymentOffset
        jsl rlGetTerrainTypeByDeploymentOffset
        jsl rlGetSelectedUnitBattleAvoid
        sta wR0
        jsl rlGetSelectedUnitDeploymentOffset
        jsl rlGetTerrainTypeByDeploymentOffset
        jsl rlGetSelectedUnitFirstWeaponAvoid
        sec
        sbc wR0
        phx
        pha
        lda #$0007
        and #$00FF
        xba
        ora #$0008
        tax
        pla
        jsr rsDrawStatChangeArrow
        plx
        lda wR0
        ldx #$24F0
        stx aCurrentTilemapInfo,b
        ldx #$0706
        jsl rlDrawMapMenuNumber
        plx
        lda bBufferTM
        bit #$0002
        beq _9A5B
        jsr rsMapItemWeaponStatsDrawRankIcon

        _9A5B
        jsl rlDrawMapMenuBG3
        lda #<>rlProcMapItemWeaponStatsCycle
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 85/9A66

      rsDrawStatChangeArrow ; 85/9A66

        .al
        .xl
        .autsiz
        .databank ?

        ; A = difference, X = row and column: ↓ if positive, ↑ if negative (the first weapon minus this one), blank if 0.

        pha
        lda #$2400
        sta aCurrentTilemapInfo,b
        pla
        ora #$0000
        beq _9A97
        bpl _9A77
        bmi _9A87

        _9A77
        lda #(`aItemListDownArrowText)<<8
        sta lR18+1
        lda #<>aItemListDownArrowText
        sta lR18
        jsl rlDrawMapMenuTextLine
        bra _9AA5


        _9A87
        lda #(`aItemListUpArrowText)<<8
        sta lR18+1
        lda #<>aItemListUpArrowText
        sta lR18
        jsl rlDrawMapMenuTextLine
        bra _9AA5


        _9A97
        lda #(`aItemListBlankArrowText)<<8
        sta lR18+1
        lda #<>aItemListBlankArrowText
        sta lR18
        jsl rlDrawMapMenuTextLine

        _9AA5
        lda wR0
        rts

        .databank 0

        ; 85/9AA8

    .endsection Unsorted859973Section


    .section Table859AA8Section

      .al
      .xl

      aItemListUpArrowText ; 85/9AA8

        .enc "SJIS"
        .text "↑"
        .word $0000
        .enc "none"

      aItemListDownArrowText ; 85/9AAC

        .enc "SJIS"
        .text "↓"
        .word $0000
        .enc "none"

      aItemListBlankArrowText ; 85/9AB0

        .enc "SJIS"
        .text "　"
        .word $0000
        .enc "none"


    .endsection Table859AA8Section


    .section Unsorted859AB4Section

      .al
      .xl

      rlProcMapItemWeaponStatsCycle ; 85/9AB4

        .al
        .xl
        .autsiz
        .databank ?

        ; wMapItemListRequest bit 15: close; bit 14: show the item in wMapItemListHoveredSlot.

        lda wMapItemListRequest
        bit #$8000
        bne _9AC7
        lda wMapItemListRequest
        bit #$4000
        bne _9ADB
        rtl


        _9AC7
        jsl rlCloseMapMenuFromProc
        jsl rlProcEngineFreeProc
        lda #$0000
        sta wMapItemListRequest
        sta wMapItemListHoveredSlot
        rtl


        _9ADB
        phx
        lda wMapItemListHoveredSlot
        jsl rlGetItemROMDataByInventorySlot
        plx
        lda wCurrentItemDataROMPointer,b
        sta aProcSystem.aBody5,b,x
        lda #$0000
        sta wMapItemListRequest
        sta wMapItemListHoveredSlot
        lda #<>rlProcMapItemWeaponStatsDraw
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 85/9AFD

    .endsection Unsorted859AB4Section


    .section Unsorted859AFDSection

      .al
      .xl

      rsMapItemWeaponStatsDrawRankIcon ; 85/9AFD

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda wR0
        pha
        lda wR1
        pha
        ldy #<>aMapItemWeaponRankIconSprite
        lda #$00C8
        sta wR0
        lda #$0028
        sta wR1
        stz wR4
        stz wR5
        jsl rlPushToOAMBuffer
        pla
        sta wR1
        pla
        sta wR0
        plx
        rts

        .databank 0

        ; 85/9B21


      aMapItemWeaponRankIconSprite ; 85/9B21

        _Sprites := [[(   0,    0), $21, SpriteLarge, $04E, 3, 5, false, false]]

        .structSpriteArray aMapItemWeaponRankIconSprite._Sprites

    .endsection Unsorted859AFDSection


    .section Unsorted859B28Section

      .al
      .xl

      aProcMapItemWeaponStatsCode ; 85/9B28

        PROC_HALT


        ; 85/9B2A

    .endsection Unsorted859B28Section


