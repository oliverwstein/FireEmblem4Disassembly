; Pop-ups on the map: the castle name, gold, seizing a castle, getting an item; a
; second pop-up proc (procUnknown85BB52) and the window colours by army
; (rlSetWindowColoursByRelation).

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
        jsl rlRunDialogueCycle
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
        jsl rlRunDialogueCycle
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

        jsl rlSetDialogueFontAndColors

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

      procDemoSkipFadeOut ; 82/8865

        .structProcInfo "TT", rlProcDemoSkipFadeOutInit, rlProcDemoSkipFadeOutCycle1, aProcDemoSkipFadeOutCode

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
        jsl rlHideMapWindows
        lda #$0000
        sta wBufferBG3VOFS
        sta wBufferBG3HOFS
        lda aProcSystem.wInput2,b
        jsl rlSetMapMenuPosition
        lda aProcSystem.wInput3,b
        jsl rlResizeMapMenuFrame
        lda aProcSystem.wInput1,b
        jsl rlSetWindowColoursByRelation
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
        jsl rlSetWindowColoursByRelation
        jsl rlShowMapWindows
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
        jsl rlStartMapMenuGradient
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

      rlSetWindowColoursByRelation ; 85/C4E0

        .al
        .xl
        .autsiz
        .databank ?

        ; A = relation to the player (rlGetFactionRelation): BG colours 8-15 from aWindowColoursByRelation; -1 puts back aWindowPalette's.

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
        lda <>aWindowColoursByRelation,b,y
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

      aWindowColoursByRelation ; 85/C51B

        ; Read by rlSetWindowColoursByRelation.

        .word $0000, $02FC, $7292, $6A70, $6A2F, $660E, $61ED, $04A7
        .word $0000, $02FC, $2976, $2555, $2134, $1D13, $18F2, $04A4
        .word $0000, $02FC, $5370, $4B2E, $470D, $42EC, $3AAA, $04A7
        .word $0000, $02FC, $46D7, $3EB6, $3E95, $3275, $2655, $0CE9

        ; 85/C55B

    .endsection Data85C51BSection


    .section Unsorted85B8D6Section

      .al
      .xl

      rlOpenGoldPopUp ; 85/B8D6

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`procGoldPopUp)<<8
        sta lR44+1
        lda #<>procGoldPopUp
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 85/B8E5

    .endsection Unsorted85B8D6Section


    .section Table85B8E5Section

      .al
      .xl

      aGoldPopUpTilemapData ; 85/B8E5
        .byte $20, $04, $88, $83, $7E, $00, $4A, $CE, $7F

    .endsection Table85B8E5Section


    .section Unsorted85B8EESection

      .al
      .xl

      aGoldPopUpData ; 85/B8EE

        .long 0
        .long 0
        .long aGoldPopUpTilemapData
        .byte 0, 1, 1

    .endsection Unsorted85B8EESection


    .section ProcScript85B8FASection

      .al
      .xl

      procGoldPopUp ; 85/B8FA

        .structProcInfo "PW", rlProcGoldPopUpInit, rlProcGoldPopUpShow, aProcDialogueBoxCode


        .long aGoldPopUpData
        .byte 1

    .endsection ProcScript85B8FASection


    .section Unsorted85B906Section

      .al
      .xl

      rlProcGoldPopUpInit ; 85/B906

        .al
        .xl
        .autsiz
        .databank ?

        ; "<n> ゴールドてにいれた！" (got n gold): wInput2 = the gold, wInput3 = row (high byte). Sized to the digits and centred; stays 180 frames (aBody5).

        jsl rlInitMapMenuProc
        jsl rlHideMapWindows
        lda #$00B4
        sta aProcSystem.aBody5,b,x
        lda aProcSystem.wInput3,b
        and #$FF00
        sta aProcSystem.aBody7,b,x
        lda aProcSystem.wInput2,b
        sta aProcSystem.aBody6,b,x
        ldy #$0000
        cmp #$000A
        bmi _B93E
        cmp #$0064
        bmi _B93D
        cmp #$03E8
        bmi _B93C
        cmp #$2710
        bmi _B93B
        inc y

        _B93B
        inc y

        _B93C
        inc y

        _B93D
        inc y

        _B93E
        inc y
        tya
        clc
        adc #$000E
        sta wR0
        ora #$0400
        jsl rlSetMapMenuTilemapArea
        lda #$0020
        sec
        sbc wR0
        lsr a
        ora aProcSystem.aBody7,b,x
        jsl rlSetMapMenuPosition
        phx
        phy
        lda #$20F0
        sta aCurrentTilemapInfo,b
        lda aProcSystem.aBody6,b,x
        sta wR0

        _B968
        dec y
        lda wR0
        sta wR13
        lda #$000A
        sta wR14
        jsl rlUnsignedDivide16By16R13
        lda wR13
        sta wR0
        lda wR10
        beq _B980
        bra _B983


        _B980
        tya
        bmi _B991

        _B983
        tya
        clc
        adc #$0101
        tax
        lda wR10
        jsl rlDrawMapMenuNumber
        bra _B968


        _B991
        ply
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda #(`aGoldPopUpText)<<8
        sta lR18+1
        lda #<>aGoldPopUpText
        sta lR18
        tya
        clc
        adc #$0102
        tax
        jsl rlDrawMapMenuTextLine
        jsl rlDrawMapMenu
        jsl rlHideMapMenuLayers
        plx
        lda #$0094
        sta aProcSystem.aBody4,b,x
        rtl

        .databank 0

        ; 85/B9BC

    .endsection Unsorted85B906Section


    .section Table85B9BCSection

      .al
      .xl

      aGoldPopUpText ; 85/B9BC

        .enc "SJIS"
        .text "　ゴールドてにいれた！"
        .word $0000
        .enc "none"


    .endsection Table85B9BCSection


    .section Unsorted85B9D4Section

      .al
      .xl

      rlProcGoldPopUpShow ; 85/B9D4

        .al
        .autsiz
        .databank ?

        ; Once no music is loading: shows the window and plays sound $94 (aBody4).

        lda wMusicID,b
        bne +

          jsl rlShowMapMenuLayers
          lda #$00F7
          jsl rlSendSoundCommand
          lda aProcSystem.aBody4,b,x
          jsl rlPlaySoundEffect
          lda #<>rlProcGoldPopUpCheckSkip
          sta aProcSystem.aHeaderOnCycle,b,x

        +
        rtl

        .databank 0

        ; 85/B9F2

    .endsection Unsorted85B9D4Section


    .section Unsorted85B9F2Section

      .al
      .xl

      rlProcGoldPopUpCheckSkip ; 85/B9F2

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; A button takes 60 frames off.

        lda wJoy1New
        bit #$D0C0
        beq rlProcGoldPopUpWait
        lda #<>rlProcGoldPopUpWait
        sta aProcSystem.aHeaderOnCycle,b,x
        lda aProcSystem.aBody5,b,x
        sec
        sbc #$003C
        sta aProcSystem.aBody5,b,x

        .databank 0

      rlProcGoldPopUpWait ; 85/BA09

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aBody5,b,x
        dec a
        bmi _BA13
        sta aProcSystem.aBody5,b,x

        _BA12
        rtl


        _BA13
        jsl rlLoadMapMenuEntryPointerFromProcBody
        jsl rlCloseMapMenuFromProc
        jsl rlUnknown85C0C7
        jsl rlShowMapWindows
        lda #$00E8
        jsl rlSendSoundCommand
        bra _BA12

        .databank 0

        ; 85/BA2C

    .endsection Unsorted85B9F2Section


    .section Table85BA2CSection

      .al
      .xl

      aSeizePopUpTilemapData ; 85/BA2C
        .byte $20, $04, $88, $83, $7E, $00, $4A, $CE, $7F

      aSeizePopUpData ; 85/BA35
        .long $000000
        .long $000000
        .long aSeizePopUpTilemapData
        .byte $00, $01, $01

    .endsection Table85BA2CSection


    .section Unsorted85BA41Section

      .al
      .xl

      procSeizePopUp .structProcInfo "PW", rlProcSeizePopUpInit, rlProcSeizePopUpWaitMusic, aProcDialogueBoxCode ; 85/BA41

        .long aSeizePopUpData
        .byte 1

    .endsection Unsorted85BA41Section


    .section Unsorted85BA4DSection

      .al
      .xl

      rlProcSeizePopUpInit ; 85/BA4D

        .al
        .autsiz
        .databank ?

        ; "<castle> をせいあつした！" (seized the castle): wInput3 = location, wInput2 = frames to wait before showing (aBody6); stays 366 frames (aBody7).

        jsl rlInitMapMenuProc
        jsl rlHideMapWindows

        lda #$016E
        sta aProcSystem.aBody7,b,x
        lda aProcSystem.wInput2,b
        sta aProcSystem.aBody6,b,x
        lda aProcSystem.wInput3,b
        jsl rlGetLocationEventDataEntry
        jsl rlGetEventLocationEntryCastleName
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        jsl rlGetMenuTextStringLength

        lda wR10
        clc
        adc #12
        sta wR0
        ora #$0400
        jsl rlSetMapMenuTilemapArea

        lda #$0020
        sec
        sbc wR0
        lsr a
        ora #$0C00
        jsl rlSetMapMenuPosition

        lda #(`aSeizePopUpText)<<8
        sta lR19+1
        lda #<>aSeizePopUpText
        sta lR19
        ldx #$0102
        lda #$2000
        sta aCurrentTilemapInfo.wBaseTile,b
        jsl rlDrawTwoMapMenuTextLines
        jsl rlHideMapMenu
        rtl

        .databank 0

        ; 85/BAB3

    .endsection Unsorted85BA4DSection


    .section Table85BAB3Section

      .al
      .xl

      aSeizePopUpText ; 85/BAB3

        .enc "SJIS"
        .text "　をせいあつした！"
        .word $0000
        .enc "none"


    .endsection Table85BAB3Section


    .section Unsorted85BAC7Section

      .al
      .xl

      rlProcSeizePopUpWaitMusic ; 85/BAC7

        .al
        .xl
        .autsiz
        .databank ?

        lda wMusicID,b
        bne _BAD8
        lda #$0001
        sta wSoundUploadBusyFlag,b
        lda #<>rlProcSeizePopUpWaitToShow
        sta aProcSystem.aHeaderOnCycle,b,x

        _BAD8
        rtl

        .databank 0

        ; 85/BAD9

    .endsection Unsorted85BAC7Section


    .section Unsorted85BAD9Section

      .al
      .xl

      rlProcSeizePopUpWaitToShow ; 85/BAD9

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aBody6,b,x
        dec a
        bmi _BAE3
        sta aProcSystem.aBody6,b,x
        rtl


        _BAE3
        jsl rlLoadMapMenuEntryPointerFromProcBody
        jsl rlShowMapMenu
        lda #$0095
        jsl rlPlaySoundEffect
        lda #<>rlProcSeizePopUpCheckSkip
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 85/BAF9

      rlProcSeizePopUpCheckSkip ; 85/BAF9

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda wJoy1New
        bit #$D0C0
        beq rlProcSeizePopUpWait
        lda #<>rlProcSeizePopUpWait
        sta aProcSystem.aHeaderOnCycle,b,x
        lda aProcSystem.aBody7,b,x
        sec
        sbc #$003C
        sta aProcSystem.aBody7,b,x

        .databank 0

      rlProcSeizePopUpWait ; 85/BB10

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aBody7,b,x
        dec a
        bmi _BB1A
        sta aProcSystem.aBody7,b,x

        _BB19
        rtl


        _BB1A
        jsl rlLoadMapMenuEntryPointerFromProcBody
        jsl rlCloseMapMenuFromProc
        jsl rlUnknown85C0C7
        lda #$0000
        sta wSoundUploadBusyFlag,b
        bra _BB19

        .databank 0

        ; 85/BB2E

    .endsection Unsorted85BAD9Section


    .section Unsorted85BB2ESection

      .al
      .xl

      rlOpenSeizePopUp ; 85/BB2E

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`procSeizePopUp)<<8
        sta lR44+1
        lda #<>procSeizePopUp
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 85/BB3D


      aUnknown85BB3D ; 85/BB3D

        .structMapMenuTilemapData 32, 4, aBG3TilemapBuffer, 0, $7FCE4A

      aUnknown85BB46 ; 85/BB46

        .long 0, 0, aUnknown85BB3D
        .byte 0, 1, 1

    .endsection Unsorted85BB2ESection


    .section Unsorted85BC00Section

      .al
      .xl

      rlOpenItemPopUp ; 85/BC00

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`procUnknown85BC0F)<<8
        sta lR44+1
        lda #<>procUnknown85BC0F
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 85/BC0F

    .endsection Unsorted85BC00Section


    .section Unsorted85BC1BSection

      .al
      .xl

      rlProcItemPopUpInit ; 85/BC1B

        .al
        .autsiz
        .databank ?

        ; "<item> をてにいれた！" (got the item): wInput2 = item ID, wInput3 = row. Item $50 gets sound $96 and 60 more frames.

        phx
        jsl rlInitMapMenuProc
        lda #$0093
        sta aProcSystem.aBody5,b,x
        lda aProcSystem.wInput2,b
        jsl rlGetItemNamePointerByItemID
        lda lRoutineVariable,b
        sta lR18
        lda $0571+1,b
        sta lR18+1
        lda #(`aItemObtainedText)<<8
        sta lR19+1
        lda #<>aItemObtainedText
        sta lR19
        lda aProcSystem.wInput3,b
        ldx #$0400
        jsl rlGetCenteredTextBoxPlacement
        pha
        dec a
        jsl rlSetMapMenuPosition
        txa
        inc a
        inc a
        jsl rlSetMapMenuTilemapArea
        pla
        and #$FF00
        lda #$2000
        sta aCurrentTilemapInfo.wBaseTile,b
        ldx #$0102
        jsl rlDrawTwoMapMenuTextLines
        jsl rlDrawMapMenu
        plx
        lda aProcSystem.wInput2,b
        cmp #$0050
        bne +

        lda aProcSystem.aBody5,b,x
        clc
        adc #$003C
        sta aProcSystem.aBody5,b,x
        lda #$0096
        bra ++
        
        +
        lda #$0092
        
        +
        sta aProcSystem.aBody4,b,x
        rtl

        .databank 0

    .endsection Unsorted85BC1BSection


    .section ItemObtainedTextSection

      .al
      .xl

      aItemObtainedText ; 85/BC8C

        .enc "SJIS"
        .text "　をてにいれた！\n"

    .endsection ItemObtainedTextSection


