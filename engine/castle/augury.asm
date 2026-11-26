; The augury (steps $05/$06): the fortune teller answers about love (from love
; points with the unit's lover or top candidate), the unit's win/loss record, and,
; for children, their parents. Banks $87 and $8A.


    .section Unsorted87AE88Section

      .al
      .xl

      rlGetUnitLoverOrTopCandidate ; 87/AE88

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Returns the generation ID of the unit's lover; without one, of the unpaired unit of the other sex with the most love points (0 if none).

        phb
        php
        phk
        plb
        .databank $87
        phx
        phy
        ldx wSelectedUnitDataRAMPointer,b
        phx
        ldx wR0
        phx
        ldx wR1
        phx
        ldx wR2
        phx
        sta wR2
        jsl rlGetSelectedUnitLoverGenerationID
        ora #$0000
        beq _AEAA
        jml _AF34


        _AEAA
        lda #$0001
        sta wR0
        stz wR1
        jsl rlGetSelectedUnitGenerationID
        bcs _AF32
        cmp #$0010
        bcs _AEFB
        tay
        ldx #$0001

        _AEC0
        stx wRoutineVariable1,b
        lda #$0000
        jsl rlGetUnitRAMDataPointerByFactionSlotEntryID
        lda wSelectedUnitDataRAMPointer,b
        beq _AEF9
        jsl rlGetSelectedUnitGenerationID
        bcs _AEF6
        cmp #$0010
        bcc _AEF6
        sta wRoutineVariable1,b
        jsl rlGetSelectedUnitLoverGenerationID
        ora #$0000
        bne _AEF6
        tya
        jsl rlGetLoverPointsWithTarget
        cmp wR0
        bmi _AEF6
        sta wR0
        lda wRoutineVariable1,b
        sta wR1

        _AEF6
        inc x
        bra _AEC0


        _AEF9
        bra _AF32


        _AEFB
        jsl rlGetSelectedUnitLoverData
        cpx #$0000
        beq _AF32
        ldy #$0001

        _AF07
        sty wRoutineVariable1,b
        lda #$0000
        jsl rlFindGenerationIDInFactionSlotData
        lda wSelectedUnitDataRAMPointer,b
        beq _AF2A
        jsl rlGetSelectedUnitLoverGenerationID
        ora #$0000
        bne _AF2A
        lda $0000,b,x
        cmp wR0
        bmi _AF2A
        sta wR0
        sty wR1

        _AF2A
        inc x
        inc x
        inc y
        cpy #$0010
        bne _AF07

        _AF32
        lda wR1

        _AF34
        plx
        stx wR2
        plx
        stx wR1
        plx
        stx wR0
        plx
        stx wSelectedUnitDataRAMPointer,b
        ply
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 87/AF46

    .endsection Unsorted87AE88Section


    .section Unsorted8AAD6FSection

      .al
      .xl

      rsDrawAuguryTopics ; 8A/AD6F

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$2000
        sta aCurrentTilemapInfo,b
        lda $7F8183
        and #$00FF
        tax

        _AD7D
        lda $7F8184,x
        and #$00FF
        asl a
        phx
        tax
        jsr (aAuguryTopicTextHandlers,x)
        plx
        lda #$2000
        sta aCurrentTilemapInfo,b
        phx
        txa
        asl a
        tay
        lda <>aCastleListRowYPositions,b,y
        xba
        clc
        adc #$0003
        tax
        jsl rlDrawMenuTextLine
        plx
        dec x
        bpl _AD7D
        rts

        .databank 0

        ; 8A/ADA7

    .endsection Unsorted8AAD6FSection


    .section Table8AADA7Section

      .al
      .xl

      aAuguryTopicTextHandlers ; 8A/ADA7

        ; Jump table of rsDrawAuguryTopics.
        .word <>rsGetAuguryTopicLoveText
        .word <>rsGetAuguryTopicRecordText
        .word <>rsGetAuguryTopicParentsText

    .endsection Table8AADA7Section


    .section Unsorted8AADADSection

      .al
      .xl

      rsGetAuguryTopicLoveText ; 8A/ADAD

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aAuguryTopicLoveText)<<8
        sta lR18+1
        lda #<>aAuguryTopicLoveText
        sta lR18
        rts

        .databank 0

        ; 8A/ADB8

      rsGetAuguryTopicRecordText ; 8A/ADB8

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aAuguryTopicRecordText)<<8
        sta lR18+1
        lda #<>aAuguryTopicRecordText
        sta lR18
        rts

        .databank 0

        ; 8A/ADC3

    .endsection Unsorted8AADADSection


    .section Unsorted8AADC3Section

      .al
      .xl

      rsGetAuguryTopicParentsText ; 8A/ADC3

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aAuguryTopicParentsText)<<8
        sta lR18+1
        lda #<>aAuguryTopicParentsText
        sta lR18
        rts

        .databank 0

        ; 8A/ADCE

    .endsection Unsorted8AADC3Section


    .section Table8AADCESection

      .al
      .xl

      aAuguryTopicLoveText ; 8A/ADCE

        .enc "SJIS"
        .text "こいのゆくえ"
        .word $0000
        .enc "none"

      aAuguryTopicRecordText ; 8A/ADDC

        .enc "SJIS"
        .text "しょうはい"
        .word $0000
        .enc "none"

      aAuguryTopicParentsText ; 8A/ADE8

        .enc "SJIS"
        .text "おやのこと"
        .word $0000
        .enc "none"


    .endsection Table8AADCESection


    .section AuguryScreenSetupSection

      .al
      .xl

      rlAuguryScreenSetup ; 8A/F894

        .al
        .xl
        .autsiz
        .databank ?

        ; Blanks the screen and loads the augury; the topics are love and record, and also parents for a child (UnitTypeDynamic); moves to step $06.

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
        lda #(`aDecompressionDMAEntry8AFA14)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry8AFA14
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        lda #(`aDecompressionDMAEntry8AFA1C)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry8AFA1C
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        jsl rlDMAByStruct

          .structDMAToVRAM g4bppCursorSprites, $0400, $80, $C000

        lda #(`aDecompressionDMAEntry8AFA24)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry8AFA24
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        lda #(`aDecompressionDMAEntry8AFA2C)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry8AFA2C
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        jsl rlDMAByStruct

          .structDMAToVRAM g2bppItemStatLabels, $0800, $80, $9800

        lda #(`aDecompressionDMAEntry8AFA0C)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry8AFA0C
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        jsl rlGetDialogueBoxGraphicsAndPalette
        ldx #$0800
        lda #$00FF

        _F943
        sta aBG3TilemapBuffer,x
        dec x
        dec x
        bne _F943
        ldx #$01FE

        _F94E
        lda aCastleAuguryBGPalettes,x
        sta aBGPaletteBuffer,b,x
        dec x
        dec x
        bpl _F94E
        lda #$00B3
        jsl rlLoadKeeperPortraitData
        jsl rlCastleFillVRAM2000
        sep #$20
        lda #$17
        sta bBufferTM
        lda #$00
        sta bBufferTS
        lda #$00
        sta bBufferCGWSEL
        lda #$00
        sta bBufferCGADSUB
        lda #$20
        sta bBufferCOLDATA_1
        lda #$40
        sta bBufferCOLDATA_2
        lda #$80
        sta bBufferCOLDATA_3
        rep #$20
        stz wMenuState,b
        stz wCastleMenuOptionIndex,b
        stz wCastleConfirmCursorIndex,b
        stz wCastleListWindowRow,b
        stz wCastleListSelectedIndex,b
        lda #(`aCastleMenuTilemapData)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aCastleMenuTilemapData
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$2C00
        sta aCurrentTilemapInfo,b
        jsr rsClearCastleList
        jsl rlGetUnitType
        cmp #$0001
        bne _F9BB
        sep #$20
        lda #$02
        sta $7F8183
        bra _F9C3


        _F9BB
        .al
        sep #$20
        lda #$01
        sta $7F8183

        _F9C3
        lda #$00
        sta $7F8184
        lda #$01
        sta $7F8185
        lda #$02
        sta $7F8186
        rep #$20
        lda $7F8183
        and #$00FF
        sta wAuguryLastTopic
        jsr rsDrawAuguryTopics
        jsr rsDrawCastleUnitMoney
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0700, $80, $7000

        lda #CASTLE_STEP_AUGURY
        sta wGameStateStep,b
        rep #$20
        jsl rlEnableVBlank
        sep #$20
        lda #$00
        sta bBufferINIDISP
        rep #$20
        rtl

        .databank 0

        ; 8A/FA0A

        ; Unused: 2 zero bytes.
        .fill 2, $00

    .endsection AuguryScreenSetupSection


    .section Unsorted8AFA34Section

      .al
      .xl

      rlAuguryScreenStep ; 8A/FA34

        .al
        .xl
        .autsiz
        .databank ?

        ; Runs augury sub-state wMenuState (aAuguryStepHandlers) and draws the keeper's portrait.

        phb
        php
        phk
        plb
        .databank $8A
        lda wCastleRedrawIcons
        bne _FA4D
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0700, $80, $7000

        bra _FA54


        _FA4D
        lda #$0000
        sta wCastleRedrawIcons

        _FA54
        lda wMenuState,b
        asl a
        tax
        jsr (aAuguryStepHandlers,x)
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

        ; 8A/FA6F

    .endsection Unsorted8AFA34Section


    .section Table8AFA6FSection

      .al
      .xl

      aAuguryStepHandlers ; 8A/FA6F

        ; Jump table of rlAuguryScreenStep.
        .word <>rsAuguryGreet
        .word <>rsAuguryWaitForText
        .word <>rsAuguryOpenTopics
        .word <>rsAuguryRedrawTopics
        .word <>rsAuguryTopicMenu
        .word <>rsAuguryAnswer
        .word <>rsAuguryAskAgain
        .word <>rsAuguryLeave

    .endsection Table8AFA6FSection


    .section Unsorted8AFA7FSection

      .al
      .xl

      rsAuguryGreet ; 8A/FA7F

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`dialogueShopAuguryGreeting)<<8
        sta lR18+1
        lda #<>dialogueShopAuguryGreeting
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

        ; 8A/FAAB

      rsAuguryWaitForText ; 8A/FAAB

        .al
        .xl
        .autsiz
        .databank ?

        lda aDialogue.wStatus,b
        beq _FABF
        lda #$00E8
        sta wR0
        lda #$0036
        sta wR1
        jsl rlDisplayDialogueAPressArrows
        rts


        _FABF
        lda wNextMenuState,b
        sta wMenuState,b
        rts

        .databank 0

        ; 8A/FAC6

      rsAuguryOpenTopics ; 8A/FAC6

        .al
        .xl
        .autsiz
        .databank ?

        ; Sub-state $02.

        lda #(`aCastleMenuTilemapData)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aCastleMenuTilemapData
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$2C00
        sta aCurrentTilemapInfo,b
        lda #$0003
        sta wMenuState,b
        lda #$000A
        jsl rlPlaySoundEffect
        rts

        .databank 0

        ; 8A/FAE6

      rsAuguryRedrawTopics ; 8A/FAE6

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsDrawAuguryTopics
        lda #$0004
        sta wMenuState,b
        rts

        .databank 0

        ; 8A/FAF0

      rsAuguryTopicMenu ; 8A/FAF0

        .al
        .xl
        .autsiz
        .databank ?

        ; Sub-state $04: A answers the topic under the cursor; B says goodbye.

        lda wCastleListWindowRow,b
        tax
        lda #$0004
        sta wR0
        lda aCastleListRowY,x
        and #$00FF
        clc
        adc #$0004
        sta wR1
        lda #$0000
        jsl rlPushCastleHandCursor
        jsr rsAuguryTopicInput
        lda wJoy1New
        cmp #$0080
        beq _FB1D
        cmp #$8000
        beq _FB32
        rts


        _FB1D
        lda #$FFFF
        sta wCastleRedrawIcons
        lda #$000A
        jsl rlPlaySoundEffect
        lda #$0005
        sta wMenuState,b
        rts


        _FB32
        lda #$0021
        jsl rlPlaySoundEffect
        lda #(`dialogueShopAuguryFarewell)<<8
        sta lR18+1
        lda #<>dialogueShopAuguryFarewell
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsSetupKeeperDialogueBox
        lda #$0001
        sta wMenuState,b
        lda #$0007
        sta wNextMenuState,b
        rts

        .databank 0

        ; 8A/FB5D

      rsAuguryAnswer ; 8A/FB5D

        .al
        .xl
        .autsiz
        .databank ?

        ; Sub-state $05. Record: wins and losses. Parents: father and mother. Love: from the points with the unit's lover or top candidate, exactly 500 is "bound to", 400+ "loves", 300+ "likes", 200+ "interested in", less is "not interested in anyone".

        lda #$2C00
        sta aCurrentTilemapInfo,b
        lda wCastleListWindowRow,b
        tax
        lda #$0004
        sta wR0
        lda aCastleListRowY,x
        and #$00FF
        sta wR1
        lda #$0001
        jsl rlPushCastleHandCursor
        lda #$FFFF
        sta wCastleRedrawIcons
        lda wCastleListSelectedIndex,b
        tax
        lda $7F8184,x
        and #$00FF
        asl a
        tax
        ldx #$0000
        jsl rlDialogueClearDialogueWrapper
        lda wCastleListSelectedIndex,b
        tax
        lda $7F8184,x
        and #$00FF
        cmp #$0001
        beq _FBAE
        cmp #$0002
        beq _FBC8
        bra _FC09


        _FBAE
        jsl rlGetUnitWinCount
        sta aDialogue.wNumber1,b
        jsl rlGetUnitLossCount
        sta aDialogue.wNumber2,b
        lda #(`dialogueShopAuguryRecord)<<8
        sta lR18+1
        lda #<>dialogueShopAuguryRecord
        sta lR18
        bra _FBE2


        _FBC8
        jsl rlGetSelectedUnitFatherID
        sta aDialogue.wUnit1,b
        jsl rlGetSelectedUnitMotherID
        sta aDialogue.wUnit2,b
        lda #(`dialogueShopAuguryParents)<<8
        sta lR18+1
        lda #<>dialogueShopAuguryParents
        sta lR18
        bra _FBE2


        _FBE2
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsl rlSetupKeeperDialogueBox
        lda #$0001
        sta wMenuState,b
        lda #$0006
        sta wNextMenuState,b
        rts


        _FBFD
        lda #(`dialogueShopAuguryLoveNone)<<8
        sta lR18+1
        lda #<>dialogueShopAuguryLoveNone
        sta lR18
        bra _FBE2


        _FC09
        jsr rsAuguryGetLovePoints
        cmp #$01F4
        beq _FC46
        cmp #$0190
        bcs _FC3A
        cmp #$012C
        bcs _FC2E
        cmp #$00C8
        bcs _FC22
        bra _FBFD


        _FC22
        lda #(`dialogueShopAuguryLoveInterested)<<8
        sta lR18+1
        lda #<>dialogueShopAuguryLoveInterested
        sta lR18
        bra _FBE2


        _FC2E
        lda #(`dialogueShopAuguryLoveLikes)<<8
        sta lR18+1
        lda #<>dialogueShopAuguryLoveLikes
        sta lR18
        bra _FBE2


        _FC3A
        lda #(`dialogueShopAuguryLoveInLove)<<8
        sta lR18+1
        lda #<>dialogueShopAuguryLoveInLove
        sta lR18
        bra _FBE2


        _FC46
        lda #(`dialogueShopAuguryLoveLovers)<<8
        sta lR18+1
        lda #<>dialogueShopAuguryLoveLovers
        sta lR18
        bra _FBE2

        .databank 0

        ; 8A/FC52

    .endsection Unsorted8AFA7FSection


    .section Unsorted8AFC78Section

      .al
      .xl

      rsAuguryGetLovePoints ; 8A/FC78

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Returns the love points between the unit and its lover or top candidate (rlGetUnitLoverOrTopCandidate); 0 if there is none. The points are read from the woman's side (generation ID $10 and up).

        lda wSelectedUnitDataRAMPointer,b
        pha
        lda wEnteredCastleLocationID,b
        jsl rlGetUnitLoverOrTopCandidate
        sta wTempVariable1,b
        lda wTempVariable1,b
        ora #$0000
        beq _FCCD
        jsl rlFindCharacterByGenerationID
        jsl rlGetSelectedUnitCharacterID
        sta aDialogue.wUnit1,b
        pla
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitGenerationID
        cmp #$0010
        bcs _FCC5
        sta wTempVariable2,b
        lda wSelectedUnitDataRAMPointer,b
        pha
        lda wTempVariable1,b
        jsl rlFindCharacterByGenerationID
        lda wTempVariable2,b
        jsl rlGetLoverPointsWithTarget
        sta wR0
        pla
        sta wSelectedUnitDataRAMPointer,b
        lda wR0
        bra _FCCC


        _FCC5
        lda wTempVariable1,b
        jsl rlGetLoverPointsWithTarget

        _FCCC
        rts


        _FCCD
        pla
        sta wSelectedUnitDataRAMPointer,b
        lda #$0000
        rts

        .databank 0

        ; 8A/FCD5

    .endsection Unsorted8AFC78Section


    .section Unsorted8AFCD5Section

      .al
      .xl

      rsAuguryAskAgain ; 8A/FCD5

        .al
        .xl
        .autsiz
        .databank ?

        lda #$FFFF
        sta wCastleRedrawIcons
        lda #(`dialogueShopAuguryAnythingElse)<<8
        sta lR18+1
        lda #<>dialogueShopAuguryAnythingElse
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

        .databank 0

        ; 8A/FD00

      rsAuguryLeave ; 8A/FD00

        .al
        .xl
        .autsiz
        .databank ?

        ; Sub-state $07: blanks the screen and returns to the town (step $12).

        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        lda #CASTLE_STEP_REOPEN_TOWN_SAME_SONG
        sta wGameStateStep,b
        rts

        .databank 0

        ; 8A/FD0F

    .endsection Unsorted8AFCD5Section
