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

        .structProcInfo "ON", rlUnknown9FEBA7, rlUnknown9F8065, aProcUnknown9F805DCode

    .endsection ProcScript9F805DSection


    .section Unsorted9F8065Section

      .al
      .xl

      rlUnknown9F8065 ; 9F/8065

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
        lda $9F80D9,x
        sta lR18
        lda $9F80DA,x
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
        lda $9F80DC,x
        sta lR18
        lda $9F80DD,x
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
        lda $9F80DF,x
        sta lR18
        lda $9F80E0,x
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
        lda $9F8724,x
        cmp #$FFFF
        beq _8721
        phk
        phk
        ply
        sty lR19+1
        sta lR19
        lda $9F8726,x
        sta lR18
        lda $9F8727,x
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


    .section Unsorted9FEBA7Section

      .al
      .xl

      rlUnknown9FEBA7 ; 9F/EBA7

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
