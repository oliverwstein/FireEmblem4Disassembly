; The castle name pop-up shown on the map.

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

          lda #$8576
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
        jsl rlUnknown91811C
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
