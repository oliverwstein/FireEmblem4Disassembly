; The unit menu's lists of usable inventory slots (rlBuildUnitMenuSlotLists):
; weapons with targets, staves with targets, weapons for assault, usable items and
; equippable weapons, each a count and up to seven slots, with the equipped weapon
; first. Also the castle staff lists and rlFindTargetsForItemRange. Bank $84.


    .section Unsorted84F75CSection

      .al
      .xl

      rlCheckInventorySlotStaffUsable ; 84/F75C

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlGetItemROMDataByInventorySlot
        jsl rlCheckStaffEquippable
        rtl

        .databank 0

        ; 84/F765

      rlCheckInventorySlotItemUsable ; 84/F765

        .al
        .xl
        .autsiz
        .databank ?

        ; Carry set for an item in the slot that is not a staff and has targets.

        phb
        phk
        plb
        .databank $84
        jsl rlGetItemROMDataByInventorySlot
        lda wCurrentItemDataROMPointer,b
        beq _F783
        jsl rlGetItemEquipmentType
        cmp #$0001
        beq _F783
        jsl rlCheckStaffHasTargets
        bcc _F783
        sec

        _F781
        plb
        .databank $84
        rtl


        _F783
        clc
        bra _F781

        .databank 0

        ; 84/F786

      rlBuildUnitMenuSlotLists ; 84/F786

        .al
        .xl
        .autsiz
        .databank ?

        ; Builds the unit menu's slot lists for slots 1-7: weapons with targets, staves with targets, weapons for assault, usable items and equippable weapons (only the last during canto). Clears unit state $0400 first.

        phb
        php
        phk
        plb
        .databank $84
        phx
        phy
        lda wR0
        pha
        lda wR1
        pha
        lda #(`$7F654A)<<8
        sta lRoutineVariable+1,b
        lda #<>$7F654A
        sta lRoutineVariable,b
        jsl rlUnknown8483F3
        lda #$0400
        jsl rlUnsetSelectedUnitStates
        lda #$0000
        sta aUnitMenuWeaponSlots
        sta aUnitMenuStaffSlots
        sta aUnitMenuAssaultSlots
        sta aUnitMenuItemSlots
        sta aUnitMenuEquipSlots
        lda #$0001
        sta wR0

        _F7C5
        jsl rlGetSelectedUnitStates
        bit #UnitStateCanto
        bne _F7DA
        jsr rsAddSlotIfWeaponHasTargets
        jsr rsAddSlotIfStaffHasTargets
        jsr rsAddSlotIfAssaultHasTargets
        jsr rsAddSlotIfItemUsable

        _F7DA
        jsr rsAddSlotIfEquippable
        inc wR0
        lda wR0
        cmp #$0008
        bcs _F7EA
        jml _F7C5


        _F7EA
        pla
        sta wR1
        pla
        sta wR0
        ply
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 84/F7F5

      rsAddSlotIfWeaponHasTargets ; 84/F7F5

        .al
        .xl
        .autsiz
        .databank ?

        lda #<>aUnitMenuWeaponSlots
        sta wR1
        lda wR0
        jsl rlCheckWeaponInInventorySlotEquippable
        bcc _F814
        stz wR12
        lda #$0000
        jsl rlFindTargetsForItemRange
        ora #$0000
        beq _F814
        jml rsAddSlotIfEquippable._F889


        _F814
        rts

        .databank 0

        ; 84/F815

      rsAddSlotIfStaffHasTargets ; 84/F815

        .al
        .xl
        .autsiz
        .databank ?

        lda #<>aUnitMenuStaffSlots
        sta wR1
        lda wR0
        jsl rlCheckInventorySlotStaffUsable
        bcc _F82C
        jsl rlCheckStaffHasTargets
        bcc _F82C
        jml rsAddSlotIfEquippable._F889


        _F82C
        rts

        .databank 0

        ; 84/F82D

      rsAddSlotIfStaffHasCastleTargets ; 84/F82D

        .al
        .xl
        .autsiz
        .databank ?

        lda #<>aUnitMenuCastleStaffSlots
        sta wR1
        lda wR0
        jsl rlCheckInventorySlotStaffUsable
        bcc _F844
        jsl rlCheckStaffHasCastleTargets
        bcc _F844
        jml rsAddSlotIfEquippable._F889


        _F844
        rts

        .databank 0

        ; 84/F845

      rsAddSlotIfAssaultHasTargets ; 84/F845

        .al
        .xl
        .autsiz
        .databank ?

        lda #<>aUnitMenuAssaultSlots
        sta wR1
        lda wR0
        jsl rlCheckWeaponInInventorySlotEquippable
        bcc _F864
        stz wR12
        lda #$0004
        jsl rlFindTargetsForItemRange
        ora #$0000
        beq _F864
        jml rsAddSlotIfEquippable._F889


        _F864
        rts

        .databank 0

        ; 84/F865

      rsAddSlotIfItemUsable ; 84/F865

        .al
        .xl
        .autsiz
        .databank ?

        lda #<>aUnitMenuItemSlots
        sta wR1
        lda wR0
        jsl rlCheckInventorySlotItemUsable
        bcc _F876
        jml rsAddSlotIfEquippable._F889


        _F876
        rts

        .databank 0

        ; 84/F877

      rsAddSlotIfEquippable ; 84/F877

        .al
        .xl
        .autsiz
        .databank ?

        ; Adds slot wR0 to the list at wR1 if its weapon is equippable; _F889 adds it to any list, the equipped weapon first.

        lda #<>aUnitMenuEquipSlots
        sta wR1
        lda wR0
        jsl rlCheckWeaponInInventorySlotEquippable
        bcc _F888
        jml _F889


        _F888
        rts


        _F889
        phb
        php
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb
        .databank $7E
        ldx wR1
        lda wR0
        jsl rlCheckIfWeaponEquipped
        bcs _F8B0
        lda $0000,b,x
        and #$00FF

        _F8A3
        clc
        adc wR1
        tay
        sep #$20
        lda wR0
        sta $0001,b,y
        bra _F8D1


        _F8B0
        .al
        lda $0000,b,x
        and #$00FF
        beq _F8A3
        phx
        tax
        clc
        adc wR1
        dec a
        tay
        sep #$20

        _F8C1
        lda $0001,b,y
        sta $0002,b,y
        dec y
        dec x
        bne _F8C1
        plx
        lda wR0
        sta $0002,b,y

        _F8D1
        inc $0000,b,x
        rep #$20
        plp
        plb
        .databank ?
        rts

        .databank 0

        ; 84/F8D9

    .endsection Unsorted84F75CSection


    .section Unsorted84F8D9Section

      .al
      .xl

      rlBuildCastleStaffSlotLists ; 84/F8D9

        .al
        .xl
        .autsiz
        .databank ?

        ; The staff and castle staff lists for a unit in its castle, from the castle's tile.

        phb
        php
        phk
        plb
        .databank $84
        phx
        phy
        lda wR0
        pha
        lda wR1
        pha
        lda wEventLocationEntry,b
        beq _F92E
        jsl rlGetEventLocationEntryEffectiveXCoordinate
        sta wR10
        jsl rlGetEventLocationEntryEffectiveYCoordinate
        dec a
        sta wR11
        lda #(`aRangeMap)<<8
        sta lRoutineVariable+1,b
        lda #<>aRangeMap
        sta lRoutineVariable,b
        jsl rlUnknown8483F3
        lda #$0000
        sta aUnitMenuStaffSlots
        sta aUnitMenuItemSlots
        sta aUnitMenuCastleStaffSlots
        lda #$0001
        sta wR0

        _F91B
        jsr rsAddSlotIfStaffHasTargets
        jsr rsAddSlotIfStaffHasCastleTargets
        inc wR0
        lda wR0
        cmp #$0008
        bcs _F92E
        jml _F91B


        _F92E
        pla
        sta wR1
        pla
        sta wR0
        ply
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 84/F939

    .endsection Unsorted84F8D9Section


    .section Unsorted84FED2Section

      .al
      .xl

      rlFindTargetsForItemRange ; 84/FED2

        .al
        .xl
        .autsiz
        .databank ?

        ; Finds targets with filter A in the item's range; filter 4 (assault) uses only range 2 and only for weapons with minimum range 1.

        phb
        php
        phk
        plb
        .databank $84
        pha
        cmp #$0004
        beq _FEEA
        jsl rlGetItemMinimumRange
        sta wR10
        jsl rlGetItemMaximumRange
        sta wR11
        bra _FEFD


        _FEEA
        jsl rlGetItemMinimumRange
        ora #$0000
        beq _FF05
        cmp #$0002
        bcs _FF05
        inc a
        sta wR10
        sta wR11

        _FEFD
        pla
        jsl rlFindTargetsInRange

        _FF02
        plp
        plb
        .databank ?
        rtl


        _FF05
        pla
        lda #$0000
        bra _FF02

        .databank 0

        ; 84/FF0B

    .endsection Unsorted84FED2Section

