; The battle scene's visual effects: palette, spell/polygon/gradient/mosaic
; window, HDMA, BG scroll/shake/animation, and sprite effects started by the
; script commands and by spells.


    .section Unsorted959C64Section

      .al
      .xl

      rsBattleSceneStartKnockbackFromStrike ; 95/9C64

        .al
        .xl
        .autsiz
        .databank ?

        php
        lda bBattleSceneStrikeFlags,b
        bit #$0080
        beq _9C90
        lda bBattleSceneRoundState,b
        bit #$0020
        bne _9C90
        lda bBattleSceneAttackerSide,b
        bit #$0080
        beq _9C80
        clc
        bra _9C81


        _9C80
        sec

        _9C81
        jsr rsBattleSceneInitHitSparks
        sep #$20
        lda bBattleSceneRoundState,b
        ora #$20
        sta bBattleSceneRoundState,b
        rep #$20

        _9C90
        plp
        rts

        .databank 0

        ; 95/9C92

      rsBattleSceneInitHitSparks ; 95/9C92

        .al
        .xl
        .autsiz
        .databank ?

        bcs _9CBA
        sep #$20
        lda #$20
        sta $7FE191
        lda bBattleAnimationStateFlags,b
        and #$FE
        sta bBattleAnimationStateFlags,b
        lda bBattleAnimationAttributes,b
        bit #$08
        bne _9CAF
        lda #$81
        bra _9CB1


        _9CAF
        lda #$C1

        _9CB1
        sta $7FE192
        rep #$20
        clc
        bra _9CDE


        _9CBA
        sep #$20
        lda #$20
        sta $7FE193
        lda bBattleAnimation2StateFlags,b
        and #$FE
        sta bBattleAnimation2StateFlags,b
        lda bBattleAnimation2Attributes,b
        bit #$08
        bne _9CD5
        lda #$81
        bra _9CD7


        _9CD5
        lda #$C1

        _9CD7
        sta $7FE194
        rep #$20
        sec

        _9CDE
        rts

        .databank 0

        ; 95/9CDF

      rlBattleSceneStartDamageFlash ; 95/9CDF

        .al
        .xl
        .autsiz
        .databank ?

        ; Carry clear combatant 1, set combatant 2: 25 frames ($7FE195 or $7FE196).

        bcs _9CED
        sep #$20
        lda #$19
        sta bBattleSceneDamageFlash1
        rep #$20
        bra _9CF7


        _9CED
        sep #$20
        lda #$19
        sta bBattleSceneDamageFlash2
        rep #$20

        _9CF7
        rtl

        .databank 0

        ; 95/9CF8

      rsBattleSceneStepDamageFlash ; 95/9CF8

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda bBattleSceneDamageFlash1
        bne _9D03
        jml _9DAA


        _9D03
        and #$00FF
        beq _9D23
        dec a
        sep #$20
        sta bBattleSceneDamageFlash1
        rep #$20
        asl a
        tax
        lda aBattleSceneDamageFlashTable1,x
        sta $2181,b
        sep #$20
        lda #$01
        sta $2183,b
        bra _9D43


        _9D23
        .al
        lda bBattleSceneDamageFlash2
        and #$00FF
        dec a
        sep #$20
        sta bBattleSceneDamageFlash2
        rep #$20
        asl a
        tax
        lda aBattleSceneDamageFlashTable2,x
        sta $2181,b
        sep #$20
        lda #$01
        sta $2183,b

        _9D43
        ldx #$0000

        _9D46
        lda $2180,b
        sta $0282,b,x
        lda $2180,b
        sta $0283,b,x
        lda $2180,b
        sta $02A2,b,x
        lda $2180,b
        sta $02A3,b,x
        lda $2180,b
        sta $02C2,b,x
        lda $2180,b
        sta $02C3,b,x
        lda $2180,b
        sta $02E2,b,x
        lda $2180,b
        sta $02E3,b,x
        inc x
        inc x
        cpx #$0012
        bcc _9D46

        _9D7D
        lda $2180,b
        sta $0282,b,x
        lda $2180,b
        sta $0283,b,x
        lda $2180,b
        sta $02A2,b,x
        lda $2180,b
        sta $02A3,b,x
        lda $2180,b
        sta $02C2,b,x
        lda $2180,b
        sta $02C3,b,x
        inc x
        inc x
        cpx #$001E
        bcc _9D7D
        rep #$20

        _9DAA
        plx
        rts

        .databank 0

        ; 95/9DAC

    .endsection Unsorted959C64Section


    .section Unsorted959DACSection

      .al
      .xl

      rlBattleSceneDarkenColorsStep ; 95/9DAC

        .al
        .xl
        .autsiz
        .databank ?

        ; A = first color, Y = count: takes one step off each nonzero channel of those colors of aBGPaletteBuffer. Carry set when they are all black.

        pha
        phx
        phy
        sty wR0
        asl a
        tax
        phx

        _9DB4
        lda aBGPaletteBuffer,b,x
        bit #$001F
        beq _9DE3
        bit #$03E0
        beq _9DD2
        bit #$7C00
        beq _9DCC
        sec
        sbc #$0421
        bra _9E02


        _9DCC
        sec
        sbc #$0021
        bra _9E02


        _9DD2
        bit #$7C00
        beq _9DDD
        sec
        sbc #$0401
        bra _9E02


        _9DDD
        sec
        sbc #$0001
        bra _9E02


        _9DE3
        bit #$03E0
        beq _9DF9
        bit #$7C00
        beq _9DF3
        sec
        sbc #$0420
        bra _9E02


        _9DF3
        sec
        sbc #$0020
        bra _9E02


        _9DF9
        bit #$7C00
        beq _9E02
        sec
        sbc #$0400

        _9E02
        sta aBGPaletteBuffer,b,x
        inc x
        inc x
        dec y
        bne _9DB4
        plx
        ldy #$0000

        _9E0E
        lda aBGPaletteBuffer,b,x
        bne _9E1D
        inc x
        inc x
        inc y
        cpy wR0
        bcc _9E0E
        sec
        bra _9E1E


        _9E1D
        clc

        _9E1E
        ply
        plx
        pla
        rtl

        .databank 0

        ; 95/9E22

    .endsection Unsorted959DACSection


    .section Unsorted959E22Section

      .al
      .xl

      rlBattleSceneBrightenColorsStep ; 95/9E22

        .al
        .xl
        .autsiz
        .databank ?

        ; A = first color, Y = count: adds one step to each channel below 31. Carry set when they are all white.

        pha
        phx
        phy
        sty wR0
        asl a
        tax
        phx

        _9E2A
        lda aBGPaletteBuffer,b,x
        inc a
        bit #$001F
        bne _9E34
        dec a

        _9E34
        clc
        adc #$0020
        bit #$03E0
        bne _9E41
        sec
        sbc #$0020

        _9E41
        clc
        adc #$0400
        bit #$7C00
        bne _9E4E
        sec
        sbc #$0400

        _9E4E
        sta aBGPaletteBuffer,b,x
        inc x
        inc x
        dec y
        bne _9E2A
        plx
        ldy #$0000

        _9E5A
        lda aBGPaletteBuffer,b,x
        cmp #$7FFF
        bne _9E6C
        inc x
        inc x
        inc y
        cpy wR0
        bcc _9E5A
        sec
        bra _9E6D


        _9E6C
        clc

        _9E6D
        ply
        plx
        pla
        rtl

        .databank 0

        ; 95/9E71

    .endsection Unsorted959E22Section


    .section Unreferenced959E71Section

      .al
      .xl

      rlBattleSceneBrightenColorsToward ; 95/9E71

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        phy
        asl a
        tax
        tya
        asl a
        sta wR0
        ldy #$0000

        _9E7D
        lda aBGPaletteBuffer,b,x
        pha
        and #$001F
        pha
        lda [lR18],y
        and #$001F
        cmp #1,s
        beq _9E98
        bcc _9E98
        pla
        pla
        clc
        adc #$0001
        bra _9E9A


        _9E98
        pla
        pla

        _9E9A
        pha
        and #$03E0
        pha
        lda [lR18],y
        and #$03E0
        cmp #1,s
        beq _9EB2
        bcc _9EB2
        pla
        pla
        clc
        adc #$0020
        bra _9EB4


        _9EB2
        pla
        pla

        _9EB4
        pha
        and #$7C00
        pha
        lda [lR18],y
        and #$7C00
        cmp #1,s
        beq _9ECC
        bcc _9ECC
        pla
        pla
        clc
        adc #$0400
        bra _9ECE


        _9ECC
        pla
        pla

        _9ECE
        sta aBGPaletteBuffer,b,x
        inc x
        inc x
        inc y
        inc y
        cpy wR0
        bcc _9E7D
        ply
        plx
        pla
        rtl

        .databank 0

        ; 95/9EDD

      rlBattleSceneDarkenColorsToward ; 95/9EDD

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        phy
        asl a
        tax
        tya
        asl a
        sta wR0
        ldy #$0000

        _9EE9
        lda aBGPaletteBuffer,b,x
        pha
        and #$001F
        pha
        lda [lR18],y
        and #$001F
        cmp #1,s
        bcs _9F02
        pla
        pla
        sec
        sbc #$0001
        bra _9F04


        _9F02
        pla
        pla

        _9F04
        pha
        and #$03E0
        pha
        lda [lR18],y
        and #$03E0
        cmp #1,s
        bcs _9F1A
        pla
        pla
        sec
        sbc #$0020
        bra _9F1C


        _9F1A
        pla
        pla

        _9F1C
        pha
        and #$7C00
        pha
        lda [lR18],y
        and #$7C00
        cmp #1,s
        bcs _9F32
        pla
        pla
        sec
        sbc #$0400
        bra _9F34


        _9F32
        pla
        pla

        _9F34
        sta aBGPaletteBuffer,b,x
        inc x
        inc x
        inc y
        inc y
        cpy wR0
        bcc _9EE9
        ply
        plx
        pla
        rtl

        .databank 0

        ; 95/9F43

    .endsection Unreferenced959E71Section
    .section Unsorted959F43Section

      .al
      .xl

      rlBattleSceneStepColorsToward ; 95/9F43

        .al
        .xl
        .autsiz
        .databank ?

        ; A = first color, Y = count, lR18 = target colors: moves each channel one step toward the target's. Carry set when they all match.

        pha
        phx
        phy
        asl a
        tax
        phx
        tya
        asl a
        sta wR0
        ldy #$0000

        _9F50
        lda aBGPaletteBuffer,b,x
        pha
        and #$001F
        pha
        lda [lR18],y
        and #$001F
        cmp #1,s
        beq _9F73
        bcs _9F6B
        pla
        pla
        sec
        sbc #$0001
        bra _9F75


        _9F6B
        pla
        pla
        clc
        adc #$0001
        bra _9F75


        _9F73
        pla
        pla

        _9F75
        pha
        and #$03E0
        pha
        lda [lR18],y
        and #$03E0
        cmp #1,s
        beq _9F95
        bcs _9F8D
        pla
        pla
        sec
        sbc #$0020
        bra _9F97


        _9F8D
        pla
        pla
        clc
        adc #$0020
        bra _9F97


        _9F95
        pla
        pla

        _9F97
        pha
        and #$7C00
        pha
        lda [lR18],y
        and #$7C00
        cmp #1,s
        beq _9FB7
        bcs _9FAF
        pla
        pla
        sec
        sbc #$0400
        bra _9FB9


        _9FAF
        pla
        pla
        clc
        adc #$0400
        bra _9FB9


        _9FB7
        pla
        pla

        _9FB9
        sta aBGPaletteBuffer,b,x
        inc x
        inc x
        inc y
        inc y
        cpy wR0
        bcc _9F50
        plx
        ldy #$0000

        _9FC8
        lda aBGPaletteBuffer,b,x
        and #$7FFF
        pha
        lda [lR18],y
        and #$7FFF
        cmp #1,s
        bne _9FE4
        pla
        inc x
        inc x
        inc y
        inc y
        cpy wR0
        bcc _9FC8
        sec
        bra _9FE6


        _9FE4
        pla
        clc

        _9FE6
        ply
        plx
        pla
        rtl

        .databank 0

        ; 95/9FEA

    .endsection Unsorted959F43Section


    .section Unreferenced959FEASection

      .al
      .xl

      rlBattleSceneStepColorsTowardExact ; 95/9FEA

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        phy
        asl a
        tax
        phx
        tya
        asl a
        sta wR0
        ldy #$0000

        _9FF7
        lda aBGPaletteBuffer,b,x
        pha
        and #$001F
        pha
        lda [lR18],y
        and #$001F
        cmp #1,s
        beq _A01A
        bcs _A012
        pla
        pla
        sec
        sbc #$0001
        bra _A01C


        _A012
        pla
        pla
        clc
        adc #$0001
        bra _A01C


        _A01A
        pla
        pla

        _A01C
        pha
        and #$03E0
        pha
        lda [lR18],y
        and #$03E0
        cmp #1,s
        beq _A03C
        bcs _A034
        pla
        pla
        sec
        sbc #$0020
        bra _A03E


        _A034
        pla
        pla
        clc
        adc #$0020
        bra _A03E


        _A03C
        pla
        pla

        _A03E
        pha
        and #$7C00
        pha
        lda [lR18],y
        and #$7C00
        cmp #1,s
        beq _A05E
        bcs _A056
        pla
        pla
        sec
        sbc #$0400
        bra _A060


        _A056
        pla
        pla
        clc
        adc #$0400
        bra _A060


        _A05E
        pla
        pla

        _A060
        sta aBGPaletteBuffer,b,x
        inc x
        inc x
        inc y
        inc y
        cpy wR0
        bcc _9FF7
        plx
        ldy #$0000

        _A06F
        lda aBGPaletteBuffer,b,x
        cmp [lR18],y
        bne _A081
        inc x
        inc x
        inc y
        inc y
        cpy wR0
        bcc _A06F
        sec
        bra _A082


        _A081
        clc

        _A082
        ply
        plx
        pla
        rtl

        .databank 0

        ; 95/A086

    .endsection Unreferenced959FEASection
    .section Table95E69ESection

      .al
      .xl

      aBattleSceneWindowEffect2HDMAInfo .dstruct structHDMAIndirectEntryInfo, rlBattleSceneHDMAInitNoOp, rlBattleSceneHDMAOnCycleNoOp, aBattleSceneHDMAHaltCode, $7FED7A, PPU_REG_BASE + $26, $41, $7F ; 95/E69E

    .endsection Table95E69ESection


    .section Unsorted95E6AASection

      .al
      .xl

      rlBattleSceneHDMAInitNoOp ; 95/E6AA

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 95/E6AB

      rlBattleSceneHDMAOnCycleNoOp ; 95/E6AB

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 95/E6AC

    .endsection Unsorted95E6AASection


    .section Table95E6ACSection

      .al
      .xl

      aBattleSceneHDMAHaltCode ; 95/E6AC
        HDMA_HALT

      aBattleSceneWindowEffect2RightHDMAInfo .dstruct structHDMAIndirectEntryInfo, rlBattleSceneHDMAInitNoOp, rlBattleSceneHDMAOnCycleNoOp, aBattleSceneHDMAHaltCode, $7FED96, PPU_REG_BASE + $28, $41, $7F ; 95/E6AE

      aBattleSceneSpellWindowHDMAInfo1 .dstruct structHDMAIndirectEntryInfo, rlBattleSceneHDMAInitNoOp, rlBattleSceneHDMAOnCycleNoOp, aBattleSceneHDMAHaltCode, $7FE4EA, PPU_REG_BASE + $26, $41, $7F ; 95/E6BA

      aBattleSceneSpellWindowHDMAInfo2 .dstruct structHDMAIndirectEntryInfo, rlBattleSceneHDMAInitNoOp, rlBattleSceneHDMAOnCycleNoOp, aBattleSceneHDMAHaltCode, $7FE506, PPU_REG_BASE + $28, $41, $7F ; 95/E6C6

      aBattleSceneLetterboxHDMAInfo .dstruct structHDMAIndirectEntryInfo, rlBattleSceneHDMAInitNoOp, rlBattleSceneHDMAOnCycleNoOp, aBattleSceneHDMAHaltCode, $7FE1F6, PPU_REG_BASE + $0F, $43, $7F ; 95/E6D2

      aBattleSceneCOLDATAHDMAInfoUnused .dstruct structHDMAIndirectEntryInfo, rlBattleSceneHDMAInitNoOp, rlBattleSceneHDMAOnCycleNoOp, aBattleSceneHDMAHaltCode, $7FE39A, PPU_REG_BASE + $32, $42, $7F ; 95/E6DE

        ; Unreferenced.

      aBattleSceneHUDBannerHDMAInfo .dstruct structHDMAIndirectEntryInfo, rlBattleSceneHDMAInitNoOp, rlBattleSceneHDMAOnCycleNoOp, aBattleSceneHDMAHaltCode, $7FE3CA, PPU_REG_BASE + $32, $40, $7F ; 95/E6EA

      aBattleSceneBG2ScrollHDMAInfo .dstruct structHDMAIndirectEntryInfo, rlBattleSceneHDMAInitNoOp, rlBattleSceneHDMAOnCycleNoOp, aBattleSceneHDMAHaltCode, $7FF6B4, PPU_REG_BASE + $0D, $43, $7F ; 95/E6F6

      aBattleSceneMosaicWindowHDMAInfo .dstruct structHDMAIndirectEntryInfo, rlBattleSceneHDMAInitNoOp, rlBattleSceneHDMAOnCycleNoOp, aBattleSceneHDMAHaltCode, $7FE506, PPU_REG_BASE + $28, $41, $7F ; 95/E702

      aBattleSceneBG2VScrollHDMAInfo .dstruct structHDMAIndirectEntryInfo, rlBattleSceneHDMAInitNoOp, rlBattleSceneHDMAOnCycleNoOp, aBattleSceneHDMAHaltCode, $7FF6B4, PPU_REG_BASE + $0E, $42, $7F ; 95/E70E

      aBattleSceneBG2ScrollHDMA3Info .dstruct structHDMAIndirectEntryInfo, rlBattleSceneHDMAInitNoOp, rlBattleSceneHDMAOnCycleNoOp, aBattleSceneHDMAHaltCode, $7FF6B4, PPU_REG_BASE + $0F, $43, $7F ; 95/E71A

      aBattleSceneBG1ScrollHDMAInfo .dstruct structHDMAIndirectEntryInfo, rlBattleSceneHDMAInitNoOp, rlBattleSceneHDMAOnCycleNoOp, aBattleSceneHDMAHaltCode, $7FF6D4, PPU_REG_BASE + $0D, $43, $7F ; 95/E726

      aBattleSceneBackdropHDMAInfo1 .dstruct structHDMADirectEntryInfo, rlBattleSceneHDMAInitNoOp, rlBattleSceneHDMAOnCycleNoOp, aBattleSceneHDMAHaltCode, aBattleSceneKnockbackShake+429, PPU_REG_BASE + $21, $00 ; 95/E732

      aBattleSceneBackdropHDMAInfo2 .dstruct structHDMAIndirectEntryInfo, rlBattleSceneHDMAInitNoOp, rlBattleSceneHDMAOnCycleNoOp, aBattleSceneHDMAHaltCode, $7FF6B4, PPU_REG_BASE + $22, $42, $98 ; 95/E73D

      aBattleSceneAttackerColorHDMAInfo .dstruct structHDMADirectEntryInfo, rlBattleSceneHDMAInitNoOp, rlBattleSceneHDMAOnCycleNoOp, aBattleSceneHDMAHaltCode, $7FF6B4, PPU_REG_BASE + $26, $01 ; 95/E749

      aBattleSceneSolo2HDMAInfo1 .dstruct structHDMAIndirectEntryInfo, rlBattleSceneHDMAInitNoOp, rlBattleSceneHDMAOnCycleNoOp, aBattleSceneHDMAHaltCode, aBattleSceneHUDColors+448, PPU_REG_BASE + $21, $40, $99 ; 95/E754

      aBattleSceneSolo2HDMAInfo2 .dstruct structHDMAIndirectEntryInfo, rlBattleSceneHDMAInitNoOp, rlBattleSceneHDMAOnCycleNoOp, aBattleSceneHDMAHaltCode, aBattleSceneHUDColors+438, PPU_REG_BASE + $22, $42, $99 ; 95/E760

      aBattleSceneColorMathHDMAInfo .dstruct structHDMAIndirectEntryInfo, rlBattleSceneHDMAInitNoOp, rlBattleSceneHDMAOnCycleNoOp, aBattleSceneHDMAHaltCode, aBattleSceneSeaColumns+64, PPU_REG_BASE + $32, $40, $7F ; 95/E76C

      aBattleSceneBG2HShakeHDMAInfo .dstruct structHDMAIndirectEntryInfo, rlBattleSceneHDMAInitNoOp, rlBattleSceneHDMAOnCycleNoOp, aBattleSceneHDMAHaltCode, aBattleSceneHUDShakeOffsets+54, PPU_REG_BASE + $0F, $42, $7F ; 95/E778

      aBattleSceneTMHDMAInfoUnused .dstruct structHDMADirectEntryInfo, rlBattleSceneHDMAInitNoOp, rlBattleSceneHDMAOnCycleNoOp, aBattleSceneHDMAHaltCode, $7FD06B, PPU_REG_BASE + $2C, $01 ; 95/E784

        ; Unreferenced.

      aTitleIntroBG2WaveHDMAInfo .dstruct structHDMAIndirectEntryInfo, rlBattleSceneHDMAInitNoOp, rlBattleSceneHDMAOnCycleNoOp, aBattleSceneHDMAHaltCode, $7FD633, PPU_REG_BASE + $0F, $42, $7F ; 95/E78F

      aTitleIntroBG1WaveHDMAInfo .dstruct structHDMAIndirectEntryInfo, rlBattleSceneHDMAInitNoOp, rlBattleSceneHDMAOnCycleNoOp, aBattleSceneHDMAHaltCode, $7FD64C, PPU_REG_BASE + $0D, $42, $7F ; 95/E79B

      aTitleIntroScene7CurtainHDMAInfo .dstruct structHDMAIndirectEntryInfo, rlBattleSceneHDMAInitNoOp, rlBattleSceneHDMAOnCycleNoOp, aBattleSceneHDMAHaltCode, $7FD076, PPU_REG_BASE + $00, $40, $99 ; 95/E7A7


    .endsection Table95E6ACSection


    .section Unsorted96A532Section

      .al
      .xl

      rlBattleSceneUpdateSpellWindowEffects ; 96/A532

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0000
        jsl rlBattleSceneUpdateSpellWindowSlot
        ldx #$0024
        jsl rlBattleSceneUpdateSpellWindowSlot
        rtl

        .databank 0

        ; 96/A541

      rlBattleSceneUpdateSpellWindowSlot ; 96/A541

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda aBattleSceneSpellWindowSlots.wFlags,x
        bit #$0080
        bne _A559
        lda aBattleSceneSpellWindowSlots.wFlags,x
        bit #$0020
        bne _A55F
        jml _A6F1


        _A559
        jsr rsBattleSceneRunSpellWindowScript
        jsr rsBattleSceneStepWindowHorizontal

        _A55F
        sep #$20
        phb
        lda #$7F
        pha
        plb
        .databank $7F
        rep #$20
        cpx #$0000
        bne _A572
        ldy #$0000
        bra _A575


        _A572
        ldy #$001C

        _A575
        lda @l aBattleSceneSpellWindowSlots.wFlags,x
        bit #$0010
        beq _A59E
        lda @l aBattleSceneSpellWindowSlots.wX,x
        sep #$20
        sta $E4DE,b,y
        lda @l aUnit2DataBuffer._ROM.SkillGrowth,x
        sec
        sbc @l aUnit2DataBuffer._ROM.SpeedGrowth,x
        sta $E4DF,b,y
        lda @l aBattleSceneSpellWindowSlots.wAttr,x
        sta $E4E1,b,y
        rep #$20
        bra _A5C6


        _A59E
        lda @l aBattleSceneSpellWindowSlots.wX,x
        sec
        sbc @l wBattleSceneCameraX
        sep #$20
        sta $E4DE,b,y
        lda @l aUnit2DataBuffer._ROM.SkillGrowth,x
        sec
        sbc @l aUnit2DataBuffer._ROM.SpeedGrowth,x
        sec
        sbc @l wBattleSceneCameraY
        sta $E4DF,b,y
        lda @l aBattleSceneSpellWindowSlots.wAttr,x
        sta $E4E1,b,y
        rep #$20

        _A5C6
        plb
        .databank $7F
        lda @l aBattleSceneSpellWindowSlots.wFlags,x
        and #$000F
        cmp #$0009
        bne _A5D7
        jml _A6CE


        _A5D7
        cmp #$0001
        beq _A631
        cmp #$0002
        beq _A646
        cmp #$0003
        beq _A658
        cmp #$0004
        bne _A5EF
        jml _A671


        _A5EF
        cmp #$0005
        bne _A5F8
        jml _A688


        _A5F8
        cmp #$0006
        bne _A601
        jml _A69F


        _A601
        cmp #$0007
        bne _A60A
        jml _A6BB


        _A60A
        cmp #$000A
        bne _A613
        jml _A6E1


        _A613
        phx
        tyx
        lda @l aBattleSceneSpellWindowOAM.bAttr,x
        and #$00FF
        asl a
        sta @l $7FE4E2,x
        jsl rlBattleSceneGetSpellWindowBuffer
        lda #$0078
        jsl rlBattleSceneDrawWindowCircle
        plx
        jml _A6F1


        _A631
        phx
        tyx
        jsr rsBattleSceneCalcWindowHalfHeight
        jsl rlBattleSceneGetSpellWindowBuffer
        lda #$0078
        jsl rlBattleSceneDrawWindowCircle
        plx
        jml _A6F1


        _A646
        phx
        tyx
        jsr rsBattleSceneCalcWindowHalfHeight
        jsl rlBattleSceneGetSpellWindowBuffer
        jsl rlBattleSceneDrawWindowDiamond
        plx
        jml _A6F1


        _A658
        phx
        tyx
        lda @l aBattleSceneSpellWindowOAM.bAttr,x
        and #$00FF
        sta @l $7FE4E2,x
        jsl rlBattleSceneGetSpellWindowBuffer
        jsr rsBattleSceneDrawWindowCone8
        plx
        jml _A6F1


        _A671
        phx
        tyx
        lda @l aBattleSceneSpellWindowOAM.bAttr,x
        and #$00FF
        sta @l $7FE4E2,x
        jsl rlBattleSceneGetSpellWindowBuffer
        jsr rsBattleSceneDrawWindowCone8Inverted
        plx
        bra _A6F1


        _A688
        phx
        tyx
        lda @l aBattleSceneSpellWindowOAM.bAttr,x
        and #$00FF
        sta @l $7FE4E2,x
        jsl rlBattleSceneGetSpellWindowBuffer
        jsr rsBattleSceneDrawWindowCone4
        plx
        bra _A6F1


        _A69F
        phx
        tyx
        lda @l aBattleSceneSpellWindowOAM.bAttr,x
        and #$00FF
        asl a
        sta @l $7FE4E2,x
        jsl rlBattleSceneGetSpellWindowBuffer
        lda #$00C0
        jsl rlBattleSceneDrawWindowCircle
        plx
        bra _A6F1


        _A6BB
        phx
        tyx
        jsr rsBattleSceneCalcWindowHalfHeightA0
        jsl rlBattleSceneGetSpellWindowBuffer
        lda #$00C0
        jsl rlBattleSceneDrawWindowCircleWide
        plx
        bra _A6F1


        _A6CE
        phx
        tyx
        jsr rsBattleSceneCalcWindowHalfHeightA0
        jsl rlBattleSceneGetSpellWindowBuffer
        lda #$0070
        jsl rlBattleSceneDrawWindowOval
        plx
        bra _A6F1


        _A6E1
        phx
        tyx
        jsr rsBattleSceneCalcWindowHalfHeightA0
        jsl rlBattleSceneGetSpellWindowBuffer
        lda #$0070
        jsr rsBattleSceneDrawWindowCone2
        plx

        _A6F1
        jsr rsBattleSceneUpdateTrackedWindowPos
        ply
        plx
        rtl

        .databank 0

        ; 96/A6F7

      rlBattleSceneGetSpellWindowBuffer ; 96/A6F7

        .al
        .xl
        .autsiz
        .databank ?

        pha
        cpx #$0000
        bne _A709
        lda #$7F00
        sta lR18+1
        lda #$E51D
        sta lR18
        bra _A713


        _A709
        lda #$7F00
        sta lR18+1
        lda #$E6DD
        sta lR18

        _A713
        pla
        rtl

        .databank 0

        ; 96/A715

      rsBattleSceneRunSpellWindowScript ; 96/A715

        .al
        .xl
        .autsiz
        .databank ?

        phx
        sep #$20
        lda $7FEC2B,x
        beq _A727
        dec a
        sta $7FEC2B,x
        jml _A7DF


        _A727
        rep #$20

        _A729
        jsr rsBattleSceneReadSpellWindowWord
        xba
        and #$00FF
        cmp #$00FF
        bne _A73C
        jsr rsBattleSceneEndSpellWindowEffect
        jml _A7DF


        _A73C
        cmp #$00FD
        bne _A748
        jsr rsBattleSceneStopSpellWindowSlot
        jml _A7DF


        _A748
        cmp #$00FE
        bne _A754
        jsr rsBattleSceneSpellWindowLoop
        jml _A7DB


        _A754
        cmp #$00FC
        bne _A75E
        jsr rsBattleSceneSpellWindowSetAttackerPos
        bra _A7DB


        _A75E
        cmp #$00FB
        bne _A768
        jsr rsBattleSceneSpellWindowSetDefenderPos
        bra _A7DB


        _A768
        cmp #$00FA
        bne _A772
        jsr rsBattleSceneSpellWindowLaunchProjectile
        bra _A7DB


        _A772
        cmp #$00F9
        bne _A77C
        jsr rsBattleSceneSpellWindowWait1
        bra _A7DF


        _A77C
        cmp #$00F8
        bne _A786
        jsr rsBattleSceneSpellWindowSnapAttackerPos
        bra _A7DB


        _A786
        cmp #$00F7
        bne _A790
        jsr rsBattleSceneSpellWindowSnapDefenderPos
        bra _A7DB


        _A790
        cmp #$00F6
        bne _A79A
        jsr rsBattleSceneSpellWindowAimDefenderHit
        bra _A7DB


        _A79A
        cmp #$00F5
        bne _A7A4
        jsr rsBattleSceneSpellWindowCenterStage
        bra _A7DB


        _A7A4
        cmp #$00F4
        bne _A7AE
        jsr rsBattleSceneSpellWindowTrackTarget
        bra _A7DB


        _A7AE
        cmp #$00F3
        bne _A7B8
        jsr rsBattleSceneSpellWindowAimDefenderLow
        bra _A7DB


        _A7B8
        cmp #$00F2
        bne _A7C2
        jsr rsBattleSceneSpellWindowSetFixed4A00
        bra _A7DB


        _A7C2
        cmp #$00F1
        bne _A7CC
        jsr rsBattleSceneSpellWindowSetFixed4A10
        bra _A7DB


        _A7CC
        cmp #$00F0
        bne _A7D6
        jsr rsBattleSceneSpellWindowSetFixed3400
        bra _A7DB


        _A7D6
        jsr rsBattleSceneSpellWindowSetPoseAndDelay
        bra _A7DF


        _A7DB
        jml _A729


        _A7DF
        .as
        rep #$20
        plx
        rts

        .databank 0

        ; 96/A7E3

      rsBattleSceneEndSpellWindowEffect ; 96/A7E3

        .al
        .xl
        .autsiz
        .databank ?

        lda aBattleSceneSpellWindowSlots.wFlags,x
        bit #$0080
        beq _A81B
        jsr rsBattleSceneClearWindowRegs
        sep #$20
        lda aBattleSceneSpellWindowSlots.wFlags,x
        and #$7F
        sta aBattleSceneSpellWindowSlots.wFlags,x
        rep #$20
        lda #$0000
        sta aUnit2DataBuffer._Inventory.ItemCount,x
        sta $7FEC3A,x
        sta $7FEC3F,x
        sep #$20
        lda bBattleSceneScriptWaitCount
        beq _A815
        dec a

        _A815
        sta bBattleSceneScriptWaitCount
        rep #$20

        _A81B
        rts

        .databank 0

        ; 96/A81C

      rsBattleSceneStopSpellWindowSlot ; 96/A81C

        .al
        .xl
        .autsiz
        .databank ?

        lda aBattleSceneSpellWindowSlots.wFlags,x
        bit #$0080
        beq _A842
        sep #$20
        lda aBattleSceneSpellWindowSlots.wFlags,x
        and #$7F
        sta aBattleSceneSpellWindowSlots.wFlags,x
        rep #$20
        sep #$20
        lda bBattleSceneScriptWaitCount
        beq _A83C
        dec a

        _A83C
        sta bBattleSceneScriptWaitCount
        rep #$20

        _A842
        rts

        .databank 0

        ; 96/A843

      rsBattleSceneSpellWindowLoop ; 96/A843

        .al
        .xl
        .autsiz
        .databank ?

        lda aUnit2DataBuffer._ROM.Skills1,x
        and #$00FF
        beq _A865
        dec a
        sep #$20
        sta aUnit2DataBuffer._ROM.Skills1,x
        rep #$20
        bne _A875
        lda aBattleSceneSpellWindowSlots.wScriptOffset,x
        clc
        adc #$0002
        sta aBattleSceneSpellWindowSlots.wScriptOffset,x
        bra _A87D


        _A865
        jsr rsBattleSceneReadSpellWindowWord
        and #$00FF
        beq _A875
        sep #$20
        sta aUnit2DataBuffer._ROM.Skills1,x
        rep #$20

        _A875
        lda aUnit2DataBuffer._ROM.DefenseGrowth,x
        sta aBattleSceneSpellWindowSlots.wScriptOffset,x

        _A87D
        rts

        .databank 0

        ; 96/A87E

      rsBattleSceneSpellWindowSetAttackerPos ; 96/A87E

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phy
        ldy wBattleAnimationAttackerOffset,b
        lda wBattleAnimationXFixed,b,y
        sta aUnit2DataBuffer._ROM.StrengthGrowth,x
        lda wBattleAnimationX,b,y
        sta aBattleSceneSpellWindowSlots.wX,x
        lda wBattleAnimationYAnchor,b,y
        sta aBattleSceneSpellWindowSlots.wYAnchor,x
        lda wBattleAnimationYFixed,b,y
        clc
        adc #$3000
        sta aBattleSceneSpellWindowSlots.wYFixed,x
        lda aBattleSceneSpellWindowSlots.wScriptOffset,x
        clc
        adc #$0002
        sta aBattleSceneSpellWindowSlots.wScriptOffset,x
        ply
        pla
        rts

        .databank 0

        ; 96/A8B2

      rsBattleSceneSpellWindowSetDefenderPos ; 96/A8B2

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        phy
        ldy wBattleAnimationDefenderOffset,b
        lda wBattleAnimationXFixed,b,y
        sta aUnit2DataBuffer._ROM.StrengthGrowth,x
        lda wBattleAnimationX,b,y
        sta aBattleSceneSpellWindowSlots.wX,x
        lda wBattleAnimationYAnchor,b,y
        sta aBattleSceneSpellWindowSlots.wYAnchor,x
        lda wBattleAnimationYFixed,b,y
        clc
        adc #$1000
        sta aBattleSceneSpellWindowSlots.wYFixed,x
        jsl rlBattleSceneGetCombatantGap
        lda wR0
        cmp #$0100
        bcc _A903
        lda aBattleSceneSpellWindowSlots.wX
        cmp #$0180
        bcc _A8F1
        lda #$0180
        bra _A8FB


        _A8F1
        cmp #$0080
        bcs _A8FB
        lda #$0080
        bra _A8FB


        _A8FB
        sec
        sbc #$0080
        sta wBattleSceneCameraX

        _A903
        lda aBattleSceneSpellWindowSlots.wScriptOffset,x
        clc
        adc #$0002
        sta aBattleSceneSpellWindowSlots.wScriptOffset,x
        ply
        plx
        pla
        rts

        .databank 0

        ; 96/A913

      rsBattleSceneSpellWindowLaunchProjectile ; 96/A913

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        jsl rlBattleSceneLaunchWindowProjectile
        lda aBattleSceneSpellWindowSlots.wScriptOffset,x
        clc
        adc #$0002
        sta aBattleSceneSpellWindowSlots.wScriptOffset,x
        plx
        pla
        rts

        .databank 0

        ; 96/A928

      rsBattleSceneSpellWindowWait1 ; 96/A928

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        sep #$20
        lda #$01
        sta $7FEC2B,x
        rep #$20
        plx
        pla
        rts

        .databank 0

        ; 96/A937

      rsBattleSceneSpellWindowSnapAttackerPos ; 96/A937

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        phy
        ldy wBattleAnimationAttackerOffset,b
        lda wBattleAnimationXFixed,b,y
        sta aUnit2DataBuffer._ROM.StrengthGrowth,x
        lda wBattleAnimationX,b,y
        sta aBattleSceneSpellWindowSlots.wX,x
        lda wBattleAnimationYAnchor,b,y
        sta aBattleSceneSpellWindowSlots.wYAnchor,x
        lda #$0000
        sta aBattleSceneSpellWindowSlots.wYFixed,x
        lda aBattleSceneSpellWindowSlots.wScriptOffset,x
        clc
        adc #$0002
        sta aBattleSceneSpellWindowSlots.wScriptOffset,x
        ply
        plx
        pla
        rts

        .databank 0

        ; 96/A969

      rsBattleSceneSpellWindowSnapDefenderPos ; 96/A969

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        phy
        ldy wBattleAnimationDefenderOffset,b
        lda wBattleAnimationXFixed,b,y
        sta aUnit2DataBuffer._ROM.StrengthGrowth,x
        lda wBattleAnimationX,b,y
        sta aBattleSceneSpellWindowSlots.wX,x
        lda wBattleAnimationYAnchor,b,y
        sta aBattleSceneSpellWindowSlots.wYAnchor,x
        lda #$0000
        sta aBattleSceneSpellWindowSlots.wYFixed,x
        lda aBattleSceneSpellWindowSlots.wScriptOffset,x
        clc
        adc #$0002
        sta aBattleSceneSpellWindowSlots.wScriptOffset,x
        ply
        plx
        pla
        rts

        .databank 0

        ; 96/A99B

      rsBattleSceneSpellWindowAimDefenderHit ; 96/A99B

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        phy
        ldy wBattleAnimationDefenderOffset,b
        lda wBattleAnimationXFixed,b,y
        sta aUnit2DataBuffer._ROM.StrengthGrowth,x
        lda wBattleAnimationX,b,y
        sta aBattleSceneSpellWindowSlots.wX,x
        lda $7FEC65
        and #$00FF
        xba
        pha
        lda wBattleAnimationYAnchor,b,y
        sec
        sbc #1,s
        sta aBattleSceneSpellWindowSlots.wYAnchor,x
        pla
        phx
        ldx wBattleAnimationDefenderOffset,b
        jsl rlBattleAnimationGetHitHeight
        sec
        sbc #$0010
        xba
        plx
        sta aBattleSceneSpellWindowSlots.wYFixed,x
        jsl rlBattleSceneGetCombatantGap
        lda wR0
        cmp #$0100
        bcc _AA00
        lda aBattleSceneSpellWindowSlots.wX,x
        cmp #$0180
        bcc _A9EE
        lda #$0180
        bra _A9F8


        _A9EE
        cmp #$0080
        bcs _A9F8
        lda #$0080
        bra _A9F8


        _A9F8
        sec
        sbc #$0080
        sta wBattleSceneCameraX,x

        _AA00
        lda aBattleSceneSpellWindowSlots.wScriptOffset,x
        clc
        adc #$0002
        sta aBattleSceneSpellWindowSlots.wScriptOffset,x
        ply
        plx
        pla
        rts

        .databank 0

        ; 96/AA10

      rsBattleSceneSpellWindowCenterStage ; 96/AA10

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        phy
        ldy wBattleAnimationDefenderOffset,b
        lda #$0000
        sta aUnit2DataBuffer._ROM.StrengthGrowth,x
        lda wBattleSceneCameraX
        clc
        adc #$0080
        sta aBattleSceneSpellWindowSlots.wX,x
        lda $7FEC65
        and #$00FF
        xba
        pha
        lda wBattleAnimationYAnchor,b,y
        sec
        sbc #1,s
        sta aBattleSceneSpellWindowSlots.wYAnchor,x
        pla
        lda #$F400
        sta aBattleSceneSpellWindowSlots.wYFixed,x
        lda aBattleSceneSpellWindowSlots.wScriptOffset,x
        clc
        adc #$0002
        sta aBattleSceneSpellWindowSlots.wScriptOffset,x
        ply
        plx
        pla
        rts

        .databank 0

        ; 96/AA54

      rsBattleSceneSpellWindowTrackTarget ; 96/AA54

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        sep #$20
        lda aBattleSceneSpellWindowSlots.wFlags,x
        ora #$20
        sta aBattleSceneSpellWindowSlots.wFlags,x
        rep #$20
        lda #$0000
        sta aUnit2DataBuffer._ROM.StrengthGrowth,x
        lda aBattleSceneBGAnimSlots.wX
        and #$03FF
        sec
        sbc #$0100
        clc
        adc #$0100
        sta aBattleSceneSpellWindowSlots.wX,x
        lda aBattleSceneBGAnimSlots.wY
        clc
        adc #$0080
        and #$00FF
        xba
        sta aBattleSceneSpellWindowSlots.wYFixed,x
        lda #$0064
        sta aBattleSceneSpellWindowSlots.wYAnchor,x
        lda aBattleSceneSpellWindowSlots.wScriptOffset,x
        clc
        adc #$0002
        sta aBattleSceneSpellWindowSlots.wScriptOffset,x
        plx
        pla
        rts

        .databank 0

        ; 96/AAA4

      rsBattleSceneSpellWindowAimDefenderLow ; 96/AAA4

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        phy
        ldy wBattleAnimationDefenderOffset,b
        lda wBattleAnimationXFixed,b,y
        sta aUnit2DataBuffer._ROM.StrengthGrowth,x
        lda wBattleAnimationX,b,y
        sta aBattleSceneSpellWindowSlots.wX,x
        lda $7FEC65
        and #$00FF
        xba
        pha
        lda wBattleAnimationYAnchor,b,y
        sec
        sbc #1,s
        sta aBattleSceneSpellWindowSlots.wYAnchor,x
        pla
        lda #$F000
        sta aBattleSceneSpellWindowSlots.wYFixed,x
        jsl rlBattleSceneGetCombatantGap
        lda wR0
        cmp #$0100
        bcc _AAFE
        lda aBattleSceneSpellWindowSlots.wX,x
        cmp #$0180
        bcc _AAEC
        lda #$0180
        bra _AAF6


        _AAEC
        cmp #$0080
        bcs _AAF6
        lda #$0080
        bra _AAF6


        _AAF6
        sec
        sbc #$0080
        sta wBattleSceneCameraX,x

        _AAFE
        lda aBattleSceneSpellWindowSlots.wScriptOffset,x
        clc
        adc #$0002
        sta aBattleSceneSpellWindowSlots.wScriptOffset,x
        ply
        plx
        pla
        rts

        .databank 0

        ; 96/AB0E

      rsBattleSceneSpellWindowSetFixed4A00 ; 96/AB0E

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        sep #$20
        lda aBattleSceneSpellWindowSlots.wFlags,x
        and #$DF
        ora #$10
        sta aBattleSceneSpellWindowSlots.wFlags,x
        rep #$20
        lda #$0000
        sta aUnit2DataBuffer._ROM.StrengthGrowth,x
        lda #$0080
        sta aBattleSceneSpellWindowSlots.wX,x
        lda #$4A00
        sta aBattleSceneSpellWindowSlots.wYAnchor,x
        lda #$0000
        sta aBattleSceneSpellWindowSlots.wYFixed,x
        lda aBattleSceneSpellWindowSlots.wScriptOffset,x
        clc
        adc #$0002
        sta aBattleSceneSpellWindowSlots.wScriptOffset,x
        plx
        pla
        rts

        .databank 0

        ; 96/AB4B

      rsBattleSceneSpellWindowSetFixed4A10 ; 96/AB4B

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        sep #$20
        lda aBattleSceneSpellWindowSlots.wFlags,x
        and #$DF
        ora #$10
        sta aBattleSceneSpellWindowSlots.wFlags,x
        rep #$20
        lda #$0000
        sta aUnit2DataBuffer._ROM.StrengthGrowth,x
        lda #$0080
        sta aBattleSceneSpellWindowSlots.wX,x
        lda #$4A10
        sta aBattleSceneSpellWindowSlots.wYAnchor,x
        lda #$0000
        sta aBattleSceneSpellWindowSlots.wYFixed,x
        lda aBattleSceneSpellWindowSlots.wScriptOffset,x
        clc
        adc #$0002
        sta aBattleSceneSpellWindowSlots.wScriptOffset,x
        plx
        pla
        rts

        .databank 0

        ; 96/AB88

      rsBattleSceneSpellWindowSetFixed3400 ; 96/AB88

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        sep #$20
        lda aBattleSceneSpellWindowSlots.wFlags,x
        and #$DF
        ora #$10
        sta aBattleSceneSpellWindowSlots.wFlags,x
        rep #$20
        lda #$0000
        sta aUnit2DataBuffer._ROM.StrengthGrowth,x
        lda #$0080
        sta aBattleSceneSpellWindowSlots.wX,x
        lda #$3400
        sta aBattleSceneSpellWindowSlots.wYAnchor,x
        lda #$0000
        sta aBattleSceneSpellWindowSlots.wYFixed,x
        lda aBattleSceneSpellWindowSlots.wScriptOffset,x
        clc
        adc #$0002
        sta aBattleSceneSpellWindowSlots.wScriptOffset,x
        plx
        pla
        rts

        .databank 0

        ; 96/ABC5

      rsBattleSceneSpellWindowSetPoseAndDelay ; 96/ABC5

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsBattleSceneReadSpellWindowWord
        sep #$20
        sta aBattleSceneSpellWindowSlots.wAttr,x
        xba
        sta $7FEC2B,x
        rep #$20
        lda aBattleSceneSpellWindowSlots.wScriptOffset,x
        clc
        adc #$0002
        sta aBattleSceneSpellWindowSlots.wScriptOffset,x
        rts

        .databank 0

        ; 96/ABE2

      rsBattleSceneReadSpellWindowWord ; 96/ABE2

        .al
        .xl
        .autsiz
        .databank ?

        phy
        lda $7FEC27,x
        sta lR18+1
        lda aBattleSceneSpellWindowSlots.wScriptOffset,x
        sta lR18
        ldy #$0000
        lda [lR18],y
        ply
        rts

        .databank 0

        ; 96/ABF6

    .endsection Unsorted96A532Section


    .section Unsorted96ACABSection

      .al
      .xl

      rsBattleSceneClearWindowRegs ; 96/ACAB

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$00
        sta bBufferW12SEL
        sta $2123,b
        sta bBufferW34SEL
        sta $2124,b
        sta bBufferWOBJSEL
        sta $2125,b
        sta bBufferTMW
        sta bBufferTSW
        rep #$20
        rts

        .databank 0

        ; 96/ACC5

    .endsection Unsorted96ACABSection


    .section Unreferenced96ACC5Section

      .al
      .xl

      rsBattleSceneClearWindow1Masks ; 96/ACC5

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda bBufferW12SEL
        and #$CC
        sta bBufferW12SEL
        sta $2123,b
        lda bBufferW34SEL
        and #$CC
        sta bBufferW34SEL
        sta $2124,b
        lda bBufferWOBJSEL
        and #$CC
        sta bBufferWOBJSEL
        sta $2125,b
        rep #$20
        rts

        .databank 0

        ; 96/ACE5

      rsBattleSceneClearWindow2Masks ; 96/ACE5

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda bBufferW12SEL
        and #$33
        sta bBufferW12SEL
        sta $2123,b
        lda bBufferW34SEL
        and #$33
        sta bBufferW34SEL
        sta $2124,b
        lda bBufferWOBJSEL
        and #$33
        sta bBufferWOBJSEL
        sta $2125,b
        rep #$20
        rts

        .databank 0

        ; 96/AD05

        ; Unreachable: it follows a return.
        rep #$20

    .endsection Unreferenced96ACC5Section
    .section Unsorted96AD07Section

      .al
      .xl

      rsBattleSceneCreateSpellWindowHDMA ; 96/AD07

        .al
        .xl
        .autsiz
        .databank ?

        phx
        cpx #$0000
        bne _AD22
        lda #(`aBattleSceneSpellWindowHDMAInfo1)<<8
        sta lR44+1
        lda #<>aBattleSceneSpellWindowHDMAInfo1
        sta lR44
        lda #$0003
        sta wR40
        jsl rlHDMAEngineCreateEntryByIndex
        bra _AD35


        _AD22
        lda #(`aBattleSceneSpellWindowHDMAInfo2)<<8
        sta lR44+1
        lda #<>aBattleSceneSpellWindowHDMAInfo2
        sta lR44
        lda #$0006
        sta wR40
        jsl rlHDMAEngineCreateEntryByIndex

        _AD35
        plx
        rts

        .databank 0

        ; 96/AD37

        ; Unreachable: it follows a return.
        rep #$20

    .endsection Unsorted96AD07Section


    .section Unsorted96AD39Section

      .al
      .xl

      rlBattleSceneBuildSpellWindowHDMA ; 96/AD39

        .al
        .xl
        .autsiz
        .databank ?

        phx
        cpx #$0000
        bne _AD47
        lda #$E51D
        ldx #$0000
        bra _AD4D


        _AD47
        lda #$E6DD
        ldx #$001C

        _AD4D
        sta wR0
        lda wBattleSceneFrame
        bit #$0001
        beq _AD5D
        lda #$0380
        bra _AD60


        _AD5D
        lda #$0000

        _AD60
        clc
        adc wR0
        sta wR0
        lda $7FEC65
        and #$00FF
        beq _AD9C
        dec a
        cmp #$0080
        bcc _AD8B
        pha
        lda #$00FF
        sta $7FE4EA,x
        inc x
        lda #$E51B
        sta $7FE4EA,x
        inc x
        inc x
        pla
        sec
        sbc #$007F

        _AD8B
        ora #$0080
        sta $7FE4EA,x
        inc x
        lda #$E51B
        sta $7FE4EA,x
        inc x
        inc x

        _AD9C
        lda $7FEC66
        and #$00FF
        beq _ADE7
        cmp #$0080
        bcc _ADD9
        pha
        lda #$00FF
        sta $7FE4EA,x
        phx
        txa
        sec
        sbc #3,s
        pha
        lda #5,s
        tax
        pla
        sep #$20
        sta $7FE4E9,x
        rep #$20
        plx
        inc x
        lda wR0
        sta $7FE4EA,x
        inc x
        inc x
        clc
        adc #$00FE
        sta wR0
        pla
        sec
        sbc #$007F

        _ADD9
        ora #$0080
        sta $7FE4EA,x
        inc x
        lda wR0
        sta $7FE4EA,x

        _ADE7
        plx
        rtl

        .databank 0

        ; 96/ADE9

    .endsection Unsorted96AD39Section


    .section Unsorted96ADE9Section

      .al
      .xl

      rlBattleSceneDrawWindowCircle ; 96/ADE9

        .al
        .xl
        .autsiz
        .databank ?

        phx
        sta wR0
        phd
        lda #$0000
        pha
        pld
        lda lR18+1
        and #$01FF
        sta $2182,b
        lda wBattleSceneFrame
        bit #$0001
        bne _AE08
        lda #$0380
        bra _AE0B


        _AE08
        lda #$0000

        _AE0B
        clc
        adc lR18
        sta $2181,b
        lda aBattleSceneSpellWindowOAM.bX,x
        and #$00FF
        sta wR1
        lda aBattleSceneSpellWindowOAM.wY,x
        sec
        sbc #$0010
        sta wR2
        lda aBattleSceneSpellWindowOAM.bAttr,x
        and #$00FF
        sta wR3
        lda $7FE4E2,x
        sta wR4
        jsl rlBattleSceneGetWindowShapePtr
        ldy #$0000
        sep #$20
        lda wR2
        sec
        sbc wR3
        beq _AE7D
        bcc _AE68
        cmp #$64
        bcs _AEC7
        rep #$20
        and #$00FF
        tax
        sep #$20

        _AE51
        lda #$80
        sta $2180,b
        lda #$7F
        sta $2180,b
        dec wR0
        bne _AE63
        jml _AED7


        _AE63
        dec x
        bne _AE51
        bra _AE7D


        _AE68
        rep #$20
        eor #$FFFF
        inc a
        and #$00FF
        pha
        lda wR4
        sec
        sbc #1,s
        sta wR4
        pla
        tay
        sep #$20

        _AE7D
        jsr rsBattleSceneWriteWindowPair
        dec wR0
        beq _AED7
        inc y
        cpy wR3
        bcs _AE93
        rep #$20
        dec wR4
        beq _AEAA
        sep #$20
        bra _AE7D


        _AE93
        dec y
        cpy #$0000
        bmi _AEC7
        jsr rsBattleSceneWriteWindowPair
        dec wR0
        beq _AED7
        rep #$20
        dec wR4
        beq _AEAA
        sep #$20
        bra _AE93


        _AEAA
        .al
        and #$85FF
        asl $A8
        jsl rlBattleSceneGetWindowShapePtr
        sep #$20

        _AEB5
        dec y
        dec y
        dec y
        dec y
        cpy #$0000
        bmi _AEC7
        jsr rsBattleSceneWriteWindowPair
        dec wR0
        beq _AED7
        bra _AEB5


        _AEC7
        lda #$80
        sta $2180,b
        lda #$7F
        sta $2180,b
        dec wR0
        beq _AED7
        bra _AEC7


        _AED7
        rep #$20
        pld
        plx
        rtl

        .databank 0

        ; 96/AEDC

      rlBattleSceneDrawWindowCircleWide ; 96/AEDC

        .al
        .xl
        .autsiz
        .databank ?

        phx
        sta wR0
        phd
        lda #$0000
        pha
        pld
        lda lR18+1
        and #$01FF
        sta $2182,b
        lda wBattleSceneFrame
        bit #$0001
        bne _AEFB
        lda #$0380
        bra _AEFE


        _AEFB
        lda #$0000

        _AEFE
        clc
        adc lR18
        sta $2181,b
        lda aBattleSceneSpellWindowOAM.bX,x
        and #$00FF
        sta wR1
        lda aBattleSceneSpellWindowOAM.wY,x
        sec
        sbc #$0010
        sta wR2
        lda aBattleSceneSpellWindowOAM.bAttr,x
        and #$00FF
        sta wR3
        lda $7FE4E2,x
        sta wR4
        jsl rlBattleSceneGetWindowShapePtr
        ldy #$0000
        sep #$20
        lda wR2
        sec
        sbc wR3
        beq _AF70
        bcc _AF5B
        cmp #$A0
        bcs _AFBA
        rep #$20
        and #$00FF
        tax
        sep #$20

        _AF44
        lda #$80
        sta $2180,b
        lda #$7F
        sta $2180,b
        dec wR0
        bne _AF56
        jml _AFCA


        _AF56
        dec x
        bne _AF44
        bra _AF70


        _AF5B
        rep #$20
        eor #$FFFF
        inc a
        and #$00FF
        pha
        lda wR4
        sec
        sbc #1,s
        sta wR4
        pla
        tay
        sep #$20

        _AF70
        jsr rsBattleSceneWriteWindowPair
        dec wR0
        beq _AFCA
        inc y
        cpy wR3
        bcs _AF86
        rep #$20
        dec wR4
        beq _AF9D
        sep #$20
        bra _AF70


        _AF86
        dec y
        cpy #$0000
        bmi _AFBA
        jsr rsBattleSceneWriteWindowPair
        dec wR0
        beq _AFCA
        rep #$20
        dec wR4
        beq _AF9D
        sep #$20
        bra _AF86


        _AF9D
        .al
        and #$85FF
        asl $A8
        jsl rlBattleSceneGetWindowShapePtr
        sep #$20

        _AFA8
        dec y
        dec y
        dec y
        dec y
        cpy #$0000
        bmi _AFBA
        jsr rsBattleSceneWriteWindowPair
        dec wR0
        beq _AFCA
        bra _AFA8


        _AFBA
        lda #$80
        sta $2180,b
        lda #$7F
        sta $2180,b
        dec wR0
        beq _AFCA
        bra _AFBA


        _AFCA
        rep #$20
        pld
        plx
        rtl

        .databank 0

        ; 96/AFCF

      rlBattleSceneDrawWindowOval ; 96/AFCF

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phd
        lda #$0000
        pha
        pld
        lda lR18+1
        and #$01FF
        sta $2182,b
        lda wBattleSceneFrame
        bit #$0001
        bne _AFEC
        lda #$0380
        bra _AFEF


        _AFEC
        lda #$0000

        _AFEF
        clc
        adc lR18
        sta $2181,b
        lda aBattleSceneSpellWindowOAM.wY,x
        sec
        sbc #$0010
        sta wR2
        lda aBattleSceneSpellWindowOAM.bAttr,x
        and #$00FF
        sta wR3
        lda $7FE4E2,x
        sta wR4
        jsl rlBattleSceneGetWindowShapePtr
        ldy #$0000
        sep #$20
        lda wR2
        sec
        sbc wR3
        beq _B04C
        bcc _B037
        rep #$20
        and #$00FF
        tax
        sep #$20

        _B028
        lda #$80
        sta $2180,b
        lda #$7F
        sta $2180,b
        dec x
        bne _B028
        bra _B04C


        _B037
        rep #$20
        eor #$FFFF
        inc a
        and #$00FF
        pha
        lda wR4
        sec
        sbc #1,s
        sta wR4
        pla
        tay
        sep #$20

        _B04C
        lda [lR19],y
        pha
        lda #$80
        sec
        sbc #1,s
        sta $2180,b
        lda #$80
        clc
        adc #1,s
        sta $2180,b
        pla
        inc y
        cpy wR3
        bcs _B069
        dec wR4
        bne _B04C

        _B069
        dec y
        dec y
        dec y
        dec y
        cpy #$0000
        bmi _B088
        lda [lR19],y
        pha
        lda #$80
        sec
        sbc #1,s
        sta $2180,b
        lda #$80
        clc
        adc #1,s
        sta $2180,b
        pla
        bra _B069


        _B088
        rep #$20
        pld
        plx
        rtl

        .databank 0

        ; 96/B08D

    .endsection Unsorted96ADE9Section


    .section Unreferenced96B08DSection

      .al
      .xl

      rlBattleSceneClearWindowBuffers ; 96/B08D

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0070

        _B091
        lda #$7F80
        sta $7FE51D,x
        sta $7FE89D,x
        sta $7FE51F,x
        sta $7FE89F,x
        sta $7FE521,x
        sta $7FE8A1,x
        sta $7FE523,x
        sta $7FE8A3,x
        sta $7FE525,x
        sta $7FE8A5,x
        sta $7FE527,x
        sta $7FE8A7,x
        sta $7FE529,x
        sta $7FE8A9,x
        sta $7FE52B,x
        sta $7FE8AB,x
        txa
        clc
        adc #$0010
        tax
        cpx #$00E0
        bcc _B091
        plx
        rtl

        .databank 0

        ; 96/B0E1

    .endsection Unreferenced96B08DSection
    .section Unsorted96B0E1Section

      .al
      .xl

      rsBattleSceneDrawWindowCone8 ; 96/B0E1

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$0078
        sta wR0
        phd
        lda #$0000
        pha
        pld
        lda lR18+1
        and #$01FF
        sta $2182,b
        lda wBattleSceneFrame
        bit #$0001
        bne _B103
        lda #$0380
        bra _B106


        _B103
        lda #$0000

        _B106
        clc
        adc lR18
        sta $2181,b
        lda aBattleSceneSpellWindowOAM.bX,x
        and #$00FF
        sta wR1
        lda aBattleSceneSpellWindowOAM.wY,x
        sta wR2
        lda aBattleSceneSpellWindowOAM.bAttr,x
        and #$00FF
        sta wR3
        lda $7FE4E2,x
        sta wR4
        jsl rlBattleSceneGetWindowShapePtr
        ldy #$0000
        sep #$20
        lda wR3
        lsr a
        lsr a
        lsr a
        pha
        lda wR2
        sec
        sbc #1,s
        rep #$20
        and #$00FF
        tax
        sep #$20
        pla

        _B147
        lda #$80
        sta $2180,b
        lda #$7F
        sta $2180,b
        dec wR0
        bne _B159
        jml _B1A9


        _B159
        dec x
        bne _B147

        _B15C
        jsr rsBattleSceneWriteWindowPair
        dec wR0
        beq _B1A9
        inc y
        inc y
        inc y
        inc y
        inc y
        inc y
        inc y
        inc y
        cpy wR3
        bcs _B179
        rep #$20
        dec wR4
        beq _B179
        sep #$20
        bra _B15C


        _B179
        dec y
        dec y
        dec y
        dec y
        dec y
        dec y
        dec y
        dec y
        cpy #$0000
        bmi _B197
        jsr rsBattleSceneWriteWindowPair
        dec wR0
        beq _B1A9
        rep #$20
        dec wR4
        beq _B197
        sep #$20
        bra _B179


        _B197
        sep #$20
        lda #$80
        sta $2180,b
        lda #$7F
        sta $2180,b
        dec wR0
        beq _B1A9
        bra _B197


        _B1A9
        rep #$20
        pld
        plx
        rts

        .databank 0

        ; 96/B1AE

      rsBattleSceneDrawWindowCone8Inverted ; 96/B1AE

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$0078
        sta wR0
        phd
        lda #$0000
        pha
        pld
        lda lR18+1
        and #$01FF
        sta $2182,b
        lda wBattleSceneFrame
        bit #$0001
        bne _B1D0
        lda #$0380
        bra _B1D3


        _B1D0
        lda #$0000

        _B1D3
        clc
        adc lR18
        sta $2181,b
        lda aBattleSceneSpellWindowOAM.bX,x
        and #$00FF
        sta wR1
        lda aBattleSceneSpellWindowOAM.wY,x
        sta wR2
        lda aBattleSceneSpellWindowOAM.bAttr,x
        and #$00FF
        sta wR3
        lda $7FE4E2,x
        sta wR4
        jsl rlBattleSceneGetWindowShapePtr
        lda wR3
        tay
        sep #$20
        lda wR2
        rep #$20
        and #$00FF
        tax
        sep #$20

        _B20A
        lda #$00
        sta $2180,b
        lda #$FF
        sta $2180,b
        dec wR0
        bne _B21C
        jml _B24F


        _B21C
        dec x
        bne _B20A

        _B21F
        dec y
        dec y
        dec y
        dec y
        dec y
        dec y
        dec y
        dec y
        cpy #$0000
        bmi _B23D
        jsr rsBattleSceneWriteWindowPair
        dec wR0
        beq _B24F
        rep #$20
        dec wR4
        beq _B23D
        sep #$20
        bra _B21F


        _B23D
        sep #$20
        lda #$80
        sta $2180,b
        lda #$7F
        sta $2180,b
        dec wR0
        beq _B24F
        bra _B23D


        _B24F
        rep #$20
        pld
        plx
        rts

        .databank 0

        ; 96/B254

      rsBattleSceneDrawWindowCone4 ; 96/B254

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$0078
        sta wR0
        phd
        lda #$0000
        pha
        pld
        lda lR18+1
        and #$01FF
        sta $2182,b
        lda wBattleSceneFrame
        bit #$0001
        bne _B276
        lda #$0380
        bra _B279


        _B276
        lda #$0000

        _B279
        clc
        adc lR18
        sta $2181,b
        lda aBattleSceneSpellWindowOAM.bX,x
        and #$00FF
        sta wR1
        lda aBattleSceneSpellWindowOAM.wY,x
        sta wR2
        lda aBattleSceneSpellWindowOAM.bAttr,x
        and #$00FF
        sta wR3
        lda $7FE4E2,x
        sta wR4
        jsl rlBattleSceneGetWindowShapePtr
        ldy #$0000
        sep #$20
        lda wR3
        lsr a
        pha
        lda wR2
        sec
        sbc #1,s
        rep #$20
        and #$00FF
        tax
        sep #$20
        pla

        _B2B8
        lda #$80
        sta $2180,b
        lda #$7F
        sta $2180,b
        dec wR0
        bne _B2CA
        jml _B312


        _B2CA
        dec x
        bne _B2B8

        _B2CD
        jsr rsBattleSceneWriteWindowPair
        dec wR0
        beq _B312
        inc y
        inc y
        inc y
        inc y
        cpy wR3
        bcs _B2E6
        rep #$20
        dec wR4
        beq _B2E6
        sep #$20
        bra _B2CD


        _B2E6
        dec y
        dec y
        dec y
        dec y
        cpy #$0000
        bmi _B300
        jsr rsBattleSceneWriteWindowPair
        dec wR0
        beq _B312
        rep #$20
        dec wR4
        beq _B300
        sep #$20
        bra _B2E6


        _B300
        sep #$20
        lda #$80
        sta $2180,b
        lda #$7F
        sta $2180,b
        dec wR0
        beq _B312
        bra _B300


        _B312
        rep #$20
        pld
        plx
        rts

        .databank 0

        ; 96/B317

      rlBattleSceneDrawWindowDiamond ; 96/B317

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$0070
        sta wR0
        phd
        lda #$0000
        pha
        pld
        lda lR18+1
        and #$01FF
        sta $2182,b
        lda wBattleSceneFrame
        bit #$0001
        bne _B339
        lda #$0380
        bra _B33C


        _B339
        lda #$0000

        _B33C
        clc
        adc lR18
        sta $2181,b
        lda aBattleSceneSpellWindowOAM.bX,x
        and #$00FF
        sta wR1
        lda aBattleSceneSpellWindowOAM.wY,x
        sec
        sbc #$0010
        sta wR2
        lda aBattleSceneSpellWindowOAM.bAttr,x
        and #$00FF
        sta wR3
        lda $7FE4E2,x
        sta wR4
        lda wR3
        jsr rlBattleSceneGetWindowShapeWidth
        pha
        sep #$20
        lda wR1
        clc
        adc #1,s
        bcc _B375
        lda #$FF

        _B375
        xba
        lda wR1
        sec
        sbc #1,s
        bcs _B37F
        lda #$00

        _B37F
        rep #$20
        sta wR5
        pla
        jsl rlBattleSceneGetWindowShapePtr
        ldy #$0000
        sep #$20
        lda wR2
        sec
        sbc wR3
        beq _B3D4
        bcc _B3BF
        cmp $7FFC5B
        bcc _B3A0
        jml _B426


        _B3A0
        rep #$20
        and #$00FF
        tax
        sep #$20

        _B3A8
        lda wR5
        sta $2180,b
        lda wR5+1
        sta $2180,b
        dec wR0
        bne _B3BA
        jml _B436


        _B3BA
        dec x
        bne _B3A8
        bra _B3D4


        _B3BF
        rep #$20
        eor #$FFFF
        inc a
        and #$00FF
        pha
        lda wR4
        sec
        sbc #1,s
        sta wR4
        pla
        tay
        sep #$20

        _B3D4
        lda wR5
        sta $2180,b
        lda wR5+1
        sta $2180,b
        dec wR0
        beq _B436
        inc y
        cpy wR3
        bcs _B3F1
        rep #$20
        dec wR4
        beq _B408
        sep #$20
        bra _B3D4


        _B3F1
        dec y
        cpy #$0000
        bmi _B426
        jsr rsBattleSceneWriteWindowPair
        dec wR0
        beq _B436
        rep #$20
        dec wR4
        beq _B408
        sep #$20
        bra _B3F1


        _B408
        .al
        and #$85FF
        asl $A8
        jsl rlBattleSceneGetWindowShapePtr
        sep #$20

        _B413
        dec y
        dec y
        dec y
        dec y
        dec y
        cpy #$0000
        bmi _B426
        jsr rsBattleSceneWriteWindowPair
        dec wR0
        beq _B436
        bra _B413


        _B426
        lda #$80
        sta $2180,b
        lda #$7F
        sta $2180,b
        dec wR0
        beq _B436
        bra _B426


        _B436
        rep #$20
        pld
        plx
        rtl

        .databank 0

        ; 96/B43B

      rsBattleSceneDrawWindowCone2 ; 96/B43B

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$0078
        sta wR0
        phd
        lda #$0000
        pha
        pld
        lda lR18+1
        and #$01FF
        sta $2182,b
        lda wBattleSceneFrame
        bit #$0001
        bne _B45D
        lda #$0380
        bra _B460


        _B45D
        lda #$0000

        _B460
        clc
        adc lR18
        sta $2181,b
        lda aBattleSceneSpellWindowOAM.bX,x
        and #$00FF
        sta wR1
        lda aBattleSceneSpellWindowOAM.wY,x
        sta wR2
        lda aBattleSceneSpellWindowOAM.bAttr,x
        and #$00FF
        sta wR3
        lda $7FE4E2,x
        sta wR4
        jsl rlBattleSceneGetWindowShapePtr
        ldy #$0000
        sep #$20
        lda wR3
        lsr a
        pha
        lda wR2
        sec
        sbc #1,s
        bcc _B4BA
        beq _B4D0
        rep #$20
        and #$00FF
        tax
        sep #$20
        pla

        _B4A3
        lda #$80
        sta $2180,b
        lda #$7F
        sta $2180,b
        dec wR0
        bne _B4B5
        jml _B512


        _B4B5
        dec x
        bne _B4A3
        bra _B4D1


        _B4BA
        rep #$20
        asl a
        eor #$FFFF
        inc a
        and #$00FF
        pha
        lda wR4
        sec
        sbc #1,s
        sta wR4
        pla
        tay
        sep #$20

        _B4D0
        pla

        _B4D1
        jsr rsBattleSceneWriteWindowPair
        dec wR0
        beq _B512
        inc y
        inc y
        cpy wR3
        bcs _B4E8
        rep #$20
        dec wR4
        beq _B4E8
        sep #$20
        bra _B4D1


        _B4E8
        dec y
        dec y
        cpy #$0000
        bmi _B500
        jsr rsBattleSceneWriteWindowPair
        dec wR0
        beq _B512
        rep #$20
        dec wR4
        beq _B500
        sep #$20
        bra _B4E8


        _B500
        sep #$20
        lda #$80
        sta $2180,b
        lda #$7F
        sta $2180,b
        dec wR0
        beq _B512
        bra _B500


        _B512
        rep #$20
        pld
        plx
        rts

        .databank 0

        ; 96/B517

      rlBattleSceneGetWindowShapePtr ; 96/B517

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$9A00
        sta lR19+1
        lda wR3
        bit #$0080
        beq _B536
        pha
        and #$FFF8
        sta wR3
        pla
        and #$FF78
        lsr a
        lsr a
        clc
        adc #$0080
        bra _B562


        _B536
        bit #$0040
        beq _B54C
        pha
        and #$FFFC
        sta wR3
        pla
        and #$FFBC
        lsr a
        clc
        adc #$0060
        bra _B562


        _B54C
        bit #$0020
        beq _B561
        pha
        and #$FFFE
        sta wR3
        pla
        and #$FFDE
        clc
        adc #$0040
        bra _B562


        _B561
        asl a

        _B562
        tax
        lda aBattleSceneWindowShapes,x
        clc
        adc #$A30A
        sta lR19
        plx
        rtl

        .databank 0

        ; 96/B56F

      rlBattleSceneGetWindowShapeWidth ; 96/B56F

        .al
        .xl
        .autsiz
        .databank ?

        phx
        pha
        bit #$0080
        beq _B581
        and #$FF78
        lsr a
        lsr a
        clc
        adc #$0080
        bra _B59F


        _B581
        bit #$0040
        beq _B590
        and #$FFBC
        lsr a
        clc
        adc #$0060
        bra _B59F


        _B590
        bit #$0020
        beq _B59E
        and #$FFDE
        clc
        adc #$0040
        bra _B59F


        _B59E
        asl a

        _B59F
        tax
        lda aBattleSceneWindowShapes,x
        clc
        adc #1,s
        dec a
        tax
        lda aBattleSceneWindowShapes,x
        and #$00FF
        sta #1,s
        pla
        plx
        rts

        .databank 0

        ; 96/B5B5

      rsBattleSceneWriteWindowPair ; 96/B5B5

        .as
        .xl
        .autsiz
        .databank ?

        lda [lR19],y
        pha
        lda wR1
        sec
        sbc #1,s
        bcs _B5C1
        lda #$00

        _B5C1
        sta $2180,b
        lda wR1
        clc
        adc #1,s
        bcc _B5CD
        lda #$FF

        _B5CD
        sta $2180,b
        pla
        rts

        .databank 0

        ; 96/B5D2

      rsBattleSceneCalcWindowHalfHeight ; 96/B5D2

        .al
        .xl
        .autsiz
        .databank ?

        pha
        lda $7FFC5B
        sec
        sbc aBattleSceneSpellWindowOAM.wY,x
        bcc _B5F7
        cmp aBattleSceneSpellWindowOAM.bAttr,x
        bcs _B613
        rep #$20
        and #$00FF
        sta wR0
        lda aBattleSceneSpellWindowOAM.bAttr,x
        and #$00FF
        clc
        adc wR0
        bra _B61D


        _B5F7
        rep #$20
        lda aBattleSceneSpellWindowOAM.wY,x
        and #$00FF
        sec
        sbc $7FFC5B
        sta wR0
        lda aBattleSceneSpellWindowOAM.bAttr,x
        and #$00FF
        sec
        sbc wR0
        bra _B61D


        _B613
        rep #$20
        lda aBattleSceneSpellWindowOAM.bAttr,x
        and #$00FF
        asl a

        _B61D
        sta $7FE4E2,x
        pla
        rts

        .databank 0

        ; 96/B623

      rsBattleSceneCalcWindowHalfHeightA0 ; 96/B623

        .al
        .xl
        .autsiz
        .databank ?

        pha
        lda #$00A0
        sec
        sbc aBattleSceneSpellWindowOAM.wY,x
        bcc _B647
        cmp aBattleSceneSpellWindowOAM.bAttr,x
        bcs _B662
        rep #$20
        and #$00FF
        sta wR0
        lda aBattleSceneSpellWindowOAM.bAttr,x
        and #$00FF
        clc
        adc wR0
        bra _B66C


        _B647
        rep #$20
        lda aBattleSceneSpellWindowOAM.wY,x
        and #$00FF
        sec
        sbc #$00A0
        sta wR0
        lda aBattleSceneSpellWindowOAM.bAttr,x
        and #$00FF
        sec
        sbc wR0
        bra _B66C


        _B662
        rep #$20
        lda aBattleSceneSpellWindowOAM.bAttr,x
        and #$00FF
        asl a

        _B66C
        sta $7FE4E2,x
        pla
        rts

        .databank 0

        ; 96/B672

      rlBattleSceneLaunchWindowProjectile ; 96/B672

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda bBattleSceneAttackerSide,b
        bit #$0080
        bne _B680
        lda #$0000
        bra _B685


        _B680
        lda #$8000
        bra _B685


        _B685
        jsr rsBattleSceneSetupWindowProjectile
        plx
        rtl

        .databank 0

        ; 96/B68A

      rsBattleSceneSetupWindowProjectile ; 96/B68A

        .al
        .xl
        .autsiz
        .databank ?

        pha
        pha
        jsl rlBattleSceneGetCombatantGap
        jsr rsBattleSceneInitEffectHorizontalMove
        lda wR0
        sta wR1
        clc
        jsl rlBattleAnimationGetEffectSpeed
        pha
        sta wR0
        lda wR1
        jsl rlBattleAnimationGetSpeed
        sta wR0
        pla
        sta wR1
        jsl rlBattleAnimationCompareCombatantX
        bcc _B6B6
        pla
        eor #$8000
        bra _B6B7


        _B6B6
        pla

        _B6B7
        ora wR1
        sta aUnit2DataBuffer._Inventory.ItemCount,x
        pla
        pha
        sta wR1
        lda wR0
        pha
        lda wR1
        jsr rsBattleSceneInitEffectVerticalArc
        pla
        sta wR0
        pla
        asl a
        jsl rlBattleAnimationGetEffectArcHeight
        jsl rlBattleAnimationGetJumpArc
        lda wR0
        sta $7FEC3C,x
        lda wR1
        sta $7FEC3A,x
        rts

        .databank 0

        ; 96/B6E3

      rsBattleSceneUpdateTrackedWindowPos ; 96/B6E3

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda aBattleSceneSpellWindowSlots.wFlags,x
        bit #$0020
        beq _B717
        lda #$0000
        sta aUnit2DataBuffer._ROM.StrengthGrowth,x
        lda aBattleSceneBGAnimSlots.wX
        and #$03FF
        sec
        sbc #$0100
        clc
        adc #$0100
        sta aBattleSceneSpellWindowSlots.wX,x
        lda aBattleSceneBGAnimSlots.bYFraction
        clc
        adc #$8000
        eor #$FFFF
        inc a
        sta aBattleSceneSpellWindowSlots.wYFixed,x

        _B717
        plx
        rts

        .databank 0

        ; 96/B719

      rsBattleSceneStepWindowHorizontal ; 96/B719

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda aUnit2DataBuffer._Inventory.ItemCount
        bne _B724
        jml _B743


        _B724
        bpl _B72A
        jml _B736


        _B72A
        sta wR0
        jsr rsBattleSceneStepWindowRight
        bcc _B734
        jsr rsBattleSceneStopSpellWindowSlot

        _B734
        bra _B743


        _B736
        and #$7FFF
        sta wR0
        jsr rsBattleSceneStepWindowLeft
        bcc _B743
        jsr rsBattleSceneStopSpellWindowSlot

        _B743
        plx
        rts

        .databank 0

        ; 96/B745

      rsBattleSceneStepWindowRight ; 96/B745

        .al
        .xl
        .autsiz
        .databank ?

        phx
        sta wR2
        lda aUnit2DataBuffer._ROM.StrengthGrowth
        clc
        adc wR2
        sta aUnit2DataBuffer._ROM.StrengthGrowth
        lda aUnit2DataBuffer._ROM.MagicGrowth
        adc #$0000
        sep #$20
        sta aUnit2DataBuffer._ROM.MagicGrowth
        rep #$20
        lda aBattleSceneSpellWindowSlots.wX
        cmp #$0200
        bcs _B792
        ldx wBattleAnimationDefenderOffset,b
        cmp wBattleAnimationX,b,x
        bcc _B775
        bra _B792


        _B775
        cmp #$0180
        bcc _B77F
        lda #$0180
        bra _B789


        _B77F
        cmp #$0080
        bcs _B789
        lda #$0080
        bra _B789


        _B789
        sec
        sbc #$0080
        sta wBattleSceneCameraX
        clc

        _B792
        plx
        rts

        .databank 0

        ; 96/B794

      rsBattleSceneStepWindowLeft ; 96/B794

        .al
        .xl
        .autsiz
        .databank ?

        sta wR2
        lda aUnit2DataBuffer._ROM.StrengthGrowth
        sec
        sbc wR2
        sta aUnit2DataBuffer._ROM.StrengthGrowth
        lda aUnit2DataBuffer._ROM.MagicGrowth
        sbc #$0000
        sep #$20
        sta aUnit2DataBuffer._ROM.MagicGrowth
        rep #$20
        lda aBattleSceneSpellWindowSlots.wX
        bpl _B7B9
        sec
        bra _B7E1


        _B7B9
        ldx wBattleAnimationDefenderOffset,b
        cmp wBattleAnimationX,b,x
        bcs _B7C4
        sec
        bra _B7E1


        _B7C4
        cmp #$0180
        bcc _B7CE
        lda #$0180
        bra _B7D8


        _B7CE
        cmp #$0080
        bcs _B7D8
        lda #$0080
        bra _B7D8


        _B7D8
        sec
        sbc #$0080
        sta wBattleSceneCameraX
        clc

        _B7E1
        rts

        .databank 0

        ; 96/B7E2

    .endsection Unsorted96B0E1Section


    .section Unreferenced96B7E2Section

      .al
      .xl

      rsBattleSceneStepWindowGravity ; 96/B7E2

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda $7FEC3A
        bmi _B7F5
        lda $7FEC3A
        clc
        adc aBattleSceneSpellWindowSlots.wYFixed
        bcc _B808
        bra _B800


        _B7F5
        lda $7FEC3A
        clc
        adc aBattleSceneSpellWindowSlots.wYFixed
        bcs _B808

        _B800
        stz $EC23,b
        stz $EC3A,b
        bra _B819


        _B808
        sta aBattleSceneSpellWindowSlots.wYFixed
        lda $7FEC3A
        sec
        sbc $7FEC3C
        sta $7FEC3A

        _B819
        rts

        .databank 0

        ; 96/B81A

      rsBattleSceneStepWindowVertical ; 96/B81A

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda $7FEC3F
        bne _B822
        bra _B851


        _B822
        bmi _B83A
        sta wR0
        lda aBattleSceneSpellWindowSlots.wYFixed
        sec
        sbc wR0
        bcs _B834
        jsr rsBattleSceneEndSpellWindowEffect
        bra _B838


        _B834
        sta aBattleSceneSpellWindowSlots.wYFixed

        _B838
        bra _B851


        _B83A
        and #$7FFF
        sta wR0
        lda aBattleSceneSpellWindowSlots.wYFixed
        clc
        adc wR0
        bcc _B84D
        jsr rsBattleSceneEndSpellWindowEffect
        bra _B851


        _B84D
        sta aBattleSceneSpellWindowSlots.wYFixed

        _B851
        rts

        .databank 0

        ; 96/B852

    .endsection Unreferenced96B7E2Section
    .section Unsorted96BE28Section

      .al
      .xl

      rlBattleSceneRunHDMAEffects ; 96/BE28

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda $7FED02
        and #$00FF
        beq _BE50
        ldx #$0000

        _BE36
        lda $7FED03,x
        bit #$0001
        beq _BE45
        phb
        jsl rlBattleSceneDispatchHDMAEffect
        plb
        .databank ?

        _BE45
        txa
        clc
        adc #$0009
        tax
        cpx #$0048
        bcc _BE36

        _BE50
        ply
        plx
        rtl

        .databank 0

        ; 96/BE53

      rlBattleSceneDispatchHDMAEffect ; 96/BE53

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FED04,x
        sta lR18
        sep #$20
        lda $7FED06,x
        sta lR18+2
        pha
        plb
        .databank ?
        rep #$20
        jml [lR18]

        .databank 0

        ; 96/BE68

        ; Unreachable: it follows a return.
        rtl

      rlBattleSceneInitBG2ScrollHDMA1 ; 96/BE69

        .al
        .xl
        .autsiz
        .databank ?

        ; Unreferenced.

        phx
        lda #$000F
        sta $7FF6B4,x
        lda #$F714
        sta $7FF6B5,x
        lda #$00C0
        sta $7FF6B7,x
        lda #$F714
        sta $7FF6B8,x
        lda #$00B0
        sta $7FF6BA,x
        lda #$F714
        sta $7FF6BB,x
        sep #$20
        lda #$00
        sta $7FF6BD,x
        rep #$20
        lda #(`aBattleSceneBG2ScrollHDMAInfo)<<8
        sta lR44+1
        lda #<>aBattleSceneBG2ScrollHDMAInfo
        sta lR44
        lda #$0005
        sta wR40
        jsl rlHDMAEngineCreateEntryByIndex
        lda #(`rlBattleSceneStepBG2ScrollHDMA1)<<8
        sta $7FED05,x
        lda #<>rlBattleSceneStepBG2ScrollHDMA1
        sta $7FED04,x
        plx
        rtl

        .databank 0

        ; 96/BEC1

      rlBattleSceneStepBG2ScrollHDMA1 ; 96/BEC1

        .al
        .xl
        .autsiz
        .databank ?

        ; Unreferenced.

        phx
        ldx #$0000
        lda aBattleSceneBGAnimSlots.wX
        bit #$0100
        beq _BED1
        ora #$FF00

        _BED1
        pha
        lda aBattleSceneBGAnimSlots.wY
        bit #$0100
        beq _BEDE
        ora #$FF00

        _BEDE
        pha

        _BEDF
        lda aBattleSceneBG2ShakeOffsets+12,x
        sec
        sbc #3,s
        sta $7FF714,x
        inc x
        inc x
        lda aBattleSceneBG2ShakeOffsets+12,x
        sec
        sbc #1,s
        sta $7FF714,x
        inc x
        inc x
        cpx #$0100
        bcc _BEDF
        pla
        pla
        plx
        rtl

        phx
        lda #$000F
        sta $7FF6B4,x
        lda #$F714
        sta $7FF6B5,x
        lda #$00A0
        sta $7FF6B7,x
        lda #$F714
        sta $7FF6B8,x
        lda #$00A0
        sta $7FF6BA,x
        lda #$F714
        sta $7FF6BB,x
        lda #$00A0
        sta $7FF6BD,x
        lda #$F714
        sta $7FF6BE,x
        lda #$0090
        sta $7FF6C0,x
        lda #$F714
        sta $7FF6C1,x
        sep #$20
        lda #$00
        sta $7FF6C3,x
        rep #$20
        lda #(`aBattleSceneBG2ScrollHDMAInfo)<<8
        sta lR44+1
        lda #<>aBattleSceneBG2ScrollHDMAInfo
        sta lR44
        lda #$0005
        sta wR40
        jsl rlHDMAEngineCreateEntryByIndex
        lda #(`rlBattleSceneStepBG2ScrollHDMA2)<<8
        sta $7FED05,x
        lda #<>rlBattleSceneStepBG2ScrollHDMA2
        sta $7FED04,x
        plx
        rtl

        .databank 0

      rlBattleSceneStepBG2ScrollHDMA2 ; 96/BF76

        .al
        .xl
        .autsiz
        .databank ?

        ; The step rlBattleSceneStepBG2ScrollHDMA1 stores for its slot.

        phx
        phy
        lda aBattleSceneBG2ScrollHDMAStep,x
        pha
        clc
        adc #$0004
        cmp #$0080
        bcc _BF89
        lda #$0000

        _BF89
        sta aBattleSceneBG2ScrollHDMAStep,x
        pla
        tax
        lda #$7F00
        sta lR18+1
        lda #$F714
        sta lR18
        ldy #$0000
        lda aBattleSceneBGAnimSlots.wX
        and #$03FF
        sec
        sbc wBattleSceneCameraX
        sec
        sbc #$0100
        sec
        sbc aBattleSceneBGAnimSlots.wOffsetX
        pha
        lda aBattleSceneBGAnimSlots.wY
        pha

        _BFB7
        lda aBattleSceneBG2ShakeOffsets+268,x
        cmp #$8000
        bne _BFC5
        ldx #$0000
        bra _BFB7


        _BFC5
        sec
        sbc #3,s
        sta [lR18],y
        inc x
        inc x
        inc y
        inc y
        lda aBattleSceneBG2ShakeOffsets+268,x
        sec
        sbc #1,s
        sta [lR18],y
        inc x
        inc x
        inc y
        inc y
        cpy #$0080
        bcc _BFB7
        pla
        pla
        ply
        plx
        rtl

        .databank 0

        ; 96/BFE5

    .endsection Unsorted96BE28Section


    .section Unsorted96BFE5Section

      .al
      .xl

      rlBattleSceneInitBG3WaveHDMA ; 96/BFE5

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        sep #$20
        lda $7FED03
        ora #$02
        sta $7FED03
        rep #$20
        jsl rlBattleSceneCreateBG2VScrollHDMA5
        lda #(`rlBattleSceneStepBG3WaveHDMA)<<8
        sta $7FED05,x
        lda #<>rlBattleSceneStepBG3WaveHDMA
        sta $7FED04,x
        plx
        rtl

        .databank 0

        ; 96/C008

      rlBattleSceneStepBG3WaveHDMA ; 96/C008

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda $7FED07
        and #$00FF
        beq _C01E
        sep #$20
        dec a
        sta $7FED07
        rep #$20
        bra _C078


        _C01E
        lda aBattleSceneBG2ScrollHDMAStep,x
        tax
        lda aBattleSceneBG3WaveData,x
        cmp #$8001
        bne _C035
        lda #$0000
        jsl rlBattleSceneClearHDMAEffectSlot
        bra _C04D


        _C035
        cmp #$8000
        bne _C05C
        lda #$0000
        jsl rlBattleSceneStopHDMAEffect
        sep #$20
        lda $7FED03
        and #$FD
        sta $7FED03

        _C04D
        lda bBattleSceneScriptWaitCount
        beq _C058
        dec a
        sta bBattleSceneScriptWaitCount

        _C058
        rep #$20
        bra _C07C


        _C05C
        sep #$20
        sta $7FED07
        xba
        sta $7FF5AC
        rep #$20
        lda #3,s
        tax
        lda aBattleSceneBG2ScrollHDMAStep,x
        clc
        adc #$0002
        sta aBattleSceneBG2ScrollHDMAStep,x

        _C078
        jsl rlBattleSceneBuildBG2WaveTable

        _C07C
        ply
        plx
        rtl

        .databank 0

        ; 96/C07F

    .endsection Unsorted96BFE5Section


    .section Unreferenced96C07FSection

      .al
      .xl

      rlBattleSceneInitBG1ScrollHDMA ; 96/C07F

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phx
        ldx #$0020
        lda #$000F
        sta $7FF6B4,x
        lda #$F8D4
        sta $7FF6B5,x
        lda #$00C0
        sta $7FF6B7,x
        lda #$F8D4
        sta $7FF6B8,x
        lda #$00B0
        sta $7FF6BA,x
        lda #$F8D4
        sta $7FF6BB,x
        sep #$20
        lda #$00
        sta $7FF6BD,x
        rep #$20
        plx
        lda #(`aBattleSceneBG1ScrollHDMAInfo)<<8
        sta lR44+1
        lda #<>aBattleSceneBG1ScrollHDMAInfo
        sta lR44
        lda #$0005
        sta wR40
        jsl rlHDMAEngineCreateEntryByIndex
        lda #(`rlBattleSceneStepBG1ScrollHDMA)<<8
        sta $7FED05,x
        lda #<>rlBattleSceneStepBG1ScrollHDMA
        sta $7FED04,x
        plx
        rtl

        .databank 0

        ; 96/C0DC

      rlBattleSceneStepBG1ScrollHDMA ; 96/C0DC

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000
        lda aBattleSceneBGAnimSlots.wX
        bit #$0100
        beq _C0EC
        ora #$FF00

        _C0EC
        pha
        lda aBattleSceneBGAnimSlots.wY
        bit #$0100
        beq _C0F9
        ora #$FF00

        _C0F9
        pha

        _C0FA
        lda aBattleSceneBG3WaveData+194,x
        sec
        sbc #3,s
        sta $7FF8D4,x
        lda aBattleSceneBG3WaveData+196,x
        sec
        sbc #1,s
        sta $7FF8D6,x
        lda aBattleSceneBG3WaveData+198,x
        sec
        sbc #3,s
        sta $7FF8D8,x
        lda aBattleSceneBG3WaveData+200,x
        sec
        sbc #1,s
        sta $7FF8DA,x
        lda aBattleSceneBG3WaveData+202,x
        sec
        sbc #3,s
        sta $7FF8DC,x
        lda aBattleSceneBG3WaveData+204,x
        sec
        sbc #1,s
        sta $7FF8DE,x
        lda aBattleSceneBG3WaveData+206,x
        sec
        sbc #3,s
        sta $7FF8E0,x
        lda aBattleSceneBG3WaveData+208,x
        sec
        sbc #1,s
        sta $7FF8E2,x
        txa
        clc
        adc #$0010
        tax
        cpx #$0100
        bcc _C0FA
        pla
        pla
        plx
        rtl

        .databank 0

        ; 96/C161

      rlBattleSceneInitBG2ScrollHDMA3 ; 96/C161

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$000F
        sta $7FF6B4,x
        lda #$F714
        sta $7FF6B5,x
        lda #$00C0
        sta $7FF6B7,x
        lda #$F714
        sta $7FF6B8,x
        lda #$00B0
        sta $7FF6BA,x
        lda #$F714
        sta $7FF6BB,x
        sep #$20
        lda #$00
        sta $7FF6BD,x
        rep #$20
        lda #(`aBattleSceneBG2ScrollHDMA3Info)<<8
        sta lR44+1
        lda #<>aBattleSceneBG2ScrollHDMA3Info
        sta lR44
        lda #$0006
        sta wR40
        jsl rlHDMAEngineCreateEntryByIndex
        lda #(`rlBattleSceneStepBG2ScrollHDMA3)<<8
        sta $7FED05,x
        lda #<>rlBattleSceneStepBG2ScrollHDMA3
        sta $7FED04,x
        plx
        rtl

        .databank 0

        ; 96/C1B9

      rlBattleSceneStepBG2ScrollHDMA3 ; 96/C1B9

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000
        lda aBattleSceneBG2AnimSlot.wX
        bit #$0100
        beq _C1C9
        ora #$FF00

        _C1C9
        pha
        lda aBattleSceneBG2AnimSlot.wY
        eor #$FFFF
        inc a
        pha

        _C1D3
        lda aBattleSceneBG3WaveData+450,x
        sec
        sbc #3,s
        sta $7FF714,x
        lda aBattleSceneBG3WaveData+452,x
        sec
        sbc #1,s
        sta $7FF716,x
        lda aBattleSceneBG3WaveData+454,x
        sec
        sbc #3,s
        sta $7FF718,x
        lda aBattleSceneBG3WaveData+456,x
        sec
        sbc #1,s
        sta $7FF71A,x
        lda aBattleSceneBG3WaveData+458,x
        sec
        sbc #3,s
        sta $7FF71C,x
        lda aBattleSceneBG3WaveData+460,x
        sec
        sbc #1,s
        sta $7FF71E,x
        lda aBattleSceneBG3WaveData+462,x
        sec
        sbc #3,s
        sta $7FF720,x
        lda aBattleSceneBG3WaveData+464,x
        sec
        sbc #1,s
        sta $7FF722,x
        txa
        clc
        adc #$0010
        tax
        cpx #$0100
        bcc _C1D3
        pla
        pla
        plx
        rtl

        .databank 0

        ; 96/C23A

      rlBattleSceneInitBG2ScrollHDMA4 ; 96/C23A

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$000F
        sta $7FF6B4,x
        lda #$F714
        sta $7FF6B5,x
        lda #$00C0
        sta $7FF6B7,x
        lda #$F714
        sta $7FF6B8,x
        lda #$00B0
        sta $7FF6BA,x
        lda #$F714
        sta $7FF6BB,x
        sep #$20
        lda #$00
        sta $7FF6BD,x
        rep #$20
        lda #(`aBattleSceneBG2ScrollHDMAInfo)<<8
        sta lR44+1
        lda #<>aBattleSceneBG2ScrollHDMAInfo
        sta lR44
        lda #$0005
        sta wR40
        jsl rlHDMAEngineCreateEntryByIndex
        lda #(`rlBattleSceneStepBG2ScrollHDMA4)<<8
        sta $7FED05,x
        lda #<>rlBattleSceneStepBG2ScrollHDMA4
        sta $7FED04,x
        plx
        rtl

        .databank 0

        ; 96/C292

      rlBattleSceneStepBG2ScrollHDMA4 ; 96/C292

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000
        lda aBattleSceneBGAnimSlots.wX
        bit #$0100
        beq _C2A2
        ora #$FF00

        _C2A2
        pha
        lda aBattleSceneBGAnimSlots.wY
        eor #$FFFF
        inc a
        pha

        _C2AC
        lda aBattleSceneBG3WaveData+450,x
        sec
        sbc #3,s
        sta $7FF714,x
        inc x
        inc x
        lda aBattleSceneBG3WaveData+450,x
        sec
        sbc #1,s
        sta $7FF714,x
        inc x
        inc x
        cpx #$0100
        bcc _C2AC
        pla
        pla
        plx
        rtl

        .databank 0

        ; 96/C2CF

      rlBattleSceneInitBackdropHDMA ; 96/C2CF

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsl rlBattleSceneStepBackdropHDMA
        lda #(`aBattleSceneBackdropHDMAInfo1)<<8
        sta lR44+1
        lda #<>aBattleSceneBackdropHDMAInfo1
        sta lR44
        lda #$0005
        sta wR40
        jsl rlHDMAEngineCreateEntryByIndex
        lda #(`aBattleSceneBackdropHDMAInfo2)<<8
        sta lR44+1
        lda #<>aBattleSceneBackdropHDMAInfo2
        sta lR44
        lda #$0006
        sta wR40
        jsl rlHDMAEngineCreateEntryByIndex
        lda #(`rlBattleSceneStepBackdropHDMA)<<8
        sta $7FED05,x
        lda #<>rlBattleSceneStepBackdropHDMA
        sta $7FED04,x
        plx
        rtl

        .databank 0

        ; 96/C30A

      rlBattleSceneStepBackdropHDMA ; 96/C30A

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phx
        lda aBattleSceneBG2ScrollHDMAStep,x
        tax
        lda aBattleSceneKnockbackShake+648,x
        and #$00FF
        sta $7FF6B4
        lda #$AF83
        sta $7FF6B5
        lda #$00B4
        sta $7FF6B7
        lda #$AF85
        sta $7FF6B8
        sep #$20
        lda #$00
        sta $7FF6BA
        rep #$20
        plx
        lda aBattleSceneBG2ScrollHDMAStep,x
        inc a
        cmp #$0010
        bcc _C349
        lda #$0000

        _C349
        sta aBattleSceneBG2ScrollHDMAStep,x
        plx
        rtl

        .databank 0

        ; 96/C34F

      rlBattleSceneInitAttackerColorHDMA ; 96/C34F

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phx
        ldx wBattleAnimationAttackerOffset,b
        lda wBattleAnimationBaseTile,b,x
        bit #$8000
        bne _C361
        lda #$0000
        bra _C364


        _C361
        lda #$0001

        _C364
        plx
        sta $7FED07,x
        jsl rlBattleSceneStepAttackerColorHDMA
        lda #(`aBattleSceneAttackerColorHDMAInfo)<<8
        sta lR44+1
        lda #<>aBattleSceneAttackerColorHDMAInfo
        sta lR44
        lda #$0005
        sta wR40
        jsl rlHDMAEngineCreateEntryByIndex
        lda #(`rlBattleSceneStepAttackerColorHDMA)<<8
        sta $7FED05,x
        lda #<>rlBattleSceneStepAttackerColorHDMA
        sta $7FED04,x
        plx
        rtl

        .databank 0

        ; 96/C390

      rlBattleSceneStepAttackerColorHDMA ; 96/C390

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7FED07,x
        bne _C3B5
        lda aBattleSceneBGAnimSlots.wX
        and #$03FF
        sec
        sbc wBattleSceneCameraX
        sec
        sbc #$0100
        sec
        sbc #$0116
        and #$00FF
        xba
        sta $7FF6B8
        bra _C3D3


        _C3B5
        lda aBattleSceneBGAnimSlots.wX
        and #$03FF
        sec
        sbc wBattleSceneCameraX
        sec
        sbc #$0100
        sec
        sbc #$00EA
        and #$00FF
        ora #$FF00
        sta $7FF6B8

        _C3D3
        lda aBattleSceneBG3AnimSlot.wY
        clc
        adc #$0074
        and #$00FF
        sta $7FF6B4
        lda #$FF00
        sta $7FF6B5
        sep #$20
        lda #$18
        sta $7FF6B7
        rep #$20
        lda aBattleSceneKnockbackShake+648,x
        and #$0001
        sta $7FF6BA
        lda #$FF00
        sta $7FF6BB
        sep #$20
        lda #$00
        sta $7FF6BD
        rep #$20
        plx
        rtl

        .databank 0

        ; 96/C411

      rlBattleSceneInitBG2ScrollHDMA5 ; 96/C411

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$000F
        sta $7FF6B4,x
        lda #$F714
        sta $7FF6B5,x
        lda #$00A0
        sta $7FF6B7,x
        lda #$F714
        sta $7FF6B8,x
        lda #$00A0
        sta $7FF6BA,x
        lda #$F714
        sta $7FF6BB,x
        lda #$00A0
        sta $7FF6BD,x
        lda #$F714
        sta $7FF6BE,x
        lda #$0090
        sta $7FF6C0,x
        lda #$F714
        sta $7FF6C1,x
        sep #$20
        lda #$00
        sta $7FF6C3,x
        rep #$20
        lda #(`aBattleSceneBG2ScrollHDMAInfo)<<8
        sta lR44+1
        lda #<>aBattleSceneBG2ScrollHDMAInfo
        sta lR44
        lda #$0005
        sta wR40
        jsl rlHDMAEngineCreateEntryByIndex
        lda #(`rlBattleSceneStepBG2ScrollHDMA5)<<8
        sta $7FED05,x
        lda #<>rlBattleSceneStepBG2ScrollHDMA5
        sta $7FED04,x
        plx
        rtl

        .databank 0

        ; 96/C485

      rlBattleSceneStepBG2ScrollHDMA5 ; 96/C485

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda aBattleSceneBG2ScrollHDMAStep,x
        pha
        clc
        adc #$0004
        cmp #$0080
        bcc _C498
        lda #$0000

        _C498
        sta aBattleSceneBG2ScrollHDMAStep,x
        pla
        tax
        lda #$7F00
        sta lR18+1
        lda #$F714
        sta lR18
        ldy #$0000
        lda aBattleSceneBGAnimSlots.wX
        and #$03FF
        sec
        sbc wBattleSceneCameraX
        sec
        sbc #$0100
        sec
        sbc aBattleSceneBGAnimSlots.wOffsetX
        pha
        lda aBattleSceneBGAnimSlots.wY
        pha

        _C4C6
        lda aBattleSceneBG3WaveData+706,x
        cmp #$8000
        bne _C4D4
        ldx #$0000
        bra _C4C6


        _C4D4
        sec
        sbc #3,s
        sta [lR18],y
        inc x
        inc x
        inc y
        inc y
        lda aBattleSceneBG3WaveData+706,x
        sec
        sbc #1,s
        sta [lR18],y
        inc x
        inc x
        inc y
        inc y
        cpy #$0080
        bcc _C4C6
        pla
        pla
        ply
        plx
        rtl

        .databank 0

        ; 96/C4F4

      rlBattleSceneInitColorMathHDMA ; 96/C4F4

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000

        _C4F8
        lda aBattleSceneSeaColumns+149,x
        sta $7FE51D,x
        inc x
        inc x
        cpx #$0010
        bcc _C4F8
        lda #(`aBattleSceneColorMathHDMAInfo)<<8
        sta lR44+1
        lda #<>aBattleSceneColorMathHDMAInfo
        sta lR44
        lda #$0005
        sta wR40
        jsl rlHDMAEngineCreateEntryByIndex
        lda #1,s
        tax
        lda #(`rlBattleSceneStepColorMathHDMA)<<8
        sta $7FED05,x
        lda #<>rlBattleSceneStepColorMathHDMA
        sta $7FED04,x
        plx
        rtl

        .databank 0

        ; 96/C52D

      rlBattleSceneStepColorMathHDMA ; 96/C52D

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda #$7F00
        sta lR18+1
        lda #$E51D
        sta lR18
        lda aBattleSceneBG2ScrollHDMAStep,x
        pha
        clc
        adc #$000F
        sta aBattleSceneBG2ScrollHDMAStep,x
        plx
        lda aBattleSceneSeaColumns+149,x
        and #$00FF
        cmp #$0000
        bne _C56B
        lda #$0000
        jsl rlBattleSceneStopHDMAEffect
        sep #$20
        lda bBattleSceneScriptWaitCount
        beq _C567
        dec a
        sta bBattleSceneScriptWaitCount

        _C567
        rep #$20
        bra _C57D


        _C56B
        ldy #$0000

        _C56E
        lda aBattleSceneSeaColumns+149,x
        sta [lR18],y
        inc x
        inc x
        inc y
        inc y
        cpy #$0010
        bcc _C56E

        _C57D
        ply
        plx
        rtl

        .databank 0

        ; 96/C580

      rlBattleSceneInitBG2HShakeHDMA ; 96/C580

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000
        lda #$0000

        _C587
        sta $7FF8D4,x
        inc x
        inc x
        cpx #$0020
        bcc _C587
        phx
        ldx wBattleAnimationAttackerOffset,b
        lda wBattleAnimationBaseTile,b,x
        plx
        bit #$8000
        beq _C5A4
        lda #$0001
        bra _C5A7


        _C5A4
        lda #$0000

        _C5A7
        sta aBattleSceneBG2ScrollHDMAStep
        lda #(`aBattleSceneBG2HShakeHDMAInfo)<<8
        sta lR44+1
        lda #<>aBattleSceneBG2HShakeHDMAInfo
        sta lR44
        lda #$0005
        sta wR40
        jsl rlHDMAEngineCreateEntryByIndex
        lda #1,s
        tax
        lda #(`rlBattleSceneStepBG2HShakeHDMA)<<8
        sta $7FED05,x
        lda #<>rlBattleSceneStepBG2HShakeHDMA
        sta $7FED04,x
        plx
        rtl

        .databank 0

        ; 96/C5D1

      rlBattleSceneStepBG2HShakeHDMA ; 96/C5D1

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda aBattleSceneBG2ScrollHDMAStep
        bne _C641
        lda aBattleSceneHUDShakeOffsets+103
        clc
        adc $7FF8E4
        sta $7FF8E4
        lda aBattleSceneHUDShakeOffsets+105
        clc
        adc $7FF8E6
        sta $7FF8E6
        lda aBattleSceneHUDShakeOffsets+107
        clc
        adc $7FF8E8
        sta $7FF8E8
        lda aBattleSceneHUDShakeOffsets+109
        clc
        adc $7FF8EA
        sta $7FF8EA
        lda aBattleSceneHUDShakeOffsets+111
        clc
        adc $7FF8EC
        sta $7FF8EC
        lda aBattleSceneHUDShakeOffsets+113
        clc
        adc $7FF8EE
        sta $7FF8EE
        lda aBattleSceneHUDShakeOffsets+115
        clc
        adc $7FF8F0
        sta $7FF8F0
        lda aBattleSceneHUDShakeOffsets+117
        clc
        adc $7FF8F2
        sta $7FF8F2
        bra _C6A9


        _C641
        lda $7FF8E4
        sec
        sbc aBattleSceneHUDShakeOffsets+103
        sta $7FF8E4
        lda $7FF8E6
        sec
        sbc aBattleSceneHUDShakeOffsets+105
        sta $7FF8E6
        lda $7FF8E8
        sec
        sbc aBattleSceneHUDShakeOffsets+107
        sta $7FF8E8
        lda $7FF8EA
        sec
        sbc aBattleSceneHUDShakeOffsets+109
        sta $7FF8EA
        lda $7FF8EC
        sec
        sbc aBattleSceneHUDShakeOffsets+111
        sta $7FF8EC
        lda $7FF8EE
        sec
        sbc aBattleSceneHUDShakeOffsets+113
        sta $7FF8EE
        lda $7FF8F0
        sec
        sbc aBattleSceneHUDShakeOffsets+115
        sta $7FF8F0
        lda $7FF8F2
        sec
        sbc aBattleSceneHUDShakeOffsets+117
        sta $7FF8F2

        _C6A9
        lda $7FF8E5
        and #$00FF
        sta $7FF8D4
        lda $7FF8E7
        and #$00FF
        sta $7FF8D6
        lda $7FF8E9
        and #$00FF
        sta $7FF8D8
        lda $7FF8EB
        and #$00FF
        sta $7FF8DA
        lda $7FF8ED
        and #$00FF
        sta $7FF8DC
        lda $7FF8EF
        and #$00FF
        sta $7FF8DE
        lda $7FF8F1
        and #$00FF
        sta $7FF8E0
        lda $7FF8F3
        and #$00FF
        sta $7FF8E2
        rtl

        .databank 0

        ; 96/C702

      rlBattleSceneInitBG2ScrollHDMA6 ; 96/C702

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$000F
        sta $7FF6B4,x
        lda #$F714
        sta $7FF6B5,x
        lda #$00A0
        sta $7FF6B7,x
        lda #$F714
        sta $7FF6B8,x
        lda #$00A0
        sta $7FF6BA,x
        lda #$F714
        sta $7FF6BB,x
        lda #$00A0
        sta $7FF6BD,x
        lda #$F714
        sta $7FF6BE,x
        lda #$0090
        sta $7FF6C0,x
        lda #$F714
        sta $7FF6C1,x
        sep #$20
        lda #$00
        sta $7FF6C3,x
        rep #$20
        lda #(`aBattleSceneBG2ScrollHDMAInfo)<<8
        sta lR44+1
        lda #<>aBattleSceneBG2ScrollHDMAInfo
        sta lR44
        lda #$0005
        sta wR40
        jsl rlHDMAEngineCreateEntryByIndex
        lda #(`rlBattleSceneStepBG2ScrollHDMA6)<<8
        sta $7FED05,x
        lda #<>rlBattleSceneStepBG2ScrollHDMA6
        sta $7FED04,x
        plx
        rtl

        .databank 0

        ; 96/C776

      rlBattleSceneStepBG2ScrollHDMA6 ; 96/C776

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda aBattleSceneBG2ScrollHDMAStep,x
        pha
        clc
        adc #$0004
        cmp #$0080
        bcc _C789
        lda #$0000

        _C789
        sta aBattleSceneBG2ScrollHDMAStep,x
        pla
        tax
        lda #$7F00
        sta lR18+1
        lda #$F714
        sta lR18
        ldy #$0000
        lda aBattleSceneBGAnimSlots.wX
        and #$03FF
        eor #$FFFF
        inc a
        pha
        lda aBattleSceneBGAnimSlots.wY
        pha

        _C7AD
        lda aBattleSceneBG3WaveData+836,x
        cmp #$8000
        bne _C7BB
        ldx #$0000
        bra _C7AD


        _C7BB
        sec
        sbc #3,s
        sta [lR18],y
        inc x
        inc x
        inc y
        inc y
        lda aBattleSceneBG3WaveData+836,x
        sec
        sbc #1,s
        sta [lR18],y
        inc x
        inc x
        inc y
        inc y
        cpy #$0080
        bcc _C7AD
        pla
        pla
        ply
        plx
        rtl

        .databank 0

        ; 96/C7DB

    .endsection Unreferenced96C07FSection
    .section Unsorted96C7DBSection

      .al
      .xl

      rlBattleSceneCreateBG2VScrollHDMA5 ; 96/C7DB

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$000F
        sta $7FF6B4,x
        lda #$F714
        sta $7FF6B5,x
        lda #$00F0
        sta $7FF6B7,x
        lda #$F714
        sta $7FF6B8,x
        sep #$20
        lda #$00
        sta $7FF6BA,x
        rep #$20
        lda #(`aBattleSceneBG2VScrollHDMAInfo)<<8
        sta lR44+1
        lda #<>aBattleSceneBG2VScrollHDMAInfo
        sta lR44
        lda #$0005
        sta wR40
        jsl rlHDMAEngineCreateEntryByIndex
        plx
        rtl

        .databank 0

        ; 96/C817

      rlBattleSceneBuildBG2WaveTable ; 96/C817

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$7F00
        sta lR18+1
        lda #$F714
        sta lR18
        lda aBattleSceneBGAnimSlots.wY
        eor #$FFFF
        inc a
        clc
        adc #$000F
        and #$00FF
        asl a
        tax
        ldy #$0000
        lda aBattleSceneBGAnimSlots.wY
        pha

        _C83B
        lda $7FEDAA,x
        sec
        sbc #1,s
        sta [lR18],y
        inc y
        inc y
        lda $7FEDAC,x
        sec
        sbc #1,s
        sta [lR18],y
        inc y
        inc y
        lda $7FEDAE,x
        sec
        sbc #1,s
        sta [lR18],y
        inc y
        inc y
        lda $7FEDB0,x
        sec
        sbc #1,s
        sta [lR18],y
        inc y
        inc y
        lda $7FEDB2,x
        sec
        sbc #1,s
        sta [lR18],y
        inc y
        inc y
        lda $7FEDB4,x
        sec
        sbc #1,s
        sta [lR18],y
        inc y
        inc y
        lda $7FEDB6,x
        sec
        sbc #1,s
        sta [lR18],y
        inc y
        inc y
        lda $7FEDB8,x
        sec
        sbc #1,s
        sta [lR18],y
        inc y
        inc y
        txa
        clc
        adc #$0010
        tax
        cpy #$00E0
        bcc _C83B
        pla
        plx
        rtl

        .databank 0

        ; 96/C8A1

    .endsection Unsorted96C7DBSection


    .section Unsorted96C8A1Section

      .al
      .xl

      rlBattleSceneStepWaveOffsetTable ; 96/C8A1

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda $7FED03
        bit #$0002
        bne _C8AE
        bra _C901


        _C8AE
        jsl rlBattleSceneResetWaveOffsetTable
        lda $7FF5AC
        and #$00FF
        pha
        asl a
        asl a
        tax
        lda aBattleSceneWaveScaleTable,x
        tay
        pla
        cpy #$0000
        beq _C901
        asl a
        asl a
        tax
        lda aBattleSceneWaveScaleTable+2,x
        pha
        tya
        pha
        lda #$0100
        sec
        sbc #1,s
        and #$FFFE
        tax
        pla
        txa
        lsr a
        eor #$FFFF
        inc a
        and #$00FF
        sta wR0
        lda #$0000

        _C8EB
        pha
        xba
        and #$00FF
        clc
        adc wR0
        sta $7FEDAA,x
        pla
        clc
        adc #1,s
        inc x
        inc x
        dec y
        bne _C8EB
        pla

        _C901
        ply
        plx
        rtl

        .databank 0

        ; 96/C904

      rlBattleSceneResetWaveOffsetTable ; 96/C904

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000
        lda #$00FE

        _C90B
        sta $7FEDAA,x
        dec a
        sta $7FEDAC,x
        dec a
        sta $7FEDAE,x
        dec a
        sta $7FEDB0,x
        dec a
        sta $7FEDB2,x
        dec a
        sta $7FEDB4,x
        dec a
        sta $7FEDB6,x
        dec a
        sta $7FEDB8,x
        dec a
        pha
        txa
        clc
        adc #$0010
        tax
        pla
        cpx #$0200
        bcc _C90B
        plx
        rtl

        .databank 0

        ; 96/C942

    .endsection Unsorted96C8A1Section


    .section Unsorted96C942Section

      .al
      .xl

      rlBattleSceneStopHDMAEffect ; 96/C942

        .al
        .xl
        .autsiz
        .databank ?

        ; A = slot: frees it and its HDMA entry (A + 5).

        phx
        pha
        sta wR10
        lda #$0009
        sta wR11
        jsl rlUnsignedMultiply16By16
        ldx wR12
        sep #$20
        lda $7FED03,x
        and #$FE
        sta $7FED03,x
        rep #$20
        lda $7FED02
        beq _C96A
        dec a
        sta $7FED02

        _C96A
        pla
        clc
        adc #$0005
        jsl rlHDMAEngineFreeEntryByIndex
        plx
        rtl

        .databank 0

        ; 96/C975

      rlBattleSceneClearHDMAEffectSlot ; 96/C975

        .al
        .xl
        .autsiz
        .databank ?

        phx
        sta wR10
        lda #$0009
        sta wR11
        jsl rlUnsignedMultiply16By16
        ldx wR12
        sep #$20
        lda $7FED03,x
        and #$FE
        sta $7FED03,x
        rep #$20
        lda $7FED02
        beq _C99C
        dec a
        sta $7FED02

        _C99C
        plx
        rtl

        .databank 0

        ; 96/C99E

      rlBattleSceneClearScriptRoutine ; 96/C99E

        .al
        .xl
        .autsiz
        .databank ?

        ; Clears the routine run every frame (lBattleSceneScriptRoutine).

        lda #$FF00
        sta lBattleSceneScriptRoutine+1
        lda #$FFFF
        sta lBattleSceneScriptRoutine
        rtl

        .databank 0

        ; 96/C9AD

    .endsection Unsorted96C942Section


    .section Unsorted96C9D9Section

      .al
      .xl

      rlBattleSceneCommandSetRoutine ; 96/C9D9

        .al
        .xl
        .autsiz
        .databank ?

        ; Command 8: sets routine arg from aBattleSceneScriptRoutines as the one
        ; rlBattleSceneScriptRunRoutine runs every frame.

        phx
        phy
        tya
        and #$01FF
        pha
        asl a
        clc
        adc #1,s
        tax
        pla
        lda aBattleSceneScriptRoutines+1,x
        sta lBattleSceneScriptRoutine+1
        lda aBattleSceneScriptRoutines,x
        sta lBattleSceneScriptRoutine
        pla
        pha
        jsr rsBattleSceneScriptNextCommand
        ply
        plx
        rtl

        .databank 0

        ; 96/C9FE

      rlBattleSceneEndScriptRoutine ; 96/C9FE

        .al
        .xl
        .autsiz
        .databank ?

        ; Ends the routine run every frame (lBattleSceneScriptRoutine) and counts down bBattleSceneScriptWaitCount.

        lda #$FF00
        sta lBattleSceneScriptRoutine+1
        lda #$FFFF
        sta lBattleSceneScriptRoutine
        sep #$20
        lda bBattleSceneScriptWaitCount
        beq _CA19
        dec a
        sta bBattleSceneScriptWaitCount

        _CA19
        rep #$20
        rtl

        .databank 0

        ; 96/CA1C

      rlBattleSceneCommandCallRoutine ; 96/CA1C

        .al
        .xl
        .autsiz
        .databank ?

        ; Command 4: calls routine arg from aBattleSceneScriptRoutines (72 long pointers).

        phx
        phy
        tya
        and #$01FF
        sta wR0
        phb
        jsl _CA2C
        plb
        .databank ?
        bra _CA4E


        _CA2C
        lda wR0
        cmp #$0048
        bmi _CA35

        _CA33
        bra _CA33


        _CA35
        asl a
        adc wR0
        tax
        lda aBattleSceneScriptRoutines,x
        sta lR23
        sep #$20
        lda aBattleSceneScriptRoutines+2,x
        sta lR23+2
        pha
        plb
        .databank ?
        rep #$20
        jml [lR23]


        _CA4E
        pla
        pha
        jsr rsBattleSceneScriptNextCommandNoWait
        ply
        plx
        rtl

        .databank 0

        ; 96/CA56

      rlBattleSceneCommandCallRoutineUntilDone ; 96/CA56

        .al
        .xl
        .autsiz
        .databank ?

        ; Command 5: calls routine arg from aBattleSceneScriptRoutines every frame until it
        ; clears bit 0 of $7FE4B7.

        phx
        phy
        sep #$20
        lda bBattleSceneScriptWaitFlags
        ora #$01
        sta bBattleSceneScriptWaitFlags
        rep #$20
        tya
        and #$01FF
        sta wR0
        phb
        jsl _CA74
        plb
        .databank ?
        bra _CA96


        _CA74
        lda wR0
        cmp #$0048
        bmi _CA7D

        _CA7B
        bra _CA7B


        _CA7D
        asl a
        adc wR0
        tax
        lda aBattleSceneScriptRoutines,x
        sta lR23
        sep #$20
        lda aBattleSceneScriptRoutines+2,x
        sta lR23+2
        pha
        plb
        .databank ?
        rep #$20
        jml [lR23]


        _CA96
        lda bBattleSceneScriptWaitFlags
        bit #$0001
        bne _CAA4
        pla
        pha
        jsr rsBattleSceneScriptNextCommandNoWait

        _CAA4
        ply
        plx
        rtl

        .databank 0

        ; 96/CAA7

      rlBattleSceneScriptLoadAttackerPortraitPal ; 96/CAA7

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        clc
        jsl rlBattleSceneLoadPortraitPalette7
        rtl

        .databank 0

        ; 96/CAAD

      rlBattleSceneScriptLoadDialoguePortraitPal ; 96/CAAD

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        sec
        jsl rlBattleSceneLoadPortraitPalette7
        rtl

        .databank 0

        ; 96/CAB3

      rlBattleSceneLoadPortraitPalette7 ; 96/CAB3

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        bcs _CADA
        lda aBattleSceneCombatant1.Character,b
        jsl rlGetCharacterPortraitData
        ldy #$0000
        ldx #$0000

        _CAC4
        lda [lR19],y
        sta aBGPaletteBuffer.aPalette7,b,x
        inc x
        inc x
        inc y
        inc y
        cpx #$0020
        bcc _CAC4
        lda #$35AD
        sta $01FC,b
        bra _CB07


        _CADA
        lda lBattleSceneDialoguePointer
        sta lR18
        lda lBattleSceneDialoguePointer+1
        sta lR18+1
        jsr rsBattleSceneFindDialoguePortrait
        jsl rlGetCharacterPortraitData
        ldy #$0000
        ldx #$0000

        _CAF3
        lda [lR19],y
        sta aBGPaletteBuffer.aPalette7,b,x
        inc x
        inc x
        inc y
        inc y
        cpx #$0020
        bcc _CAF3
        lda #$0000
        sta $01FC,b

        _CB07
        ply
        plx
        rtl

        .databank 0

        ; 96/CB0A

      rlBattleSceneResetPolygonWindows ; 96/CB0A

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$00
        sta $7FED5C
        sta $7FED64
        sta bBattleSceneWindowEffect2Flag
        sta $7FED8A
        sta $7FED5D
        sta $7FED65
        sta $7FED63
        sta $7FED6B
        lda #$0F
        sta $7FED6C
        lda #$70
        sta $7FED6D
        rep #$20
        lda #$00FF
        sta $7FE51B
        rtl

        .databank 0

        ; 96/CB44

    .endsection Unsorted96C9D9Section


    .section Unsorted96CB44Section

      .al
      .xl

      rlBattleSceneUpdatePolygonWindows ; 96/CB44

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        ldx #$0000

        _CB49
        lda $7FED5C,x
        bit #$0001
        beq _CB5F
        bit #$0002
        bne _CB5C
        jsr rsBattleSceneRunPolygonWindowScript
        bra _CB5F


        _CB5C
        jsr rsBattleSceneRunGradientWindowScript

        _CB5F
        txa
        clc
        adc #$0008
        tax
        cpx #$0010
        bcc _CB49
        ply
        plx
        rtl

        .databank 0

        ; 96/CB6D

      rsBattleSceneRunPolygonWindowScript ; 96/CB6D

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda $7FED5D,x
        beq _CB7C
        dec a
        sta $7FED5D,x
        bra _CBD2


        _CB7C
        rep #$20

        _CB7E
        jsr rsBattleSceneReadPolygonWindowWord
        xba
        and #$00FF
        cmp #$00FF
        bne _CB8F
        jsr rsBattleSceneEndPolygonWindow
        bra _CBD2


        _CB8F
        cmp #$00FD
        bne _CB99
        jsr rsBattleSceneStopPolygonWindow
        bra _CBD2


        _CB99
        cmp #$00FE
        bne _CBA3
        jsr rsBattleScenePolygonWindowLoop
        bra _CBD0


        _CBA3
        cmp #$00FC
        bne _CBAD
        jsr rsBattleScenePolygonWindowSetAttackerPos
        bra _CBD0


        _CBAD
        cmp #$00FB
        bne _CBB7
        jsr rsBattleScenePolygonWindowSetDefenderPos
        bra _CBD0


        _CBB7
        cmp #$00FA
        bne _CBC1
        jsr rsBattleScenePolygonWindowWait1
        bra _CBD0


        _CBC1
        cmp #$00F9
        bne _CBCB
        jsr rsBattleScenePolygonWindowResetScale
        bra _CBD0


        _CBCB
        jsr rsBattleScenePolygonWindowReadFrame
        bra _CBD2


        _CBD0
        bra _CB7E


        _CBD2
        .as
        rep #$20
        jsl rlBattleSceneRasterizePolygonWindows
        jsl rlBattleSceneTransformPolygonBuffers
        jsl rlBattleSceneBuildPolygonWindowHDMA
        rts

        .databank 0

        ; 96/CBE1

      rsBattleSceneEndPolygonWindow ; 96/CBE1

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsBattleSceneClearWindowRegs
        sep #$20
        phx
        cpx #$0000
        beq _CBEF
        ldx #$001C

        _CBEF
        lda bBattleSceneWindowEffect2Flag,x
        and #$FE
        sta bBattleSceneWindowEffect2Flag,x
        plx
        lda $7FED5C,x
        and #$FE
        sta $7FED5C,x
        rep #$20
        jsl rlBattleSceneFreePolygonWindowHDMA
        sep #$20
        lda bBattleSceneScriptWaitCount
        beq _CC13
        dec a

        _CC13
        sta bBattleSceneScriptWaitCount
        rep #$20
        rts

        .databank 0

        ; 96/CC1A

      rsBattleSceneStopPolygonWindow ; 96/CC1A

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        phx
        cpx #$0000
        beq _CC25
        ldx #$001C

        _CC25
        lda bBattleSceneWindowEffect2Flag,x
        and #$FE
        sta bBattleSceneWindowEffect2Flag,x
        plx
        sep #$20
        lda bBattleSceneScriptWaitCount
        beq _CC39
        dec a

        _CC39
        sta bBattleSceneScriptWaitCount
        rep #$20
        rts

        .databank 0

        ; 96/CC40

      rsBattleScenePolygonWindowLoop ; 96/CC40

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FED63,x
        and #$00FF
        beq _CC62
        dec a
        sep #$20
        sta $7FED63,x
        rep #$20
        bne _CC72
        lda $7FED61,x
        clc
        adc #$0002
        sta $7FED61,x
        bra _CC7A


        _CC62
        jsr rsBattleSceneReadPolygonWindowWord
        and #$00FF
        beq _CC72
        sep #$20
        sta $7FED63,x
        rep #$20

        _CC72
        lda $7FED5E,x
        sta $7FED61,x

        _CC7A
        rts

        .databank 0

        ; 96/CC7B

      rsBattleScenePolygonWindowSetAttackerPos ; 96/CC7B

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        ldx wBattleAnimationAttackerOffset,b
        lda wBattleAnimationXFixed,b,x
        sta aUnit2DataBuffer._ROM.StrengthGrowth
        lda wBattleAnimationX,b,x
        sta aBattleSceneSpellWindowSlots.wX
        lda wBattleAnimationYAnchor,b,x
        sta aBattleSceneSpellWindowSlots.wYAnchor
        lda wBattleAnimationYFixed,b,x
        clc
        adc #$3000
        sta aBattleSceneSpellWindowSlots.wYFixed
        lda aBattleSceneSpellWindowSlots.wScriptOffset
        clc
        adc #$0002
        sta aBattleSceneSpellWindowSlots.wScriptOffset
        plx
        pla
        rts

        .databank 0

        ; 96/CCAF

      rsBattleScenePolygonWindowSetDefenderPos ; 96/CCAF

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        ldx wBattleAnimationDefenderOffset,b
        lda wBattleAnimationXFixed,b,x
        sta aUnit2DataBuffer._ROM.StrengthGrowth
        lda wBattleAnimationX,b,x
        sta aBattleSceneSpellWindowSlots.wX
        lda wBattleAnimationYAnchor,b,x
        sta aBattleSceneSpellWindowSlots.wYAnchor
        lda wBattleAnimationYFixed,b,x
        clc
        adc #$1000
        sta aBattleSceneSpellWindowSlots.wYFixed
        jsl rlBattleSceneGetCombatantGap
        lda wR0
        cmp #$0100
        bcc _CCFF
        lda aBattleSceneSpellWindowSlots.wX
        cmp #$0180
        bcc _CCED
        lda #$0180
        bra _CCF7


        _CCED
        cmp #$0080
        bcs _CCF7
        lda #$0080
        bra _CCF7


        _CCF7
        sec
        sbc #$0080
        sta wBattleSceneCameraX

        _CCFF
        lda aBattleSceneSpellWindowSlots.wScriptOffset
        clc
        adc #$0002
        sta aBattleSceneSpellWindowSlots.wScriptOffset
        plx
        pla
        rts

        .databank 0

        ; 96/CD0E

    .endsection Unsorted96CB44Section


    .section Unreferenced96CD0ESection

      .al
      .xl

      rsBattleScenePolygonWindowLaunchProjectile ; 96/CD0E

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        jsl rlBattleSceneLaunchWindowProjectile
        lda aBattleSceneSpellWindowSlots.wScriptOffset
        clc
        adc #$0002
        sta aBattleSceneSpellWindowSlots.wScriptOffset
        plx
        pla
        rts

        .databank 0

        ; 96/CD23

    .endsection Unreferenced96CD0ESection
    .section Unsorted96CD23Section

      .al
      .xl

      rsBattleScenePolygonWindowWait1 ; 96/CD23

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        sep #$20
        lda #$01
        sta $7FEC2B
        rep #$20
        plx
        pla
        rts

        .databank 0

        ; 96/CD32

      rsBattleScenePolygonWindowResetScale ; 96/CD32

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        lda #$0100
        sta $7FED6F,x
        lda #$00C8
        sta $7FED71,x
        lda $7FED61,x
        clc
        adc #$0002
        sta $7FED61,x
        plx
        pla
        rts

        .databank 0

        ; 96/CD51

      rsBattleScenePolygonWindowReadFrame ; 96/CD51

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda $7FED5F,x
        sta lR18+1
        lda $7FED61,x
        sta lR18
        lda $7FED61,x
        clc
        adc #$0007
        sta $7FED61,x
        sep #$20
        ldy #$0000
        lda [lR18],y
        sta $7FED5D,x
        rep #$20
        cpx #$0000
        bne _CD82
        ldx #$0000
        bra _CD85


        _CD82
        ldx #$0008

        _CD85
        ldy #$0001
        lda [lR18],y
        sta $7FED73,x
        ldy #$0003
        lda [lR18],y
        sta $7FED75,x
        ldy #$0005
        lda [lR18],y
        sta $7FED77,x
        ply
        plx
        rts

        .databank 0

        ; 96/CDA3

      rsBattleSceneReadPolygonWindowWord ; 96/CDA3

        .al
        .xl
        .autsiz
        .databank ?

        phy
        lda $7FED5F,x
        sta lR18+1
        lda $7FED61,x
        sta lR18
        ldy #$0000
        lda [lR18],y
        ply
        rts

        .databank 0

        ; 96/CDB7

    .endsection Unsorted96CD23Section


    .section Unsorted96CECESection

      .al
      .xl

      rlBattleSceneFreePolygonWindowHDMA ; 96/CECE

        .al
        .xl
        .autsiz
        .databank ?

        phx
        cpx #$0000
        bne _CEDD
        lda #$0003
        jsl rlHDMAEngineFreeEntryByIndex
        bra _CEE4


        _CEDD
        lda #$0006
        jsl rlHDMAEngineFreeEntryByIndex

        _CEE4
        plx
        rtl

        .databank 0

        ; 96/CEE6

      rlBattleSceneBuildPolygonWindowHDMA ; 96/CEE6

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7FED5C
        bit #$0002
        bne _CF23
        lda bBattleSceneWindowEffect2Flag
        bit #$0001
        beq _CF23
        ldx #$0000
        lda wBattleSceneFrame
        bit #$0001
        bne _CF0A
        ldy #$E51D
        bra _CF0D


        _CF0A
        ldy #$E6DD

        _CF0D
        lda $7FED79
        and #$00FF
        sta wR2
        lda $7FED74
        and #$00FF
        sta wR5
        jsl rlBattleSceneWritePolygonHDMAEntries

        _CF23
        lda $7FED8A
        bit #$0001
        beq _CF56
        ldx #$001C
        lda wBattleSceneFrame
        bit #$00FF
        bne _CF3D
        ldy #$E89D
        bra _CF40


        _CF3D
        ldy #$EA5D

        _CF40
        lda $7FED95
        and #$00FF
        sta wR2
        lda $7FED90
        and #$00FF
        sta wR5
        jsl rlBattleSceneWritePolygonHDMAEntries

        _CF56
        plx
        rtl

        .databank 0

        ; 96/CF58

      rlBattleSceneWritePolygonHDMAEntries ; 96/CF58

        ; TRACE: stack-args
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        phx
        lda $7FED6C
        and #$00FF
        sta wR3
        beq _CF74
        sta $7FED7A,x
        lda #$E51B
        sta $7FED7B,x
        inc x
        inc x
        inc x

        _CF74
        phx
        lda #3,s
        tax
        lda $7FED71,x
        plx
        sec
        sbc #$00FF
        clc
        adc wR5
        sec
        sbc wR3
        bmi _CFDF
        beq _CFDD
        pha
        lda $7FED6D
        and #$00FF
        cmp #1,s
        beq _CF99
        bcs _CF9E

        _CF99
        pla
        jml _D043


        _CF9E
        pla
        cmp #$0080
        bcc _CFCD
        pha
        lda #$007F
        sta $7FED7A,x
        lda #$E51B
        sta $7FED7B,x
        lda #1,s
        sec
        sbc #$007F
        inc x
        inc x
        inc x
        sta $7FED7A,x
        lda #$E51B
        sta $7FED7B,x
        pla
        inc x
        inc x
        inc x
        bra _CFFE


        _CFCD
        sta $7FED7A,x
        pha
        lda #$E51B
        sta $7FED7B,x
        pla
        inc x
        inc x
        inc x

        _CFDD
        bra _CFFE


        _CFDF
        pha
        clc
        adc wR2
        bmi _CFFB
        beq _CFFB
        sta wR2
        pla
        eor #$FFFF
        inc a
        asl a
        pha
        tya
        clc
        adc #1,s
        tay
        pla
        lda #$0000
        bra _CFFE


        _CFFB
        pla
        bra _D043


        _CFFE
        pha
        lda $7FED6D
        and #$00FF
        sec
        sbc #1,s
        cmp wR2
        bcs _D012
        sta #1,s
        pla
        bra _D015


        _D012
        pla
        lda wR2

        _D015
        cmp #$0080
        bcc _D034
        pha
        lda #$00FF
        sta $7FED7A,x
        tya
        sta $7FED7B,x
        clc
        adc #$00FE
        tay
        pla
        sec
        sbc #$007F
        inc x
        inc x
        inc x

        _D034
        ora #$0080
        sta $7FED7A,x
        tya
        sta $7FED7B,x
        inc x
        inc x
        inc x

        _D043
        lda #$0001
        sta $7FED7A,x
        lda #$E51B
        sta $7FED7B,x
        sep #$20
        lda #$00
        sta $7FED7D,x
        rep #$20
        plx
        ply
        plx
        rtl

        .databank 0

        ; 96/D05F

      rlBattleSceneTransformPolygonBuffers ; 96/D05F

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda bBattleSceneWindowEffect2Flag
        bit #$0001
        beq _D08A
        lda $7FED6F
        sta wR0
        lda wBattleSceneFrame
        bit #$0001
        bne _D082
        lda $7FED79
        jsl rlBattleSceneTransformPolygonSlot0Buf0
        bra _D08A


        _D082
        lda $7FED79
        jsl rlBattleSceneTransformPolygonSlot0Buf1

        _D08A
        lda $7FED8A
        bit #$0001
        beq _D0B4
        lda $7FED8B
        sta wR0
        lda wBattleSceneFrame
        bit #$0001
        bne _D0AC
        lda $7FED95
        jsl rlBattleSceneTransformPolygonSlot1Buf0
        bra _D0B4


        _D0AC
        lda $7FED95
        jsl rlBattleSceneTransformPolygonSlot1Buf1

        _D0B4
        plx
        rtl

        .databank 0

        ; 96/D0B6

      rlBattleSceneTransformPolygonSlot0Buf0 ; 96/D0B6

        .al
        .xl
        .autsiz
        .databank ?

        phb
        phx
        phy
        and #$00FF
        bne _D0C1
        lda #$0100

        _D0C1
        asl a
        tax
        sep #$20
        lda #$7F
        pha
        plb
        .databank $7F
        rep #$20
        lda wR0
        sec
        sbc #$0100
        sta wR0

        _D0D3
        lda $EDA9,b,x
        and #$00FF
        clc
        adc wR0
        bpl _D0E3
        lda #$0000
        bra _D0F0


        _D0E3
        cmp #$0100
        bcc _D0F0
        lda #$00FF
        sta $E51B,b,x
        bra _D115


        _D0F0
        sta $E51B,b,x
        lda $EFA9,b,x
        and #$00FF
        clc
        adc wR0
        bpl _D106
        lda #$00FF
        sta $E51B,b,x
        bra _D115


        _D106
        cmp #$0100
        bcc _D10E
        lda #$00FF

        _D10E
        sep #$20
        sta $E51C,b,x
        rep #$20

        _D115
        dec x
        dec x
        bne _D0D3
        ply
        plx
        plb
        .databank $7F
        rtl

        .databank 0

        ; 96/D11D

      rlBattleSceneTransformPolygonSlot1Buf0 ; 96/D11D

        .al
        .xl
        .autsiz
        .databank ?

        phb
        phx
        phy
        and #$00FF
        bne _D128
        lda #$0100

        _D128
        asl a
        tax
        sep #$20
        lda #$7F
        pha
        plb
        .databank $7F
        rep #$20
        lda wR0
        sec
        sbc #$0100
        sta wR0

        _D13A
        lda $F1A9,b,x
        and #$00FF
        clc
        adc wR0
        bpl _D14A
        lda #$0000
        bra _D157


        _D14A
        cmp #$0100
        bcc _D157
        lda #$00FF
        sta $E89B,b,x
        bra _D17D


        _D157
        sta @l $7FE89B,x
        lda $F3A9,b,x
        and #$00FF
        clc
        adc wR0
        bpl _D16E
        lda #$00FF
        sta $E89B,b,x
        bra _D17D


        _D16E
        cmp #$0100
        bcc _D176
        lda #$00FF

        _D176
        sep #$20
        sta $E89C,b,x
        rep #$20

        _D17D
        dec x
        dec x
        bne _D13A
        ply
        plx
        plb
        .databank $7F
        rtl

        .databank 0

        ; 96/D185

      rlBattleSceneTransformPolygonSlot0Buf1 ; 96/D185

        .al
        .xl
        .autsiz
        .databank ?

        phb
        phx
        phy
        and #$00FF
        bne _D190
        lda #$0100

        _D190
        asl a
        tax
        sep #$20
        lda #$7F
        pha
        plb
        .databank $7F
        rep #$20
        lda wR0
        sec
        sbc #$0100
        sta wR0

        _D1A2
        lda $EDA9,b,x
        and #$00FF
        clc
        adc wR0
        bpl _D1B2
        lda #$0000
        bra _D1BF


        _D1B2
        cmp #$0100
        bcc _D1BF
        lda #$00FF
        sta $E6DB,b,x
        bra _D1E4


        _D1BF
        sta $E6DB,b,x
        lda $EFA9,b,x
        and #$00FF
        clc
        adc wR0
        bpl _D1D5
        lda #$00FF
        sta $E6DB,b,x
        bra _D1E4


        _D1D5
        cmp #$0100
        bcc _D1DD
        lda #$00FF

        _D1DD
        sep #$20
        sta $E6DC,b,x
        rep #$20

        _D1E4
        dec x
        dec x
        bne _D1A2
        ply
        plx
        plb
        .databank $7F
        rtl

        .databank 0

        ; 96/D1EC

      rlBattleSceneTransformPolygonSlot1Buf1 ; 96/D1EC

        .al
        .xl
        .autsiz
        .databank ?

        phb
        phx
        phy
        and #$00FF
        bne _D1F7
        lda #$0100

        _D1F7
        asl a
        tax
        sep #$20
        lda #$7F
        pha
        plb
        .databank $7F
        rep #$20
        lda wR0
        sec
        sbc #$0100
        sta wR0

        _D209
        lda $F1A9,b,x
        and #$00FF
        clc
        adc wR0
        bpl _D219
        lda #$0000
        bra _D226


        _D219
        cmp #$0100
        bcc _D226
        lda #$00FF
        sta $EA5B,b,x
        bra _D24C


        _D226
        sta @l $7FEA5B,x
        lda $F3A9,b,x
        and #$00FF
        clc
        adc wR0
        bpl _D23D
        lda #$00FF
        sta $EA5B,b,x
        bra _D24C


        _D23D
        cmp #$0100
        bcc _D245
        lda #$00FF

        _D245
        sep #$20
        sta $EA5C,b,x
        rep #$20

        _D24C
        dec x
        dec x
        bne _D209
        ply
        plx
        plb
        .databank $7F
        rtl

        .databank 0

        ; 96/D254

        ; Unreachable: it follows a return.
        rep #$20

    .endsection Unsorted96CECESection


    .section Unsorted96D256Section

      .al
      .xl

      rlBattleSceneRasterizePolygonWindows ; 96/D256

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000
        ldy #$0000

        _D25D
        lda bBattleSceneWindowEffect2Flag,x
        bit #$0001
        beq _D2C2
        lda $7FED72,x
        and #$FF00
        sta wR4
        lda $7FED73,x
        and #$FF00
        sta wR5
        lda $7FED74,x
        and #$FF00
        sta wR6
        lda $7FED75,x
        and #$FF00
        sta wR7
        lda $7FED76,x
        and #$FF00
        sta wR8
        lda $7FED77,x
        and #$FF00
        sta wR9
        cpx #$0000
        bne _D2A6
        ldy #$0000
        bra _D2A9


        _D2A6
        ldy #$0380

        _D2A9
        tya
        sta $7FEDA6
        clc
        adc #$0200
        sta $7FEDA8
        jsl rlBattleSceneRasterizeTriangle
        sep #$20
        sta $7FED79,x
        rep #$20

        _D2C2
        tya
        clc
        adc #$0400
        tay
        txa
        clc
        adc #$001C
        tax
        cpx #$0038
        bcc _D25D
        plx
        rtl

        .databank 0

        ; 96/D2D5

        ; Unreachable: it follows a return.
        rep #$20

    .endsection Unsorted96D256Section


    .section Unsorted96D2D7Section

      .al
      .xl

      rlBattleSceneRasterizeTriangle ; 96/D2D7

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda wR7
        sec
        sbc wR5
        xba
        and #$00FF
        inc a
        tay
        sta wR14
        lda wR6
        sec
        sbc wR4
        bcs _D2F1
        eor #$FFFF
        inc a

        _D2F1
        sta wR13
        jsl rlUnsignedDivide16By16R13
        lda wR13
        sta wR1
        lda wR4
        sta wR0
        lda $7FEDA6
        tax
        lda wR4
        cmp wR6
        bcs _D30F
        jsr rsBattleSceneStepEdgeUpPostInc
        bra _D312


        _D30F
        jsr rsBattleSceneStepEdgeDownPreDec

        _D312
        txa
        sta $7FEDA6
        lda wR9
        sec
        sbc wR5
        xba
        and #$00FF
        inc a
        tay
        sta wR14
        lda wR8
        sec
        sbc wR4
        bcs _D32F
        eor #$FFFF
        inc a

        _D32F
        sta wR13
        jsl rlUnsignedDivide16By16R13
        lda wR13
        sta wR1
        lda wR4
        sta wR0
        lda $7FEDA8
        tax
        lda wR4
        cmp wR8
        bcs _D34D
        jsr rsBattleSceneStepEdgeUpPreInc
        bra _D350


        _D34D
        jsr rsBattleSceneStepEdgeDownPostDec

        _D350
        txa
        sta $7FEDA8
        lda wR7
        cmp wR9
        bne _D369
        sec
        sbc wR5
        xba
        and #$00FF
        inc a
        sta wR2
        jml _D3E8


        _D369
        lda wR9
        sec
        sbc wR7
        bcs _D374
        eor #$FFFF
        inc a

        _D374
        xba
        and #$00FF
        tay
        sta wR14
        lda wR8
        sec
        sbc wR6
        bcs _D386
        eor #$FFFF
        inc a

        _D386
        sta wR13
        jsl rlUnsignedDivide16By16R13
        lda wR13
        sta wR1
        lda wR7
        cmp wR9
        bcc _D3C0
        lda wR8
        sta wR0
        lda $7FEDA8
        tax
        lda wR6
        cmp wR8
        bcs _D3AA
        jsr rsBattleSceneStepEdgeDownPreDec
        bra _D3AD


        _D3AA
        jsr rsBattleSceneStepEdgeUpPreInc

        _D3AD
        txa
        sta $7FEDA8
        lda wR7
        sec
        sbc wR5
        xba
        and #$00FF
        inc a
        sta wR2
        bra _D3E8


        _D3C0
        lda wR6
        sta wR0
        lda $7FEDA6
        tax
        lda wR8
        cmp wR6
        bcs _D3D4
        jsr rsBattleSceneStepEdgeDownPreDec
        bra _D3D7


        _D3D4
        jsr rsBattleSceneStepEdgeUpPreInc

        _D3D7
        txa
        sta $7FEDA6
        lda wR9
        sec
        sbc wR5
        xba
        and #$00FF
        inc a
        sta wR2

        _D3E8
        ply
        plx
        rtl

        .databank 0

        ; 96/D3EB

        ; Unreachable: it follows a return.
        rep #$20

    .endsection Unsorted96D2D7Section


    .section Unsorted96D3EDSection

      .al
      .xl

      rsBattleSceneStepEdgeUpPreInc ; 96/D3ED

        .al
        .xl
        .autsiz
        .databank ?

        lda wR1
        pha
        lda wR0

        _D3F2
        clc
        adc #1,s
        sta $7FEDAA,x
        inc x
        inc x
        dec y
        bne _D3F2
        pla
        rts

        .databank 0

        ; 96/D400

        ; Unreachable: it follows a return.
        rep #$20

    .endsection Unsorted96D3EDSection


    .section Unsorted96D402Section

      .al
      .xl

      rsBattleSceneStepEdgeDownPreDec ; 96/D402

        .al
        .xl
        .autsiz
        .databank ?

        lda wR1
        pha
        lda wR0

        _D407
        sec
        sbc #1,s
        sta $7FEDAA,x
        inc x
        inc x
        dec y
        bne _D407
        pla
        rts

        .databank 0

        ; 96/D415

        ; Unreachable: it follows a return.
        rep #$20

    .endsection Unsorted96D402Section


    .section Unsorted96D417Section

      .al
      .xl

      rsBattleSceneStepEdgeUpPostInc ; 96/D417

        .al
        .xl
        .autsiz
        .databank ?

        lda wR1
        pha
        lda wR0

        _D41C
        sta $7FEDAA,x
        clc
        adc #1,s
        inc x
        inc x
        dec y
        bne _D41C
        pla
        rts

        .databank 0

        ; 96/D42A

        ; Unreachable: it follows a return.
        rep #$20

    .endsection Unsorted96D417Section


    .section Unsorted96D42CSection

      .al
      .xl

      rsBattleSceneStepEdgeDownPostDec ; 96/D42C

        .al
        .xl
        .autsiz
        .databank ?

        lda wR1
        pha
        lda wR0

        _D431
        sta $7FEDAA,x
        sec
        sbc #1,s
        inc x
        inc x
        dec y
        bne _D431
        pla
        rts

        .databank 0

        ; 96/D43F

      rsBattleSceneRunGradientWindowScript ; 96/D43F

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda bBattleSceneWindowEffect2Flag
        bit #$0001
        bne _D44E
        jml _D5D8


        _D44E
        lda $7FED5D
        and #$00FF
        beq _D464
        sep #$20
        dec a
        sta $7FED5D
        rep #$20
        jml _D5D8


        _D464
        sep #$20
        lda bBattleSceneWindowEffect2Flag
        eor #$02
        sta bBattleSceneWindowEffect2Flag
        rep #$20
        bit #$0002
        bne _D47C
        lda #$0000
        bra _D47F


        _D47C
        lda #$01C0

        _D47F
        sta $7FEDA6
        inc a
        sta $7FEDA8
        lda $7FED5F
        sta lR18+1
        lda $7FED61
        sta lR18
        clc
        adc #$000F
        sta $7FED61
        ldy #$0000
        lda [lR18],y
        xba
        and #$00FF
        cmp #$00FF
        bne _D4B1
        jsr rsBattleSceneEndPolygonWindow
        jml _D5D8


        _D4B1
        cmp #$00FD
        bne _D4BD
        jsr rsBattleSceneStopPolygonWindow
        jml _D5D8


        _D4BD
        sep #$20
        ldy #$0000
        lda [lR18],y
        sta $7FED5D
        inc y
        rep #$20
        lda [lR18],y
        sta $7FF5AA
        inc y
        inc y
        lda [lR18],y
        bit #$007F
        beq _D52A
        bit #$0080
        bne _D4F4
        and #$007F
        sta wR2
        asl a
        pha
        lda $7FEDA6
        tax
        clc
        adc #1,s
        sta $7FEDA6
        bra _D507


        _D4F4
        and #$007F
        sta wR2
        asl a
        pha
        lda $7FEDA8
        tax
        clc
        adc #1,s
        sta $7FEDA8

        _D507
        pla
        lda [lR18],y
        and #$FF00
        pha
        inc y
        inc y
        lda [lR18],y
        sta wR0
        pla
        inc y
        inc y

        _D517
        sep #$20
        xba
        sta $7FE51D,x
        xba
        rep #$20
        inc x
        inc x
        clc
        adc wR0
        dec wR2
        bne _D517

        _D52A
        lda [lR18],y
        bit #$007F
        beq _D581
        bit #$0080
        bne _D54B
        and #$007F
        sta wR2
        asl a
        pha
        lda $7FEDA6
        tax
        clc
        adc #1,s
        sta $7FEDA6
        bra _D55E


        _D54B
        and #$007F
        sta wR2
        asl a
        pha
        lda $7FEDA8
        tax
        clc
        adc #1,s
        sta $7FEDA8

        _D55E
        pla
        lda [lR18],y
        and #$FF00
        pha
        inc y
        inc y
        lda [lR18],y
        sta wR0
        pla
        inc y
        inc y

        _D56E
        sep #$20
        xba
        sta $7FE51D,x
        xba
        rep #$20
        inc x
        inc x
        clc
        adc wR0
        dec wR2
        bne _D56E

        _D581
        lda [lR18],y
        bit #$007F
        beq _D5D8
        bit #$0080
        bne _D5A2
        and #$007F
        sta wR2
        asl a
        pha
        lda $7FEDA6
        tax
        clc
        adc #1,s
        sta $7FEDA6
        bra _D5B5


        _D5A2
        and #$007F
        sta wR2
        asl a
        pha
        lda $7FEDA8
        tax
        clc
        adc #1,s
        sta $7FEDA8

        _D5B5
        pla
        lda [lR18],y
        and #$FF00
        pha
        inc y
        inc y
        lda [lR18],y
        sta wR0
        pla
        inc y
        inc y

        _D5C5
        sep #$20
        xba
        sta $7FE51D,x
        xba
        rep #$20
        inc x
        inc x
        clc
        adc wR0
        dec wR2
        bne _D5C5

        _D5D8
        ply
        plx
        rts

        .databank 0

        ; 96/D5DB

    .endsection Unsorted96D42CSection


    .section Unsorted96D5DBSection

      .al
      .xl

      rlBattleSceneBuildGradientWindowHDMA ; 96/D5DB

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7FED5C
        and #$0003
        cmp #$0003
        bne _D657
        ldx #$0000
        lda $7FED6C
        and #$00FF
        sta $7FED7A,x
        lda #$E51B
        sta $7FED7B,x
        inc x
        inc x
        inc x
        lda $7FF5AA
        and #$00FF
        beq _D617
        sta $7FED7A,x
        lda #$E51B
        sta $7FED7B,x
        inc x
        inc x
        inc x

        _D617
        lda $7FF5AB
        and #$00FF
        beq _D63F
        ora #$0080
        sta $7FED7A,x
        lda bBattleSceneWindowEffect2Flag
        bit #$0002
        bne _D635
        lda #$E51D
        bra _D638


        _D635
        lda #$E6DD

        _D638
        sta $7FED7B,x
        inc x
        inc x
        inc x

        _D63F
        lda #$0001
        sta $7FED7A,x
        lda #$E51B
        sta $7FED7B,x
        sep #$20
        lda #$00
        sta $7FED7D,x
        rep #$20

        _D657
        plx
        rtl

        .databank 0

        ; 96/D659

    .endsection Unsorted96D5DBSection


    .section Unsorted96D659Section

      .al
      .xl

      rlFreeBattleScenePaletteSlots ; 96/D659

        .al
        .xl
        .autsiz
        .databank ?

        ; Frees all ten palette effect slots (type $80) and clears wBattleScenePaletteBrighten.

        phx
        ldx #$0000

        _D65D
        sep #$20
        lda #$80
        sta aBattleScenePaletteSlots.Type,x
        rep #$20
        txa
        clc
        adc #$000A
        tax
        cpx #$0064
        bcc _D65D
        lda #$0000
        sta wBattleScenePaletteBrighten
        plx
        rtl

        .databank 0

        ; 96/D67B

    .endsection Unsorted96D659Section


    .section Unsorted96D67BSection

      .al
      .xl

      rlBattleSceneSavePalette ; 96/D67B

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$0000
        sta aBGPaletteBuffer,b
        ldx #$0000

        _D685
        lda aBGPaletteBuffer,b,x
        sta $7FFE00,x
        inc x
        inc x
        cpx #$0200
        bcc _D685
        plx
        rtl

        .databank 0

        ; 96/D695

    .endsection Unsorted96D67BSection


    .section Unsorted96D695Section

      .al
      .xl

      rlBattleSceneRunPaletteEffects ; 96/D695

        .al
        .xl
        .autsiz
        .databank ?

        ; Every frame: for each of the ten palette effect slots (aBattleScenePaletteSlots) still running, counts down its timer, and when it is out runs its type (aBattleScenePaletteEffectTypes).

        phx
        phy
        ldx #$0000

        _D69A
        lda aBattleScenePaletteSlots.Type,x
        bit #$0080
        bne _D6CE
        lda aBattleScenePaletteSlots.Timer,x
        and #$00FF
        beq _D6BB
        sep #$20
        lda aBattleScenePaletteSlots.Timer,x
        dec a
        sta aBattleScenePaletteSlots.Timer,x
        rep #$20
        bra _D6CE


        _D6BB
        lda aBattleScenePaletteSlots.Type,x
        and #$003F
        sta wR0
        txy
        phx
        lda wR0
        asl a
        tax
        jsr (aBattleScenePaletteEffectTypes,x)
        plx

        _D6CE
        txa
        clc
        adc #$000A
        tax
        txy
        cpx #$0064
        bcc _D69A
        ply
        plx
        rtl

        .databank 0

        ; 96/D6DD

    .endsection Unsorted96D695Section


    .section Table96D6DDSection

      .al
      .xl

      aBattleScenePaletteEffectTypes ; 96/D6DD

        ; Jump table of rlBattleSceneRunPaletteEffects.
        .word <>rsBattleScenePaletteEffectFrames
        .word <>rsBattleScenePaletteEffectScrollIn
        .word <>rsBattleScenePaletteEffectScrollInBack
        .word <>rsBattleScenePaletteEffectRotate
        .word <>rsBattleScenePaletteEffectRotateBack
        .word <>rsBattleScenePaletteEffectFadeToBlack
        .word <>rsBattleScenePaletteEffectFadeToWhite
        .word <>rsBattleScenePaletteEffectFadeToColors
        .word <>rsBattleScenePaletteEffectBlack
        .word <>rsBattleScenePaletteEffectWhite
        .word <>rsBattleScenePaletteEffectSetColors
        .word <>rsBattleScenePaletteEffectRestore
        .word <>rsBattleScenePaletteEffectScrollInBright

    .endsection Table96D6DDSection


    .section Unsorted96D6F7Section

      .al
      .xl

      rsBattleScenePaletteEffectFrames ; 96/D6F7

        .al
        .xl
        .autsiz
        .databank ?

        ; Type 0: writes the next frame of Count colors from the data; a byte $80 | n before it sets the delay, $FE goes back to the start, $FF ends.

        phx
        tyx
        lda $7FFD9C,x
        sta lR18+1
        lda aBattleScenePaletteSlots.Position,x
        sta lR18

        _D705
        ldy #$0000
        lda [lR18],y
        and #$00FF
        cmp #$00FF
        beq _D721
        cmp #$00FE
        beq _D726
        bit #$0080
        beq _D733
        and #$007F
        bra _D730


        _D721
        jsr rsBattleSceneEndPaletteEffect
        bra _D772


        _D726
        lda aBattleScenePaletteSlots.Data,x
        sta aBattleScenePaletteSlots.Position,x
        bra _D705


        _D730
        inc y
        bra _D737


        _D733
        lda aBattleScenePaletteSlots.Delay,x

        _D737
        sep #$20
        sta aBattleScenePaletteSlots.Timer,x
        sta aBattleScenePaletteSlots.Delay,x
        rep #$20
        lda aBattleScenePaletteSlots.Count,x
        and #$00FF
        sta wR0
        phx
        lda aBattleScenePaletteSlots.FirstColor,x
        and #$00FF
        asl a
        tax
        lda wR0

        _D758
        pha
        lda [lR18],y
        xba
        sta aBGPaletteBuffer,b,x
        inc x
        inc x
        inc y
        inc y
        pla
        dec a
        bne _D758
        plx
        tya
        clc
        adc aBattleScenePaletteSlots.Position,x
        sta aBattleScenePaletteSlots.Position,x

        _D772
        plx
        rts

        .databank 0

        ; 96/D774

    .endsection Unsorted96D6F7Section


    .section Unsorted96D774Section

      .al
      .xl

      rsBattleScenePaletteEffectScrollIn ; 96/D774

        .al
        .xl
        .autsiz
        .databank ?

        ; Type 1: moves the colors down by one and puts the next color of the data (read as in type 0) in the last place.

        tyx
        phx
        lda aBattleScenePaletteSlots.Count,x
        and #$00FF
        dec a
        bne _D78B
        lda aBattleScenePaletteSlots.FirstColor,x
        and #$00FF
        asl a
        tax
        bra _D7A3


        _D78B
        pha
        lda aBattleScenePaletteSlots.FirstColor,x
        and #$00FF
        asl a
        tax
        ply

        _D796
        lda @l $000102,x
        sta @l aBGPaletteBuffer,x
        inc x
        inc x
        dec y
        bne _D796

        _D7A3
        phx
        lda #3,s
        tax

        _D7A7
        lda $7FFD9C,x
        sta lR18+1
        lda aBattleScenePaletteSlots.Position,x
        sta lR18
        ldy #$0000
        lda [lR18],y
        and #$00FF
        cmp #$00FF
        beq _D7CF
        cmp #$00FE
        beq _D7D6
        bit #$0080
        beq _D7E3
        and #$007F
        bra _D7E0


        _D7CF
        jsr rsBattleSceneEndPaletteEffect
        plx
        plx
        bra _D807


        _D7D6
        lda aBattleScenePaletteSlots.Data,x
        sta aBattleScenePaletteSlots.Position,x
        bra _D7A7


        _D7E0
        inc y
        bra _D7E7


        _D7E3
        lda aBattleScenePaletteSlots.Delay,x

        _D7E7
        sep #$20
        sta aBattleScenePaletteSlots.Timer,x
        sta aBattleScenePaletteSlots.Delay,x
        rep #$20
        plx
        lda [lR18],y
        xba
        sta aBGPaletteBuffer,b,x
        inc y
        inc y
        plx
        tya
        clc
        adc aBattleScenePaletteSlots.Position,x
        sta aBattleScenePaletteSlots.Position,x

        _D807
        rts

        .databank 0

        ; 96/D808

      rsBattleScenePaletteEffectScrollInBack ; 96/D808

        .al
        .xl
        .autsiz
        .databank ?

        ; Type 2: as type 1, the colors moved up and the new one in the first place.

        tyx
        phx
        lda aBattleScenePaletteSlots.Count,x
        and #$00FF
        dec a
        bne _D81F
        lda aBattleScenePaletteSlots.FirstColor,x
        and #$00FF
        asl a
        tax
        bra _D83A


        _D81F
        pha
        lda aBattleScenePaletteSlots.FirstColor,x
        and #$00FF
        clc
        adc #1,s
        asl a
        tax
        ply

        _D82D
        lda @l wJoy2RepeatTimer,x
        sta @l aBGPaletteBuffer,x
        dec x
        dec x
        dec y
        bne _D82D

        _D83A
        phx
        lda #3,s
        tax

        _D83E
        lda $7FFD9C,x
        sta lR18+1
        lda aBattleScenePaletteSlots.Position,x
        sta lR18
        ldy #$0000
        lda [lR18],y
        and #$00FF
        cmp #$00FF
        beq _D866
        cmp #$00FE
        beq _D86D
        bit #$0080
        beq _D87A
        and #$007F
        bra _D877


        _D866
        jsr rsBattleSceneEndPaletteEffect
        plx
        plx
        bra _D89E


        _D86D
        lda aBattleScenePaletteSlots.Data,x
        sta aBattleScenePaletteSlots.Position,x
        bra _D83E


        _D877
        inc y
        bra _D87E


        _D87A
        lda aBattleScenePaletteSlots.Delay,x

        _D87E
        sep #$20
        sta aBattleScenePaletteSlots.Timer,x
        sta aBattleScenePaletteSlots.Delay,x
        rep #$20
        plx
        lda [lR18],y
        xba
        sta aBGPaletteBuffer,b,x
        inc y
        inc y
        plx
        tya
        clc
        adc aBattleScenePaletteSlots.Position,x
        sta aBattleScenePaletteSlots.Position,x

        _D89E
        rts

        .databank 0

        ; 96/D89F

    .endsection Unsorted96D774Section


    .section Unsorted96D89FSection

      .al
      .xl

      rsBattleScenePaletteEffectRotate ; 96/D89F

        .al
        .xl
        .autsiz
        .databank ?

        ; Type 3: rotates the colors down by one every Value frames.

        tyx
        sep #$20
        lda aBattleScenePaletteSlots.Delay,x
        sta aBattleScenePaletteSlots.Timer,x
        rep #$20
        lda aBattleScenePaletteSlots.Count,x
        and #$00FF
        dec a
        pha
        lda aBattleScenePaletteSlots.FirstColor,x
        and #$00FF
        asl a
        tax
        ply
        lda @l aBGPaletteBuffer,x
        pha

        _D8C4
        lda @l $000102,x
        sta @l aBGPaletteBuffer,x
        inc x
        inc x
        dec y
        bne _D8C4
        pla
        sta @l aBGPaletteBuffer,x
        rts

        .databank 0

        ; 96/D8D7

    .endsection Unsorted96D89FSection


    .section Unsorted96D8D7Section

      .al
      .xl

      rsBattleScenePaletteEffectRotateBack ; 96/D8D7

        .al
        .xl
        .autsiz
        .databank ?

        ; Type 4: rotates the colors up by one every Value frames.

        tyx
        sep #$20
        lda aBattleScenePaletteSlots.Delay,x
        sta aBattleScenePaletteSlots.Timer,x
        rep #$20
        lda aBattleScenePaletteSlots.Count,x
        and #$00FF
        dec a
        pha
        lda aBattleScenePaletteSlots.FirstColor,x
        and #$00FF
        clc
        adc #1,s
        asl a
        tax
        ply
        lda @l aBGPaletteBuffer,x
        pha

        _D8FF
        lda @l wJoy2RepeatTimer,x
        sta @l aBGPaletteBuffer,x
        dec x
        dec x
        dec y
        bne _D8FF
        pla
        sta @l aBGPaletteBuffer,x
        rts

        .databank 0

        ; 96/D912

    .endsection Unsorted96D8D7Section


    .section Unsorted96D912Section

      .al
      .xl

      rsBattleScenePaletteEffectFadeToBlack ; 96/D912

        .al
        .xl
        .autsiz
        .databank ?

        ; Type 5: takes one step off every channel every Value frames (rlBattleSceneDarkenColorsStep); ends at black.

        tyx
        sep #$20
        lda aBattleScenePaletteSlots.Delay,x
        sta aBattleScenePaletteSlots.Timer,x
        rep #$20
        lda aBattleScenePaletteSlots.Count,x
        and #$00FF
        tay
        lda aBattleScenePaletteSlots.FirstColor,x
        and #$00FF
        jsl rlBattleSceneDarkenColorsStep
        bcc _D937
        jsr rsBattleSceneEndPaletteEffect

        _D937
        rts

        .databank 0

        ; 96/D938

    .endsection Unsorted96D912Section


    .section Unsorted96D938Section

      .al
      .xl

      rsBattleScenePaletteEffectFadeToWhite ; 96/D938

        .al
        .xl
        .autsiz
        .databank ?

        ; Type 6: adds one step to every channel every Value frames (rlBattleSceneBrightenColorsStep); ends at white.

        tyx
        sep #$20
        lda aBattleScenePaletteSlots.Delay,x
        sta aBattleScenePaletteSlots.Timer,x
        rep #$20
        lda aBattleScenePaletteSlots.Count,x
        and #$00FF
        tay
        lda aBattleScenePaletteSlots.FirstColor,x
        and #$00FF
        jsl rlBattleSceneBrightenColorsStep
        bcc _D95D
        jsr rsBattleSceneEndPaletteEffect

        _D95D
        rts

        .databank 0

        ; 96/D95E

    .endsection Unsorted96D938Section


    .section Unsorted96D95ESection

      .al
      .xl

      rsBattleScenePaletteEffectFadeToColors ; 96/D95E

        .al
        .xl
        .autsiz
        .databank ?

        ; Type 7: moves every channel one step toward the data's colors every Value frames (rlBattleSceneStepColorsToward); ends when they match.

        tyx
        sep #$20
        lda aBattleScenePaletteSlots.Delay,x
        sta aBattleScenePaletteSlots.Timer,x
        rep #$20
        lda aBattleScenePaletteSlots.Data,x
        sta lR18
        lda $7FFD9C,x
        sta lR18+1
        lda aBattleScenePaletteSlots.Count,x
        and #$00FF
        tay
        lda aBattleScenePaletteSlots.FirstColor,x
        and #$00FF
        jsl rlBattleSceneStepColorsToward
        bcc _D98F
        jsr rsBattleSceneEndPaletteEffect

        _D98F
        rts

        .databank 0

        ; 96/D990

    .endsection Unsorted96D95ESection


    .section Unsorted96D990Section

      .al
      .xl

      rsBattleScenePaletteEffectBlack ; 96/D990

        .al
        .xl
        .autsiz
        .databank ?

        ; Type 8: sets the colors black and ends.

        tyx
        phx
        lda aBattleScenePaletteSlots.Count,x
        and #$00FF
        tay
        lda aBattleScenePaletteSlots.FirstColor,x
        and #$00FF
        asl a
        tax
        lda #$0000

        _D9A6
        sta @l aBGPaletteBuffer,x
        inc x
        inc x
        dec y
        bne _D9A6
        plx
        jsr rsBattleSceneEndPaletteEffect
        rts

        .databank 0

        ; 96/D9B4

    .endsection Unsorted96D990Section


    .section Unsorted96D9B4Section

      .al
      .xl

      rsBattleScenePaletteEffectWhite ; 96/D9B4

        .al
        .xl
        .autsiz
        .databank ?

        ; Type 9: sets the colors white and ends.

        tyx
        phx
        lda aBattleScenePaletteSlots.Count,x
        and #$00FF
        tay
        lda aBattleScenePaletteSlots.FirstColor,x
        and #$00FF
        asl a
        tax
        lda #$7FFF

        _D9CA
        sta @l aBGPaletteBuffer,x
        inc x
        inc x
        dec y
        bne _D9CA
        plx
        jsr rsBattleSceneEndPaletteEffect
        rts

        .databank 0

        ; 96/D9D8

    .endsection Unsorted96D9B4Section


    .section Unsorted96D9D8Section

      .al
      .xl

      rsBattleScenePaletteEffectSetColors ; 96/D9D8

        .al
        .xl
        .autsiz
        .databank ?

        ; Type 10: copies the colors from the data and ends.

        tyx
        phx
        lda aBattleScenePaletteSlots.Data,x
        sta lR18
        lda $7FFD9C,x
        sta lR18+1
        lda aBattleScenePaletteSlots.Count,x
        and #$00FF
        pha
        lda aBattleScenePaletteSlots.FirstColor,x
        and #$00FF
        asl a
        tax
        pla
        ldy #$0000

        _D9FB
        pha
        lda [lR18],y
        sta @l aBGPaletteBuffer,x
        inc x
        inc x
        inc y
        inc y
        pla
        dec a
        bne _D9FB
        plx
        jsr rsBattleSceneEndPaletteEffect
        rts

        .databank 0

        ; 96/DA0F

    .endsection Unsorted96D9D8Section


    .section Unsorted96DA0FSection

      .al
      .xl

      rsBattleScenePaletteEffectRestore ; 96/DA0F

        .al
        .xl
        .autsiz
        .databank ?

        ; Type 11: copies the colors back from the saved palette at $7FFE00 and ends.

        tyx
        phx
        lda aBattleScenePaletteSlots.Count,x
        and #$00FF
        tay
        lda aBattleScenePaletteSlots.FirstColor,x
        and #$00FF
        asl a
        tax

        _DA22
        lda $7FFE00,x
        sta @l aBGPaletteBuffer,x
        inc x
        inc x
        dec y
        bne _DA22
        plx
        jsr rsBattleSceneEndPaletteEffect
        rts

        .databank 0

        ; 96/DA34

    .endsection Unsorted96DA0FSection


    .section Unsorted96DA34Section

      .al
      .xl

      rsBattleScenePaletteEffectScrollInBright ; 96/DA34

        .al
        .xl
        .autsiz
        .databank ?

        ; Type 12: as type 1, the new color brightened by wBattleScenePaletteBrighten steps (rsBattleSceneBrightenColorBy).

        tyx
        phx
        lda aBattleScenePaletteSlots.Count,x
        and #$00FF
        dec a
        bne _DA4B
        lda aBattleScenePaletteSlots.FirstColor,x
        and #$00FF
        asl a
        tax
        bra _DA63


        _DA4B
        pha
        lda aBattleScenePaletteSlots.FirstColor,x
        and #$00FF
        asl a
        tax
        ply

        _DA56
        lda @l $000102,x
        sta @l aBGPaletteBuffer,x
        inc x
        inc x
        dec y
        bne _DA56

        _DA63
        phx
        lda #3,s
        tax

        _DA67
        lda $7FFD9C,x
        sta lR18+1
        lda aBattleScenePaletteSlots.Position,x
        sta lR18
        ldy #$0000
        lda [lR18],y
        and #$00FF
        cmp #$00FF
        beq _DA8F
        cmp #$00FE
        beq _DA96
        bit #$0080
        beq _DAA3
        and #$007F
        bra _DAA0


        _DA8F
        jsr rsBattleSceneEndPaletteEffect
        plx
        plx
        bra _DACA


        _DA96
        lda aBattleScenePaletteSlots.Data,x
        sta aBattleScenePaletteSlots.Position,x
        bra _DA67


        _DAA0
        inc y
        bra _DAA7


        _DAA3
        lda aBattleScenePaletteSlots.Delay,x

        _DAA7
        sep #$20
        sta aBattleScenePaletteSlots.Timer,x
        sta aBattleScenePaletteSlots.Delay,x
        rep #$20
        plx
        lda [lR18],y
        xba
        jsr rsBattleSceneBrightenColorBy
        sta aBGPaletteBuffer,b,x
        inc y
        inc y
        plx
        tya
        clc
        adc aBattleScenePaletteSlots.Position,x
        sta aBattleScenePaletteSlots.Position,x

        _DACA
        rts

        .databank 0

        ; 96/DACB

    .endsection Unsorted96DA34Section


    .section Unsorted96DACBSection

      .al
      .xl

      rsBattleSceneBrightenColorBy ; 96/DACB

        ; TRACE: stack-args
        .al
        .xl
        .autsiz
        .databank ?

        ; Returns color A with each channel raised by wBattleScenePaletteBrighten steps (aBattleSceneBrightenRedSteps, aBattleSceneBrightenGreenSteps, aBattleSceneBrightenBlueSteps by channel), each at most 31.

        phx
        pha
        and #$7C00
        pha
        lda #3,s
        and #$03E0
        pha
        lda #5,s
        and #$001F
        pha
        lda wBattleScenePaletteBrighten
        asl a
        tax
        lda aBattleSceneBrightenRedSteps,x
        clc
        adc #1,s
        cmp #$0020
        bcc _DAF2
        lda #$001F

        _DAF2
        sta #7,s
        lda aBattleSceneBrightenGreenSteps,x
        clc
        adc #3,s
        cmp #$0400
        bcc _DB03
        lda #$03E0

        _DB03
        ora #7,s
        sta #7,s
        lda aBattleSceneBrightenBlueSteps,x
        clc
        adc #5,s
        cmp #$8000
        bcc _DB16
        lda #$7C00

        _DB16
        ora #7,s
        sta #7,s
        pla
        pla
        pla
        pla
        plx
        rts

        .databank 0

        ; 96/DB20

    .endsection Unsorted96DACBSection


    .section Unsorted96DB20Section

      .al
      .xl

      rlBattleSceneStopPaletteSlot ; 96/DB20

        .al
        .xl
        .autsiz
        .databank ?

        phx
        and #$00FF
        sta wR10
        lda #$000A
        sta wR11
        jsl rlUnsignedMultiply16By16
        ldx wR12
        jsr rsBattleSceneEndPaletteEffect
        plx
        rtl

        .databank 0

        ; 96/DB36

      rsBattleSceneEndPaletteEffect ; 96/DB36

        .al
        .xl
        .autsiz
        .databank ?

        ; X = the slot: stops it (bit 7 of its type) and, when it was waited for (bit 6), counts down bBattleSceneScriptWaitCount.

        sep #$20
        lda aBattleScenePaletteSlots.Type,x
        ora #$80
        sta aBattleScenePaletteSlots.Type,x
        lda aBattleScenePaletteSlots.Type,x
        bit #$40
        beq _DB55
        lda bBattleSceneScriptWaitCount
        beq _DB51
        dec a

        _DB51
        sta bBattleSceneScriptWaitCount

        _DB55
        rep #$20
        rts

        .databank 0

        ; 96/DB58

    .endsection Unsorted96DB20Section


    .section Unsorted96DC7CSection

      .al
      .xl

      rlBattleSceneGetWeaponScript ; 96/DC7C

        .al
        .xl
        .autsiz
        .databank ?

        ; X = 0 or $43: A = the battle scene script of the combatant's weapon from aBattleSceneWeaponScripts (the second column at wBattleDistance 3 or more), 0 for a weapon not listed.

        phx
        cpx #$0000
        bne _DC87
        ldx #$0000
        bra _DC8A


        _DC87
        ldx #$000E

        _DC8A
        lda aBattleSceneCombatant1.Weapon,b,x
        pha
        ldx #$0000

        _DC91
        lda aBattleSceneWeaponScripts,x
        cmp #$FFFF
        bne _DCA1
        lda #$0000
        sta #1,s
        bra _DCC5


        _DCA1
        and #$00FF
        cmp #1,s
        beq _DCAD
        inc x
        inc x
        inc x
        bra _DC91


        _DCAD
        lda wBattleDistance
        cmp #$0003
        bcs _DCBC
        lda aBattleSceneWeaponScripts+1,x
        bra _DCC0


        _DCBC
        lda aBattleSceneWeaponScripts+2,x

        _DCC0
        and #$00FF
        sta #1,s

        _DCC5
        pla
        plx
        rtl

        .databank 0

        ; 96/DCC8

    .endsection Unsorted96DC7CSection


    .section Unreferenced96DCC8Section

      .al
      .xl

      rlBattleSceneScriptInitTileWipe ; 96/DCC8

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000
        lda #$40FC

        _DCCF
        sta $7FF5B0,x
        inc x
        inc x
        cpx #$0080
        bcc _DCCF
        lda #$00FC
        sta aBattleSceneBG2AnimSlot.wX
        lda #(`rlBattleSceneScriptStepTileWipe)<<8
        sta lBattleSceneScriptRoutine+1
        lda #<>rlBattleSceneScriptStepTileWipe
        sta lBattleSceneScriptRoutine
        plx
        rtl

        .databank 0

        ; 96/DCF1

      rlBattleSceneScriptStepTileWipe ; 96/DCF1

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        phb
        ldx #$0000
        ldy #$0000
        sep #$20
        lda #$99
        pha
        plb
        .databank $99

        _DD00
        lda $7FF5F0,x
        sec
        sbc aBattleSceneEffectSpeedTable,y
        sta $7FF5F0,x
        inc x
        inc x
        inc y
        cpy #$0020
        bcc _DD00
        rep #$20
        lda $7FF5F0
        and #$00FF
        sta aBattleSceneBG2AnimSlot.wY
        lda #$7F00
        sta lR18+1
        lda #$F5B0
        sta lR18
        ldy #$7000
        lda #$0080
        jsl rlBattleSceneQueueUpload
        plb
        .databank $99
        ply
        plx
        rtl

        .databank 0

        ; 96/DD39

    .endsection Unreferenced96DCC8Section
    .section Unsorted96DD39Section

      .al
      .xl

      rlBattleSceneResetBGScrolls ; 96/DD39

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$00
        sta aBattleSceneBGAnimSlots.bFlags
        sta aBattleSceneBGAnimSlots.bFlags
        sta aBattleSceneBGAnimSlots.bFlags
        rep #$20
        lda #$0000
        sta aBattleSceneBGAnimSlots.wOffsetX
        sta aBattleSceneBGAnimSlots.wOffsetY
        sta aBattleSceneBG2AnimSlot.wOffsetX
        sta aBattleSceneBG2AnimSlot.wOffsetY
        sta aBattleSceneBG3AnimSlot.wOffsetX
        sta aBattleSceneBG3AnimSlot.wOffsetY
        lda #$FFFF
        sta wBattleSceneBGScrollScriptOffset
        rtl

        .databank 0

        ; 96/DD6E

    .endsection Unsorted96DD39Section


    .section Unsorted96DD6ESection

      .al
      .xl

      rlBattleSceneUpdateBGScrolls ; 96/DD6E

        .al
        .xl
        .autsiz
        .databank ?

        lda bBattleSceneBackgroundFlags
        bit #$0002
        bne _DDD9
        lda aBattleSceneBGAnimSlots.bFlags
        bit #$0040
        beq _DDAB
        lda aBattleSceneBGAnimSlots.wX
        and #$03FF
        sec
        sbc #$0100
        jsl rlBattleSceneNoOp1
        eor #$FFFF
        inc a
        sec
        sbc aBattleSceneBGAnimSlots.wOffsetX
        sta wBufferBG1HOFS
        lda aBattleSceneBGAnimSlots.wY
        eor #$FFFF
        inc a
        sec
        sbc aBattleSceneBGAnimSlots.wOffsetY
        sta wBufferBG1VOFS
        bra _DDD9


        _DDAB
        lda aBattleSceneBGAnimSlots.wX
        and #$03FF
        sec
        sbc wBattleSceneCameraX
        sec
        sbc #$0100
        jsl rlBattleSceneNoOp1
        eor #$FFFF
        inc a
        sec
        sbc aBattleSceneBGAnimSlots.wOffsetX
        sta wBufferBG1HOFS
        lda aBattleSceneBGAnimSlots.wY
        eor #$FFFF
        inc a
        sec
        sbc aBattleSceneBGAnimSlots.wOffsetY
        sta wBufferBG1VOFS

        _DDD9
        lda bBattleSceneBackgroundFlags
        bit #$0004
        beq _DDF8
        lda aBattleSceneBG2AnimSlot.wX
        sec
        sbc aBattleSceneBG2AnimSlot.wOffsetX
        sta wBufferBG2HOFS
        lda aBattleSceneBG2AnimSlot.wY
        sec
        sbc aBattleSceneBG2AnimSlot.wOffsetY
        sta wBufferBG2VOFS

        _DDF8
        lda bBattleSceneBackgroundFlags
        bit #$0008
        bne _DE6E
        lda bBufferBGMODE
        and #$0007
        cmp #$0002
        beq _DE6E
        lda bBattleSceneBG3Mode
        and #$00FF
        cmp #$0004
        beq _DE1C
        cmp #$0003
        bne _DE23

        _DE1C
        lda #$0000
        sta wBufferBG3HOFS
        bra _DE6E


        _DE23
        lda aBattleSceneBG3AnimSlot.bFlags
        bit #$0040
        beq _DE44
        lda aBattleSceneBG3AnimSlot.wX
        sec
        sbc aBattleSceneBG3AnimSlot.wOffsetX
        sta wBufferBG3HOFS
        lda aBattleSceneBG3AnimSlot.wY
        sec
        sbc aBattleSceneBG3AnimSlot.wOffsetY
        sta wBufferBG3VOFS
        bra _DE6E


        _DE44
        lda aBattleSceneBG3AnimSlot.wX
        and #$03FF
        sec
        sbc wBattleSceneCameraX
        sec
        sbc #$0100
        eor #$FFFF
        inc a
        sec
        sbc aBattleSceneBG3AnimSlot.wOffsetX
        sta wBufferBG3HOFS
        lda aBattleSceneBG3AnimSlot.wY
        eor #$FFFF
        inc a
        sec
        sbc aBattleSceneBG3AnimSlot.wOffsetY
        sta wBufferBG3VOFS

        _DE6E
        rtl

        .databank 0

        ; 96/DE6F

      rlBattleSceneRunBGAnimSlots ; 96/DE6F

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        ldx #$0000

        _DE74
        lda aBattleSceneBGAnimSlots.bFlags,x
        bit #$0080
        beq _DE98
        and #$001F
        sec
        sbc #$0011
        bcc _DE98
        sta wR0
        txy
        phx
        phb
        php
        phk
        plb
        .databank $96
        lda wR0
        asl a
        tax
        jsr (aBattleSceneBGAnimSlotHandlers,x)
        plp
        plb
        .databank $96
        plx

        _DE98
        txa
        clc
        adc #$0015
        tax
        cpx #$003F
        bcc _DE74
        jsl rlBattleSceneStepBGScrollScript
        ply
        plx
        rtl

        .databank 0

        ; 96/DEAA

    .endsection Unsorted96DD6ESection


    .section Table96DEAASection

      .al
      .xl

      aBattleSceneBGAnimSlotHandlers ; 96/DEAA

        ; Jump table of rlBattleSceneRunBGAnimSlots.
        .word <>rsBattleSceneStepBGSlotMove
        .word <>rsBattleSceneStepBGSlotIdle
        .word <>rsBattleSceneStepBGSlotMove2
        .word <>rsBattleSceneStepBGSlotUntilOffscreen
        .word <>rsBattleSceneStepBGSlotPathY
        .word <>rlBattleSceneStepBGScrollScript
        .word <>rsBattleSceneStepBGSlotMove3
        .word <>rsBattleSceneStepBGSlotMove2
        .word <>rsBattleSceneStepBGSlotGravity
        .word <>rsBattleSceneStepBGSlotBounce
        .word <>rsBattleSceneStepBGSlotMove2

    .endsection Table96DEAASection


    .section Unsorted96DFBBSection

      .al
      .xl

      rsBattleSceneClearBGSlotOffset ; 96/DFBB

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta aBattleSceneBGAnimSlots.wOffsetX,x
        sta aBattleSceneBGAnimSlots.wOffsetY,x
        rts

        .databank 0

        ; 96/DFC7

    .endsection Unsorted96DFBBSection


    .section Unsorted96DFC7Section

      .al
      .xl

      rsBattleSceneInitBGSlotAttacker ; 96/DFC7

        .al
        .xl
        .autsiz
        .databank ?

        phx
        tyx
        jsr rsBattleSceneClearBGSlotOffset
        sep #$20
        lda aBattleSceneBGAnimSlots.bFlags,x
        and #$7F
        and #$BF
        sta aBattleSceneBGAnimSlots.bFlags,x
        rep #$20
        phx
        lda #$0000
        sta aBattleSceneBGAnimSlots.bXFraction,x
        ldx wBattleAnimationAttackerOffset,b
        lda wBattleAnimationX,b,x
        clc
        adc #$0100
        clc
        adc #$0100
        plx
        sta aBattleSceneBGAnimSlots.wX,x
        phx
        lda #$0000
        sta aBattleSceneBGAnimSlots.bYFraction,x
        ldx wBattleAnimationAttackerOffset,b
        jsl rlBattleAnimationGetHitHeight
        sec
        sbc #$0008
        pha
        lda #$0064
        sec
        sbc #1,s
        sta #1,s
        pla
        clc
        adc #$0080
        plx
        sta aBattleSceneBGAnimSlots.wY,x
        plx
        rts

        .databank 0

        ; 96/E01F

    .endsection Unsorted96DFC7Section


    .section Unsorted96E01FSection

      .al
      .xl

      rsBattleSceneInitBGSlotAttackerAlt ; 96/E01F

        .al
        .xl
        .autsiz
        .databank ?

        phx
        tyx
        jsr rsBattleSceneClearBGSlotOffset
        sep #$20
        lda aBattleSceneBGAnimSlots.bFlags,x
        and #$7F
        and #$BF
        sta aBattleSceneBGAnimSlots.bFlags,x
        rep #$20
        phx
        lda #$0000
        sta aBattleSceneBGAnimSlots.bXFraction,x
        ldx wBattleAnimationAttackerOffset,b
        lda wBattleAnimationX,b,x
        clc
        adc #$0100
        clc
        adc #$0100
        plx
        sta aBattleSceneBGAnimSlots.wX,x
        phx
        lda #$0000
        sta aBattleSceneBGAnimSlots.bYFraction,x
        ldx wBattleAnimationAttackerOffset,b
        jsl rlBattleAnimationGetHitHeight
        sec
        sbc #$0008
        pha
        lda #$0064
        sec
        sbc #1,s
        sta #1,s
        pla
        clc
        adc #$0080
        plx
        sta aBattleSceneBGAnimSlots.wY,x
        plx
        rts

        .databank 0

        ; 96/E077

    .endsection Unsorted96E01FSection


    .section Unsorted96E077Section

      .al
      .xl

      rsBattleSceneInitBGSlotAttackerLow ; 96/E077

        .al
        .xl
        .autsiz
        .databank ?

        phx
        tyx
        jsr rsBattleSceneClearBGSlotOffset
        sep #$20
        lda aBattleSceneBGAnimSlots.bFlags,x
        and #$7F
        and #$BF
        sta aBattleSceneBGAnimSlots.bFlags,x
        rep #$20
        phx
        lda #$0000
        sta aBattleSceneBGAnimSlots.bXFraction,x
        ldx wBattleAnimationAttackerOffset,b
        lda wBattleAnimationX,b,x
        clc
        adc #$0100
        clc
        adc #$0080
        plx
        sta aBattleSceneBGAnimSlots.wX,x
        phx
        lda #$0000
        sta aBattleSceneBGAnimSlots.bYFraction,x
        ldx wBattleAnimationAttackerOffset,b
        jsl rlBattleAnimationGetHitHeight
        clc
        adc #$0018
        pha
        lda #$0064
        sec
        sbc #1,s
        sta #1,s
        pla
        clc
        adc #$0080
        plx
        sta aBattleSceneBGAnimSlots.wY,x
        plx
        rts

        .databank 0

        ; 96/E0CF

    .endsection Unsorted96E077Section


    .section Unsorted96E0CFSection

      .al
      .xl

      rsBattleSceneInitBGSlotAttackerLowFar ; 96/E0CF

        .al
        .xl
        .autsiz
        .databank ?

        phx
        tyx
        jsr rsBattleSceneClearBGSlotOffset
        sep #$20
        lda aBattleSceneBGAnimSlots.bFlags,x
        and #$7F
        and #$BF
        sta aBattleSceneBGAnimSlots.bFlags,x
        rep #$20
        phx
        lda #$0000
        sta aBattleSceneBGAnimSlots.bXFraction,x
        ldx wBattleAnimationAttackerOffset,b
        lda wBattleAnimationX,b,x
        clc
        adc #$0100
        clc
        adc #$0100
        plx
        sta aBattleSceneBGAnimSlots.wX,x
        phx
        lda #$0000
        sta aBattleSceneBGAnimSlots.bYFraction,x
        ldx wBattleAnimationAttackerOffset,b
        jsl rlBattleAnimationGetHitHeight
        clc
        adc #$0018
        pha
        lda #$0064
        sec
        sbc #1,s
        sta #1,s
        pla
        clc
        adc #$0080
        plx
        sta aBattleSceneBGAnimSlots.wY,x
        plx
        rts

        .databank 0

        ; 96/E127

    .endsection Unsorted96E0CFSection


    .section Unsorted96E127Section

      .al
      .xl

      rsBattleSceneInitBGSlotDefender ; 96/E127

        .al
        .xl
        .autsiz
        .databank ?

        phx
        tyx
        jsr rsBattleSceneClearBGSlotOffset
        sep #$20
        lda aBattleSceneBGAnimSlots.bFlags,x
        and #$7F
        and #$BF
        sta aBattleSceneBGAnimSlots.bFlags,x
        rep #$20
        phx
        lda #$0000
        sta aBattleSceneBGAnimSlots.bXFraction,x
        ldx wBattleAnimationDefenderOffset,b
        lda wBattleAnimationX,b,x
        clc
        adc #$0100
        clc
        adc #$0080
        plx
        sta aBattleSceneBGAnimSlots.wX,x
        phx
        lda #$0000
        sta aBattleSceneBGAnimSlots.bYFraction,x
        ldx wBattleAnimationDefenderOffset,b
        jsl rlBattleAnimationGetHitHeight
        sec
        sbc #$0008
        pha
        lda #$0064
        sec
        sbc #1,s
        sta #1,s
        pla
        plx
        sta aBattleSceneBGAnimSlots.wY,x
        plx
        rts

        .databank 0

        ; 96/E17B

    .endsection Unsorted96E127Section


    .section Unsorted96E17BSection

      .al
      .xl

      rsBattleSceneInitBGSlotDefenderOffset ; 96/E17B

        .al
        .xl
        .autsiz
        .databank ?

        phx
        tyx
        jsr rsBattleSceneClearBGSlotOffset
        sep #$20
        lda aBattleSceneBGAnimSlots.bFlags,x
        and #$7F
        and #$BF
        sta aBattleSceneBGAnimSlots.bFlags,x
        rep #$20
        phx
        lda #$0000
        sta aBattleSceneBGAnimSlots.bXFraction,x
        ldx wBattleAnimationDefenderOffset,b
        lda wBattleAnimationX,b,x
        clc
        adc #$0100
        clc
        adc #$0100
        plx
        sta aBattleSceneBGAnimSlots.wX,x
        phx
        lda #$0000
        sta aBattleSceneBGAnimSlots.bYFraction,x
        ldx wBattleAnimationDefenderOffset,b
        jsl rlBattleAnimationGetHitHeight
        sec
        sbc #$0008
        pha
        lda #$0064
        sec
        sbc #1,s
        sta #1,s
        pla
        clc
        adc #$0080
        plx
        sta aBattleSceneBGAnimSlots.wY,x
        plx
        rts

        .databank 0

        ; 96/E1D3

    .endsection Unsorted96E17BSection


    .section Unsorted96E1D3Section

      .al
      .xl

      rsBattleSceneInitBGSlotFixedCenter ; 96/E1D3

        .al
        .xl
        .autsiz
        .databank ?

        phx
        tyx
        jsr rsBattleSceneClearBGSlotOffset
        sep #$20
        lda aBattleSceneBGAnimSlots.bFlags,x
        and #$7F
        ora #$40
        sta aBattleSceneBGAnimSlots.bFlags,x
        rep #$20
        lda #$0000
        sta aBattleSceneBGAnimSlots.bXFraction,x
        lda #$0100
        sta aBattleSceneBGAnimSlots.wX,x
        lda #$0000
        sta aBattleSceneBGAnimSlots.bYFraction,x
        lda #$0048
        clc
        adc #$0080
        sta aBattleSceneBGAnimSlots.wY,x
        plx
        rts

        .databank 0

        ; 96/E20A

    .endsection Unsorted96E1D3Section


    .section Unsorted96E20ASection

      .al
      .xl

      rsBattleSceneInitBGSlotFixedRight ; 96/E20A

        .al
        .xl
        .autsiz
        .databank ?

        phx
        tyx
        jsr rsBattleSceneClearBGSlotOffset
        sep #$20
        lda aBattleSceneBGAnimSlots.bFlags,x
        and #$7F
        ora #$40
        sta aBattleSceneBGAnimSlots.bFlags,x
        rep #$20
        lda #$0000
        sta aBattleSceneBGAnimSlots.bXFraction,x
        lda #$0100
        clc
        adc #$0080
        sta aBattleSceneBGAnimSlots.wX,x
        lda #$0000
        sta aBattleSceneBGAnimSlots.bYFraction,x
        lda #$0048
        clc
        adc #$0080
        sta aBattleSceneBGAnimSlots.wY,x
        plx
        rts

        .databank 0

        ; 96/E245

    .endsection Unsorted96E20ASection


    .section Unsorted96E245Section

      .al
      .xl

      rsBattleSceneInitBGSlotFixedOrigin ; 96/E245

        .al
        .xl
        .autsiz
        .databank ?

        phx
        tyx
        jsr rsBattleSceneClearBGSlotOffset
        sep #$20
        lda aBattleSceneBGAnimSlots.bFlags,x
        and #$7F
        ora #$40
        sta aBattleSceneBGAnimSlots.bFlags,x
        rep #$20
        lda #$0000
        sta aBattleSceneBGAnimSlots.bXFraction,x
        lda #$0100
        sta aBattleSceneBGAnimSlots.wX,x
        lda #$0000
        sta aBattleSceneBGAnimSlots.bYFraction,x
        sta aBattleSceneBGAnimSlots.wY,x
        plx
        rts

        .databank 0

        ; 96/E275

    .endsection Unsorted96E245Section


    .section Unsorted96E275Section

      .al
      .xl

      rsBattleSceneInitBGSlotDefenderScreen ; 96/E275

        .al
        .xl
        .autsiz
        .databank ?

        phx
        tyx
        jsl rlBattleSceneClearBGScrollScript
        jsr rsBattleSceneClearBGSlotOffset
        sep #$20
        lda aBattleSceneBGAnimSlots.bFlags,x
        and #$7F
        ora #$40
        sta aBattleSceneBGAnimSlots.bFlags,x
        rep #$20
        phx
        lda #$0000
        sta aBattleSceneBGAnimSlots.bXFraction,x
        ldx wBattleAnimationDefenderOffset,b
        lda wBattleAnimationX,b,x
        sec
        sbc wBattleSceneCameraX
        clc
        adc #$0100
        clc
        adc #$0030
        plx
        sta aBattleSceneBGAnimSlots.wX,x
        phx
        lda #$0000
        sta aBattleSceneBGAnimSlots.bYFraction,x
        ldx wBattleAnimationDefenderOffset,b
        sec
        sbc #$0008
        pha
        lda #$0064
        sec
        sbc #1,s
        sta #1,s
        pla
        plx
        sta aBattleSceneBGAnimSlots.wY,x
        plx
        rts

        .databank 0

        ; 96/E2CE

    .endsection Unsorted96E275Section


    .section Unsorted96E2CESection

      .al
      .xl

      rsBattleSceneInitBGSlotDefenderGround ; 96/E2CE

        .al
        .xl
        .autsiz
        .databank ?

        phx
        tyx
        jsr rsBattleSceneClearBGSlotOffset
        sep #$20
        lda aBattleSceneBGAnimSlots.bFlags,x
        and #$7F
        and #$BF
        sta aBattleSceneBGAnimSlots.bFlags,x
        rep #$20
        phx
        lda #$0000
        sta aBattleSceneBGAnimSlots.bXFraction,x
        ldx wBattleAnimationDefenderOffset,b
        lda wBattleAnimationX,b,x
        clc
        adc #$0100
        clc
        adc #$0100
        plx
        sta aBattleSceneBGAnimSlots.wX,x
        lda #$0000
        sta aBattleSceneBGAnimSlots.bYFraction,x
        lda #$0064
        clc
        adc #$0080
        sta aBattleSceneBGAnimSlots.wY,x
        plx
        rts

        .databank 0

        ; 96/E312

    .endsection Unsorted96E2CESection


    .section Unsorted96E312Section

      .al
      .xl

      rsBattleSceneInitBGSlotAttackerGround ; 96/E312

        .al
        .xl
        .autsiz
        .databank ?

        phx
        tyx
        jsr rsBattleSceneClearBGSlotOffset
        sep #$20
        lda aBattleSceneBGAnimSlots.bFlags,x
        and #$7F
        and #$BF
        sta aBattleSceneBGAnimSlots.bFlags,x
        rep #$20
        phx
        lda #$0000
        sta aBattleSceneBGAnimSlots.bXFraction,x
        ldx wBattleAnimationAttackerOffset,b
        lda wBattleAnimationX,b,x
        clc
        adc #$0100
        clc
        adc #$0100
        plx
        sta aBattleSceneBGAnimSlots.wX,x
        lda #$0000
        sta aBattleSceneBGAnimSlots.bYFraction,x
        lda #$0064
        clc
        adc #$0088
        sta aBattleSceneBGAnimSlots.wY,x
        plx
        rts

        .databank 0

        ; 96/E356

    .endsection Unsorted96E312Section


    .section Unsorted96E356Section

      .al
      .xl

      rsBattleSceneInitBGSlotFixedLow ; 96/E356

        .al
        .xl
        .autsiz
        .databank ?

        phx
        tyx
        jsr rsBattleSceneClearBGSlotOffset
        sep #$20
        lda aBattleSceneBGAnimSlots.bFlags,x
        and #$7F
        ora #$40
        sta aBattleSceneBGAnimSlots.bFlags,x
        rep #$20
        lda #$0000
        sta aBattleSceneBGAnimSlots.bXFraction,x
        lda #$0100
        sta aBattleSceneBGAnimSlots.wX,x
        lda #$0000
        sta aBattleSceneBGAnimSlots.bYFraction,x
        lda #$0048
        clc
        adc #$00F0
        sta aBattleSceneBGAnimSlots.wY,x
        plx
        rts

        .databank 0

        ; 96/E38D

    .endsection Unsorted96E356Section


    .section Unsorted96E38DSection

      .al
      .xl

      rsBattleSceneInitBGSlotCamera ; 96/E38D

        .al
        .xl
        .autsiz
        .databank ?

        phx
        tyx
        jsr rsBattleSceneClearBGSlotOffset
        sep #$20
        lda aBattleSceneBGAnimSlots.bFlags,x
        and #$7F
        ora #$40
        sta aBattleSceneBGAnimSlots.bFlags,x
        rep #$20
        lda bBattleSceneCameraXFraction
        sta aBattleSceneBGAnimSlots.bXFraction,x
        lda wBattleSceneCameraX
        sta aBattleSceneBGAnimSlots.wX,x
        lda #$0000
        sta aBattleSceneBGAnimSlots.bYFraction,x
        lda wBattleSceneCameraY
        sec
        sbc #$0080
        and #$00FF
        sta aBattleSceneBGAnimSlots.wY,x
        plx
        rts

        .databank 0

        ; 96/E3CA

    .endsection Unsorted96E38DSection


    .section Unsorted96E3CASection

      .al
      .xl

      rsBattleSceneStopBGSlot ; 96/E3CA

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        tyx
        sep #$20
        lda aBattleSceneBGAnimSlots.bFlags,x
        and #$7F
        sta aBattleSceneBGAnimSlots.bFlags,x
        rep #$20
        lda #$FFFF
        sta wBattleSceneBGScrollScriptOffset
        ply
        plx
        rts

        .databank 0

        ; 96/E3E5

    .endsection Unsorted96E3CASection


    .section Unsorted96E3E5Section

      .al
      .xl

      rsBattleSceneInitBGSlotDefenderLow ; 96/E3E5

        .al
        .xl
        .autsiz
        .databank ?

        phx
        tyx
        jsr rsBattleSceneClearBGSlotOffset
        sep #$20
        lda aBattleSceneBGAnimSlots.bFlags,x
        and #$7F
        and #$BF
        sta aBattleSceneBGAnimSlots.bFlags,x
        rep #$20
        phx
        lda #$0000
        sta aBattleSceneBGAnimSlots.bXFraction,x
        ldx wBattleAnimationDefenderOffset,b
        lda wBattleAnimationX,b,x
        clc
        adc #$0100
        clc
        adc #$0100
        plx
        sta aBattleSceneBGAnimSlots.wX,x
        lda #$0000
        sta aBattleSceneBGAnimSlots.bYFraction,x
        lda #$0064
        clc
        adc #$0080
        clc
        adc #$000A
        sta aBattleSceneBGAnimSlots.wY,x
        plx
        rts

        .databank 0

        ; 96/E42D

    .endsection Unsorted96E3E5Section


    .section Unsorted96E42DSection

      .al
      .xl

      rsBattleSceneInitBGSlotFromArgs ; 96/E42D

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        tyx
        sep #$20
        lda aBattleSceneBGAnimSlots.bFlags,x
        and #$7F
        ora #$40
        sta aBattleSceneBGAnimSlots.bFlags,x
        rep #$20
        ldy #$0002
        lda #$0000
        sta aBattleSceneBGAnimSlots.bXFraction,x
        lda [lR18],y
        sta aBattleSceneBGAnimSlots.wX,x
        ldy #$0004
        lda #$0000
        sta aBattleSceneBGAnimSlots.bYFraction,x
        lda [lR18],y
        sta aBattleSceneBGAnimSlots.wY,x
        ply
        plx
        rts

        .databank 0

        ; 96/E463

    .endsection Unsorted96E42DSection


    .section Unsorted96E463Section

      .al
      .xl

      rsBattleSceneAimBGSlotAtAttacker ; 96/E463

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        tyx
        sep #$20
        lda aBattleSceneBGAnimSlots.bFlags,x
        and #$BF
        sta aBattleSceneBGAnimSlots.bFlags,x
        rep #$20
        phx
        ldx wBattleAnimationAttackerOffset,b
        lda wBattleAnimationX,b,x
        sta wR0
        lda bBattleAnimationY,b,x
        and #$00FF
        sta wR1
        plx
        ldy #$0002
        lda [lR18],y
        and #$00FF
        jsl rlBattleSceneCalcBGSlotVelocity
        lda #$0000
        sta aBattleSceneBGAnimSlots.wYVelocity,x
        ply
        plx
        rts

        .databank 0

        ; 96/E49C

    .endsection Unsorted96E463Section


    .section Unsorted96E49CSection

      .al
      .xl

      rsBattleSceneBGSlotNoOp1 ; 96/E49C

        .al
        .xl
        .autsiz
        .databank ?

        rts

        .databank 0

        ; 96/E49D

    .endsection Unsorted96E49CSection


    .section Unsorted96E49DSection

      .al
      .xl

      rsBattleSceneAimBGSlotAtDefenderHit ; 96/E49D

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        tyx
        sep #$20
        lda aBattleSceneBGAnimSlots.bFlags,x
        and #$BF
        sta aBattleSceneBGAnimSlots.bFlags,x
        rep #$20
        phx
        ldx wBattleAnimationDefenderOffset,b
        lda wBattleAnimationX,b,x
        sta wR0
        jsl rlBattleAnimationGetHitHeight
        sec
        sbc #$0008
        clc
        adc bBattleAnimationY,b,x
        and #$00FF
        sta wR1
        plx
        ldy #$0002
        lda [lR18],y
        and #$00FF
        jsl rlBattleSceneCalcBGSlotVelocity
        ply
        plx
        rts

        .databank 0

        ; 96/E4D8

    .endsection Unsorted96E49DSection


    .section Unsorted96E4D8Section

      .al
      .xl

      rsBattleSceneAimBGSlotAtDefenderTop ; 96/E4D8

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        tyx
        sep #$20
        lda aBattleSceneBGAnimSlots.bFlags,x
        and #$BF
        sta aBattleSceneBGAnimSlots.bFlags,x
        rep #$20
        phx
        ldx wBattleAnimationDefenderOffset,b
        lda wBattleAnimationX,b,x
        sta wR0
        lda bBattleAnimationY,b,x
        and #$00FF
        sec
        sbc #$0010
        sta wR1
        plx
        ldy #$0002
        lda [lR18],y
        and #$00FF
        jsl rlBattleSceneCalcBGSlotVelocity
        ply
        plx
        rts

        .databank 0

        ; 96/E50E

    .endsection Unsorted96E4D8Section


    .section Unsorted96E50ESection

      .al
      .xl

      rsBattleSceneBGSlotNoOp2 ; 96/E50E

        .al
        .xl
        .autsiz
        .databank ?

        rts

        .databank 0

        ; 96/E50F

    .endsection Unsorted96E50ESection


    .section Unsorted96E50FSection

      .al
      .xl

      rsBattleSceneAimBGSlotWithPath ; 96/E50F

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        tyx
        sep #$20
        lda aBattleSceneBGAnimSlots.bFlags,x
        and #$BF
        sta aBattleSceneBGAnimSlots.bFlags,x
        rep #$20
        phx
        ldx wBattleAnimationDefenderOffset,b
        lda wBattleAnimationX,b,x
        sta wR0
        jsl rlBattleAnimationGetHitHeight
        sec
        sbc #$0008
        clc
        adc bBattleAnimationY,b,x
        and #$00FF
        sta wR1
        plx
        ldy #$0002
        lda [lR18],y
        and #$00FF
        jsl rlBattleSceneCalcBGSlotVelocity
        inc y
        lda [lR18],y
        sta $7FE483,x
        inc y
        lda [lR18],y
        sta $7FE484,x
        ply
        plx
        rts

        .databank 0

        ; 96/E558

    .endsection Unsorted96E50FSection


    .section Unsorted96E558Section

      .al
      .xl

      rsBattleSceneStartBGScrollScript ; 96/E558

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        tyx
        sep #$20
        lda aBattleSceneBGAnimSlots.bFlags,x
        and #$7F
        sta aBattleSceneBGAnimSlots.bFlags,x
        lda #$00
        sta $7FE482,x
        rep #$20
        ldy #$0002
        lda [lR18],y
        sta $7FE483,x
        inc y
        lda [lR18],y
        sta $7FE484,x
        lda #$0000
        sta $7FE473
        txa
        sta wBattleSceneBGScrollScriptOffset
        ply
        plx
        rts

        .databank 0

        ; 96/E58E

    .endsection Unsorted96E558Section


    .section Unsorted96E58ESection

      .al
      .xl

      rsBattleSceneSetBGSlotVelocity ; 96/E58E

        ; TRACE: stack-args
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        tyx
        sep #$20
        lda aBattleSceneBGAnimSlots.bFlags,x
        ora #$80
        ora #$40
        sta aBattleSceneBGAnimSlots.bFlags,x
        rep #$20
        ldy #$0002
        lda [lR18],y
        phx
        pha
        ldx wBattleAnimationAttackerOffset,b
        lda wBattleAnimationBaseTile,b,x
        bit #$8000
        beq _E5BB
        lda #1,s
        eor #$FFFF
        inc a
        sta #1,s

        _E5BB
        pla
        plx
        and #$00FF
        xba
        sta aBattleSceneBGAnimSlots.wXVelocity,x
        inc y
        lda [lR18],y
        and #$00FF
        xba
        sta aBattleSceneBGAnimSlots.wYVelocity,x
        inc y
        lda [lR18],y
        sta $7FE480,x
        ply
        plx
        rts

        .databank 0

        ; 96/E5DA

    .endsection Unsorted96E58ESection


    .section Unsorted96E5DASection

      .al
      .xl

      rsBattleSceneSetBGSlotVelocityOffset1 ; 96/E5DA

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        jsr rsBattleSceneSetBGSlotVelocity
        lda aBattleSceneBGAnimSlots.bXFraction
        sta $7FE4B4
        lda aBattleSceneBGAnimSlots.wX
        clc
        adc #$0060
        sta $7FE4B5
        ply
        plx
        rts

        .databank 0

        ; 96/E5F6

    .endsection Unsorted96E5DASection


    .section Unsorted96E5F6Section

      .al
      .xl

      rsBattleSceneSetBGSlotVelocityOffset2 ; 96/E5F6

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        jsr rsBattleSceneSetBGSlotVelocity
        lda aBattleSceneBGAnimSlots.bXFraction
        sta $7FE4B4
        lda aBattleSceneBGAnimSlots.wX
        clc
        adc #$0060
        sta $7FE4B5
        ply
        plx
        rts

        .databank 0

        ; 96/E612

    .endsection Unsorted96E5F6Section


    .section Unsorted96E612Section

      .al
      .xl

      rsBattleSceneAimBGSlotAtDefenderFlat ; 96/E612

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        tyx
        sep #$20
        lda aBattleSceneBGAnimSlots.bFlags,x
        and #$BF
        sta aBattleSceneBGAnimSlots.bFlags,x
        rep #$20
        phx
        ldx wBattleAnimationDefenderOffset,b
        lda wBattleAnimationX,b,x
        sta wR0
        jsl rlBattleAnimationGetHitHeight
        sec
        sbc #$0008
        clc
        adc bBattleAnimationY,b,x
        and #$00FF
        sta wR1
        plx
        ldy #$0002
        lda [lR18],y
        and #$00FF
        jsl rlBattleSceneCalcBGSlotVelocity
        lda #$0000
        sta aBattleSceneBGAnimSlots.wYVelocity,x
        ply
        plx
        rts

        .databank 0

        ; 96/E654

      rlBattleSceneCalcBGSlotVelocity ; 96/E654

        ; Reads the stack above its return address, but in the emulator log every
        ; caller continues right after the call: no inline arguments.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        and #$00FF
        pha
        lda wR0
        clc
        adc #$0100
        clc
        adc #$0100
        sec
        sbc aBattleSceneBGAnimSlots.wX,x
        bpl _E67A
        eor #$FFFF
        inc a
        sta wR13
        lda #1,s
        xba
        eor #$FFFF
        inc a
        bra _E67F


        _E67A
        sta wR13
        lda #1,s
        xba

        _E67F
        sta aBattleSceneBGAnimSlots.wXVelocity,x
        lda #1,s
        sta wR14
        jsl rlUnsignedDivide16By16R13
        lda wR13
        sta $7FE480,x
        sta wR14
        lda wR1
        and #$00FF
        pha
        lda #$0064
        sec
        sbc #1,s
        sta #1,s
        pla
        clc
        adc #$0080
        sec
        sbc aBattleSceneBGAnimSlots.wY,x
        bpl _E6BB
        and #$00FF
        xba
        sta wR13
        jsl rlUnsignedDivide16By16R13
        lda wR13
        bra _E6CF


        _E6BB
        eor #$FFFF
        inc a
        and #$00FF
        xba
        sta wR13
        jsl rlUnsignedDivide16By16R13
        lda wR13
        eor #$FFFF
        inc a

        _E6CF
        sta aBattleSceneBGAnimSlots.wYVelocity,x
        pla
        ply
        plx
        rtl

        .databank 0

        ; 96/E6D7

    .endsection Unsorted96E612Section


    .section Unsorted96E6D7Section

      .al
      .xl

      rsBattleSceneStepBGSlotMove ; 96/E6D7

        .al
        .xl
        .autsiz
        .databank ?

        phx
        tyx
        jsl rlBattleSceneApplyBGSlotVelocity
        lda $7FE480,x
        bne _E70B
        sep #$20
        lda aBattleSceneBGAnimSlots.bFlags,x
        and #$7F
        sta aBattleSceneBGAnimSlots.bFlags,x
        rep #$20
        lda aBattleSceneBGAnimSlots.bFlags,x
        bit #$0020
        beq _E709
        sep #$20
        lda bBattleSceneScriptWaitCount
        beq _E703
        dec a

        _E703
        sta bBattleSceneScriptWaitCount
        rep #$20

        _E709
        bra _E710


        _E70B
        dec a
        sta $7FE480,x

        _E710
        plx
        rts

        .databank 0

        ; 96/E712

    .endsection Unsorted96E6D7Section


    .section Unsorted96E712Section

      .al
      .xl

      rsBattleSceneStepBGSlotIdle ; 96/E712

        .al
        .xl
        .autsiz
        .databank ?

        phx
        tyx
        plx
        rts

        .databank 0

        ; 96/E716

    .endsection Unsorted96E712Section


    .section Unsorted96E716Section

      .al
      .xl

      rsBattleSceneStepBGSlotMove2 ; 96/E716

        .al
        .xl
        .autsiz
        .databank ?

        phx
        tyx
        jsl rlBattleSceneApplyBGSlotVelocity
        lda $7FE480,x
        bne _E74A
        sep #$20
        lda aBattleSceneBGAnimSlots.bFlags,x
        and #$7F
        sta aBattleSceneBGAnimSlots.bFlags,x
        rep #$20
        lda aBattleSceneBGAnimSlots.bFlags,x
        bit #$0020
        beq _E748
        sep #$20
        lda bBattleSceneScriptWaitCount
        beq _E742
        dec a

        _E742
        sta bBattleSceneScriptWaitCount
        rep #$20

        _E748
        bra _E74F


        _E74A
        dec a
        sta $7FE480,x

        _E74F
        plx
        rts

        .databank 0

        ; 96/E751

      rsBattleSceneStepBGSlotUntilOffscreen ; 96/E751

        .al
        .xl
        .autsiz
        .databank ?

        phx
        tyx
        jsl rlBattleSceneApplyBGSlotVelocity
        lda aBattleSceneBGAnimSlots.wX,x
        sec
        sbc wBattleSceneCameraX
        sec
        sbc #$0100
        cmp #$00C0
        bcc _E76E
        cmp #$0240
        bcc _E796

        _E76E
        sep #$20
        lda aBattleSceneBGAnimSlots.bFlags,x
        and #$7F
        sta aBattleSceneBGAnimSlots.bFlags,x
        rep #$20
        lda aBattleSceneBGAnimSlots.bFlags,x
        bit #$0020
        beq _E794
        sep #$20
        lda bBattleSceneScriptWaitCount
        beq _E78E
        dec a

        _E78E
        sta bBattleSceneScriptWaitCount
        rep #$20

        _E794
        bra _E796


        _E796
        plx
        rts

        .databank 0

        ; 96/E798

    .endsection Unsorted96E716Section


    .section Unsorted96E798Section

      .al
      .xl

      rsBattleSceneStepBGSlotPathY ; 96/E798

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        tyx
        jsl rlBattleSceneApplyBGSlotVelocity
        lda $7FE483,x
        sta lR18
        lda $7FE484,x
        sta lR18+1
        ldy #$0000
        lda [lR18],y
        and #$00FF
        cmp #$0080
        beq _E7CD
        bit #$0080
        beq _E7C0
        ora #$FF00

        _E7C0
        sta aBattleSceneBGAnimSlots.wOffsetY,x
        lda $7FE483,x
        inc a
        sta $7FE483,x

        _E7CD
        lda $7FE480,x
        bne _E7FB
        sep #$20
        lda aBattleSceneBGAnimSlots.bFlags,x
        and #$7F
        sta aBattleSceneBGAnimSlots.bFlags,x
        rep #$20
        lda aBattleSceneBGAnimSlots.bFlags,x
        bit #$0020
        beq _E7F9
        sep #$20
        lda bBattleSceneScriptWaitCount
        beq _E7F3
        dec a

        _E7F3
        sta bBattleSceneScriptWaitCount
        rep #$20

        _E7F9
        bra _E800


        _E7FB
        dec a
        sta $7FE480,x

        _E800
        ply
        plx
        rts

        .databank 0

        ; 96/E803

    .endsection Unsorted96E798Section


    .section Unsorted96E803Section

      .al
      .xl

      rlBattleSceneStepBGScrollScript ; 96/E803

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda wBattleSceneBGScrollScriptOffset
        cmp #$FFFF
        bne _E812
        jml _E8DE


        _E812
        tax
        lda $7FE482,x
        and #$00FF
        beq _E820
        jml _E8D5


        _E820
        lda $7FE483,x
        sta lR18
        lda $7FE484,x
        sta lR18+1
        ldy #$0000
        lda [lR18],y
        and #$00FF
        cmp #$00FF
        beq _E863
        cmp #$00FE
        beq _E884
        inc y
        sep #$20
        sta $7FE482,x
        rep #$20
        lda [lR18],y
        sta aBattleSceneBGAnimSlots.wOffsetX,x
        inc y
        inc y
        lda [lR18],y
        sta aBattleSceneBGAnimSlots.wOffsetY,x
        lda $7FE483,x
        clc
        adc #$0005
        sta $7FE483,x
        bra _E8DE


        _E863
        lda #$FFFF
        sta wBattleSceneBGScrollScriptOffset
        lda aBattleSceneBGAnimSlots.bFlags,x
        bit #$0020
        beq _E882
        sep #$20
        lda bBattleSceneScriptWaitCount
        beq _E87C
        dec a

        _E87C
        sta bBattleSceneScriptWaitCount
        rep #$20

        _E882
        bra _E8DE


        _E884
        lda $7FE473
        beq _E894
        dec a
        sta $7FE473
        beq _E8C5
        inc y
        bra _E8A2


        _E894
        sta $7FE473
        inc y
        lda [lR18],y
        and #$00FF
        sta $7FE473

        _E8A2
        inc y
        lda [lR18],y
        and #$00FF
        bne _E8AD
        lda #$0001

        _E8AD
        pha
        asl a
        asl a
        clc
        adc #1,s
        sta #1,s
        lda $7FE483,x
        sec
        sbc #1,s
        sta $7FE483,x
        pla
        jml _E820


        _E8C5
        lda $7FE483,x
        clc
        adc #$0003
        sta $7FE483,x
        jml _E820


        _E8D5
        dec a
        sep #$20
        sta $7FE482,x
        rep #$20

        _E8DE
        ply
        plx
        rtl

        .databank 0

        ; 96/E8E1

    .endsection Unsorted96E803Section


    .section Unsorted96E8E1Section

      .al
      .xl

      rsBattleSceneStepBGSlotMove3 ; 96/E8E1

        .al
        .xl
        .autsiz
        .databank ?

        phx
        tyx
        jsl rlBattleSceneApplyBGSlotVelocity
        lda $7FE480,x
        bne _E915
        sep #$20
        lda aBattleSceneBGAnimSlots.bFlags,x
        and #$7F
        sta aBattleSceneBGAnimSlots.bFlags,x
        rep #$20
        lda aBattleSceneBGAnimSlots.bFlags,x
        bit #$0020
        beq _E913
        sep #$20
        lda bBattleSceneScriptWaitCount
        beq _E90D
        dec a

        _E90D
        sta bBattleSceneScriptWaitCount
        rep #$20

        _E913
        bra _E91A


        _E915
        dec a
        sta $7FE480,x

        _E91A
        plx
        rts

        .databank 0

        ; 96/E91C

    .endsection Unsorted96E8E1Section


    .section Unsorted96E91CSection

      .al
      .xl

      rsBattleSceneStepBGSlotGravity ; 96/E91C

        .al
        .xl
        .autsiz
        .databank ?

        phx
        tyx
        jsr rsBattleSceneStepBGSlotMirror
        lda aBattleSceneBGAnimSlots.wYVelocity
        clc
        adc #$0010
        sta aBattleSceneBGAnimSlots.wYVelocity
        plx
        rts

        .databank 0

        ; 96/E92F

    .endsection Unsorted96E91CSection


    .section Unsorted96E92FSection

      .al
      .xl

      rsBattleSceneStepBGSlotBounce ; 96/E92F

        .al
        .xl
        .autsiz
        .databank ?

        phx
        tyx
        jsr rsBattleSceneStepBGSlotMirror
        plx
        rts

        .databank 0

        ; 96/E936

    .endsection Unsorted96E92FSection


    .section Unsorted96E936Section

      .al
      .xl

      rsBattleSceneStepBGSlotMirror ; 96/E936

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7FE4B4
        pha
        lda $7FE4B5
        pha
        lda aBattleSceneBGAnimSlots.bXFraction
        pha
        lda aBattleSceneBGAnimSlots.wX
        sta $7FE4B5
        pla
        sta $7FE4B4
        pla
        sta aBattleSceneBGAnimSlots.wX
        pla
        sta aBattleSceneBGAnimSlots.bXFraction
        lda aBattleSceneBGAnimSlots.wXVelocity
        eor #$FFFF
        inc a
        sta aBattleSceneBGAnimSlots.wXVelocity
        sep #$20
        lda bBufferBG1SC
        eor #$08
        sta bBufferBG1SC
        lda bBufferCGADSUB
        eor #$10
        sta bBufferCGADSUB
        lda bBufferW12SEL
        eor #$08
        sta bBufferW12SEL
        rep #$20
        jsl rlBattleSceneApplyBGSlotVelocity
        lda $7FE480,x
        bne _E9B1
        sep #$20
        lda aBattleSceneBGAnimSlots.bFlags,x
        and #$7F
        sta aBattleSceneBGAnimSlots.bFlags,x
        rep #$20
        lda aBattleSceneBGAnimSlots.bFlags,x
        bit #$0020
        beq _E9AF
        sep #$20
        lda bBattleSceneScriptWaitCount
        beq _E9A9
        dec a

        _E9A9
        sta bBattleSceneScriptWaitCount
        rep #$20

        _E9AF
        bra _E9B6


        _E9B1
        dec a
        sta $7FE480,x

        _E9B6
        plx
        rts

        .databank 0

        ; 96/E9B8

    .endsection Unsorted96E936Section


    .section Unsorted96E9B8Section

      .al
      .xl

      rlBattleSceneApplyBGSlotVelocity ; 96/E9B8

        .al
        .xl
        .autsiz
        .databank ?

        lda aBattleSceneBGAnimSlots.wXVelocity,x
        bmi _E9DE
        lda aBattleSceneBGAnimSlots.bXFraction,x
        clc
        adc aBattleSceneBGAnimSlots.wXVelocity,x
        sta aBattleSceneBGAnimSlots.bXFraction,x
        bcc _EA00
        sep #$20
        lda aBattleSceneBGAnimSlots.wX+1,x
        inc a
        and #$03
        sta aBattleSceneBGAnimSlots.wX+1,x
        rep #$20
        bra _EA00


        _E9DE
        eor #$FFFF
        inc a
        pha
        lda aBattleSceneBGAnimSlots.bXFraction,x
        sec
        sbc #1,s
        sta aBattleSceneBGAnimSlots.bXFraction,x
        pla
        bcs _EA00
        sep #$20
        lda aBattleSceneBGAnimSlots.wX+1,x
        dec a
        and #$03
        sta aBattleSceneBGAnimSlots.wX+1,x
        rep #$20

        _EA00
        lda aBattleSceneBGAnimSlots.wYVelocity,x
        cmp #$8000
        bne _EA31
        lda wBattleSceneFrame
        bit #$0001
        beq _EA79
        lda aBattleSceneBGAnimSlots.bYFraction,x
        sec
        sbc #$0100
        sta aBattleSceneBGAnimSlots.bYFraction,x
        bcs _EA79
        sep #$20
        lda aBattleSceneBGAnimSlots.wY+1,x
        dec a
        and #$01
        sta aBattleSceneBGAnimSlots.wY+1,x
        rep #$20
        bra _EA79


        _EA31
        lda aBattleSceneBGAnimSlots.wYVelocity,x
        bmi _EA57
        lda aBattleSceneBGAnimSlots.bYFraction,x
        clc
        adc aBattleSceneBGAnimSlots.wYVelocity,x
        sta aBattleSceneBGAnimSlots.bYFraction,x
        bcc _EA79
        sep #$20
        lda aBattleSceneBGAnimSlots.wY+1,x
        inc a
        and #$01
        sta aBattleSceneBGAnimSlots.wY+1,x
        rep #$20
        bra _EA79


        _EA57
        eor #$FFFF
        inc a
        pha
        lda aBattleSceneBGAnimSlots.bYFraction,x
        sec
        sbc #1,s
        sta aBattleSceneBGAnimSlots.bYFraction,x
        pla
        bcs _EA79
        sep #$20
        lda aBattleSceneBGAnimSlots.wY+1,x
        dec a
        and #$01
        sta aBattleSceneBGAnimSlots.wY+1,x
        rep #$20

        _EA79
        rtl

        .databank 0

        ; 96/EA7A

    .endsection Unsorted96E9B8Section


    .section Unsorted96EA7ASection

      .al
      .xl

      rlBattleSceneClearBGScrollScript ; 96/EA7A

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda wBattleSceneBGScrollScriptOffset
        cmp #$FFFF
        beq _EA97
        tax
        lda #$FFFF
        sta wBattleSceneBGScrollScriptOffset
        lda #$0000
        sta aBattleSceneBGAnimSlots.wOffsetX,x
        sta aBattleSceneBGAnimSlots.wOffsetX,x

        _EA97
        plx
        rtl

        .databank 0

        ; 96/EA99

    .endsection Unsorted96EA7ASection


    .section Unsorted96EA99Section

      .al
      .xl

      rlBattleSceneCommandScrollToCombatant ; 96/EA99

        .al
        .xl
        .autsiz
        .databank ?

        ; Command 15: scrolls the camera to the acting combatant ($0AE9) or its opponent
        ; ($0AEB), by entry arg of the offset table at $97/C2A0.

        phx
        phy
        lda #$9700
        sta lR18+1
        tya
        and #$01FF
        asl a
        clc
        adc #$C2A0
        sta lR18
        ldy #$0000
        lda [lR18],y
        clc
        adc #$C2A0
        sta lR18
        ldy #$0000
        lda [lR18],y
        bit #$0001
        bne _EAC5
        ldx wBattleAnimationAttackerOffset,b
        bra _EAC8


        _EAC5
        ldx wBattleAnimationDefenderOffset,b

        _EAC8
        lda wBattleAnimationX,b,x
        sta wBattleSceneCheckX
        ldy #$0001
        lda [lR18],y
        and #$00FF
        jsl rlBattleSceneCheckOnScreen
        bcs _EAFC
        lda #1,s
        and #$C000
        cmp #$4000
        bne _EAF5
        sep #$20
        lda $7FE1A3
        ora #$01
        sta $7FE1A3
        rep #$20

        _EAF5
        lda #1,s
        jsr rsBattleSceneScriptNextCommand
        bra _EAFF


        _EAFC
        jsr rsBattleSceneScriptNextCommandNoWait

        _EAFF
        ply
        plx
        rtl

        .databank 0

        ; 96/EB02

      rlBattleSceneClearSpellTileSlots ; 96/EB02

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta $7FEC70
        sta $7FEC72
        sta $7FEC74
        sta $7FEC76
        sta $7FEC78
        sta $7FEC7A
        rtl

        .databank 0

        ; 96/EB1E

      rlBattleSceneUpdateSpellTileSlots ; 96/EB1E

        .al
        .xl
        .autsiz
        .databank ?

        phb
        pha
        phx
        sep #$20
        lda #$7F
        pha
        plb
        .databank $7F
        rep #$20
        lda @l $7FEC70
        beq _EB43
        tax
        lda @l $7FEC7C
        sta @l $7FEC94,x
        inc x
        inc x
        inc x
        lda @l $7FEC7C
        sta @l $7FEC94,x

        _EB43
        lda @l $7FEC72
        beq _EB5D
        tax
        lda @l $7FEC7E
        sta @l $7FECA4,x
        inc x
        inc x
        inc x
        lda @l $7FEC7E
        sta @l $7FECA4,x

        _EB5D
        lda @l $7FEC74
        beq _EB77
        tax
        lda @l $7FEC80
        sta @l $7FECB4,x
        inc x
        inc x
        inc x
        lda @l $7FEC80
        sta @l $7FECB4,x

        _EB77
        lda @l $7FEC76
        beq _EB91
        tax
        lda @l $7FEC82
        sta @l $7FECC4,x
        inc x
        inc x
        inc x
        lda @l $7FEC82
        sta @l $7FECC4,x

        _EB91
        lda @l $7FEC78
        beq _EBAB
        tax
        lda @l $7FEC84
        sta @l $7FECD4,x
        inc x
        inc x
        inc x
        lda @l $7FEC84
        sta @l $7FECD4,x

        _EBAB
        lda @l $7FEC7A
        beq _EBC5
        tax
        lda @l $7FEC86
        sta @l $7FECE4,x
        inc x
        inc x
        inc x
        lda @l $7FEC86
        sta @l $7FECE4,x

        _EBC5
        plx
        pla
        plb
        .databank $7F
        rtl

        .databank 0

        ; 96/EBC9

      rlBattleSceneClearBG2Shake ; 96/EBC9

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda $7FF630
        and #$7F
        sta $7FF630
        rep #$20
        lda #$0000
        sta $7FE19F
        sta $7FE1A1
        rtl

        .databank 0

        ; 96/EBE3

    .endsection Unsorted96EA99Section


    .section Unsorted96EBE3Section

      .al
      .xl

      rlBattleSceneStepBG2Shake ; 96/EBE3

        .al
        .xl
        .autsiz
        .databank ?

        phy
        lda $7FF630
        bit #$0080
        beq _EC48

        _EBED
        lda $7FF632
        sta lR18+1
        lda $7FF634
        sta lR18
        ldy #$0000
        lda [lR18],y
        cmp #$8080
        bne _EC0D
        lda $7FF631
        sta $7FF634
        bra _EBED


        _EC0D
        cmp #$8081
        bne _EC18
        jsl rlBattleSceneStopBG2Shake
        bra _EC48


        _EC18
        lda [lR18],y
        and #$00FF
        bit #$0080
        beq _EC25
        ora #$FF00

        _EC25
        sta $7FE19F
        inc y
        lda [lR18],y
        and #$00FF
        bit #$0080
        beq _EC37
        ora #$FF00

        _EC37
        sta $7FE1A1
        inc y
        lda $7FF634
        clc
        adc #$0002
        sta $7FF634

        _EC48
        ply
        rtl

        .databank 0

        ; 96/EC4A

    .endsection Unsorted96EBE3Section


    .section Unsorted96ECDCSection

      .al
      .xl

      rsBattleSceneTintPaletteRed ; 96/ECDC

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000

        _ECE0
        lda $0162,b,x
        pha
        lsr a
        and #$3DE0
        pha
        lda #3,s
        and #$001F
        clc
        adc #$0010
        cmp #$0020
        bcc _ECFA
        lda #$001F

        _ECFA
        ora #1,s
        sta $7FF636,x
        pla
        pla
        inc x
        inc x
        cpx #$005E
        bcc _ECE0
        plx
        rts

        .databank 0

        ; 96/ED0B

    .endsection Unsorted96ECDCSection


    .section Unsorted96ED0BSection

      .al
      .xl

      rsBattleSceneDimPaletteHalf ; 96/ED0B

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000

        _ED0F
        lda $0162,b,x
        lsr a
        and #$3DEF
        sta $7FF636,x
        inc x
        inc x
        cpx #$005E
        bcc _ED0F
        plx
        rts

        .databank 0

        ; 96/ED23

    .endsection Unsorted96ED0BSection


    .section Unsorted96ED23Section

      .al
      .xl

      rsBattleSceneConvertPaletteLuma ; 96/ED23

        ; TRACE: stack-args
        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000

        _ED27
        lda $7FFE62,x
        pha
        and #$001F
        pha
        lda #3,s
        lsr a
        lsr a
        lsr a
        lsr a
        lsr a
        sta #3,s
        and #$001F
        clc
        adc #1,s
        sta #1,s
        lda #3,s
        lsr a
        lsr a
        lsr a
        lsr a
        and #$003E
        clc
        adc #1,s
        lsr a
        and #$FFFE
        phx
        tax
        lda aBattleSceneLumaRamp,x
        plx
        sta $7FF636,x
        pla
        pla
        inc x
        inc x
        cpx #$005E
        bcc _ED27
        plx
        rts

        .databank 0

        ; 96/ED67

    .endsection Unsorted96ED23Section


    .section Unsorted96EDA7Section

      .al
      .xl

      rsBattleSceneConvertPaletteLuma2 ; 96/EDA7

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000

        _EDAB
        lda $7FFE62,x
        jsl rlBattleSceneColorToLuma
        sta $7FF636,x
        inc x
        inc x
        cpx #$005E
        bcc _EDAB
        plx
        rts

        .databank 0

        ; 96/EDC0

    .endsection Unsorted96EDA7Section


    .section Unsorted96EDC0Section

      .al
      .xl

      rlBattleSceneColorToLuma ; 96/EDC0

        ; Reads the stack above its return address, but in the emulator log every
        ; caller continues right after the call: no inline arguments.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        pha
        and #$001F
        pha
        lda #3,s
        lsr a
        lsr a
        lsr a
        lsr a
        lsr a
        sta #3,s
        and #$001F
        clc
        adc #1,s
        sta #1,s
        lda #3,s
        lsr a
        lsr a
        lsr a
        lsr a
        and #$003E
        clc
        adc #1,s
        lsr a
        and #$FFFE
        tax
        lda aBattleSceneGrayRamp,x
        sta #3,s
        pla
        pla
        plx
        rtl

        .databank 0

        ; 96/EDF2

    .endsection Unsorted96EDC0Section


    .section Unsorted96EE32Section

      .al
      .xl

      rsBattleSceneDimSpritePaletteHalf ; 96/EE32

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000

        _EE36
        lda $0282,b,x
        lsr a
        and #$3DEF
        sta $7FF636,x
        inc x
        inc x
        cpx #$007E
        bcc _EE36
        plx
        rts

        .databank 0

        ; 96/EE4A

    .endsection Unsorted96EE32Section


    .section Unsorted96EE4ASection

      .al
      .xl

      rsBattleSceneFillPaletteBlue1 ; 96/EE4A

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000
        lda #$7C00

        _EE51
        sta $7FF636,x
        inc x
        inc x
        cpx #$003E
        bcc _EE51
        plx
        rts

        .databank 0

        ; 96/EE5E

    .endsection Unsorted96EE4ASection


    .section Unsorted96EE5ESection

      .al
      .xl

      rsBattleSceneFillPaletteBlue2 ; 96/EE5E

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000
        lda #$7C00

        _EE65
        sta $0162,b,x
        inc x
        inc x
        cpx #$005E
        bcc _EE65
        plx
        rts

        .databank 0

        ; 96/EE71

    .endsection Unsorted96EE5ESection


    .section Unsorted96EE71Section

      .al
      .xl

      rsBattleSceneDimPaletteQuarter ; 96/EE71

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000

        _EE75
        lda $0162,b,x
        lsr a
        lsr a
        and #$1CE7
        sta $7FF636,x
        inc x
        inc x
        cpx #$005E
        bcc _EE75
        plx
        rts

        .databank 0

        ; 96/EE8A

    .endsection Unsorted96EE71Section


    .section Unsorted96EE8ASection

      .al
      .xl

      rlBattleSceneResetMosaic ; 96/EE8A

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$00
        sta $7FEC67
        rep #$20
        rtl

        .databank 0

        ; 96/EE95

    .endsection Unsorted96EE8ASection


    .section Unsorted96EE95Section

      .al
      .xl

      rlBattleSceneStepMosaic ; 96/EE95

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda $7FEC67
        bit #$0080
        beq _EEBA
        and #$000F
        sta wR0
        phb
        php
        phk
        plb
        .databank $96
        lda wR0
        asl a
        tax
        jsr (aBattleSceneMosaicModeHandlers,x)
        plp
        plb
        .databank $96
        jsl rlBattleSceneBuildMosaicWindowHDMA
        jsl rlBattleSceneCreateMosaicWindowHDMA

        _EEBA
        ply
        plx
        rtl

        .databank 0

        ; 96/EEBD

    .endsection Unsorted96EE95Section


    .section Table96EEBDSection

      .al
      .xl

      aBattleSceneMosaicModeHandlers ; 96/EEBD

        ; Jump table of rlBattleSceneStepMosaic.
        .word <>rsBattleSceneMosaicMode0NoOp
        .word <>rsBattleSceneCalcMosaicBoxBG3
        .word <>rsBattleSceneCalcMosaicBoxBG3Center
        .word <>rsBattleSceneCalcMosaicBoxBG1

    .endsection Table96EEBDSection


    .section Unsorted96EEC5Section

      .al
      .xl

      rsBattleSceneMosaicMode0NoOp ; 96/EEC5

        .al
        .xl
        .autsiz
        .databank ?

        rts

        .databank 0

        ; 96/EEC6

    .endsection Unsorted96EEC5Section


    .section Unsorted96EEC6Section

      .al
      .xl

      rsBattleSceneCalcMosaicBoxBG3 ; 96/EEC6

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FEC6A
        clc
        adc $7FEC6B
        and #$00FF
        sta wR2
        lda aBattleSceneBG3AnimSlot.wX
        and #$03FF
        sec
        sbc wBattleSceneCameraX
        sec
        sbc #$0080
        sta wR0
        lda $7FEC68
        and #$00FF
        pha
        lda wR0
        sec
        sbc #1,s
        sta #1,s
        pla
        cmp #$0200
        bcc _EEFF
        jml _EFA6


        _EEFF
        cmp #$0100
        bcs _EF07
        lda #$0100

        _EF07
        sec
        sbc #$0100
        sep #$20
        sta $7FEC6E
        rep #$20
        lda $7FEC69
        and #$00FF
        clc
        adc wR0
        cmp #$0100
        bcs _EF26
        jml _EFA6


        _EF26
        cmp #$0200
        bcc _EF2E
        lda #$01FF

        _EF2E
        sec
        sbc #$0100
        sep #$20
        sta $7FEC6F
        rep #$20
        lda $7FEC65
        clc
        adc $7FEC66
        and #$00FF
        sta wR1
        lda aBattleSceneBG3AnimSlot.wY
        sta wR0
        lda $7FEC6A
        and #$00FF
        pha
        lda wR0
        sec
        sbc #1,s
        bcs _EF69
        pha
        lda wR2
        sec
        sbc #1,s
        sta wR2
        pla
        lda #$0000

        _EF69
        sta #1,s
        pla
        cmp wR1
        bcs _EFA6
        sep #$20
        sta $7FEC6C
        rep #$20
        lda $7FEC6C
        and #$00FF
        clc
        adc wR2
        cmp wR1
        bcc _EF9A
        beq _EF9A
        lda $7FEC6C
        and #$00FF
        pha
        lda wR1
        sec
        sbc #1,s
        sta #1,s
        pla
        bra _EF9C


        _EF9A
        lda wR2

        _EF9C
        sep #$20
        sta $7FEC6D
        rep #$20
        bra _EFC2


        _EFA6
        sep #$20
        lda #$FF
        sta $7FEC6E
        lda #$00
        sta $7FEC6F
        lda #$00
        sta $7FEC6C
        lda #$00
        sta $7FEC6D
        rep #$20

        _EFC2
        rts

        .databank 0

        ; 96/EFC3

    .endsection Unsorted96EEC6Section


    .section Unsorted96EFC3Section

      .al
      .xl

      rsBattleSceneCalcMosaicBoxBG3Center ; 96/EFC3

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FEC6A
        clc
        adc $7FEC6B
        and #$00FF
        sta wR2
        lda aBattleSceneBG3AnimSlot.wX
        and #$03FF
        sec
        sbc wBattleSceneCameraX
        sec
        sbc #$0100
        sta wR0
        lda $7FEC68
        and #$00FF
        pha
        lda wR0
        sec
        sbc #1,s
        sta #1,s
        pla
        cmp #$0200
        bcc _EFFC
        jml _F0A7


        _EFFC
        cmp #$0100
        bcs _F004
        lda #$0100

        _F004
        sec
        sbc #$0100
        sep #$20
        sta $7FEC6E
        rep #$20
        lda $7FEC69
        and #$00FF
        clc
        adc wR0
        cmp #$0100
        bcs _F023
        jml _F0A7


        _F023
        cmp #$0200
        bcc _F02B
        lda #$01FF

        _F02B
        sec
        sbc #$0100
        sep #$20
        sta $7FEC6F
        rep #$20
        lda $7FEC65
        clc
        adc $7FEC66
        and #$00FF
        sta wR1
        lda aBattleSceneBG3AnimSlot.wY
        sec
        sbc #$0080
        sta wR0
        lda $7FEC6A
        and #$00FF
        pha
        lda wR0
        sec
        sbc #1,s
        bcs _F06A
        pha
        lda wR2
        sec
        sbc #1,s
        sta wR2
        pla
        lda #$0000

        _F06A
        sta #1,s
        pla
        cmp wR1
        bcs _F0A7
        sep #$20
        sta $7FEC6C
        rep #$20
        lda $7FEC6C
        and #$00FF
        clc
        adc wR2
        cmp wR1
        bcc _F09B
        beq _F09B
        lda $7FEC6C
        and #$00FF
        pha
        lda wR1
        sec
        sbc #1,s
        sta #1,s
        pla
        bra _F09D


        _F09B
        lda wR2

        _F09D
        sep #$20
        sta $7FEC6D
        rep #$20
        bra _F0C3


        _F0A7
        sep #$20
        lda #$FF
        sta $7FEC6E
        lda #$00
        sta $7FEC6F
        lda #$00
        sta $7FEC6C
        lda #$00
        sta $7FEC6D
        rep #$20

        _F0C3
        rts

        .databank 0

        ; 96/F0C4

    .endsection Unsorted96EFC3Section


    .section Unsorted96F0C4Section

      .al
      .xl

      rsBattleSceneCalcMosaicBoxBG1 ; 96/F0C4

        .al
        .xl
        .autsiz
        .databank ?

        lda #$EC6A
        clc
        adc #$EC6B
        and #$00FF
        sta wR2
        lda aBattleSceneBGAnimSlots.wX
        and #$03FF
        sec
        sbc #$0100
        sec
        sbc #$0080
        sta wR0
        lda $7FEC68
        and #$00FF
        pha
        lda wR0
        sec
        sbc #1,s
        sta #1,s
        pla
        cmp #$0200
        bcc _F0FA
        jml _F1A5


        _F0FA
        cmp #$0100
        bcs _F102
        lda #$0100

        _F102
        sec
        sbc #$0100
        sep #$20
        sta $7FEC6E
        rep #$20
        lda $7FEC69
        and #$00FF
        clc
        adc wR0
        cmp #$0100
        bcs _F121
        jml _F1A5


        _F121
        cmp #$0200
        bcc _F129
        lda #$01FF

        _F129
        sec
        sbc #$0100
        sep #$20
        sta $7FEC6F
        rep #$20
        lda $7FEC65
        clc
        adc $7FEC66
        and #$00FF
        sta wR1
        lda aBattleSceneBGAnimSlots.wY
        sec
        sbc #$0080
        sta wR0
        lda $7FEC6A
        and #$00FF
        pha
        lda wR0
        sec
        sbc #1,s
        bcs _F168
        pha
        lda wR2
        sec
        sbc #1,s
        sta wR2
        pla
        lda #$0000

        _F168
        sta #1,s
        pla
        cmp wR1
        bcs _F1A5
        sep #$20
        sta $7FEC6C
        rep #$20
        lda $7FEC6C
        and #$00FF
        clc
        adc wR2
        cmp wR1
        bcc _F199
        beq _F199
        lda $7FEC6C
        and #$00FF
        pha
        lda wR1
        sec
        sbc #1,s
        sta #1,s
        pla
        bra _F19B


        _F199
        lda wR2

        _F19B
        sep #$20
        sta $7FEC6D
        rep #$20
        bra _F1C1


        _F1A5
        sep #$20
        lda #$FF
        sta $7FEC6E
        lda #$00
        sta $7FEC6F
        lda #$00
        sta $7FEC6C
        lda #$00
        sta $7FEC6D
        rep #$20

        _F1C1
        rts

        .databank 0

        ; 96/F1C2

    .endsection Unsorted96F0C4Section


    .section Unsorted96F275Section

      .al
      .xl

      rlBattleSceneCreateMosaicWindowHDMA ; 96/F275

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #(`aBattleSceneMosaicWindowHDMAInfo)<<8
        sta lR44+1
        lda #<>aBattleSceneMosaicWindowHDMAInfo
        sta lR44
        lda #$0006
        sta wR40
        jsl rlHDMAEngineCreateEntryByIndex
        plx
        rtl

        .databank 0

        ; 96/F28B

        ; Unreachable: it follows a return.
        rep #$20

    .endsection Unsorted96F275Section


    .section Unsorted96F28DSection

      .al
      .xl

      rlBattleSceneBuildMosaicWindowHDMA ; 96/F28D

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000
        lda $7FEC6C
        and #$00FF
        beq _F2C5
        dec a
        cmp #$0080
        bcc _F2B7
        pha
        lda #$007F
        sta $7FE506,x
        inc x
        lda #$E51B
        sta $7FE506,x
        inc x
        inc x
        pla
        sec
        sbc #$007F

        _F2B7
        sta $7FE506,x
        inc x
        lda #$E51B
        sta $7FE506,x
        inc x
        inc x

        _F2C5
        lda $7FEC6D
        and #$00FF
        beq _F2F8
        cmp #$0080
        bcc _F2EA
        pha
        lda #$007F
        sta $7FE506,x
        inc x
        lda #$EC6E
        sta $7FE506,x
        inc x
        inc x
        pla
        sec
        sbc #$007F

        _F2EA
        sta $7FE506,x
        inc x
        lda #$EC6E
        sta $7FE506,x
        inc x
        inc x

        _F2F8
        lda #$0001
        sta $7FE506,x
        inc x
        lda #$E51B
        sta $7FE506,x
        inc x
        inc x
        sep #$20
        lda #$00
        sta $7FE506,x
        rep #$20
        plx
        rtl

        .databank 0

        ; 96/F315

    .endsection Unsorted96F28DSection


    .section Unsorted96F315Section

      .al
      .xl

      rlBattleSceneEndStepDefeatScript ; 96/F315

        .al
        .xl
        .autsiz
        .databank ?

        ; When bBattleSceneStrikeFlags bit 7 is set and the defender is not Julius in the final chapter, starts script $34.

        lda bBattleSceneStrikeFlags,b
        bit #$0080
        beq _F32A
        jsl rlBattleSceneCheckJuliusDefends
        bcs _F32A
        lda #$0034
        jsl rlStartBattleSceneScript

        _F32A
        rtl

        .databank 0

        ; 96/F32B

      rlBattleSceneEndStepDefeatScript2 ; 96/F32B

        .al
        .xl
        .autsiz
        .databank ?

        ; When bBattleSceneStrikeFlags bit 7 is set and the defender is not Julius in the final chapter, starts script $31.

        lda bBattleSceneStrikeFlags,b
        bit #$0080
        beq _F340
        jsl rlBattleSceneCheckJuliusDefends
        bcs _F340
        lda #$0031
        jsl rlStartBattleSceneScript

        _F340
        rtl

        .databank 0

        ; 96/F341

      rlBattleSceneCheckJuliusDefends ; 96/F341

        .al
        .xl
        .autsiz
        .databank ?

        ; Carry set when combatant 1 attacks and combatant 2 is JuliusChFinal.

        lda wBattleAnimationAttackerOffset,b
        cmp #$0000
        bne _F354
        lda aBattleSceneCombatant2.Character,b
        cmp #JuliusChFinal
        bne _F354
        sec
        bra _F355


        _F354
        clc

        _F355
        rtl

        .databank 0

        ; 96/F356

      rlBattleSceneScriptInitPalFlash ; 96/F356

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$00
        sta $7FFC54
        sta $7FFC55
        lda #$00
        sta bBufferTMW
        sta bBufferTSW
        lda bBufferTM
        ora #$12
        sta bBufferTM
        lda bBufferTS
        and #$FF
        ora #$02
        sta bBufferTS
        lda #$02
        sta bBufferCGWSEL
        lda #$00
        sta bBufferCGADSUB
        rep #$20
        lda #(`rlBattleSceneScriptStepPalFlash)<<8
        sta lBattleSceneScriptRoutine+1
        lda #<>rlBattleSceneScriptStepPalFlash
        sta lBattleSceneScriptRoutine
        rtl

        .databank 0

        ; 96/F38F

      rlBattleSceneScriptStepPalFlash ; 96/F38F

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7FFC55
        and #$00FF
        beq _F3A4
        sep #$20
        dec a
        sta $7FFC55
        rep #$20
        bra _F3E0


        _F3A4
        lda $7FFC54
        and #$00FF
        tax
        lda aBattleScenePalFlashSteps,x
        and #$00FF
        cmp #$00FF
        bne _F3BE
        jsl rlBattleSceneEndScriptRoutine
        bra _F3E0


        _F3BE
        pha
        sep #$20
        and #$7F
        sta $7FFC55
        lda $7FFC54
        inc a
        sta $7FFC54
        rep #$20
        pla
        bit #$0080
        bne _F3DD
        jsr rsBattleSceneRestoreSpritePalettes
        bra _F3E0


        _F3DD
        jsr rsBattleSceneApplyTintedSpritePalettes

        _F3E0
        plx
        rtl

        .databank 0

        ; 96/F3E2

      rsBattleSceneRestoreSpritePalettes ; 96/F3E2

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000

        _F3E6
        lda $7FFF82,x
        sta $0282,b,x
        inc x
        inc x
        cpx #$007E
        bcc _F3E6
        sep #$20
        lda #$00
        sta bBufferCGADSUB
        rep #$20
        plx
        rts

        .databank 0

        ; 96/F3FE

      rsBattleSceneApplyTintedSpritePalettes ; 96/F3FE

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000

        _F402
        lda $7FF636,x
        sta $0282,b,x
        inc x
        inc x
        cpx #$007E
        bcc _F402
        sep #$20
        lda #$10
        sta bBufferCGADSUB
        rep #$20
        plx
        rts

        .databank 0

        ; 96/F41A

    .endsection Unsorted96F315Section


    .section Unreferenced96F41ASection

      .al
      .xl

      rlBattleSceneScriptInitShake0 ; 96/F41A

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$0000
        sta aBattleSceneAfterimages.Owner,b
        lda #(`rlBattleSceneScriptStepDefenderShake)<<8
        sta lBattleSceneScriptRoutine+1
        lda #<>rlBattleSceneScriptStepDefenderShake
        sta lBattleSceneScriptRoutine
        plx
        rtl

        .databank 0

        ; 96/F431

      rlBattleSceneScriptInitShake1 ; 96/F431

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$008E
        sta aBattleSceneAfterimages.Owner,b
        lda #(`rlBattleSceneScriptStepDefenderShake)<<8
        sta lBattleSceneScriptRoutine+1
        lda #<>rlBattleSceneScriptStepDefenderShake
        sta lBattleSceneScriptRoutine
        plx
        rtl

        .databank 0

        ; 96/F448

      rlBattleSceneScriptInitShake2 ; 96/F448

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$0118
        sta aBattleSceneAfterimages.Owner,b
        lda #(`rlBattleSceneScriptStepDefenderShake)<<8
        sta lBattleSceneScriptRoutine+1
        lda #<>rlBattleSceneScriptStepDefenderShake
        sta lBattleSceneScriptRoutine
        plx
        rtl

        .databank 0

        ; 96/F45F

      rlBattleSceneScriptInitShake3 ; 96/F45F

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$0122
        sta aBattleSceneAfterimages.Owner,b
        lda #(`rlBattleSceneScriptStepDefenderShake)<<8
        sta lBattleSceneScriptRoutine+1
        lda #<>rlBattleSceneScriptStepDefenderShake
        sta lBattleSceneScriptRoutine
        plx
        rtl

        .databank 0

        ; 96/F476

      rlBattleSceneScriptStepDefenderShake ; 96/F476

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx aBattleSceneAfterimages.Owner,b
        lda aBattleSceneKnockbackShake+59,x
        cmp #$8080
        bne _F489
        jsl rlBattleSceneEndScriptRoutine
        bra _F4A1


        _F489
        ldx wBattleAnimationDefenderOffset,b
        sep #$20
        sta bBattleAnimationDrawOffsetX,b,x
        xba
        sta bBattleAnimationDrawOffsetY,b,x
        rep #$20
        lda aBattleSceneAfterimages.Owner,b
        clc
        adc #$0002
        sta aBattleSceneAfterimages.Owner,b

        _F4A1
        plx
        rtl

        .databank 0

        ; 96/F4A3

      rlBattleSceneScriptInitAttackerBlink ; 96/F4A3

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$0000
        sta aBattleSceneAfterimages.Owner,b
        lda #(`rlBattleSceneScriptStepAttackerBlink)<<8
        sta lBattleSceneScriptRoutine+1
        lda #<>rlBattleSceneScriptStepAttackerBlink
        sta lBattleSceneScriptRoutine
        plx
        rtl

        .databank 0

        ; 96/F4BA

      rlBattleSceneScriptStepAttackerBlink ; 96/F4BA

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda aBattleSceneAfterimages.Owner,b
        lsr a
        lsr a
        lsr a
        tax
        lda aBattleSceneKnockbackShake+401,x
        cmp #$FFFF
        bne _F4D1
        jsl rlBattleSceneEndScriptRoutine
        bra _F50B


        _F4D1
        pha
        lda aBattleSceneAfterimages.Owner,b
        and #$0007
        tax
        lda aBattleSceneKnockbackShake+421,x
        and #1,s
        and #$00FF
        bne _F4F5
        pla
        sep #$20
        lda #$80
        sta bBattleAnimationDrawOffsetY,b
        lda #$00
        sta $0B5B,b
        rep #$20
        bra _F504


        _F4F5
        pla
        sep #$20
        lda #$00
        sta bBattleAnimationDrawOffsetY,b
        lda #$80
        sta $0B5B,b
        rep #$20

        _F504
        lda aBattleSceneAfterimages.Owner,b
        inc a
        sta aBattleSceneAfterimages.Owner,b

        _F50B
        plx
        rtl

        .databank 0

        ; 96/F50D

        ; Unreachable: it follows a return.
        rtl
        rtl
        rtl
        rtl
        rtl

      rlBattleSceneScriptHideLetterbox ; 96/F512

        .al
        .xl
        .autsiz
        .databank ?

        ; Unreferenced.

        sep #$20
        lda bBattleSceneBackgroundFlags
        ora #$04
        sta bBattleSceneBackgroundFlags
        rep #$20
        lda #$0007
        jsl rlHDMAEngineFreeEntryByIndex
        jsl rlBattleSceneEndScriptRoutine
        rtl

        .databank 0

        ; 96/F52C

      rlBattleSceneScriptShowLetterbox ; 96/F52C

        .al
        .xl
        .autsiz
        .databank ?

        ; Unreferenced.

        sep #$20
        lda bBattleSceneBackgroundFlags
        and #$FB
        sta bBattleSceneBackgroundFlags
        rep #$20
        jsl rlBattleSceneCreateLetterboxHDMA
        jsl rlBattleSceneEndScriptRoutine
        rtl

        .databank 0

        ; 96/F543

      rlBattleSceneScriptFreeLetterboxHDMA ; 96/F543

        .al
        .xl
        .autsiz
        .databank ?

        ; Unreferenced.

        lda #$0007
        jsl rlHDMAEngineFreeEntryByIndex
        jsl rlBattleSceneEndScriptRoutine
        rtl

        .databank 0

        ; 96/F54F

      rlBattleSceneScriptCreateLetterboxHDMA ; 96/F54F

        .al
        .xl
        .autsiz
        .databank ?

        ; Unreferenced.

        jsl rlBattleSceneCreateLetterboxHDMA
        jsl rlBattleSceneEndScriptRoutine
        rtl

        .databank 0

        ; 96/F558

    .endsection Unreferenced96F41ASection
    .section Unsorted96F7D4Section

      .al
      .xl

      rlBattleSceneUpdateEffectSprites ; 96/F7D4

        .al
        .xl
        .autsiz
        .databank ?

        lda bBattleSceneSkillFlags
        bit #$0001
        beq _F7EA
        bit #$0002
        bne _F7E7
        jsr rsBattleSceneStepDodgeOrMissSprites
        bra _F7EA


        _F7E7
        jsr rsBattleSceneStepHitEffectSprites

        _F7EA
        rtl

        .databank 0

        ; 96/F7EB

      rsBattleSceneStepDodgeOrMissSprites ; 96/F7EB

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda $7FFC69
        and #$00FF
        beq _F801
        sep #$20
        dec a
        sta $7FFC69
        rep #$20
        bra _F859


        _F801
        lda $7FFC65
        sta lR18+1
        lda $7FFC67
        sta lR18
        ldy #$0000
        lda [lR18],y
        cmp #$FFFF
        beq _F841
        sep #$20
        xba
        sta $7FFC69
        xba
        rep #$20
        and #$00FF
        dec a
        asl a
        tax
        lda aBattleSceneDodgeMissSprites,x
        clc
        adc #$B231
        sta $7FFC64
        lda $7FFC67
        clc
        adc #$0002
        sta $7FFC67
        bra _F859


        _F841
        sep #$20
        lda bBattleSceneSkillFlags
        and #$FE
        sta bBattleSceneSkillFlags
        lda #$FF
        sta bBattleSceneSkill1
        rep #$20
        jml _F898


        _F859
        lda $7FFC60
        and #$01FF
        sec
        sbc wBattleSceneCameraX
        sta wR0
        lda $7FFC62
        clc
        adc wBattleSceneCameraY
        and #$00FF
        sta wR1
        lda #$0000
        sta wR5
        sta wR4
        phx
        sep #$20
        phb
        lda $7FFC66
        pha
        plb
        .databank ?
        rep #$20
        lda $7FFC64
        tay
        clc
        jsl rlBattleScenePushSprites
        sep #$20
        plb
        .databank ?
        rep #$20
        plx

        _F898
        ply
        plx
        rts

        .databank 0

        ; 96/F89B

    .endsection Unsorted96F7D4Section


    .section Unreferenced96F89BSection

      .al
      .xl

      rlBattleSceneScriptInitHitSpark ; 96/F89B

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        sep #$20
        lda bBattleSceneSkillFlags
        ora #$01
        and #$FD
        sta bBattleSceneSkillFlags
        lda #$00
        sta $7FFC69
        rep #$20
        lda lBattleSceneRoundPointer+1,b
        sta lR18+1
        lda lBattleSceneRoundPointer,b
        sta lR18
        ldy #$0000

        _F8C0
        lda [lR18],y
        cmp #$FFFF
        beq _F8D5
        bit #$0080
        beq _F8D0
        inc y
        inc y
        bra _F8C0


        _F8D0
        bit #$0001
        bne _F8DA

        _F8D5
        ldx #$0000
        bra _F8DD


        _F8DA
        ldx #$0043

        _F8DD
        lda wBattleAnimationX,b,x
        sta $7FFC60
        jsl rlBattleAnimationGetHitHeight
        pha
        lda wBattleAnimationYAnchor,b,x
        sec
        sbc wBattleAnimationYFixed,b,x
        xba
        sec
        sbc #1,s
        clc
        adc #$0018
        sta $7FFC62
        pla
        jsr rsBattleScenePlaySound05Panned
        lda #$9800
        sta $7FFC65
        lda #$B215
        sta $7FFC67
        jsl rlBattleSceneEndScriptRoutine
        ply
        plx
        rtl

        .databank 0

        ; 96/F915

    .endsection Unreferenced96F89BSection
    .section Unsorted96F915Section

      .al
      .xl

      rsBattleSceneStepHitEffectSprites ; 96/F915

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7FFC69
        and #$00FF
        asl a
        asl a
        tax
        lda aBattleSceneHitEffectSpriteMotion,x
        cmp #$8080
        beq _F952
        pha
        lda $7FFC6C
        bit #$8000
        beq _F93A
        pla
        eor #$FFFF
        inc a
        bra _F93B


        _F93A
        pla

        _F93B
        sta wR8
        lda aBattleSceneHitEffectSpriteMotion+2,x
        sta wR9
        sep #$20
        lda $7FFC69
        inc a
        sta $7FFC69
        rep #$20
        bra _F971


        _F952
        sep #$20
        lda bBattleSceneSkillFlags
        and #$FE
        sta bBattleSceneSkillFlags
        lda #$FF
        sta bBattleSceneSkill2
        rep #$20
        lda #$0009
        jsl rlBattleSceneStopPaletteSlot
        jml _F9BD


        _F971
        lda $7FFC60
        clc
        adc wR8
        and #$01FF
        sec
        sbc wBattleSceneCameraX
        sta wR0
        lda $7FFC62
        clc
        adc wBattleSceneCameraY
        and #$00FF
        clc
        adc wR9
        sta wR1
        lda #$0000
        sta wR5
        ora #$0100
        sta wR4
        phx
        sep #$20
        phb
        lda $7FFC66
        pha
        plb
        .databank ?
        rep #$20
        lda $7FFC67
        tay
        lda $7FFC6C
        asl a
        jsl rlBattleScenePushSprites
        sep #$20
        plb
        .databank ?
        rep #$20
        plx

        _F9BD
        plx
        rts

        .databank 0

        ; 96/F9BF

      rlBattleSceneStartHitEffectSprites ; 96/F9BF

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda bBattleSceneSkill2
        and #$00FF
        cmp #$00FF
        bne _F9D0
        jml _FA90


        _F9D0
        sep #$20
        lda bBattleSceneSkillFlags
        ora #$03
        sta bBattleSceneSkillFlags
        lda #$00
        sta $7FFC69
        rep #$20
        ldx wBattleAnimationDefenderOffset,b
        jsl rlBattleAnimationGetBodyWidth
        pha
        ldx wBattleAnimationAttackerOffset,b
        lda wBattleAnimationX,b,x
        ldx wBattleAnimationDefenderOffset,b
        cmp wBattleAnimationX,b,x
        bcs _FA0E
        lda wBattleAnimationX,b,x
        sec
        sbc #1,s
        sta $7FFC60
        pla
        lda #$0000
        sta $7FFC6C
        bra _FA20


        _FA0E
        lda wBattleAnimationX,b,x
        clc
        adc #1,s
        sta $7FFC60
        pla
        lda #$8000
        sta $7FFC6C

        _FA20
        jsl rlBattleAnimationGetHitHeight
        pha
        lda wBattleAnimationYAnchor,b,x
        sec
        sbc wBattleAnimationYFixed,b,x
        xba
        sec
        sbc #1,s
        clc
        adc #$0008
        sta $7FFC62
        pla
        lda bBattleSceneSkill2
        and #$00FF
        cmp #$0017
        beq _FA5A
        cmp #$0002
        beq _FA6A
        lda #$9800
        sta $7FFC65
        lda #$B2FB
        sta $7FFC67
        bra _FA7D


        _FA5A
        lda #$9800
        sta $7FFC65
        lda #$B32F
        sta $7FFC67
        bra _FA7D


        _FA6A
        lda #$9800
        sta $7FFC65
        lda #$B363
        sta $7FFC67
        jsr rsBattleScenePlaySound6FPanned
        bra _FA90


        _FA7D
        lda #(`aBattleScenePaletteEffectAF21)<<8
        sta lR18+1
        lda #<>aBattleScenePaletteEffectAF21
        sta lR18
        lda #$0000
        sta wR0
        jsl rlBattleSceneStartPaletteEffect

        _FA90
        plx
        rtl

        .databank 0

        ; 96/FA92

    .endsection Unsorted96F915Section


    .section Unreferenced96FA92Section

      .al
      .xl

      rsBattleScenePlaySound05Panned ; 96/FA92

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda wBattleAnimationX,b,x
        and #$01FF
        sec
        sbc wBattleSceneCameraX
        jsl rlGetSoundPanFromXPixel
        cpx #$0000
        bne _FAAC
        clc
        adc #$2000

        _FAAC
        ora #$0005
        jsl rlPlaySoundEffect2
        ply
        plx
        rts

        .databank 0

        ; 96/FAB6

    .endsection Unreferenced96FA92Section
    .section Unsorted96FAB6Section

      .al
      .xl

      rsBattleScenePlaySound6FPanned ; 96/FAB6

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda wBattleAnimationX,b,x
        and #$01FF
        sec
        sbc wBattleSceneCameraX
        jsl rlGetSoundPanFromXPixel
        cpx #$0000
        bne _FAD0
        clc
        adc #$2000

        _FAD0
        ora #$006F
        jsl rlPlaySoundEffect2
        ply
        plx
        rts

        .databank 0

        ; 96/FADA

    .endsection Unsorted96FAB6Section


    .section Unreferenced96FADASection

      .al
      .xl

      rlBattleSceneScriptInitBlueTintIn ; 96/FADA

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta $7FE3EF
        sep #$20
        lda #$E0
        sta bBufferCOLDATA_3
        lda #$00
        sta bBufferCOLDATA_1
        sta bBufferCOLDATA_2
        rep #$20
        jsl rlBattleSceneScriptStepBlueTintIn
        lda #(`rlBattleSceneScriptStepBlueTintIn)<<8
        sta lBattleSceneScriptRoutine+1
        lda #<>rlBattleSceneScriptStepBlueTintIn
        sta lBattleSceneScriptRoutine
        rtl

        .databank 0

        ; 96/FB02

      rlBattleSceneScriptStepBlueTintIn ; 96/FB02

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda $7FE3EF
        sep #$20
        pha
        lsr a
        ora #$E0
        sta bBufferCOLDATA_3
        sta $7FE3EE
        pla
        cmp #$3E
        bne _FB2D
        lda #$E0
        sta bBufferCOLDATA_3
        sta bBufferCOLDATA_1
        sta bBufferCOLDATA_2
        lda #$00
        sta $7FE3EE
        rep #$20
        jsl rlBattleSceneEndScriptRoutine
        bra _FB38


        _FB2D
        .as
        rep #$20
        lda $7FE3EF
        inc a
        sta $7FE3EF

        _FB38
        rtl

        .databank 0

        ; 96/FB39

      rlBattleSceneScriptInitBlueTintOut ; 96/FB39

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$007F
        sta $7FE3EF
        sep #$20
        lda #$E0
        sta bBufferCOLDATA_3
        lda #$00
        sta bBufferCOLDATA_1
        sta bBufferCOLDATA_2
        rep #$20
        jsl rlBattleSceneScriptStepBlueTintOut
        lda #(`rlBattleSceneScriptStepBlueTintOut)<<8
        sta lBattleSceneScriptRoutine+1
        lda #<>rlBattleSceneScriptStepBlueTintOut
        sta lBattleSceneScriptRoutine
        rtl

        .databank 0

        ; 96/FB61

      rlBattleSceneScriptStepBlueTintOut ; 96/FB61

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda $7FE3EF
        sep #$20
        pha
        lsr a
        lsr a
        ora #$E0
        sta bBufferCOLDATA_3
        sta $7FE3EE
        pla
        cmp #$00
        bne _FB8D
        lda #$E0
        sta bBufferCOLDATA_3
        sta bBufferCOLDATA_1
        sta bBufferCOLDATA_2
        lda #$00
        sta $7FE3EE
        rep #$20
        jsl rlBattleSceneEndScriptRoutine
        bra _FB98


        _FB8D
        .as
        rep #$20
        lda $7FE3EF
        dec a
        sta $7FE3EF

        _FB98
        rtl

        .databank 0

        ; 96/FB99

      rlBattleSceneScriptInitBlueTintSlow ; 96/FB99

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta $7FE3EF
        sep #$20
        lda #$E0
        sta bBufferCOLDATA_3
        lda #$00
        sta bBufferCOLDATA_1
        sta bBufferCOLDATA_2
        rep #$20
        jsl rlBattleSceneScriptStepBlueTintSlow
        lda #(`rlBattleSceneScriptStepBlueTintSlow)<<8
        sta lBattleSceneScriptRoutine+1
        lda #<>rlBattleSceneScriptStepBlueTintSlow
        sta lBattleSceneScriptRoutine
        rtl

        .databank 0

        ; 96/FBC1

      rlBattleSceneScriptStepBlueTintSlow ; 96/FBC1

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda $7FE3EF
        sep #$20
        pha
        lsr a
        lsr a
        ora #$E0
        sta bBufferCOLDATA_3
        sta $7FE3EE
        pla
        cmp #$7C
        bne _FBED
        lda #$E0
        sta bBufferCOLDATA_3
        sta bBufferCOLDATA_1
        sta bBufferCOLDATA_2
        lda #$00
        sta $7FE3EE
        rep #$20
        jsl rlBattleSceneEndScriptRoutine
        bra _FBF8


        _FBED
        .as
        rep #$20
        lda $7FE3EF
        inc a
        sta $7FE3EF

        _FBF8
        rtl

        .databank 0

        ; 96/FBF9

    .endsection Unreferenced96FADASection
    .section Unsorted96FBF9Section

      .al
      .xl

      rlBattleSceneResetAllEffects ; 96/FBF9

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlBattleSceneInitEffectBuffers
        jsl rlBattleSceneClearHDMAEffects
        jsl rlBattleSceneResetPolygonWindows
        jsl rlBattleSceneResetBGScrolls
        jsl rlBattleSceneResetMosaic
        jsl rlBattleSceneClearBG2Shake
        jsl rlBattleSceneClearScriptRoutine
        lda #$0003
        jsl rlHDMAEngineFreeEntryByIndex
        lda #$0005
        jsl rlHDMAEngineFreeEntryByIndex
        lda #$0006
        jsl rlHDMAEngineFreeEntryByIndex
        ldx #$0014

        _FC2D
        sep #$20
        lda #$80
        sta aBattleScenePaletteSlots.Type,x
        rep #$20
        txa
        clc
        adc #$000A
        tax
        cpx #$0064
        bcc _FC2D
        lda #$0000
        sta aBGPaletteBuffer,b
        rtl

        .databank 0

        ; 96/FC49

    .endsection Unsorted96FBF9Section


    .section Unreferenced96FC49Section

      .al
      .xl

      rlBattleSceneResetScrollAndHDMAEffects ; 96/FC49

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlBattleSceneInitEffectBuffers
        jsl rlBattleSceneClearHDMAEffects
        jsl rlBattleSceneResetPolygonWindows
        jsl rlBattleSceneResetBGScrolls
        jsl rlBattleSceneResetMosaic
        jsl rlBattleSceneClearBG2Shake
        lda #$0005
        jsl rlHDMAEngineFreeEntryByIndex
        ldx #$0014

        _FC6B
        sep #$20
        lda #$80
        sta aBattleScenePaletteSlots.Type,x
        rep #$20
        txa
        clc
        adc #$000A
        tax
        cpx #$0064
        bcc _FC6B
        rtl

        .databank 0

        ; 96/FC81

      rlBattleSceneResetEffectsAndColorMath ; 96/FC81

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlBattleSceneInitEffectBuffers
        jsl rlBattleSceneClearHDMAEffects
        jsl rlBattleSceneResetPolygonWindows
        jsl rlBattleSceneResetMosaic
        jsl rlBattleSceneClearBG2Shake
        jsl rlBattleSceneClearScriptRoutine
        lda #$0003
        jsl rlHDMAEngineFreeEntryByIndex
        lda #$0005
        jsl rlHDMAEngineFreeEntryByIndex
        lda #$0006
        jsl rlHDMAEngineFreeEntryByIndex
        ldx #$0014

        _FCB1
        sep #$20
        lda #$80
        sta aBattleScenePaletteSlots.Type,x
        rep #$20
        txa
        clc
        adc #$000A
        tax
        cpx #$0064
        bcc _FCB1
        lda #$0000
        sta aBGPaletteBuffer,b
        sep #$20
        lda #$E0
        sta bBufferCOLDATA_0
        sta bBufferCOLDATA_3
        sta bBufferCOLDATA_1
        sta bBufferCOLDATA_2
        rep #$20
        rtl

        .databank 0

        ; 96/FCDB

      rlBattleSceneResetCombatant1Center ; 96/FCDB

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        sep #$20
        lda $7FF5AF
        and #$FE
        sta $7FF5AF
        lda #$00
        sta wBattleSceneCameraY
        rep #$20
        lda #$0000
        sta wBattleAnimationYFixed,b
        sta wBattleAnimationXFixed,b
        sta bBattleSceneCameraXFraction
        lda #$0100
        sta wBattleAnimationX,b
        lda #$0080
        sta wBattleSceneCameraX
        ldx #$0000
        jsl rlBattleSceneQueueIdleAction
        plx
        rtl

        .databank 0

        ; 96/FD13

      rlBattleSceneResetBothCombatantsCenter ; 96/FD13

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        sep #$20
        lda $7FF5AF
        and #$FE
        sta $7FF5AF
        lda #$00
        sta wBattleSceneCameraY
        rep #$20
        lda #$0000
        sta wBattleAnimationXFixed,b
        sta wBattleAnimation2XFixed,b
        sta wBattleAnimationYFixed,b
        sta wBattleAnimation2YFixed,b
        sta bBattleSceneCameraXFraction
        lda #$0080
        sta wBattleSceneCameraX
        lda #$0100
        sta wBattleAnimationX,b
        sta wBattleAnimation2X,b
        ldx #$0043
        jsl rlBattleSceneQueueIdleAction
        plx
        rtl

        .databank 0

        ; 96/FD54

    .endsection Unreferenced96FC49Section
    .section Unsorted96FD54Section

      .al
      .xl

      rlBattleSceneRestoreHUDPalettes ; 96/FD54

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000

        _FD58
        lda $7FC3F0,x
        sta $01F2,b,x
        lda $7FC1F0,x
        sta $01D2,b,x
        inc x
        inc x
        cpx #$000E
        bcc _FD58
        plx
        rtl

        .databank 0

        ; 96/FD6F

    .endsection Unsorted96FD54Section


    .section Unsorted97802CSection

      .al
      .xl

      rlBattleSceneClearWindowBuffersRegs ; 97/802C

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$00
        sta bBufferW12SEL
        sta bBufferW34SEL
        sta bBufferWOBJSEL
        rep #$20
        rtl

        .databank 0

        ; 97/8039

    .endsection Unsorted97802CSection


