; Code from bank $8A not yet assigned to a game system.

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

        jsl $80BA52
        jsl rlGetSelectedUnitCharacterID
        jsl $8A9776
        jsl $8A94E2
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
          jsl $8A9776
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


    .section Unsorted8AE199Section

      .al
      .xl

      procUnknown8AE199 ; 8A/E199

        .structProcInfo "F2", rlProcUnknown8AE199Init, rlProcUnknown8AE199Cycle, $8AE1E9

    .endsection Unsorted8AE199Section


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
