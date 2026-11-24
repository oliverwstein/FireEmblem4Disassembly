; The banner at the start of each army's phase ("<army> PHASE").


    .section Unsorted85ABF6Section

      .al
      .xl

      procPhaseBanner ; 85/ABF6

        .structProcInfo "PS", rlProcPhaseBannerInit, rlProcPhaseBannerLoadGraphics, aProcPhaseBannerCode

    .endsection Unsorted85ABF6Section


    .section Unsorted85ABFESection

      .al
      .xl

      aUnknown85ABFE ; 85/ABFE

        .byte 0, 0, 0, 1

    .endsection Unsorted85ABFESection


    .section Unsorted85AC02Section

      .al
      .xl

      rlProcPhaseBannerInit ; 85/AC02

        .al
        .autsiz
        .databank ?

        ; Holds the game state (aBody5), hides the map menus, saves the palettes it changes, loads the army's colours (by its relation to the player) and its banner graphics (rlLoadBattleBannerGraphicsAndPalette). aBody6 = frames to stay (120).

        phx
        lda #$0008
        tsb wMapSystemFlags,b

        lda wGameStateRoutine1,b
        sta aProcSystem.aBody5,b,x
        stz wGameStateRoutine1,b

        lda #$0078
        sta aProcSystem.aBody6,b,x

        lda #2
        sta $7FEAAC

        stz $89
        stz $87
        stz $85
        stz $83

        jsl rlHideMapMenuLayers
        jsr rsPhaseBannerSavePalettes
        jsr rsPhaseBannerLoadColours

        plx
        phx
        lda wActiveFactionSlot,b
        jsl rlGetFactionBattleBannerID
        jsl rlLoadBattleBannerGraphicsAndPalette

        plx
        rtl

        .databank 0

        ; 85/AC40

    .endsection Unsorted85AC02Section


    .section Unsorted85AC40Section

      .al
      .xl

      rlProcPhaseBannerLoadGraphics ; 85/AC40

        .al
        .xl
        .autsiz
        .databank ?

        ; Once the decompression queue is empty: uploads the banner tiles and the army's banner colours.

        lda bDecompressionArrayFlag,b
        bne _AC88
        phx
        phy
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8E88, $0180, $80, $7000

        lda #(`aDecompressionBuffer)<<8
        sta lR18+1
        lda #<>aDecompressionBuffer+$100
        sta lR18
        lda #(`aDecompressionBuffer)<<8
        sta lR18+1
        lda wActiveFactionSlot,b
        jsl rlGetFactionBattleBannerID
        xba
        lsr a
        lsr a
        lsr a
        clc
        adc #<>aDecompressionBuffer+$110
        sta lR18
        ldy #$000E

        _AC77
        lda [lR18],y
        sta $01F0,b,y
        dec y
        dec y
        bpl _AC77
        ply
        plx
        lda #<>rlProcPhaseBannerDrawFrame
        sta aProcSystem.aHeaderOnCycle,b,x

        _AC88
        rtl

        .databank 0

        ; 85/AC89

    .endsection Unsorted85AC40Section


    .section Unsorted85AC89Section

      .al
      .xl

      rlProcPhaseBannerDrawFrame ; 85/AC89

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$1800
        sta aCurrentTilemapInfo,b
        lda #(`aPhaseBannerFrameTilemapData)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aPhaseBannerFrameTilemapData
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #(`aPhaseBannerFrameTiles)<<8
        sta lR18+1
        lda #<>aPhaseBannerFrameTiles
        sta lR18
        jsl rlFillTilemapEntryWithPattern
        jsr rsPhaseBannerDrawEmblem
        jsl rlDMAByStruct

          .structDMAToVRAM $7E7B88, $0800, $80, $A800

        plx
        lda #<>rlProcPhaseBannerDrawText
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 85/ACC2

      aPhaseBannerFrameTiles ; 85/ACC2

        .word $0307, $2308, $2309, $230A, $230B, $230C, $230D, $230E
        .word $2318, $2319, $231A, $231B, $231C, $231D, $231E, $2328
        .word $2329, $232A, $232B, $232C, $232D, $232E

      rlProcPhaseBannerDrawText ; 85/ACEE

        .al
        .xl
        .autsiz
        .databank ?

        ; The army's name and "PHASE", centred.

        phx
        lda #$2400
        sta aCurrentTilemapInfo,b
        lda wActiveFactionSlot,b
        jsl rlGetFactionSlotNamePointer
        lda lRoutineVariable+1,b
        sta lR18+1
        lda lRoutineVariable,b
        sta lR18
        jsl rlGetMenuTextStringLength
        lda #$001A
        sec
        sbc wR10
        lsr a
        and #$00FF
        ora #$0D00
        tax
        clc
        adc wR10
        pha
        lda #(`aPhaseBannerTextTilemapData)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aPhaseBannerTextTilemapData
        sta lMapMenuTilemapRAMEntryPointer,b
        jsl rlDrawMenuTextLine
        lda #(`aPhaseBannerPhaseText)<<8
        sta lR18+1
        lda #<>aPhaseBannerPhaseText
        sta lR18
        plx
        jsl rlDrawMenuTextLine
        jsl rlMarkAllMapMenuRowsDirty
        plx
        lda #<>rlProcPhaseBannerSlideIn
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

    .endsection Unsorted85AC89Section


    .section Table85AD47Section

      .al
      .xl

      aPhaseBannerPhaseText ; 85/AD47

        .enc "SJIS"
        .text "　ＰＨＡＳＥ"
        .word $0000
        .enc "none"


      aPhaseBannerFrameTilemapData ; 85/AD55
        .byte $20, $20, $00, $00, $00, $00, $88, $7B, $7E

      aPhaseBannerTextTilemapData ; 85/AD5E
        .byte $20, $1E, $00, $00, $00, $00, $88, $83, $7E

    .endsection Table85AD47Section


    .section Unsorted85AD67Section

      .al
      .xl

      rlProcPhaseBannerSlideIn ; 85/AD67

        .al
        .xl
        .autsiz
        .databank ?

        ; Shows the layers and starts the slide-in window (aPhaseBannerSlideInHDMAInfo).

        phx
        jsl rlShowMapMenuLayers
        lda #$0002
        sta wR40
        lda #(`aPhaseBannerSlideInHDMAInfo)<<8
        sta lR44+1
        lda #<>aPhaseBannerSlideInHDMAInfo
        sta lR44
        jsl rlHDMAEngineCreateEntryByIndex
        sep #$20
        lda #$02
        sta bBufferCGWSEL
        lda #$42
        sta bBufferCGADSUB
        lda #$11
        sta bBufferTS
        rep #$20
        plx
        lda #<>rlProcPhaseBannerWaitSlideIn
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 85/AD97

      rlProcPhaseBannerWaitSlideIn ; 85/AD97

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FEAAA
        cmp #$7FFF
        bne _ADA6
        lda #<>rlProcPhaseBannerWait
        sta aProcSystem.aHeaderOnCycle,b,x

        _ADA6
        rtl

        .databank 0

        ; 85/ADA7

      rlProcPhaseBannerWait ; 85/ADA7

        .al
        .xl
        .autsiz
        .databank ?

        ; Counts aBody6 down.

        dec aProcSystem.aBody6,b,x
        bpl _ADB2
        lda #<>rlProcPhaseBannerResetScroll
        sta aProcSystem.aHeaderOnCycle,b,x

        _ADB2
        rtl

        .databank 0

        ; 85/ADB3

      rlProcPhaseBannerResetScroll ; 85/ADB3

        .al
        .xl
        .autsiz
        .databank ?

        stz wBufferBG2VOFS
        stz wBufferBG2HOFS
        stz wBufferBG3VOFS
        stz wBufferBG3HOFS
        sep #$20
        lda #$02
        sta bBufferCGWSEL
        lda #$42
        sta bBufferCGADSUB
        lda #$11
        sta bBufferTS
        rep #$20
        jsr rsPhaseBannerLoadColours
        lda #<>rlProcPhaseBannerSlideOut
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 85/ADD5

      rlProcPhaseBannerSlideOut ; 85/ADD5

        .al
        .xl
        .autsiz
        .databank ?

        lda #<>rlProcPhaseBannerWaitSlideOut
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0002
        jsl rlHDMAEngineFreeEntryByIndex
        lda #$0002
        sta wR40
        lda #(`aPhaseBannerSlideOutHDMAInfo)<<8
        sta lR44+1
        lda #<>aPhaseBannerSlideOutHDMAInfo
        sta lR44
        jsl rlHDMAEngineCreateEntryByIndex
        rtl

        .databank 0

        ; 85/ADF6

      rlProcPhaseBannerWaitSlideOut ; 85/ADF6

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FEAAA
        cmp #$FFFF
        beq _AE00
        rtl


        _AE00
        phx
        lda #$030F
        sta wMapMenuClearTile,b
        lda #(`aPhaseBannerFrameTilemapData)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aPhaseBannerFrameTilemapData
        sta lMapMenuTilemapRAMEntryPointer,b
        jsl rlClearTilemapEntryTiles
        jsl rlDMAByStruct

          .structDMAToVRAM $7E7B88, $0800, $80, $A800

        plx
        lda #<>rlProcPhaseBannerClear
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 85/AE2C

      rlProcPhaseBannerClear ; 85/AE2C

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$20FF
        sta wMapMenuClearTile,b
        lda #(`aPhaseBannerTextTilemapData)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aPhaseBannerTextTilemapData
        sta lMapMenuTilemapRAMEntryPointer,b
        jsl rlClearTilemapEntryTiles
        jsl rlMarkAllMapMenuRowsDirty
        lda #$0002
        jsl rlHDMAEngineFreeEntryByIndex
        plx
        lda #<>rlProcPhaseBannerEnd
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 85/AE56

      rlProcPhaseBannerEnd ; 85/AE56

        .al
        .xl
        .autsiz
        .databank ?

        ; Puts back the palettes, colour math and game state, frees the proc and shows the map windows again.

        stz wBufferBG2VOFS
        stz wBufferBG2HOFS
        stz wBufferBG3VOFS
        stz wBufferBG3HOFS
        jsr rsPhaseBannerRestorePalettes
        sep #$20
        lda #$00
        sta bBufferCGWSEL
        lda #$00
        sta bBufferCGADSUB
        lda #$00
        sta bBufferTS
        lda #$E0
        sta bBufferCOLDATA_0
        sta bBufferCOLDATA_1
        sta bBufferCOLDATA_2
        sta bBufferCOLDATA_3
        rep #$20
        lda aProcSystem.aBody5,b,x
        sta wGameStateRoutine1,b
        jsl rlProcEngineFreeProc
        jsl rlShowMapWindows
        rtl

        .databank 0

        ; 85/AE8A

    .endsection Unsorted85AD67Section


    .section Unsorted85AE8ASection

      .al
      .xl

      rlPhaseBannerCheckSkip ; 85/AE8A

        .al
        .xl
        .autsiz
        .databank ?

        ; A button (A, B, X, Y, Start or Select): faster slide (speed 4) and 100 frames less.

        lda wJoy1New
        bit #$D0C0
        beq _AEAB
        lda #$0004
        sta $7FEAAC
        lda aProcSystem.aBody6,b,x
        sec
        sbc #$0064
        sta aProcSystem.aBody6,b,x
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0001
        sta aProcSystem.aHeaderBitfield,b,x

        _AEAB
        rtl

        .databank 0

        ; 85/AEAC

    .endsection Unsorted85AE8ASection


    .section ProcScript85AEACSection

      .al
      .xl

      aProcPhaseBannerCode ; 85/AEAC

        PROC_YIELD 1
        PROC_CALL rlPhaseBannerCheckSkip
        PROC_JUMP_IF_BITS_UNSET aProcPhaseBannerCode, $0001
        PROC_HALT


        ; 85/AEBB

    .endsection ProcScript85AEACSection


    .section Table85AEBBSection

      .al
      .xl

      aPhaseBannerSlideInHDMAInfo .dstruct structHDMAIndirectEntryInfo, rlPhaseBannerSlideInHDMAInit, rlPhaseBannerSlideInHDMACycle, aPhaseBannerHDMACode, $7FEAAE, PPU_REG_BASE + $2C, $40, $85 ; 85/AEBB

    .endsection Table85AEBBSection


    .section Unsorted85AEC7Section

      .al
      .xl

      rlPhaseBannerSlideInHDMAInit ; 85/AEC7

        .al
        .xl
        .autsiz
        .databank ?

        lda #$006E
        sta $7FEAAA
        jsr rsPhaseBannerBuildWindowTable
        rtl

        .databank 0

        ; 85/AED2

      rlPhaseBannerSlideInHDMACycle ; 85/AED2

        .al
        .xl
        .autsiz
        .databank ?

        ; Moves the window's edge (in $7FEAAA) by the speed ($7FEAAC) each frame; $7FEAAA = $7FFF when done.

        lda $7FEAAA
        sec
        sbc $7FEAAC
        sta $7FEAAA
        cmp #$0058
        bmi _AEE8

        _AEE4
        jsr rsPhaseBannerBuildWindowTable
        rtl


        _AEE8
        sec
        sbc #$0058
        clc
        adc $7FEAAC
        bmi _AEFE
        beq _AEFE
        lda #$0058
        sta $7FEAAA
        bra _AEE4


        _AEFE
        lda #<>rlPhaseBannerHDMADone
        sta aHDMASystem.aOnCycle,b,x
        lda #$7FFF
        sta $7FEAAA
        rtl

        .databank 0

        ; 85/AF0C

      rlPhaseBannerHDMADone ; 85/AF0C

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 85/AF0D

    .endsection Unsorted85AEC7Section


    .section Table85AF0DSection

      .al
      .xl

      aPhaseBannerHDMACode ; 85/AF0D
        HDMA_HALT

      aPhaseBannerSlideOutHDMAInfo .dstruct structHDMAIndirectEntryInfo, rlPhaseBannerSlideOutHDMAInit, rlPhaseBannerSlideOutHDMACycle, aPhaseBannerHDMACode, $7FEAAE, PPU_REG_BASE + $2C, $40, $85 ; 85/AF0F

    .endsection Table85AF0DSection


    .section Unsorted85AF1BSection

      .al
      .xl

      rlPhaseBannerSlideOutHDMAInit ; 85/AF1B

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0058
        sta $7FEAAA
        rtl

        .databank 0

        ; 85/AF23

      rlPhaseBannerSlideOutHDMACycle ; 85/AF23

        .al
        .xl
        .autsiz
        .databank ?

        ; Like the slide in, the other way; $7FEAAA = $FFFF when done.

        lda $7FEAAA
        clc
        adc $7FEAAC
        sta $7FEAAA
        cmp #$0071
        bpl _AF39

        _AF35
        jsr rsPhaseBannerBuildWindowTable
        rtl


        _AF39
        sec
        sbc #$0070
        cmp $7FEAAC
        bpl _AF4C
        lda #$0070
        sta $7FEAAA
        bra _AF35


        _AF4C
        lda #<>rlPhaseBannerHDMADone
        sta aHDMASystem.aOnCycle,b,x
        lda #$FFFF
        sta $7FEAAA
        rtl

        .databank 0

        ; 85/AF5A

      rsPhaseBannerBuildWindowTable ; 85/AF5A

        .al
        .xl
        .autsiz
        .databank ?

        ; Builds the window table in one of two halves of the buffer at $7FEAAE (alternating frames) and points the HDMA entry at it.

        lda wVBlankEnabledFramecount
        bit #$0001
        bne _AF66
        lda #$0000
        bra _AF69


        _AF66
        lda #$0010

        _AF69
        sta wR4
        jsr rsPhaseBannerWriteWindowTable
        lda #$EAAE
        clc
        adc wR4
        sta aHDMASystem.aOffset,b,x
        rts

        .databank 0

        ; 85/AF78

      rsPhaseBannerWriteWindowTable ; 85/AF78

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7FEAAA
        ldx wR4
        sep #$20
        sta $7FEAAE,x
        rep #$20
        asl a
        sta wR0
        lda #<>aPhaseBannerWindowOn
        sta $7FEAAF,x
        lda #$00E0
        sec
        sbc wR0
        sep #$20
        sta $7FEAB1,x
        rep #$20
        lda #<>aPhaseBannerWindowOff
        sta aDialogueBoxHDMAIndirectTableOdd,x
        lda $7FEAAA
        dec a
        sep #$20
        sta $7FEAB4,x
        rep #$20
        lda #<>aPhaseBannerWindowOn
        sta $7FEAB5,x
        lda #$0000
        sta $7FEAB7,x
        plx
        rts

        .databank 0

        ; 85/AFC3


      aPhaseBannerWindowOn ; 85/AFC3

        .byte $11

      aPhaseBannerWindowOff ; 85/AFC4

        .byte $17

    .endsection Unsorted85AF1BSection


    .section Unsorted85AFC5Section

      .al
      .xl

      rsPhaseBannerDrawEmblem ; 85/AFC5

        .al
        .xl
        .autsiz
        .databank ?

        ; Writes the 3x4 emblem tiles ($3F80...) into the frame layer.

        phb
        php
        phk
        plb
        .databank $85
        phy
        phx
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb
        .databank $7E
        ldy #$7EA6
        lda #$3F80
        sta wR0
        stz wR1

        _AFDD
        ldx #$0000

        _AFE0
        lda wR0
        sta $0000,b,y
        cpx #$0002
        beq _AFF1
        inc x
        inc y
        inc y
        inc wR0
        bra _AFE0


        _AFF1
        lda wR1
        cmp #$0003
        beq _B004
        inc wR0
        inc wR1
        tya
        clc
        adc #$003C
        tay
        bra _AFDD


        _B004
        plx
        ply
        plp
        plb
        .databank $7E
        rts

        .databank 0

        ; 85/B009

    .endsection Unsorted85AFC5Section


    .section Unsorted85B009Section

      .al
      .xl

      rsPhaseBannerSavePalettes ; 85/B009

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000

        _B00D
        lda $0108,b,x
        sta $7FEACE,x
        lda $01D0,b,x
        sta $7FEAD6,x
        lda $01D8,b,x
        sta $7FEADE,x
        lda $01F0,b,x
        sta $7FEAEE,x
        lda $01F8,b,x
        sta $7FEB0E,x
        inc x
        inc x
        cpx #$0008
        bmi _B00D
        plx
        rts

        .databank 0

        ; 85/B039

    .endsection Unsorted85B009Section


    .section Unsorted85B039Section

      .al
      .xl

      rsPhaseBannerRestorePalettes ; 85/B039

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000

        _B03D
        lda $7FEACE,x
        sta $0108,b,x
        lda $7FEAD6,x
        sta $01D0,b,x
        lda $7FEADE,x
        sta $01D8,b,x
        lda $7FEAEE,x
        sta $01F0,b,x
        lda $7FEB0E,x
        sta $01F8,b,x
        inc x
        inc x
        cpx #$0008
        bmi _B03D
        plx
        rts

        .databank 0

        ; 85/B069

      rsPhaseBannerWhitenText ; 85/B069

        .al
        .xl
        .autsiz
        .databank ?

        ; Sets colours $68-$6F to white. Nothing in the build reaches this.

        phx
        ldx #$0000

        _B06D
        lda #$7FFF
        sta $01D0,b,x
        inc x
        inc x
        cpx #$0010
        bmi _B06D
        plx
        rts

        .databank 0

        ; 85/B07C

    .endsection Unsorted85B039Section


    .section Unsorted85B07CSection

      .al
      .xl

      rsPhaseBannerLoadColours ; 85/B07C

        .al
        .xl
        .autsiz
        .databank ?

        ; By the active army's relation to the player.

        phx
        lda #$0000
        ldx wActiveFactionSlot,b
        jsl rlGetFactionRelation
        sta wR0
        jsr rsPhaseBannerLoadTextColours
        jsr rsPhaseBannerLoadFrameColours
        plx
        rts

        .databank 0

        ; 85/B091

      rsPhaseBannerLoadTextColours ; 85/B091

        .al
        .xl
        .autsiz
        .databank ?

        phx
        sep #$20
        lda #$85
        sta $7FEACC
        rep #$20
        lda wR0
        asl a
        tax
        lda aPhaseBannerTextPalettes,x
        sta $7FEACA
        sta wR1
        ldx #$0000

        _B0AD
        lda (wR1)
        sta $01D0,b,x
        inc x
        inc x
        inc wR1
        inc wR1
        cpx #$0010
        bmi _B0AD
        plx
        rts

        .databank 0

        ; 85/B0BF

    .endsection Unsorted85B07CSection


    .section Table85B0BFSection

      .al
      .xl

      aPhaseBannerTextPalettes ; 85/B0BF

        ; Read by rsPhaseBannerLoadTextColours.

        ; By relation to the player (rlGetFactionRelation): 8 colours each, for colours $68-$6F (aBGPaletteBuffer+$D0).
        .word <>aPhaseBannerTextPalette0, <>aPhaseBannerTextPalette1, <>aPhaseBannerTextPalette2, <>aPhaseBannerTextPalette3

      aPhaseBannerTextPalette0 ; 85/B0C7

        .word $4D96, $039C, $7292, $6A70, $6A2F, $660E, $61ED, $04A7

      aPhaseBannerTextPalette1 ; 85/B0D7

        .word $3000, $039C, $24F9, $0CB7, $1896, $1475, $1054, $04A7

      aPhaseBannerTextPalette2 ; 85/B0E7

        .word $3000, $039C, $5370, $4B2E, $470D, $42EC, $3AAA, $04A7

      aPhaseBannerTextPalette3 ; 85/B0F7

        .word $3000, $03FF, $5F9C, $537B, $4B18, $3EF8, $2E96, $08C8

        ; 85/B107

    .endsection Table85B0BFSection


    .section Unsorted85B107Section

      .al
      .xl

      rsPhaseBannerLoadFrameColours ; 85/B107

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda wR0
        asl a
        tax
        lda aPhaseBannerFramePalettes,x
        sta wR1
        ldx #$0000

        _B115
        lda (wR1)
        sta $0108,b,x
        inc x
        inc x
        inc wR1
        inc wR1
        cpx #$0008
        bmi _B115
        plx
        rts

        .databank 0

        ; 85/B127

    .endsection Unsorted85B107Section


    .section Table85B127Section

      .al
      .xl

      aPhaseBannerFramePalettes ; 85/B127

        ; Read by rsPhaseBannerLoadFrameColours.

        ; By relation to the player: 4 colours each, for colours 4-7 (aBGPaletteBuffer+$08).
        .word <>aPhaseBannerFramePalette0, <>aPhaseBannerFramePalette1, <>aPhaseBannerFramePalette2, <>aPhaseBannerFramePalette3

      aPhaseBannerFramePalette0 ; 85/B12F

        .word $4D96, $152B, $67DE, $0864

      aPhaseBannerFramePalette1 ; 85/B137

        .word $4D96, $1529, $67FC, $0443

      aPhaseBannerFramePalette2 ; 85/B13F

        .word $4D96, $1509, $6FBE, $0423

      aPhaseBannerFramePalette3 ; 85/B147

        .word $4D96, $212A, $737D, $0C44

        ; 85/B14F

    .endsection Table85B127Section


