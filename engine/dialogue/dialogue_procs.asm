; The procs that run a dialogue scene, with and without a background picture,
; and the colour intensity effect they use.

    .section DialogueSection

      .al
      .xl

      procDialogue ; 82/845F

        .structProcInfo "TT", rlProcDialogueInit, rlProcDialogueCycle1, aProcDialogueCode
        .word 0

    .endsection DialogueSection


    .section ProcDialogueInitSection

      .al
      .xl

      rlProcDialogueInit ; 82/8469

        .al
        .autsiz
        .databank ?

        lda #8
        sta aProcSystem.aBody0,b,x

        jsl rlResetDialogueEngine

        ldy wActiveEventOffset,b
        lda lActiveEventPointer,b
        sta @l lR22
        lda lActiveEventPointer+1,b
        sta @l lR22+1

        lda [lR22],y
        sta lR18
        inc y
        lda [lR22],y
        sta lR18+1
        jsl rlUnknown828653

        lda wEventUnit1Pointer,b
        jsl rlUnknown828A1C
        sta aDialogue.wUnit1,b

        lda wEventUnit2Pointer,b
        jsl rlUnknown828A1C
        sta aDialogue.wUnit2,b

        lda #5
        sta aEpilogueUnitStates
        lda #11
        sta $7FC54C
        lda #21
        sta $7FC5AE
        lda #11
        sta $7FC5B0

        lda bBufferINIDISP
        and #$000F
        cmp #$000F
        beq _End

          lda #(`procFadeIn)<<8
          sta lR44+1
          lda #<>procFadeIn
          sta lR44
          jsl rlProcEngineFindProc
          bcs _End

            lda #(`procFadeIn)<<8
            sta lR44+1
            lda #<>procFadeIn
            sta lR44
            jsl rlProcEngineCreateProc

        _End
        rtl

        .databank 0

    .endsection ProcDialogueInitSection


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

        jsl rlQueueMenuFontDecompression
        lda #<>rlProcDialogueCycle7
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

      rlProcDialogueCycle7 ; 82/8581

        .al
        .autsiz
        .databank ?

        lda bDecompressionArrayFlag,b
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
        jsl rlLoadMenuIconGraphics
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
          jsl rlUnknown85BD12

        +
        lda aDialogue._Slot[1].wPortraitID
        cmp #$FFFF
        beq +

          lda aDialogue.wUnknown0018A5,b
          ldy #1
          jsl rlUnknown85BD12

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

          jsl rlUnknown85BD93

        _End
        rts

        .databank 0

    .endsection ProcDialogueCycle1Section


    .section Unknown82862ESection

      .al
      .xl

      rsUnknown82862E ; 82/862E

        .al
        .autsiz
        .databank ?

        ; Sets the position of the A press arrow based on the currently active slot

        ldx #$00E0
        ldy #$0038

        lda aDialogue.wSlotOffset,b
        beq +

          ldx #$00E0
          ldy #$00C8

        +
        stx wR0
        sty wR1
        jsl rlDisplayDialogueAPressArrows
        rts

        .databank 0

        ; 82/8648

    .endsection Unknown82862ESection


    .section Unknown828653Section

      .al
      .xl

      rlUnknown828653 ; 82/8653

        .al
        .autsiz
        .databank ?

        ; Input:
        ; lR18 = dialogue pointer

        php
        jsl rlFreeHDMAEntry0

        lda #1
        jsl rlDialogueStartTextAndHDMA

        lda #1
        sta aDialogue.wTextSound,b
        jsl rlUnknown91A928

        ldx #0
        jsl rlUnknown919420._944B

        ldx #$0019
        jsl rlUnknown919420._944B

        lda #4
        sta wBufferBG3HOFS
        sep #$20
        lda #$06
        tsb bBufferTM
        lda #0
        sta bBufferCGWSEL
        lda #$91
        sta bBufferCGADSUB
        lda #0
        sta bBufferCOLDATA_0
        jsl rlApplyCOLDATA0Intensity
        plp
        rtl

        .databank 0

    .endsection Unknown828653Section


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


    .section ProcDialogueWithBGFromPointerSection

      .al
      .xl

      procDialogueWithBGFromPointer ; 82/88E9

        .structProcInfo "TT", rlProcDialogueWithBGFromPointerInit, rlProcDialogueWithBGCycle1, aProcDialogueWithBGCode

    .endsection ProcDialogueWithBGFromPointerSection


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

        _8921
        lda [lR22],y
        sta lBaseSceneDialoguePointer,b
        inc y
        lda [lR22],y
        sta $08AF+1,b
        inc y
        inc y

        lda [lR22],y
        and #$00FF
        sta wBaseSceneArgument,b
        inc y

        lda [lR22],y
        and #$00FF
        sta aProcSystem.aBody0,b,x
        cmp #$00FF
        bne +

          lda #3

        +
        sta wBaseSceneMode,b
        inc y

        lda [lR22],y
        and #$00FF
        sta wScreenFadingProcInput,b

        stz wBaseSceneFlags,b
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
        lda wGameStateRoutine1,b
        cmp #GAMESTATE_MAP_STEP
        bne +

          jsl rlUnknown88B3AF

        +
        lda #2
        sta wCastleScreenHandler,b
        lda #<>rsOpenCastleScreen
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
          jsl rlUnknown8AE29F

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


    .section Unsorted8AE29FSection

      .al
      .xl

      rlUnknown8AE29F ; 8A/E29F

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`procUnknown8AE147)<<8
        sta lR44+1
        lda #<>procUnknown8AE147
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


    .section Unsorted828648Section

      .al
      .xl

      rlStartDialogueWithBoxGraphics ; 82/8648

        .al
        .xl
        .autsiz
        .databank ?

        ; Start dialogue HDMA/text in mode 1 (rlUnknown828653) and load box graphics/palette

        php
        jsl rlUnknown828653
        jsl rlGetDialogueBoxGraphicsAndPalette
        plp
        rtl

        .databank 0

        ; 82/8653

    .endsection Unsorted828648Section


    .section Unsorted8288F3Section

      .al
      .xl

      rlProcDialogueWithBGFromPointerInit ; 82/88F3

        ; Runs on into built code at the end.
        .al
        .xl
        .autsiz
        .databank ?

        ; Load lR22 from aBody0/aBody1 and branch into rlProcDialogueWithBGInit._8921

        ldy #$0000
        lda aProcSystem.aBody0,b
        sta @l lR22
        lda aProcSystem.aBody1,b
        sta @l lR22+1
        bra rlProcDialogueWithBGInit._8921

        .databank 0

        ; 82/8906

    .endsection Unsorted8288F3Section


