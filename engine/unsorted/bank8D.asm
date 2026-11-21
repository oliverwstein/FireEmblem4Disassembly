; Code from bank $8D not yet assigned to a game system.

    .section Unsorted8DA06ASection

      .al
      .xl

      rlUnknown8DA06A ; 8D/A06A

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 8D/A06B

      rlUnknown8DA06B ; 8D/A06B

        .al
        .xl
        .autsiz
        .databank ?

        lda #$7F00
        sta lR18+1
        lda #$5709
        sta lR18
        lda #$A8F6
        jsl rlBuildRAMAreaHeaderAndGuidingEntry
        ldx #$1308
        lda #$0000

        _A082
        sta $7F4400,x
        dec x
        bpl _A082
        jsl rlEnableActiveSpriteEngine
        inc wGameStateRoutine1,b
        lda $08DA,b
        cmp #$0001
        beq _A0B6
        cmp #$0000
        beq _A0B6
        cmp #$0002
        beq _A0B6
        lda #$0004
        sta wScreenFadingProcInput,b
        lda #(`procFadeInByScreenFadingTimer)<<8
        sta lR44+1
        lda #<>procFadeInByScreenFadingTimer
        sta lR44
        jsl rlProcEngineCreateProc

        _A0B6
        rtl

        .databank 0

        ; 8D/A0B7

      rlUnknown8DA0B7 ; 8D/A0B7

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $8D
        lda wGameStateStep,b
        asl a
        tax
        jsr (aUnknown8DA0C6,x)
        plp
        plb
        .databank $8D
        rtl

        .databank 0

        ; 8D/A0C6

    .endsection Unsorted8DA06ASection


    .section Unsorted8DA0C6Section

      .al
      .xl

      aUnknown8DA0C6 ; 8D/A0C6

        ; Step handlers of rlUnknown8DA0B7, by wGameStateStep.
        .word <>rsUnknown8DA0EC, <>rsUnknown8DA113, <>rsUnknown8DA136, <>rsUnknown8DA13B, <>rsUnknown8DA180, <>rsUnknown8DA185, <>rsUnknown8DA18F, <>rsUnknown8DA194, <>rsUnknown8DA199, <>rsUnknown8DA19E, <>rsUnknown8DA1A3, <>rsUnknown8DA1C0, <>rsUnknown8DA1DF, <>rsUnknown8DA1FA, <>rsUnknown8DA20B, <>rsUnknown8DA240, <>rsUnknown8DA258, <>rsUnknown8DA282, <>rsUnknown8DA287


      rsUnknown8DA0EC ; 8D/A0EC

        .al
        .xl
        .autsiz
        .databank ?

        ; Step 0 of aUnknown8DA0C6.

        lda aDialogue.wStatus,b
        beq _A0F2
        rts


        _A0F2
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0800, $80, $D000

        lda #$000B
        sta wGameStateStep,b
        lda #$0001
        sta $0594,b
        lda #$0000
        sta $7F5486
        rts

        .databank 0

        ; 8D/A113

      rsUnknown8DA113 ; 8D/A113

        .al
        .xl
        .autsiz
        .databank ?

        ; Step 1 of aUnknown8DA0C6.

        lda $7F5486
        cmp #$00C0
        bcs _A122
        inc a
        sta $7F5486
        rts


        _A122
        lda #$0000
        sta $7F5486
        lda #$000A
        sta wGameStateStep,b
        lda #$000C
        sta $0594,b
        rts

        .databank 0

        ; 8D/A136

      rsUnknown8DA136 ; 8D/A136

        .al
        .xl
        .autsiz
        .databank ?

        ; Step 2 of aUnknown8DA0C6.

        jsl rlUnknown80EE37
        rts

        .databank 0

        ; 8D/A13B

      rsUnknown8DA13B ; 8D/A13B

        .al
        .xl
        .autsiz
        .databank ?

        ; Step 3 of aUnknown8DA0C6.

        lda $7F5486
        bne _A161
        lda #$8D00
        sta lR44+1
        lda #$A504
        sta lR44
        jsl rlHDMAEngineCreateEntry
        lda #$8D00
        sta lR44+1
        lda #$A4A8
        sta lR44
        jsl rlHDMAEngineCreateEntry
        jsl rlUnknown8DA755

        _A161
        jsr rsUnknown8DA34D
        lda $7F5486
        inc a
        sta $7F5486
        cmp #$0060
        bcc _A17F
        lda #$0000
        sta $7F5486
        lda #$0004
        sta wGameStateStep,b

        _A17F
        rts

        .databank 0

        ; 8D/A180

      rsUnknown8DA180 ; 8D/A180

        .al
        .xl
        .autsiz
        .databank ?

        ; Step 4 of aUnknown8DA0C6.

        jsl rlUnknown8DA2AA
        rts

        .databank 0

        ; 8D/A185

      rsUnknown8DA185 ; 8D/A185

        .al
        .xl
        .autsiz
        .databank ?

        ; Step 5 of aUnknown8DA0C6.

        jsr rsUnknown8DA624
        jsr rsUnknown8DA624._A676
        jsr rsUnknown8DA624._A6E9
        rts

        .databank 0

        ; 8D/A18F

      rsUnknown8DA18F ; 8D/A18F

        .al
        .xl
        .autsiz
        .databank ?

        ; Step 6 of aUnknown8DA0C6.

        jsl rlUnknown80EFD8
        rts

        .databank 0

        ; 8D/A194

      rsUnknown8DA194 ; 8D/A194

        .al
        .xl
        .autsiz
        .databank ?

        ; Step 7 of aUnknown8DA0C6.

        jsl rlUnknown8DAD73
        rts

        .databank 0

        ; 8D/A199

      rsUnknown8DA199 ; 8D/A199

        .al
        .xl
        .autsiz
        .databank ?

        ; Step 8 of aUnknown8DA0C6.

        jsl rlUnknown80F1A7
        rts

        .databank 0

        ; 8D/A19E

      rsUnknown8DA19E ; 8D/A19E

        .al
        .xl
        .autsiz
        .databank ?

        ; Step 9 of aUnknown8DA0C6.

        jsl rlUnknown8DB4F1
        rts

        .databank 0

        ; 8D/A1A3

      rsUnknown8DA1A3 ; 8D/A1A3

        .al
        .xl
        .autsiz
        .databank ?

        ; Step 10 of aUnknown8DA0C6.

        lda wVBlankEnabledFramecount
        and #$0007
        bne _A1B4
        sep #$20
        lda bBufferINIDISP
        and #$0F
        beq _A1B7
        dec bBufferINIDISP

        _A1B4
        rep #$20
        rts


        _A1B7
        .as
        rep #$20
        lda $0594,b
        sta wGameStateStep,b
        rts

        .databank 0

        ; 8D/A1C0

      rsUnknown8DA1C0 ; 8D/A1C0

        .al
        .xl
        .autsiz
        .databank ?

        ; Step 11 of aUnknown8DA0C6.

        lda wVBlankEnabledFramecount
        and #$0007
        bne _A1D3
        sep #$20
        lda bBufferINIDISP
        and #$0F
        cmp #$0F
        beq _A1D6
        inc bBufferINIDISP

        _A1D3
        rep #$20
        rts


        _A1D6
        .as
        rep #$20
        lda $0594,b
        sta wGameStateStep,b
        rts

        .databank 0

        ; 8D/A1DF

      rsUnknown8DA1DF ; 8D/A1DF

        .al
        .xl
        .autsiz
        .databank ?

        ; Step 12 of aUnknown8DA0C6.

        lda #$FFFF
        sta wCurrentChapter,b
        lda #(`aEventChapterEpilogueWorldMap)<<8
        sta lR18+1
        lda #<>aEventChapterEpilogueWorldMap
        sta lR18
        jsl rlUnknown80C1FC
        lda #$0005
        sta wGameStateStep,b
        rts

        .databank 0

        ; 8D/A1FA

      rsUnknown8DA1FA ; 8D/A1FA

        .al
        .xl
        .autsiz
        .databank ?

        ; Step 13 of aUnknown8DA0C6.

        jsl rlUnknown8DAF33
        lda #$000B
        sta wGameStateStep,b
        lda #$000E
        sta $0594,b
        rts

        .databank 0

        ; 8D/A20B

      rsUnknown8DA20B ; 8D/A20B

        .al
        .xl
        .autsiz
        .databank ?

        ; Step 14 of aUnknown8DA0C6.

        lda $7F5486
        inc a
        sta $7F5486
        cmp #$0B40
        bcs _A223
        cmp #$0100
        bcs _A21F

        _A21E
        rts


        _A21F
        lda wJoy1New
        beq _A21E

        _A223
        lda #$000A
        sta wGameStateStep,b
        lda #$0006
        sta $0594,b
        jsl rlCalculateFinalRankingScore
        cmp #$0003
        bcs _A23F
        lda #$00E3
        jsl rlUnknown808F6F

        _A23F
        rts

        .databank 0

        ; 8D/A240

      rsUnknown8DA240 ; 8D/A240

        .al
        .xl
        .autsiz
        .databank ?

        ; Step 15 of aUnknown8DA0C6.

        jsl rlUnknown8DAFA5
        lda #$0000
        sta $7F5486
        lda #$000B
        sta wGameStateStep,b
        lda #$0010
        sta $0594,b
        rts

        .databank 0

        ; 8D/A258

      rsUnknown8DA258 ; 8D/A258

        .al
        .xl
        .autsiz
        .databank ?

        ; Step 16 of aUnknown8DA0C6.

        lda $7F5486
        cmp #$0180
        bcs _A267
        inc a
        sta $7F5486
        rts


        _A267
        lda #$0000
        sta $7F5486
        lda #$0011
        sta wGameStateStep,b
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8088, $0040, $80, $D500

        rts

        .databank 0

        ; 8D/A282

      rsUnknown8DA282 ; 8D/A282

        .al
        .xl
        .autsiz
        .databank ?

        ; Step 17 of aUnknown8DA0C6.

        jsl rlUnknown8DB276
        rts

        .databank 0

        ; 8D/A287

      rsUnknown8DA287 ; 8D/A287

        .al
        .xl
        .autsiz
        .databank ?

        ; Step 18 of aUnknown8DA0C6.

        rts

        .databank 0

        ; 8D/A288

    .endsection Unsorted8DA0C6Section


    .section Unsorted8DA288Section

      .al
      .xl

      rlUnknown8DA288 ; 8D/A288

        .al
        .xl
        .autsiz
        .databank ?

        stz $08DA,b
        lda #$FFFF
        sta wCurrentChapter,b
        lda #$ECC9
        sta $0ECF,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        jsl rlUnknown88B3AF
        rtl

        .databank 0

        ; 8D/A2AA

    .endsection Unsorted8DA288Section


    .section Unsorted8DA2AASection

      .al
      .xl

      rlUnknown8DA2AA ; 8D/A2AA

        .al
        .xl
        .autsiz
        .databank ?

        lda wBufferBG2VOFS
        sec
        sbc #$0038
        clc
        adc #$0010
        cmp #$0000
        beq _A332
        lda $7F5491
        clc
        adc #$5500
        sta $7F5491
        lda $7F5490
        adc #$0000
        sta $7F5490
        lda #$0140
        sec
        sbc $7F5490
        sta wBufferBG1VOFS
        lda $7F5494
        clc
        adc #$3900
        sta $7F5494
        lda $7F5493
        adc #$0000
        sta $7F5493
        lda #$0140
        sec
        sbc $7F5493
        sta wBufferBG2VOFS
        lda wBufferBG2VOFS
        cmp #$0080
        bcc _A305
        jsr rsUnknown8DA34D

        _A305
        lda wBufferBG2VOFS
        cmp #$00E0
        bne _A310
        jsl rlUnknown8DA755

        _A310
        lda wBufferBG2VOFS
        cmp #$00A0
        bne _A324
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0400, $80, $AC00


        _A324
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8788, $0400, $80, $D400

        rtl


        _A332
        lda $7F5486
        inc a
        sta $7F5486
        cmp #$0040
        bcc _A324
        lda #$000A
        sta wGameStateStep,b
        lda #$000D
        sta $0594,b
        rtl

        .databank 0

        ; 8D/A34D

    .endsection Unsorted8DA2AASection


    .section Unsorted8DA34DSection

      .al
      .xl

      rsUnknown8DA34D ; 8D/A34D

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0000
        jsr rsUnknown8DA624
        ldx #$0002
        jsr rsUnknown8DA624
        ldx #$0004
        jsr rsUnknown8DA624
        ldx #$0006
        jsr rsUnknown8DA624
        ldx #$0008
        jsr rsUnknown8DA624
        ldx #$000A
        jsr rsUnknown8DA624
        rts

        .databank 0

        ; 8D/A372

    .endsection Unsorted8DA34DSection


    .section Unsorted8DA3DESection

      .al
      .xl

      rlUnknown8DA3DE ; 8D/A3DE

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0500
        tsb aDialogue.wStatus,b
        lda #$01FF
        sta aDialogue.wClearTile,b
        lda #$0001
        sta aDialogue.wTextSpeed,b
        lda #$0004
        sta aDialogue.wUnknown00188C,b
        lda #$0080
        sta $18E1,b,x
        lda #$0818
        sta $18DB,b,x
        lda #$4000
        sta $18D7,b,x
        lda #$7E00
        sta $18D5,b,x
        lda #$8388
        sta $18D4,b,x
        lda #$2000
        sta aDialogue.wBaseTile,b,x
        lda #$150C
        sta wR1
        sep #$20
        lda #$00
        sta wR0+1
        xba
        lda wR1
        sta wR0
        lda wR1+1
        xba
        rep #$20
        lsr a
        lsr a
        clc
        adc wR0
        sta wR0
        ldx aDialogue,b
        lda #$7E00
        sta $18D5,b,x
        lda #$8388
        clc
        adc wR0
        sta $18D4,b,x
        rtl

        .databank 0

        ; 8D/A449

    .endsection Unsorted8DA3DESection


    .section Unsorted8DA4B3Section

      .al
      .xl

      rlUnknown8DA4B3 ; 8D/A4B3

        .al
        .xl
        .autsiz
        .databank ?

        rep #$20
        sep #$20
        lda #$18
        sta @l $0008BC
        lda #$00
        sta @l $0008BD
        lda #$58
        sta @l $0008BE
        lda bBufferTM
        sta @l $0008BF
        lda #$48
        sta @l $0008C0
        lda #$03
        sta @l $0008C1
        lda #$20
        sta @l $0008C2
        lda #$04
        sta @l $0008C3
        lda #$08
        sta @l $0008C4
        lda #$00
        sta @l $0008C5
        lda #$00
        sta @l $0008C6
        lda #$00
        sta @l $0008C7
        rep #$20
        rtl

        .databank 0

        ; 8D/A502

    .endsection Unsorted8DA4B3Section


    .section Unsorted8DA50FSection

      .al
      .xl

      rlUnknown8DA50F ; 8D/A50F

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$60
        sta $7F56C9
        rep #$20
        lda wBufferBG2HOFS
        sta $7F56CA
        lda $7F5493
        cmp #$0064
        bcc _A52C
        jml _A60D


        _A52C
        sep #$20
        lda #$08
        clc
        adc #$04
        clc
        adc $7F5493
        sta $7F56CC
        rep #$20
        lda wBufferBG2HOFS
        sta $7F56CD
        ldx #$0015
        lda wVBlankEnabledFramecount
        lsr a
        lsr a
        and #$000F
        tay

        _A54F
        sep #$20
        lda #$01
        sta $7F56CF,x
        rep #$20
        lda $A612,b,y
        and #$00FF
        sta $7F56D0,x
        tya
        sec
        sbc #$0001
        and #$000F
        tay
        dec x
        dec x
        dec x
        bpl _A54F
        sep #$20
        lda #$08
        sta $7F56E7
        rep #$20
        lda wBufferBG2HOFS
        sta $7F56E8
        ldx #$002D
        lda wVBlankEnabledFramecount
        lsr a
        lsr a
        and #$000F
        tay

        _A58C
        sep #$20
        lda #$01
        sta $7F56EA,x
        rep #$20
        lda $A612,b,y
        and #$00FF
        sta $7F56EB,x
        tya
        sec
        sbc #$0001
        and #$000F
        tay
        dec x
        dec x
        dec x
        bpl _A58C
        sep #$20
        lda #$08
        sta $7F571A
        rep #$20
        lda wBufferBG2HOFS
        sta $7F571B
        ldx #$0015
        lda wVBlankEnabledFramecount
        lsr a
        lsr a
        and #$000F
        tay

        _A5C9
        sep #$20
        lda #$01
        sta $7F571D,x
        rep #$20
        lda $A612,b,y
        and #$00FF
        sta $7F571E,x
        tya
        sec
        sbc #$0001
        and #$000F
        tay
        dec x
        dec x
        dec x
        bpl _A5C9
        sep #$20
        lda #$08
        sta $7F5735
        rep #$20
        lda wBufferBG2HOFS
        sta $7F5736
        sep #$20
        lda #$00
        sta $7F5738
        rep #$20
        lda #$0000
        sta $7F5739
        rtl


        _A60D
        jsl rlHDMAEngineFreeEntryByOffset
        rtl

        .databank 0

        ; 8D/A612

    .endsection Unsorted8DA50FSection


    .section Unsorted8DA624Section

      .al
      .xl

      rsUnknown8DA624 ; 8D/A624

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda aWorldMapPortrait,x
        asl a
        tax
        lda wVBlankEnabledFramecount
        and #$0001
        bne _A638
        lda $8DA73D,x
        bra _A63E


        _A638
        lda $8DA743,x
        bra _A63E


        _A63E
        sta wR0
        lda wVBlankEnabledFramecount
        and #$0001
        bne _A64D
        lda $8DA749,x
        bra _A653


        _A64D
        lda $8DA74F,x
        bra _A653


        _A653
        sta wR1
        plx
        lda $7F5420,x
        clc
        adc #$0020
        bmi _A676
        lda $7F5420,x
        sec
        sbc wR0
        sta $7F5420,x
        lda $7F5430,x
        sec
        sbc wR1
        sta $7F5430,x

        _A676
        lda $7F5410,x
        dec a
        sta $7F5410,x
        bpl _A6BD
        lda aWorldMapMarker,x
        inc a

        _A686
        sta aWorldMapMarker,x
        phx
        asl a
        asl a
        sta wR0
        lda aWorldMapPortrait,x
        asl a
        tax
        lda $8DA737,x
        clc
        adc wR0
        tax
        lda $8DCF88,x
        cmp #$FFFF
        bne _A6AC
        lda #$0000
        plx
        bra _A686


        _A6AC
        sta wR0
        lda $8DCF8A,x
        plx
        sta $7F5410,x
        lda wR0
        sta $7F5440,x

        _A6BD
        sep #$20
        lda #$8D
        pha
        plb
        .databank $8D
        rep #$20
        lda $7F5440,x
        tay
        lda $7F5420,x
        sta wR0
        lda #$0030
        lda $7F5430,x
        sta wR1
        lda #$0000
        sta wR5
        lda #$0000
        sta wR4
        phx
        jsl rlPushToOAMBuffer
        plx

        _A6E9
        sep #$20
        lda #$8D
        pha
        plb
        .databank $8D
        rep #$20
        lda aWorldMapMarker,x
        asl a
        asl a
        phx
        sta wR0
        lda aWorldMapPortrait,x
        asl a
        tax
        lda @l $8DA737,x
        clc
        adc wR0
        tax
        lda @l $8DCF9A,x
        tay
        plx
        lda #$0080
        lda $7F5420,x
        sta wR0
        lda #$00D0
        sec
        sbc $7F5430,x
        clc
        adc $7F5493
        sta wR1
        lda #$0000
        sta wR5
        lda #$0000
        sta wR4
        phx
        jsl rlPushToOAMBuffer
        plx
        rts

        .databank 0

        ; 8D/A737

    .endsection Unsorted8DA624Section


    .section Unsorted8DA755Section

      .al
      .xl

      rlUnknown8DA755 ; 8D/A755

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0000
        lda #$0100
        sta $7F5420,x
        lda #$0028
        sta $7F5430,x
        lda #$0001
        sta aWorldMapMarker,x
        lda #$0001
        sta aWorldMapPortrait,x
        ldx #$0002
        lda #$0140
        sta $7F5420,x
        lda #$0048
        sta $7F5430,x
        lda #$0000
        sta aWorldMapMarker,x
        lda #$0002
        sta aWorldMapPortrait,x
        ldx #$0004
        lda #$0138
        sta $7F5420,x
        lda #$0034
        sta $7F5430,x
        lda #$0002
        sta aWorldMapMarker,x
        lda #$0000
        sta aWorldMapPortrait,x
        ldx #$0006
        lda #$0130
        sta $7F5420,x
        lda #$0040
        sta $7F5430,x
        lda #$0002
        sta aWorldMapMarker,x
        lda #$0001
        sta aWorldMapPortrait,x
        ldx #$0008
        lda #$0150
        sta $7F5420,x
        lda #$0058
        sta $7F5430,x
        lda #$0000
        sta aWorldMapMarker,x
        lda #$0002
        sta aWorldMapPortrait,x
        ldx #$000A
        lda #$01A8
        sta $7F5420,x
        lda #$0068
        sta $7F5430,x
        lda #$0001
        sta aWorldMapMarker,x
        lda #$0002
        sta aWorldMapPortrait,x
        rtl

        .databank 0

        ; 8D/A810

    .endsection Unsorted8DA755Section


    .section Unsorted8DAD73Section

      .al
      .xl

      rlUnknown8DAD73 ; 8D/AD73

        .al
        .xl
        .autsiz
        .databank ?

        lda aDialogue.wStatus,b
        beq _AD91
        dec wBufferBG1VOFS
        lda wVBlankEnabledFramecount
        and #$0007
        bne _AD83
        inc wBufferBG2VOFS

        _AD83
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0800, $80, $D000

        rtl


        _AD91
        lda #$000A
        sta wGameStateStep,b
        lda #$000F
        sta $0594,b
        rtl

        .databank 0

        ; 8D/AD9E

    .endsection Unsorted8DAD73Section


    .section Unsorted8DAE85Section

      .al
      .xl

      rlUnknown8DAE85 ; 8D/AE85

        .al
        .xl
        .autsiz
        .databank ?

        phk
        plb
        .databank $8D
        sep #$20
        lda #$18
        sta $7F56C9
        lda #$00
        lda #$00
        sta $7F56CA
        lda #$64
        sta $7F56CB
        lda #$06
        sta $7F56CC
        lda #$24
        sta $7F56CD
        lda #$00
        lda #$00
        sta $7F56CE
        lda #$00
        sta $7F56CF
        lda #$00
        sta $7F56D0
        rep #$20
        rtl

        .databank 0

        ; 8D/AEC0

    .endsection Unsorted8DAE85Section


    .section Unsorted8DAEC2Section

      .al
      .xl

      rlUnknown8DAEC2 ; 8D/AEC2

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0500
        tsb aDialogue.wStatus,b
        lda #$03FF
        sta aDialogue.wClearTile,b
        lda #$0001
        sta aDialogue.wTextSpeed,b
        lda #$0004
        sta aDialogue.wUnknown00188C,b
        lda #$0080
        sta $18E1,b,x
        lda #$0026
        sta $18DD,b
        lda #$101C
        sta $18DB,b,x
        lda #$4000
        sta $18D7,b,x
        lda #$7E00
        sta $18D5,b,x
        lda #$8388
        sta $18D4,b,x
        lda #$2000
        sta aDialogue.wBaseTile,b,x
        lda #$0102
        sta wR1
        sep #$20
        lda #$00
        sta wR0+1
        xba
        lda wR1
        sta wR0
        lda wR1+1
        xba
        rep #$20
        lsr a
        lsr a
        clc
        adc wR0
        sta wR0
        ldx aDialogue,b
        lda #$7E00
        sta $18D5,b,x
        lda #$8388
        clc
        adc wR0
        sta $18D4,b,x
        rtl

        .databank 0

        ; 8D/AF33

    .endsection Unsorted8DAEC2Section


    .section Unsorted8DAF33Section

      .al
      .xl

      rlUnknown8DAF33 ; 8D/AF33

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$80
        sta $2100,b
        sta bBufferINIDISP
        rep #$20
        jsl rlDisableVBlank
        jsl rlResetHDMAEngine
        jsl rlUnknown9180BC
        jsl rlDialogueFreeHDMA
        stz wBufferBG2VOFS
        lda #(`aDecompressionDMAEntry8DAF95)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry8DAF95
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        lda #(`aDecompressionDMAEntry8DAF9D)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry8DAF9D
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        ldx #$01FE

        _AF6F
        lda $8CA400,x
        sta aBGPaletteBuffer,b,x
        dec x
        dec x
        bpl _AF6F
        lda #$0000
        sta aBGPaletteBuffer,b
        jsl rlEnableVBlank
        sep #$20
        lda #$00
        sta bBufferINIDISP
        lda #$02
        sta bBufferTM
        lda #$00
        sta bBufferTS
        rep #$20
        rtl

        .databank 0

        ; 8D/AF95

    .endsection Unsorted8DAF33Section


    .section Unsorted8DAFA5Section

      .al
      .xl

      rlUnknown8DAFA5 ; 8D/AFA5

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$80
        sta $2100,b
        sta bBufferINIDISP
        rep #$20
        jsl rlDisableVBlank
        jsl rlResetHDMAEngine
        jsl rlUnknown9180BC
        jsl rlDialogueFreeHDMA
        stz wBufferBG2VOFS
        stz wBufferBG3VOFS
        lda #(`aDecompressionDMAEntry8DB056)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry8DB056
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        lda #(`aDecompressionDMAEntry8DB066)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry8DB066
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        sep #$20
        rep #$10
        ldx #$28B8
        stx DecompressionVariables
        lda #$D4
        sta $CA
        ldx #$8388
        stx $CB
        lda #$7E
        sta $CD
        rep #$30
        jsl rlDecompressor
        jsr rsUnknown8DB06E
        jsr rsUnknown8DB150
        jsr rsUnknown8DB1DD
        jsr rsUnknown8DB217
        jsr rsUnknown8DB252
        ldx #$00BE

        _B00E
        lda $7E8888,x
        sta $7E8088,x
        dec x
        dec x
        bpl _B00E
        ldx #$00BE
        lda #$007F

        _B020
        sta $7E8888,x
        dec x
        dec x
        bpl _B020
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0800, $80, $D000

        sep #$20
        lda #$06
        sta bBufferTM
        lda #$01
        sta bBufferTS
        lda #$00
        sta bBufferCGWSEL
        lda #$00
        sta bBufferCGADSUB
        rep #$20
        jsl rlEnableVBlank
        sep #$20
        lda #$00
        sta bBufferINIDISP
        rep #$20
        rtl

        .databank 0

        ; 8D/B056

    .endsection Unsorted8DAFA5Section


    .section Unsorted8DB06ESection

      .al
      .xl

      rsUnknown8DB06E ; 8D/B06E

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlCalculateTacticsRanking
        asl a
        sta wR0
        clc
        adc #$2820
        sta $7E8564
        lda wR0
        clc
        adc #$2821
        sta $7E8566
        lda wR0
        clc
        adc #$2830
        sta $7E85A4
        lda wR0
        clc
        adc #$2831
        sta $7E85A6
        jsl rlCalculateExperienceRanking
        asl a
        sta wR0
        clc
        adc #$2820
        sta $7E8578
        lda wR0
        clc
        adc #$2821
        sta $7E857A
        lda wR0
        clc
        adc #$2830
        sta $7E85B8
        lda wR0
        clc
        adc #$2831
        sta $7E85BA
        jsl rlCalculateSurvivalRanking
        asl a
        sta wR0
        clc
        adc #$2820
        sta $7E85E4
        lda wR0
        clc
        adc #$2821
        sta $7E85E6
        lda wR0
        clc
        adc #$2830
        sta $7E8624
        lda wR0
        clc
        adc #$2831
        sta $7E8626
        jsl rlCalculateCombatRanking
        asl a
        sta wR0
        clc
        adc #$2820
        sta $7E85F8
        lda wR0
        clc
        adc #$2821
        sta $7E85FA
        lda wR0
        clc
        adc #$2830
        sta $7E8638
        lda wR0
        clc
        adc #$2831
        sta $7E863A
        jsl rlCalculateFinalRankingScore
        asl a
        sta wR0
        clc
        adc #$2820
        sta $7E86F6
        lda wR0
        clc
        adc #$2821
        sta $7E86F8
        lda wR0
        clc
        adc #$2830
        sta $7E8736
        lda wR0
        clc
        adc #$2831
        sta $7E8738
        rts

        .databank 0

        ; 8D/B150

    .endsection Unsorted8DB06ESection


    .section Unsorted8DB150Section

      .al
      .xl

      rsUnknown8DB150 ; 8D/B150

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown91EBC9
        txa
        sta wR0
        stz wR2
        stz wR3
        stz wR4
        stz wR5

        _B15F
        lda wR0
        cmp #$03E8
        bcc _B176
        sec
        sbc #$03E8
        sta wR0
        lda wR2
        clc
        adc #$0001
        sta wR2
        bra _B15F


        _B176
        lda wR0
        cmp #$0064
        bcc _B18D
        sec
        sbc #$0064
        sta wR0
        lda wR3
        clc
        adc #$0001
        sta wR3
        bra _B176


        _B18D
        lda wR0
        cmp #$000A
        bcc _B1A4
        sec
        sbc #$000A
        sta wR0
        lda wR4
        clc
        adc #$0001
        sta wR4
        bra _B18D


        _B1A4
        lda wR0
        sta wR5
        lda wR2
        clc
        adc #$0075
        ora #$3400
        sta $7E889C
        lda wR3
        clc
        adc #$0075
        ora #$3400
        sta $7E889E
        lda wR4
        clc
        adc #$0075
        ora #$3400
        sta $7E88A0
        lda wR5
        clc
        adc #$0075
        ora #$3400
        sta $7E88A2
        rts

        .databank 0

        ; 8D/B1DD

    .endsection Unsorted8DB150Section


    .section Unsorted8DB1DDSection

      .al
      .xl

      rsUnknown8DB1DD ; 8D/B1DD

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown91EBC9
        sta wR0
        stz wR4

        _B1E5
        lda wR0
        cmp #$000A
        bcc _B1FC
        sec
        sbc #$000A
        sta wR0
        lda wR4
        clc
        adc #$0001
        sta wR4
        bra _B1E5


        _B1FC
        lda wR4
        clc
        adc #$0075
        ora #$3400
        sta $7E88A6
        lda wR0
        clc
        adc #$0075
        ora #$3400
        sta $7E88A8
        rts

        .databank 0

        ; 8D/B217

    .endsection Unsorted8DB1DDSection


    .section Unsorted8DB217Section

      .al
      .xl

      rsUnknown8DB217 ; 8D/B217

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlGetCurrentSaveCompletionCount
        inc a
        sta wR0
        stz wR4

        _B220
        lda wR0
        cmp #$000A
        bcc _B237
        sec
        sbc #$000A
        sta wR0
        lda wR4
        clc
        adc #$0001
        sta wR4
        bra _B220


        _B237
        lda wR4
        clc
        adc #$0075
        ora #$3400
        sta $7E88BA
        lda wR0
        clc
        adc #$0075
        ora #$3400
        sta $7E88BC
        rts

        .databank 0

        ; 8D/B252

    .endsection Unsorted8DB217Section


    .section Unsorted8DB252Section

      .al
      .xl

      rsUnknown8DB252 ; 8D/B252

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$001E

        _B255
        phx
        sep #$20
        txa
        lsr a
        tax
        lda aUnknown7FC70A,x
        sec
        sbc #$41
        rep #$20
        plx
        clc
        adc #$0080
        ora #$3800
        sta $7E8918,x
        dec x
        dec x
        txa
        bpl _B255
        rts

        .databank 0

        ; 8D/B276

    .endsection Unsorted8DB252Section


    .section Unsorted8DB276Section

      .al
      .xl

      rlUnknown8DB276 ; 8D/B276

        .al
        .xl
        .autsiz
        .databank ?

        phk
        plb
        .databank $8D
        lda wJoy1New
        beq _B29A
        sta wR0
        lda $7F5486
        asl a
        tax
        lda @l aUnknown8DB2B8,x
        cmp wR0
        bne _B2AF
        lda $7F5486
        cmp #$000B
        beq _B29B
        inc a
        sta $7F5486

        _B29A
        rtl


        _B29B
        lda #$0012
        sta wGameStateStep,b
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8108, $0040, $80, $D580

        rtl


        _B2AF
        lda #$0000
        sta $7F5486
        bra _B29A

        .databank 0

        ; 8D/B2B8

    .endsection Unsorted8DB276Section


    .section Unsorted8DB2B8Section

      .al
      .xl

      aUnknown8DB2B8 ; 8D/B2B8

        ; A button sequence: rlUnknown8DB276 compares each new press with the next
        ; entry and goes to step $12 after the twelfth. Select, Up, A, Down, B, Left,
        ; X, Right, Y, L, R, Start.
        .word $2000, $0800, $0080, $0400, $8000, $0200, $0040, $0100, $4000, $0020, $0010, $1000


      rlUnknown8DB2D0 ; 8D/B2D0

        .al
        .xl
        .autsiz
        .databank ?

        ; One of 13 alike: stores a chapter's turn count (aChapterTurncounts) in $18AD
        ; and runs rsUnknown8DB386. Word pointers to these sit at $8D/CA4A-CBF2, in
        ; data not built yet.

        ldx #$0000
        lda aChapterTurncounts,b,x
        sta aDialogue.wNumber1,b
        jsr rsUnknown8DB386
        rtl

        .databank 0

        ; 8D/B2DD

      rlUnknown8DB2DD ; 8D/B2DD

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0002
        lda aChapterTurncounts,b,x
        sta aDialogue.wNumber1,b
        jsr rsUnknown8DB386
        rtl

        .databank 0

        ; 8D/B2EA

      rlUnknown8DB2EA ; 8D/B2EA

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0004
        lda aChapterTurncounts,b,x
        sta aDialogue.wNumber1,b
        jsr rsUnknown8DB386
        rtl

        .databank 0

        ; 8D/B2F7

      rlUnknown8DB2F7 ; 8D/B2F7

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0006
        lda aChapterTurncounts,b,x
        sta aDialogue.wNumber1,b
        jsr rsUnknown8DB386
        rtl

        .databank 0

        ; 8D/B304

      rlUnknown8DB304 ; 8D/B304

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0008
        lda aChapterTurncounts,b,x
        sta aDialogue.wNumber1,b
        jsr rsUnknown8DB386
        rtl

        .databank 0

        ; 8D/B311

      rlUnknown8DB311 ; 8D/B311

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$000A
        lda aChapterTurncounts,b,x
        sta aDialogue.wNumber1,b
        jsr rsUnknown8DB386
        rtl

        .databank 0

        ; 8D/B31E

      rlUnknown8DB31E ; 8D/B31E

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$000C
        lda aChapterTurncounts,b,x
        sta aDialogue.wNumber1,b
        jsr rsUnknown8DB386
        rtl

        .databank 0

        ; 8D/B32B

      rlUnknown8DB32B ; 8D/B32B

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$000E
        lda aChapterTurncounts,b,x
        sta aDialogue.wNumber1,b
        jsr rsUnknown8DB386
        rtl

        .databank 0

        ; 8D/B338

      rlUnknown8DB338 ; 8D/B338

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0010
        lda aChapterTurncounts,b,x
        sta aDialogue.wNumber1,b
        jsr rsUnknown8DB386
        rtl

        .databank 0

        ; 8D/B345

      rlUnknown8DB345 ; 8D/B345

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0012
        lda aChapterTurncounts,b,x
        sta aDialogue.wNumber1,b
        jsr rsUnknown8DB386
        rtl

        .databank 0

        ; 8D/B352

      rlUnknown8DB352 ; 8D/B352

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0014
        lda aChapterTurncounts,b,x
        sta aDialogue.wNumber1,b
        jsr rsUnknown8DB386
        rtl

        .databank 0

        ; 8D/B35F

      rlUnknown8DB35F ; 8D/B35F

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0016
        lda aChapterTurncounts,b,x
        sta aDialogue.wNumber1,b
        jsr rsUnknown8DB386
        rtl

        .databank 0

        ; 8D/B36C

      rlUnknown8DB36C ; 8D/B36C

        .al
        .xl
        .autsiz
        .databank ?

        stz aDialogue.wNumber1,b
        phx
        ldx #$0016

        _B373
        lda aChapterTurncounts,b,x
        clc
        adc aDialogue.wNumber1,b
        sta aDialogue.wNumber1,b
        dec x
        dec x
        bpl _B373
        plx
        jsr rsUnknown8DB3B4
        rtl

        .databank 0

        ; 8D/B386

      rsUnknown8DB386 ; 8D/B386

        .al
        .xl
        .autsiz
        .databank ?

        lda aDialogue.wNumber1,b
        cmp #$000A
        bcc _B395
        cmp #$0064
        bcs _B3B3
        bra _B3A4


        _B395
        lda #$8D00
        sta lR18+1
        lda #$CC3D
        sta lR18
        jsl rlDialoguePushToActivePointerStack
        rts


        _B3A4
        lda #$8D00
        sta lR18+1
        lda #$CC39
        sta lR18
        jsl rlDialoguePushToActivePointerStack
        rts


        _B3B3
        rts

        .databank 0

        ; 8D/B3B4

      rsUnknown8DB3B4 ; 8D/B3B4

        .al
        .xl
        .autsiz
        .databank ?

        lda aDialogue.wNumber1,b
        cmp #$000A
        bcc _B3CD
        cmp #$0064
        bcc _B3DC
        cmp #$03E8
        bcc _B3EB
        cmp #$2710
        bcc _B3FA
        bra _B409


        _B3CD
        lda #$8D00
        sta lR18+1
        lda #$CC54
        sta lR18
        jsl rlDialoguePushToActivePointerStack
        rts


        _B3DC
        lda #$8D00
        sta lR18+1
        lda #$CC4C
        sta lR18
        jsl rlDialoguePushToActivePointerStack
        rts


        _B3EB
        lda #$8D00
        sta lR18+1
        lda #$CC46
        sta lR18
        jsl rlDialoguePushToActivePointerStack
        rts


        _B3FA
        lda #$8D00
        sta lR18+1
        lda #$CC42
        sta lR18
        jsl rlDialoguePushToActivePointerStack
        rts


        _B409
        rts

        .databank 0

        ; 8D/B40A

      rlUnknown8DB40A ; 8D/B40A

        .al
        .xl
        .autsiz
        .databank ?

        stz $0AD3,b
        rtl

        .databank 0

        ; 8D/B40E

      rlUnknown8DB40E ; 8D/B40E

        .al
        .xl
        .autsiz
        .databank ?

        lda aDialogue.lActivePointer,b
        sec
        sbc #$0005
        sta aDialogue.lActivePointer,b

        _B418
        lda $0AD3,b
        clc
        adc #$0001
        cmp #$0019
        bcs _B471
        sta $0AD3,b
        lda $0AD3,b
        sta aDialogue.wUnit1,b
        lda $0AD3,b
        jsl rlUnknown8486A0
        sta aDialogue.wNumber1,b
        lda $0AD3,b
        jsl rlUnknown8486E5
        sta aDialogue.wNumber2,b
        lda $0AD3,b
        asl a
        tax
        lda aEpilogueUnitStates,x
        bit #$4000
        bne _B418
        bit #$8000
        bne _B45C
        lda #$2000
        sta aDialogue.wBaseTile,b
        bra _B462


        _B45C
        lda #$2400
        sta aDialogue.wBaseTile,b

        _B462
        lda #$8D00
        sta lR18+1
        lda #$CC24
        sta lR18
        jsl rlDialoguePushToActivePointerStack
        rtl


        _B471
        lda aDialogue.lActivePointer,b
        clc
        adc #$0005
        sta aDialogue.lActivePointer,b
        rtl

        .databank 0

        ; 8D/B47C

      rlUnknown8DB47C ; 8D/B47C

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0018
        sta $0AD3,b
        rtl

        .databank 0

        ; 8D/B483

      rlUnknown8DB483 ; 8D/B483

        .al
        .xl
        .autsiz
        .databank ?

        lda aDialogue.lActivePointer,b
        sec
        sbc #$0005
        sta aDialogue.lActivePointer,b

        _B48D
        lda $0AD3,b
        clc
        adc #$0001
        cmp #$0040
        bcs _B4E6
        sta $0AD3,b
        lda $0AD3,b
        sta aDialogue.wUnit1,b
        lda $0AD3,b
        jsl rlUnknown8486A0
        sta aDialogue.wNumber1,b
        lda $0AD3,b
        jsl rlUnknown8486E5
        sta aDialogue.wNumber2,b
        lda $0AD3,b
        asl a
        tax
        lda aEpilogueUnitStates,x
        bit #$4000
        bne _B48D
        bit #$8000
        bne _B4D1
        lda #$2000
        sta aDialogue.wBaseTile,b
        bra _B4D7


        _B4D1
        lda #$2400
        sta aDialogue.wBaseTile,b

        _B4D7
        lda #$8D00
        sta lR18+1
        lda #$CC24
        sta lR18
        jsl rlDialoguePushToActivePointerStack
        rtl


        _B4E6
        lda aDialogue.lActivePointer,b
        clc
        adc #$0005
        sta aDialogue.lActivePointer,b
        rtl

        .databank 0

        ; 8D/B4F1

    .endsection Unsorted8DB2B8Section


    .section Unsorted8DB4F1Section

      .al
      .xl

      rlUnknown8DB4F1 ; 8D/B4F1

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown8DB52C
        rtl

        .databank 0

        ; 8D/B4F6

    .endsection Unsorted8DB4F1Section


    .section Unsorted8DB4F6Section

      .al
      .xl

      rsUnknown8DB4F6 ; 8D/B4F6

        .al
        .xl
        .autsiz
        .databank ?

        lda wJoy1Input
        bit #$8000
        bne _B503
        bit #$2000
        bne _B52B
        rts


        _B503
        lda #$0000
        sta wCurrentChapter,b
        lda #$0021
        jsl rlPlaySoundEffect
        lda #$0002
        sta $0D77,b
        lda #$B122
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        rts


        _B52B
        rts

        .databank 0

        ; 8D/B52C

      rlUnknown8DB52C ; 8D/B52C

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown8DB53A
        jsr rsUnknown8DB4F6
        lda #$000B
        sta wGameStateStep,b
        rtl

        .databank 0

        ; 8D/B539

    .endsection Unsorted8DB4F6Section


    .section Unsorted8DB53ASection

      .al
      .xl

      rsUnknown8DB53A ; 8D/B53A

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0002
        tsb $08AD,b
        lda #$FFFF
        sta $7F7670
        lda #$0004
        trb $08AD,b
        lda #$0008
        trb $08AD,b
        lda #$0001
        trb $08AD,b
        lda $08DC,b
        cmp #$003F
        bcc _B563
        bra _B5A9


        _B563
        inc $08DC,b
        lda $08DC,b
        sta aDialogue.wUnit1,b
        sta $08B4,b
        lda $08DC,b
        sec
        sbc #$0019
        sta wR0
        clc
        adc wR0
        clc
        adc wR0
        tax
        lda $8DB5C9,x
        sta $08B0,b
        lda $8DB5C8,x
        sta $08AF,b
        lda $08DC,b
        and #$0003
        sta $08B6,b
        lda #$0004
        sta $08B8,b
        lda #$0002
        sta $088B,b
        lda #$0002
        sta wScreenFadingProcInput,b
        rts


        _B5A9
        lda #$0001
        sta $08DA,b
        lda #$ECC9
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        jsl rlUnknown88B3AF
        rts

        .databank 0

        ; 8D/B5C8

    .endsection Unsorted8DB53ASection


    .section Unsorted8DD041Section

      .al
      .xl

      rlUnknown8DD041 ; 8D/D041

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 8D/D042

    .endsection Unsorted8DD041Section
