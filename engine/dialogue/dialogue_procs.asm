; TODO: describe this file.

    .section DialogueSection

      .al
      .xl

      procDialogue ; 82/845F

        .structProcInfo "TT", rlProcDialogueInit, rlProcDialogueCycle1, $828694
        .word 0

    .endsection DialogueSection


    .section ProcDialogueCycle1Section

      .al
      .xl

      rlProcDialogueCycle1 ; 82/84EA

        .al
        .autsiz
        .databank ?

        ; Waits a cycle.

        lda #<>rlProcDialogueCycle2
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

      rlProcDialogueCycle2 ; 82/84F1

        .al
        .autsiz
        .databank ?

        ; Grabs graphics and palette

        lda #<>rlProcDialogueCycle3
        sta aProcSystem.aHeaderOnCycle,b,x

        jsl rlGetDialogueBoxGraphicsAndPalette
        rtl

        .databank 0

      rlProcDialogueCycle3 ; 82/84FC

        .al
        .autsiz
        .databank ?

        ; Darkens the background

        lda aProcSystem.aBody0,b,x
        beq +

          dec a
          sta aProcSystem.aBody0,b,x
          bra _End

        +
        lda wVBlankEnabledFramecount
        and #$0001
        bne _End

          sep #$20
          lda bBufferCOLDATA_0
          inc a
          sta bBufferCOLDATA_0
          rep #$20

          jsl rlApplyCOLDATA0Intensity

          lda bBufferCOLDATA_0
          and #$00FF
          cmp #5
          bcc _End

            lda #<>rlProcDialogueCycle4
            sta aProcSystem.aHeaderOnCycle,b,x

        _End
        rtl

        .databank 0

      rlProcDialogueCycle4 ; 82/852C

        .al
        .autsiz
        .databank ?

        lda bBufferINIDISP
        and #INIDISP_Brightness
        cmp #15
        bne _End

          phx
          lda #4
          sta wBufferBG3HOFS
          jsl rlUnknown8285E1
          plx

          lda aDialogue.wStatus,b
          bit #DialogueStatusEnabled
          bne _End

            jsl rlDialogueFreeHDMA
            lda #<>rlProcDialogueCycle5
            sta aProcSystem.aHeaderOnCycle,b,x

        _End
        rtl

        .databank 0

      rlProcDialogueCycle5 ; 82/8554

        .al
        .autsiz
        .databank ?

        lda wVBlankEnabledFramecount
        and #$0001
        bne _End

          sep #$20
          lda bBufferCOLDATA_0
          dec a
          sta bBufferCOLDATA_0
          rep #$20

          jsl rlApplyCOLDATA0Intensity

          lda bBufferCOLDATA_0
          and #$00FF
          bne _End

            lda #<>rlProcDialogueCycle6
            sta aProcSystem.aHeaderOnCycle,b,x

        _End
        rtl

        .databank 0

      rlProcDialogueCycle6 ; 82/8576

        .al
        .autsiz
        .databank ?

        jsl $80B0D3
        lda #<>rlProcDialogueCycle7
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

      rlProcDialogueCycle7 ; 82/8581

        .al
        .autsiz
        .databank ?

        lda $0448,b
        bne _End

          lda #<>rlProcDialogueCycle8
          sta aProcSystem.aHeaderOnCycle,b,x

        _End
        rtl

        .databank 0

      rlProcDialogueCycle8 ; 82/858D

        .al
        .autsiz
        .databank ?

        phx
        jsl rlDMAByStruct

          .dstruct structDMAToVRAM, aDecompressionBuffer, $0800, $80, $8000

        plx
        lda #<>rlProcDialogueCycle9
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

      rlProcDialogueCycle9 ; 82/85A3

        .al
        .autsiz
        .databank ?

        phx
        jsl rlDMAByStruct

          .dstruct structDMAToVRAM, aDecompressionBuffer+$800, $0800, $80, $8800

        plx
        lda #<>rlProcDialogueCycle10
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

      rlProcDialogueCycle10 ; 82/85B9

        .al
        .autsiz
        .databank ?

        phx
        jsl rlDMAByStruct

          .dstruct structDMAToVRAM, aDecompressionBuffer+$1000, $0800, $80, $9000

        plx
        lda #<>rlProcDialogueCycle11
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

      rlProcDialogueCycle11 ; 82/85CF

        .al
        .autsiz
        .databank ?

        phx
        jsl $80B0EE
        plx
        bcs _End

          lda #0
          sta wBufferBG3HOFS
          jsl rlEventEngineFreeProc

        _End
        rtl

        .databank 0

      rlUnknown8285E1 ; 82/85E1

        .al
        .autsiz
        .databank ?

        jsl rlUnknown9181F6
        jsr rsUnknown8285EC
        jsr rsUnknown82862E
        rtl

        .databank 0

      rsUnknown8285EC ; 82/85EC

        .al
        .autsiz
        .databank ?

        lda aDialogue._Slot[0].wPortraitID
        cmp #$FFFF
        beq +

          lda aDialogue.wUnknown0018A3,b
          ldy #0
          jsl $85BD12

        +
        lda aDialogue._Slot[1].wPortraitID
        cmp #$FFFF
        beq +

          lda aDialogue.wUnknown0018A5,b
          ldy #1
          jsl $85BD12

        +
        lda aDialogue._Slot[0].wPortraitID
        cmp #$FFFF
        bne +

          lda aDialogue._Slot[1].wPortraitID
          cmp #$FFFF
          beq _End

        +
        lda aDialogue.wUnknown0018A7,b
        beq _End

          jsl $85BD93

        _End
        rts

        .databank 0

    .endsection ProcDialogueCycle1Section


    .section ProcDialogueCodeSection

      .as
      .xl

      aProcDialogueCode ; 82/8694
        
        PROC_HALT

      rlApplyCOLDATA0Intensity ; 82/8696

        .al
        .autsiz
        .databank ?

        php
        sep #$20
        lda bBufferCOLDATA_0
        ora #COLDATA_ApplyRed
        sta bBufferCOLDATA_1
        sta COLDATA,b

        lda bBufferCOLDATA_0
        ora #COLDATA_ApplyGreen
        sta bBufferCOLDATA_2
        sta COLDATA,b

        lda bBufferCOLDATA_0
        ora #COLDATA_ApplyBlue
        sta bBufferCOLDATA_3
        sta COLDATA,b
        plp
        rtl

        .databank 0

        ; 82/86B6

    .endsection ProcDialogueCodeSection


    .section DialogueWithBGSection

      .al
      .xl

      procDialogueWithBG ; 82/8906

        .structProcInfo "TT", rlProcDialogueWithBGInit, rlProcDialogueWithBGCycle1, aProcDialogueWithBGCode
        .word 0

      rlProcDialogueWithBGInit ; 82/8910

        .al
        .autsiz
        .databank ?

        ldy wActiveEventOffset,b
        lda lActiveEventPointer,b
        sta @l lR22
        lda lActiveEventPointer+1,b
        sta @l lR22+1

        lda [lR22],y
        sta $08AF,b
        inc y
        lda [lR22],y
        sta $08AF+1,b
        inc y
        inc y

        lda [lR22],y
        and #$00FF
        sta $08B6,b
        inc y

        lda [lR22],y
        and #$00FF
        sta aProcSystem.aBody0,b,x
        cmp #$00FF
        bne +

          lda #3

        +
        sta $08B8,b
        inc y

        lda [lR22],y
        and #$00FF
        sta wScreenFadingProcInput,b

        stz $08AD,b
        lda wEventUnit1Pointer,b
        cmp #$FFFE
        beq +

          lda wEventUnit1Pointer,b
          jsl rlUnknown828A1C
          sta aDialogue.wUnit1,b
          lda wEventUnit2Pointer,b
          jsl rlUnknown828A1C
          sta aDialogue.wUnit2,b

        +
        lda $0302,b
        cmp #$0012
        bne +

          jsl $88B3AF

        +
        lda #2
        sta $088B,b
        lda #<>$80B6B6
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFadeByTimer)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFadeByTimer
        sta lR44
        jsl rlProcEngineCreateProc
        jsl rlUnknown91C611
        bra +

        +
        rtl

        .databank 0

      rlProcDialogueWithBGCycle1 ; 82/899F

        .al
        .autsiz
        .databank ?

        lda #1
        sta aDialogue.wTextSound,b

        lda aDialogue.wStatus,b
        bit #1
        beq +

          lda #<>rlProcDialogueWithBGCycle2
          sta aProcSystem.aHeaderOnCycle,b,x

        +
        rtl

        .databank 0

      rlProcDialogueWithBGCycle2 ; 82/89B4

        .al
        .autsiz
        .databank ?

        lda aDialogue.wStatus,b
        bit #1
        bne +

          lda #<>rlProcDialogueWithBGCycle3
          sta aProcSystem.aHeaderOnCycle,b,x
          jsl rlClearAllFadeInProcs
          jsl $8AE29F

        +
        rtl

        .databank 0

      rlProcDialogueWithBGCycle3 ; 82/89CB

        .al
        .autsiz
        .databank ?

        lda bBufferINIDISP
        and #$000F
        bne _End

          lda aProcSystem.aBody0,b,x
          cmp #5
          beq +

          cmp #$00FF
          bne ++

          +
          lda #<>rlProcDialogueWithBGCycle5
          sta aProcSystem.aHeaderOnCycle,b,x
          bra _End

          +
          lda #<>rlProcDialogueWithBGCycle4
          sta aProcSystem.aHeaderOnCycle,b,x

        _End
        rtl

        .databank 0

      rlProcDialogueWithBGCycle4 ; 82/89EE

        .al
        .autsiz
        .databank ?

        lda bBufferINIDISP
        and #$000F
        cmp #$000F
        bne +

          lda #<>rlProcDialogueWithBGCycle5
          sta aProcSystem.aHeaderOnCycle,b,x

        +
        rtl

        .databank 0

      rlProcDialogueWithBGCycle5 ; 82/89FF

        .al
        .autsiz
        .databank ?

        lda #2
        sta aProcSystem.aBody0,b,x
        lda #<>rlProcDialogueWithBGCycle6
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

      rlProcDialogueWithBGCycle6 ; 82/8A0C

        .al
        .autsiz
        .databank ?

        lda aProcSystem.aBody0,b,x
        dec a
        sta aProcSystem.aBody0,b,x
        bne +

          jsl rlEventEngineFreeProc

        +
        rtl

        .databank 0

      aProcDialogueWithBGCode ; 82/8A1A

        PROC_HALT

      rlUnknown828A1C ; 82/8A1C

        .al
        .autsiz
        .databank ?

        php
        and #$FFFF
        beq +

        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitCharacterID
        bra ++

        +
        lda #1

        +
        plp
        rtl

        .databank 0

        ; 82/8A30

    .endsection DialogueWithBGSection
