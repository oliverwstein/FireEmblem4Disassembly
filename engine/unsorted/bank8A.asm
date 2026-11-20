; Code from bank $8A not yet assigned to a game system.

    .section Unsorted8A8000Section

      .al
      .xl

      rlUnknown8A8000 ; 8A/8000

        .al
        .xl
        .autsiz
        .databank ?

        lda $0891,b
        cmp #$0002
        beq _800D
        cmp #$0003
        beq _800D

        _800D
        rtl

        .databank 0

        ; 8A/800E

    .endsection Unsorted8A8000Section


    .section Unsorted8A800ESection

      .al
      .xl

      rlUnknown8A800E ; 8A/800E

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$7F00
        sta lR18+1
        lda #$B16C
        sta lR18
        lda #$0001
        sta wStructIndex,b
        lda #$4E93
        jsl rlBuildRAMAreaHeaderAndGuidingEntry
        lda $088B,b
        cmp #$0002
        beq _8041
        jsl rlEnableActiveSpriteEngine
        lda #(`procFadeIn)<<8
        sta lR44+1
        lda #<>procFadeIn
        sta lR44
        jsl rlProcEngineCreateProc
        bra _8049


        _8041
        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20

        _8049
        lda $08B8,b
        cmp #$0004
        beq _805D
        stz wBufferBG1VOFS
        stz wBufferBG2VOFS
        stz wBufferBG3VOFS
        stz wBufferBG1HOFS
        stz wBufferBG2HOFS
        stz wBufferBG3HOFS

        _805D
        inc wGameStateRoutine1,b
        rtl

        .databank 0

        ; 8A/8061

    .endsection Unsorted8A800ESection


    .section Unsorted8A8061Section

      .al
      .xl

      rlUnknown8A8061 ; 8A/8061

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $8A
        jsl rlUnknown81B15A
        jsl rlUnknown81ADD8
        lda wGameStateStep,b
        asl a
        tax
        jsr (aUnknown8A8078,x)
        plp
        plb
        .databank $8A
        rtl

        .databank 0

        ; 8A/8078

    .endsection Unsorted8A8061Section


    .section Table8A8078Section

      .al
      .xl

      aUnknown8A8078 ; 8A/8078

        ; Jump table of rlUnknown8A8061.
        .word <>rsUnknown8A80A6
        .word <>rsUnknown8A80BD
        .word <>rsUnknown8A80C2
        .word <>rsUnknown8A80C3
        .word <>rsUnknown8A80C8
        .word <>rsUnknown8A80CD
        .word <>rsUnknown8A80D2
        .word <>rsUnknown8A80D7
        .word <>rsUnknown8A80DC
        .word <>rsUnknown8A80E1
        .word <>rsUnknown8A80E6
        .word <>rsUnknown8A80F5
        .word <>rsUnknown8A80FA
        .word <>rsUnknown8A80EB
        .word <>rsUnknown8A80F0
        .word <>rsUnknown8A811A
        .word <>rsUnknown8A80FF
        .word <>rsUnknown8A8139
        .word $816F
        .word $8178
        .word <>rsUnknown8A8139
        .word <>rsUnknown8A815F
        .word <>rsUnknown8A8174

    .endsection Table8A8078Section


    .section Unsorted8A80A6Section

      .al
      .xl

      rsUnknown8A80A6 ; 8A/80A6

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown8A8208
        lda $04BA,b
        bne _80BC
        lda #$00F7
        jsl rlUnknown808F6F
        lda #$0001
        sta wGameStateStep,b

        _80BC
        rts

        .databank 0

        ; 8A/80BD

      rsUnknown8A80BD ; 8A/80BD

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown8A8208
        rts

        .databank 0

        ; 8A/80C2

      rsUnknown8A80C2 ; 8A/80C2

        .al
        .xl
        .autsiz
        .databank ?

        rts

        .databank 0

        ; 8A/80C3

    .endsection Unsorted8A80A6Section


    .section Unsorted8A80C3Section

      .al
      .xl

      rsUnknown8A80C3 ; 8A/80C3

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown8AE2F8
        rts

        .databank 0

        ; 8A/80C8

    .endsection Unsorted8A80C3Section


    .section Unsorted8A80C8Section

      .al
      .xl

      rsUnknown8A80C8 ; 8A/80C8

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlArenaMenuRunStep
        rts

        .databank 0

        ; 8A/80CD

    .endsection Unsorted8A80C8Section


    .section Unsorted8A80CDSection

      .al
      .xl

      rsUnknown8A80CD ; 8A/80CD

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown8AF894
        rts

        .databank 0

        ; 8A/80D2

      rsUnknown8A80D2 ; 8A/80D2

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown8AFA34
        rts

        .databank 0

        ; 8A/80D7

      rsUnknown8A80D7 ; 8A/80D7

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown8AF0F2
        rts

        .databank 0

        ; 8A/80DC

      rsUnknown8A80DC ; 8A/80DC

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown8AF283
        rts

        .databank 0

        ; 8A/80E1

      rsUnknown8A80E1 ; 8A/80E1

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown8AECEF
        rts

        .databank 0

        ; 8A/80E6

      rsUnknown8A80E6 ; 8A/80E6

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown8AEEB1
        rts

        .databank 0

        ; 8A/80EB

      rsUnknown8A80EB ; 8A/80EB

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown8ABCF8
        rts

        .databank 0

        ; 8A/80F0

      rsUnknown8A80F0 ; 8A/80F0

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown8AC04B
        rts

        .databank 0

        ; 8A/80F5

    .endsection Unsorted8A80CDSection


    .section Unsorted8A80F5Section

      .al
      .xl

      rsUnknown8A80F5 ; 8A/80F5

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown8AD81B
        rts

        .databank 0

        ; 8A/80FA

    .endsection Unsorted8A80F5Section


    .section Unsorted8A80FASection

      .al
      .xl

      rsUnknown8A80FA ; 8A/80FA

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown8AD975
        rts

        .databank 0

        ; 8A/80FF

      rsUnknown8A80FF ; 8A/80FF

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown8A81C4
        sep #$20
        lda bBufferINIDISP
        and #$0F
        cmp #$0F
        beq _8111
        inc bBufferINIDISP
        rep #$20
        rts


        _8111
        .as
        rep #$20
        lda $0594,b
        sta wGameStateStep,b
        rts

        .databank 0

        ; 8A/811A

      rsUnknown8A811A ; 8A/811A

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown8A81C4
        sep #$20
        lda bBufferINIDISP
        and #$0F
        beq _812A
        dec bBufferINIDISP
        rep #$20
        rts


        _812A
        .as
        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        lda $0594,b
        sta wGameStateStep,b
        rts

        .databank 0

        ; 8A/8139

      rsUnknown8A8139 ; 8A/8139

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$00F7
        jsl rlUnknown808F6F
        jsr rsUnknown8A8E08
        lda #$0000
        sta $7F766A
        lda #$0010
        sta wGameStateStep,b
        lda #$0000
        sta $0594,b
        sep #$20
        lda #$00
        sta bBufferINIDISP
        rep #$20
        rts

        .databank 0

        ; 8A/815F

      rsUnknown8A815F ; 8A/815F

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlDisableVBlank
        jsl rlResetHDMAEngine
        jsl rlUnknown8A9D39
        jsl rlEnableVBlank
        jsl rlUnknown8A97C2
        rts

        .databank 0

        ; 8A/8174

      rsUnknown8A8174 ; 8A/8174

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown81AB26
        lda #$00E8
        jsl rlUnknown808F6F
        sep #$20
        lda bBufferINIDISP
        rep #$20
        and #$000F
        cmp #$000F
        beq _8191
        jml _81C3


        _8191
        lda #(`procFadeIn)<<8
        sta lR44+1
        lda #<>procFadeIn
        sta lR44
        jsl rlProcEngineFindProc
        bcs _81C3
        lda #$B122
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        bcs _81C3
        lda #$0000
        sta $0D77,b
        lda #$0002
        sta wGameStateStep,b

        _81C3
        rts

        .databank 0

        ; 8A/81C4

      rsUnknown8A81C4 ; 8A/81C4

        .al
        .xl
        .autsiz
        .databank ?

        rep #$20
        lda $7F766A
        cmp #$0000
        beq _81DE
        cmp #$0001
        beq _81DF
        cmp #$0002
        beq _81F1
        cmp #$0003
        beq _81F6

        _81DE
        rts


        _81DF
        lda #$00A0
        sta wR0
        lda #$0060
        sta wR1
        ldx #$0000
        jsr rsUnknown8A9539
        bra _81DE


        _81F1
        jsr rsUnknown8AAF0A
        bra _81DE


        _81F6
        lda #$00A0
        sta wR0
        lda #$0060
        sta wR1
        ldx #$0000
        jsr rsUnknown8A956F
        bra _81DE

        .databank 0

        ; 8A/8208

    .endsection Unsorted8A80FASection


    .section Unsorted8A8208Section

      .al
      .xl

      rlUnknown8A8208 ; 8A/8208

        .al
        .xl
        .autsiz
        .databank ?

        lda $0788,b
        bit #$0020
        beq _8214
        jml rlUnknown88973F


        _8214
        lda $0891,b
        cmp #$0001
        beq _8223
        cmp #$0003
        beq _8227
        bra _822B


        _8223
        jml _82C8


        _8227
        jml _8349


        _822B
        lda wJoy1New
        bit #$A0C0
        beq _824A
        jsr rsUnknown8A89F0
        stz wMapScrollDirectionIdentifier,b
        lda $0891,b
        cmp #$0004
        beq _827D
        cmp #$0007
        bne _8266
        stz $0891,b
        bra _827D


        _824A
        lda wJoy1Input
        sta wMapScrollDirectionIdentifier,b
        beq _8266
        lda $0891,b
        cmp #$0004
        beq _8263
        cmp #$0005
        beq _8263
        jsr rsUnknown8A8393
        bra _8266


        _8263
        jsr rsUnknown8A8643

        _8266
        lda $088D,b
        sec
        sbc #$0012
        sta wR0
        lda $088F,b
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
        ldy #$EE52
        lda $088D,b
        sec
        sbc #$0008
        sta wR0
        lda $088F,b
        sec
        sbc #$0008
        sta wR1
        lda #$0000
        sta wR5
        lda #$0000
        sta wR4
        lda $0891,b
        cmp #$0004
        beq _82B4
        cmp #$0005
        beq _82B4
        bra _82B9


        _82B4
        lda #$0006
        sta wR4

        _82B9
        lda wVBlankEnabledFramecount
        and #$0018
        beq _82C3
        ldy #$EE3C

        _82C3
        jsl rlPushToOAMBuffer
        rtl


        _82C8
        jsr rsUnknown8A8783
        lda wJoy1New
        beq _82DC
        jsr rsUnknown8A89F0
        lda $0891,b
        beq _82DC
        cmp #$0003
        beq _8313

        _82DC
        lda $0893,b
        tax
        lda $8A8343,x
        and #$00FF
        clc
        adc #$0004
        sta wR0
        lda #$00A8
        sta wR1
        lda #$0000
        jsl rlUnknown88A704
        lda #$00A0
        sta wR0
        lda #$0060
        sta wR1
        ldx #$0000
        jsr rsUnknown8A956F
        lda $088F,b
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
        ldy #$EE52
        lda $088D,b
        sec
        sbc #$0008
        sta wR0
        lda $088F,b
        sec
        sbc #$0008
        sta wR1
        lda #$0000
        sta wR5
        lda #$0004
        sta wR4
        ldy #$EE68
        jsl rlPushToOAMBuffer
        rtl

        .byte $18, $38, $58, $78, $98, $B8


        _8349
        jsr rsUnknown8A8980
        lda wJoy1New
        jsr rsUnknown8A89F0
        lda $0891,b
        cmp #$0002
        bcc _8386
        lda $0895,b
        tax
        lda $8A8387,x
        and #$00FF
        sta wR0
        lda $8A838D,x
        and #$00FF
        sta wR1
        lda #$0000
        jsl rlUnknown88A704
        lda #$00A0
        sta wR0
        lda #$0060
        sta wR1
        ldx #$0000
        jsr rsUnknown8A9539

        _8386
        rtl

        .databank 0

        ; 8A/8387

    .endsection Unsorted8A8208Section


    .section Unsorted8A8393Section

      .al
      .xl

      rsUnknown8A8393 ; 8A/8393

        .al
        .xl
        .autsiz
        .databank ?

        lda $0897,b
        sta wTempVariable1,b
        and #$001C
        lsr a
        tax
        lda $8A847E,x
        sta wR0
        lda $8A848A,x
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
        lda $0897,b
        cmp wR0
        beq _83CA
        sec
        sbc #$0001
        bra _8401


        _83D8
        lda $0897,b
        cmp wR1
        bcs _83CA
        clc
        adc #$0001
        bra _8401


        _83E5
        lda $0897,b
        cmp #$0004
        bcc _83CA
        sec
        sbc #$0004
        bra _8401


        _83F3
        lda $0897,b
        cmp #$0014
        bcs _83CA
        clc
        adc #$0004
        bra _8401


        _8401
        sta $0897,b
        asl a
        tax
        lda aUnknown8A99DB,x
        sta $088D,b
        lda aUnknown8A9A0B,x
        sta $088F,b
        jsl rlUnknown8A8496
        lda #$0007
        jsl rlPlaySoundEffect
        rts


        _8420
        lda $7F763A
        beq _847D
        lda wTempVariable1,b
        beq _846D
        sec
        sbc #$0001
        sta wTempVariable1,b

        _8432
        asl a
        tax
        lda $7F757A,x
        asl a
        tax
        lda $7F75AA,x
        beq _8420
        lda wTempVariable1,b
        bra _8401


        _8445
        lda $7F763A
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
        lda $7F757A,x
        asl a
        tax
        lda $7F75AA,x
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


    .section Unsorted8A8496Section

      .al
      .xl

      rlUnknown8A8496 ; 8A/8496

        .al
        .xl
        .autsiz
        .databank ?

        phk
        plb
        .databank $8A
        lda #$8000
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$B6AD
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$3000
        sta aCurrentTilemapInfo,b
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0200, $80, $B000

        lda #$8A00
        sta lRoutineVariable+1,b
        lda #$85EF
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
        lda $0891,b
        beq _84EF
        cmp #$0004
        beq _84EF
        cmp #$0005
        beq _84EF
        jml _857E


        _84EF
        lda $0897,b
        asl a
        tax
        lda $7F757A,x
        asl a
        tax
        lda $7F75AA,x
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
        lda #$8A00
        sta lRoutineVariable+1,b
        lda #$8621
        sta lRoutineVariable,b
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$0110
        jsl rlDrawMenuTextLine
        lda #$8A00
        sta lRoutineVariable+1,b
        lda #$8627
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
        jsl rlUnknown87913E
        jsl rlGetSelectedUnitMaxHP
        ldx #$30F0
        stx aCurrentTilemapInfo,b
        ldx #$0116
        jsl rlUnknown87913E
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
        lda aUnknown89A76C+1,x
        sta lRoutineVariable+1,b
        lda aUnknown89A76C,x
        sta lRoutineVariable,b
        lda #$3400
        sta aCurrentTilemapInfo,b
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$010E
        jsl rlDrawMenuTextLine
        lda #$8A00
        sta lRoutineVariable+1,b
        lda #$863B
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
        jsl rlUnknown87913E
        rtl

        .databank 0

        ; 8A/85EF

    .endsection Unsorted8A8496Section


    .section Unsorted8A8643Section

      .al
      .xl

      rsUnknown8A8643 ; 8A/8643

        .al
        .xl
        .autsiz
        .databank ?

        lda $0897,b
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
        jsr rsUnknown8A870D
        bcs _8676
        rts


        _8670
        jsr rsUnknown8A869A
        bcs _8676
        rts


        _8676
        jsl rlUnknown8A8496
        lda #$0007
        jsl rlPlaySoundEffect
        rts

        .databank 0

        ; 8A/8682

    .endsection Unsorted8A8643Section


    .section Unsorted8A869ASection

      .al
      .xl

      rsUnknown8A869A ; 8A/869A

        .al
        .xl
        .autsiz
        .databank ?

        lda $0897,b
        sta wTempVariable1,b
        sta wTempVariable2,b

        _86A3
        lda $7F763A
        beq _870B
        lda wTempVariable1,b
        beq _86E6
        sec
        sbc #$0001
        sta wTempVariable1,b

        _86B5
        asl a
        tax
        lda $7F757A,x
        asl a
        tax
        lda $7F75AA,x
        beq _86A3
        sta wRoutineVariable1,b
        lda wSelectedUnitDataRAMPointer,b
        pha
        lda wRoutineVariable1,b
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitDeploymentOffset
        sta wRoutineVariable1,b
        jsl rlUnknown87A01A
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
        sta $0897,b
        asl a
        tax
        lda aUnknown8A99DB,x
        sta $088D,b
        lda aUnknown8A9A0B,x
        sta $088F,b
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

      rsUnknown8A870D ; 8A/870D

        .al
        .xl
        .autsiz
        .databank ?

        lda $0897,b
        sta wTempVariable1,b
        sta wTempVariable2,b

        _8716
        lda $7F763A
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
        lda $7F757A,x
        asl a
        tax
        lda $7F75AA,x
        beq _8716
        sta wRoutineVariable1,b
        lda wSelectedUnitDataRAMPointer,b
        pha
        lda wRoutineVariable1,b
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitDeploymentOffset
        sta wRoutineVariable1,b
        jsl rlUnknown87A01A
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
        sta $0897,b
        asl a
        tax
        lda aUnknown8A99DB,x
        sta $088D,b
        lda aUnknown8A9A0B,x
        sta $088F,b
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

      rsUnknown8A8783 ; 8A/8783

        .al
        .xl
        .autsiz
        .databank ?

        lda wJoy1Repeated
        bit #$0200
        bne _8790
        bit #$0100
        bne _879E

        _878F
        rts


        _8790
        lda $0893,b
        beq _878F
        sec
        sbc #$0001
        sta $0893,b
        bra _87AD


        _879E
        lda $0893,b
        cmp #$0005
        bcs _878F
        clc
        adc #$0001
        sta $0893,b

        _87AD
        jsr rsUnknown8A87B8
        lda #$0007
        jsl rlPlaySoundEffect
        rts

        .databank 0

        ; 8A/87B8

    .endsection Unsorted8A8783Section


    .section Unsorted8A87B8Section

      .al
      .xl

      rsUnknown8A87B8 ; 8A/87B8

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$8000
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$B6AD
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$3400
        sta aCurrentTilemapInfo,b
        lda $0893,b
        asl a
        tax
        jsr (aUnknown8A87F3,x)
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

      aUnknown8A87F3 ; 8A/87F3

        .word <>rsUnknown8A883A
        .word <>rsUnknown8A87FF
        .word <>rsUnknown8A8812
        .word <>rsUnknown8A8825
        .word <>rsUnknown8A889A
        .word <>rsUnknown8A8876

        ; 8A/87FF

      rsUnknown8A87FF ; 8A/87FF

        .al
        .xl
        .autsiz
        .databank ?

        lda #$8A00
        sta lRoutineVariable+1,b
        lda #$88E0
        sta lRoutineVariable,b
        jsl rlUnknown879F12
        bcc rsUnknown8A886F
        rts

        .databank 0

        ; 8A/8812

      rsUnknown8A8812 ; 8A/8812

        .al
        .xl
        .autsiz
        .databank ?

        lda #$8A00
        sta lRoutineVariable+1,b
        lda #$88F4
        sta lRoutineVariable,b
        jsl rlUnknown879F67
        bcc rsUnknown8A886F
        rts

        .databank 0

        ; 8A/8825

      rsUnknown8A8825 ; 8A/8825

        .al
        .xl
        .autsiz
        .databank ?

        lda #$8A00
        sta lRoutineVariable+1,b
        lda #$8908
        sta lRoutineVariable,b
        lda wCurrentChapter,b
        cmp #$0006
        beq rsUnknown8A8863
        rts

        .databank 0

        ; 8A/883A

      rsUnknown8A883A ; 8A/883A

        .al
        .xl
        .autsiz
        .databank ?

        lda #$8A00
        sta lRoutineVariable+1,b
        lda #$891C
        sta lRoutineVariable,b
        rts

        .databank 0

        ; 8A/8847

      rsUnknown8A8847 ; 8A/8847

        .al
        .xl
        .autsiz
        .databank ?

        lda #$8A00
        sta lRoutineVariable+1,b
        lda #$896C
        sta lRoutineVariable,b
        bra rsUnknown8A886F

        .databank 0

        ; 8A/8855

      rsUnknown8A8855 ; 8A/8855

        .al
        .xl
        .autsiz
        .databank ?

        lda #$8A00
        sta lRoutineVariable+1,b
        lda #$8958
        sta lRoutineVariable,b
        bra rsUnknown8A886F

        .databank 0

        ; 8A/8863

      rsUnknown8A8863 ; 8A/8863

        ; Runs on into rsUnknown8A886F.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$8A00
        sta lRoutineVariable+1,b
        lda #$8944
        sta lRoutineVariable,b

        .databank 0

        ; 8A/886F

      rsUnknown8A886F ; 8A/886F

        .al
        .xl
        .autsiz
        .databank ?

        lda #$3800
        sta aCurrentTilemapInfo,b
        rts

        .databank 0

        ; 8A/8876

      rsUnknown8A8876 ; 8A/8876

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #SkillIDSteal
        jsl rlCheckIfUnitHasSpecifiedPersonalOrClassSkill
        bcs _8887
        jsl rlUnknown879F9C
        bcs _8887
        bra rsUnknown8A8863


        _8887
        jsl rlUnknown879F9C
        bcc rsUnknown8A8847
        lda #$8A00
        sta lRoutineVariable+1,b
        lda #$896C
        sta lRoutineVariable,b
        rts

        .databank 0

        ; 8A/889A

      rsUnknown8A889A ; 8A/889A

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #SkillIDDance
        jsl rlCheckIfUnitHasSpecifiedPersonalOrClassSkill
        bcs _88CD
        jsl rlGetSelectedUnitDeploymentOffset
        sta wActiveUnitDeploymentOffset,b
        jsl rlUnknown84F8D9
        lda wAIGroupLeaderFieldMovement
        and #$00FF
        bne _88C0
        lda $7E2028
        and #$00FF
        beq rsUnknown8A8863

        _88C0
        lda #$8A00
        sta lRoutineVariable+1,b
        lda #$8930
        sta lRoutineVariable,b
        rts


        _88CD
        jsl rlUnknown87A006
        bcc rsUnknown8A8855
        lda #$8A00
        sta lRoutineVariable+1,b
        lda #$8958
        sta lRoutineVariable,b
        rts

        .databank 0

        ; 8A/88E0

    .endsection Unsorted8A87B8Section


    .section Unsorted8A8980Section

      .al
      .xl

      rsUnknown8A8980 ; 8A/8980

        .al
        .xl
        .autsiz
        .databank ?

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
        lda $0895,b
        beq _8996
        sec
        sbc #$0001
        sta $0895,b
        bra _89E0


        _89A5
        lda $0895,b
        cmp #$0005
        bcs _8996
        clc
        adc #$0001
        sta $0895,b
        bra _89E0


        _89B6
        lda $0895,b
        cmp #$0003
        bcc _8996
        sec
        sbc #$0003
        sta $0895,b
        bra _89E8


        _89C7
        lda $0895,b
        cmp #$0003
        bcs _8996
        clc
        adc #$0003
        cmp #$0006
        bcc _89DB
        lda #$0005

        _89DB
        sta $0895,b
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

      rsUnknown8A89F0 ; 8A/89F0

        .al
        .xl
        .autsiz
        .databank ?

        lda $04BA,b
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
        jsr rsUnknown8A8A84
        rts


        _8A22
        jsr rsUnknown8A8BAB
        rts


        _8A26
        jsr rsUnknown8A8C8B
        rts


        _8A2A
        lda $0891,b
        bne _8A1D
        lda $0897,b
        asl a
        tax
        lda $7F757A,x
        asl a
        tax
        lda $7F75AA,x
        beq _8A1D
        sta wSelectedUnitDataRAMPointer,b
        sta $7F766C
        lda #$FFFF
        sta $0891,b
        jsl rlGetSelectedUnitDeploymentOffset
        sta wActiveUnitDeploymentOffset,b
        lda #$0002
        sta wGameStateStep,b
        lda #$B6B6
        sta $7F8183
        lda #$0000
        sta $7F819D
        lda #$0008
        jsl rlPlaySoundEffect
        lda #$BBD9
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        rts

        .databank 0

        ; 8A/8A84

      rsUnknown8A8A84 ; 8A/8A84

        .al
        .xl
        .autsiz
        .databank ?

        lda $0891,b
        cmp #$0001
        beq _8AA0
        cmp #$0003
        beq _8AA4
        cmp #$0004
        beq _8AA8
        cmp #$0005
        beq _8AA8
        jml _8B48


        _8A9F
        rts


        _8AA0
        jsr rsUnknown8A8F8F
        rts


        _8AA4
        jsr rsUnknown8A9389
        rts


        _8AA8
        lda $0897,b
        asl a
        tax
        lda $7F757A,x
        asl a
        tax
        lda $7F75AA,x
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
        jsl rlUnknown87A01A
        lda wSelectedUnitDataRAMPointer,b
        sta wRoutineVariable1,b
        pla
        sta wSelectedUnitDataRAMPointer,b
        bcc _8B3C
        lda wUnknown000D79,b
        bit #$0800
        bne _8B22
        lda $0899,b
        sta $0897,b
        asl a
        tax
        lda aUnknown8A99DB,x
        sta $088D,b
        lda aUnknown8A9A0B,x
        sta $088F,b
        lda $0891,b
        cmp #$0005
        beq _8B17
        jsl rlUnknown84B6A6
        rts


        _8B17
        jsl rlUnknown84B6F6
        lda #$0007
        sta $0891,b
        rts


        _8B22
        lda wSelectedUnitDataRAMPointer,b
        pha
        lda wRoutineVariable1,b
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitDeploymentOffset
        sta $0774,b
        pla
        sta wSelectedUnitDataRAMPointer,b
        jml _8B92

        .byte $60


        _8B3C
        lda #$0022
        jsl rlPlaySoundEffect
        rts


        _8B44
        jsr rsUnknown8A8C8B
        rts


        _8B48
        lda $0897,b
        asl a
        tax
        lda $7F757A,x
        asl a
        tax
        lda $7F75AA,x
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
        jsr rsUnknown8A87B8
        lda #$0001
        sta $0891,b
        jsl rlGetSelectedUnitCharacterID
        jsl rlUnknown8A979C
        jsr rsUnknown8A8CB7
        lda #$0008
        jsl rlPlaySoundEffect
        rts


        _8B92
        jsl rlUnknown8881E5
        lda #$0020
        tsb $0788,b
        lda #(`procUnknown889396)<<8
        sta lR44+1
        lda #<>procUnknown889396
        sta lR44
        jsl rlProcEngineCreateProc
        rts

        .databank 0

        ; 8A/8BAB

      rsUnknown8A8BAB ; 8A/8BAB

        .al
        .xl
        .autsiz
        .databank ?

        lda $0891,b
        beq _8BD2
        cmp #$0001
        beq _8C28
        cmp #$0003
        beq _8BD9
        cmp #$0004
        beq _8BF6
        cmp #$0005
        beq _8BF6

        _8BC4
        rts


        _8BC5
        jsl rlUnknown84AF17
        bcs _8BC4
        lda #$0016
        sta wGameStateStep,b
        rts


        _8BD2
        lda #$0016
        sta wGameStateStep,b
        rts


        _8BD9
        lda $088B,b
        cmp #$0001
        beq _8BC5
        lda #$0000
        sta $0891,b
        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        lda #$0014
        sta wGameStateStep,b
        rts


        _8BF6
        lda $0899,b
        sta $0897,b
        asl a
        tax
        lda aUnknown8A99DB,x
        sta $088D,b
        lda aUnknown8A9A0B,x
        sta $088F,b
        jsl rlUnknown8A8496
        lda #$0000
        sta $0891,b
        jsl rlUnknown85921D
        lda #$0800
        trb wUnknown000D79,b
        lda #$0021
        jsl rlPlaySoundEffect
        rts


        _8C28
        jsr rsUnknown8A8C2C
        rts

        .databank 0

        ; 8A/8C2C

      rsUnknown8A8C2C ; 8A/8C2C

        .al
        .xl
        .autsiz
        .databank ?

        stz $0891,b
        ldx #$07FE
        lda #$00FF

        _8C35
        sta aBG3TilemapBuffer,x
        dec x
        dec x
        bpl _8C35
        jsl rlUnknown8A8496
        lda #$8000
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$B6AD
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

      rsUnknown8A8C8B ; 8A/8C8B

        .al
        .xl
        .autsiz
        .databank ?

        lda $0891,b
        bne _8CB6
        ldx #$01FE
        lda #$00FF

        _8C96
        sta $7E8088,x
        dec x
        dec x
        bpl _8C96
        jsr rsUnknown8A929B
        lda #$0009
        jsl rlPlaySoundEffect
        lda #(`procUnknown85DDDB)<<8
        sta lR44+1
        lda #<>procUnknown85DDDB
        sta lR44
        jsl rlProcEngineCreateProc

        _8CB6
        rts

        .databank 0

        ; 8A/8CB7

      rsUnknown8A8CB7 ; 8A/8CB7

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$001E

        _8CBA
        lda $8C9800,x
        sta aBGPaletteBuffer,b,x
        dec x
        dec x
        bpl _8CBA
        ldx #$01FE

        _8CC8
        lda $DA6500,x
        sta $7E8088,x
        dec x
        dec x
        bpl _8CC8
        jsl rlUnknown879F12
        bcs _8D06
        lda $DA6552
        and #$E3FF
        sta $7E80DA
        lda $DA6554
        and #$E3FF
        sta $7E80DC
        lda $DA6592
        and #$E3FF
        sta $7E811A
        lda $DA6594
        and #$E3FF
        sta $7E811C

        _8D06
        jsl rlUnknown879F67
        bcs _8D38
        lda $DA655A
        and #$E3FF
        sta $7E80E2
        lda $DA655C
        and #$E3FF
        sta $7E80E4
        lda $DA659A
        and #$E3FF
        sta $7E8122
        lda $DA659C
        and #$E3FF
        sta $7E8124

        _8D38
        lda wCurrentChapter,b
        cmp #$0006
        bne _8D6C
        lda $DA6562
        and #$E3FF
        sta $7E80EA
        lda $DA6564
        and #$E3FF
        sta $7E80EC
        lda $DA65A2
        and #$E3FF
        sta $7E812A
        lda $DA65A4
        and #$E3FF
        sta $7E812C

        _8D6C
        lda #SkillIDDance
        jsl rlCheckIfUnitHasSpecifiedPersonalOrClassSkill
        bcs _8DC2
        jsl rlGetSelectedUnitDeploymentOffset
        sta wActiveUnitDeploymentOffset,b
        jsl rlUnknown84F8D9
        lda wAIGroupLeaderFieldMovement
        and #$00FF
        bne _8DC8
        lda $7E2028
        and #$00FF
        beq _8D94
        bra _8DC8


        _8D94
        lda $DA656A
        and #$E3FF
        sta $7E80F2
        lda $DA656C
        and #$E3FF
        sta $7E80F4
        lda $DA65AA
        and #$E3FF
        sta $7E8132
        lda $DA65AC
        and #$E3FF
        sta $7E8134
        bra _8DC8


        _8DC2
        jsl rlUnknown87A006
        bcc _8D94

        _8DC8
        jsl rlUnknown879F9C
        bcs _8DFA
        lda $DA6572
        and #$E3FF
        sta $7E80FA
        lda $DA6574
        and #$E3FF
        sta $7E80FC
        lda $DA65B2
        and #$E3FF
        sta $7E813A
        lda $DA65B4
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

      rsUnknown8A8E08 ; 8A/8E08

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
        jsl rlUnknown80B08C
        jsl rlDMAByStruct

          .structDMAToVRAM $D80000, $4000, $80, $0000

        jsl rlDMAByStruct

          .structDMAToVRAM $D77800, $0800, $80, $A000

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

          .structDMAToVRAM $D76800, $0800, $80, $9800

        lda #$8A00
        sta lR19+1
        lda #$8F58
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        lda #$8A00
        sta lR19+1
        lda #$8F60
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        jsl rlUnknown8881EC
        jsl rlUnknown88DE1B
        jsl rlDMAByStruct

          .structDMAToVRAM $DE40C0, $0400, $80, $C000

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
        lda $8C9800,x
        sta aBGPaletteBuffer,b,x
        dec x
        dec x
        bpl _8ED9
        ldx #$00FE

        _8EE7
        lda $8C9500,x
        sta aOAMPaletteBuffer,b,x
        dec x
        dec x
        bpl _8EE7
        ldx #$001E

        _8EF5
        lda $8C9D00,x
        sta aOAMPaletteBuffer,b,x
        dec x
        dec x
        bpl _8EF5
        jsl rlUnknown899FDC
        sep #$20
        rep #$10
        ldx #$2542
        stx DecompressionVariables
        lda #$C0
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
        jsl rlUnknown8A8496
        rts

        .databank 0

        ; 8A/8F56

    .endsection Unsorted8A8E08Section


    .section Unsorted8A8F68Section

      .al
      .xl

      rlUnknown8A8F68 ; 8A/8F68

        .al
        .xl
        .autsiz
        .databank ?

        phb
        phk
        plb
        .databank $8A
        ldx #$00FE

        _8F6E
        lda aUnknown8C9800,x
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
        jsl rlUnknown8A8496
        plb
        .databank $8A
        rtl

        .databank 0

        ; 8A/8F8F

    .endsection Unsorted8A8F68Section


    .section Unsorted8A8F8FSection

      .al
      .xl

      rsUnknown8A8F8F ; 8A/8F8F

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda $0893,b
        beq _8FE4
        cmp #$0001
        beq _8FB6
        cmp #$0002
        beq _8FDC
        cmp #$0003
        beq _8FE0
        cmp #$0004
        beq _9002
        cmp #$0005
        beq _9021
        rts


        _8FAE
        lda #$0022
        jsl rlPlaySoundEffect
        rts


        _8FB6
        jsl rlUnknown879F12
        bcc _8FAE
        jsl rlUnknown84AF17
        bcs _8FAE
        lda #$000A
        jsl rlPlaySoundEffect
        lda wRoutineVariable1,b
        sta wActiveUnitDeploymentOffset,b
        lda #$FFFF
        sta $07E0,b
        lda #$0016
        sta wGameStateStep,b
        rts


        _8FDC
        jsr rsUnknown8A9069
        rts


        _8FE0
        jsr rsUnknown8A9038
        rts


        _8FE4
        jsr rsUnknown8A9D22
        lda #$000F
        sta wGameStateStep,b
        lda #$0015
        sta $0594,b
        lda #$0003
        sta $7F766A
        lda #$000A
        jsl rlPlaySoundEffect
        rts


        _9002
        lda $0897,b
        sta $0899,b
        lda #SkillIDDance
        jsl rlCheckIfUnitHasSpecifiedPersonalOrClassSkill
        bcc _9019
        jsl rlUnknown87A006
        bcs _901D
        bra _8FAE


        _9019
        jsr rsUnknown8A90C7
        rts


        _901D
        jsr rsUnknown8A918A
        rts


        _9021
        lda $0897,b
        sta $0899,b
        jsl rlUnknown879F9C
        bcc _8FAE
        jsr rsUnknown8A9209
        lda #$000A
        jsl rlPlaySoundEffect
        rts

        .databank 0

        ; 8A/9038

      rsUnknown8A9038 ; 8A/9038

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda wCurrentChapter,b
        cmp #$0006
        beq _9061
        lda #$0003
        sta $0891,b
        lda #$0009
        sta wGameStateStep,b
        lda #$0003
        sta $08A9,b
        lda #$0005
        sta $7F8082
        lda #$000A
        jsl rlPlaySoundEffect
        rts


        _9061
        lda #$0022
        jsl rlPlaySoundEffect
        rts

        .databank 0

        ; 8A/9069

      rsUnknown8A9069 ; 8A/9069

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown879F67
        bcc _90BF
        jsl rlUnknown84AF17
        lda #$000A
        jsl rlPlaySoundEffect
        jsl rlUnknown88C25D
        lda wCursorXOffset,b
        clc
        adc wMapScrollXPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta $0778,b
        lda wCursorYOffset,b
        clc
        adc wMapScrollYPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta $077A,b
        lda wCursorYOffset,b
        sec
        sbc #$0020
        sta wCursorYOffset,b
        lda #$0003
        sta $07E0,b
        lda wRoutineVariable1,b
        sta wActiveUnitDeploymentOffset,b
        tax
        lda #$0001
        jsl rlUnknown84D03E
        lda #$0016
        sta wGameStateStep,b
        rts


        _90BF
        lda #$0022
        jsl rlPlaySoundEffect
        rts

        .databank 0

        ; 8A/90C7

      rsUnknown8A90C7 ; 8A/90C7

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlGetSelectedUnitDeploymentOffset
        sta wActiveUnitDeploymentOffset,b
        jsl rlUnknown84F8D9
        lda wAIGroupLeaderFieldMovement
        and #$00FF
        bne _90E4
        lda $7E2028
        and #$00FF
        beq _9150

        _90E4
        stz wBufferBG2VOFS
        stz $0891,b
        lda #$8A00
        sta lRoutineVariable+1,b
        lda #$9158
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
        sta wUnknown00052A,b
        lda #$0001
        sta wUnknown00052C,b
        jsl rlUnknown87829A
        jsr rsUnknown8A929B
        lda #$8500
        sta lR44+1
        lda #$E9C7
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


    .section Unsorted8A918ASection

      .al
      .xl

      rsUnknown8A918A ; 8A/918A

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$8A00
        sta lRoutineVariable+1,b
        lda #$91D7
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

        jsr rsUnknown8A929B
        jsl rlUnknown84B6E2
        rts

        .databank 0

        ; 8A/91D7

    .endsection Unsorted8A918ASection


    .section Unsorted8A9209Section

      .al
      .xl

      rsUnknown8A9209 ; 8A/9209

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0005
        sta $0891,b
        jsl rlGetSelectedUnitDeploymentOffset
        sta wActiveUnitDeploymentOffset,b
        stz $0897,b
        jsr rsUnknown8A870D
        lda #$8A00
        sta lRoutineVariable+1,b
        lda #$9269
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

        jsr rsUnknown8A929B
        jsl rlUnknown8A8496
        rts

        .databank 0

        ; 8A/9269

    .endsection Unsorted8A9209Section


    .section Unsorted8A929BSection

      .al
      .xl

      rsUnknown8A929B ; 8A/929B

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$001E

        _929E
        lda aUnknownDE0000,x
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

      rlUnknown8A92AA ; 8A/92AA

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0004
        sta $0891,b
        stz $0897,b
        jsr rsUnknown8A870D
        jsl rlUnknown8A8496
        rtl

        .databank 0

        ; 8A/92BB

    .endsection Unsorted8A92AASection


    .section Unsorted8A92BBSection

      .al
      .xl

      rlUnknown8A92BB ; 8A/92BB

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown88C25D
        jsl rlUnknown84AF57
        bcs _92D5
        lda wRoutineVariable1,b
        sta wActiveUnitDeploymentOffset,b
        jsl rlUnknown8881DE
        lda #$0016
        sta wGameStateStep,b

        _92D5
        rtl

        .databank 0

        ; 8A/92D6

    .endsection Unsorted8A92BBSection


    .section Unsorted8A92D6Section

      .al
      .xl

      rlUnknown8A92D6 ; 8A/92D6

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown88C25D
        jsl rlUnknown84AF57
        bcs _92FE
        lda wRoutineVariable1,b
        sta wActiveUnitDeploymentOffset,b
        jsl rlUnknown8881DE
        jsl rlUnknown8881E5
        lda wCursorYOffset,b
        sec
        sbc #$0010
        sta wCursorYOffset,b
        lda #$0016
        sta wGameStateStep,b

        _92FE
        rtl

        .databank 0

        ; 8A/92FF

      rlUnknown8A92FF ; 8A/92FF

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phk
        plb
        .databank $8A
        jsl rlUnknown8A8496
        sep #$20
        lda #$17
        sta bBufferTM
        rep #$20
        jsr rsUnknown8A87B8
        lda #$0001
        sta $0891,b
        jsl rlGetSelectedUnitCharacterID
        jsl rlUnknown8A979C
        jsl rlDMAByStruct

          .structDMAToVRAM $DA6500, $0200, $80, $AD00

        lda $0899,b
        sta $0897,b
        asl a
        tax
        lda @l aUnknown8A99DB,x
        sta $088D,b
        lda @l aUnknown8A9A0B,x
        sta $088F,b
        rtl

        .databank 0

        ; 8A/9342

    .endsection Unsorted8A92D6Section


    .section Unsorted8A9342Section

      .al
      .xl

      rlUnknown8A9342 ; 8A/9342

        .al
        .xl
        .autsiz
        .databank ?

        phb
        phx
        phy
        lda #$0000
        jsl rlGetFactionSlotLocationID
        cmp $089F,b
        bne _9364
        lda #$0000
        jsl rlGetLocationEventDataEntry
        jsl rlBuildDeadPlayerCharacterList
        jsl rlUnknown80B9AD
        jsl rlUnknown8A9A56

        _9364
        lda $0899,b
        sta $0897,b
        asl a
        tax
        lda aUnknown8A99DB,x
        sta $088D,b
        lda aUnknown8A9A0B,x
        sta $088F,b
        ply
        plx
        plb
        .databank ?
        rtl

        .databank 0

        ; 8A/937E

      rlUnknown8A937E ; 8A/937E

        ; Nothing in the build reaches this; it did not run in fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0005
        sta $0891,b
        jsl rlUnknown8A8496
        rtl

        .databank 0

        ; 8A/9389

    .endsection Unsorted8A9342Section


    .section Unsorted8A9389Section

      .al
      .xl

      rsUnknown8A9389 ; 8A/9389

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown87EF46
        sta wR0
        lda $0895,b
        asl a
        tax
        lda aUnknown8A945E,x
        sta wR1
        lda wR0
        bit wR1
        beq _93BE
        lda $0895,b
        beq _93EB
        cmp #$0001
        beq _93D5
        cmp #$0002
        beq _9423
        cmp #$0003
        beq _940A
        cmp #$0004
        beq _9401
        cmp #$0005
        beq _93BF

        _93BE
        rts


        _93BF
        lda #$000D
        sta wGameStateStep,b
        lda #$0004
        sta $08A9,b
        lda #$0000
        sta $7F8082
        bra _944E

        rts


        _93D5
        lda #$000D
        sta wGameStateStep,b
        lda #$0005
        sta $08A9,b
        lda #$0001
        sta $7F8082
        bra _944E

        rts


        _93EB
        lda #$000D
        sta wGameStateStep,b
        lda #$0004
        sta $08A9,b
        lda #$0002
        sta $7F8082
        bra _944E

        rts


        _9401
        lda #$0005
        sta wGameStateStep,b
        bra _944E

        rts


        _940A
        lda wSelectedUnitDataRAMPointer,b
        sta $089B,b
        lda #$0003
        sta wGameStateStep,b
        lda #$0007
        sta $7F8082
        stz $0AD7,b
        bra _944E

        rts


        _9423
        lda #$0007
        sta wGameStateStep,b
        lda #$0002
        sta $08A9,b
        lda #$0003
        sta $7F8082
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


    .section Unsorted8A94B6Section

      .al
      .xl

      rlUnknown8A94B6 ; 8A/94B6

        .al
        .xl
        .autsiz
        .databank ?

        rep #$30
        lda #$1809
        sta $4300,b
        lda #$8A00
        sta $4303,b
        lda #$94E1
        sta $4302,b
        lda #$0800
        sta $4305,b
        lda #$2000
        sta $2116,b
        sep #$20
        lda #$01
        sta $420B,b
        rep #$20
        rtl

        .databank 0

        ; 8A/94E0

    .endsection Unsorted8A94B6Section


    .section Unsorted8A94E2Section

      .al
      .xl

      rlUnknown8A94E2 ; 8A/94E2

        .al
        .xl
        .autsiz
        .databank ?

        rep #$30
        lda #$1809
        sta $4300,b
        lda #$8A00
        sta $4303,b
        lda #$950D
        sta $4302,b
        lda #$0800
        sta $4305,b
        lda #$2400
        sta $2116,b
        sep #$20
        lda #$01
        sta $420B,b
        rep #$20
        rtl

        .databank 0

        ; 8A/950C

    .endsection Unsorted8A94E2Section


    .section Unsorted8A950ESection

      .al
      .xl

      rsUnknown8A950E ; 8A/950E

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$8A
        pha
        plb
        .databank $8A
        rep #$20
        ldy #$964C
        lda #$0000
        sta wR5
        sta wR4
        lda aDialogue.wUnknown0018A3,b,x
        beq _9534
        cmp #$0001
        beq _952F
        ldy #$96C8
        bra _9534


        _952F
        ldy #$968A
        bra _9534


        _9534
        jsl rlPushToOAMBuffer
        rts

        .databank 0

        ; 8A/9539

      rsUnknown8A9539 ; 8A/9539

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$8A
        pha
        plb
        .databank $8A
        rep #$20
        ldy #$9586
        lda #$0000
        sta wR5
        lda #$0040
        sta wR4
        lda wCurrentChapter,b
        cmp #$FFFF
        beq _956A
        lda aDialogue.wUnknown0018A3,b,x
        beq _956A
        cmp #$0001
        beq _9565
        ldy #$9602
        bra _956A


        _9565
        ldy #$95C4
        bra _956A


        _956A
        jsl rlPushToOAMBuffer
        rts

        .databank 0

        ; 8A/956F

    .endsection Unsorted8A950ESection


    .section Unsorted8A956FSection

      .al
      .xl

      rsUnknown8A956F ; 8A/956F

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$8A
        pha
        plb
        .databank $8A
        rep #$20
        ldy #$9712
        lda #$0000
        sta wR5
        sta wR4
        jsl rlPushToOAMBuffer
        rts

        .databank 0

        ; 8A/9586

    .endsection Unsorted8A956FSection


    .section Unsorted8A9750Section

      .al
      .xl

      rlUnknown8A9750 ; 8A/9750

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = PortraitID

        jsl rlGetDecompressedPortraitDataPointers

        ldx #size(Palette)-2
        ldy #size(Palette)-2

          -
          lda [lR19],y
          sta aOAMPaletteBuffer.aPalette5,b,y
          dec x
          dec x
          dec y
          dec y
          bpl -

        lda #16 * 4 * size(Tile4bpp)
        sta wR0
        lda #$CE00 >> 1
        sta wR1
        phx
        jsl rlDMAByPointer
        plx
        rtl

        .databank 0

        ; 8A/9776

    .endsection Unsorted8A9750Section


    .section Unsorted8A9776Section

      .al
      .xl

      rlUnknown8A9776 ; 8A/9776

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown8AB3FE
        ldx #$001E
        ldy #$001E

        _9780
        lda [lR19],y
        sta aOAMPaletteBuffer.aPalette4,b,y
        dec x
        dec x
        dec y
        dec y
        bpl _9780
        lda #$0800
        sta wR0
        lda #$6B00
        sta wR1
        phx
        jsl rlDMAByPointer
        plx
        rtl

        .databank 0

        ; 8A/979C

    .endsection Unsorted8A9776Section


    .section Unsorted8A979CSection

      .al
      .xl

      rlUnknown8A979C ; 8A/979C

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlGetDecompressedPortraitDataPointers
        ldx #$001E
        ldy #$001E

        _97A6
        lda [lR19],y
        sta aOAMPaletteBuffer.aPalette6,b,y
        dec x
        dec x
        dec y
        dec y
        bpl _97A6
        lda #$0800
        sta wR0
        lda #$6400
        sta wR1
        phx
        jsl rlDMAByPointer
        plx
        rtl

        .databank 0

        ; 8A/97C2

    .endsection Unsorted8A979CSection


    .section Unsorted8A97C2Section

      .al
      .xl

      rlUnknown8A97C2 ; 8A/97C2

        .al
        .autsiz
        .databank ?

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
        lda $089F,b
        sta wEventEngineArgument2,b
        jsl rlGetAndRunChapterMapEventConditions
        bcc +

          lda wSelectedUnitDataRAMPointer,b
          sta $08BA,b
          lda #2
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

        jsl rlUnknown80BA52
        jsl rlGetSelectedUnitCharacterID
        jsl rlUnknown8A9776
        jsl rlUnknown8A94E2
        lda #1
        sta $7F766A
        lda #$0010
        sta wGameStateStep,b
        lda #1
        sta $0594,b
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

      rlUnknown8A9858 ; 8A/9858

        .al
        .xl
        .autsiz
        .databank ?

        phk
        plb
        .databank $8A
        lda #$2400
        sta aCurrentTilemapInfo,b
        jsl rlUnknown87EF46
        sta wTempVariable1,b
        ldx #$000A

        _986A
        lda @l aUnknown8A98AC,x
        sta wR1
        lda wTempVariable1,b
        bit wR1
        bne _9897
        lda #$8A00
        sta lR18+1
        lda #$989A
        sta lR18
        phx
        lda @l aUnknown8A98C4,x
        xba
        clc
        adc @l aUnknown8A98B8,x
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


    .section Table8A98ACSection

      .al
      .xl

      aUnknown8A98AC ; 8A/98AC

        ; Read by rlUnknown8A9858.

        .word $0020, $0040, $0010, $0004, $0008, $0080

        ; 8A/98B8

    .endsection Table8A98ACSection


    .section Table8A98B8Section

      .al
      .xl

      aUnknown8A98B8 ; 8A/98B8

        ; Read by rlUnknown8A9858.

        .word $0002, $000B, $0014, $0001, $000B, $0014

        ; 8A/98C4

    .endsection Table8A98B8Section


    .section Unsorted8A98D0Section

      .al
      .xl

      rlUnknown8A98D0 ; 8A/98D0

        .al
        .xl
        .autsiz
        .databank ?

        phk
        plb
        .databank $8A
        lda wVBlankEnabledFramecount
        jsl rlUnknown88CC75
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
        lda aDeadPlayerCharacterList,x
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
        lda aDeploymentTable._DeploymentOffsets,x
        tax
        lda aDeploymentTable._MapSpriteID,x
        and #$8000
        bne _9958
        lda $88D1C5,x
        sta wR4
        lda #$9A43
        tay
        plx
        phx
        lda aMovementMap,x
        tax
        lda $7F75DA,x
        sec
        sbc #$0008
        sta wR0
        lda $7F760A,x
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
        lda aDeadPlayerCharacterList,x
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
        lda aDeploymentTable._DeploymentOffsets,x
        tax
        lda aDeploymentTable._MapSpriteID,x
        and #$8000
        beq _99D5
        lda $88D255,x
        sta wR4
        lda #$9A4A
        tay
        plx
        phx
        lda aMovementMap,x
        tax
        lda $7F75DA,x
        sec
        sbc #$0008
        sta wR0
        lda $7F760A,x
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

      aUnknown8A99DB ; 8A/99DB

        ; Read by rlUnknown8A9342.

        .word $0048, $0080, $0091, $00B8, $003F, $0058, $00A8, $00C1
        .word $003D, $0056, $00AA, $00C3, $003B, $0054, $00AC, $00C5
        .word $0039, $0052, $00AE, $00C7, $0037, $0050, $00B0, $00C9

        ; 8A/9A0B

    .endsection Table8A99DBSection


    .section Table8A9A0BSection

      .al
      .xl

      aUnknown8A9A0B ; 8A/9A0B

        ; Read by rlUnknown8A9342.

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

      rlUnknown8A9A56 ; 8A/9A56

        .al
        .xl
        .autsiz
        .databank ?

        phk
        plb
        .databank $8A
        lda #$0000
        sta $7F763A
        lda #$0017
        sta wRoutineVariable1,b
        ldx #$002E

        _9A68
        lda wCurrentChapter,b
        cmp #$0006
        bcs _9A7E
        lda @l aUnknown8A9B94,x
        sta $7F757A,x
        lda @l aUnknown8A9BF4,x
        bra _9A8A


        _9A7E
        lda @l aUnknown8A9BC4,x
        sta $7F757A,x
        lda @l aUnknown8A9C24,x

        _9A8A
        asl a
        tay
        lda $9AD4,b,y
        sta $7F75DA,x
        lda $9B04,b,y
        sta $7F760A,x
        lda aDeadPlayerCharacterList,x
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
        sta $7F75AA,x
        plx
        lda $7F763A
        clc
        adc #$0001
        sta $7F763A

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

      aUnknown8A9AD4 ; 8A/9AD4

        ; Read by rlUnknown8A9A56.

        .word $0048, $0080, $0091, $00B8, $003F, $0058, $00A8, $00C1
        .word $003D, $0056, $00AA, $00C3, $003B, $0054, $00AC, $00C5
        .word $0039, $0052, $00AE, $00C7, $0037, $0050, $00B0, $00C9

        ; 8A/9B04

    .endsection Table8A9AD4Section


    .section Table8A9B04Section

      .al
      .xl

      aUnknown8A9B04 ; 8A/9B04

        ; Read by rlUnknown8A9A56.

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

      aUnknown8A9B94 ; 8A/9B94

        ; Read by rlUnknown8A9A56.

        .word $0005, $0000, $000F, $0010, $0003, $0001, $0002, $0004
        .word $000D, $0009, $0016, $0006, $0008, $0012, $000A, $000E
        .word $0007, $0015, $0011, $000C, $0013, $0017, $0014, $000B

        ; 8A/9BC4

    .endsection Table8A9B94Section


    .section Table8A9BC4Section

      .al
      .xl

      aUnknown8A9BC4 ; 8A/9BC4

        ; Read by rlUnknown8A9A56.

        .word $0001, $0000, $0012, $000E, $0002, $0010, $0011, $000A
        .word $0008, $0017, $0014, $0007, $000D, $0015, $000F, $0003
        .word $0004, $0013, $0016, $0006, $0005, $0009, $000C, $000B

        ; 8A/9BF4

    .endsection Table8A9BC4Section


    .section Table8A9BF4Section

      .al
      .xl

      aUnknown8A9BF4 ; 8A/9BF4

        ; Read by rlUnknown8A9A56.

        .word $0001, $0005, $0006, $0004, $0007, $0000, $000B, $0010
        .word $000C, $0009, $000E, $0017, $0013, $0008, $000F, $0002
        .word $0003, $0012, $000D, $0014, $0016, $0011, $000A, $0015

        ; 8A/9C24

    .endsection Table8A9BF4Section


    .section Table8A9C24Section

      .al
      .xl

      aUnknown8A9C24 ; 8A/9C24

        ; Read by rlUnknown8A9A56.

        .byte $01, $00, $00, $00, $04, $00, $0F, $00, $10, $00, $14, $00, $13, $00, $0B, $00
        .byte $08, $00, $15, $00, $07, $00, $17, $00, $16, $00, $0C, $00, $03, $00, $0E, $00
        .byte $05, $00, $06, $00, $02, $00, $11, $00, $0A, $00, $0D, $00, $12, $00, $09, $00
        .byte $6B, $6B, $61, $9C, $61, $9C, $A8, $9C, $A3, $80, $7F, $32, $00

        ; 8A/9C61

    .endsection Table8A9C24Section


    .section Unsorted8A9C61Section

      .al
      .xl

      rlUnknown8A9C61 ; 8A/9C61

        .al
        .xl
        .autsiz
        .databank ?

        lda $0891,b
        cmp #$0003
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

    .endsection Unsorted8A9C61Section


    .section Unsorted8A9D22Section

      .al
      .xl

      rsUnknown8A9D22 ; 8A/9D22

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlGetEventLocationEntryNameID
        asl a
        tax
        lda aUnknown8A9D79,x
        cmp $0510,b
        beq _9D38
        lda #$00E0
        jsl rlUnknown808F6F

        _9D38
        rts

        .databank 0

        ; 8A/9D39

    .endsection Unsorted8A9D22Section


    .section Unsorted8A9D39Section

      .al
      .xl

      rlUnknown8A9D39 ; 8A/9D39

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phk
        plb
        .databank $8A
        jsl rlGetEventLocationEntryNameID
        asl a
        tax
        lda @l aUnknown8A9D79,x
        cmp $0510,b
        beq _9D6C
        lda #$00C0
        jsl rlUnknown808F6F
        jsl rlGetEventLocationEntryNameID
        asl a
        cmp #$005C
        bcs _9D74

        _9D5B
        tax
        lda @l aUnknown8A9D79,x
        cmp $0510,b
        beq _9D6C
        sta $04BA,b
        jsl rlUnknown809654

        _9D6C
        lda #$00E8
        jsl rlUnknown808F6F
        rtl


        _9D74
        lda #$0000
        bra _9D5B

        .databank 0

        ; 8A/9D79

    .endsection Unsorted8A9D39Section


    .section Unsorted8A9DF2Section

      .al
      .xl

      rlUnknown8A9DF2 ; 8A/9DF2

        .al
        .xl
        .autsiz
        .databank ?

        stz $08AB,b
        jsl rlGetItemRAMDataCount
        sta wTempVariable1,b
        ldy #$0001
        ldx #$0000

        _9E02
        tya
        jsl rlGetItemRAMStructEntryByPlayerItemIndex
        bcs _9E51
        jsl rlGetItemRAMStateAndOwner
        lda wR0
        cmp $08A9,b
        bne _9E51
        cmp #$0005
        beq _9E19

        _9E19
        tya
        sta $7F7672,x
        jsl rlGetEffectiveItemIDByItemRAMStructEntry
        sta $7F7A72,x
        jsl rlGetEffectiveItemROMPointerByItemRAMStructEntry
        lda #$0000
        sta $7F7E72,x
        jsl rlCheckItemObtainable
        bcs _9E3E
        lda #$FFFF
        sta $7F7E72,x

        _9E3E
        lda wCurrentItemDataROMPointer,b
        sta $7F7C72,x
        lda wCurrentItemDataRAMPointer,b
        sta $7F7872,x
        inc $08AB,b
        inc x
        inc x

        _9E51
        cpy wTempVariable1,b
        beq _9E59
        inc y
        bra _9E02


        _9E59
        rtl

        .databank 0

        ; 8A/9E5A

      rlUnknown8A9E5A ; 8A/9E5A

        .al
        .xl
        .autsiz
        .databank ?

        stz $08AB,b
        jsl rlGetItemRAMDataCount
        sta wTempVariable1,b
        ldy #$0001
        ldx #$0000

        _9E6A
        tya
        jsl rlGetItemRAMStructEntryByPlayerItemIndex
        bcs _9EAE
        jsl rlGetItemRAMStateAndOwner
        lda wR0
        cmp $08A9,b
        bne _9EAE
        lda wR1
        cmp wSelectedUnitDataRAMPointer,b
        bne _9EAE
        tya
        sta $7F7672,x
        jsl rlGetEffectiveItemIDByItemRAMStructEntry
        sta $7F7A72,x
        jsl rlGetEffectiveItemROMPointerByItemRAMStructEntry
        lda #$0000
        sta $7F7E72,x
        lda wCurrentItemDataROMPointer,b
        sta $7F7C72,x
        lda wCurrentItemDataRAMPointer,b
        sta $7F7872,x
        inc $08AB,b
        inc x
        inc x

        _9EAE
        cpy wTempVariable1,b
        beq _9EB6
        inc y
        bra _9E6A


        _9EB6
        rtl

        .databank 0

        ; 8A/9EB7

    .endsection Unsorted8A9DF2Section


    .section Unsorted8A9EB7Section

      .al
      .xl

      rlUnknown8A9EB7 ; 8A/9EB7

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0000
        stz $08AB,b
        jsl rlGetFirstEquippableWeaponInInventory
        sta $7F8072,x
        sta wTempVariable1,b
        lda wCurrentItemDataROMPointer,b
        beq _9EEC
        sta $7F7C72,x
        lda #$0000
        sta $7F7E72,x
        jsl rlGetEffectiveItemIDByItemRAMStructEntry
        sta $7F7A72,x
        lda wCurrentItemDataRAMPointer,b
        sta $7F7872,x
        inc $08AB,b
        inc x
        inc x

        _9EEC
        ldy #$0007

        _9EEF
        tya
        sta wRoutineVariable1,b
        jsl rlGetItemROMDataByInventorySlot
        lda wCurrentItemDataROMPointer,b
        beq _9F2E
        jsl rlCheckWeaponEquippable
        bcc _9F2E
        lda #$0000
        sta $7F7E72,x
        lda wCurrentItemDataROMPointer,b
        sta $7F7C72,x
        jsl rlGetEffectiveItemIDByItemRAMStructEntry
        sta $7F7A72,x
        lda wCurrentItemDataRAMPointer,b
        sta $7F7872,x
        tya
        cmp wTempVariable1,b
        beq _9F2E
        sta $7F8072,x
        inc $08AB,b
        inc x
        inc x

        _9F2E
        dec y
        bne _9EEF
        rtl

        .databank 0

        ; 8A/9F32

      rlUnknown8A9F32 ; 8A/9F32

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0000
        stz $08AB,b
        jsl rlGetFirstEquippableWeaponInInventory
        sta $7F8072,x
        sta wTempVariable1,b
        jsl rlGetItemMinimumRange
        sta wTempVariable2,b
        jsl rlGetSelectedUnitEquippedWeaponBitfield
        cmp #$0000
        bne _9F59
        lda #$0001
        sta wTempVariable2,b

        _9F59
        lda wCurrentItemDataROMPointer,b
        beq _9F7D
        sta $7F7C72,x
        lda #$0000
        sta $7F7E72,x
        jsl rlGetEffectiveItemIDByItemRAMStructEntry
        sta $7F7A72,x
        lda wCurrentItemDataRAMPointer,b
        sta $7F7872,x
        inc $08AB,b
        inc x
        inc x

        _9F7D
        ldy #$0007

        _9F80
        tya
        sta wRoutineVariable1,b
        jsl rlGetItemROMDataByInventorySlot
        lda wCurrentItemDataROMPointer,b
        beq _9FC8
        jsl rlGetItemMinimumRange
        cmp wTempVariable2,b
        bne _9FC8
        jsl rlCheckWeaponEquippable
        bcc _9FC8
        lda #$0000
        sta $7F7E72,x
        lda wCurrentItemDataROMPointer,b
        sta $7F7C72,x
        jsl rlGetEffectiveItemIDByItemRAMStructEntry
        sta $7F7A72,x
        lda wCurrentItemDataRAMPointer,b
        sta $7F7872,x
        tya
        cmp wTempVariable1,b
        beq _9FC8
        sta $7F8072,x
        inc $08AB,b
        inc x
        inc x

        _9FC8
        dec y
        bne _9F80
        rtl

        .databank 0

        ; 8A/9FCC

    .endsection Unsorted8A9EB7Section


    .section Unsorted8A9FCCSection

      .al
      .xl

      rlUnknown8A9FCC ; 8A/9FCC

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        stz $08AB,b
        jsl rlGetItemRAMDataCount
        tay
        ldx #$0000

        _9FD7
        tya
        jsl rlGetItemRAMStructEntryByPlayerItemIndex
        bcs _A00F
        jsl rlGetItemRAMStateAndOwner
        lda wR0
        cmp $08A9,b
        bne _A00F
        bne _A00F
        tya
        sta $7F7672,x
        jsl rlGetEffectiveItemIDByItemRAMStructEntry
        sta $7F7A72,x
        jsl rlGetEffectiveItemROMPointerByItemRAMStructEntry
        lda #$0000
        sta $7F7E72,x
        lda wCurrentItemDataROMPointer,b
        sta $7F7C72,x
        inc $08AB,b
        inc x
        inc x

        _A00F
        dec y
        bne _9FD7
        rtl

        .databank 0

        ; 8A/A013

    .endsection Unsorted8A9FCCSection


    .section Unsorted8AA013Section

      .al
      .xl

      rlUnknown8AA013 ; 8A/A013

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0005
        sta wR0
        lda $089F,b
        sta wR1
        jsl rlSetItemRAMStateAndOwner
        rtl

        .databank 0

        ; 8A/A022

    .endsection Unsorted8AA013Section


    .section Unsorted8AA02BSection

      .al
      .xl

      rsUnknown8AA02B ; 8A/A02B

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$8A00
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$A022
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$0000
        ldx #$00C0

        _A03D
        sta $7F80C1,x
        dec x
        dec x
        bne _A03D
        lda aCurrentTilemapInfo,b
        pha
        lda #$2000
        sta aCurrentTilemapInfo,b
        jsl rlGetItemDescriptionPointer
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$0000
        jsl rlDrawMenuTextLine
        pla
        sta aCurrentTilemapInfo,b
        lda #$8000
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$B6AD
        sta lMapMenuTilemapRAMEntryPointer,b
        ldx #$0000

        _A077
        lda $7F80C3,x
        sta $7E868A,x
        lda $7F8123,x
        sta $7E86CA,x
        inc x
        inc x
        cpx #$0010
        bne _A077
        ldx #$0000

        _A091
        lda $7F80D3,x
        sta $7E870A,x
        lda $7F8133,x
        sta $7E874A,x
        inc x
        inc x
        cpx #$0010
        bne _A091
        ldx #$0000

        _A0AB
        lda $7F80E3,x
        sta $7E878A,x
        lda $7F8143,x
        sta $7E87CA,x
        inc x
        inc x
        cpx #$0010
        bne _A0AB
        ldx #$0000

        _A0C5
        lda $7F80F3,x
        sta $7E880A,x
        lda $7F8153,x
        sta $7E884A,x
        inc x
        inc x
        cpx #$0010
        bne _A0C5
        ldx #$0000

        _A0DF
        lda $7F8103,x
        sta $7E888A,x
        lda $7F8163,x
        sta $7E88CA,x
        inc x
        inc x
        cpx #$0010
        bne _A0DF
        ldx #$0000

        _A0F9
        lda $7F8113,x
        sta $7E890A,x
        lda $7F8173,x
        sta $7E894A,x
        inc x
        inc x
        cpx #$0010
        bne _A0F9
        lda #$8A00
        sta lRoutineVariable+1,b
        lda #$A12E
        sta lRoutineVariable,b
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$1600
        jsl rlDrawMenuTextLine
        rts

        .databank 0

        ; 8A/A12E

    .endsection Unsorted8AA02BSection


    .section Unsorted8AA142Section

      .al
      .xl

      rsUnknown8AA142 ; 8A/A142

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda $7F8087
        sta lR20+1
        lda $7F8086
        sta lR20
        lda $08A1,b
        tay
        lda [lR20],y
        and #$00FF
        beq _A177
        cmp #$0001
        beq _A17B
        cmp #$0002
        beq _A17B
        cmp #$0003
        beq _A17F
        cmp #$0004
        beq _A17F
        cmp #$0005
        beq _A17F
        cmp #$00FF
        beq _A177

        _A177
        jml _A180


        _A17B
        jml rsUnknown8AA222


        _A17F
        rts


        _A180
        ldy #$000E
        lda $08A7,b
        sec
        sbc $08A5,b
        clc
        adc #$0007
        asl a
        tax

        _A190
        phx
        phy
        lda $7F7A72,x
        sta wR0
        txa
        and #$000E
        tay
        lda <>aUnknown8AA1B0,b,y
        tax
        lda wR0
        jsl rlCopyItemIcon
        ply
        plx
        dec x
        dec x
        dec y
        dec y
        bpl _A190
        rts

        .databank 0

      aUnknown8AA1B0 ; 8A/A1B0

        ; Tile positions of the item icons drawn by rsUnknown8AA142, as the two tables below.
        .word $0050, $0052, $0054, $0056, $0058, $005A, $005C, $005E

      rsUnknown8AA1C0 ; 8A/A1C0

        .al
        .xl
        .autsiz
        .databank ?

        lda $08A7,b
        sec
        sbc $08A5,b
        asl a
        tax
        lda $7F7A72,x
        sta wR0
        txa
        and #$000E
        tay
        lda <>aUnknown8AA1DF,b,y
        tax
        lda wR0
        jsl rlCopyItemIcon
        rts

        .databank 0

      aUnknown8AA1DF ; 8A/A1DF

        .word $0050, $0052, $0054, $0056, $0058, $005A, $005C, $005E

      rsUnknown8AA1EF ; 8A/A1EF

        .al
        .xl
        .autsiz
        .databank ?

        lda $08A7,b
        sec
        sbc $08A5,b
        clc
        adc #$0007
        asl a
        tax
        lda $7F7A72,x
        sta wR0
        txa
        and #$000E
        tay
        lda <>aUnknown8AA212,b,y
        tax
        lda wR0
        jsl rlCopyItemIcon
        rts

        .databank 0

      aUnknown8AA212 ; 8A/A212

        .word $0050, $0052, $0054, $0056, $0058, $005A, $005C, $005E

      rsUnknown8AA222 ; 8A/A222

        .al
        .xl
        .autsiz
        .databank ?

        _A222
        ldx #$000E
        ldy #$0007

        _A228
        phx
        phy
        lda aUnknown8AA241,x
        tax
        tya
        inc a
        jsl rlGetItemIDByInventorySlot
        jsl rlCopyItemIcon
        ply
        plx
        dec x
        dec x
        dec y
        bpl _A228
        rts

        .databank 0

        ; 8A/A241

    .endsection Unsorted8AA142Section


    .section Unsorted8AA2EDSection

      .al
      .xl

      rsUnknown8AA2ED ; 8A/A2ED

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$2800
        sta aCurrentTilemapInfo,b
        lda #$8A00
        sta lRoutineVariable+1,b
        lda #$A31C
        sta lRoutineVariable,b
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$1902
        jsl rlDrawMenuTextLine
        jsl rlGetSelectedUnitMoney
        ldx #$0646
        jsl rlUnknown8AB111
        rts

        .databank 0

        ; 8A/A31C

    .endsection Unsorted8AA2EDSection


    .section Unsorted8AA400Section

      .al
      .xl

      rsUnknown8AA400 ; 8A/A400

        .al
        .xl
        .autsiz
        .databank ?

        lda wJoy1Repeated
        bit #$0800
        bne _A40D
        bit #$0400
        bne _A432
        rts


        _A40D
        lda $08A7,b
        sta wR0
        beq _A45D
        sec
        sbc #$0001
        sta $08A7,b
        lda #$0006
        jsl rlPlaySoundEffect
        lda $08A5,b
        sta wR1
        beq _A464
        sec
        sbc #$0001
        sta $08A5,b
        bra _A464


        _A432
        lda $08A7,b
        sta wR0
        clc
        adc #$0001
        cmp $08AB,b
        bcs _A45D
        sta $08A7,b
        lda #$0006
        jsl rlPlaySoundEffect
        lda $08A5,b
        sta wR1
        cmp #$0007
        bcs _A469
        clc
        adc #$0001
        sta $08A5,b
        bra _A469


        _A45D
        jsr rsUnknown8AA63D
        jsr rsUnknown8AA9CE
        rts


        _A464
        jsr rsUnknown8AA1C0
        bra _A45D


        _A469
        jsr rsUnknown8AA1EF
        bra _A45D

        .databank 0

        ; 8A/A46E

      rsUnknown8AA46E ; 8A/A46E

        .al
        .xl
        .autsiz
        .databank ?

        lda wJoy1New
        bit #$0200
        bne _A499
        bit #$0100
        bne _A4AE

        _A47A
        lda $08A3,b
        tax
        lda $8AA4C6,x
        and #$00FF
        sec
        sbc #$000D
        sta wR0
        lda #$0028
        clc
        adc #$0004
        clc
        adc #$0008
        sta wR1
        rts


        _A499
        lda $08A3,b
        beq _A47A
        sec
        sbc #$0001
        sta $08A3,b
        lda #$0007
        jsl rlPlaySoundEffect
        bra _A47A


        _A4AE
        lda $08A3,b
        cmp #$0001
        bcs _A47A
        clc
        adc #$0001
        sta $08A3,b
        lda #$0007
        jsl rlPlaySoundEffect
        bra _A47A

        .databank 0

        ; 8A/A4C6

    .endsection Unsorted8AA400Section


    .section Unsorted8AA4C8Section

      .al
      .xl

      rsUnknown8AA4C8 ; 8A/A4C8

        .al
        .xl
        .autsiz
        .databank ?

        lda wJoy1Repeated
        bit #$0800
        bne _A4D5
        bit #$0400
        bne _A4FA
        rts


        _A4D5
        lda $08A7,b
        sta wR0
        beq _A525
        sec
        sbc #$0001
        sta $08A7,b
        lda #$0006
        jsl rlPlaySoundEffect
        lda $08A5,b
        sta wR1
        beq _A52C
        sec
        sbc #$0001
        sta $08A5,b
        bra _A52C


        _A4FA
        lda $08A7,b
        sta wR0
        clc
        adc #$0001
        cmp $0889,b
        bcs _A525
        sta $08A7,b
        lda #$0006
        jsl rlPlaySoundEffect
        lda $08A5,b
        sta wR1
        cmp #$0007
        bcs _A52E
        clc
        adc #$0001
        sta $08A5,b
        bra _A52E


        _A525
        jsr rlUnknown8AA83D
        jsr rsUnknown8AAB48
        rts


        _A52C
        bra _A525


        _A52E
        bra _A525

        .databank 0

        ; 8A/A530

      rsUnknown8AA530 ; 8A/A530

        .al
        .xl
        .autsiz
        .databank ?

        lda wJoy1Repeated
        bit #$0800
        bne _A53D
        bit #$0400
        bne _A562
        rts


        _A53D
        lda $08A7,b
        sta wR0
        beq _A58D
        sec
        sbc #$0001
        sta $08A7,b
        lda #$0006
        jsl rlPlaySoundEffect
        lda $08A5,b
        sta wR1
        beq _A594
        sec
        sbc #$0001
        sta $08A5,b
        bra _A594


        _A562
        lda $08A7,b
        sta wR0
        clc
        adc #$0001
        cmp $0889,b
        bcs _A58D
        sta $08A7,b
        lda #$0006
        jsl rlPlaySoundEffect
        lda $08A5,b
        sta wR1
        cmp #$0007
        bcs _A596
        clc
        adc #$0001
        sta $08A5,b
        bra _A596


        _A58D
        jsr rlUnknown8AA83D
        jsr rsUnknown8AACA8
        rts


        _A594
        bra _A58D


        _A596
        bra _A58D

        .databank 0

        ; 8A/A598

      rsUnknown8AA598 ; 8A/A598

        .al
        .xl
        .autsiz
        .databank ?

        lda wJoy1Repeated
        bit #$0800
        bne _A5A5
        bit #$0400
        bne _A5CA
        rts


        _A5A5
        lda $08A7,b
        sta wR0
        beq _A5F7
        sec
        sbc #$0001
        sta $08A7,b
        lda #$0006
        jsl rlPlaySoundEffect
        lda $08A5,b
        sta wR1
        beq _A5FB
        sec
        sbc #$0001
        sta $08A5,b
        bra _A5FB


        _A5CA
        lda $08A7,b
        sta wR0
        cmp $7F8091
        bcs _A5F7
        clc
        adc #$0001
        sta $08A7,b
        lda #$0006
        jsl rlPlaySoundEffect
        lda $08A5,b
        sta wR1
        cmp $7F8091
        bcs _A5FD
        clc
        adc #$0001
        sta $08A5,b
        bra _A5FD


        _A5F7
        jsr rsUnknown8AAD6F
        rts


        _A5FB
        bra _A5F7


        _A5FD
        bra _A5F7

        .databank 0

        ; 8A/A5FF

    .endsection Unsorted8AA4C8Section


    .section Unsorted8AA5FFSection

      .al
      .xl

      rlUnknown8AA5FF ; 8A/A5FF

        .al
        .xl
        .autsiz
        .databank ?

        pha
        tya
        asl a
        asl a
        asl a
        asl a
        asl a
        asl a
        sta wR0
        txa
        asl a
        clc
        adc wR0
        tay
        pla
        asl a
        asl a
        tax
        phx
        lda aUnknown8AA629,x
        tyx
        sta aBG3TilemapBuffer,x
        txy
        plx
        lda aUnknown8AA629+2,x
        tyx
        sta $7E83C8,x
        rtl

        .databank 0

        ; 8A/A629

    .endsection Unsorted8AA5FFSection


    .section Unsorted8AA63DSection

      .al
      .xl

      rsUnknown8AA63D ; 8A/A63D

        .al
        .xl
        .autsiz
        .databank ?

        lda $08AB,b
        beq _A6AE
        lda $08A7,b
        asl a
        tax
        lda $7F7C72,x
        sta wCurrentItemDataROMPointer,b
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda #$8000
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$B6AD
        sta lMapMenuTilemapRAMEntryPointer,b
        jsl rlGetItemEquipmentType
        cmp #$0001
        beq _A68F
        cmp #$0000
        beq _A6B2
        lda #(`aUnknown8AA6B6)<<8
        sta lRoutineVariable+1,b
        lda #<>aUnknown8AA6B6
        sta lRoutineVariable,b
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$0A00
        jsl rlDrawMenuTextLine
        jml rsUnknown8AA02B


        _A68F
        ldx #$0282
        lda #$0002
        ldy #$0008
        jsr rsUnknown8AA9A6
        jsl rlGetItemWeaponRank
        ldx #$0008
        ldy #$000A
        inc a
        jsl rlUnknown8AA5FF
        jml rsUnknown8AA02B


        _A6AE
        jml rsUnknown8AA830


        _A6B2
        jml rsUnknown8AA6CA

        .databank 0

      aUnknown8AA6B6 ; 8A/A6B6

        ; Nine full-width spaces: blanks the line.
        .enc "SJIS"
        .text "　　　　　　　　　\n"

        .databank 0

        ; 8A/A6CA

    .endsection Unsorted8AA63DSection


    .section Unsorted8AA6CASection

      .al
      .xl

      rsUnknown8AA6CA ; 8A/A6CA

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0282
        lda #$000A
        ldy #$0008
        jsr rsUnknown8AA9A6
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda #$8000
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$B6AD
        sta lMapMenuTilemapRAMEntryPointer,b
        jsl rlGetItemWeaponRank
        ldx #$0008
        ldy #$000A
        inc a
        jsl rlUnknown8AA5FF
        jsl rlGetItemAccuracy
        ldx #$2520
        stx wR5
        ldx #$0000
        stx wR6
        ldx #$030C
        jsl rlDrawMenuTextNumber
        jsl rlGetItemMight
        ldx #$24F0
        stx aCurrentTilemapInfo,b
        ldx #$0E06
        jsl rlUnknown87913E
        jsl rlGetItemMinimumRange
        ldx #$2520
        stx wR5
        ldx #$0001
        stx wR6
        ldx #$040C
        jsl rlDrawMenuTextNumber
        jsl rlGetItemMaximumRange
        ldx #$2520
        stx wR5
        ldx #$0000
        stx wR6
        ldx #$0410
        jsl rlDrawMenuTextNumber
        jsl rlGetItemWeight
        ldx #$24F0
        stx aCurrentTilemapInfo,b
        ldx #$1206
        jsl rlUnknown87913E
        lda #$8A00
        sta lRoutineVariable+1,b
        lda #$A7DD
        sta lRoutineVariable,b
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$1400
        jsl rlDrawMenuTextLine
        lda #$8A00
        sta lRoutineVariable+1,b
        lda #$A7DD
        sta lRoutineVariable,b
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$1600
        jsl rlDrawMenuTextLine
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda #$8000
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$B6AD
        sta lMapMenuTilemapRAMEntryPointer,b
        jsl rlGetItemDescriptionPointer
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$1501
        jsl rlDrawMenuTextLine
        lda #$2400
        sta aCurrentTilemapInfo,b
        lda #$8A00
        sta lRoutineVariable+1,b
        lda #$A7F1
        sta lRoutineVariable,b
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$1007
        jsl rlDrawMenuTextLine
        rts

        .databank 0

        ; 8A/A7DD

    .endsection Unsorted8AA6CASection


    .section Unsorted8AA830Section

      .al
      .xl

      rsUnknown8AA830 ; 8A/A830

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0282
        lda #$000E
        ldy #$0008
        jsr rsUnknown8AA97F
        rts

        .databank 0

        ; 8A/A83D

    .endsection Unsorted8AA830Section


    .section Unsorted8AA83DSection

      .al
      .xl

      rlUnknown8AA83D ; 8A/A83D

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda $08A7,b
        inc a
        sta wRoutineVariable1,b
        jsl rlGetItemROMDataByInventorySlot
        lda wCurrentItemDataROMPointer,b
        beq _A8AD
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda #$8000
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$B6AD
        sta lMapMenuTilemapRAMEntryPointer,b
        jsl rlGetItemEquipmentType
        cmp #$0001
        beq _A88E
        cmp #$0000
        beq _A8B1
        lda #$8A00
        sta lRoutineVariable+1,b
        lda #$A8B5
        sta lRoutineVariable,b
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$0A00
        jsl rlDrawMenuTextLine
        jml rsUnknown8AA02B


        _A88E
        ldx #$0282
        lda #$0002
        ldy #$0008
        jsr rsUnknown8AA9A6
        jsl rlGetItemWeaponRank
        ldx #$0008
        ldy #$000A
        inc a
        jsl rlUnknown8AA5FF
        jml rsUnknown8AA02B


        _A8AD
        jml rsUnknown8AA830


        _A8B1
        jml rsUnknown8AA6CA

        .databank 0

        ; 8A/A8B5

    .endsection Unsorted8AA83DSection


    .section Unsorted8AA8C9Section

      .al
      .xl

      rsUnknown8AA8C9 ; 8A/A8C9

        .al
        .xl
        .autsiz
        .databank ?

        lda $08AB,b
        beq _A916
        lda $08A7,b
        asl a
        tax
        lda $7F7C72,x
        sta wCurrentItemDataROMPointer,b
        jsl rlGetItemEquipmentType
        cmp #$0001
        beq _A8E8
        cmp #$0000
        bne _A916

        _A8E8
        jsl rlGetItemWeaponType
        tax
        sep #$20
        lda #$8A
        pha
        plb
        .databank $8A
        rep #$20
        ldy #$A921
        lda #$0030
        sta wR0
        lda #$0050
        sta wR1
        lda @l $8AA917,x
        and #$00FF
        sta wR4
        lda #$0000
        sta wR5
        phx
        jsl rlPushToOAMBuffer
        plx

        _A916
        rts

        .databank 0

        ; 8A/A917

    .endsection Unsorted8AA8C9Section


    .section Unsorted8AA928Section

      .al
      .xl

      rsUnknown8AA928 ; 8A/A928

        .al
        .xl
        .autsiz
        .databank ?

        lda $08A7,b
        inc a
        sta wRoutineVariable1,b
        jsl rlGetItemROMDataByInventorySlot
        lda wCurrentItemDataROMPointer,b
        beq _A974
        jsl rlGetItemEquipmentType
        cmp #$0001
        beq _A946
        cmp #$0000
        bne _A974

        _A946
        jsl rlGetItemWeaponType
        tax
        sep #$20
        lda #$8A
        pha
        plb
        .databank $8A
        rep #$20
        ldy #$A921
        lda #$0030
        sta wR0
        lda #$0050
        sta wR1
        lda @l $8AA975,x
        and #$00FF
        sta wR4
        lda #$0000
        sta wR5
        phx
        jsl rlPushToOAMBuffer
        plx

        _A974
        rts

        .databank 0

        ; 8A/A975

    .endsection Unsorted8AA928Section


    .section Unsorted8AA97FSection

      .al
      .xl

      rsUnknown8AA97F ; 8A/A97F

        .al
        .xl
        .autsiz
        .databank ?

        stx wR0
        sty wR1
        sty wR3
        sta wR2

        _A987
        lda #$00FF
        sta aBG3TilemapBuffer,x
        inc x
        inc x
        dec wR1
        bne _A987
        lda wR0
        clc
        adc #$0040
        sta wR0
        tax
        lda wR3
        sta wR1
        dec wR2
        bne _A987
        rts

        .databank 0

        ; 8A/A9A6

    .endsection Unsorted8AA97FSection


    .section Unsorted8AA9A6Section

      .al
      .xl

      rsUnknown8AA9A6 ; 8A/A9A6

        .al
        .xl
        .autsiz
        .databank ?

        stx wR0
        sty wR1
        sty wR3
        sta wR2

        _A9AE
        lda aUnknownDA7000,x
        sta aBG3TilemapBuffer,x
        inc x
        inc x
        dec wR1
        bne _A9AE
        lda wR0
        clc
        adc #$0040
        sta wR0
        tax
        lda wR3
        sta wR1
        dec wR2
        bne _A9AE
        rts

        .databank 0

        ; 8A/A9CE

    .endsection Unsorted8AA9A6Section


    .section Unsorted8AA9CESection

      .al
      .xl

      rsUnknown8AA9CE ; 8A/A9CE

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$2000
        sta aCurrentTilemapInfo,b
        ldy #$000E
        lda $08A7,b
        sec
        sbc $08A5,b
        clc
        adc #$0007
        asl a
        tax

        _A9E4
        txa
        lsr a
        cmp $08AB,b
        bcs _AA0F
        lda $7F7E72,x
        bmi _A9F9
        lda #$2000
        sta aCurrentTilemapInfo,b
        bra _A9FF


        _A9F9
        lda #$2C00
        sta aCurrentTilemapInfo,b

        _A9FF
        jsr rsUnknown8AAA8A
        jsr rsUnknown8AAAE7
        jsr rsUnknown8AAA3A

        _AA08
        dec x
        dec x
        dec y
        dec y
        bpl _A9E4
        rts


        _AA0F
        lda #$8A00
        sta lR18+1
        lda #$A320
        sta lR18
        phx
        lda $AA2A,b,y
        xba
        clc
        adc #$000D
        tax
        jsl rlDrawMenuTextLine
        plx
        bra _AA08

        .databank 0

        ; 8A/AA2A

    .endsection Unsorted8AA9CESection


    .section Unsorted8AAA3ASection

      .al
      .xl

      rsUnknown8AAA3A ; 8A/AA3A

        .al
        .xl
        .autsiz
        .databank ?

        lda #$8A00
        sta lR18+1
        lda #$AA78
        sta lR18
        phx
        lda $AA2A,b,y
        xba
        clc
        adc #$000D
        tax
        jsl rlDrawMenuTextLine
        plx
        lda $7F7C72,x
        sta wCurrentItemDataROMPointer,b
        jsl rlGetItemNamePointer
        lda lRoutineVariable+1,b
        sta lR18+1
        lda lRoutineVariable,b
        sta lR18
        phx
        lda $AA2A,b,y
        xba
        clc
        adc #$000D
        tax
        jsl rlDrawMenuTextLine
        plx
        rts

        .databank 0

        ; 8A/AA78

    .endsection Unsorted8AAA3ASection


    .section Unsorted8AAA8ASection

      .al
      .xl

      rsUnknown8AAA8A ; 8A/AA8A

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F8082
        cmp #$0003
        beq _AAE6
        cmp #$0004
        beq _AAE6
        cmp #$0007
        beq _AAE6
        phy
        phx
        lda $7F7872,x
        sta wCurrentItemDataRAMPointer,b
        jsl rlGetItemBuyPrice
        sta wTempVariable1,b
        plx
        ply
        jsl rlUnknown87A18C
        bcc _AABC
        lda wTempVariable1,b
        lsr a
        sta wTempVariable1,b

        _AABC
        phx
        lda $AA2A,b,y
        xba
        lsr a
        lsr a
        clc
        adc #$0032
        tax
        lda wTempVariable1,b
        jsl rlUnknown8AB111
        plx
        rts

        .byte $DA, $B9, $2A, $AA, $EB, $4A, $4A, $18, $69, $32, $00, $AA, $AD, $8C, $07, $4A
        .byte $22, $11, $B1, $8A, $FA


        _AAE6
        rts

        .databank 0

        ; 8A/AAE7

      rsUnknown8AAAE7 ; 8A/AAE7

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda $7F7872,x
        sta wCurrentItemDataRAMPointer,b
        jsl rlGetItemCurrentDurability
        sta wR0
        plx
        ply
        lda $7F7C72,x
        sta wCurrentItemDataROMPointer,b
        phy
        phx
        jsl rlGetItemEquipmentType
        plx
        ply
        cmp #$0002
        beq _AB20
        phx
        lda $AA2A,b,y
        xba
        lsr a
        lsr a
        clc
        adc #$0026
        tax
        lda wR0
        jsl rlUnknown8AB111
        plx
        rts


        _AB20
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda #$8A00
        sta lR18+1
        lda #$AB40
        sta lR18
        phx
        lda $AA2A,b,y
        xba
        clc
        adc #$0015
        tax
        jsl rlDrawMenuTextLine
        plx
        rts

        .databank 0

        ; 8A/AB40

    .endsection Unsorted8AAA8ASection


    .section Unsorted8AAB48Section

      .al
      .xl

      rsUnknown8AAB48 ; 8A/AB48

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$2000
        sta aCurrentTilemapInfo,b
        stz $0889,b
        ldx #$0007
        ldy #$000E

        _AB57
        txa
        inc a
        sta wRoutineVariable1,b
        jsl rlGetItemROMDataByInventorySlot
        lda wCurrentItemDataROMPointer,b
        beq _AB90
        inc $0889,b
        jsl rlCheckItemObtainable
        bcc _AB76
        lda #$2000
        sta aCurrentTilemapInfo,b
        bra _AB7C


        _AB76
        lda #$2C00
        sta aCurrentTilemapInfo,b

        _AB7C
        txa
        inc a
        sta wRoutineVariable1,b
        jsr rsUnknown8AABFC
        jsr rsUnknown8AAC51
        jsr rsUnknown8AABAB

        _AB8A
        dec x
        dec y
        dec y
        bpl _AB57
        rts


        _AB90
        lda #$8A00
        sta lR18+1
        lda #$A320
        sta lR18
        phx
        lda $AA2A,b,y
        xba
        clc
        adc #$000D
        tax
        jsl rlDrawMenuTextLine
        plx
        bra _AB8A

        .databank 0

        ; 8A/ABAB

    .endsection Unsorted8AAB48Section


    .section Unsorted8AABABSection

      .al
      .xl

      rsUnknown8AABAB ; 8A/ABAB

        .al
        .xl
        .autsiz
        .databank ?

        lda #$8A00
        sta lR18+1
        lda #$ABEA
        sta lR18
        phx
        lda $AA2A,b,y
        xba
        clc
        adc #$000D
        tax
        jsl rlDrawMenuTextLine
        plx
        phx
        phy
        jsl rlGetEffectiveItemROMPointerByItemRAMStructEntry
        ply
        plx
        jsl rlGetItemNamePointer
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        phx
        lda $AA2A,b,y
        xba
        clc
        adc #$000D
        tax
        jsl rlDrawMenuTextLine
        plx
        rts

        .databank 0

        ; 8A/ABEA

    .endsection Unsorted8AABABSection


    .section Unsorted8AABFCSection

      .al
      .xl

      rsUnknown8AABFC ; 8A/ABFC

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F8082
        cmp #$0003
        beq _AC36
        cmp #$0007
        beq _AC36
        txa
        inc a
        phx
        phy
        jsl rlGetItemROMDataByInventorySlot
        ply
        plx
        jsl rlGetItemWeaponRank
        ora #$0000
        bmi _AC37
        jsl rlGetInventorySlotItemSellPrice
        sta wR0
        phx
        lda $AA2A,b,y
        xba
        lsr a
        lsr a
        clc
        adc #$0032
        tax
        lda wR0
        jsl rlUnknown8AB111
        plx

        _AC36
        rts


        _AC37
        lda #$8A00
        sta lR18+1
        lda #$A320
        sta lR18
        phx
        lda $AA2A,b,y
        xba
        clc
        adc #$000D
        tax
        jsl rlDrawMenuTextLine
        plx
        rts

        .databank 0

        ; 8A/AC51

      rsUnknown8AAC51 ; 8A/AC51

        .al
        .xl
        .autsiz
        .databank ?

        txa
        inc a
        jsl rlGetItemDurabilityOfInventorySlot
        sta wR0
        txa
        inc a
        phy
        phx
        jsl rlGetItemROMDataByInventorySlot
        jsl rlGetItemEquipmentType
        plx
        ply
        cmp #$0002
        beq _AC80
        phx
        lda $AA2A,b,y
        xba
        lsr a
        lsr a
        clc
        adc #$0026
        tax
        lda wR0
        jsl rlUnknown8AB111
        plx
        rts


        _AC80
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda #$8A00
        sta lR18+1
        lda #$ACA0
        sta lR18
        phx
        lda $AA2A,b,y
        xba
        clc
        adc #$0015
        tax
        jsl rlDrawMenuTextLine
        plx
        rts

        .databank 0

        ; 8A/ACA0

    .endsection Unsorted8AABFCSection


    .section Unsorted8AACA8Section

      .al
      .xl

      rsUnknown8AACA8 ; 8A/ACA8

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$2000
        sta aCurrentTilemapInfo,b
        stz $0889,b
        ldx #$0007
        ldy #$000E

        _ACB7
        txa
        inc a
        sta wRoutineVariable1,b
        jsl rlGetItemROMDataByInventorySlot
        lda wCurrentItemDataROMPointer,b
        beq _ACEA
        inc $0889,b
        jsr rsUnknown8AAD05
        jsr rsUnknown8AAC51
        lda wTempVariable1,b
        beq _ACDB
        lda #$2000
        sta aCurrentTilemapInfo,b
        bra _ACE1


        _ACDB
        lda #$2C00
        sta aCurrentTilemapInfo,b

        _ACE1
        jsr rsUnknown8AABAB

        _ACE4
        dec x
        dec y
        dec y
        bpl _ACB7
        rts


        _ACEA
        lda #$8A00
        sta lR18+1
        lda #$A320
        sta lR18
        phx
        lda $AA2A,b,y
        xba
        clc
        adc #$000D
        tax
        jsl rlDrawMenuTextLine
        plx
        bra _ACE4

        .databank 0

        ; 8A/AD05

    .endsection Unsorted8AACA8Section


    .section Unsorted8AAD05Section

      .al
      .xl

      rsUnknown8AAD05 ; 8A/AD05

        .al
        .xl
        .autsiz
        .databank ?

        lda wRoutineVariable1,b
        jsl rlGetInventorySlotItemRepairCost
        sta wTempVariable1,b
        txa
        inc a
        phy
        phx
        jsl rlGetItemROMDataByInventorySlot
        jsl rlGetItemEquipmentType
        plx
        ply
        cmp #$0002
        beq _AD43
        jsl rlUnknown87A18C
        bcc _AD2F
        lda wTempVariable1,b
        lsr a
        sta wTempVariable1,b

        _AD2F
        phx
        lda $AA2A,b,y
        xba
        lsr a
        lsr a
        clc
        adc #$0032
        tax
        lda wTempVariable1,b
        jsl rlUnknown8AB111
        plx

        _AD43
        rts

        .databank 0

        ; 8A/AD44

      rsUnknown8AAD44 ; 8A/AD44

        .al
        .xl
        .autsiz
        .databank ?

        lda #$2000
        sta aCurrentTilemapInfo,b
        ldx #$0007
        ldy #$000E

        _AD50
        lda #$8A00
        sta lR18+1
        lda #$A320
        sta lR18
        phx
        lda $AA2A,b,y
        xba
        clc
        adc #$000D
        tax
        jsl rlDrawMenuTextLine
        plx
        dec x
        dec y
        dec y
        bpl _AD50
        rts

        .databank 0

        ; 8A/AD6F

    .endsection Unsorted8AAD05Section


    .section Unsorted8AAD6FSection

      .al
      .xl

      rsUnknown8AAD6F ; 8A/AD6F

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$2000
        sta aCurrentTilemapInfo,b
        lda $7F8183
        and #$00FF
        tax

        _AD7D
        lda $7F8184,x
        and #$00FF
        asl a
        phx
        tax
        jsr (aUnknown8AADA7,x)
        plx
        lda #$2000
        sta aCurrentTilemapInfo,b
        phx
        txa
        asl a
        tay
        lda $AA2A,b,y
        xba
        clc
        adc #$0003
        tax
        jsl rlDrawMenuTextLine
        plx
        dec x
        bpl _AD7D
        rts

        .databank 0

        ; 8A/ADA7

    .endsection Unsorted8AAD6FSection


    .section Table8AADA7Section

      .al
      .xl

      aUnknown8AADA7 ; 8A/ADA7

        ; Jump table of rsUnknown8AAD6F.
        .word <>rsUnknown8AADAD
        .word <>rsUnknown8AADB8
        .word <>rsUnknown8AADC3

    .endsection Table8AADA7Section


    .section Unsorted8AADADSection

      .al
      .xl

      rsUnknown8AADAD ; 8A/ADAD

        .al
        .xl
        .autsiz
        .databank ?

        lda #$8A00
        sta lR18+1
        lda #$ADCE
        sta lR18
        rts

        .databank 0

        ; 8A/ADB8

      rsUnknown8AADB8 ; 8A/ADB8

        .al
        .xl
        .autsiz
        .databank ?

        lda #$8A00
        sta lR18+1
        lda #$ADDC
        sta lR18
        rts

        .databank 0

        ; 8A/ADC3

    .endsection Unsorted8AADADSection


    .section Unsorted8AADC3Section

      .al
      .xl

      rsUnknown8AADC3 ; 8A/ADC3

        .al
        .xl
        .autsiz
        .databank ?

        lda #$8A00
        sta lR18+1
        lda #$ADE8
        sta lR18
        rts

        .databank 0

        ; 8A/ADCE

    .endsection Unsorted8AADC3Section


    .section Unsorted8AADF4Section

      .al
      .xl

      rsUnknown8AADF4 ; 8A/ADF4

        .al
        .xl
        .autsiz
        .databank ?

        lda #$2800
        sta aCurrentTilemapInfo,b
        lda #$8A00
        sta lRoutineVariable+1,b
        lda #$AEDA
        sta lRoutineVariable,b
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$0A0D
        jsl rlDrawMenuTextLine
        lda #$2000
        sta aCurrentTilemapInfo,b
        jsl rlUnknown87A082
        sta wTempVariable1,b
        jsl rlGetCharacterNamePointer
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$0C0E
        jsl rlDrawMenuTextLine
        lda wTempVariable1,b
        jsl rlGetCharacterClass
        jsl rlGetClassNamePointer
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$0E0E
        jsl rlDrawMenuTextLine
        jsl rlUnknown87A0DF
        jsl rlGetItemNamePointer
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$100E
        jsl rlDrawMenuTextLine
        lda $0585,b
        beq _AE8B
        sta wCurrentItemDataROMPointer,b
        jsl rlGetItemNamePointer
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$120E
        jsl rlDrawMenuTextLine

        _AE8B
        lda #$8A00
        sta lRoutineVariable+1,b
        lda #$AEEC
        sta lRoutineVariable,b
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$160E
        jsl rlDrawMenuTextLine
        lda #$8A00
        sta lRoutineVariable+1,b
        lda #$AEE6
        sta lRoutineVariable,b
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$0E17
        jsl rlDrawMenuTextLine
        lda wTempVariable1,b
        jsl rlGetCharacterLevel
        ldx #$24F0
        stx aCurrentTilemapInfo,b
        ldx #$0E19
        jsl rlUnknown87913E
        rts

        .databank 0

        ; 8A/AEDA

    .endsection Unsorted8AADF4Section


    .section Unsorted8AAF0ASection

      .al
      .xl

      rsUnknown8AAF0A ; 8A/AF0A

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F8087
        sta lR20+1
        lda $7F8086
        sta lR20
        lda $08A1,b
        tay
        lda [lR20],y
        and #$00FF
        beq _AF3F
        cmp #$0001
        beq _AF43
        cmp #$0002
        beq _AF43
        cmp #$0003
        beq _AF4F
        cmp #$0004
        beq _AF4F
        cmp #$0005
        beq _AF4F
        cmp #$00FF
        beq _AF3F

        _AF3F
        jml _AF50


        _AF43
        lda $08A9,b
        cmp #$0003
        beq _AF4F
        jml _AFEB


        _AF4F
        rts


        _AF50
        ldy #$0007
        sep #$20
        lda #$8A
        pha
        plb
        .databank $8A
        rep #$20
        lda $08A7,b
        sec
        sbc $08A5,b
        and #$0007
        clc
        adc #$0007
        tax
        lda $08A7,b
        sec
        sbc $08A5,b
        sta wR0
        clc
        adc #$0007
        cmp $08AB,b
        bcs _AF7E
        bra _AF98


        _AF7E
        lda $08AB,b
        sec
        sbc wR0
        dec a
        and #$0007
        tay
        sta wR0
        lda #$0007
        sec
        sbc wR0
        sta wR0
        txa
        sec
        sbc wR0
        tax

        _AF98
        cpy $08AB,b
        bcs _AFC7
        lda #$0058
        sta wR0
        lda $AFCC,b,y
        and #$00FF
        clc
        adc #$0050
        sta wR1
        lda @l $8AAFD4,x
        and #$00FF
        sta wR4
        lda #$3200
        sta wR5
        phx
        phy
        ldy #$AFE4
        jsl rlPushToOAMBuffer
        ply
        plx

        _AFC7
        dec x
        dec y
        bpl _AF98
        rts

        .byte $00, $10, $20, $30, $40, $50, $60, $70, $20, $22, $24, $26, $28, $2A, $2C, $2E
        .byte $20, $22, $24, $26, $28, $2A, $2C, $2E, $01, $00, $00, $C2, $00, $30, $32


        _AFEB
        ldx #$0007
        ldy #$0007
        sep #$20
        lda #$8A
        pha
        plb
        .databank $8A
        rep #$20

        _AFF9
        txa
        inc a
        jsl rlGetItemROMDataByInventorySlot
        lda wCurrentItemDataROMPointer,b
        beq _B02E
        lda #$0058
        sta wR0
        lda $B033,b,y
        and #$00FF
        clc
        adc #$0050
        sta wR1
        lda @l $8AB03B,x
        and #$00FF
        sta wR4
        lda #$3200
        sta wR5
        phx
        phy
        ldy #$AFE4
        jsl rlPushToOAMBuffer
        ply
        plx

        _B02E
        dec x
        dec y
        bpl _AFF9
        rts

        .databank 0

        ; 8A/B033

    .endsection Unsorted8AAF0ASection


    .section Unsorted8AB043Section

      .al
      .xl

      rlUnknown8AB043 ; 8A/B043

        .al
        .xl
        .autsiz
        .databank ?

        phb
        phx
        phy
        cmp #$0000
        beq _B04F
        lda wR0
        bra _B05D


        _B04F
        lda wVBlankEnabledFramecount
        and #$001C
        lsr a
        tax
        lda $8AB07C,x
        clc
        adc wR0

        _B05D
        sta wR0
        sep #$20
        lda #$8A
        pha
        plb
        .databank $8A
        rep #$20
        ldy #$B08C
        lda #$0000
        sta wR4
        lda #$2000
        sta wR5
        jsl rlPushToOAMBuffer
        ply
        plx
        plb
        .databank $8A
        rtl

        .databank 0

        ; 8A/B07C

    .endsection Unsorted8AB043Section


    .section Unsorted8AB093Section

      .al
      .xl

      rlUnknown8AB093 ; 8A/B093

        .al
        .xl
        .autsiz
        .databank ?

        phb
        phx
        phy
        lda wR0
        sta wTempVariable1,b
        lda wR1
        sta wTempVariable2,b
        sep #$20
        lda #$8A
        pha
        plb
        .databank $8A
        rep #$20
        lda $08A7,b
        cmp #$0008
        bcs _B0B7
        cmp $08A5,b
        bne _B0B7
        bra _B0D2


        _B0B7
        lda #$0098
        sta wR0
        lda #$0048
        sta wR1
        ldy #$B10A
        lda #$0000
        sta wR4
        lda #$A000
        sta wR5
        jsl rlPushToOAMBuffer

        _B0D2
        lda $08AB,b
        lda $08A7,b
        clc
        adc #$0008
        sec
        sbc $08A5,b
        cmp $08AB,b
        bcc _B0E7
        bra _B106


        _B0E7
        lda #$0098
        sta wR0
        lda #$00C8
        clc
        adc #$0006
        sta wR1
        ldy #$B10A
        lda #$0000
        sta wR4
        lda #$2000
        sta wR5
        jsl rlPushToOAMBuffer

        _B106
        ply
        plx
        plb
        .databank $8A
        rtl

        .databank 0

        ; 8A/B10A

    .endsection Unsorted8AB093Section


    .section Unsorted8AB111Section

      .al
      .xl

      rlUnknown8AB111 ; 8A/B111

        .al
        .xl
        .autsiz
        .databank ?

        sta wR0
        stz wR1
        stz wR2
        stz wR3
        stz wR4
        stz wR5
        lda wR0
        cmp #$2710
        bcs _B129
        lda #$00CF
        sta wR1

        _B129
        lda wR0
        cmp #$03E8
        bcs _B135
        lda #$00CF
        sta wR2

        _B135
        lda wR0
        cmp #$0064
        bcs _B141
        lda #$00CF
        sta wR3

        _B141
        lda wR0
        cmp #$000A
        bcs _B14D
        lda #$00CF
        sta wR4

        _B14D
        lda wR0
        cmp #$2710
        bcc _B164
        sec
        sbc #$2710
        sta wR0
        lda wR1
        clc
        adc #$0001
        sta wR1
        bra _B14D


        _B164
        lda wR0
        cmp #$03E8
        bcc _B17B
        sec
        sbc #$03E8
        sta wR0
        lda wR2
        clc
        adc #$0001
        sta wR2
        bra _B164


        _B17B
        lda wR0
        cmp #$0064
        bcc _B192
        sec
        sbc #$0064
        sta wR0
        lda wR3
        clc
        adc #$0001
        sta wR3
        bra _B17B


        _B192
        lda wR0
        cmp #$000A
        bcc _B1A9
        sec
        sbc #$000A
        sta wR0
        lda wR4
        clc
        adc #$0001
        sta wR4
        bra _B192


        _B1A9
        lda wR0
        sta wR5
        lda wR1
        clc
        adc #$0120
        ora #$2400
        sta aBG3TilemapBuffer,x
        lda wR1
        clc
        adc #$0130
        ora #$2400
        sta $7E83C8,x
        lda wR2
        clc
        adc #$0120
        ora #$2400
        sta $7E838A,x
        lda wR2
        clc
        adc #$0130
        ora #$2400
        sta $7E83CA,x
        lda wR3
        clc
        adc #$0120
        ora #$2400
        sta $7E838C,x
        lda wR3
        clc
        adc #$0130
        ora #$2400
        sta $7E83CC,x
        lda wR4
        clc
        adc #$0120
        ora #$2400
        sta $7E838E,x
        lda wR4
        clc
        adc #$0130
        ora #$2400
        sta $7E83CE,x
        lda wR5
        clc
        adc #$0120
        ora #$2400
        sta $7E8390,x
        lda wR5
        clc
        adc #$0130
        ora #$2400
        sta $7E83D0,x
        rtl

        .databank 0

        ; 8A/B230

    .endsection Unsorted8AB111Section


    .section Unsorted8AB23BSection

      .al
      .xl

      rlUnknown8AB23B ; 8A/B23B

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$48
        sta $08C8,b
        lda #$00
        sta $08C9,b
        lda #$80
        sec
        sbc #$48
        sta $08CA,b
        lda #$82
        sta $08CB,b
        lda #$00
        sta $08CC,b
        lda #$00
        sta $08CD,b
        rep #$20
        rtl

        .databank 0

        ; 8A/B261

    .endsection Unsorted8AB23BSection


    .section Unsorted8AB3FESection

      .al
      .xl

      rlUnknown8AB3FE ; 8A/B3FE

        .al
        .xl
        .autsiz
        .databank ?

        phk
        plb
        .databank $8A
        sta wTempVariable1,b
        jsl rlGetCharacterPortraitDataID
        jsr rlTryGetClassPortraitDataID
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
        lda #<>aDecompressionBuffer
        clc
        adc #$0800
        sta lR47
        phx
        jsl rlDecompressSingle
        plx
        lda #(`aDecompressionBuffer)<<8
        sta lR18+1
        lda #<>aDecompressionBuffer
        sta lR18
        lda lR18
        clc
        adc #$0800
        sta lR18
        lda @l aPortraitPalettePointers+1,x
        sta lR19+1
        lda @l aPortraitPalettePointers,x
        sta lR19
        rtl

        .databank 0

        ; 8A/B452

    .endsection Unsorted8AB3FESection


    .section Unsorted8ABB3ESection

      .al
      .xl

      rlUnknown8ABB3E ; 8A/BB3E

        .al
        .xl
        .autsiz
        .databank ?

        lda $08B6,b
        asl a
        clc
        adc $08B6,b
        tax
        lda $8ABAD0,x
        sta lR19+1
        lda $8ABACF,x
        sta lR19
        ldy #$0000
        lda [lR19],y
        sta lR45
        ldy #$0001
        lda [lR19],y
        sta lR45+1
        lda #(`aDecompressionBuffer)<<8
        sta lR47+1
        lda #<>aDecompressionBuffer
        sta lR47
        jsl rlDecompressSingle
        lda #(`aDecompressionBuffer)<<8
        sta lR20+1
        lda #<>aDecompressionBuffer
        sta lR20
        sep #$20
        lda #$80
        sta $2115,b
        lda #$00
        sta $4315,b
        lda #$20
        sta $4316,b
        lda #$18
        sta $4311,b
        lda lR20
        sta $4312,b
        lda lR20+1
        sta $4313,b
        lda lR20+2
        sta $4314,b
        lda #$00
        sta $2116,b
        lda #$20
        sta $2117,b
        lda #$01
        sta $4310,b
        lda #$02
        sta $420B,b
        rep #$20
        ldy #$0003
        lda [lR19],y
        sta lR45
        ldy #$0004
        lda [lR19],y
        sta lR45+1
        lda #(`aDecompressionBuffer)<<8
        sta lR47+1
        lda #<>aDecompressionBuffer
        sta lR47
        jsl rlDecompressSingle
        lda #(`aDecompressionBuffer)<<8
        sta lR20+1
        lda #<>aDecompressionBuffer
        sta lR20
        sep #$20
        lda #$80
        sta $2115,b
        lda #$00
        sta $4315,b
        lda #$40
        sta $4316,b
        lda #$18
        sta $4311,b
        lda lR20
        sta $4312,b
        lda lR20+1
        sta $4313,b
        lda lR20+2
        sta $4314,b
        lda #$00
        sta $2116,b
        lda #$00
        sta $2117,b
        lda #$01
        sta $4310,b
        lda #$02
        sta $420B,b
        rep #$20
        ldy #$0007
        lda [lR19],y
        sta lR20+1
        ldy #$0006
        lda [lR19],y
        sta lR20
        ldy #$01FE

        _BC26
        lda [lR20],y
        sta aBGPaletteBuffer,b,y
        dec y
        dec y
        bpl _BC26
        lda #$0000
        sta aBGPaletteBuffer,b
        ldy #$0009
        lda [lR19],y
        sta lR45
        ldy #$000A
        lda [lR19],y
        sta lR45+1
        lda #(`aDecompressionBuffer)<<8
        sta lR47+1
        lda #<>aDecompressionBuffer
        sta lR47
        jsl rlDecompressSingle
        lda #(`aDecompressionBuffer)<<8
        sta lR20+1
        lda #<>aDecompressionBuffer
        sta lR20
        sep #$20
        lda #$80
        sta $2115,b
        lda #$00
        sta $4315,b
        lda #$08
        sta $4316,b
        lda #$18
        sta $4311,b
        lda lR20
        sta $4312,b
        lda lR20+1
        sta $4313,b
        lda lR20+2
        sta $4314,b
        lda #$00
        sta $2116,b
        lda #$70
        sta $2117,b
        lda #$01
        sta $4310,b
        lda #$02
        sta $420B,b
        rep #$20
        ldy #$000C
        lda [lR19],y
        sta lR45
        ldy #$000D
        lda [lR19],y
        sta lR45+1
        lda #(`aDecompressionBuffer)<<8
        sta lR47+1
        lda #<>aDecompressionBuffer
        sta lR47
        jsl rlDecompressSingle
        lda #(`aDecompressionBuffer)<<8
        sta lR20+1
        lda #<>aDecompressionBuffer
        sta lR20
        sep #$20
        lda #$80
        sta $2115,b
        lda #$C0
        sta $4315,b
        lda #$02
        sta $4316,b
        lda #$18
        sta $4311,b
        lda lR20
        sta $4312,b
        lda lR20+1
        sta $4313,b
        lda lR20+2
        sta $4314,b
        lda #$20
        sta $2116,b
        lda #$75
        sta $2117,b
        lda #$01
        sta $4310,b
        lda #$02
        sta $420B,b
        rep #$20
        rtl

        .databank 0

        ; 8A/BCF8

      rlUnknown8ABCF8 ; 8A/BCF8

        .al
        .xl
        .autsiz
        .databank ?

        phk
        plb
        .databank $8A
        sep #$20
        lda #$80
        sta $2100,b
        sta bBufferINIDISP
        rep #$20
        jsl rlDisableVBlank
        jsl rlResetHDMAEngine
        jsr rsUnknown8ABF27
        lda #$0000
        sta wR1
        lda #$0000
        sta wR2
        lda #$4000
        sta wR3
        sta wR4
        lda #$6000
        sta wR5
        lda #$2800
        sta wR6
        lda #$2C00
        sta wR7
        lda #$3800
        sta wR8
        jsl rlSetLayerPositionsAndSizes
        jsl rlResetDialogueEngine
        jsl rlDMAByStruct

          .structDMAToVRAM $DE40C0, $0400, $80, $C000

        jsl rlDMAByStruct

          .structDMAToVRAM $DE0200, $0800, $80, $D600

        lda #$8A00
        sta lR19+1
        lda #$BE53
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        lda #$8A00
        sta lR19+1
        lda #$BE5B
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        jsl rlDMAByStruct

          .structDMAToVRAM $D76000, $0800, $80, $9800

        lda #$8A00
        sta lR19+1
        lda #$BE4B
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        jsl rlGetDialogueBoxGraphicsAndPalette
        jsr rsUnknown8ABE63
        ldx #$0800
        lda #$00FF

        _BD9B
        sta aBG3TilemapBuffer,x
        dec x
        dec x
        bne _BD9B
        lda #$0001
        jsl rlUnitWindowCopySpritePalette1
        lda #$0002
        jsl rlUnitWindowCopySpritePalette2
        jsr rsUnknown8ABFD1
        ldy #$0000
        stz $0889,b

        _BDBA
        tya
        clc
        adc #$0001
        jsl rlGetItemROMDataByInventorySlot
        lda wCurrentItemDataROMPointer,b
        beq _BDD1
        inc $0889,b
        inc y
        cpy #$0007
        bcc _BDBA

        _BDD1
        sep #$20
        lda #$17
        sta bBufferTM
        lda #$00
        sta bBufferTS
        lda #$00
        sta bBufferCGWSEL
        lda #$00
        sta bBufferCGADSUB
        rep #$20
        stz $0592,b
        stz $08A1,b
        stz $08A3,b
        stz $08A5,b
        stz $08A7,b
        jsl rlUnknown8A9DF2
        jsr rsUnknown8AA142
        lda #$8000
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$B6AD
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$2000
        sta aCurrentTilemapInfo,b
        jsr rsUnknown8AAD44
        jsr rsUnknown8AC003
        jsr rsUnknown8AA830
        jsr rsUnknown8AA2ED
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0700, $80, $7000

        lda #$8A00
        sta lR44+1
        lda #$B230
        sta lR44
        jsl rlHDMAEngineCreateEntry
        lda #$000E
        sta wGameStateStep,b
        rep #$20
        jsl rlEnableVBlank
        sep #$20
        lda #$00
        sta bBufferINIDISP
        rep #$20
        rtl

        .databank 0

        ; 8A/BE49

    .endsection Unsorted8ABB3ESection


    .section Unsorted8ABE63Section

      .al
      .xl

      rsUnknown8ABE63 ; 8A/BE63

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F8082
        cmp #$0000
        beq _BE76
        cmp #$0001
        beq _BEA9
        cmp #$0002
        beq _BEDC

        _BE76
        lda #$8A00
        sta lR19+1
        lda #$BF0F
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        ldx #$01FE

        _BE87
        lda $8C9600,x
        sta aBGPaletteBuffer,b,x
        dec x
        dec x
        bpl _BE87
        sep #$20
        lda #$04
        ora #$20
        sta bBufferCOLDATA_1
        lda #$04
        ora #$40
        sta bBufferCOLDATA_2
        lda #$04
        ora #$80
        sta bBufferCOLDATA_3
        rep #$20
        rts


        _BEA9
        lda #$8A00
        sta lR19+1
        lda #$BF17
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        ldx #$01FE

        _BEBA
        lda $8CD400,x
        sta aBGPaletteBuffer,b,x
        dec x
        dec x
        bpl _BEBA
        sep #$20
        lda #$02
        ora #$20
        sta bBufferCOLDATA_1
        lda #$02
        ora #$40
        sta bBufferCOLDATA_2
        lda #$02
        ora #$80
        sta bBufferCOLDATA_3
        rep #$20
        rts


        _BEDC
        lda #$8A00
        sta lR19+1
        lda #$BF1F
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        ldx #$01FE

        _BEED
        lda $8CD200,x
        sta aBGPaletteBuffer,b,x
        dec x
        dec x
        bpl _BEED
        sep #$20
        lda #$06
        ora #$20
        sta bBufferCOLDATA_1
        lda #$03
        ora #$40
        sta bBufferCOLDATA_2
        lda #$02
        ora #$80
        sta bBufferCOLDATA_3
        rep #$20
        rts

        .databank 0

        ; 8A/BF0F

    .endsection Unsorted8ABE63Section


    .section Unsorted8ABF27Section

      .al
      .xl

      rsUnknown8ABF27 ; 8A/BF27

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F8082
        beq _BF50
        cmp #$0001
        beq _BF60
        cmp #$0002
        beq _BF70
        cmp #$0003
        beq _BF80
        cmp #$0004
        beq _BF90
        cmp #$0005
        beq _BFA0
        cmp #$0006
        beq _BFB0
        cmp #$0007
        beq _BFC0

        _BF50
        lda #$8A00
        sta $7F8087
        lda #$D074
        sta $7F8086
        bra _BFD0


        _BF60
        lda #$8A00
        sta $7F8087
        lda #$D07A
        sta $7F8086
        bra _BFD0


        _BF70
        lda #$8A00
        sta $7F8087
        lda #$D07F
        sta $7F8086
        bra _BFD0


        _BF80
        lda #$8A00
        sta $7F8087
        lda #$D083
        sta $7F8086
        bra _BFD0


        _BF90
        lda #$8A00
        sta $7F8087
        lda #$D085
        sta $7F8086
        bra _BFD0


        _BFA0
        lda #$8A00
        sta $7F8087
        lda #$D086
        sta $7F8086
        bra _BFD0


        _BFB0
        lda #$8A00
        sta $7F8087
        lda #$D087
        sta $7F8086
        bra _BFD0


        _BFC0
        lda #$8A00
        sta $7F8087
        lda #$D08A
        sta $7F8086
        bra _BFD0


        _BFD0
        rts

        .databank 0

        ; 8A/BFD1

      rsUnknown8ABFD1 ; 8A/BFD1

        .al
        .xl
        .autsiz
        .databank ?

        lda wSelectedUnitDataRAMPointer,b
        pha
        lda #$FFFF
        sta $7F8084
        lda $7F8082
        asl a
        tax
        lda aUnknown8ABFF3,x
        jsl rlUnknown8AFC52
        jsl rlUnknown8A94B6
        pla
        sta wSelectedUnitDataRAMPointer,b
        rts

        .databank 0

        ; 8A/BFF3

    .endsection Unsorted8ABF27Section


    .section Unsorted8AC003Section

      .al
      .xl

      rsUnknown8AC003 ; 8A/C003

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F8082
        beq _C027
        cmp #$0001
        beq _C02C
        cmp #$0002
        beq _C031
        cmp #$0003
        beq _C036
        cmp #$0004
        beq _C03B
        cmp #$0005
        beq _C040
        cmp #$0006
        beq _C045

        _C027
        jsr rsUnknown8AA9CE
        bra _C04A


        _C02C
        jsr rsUnknown8AAB48
        bra _C04A


        _C031
        jsr rsUnknown8AACA8
        bra _C04A


        _C036
        jsr rsUnknown8AAB48
        bra _C04A


        _C03B
        jsr rsUnknown8AA9CE
        bra _C04A


        _C040
        jsr rsUnknown8AAD44
        bra _C04A


        _C045
        jsr rsUnknown8AAD44
        bra _C04A


        _C04A
        rts

        .databank 0

        ; 8A/C04B

      rlUnknown8AC04B ; 8A/C04B

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $8A
        lda $0592,b
        asl a
        tax
        jsr (aUnknown8AC08F,x)
        lda $7F7670
        bne _C06C
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0700, $80, $7000

        bra _C076


        _C06C
        lda #$0000
        sta $7F7670
        jsr rsUnknown8AA142

        _C076
        jsr rsUnknown8AAF0A
        jsr rsUnknown8AA2ED
        lda #$0008
        sta wR0
        lda #$0008
        sta wR1
        ldx #$0000
        jsr rsUnknown8A950E
        plp
        plb
        .databank $8A
        rtl

        .databank 0

        ; 8A/C08F

    .endsection Unsorted8AC003Section


    .section Table8AC08FSection

      .al
      .xl

      aUnknown8AC08F ; 8A/C08F

        ; Jump table of rlUnknown8AC04B.
        .word <>rsUnknown8AC0B9
        .word <>rsUnknown8AC168
        .word <>rsUnknown8AC1BC
        .word <>rsUnknown8AC50D
        .word <>rsUnknown8AC524
        .word <>rsUnknown8AC6BA
        .word <>rsUnknown8AC785
        .word <>rsUnknown8AC81E
        .word <>rsUnknown8AC853
        .word <>rsUnknown8AC8A2
        .word <>rsUnknown8AC8B9
        .word <>rsUnknown8AC984
        .word <>rsUnknown8ACA53
        .word <>rsUnknown8ACAD2
        .word <>rsUnknown8ACAE9
        .word <>rsUnknown8ACC58
        .word <>rsUnknown8ACD53
        .word <>rsUnknown8ACD94
        .word <>rsUnknown8ACDAB
        .word <>rsUnknown8ACE2B
        .word <>rsUnknown8ACE3A

    .endsection Table8AC08FSection


    .section Unsorted8AC0B9Section

      .al
      .xl

      rsUnknown8AC0B9 ; 8A/C0B9

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F8082
        cmp #$0001
        beq _C130
        cmp #$0002
        beq _C104

        _C0C7
        lda $7F8082
        clc
        adc $7F8082
        clc
        adc $7F8082
        tax
        lda $8ACEB4,x
        sta lR18+1
        lda aUnknown8ACEB3,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$0001
        sta $0592,b
        lda #$0002
        sta $0594,b

        _C0FB
        sep #$20
        lda #$0F
        sta bBufferINIDISP
        rep #$20
        rts


        _C104
        lda $0889,b
        beq _C10B
        bra _C0C7


        _C10B
        lda #$8A00
        sta lR18+1
        lda #$D3AA
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$0001
        sta $0592,b
        lda #$0013
        sta $0594,b
        bra _C0FB


        _C130
        lda $08AB,b
        beq _C137
        bra _C143


        _C137
        lda #$8A00
        sta lR18+1
        lda #$D1B5
        sta lR18
        bra _C14D


        _C143
        lda #$8A00
        sta lR18+1
        lda #$D195
        sta lR18

        _C14D
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$0001
        sta $0592,b
        lda #$0002
        sta $0594,b
        bra _C0FB

        .databank 0

        ; 8A/C168

      rsUnknown8AC168 ; 8A/C168

        .al
        .xl
        .autsiz
        .databank ?

        lda $0594,b
        cmp #$0005
        beq _C195
        cmp #$000B
        beq _C19A
        cmp #$000F
        beq _C19A

        _C17A
        lda aDialogue.wStatus,b
        beq _C18E
        lda #$00E8
        sta wR0
        lda #$0036
        sta wR1
        jsl rlDisplayDialogueAPressArrows
        rts


        _C18E
        lda $0594,b
        sta $0592,b
        rts


        _C195
        jsr rsUnknown8AA8C9
        bra _C19D


        _C19A
        jsr rsUnknown8AA928

        _C19D
        lda $08A5,b
        tax
        lda #$004C
        sta wR0
        lda $8A9DD5,x
        and #$00FF
        clc
        adc #$0004
        sta wR1
        lda #$0001
        jsl rlUnknown8AB043
        bra _C17A

        .databank 0

        ; 8A/C1BC

      rsUnknown8AC1BC ; 8A/C1BC

        .al
        .xl
        .autsiz
        .databank ?

        lda #$8000
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$B6AD
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda $7F8082
        beq _C1E6
        cmp #$0001
        beq _C1E2
        cmp #$0002
        beq _C1DE

        _C1DE
        jml rsUnknown8AC457


        _C1E2
        jml _C333


        _C1E6
        jml _C1EA


        _C1EA
        lda #$0002
        sta wTempVariable1,b
        lda #$8A00
        sta lR18+1
        lda #$C2FE
        sta lR18
        lda $18DD,b
        cmp #$0100
        beq _C208
        clc
        adc #$0120
        bra _C20C


        _C208
        sec
        sbc #$0040

        _C20C
        clc
        adc #$000B
        tax
        lda #$2000
        sta aCurrentTilemapInfo,b
        jsl rlDrawMenuTextLine
        lda #$8A00
        sta lR19+1
        lda #$D071
        sta lR19
        lda #$8A00
        sta lR20+1
        lda #$D074
        sta lR20
        lda wTempVariable1,b
        jsr rsUnknown8ACFBE
        lda #$0000
        jsl rlUnknown8AB043
        lda wJoy1New
        cmp #$8000
        beq _C256
        cmp #$0080
        bne _C255
        lda $08A1,b
        cmp #$0000
        beq _C292
        cmp #$0001
        beq _C2AB

        _C255
        rts


        _C256
        lda $7F8082
        clc
        adc $7F8082
        clc
        adc $7F8082
        tax
        lda $8ACEEA,x
        sta lR18+1
        lda $8ACEE9,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$0001
        sta $0592,b
        lda #$0013
        sta $0594,b
        lda #$0021
        jsl rlPlaySoundEffect
        rts


        _C292
        lda $08AB,b
        beq _C2E2
        ldx #$0000
        lda $8ACEFC,x
        sta lR18+1
        lda $8ACEFB,x
        sta lR18
        lda #$0003
        bra _C2C4


        _C2AB
        lda $0889,b
        beq _C2F0
        ldx #$0000
        lda $8ACF56,x
        sta lR18+1
        lda $8ACF55,x
        sta lR18
        lda #$0011
        bra _C2C4


        _C2C4
        sta $0594,b
        lda #$0001
        sta $0592,b
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$000A
        jsl rlPlaySoundEffect
        rts


        _C2E2
        lda #$8A00
        sta lR18+1
        lda #$D131
        sta lR18
        jml _C312


        _C2F0
        lda #$8A00
        sta lR18+1
        lda #$D257
        sta lR18
        jml _C312

        .byte $82, $A9, $82, $A4, $81, $40, $81, $40, $81, $40, $82, $E0, $82, $BF, $82, $E0
        .byte $82, $CC, $00, $00


        _C312
        lda #$000A
        jsl rlPlaySoundEffect
        lda $0592,b
        sta $0594,b
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$0001
        sta $0592,b
        rts


        _C333
        lda #$0002
        sta wTempVariable1,b
        lda #$8A00
        sta lR18+1
        lda #$C447
        sta lR18
        lda $18DD,b
        cmp #$0100
        beq _C351
        clc
        adc #$0120
        bra _C355


        _C351
        sec
        sbc #$0040

        _C355
        clc
        adc #$000B
        tax
        jsl rlDrawMenuTextLine
        stz $08A5,b
        stz $08A7,b
        lda #$8A00
        sta lR19+1
        lda #$D077
        sta lR19
        lda #$8A00
        sta lR20+1
        lda #$D07A
        sta lR20
        lda wTempVariable1,b
        jsr rsUnknown8ACFBE
        lda #$0000
        jsl rlUnknown8AB043
        lda wJoy1New
        cmp #$8000
        beq _C39F
        cmp #$0080
        bne _C39E
        lda $08A1,b
        cmp #$0000
        beq _C3DB
        cmp #$0001
        beq _C3F4

        _C39E
        rts


        _C39F
        lda $7F8082
        clc
        adc $7F8082
        clc
        adc $7F8082
        tax
        lda $8ACEEA,x
        sta lR18+1
        lda $8ACEE9,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$0001
        sta $0592,b
        lda #$0013
        sta $0594,b
        lda #$0021
        jsl rlPlaySoundEffect
        rts


        _C3DB
        lda $0889,b
        beq _C42B
        ldx #$0003
        lda $8ACF56,x
        sta lR18+1
        lda $8ACF55,x
        sta lR18
        lda #$0009
        bra _C40D


        _C3F4
        lda $08AB,b
        beq _C439
        ldx #$0003
        lda $8ACEFC,x
        sta lR18+1
        lda $8ACEFB,x
        sta lR18
        lda #$0003
        bra _C40D


        _C40D
        sta $0594,b
        lda #$0001
        sta $0592,b
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$000A
        jsl rlPlaySoundEffect
        rts


        _C42B
        lda #$8A00
        sta lR18+1
        lda #$D257
        sta lR18
        jml _C312


        _C439
        lda #$8A00
        sta lR18+1
        lda #$D233
        sta lR18
        jml _C312

        .databank 0

        ; 8A/C447

    .endsection Unsorted8AC0B9Section


    .section Unsorted8AC457Section

      .al
      .xl

      rsUnknown8AC457 ; 8A/C457

        .al
        .xl
        .autsiz
        .databank ?

        lda $0889,b
        beq _C4B7
        jml _C4F3

        .byte $AD, $DD, $18, $C9, $00, $01, $F0, $06, $18, $69, $20, $01, $80, $04, $38, $E9
        .byte $40, $00, $18, $69, $0B, $00, $AA, $22, $54, $93, $87, $9C, $A5, $08, $9C, $A7
        .byte $08, $A9, $00, $8A, $85, $28, $A9, $7D, $D0, $85, $27, $A9, $00, $8A, $85, $2B
        .byte $A9, $7F, $D0, $85, $2A, $A9, $02, $00, $20, $BE, $CF, $A9, $00, $00, $22, $43
        .byte $B0, $8A, $A5, $E8, $C9, $00, $80, $F0, $0E, $C9, $80, $00, $D0, $08, $AD, $A1
        .byte $08, $C9, $00, $00, $F0, $3D, $60


        _C4B7
        lda $7F8082
        clc
        adc $7F8082
        clc
        adc $7F8082
        tax
        lda $8ACEEA,x
        sta lR18+1
        lda $8ACEE9,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$0001
        sta $0592,b
        lda #$0013
        sta $0594,b
        lda #$0021
        jsl rlPlaySoundEffect
        rts


        _C4F3
        lda $0889,b
        beq _C4FF
        lda #$000D
        sta $0592,b
        rts


        _C4FF
        lda #$8A00
        sta lR18+1
        lda #$D257
        sta lR18
        jml $8AC312

        .databank 0

        ; 8A/C50D

    .endsection Unsorted8AC457Section


    .section Unsorted8AC50DSection

      .al
      .xl

      rsUnknown8AC50D ; 8A/C50D

        .al
        .xl
        .autsiz
        .databank ?

        lda #$FFFF
        sta $7F7670
        jsr rsUnknown8AA63D
        jsr rsUnknown8AA8C9
        jsr rsUnknown8AA9CE
        lda #$0004
        sta $0592,b
        rts

        .databank 0

        ; 8A/C524

    .endsection Unsorted8AC50DSection


    .section Unsorted8AC524Section

      .al
      .xl

      rsUnknown8AC524 ; 8A/C524

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown8AA8C9
        lda $08A5,b
        tax
        lda #$004C
        sta wR0
        lda $8A9DD5,x
        and #$00FF
        clc
        adc #$0004
        sta wR1
        lda #$0000
        jsl rlUnknown8AB043
        jsl $8AB093
        jsr rsUnknown8AA400
        lda wJoy1New
        cmp #$0080
        beq _C560
        cmp #$8000
        beq _C5C1

        _C557
        rts


        _C558
        lda #$0022
        jsl rlPlaySoundEffect
        rts


        _C560
        lda $08A7,b
        asl a
        tax
        lda $7F7E72,x
        bmi _C558
        lda $08AB,b
        beq _C557
        lda $0889,b
        cmp #$0007
        bne _C57C
        jml _C610


        _C57C
        jsr $8AC68E
        bcs _C585
        jml _C64F


        _C585
        lda #$000A
        jsl rlPlaySoundEffect
        lda $7F8082
        clc
        adc $7F8082
        clc
        adc $7F8082
        tax
        lda $8ACF0B,x
        sta lR18+1
        lda $8ACF0A,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$0001
        sta $0592,b
        lda #$0005
        sta $0594,b
        rts


        _C5C1
        lda #$0021
        jsl rlPlaySoundEffect
        lda $7F8082
        clc
        adc $7F8082
        clc
        adc $7F8082
        tax
        lda $8ACED8,x
        sta lR18+1
        lda $8ACED7,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$0001
        sta $0592,b
        lda #$0002
        sta $0594,b
        jsr rsUnknown8AA830
        stz $08A5,b
        stz $08A7,b
        jsr rsUnknown8AA9CE
        lda #$FFFF
        sta $7F7670
        rts


        _C610
        lda #$0021
        jsl rlPlaySoundEffect
        lda $7F8082
        clc
        adc $7F8082
        clc
        adc $7F8082
        tax
        lda $8ACF38,x
        sta lR18+1
        lda $8ACF37,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$0001
        sta $0592,b
        lda #$0008
        sta $0594,b
        jsr rsUnknown8AA830
        rts


        _C64F
        lda #$0021
        jsl rlPlaySoundEffect
        lda $7F8082
        clc
        adc $7F8082
        clc
        adc $7F8082
        tax
        lda $8ACF29,x
        sta lR18+1
        lda $8ACF28,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$0001
        sta $0592,b
        lda #$0007
        sta $0594,b
        jsr rsUnknown8AA830
        rts

        .databank 0

        ; 8A/C68E

    .endsection Unsorted8AC524Section


    .section Unsorted8AC68ESection

      .al
      .xl

      rsUnknown8AC68E ; 8A/C68E

        .al
        .xl
        .autsiz
        .databank ?

        lda $08A7,b
        asl a
        tax
        lda $7F7672,x
        sta wRoutineVariable1,b
        jsl rlGetItemRAMStructEntryByPlayerItemIndex
        jsl rlGetItemBuyPrice
        sta wTempVariable1,b
        jsl rlUnknown87A18C
        bcc _C6B2
        lda wTempVariable1,b
        lsr a
        sta wTempVariable1,b

        _C6B2
        jsl rlGetSelectedUnitMoney
        cmp wTempVariable1,b
        rts

        .databank 0

        ; 8A/C6BA

    .endsection Unsorted8AC68ESection


    .section Unsorted8AC6BASection

      .al
      .xl

      rsUnknown8AC6BA ; 8A/C6BA

        .al
        .xl
        .autsiz
        .databank ?

        lda #$2000
        sta aCurrentTilemapInfo,b
        jsr rsUnknown8AA8C9
        lda $08A5,b
        tax
        lda #$004C
        sta wR0
        lda $8A9DD5,x
        and #$00FF
        clc
        adc #$0004
        sta wR1
        lda #$0001
        jsl rlUnknown8AB043
        jsr rsUnknown8AD092
        jsr rsUnknown8AA46E
        lda #$0000
        jsl rlUnknown8AB043
        lda wJoy1New
        cmp #$8000
        beq _C707
        cmp #$0080
        bne _C706
        lda $08A3,b
        cmp #$0000
        beq _C71B
        cmp #$0001
        beq _C707

        _C706
        rts


        _C707
        lda #$0021
        jsl rlPlaySoundEffect
        stz $08A3,b
        lda #$0006
        sta $0592,b
        jsr rsUnknown8AA830
        rts


        _C71B
        lda $08A7,b
        asl a
        tax
        lda $7F7672,x
        sta wRoutineVariable1,b
        jsl rlBuyItemForSelectedUnit
        bcs _C744
        inc $0889,b
        lda #$0070
        jsl rlPlaySoundEffect2
        stz $08A3,b
        lda #$0006
        sta $0592,b
        jsr rsUnknown8AA830
        rts


        _C744
        bra _C746


        _C746
        lda #$0021
        jsl rlPlaySoundEffect
        lda $7F8082
        clc
        adc $7F8082
        clc
        adc $7F8082
        tax
        lda $8ACF29,x
        sta lR18+1
        lda $8ACF28,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$0001
        sta $0592,b
        lda #$0007
        sta $0594,b
        jsr rsUnknown8AA830
        rts

        .databank 0

        ; 8A/C785

    .endsection Unsorted8AC6BASection


    .section Unsorted8AC785Section

      .al
      .xl

      rsUnknown8AC785 ; 8A/C785

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown8A9DF2
        jsr rsUnknown8AA9CE
        lda #$FFFF
        sta $7F7670
        lda $08AB,b
        beq _C7DC
        lda $08A7,b
        cmp $08AB,b
        bcc _C7A7
        dec a
        sta $08A7,b
        dec $08A5,b

        _C7A7
        lda $7F8082
        clc
        adc $7F8082
        clc
        adc $7F8082
        tax
        lda $8ACF1A,x
        sta lR18+1
        lda $8ACF19,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$0001
        sta $0592,b
        lda #$0003
        sta $0594,b
        rts


        _C7DC
        lda #$0021
        jsl rlPlaySoundEffect
        lda $7F8082
        clc
        adc $7F8082
        clc
        adc $7F8082
        tax
        lda $8ACED8,x
        sta lR18+1
        lda $8ACED7,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$0001
        sta $0592,b
        lda #$0002
        sta $0594,b
        stz $08A5,b
        stz $08A7,b
        rts

        .databank 0

        ; 8A/C81E

    .endsection Unsorted8AC785Section


    .section Unsorted8AC81ESection

      .al
      .xl

      rsUnknown8AC81E ; 8A/C81E

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F8082
        clc
        adc $7F8082
        clc
        adc $7F8082
        tax
        lda $8ACF1A,x
        sta lR18+1
        lda $8ACF19,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$0001
        sta $0592,b
        lda #$0003
        sta $0592,b
        rts

        .databank 0

        ; 8A/C853

    .endsection Unsorted8AC81ESection


    .section Unsorted8AC853Section

      .al
      .xl

      rsUnknown8AC853 ; 8A/C853

        .al
        .xl
        .autsiz
        .databank ?

        stz $08A3,b
        lda #$0021
        jsl rlPlaySoundEffect
        lda $7F8082
        clc
        adc $7F8082
        clc
        adc $7F8082
        tax
        lda $8ACED8,x
        sta lR18+1
        lda $8ACED7,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$0001
        sta $0592,b
        lda #$0002
        sta $0594,b
        stz $08A5,b
        stz $08A7,b
        jsr rsUnknown8AA9CE
        lda #$FFFF
        sta $7F7670
        rts

        .databank 0

        ; 8A/C8A2

    .endsection Unsorted8AC853Section


    .section Unsorted8AC8A2Section

      .al
      .xl

      rsUnknown8AC8A2 ; 8A/C8A2

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$FFFF
        sta $7F7670
        jsr rlUnknown8AA83D
        jsr rsUnknown8AA928
        jsr rsUnknown8AAB48
        lda #$000A
        sta $0592,b
        rts

        .databank 0

        ; 8A/C8B9

      rsUnknown8AC8B9 ; 8A/C8B9

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown8AA928
        lda $08A5,b
        tax
        lda #$004C
        sta wR0
        lda $8A9DD5,x
        and #$00FF
        clc
        adc #$0004
        sta wR1
        lda #$0000
        jsl rlUnknown8AB043
        jsr rsUnknown8AA4C8
        lda wJoy1New
        cmp #$0080
        beq _C8E9
        cmp #$8000
        beq _C935

        _C8E8
        rts


        _C8E9
        lda $08A7,b
        inc a
        sta wRoutineVariable1,b
        jsl rlGetItemROMDataByInventorySlot
        lda wCurrentItemDataROMPointer,b
        beq _C8E8
        lda #$000A
        jsl rlPlaySoundEffect
        lda $7F8082
        clc
        adc $7F8082
        clc
        adc $7F8082
        tax
        lda $8ACF65,x
        sta lR18+1
        lda $8ACF64,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$0001
        sta $0592,b
        lda #$000B
        sta $0594,b
        rts


        _C935
        lda #$0021
        jsl rlPlaySoundEffect
        lda $7F8082
        clc
        adc $7F8082
        clc
        adc $7F8082
        tax
        lda $8ACED8,x
        sta lR18+1
        lda $8ACED7,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$0001
        sta $0592,b
        lda #$0002
        sta $0594,b
        jsr rsUnknown8AA830
        stz $08A5,b
        stz $08A7,b
        jsr rsUnknown8AAB48
        lda #$FFFF
        sta $7F7670
        rts

        .databank 0

        ; 8A/C984

    .endsection Unsorted8AC8A2Section


    .section Unsorted8AC984Section

      .al
      .xl

      rsUnknown8AC984 ; 8A/C984

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown8AA928
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda $08A5,b
        tax
        lda #$004C
        sta wR0
        lda $8A9DD5,x
        and #$00FF
        clc
        adc #$0004
        sta wR1
        lda #$0001
        jsl rlUnknown8AB043
        jsr rsUnknown8AD092
        jsr rsUnknown8AA46E
        lda #$0000
        jsl rlUnknown8AB043
        lda wJoy1New
        cmp #$8000
        beq _C9FD
        cmp #$0080
        bne _C9D0
        lda $08A3,b
        cmp #$0000
        beq _C9D1
        cmp #$0001
        beq _C9FD

        _C9D0
        rts


        _C9D1
        jsl rlSellInventorySlotItem
        bcs _CA11
        jsl $8AA013
        jsl rlUnknown8A9DF2
        jsr rsUnknown8AAB48
        lda #$FFFF
        sta $7F7670
        lda #$0070
        jsl rlPlaySoundEffect2
        stz $08A3,b
        lda #$000C
        sta $0592,b
        jsr rsUnknown8AA830
        rts


        _C9FD
        lda #$0021
        jsl rlPlaySoundEffect
        stz $08A3,b
        lda #$000C
        sta $0592,b
        jsr rsUnknown8AA830
        rts


        _CA11
        lda #$0021
        jsl rlPlaySoundEffect
        stz $08A3,b
        lda $7F8082
        clc
        adc $7F8082
        clc
        adc $7F8082
        tax
        lda $8ACF47,x
        sta lR18+1
        lda $8ACF46,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$0001
        sta $0592,b
        lda #$000C
        sta $0594,b
        jsr rsUnknown8AA830
        rts

        .databank 0

        ; 8A/CA53

    .endsection Unsorted8AC984Section


    .section Unsorted8ACA53Section

      .al
      .xl

      rsUnknown8ACA53 ; 8A/CA53

        .al
        .xl
        .autsiz
        .databank ?

        stz $08A5,b
        stz $08A7,b
        lda $0889,b
        beq _CA93
        lda $7F8082
        clc
        adc $7F8082
        clc
        adc $7F8082
        tax
        lda $8ACF74,x
        sta lR18+1
        lda $8ACF73,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$0001
        sta $0592,b
        lda #$0009
        sta $0594,b
        rts


        _CA93
        lda $7F8082
        clc
        adc $7F8082
        clc
        adc $7F8082
        tax
        lda $8ACED8,x
        sta lR18+1
        lda $8ACED7,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$0001
        sta $0592,b
        lda #$0002
        sta $0594,b
        jsr rsUnknown8AAB48
        lda #$FFFF
        sta $7F7670
        rts

        .databank 0

        ; 8A/CAD2

    .endsection Unsorted8ACA53Section


    .section Unsorted8ACAD2Section

      .al
      .xl

      rsUnknown8ACAD2 ; 8A/CAD2

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$FFFF
        sta $7F7670
        jsr rlUnknown8AA83D
        jsr rsUnknown8AA928
        jsr rsUnknown8AACA8
        lda #$000E
        sta $0592,b
        rts

        .databank 0

        ; 8A/CAE9

      rsUnknown8ACAE9 ; 8A/CAE9

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown8AA928
        lda $08A5,b
        tax
        lda #$004C
        sta wR0
        lda $8A9DD5,x
        and #$00FF
        clc
        adc #$0004
        sta wR1
        lda #$0000
        jsl rlUnknown8AB043
        jsr rsUnknown8AA530
        lda wJoy1New
        cmp #$0080
        beq _CB21
        cmp #$8000
        beq _CB7E

        _CB18
        rts


        _CB19
        lda #$0022
        jsl rlPlaySoundEffect
        rts


        _CB21
        lda $08A7,b
        inc a
        sta wRoutineVariable1,b
        jsl rlGetItemROMDataByInventorySlot
        lda wCurrentItemDataROMPointer,b
        beq _CB18
        lda wRoutineVariable1,b
        jsl rlGetInventorySlotItemRepairCost
        cmp #$0000
        beq _CB19
        lda #$000A
        jsl rlPlaySoundEffect
        jsr rsUnknown8ACC43
        bcs _CBBD
        lda $7F8082
        clc
        adc $7F8082
        clc
        adc $7F8082
        tax
        lda $8ACF92,x
        sta lR18+1
        lda $8ACF91,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$0001
        sta $0592,b
        lda #$000F
        sta $0594,b
        rts


        _CB7E
        lda #$0021
        jsl rlPlaySoundEffect
        lda $7F8082
        clc
        adc $7F8082
        clc
        adc $7F8082
        tax
        lda $8ACEEA,x
        sta lR18+1
        lda $8ACEE9,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$0001
        sta $0592,b
        lda #$0013
        sta $0594,b
        jsr rsUnknown8AA830
        rts


        _CBBD
        lda $7F8082
        clc
        adc $7F8082
        clc
        adc $7F8082
        tax
        lda $8ACFB0,x
        sta lR18+1
        lda $8ACFAF,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$0001
        sta $0592,b
        lda #$000F
        sta $0594,b
        rts

        .databank 0

        ; 8A/CBF2

    .endsection Unsorted8ACAD2Section


    .section Unsorted8ACBF2Section

      .al
      .xl

      rsUnknown8ACBF2 ; 8A/CBF2

        ; Nothing in the build reaches this. Plays sound $21 and starts the shop
        ; dialogue picked by $7F8082 from the table at $8A/CF28 (not built).

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0021
        jsl rlPlaySoundEffect
        lda $7F8082
        clc
        adc $7F8082
        clc
        adc $7F8082
        tax
        lda $8ACF29,x
        sta lR18+1
        lda $8ACF28,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$0001
        sta $0592,b
        lda #$000D
        sta $0594,b
        jsr rsUnknown8AA830
        rts

        .databank 0

        ; 8A/CC31

      rsUnknown8ACC31 ; 8A/CC31

        ; Nothing in the build reaches this. Compares the selected unit's money with
        ; the repair cost of inventory slot wRoutineVariable1 (kept in wTempVariable1).

        .al
        .xl
        .autsiz
        .databank ?

        lda wRoutineVariable1,b
        jsl rlGetInventorySlotItemRepairCost
        sta wTempVariable1,b
        jsl rlGetSelectedUnitMoney
        cmp wTempVariable1,b
        rts

        .databank 0

        ; 8A/CC43

    .endsection Unsorted8ACBF2Section


    .section Unsorted8ACC43Section

      .al
      .xl

      rsUnknown8ACC43 ; 8A/CC43

        .al
        .xl
        .autsiz
        .databank ?

        lda $08A7,b
        inc a
        jsl rlGetItemRAMStructEntryByInventorySlot
        jsl rlGetItemRAMKillCountAndCritAbility
        cmp #$0032
        bcs _CC56
        clc
        rts


        _CC56
        sec
        rts

        .databank 0

        ; 8A/CC58

    .endsection Unsorted8ACC43Section


    .section Unsorted8ACC58Section

      .al
      .xl

      rsUnknown8ACC58 ; 8A/CC58

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown8AA928
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda $08A5,b
        tax
        lda #$004C
        sta wR0
        lda $8A9DD5,x
        and #$00FF
        clc
        adc #$0004
        sta wR1
        lda #$0001
        jsl rlUnknown8AB043
        jsr rsUnknown8AD092
        jsr rsUnknown8AA46E
        lda #$0000
        jsl rlUnknown8AB043
        lda wJoy1New
        cmp #$8000
        beq _CCA5
        cmp #$0080
        bne _CCA4
        lda $08A3,b
        cmp #$0000
        beq _CCB6
        cmp #$0001
        beq _CCA5

        _CCA4
        rts


        _CCA5
        lda #$0021
        jsl rlPlaySoundEffect
        stz $08A3,b
        lda #$0010
        sta $0592,b
        rts


        _CCB6
        jsl rlUnknown84B349
        bcs _CCCD
        lda #$0070
        jsl rlPlaySoundEffect2
        stz $08A3,b
        lda #$0010
        sta $0592,b
        rts


        _CCCD
        cmp #$0000
        bne _CD14
        lda #$0021
        jsl rlPlaySoundEffect
        stz $08A3,b
        lda $7F8082
        clc
        adc $7F8082
        clc
        adc $7F8082
        tax
        lda $8ACF47,x
        sta lR18+1
        lda $8ACF46,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$0001
        sta $0592,b
        lda #$0010
        sta $0594,b
        jsr rsUnknown8AA830
        rts


        _CD14
        lda #$0021
        jsl rlPlaySoundEffect
        lda $7F8082
        clc
        adc $7F8082
        clc
        adc $7F8082
        tax
        lda $8ACF29,x
        sta lR18+1
        lda $8ACF28,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$0001
        sta $0592,b
        lda #$000D
        sta $0594,b
        jsr rsUnknown8AA830
        rts

        .databank 0

        ; 8A/CD53

    .endsection Unsorted8ACC58Section


    .section Unsorted8ACD53Section

      .al
      .xl

      rsUnknown8ACD53 ; 8A/CD53

        .al
        .xl
        .autsiz
        .databank ?

        stz $08A5,b
        stz $08A7,b
        jsr rsUnknown8AACA8
        jsr rsUnknown8AA830
        lda $7F8082
        clc
        adc $7F8082
        clc
        adc $7F8082
        tax
        lda $8ACFA1,x
        sta lR18+1
        lda $8ACFA0,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$0001
        sta $0592,b
        lda #$000D
        sta $0594,b
        rts

        .databank 0

        ; 8A/CD94

    .endsection Unsorted8ACD53Section


    .section Unsorted8ACD94Section

      .al
      .xl

      rsUnknown8ACD94 ; 8A/CD94

        .al
        .xl
        .autsiz
        .databank ?

        lda #$FFFF
        sta $7F7670
        jsr rlUnknown8AA83D
        jsr rsUnknown8AA928
        jsr rsUnknown8AAB48
        lda #$0012
        sta $0592,b
        rts

        .databank 0

        ; 8A/CDAB

    .endsection Unsorted8ACD94Section


    .section Unsorted8ACDABSection

      .al
      .xl

      rsUnknown8ACDAB ; 8A/CDAB

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown8AA928
        lda $08A5,b
        tax
        lda #$004C
        sta wR0
        lda $8A9DD5,x
        and #$00FF
        clc
        adc #$0004
        sta wR1
        lda #$0000
        jsl rlUnknown8AB043
        jsr rsUnknown8AA4C8
        lda wJoy1New
        cmp #$0080
        beq _CDDB
        cmp #$8000
        beq _CDDC
        rts


        _CDDB
        rts


        _CDDC
        lda #$0021
        jsl rlPlaySoundEffect
        lda $7F8082
        clc
        adc $7F8082
        clc
        adc $7F8082
        tax
        lda $8ACED8,x
        sta lR18+1
        lda $8ACED7,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$0001
        sta $0592,b
        lda #$0002
        sta $0594,b
        jsr rsUnknown8AA830
        stz $08A5,b
        stz $08A7,b
        jsr rsUnknown8AAB48
        lda #$FFFF
        sta $7F7670
        rts

        .databank 0

        ; 8A/CE2B

    .endsection Unsorted8ACDABSection


    .section Unsorted8ACE2BSection

      .al
      .xl

      rsUnknown8ACE2B ; 8A/CE2B

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        lda #$0012
        sta wGameStateStep,b
        rts

        .databank 0

        ; 8A/CE3A

    .endsection Unsorted8ACE2BSection


    .section Unsorted8ACE3ASection

      .al
      .xl

      rsUnknown8ACE3A ; 8A/CE3A

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta $0891,b
        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        lda #$0011
        sta wGameStateStep,b
        rts

        .databank 0

        ; 8A/CE4F

    .endsection Unsorted8ACE3ASection


    .section Unsorted8ACEB3Section

      .al
      .xl

      aUnknown8ACEB3 ; 8A/CEB3

        ; 89 long pointers into bank $8A.

        .long $8AD0D4, $8AD195, $8AD2D9, $8AD3D3
        .long $8AD727, $8AD4B0, $8AD60D, $8AD60D
        .long $8AD60D, $8AD60D, $8AD60D, $8AD60D
        .long $8AD17B, $8AD2B8, $8AD38F, $8AD48F
        .long $8AD81A, $8AD17B, $8AD18B, $8AD2C8
        .long $8AD39F, $8AD4A0, $8AD81A, $8AD5F9
        .long $8AD0E3, $8AD1D2, $8AD0E3, $8AD44E
        .long $8AD81A, $8AD0F1, $8AD1E0, $8AD0F1
        .long $8AD401, $8AD81A, $8AD101, $8AD1F2
        .long $8AD81A, $8AD45D, $8AD81A, $8AD110
        .long $8AD27B, $8AD363, $8AD110, $8AD110
        .long $8AD121, $8AD28A, $8AD121, $8AD43E
        .long $8AD121, $8AD29F, $8AD29F, $8AD373
        .long $8AD29F, $8AD29F, $8AD154, $8AD205
        .long $8AD81A, $8AD3EF, $8AD81A, $8AD81A
        .long $8AD217, $8AD81A, $8AD401, $8AD81A
        .long $8AD81A, $8AD224, $8AD81A, $8AD40B
        .long $8AD81A, $8AD30A, $8AD30A, $8AD2F8
        .long $8AD30A, $8AD81A, $8AD31C, $8AD31C
        .long $8AD31C, $8AD31C, $8AD728, $8AD351
        .long $8AD351, $8AD351, $8AD351, $8AD351
        .long $8AD32E, $8AD32E, $8AD32E, $8AD32E
        .long $8AD728

        ; Not understood yet: this starts in the middle of a routine.

        .text ROM[$0ACFBE:$0AD071]

    .endsection Unsorted8ACEB3Section


    .section Unsorted8ACFBESection

      .al
      .xl

      rsUnknown8ACFBE ; 8A/CFBE

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        sec
        sbc #$0001
        sta wR0
        lda wJoy1New
        bit #$0200
        bne _CFD2
        bit #$0100
        bne _CFEE
        bra _D00C


        _CFD2
        lda $08A1,b
        beq _D00C
        sec
        sbc #$0001
        sta $08A1,b
        lda #$0007
        jsl rlPlaySoundEffect
        lda #$FFFF
        sta $7F7670
        bra _D02D


        _CFEE
        lda $08A1,b
        cmp wR0
        bcs _D00C
        clc
        adc #$0001
        sta $08A1,b
        lda #$0007
        jsl rlPlaySoundEffect
        lda #$FFFF
        sta $7F7670
        bra _D02D


        _D00C
        lda $08A1,b
        tay
        lda [lR19],y
        and #$00FF
        sec
        sbc #$000D
        sta wR0
        lda #$0020
        clc
        adc #$0004
        clc
        adc #$0008
        clc
        adc #$0008
        sta wR1
        rts


        _D02D
        lda $08A1,b
        tay
        lda [lR20],y
        and #$00FF
        cmp #$00FF
        beq _D00C
        cmp #$0000
        beq _D059
        cmp #$0001
        beq _D05E
        cmp #$0002
        beq _D063
        cmp #$0003
        beq _D068
        cmp #$0004
        beq _D06D
        cmp #$0005
        beq _D06F

        _D059
        jsr rsUnknown8AA9CE
        bra _D00C


        _D05E
        jsr rsUnknown8AAB48
        bra _D00C


        _D063
        jsr rsUnknown8AACA8
        bra _D00C


        _D068
        jsr rsUnknown8AAD44
        bra _D00C


        _D06D
        bra _D00C


        _D06F
        bra _D00C

        .databank 0

        ; 8A/D071

    .endsection Unsorted8ACFBESection


    .section Unsorted8AD092Section

      .al
      .xl

      rsUnknown8AD092 ; 8A/D092

        .al
        .xl
        .autsiz
        .databank ?

        lda #$8A00
        sta lR18+1
        lda #$A348
        sta lR18
        lda $18DD,b
        cmp #$0100
        beq _D0AA
        clc
        adc #$0120
        bra _D0AE


        _D0AA
        sec
        sbc #$0040

        _D0AE
        clc
        adc #$000A
        tax
        jsl rlDrawMenuTextLine
        rts

        .databank 0

        ; 8A/D0B8

      rsUnknown8AD0B8 ; 8A/D0B8

        .al
        .xl
        .autsiz
        .databank ?

        lda $18DD,b
        cmp #$0100
        beq _D0C6
        clc
        adc #$0120
        bra _D0CA


        _D0C6
        sec
        sbc #$0040

        _D0CA
        clc
        adc #$000B
        tax
        jsl rlDrawMenuTextLine
        rts

        .databank 0

        ; 8A/D0D4

    .endsection Unsorted8AD092Section


    .section Unsorted8AD81BSection

      .al
      .xl

      rlUnknown8AD81B ; 8A/D81B

        .al
        .xl
        .autsiz
        .databank ?

        phk
        plb
        .databank $8A
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
        lda #$7000
        sta wR6
        lda #$7400
        sta wR7
        lda #$7800
        sta wR8
        jsl rlSetLayerPositionsAndSizes
        jsl rlDMAByStruct

          .structDMAToVRAM $DE40C0, $0400, $80, $C000

        jsl rlDMAByStruct

          .structDMAToVRAM $DA7A00, $0400, $80, $C400

        ldx #$07FE
        lda #$00FF

        _D879
        sta aBG3TilemapBuffer,x
        dec x
        dec x
        bpl _D879
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0800, $80, $F000

        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0800, $80, $E800

        jsl rlUnknown8ABB3E
        jsl rlGetDialogueBoxGraphicsAndPalette
        ldx #$000E

        _D8A6
        lda $8C9700,x
        sta aOAMPaletteBuffer,b,x
        dec x
        dec x
        bpl _D8A6
        lda #$8A00
        sta lR19+1
        lda #$D952
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        lda $08AD,b
        bit #$0004
        beq _D8CB
        jsl rlUnknown8ADA08

        _D8CB
        lda $08AD,b
        bit #$0008
        beq _D8D7
        jsl rlUnknown8ADA16

        _D8D7
        lda $08AD,b
        bit #$0001
        beq _D8E6
        lda $08B2,b
        jsl rlUnknown8A9750

        _D8E6
        lda $08AD,b
        bit #$0002
        beq _D8F5
        lda $08B4,b
        jsl rlUnknown8A9776

        _D8F5
        sep #$20
        lda #$17
        sta bBufferTM
        lda #$00
        sta bBufferTS
        lda #$00
        sta bBufferCGWSEL
        lda #$00
        sta bBufferCGADSUB
        rep #$20
        stz $0592,b
        stz $08A1,b
        stz $08A3,b
        stz $08A5,b
        stz $08A7,b
        jsr rsUnknown8AD95A
        lda #$000C
        sta wGameStateStep,b
        lda $08B8,b
        cmp #$0004
        beq _D938
        rep #$20
        jsl rlEnableVBlank
        sep #$20
        lda #$0F
        sta bBufferINIDISP
        rep #$20
        rtl


        _D938
        lda #$0010
        sta wBufferBG1VOFS
        sta wBufferBG2VOFS
        sta wBufferBG3VOFS
        rep #$20
        jsl rlEnableVBlank
        sep #$20
        lda #$00
        sta bBufferINIDISP
        rep #$20
        rtl

        .databank 0

        ; 8A/D950

    .endsection Unsorted8AD81BSection


    .section Unsorted8AD95ASection

      .al
      .xl

      rsUnknown8AD95A ; 8A/D95A

        .al
        .xl
        .autsiz
        .databank ?

        lda $08B6,b
        cmp #$0000
        beq _D963
        rts


        _D963
        lda #$0000
        sta $7F80A3
        sta $7F80A5
        sta $7F80A7
        bra _D974


        _D974
        rts

        .databank 0

        ; 8A/D975

    .endsection Unsorted8AD95ASection


    .section Unsorted8AD975Section

      .al
      .xl

      rlUnknown8AD975 ; 8A/D975

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        jsr rsUnknown8AE05E

        lda $7F7670
        bne +

          jsl rlDMAByStruct
            .structDMAToVRAM aBG3TilemapBuffer, $0700, $80, $F000

          bra ++

        +
        lda #0
        sta $7F7670
        jsr rsUnknown8ADA83
        jsr rsUnknown8ADA24

        sep #$20
        lda bBufferINIDISP
        rep #$20
        and #$000F
        bne +

          lda #(`procFadeInByScreenFadingTimer)<<8
          sta lR44+1
          lda #<>procFadeInByScreenFadingTimer
          sta lR44
          jsl rlProcEngineFindProc
          bcs +

            jsl rlProcEngineCreateProc

        +
        lda $0592,b
        asl a
        tax
        jsr (aUnknown8AD9FE,x)

        lda $08AD,b
        bit #$0001
        beq +

          lda #$0020
          sta wR0
          lda #$0060
          sta wR1
          ldx #0
          jsr rsUnknown8A950E
          jsr rsUnknown8ADB04

        +
        lda $08AD,b
        bit #$0002
        beq +

          lda #$00A0
          sta wR0
          lda #$0060
          sta wR1
          ldx #2
          jsr rsUnknown8A9539
          jsr rsUnknown8ADB37

        +
        plp
        plb
        rtl

        .databank 0

    .endsection Unsorted8AD975Section


    .section Unsorted8AD9FESection

      .al
      .xl

      aUnknown8AD9FE ; 8A/D9FE

        .word <>rsUnknown8ADBBD
        .word <>rsUnknown8ADBFF
        .word <>rsUnknown8ADC25
        .word <>rsUnknown8ADCDD
        .word <>rsUnknown8ADCDE

      rlUnknown8ADA08 ; 8A/DA08

        .al
        .autsiz
        .databank ?

        lda #$0044
        tsb $08AD,b
        lda #1
        sta $7F7670
        rtl

        .databank 0

        ; 8A/DA16

    .endsection Unsorted8AD9FESection


    .section Unsorted8ADA16Section

      .al
      .xl

      rlUnknown8ADA16 ; 8A/DA16

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0088
        tsb $08AD,b
        lda #$0001
        sta $7F7670
        rtl

        .databank 0

        ; 8A/DA24

      rsUnknown8ADA24 ; 8A/DA24

        .al
        .xl
        .autsiz
        .databank ?

        lda $08AD,b
        bit #$0040
        beq _DA3F
        jsl rlDMAByStruct

          .structDMAToVRAM $DA6800, $0240, $80, $E800

        lda #$0040
        trb $08AD,b

        _DA3F
        lda $08AD,b
        bit #$0080
        beq _DA5A
        jsl rlDMAByStruct

          .structDMAToVRAM $DA6D00, $0240, $80, $ED00

        lda #$0080
        trb $08AD,b

        _DA5A
        rts

        .databank 0

        ; 8A/DA5B

      rlUnknown8ADA5B ; 8A/DA5B

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0004
        trb $08AD,b
        jsl rlDMAByStruct

          .structDMAToVRAM $DA6A40, $0240, $80, $E800

        rtl

        .databank 0

        ; 8A/DA6F

      rlUnknown8ADA6F ; 8A/DA6F

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0008
        trb $08AD,b
        jsl rlDMAByStruct

          .structDMAToVRAM $DA6A40, $0240, $80, $ED00

        rtl

        .databank 0

        ; 8A/DA83

    .endsection Unsorted8ADA16Section


    .section Unsorted8ADA83Section

      .al
      .xl

      rsUnknown8ADA83 ; 8A/DA83

        .al
        .autsiz
        .databank ?

        lda $08AD,b
        bit #$0010
        beq +

          lda $08B2,b
          jsl rlUnknown8A9750
          lda #$0010
          trb $08AD,b
          lda #(`procUnknown8AE147)<<8
          sta lR44+1
          lda #<>procUnknown8AE147
          sta lR44
          jsl rlProcEngineCreateProc

        +
        lda $08AD,b
        bit #$0020
        beq +

          lda $08B4,b
          jsl rlUnknown8A9776
          lda #$0020
          trb $08AD,b
          lda #(`procUnknown8AE199)<<8
          sta lR44+1
          lda #<>procUnknown8AE199
          sta lR44
          jsl rlProcEngineCreateProc

        +
        rts

        .databank 0

      rlUnknown8ADACA ; 8A/DACA

        .al
        .autsiz
        .databank ?

        lda #$0011
        tsb $08AD,b
        lda #1
        sta $7F7670
        rtl

        .databank 0

      rlUnknown8ADAD8 ; 8A/DAD8

        .al
        .autsiz
        .databank ?

        lda #$0022
        tsb $08AD,b
        lda #1
        sta $7F7670
        rtl

        .databank 0

      rlUnknown8ADAE6 ; 8A/DAE6

        .al
        .autsiz
        .databank ?

        lda #(`procUnknown8AE1EB)<<8
        sta lR44+1
        lda #<>procUnknown8AE1EB
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

      rlUnknown8ADAF5 ; 8A/DAF5

        .al
        .autsiz
        .databank ?

        lda #(`procUnknown8AE245)<<8
        sta lR44+1
        lda #<>procUnknown8AE245
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 8A/DB04

    .endsection Unsorted8ADA83Section


    .section Unsorted8ADB04Section

      .al
      .xl

      rsUnknown8ADB04 ; 8A/DB04

        .al
        .xl
        .autsiz
        .databank ?

        lda $08AD,b
        bit #$0004
        beq _DB2F
        lda #$0050
        sta wR0
        lda #$0040
        sta wR1
        sep #$20
        lda #$8A
        pha
        plb
        .databank $8A
        rep #$20
        ldy #$DB30
        lda #$0000
        sta wR4
        lda #$C000
        sta wR5
        jsl rlPushToOAMBuffer

        _DB2F
        rts

        .databank 0

        ; 8A/DB30

    .endsection Unsorted8ADB04Section


    .section Unsorted8ADB37Section

      .al
      .xl

      rsUnknown8ADB37 ; 8A/DB37

        .al
        .xl
        .autsiz
        .databank ?

        lda $08AD,b
        bit #$0008
        beq _DB62
        lda #$0090
        sta wR0
        lda #$0098
        sta wR1
        sep #$20
        lda #$8A
        pha
        plb
        .databank $8A
        rep #$20
        ldy #$DB30
        lda #$0000
        sta wR4
        lda #$0000
        sta wR5
        jsl rlPushToOAMBuffer

        _DB62
        rts

        .databank 0

        ; 8A/DB63

    .endsection Unsorted8ADB37Section


    .section Unsorted8ADBBDSection

      .al
      .xl

      rsUnknown8ADBBD ; 8A/DBBD

        .al
        .autsiz
        .databank ?

        jsl rlResetDialogueEngine

        lda $08AF+1,b
        sta $24+1
        lda $08AF,b
        sta $24
        lda #2
        jsl rlDialogueStartTextAndHDMA

        lda #0
        sta aBGPaletteBuffer,b
        lda #2
        sta aDialogue.wUnknown0018D0,b
        ldx #0
        jsr rsUnknown8ADCF9

        lda $08B8,b
        cmp #4
        bne +

          lda #$081E
          sta aDialogue._Slot[1].wDisplayArea,b

        +
        lda #1
        sta $0592,b
        lda #2
        sta $0594,b
        rts

        .databank 0

    .endsection Unsorted8ADBBDSection


    .section Unsorted8ADBFFSection

      .al
      .xl

      rsUnknown8ADBFF ; 8A/DBFF

        .al
        .autsiz
        .databank ?

        lda aDialogue.wStatus,b
        beq ++

          ldx #$00E0
          ldy #$0038
          lda aDialogue.wSlotOffset,b
          beq +

            ldx #$00E0
            ldy #$00D0

          +
          stx wR0
          sty wR1
          jsl rlDisplayDialogueAPressArrows
          rts

        +
        lda $0594,b
        sta $0592,b
        rts

        .databank 0

        ; 8A/DC25

    .endsection Unsorted8ADBFFSection


    .section Unsorted8ADC25Section

      .al
      .xl

      rsUnknown8ADC25 ; 8A/DC25

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda $08B8,b
        cmp #$0000
        beq _DC41
        cmp #$0001
        beq _DC7A
        cmp #$0004
        beq _DC73
        cmp #$0005
        beq _DC5E
        cmp #$0003
        beq _DCB6

        _DC41
        lda #$0000
        sta $0891,b
        jsl rlBuildDeadPlayerCharacterList
        jsl rlUnknown8A9A56
        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        lda #$0011
        sta wGameStateStep,b
        rts


        _DC5E
        lda #$0003
        sta $0592,b
        lda #(`procFadeOutByScreenFadingTimer)<<8
        sta lR44+1
        lda #<>procFadeOutByScreenFadingTimer
        sta lR44
        jsl rlProcEngineCreateProc
        rts


        _DC73
        lda #$0004
        sta $0592,b
        rts


        _DC7A
        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        lda #$0012
        sta wGameStateStep,b
        lda #$0000
        jsl rlGetFactionSlotLocationID
        cmp $089F,b
        bne _DCA9
        lda #$0000
        sta $088B,b
        jsl rlBuildDeadPlayerCharacterList
        jsl rlUnknown8A9A56
        lda $08BA,b
        sta wSelectedUnitDataRAMPointer,b
        rts


        _DCA9
        lda #$0001
        sta $088B,b
        lda $08BA,b
        sta wSelectedUnitDataRAMPointer,b
        rts


        _DCB6
        lda #$0003
        sta $0592,b
        lda #$0000
        sta $0D77,b
        lda #$B122
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFadeByTimer)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFadeByTimer
        sta lR44
        jsl rlProcEngineFindProc
        bcs _DCDC
        jsl rlProcEngineCreateProc

        _DCDC
        rts

        .databank 0

        ; 8A/DCDD

    .endsection Unsorted8ADC25Section


    .section Unsorted8ADCDDSection

      .al
      .xl

      rsUnknown8ADCDD ; 8A/DCDD

        .al
        .xl
        .autsiz
        .databank ?

        rts

        .databank 0

        ; 8A/DCDE

    .endsection Unsorted8ADCDDSection


    .section Unsorted8ADCDESection

      .al
      .xl

      rsUnknown8ADCDE ; 8A/DCDE

        .al
        .xl
        .autsiz
        .databank ?

        lda wVBlankEnabledFramecount
        and #$0003
        bne _DCEF
        sep #$20
        lda bBufferINIDISP
        and #$0F
        beq _DCF2
        dec bBufferINIDISP

        _DCEF
        rep #$20
        rts


        _DCF2
        .as
        rep #$20
        jsl rlUnknown8DB52C
        rts

        .databank 0

        ; 8A/DCF9

    .endsection Unsorted8ADCDESection


    .section Unsorted8ADCF9Section

      .al
      .xl

      rsUnknown8ADCF9 ; 8A/DCF9

        .al
        .autsiz
        .databank ?

        ; Only ever enter this routine with aDialogue.wSlotOffset = 0

        lda #$2200
        sta aDialogue.wBaseTile,b,x
        stz aDialogue._Slot[0].wUnknown0018D9,b
        stz aDialogue._Slot[1].wUnknown0018D9,b
        lda #1
        sta aDialogue.wTextSound,b
        lda #(`aBG3TilemapBuffer)<<8
        sta aDialogue._Slot[0].lBGBufferPosition+1,b
        sta aDialogue._Slot[1].lBGBufferPosition+1,b
        lda #<>aBG3TilemapBuffer
        sta aDialogue._Slot[0].lBGBufferPosition,b
        sta aDialogue._Slot[1].lBGBufferPosition,b
        lda #$A000 >> 1
        sta aDialogue._Slot[0].wVRAMAddress,b
        lda #$B000 >> 1
        sta aDialogue._Slot[1].wVRAMAddress,b
        lda #pack([30, 6])
        sta aDialogue._Slot[0].wDisplayArea,b
        lda #pack([30, 6])
        sta aDialogue._Slot[1].wDisplayArea,b
        stz aDialogue._Slot[0].wUnknown0018E1,b
        stz aDialogue._Slot[1].wUnknown0018E1,b

        lda #pack([4, 2])
        sta wR1

        sep #$20
        lda #0
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

        ldx aDialogue.wSlotOffset,b
        lda #(`aBG3TilemapBuffer)<<8
        sta aDialogue._Slot[0].lBGBufferPosition+1,b,x
        lda #<>aBG3TilemapBuffer
        clc
        adc wR0
        sta aDialogue._Slot[0].lBGBufferPosition,b,x

        lda #pack([4, 21])
        sta wR1

        sep #$20
        lda #0
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

        ldx aDialogue.wSlotOffset,b
        lda #(`aBG3TilemapBuffer)<<8
        sta aDialogue._Slot[1].lBGBufferPosition+1,b,x
        lda #<>aBG3TilemapBuffer
        clc
        adc wR0
        sta aDialogue._Slot[1].lBGBufferPosition,b,x
        rts

        .databank 0

        ; 8A/DD98

    .endsection Unsorted8ADCF9Section


    .section Unsorted8AE05ESection

      .al
      .xl

      rsUnknown8AE05E ; 8A/E05E

        .al
        .autsiz
        .databank ?

        lda $08B6,b
        asl a
        tax
        jsr (aUnknown8AE067,x)
        rts

        .databank 0

      aUnknown8AE067 ; 8A/E067

        .word <>rsUnknown8AE076
        .word <>rsUnknown8AE075
        .word <>rsUnknown8AE075
        .word <>rsUnknown8AE075
        .word <>rsUnknown8AE0D7
        .word <>rsUnknown8AE075
        .word <>rsUnknown8AE075

      rsUnknown8AE075 ; 8A/E075

        .al
        .autsiz
        .databank ?

        rts

        .databank 0

      rsUnknown8AE076 ; 8A/E076

        .al
        .autsiz
        .databank ?

        lda $7F80A3
        sec
        sbc #1
        bpl _E0A7

          lda $7F80A5
          clc
          adc #4
          sta $7F80A5
          tax
          lda aUnknown8AE0C7+2,x
          bpl +

            lda #0
            sta $7F80A5
            tax
            lda aUnknown8AE0C7+2,x

          +
          sta $7F80A7
          lda aUnknown8AE0C7,x
        
        _E0A7
        sta $7F80A3

        lda $7F80A7
        asl a
        tax
        lda aUnknown8CA000,x
        sta $0170,b
        lda aUnknown8CA000+2,x
        sta $0172,b
        lda aUnknown8CA000+4,x
        sta $0174,b
        rts

        .databank 0

        ; 8A/E0C7

    .endsection Unsorted8AE05ESection


    .section Table8AE0C7Section

      .al
      .xl

      aUnknown8AE0C7 ; 8A/E0C7

        ; Pairs of words, ended by $FFFF, $FFFF. Read by rsUnknown8AE076.

        .word $0004, $0000, $0004, $0001, $0004, $0002, $FFFF, $FFFF

        ; 8A/E0D7

      rsUnknown8AE0D7 ; 8A/E0D7

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F80A3
        sec
        sbc #$0001
        bpl _E108
        lda $7F80A5
        clc
        adc #$0004
        sta $7F80A5
        tax
        lda aUnknown8AE12F+2,x
        bpl _E100
        lda #$0000
        sta $7F80A5
        tax
        lda aUnknown8AE12F+2,x

        _E100
        sta $7F80A7
        lda aUnknown8AE12F,x

        _E108
        sta $7F80A3
        lda $7F80A7
        asl a
        tax
        lda $8CCB00,x
        sta $0186,b
        lda $8CCB40,x
        sta $0188,b
        lda $8CCB80,x
        sta $018A,b
        lda $8CCBC0,x
        sta $018C,b
        rts

        .databank 0

        ; 8A/E12F

      aUnknown8AE12F ; 8A/E12F

        ; Pairs of words, ended by $FFFF, $FFFF; read by rsUnknown8AE0D7.

        .word $0004, $0000, $0004, $0001, $0004, $0002, $0004, $0003
        .word $0004, $0004, $FFFF, $FFFF

        ; 8A/E147

    .endsection Table8AE0C7Section


    .section ProcScript8AE147Section

      .al
      .xl

      procUnknown8AE147 ; 8A/E147

        .structProcInfo "FN", rlProcUnknown8AE147Init, rlProcUnknown8AE147Cycle, aProcUnknown8AE147Code

    .endsection ProcScript8AE147Section


    .section Unsorted8AE14FSection

      .al
      .xl

      rlProcUnknown8AE147Init ; 8A/E14F

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlSavePaletteBufferColorsToRAM

          .byte $88, $9B, $7E, $10, $00, $A0, $01

        ldx #$001E
        lda #$0000

        _E160
        sta aOAMPaletteBuffer.aPalette5,b,x
        dec x
        dec x
        bpl _E160
        lda #$0000
        sta $7F8089
        rtl

        .databank 0

        ; 8A/E16F

      rlProcUnknown8AE147Cycle ; 8A/E16F

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F8089
        sta aPaletteFading.wCurrentStep,b
        lda #$0010
        sta aPaletteFading,b
        clc
        jsl rlFadePaletteToColors

          .byte $88, $9B, $10, $00, $A0, $01

        bcs _E191

        _E189
        lda aPaletteFading.wCurrentStep,b
        sta $7F8089
        rtl


        _E191
        jsl rlProcEngineFreeProc
        bra _E189

        .databank 0

        ; 8A/E197

    .endsection Unsorted8AE14FSection


    .section ProcScript8AE197Section

      .al
      .xl

      aProcUnknown8AE147Code ; 8A/E197

        PROC_HALT


        ; 8A/E199

    .endsection ProcScript8AE197Section


    .section Unsorted8AE199Section

      .al
      .xl

      procUnknown8AE199 ; 8A/E199

        .structProcInfo "F2", rlProcUnknown8AE199Init, rlProcUnknown8AE199Cycle, $8AE1E9

    .endsection Unsorted8AE199Section


    .section ProcUnknown8AE199InitSection

      .al
      .xl

      rlProcUnknown8AE199Init ; 8A/E1A1

        .al
        .autsiz
        .databank ?

        jsl rlSavePaletteBufferColorsToRAM

          .long $7E9BA8
          .word len(Palette.Colors)
          .word aOAMPaletteBuffer.aPalette4 - aBGPaletteBuffer

        ldx #size(Palette)-2
        lda #0

          -
          sta aOAMPaletteBuffer.aPalette4,b,x
          dec x
          dec x
          bpl -

        lda #0
        sta $7F808B
        rtl

        .databank 0

    .endsection ProcUnknown8AE199InitSection


    .section Unsorted8AE1C1Section

      .al
      .xl

      rlProcUnknown8AE199Cycle ; 8A/E1C1

        .al
        .autsiz
        .databank ?

        lda $7F808B

        sta aPaletteFading.wCurrentStep,b
        lda #16
        sta aPaletteFading.wMaxSteps,b
        clc
        jsl rlFadePaletteToColors

          .word <>$7E9BA8
          .word $0010
          .word $0180

        bcs +

          -
          lda aPaletteFading.wCurrentStep,b
          sta $7F808B
          rtl

        +
        jsl rlProcEngineFreeProc
        bra -

        .databank 0

      aProcUnknown8AE199Code ; 8A/E1E9

        PROC_HALT

    .endsection Unsorted8AE1C1Section


    .section Unsorted8AE1EBSection

      .al
      .xl

      procUnknown8AE1EB ; 8A/E1EB

        .structProcInfo "FF", rlProcUnknown8AE1EBInit, rlProcUnknown8AE1EBCycle, $8AE243

    .endsection Unsorted8AE1EBSection


    .section Unsorted8AE1F3Section

      .al
      .xl

      rlProcUnknown8AE1EBInit ; 8A/E1F3

        .al
        .autsiz
        .databank ?

        lda #0
        sta $7F808D
        rtl

        .databank 0

      rlProcUnknown8AE1EBCycle ; 8A/E1FB

        .al
        .autsiz
        .databank ?

        lda $7F808D
        sta aPaletteFading.wCurrentStep,b
        lda #0
        sta aPaletteFading.wDesiredColor,b
        lda #8
        sta aPaletteFading.wMaxSteps,b
        clc
        jsl rlFadePaletteToBlack

          .word $E23D

        bcs +

        -
        lda aPaletteFading.wCurrentStep,b
        sta $7F808D
        rtl

        +
        lda #(`procUnknown8AE147)<<8
        sta lR44+1
        lda #<>procUnknown8AE147
        sta lR44
        phx
        jsl rlProcEngineFindProc
        plx
        bcs +

          lda #$0001
          trb $08AD,b

        +
        jsl rlProcEngineFreeProc
        bra -

        .databank 0

        ; 8A/E23D

    .endsection Unsorted8AE1F3Section


    .section ProcScript8AE243Section

      .al
      .xl

      aProcUnknown8AE1EBCode ; 8A/E243

        PROC_HALT


        ; 8A/E245

    .endsection ProcScript8AE243Section


    .section Unsorted8AE245Section

      .al
      .xl

      procUnknown8AE245 ; 8A/E245

        .structProcInfo "FF", rlProcUnknown8AE245Init, rlProcUnknown8AE245Cycle, $8AE29D

      rlProcUnknown8AE245Init ; 8A/E24D

        .al
        .autsiz
        .databank ?

        lda #0
        sta $7F808F
        rtl

        .databank 0

      rlProcUnknown8AE245Cycle ; 8A/E255

        .al
        .autsiz
        .databank ?

        lda $7F808F
        sta aPaletteFading.wCurrentStep,b
        lda #0
        sta aPaletteFading.wDesiredColor,b
        lda #8
        sta aPaletteFading.wMaxSteps,b
        clc
        jsl rlFadePaletteToBlack
          .word <>aUnknown8AE297

        bcs +

          -
          lda aPaletteFading.wCurrentStep,b
          sta $7F808F
          rtl

        +
        lda #(`procUnknown8AE199)<<8
        sta lR44+1
        lda #<>procUnknown8AE199
        sta lR44
        phx
        jsl rlProcEngineFindProc
        plx
        bcs +

          lda #$0002
          trb $08AD,b

        +
        jsl rlProcEngineFreeProc
        bra -

        .databank 0

      aUnknown8AE297 ; 8A/E297

        .word $0182
        .word $000F
        .word $FFFF

      aProcUnknown8AE245Code ; 8A/E29D

        PROC_HALT

        ; 8A/E29F

    .endsection Unsorted8AE245Section


    .section Unsorted8AE2F8Section

      .al
      .xl

      rlUnknown8AE2F8 ; 8A/E2F8

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phk
        plb
        .databank $8A
        sep #$20
        lda #$80
        sta $2100,b
        sta bBufferINIDISP
        rep #$20
        jsl rlDisableVBlank
        jsl rlResetHDMAEngine
        lda #$004B
        sta $04BA,b
        jsl rlUnknown809654
        phk
        plb
        .databank $8A
        rep #$30
        lda #$1809
        sta $4300,b
        lda #(`aUnknown8AE4BA)<<8
        sta $4303,b
        lda #<>aUnknown8AE4BA
        sta $4302,b
        lda #$2000
        sta $4305,b
        lda #$2000
        sta $2116,b
        sep #$20
        lda #$01
        sta $420B,b
        rep #$20
        jsl rlResetDialogueEngine
        jsr rsUnknown8ABF27
        jsl rlUnknown889268
        lda wEventLocationEntry,b
        pha
        jsl rlUpdateAllLocationEvents
        jsl rlUnknown86C629
        pla
        sta wEventLocationEntry,b
        lda #$0000
        sta wR1
        lda #$0000
        sta wR2
        lda #$4000
        sta wR3
        sta wR4
        lda #$6000
        sta wR5
        lda #$2800
        sta wR6
        lda #$2C00
        sta wR7
        lda #$3800
        sta wR8
        jsl rlSetLayerPositionsAndSizes
        lda #(`aUnknown8AE4C3)<<8
        sta lR19+1
        lda #<>aUnknown8AE4C3
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        jsl rlDMAByStruct

          .structDMAToVRAM $DE40C0, $0400, $80, $C000

        jsl rlDMAByStruct

          .structDMAToVRAM $DE0200, $0800, $80, $D600

        lda #(`aUnknown8AE4CB)<<8
        sta lR19+1
        lda #<>aUnknown8AE4CB
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        lda #(`aUnknown8AE4D3)<<8
        sta lR19+1
        lda #<>aUnknown8AE4D3
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        jsl rlDMAByStruct

          .structDMAToVRAM $D76000, $0800, $80, $9800

        lda #(`aUnknown8AE4BB)<<8
        sta lR19+1
        lda #<>aUnknown8AE4BB
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        jsl rlGetDialogueBoxGraphicsAndPalette
        ldx #$0800
        lda #$00FF

        _E3EF
        sta aBG3TilemapBuffer,x
        dec x
        dec x
        bne _E3EF
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0700, $80, $7000

        ldx #$01FE

        _E407
        lda aUnknown8CD600,x
        sta aBGPaletteBuffer,b,x
        dec x
        dec x
        bpl _E407
        lda #$0001
        jsl rlUnitWindowCopySpritePalette1
        lda #$0002
        jsl rlUnitWindowCopySpritePalette2
        jsr rsUnknown8ABFD1
        sep #$20
        lda #$17
        sta bBufferTM
        lda #$00
        sta bBufferTS
        lda #$00
        sta bBufferCGWSEL
        lda #$00
        sta bBufferCGADSUB
        lda #$04
        ora #$20
        sta bBufferCOLDATA_1
        lda #$04
        ora #$40
        sta bBufferCOLDATA_2
        lda #$04
        ora #$80
        sta bBufferCOLDATA_3
        rep #$20
        lda $0AD7,b
        beq _E457
        jsl rlUnknown84B550
        cmp #$0002
        beq _E45D

        _E457
        jsl rlUnknown8A9EB7
        bra _E461


        _E45D
        jsl rlUnknown8A9F32

        _E461
        stz $08A1,b
        jsr rsUnknown8AA142
        stz $0592,b
        stz $08A1,b
        stz $08A3,b
        stz $08A5,b
        stz $08A7,b
        lda #$0000
        sta $7F7670
        lda #$8000
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$B6AD
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$2000
        sta aCurrentTilemapInfo,b
        jsr rsUnknown8AA830
        jsr rsUnknown8AA2ED
        jsr rsUnknown8AAD44
        lda #$8A00
        sta lR44+1
        lda #$B230
        sta lR44
        jsl rlHDMAEngineCreateEntry
        lda #$0004
        sta wGameStateStep,b
        jsl rlEnableVBlank
        sep #$20
        lda #$00
        sta bBufferINIDISP
        rep #$20
        rtl

        .databank 0

        ; 8A/E4B9

    .endsection Unsorted8AE2F8Section


    .section Unsorted8AECEFSection

      .al
      .xl

      rlUnknown8AECEF ; 8A/ECEF

        .al
        .xl
        .autsiz
        .databank ?

        phk
        plb
        .databank $8A
        sep #$20
        lda #$80
        sta $2100,b
        sta bBufferINIDISP
        rep #$20
        jsl rlDisableVBlank
        jsl rlResetHDMAEngine
        phk
        plb
        .databank $8A
        rep #$30
        lda #$1809
        sta $4300,b
        lda #$8A00
        sta $4303,b
        lda #$EE80
        sta $4302,b
        lda #$0020
        sta $4305,b
        lda #$2400
        sta $2116,b
        sep #$20
        lda #$01
        sta $420B,b
        rep #$20
        jsr rsUnknown8ABF27
        lda #$0000
        sta wR1
        lda #$0000
        sta wR2
        lda #$4000
        sta wR3
        sta wR4
        lda #$6000
        sta wR5
        lda #$2800
        sta wR6
        lda #$2C00
        sta wR7
        lda #$3800
        sta wR8
        jsl rlSetLayerPositionsAndSizes
        jsl rlResetDialogueEngine
        lda #$8A00
        sta lR19+1
        lda #$EE91
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        lda #$8A00
        sta lR19+1
        lda #$EE99
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        jsl rlDMAByStruct

          .structDMAToVRAM $DE40C0, $0400, $80, $C000

        jsl rlDMAByStruct

          .structDMAToVRAM $DE0200, $0800, $80, $D600

        lda #$8A00
        sta lR19+1
        lda #$EEA1
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        lda #$8A00
        sta lR19+1
        lda #$EEA9
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        jsl rlDMAByStruct

          .structDMAToVRAM $D76000, $0800, $80, $9800

        lda #$8A00
        sta lR19+1
        lda #$EE89
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        jsl rlGetDialogueBoxGraphicsAndPalette
        ldx #$0800
        lda #$00FF

        _EDD6
        sta aBG3TilemapBuffer,x
        dec x
        dec x
        bne _EDD6
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0700, $80, $7000

        ldx #$01FE

        _EDEE
        lda $8CD000,x
        sta aBGPaletteBuffer,b,x
        dec x
        dec x
        bpl _EDEE
        lda #$0001
        jsl rlUnitWindowCopySpritePalette1
        lda #$0002
        jsl rlUnitWindowCopySpritePalette2
        lda wCurrentChapter,b
        cmp #$0006
        bcs _EE14
        lda #$0018
        bra _EE17


        _EE14
        lda #$0028

        _EE17
        jsl rlUnknown8AFC52
        jsl rlUnknown8A94B6
        sep #$20
        lda #$20
        sta bBufferCOLDATA_1
        lda #$40
        sta bBufferCOLDATA_2
        lda #$80
        sta bBufferCOLDATA_3
        lda #$17
        sta bBufferTM
        lda #$00
        sta bBufferTS
        lda #$00
        sta bBufferCGWSEL
        lda #$00
        sta bBufferCGADSUB
        rep #$20
        stz $0592,b
        stz $08A1,b
        stz $08A3,b
        stz $08A5,b
        stz $08A7,b
        jsl rlUnknown8A9FCC
        jsr rsUnknown8AA142
        lda #$8000
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$B6AD
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$2000
        sta aCurrentTilemapInfo,b
        jsr rsUnknown8AAD44
        lda #$000A
        sta wGameStateStep,b
        rep #$20
        jsl rlEnableVBlank
        sep #$20
        lda #$00
        sta bBufferINIDISP
        rep #$20
        rtl

        .databank 0

        ; 8A/EE7F

    .endsection Unsorted8AECEFSection


    .section Unsorted8AEEB1Section

      .al
      .xl

      rlUnknown8AEEB1 ; 8A/EEB1

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $8A
        lda $7F7670
        bne _EECA
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0700, $80, $7000

        bra _EED4


        _EECA
        lda #$0000
        sta $7F7670
        jsr rsUnknown8AA142

        _EED4
        lda $0592,b
        asl a
        tax
        jsr (aUnknown8AEEF2,x)
        jsr rsUnknown8AAF0A
        lda #$0008
        sta wR0
        lda #$0008
        sta wR1
        ldx #$0000
        jsr rsUnknown8A950E
        plp
        plb
        .databank $8A
        rtl

        .databank 0

        ; 8A/EEF2

    .endsection Unsorted8AEEB1Section


    .section Table8AEEF2Section

      .al
      .xl

      aUnknown8AEEF2 ; 8A/EEF2

        ; Jump table of rlUnknown8AEEB1.
        .word <>rsUnknown8AEEFE
        .word <>rsUnknown8AEF30
        .word <>rsUnknown8AEF4B
        .word <>rsUnknown8AF048
        .word <>rsUnknown8AF0B4
        .word <>rsUnknown8AF0D7

    .endsection Table8AEEF2Section


    .section Unsorted8AEEFESection

      .al
      .xl

      rsUnknown8AEEFE ; 8A/EEFE

        .al
        .xl
        .autsiz
        .databank ?

        lda #$000C
        tax
        lda $8ACEB4,x
        sta lR18+1
        lda aUnknown8ACEB3,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$0001
        sta $0592,b
        lda #$0002
        sta $0594,b
        sep #$20
        lda #$0F
        sta bBufferINIDISP
        rep #$20
        rts

        .databank 0

        ; 8A/EF30

      rsUnknown8AEF30 ; 8A/EF30

        .al
        .xl
        .autsiz
        .databank ?

        lda aDialogue.wStatus,b
        beq _EF44
        lda #$00E8
        sta wR0
        lda #$0036
        sta wR1
        jsl rlDisplayDialogueAPressArrows
        rts


        _EF44
        lda $0594,b
        sta $0592,b
        rts

        .databank 0

        ; 8A/EF4B

      rsUnknown8AEF4B ; 8A/EF4B

        .al
        .xl
        .autsiz
        .databank ?

        lda #$8000
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$B6AD
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda #$000C
        tax
        jsl rlGetPromotedClassIfAvailable
        bcc _EF6B
        jml _F00D


        _EF6B
        lda $7E2000
        beq _EFD5
        lda $7E2002
        and #$00FF
        clc
        adc #$0001
        sta aDialogue.wClassID,b
        lda wCurrentChapter,b
        cmp #$0006
        bcs _EFB1
        lda #$000C
        tax
        lda $8ACF92,x
        sta lR18+1
        lda $8ACF91,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$0001
        sta $0592,b
        lda #$0003
        sta $0594,b
        rts


        _EFB1
        lda #$8A00
        sta lR18+1
        lda #$D7A4
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$0001
        sta $0592,b
        lda #$0003
        sta $0594,b
        rts


        _EFD5
        lda wCurrentChapter,b
        cmp #$0006
        bcs _EFE9
        lda #$8A00
        sta lR18+1
        lda #$D756
        sta lR18
        bra _EFF3


        _EFE9
        lda #$8A00
        sta lR18+1
        lda #$D7D0
        sta lR18

        _EFF3
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$0001
        sta $0592,b
        lda #$0005
        sta $0594,b
        rts


        _F00D
        lda wCurrentChapter,b
        cmp #$0006
        bcs _F021
        lda #$8A00
        sta lR18+1
        lda #$D785
        sta lR18
        bra _F02B


        _F021
        lda #$8A00
        sta lR18+1
        lda #$D7FC
        sta lR18

        _F02B
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$0001
        sta $0592,b
        lda #$0005
        sta $0594,b
        rts

        .databank 0

        ; 8A/F045

    .endsection Unsorted8AEEFESection


    .section Unsorted8AF048Section

      .al
      .xl

      rsUnknown8AF048 ; 8A/F048

        .al
        .xl
        .autsiz
        .databank ?

        lda #$2000
        sta aCurrentTilemapInfo,b
        jsr rsUnknown8AD092
        jsr rsUnknown8AA46E
        lda #$0000
        jsl rlUnknown8AB043
        lda wJoy1New
        cmp #$8000
        beq _F083
        cmp #$0080
        bne _F074
        lda $08A3,b
        cmp #$0000
        beq _F075
        cmp #$0001
        beq _F083

        _F074
        rts


        _F075
        lda #$000A
        jsl rlPlaySoundEffect
        lda #$0004
        sta $0592,b
        rts


        _F083
        lda #$0021
        jsl rlPlaySoundEffect
        lda #$000C
        tax
        lda $8ACEEA,x
        sta lR18+1
        lda $8ACEE9,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$0001
        sta $0592,b
        lda #$0005
        sta $0594,b
        rts

        .databank 0

        ; 8A/F0B4

    .endsection Unsorted8AF048Section


    .section Unsorted8AF0B4Section

      .al
      .xl

      rsUnknown8AF0B4 ; 8A/F0B4

        .al
        .xl
        .autsiz
        .databank ?

        lda wVBlankEnabledFramecount
        and #$0001
        bne _F0C5
        sep #$20
        lda bBufferINIDISP
        and #$0F
        beq _F0C8
        dec bBufferINIDISP

        _F0C5
        rep #$20
        rts


        _F0C8
        .as
        rep #$20
        lda $08A7,b
        tax
        lda $7E2002,x
        jsl rlUnknown84ABB0
        rts

        .databank 0

        ; 8A/F0D7

    .endsection Unsorted8AF0B4Section


    .section Unsorted8AF0D7Section

      .al
      .xl

      rsUnknown8AF0D7 ; 8A/F0D7

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta $0891,b
        lda #$0003
        sta $0893,b
        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        lda #$0011
        sta wGameStateStep,b
        rts

        .databank 0

        ; 8A/F0F2

      rlUnknown8AF0F2 ; 8A/F0F2

        .al
        .xl
        .autsiz
        .databank ?

        phk
        plb
        .databank $8A
        sep #$20
        lda #$80
        sta $2100,b
        sta bBufferINIDISP
        rep #$20
        jsl rlDisableVBlank
        jsl rlResetHDMAEngine
        jsr rsUnknown8ABF27
        lda #$0000
        sta wR1
        lda #$0000
        sta wR2
        lda #$4000
        sta wR3
        sta wR4
        lda #$6000
        sta wR5
        lda #$2800
        sta wR6
        lda #$2C00
        sta wR7
        lda #$3800
        sta wR8
        jsl rlSetLayerPositionsAndSizes
        jsl rlResetDialogueEngine
        lda #$8A00
        sta lR19+1
        lda #$F26B
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        jsl rlDMAByStruct

          .structDMAToVRAM $DE40C0, $0400, $80, $C000

        jsl rlDMAByStruct

          .structDMAToVRAM $DE0200, $0800, $80, $D600

        lda #$8A00
        sta lR19+1
        lda #$F273
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        lda #$8A00
        sta lR19+1
        lda #$F27B
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        jsl rlDMAByStruct

          .structDMAToVRAM $D76000, $0800, $80, $9800

        lda #$8A00
        sta lR19+1
        lda #$F263
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        jsl rlGetDialogueBoxGraphicsAndPalette
        ldx #$0800
        lda #$00FF

        _F1A0
        sta aBG3TilemapBuffer,x
        dec x
        dec x
        bne _F1A0
        ldx #$01FE

        _F1AB
        lda $8CD800,x
        sta aBGPaletteBuffer,b,x
        dec x
        dec x
        bpl _F1AB
        lda #$0001
        jsl rlUnitWindowCopySpritePalette1
        lda #$0002
        jsl rlUnitWindowCopySpritePalette2
        lda #$00B2
        jsl rlUnknown8AFC52
        jsl rlUnknown8A94B6
        sep #$20
        lda #$17
        sta bBufferTM
        lda #$00
        sta bBufferTS
        lda #$00
        sta bBufferCGWSEL
        lda #$00
        sta bBufferCGADSUB
        lda #$03
        ora #$20
        sta bBufferCOLDATA_1
        lda #$03
        ora #$40
        sta bBufferCOLDATA_2
        lda #$03
        ora #$80
        sta bBufferCOLDATA_3
        rep #$20
        stz $0592,b
        stz $08A1,b
        stz $08A3,b
        stz $08A5,b
        stz $08A7,b
        jsl rlUnknown8A9E5A
        jsr rsUnknown8AA142
        lda #$8000
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$B6AD
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$2000
        sta aCurrentTilemapInfo,b
        jsr rsUnknown8AAD44
        jsr rsUnknown8AAB48
        jsr rsUnknown8AA830
        jsr rsUnknown8AA2ED
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0700, $80, $7000

        lda #$8A00
        sta lR44+1
        lda #$B230
        sta lR44
        jsl rlHDMAEngineCreateEntry
        lda #$0008
        sta wGameStateStep,b
        rep #$20
        jsl rlEnableVBlank
        sep #$20
        lda #$00
        sta bBufferINIDISP
        rep #$20
        rtl

        .databank 0

        ; 8A/F259

    .endsection Unsorted8AF0D7Section


    .section Unsorted8AF283Section

      .al
      .xl

      rlUnknown8AF283 ; 8A/F283

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $8A
        lda $0592,b
        asl a
        tax
        jsr (aUnknown8AF2C7,x)
        lda $7F7670
        bne _F2A4
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0700, $80, $7000

        bra _F2AE


        _F2A4
        lda #$0000
        sta $7F7670
        jsr rsUnknown8AA142

        _F2AE
        jsr rsUnknown8AAF0A
        jsr rsUnknown8AA2ED
        lda #$0008
        sta wR0
        lda #$0008
        sta wR1
        ldx #$0000
        jsr rsUnknown8A950E
        plp
        plb
        .databank $8A
        rtl

        .databank 0

        ; 8A/F2C7

    .endsection Unsorted8AF283Section


    .section Table8AF2C7Section

      .al
      .xl

      aUnknown8AF2C7 ; 8A/F2C7

        ; Jump table of rlUnknown8AF283.
        .word <>rsUnknown8AF2E1
        .word <>rsUnknown8AF313
        .word <>rsUnknown8AF362
        .word <>rsUnknown8AF4A1
        .word <>rsUnknown8AF4B8
        .word <>rsUnknown8AF556
        .word <>rsUnknown8AF634
        .word <>rsUnknown8AF6A1
        .word <>rsUnknown8AF6D5
        .word <>rsUnknown8AF6EC
        .word <>rsUnknown8AF791
        .word <>rsUnknown8AF818
        .word <>rsUnknown8AF885

    .endsection Table8AF2C7Section


    .section Unsorted8AF2E1Section

      .al
      .xl

      rsUnknown8AF2E1 ; 8A/F2E1

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0009
        tax
        lda $8ACEB4,x
        sta lR18+1
        lda aUnknown8ACEB3,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$0001
        sta $0592,b
        lda #$0002
        sta $0594,b
        sep #$20
        lda #$0F
        sta bBufferINIDISP
        rep #$20
        rts

        .databank 0

        ; 8A/F313

      rsUnknown8AF313 ; 8A/F313

        .al
        .xl
        .autsiz
        .databank ?

        lda $0594,b
        cmp #$0005
        beq _F33B
        cmp #$000A
        beq _F340

        _F320
        lda aDialogue.wStatus,b
        beq _F334
        lda #$00E8
        sta wR0
        lda #$0036
        sta wR1
        jsl rlDisplayDialogueAPressArrows
        rts


        _F334
        lda $0594,b
        sta $0592,b
        rts


        _F33B
        jsr rsUnknown8AA8C9
        bra _F343


        _F340
        jsr rsUnknown8AA928

        _F343
        lda $08A5,b
        tax
        lda #$004C
        sta wR0
        lda $8A9DD5,x
        and #$00FF
        clc
        adc #$0004
        sta wR1
        lda #$0000
        jsl rlUnknown8AB043
        bra _F320

        .databank 0

        ; 8A/F362

      rsUnknown8AF362 ; 8A/F362

        .al
        .xl
        .autsiz
        .databank ?

        lda #$8000
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$B6AD
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda #$8A00
        sta lR18+1
        lda #$F475
        sta lR18
        lda $18DD,b
        cmp #$0100
        beq _F38C
        clc
        adc #$0120
        bra _F390


        _F38C
        sec
        sbc #$0040

        _F390
        clc
        adc #$000B
        tax
        jsl rlDrawMenuTextLine
        stz $08A5,b
        stz $08A7,b
        lda #$8A00
        sta lR19+1
        lda #$D081
        sta lR19
        lda #$8A00
        sta lR20+1
        lda #$D083
        sta lR20
        lda #$0002
        jsr rsUnknown8ACFBE
        lda #$0000
        jsl rlUnknown8AB043
        lda wJoy1New
        cmp #$8000
        beq _F3DE
        cmp #$0080
        bne _F3DD
        lda #$0009
        tax
        lda $08A1,b
        cmp #$0000
        beq _F40F
        cmp #$0001
        beq _F425

        _F3DD
        rts


        _F3DE
        lda #$0009
        tax
        lda $8ACEEA,x
        sta lR18+1
        lda $8ACEE9,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$0001
        sta $0592,b
        lda #$000C
        sta $0594,b
        lda #$0021
        jsl rlPlaySoundEffect
        rts


        _F40F
        lda $0889,b
        beq _F459
        lda $8ACF56,x
        sta lR18+1
        lda $8ACF55,x
        sta lR18
        lda #$0008
        bra _F43B


        _F425
        lda $08AB,b
        beq _F467
        lda $8ACEFC,x
        sta lR18+1
        lda $8ACEFB,x
        sta lR18
        lda #$0003
        bra _F43B


        _F43B
        sta $0594,b
        lda #$0001
        sta $0592,b
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$000A
        jsl rlPlaySoundEffect
        rts


        _F459
        lda #$8A00
        sta lR18+1
        lda #$D418
        sta lR18
        jml $8AC312


        _F467
        lda #$8A00
        sta lR18+1
        lda #$D46F
        sta lR18
        jml $8AC312

        .databank 0

        ; 8A/F475

    .endsection Unsorted8AF2E1Section


    .section Unsorted8AF4A1Section

      .al
      .xl

      rsUnknown8AF4A1 ; 8A/F4A1

        .al
        .xl
        .autsiz
        .databank ?

        lda #$FFFF
        sta $7F7670
        jsr rsUnknown8AA63D
        jsr rsUnknown8AA8C9
        jsr rsUnknown8AA9CE
        lda #$0004
        sta $0592,b
        rts

        .databank 0

        ; 8A/F4B8

    .endsection Unsorted8AF4A1Section


    .section Unsorted8AF4B8Section

      .al
      .xl

      rsUnknown8AF4B8 ; 8A/F4B8

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown8AA8C9
        lda $08A5,b
        tax
        lda #$004C
        sta wR0
        lda $8A9DD5,x
        and #$00FF
        clc
        adc #$0004
        sta wR1
        lda #$0000
        jsl rlUnknown8AB043
        jsl $8AB093
        jsr rsUnknown8AA400
        lda wJoy1New
        cmp #$0080
        beq _F4EC
        cmp #$8000
        beq _F522

        _F4EB
        rts


        _F4EC
        lda $08AB,b
        beq _F4EB
        lda #$000A
        jsl rlPlaySoundEffect
        lda #$0009
        tax
        lda $8ACF0B,x
        sta lR18+1
        lda $8ACF0A,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$0001
        sta $0592,b
        lda #$0005
        sta $0594,b
        rts


        _F522
        lda #$0021
        jsl rlPlaySoundEffect
        lda #$0009
        tax
        lda $8ACED8,x
        sta lR18+1
        lda $8ACED7,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$0001
        sta $0592,b
        lda #$0002
        sta $0594,b
        jsr rsUnknown8AA830
        rts

        .databank 0

        ; 8A/F556

    .endsection Unsorted8AF4B8Section


    .section Unsorted8AF556Section

      .al
      .xl

      rsUnknown8AF556 ; 8A/F556

        .al
        .xl
        .autsiz
        .databank ?

        lda #$2000
        sta aCurrentTilemapInfo,b
        jsr rsUnknown8AA8C9
        lda $08A5,b
        tax
        lda #$004C
        sta wR0
        lda $8A9DD5,x
        and #$00FF
        clc
        adc #$0004
        sta wR1
        lda #$0001
        jsl rlUnknown8AB043
        jsr rsUnknown8AD092
        jsr rsUnknown8AA46E
        lda #$0000
        jsl rlUnknown8AB043
        lda wJoy1New
        cmp #$8000
        beq _F5A3
        cmp #$0080
        bne _F5A2
        lda $08A3,b
        cmp #$0000
        beq _F5B7
        cmp #$0001
        beq _F5A3

        _F5A2
        rts


        _F5A3
        lda #$0021
        jsl rlPlaySoundEffect
        stz $08A3,b
        lda #$0006
        sta $0592,b
        jsr rsUnknown8AA830
        rts


        _F5B7
        ldy #$0000
        stz wTempVariable1,b

        _F5BD
        tya
        clc
        adc #$0001
        jsl rlGetItemROMDataByInventorySlot
        lda wCurrentItemDataROMPointer,b
        beq _F5D4
        inc wTempVariable1,b
        inc y
        cpy #$0007
        bcc _F5BD

        _F5D4
        lda wTempVariable1,b
        cmp #$0007
        beq _F600
        lda $08A7,b
        asl a
        tax
        lda $7F7672,x
        sta wRoutineVariable1,b
        jsl rlGiveItemToUnitCheckEncumbered
        lda #$000A
        jsl rlPlaySoundEffect
        stz $08A3,b
        lda #$0006
        sta $0592,b
        jsr rsUnknown8AA830
        rts


        _F600
        lda #$0021
        jsl rlPlaySoundEffect
        lda #$0009
        tax
        lda $8ACF38,x
        sta lR18+1
        lda $8ACF37,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$0001
        sta $0592,b
        lda #$0007
        sta $0594,b
        jsr rsUnknown8AA830
        rts

        .databank 0

        ; 8A/F634

    .endsection Unsorted8AF556Section


    .section Unsorted8AF634Section

      .al
      .xl

      rsUnknown8AF634 ; 8A/F634

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown8A9E5A
        jsr rsUnknown8AA9CE
        lda #$FFFF
        sta $7F7670
        stz $08A5,b
        stz $08A7,b
        lda $08AB,b
        beq _F677
        lda #$0009
        tax
        lda $8ACF1A,x
        sta lR18+1
        lda $8ACF19,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$0001
        sta $0592,b
        lda #$0003
        sta $0594,b
        rts


        _F677
        lda #$0009
        tax
        lda $8ACED8,x
        sta lR18+1
        lda $8ACED7,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$0001
        sta $0592,b
        lda #$0002
        sta $0594,b
        rts

        .databank 0

        ; 8A/F6A1

    .endsection Unsorted8AF634Section


    .section Unsorted8AF6A1Section

      .al
      .xl

      rsUnknown8AF6A1 ; 8A/F6A1

        .al
        .xl
        .autsiz
        .databank ?

        stz $08A3,b
        lda #$0021
        jsl rlPlaySoundEffect
        lda #$0009
        tax
        lda $8ACED8,x
        sta lR18+1
        lda $8ACED7,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$0001
        sta $0592,b
        lda #$0002
        sta $0594,b
        rts

        .databank 0

        ; 8A/F6D5

    .endsection Unsorted8AF6A1Section


    .section Unsorted8AF6D5Section

      .al
      .xl

      rsUnknown8AF6D5 ; 8A/F6D5

        .al
        .xl
        .autsiz
        .databank ?

        lda #$FFFF
        sta $7F7670
        jsr rlUnknown8AA83D
        jsr rsUnknown8AA928
        jsr rsUnknown8AAB48
        lda #$0009
        sta $0592,b
        rts

        .databank 0

        ; 8A/F6EC

    .endsection Unsorted8AF6D5Section


    .section Unsorted8AF6ECSection

      .al
      .xl

      rsUnknown8AF6EC ; 8A/F6EC

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown8AA928
        lda $08A5,b
        tax
        lda #$004C
        sta wR0
        lda $8A9DD5,x
        and #$00FF
        clc
        adc #$0004
        sta wR1
        lda #$0000
        jsl rlUnknown8AB043
        jsr rsUnknown8AA4C8
        lda wJoy1New
        cmp #$0080
        beq _F71C
        cmp #$8000
        beq _F75D

        _F71B
        rts


        _F71C
        lda $08A7,b
        inc a
        sta wRoutineVariable1,b
        jsl rlGetItemROMDataByInventorySlot
        lda wCurrentItemDataROMPointer,b
        beq _F71B
        lda #$000A
        jsl rlPlaySoundEffect
        lda #$0009
        tax
        lda $8ACF65,x
        sta lR18+1
        lda $8ACF64,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$0001
        sta $0592,b
        lda #$000A
        sta $0594,b
        rts


        _F75D
        lda #$0021
        jsl rlPlaySoundEffect
        lda #$0009
        tax
        lda $8ACED8,x
        sta lR18+1
        lda $8ACED7,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$0001
        sta $0592,b
        lda #$0002
        sta $0594,b
        jsr rsUnknown8AA830
        rts

        .databank 0

        ; 8A/F791

    .endsection Unsorted8AF6ECSection


    .section Unsorted8AF791Section

      .al
      .xl

      rsUnknown8AF791 ; 8A/F791

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown8AA928
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda $08A5,b
        tax
        lda #$004C
        sta wR0
        lda $8A9DD5,x
        and #$00FF
        clc
        adc #$0004
        sta wR1
        lda #$0001
        jsl rlUnknown8AB043
        jsr rsUnknown8AD092
        jsr rsUnknown8AA46E
        lda #$0000
        jsl rlUnknown8AB043
        lda wJoy1New
        cmp #$8000
        beq _F804
        cmp #$0080
        bne _F7DD
        lda $08A3,b
        cmp #$0000
        beq _F7DE
        cmp #$0001
        beq _F804

        _F7DD
        rts


        _F7DE
        jsl rlSendInventorySlotItemToSupply
        jsl rlUnknown8A9E5A
        jsr rsUnknown8AAB48
        lda #$FFFF
        sta $7F7670
        lda #$000A
        jsl rlPlaySoundEffect
        stz $08A3,b
        lda #$000B
        sta $0592,b
        jsr rsUnknown8AA830
        rts


        _F804
        lda #$0021
        jsl rlPlaySoundEffect
        stz $08A3,b
        lda #$000B
        sta $0592,b
        jsr rsUnknown8AA830
        rts

        .databank 0

        ; 8A/F818

    .endsection Unsorted8AF791Section


    .section Unsorted8AF818Section

      .al
      .xl

      rsUnknown8AF818 ; 8A/F818

        .al
        .xl
        .autsiz
        .databank ?

        stz $08A5,b
        stz $08A7,b
        lda $0889,b
        beq _F84D
        lda #$0009
        tax
        lda $8ACF74,x
        sta lR18+1
        lda $8ACF73,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$0001
        sta $0592,b
        lda #$0008
        sta $0594,b
        rts


        _F84D
        lda $7F8082
        clc
        adc $7F8082
        clc
        adc $7F8082
        tax
        lda $8ACED8,x
        sta lR18+1
        lda $8ACED7,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$0001
        sta $0592,b
        lda #$0002
        sta $0594,b
        jsr rsUnknown8AAB48
        rts

        .databank 0

        ; 8A/F885

    .endsection Unsorted8AF818Section


    .section Unsorted8AF885Section

      .al
      .xl

      rsUnknown8AF885 ; 8A/F885

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        lda #$0012
        sta wGameStateStep,b
        rts

        .databank 0

        ; 8A/F894

      rlUnknown8AF894 ; 8A/F894

        .al
        .xl
        .autsiz
        .databank ?

        phk
        plb
        .databank $8A
        sep #$20
        lda #$80
        sta $2100,b
        sta bBufferINIDISP
        rep #$20
        jsl rlDisableVBlank
        jsl rlResetHDMAEngine
        jsr rsUnknown8ABF27
        lda #$0000
        sta wR1
        lda #$0000
        sta wR2
        lda #$4000
        sta wR3
        sta wR4
        lda #$6000
        sta wR5
        lda #$2800
        sta wR6
        lda #$2C00
        sta wR7
        lda #$3800
        sta wR8
        jsl rlSetLayerPositionsAndSizes
        jsl rlResetDialogueEngine
        lda #$8A00
        sta lR19+1
        lda #$FA14
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        lda #$8A00
        sta lR19+1
        lda #$FA1C
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        jsl rlDMAByStruct

          .structDMAToVRAM $DE40C0, $0400, $80, $C000

        lda #$8A00
        sta lR19+1
        lda #$FA24
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        lda #$8A00
        sta lR19+1
        lda #$FA2C
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        jsl rlDMAByStruct

          .structDMAToVRAM $D76000, $0800, $80, $9800

        lda #$8A00
        sta lR19+1
        lda #$FA0C
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        jsl rlGetDialogueBoxGraphicsAndPalette
        ldx #$0800
        lda #$00FF

        _F943
        sta aBG3TilemapBuffer,x
        dec x
        dec x
        bne _F943
        ldx #$01FE

        _F94E
        lda $8CDA00,x
        sta aBGPaletteBuffer,b,x
        dec x
        dec x
        bpl _F94E
        lda #$00B3
        jsl rlUnknown8AFC52
        jsl rlUnknown8A94B6
        sep #$20
        lda #$17
        sta bBufferTM
        lda #$00
        sta bBufferTS
        lda #$00
        sta bBufferCGWSEL
        lda #$00
        sta bBufferCGADSUB
        lda #$20
        sta bBufferCOLDATA_1
        lda #$40
        sta bBufferCOLDATA_2
        lda #$80
        sta bBufferCOLDATA_3
        rep #$20
        stz $0592,b
        stz $08A1,b
        stz $08A3,b
        stz $08A5,b
        stz $08A7,b
        lda #$8000
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$B6AD
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$2C00
        sta aCurrentTilemapInfo,b
        jsr rsUnknown8AAD44
        jsl rlGetUnitType
        cmp #$0001
        bne _F9BB
        sep #$20
        lda #$02
        sta $7F8183
        bra _F9C3


        _F9BB
        .al
        sep #$20
        lda #$01
        sta $7F8183

        _F9C3
        lda #$00
        sta $7F8184
        lda #$01
        sta $7F8185
        lda #$02
        sta $7F8186
        rep #$20
        lda $7F8183
        and #$00FF
        sta $7F8091
        jsr rsUnknown8AAD6F
        jsr rsUnknown8AA2ED
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0700, $80, $7000

        lda #$0006
        sta wGameStateStep,b
        rep #$20
        jsl rlEnableVBlank
        sep #$20
        lda #$00
        sta bBufferINIDISP
        rep #$20
        rtl

        .databank 0

        ; 8A/FA0A

    .endsection Unsorted8AF885Section


    .section Unsorted8AFA34Section

      .al
      .xl

      rlUnknown8AFA34 ; 8A/FA34

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $8A
        lda $7F7670
        bne _FA4D
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0700, $80, $7000

        bra _FA54


        _FA4D
        lda #$0000
        sta $7F7670

        _FA54
        lda $0592,b
        asl a
        tax
        jsr (aUnknown8AFA6F,x)
        lda #$0008
        sta wR0
        lda #$0008
        sta wR1
        ldx #$0000
        jsr rsUnknown8A950E
        plp
        plb
        .databank $8A
        rtl

        .databank 0

        ; 8A/FA6F

    .endsection Unsorted8AFA34Section


    .section Table8AFA6FSection

      .al
      .xl

      aUnknown8AFA6F ; 8A/FA6F

        ; Jump table of rlUnknown8AFA34.
        .word <>rsUnknown8AFA7F
        .word <>rsUnknown8AFAAB
        .word <>rsUnknown8AFAC6
        .word <>rsUnknown8AFAE6
        .word <>rsUnknown8AFAF0
        .word <>rsUnknown8AFB5D
        .word <>rsUnknown8AFCD5
        .word <>rsUnknown8AFD00

    .endsection Table8AFA6FSection


    .section Unsorted8AFA7FSection

      .al
      .xl

      rsUnknown8AFA7F ; 8A/FA7F

        .al
        .xl
        .autsiz
        .databank ?

        lda #$8A00
        sta lR18+1
        lda #$D616
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$0001
        sta $0592,b
        lda #$0002
        sta $0594,b
        sep #$20
        lda #$0F
        sta bBufferINIDISP
        rep #$20
        rts

        .databank 0

        ; 8A/FAAB

      rsUnknown8AFAAB ; 8A/FAAB

        .al
        .xl
        .autsiz
        .databank ?

        lda aDialogue.wStatus,b
        beq _FABF
        lda #$00E8
        sta wR0
        lda #$0036
        sta wR1
        jsl rlDisplayDialogueAPressArrows
        rts


        _FABF
        lda $0594,b
        sta $0592,b
        rts

        .databank 0

        ; 8A/FAC6

      rsUnknown8AFAC6 ; 8A/FAC6

        .al
        .xl
        .autsiz
        .databank ?

        lda #$8000
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$B6AD
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$2C00
        sta aCurrentTilemapInfo,b
        lda #$0003
        sta $0592,b
        lda #$000A
        jsl rlPlaySoundEffect
        rts

        .databank 0

        ; 8A/FAE6

      rsUnknown8AFAE6 ; 8A/FAE6

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown8AAD6F
        lda #$0004
        sta $0592,b
        rts

        .databank 0

        ; 8A/FAF0

      rsUnknown8AFAF0 ; 8A/FAF0

        .al
        .xl
        .autsiz
        .databank ?

        lda $08A5,b
        tax
        lda #$0004
        sta wR0
        lda $8A9DD5,x
        and #$00FF
        clc
        adc #$0004
        sta wR1
        lda #$0000
        jsl rlUnknown8AB043
        jsr rsUnknown8AA598
        lda wJoy1New
        cmp #$0080
        beq _FB1D
        cmp #$8000
        beq _FB32
        rts


        _FB1D
        lda #$FFFF
        sta $7F7670
        lda #$000A
        jsl rlPlaySoundEffect
        lda #$0005
        sta $0592,b
        rts


        _FB32
        lda #$0021
        jsl rlPlaySoundEffect
        lda #$8A00
        sta lR18+1
        lda #$D6DA
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$0001
        sta $0592,b
        lda #$0007
        sta $0594,b
        rts

        .databank 0

        ; 8A/FB5D

      rsUnknown8AFB5D ; 8A/FB5D

        .al
        .xl
        .autsiz
        .databank ?

        lda #$2C00
        sta aCurrentTilemapInfo,b
        lda $08A5,b
        tax
        lda #$0004
        sta wR0
        lda $8A9DD5,x
        and #$00FF
        sta wR1
        lda #$0001
        jsl rlUnknown8AB043
        lda #$FFFF
        sta $7F7670
        lda $08A7,b
        tax
        lda $7F8184,x
        and #$00FF
        asl a
        tax
        ldx #$0000
        jsl rlDialogueClearDialogueWrapper
        lda $08A7,b
        tax
        lda $7F8184,x
        and #$00FF
        cmp #$0001
        beq _FBAE
        cmp #$0002
        beq _FBC8
        bra _FC09


        _FBAE
        jsl rlUnknown87A13C
        sta aDialogue.wNumber1,b
        jsl rlUnknown87A165
        sta aDialogue.wNumber2,b
        lda #$8A00
        sta lR18+1
        lda #$D6E7
        sta lR18
        bra _FBE2


        _FBC8
        jsl rlGetSelectedUnitFatherID
        sta aDialogue.wUnit1,b
        jsl rlGetSelectedUnitMotherID
        sta aDialogue.wUnit2,b
        lda #$8A00
        sta lR18+1
        lda #$D70D
        sta lR18
        bra _FBE2


        _FBE2
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsl rlUnknown8ACE50
        lda #$0001
        sta $0592,b
        lda #$0006
        sta $0594,b
        rts


        _FBFD
        lda #$8A00
        sta lR18+1
        lda #$D6BE
        sta lR18
        bra _FBE2


        _FC09
        jsr rsUnknown8AFC78
        cmp #$01F4
        beq _FC46
        cmp #$0190
        bcs _FC3A
        cmp #$012C
        bcs _FC2E
        cmp #$00C8
        bcs _FC22
        bra _FBFD


        _FC22
        lda #$8A00
        sta lR18+1
        lda #$D65E
        sta lR18
        bra _FBE2


        _FC2E
        lda #$8A00
        sta lR18+1
        lda #$D678
        sta lR18
        bra _FBE2


        _FC3A
        lda #$8A00
        sta lR18+1
        lda #$D68E
        sta lR18
        bra _FBE2


        _FC46
        lda #$8A00
        sta lR18+1
        lda #$D6A8
        sta lR18
        bra _FBE2

        .databank 0

        ; 8A/FC52

    .endsection Unsorted8AFA7FSection


    .section Unsorted8AFC52Section

      .al
      .xl

      rlUnknown8AFC52 ; 8A/FC52

        .al
        .xl
        .autsiz
        .databank ?

        jsl $8AB45E
        ldx #$001E
        ldy #$001E

        _FC5C
        lda [lR19],y
        sta aOAMPaletteBuffer.aPalette5,b,y
        dec x
        dec x
        dec y
        dec y
        bpl _FC5C
        lda #$0800
        sta wR0
        lda #$6700
        sta wR1
        phx
        jsl rlDMAByPointer
        plx
        rtl

        .databank 0

        ; 8A/FC78

    .endsection Unsorted8AFC52Section


    .section Unsorted8AFC78Section

      .al
      .xl

      rsUnknown8AFC78 ; 8A/FC78

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda wSelectedUnitDataRAMPointer,b
        pha
        lda $089F,b
        jsl rlUnknown87AE88
        sta wTempVariable1,b
        lda wTempVariable1,b
        ora #$0000
        beq _FCCD
        jsl rlFindCharacterByGenerationID
        jsl rlGetSelectedUnitCharacterID
        sta aDialogue.wUnit1,b
        pla
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitGenerationID
        cmp #$0010
        bcs _FCC5
        sta wTempVariable2,b
        lda wSelectedUnitDataRAMPointer,b
        pha
        lda wTempVariable1,b
        jsl rlFindCharacterByGenerationID
        lda wTempVariable2,b
        jsl rlGetLoverPointsWithTarget
        sta wR0
        pla
        sta wSelectedUnitDataRAMPointer,b
        lda wR0
        bra _FCCC


        _FCC5
        lda wTempVariable1,b
        jsl rlGetLoverPointsWithTarget

        _FCCC
        rts


        _FCCD
        pla
        sta wSelectedUnitDataRAMPointer,b
        lda #$0000
        rts

        .databank 0

        ; 8A/FCD5

    .endsection Unsorted8AFC78Section


    .section Unsorted8AFCD5Section

      .al
      .xl

      rsUnknown8AFCD5 ; 8A/FCD5

        .al
        .xl
        .autsiz
        .databank ?

        lda #$FFFF
        sta $7F7670
        lda #$8A00
        sta lR18+1
        lda #$D648
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$0001
        sta $0592,b
        lda #$0003
        sta $0594,b
        rts

        .databank 0

        ; 8A/FD00

      rsUnknown8AFD00 ; 8A/FD00

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        lda #$0012
        sta wGameStateStep,b
        rts

        .databank 0

        ; 8A/FD0F

    .endsection Unsorted8AFCD5Section
