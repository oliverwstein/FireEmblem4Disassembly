; The castle conversation scene (steps $0B/$0C): two portraits over a dialogue
; background (fountain, gate, alley, hallway, throne, cloister), with windows and
; fades driven by wConversationFlags, and an exit chosen by wConversationExitMode. Events
; and the dialogue engine start it. Also the background loader and the fountain
; and throne animations. Banks $8A and $8C.


    .section Unsorted8ABB3ESection

      .al
      .xl

      rlLoadDialogueBackground ; 8A/BB3E

        .al
        .xl
        .autsiz
        .databank ?

        ; Decompresses and loads dialogue background wConversationBackground (aDialogueBackgroundPointers): two tile sets, the palette and two tilemaps.

        lda wConversationBackground,b
        asl a
        clc
        adc wConversationBackground,b
        tax
        lda aDialogueBackgroundPointers+1,x
        sta lR19+1
        lda aDialogueBackgroundPointers,x
        sta lR19
        ldy #$0000
        lda [lR19],y
        sta lR45
        ldy #$0001
        lda [lR19],y
        sta lR45+1
        lda #(`aDecompressionBuffer)<<8
        sta lR47+1
        lda #<>aDecompressionBuffer
        sta lR47
        jsl rlDecompressSingle
        lda #(`aDecompressionBuffer)<<8
        sta lR20+1
        lda #<>aDecompressionBuffer
        sta lR20
        sep #$20
        lda #$80
        sta $2115,b
        lda #$00
        sta $4315,b
        lda #$20
        sta $4316,b
        lda #$18
        sta $4311,b
        lda lR20
        sta $4312,b
        lda lR20+1
        sta $4313,b
        lda lR20+2
        sta $4314,b
        lda #$00
        sta $2116,b
        lda #$20
        sta $2117,b
        lda #$01
        sta $4310,b
        lda #$02
        sta $420B,b
        rep #$20
        ldy #$0003
        lda [lR19],y
        sta lR45
        ldy #$0004
        lda [lR19],y
        sta lR45+1
        lda #(`aDecompressionBuffer)<<8
        sta lR47+1
        lda #<>aDecompressionBuffer
        sta lR47
        jsl rlDecompressSingle
        lda #(`aDecompressionBuffer)<<8
        sta lR20+1
        lda #<>aDecompressionBuffer
        sta lR20
        sep #$20
        lda #$80
        sta $2115,b
        lda #$00
        sta $4315,b
        lda #$40
        sta $4316,b
        lda #$18
        sta $4311,b
        lda lR20
        sta $4312,b
        lda lR20+1
        sta $4313,b
        lda lR20+2
        sta $4314,b
        lda #$00
        sta $2116,b
        lda #$00
        sta $2117,b
        lda #$01
        sta $4310,b
        lda #$02
        sta $420B,b
        rep #$20
        ldy #$0007
        lda [lR19],y
        sta lR20+1
        ldy #$0006
        lda [lR19],y
        sta lR20
        ldy #$01FE

        _BC26
        lda [lR20],y
        sta aBGPaletteBuffer,b,y
        dec y
        dec y
        bpl _BC26
        lda #$0000
        sta aBGPaletteBuffer,b
        ldy #$0009
        lda [lR19],y
        sta lR45
        ldy #$000A
        lda [lR19],y
        sta lR45+1
        lda #(`aDecompressionBuffer)<<8
        sta lR47+1
        lda #<>aDecompressionBuffer
        sta lR47
        jsl rlDecompressSingle
        lda #(`aDecompressionBuffer)<<8
        sta lR20+1
        lda #<>aDecompressionBuffer
        sta lR20
        sep #$20
        lda #$80
        sta $2115,b
        lda #$00
        sta $4315,b
        lda #$08
        sta $4316,b
        lda #$18
        sta $4311,b
        lda lR20
        sta $4312,b
        lda lR20+1
        sta $4313,b
        lda lR20+2
        sta $4314,b
        lda #$00
        sta $2116,b
        lda #$70
        sta $2117,b
        lda #$01
        sta $4310,b
        lda #$02
        sta $420B,b
        rep #$20
        ldy #$000C
        lda [lR19],y
        sta lR45
        ldy #$000D
        lda [lR19],y
        sta lR45+1
        lda #(`aDecompressionBuffer)<<8
        sta lR47+1
        lda #<>aDecompressionBuffer
        sta lR47
        jsl rlDecompressSingle
        lda #(`aDecompressionBuffer)<<8
        sta lR20+1
        lda #<>aDecompressionBuffer
        sta lR20
        sep #$20
        lda #$80
        sta $2115,b
        lda #$C0
        sta $4315,b
        lda #$02
        sta $4316,b
        lda #$18
        sta $4311,b
        lda lR20
        sta $4312,b
        lda lR20+1
        sta $4313,b
        lda lR20+2
        sta $4314,b
        lda #$20
        sta $2116,b
        lda #$75
        sta $2117,b
        lda #$01
        sta $4310,b
        lda #$02
        sta $420B,b
        rep #$20
        rtl

        .databank 0

        ; 8A/BCF8

    .endsection Unsorted8ABB3ESection


    .section Unsorted8AD81BSection

      .al
      .xl

      rlConversationSceneSetup ; 8A/D81B

        .al
        .xl
        .autsiz
        .databank ?

        ; Blanks the screen and loads a conversation scene: background wConversationBackground, the two portraits and their windows.

        phk
        plb
        .databank $8A
        sep #$20
        lda #$80
        sta $2100,b
        sta bBufferINIDISP
        rep #$20
        jsl rlDisableVBlank
        jsl rlResetHDMAEngine
        lda #$0000
        sta wR1
        lda #$0000
        sta wR2
        lda #$4000
        sta wR3
        sta wR4
        lda #$6000
        sta wR5
        lda #$7000
        sta wR6
        lda #$7400
        sta wR7
        lda #$7800
        sta wR8
        jsl rlSetLayerPositionsAndSizes
        jsl rlDMAByStruct

          .structDMAToVRAM g4bppCursorSprites, $0400, $80, $C000

        jsl rlDMAByStruct

          .structDMAToVRAM g4bppUnknownDA7A00, $0400, $80, $C400

        ldx #$07FE
        lda #$00FF

        _D879
        sta aBG3TilemapBuffer,x
        dec x
        dec x
        bpl _D879
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0800, $80, $F000

        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0800, $80, $E800

        jsl rlLoadDialogueBackground
        jsl rlGetDialogueBoxGraphicsAndPalette
        ldx #$000E

        _D8A6
        lda aCastleVendorOAMPalettes,x
        sta aOAMPaletteBuffer,b,x
        dec x
        dec x
        bpl _D8A6
        lda #(`aDecompressionDMAEntry8AD952)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry8AD952
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        lda wConversationFlags,b
        bit #$0004
        beq _D8CB
        jsl rlConversationOpenLeftWindow

        _D8CB
        lda wConversationFlags,b
        bit #$0008
        beq _D8D7
        jsl rlConversationOpenRightWindow

        _D8D7
        lda wConversationFlags,b
        bit #$0001
        beq _D8E6
        lda wConversationLeftUnit,b
        jsl rlLoadKeeperPortrait

        _D8E6
        lda wConversationFlags,b
        bit #$0002
        beq _D8F5
        lda wConversationRightUnit,b
        jsl rlLoadUnitPortrait

        _D8F5
        sep #$20
        lda #$17
        sta bBufferTM
        lda #$00
        sta bBufferTS
        lda #$00
        sta bBufferCGWSEL
        lda #$00
        sta bBufferCGADSUB
        rep #$20
        stz wMenuState,b
        stz wCastleMenuOptionIndex,b
        stz wCastleConfirmCursorIndex,b
        stz wCastleListWindowRow,b
        stz wCastleListSelectedIndex,b
        jsr rsResetFountainAnimation
        lda #CASTLE_STEP_CONVERSATION
        sta wGameStateStep,b
        lda wConversationExitMode,b
        cmp #CONVERSATION_EXIT_CALLBACK
        beq _D938
        rep #$20
        jsl rlEnableVBlank
        sep #$20
        lda #$0F
        sta bBufferINIDISP
        rep #$20
        rtl


        _D938
        lda #$0010
        sta wBufferBG1VOFS
        sta wBufferBG2VOFS
        sta wBufferBG3VOFS
        rep #$20
        jsl rlEnableVBlank
        sep #$20
        lda #$00
        sta bBufferINIDISP
        rep #$20
        rtl

        .databank 0

        ; 8A/D950

        ; Unused: 2 zero bytes.
        .fill 2, $00

    .endsection Unsorted8AD81BSection


    .section Unsorted8AD95ASection

      .al
      .xl

      rsResetFountainAnimation ; 8A/D95A

        .al
        .xl
        .autsiz
        .databank ?

        lda wConversationBackground,b
        cmp #$0000
        beq _D963
        rts


        _D963
        lda #$0000
        sta $7F80A3
        sta $7F80A5
        sta $7F80A7
        bra _D974


        _D974
        rts

        .databank 0

        ; 8A/D975

    .endsection Unsorted8AD95ASection


    .section Unsorted8AD975Section

      .al
      .xl

      rlConversationSceneStep ; 8A/D975

        .al
        .autsiz
        .databank ?

        ; Animates the background, loads portraits as wConversationFlags asks, runs sub-state wMenuState (aConversationSceneStepHandlers) and draws both portraits.

        phb
        php
        phk
        plb
        jsr rsAnimateConversationBackground

        lda wCastleRedrawIcons
        bne +

          jsl rlDMAByStruct
            .structDMAToVRAM aBG3TilemapBuffer, $0700, $80, $F000

          bra ++

        +
        lda #0
        sta wCastleRedrawIcons
        jsr rsConversationLoadPortraits
        jsr rsConversationDrawWindows

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
        lda wMenuState,b
        asl a
        tax
        jsr (aConversationSceneStepHandlers,x)

        lda wConversationFlags,b
        bit #$0001
        beq +

          lda #$0020
          sta wR0
          lda #$0060
          sta wR1
          ldx #0
          jsr rsPushKeeperPortraitSprites
          jsr rsPushConversationLeftFrame

        +
        lda wConversationFlags,b
        bit #$0002
        beq +

          lda #$00A0
          sta wR0
          lda #$0060
          sta wR1
          ldx #2
          jsr rsPushUnitPortraitSprites
          jsr rsPushConversationRightFrame

        +
        plp
        plb
        rtl

        .databank 0

    .endsection Unsorted8AD975Section


    .section Unsorted8AD9FESection

      .al
      .xl

      aConversationSceneStepHandlers ; 8A/D9FE

        .word <>rsConversationStart
        .word <>rsConversationWaitForText
        .word <>rsConversationEnd
        .word <>rsConversationWait
        .word <>rsConversationFadeOut

      rlConversationOpenLeftWindow ; 8A/DA08

        .al
        .autsiz
        .databank ?

        lda #$0044
        tsb wConversationFlags,b
        lda #1
        sta wCastleRedrawIcons
        rtl

        .databank 0

        ; 8A/DA16

    .endsection Unsorted8AD9FESection


    .section Unsorted8ADA16Section

      .al
      .xl

      rlConversationOpenRightWindow ; 8A/DA16

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0088
        tsb wConversationFlags,b
        lda #$0001
        sta wCastleRedrawIcons
        rtl

        .databank 0

        ; 8A/DA24

      rsConversationDrawWindows ; 8A/DA24

        .al
        .xl
        .autsiz
        .databank ?

        lda wConversationFlags,b
        bit #$0040
        beq _DA3F
        jsl rlDMAByStruct

          .structDMAToVRAM gUnknownDA6800, $0240, $80, $E800

        lda #$0040
        trb wConversationFlags,b

        _DA3F
        lda wConversationFlags,b
        bit #$0080
        beq _DA5A
        jsl rlDMAByStruct

          .structDMAToVRAM gUnknownDA6D00, $0240, $80, $ED00

        lda #$0080
        trb wConversationFlags,b

        _DA5A
        rts

        .databank 0

        ; 8A/DA5B

      rlConversationCloseLeftWindow ; 8A/DA5B

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0004
        trb wConversationFlags,b
        jsl rlDMAByStruct

          .structDMAToVRAM gUnknownDA6A40, $0240, $80, $E800

        rtl

        .databank 0

        ; 8A/DA6F

      rlConversationCloseRightWindow ; 8A/DA6F

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0008
        trb wConversationFlags,b
        jsl rlDMAByStruct

          .structDMAToVRAM gUnknownDA6A40, $0240, $80, $ED00

        rtl

        .databank 0

        ; 8A/DA83

    .endsection Unsorted8ADA16Section


    .section Unsorted8ADA83Section

      .al
      .xl

      rsConversationLoadPortraits ; 8A/DA83

        .al
        .autsiz
        .databank ?

        ; Loads the left and/or right portrait wConversationFlags asks for and starts its fade-in proc.

        lda wConversationFlags,b
        bit #$0010
        beq +

          lda wConversationLeftUnit,b
          jsl rlLoadKeeperPortrait
          lda #$0010
          trb wConversationFlags,b
          lda #(`procConversationFadeInLeftPortrait)<<8
          sta lR44+1
          lda #<>procConversationFadeInLeftPortrait
          sta lR44
          jsl rlProcEngineCreateProc

        +
        lda wConversationFlags,b
        bit #$0020
        beq +

          lda wConversationRightUnit,b
          jsl rlLoadUnitPortrait
          lda #$0020
          trb wConversationFlags,b
          lda #(`procConversationFadeInRightPortrait)<<8
          sta lR44+1
          lda #<>procConversationFadeInRightPortrait
          sta lR44
          jsl rlProcEngineCreateProc

        +
        rts

        .databank 0

      rlConversationShowLeftPortrait ; 8A/DACA

        .al
        .autsiz
        .databank ?

        lda #$0011
        tsb wConversationFlags,b
        lda #1
        sta wCastleRedrawIcons
        rtl

        .databank 0

      rlConversationShowRightPortrait ; 8A/DAD8

        .al
        .autsiz
        .databank ?

        lda #$0022
        tsb wConversationFlags,b
        lda #1
        sta wCastleRedrawIcons
        rtl

        .databank 0

      rlConversationFadeOutLeftPortrait ; 8A/DAE6

        .al
        .autsiz
        .databank ?

        lda #(`procConversationFadeOutLeftPortrait)<<8
        sta lR44+1
        lda #<>procConversationFadeOutLeftPortrait
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

      rlConversationFadeOutRightPortrait ; 8A/DAF5

        .al
        .autsiz
        .databank ?

        lda #(`procConversationFadeOutRightPortrait)<<8
        sta lR44+1
        lda #<>procConversationFadeOutRightPortrait
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 8A/DB04

    .endsection Unsorted8ADA83Section


    .section Unsorted8ADB04Section

      .al
      .xl

      rsPushConversationLeftFrame ; 8A/DB04

        .al
        .xl
        .autsiz
        .databank ?

        lda wConversationFlags,b
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


      aUnknown8ADB30 ; 8A/DB30

        _Sprites := [[(   0,    0), $21, SpriteLarge, $020, 3, 0, false, false]]

        .structSpriteArray aUnknown8ADB30._Sprites

    .endsection Unsorted8ADB04Section


    .section Unsorted8ADB37Section

      .al
      .xl

      rsPushConversationRightFrame ; 8A/DB37

        .al
        .xl
        .autsiz
        .databank ?

        lda wConversationFlags,b
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


    .section Table8ADB9FSection

      .al
      .xl

      aUnknown8ADB9F ; 8A/DB9F
        .byte $00, $00, $00, $00, $01, $00, $01, $00, $00, $00, $00, $00, $FF, $FF, $FF, $FF

      aUnknown8ADBAF ; 8A/DBAF
        .word 1 ; sprite count
        .structSpriteEntry (   0,    0), $21, SpriteLarge, $00A, 3, 0, false, false

      aUnknown8ADBB6 ; 8A/DBB6
        .word 1 ; sprite count
        .structSpriteEntry (   0,    0), $21, SpriteLarge, $008, 3, 0, false, false

    .endsection Table8ADB9FSection


    .section Unsorted8ADBBDSection

      .al
      .xl

      rsConversationStart ; 8A/DBBD

        .al
        .autsiz
        .databank ?

        ; Sub-state $00: starts lConversationDialoguePointer.

        jsl rlResetDialogueEngine

        lda $08AF+1,b
        sta $24+1
        lda lConversationDialoguePointer,b
        sta $24
        lda #2
        jsl rlDialogueStartTextAndHDMA

        lda #0
        sta aBGPaletteBuffer,b
        lda #2
        sta aDialogue.wUnknown0018D0,b
        ldx #0
        jsr rsConversationSetupSlots

        lda wConversationExitMode,b
        cmp #CONVERSATION_EXIT_CALLBACK
        bne +

          lda #$081E
          sta aDialogue._Slot[1].wDisplayArea,b

        +
        lda #1
        sta wMenuState,b
        lda #2
        sta wNextMenuState,b
        rts

        .databank 0

    .endsection Unsorted8ADBBDSection


    .section Unsorted8ADBFFSection

      .al
      .xl

      rsConversationWaitForText ; 8A/DBFF

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
        lda wNextMenuState,b
        sta wMenuState,b
        rts

        .databank 0

        ; 8A/DC25

    .endsection Unsorted8ADBFFSection


    .section Unsorted8ADC25Section

      .al
      .xl

      rsConversationEnd ; 8A/DC25

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Sub-state $02: leaves by wConversationExitMode: 0 the courtyard, 1 the town, 3 the map, 4 a fade then rlShowNextEpilogueCharacterEnding, 5 a fade out.

        lda wConversationExitMode,b
        cmp #CONVERSATION_EXIT_COURTYARD
        beq _DC41
        cmp #CONVERSATION_EXIT_TOWN
        beq _DC7A
        cmp #CONVERSATION_EXIT_CALLBACK
        beq _DC73
        cmp #CONVERSATION_EXIT_FADE_OUT
        beq _DC5E
        cmp #CONVERSATION_EXIT_MAP
        beq _DCB6

        _DC41
        lda #CASTLE_CURSOR_GRID
        sta wCastleCursorState,b
        jsl rlBuildCastleUnitList
        jsl rlCastleBuildCourtyardTables
        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        lda #CASTLE_STEP_RETURN_TO_COURTYARD
        sta wGameStateStep,b
        rts


        _DC5E
        lda #$0003
        sta wMenuState,b
        lda #(`procFadeOutByScreenFadingTimer)<<8
        sta lR44+1
        lda #<>procFadeOutByScreenFadingTimer
        sta lR44
        jsl rlProcEngineCreateProc
        rts


        _DC73
        lda #$0004
        sta wMenuState,b
        rts


        _DC7A
        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        lda #CASTLE_STEP_REOPEN_TOWN_SAME_SONG
        sta wGameStateStep,b
        lda #$0000
        jsl rlGetFactionSlotLocationID
        cmp wEnteredCastleLocationID,b
        bne _DCA9
        lda #CASTLE_SCREEN_COURTYARD
        sta wCastleScreenHandler,b
        jsl rlBuildCastleUnitList
        jsl rlCastleBuildCourtyardTables
        lda wCastleEventUnit,b
        sta wSelectedUnitDataRAMPointer,b
        rts


        _DCA9
        lda #CASTLE_SCREEN_TOWN
        sta wCastleScreenHandler,b
        lda wCastleEventUnit,b
        sta wSelectedUnitDataRAMPointer,b
        rts


        _DCB6
        lda #$0003
        sta wMenuState,b
        lda #$0000
        sta wMainGameMode,b
        lda #<>rsReturnToMapMainLoop
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFadeByTimer)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFadeByTimer
        sta lR44
        jsl rlProcEngineFindProc
        bcs _DCDC
        jsl rlProcEngineCreateProc

        _DCDC
        rts

        .databank 0

        ; 8A/DCDD

    .endsection Unsorted8ADC25Section


    .section Unsorted8ADCDDSection

      .al
      .xl

      rsConversationWait ; 8A/DCDD

        .al
        .xl
        .autsiz
        .databank ?

        rts

        .databank 0

        ; 8A/DCDE

    .endsection Unsorted8ADCDDSection


    .section Unsorted8ADCDESection

      .al
      .xl

      rsConversationFadeOut ; 8A/DCDE

        .al
        .xl
        .autsiz
        .databank ?

        ; Sub-state $04: fades out, then rlShowNextEpilogueCharacterEnding.

        lda wVBlankEnabledFramecount
        and #$0003
        bne _DCEF
        sep #$20
        lda bBufferINIDISP
        and #$0F
        beq _DCF2
        dec bBufferINIDISP

        _DCEF
        rep #$20
        rts


        _DCF2
        .as
        rep #$20
        jsl rlShowNextEpilogueCharacterEnding
        rts

        .databank 0

        ; 8A/DCF9

    .endsection Unsorted8ADCDESection


    .section Unsorted8ADCF9Section

      .al
      .xl

      rsConversationSetupSlots ; 8A/DCF9

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

      aUnknown8ADD98 .dstruct structHDMADirectEntryInfo, rlUnknown8ADDA3, rlUnknown8ADDA3, aUnknown8ADDA4, aUnknown8ADDB4, PPU_REG_BASE + $21, $00 ; 8A/DD98

        ; Unreferenced: two HDMA effects that write a colour gradient line by
        ; line, the colour index (CGADD) from aUnknown8ADDB4 and the colour
        ; (CGDATA) from aUnknown8ADE99.

      rlUnknown8ADDA3 ; 8A/DDA3

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

      aUnknown8ADDA4 ; 8A/DDA4

        HDMA_HALT

      aUnknown8ADDA6 .dstruct structHDMADirectEntryInfo, rlUnknown8ADDB1, rlUnknown8ADDB1, aUnknown8ADDB2, aUnknown8ADE99, PPU_REG_BASE + $22, $02 ; 8A/DDA6

      rlUnknown8ADDB1 ; 8A/DDB1

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

      aUnknown8ADDB2 ; 8A/DDB2

        HDMA_HALT

      aUnknown8ADDB4 ; 8A/DDB4

        .byte $C0, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $C0, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $C0, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $A0, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00

      aUnknown8ADE99 ; 8A/DE99

        .byte $C0, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $C0, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $53, $00, $53, $00, $53, $00, $53, $00, $53, $00, $53, $00, $53, $A0, $46
        .byte $A0, $46, $A0, $46, $A0, $46, $A0, $46, $A0, $46, $A0, $46, $A0, $46, $A0, $46
        .byte $A0, $46, $A0, $46, $A0, $46, $A0, $46, $A0, $46, $A0, $46, $A0, $46, $A0, $46
        .byte $A0, $46, $A0, $46, $A0, $46, $A0, $46, $A0, $46, $A0, $46, $A0, $46, $A0, $46
        .byte $A0, $46, $A0, $46, $A0, $46, $A0, $46, $A0, $46, $A0, $46, $A0, $46, $A0, $46
        .byte $A0, $46, $A0, $46, $60, $3E, $60, $3E, $60, $3E, $60, $3E, $60, $3E, $60, $3E
        .byte $60, $3E, $60, $3E, $C0, $29, $C0, $29, $C0, $29, $C0, $29, $C0, $29, $C0, $29
        .byte $C0, $29, $C0, $C0, $29, $C0, $29, $C0, $29, $C0, $29, $C0, $29, $C0, $29, $C0
        .byte $29, $C0, $29, $C0, $29, $C0, $29, $C0, $29, $C0, $29, $00, $53, $00, $53, $00
        .byte $53, $00, $53, $00, $53, $00, $53, $00, $53, $00, $53, $00, $53, $00, $53, $00
        .byte $53, $00, $53, $00, $53, $00, $53, $00, $53, $00, $53, $00, $53, $00, $53, $00
        .byte $53, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $A0, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00

    .endsection Unsorted8ADCF9Section


    .section Unsorted8AE05ESection

      .al
      .xl

      rsAnimateConversationBackground ; 8A/E05E

        .al
        .autsiz
        .databank ?

        lda wConversationBackground,b
        asl a
        tax
        jsr (aConversationBackgroundAnimations,x)
        rts

        .databank 0

      aConversationBackgroundAnimations ; 8A/E067

        .word <>rsAnimateFountainBackground
        .word <>rsConversationBackgroundNoAnimation
        .word <>rsConversationBackgroundNoAnimation
        .word <>rsConversationBackgroundNoAnimation
        .word <>rsAnimateThroneBackground
        .word <>rsConversationBackgroundNoAnimation
        .word <>rsConversationBackgroundNoAnimation

      rsConversationBackgroundNoAnimation ; 8A/E075

        .al
        .autsiz
        .databank ?

        rts

        .databank 0

      rsAnimateFountainBackground ; 8A/E076

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
          lda aUnknown8AE0C7+2,x
          bpl +

            lda #0
            sta $7F80A5
            tax
            lda aUnknown8AE0C7+2,x

          +
          sta $7F80A7
          lda aUnknown8AE0C7,x
        
        _E0A7
        sta $7F80A3

        lda $7F80A7
        asl a
        tax
        lda aUnknown8CA000,x
        sta $0170,b
        lda aUnknown8CA000+2,x
        sta $0172,b
        lda aUnknown8CA000+4,x
        sta $0174,b
        rts

        .databank 0

        ; 8A/E0C7

    .endsection Unsorted8AE05ESection


    .section Table8AE0C7Section

      .al
      .xl

      aUnknown8AE0C7 ; 8A/E0C7

        ; Pairs of words, ended by $FFFF, $FFFF. Read by rsAnimateFountainBackground.

        .word $0004, $0000, $0004, $0001, $0004, $0002, $FFFF, $FFFF

        ; 8A/E0D7

      rsAnimateThroneBackground ; 8A/E0D7

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F80A3
        sec
        sbc #$0001
        bpl _E108
        lda $7F80A5
        clc
        adc #$0004
        sta $7F80A5
        tax
        lda aUnknown8AE12F+2,x
        bpl _E100
        lda #$0000
        sta $7F80A5
        tax
        lda aUnknown8AE12F+2,x

        _E100
        sta $7F80A7
        lda aUnknown8AE12F,x

        _E108
        sta $7F80A3
        lda $7F80A7
        asl a
        tax
        lda aUnknown8CCB00,x
        sta $0186,b
        lda aUnknown8CCB40,x
        sta $0188,b
        lda aUnknown8CCB80,x
        sta $018A,b
        lda aUnknown8CCBC0,x
        sta $018C,b
        rts

        .databank 0

        ; 8A/E12F

      aUnknown8AE12F ; 8A/E12F

        ; Pairs of words, ended by $FFFF, $FFFF; read by rsAnimateThroneBackground.

        .word $0004, $0000, $0004, $0001, $0004, $0002, $0004, $0003
        .word $0004, $0004, $FFFF, $FFFF

        ; 8A/E147

    .endsection Table8AE0C7Section


    .section ProcScript8AE147Section

      .al
      .xl

      procConversationFadeInLeftPortrait ; 8A/E147

        .structProcInfo "FN", rlProcConversationFadeInLeftPortraitInit, rlProcConversationFadeInLeftPortraitCycle, aProcConversationFadeInLeftPortraitCode

    .endsection ProcScript8AE147Section


    .section Unsorted8AE14FSection

      .al
      .xl

      rlProcConversationFadeInLeftPortraitInit ; 8A/E14F

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlSavePaletteBufferColorsToRAM

          .byte $88, $9B, $7E, $10, $00, $A0, $01

        ldx #$001E
        lda #$0000

        _E160
        sta aOAMPaletteBuffer.aPalette5,b,x
        dec x
        dec x
        bpl _E160
        lda #$0000
        sta wConversationLeftFadeInStep
        rtl

        .databank 0

        ; 8A/E16F

      rlProcConversationFadeInLeftPortraitCycle ; 8A/E16F

        .al
        .xl
        .autsiz
        .databank ?

        lda wConversationLeftFadeInStep
        sta aPaletteFading.wCurrentStep,b
        lda #$0010
        sta aPaletteFading,b
        clc
        jsl rlFadePaletteToColors

          .byte $88, $9B, $10, $00, $A0, $01

        bcs _E191

        _E189
        lda aPaletteFading.wCurrentStep,b
        sta wConversationLeftFadeInStep
        rtl


        _E191
        jsl rlProcEngineFreeProc
        bra _E189

        .databank 0

        ; 8A/E197

    .endsection Unsorted8AE14FSection


    .section ProcScript8AE197Section

      .al
      .xl

      aProcConversationFadeInLeftPortraitCode ; 8A/E197

        PROC_HALT


        ; 8A/E199

    .endsection ProcScript8AE197Section


    .section Unsorted8AE199Section

      .al
      .xl

      procConversationFadeInRightPortrait ; 8A/E199

        .structProcInfo "F2", rlProcConversationFadeInRightPortraitInit, rlProcConversationFadeInRightPortraitCycle, aProcConversationFadeInRightPortraitCode

    .endsection Unsorted8AE199Section


    .section ProcUnknown8AE199InitSection

      .al
      .xl

      rlProcConversationFadeInRightPortraitInit ; 8A/E1A1

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
        sta wConversationRightFadeInStep
        rtl

        .databank 0

    .endsection ProcUnknown8AE199InitSection


    .section Unsorted8AE1C1Section

      .al
      .xl

      rlProcConversationFadeInRightPortraitCycle ; 8A/E1C1

        .al
        .autsiz
        .databank ?

        lda wConversationRightFadeInStep

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
          sta wConversationRightFadeInStep
          rtl

        +
        jsl rlProcEngineFreeProc
        bra -

        .databank 0

      aProcConversationFadeInRightPortraitCode ; 8A/E1E9

        PROC_HALT

    .endsection Unsorted8AE1C1Section


    .section Unsorted8AE1EBSection

      .al
      .xl

      procConversationFadeOutLeftPortrait ; 8A/E1EB

        .structProcInfo "FF", rlProcConversationFadeOutLeftPortraitInit, rlProcConversationFadeOutLeftPortraitCycle, aProcConversationFadeOutLeftPortraitCode

    .endsection Unsorted8AE1EBSection


    .section Unsorted8AE1F3Section

      .al
      .xl

      rlProcConversationFadeOutLeftPortraitInit ; 8A/E1F3

        .al
        .autsiz
        .databank ?

        lda #0
        sta wConversationLeftFadeOutStep
        rtl

        .databank 0

      rlProcConversationFadeOutLeftPortraitCycle ; 8A/E1FB

        .al
        .autsiz
        .databank ?

        lda wConversationLeftFadeOutStep
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
        sta wConversationLeftFadeOutStep
        rtl

        +
        lda #(`procConversationFadeInLeftPortrait)<<8
        sta lR44+1
        lda #<>procConversationFadeInLeftPortrait
        sta lR44
        phx
        jsl rlProcEngineFindProc
        plx
        bcs +

          lda #$0001
          trb wConversationFlags,b

        +
        jsl rlProcEngineFreeProc
        bra -

        .databank 0

        ; 8A/E23D


      aUnknown8AE23D ; 8A/E23D

        .word $01A2, $000F, $FFFF

    .endsection Unsorted8AE1F3Section


    .section ProcScript8AE243Section

      .al
      .xl

      aProcConversationFadeOutLeftPortraitCode ; 8A/E243

        PROC_HALT


        ; 8A/E245

    .endsection ProcScript8AE243Section


    .section Unsorted8AE245Section

      .al
      .xl

      procConversationFadeOutRightPortrait ; 8A/E245

        .structProcInfo "FF", rlProcConversationFadeOutRightPortraitInit, rlProcConversationFadeOutRightPortraitCycle, aProcConversationFadeOutRightPortraitCode

      rlProcConversationFadeOutRightPortraitInit ; 8A/E24D

        .al
        .autsiz
        .databank ?

        lda #0
        sta wConversationRightFadeOutStep
        rtl

        .databank 0

      rlProcConversationFadeOutRightPortraitCycle ; 8A/E255

        .al
        .autsiz
        .databank ?

        lda wConversationRightFadeOutStep
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
          sta wConversationRightFadeOutStep
          rtl

        +
        lda #(`procConversationFadeInRightPortrait)<<8
        sta lR44+1
        lda #<>procConversationFadeInRightPortrait
        sta lR44
        phx
        jsl rlProcEngineFindProc
        plx
        bcs +

          lda #$0002
          trb wConversationFlags,b

        +
        jsl rlProcEngineFreeProc
        bra -

        .databank 0

      aUnknown8AE297 ; 8A/E297

        .word $0182
        .word $000F
        .word $FFFF

      aProcConversationFadeOutRightPortraitCode ; 8A/E29D

        PROC_HALT

        ; 8A/E29F

    .endsection Unsorted8AE245Section


    .section Data8CCB00Section

      .al
      .xl

      aUnknown8CCB00 ; 8C/CB00

        ; Read by rsAnimateThroneBackground.

        .word $031F, $01FC, $0199, $0135, $0011, $031F, $01FC, $0199
        .word $0135, $0011, $031F, $01FC, $0199, $0135, $0011, $031F
        .word $01FC, $0199, $0135, $0011, $025F, $01FC, $0199, $0135
        .word $0011, $025F, $01FC, $0199, $0135, $0011, $025F, $01FC

        ; 8C/CB40

      aUnknown8CCB40 ; 8C/CB40

        ; Read by rsAnimateThroneBackground.

        .word $01FC, $0199, $0135, $0011, $025F, $01FC, $0199, $0135
        .word $0011, $025F, $01FC, $0199, $0135, $0011, $025F, $01FC
        .word $0199, $0135, $0011, $025F, $01FC, $0199, $0135, $0011
        .word $025F, $01FC, $0199, $0135, $0011, $025F, $01FC, $0199

        ; 8C/CB80

      aUnknown8CCB80 ; 8C/CB80

        ; Read by rsAnimateThroneBackground.

        .word $0199, $0135, $0011, $025F, $01FC, $0199, $0135, $0011
        .word $025F, $01FC, $0199, $0135, $0011, $025F, $01FC, $0199
        .word $00F3, $000F, $01FF, $01BA, $0157, $00F3, $000F, $01FF
        .word $01BA, $0157, $00F3, $000F, $01FF, $01BA, $0157, $00F3

        ; 8C/CBC0

      aUnknown8CCBC0 ; 8C/CBC0

        ; Read by rsAnimateThroneBackground.

        .word $0070, $000D, $0178, $0115, $00D3, $0070, $000D, $0178
        .word $0115, $00D3, $0070, $000D, $0178, $0115, $00D3, $0070
        .word $000D, $0178, $0115, $00D3, $0070, $000D, $0178, $0115
        .word $00D3, $0070, $000D, $0178, $0115, $00D3, $0070, $000D

        ; 8C/CC00

    .endsection Data8CCB00Section
