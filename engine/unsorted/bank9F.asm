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


      aUnknown9F8085 ; 9F/8085

        .word <>rlUnknown9F9296
        .word <>rlUnknown9F92AC
        .word <>rlUnknown9FA2BF
        .word $D42A
        .word <>rlUnknown9FB26C
        .word <>rlUnknown9FA66C
        .word <>rlUnknown9FA672
        .word <>rlUnknown9FAF22
        .word <>rlUnknown9FBCCF
        .word <>rlUnknown9FA672
        .word $CA5F
        .word $CA5F
        .word $C840
        .word $BFF9
        .word <>rlUnknown9FB527
        .word <>rlUnknown9FAC5B
        .word $C18B
        .word <>rlUnknown9F97B7
        .word <>rlUnknown9F9954
        .word $D0D6
        .word <>rlUnknown9F9D10
        .word <>rlUnknown9FA5AB
        .word <>rlUnknown9F9954
        .word <>rlUnknown9F9954
        .word <>rlUnknown9F9954
        .word <>rlUnknown9F9954
        .word <>rlUnknown9F9954
        .word $9965
        .word <>rlUnknown9F9976
        .word $9987
        .word $9998
        .word <>rlUnknown9FB60E
        .word $CD38
        .word $CD38
        .word <>rlUnknown9F9954
        .word <>rlUnknown9FB614
        .word <>rlUnknown9F9954
        .word $C60F
        .word <>rlUnknown9FB61A
        .word <>rlUnknown9F9BFD
        .word $D2C8
        .word $CD52

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

      rsUnknown9F827A ; 9F/827A

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda aProcSystem.aBody7,b,x
        inc aProcSystem.aBody7,b,x
        and #$0003
        asl a
        tax
        sep #$20
        lda $7F57FD
        adc <>aUnknown9F829F,b,x
        sta $7F
        lda $7F57FE
        clc
        adc <>(aUnknown9F829F+1),b,x
        sta $81
        rep #$20
        plx
        rts

        .databank 0

      aUnknown9F829F ; 9F/829F

        .byte $02, $02, $00, $02, $00, $FE, $FE, $FE

        ; 9F/82A7

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

      rsUnknown9F82BE ; 9F/82BE

        .al
        .xl
        .autsiz
        .databank ?

        stz aProcSystem.aBody0,b,x
        stz aProcSystem.aBody1,b,x
        stz aProcSystem.aBody2,b,x
        stz aProcSystem.aBody3,b,x
        stz aProcSystem.aBody4,b,x
        stz aProcSystem.aBody5,b,x
        stz aProcSystem.aBody6,b,x
        stz aProcSystem.aBody7,b,x
        rts

        .databank 0

        ; 9F/82D7

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


      aUnknown9F83E9 ; 9F/83E9

        .byte $08, $21, $7F, $37, $7F, $30, $22, $0E

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
        lda aMapAction.wMapBattleRoundIndex
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
        lda aMapAction.wMapBattleRoundIndex
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

        ; Found by tools/sweep.py.
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

      rsUnknown9F89D4 ; 9F/89D4

        .al
        .xl
        .autsiz
        .databank ?

        lda aActiveSpriteSystem.aUnknown001200,b,x
        sec
        sbc wR0
        bpl _89E0
        eor #$FFFF
        inc a

        _89E0
        cmp wR2
        bpl _89F6
        lda aActiveSpriteSystem.aUnknown001240,b,x
        sec
        sbc wR1
        bpl _89F0
        eor #$FFFF
        inc a

        _89F0
        cmp wR2
        bpl _89F6
        sec
        rts

        _89F6
        clc
        rts

        .databank 0

      rlUnknown9F89F8 ; 9F/89F8

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda wR0
        sta wR2
        jsl rlUnknown9F8A34
        sta wR0
        lda wR2
        bpl _8A0B
        eor #$FFFF
        inc a

        _8A0B
        xba
        jsl rlUnknown9F8B7A._8B84
        bpl _8A16
        eor #$FFFF
        inc a

        _8A16
        sta wR2
        lda wR1
        bpl _8A20
        eor #$FFFF
        inc a

        _8A20
        xba
        jsl rlUnknown9F8B7A
        bpl _8A2B
        eor #$FFFF
        inc a

        _8A2B
        clc
        adc wR2
        xba
        plx
        and #$00FF
        rtl

        .databank 0

        ; 9F/8A34

    .endsection Unsorted9F8999Section


    .section Unsorted9F8A34Section

      .as
      .xl

      rlUnknown9F8A34 ; 9F/8A34

        ; Found by tools/sweep.py.
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


      aUnknown9F8B3A ; 9F/8B3A

        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $FF, $FF, $FF, $FF, $FF, $FF
        .byte $00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00
        .byte $00, $00, $01, $02, $02, $02, $03, $03, $03, $03, $04, $03, $03, $04, $03, $04
        .byte $03, $03, $03, $03, $03, $03, $03, $02, $02, $02, $02, $01, $01, $00, $00, $00

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


    .section Table9F8C3ASection

      .al
      .xl

      aUnknown9F8C3A ; 9F/8C3A

        ; Read by rlUnknown9F8B7A and rlUnknown9F8C05 (256-entry signed trig table).

        .sint $0000, $0006, $000C, $0012, $0019, $001F, $0025, $002B
        .sint $0031, $0038, $003E, $0044, $004A, $0050, $0056, $005C
        .sint $0061, $0067, $006D, $0073, $0078, $007E, $0083, $0088
        .sint $008E, $0093, $0098, $009D, $00A2, $00A7, $00AB, $00B0
        .sint $00B5, $00B9, $00BD, $00C1, $00C5, $00C9, $00CD, $00D1
        .sint $00D4, $00D8, $00DB, $00DE, $00E1, $00E4, $00E7, $00EA
        .sint $00EC, $00EE, $00F1, $00F3, $00F4, $00F6, $00F8, $00F9
        .sint $00FB, $00FC, $00FD, $00FE, $00FE, $00FF, $00FF, $00FF
        .sint $0100, $00FF, $00FF, $00FF, $00FE, $00FE, $00FD, $00FC
        .sint $00FB, $00F9, $00F8, $00F6, $00F4, $00F3, $00F1, $00EE
        .sint $00EC, $00EA, $00E7, $00E4, $00E1, $00DE, $00DB, $00D8
        .sint $00D4, $00D1, $00CD, $00C9, $00C5, $00C1, $00BD, $00B9
        .sint $00B5, $00B0, $00AB, $00A7, $00A2, $009D, $0098, $0093
        .sint $008E, $0088, $0083, $007E, $0078, $0073, $006D, $0067
        .sint $0061, $005C, $0056, $0050, $004A, $0044, $003E, $0038
        .sint $0031, $002B, $0025, $001F, $0019, $0012, $000C, $0006
        .sint $0000, -$0006, -$000C, -$0012, -$0019, -$001F, -$0025, -$002B
        .sint -$0031, -$0038, -$003E, -$0044, -$004A, -$0050, -$0056, -$005C
        .sint -$0061, -$0067, -$006D, -$0073, -$0078, -$007E, -$0083, -$0088
        .sint -$008E, -$0093, -$0098, -$009D, -$00A2, -$00A7, -$00AB, -$00B0
        .sint -$00B5, -$00B9, -$00BD, -$00C1, -$00C5, -$00C9, -$00CD, -$00D1
        .sint -$00D4, -$00D8, -$00DB, -$00DE, -$00E1, -$00E4, -$00E7, -$00EA
        .sint -$00EC, -$00EE, -$00F1, -$00F3, -$00F4, -$00F6, -$00F8, -$00F9
        .sint -$00FB, -$00FC, -$00FD, -$00FE, -$00FE, -$00FF, -$00FF, -$00FF
        .sint -$0100, -$00FF, -$00FF, -$00FF, -$00FE, -$00FE, -$00FD, -$00FC
        .sint -$00FB, -$00F9, -$00F8, -$00F6, -$00F4, -$00F3, -$00F1, -$00EE
        .sint -$00EC, -$00EA, -$00E7, -$00E4, -$00E1, -$00DE, -$00DB, -$00D8
        .sint -$00D4, -$00D1, -$00CD, -$00C9, -$00C5, -$00C1, -$00BD, -$00B9
        .sint -$00B5, -$00B0, -$00AB, -$00A7, -$00A2, -$009D, -$0098, -$0093
        .sint -$008E, -$0088, -$0083, -$007E, -$0078, -$0073, -$006D, -$0067
        .sint -$0061, -$005C, -$0056, -$0050, -$004A, -$0044, -$003E, -$0038
        .sint -$0031, -$002B, -$0025, -$001F, -$0019, -$0012, -$000C, -$0006

        ; 9F/8E3A

    .endsection Table9F8C3ASection


    .section Unsorted9F8E3ASection

      .al
      .xl

      rlUnknown9F8E3A ; 9F/8E3A

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda #5,s
        tay
        lda $0001,b,y
        sta lR18
        lda $0002,b,y
        sta lR18+1
        lda $0004,b,y
        sta wR0
        lda $0006,b,y
        tax
        tya
        clc
        adc #$0007
        sta #5,s
        ldy #$0000

        _8E5C
        lda [lR18],y
        sta aBGPaletteBuffer,b,x
        inc x
        inc x
        inc y
        inc y
        dec wR0
        bne _8E5C
        ply
        plx
        rtl

        .databank 0

        ; 9F/8E6C


    .endsection Unsorted9F8E3ASection


    .section Unsorted9F8EC0Section

      .al
      .xl

      rlUnknown9F8EC0 ; 9F/8EC0

        ; Found by tools/sweep.py.
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

        jsr rsUnknown9F919F
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
        bra rsUnknown9F912A

        .databank 0

      rsUnknown9F911E ; 9F/911E

        .al
        .xl
        .autsiz
        .databank ?

        sta aPaletteFading.wDesiredColor,b
        tya
        sta aPaletteFading,b
        clc
        jml rsUnknown9F91FB

        .databank 0

      rsUnknown9F912A ; 9F/912A

        .al
        .xl
        .autsiz
        .databank ?

        sta aPaletteFading.wDesiredColor,b
        tya
        sta aPaletteFading,b
        sec
        jml rsUnknown9F91B1

        .databank 0

      rsUnknown9F9136 ; 9F/9136

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0007
        ldy #$000E
        sta aPaletteFading.wDesiredColor,b
        tya
        sta aPaletteFading,b
        clc
        jml rsUnknown9F91CE

        .databank 0

      rsUnknown9F9148 ; 9F/9148

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0007
        ldy #$0014
        sta aPaletteFading.wDesiredColor,b
        tya
        sta aPaletteFading,b
        clc
        jml rsUnknown9F91DD

        .databank 0

      rsUnknown9F915A ; 9F/915A

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0007
        ldy #$000E
        sta aPaletteFading.wDesiredColor,b
        tya
        sta aPaletteFading,b
        clc
        jml rsUnknown9F91EC

        .databank 0

      rsUnknown9F916C ; 9F/916C

        .al
        .xl
        .autsiz
        .databank ?

        lda #$7FFF
        sta aPaletteFading.wDesiredColor,b
        lda #$0010
        sta aPaletteFading,b
        clc
        jml rsUnknown9F91B1

        .databank 0

      rsUnknown9F917D ; 9F/917D

        .al
        .xl
        .autsiz
        .databank ?

        lda #$7FFF
        sta aPaletteFading.wDesiredColor,b
        lda #$0010
        sta aPaletteFading,b
        clc
        jml rsUnknown9F920A

        .databank 0

      rsUnknown9F918E ; 9F/918E

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta aPaletteFading.wDesiredColor,b
        lda #$0010
        sta aPaletteFading,b
        clc
        jml rsUnknown9F920A

        .databank 0

      rsUnknown9F919F ; 9F/919F

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0008
        sta aPaletteFading,b
        clc
        jsl rlFadePaletteToColors

          .byte $00, $D0, $50, $00, $20, $00

        rts

        .databank 0

      rsUnknown9F91B1 ; 9F/91B1

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlFadePaletteToBlack

          .word <>aUnknown9F91B8

        rts

        .databank 0

      aUnknown9F91B8 ; 9F/91B8

        .word $0022, $000F, $0042, $000F, $0062, $000F, $0082, $000F, $00A2, $000F, $FFFF

      rsUnknown9F91CE ; 9F/91CE

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlFadeBGPaletteColorRanges
        .word <>aUnknown9F91D5
        rts

        .databank 0

      aUnknown9F91D5 ; 9F/91D5

        .word $0022, $004F, $0420, $FFFF

      rsUnknown9F91DD ; 9F/91DD

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlFadeBGPaletteColorRanges
        .word <>aUnknown9F91E4
        rts

        .databank 0

      aUnknown9F91E4 ; 9F/91E4

        .word $0022, $004F, $0021, $FFFF

      rsUnknown9F91EC ; 9F/91EC

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlFadeBGPaletteColorRanges
        .word <>aUnknown9F91F3
        rts

        .databank 0

      aUnknown9F91F3 ; 9F/91F3

        .word $0022, $004F, $0401, $FFFF

      rsUnknown9F91FB ; 9F/91FB

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlFadeBGPaletteColorRanges
        .word <>aUnknown9F9202
        rts

        .databank 0

      aUnknown9F9202 ; 9F/9202

        .word $0022, $004F, $0421, $FFFF

      rsUnknown9F920A ; 9F/920A

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlFadePaletteToBlack
        .word <>aUnknown9F9211
        rts

        .databank 0

      aUnknown9F9211 ; 9F/9211

        .word $01C2, $000F, $FFFF

        ; 9F/9217

    .endsection Unsorted9F910ASection


    .section Unsorted9F9217Section

      .al
      .xl

      rlUnknown9F9217 ; 9F/9217

        ; Found by tools/sweep.py.
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
        bcc rlUnknown9F9295
        lda #<>rlUnknown9F9295
        sta aProcSystem.aHeaderOnCycle,b,x
        stz aProcSystem.aHeaderTypeOffset,b,x
        jsl rlUnknown9F8349
        jsl rlUnknown9F8473._847A

        .databank 0

      rlUnknown9F9295 ; 9F/9295

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 9F/9296

      rlUnknown9F9296 ; 9F/9296

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #(`aUnknown9F936C)<<8
        sta lR44+1
        lda #<>aUnknown9F936C
        sta lR44
        jsl rlActiveSpriteEngineCreateSpriteHighestSlot
        plx
        jsr rsUnknown9F82D7

          .word $92C2

        rtl

        .databank 0

        ; 9F/92AC


      rlUnknown9F92AC ; 9F/92AC

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #(`aUnknown9F9372)<<8
        sta lR44+1
        lda #<>aUnknown9F9372
        sta lR44
        jsl rlActiveSpriteEngineCreateSpriteHighestSlot
        plx
        jsr rsUnknown9F82D7

          .word $92CA

        rtl

        .databank 0

      procUnknown9F92C2 ; 9F/92C2

        .structProcInfo "ON", rlUnknown9F92D2, rlUnknown9F92F3, aProcUnknown9F805DCode

      procUnknown9F92CA ; 9F/92CA

        .structProcInfo "ON", rlUnknown9F92D2, rlUnknown9F9302, aProcUnknown9F805DCode

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

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        lda $7ECC06
        bne _92FA
        rtl


        _92FA
        lda #<>rlUnknown9F932D
        sta aProcSystem.aHeaderOnCycle,b,x
        bra rlUnknown9F932D

        .databank 0

        ; 9F/9302

      rlUnknown9F9302 ; 9F/9302

        .al
        .xl
        .autsiz
        .databank ?

        lda $7ECC06
        bne _9309
        rtl


        _9309
        jsr rsUnknown9F934D
        lda #<>rlUnknown9F9313
        sta aProcSystem.aHeaderOnCycle,b,x

        _9312
        rtl

        .databank 0

        ; 9F/9313

      rlUnknown9F9313 ; 9F/9313

        .al
        .xl
        .autsiz
        .databank ?

        lda $7ECC08
        beq rlUnknown9F9302._9312
        jsl rlUnknown9F9691
        bcc rlUnknown9F9302._9312
        lda #$0001
        sta $7F5093
        lda #<>rlUnknown9F932C
        sta aProcSystem.aHeaderOnCycle,b,x

        .databank 0

        ; 9F/932C

      rlUnknown9F932C ; 9F/932C

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 9F/932D

      rlUnknown9F932D ; 9F/932D

        .al
        .xl
        .autsiz
        .databank ?

        lda $7ECC08
        beq rlUnknown9F9340
        lda #$0001
        sta $7F5093
        lda #<>rlUnknown9F9340
        sta aProcSystem.aHeaderOnCycle,b,x

        .databank 0

      rlUnknown9F9340 ; 9F/9340

        .al
        .xl
        .autsiz
        .databank ?

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

        bra rsUnknown9F934D._9357

        .databank 0

        ; 9F/934D

      rsUnknown9F934D ; 9F/934D

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9F82D7

          .word $EBBA

        jsr rsUnknown9F830F

          .word $DE5E


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


    .section Table9F936CSection

      .al
      .xl

      aUnknown9F936C ; 9F/936C
        .word <>rlUnknown9F939E, <>rlUnknown9F9378, $9527

      aUnknown9F9372 ; 9F/9372
        .word <>rlUnknown9F939E, <>rlUnknown9F9378, $9584

    .endsection Table9F936CSection


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
        lda #<>rlUnknown9F94D5
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

      rlUnknown9F94D5 ; 9F/94D5

        .al
        .xl
        .autsiz
        .databank ?

        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne _94ED
        lda #$0008
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        lda #<>rlUnknown9F94EE
        sta aActiveSpriteSystem.aOnCycle,b,x
        lda #$0001
        sta aMapAction.wMapBattleActiveSpriteSyncFlag

        _94ED
        rtl

        .databank 0

        ; 9F/94EE

      rlUnknown9F94EE ; 9F/94EE

        .al
        .xl
        .autsiz
        .databank ?

        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne _94FD
        stz aActiveSpriteSystem.aTypeOffset,b,x
        lda #$0001
        sta $7ECC08

        _94FD
        rtl

        .databank 0

        ; 9F/94FE

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
        bne rlUnknown9F9517._9526
        lda #$0001
        sta aMapAction.wMapBattleActiveSpriteSyncFlag
        lda #<>rlUnknown9F9517
        sta aActiveSpriteSystem.aOnCycle,b,x
        lda #$0020
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        rtl

        .databank 0

        ; 9F/9517

      rlUnknown9F9517 ; 9F/9517

        .al
        .xl
        .autsiz
        .databank ?

        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne _9526
        stz aActiveSpriteSystem.aTypeOffset,b,x
        lda #$0001
        sta $7ECC08

        _9526
        rtl

        .databank 0

        ; 9F/9527


      aUnknown9F9527 ; 9F/9527

        .byte $00, $05, $01, $96, $17, $70, $95, $00, $01, $03, $96, $00, $01, $0A, $96, $00
        .byte $01, $11, $96, $14, $E0, $93, $00, $01, $03, $96, $00, $01, $0A, $96, $00, $01
        .byte $11, $96, $17, $E1, $95, $3D, $95, $00, $01, $03, $96, $00, $01, $0A, $96, $00
        .byte $01, $11, $96, $17, $F1, $95, $4E, $95, $17, $7A, $95, $00, $02, $18, $96, $00
        .byte $02, $1F, $96, $00, $30, $01, $96, $16, $FB

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


      aUnknown9F9601 ; 9F/9601

        .word 0

      aUnknown9F9603 ; 9F/9603

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $000, 2, 6, false, false]]

        .structSpriteArray aUnknown9F9603._Sprites

      aUnknown9F960A ; 9F/960A

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $002, 2, 6, false, false]]

        .structSpriteArray aUnknown9F960A._Sprites

      aUnknown9F9611 ; 9F/9611

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $004, 2, 6, false, false]]

        .structSpriteArray aUnknown9F9611._Sprites

      aUnknown9F9618 ; 9F/9618

        _Sprites := [[(  -8,  -10), $21, SpriteLarge, $006, 2, 6, false, false]]

        .structSpriteArray aUnknown9F9618._Sprites

      aUnknown9F961F ; 9F/961F

        _Sprites := [[(  -8,   -9), $21, SpriteLarge, $008, 2, 6, false, false]]

        .structSpriteArray aUnknown9F961F._Sprites

      aUnknown9F9626 ; 9F/9626

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $000, 2, 6, false, false]]

        .structSpriteArray aUnknown9F9626._Sprites

      aUnknown9F962D ; 9F/962D

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $002, 2, 6, false, false]]

        .structSpriteArray aUnknown9F962D._Sprites

      aUnknown9F9634 ; 9F/9634

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $004, 2, 6, false, false]]

        .structSpriteArray aUnknown9F9634._Sprites

      aUnknown9F963B ; 9F/963B

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $006, 2, 6, false, false]]

        .structSpriteArray aUnknown9F963B._Sprites

      aUnknown9F9642 ; 9F/9642

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $008, 2, 6, false, false]]

        .structSpriteArray aUnknown9F9642._Sprites

      aUnknown9F9649 ; 9F/9649

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $00A, 2, 6, false, false]]

        .structSpriteArray aUnknown9F9649._Sprites

      aUnknown9F9650 ; 9F/9650

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $006, 2, 6, false, true]]

        .structSpriteArray aUnknown9F9650._Sprites

      aUnknown9F9657 ; 9F/9657

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $008, 2, 6, false, true]]

        .structSpriteArray aUnknown9F9657._Sprites

      aUnknown9F965E ; 9F/965E

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $00A, 2, 6, false, true]]

        .structSpriteArray aUnknown9F965E._Sprites

      aUnknown9F9665 ; 9F/9665

        _Sprites := [[(   0,    3), $00, SpriteSmall, $01C, 2, 6, true, false]]
        _Sprites ..= [[(   0,   -5), $00, SpriteSmall, $00C, 2, 6, true, false]]
        _Sprites ..= [[(  -8,    3), $00, SpriteSmall, $01C, 2, 6, false, false]]
        _Sprites ..= [[(  -8,   -5), $00, SpriteSmall, $00C, 2, 6, false, false]]

        .structSpriteArray aUnknown9F9665._Sprites

      aUnknown9F967B ; 9F/967B

        _Sprites := [[(   0,    3), $00, SpriteSmall, $01D, 2, 6, false, false]]
        _Sprites ..= [[(   0,   -5), $00, SpriteSmall, $00D, 2, 6, false, false]]
        _Sprites ..= [[(  -8,    3), $00, SpriteSmall, $01D, 2, 6, true, false]]
        _Sprites ..= [[(  -8,   -5), $00, SpriteSmall, $00D, 2, 6, true, false]]

        .structSpriteArray aUnknown9F967B._Sprites

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


      aUnknown9F96D5 ; 9F/96D5

        .word $73FF, $2FFF, $03BF, $02DF, $023F, $017F, $007F
        .word $6BBD, $2BBD, $037D, $029D, $01FD, $015D, $005D
        .word $635A, $275A, $033A, $027A, $01DA, $013A, $005A
        .word $5B18, $2318, $02F8, $0238, $01B8, $0118, $0058
        .word $52D6, $22D6, $02B6, $0216, $0196, $0116, $0056
        .word $4A94, $1E94, $0274, $01D4, $0174, $00F4, $0054
        .word $4252, $1A52, $0232, $01B2, $0152, $00D2, $0032
        .word $3E10, $1610, $01F0, $0170, $0130, $00B0, $0030
        .word $35CE, $15CE, $01AE, $014E, $010E, $00AE, $002E
        .word $2D8C, $118C, $016C, $010C, $00CC, $008C, $002C
        .word $254A, $0D4A, $012A, $00EA, $00AA, $006A, $002A
        .word $1D08, $0D08, $00E8, $00A8, $0088, $0068, $0008
        .word $14C6, $08C6, $00A6, $0086, $0066, $0046, $0006
        .word $0C84, $0484, $0064, $0064, $0044, $0024, $0004
        .word $0442, $0042, $0042, $0022, $0022, $0002, $0002
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $FFFF

      rlUnknown9F97B7 ; 9F/97B7

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9F82D7

          .word $97BD

        rtl

        .databank 0

      procUnknown9F97BD ; 9F/97BD

        .structProcInfo "ON", rlUnknown9F97C5, rlUnknown9F97D6, aProcUnknown9F805DCode

      rlUnknown9F97C5 ; 9F/97C5

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9F83F1
        jsr rsUnknown9F910A
        stz aProcSystem.aBody2,b,x
        stz aProcSystem.aBody3,b,x
        jsl rlUnknown9F97D6._9860
        rtl

        .databank 0

      rlUnknown9F97D6 ; 9F/97D6

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9F915A
        bcc _97E1
        lda #$97E2
        sta aProcSystem.aHeaderOnCycle,b,x

        _97E1
        rtl


        _97E2
        jsr rsUnknown9F82D7

          .word $EBC9

        jsr rsUnknown9F830F

          .word $DBB8

        jsr rsUnknown9F830F

          .word $DBF1

        jsr rsUnknown9F830F

          .word $DB6C

        jsr rsUnknown9F830F

          .word $DB7F

        jsr rsUnknown9F830F

          .word $DE6E

        lda $7F509B
        and #$00FF

        _9807
        jsr rsUnknown9F8253

          .byte $60

        lda #$9818
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0028
        sta aProcSystem.aBody0,b,x
        rtl


        _9818
        dec aProcSystem.aBody0,b,x
        bne _9830
        lda #$0001
        sta aMapAction.wMapBattleActiveSpriteSyncFlag
        lda #$9831
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0008
        sta aProcSystem.aBody0,b,x

        _9830
        rtl


        _9831
        dec aProcSystem.aBody0,b,x
        bne _983C
        lda #$983D
        sta aProcSystem.aHeaderOnCycle,b,x

        _983C
        rtl


        _983D
        jsl _9860
        bcc _984C
        lda #$984D
        sta aProcSystem.aHeaderOnCycle,b,x
        jsr rsUnknown9F8359

        _984C
        rtl


        _984D
        jsr rsUnknown9F919F
        bcc _985F
        lda #$985F
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0001
        sta $7F5093

        _985F
        rtl


        _9860
        lda #$0003
        sta aProcSystem.aBody2,b,x
        ldy aProcSystem.aBody3,b,x
        lda $98AA,b,y
        cmp #$FFFF
        beq aUnknown9F98A8
        phx
        tya
        clc
        adc #$000E
        sta aProcSystem.aBody3,b,x
        tyx
        lda $98AA,b,x
        sta $01D2,b
        lda $98AC,b,x
        sta $01D4,b
        lda $98AE,b,x
        sta $01D6,b
        lda $98B0,b,x
        sta $01D8,b
        lda $98B2,b,x
        sta $01DA,b
        lda $98B4,b,x
        sta $01DC,b
        lda $98B6,b,x
        sta $01DE,b
        plx
        clc
        rtl

        .databank 0

      aUnknown9F98A8 ; 9F/98A8

        .word $6B38, $02D6, $12D6, $1ED6, $2ED6, $3AD6, $46D6
        .word $56D6, $0294, $1294, $1A94, $2A94, $3694, $4294
        .word $4E94, $0252, $0E52, $1A52, $2652, $3252, $3A52
        .word $4652, $0210, $0E10, $1610, $2210, $2A10, $3210
        .word $3E10, $01CE, $09CE, $11CE, $1DCE, $25CE, $2DCE
        .word $35CE, $018C, $098C, $118C, $198C, $218C, $258C
        .word $2D8C, $014A, $094A, $0D4A, $154A, $194A, $214A
        .word $254A, $0108, $0508, $0908, $1108, $1508, $1908
        .word $1D08, $00C6, $04C6, $08C6, $0CC6, $10C6, $10C6
        .word $14C6, $0084, $0084, $0484, $0884, $0884, $0C84
        .word $0C84, $0042, $0042, $0042, $0442, $0442, $0442
        .word $0842, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $FFFF

    .endsection Unsorted9F9691Section


    .section Unsorted9F9954Section

      .al
      .xl

      rlUnknown9F9954 ; 9F/9954

        ; Found through fe4.cdl.
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

        ; Found through fe4.cdl.
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


      procUnknown9F99BB ; 9F/99BB

        .structProcInfo "ON", rlUnknown9F99CE, rlUnknown9F99E6, aProcUnknown9F99C3Code

      aProcUnknown9F99C3Code ; 9F/99C3

        PROC_YIELD 1
        PROC_CALL rlUnknown9F9ABF
        PROC_JUMP aProcUnknown9F99C3Code

    .endsection Unsorted9F999ESection


    .section Unsorted9F99CESection

      .al
      .xl

      rlUnknown9F99CE ; 9F/99CE

        ; Found through fe4.cdl.
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

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        dec aProcSystem.aBody0,b,x
        bne _99FE
        lda #$0001
        sta aMapAction.wMapBattleActiveSpriteSyncFlag
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

        ; Found through fe4.cdl.
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


      aUnknown9F9B08 ; 9F/9B08

        .word $7FFF, $7FBD, $7F9C, $7F5A, $7F38, $7EF7, $7ED5, $7E93
        .word $7E72, $7E30, $7E0E, $7DCD, $7DAB, $7D69, $7D48, $7D06
        .word $7D06, $7D48, $7D69, $7DAB, $7DCD, $7E0E, $7E30, $7E72
        .word $7E93, $7ED5, $7EF7, $7F38, $7F5A, $7F9C, $7FBD, $7FFF
        .word $7FFF, $7FBD, $7F9C, $7F5A, $7F38, $7EF7, $7ED5

      rsUnknown9F9B56 ; 9F/9B56

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aBody2,b,x
        beq _9B60
        dec a
        sta aProcSystem.aBody2,b,x
        rts


        _9B60
        lda #$0003
        sta aProcSystem.aBody2,b,x
        phx
        lda aProcSystem.aBody3,b,x
        inc a
        and #$000F
        sta aProcSystem.aBody3,b,x
        asl a
        tax
        lda $9B9B,b,x
        sta $01D6,b
        lda $9B99,b,x
        sta $01D8,b
        lda $9B97,b,x
        sta $01DA,b
        lda $9B95,b,x
        sta $01DC,b
        lda $9B93,b,x
        sta $01DE,b
        plx
        rts

        .databank 0

      aUnknown9F9B93 ; 9F/9B93

        .word $03FF, $02B9, $0278, $0216, $01D5, $0153, $00D0, $004E
        .word $004E, $00D0, $0153, $01D5, $01D5, $0216, $0278, $03FF
        .word $03FF, $02B9, $0278, $0216, $01D5, $0153, $00D0, $004E
        .word $004E, $00D0, $0153, $01D5, $01D5, $0216, $0278, $03FF
        .word $03FF, $0278, $0216, $01D5, $01D5, $0153, $00D0, $004E
        .word $004E, $00D0, $0153, $01D5, $0216, $0278, $02B9, $03FF
        .word $03FF, $0278, $0216, $01D5, $01D5

      rlUnknown9F9BFD ; 9F/9BFD

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9F82D7

          .word $9C03

        rtl

        .databank 0

      procUnknown9F9C03 ; 9F/9C03

        .structProcInfo "ON", rlUnknown9F9C0B, rlUnknown9F9C47, aProcUnknown9F9C8CCode

      rlUnknown9F9C0B ; 9F/9C0B

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9F83F1
        jsr rsUnknown9F82D7

          .word $EC2B

        sta aProcSystem.aBody7,b,x
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

        stz aProcSystem.aBody2,b,x
        stz aProcSystem.aBody3,b,x
        lda $7F509B
        and #$00FF
        jsr rsUnknown9F8253

          .byte $76

        lda #$0010
        sta aProcSystem.aBody0,b,x
        rtl


      rlUnknown9F9C47 ; 9F/9C47

        .al
        .xl
        .autsiz
        .databank ?
        dec aProcSystem.aBody0,b,x
        bne _9C8B
        lda #$0001
        sta aMapAction.wMapBattleActiveSpriteSyncFlag
        lda #$9C60
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0020
        sta aProcSystem.aBody0,b,x
        rtl


        _9C60
        dec aProcSystem.aBody0,b,x
        bne _9C8B
        ldy aProcSystem.aBody7,b,x
        lda aProcSystem.aBody4,b,y
        eor #$FFFF
        inc a
        sta aProcSystem.aBody4,b,y
        lda #$9C7F
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0020
        sta aProcSystem.aBody0,b,x
        rtl


        _9C7F
        dec aProcSystem.aBody0,b,x
        bne _9C8B
        lda #$0001
        sta $7F5093

        _9C8B
        rtl

        .databank 0

      aProcUnknown9F9C8CCode ; 9F/9C8C

        PROC_YIELD 1
        PROC_CALL rlUnknown9F9C97
        PROC_JUMP aProcUnknown9F9C8CCode

      rlUnknown9F9C97 ; 9F/9C97

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aBody2,b,x
        beq _9CA1
        dec a
        sta aProcSystem.aBody2,b,x
        rtl


        _9CA1
        lda #$0001
        sta aProcSystem.aBody2,b,x
        phx
        lda aProcSystem.aBody3,b,x
        inc a
        and #$000F
        sta aProcSystem.aBody3,b,x
        asl a
        tax
        lda $9CE0,b,x
        sta $01D2,b
        lda $9CE2,b,x
        sta $01D4,b
        lda $9CE4,b,x
        sta $01D6,b
        lda $9CE6,b,x
        sta $01D8,b
        lda $9CE8,b,x
        sta $01DA,b
        lda $9CEA,b,x
        sta $01DC,b
        lda $9CEC,b,x
        sta $01DE,b
        plx
        rtl

        .databank 0

      aUnknown9F9CE0 ; 9F/9CE0

        .word $00FF, $53FF, $3FFF, $033F, $02BF, $01BF, $00FF, $00FF
        .word $0C12, $71BF, $701F, $401F, $2C1B, $1C16, $1414, $0C12
        .word $00FF, $53FF, $3FFF, $033F, $02BF, $01BF, $00FF, $00FF

      rlUnknown9F9D10 ; 9F/9D10

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9F82D7

          .word $9D16

        rtl

        .databank 0

      procUnknown9F9D16 ; 9F/9D16

        .structProcInfo "ON", rlUnknown9F9D1E, rlUnknown9F9D38, aProcUnknown9F9DA4Code

      rlUnknown9F9D1E ; 9F/9D1E

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9F83F1
        jsr rsUnknown9F910A
        lda #$0000
        sta $7ECC06
        sta $7ECC08
        sta $7ECC0A
        sta $7ECC0C
        rtl


      rlUnknown9F9D38 ; 9F/9D38

        .al
        .xl
        .autsiz
        .databank ?
        jsr rsUnknown9F9116
        bcc _9D49
        lda #$9D4A
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0010
        sta aProcSystem.aBody0,b,x

        _9D49
        rtl


        _9D4A
        dec aProcSystem.aBody0,b,x
        bne _9D49
        jsr rsUnknown9F82D7

          .word $EC1C

        sta aProcSystem.aBody7,b,x
        jsr rsUnknown9F82D7

          .word $A139

        jsr rsUnknown9F830F

          .word $DBB8

        jsr rsUnknown9F830F

          .word $DC34

        jsr rsUnknown9F830F

          .word $DB6C

        jsr rsUnknown9F830F

          .word $DB7F

        jsr rsUnknown9F830F

          .word $A08E

        lda $7F509B
        and #$00FF
        jsr rsUnknown9F8253

          .byte $68

        lda #$9D87
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl


        _9D87
        lda $7ECC06
        beq _9DA2
        ldy aProcSystem.aBody7,b,x
        lda #$FFFC
        sta aProcSystem.aBody4,b,y
        lda #$9DA3
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$9DA6
        sta aProcSystem.aHeaderCodeOffset,b,x

        _9DA2
        rtl


        _9DA3
        rtl

        .databank 0

      aProcUnknown9F9DA4Code ; 9F/9DA4

        PROC_HALT

      aProcUnknown9F9DA6Code ; 9F/9DA6

        PROC_YIELD 1
        PROC_CALL_ARGS rlUnknown9F9DCC, 1
        .byte $2A
        PROC_YIELD 1
        PROC_CALL_ARGS rlUnknown9F9DCC, 1
        .byte $1C
        PROC_YIELD 1
        PROC_CALL_ARGS rlUnknown9F9DCC, 1
        .byte $0E
        PROC_YIELD 1
        PROC_CALL_ARGS rlUnknown9F9DCC, 1
        .byte $00
        PROC_HALT

      rlUnknown9F9DCC ; 9F/9DCC

        .al
        .xl
        .autsiz
        .databank ?

        lda $0000,b,y
        and #$00FF
        asl a
        tax
        lda $9E29,b,x
        sta $01D2,b
        lda $9E2B,b,x
        sta $01D4,b
        lda $9E2D,b,x
        sta $01D6,b
        lda $9E2F,b,x
        sta $01D8,b
        lda $9E31,b,x
        sta $01DA,b
        lda $9E33,b,x
        sta $01DC,b
        lda $9E35,b,x
        sta $01DE,b
        lda $9E99,b,x
        sta $01F2,b
        lda $9E9B,b,x
        sta $01F4,b
        lda $9E9D,b,x
        sta $01F6,b
        lda $9E9F,b,x

        _9E13
        sta $01F8,b
        lda $9EA1,b,x
        sta $01FA,b
        lda $9EA3,b,x
        sta $01FC,b
        lda $9EA5,b,x
        sta $01FE,b
        rtl

        .databank 0

      aUnknown9F9E29 ; 9F/9E29

        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0444, $0443, $0022, $0021, $0001, $0000, $0000
        .word $08A8, $0886, $0465, $0443, $0002, $0001, $0000
        .word $110D, $0CCA, $0888, $0465, $0004, $0001, $0000
        .word $1571, $110D, $0CCB, $0886, $0025, $0002, $0000
        .word $1DD6, $1551, $10EE, $08A8, $0027, $0002, $0000
        .word $223A, $1994, $1531, $0CCA, $0028, $0003, $0000
        .word $2A9F, $1DD8, $1974, $10EC, $004A, $0024, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $1020, $1020, $0C20, $0800, $0800, $0400, $0000
        .word $2060, $2040, $1840, $1420, $1000, $0C00, $0000
        .word $3480, $3080, $2860, $2020, $1C00, $1000, $0000
        .word $44C0, $40A0, $3480, $2840, $2420, $1800, $0000
        .word $58E0, $50E0, $44A0, $3440, $3020, $1C00, $0000
        .word $6920, $6100, $50C0, $4060, $3820, $2400, $0000
        .word $7D60, $7140, $60E0, $4C80, $4440, $2C00, $0000

      aUnknown9F9F09 ; 9F/9F09

        .word <>rlUnknown9F9F0F, <>rlUnknown9F9F38, <>aUnknown9F9FDE

      rlUnknown9F9F0F ; 9F/9F0F

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
        sta aActiveSpriteSystem.aUnknown001240,b,x
        lda #$0040
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        lda aActiveSpriteSystem.aUnknown001200,b,x
        jsr rsUnknown9F8253

          .byte $69

        rtl

        .databank 0

      rlUnknown9F9F38 ; 9F/9F38

        .al
        .xl
        .autsiz
        .databank ?

        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne rlUnknown9F9F79
        lda #$9F7A
        sta aActiveSpriteSystem.aOnCycle,b,x
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
        jsl rlUnknown9F89F8
        lsr a
        lsr a
        bne _9F68
        lda #$0002

        _9F68
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        lda wR0
        sta aActiveSpriteSystem.aUnknown0012E0,b,x
        lda #$0400
        sta aActiveSpriteSystem.aUnknown001300,b,x
        jsr rsUnknown9F9379

        .databank 0

      rlUnknown9F9F79 ; 9F/9F79

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .byte $22, $99, $89, $9F, $DE, $C0, $12, $D0, $0F, $A9, $93, $9F, $9D, $60, $11, $A9
        .byte $10, $00, $9D, $C0, $12, $9D, $20, $13, $6B, $DE, $C0, $12, $D0

        .databank 0

      rlUnknown9F9F97 ; 9F/9F97

        .al
        .xl
        .autsiz
        .databank ?

        ora (#169,s),y
        ora (wR0,x)
        sta aMapAction.wMapBattleActiveSpriteSyncFlag
        lda #$9FAC
        sta aActiveSpriteSystem.aOnCycle,b,x
        lda #$0008
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        rtl

        .byte $DE, $C0, $12

        .databank 0

      rlUnknown9F9FAF ; 9F/9FAF

        .al
        .xl
        .autsiz
        .databank ?

        bne _9FC1
        lda #$9FC2
        sta aActiveSpriteSystem.aOnCycle,b,x
        lda #$0010
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        sta $7ECC06

        _9FC1
        rtl

        .byte $DE, $C0

        .databank 0

      rlUnknown9F9FC4 ; 9F/9FC4

        .al
        .xl
        .autsiz
        .databank ?

        ora ($D0)
        asl $A9
        dec $9D9F,b
        rts

        .byte $11, $6B, $20


        _9FCF
        sta $0A9091,x
        stz aActiveSpriteSystem.aTypeOffset,b,x
        lda #$0001
        sta $7F5093
        rtl

        .databank 0

      aUnknown9F9FDE ; 9F/9FDE

        .byte $00, $04, $1D, $A0, $00, $04, $2E, $A0, $00, $04, $3F, $A0, $00, $04, $50, $A0
        .byte $00, $04, $61, $A0, $00, $03, $72, $A0, $00, $03, $79, $A0, $00, $03, $80, $A0
        .byte $00, $03, $87, $A0, $17, $0E, $A0, $F2, $9F, $00, $01, $1B, $A0, $15, $07, $A0

      rlUnknown9FA00E ; 9F/A00E

        .al
        .xl
        .autsiz
        .databank ?

        lda aActiveSpriteSystem.aUnknown001320,b,x
        bne _A018
        lda $0000,b,y
        tay
        rtl


        _A018
        inc y
        inc y
        rtl

        .databank 0

      aUnknown9FA01B ; 9F/A01B

        .word 0

      aUnknown9FA01D ; 9F/A01D

        _Sprites := [[(  -4,   14), $00, SpriteSmall, $001, 3, 6, false, false]]
        _Sprites ..= [[(  20,  -11), $00, SpriteSmall, $001, 3, 6, false, false]]
        _Sprites ..= [[( -28,  -11), $00, SpriteSmall, $001, 3, 6, false, false]]

        .structSpriteArray aUnknown9FA01D._Sprites

      aUnknown9FA02E ; 9F/A02E

        _Sprites := [[( -14,   11), $00, SpriteSmall, $002, 3, 6, false, false]]
        _Sprites ..= [[(  15,   -5), $00, SpriteSmall, $002, 3, 6, false, false]]
        _Sprites ..= [[( -25,  -16), $00, SpriteSmall, $002, 3, 6, false, false]]

        .structSpriteArray aUnknown9FA02E._Sprites

      aUnknown9FA03F ; 9F/A03F

        _Sprites := [[(   9,    2), $00, SpriteSmall, $010, 3, 6, false, false]]
        _Sprites ..= [[( -19,    3), $00, SpriteSmall, $010, 3, 6, false, false]]
        _Sprites ..= [[(  -5,  -16), $00, SpriteSmall, $010, 3, 6, false, false]]

        .structSpriteArray aUnknown9FA03F._Sprites

      aUnknown9FA050 ; 9F/A050

        _Sprites := [[(  -3,   10), $00, SpriteSmall, $012, 3, 6, false, false]]
        _Sprites ..= [[( -20,   -2), $00, SpriteSmall, $012, 3, 6, false, false]]
        _Sprites ..= [[(   3,  -13), $00, SpriteSmall, $012, 3, 6, false, false]]

        .structSpriteArray aUnknown9FA050._Sprites

      aUnknown9FA061 ; 9F/A061

        _Sprites := [[( -11,    6), $00, SpriteSmall, $010, 3, 6, false, true]]
        _Sprites ..= [[(   3,   -3), $00, SpriteSmall, $010, 3, 6, false, true]]
        _Sprites ..= [[( -14,   -9), $00, SpriteSmall, $010, 3, 6, false, true]]

        .structSpriteArray aUnknown9FA061._Sprites

      aUnknown9FA072 ; 9F/A072

        _Sprites := [[(  -8,  -10), $21, SpriteLarge, $006, 3, 6, false, true]]

        .structSpriteArray aUnknown9FA072._Sprites

      aUnknown9FA079 ; 9F/A079

        _Sprites := [[( -10,   -8), $21, SpriteLarge, $004, 3, 6, true, false]]

        .structSpriteArray aUnknown9FA079._Sprites

      aUnknown9FA080 ; 9F/A080

        _Sprites := [[(  -8,   -6), $21, SpriteLarge, $006, 3, 6, false, false]]

        .structSpriteArray aUnknown9FA080._Sprites

      aUnknown9FA087 ; 9F/A087

        _Sprites := [[(  -6,   -8), $21, SpriteLarge, $004, 3, 6, false, false]]

        .structSpriteArray aUnknown9FA087._Sprites

      aUnknown9FA08E .dstruct structHDMAIndirectEntryInfo, rlUnknown9FA09A, rlUnknown9FDB69, aHDMAUnknown9FDB6ACode, aUnknown9FDF58, PPU_REG_BASE + $0F, DMAP_HDMA_Setting(DMAP_CPUToIO, true, DMAP_Mode3), $7F ; 9F/A08E

      rlUnknown9FA09A ; 9F/A09A

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
        lda $7F508F
        and #$0400
        beq _A0BD
        lda #$DF65
        sta aHDMASystem.aOffset,b,x

        _A0BD
        lda #$0078
        sta $7F50D9
        lda #$0000
        sta $7F50DB
        lda $7F509B
        and #$00FF
        sta $7F50DF
        lda $7F509B
        and #$00FF
        sec
        sbc #$007C
        eor #$FFFF
        inc a
        sta wR0
        sta $7F50CD
        lda $7F509C
        and #$00FF
        sta $7F50E1
        lda $7F509C
        and #$00FF
        sec
        sbc #$0070
        eor #$FFFF
        inc a
        sta wR1
        sta $7F50CF
        lda #$7F54
        and #$01FF
        sta $2182,b
        lda #$546A
        sta $2181,b
        ldy #$00E0
        sep #$20

        _A11F
        lda wR0
        sta $2180,b
        lda wR0+1
        sta $2180,b
        lda wR1
        sta $2180,b
        lda wR1+1
        sta $2180,b
        dec y
        bne _A11F
        rep #$20
        rtl

        .databank 0

      procUnknown9FA139 ; 9F/A139

        .structProcInfo "ON", rlUnknown9FA141, $A15A, aProcUnknown9F805DCode

      rlUnknown9FA141 ; 9F/A141

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta aProcSystem.aBody0,b,x
        lda #$0200
        sta aProcSystem.aBody1,b,x
        lda #$2000
        sta aProcSystem.aBody2,b,x
        lda #$4000
        sta aProcSystem.aBody3,b,x
        rtl


        _A15A
        jsl rlUnknown9FA221
        lda $7F50CD
        and #$01FF
        sta wR4
        lda $7F50CF
        and #$01FF
        sta wR5
        lda #$7F54
        and #$01FF
        sta $2182,b
        lda #$546A
        sta $2181,b
        lda aProcSystem.aBody1,b,x
        clc
        adc #$0008
        sta aProcSystem.aBody1,b,x
        lda $1018,b,x
        and #$00FF
        sta wR2
        lda $0FD8,b,x
        and #$00FF
        sta wR0
        lda $1038,b,x
        and #$00FF
        sta wR3
        phx
        ldy #$00E0

        _A1A5
        lda wR3
        jsl rlUnknown9F8C05
        clc
        adc wR4
        sep #$20
        sta $2180,b
        stz $2180,b
        lda wR5
        sta $2180,b
        stz $2180,b
        lda wR0
        clc
        adc wR2
        sta wR0
        rep #$21
        txa
        adc #$0002
        tax
        dec y
        bne _A1A5
        plx
        bra _A1EE

        .byte $DA, $A0, $E0, $00, $E2, $20, $A5, $08, $8D, $80, $21, $9C, $80, $21, $A5, $0A
        .byte $8D, $80, $21, $9C, $80, $21, $88, $D0, $ED, $C2, $20, $FA


        _A1EE
        lda aProcSystem.aBody0,b,x
        clc
        adc aProcSystem.aBody1,b,x
        sta aProcSystem.aBody0,b,x
        lda aProcSystem.aBody3,b,x
        sec
        sbc #$0100
        bcs _A21D
        phx
        lda #(`aUnknown9F9F09)<<8
        sta lR44+1
        lda #<>aUnknown9F9F09
        sta lR44
        jsl rlActiveSpriteEngineCreateSpriteHighestSlot
        plx
        lda #$A221
        sta aProcSystem.aHeaderOnCycle,b,x
        stz aProcSystem.aBody4,b,x
        lda #$0000

        _A21D
        sta aProcSystem.aBody3,b,x
        rtl


      rlUnknown9FA221 ; 9F/A221

        .al
        .xl
        .autsiz
        .databank ?
        lda aProcSystem.aBody4,b,x
        and #$0003
        bne _A23B
        lda aProcSystem.aBody4,b,x
        and #$000C
        phx
        lsr a
        tax
        lda $A23F,b,x
        tax
        jsl rlUnknown9F8943
        plx

        _A23B
        inc aProcSystem.aBody4,b,x
        rtl

        .databank 0

      aUnknown9FA23F ; 9F/A23F

        .byte $47, $A2, $61, $A2, $7B, $A2, $95, $A2, $81, $AF, $A2, $9F, $04, $00, $EC, $5C
        .byte $81, $AF, $A2, $9F, $04, $00, $4F, $5D, $81, $AF, $A2, $9F, $04, $00, $F2, $5C
        .byte $FF, $FF, $81, $B3, $A2, $9F, $04, $00, $EC, $5C, $81, $B3, $A2, $9F, $04, $00
        .byte $4F, $5D, $81, $B3, $A2, $9F, $04, $00, $F2, $5C, $FF, $FF, $81, $B7, $A2, $9F
        .byte $04, $00, $EC, $5C, $81, $B7, $A2, $9F, $04, $00, $4F, $5D, $81, $B7, $A2, $9F
        .byte $04, $00, $F2, $5C, $FF, $FF, $81, $BB, $A2, $9F, $04, $00, $EC, $5C, $81, $BB
        .byte $A2, $9F, $04, $00, $4F, $5D, $81, $BB, $A2, $9F, $04, $00, $F2, $5C, $FF, $FF
        .byte $83, $3F, $93, $3F, $84, $3F, $94, $3F, $85, $3F, $95, $3F, $86, $3F, $96, $3F

      rlUnknown9FA2BF ; 9F/A2BF

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aUnknown9FA4FD)<<8
        sta lR44+1
        lda #<>aUnknown9FA4FD
        sta lR44
        jsl rlActiveSpriteEngineCreateSpriteLastSlot
        jsr rsUnknown9F82D7

          .word $A2D3

        rtl

        .databank 0

      procUnknown9FA2D3 ; 9F/A2D3

        .structProcInfo "ON", rlUnknown9FA2DB, rlUnknown9FA305, aProcUnknown9F805DCode

      rlUnknown9FA2DB ; 9F/A2DB

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9F83F1
        lda #$0020
        sta aProcSystem.aBody0,b,x
        stz aProcSystem.aBody2,b,x
        stz aProcSystem.aBody3,b,x
        jsr rsUnknown9F910A
        jsl rlUnknown9FA380
        lda #$0000
        sta $7ECC06
        sta $7ECC08
        sta $7ECC0A
        sta $7ECC0C
        rtl


      rlUnknown9FA305 ; 9F/A305

        .al
        .xl
        .autsiz
        .databank ?
        jsr rsUnknown9F9136
        bcc _A310
        lda #$A311
        sta aProcSystem.aHeaderOnCycle,b,x

        _A310
        rtl


        _A311
        lda $7ECC06
        cmp #$0001
        bne _A310
        jsr rsUnknown9F82D7

          .word $EC49

        jsr rsUnknown9F830F

          .word $DBB8

        jsr rsUnknown9F830F

          .word $DBF1

        jsr rsUnknown9F830F

          .word $DB6C

        jsr rsUnknown9F830F

          .word $DB7F

        jsr rsUnknown9F830F

          .word $DC77

        lda #$A345
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$001E
        sta aProcSystem.aBody0,b,x
        rtl


        _A345
        jsr rsUnknown9F827A
        jsl rlUnknown9FA380
        dec aProcSystem.aBody0,b,x
        bne _A35D
        lda #$0010
        sta aProcSystem.aBody0,b,x
        lda #$A35E
        sta aProcSystem.aHeaderOnCycle,b,x

        _A35D
        rtl


        _A35E
        jsr rsUnknown9F827A
        jsl rlUnknown9FA380
        dec aProcSystem.aBody0,b,x
        bne _A377
        lda #$0001
        sta aMapAction.wMapBattleActiveSpriteSyncFlag
        lda #$A378
        sta aProcSystem.aHeaderOnCycle,b,x

        _A377
        rtl


        _A378
        jsr rsUnknown9F827A
        jsl rlUnknown9FA380
        rtl


      rlUnknown9FA380 ; 9F/A380

        .al
        .xl
        .autsiz
        .databank ?
        lda aProcSystem.aBody2,b,x
        beq _A38A
        dec a
        sta aProcSystem.aBody2,b,x
        rtl


        _A38A
        lda #$0003
        sta aProcSystem.aBody2,b,x
        phx
        lda aProcSystem.aBody3,b,x
        inc a
        sta aProcSystem.aBody3,b,x
        dec a
        asl a
        asl a
        asl a
        asl a
        tax
        lda $A3DB,b,x
        cmp #$FFFF
        beq _A3CF
        sta $01D2,b
        lda $A3DD,b,x
        sta $01D4,b
        lda $A3DF,b,x
        sta $01D6,b
        lda $A3E1,b,x
        sta $01D8,b
        lda $A3E3,b,x
        sta $01DA,b
        lda $A3E5,b,x
        sta $01DC,b
        lda $A3E7,b,x
        sta $01DE,b
        plx
        rtl


        _A3CF
        plx
        stz aProcSystem.aHeaderTypeOffset,b,x
        lda #$0001
        sta $7ECC08
        rtl

        .databank 0

      aUnknown9FA3DB ; 9F/A3DB

        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $A4FB
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $A4FB
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $A4FB
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $A4FB
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $A4FB
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $A4FB
        .word $0000, $0000, $0005, $000A, $000E, $0012, $0015, $A4FB
        .word $0006, $000A, $000E, $0012, $0015, $0019, $001C, $A4FB
        .word $000C, $0010, $0017, $015D, $021F, $02BF, $02FF, $A4FB
        .word $0000, $0000, $0006, $000A, $000E, $0012, $0015, $A4FB
        .word $0000, $0000, $0005, $000A, $000E, $0012, $0015, $A4FB
        .word $0000, $0000, $0000, $0000, $0005, $000A, $000E, $A4FB
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $A4FB
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $A4FB
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $A4FB
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $A4FB
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $A4FB
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $A4FB
        .word $FFFF

      aUnknown9FA4FD ; 9F/A4FD

        .word <>rlUnknown9FA503, <>rlUnknown9FA527, <>aUnknown9FA563

      rlUnknown9FA503 ; 9F/A503

        .al
        .xl
        .autsiz
        .databank ?

        ; WARNING: a branch or jump leads into the middle of an instruction at $9FA536
        lda $7F509F
        sta aActiveSpriteSystem.aUnknown001260,b,x
        lda $7F509B
        and #$00FF
        sta aActiveSpriteSystem.aUnknown001200,b,x
        jsr rsUnknown9F8253

          .byte $53

        lda $7F509C
        clc
        adc #$0002
        and #$00FF
        sta aActiveSpriteSystem.aUnknown001240,b,x
        rtl


      rlUnknown9FA527 ; 9F/A527

        .al
        .xl
        .autsiz
        .databank ?
        lda $7ECC06
        cmp #$0002
        beq _A531
        rtl


        _A531
        lda #$A537
        sta aActiveSpriteSystem.aOnCycle,b,x
        jsr rsUnknown9F919F
        bcc _A546
        lda #$0001
        sta $7F5093
        stz aActiveSpriteSystem.aTypeOffset,b,x

        _A546
        rtl

        .databank 0

      aUnknown9FA547 ; 9F/A547

        .word 0

      aUnknown9FA549 ; 9F/A549

        _Sprites := [[(  -4,    0), $00, SpriteSmall, $010, 2, 6, false, false]]

        .structSpriteArray aUnknown9FA549._Sprites

      aUnknown9FA550 ; 9F/A550

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $001, 2, 6, false, false]]

        .structSpriteArray aUnknown9FA550._Sprites

      aUnknown9FA557 ; 9F/A557

        _Sprites := [[(   0,   -7), $21, SpriteLarge, $003, 2, 6, true, false]]
        _Sprites ..= [[( -16,   -7), $21, SpriteLarge, $003, 2, 6, false, false]]

        .structSpriteArray aUnknown9FA557._Sprites

      aUnknown9FA563 ; 9F/A563

        .byte $00, $08, $49, $A5, $00, $08, $50, $A5, $00, $02, $57, $A5, $17, $9B, $A5, $00
        .byte $01, $57, $A5, $17, $8D, $A5, $72, $A5, $00, $08, $50, $A5, $00, $08, $49, $A5
        .byte $17, $A3, $A5

      rlUnknown9FA586 ; 9F/A586

        .al
        .xl
        .autsiz
        .databank ?

        .byte $00 ; brk
        ora (wR31+1,x)
        lda wR10+1
        stx $A5
        lda $7ECC08
        beq _A596
        inc y
        inc y
        rtl


        _A596
        lda $0000,b,y
        tay
        rtl


      rlUnknown9FA59B ; 9F/A59B

        .al
        .xl
        .autsiz
        .databank ?
        lda #$0001
        sta $7ECC06
        rtl


      rlUnknown9FA5A3 ; 9F/A5A3

        .al
        .xl
        .autsiz
        .databank ?
        lda #$0002
        sta $7ECC06
        rtl

        .databank 0

      rlUnknown9FA5AB ; 9F/A5AB

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9F82D7

          .word $A5B1

        rtl

        .databank 0

      procUnknown9FA5B1 ; 9F/A5B1

        .structProcInfo "ON", rlUnknown9FA5B9, rlUnknown9FA5C0, aProcUnknown9F805DCode

      rlUnknown9FA5B9 ; 9F/A5B9

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9F83F1
        jsr rsUnknown9F910A
        rtl


      rlUnknown9FA5C0 ; 9F/A5C0

        .al
        .xl
        .autsiz
        .databank ?
        jsr rsUnknown9F9116
        bcc _A602
        lda #$A603
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0020
        sta aProcSystem.aBody0,b,x
        jsr rsUnknown9F82D7

          .word $EC3A

        sta aProcSystem.aBody7,b,x
        jsr rsUnknown9F830F

          .word $DBB8

        jsr rsUnknown9F830F

          .word $DC34

        jsr rsUnknown9F830F

          .word $DB6C

        jsr rsUnknown9F830F

          .word $DB7F

        jsr rsUnknown9F830F

          .word $E378

        jsr rsUnknown9F830F

          .word $E2D9

        lda $7F509B
        and #$00FF
        jsr rsUnknown9F8253

          .byte $58


        _A602
        rtl


        _A603
        dec aProcSystem.aBody0,b,x
        bne _A614
        lda #$A615
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0020
        sta aProcSystem.aBody0,b,x

        _A614
        rtl


        _A615
        dec aProcSystem.aBody0,b,x
        bne _A64C
        lda #$0001
        sta aMapAction.wMapBattleActiveSpriteSyncFlag
        lda #$A62E
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$000E
        sta aProcSystem.aBody0,b,x
        rtl


        _A62E
        dec aProcSystem.aBody0,b,x
        bne _A64C
        lda #$A64D
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0016
        sta aProcSystem.aBody0,b,x
        ldy aProcSystem.aBody7,b,x
        lda aProcSystem.aBody4,b,y
        eor #$FFFF
        inc a
        sta aProcSystem.aBody4,b,y

        _A64C
        rtl


        _A64D
        dec aProcSystem.aBody0,b,x
        bne _A658
        lda #$A659
        sta aProcSystem.aHeaderOnCycle,b,x

        _A658
        rtl


        _A659
        jsr rsUnknown9F919F
        bcc _A66B
        lda #$A66B
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0001
        sta $7F5093

        _A66B
        rtl

        .databank 0

      rlUnknown9FA66C ; 9F/A66C

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9F82D7

          .word $A678

        rtl

        .databank 0

      rlUnknown9FA672 ; 9F/A672

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9F82D7

          .word $A682

        rtl

        .databank 0

      procUnknown9FA678 ; 9F/A678

        .structProcInfo "ON", rlUnknown9FA68C, rlUnknown9FA693, aProcUnknown9F805DCode
        .word <>aUnknown9FA6CB

      procUnknown9FA682 ; 9F/A682

        .structProcInfo "ON", rlUnknown9FA68C, rlUnknown9FA693, aProcUnknown9F805DCode
        .word <>aUnknown9FA6D1

      rlUnknown9FA68C ; 9F/A68C

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9F83F1
        jsr rsUnknown9F910A
        rtl


      rlUnknown9FA693 ; 9F/A693

        .al
        .xl
        .autsiz
        .databank ?
        jsr rsUnknown9F9116
        bcc _A6CA
        lda $0EF6,b,x
        sta lR44+1
        ldy aProcSystem.aHeaderTypeOffset,b,x
        lda $0008,b,y
        sta lR44
        lda #$A6CA
        sta aProcSystem.aHeaderOnCycle,b,x
        phx
        phy
        lda $7F509A
        sec
        sbc #$0008
        and #$00FF
        tay
        lda $7F5099
        and #$00FF
        tax
        jsl rlActiveSpriteEngineCreateSpriteHighestSlot
        ply
        plx
        stz aProcSystem.aHeaderTypeOffset,b,x

        _A6CA
        rtl

        .databank 0

      aUnknown9FA6CB ; 9F/A6CB
        .word $A6FF, $A8EB, $A972

      aUnknown9FA6D1 ; 9F/A6D1
        .word $A6EF, $A77A, $A8BC

      aUnknown9FA6D7 ; 9F/A6D7
        .word $A71B, $A77A, $A8C8

      aUnknown9FA6DD ; 9F/A6DD
        .word $A71B, $A79B, $A8C8

      aUnknown9FA6E3 ; 9F/A6E3
        .word $A71B, $A7BC, $A8D6

      aUnknown9FA6E9 ; 9F/A6E9
        .word $A729, $A74B, $A967

      rlUnknown9FA6EF ; 9F/A6EF

        .al
        .xl
        .autsiz
        .databank ?

        ; WARNING: a branch or jump leads into the middle of an instruction at $9FA800
        ; WARNING: a branch or jump leads into the middle of an instruction at $9FA7CE
        ; WARNING: a branch or jump leads into the middle of an instruction at $9FA71E
        lda $7F5099
        and #$00FF
        sta aActiveSpriteSystem.aUnknown001200,b,x
        jsr rsUnknown9F8253

          .byte $56

        bra _A70D


        _A6FF
        lda $7F5099
        and #$00FF
        sta aActiveSpriteSystem.aUnknown001200,b,x
        jsr rsUnknown9F8253

          .byte $54


        _A70D
        lda $7F509A
        and #$00FF
        sec
        sbc #$0010
        sta aActiveSpriteSystem.aUnknown001240,b,x
        lda $7F509F
        sta aActiveSpriteSystem.aUnknown001260,b,x
        lda #$0004
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        rtl

        .byte $AF, $9F, $50, $7F, $9D, $60, $12, $AF, $9B, $50, $7F, $29, $FF, $00, $9D, $00
        .byte $12, $AF, $9C, $50, $7F, $29, $FF, $00, $9D, $40, $12, $9E, $20, $13, $9E, $40
        .byte $13, $6B


        _A74B
        jsl rlUnknown9FAACC
        bcc _A779
        lda #$000C
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        lda #$A75E
        sta aActiveSpriteSystem.aOnCycle,b,x
        rtl

        .byte $DE, $C0, $12, $D0, $16, $A9, $6A, $A7, $9D, $60, $11, $6B, $20, $9F, $91, $90
        .byte $0A, $9E, $00, $11, $A9, $01, $00, $8F, $93, $50, $7F


        _A779
        rtl


        _A77A
        lda aActiveSpriteSystem.aUnknown001320,b,x
        beq _A79A
        stz aActiveSpriteSystem.aUnknown001320,b,x
        jsr _A7F6
        lda #$A792
        sta aActiveSpriteSystem.aOnCycle,b,x
        lda #$0040
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        rtl

        .byte $DE, $C0, $12, $D0, $03, $9E, $00, $11


        _A79A
        rtl


        _A79B
        lda aActiveSpriteSystem.aUnknown001320,b,x
        beq _A7BB
        stz aActiveSpriteSystem.aUnknown001320,b,x
        lda #$A7B0
        sta aActiveSpriteSystem.aOnCycle,b,x
        lda #$0040
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        rtl

        .byte $DE, $C0, $12, $D0, $06, $20, $43, $A8, $9E, $00, $11


        _A7BB
        rtl


        _A7BC
        lda aActiveSpriteSystem.aUnknown001320,b,x
        beq _A7F5
        stz aActiveSpriteSystem.aUnknown001320,b,x
        jsr _A86B
        lda #$A7D4
        sta aActiveSpriteSystem.aOnCycle,b,x
        lda #$003C
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        rtl

        .byte $DE, $C0, $12, $D0, $13, $A9, $01, $00, $8F, $80, $45, $7F, $A9, $ED, $A7, $9D
        .byte $60, $11, $A9, $04, $00


        _A7E9
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        rtl

        .byte $DE, $C0, $12, $D0, $03, $9E, $00, $11


        _A7F5
        rtl


        _A7F6
        phx
        phy
        lda aActiveSpriteSystem.aUnknown001240,b,x
        sec
        sbc #$0030
        bpl _A809
        clc
        adc #$0018
        bpl _A826
        bra _A826


        _A809
        clc
        adc #$0018
        tay
        lda aActiveSpriteSystem.aUnknown001200,b,x
        and #$00FF
        tax
        lda #(`aUnknown9FA6D7)<<8
        sta lR44+1
        lda #<>aUnknown9FA6D7
        sta lR44
        jsl rlActiveSpriteEngineCreateSpriteHighestSlot
        ply
        plx
        rts


        _A826
        clc
        adc #$0018
        tay
        lda aActiveSpriteSystem.aUnknown001200,b,x
        and #$00FF
        tax
        lda #(`aUnknown9FA6DD)<<8
        sta lR44+1
        lda #<>aUnknown9FA6DD
        sta lR44
        jsl rlActiveSpriteEngineCreateSpriteHighestSlot
        ply
        plx
        rts


        _A843
        phx
        phy
        lda $7F509C
        and #$0008
        sec
        sbc #$0020
        tay
        lda $7F509B
        and #$00FF
        tax
        lda #(`aUnknown9FA6E3)<<8
        sta lR44+1
        lda #<>aUnknown9FA6E3
        sta lR44
        jsl rlActiveSpriteEngineCreateSpriteHighestSlot
        ply
        plx
        clc
        rts


        _A86B
        phx
        phy
        lda $7F509C
        and #$00FF
        sec
        sbc #$0018
        sta wR0
        lda aActiveSpriteSystem.aUnknown001240,b,x
        clc
        adc #$0018
        cmp wR0
        bpl _A8A0
        tay
        lda $7F509B
        and #$00FF
        tax
        lda #(`aUnknown9FA6E3)<<8
        sta lR44+1
        lda #<>aUnknown9FA6E3
        sta lR44
        jsl rlActiveSpriteEngineCreateSpriteHighestSlot
        ply
        plx
        clc
        rts


        _A8A0
        lda aActiveSpriteSystem.aUnknown001200,b,x
        jsr rsUnknown9F8253

          .byte $57

        jsr rlUnknown9FAA16
        lda #(`aUnknown9FA6E9)<<8
        sta lR44+1
        lda #<>aUnknown9FA6E9
        sta lR44
        jsl rlActiveSpriteEngineCreateSpriteHighestSlot
        ply
        plx
        sec
        rts

        .databank 0

      aUnknown9FA8BC ; 9F/A8BC

        .byte $00, $01, $39, $AA, $00, $01, $40, $AA, $00, $01, $4C, $AA, $17, $E4, $A8, $00
        .byte $01, $5D, $AA, $00, $01, $6E, $AA, $15, $CB, $A8, $17, $E4, $A8, $00, $01, $A3
        .byte $AA, $00, $01

      aUnknown9FA8DF ; 9F/A8DF

        .word <>$AAB4, <>$D915, <>$A9A8

      rlUnknown9FA8E5 ; 9F/A8E5

        .al
        .xl
        .autsiz
        .databank ?

        ; WARNING: a branch or jump leads into the middle of an instruction at $9FA935
        ora (wR0,x)
        sta aActiveSpriteSystem.aUnknown001320,b,x
        rtl

        .byte $BD, $40, $12, $C9, $0A, $00, $10, $24, $A9, $01, $00, $9D, $A0, $13, $AF, $9B
        .byte $50, $7F, $29, $FF, $00, $9D, $00, $12, $AF, $9C, $50, $7F, $29, $1F, $00, $38
        .byte $E9, $20, $00, $9D, $40, $12, $A9, $17


        _A913
        lda #$609D
        ora (lR47+1),y
        lda aActiveSpriteSystem.aUnknown001200,b,x
        jsr rsUnknown9F8253

          .byte $55

        lda #$0020
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        lda #$0002
        sta aActiveSpriteSystem.aUnknown0013A0,b,x
        stz aActiveSpriteSystem.aUnknown001320,b,x
        stz aActiveSpriteSystem.aUnknown001340,b,x
        lda #$A938
        sta aActiveSpriteSystem.aOnCycle,b,x
        rtl

        .byte $DE, $C0, $12, $D0, $0D, $A9, $4A, $A9, $9D, $60, $11, $A9, $01, $00, $8F, $80
        .byte $45, $7F, $22, $CC, $AA, $9F, $90, $16, $A9, $57, $A9, $9D, $60, $11


        _A956
        rtl


        _A957
        jsr rsUnknown9F919F
        bcc _A966
        stz aActiveSpriteSystem.aTypeOffset,b,x
        lda #$0001
        sta $7F5093

        _A966
        rtl

        .databank 0

      aUnknown9FA967 ; 9F/A967

        .byte $00, $40, $C5, $AA, $00, $01, $37, $AA, $15, $6B, $A9, $00, $01, $39, $AA, $00
        .byte $01, $40, $AA, $00, $01, $4C, $AA, $00, $01, $5D, $AA, $19, $00, $F6, $00, $01
        .byte $6E, $AA, $19, $00, $F6, $17, $F7, $A9, $7E, $A9, $17, $12, $AA, $00, $1D, $37
        .byte $AA, $00, $01, $92, $AA, $17, $C1, $A9, $B6, $A9, $00, $01, $A3, $AA, $17, $C1
        .byte $A9, $B6, $A9, $00, $01, $B4, $AA, $17, $C1, $A9, $B6, $A9, $15, $98, $A9, $00
        .byte $04, $C5, $AA, $00, $01, $37, $AA, $15, $BA, $A9

      rlUnknown9FA9C1 ; 9F/A9C1

        .al
        .xl
        .autsiz
        .databank ?

        ; WARNING: a branch or jump leads into the middle of an instruction at $9FA9EA
        lda $7F509C
        and #$00FF
        sec
        sbc #$0018
        sta wR0
        lda #$0010
        clc
        adc aActiveSpriteSystem.aUnknown001240,b,x
        sta aActiveSpriteSystem.aUnknown001240,b,x
        cmp wR0
        bmi _A9F4
        jsr rlUnknown9FAA16
        lda $7F509C
        and #$00FF
        sta aActiveSpriteSystem.aUnknown001240,b,x
        lda #$A918
        sta aActiveSpriteSystem.aOnCycle,b,x

        _A9EF
        lda $0000,b,y
        tay
        rtl


        _A9F4
        inc y
        inc y

        _A9F6
        rtl

        .byte $BD, $A0, $13, $C9, $01, $00, $D0, $0E, $C8, $C8, $6B, $BD, $A0, $13, $C9, $02
        .byte $00, $D0, $03, $C8, $C8, $6B, $B9, $00, $00, $A8, $6B


        _AA12
        stz aActiveSpriteSystem.aUnknown0013A0,b,x
        rtl


      rlUnknown9FAA16 ; 9F/AA16

        .al
        .xl
        .autsiz
        .databank ?
        phy
        jsr rsUnknown9F82D7

          .word $EBE7

        jsr rsUnknown9F830F

          .word $DBB8

        jsr rsUnknown9F830F

          .word $DBF1

        jsr rsUnknown9F830F

          .word $DB6C

        jsr rsUnknown9F830F

          .word $DB7F

        jsr rsUnknown9F830F

          .word $DC77

        ply
        rts

        .databank 0

      aUnknown9FAA37 ; 9F/AA37

        .word 0

      aUnknown9FAA39 ; 9F/AA39

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $000, 2, 6, false, false]]

        .structSpriteArray aUnknown9FAA39._Sprites

      aUnknown9FAA40 ; 9F/AA40

        _Sprites := [[(  -8,  -24), $21, SpriteLarge, $006, 2, 6, false, false]]
        _Sprites ..= [[(  -8,   -8), $21, SpriteLarge, $002, 2, 6, false, false]]

        .structSpriteArray aUnknown9FAA40._Sprites

      aUnknown9FAA4C ; 9F/AA4C

        _Sprites := [[(  -8,  -40), $21, SpriteLarge, $002, 2, 6, false, false]]
        _Sprites ..= [[(  -8,  -24), $21, SpriteLarge, $004, 2, 6, false, false]]
        _Sprites ..= [[(  -8,   -8), $21, SpriteLarge, $006, 2, 6, false, false]]

        .structSpriteArray aUnknown9FAA4C._Sprites

      aUnknown9FAA5D ; 9F/AA5D

        _Sprites := [[(  -8,  -40), $21, SpriteLarge, $000, 2, 6, true, false]]
        _Sprites ..= [[(  -8,  -24), $21, SpriteLarge, $006, 2, 6, false, false]]
        _Sprites ..= [[(  -8,   -8), $21, SpriteLarge, $004, 2, 6, false, false]]

        .structSpriteArray aUnknown9FAA5D._Sprites

      aUnknown9FAA6E ; 9F/AA6E

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $000, 2, 6, false, false]]
        _Sprites ..= [[(  -8,  -24), $21, SpriteLarge, $002, 2, 6, false, false]]
        _Sprites ..= [[(  -8,  -40), $21, SpriteLarge, $006, 2, 6, true, false]]

        .structSpriteArray aUnknown9FAA6E._Sprites

      aUnknown9FAA7F ; 9F/AA7F

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $002, 2, 6, false, true]]

        .structSpriteArray aUnknown9FAA7F._Sprites

      aUnknown9FAA86 ; 9F/AA86

        _Sprites := [[(  -8,    8), $21, SpriteLarge, $000, 2, 6, false, true]]
        _Sprites ..= [[(  -8,   -8), $21, SpriteLarge, $006, 2, 6, true, false]]

        .structSpriteArray aUnknown9FAA86._Sprites

      aUnknown9FAA92 ; 9F/AA92

        _Sprites := [[(  -8,   24), $21, SpriteLarge, $004, 2, 6, false, true]]
        _Sprites ..= [[(  -8,    8), $21, SpriteLarge, $002, 2, 6, false, true]]
        _Sprites ..= [[(  -8,   -8), $21, SpriteLarge, $000, 2, 6, false, false]]

        .structSpriteArray aUnknown9FAA92._Sprites

      aUnknown9FAAA3 ; 9F/AAA3

        _Sprites := [[(  -8,   24), $21, SpriteLarge, $006, 2, 6, false, true]]
        _Sprites ..= [[(  -8,    8), $21, SpriteLarge, $002, 2, 6, true, true]]
        _Sprites ..= [[(  -8,   -8), $21, SpriteLarge, $002, 2, 6, false, true]]

        .structSpriteArray aUnknown9FAAA3._Sprites

      aUnknown9FAAB4 ; 9F/AAB4

        _Sprites := [[(  -8,   24), $21, SpriteLarge, $002, 2, 6, false, true]]
        _Sprites ..= [[(  -8,    8), $21, SpriteLarge, $006, 2, 6, false, false]]
        _Sprites ..= [[(  -8,   -8), $21, SpriteLarge, $004, 2, 6, false, true]]

        .structSpriteArray aUnknown9FAAB4._Sprites

      aUnknown9FAAC5 ; 9F/AAC5

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $00A, 2, 6, false, false]]

        .structSpriteArray aUnknown9FAAC5._Sprites

      rlUnknown9FAACC ; 9F/AACC

        .al
        .xl
        .autsiz
        .databank ?

        lda aActiveSpriteSystem.aUnknown001320,b,x
        beq _AAD7
        dec a
        sta aActiveSpriteSystem.aUnknown001320,b,x

        _AAD5
        clc
        rtl


        _AAD7
        txy
        phx
        lda aActiveSpriteSystem.aUnknown001340,b,x
        inc a
        sta aActiveSpriteSystem.aUnknown001340,b,x
        dec a
        asl a
        asl a
        asl a
        asl a
        tax
        lda $AB29,b,x
        cmp #$FFFF
        beq _AB26
        sta aActiveSpriteSystem.aUnknown001320,b,y
        inc x
        inc x
        lda $AB29,b,x
        sta $01D2,b
        lda $AB2B,b,x
        sta $01D4,b
        lda $AB2D,b,x
        sta $01D6,b
        lda $AB2F,b,x
        sta $01D8,b
        lda $AB31,b,x
        sta $01DA,b
        lda $AB33,b,x
        sta $01DC,b
        lda $AB35,b,x
        sta $01DE,b
        lda $AB37,b,x
        sta aBGPaletteBuffer.aPalette7,b
        plx
        clc
        rtl


        _AB26
        plx
        sec
        rtl

        .databank 0

      aUnknown9FAB29 ; 9F/AB29

        .word $0002, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0002, $0000, $0000, $0000, $0000, $0000, $0000, $0400
        .word $0002, $0000, $0000, $0000, $0000, $0000, $0000, $0820
        .word $0002, $0000, $0000, $0000, $0000, $0000, $0000, $1060
        .word $0002, $0000, $0000, $0000, $0000, $0000, $18A0, $20C0
        .word $0002, $0000, $0000, $0000, $18A0, $20C0, $2D20, $3540
        .word $0003, $0000, $18A0, $20C0, $2D20, $3540, $3D80, $49A0
        .word $0002, $0000, $0000, $0000, $18A0, $20C0, $2D20, $3540
        .word $0002, $1800, $20C0, $2D20, $3540, $49A0, $5E20, $6E80
        .word $0002, $0000, $0000, $0000, $18A0, $20C0, $2D20, $3540
        .word $0003, $1800, $20C0, $2D20, $3540, $49A0, $5E20, $6E80
        .word $0002, $0000, $0000, $0000, $18A0, $20C0, $2D20, $3540
        .word $0003, $0000, $18A0, $20C0, $2D20, $3540, $3D80, $49A0
        .word $0003, $0820, $0000, $1060, $18A0, $20C0, $2D20, $3540
        .word $0003, $0000, $0000, $0000, $1060, $18A0, $20C0, $2D20
        .word $0003, $0000, $0000, $0000, $0000, $1060, $18A0, $20C0
        .word $0003, $0000, $0400, $0000, $0000, $0000, $1060, $1060
        .word $0003, $0000, $0000, $0000, $0800, $0800, $0000, $1060
        .word $0003, $0000, $0000, $0000, $0400, $0000, $0000, $0400
        .word $FFFF

      rlUnknown9FAC5B ; 9F/AC5B

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9F82D7

          .word $AC61

        rtl

        .databank 0

      procUnknown9FAC61 ; 9F/AC61

        .structProcInfo "ON", rlUnknown9FAC74, rlUnknown9FAC81, aProcUnknown9FAC69Code

      aProcUnknown9FAC69Code ; 9F/AC69

        PROC_YIELD 1
        PROC_CALL rlUnknown9FACE3
        PROC_JUMP aProcUnknown9FAC69Code

      rlUnknown9FAC74 ; 9F/AC74

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9F83F1
        jsr rsUnknown9F910A
        stz aProcSystem.aBody2,b,x
        stz aProcSystem.aBody3,b,x
        rtl


      rlUnknown9FAC81 ; 9F/AC81

        .al
        .xl
        .autsiz
        .databank ?
        jsr rsUnknown9F9116
        bcc _ACC8
        jsr rsUnknown9F82D7

          .word $EBD8

        sta aProcSystem.aBody7,b,x
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

        lda #$ACC9
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0078
        sta aProcSystem.aBody0,b,x
        lda #$0080
        jsr rsUnknown9F8253

          .byte $59

        lda #(`aUnknown9FAD72)<<8
        sta lR44+1
        lda #<>aUnknown9FAD72
        sta lR44
        jsl rlActiveSpriteEngineCreateSpriteHighestSlot

        _ACC8
        rtl


        _ACC9
        dec aProcSystem.aBody0,b,x
        bne _ACE1
        ldy aProcSystem.aBody7,b,x
        lda aProcSystem.aBody4,b,y
        eor #$FFFF
        inc a
        sta aProcSystem.aBody4,b,y
        lda #$ACE2
        sta aProcSystem.aHeaderOnCycle,b,x

        _ACE1
        rtl


        _ACE2
        rtl


      rlUnknown9FACE3 ; 9F/ACE3

        .al
        .xl
        .autsiz
        .databank ?
        lda aProcSystem.aBody2,b,x
        beq _ACED
        dec a
        sta aProcSystem.aBody2,b,x
        rtl


        _ACED
        lda #$0001
        sta aProcSystem.aBody2,b,x
        phx
        lda aProcSystem.aBody3,b,x
        inc a
        and #$000F
        sta aProcSystem.aBody3,b,x
        asl a
        tax
        lda $AD32,b,x
        sta $01D2,b
        lda $AD34,b,x
        sta $01D4,b
        lda $AD36,b,x
        sta $01D6,b
        lda $AD38,b,x
        sta $01D8,b
        lda $AD3A,b,x
        sta $01DA,b
        lda $AD3C,b,x
        sta $01DC,b
        lda $AD3E,b,x
        sta $01DE,b
        lda $AD40,b,x
        sta aBGPaletteBuffer.aPalette7,b
        plx
        rtl

        .databank 0

      aUnknown9FAD32 ; 9F/AD32

        .word $015F, $02FF, $03FF, $7FFF, $7FFF, $03FA, $03E0, $0260
        .word $015F, $02FF, $03FF, $7FFF, $7FFF, $03FA, $03E0, $0260
        .word $015F, $02FF, $03FF, $7FFF, $7FFF, $03FA, $03E0, $0260
        .word $015F, $02FF, $03FF, $7FFF, $7FFF, $03FA, $03E0, $0260

      aUnknown9FAD72 ; 9F/AD72

        .word <>rlUnknown9FAD78, <>$ADA3, <>aUnknown9FAE9C

      rlUnknown9FAD78 ; 9F/AD78

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F509F
        sta aActiveSpriteSystem.aUnknown001260,b,x
        lda $7F509B
        and #$00FF
        sta aActiveSpriteSystem.aUnknown001200,b,x
        lda $7F509C
        and #$00FF
        sta aActiveSpriteSystem.aUnknown001240,b,x
        stz aActiveSpriteSystem.aUnknown0013E0,b,x
        stz aActiveSpriteSystem.aUnknown0013C0,b,x
        lda #$0028
        sta aActiveSpriteSystem.aUnknown0012C0,b,x

        _AD9F
        jml rlUnknown9FAE19

        .byte $22, $19, $AE, $9F, $DE, $C0, $12, $D0, $6C, $A9, $B9, $AD, $9D, $60, $11, $A9
        .byte $20, $00, $9D, $C0, $12


        _ADB8
        rtl

        .byte $22, $19, $AE, $9F, $DE, $C0, $12, $D0, $56, $A9, $01, $00, $8F, $80, $45, $7F
        .byte $A9, $D6, $AD, $9D, $60, $11, $A9, $18, $00, $9D, $C0, $12, $6B, $22, $19, $AE
        .byte $9F


        _ADDA
        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne _AE18
        lda #$0001
        sta aActiveSpriteSystem.aUnknown0013A0,b,x
        lda #$ADF2
        sta aActiveSpriteSystem.aOnCycle,b,x
        lda #$0028
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        rtl


        _ADF2
        jsl rlUnknown9FAE19
        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne _AE18
        lda #$AE05
        sta aActiveSpriteSystem.aOnCycle,b,x
        jsr rsUnknown9F8359
        rtl

        .byte $22, $19, $AE, $9F, $20, $9F, $91, $90, $0A, $9E, $00, $11, $A9, $01, $00, $8F
        .byte $93, $50, $7F


        _AE18
        rtl


      rlUnknown9FAE19 ; 9F/AE19

        .al
        .xl
        .autsiz
        .databank ?
        lda aActiveSpriteSystem.aUnknown001360,b,x
        beq _AE23
        dec a
        sta aActiveSpriteSystem.aUnknown001360,b,x
        rtl


        _AE23
        lda #$0002
        sta aActiveSpriteSystem.aUnknown001360,b,x
        phx
        lda aActiveSpriteSystem.aUnknown001380,b,x
        inc a
        and #$000F
        sta aActiveSpriteSystem.aUnknown001380,b,x
        asl a
        tax
        lda $AE5C,b,x
        sta $02C4,b
        lda $AE5E,b,x
        sta $02C6,b
        lda $AE60,b,x
        sta $02C8,b
        lda $AE62,b,x
        sta $02CA,b
        lda $AE64,b,x
        sta $02CC,b
        lda $AE66,b,x
        sta $02CE,b
        plx
        rtl

        .databank 0

      aUnknown9FAE5C ; 9F/AE5C

        .word $65FC, $6A3C, $6E7D, $6EBD, $72FE, $773E, $7B7E, $7BBF
        .word $7FFF, $7BBF, $7B7E, $773E, $72FE, $6EBD, $6E7D, $6A3C
        .word $65FC, $6A3C, $6E7D, $6EBD, $72FE, $773E, $7B7E, $7BBF
        .word $7FFF, $7BBF, $7B7E, $773E, $72FE, $6EBD, $6E7D, $6A3C

      aUnknown9FAE9C ; 9F/AE9C

        .byte $00, $08, $EA, $AE, $00, $08, $F1, $AE, $00, $08, $F8, $AE, $00, $08, $FF, $AE
        .byte $00, $03, $06, $AF, $00, $03, $0D, $AF, $00, $03, $14, $AF, $00, $03, $1B, $AF
        .byte $17, $D8, $AE, $AC, $AE, $00, $03, $FF, $AE, $00, $03, $F8, $AE, $00, $03, $F1
        .byte $AE, $00, $03, $EA, $AE, $00, $01, $E8, $AE, $15, $D1, $AE, $BD

      rlUnknown9FAED9 ; 9F/AED9

        .al
        .xl
        .autsiz
        .databank ?

        ldy #$D013
        ora $B9
        .byte $00 ; brk
        .byte $00 ; brk
        tay
        rtl

        .byte $9E, $A0, $13, $C8, $C8, $6B

        .databank 0

      aUnknown9FAEE8 ; 9F/AEE8

        .word 0

      aUnknown9FAEEA ; 9F/AEEA

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $000, 3, 6, false, false]]

        .structSpriteArray aUnknown9FAEEA._Sprites

      aUnknown9FAEF1 ; 9F/AEF1

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $002, 3, 6, false, false]]

        .structSpriteArray aUnknown9FAEF1._Sprites

      aUnknown9FAEF8 ; 9F/AEF8

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $004, 3, 6, false, false]]

        .structSpriteArray aUnknown9FAEF8._Sprites

      aUnknown9FAEFF ; 9F/AEFF

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $006, 3, 6, false, false]]

        .structSpriteArray aUnknown9FAEFF._Sprites

      aUnknown9FAF06 ; 9F/AF06

        _Sprites := [[(  -8,   -6), $21, SpriteLarge, $00A, 3, 6, false, false]]

        .structSpriteArray aUnknown9FAF06._Sprites

      aUnknown9FAF0D ; 9F/AF0D

        _Sprites := [[( -10,   -8), $21, SpriteLarge, $008, 3, 6, true, false]]

        .structSpriteArray aUnknown9FAF0D._Sprites

      aUnknown9FAF14 ; 9F/AF14

        _Sprites := [[(  -8,  -10), $21, SpriteLarge, $00A, 3, 6, false, true]]

        .structSpriteArray aUnknown9FAF14._Sprites

      aUnknown9FAF1B ; 9F/AF1B

        _Sprites := [[(  -6,   -8), $21, SpriteLarge, $008, 3, 6, false, false]]

        .structSpriteArray aUnknown9FAF1B._Sprites

      rlUnknown9FAF22 ; 9F/AF22

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9F82D7

          .word $AF28

        rtl

        .databank 0

      procUnknown9FAF28 ; 9F/AF28

        .structProcInfo "ON", rlUnknown9FAF30, rlUnknown9FAF37, aProcUnknown9F805DCode

      rlUnknown9FAF30 ; 9F/AF30

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9F83F1
        jsr rsUnknown9F910A
        rtl


      rlUnknown9FAF37 ; 9F/AF37

        .al
        .xl
        .autsiz
        .databank ?
        jsr rsUnknown9F9116
        bcc _AF56
        lda #$AF57
        sta aProcSystem.aHeaderOnCycle,b,x
        stz aProcSystem.aBody2,b,x
        stz aProcSystem.aBody3,b,x
        lda #(`aUnknown9FAFD9)<<8
        sta lR44+1
        lda #<>aUnknown9FAFD9
        sta lR44
        jsl rlActiveSpriteEngineCreateSpriteHighestSlot

        _AF56
        rtl


        _AF57
        jsl rlUnknown9FAF5C
        rtl


      rlUnknown9FAF5C ; 9F/AF5C

        .al
        .xl
        .autsiz
        .databank ?
        lda aProcSystem.aBody2,b,x
        beq _AF66
        dec a
        sta aProcSystem.aBody2,b,x
        rtl


        _AF66
        lda #$0002
        sta aProcSystem.aBody2,b,x
        phx
        lda aProcSystem.aBody3,b,x
        inc aProcSystem.aBody3,b,x
        cmp #$000B
        bmi _AF7B
        stz aProcSystem.aBody3,b,x

        _AF7B
        asl a
        tax
        lda $AFA9,b,x
        sta $01D2,b
        lda $AFAB,b,x
        sta $01D4,b
        lda $AFAD,b,x
        sta $01D6,b
        lda $AFAF,b,x
        sta $01D8,b
        lda $AFB1,b,x
        sta $01DA,b
        lda $AFB3,b,x
        sta $01DC,b
        lda $AFB5,b,x
        sta $01DE,b
        plx
        rtl

        .databank 0

      aUnknown9FAFA9 ; 9F/AFA9

        .word $0000, $18A0, $30E0, $3160, $4E00, $66C0, $0000, $18A0
        .word $3160, $4E00, $66C0, $7F60, $0000, $18A0, $30E0, $3160
        .word $4E00, $66C0, $0000, $18A0, $3160, $4E00, $66C0, $7F60

      aUnknown9FAFD9 ; 9F/AFD9

        .word <>rlUnknown9FAFDF, <>rlUnknown9FB011, <>$B111

      rlUnknown9FAFDF ; 9F/AFDF

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
        clc
        adc #$FFF8
        sta aActiveSpriteSystem.aUnknown001240,b,x
        lda #$0002
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        lda $7F50C9
        asl a
        tay
        lda $B101,b,y
        sta aActiveSpriteSystem.aCodeOffset,b,x
        rtl


      rlUnknown9FB011 ; 9F/B011

        .al
        .xl
        .autsiz
        .databank ?
        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne _B052
        lda #$B053
        sta aActiveSpriteSystem.aOnCycle,b,x
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
        jsl rlUnknown9F89F8
        lsr a
        lsr a
        bne _B041
        lda #$0002

        _B041
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        lda wR0
        sta aActiveSpriteSystem.aUnknown0012E0,b,x
        lda #$0400
        sta aActiveSpriteSystem.aUnknown001300,b,x

        _B04F
        jsr rsUnknown9F9379

        _B052
        rtl

        .byte $22, $99, $89, $9F, $DE, $C0, $12, $D0, $F6, $AF, $9B, $50, $7F, $29, $FF, $00
        .byte $9D, $00, $12, $AF, $9C, $50, $7F, $29, $FF, $00, $9D, $40, $12, $A9, $01, $00
        .byte $9D, $A0, $13, $A9, $AB, $B0, $9D, $60, $11, $A9, $32, $00, $9D, $C0, $12, $BD
        .byte $00, $12, $20, $53, $82, $5C


        _B089
        jsr rsUnknown9F82D7

          .word $EC58

        sta aActiveSpriteSystem.aUnknown001380,b,x
        jsr rsUnknown9F830F

          .word $DBB8

        jsr rsUnknown9F830F

          .word $DBF1

        jsr rsUnknown9F830F

          .word $DB6C

        jsr rsUnknown9F830F

          .word $DB7F

        jsr rsUnknown9F830F

          .word $DC77


        _B0AA
        rtl

        .byte $DE, $C0, $12, $D0, $34, $A9, $01, $00, $8F, $80, $45, $7F, $A9, $C4, $B0, $9D
        .byte $60, $11, $A9, $0A, $00, $9D, $C0, $12, $6B


        _B0C4
        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne _B0E4
        ldy aActiveSpriteSystem.aUnknown001380,b,x
        lda #$FFFD
        sta aProcSystem.aBody4,b,y
        lda #$0001
        sta aActiveSpriteSystem.aUnknown0013A0,b,x
        lda #$B0E5
        sta aActiveSpriteSystem.aOnCycle,b,x
        lda #$0010
        sta aActiveSpriteSystem.aUnknown0012C0,b,x

        _B0E4
        rtl

        .byte $DE, $C0, $12, $D0, $06, $A9, $F1, $B0, $9D, $60, $11, $6B


        _B0F1
        jsr rsUnknown9F919F
        bcc _B100
        stz aActiveSpriteSystem.aTypeOffset,b,x
        lda #$0001
        sta $7F5093

        _B100
        rtl

        .databank 0

      aUnknown9FB101 ; 9F/B101

        .byte $11, $B1, $59, $B1, $29, $B1, $41, $B1, $11, $B1, $59, $B1, $29, $B1, $41, $B1
        .byte $00, $03, $DE, $B1, $00, $01, $DC, $B1, $00, $03, $EA, $B1, $00, $01, $DC, $B1
        .byte $17, $CC, $B1, $71, $B1, $15, $11, $B1, $00, $03, $04, $B2, $00, $01, $DC, $B1
        .byte $00, $03, $10, $B2, $00, $01, $DC, $B1, $17, $CC, $B1, $71, $B1, $15, $29, $B1
        .byte $00, $03, $F6, $B1, $00, $01, $DC, $B1, $00, $03, $FD, $B1, $00, $01, $DC, $B1
        .byte $17, $CC, $B1, $71, $B1, $15, $41, $B1, $00, $03, $1C, $B2, $00, $01, $DC, $B1
        .byte $00, $03, $23, $B2, $00, $01, $DC, $B1, $17, $CC, $B1, $71, $B1, $15, $59, $B1
        .byte $00, $01, $FD, $B1, $17, $CC, $B1, $C5, $B1, $00, $01, $FD, $B1, $17, $CC, $B1
        .byte $C5, $B1, $00, $01, $DC, $B1, $17, $CC, $B1, $C5, $B1, $00, $01, $40, $B2, $17
        .byte $CC, $B1, $C5, $B1, $00, $01, $40, $B2, $17, $CC, $B1, $C5, $B1, $00, $01, $DC
        .byte $B1, $17, $CC, $B1, $C5, $B1, $00, $01, $56, $B2, $17, $CC, $B1, $C5, $B1, $00
        .byte $01, $56, $B2, $17, $CC, $B1, $C5, $B1, $00, $01, $DC, $B1, $17, $CC, $B1, $C5
        .byte $B1, $15, $71, $B1, $00, $01, $DC, $B1, $15, $C5, $B1, $BD

      rlUnknown9FB1CD ; 9F/B1CD

        .al
        .xl
        .autsiz
        .databank ?

        ldy #$F013
        php
        stz aActiveSpriteSystem.aUnknown0013A0,b,x
        lda $0000,b,y
        tay
        rtl

        .byte $C8, $C8, $6B

        .databank 0

      aUnknown9FB1DC ; 9F/B1DC

        .word 0

      aUnknown9FB1DE ; 9F/B1DE

        _Sprites := [[(   0,   -4), $00, SpriteSmall, $010, 2, 6, false, false]]
        _Sprites ..= [[(  -8,   -4), $00, SpriteSmall, $000, 2, 6, false, false]]

        .structSpriteArray aUnknown9FB1DE._Sprites

      aUnknown9FB1EA ; 9F/B1EA

        _Sprites := [[(   0,   -4), $00, SpriteSmall, $010, 2, 6, false, true]]
        _Sprites ..= [[(  -8,   -4), $00, SpriteSmall, $000, 2, 6, false, true]]

        .structSpriteArray aUnknown9FB1EA._Sprites

      aUnknown9FB1F6 ; 9F/B1F6

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $002, 2, 6, true, true]]

        .structSpriteArray aUnknown9FB1F6._Sprites

      aUnknown9FB1FD ; 9F/B1FD

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $00C, 2, 6, false, false]]

        .structSpriteArray aUnknown9FB1FD._Sprites

      aUnknown9FB204 ; 9F/B204

        _Sprites := [[(  -4,    0), $00, SpriteSmall, $011, 2, 6, false, false]]
        _Sprites ..= [[(  -4,   -8), $00, SpriteSmall, $001, 2, 6, false, false]]

        .structSpriteArray aUnknown9FB204._Sprites

      aUnknown9FB210 ; 9F/B210

        _Sprites := [[(  -4,   -8), $00, SpriteSmall, $011, 2, 6, false, true]]
        _Sprites ..= [[(  -4,    0), $00, SpriteSmall, $001, 2, 6, false, true]]

        .structSpriteArray aUnknown9FB210._Sprites

      aUnknown9FB21C ; 9F/B21C

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $002, 2, 6, true, false]]

        .structSpriteArray aUnknown9FB21C._Sprites

      aUnknown9FB223 ; 9F/B223

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $00C, 2, 6, true, false]]

        .structSpriteArray aUnknown9FB223._Sprites

      aUnknown9FB22A ; 9F/B22A

        _Sprites := [[(   0,  -16), $21, SpriteLarge, $00A, 2, 6, false, true]]
        _Sprites ..= [[( -16,  -16), $21, SpriteLarge, $004, 2, 6, true, true]]
        _Sprites ..= [[( -16,    0), $21, SpriteLarge, $006, 2, 6, true, false]]
        _Sprites ..= [[(   0,    0), $21, SpriteLarge, $008, 2, 6, false, false]]

        .structSpriteArray aUnknown9FB22A._Sprites

      aUnknown9FB240 ; 9F/B240

        _Sprites := [[( -16,  -16), $21, SpriteLarge, $006, 2, 6, true, true]]
        _Sprites ..= [[(   0,  -16), $21, SpriteLarge, $004, 2, 6, false, true]]
        _Sprites ..= [[( -16,    0), $21, SpriteLarge, $008, 2, 6, true, false]]
        _Sprites ..= [[(   0,    0), $21, SpriteLarge, $00A, 2, 6, false, false]]

        .structSpriteArray aUnknown9FB240._Sprites

      aUnknown9FB256 ; 9F/B256

        _Sprites := [[(   0,    0), $21, SpriteLarge, $006, 2, 6, false, false]]
        _Sprites ..= [[( -16,    0), $21, SpriteLarge, $00A, 2, 6, true, false]]
        _Sprites ..= [[(   0,  -16), $21, SpriteLarge, $006, 2, 6, false, true]]
        _Sprites ..= [[( -16,  -16), $21, SpriteLarge, $008, 2, 6, true, true]]

        .structSpriteArray aUnknown9FB256._Sprites

      rlUnknown9FB26C ; 9F/B26C

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9F82D7

          .word $B279

        lda #$0080
        jsr rsUnknown9F8253

          .byte $5E

        rtl

        .databank 0

      procUnknown9FB279 ; 9F/B279

        .structProcInfo "ON", rlUnknown9FB28C, rlUnknown9FB2AC, aProcUnknown9FB281Code

      aProcUnknown9FB281Code ; 9F/B281

        PROC_YIELD 1
        PROC_CALL rlUnknown9FB330
        PROC_JUMP aProcUnknown9FB281Code

      rlUnknown9FB28C ; 9F/B28C

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9F83F1
        jsr rsUnknown9F910A
        stz aProcSystem.aBody2,b,x
        stz aProcSystem.aBody3,b,x
        lda #$0000
        sta $7ECC06
        sta $7ECC08
        sta $7ECC0A
        sta $7ECC0C
        rtl


      rlUnknown9FB2AC ; 9F/B2AC

        .al
        .xl
        .autsiz
        .databank ?
        lda $7F50CB
        bne _B2B7
        jsr rsUnknown9F9116
        bcc _B2C3

        _B2B7
        lda #$B2C4
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0018
        sta aProcSystem.aBody0,b,x

        _B2C3
        rtl


        _B2C4
        dec aProcSystem.aBody0,b,x
        bpl _B2ED
        jsr rsUnknown9F82D7

          .word $ECA3

        jsr rsUnknown9F830F

          .word $DBB8

        jsr rsUnknown9F830F

          .word $DB6C

        jsr rsUnknown9F830F

          .word $DBF1

        jsr rsUnknown9F830F

          .word $DB7F

        jsr rsUnknown9F830F

          .word $DCF4

        lda #$B2EE
        sta aProcSystem.aHeaderOnCycle,b,x

        _B2ED
        rtl


        _B2EE
        lda #$B319
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #(`aUnknown9FB3DD)<<8
        sta lR44+1
        lda #<>aUnknown9FB3DD
        sta lR44
        lda $7F509B
        and #$00FF
        cmp #$00A0
        bmi _B314
        lda #(`aUnknown9FB3E3)<<8
        sta lR44+1
        lda #<>aUnknown9FB3E3
        sta lR44

        _B314
        jsl rlActiveSpriteEngineCreateSpriteHighestSlot
        rtl


        _B319
        lda $7ECC0C
        beq _B32B
        lda #$B32C
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$EBA9
        sta aProcSystem.aHeaderCodeOffset,b,x

        _B32B
        rtl


        _B32C
        jsr rsUnknown9F827A
        rtl


      rlUnknown9FB330 ; 9F/B330

        .al
        .xl
        .autsiz
        .databank ?
        lda aProcSystem.aBody2,b,x
        beq _B33A
        dec a
        sta aProcSystem.aBody2,b,x
        rtl


        _B33A
        lda #$0002
        sta aProcSystem.aBody2,b,x
        phx
        lda aProcSystem.aBody3,b,x
        inc aProcSystem.aBody3,b,x
        cmp #$0027
        bmi _B34F
        stz aProcSystem.aBody3,b,x

        _B34F
        asl a
        tax
        lda $B37D,b,x
        sta $01D2,b
        lda $B37F,b,x
        sta $01D4,b
        lda $B381,b,x
        sta $01D6,b
        lda $B383,b,x
        sta $01D8,b
        lda $B385,b,x
        sta $01DA,b
        lda $B387,b,x
        sta $01DC,b
        lda $B389,b,x
        sta $01DE,b
        plx
        rtl

        .databank 0

      aUnknown9FB37D ; 9F/B37D

        .word $0012, $000D, $0012, $0017, $001F, $01FF
        .word $0012, $0008, $0012, $0017, $001F, $01FF
        .word $0012, $000D, $0012, $0017, $001F, $01FF
        .word $0012, $000D, $0012, $0017, $001F, $01FF
        .word $0012, $0008, $0012, $0017, $001F, $01FF
        .word $0012, $000D, $0012, $0017, $001F, $01FF
        .word $0012, $000D, $0012, $0017, $001F, $01FF
        .word $0008, $000D, $0012, $0017, $001F, $01FF

      aUnknown9FB3DD ; 9F/B3DD

        .word <>rlUnknown9FB3E9, <>rlUnknown9FB40A, <>aUnknown9FB4C8

      aUnknown9FB3E3 ; 9F/B3E3

        .word <>rlUnknown9FB3E9, <>rlUnknown9FB40A, <>$B4D8

      rlUnknown9FB3E9 ; 9F/B3E9

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F509F
        sta aActiveSpriteSystem.aUnknown001260,b,x
        lda #$00F8
        sta aActiveSpriteSystem.aUnknown001200,b,x
        lda #$FFF0
        sta aActiveSpriteSystem.aUnknown001240,b,x
        stz aActiveSpriteSystem.aUnknown0013E0,b,x
        stz aActiveSpriteSystem.aUnknown0013C0,b,x
        lda $7ECC0A
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        rtl


      rlUnknown9FB40A ; 9F/B40A

        .al
        .xl
        .autsiz
        .databank ?
        jsl rlUnknown9FDE04
        lda $7F50CD
        eor #$FFFF
        inc a
        clc
        adc #$0080
        and #$00FF
        sta aActiveSpriteSystem.aUnknown001200,b,x
        lda $7F50CF
        eor #$FFFF
        inc a
        clc
        adc #$0070
        and #$00FF
        sta aActiveSpriteSystem.aUnknown001240,b,x
        lda $7F509C
        and #$00FF
        sta wR0
        lda aActiveSpriteSystem.aUnknown001240,b,x
        cmp wR0
        bmi _B461
        lda wR0
        sta aActiveSpriteSystem.aUnknown001240,b,x
        lda aActiveSpriteSystem.aUnknown001200,b,x
        jsr rsUnknown9F8253

          .byte $5F

        lda #$000C
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        lda #$B462
        sta aActiveSpriteSystem.aOnCycle,b,x
        lda #$0001
        sta $7ECC0C

        _B461
        rtl

        .byte $DE, $C0


        _B464
        ora ($D0)
        ora $01A9,b
        .byte $00 ; brk
        sta aMapAction.wMapBattleActiveSpriteSyncFlag
        lda #$B475
        sta aActiveSpriteSystem.aOnCycle,b,x
        rtl

        .byte $A9, $00


        _B477
        .byte $00 ; brk
        sta aPaletteFading.wDesiredColor,b
        lda #$0006
        sta aPaletteFading,b
        jsl rlFadePaletteToBlack

          .byte $96, $B4

        bcc _B495
        lda #$B49C
        sta aActiveSpriteSystem.aOnCycle,b,x
        lda #$000E
        sta aActiveSpriteSystem.aUnknown0012C0,b,x

        _B495
        rtl

        .databank 0

      aUnknown9FB496 ; 9F/B496

        .byte $D2, $00, $07, $00, $FF, $FF

      rlUnknown9FB49C ; 9F/B49C

        .al
        .xl
        .autsiz
        .databank ?

        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne _B4AE
        lda #$0002
        sta $7ECC0C
        lda #$B4AF
        sta aActiveSpriteSystem.aOnCycle,b,x

        _B4AE
        rtl


        _B4AF
        lda $7F50CB
        bne _B4BA
        jsr rsUnknown9F919F
        bcc _B4C7

        _B4BA
        stz aActiveSpriteSystem.aTypeOffset,b,x
        lda #$0001
        sta $7F5093
        jsr rsUnknown9F8371

        _B4C7
        rtl

        .databank 0

      aUnknown9FB4C8 ; 9F/B4C8

        .byte $00, $01, $FB, $B4, $17, $E8, $B4, $C8, $B4, $00, $01, $F9, $B4, $15, $D1, $B4
        .byte $00, $01, $11, $B5, $17, $E8, $B4, $D8, $B4, $00, $01, $F9, $B4, $15, $E1, $B4

      rlUnknown9FB4E8 ; 9F/B4E8

        .al
        .xl
        .autsiz
        .databank ?

        lda $7ECC0C
        cmp #$0002
        beq _B4F6
        lda $0000,b,y
        tay
        rtl


        _B4F6
        inc y
        inc y
        rtl

        .databank 0

      aUnknown9FB4F9 ; 9F/B4F9

        .word 0

      aUnknown9FB4FB ; 9F/B4FB

        _Sprites := [[(   0,    0), $21, SpriteLarge, $006, 2, 6, false, false]]
        _Sprites ..= [[( -16,    0), $21, SpriteLarge, $004, 2, 6, false, false]]
        _Sprites ..= [[(   0,  -16), $21, SpriteLarge, $002, 2, 6, false, false]]
        _Sprites ..= [[( -16,  -16), $21, SpriteLarge, $000, 2, 6, false, false]]

        .structSpriteArray aUnknown9FB4FB._Sprites

      aUnknown9FB511 ; 9F/B511

        _Sprites := [[( -16,    0), $21, SpriteLarge, $006, 2, 6, true, false]]
        _Sprites ..= [[(   0,    0), $21, SpriteLarge, $004, 2, 6, true, false]]
        _Sprites ..= [[( -16,  -16), $21, SpriteLarge, $002, 2, 6, true, false]]
        _Sprites ..= [[(   0,  -16), $21, SpriteLarge, $000, 2, 6, true, false]]

        .structSpriteArray aUnknown9FB511._Sprites

      rlUnknown9FB527 ; 9F/B527

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9F82D7

          .word $B52D

        rtl

        .databank 0

      procUnknown9FB52D ; 9F/B52D

        .structProcInfo "ON", rlUnknown9FB535, rlUnknown9FB53C, aProcUnknown9F805DCode

      rlUnknown9FB535 ; 9F/B535

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9F83F1
        jsr rsUnknown9F910A

        _B53B
        rtl


      rlUnknown9FB53C ; 9F/B53C

        .al
        .xl
        .autsiz
        .databank ?
        jsr rsUnknown9F9116
        bcc rlUnknown9FB535._B53B
        lda #$B559
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0004
        sta aProcSystem.aBody0,b,x
        lda $7F509B
        and #$00FF
        jsr rsUnknown9F8253

          .byte $66

        rtl


        _B559
        dec aProcSystem.aBody0,b,x
        bpl _B56D
        jsr rlUnknown9FB5EC
        lda #$B56E
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0028
        sta aProcSystem.aBody0,b,x

        _B56D
        rtl


        _B56E
        dec aProcSystem.aBody0,b,x
        bne _B57F
        lda #$B580
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0014
        sta aProcSystem.aBody0,b,x

        _B57F
        rtl


        _B580
        dec aProcSystem.aBody0,b,x
        bne _B5B7
        lda #$B599
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0014
        sta aProcSystem.aBody0,b,x
        lda #$0001
        sta aMapAction.wMapBattleActiveSpriteSyncFlag
        rtl


        _B599
        dec aProcSystem.aBody0,b,x
        bne _B5B7
        lda #$B5B8
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0014
        sta aProcSystem.aBody0,b,x
        ldy aProcSystem.aBody7,b,x
        lda aProcSystem.aBody4,b,y
        eor #$FFFF
        inc a
        sta aProcSystem.aBody4,b,y

        _B5B7
        rtl


        _B5B8
        dec aProcSystem.aBody0,b,x
        bne _B5CC
        jsr rsUnknown9F8359
        lda #$B5CD
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0001
        sta aProcSystem.aBody0,b,x

        _B5CC
        rtl


        _B5CD
        dec aProcSystem.aBody0,b,x
        bne _B5D8
        lda #$B5D9
        sta aProcSystem.aHeaderOnCycle,b,x

        _B5D8
        rtl


        _B5D9
        jsr rsUnknown9F919F
        bcc _B5EB
        lda #$B5EB
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0001
        sta $7F5093

        _B5EB
        rtl


      rlUnknown9FB5EC ; 9F/B5EC

        .al
        .xl
        .autsiz
        .databank ?
        jsr rsUnknown9F82D7

          .word $EC3A

        sta aProcSystem.aBody7,b,x
        jsr rsUnknown9F830F

          .word $DBB8

        jsr rsUnknown9F830F

          .word $DC34

        jsr rsUnknown9F830F

          .word $DB6C

        jsr rsUnknown9F830F

          .word $DB7F

        jsr rsUnknown9F830F

          .word $DE9E

        rts

        .databank 0

      rlUnknown9FB60E ; 9F/B60E

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9F82D7

          .word $B6C4

        rtl

        .databank 0

      rlUnknown9FB614 ; 9F/B614

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9F82D7

          .word $B974

        rtl

        .databank 0

      rlUnknown9FB61A ; 9F/B61A

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9F82D7

          .word $B620

        rtl

        .databank 0

      procUnknown9FB620 ; 9F/B620

        .structProcInfo "ON", rlUnknown9FB6CC, $B633, aProcUnknown9FB628Code

      aProcUnknown9FB628Code ; 9F/B628

        PROC_YIELD 1
        PROC_CALL rlUnknown9FBAD5
        PROC_JUMP aProcUnknown9FB628Code

      rlUnknown9FB633 ; 9F/B633

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9F82D7

          .word $EC67

        sta aProcSystem.aBody7,b,x
        jsr rsUnknown9F830F

          .word $DBB8

        jsr rsUnknown9F830F

          .word $DBF1

        jsr rsUnknown9F830F

          .word $DB6C

        jsr rsUnknown9F830F

          .word $DB7F

        jsr rsUnknown9F830F

          .word $E2E5

        lda #$B67C
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0020
        sta aProcSystem.aBody0,b,x
        phx
        lda #(`aUnknown9FBA18)<<8
        sta lR44+1
        lda #<>aUnknown9FBA18
        sta lR44
        jsl rlActiveSpriteEngineCreateSpriteLastSlot
        plx
        lda $7F509B
        and #$00FF
        jsr rsUnknown9F8253

          .byte $7C

        rtl


        _B67C
        dec aProcSystem.aBody0,b,x
        bne _B694
        lda #$0001
        sta aMapAction.wMapBattleActiveSpriteSyncFlag
        lda #$B695
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0080
        sta aProcSystem.aBody0,b,x

        _B694
        rtl


        _B695
        dec aProcSystem.aBody0,b,x
        bne _B6B6
        ldy aProcSystem.aBody7,b,x
        lda #$FF00
        sta aProcSystem.aBody4,b,y
        lda #$B6B7
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0020
        sta aProcSystem.aBody0,b,x
        lda #$0001
        sta $7ECC08

        _B6B6
        rtl


        _B6B7
        dec aProcSystem.aBody0,b,x
        bne _B6C3
        lda #$0001
        sta $7ECC06

        _B6C3
        rtl

        .databank 0

      procUnknown9FB6C4 ; 9F/B6C4

        .structProcInfo "ON", rlUnknown9FB6CC, rlUnknown9FB81B, aProcUnknown9FB6F7Code

      rlUnknown9FB6CC ; 9F/B6CC

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
        lda aMapAction.wMapBattleDefenderSpriteSlot
        tay
        lda aActiveSpriteSystem.aUnknown001240,b,y
        sta aProcSystem.aBody5,b,x
        stz aProcSystem.aBody6,b,x
        rtl

        .databank 0

      aProcUnknown9FB6F7Code ; 9F/B6F7

        PROC_YIELD 3
        PROC_CALL_ARGS rlUnknown9FBC45, 1
        .byte $0F
        PROC_YIELD 3
        PROC_CALL_ARGS rlUnknown9FBC45, 1
        .byte $0E
        PROC_YIELD 3
        PROC_CALL_ARGS rlUnknown9FBC45, 1
        .byte $0D
        PROC_YIELD 3
        PROC_CALL_ARGS rlUnknown9FBC45, 1
        .byte $0C
        PROC_YIELD 3
        PROC_CALL_ARGS rlUnknown9FBC45, 1
        .byte $0B
        PROC_YIELD 3
        PROC_CALL_ARGS rlUnknown9FBC45, 1
        .byte $0A
        PROC_YIELD 3
        PROC_CALL_ARGS rlUnknown9FBC45, 1
        .byte $09
        PROC_YIELD 3
        PROC_CALL_ARGS rlUnknown9FBC45, 1
        .byte $08
        PROC_YIELD 3
        PROC_CALL_ARGS rlUnknown9FBC45, 1
        .byte $07
        PROC_YIELD 3
        PROC_CALL_ARGS rlUnknown9FBC45, 1
        .byte $06
        PROC_YIELD 3
        PROC_CALL_ARGS rlUnknown9FBC45, 1
        .byte $05
        PROC_YIELD 3
        PROC_CALL_ARGS rlUnknown9FBC45, 1
        .byte $04
        PROC_YIELD 3
        PROC_CALL_ARGS rlUnknown9FBC45, 1
        .byte $03
        PROC_YIELD 3
        PROC_CALL_ARGS rlUnknown9FBC45, 1
        .byte $02
        PROC_YIELD 3
        PROC_CALL_ARGS rlUnknown9FBC45, 1
        .byte $01
        PROC_YIELD 3
        PROC_CALL_ARGS rlUnknown9FBC45, 1
        .byte $00
        PROC_YIELD 2
        PROC_CALL_ARGS rlUnknown9FBC45, 1
        .byte $0F
        PROC_YIELD 2
        PROC_CALL_ARGS rlUnknown9FBC45, 1
        .byte $0E
        PROC_YIELD 2
        PROC_CALL_ARGS rlUnknown9FBC45, 1
        .byte $0D
        PROC_YIELD 2
        PROC_CALL_ARGS rlUnknown9FBC45, 1
        .byte $0C
        PROC_YIELD 2
        PROC_CALL_ARGS rlUnknown9FBC45, 1
        .byte $0B
        PROC_YIELD 2
        PROC_CALL_ARGS rlUnknown9FBC45, 1
        .byte $0A
        PROC_YIELD 2
        PROC_CALL_ARGS rlUnknown9FBC45, 1
        .byte $09
        PROC_YIELD 2
        PROC_CALL_ARGS rlUnknown9FBC45, 1
        .byte $08
        PROC_YIELD 2
        PROC_CALL_ARGS rlUnknown9FBC45, 1
        .byte $07
        PROC_YIELD 2
        PROC_CALL_ARGS rlUnknown9FBC45, 1
        .byte $06
        PROC_YIELD 2
        PROC_CALL_ARGS rlUnknown9FBC45, 1
        .byte $05
        PROC_YIELD 2
        PROC_CALL_ARGS rlUnknown9FBC45, 1
        .byte $04
        PROC_YIELD 2
        PROC_CALL_ARGS rlUnknown9FBC45, 1
        .byte $03
        PROC_YIELD 2
        PROC_CALL_ARGS rlUnknown9FBC45, 1
        .byte $02
        PROC_YIELD 2
        PROC_CALL_ARGS rlUnknown9FBC45, 1
        .byte $01
        PROC_YIELD 2
        PROC_CALL_ARGS rlUnknown9FBC45, 1
        .byte $00
        PROC_JUMP aProcUnknown9FB6F7Code

      rlUnknown9FB81B ; 9F/B81B

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9F82D7

          .word $EC67

        sta aProcSystem.aBody7,b,x
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

        lda #$B864
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0020
        sta aProcSystem.aBody0,b,x
        phx
        lda #(`aUnknown9FBA18)<<8
        sta lR44+1
        lda #<>aUnknown9FBA18
        sta lR44
        jsl rlActiveSpriteEngineCreateSpriteLastSlot
        plx
        lda $7F509B
        and #$00FF
        jsr rsUnknown9F8253

          .byte $7D

        rtl


        _B864
        dec aProcSystem.aBody0,b,x
        bne _B876
        lda #$0001
        sta aMapAction.wMapBattleActiveSpriteSyncFlag
        lda #$B877
        sta aProcSystem.aHeaderOnCycle,b,x

        _B876
        rtl


        _B877
        jsr _B8B8
        bcc _B888
        lda #$B889
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0010
        sta aProcSystem.aBody0,b,x

        _B888
        rtl


        _B889
        dec aProcSystem.aBody0,b,x
        bne _B8AA
        ldy aProcSystem.aBody7,b,x
        lda #$FF00
        sta aProcSystem.aBody4,b,y
        lda #$B8AB
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0020
        sta aProcSystem.aBody0,b,x
        lda #$0001
        sta $7ECC08

        _B8AA
        rtl


        _B8AB
        dec aProcSystem.aBody0,b,x
        bne _B8B7
        lda #$0001
        sta $7ECC06

        _B8B7
        rtl


        _B8B8
        lda aProcSystem.aBody6,b,x
        inc a
        cmp #$003F
        bmi _B8C4
        lda #$003F

        _B8C4
        sta aProcSystem.aBody6,b,x
        lda aMapAction.wMapBattleDefenderAuxSpriteSlot
        cmp #$FFFF
        beq _B8D3
        jsr _B8D7

        _B8D3
        lda aMapAction.wMapBattleDefenderSpriteSlot

        _B8D7
        tay
        lda aActiveSpriteSystem.aUnknown001240,b,y
        clc
        adc #$FFFE
        bmi _B91B
        phx
        lda $7ECC0A
        clc
        adc #$0010
        sta $7ECC0A
        and #$FF00
        xba
        eor #$FFFF
        inc a
        clc
        adc aProcSystem.aBody5,b,x
        sta aProcSystem.aBody5,b,x
        sta wR0
        lda aProcSystem.aBody6,b,x
        and #$001F
        lsr a
        tax
        lda $B934,b,x
        asl a
        and #$00FF
        eor #$FFFF
        inc a
        clc
        adc wR0
        sta aActiveSpriteSystem.aUnknown001240,b,y
        plx
        clc
        rts


        _B91B
        lda aMapAction.wMapBattleDefenderAuxSpriteSlot
        cmp #$FFFF
        beq _B927
        jsr _B92B

        _B927
        lda aMapAction.wMapBattleDefenderSpriteSlot

        _B92B
        tay
        lda #$FFF8
        sta aActiveSpriteSystem.aUnknown001240,b,y
        sec
        rts

        .databank 0

      aUnknown9FB934 ; 9F/B934

        .word $0100, $0200, $0300, $0400, $0500, $0600, $0700, $0800
        .word $0900, $0A00, $0B00, $0C00, $0D00, $0E00, $0F00, $1000
        .word $1100, $1200, $1300, $1400, $1500, $1600, $1700, $1800
        .word $1900, $1A00, $1B00, $1C00, $1D00, $1E00, $1F00, $2000

      procUnknown9FB974 ; 9F/B974

        .structProcInfo "ON", rlUnknown9FB6CC, rlUnknown9FB987, aProcUnknown9FB97CCode

      aProcUnknown9FB97CCode ; 9F/B97C

        PROC_YIELD 1
        PROC_CALL rlUnknown9FBB8E
        PROC_JUMP aProcUnknown9FB97CCode

      rlUnknown9FB987 ; 9F/B987

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9F82D7

          .word $EC67

        sta aProcSystem.aBody7,b,x
        jsr rsUnknown9F830F

          .word $DBB8

        jsr rsUnknown9F830F

          .word $DBF1

        jsr rsUnknown9F830F

          .word $DB6C

        jsr rsUnknown9F830F

          .word $DB7F

        jsr rsUnknown9F830F

          .word $E2D9

        lda #$B9D0
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0020
        sta aProcSystem.aBody0,b,x
        phx
        lda #(`aUnknown9FBA18)<<8
        sta lR44+1
        lda #<>aUnknown9FBA18
        sta lR44
        jsl rlActiveSpriteEngineCreateSpriteLastSlot
        plx
        lda $7F509B
        and #$00FF
        jsr rsUnknown9F8253

          .byte $78

        rtl


        _B9D0
        dec aProcSystem.aBody0,b,x
        bne _B9E8
        lda #$0001
        sta aMapAction.wMapBattleActiveSpriteSyncFlag
        lda #$B9E9
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0080
        sta aProcSystem.aBody0,b,x

        _B9E8
        rtl


        _B9E9
        dec aProcSystem.aBody0,b,x
        bne _BA0A
        ldy aProcSystem.aBody7,b,x
        lda #$FF00
        sta aProcSystem.aBody4,b,y
        lda #$BA0B
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0020
        sta aProcSystem.aBody0,b,x
        lda #$0001
        sta $7ECC08

        _BA0A
        rtl


        _BA0B
        dec aProcSystem.aBody0,b,x
        bne _BA17
        lda #$0001
        sta $7ECC06

        _BA17
        rtl

        .databank 0

      aUnknown9FBA18 ; 9F/BA18

        .word <>rlUnknown9FBA1E, <>rlUnknown9FBA3E, <>aUnknown9FBA4F

      rlUnknown9FBA1E ; 9F/BA1E

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F509F
        sta aActiveSpriteSystem.aUnknown001260,b,x
        lda $7F509B
        and #$00FF
        sta aActiveSpriteSystem.aUnknown001200,b,x
        lda $7F509C
        clc
        adc #$FFFC
        and #$00FF
        sta aActiveSpriteSystem.aUnknown001240,b,x
        rtl


      rlUnknown9FBA3E ; 9F/BA3E

        .al
        .xl
        .autsiz
        .databank ?
        lda $7ECC06
        beq _BA4E
        lda #$0001
        sta $7F5093
        stz aActiveSpriteSystem.aTypeOffset,b,x

        _BA4E
        rtl

        .databank 0

      aUnknown9FBA4F ; 9F/BA4F

        .byte $00, $03, $CE, $BA, $00, $03, $A8, $BA, $00, $03, $B6, $BA, $00, $03, $AF, $BA
        .byte $00, $03, $BD, $BA, $00, $01, $97, $BA, $17, $87, $BA, $63, $BA, $00, $02, $BD
        .byte $BA, $00, $02, $AF, $BA, $00, $02, $B6, $BA, $00, $02, $A8, $BA, $00, $02, $CE
        .byte $BA, $00, $01, $95, $BA, $15, $80, $BA

      rlUnknown9FBA87 ; 9F/BA87

        .al
        .xl
        .autsiz
        .databank ?

        lda $7ECC08
        bne _BA92
        lda $0000,b,y
        tay
        rtl


        _BA92
        inc y
        inc y
        rtl

        .databank 0

      aUnknown9FBA95 ; 9F/BA95

        .word 0

      aUnknown9FBA97 ; 9F/BA97

        _Sprites := [[(   5,    8), $00, SpriteSmall, $012, 2, 6, false, false]]
        _Sprites ..= [[(   5,    0), $00, SpriteSmall, $002, 2, 6, false, false]]
        _Sprites ..= [[( -11,    0), $21, SpriteLarge, $000, 2, 6, false, false]]

        .structSpriteArray aUnknown9FBA97._Sprites

      aUnknown9FBAA8 ; 9F/BAA8

        _Sprites := [[(  -3,    3), $00, SpriteSmall, $003, 2, 6, false, false]]

        .structSpriteArray aUnknown9FBAA8._Sprites

      aUnknown9FBAAF ; 9F/BAAF

        _Sprites := [[(  -8,    0), $21, SpriteLarge, $004, 2, 6, false, false]]

        .structSpriteArray aUnknown9FBAAF._Sprites

      aUnknown9FBAB6 ; 9F/BAB6

        _Sprites := [[(  -8,    0), $21, SpriteLarge, $006, 2, 6, false, false]]

        .structSpriteArray aUnknown9FBAB6._Sprites

      aUnknown9FBABD ; 9F/BABD

        _Sprites := [[(   5,    8), $00, SpriteSmall, $01A, 2, 6, false, false]]
        _Sprites ..= [[(   5,    0), $00, SpriteSmall, $00A, 2, 6, false, false]]
        _Sprites ..= [[( -11,    0), $21, SpriteLarge, $008, 2, 6, false, false]]

        .structSpriteArray aUnknown9FBABD._Sprites

      aUnknown9FBACE ; 9F/BACE

        _Sprites := [[(  -3,    4), $00, SpriteSmall, $013, 2, 6, false, false]]

        .structSpriteArray aUnknown9FBACE._Sprites

      rlUnknown9FBAD5 ; 9F/BAD5

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aBody2,b,x
        beq _BADF
        dec a
        sta aProcSystem.aBody2,b,x
        rtl


        _BADF
        lda #$0002
        sta aProcSystem.aBody2,b,x
        phx
        lda aProcSystem.aBody3,b,x
        inc aProcSystem.aBody3,b,x
        cmp #$0010
        bmi _BAF4
        stz aProcSystem.aBody3,b,x

        _BAF4
        asl a
        tax
        lda $BB3A,b,x
        sta $01D2,b
        sta $02C2,b
        lda $BB38,b,x
        sta $01D4,b
        sta $02C4,b
        lda $BB36,b,x
        sta $01D6,b
        sta $02C6,b
        lda $BB34,b,x
        sta $01D8,b
        sta $02C8,b
        lda $BB32,b,x
        sta $01DA,b
        sta $02CA,b
        lda $BB30,b,x
        sta $01DC,b
        sta $02CC,b
        plx
        rtl

        .databank 0

      aUnknown9FBB2E ; 9F/BB2E

        .word $7E0B, $7E0E, $7E11, $7E14, $7E16, $7E19, $7E1C, $7E1F
        .word $7E1F, $7DDD, $7D7A, $7D38, $7CF6, $7CB4, $7C51, $7C0F
        .word $7C0F, $7C6D, $7CCC, $7D2A, $7DA9, $7E07, $7E66, $7EC4
        .word $7EC4, $7E66, $7E07, $7DA9, $7D2A, $7CCC, $7C6D, $7C0F
        .word $7E0B, $7E0E, $7E11, $7E14, $7E16, $7E19, $7E1C, $7E1F
        .word $7E1F, $7DDD, $7D7A, $7D38, $7CF6, $7CB4, $7C51, $7C0F

      rlUnknown9FBB8E ; 9F/BB8E

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aBody2,b,x
        beq _BB98
        dec a
        sta aProcSystem.aBody2,b,x
        rtl


        _BB98
        lda #$0002
        sta aProcSystem.aBody2,b,x
        phx
        lda aProcSystem.aBody3,b,x
        dec a
        bpl _BBA8
        lda #$0020

        _BBA8
        sta aProcSystem.aBody3,b,x
        asl a
        tax
        lda $BBE5,b,x
        sta $01D2,b
        sta $02C2,b
        lda $BBE7,b,x
        sta $01D4,b
        sta $02C4,b
        lda $BBE9,b,x
        sta $01D6,b
        sta $02C6,b
        lda $BBEB,b,x
        sta $01D8,b
        sta $02C8,b
        lda $BBED,b,x
        sta $01DA,b
        sta $02CA,b
        lda $BBEF,b,x
        sta $01DC,b
        sta $02CC,b
        plx
        rtl

        .databank 0

      aUnknown9FBBE5 ; 9F/BBE5

        .word $7D40, $7520, $7120, $6900, $64E0, $5CE0, $58C0, $50A0
        .word $4CA0, $4480, $4060, $3860, $3440, $2C20, $2820, $2000
        .word $2000, $2820, $2C20, $3440, $3860, $4060, $4480, $4CA0
        .word $50A0, $58C0, $5CE0, $64E0, $6900, $7120, $7520, $7D40
        .word $7D40, $7520, $7120, $6900, $64E0, $5CE0, $58C0, $50A0
        .word $4CA0, $4480, $4060, $3860, $3440, $2C20, $2820, $2000

      rlUnknown9FBC45 ; 9F/BC45

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $0000,b,y
        and #$00FF
        asl a
        tax
        lda $BC8F,b,x
        sta $01D2,b
        sta $02C2,b
        lda $BC91,b,x
        sta $01D4,b
        sta $02C4,b
        lda $BC93,b,x
        sta $01D6,b
        sta $02C6,b
        lda $BC95,b,x
        sta $01D8,b
        sta $02C8,b
        lda $BC97,b,x
        sta $01DA,b
        sta $02CA,b
        lda $BC99,b,x
        sta $01DC,b
        sta $02CC,b
        lda $BC9B,b,x
        sta $01DE,b
        sta $02CE,b
        plx
        rtl

        .databank 0

      aUnknown9FBC8F ; 9F/BC8F

        .word $43FF, $039F, $033D, $025A, $01DA, $0159, $00F0, $006E
        .word $006E, $00F0, $0159, $01DA, $025A, $033D, $039F, $43FF
        .word $43FF, $039F, $033D, $025A, $01DA, $0159, $00F0, $006E
        .word $006E, $00F0, $0159, $01DA, $025A, $033D, $039F, $43FF

      rlUnknown9FBCCF ; 9F/BCCF

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9F82D7

          .word $BCD5

        rtl

        .databank 0

      procUnknown9FBCD5 ; 9F/BCD5

        .structProcInfo "ON", rlUnknown9FBCDD, rlUnknown9FBCFD, $BDC1

      rlUnknown9FBCDD ; 9F/BCDD

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9F83F1
        jsr rsUnknown9F910A
        stz aProcSystem.aBody0,b,x
        stz aProcSystem.aBody1,b,x
        lda #$0000
        sta $7ECC06
        sta $7ECC08
        sta $7ECC0A
        sta $7ECC0C

        _BCFC
        rtl


      rlUnknown9FBCFD ; 9F/BCFD

        .al
        .xl
        .autsiz
        .databank ?
        jsr rsUnknown9F9116
        bcc rlUnknown9FBCDD._BCFC
        jsr rsUnknown9F82D7

          .word $EBFE

        sta aProcSystem.aBody7,b,x
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

        lda #$BD48
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0020
        sta aProcSystem.aBody0,b,x
        stz aProcSystem.aBody2,b,x
        stz aProcSystem.aBody3,b,x
        jsl rlUnknown9FBEB2
        lda #(`aUnknown9FBF08)<<8
        sta lR44+1
        lda #<>aUnknown9FBF08
        sta lR44
        jsl rlActiveSpriteEngineCreateSpriteHighestSlot
        rtl


        _BD48
        jsl rlUnknown9FBEB2
        dec aProcSystem.aBody0,b,x
        bne _BD5D
        lda #$BD5E
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0030
        sta aProcSystem.aBody0,b,x

        _BD5D
        rtl


        _BD5E
        jsl rlUnknown9FBEB2
        dec aProcSystem.aBody0,b,x
        bne _BD9E
        lda #$0001
        sta aMapAction.wMapBattleActiveSpriteSyncFlag
        lda #$BD7B
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0050
        sta aProcSystem.aBody0,b,x
        rtl


        _BD7B
        jsl rlUnknown9FBEB2
        lda $7ECC06
        beq _BD9E
        ldy aProcSystem.aBody7,b,x
        lda aProcSystem.aBody4,b,y
        eor #$FFFF
        inc a
        sta aProcSystem.aBody4,b,y
        lda #$BD9F
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$000C
        sta aProcSystem.aBody0,b,x

        _BD9E
        rtl


        _BD9F
        dec aProcSystem.aBody0,b,x
        bne _BDAD
        lda #$BDAE
        sta aProcSystem.aHeaderOnCycle,b,x
        jsr rsUnknown9F8359

        _BDAD
        rtl


        _BDAE
        jsr rsUnknown9F919F
        bcc _BDC0
        lda #$BDC0
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0001
        sta $7F5093

        _BDC0
        rtl

        .databank 0

      aProcUnknown9FBDC1Code ; 9F/BDC1

        PROC_YIELD 1
        PROC_CALL_ARGS rlUnknown9FBE31, 1
        .byte $00
        PROC_YIELD 1
        PROC_CALL_ARGS rlUnknown9FBE31, 1
        .byte $01
        PROC_YIELD 1
        PROC_CALL_ARGS rlUnknown9FBE31, 1
        .byte $02
        PROC_YIELD 2
        PROC_CALL_ARGS rlUnknown9FBE31, 1
        .byte $03
        PROC_YIELD 2
        PROC_CALL_ARGS rlUnknown9FBE31, 1
        .byte $04
        PROC_YIELD 2
        PROC_CALL_ARGS rlUnknown9FBE31, 1
        .byte $05
        PROC_YIELD 2
        PROC_CALL_ARGS rlUnknown9FBE31, 1
        .byte $06
        PROC_YIELD 2
        PROC_CALL_ARGS rlUnknown9FBE31, 1
        .byte $07
        PROC_YIELD 2
        PROC_CALL_ARGS rlUnknown9FBE31, 1
        .byte $08
        PROC_YIELD 1
        PROC_CALL_ARGS rlUnknown9FBE31, 1
        .byte $09
        PROC_YIELD 1
        PROC_CALL_ARGS rlUnknown9FBE31, 1
        .byte $0A
        PROC_YIELD 1
        PROC_CALL_ARGS rlUnknown9FBE31, 1
        .byte $0B
        PROC_JUMP aProcUnknown9FBDC1Code


      rlUnknown9FBE31 ; 9F/BE31

        .al
        .xl
        .autsiz
        .databank ?

        lda $0000,b,y
        and #$00FF
        asl a
        tax
        lda $BE52,b,x
        sta $01D2,b
        lda $BE54,b,x
        sta $01D4,b
        lda $BE56,b,x
        sta $01D6,b
        lda $BE58,b,x
        sta $01D8,b
        rtl

        .databank 0

      aUnknown9FBE52 ; 9F/BE52

        .word $7400, $7C20, $7D40, $7DC0, $7E40, $7FC0
        .word $2C02, $4007, $5C0B, $6810, $7C17, $7C9F
        .word $7400, $7C20, $7D40, $7DC0, $7E40, $7FC0
        .word $2C02, $4007, $5C0B, $6810, $7C17, $7C9F
        .word $7400, $7C20, $7D40, $7DC0, $7E40, $7FC0
        .word $2C02, $4007, $5C0B, $6810, $7C17, $7C9F
        .word $7400, $7C20, $7D40, $7DC0, $7E40, $7FC0
        .word $2C02, $4007, $5C0B, $6810, $7C17, $7C9F

      rlUnknown9FBEB2 ; 9F/BEB2

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aBody2,b,x
        inc a
        cmp #$0004
        bpl _BEBF
        sta aProcSystem.aBody2,b,x
        rtl


        _BEBF
        stz aProcSystem.aBody2,b,x
        lda aProcSystem.aBody3,b,x
        inc a
        cmp #$0008
        bmi _BECE
        lda #$0000

        _BECE
        sta aProcSystem.aBody3,b,x
        asl a
        phx
        tax
        lda $BEE8,b,x
        sta $01DA,b
        lda $BEEA,b,x
        sta $01DC,b
        lda $BEEC,b,x
        sta $01DE,b
        plx
        rtl

        .databank 0

      aUnknown9FBEE8 ; 9F/BEE8

        .word $0000, $1800, $6000, $7D60, $7000, $3400, $1800, $0000
        .word $0000, $1800, $6000, $7D60, $7000, $3400, $1800, $0000

      aUnknown9FBF08 ; 9F/BF08

        .word <>rlUnknown9FBF0E, <>rlUnknown9FBF37, <>aUnknown9FBF47


      rlUnknown9FBF0E ; 9F/BF0E

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F509F
        sta aActiveSpriteSystem.aUnknown001260,b,x
        lda $7F509B
        and #$00FF
        sta aActiveSpriteSystem.aUnknown001200,b,x
        lda $7F509C
        and #$00FF
        sta aActiveSpriteSystem.aUnknown001240,b,x
        lda #$0060
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        lda aActiveSpriteSystem.aUnknown001200,b,x
        jsr rsUnknown9F8253

          .byte $5D

        rtl

        .databank 0

      rlUnknown9FBF37 ; 9F/BF37

        .al
        .xl
        .autsiz
        .databank ?

        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne _BF46
        lda #$0001
        sta $7ECC06
        stz aActiveSpriteSystem.aTypeOffset,b,x

        _BF46
        rtl

        .databank 0

      aUnknown9FBF47 ; 9F/BF47

        .byte $00, $01, $79, $BF, $17, $6B, $BF, $47, $BF, $00, $03, $7B, $BF, $00, $01, $79
        .byte $BF, $00, $03, $A5, $BF, $00, $01, $79, $BF, $00, $01, $CF, $BF, $00, $01, $79
        .byte $BF, $15, $50, $BF

      rlUnknown9FBF6B ; 9F/BF6B

        .al
        .xl
        .autsiz
        .databank ?

        lda $7ECC08
        bne _BF76
        lda $0000,b,y
        tay
        rtl


        _BF76
        inc y
        inc y
        rtl

        .databank 0

      aUnknown9F9FBF79 ; 9F/9FBF79

        .word 0

      aUnknown9F9FBF7B ; 9F/9FBF7B

        _Sprites := [[( -40,   -9), $21, SpriteLarge, $006, 2, 6, false, true]]
        _Sprites ..= [[(  -6,  -38), $21, SpriteLarge, $00C, 2, 6, false, true]]
        _Sprites ..= [[(  16,   16), $21, SpriteLarge, $002, 2, 6, false, false]]
        _Sprites ..= [[(  14,  -32), $21, SpriteLarge, $002, 2, 6, false, true]]
        _Sprites ..= [[(  22,   -8), $21, SpriteLarge, $006, 2, 6, false, false]]
        _Sprites ..= [[( -32,  -32), $21, SpriteLarge, $004, 2, 6, true, true]]
        _Sprites ..= [[( -32,   16), $21, SpriteLarge, $004, 2, 6, true, false]]
        _Sprites ..= [[( -13,   25), $21, SpriteLarge, $00C, 2, 6, false, false]]

        .structSpriteArray aUnknown9F9FBF7B._Sprites

      aUnknown9F9FBFA5 ; 9F/9FBFA5

        _Sprites := [[( -14,   25), $21, SpriteLarge, $002, 2, 6, false, true]]
        _Sprites ..= [[(  22,  -11), $21, SpriteLarge, $006, 2, 6, false, true]]
        _Sprites ..= [[( -40,   -6), $21, SpriteLarge, $008, 2, 6, false, false]]
        _Sprites ..= [[( -32,   16), $21, SpriteLarge, $002, 2, 6, true, false]]
        _Sprites ..= [[(  14,  -32), $21, SpriteLarge, $000, 2, 6, false, true]]
        _Sprites ..= [[(  16,   16), $21, SpriteLarge, $000, 2, 6, false, false]]
        _Sprites ..= [[( -31,  -32), $21, SpriteLarge, $004, 2, 6, false, false]]
        _Sprites ..= [[(  -7,  -38), $21, SpriteLarge, $00A, 2, 6, false, true]]

        .structSpriteArray aUnknown9F9FBFA5._Sprites

      aUnknown9F9FBFCF ; 9F/9FBFCF

        _Sprites := [[(  14,  -32), $21, SpriteLarge, $004, 2, 6, true, false]]
        _Sprites ..= [[(  22,   -8), $21, SpriteLarge, $008, 2, 6, true, false]]
        _Sprites ..= [[(  16,   16), $21, SpriteLarge, $004, 2, 6, false, false]]
        _Sprites ..= [[( -13,   25), $21, SpriteLarge, $00A, 2, 6, false, false]]
        _Sprites ..= [[( -32,   16), $21, SpriteLarge, $000, 2, 6, true, false]]
        _Sprites ..= [[( -40,   -6), $21, SpriteLarge, $006, 2, 6, false, false]]
        _Sprites ..= [[( -32,  -32), $21, SpriteLarge, $002, 2, 6, true, true]]
        _Sprites ..= [[(  -7,  -38), $21, SpriteLarge, $00C, 2, 6, false, false]]

        .structSpriteArray aUnknown9F9FBFCF._Sprites


      rlUnknown9FBFF9 ; 9F/BFF9

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9F82D7

          .word <>procUnknown9FBFFF

        rtl

        .databank 0

      procUnknown9FBFFF ; 9F/BFFF

        .structProcInfo "ON", rlUnknown9FC007, rlUnknown9FC00F, aProcUnknown9F805DCode


      rlUnknown9FC007 ; 9F/C007

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9F910A
        jsl rlUnknown9FC0B3
        rtl

        .databank 0

      rlUnknown9FC00F ; 9F/C00F

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9F9116
        bcc _C04F
        jsr rsUnknown9F83F1
        jsr rsUnknown9F82D7

          .word <>procUnknown9FEC76

        sta aProcSystem.aBody7,b,x
        jsr rsUnknown9F830F

          .word <>aUnknown9FDBB8

        jsr rsUnknown9F830F

          .word <>aUnknown9FDBF1

        jsr rsUnknown9F830F

          .word <>aUnknown9FDB6C

        jsr rsUnknown9F830F

          .word <>aUnknown9FDB7F

        jsr rsUnknown9F830F

          .word <>aUnknown9FDE8E

        lda $7F509B
        and #$00FF
        jsr rsUnknown9F8253

          .byte $65

        lda #$C050
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0014
        sta aProcSystem.aBody0,b,x

        _C04F
        rtl

        .databank 0

      rlUnknown9FC050 ; 9F/C050

        .al
        .xl
        .autsiz
        .databank ?

        dec aProcSystem.aBody0,b,x
        bne _C061
        lda #$C062
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0014
        sta aProcSystem.aBody0,b,x

        _C061
        rtl

        .databank 0

      rlUnknown9FC062 ; 9F/C062

        .al
        .xl
        .autsiz
        .databank ?

        dec aProcSystem.aBody0,b,x
        bne rlUnknown9FC07B._C092
        lda #$0001
        sta aMapAction.wMapBattleActiveSpriteSyncFlag
        lda #$C07B
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0014
        sta aProcSystem.aBody0,b,x
        rtl

        .databank 0

      rlUnknown9FC07B ; 9F/C07B

        .al
        .xl
        .autsiz
        .databank ?

        dec aProcSystem.aBody0,b,x
        bne _C092
        lda #$C093
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0010
        sta aProcSystem.aBody0,b,x
        stz aProcSystem.aBody2,b,x
        stz aProcSystem.aBody3,b,x

        _C092
        rtl

        .databank 0

      rlUnknown9FC093 ; 9F/C093

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown9FC0B3
        bcc _C09F
        lda #$C0A0
        sta aProcSystem.aHeaderOnCycle,b,x

        _C09F
        rtl

        .databank 0

      rlUnknown9FC0A0 ; 9F/C0A0

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9F919F
        bcc _C0B2
        lda #$C0B2
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0001
        sta $7F5093

        _C0B2
        rtl

        .databank 0

      rlUnknown9FC0B3 ; 9F/C0B3

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0003
        sta aProcSystem.aBody2,b,x
        ldy aProcSystem.aBody3,b,x
        lda $C0FD,b,y
        cmp #$FFFF
        beq _C0FB
        phx
        tya
        clc
        adc #$000E
        sta aProcSystem.aBody3,b,x
        tyx
        lda $C0FD,b,x
        sta $01D2,b
        lda $C0FF,b,x
        sta $01D4,b
        lda $C101,b,x
        sta $01D6,b
        lda $C103,b,x
        sta $01D8,b
        lda $C105,b,x
        sta $01DA,b
        lda $C107,b,x
        sta $01DC,b
        lda $C109,b,x
        sta $01DE,b
        plx
        clc
        rtl


        _C0FB
        sec
        rtl

        .databank 0

      aUnknown9FC0FD ; 9F/C0FD

        .word $4251, $360D, $21C7, $1984, $0942, $00C0, $0020
        .word $3E0F, $2DCB, $1D86, $1544, $0922, $00A0, $0020
        .word $35CD, $298A, $1965, $1123, $0501, $0080, $0020
        .word $2D8B, $2148, $1524, $1103, $04C1, $0080, $0000
        .word $2549, $1D27, $1104, $0CC2, $04A1, $0060, $0000
        .word $1D07, $14E5, $0CC3, $08A2, $0481, $0040, $0000
        .word $14C5, $10A4, $0882, $0881, $0060, $0040, $0000
        .word $0C83, $0C63, $0461, $0441, $0040, $0020, $0000
        .word $0442, $0421, $0420, $0020, $0020, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $FFFF

      rlUnknown9FC18B ; 9F/C18B

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9F82D7

          .word <>procUnknown9FC191

        rtl

        .databank 0

      procUnknown9FC191 ; 9F/C191

        .structProcInfo "ON", rlUnknown9FC199, rlUnknown9FC1B0, aProcUnknown9FC50CCode


      rlUnknown9FC199 ; 9F/C199

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
        rtl

        .databank 0

      rlUnknown9FC1B0 ; 9F/C1B0

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9F82D7

          .word <>procUnknown9FEBF6

        jsr rsUnknown9F830F

          .word <>aUnknown9FDBB8

        jsr rsUnknown9F830F

          .word <>aUnknown9FDC34

        jsr rsUnknown9F830F

          .word <>aUnknown9FDB6C

        jsr rsUnknown9F830F

          .word <>aUnknown9FDB7F

        jsr rsUnknown9F830F

          .word <>aUnknown9FDC77

        lda #$C1F4
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0060
        sta aProcSystem.aBody0,b,x
        lda $7F509B
        and #$00FF
        jsr rsUnknown9F8253

          .byte $67

        lda #(`aUnknown9FC3A7)<<8
        sta lR44+1
        lda #<>aUnknown9FC3A7
        sta lR44
        jsl rlActiveSpriteEngineCreateSpriteHighestSlot
        rtl

        .databank 0

      rlUnknown9FC1F4 ; 9F/C1F4

        .al
        .xl
        .autsiz
        .databank ?

        dec aProcSystem.aBody0,b,x
        bne _C20C
        lda #$0001
        sta aMapAction.wMapBattleActiveSpriteSyncFlag
        lda #$C20D
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$00A0
        sta aProcSystem.aBody0,b,x

        _C20C
        rtl

        .databank 0

      rlUnknown9FC20D ; 9F/C20D

        .al
        .xl
        .autsiz
        .databank ?

        dec aProcSystem.aBody0,b,x
        bne _C219
        lda #$0001
        sta $7ECC0C

        _C219
        rtl

        .databank 0

      rlUnknown9FC21A ; 9F/C21A

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9F82BE
        lda $7F509B
        and #$00FF
        xba
        sta aProcSystem.aBody3,b,x
        lda $7F509B
        and #$FF00
        sta aProcSystem.aBody4,b,x
        lda $7F509B
        and #$00FF
        sta wR0
        lda $7F5099
        and #$00FF
        sec
        sbc wR0
        sta wR0
        lda $7F509C
        and #$00FF
        sta wR1
        lda $7F509A
        and #$00FF
        sec
        sbc wR1
        sta wR1
        jsl rlUnknown9F89F8
        sta aProcSystem.aBody1,b,x
        lda #$0100
        jsl rlUnknown9F8B7A._8B84
        ldx aProcSystem.wOffset,b
        sta aProcSystem.aBody5,b,x
        lda #$0100
        jsl rlUnknown9F8B7A
        ldx aProcSystem.wOffset,b
        sta aProcSystem.aBody6,b,x
        rtl

        .databank 0

      rlUnknown9FC27E ; 9F/C27E

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aBody2,b,x
        clc
        adc #$0001
        cmp #$0012
        bcc _C2A0
        lda #$C2A7
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0040
        sta aProcSystem.aBody0,b,x
        lda #$0001
        sta $7ECC0A
        lda #$0012

        _C2A0
        sta aProcSystem.aBody2,b,x
        jsr rsUnknown9FC33F
        rtl

        .databank 0

      rlUnknown9FC2A7 ; 9F/C2A7

        .al
        .xl
        .autsiz
        .databank ?

        dec aProcSystem.aBody0,b,x
        bne _C2BF
        lda #$C2C0
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0004
        sta aProcSystem.aBody0,b,x
        lda #$0001
        sta $7ECC0A

        _C2BF
        rtl

        .databank 0

      rlUnknown9FC2C0 ; 9F/C2C0

        .al
        .xl
        .autsiz
        .databank ?

        dec aProcSystem.aBody0,b,x
        bne _C2D1
        lda #$C2D2
        sta aProcSystem.aHeaderOnCycle,b,x
        lda aProcSystem.aBody1,b,x
        sta aProcSystem.aBody0,b,x

        _C2D1
        rtl

        .databank 0

      rlUnknown9FC2D2 ; 9F/C2D2

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9FC393
        lda aProcSystem.aBody2,b,x
        jsr rsUnknown9FC33F
        dec aProcSystem.aBody0,b,x
        bne _C2F3
        lda #$C2F4
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0004
        sta aProcSystem.aBody0,b,x
        lda #$0001
        sta $7ECC06

        _C2F3
        rtl

        .databank 0

      rlUnknown9FC2F4 ; 9F/C2F4

        .al
        .xl
        .autsiz
        .databank ?

        dec aProcSystem.aBody0,b,x
        bne _C30C
        lda #$C30D
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0040
        sta aProcSystem.aBody0,b,x
        lda #$0001
        sta $7ECC0A

        _C30C
        rtl

        .databank 0

      rlUnknown9FC30D ; 9F/C30D

        .al
        .xl
        .autsiz
        .databank ?

        dec aProcSystem.aBody0,b,x
        bne _C31F
        lda #$C320
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0001
        sta $7ECC0A

        _C31F
        rtl

        .databank 0

      rlUnknown9FC320 ; 9F/C320

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aBody2,b,x
        sec
        sbc #$0001
        cmp #$0001
        bpl _C338
        jsr rsUnknown9F8359
        lda #$C33E
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0001

        _C338
        sta aProcSystem.aBody2,b,x
        jsr rsUnknown9FC33F
        rtl

        .databank 0

      rsUnknown9FC33F ; 9F/C33F

        .al
        .xl
        .autsiz
        .databank ?

        sta $7F50E3
        asl a
        sta $7F50E5
        lda $1038,b,x
        and #$00FF
        sta $7F50DF
        sec
        sbc #$0080
        eor #$FFFF
        inc a
        sta $7F50CD
        lda $1058,b,x
        and #$00FF
        sta $7F50E1
        lda $1058,b,x
        and #$00FF
        sec
        sbc #$0070
        eor #$FFFF
        inc a
        sta $7F50CF
        phx
        phy
        lda #$7F00
        sta lR18+1
        lda #$50EA
        sta lR18
        ldx #$0000
        lda #$00E0
        jsl rlUnknown9FEA52
        ply
        plx
        rts

        .databank 0

      rsUnknown9FC393 ; 9F/C393

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aBody5,b,x
        clc
        adc aProcSystem.aBody3,b,x
        sta aProcSystem.aBody3,b,x
        lda aProcSystem.aBody6,b,x
        adc aProcSystem.aBody4,b,x
        sta aProcSystem.aBody4,b,x
        rts

        .databank 0

      aUnknown9FC3A7 ; 9F/C3A7

        .word <>rlUnknown9FC3AD, <>rlUnknown9FC3C9, <>aUnknown9FC499


      rlUnknown9FC3AD ; 9F/C3AD

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
        sta aActiveSpriteSystem.aUnknown001240,b,x
        rtl

        .databank 0

      rlUnknown9FC3C9 ; 9F/C3C9

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9FC415
        lda $7F509B
        and #$00FF
        sta aActiveSpriteSystem.aUnknown001200,b,x
        lda $7F509C
        and #$00FF
        sta aActiveSpriteSystem.aUnknown001240,b,x
        lda $7ECC06
        beq _C3EC
        lda #$C3ED
        sta aActiveSpriteSystem.aOnCycle,b,x

        _C3EC
        rtl

        .databank 0

      rlUnknown9FC3ED ; 9F/C3ED

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9FC415
        lda $7F5099
        and #$00FF
        sta aActiveSpriteSystem.aUnknown001200,b,x
        lda $7F509A
        and #$00FF
        sta aActiveSpriteSystem.aUnknown001240,b,x
        lda $7ECC0C
        beq _C414
        stz aActiveSpriteSystem.aTypeOffset,b,x
        lda #$0001
        sta $7F5093

        _C414
        rtl

        .databank 0

      rsUnknown9FC415 ; 9F/C415

        .al
        .xl
        .autsiz
        .databank ?

        phx
        inc aActiveSpriteSystem.aUnknown001300,b,x
        lda aActiveSpriteSystem.aUnknown001300,b,x
        and #$001F
        asl a
        tay
        lda #$000F
        sta wR0
        ldx #$0000

        _C429
        lda $C439,b,y
        sta $02C2,b,x
        inc y
        inc y
        inc x
        inc x
        dec wR0
        bne _C429
        plx
        rts

        .databank 0

      aUnknown9FC439 ; 9F/C439

        .word $2550, $39F3, $4E97, $5F3B, $73DF, $01D8, $0619, $063A
        .word $0A7B, $0EBC, $12FD, $131E, $175F, $00AC, $00EE, $052F
        .word $0571, $09B2, $0A35, $0E97, $131A, $17DF, $0C89, $190C
        .word $298F, $3612, $4276, $4EF9, $5F7C, $6BFF, $0008, $14AC
        .word $2550, $39F3, $4E97, $5F3B, $73DF, $01D8, $0619, $063A
        .word $0A7B, $0EBC, $12FD, $131E, $175F, $00AC, $00EE, $052F

      aUnknown9FC499 ; 9F/C499

        .byte $00, $01, $DE, $C4, $17, $C9, $C4, $99, $C4, $00, $01, $F6, $C4, $17, $C9, $C4
        .byte $A2, $C4, $00, $01, $DE, $C4, $17, $C9, $C4, $AB, $C4, $00, $01, $E0, $C4, $17
        .byte $C9, $C4, $B4, $C4, $00, $01, $DE, $C4, $17, $C9, $C4, $BD, $C4, $15, $99, $C4

      rlUnknown9FC4C9 ; 9F/C4C9

        .al
        .xl
        .autsiz
        .databank ?

        lda $7ECC0A
        beq _C4D9
        lda #$0000
        sta $7ECC0A
        inc y
        inc y
        rtl


        _C4D9
        lda $0000,b,y
        tay
        rtl

        .databank 0

      aUnknown9F9FC4DE ; 9F/9FC4DE

        .word 0

      aUnknown9F9FC4E0 ; 9F/9FC4E0

        _Sprites := [[(   0,    2), $21, SpriteLarge, $000, 3, 6, true, true]]
        _Sprites ..= [[(   0,  -14), $21, SpriteLarge, $000, 3, 6, true, false]]
        _Sprites ..= [[( -16,    2), $21, SpriteLarge, $000, 3, 6, false, true]]
        _Sprites ..= [[( -16,  -14), $21, SpriteLarge, $000, 3, 6, false, false]]

        .structSpriteArray aUnknown9F9FC4E0._Sprites

      aUnknown9F9FC4F6 ; 9F/9FC4F6

        _Sprites := [[(   0,    2), $21, SpriteLarge, $002, 3, 6, true, true]]
        _Sprites ..= [[( -16,    2), $21, SpriteLarge, $002, 3, 6, false, true]]
        _Sprites ..= [[(   0,  -14), $21, SpriteLarge, $002, 3, 6, true, false]]
        _Sprites ..= [[( -16,  -14), $21, SpriteLarge, $002, 3, 6, false, false]]

        .structSpriteArray aUnknown9F9FC4F6._Sprites


      aProcUnknown9FC50CCode ; 9F/C50C

        PROC_YIELD 2
        PROC_CALL_ARGS rlUnknown9FC57C, 1
        .byte $00
        PROC_YIELD 2
        PROC_CALL_ARGS rlUnknown9FC57C, 1
        .byte $01
        PROC_YIELD 2
        PROC_CALL_ARGS rlUnknown9FC57C, 1
        .byte $02
        PROC_YIELD 2
        PROC_CALL_ARGS rlUnknown9FC57C, 1
        .byte $03
        PROC_YIELD 2
        PROC_CALL_ARGS rlUnknown9FC57C, 1
        .byte $04
        PROC_YIELD 2
        PROC_CALL_ARGS rlUnknown9FC57C, 1
        .byte $05
        PROC_YIELD 2
        PROC_CALL_ARGS rlUnknown9FC57C, 1
        .byte $06
        PROC_YIELD 2
        PROC_CALL_ARGS rlUnknown9FC57C, 1
        .byte $07
        PROC_YIELD 2
        PROC_CALL_ARGS rlUnknown9FC57C, 1
        .byte $08
        PROC_YIELD 2
        PROC_CALL_ARGS rlUnknown9FC57C, 1
        .byte $09
        PROC_YIELD 2
        PROC_CALL_ARGS rlUnknown9FC57C, 1
        .byte $0A
        PROC_YIELD 2
        PROC_CALL_ARGS rlUnknown9FC57C, 1
        .byte $0B
        PROC_JUMP aProcUnknown9FC50CCode


      rlUnknown9FC57C ; 9F/C57C

        .al
        .xl
        .autsiz
        .databank ?

        lda $0000,b,y
        and #$00FF
        asl a
        tax
        lda $C5AF,b,x
        sta $01D2,b
        lda $C5B1,b,x
        sta $01D4,b
        lda $C5B3,b,x
        sta $01D6,b
        lda $C5B5,b,x
        sta $01D8,b
        lda $C5B7,b,x
        sta $01DA,b
        lda $C5B9,b,x
        sta $01DC,b
        lda $C5BB,b,x
        sta $01DE,b
        rtl

        .databank 0

      aUnknown9FC5AF ; 9F/C5AF

        .word $001D, $0016, $0013, $0012, $000D, $001D, $0016, $0013
        .word $0012, $000D, $001D, $0016, $0013, $0012, $000D, $001D
        .word $0016, $0013, $0012, $000D, $001D, $0016, $0013, $0012
        .word $000D, $001D, $0016, $0013, $0012, $000D, $001D, $0016
        .word $0013, $0012, $000D, $001D, $0016, $0013, $0012, $000D
        .word $001D, $0016, $0013, $0012, $000D, $001D, $0016, $0013

      rlUnknown9FC60F ; 9F/C60F

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9F82D7

          .word <>procUnknown9FC615

        rtl

        .databank 0

      procUnknown9FC615 ; 9F/C615

        .structProcInfo "ON", rlUnknown9FC628, rlUnknown9FC62F, aProcUnknown9FC61DCode


      aProcUnknown9FC61DCode ; 9F/C61D

        PROC_YIELD 1
        PROC_CALL rlUnknown9FC7A8
        PROC_JUMP aProcUnknown9FC61DCode


      rlUnknown9FC628 ; 9F/C628

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9F83F1
        jsr rsUnknown9F910A
        rtl

        .databank 0

      rlUnknown9FC62F ; 9F/C62F

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9F9116
        bcc _C64B
        lda #$C64C
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$000C
        sta aProcSystem.aBody0,b,x
        lda $7F509B
        and #$00FF
        jsr rsUnknown9F8253

          .byte $79


        _C64B
        rtl

        .databank 0

      rlUnknown9FC64C ; 9F/C64C

        .al
        .xl
        .autsiz
        .databank ?

        dec aProcSystem.aBody0,b,x
        bne _C67E
        jsr rsUnknown9F82D7

          .word <>procUnknown9FEC85

        sta aProcSystem.aBody7,b,x
        jsr rsUnknown9F830F

          .word <>aUnknown9FDBB8

        jsr rsUnknown9F830F

          .word <>aUnknown9FDC34

        jsr rsUnknown9F830F

          .word <>aUnknown9FDB6C

        jsr rsUnknown9F830F

          .word <>aUnknown9FDB7F

        jsr rsUnknown9F830F

          .word <>aUnknown9FDC77

        lda #$C67F
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0020
        sta aProcSystem.aBody0,b,x

        _C67E
        rtl

        .databank 0

      rlUnknown9FC67F ; 9F/C67F

        .al
        .xl
        .autsiz
        .databank ?

        dec aProcSystem.aBody0,b,x
        bne _C697
        lda #$C698
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0030
        sta aProcSystem.aBody0,b,x
        lda #$0001
        sta aMapAction.wMapBattleActiveSpriteSyncFlag

        _C697
        rtl

        .databank 0

      rlUnknown9FC698 ; 9F/C698

        .al
        .xl
        .autsiz
        .databank ?

        ; WARNING: a branch or jump leads into the middle of an instruction at $9FC69C
        dec aProcSystem.aBody0,b,x
        bne _C6B2
        ldy aProcSystem.aBody7,b,x
        lda #$FFFD
        sta aProcSystem.aBody4,b,y
        lda #$C6B3
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0010
        sta aProcSystem.aBody0,b,x

        _C6B2
        rtl

        .databank 0

      rlUnknown9FC6B3 ; 9F/C6B3

        .al
        .xl
        .autsiz
        .databank ?

        dec aProcSystem.aBody0,b,x
        bne _C6C1
        lda #$C6C2
        sta aProcSystem.aHeaderOnCycle,b,x
        jsr rsUnknown9F8359

        _C6C1
        rtl

        .databank 0

      rlUnknown9FC6C2 ; 9F/C6C2

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9F919F
        bcc _C6D4
        lda #$C6D4
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0001
        sta $7F5093

        _C6D4
        rtl

        .databank 0

      rlUnknown9FC6D5 ; 9F/C6D5

        .al
        .xl
        .autsiz
        .databank ?

        dec aProcSystem.aBody1,b,x
        beq _C6DE
        jml _C79F


        _C6DE
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
        bpl _C70A
        lda #$0001
        sta aProcSystem.aBody2,b,x

        _C70A
        cmp aProcSystem.aBody3,b,x
        bmi _C715
        lda aProcSystem.aBody3,b,x
        sta aProcSystem.aBody2,b,x

        _C715
        lda $7F509B
        and #$00FF
        clc
        adc wR0
        sta $7F50DF
        lda aProcSystem.aBody7,b,x
        inc aProcSystem.aBody7,b,x
        and #$000C
        lsr a
        tay
        lda $7F509B
        and #$00FF
        sec
        sbc $C7A0,b,y
        eor #$FFFF
        inc a
        sta $7F50CD
        lda $7F509C
        and #$00FF
        clc
        adc #$0004
        clc
        adc wR1
        sta $7F50E1
        lda $7F509C
        and #$00FF
        clc
        adc #$0004
        sec
        sbc #$0070
        eor #$FFFF
        inc a
        sta $7F50CF
        lda aProcSystem.aBody5,b,x
        bne _C77D
        lda aProcSystem.aBody2,b,x
        sta $7F50E3
        asl a
        sta $7F50E5
        bra _C789


        _C77D
        lda aProcSystem.aBody2,b,x
        sta $7F50E3
        inc a
        sta $7F50E5

        _C789
        phy
        lda #$7F00
        sta lR18+1
        lda #$50EA
        sta lR18
        ldx #$0000
        lda #$00E0
        jsl rlUnknown9FEA52
        ply

        _C79F
        rtl

        .databank 0

      aUnknown9FC7A0 ; 9F/C7A0

        .word $0080, $00B0, $00E0, $0050

      rlUnknown9FC7A8 ; 9F/C7A8

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda aProcSystem.aBody2,b
        inc aProcSystem.aBody2,b
        and #$001F
        asl a
        tax
        lda $C7E0,b,x
        sta $01D2,b
        lda $C7E2,b,x
        sta $01D4,b
        lda $C7E4,b,x
        sta $01D6,b
        lda $C7E6,b,x
        sta $01D8,b
        lda $C7E8,b,x
        sta $01DA,b
        lda $C7EA,b,x
        sta $01DC,b
        lda $C7EC,b,x
        sta $01DE,b
        plx
        rtl

        .databank 0

      aUnknown9FC7E0 ; 9F/C7E0

        .word $7D40, $7520, $7120, $6900, $64E0, $5CE0, $58C0, $50A0
        .word $4CA0, $4480, $4060, $3860, $3440, $2C20, $2820, $2000
        .word $2000, $2820, $2C20, $3440, $3860, $4060, $4480, $4CA0
        .word $50A0, $58C0, $5CE0, $64E0, $6900, $7120, $7520, $7D40
        .word $7D40, $7520, $7120, $6900, $64E0, $5CE0, $58C0, $50A0
        .word $4CA0, $4480, $4060, $3860, $3440, $2C20, $2820, $2000

      rlUnknown9FC840 ; 9F/C840

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9F82D7

          .word <>procUnknown9FC846

        rtl

        .databank 0

      procUnknown9FC846 ; 9F/C846

        .structProcInfo "ON", rlUnknown9FC84E, rlUnknown9FC865, aProcUnknown9F805DCode


      rlUnknown9FC84E ; 9F/C84E

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9F910A
        lda #$0000
        sta $7ECC06
        sta $7ECC08
        sta $7ECC0A
        sta $7ECC0C
        rtl

        .databank 0

      rlUnknown9FC865 ; 9F/C865

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0007
        ldy #$0014
        sta aPaletteFading.wDesiredColor,b
        tya
        sta aPaletteFading,b
        sec
        jsr rsUnknown9F91DD
        bcc _C88E
        lda #$C88F
        sta aProcSystem.aHeaderOnCycle,b,x
        phx
        lda #(`aUnknown9FC8C1)<<8
        sta lR44+1
        lda #<>aUnknown9FC8C1
        sta lR44
        jsl rlActiveSpriteEngineCreateSpriteHighestSlot
        plx

        _C88E
        rtl

        .databank 0

      rlUnknown9FC88F ; 9F/C88F

        .al
        .xl
        .autsiz
        .databank ?

        lda $7ECC06
        beq _C8A1
        lda #$C8A2
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0010
        sta aProcSystem.aBody0,b,x

        _C8A1
        rtl

        .databank 0

      rlUnknown9FC8A2 ; 9F/C8A2

        .al
        .xl
        .autsiz
        .databank ?

        dec aProcSystem.aBody0,b,x
        bne _C8AD
        lda #$C8AE
        sta aProcSystem.aHeaderOnCycle,b,x

        _C8AD
        rtl

        .databank 0

      rlUnknown9FC8AE ; 9F/C8AE

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9F919F
        bcc _C8C0
        lda #$C8C0
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0001
        sta $7F5093

        _C8C0
        rtl

        .databank 0

      aUnknown9FC8C1 ; 9F/C8C1

        .word <>rlUnknown9FC8C7, <>rlUnknown9FC8F0, <>aUnknown9FC969


      rlUnknown9FC8C7 ; 9F/C8C7

        .al
        .xl
        .autsiz
        .databank ?

        ; WARNING: a branch or jump leads into the middle of an instruction at $9FC8CC
        lda $7F509F
        sta aActiveSpriteSystem.aUnknown001260,b,x
        lda $7F5099
        and #$00FF
        sta aActiveSpriteSystem.aUnknown001200,b,x
        jsr rsUnknown9F8253

          .byte $63

        lda $7F509A
        and #$00FF
        sta aActiveSpriteSystem.aUnknown001240,b,x
        lda #$0030
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        jml rlUnknown9FC9E8

        .databank 0

      rlUnknown9FC8F0 ; 9F/C8F0

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown9FC9E8
        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne _C933
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
        jsl rlUnknown9F89F8
        bne _C91C
        lda #$0008

        _C91C
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        lda wR0
        sta aActiveSpriteSystem.aUnknown0012E0,b,x
        lda #$0100
        sta aActiveSpriteSystem.aUnknown001300,b,x
        jsr rsUnknown9F9379
        lda #$C934
        sta aActiveSpriteSystem.aOnCycle,b,x

        _C933
        rtl

        .databank 0

      rlUnknown9FC934 ; 9F/C934

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown9FC9E8
        jsl rlUnknown9F8999
        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne _C954
        lda #$0001
        sta aMapAction.wMapBattleActiveSpriteSyncFlag
        lda #$0020
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        lda #$C955
        sta aActiveSpriteSystem.aOnCycle,b,x

        _C954
        rtl

        .databank 0

      rlUnknown9FC955 ; 9F/C955

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown9FC9E8
        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne _C968
        lda #$0001
        sta $7ECC06
        stz aActiveSpriteSystem.aTypeOffset,b,x

        _C968
        rtl

        .databank 0

      aUnknown9FC969 ; 9F/C969

        .byte $00, $03, $7C, $C9, $00, $03, $B2, $C9, $00, $03, $97, $C9, $00, $03, $CD, $C9
        .byte $15, $69, $C9

      aUnknown9F9FC97C ; 9F/9FC97C

        _Sprites := [[(  -1,  -72), $21, SpriteLarge, $00C, 2, 6, true, false]]
        _Sprites ..= [[(  -3,  -56), $21, SpriteLarge, $006, 2, 6, false, false]]
        _Sprites ..= [[(  -4,  -40), $21, SpriteLarge, $004, 2, 6, false, false]]
        _Sprites ..= [[(  -6,  -24), $21, SpriteLarge, $002, 2, 6, false, false]]
        _Sprites ..= [[(  -8,   -8), $21, SpriteLarge, $000, 2, 6, false, false]]

        .structSpriteArray aUnknown9F9FC97C._Sprites

      aUnknown9F9FC997 ; 9F/9FC997

        _Sprites := [[(   1,  -72), $21, SpriteLarge, $00C, 2, 6, false, false]]
        _Sprites ..= [[(  -3,  -56), $21, SpriteLarge, $004, 2, 6, false, false]]
        _Sprites ..= [[(  -5,  -40), $21, SpriteLarge, $006, 2, 6, false, false]]
        _Sprites ..= [[(  -9,  -24), $21, SpriteLarge, $008, 2, 6, false, false]]
        _Sprites ..= [[(  -8,   -8), $21, SpriteLarge, $00A, 2, 6, false, false]]

        .structSpriteArray aUnknown9F9FC997._Sprites

      aUnknown9F9FC9B2 ; 9F/9FC9B2

        _Sprites := [[(  -6,  -72), $21, SpriteLarge, $00C, 2, 6, true, false]]
        _Sprites ..= [[(  -8,  -56), $21, SpriteLarge, $006, 2, 6, false, false]]
        _Sprites ..= [[(  -7,  -40), $21, SpriteLarge, $004, 2, 6, true, false]]
        _Sprites ..= [[(  -8,  -24), $21, SpriteLarge, $002, 2, 6, true, false]]
        _Sprites ..= [[(  -8,   -8), $21, SpriteLarge, $000, 2, 6, false, false]]

        .structSpriteArray aUnknown9F9FC9B2._Sprites

      aUnknown9F9FC9CD ; 9F/9FC9CD

        _Sprites := [[(  -7,  -72), $21, SpriteLarge, $00C, 2, 6, false, false]]
        _Sprites ..= [[( -10,  -56), $21, SpriteLarge, $004, 2, 6, false, true]]
        _Sprites ..= [[(  -7,  -40), $21, SpriteLarge, $006, 2, 6, true, false]]
        _Sprites ..= [[(  -9,  -24), $21, SpriteLarge, $008, 2, 6, false, false]]
        _Sprites ..= [[(  -7,   -8), $21, SpriteLarge, $00A, 2, 6, true, false]]

        .structSpriteArray aUnknown9F9FC9CD._Sprites


      rlUnknown9FC9E8 ; 9F/C9E8

        .al
        .xl
        .autsiz
        .databank ?

        lda aActiveSpriteSystem.aUnknown001360,b,x
        beq _C9F2

        _C9ED
        dec a
        sta aActiveSpriteSystem.aUnknown001360,b,x
        rtl


        _C9F2
        lda #$0002
        sta aActiveSpriteSystem.aUnknown001360,b,x
        phx
        lda aActiveSpriteSystem.aUnknown001380,b,x
        inc a
        and #$000F
        sta aActiveSpriteSystem.aUnknown001380,b,x
        asl a
        tax
        lda $CA1F,b,x
        sta $02CE,b
        lda $CA21,b,x
        sta $02D0,b
        lda $CA23,b,x
        sta $02D2,b
        lda $CA25,b,x
        sta $02D4,b
        plx
        rtl

        .databank 0

      aUnknown9FCA1F ; 9F/CA1F

        .word $7F9F, $62B8, $45D1, $24E9, $1445, $24E9, $45D1, $62B8
        .word $7F9F, $62B8, $45D1, $45D1, $24E9, $1445, $24E9, $45D1
        .word $7F9F, $62B8, $45D1, $24E9, $1445, $24E9, $45D1, $62B8
        .word $7F9F, $62B8, $45D1, $45D1, $24E9, $1445, $24E9, $45D1

      rlUnknown9FCA5F ; 9F/CA5F

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aUnknown9FCA89)<<8
        sta lR44+1
        lda #<>aUnknown9FCA89
        sta lR44
        jsl rlActiveSpriteEngineCreateSpriteHighestSlot
        rtl

        .databank 0

      rsUnknown9FCA6E ; 9F/CA6E

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda aActiveSpriteSystem.aUnknown001240,b,x
        tay
        lda aActiveSpriteSystem.aUnknown001200,b,x
        tax
        lda #(`aUnknown9FCA8F)<<8
        sta lR44+1
        lda #<>aUnknown9FCA8F
        sta lR44
        jsl rlActiveSpriteEngineCreateSpriteHighestSlot
        ply
        plx
        rts

        .databank 0

      aUnknown9FCA89 ; 9F/CA89

        .word <>rlUnknown9FCA97, <>rlUnknown9FCB00, <>aUnknown9FCA95


      aUnknown9FCA8F ; 9F/CA8F

        .word <>rlUnknown9FCADD, <>rlUnknown9FCAF7, <>aUnknown9FCA95


      aUnknown9FCA95 ; 9F/CA95

        .word $0000

      rlUnknown9FCA97 ; 9F/CA97

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
        sta aActiveSpriteSystem.aUnknown001240,b,x
        lda #$0001
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        lda $7F50C9
        asl a
        tay
        lda $CBA6,b,y
        sta aActiveSpriteSystem.aCodeOffset,b,x
        lda $7F5089
        cmp #$000B
        beq _CAD5
        lda aActiveSpriteSystem.aUnknown001200,b,x
        jsr rsUnknown9F8253

          .byte $61

        rtl


        _CAD5
        lda aActiveSpriteSystem.aUnknown001200,b,x
        jsr rsUnknown9F8253

          .byte $62

        rtl

        .databank 0

      rlUnknown9FCADD ; 9F/CADD

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F509F
        sta aActiveSpriteSystem.aUnknown001260,b,x
        lda #$0001
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        lda $7F50C9
        asl a
        tay
        lda $CBB6,b,y
        sta aActiveSpriteSystem.aCodeOffset,b,x
        rtl

        .databank 0

      rlUnknown9FCAF7 ; 9F/CAF7

        .al
        .xl
        .autsiz
        .databank ?

        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne _CAFF
        stz aActiveSpriteSystem.aTypeOffset,b,x

        _CAFF
        rtl

        .databank 0

      rlUnknown9FCB00 ; 9F/CB00

        .al
        .xl
        .autsiz
        .databank ?

        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne _CB41
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
        jsl rlUnknown9F89F8
        lsr a
        lsr a
        bne _CB2A
        lda #$0002

        _CB2A
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        lda wR0
        sta aActiveSpriteSystem.aUnknown0012E0,b,x
        lda #$0400
        sta aActiveSpriteSystem.aUnknown001300,b,x
        jsr rsUnknown9F9379
        lda #$CB42
        sta aActiveSpriteSystem.aOnCycle,b,x

        _CB41
        rtl

        .databank 0

      rlUnknown9FCB42 ; 9F/CB42

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F5089
        cmp #$000B
        bne _CB4E
        jsr rsUnknown9FCA6E

        _CB4E
        jsl rlUnknown9F8999
        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne rlUnknown9FCB00._CB41
        lda #$0001
        sta aMapAction.wMapBattleActiveSpriteSyncFlag
        sta aActiveSpriteSystem.aUnknown001320,b,x
        lda #$0020
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        lda #$CB6E
        sta aActiveSpriteSystem.aOnCycle,b,x
        rtl

        .databank 0

      rlUnknown9FCB6E ; 9F/CB6E

        .al
        .xl
        .autsiz
        .databank ?

        lda aActiveSpriteSystem.aUnknown001300,b,x
        sec
        sbc #$00C0
        bcs _CB7A
        lda #$0000

        _CB7A
        sta aActiveSpriteSystem.aUnknown001300,b,x
        jsr rsUnknown9F9379
        jsl rlUnknown9F8999
        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne rlUnknown9FCB00._CB41
        lda #$0010
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        lda #$CB96
        sta aActiveSpriteSystem.aOnCycle,b,x
        rtl

        .databank 0

      rlUnknown9FCB96 ; 9F/CB96

        .al
        .xl
        .autsiz
        .databank ?

        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne rlUnknown9FCB00._CB41
        lda #$0001
        sta $7F5093
        stz aActiveSpriteSystem.aTypeOffset,b,x
        rtl

        .databank 0

      aUnknown9FCBA6 ; 9F/CBA6

        .word $CC11, $CBD5, $CC2F, $CBF3, $CC02, $CBE4, $CC20, $CBC6
        .word $CC19, $CBDD, $CC37, $CBFB, $CC0A, $CBEC, $CC28, $CBCE

      aUnknown9FCBC6 ; 9F/CBC6

        .byte $00, $02, $40, $CC, $00, $02, $47, $CC, $00, $01, $4E, $CC, $15, $CE, $CB, $00
        .byte $02, $55, $CC, $00, $02, $5C, $CC, $00, $01, $63, $CC, $15, $DD, $CB, $00, $02
        .byte $6A, $CC, $00, $02, $71, $CC, $00, $01, $78, $CC, $15, $EC, $CB, $00, $02, $7F
        .byte $CC, $00, $02, $86, $CC, $00, $01, $8D, $CC, $15, $FB, $CB, $00, $02, $94, $CC
        .byte $00, $02, $9B, $CC, $00, $01, $A2, $CC, $15, $0A, $CC, $00, $02, $AE, $CC, $00
        .byte $02, $B5, $CC, $00, $01, $BC, $CC, $15, $19, $CC, $00, $02, $C8, $CC, $00, $02
        .byte $DE, $CC, $00, $01, $F4, $CC, $15, $28, $CC, $00, $02, $00, $CD, $00, $02, $16
        .byte $CD, $00, $01, $2C, $CD, $15, $37, $CC

      aUnknown9F9FCC3E ; 9F/9FCC3E

        .word 0

      aUnknown9F9FCC40 ; 9F/9FCC40

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $00A, 2, 6, false, false]]

        .structSpriteArray aUnknown9F9FCC40._Sprites

      aUnknown9F9FCC47 ; 9F/9FCC47

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $00C, 2, 6, false, false]]

        .structSpriteArray aUnknown9F9FCC47._Sprites

      aUnknown9F9FCC4E ; 9F/9FCC4E

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $004, 2, 6, false, false]]

        .structSpriteArray aUnknown9F9FCC4E._Sprites

      aUnknown9F9FCC55 ; 9F/9FCC55

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $00A, 2, 6, false, true]]

        .structSpriteArray aUnknown9F9FCC55._Sprites

      aUnknown9F9FCC5C ; 9F/9FCC5C

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $00C, 2, 6, false, true]]

        .structSpriteArray aUnknown9F9FCC5C._Sprites

      aUnknown9F9FCC63 ; 9F/9FCC63

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $004, 2, 6, false, true]]

        .structSpriteArray aUnknown9F9FCC63._Sprites

      aUnknown9F9FCC6A ; 9F/9FCC6A

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $00A, 2, 6, true, false]]

        .structSpriteArray aUnknown9F9FCC6A._Sprites

      aUnknown9F9FCC71 ; 9F/9FCC71

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $00C, 2, 6, true, false]]

        .structSpriteArray aUnknown9F9FCC71._Sprites

      aUnknown9F9FCC78 ; 9F/9FCC78

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $004, 2, 6, true, false]]

        .structSpriteArray aUnknown9F9FCC78._Sprites

      aUnknown9F9FCC7F ; 9F/9FCC7F

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $00A, 2, 6, true, true]]

        .structSpriteArray aUnknown9F9FCC7F._Sprites

      aUnknown9F9FCC86 ; 9F/9FCC86

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $00C, 2, 6, true, true]]

        .structSpriteArray aUnknown9F9FCC86._Sprites

      aUnknown9F9FCC8D ; 9F/9FCC8D

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $004, 2, 6, true, true]]

        .structSpriteArray aUnknown9F9FCC8D._Sprites

      aUnknown9F9FCC94 ; 9F/9FCC94

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $000, 2, 6, false, false]]

        .structSpriteArray aUnknown9F9FCC94._Sprites

      aUnknown9F9FCC9B ; 9F/9FCC9B

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $008, 2, 6, false, false]]

        .structSpriteArray aUnknown9F9FCC9B._Sprites

      aUnknown9F9FCCA2 ; 9F/9FCCA2

        _Sprites := [[(  -8,    0), $00, SpriteSmall, $013, 2, 6, false, false]]
        _Sprites ..= [[(  -8,   -8), $00, SpriteSmall, $012, 2, 6, false, false]]

        .structSpriteArray aUnknown9F9FCCA2._Sprites

      aUnknown9F9FCCAE ; 9F/9FCCAE

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $000, 2, 6, true, false]]

        .structSpriteArray aUnknown9F9FCCAE._Sprites

      aUnknown9F9FCCB5 ; 9F/9FCCB5

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $008, 2, 6, true, false]]

        .structSpriteArray aUnknown9F9FCCB5._Sprites

      aUnknown9F9FCCBC ; 9F/9FCCBC

        _Sprites := [[(   0,    0), $00, SpriteSmall, $013, 2, 6, true, false]]
        _Sprites ..= [[(   0,   -8), $00, SpriteSmall, $012, 2, 6, true, false]]

        .structSpriteArray aUnknown9F9FCCBC._Sprites

      aUnknown9F9FCCC8 ; 9F/9FCCC8

        _Sprites := [[(   0,    0), $00, SpriteSmall, $016, 2, 6, true, false]]
        _Sprites ..= [[(   0,   -8), $00, SpriteSmall, $006, 2, 6, true, false]]
        _Sprites ..= [[(  -8,    0), $00, SpriteSmall, $016, 2, 6, false, false]]
        _Sprites ..= [[(  -8,   -8), $00, SpriteSmall, $006, 2, 6, false, false]]

        .structSpriteArray aUnknown9F9FCCC8._Sprites

      aUnknown9F9FCCDE ; 9F/9FCCDE

        _Sprites := [[(   0,    0), $00, SpriteSmall, $017, 2, 6, false, false]]
        _Sprites ..= [[(   0,   -8), $00, SpriteSmall, $007, 2, 6, false, false]]
        _Sprites ..= [[(  -8,    0), $00, SpriteSmall, $017, 2, 6, true, false]]
        _Sprites ..= [[(  -8,   -8), $00, SpriteSmall, $007, 2, 6, true, false]]

        .structSpriteArray aUnknown9F9FCCDE._Sprites

      aUnknown9F9FCCF4 ; 9F/9FCCF4

        _Sprites := [[(   0,   -7), $00, SpriteSmall, $003, 2, 6, false, false]]
        _Sprites ..= [[(  -8,   -7), $00, SpriteSmall, $002, 2, 6, false, false]]

        .structSpriteArray aUnknown9F9FCCF4._Sprites

      aUnknown9F9FCD00 ; 9F/9FCD00

        _Sprites := [[(   0,   -8), $00, SpriteSmall, $016, 2, 6, true, true]]
        _Sprites ..= [[(   0,    0), $00, SpriteSmall, $006, 2, 6, true, true]]
        _Sprites ..= [[(  -8,   -8), $00, SpriteSmall, $016, 2, 6, false, true]]
        _Sprites ..= [[(  -8,    0), $00, SpriteSmall, $006, 2, 6, false, true]]

        .structSpriteArray aUnknown9F9FCD00._Sprites

      aUnknown9F9FCD16 ; 9F/9FCD16

        _Sprites := [[(  -8,    0), $00, SpriteSmall, $007, 2, 6, true, true]]
        _Sprites ..= [[(   0,   -8), $00, SpriteSmall, $017, 2, 6, false, true]]
        _Sprites ..= [[(   0,    0), $00, SpriteSmall, $007, 2, 6, false, true]]
        _Sprites ..= [[(  -8,   -8), $00, SpriteSmall, $017, 2, 6, true, true]]

        .structSpriteArray aUnknown9F9FCD16._Sprites

      aUnknown9F9FCD2C ; 9F/9FCD2C

        _Sprites := [[(   0,   -1), $00, SpriteSmall, $003, 2, 6, false, true]]
        _Sprites ..= [[(  -8,   -1), $00, SpriteSmall, $002, 2, 6, false, true]]

        .structSpriteArray aUnknown9F9FCD2C._Sprites


      rlUnknown9FCD38 ; 9F/CD38

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F509B
        and #$00FF
        jsr rsUnknown9F8253

          .byte $77

        lda #(`aUnknown9FCD6C)<<8
        sta lR44+1
        lda #<>aUnknown9FCD6C
        sta lR44
        jsl rlActiveSpriteEngineCreateSpriteHighestSlot
        rtl

        .databank 0

      rlUnknown9FCD52 ; 9F/CD52

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F509B
        and #$00FF
        jsr rsUnknown9F8253

          .byte $77

        lda #(`aUnknown9FCD72)<<8
        sta lR44+1
        lda #<>aUnknown9FCD72
        sta lR44
        jsl rlActiveSpriteEngineCreateSpriteHighestSlot
        rtl

        .databank 0

      aUnknown9FCD6C ; 9F/CD6C

        .word <>rlUnknown9FCD78, <>rlUnknown9FCD9A, <>aUnknown9FCED1


      aUnknown9FCD72 ; 9F/CD72

        .word <>rlUnknown9FCE44, <>rlUnknown9FCE62, <>aUnknown9FD004


      rlUnknown9FCD78 ; 9F/CD78

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F509F
        sta aActiveSpriteSystem.aUnknown001260,b,x
        lda $7F509B
        and #$00FF
        sta aActiveSpriteSystem.aUnknown001200,b,x
        lda $7F509C
        and #$00FF
        sta aActiveSpriteSystem.aUnknown001240,b,x
        lda #$0001
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        rtl

        .databank 0

      rlUnknown9FCD9A ; 9F/CD9A

        .al
        .xl
        .autsiz
        .databank ?

        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne _CDAC
        lda #$0001
        sta aMapAction.wMapBattleActiveSpriteSyncFlag
        lda #$CDAC
        sta aActiveSpriteSystem.aOnCycle,b,x

        _CDAC
        rtl

        .databank 0

      rlUnknown9FCDAD ; 9F/CDAD

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown9F8999
        lda aActiveSpriteSystem.aUnknown0013A0,b,x
        beq _CDCC
        stz aActiveSpriteSystem.aUnknown0013A0,b,x
        lda $7F5089
        cmp #$0020
        bne _CDCD
        lda #$0001
        sta $7F5093
        stz aActiveSpriteSystem.aTypeOffset,b,x

        _CDCC
        rtl


        _CDCD
        lda #$0001
        sta aActiveSpriteSystem.aFrameTimer,b,x
        lda #$CF73
        sta aActiveSpriteSystem.aCodeOffset,b,x
        lda #$CE02
        sta aActiveSpriteSystem.aOnCycle,b,x
        lda #$0018
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        lda #$0800
        sta aActiveSpriteSystem.aUnknown0013E0,b,x
        stz aActiveSpriteSystem.aUnknown0011E0,b,x
        stz aActiveSpriteSystem.aUnknown001220,b,x
        lda $7F509D
        and #$00FF
        sta aActiveSpriteSystem.aUnknown001200,b,x
        lda #$FFF8
        sta aActiveSpriteSystem.aUnknown001240,b,x
        rtl


        _CE02
        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne _CE0D
        lda #$CE0E
        sta aActiveSpriteSystem.aOnCycle,b,x

        _CE0D
        rtl

        .databank 0

      rlUnknown9FCE0E ; 9F/CE0E

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown9F8999
        lda $7F509E
        and #$00FF
        cmp aActiveSpriteSystem.aUnknown001240,b,x
        beq _CE21
        bmi _CE21
        rtl


        _CE21
        lda #$0001
        sta aActiveSpriteSystem.aUnknown0013A0,b,x
        lda #$CE34
        sta aActiveSpriteSystem.aOnCycle,b,x
        lda #$0030
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        rtl

        .databank 0

      rlUnknown9FCE34 ; 9F/CE34

        .al
        .xl
        .autsiz
        .databank ?

        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne _CE43
        lda #$0001
        sta $7F5093
        stz aActiveSpriteSystem.aTypeOffset,b,x

        _CE43
        rtl

        .databank 0

      rlUnknown9FCE44 ; 9F/CE44

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F509F
        sta aActiveSpriteSystem.aUnknown001260,b,x
        lda $7F509B
        and #$00FF
        sta aActiveSpriteSystem.aUnknown001200,b,x
        and #$FFF8
        sta aActiveSpriteSystem.aUnknown001240,b,x
        lda #$0001
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        rtl

        .databank 0

      rlUnknown9FCE62 ; 9F/CE62

        .al
        .xl
        .autsiz
        .databank ?

        lda #$CE8B
        sta aActiveSpriteSystem.aOnCycle,b,x
        lda #$0018
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        lda #$0800
        sta aActiveSpriteSystem.aUnknown0013E0,b,x
        stz aActiveSpriteSystem.aUnknown0011E0,b,x
        stz aActiveSpriteSystem.aUnknown001220,b,x
        lda $7F509B
        and #$00FF
        sta aActiveSpriteSystem.aUnknown001200,b,x
        lda #$FFF8
        sta aActiveSpriteSystem.aUnknown001240,b,x
        rtl

        .databank 0

      rlUnknown9FCE8B ; 9F/CE8B

        .al
        .xl
        .autsiz
        .databank ?

        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne _CE96
        lda #$CE97
        sta aActiveSpriteSystem.aOnCycle,b,x

        _CE96
        rtl

        .databank 0

      rlUnknown9FCE97 ; 9F/CE97

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown9F8999
        lda $7F509C
        and #$00FF
        cmp aActiveSpriteSystem.aUnknown001240,b,x
        beq _CEAA
        bmi _CEAA
        rtl


        _CEAA
        lda #$0001
        sta aActiveSpriteSystem.aUnknown0013A0,b,x
        lda #$CEC1
        sta aActiveSpriteSystem.aOnCycle,b,x
        lda #$0030
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        jsl rlUnknown9EF5AC
        rtl

        .databank 0

      rlUnknown9FCEC1 ; 9F/CEC1

        .al
        .xl
        .autsiz
        .databank ?

        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne _CED0
        lda #$0001
        sta $7F5093
        stz aActiveSpriteSystem.aTypeOffset,b,x

        _CED0
        rtl

        .databank 0

      aUnknown9FCED1 ; 9F/CED1

        .byte $00, $01, $97, $D0, $00, $02, $9E, $D0, $00, $08, $A5, $D0, $00, $03, $AC, $D0
        .byte $00, $03, $B3, $D0, $00, $02, $BA, $D0, $00, $03, $C1, $D0, $00, $03, $AC, $D0
        .byte $00, $03, $B3, $D0, $17, $58, $CF, $00, $03, $BA, $D0, $00, $03, $C1, $D0, $00
        .byte $03, $AC, $D0, $00, $03, $B3, $D0, $00, $03, $BA, $D0, $00, $03, $C1, $D0, $00
        .byte $03, $B3, $D0, $19, $00, $F6, $00, $05, $C8, $D0, $19, $00, $EE, $00, $01, $CF
        .byte $D0, $17, $35, $CF, $00, $01, $CF, $D0, $17, $45, $CF, $25, $CF, $00, $01, $95
        .byte $D0, $15, $2E, $CF

      rlUnknown9FCF35 ; 9F/CF35

        .al
        .xl
        .autsiz
        .databank ?

        lda #$F800
        sta aActiveSpriteSystem.aUnknown0013E0,b,x
        stz aActiveSpriteSystem.aUnknown0013C0,b,x
        lda #$CDAD
        sta aActiveSpriteSystem.aOnCycle,b,x
        rtl

        .databank 0

      rlUnknown9FCF45 ; 9F/CF45

        .al
        .xl
        .autsiz
        .databank ?

        lda aActiveSpriteSystem.aUnknown001240,b,x
        bmi _CF4F
        lda $0000,b,y
        tay
        rtl


        _CF4F
        inc y
        inc y
        lda #$0001
        sta aActiveSpriteSystem.aUnknown0013A0,b,x
        rtl

        .databank 0

      rlUnknown9FCF58 ; 9F/CF58

        .al
        .xl
        .autsiz
        .databank ?

        lda aMapAction.wMapBattleDefenderAuxSpriteSlot
        cmp #$FFFF
        beq _CF65
        jsl rlUnknown9FCF69

        _CF65
        lda aMapAction.wMapBattleDefenderSpriteSlot

        .databank 0

      rlUnknown9FCF69 ; 9F/CF69

        .al
        .xl
        .autsiz
        .databank ?

        phy
        tay
        lda #$FFFE
        sta aActiveSpriteSystem.aUnknown001240,b,y
        ply
        rtl

        .databank 0

      aUnknown9FCF73 ; 9F/CF73

        .byte $00, $01, $CF, $D0, $17, $F7, $CF, $73, $CF, $00, $03, $CF, $D0, $00, $03, $C8
        .byte $D0, $00, $03, $B3, $D0, $00, $03, $C1, $D0, $00, $03, $BA, $D0, $00, $03, $B3
        .byte $D0, $00, $03, $AC, $D0, $00, $03, $C1, $D0, $00, $03, $BA, $D0, $17, $CE, $CF
        .byte $00, $03, $B3, $D0, $00, $03, $AC, $D0, $00, $03, $C1, $D0, $00, $02, $BA, $D0
        .byte $00, $03, $B3, $D0, $00, $03, $AC, $D0, $00, $08, $A5, $D0, $00, $02, $9E, $D0
        .byte $00, $01, $97, $D0, $00, $01, $95, $D0, $15, $C7, $CF

      rlUnknown9FCFCE ; 9F/CFCE

        .al
        .xl
        .autsiz
        .databank ?

        lda aMapAction.wMapBattleDefenderAuxSpriteSlot
        cmp #$FFFF
        beq _CFDB
        jsl rlUnknown9FCFDF

        _CFDB
        lda aMapAction.wMapBattleDefenderSpriteSlot

        .databank 0

      rlUnknown9FCFDF ; 9F/CFDF

        .al
        .xl
        .autsiz
        .databank ?

        phy
        tay
        lda $7F509D
        and #$00FF
        sta aActiveSpriteSystem.aUnknown001200,b,y
        lda $7F509E
        and #$00FF
        sta aActiveSpriteSystem.aUnknown001240,b,y
        ply
        rtl

        .databank 0

      rlUnknown9FCFF7 ; 9F/CFF7

        .al
        .xl
        .autsiz
        .databank ?

        lda aActiveSpriteSystem.aUnknown0013A0,b,x
        beq _CFFF
        inc y
        inc y
        rtl


        _CFFF
        lda $0000,b,y
        tay
        rtl

        .databank 0

      aUnknown9FD004 ; 9F/D004

        .byte $00, $01, $CF, $D0, $17, $88, $D0, $04, $D0, $00, $03, $CF, $D0, $00, $03, $C8
        .byte $D0, $00, $03, $B3, $D0, $00, $03, $C1, $D0, $00, $03, $BA, $D0, $00, $03, $B3
        .byte $D0, $00, $03, $AC, $D0, $00, $03, $C1, $D0, $00, $03, $BA, $D0, $17, $5F, $D0
        .byte $00, $03, $B3, $D0, $00, $03, $AC, $D0, $00, $03, $C1, $D0, $00, $02, $BA, $D0
        .byte $00, $03, $B3, $D0, $00, $03, $AC, $D0, $00, $08, $A5, $D0, $00, $02, $9E, $D0
        .byte $00, $01, $97, $D0, $00, $01, $95, $D0, $15, $58

      rlUnknown9FD05E ; 9F/D05E

        .al
        .xl
        .autsiz
        .databank ?

        bne aUnknown9FD004+11
        tax
        eor wBufferBG1HOFS
        cmp #$FFFF
        beq _D06C
        jsl rlUnknown9FD070

        _D06C
        lda aMapAction.wMapBattleDefenderSpriteSlot

        .databank 0

      rlUnknown9FD070 ; 9F/D070

        .al
        .xl
        .autsiz
        .databank ?

        phy
        tay
        lda $7F509B
        and #$00FF
        sta aActiveSpriteSystem.aUnknown001200,b,y
        lda $7F509C
        and #$00FF
        sta aActiveSpriteSystem.aUnknown001240,b,y
        ply
        rtl

        .databank 0

      rlUnknown9FD088 ; 9F/D088

        .al
        .xl
        .autsiz
        .databank ?

        lda aActiveSpriteSystem.aUnknown0013A0,b,x
        beq _D090
        inc y
        inc y
        rtl


        _D090
        lda $0000,b,y
        tay
        rtl

        .databank 0

      aUnknown9F9FD095 ; 9F/9FD095

        .word 0

      aUnknown9F9FD097 ; 9F/9FD097

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $008, 2, 6, false, false]]

        .structSpriteArray aUnknown9F9FD097._Sprites

      aUnknown9F9FD09E ; 9F/9FD09E

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $008, 2, 6, false, false]]

        .structSpriteArray aUnknown9F9FD09E._Sprites

      aUnknown9F9FD0A5 ; 9F/9FD0A5

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $00A, 2, 6, false, false]]

        .structSpriteArray aUnknown9F9FD0A5._Sprites

      aUnknown9F9FD0AC ; 9F/9FD0AC

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $000, 2, 6, false, false]]

        .structSpriteArray aUnknown9F9FD0AC._Sprites

      aUnknown9F9FD0B3 ; 9F/9FD0B3

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $002, 2, 6, false, false]]

        .structSpriteArray aUnknown9F9FD0B3._Sprites

      aUnknown9F9FD0BA ; 9F/9FD0BA

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $004, 2, 6, false, false]]

        .structSpriteArray aUnknown9F9FD0BA._Sprites

      aUnknown9F9FD0C1 ; 9F/9FD0C1

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $006, 2, 6, false, false]]

        .structSpriteArray aUnknown9F9FD0C1._Sprites

      aUnknown9F9FD0C8 ; 9F/9FD0C8

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $002, 2, 6, false, false]]

        .structSpriteArray aUnknown9F9FD0C8._Sprites

      aUnknown9F9FD0CF ; 9F/9FD0CF

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $004, 2, 6, false, false]]

        .structSpriteArray aUnknown9F9FD0CF._Sprites


      rlUnknown9FD0D6 ; 9F/D0D6

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9F82D7

          .word <>procUnknown9FD0DC

        rtl

        .databank 0

      procUnknown9FD0DC ; 9F/D0DC

        .structProcInfo "ON", rlUnknown9FD0E4, rlUnknown9FD0E8, aProcUnknown9F805DCode


      rlUnknown9FD0E4 ; 9F/D0E4

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9F910A
        rtl

        .databank 0

      rlUnknown9FD0E8 ; 9F/D0E8

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9F9116
        bcc _D101
        lda #$D101
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #(`aUnknown9FD102)<<8
        sta lR44+1
        lda #<>aUnknown9FD102
        sta lR44
        jsl rlActiveSpriteEngineCreateSpriteHighestSlot

        _D101
        rtl

        .databank 0

      aUnknown9FD102 ; 9F/D102

        .word <>rlUnknown9FD108, <>$D128, <>aUnknown9FD139


      rlUnknown9FD108 ; 9F/D108

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
        sec
        sbc #$0008
        and #$00FF
        sta aActiveSpriteSystem.aUnknown001240,b,x
        rtl


        _D128
        rtl

        .databank 0

      rlUnknown9FD129 ; 9F/D129

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9F919F
        bcc _D138
        lda #$0001
        sta $7F5093
        stz aActiveSpriteSystem.aTypeOffset,b,x

        _D138
        rtl

        .databank 0

      aUnknown9FD139 ; 9F/D139

        .byte $17, $1B, $D2, $00, $05, $54, $D2, $00, $03, $65, $D2, $00, $03, $76, $D2, $00
        .byte $05, $87, $D2, $00, $06, $98, $D2, $17, $06, $D2, $00, $04, $2F, $D2, $17, $25
        .byte $D2, $00, $01, $31, $D2, $00, $03, $2F, $D2, $00, $01, $38, $D2, $00, $03, $2F
        .byte $D2, $00, $01, $38, $D2, $00, $03, $2F, $D2, $00, $01, $38, $D2, $00, $03, $2F
        .byte $D2, $00, $01, $3F, $D2, $00, $03, $2F, $D2, $00, $01, $3F, $D2, $00, $03, $2F
        .byte $D2, $00, $01, $3F, $D2, $00, $03, $2F, $D2, $17, $F7, $D1, $00, $01, $9F, $D2
        .byte $00, $03, $2F, $D2, $00, $01, $9F, $D2, $00, $02, $2F, $D2, $00, $01, $AB, $D2
        .byte $00, $02, $2F, $D2, $00, $01, $AB, $D2, $00, $01, $2F, $D2, $00, $01, $AB, $D2
        .byte $00, $02, $2F, $D2, $00, $01, $B7, $D2, $00, $03, $2F, $D2, $00, $01, $B7, $D2
        .byte $00, $03, $2F, $D2, $00, $01, $46, $D2, $00, $03, $2F, $D2, $00, $01, $46, $D2
        .byte $00, $03, $2F, $D2, $00, $01, $4D, $D2, $00, $03, $2F, $D2, $00, $01, $4D, $D2
        .byte $00, $03, $2F, $D2, $17, $FF, $D1, $00, $01, $2F, $D2, $15, $F0, $D1

      rlUnknown9FD1F7 ; 9F/D1F7

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0001
        sta aMapAction.wMapBattleActiveSpriteSyncFlag
        rtl

        .databank 0

      rlUnknown9FD1FF ; 9F/D1FF

        .al
        .xl
        .autsiz
        .databank ?

        lda #$D129
        sta aActiveSpriteSystem.aOnCycle,b,x
        rtl

        .databank 0

      rlUnknown9FD206 ; 9F/D206

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F509B
        and #$00FF
        sta aActiveSpriteSystem.aUnknown001200,b,x
        lda $7F509C
        and #$00FF
        sta aActiveSpriteSystem.aUnknown001240,b,x
        rtl

        .databank 0

      rlUnknown9FD21B ; 9F/D21B

        .al
        .xl
        .autsiz
        .databank ?

        phy
        lda aActiveSpriteSystem.aUnknown001200,b,x
        jsr rsUnknown9F8253

          .byte $5A

        ply
        rtl

        .databank 0

      rlUnknown9FD225 ; 9F/D225

        .al
        .xl
        .autsiz
        .databank ?

        phy
        lda aActiveSpriteSystem.aUnknown001200,b,x
        jsr rsUnknown9F8253

          .byte $5B

        ply
        rtl

        .databank 0

      aUnknown9F9FD22F ; 9F/9FD22F

        .word 0

      aUnknown9F9FD231 ; 9F/9FD231

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $000, 2, 6, false, false]]

        .structSpriteArray aUnknown9F9FD231._Sprites

      aUnknown9F9FD238 ; 9F/9FD238

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $002, 2, 6, false, false]]

        .structSpriteArray aUnknown9F9FD238._Sprites

      aUnknown9F9FD23F ; 9F/9FD23F

        _Sprites := [[(  -8,   -9), $21, SpriteLarge, $004, 2, 6, false, false]]

        .structSpriteArray aUnknown9F9FD23F._Sprites

      aUnknown9F9FD246 ; 9F/9FD246

        _Sprites := [[(  -8,  -26), $21, SpriteLarge, $006, 2, 6, false, false]]

        .structSpriteArray aUnknown9F9FD246._Sprites

      aUnknown9F9FD24D ; 9F/9FD24D

        _Sprites := [[(  -8,  -33), $21, SpriteLarge, $008, 2, 6, false, false]]

        .structSpriteArray aUnknown9F9FD24D._Sprites

      aUnknown9F9FD254 ; 9F/9FD254

        _Sprites := [[(  -2,    0), $00, SpriteSmall, $00B, 2, 6, false, false]]
        _Sprites ..= [[( -10,    0), $00, SpriteSmall, $01B, 2, 6, false, false]]
        _Sprites ..= [[(  -7,   -7), $00, SpriteSmall, $00A, 2, 6, false, false]]

        .structSpriteArray aUnknown9F9FD254._Sprites

      aUnknown9F9FD265 ; 9F/9FD265

        _Sprites := [[(  -2,   -3), $00, SpriteSmall, $01B, 2, 6, false, false]]
        _Sprites ..= [[( -10,   -4), $00, SpriteSmall, $00B, 2, 6, false, false]]
        _Sprites ..= [[(  -7,  -13), $00, SpriteSmall, $01A, 2, 6, false, false]]

        .structSpriteArray aUnknown9F9FD265._Sprites

      aUnknown9F9FD276 ; 9F/9FD276

        _Sprites := [[(  -2,   -4), $00, SpriteSmall, $00B, 2, 6, false, false]]
        _Sprites ..= [[( -10,   -9), $00, SpriteSmall, $01B, 2, 6, false, false]]
        _Sprites ..= [[(  -7,  -22), $00, SpriteSmall, $00A, 2, 6, false, false]]

        .structSpriteArray aUnknown9F9FD276._Sprites

      aUnknown9F9FD287 ; 9F/9FD287

        _Sprites := [[(  -2,   -7), $00, SpriteSmall, $01B, 2, 6, false, false]]
        _Sprites ..= [[( -10,  -15), $00, SpriteSmall, $00B, 2, 6, false, false]]
        _Sprites ..= [[(  -7,  -29), $00, SpriteSmall, $01A, 2, 6, false, false]]

        .structSpriteArray aUnknown9F9FD287._Sprites

      aUnknown9F9FD298 ; 9F/9FD298

        _Sprites := [[(  -6,  -39), $00, SpriteSmall, $00B, 2, 6, false, false]]

        .structSpriteArray aUnknown9F9FD298._Sprites

      aUnknown9F9FD29F ; 9F/9FD29F

        _Sprites := [[(  -8,    0), $21, SpriteLarge, $00C, 2, 6, false, false]]
        _Sprites ..= [[(  -8,  -15), $21, SpriteLarge, $004, 2, 6, false, false]]

        .structSpriteArray aUnknown9F9FD29F._Sprites

      aUnknown9F9FD2AB ; 9F/9FD2AB

        _Sprites := [[(  -8,   -4), $21, SpriteLarge, $00C, 2, 6, false, false]]
        _Sprites ..= [[(  -8,  -19), $21, SpriteLarge, $004, 2, 6, false, false]]

        .structSpriteArray aUnknown9F9FD2AB._Sprites

      aUnknown9F9FD2B7 ; 9F/9FD2B7

        _Sprites := [[(   0,   -9), $00, SpriteSmall, $017, 2, 6, false, false]]
        _Sprites ..= [[(  -8,   -9), $00, SpriteSmall, $016, 2, 6, false, false]]
        _Sprites ..= [[(  -8,  -22), $21, SpriteLarge, $004, 2, 6, false, false]]

        .structSpriteArray aUnknown9F9FD2B7._Sprites


      rlUnknown9FD2C8 ; 9F/D2C8

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aUnknown9FD2D7)<<8
        sta lR44+1
        lda #<>aUnknown9FD2D7
        sta lR44
        jsl rlActiveSpriteEngineCreateSpriteHighestSlot
        rtl

        .databank 0

      aUnknown9FD2D7 ; 9F/D2D7

        .word <>rlUnknown9FD2DD, <>rlUnknown9FD2FF, <>aUnknown9FD399


      rlUnknown9FD2DD ; 9F/D2DD

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
        sta aActiveSpriteSystem.aUnknown001240,b,x
        lda #$000A
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        rtl

        .databank 0

      rlUnknown9FD2FF ; 9F/D2FF

        .al
        .xl
        .autsiz
        .databank ?

        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne _D340
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
        jsl rlUnknown9F89F8
        lsr a
        lsr a
        bne _D329
        lda #$0002

        _D329
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        lda wR0
        sta aActiveSpriteSystem.aUnknown0012E0,b,x
        lda #$0400
        sta aActiveSpriteSystem.aUnknown001300,b,x
        jsr rsUnknown9F9379
        lda #$D341
        sta aActiveSpriteSystem.aOnCycle,b,x

        _D340
        rtl

        .databank 0

      rlUnknown9FD341 ; 9F/D341

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown9F8999
        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne rlUnknown9FD2FF._D340
        lda #$0001
        sta aMapAction.wMapBattleActiveSpriteSyncFlag
        sta aActiveSpriteSystem.aUnknown001320,b,x
        lda #$0020
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        lda #$D361
        sta aActiveSpriteSystem.aOnCycle,b,x
        rtl

        .databank 0

      rlUnknown9FD361 ; 9F/D361

        .al
        .xl
        .autsiz
        .databank ?

        lda aActiveSpriteSystem.aUnknown001300,b,x
        sec
        sbc #$00C0
        bcs _D36D
        lda #$0000

        _D36D
        sta aActiveSpriteSystem.aUnknown001300,b,x
        jsr rsUnknown9F9379
        jsl rlUnknown9F8999
        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne rlUnknown9FD2FF._D340
        lda #$0010
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        lda #$D389
        sta aActiveSpriteSystem.aOnCycle,b,x
        rtl

        .databank 0

      rlUnknown9FD389 ; 9F/D389

        .al
        .xl
        .autsiz
        .databank ?

        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne rlUnknown9FD2FF._D340
        lda #$0001
        sta $7F5093
        stz aActiveSpriteSystem.aTypeOffset,b,x
        rtl

        .databank 0

      aUnknown9FD399 ; 9F/D399

        .byte $00, $04, $E4, $D3, $00, $05, $EB, $D3, $00, $06, $F2, $D3, $00, $09, $F9, $D3
        .byte $00, $03, $F9, $D3, $00, $03, $00, $D4, $17, $D5, $D3, $A9, $D3, $00, $05, $07
        .byte $D4, $00, $20, $0E, $D4, $00, $09, $F9, $D3, $00, $06, $F2, $D3, $00, $05, $EB
        .byte $D3, $00, $04, $E4, $D3, $00, $09, $E2, $D3, $15, $CE, $D3

      rlUnknown9FD3D5 ; 9F/D3D5

        .al
        .xl
        .autsiz
        .databank ?

        lda aActiveSpriteSystem.aUnknown001320,b,x
        bne _D3DF
        lda $0000,b,y
        tay
        rtl


        _D3DF
        inc y
        inc y
        rtl

        .databank 0

      aUnknown9F9FD3E2 ; 9F/9FD3E2

        .word 0

      aUnknown9F9FD3E4 ; 9F/9FD3E4

        _Sprites := [[(  -4,   -4), $00, SpriteSmall, $00C, 2, 6, false, false]]

        .structSpriteArray aUnknown9F9FD3E4._Sprites

      aUnknown9F9FD3EB ; 9F/9FD3EB

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $000, 2, 6, false, false]]

        .structSpriteArray aUnknown9F9FD3EB._Sprites

      aUnknown9F9FD3F2 ; 9F/9FD3F2

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $002, 2, 6, false, false]]

        .structSpriteArray aUnknown9F9FD3F2._Sprites

      aUnknown9F9FD3F9 ; 9F/9FD3F9

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $004, 2, 6, false, false]]

        .structSpriteArray aUnknown9F9FD3F9._Sprites

      aUnknown9F9FD400 ; 9F/9FD400

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $006, 2, 6, false, false]]

        .structSpriteArray aUnknown9F9FD400._Sprites

      aUnknown9F9FD407 ; 9F/9FD407

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $008, 2, 6, false, false]]

        .structSpriteArray aUnknown9F9FD407._Sprites

      aUnknown9F9FD40E ; 9F/9FD40E

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $00A, 2, 6, false, false]]

        .structSpriteArray aUnknown9F9FD40E._Sprites

      aUnknown9F9FD415 ; 9F/9FD415

        _Sprites := [[(  -4,   -4), $00, SpriteSmall, $01C, 2, 6, false, false]]

        .structSpriteArray aUnknown9F9FD415._Sprites

      aUnknown9F9FD41C ; 9F/9FD41C

        _Sprites := [[(  -4,   -4), $00, SpriteSmall, $00D, 2, 6, false, false]]

        .structSpriteArray aUnknown9F9FD41C._Sprites

      aUnknown9F9FD423 ; 9F/9FD423

        _Sprites := [[(  -4,   -4), $00, SpriteSmall, $01D, 2, 6, false, false]]

        .structSpriteArray aUnknown9F9FD423._Sprites


      rlUnknown9FD42A ; 9F/D42A

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9F82D7

          .word <>procUnknown9FD430

        rtl

        .databank 0

      procUnknown9FD430 ; 9F/D430

        .structProcInfo "ON", rlUnknown9FD443, rlUnknown9FD463, aProcUnknown9FD438Code


      aProcUnknown9FD438Code ; 9F/D438

        PROC_YIELD 1
        PROC_CALL rlUnknown9FD4C6
        PROC_JUMP aProcUnknown9FD438Code


      rlUnknown9FD443 ; 9F/D443

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
        jsr rsUnknown9F910A
        rtl

        .databank 0

      rlUnknown9FD463 ; 9F/D463

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9F9136
        bcc _D474
        lda #$D475
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0020
        sta aProcSystem.aBody0,b,x

        _D474
        rtl

        .databank 0

      rlUnknown9FD475 ; 9F/D475

        .al
        .xl
        .autsiz
        .databank ?

        dec aProcSystem.aBody0,b,x
        bpl _D489
        jsr rsUnknown9FD497
        lda #$D48A
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0080
        sta aProcSystem.aBody0,b,x

        _D489
        rtl

        .databank 0

      rlUnknown9FD48A ; 9F/D48A

        .al
        .xl
        .autsiz
        .databank ?

        dec aProcSystem.aBody0,b,x
        bne _D495
        lda #$D496
        sta aProcSystem.aHeaderOnCycle,b,x

        _D495
        rtl

        .databank 0

      rlUnknown9FD496 ; 9F/D496

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

      rsUnknown9FD497 ; 9F/D497

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9F82D7

          .word <>procUnknown9FD7A0

        jsr rsUnknown9F830F

          .word <>aUnknown9FDBB8

        jsr rsUnknown9F830F

          .word <>aUnknown9FDC34

        jsr rsUnknown9F830F

          .word <>aUnknown9FDB6C

        jsr rsUnknown9F830F

          .word <>aUnknown9FDB7F

        jsr rsUnknown9F830F

          .word <>aUnknown9FDE7E

        phx
        lda #(`aUnknown9FD5D2)<<8
        sta lR44+1
        lda #<>aUnknown9FD5D2
        sta lR44
        jsl rlActiveSpriteEngineCreateSpriteLastSlot
        plx
        rts

        .databank 0

      rlUnknown9FD4C6 ; 9F/D4C6

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aBody2,b,x
        beq _D4D0
        dec a
        sta aProcSystem.aBody2,b,x
        rtl


        _D4D0
        lda #$0002
        sta aProcSystem.aBody2,b,x
        phx
        lda aProcSystem.aBody3,b,x
        inc aProcSystem.aBody3,b,x
        cmp #$0010
        bmi _D4E5
        stz aProcSystem.aBody3,b,x

        _D4E5
        asl a
        tax
        lda $D513,b,x
        sta $01D2,b
        lda $D515,b,x
        sta $01D4,b
        lda $D517,b,x
        sta $01D6,b
        lda $D519,b,x
        sta $01D8,b
        lda $D51B,b,x
        sta $01DA,b
        lda $D51D,b,x
        sta $01DC,b
        lda $D51F,b,x
        sta $01DE,b
        plx
        rtl

        .databank 0

      aUnknown9FD513 ; 9F/D513

        .word $03FF, $033F, $025F, $019F, $019F, $025F, $033F, $03FF
        .word $03FF, $033F, $025F, $019F, $019F, $025F, $033F, $03FF
        .word $03FF, $033F, $025F, $019F, $019F, $025F, $033F, $03FF
        .word $03FF

      rlUnknown9FD545 ; 9F/D545

        .al
        .xl
        .autsiz
        .databank ?

        lda aActiveSpriteSystem.aUnknown001320,b,x
        beq _D54F
        dec a
        sta aActiveSpriteSystem.aUnknown001320,b,x
        rtl


        _D54F
        lda #$0003
        sta aActiveSpriteSystem.aUnknown001320,b,x
        phx
        lda aActiveSpriteSystem.aUnknown001340,b,x
        inc aActiveSpriteSystem.aUnknown001340,b,x
        cmp #$0010
        bmi _D564
        stz aActiveSpriteSystem.aUnknown001340,b,x

        _D564
        asl a
        tax
        lda $D592,b,x
        sta $02D2,b
        lda $D594,b,x
        sta $02D4,b
        lda $D596,b,x
        sta $02D6,b
        lda $D598,b,x
        sta $02D8,b
        lda $D59A,b,x
        sta $02DA,b
        lda $D59C,b,x
        sta $02DC,b
        lda $D59E,b,x
        sta $02DE,b
        plx
        rtl

        .databank 0

      aUnknown9FD592 ; 9F/D592

        .word $02FF, $025F, $01FC, $01B7, $00F5, $14B0, $00F5, $01B7
        .word $025F, $02FF, $025F, $01B7, $00F5, $14B0, $00F5, $01FC
        .word $02FF, $025F, $01FC, $01B7, $00F5, $14B0, $00F5, $01B7
        .word $025F, $02FF, $025F, $01B7, $00F5, $14B0, $00F5, $01FC

      aUnknown9FD5D2 ; 9F/D5D2

        .word <>rlUnknown9FD5D8, <>rlUnknown9FD5F8, <>aUnknown9FD70E


      rlUnknown9FD5D8 ; 9F/D5D8

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F509F
        sta aActiveSpriteSystem.aUnknown001260,b,x
        lda $7F509B
        and #$00FF
        sta aActiveSpriteSystem.aUnknown001200,b,x
        lda $7F509C
        clc
        adc #$0002
        and #$00FF
        sta aActiveSpriteSystem.aUnknown001240,b,x
        rtl

        .databank 0

      rlUnknown9FD5F8 ; 9F/D5F8

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown9FD545
        lda $7ECC06
        beq _D60C
        lda #$0001
        sta $7F5093
        stz aActiveSpriteSystem.aTypeOffset,b,x

        _D60C
        rtl

        .databank 0

      aUnknown9FD60D ; 9F/D60D

        .word <>rlUnknown9FD620, <>rlUnknown9FD69D, <>aUnknown9FD6BA


      aUnknown9FD613 ; 9F/D613

        .word <>rlUnknown9FD619, <>rlUnknown9FD69D, <>aUnknown9FD6E4


      rlUnknown9FD619 ; 9F/D619

        .al
        .xl
        .autsiz
        .databank ?

        lda #$8000
        sta wR2
        bra rlUnknown9FD620._D622

        .databank 0

      rlUnknown9FD620 ; 9F/D620

        .al
        .xl
        .autsiz
        .databank ?

        stz wR2

        _D622
        lda $7F509F
        sta aActiveSpriteSystem.aUnknown001260,b,x
        ldy wR0
        lda $D67D,b,y
        bit wR2
        bpl _D636
        eor #$FFFF
        inc a

        _D636
        sta wR3
        lda $7F509B
        and #$00FF
        clc
        adc wR3
        sec
        sbc aActiveSpriteSystem.aUnknown001200,b,x
        sta wR0
        lda $7F509C
        clc
        adc $D67F,b,y
        and #$00FF
        sec
        sbc aActiveSpriteSystem.aUnknown001240,b,x
        sta wR1
        jsl rlUnknown9F89F8
        lsr a
        lsr a
        bne _D664
        lda #$0002

        _D664
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        lda wR0
        sta aActiveSpriteSystem.aUnknown0012E0,b,x
        lda #$0400
        sta aActiveSpriteSystem.aUnknown001300,b,x
        jsr rsUnknown9F9379
        lda aActiveSpriteSystem.aUnknown001200,b,x
        jsr rsUnknown9F8253

          .byte $4D

        rtl

        .databank 0

      aUnknown9FD67D ; 9F/D67D

        .byte $F0, $FF, $02, $00, $00, $00, $00, $00, $F8, $FF, $06, $00, $00, $00, $00, $00
        .byte $F0, $FF, $02, $00, $00, $00, $00, $00, $F8, $FF, $06, $00, $00, $00, $00, $00

      rlUnknown9FD69D ; 9F/D69D

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown9F8999
        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne _D6B8
        lda #$0001
        sta aActiveSpriteSystem.aUnknown001320,b,x
        lda #$0020
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        lda #$D6B9
        sta aActiveSpriteSystem.aOnCycle,b,x

        _D6B8
        rtl


        _D6B9
        rtl

        .databank 0

      aUnknown9FD6BA ; 9F/D6BA

        .byte $00, $01, $57, $D7, $17, $D4, $D6, $BA, $D6, $00, $04, $6A, $D7, $00, $04, $71
        .byte $D7, $00, $04, $78, $D7, $00, $01, $55, $D7, $01

      rlUnknown9FD6D4 ; 9F/D6D4

        .al
        .xl
        .autsiz
        .databank ?

        lda aActiveSpriteSystem.aUnknown001320,b,x
        cmp #$0001
        beq _D6E1
        lda $0000,b,y
        tay
        rtl


        _D6E1
        inc y
        inc y
        rtl

        .databank 0

      aUnknown9FD6E4 ; 9F/D6E4

        .byte $00, $01, $99, $D7, $17, $FE, $D6, $E4, $D6, $00, $04, $6A, $D7, $00, $04, $71
        .byte $D7, $00, $04, $78, $D7, $00, $01, $55, $D7, $01

      rlUnknown9FD6FE ; 9F/D6FE

        .al
        .xl
        .autsiz
        .databank ?

        lda aActiveSpriteSystem.aUnknown001320,b,x
        cmp #$0001
        beq _D70B
        lda $0000,b,y
        tay
        rtl


        _D70B
        inc y
        inc y
        rtl

        .databank 0

      aUnknown9FD70E ; 9F/D70E

        .byte $00, $01, $55, $D7, $17, $3F, $D7, $0E, $D7, $00, $06, $7F, $D7, $00, $05, $86
        .byte $D7, $00, $03, $8D, $D7, $00, $01, $5E, $D7, $17, $47, $D7, $23, $D7, $00, $02
        .byte $8D, $D7, $00, $02, $86, $D7, $00, $02, $7F, $D7, $00, $01, $55, $D7, $15, $38
        .byte $D7

      rlUnknown9FD73F ; 9F/D73F

        .al
        .xl
        .autsiz
        .databank ?

        lda $7ECC08
        bne _D752
        bra _D74D


        _D747
        lda $7ECC0A
        bne _D752

        _D74D
        lda $0000,b,y
        tay
        rtl


        _D752
        inc y
        inc y
        rtl

        .databank 0

      aUnknown9F9FD755 ; 9F/9FD755

        .word 0

      aUnknown9F9FD757 ; 9F/9FD757

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $000, 2, 6, false, false]]

        .structSpriteArray aUnknown9F9FD757._Sprites

      aUnknown9F9FD75E ; 9F/9FD75E

        _Sprites := [[(   0,   -5), $21, SpriteLarge, $004, 2, 6, false, false]]
        _Sprites ..= [[( -16,   -5), $21, SpriteLarge, $002, 2, 6, false, false]]

        .structSpriteArray aUnknown9F9FD75E._Sprites

      aUnknown9F9FD76A ; 9F/9FD76A

        _Sprites := [[(  -4,   -4), $00, SpriteSmall, $016, 2, 6, false, false]]

        .structSpriteArray aUnknown9F9FD76A._Sprites

      aUnknown9F9FD771 ; 9F/9FD771

        _Sprites := [[(  -4,   -4), $00, SpriteSmall, $006, 2, 6, false, false]]

        .structSpriteArray aUnknown9F9FD771._Sprites

      aUnknown9F9FD778 ; 9F/9FD778

        _Sprites := [[(  -4,   -4), $00, SpriteSmall, $017, 2, 6, false, false]]

        .structSpriteArray aUnknown9F9FD778._Sprites

      aUnknown9F9FD77F ; 9F/9FD77F

        _Sprites := [[(  -4,   -1), $00, SpriteSmall, $007, 2, 6, false, false]]

        .structSpriteArray aUnknown9F9FD77F._Sprites

      aUnknown9F9FD786 ; 9F/9FD786

        _Sprites := [[(  -8,   -5), $21, SpriteLarge, $008, 2, 6, false, false]]

        .structSpriteArray aUnknown9F9FD786._Sprites

      aUnknown9F9FD78D ; 9F/9FD78D

        _Sprites := [[(   5,   -5), $21, SpriteLarge, $00C, 2, 6, false, false]]
        _Sprites ..= [[( -11,   -5), $21, SpriteLarge, $00A, 2, 6, false, false]]

        .structSpriteArray aUnknown9F9FD78D._Sprites

      aUnknown9F9FD799 ; 9F/9FD799

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $000, 2, 6, true, false]]

        .structSpriteArray aUnknown9F9FD799._Sprites


      procUnknown9FD7A0 ; 9F/D7A0

        .structProcInfo "ON", rlUnknown9FD7A8, rlUnknown9FD823, aProcUnknown9F805DCode


      rlUnknown9FD7A8 ; 9F/D7A8

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0020
        sta aProcSystem.aBody0,b,x
        stz aProcSystem.aBody1,b,x
        stz aProcSystem.aBody2,b,x
        lda $7F509B
        and #$00FF
        cmp #$00C0
        bmi _D7F3
        lda $7F509C
        and #$00FF
        sta wR10
        lda #$0035
        sta wR11
        jsl rlUnsignedMultiply16By16
        lda $7F509B
        and #$00FF
        sec
        sbc wR12+1
        and #$00FF
        xba
        sta aProcSystem.aBody5,b,x
        lda #$C800
        sta aProcSystem.aBody3,b,x
        sta aProcSystem.aBody4,b,x
        sta aProcSystem.aBody7,b,x
        jml rlUnknown9FECB2


        _D7F3
        lda $7F509C
        and #$00FF
        sta wR10
        lda #$0035
        sta wR11
        jsl rlUnsignedMultiply16By16
        lda wR12+1
        clc
        adc $7F509B
        and #$00FF
        xba
        sta aProcSystem.aBody5,b,x
        lda #$B800
        sta aProcSystem.aBody3,b,x
        sta aProcSystem.aBody4,b,x
        sta aProcSystem.aBody7,b,x
        jml rlUnknown9FECB2

        .databank 0

      rlUnknown9FD823 ; 9F/D823

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F509C
        and #$00FF
        sta wR0
        lda aProcSystem.aBody1,b,x
        clc
        adc #$0006
        sta aProcSystem.aBody1,b,x
        cmp wR0
        bmi _D852
        lda #$0001
        sta $7ECC08
        lda wR0
        sta aProcSystem.aBody1,b,x
        lda #$0006
        sta aProcSystem.aBody0,b,x
        lda #$D86A
        sta aProcSystem.aHeaderOnCycle,b,x

        _D852
        sta wR1
        lda aProcSystem.aBody5,b,x
        sta wR2
        lda aProcSystem.aBody3,b,x
        sta wR4
        lda aProcSystem.aBody4,b,x
        sta wR5
        lda aProcSystem.aBody2,b,x
        jsr rsUnknown9FD9F3
        rtl

        .databank 0

      rlUnknown9FD86A ; 9F/D86A

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9FD9DC
        dec aProcSystem.aBody0,b,x
        bne _D898
        lda #$D8A9
        sta aProcSystem.aHeaderOnCycle,b,x
        lda $7F509C
        and #$00FF
        lsr a
        lsr a
        lsr a
        lsr a
        tay
        lda $D899,b,y
        and #$00FF
        sta aProcSystem.aBody0,b,x
        lda $7F509B
        and #$00FF
        jsr rsUnknown9F8253

          .byte $64


        _D898
        rtl

        .databank 0

      aUnknown9FD899 ; 9F/D899

        .byte $16, $12, $0E, $0C, $0A, $09, $08, $07, $07, $06, $05, $05, $05, $05, $05, $05

      rlUnknown9FD8A9 ; 9F/D8A9

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aBody3,b,x
        clc
        adc #$FF80
        sta aProcSystem.aBody3,b,x
        lda aProcSystem.aBody4,b,x
        clc
        adc #$0080
        sta aProcSystem.aBody4,b,x
        lda aProcSystem.aBody1,b,x
        sta wR1
        lda aProcSystem.aBody3,b,x
        sta wR4
        lda aProcSystem.aBody4,b,x
        sta wR5
        lda aProcSystem.aBody5,b,x
        sta wR2
        lda aProcSystem.aBody2,b,x
        clc
        adc #$0100
        sta aProcSystem.aBody2,b,x
        dec aProcSystem.aBody0,b,x
        bne _D8EF
        lda #$D8F6
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0080
        sta aProcSystem.aBody0,b,x
        stz aProcSystem.aBody6,b,x

        _D8EF
        lda aProcSystem.aBody2,b,x
        jsr rsUnknown9FD9F3
        rtl

        .databank 0

      rlUnknown9FD8F6 ; 9F/D8F6

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aBody0,b,x
        cmp #$0010
        bne _D905
        lda #$0001
        sta aMapAction.wMapBattleActiveSpriteSyncFlag

        _D905
        lda aProcSystem.aBody0,b,x
        and #$001F
        bne rlUnknown9FD915._D948
        phx
        lda aProcSystem.aBody6,b,x
        asl a
        asl a
        sta wR0

        .databank 0

      rlUnknown9FD915 ; 9F/D915

        .al
        .xl
        .autsiz
        .databank ?

        inc aProcSystem.aBody6,b,x
        lda aProcSystem.aBody5,b,x
        and #$FF00
        xba
        tax
        ldy #$0000
        lda #(`aUnknown9FD60D)<<8
        sta lR44+1
        lda #<>aUnknown9FD60D
        sta lR44
        lda $7F509B
        and #$00FF
        cmp #$00C0
        bmi _D943
        lda #(`aUnknown9FD613)<<8
        sta lR44+1
        lda #<>aUnknown9FD613
        sta lR44

        _D943
        jsl rlActiveSpriteEngineCreateSpriteHighestSlot
        plx

        _D948
        dec aProcSystem.aBody0,b,x
        bne _D960
        lda #$D961
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0006
        sta aProcSystem.aBody0,b,x
        lda #$0001
        sta $7ECC0A

        _D960
        rtl

        .databank 0

      rlUnknown9FD961 ; 9F/D961

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aBody3,b,x
        clc
        adc #$0100
        cmp aProcSystem.aBody7,b,x
        bcc _D970
        lda aProcSystem.aBody7,b,x

        _D970
        sta aProcSystem.aBody3,b,x
        lda aProcSystem.aBody4,b,x
        clc
        adc #$FF00
        cmp aProcSystem.aBody7,b,x
        bcs _D982
        lda aProcSystem.aBody7,b,x

        _D982
        sta aProcSystem.aBody4,b,x
        lda aProcSystem.aBody2,b,x
        clc
        adc #$FE00
        bpl _D991
        lda #$0000

        _D991
        sta aProcSystem.aBody2,b,x
        lda aProcSystem.aBody1,b,x
        sta wR1
        lda aProcSystem.aBody3,b,x
        and #$FF00
        sta wR4
        lda aProcSystem.aBody4,b,x
        and #$FF00
        sta wR5
        lda aProcSystem.aBody5,b,x
        sta wR2
        dec aProcSystem.aBody0,b,x
        bne _D9C2
        lda #$D9C9
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0000
        sta aProcSystem.aBody2,b,x
        jsr rsUnknown9F8359

        _D9C2
        lda aProcSystem.aBody2,b,x
        jsr rsUnknown9FD9F3
        rtl

        .databank 0

      rlUnknown9FD9C9 ; 9F/D9C9

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9F919F
        bcc _D9DB
        lda #$D9DB
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0001
        sta $7ECC06

        _D9DB
        rtl

        .databank 0

      rsUnknown9FD9DC ; 9F/D9DC

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aBody1,b,x
        sta wR1
        lda aProcSystem.aBody3,b,x
        sta wR4
        lda aProcSystem.aBody4,b,x
        sta wR5
        lda aProcSystem.aBody5,b,x
        sta wR2
        lda aProcSystem.aBody2,b,x

        .databank 0

      rsUnknown9FD9F3 ; 9F/D9F3

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lsr a
        pha
        clc
        adc wR2
        bcc _D9FE
        lda #$FFFF

        _D9FE
        sta wR3
        lda wR2
        sec
        sbc #1,s
        bcs _DA0A
        lda #$0000

        _DA0A
        sta wR2
        pla
        lda wR4+1
        and #$00FF
        sta wR0
        lda #$0100
        jsl rlUnknown9F8B7A._8B84
        sta wR8
        bpl _DA23
        eor #$FFFF
        inc a

        _DA23
        xba
        sta $4204,b
        lda wR4+1
        and #$00FF
        sta wR0
        lda #$0100
        jsl rlUnknown9F8B7A
        sep #$20
        sta $4206,b
        nop
        nop
        nop
        nop
        nop
        nop
        rep #$20
        lda $4214,b
        bit wR8
        bpl _DA4D
        eor #$FFFF

        _DA4C
        inc a

        _DA4D
        sta wR6
        lda wR5+1
        and #$00FF
        sta wR0
        lda #$0100
        jsl rlUnknown9F8B7A._8B84
        sta wR8
        bpl _DA65
        eor #$FFFF
        inc a

        _DA65
        xba
        sta $4204,b
        lda wR5+1
        and #$00FF
        sta wR0
        lda #$0100
        jsl rlUnknown9F8B7A
        sep #$20
        sta $4206,b
        nop
        nop
        nop
        nop
        nop
        nop
        rep #$20
        lda $4214,b
        bit wR8
        bpl _DA8F
        eor #$FFFF
        inc a

        _DA8F
        sta wR7
        lda #$50EA
        sta $2181,b
        sep #$20
        lda #$01
        sta $2183,b
        rep #$20
        ldx #$0000
        ldy #$0000

        _DAA6
        lda wR2
        clc
        adc wR6
        sta wR2
        and #$FF00
        cmp #$0800
        bcs _DAB8
        lda #$0800

        _DAB8
        xba
        sep #$20
        sta $2180,b
        rep #$20
        lda wR3
        clc
        adc wR7
        sta wR3
        and #$FF00
        cmp #$F700
        bcc _DAD2
        lda #$F700

        _DAD2
        xba
        sep #$20
        sta $2180,b
        rep #$20
        inc x
        cpx wR1
        bmi _DAA6
        stx wR1
        lda wR3
        sec
        sbc wR2
        cmp #$0100
        bmi _DB4E
        clc
        adc #$0A00
        and #$FE00
        xba
        lsr a
        and #$FFFE
        bne _DAFC
        lda #$0002

        _DAFC
        tay
        inc a
        asl a
        tax
        phb
        pea #$9A00
        plb
        .databank ?
        plb
        .databank ?
        lda aUnknown9AA30A,x
        clc
        adc #<>aUnknown9AA30A
        tax
        dec x
        lda wR2+1
        clc
        adc wR3+1
        and #$01FF
        lsr a
        sta wR0

        _DB1B
        sep #$20
        lda wR0
        sec
        sbc $0000,b,x
        bcs _DB27
        lda #$00

        _DB27
        cmp wR2+1
        bcs _DB2D
        lda wR2+1

        _DB2D
        sta $2180,b
        lda $0000,b,x
        clc
        adc wR0
        bcc _DB3A
        lda #$F8

        _DB3A
        cmp wR3+1
        bcc _DB40
        lda wR3+1

        _DB40
        sta $2180,b
        rep #$20
        dec wR1
        dec x
        dec x
        dec y
        dec y
        bne _DB1B
        plb
        .databank ?

        _DB4E
        ldx wR1
        bra _DB61


        _DB52
        sep #$20
        lda #$FF
        sta $2180,b
        lda #$00
        sta $2180,b
        rep #$20
        inc x

        _DB61
        cpx #$00E0
        bmi _DB52
        plx
        rts

        .databank 0

    .endsection Unsorted9F9ABFSection

.section Unsorted9FDB68Section

      .al
      .xl

      rlUnknown9FDB68 ; 9F/DB68

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 9F/DB69

      rlUnknown9FDB69 ; 9F/DB69

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 9F/DB6A


      aHDMAUnknown9FDB6ACode ; 9F/DB6A

        HDMA_HALT

      aUnknown9FDB6C .dstruct structHDMAIndirectEntryInfo, rlUnknown9FDB68, rlUnknown9FDB69, aHDMAUnknown9FDB6ACode, aUnknown9FDB78, PPU_REG_BASE + $28, DMAP_HDMA_Setting(DMAP_CPUToIO, true, DMAP_Mode1), $7F ; 9F/DB6C

      aUnknown9FDB78 ; 9F/DB78

        .byte $FF, $EA, $50, $E0, $E8, $51, $00

      aUnknown9FDB7F .dstruct structHDMAIndirectEntryInfo, rlUnknown9FDB8B, rlUnknown9FDB69, aHDMAUnknown9FDB6ACode, aUnknown9FDBA1, PPU_REG_BASE + $08, DMAP_HDMA_Setting(DMAP_CPUToIO, false, DMAP_Mode0), $9F ; 9F/DB7F

    .endsection Unsorted9FDB68Section


    .section Unsorted9FDB8BSection

      .al
      .xl

      rlUnknown9FDB8B ; 9F/DB8B

        ; Found through fe4.cdl.
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


      aUnknown9FDBA1 ; 9F/DBA1

        .byte $08, $5C, $21, $54, $7F, $5C, $37, $5C, $00, $7F, $5C, $30, $5C, $22, $54, $0E
        .byte $5C, $00, $70, $5C, $70, $5C, $00

      aUnknown9FDBB8 .dstruct structHDMAIndirectEntryInfo, rlUnknown9FDBC4, rlUnknown9FDB69, aHDMAUnknown9FDB6ACode, aUnknown9FDBDA, PPU_REG_BASE + $23, DMAP_HDMA_Setting(DMAP_CPUToIO, false, DMAP_Mode0), $9F ; 9F/DBB8

    .endsection Unsorted9FDB8BSection


    .section Unsorted9FDBC4Section

      .al
      .xl

      rlUnknown9FDBC4 ; 9F/DBC4

        ; Found through fe4.cdl.
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


      aUnknown9FDBDA ; 9F/DBDA

        .byte $08, $C3, $21, $33, $7F, $C3, $37, $C3, $00, $7F, $C3, $30, $C3, $22, $33, $0E
        .byte $C3, $00, $70, $C3, $70, $C3, $00

      aUnknown9FDBF1 .dstruct structHDMAIndirectEntryInfo, rlUnknown9FDBFD, rlUnknown9FDB69, aHDMAUnknown9FDB6ACode, aUnknown9FDC13, PPU_REG_BASE + $30, DMAP_HDMA_Setting(DMAP_CPUToIO, false, DMAP_Mode1), $9F ; 9F/DBF1

    .endsection Unsorted9FDBC4Section


    .section Unsorted9FDBFDSection

      .al
      .xl

      rlUnknown9FDBFD ; 9F/DBFD

        ; Found through fe4.cdl.
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


      aUnknown9FDC13 ; 9F/DC13

        .byte $08, $02, $02, $21, $00, $82, $7F, $02, $02, $37, $02, $02, $00, $7F, $02, $02
        .byte $30, $02, $02, $22, $00, $82, $0E, $02, $02, $00, $70, $02, $02, $70, $02, $02
        .byte $00

      aUnknown9FDC34 .dstruct structHDMAIndirectEntryInfo, rlUnknown9FDC40, rlUnknown9FDB69, aHDMAUnknown9FDB6ACode, aUnknown9FDC56, PPU_REG_BASE + $30, DMAP_HDMA_Setting(DMAP_CPUToIO, false, DMAP_Mode1), $9F ; 9F/DC34

    .endsection Unsorted9FDBFDSection


    .section Unsorted9FDC40Section

      .al
      .xl

      rlUnknown9FDC40 ; 9F/DC40

        ; Found through fe4.cdl.
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


      aUnknown9FDC56 ; 9F/DC56

        .byte $08, $02, $42, $21, $00, $82, $7F, $02, $42, $37, $02, $42, $00, $7F, $02, $42
        .byte $30, $02, $42, $22, $00, $82, $0E, $02, $42, $00, $70, $02, $42, $70, $02, $42
        .byte $00

      aUnknown9FDC77 .dstruct structHDMAIndirectEntryInfo, rlUnknown9FDC83, rlUnknown9FDB69, aHDMAUnknown9FDB6ACode, aUnknown9FDCD3, PPU_REG_BASE + $0F, DMAP_HDMA_Setting(DMAP_CPUToIO, true, DMAP_Mode3), $7F ; 9F/DC77

    .endsection Unsorted9FDC40Section


    .section Unsorted9FDC83Section

      .al
      .xl

      rlUnknown9FDC83 ; 9F/DC83

        ; Found through fe4.cdl.
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


      aUnknown9FDCD3 ; 9F/DCD3

        .byte $08, $CD, $50, $21, $D1, $50, $7F, $CD, $50, $37, $CD, $50, $00, $7F, $CD, $50
        .byte $30, $CD, $50, $22, $D1, $50, $0E, $CD, $50, $00, $70, $CD, $50, $70, $CD, $50
        .byte $00

      aUnknown9FDCF4 .dstruct structHDMAIndirectEntryInfo, rlUnknown9FDD00, rlUnknown9FDB69, aHDMAUnknown9FDB6ACode, aUnknown9FDDEA, PPU_REG_BASE + $0F, DMAP_HDMA_Setting(DMAP_CPUToIO, true, DMAP_Mode3), $7F ; 9F/DCF4

      rlUnknown9FDD00 ; 9F/DD00

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta $7F50DD
        lda #$0200
        sta $7F50D5
        lda #$FC8A
        sta $7F50D7
        lda $7F509B
        and #$00FF
        cmp #$00A0
        bmi _DD67
        lda #$FE00
        sta $7F50D5
        lda $7F509C
        and #$00FF
        sta wR10
        lda #$0093
        sta wR11
        jsl rlUnsignedMultiply16By16
        lda $7F509B
        and #$00FF
        sec
        sbc wR12+1
        clc
        adc #$0008
        and #$00FF
        sta wR0
        sta $7F50CD
        sec
        sbc #$0080
        xba
        eor #$FFFF
        inc a
        sta $7F50D9
        lda #$6000
        sta $7F50DB
        bra _DDA1


        _DD67
        lda $7F509C
        and #$00FF
        sta wR10
        lda #$0093
        sta wR11
        jsl rlUnsignedMultiply16By16
        lda $7F509B
        clc
        adc wR12+1
        clc
        adc #$FFF8
        and #$00FF
        sta wR0
        sta $7F50CD
        sec
        sbc #$0080
        xba
        eor #$FFFF
        inc a
        sta $7F50D9
        lda #$6000
        sta $7F50DB

        _DDA1
        lda $7F509B
        and #$00FF
        sta wR1
        lda wR0
        sec
        sbc wR1
        sta wR0
        lda $7F509C
        and #$00FF
        sta wR1
        jsl rlUnknown9F89F8
        sta $7ECC0A
        lda $7F57FF
        sta $7F50D1
        lda $7F5800
        clc
        adc #$FFFF
        sta $7F50D3
        lda $7F508F
        and #$0400
        beq _DDE5
        lda #$DDF7
        sta aHDMASystem.aOffset,b,x

        _DDE5
        jsl rlUnknown9FDE04
        rtl

        .databank 0

      aUnknown9FDDEA ; 9F/DDEA

        .byte $08, $CD, $50, $21, $D1, $50, $7F, $CD, $50, $37, $CD, $50, $00, $7F, $CD, $50
        .byte $30, $CD, $50, $22, $D1, $50, $0E, $CD, $50, $00

      rlUnknown9FDE04 ; 9F/DE04

        .al
        .xl
        .autsiz
        .databank ?

        lda $7ECC0C
        beq _DE15
        lda #$0000
        sta $7F50D5
        sta $7F50D7

        _DE15
        lda $7F50D9
        clc
        adc $7F50D5
        sta $7F50D9
        xba
        bpl _DE2A
        ora #$FF00
        bra _DE2D


        _DE2A
        and #$00FF

        _DE2D
        sta $7F50CD
        lda $7F50DB
        clc
        adc $7F50D7
        sta $7F50DB
        xba
        bpl _DE46
        ora #$FF00
        bra _DE49


        _DE46
        and #$00FF

        _DE49
        sta $7F50CF
        rtl

        .databank 0

      aUnknown9FDE4E .dstruct structHDMAIndirectEntryInfo, rlUnknown9FDEE3, rlUnknown9FE006, aHDMAUnknown9FDB6ACode, aUnknown9FDF58, PPU_REG_BASE + $0F, DMAP_HDMA_Setting(DMAP_CPUToIO, true, DMAP_Mode3), $7F ; 9F/DE4E
        .word $FDC0, $0130

      aUnknown9FDE5E .dstruct structHDMAIndirectEntryInfo, rlUnknown9FDEE3, rlUnknown9FE017, aHDMAUnknown9FDB6ACode, aUnknown9FDF58, PPU_REG_BASE + $0F, DMAP_HDMA_Setting(DMAP_CPUToIO, true, DMAP_Mode3), $7F ; 9F/DE5E
        .word $FDC0, $01C0

      aUnknown9FDE6E .dstruct structHDMAIndirectEntryInfo, rlUnknown9FDEE3, rlUnknown9FDFF5, aHDMAUnknown9FDB6ACode, aUnknown9FDF58, PPU_REG_BASE + $0F, DMAP_HDMA_Setting(DMAP_CPUToIO, true, DMAP_Mode3), $7F ; 9F/DE6E
        .word $FDF0, $02C0

      aUnknown9FDE7E .dstruct structHDMAIndirectEntryInfo, rlUnknown9FDEE3, aUnknown9FDF58+26, aHDMAUnknown9FDB6ACode, aUnknown9FDF58, PPU_REG_BASE + $0F, DMAP_HDMA_Setting(DMAP_CPUToIO, true, DMAP_Mode3), $7F ; 9F/DE7E
        .word $0240, $FCC0

      aUnknown9FDE8E .dstruct structHDMAIndirectEntryInfo, rlUnknown9FDEBE, rlUnknown9FE0AA, aHDMAUnknown9FDB6ACode, aUnknown9FDF58, PPU_REG_BASE + $0F, DMAP_HDMA_Setting(DMAP_CPUToIO, true, DMAP_Mode3), $7F ; 9F/DE8E
        .word $0000, $0000

      aUnknown9FDE9E .dstruct structHDMAIndirectEntryInfo, rlUnknown9FDEE3, aUnknown9FDF58+26, aHDMAUnknown9FDB6ACode, aUnknown9FDF58, PPU_REG_BASE + $0F, DMAP_HDMA_Setting(DMAP_CPUToIO, true, DMAP_Mode3), $7F ; 9F/DE9E
        .word $0100, $FC80

      aUnknown9FDEAE .dstruct structHDMAIndirectEntryInfo, rlUnknown9FDEE3, aUnknown9FDF58+26, aHDMAUnknown9FDB6ACode, aUnknown9FDF58, PPU_REG_BASE + $0F, DMAP_HDMA_Setting(DMAP_CPUToIO, true, DMAP_Mode3), $7F ; 9F/DEAE
        .word $0000, $0030

      rlUnknown9FDEBE ; 9F/DEBE

        .al
        .xl
        .autsiz
        .databank ?

        lda #$7F4C
        and #$01FF
        sta $2182,b
        lda #$4C89
        sta $2181,b
        ldy #$00E0
        sep #$20

        _DED2
        stz $2180,b
        stz $2180,b
        stz $2180,b
        stz $2180,b
        dec y
        bne _DED2
        rep #$20

        .databank 0

    .endsection Unsorted9FDC83Section


    .section Unsorted9FDEE3Section

      .al
      .xl

      rlUnknown9FDEE3 ; 9F/DEE3

        ; Found through fe4.cdl.
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


      aUnknown9FDF58 ; 9F/DF58

        .byte $88, $6A, $54, $21, $D1, $50, $FF, $0E, $55, $B7, $0A, $57, $00, $FF, $6A, $54
        .byte $B0, $66, $56, $22, $D1, $50, $8E, $AE, $57, $00, $9B

      rlUnknown9FDF73 ; 9F/DF73

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
        lda $50D9,b
        clc
        adc $50D5,b
        sta $50D9,b
        xba
        bpl _DF8B
        ora #$FF00
        bra _DF8E


        _DF8B
        and #$00FF

        _DF8E
        sta wR0
        lda $50DB,b
        clc
        adc $50D7,b
        sta $50DB,b
        xba
        bpl _DFA2
        ora #$FF00
        bra _DFA5


        _DFA2
        and #$00FF

        _DFA5
        sta wR1
        lda $50DD,b
        clc
        adc #$0002
        cmp #$0020
        bmi _DFB6
        lda #$0000

        _DFB6
        sta $50DD,b
        tax
        lda $50CD,b
        sta wR2
        lda $50CF,b
        sta wR3
        ldy #$0000

        _DFC7
        lda aUnknown9FE634,x
        clc
        adc wR0
        clc
        adc wR2
        and #$01FF
        sta $546A,b,y
        lda wR3
        clc
        adc wR1
        and #$01FF
        sta $546C,b,y
        txa
        clc
        adc #$0002
        tax
        tya
        clc
        adc #$0004
        tay
        cpy #$0380
        bne _DFC7
        plb
        .databank ?
        rtl

        .databank 0

      rlUnknown9FDFF5 ; 9F/DFF5

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0003
        sta wR6
        lda #$0006
        sta wR7
        lda #$0002
        sta wR8

        .databank 0
        bra rlUnknown9FE026

    .endsection Unsorted9FDEE3Section


    .section Unsorted9FE006Section

      .al
      .xl

      rlUnknown9FE006 ; 9F/E006

        ; Found through fe4.cdl.
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
        bra rlUnknown9FE026

        .databank 0

      rlUnknown9FE017 ; 9F/E017

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0003
        sta wR6
        lda #$000A
        sta wR7
        lda #$0030
        sta wR8

        .databank 0

      rlUnknown9FE026 ; 9F/E026

        .al
        .xl
        .autsiz
        .databank ?
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

      rlUnknown9FE0AA ; 9F/E0AA

        .al
        .xl
        .autsiz
        .databank ?

        phx
        txy
        phb
        pea #$7F7F
        plb
        .databank ?
        plb
        .databank ?
        lda $50CD,b
        sta wR4
        lda $50CF,b
        sta wR5
        lda $7ECC40
        clc
        adc #$0008
        and #$00FF
        sta $7ECC40
        sta wR0
        ldy #$0000
        ldx #$0000

        _E0D3
        lda @l aUnknown9FE119,x
        asl a
        asl a
        asl a
        asl a
        asl a
        sta wR6
        lda $4C89,b,y
        clc
        adc @l aUnknown9FE119,x
        cmp wR6
        bmi _E0EC
        lda wR6

        _E0EC
        sta $4C89,b,y
        xba
        and #$00FF
        clc
        adc $546A,b,y
        and #$01FF
        sta $546A,b,y
        lda wR5
        and #$01FF
        sta $546C,b,y
        txa
        clc
        adc #$0002
        tax
        tya
        clc
        adc #$0004
        tay
        cpy #$0380
        bne _E0D3
        plb
        .databank ?
        plx
        rtl

        .databank 0

      aUnknown9FE119 ; 9F/E119

        .word $00EE, $00EC, $00EA, $00E8, $00E6, $00E4, $00E2, $00E0
        .word $00DE, $00DC, $00DA, $00D8, $00D6, $00D4, $00D2, $00D0
        .word $00CE, $00CC, $00CA, $00C8, $00C6, $00C4, $00C2, $00C0
        .word $00BE, $00BC, $00BA, $00B8, $00B6, $00B4, $00B2, $00B0
        .word $00AE, $00AC, $00AA, $00A8, $00A6, $00A4, $00A2, $00A0
        .word $009E, $009C, $009A, $0098, $0096, $0094, $0092, $0090
        .word $008E, $008C, $008A, $0088, $0086, $0084, $0082, $0080
        .word $007E, $007C, $007A, $0078, $0076, $0074, $0072, $0070
        .word $006E, $006C, $006A, $0068, $0066, $0064, $0062, $0060
        .word $005E, $005C, $005A, $0058, $0056, $0054, $0052, $0050
        .word $004E, $004C, $004A, $0048, $0046, $0044, $0042, $0040
        .word $003E, $003C, $003A, $0038, $0036, $0034, $0032, $0030
        .word $002E, $002C, $002A, $0028, $0026, $0024, $0022, $0020
        .word $001E, $001C, $001A, $0018, $0016, $0014, $0012, $0010
        .word $0010, $0012, $0014, $0016, $0018, $001A, $001C, $001E
        .word $0020, $0022, $0024, $0026, $0028, $002A, $002C, $002E
        .word $0030, $0032, $0034, $0036, $0038, $003A, $003C, $003E
        .word $0040, $0042, $0044, $0046, $0048, $004A, $004C, $004E
        .word $0050, $0052, $0054, $0056, $0058, $005A, $005C, $005E
        .word $0060, $0062, $0064, $0066, $0068, $006A, $006C, $006E
        .word $0070, $0072, $0074, $0076, $0078, $007A, $007C, $007E
        .word $0080, $0082, $0084, $0086, $0088, $008A, $008C, $008E
        .word $0090, $0092, $0094, $0096, $0098, $009A, $009C, $009E
        .word $00A0, $00A2, $00A4, $00A6, $00A8, $00AA, $00AC, $00AE
        .word $00B0, $00B2, $00B4, $00B6, $00B8, $00BA, $00BC, $00BE
        .word $00C0, $00C2, $00C4, $00C6, $00C8, $00CA, $00CC, $00CE
        .word $00D0, $00D2, $00D4, $00D6, $00D8, $00DA, $00DC, $00DE
        .word $00E0, $00E2, $00E4, $00E6, $00E8, $00EA, $00EC, $00EE

      aUnknown9FE2D9 .dstruct structHDMAIndirectEntryInfo, rlUnknown9FE2F6, rlUnknown9FE341, aHDMAUnknown9FDB6ACode, aUnknown9FE357, PPU_REG_BASE + $0F, DMAP_HDMA_Setting(DMAP_CPUToIO, true, DMAP_Mode3), $7F ; 9F/E2D9

      aUnknown9FE2E5 .dstruct structHDMAIndirectEntryInfo, rlUnknown9FE2F1, rlUnknown9FE341, aHDMAUnknown9FDB6ACode, aUnknown9FE357, PPU_REG_BASE + $0F, DMAP_HDMA_Setting(DMAP_CPUToIO, true, DMAP_Mode3), $7F ; 9F/E2E5

      rlUnknown9FE2F1 ; 9F/E2F1

        .al
        .xl
        .autsiz
        .databank ?

        lda #$FFD0
        bra rlUnknown9FE2F6._E2F9

        .databank 0

      rlUnknown9FE2F6 ; 9F/E2F6

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0100

        _E2F9
        sta $7F50DB
        lda #$0000
        sta $7F50D7
        lda $7F509B
        and #$00FF
        sec
        sbc #$0080
        eor #$FFFF
        inc a
        sta $7F50CD
        lda $7F57FF
        sta $7F50D1
        lda $7F5800
        clc
        adc #$FFFF
        sta $7F50D3
        ldy #<>aUnknown9FE371
        lda $7F508F
        bmi _E33C
        and #$0400
        beq _E340
        ldy #<>aUnknown9FE364

        _E33C
        tya
        sta aHDMASystem.aOffset,b,x

        _E340
        rtl

        .databank 0

      rlUnknown9FE341 ; 9F/E341

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F50D7
        clc
        adc $7F50DB
        sta $7F50D7
        xba
        and #$00FF
        sta $7F50CF
        rtl

        .databank 0

      aUnknown9FE357 ; 9F/E357

        .byte $08, $CD, $50, $21, $D1, $50, $7F, $CD, $50, $37, $CD, $50, $00

      aUnknown9FE364 ; 9F/E364

        .byte $7F, $CD, $50, $30, $CD, $50, $22, $D1, $50, $0E, $CD, $50, $00

      aUnknown9FE371 ; 9F/E371

        .byte $70, $CD, $50, $70, $CD, $50, $00

      aUnknown9FE378 .dstruct structHDMAIndirectEntryInfo, rlUnknown9FDB68, rlUnknown9FDB69, aHDMAUnknown9FE384Code, aUnknown9FE393, PPU_REG_BASE + $0F, DMAP_HDMA_Setting(DMAP_CPUToIO, false, DMAP_Mode2), $9F ; 9F/E378

      aHDMAUnknown9FE384Code ; 9F/E384

        HDMA_SET_INDIRECT_BANK $9F
        HDMA_YIELD 1, aUnknown9FE393

        _E38B
        HDMA_YIELD 2, aUnknown9FE393
        HDMA_JUMP _E38B

      aUnknown9FE393 ; 9F/E393

        .byte $01, $00, $00, $01, $00, $00, $01, $01, $00, $01, $01, $00, $01, $02, $00, $01
        .byte $02, $00, $01, $03, $00, $01, $03, $00, $01, $00, $00, $01, $00, $00, $01, $00
        .byte $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00
        .byte $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01
        .byte $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00
        .byte $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00
        .byte $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01
        .byte $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $01
        .byte $00, $01, $01, $00, $01, $02, $00, $01, $02, $00, $01, $03, $00, $01, $03, $00
        .byte $01, $03, $00, $01, $03, $00, $01, $02, $00, $01, $02, $00, $01, $01, $00, $01
        .byte $01, $00, $01, $00, $00, $01, $00, $00, $01, $00, $01, $01, $00, $01, $01, $FF
        .byte $01, $01, $FF, $01, $01, $FE, $01, $01, $FE, $01, $01, $FD, $01, $01, $FD, $01
        .byte $01, $FD, $01, $01, $FD, $01, $01, $FE, $01, $01, $FE, $01, $01, $FF, $01, $01
        .byte $FF, $01, $01, $00, $01, $01, $00, $01, $01, $00, $00, $01, $00, $00, $01, $01
        .byte $00, $01, $01, $00, $01, $02, $00, $01, $02, $00, $01, $03, $00, $01, $03, $00
        .byte $01, $03, $00, $01, $03, $00, $01, $02, $00, $01, $02, $00, $01, $01, $00, $01
        .byte $01, $00, $01, $00, $00, $01, $00, $00, $01, $00, $01, $01, $00, $01, $01, $FF
        .byte $01, $01, $FF, $01, $01, $FE, $01, $01, $FE, $01, $01, $FD, $01, $01, $FD, $01
        .byte $01, $FD, $01, $01, $FD, $01, $01, $FE, $01, $01, $FE, $01, $01, $FF, $01, $01
        .byte $FF, $01, $01, $00, $01, $01, $00, $01, $01, $00, $00, $01, $00, $00, $01, $01
        .byte $00, $01, $01, $00, $01, $02, $00, $01, $02, $00, $01, $03, $00, $01, $03, $00
        .byte $01, $03, $00, $01, $03, $00, $01, $02, $00, $01, $02, $00, $01, $01, $00, $01
        .byte $01, $00, $01, $00, $00, $01, $00, $00, $01, $00, $01, $01, $00, $01, $01, $FF
        .byte $01, $01, $FF, $01, $01, $FE, $01, $01, $FE, $01, $01, $FD, $01, $01, $FD, $01
        .byte $01, $FD, $01, $01, $FD, $01, $01, $FE, $01, $01, $FE, $01, $01, $FF, $01, $01
        .byte $FF, $01, $01, $00, $01, $01, $00, $01, $01, $00, $00, $01, $00, $00, $01, $01
        .byte $00, $01, $01, $00, $01, $02, $00, $01, $02, $00, $01, $03, $00, $01, $03, $00
        .byte $01, $03, $00, $01, $03, $00, $01, $02, $00, $01, $02, $00, $01, $01, $00, $01
        .byte $01, $00, $01, $00, $00, $01, $00, $00, $01, $00, $01, $01, $00, $01, $01, $FF
        .byte $01, $01, $FF, $01, $01, $FE, $01, $01, $FE, $01, $01, $FD, $01, $01, $FD, $01
        .byte $01, $FD, $01, $01, $FD, $01, $01, $FE, $01, $01, $FE, $01, $01, $FF, $01, $01
        .byte $FF, $01, $01, $00, $01, $01, $00, $01, $01, $00, $00, $01, $00, $00, $01, $01
        .byte $00, $01, $01, $00, $01, $02, $00, $01, $02, $00, $01, $03, $00, $01, $03, $00
        .byte $01, $03, $00, $01, $03, $00, $01, $02, $00, $01, $02, $00, $01, $01, $00, $01
        .byte $01, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00
        .byte $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00
        .byte $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01
        .byte $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00
        .byte $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00
        .byte $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01
        .byte $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00
        .byte $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00
        .byte $00

      aUnknown9FE634 ; 9F/E634

        .word $0000, $0000, $0001, $0001, $0002, $0002, $0003, $0003
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0001, $0001, $0002, $0002, $0003, $0003
        .word $0003, $0003, $0002, $0002, $0001, $0001, $0000, $0000
        .word $0100, $0100, $01FF, $01FF, $01FE, $01FE, $01FD, $01FD
        .word $01FD, $01FD, $01FE, $01FE, $01FF, $01FF, $0100, $0100
        .word $0000, $0000, $0001, $0001, $0002, $0002, $0003, $0003
        .word $0003, $0003, $0002, $0002, $0001, $0001, $0000, $0000
        .word $0100, $0100, $01FF, $01FF, $01FE, $01FE, $01FD, $01FD
        .word $01FD, $01FD, $01FE, $01FE, $01FF, $01FF, $0100, $0100
        .word $0000, $0000, $0001, $0001, $0002, $0002, $0003, $0003
        .word $0003, $0003, $0002, $0002, $0001, $0001, $0000, $0000
        .word $0100, $0100, $01FF, $01FF, $01FE, $01FE, $01FD, $01FD
        .word $01FD, $01FD, $01FE, $01FE, $01FF, $01FF, $0100, $0100
        .word $0000, $0000, $0001, $0001, $0002, $0002, $0003, $0003
        .word $0003, $0003, $0002, $0002, $0001, $0001, $0000, $0000
        .word $0100, $0100, $01FF, $01FF, $01FE, $01FE, $01FD, $01FD
        .word $01FD, $01FD, $01FE, $01FE, $01FF, $01FF, $0100, $0100
        .word $0000, $0000, $0001, $0001, $0002, $0002, $0003, $0003
        .word $0003, $0003, $0002, $0002, $0001, $0001, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0001, $0001, $0002, $0002, $0003, $0003
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000

        ; 9F/E824

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

        ; Found by tools/sweep.py.
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
        lda aUnknown9AA30A,x
        clc
        adc #1,s
        dec a
        tax
        lda aUnknown9AA30A,x
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


      procUnknown9FEBAB ; 9F/EBAB

        .structProcInfo "ON", rlUnknown9FECFE, rlUnknown9FF060, aProcUnknown9F805DCode

        .byte $10, $00, $01, $00, $00, $00, $00

      procUnknown9FEBBA ; 9F/EBBA

        .structProcInfo "ON", rlUnknown9FECFE, $F04F, aProcUnknown9F805DCode

        .byte $10, $00, $01, $00, $00, $00, $00

      procUnknown9FEBC9 ; 9F/EBC9

        .structProcInfo "ON", $ED29, $F071, aProcUnknown9F805DCode

        .byte $18, $00, $12, $00, $00, $00, $00

      procUnknown9FEBD8 ; 9F/EBD8

        .structProcInfo "ON", rlUnknown9FED5A, rlUnknown9FEDB3, aProcUnknown9F805DCode

        .byte $12, $00, $01, $00, $00, $00, $00

      procUnknown9FEBE7 ; 9F/EBE7

        .structProcInfo "ON", rlUnknown9FED5A, rlUnknown9FEDB3, aProcUnknown9F805DCode

        .byte $18, $01, $02, $00, $00, $00, $00

      procUnknown9FEBF6 ; 9F/EBF6

        .structProcInfo "ON", $C21A, $C27E, aProcUnknown9F805DCode

      procUnknown9FEBFE ; 9F/EBFE

        .structProcInfo "ON", $ED54, $EE45, aProcUnknown9F805DCode

        .byte $18, $00, $01, $00, $00, $00, $00

      procUnknown9FEC0D ; 9F/EC0D

        .structProcInfo "ON", rlUnknown9FED5A, rlUnknown9FEDB3, aProcUnknown9F805DCode

        .byte $80, $00, $10, $00, $00, $00, $00

      procUnknown9FEC1C ; 9F/EC1C

        .structProcInfo "ON", rlUnknown9FED5A, rlUnknown9FEDB3, aProcUnknown9F805DCode

        .byte $60, $00, $02, $00, $00, $D4, $00

      procUnknown9FEC2B ; 9F/EC2B

        .structProcInfo "ON", rlUnknown9FED5A, rlUnknown9FEDB3, aProcUnknown9F805DCode

        .byte $20, $00, $01, $00, $00, $00, $00

      procUnknown9FEC3A ; 9F/EC3A

        .structProcInfo "ON", rlUnknown9FED5A, rlUnknown9FEDB3, aProcUnknown9F805DCode

        .byte $18, $01, $01, $00, $00, $00, $00

      procUnknown9FEC49 ; 9F/EC49

        .structProcInfo "ON", rlUnknown9FED5A, rlUnknown9FEDB3, aProcUnknown9F805DCode

        .byte $30, $01, $10, $00, $00, $F0, $FF

      procUnknown9FEC58 ; 9F/EC58

        .structProcInfo "ON", rlUnknown9FED5A, rlUnknown9FEDB3, aProcUnknown9F805DCode

        .byte $1E, $00, $01, $00, $00, $00, $00

      procUnknown9FEC67 ; 9F/EC67

        .structProcInfo "ON", $F0DC, rlUnknown9FF100, aProcUnknown9F805DCode

        .byte $0C, $30, $00, $00, $00, $0E, $00

      procUnknown9FEC76 ; 9F/EC76

        .structProcInfo "ON", rlUnknown9FED5A, $F1BC, aProcUnknown9F805DCode

        .byte $F0, $00, $02, $00, $00, $00, $00

      procUnknown9FEC85 ; 9F/EC85

        .structProcInfo "ON", rlUnknown9FED5A, $C6D5, aProcUnknown9F805DCode

        .byte $22, $00, $01, $00, $00, $00, $00

      procUnknown9FEC94 ; 9F/EC94

        .structProcInfo "ON", rlUnknown9FED5A, rlUnknown9FEDB3, aProcUnknown9F805DCode

        .byte $18, $01, $01, $00, $00, $00, $00

      procUnknown9FECA3 ; 9F/ECA3

        .structProcInfo "ON", rlUnknown9FECFE, $F000, aProcUnknown9F805DCode

        .byte $10, $00, $01, $00, $00, $00, $00

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

        ; Found through fe4.cdl.
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

        ; Found through fe4.cdl.
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

        ; Found through fe4.cdl.
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

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        dec aProcSystem.aBody0,b,x
        bne rlUnknown9FF111
        lda #<>rlUnknown9FF111
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$00C0
        sta aProcSystem.aBody4,b,x

        .databank 0

      rlUnknown9FF111 ; 9F/F111

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aBody4,b,x
        clc
        adc aProcSystem.aBody3,b,x
        sta aProcSystem.aBody3,b,x
        cmp #$0100
        bpl _F126
        lda #$0000
        sta aProcSystem.aBody3,b,x

        _F126
        cmp #$0C00
        bmi _F131
        lda #$0C00
        sta aProcSystem.aBody3,b,x

        _F131
        lda aProcSystem.aHeaderTypeOffset,b,x
        tax
        lda $000B,b,x
        sta wR0
        lda $000D,b,x
        sta wR1
        ldx aProcSystem.wOffset,b
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

      rsUnknown9FF2FD ; 9F/F2FD

        .al
        .xl
        .autsiz
        .databank ?

        phb
        pea #(`aUnknown9AA30A)<<8
        plb
        plb
        lda wR5
        clc
        adc #$0004
        asl a
        tax
        lda @l aUnknown9AA30A,x
        clc
        adc #<>aUnknown9AA30A
        tax
        dex
        lda wR5
        clc
        adc #$0003
        lsr a
        tay
        bne +
        ldy #$0001
        +
        lda wR2
        clc
        adc wR4
        and #$01FF
        lsr a
        sta wR0

        _F32D
        lda $0000,b,x
        and #$00FF
        sta wR6
        lda wR0
        sec
        sbc wR6
        cmp wR2
        bpl +
        lda wR2
        +
        cmp #$0008
        bpl +
        lda #$0008
        +
        sep #$20
        .as
        sta $2180,b
        rep #$20
        .al
        lda $0000,b,x
        and #$00FF
        clc
        adc wR0
        cmp wR4
        bcc +
        lda wR4
        +
        cmp #$00F7
        bcc +
        lda #$00F7
        +
        sep #$20
        .as
        sta $2180,b
        rep #$20
        .al
        dec wR1
        dex
        dex
        dey
        bne _F32D
        plb
        rts

        .databank 0

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
        sta aProcSystem.aBody7,b,x
        stz wGameStateRoutine1,b
        jsl rlUnknown88CD53
        jsl rlUnknown88CD61
        lda #$0000
        sta aProcSystem.aHeaderBitfield,b,x
        sta aProcSystem.aBody3,b,x
        sta $7F4C17
        sta $7F4C07
        sta aMapAction.wMapBattleActiveSpriteSyncFlag
        sta aMapAction.wMapBattleActiveSpriteAckFlag
        sta aMapAction.wMapBattlePhaseFlag
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
        lda #(`rlPushToOAMBufferDualTileBase)<<8
        sta $15E5,b
        lda #<>rlPushToOAMBufferDualTileBase
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
        lda aProcSystem.aBody3,b,x
        bne _F563
        jsr rsUnknown9FF97A
        bcc _F563
        lda #1,s
        tax
        lda #<>rlUnknown9FF54E
        sta aProcSystem.aHeaderOnCycle,b,x

        _F563
        lda #1,s
        tax
        lda aProcSystem.aBody3,b,x
        dec a
        bpl _F56F
        lda #$0004

        _F56F
        sta aProcSystem.aBody3,b,x
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
        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFB
        sta aProcSystem.aHeaderBitfield,b,x
        lda #$0015
        sta @l $0004BA
        plx
        rtl

        .databank 0

      rlUnknown9FF66D ; 9F/F66D

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFB
        sta aProcSystem.aHeaderBitfield,b,x
        jsl rlUnknown81AB26
        plx
        rtl

        .databank 0

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
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0004
        sta aProcSystem.aHeaderBitfield,b,x

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

        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFE
        sta aProcSystem.aHeaderBitfield,b,x
        lda bDecompressionArrayFlag,b
        and #$00FF
        bne _F6EF
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0001
        sta aProcSystem.aHeaderBitfield,b,x

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
        sta aOAMPaletteBuffer.aPalette5,b,x
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
        sta aMapAction.lUnknown7F4598+1
        sta lR18+1
        lda #$8B88
        clc
        adc #$1000
        sta aMapAction.lUnknown7F4598
        sta lR18
        lda #$7E00
        sta aMapAction.lMapBattleAttackerSpriteScriptPointer+1
        ldy #$0004
        lda [lR18],y
        clc
        adc lR18
        sta aMapAction.lMapBattleAttackerSpriteScriptPointer
        lda $7F57EC
        tay
        lda $7F57EA
        tax
        lda aActionStructUnit2.UnitRAMPointer
        jsl rlUnknown9E8D25
        lda #$7E00
        sta lR44+1
        lda #$FC88
        sta lR44
        lda aMapAction.lMapBattleAttackerSpriteScriptPointer
        sta $7EFC8C
        ldx wR0
        lda wR1
        clc
        adc #$0005
        tay
        lda #$FC88
        jsl rlActiveSpriteEngineCreateSpriteLowestSlot
        lda aActiveSpriteSystem.wOffset,b
        tax
        sta aMapAction.wMapBattleAttackerSpriteSlot
        lda #$0000
        sta aActiveSpriteSystem.aUnknown001260,b,x
        sta aActiveSpriteSystem.aUnknown001280,b,x
        lda #$0005
        sta aActiveSpriteSystem.aUnknown0012A0,b,x
        lda #$0000
        sta aActiveSpriteSystem.aUnknown001320,b,x
        lda #$7E00
        sta lR18+1
        lda #$8B88
        clc
        adc #$1000
        sta lR18
        lda #$7E00
        sta aMapAction.lMapBattleAttackerSpriteScriptPointer+1
        ldy #$0008
        lda [lR18],y
        clc
        adc lR18
        sta aMapAction.lMapBattleAttackerSpriteScriptPointer
        lda $7F57EC
        tay
        lda $7F57EA
        tax
        lda aActionStructUnit2.UnitRAMPointer
        jsl rlUnknown9E8D25
        lda #$7E00
        sta lR44+1
        lda #$FC8E
        sta lR44
        lda aMapAction.lMapBattleAttackerSpriteScriptPointer
        sta $7EFC92
        lda #$FC8E
        ldx wR0
        ldy wR1
        jsl rlActiveSpriteEngineCreateSpriteLowestSlot
        lda aActiveSpriteSystem.wOffset,b
        tax
        sta aMapAction.wMapBattleAttackerAuxSpriteSlot
        lda #$0000
        sta aActiveSpriteSystem.aUnknown001260,b,x
        sta aActiveSpriteSystem.aUnknown001280,b,x
        lda #$0005
        sta aActiveSpriteSystem.aUnknown0012A0,b,x
        lda #$0000
        sta aActiveSpriteSystem.aUnknown001320,b,x
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
        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFB
        sta aProcSystem.aHeaderBitfield,b,x
        lda aMapAction.wMapBattleAttackerSpriteSlot
        tax
        lda aActiveSpriteSystem.aUnknown001240,b,x
        cmp #$0060
        beq _F856
        dec a
        sta aActiveSpriteSystem.aUnknown001240,b,x
        bra _F862


        _F856
        lda #1,s
        tax
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0004
        sta aProcSystem.aHeaderBitfield,b,x

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
        sta aMapAction.wMapBattleActiveSpriteSyncFlag
        lda aMapAction.wMapBattleAttackerAuxSpriteSlot
        tax
        lda #$0000
        sta aActiveSpriteSystem.aTypeOffset,b,x
        rtl

        .databank 0

        ; 9F/F887

      rlUnknown9FF887 ; 9F/F887

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFB
        sta aProcSystem.aHeaderBitfield,b,x
        lda #$0010
        sta aProcSystem.aBody3,b,x
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
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0004
        sta aProcSystem.aHeaderBitfield,b,x

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
        sta aProcSystem.aBody3,b,x
        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFB
        sta aProcSystem.aHeaderBitfield,b,x
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
        lda aProcSystem.aBody3,b,x
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
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0004
        sta aProcSystem.aHeaderBitfield,b,x
        lda #<>rlUnknown9FF54E
        sta aProcSystem.aHeaderOnCycle,b,x
        bra _F8FF


        _F8F3
        lda #1,s
        tax
        lda aProcSystem.aBody3,b,x
        dec a
        bpl _F8FF
        lda #$0018

        _F8FF
        sta aProcSystem.aBody3,b,x
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
        sta aProcSystem.aBody3,b,x
        rtl

        .databank 0

        ; 9F/F90C

      rlUnknown9FF90C ; 9F/F90C

        .al
        .xl
        .autsiz
        .databank ?

        stz aPaletteFading.wCurrentStep,b
        lda #$0020
        sta aProcSystem.aBody3,b,x
        rtl

        .databank 0

        ; 9F/F916

      rlUnknown9FF916 ; 9F/F916

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aBody7,b,x
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
        sta aProcSystem.wInput0,b
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
        sta aPaletteFading.wDesiredColor,b
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
        sta aProcSystem.aBody3,b,x
        lda wMapScrollYPixels,b
        sta aProcSystem.aBody4,b,x
        lda #$0002
        sta aProcSystem.aBody5,b,x
        lda #$0000
        sta aProcSystem.aBody6,b,x
        rtl

        .databank 0

        ; 9F/F9DA

      rlUnknown9FF9DA ; 9F/F9DA

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda aProcSystem.aBody5,b,x
        beq _F9E4
        jml _FA6A


        _F9E4
        lda $7F4C07
        bit #$0004
        bne _FA1B
        lda aProcSystem.aBody6,b,x
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
        lda aMapAction.wMapBattleAttackerAuxSpriteSlot
        tax
        lda aActiveSpriteSystem.aUnknown001200,b,x
        eor aUnknown9FFA88,x
        sta aActiveSpriteSystem.aUnknown001200,b,x
        bra _FA47


        _FA1B
        lda aProcSystem.aBody6,b,x
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
        lda aMapAction.wMapBattleAttackerAuxSpriteSlot
        tax
        lda aActiveSpriteSystem.aUnknown001200,b,x
        eor aUnknown9FFA78,x
        sta aActiveSpriteSystem.aUnknown001200,b,x

        _FA47
        lda #1,s
        tax
        lda aProcSystem.aBody6,b,x
        inc a
        sta aProcSystem.aBody6,b,x
        lda $7F4C07
        bit #$0001
        beq _FA6A
        lda aProcSystem.aBody3,b,x
        sta wMapScrollXPixels,b
        lda aProcSystem.aBody4,b,x
        sta wMapScrollYPixels,b
        jsl rlProcEngineFreeProc

        _FA6A
        lda aProcSystem.aBody5,b,x
        dec a
        bpl _FA73
        lda #$0002

        _FA73
        sta aProcSystem.aBody5,b,x
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

      aUnused9FFACC ; 9F/FACC

    .endsection Unsorted9FFAB4Section
