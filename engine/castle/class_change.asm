; Class change in the castle (steps $09/$0A), reached from the unit commands:
; the keeper says whether the unit can promote (level 20 and a promoted class)
; and rlStartCastleClassChange changes the class and starts the class change
; scene. Banks $84 and $8A.


    .section Unsorted84ABB0Section

      .al
      .xl

      rlStartCastleClassChange ; 84/ABB0

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Sets the unit's class to A, updates its map sprite and starts the class change scene (battle song $3C).

        phb
        php
        phk
        plb
        .databank $84
        phx
        pha
        lda #$7F00
        sta lRAMBufferPointer+1,b
        lda #$EB66
        sta lRAMBufferPointer,b
        jsl rlUnknown8499B5
        jsl rlClearBattleData
        ldx #$4EB5
        jsr rsUnknown84AC24
        pla
        jsl rlSetSelectedUnitClass
        jsl rlGetSelectedUnitDeploymentOffset
        tax
        jsl rlGetSelectedUnitMapSprite
        sta wR1
        jsl rlAddDeployedMapSprite
        sta aDeploymentTable._DeploymentOffsets,x
        lda #$7F00
        sta lRAMBufferPointer+1,b
        lda #$EBF4
        sta lRAMBufferPointer,b
        jsl rlUnknown8499B5
        ldx #$4F15
        jsr rsUnknown84AC24
        ldx #$4EF5
        jsr rsUnknown84AC50
        lda #$FFFF
        sta $7E4F85
        sep #$20
        lda #$02
        sta $7E4EA9
        rep #$20
        lda #$003C
        sta wBattleSong
        jsl rlUnknown81B368
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 84/AC24

    .endsection Unsorted84ABB0Section


    .section Unsorted8AECEFSection

      .al
      .xl

      rlClassChangeScreenSetup ; 8A/ECEF

        .al
        .xl
        .autsiz
        .databank ?

        ; Blanks the screen and loads the class change screen; moves to step $0A.

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
        phk
        plb
        .databank $8A
        rep #$30
        lda #$1809
        sta $4300,b
        lda #$8A00
        sta $4303,b
        lda #$EE80
        sta $4302,b
        lda #$0020
        sta $4305,b
        lda #$2400
        sta $2116,b
        sep #$20
        lda #$01
        sta $420B,b
        rep #$20
        jsr rsSetKeeperOptionList
        lda #$0000
        sta wR1
        lda #$0000
        sta wR2
        lda #$4000
        sta wR3
        sta wR4
        lda #$6000
        sta wR5
        lda #$2800
        sta wR6
        lda #$2C00
        sta wR7
        lda #$3800
        sta wR8
        jsl rlSetLayerPositionsAndSizes
        jsl rlResetDialogueEngine
        lda #(`aDecompressionDMAEntry8AEE91)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry8AEE91
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        lda #(`aDecompressionDMAEntry8AEE99)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry8AEE99
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        jsl rlDMAByStruct

          .structDMAToVRAM g4bppCursorSprites, $0400, $80, $C000

        jsl rlDMAByStruct

          .structDMAToVRAM g4bppWeaponTypeIcons, $0800, $80, $D600

        lda #(`aDecompressionDMAEntry8AEEA1)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry8AEEA1
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        lda #(`aDecompressionDMAEntry8AEEA9)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry8AEEA9
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        jsl rlDMAByStruct

          .structDMAToVRAM g2bppItemStatLabels, $0800, $80, $9800

        lda #(`aDecompressionDMAEntry8AEE89)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry8AEE89
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        jsl rlGetDialogueBoxGraphicsAndPalette
        ldx #$0800
        lda #$00FF

        _EDD6
        sta aBG3TilemapBuffer,x
        dec x
        dec x
        bne _EDD6
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0700, $80, $7000

        ldx #$01FE

        _EDEE
        lda aUnknown8CD000,x
        sta aBGPaletteBuffer,b,x
        dec x
        dec x
        bpl _EDEE
        lda #$0001
        jsl rlUnitWindowCopySpritePalette1
        lda #$0002
        jsl rlUnitWindowCopySpritePalette2
        lda wCurrentChapter,b
        cmp #$0006
        bcs _EE14
        lda #$0018
        bra _EE17


        _EE14
        lda #$0028

        _EE17
        jsl rlLoadKeeperPortraitData
        jsl rlCastleFillVRAM2000
        sep #$20
        lda #$20
        sta bBufferCOLDATA_1
        lda #$40
        sta bBufferCOLDATA_2
        lda #$80
        sta bBufferCOLDATA_3
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
        jsl rlBuildItemListInState
        jsr rsUnknown8AA142
        lda #(`aCastleMenuTilemapData)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aCastleMenuTilemapData
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$2000
        sta aCurrentTilemapInfo,b
        jsr rsClearCastleList
        lda #CASTLE_STEP_CLASS_CHANGE
        sta wGameStateStep,b
        rep #$20
        jsl rlEnableVBlank
        sep #$20
        lda #$00
        sta bBufferINIDISP
        rep #$20
        rtl

        .databank 0

        ; 8A/EE7F


      aUnknown8AEE7F ; 8A/EE7F

        .word 0

      aUnknown8AEE81 ; 8A/EE81

        .word $001A, $0017, $001C, $001A

    .endsection Unsorted8AECEFSection


    .section Unsorted8AEEB1Section

      .al
      .xl

      rlClassChangeScreenStep ; 8A/EEB1

        .al
        .xl
        .autsiz
        .databank ?

        ; Runs class change sub-state wMenuState (aClassChangeStepHandlers), then the list sprites and the keeper's portrait.

        phb
        php
        phk
        plb
        .databank $8A
        lda wCastleRedrawIcons
        bne _EECA
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0700, $80, $7000

        bra _EED4


        _EECA
        lda #$0000
        sta wCastleRedrawIcons
        jsr rsUnknown8AA142

        _EED4
        lda wMenuState,b
        asl a
        tax
        jsr (aClassChangeStepHandlers,x)
        jsr rsPushCastleListSprites
        lda #$0008
        sta wR0
        lda #$0008
        sta wR1
        ldx #$0000
        jsr rsPushKeeperPortraitSprites
        plp
        plb
        .databank $8A
        rtl

        .databank 0

        ; 8A/EEF2

    .endsection Unsorted8AEEB1Section


    .section Table8AEEF2Section

      .al
      .xl

      aClassChangeStepHandlers ; 8A/EEF2

        ; Jump table of rlClassChangeScreenStep.
        .word <>rsClassChangeGreet
        .word <>rsClassChangeWaitForText
        .word <>rsClassChangeCheck
        .word <>rsClassChangeConfirm
        .word <>rsClassChangeFadeOutAndPromote
        .word <>rsClassChangeLeave

    .endsection Table8AEEF2Section


    .section Unsorted8AEEFESection

      .al
      .xl

      rsClassChangeGreet ; 8A/EEFE

        .al
        .xl
        .autsiz
        .databank ?

        lda #$000C
        tax
        lda aShopDialoguePointers+1,x
        sta lR18+1
        lda aShopDialoguePointers,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsSetupKeeperDialogueBox
        lda #$0001
        sta wMenuState,b
        lda #$0002
        sta wNextMenuState,b
        sep #$20
        lda #$0F
        sta bBufferINIDISP
        rep #$20
        rts

        .databank 0

        ; 8A/EF30

      rsClassChangeWaitForText ; 8A/EF30

        .al
        .xl
        .autsiz
        .databank ?

        lda aDialogue.wStatus,b
        beq _EF44
        lda #$00E8
        sta wR0
        lda #$0036
        sta wR1
        jsl rlDisplayDialogueAPressArrows
        rts


        _EF44
        lda wNextMenuState,b
        sta wMenuState,b
        rts

        .databank 0

        ; 8A/EF4B

      rsClassChangeCheck ; 8A/EF4B

        .al
        .xl
        .autsiz
        .databank ?

        ; Sub-state $02: no promoted class gives "you cannot class change"; a promoted class but no option at $7E2000 gives "you need level 20"; otherwise offers the class at $7E2002. Generation 2 (chapter 6 on) has its own lines.

        lda #(`aCastleMenuTilemapData)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aCastleMenuTilemapData
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda #$000C
        tax
        jsl rlGetPromotedClassIfAvailable
        bcc _EF6B
        jml _F00D


        _EF6B
        lda $7E2000
        beq _EFD5
        lda $7E2002
        and #$00FF
        clc
        adc #$0001
        sta aDialogue.wClassID,b
        lda wCurrentChapter,b
        cmp #$0006
        bcs _EFB1
        lda #$000C
        tax
        lda aShopDialoguePointers+223,x
        sta lR18+1
        lda aShopDialoguePointers+222,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsSetupKeeperDialogueBox
        lda #$0001
        sta wMenuState,b
        lda #$0003
        sta wNextMenuState,b
        rts


        _EFB1
        lda #(`dialogueShopUnknown8AD7A4)<<8
        sta lR18+1
        lda #<>dialogueShopUnknown8AD7A4
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsSetupKeeperDialogueBox
        lda #$0001
        sta wMenuState,b
        lda #$0003
        sta wNextMenuState,b
        rts


        _EFD5
        lda wCurrentChapter,b
        cmp #$0006
        bcs _EFE9
        lda #(`dialogueShopUnknown8AD756)<<8
        sta lR18+1
        lda #<>dialogueShopUnknown8AD756
        sta lR18
        bra _EFF3


        _EFE9
        lda #(`dialogueShopUnknown8AD7D0)<<8
        sta lR18+1
        lda #<>dialogueShopUnknown8AD7D0
        sta lR18

        _EFF3
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsSetupKeeperDialogueBox
        lda #$0001
        sta wMenuState,b
        lda #$0005
        sta wNextMenuState,b
        rts


        _F00D
        lda wCurrentChapter,b
        cmp #$0006
        bcs _F021
        lda #(`dialogueShopUnknown8AD785)<<8
        sta lR18+1
        lda #<>dialogueShopUnknown8AD785
        sta lR18
        bra _F02B


        _F021
        lda #(`dialogueShopUnknown8AD7FC)<<8
        sta lR18+1
        lda #<>dialogueShopUnknown8AD7FC
        sta lR18

        _F02B
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsSetupKeeperDialogueBox
        lda #$0001
        sta wMenuState,b
        lda #$0005
        sta wNextMenuState,b
        rts

        .databank 0

        ; 8A/F045

    .endsection Unsorted8AEEFESection


    .section Unsorted8AF048Section

      .al
      .xl

      rsClassChangeConfirm ; 8A/F048

        .al
        .xl
        .autsiz
        .databank ?

        lda #$2000
        sta aCurrentTilemapInfo,b
        jsr rsDrawYesNo
        jsr rsCastleYesNoInput
        lda #$0000
        jsl rlPushCastleHandCursor
        lda wJoy1New
        cmp #$8000
        beq _F083
        cmp #$0080
        bne _F074
        lda wCastleConfirmCursorIndex,b
        cmp #$0000
        beq _F075
        cmp #$0001
        beq _F083

        _F074
        rts


        _F075
        lda #$000A
        jsl rlPlaySoundEffect
        lda #$0004
        sta wMenuState,b
        rts


        _F083
        lda #$0021
        jsl rlPlaySoundEffect
        lda #$000C
        tax
        lda aShopDialoguePointers+55,x
        sta lR18+1
        lda aShopDialoguePointers+54,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsSetupKeeperDialogueBox
        lda #$0001
        sta wMenuState,b
        lda #$0005
        sta wNextMenuState,b
        rts

        .databank 0

        ; 8A/F0B4

    .endsection Unsorted8AF048Section


    .section Unsorted8AF0B4Section

      .al
      .xl

      rsClassChangeFadeOutAndPromote ; 8A/F0B4

        .al
        .xl
        .autsiz
        .databank ?

        ; Sub-state $04: fades out, then changes the class (rlStartCastleClassChange).

        lda wVBlankEnabledFramecount
        and #$0001
        bne _F0C5
        sep #$20
        lda bBufferINIDISP
        and #$0F
        beq _F0C8
        dec bBufferINIDISP

        _F0C5
        rep #$20
        rts


        _F0C8
        .as
        rep #$20
        lda wCastleListSelectedIndex,b
        tax
        lda $7E2002,x
        jsl rlStartCastleClassChange
        rts

        .databank 0

        ; 8A/F0D7

    .endsection Unsorted8AF0B4Section


    .section Unsorted8AF0D7Section

      .al
      .xl

      rsClassChangeLeave ; 8A/F0D7

        .al
        .xl
        .autsiz
        .databank ?

        ; Sub-state $05: returns to the courtyard (step $11) with the cursor on the class change command.

        lda #CASTLE_CURSOR_GRID
        sta wCastleCursorState,b
        lda #CASTLE_COMMAND_CLASS_CHANGE
        sta wCastleUnitCommand,b
        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        lda #CASTLE_STEP_RETURN_TO_COURTYARD
        sta wGameStateStep,b
        rts

        .databank 0

        ; 8A/F0F2

    .endsection Unsorted8AF0D7Section
