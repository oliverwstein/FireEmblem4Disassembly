; Windows for map battles and map actions: the HP windows, the experience windows,
; the map battle text box, and their palettes.


    .section Table85AB82Section

      .al
      .xl

      aMapBattleExperienceWindowHDMAInfo .dstruct structHDMAIndirectEntryInfo, rlMapBattleExperienceWindowHDMAInit, rlMapBattleExperienceWindowHDMACycle, aMapBattleExperienceWindowHDMACode, $7FEA9A, PPU_REG_BASE + $12, $42, $85 ; 85/AB82

    .endsection Table85AB82Section


    .section Unsorted85AB8ESection

      .al
      .xl

      rlMapBattleExperienceWindowHDMAInit ; 85/AB8E

        .al
        .xl
        .autsiz
        .databank ?

        lda wR43
        jsr rsBuildMapBattleExperienceWindowHDMATable

      rlMapBattleExperienceWindowHDMACycle ; 85/AB93

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 85/AB94


      aMapBattleExperienceWindowHDMACode ; 85/AB94

        HDMA_HALT

    .endsection Unsorted85AB8ESection


    .section Unsorted85AB96Section

      .al
      .xl

      rsBuildMapBattleExperienceWindowHDMATable ; 85/AB96

        .al
        .xl
        .autsiz
        .databank ?

        ; A = first line: BG3VOFS $01FF above it, $01FE for the 24 lines of the window.

        phx
        ldx #$0000
        ora #$0000
        beq _ABD2
        cmp #$007F
        bcc _ABC0
        sec
        sbc #$0078
        sta wR0
        sep #$20
        lda #$78
        sta $7FEA9A,x
        rep #$20
        inc x
        lda #<>aMapBattleExperienceWindowScrollAbove
        sta $7FEA9A,x
        inc x
        inc x
        lda wR0

        _ABC0
        sep #$20
        sta $7FEA9A,x
        rep #$20
        inc x
        lda #<>aMapBattleExperienceWindowScrollAbove
        sta $7FEA9A,x
        inc x
        inc x

        _ABD2
        lda #$0018
        sep #$20
        sta $7FEA9A,x
        rep #$20
        lda #<>aMapBattleExperienceWindowScrollWindow
        sta $7FEA9B,x
        lda #$0000
        sta $7FEA9D,x
        plx
        rts

        .databank 0

        ; 85/ABED


      aMapBattleExperienceWindowScrollAbove ; 85/ABED

        .byte $FF, $01

      aMapBattleExperienceWindowScrollWindow ; 85/ABEF

        .byte $FE, $01

    .endsection Unsorted85AB96Section


    .section Unsorted85ABF1Section

      .al
      .xl

      rlFreeHDMAEntryByIndex ; 85/ABF1

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlHDMAEngineFreeEntryByIndex
        rtl

        .databank 0

        ; 85/ABF6

    .endsection Unsorted85ABF1Section


    .section ProcScript85CA85Section

      .al
      .xl

      procMapExperienceWindow ; 85/CA85

        .structProcInfo "OW", rlProcMapExperienceWindowInit, rlProcMapExperienceWindowWaitForMap, aProcMapExperienceWindowCode


        .long aMapExperienceWindowData
        .byte 1

    .endsection ProcScript85CA85Section


    .section Unsorted85CA91Section

      .al
      .xl

      rlProcMapExperienceWindowInit ; 85/CA91

        .al
        .xl
        .autsiz
        .databank ?

        ; wInput0 = experience (low byte) and experience gained (high byte), wInput1 = the maximum (aBody5), wInput2 = deployment offset (aBody6), wInput3 = passed to procUnknown9ECEDD. The target ($1058) is the experience plus the gain, at most the maximum.

        jsl rlInitMapMenuProc
        jsl rlHideMapWindows
        stz $0DB1,b
        lda aProcSystem.wInput0,b
        and #$00FF
        sta aProcSystem.aBody7,b,x
        lda aProcSystem.wInput1,b
        sta aProcSystem.aBody5,b,x
        lda aProcSystem.wInput3,b
        sta $7FEB0A
        lda aProcSystem.wInput0+1,b
        and #$00FF
        clc
        adc aProcSystem.aBody7,b,x
        cmp aProcSystem.aBody5,b,x
        bmi _CAC4
        lda aProcSystem.aBody5,b,x

        _CAC4
        sep #$20
        sta $1058,b,x
        rep #$20
        lda aProcSystem.wInput2,b
        sta aProcSystem.aBody6,b,x
        jsl rlUnknown88B46A
        jsl rlHideMapMenu
        rtl

        .databank 0

        ; 85/CADA

      rlProcMapExperienceWindowWaitForMap ; 85/CADA

        .al
        .xl
        .autsiz
        .databank ?

        ; Waits for wUnknown0007D8 to be 0, then sets bit 0 of the bitfield for the script.

        phb
        phx
        jsl rlUnknown88A12B
        jsl rlUnknown888560
        plx
        plb
        .databank ?
        lda wUnknown0007D8,b
        bne _CAFA
        lda #<>rlProcMapExperienceWindowIdle
        sta aProcSystem.aHeaderOnCycle,b,x
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0001
        sta aProcSystem.aHeaderBitfield,b,x

        _CAFA
        rtl

        .databank 0

        ; 85/CAFB

    .endsection Unsorted85CA91Section


    .section Unsorted85CAFBSection

      .al
      .xl

      rlProcMapExperienceWindowIdle ; 85/CAFB

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 85/CAFC

    .endsection Unsorted85CAFBSection


    .section Unsorted85CAFCSection

      .al
      .xl

      rlProcMapExperienceWindowStartEffect ; 85/CAFC

        .al
        .xl
        .autsiz
        .databank ?

        ; Creates procUnknown9ECEDD at the unit's tile.

        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFE
        sta aProcSystem.aHeaderBitfield,b,x
        lda #<>rlProcMapExperienceWindowWaitEffect
        sta aProcSystem.aHeaderOnCycle,b,x
        phx
        lda aProcSystem.aBody6,b,x
        tax
        lda aDeploymentTable._XTilePosition,x
        sta aProcSystem.wInput0,b
        lda aDeploymentTable._YTilePosition,x
        sta aProcSystem.wInput1,b
        plx
        lda $7FEB0A
        sta aProcSystem.wInput3,b
        lda #(`procUnknown9ECEDD)<<8
        sta lR44+1
        lda #<>procUnknown9ECEDD
        sta lR44
        jsl rlProcEngineCreateProc
        bra rlProcMapExperienceWindowWaitEffect._CB50

        .databank 0

      rlProcMapExperienceWindowWaitEffect ; 85/CB36

        .al
        .xl
        .autsiz
        .databank ?

        stx wR0
        lda #(`procUnknown9ECEDD)<<8
        sta lR44+1
        lda #<>procUnknown9ECEDD
        sta lR44
        jsl rlProcEngineFindProc
        bcs _CB50
        ldx wR0
        lda #<>rlProcMapExperienceWindowShow
        sta aProcSystem.aHeaderOnCycle,b,x

        _CB50
        rtl

        .databank 0

        ; 85/CB51

    .endsection Unsorted85CAFCSection


    .section Unsorted85CB51Section

      .al
      .xl

      rlProcMapExperienceWindowShow ; 85/CB51

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Once its graphics are loaded: places the window by the unit, starts the gradient and draws the number and the bar.

        jsl rlLoadMapBattleHUDGraphics
        bcc _CB58
        rtl


        _CB58
        jsl rlSetMapBattlePalettes
        phx
        jsl rlLoadMapMenuEntryPointerFromProcBody
        jsr rsGetMapExperienceWindowUnitTile
        jsr rsPlaceMapExperienceWindow
        lda wMapMenuNewPosition,b
        and #$FF00
        asl a
        asl a
        asl a
        and #$FF00
        ora #$0018
        sta wR43
        lda #$000A
        sta wR42
        jsl rlStartMapMenuGradient
        plx
        phx
        lda aProcSystem.aBody7,b,x
        ldx #$05A0
        stx aCurrentTilemapInfo,b
        ldx #$0101
        jsl rlDrawMapMenuSmallNumber
        plx
        phx
        lda aProcSystem.aBody7,b,x
        ldy aProcSystem.aBody5,b,x
        ldx #$0980
        stx aCurrentTilemapInfo,b
        ldx #$0103
        jsl rlDrawMapMenuGauge
        plx
        lda #<>rlProcMapExperienceWindowIdle2
        sta aProcSystem.aHeaderOnCycle,b,x
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0001
        sta aProcSystem.aHeaderBitfield,b,x
        jsl rlMoveMapMenu

      rlProcMapExperienceWindowIdle2 ; 85/CBBC

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 85/CBBD

    .endsection Unsorted85CB51Section


    .section Unsorted85CBBDSection

      .al
      .xl

      rlProcMapExperienceWindowStartCount ; 85/CBBD

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFE
        sta aProcSystem.aHeaderBitfield,b,x
        lda #<>rlProcMapExperienceWindowCount
        sta aProcSystem.aHeaderOnCycle,b,x

      rlProcMapExperienceWindowCount ; 85/CBCC

        .al
        .xl
        .autsiz
        .databank ?

        ; Adds 1 every third frame (a tick sound every seventh) until the target.

        phx
        jsl rlLoadMapMenuEntryPointerFromProcBody
        lda $1058,b,x
        and #$00FF
        cmp aProcSystem.aBody7,b,x
        bne _CBED
        lda #<>rlProcMapExperienceWindowIdle3
        sta aProcSystem.aHeaderOnCycle,b,x
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0001
        sta aProcSystem.aHeaderBitfield,b,x
        bra _CC3B


        _CBED
        sep #$20
        dec $0DB2,b
        bpl _CBFF
        lda #$0D
        jsl rlPlaySoundEffect
        lda #$06
        sta $0DB2,b

        _CBFF
        dec $0DB1,b
        bpl _CC0E
        lda #$02
        sta $0DB1,b
        rep #$20
        inc aProcSystem.aBody7,b,x

        _CC0E
        rep #$20
        plx
        phx
        lda aProcSystem.aBody7,b,x
        ldx #$05A0
        stx aCurrentTilemapInfo,b
        ldx #$0101
        jsl rlDrawMapMenuSmallNumber
        plx
        phx
        lda aProcSystem.aBody7,b,x
        ldy aProcSystem.aBody5,b,x
        ldx #$0980
        stx aCurrentTilemapInfo,b
        ldx #$0103
        jsl rlDrawMapMenuGauge
        jsl rlDrawMapMenuBG3

        _CC3B
        plx
        rtl

        .databank 0

        ; 85/CC3D

    .endsection Unsorted85CBBDSection


    .section Unsorted85CC3DSection

      .al
      .xl

      rlProcMapExperienceWindowIdle3 ; 85/CC3D

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 85/CC3E

    .endsection Unsorted85CC3DSection


    .section Unsorted85CC3ESection

      .al
      .xl

      rlProcMapExperienceWindowClose ; 85/CC3E

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlCloseMapMenuFromProc
        jsl rlRestoreMapBattlePalettes
        lda #<>rlProcMapExperienceWindowEnd
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 85/CC4D

    .endsection Unsorted85CC3ESection


    .section Unsorted85CC4DSection

      .al
      .xl

      rlProcMapExperienceWindowEnd ; 85/CC4D

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlLoadMenuIconGraphics
        bcs _CC61
        jsl rlFreeHDMAEntry0
        jsl rlProcEngineFreeProc
        lda #$FFFF
        sta $0DB1,b

        _CC61
        rtl

        .databank 0

        ; 85/CC62

    .endsection Unsorted85CC4DSection


    .section ProcScript85CC62Section

      .al
      .xl

      aProcMapExperienceWindowCode ; 85/CC62

        PROC_YIELD 1
        _CC64
        PROC_YIELD 1
        PROC_JUMP_IF_BITS_UNSET _CC64, $0001
        PROC_SET_UNK_TIMER 30
        _CC70
        PROC_YIELD 1
        PROC_JUMP_WHILE_UNK_TIMER _CC70
        PROC_SET_ONCYCLE rlProcMapExperienceWindowStartEffect
        _CC7A
        PROC_YIELD 1
        PROC_JUMP_IF_BITS_UNSET _CC7A, $0001
        PROC_SET_UNK_TIMER 40
        _CC86
        PROC_YIELD 1
        PROC_JUMP_WHILE_UNK_TIMER _CC86
        PROC_SET_ONCYCLE rlProcMapExperienceWindowStartCount
        _CC90
        PROC_YIELD 1
        PROC_JUMP_IF_BITS_UNSET _CC90, $0001
        PROC_SET_UNK_TIMER 60
        _CC9C
        PROC_YIELD 1
        PROC_JUMP_WHILE_UNK_TIMER _CC9C
        PROC_SET_ONCYCLE rlProcMapExperienceWindowClose
        PROC_HALT


        ; 85/CCA8

    .endsection ProcScript85CC62Section


    .section Unsorted85CCA8Section

      .al
      .xl

      rsGetMapExperienceWindowUnitTile ; 85/CCA8

        .al
        .xl
        .autsiz
        .databank ?

        ; wR0 = the unit's screen tile (row, column).

        phx
        lda aProcSystem.aBody6,b,x
        tax
        lda aDeploymentTable._XTilePosition,x
        sta wR10
        lda aDeploymentTable._YTilePosition,x
        sta wR11
        jsl rlUnknown88BF6C
        lda wR11
        xba
        and #$FF00
        ora wR10
        sta wR0
        plx
        rts

        .databank 0

        ; 85/CCC9

      rsPlaceMapExperienceWindow ; 85/CCC9

        .al
        .xl
        .autsiz
        .databank ?

        ; wMapMenuNewPosition beside the unit's tile, kept on screen.

        lda wR0
        xba
        and #$00FF
        cmp #$0004
        bmi _CCDA
        sec
        sbc #$0003
        bra _CCDC


        _CCDA
        inc a
        inc a

        _CCDC
        xba
        sta wR4
        lda wR0
        and #$00FF
        cmp #$000F
        bmi _CCEF
        sec
        sbc #$000C
        bra _CCF1


        _CCEF
        inc a
        inc a

        _CCF1
        ora wR4
        sta wMapMenuNewPosition,b
        rts

        .databank 0

        ; 85/CCF7


      aMapBattleHPWindowRightTilemapData ; 85/CCF7

        .structMapMenuTilemapData 12, 4, aBG3TilemapBuffer, 0, $7FC54A

      aMapBattleHPWindowRightData ; 85/CD00

        .long 0, 0, aMapBattleHPWindowRightTilemapData
        .byte 3, 16, 16

    .endsection Unsorted85CCA8Section


    .section ProcScript85CD0CSection

      .al
      .xl

      procMapBattleHPWindowRight ; 85/CD0C

        .structProcInfo "OB", rlProcMapBattleHPWindowInit, rlProcMapBattleHPWindowOpen, aProcMapBattleHPWindowCode


        .long aMapBattleHPWindowRightData
        .byte 1

      aMapBattleHPWindowLeftTilemapData ; 85/CD18

        .structMapMenuTilemapData 12, 4, aBG3TilemapBuffer, 0, $7FC94A

      aMapBattleHPWindowLeftData ; 85/CD21

        .long 0, 0, aMapBattleHPWindowLeftTilemapData
        .byte 4, 4, 16

    .endsection ProcScript85CD0CSection


    .section ProcScript85CD2DSection

      .al
      .xl

      procMapBattleHPWindowLeft ; 85/CD2D

        .structProcInfo "OB", rlProcMapBattleHPWindowInit, rlProcMapBattleHPWindowOpen, aProcMapBattleHPWindowCode


        .long aMapBattleHPWindowLeftData
        .byte 1

    .endsection ProcScript85CD2DSection


    .section Unsorted85CD39Section

      .al
      .xl

      rlProcMapBattleHPWindowInit ; 85/CD39

        .al
        .xl
        .autsiz
        .databank ?

        ; wInput3 = action struct (aBody7), wInput2 = position (aBody5; bit 7 sets bit 0 of the bitfield: the window opens from the other side).

        php
        phb
        phy
        phx
        jsr rsMapBattleHPWindowReadInputs
        jsl rlStallProcUntilMapMenuDataLoaded
        lda #$20FF
        sta wMapMenuClearTile,b
        jsl rlClearMapMenuTiles
        lda #$0002
        sta wBufferBG3VOFS
        lda #$0000
        sta wBufferBG3HOFS
        lda aProcSystem.aBody5,b,x
        and #$FF1F
        jsl rlSetMapMenuPosition
        plx
        jsr rsBeginMapBattleHPWindowOpening
        jsl rlDrawMapMenu
        jsl rlShowMapMenuLayers
        ply
        plb
        .databank ?
        plp
        rtl

        .databank 0

        ; 85/CD72

      aUnknown85CD72 ; 85/CD72

        ; Five tile strings for rlDrawTileStringToTilemapEntry. Nothing in the build reads them.
        .byte $20, $2A, $00
        .byte $24, $25, $00
        .byte $22, $23, $00
        .byte $20, $21, $00
        .byte $26, $27, $00

    .endsection Unsorted85CD39Section


    .section Unsorted85CD81Section

      .al
      .xl

      rsMapBattleHPWindowReadInputs ; 85/CD81

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.wInput3,b
        sta aProcSystem.aBody7,b,x
        lda aProcSystem.wInput2,b
        sta aProcSystem.aBody5,b,x
        bit #$0080
        beq _CD9B
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0001
        sta aProcSystem.aHeaderBitfield,b,x

        _CD9B
        rts

        .databank 0

        ; 85/CD9C

      rsMapBattleHPWindowReadHP ; 85/CD9C

        .al
        .xl
        .autsiz
        .databank ?

        ; aBody5, aBody6 = the action struct's HP and max HP.

        phb
        ldy aProcSystem.aBody7,b,x
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb
        .databank $7E
        ldy aProcSystem.aBody7,b,x
        lda $0010,b,y
        sta aProcSystem.aBody5,b,x
        lda $0012,b,y
        sta aProcSystem.aBody6,b,x
        plb
        .databank $7E
        rts

        .databank 0

        ; 85/CDB9

      rsDrawMapBattleHPWindow ; 85/CDB9

        .al
        .xl
        .autsiz
        .databank ?

        ; The HP bar, the unit's name and its HP.

        phx
        lda aProcSystem.aBody5,b,x
        ldy aProcSystem.aBody6,b,x
        ldx #$0980
        stx aCurrentTilemapInfo,b
        ldx #$0203
        jsl rlDrawMapMenuGauge
        plx
        phx
        ldy aProcSystem.aBody7,b,x
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb
        .databank $7E
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda $0006,b,y
        sta wSelectedUnitDataRAMPointer,b
        ldx #$0002
        jsl rlDrawSelectedUnitNameInMapMenu
        plx
        lda #$01A0
        jsr rsGetMapBattleHPWindowTileBase
        sta aCurrentTilemapInfo,b
        phx
        lda aProcSystem.aBody5,b,x
        ldx #$0201
        jsl rlDrawMapMenuSmallNumber
        plx
        jsl rlShowMapMenuLayers
        rts

        .databank 0

        ; 85/CE08

      rsGetMapBattleHPWindowTileBase ; 85/CE08

        .al
        .xl
        .autsiz
        .databank ?

        ; A = tile base: palette by the window's type (3 or 4).

        sta wR0
        jsl rlGetMapMenuType
        cmp #$0004
        beq _CE18
        lda #$0400
        bra _CE1B


        _CE18
        lda #$0C00

        _CE1B
        ora wR0
        rts

        .databank 0

        ; 85/CE1E

      rsBeginMapBattleHPWindowOpening ; 85/CE1E

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aHeaderBitfield,b,x
        bit #$0001
        bne _CE2B
        ldy #$0000
        bra _CE2E


        _CE2B
        ldy #$0001

        _CE2E
        tya
        jsl rlBeginMapMenuOpening
        rts

        .databank 0

        ; 85/CE34

      rsStepMapBattleHPWindowOpening ; 85/CE34

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aHeaderBitfield,b,x
        bit #$0001
        bne _CE41
        ldy #$0000
        bra _CE44


        _CE41
        ldy #$0001

        _CE44
        lda #$040C
        pha
        tya
        xba
        ora #$0008
        tay
        pla
        jsl rlStepMapMenuOpening
        rts

        .databank 0

        ; 85/CE54

    .endsection Unsorted85CD81Section


    .section Unsorted85CE54Section

      .al
      .xl

      rsBeginMapBattleHPWindowClosing ; 85/CE54

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlLoadMapMenuEntryPointerFromProcBody
        lda aProcSystem.aHeaderBitfield,b,x
        bit #$0001
        bne _CE65
        ldy #$0004
        bra _CE68


        _CE65
        ldy #$0003

        _CE68
        tya
        jsl rlBeginMapMenuOpening
        lda #$20FF
        sta wMapMenuClearTile,b
        jsl rlClearMapMenuTiles
        jsl rlDrawMapMenuBG3
        rts

        .databank 0

        ; 85/CE7C

    .endsection Unsorted85CE54Section


    .section Unsorted85CE7CSection

      .al
      .xl

      rsStepMapBattleHPWindowClosing ; 85/CE7C

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aHeaderBitfield,b,x
        bit #$0001
        bne _CE89
        ldy #$0004
        bra _CE8C


        _CE89
        ldy #$0003

        _CE8C
        lda #$040C
        pha
        tya
        xba
        ora #$0005
        tay
        pla
        jsl rlStepMapMenuOpening
        rts

        .databank 0

        ; 85/CE9C

      rsSetMapBattleHPWindowRequest ; 85/CE9C

        .al
        .xl
        .autsiz
        .databank ?

        ; A = request bits for this window: $0DB1 for type 3, $0DAF for type 4.

        pha
        jsl rlGetMapMenuType
        cmp #$0004
        beq _CEAC
        pla
        sta $0DB1,b
        bra _CEB0


        _CEAC
        pla
        sta $0DAF,b

        _CEB0
        rts

        .databank 0

        ; 85/CEB1

      rsGetMapBattleHPWindowRequest ; 85/CEB1

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlGetMapMenuType
        cmp #$0004
        beq _CEBF
        lda $0DB1,b
        bra _CEC2


        _CEBF
        lda $0DAF,b

        _CEC2
        rts

        .databank 0

        ; 85/CEC3

    .endsection Unsorted85CE7CSection


    .section Unsorted85CEC3Section

      .al
      .xl

      rlProcMapBattleHPWindowOpen ; 85/CEC3

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlLoadMapMenuEntryPointerFromProcBody
        jsl rlDrawMapMenu
        jsr rsStepMapBattleHPWindowOpening
        bcs _CED1
        rtl


        _CED1
        jsr rsMapBattleHPWindowReadHP
        jsr rsDrawMapBattleHPWindow
        jsl rlDrawMapMenuBG3
        lda #<>rlProcMapBattleHPWindowCycle
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 85/CEE2

    .endsection Unsorted85CEC3Section


    .section Unsorted85CEE2Section

      .al
      .xl

      rlProcMapBattleHPWindowCycle ; 85/CEE2

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Acts on the request bits ($0DB1/$0DAF) the map battle sets: drain HP, close, gain experience...

        phx
        jsl rlLoadMapMenuEntryPointerFromProcBody
        jsr rsGetMapBattleHPWindowRequest
        bit #$4000
        bne _CF11
        bit #$0800
        bne _CF00
        bit #$1000
        bne _CF37
        bit #$0100
        bne _CF44

        _CEFE
        plx
        rtl


        _CF00
        and #$00FF
        clc
        adc aProcSystem.aBody5,b,x
        cmp aProcSystem.aBody6,b,x
        bmi _CF24
        lda aProcSystem.aBody6,b,x
        bra _CF24


        _CF11
        and #$00FF
        sta wR0
        lda aProcSystem.aBody5,b,x
        sec
        sbc wR0
        ora #$0000
        bpl _CF24
        lda #$0000

        _CF24
        sta aProcSystem.aBody4,b,x
        lda #$2000
        jsr rsSetMapBattleHPWindowRequest
        lda #<>rlProcMapBattleHPWindowDrainHP
        sta aProcSystem.aHeaderOnCycle,b,x
        jml _CEFE


        _CF37
        lda #<>rlProcMapBattleHPWindowClose
        sta aProcSystem.aHeaderOnCycle,b,x
        jsr rsBeginMapBattleHPWindowClosing
        jml _CEFE


        _CF44
        lda aProcSystem.aBody6,b,x
        bit #$0080
        bne _CFA3
        phb
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb
        .databank $7E
        lda aProcSystem.aBody7,b,x
        tay
        lda $0018,b,y
        sta aProcSystem.wInput1,b
        lda $001A,b,y
        sta aProcSystem.wInput3,b
        plb
        .databank $7E
        lda aProcSystem.wInput3,b
        beq _CFB3
        lda #$0080
        sta aProcSystem.aBody6,b,x
        jsl rlGetMapMenuPosition
        xba
        and #$00FF
        cmp #$0002
        bmi _CF81
        dec a
        bra _CF85


        _CF81
        clc
        adc #$0002

        _CF85
        sta aProcSystem.wInput2,b
        lda #$0001
        sta aProcSystem.wInput0,b
        lda #(`procMapBattleExperienceWindow)<<8
        sta lR44+1
        lda #<>procMapBattleExperienceWindow
        sta lR44
        lda #$0001
        jsl rlProcEngineCreateProcByIndex
        jml _CEFE


        _CFA3
        lda #(`procMapBattleExperienceWindow)<<8
        sta lR44+1
        lda #<>procMapBattleExperienceWindow
        sta lR44
        jsl rlProcEngineFindProc
        bcs _CFBC

        _CFB3
        lda #$0000
        sta aProcSystem.aBody6,b,x
        jsr rsSetMapBattleHPWindowRequest

        _CFBC
        jml _CEFE

        .databank 0

        ; 85/CFC0

      rlProcMapBattleHPWindowDrainHP ; 85/CFC0

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsl rlLoadMapMenuEntryPointerFromProcBody
        lda aProcSystem.aBody4,b,x
        cmp aProcSystem.aBody5,b,x
        beq _D033
        bpl _CFDA
        lda #$1D80
        sta aCurrentTilemapInfo,b
        dec aProcSystem.aBody5,b,x
        bra _D009


        _CFDA
        lda #$0980
        sta aCurrentTilemapInfo,b
        inc aProcSystem.aBody5,b,x
        jsr rsGetMapBattleHPWindowRequest
        pha
        and #$FF00
        sta wR0
        pla
        and #$00FF
        dec a
        bmi _CFFA
        ora wR0
        jsr rsSetMapBattleHPWindowRequest
        bra _D009


        _CFFA
        lda #$0006
        ora wR0
        jsr rsSetMapBattleHPWindowRequest
        lda #$000D
        jsl rlPlaySoundEffect

        _D009
        phx
        lda aProcSystem.aBody5,b,x
        ldy aProcSystem.aBody6,b,x
        ldx #$0203
        jsl rlDrawMapMenuGauge
        plx
        phx
        lda #$01A0
        jsr rsGetMapBattleHPWindowTileBase
        sta aCurrentTilemapInfo,b
        lda aProcSystem.aBody5,b,x
        ldx #$0201
        jsl rlDrawMapMenuSmallNumber
        plx
        jsl rlDrawMapMenuBG3
        plx
        rtl


        _D033
        lda #$8000
        jsr rsSetMapBattleHPWindowRequest
        lda #<>rlProcMapBattleHPWindowCycle
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0980
        sta aCurrentTilemapInfo,b
        bra _D009

        .databank 0

        ; 85/D047

      rlProcMapBattleHPWindowClose ; 85/D047

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlLoadMapMenuEntryPointerFromProcBody
        jsr rsStepMapBattleHPWindowClosing
        bcs _D055
        jsl rlResizeMapMenuFrame
        rtl


        _D055
        lda #$0000
        jsr rsSetMapBattleHPWindowRequest
        jsl rlCloseMapMenuFromProc
        jsl rlProcEngineFreeProc
        rtl

        .databank 0

        ; 85/D064

    .endsection Unsorted85CEE2Section


    .section ProcScript85D064Section

      .al
      .xl

      aProcMapBattleHPWindowCode ; 85/D064

        PROC_HALT


        ; 85/D066

    .endsection ProcScript85D064Section


    .section Unsorted85D066Section

      .al
      .xl

      rlOpenMapBattleHPWindows ; 85/D066

        .al
        .xl
        .autsiz
        .databank ?

        ; Colours, places and opens both windows for aActionStructUnit1 and aActionStructUnit2, with the gradient.

        stz $0DB1,b
        stz $0DAF,b
        phb
        phy
        phx
        jsl rlSetMapBattleHUDColours
        lda $7F508F
        bit #$0001
        bne _D081
        jsr rsPlaceMapBattleHPWindows
        bra _D084


        _D081
        jsr rsUnknown85D29F

        _D084
        jsr rsOpenMapBattleHPWindowRight
        jsr rsOpenMapBattleHPWindowLeft
        lda wR1
        and #$FF00
        asl a
        asl a
        asl a
        sec
        sbc #$0010
        tay
        xba
        and #$00FF
        cmp #$0000
        bpl _D0A3
        ldy #$0000

        _D0A3
        tya
        and #$FF00
        ora #$0030
        sta wR43
        lda #$0014
        sta wR42
        jsl rlStartMapMenuGradient
        plx
        ply
        plb
        .databank ?
        rtl

        .databank 0

        ; 85/D0B9

      rlSetMapBattleHUDColours ; 85/D0B9

        .al
        .xl
        .autsiz
        .databank ?

        ; Each unit's army HUD colours (rlGetFactionBattleHUDColorID).

        lda aActionStructUnit1.UnitRAMPointer
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitFactionSlot
        jsl rlGetFactionBattleHUDColorID
        sta wR0
        lda #$0000
        ldy wR0
        jsl rlLoadMapBattleHPWindowColours
        lda #$0000
        ldy wR0
        jsl rlUnknown85D766
        lda aActionStructUnit2.UnitRAMPointer
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitFactionSlot
        jsl rlGetFactionBattleHUDColorID
        sta wR0
        lda #$0001
        ldy wR0
        jsl rlLoadMapBattleHPWindowColours
        lda #$0001
        ldy wR0
        jsl rlUnknown85D766
        rtl

        .databank 0

        ; 85/D100

    .endsection Unsorted85D066Section


    .section Unsorted85D100Section

      .al
      .xl

      rlOpenMapBattleHPWindowRightOnly ; 85/D100

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        stz $0DB1,b
        phb
        phy
        phx
        jsl rlSetMapBattleHUDColours
        jsr rsPlaceMapBattleHPWindows
        jsr rsOpenMapBattleHPWindowRight
        lda wR0
        and #$FF00
        asl a
        asl a
        asl a
        sec
        sbc #$0010
        tay
        xba
        and #$00FF
        cmp #$0000
        bpl _D129
        ldy #$0000

        _D129
        tya
        and #$FF00
        ora #$0030
        sta wR43
        lda #$0014
        sta wR42
        jsl rlStartMapMenuGradient
        plx
        ply
        plb
        .databank ?
        rtl

        .databank 0

        ; 85/D13F

      rlOpenMapBattleHPWindowLeftOnly ; 85/D13F

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        stz $0DAF,b
        phb
        phy
        phx
        jsl rlSetMapBattleHUDColours
        jsr rsPlaceMapBattleHPWindows
        jsr rsOpenMapBattleHPWindowRight
        lda wR1
        and #$FF00
        asl a
        asl a
        asl a
        sec
        sbc #$0010
        tay
        xba
        and #$00FF
        cmp #$0000
        bpl _D168
        ldy #$0000

        _D168
        tya
        and #$FF00
        ora #$0030
        sta wR43
        lda #$0014
        sta wR42
        jsl rlStartMapMenuGradient
        plx
        ply
        plb
        .databank ?
        rtl

        .databank 0

        ; 85/D17E

    .endsection Unsorted85D100Section


    .section Unsorted85D17ESection

      .al
      .xl

      rsOpenMapBattleHPWindowRight ; 85/D17E

        .al
        .xl
        .autsiz
        .databank ?

        lda wR1
        pha
        lda wR0
        pha
        lda #(`procMapBattleHPWindowRight)<<8
        sta lR44+1
        lda #<>procMapBattleHPWindowRight
        sta lR44
        lda aActionStructUnit1.MaxHP
        sta aProcSystem.wInput0,b
        lda aActionStructUnit1.CurrentHP
        sta aProcSystem.wInput1,b
        lda #<>aActionStructUnit1
        sta aProcSystem.wInput3,b
        lda wR0
        sta aProcSystem.wInput2,b
        jsl rlProcEngineCreateProc
        pla
        sta wR0
        pla
        sta wR1
        rts

        .databank 0

        ; 85/D1B2

      rsOpenMapBattleHPWindowLeft ; 85/D1B2

        .al
        .xl
        .autsiz
        .databank ?

        lda wR0
        pha
        lda wR1
        pha
        lda #(`procMapBattleHPWindowLeft)<<8
        sta lR44+1
        lda #<>procMapBattleHPWindowLeft
        sta lR44
        lda aActionStructUnit2.MaxHP
        sta aProcSystem.wInput0,b
        lda aActionStructUnit2.CurrentHP
        sta aProcSystem.wInput1,b
        lda #<>aActionStructUnit2
        sta aProcSystem.wInput3,b
        lda wR1
        sta aProcSystem.wInput2,b
        jsl rlProcEngineCreateProc
        pla
        sta wR1
        pla
        sta wR0
        rts

        .databank 0

        ; 85/D1E6

      rsPlaceMapBattleHPWindows ; 85/D1E6

        .al
        .xl
        .autsiz
        .databank ?

        ; Above or below the two units, from their screen tiles (rlUnknown88BF6C).

        lda aActionStructUnit2.XPosition
        sta wR2
        sta wR10
        lda aActionStructUnit1.XPosition
        sta wR12
        cmp wR2
        bpl _D204
        lda #$0004
        sta wR0
        lda #$0090
        sta wR1
        bra _D20E


        _D204
        lda #$0090
        sta wR0
        lda #$0004
        sta wR1

        _D20E
        lda aActionStructUnit2.YPosition
        sta wR11
        jsl rlUnknown88BF6C
        lda wR11
        sta wR2
        lda aActionStructUnit1.YPosition
        sta wR11
        lda wR12
        sta wR10
        jsl rlUnknown88BF6C
        lda wR11
        sta wR5
        cmp wR2
        bmi _D23C
        lda wR5
        sta wR4
        lda wR2
        sta wR3
        bra _D244


        _D23C
        lda wR2
        sta wR4
        lda wR5
        sta wR3

        _D244
        inc wR4
        stz wR6
        lda wR3
        sta wR2
        cmp #$0007
        bmi _D256
        lda #$0001
        tsb wR6

        _D256
        lda #$001B
        sec
        sbc wR4
        sta wR5
        cmp #$0006
        bmi _D268
        lda #$0002
        tsb wR6

        _D268
        lda wR6
        cmp #$0003
        beq _D27E
        bit #$0001
        bne _D286
        bit #$0002
        bne _D290
        lda #$0010
        bra _D296


        _D27E
        lda wR2
        cmp wR5
        bpl _D286
        bra _D290


        _D286
        lda wR3
        sec
        sbc #$0004
        dec a
        dec a
        bra _D296


        _D290
        lda wR4
        inc a
        inc a
        bra _D296


        _D296
        xba
        and #$FF00
        tsb wR0
        tsb wR1
        rts

        .databank 0

        ; 85/D29F

      rsUnknown85D29F ; 85/D29F

        .al
        .xl
        .autsiz
        .databank ?

        lda aActionStructUnit2.XPosition
        sta wR2
        lda aActionStructUnit1.XPosition
        cmp wR2
        bpl _D2B9
        lda #$0004
        sta wR0
        lda #$0090
        sta wR1
        bra _D2C3


        _D2B9
        lda #$0090
        sta wR0
        lda #$0004
        sta wR1

        _D2C3
        lda $7F5090
        and #$0003
        beq _D2F5
        cmp #$0001
        beq _D2E3
        lda wR0
        clc
        adc #$0002
        sta wR0
        lda wR1
        clc
        adc #$0002
        sta wR1
        bra _D2F5


        _D2E3
        lda wR0
        sec
        sbc #$0003
        sta wR0
        lda wR1
        sec
        sbc #$0003
        sta wR1
        bra _D2F5


        _D2F5
        lda $7F5090
        bit #$0004
        bne _D307
        lda #$0100
        tsb wR0
        tsb wR1
        bra _D30E


        _D307
        lda #$1600
        tsb wR0
        tsb wR1

        _D30E
        rts

        .databank 0

        ; 85/D30F

      rlMapBattleDamageRight ; 85/D30F

        .al
        .xl
        .autsiz
        .databank ?

        ; A = damage: asks the right HP window (type 3, $0DB1) to lose that much HP ($4000 + damage).

        and #$00FF
        ora #$4000
        sta $0DB1,b
        rtl

        .databank 0

        ; 85/D319

      rlMapBattleDamageLeft ; 85/D319

        .al
        .xl
        .autsiz
        .databank ?

        ; A = damage: the left HP window (type 4, $0DAF).

        and #$00FF
        ora #$4000
        sta $0DAF,b
        rtl

        .databank 0

        ; 85/D323

      rlMapBattleHealRight ; 85/D323

        .al
        .xl
        .autsiz
        .databank ?

        ; A = HP: asks the right HP window to gain that much ($0800 + HP).

        and #$00FF
        ora #$0800
        sta $0DB1,b
        rtl

        .databank 0

        ; 85/D32D

      rlMapBattleHealLeft ; 85/D32D

        .al
        .xl
        .autsiz
        .databank ?

        and #$00FF
        ora #$0800
        sta $0DAF,b
        rtl

        .databank 0

        ; 85/D337

      rlUnknown85D337 ; 85/D337

        .al
        .xl
        .autsiz
        .databank ?

        lda $0DB1,b
        cmp #$8000
        beq _D343
        lda #$FFFF
        rtl


        _D343
        lda #$0000
        rtl

        .databank 0

        ; 85/D347

      rlUnknown85D347 ; 85/D347

        .al
        .xl
        .autsiz
        .databank ?

        lda $0DAF,b
        cmp #$8000
        beq _D353
        lda #$FFFF
        rtl


        _D353
        lda #$0000
        rtl

        .databank 0

        ; 85/D357

      rlMapBattleExperienceRight ; 85/D357

        .al
        .xl
        .autsiz
        .databank ?

        ; Request $0100 to the right HP window: show the experience window. Nothing in the build reaches this.

        lda #$0100
        sta $0DB1,b
        rtl

        .databank 0

        ; 85/D35E

      rlMapBattleExperienceLeft ; 85/D35E

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0100
        sta $0DAF,b
        rtl

        .databank 0

        ; 85/D365

      rlCheckMapBattleExperienceRightPending ; 85/D365

        .al
        .xl
        .autsiz
        .databank ?

        ; A = $FFFF while the right window's request has bit 8 ($0100). Nothing in the build reaches this.

        lda $0DB1,b
        bit #$0100
        beq _D371
        lda #$FFFF
        rtl


        _D371
        lda #$0000
        rtl

        .databank 0

        ; 85/D375

      rlCheckMapBattleExperienceLeftPending ; 85/D375

        .al
        .xl
        .autsiz
        .databank ?

        lda $0DAF,b
        bit #$0100
        beq _D381
        lda #$FFFF
        rtl


        _D381
        lda #$0000
        rtl

        .databank 0

        ; 85/D385

    .endsection Unsorted85D17ESection


    .section Unsorted85D385Section

      .al
      .xl

      rlOpenMapBattleExperienceWindow ; 85/D385

        .al
        .xl
        .autsiz
        .databank ?

        ; A = row. Nothing in this bank uses it; the HP windows open procMapBattleExperienceWindow themselves on request $0100.

        lda #$0001
        sta aProcSystem.wInput0,b
        lda #$000D
        sta aProcSystem.wInput2,b
        pha
        lda #(`procMapBattleExperienceWindow)<<8
        sta lR44+1
        lda #<>procMapBattleExperienceWindow
        sta lR44
        lda #$0001
        jsl rlProcEngineCreateProcByIndex
        pla
        xba
        and #$FF00
        asl a
        asl a
        asl a
        and #$FF00
        ora #$0020
        sta wR43
        lda #$000E
        sta wR42
        jsl rlStartMapMenuGradient
        rtl

        .databank 0

        ; 85/D3BD

      rlOpenMapBattleExperienceWindowType6 ; 85/D3BD

        .al
        .xl
        .autsiz
        .databank ?

        ; As rlOpenMapBattleExperienceWindow, with frame type 6 (wInput0 = 0) at row 13. Nothing in the build reaches this.

        lda #$0000
        sta aProcSystem.wInput0,b
        lda #$000D
        sta aProcSystem.wInput2,b
        pha
        lda #(`procMapBattleExperienceWindow)<<8
        sta lR44+1
        lda #<>procMapBattleExperienceWindow
        sta lR44
        lda #$0001
        jsl rlProcEngineCreateProcByIndex
        pla
        xba
        and #$FF00
        asl a
        asl a
        asl a
        and #$FF00
        ora #$0020
        sta wR43
        lda #$000E
        sta wR42
        jsl rlStartMapMenuGradient
        rtl

        .databank 0

        ; 85/D3F5

    .endsection Unsorted85D385Section


    .section Unsorted85D3F5Section

      .al
      .xl

      rlCheckMapBattleExperienceWindowOpen ; 85/D3F5

        .al
        .xl
        .autsiz
        .databank ?

        ; A = $FFFF while it is open; otherwise frees HDMA entry 0 and returns 0.

        phx
        lda #(`procMapBattleExperienceWindow)<<8
        sta lR44+1
        lda #<>procMapBattleExperienceWindow
        sta lR44
        jsl rlProcEngineFindProc
        bcc _D40B
        plx
        lda #$FFFF
        rtl


        _D40B
        plx
        jsl rlFreeHDMAEntry0
        lda #$0000
        rtl

        .databank 0

        ; 85/D414

      rlCloseMapBattleHPWindows ; 85/D414

        .al
        .xl
        .autsiz
        .databank ?

        ; Request $1000 (close) to both.

        lda #$1000
        sta $0DB1,b
        sta $0DAF,b
        rtl

        .databank 0

        ; 85/D41E

      rlCheckMapBattleHPWindowsBusy ; 85/D41E

        .al
        .xl
        .autsiz
        .databank ?

        ; A = $FFFF while either window still has a request; otherwise frees HDMA entry 0 and returns 0.

        lda $0DB1,b
        beq _D425
        bra _D434


        _D425
        lda $0DAF,b
        beq _D42C
        bra _D434


        _D42C
        jsl rlFreeHDMAEntry0
        lda #$0000
        rtl


        _D434
        lda #$FFFF
        rtl

        .databank 0

        ; 85/D438

      rlClearBG2Page1 ; 85/D438

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$0000
        jsl rlFillBG2Page1TilemapBuffer
        plx
        rtl

        .databank 0

        ; 85/D442

    .endsection Unsorted85D3F5Section


    .section Unsorted85D442Section

      .al
      .xl

      rlUnknown85D442 ; 85/D442

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        stx wR7
        sta wR2
        sty wR3
        lda wR3
        cmp #$0026
        bpl _D45D
        lda wR2
        sta wR4
        sta wR6
        lda wR3
        sta wR5
        jsr rsUnknown85D4B2
        rtl


        _D45D
        lda wR2
        cmp #$0026
        bpl _D489
        lda wR2
        sta wR4
        sta wR6
        lda #$0026
        sta wR5
        jsr rsUnknown85D4B2
        lda wR7
        sec
        sbc #$0100
        tax
        stz wR4
        stz wR6
        lda wR3
        sec
        sbc #$0026
        sta wR5
        jsr rsUnknown85D4B2
        rtl


        _D489
        lda #$0026
        sta wR4
        sta wR6
        sta wR5
        jsr rsUnknown85D4B2
        lda wR7
        sec
        sbc #$0100
        tax
        lda wR2
        sec
        sbc #$0026
        sta wR4
        sta wR6
        lda wR3
        sec
        sbc #$0026
        sta wR5
        jsr rsUnknown85D4B2
        rtl

        .databank 0

        ; 85/D4B2

    .endsection Unsorted85D442Section


    .section Unsorted85D4B2Section

      .al
      .xl

      rsUnknown85D4B2 ; 85/D4B2

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda wR4
        sec
        sbc #$0004
        sta wR0
        bpl _D4C0
        jml _D4DF


        _D4C0
        phy
        pha
        phx
        ldy #$0004
        lda #$0004
        jsr rsUnknown85D5AA
        plx
        jsr rsUnknown85D5C3
        jsl rlUnknown85D81F
        pla
        ply
        lda wR0
        sta wR4
        inc x
        jml rsUnknown85D4B2


        _D4DF
        lda wR5
        sec
        sbc wR6
        sta wR1
        clc
        adc wR4
        cmp #$0005
        bpl _D505
        tay
        phy
        pha
        phx
        lda wR4
        jsr rsUnknown85D5AA
        plx
        jsr rsUnknown85D5C3
        jsl rlUnknown85D81F
        pla
        ply
        jml _D572


        _D505
        phy
        pha
        phx
        ldy #$0004
        lda wR4
        jsr rsUnknown85D5AA
        plx
        jsr rsUnknown85D5C3
        jsl rlUnknown85D81F
        pla
        ply
        inc x
        lda #$0004
        sec
        sbc wR4
        sta wR0
        lda wR5
        sec
        sbc wR6
        sec
        sbc wR0
        sta wR5
        jml _D531


        _D531
        lda wR5
        sec
        sbc #$0004
        bmi _D556
        phy
        pha
        phx
        ldy #$0004
        lda #$0000
        jsr rsUnknown85D5AA
        plx
        jsr rsUnknown85D5C3
        jsl rlUnknown85D81F
        pla
        ply
        sta wR5
        inc x
        jml _D531


        _D556
        nop
        nop
        nop
        phy
        pha
        phx
        ldy wR5
        lda #$0000
        jsr rsUnknown85D5AA
        plx
        jsr rsUnknown85D5C3
        jsl rlUnknown85D81F
        pla
        ply
        nop
        nop
        nop
        rts


        _D572
        tya
        cmp #$0004
        beq _D579
        rts


        _D579
        inc x
        phy
        pha
        phx
        ldy #$0000
        lda #$0000
        jsr rsUnknown85D5AA
        plx
        jsr rsUnknown85D5C3
        jsl rlUnknown85D81F
        pla
        ply
        rts

        .databank 0

        ; 85/D591

    .endsection Unsorted85D4B2Section


    .section Table85D591Section

      .al
      .xl

      aUnknown85D591 ; 85/D591

        ; Read by rsUnknown85D5AA.

        .byte $1E, $1E, $1E, $1E, $1E, $1C, $1D, $1D, $1D, $1D, $19, $1A, $1B, $1B, $1B, $15
        .byte $16, $17, $18, $18, $10, $11, $12, $13, $14

        ; 85/D5AA

    .endsection Table85D591Section


    .section Unsorted85D5AASection

      .al
      .xl

      rsUnknown85D5AA ; 85/D5AA

        .al
        .xl
        .autsiz
        .databank ?

        pha
        lda #$0005
        sta wR10
        sty wR11
        jsl rlUnsignedMultiply16By16
        pla
        clc
        adc wR12
        tax
        lda aUnknown85D591,x
        and #$00FF
        rts

        .databank 0

        ; 85/D5C3

      rsUnknown85D5C3 ; 85/D5C3

        .al
        .xl
        .autsiz
        .databank ?

        cpx wR7
        bpl _D5CB
        sec
        sbc #$0010

        _D5CB
        rts

        .databank 0

        ; 85/D5CC

    .endsection Unsorted85D5AASection


    .section Unsorted85D5CCSection

      .al
      .xl

      rlSetMapBattlePalettes ; 85/D5CC

        .al
        .xl
        .autsiz
        .databank ?

        ; Saves BG colours 1-15 at $7FD14C and loads the map battle's (aMapBattlePalette...).

        phx
        ldx #$001C

        _D5D0
        lda @l $000102,x
        sta $7FD14C,x
        dec x
        dec x
        bpl _D5D0
        ldx #$001C

        _D5DF
        lda aMapBattlePalette,x
        sta @l $000102,x
        dec x
        dec x
        bpl _D5DF
        ldx #$000E

        _D5EE
        lda aMapBattleHUDPalette1,x
        sta @l $0001C2,x
        lda aMapBattleHUDPalette2,x
        sta @l $0001E2,x
        dec x
        dec x
        bpl _D5EE
        plx
        rtl

        .databank 0

        ; 85/D604

      aMapBattlePaletteColour0 ; 85/D604

        ; Colour 0 of aMapBattlePalette; rlSetMapBattlePalettes copies from colour 1.
        .word $4D96

    .endsection Unsorted85D5CCSection


    .section Table85D606Section

      .al
      .xl

      aMapBattlePalette ; 85/D606

        ; Read by rlSetMapBattlePalettes.

        .word $318B, $7FFF, $1484, $7FFF, $318B, $10E7, $5F7B, $7FFF
        .word $4F00, $1CA2, $77FF, $7FFF, $1D64, $0CA0, $4ACE, $0001

        ; 85/D626

    .endsection Table85D606Section


    .section Table85D626Section

      .al
      .xl

      aMapBattleHUDPalette1 ; 85/D626

        ; Read by rlSetMapBattlePalettes.

        .word $03FF, $6B7B, $635A, $5AF7, $4ED7, $3E75, $08C8, $0000
        .word $4001

        ; 85/D638

    .endsection Table85D626Section


    .section Table85D638Section

      .al
      .xl

      aMapBattleHUDPalette2 ; 85/D638

        ; Read by rlSetMapBattlePalettes.

        .word $039C, $5310, $4ACE, $46AD, $428C, $3A4A, $04A7, $0000

        ; 85/D648

    .endsection Table85D638Section


    .section Unsorted85D648Section

      .al
      .xl

      rlRestoreMapBattlePalettes ; 85/D648

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$001C

        _D64C
        lda $7FD14C,x
        sta @l $000102,x
        dec x
        dec x
        bpl _D64C
        plx
        rtl

        .databank 0

        ; 85/D65A

      rlLoadMapBattleHUDGraphics ; 85/D65A

        .al
        .xl
        .autsiz
        .databank ?

        ; Carry set while the decompression is still going.

        lda #(`aDecompressionDMAEntry85D669)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry85D669
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        rtl

        .databank 0

        ; 85/D669

    .endsection Unsorted85D648Section


    .section Unsorted85D671Section

      .al
      .xl

      rlReloadMenuIconGraphics ; 85/D671

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlLoadMenuIconGraphics
        rtl

        .databank 0

        ; 85/D676

    .endsection Unsorted85D671Section


    .section Unsorted85D676Section

      .al
      .xl

      rlLoadMapBattleHPWindowColours ; 85/D676

        .al
        .xl
        .autsiz
        .databank ?

        ; A = side (1: colours $77-$7F, else $67-$6F... at aBGPaletteBuffer+$CE/$EE), Y = HUD colour ID.

        phb
        php
        phk
        plb
        .databank $85
        phx
        phy
        pha
        tya
        asl a
        tax
        lda @l aUnknown85D6B2,x
        clc
        adc #$0010
        tay
        pla
        cmp #$0001
        beq _D694
        ldx #$00CE
        bra _D697


        _D694
        ldx #$00EE

        _D697
        lda #$0007
        sta wR1

        _D69C
        lda $0000,b,y
        sta @l $000102,x
        dec x
        dec x
        dec y
        dec y
        dec wR1
        lda wR1
        bpl _D69C
        ply
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 85/D6B2

    .endsection Unsorted85D676Section


    .section Table85D6B2Section

      .al
      .xl

      aUnknown85D6B2 ; 85/D6B2

        ; Read by rlLoadMapBattleHPWindowColours.

        .word $D6C4, $D6D6, $D6E8, $D6FA, $D70C, $D71E, $D730, $D742
        .word $D754, $5ED5, $039C, $39D2, $3190, $2D6F, $294E, $252D
        .word $1CC9, $0000, $3000, $039C, $420F, $3DEE, $39CD, $35AC
        .word $318B, $0C42, $0000, $3000, $039C, $5310, $4ACE, $46AD
        .word $428C, $3A4A, $04A7, $0000, $3000, $039C, $4DAF, $498E
        .word $456D, $414C, $3D2B, $0866, $0000, $3000, $03FF, $6B7B
        .word $635A, $5AF7, $4ED7, $3E75, $08C8, $0000, $4001, $03FF
        .word $21AF, $1D8E, $196D, $154C, $152B, $04A7, $0000, $0001
        .word $039C, $76D3, $72B2, $6E91, $6A70, $664F, $04A7, $0000
        .word $4001, $03FF, $19D4, $15B3, $1192, $0D71, $0950, $04A7
        .word $0000, $3800, $039C, $658C, $616B, $5D4A, $5929, $5909
        .word $0445, $0000

        ; 85/D766

    .endsection Table85D6B2Section


    .section Unsorted85D766Section

      .al
      .xl

      rlUnknown85D766 ; 85/D766

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $85
        phx
        pha
        tya
        asl a
        tax
        lda @l aUnknown85D7A0,x
        clc
        adc #$0006
        tay
        pla
        cmp #$0001
        beq _D783
        ldx #$000C
        bra _D786


        _D783
        ldx #$001C

        _D786
        lda #$0002
        sta wR1

        _D78B
        lda $0000,b,y
        sta @l $000102,x
        dec x
        dec x
        dec y
        dec y
        dec wR1
        lda wR1
        bpl _D78B
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 85/D7A0

    .endsection Unsorted85D766Section


    .section Table85D7A0Section

      .al
      .xl

      aUnknown85D7A0 ; 85/D7A0

        ; Read by rlUnknown85D766.

        .word $D7B2, $D7BA, $D7C2, $D7CA, $D7D2, $D7DA, $D7E2, $D7EA
        .word $D7F2, $0000, $18A8, $0003, $39D2, $0000, $1CE6, $0000
        .word $420F, $0000, $1D64, $0880, $4ACE, $0000, $2CA7, $0401
        .word $498E, $10A6, $318B, $10E7, $5F7B, $0000, $04A7, $0021
        .word $21AF, $0000, $2106, $0C42, $5A71, $0000, $0068, $0021
        .word $1DF5, $65AB, $3863, $0400, $61AD

        ; 85/D7FA

    .endsection Table85D7A0Section


    .section Unsorted85D7FASection

      .al
      .xl

      rlUnknown85D7FA ; 85/D7FA

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $85
        txy
        ldx lR18
        sep #$20
        lda lR18+2
        pha
        rep #$20
        plb
        .databank ?

        _D809
        lda $0000,b,x
        and #$00FF
        beq _D81C
        phx
        tyx
        jsl rlUnknown85D81F
        plx
        inc x
        inc y
        bra _D809


        _D81C
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 85/D81F

      rlUnknown85D81F ; 85/D81F

        .al
        .xl
        .autsiz
        .databank ?

        pha
        jsl rlGetMapMenuTilemapRAMEntryPointer
        pla
        jsl rlUnknown85D82A
        rtl

        .databank 0

        ; 85/D82A

      rlUnknown85D82A ; 85/D82A

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $85
        phx
        phy
        ldy wR0
        phy
        and #$00FF
        cmp #$0080
        bcs _D88B
        pha
        ldy lMapMenuTilemapRAMEntryPointer,b
        sep #$20
        lda lMapMenuTilemapRAMEntryPointer+2,b
        pha
        rep #$20
        plb
        .databank ?
        lda structMapMenuTilemapData.TilesPointer,b,y
        sta lR23
        lda structMapMenuTilemapData.TilesPointer+1,b,y
        sta lR23+1
        stz wR0
        txa
        sep #$20
        sta wR0
        xba
        sta @l WRMPYA
        lda structMapMenuTilemapData.Width,b,y
        sta @l WRMPYB
        nop
        nop
        nop
        rep #$20
        lda @l RDMPY
        clc
        adc wR0
        asl a
        clc
        adc lR23
        sta lR23
        pla
        clc
        adc @l aCurrentTilemapInfo
        ora #$2000
        sta [lR23]
        pla
        sta wR0
        ply
        plx
        plp
        plb
        .databank ?
        clc

        _D88A
        rtl


        _D88B
        plx
        stx wR0
        ply
        plx
        plp
        plb
        .databank ?
        sec
        bra _D88A

        .databank 0

        ; 85/D895


      aUnknown85D895 ; 85/D895

        .structMapMenuTilemapData 22, 3, aBG3TilemapBuffer, 0, $7FCD4A

      aUnknown85D89E ; 85/D89E

        .long 0, 0, aUnknown85D895
        .byte 5, 3, 11

    .endsection Unsorted85D7FASection


    .section ProcScript85D8AASection

      .al
      .xl

      procMapBattleExperienceWindow ; 85/D8AA

        .structProcInfo "OW", rlProcMapBattleExperienceWindowInit, rlProcMapBattleExperienceWindowDraw, aProcMapBattleExperienceWindowCode


        .long aUnknown85D89E
        .byte 0

    .endsection ProcScript85D8AASection


    .section Unsorted85D8B6Section

      .al
      .xl

      rlProcMapBattleExperienceWindowInit ; 85/D8B6

        .al
        .xl
        .autsiz
        .databank ?

        ; wInput1 = experience (aBody7), wInput3 = experience gained (aBody6), wInput2 = row, wInput0 = 0 for frame type 6. Splits BG3's scroll under the window (aMapBattleExperienceWindowHDMAInfo).

        phx
        jsl rlStallProcUntilMapMenuDataLoaded
        lda #$20FF
        sta wMapMenuClearTile,b
        jsl rlClearMapMenuTiles
        lda #$0000
        sta wBufferBG3VOFS
        sta wBufferBG3HOFS
        lda aProcSystem.wInput2,b
        sta wR6
        lda aProcSystem.wInput1,b
        sta aProcSystem.aBody7,b,x
        lda aProcSystem.wInput3,b
        sta aProcSystem.aBody6,b,x
        lda wR6
        xba
        ora #$0005
        jsl rlSetMapMenuPosition
        lda aProcSystem.wInput0,b
        bne _D8F3
        lda #$0006
        jsl rlSetMapMenuType

        _D8F3
        lda wR6
        asl a
        asl a
        asl a
        sta wR43
        lda #$0001
        sta wR40
        lda #(`aMapBattleExperienceWindowHDMAInfo)<<8
        sta lR44+1
        lda #<>aMapBattleExperienceWindowHDMAInfo
        sta lR44
        jsl rlHDMAEngineCreateEntryByIndex
        plx
        rtl

        .databank 0

        ; 85/D90F

      rlProcMapBattleExperienceWindowDraw ; 85/D90F

        .al
        .xl
        .autsiz
        .databank ?

        ; "EXP", the number and an 11-tile bar; waits 30 frames.

        phb
        php
        phk
        plb
        .databank $85
        phx
        jsl rlLoadMapMenuEntryPointerFromProcBody
        plx
        phx
        ldx #$0580
        stx aCurrentTilemapInfo,b
        lda #(`aMapBattleExperienceLabelTiles)<<8
        sta lR18+1
        lda #<>aMapBattleExperienceLabelTiles
        sta lR18
        ldx #$0101
        jsl rlUnknown85D7FA
        plx
        phx
        lda aProcSystem.aBody7,b,x
        ldx #$05A0
        stx aCurrentTilemapInfo,b
        ldx #$0105
        jsl rlDrawMapMenuSmallNumber
        plx
        phx
        lda aProcSystem.aBody7,b,x
        ldx #$0980
        stx aCurrentTilemapInfo,b
        ldx #$0107
        jsl rlDrawMapMenuLongGauge
        plx
        jsl rlShowMapMenuLayers
        jsl rlDrawMapMenu
        plp
        plb
        .databank ?
        lda #$001E
        sta aProcSystem.aBody5,b,x
        lda #<>rlProcMapBattleExperienceWindowWait
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 85/D96D

    .endsection Unsorted85D8B6Section


    .section Table85D96DSection

      .al
      .xl

      aMapBattleExperienceLabelTiles ; 85/D96D
        .byte $40, $41, $42, $00

    .endsection Table85D96DSection


    .section Unsorted85D971Section

      .al
      .xl

      rlProcMapBattleExperienceWindowWait ; 85/D971

        .al
        .xl
        .autsiz
        .databank ?

        dec aProcSystem.aBody5,b,x
        bmi _D977
        rtl


        _D977
        lda #$000B
        jsl rlPlaySoundEffect
        lda #<>rlProcMapBattleExperienceWindowCount
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 85/D985

      rlProcMapBattleExperienceWindowCount ; 85/D985

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlLoadMapMenuEntryPointerFromProcBody
        lda aProcSystem.aBody6,b,x
        beq _D9C9
        dec aProcSystem.aBody6,b,x
        inc aProcSystem.aBody7,b,x
        lda aProcSystem.aBody7,b,x
        cmp #$0064
        bpl _D99E
        bra _D9A1


        _D99E
        stz aProcSystem.aBody7,b,x

        _D9A1
        phx
        lda aProcSystem.aBody7,b,x
        ldx #$05A0
        stx aCurrentTilemapInfo,b
        ldx #$0105
        jsl rlDrawMapMenuSmallNumber
        plx
        lda aProcSystem.aBody7,b,x
        ldx #$0980
        stx aCurrentTilemapInfo,b
        ldx #$0107
        jsl rlDrawMapMenuLongGauge
        jsl rlDrawMapMenuBG3
        bra _D9DE


        _D9C9
        lda #$000C
        jsl rlPlaySoundEffect
        lda #$0032
        sta aProcSystem.aBody5,b,x
        lda #<>rlProcMapBattleExperienceWindowClose
        sta aProcSystem.aHeaderOnCycle,b,x
        bra _D9DE


        _D9DE
        rtl

        .databank 0

        ; 85/D9DF

      rlProcMapBattleExperienceWindowClose ; 85/D9DF

        .al
        .xl
        .autsiz
        .databank ?

        dec aProcSystem.aBody5,b,x
        bmi _D9EE
        beq _D9E8
        bra _D9F9


        _D9E8
        jsl rlCloseMapMenuFromProc
        bra _D9F9


        _D9EE
        lda #$0001
        jsl rlFreeHDMAEntryByIndex
        jsl rlProcEngineFreeProc

        _D9F9
        rtl

        .databank 0

        ; 85/D9FA

    .endsection Unsorted85D971Section


    .section ProcScript85D9FASection

      .al
      .xl

      aProcMapBattleExperienceWindowCode ; 85/D9FA

        PROC_HALT


        ; 85/D9FC

    .endsection ProcScript85D9FASection


    .section ProcScript85DAEASection

      .al
      .xl

      procMapBattleTextBox ; 85/DAEA

        .structProcInfo "OW", rlProcMapBattleTextBoxInit, rlProcMapTextBoxDraw, aProcDialogueBoxCode
        .long aMapBattleTextBoxData
        .byte 0

    .endsection ProcScript85DAEASection


    .section Unsorted85DAF6Section

      .al
      .xl

      rlProcMapBattleTextBoxInit ; 85/DAF6

        .al
        .xl
        .autsiz
        .databank ?

        ; Like rlProcMapTextBoxInit, but placed above or below the map battle HP windows if they are open; with the gradient.

        phx
        lda #(`procMapBattleHPWindowRight)<<8
        sta lR44+1
        lda #<>procMapBattleHPWindowRight
        sta lR44
        jsl rlProcEngineFindProc
        bcs _DB19
        lda #(`procMapBattleHPWindowLeft)<<8
        sta lR44+1
        lda #<>procMapBattleHPWindowLeft
        sta lR44
        jsl rlProcEngineFindProc
        bcs _DB19
        bra _DB43


        _DB19
        jsl rlLoadMapMenuEntryPointerFromProcBody
        jsl rlGetMapMenuPosition
        and #$FF00
        ora #$0005
        sta wR0
        xba
        and #$00FF
        cmp #$0003
        bpl _DB3A
        lda wR0
        clc
        adc #$0300
        bra _DB40


        _DB3A
        lda wR0
        sec
        sbc #$0200

        _DB40
        sta aProcSystem.wInput3,b

        _DB43
        plx
        jsl rlProcMapTextBoxInit
        lda aProcSystem.wInput3,b
        and #$FF00
        asl a
        asl a
        asl a
        and #$FF00
        ora #$0020
        sta wR43
        lda #$0010
        sta wR42
        jsl rlStartMapMenuGradient
        rtl

        .databank 0

        ; 85/DB63

      rlOpenMapBattleTextBox ; 85/DB63

        .al
        .xl
        .autsiz
        .databank ?

        ; A = position, X = size, Y = flags, lR18/lR19 = texts; tile base $2000.

        pha
        lda #$2000
        sta aCurrentTilemapInfo,b
        pla
        jsl rlCreateMapBattleTextBox
        rtl

        .databank 0

        ; 85/DB70

      rlCreateMapBattleTextBox ; 85/DB70

        .al
        .xl
        .autsiz
        .databank ?

        sta aProcSystem.wInput3,b
        stx aProcSystem.wInput2,b
        sty aProcSystem.wInput1,b
        lda aCurrentTilemapInfo,b
        sta aProcSystem.wInput0,b
        lda #(`procMapBattleTextBox)<<8
        sta lR44+1
        lda #<>procMapBattleTextBox
        sta lR44
        lda #$0000
        jsl rlProcEngineCreateProcByIndex
        rtl

        .databank 0

        ; 85/DB91

      rlCloseMapBattleTextBox ; 85/DB91

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`procMapBattleTextBox)<<8
        sta lR44+1
        lda #<>procMapBattleTextBox
        sta lR44
        jsl rlProcEngineFindProc
        bcc _DBAA
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0002
        sta aProcSystem.aHeaderBitfield,b,x

        _DBAA
        rtl

        .databank 0

        ; 85/DBAB

      rlChangeMapBattleTextBox ; 85/DBAB

        .al
        .xl
        .autsiz
        .databank ?

        ; lR18/lR19 = new texts: sets bit 2 (redraw) of procMapBattleTextBox. Nothing in the build reaches this.

        lda #(`procMapBattleTextBox)<<8
        sta lR44+1
        lda #<>procMapBattleTextBox
        sta lR44
        jsl rlProcEngineFindProc
        bcc _DBDC
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0004
        sta aProcSystem.aHeaderBitfield,b,x
        lda lR18
        sta $7FEAAA
        lda lR18+1
        sta $7FEAAB
        lda lR19
        sta $7FEAAE
        lda lR19+1
        sta $7FEAAF

        _DBDC
        rtl

        .databank 0

        ; 85/DBDD

    .endsection Unsorted85DAF6Section


