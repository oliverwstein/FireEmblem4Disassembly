; Portraits shown on the world map.
; Also the procs and helpers that only the portrait routines use.

    .section DecompressWorldMapPortraitToSlotSection

      .al
      .xl

      rlDecompressWorldMapPortraitToSlot ; 8A/B49A

        .al
        .autsiz
        .databank $8A

        ; Input:
        ; A = CharacterID / also PortraitDialogue
        ; X = portrait slot offset

        ; Output:
        ; lR18 = Decompression buffer pointer
        ; lR19 = Portrait palette

        phk
        plb

        phy
        sta wTempVariable1,b

        jsl rlGetCharacterPortraitDataID
        jsr rlTryGetClassPortraitDataID
        ply

        sta wR0
        clc
        adc wR0
        clc
        adc wR0
        tax

        lda @l aPortraitGraphicPointers,x
        sta lR45
        lda @l aPortraitGraphicPointers+1,x
        sta lR45+1
        lda #(`aDecompressionBuffer)<<8
        sta lR47+1
        lda aPortraitSlotDecompressionPointers,y
        sta lR47

        phx
        phy
        jsl rlDecompressSingle
        ply
        plx

        lda #(`aDecompressionBuffer)<<8
        sta lR18+1
        lda #<>aDecompressionBuffer
        sta lR18

        lda aPortraitSlotDecompressionPointers,y
        sta lR18
        lda @l aPortraitPalettePointers+1,x
        sta lR19+1
        lda @l aPortraitPalettePointers,x
        sta lR19
        rtl

        .databank 0

    .endsection DecompressWorldMapPortraitToSlotSection


    .section FadeInWorldMapPortraitSlotSection

      .al
      .xl

      rlFadeInWorldMapPortraitSlot ; 8B/821F

        .al
        .autsiz
        .databank ?

        lda wR0
        sta aWorldMapPortrait.wXPosition[0],x
        lda wR1
        sta aWorldMapPortrait.wYPosition[0],x
        lda #$FFFF
        sta aWorldMapPortrait.wStatus[0],x

        txa
        sta wTempVariable1,b

        lda #(`procFadeInWorldMapPortraitSlot)<<8
        sta lR44+1
        lda #<>procFadeInWorldMapPortraitSlot
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

      rlFadeOutWorldMapPortraitSlot ; 8B/8245

        .al
        .autsiz
        .databank ?

        lda wGameStateRoutine1,b
        bne +

          jml rlFadeOutFirstGenerationEndingPortrait

        +
        txa
        sta wTempVariable1,b

        lda #(`procFadeOutWorldMapPortraitSlot)<<8
        sta lR44+1
        lda #<>procFadeOutWorldMapPortraitSlot
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

      rlMoveWorldMapPortraitSlot ; 8B/8261

        .al
        .autsiz
        .databank ?

        lda wR0
        sta aWorldMapPortrait.wXPosition[0],x
        lda wR1
        sta aWorldMapPortrait.wYPosition[0],x
        lda #$FFFF
        sta aWorldMapPortrait.wStatus[0],x
        rtl

        .databank 0

      rsHandleWorldMapPortraits ; 8B/8275

        .al
        .autsiz
        .databank ?

        ldx #6 * size(word)

          _Loop
          lda aWorldMapPortrait.wStatus[0],x
          beq _Next

            lda aWorldMapPortrait.wXPosition[0],x
            sta wR0
            lda aWorldMapPortrait.wYPosition[0],x
            sta wR1
            phx
            jsl rlHandleWorldMapPortraitEffect
            plx

          _Next
          dec x
          dec x
          bpl _Loop

        rts

        .databank 0

      rlHandleWorldMapPortraitEffect ; 8B/8295

        .al
        .autsiz
        .databank ?

        sep #$20
        lda #`aWorldMapPortraitSprite
        pha
        plb
        rep #$20

        ldy #<>aWorldMapPortraitSprite
        lda aWorldMapPortraitAttributeBase,x
        sta wR5
        lda aWorldMapPortraitSpriteBase,x
        sta wR4
        jsl rlPushToOAMBuffer
        rtl

        .databank 0

      aWorldMapPortraitAttributeBase ; 8B/82B1

        .word OAMTileAndAttr(0, 2, 0, false, false)
        .word OAMTileAndAttr(0, 3, 0, false, false)
        .word OAMTileAndAttr(0, 4, 0, false, false)
        .word OAMTileAndAttr(0, 5, 0, false, false)
        .word OAMTileAndAttr(0, 6, 0, false, false)
        .word OAMTileAndAttr(0, 7, 0, false, false)

      aWorldMapPortraitSpriteBase ; 8B/82BD

        .word $0080
        .word $00C0
        .word $0100
        .word $0140
        .word $0180
        .word $01C0

      aWorldMapPortraitSprite ; 8B/82C9

        _Sprites := [[(  32,   48), $21, SpriteLarge, $002A, 3, 0, false, false]]
        _Sprites..= [[(  16,   48), $21, SpriteLarge, $0028, 3, 0, false, false]]
        _Sprites..= [[(   0,   48), $21, SpriteLarge, $0026, 3, 0, false, false]]
        _Sprites..= [[(  32,   32), $21, SpriteLarge, $000A, 3, 0, false, false]]
        _Sprites..= [[(  16,   32), $21, SpriteLarge, $0008, 3, 0, false, false]]
        _Sprites..= [[(   0,   32), $21, SpriteLarge, $0006, 3, 0, false, false]]
        _Sprites..= [[(  32,   16), $21, SpriteLarge, $0024, 3, 0, false, false]]
        _Sprites..= [[(  16,   16), $21, SpriteLarge, $0022, 3, 0, false, false]]
        _Sprites..= [[(   0,   16), $21, SpriteLarge, $0020, 3, 0, false, false]]
        _Sprites..= [[(  32,    0), $21, SpriteLarge, $0004, 3, 0, false, false]]
        _Sprites..= [[(  16,    0), $21, SpriteLarge, $0002, 3, 0, false, false]]
        _Sprites..= [[(   0,    0), $21, SpriteLarge, $0000, 3, 0, false, false]]

        .structSpriteArray aWorldMapPortraitSprite._Sprites

      aWorldMapPortraitSpriteMirrored ; 8B/8307

        _Sprites := [[(   0,   48), $21, SpriteLarge, $002A, 3, 0, true, false]]
        _Sprites..= [[(  16,   48), $21, SpriteLarge, $0028, 3, 0, true, false]]
        _Sprites..= [[(  32,   48), $21, SpriteLarge, $0026, 3, 0, true, false]]
        _Sprites..= [[(   0,   32), $21, SpriteLarge, $000A, 3, 0, true, false]]
        _Sprites..= [[(  16,   32), $21, SpriteLarge, $0008, 3, 0, true, false]]
        _Sprites..= [[(  32,   32), $21, SpriteLarge, $0006, 3, 0, true, false]]
        _Sprites..= [[(   0,   16), $21, SpriteLarge, $0024, 3, 0, true, false]]
        _Sprites..= [[(  16,   16), $21, SpriteLarge, $0022, 3, 0, true, false]]
        _Sprites..= [[(  32,   16), $21, SpriteLarge, $0020, 3, 0, true, false]]
        _Sprites..= [[(   0,    0), $21, SpriteLarge, $0004, 3, 0, true, false]]
        _Sprites..= [[(  16,    0), $21, SpriteLarge, $0002, 3, 0, true, false]]
        _Sprites..= [[(  32,    0), $21, SpriteLarge, $0000, 3, 0, true, false]]

        .structSpriteArray aWorldMapPortraitSpriteMirrored._Sprites

        ; 8B/8345

    .endsection FadeInWorldMapPortraitSlotSection


    .section WorldMapPortraitSection

      .al
      .xl

      rlLoadWorldMapPortraitIntoSlot ; 8B/8345

        .al
        .autsiz
        .databank ?

        ldy wGameStateRoutine1,b
        cpy #0
        bne +

          jml rlLoadFirstGenerationEndingPortrait

        +
        phx
        txy
        jsl rlDecompressWorldMapPortraitToSlot
        plx

        phx
        lda aPortraitSlotPaletteOffsets,x
        sec
        sbc #2
        tax

        ldy #size(Palette) - size(word)

          -
          lda [lR19],y
          sta aPortraitSlotsPaletteBuffer + size(Palette),x
          dec x
          dec x
          dec y
          dec y
          bpl -

        lda #$35AD
        sta aPortraitSlotsPaletteBuffer + size(Palette) +$1E,x
        plx

        ; Portrait size
        lda #$0800
        sta wR0

        lda #$6000
        clc
        adc aPortraitSlotVRAMOffsets,x
        sta wR1
        phx
        jsl rlDMAByPointer
        plx
        rtl

        .databank 0

      aPortraitSlotPaletteOffsets ; 8B/838F

        .word size(Palette) * 2
        .word size(Palette) * 3
        .word size(Palette) * 4
        .word size(Palette) * 5
        .word size(Palette) * 6
        .word size(Palette) * 7

      aPortraitSlotVRAMOffsets ; 8B/839B

        .word $0800
        .word $0C00
        .word $1000
        .word $1400
        .word $1800
        .word $1C00

        ; 8B/83A7

    .endsection WorldMapPortraitSection


    .section Unreferenced8B83A7Section

      .al
      .xl

      rsFadeColorWarmUnused ; 8B/83A7

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        sta wR0
        lda wR0
        and #$001F
        sta wR1
        lda wR0
        and #$03E0
        lsr a
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR2
        lda wR0
        and #$7C00
        xba
        lsr a
        lsr a
        sta wR3
        lda wR2
        clc
        adc wR3
        lsr a
        sta wR5
        sta wR6
        lda wR1
        clc
        adc wR5
        lsr a
        sec
        sbc #$0005
        bpl _83DF
        lda #$0000

        _83DF
        sta wR6
        clc
        adc #$0004
        sta wR5
        clc
        adc #$0003
        sta wR4
        lda wR4
        and #$001F
        sta wR1
        lda wR5
        asl a
        asl a
        asl a
        asl a
        asl a
        and #$03E0
        sta wR2
        lda wR6
        xba
        asl a
        asl a
        and #$7C00
        sta wR3
        lda wR1
        clc
        adc wR2
        clc
        adc wR3
        rts

        .databank 0

        ; 8B/8413

      rsHalveColorBrightnessUnused ; 8B/8413

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        sta wR0
        lda wR0
        and #$001F
        sta wR1
        lda wR0
        and #$03E0
        lsr a
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR2
        lda wR0
        and #$7C00
        xba
        lsr a
        lsr a
        sta wR3
        lda wR1
        lsr a
        sta wR4
        lda wR2
        lsr a
        sta wR5
        lda wR3
        lsr a
        sta wR6
        lda wR4
        sta wR1
        lda wR5
        asl a
        asl a
        asl a
        asl a
        asl a
        sta wR2
        lda wR6
        xba
        asl a
        asl a
        sta wR3
        lda wR1
        clc
        adc wR2
        clc
        adc wR3
        rts

        .databank 0

        ; 8B/845E

      rsDimDominantColorChannelUnused ; 8B/845E

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        sta wR0
        lda wR0
        and #$001F
        sta wR1
        lda wR0
        and #$03E0
        lsr a
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR2
        lda wR0
        and #$7C00
        xba
        lsr a
        lsr a
        sta wR3
        lda wR1
        cmp wR2
        bcc _8494
        lda wR1
        cmp wR3
        bcc _8494
        lda wR1
        sec
        sbc #$0003
        bpl _8494
        lda #$0000

        _8494
        sta wR4
        lda wR2
        cmp wR1
        bcc _84AD
        lda wR2
        cmp wR3
        bcc _84AD
        lda wR2
        sec
        sbc #$0003
        bpl _84AD
        lda #$0000

        _84AD
        sta wR5
        lda wR3
        cmp wR1
        bcc _84C6
        lda wR3
        cmp wR2
        bcc _84C6
        lda wR3
        sec
        sbc #$0003
        bpl _84C6
        lda #$0000

        _84C6
        sta wR6
        lda wR4
        sta wR1
        lda wR5
        asl a
        asl a
        asl a
        asl a
        asl a
        sta wR2
        lda wR6
        xba
        asl a
        asl a
        sta wR3
        lda wR1
        clc
        adc wR2
        clc
        adc wR3
        rts

        .databank 0

        ; 8B/84E5

    .endsection Unreferenced8B83A7Section
    .section FadeInWorldMapPortraitSlot8B8C83Section

      .al
      .xl

      procFadeInWorldMapPortraitSlot ; 8B/8C83

        .structProcInfo "FN", rlProcFadeInWorldMapPortraitSlotInit, rlProcFadeInWorldMapPortraitSlotCycle, aProcFadeInWorldMapPortraitSlotCode

      rlProcFadeInWorldMapPortraitSlotInit ; 8B/8C8B

        .al
        .autsiz
        .databank ?

        ; Color bightness
        lda #$001E
        sta aProcSystem.aBody0,b,x

        lda wTempVariable1,b
        sta aProcSystem.aBody1,b,x
        rtl

        .databank 0

    .endsection FadeInWorldMapPortraitSlot8B8C83Section


    .section ProcFadeInWorldMapPortraitSlotCycleSection

      .al
      .xl

      rlProcFadeInWorldMapPortraitSlotCycle ; 8B/8C98

        .al
        .autsiz
        .databank ?

        .for i in range(15)

          lda #(i+1) * $200
          sta lR18+1
          lda #<>(aOAMPaletteBuffer.aPalette0 + ((i+1) * size(word)))
          sta lR18
          lda #(i+1) * $200 + $7F
          sta lR19+1
          lda #<>(aPortraitSlotsPaletteBuffer + ((i+1) * size(word)))
          sta lR19
          jsl rlIncreaseColorBightnessOfPortraitSlot

        .endfor

        lda wVBlankEnabledFramecount
        and #$0003
        bne _End

          lda aProcSystem.aBody0,b,x
          dec a
          dec a
          sta aProcSystem.aBody0,b,x
          bmi +

        _End
        rtl

        +
        jsl rlProcEngineFreeProc
        rtl

        .databank 0

    .endsection ProcFadeInWorldMapPortraitSlotCycleSection


    .section ProcFadeInWorldMapPortraitSlotCodeSection

      .al
      .xl

      aProcFadeInWorldMapPortraitSlotCode ; 8B/8E17
        
        PROC_HALT

      procFadeOutWorldMapPortraitSlot ; 8B/8E19

        .structProcInfo "FF", rlProcFadeOutWorldMapPortraitSlotInit, rlProcFadeOutWorldMapPortraitSlotCycle, aProcFadeOutWorldMapPortraitSlotCode

      rlProcFadeOutWorldMapPortraitSlotInit ; 8B/8E21

        .al
        .autsiz
        .databank ?

        lda #0
        sta aProcSystem.aBody0,b,x
        lda wTempVariable1,b
        sta aProcSystem.aBody1,b,x
        rtl

        .databank 0

      rlProcFadeOutWorldMapPortraitSlotCycle ; 8B/8E2E

        .al
        .autsiz
        .databank ?

        .for i in range(15)

          lda #(i+1) * $200
          sta lR18+1
          lda #aOAMPaletteBuffer.aPalette0 + ((i+1) * size(word))
          sta lR18
          jsl rlDecreaseColorBightnessOfPortraitSlot

        .endfor

        lda wVBlankEnabledFramecount
        and #$0001
        bne _End

          lda aProcSystem.aBody0,b,x
          inc a
          inc a
          sta aProcSystem.aBody0,b,x
          cmp #32
          beq +

        _End
        rtl
        
        +
        lda aProcSystem.aBody1,b,x
        phx

        tax
        lda #0
        sta aWorldMapPortrait.wStatus[0],x
        plx

        jsl rlProcEngineFreeProc
        rtl

        .databank 0

      aProcFadeOutWorldMapPortraitSlotCode ; 8B/8F27

        PROC_HALT

      rlDecreaseColorBightnessOfPortraitSlot ; 8B/8F29

        .al
        .autsiz
        .databank $8B

        lda aProcSystem.aBody1,b,x
        tay
        lda _PalettePointers,y
        tay
        lda [lR18],y
        sta wR0

        lda aProcSystem.aBody0,b,x
        phx

        tax
        jsl rlModifyPortraitColorBightness
        sta [lR18],y

        plx
        rtl

        _PalettePointers ; 8B/8F42
        .word size(Palette) * 2
        .word size(Palette) * 3
        .word size(Palette) * 4
        .word size(Palette) * 5
        .word size(Palette) * 6
        .word size(Palette) * 7

        .databank 0

      rlIncreaseColorBightnessOfPortraitSlot ; 8B/8F4E

        .al
        .autsiz
        .databank $8B

        ; Input:
        ; lR19 = pointer to color
        ; aProcSystem.aBody0 = brightness value
        ; aProcSystem.aBody1 = potrait slot

        phk
        plb

        lda aProcSystem.aBody1,b,x
        tay
        lda _PalettePointers,y
        tay

        sep #$20
        lda #`aPortraitSlotsPaletteBuffer
        pha
        plb
        rep #$20

        ; Get the target color
        lda (lR19),y
        sta wR0

        phk
        plb

        lda aProcSystem.aBody0,b,x
        phx

        tax
        jsl rlModifyPortraitColorBightness
        sta [lR18],y

        plx
        rtl

        _PalettePointers ; 8B/8F73
        .word size(Palette) * 2
        .word size(Palette) * 3
        .word size(Palette) * 4
        .word size(Palette) * 5
        .word size(Palette) * 6
        .word size(Palette) * 7

        .databank 0

      rlModifyPortraitColorBightness ; 8B/8F7F

        .al
        .autsiz
        .databank ?

        ; Input:
        ; X = brightness value
        ; wR0 = color

        ; Output:
        ; wR0 = adjusted color

        phk
        plb
        lda wR0
        and #Color_Red
        cmp aModifyColorBrightnessRed,x
        bcs +

          lda aModifyColorBrightnessRed,x

        +
        sta wR1

        lda wR0
        and #Color_Green
        cmp aModifyColorBrightnessGreen,x
        bcs +

          lda aModifyColorBrightnessGreen,x

        +
        sta wR2

        lda wR0
        and #Color_Blue
        cmp aModifyColorBrightnessBlue,x
        bcs +

          lda aModifyColorBrightnessBlue,x

        +
        sta wR3

        lda wR1
        ora wR2
        ora wR3
        sta wR0
        rtl

        .databank 0

      aModifyColorBrightnessRed ; 8B/8FBD

        .word $0000
        .word $0001
        .word $0002
        .word $0003
        .word $0004
        .word $0005
        .word $0006
        .word $0007
        .word $0008
        .word $0009
        .word $000A
        .word $000C
        .word $000E
        .word $0010
        .word $0012
        .word $0014

      aModifyColorBrightnessGreen ; 8B/8FDD

        .word $0000
        .word $0020
        .word $0040
        .word $0060
        .word $0080
        .word $00A0
        .word $00C0
        .word $00E0
        .word $0100
        .word $0120
        .word $0140
        .word $0180
        .word $01C0
        .word $0200
        .word $0240
        .word $0280

      aModifyColorBrightnessBlue ; 8B/8FFD

        .word $0000
        .word $0400
        .word $0800
        .word $0C00
        .word $1000
        .word $1400
        .word $1800
        .word $1C00
        .word $2000
        .word $2400
        .word $2800
        .word $3000
        .word $3800
        .word $4000
        .word $4800
        .word $5000

      procWorldMapFadeInHighlightColor ; 8B/901D

        .structProcInfo "GC", rlProcWorldMapFadeInHighlightColorInit, rlProcWorldMapFadeInHighlightColorCycle, aProcWorldMapFadeInHighlightColorCode

      rlProcWorldMapFadeInHighlightColorInit ; 8B/9025

        .al
        .autsiz
        .databank ?

        lda #0
        sta $7F548C
        rtl

        .databank 0

      rlProcWorldMapFadeInHighlightColorCycle ; 8B/902D

        .al
        .autsiz
        .databank $8B

        lda $7F548C
        asl a
        tay
        lda aWorldMapHighlightFadeColors,y
        sta aBGPaletteBuffer.aPalette1+2,b

        lda $DB
        and #$0001
        bne _End

          lda $7F548C
          clc
          adc #1
          cmp #48
          beq +

            sta $7F548C

        _End
        rtl

        +
        jsl rlProcEngineFreeProc
        rtl

        .databank 0

      aWorldMapHighlightFadeColors ; 8B/9057

        .word $0000, $0001, $0001, $0001, $0001, $0002, $0002, $0002
        .word $0002, $0003, $0003, $0003, $0003, $0004, $0004, $0004
        .word $0004, $0005, $0005, $0005, $0005, $0006, $0006, $0006
        .word $0007, $0007, $0007, $0008, $0008, $0008, $0009, $0009
        .word $0009, $000A, $000A, $000A, $000B, $000B, $000B, $000C
        .word $000C, $000C, $000D, $000D, $000E, $000E, $000F, $000F
        .word $0010, $0011, $0012, $0013, $0014, $0015, $0416, $0417
        .word $0418, $0419, $041A, $041B, $041C, $041D, $041E, $041F

      aProcWorldMapFadeInHighlightColorCode ; 8B/90D7

        PROC_HALT

      procWorldMapFadeOutHighlightColor ; 8B/90D9

        .structProcInfo "GL", rlProcWorldMapFadeOutHighlightColorInit, rlProcWorldMapFadeOutHighlightColorCycle, aProcWorldMapFadeOutHighlightColorCode

      rlProcWorldMapFadeOutHighlightColorInit ; 8B/90E1

        .al
        .autsiz
        .databank ?

        lda #47
        sta $7F548C
        rtl

        .databank 0

      rlProcWorldMapFadeOutHighlightColorCycle ; 8B/90E9

        .al
        .autsiz
        .databank $8B

        lda $7F548C
        asl a
        tay
        lda aWorldMapHighlightFadeColors,y
        sta aBGPaletteBuffer.aPalette1+2,b

        lda $DB
        and #$0001
        bne _End

          lda $7F548C
          sec
          sbc #1
          bmi +

            sta $7F548C

        _End
        rtl
        
        +
        jsl rlProcEngineFreeProc

        jsl rlDMAByStruct

          .structDMAToVRAM $7E7B88, 32 * 21 * size(word), $80, $A800

        rtl

        .databank 0

      aProcWorldMapFadeOutHighlightColorCode ; 8B/911D

        PROC_HALT

      ; 8B/911F

    .endsection ProcFadeInWorldMapPortraitSlotCodeSection


