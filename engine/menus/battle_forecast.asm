; The battle forecast: the target's and the attacker's windows while a target is chosen.


    .section Table858D62Section

      .al
      .xl

      aBattleForecastTargetTilemapData ; 85/8D62
        .byte $0A, $13, $88, $83, $7E, $00, $4A, $C5, $7F

      aBattleForecastTargetData ; 85/8D6B
        .long $000000
        .long $000000
        .long aBattleForecastTargetTilemapData
        .byte $00, $02, $01

      procBattleForecastTarget ; 85/8D77
        .structProcInfo "PW", rlProcBattleForecastTargetInit, rlProcBattleForecastTargetFirstCycle, aProcDialogueBoxCode
        .long aBattleForecastTargetData
        .byte $00

    .endsection Table858D62Section


    .section Unsorted858D83Section

      .al
      .xl

      rlProcBattleForecastTargetInit ; 85/8D83

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        ; Shows the target's side of the forecast: aActionStructUnit2. For a staff (wMapActionTargetType 1) the window is shorter.

        jsl rlInitMapMenuProc
        lda #<>aActionStructUnit2
        sta aProcSystem.aBody4,b,x
        lda #$0000
        sta aProcSystem.aBody5,b,x
        lda wMapActionTargetType,b
        cmp #MAP_ACTION_STAFF
        bne _8DA2
        lda #$0D0A
        jsl rlSetMapMenuTilemapArea

        _8DA2
        jsl rlSetMapMenuTextColors
        jsl rlHideMapMenuLayers
        rtl

        .databank 0

        ; 85/8DAB

      rlProcBattleForecastTargetFirstCycle ; 85/8DAB

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        jsr rsBattleForecastCheckClose
        lda #<>rlProcBattleForecastTargetSetUp
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 85/8DB5

      rlProcBattleForecastTargetSetUp ; 85/8DB5

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws the labels (LV, HP and the stat icons), the numbers, and places the window away from the cursor.

        lda wMapCursorState,b
        cmp #MAP_CURSOR_TO_TARGET
        bne _8DC1
        jml _8EA0


        _8DC1
        jsr rsBattleForecastCheckClose
        bcc _8DCA
        jml _8EA0


        _8DCA
        jsl rlLoadMapMenuEntryPointerFromProcBody
        phx
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda #(`aBattleForecastLevelText)<<8
        sta lR18+1
        lda #<>aBattleForecastLevelText
        sta lR18
        ldx #$0702
        jsl rlDrawMapMenuTextLine
        lda wMapActionTargetType,b
        cmp #MAP_ACTION_STAFF
        bne _8E01
        lda #(`aBattleForecastHPText)<<8
        sta lR18+1
        lda #<>aBattleForecastHPText
        sta lR18
        ldx #$0901
        jsl rlDrawMapMenuTextLine
        bra _8E7E


        _8E01
        lda #(`aBattleForecastHPText)<<8
        sta lR18+1
        lda #<>aBattleForecastHPText
        sta lR18
        ldx #$0902
        jsl rlDrawMapMenuTextLine
        lda #$2140
        sta aCurrentTilemapInfo,b
        lda #(`aUnknown858EAD)<<8
        sta lR18+1
        lda #<>aUnknown858EAD
        sta lR18
        ldx #$0B02
        jsl rlDrawMapMenuTileString
        lda #(`aUnknown858EB1)<<8
        sta lR18+1
        lda #<>aUnknown858EB1
        sta lR18
        ldx #$0C02
        jsl rlDrawMapMenuTileString
        lda #(`aUnknown858EB5)<<8
        sta lR18+1
        lda #<>aUnknown858EB5
        sta lR18
        ldx #$0D02
        jsl rlDrawMapMenuTileString
        lda #(`aUnknown858EB9)<<8
        sta lR18+1
        lda #<>aUnknown858EB9
        sta lR18
        ldx #$0E02
        jsl rlDrawMapMenuTileString
        lda #(`aUnknown858EBD)<<8
        sta lR18+1
        lda #<>aUnknown858EBD
        sta lR18
        ldx #$0F02
        jsl rlDrawMapMenuTileString
        lda #(`aUnknown858EC1)<<8
        sta lR18+1
        lda #<>aUnknown858EC1
        sta lR18
        ldx #$1002
        jsl rlDrawMapMenuTileString

        _8E7E
        plx
        jsl rlBattleForecastDrawTarget
        jsl rlBattleForecastAvoidCursor
        bcc _8E92
        sta wMapMenuNewPosition,b
        jsl rlMoveMapMenu
        bra _8E96


        _8E92
        jsl rlDrawMapMenu

        _8E96
        jsl rlShowMapMenuLayers
        lda #<>rlProcBattleForecastTargetCycle
        sta aProcSystem.aHeaderOnCycle,b,x

        _8EA0
        rtl

        .databank 0

        ; 85/8EA1

    .endsection Unsorted858D83Section


    .section Table858EA1Section

      .al
      .xl

      aBattleForecastLevelText ; 85/8EA1

        .enc "SJIS"
        .text "ＬＶ"
        .word $0000
        .enc "none"

      aBattleForecastHPText ; 85/8EA7

        .enc "SJIS"
        .text "ＨＰ"
        .word $0000
        .enc "none"


      aUnknown858EAD ; 85/8EAD
        .byte $44, $45, $46, $00

      aUnknown858EB1 ; 85/8EB1
        .byte $54, $55, $56, $00

      aUnknown858EB5 ; 85/8EB5
        .byte $47, $48, $49, $00

      aUnknown858EB9 ; 85/8EB9
        .byte $57, $58, $59, $00

      aUnknown858EBD ; 85/8EBD
        .byte $4A, $4B, $4C, $00

      aUnknown858EC1 ; 85/8EC1
        .byte $5A, $5B, $5C, $00

    .endsection Table858EA1Section


    .section Unsorted858EC5Section

      .al
      .xl

      rlProcBattleForecastTargetCycle ; 85/8EC5

        .al
        .xl
        .autsiz
        .databank ?

        ; Bit 0 of the proc's bitfield: redraw the numbers (the target changed); bit 1: close.

        lda wMapCursorState,b
        cmp #MAP_CURSOR_TO_TARGET
        beq _8ED3
        jsl rlShowMapMenuLayers
        bra _8ED7


        _8ED3
        jsl rlHideMapMenuLayers

        _8ED7
        lda aProcSystem.aHeaderBitfield,b,x
        bit #$0002
        bne _8F03
        bit #$0001
        beq _8F0F
        and #$FFFE
        sta aProcSystem.aHeaderBitfield,b,x
        jsl rlBattleForecastDrawTarget
        jsl rlBattleForecastAvoidCursor
        bcc _8EFD
        sta wMapMenuNewPosition,b
        jsl rlMoveMapMenu
        bra _8F0F


        _8EFD
        jsl rlDrawMapMenuBG3
        bra _8F0F


        _8F03
        jsl rlCloseMapMenuFromProc
        jsl rlProcEngineFreeProc
        jsl rlRestoreMapMenuTextColors

        _8F0F
        rtl

        .databank 0

        ; 85/8F10

    .endsection Unsorted858EC5Section


    .section Unsorted858F10Section

      .al
      .xl

      rsBattleForecastCheckClose ; 85/8F10

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Bit 1 of the proc's bitfield: closes the window, frees the proc and puts back the text colours; carry set.

        lda aProcSystem.aHeaderBitfield,b,x
        bit #$0002
        beq _8F26
        jsl rlCloseMapMenuFromProc
        jsl rlProcEngineFreeProc
        jsl rlRestoreMapMenuTextColors
        sec
        rts


        _8F26
        clc
        rts

        .databank 0

        ; 85/8F28

    .endsection Unsorted858F10Section


    .section Unsorted858F28Section

      .al
      .xl

      rlBattleForecastAvoidCursor ; 85/8F28

        .al
        .xl
        .autsiz
        .databank ?

        ; Carry set and A = a new position (column 2 or $12) when the window should change sides to stay away from the cursor; aBody5 remembers the side.

        lda wCursorXOffset,b
        cmp #$0080
        bcc _8F47
        lda aProcSystem.aBody5,b,x
        beq _8F5F
        lda #$0000
        sta aProcSystem.aBody5,b,x
        jsl rlGetMapMenuPosition
        and #$FF00
        ora #$0002
        bra _8F5C


        _8F47
        lda aProcSystem.aBody5,b,x
        bne _8F5F
        lda #$0001
        sta aProcSystem.aBody5,b,x
        jsl rlGetMapMenuPosition
        and #$FF00
        ora #$0012

        _8F5C
        sec
        bra _8F60


        _8F5F
        clc

        _8F60
        rtl

        .databank 0

        ; 85/8F61

      rlBattleForecastDrawTarget ; 85/8F61

        .al
        .xl
        .autsiz
        .databank ?

        ; Name, class, weapon and level; then HP over max HP for a staff, or HP, might ("−−" from $FF), defense and adjusted hit (the "100" glyph at 100).

        phb
        php
        phk
        plb
        .databank $85
        phx
        phy
        jsl rlLoadMapMenuEntryPointerFromProcBody
        ldy aProcSystem.aBody4,b,x
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb
        .databank $7E
        lda $0006,b,y
        sta wSelectedUnitDataRAMPointer,b
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda #(`aBattleForecastBlankText)<<8
        sta lR18+1
        lda #<>aBattleForecastBlankText
        sta lR18
        ldx #$0101
        jsl rlDrawMapMenuTextLine
        lda #(`aBattleForecastBlankText)<<8
        sta lR18+1
        lda #<>aBattleForecastBlankText
        sta lR18
        ldx #$0301
        jsl rlDrawMapMenuTextLine
        lda #(`aBattleForecastBlankText)<<8
        sta lR18+1
        lda #<>aBattleForecastBlankText
        sta lR18
        ldx #$0501
        jsl rlDrawMapMenuTextLine
        ldx #$0101
        jsl rlDrawSelectedUnitNameInMapMenu
        ldx #$0301
        jsl rlDrawSelectedUnitClassInMapMenu
        lda $0028,b,y
        jsl rlGetItemDataROMPointer
        ldx #$0501
        jsl rlDrawItemNameInMapMenu
        lda #$24F0
        sta aCurrentTilemapInfo,b
        jsl rlGetSelectedUnitLevel
        ldx #$0706
        jsl rlDrawMapMenuNumber
        lda wMapActionTargetType,b
        cmp #MAP_ACTION_STAFF
        bne _9017
        lda $0010,b,y
        ldx #$0904
        jsl rlDrawMapMenuNumber
        lda $0012,b,y
        ldx #$0907
        jsl rlDrawMapMenuNumber
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda #(`aBattleForecastSlashText)<<8
        sta lR18+1
        lda #<>aBattleForecastSlashText
        sta lR18
        ldx #$0906
        jsl rlDrawMapMenuTextLine
        bra _9073


        _9017
        lda $0010,b,y
        ldx #$0906
        jsl rlDrawMapMenuNumber
        lda $003A,b,y
        cmp #$00FF
        bcs _9032
        ldx #$0B06
        jsl rlDrawMapMenuNumber
        bra _904F


        _9032
        lda #$2400
        sta aCurrentTilemapInfo,b
        lda #(`aBattleForecastDoubleDashText)<<8
        sta lR18+1
        lda #<>aBattleForecastDoubleDashText
        sta lR18
        ldx #$0B06
        jsl rlDrawMapMenuTextLine
        lda #$24F0
        sta aCurrentTilemapInfo,b

        _904F
        lda $003C,b,y
        ldx #$0D06
        jsl rlDrawMapMenuNumber
        lda $0032,b,y
        cmp #$0064
        beq _906D
        lda $0032,b,y
        ldx #$0F06
        jsl rlDrawMapMenuNumber
        bra _9073


        _906D
        ldx #$0F05
        jsr rsDrawMapMenuNumber100

        _9073
        ply
        plx
        plp
        plb
        .databank $7E
        rtl

        .databank 0

        ; 85/9078

    .endsection Unsorted858F28Section


    .section Table859078Section

      .al
      .xl

      aBattleForecastSlashText ; 85/9078

        .enc "SJIS"
        .text "／"
        .word $0000
        .enc "none"

      aBattleForecastDashText ; 85/907C

        .enc "SJIS"
        .text "−"
        .word $0000
        .enc "none"

      aBattleForecastBlankText ; 85/9080

        .enc "SJIS"
        .text "　　　　　　　　"
        .word $0000
        .enc "none"

      aBattleForecastDoubleDashText ; 85/9092

        .enc "SJIS"
        .text "−−"
        .word $0000
        .enc "none"


      aBattleForecastAttackerTilemapData ; 85/9098
        .byte $04, $0A, $88, $83, $7E, $00, $4A, $C9, $7F

      aBattleForecastAttackerData ; 85/90A1
        .long $000000
        .long $000000
        .long aBattleForecastAttackerTilemapData
        .byte $01, $0A, $09

      procBattleForecastAttacker ; 85/90AD
        .structProcInfo "PW", rlProcBattleForecastAttackerInit, rlProcBattleForecastAttackerFirstCycle, aProcBattleForecastAttackerCode
        .long aBattleForecastAttackerData
        .byte $00

    .endsection Table859078Section


    .section Unsorted8590B9Section

      .al
      .xl

      rlProcBattleForecastAttackerInit ; 85/90B9

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        ; The attacker's side of the forecast: aActionStructUnit1's HP, might, defense and adjusted hit.

        jsl rlInitMapMenuProc
        lda #$0000
        sta aProcSystem.aBody5,b,x
        jsl rlHideMapMenuLayers
        rtl

        .databank 0

        ; 85/90C8

      rlProcBattleForecastAttackerFirstCycle ; 85/90C8

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        jsr rsBattleForecastCheckClose
        lda #<>rlProcBattleForecastAttackerSetUp
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 85/90D2

      rlProcBattleForecastAttackerSetUp ; 85/90D2

        .al
        .xl
        .autsiz
        .databank ?

        lda wMapCursorState,b
        cmp #MAP_CURSOR_TO_TARGET
        beq _9107
        jsr rsBattleForecastCheckClose
        bcs _9107
        jsl rlLoadMapMenuEntryPointerFromProcBody
        jsr rsBattleForecastDrawAttacker
        jsl rlBattleForecastAvoidCursor
        bcc _90F9
        clc
        adc #$0008
        sta wMapMenuNewPosition,b
        jsl rlMoveMapMenu
        bra _90FD


        _90F9
        jsl rlDrawMapMenu

        _90FD
        jsl rlShowMapMenuLayers
        lda #<>rlProcBattleForecastAttackerCycle
        sta aProcSystem.aHeaderOnCycle,b,x

        _9107
        rtl

        .databank 0

        ; 85/9108

    .endsection Unsorted8590B9Section


    .section Unsorted859108Section

      .al
      .xl

      rlProcBattleForecastAttackerCycle ; 85/9108

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlLoadMapMenuEntryPointerFromProcBody
        lda aProcSystem.aHeaderBitfield,b,x
        bit #$0002
        bne _914F
        lda aProcSystem.aHeaderBitfield,b,x
        bit #$0001
        bne _9121
        bit #$0008
        bne _9157

        _9121
        and #$FFFB
        ora #$0008
        sta aProcSystem.aHeaderBitfield,b,x
        jsr rsBattleForecastDrawAttacker
        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFE
        sta aProcSystem.aHeaderBitfield,b,x
        jsl rlBattleForecastAvoidCursor
        bcc _9149
        clc
        adc #$0008
        sta wMapMenuNewPosition,b
        jsl rlMoveMapMenu
        bra _9157


        _9149
        jsl rlDrawMapMenu
        bra _9157


        _914F
        jsl rlCloseMapMenuFromProc
        jsl rlProcEngineFreeProc

        _9157
        rtl

        .databank 0

        ; 85/9158

      aProcBattleForecastAttackerCode ; 85/9158

        PROC_HALT

    .endsection Unsorted859108Section


    .section Unsorted85915ASection

      .al
      .xl

      rsBattleForecastDrawAttacker ; 85/915A

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $85
        phy
        phx
        jsl rlLoadMapMenuEntryPointerFromProcBody
        ldy #<>aActionStructUnit1
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb
        .databank $7E
        lda #$24F0
        sta aCurrentTilemapInfo,b
        lda structActionStructEntry.CurrentHP,b,y
        ldx #$0101
        jsl rlDrawMapMenuNumber
        lda $003A,b,y
        ldx #$0301
        jsl rlDrawMapMenuNumber
        lda $003C,b,y
        ldx #$0501
        jsl rlDrawMapMenuNumber
        lda $0032,b,y
        cmp #$0064
        beq _91A7
        lda $0032,b,y
        ldx #$0701
        jsl rlDrawMapMenuNumber
        bra _91AD


        _91A7
        ldx #$0700
        jsr rsDrawMapMenuNumber100

        _91AD
        plx
        ply
        plp
        plb
        .databank $7E
        rts

        .databank 0

        ; 85/91B2

      rlShowBattleForecast ; 85/91B2

        .al
        .xl
        .autsiz
        .databank ?

        ; Unless wMapActionTargetType is 2-4: computes the battle stats and opens or refreshes the target's window, and the attacker's unless it is a staff (type 1).

        phb
        php
        phk
        plb
        .databank $85
        phx
        lda wMapActionTargetType,b
        cmp #MAP_ACTION_HELP
        beq _9219
        cmp #MAP_ACTION_GIVE_GOLD
        beq _9219
        cmp #MAP_ACTION_TALK
        beq _9219
        jsl rlActionStructGetBattleStats
        lda #(`procBattleForecastTarget)<<8
        sta lR44+1
        lda #<>procBattleForecastTarget
        sta lR44
        jsl rlProcEngineFindProc
        bcs _91E6
        lda #$0005
        jsl rlProcEngineCreateProcByIndex
        bra _91EF


        _91E6
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0001
        sta aProcSystem.aHeaderBitfield,b,x

        _91EF
        lda wMapActionTargetType,b
        cmp #MAP_ACTION_STAFF
        beq _9219
        lda #(`procBattleForecastAttacker)<<8
        sta lR44+1
        lda #<>procBattleForecastAttacker
        sta lR44
        jsl rlProcEngineFindProc
        bcs _9210
        lda #$0004
        jsl rlProcEngineCreateProcByIndex
        bra _9219


        _9210
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0001
        sta aProcSystem.aHeaderBitfield,b,x

        _9219
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 85/921D

      rlCloseBattleForecast ; 85/921D

        .al
        .xl
        .autsiz
        .databank ?

        ; Sets bit 1 (close) in both forecast procs and runs them once.

        phb
        php
        phk
        plb
        .databank $85
        phx
        lda wR0
        pha
        lda wR1
        pha
        lda #(`procBattleForecastTarget)<<8
        sta lR44+1
        lda #<>procBattleForecastTarget
        sta lR44
        jsl rlProcEngineFindProc
        bcc _9262
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0002
        sta aProcSystem.aHeaderBitfield,b,x
        jsl rlProcBattleForecastTargetCycle
        lda #(`procBattleForecastAttacker)<<8
        sta lR44+1
        lda #<>procBattleForecastAttacker
        sta lR44
        jsl rlProcEngineFindProc
        bcc _9262
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0002
        sta aProcSystem.aHeaderBitfield,b,x
        jsl rlProcBattleForecastAttackerCycle

        _9262
        pla
        sta wR1
        pla
        sta wR0
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 85/926C

    .endsection Unsorted85915ASection


