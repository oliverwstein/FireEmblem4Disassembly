; Code from bank $9B not yet assigned to a game system.

    .section Unsorted9BDC24Section

      .al
      .xl

      rlUnknown9BDC24 ; 9B/DC24

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$80
        sta $2100,b
        sta bBufferINIDISP
        rep #$20
        jsl rlProcEngineResetProcEngine
        jsl rlUnknown9BE05D
        jsl rlResetHDMAEngine
        jsl rlUnknown95F1A9
        jsl rlUnknown96B93A
        jsl rlUnknown95EA47
        jsl rlUnknown9BF3F3
        jsl rlUnknown96D659
        jsl rlUnknown95F741
        jsl rlUnknown95F7F7
        jsl rlUnknown95F87F
        jsl rlUnknown9BEAA5
        lda #$0000
        sta $7FE09E
        lda $7FD8B9
        and #$00FF
        bne _DCA7
        jsl rlUnknown9BFB7E
        jsl rlUnknown809654
        lda #$0000
        sep #$20
        sta $7FD000
        lda #$00
        sta $7FD8B5
        sta $7FD075
        sta $7FD8B7
        lda $7FD8BA
        ora #$08
        sta $7FD8BA
        stz $0CC4,b
        rep #$20
        stz $0CC7,b

        _DCA0
        inc wGameStateRoutine1,b
        stz wGameStateStep,b
        rtl


        _DCA7
        jsl rlUnknown9BDE12
        jsl rlUnknown9BDE69
        sep #$20
        stz $0CC4,b
        rep #$20
        stz $0CC7,b
        bra _DCA0

        .databank 0

        ; 9B/DCBB

      rlUnknown9BDCBB ; 9B/DCBB

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda $7FD075
        beq _DCC7
        lda #$80
        bra _DCC9


        _DCC7
        lda bBufferINIDISP

        _DCC9
        sta $2100,b
        rep #$20
        lda $7FD000
        and #$00FF
        cmp #$0000
        beq _DCE5
        cmp #$0001
        beq _DCEB
        jsl rlUnknown9BDDE3
        bra _DCEF


        _DCE5
        jsl rlUnknown9BDD02
        bra _DCEF


        _DCEB
        jsl rlUnknown9BDD9A

        _DCEF
        lda $7FD001
        inc a
        sta $7FD001
        lda $7FE09E
        inc a
        sta $7FE09E
        rtl

        .databank 0

        ; 9B/DD02

      rlUnknown9BDD02 ; 9B/DD02

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FD8BA
        bit #$0004
        bne _DD4C
        lda $7FD8B9
        and #$00FF
        bne _DD46
        lda $7FD8BA
        bit #$0001
        beq _DD29
        sep #$20
        and #$FE
        sta $7FD8BA
        rep #$20
        bra _DD46


        _DD29
        jsl rlUnknown95F13C
        bcc _DD62
        lda #$000A
        jsl rlUnknown808FAD
        sep #$20
        lda $7FD8BA
        ora #$01
        sta $7FD8BA
        rep #$20
        bra _DD62


        _DD46
        jsl rlUnknown9BDE12
        bra _DD99


        _DD4C
        lda bDecompressionArrayFlag,b
        and #$00FF
        bne _DD99
        lda $04F4,b
        and #$00FF
        bne _DD99
        jsl rlUnknown9BDE69
        bra _DD99


        _DD62
        jsl rlUnknown9BE184
        jsr rsUnknown9BE08A
        jsr rsUnknown9BE128
        jsl rlUnknown95F1D5
        jsl rlUnknown96BBE2
        jsl rlUnknown95F14D
        jsl rlUnknown96D695
        jsl rlUnknown96CB44
        jsl rlUnknown96A532
        jsl rlUnknown95F89A
        jsl rlUnknown9BF179
        lda $7FD8B5
        and #$00FF
        beq _DD99
        jsl rlUnknown9BDFAA

        _DD99
        rtl

        .databank 0

        ; 9B/DD9A

      rlUnknown9BDD9A ; 9B/DD9A

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FD8BA
        bit #$0002
        beq _DDAD
        jsl rlUnknown95F12B
        bcc _DDAD
        jsl rlUnknown9BDFF3

        _DDAD
        jsl rlUnknown9BE184
        jsr rsUnknown9BE08A
        jsr rsUnknown9BE128
        jsl rlUnknown95F1D5
        jsl rlUnknown96BBE2
        jsl rlUnknown95F14D
        jsl rlUnknown96D695
        jsl rlUnknown96A532
        jsl rlUnknown96CB44
        jsl rlUnknown95F89A
        lda $7FD8B5
        and #$00FF
        beq _DDE2
        jsl rlUnknown9BDFAA
        bra _DDE2


        _DDE2
        rtl

        .databank 0

        ; 9B/DDE3

      rlUnknown9BDDE3 ; 9B/DDE3

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown9BE184
        jsr rsUnknown9BE08A
        jsr rsUnknown9BE128
        jsl rlUnknown95F1D5
        jsl rlUnknown96BBE2
        jsl rlUnknown95F14D
        jsl rlUnknown96D695
        jsl rlUnknown95F89A
        lda $7FD8B5
        and #$00FF
        beq _DE11
        stz wGameStateRoutine1,b
        jsl rlUnknown91E55A

        _DE11
        rtl

        .databank 0

        ; 9B/DE12

      rlUnknown9BDE12 ; 9B/DE12

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$80
        sta $2100,b
        sta bBufferINIDISP
        rep #$20
        jsl rlResetHDMAEngine
        jsl rlUnknown95F87F
        jsl rlUnknown96D659
        jsl rlUnknown82E073
        lda #$0000
        sta $7FE18A
        sep #$20
        sta $7FECF4
        sta $7FD08B
        sta $7FD075
        rep #$20
        jsl rlUnknown9BE05D
        lda #$9700
        sta $7FD004
        lda #$F12D
        sta $7FD003
        jsl rlUnknown95F1A9
        sep #$20
        lda $7FD8BA
        ora #$04
        sta $7FD8BA
        rep #$20
        rtl

        .databank 0

        ; 9B/DE69

      rlUnknown9BDE69 ; 9B/DE69

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlDisableVBlank
        sep #$20
        lda #$01
        sta $7FD000
        rep #$20
        jsl rlUnknown95EF54
        jsl rlUnknown95F12A
        ldx #$0000
        lda #$9900
        sta lR18+1
        lda #$FEAC
        sta lR18
        jsl rlUnknown95F967
        jsl rlUnknown9BFD71
        jsl rsUnknown9BFD8C
        jsl rsUnknown9BFD99
        jsl rsUnknown9BFDA6
        jsl rsUnknown9BFDB3
        jsl rlUnknown9BFDC0
        jsl rlUnknown9BFDD2
        jsl rlUnknown9BFDDF
        jsl rlUnknown9BFDEC
        jsl rlUnknown9BFDF9
        jsl rlUnknown9BFE06
        lda #$9B00
        sta lR18+1
        lda #$DF09
        sta lR18
        jsl rlUnknown96BD1A
        lda #$0000
        sta wBufferBG1HOFS
        sta wBufferBG1VOFS
        sta wBufferBG2HOFS
        lda #$0020
        sta wBufferBG2VOFS
        sep #$20
        lda #$E0
        sta $2132,b
        lda #$00
        sta $7FD075
        rep #$20
        lda #$0000
        sta aBGPaletteBuffer,b
        jsl rlUnknown9BEAA5
        jsl rlUnknown9BFBA9
        jsl rlUnknown809654
        jsl rlEnableVBlank
        sep #$20
        lda #$80
        sta $2100,b
        sta bBufferINIDISP
        rep #$20
        rtl

        .databank 0

        ; 9B/DF09

    .endsection Unsorted9BDC24Section


    .section Unsorted9BDFAASection

      .al
      .xl

      rlUnknown9BDFAA ; 9B/DFAA

        .al
        .xl
        .autsiz
        .databank ?

        sei
        jsl rlDisableVBlank
        jsl rlUnknown9BF297
        sep #$20
        lda #$80
        sta $2100,b
        sta bBufferINIDISP
        rep #$20
        jsl rlResetHDMAEngine
        sep #$20
        lda #$00
        sta $7FD000
        lda #$00
        sta $7FD8B5
        rep #$20
        jsl rlUnknown9BE05D
        lda #$9700
        sta $7FD004
        lda #$EC63
        sta $7FD003
        lda #$9000
        sta lR18+1
        lda #$E8CE
        sta lR18
        jsl rlUnknown80C1FC
        rtl

        .databank 0

        ; 9B/DFF3

      rlUnknown9BDFF3 ; 9B/DFF3

        .al
        .xl
        .autsiz
        .databank ?

        lda #$001E
        jsl rlUnknown808FAD
        jsl rlResetHDMAEngine
        jsl rlUnknown96D659
        jsl rlUnknown95F741
        jsl rlUnknown95F7F7
        lda #$0000
        sta $7FE18A
        sep #$20
        sta $7FECF4
        sta $7FD08B
        sta $7FD075
        lda #$02
        sta $7FD000
        lda #$00
        sta $7FD8B5
        rep #$20
        jsl rlUnknown9BE05D
        lda #$9700
        sta $7FD004
        lda #$F15D
        sta $7FD003
        jsl rlUnknown95F1BF
        ldx #$0000
        lda #$9900
        sta lR18+1
        lda #$FEAC
        sta lR18
        jsl rlUnknown95F967
        sep #$20
        lda #$0F
        sta bBufferINIDISP
        rep #$20
        rtl

        .databank 0

        ; 9B/E05D

      rlUnknown9BE05D ; 9B/E05D

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$0000
        sta $7FD001
        lda #$9700
        sta $7FD004
        lda #$EC63
        sta $7FD003
        ldx #$0000

        _E076
        lda #$0000
        sta $7FD006,x
        txa
        clc
        adc #$0004
        tax
        cpx #$0040
        bcc _E076
        plx
        rtl

        .databank 0

        ; 9B/E08A

      rsUnknown9BE08A ; 9B/E08A

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda $7FD003
        sta lR18
        lda $7FD004
        sta lR18+1
        ldy #$0000
        lda [lR18],y
        cmp $7FD001
        beq _E0A5
        bcs _E0F3

        _E0A5
        inc y
        inc y

        _E0A7
        lda [lR18],y
        inc y
        and #$00FF
        cmp #$00FF
        beq _E0E9
        bit #$0080
        beq _E0BD
        jsl rlUnknown9BE0F6
        bra _E0E7


        _E0BD
        sta wR10
        lda #$0004
        sta wR11
        jsl rlUnsignedMultiply16By16
        ldx wR12
        sep #$20
        lda $7FD006,x
        ora #$01
        sta $7FD006,x
        lda [lR18],y
        inc y
        sta $7FD007,x
        rep #$20
        lda [lR18],y
        inc y
        inc y
        sta $7FD008,x

        _E0E7
        bra _E0A7


        _E0E9
        tya
        clc
        adc $7FD003
        sta $7FD003

        _E0F3
        ply
        plx
        rts

        .databank 0

        ; 9B/E0F6

      rlUnknown9BE0F6 ; 9B/E0F6

        .al
        .xl
        .autsiz
        .databank ?

        and #$007F
        sta wR0
        lda lR18
        pha
        lda lR18+1
        pha
        phb
        jsl _E109
        plb
        .databank ?
        bra _E121


        _E109
        lda [lR18],y
        inc y
        sta lR19
        lda [lR18],y
        inc y
        inc y
        sta lR19+1
        sep #$20
        lda lR19+2
        pha
        plb
        .databank ?
        rep #$20
        lda wR0
        jml [lR19]


        _E121
        pla
        sta lR18+1
        pla
        sta lR18
        rtl

        .databank 0

        ; 9B/E128

      rsUnknown9BE128 ; 9B/E128

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000

        _E12C
        lda $7FD006,x
        bit #$0001
        beq _E152
        phb
        jsl _E13D
        plb
        .databank ?
        bra _E152


        _E13D
        lda $7FD007,x
        sta lR18
        sep #$20
        lda $7FD009,x
        sta lR18+2
        pha
        plb
        .databank ?
        rep #$20
        jml [lR18]


        _E152
        txa
        clc
        adc #$0004
        tax
        cpx #$0040
        bcc _E12C
        plx
        rts

        .databank 0

        ; 9B/E15F

    .endsection Unsorted9BDFAASection


    .section Unsorted9BE179Section

      .al
      .xl

      rlUnknown9BE179 ; 9B/E179

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$08
        sta $7FD074
        rep #$20
        rtl

        .databank 0

        ; 9B/E184

      rlUnknown9BE184 ; 9B/E184

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000
        sep #$20
        lda $7FD074
        cmp #$02
        bcc _E1A4
        dec a
        sta $7FD06B,x
        lda #$00
        sta $7FD06C,x
        sta $7FD06D,x
        inc x
        inc x
        inc x

        _E1A4
        lda #$01
        sta $7FD06B,x
        lda bBufferTM
        sta $7FD06C,x
        lda bBufferTS
        sta $7FD06D,x
        lda #$00
        sta $7FD06E,x
        rep #$20
        plx
        rtl

        .databank 0

        ; 9B/E1C0

      rlUnknown9BE1C0 ; 9B/E1C0

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000
        lda #$0080

        _E1C7
        sta $7E8B88,x
        inc x
        inc x
        cpx #$0140
        bcc _E1C7
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $0140, $80, $FE00

        sep #$20
        rep #$10
        ldx #$426A
        stx DecompressionVariables
        lda #$F3
        sta $CA
        ldx #$8B88
        stx $CB
        lda #$7E
        sta $CD
        rep #$30
        jsl rlDecompressor
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $6000, $80, $0000

        sep #$20
        rep #$10
        ldx #$0F1E
        stx DecompressionVariables
        lda #$F4
        sta $CA
        ldx #$8B88
        stx $CB
        lda #$7E
        sta $CD
        rep #$30
        jsl rlDecompressor
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $1000, $80, $6000

        sep #$20
        rep #$10
        ldx #$68D3
        stx DecompressionVariables
        lda #$F4
        sta $CA
        ldx #$8B88
        stx $CB
        lda #$7E
        sta $CD
        rep #$30
        jsl rlDecompressor
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $2000, $80, $C000

        sep #$20
        rep #$10
        ldx #$7CBD
        stx DecompressionVariables
        lda #$F4
        sta $CA
        ldx #$8B88
        stx $CB
        lda #$7E
        sta $CD
        rep #$30
        jsl rlDecompressor
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $0800, $80, $E000

        ldx #$0000

        _E286
        lda $E02299,x
        sta $0162,b,x
        lda $E023B1,x
        sta $0142,b,x
        lda $E02787,x
        sta $0102,b,x
        inc x
        inc x
        cpx #$001E
        bcc _E286
        plx
        rtl

        .databank 0

        ; 9B/E2A4

    .endsection Unsorted9BE179Section


    .section Unsorted9BE5B2Section

      .al
      .xl

      rlUnknown9BE5B2 ; 9B/E5B2

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$9B00
        sta $7FD8A6
        lda #$E619
        sta $7FD8A5
        lda #$9500
        sta lR44+1
        lda #$E78F
        sta lR44
        lda #$0004
        sta wR40
        jsl rlHDMAEngineCreateEntryByIndex
        lda #$9B00
        sta $7FD008,x
        lda #$E5E4
        sta $7FD007,x
        plx
        rtl

        .databank 0

        ; 9B/E5E4

      rlUnknown9BE5E4 ; 9B/E5E4

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda #$7F00
        sta lR18+1
        lda $7FD001
        bit #$0001
        beq _E5F9
        lda #$D665
        bra _E5FC


        _E5F9
        lda #$D6F5

        _E5FC
        sta lR18
        ldx #$0000
        ldy #$0000

        _E604
        lda wBufferBG2HOFS
        clc
        adc $97FB12,x
        sta [lR18],y
        inc y
        inc y
        inc x
        inc x
        cpx #$0040
        bcc _E604
        ply
        plx
        rtl

        .databank 0

        ; 9B/E619

      rlUnknown9BE619 ; 9B/E619

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda $7FD001
        bit #$0001
        bne _E629
        lda #$D665
        bra _E62C


        _E629
        lda #$D6F5

        _E62C
        pha
        lda #$00A0
        sta $7FD636
        lda #1,s
        sta $7FD637
        lda #$00A0
        sta $7FD639
        lda #1,s
        sta $7FD63A
        lda #$00A0
        sta $7FD63C
        lda #1,s
        sta $7FD63D
        lda #$00A0
        sta $7FD63F
        lda #1,s
        sta $7FD640
        lda #$00A0
        sta $7FD642
        lda #1,s
        sta $7FD643
        lda #$009D
        sta $7FD645
        lda #1,s
        sta $7FD646
        pla
        lda #$0007
        sta $7FD633
        lda #$0000
        sta $7FD634
        sep #$20
        lda #$00
        sta $7FD648
        rep #$20
        ply
        plx
        rtl

        .databank 0

        ; 9B/E697

    .endsection Unsorted9BE5B2Section


    .section Unsorted9BEAA5Section

      .al
      .xl

      rlUnknown9BEAA5 ; 9B/EAA5

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta $7FD8A5
        sta $7FD8A8
        rtl

        .databank 0

        ; 9B/EAB1

    .endsection Unsorted9BEAA5Section


    .section Unsorted9BEAB1Section

      .al
      .xl

      rlUnknown9BEAB1 ; 9B/EAB1

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000

        _EAB5
        lda $7FD8A5,x
        cmp #$0000
        beq _EADB
        phb
        jsl _EAC6
        plb
        .databank ?
        bra _EADB


        _EAC6
        lda $7FD8A5,x
        sta lR18
        sep #$20
        lda $7FD8A7,x
        sta lR18+2
        pha
        plb
        .databank ?
        rep #$20
        jml [lR18]


        _EADB
        txa
        clc
        adc #$0003
        tax
        cpx #$0006
        bcc _EAB5
        plx
        rtl

        .databank 0

        ; 9B/EAE8

    .endsection Unsorted9BEAB1Section


    .section Unsorted9BEAE8Section

      .al
      .xl

      rlUnknown9BEAE8 ; 9B/EAE8

        ; Reads the stack above its return address, but in the emulator log every
        ; caller continues right after the call: no inline arguments.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7FD08F,x
        bit #$0001
        bne _EAF6
        jml _EC6C


        _EAF6
        bit #$0002
        beq _EB03
        jsl rlUnknown9BEC6E
        jml _EC6C


        _EB03
        sep #$20
        lda $7FD0EF,x
        dec a
        and #$0F
        sta $7FD0EF,x
        rep #$20
        phx
        lda $7FD090,x
        pha
        lda $7FD092,x
        pha
        lda $7FD099,x
        pha
        lda $7FD0EF,x
        and #$00FF
        clc
        adc #7,s
        tax
        pla
        sep #$20
        sta $7FD0DF,x
        rep #$20
        lda #5,s
        tax
        lda $7FD0EF,x
        and #$00FF
        asl a
        clc
        adc #5,s
        tax
        pla
        sta $7FD0BF,x
        pla
        sta $7FD09F,x
        plx
        lda $7FD001
        bit #$0001
        beq _EB62
        bit #$0002
        bne _EBA3
        jml _EBE5


        _EB62
        phx
        lda $7FD0EF,x
        clc
        adc $7FD0F0,x
        dec a
        and #$000F
        clc
        adc #1,s
        tax
        lda $7FD0DF,x
        and #$00FF
        sta wR9
        lda #1,s
        tax
        lda $7FD0EF,x
        clc
        adc $7FD0F0,x
        dec a
        and #$000F
        asl a
        clc
        adc #1,s
        tax
        lda $7FD09F,x
        sta wR0
        lda $7FD0BF,x
        sta wR1
        plx
        jml _EC33


        _EBA3
        phx
        lda $7FD0F0,x
        asl a
        dec a
        clc
        adc $7FD0EF,x
        and #$000F
        clc
        adc #1,s
        tax
        sep #$20
        lda $7FD0DF,x
        sta wR9
        rep #$20
        lda #1,s
        tax
        lda $7FD0F0,x
        asl a
        dec a
        clc
        adc $7FD0EF,x
        and #$000F
        asl a
        clc
        adc #1,s
        tax
        lda $7FD09F,x
        sta wR0
        lda $7FD0BF,x
        sta wR1
        plx
        bra _EC33


        _EBE5
        phx
        lda $7FD0F0,x
        pha
        asl a
        clc
        adc #1,s
        sta #1,s
        pla
        dec a
        clc
        adc $7FD0EF,x
        and #$000F
        clc
        adc #1,s
        tax
        sep #$20
        lda $7FD0DF,x
        sta wR9
        rep #$20
        lda #1,s
        tax
        lda $7FD0F0,x
        pha
        asl a
        clc
        adc #1,s
        sta #1,s
        pla
        dec a
        clc
        adc $7FD0EF,x
        and #$000F
        asl a
        clc
        adc #1,s
        tax
        lda $7FD09F,x
        sta wR0
        lda $7FD0BF,x
        sta wR1
        plx

        _EC33
        lda $7FD095,x
        sta lR18+1
        lda $7FD097,x
        sta lR18
        lda wR9
        and #$00FF
        asl a
        tay
        lda [lR18],y
        clc
        adc $7FD097,x
        tay
        lda $7FD09B,x
        sta wR5
        lda $7FD09D,x
        sta wR4
        sep #$20
        phb
        lda $7FD096,x
        pha
        plb
        .databank ?
        rep #$20
        phx
        jsl rlPushToOAMBuffer
        plx
        plb
        .databank ?

        _EC6C
        plx
        rtl

        .databank 0

        ; 9B/EC6E

      rlUnknown9BEC6E ; 9B/EC6E

        ; TRACE: stack-args
        .al
        .xl
        .autsiz
        .databank ?

        phx
        sep #$20
        lda $7FD0EF,x
        dec a
        and #$0F
        sta $7FD0EF,x
        rep #$20
        phx
        lda $7FD090,x
        pha
        lda $7FD092,x
        pha
        lda $7FD0FB,x
        pha
        lda $7FD0EF,x
        and #$00FF
        clc
        adc #7,s
        tax
        pla
        sep #$20
        sta $7FD0DF,x
        rep #$20
        lda #5,s
        tax
        lda $7FD0EF,x
        and #$00FF
        asl a
        clc
        adc #5,s
        tax
        pla
        sta $7FD0BF,x
        pla
        sta $7FD09F,x
        plx
        phx
        lda $7FD0EF,x
        clc
        adc $7FD0F0,x
        dec a
        and #$000F
        clc
        adc #1,s
        tax
        lda $7FD0DF,x
        and #$00FF
        sta wR9
        lda #1,s
        tax
        lda $7FD0EF,x
        clc
        adc $7FD0F0,x
        dec a
        and #$000F
        asl a
        clc
        adc #1,s
        tax
        lda $7FD09F,x
        sta wR0
        lda $7FD0BF,x
        sta wR1
        plx
        jsr rsUnknown9BED9D
        lda $7FD001
        bit #$0001
        bne _ED4A
        phx
        lda $7FD0F0,x
        asl a
        dec a
        clc
        adc $7FD0EF,x
        and #$000F
        clc
        adc #1,s
        tax
        sep #$20
        lda $7FD0DF,x
        sta wR9
        rep #$20
        lda #1,s
        tax
        lda $7FD0F0,x
        asl a
        dec a
        clc
        adc $7FD0EF,x
        and #$000F
        asl a
        clc
        adc #1,s
        tax
        lda $7FD09F,x
        sta wR0
        lda $7FD0BF,x
        sta wR1
        plx
        jsr rsUnknown9BED9D
        bra _ED9B


        _ED4A
        phx
        lda $7FD0F0,x
        pha
        asl a
        clc
        adc #1,s
        sta #1,s
        pla
        dec a
        clc
        adc $7FD0EF,x
        and #$000F
        clc
        adc #1,s
        tax
        sep #$20
        lda $7FD0DF,x
        sta wR9
        rep #$20
        lda #1,s
        tax
        lda $7FD0F0,x
        pha
        asl a
        clc
        adc #1,s
        sta #1,s
        pla
        dec a
        clc
        adc $7FD0EF,x
        and #$000F
        asl a
        clc
        adc #1,s
        tax
        lda $7FD09F,x
        sta wR0
        lda $7FD0BF,x
        sta wR1
        plx
        jsr rsUnknown9BED9D

        _ED9B
        plx
        rtl

        .databank 0

        ; 9B/ED9D

      rsUnknown9BED9D ; 9B/ED9D

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FD095,x
        sta lR18+1
        lda $7FD097,x
        sta lR18
        lda wR9
        and #$00FF
        asl a
        tay
        lda [lR18],y
        clc
        adc $7FD097,x
        tay
        lda $7FD0FD,x
        sta wR5
        lda $7FD0FF,x
        sta wR4
        sep #$20
        phb
        lda $7FD096,x
        pha
        plb
        .databank ?
        rep #$20
        phx
        jsl rlPushToOAMBuffer
        plx
        plb
        .databank ?
        rts

        .databank 0

        ; 9B/EDD7

    .endsection Unsorted9BEAE8Section


    .section Unsorted9BEEB4Section

      .al
      .xl

      rlUnknown9BEEB4 ; 9B/EEB4

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda $7FD075
        bne _EEC0
        jml _EF85


        _EEC0
        lda $4212,b
        bit #$40
        beq _EEC0
        lda #$80
        sta $2100,b

        _EECC
        lda $4212,b
        bit #$40
        bne _EECC

        _EED3
        lda $4212,b
        bit #$40
        beq _EED3
        lda #$00
        sta $2100,b

        _EEDF
        lda $4212,b
        bit #$40
        bne _EEDF

        _EEE6
        lda $4212,b
        bit #$40
        beq _EEE6
        lda $7FD8B4
        sta $2100,b

        _EEF4
        lda $4212,b
        bit #$40
        bne _EEF4

        _EEFB
        lda $4212,b
        bit #$40
        beq _EEFB
        lda $7FD8B2
        sta $2100,b

        _EF09
        lda $4212,b
        bit #$40
        bne _EF09

        _EF10
        lda $4212,b
        bit #$40
        beq _EF10
        lda $7FD8B1
        sta $2100,b

        _EF1E
        lda $4212,b
        bit #$40
        bne _EF1E

        _EF25
        lda $4212,b
        bit #$40
        beq _EF25
        lda $7FD8B0
        sta $2100,b

        _EF33
        lda $4212,b
        bit #$40
        bne _EF33

        _EF3A
        lda $4212,b
        bit #$40
        beq _EF3A
        lda $7FD8AF
        sta $2100,b

        _EF48
        lda $4212,b
        bit #$40
        bne _EF48

        _EF4F
        lda $4212,b
        bit #$40
        beq _EF4F
        lda $7FD8AE
        sta $2100,b

        _EF5D
        lda $4212,b
        bit #$40
        bne _EF5D

        _EF64
        lda $4212,b
        bit #$40
        beq _EF64
        lda $7FD8AD
        sta $2100,b

        _EF72
        lda $4212,b
        bit #$40
        bne _EF72

        _EF79
        lda $4212,b
        bit #$40
        beq _EF79
        lda bBufferINIDISP
        sta $2100,b

        _EF85
        rep #$20
        rtl

        .databank 0

        ; 9B/EF88

      rlUnknown9BEF88 ; 9B/EF88

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda $7FD075
        bne _EF94
        jml _F09C


        _EF94
        lda $4212,b
        bit #$40
        beq _EF94
        lda $7FD8AD
        sta $2100,b

        _EFA2
        lda $4212,b
        bit #$40
        bne _EFA2

        _EFA9
        lda $4212,b
        bit #$40
        beq _EFA9
        lda $7FD8AE
        sta $2100,b

        _EFB7
        lda $4212,b
        bit #$40
        bne _EFB7

        _EFBE
        lda $4212,b
        bit #$40
        beq _EFBE
        lda $7FD8AF
        sta $2100,b

        _EFCC
        lda $4212,b
        bit #$40
        bne _EFCC

        _EFD3
        lda $4212,b
        bit #$40
        beq _EFD3
        lda $7FD8B0
        sta $2100,b

        _EFE1
        lda $4212,b
        bit #$40
        bne _EFE1

        _EFE8
        lda $4212,b
        bit #$40
        beq _EFE8
        lda $7FD8B1
        sta $2100,b

        _EFF6
        lda $4212,b
        bit #$40
        bne _EFF6

        _EFFD
        lda $4212,b
        bit #$40
        beq _EFFD
        lda $7FD8B2
        sta $2100,b

        _F00B
        lda $4212,b
        bit #$40
        bne _F00B

        _F012
        lda $4212,b
        bit #$40
        beq _F012
        lda $7FD8B3
        sta $2100,b

        _F020
        lda $4212,b
        bit #$40
        bne _F020

        _F027
        lda $4212,b
        bit #$40
        beq _F027
        lda $7FD8B4
        sta $2100,b

        _F035
        lda $4212,b
        bit #$40
        bne _F035

        _F03C
        lda $4212,b
        bit #$40
        beq _F03C
        lda #$80
        sta $2100,b
        lda #$00
        sta $420C,b
        lda #$01
        sta $212C,b
        lda #$00
        sta $212D,b
        lda #$01
        sta $2105,b
        lda #$7C
        sta $2107,b
        lda #$07
        sta $210B,b
        stz $210E,b
        stz $210E,b
        lda $7FD8AC
        sta $210D,b
        stz $210D,b
        stz $2123,b
        stz $2121,b
        stz $2122,b
        stz $2122,b
        lda #$E0
        sta $2132,b

        _F087
        lda $4212,b
        bit #$40
        bne _F087

        _F08E
        lda $4212,b
        bit #$40
        beq _F08E
        lda $7FD073
        sta $2100,b

        _F09C
        rep #$20
        rtl

        .databank 0

        ; 9B/F09F

      rlUnknown9BF09F ; 9B/F09F

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta $7FD050
        sep #$20
        lda #$00
        sta $7FD073
        rep #$20
        jsl rlUnknown9BF0C3
        lda #$9B00
        sta $7FD008,x
        lda #$F0C3
        sta $7FD007,x
        rtl

        .databank 0

        ; 9B/F0C3

      rlUnknown9BF0C3 ; 9B/F0C3

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7FD050
        bne _F0EB
        sep #$20
        lda $7FD073
        cmp #$0F
        beq _F0DD
        inc a
        sta $7FD073
        rep #$20
        bra _F0EB


        _F0DD
        .as
        rep #$20
        sep #$20
        lda #$00
        sta $7FD006,x
        rep #$20
        bra _F0FC


        _F0EB
        lda $7FD050
        inc a
        cmp #$0003
        bcc _F0F8
        lda #$0000

        _F0F8
        sta $7FD050

        _F0FC
        plx
        rtl

        .databank 0

        ; 9B/F0FE

      rlUnknown9BF0FE ; 9B/F0FE

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta $7FD050
        jsl rlUnknown9BF118
        lda #$9B00
        sta $7FD008,x
        lda #$F118
        sta $7FD007,x
        rtl

        .databank 0

        ; 9B/F118

      rlUnknown9BF118 ; 9B/F118

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7FD050
        bne _F146
        sep #$20
        lda $7FD073
        cmp #$00
        beq _F132
        dec a
        sta $7FD073
        rep #$20
        bra _F146


        _F132
        .as
        lda #$80
        sta $7FD073
        rep #$20
        sep #$20
        lda #$00
        sta $7FD006,x
        rep #$20
        bra _F157


        _F146
        lda $7FD050
        inc a
        cmp #$0003
        bcc _F153
        lda #$0000

        _F153
        sta $7FD050

        _F157
        plx
        rtl

        .databank 0

        ; 9B/F159

      rlUnknown9BF159 ; 9B/F159

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7FD8AB
        and #$00FF
        tax
        sep #$20
        lda $99FFE7,x
        sta $7FD8AC
        lda $7FD8AB
        inc a
        sta $7FD8AB
        rep #$20
        plx
        rtl

        .databank 0

        ; 9B/F179

    .endsection Unsorted9BEEB4Section


    .section Unsorted9BF179Section

      .al
      .xl

      rlUnknown9BF179 ; 9B/F179

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda bBufferINIDISP
        bit #$80
        beq _F1A3
        sta $7FD8AD
        sta $7FD8AE
        sta $7FD8AF
        sta $7FD8B0
        sta $7FD8B1
        sta $7FD8B2
        sta $7FD8B3
        sta $7FD8B4
        bra _F1F1


        _F1A3
        dec a
        dec a
        bpl _F1A9
        lda #$00

        _F1A9
        sta $7FD8AD
        dec a
        dec a
        bpl _F1B3
        lda #$00

        _F1B3
        sta $7FD8AE
        dec a
        dec a
        bpl _F1BD
        lda #$00

        _F1BD
        sta $7FD8AF
        dec a
        dec a
        bpl _F1C7
        lda #$00

        _F1C7
        sta $7FD8B0
        dec a
        dec a
        bpl _F1D1
        lda #$00

        _F1D1
        sta $7FD8B1
        dec a
        dec a
        bpl _F1DB
        lda #$00

        _F1DB
        sta $7FD8B2
        dec a
        bpl _F1E4
        lda #$00

        _F1E4
        sta $7FD8B3
        dec a
        bpl _F1ED
        lda #$00

        _F1ED
        sta $7FD8B4

        _F1F1
        rep #$20
        rtl

        .databank 0

        ; 9B/F1F4

    .endsection Unsorted9BF179Section


    .section Unsorted9BF23CSection

      .al
      .xl

      rlUnknown9BF23C ; 9B/F23C

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta $7FD04E
        sep #$20
        lda #$E0
        sta bBufferCOLDATA_3
        lda #$00
        sta bBufferCOLDATA_1
        sta bBufferCOLDATA_2
        rep #$20
        jsl rlUnknown9BF264
        lda #$9B00
        sta $7FD008,x
        lda #$F264
        sta $7FD007,x
        rtl

        .databank 0

        ; 9B/F264

      rlUnknown9BF264 ; 9B/F264

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FD04E
        sep #$20
        pha
        lsr a
        ora #$E0
        sta bBufferCOLDATA_3
        pla
        cmp #$3E
        bne _F28B
        lda #$E0
        sta bBufferCOLDATA_3
        sta bBufferCOLDATA_1
        sta bBufferCOLDATA_2
        rep #$20
        sep #$20
        lda #$00
        sta $7FD006,x
        rep #$20
        bra _F296


        _F28B
        .as
        rep #$20
        lda $7FD04E
        inc a
        sta $7FD04E

        _F296
        rtl

        .databank 0

        ; 9B/F297

    .endsection Unsorted9BF23CSection


    .section Unsorted9BF297Section

      .al
      .xl

      rlUnknown9BF297 ; 9B/F297

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20

        _F299
        lda $4212,b
        bit #$80
        bne _F299

        _F2A0
        lda $4212,b
        bit #$80
        beq _F2A0
        rep #$20
        rtl

        .databank 0

        ; 9B/F2AA

    .endsection Unsorted9BF297Section


    .section Unsorted9BF3F3Section

      .al
      .xl

      rlUnknown9BF3F3 ; 9B/F3F3

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0000
        txa

        _F3F7
        sta $7E9188,x
        inc x
        inc x
        cpx #$0600
        bcc _F3F7
        ldx #$0000

        _F405
        lda $E024E3,x
        and #$001F
        sta $7E8B88,x
        lda $E024E3,x
        and #$03E0
        sta $7E8D88,x
        lda $E024E3,x
        and #$7C00
        xba
        sta $7E8F88,x
        inc x
        inc x
        cpx #$0184
        bcc _F405
        lda #$8000
        sta $2181,b
        sep #$20
        lda #$01
        sta $2183,b
        rep #$20
        ldy #$0021

        _F440
        ldx #$0000

        _F443
        lda $7E8B88,x
        clc
        adc $7E9188,x
        sta $7E9188,x
        lsr a
        lsr a
        lsr a
        lsr a
        lsr a
        pha
        lda $7E8D88,x
        clc
        adc aEventMovement.aMovementCostMap,x
        sta aEventMovement.aMovementCostMap,x
        lsr a
        lsr a
        lsr a
        lsr a
        lsr a
        and #$03E0
        ora #1,s
        sta #1,s
        lda $7E8F88,x
        clc
        adc $7E9588,x
        sta $7E9588,x
        lsr a
        lsr a
        lsr a
        lsr a
        lsr a
        xba
        and #$7C00
        ora #1,s
        sep #$20
        sta $2180,b
        xba
        sta $2180,b
        rep #$20
        pla
        inc x
        inc x
        cpx #$0184
        bcc _F443
        dec y
        bne _F440
        rtl

        .databank 0

        ; 9B/F49E

    .endsection Unsorted9BF3F3Section


    .section Unsorted9BF651Section

      .al
      .xl

      rlUnknown9BF651 ; 9B/F651

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$01
        sta $7FD075
        rep #$20
        rtl

        .databank 0

        ; 9B/F65C

      rlUnknown9BF65C ; 9B/F65C

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$9B00
        sta lR18+1
        lda #$F69D
        sta lR18
        jsl rlUnknown96BD1A
        lda #$00F8
        sta wBufferBG3HOFS
        lda #$0000
        sta wBufferBG3VOFS
        ldx #$0000

        _F678
        lda $E0273B,x
        sta $0102,b,x
        inc x
        inc x
        cpx #$001E
        bcc _F678
        lda #1,s
        tax
        jsl rlUnknown9BF6B1
        lda #$9B00
        sta $7FD008,x
        lda #$F6B1
        sta $7FD007,x
        plx
        rtl

        .databank 0

        ; 9B/F69D

    .endsection Unsorted9BF651Section


    .section Unsorted9BF6B1Section

      .al
      .xl

      rlUnknown9BF6B1 ; 9B/F6B1

        .al
        .xl
        .autsiz
        .databank ?

        lda wBufferBG3HOFS
        sec
        sbc #$000C
        and #$01FF
        sta wBufferBG3HOFS
        cmp #$0100
        bne _F6D5
        sep #$20
        lda #$00
        sta bBufferTS
        sta bBufferCGADSUB
        rep #$20
        sep #$20
        lda #$00
        sta $7FD006,x
        rep #$20

        _F6D5
        rtl

        .databank 0

        ; 9B/F6D6

      rlUnknown9BF6D6 ; 9B/F6D6

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$9B00
        sta lR18+1
        lda #$F715
        sta lR18
        jsl rlUnknown96BD1A
        lda #$0000
        sta wBufferBG3HOFS
        sta wBufferBG3VOFS
        lda #$0010
        sta $7FD065
        lda #$0000
        sta $7FD067
        sta $7FD069
        lda #1,s
        tax
        jsl rlUnknown9BF726
        lda #$9B00
        sta $7FD008,x
        lda #$F726
        sta $7FD007,x
        plx
        rtl

        .databank 0

        ; 9B/F715

    .endsection Unsorted9BF6B1Section


    .section Unsorted9BF726Section

      .al
      .xl

      rlUnknown9BF726 ; 9B/F726

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FD067
        inc a
        cmp #$0004
        bcs _F736
        sta $7FD067
        bra _F745


        _F736
        lda #$0000
        sta $7FD067
        lda wBufferBG3VOFS
        dec a
        and #$00FF
        sta wBufferBG3VOFS

        _F745
        lda $7FD069
        inc a
        cmp #$0004
        bcs _F755
        sta $7FD069
        bra _F764


        _F755
        lda #$0000
        sta $7FD069
        lda wBufferBG3HOFS
        dec a
        and #$00FF
        sta wBufferBG3HOFS

        _F764
        lda $7FD065
        dec a
        sta $7FD065
        bne _F779
        sep #$20
        lda #$00
        sta $7FD006,x
        rep #$20

        _F779
        rtl

        .databank 0

        ; 9B/F77A

    .endsection Unsorted9BF726Section


    .section Unsorted9BFA58Section

      .al
      .xl

      rlUnknown9BFA58 ; 9B/FA58

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$9B00
        sta lR18+1
        lda #$FA69
        sta lR18
        jsl rlUnknown96BD1A
        plx
        rtl

        .databank 0

        ; 9B/FA69

    .endsection Unsorted9BFA58Section


    .section Unsorted9BFA6ESection

      .al
      .xl

      rlUnknown9BFA6E ; 9B/FA6E

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$9B00
        sta lR18+1
        lda #$FA7F
        sta lR18
        jsl rlUnknown96BD1A
        plx
        rtl

        .databank 0

        ; 9B/FA7F

    .endsection Unsorted9BFA6ESection


    .section Unsorted9BFA85Section

      .al
      .xl

      rlUnknown9BFA85 ; 9B/FA85

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$9B00
        sta lR18+1
        lda #$FA96
        sta lR18
        jsl rlUnknown96BD1A
        plx
        rtl

        .databank 0

        ; 9B/FA96

    .endsection Unsorted9BFA85Section


    .section Unsorted9BFAA1Section

      .al
      .xl

      rlUnknown9BFAA1 ; 9B/FAA1

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$9B00
        sta lR18+1
        lda #$FAB2
        sta lR18
        jsl rlUnknown96BD1A
        plx
        rtl

        .databank 0

        ; 9B/FAB2

    .endsection Unsorted9BFAA1Section


    .section Unsorted9BFAB7Section

      .al
      .xl

      rlUnknown9BFAB7 ; 9B/FAB7

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda $7FD8BA
        ora #$02
        sta $7FD8BA
        rep #$20
        rtl

        .databank 0

        ; 9B/FAC6

      rlUnknown9BFAC6 ; 9B/FAC6

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        sep #$20
        lda bBufferINIDISP
        ora #$0F
        sta bBufferINIDISP
        rep #$20
        lda #$9B00
        sta lR18+1
        lda #$FB46
        sta lR18
        jsl rlUnknown96BD1A
        lda #$0000
        sta wBufferBG1HOFS
        sta wBufferBG1VOFS
        sta wBufferBG2HOFS
        lda #$0020
        sta wBufferBG2VOFS
        ldx #$0000

        _FAF0
        lda $0122,b,x
        lsr a
        and #$3DEF
        sta $0122,b,x
        lda $0142,b,x
        lsr a
        and #$3DEF
        sta $0142,b,x
        lda $0162,b,x
        lsr a
        and #$3DEF
        sta $0162,b,x
        lda $0182,b,x
        lsr a
        and #$3DEF
        sta $0182,b,x
        lda $0242,b,x
        lsr a
        and #$3DEF
        sta $0242,b,x
        lda $0282,b,x
        lsr a
        and #$3DEF
        sta $0282,b,x
        inc x
        inc x
        cpx #$001E
        bcc _FAF0
        lda #1,s
        tax
        lda #$9B00
        sta $7FD008,x
        lda #$FB5D
        sta $7FD007,x
        plx
        rtl

        .databank 0

        ; 9B/FB46

    .endsection Unsorted9BFAB7Section


    .section Unsorted9BFB5DSection

      .al
      .xl

      rlUnknown9BFB5D ; 9B/FB5D

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$00
        sta $7FD006,x
        rep #$20
        rtl

        .databank 0

        ; 9B/FB68

      rlUnknown9BFB68 ; 9B/FB68

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$01
        sta $7FD8B5
        rep #$20
        rtl

        .databank 0

        ; 9B/FB73

    .endsection Unsorted9BFB5DSection


    .section Unsorted9BFB7ESection

      .al
      .xl

      rlUnknown9BFB7E ; 9B/FB7E

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda $04EA,b
        and #$EF
        sta $04EA,b
        rep #$20
        lda #$0001
        sta $04BA,b
        sep #$20
        lda $7FD8BA
        and #$F7
        sta $7FD8BA
        rep #$20
        rtl

        .databank 0

        ; 9B/FB9F

    .endsection Unsorted9BFB7ESection


    .section Unsorted9BFB9FSection

      .al
      .xl

      rlUnknown9BFB9F ; 9B/FB9F

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0002
        sta $04BA,b
        sta $0500,b
        rtl

        .databank 0

        ; 9B/FBA9

    .endsection Unsorted9BFB9FSection


    .section Unsorted9BFBA9Section

      .al
      .xl

      rlUnknown9BFBA9 ; 9B/FBA9

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0003
        sta $04BA,b
        rtl

        .databank 0

        ; 9B/FBB0

    .endsection Unsorted9BFBA9Section


    .section Unsorted9BFBC0Section

      .al
      .xl

      rlUnknown9BFBC0 ; 9B/FBC0

        .al
        .xl
        .autsiz
        .databank ?

        phx
        sep #$20
        lda #$00
        sta $7FD000
        lda #$01
        sta bBufferTM
        sta bBufferBGMODE
        sta bBufferOBSEL
        lda #$10
        sta bBufferBG1SC
        rep #$20
        jsl rlUnknown88EEB1
        jsl rlGetHighestCompletionCount
        cmp #$0010
        bcc _FBE7
        lda #$000F

        _FBE7
        sta $0CC2,b
        stz aBGPaletteBuffer,b
        lda #$0000
        sta $7FD001
        stz wBufferBG1HOFS
        stz wBufferBG1VOFS
        sep #$20
        rep #$10
        ldx #$2AFE
        stx DecompressionVariables
        lda #$DF
        sta $CA
        ldx #$8B88
        stx $CB
        lda #$7E
        sta $CD
        jsl rlDecompressor
        rep #$30
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $0820, $80, $0000

        sep #$20
        rep #$10
        ldx #$30CC
        stx DecompressionVariables
        lda #$DF
        sta $CA
        ldx #$8B88
        stx $CB
        lda #$7E
        sta $CD
        jsl rlDecompressor
        rep #$30
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $0060, $80, $4000

        sep #$20
        rep #$10
        ldx #$30E9
        stx DecompressionVariables
        lda #$DF
        sta $CA
        ldx #$8B88
        stx $CB
        lda #$7E
        sta $CD
        jsl rlDecompressor
        rep #$30
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $0700, $80, $2000

        ldx #$0000

        _FC76
        lda aUnknownE0283F,x
        sta $0122,b,x
        lda aUnknownE0285D,x
        sta $0222,b,x
        inc x
        inc x
        cpx #$001E
        bcc _FC76
        plx
        rtl

        .databank 0

        ; 9B/FC8D

    .endsection Unsorted9BFBC0Section


    .section Unsorted9BFC8DSection

      .al
      .xl

      rlUnknown9BFC8D ; 9B/FC8D

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FD000
        and #$00FF
        cmp #$0001
        beq _FCB9
        cmp #$0002
        beq _FCC4
        cmp #$0003
        beq _FCE4
        cmp #$0004
        beq _FD18
        cmp #$0005
        beq _FD28
        sep #$20
        lda #$0F
        sta bBufferINIDISP
        rep #$20
        jml _FD43


        _FCB9
        lda $04BA,b
        beq _FCC2
        jml _FD50


        _FCC2
        bra _FD43


        _FCC4
        sep #$20
        lda #$10
        sta bBufferTS
        lda #$02
        sta bBufferCGWSEL
        lda #$01
        sta bBufferCGADSUB
        rep #$20
        lda #$0028
        sta $7FD046
        lda #$0084
        jsl rlUnknown808FAD
        bra _FD43


        _FCE4
        lda $7FD001
        inc a
        sta $7FD001
        cmp #$0023
        bcc _FD01
        sep #$20
        stz bBufferTS
        rep #$20
        lda #$0000
        sta $7FD001
        bra _FD43


        _FD01
        lda $7FD046
        sta wR0
        jsr rsUnknown9BFD52
        lda $7FD046
        clc
        adc #$0005
        sta $7FD046
        bra _FD50


        _FD18
        lda $7FD001
        inc a
        sta $7FD001
        cmp #$0028
        bcs _FD43
        bra _FD50


        _FD28
        lda bBufferINIDISP
        and #$00FF
        beq _FD38
        sep #$20
        dec a
        sta bBufferINIDISP
        rep #$20
        bra _FD50


        _FD38
        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        sec
        bra _FD51


        _FD43
        sep #$20
        lda $7FD000
        inc a
        sta $7FD000
        rep #$20

        _FD50
        clc

        _FD51
        rtl

        .databank 0

        ; 9B/FD52

      rsUnknown9BFD52 ; 9B/FD52

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        phb
        sep #$20
        lda #$99
        pha
        plb
        .databank $99
        rep #$20
        lda #$0070
        sta wR1
        stz wR4
        stz wR5
        ldy #$FF6D
        jsl rlPushToOAMBuffer
        plb
        .databank $99
        ply
        plx
        rts

        .databank 0

        ; 9B/FD71

    .endsection Unsorted9BFC8DSection


    .section Unsorted9BFD71Section

      .al
      .xl

      rlUnknown9BFD71 ; 9B/FD71

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda $7FD08F
        and #$FC
        sta $7FD08F
        rep #$20
        ldx #$0062
        lda #$9900
        sta lR18+1
        lda #$FEB9
        bra $9BFDCB

        .databank 0

        ; 9B/FD8C

      rsUnknown9BFD8C ; 9B/FD8C

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$00C4
        lda #$9900
        sta lR18+1
        lda #$FEC6
        bra $9BFDCB

        .databank 0

        ; 9B/FD99

      rsUnknown9BFD99 ; 9B/FD99

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0126
        lda #$9900
        sta lR18+1
        lda #$FED3
        bra $9BFDCB

        .databank 0

        ; 9B/FDA6

      rsUnknown9BFDA6 ; 9B/FDA6

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0188
        lda #$9900
        sta lR18+1
        lda #$FEE0
        bra $9BFDCB

        .databank 0

        ; 9B/FDB3

      rsUnknown9BFDB3 ; 9B/FDB3

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$01EA
        lda #$9900
        sta lR18+1
        lda #$FEED
        bra $9BFDCB

        .databank 0

        ; 9B/FDC0

      rlUnknown9BFDC0 ; 9B/FDC0

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$024C
        lda #$9900
        sta lR18+1
        lda #$FEFA
        sta lR18
        jsl rlUnknown95F967
        rtl

        .databank 0

        ; 9B/FDD2

      rlUnknown9BFDD2 ; 9B/FDD2

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$02AE
        lda #$9900
        sta lR18+1
        lda #$FF07
        bra $9BFDCB

        .databank 0

        ; 9B/FDDF

      rlUnknown9BFDDF ; 9B/FDDF

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0310
        lda #$9900
        sta lR18+1
        lda #$FF14
        bra $9BFDCB

        .databank 0

        ; 9B/FDEC

      rlUnknown9BFDEC ; 9B/FDEC

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0372
        lda #$9900
        sta lR18+1
        lda #$FF21
        bra $9BFDCB

        .databank 0

        ; 9B/FDF9

      rlUnknown9BFDF9 ; 9B/FDF9

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$03D4
        lda #$9900
        sta lR18+1
        lda #$FF2E
        bra $9BFDCB

        .databank 0

        ; 9B/FE06

      rlUnknown9BFE06 ; 9B/FE06

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0436
        lda #$9900
        sta lR18+1
        lda #$FF3B
        bra $9BFDCB

        .databank 0

        ; 9B/FE13

    .endsection Unsorted9BFD71Section


    .section TableE0283FSection

      .al
      .xl

      aUnknownE0283F ; E0/283F

        ; Read by rlUnknown9BFBC0.

        .word $7FFF, $637C, $6739, $435E, $2F1D, $42B8, $4631, $2A33
        .word $15D2, $096F, $00EA, $00A7, $0443, $0421, $0400

        ; E0/285D

    .endsection TableE0283FSection
