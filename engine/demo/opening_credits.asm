; The staff credits of the attract mode's opening (the event script in
; engine/demo/opening.asm). Each RUN_ASM routine here blanks the screen, loads
; one page of credits as a BG3 tilemap (gcOpeningCreditsPage1...), sets up the
; screen with the credits font (rsSetUpOpeningCreditsScreen) and starts the
; page's HDMA scroll effects. Pages 1-8: game designer and director, advisors,
; programmers, graphic designers, sound and art, assistants, special thanks,
; producer. Bank $8D, with the horizontal scroll HDMA infos from bank $8B.

    .section OpeningCreditsSection

      .al
      .xl

      rlShowOpeningCreditsPage1 ; 8D/AAFD

        .al
        .xl
        .autsiz
        .databank ?

        php
        sep #$20
        lda #$80
        sta $2100,b
        sta bBufferINIDISP
        rep #$20
        lda #(`aOpeningCreditsPage1Tilemap)<<8
        sta lR19+1
        lda #<>aOpeningCreditsPage1Tilemap
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        jsr rsSetUpOpeningCreditsScreen
        lda #(`aOpeningCreditsVScrollHDMAInfo1)<<8
        sta lR44+1
        lda #<>aOpeningCreditsVScrollHDMAInfo1
        sta lR44
        jsl rlHDMAEngineCreateEntry
        plp
        rtl

        .databank 0

      aOpeningCreditsPage1Tilemap .structDecompressionDMAEntry gcOpeningCreditsPage1, $0700, $5800 ; 8D/AB2A

      rlShowOpeningCreditsPage2 ; 8D/AB32

        .al
        .xl
        .autsiz
        .databank ?

        php
        sep #$20
        lda #$80
        sta $2100,b
        sta bBufferINIDISP
        rep #$20
        lda #(`aOpeningCreditsPage2Tilemap)<<8
        sta lR19+1
        lda #<>aOpeningCreditsPage2Tilemap
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        jsr rsSetUpOpeningCreditsScreen
        lda #(`aOpeningCreditsVScrollHDMAInfo2)<<8
        sta lR44+1
        lda #<>aOpeningCreditsVScrollHDMAInfo2
        sta lR44
        jsl rlHDMAEngineCreateEntry
        plp
        rtl

        .databank 0

      aOpeningCreditsPage2Tilemap .structDecompressionDMAEntry gcOpeningCreditsPage2, $0700, $5800 ; 8D/AB5F

      rlShowOpeningCreditsPage3 ; 8D/AB67

        .al
        .xl
        .autsiz
        .databank ?

        php
        sep #$20
        lda #$80
        sta $2100,b
        sta bBufferINIDISP
        rep #$20
        lda #(`aOpeningCreditsPage3Tilemap)<<8
        sta lR19+1
        lda #<>aOpeningCreditsPage3Tilemap
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        jsr rsSetUpOpeningCreditsScreen
        lda #(`aOpeningCreditsVScrollHDMAInfo3)<<8
        sta lR44+1
        lda #<>aOpeningCreditsVScrollHDMAInfo3
        sta lR44
        jsl rlHDMAEngineCreateEntry
        lda #(`aOpeningCreditsHScrollHDMAInfo1)<<8
        sta lR44+1
        lda #<>aOpeningCreditsHScrollHDMAInfo1
        sta lR44
        jsl rlHDMAEngineCreateEntry
        plp
        rtl

        .databank 0

      aOpeningCreditsPage3Tilemap .structDecompressionDMAEntry gcOpeningCreditsPage3, $0700, $5800 ; 8D/ABA2

      rlShowOpeningCreditsPage4 ; 8D/ABAA

        .al
        .xl
        .autsiz
        .databank ?

        php
        sep #$20
        lda #$80
        sta $2100,b
        sta bBufferINIDISP
        rep #$20
        lda #(`aOpeningCreditsPage4Tilemap)<<8
        sta lR19+1
        lda #<>aOpeningCreditsPage4Tilemap
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        jsr rsSetUpOpeningCreditsScreen
        lda #(`aOpeningCreditsVScrollHDMAInfo4)<<8
        sta lR44+1
        lda #<>aOpeningCreditsVScrollHDMAInfo4
        sta lR44
        jsl rlHDMAEngineCreateEntry
        lda #(`aOpeningCreditsHScrollHDMAInfo2)<<8
        sta lR44+1
        lda #<>aOpeningCreditsHScrollHDMAInfo2
        sta lR44
        jsl rlHDMAEngineCreateEntry
        plp
        rtl

        .databank 0

      aOpeningCreditsPage4Tilemap .structDecompressionDMAEntry gcOpeningCreditsPage4, $0700, $5800 ; 8D/ABE5

      rlShowOpeningCreditsPage5 ; 8D/ABED

        .al
        .xl
        .autsiz
        .databank ?

        php
        sep #$20
        lda #$80
        sta $2100,b
        sta bBufferINIDISP
        rep #$20
        lda #(`aOpeningCreditsPage5Tilemap)<<8
        sta lR19+1
        lda #<>aOpeningCreditsPage5Tilemap
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        jsr rsSetUpOpeningCreditsScreen
        lda #(`aOpeningCreditsVScrollHDMAInfo5)<<8
        sta lR44+1
        lda #<>aOpeningCreditsVScrollHDMAInfo5
        sta lR44
        jsl rlHDMAEngineCreateEntry
        lda #(`aOpeningCreditsHScrollHDMAInfo3)<<8
        sta lR44+1
        lda #<>aOpeningCreditsHScrollHDMAInfo3
        sta lR44
        jsl rlHDMAEngineCreateEntry
        plp
        rtl

        .databank 0

      aOpeningCreditsPage5Tilemap .structDecompressionDMAEntry gcOpeningCreditsPage5, $0700, $5800 ; 8D/AC28

      rlShowOpeningCreditsPage6 ; 8D/AC30

        .al
        .xl
        .autsiz
        .databank ?

        php
        sep #$20
        lda #$80
        sta $2100,b
        sta bBufferINIDISP
        rep #$20
        lda #(`aOpeningCreditsPage6Tilemap)<<8
        sta lR19+1
        lda #<>aOpeningCreditsPage6Tilemap
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        jsr rsSetUpOpeningCreditsScreen
        lda #(`aOpeningCreditsVScrollHDMAInfo6)<<8
        sta lR44+1
        lda #<>aOpeningCreditsVScrollHDMAInfo6
        sta lR44
        jsl rlHDMAEngineCreateEntry
        lda #(`aOpeningCreditsHScrollHDMAInfo4)<<8
        sta lR44+1
        lda #<>aOpeningCreditsHScrollHDMAInfo4
        sta lR44
        jsl rlHDMAEngineCreateEntry
        plp
        rtl

        .databank 0

      aOpeningCreditsPage6Tilemap .structDecompressionDMAEntry gcOpeningCreditsPage6, $0700, $5800 ; 8D/AC6B

      rlShowOpeningCreditsPage7 ; 8D/AC73

        .al
        .xl
        .autsiz
        .databank ?

        php
        sep #$20
        lda #$80
        sta $2100,b
        sta bBufferINIDISP
        rep #$20
        lda #(`aOpeningCreditsPage7Tilemap)<<8
        sta lR19+1
        lda #<>aOpeningCreditsPage7Tilemap
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        jsr rsSetUpOpeningCreditsScreen
        plp
        rtl

        .databank 0

      aOpeningCreditsPage7Tilemap .structDecompressionDMAEntry gcOpeningCreditsPage7, $0700, $5800 ; 8D/AC92

      rlShowOpeningCreditsPage8 ; 8D/AC9A

        .al
        .xl
        .autsiz
        .databank ?

        php
        sep #$20
        lda #$80
        sta $2100,b
        sta bBufferINIDISP
        rep #$20
        lda #(`aOpeningCreditsPage8Tilemap)<<8
        sta lR19+1
        lda #<>aOpeningCreditsPage8Tilemap
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        jsr rsSetUpOpeningCreditsScreen
        plp
        rtl

        .databank 0

      aOpeningCreditsPage8Tilemap .structDecompressionDMAEntry gcOpeningCreditsPage8, $0700, $5800 ; 8D/ACB9

      rsSetUpOpeningCreditsScreen ; 8D/ACC1

        .al
        .xl
        .autsiz
        .databank ?

        stz wGameStateRoutine1,b
        jsl rlResetHDMAEngine
        jsl rlResetIRQEngine
        lda #$0000
        sta wR1
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
        lda #(`aOpeningCreditsFont)<<8
        sta lR19+1
        lda #<>aOpeningCreditsFont
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        lda #$0004
        sta wScreenFadingProcInput,b
        lda #(`procFadeInByScreenFadingTimer)<<8
        sta lR44+1
        lda #<>procFadeInByScreenFadingTimer
        sta lR44
        jsl rlProcEngineCreateProc
        sep #$20
        lda #$04
        sta bBufferTM
        lda #$00
        sta bBufferTS
        lda #$00
        sta bBufferCGWSEL
        lda #$00
        sta bBufferCGADSUB
        lda bBufferBG3SC
        and #$FC
        sta bBufferBG3SC
        rep #$20
        lda #$0000
        sta wBufferBG3HOFS
        sta wBufferBG3VOFS
        ldx #$00FE
        lda #$0000

        _AD3B
        sta $7E8A88,x
        dec x
        dec x
        bpl _AD3B
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8A88, $0100, $80, $B700

        ldx #$001E

        _AD53
        lda aOpeningCreditsPalette,x
        sta aBGPaletteBuffer,b,x
        dec x
        dec x
        bpl _AD53
        jsl rlEnableVBlank
        sep #$20
        lda #$00
        sta bBufferINIDISP
        rep #$20
        rts

        .databank 0

      aOpeningCreditsFont .structDecompressionDMAEntry gcOpeningCreditsFont, $3000, $4000 ; 8D/AD6B

    .endsection OpeningCreditsSection


    .section OpeningCreditsHScrollHDMASection

      aOpeningCreditsHScrollHDMAInfo1 .dstruct structHDMADirectEntryInfo, rlUnknown8BA0B4, rlUnknown8BA0B4, aUnknown8BA0B5, aUnknown8BA0B7, PPU_REG_BASE + $11, $02 ; 8B/A088
      aOpeningCreditsHScrollHDMAInfo2 .dstruct structHDMADirectEntryInfo, rlUnknown8BA0B4, rlUnknown8BA0B4, aUnknown8BA0B5, aUnknown8BA27C, PPU_REG_BASE + $11, $02 ; 8B/A093
      aOpeningCreditsHScrollHDMAInfo3 .dstruct structHDMADirectEntryInfo, rlUnknown8BA0B4, rlUnknown8BA0B4, aUnknown8BA0B5, aUnknown8BA441, PPU_REG_BASE + $11, $02 ; 8B/A09E
      aOpeningCreditsHScrollHDMAInfo4 .dstruct structHDMADirectEntryInfo, rlUnknown8BA0B4, rlUnknown8BA0B4, aUnknown8BA0B5, aUnknown8BA606, PPU_REG_BASE + $11, $02 ; 8B/A0A9

    .endsection OpeningCreditsHScrollHDMASection
