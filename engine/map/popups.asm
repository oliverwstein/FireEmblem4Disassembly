; The castle name pop-up shown on the map.
; Also a second pop-up proc (procUnknown85BB52) and the helpers only these
; pop-ups use.

    .section CastleNamePopUpSection

      .as
      .xl

      procCastleNamePopUp ; 82/86B6

        .structProcInfo "TT", rlProcCastleNamePopUpInit, rlProcCastleNamePopUpCycle1, aProcCastleNamePopUpCode
        .word 0

      rlProcCastleNamePopUpInit ; 82/86C0

        .al
        .autsiz
        .databank ?

        ldy wActiveEventOffset,b
        lda lActiveEventPointer,b
        sta @l lR22
        lda lActiveEventPointer+1,b
        sta @l lR22+1

        ; Load the dialogue pointer
        lda [lR22],y
        sta aProcSystem.aBody4,b,x
        inc y
        lda [lR22],y
        sta aProcSystem.aBody5,b,x
        inc y
        inc y

        ; Load the box color
        lda [lR22],y
        and #$00FF
        cmp #$00FF
        bne +

          lda #$FFFF

        +
        sta aProcSystem.aBody2,b,x
        inc y

        ; Load the display duration
        lda [lR22],y
        and #$00FF
        sta aProcSystem.aBody3,b,x

        ; Load the text are size
        lda #(4 << 8 | 10)
        sta aDialogue._Slot[0].wDisplayArea,b
        sta aProcSystem.aBody1,b,x

        ; Load the text position
        lda #(7 << 8 | 11)
        sta aProcSystem.aBody0,b,x
        jsl rlUnknown8287C1

        lda #(DialogueStatusPreventBSkipping | DialogueStatusPreventASpeedUp)
        tsb aDialogue.wStatus,b

        lda #T_Setting(false, true, true, false, false)
        trb bBufferTM

        rtl

        .databank 0

      rlProcCastleNamePopUpCycle1 ; 82/8716

        .al
        .autsiz
        .databank ?

        lda #T_Setting(false, true, true, false, false)
        trb bBufferTM

        phx
        jsl rlUnknown9181F6
        plx

        ; Wait until the dialogue string is completed
        lda aDialogue.wStatus,b
        bit #DialogueStatusEnabled
        bne _End

          ; Update the box size in aProcSystem.aBody1 with the string tile count + 4

          lda aDialogue.wStringPixelLength,b
          lsr a
          lsr a
          lsr a
          clc
          adc #4
          sta wR0

          lda aProcSystem.aBody1,b,x
          and #$FF00
          ora wR0
          sta aProcSystem.aBody1,b,x

          ; Update the Y position of the box

          lda wR0
          lsr a
          sta wR0

          lda #16
          sec
          sbc wR0
          sta wR0

          lda aProcSystem.aBody0,b,x
          and #$FF00
          ora wR0
          sec
          sbc #1
          sta aProcSystem.aBody0,b,x

          lda #<>rlProcCastleNamePopUpCycle2
          sta aProcSystem.aHeaderOnCycle,b,x
          jsl rlUnknown8287C1

          lda #(DialogueStatusPreventBSkipping | DialogueStatusPreventASpeedUp)
          tsb aDialogue.wStatus,b

          lda #$00FF
          jsl rlFillBG3Page0TilemapBuffer

        _End
        rtl

        .databank 0

      rlProcCastleNamePopUpCycle2 ; 82/8774

        .al
        .autsiz
        .databank ?

        phx
        jsl rlUnknown9181F6
        plx

        lda aDialogue.wStatus,b
        bit #DialogueStatusEnabled
        bne _End

          phx
          plx
          lda #T_Setting(false, true, true, false, false)
          tsb bBufferTM

          lda #<>rlProcCastleNamePopUpCycle3
          sta aProcSystem.aHeaderOnCycle,b,x

          lda aProcSystem.aBody1,b,x
          sta wR0

          lda aProcSystem.aBody2,b,x
          tay
          lda aProcSystem.aBody0,b,x
          ldx wR0
          jsl rlUnknown85BBA5

        _End
        rtl

        .databank 0

      rlProcCastleNamePopUpCycle3 ; 82/87A2

        .al
        .autsiz
        .databank ?

        lda aProcSystem.aBody3,b,x
        dec a
        sta aProcSystem.aBody3,b,x
        bne _End

          lda #T_Setting(false, true, true, false, false)
          trb bBufferTM

          phx
          jsl rlUnknown85BBE0
          jsl rlFreeHDMAEntry0
          plx

          lda #<>rlProcDialogueCycle6
          sta aProcSystem.aHeaderOnCycle,b,x

        _End
        rtl

        .databank 0

      rlUnknown8287C1 ; 82/87C1

        .al
        .autsiz
        .databank ?

        phx
        jsl rlResetDialogueEngine
        plx

        phx
        lda aProcSystem.aBody4,b,x
        sta lR18
        lda aProcSystem.aBody5,b,x
        sta lR18+1
        lda #0
        jsl rlDialogueStartTextAndHDMA
        jsl rlDialogueFreeHDMA
        plx

        phx

        ; Load box size
        lda aProcSystem.aBody1,b,x
        sta aDialogue._Slot[0].wDisplayArea,b

        ; Load box position
        lda aProcSystem.aBody0,b,x
        clc
        adc #$0101
        jsl rlUnknown9180F0
        tay

        lda #$8000 >> 1
        sta aDialogue._Slot[0].wVRAMAddress,b

        lda #(`aBG3TilemapBuffer)<<8
        sta aDialogue._Slot[0].lBGBufferPosition+1,b
        tya
        clc
        adc #2
        adc #<>aBG3TilemapBuffer
        sta aDialogue._Slot[0].lBGBufferPosition,b

        jsl rlUnknown91A984

        lda #$FFFF
        sta aDialogue.wTextSpeed,b
        plx
        rtl

        .databank 0

      aProcCastleNamePopUpCode ; 82/8814

        PROC_HALT

        ; 82/8816

    .endsection CastleNamePopUpSection


    .section ProcScript828865Section

      .al
      .xl

      procUnknown828865 ; 82/8865

        .structProcInfo "TT", rlProcUnknown828865Init, rlProcUnknown828865Cycle, aProcUnknown828865Code

    .endsection ProcScript828865Section


    .section ProcScript85BB52Section

      .al
      .xl

      procUnknown85BB52 ; 85/BB52

        .structProcInfo "PW", rlProcUnknown85BB52Init, rlProcUnknown85BB52Cycle, aProcDialogueBoxCode


        .long aUnknown85BB46
        .byte 0

    .endsection ProcScript85BB52Section


    .section Unsorted85BB5ESection

      .al
      .xl

      rlProcUnknown85BB52Init ; 85/BB5E

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlStallProcUntilMapMenuDataLoaded
        jsl rlUnknown85C0CE
        lda #$0000
        sta wBufferBG3VOFS
        sta wBufferBG3HOFS
        lda aProcSystem.wInput2,b
        jsl rlSetMapMenuPosition
        lda aProcSystem.wInput3,b
        jsl rlUnknown85884A
        lda aProcSystem.wInput1,b
        jsl rlUnknown85C4E0
        rtl

        .databank 0

        ; 85/BB83

      rlProcUnknown85BB52Cycle ; 85/BB83

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aHeaderBitfield,b,x
        bit #$0001
        bne _BB8C

        _BB8B
        rtl


        _BB8C
        jsl rlLoadMapMenuEntryPointerFromProcBody
        jsl rlCloseMapMenuFromProc
        jsl rlUnknown85C0C7
        lda #$FFFF
        jsl rlUnknown85C4E0
        jsl rlUnknown85C0D5
        bra _BB8B

        .databank 0

        ; 85/BBA5

    .endsection Unsorted85BB5ESection


    .section Unsorted85BBA5Section

      .al
      .xl

      rlUnknown85BBA5 ; 85/BBA5

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phy
        phx
        and #$FF00
        asl a
        asl a
        asl a
        sta wR0
        txa
        and #$FF00
        asl a
        asl a
        asl a
        xba
        ora wR0
        sta wR43
        lda #$000F
        sta wR42
        jsl rlUnknown859FCD
        plx
        ply
        pla
        sty aProcSystem.wInput1,b
        sta aProcSystem.wInput2,b
        stx aProcSystem.wInput3,b
        lda #(`procUnknown85BB52)<<8
        sta lR44+1
        lda #<>procUnknown85BB52
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 85/BBE0

      rlUnknown85BBE0 ; 85/BBE0

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #(`procUnknown85BB52)<<8
        sta lR44+1
        lda #<>procUnknown85BB52
        sta lR44
        jsl rlProcEngineFindProc
        bcc _BBFD
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0001
        sta aProcSystem.aHeaderBitfield,b,x
        plx
        sec
        rtl


        _BBFD
        plx
        clc
        rtl

        .databank 0

        ; 85/BC00

    .endsection Unsorted85BBA5Section


    .section Unsorted85C0C7Section

      .al
      .xl

      rlUnknown85C0C7 ; 85/C0C7

        .al
        .xl
        .autsiz
        .databank ?

        lda #<>rlUnknown85C0BA
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 85/C0CE

    .endsection Unsorted85C0C7Section


    .section Unsorted85C4E0Section

      .al
      .xl

      rlUnknown85C4E0 ; 85/C4E0

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $85
        phx
        phy
        ora #$0000
        bmi _C505
        asl a
        asl a
        asl a
        asl a
        clc
        adc #$000E
        tay
        ldx #$000E

        _C4F7
        lda $C51B,b,y
        sta $0110,b,x
        dec y
        dec y
        dec x
        dec x
        bpl _C4F7
        bra _C516


        _C505
        ldx #$0010

        _C508
        lda aWindowPalette,x
        sta aBGPaletteBuffer,b,x
        inc x
        inc x
        cpx #$0020
        bmi _C508

        _C516
        ply
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 85/C51B

    .endsection Unsorted85C4E0Section


    .section Data85C51BSection

      .al
      .xl

      aUnknown85C51B ; 85/C51B

        ; Read by rlUnknown85C4E0.

        .word $0000, $02FC, $7292, $6A70, $6A2F, $660E, $61ED, $04A7
        .word $0000, $02FC, $2976, $2555, $2134, $1D13, $18F2, $04A4
        .word $0000, $02FC, $5370, $4B2E, $470D, $42EC, $3AAA, $04A7
        .word $0000, $02FC, $46D7, $3EB6, $3E95, $3275, $2655, $0CE9

        ; 85/C55B

    .endsection Data85C51BSection
