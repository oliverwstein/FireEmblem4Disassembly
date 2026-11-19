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
        pea #$807F
        jmp (lR18)

        .byte $FA


        _8081
        stz $0ED7,b,x

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
        jsl rlUnknown80900D
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

        lda $7F4560
        tay
        lda $7F4BEB
        lsr a
        bcc _82B8
        lda $7F455E
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
        lda $15E9,b
        sta $7F50B7,x
        lda #$FFFF
        sta $7F50B9,x
        inc x
        inc x
        txa
        sta $7F50A3
        plx
        lda $15E9,b

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
        lda aUnknown9F80D9,x
        sta lR18
        lda aUnknown9F80D9+1,x
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
        lda #$D600
        sta lR18+1
        lda #$1ECF
        sta lR18
        bra _8564


        _8532
        cmp #$0003
        bne _854F
        lda $7F509B
        and #$00FF
        cmp #$00C0
        bmi _854F
        lda #$D600
        sta lR18+1
        lda #$1D6C
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
        lda aUnknown9F80D9+3,x
        sta lR18
        lda aUnknown9F80D9+4,x
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
        lda aUnknown9F80D9+6,x
        sta lR18
        lda aUnknown9F80D9+7,x
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
        lda $7E4EA9
        and #$00FF
        cmp #$0003
        beq _8660
        ldy #$00D2
        ldx #$00D2

        _864B
        lda [lR18],y
        sta aBGPaletteBuffer,b,x
        lda [lR19],y
        sta $0120,b,x
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
        lda $7E4F85,x
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
        lda $0F37,b,x
        and #$FFFD
        sta $0F37,b,x
        lda $7F5089
        bmi _8721
        asl a
        asl a
        adc $7F5089
        tax
        lda aUnknown9F8724,x
        cmp #$FFFF
        beq _8721
        phk
        phk
        ply
        sty lR19+1
        sta lR19
        lda aUnknown9F8724+2,x
        sta lR18
        lda aUnknown9F8724+3,x
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
        lda $0F37,b,x
        and #$FFFE
        ora #$0002
        sta $0F37,b,x
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

        lda $0F37,b,x
        and #$FFFD
        sta $0F37,b,x
        lda $7F508F
        beq _8942
        phx
        lda $7F508B
        sta $7F5089
        lda $7F459E
        asl a
        tax
        lda $7E4F85,x
        and #$0001
        beq _892F
        lda $7F508D
        sta $7F5089

        _892F
        plx
        lda $7F5089
        cmp #$FFFF
        beq _8942
        lda $0F37,b,x
        ora #$0002
        sta $0F37,b,x

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
        jsr ($9F8A6E,x)
        plx
        rtl

        sta [wBufferBG3VOFS+1],y
        tay
        txa
        lda wBufferBG3VOFS+1,x
        dec wBufferBG3VOFS+1

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
        jsr ($9F8A8F,x)
        plx
        rtl

        .databank 0

        ; 9F/8A8F

    .endsection Unsorted9F8A34Section


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
        lda $1B43,b
        cmp aBGPaletteBuffer,b,x
        beq _8EDA
        phx
        lda aBGPaletteBuffer,b,x
        tax
        lda $1B45,b
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

        jsr $9F919F
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
        sta $1B43,b
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
        lda #$9F00
        sta lR44+1
        lda #$924B
        sta lR44
        jsl rlProcEngineCreateProc
        ply
        plb
        .databank ?
        rtl

        .databank 0

        ; 9F/924B

    .endsection Unsorted9F9217Section


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
        sta $1057,b,x
        lda #$926E
        sta $0F57,b,x
        lda $7F509B
        and #$00FF
        jsr rsUnknown9F8253
        jmp rlUnknown9FBD6B

        .databank 0

        ; 9F/926F

    .endsection Unsorted9F9253Section


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
        stz $1017,b,x
        stz $1037,b,x
        jsl rlUnknown9F9691
        rtl

        .databank 0

        ; 9F/92F3

    .endsection Unsorted9F92D2Section


    .section Unsorted9F9341Section

      .al
      .xl

      rlUnknown9F9341 ; 9F/9341

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9F82D7
        plb
        .databank ?
        xba
        jsr rsUnknown9F830F
        lsr $80DE,b
        asl a
        jsr rsUnknown9F82D7
        tsx
        xba
        jsr rsUnknown9F830F
        lsr $20DE,b,x
        ora aUnknownDBB883
        jsr rsUnknown9F830F
        sbc (wVBlankEnabledFramecount),y
        jsr rsUnknown9F830F
        jmp ($20DB)

        .databank 0

        ; 9F/9367

    .endsection Unsorted9F9341Section


    .section Unsorted9F9691Section

      .al
      .xl

      rlUnknown9F9691 ; 9F/9691

        .al
        .xl
        .autsiz
        .databank ?

        ldy $1037,b,x
        lda $96D5,b,y
        cmp #$FFFF
        beq _96D3
        phx
        tya
        clc
        adc #$000E
        sta $1037,b,x
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
        bpl _F42F
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
        jsr ($9FF427,x)
        plx
        rtl

        .byte $50, $F4, $5E, $F4, $68, $F4, $76, $F4


        _F42F
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
        jsr ($9FF448,x)
        plx
        rtl

        .databank 0

        ; 9F/F448

    .endsection Unsorted9FF3EDSection
