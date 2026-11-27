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

      aOpeningCreditsHScrollHDMAInfo1 .dstruct structHDMADirectEntryInfo, rlOpeningCreditsHScrollHDMANoOp, rlOpeningCreditsHScrollHDMANoOp, aOpeningCreditsHScrollHDMACode, aOpeningCreditsHScrollTable1, PPU_REG_BASE + $11, $02 ; 8B/A088
      aOpeningCreditsHScrollHDMAInfo2 .dstruct structHDMADirectEntryInfo, rlOpeningCreditsHScrollHDMANoOp, rlOpeningCreditsHScrollHDMANoOp, aOpeningCreditsHScrollHDMACode, aOpeningCreditsHScrollTable2, PPU_REG_BASE + $11, $02 ; 8B/A093
      aOpeningCreditsHScrollHDMAInfo3 .dstruct structHDMADirectEntryInfo, rlOpeningCreditsHScrollHDMANoOp, rlOpeningCreditsHScrollHDMANoOp, aOpeningCreditsHScrollHDMACode, aOpeningCreditsHScrollTable3, PPU_REG_BASE + $11, $02 ; 8B/A09E
      aOpeningCreditsHScrollHDMAInfo4 .dstruct structHDMADirectEntryInfo, rlOpeningCreditsHScrollHDMANoOp, rlOpeningCreditsHScrollHDMANoOp, aOpeningCreditsHScrollHDMACode, aOpeningCreditsHScrollTable4, PPU_REG_BASE + $11, $02 ; 8B/A0A9

    .endsection OpeningCreditsHScrollHDMASection


    .section OpeningCreditsVScrollHDMANoOpSection

      .al
      .xl

      rlOpeningCreditsVScrollHDMANoOp ; 8D/D041

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        ; Init and cycle of the opening credits' vertical scroll HDMA: nothing (the tables are fixed).

        rtl

        .databank 0

        ; 8D/D042


      aOpeningCreditsVScrollHDMACode ; 8D/D042

        HDMA_HALT

      aOpeningCreditsVScrollTable1 ; 8D/D044

        .byte $C0
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .byte $C0
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $00FB
        .word $00FB, $00FB, $00FB, $00FB, $00FB, $00FB, $00FB, $00FB
        .word $00FB, $00FB, $00FB, $00FB, $00FB, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .byte $C0
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .byte $A0
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .byte 0

      aOpeningCreditsVScrollTable2 ; 8D/D209

        .byte $C0
        .word $00EB, $00EB, $00EB, $00EB, $00EB, $00EB, $00EB, $00EB
        .word $00EB, $00EB, $00EB, $00EB, $00EB, $00EB, $00EB, $00EB
        .word $00EB, $00EB, $00EB, $00EB, $00EB, $00EB, $00EB, $00EB
        .word $00EB, $00EB, $00EB, $00EB, $00EB, $00EB, $00EB, $00EB
        .word $00EB, $00EB, $00EB, $00EB, $00F1, $00F1, $00F1, $00F1
        .word $00F1, $00F1, $00F1, $00F1, $00F1, $00F1, $00F1, $00F1
        .word $00F1, $00F1, $00F1, $00F2, $00F2, $00F2, $00F2, $00F2
        .word $00F2, $00F2, $00F2, $00F2, $00F2, $00F8, $00F8, $00F8
        .byte $C0
        .word $00F8, $00F8, $00F8, $00F8, $00F8, $00F8, $00FC, $00FC
        .word $00FC, $00FC, $00FC, $00FC, $00FC, $00FC, $00FC, $00FC
        .word $00FC, $00FC, $00FC, $00FC, $00FC, $00FC, $00FC, $00FC
        .word $00FC, $00FC, $00FC, $00FC, $00FC, $00FC, $00FC, $00FC
        .word $00FC, $00FC, $00FC, $00FC, $00FC, $00FC, $00FC, $00FC
        .word $00FC, $00FC, $00FC, $00FC, $00FC, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .byte $C0
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0004, $0004, $0004, $0004, $0004, $0004, $0004, $0004
        .word $0004, $0004, $0004, $0004, $0004, $0004, $0004, $0004
        .word $0004, $0015, $0015, $0015, $0015, $0015, $0015, $0015
        .word $0015, $0015, $0015, $0015, $0015, $0015, $0015, $0015
        .word $0015, $0015, $0015, $0015, $0015, $0015, $0015, $0015
        .word $0015, $0015, $0015, $0015, $0015, $0015, $0015, $0015
        .byte $A0
        .word $0015, $0015, $0015, $0015, $0015, $0015, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .byte 0

      aOpeningCreditsVScrollTable3 ; 8D/D3CE

        .byte $C0
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $0000, $0000, $0000, $00ED, $00ED, $00ED, $00ED
        .word $00ED, $00ED, $00ED, $00ED, $00ED, $00ED, $00ED, $00ED
        .word $00ED, $00ED, $00ED, $00ED, $00ED, $00ED, $00ED, $00ED
        .byte $C0
        .word $00ED, $00ED, $00ED, $00ED, $00ED, $00ED, $00ED, $00ED
        .word $00ED, $00ED, $00ED, $00ED, $00ED, $00ED, $00ED, $00ED
        .word $00ED, $00ED, $00ED, $00ED, $00ED, $00ED, $00ED, $00ED
        .word $00ED, $00ED, $00ED, $00ED, $00F3, $00F3, $00F3, $00F3
        .word $00F3, $00F3, $00F3, $00F3, $00F9, $00F9, $00F9, $00F9
        .word $00F9, $00F9, $00F9, $00F9, $00F9, $00F9, $00F9, $00F9
        .word $00FC, $00FC, $00FC, $00FC, $00FC, $00FC, $00FC, $00FC
        .word $00FC, $00FC, $00FC, $0002, $0002, $0002, $0002, $0002
        .byte $C0
        .word $0002, $0002, $0002, $0008, $0008, $0008, $0008, $0008
        .word $0008, $0008, $0008, $0008, $0008, $0008, $0008, $0008
        .word $0008, $0008, $000B, $000B, $000B, $000B, $000B, $000B
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .byte $A0
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .byte 0

      aOpeningCreditsVScrollTable4 ; 8D/D593

        .byte $C0
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $00F9
        .byte $C0
        .word $00F9, $00F9, $00F9, $00F9, $00F9, $00F9, $00F9, $00F9
        .word $00F9, $00F9, $00F9, $00F9, $00F9, $00F9, $00F9, $00F9
        .word $00F8, $00F6, $00F6, $00F6, $00F6, $00F6, $00F6, $00F6
        .word $00F6, $00F6, $00F6, $00F6, $00F6, $00F6, $00F6, $00F7
        .word $00FB, $00FB, $00FB, $00FB, $00FB, $00FB, $00FB, $00FB
        .word $00FB, $00FB, $00FB, $00FB, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0001, $0001, $0001, $0001, $0001, $0001, $0001
        .byte $C0
        .word $0001, $0001, $0001, $0001, $0001, $0001, $0007, $0007
        .word $0007, $0007, $0007, $0007, $0007, $0007, $0007, $0007
        .word $0007, $0007, $0007, $0007, $0007, $0007, $0007, $0007
        .word $0007, $0007, $0007, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .byte $A0
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .byte 0

      aOpeningCreditsVScrollTable5 ; 8D/D758

        .byte $C0
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $00F4, $00F4, $00F4, $00F4
        .word $00F3, $00F3, $00F3, $00F3, $00F5, $00F5, $00F5, $00F5
        .word $00F0, $00F0, $00F0, $00F3, $00F3, $00F3, $00F3, $00F3
        .word $00F3, $00F3, $00F2, $00F3, $00F3, $00F3, $00F3, $00F3
        .word $00F3, $00F3, $00F3, $00F3, $00F3, $00F3, $00F4, $00F4
        .byte $C0
        .word $00F4, $00F4, $00F4, $00F4, $00F4, $00F4, $00F4, $00F4
        .word $00F4, $00F4, $00F4, $00F4, $00FA, $00FA, $00FA, $00FA
        .word $00FA, $00FA, $00FA, $00FA, $00FA, $00FA, $00FE, $00FE
        .word $00FE, $00FE, $00FE, $00FE, $00FE, $00FE, $00FE, $00FD
        .word $00FD, $00FD, $00FD, $00FD, $00FD, $00FD, $00FD, $00FD
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $0005, $0005, $0005, $0005, $0005, $0005, $0005, $0005
        .byte $C0
        .word $0005, $0005, $0005, $0005, $000B, $000B, $000B, $000B
        .word $000B, $000B, $000B, $000B, $0011, $0011, $0011, $0011
        .word $0011, $0011, $0011, $0011, $0011, $0011, $0011, $0017
        .word $0017, $0017, $0017, $0017, $0017, $0017, $0017, $0017
        .word $0017, $0017, $0017, $0017, $0017, $0017, $0017, $0017
        .word $0017, $0017, $0017, $0017, $000B, $000B, $000B, $000B
        .word $000B, $000B, $000B, $000B, $000B, $000B, $000B, $000B
        .word $000B, $000B, $0000, $0000, $0000, $0000, $0000, $0000
        .byte $A0
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .byte 0

      aOpeningCreditsVScrollTable6 ; 8D/D91D

        .byte $C0
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .byte $C0
        .word $00EE, $00EE, $00EE, $00EE, $00EE, $00EE, $00EE, $00EE
        .word $00EE, $00EE, $00EE, $00EE, $00EE, $00EE, $00EE, $00EE
        .word $00EE, $00EE, $00EE, $00EE, $00EE, $00EE, $00EE, $00EE
        .word $00EE, $00F4, $00F4, $00F4, $00F4, $00F4, $00F4, $00F4
        .word $00F4, $00F4, $00F4, $00FA, $00FA, $00FA, $00FA, $00FA
        .word $00FA, $00FA, $00FA, $00FA, $00FA, $00FA, $00FA, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0006, $0006, $0006, $0006, $0006, $0006, $0006, $0006
        .byte $C0
        .word $000C, $000C, $000C, $000C, $000C, $000C, $000C, $000C
        .word $000C, $000C, $000C, $000C, $000C, $0012, $0012, $0012
        .word $0012, $0012, $0012, $0012, $0012, $0012, $0012, $001C
        .word $001C, $001C, $001C, $001C, $001C, $001C, $001C, $001C
        .word $001C, $001C, $001C, $001C, $001C, $001C, $001C, $001C
        .word $001C, $001C, $001C, $001C, $001C, $001C, $001C, $001C
        .word $001C, $001C, $001C, $001C, $001C, $001C, $001C, $001C
        .word $001C, $001C, $001C, $001C, $001C, $001C, $001C, $001C
        .byte $A0
        .word $001C, $001C, $001C, $001C, $001C, $001C, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .byte 0

      aOpeningCreditsVScrollTable7 ; 8D/DAE2

        .byte $C0
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .byte $C0
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .byte $C0
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .byte $A0
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .word $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA, $00EA
        .byte 0

    .endsection OpeningCreditsVScrollHDMANoOpSection


    .section OpeningCreditsHScrollHDMANoOpSection

      .al
      .xl

      rlOpeningCreditsHScrollHDMANoOp ; 8B/A0B4

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        ; Init and cycle of the opening credits' horizontal scroll HDMA: nothing.

        rtl

        .databank 0

        ; 8B/A0B5


      aOpeningCreditsHScrollHDMACode ; 8B/A0B5

        HDMA_HALT

      aOpeningCreditsHScrollTable1 ; 8B/A0B7

        .byte $C0
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .byte $C0
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $00F7, $00F7, $00F7, $00F7, $10F7, $00F7
        .word $00F7, $00F7, $00F7, $00F7, $00F7, $00F7, $00F7, $00F7
        .word $00F7, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0002, $0002, $0002, $0002, $0002
        .word $0002, $0002, $0002, $0002, $0002, $0002, $0005, $0005
        .word $0005, $0005, $0005, $0005, $0005, $0005, $0005, $0005
        .word $0005, $0005, $0005, $0000, $0000, $0000, $1000, $0000
        .byte $C0
        .word $0000, $0000, $0000, $0000, $0000, $00F5, $00F5, $00F5
        .word $00F5, $00F5, $00F5, $00F5, $00F5, $00F5, $00F5, $00F5
        .word $00F5, $0000, $0000, $0003, $0003, $0003, $0003, $0003
        .word $0003, $0003, $0003, $0003, $0003, $0003, $0003, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .byte $A0
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .byte 0

      aOpeningCreditsHScrollTable2 ; 8B/A27C

        .byte $C0
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .byte $C0
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00F0
        .word $00F0, $00F0, $00F0, $00F0, $00F0, $00F0, $00F0, $00F0
        .word $00F0, $00F0, $00F0, $00F0, $00FD, $00FD, $00FD, $00FD
        .word $00FD, $00FD, $00FD, $00FD, $00FD, $00FD, $00FD, $0004
        .word $0004, $0004, $0004, $0004, $0004, $0004, $0004, $0004
        .byte $C0
        .word $0004, $0004, $0004, $0004, $0004, $00FD, $00FD, $00FD
        .word $00FD, $00FD, $00FD, $00FD, $00FD, $00FD, $00FD, $00FD
        .word $00FD, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .byte $A0
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .byte 0

      aOpeningCreditsHScrollTable3 ; 8B/A441

        .byte $C0
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .byte $C0
        .word $0000, $0000, $0000, $0009, $0009, $0009, $0009, $0009
        .word $0009, $0009, $0009, $0009, $0009, $0006, $0006, $0006
        .word $0006, $0006, $0006, $0006, $0006, $0000, $0000, $0000
        .word $00FC, $00FC, $00FC, $00FC, $00FC, $00FC, $00FC, $00FC
        .word $00FC, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $00FC, $00FC, $10FC, $00FC, $10FC, $00FC, $00FC
        .word $00FC, $00FC, $00FC, $00FC, $00FC, $00FC, $00FC, $00FC
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .byte $C0
        .word $00FF, $00FF, $00FF, $0003, $0003, $0003, $0003, $0003
        .word $0003, $0003, $0003, $0003, $0003, $00FD, $00FD, $00FD
        .word $00FD, $00FD, $00FD, $00FD, $00FD, $00FD, $00FD, $0001
        .word $0001, $0001, $0001, $0001, $0001, $0001, $0001, $0001
        .word $0001, $0001, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .byte $A0
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .byte 0

      aOpeningCreditsHScrollTable4 ; 8B/A606

        .byte $C0
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .byte $C0
        .word $00FE, $00FE, $00FE, $00FE, $00FE, $00FE, $00FE, $00FE
        .word $00FE, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $00FC, $00FC, $00FC, $00FC, $00FC, $00FC, $00FC
        .word $00FC, $00FC, $00FD, $00FD, $00FD, $00FD, $00FD, $00FD
        .word $00FD, $00FD, $00FD, $00FD, $00FC, $00FC, $00FC, $00FC
        .word $00FC, $00FC, $00FC, $00FC, $00FC, $00FC, $0004, $0004
        .word $0004, $0004, $0004, $0004, $0004, $0004, $0004, $0004
        .word $0004, $0004, $0004, $0004, $0004, $0004, $0004, $0004
        .byte $C0
        .word $0004, $0004, $0004, $0004, $0004, $0004, $0004, $0004
        .word $0004, $0004, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .byte $A0
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .byte 0

    .endsection OpeningCreditsHScrollHDMANoOpSection


