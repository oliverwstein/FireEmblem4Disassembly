; Code from bank $8A not yet assigned to a game system.

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
        lda $8A99DB,x
        sta $088D,b
        lda $8A9A0B,x
        sta $088F,b
        ply
        plx
        plb
        .databank ?
        rtl

        .databank 0

        ; 8A/937E

    .endsection Unsorted8A9342Section


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
        lda $18A3,b,x
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
        lda $18A3,b,x
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
        sta $0280,b,y
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
          sta $0304,b
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
        sta $0304,b
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
        sta $078C,b
        ldx #$000A

        _986A
        lda @l $8A98AC,x
        sta wR1
        lda $078C,b
        bit wR1
        bne _9897
        lda #$8A00
        sta lR18+1
        lda #$989A
        sta lR18
        phx
        lda @l $8A98C4,x
        xba
        clc
        adc @l $8A98B8,x
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
        lda @l $8A9B94,x
        sta $7F757A,x
        lda @l $8A9BF4,x
        bra _9A8A


        _9A7E
        lda @l $8A9BC4,x
        sta $7F757A,x
        lda @l $8A9C24,x

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
        lda $7E46EB,x
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
        sta $078C,b
        jsl rlGetCharacterPortraitDataID
        jsr rlTryGetClassPortraitDataID
        sta wR0
        clc
        adc wR0
        clc
        adc wR0
        tax
        lda @l PortraitGraphic00PortraitGraphicPointersEntry,x
        sta lR45
        lda @l $8AB4FA,x
        sta lR45+1
        lda #$7E00
        sta lR47+1
        lda #$8B88
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
        lda @l $8AB7E2,x
        sta lR19+1
        lda @l aPortraitPalettePointers,x
        sta lR19
        rtl

        .databank 0

        ; 8A/B452

    .endsection Unsorted8AB3FESection


    .section Unsorted8ACE50Section

      .al
      .xl

      rlUnknown8ACE50 ; 8A/CE50

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown8ACE54
        rtl

        .databank 0

        ; 8A/CE54

      rsUnknown8ACE54 ; 8A/CE54

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0003
        sta $18D0,b
        lda #$0002
        sta $1888,b
        lda #$0001
        sta $189B,b
        lda #$061E
        sta $18DB,b,x
        lda #$5000
        sta $18D7,b,x
        lda #$7E00
        sta $18D5,b,x
        lda #$8388
        sta $18D4,b,x
        lda #$3200
        sta $189F,b,x
        lda #$0212
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
        rts

        .databank 0

        ; 8A/CEB3

    .endsection Unsorted8ACE50Section


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
        .word $DC25
        .word $DCDD
        .word $DCDE

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
          lda #(`$8AE147)<<8
          sta lR44+1
          lda #<>$8AE147
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
          lda #(`$8AE199)<<8
          sta lR44+1
          lda #<>$8AE199
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
        jsl rlUnknown91811C

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
        .word $E0D7
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
          lda $8AE0C9,x
          bpl +

            lda #0
            sta $7F80A5
            tax
            lda $8AE0C9,x

          +
          sta $7F80A7
          lda $8AE0C7,x
        
        _E0A7
        sta $7F80A3

        lda $7F80A7
        asl a
        tax
        lda $8CA000,x
        sta $0170,b
        lda $8CA002,x
        sta $0172,b
        lda $8CA004,x
        sta $0174,b
        rts

        .databank 0

        ; 8A/E0C7

    .endsection Unsorted8AE05ESection


    .section Unsorted8AE14FSection

      .al
      .xl

      rlUnknown8AE14F ; 8A/E14F

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlSavePaletteBufferColorsToRAM

          .byte $88, $9B, $7E, $10, $00, $A0, $01

        ldx #$001E
        lda #$0000

        _E160
        sta $02A0,b,x
        dec x
        dec x
        bpl _E160
        lda #$0000
        sta $7F8089
        rtl

        .databank 0

        ; 8A/E16F

      rlUnknown8AE16F ; 8A/E16F

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F8089
        sta $1B45,b
        lda #$0010
        sta aPaletteFading,b
        clc
        jsl rlFadePaletteToColors

          .byte $88, $9B, $10, $00, $A0, $01

        bcs _E191

        _E189
        lda $1B45,b
        sta $7F8089
        rtl


        _E191
        jsl rlProcEngineFreeProc
        bra _E189

        .databank 0

        ; 8A/E197

    .endsection Unsorted8AE14FSection


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
        lda #(`$8AE147)<<8
        sta lR44+1
        lda #<>$8AE147
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


    .section Unsorted8AE29FSection

      .al
      .xl

      rlUnknown8AE29F ; 8A/E29F

        .al
        .xl
        .autsiz
        .databank ?

        lda #$8A00
        sta lR44+1
        lda #$E147
        sta lR44
        jsl rlProcEngineFindProc
        bcc _E2B5
        txa
        lsr a
        jsl rlProcEngineFreeProcByIndex

        _E2B5
        lda #(`procUnknown8AE199)<<8
        sta lR44+1
        lda #<>procUnknown8AE199
        sta lR44
        jsl rlProcEngineFindProc
        bcc _E2CB
        txa
        lsr a
        jsl rlProcEngineFreeProcByIndex

        _E2CB
        lda #(`procUnknown8AE1EB)<<8
        sta lR44+1
        lda #<>procUnknown8AE1EB
        sta lR44
        jsl rlProcEngineFindProc
        bcc _E2E1
        txa
        lsr a
        jsl rlProcEngineFreeProcByIndex

        _E2E1
        lda #(`procUnknown8AE245)<<8
        sta lR44+1
        lda #<>procUnknown8AE245
        sta lR44
        jsl rlProcEngineFindProc
        bcc _E2F7
        txa
        lsr a
        jsl rlProcEngineFreeProcByIndex

        _E2F7
        rtl

        .databank 0

        ; 8A/E2F8

    .endsection Unsorted8AE29FSection
