; Code from bank $80 not yet assigned to a game system.

    .section Unsorted808FA3Section

      .al
      .xs

      rlUnknown808FA3 ; 80/8FA3

        .al
        .autsiz
        .databank ?

        php
        phb
        phk
        plb
        rep #$30
        phx
        pha
        bra +

      rlUnknown808FAD ; 80/8FAD

        .al
        .autsiz
        .databank ?

        php
        phb
        phk
        plb
        rep #$30
        phx
        tax
        lda $04F4,b
        and #$00FF
        bne _End

          lda $04EA,b
          and #$0001
          bne _End

            phx

            +
            ldx #0

              -
              lda $04D8,b,x
              beq +

                inc x
                inc x
                cpx #6
                bcc -

            +
            pla
            sta $04D8,b,x
        
        _End
        plx
        plb
        plp
        rtl

        .databank 0

    .endsection Unsorted808FA3Section


    .section Unsorted808FDDSection

      .al
      .xl

      rlUnknown808FDD ; 80/8FDD

        .al
        .autsiz
        .databank ?

        php
        phb
        phk
        plb
        rep #$30
        phx

        tax
        lda $04F4,b
        and #$00FF
        beq rlUnknown80900D._901D

        cpx #$0010
        beq +

        cpx #$0020
        bne rlUnknown80900D._End
        
        +
        cpx $04E2,b
        beq rlUnknown80900D._End

        cpx $04E4,b
        beq rlUnknown80900D._End

        cpx $04E6,b
        beq rlUnknown80900D._End

        cpx $04E8,b
        beq rlUnknown80900D._End
        bra rlUnknown80900D._901D

      rlUnknown80900D ; 80/900D

        .al
        .autsiz
        .databank ?

        php
        phb
        phk
        plb
        rep #$30
        phx
        tax
        lda $04F4,b
        and #$00FF
        bne _End

          _901D
          lda $04EA,b
          and #$0004
          bne _End

          phx
          ldx #0

          -
          lda $04E2,b,x
          beq +

            inc x
            inc x
            cpx #6
            bcc -

          +
          pla
          sta $04E2,b,x

        _End
        plx
        plb
        plp
        rtl

        .databank 0

        ; 80/903D

    .endsection Unsorted808FDDSection


    .section Unsorted809933Section

      .al
      .xl

      rlUnknown809933 ; 80/9933

        .al
        .autsiz
        .databank ?

        php
        phb
        phk
        plb
        sep #$20
        lda $04CA,b,x
        beq _End

        cmp $04D0,b,x
        beq _995D

        cmp #$10
        bne +

        stz $04CA,b,x
        bra _9976

        +
        sta $04D0,b,x
        xba
        lda $04CB,b,x
        lsr a
        lsr a
        lsr a
        cmp #$10
        bcs _9975

        inc a
        bra _9975
        
        _995D
        cpx $04F7,b
        bne _End

        lda #1
        xba
        lda $04CB,b,x
        lsr a
        lsr a
        lsr a
        cmp #$10
        bcs +

        inc a
        
        +
        ora #$80
        ora $04CC,b,x

        _9975
        xba
        
        _9976
        rep #$20
        cpx #0
        beq +

          clc
          adc #$0010

        +
        jsl rlUnknown808FDD
        
        _End
        plb
        plp
        rtl

        .databank 0

        ; 80/9988

    .endsection Unsorted809933Section


    .section Unsorted809B01Section

      .al
      .xl

      aUnknown809B01 ; 80/9B01

        .long $809B00
        .long $868010
        .long $868011
        .long $86803E
        .long $91D616
        .long $91D617
        .long $91D61B
        .long $898000
        .long $898004
        .long $8980E0
        .long $8A8000
        .long $8A800E
        .long $8A8061
        .long $8B96CF
        .long $8B96E5
        .long $8B9717
        .long $81A800
        .long $81A813
        .long $81A89D ; event main loop routine?
        .long $8BA7CB
        .long $8BA7CC
        .long $8BA7CD
        .long $80C1A0
        .long $80C1CA
        .long $95E5C9
        .long $95E5DB
        .long $9BDC24
        .long $9BDCBB
        .long $9FFACC
        .long $9FFACC
        .long $9FFACC
        .long $9FFACC
        .long $8BA851
        .long $8BA7F2
        .long $8BA81F
        .long $89B883
        .long $89B3D7
        .long $89B3E7
        .long $89E7EA
        .long $89E7BD
        .long $89E7CC
        .long $89ECC7
        .long $89EB26
        .long $89EB40
        .long $8BD8FE
        .long $8BD794
        .long $8BD7AA
        .long $8BD13D
        .long $8BCF0A
        .long $8BCF20
        .long $89B0AA
        .long $89ACCE
        .long $89ACE7
        .long $8DA06A
        .long $8DA06B
        .long $8DA0B7

      rlUnknown809BA9 ; 80/9BA9

        .al
        .autsiz
        .databank ?

        phb

        lda $0302,b
        asl a
        adc $0302,b
        jsr rsUnknown809BC0

        lda $0300,b
        asl a
        adc $0300,b
        jsr rsUnknown809BC0

        plb
        rtl

        .databank 0

      rsUnknown809BC0 ; 80/9BC0

        .al
        .autsiz
        .databank ?

        tax
        sep #$20
        lda aUnknown809B01+2,x
        cmp #$7D
        beq +

          sta $24+2

          pha
          plb

          rep #$20
          lda aUnknown809B01,x
          sta $24
          jsl rlUnknown809BEB
          rep #$30
          rts

        +
        rep #$20
        lda aUnknown809B01,x
        sta $0302,b
        jml $809BDB

        .databank 0

      rlUnknown809BEB ; 80/9BEB

        .al
        .autsiz
        .databank ?

        jml [$24]

        .databank 0

        ; 80/9BEE

    .endsection Unsorted809B01Section


    .section Unsorted80A861Section

      .al
      .xl

      rlUnknown80A861 ; 80/A861

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phy

        clc
        adc $0000,b,x
        tay
        sep #$20
        lda $0002,b,x
        pha
        rep #$20
        plb

        lda $0000,b,y
        ora $0001,b,y
        beq +

          lda $0000,b,y
          sta lR23
          lda $0001,b,y
          sta lR23+1
          jsl rlUnknown80A88E

        +
        ply
        plp
        plb
        rtl

        .databank 0

      rlUnknown80A88E ; 80/A88E

        .al
        .autsiz
        .databank ?

        sep #$20
        lda lR23+2
        pha
        rep #$20
        plb
        jml [lR23]

        ora #0
        beq +

          phx
          dec a
          asl a
          tax
          lda $80A8A8,x
          plx

        +
        rtl

        .databank 0

        ; 80/A8A8

    .endsection Unsorted80A861Section


    .section Unsorted80AF9BSection

      .al
      .xl

      rsUnknown80AF9B ; 80/AF9B

        .al
        .autsiz
        .databank ?

        jsl rlHardwareResetScreenPosMathHDMA
        jsl rlHardwareResetScreenRegisters
        lda #0
        jsl rlFillBG2Page0TilemapBuffer
        lda #$030F
        jsl rlFillBG2Page1TilemapBuffer
        lda #$00FF
        jsl rlFillBG3Page0TilemapBuffer

        ldx #$067E
        lda #0

          -
          sta $7FDD4A,x
          sta $7FE3CA,x
          dec x
          dec x
          bpl -

        lda #$0000 >> 1
        sta wR1
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

        jsl rlClearSpriteExtBuffer
        jsl rlHideSprites
        jsl rlDMAPaletteAndOAMBuffer
        jsl rlDMAByStruct
          .structDMAToVRAM aBG2TilemapBuffer.Page1, $0800, $80, $A800

        jsl rlDMAByStruct
          .structDMAToVRAM aBG3TilemapBuffer.Page0, $0800, $80, $B000

        jsl rlClearUnitWindowAndTerrainWindowProcs
        jsl rlActiveSpriteEngineReset
        jsl rlEnableActiveSpriteEngine
        jsl rlResetHDMAEngine
        jsl $82E073
        jsl $82E400
        jsl rlUnknown8780AA
        jsl $82F211
        lda #$00FF
        sta $053E,b
        jsl rlUnknown8780DF
        rts

        .databank 0

        ; 80/B041

    .endsection Unsorted80AF9BSection


    .section Unsorted80B122Section

      .al
      .xl

      rsUnknown80B122 ; 80/B122

        .al
        .autsiz
        .databank ?

        ; a MainLoop routine

        php
        sei
        sep #$20
        lda #INIDISP_Setting(true, 0)
        sta bBufferINIDISP
        sta INIDISP,b
        rep #$20

        jsl rlDisableVBlank
        jsr rsUnknown80AF9B
        jsr rsUnknown80B16A
        jsl $899FDC
        jsr $80B065
        jsr $80B105
        jsr $80B052
        jsr $80B041

        lda #$0012
        sta $0302,b
        lda $0D7B,b
        sta $0304,b
        jsr $80B195

        sep #$20
        lda #INIDISP_Setting(false, 0)
        sta bBufferINIDISP
        sta INIDISP,b
        rep #$20

        jsl rlEnableVBlank
        plp
        cli
        rts

        .databank 0

      rsUnknown80B16A ; 80/B16A

        .al
        .autsiz
        .databank ?

        lda $0D77,b
        asl a
        tax
        jmp (+,x)

        +
        .addr rsUnknown80B17A
        .addr rsUnknown80B17F
        .addr rsUnknown80B184
        .addr rsUnknown80B184

        .databank 0

      rsUnknown80B17A ; 80/B17A

        .al
        .autsiz
        .databank ?

        jsl $888082
        rts

        .databank 0

      rsUnknown80B17F ; 80/B17F

        .al
        .autsiz
        .databank ?

        jsl $88821A
        rts

        .databank 0

      rsUnknown80B184 ; 80/B184

        .al
        .autsiz
        .databank ?

        jsl $889268
        jsl $87EAF1
        jsl $86C629
        jsl $888082
        rts

        .databank 0

      rsUnknown80B195 ; 80/B195

        .al
        .autsiz
        .databank ?

        lda #$0020
        trb wUnknown000D79,b

        lda #(`aMapMenuRAMArea)<<8
        sta lR18+1
        lda #<>aMapMenuRAMArea
        sta lR18
        lda #1
        sta wStructIndex,b
        lda #size(aMapMenuRAMArea)
        jsl rlBuildRAMAreaHeaderAndGuidingEntry

        lda #11
        sta $0304,b
        jsl $858728

        lda $0D77,b
        cmp #2
        bcc _End

          jsl rlUnknown81B088
          bcc +

            jsl rlGetVictoryThemeIfAllEnemiesDead
            bcc +

              sta $0DAB,b

          +
          lda wUnknown00171A,b
          bne _End

            jsl rlUnknown81AB26
            jsl $809654

        _End
        rts

        .databank 0

        ; 80/B1E1

    .endsection Unsorted80B122Section


    .section Unsorted80C1CBSection

      .al
      .xs

      rlUnknown80C1CB ; 80/C1CB

        .al
        .autsiz
        .databank ?

        phb
        sta wR0

        lda wUnknown00171A,b
        bne _SEC

          stz wUnknown00171C,b

          lda wR0
          cmp #$0232
          bcs _SEC

            sta wUnknown001732,b
            asl a
            clc
            adc wUnknown001732,b
            tax

            lda $8FE8BF,x
            sta lR18
            lda $8FE8BF+1,x
            sta lR18+1
            jsl rlUnknown80C1FC
            clc
            bra +

        _SEC
        sec

        +
        plb
        rtl

        .databank 0

      rlUnknown80C1FC ; 80/C1FC

        .al
        .autsiz
        .databank ?

        phb
        lda lR18
        sta lActiveEventPointer,b
        lda lR18+1
        sta lActiveEventPointer+1,b

        stz wActiveEventOffset,b

        lda #9
        sta wUnknown00171A,b
        plb
        rtl

        .databank 0

        ; 80/C212

    .endsection Unsorted80C1CBSection


    .section Unsorted80C32CSection

      .al
      .xl

      rlUnknown80C32C ; 80/C32C

        .al
        .autsiz
        .databank ?

        php
        sep #$20
        lda #$09
        sta bBufferBGMODE
        rep #$20

        lda #0
        sta wR1
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
        plp
        rtl

        .databank 0

    .endsection Unsorted80C32CSection


    .section Unsorted80C35DSection

      .al
      .xl

      rlUnknown80C35D ; 80/C35D

        .al
        .autsiz
        .databank ?

        php
        sep #$20
        lda #3
        sta BGMODE,b
        sta bBufferBGMODE
        lda #0
        sta BG1SC,b
        sta bBufferBG1SC
        sta BG2SC,b
        sta bBufferBG2SC
        rep #$20

        lda #$2000 >> 1
        sta wR1
        sta wR2
        lda #$0000 >> 1
        sta wR3
        sta wR4
        lda #$0000 >> 1
        sta wR5
        lda #$E000 >> 1
        sta wR6
        sta wR7
        lda #$0000 >> 1
        sta wR8
        jsl rlSetLayerPositionsAndSizes
        plp
        rtl

        .databank 0

        ; 80/C39A

    .endsection Unsorted80C35DSection


    .section Unsorted80E42BSection

      .al
      .xs

      rsUnknown80E42B ; 80/E42B

        .al
        .autsiz
        .databank ?

        php
        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20

        lda #<>$80BB9B
        sta $D3

        jsl $80823F
        jsl rlDisableVBlank

        jsl rlHardwareResetScreenPosMathHDMA
        jsl rlHardwareResetScreenRegisters

        stz wR0
        stz wR2
        stz wR4
        stz wR7
        stz wR9

        lda #0
        sta wR5
        lda #0
        sta wR1
        lda #$4000
        sta wR3
        lda #$6000
        sta wR6
        lda #$7000
        sta wR8

        jsl $809F15
        jsl rlProcEngineResetProcEngine
        jsl rlActiveSpriteEngineReset
        jsl rlResetHDMAEngine
        jsl $82E073
        jsl $82E400
        jsl $8780AA
        jsl $82F211

        jsr rsUnknown80E4B3
        jsr rsUnknown80E4EB
        jsr $80E54D

        lda $7F8400
        sta $0304,b

        lda #$0027
        sta $0302,b
        lda #$0026
        sta $0300,b

        lda #<>rsUnknown809D4F
        sta $D7

        jsl rlEnableVBlank

        plp
        rts

        .databank 0

      rsUnknown80E4B3 ; 80/E4B3

        .al
        .autsiz
        .databank ?

        lda $7F8183
        sta $7F8404

        lda #0
        sta $7F8402
        sta $7F8410
        sta $7F8412
        sta $7F840A
        sta $7F840C
        sta $7F8408

        lda #(`$80E422)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>$80E422
        sta lMapMenuTilemapRAMEntryPointer,b
        jsl rlGetSelectedUnitFactionSlot
        sta $7F840E
        rts

        .databank 0

      rsUnknown80E4EB ; 80/E4EB

        .al
        .xl
        .autsiz
        .databank ?

        ; Gets debug BG, pal and tilemap

        ; DMA graphics with pointing hand, promotion indicator, droppable item icon, arrows and a star

        jsl rlDMAByStruct

          .dstruct structDMAToVRAM, $DE44C0, $0400, $80, $0000

        lda #(`aUnknown80E53D)<<8
        sta lR19+1
        lda #<>aUnknown80E53D
        sta lR19
        jsl $878979
        jsl rlUnknown899FDC

        ldx #$0200  
        
        -
        lda $DDFFFE,x
        sta $FE,x
        dec x
        dec x
        bne -

        ; Clear the tilemap
        lda #0
        sta $0100,b
        jsl $8BB45D

         ; DMA clean tilemap
        jsl rlDMAByStruct

          .dstruct structDMAToVRAM, aBG3TilemapBuffer, $0800, $80, $E000

        lda #(`aUnknown80E545)<<8
        sta lR19+1
        lda #<>aUnknown80E545
        sta lR19
        jsl $878979
        rts

        .databank 0

      aUnknown80E53D ; 80/E53D

        .word $1800
        .word $4000
        .word $2B01
        .word $C00A

      aUnknown80E545 ; 80/E545

        .word $0800
        .word $6000
        .word $2001
        .word $DD3F

      rsUnknown80E54D ; 80/E54D

        .al
        .autsiz
        .databank ?

        sep #$20
        lda bBufferBG1SC
        and #$FC
        ora #$02
        sta bBufferBG1SC

        lda bBufferBG3SC
        and #$FC
        ora #$02
        sta bBufferBG3SC

        lda #$15
        sta bBufferTM
        lda #0
        sta bBufferWH0
        sta bBufferWH2
        sta bBufferWH3
        lda #$FF
        sta bBufferWH1
        lda #0
        sta bBufferCGWSEL
        lda #$81
        sta bBufferCGADSUB
        rep #$20

        stz wBufferBG1HOFS
        stz wBufferBG1VOFS
        stz wBufferBG2HOFS
        stz wBufferBG2VOFS
        stz wBufferBG3HOFS
        stz wBufferBG3VOFS
        rts

        .databank 0

        ; 80/E586

    .endsection Unsorted80E42BSection


    .section Unsorted80F2BESection

      .al
      .xl

      rsUnknown80F2BE ; 80/F2BE

        .al
        .autsiz
        .databank ?

        ; Transition from WM to map?

        php
        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20

        lda #$BB9B
        sta wVBlankPointer
        jsl $80823F
        jsl rlDisableVBlank
        jsl rlHardwareResetScreenPosMathHDMA
        jsl rlHardwareResetScreenRegisters

        lda #0
        sta wR1
        lda #$4000
        sta wR2
        lda #$5000
        sta wR6
        lda #$6000
        sta wR7
        jsl rlSetLayerPositionsAndSizes

        jsl rlProcEngineResetProcEngine
        jsl rlActiveSpriteEngineReset
        jsl rlResetHDMAEngine
        jsl rlUnknown82E073
        jsl rlUnknown82E400
        jsl rlUnknown8780AA
        jsl rlUnknown82F211

        jsr $80F340
        jsr $80F392
        jsr $80F4EB

        lda #$0024
        sta $0304,b
        lda #5
        sta $0302,b
        lda #4
        sta $0300,b

        lda #<>$809D4F
        sta wMainLoopPointer

        jsl rlEnableVBlank

        plp
        cli
        rts

        .databank 0

        ; 80/F337

    .endsection Unsorted80F2BESection
