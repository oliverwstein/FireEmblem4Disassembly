; The courtyard and the town. The courtyard shows the units waiting in the castle
; on a 4x6 grid; each character has a fixed slot and spot (aCastleGridCharacters*,
; aCastleCourtyardSpots*). A on a unit opens the six unit commands: town, sortie,
; guard, class change, staff or dance, give. Town opens the town screen with up to
; six facility buttons; the castle's facility bits (rlGetCastleFacilities) decide
; which are open. wCastleCursorState says which of these has the cursor.
; Also: the castle's song (aCastleSongs) and the courtyard unit sprites. Bank $8A.


    .section Unsorted8A8208Section

      .al
      .xl

      rlCastleCourtyardStep ; 8A/8208

        .al
        .xl
        .autsiz
        .databank ?

        ; Runs the courtyard every frame: dispatches on wCastleCursorState to the unit grid, the unit command menu or the town's facility buttons, and draws the cursor.

        lda wMapSystemFlags,b
        bit #$0020
        beq _8214
        jml rlMinimapStep


        _8214
        lda wCastleCursorState,b
        cmp #CASTLE_CURSOR_COMMANDS
        beq _8223
        cmp #CASTLE_CURSOR_TOWN
        beq _8227
        bra _822B


        _8223
        jml _82C8


        _8227
        jml rlCastleTownStep


        _822B
        lda wJoy1New
        bit #$A0C0
        beq _824A
        jsr rsCastleCourtyardButtons
        stz wMapScrollDirectionIdentifier,b
        lda wCastleCursorState,b
        cmp #CASTLE_CURSOR_STAFF_TARGET
        beq _827D
        cmp #CASTLE_CURSOR_GAVE
        bne _8266
        stz wCastleCursorState,b
        bra _827D


        _824A
        lda wJoy1Input
        sta wMapScrollDirectionIdentifier,b
        beq _8266
        lda wCastleCursorState,b
        cmp #CASTLE_CURSOR_STAFF_TARGET
        beq _8263
        cmp #CASTLE_CURSOR_GIVE_TARGET
        beq _8263
        jsr rsCastleGridMoveCursor
        bra _8266


        _8263
        jsr rsCastleGridMoveToTarget

        _8266
        lda wCastleGridCursorXPixel,b
        sec
        sbc #$0012
        sta wR0
        lda wCastleGridCursorYPixel,b
        sec
        sbc #$0008
        sta wR1
        lda #$0000
        bra _827E


        _827D
        rtl


        _827E
        sep #$20
        lda #$88
        pha
        plb
        .databank $88
        rep #$20
        ldy #<>aMapCursorSprite
        lda wCastleGridCursorXPixel,b
        sec
        sbc #$0008
        sta wR0
        lda wCastleGridCursorYPixel,b
        sec
        sbc #$0008
        sta wR1
        lda #$0000
        sta wR5
        lda #$0000
        sta wR4
        lda wCastleCursorState,b
        cmp #CASTLE_CURSOR_STAFF_TARGET
        beq _82B4
        cmp #CASTLE_CURSOR_GIVE_TARGET
        beq _82B4
        bra _82B9


        _82B4
        lda #$0006
        sta wR4

        _82B9
        lda wVBlankEnabledFramecount
        and #$0018
        beq _82C3
        ldy #<>aMapCursorSpriteWide

        _82C3
        jsl rlPushToOAMBuffer
        rtl


        _82C8
        jsr rsCastleUnitCommandMenuInput
        lda wJoy1New
        beq _82DC
        jsr rsCastleCourtyardButtons
        lda wCastleCursorState,b
        beq _82DC
        cmp #CASTLE_CURSOR_TOWN
        beq _8313

        _82DC
        lda wCastleUnitCommand,b
        tax
        lda aCastleUnitCommandCursorX,x
        and #$00FF
        clc
        adc #$0004
        sta wR0
        lda #$00A8
        sta wR1
        lda #$0000
        jsl rlDrawHandCursor
        lda #$00A0
        sta wR0
        lda #$0060
        sta wR1
        ldx #$0000
        jsr rsPushCourtyardPortraitSprites
        lda wCastleGridCursorYPixel,b
        cmp #$00B0
        bcs _8313
        bra _8314


        _8313
        rtl


        _8314
        sep #$20
        lda #$88
        pha
        plb
        .databank $88
        rep #$20
        ldy #<>aMapCursorSprite
        lda wCastleGridCursorXPixel,b
        sec
        sbc #$0008
        sta wR0
        lda wCastleGridCursorYPixel,b
        sec
        sbc #$0008
        sta wR1
        lda #$0000
        sta wR5
        lda #$0004
        sta wR4
        ldy #<>aMapCursorSpriteWideTwoPalettes
        jsl rlPushToOAMBuffer
        rtl

        .databank 0

      aCastleUnitCommandCursorX ; 8A/8343
        .byte $18, $38, $58, $78, $98, $B8

      rlCastleTownStep ; 8A/8349

        .al
        .xl
        .autsiz
        .databank ?

        ; Runs the town screen (wCastleCursorState 3): moves between the facility buttons, handles the buttons and draws the button cursor and the unit's portrait.

        jsr rsCastleTownFacilityInput
        lda wJoy1New
        jsr rsCastleCourtyardButtons
        lda wCastleCursorState,b
        cmp #$0002
        bcc _8386
        lda wCastleTownFacility,b
        tax
        lda aCastleTownFacilityCursorX,x
        and #$00FF
        sta wR0
        lda aCastleTownFacilityCursorY,x
        and #$00FF
        sta wR1
        lda #$0000
        jsl rlDrawHandCursor
        lda #$00A0
        sta wR0
        lda #$0060
        sta wR1
        ldx #$0000
        jsr rsPushUnitPortraitSprites

        _8386
        rtl

        .databank 0

        ; 8A/8387

    .endsection Unsorted8A8208Section


    .section Data8A8387Section

      .al
      .xl

      aCastleTownFacilityCursorX ; 8A/8387

        ; Read by rlCastleCourtyardStep.

        .word $580C, $0CA0, $A058

        ; 8A/838D

      aCastleTownFacilityCursorY ; 8A/838D

        ; Read by rlCastleCourtyardStep.

        .word $A8A8, $C8A8, $C8C8

        ; 8A/8393

    .endsection Data8A8387Section


    .section Unsorted8A8393Section

      .al
      .xl

      rsCastleGridMoveCursor ; 8A/8393

        .al
        .xl
        .autsiz
        .databank ?

        ; Moves the cursor on the 4x6 courtyard grid with the D-pad; L and R jump to the previous or next occupied slot.

        lda wCastleGridSlot,b
        sta wTempVariable1,b
        and #$001C
        lsr a
        tax
        lda aCastleGridRowFirstSlot,x
        sta wR0
        lda aCastleGridRowLastSlot,x
        sta wR1
        lda wJoy1Repeated
        bit #$0200
        bne _83CB
        bit #$0100
        bne _83D8
        cmp #$0800
        beq _83E5
        cmp #$0400
        beq _83F3
        cmp #$0020
        beq _8420
        cmp #$0010
        beq _8445

        _83CA
        rts


        _83CB
        lda wCastleGridSlot,b
        cmp wR0
        beq _83CA
        sec
        sbc #$0001
        bra _8401


        _83D8
        lda wCastleGridSlot,b
        cmp wR1
        bcs _83CA
        clc
        adc #$0001
        bra _8401


        _83E5
        lda wCastleGridSlot,b
        cmp #$0004
        bcc _83CA
        sec
        sbc #$0004
        bra _8401


        _83F3
        lda wCastleGridSlot,b
        cmp #$0014
        bcs _83CA
        clc
        adc #$0004
        bra _8401


        _8401
        sta wCastleGridSlot,b
        asl a
        tax
        lda aCastleGridCursorX,x
        sta wCastleGridCursorXPixel,b
        lda aCastleGridCursorY,x
        sta wCastleGridCursorYPixel,b
        jsl rlCastleDrawInfoLine
        lda #$0007
        jsl rlPlaySoundEffect
        rts


        _8420
        lda wCastleUnitCount
        beq _847D
        lda wTempVariable1,b
        beq _846D
        sec
        sbc #$0001
        sta wTempVariable1,b

        _8432
        asl a
        tax
        lda aCastleGridCharacters,x
        asl a
        tax
        lda aCastleUnitsByCharacter,x
        beq _8420
        lda wTempVariable1,b
        bra _8401


        _8445
        lda wCastleUnitCount
        beq _847D
        lda wTempVariable1,b
        cmp #$0017
        bcs _8475
        clc
        adc #$0001
        sta wTempVariable1,b

        _845A
        asl a
        tax
        lda aCastleGridCharacters,x
        asl a
        tax
        lda aCastleUnitsByCharacter,x
        beq _8445
        lda wTempVariable1,b
        bra _8401


        _846D
        lda #$0017
        sta wTempVariable1,b
        bra _8432


        _8475
        lda #$0000
        sta wTempVariable1,b
        bra _845A


        _847D
        rts

        .databank 0

        ; 8A/847E

    .endsection Unsorted8A8393Section


    .section Data8A847ESection

      .al
      .xl

      aCastleGridRowFirstSlot ; 8A/847E

        ; Read by rsCastleGridMoveCursor.

        .word $0000, $0004, $0008, $000C, $0010, $0014

        ; 8A/848A

      aCastleGridRowLastSlot ; 8A/848A

        ; Read by rsCastleGridMoveCursor.

        .word $0003, $0007, $000B, $000F, $0013, $0017

        ; 8A/8496

    .endsection Data8A847ESection


    .section Unsorted8A8496Section

      .al
      .xl

      rlCastleDrawInfoLine ; 8A/8496

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws the line at the bottom of the courtyard: the unit's name with HP or status and turns left, or the castle's name when no unit is under the cursor.

        phk
        plb
        .databank $8A
        lda #(`aCastleMenuTilemapData)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aCastleMenuTilemapData
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$3000
        sta aCurrentTilemapInfo,b
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0200, $80, $B000

        lda #(`aCastleInfoLineBlankText)<<8
        sta lRoutineVariable+1,b
        lda #<>aCastleInfoLineBlankText
        sta lRoutineVariable,b
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$0104
        jsl rlDrawMenuTextLine
        sep #$20
        lda #$15
        sta bBufferTM
        rep #$20
        lda wCastleCursorState,b
        beq _84EF
        cmp #CASTLE_CURSOR_STAFF_TARGET
        beq _84EF
        cmp #CASTLE_CURSOR_GIVE_TARGET
        beq _84EF
        jml _857E


        _84EF
        lda wCastleGridSlot,b
        asl a
        tax
        lda aCastleGridCharacters,x
        asl a
        tax
        lda aCastleUnitsByCharacter,x
        beq _857E
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitNamePointer
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$0108
        jsl rlDrawMenuTextLine
        jsl rlGetSelectedUnitStatus
        cmp #StatusHealthy
        bne _8594
        lda #(`aCastleInfoLineHPText)<<8
        sta lRoutineVariable+1,b
        lda #<>aCastleInfoLineHPText
        sta lRoutineVariable,b
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$0110
        jsl rlDrawMenuTextLine
        lda #(`aCastleInfoLineSlashText)<<8
        sta lRoutineVariable+1,b
        lda #<>aCastleInfoLineSlashText
        sta lRoutineVariable,b
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$0115
        jsl rlDrawMenuTextLine
        jsl rlGetSelectedUnitCurrentHP
        ldx #$30F0
        stx aCurrentTilemapInfo,b
        ldx #$0113
        jsl rlDrawTallTwoDigitNumberToTilemapEntry
        jsl rlGetSelectedUnitMaxHP
        ldx #$30F0
        stx aCurrentTilemapInfo,b
        ldx #$0116
        jsl rlDrawTallTwoDigitNumberToTilemapEntry
        rtl


        _857E
        jsl rlGetEventLocationEntryCastleName
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$010C
        jsl rlDrawMenuTextLine
        rtl


        _8594
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda aConditionNamePointers+1,x
        sta lRoutineVariable+1,b
        lda aConditionNamePointers,x
        sta lRoutineVariable,b
        lda #$3400
        sta aCurrentTilemapInfo,b
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$010E
        jsl rlDrawMenuTextLine
        lda #(`aCastleInfoLineTurnsLeftText)<<8
        sta lRoutineVariable+1,b
        lda #<>aCastleInfoLineTurnsLeftText
        sta lRoutineVariable,b
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$0114
        jsl rlDrawMenuTextLine
        jsl rlGetSelectedUnitStatusDuration
        ldx #$34F0
        stx aCurrentTilemapInfo,b
        ldx #$0117
        jsl rlDrawTallTwoDigitNumberToTilemapEntry
        rtl

        .databank 0

        ; 8A/85EF

    .endsection Unsorted8A8496Section


    .section Table8A85EFSection

      .al
      .xl

      aCastleInfoLineBlankText ; 8A/85EF

        .enc "SJIS"
        .text "　　　　　　　　　　　　　　　　　　　　　　　　"
        .word $0000
        .enc "none"

      aCastleInfoLineHPText ; 8A/8621

        .enc "SJIS"
        .text "ＨＰ"
        .word $0000
        .enc "none"

      aCastleInfoLineSlashText ; 8A/8627

        .enc "SJIS"
        .text "／"
        .word $0000
        .enc "none"

      aCastleInfoLinePartTimeText ; 8A/862B

        .enc "SJIS"
        .text "　　アルバイト"
        .word $0000
        .enc "none"

      aCastleInfoLineTurnsLeftText ; 8A/863B

        .enc "SJIS"
        .text "のこり"
        .word $0000
        .enc "none"


    .endsection Table8A85EFSection


    .section Unsorted8A8643Section

      .al
      .xl

      rsCastleGridMoveToTarget ; 8A/8643

        .al
        .xl
        .autsiz
        .databank ?

        ; While choosing a target for a staff, dance or gift, moves the cursor to the previous or next unit in the target list.

        lda wCastleGridSlot,b
        sta wTempVariable1,b
        lda wJoy1Repeated
        bit #$0200
        bne _8670
        bit #$0100
        bne _866A
        cmp #$0800
        beq _8670
        cmp #$0400
        beq _866A
        cmp #$0020
        beq _8670
        cmp #$0010
        beq _866A
        rts


        _866A
        jsr rsCastleGridFindNextTarget
        bcs _8676
        rts


        _8670
        jsr rsCastleGridFindPreviousTarget
        bcs _8676
        rts


        _8676
        jsl rlCastleDrawInfoLine
        lda #$0007
        jsl rlPlaySoundEffect
        rts

        .databank 0

        ; 8A/8682

      aCourtyardOuterColumnSlotsUnused ; 8A/8682

        ; Unreferenced: the courtyard grid slots of the left column (0, 4 ... 20) and
        ; the right column (3, 7 ... 23).

        .word $0000, $0004, $0008, $000C, $0010, $0014, $0003, $0007
        .word $000B, $000F, $0013, $0017

    .endsection Unsorted8A8643Section


    .section Unsorted8A869ASection

      .al
      .xl

      rsCastleGridFindPreviousTarget ; 8A/869A

        .al
        .xl
        .autsiz
        .databank ?

        lda wCastleGridSlot,b
        sta wTempVariable1,b
        sta wTempVariable2,b

        _86A3
        lda wCastleUnitCount
        beq _870B
        lda wTempVariable1,b
        beq _86E6
        sec
        sbc #$0001
        sta wTempVariable1,b

        _86B5
        asl a
        tax
        lda aCastleGridCharacters,x
        asl a
        tax
        lda aCastleUnitsByCharacter,x
        beq _86A3
        sta wRoutineVariable1,b
        lda wSelectedUnitDataRAMPointer,b
        pha
        lda wRoutineVariable1,b
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitDeploymentOffset
        sta wRoutineVariable1,b
        jsl rlCheckInCastleTargetList
        pla
        sta wSelectedUnitDataRAMPointer,b
        bcc _86A3
        lda wTempVariable1,b
        bra _86EE


        _86E6
        lda #$0017
        sta wTempVariable1,b
        bra _86B5


        _86EE
        sta wCastleGridSlot,b
        asl a
        tax
        lda aCastleGridCursorX,x
        sta wCastleGridCursorXPixel,b
        lda aCastleGridCursorY,x
        sta wCastleGridCursorYPixel,b
        lda wTempVariable1,b
        cmp wTempVariable2,b
        beq _870B
        sec
        rts


        _870B
        clc
        rts

        .databank 0

        ; 8A/870D

    .endsection Unsorted8A869ASection


    .section Unsorted8A870DSection

      .al
      .xl

      rsCastleGridFindNextTarget ; 8A/870D

        .al
        .xl
        .autsiz
        .databank ?

        lda wCastleGridSlot,b
        sta wTempVariable1,b
        sta wTempVariable2,b

        _8716
        lda wCastleUnitCount
        beq _8781
        lda wTempVariable1,b
        cmp #$0017
        bcs _875C
        clc
        adc #$0001
        sta wTempVariable1,b

        _872B
        asl a
        tax
        lda aCastleGridCharacters,x
        asl a
        tax
        lda aCastleUnitsByCharacter,x
        beq _8716
        sta wRoutineVariable1,b
        lda wSelectedUnitDataRAMPointer,b
        pha
        lda wRoutineVariable1,b
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitDeploymentOffset
        sta wRoutineVariable1,b
        jsl rlCheckInCastleTargetList
        pla
        sta wSelectedUnitDataRAMPointer,b
        bcc _8716
        lda wTempVariable1,b
        bra _8764


        _875C
        lda #$0000
        sta wTempVariable1,b
        bra _872B


        _8764
        sta wCastleGridSlot,b
        asl a
        tax
        lda aCastleGridCursorX,x
        sta wCastleGridCursorXPixel,b
        lda aCastleGridCursorY,x
        sta wCastleGridCursorYPixel,b
        lda wTempVariable1,b
        cmp wTempVariable2,b
        beq _8781
        sec
        rts


        _8781
        clc
        rts

        .databank 0

        ; 8A/8783

    .endsection Unsorted8A870DSection


    .section Unsorted8A8783Section

      .al
      .xl

      rsCastleUnitCommandMenuInput ; 8A/8783

        .al
        .xl
        .autsiz
        .databank ?

        ; Left and right step through the six unit commands.

        lda wJoy1Repeated
        bit #$0200
        bne _8790
        bit #$0100
        bne _879E

        _878F
        rts


        _8790
        lda wCastleUnitCommand,b
        beq _878F
        sec
        sbc #$0001
        sta wCastleUnitCommand,b
        bra _87AD


        _879E
        lda wCastleUnitCommand,b
        cmp #$0005
        bcs _878F
        clc
        adc #$0001
        sta wCastleUnitCommand,b

        _87AD
        jsr rsCastleDrawUnitCommandName
        lda #$0007
        jsl rlPlaySoundEffect
        rts

        .databank 0

        ; 8A/87B8

    .endsection Unsorted8A8783Section


    .section Unsorted8A87B8Section

      .al
      .xl

      rsCastleDrawUnitCommandName ; 8A/87B8

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Draws the selected command's name, in the grey palette when the unit cannot use it.

        lda #(`aCastleMenuTilemapData)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aCastleMenuTilemapData
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$3400
        sta aCurrentTilemapInfo,b
        lda wCastleUnitCommand,b
        asl a
        tax
        jsr (aCastleUnitCommandNameHandlers,x)
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8988, $0100, $80, $B600

        stz wBufferBG2VOFS
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$1903
        jsl rlDrawMenuTextLine
        rts

        .databank 0

        ; 8A/87F3

      aCastleUnitCommandNameHandlers ; 8A/87F3

        .word <>rsCastleUnitCommandNameTown
        .word <>rsCastleUnitCommandNameSortie
        .word <>rsCastleUnitCommandNameGuard
        .word <>rsCastleUnitCommandNameClassChange
        .word <>rsCastleUnitCommandNameStaffOrDance
        .word <>rsCastleUnitCommandNameGive

        ; 8A/87FF

      rsCastleUnitCommandNameSortie ; 8A/87FF

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aCastleUnitCommandSortieText)<<8
        sta lRoutineVariable+1,b
        lda #<>aCastleUnitCommandSortieText
        sta lRoutineVariable,b
        jsl rlCheckUnitCanSortie
        bcc rsCastleUnitCommandNameSetGrey
        rts

        .databank 0

        ; 8A/8812

      rsCastleUnitCommandNameGuard ; 8A/8812

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aCastleUnitCommandGuardText)<<8
        sta lRoutineVariable+1,b
        lda #<>aCastleUnitCommandGuardText
        sta lRoutineVariable,b
        jsl rlCheckUnitCanGuard
        bcc rsCastleUnitCommandNameSetGrey
        rts

        .databank 0

        ; 8A/8825

      rsCastleUnitCommandNameClassChange ; 8A/8825

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aCastleUnitCommandClassChangeText)<<8
        sta lRoutineVariable+1,b
        lda #<>aCastleUnitCommandClassChangeText
        sta lRoutineVariable,b
        lda wCurrentChapter,b
        cmp #$0006
        beq rsCastleUnitCommandNameBlank
        rts

        .databank 0

        ; 8A/883A

      rsCastleUnitCommandNameTown ; 8A/883A

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aCastleUnitCommandTownText)<<8
        sta lRoutineVariable+1,b
        lda #<>aCastleUnitCommandTownText
        sta lRoutineVariable,b
        rts

        .databank 0

        ; 8A/8847

      rsCastleUnitCommandNameGiveGrey ; 8A/8847

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aCastleUnitCommandGiveText)<<8
        sta lRoutineVariable+1,b
        lda #<>aCastleUnitCommandGiveText
        sta lRoutineVariable,b
        bra rsCastleUnitCommandNameSetGrey

        .databank 0

        ; 8A/8855

      rsCastleUnitCommandNameDanceGrey ; 8A/8855

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aCastleUnitCommandDanceText)<<8
        sta lRoutineVariable+1,b
        lda #<>aCastleUnitCommandDanceText
        sta lRoutineVariable,b
        bra rsCastleUnitCommandNameSetGrey

        .databank 0

        ; 8A/8863

      rsCastleUnitCommandNameBlank ; 8A/8863

        ; Runs on into rsCastleUnitCommandNameSetGrey.
        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aCastleUnitCommandBlankText)<<8
        sta lRoutineVariable+1,b
        lda #<>aCastleUnitCommandBlankText
        sta lRoutineVariable,b

        .databank 0

        ; 8A/886F

      rsCastleUnitCommandNameSetGrey ; 8A/886F

        .al
        .xl
        .autsiz
        .databank ?

        lda #$3800
        sta aCurrentTilemapInfo,b
        rts

        .databank 0

        ; 8A/8876

      rsCastleUnitCommandNameGive ; 8A/8876

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda #SkillIDSteal
        jsl rlCheckIfUnitHasSpecifiedPersonalOrClassSkill
        bcs _8887
        jsl rlCheckUnitCanGive
        bcs _8887
        bra rsCastleUnitCommandNameBlank


        _8887
        jsl rlCheckUnitCanGive
        bcc rsCastleUnitCommandNameGiveGrey
        lda #(`aCastleUnitCommandGiveText)<<8
        sta lRoutineVariable+1,b
        lda #<>aCastleUnitCommandGiveText
        sta lRoutineVariable,b
        rts

        .databank 0

        ; 8A/889A

      rsCastleUnitCommandNameStaffOrDance ; 8A/889A

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda #SkillIDDance
        jsl rlCheckIfUnitHasSpecifiedPersonalOrClassSkill
        bcs _88CD
        jsl rlGetSelectedUnitDeploymentOffset
        sta wActiveUnitDeploymentOffset,b
        jsl rlBuildCastleStaffSlotLists
        lda wAIGroupLeaderFieldMovement
        and #$00FF
        bne _88C0
        lda aUnitMenuCastleStaffSlots
        and #$00FF
        beq rsCastleUnitCommandNameBlank

        _88C0
        lda #(`aCastleUnitCommandStaffText)<<8
        sta lRoutineVariable+1,b
        lda #<>aCastleUnitCommandStaffText
        sta lRoutineVariable,b
        rts


        _88CD
        jsl rlCheckUnitCanDance
        bcc rsCastleUnitCommandNameDanceGrey
        lda #(`aCastleUnitCommandDanceText)<<8
        sta lRoutineVariable+1,b
        lda #<>aCastleUnitCommandDanceText
        sta lRoutineVariable,b
        rts

        .databank 0

        ; 8A/88E0

    .endsection Unsorted8A87B8Section


    .section Table8A88E0Section

      .al
      .xl

      aCastleUnitCommandSortieText ; 8A/88E0

        .enc "SJIS"
        .text "　　しゅつげき　　"
        .word $0000
        .enc "none"

      aCastleUnitCommandGuardText ; 8A/88F4

        .enc "SJIS"
        .text "　　しゅび　　　　"
        .word $0000
        .enc "none"

      aCastleUnitCommandClassChangeText ; 8A/8908

        .enc "SJIS"
        .text "　　クラスチェンジ"
        .word $0000
        .enc "none"

      aCastleUnitCommandTownText ; 8A/891C

        .enc "SJIS"
        .text "　　まち　　　　　"
        .word $0000
        .enc "none"

      aCastleUnitCommandStaffText ; 8A/8930

        .enc "SJIS"
        .text "　　つえ　　　　　"
        .word $0000
        .enc "none"

      aCastleUnitCommandBlankText ; 8A/8944

        .enc "SJIS"
        .text "　　　　　　　　　"
        .word $0000
        .enc "none"

      aCastleUnitCommandDanceText ; 8A/8958

        .enc "SJIS"
        .text "　　おどる　　　　"
        .word $0000
        .enc "none"

      aCastleUnitCommandGiveText ; 8A/896C

        .enc "SJIS"
        .text "　　あげる　　　　"
        .word $0000
        .enc "none"


    .endsection Table8A88E0Section


    .section Unsorted8A8980Section

      .al
      .xl

      rsCastleTownFacilityInput ; 8A/8980

        .al
        .xl
        .autsiz
        .databank ?

        ; Moves between the six facility buttons (two rows of three).

        lda wJoy1Repeated
        bit #$0800
        bne _89B6
        bit #$0400
        bne _89C7
        bit #$0200
        bne _8997
        bit #$0100
        bne _89A5

        _8996
        rts


        _8997
        lda wCastleTownFacility,b
        beq _8996
        sec
        sbc #$0001
        sta wCastleTownFacility,b
        bra _89E0


        _89A5
        lda wCastleTownFacility,b
        cmp #$0005
        bcs _8996
        clc
        adc #$0001
        sta wCastleTownFacility,b
        bra _89E0


        _89B6
        lda wCastleTownFacility,b
        cmp #$0003
        bcc _8996
        sec
        sbc #$0003
        sta wCastleTownFacility,b
        bra _89E8


        _89C7
        lda wCastleTownFacility,b
        cmp #$0003
        bcs _8996
        clc
        adc #$0003
        cmp #$0006
        bcc _89DB
        lda #$0005

        _89DB
        sta wCastleTownFacility,b
        bra _89E8


        _89E0
        lda #$0007
        jsl rlPlaySoundEffect
        rts


        _89E8
        lda #$0006
        jsl rlPlaySoundEffect
        rts

        .databank 0

        ; 8A/89F0

      rsCastleCourtyardButtons ; 8A/89F0

        .al
        .xl
        .autsiz
        .databank ?

        ; Once the screen is fully bright and no song is starting: A, B, Select, and X (opens the status screen for the unit under the cursor).

        lda wMusicID,b
        bne _8A1D
        sep #$20
        lda bBufferINIDISP
        rep #$20
        and #$000F
        cmp #$000F
        beq _8A07
        jml _8A1D


        _8A07
        lda wJoy1New
        bit #$0080
        bne _8A1E
        bit #$8000
        bne _8A22
        bit #$0040
        bne _8A2A
        bit #$2000
        bne _8A26

        _8A1D
        rts


        _8A1E
        jsr rsCastleCourtyardPressA
        rts


        _8A22
        jsr rsCastleCourtyardPressB
        rts


        _8A26
        jsr rsCastleOpenMainMenu
        rts


        _8A2A
        lda wCastleCursorState,b
        bne _8A1D
        lda wCastleGridSlot,b
        asl a
        tax
        lda aCastleGridCharacters,x
        asl a
        tax
        lda aCastleUnitsByCharacter,x
        beq _8A1D
        sta wSelectedUnitDataRAMPointer,b
        sta wCastleStatusScreenUnit
        lda #CASTLE_CURSOR_STATUS_SCREEN
        sta wCastleCursorState,b
        jsl rlGetSelectedUnitDeploymentOffset
        sta wActiveUnitDeploymentOffset,b
        lda #CASTLE_STEP_WAIT
        sta wGameStateStep,b
        lda #<>rsOpenCastleScreen
        sta wStatusScreenCaller
        lda #$0000
        sta wStatusScreenReopenMode
        lda #$0008
        jsl rlPlaySoundEffect
        lda #<>rsOpenStatusScreen
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        rts

        .databank 0

        ; 8A/8A84

      rsCastleCourtyardPressA ; 8A/8A84

        .al
        .xl
        .autsiz
        .databank ?

        lda wCastleCursorState,b
        cmp #CASTLE_CURSOR_COMMANDS
        beq _8AA0
        cmp #CASTLE_CURSOR_TOWN
        beq _8AA4
        cmp #CASTLE_CURSOR_STAFF_TARGET
        beq _8AA8
        cmp #CASTLE_CURSOR_GIVE_TARGET
        beq _8AA8
        jml _8B48


        _8A9F
        rts


        _8AA0
        jsr rsCastleRunUnitCommand
        rts


        _8AA4
        jsr rsCastleEnterFacility
        rts


        _8AA8
        lda wCastleGridSlot,b
        asl a
        tax
        lda aCastleGridCharacters,x
        asl a
        tax
        lda aCastleUnitsByCharacter,x
        beq _8A9F
        sta wRoutineVariable1,b
        ldx wActiveUnitDeploymentOffset,b
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        cmp wRoutineVariable1,b
        beq _8B3C
        lda wSelectedUnitDataRAMPointer,b
        pha
        lda wRoutineVariable1,b
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitDeploymentOffset
        sta wRoutineVariable1,b
        jsl rlCheckInCastleTargetList
        lda wSelectedUnitDataRAMPointer,b
        sta wRoutineVariable1,b
        pla
        sta wSelectedUnitDataRAMPointer,b
        bcc _8B3C
        lda wChapterFlags,b
        bit #$0800
        bne _8B22
        lda wCastleGridSavedSlot,b
        sta wCastleGridSlot,b
        asl a
        tax
        lda aCastleGridCursorX,x
        sta wCastleGridCursorXPixel,b
        lda aCastleGridCursorY,x
        sta wCastleGridCursorYPixel,b
        lda wCastleCursorState,b
        cmp #CASTLE_CURSOR_GIVE_TARGET
        beq _8B17
        jsl rlBuildCastleActionRounds
        rts


        _8B17
        jsl rlCastleGiveMoney
        lda #CASTLE_CURSOR_GAVE
        sta wCastleCursorState,b
        rts


        _8B22
        lda wSelectedUnitDataRAMPointer,b
        pha
        lda wRoutineVariable1,b
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitDeploymentOffset
        sta wMapTargetDeploymentOffset,b
        pla
        sta wSelectedUnitDataRAMPointer,b
        jml _8B92

        .byte $60


        _8B3C
        lda #$0022
        jsl rlPlaySoundEffect
        rts


        _8B44
        jsr rsCastleOpenMainMenu
        rts


        _8B48
        lda wCastleGridSlot,b
        asl a
        tax
        lda aCastleGridCharacters,x
        asl a
        tax
        lda aCastleUnitsByCharacter,x
        beq _8B44
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitStates
        bit #UnitStateMoved
        bne _8B3C
        jsl rlGetSelectedUnitStatus
        cmp #StatusSleep
        beq _8B3C
        sep #$20
        lda #$17
        sta bBufferTM
        rep #$20
        jsr rsCastleDrawUnitCommandName
        lda #CASTLE_CURSOR_COMMANDS
        sta wCastleCursorState,b
        jsl rlGetSelectedUnitCharacterID
        jsl rlLoadCourtyardPortrait
        jsr rsCastleDrawUnitCommandIcons
        lda #$0008
        jsl rlPlaySoundEffect
        rts


        _8B92
        jsl rlSetMapReturnCastleGridStaff
        lda #$0020
        tsb wMapSystemFlags,b
        lda #(`procMinimap)<<8
        sta lR44+1
        lda #<>procMinimap
        sta lR44
        jsl rlProcEngineCreateProc
        rts

        .databank 0

        ; 8A/8BAB

      rsCastleCourtyardPressB ; 8A/8BAB

        .al
        .xl
        .autsiz
        .databank ?

        lda wCastleCursorState,b
        beq _8BD2
        cmp #CASTLE_CURSOR_COMMANDS
        beq _8C28
        cmp #CASTLE_CURSOR_TOWN
        beq _8BD9
        cmp #CASTLE_CURSOR_STAFF_TARGET
        beq _8BF6
        cmp #CASTLE_CURSOR_GIVE_TARGET
        beq _8BF6

        _8BC4
        rts


        _8BC5
        jsl rlSortieUnitFromCastle
        bcs _8BC4
        lda #CASTLE_STEP_EXIT_TO_MAP
        sta wGameStateStep,b
        rts


        _8BD2
        lda #CASTLE_STEP_EXIT_TO_MAP
        sta wGameStateStep,b
        rts


        _8BD9
        lda wCastleScreenHandler,b
        cmp #CASTLE_SCREEN_TOWN
        beq _8BC5
        lda #CASTLE_CURSOR_GRID
        sta wCastleCursorState,b
        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        lda #CASTLE_STEP_RETURN_TO_COURTYARD_2
        sta wGameStateStep,b
        rts


        _8BF6
        lda wCastleGridSavedSlot,b
        sta wCastleGridSlot,b
        asl a
        tax
        lda aCastleGridCursorX,x
        sta wCastleGridCursorXPixel,b
        lda aCastleGridCursorY,x
        sta wCastleGridCursorYPixel,b
        jsl rlCastleDrawInfoLine
        lda #CASTLE_CURSOR_GRID
        sta wCastleCursorState,b
        jsl rlCloseBattleForecast
        lda #$0800
        trb wChapterFlags,b
        lda #$0021
        jsl rlPlaySoundEffect
        rts


        _8C28
        jsr rsCastleCloseUnitCommandMenu
        rts

        .databank 0

        ; 8A/8C2C

      rsCastleCloseUnitCommandMenu ; 8A/8C2C

        .al
        .xl
        .autsiz
        .databank ?

        stz wCastleCursorState,b
        ldx #$07FE
        lda #$00FF

        _8C35
        sta aBG3TilemapBuffer,x
        dec x
        dec x
        bpl _8C35
        jsl rlCastleDrawInfoLine
        lda #(`aCastleMenuTilemapData)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aCastleMenuTilemapData
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$3000
        sta aCurrentTilemapInfo,b
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8988, $0100, $80, $B600

        ldx #$01FE
        lda #$00FF

        _8C66
        sta $7E8088,x
        dec x
        dec x
        bpl _8C66
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8088, $0200, $80, $AD00

        sep #$20
        lda #$15
        sta bBufferTM
        rep #$20
        lda #$0021
        jsl rlPlaySoundEffect
        rts

        .databank 0

        ; 8A/8C8B

      rsCastleOpenMainMenu ; 8A/8C8B

        .al
        .xl
        .autsiz
        .databank ?

        ; Select on the unit grid: opens the same menu the map opens (procMainMapMenu).

        lda wCastleCursorState,b
        bne _8CB6
        ldx #$01FE
        lda #$00FF

        _8C96
        sta $7E8088,x
        dec x
        dec x
        bpl _8C96
        jsr rsCastleLoadWindowPalette
        lda #$0009
        jsl rlPlaySoundEffect
        lda #(`procMainMapMenu)<<8
        sta lR44+1
        lda #<>procMainMapMenu
        sta lR44
        jsl rlProcEngineCreateProc

        _8CB6
        rts

        .databank 0

        ; 8A/8CB7

      rsCastleDrawUnitCommandIcons ; 8A/8CB7

        .al
        .xl
        .autsiz
        .databank ?

        ; Copies the command icon tilemap from aCastleUnitCommandIconTiles and greys out each command the unit cannot use.

        ldx #$001E

        _8CBA
        lda aCastleCourtyardBGPalettes,x
        sta aBGPaletteBuffer,b,x
        dec x
        dec x
        bpl _8CBA
        ldx #$01FE

        _8CC8
        lda aCastleUnitCommandIconTiles,x
        sta $7E8088,x
        dec x
        dec x
        bpl _8CC8
        jsl rlCheckUnitCanSortie
        bcs _8D06
        lda aCastleSortieIconTopTiles
        and #$E3FF
        sta $7E80DA
        lda aCastleSortieIconTopTiles+2
        and #$E3FF
        sta $7E80DC
        lda aCastleSortieIconBottomTiles
        and #$E3FF
        sta $7E811A
        lda aCastleSortieIconBottomTiles+2
        and #$E3FF
        sta $7E811C

        _8D06
        jsl rlCheckUnitCanGuard
        bcs _8D38
        lda aCastleGuardIconTopTiles
        and #$E3FF
        sta $7E80E2
        lda aCastleGuardIconTopTiles+2
        and #$E3FF
        sta $7E80E4
        lda aCastleGuardIconBottomTiles
        and #$E3FF
        sta $7E8122
        lda aCastleGuardIconBottomTiles+2
        and #$E3FF
        sta $7E8124

        _8D38
        lda wCurrentChapter,b
        cmp #$0006
        bne _8D6C
        lda aCastleArenaIconTopTiles
        and #$E3FF
        sta $7E80EA
        lda aCastleArenaIconTopTiles+2
        and #$E3FF
        sta $7E80EC
        lda aCastleArenaIconBottomTiles
        and #$E3FF
        sta $7E812A
        lda aCastleArenaIconBottomTiles+2
        and #$E3FF
        sta $7E812C

        _8D6C
        lda #SkillIDDance
        jsl rlCheckIfUnitHasSpecifiedPersonalOrClassSkill
        bcs _8DC2
        jsl rlGetSelectedUnitDeploymentOffset
        sta wActiveUnitDeploymentOffset,b
        jsl rlBuildCastleStaffSlotLists
        lda wAIGroupLeaderFieldMovement
        and #$00FF
        bne _8DC8
        lda aUnitMenuCastleStaffSlots
        and #$00FF
        beq _8D94
        bra _8DC8


        _8D94
        lda aCastleStaffDanceIconTopTiles
        and #$E3FF
        sta $7E80F2
        lda aCastleStaffDanceIconTopTiles+2
        and #$E3FF
        sta $7E80F4
        lda aCastleStaffDanceIconBottomTiles
        and #$E3FF
        sta $7E8132
        lda aCastleStaffDanceIconBottomTiles+2
        and #$E3FF
        sta $7E8134
        bra _8DC8


        _8DC2
        jsl rlCheckUnitCanDance
        bcc _8D94

        _8DC8
        jsl rlCheckUnitCanGive
        bcs _8DFA
        lda aCastleGiveIconTopTiles
        and #$E3FF
        sta $7E80FA
        lda aCastleGiveIconTopTiles+2
        and #$E3FF
        sta $7E80FC
        lda aCastleGiveIconBottomTiles
        and #$E3FF
        sta $7E813A
        lda aCastleGiveIconBottomTiles+2
        and #$E3FF
        sta $7E813C

        _8DFA
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8088, $0200, $80, $AD00

        rts

        .databank 0

        ; 8A/8E08

    .endsection Unsorted8A8980Section


    .section Unsorted8A8E08Section

      .al
      .xl

      rsCastleLoadCourtyardScreen ; 8A/8E08

        .al
        .xl
        .autsiz
        .databank ?

        ; Blanks the screen and loads the courtyard's graphics, palettes and tilemaps, then draws the info line.

        sep #$20
        lda #$80
        sta $2100,b
        sta bBufferINIDISP
        rep #$20
        jsl rlDisableVBlank
        jsl rlResetHDMAEngine
        lda #$0000
        sta wR1
        lda #$0000
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
        jsl rlLoadMapMenuDecompression80B09B
        jsl rlDMAByStruct

          .structDMAToVRAM g4bppShopScreen, $4000, $80, $0000

        jsl rlDMAByStruct

          .structDMAToVRAM gCastleCourtyardTilemap, $0800, $80, $A000

        ldx #$06FE
        lda #$00FF

        _8E68
        sta aBG2TilemapBuffer.Page1,x
        dec x
        dec x
        bpl _8E68
        jsl rlDMAByStruct

          .structDMAToVRAM $7E7B88, $0700, $80, $A800

        jsl rlDMAByStruct

          .structDMAToVRAM g2bppShopLabels, $0800, $80, $9800

        lda #(`aDecompressionDMAEntry8A8F58)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry8A8F58
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        lda #(`aDecompressionDMAEntry8A8F60)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry8A8F60
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        jsl rlClearVRAM6000
        jsl rlUploadAllStandingMapSprites
        jsl rlDMAByStruct

          .structDMAToVRAM g4bppCursorSprites, $0400, $80, $C000

        ldx #$07FE
        lda #$00FF

        _8EC1
        sta aBG3TilemapBuffer,x
        dec x
        dec x
        bpl _8EC1
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0800, $80, $B000

        ldx #$01FE

        _8ED9
        lda aCastleCourtyardBGPalettes,x
        sta aBGPaletteBuffer,b,x
        dec x
        dec x
        bpl _8ED9
        ldx #$00FE

        _8EE7
        lda aCastleScreenOAMPalettes,x
        sta aOAMPaletteBuffer,b,x
        dec x
        dec x
        bpl _8EE7
        ldx #$001E

        _8EF5
        lda aMapAndCastleSpriteOAMPalettes,x
        sta aOAMPaletteBuffer,b,x
        dec x
        dec x
        bpl _8EF5
        jsl rlLoadWindowGraphics
        sep #$20
        rep #$10
        ldx #<>gcUnknownC02542
        stx DecompressionVariables
        lda #`gcUnknownC02542
        sta $CA
        ldx #$8F88
        stx $CB
        lda #$7E
        sta $CD
        rep #$30
        jsl rlDecompressor
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8F88, $0400, $80, $6C00

        sep #$20
        lda #$15
        sta bBufferTM
        lda #$00
        sta bBufferCGADSUB
        lda #$20
        sta bBufferCOLDATA_1
        lda #$40
        sta bBufferCOLDATA_2
        lda #$80
        sta bBufferCOLDATA_3
        rep #$20
        jsl rlEnableVBlank
        sep #$20
        lda #$00
        sta bBufferINIDISP
        rep #$20
        jsl rlCastleDrawInfoLine
        rts

        .databank 0

        ; 8A/8F56

        ; Unused: 2 zero bytes.
        .fill 2, $00

    .endsection Unsorted8A8E08Section


    .section Unsorted8A8F68Section

      .al
      .xl

      rlCastleRestoreCourtyardPalettes ; 8A/8F68

        .al
        .xl
        .autsiz
        .databank ?

        ; Used by event scenes shown over the courtyard.

        phb
        phk
        plb
        .databank $8A
        ldx #$00FE

        _8F6E
        lda aCastleCourtyardBGPalettes,x
        sta aBGPaletteBuffer,b,x
        dec x
        dec x
        bpl _8F6E
        jsl rlResetHDMAEngine
        sep #$20
        lda #$00
        sta bBufferCGWSEL
        lda #$81
        sta bBufferCGADSUB
        rep #$20
        jsl rlCastleDrawInfoLine
        plb
        .databank $8A
        rtl

        .databank 0

        ; 8A/8F8F

    .endsection Unsorted8A8F68Section


    .section Unsorted8A8F8FSection

      .al
      .xl

      rsCastleRunUnitCommand ; 8A/8F8F

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; A on a unit command; the command index is wCastleUnitCommand.

        lda wCastleUnitCommand,b
        beq _8FE4
        cmp #CASTLE_COMMAND_SORTIE
        beq _8FB6
        cmp #CASTLE_COMMAND_GUARD
        beq _8FDC
        cmp #CASTLE_COMMAND_CLASS_CHANGE
        beq _8FE0
        cmp #CASTLE_COMMAND_STAFF_OR_DANCE
        beq _9002
        cmp #CASTLE_COMMAND_GIVE
        beq _9021
        rts


        _8FAE
        lda #$0022
        jsl rlPlaySoundEffect
        rts


        _8FB6
        jsl rlCheckUnitCanSortie
        bcc _8FAE
        jsl rlSortieUnitFromCastle
        bcs _8FAE
        lda #$000A
        jsl rlPlaySoundEffect
        lda wRoutineVariable1,b
        sta wActiveUnitDeploymentOffset,b
        lda #$FFFF ; pending, becomes MAP_ACTION_MODE_SORTIE
        sta wMapActionMode,b
        lda #CASTLE_STEP_EXIT_TO_MAP
        sta wGameStateStep,b
        rts


        _8FDC
        jsr rsCastleUnitCommandGuard
        rts


        _8FE0
        jsr rsCastleUnitCommandClassChange
        rts


        _8FE4
        jsr rsCastleFadeSongIfChanging
        lda #CASTLE_STEP_FADE_OUT
        sta wGameStateStep,b
        lda #CASTLE_STEP_REOPEN_TOWN
        sta wNextMenuState,b
        lda #$0003
        sta wCastleFadePortrait
        lda #$000A
        jsl rlPlaySoundEffect
        rts


        _9002
        lda wCastleGridSlot,b
        sta wCastleGridSavedSlot,b
        lda #SkillIDDance
        jsl rlCheckIfUnitHasSpecifiedPersonalOrClassSkill
        bcc _9019
        jsl rlCheckUnitCanDance
        bcs _901D
        bra _8FAE


        _9019
        jsr rsCastleUnitCommandStaff
        rts


        _901D
        jsr rsCastleUnitCommandDance
        rts


        _9021
        lda wCastleGridSlot,b
        sta wCastleGridSavedSlot,b
        jsl rlCheckUnitCanGive
        bcc _8FAE
        jsr rsCastleUnitCommandGive
        lda #$000A
        jsl rlPlaySoundEffect
        rts

        .databank 0

        ; 8A/9038

      rsCastleUnitCommandClassChange ; 8A/9038

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda wCurrentChapter,b
        cmp #$0006
        beq _9061
        lda #CASTLE_CURSOR_TOWN
        sta wCastleCursorState,b
        lda #CASTLE_STEP_CLASS_CHANGE_SETUP
        sta wGameStateStep,b
        lda #$0003
        sta wCastleListItemState,b
        lda #KEEPER_CLASS_CHANGE
        sta wKeeper
        lda #$000A
        jsl rlPlaySoundEffect
        rts


        _9061
        lda #$0022
        jsl rlPlaySoundEffect
        rts

        .databank 0

        ; 8A/9069

      rsCastleUnitCommandGuard ; 8A/9069

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlCheckUnitCanGuard
        bcc _90BF
        jsl rlSortieUnitFromCastle
        lda #$000A
        jsl rlPlaySoundEffect
        jsl rlCenterCameraOnLocation
        lda wCursorXOffset,b
        clc
        adc wMapScrollXPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wMapCursorXTile,b
        lda wCursorYOffset,b
        clc
        adc wMapScrollYPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wMapCursorYTile,b
        lda wCursorYOffset,b
        sec
        sbc #$0020
        sta wCursorYOffset,b
        lda #MAP_ACTION_MODE_CASTLE_GUARD
        sta wMapActionMode,b
        lda wRoutineVariable1,b
        sta wActiveUnitDeploymentOffset,b
        tax
        lda #$0001
        jsl rlUnitGuardCastle
        lda #CASTLE_STEP_EXIT_TO_MAP
        sta wGameStateStep,b
        rts


        _90BF
        lda #$0022
        jsl rlPlaySoundEffect
        rts

        .databank 0

        ; 8A/90C7

      rsCastleUnitCommandStaff ; 8A/90C7

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlGetSelectedUnitDeploymentOffset
        sta wActiveUnitDeploymentOffset,b
        jsl rlBuildCastleStaffSlotLists
        lda aUnitMenuStaffSlots ; staves with a target on the map
        and #$00FF
        bne _90E4
        lda aUnitMenuCastleStaffSlots ; staves with a target in the castle
        and #$00FF
        beq _9150

        _90E4
        stz wBufferBG2VOFS
        stz wCastleCursorState,b
        lda #(`aCastleStaffBlankText)<<8
        sta lRoutineVariable+1,b
        lda #<>aCastleStaffBlankText
        sta lRoutineVariable,b
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$1903
        jsl rlDrawMenuTextLine
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8988, $0100, $80, $B600

        ldx #$01FE
        lda #$00FF

        _9119
        sta $7E8088,x
        dec x
        dec x
        bpl _9119
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8088, $0200, $80, $AD00

        lda #$0000
        sta wMapMenuDirtyTop,b
        lda #$0001
        sta wMapMenuDirtyBottom,b
        jsl rlGetMapMenuRows
        jsr rsCastleLoadWindowPalette
        lda #(`procCastleStaffMenu)<<8
        sta lR44+1
        lda #<>procCastleStaffMenu
        sta lR44
        jsl rlProcEngineCreateProc
        rts


        _9150
        lda #$0022
        jsl rlPlaySoundEffect
        rts

        .databank 0

        ; 8A/9158

    .endsection Unsorted8A8F8FSection


    .section Table8A9158Section

      .al
      .xl

      aCastleStaffBlankText ; 8A/9158

        .enc "SJIS"
        .text "　　　　　　　　　　　　　　　　　　　　　　　　"
        .word $0000
        .enc "none"


    .endsection Table8A9158Section


    .section Unsorted8A918ASection

      .al
      .xl

      rsCastleUnitCommandDance ; 8A/918A

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aCastleDanceBlankText)<<8
        sta lRoutineVariable+1,b
        lda #<>aCastleDanceBlankText
        sta lRoutineVariable,b
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$1903
        jsl rlDrawMenuTextLine
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8988, $0100, $80, $B600

        ldx #$01FE
        lda #$00FF

        _91BA
        sta $7E8088,x
        dec x
        dec x
        bpl _91BA
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8088, $0200, $80, $AD00

        jsr rsCastleLoadWindowPalette
        jsl rlBuildCastleDanceRounds
        rts

        .databank 0

        ; 8A/91D7

    .endsection Unsorted8A918ASection


    .section Table8A91D7Section

      .al
      .xl

      aCastleDanceBlankText ; 8A/91D7

        .enc "SJIS"
        .text "　　　　　　　　　　　　　　　　　　　　　　　　"
        .word $0000
        .enc "none"


    .endsection Table8A91D7Section


    .section Unsorted8A9209Section

      .al
      .xl

      rsCastleUnitCommandGive ; 8A/9209

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda #CASTLE_CURSOR_GIVE_TARGET
        sta wCastleCursorState,b
        jsl rlGetSelectedUnitDeploymentOffset
        sta wActiveUnitDeploymentOffset,b
        stz wCastleGridSlot,b
        jsr rsCastleGridFindNextTarget
        lda #(`aCastleGiveBlankText)<<8
        sta lRoutineVariable+1,b
        lda #<>aCastleGiveBlankText
        sta lRoutineVariable,b
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$1903
        jsl rlDrawMenuTextLine
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8988, $0100, $80, $B600

        ldx #$01FE
        lda #$00FF

        _924C
        sta $7E8088,x
        dec x
        dec x
        bpl _924C
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8088, $0200, $80, $AD00

        jsr rsCastleLoadWindowPalette
        jsl rlCastleDrawInfoLine
        rts

        .databank 0

        ; 8A/9269

    .endsection Unsorted8A9209Section


    .section Table8A9269Section

      .al
      .xl

      aCastleGiveBlankText ; 8A/9269

        .enc "SJIS"
        .text "　　　　　　　　　　　　　　　　　　　　　　　　"
        .word $0000
        .enc "none"


    .endsection Table8A9269Section


    .section Unsorted8A929BSection

      .al
      .xl

      rsCastleLoadWindowPalette ; 8A/929B

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$001E

        _929E
        lda aWindowPalette,x
        sta aBGPaletteBuffer,b,x
        dec x
        dec x
        bpl _929E
        rts

        .databank 0

        ; 8A/92AA

    .endsection Unsorted8A929BSection


    .section Unsorted8A92AASection

      .al
      .xl

      rlCastleStartStaffTargetSelection ; 8A/92AA

        .al
        .xl
        .autsiz
        .databank ?

        ; Called by the castle staff menu: wCastleCursorState 4, cursor on the first unit in the target list.

        lda #CASTLE_CURSOR_STAFF_TARGET
        sta wCastleCursorState,b
        stz wCastleGridSlot,b
        jsr rsCastleGridFindNextTarget
        jsl rlCastleDrawInfoLine
        rtl

        .databank 0

        ; 8A/92BB

    .endsection Unsorted8A92AASection


    .section Unsorted8A92BBSection

      .al
      .xl

      rlCastleUseStaffFromMap ; 8A/92BB

        .al
        .xl
        .autsiz
        .databank ?

        ; Called by the castle staff menu for a staff used on the map: puts the unit one tile north of its castle and returns to the map.

        jsl rlCenterCameraOnLocation
        jsl rlSortieUnitNorthOfCastle
        bcs _92D5
        lda wRoutineVariable1,b
        sta wActiveUnitDeploymentOffset,b
        jsl rlSetMapReturnStartCastleStaff
        lda #CASTLE_STEP_EXIT_TO_MAP
        sta wGameStateStep,b

        _92D5
        rtl

        .databank 0

        ; 8A/92D6

    .endsection Unsorted8A92BBSection


    .section Unsorted8A92D6Section

      .al
      .xl

      rlCastleUseStaffFromMapRaised ; 8A/92D6

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Like rlCastleUseStaffFromMap, and also moves the map cursor up 16 pixels.

        jsl rlCenterCameraOnLocation
        jsl rlSortieUnitNorthOfCastle
        bcs _92FE
        lda wRoutineVariable1,b
        sta wActiveUnitDeploymentOffset,b
        jsl rlSetMapReturnStartCastleStaff
        jsl rlSetMapReturnCastleGridStaff
        lda wCursorYOffset,b
        sec
        sbc #$0010
        sta wCursorYOffset,b
        lda #CASTLE_STEP_EXIT_TO_MAP
        sta wGameStateStep,b

        _92FE
        rtl

        .databank 0

        ; 8A/92FF

      rlCastleReopenUnitCommandMenu ; 8A/92FF

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phk
        plb
        .databank $8A
        jsl rlCastleDrawInfoLine
        sep #$20
        lda #$17
        sta bBufferTM
        rep #$20
        jsr rsCastleDrawUnitCommandName
        lda #CASTLE_CURSOR_COMMANDS
        sta wCastleCursorState,b
        jsl rlGetSelectedUnitCharacterID
        jsl rlLoadCourtyardPortrait
        jsl rlDMAByStruct

          .structDMAToVRAM aCastleUnitCommandIconTiles, $0200, $80, $AD00

        lda wCastleGridSavedSlot,b
        sta wCastleGridSlot,b
        asl a
        tax
        lda @l aCastleGridCursorX,x
        sta wCastleGridCursorXPixel,b
        lda @l aCastleGridCursorY,x
        sta wCastleGridCursorYPixel,b
        rtl

        .databank 0

        ; 8A/9342

    .endsection Unsorted8A92D6Section


    .section Unsorted8A9342Section

      .al
      .xl

      rlCastleRefreshUnitsAfterMapAction ; 8A/9342

        .al
        .xl
        .autsiz
        .databank ?

        ; After a map action, rebuilds the castle's unit list if the player's home castle is the castle entered, and puts the cursor back on the saved slot.

        phb
        phx
        phy
        lda #$0000
        jsl rlGetFactionSlotLocationID
        cmp wEnteredCastleLocationID,b
        bne _9364
        lda #$0000
        jsl rlGetLocationEventDataEntry
        jsl rlBuildCastleUnitList
        jsl rlClearMovementMapBuffer
        jsl rlCastleBuildCourtyardTables

        _9364
        lda wCastleGridSavedSlot,b
        sta wCastleGridSlot,b
        asl a
        tax
        lda aCastleGridCursorX,x
        sta wCastleGridCursorXPixel,b
        lda aCastleGridCursorY,x
        sta wCastleGridCursorYPixel,b
        ply
        plx
        plb
        .databank ?
        rtl

        .databank 0

        ; 8A/937E

      rlCastleStartGiveTargetSelection ; 8A/937E

        ; Nothing in the build reaches this; it did not run in fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        lda #CASTLE_CURSOR_GIVE_TARGET
        sta wCastleCursorState,b
        jsl rlCastleDrawInfoLine
        rtl

        .databank 0

        ; 8A/9389

    .endsection Unsorted8A9342Section


    .section Unsorted8A9389Section

      .al
      .xl

      rsCastleEnterFacility ; 8A/9389

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; A on a facility button the castle has (rlGetCastleFacilities): chooses the facility's step and keeper (wKeeper).

        jsl rlGetCastleFacilities
        sta wR0
        lda wCastleTownFacility,b
        asl a
        tax
        lda aCastleTownFacilityBits,x
        sta wR1
        lda wR0
        bit wR1
        beq _93BE
        lda wCastleTownFacility,b
        beq _93EB
        cmp #CASTLE_TOWN_SECONDHAND_SHOP
        beq _93D5
        cmp #CASTLE_TOWN_DEPOT
        beq _9423
        cmp #CASTLE_TOWN_ARENA
        beq _940A
        cmp #CASTLE_TOWN_AUGURY
        beq _9401
        cmp #CASTLE_TOWN_ITEM_SHOP
        beq _93BF

        _93BE
        rts


        _93BF
        lda #CASTLE_STEP_SHOP_SETUP
        sta wGameStateStep,b
        lda #$0004
        sta wCastleListItemState,b
        lda #KEEPER_ITEM_SHOP
        sta wKeeper
        bra _944E

        rts


        _93D5
        lda #CASTLE_STEP_SHOP_SETUP
        sta wGameStateStep,b
        lda #$0005
        sta wCastleListItemState,b
        lda #KEEPER_SECONDHAND_SHOP
        sta wKeeper
        bra _944E

        rts


        _93EB
        lda #CASTLE_STEP_SHOP_SETUP
        sta wGameStateStep,b
        lda #$0004
        sta wCastleListItemState,b
        lda #KEEPER_REPAIR_SHOP
        sta wKeeper
        bra _944E

        rts


        _9401
        lda #CASTLE_STEP_AUGURY_SETUP
        sta wGameStateStep,b
        bra _944E

        rts


        _940A
        lda wSelectedUnitDataRAMPointer,b
        sta wCastleSavedUnitRAMPointer,b
        lda #CASTLE_STEP_ARENA_SETUP
        sta wGameStateStep,b
        lda #KEEPER_ARENA
        sta wKeeper
        stz wArenaFightsWithOpponent,b
        bra _944E

        rts


        _9423
        lda #CASTLE_STEP_DEPOT_SETUP
        sta wGameStateStep,b
        lda #$0002
        sta wCastleListItemState,b
        lda #KEEPER_DEPOT
        sta wKeeper
        bra _944E

        rts

        lda #$C39A
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        rts


        _944E
        lda #$000A
        jsl rlPlaySoundEffect
        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        rts

        .databank 0

        ; 8A/945E

    .endsection Unsorted8A9389Section


    .section Table8A945ESection

      .al
      .xl

      aCastleTownFacilityBits ; 8A/945E

        ; Read by rsCastleEnterFacility.

        .word CastleFacilityRepairShop, CastleFacilitySecondhandShop, CastleFacilityDepot, CastleFacilityArena, CastleFacilityAugury, CastleFacilityItemShop

        ; 8A/946A

    .endsection Table8A945ESection


    .section Unsorted8A97C2Section

      .al
      .xl

      rlCastleOpenTown ; 8A/97C2

        .al
        .autsiz
        .databank ?

        ; Runs chapter event action 6 (character, castle); if an event runs, waits in step $02. Otherwise sets up the town screen and fades in to step $01.

        phk
        plb
        sep #$20
        lda #$80
        sta $2100,b
        sta bBufferINIDISP
        rep #$20

        lda #$0006
        sta bEventActionIdentifier,b
        jsl rlGetSelectedUnitCharacterID
        sta wEventEngineArgument1,b

        ; Holds the LocationID
        lda wEnteredCastleLocationID,b
        sta wEventEngineArgument2,b
        jsl rlGetAndRunChapterMapEventConditions
        bcc +

          lda wSelectedUnitDataRAMPointer,b
          sta wCastleEventUnit,b
          lda #CASTLE_STEP_WAIT
          sta wGameStateStep,b
          rtl

        +
        jsl rlDisableVBlank
        jsl rlResetHDMAEngine

        lda #0
        sta wR1
        lda #0
        sta wR2
        lda #$8000 >> 1
        sta wR3
        sta wR4
        lda #$C000 >> 1
        sta wR5
        lda #$A000 >> 1
        sta wR6
        lda #$A800 >> 1
        sta wR7
        lda #$B000 >> 1
        sta wR8
        jsl rlSetLayerPositionsAndSizes

        jsl rlSetupCastleTownDisplay
        jsl rlGetSelectedUnitCharacterID
        jsl rlLoadUnitPortrait
        jsl rlCastleFillVRAM2400
        lda #1
        sta wCastleFadePortrait
        lda #CASTLE_STEP_FADE_IN
        sta wGameStateStep,b
        lda #CASTLE_STEP_COURTYARD
        sta wNextMenuState,b
        rep #$20
        jsl rlEnableVBlank

        sep #$20
        lda #0
        sta bBufferINIDISP
        rep #$20
        rtl

        .databank 0

        ; 8A/9858

    .endsection Unsorted8A97C2Section


    .section Unsorted8A9858Section

      .al
      .xl

      rlCastleBlankMissingFacilities ; 8A/9858

        .al
        .xl
        .autsiz
        .databank ?

        ; Blanks the button of each facility the castle does not have.

        phk
        plb
        .databank $8A
        lda #$2400
        sta aCurrentTilemapInfo,b
        jsl rlGetCastleFacilities
        sta wTempVariable1,b
        ldx #$000A

        _986A
        lda @l aCastleTownFacilityButtonBits,x
        sta wR1
        lda wTempVariable1,b
        bit wR1
        bne _9897
        lda #(`aCastleTownFacilityBlankText)<<8
        sta lR18+1
        lda #<>aCastleTownFacilityBlankText
        sta lR18
        phx
        lda @l aCastleTownFacilityButtonRow,x
        xba
        clc
        adc @l aCastleTownFacilityButtonColumn,x
        tax
        jsl rlDrawMenuTextLine
        plx

        _9892
        dec x
        dec x
        bpl _986A
        rtl


        _9897
        bra _9892

        .databank 0

        ; 8A/9899

    .endsection Unsorted8A9858Section


    .section Table8A9899Section

      .al
      .xl

      ; unused trailing rtl
        .byte $6B

      aCastleTownFacilityBlankText ; 8A/989A

        .enc "SJIS"
        .text "　　　　　　　　"
        .word $0000
        .enc "none"


    .endsection Table8A9899Section


    .section Table8A98ACSection

      .al
      .xl

      aCastleTownFacilityButtonBits ; 8A/98AC

        ; Read by rlCastleBlankMissingFacilities.

        .word CastleFacilityRepairShop, CastleFacilitySecondhandShop, CastleFacilityDepot, CastleFacilityArena, CastleFacilityAugury, CastleFacilityItemShop

        ; 8A/98B8

    .endsection Table8A98ACSection


    .section Table8A98B8Section

      .al
      .xl

      aCastleTownFacilityButtonColumn ; 8A/98B8

        ; Read by rlCastleBlankMissingFacilities.

        .word $0002, $000B, $0014, $0001, $000B, $0014

        ; 8A/98C4

    .endsection Table8A98B8Section


    .section Data8A98C4Section

      .al
      .xl

      aCastleTownFacilityButtonRow ; 8A/98C4

        ; Read by rlCastleBlankMissingFacilities.

        .word $0015, $0015, $0015, $0019, $0019, $0019

        ; 8A/98D0

    .endsection Data8A98C4Section


    .section Unsorted8A98D0Section

      .al
      .xl

      rlCastleDrawCourtyardUnitSprites ; 8A/98D0

        .al
        .xl
        .autsiz
        .databank ?

        ; From the castle VBlank: draws each unit in the castle as a map sprite at its courtyard spot (normal sprites, then tall ones), grey if DeploymentStateGrayed or DeploymentStateAsleep.

        phk
        plb
        .databank $8A
        lda wVBlankEnabledFramecount
        jsl rlQueueStandingMapSpriteFrames
        sep #$20
        lda #$8A
        pha
        plb
        .databank $8A
        rep #$20
        lda #$0017
        sta wRoutineVariable1,b
        ldx #$002E

        _98E9
        lda aCastleUnitDeploymentOffsets,x
        phx
        cmp #$FFFF
        beq _9958
        tax
        lda aDeploymentTable._UnitRAMPointer,x
        beq _9958
        lda aDeploymentTable,x
        bmi _9958
        and #$0003
        asl a
        tay
        lda $9A3B,b,y
        sta wR5
        lda aDeploymentTable,x
        bit #$0008
        bne _991A
        bit #$2000
        bne _991A
        bra _991F


        _991A
        lda #$0E00
        sta wR5

        _991F
        lda aDeploymentTable._MapSpriteSlot,x
        tax
        lda aDeploymentTable._MapSpriteID,x
        and #$8000
        bne _9958
        lda aShortMapSpriteSlotTiles,x
        sta wR4
        lda #$9A43
        tay
        plx
        phx
        lda aMovementMap,x
        tax
        lda aCastleCourtyardSpriteX,x
        sec
        sbc #$0008
        sta wR0
        lda aCastleCourtyardSpriteY,x
        sec
        sbc #$0008
        sta wR1
        phy
        jsl rlPushToOAMBuffer
        ply

        _9958
        plx
        dec x
        dec x
        bpl _98E9
        lda #$0017
        sta wRoutineVariable1,b
        ldx #$002E

        _9966
        lda aCastleUnitDeploymentOffsets,x
        phx
        cmp #$FFFF
        beq _99D5
        tax
        lda aDeploymentTable._UnitRAMPointer,x
        beq _99D5
        lda aDeploymentTable,x
        bmi _99D5
        and #$0003
        asl a
        tay
        lda $9A3B,b,y
        sta wR5
        lda aDeploymentTable,x
        bit #$0008
        bne _9997
        bit #$2000
        bne _9997
        bra _999C


        _9997
        lda #$0E00
        sta wR5

        _999C
        lda aDeploymentTable._MapSpriteSlot,x
        tax
        lda aDeploymentTable._MapSpriteID,x
        and #$8000
        beq _99D5
        lda aTallMapSpriteSlotTiles,x
        sta wR4
        lda #$9A4A
        tay
        plx
        phx
        lda aMovementMap,x
        tax
        lda aCastleCourtyardSpriteX,x
        sec
        sbc #$0008
        sta wR0
        lda aCastleCourtyardSpriteY,x
        sec
        sbc #$0008
        sta wR1
        phy
        jsl rlPushToOAMBuffer
        ply

        _99D5
        plx
        dec x
        dec x
        bpl _9966
        rtl

        .databank 0

        ; 8A/99DB

    .endsection Unsorted8A98D0Section


    .section Table8A99DBSection

      .al
      .xl

      aCastleGridCursorX ; 8A/99DB

        ; Read by rlCastleRefreshUnitsAfterMapAction.

        .word $0048, $0080, $0091, $00B8, $003F, $0058, $00A8, $00C1
        .word $003D, $0056, $00AA, $00C3, $003B, $0054, $00AC, $00C5
        .word $0039, $0052, $00AE, $00C7, $0037, $0050, $00B0, $00C9

        ; 8A/9A0B

    .endsection Table8A99DBSection


    .section Table8A9A0BSection

      .al
      .xl

      aCastleGridCursorY ; 8A/9A0B

        ; Read by rlCastleRefreshUnitsAfterMapAction.

        .byte $5C, $00, $58, $00, $52, $00, $5C, $00, $74, $00, $74, $00, $74, $00, $74, $00
        .byte $88, $00, $88, $00, $88, $00, $88, $00, $9C, $00, $9C, $00, $9C, $00, $9C, $00
        .byte $B0, $00, $B0, $00, $B0, $00, $B0, $00, $C4, $00, $C4, $00, $C4, $00, $C4, $00
        .byte $00, $02, $00, $04, $00, $06, $00, $08, $01, $00, $00, $C2, $00, $80, $20, $02
        .byte $00, $00, $C2, $00, $40, $21, $00, $C2, $F0, $42, $21

        ; 8A/9A56

    .endsection Table8A9A0BSection


    .section Unsorted8A9A56Section

      .al
      .xl

      rlCastleBuildCourtyardTables ; 8A/9A56

        .al
        .xl
        .autsiz
        .databank ?

        ; Fills the grid (slot to character), the courtyard spots and the character to unit table from aCastleUnitDeploymentOffsets; generation 1 or 2 tables by chapter.

        phk
        plb
        .databank $8A
        lda #$0000
        sta wCastleUnitCount
        lda #$0017
        sta wRoutineVariable1,b
        ldx #$002E

        _9A68
        lda wCurrentChapter,b
        cmp #$0006
        bcs _9A7E
        lda @l aCastleGridCharactersGen1,x
        sta aCastleGridCharacters,x
        lda @l aCastleCourtyardSpotsGen1,x
        bra _9A8A


        _9A7E
        lda @l aCastleGridCharactersGen2,x
        sta aCastleGridCharacters,x
        lda @l aCastleCourtyardSpotsGen2,x

        _9A8A
        asl a
        tay
        lda $9AD4,b,y
        sta aCastleCourtyardSpriteX,x
        lda $9B04,b,y
        sta aCastleCourtyardSpriteY,x
        lda aCastleUnitDeploymentOffsets,x
        bmi _9ACF
        phx
        tax
        lda aDeploymentTable._UnitRAMPointer,x
        plx
        sta wSelectedUnitDataRAMPointer,b
        lda wSelectedUnitDataRAMPointer,b
        beq _9ACF
        jsl rlGetSelectedUnitGenerationID
        dec a
        asl a
        sta aMovementMap,x
        phx
        tax
        lda wSelectedUnitDataRAMPointer,b
        sta aCastleUnitsByCharacter,x
        plx
        lda wCastleUnitCount
        clc
        adc #$0001
        sta wCastleUnitCount

        _9ACF
        dec x
        dec x
        bpl _9A68
        rtl

        .databank 0

        ; 8A/9AD4

    .endsection Unsorted8A9A56Section


    .section Table8A9AD4Section

      .al
      .xl

      aCastleCourtyardSpotX ; 8A/9AD4

        ; Read by rlCastleBuildCourtyardTables.

        .word $0048, $0080, $0091, $00B8, $003F, $0058, $00A8, $00C1
        .word $003D, $0056, $00AA, $00C3, $003B, $0054, $00AC, $00C5
        .word $0039, $0052, $00AE, $00C7, $0037, $0050, $00B0, $00C9

        ; 8A/9B04

    .endsection Table8A9AD4Section


    .section Table8A9B04Section

      .al
      .xl

      aCastleCourtyardSpotY ; 8A/9B04

        ; Read by rlCastleBuildCourtyardTables.

        .word $005C, $0058, $0052, $005C, $0074, $0074, $0074, $0074
        .word $0088, $0088, $0088, $0088, $009C, $009C, $009C, $009C
        .word $00B0, $00B0, $00B0, $00B0, $00C4, $00C4, $00C4, $00C4
        .word $002E, $006C, $0094, $00D4, $0034, $0064, $0096, $00C8
        .word $0034, $0064, $0096, $00C8, $0034, $0064, $0096, $00C8
        .word $0034, $0064, $0096, $00C8, $0034, $0064, $0096, $00C8
        .word $0030, $0030, $0030, $0030, $0050, $0050, $0050, $0050
        .word $0070, $0070, $0070, $0070, $0090, $0090, $0090, $0090
        .word $00B0, $00B0, $00B0, $00B0, $00D0, $00D0, $00D0, $00D0

        ; 8A/9B94

    .endsection Table8A9B04Section


    .section Table8A9B94Section

      .al
      .xl

      aCastleGridCharactersGen1 ; 8A/9B94

        ; Read by rlCastleBuildCourtyardTables.

        .word $0005, $0000, $000F, $0010, $0003, $0001, $0002, $0004
        .word $000D, $0009, $0016, $0006, $0008, $0012, $000A, $000E
        .word $0007, $0015, $0011, $000C, $0013, $0017, $0014, $000B

        ; 8A/9BC4

    .endsection Table8A9B94Section


    .section Table8A9BC4Section

      .al
      .xl

      aCastleGridCharactersGen2 ; 8A/9BC4

        ; Read by rlCastleBuildCourtyardTables.

        .word $0001, $0000, $0012, $000E, $0002, $0010, $0011, $000A
        .word $0008, $0017, $0014, $0007, $000D, $0015, $000F, $0003
        .word $0004, $0013, $0016, $0006, $0005, $0009, $000C, $000B

        ; 8A/9BF4

    .endsection Table8A9BC4Section


    .section Table8A9BF4Section

      .al
      .xl

      aCastleCourtyardSpotsGen1 ; 8A/9BF4

        ; Read by rlCastleBuildCourtyardTables.

        .word $0001, $0005, $0006, $0004, $0007, $0000, $000B, $0010
        .word $000C, $0009, $000E, $0017, $0013, $0008, $000F, $0002
        .word $0003, $0012, $000D, $0014, $0016, $0011, $000A, $0015

        ; 8A/9C24

    .endsection Table8A9BF4Section


    .section Table8A9C24Section

      .al
      .xl

      aCastleCourtyardSpotsGen2 ; 8A/9C24

        ; Read by rlCastleBuildCourtyardTables.

        .byte $01, $00, $00, $00, $04, $00, $0F, $00, $10, $00, $14, $00, $13, $00, $0B, $00
        .byte $08, $00, $15, $00, $07, $00, $17, $00, $16, $00, $0C, $00, $03, $00, $0E, $00
        .byte $05, $00, $06, $00, $02, $00, $11, $00, $0A, $00, $0D, $00, $12, $00, $09, $00
        .byte $6B, $6B

      aCastleTownCOLDATAHDMAInfo ; 8A/9C56
        .byte $61, $9C, $61, $9C, $A8, $9C, $A3, $80, $7F, $32, $00

        ; 8A/9C61

    .endsection Table8A9C24Section


    .section Unsorted8A9C61Section

      .al
      .xl

      rlCastleCopyTownHDMATable ; 8A/9C61

        .al
        .xl
        .autsiz
        .databank ?

        lda wCastleCursorState,b
        cmp #CASTLE_CURSOR_TOWN
        beq _9C87
        jsl rlHDMAEngineFreeEntryByOffset
        bra _9CA5

        .byte $E2, $20, $B9, $AA, $9C, $9F, $A3, $80, $7F, $F0, $2B, $B9, $AB, $9C, $9F, $A4
        .byte $80, $7F, $E8, $E8, $C8, $C8, $80, $EA


        _9C87
        ldx #$0000
        ldy #$0000
        sep #$20

        _9C8F
        lda $9CFE,b,y
        sta $7F80A3,x
        beq _9CA5
        lda $9CFF,b,y
        sta $7F80A4,x
        inc x
        inc x
        inc y
        inc y
        bra _9C8F


        _9CA5
        .al
        rep #$20
        rtl

        .databank 0

        ; 8A/9CA8


      aCastleTownCOLDATAHDMACode ; 8A/9CA8

        HDMA_HALT

      aCastleTownCOLDATATable0 ; 8A/9CAA

        .byte $32, $E0, $0E, $E0, $10, $E0, $10, $E0, $10, $E0, $10, $E0
        .byte $10, $E0, $10, $E1, $10, $E2, $10, $E3, $10, $E4, $10, $E6
        .byte $10, $E8
        .word 0

      aCastleTownCOLDATATable1 ; 8A/9CC6

        .byte $32, $E0, $0E, $E1, $10, $E2, $10, $E4, $10, $E5, $10, $E6
        .byte $10, $E8, $10, $E9, $10, $EA, $10, $EC, $10, $ED, $10, $EE
        .byte $10, $F0
        .word 0

      aCastleTownCOLDATATable2 ; 8A/9CE2

        .byte $32, $E0, $0E, $E1, $10, $E2, $10, $E3, $10, $E4, $10, $E5
        .byte $10, $E6, $10, $E7, $10, $E8, $10, $E9, $10, $EA, $10, $EB
        .byte $10, $EC
        .word 0

      aCastleTownCOLDATATable3 ; 8A/9CFE

        .byte $50, $E0, $1B, $E2, $06, $E3, $0F, $E4, $0E, $E5, $09, $E6
        .byte $09, $E5, $08, $E4, $07, $E5, $09, $E6, $07, $E7, $09, $E8
        .byte $08, $EA, $08, $EB, $08, $ED, $09, $EE, $00, $EF
        .word 0

    .endsection Unsorted8A9C61Section


    .section Unsorted8A9D22Section

      .al
      .xl

      rsCastleFadeSongIfChanging ; 8A/9D22

        .al
        .xl
        .autsiz
        .databank ?

        ; Queues sound command $E0 unless the castle's song is already playing.

        jsl rlGetEventLocationEntryNameID
        asl a
        tax
        lda aCastleSongs,x
        cmp aSoundScriptPrevious,b
        beq _9D38
        lda #$00E0
        jsl rlQueueSoundCommand

        _9D38
        rts

        .databank 0

        ; 8A/9D39

    .endsection Unsorted8A9D22Section


    .section Unsorted8A9D39Section

      .al
      .xl

      rlPlayCastleSong ; 8A/9D39

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Plays the song for the castle's name ID from aCastleSongs (name IDs from $2E use the first entry).

        phk
        plb
        .databank $8A
        jsl rlGetEventLocationEntryNameID
        asl a
        tax
        lda @l aCastleSongs,x
        cmp aSoundScriptPrevious,b
        beq _9D6C
        lda #$00C0
        jsl rlQueueSoundCommand
        jsl rlGetEventLocationEntryNameID
        asl a
        cmp #$005C
        bcs _9D74

        _9D5B
        tax
        lda @l aCastleSongs,x
        cmp aSoundScriptPrevious,b
        beq _9D6C
        sta wMusicID,b
        jsl rlStepMusicScript

        _9D6C
        lda #$00E8
        jsl rlQueueSoundCommand
        rtl


        _9D74
        lda #$0000
        bra _9D5B

        .databank 0

        ; 8A/9D79

    .endsection Unsorted8A9D39Section


    .section Data8A9D79Section

      .al
      .xl

      aCastleSongs ; 8A/9D79

        ; Read by rlPlayCastleSong, rsCastleFadeSongIfChanging.

        .word $006E, $006E, $006E, $006E, $006E, $006E, $006E, $006D
        .word $006D, $006D, $006D, $006D, $006D, $006D, $008C, $008C
        .word $008C, $008C, $008C, $008C, $0089, $0089, $0089, $0089
        .word $0089, $008A, $008A, $008A, $008A, $008A, $008B, $008B
        .word $008B, $0088, $0088, $0088, $0088, $0071, $0071, $0071
        .word $0071, $0057, $0057, $0057, $0057, $0057

        ; 8A/9DD5

    .endsection Data8A9D79Section


    .section DataDA6500Section

      .al
      .xl

      aCastleUnitCommandIconTiles ; DA/6500

        ; Read by rsCastleDrawUnitCommandIcons.

        .word $0035, $0035, $30A8, $30A9, $30AA, $30A9, $30AA, $30A9
        .word $30AA, $308B, $30A9, $30AA, $30A9, $30AA, $308B, $30A9
        .word $30AA, $30A9, $30AA, $308B, $30A9, $30AA, $30A9, $30AA
        .word $308B, $30A9, $30AA, $70AA, $70A9, $70A8, $0035, $0035
        .word $0035, $0035, $30B8, $30B9, $30BA, $3886, $3887, $30B9
        .word $30BA

        ; DA/6552

      aCastleSortieIconTopTiles ; DA/6552

        ; Read by rsCastleDrawUnitCommandIcons.

        .word $3880, $3881, $30B9, $30BA

        ; DA/655A

      aCastleGuardIconTopTiles ; DA/655A

        ; Read by rsCastleDrawUnitCommandIcons.

        .word $3882, $3883, $30B9, $30BA

        ; DA/6562

      aCastleArenaIconTopTiles ; DA/6562

        ; Read by rsCastleDrawUnitCommandIcons.

        .word $3884, $3885, $309B, $30B9

        ; DA/656A

      aCastleStaffDanceIconTopTiles ; DA/656A

        ; Read by rsCastleDrawUnitCommandIcons.

        .word $3888, $3889, $30BA, $309B

        ; DA/6572

      aCastleGiveIconTopTiles ; DA/6572

        ; Read by rsCastleDrawUnitCommandIcons.

        .word $38EA, $38EB, $70BA, $70B9, $70B8, $0035, $0035, $0035
        .word $0035, $30C8, $30C9, $30CA, $3896, $3897, $30C9, $30CA

        ; DA/6592

      aCastleSortieIconBottomTiles ; DA/6592

        ; Read by rsCastleDrawUnitCommandIcons.

        .word $3890, $3891, $30C9, $30CA

        ; DA/659A

      aCastleGuardIconBottomTiles ; DA/659A

        ; Read by rsCastleDrawUnitCommandIcons.

        .word $3892, $3893, $30C9, $30CA

        ; DA/65A2

      aCastleArenaIconBottomTiles ; DA/65A2

        ; Read by rsCastleDrawUnitCommandIcons.

        .word $3894, $3895, $30AB, $30C9

        ; DA/65AA

      aCastleStaffDanceIconBottomTiles ; DA/65AA

        ; Read by rsCastleDrawUnitCommandIcons.

        .word $3898, $3899, $30CA, $30AB

        ; DA/65B2

      aCastleGiveIconBottomTiles ; DA/65B2

        ; Read by rsCastleDrawUnitCommandIcons (continuation of $0200-byte aCastleUnitCommandIconTiles).

        .word $38FA, $38FB, $70CA, $70C9, $70C8, $0035, $0035, $0035
        .word $0035, $30D8, $30D9, $30DA, $30D9, $30DA, $30D9, $30DA
        .word $30BB, $30D9, $30DA, $30D9, $30DA, $30BB, $30D9, $30DA
        .word $30D9, $30DA, $30BB, $30D9, $30DA, $30D9, $30DA, $30BB
        .word $30D9, $30DA, $70DA, $70D9, $70D8, $0035, $0035, $0035
        .word $0035, $30E5, $30E6, $30E7, $30E8, $30E6, $30E7, $30E8
        .word $30E6, $30E7, $30E8, $30E6, $30E7, $30E8, $30E6, $30E7
        .word $30E8, $30E6, $30E7, $30E8, $30E6, $30E7, $30E8, $30E6
        .word $30E7, $30E8, $30E6, $30E7, $30E9, $0035, $0035, $0035
        .word $0035, $30F5, $30F6, $30F7, $30F8, $30F6, $30F7, $30F8
        .word $30F6, $30F7, $30F8, $30F6, $30F7, $30F8, $30F6, $30F7
        .word $30F8, $30F6, $30F7, $30F8, $30F6, $30F7, $30F8, $30F6
        .word $30F7, $30F8, $30F6, $30F7, $30F9, $0035, $0035, $0035
        .word $0035, $30E0, $30E1, $30E2, $30E3, $30E1, $30E2, $30E3
        .word $30E1, $30E2, $30E3, $30E1, $30E2, $30E3, $30E1, $30E2
        .word $30E3, $30E1, $30E2, $30E3, $30E1, $30E2, $30E3, $30E1
        .word $30E2, $30E3, $30E1, $30E2, $30E4, $0035, $0035, $0035
        .word $0035, $30F0, $30F1, $30F2, $30F3, $30F1, $30F2, $30F3
        .word $30F1, $30F2, $30F3, $30F1, $30F2, $30F3, $30F1, $30F2
        .word $30F3, $30F1, $30F2, $30F3, $30F1, $30F2, $30F3, $30F1
        .word $30F2, $30F3, $30F1, $30F2, $30F4, $0035, $0035

        ; DA/6700

    .endsection DataDA6500Section
