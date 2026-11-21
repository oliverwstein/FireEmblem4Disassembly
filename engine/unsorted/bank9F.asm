; Code from bank $9F not yet assigned to a game system.

    .section Unsorted9F8020Section

      .al
      .xl

      rlUnknown9F8020 ; 9F/8020

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F5089
        bpl _8027
        rtl


        _8027
        phb
        phk
        plb
        .databank $9F
        phx
        phy
        jsr rsUnknown9F82A7
        jsr rsUnknown9F8414
        jsr rsUnknown9F83D0
        lda #$0000
        sta $7F50A1
        sta $7F50A3
        lda #$FFFF
        sta $7F50A5
        sta $7F50B7
        lda #(`procUnknown9F805D)<<8
        sta lR44+1
        lda #<>procUnknown9F805D
        sta lR44
        jsl rlProcEngineCreateProc
        ply
        plx
        plb
        .databank ?
        rtl

        .databank 0

        ; 9F/805D

    .endsection Unsorted9F8020Section


    .section ProcScript9F805DSection

      .al
      .xl

      procUnknown9F805D ; 9F/805D

        .structProcInfo "ON", rlProcUnknown9F805DInit, rlProcUnknown9F805DCycle, aProcUnknown9F805DCode

    .endsection ProcScript9F805DSection


    .section Unsorted9F8065Section

      .al
      .xl

      rlProcUnknown9F805DCycle ; 9F/8065

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F5091
        beq _8084
        bmi _8081
        phx
        lda $7F5089
        asl a
        tax
        lda $8085,b,x
        sta lR18
        phk
        pea #<>_8080 - 1
        jmp (lR18)


        _8080
        plx

        _8081
        stz aProcSystem.aHeaderTypeOffset,b,x

        _8084
        rtl

        .databank 0

        ; 9F/8085

    .endsection Unsorted9F8065Section


    .section Unsorted9F8253Section

      .al
      .xl

      rsUnknown9F8253 ; 9F/8253

        ; TRACE: stack-args
        .al
        .xl
        .autsiz
        .databank ?

        phx
        tax
        lda #3,s
        tay
        lda $0001,b,y
        and #$00FF
        pha
        tya
        inc a
        sta #5,s
        txa
        and #$00FF
        lsr a
        lsr a
        lsr a
        cmp #$0010
        bcs _8270
        inc a

        _8270
        xba
        ora #1,s
        jsl rlPlaySoundEffect2
        pla
        plx
        rts

        .databank 0

        ; 9F/827A

    .endsection Unsorted9F8253Section


    .section Unsorted9F82A7Section

      .al
      .xl

      rsUnknown9F82A7 ; 9F/82A7

        .al
        .xl
        .autsiz
        .databank ?

        lda aMapAction.wUnknown7F4560
        tay
        lda $7F4BEB
        lsr a
        bcc _82B8
        lda aMapAction.wUnknown7F455E
        tay

        _82B8
        tya
        sta $7F50C9
        rts

        .databank 0

        ; 9F/82BE

    .endsection Unsorted9F82A7Section


    .section Unsorted9F82D7Section

      .al
      .xl

      rsUnknown9F82D7 ; 9F/82D7

        ; TRACE: stack-args
        .al
        .xl
        .autsiz
        .databank ?

        phk
        phk
        pla
        sta lR44+1
        lda #1,s
        tay
        lda $0001,b,y
        sta lR44
        tya
        clc
        adc #$0002
        sta #1,s
        jsl rlProcEngineCreateProc
        bcs _830E
        phx
        pha
        lda $7F50A1
        tax
        lda #1,s
        sta $7F50A5,x
        lda #$FFFF
        sta $7F50A7,x
        inc x
        inc x
        txa
        sta $7F50A1
        pla
        plx

        _830E
        rts

        .databank 0

        ; 9F/830F

      rsUnknown9F830F ; 9F/830F

        ; TRACE: stack-args
        .al
        .xl
        .autsiz
        .databank ?

        phk
        phk
        pla
        sta lR44+1
        lda #1,s
        tay
        lda $0001,b,y
        sta lR44
        tya
        clc
        adc #$0002
        sta #1,s
        jsl rlHDMAEngineCreateEntry
        bcs _8348
        phx
        lda $7F50A3
        tax
        lda aHDMASystem.wOffset,b
        sta $7F50B7,x
        lda #$FFFF
        sta $7F50B9,x
        inc x
        inc x
        txa
        sta $7F50A3
        plx
        lda aHDMASystem.wOffset,b

        _8348
        rts

        .databank 0

        ; 9F/8349

    .endsection Unsorted9F82D7Section


    .section Unsorted9F8349Section

      .al
      .xl

      rlUnknown9F8349 ; 9F/8349

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F5089
        bmi _8358
        jsr rsUnknown9F8359
        jsr rsUnknown9F8371
        jsr rsUnknown9F8389

        _8358
        rtl

        .databank 0

        ; 9F/8359

      rsUnknown9F8359 ; 9F/8359

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000
        bra _8366


        _835F
        lsr a
        jsl rlHDMAEngineFreeEntryByIndex
        inc x
        inc x

        _8366
        lda $7F50B7,x
        cmp #$FFFF
        bne _835F
        plx
        rts

        .databank 0

        ; 9F/8371

      rsUnknown9F8371 ; 9F/8371

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000
        bra _837E


        _8377
        lsr a
        jsl rlProcEngineFreeProcByIndex
        inc x
        inc x

        _837E
        lda $7F50A5,x
        cmp #$FFFF
        bne _8377
        plx
        rts

        .databank 0

        ; 9F/8389

      rsUnknown9F8389 ; 9F/8389

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F508F
        beq _8397
        sep #$20
        lda #$54
        sta bBufferBG2SC
        rep #$20

        _8397
        rts

        .databank 0

        ; 9F/8398

    .endsection Unsorted9F8349Section


    .section Unsorted9F83D0Section

      .al
      .xl

      rsUnknown9F83D0 ; 9F/83D0

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7F5090
        and #$0004
        tax
        lda $83E9,b,x
        sta $7F5095
        lda $83EB,b,x
        sta $7F5097
        plx
        rts

        .databank 0

        ; 9F/83E9

    .endsection Unsorted9F83D0Section


    .section Unsorted9F83F1Section

      .al
      .xl

      rsUnknown9F83F1 ; 9F/83F1

        .al
        .xl
        .autsiz
        .databank ?

        php
        sep #$20
        lda bBufferTM
        ora #$02
        sta bBufferTM
        lda #$0F
        sta bBufferWBGLOG
        lda #$01
        sta bBufferWOBJLOG
        lda #$11
        sta bBufferTS
        lda #$17
        sta bBufferTMW
        lda #$11
        sta bBufferTSW
        lda #$82
        sta bBufferCGADSUB
        plp
        rts

        .databank 0

        ; 9F/8414

    .endsection Unsorted9F83F1Section


    .section Unsorted9F8414Section

      .al
      .xl

      rsUnknown9F8414 ; 9F/8414

        .al
        .xl
        .autsiz
        .databank ?

        php
        sep #$20
        lda bBufferW12SEL
        sta $7F57F2
        lda bBufferW34SEL
        sta $7F57F3
        lda bBufferWOBJSEL
        sta $7F57F4
        lda bBufferWBGLOG
        sta $7F57F5
        lda bBufferWOBJLOG
        sta $7F57F6
        lda bBufferTM
        sta $7F57F7
        lda bBufferTS
        sta $7F57F8
        lda bBufferTMW
        sta $7F57F9
        lda bBufferTSW
        sta $7F57FA
        lda bBufferCGWSEL
        sta $7F57FB
        lda bBufferCGADSUB
        sta $7F57FC
        lda wBufferBG1HOFS
        sta $7F57FD
        lda wBufferBG1VOFS
        sta $7F57FE
        lda wBufferBG2HOFS
        sta $7F57FF
        lda wBufferBG2VOFS
        sta $7F5800
        plp
        rts

        .databank 0

        ; 9F/8473

      rlUnknown9F8473 ; 9F/8473

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F5089
        bpl _847A
        rtl


        _847A
        php
        sep #$20
        lda $7F57F2
        sta bBufferW12SEL
        lda $7F57F3
        sta bBufferW34SEL
        lda $7F57F4
        sta bBufferWOBJSEL
        lda $7F57F5
        sta bBufferWBGLOG
        lda $7F57F6
        sta bBufferWOBJLOG
        lda $7F57F7
        sta bBufferTM
        lda $7F57F8
        sta bBufferTS
        lda $7F57F9
        sta bBufferTMW
        lda $7F57FA
        sta bBufferTSW
        lda $7F57FB
        sta bBufferCGWSEL
        lda $7F57FC
        sta bBufferCGADSUB
        lda $7F57FD
        sta wBufferBG1HOFS
        lda $7F57FE
        sta wBufferBG1VOFS
        lda $7F57FF
        sta wBufferBG2HOFS
        lda $7F5800
        sta wBufferBG2VOFS
        lda #$54
        sta bBufferBG2SC
        plp
        rtl

        .databank 0

        ; 9F/84DD

      rlUnknown9F84DD ; 9F/84DD

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F5089
        bmi _850A
        phx
        phy
        sta wR0
        asl a
        asl a
        asl a
        clc
        adc wR0
        tax
        lda aMapBattleMagicBackgrounds,x
        sta lR18
        lda aMapBattleMagicBackgrounds+1,x
        sta lR18+1
        lda #(`aWorldMapMarkerPalette)<<8
        sta lR19+1
        lda #<>aWorldMapMarkerPalette
        sta lR19
        jsl rlAppendDecompList
        ply
        plx

        _850A
        rtl

        .databank 0

        ; 9F/850B

      rlUnknown9F850B ; 9F/850B

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F5089
        bmi _8574
        phx
        phy
        sta wR0
        cmp #$0004
        bne _8532
        lda $7F509B
        and #$00FF
        cmp #$00A0
        bmi _8532
        lda #(`acMapBattleMagicMeteorTilemap2)<<8
        sta lR18+1
        lda #<>acMapBattleMagicMeteorTilemap2
        sta lR18
        bra _8564


        _8532
        cmp #$0003
        bne _854F
        lda $7F509B
        and #$00FF
        cmp #$00C0
        bmi _854F
        lda #(`acMapBattleMagicValflameTilemap2)<<8
        sta lR18+1
        lda #<>acMapBattleMagicValflameTilemap2
        sta lR18
        bra _8564


        _854F
        lda wR0
        asl a
        asl a
        asl a
        clc
        adc wR0
        tax
        lda aMapBattleMagicBackgrounds+3,x
        sta lR18
        lda aMapBattleMagicBackgrounds+4,x
        sta lR18+1

        _8564
        lda #$7E00
        sta lR19+1
        lda #$DB88
        sta lR19
        jsl rlAppendDecompList
        ply
        plx

        _8574
        rtl

        .databank 0

        ; 9F/8575

      rlUnknown9F8575 ; 9F/8575

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F5089
        bmi _85A2
        phx
        phy
        sta wR0
        asl a
        asl a
        asl a
        clc
        adc wR0
        tax
        lda aMapBattleMagicBackgrounds+6,x
        sta lR18
        lda aMapBattleMagicBackgrounds+7,x
        sta lR18+1
        lda #$7E00
        sta lR19+1
        lda #$E388
        sta lR19
        jsl rlAppendDecompList
        ply
        plx

        _85A2
        rtl

        .databank 0

        ; 9F/85A3

      rlUnknown9F85A3 ; 9F/85A3

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F5089
        bmi _85CB
        phy
        phx
        lda #(`aWorldMapMarkerPalette)<<8
        sta lR18+1
        lda #<>aWorldMapMarkerPalette
        sta lR18
        lda #$0800
        sta wR0
        lda bBufferBG4SC
        and #$F000
        clc
        adc #$3800
        sta wR1
        jsl rlDMAByPointer
        plx
        ply

        _85CB
        rtl

        .databank 0

        ; 9F/85CC

      rlUnknown9F85CC ; 9F/85CC

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F5089
        bmi _85F4
        phy
        phx
        lda #$7E00
        sta lR18+1
        lda #$D388
        sta lR18
        lda #$0800
        sta wR0
        lda bBufferBG4SC
        and #$F000
        clc
        adc #$3C00
        sta wR1
        jsl rlDMAByPointer
        plx
        ply

        _85F4
        rtl

        .databank 0

        ; 9F/85F5

      rlUnknown9F85F5 ; 9F/85F5

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F5089
        bmi _861E
        phy
        phx
        lda #$7E00
        sta lR18+1
        lda #$DB88
        sta lR18
        lda #$0800
        sta wR0
        lda bBufferBG1SC
        and #$00FC
        xba
        clc
        adc #$0C00
        sta wR1
        jsl rlDMAByPointer
        plx
        ply

        _861E
        rtl

        .databank 0

        ; 9F/861F

      rlUnknown9F861F ; 9F/861F

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F5089
        bmi _8676
        phy
        phx
        lda #$7E00
        sta lR18+1
        sta lR19+1
        lda #$E388
        sta lR18
        clc
        adc #$0020
        sta lR19
        lda wBattleType
        and #$00FF
        cmp #$0003
        beq _8660
        ldy #$00D2
        ldx #$00D2

        _864B
        lda [lR18],y
        sta aBGPaletteBuffer,b,x
        lda [lR19],y
        sta aBGPaletteBuffer.aPalette1,b,x
        inc y
        inc y
        inc x
        inc x
        cpx #$00E0
        bne _864B
        bra _8674


        _8660
        ldy #$00D2
        ldx #$00D2

        _8666
        lda [lR18],y
        sta aBGPaletteBuffer,b,x
        inc y
        inc y
        inc x
        inc x
        cpx #$00E0
        bne _8666

        _8674
        plx
        ply

        _8676
        rtl

        .databank 0

        ; 9F/8677

      rlUnknown9F8677 ; 9F/8677

        .al
        .xl
        .autsiz
        .databank ?

        phb
        phy
        phx
        lda #$7F00
        sta lR18+1
        lda #$45D9
        sta lR18
        lda #$0400
        sta wR0
        lda $7F459E
        asl a
        tax
        lda aBattleRoundsData._Entry[0],x
        and #$0001
        and #$0001
        asl a
        tax
        lda bBufferOBSEL
        and #$0003
        asl a
        asl a
        asl a
        asl a
        asl a
        xba
        sta wR1
        jsl rlDMAByPointer
        plx
        ply
        plb
        .databank ?
        rtl

        .databank 0

        ; 9F/86B0

    .endsection Unsorted9F8414Section


    .section Unsorted9F86B0Section

      .al
      .xl

      rlUnknown9F86B0 ; 9F/86B0

        .al
        .autsiz
        .databank ?

        lda bDecompressionArrayFlag,b
        bne +

          lda aProcSystem.aHeaderBitfield,b,x
          ora #1
          sta aProcSystem.aHeaderBitfield,b,x

        +
        rtl

        .databank 0

        ; 9F/86BF

    .endsection Unsorted9F86B0Section


    .section Unsorted9F86BFSection

      .al
      .xl

      rlUnknown9F86BF ; 9F/86BF

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFD
        sta aProcSystem.aHeaderBitfield,b,x
        lda $7F5089
        bmi _8721
        asl a
        asl a
        adc $7F5089
        tax
        lda aMapBattleMagicSprites,x
        cmp #$FFFF
        beq _8721
        phk
        phk
        ply
        sty lR19+1
        sta lR19
        lda aMapBattleMagicSprites+2,x
        sta lR18
        lda aMapBattleMagicSprites+3,x
        sta lR18+1
        ldx #$01DE
        ldy #$001E

        _86F9
        lda [lR19],y
        sta aBGPaletteBuffer,b,x
        dec x
        dec x
        dec y
        dec y
        bpl _86F9
        lda #1,s
        tax
        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFE
        ora #$0002
        sta aProcSystem.aHeaderBitfield,b,x
        lda #$7F00
        sta lR19+1
        lda #$45D9
        sta lR19
        jsl rlAppendDecompList

        _8721
        plx
        ply
        rtl

        .databank 0

        ; 9F/8724

    .endsection Unsorted9F86BFSection


    .section Unsorted9F8900Section

      .al
      .xl

      rlUnknown9F8900 ; 9F/8900

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFD
        sta aProcSystem.aHeaderBitfield,b,x
        lda $7F508F
        beq _8942
        phx
        lda $7F508B
        sta $7F5089
        lda $7F459E
        asl a
        tax
        lda aBattleRoundsData._Entry[0],x
        and #$0001
        beq _892F
        lda $7F508D
        sta $7F5089

        _892F
        plx
        lda $7F5089
        cmp #$FFFF
        beq _8942
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0002
        sta aProcSystem.aHeaderBitfield,b,x

        _8942
        rtl

        .databank 0

        ; 9F/8943

    .endsection Unsorted9F8900Section


    .section Unsorted9F8943Section

      .al
      .xl

      rlUnknown9F8943 ; 9F/8943

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        php

        _8944
        ldy wDMAArrayPosition,b
        sep #$20
        lda #$02
        sta aDMAArray,b,y
        lda #$00
        sta $034F,b,y
        lda $0000,b,x
        sta $034C,b,y
        rep #$21
        lda $0001,b,x
        sta $0347,b,y
        lda $0002,b,x
        sta $0348,b,y
        lda $0004,b,x
        sta $034A,b,y
        lda $0006,b,x
        sta $034D,b,y
        tya
        adc #$0009
        sta wDMAArrayPosition,b
        txa
        clc
        adc #$0008
        tax
        lda $0000,b,x
        cmp #$FFFF
        bne _8944
        sep #$20
        lda #$01
        sta bDMAArrayFlag,b
        lda bBufferINIDISP
        bpl _8997
        jsl rlProcessDMAStructArray

        _8997
        plp
        rtl

        .databank 0

        ; 9F/8999

    .endsection Unsorted9F8943Section


    .section Unsorted9F8999Section

      .al
      .xl

      rlUnknown9F8999 ; 9F/8999

        .al
        .xl
        .autsiz
        .databank ?

        lda aActiveSpriteSystem.aUnknown0013C0,b,x
        sep #$20
        clc
        adc $11E1,b,x
        sta $11E1,b,x
        rep #$20
        and #$FF00
        xba
        bpl _89B0
        ora #$FF00

        _89B0
        adc aActiveSpriteSystem.aUnknown001200,b,x
        sta aActiveSpriteSystem.aUnknown001200,b,x
        lda aActiveSpriteSystem.aUnknown0013E0,b,x
        sep #$20
        clc
        adc $1221,b,x
        sta $1221,b,x
        rep #$20
        and #$FF00
        xba
        bpl _89CD
        ora #$FF00

        _89CD
        adc aActiveSpriteSystem.aUnknown001240,b,x
        sta aActiveSpriteSystem.aUnknown001240,b,x
        rtl

        .databank 0

        ; 9F/89D4

    .endsection Unsorted9F8999Section


    .section Unsorted9F8A34Section

      .as
      .xl

      rlUnknown9F8A34 ; 9F/8A34

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000
        lda wR0
        bpl _8A43
        ldx #$0004
        eor #$FFFF
        inc a

        _8A43
        sta wR0
        lda wR1
        bpl _8A4F
        inc x
        inc x
        eor #$FFFF
        inc a

        _8A4F
        sta wR1
        cmp wR0
        bpl _8A76
        sep #$20
        stz $4204,b
        lda wR1
        sta $4205,b
        lda wR0
        sta $4206,b
        nop
        nop
        nop
        rep #$20
        jsr (_8A6E,x)
        plx
        rtl

        _8A6E
        .word <>rsUnknown9F8A97
        .word <>rsUnknown9F8AA8
        .word <>rsUnknown9F8AB5
        .word <>rsUnknown9F8AC6

        _8A76
        sep #$20
        stz $4204,b
        lda wR0
        sta $4205,b
        lda wR1
        sta $4206,b
        nop
        nop
        nop
        rep #$20
        jsr (_8A8F,x)
        plx
        rtl

        _8A8F
        .word <>rsUnknown9F8ADA
        .word <>rsUnknown9F8AEB
        .word <>rsUnknown9F8AFF
        .word <>rsUnknown9F8B13

        .databank 0

        ; 9F/8A97

    .endsection Unsorted9F8A34Section


    .section Unsorted9F8A97Section

      .al
      .xl

      rsUnknown9F8A97 ; 9F/8A97

        .al
        .xl
        .autsiz
        .databank ?

        lda $4214,b
        lsr a
        lsr a
        lsr a
        eor #$FFFF
        inc a
        and #$00FF
        jml rsUnknown9F8B24

        .databank 0

        ; 9F/8AA8

      rsUnknown9F8AA8 ; 9F/8AA8

        .al
        .xl
        .autsiz
        .databank ?

        lda $4214,b
        lsr a
        lsr a
        lsr a
        and #$00FF
        jml rsUnknown9F8B24

        .databank 0

        ; 9F/8AB5

      rsUnknown9F8AB5 ; 9F/8AB5

        .al
        .xl
        .autsiz
        .databank ?

        lda $4214,b
        lsr a
        lsr a
        lsr a
        clc
        adc #$0080
        and #$00FF
        jml rsUnknown9F8B24

        .databank 0

        ; 9F/8AC6

      rsUnknown9F8AC6 ; 9F/8AC6

        .al
        .xl
        .autsiz
        .databank ?

        lda $4214,b
        lsr a
        lsr a
        lsr a
        eor #$FFFF
        sec
        adc #$0080
        and #$00FF
        jml rsUnknown9F8B24

        .databank 0

        ; 9F/8ADA

      rsUnknown9F8ADA ; 9F/8ADA

        .al
        .xl
        .autsiz
        .databank ?

        lda $4214,b
        lsr a
        lsr a
        lsr a
        clc
        adc #$00C0
        and #$00FF
        jml rsUnknown9F8B24

        .databank 0

        ; 9F/8AEB

      rsUnknown9F8AEB ; 9F/8AEB

        .al
        .xl
        .autsiz
        .databank ?

        lda $4214,b
        lsr a
        lsr a
        lsr a
        eor #$FFFF
        sec
        adc #$0040
        and #$00FF
        jml rsUnknown9F8B24

        .databank 0

        ; 9F/8AFF

      rsUnknown9F8AFF ; 9F/8AFF

        .al
        .xl
        .autsiz
        .databank ?

        lda $4214,b
        lsr a
        lsr a
        lsr a
        eor #$FFFF
        sec
        adc #$00C0
        and #$00FF
        jml rsUnknown9F8B24

        .databank 0

        ; 9F/8B13

      rsUnknown9F8B13 ; 9F/8B13

        .al
        .xl
        .autsiz
        .databank ?

        lda $4214,b
        lsr a
        lsr a
        lsr a
        clc
        adc #$0040
        and #$00FF
        jml rsUnknown9F8B24

        .databank 0

        ; 9F/8B24

      rsUnknown9F8B24 ; 9F/8B24

        .al
        .xl
        .autsiz
        .databank ?

        pha
        and #$003F
        tax
        lda $8B3A,b,x
        and #$00FF
        eor #$FFFF
        inc a
        clc
        adc #1,s
        sta #1,s
        pla
        rts

        .databank 0

        ; 9F/8B3A

    .endsection Unsorted9F8A97Section


    .section Unsorted9F8B7ASection

      .al
      .xl

      rlUnknown9F8B7A ; 9F/8B7A

        .al
        .xl
        .autsiz
        .databank ?

        sta wR10
        lda wR0
        clc
        adc #$0080
        bra _8B8C

        _8B84
        sta wR10
        lda wR0
        clc
        adc #$0040

        _8B8C
        asl a
        and #$01FE
        tax
        lda aUnknown9F8C3A,x
        sta wR14
        bpl _8B9D
        eor #$FFFF
        inc a

        _8B9D
        sta wR11
        jsr rsUnknown9F8BAD
        lda wR12+1
        bit wR14
        bpl _8BAC
        eor #$FFFF
        inc a

        _8BAC
        rtl

        .databank 0

        ; 9F/8BAD

      rsUnknown9F8BAD ; 9F/8BAD

        .al
        .xl
        .autsiz
        .databank ?

        rep #$20
        sep #$10
        ldx wR10
        stx $4202,b
        ldx wR11
        stx $4203,b
        xba
        nop
        lda $4216,b
        sta wR12
        ldx wR10+1
        stx $4202,b
        ldx wR11+1
        stx $4203,b
        xba
        nop
        ldx $4216,b
        stx wR13
        ldy $4217,b
        ldx wR10+1
        stx $4202,b
        ldx wR11
        stx $4203,b
        lda wR12+1
        clc
        adc $4216,b
        sta wR12+1
        bcc _8BEB
        inc y

        _8BEB
        ldx wR10
        stx $4202,b
        ldx wR11+1
        stx $4203,b
        lda wR12+1
        clc
        adc $4216,b
        sta wR12+1
        bcc _8C00
        inc y

        _8C00
        sty wR13+1
        rep #$10
        rts

        .databank 0

        ; 9F/8C05

      rlUnknown9F8C05 ; 9F/8C05

        .al
        .xl
        .autsiz
        .databank ?

        sta wR1
        lda wR0
        clc
        adc #$0080
        bra _8C17

        .byte $85, $02, $A5, $00, $18, $69, $40, $00


        _8C17
        phx
        asl a
        and #$01FE
        tax
        lda aUnknown9F8C3A,x
        sep #$20
        sta @l M7A
        xba
        sta @l M7A
        lda wR1
        sta @l M7B
        rep #$20
        lda @l $002135
        plx
        rtl

        .databank 0

        ; 9F/8C3A

    .endsection Unsorted9F8B7ASection


    .section Unsorted9F8EC0Section

      .al
      .xl

      rlUnknown9F8EC0 ; 9F/8EC0

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        sta wR2

        _8EC2
        lda aPaletteFading.wDesiredColor,b
        cmp aBGPaletteBuffer,b,x
        beq _8EDA
        phx
        lda aBGPaletteBuffer,b,x
        tax
        lda aPaletteFading.wCurrentStep,b
        jsl rlUnknown9F9090
        plx
        sta aBGPaletteBuffer,b,x

        _8EDA
        inc x
        inc x
        dec wR2
        bne _8EC2
        rtl

        .databank 0

        ; 9F/8EE1

    .endsection Unsorted9F8EC0Section


    .section Unsorted9F9090Section

      .as
      .xl

      rlUnknown9F9090 ; 9F/9090

        ; TRACE: stack-args
        .al
        .xl
        .autsiz
        .databank ?

        pha
        pha
        phx
        phy
        lda #1,s
        and #$001F
        tay
        lda #3,s
        and #$001F
        tax
        jsr rsUnknown9F90E6
        sta #7,s
        lda #1,s
        asl a
        asl a
        asl a
        xba
        and #$001F
        tay
        lda #3,s
        asl a
        asl a
        asl a
        xba
        and #$001F
        tax
        jsr rsUnknown9F90E6
        asl a
        asl a
        asl a
        asl a
        asl a
        ora #7,s
        sta #7,s
        lda #1,s
        lsr a
        lsr a
        xba
        and #$001F
        tay
        lda #3,s
        lsr a
        lsr a
        xba
        and #$001F
        tax
        jsr rsUnknown9F90E6
        asl a
        asl a
        xba
        ora #7,s
        sta #7,s
        ply
        plx
        pla
        pla
        rtl

        .databank 0

        ; 9F/90E6

      rsUnknown9F90E6 ; 9F/90E6

        .al
        .xl
        .autsiz
        .databank ?

        phy
        txa
        sec
        sbc #1,s
        bpl _90F0
        lda #$0000

        _90F0
        ply
        rts

        .databank 0

        ; 9F/90F2

    .endsection Unsorted9F9090Section


    .section Unsorted9F90F2Section

      .al
      .xl

      rlUnknown9F90F2 ; 9F/90F2

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9F9116
        rtl

        .databank 0

        ; 9F/90F6

      rlUnknown9F90F6 ; 9F/90F6

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9F9116._912A+117
        rtl

        .databank 0

        ; 9F/90FA

      rlUnknown9F90FA ; 9F/90FA

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9F910A
        rtl

        .databank 0

        ; 9F/90FE

    .endsection Unsorted9F90F2Section


    .section Unsorted9F910ASection

      .al
      .xl

      rsUnknown9F910A ; 9F/910A

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlSavePaletteBufferColorsToRAM

          .byte $00, $D0, $7E, $50, $00, $20, $00

        rts

        .databank 0

        ; 9F/9116

      rsUnknown9F9116 ; 9F/9116

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        ldy #$0010
        bra _912A

        .byte $8D, $43, $1B, $98, $8D, $41, $1B, $18, $5C, $FB, $91, $9F


        _912A
        sta aPaletteFading.wDesiredColor,b
        tya
        sta aPaletteFading,b
        sec
        jml _91B1

        .byte $A9, $07, $00, $A0, $0E, $00, $8D, $43, $1B, $98, $8D, $41, $1B, $18, $5C, $CE
        .byte $91, $9F, $A9, $07, $00, $A0, $14, $00, $8D, $43, $1B, $98, $8D, $41, $1B, $18
        .byte $5C, $DD, $91, $9F, $A9, $07, $00, $A0, $0E, $00, $8D, $43, $1B, $98, $8D, $41
        .byte $1B, $18, $5C, $EC, $91, $9F, $A9, $FF, $7F, $8D, $43, $1B, $A9, $10, $00, $8D
        .byte $41, $1B, $18, $5C, $B1, $91, $9F, $A9, $FF, $7F, $8D, $43, $1B, $A9, $10, $00
        .byte $8D, $41, $1B, $18, $5C, $0A, $92, $9F, $A9, $00, $00, $8D, $43, $1B, $A9, $10
        .byte $00, $8D, $41, $1B, $18, $5C, $0A, $92, $9F, $A9, $08, $00, $8D, $41, $1B, $18
        .byte $22, $E1, $8E, $9F, $00, $D0, $50, $00, $20, $00, $60


        _91B1
        jsl rlFadePaletteToBlack

          .byte $B8, $91

        rts

        .databank 0

        ; 9F/91B8

    .endsection Unsorted9F910ASection


    .section Unsorted9F9217Section

      .al
      .xl

      rlUnknown9F9217 ; 9F/9217

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phb
        phk
        plb
        .databank $9F
        phy
        jsr rsUnknown9F82A7
        jsr rsUnknown9F8414
        jsr rsUnknown9F83D0
        lda #$0000
        sta $7F50A1
        sta $7F50A3
        lda #$FFFF
        sta $7F50A5
        sta $7F50B7
        lda #(`procUnknown9F924B)<<8
        sta lR44+1
        lda #<>procUnknown9F924B
        sta lR44
        jsl rlProcEngineCreateProc
        ply
        plb
        .databank ?
        rtl

        .databank 0

        ; 9F/924B

    .endsection Unsorted9F9217Section


    .section Unsorted9F924BSection

      .al
      .xl

      procUnknown9F924B ; 9F/924B

        .structProcInfo "ON", rlUnknown9F92D2, rlUnknown9F9253, aProcUnknown9F805DCode

    .endsection Unsorted9F924BSection


    .section Unsorted9F9253Section

      .al
      .xl

      rlUnknown9F9253 ; 9F/9253

        .al
        .xl
        .autsiz
        .databank ?

        jsr rlUnknown9F9341
        lda #$0020
        sta aProcSystem.aBody4,b,x
        lda #<>rlUnknown9F926E
        sta aProcSystem.aHeaderOnCycle,b,x
        lda $7F509B
        and #$00FF
        jsr rsUnknown9F8253

          .byte $4C

        rtl

        .databank 0

        ; 9F/926E

    .endsection Unsorted9F9253Section


    .section Unsorted9F926ESection

      .al
      .xl

      rlUnknown9F926E ; 9F/926E

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aBody4,b,x
        dec a
        sta aProcSystem.aBody4,b,x
        bne _927D
        lda #<>rlUnknown9F927E
        sta aProcSystem.aHeaderOnCycle,b,x

        _927D
        rtl

        .databank 0

        ; 9F/927E

      rlUnknown9F927E ; 9F/927E

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown9F9691
        bcc _9295
        lda #$9295
        sta aProcSystem.aHeaderOnCycle,b,x
        stz aProcSystem.aHeaderTypeOffset,b,x
        jsl rlUnknown9F8349
        jsl rlUnknown9F8473._847A

        _9295
        rtl

        .databank 0

        ; 9F/9296

      rlUnknown9F9296 ; 9F/9296

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$9F00
        sta lR44+1
        lda #$936C
        sta lR44
        jsl rlActiveSpriteEngineCreateSpriteHighestSlot
        plx
        jsr rsUnknown9F82D7

          .word $92C2

        rtl

        .databank 0

        ; 9F/92AC

    .endsection Unsorted9F926ESection


    .section Unsorted9F92D2Section

      .al
      .xl

      rlUnknown9F92D2 ; 9F/92D2

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9F83F1
        lda #$0000
        sta $7ECC06
        sta $7ECC08
        sta $7ECC0A
        sta $7ECC0C
        stz aProcSystem.aBody2,b,x
        stz aProcSystem.aBody3,b,x
        jsl rlUnknown9F9691
        rtl

        .databank 0

        ; 9F/92F3

    .endsection Unsorted9F92D2Section


    .section Unsorted9F92F3Section

      .al
      .xl

      rlUnknown9F92F3 ; 9F/92F3

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda $7ECC06
        bne _92FA
        rtl


        _92FA
        lda #$932D
        sta aProcSystem.aHeaderOnCycle,b,x
        bra _932D

        .byte $AF, $06, $CC, $7E, $D0, $01, $6B, $20, $4D, $93, $A9, $13, $93, $9D, $57, $0F
        .byte $6B, $AF, $08, $CC, $7E, $F0, $F9, $22, $91, $96, $9F, $90, $F3, $A9, $01, $00
        .byte $8F, $93, $50, $7F, $A9, $2C, $93, $9D, $57, $0F, $6B


        _932D
        lda $7ECC08
        beq _9340
        lda #$0001
        sta $7F5093
        lda #$9340
        sta aProcSystem.aHeaderOnCycle,b,x

        _9340
        rtl

        .databank 0

        ; 9F/9341

    .endsection Unsorted9F92F3Section


    .section Unsorted9F9341Section

      .al
      .xl

      rlUnknown9F9341 ; 9F/9341

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9F82D7

          .word $EBAB

        jsr rsUnknown9F830F

          .word $DE4E

        bra _9357

        .byte $20, $D7, $82, $BA, $EB, $20, $0F, $83, $5E, $DE


        _9357
        jsr rsUnknown9F830F

          .word $DBB8

        jsr rsUnknown9F830F

          .word $DBF1

        jsr rsUnknown9F830F

          .word $DB6C

        jsr rsUnknown9F830F

          .word $DB7F

        rts

        .databank 0

        ; 9F/936C

    .endsection Unsorted9F9341Section


    .section Unsorted9F9378Section

      .al
      .xl

      rlUnknown9F9378 ; 9F/9378

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 9F/9379

      rsUnknown9F9379 ; 9F/9379

        .al
        .xl
        .autsiz
        .databank ?

        lda aActiveSpriteSystem.aUnknown0012E0,b,x
        sta wR0
        lda aActiveSpriteSystem.aUnknown001300,b,x
        jsl rlUnknown9F8B7A._8B84
        ldx aActiveSpriteSystem.wOffset,b
        sta aActiveSpriteSystem.aUnknown0013C0,b,x
        lda aActiveSpriteSystem.aUnknown0012E0,b,x
        sta wR0
        lda aActiveSpriteSystem.aUnknown001300,b,x
        jsl rlUnknown9F8B7A
        ldx aActiveSpriteSystem.wOffset,b
        sta aActiveSpriteSystem.aUnknown0013E0,b,x
        rts

        .databank 0

        ; 9F/939E

      rlUnknown9F939E ; 9F/939E

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F509F
        sta aActiveSpriteSystem.aUnknown001260,b,x
        lda $7F5099
        and #$00FF
        sta aActiveSpriteSystem.aUnknown001200,b,x
        lda $7F509A
        and #$00FF
        sec
        sbc #$000C
        and #$01FF
        sta aActiveSpriteSystem.aUnknown001240,b,x
        lda #$FF40
        sta aActiveSpriteSystem.aUnknown0013E0,b,x
        lda #$0000
        sta aActiveSpriteSystem.aUnknown0013C0,b,x
        ldy #$0004
        lda $7F5089
        cmp #$0000
        beq _93DB
        ldy #$000C

        _93DB
        tya
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        rtl

        .databank 0

        ; 9F/93E0

      rlUnknown9F93E0 ; 9F/93E0

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda aActiveSpriteSystem.aUnknown0013E0,b,x
        sec
        sbc #$0050
        sta aActiveSpriteSystem.aUnknown0013E0,b,x
        jsl rlUnknown9F8999
        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne _9405
        lda #$0001
        sta aActiveSpriteSystem.aUnknown0013A0,b,x
        lda #$000E
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        lda #<>rlUnknown9F9406
        sta aActiveSpriteSystem.aOnCycle,b,x

        _9405
        rtl

        .databank 0

        ; 9F/9406

      rlUnknown9F9406 ; 9F/9406

        .al
        .xl
        .autsiz
        .databank ?

        lda aActiveSpriteSystem.aUnknown0013E0,b,x
        clc
        adc #$0080
        bmi _9412
        lda #$0000

        _9412
        sta aActiveSpriteSystem.aUnknown0013E0,b,x
        jsl rlUnknown9F8999
        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne _944E
        lda $7F509B
        and #$00FF
        sec
        sbc aActiveSpriteSystem.aUnknown001200,b,x
        sta wR0
        lda $7F509C
        and #$00FF
        sec
        sbc aActiveSpriteSystem.aUnknown001240,b,x
        sta wR1
        jsl rlUnknown9F8A34
        sta aActiveSpriteSystem.aUnknown0012E0,b,x
        lda #$0100
        sta aActiveSpriteSystem.aUnknown001300,b,x
        jsr rsUnknown9F9379
        lda #<>rlUnknown9F944F
        sta aActiveSpriteSystem.aOnCycle,b,x

        _944E
        rtl

        .databank 0

        ; 9F/944F

      rlUnknown9F944F ; 9F/944F

        .al
        .xl
        .autsiz
        .databank ?

        lda aActiveSpriteSystem.aUnknown001300,b,x
        clc
        adc #$0040
        sta aActiveSpriteSystem.aUnknown001300,b,x
        jsr rsUnknown9F9379
        jsl rlUnknown9F8999
        lda $7F509B
        and #$00FF
        sta wR0
        lda $7F509C
        and #$00FF
        sta wR1
        lda aActiveSpriteSystem.aUnknown001240,b,x
        cmp wR1
        bmi _94D4
        lda $7F5089
        cmp #$0000
        bne _94AA
        lda #$0001
        sta $7ECC06
        lda #$000D
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        lda #<>rlUnknown9F94FE
        sta aActiveSpriteSystem.aOnCycle,b,x
        lda $7F509B
        and #$00FF
        sta aActiveSpriteSystem.aUnknown001200,b,x
        lda $7F509C
        and #$00FF
        sta aActiveSpriteSystem.aUnknown001240,b,x
        rtl


        _94AA
        lda #$002D
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        lda #$94D5
        sta aActiveSpriteSystem.aOnCycle,b,x
        sta $7ECC06
        lda #$0002
        sta aActiveSpriteSystem.aUnknown0013A0,b,x
        lda $7F509B
        and #$00FF
        sta aActiveSpriteSystem.aUnknown001200,b,x
        lda $7F509C
        and #$00FF
        sta aActiveSpriteSystem.aUnknown001240,b,x

        _94D4
        rtl

        .databank 0

        ; 9F/94D5

    .endsection Unsorted9F9378Section


    .section Unsorted9F94FESection

      .al
      .xl

      rlUnknown9F94FE ; 9F/94FE

        .al
        .xl
        .autsiz
        .databank ?

        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne _9526
        lda #$0001
        sta $7F4580
        lda #$9517
        sta aActiveSpriteSystem.aOnCycle,b,x
        lda #$0020
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        rtl

        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne _9526
        stz aActiveSpriteSystem.aTypeOffset,b,x
        lda #$0001
        sta $7ECC08

        _9526
        rtl

        .databank 0

        ; 9F/9527

    .endsection Unsorted9F94FESection


    .section Unsorted9F9570Section

      .al
      .xl

      rlUnknown9F9570 ; 9F/9570

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        phy
        lda aActiveSpriteSystem.aUnknown001200,b,x
        jsr rsUnknown9F8253

          .byte $51

        ply
        rtl

        .databank 0

        ; 9F/957A

    .endsection Unsorted9F9570Section


    .section Unsorted9F95E1Section

      .al
      .xl

      rlUnknown9F95E1 ; 9F/95E1

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda aActiveSpriteSystem.aUnknown0013A0,b,x
        cmp #$0001
        bne _95EC
        inc y
        inc y
        rtl


        _95EC
        lda $0000,b,y
        tay
        rtl

        .databank 0

        ; 9F/95F1

      rlUnknown9F95F1 ; 9F/95F1

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda aActiveSpriteSystem.aUnknown0013A0,b,x
        cmp #$0002
        bne _95FC
        inc y
        inc y
        rtl


        _95FC
        lda $0000,b,y
        tay
        rtl

        .databank 0

        ; 9F/9601

    .endsection Unsorted9F95E1Section


    .section Unsorted9F9691Section

      .al
      .xl

      rlUnknown9F9691 ; 9F/9691

        .al
        .xl
        .autsiz
        .databank ?

        ldy aProcSystem.aBody3,b,x
        lda $96D5,b,y
        cmp #$FFFF
        beq _96D3
        phx
        tya
        clc
        adc #$000E
        sta aProcSystem.aBody3,b,x
        tyx
        lda $96D5,b,x
        sta $01D2,b
        lda $96D7,b,x
        sta $01D4,b
        lda $96D9,b,x
        sta $01D6,b
        lda $96DB,b,x
        sta $01D8,b
        lda $96DD,b,x
        sta $01DA,b
        lda $96DF,b,x
        sta $01DC,b
        lda $96E1,b,x
        sta $01DE,b
        plx
        clc
        rtl


        _96D3
        sec
        rtl

        .databank 0

        ; 9F/96D5

    .endsection Unsorted9F9691Section


    .section Unsorted9F9954Section

      .al
      .xl

      rlUnknown9F9954 ; 9F/9954

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda $7F509B
        and #$00FF
        jsr rsUnknown9F8253

          .byte $71

        jsr rsUnknown9F82D7

          .word $99BB

        rtl

        .databank 0

        ; 9F/9965

    .endsection Unsorted9F9954Section


    .section Unsorted9F9976Section

      .al
      .xl

      rlUnknown9F9976 ; 9F/9976

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda $7F509B
        and #$00FF
        jsr rsUnknown9F8253

          .byte $73

        jsr rsUnknown9F82D7

          .word $99BB

        rtl

        .databank 0

        ; 9F/9987

    .endsection Unsorted9F9976Section


    .section Unsorted9F999ESection

      .al
      .xl

      rsUnknown9F999E ; 9F/999E

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9F83F1
        jsr rsUnknown9F830F

          .word $DBB8

        jsr rsUnknown9F830F

          .word $DC34

        jsr rsUnknown9F830F

          .word $DB6C

        jsr rsUnknown9F830F

          .word $DB7F

        jsr rsUnknown9F830F

          .word $DC77

        rts

        .databank 0

        ; 9F/99BB

    .endsection Unsorted9F999ESection


    .section Unsorted9F99CESection

      .al
      .xl

      rlUnknown9F99CE ; 9F/99CE

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9F82D7

          .word $EBD8

        sta aProcSystem.aBody7,b,x
        jsr rsUnknown9F999E
        lda #$0001
        sta aProcSystem.aBody0,b,x
        stz aProcSystem.aBody2,b,x
        stz aProcSystem.aBody3,b,x
        rtl

        .databank 0

        ; 9F/99E6

      rlUnknown9F99E6 ; 9F/99E6

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        dec aProcSystem.aBody0,b,x
        bne _99FE
        lda #$0001
        sta $7F4580
        lda #<>rlUnknown9F99FF
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0040
        sta aProcSystem.aBody0,b,x

        _99FE
        rtl

        .databank 0

        ; 9F/99FF

      rlUnknown9F99FF ; 9F/99FF

        .al
        .xl
        .autsiz
        .databank ?

        dec aProcSystem.aBody0,b,x
        bne _9A1D
        ldy aProcSystem.aBody7,b,x
        lda aProcSystem.aBody4,b,y
        eor #$FFFF
        inc a
        sta aProcSystem.aBody4,b,y
        lda #<>rlUnknown9F9A1E
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$000C
        sta aProcSystem.aBody0,b,x

        _9A1D
        rtl

        .databank 0

        ; 9F/9A1E

      rlUnknown9F9A1E ; 9F/9A1E

        .al
        .xl
        .autsiz
        .databank ?

        dec aProcSystem.aBody0,b,x
        bne _9A2A
        lda #$0001
        sta $7F5093

        _9A2A
        rtl

        .databank 0

        ; 9F/9A2B

    .endsection Unsorted9F99CESection


    .section Unsorted9F9ABFSection

      .al
      .xl

      rlUnknown9F9ABF ; 9F/9ABF

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aBody2,b,x
        beq _9AC9
        dec a
        sta aProcSystem.aBody2,b,x
        rtl


        _9AC9
        lda #$0003
        sta aProcSystem.aBody2,b,x
        phx
        lda aProcSystem.aBody3,b,x
        inc a
        and #$001F
        sta aProcSystem.aBody3,b,x
        asl a
        tax
        lda $9B08,b,x
        sta $01D2,b
        lda $9B0A,b,x
        sta $01D4,b
        lda $9B0C,b,x
        sta $01D6,b
        lda $9B0E,b,x
        sta $01D8,b
        lda $9B10,b,x
        sta $01DA,b
        lda $9B12,b,x
        sta $01DC,b
        lda $9B14,b,x
        sta $01DE,b
        plx
        rtl

        .databank 0

        ; 9F/9B08

    .endsection Unsorted9F9ABFSection


    .section Unsorted9FBD6BSection

      .al
      .xl

      rlUnknown9FBD6B ; 9F/BD6B

        .al
        .xl
        .autsiz
        .databank ?

        bra _BDB2

        .byte $7F, $A9, $7B, $BD, $9D, $57, $0F, $A9, $50, $00, $9D, $D7, $0F, $6B, $22, $B2
        .byte $BE, $9F, $AF, $06, $CC, $7E, $F0, $19, $BC, $B7, $10, $B9, $57, $10, $49, $FF
        .byte $FF, $1A, $99, $57, $10, $A9, $9F, $BD, $9D, $57, $0F, $A9, $0C, $00, $9D, $D7
        .byte $0F, $6B, $DE, $D7, $0F, $D0, $09, $A9, $AE, $BD, $9D, $57, $0F, $20, $59, $83
        .byte $6B, $20, $9F, $91, $90


        _BDB2
        ora $C0A9,b
        lda $579D,b,x
        ora @l $0001A9
        sta $7F5093
        rtl

        .databank 0

        ; 9F/BDC1

    .endsection Unsorted9FBD6BSection


    .section Unsorted9FDB68Section

      .al
      .xl

      rlUnknown9FDB68 ; 9F/DB68

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 9F/DB69

      rlUnknown9FDB69 ; 9F/DB69

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 9F/DB6A

    .endsection Unsorted9FDB68Section


    .section Unsorted9FDB8BSection

      .al
      .xl

      rlUnknown9FDB8B ; 9F/DB8B

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        ldy #$DBB3
        lda $7F508F
        bmi _DB9C
        and #$0400
        beq _DBA0
        ldy #$DBAA

        _DB9C
        tya
        sta aHDMASystem.aOffset,b,x

        _DBA0
        rtl

        .databank 0

        ; 9F/DBA1

    .endsection Unsorted9FDB8BSection


    .section Unsorted9FDBC4Section

      .al
      .xl

      rlUnknown9FDBC4 ; 9F/DBC4

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        ldy #$DBEC
        lda $7F508F
        bmi _DBD5
        and #$0400
        beq _DBD9
        ldy #$DBE3

        _DBD5
        tya
        sta aHDMASystem.aOffset,b,x

        _DBD9
        rtl

        .databank 0

        ; 9F/DBDA

    .endsection Unsorted9FDBC4Section


    .section Unsorted9FDBFDSection

      .al
      .xl

      rlUnknown9FDBFD ; 9F/DBFD

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        ldy #$DC2D
        lda $7F508F
        bmi _DC0E
        and #$0400
        beq _DC12
        ldy #$DC20

        _DC0E
        tya
        sta aHDMASystem.aOffset,b,x

        _DC12
        rtl

        .databank 0

        ; 9F/DC13

    .endsection Unsorted9FDBFDSection


    .section Unsorted9FDC40Section

      .al
      .xl

      rlUnknown9FDC40 ; 9F/DC40

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        ldy #$DC70
        lda $7F508F
        bmi _DC51
        and #$0400
        beq _DC55
        ldy #$DC63

        _DC51
        tya
        sta aHDMASystem.aOffset,b,x

        _DC55
        rtl

        .databank 0

        ; 9F/DC56

    .endsection Unsorted9FDC40Section


    .section Unsorted9FDC83Section

      .al
      .xl

      rlUnknown9FDC83 ; 9F/DC83

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda $7F57FF
        sta $7F50D1
        lda $7F5800
        clc
        adc #$FFFF
        sta $7F50D3
        lda $7F509B
        and #$00FF
        sec
        sbc #$0080
        eor #$FFFF
        inc a
        sta $7F50CD
        lda $7F509C
        and #$00FF
        sec
        sbc #$0070
        eor #$FFFF
        inc a
        sta $7F50CF
        ldy #$DCED
        lda $7F508F
        bmi _DCCE
        and #$0400
        beq _DCD2
        ldy #$DCE0

        _DCCE
        tya
        sta aHDMASystem.aOffset,b,x

        _DCD2
        rtl

        .databank 0

        ; 9F/DCD3

    .endsection Unsorted9FDC83Section


    .section Unsorted9FDEE3Section

      .al
      .xl

      rlUnknown9FDEE3 ; 9F/DEE3

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        ldy aHDMASystem.aTypeOffset,b,x
        lda $000C,b,y
        sta $7F50D5
        lda $000E,b,y
        sta $7F50D7
        lda #$0000
        sta $7F50DD
        lda #$0078
        sta $7F50D9
        lda #$0000
        sta $7F50DB
        lda $7F57FF
        sta $7F50D1
        lda $7F5800
        clc
        adc #$FFFF
        sta $7F50D3
        lda $7F508F
        and #$0400
        beq _DF2C
        lda #$DF65
        sta aHDMASystem.aOffset,b,x

        _DF2C
        lda $7F50CD
        sta wR0
        lda $7F50CF
        sta wR1
        phb
        pea #$7F7F
        plb
        .databank ?
        plb
        .databank ?
        ldx #$0000

        _DF41
        lda wR0
        sta $546A,b,x
        lda wR1
        sta $546C,b,x
        txa
        clc
        adc #$0004
        tax
        cpx #$0380
        bne _DF41
        plb
        .databank ?
        rtl

        .databank 0

        ; 9F/DF58

    .endsection Unsorted9FDEE3Section


    .section Unsorted9FE006Section

      .al
      .xl

      rlUnknown9FE006 ; 9F/E006

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0003
        sta wR6
        lda #$000A
        sta wR7
        lda #$002C
        sta wR8
        bra _E026

        .byte $A9, $03, $00, $85, $0C, $A9, $0A, $00, $85, $0E, $A9, $30, $00, $85, $10


        _E026
        txy
        phb
        pea #$7F7F
        plb
        .databank ?
        plb
        .databank ?
        lda $50D9,b
        clc
        adc $50D5,b
        sta $50D9,b
        xba
        bpl _E03F
        ora #$FF00
        bra _E042


        _E03F
        and #$00FF

        _E042
        sta wR2
        lda $50DB,b
        clc
        adc $50D7,b
        sta $50DB,b
        xba
        bpl _E056
        ora #$FF00
        bra _E059


        _E056
        and #$00FF

        _E059
        sta wR3
        lda $50DD,b
        clc
        adc wR8
        and #$00FF
        sta $50DD,b
        sta wR0
        lda $50CD,b
        sta wR4
        lda $50CF,b
        sta wR5
        ldy #$0000

        _E076
        lda wR6
        jsl rlUnknown9F8C05
        clc
        adc wR2
        clc
        adc wR4
        and #$01FF
        sta $546A,b,y
        lda wR5
        clc
        adc wR3
        and #$01FF
        sta $546C,b,y
        lda wR0
        clc
        adc wR7
        and #$00FF
        sta wR0
        tya
        clc
        adc #$0004
        tay
        cpy #$0380
        bne _E076
        plb
        .databank ?
        rtl

        .databank 0

        ; 9F/E0AA

    .endsection Unsorted9FE006Section


    .section Unsorted9FE824Section

      .al
      .xl

      rlUnknown9FE824 ; 9F/E824

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$00E0
        sta @l wR0
        lda lR18+1
        and #$01FF
        sta $2182,b
        lda lR18
        sta $2181,b
        lda $7F50DF
        and #$00FF
        sta wR1
        lda $7F50E1
        sta wR2
        lda $7F50E3
        and #$00FF
        sta wR3
        lda $7F50E5
        sta wR4
        jsr rsUnknown9FEB4F
        ldy #$0000
        lda wR3
        lsr a
        sta wR9
        lda wR2
        sec
        sbc wR9
        beq _E899
        bcc _E885
        tax
        sep #$20

        _E86E
        lda #$FF
        sta $2180,b
        lda #$00
        sta $2180,b
        dec wR0
        bne _E880
        jml _E8DA


        _E880
        dec x
        bne _E86E
        bra _E899


        _E885
        .al
        rep #$20
        eor #$FFFF
        inc a
        and #$00FF
        asl a
        pha
        lda wR4
        sec
        sbc #1,s
        sta wR4
        pla
        tay

        _E899
        sep #$20

        _E89B
        jsr rsUnknown9FEB2A
        dec wR0
        beq _E8DA
        inc y
        inc y
        cpy wR3
        bcs _E8B2
        rep #$20
        dec wR4
        beq _E8B2
        sep #$20
        bra _E89B


        _E8B2
        dec y
        dec y
        cpy #$0000
        bmi _E8CA
        jsr rsUnknown9FEB2A
        dec wR0
        beq _E8DA
        rep #$20
        dec wR4
        beq _E8CA
        sep #$20
        bra _E8B2


        _E8CA
        sep #$20

        _E8CC
        lda #$FF
        sta $2180,b
        lda #$00
        sta $2180,b
        dec wR0
        bne _E8CC

        _E8DA
        rep #$20
        plx
        rtl

        .databank 0

        ; 9F/E8DE

      rlUnknown9FE8DE ; 9F/E8DE

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        sta wR0
        tya
        sta wR5
        lda $7F50DF,x
        and #$00FF
        sta wR1
        lda $7F50E1,x
        sta wR2
        lda $7F50E3,x
        sta wR3
        lda $7F50E5,x
        sta wR4
        phd
        pea #$0000
        pld
        lda lR18+1
        and #$01FF
        sta $2182,b
        lda lR18
        sta $2181,b
        lda $7F50DF,x
        and #$00FF
        sta wR1
        lda $7F50E1,x
        sec
        sbc #$0010
        sta wR2
        lda $7F50E3,x
        and #$00FF
        sta wR3
        lda $7F50E5,x
        sta wR4
        lda wR3
        jsr rsUnknown9FEA0C
        pha
        sep #$20
        lda wR1
        clc
        adc #1,s
        bcs _E946
        cmp #$F7
        bcc _E948

        _E946
        lda #$F7

        _E948
        xba
        lda wR1
        sec
        sbc #1,s
        bcc _E954
        cmp #$08
        bcs _E956

        _E954
        lda #$08

        _E956
        rep #$20
        sta wR5
        pla
        jsr rsUnknown9FEB4F
        ldy #$0000
        sep #$20
        lda wR2
        sec
        sbc wR3
        beq _E9A7
        bcc _E993
        cmp #$DF
        bcc _E974
        jml _E9F7


        _E974
        rep #$20
        and #$00FF
        tax
        sep #$20

        _E97C
        lda wR5
        sta $2180,b
        lda wR5+1
        sta $2180,b
        dec wR0
        bne _E98E
        jml _EA07


        _E98E
        dec x
        bne _E97C
        bra _E9A7


        _E993
        rep #$20
        eor #$FFFF
        inc a
        and #$00FF
        pha
        lda wR4
        sec
        sbc #1,s
        sta wR4
        ply
        sep #$20

        _E9A7
        lda wR5
        sta $2180,b
        lda wR5+1
        sta $2180,b
        dec wR0
        beq _EA07
        inc y
        cpy wR3
        bcs _E9C4
        rep #$20
        dec wR4
        beq _E9DB
        sep #$20
        bra _E9A7


        _E9C4
        dec y
        cpy #$0000
        bmi _E9F7
        jsr rsUnknown9FEB2A
        dec wR0
        beq _EA07
        rep #$20
        dec wR4
        beq _E9DB
        sep #$20
        bra _E9C4


        _E9DB
        .al
        and #$00FF
        sta wR3
        tay
        jsr rsUnknown9FEB4F
        sep #$20

        _E9E6
        dec y
        dec y
        dec y
        cpy #$0000
        bmi _E9F7
        jsr rsUnknown9FEB2A
        dec wR0
        beq _EA07
        bra _E9E6


        _E9F7
        lda #$80
        sta $2180,b
        lda #$7F
        sta $2180,b
        dec wR0
        beq _EA07
        bra _E9F7


        _EA07
        rep #$20
        pld
        plx
        rtl

        .databank 0

        ; 9F/EA0C

    .endsection Unsorted9FE824Section


    .section Unsorted9FEA0CSection

      .al
      .xl

      rsUnknown9FEA0C ; 9F/EA0C

        .al
        .xl
        .autsiz
        .databank ?

        phx
        pha
        bit #$0080
        beq _EA1E
        and #$FF78
        lsr a
        lsr a
        clc
        adc #$0080
        bra _EA3C


        _EA1E
        bit #$0040
        beq _EA2D
        and #$FFBC
        lsr a
        clc
        adc #$0060
        bra _EA3C


        _EA2D
        bit #$0020
        beq _EA3B
        and #$FFDE
        clc
        adc #$0040
        bra _EA3C


        _EA3B
        asl a

        _EA3C
        tax
        lda $9AA30A,x
        clc
        adc #1,s
        dec a
        tax
        lda $9AA30A,x
        and #$00FF
        sta #1,s
        pla
        plx
        rts

        .databank 0

        ; 9F/EA52

    .endsection Unsorted9FEA0CSection


    .section Unsorted9FEA52Section

      .al
      .xl

      rlUnknown9FEA52 ; 9F/EA52

        .al
        .xl
        .autsiz
        .databank ?

        phx
        sta wR0
        lda lR18+1
        and #$01FF
        sta $2182,b
        lda lR18
        sta $2181,b
        lda $7F50DF
        and #$00FF
        sta wR1
        lda $7F50E1
        sta wR2
        lda $7F50E3
        sta wR3
        lda $7F50E5
        sta wR4
        jsr rsUnknown9FEB4F
        ldy #$0000
        sep #$20
        lda wR2
        sec
        sbc wR3
        beq _EAD1
        bcc _EABC
        cmp #$DF
        bcc _EA96
        jml _EB18


        _EA96
        rep #$20
        and #$00FF
        tax
        lda wR3
        bne _EAA3
        ldx #$00E0

        _EAA3
        sep #$20

        _EAA5
        lda #$80
        sta $2180,b
        lda #$7F
        sta $2180,b
        dec wR0
        bne _EAB7
        jml _EB26


        _EAB7
        dec x
        bne _EAA5
        bra _EAD1


        _EABC
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

        _EAD1
        jsr rsUnknown9FEB2A
        dec wR0
        beq _EB26
        inc y
        cpy wR3
        bcs _EAE7
        rep #$20
        dec wR4
        beq _EAFE
        sep #$20
        bra _EAD1


        _EAE7
        dec y
        cpy #$0000
        bmi _EB18
        jsr rsUnknown9FEB2A
        dec wR0
        beq _EB26
        rep #$20
        dec wR4
        beq _EAFE
        sep #$20
        bra _EAE7


        _EAFE
        .al
        and #$85FF
        asl $A8
        jsr rsUnknown9FEB4F
        sep #$20

        _EB08
        dec y
        dec y
        cpy #$0000
        bmi _EB18
        jsr rsUnknown9FEB2A
        dec wR0
        bne _EB08
        bra _EB26


        _EB18
        lda #$80
        sta $2180,b
        lda #$7F
        sta $2180,b
        dec wR0
        bne _EB18

        _EB26
        rep #$20
        plx
        rtl

        .databank 0

        ; 9F/EB2A

      rsUnknown9FEB2A ; 9F/EB2A

        .as
        .xl
        .autsiz
        .databank ?

        lda [lR19],y
        pha
        lda wR1
        sec
        sbc #1,s
        bcc _EB38
        cmp #$08
        bcs _EB3A

        _EB38
        lda #$08

        _EB3A
        sta $2180,b
        lda wR1
        clc
        adc #1,s
        bcs _EB48
        cmp #$F7
        bcc _EB4A

        _EB48
        lda #$F7

        _EB4A
        sta $2180,b
        pla
        rts

        .databank 0

        ; 9F/EB4F

      rsUnknown9FEB4F ; 9F/EB4F

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$9A00
        sta lR19+1
        lda wR3
        bit #$0080
        beq _EB6E
        pha
        and #$FFF8
        sta wR3
        pla
        and #$FF78
        lsr a
        lsr a
        clc
        adc #$0080
        bra _EB9A


        _EB6E
        bit #$0040
        beq _EB84
        pha
        and #$FFFC
        sta wR3
        pla
        and #$FFBC
        lsr a
        clc
        adc #$0060
        bra _EB9A


        _EB84
        bit #$0020
        beq _EB99
        pha
        and #$FFFE
        sta wR3
        pla
        and #$FFDE
        clc
        adc #$0040
        bra _EB9A


        _EB99
        asl a

        _EB9A
        tax
        lda aUnknown9AA30A,x
        clc
        adc #$A30A
        sta lR19
        plx
        rts

        .databank 0

        ; 9F/EBA7

    .endsection Unsorted9FEA52Section


    .section Unsorted9FEBA7Section

      .al
      .xl

      rlProcUnknown9F805DInit ; 9F/EBA7

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 9F/EBA8

    .endsection Unsorted9FEBA7Section


    .section ProcScript9FEBA9Section

      .al
      .xl

      aProcUnknown9F805DCode ; 9F/EBA9

        PROC_HALT


        ; 9F/EBAB

    .endsection ProcScript9FEBA9Section


    .section Unsorted9FECB2Section

      .al
      .xl

      rlUnknown9FECB2 ; 9F/ECB2

        .al
        .xl
        .autsiz
        .databank ?

        phb
        pea #$7F7F
        plb
        .databank ?
        plb
        .databank ?
        ldx #$0000

        _ECBB
        lda #$00FF
        sta $50EA,b,x
        sta $50EC,b,x
        sta $50EE,b,x
        sta $50F0,b,x
        sta $50F2,b,x
        sta $50F4,b,x
        sta $50F6,b,x
        sta $50F8,b,x
        stz $52AA,b,x
        stz $52AC,b,x
        stz $52AE,b,x
        stz $52B0,b,x
        stz $52B2,b,x
        stz $52B4,b,x
        stz $52B6,b,x
        stz $52B8,b,x
        txa
        clc
        adc #$0010
        tax
        cpx #$01C0
        bne _ECBB
        plb
        .databank ?
        ldx aProcSystem.wOffset,b
        rtl

        .databank 0

        ; 9F/ECFE

      rlUnknown9FECFE ; 9F/ECFE

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown9FED5A
        lda $7F509B
        and #$00FF
        sec
        sbc #$00F8
        eor #$FFFF
        inc a
        sta $7F50CD
        lda $7F509C
        and #$00FF
        sec
        sbc #$0000
        eor #$FFFF
        inc a
        sta $7F50CF
        rtl

        .databank 0

        ; 9F/ED29

    .endsection Unsorted9FECB2Section


    .section Unsorted9FED5ASection

      .al
      .xl

      rlUnknown9FED5A ; 9F/ED5A

        .al
        .xl
        .autsiz
        .databank ?

        txy
        ldx aProcSystem.aHeaderTypeOffset,b,y
        lda $0008,b,x
        and #$00FF
        sta aProcSystem.aBody3,b,y
        lda $0009,b,x
        and #$00FF
        sta aProcSystem.aBody5,b,y
        lda $000A,b,x
        and #$00FF
        sta aProcSystem.aBody4,b,y
        tyx
        lda #$0001
        sta aProcSystem.aBody0,b,x
        sta aProcSystem.aBody1,b,x
        lda #$0001
        sta aProcSystem.aBody2,b,x
        lda $7F509B
        and #$00FF
        sec
        sbc #$0080
        eor #$FFFF
        inc a
        sta $7F50CD
        lda $7F509C
        and #$00FF
        sec
        sbc #$0070
        eor #$FFFF
        inc a
        sta $7F50CF
        jml rlUnknown9FECB2

        .databank 0

        ; 9F/EDB3

      rlUnknown9FEDB3 ; 9F/EDB3

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        dec aProcSystem.aBody1,b,x
        beq _EDBC
        jml _EE44


        _EDBC
        lda aProcSystem.aHeaderTypeOffset,b,x
        tax
        lda $000B,b,x
        sta wR0
        lda $000D,b,x
        sta wR1
        ldx aProcSystem.wOffset,b
        lda aProcSystem.aBody0,b,x
        sta aProcSystem.aBody1,b,x
        lda aProcSystem.aBody2,b,x
        clc
        adc aProcSystem.aBody4,b,x
        sta aProcSystem.aBody2,b,x
        cmp #$0001
        bpl _EDE8
        lda #$0000
        sta aProcSystem.aBody2,b,x

        _EDE8
        cmp aProcSystem.aBody3,b,x
        bmi _EDF3
        lda aProcSystem.aBody3,b,x
        sta aProcSystem.aBody2,b,x

        _EDF3
        lda $7F509B
        and #$00FF
        clc
        adc wR0
        sta $7F50DF
        lda $7F509C
        and #$00FF
        clc
        adc wR1
        sta $7F50E1
        lda aProcSystem.aBody5,b,x
        bne _EE22
        lda aProcSystem.aBody2,b,x
        sta $7F50E3
        asl a
        sta $7F50E5
        bra _EE2E


        _EE22
        lda aProcSystem.aBody2,b,x
        sta $7F50E3
        inc a
        sta $7F50E5

        _EE2E
        phy
        lda #$7F00
        sta lR18+1
        lda #$50EA
        sta lR18
        ldx #$0000
        lda #$00E0
        jsl rlUnknown9FEA52
        ply

        _EE44
        rtl

        .databank 0

        ; 9F/EE45

    .endsection Unsorted9FED5ASection


    .section Unsorted9FF060Section

      .al
      .xl

      rlUnknown9FF060 ; 9F/F060

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$000C
        sta wR0
        lda #$001E
        sta wR1
        lda #$FFFE
        sta wR3
        bra _F07D

        .byte $A9, $0C, $00, $85, $00, $A9, $58, $00, $85, $02, $64, $06


        _F07D
        dec aProcSystem.aBody1,b,x
        beq _F086
        jml _F0DB


        _F086
        lda aProcSystem.aBody0,b,x
        sta aProcSystem.aBody1,b,x
        lda aProcSystem.aBody2,b,x
        clc
        adc aProcSystem.aBody4,b,x
        sta aProcSystem.aBody2,b,x
        cmp #$0001
        bpl _F0A1
        lda #$0001
        sta aProcSystem.aBody2,b,x

        _F0A1
        cmp aProcSystem.aBody3,b,x
        bmi _F0AC
        lda aProcSystem.aBody3,b,x
        sta aProcSystem.aBody2,b,x

        _F0AC
        lda $7F509B
        and #$00FF
        sta $7F50DF
        lda $7F509C
        and #$00FF
        clc
        adc wR0
        and #$01FF
        sta $7F50E1
        lda aProcSystem.aBody3,b,x
        sta $7F50E3
        phy
        lda wR1
        tay
        lda $7F50E3
        jsr rsUnknown9FF250
        ply

        _F0DB
        rtl

        .databank 0

        ; 9F/F0DC

    .endsection Unsorted9FF060Section


    .section Unsorted9FF100Section

      .al
      .xl

      rlUnknown9FF100 ; 9F/F100

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        dec $0FD7,b,x
        bne _F111
        lda #$F111
        sta $0F57,b,x
        lda #$00C0
        sta $1057,b,x

        _F111
        lda $1057,b,x
        clc
        adc $1037,b,x
        sta $1037,b,x
        cmp #$0100
        bpl _F126
        lda #$0000
        sta $1037,b,x

        _F126
        cmp #$0C00
        bmi _F131
        lda #$0C00
        sta $1037,b,x

        _F131
        lda $0ED7,b,x
        tax
        lda $000B,b,x
        sta wR0
        lda $000D,b,x
        sta wR1
        ldx $0ECA,b
        lda $7F509B
        and #$00FF
        clc
        adc wR0
        sta $7F50DF
        lda $7F509C
        and #$00FF
        clc
        adc wR1
        sta $7F50E1
        lda $1038,b,x
        and #$00FF
        beq _F193
        sta $7F50E3
        asl a
        sec
        sbc #$0000
        sta $7F50E5
        phy
        lda $7F50E3
        clc
        adc #$0000
        tay
        lda #$7F00
        sta lR18+1
        lda #$50EA
        sta lR18
        ldx #$0000
        lda #$00E0
        jsl rlUnknown9FE8DE
        ply
        rtl


        _F193
        lda #$50EA
        sta $2181,b
        sep #$20
        lda #$01
        sta $2183,b
        rep #$20
        ldx #$0000
        bra _F1B6


        _F1A7
        sep #$20
        lda #$FF
        sta $2180,b
        lda #$00
        sta $2180,b
        rep #$20
        inc x

        _F1B6
        cpx #$00E0
        bmi _F1A7
        rtl

        .databank 0

        ; 9F/F1BC

    .endsection Unsorted9FF100Section


    .section Unsorted9FF250Section

      .al
      .xl

      rsUnknown9FF250 ; 9F/F250

        .al
        .xl
        .autsiz
        .databank ?

        pha
        sty wR1
        lda $7F509B
        and #$00FF
        sta wR2
        lda $7F509C
        and #$00FF
        clc
        adc wR3
        sta wR3
        pla
        phx
        jsr rsUnknown9FF275
        jsr rsUnknown9FF376
        jsr rsUnknown9FF2E4
        plx
        rts

        .databank 0

        ; 9F/F275

      rsUnknown9FF275 ; 9F/F275

        .al
        .xl
        .autsiz
        .databank ?

        lsr a
        sta wR5
        pha
        clc
        adc wR2
        sta wR4
        lda wR2
        sec
        sbc #1,s
        sta wR2
        pla
        lda #$50EA
        sta $2181,b
        sep #$20
        lda #$01
        sta $2183,b
        rep #$20
        lda wR3
        sec
        sbc wR1
        bmi _F2B2
        beq _F2B2
        tax

        _F29F
        sep #$20
        lda #$FF
        sta $2180,b
        lda #$00
        sta $2180,b
        rep #$20
        dec x
        bne _F29F
        bra _F2B6


        _F2B2
        lda wR3
        sta wR1

        _F2B6
        ldx #$0000
        ldy #$0000

        _F2BC
        lda wR2
        cmp #$0008
        bpl _F2C6
        lda #$0008

        _F2C6
        sep #$20
        sta $2180,b
        rep #$20
        lda wR4
        cmp #$00F7
        bcc _F2D7
        lda #$00F7

        _F2D7
        sep #$20
        sta $2180,b
        rep #$20
        inc x
        cpx wR1
        bmi _F2BC
        rts

        .databank 0

        ; 9F/F2E4

      rsUnknown9FF2E4 ; 9F/F2E4

        .al
        .xl
        .autsiz
        .databank ?

        ldx wR1
        bra _F2F7


        _F2E8
        sep #$20
        lda #$FF
        sta $2180,b
        lda #$00
        sta $2180,b
        rep #$20
        inc x

        _F2F7
        cpx #$00E0
        bmi _F2E8
        rts

        .databank 0

        ; 9F/F2FD

    .endsection Unsorted9FF250Section


    .section Unsorted9FF376Section

      .al
      .xl

      rsUnknown9FF376 ; 9F/F376

        .al
        .xl
        .autsiz
        .databank ?

        phb
        pea #$9A00
        plb
        .databank ?
        plb
        .databank ?
        lda wR5
        clc
        adc #$0004
        asl a
        tax
        lda aUnknown9AA30A,x
        clc
        adc #$A30A
        tax
        dec x
        lda wR5
        clc
        adc #$0003
        tay
        bne _F39A
        ldy #$0001

        _F39A
        lda wR2
        clc
        adc wR4
        and #$01FF
        lsr a
        sta wR0

        _F3A5
        lda $0000,b,x
        and #$00FF
        sta wR6
        lda wR0
        sec
        sbc wR6
        cmp wR2
        bpl _F3B8
        lda wR2

        _F3B8
        cmp #$0008
        bpl _F3C0
        lda #$0008

        _F3C0
        sep #$20
        sta $2180,b
        rep #$20
        lda $0000,b,x
        and #$00FF
        clc
        adc wR0
        cmp wR4
        bcc _F3D6
        lda wR4

        _F3D6
        cmp #$00F7
        bcc _F3DE
        lda #$00F7

        _F3DE
        sep #$20
        sta $2180,b
        rep #$20
        dec wR1
        dec x
        dec y
        bne _F3A5
        plb
        .databank ?
        rts

        .databank 0

        ; 9F/F3ED

    .endsection Unsorted9FF376Section


    .section Unsorted9FF3EDSection

      .al
      .xl

      rlUnknown9FF3ED ; 9F/F3ED

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000
        lda wR0
        bpl _F3FC
        ldx #$0004
        eor #$FFFF
        inc a

        _F3FC
        sta wR0
        lda wR1
        bpl _F408
        inc x
        inc x
        eor #$FFFF
        inc a

        _F408
        sta wR1
        cmp wR0
        bpl rlUnknown9FF42F
        sep #$20
        stz $4204,b
        lda wR1
        sta $4205,b
        lda wR0
        sta $4206,b
        nop
        nop
        nop
        rep #$20
        jsr (aUnknown9FF427,x)
        plx
        rtl

        .databank 0

      aUnknown9FF427 ; 9F/F427

        ; Jump table of rlUnknown9FF3ED.
        .word <>rsUnknown9FF450
        .word <>rsUnknown9FF45E
        .word <>rsUnknown9FF468
        .word <>rsUnknown9FF476

      rlUnknown9FF42F ; 9F/F42F

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        stz $4204,b
        lda wR0
        sta $4205,b
        lda wR1
        sta $4206,b
        nop
        nop
        nop
        rep #$20
        jsr (aUnknown9FF448,x)
        plx
        rtl

        .databank 0

        ; 9F/F448

    .endsection Unsorted9FF3EDSection


    .section Table9FF448Section

      .al
      .xl

      aUnknown9FF448 ; 9F/F448

        ; Jump table of rlUnknown9FF3ED.
        .word <>rsUnknown9FF487
        .word <>rsUnknown9FF495
        .word <>rsUnknown9FF4A6
        .word <>rsUnknown9FF4B7

    .endsection Table9FF448Section


    .section Unsorted9FF450Section

      .al
      .xl

      rsUnknown9FF450 ; 9F/F450

        .al
        .xl
        .autsiz
        .databank ?

        lda $4214,b
        lsr a
        lsr a
        lsr a
        eor #$FFFF
        inc a
        and #$00FF
        rts

        .databank 0

        ; 9F/F45E

      rsUnknown9FF45E ; 9F/F45E

        .al
        .xl
        .autsiz
        .databank ?

        lda $4214,b
        lsr a
        lsr a
        lsr a
        and #$00FF
        rts

        .databank 0

        ; 9F/F468

      rsUnknown9FF468 ; 9F/F468

        .al
        .xl
        .autsiz
        .databank ?

        lda $4214,b
        lsr a
        lsr a
        lsr a
        clc
        adc #$0080
        and #$00FF
        rts

        .databank 0

        ; 9F/F476

      rsUnknown9FF476 ; 9F/F476

        .al
        .xl
        .autsiz
        .databank ?

        lda $4214,b
        lsr a
        lsr a
        lsr a
        eor #$FFFF
        sec
        adc #$0080
        and #$00FF
        rts

        .databank 0

        ; 9F/F487

    .endsection Unsorted9FF450Section


    .section Unsorted9FF487Section

      .al
      .xl

      rsUnknown9FF487 ; 9F/F487

        .al
        .xl
        .autsiz
        .databank ?

        lda $4214,b
        lsr a
        lsr a
        lsr a
        clc
        adc #$00C0
        and #$00FF
        rts

        .databank 0

        ; 9F/F495

    .endsection Unsorted9FF487Section


    .section Unsorted9FF495Section

      .al
      .xl

      rsUnknown9FF495 ; 9F/F495

        .al
        .xl
        .autsiz
        .databank ?

        lda $4214,b
        lsr a
        lsr a
        lsr a
        eor #$FFFF
        sec
        adc #$0040
        and #$00FF
        rts

        .databank 0

        ; 9F/F4A6

    .endsection Unsorted9FF495Section


    .section Unsorted9FF4A6Section

      .al
      .xl

      rsUnknown9FF4A6 ; 9F/F4A6

        .al
        .xl
        .autsiz
        .databank ?

        lda $4214,b
        lsr a
        lsr a
        lsr a
        eor #$FFFF
        sec
        adc #$00C0
        and #$00FF
        rts

        .databank 0

        ; 9F/F4B7

    .endsection Unsorted9FF4A6Section


    .section Unsorted9FF4B7Section

      .al
      .xl

      rsUnknown9FF4B7 ; 9F/F4B7

        .al
        .xl
        .autsiz
        .databank ?

        lda $4214,b
        lsr a
        lsr a
        lsr a
        clc
        adc #$0040
        and #$00FF
        rts

        .databank 0

        ; 9F/F4C5

    .endsection Unsorted9FF4B7Section


    .section Unsorted9FF4C5Section

      .al
      .xl

      rlUnknown9FF4C5 ; 9F/F4C5

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #(`procUnknown9FF4D6)<<8
        sta lR44+1
        lda #<>procUnknown9FF4D6
        sta lR44
        jsl rlProcEngineCreateProc
        plx
        rtl

        .databank 0

        ; 9F/F4D6

    .endsection Unsorted9FF4C5Section


    .section Unsorted9FF4D6Section

      .al
      .xl

      procUnknown9FF4D6 ; 9F/F4D6

        .structProcInfo "ON", rlUnknown9FF4DE, rlUnknown9FF54E, aProcUnknown9FF4D6Code

    .endsection Unsorted9FF4D6Section


    .section Unsorted9FF4DESection

      .al
      .xl

      rlUnknown9FF4DE ; 9F/F4DE

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda wGameStateRoutine1,b
        sta $10B7,b,x
        stz wGameStateRoutine1,b
        jsl rlUnknown88CD53
        jsl rlUnknown88CD61
        lda #$0000
        sta $0F37,b,x
        sta $1037,b,x
        sta $7F4C17
        sta $7F4C07
        sta $7F4580
        sta $7F4582
        sta $7F4584
        jsl rlUnknown9FF697
        jsl rlUnknown9FF6B6
        lda #$0005
        jsl rlGetEventLocationEntryCoordinatesByID
        pha
        and #$00FF
        sta $7F57EA
        pla
        xba
        and #$00FF
        sta $7F57EC
        jsr rsUnknown9FF95C
        lda #(`rlUnknown81841B)<<8
        sta $15E5,b
        lda #<>rlUnknown81841B
        sta $15E4,b
        lda aActiveSpriteSystem,b
        sta $7F4BD9
        lda aActiveSpriteSystem,b
        ora #$4000
        sta aActiveSpriteSystem,b
        plx
        rtl

        .databank 0

        ; 9F/F54E

      rlUnknown9FF54E ; 9F/F54E

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 9F/F54F

      rlUnknown9FF54F ; 9F/F54F

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $1037,b,x
        bne _F563
        jsr rsUnknown9FF97A
        bcc _F563
        lda #1,s
        tax
        lda #$F54E
        sta $0F57,b,x

        _F563
        lda #1,s
        tax
        lda $1037,b,x
        dec a
        bpl _F56F
        lda #$0004

        _F56F
        sta $1037,b,x
        plx
        rtl

        .databank 0

        ; 9F/F574

      rlUnknown9FF574 ; 9F/F574

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda @l $001037,x
        bne _F58A
        jsr rsUnknown9FF968
        bcc _F58A
        lda #1,s
        tax
        lda #$F54E
        sta @l $000F57,x

        _F58A
        lda #1,s
        tax
        lda @l $001037,x
        dec a
        bpl _F597
        lda #$0020

        _F597
        sta @l $001037,x
        plx
        rtl

        .databank 0

        ; 9F/F59D

    .endsection Unsorted9FF4DESection


    .section Unsorted9FF59DSection

      .al
      .xl

      aProcUnknown9FF4D6Code ; 9F/F59D

        PROC_YIELD 1
        _F59F
        PROC_YIELD 1
        PROC_CALL rlUnknown9FF6D5
        PROC_JUMP_IF_BITS_UNSET _F59F, $0001
        PROC_YIELD 1
        PROC_CALL rlUnknown9FF6F0
        PROC_YIELD 2
        PROC_CALL rlUnknown9FF887
        _F5BA
        PROC_YIELD 1
        PROC_CALL rlUnknown9FF899
        PROC_JUMP_IF_BITS_UNSET _F5BA, $0004
        PROC_YIELD 1
        PROC_CALL rlUnknown9FF65A
        _F5CE
        PROC_YIELD 1
        PROC_CALL rlUnknown9FF67D
        PROC_JUMP_IF_BITS_UNSET _F5CE, $0004
        PROC_CALL rlUnknown9FF9A8
        PROC_CALL rlUnknown9FF8B5
        _F5E5
        PROC_YIELD 1
        PROC_CALL rlUnknown9FF8C7
        PROC_JUMP_IF_BITS_UNSET _F5E5, $0004
        PROC_YIELD 1
        PROC_YIELD 120
        PROC_CALL rlUnknown9FF864
        PROC_YIELD 64
        PROC_CALL rlUnknown9FF749
        _F602
        PROC_YIELD 12
        PROC_CALL rlUnknown9FF839
        PROC_JUMP_IF_BITS_UNSET _F602, $0004
        PROC_YIELD 240
        PROC_CALL rlUnknown9FF870
        PROC_CALL rlUnknown9FF68F
        PROC_YIELD 18
        PROC_CALL rlUnknown9FF947
        PROC_YIELD 6
        PROC_CALL rlUnknown9FF870
        PROC_YIELD 32
        PROC_CALL rlUnknown9FF905
        PROC_SET_ONCYCLE rlUnknown9FF54F
        PROC_YIELD 80
        PROC_YIELD 120
        PROC_CALL rlUnknown9FF90C
        PROC_SET_ONCYCLE rlUnknown9FF574
        PROC_YIELD 64
        PROC_CALL rlUnknown9FFAB4
        PROC_YIELD 120
        PROC_CALL rlUnknown9FFAC0
        PROC_YIELD 96
        PROC_YIELD 180
        PROC_CALL rlUnknown9FF916
        PROC_HALT


        ; 9F/F65A

    .endsection Unsorted9FF59DSection


    .section Unsorted9FF65ASection

      .al
      .xl

      rlUnknown9FF65A ; 9F/F65A

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $0F37,b,x
        and #$FFFB
        sta $0F37,b,x
        lda #$0015
        sta @l $0004BA
        plx
        rtl

        .databank 0

        ; 9F/F66D

    .endsection Unsorted9FF65ASection


    .section Unsorted9FF67DSection

      .al
      .xl

      rlUnknown9FF67D ; 9F/F67D

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda @l $0004BA
        bne _F68D
        lda $0F37,b,x
        ora #$0004
        sta $0F37,b,x

        _F68D
        plx
        rtl

        .databank 0

        ; 9F/F68F

      rlUnknown9FF68F ; 9F/F68F

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0016
        sta @l $0004BA
        rtl

        .databank 0

        ; 9F/F697

      rlUnknown9FF697 ; 9F/F697

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #(`gcUnknownAFF670)<<8
        sta lR18+1
        lda #<>gcUnknownAFF670
        sta lR18
        lda #$7E00
        sta lR19+1
        lda #$8B88
        clc
        adc #$0000
        sta lR19
        jsl rlAppendDecompList
        plx
        rtl

        .databank 0

        ; 9F/F6B6

      rlUnknown9FF6B6 ; 9F/F6B6

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #(`gcUnknownD67D7D)<<8
        sta lR18+1
        lda #<>gcUnknownD67D7D
        sta lR18
        lda #$7E00
        sta lR19+1
        lda #$8B88
        clc
        adc #$1000
        sta lR19
        jsl rlAppendDecompList
        plx
        rtl

        .databank 0

        ; 9F/F6D5

      rlUnknown9FF6D5 ; 9F/F6D5

        .al
        .xl
        .autsiz
        .databank ?

        lda $0F37,b,x
        and #$FFFE
        sta $0F37,b,x
        lda bDecompressionArrayFlag,b
        and #$00FF
        bne _F6EF
        lda $0F37,b,x
        ora #$0001
        sta $0F37,b,x

        _F6EF
        rtl

        .databank 0

        ; 9F/F6F0

      rlUnknown9FF6F0 ; 9F/F6F0

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$7E00
        sta lR18+1
        lda #$8B88
        clc
        adc #$0000
        sta lR18
        lda #$0C00
        sta wR0
        lda bBufferOBSEL
        and #$0003
        asl a
        asl a
        asl a
        asl a
        asl a
        xba
        clc
        adc #$0200
        sta wR1
        jsl rlDMAByPointer
        ldx #$001E

        _F71C
        lda aUnknown9FF729,x
        sta $02A0,b,x
        dec x
        dec x
        bne _F71C
        plx
        rtl

        .databank 0

        ; 9F/F729

    .endsection Unsorted9FF67DSection


    .section Data9FF729Section

      .al
      .xl

      aUnknown9FF729 ; 9F/F729

        ; Read by rlUnknown9FF6F0.

        .word $3800, $7FFF, $6739, $41F0, $292A, $1485, $0C43, $1919
        .word $10B2, $0C49, $375F, $0000, $0000, $0000, $0000, $0000

        ; 9F/F749

    .endsection Data9FF729Section


    .section Unsorted9FF749Section

      .al
      .xl

      rlUnknown9FF749 ; 9F/F749

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        jsl rlUnknown9E88CE
        lda #$7E00
        sta $7F4599
        sta lR18+1
        lda #$8B88
        clc
        adc #$1000
        sta $7F4598
        sta lR18
        lda #$7E00
        sta $7F4593
        ldy #$0004
        lda [lR18],y
        clc
        adc lR18
        sta $7F4592
        lda $7F57EC
        tay
        lda $7F57EA
        tax
        lda $7E4F1B
        jsl rlUnknown9E8D25
        lda #$7E00
        sta lR44+1
        lda #$FC88
        sta lR44
        lda $7F4592
        sta $7EFC8C
        ldx wR0
        lda wR1
        clc
        adc #$0005
        tay
        lda #$FC88
        jsl rlActiveSpriteEngineCreateSpriteLowestSlot
        lda $10F9,b
        tax
        sta $7F45A4
        lda #$0000
        sta $1260,b,x
        sta $1280,b,x
        lda #$0005
        sta $12A0,b,x
        lda #$0000
        sta $1320,b,x
        lda #$7E00
        sta lR18+1
        lda #$8B88
        clc
        adc #$1000
        sta lR18
        lda #$7E00
        sta $7F4593
        ldy #$0008
        lda [lR18],y
        clc
        adc lR18
        sta $7F4592
        lda $7F57EC
        tay
        lda $7F57EA
        tax
        lda $7E4F1B
        jsl rlUnknown9E8D25
        lda #$7E00
        sta lR44+1
        lda #$FC8E
        sta lR44
        lda $7F4592
        sta $7EFC92
        lda #$FC8E
        ldx wR0
        ldy wR1
        jsl rlActiveSpriteEngineCreateSpriteLowestSlot
        lda $10F9,b
        tax
        sta $7F45A6
        lda #$0000
        sta $1260,b,x
        sta $1280,b,x
        lda #$0005
        sta $12A0,b,x
        lda #$0000
        sta $1320,b,x
        plx
        ply
        rtl

        .databank 0

        ; 9F/F839

      rlUnknown9FF839 ; 9F/F839

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $0F37,b,x
        and #$FFFB
        sta $0F37,b,x
        lda $7F45A4
        tax
        lda $1240,b,x
        cmp #$0060
        beq _F856
        dec a
        sta $1240,b,x
        bra _F862


        _F856
        lda #1,s
        tax
        lda $0F37,b,x
        ora #$0004
        sta $0F37,b,x

        _F862
        plx
        rtl

        .databank 0

        ; 9F/F864

      rlUnknown9FF864 ; 9F/F864

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F4C07
        ora #$0010
        sta $7F4C07
        rtl

        .databank 0

        ; 9F/F870

      rlUnknown9FF870 ; 9F/F870

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0001
        sta $7F4C17
        sta $7F4580
        lda $7F45A6
        tax
        lda #$0000
        sta $1100,b,x
        rtl

        .databank 0

        ; 9F/F887

      rlUnknown9FF887 ; 9F/F887

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $0F37,b,x
        and #$FFFB
        sta $0F37,b,x
        lda #$0010
        sta $1037,b,x
        plx
        rtl

        .databank 0

        ; 9F/F899

      rlUnknown9FF899 ; 9F/F899

        .al
        .xl
        .autsiz
        .databank ?

        phb
        phx
        pea #$9F9F
        plb
        .databank ?
        plb
        .databank ?
        jsl rlUnknown9F90F2
        bcc _F8B2
        lda #1,s
        tax
        lda $0F37,b,x
        ora #$0004
        sta $0F37,b,x

        _F8B2
        plx
        plb
        .databank ?
        rtl

        .databank 0

        ; 9F/F8B5

      rlUnknown9FF8B5 ; 9F/F8B5

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$0018
        sta $1037,b,x
        lda $0F37,b,x
        and #$FFFB
        sta $0F37,b,x
        plx
        rtl

        .databank 0

        ; 9F/F8C7

      rlUnknown9FF8C7 ; 9F/F8C7

        .al
        .xl
        .autsiz
        .databank ?

        phb
        phx
        lda $1037,b,x
        bne _F8F3
        sep #$20
        lda bBufferINIDISP
        inc a
        sta bBufferINIDISP
        rep #$20
        and #$000F
        cmp #$000F
        bne _F8F3
        lda #1,s
        tax
        lda $0F37,b,x
        ora #$0004
        sta $0F37,b,x
        lda #$F54E
        sta $0F57,b,x
        bra _F8FF


        _F8F3
        lda #1,s
        tax
        lda $1037,b,x
        dec a
        bpl _F8FF
        lda #$0018

        _F8FF
        sta $1037,b,x
        plx
        plb
        .databank ?
        rtl

        .databank 0

        ; 9F/F905

      rlUnknown9FF905 ; 9F/F905

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0004
        sta $1037,b,x
        rtl

        .databank 0

        ; 9F/F90C

      rlUnknown9FF90C ; 9F/F90C

        .al
        .xl
        .autsiz
        .databank ?

        stz $1B45,b
        lda #$0020
        sta $1037,b,x
        rtl

        .databank 0

        ; 9F/F916

      rlUnknown9FF916 ; 9F/F916

        .al
        .xl
        .autsiz
        .databank ?

        lda $10B7,b,x
        sta wGameStateRoutine1,b
        lda $7F4BD9
        sta aActiveSpriteSystem,b
        lda #(`rlPushToOAMBuffer)<<8
        sta $15E5,b
        lda #<>rlPushToOAMBuffer
        sta $15E4,b
        lda $7F4C07
        ora #$0002
        sta $7F4C07
        jsl rlUnknown88CD4C
        jsl rlUnknown88CD5A
        jsl rlProcEngineFreeProc
        rtl

        .databank 0

        ; 9F/F947

      rlUnknown9FF947 ; 9F/F947

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0001
        sta $0ECF,b
        lda #(`procUnknown87C70A)<<8
        sta lR44+1
        lda #<>procUnknown87C70A
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 9F/F95C

      rsUnknown9FF95C ; 9F/F95C

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlSavePaletteBufferColorsToRAM

          .byte $00, $D0, $7E, $60, $00, $00, $00

        rts

        .databank 0

        ; 9F/F968

      rsUnknown9FF968 ; 9F/F968

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0008
        sta aPaletteFading,b
        clc
        jsl rlFadePaletteToColors

          .byte $00, $D0, $60, $00, $00, $00

        rts

        .databank 0

        ; 9F/F97A

      rsUnknown9FF97A ; 9F/F97A

        .al
        .xl
        .autsiz
        .databank ?

        lda #$7FFF
        sta $1B43,b
        lda #$0010
        sta aPaletteFading,b
        clc
        jsl rlFadePaletteToBlack

          .byte $8E, $F9

        rts

        .databank 0

        ; 9F/F98E

    .endsection Unsorted9FF749Section


    .section Unsorted9FF9A8Section

      .al
      .xl

      rlUnknown9FF9A8 ; 9F/F9A8

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #(`procUnknown9FF9B9)<<8
        sta lR44+1
        lda #<>procUnknown9FF9B9
        sta lR44
        jsl rlProcEngineCreateProc
        plx
        rtl

        .databank 0

        ; 9F/F9B9

    .endsection Unsorted9FF9A8Section


    .section Unsorted9FF9B9Section

      .al
      .xl

      procUnknown9FF9B9 ; 9F/F9B9

        .structProcInfo "ON", rlUnknown9FF9C1, rlUnknown9FF9DA, aProcUnknown9FF9B9Code

    .endsection Unsorted9FF9B9Section


    .section Unsorted9FF9C1Section

      .al
      .xl

      rlUnknown9FF9C1 ; 9F/F9C1

        .al
        .xl
        .autsiz
        .databank ?

        lda wMapScrollXPixels,b
        sta $1037,b,x
        lda wMapScrollYPixels,b
        sta $1057,b,x
        lda #$0002
        sta $1077,b,x
        lda #$0000
        sta $1097,b,x
        rtl

        .databank 0

        ; 9F/F9DA

      rlUnknown9FF9DA ; 9F/F9DA

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $1077,b,x
        beq _F9E4
        jml _FA6A


        _F9E4
        lda $7F4C07
        bit #$0004
        bne _FA1B
        lda $1097,b,x
        and #$0001
        asl a
        asl a
        tax
        lda wMapScrollXPixels,b
        eor aUnknown9FFA88,x
        sta wMapScrollXPixels,b
        lda wMapScrollYPixels,b
        eor aUnknown9FFA88+2,x
        sta wMapScrollYPixels,b
        lda $7F45A6
        tax
        lda $1200,b,x
        eor aUnknown9FFA88,x
        sta $1200,b,x
        bra _FA47


        _FA1B
        lda $1097,b,x
        and #$0003
        asl a
        asl a
        tax
        lda wMapScrollXPixels,b
        eor aUnknown9FFA78,x
        sta wMapScrollXPixels,b
        lda wMapScrollYPixels,b
        eor aUnknown9FFA78+2,x
        sta wMapScrollYPixels,b
        lda $7F45A6
        tax
        lda $1200,b,x
        eor aUnknown9FFA78,x
        sta $1200,b,x

        _FA47
        lda #1,s
        tax
        lda $1097,b,x
        inc a
        sta $1097,b,x
        lda $7F4C07
        bit #$0001
        beq _FA6A
        lda $1037,b,x
        sta wMapScrollXPixels,b
        lda $1057,b,x
        sta wMapScrollYPixels,b
        jsl rlProcEngineFreeProc

        _FA6A
        lda $1077,b,x
        dec a
        bpl _FA73
        lda #$0002

        _FA73
        sta $1077,b,x
        plx
        rtl

        .databank 0

        ; 9F/FA78

    .endsection Unsorted9FF9C1Section


    .section Data9FFA78Section

      .al
      .xl

      aUnknown9FFA78 ; 9F/FA78

        ; Read by rlUnknown9FF9DA.

        .word $0001, $0000, $0001, $0001, $0001, $0000, $0001, $0001

        ; 9F/FA88

      aUnknown9FFA88 ; 9F/FA88

        ; Read by rlUnknown9FF9DA.

        .word $0002, $0000, $0002, $0002, $0002, $0000, $0002, $0002

        ; 9F/FA98

    .endsection Data9FFA78Section


    .section Unsorted9FFA98Section

      .al
      .xl

      aProcUnknown9FF9B9Code ; 9F/FA98

        PROC_HALT


        ; 9F/FA9A

    .endsection Unsorted9FFA98Section


    .section Unsorted9FFA9ASection

      .al
      .xl

      rlUnknown9FFA9A ; 9F/FA9A

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$0220
        sta @l wMapScrollXPixels
        lda #$00D0
        sta @l wMapScrollYPixels
        lda #$0080
        sta wCursorXOffset,b
        sta wCursorYOffset,b
        plx
        rtl

        .databank 0

        ; 9F/FAB4

    .endsection Unsorted9FFA9ASection


    .section Unsorted9FFAB4Section

      .al
      .xl

      rlUnknown9FFAB4 ; 9F/FAB4

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F4C07
        ora #$0004
        sta $7F4C07
        rtl

        .databank 0

        ; 9F/FAC0

      rlUnknown9FFAC0 ; 9F/FAC0

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F4C07
        ora #$0001
        sta $7F4C07
        rtl

        .databank 0

        ; 9F/FACC

    .endsection Unsorted9FFAB4Section
