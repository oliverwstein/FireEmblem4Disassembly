; The event script interpreter (procs that run event scripts, the command table and
; command dispatch) and the event script commands themselves.
; It also holds the unnamed helpers that only event commands, and procs those
; commands create, use.

    .section Table809703Section

      .al
      .xl

      aSoundScriptCommands ; 80/9703

        ; Jump table of rsStepSoundScript.
        .word <>rsSoundScriptPlaySoundEffect
        .word <>rsSoundScriptPlaySoundEffect
        .word <>rsSoundScriptPlaySoundEffect2
        .word <>rsSoundScriptPlaySoundEffect2
        .word <>rsSoundScriptSendCommand
        .word <>rsSoundScriptQueueCommand
        .word <>rsSoundScriptUploadFD
        .word <>rsSoundScriptUploadFC
        .word <>rsSoundScriptUploadFB
        .word <>rsSoundScriptUploadFA
        .word <>rsSoundScriptDeferUploadFD
        .word <>rlSoundScriptDeferUploadFC
        .word <>rlSoundScriptDeferUploadFB
        .word <>rlSoundScriptDeferUploadFA
        .word <>rsSoundScriptWaitForAPUStatus
        .word <>rsSoundScriptWaitForDeferredUpload
        .word <>rsSoundScriptQueueCommandChecked
        .word <>rsSoundScriptBattleTerrainCommand

    .endsection Table809703Section


    .section Table86C69ASection

      .al
      .xl

      aUnknown86C69A ; 86/C69A

        ; Read by rsUnknown86C677.

        .word $0201, $0804, $2010, $8040

        ; 86/C6A2

    .endsection Table86C69ASection


    .section EventScriptEngineSection

      .al
      .xl

      rlEventEngineBeginScript ; 91/A40E

        .al
        .autsiz
        .databank ?

        php
        rep #$30
        inc wEventEngineState,b
        jsl rlZeroEventMenuWindowList
        jsr rsGetEventLength
        jsl rlEventEngineFreeAllProcs
        jsl rlUnknown91C611
        jsl rlActiveSpriteEngineClearAllSprites

        lda wGameStateRoutine1,b
        sta wUnknown001730,b

        stz wR26

        lda #0
        sta aMovingMapSprites.wState,b

        lda #8
        trb wEventEngineFlags,b

        plp
        jml rlRunEventCommand

        .databank 0

      rsEventEngineClearProcs ; 91/A440

        .al
        .autsiz
        .databank ?

        php
        phx
        ldx #size(wEventProcBanks)-2
        
          -
          lda #$FFFF
          sta wEventProcBanks,b,x
          stz wEventProcOffsets,b,x
          dec x
          dec x
          bpl -

        plx
        plp
        rts

        .databank 0

      rlEventEngineCreateProc ; 91/A455

        .al
        .autsiz
        .databank ?

        php
        lda lR44
        pha
        lda lR44+1
        pha

        jsl rlProcEngineCreateProc
        tax

        pla
        sta lR44+1
        pla
        sta lR44

        lda lR44+1
        and #$FF00
        xba
        sta wEventProcBanks,b,x
        lda lR44
        sta wEventProcOffsets,b,x

        lda #$0004
        tsb wEventEngineFlags,b

        plp
        rtl

        .databank 0

      rlEventEngineFreeProc ; 91/A47D

        .al
        .autsiz
        .databank ?

        php
        ldx aProcSystem.wOffset,b
        jsl rlProcEngineFreeProc
        plp
        rtl

        .databank 0

      rlEventEngineFreeAllProcs ; 91/A487

        .al
        .autsiz
        .databank ?

        php

        rep #$30
        ldx #size(wEventProcOffsets)-2

          -
          lda wEventProcBanks,b,x
          cmp #$FFFF
          beq +

            phx
            txa
            lsr a
            jsl rlProcEngineFreeProcByIndex
            plx

            lda #$FFFF
            sta wEventProcBanks,b,x
            stz wEventProcOffsets,b,x

          +
          dec x
          dec x
          bpl -

        plp
        rtl

        .databank 0

      rlUnknown91A4AC ; 91/A4AC

        .al
        .autsiz
        .databank ?

        php
        rep #$30
        lda wEventProcBanks,b,x
        bit #$0200
        beq +

        bit #$0400
        beq ++

        plp
        sec
        rtl

        +
        ora #$0200
        sta wEventProcBanks,b,x

        +
        plp
        clc
        rtl

        .databank 0

      rsUnknown91A4C8 ; 91/A4C8

        .al
        .autsiz
        .databank ?

        lda #$0002
        tsb wEventEngineFlags,b

        ldx #(16 - 1) *2
        
        _Loop
        lda wEventProcBanks,b,x
        cmp #$FFFF
        beq _Next

        lda wEventProcBanks,b,x
        bit #$0200
        bne _Next

        lda wEventProcOffsets,b,x
        cmp aProcSystem.aHeaderTypeOffset,b,x
        bne +

        lda wEventProcBanks,b,x
        and #$00FF
        cmp aProcSystem.aHeaderTypeBank,b,x
        beq ++

        +
        lda #$FFFF
        sta wEventProcBanks,b,x
        stz wEventProcOffsets,b,x

        _Next
        dec x
        dec x
        bpl _Loop

        rts

        +
        lda #$0002
        trb wEventEngineFlags,b
        bra _Next

        .databank 0

      aEventCommandPointers ; 91/A50A

        .word <>rsEventCommand00
        .word <>rsEventCommand01
        .word <>rsEventCommandJump
        .word <>rsEventCommandJumpTrue
        .word <>rsEventCommandJumpFalse
        .word <>rsEventCommandJumpRelativeTrue
        .word <>rsEventCommandJumpRelativeFalse
        .word <>rsEventCommandTestPermanentFlagSet
        .word <>rsEventCommandTestFlagInChapterSet
        .word <>rsEventCommandChangePaletteProc
        .word <>rsEventCommand0A
        .word <>rsEventCommand0B
        .word <>rsEventCommandDialogue
        .word <>rsEventCommandCastleName
        .word <>rsEventCommandPlaySong
        .word <>rsEventCommand0F
        .word <>rsEventCommand10
        .word <>rsEventCommandPlaySFXByte
        .word <>rsEventCommandPlaySFXWord
        .word <>rsEventCommandRestorePhaseMusic
        .word <>rsEventCommandDialogueWithBG
        .word <>rsEventCommand15
        .word <>rsEventCommandLoverHomeCastle
        .word <>rsEventCommandBerserkCast
        .word $0000               ; $18
        .word <>rsEventCommand19
        .word <>rsEventCommand1A
        .word <>rsEventCommand1B
        .word <>rsEventCommandChangeDialogue
        .word <>rsEventCommand1D
        .word $0000               ; $1E
        .word <>rsEventCommandCreateHDMA
        .word <>rsEventCommand20
        .word <>rsEventCommandCreateSprite
        .word <>rsEventCommandMoveTemporaryToCoords
        .word <>rsEventCommandLoadUnitByGroup
        .word <>rsEventCommandLoadUnitDirect
        .word <>rsEventCommandMoveTemporaryToCoordsFollow
        .word <>rsEventCommandMoveTemporaryToCoordsClass
        .word <>rsEventCommandMoveTemporaryByScript
        .word <>rsEventCommandLoadUnitByGroupSilent
        .word <>rsEventCommandWaitUnitSpriteDecompressed
        .word <>rsEventCommandWaitUntilMapSpritesHalting
        .word <>rsEventCommandContinueFormMapSpriteHalt
        .word <>rsEventCommand2C
        .word <>rsEventCommandChangePalette
        .word <>rsEventCommandPaletteSwap
        .word <>rsEventCommandStoreWord
        .word <>rsEventCommand30
        .word <>rsEventCommand31
        .word <>rsEventCommand32
        .word <>rsEventCommandResetSpriteEngine
        .word <>rsEventCommandPause
        .word <>rsEventCommand35
        .word <>rsEventCommand36
        .word <>rsEventCommand37
        .word <>rsEventCommand38
        .word <>rsEventCommandSetCameraToEventUnitSlot1
        .word <>rsEventCommandSetCameraPosition
        .word <>rsEventCommand3B
        .word <>rsEventCommand3C
        .word <>rsEventCommand3D
        .word <>rsEventCommand3E
        .word <>rsEventCommandScriptedMapScroll
        .word <>rsEventCommandMapScroll
        .word <>rsEventCommandMapScrollToEventUnitSlot1
        .word <>rsEventCommandFillEventUnitSlot
        .word <>rsEventCommandFillEventUnitSlotByCoords
        .word <>rsEventCommandFactionUnitDeath
        .word <>rsEventCommandRunASM
        .word <>rsEventCommandFadeInByTimer
        .word <>rsEventCommandFadeOutByTimer
        .word <>rsEventCommand48
        .word <>rsEventCommand49
        .word <>rsEventCommandRunEventCondition
        .word <>rsEventCommandSetFlagIfInChapter
        .word <>rsEventCommandUnsetFlagIfInChapter
        .word <>rsEventCommandRunEventConditionUnskippable
        .word <>rsEventCommand4E
        .word <>rsEventCommandWMFadeIn
        .word <>rsEventCommandWMFadeOut
        .word <>rsEventCommandWMScroll
        .word <>rsEventCommandWMMarker
        .word <>rsEventCommandWMClearMarker
        .word <>rsEventCommandWMLoadPortrait
        .word <>rsEventCommandWMFadeInPortrait
        .word <>rsEventCommandWMFadeOutPortrait
        .word <>rsEventCommandWMMovePortrait
        .word <>rsEventCommandWMDialogue
        .word <>rsEventCommand59
        .word <>rsEventCommandWMClearDialogue
        .word <>rsEventCommandWMHighlight
        .word <>rsEventCommandWMClearHighlight
        .word <>rsEventCommandDemoAllowSkip
        .word <>rsEventCommandOpenMapBattle
        .word $0000               ; $5F

      rlRunEventCommand ; 91/A5CA

        .al
        .autsiz
        .databank `aEventCommandPointers

        phb
        php
        phk
        plb

        jsr rsUnknown91A629
        bcc _End

          lda lActiveEventPointer+1,b
          sta lR22+1
          lda lActiveEventPointer,b
          sta lR22

          ldy wActiveEventOffset,b
          bra _A5FC

            _Loop
            inc y
            sty wActiveEventOffset,b

            phy
            asl a
            tay

            lda aEventCommandPointers,y
            ply

            sta lR23
            pea #<>(+)-1
            jmp (lR23)

            +
            bcc _A5FC

              sty wActiveEventOffset,b
              bra _End

          _A5FC
          lda [lR22],y
          cmp #$FEFE
          bne +

            inc y
            inc y
            sty wActiveEventOffset,b
            lda [lR22],y

          +
          cmp #$FFFF
          bne +

            lda #2
            sta wEventEngineState,b
            bra _End

          +
          and #$00FF
          cmp #$00FD
          bne _Loop

          inc y
          sty wActiveEventOffset,b

        _End
        stz wUnknown000921,b

        plp
        plb
        rtl

        .databank 0

      rsUnknown91A629 ; 91/A629

        .al
        .autsiz
        .databank ?

        lda wEventEngineFlags,b
        bit #$0004
        beq _SEC

          jsr rsUnknown91A4C8

          lda #$0002
          bit wEventEngineFlags,b
          beq _CLC

            ora #$0004
            trb wEventEngineFlags,b

        _SEC
        sec
        bra +
        
        _CLC
        clc
        
        +
        rts

        .databank 0

      rsGetEventLength ; 91/A647

        .al
        .autsiz
        .databank ?

        php
        lda lActiveEventPointer,b
        sta lR22
        lda lActiveEventPointer+1,b
        sta lR22+1
        ldy #0

        -
        lda [lR22],y
        cmp #$FEFE
        beq ++

          cmp #$FFFF
          beq +

            inc y
            bra -

          +
          stz wActiveEventLength,b
          bra _End

        +
        inc y
        inc y
        sty wActiveEventLength,b

        _End
        plp
        rts

        .databank 0

    .endsection EventScriptEngineSection


    .section EventCommandSection

      .al
      .xl

      rsEventCommand00 ; 91/BDD2

        .al
        .autsiz
        .databank ?

        ; EVENT_00

        phy
        lda [lR22],y
        and #$00FF
        pha

        lda #(`procUnknown8292A9)<<8
        sta lR44+1
        lda #<>procUnknown8292A9
        sta lR44

        jsl rlEventEngineCreateProc

        pla
        sta wR0

        pla
        clc
        adc wR0
        tay
        sty wActiveEventOffset,b

        clc
        rts

        .databank 0

      rsEventCommandJump ; 91/BDF4

        .al
        .autsiz
        .databank ?

        ; JUMP

        lda [lR22],y
        sec
        sbc lR22
        tay
        sty wActiveEventOffset,b

        clc
        rts

        .databank 0

      rsEventCommandJumpTrue ; 91/BDFF

        .al
        .autsiz
        .databank ?

        ; JUMP_TRUE

        lda wEventEngineTruthFlag,b
        bne +

          inc y
          inc y
          bra ++

        +
        lda [lR22],y
        sec
        sbc lR22
        tay

        +
        sty wActiveEventOffset,b

        clc
        rts

        .databank 0

      rsEventCommandJumpFalse ; 91/BE13

        .al
        .autsiz
        .databank ?

        ; JUMP_FALSE

        lda wEventEngineTruthFlag,b
        beq +

          inc y
          inc y
          bra ++

        +
        lda [lR22],y
        sec
        sbc lR22
        tay

        +
        sty wActiveEventOffset,b

        clc
        rts

        .databank 0

      rsEventCommandJumpRelativeTrue ; 91/BE27

        .al
        .autsiz
        .databank ?

        ; JUMP_RELATIVE_TRUE

        lda wEventEngineTruthFlag,b
        bne +

          inc y
          inc y
          bra ++

        +
        lda [lR22],y
        clc
        adc wActiveEventOffset,b
        tay

        +
        sty wActiveEventOffset,b

        clc
        rts

        .databank 0

      rsEventCommandJumpRelativeFalse ; 91/BE3C

        .al
        .autsiz
        .databank ?

        ; JUMP_RELATIVE_FALSE

        lda wEventEngineTruthFlag,b
        beq +

          inc y
          inc y
          bra ++

        +
        lda [lR22],y
        clc
        adc wActiveEventOffset,b
        tay

        +
        sty wActiveEventOffset,b

        clc
        rts

        .databank 0

      rsEventCommandTestPermanentFlagSet ; 91/BE51

        .al
        .autsiz
        .databank ?

        ; TEST_PERMANENT_FLAG_SET

        phy
        lda [lR22],y
        and #$00FF
        jsl rlCheckPermanentEventFlagSet

        lda #0
        rol a
        sta wEventEngineTruthFlag,b

        ply
        inc y
        sty wActiveEventOffset,b

        clc
        rts

        .databank 0

      rsEventCommandTestFlagInChapterSet ; 91/BE69

        .al
        .autsiz
        .databank ?

        ; CHECK_FLAG_IN_CHAPTER_SET

        phy
        lda [lR22],y
        and #$00FF
        sta wR0

        inc y
        lda [lR22],y
        and #$00FF
        tax

        lda wR0
        jsl rlGetSpecifiedChaptersRAMPointer
        bcs +

          txa
          jsl rlCheckEventFlagSet

          lda #0
          rol a
          sta wEventEngineTruthFlag,b

        +
        ply
        inc y
        inc y
        sty wActiveEventOffset,b

        clc
        rts

        .databank 0

      rsEventCommandChangePaletteProc ; 91/BE94

        .al
        .autsiz
        .databank ?

        ; CHANGE_PALETTE_PROC

        phy

        lda #(`procUnknown8293AE)<<8
        sta lR44+1
        lda #<>procUnknown8293AE
        sta lR44
        jsl rlEventEngineCreateProc

        pla
        clc
        adc #6
        tay
        sty wActiveEventOffset,b

        clc
        rts

        .databank 0

      rsEventCommand0A ; 91/BEAE

        .al
        .autsiz
        .databank ?

        ; EVENT_0A

        phb
        php
        phk
        plb
        phx
        phy

        jsl rlInitMapMenus
        jsl rlEnableMapMenuUploads
        jsl rlResetDialogueEngine

        ply
        plx
        plp
        plb

        clc
        rts

        .databank 0

      aUnknown91BEC6 ; 91/BEC6

        .word $2000
        .word $4000
        .word $2B01
        .word $C00A
        .word $0B00
        .word $4880
        .word $7B01
        .word $C019

      rsEventCommand0B ; 91/BED6

        .al
        .autsiz
        .databank ?

        phy
        jsl rlDisableMapMenuUploads
        ply

        clc
        rts

        .databank 0

      rsEventCommandDialogue ; 91/BEDE

        .al
        .autsiz
        .databank ?

        ; DIALOGUE

        phy
        lda #0
        jsl rlDialogueUpdateSlotOffset

        lda #(`procDialogue)<<8
        sta lR44+1
        lda #<>procDialogue
        sta lR44
        jsl rlEventEngineCreateProc

        ply
        inc y
        inc y
        inc y
        sty wActiveEventOffset,b

        clc
        rts

        .databank 0

      rsEventCommandCastleName ; 91/BEFD

        .al
        .autsiz
        .databank ?

        ; CASTLE_NAME

        phy
        lda #(`procCastleNamePopUp)<<8
        sta lR44+1
        lda #<>procCastleNamePopUp
        sta lR44
        jsl rlEventEngineCreateProc

        ply
        inc y
        inc y
        inc y
        inc y
        inc y
        sty wActiveEventOffset,b

        clc
        rts

        .databank 0

      rsEventCommandPlaySong ; 91/BF17

        .al
        .autsiz
        .databank ?

        phy
        lda [lR22],y
        and #$00FF
        sta wMusicID,b

        lda #(`procUnknown828AF2)<<8
        sta lR44+1
        lda #<>procUnknown828AF2
        sta lR44
        jsl rlEventEngineCreateProc

        ply
        inc y
        sty wActiveEventOffset,b

        sec
        rts

        .databank 0

      rsEventCommand0F ; 91/BF35

        .al
        .autsiz
        .databank ?

        phy
        lda [lR22],y
        and #$00FF
        jsl rlPlaySoundEffect

        ply
        inc y
        sty wActiveEventOffset,b

        clc
        rts

        .databank 0

      rsEventCommand10 ; 91/BF46

        .al
        .autsiz
        .databank ?

        phy
        lda [lR22],y
        and #$00FF
        jsl rlPlaySoundEffect

        ply
        inc y
        sty wActiveEventOffset,b

        clc
        rts

        .databank 0

      rsEventCommandPlaySFXByte ; 91/BF57

        .al
        .autsiz
        .databank ?

        ; PLAY_SFX_BYTE

        phy
        lda [lR22],y
        and #$00FF
        jsl rlPlaySoundEffect2

        ply
        inc y
        sty wActiveEventOffset,b

        clc
        rts

        .databank 0

      rsEventCommandPlaySFXWord ; 91/BF68

        .al
        .autsiz
        .databank ?

        ; PLAY_SFX_WORD

        phy
        lda [lR22],y
        jsl rlSendSoundCommand

        ply
        inc y
        inc y
        sty wActiveEventOffset,b

        clc
        rts

        .databank 0

      rsEventCommandRestorePhaseMusic ; 91/BF77

        .al
        .autsiz
        .databank ?

        ; RESTORE_PHASE_MUSIC

        phy
        jsl rlResumePhaseMusic

        lda #(`procUnknown828AF2)<<8
        sta lR44+1
        lda #<>procUnknown828AF2
        sta lR44
        jsl rlEventEngineCreateProc

        ply
        sty wActiveEventOffset,b

        clc
        rts

        .databank 0

      rsEventCommandDialogueWithBG ; 91/BF90

        .al
        .autsiz
        .databank ?

        ; DIALOGUE_WITH_BG

        php
        phy

        lda #CONVERSATION_EXIT_COURTYARD
        sta wConversationExitMode,b

        lda #(`procDialogueWithBG)<<8
        sta lR44+1
        lda #<>procDialogueWithBG
        sta lR44
        jsl rlEventEngineCreateProc

        pla
        clc
        adc #6
        sta wActiveEventOffset,b

        tay
        plp

        clc
        rts

        .databank 0

      rsEventCommand15 ; 91/BFB2

        .al
        .autsiz
        .databank ?

        ; EVENT_15

        php
        phy

        lda #CONVERSATION_EXIT_TOWN
        sta wConversationExitMode,b

        lda #(`procDialogueWithBG)<<8
        sta lR44+1
        lda #<>procDialogueWithBG
        sta lR44
        jsl rlEventEngineCreateProc

        pla
        clc
        adc #6
        sta wActiveEventOffset,b

        tay
        plp

        clc
        rts

        .databank 0

      rsEventCommandLoverHomeCastle ; 91/BFD4

        .al
        .autsiz
        .databank ?

        php
        phy
        jsl rlTryStartLoverHomeCastleConversation

        lda #(`procUnknown828A88)<<8
        sta lR44+1
        lda #<>procUnknown828A88
        sta lR44
        jsl rlEventEngineCreateProc

        pla
        sta wActiveEventOffset,b

        tay
        plp

        clc
        rts

        .databank 0

      rsEventCommandBerserkCast ; 91/BFF0

        .al
        .autsiz
        .databank ?

        ; BERSERK_CAST

        php
        phy

        lda #(`procUnknown828B61)<<8
        sta lR44+1
        lda #<>procUnknown828B61
        sta lR44
        jsl rlEventEngineCreateProc

        pla
        clc
        adc #2
        sta wActiveEventOffset,b

        tay
        plp

        clc
        rts

        .databank 0

      rsEventCommand19 ; 91/C00C

        .al
        .autsiz
        .databank ?

        ; EVENT_19

        phy
        jsl rlSetupUpperDialogueBox
        ply

        phy
        lda [lR22],y
        sta lR18
        inc y
        lda [lR22],y
        sta lR18+1
        inc y
        inc y
        lda [lR22],y
        tax

        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        sta lR19

        ; Routine does nothing
        jsl rlUnknown9183A8

        pla
        clc
        adc #5
        tay
        sty wActiveEventOffset,b

        clc
        rts

        .databank 0

      rsEventCommand1A ; 91/C03A

        .al
        .autsiz
        .databank ?

        ; EVENT_1A

        phy
        jsl rlUnknown9183A9
        ply

        clc
        rts

        .databank 0

      rsEventCommand1B ; 91/C042

        .al
        .autsiz
        .databank ?

        ; EVENT_1B

        phy
        lda [lR22],y
        sta lR18
        inc y
        lda [lR22],y
        sta lR18+1

        jsl rlUnknown9183CC

        ply
        inc y
        inc y
        inc y
        sty wActiveEventOffset,b

        clc
        rts

        .databank 0

      rsEventCommandChangeDialogue ; 91/C059

        .al
        .autsiz
        .databank ?

        ; CHANGE_DIALOGUE

        phy
        lda [lR22],y
        sta lR18
        inc y
        lda [lR22],y
        sta lR18+1

        jsl rlUnknown9183D7

        ply
        inc y
        inc y
        inc y
        sty wActiveEventOffset,b

        clc
        rts

        .databank 0

      rsEventCommand1D ; 91/C070

        .al
        .autsiz
        .databank ?

        ; EVENT_1D

        jsl rlEnableActiveSpriteEngine
        jsl rlUnknown91C611

        clc
        rts

        .databank 0

      rsEventCommandCreateHDMA ; 91/C07A

        .al
        .autsiz
        .databank ?

        ; CREATE_HDMA

        phy
        lda [lR22],y
        sta lR44
        inc y
        lda [lR22],y
        sta lR44+1

        jsl rlHDMAEngineCreateEntry

        pla
        clc
        adc #3
        sta wActiveEventOffset,b
        tay

        clc
        rts

        .databank 0

      rsEventCommand20 ; 91/C093

        .al
        .autsiz
        .databank ?

        ; EVENT_20

        php
        phy
        jsl rlActiveSpriteEngineReset
        jsl rlEnableActiveSpriteEngine
        jsl rlActiveSpriteEngineRenderOnScreenOnly
        jsl rlActiveSpriteEngineSetFlag2000

        lda [lR22],y
        sta lR18
        inc y
        lda [lR22],y
        sta lR18+1
        inc y
        inc y

        lda [lR22],y
        sta wR1
        inc y
        inc y
        lda [lR22],y
        sta wR0

        jsl rlDMAByPointer

        pla
        clc
        adc #7
        sta wActiveEventOffset,b
        tay

        plp
        clc
        rts

        .databank 0

      rsEventCommandCreateSprite ; 91/C0CA

        .al
        .autsiz
        .databank ?

        ; CREATE_SPRITE

        php
        phy
        lda [lR22],y
        sta lR44
        inc y
        lda [lR22],y
        sta lR44+1

        inc y
        inc y
        lda [lR22],y
        tax

        inc y
        inc y
        lda [lR22],y
        tay

        jsl rlActiveSpriteEngineCreateSpriteHighestSlot

        pla
        clc
        adc #7
        sta wActiveEventOffset,b
        tay

        plp
        clc
        rts

        .databank 0

      rlUnknown91C0EF ; 91/C0EF

        .al
        .autsiz
        .databank ?

        php
        rep #$30
        plp
        rtl

        .databank 0

      rsUnknown91C0F4 ; 91/C0F4

        .al
        .autsiz
        .databank ?

        lda #1
        sta aMovingMapSprites.wUnknown0017C2,b
        jml +

      rsUnknown91C0FE ; 91/C0FE

        .al
        .autsiz
        .databank ?

        lda #0
        sta aMovingMapSprites.wUnknown0017C2,b

        +
        phx
        stx aMovingMapSprites.wOffset,b
        stz aMovingMapSprites.wUnknown0017C0,b

        ldy #0
        lda [lR18],y
        sta wR0
        inc y
        inc y
        lda [lR18],y
        and #$00FF
        sta wR2
        inc y
        lda [lR18],y
        and #$00FF
        sta wR3
        inc y
        lda [lR18],y
        and #$00FF
        sta wR4
        inc y
        lda [lR18],y
        and #$00FF
        sta wR5
        inc y
        lda [lR18],y
        and #$00FF
        sta wR1
        inc y
        lda [lR18],y
        and #$00FF
        sta wR6
        inc y
        phy

        lda wR1
        bit #$0020
        beq _SkipSlot1

        lda wEventUnitSlot1XCoordinate
        cmp #$FFFF
        beq _End

          sta wR2
          lda wEventUnitSlot1YCoordinate
          cmp #$FFFF
          beq _End

            sta wR3
            bra _Continue

              _SkipSlot1
              lda wR1
              bit #$0040
              beq _Continue

                lda wEventUnitSlot2XCoordinate
                cmp #$FFFF
                beq _End

                  sta wR4
                  lda wEventUnitSlot2YCoordinate
                  cmp #$FFFF
                  beq _End

                    sta wR5

            _Continue
            lda #0
            sta wR7
            jsl rlUnknown818FA1
            jsr rsUnknown91C38C

        _End
        ply
        plx
        clc
        rts

        .databank 0

      rsUnknown91C191 ; 91/C191

        .al
        .autsiz
        .databank ?

        ; LOAD_UNIT_BY_GROUP ?

        phx
        stx aMovingMapSprites.wOffset,b
        stz aMovingMapSprites.wUnknown0017C0,b
        lda #2
        sta aMovingMapSprites.wUnknown0017C2,b

        ldy #0
        lda [lR18],y
        and #$00FF
        sta wR0

        inc y
        lda [lR18],y
        sta wRoutineVariable1,b

        inc y
        inc y
        lda [lR18],y
        and #$00FF
        sta wR2

        inc y
        lda [lR18],y
        and #$00FF
        sta wR3

        inc y
        lda [lR18],y
        and #$00FF
        sta wR1

        inc y
        lda [lR18],y
        and #$00FF
        sta wR6

        inc y
        phy

        lda wR1
        pha
        lda wR2
        pha
        lda wR3
        pha
        lda wR0

        phx
        jsl rlLoadUNITAsHidden
        bcc +

          brk

        +
        plx
        sta aMovingMapSprites.wUnknown0017CC,b,x

        ; Grab the X coordinate
        lda wR1
        and #$00FF
        sta wR4

        ; and the Y coordinate
        lda wR1
        xba
        and #$00FF
        sta wR5

        phx
        ldx wR2
        lda aUnknown91C21D,x
        and #$00FF
        sta wR6
        plx

        pla
        sta wR3
        pla
        sta wR2
        pla
        sta wR1

        lda #1
        sta wR7
        jsl rlUnknown818FA1
        jsr rsUnknown91C38C

        ply
        plx
        clc
        rts

        .databank 0

      aUnknown91C21D ; 91/C21D

        ; Indexed with allegiance

        .byte $02
        .byte $04
        .byte $06
        .byte $08

      rsEventCommandLoadUnitByGroupSilent ; 91/C221

        .al
        .autsiz
        .databank ?

        ; LOAD_UNIT_BY_GROUP_SILENT

        lda [lR22],y
        and #$00FF
        sta wR0
        inc y
        lda [lR22],y
        sta wRoutineVariable1,b
        inc y
        inc y
        phy

        lda wR0
        jsl rlLoadUNITAsHidden
        bcc +

          brk

        +
        tax
        jsl rlDeployedUnitUnsetHiddenIfAlive

        ply
        rts

        .databank 0

      rsUnknown91C241 ; 91/C241

        .al
        .autsiz
        .databank ?

        ; LOAD_UNIT_DIRECT ?

        phx
        stx aMovingMapSprites.wOffset,b
        stz aMovingMapSprites.wUnknown0017C0,b

        lda #4
        sta aMovingMapSprites.wUnknown0017C2,b

        ldy #0
        lda [lR18],y
        sta wR0

        inc y
        inc y
        lda [lR18],y
        and #$00FF
        sta aMovingMapSprites.wUnknown001822,b
        sta wR7

        inc y
        lda [lR18],y
        and #$00FF
        sta wR2

        inc y
        lda [lR18],y
        and #$00FF
        sta wR3

        inc y
        lda [lR18],y
        and #$00FF
        sta wR4

        inc y
        lda [lR18],y
        and #$00FF
        sta wR5

        inc y
        lda [lR18],y
        and #$00FF
        sta wR1

        inc y
        lda [lR18],y
        and #$00FF
        sta wR6

        inc y
        lda [lR18],y
        and #$00FF
        sta aMovingMapSprites.wUnknown001824,b

        inc y
        phy

        lda wR0
        pha
        lda wR1
        pha
        lda wR2
        pha
        lda wR3
        pha
        lda wR4
        pha
        lda wR5
        pha
        lda wR6
        pha
        lda wR7
        pha
        phx

        lda #0
        sta wR7
        jsl rlUnknown818FA1

        plx

        phx
        lda wR4
        pha
        lda wR5
        pha

        jsr rsUnknown91C38C

        pla
        sta wR8
        pla
        sta wR9
        plx

        pla
        sta wR7
        pla
        sta wR6
        pla
        sta wR5
        pla
        sta wR4
        pla
        sta wR3
        pla
        sta wR2
        pla
        sta wR1
        pla
        sta wR0

        phx
        lda wR8
        xba
        ora wR9
        sta wRoutineVariable1,b

        lda wR0
        ldx wR7
        plx
        sta aMovingMapSprites.wUnknown0017CC,b,x

        ply
        plx

        clc
        rts

        .databank 0

      rsUnknown91C2FD ; 91/C2FD

        .al
        .autsiz
        .databank ?

        phx
        stx aMovingMapSprites.wOffset,b
        lda #8
        sta aMovingMapSprites.wUnknown0017C2,b
        ldy #0
        lda [lR18],y
        sta wR0

        inc y
        inc y
        lda [lR18],y
        and #$00FF
        sta wR2

        inc y
        lda [lR18],y
        and #$00FF
        sta wR3

        inc y
        lda [lR18],y
        and #$00FF
        sta wR4

        inc y
        lda [lR18],y
        and #$00FF
        sta wR5

        inc y
        lda [lR18],y
        and #$00FF
        sta wR1

        inc y
        lda [lR18],y
        and #$00FF
        sta wR6

        inc y
        lda [lR18],y
        and #$00FF
        sta wR7

        inc y
        lda [lR18],y
        sta wR8
        sta aMovingMapSprites.wUnknown0017C0,b
        inc y
        inc y
        phy

        lda wR6
        pha
        lda wR7
        pha
        lda wR8
        pha

        phx
        lda #1
        sta wR7
        jsl rlUnknown818FA1
        plx

        phx
        jsr rsUnknown91C38C
        plx

        pla
        sta wR8
        pla
        sta wR7
        pla
        sta wR6

        lda wR7
        sta aMovingMapSprites.wUnknown0017CC,b,x
        lda wR8
        sta aMovingMapSprites.wUnknown001814,b,x
        ply
        plx
        clc
        rts

        .databank 0

      rsUnknown91C382 ; 91/C382

        .al
        .autsiz
        .databank ?

        lda #0
        sta aMovingMapSprites.wUnknown0017C2
        stz aMovingMapSprites.wUnknown0017C0,b

      rsUnknown91C38C ; 91/C38C

        .al
        .autsiz
        .databank ?

        ; X = mover ID

        phx
        stx aMovingMapSprites.wOffset,b
        phx
        ldy #aMovingMapSpriteData[0].wCharacterID - aMovingMapSpriteData[0]

        lda aMovingMapSprites.wUnknown0017C0,b
        bne _C3CA

          ; Check if the character is already in RAM
          lda [lR18],y
          pha
          jsl rlGetUnitRAMDataPointerByID
          pla
          bcc +

            ; Is a new unit
            jsl rlGetCharacterMapSprite
            bra _C3CA

          +
          ldy #aMovingMapSpriteData[0].bFlags - aMovingMapSpriteData[0]
          lda [lR18],y
          bit #$0080
          beq +

            jsl rlGetSelectedUnitStates
            bit #UnitStateDead
            beq +

              tya
              clc
              adc #9
              tay
              plx
              brl _End

          +
          jsl rlGetSelectedUnitMapSprite

        _C3CA
        plx
        sta aMovingMapSpritesMapSprites,b,x

        phx
        phy
        phb
        jsl rsMovingMapSpriteAppendDecomp
        plb
        ply
        plx

        ; Sound
        jsr rsUnknown91C447
        jsl rlUnknown91C4CE

        ldy #aMovingMapSpriteData[0].aSpawnCoordinates - aMovingMapSpriteData[0]
        lda [lR18],y
        and #$00FF
        asl a
        asl a
        asl a
        asl a
        sta aMovingMapSprites.wXPixelPosition,b,x
        inc y

        lda [lR18],y
        and #$00FF
        asl a
        asl a
        asl a
        asl a
        sta aMovingMapSprites.wYPixelPosition,b,x
        inc y

        lda [lR18],y
        and #$000F
        sta aMovingMapSprites.wSpeed,b,x

        lda [lR18],y
        and #$00F0
        bit #$0010
        beq +

          lda aMovingMapSprites.wUnknown0017C2
          ora #$0010
          sta aMovingMapSprites.wUnknown0017C2

        +
        inc y

        ; sprite color

        lda [lR18],y
        and #$003E
        xba
        sta aMovingMapSprites.wUnknown001804,b,x
        inc y

        lda [lR18],y
        sta aMovingMapSprites.wPathScriptAddress,b,x
        inc y

        lda [lR18],y
        sta aMovingMapSprites.wPathScriptBank,b,x

        stz aMovingMapSprites.wPathScriptOffset,b,x
        inc y
        inc y

        phy
        lda #(`asMapSprite)<<8
        sta lR44+1
        lda #<>asMapSprite
        sta lR44
        jsl rlActiveSpriteEngineCreateSpriteHighestSlot
        ply

        _End
        plx
        clc
        rts

        .databank 0

      rsUnknown91C447 ; 91/C447

        .al
        .autsiz
        .databank ?

        ; Sound stuff

        pha
        phx
        phy

        lda lR18
        pha
        lda lR18+1
        pha
        php

        phx
        ldy #0
        lda [lR18],y
        jsl rlGetCharacterMapSprite
        jsl rlGetMapSpriteMovementSound
        jsl rlUnknown91C472

        plx
        sta aMovingMapSprites.wMovingSound,b,x

        plp
        pla
        sta lR18+1
        pla
        sta lR18

        ply
        plx
        pla
        rts

        .databank 0

      rlUnknown91C472 ; 91/C472

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = map sprite movement sound

        phx
        pha
        stz wR0

        ldx #0

          -
          lda aMovingMapSprites.wMovingSound,b,x
          and #$FF00
          ora wR0
          sta wR0
          inc x
          inc x
          cpx #8
          bne -

        lda wR0
        cmp #$0300
        beq +

          ldx #$0100
          cmp #$0200
          beq ++

            ldx #$0200
            bra ++

        +
        inc aMovingMapSprites.wUnknown00181C,b
        lda aMovingMapSprites.wUnknown00181C,b
        and #$0001
        inc a
        xba
        tax

        +
        stx wR0

        ldx #0

          -
          lda aMovingMapSprites.wMovingSound,b,x
          and #$FF00
          cmp wR0
          bne +

            lda aMovingMapSprites.wMovingSound,b,x
            and #$00FF
            sta aMovingMapSprites.wMovingSound,b,x

          +
          inc x
          inc x
          cpx #8
          bne -

        pla
        ora wR0
        plx
        rtl

        .databank 0

      rlUnknown91C4CE ; 91/C4CE

        .al
        .autsiz
        .databank ?

        ; Something with the playing song and the movement sound.

        phx
        lda wMusicID,b
        beq +

          lda aMovingMapSprites.wMovingSound,b,x
          and #$00FF
          sta aMovingMapSprites.wMovingSound,b,x
          bra _End

        +
        lda aMovingMapSprites.wMovingSound,b,x
        sta wR0
        and #$FF00
        beq _End

          xba
          tax
          lda wR0
          and #$00FF
          dec x
          bne +

            sta aSoundChannelFadeState.bMode,b
            stz aSoundChannelFadeTarget,b
            bra _End

          +
          sta aSoundChannelFadeState2,b
          stz aSoundChannelFadeTarget2,b

        _End
        plx
        rtl

        .databank 0

      rsEventCommandMoveTemporaryByScript ; 91/C503

        .al
        .autsiz
        .databank ?

        ; MOVE_TEMPORARY_BY_SCRIPT

        lda #0
        jml +

        .databank 0

      rsEventCommandMoveTemporaryToCoords ; 91/C50A

        .al
        .autsiz
        .databank ?

        ; MOVE_TEMPORARY_TO_COORDS

        lda #1
        jml +

        .databank 0

      rsEventCommandLoadUnitByGroup ; 91/C511

        .al
        .autsiz
        .databank ?

        ; LOAD_UNIT_BY_GROUP

        lda #2
        jml +

        .databank 0

      rsEventCommandLoadUnitDirect ; 91/C518

        .al
        .autsiz
        .databank ?

        ; LOAD_UNIT_DIRECT

        lda #3
        jml +

        .databank 0

      rsEventCommandMoveTemporaryToCoordsFollow ; 91/C51F

        .al
        .autsiz
        .databank ?

        ; MOVE_TEMPORARY_TO_COORDS_FOLLOW

        lda #4
        jml +

        .databank 0

      rsEventCommandMoveTemporaryToCoordsClass ; 91/C526

        .al
        .autsiz
        .databank ?

        ; MOVE_TEMPORARY_TO_COORDS_CLASS

        lda #5
        jml +

        +
        phy
        sta wR0

        ; Wait until any decomps finished
        lda bDecompressionArrayFlag,b
        bne _SEC

          ; Wait until the move engine is free
          lda aMovingMapSprites.wState,b
          cmp #0
          bne _SEC

            lda lR22+1
            sta lR18+1

            tya
            clc
            adc lR22
            sta lR18

            ldx #6

              -
              lda aMovingMapSprites.wActiveSpriteOffset,b,x
              cmp #$FFFF
              beq +

                dec x
                dec x
                bpl -

        _SEC
        ply
        dec y
        sec
        bra _End

        +
        lda wR0
        jsr rsUnknown91C56C
        sty wR0

        pla
        clc
        adc wR0
        tay
        sty wActiveEventOffset,b

        clc
        
        _End
        rts

        .databank 0

      rsUnknown91C56C ; 91/C56C

        .al
        .autsiz
        .databank ?

        ; Unit movement?

        phx
        asl a
        tax
        lda aUnknown91C57D,x
        sta lR23
        plx

        pea #<>(+)-1
        jmp (lR23)
        
        +
        rts

        .databank 0

      aUnknown91C57D ; 91/C57D

        .word <>rsUnknown91C382
        .word <>rsUnknown91C0FE
        .word <>rsUnknown91C191
        .word <>rsUnknown91C241
        .word <>rsUnknown91C0F4
        .word <>rsUnknown91C2FD

      rsEventCommandWaitUnitSpriteDecompressed ; 91/C589

        .al
        .autsiz
        .databank ?

        ; WAIT_UNIT_SPRITE_DECOMPRESSED

        lda bDecompressionArrayFlag,b
        bne _SEC

          lda aMovingMapSprites.wState,b
          cmp #0
          bne _SEC

            clc
            bra +

        _SEC
        dec y
        sec

        +
        rts

        .databank 0

      rsEventCommandWaitUntilMapSpritesHalting ; 91/C59C

        .al
        .autsiz
        .databank ?

        ; WAIT_UNTIL_MAP_SPRITES_HALTING

        phy
        ldx #6

        -
        lda aMovingMapSprites.wActiveSpriteOffset,b,x
        cmp #$FFFF
        bne +

          dec x
          dec x
          bpl -
          bra _End

        +
        lda #(`procUnknown828431)<<8
        sta lR44+1
        lda #<>procUnknown828431
        sta lR44
        jsl rlEventEngineCreateProc

        _End
        ply
        clc
        rts

        .databank 0

      rsEventCommandContinueFormMapSpriteHalt ; 91/C5BF

        .al
        .autsiz
        .databank ?

        ; CONTINUE_FORM_MAP_SPRITE_HALT

        phx
        phy
        ldy #6

          _Loop
          lda aMovingMapSprites.wActiveSpriteOffset,b,y
          cmp #$FFFF
          beq _Next

            tax
            lda aActiveSpriteSystem.aUnknown0012E0,b,x
            ora #$8000
            sta aActiveSpriteSystem.aUnknown0012E0,b,x

            tyx
            lda aMovingMapSprites.wMovingSound,b,x
            and #$FF00
            bne +

              lda aMovingMapSprites.wMovingSound,b,x
              jsl rlUnknown91C472
              sta aMovingMapSprites.wMovingSound,b,x

            +
            jsl rlUnknown91C4CE

        _Next
        dec y
        dec y
        bpl _Loop

        ply
        plx
        rts

        .databank 0

      rsEventCommand2C ; 91/C5F4

        .al
        .autsiz
        .databank ?

        ; EVENT_2C

        phx
        phy
        ldy #6
        
          _Loop
          lda aMovingMapSprites.wActiveSpriteOffset,b,y
          cmp #$FFFF
          beq +

            tax
            stz aActiveSpriteSystem.aTypeOffset,b,x

          +
          dec y
          dec y
          bpl _Loop

        jsl rlUnknown91C611

        ply
        plx
        clc
        rts

        .databank 0

      rlUnknown91C611 ; 91/C611

        .al
        .autsiz
        .databank ?

        lda #$FFFF
        sta aMovingMapSprites.wActiveSpriteOffset,b 
        sta aMovingMapSprites.wActiveSpriteOffset+2,b
        sta aMovingMapSprites.wActiveSpriteOffset+4,b
        sta aMovingMapSprites.wActiveSpriteOffset+6,b

        sep #$20
        lda #$10
        sta aSoundChannelFadeState.bMode,b
        rep #$20

        ldx #0
        jsl rlUpdateMapSpriteSoundPanning

        sep #$20
        lda #$10
        sta aSoundChannelFadeState2,b
        rep #$20

        ldx #3
        jsl rlUpdateMapSpriteSoundPanning
        rtl

        .databank 0

      rsEventChangePalette ; 91/C641

        .al
        .autsiz
        .databank ?

        php
        rep #$30
        cpy #$0201
        bcs _End

          sty wR0
          ldy #0

            _Loop
            lda [lR18],y
            sta aBGPaletteBuffer,b,x
            inc x
            inc x
            inc y
            inc y
            cpy wR0
            bcc _Loop

        _End
        plp
        rts

        .databank 0

      rsEventCommandChangePalette ; 91/C65D

        .al
        .autsiz
        .databank ?

        ; CHANGE_PALETTE

        lda [lR22],y
        sta lR18
        inc y
        lda [lR22],y
        sta lR18+1

        inc y
        inc y
        lda [lR22],y
        and #$00FF
        asl a
        asl a
        asl a
        asl a
        asl a
        tax

        inc y
        phy

        lda [lR22],y
        and #$00FF
        asl a
        asl a
        asl a
        asl a
        asl a
        tay

        jsr rsEventChangePalette

        ply
        inc y
        sty wActiveEventOffset,b

        clc
        rts

        .databank 0

      rsEventCommandPaletteSwap ; 91/C68A

        .al
        .autsiz
        .databank ?

        ; PALETTE_SWAP

        php
        phy

        lda #(`procUnknown828BEA)<<8
        sta lR44+1
        lda #<>procUnknown828BEA
        sta lR44
        jsl rlEventEngineCreateProc

        pla
        clc
        adc #11
        sta wActiveEventOffset,b
        tay

        plp
        clc
        rts

        .databank 0

      rsEventCommandStoreWord ; 91/C6A6

        .al
        .autsiz
        .databank ?

        ; STORE_WORD

        lda [lR22],y
        sta lR18
        inc y
        lda [lR22],y
        sta lR18+1

        inc y
        inc y
        lda [lR22],y
        sta [lR18]
        inc y
        inc y
        sty wActiveEventOffset,b

        clc
        rts

        .databank 0

      rsEventCommand30 ; 91/C6BC

        .al
        .autsiz
        .databank ?

        php
        phy

        lda #(`procUnknown8292B6)<<8
        sta lR44+1
        lda #<>procUnknown8292B6
        sta lR44
        jsl rlEventEngineCreateProc

        pla
        clc
        adc #4
        sta wActiveEventOffset,b
        tay

        plp
        clc
        rts

        .databank 0

      rlUnknown91C6D8 ; 91/C6D8

        .al
        .autsiz
        .databank ?

        pea #<>(+)-1
        jmp (lR23)

        +
        rtl

        .databank 0

      rsEventCommand32 ; 91/C6DF

        .al
        .autsiz
        .databank ?

        clc
        rts

        .databank 0

      rsEventCommandResetSpriteEngine ; 91/C6E1

        .al
        .autsiz
        .databank ?

        php
        phy
        rep #$30
        jsl rlActiveSpriteEngineReset
        ply
        plp

        clc
        rts

        .databank 0

      rsEventCommand31 ; 91/C6ED

        .al
        .autsiz
        .databank ?

        php
        phy
        rep #$30
        ply
        plp
        clc
        rts

        .databank 0

      rsEventCommand37 ; 91/C6F5

        .al
        .autsiz
        .databank ?

        php
        phy

        jsl rlUnknown80C32C

        stz wBufferBG1HOFS
        stz wBufferBG1VOFS
        stz wBufferBG2HOFS
        stz wBufferBG2VOFS
        stz wBufferBG3HOFS
        stz wBufferBG3VOFS

        lda #$00FF
        jsl rlUnknown91A7BC

        sep #$20
        lda #$17
        sta bBufferTM
        sta bBufferTMW
        rep #$20

        jsl rlInitMapMenus

        ply
        plp

        clc
        rts

        .databank 0

      rsEventCommand38 ; 91/C720

        .al
        .autsiz
        .databank ?

        php
        phy

        jsl rlUnknown80C35D

        stz wBufferBG1HOFS
        stz wBufferBG1VOFS
        stz wBufferBG2HOFS
        stz wBufferBG2VOFS

        sep #$20
        lda #$11
        sta bBufferTM
        sta bBufferTMW
        lda #0
        sta bBufferW12SEL
        lda bBufferOBSEL
        and #(OBSEL_Gap | OBSEL_Base)
        sta OBSEL,b
        sta bBufferOBSEL
        rep #$20

        ply
        plp

        clc
        rts

        .databank 0

      rsEventCommandSetCameraToEventUnitSlot1 ; 91/C749

        .al
        .autsiz
        .databank ?

        ; SET_CAMERA_TO_EVENT_UNIT_SLOT_1

        php
        lda wEventUnitSlot1XCoordinate
        cmp #$FFFF
        beq +

          lda wEventUnitSlot1YCoordinate
          cmp #$FFFF
          beq +

            lda wEventUnitSlot1XCoordinate
            asl a
            asl a
            asl a
            asl a
            sec
            sbc wMapScrollXPixels,b
            sta wCursorXOffset,b

            lda wEventUnitSlot1YCoordinate
            asl a
            asl a
            asl a
            asl a
            sec
            sbc wMapScrollYPixels,b
            sta wCursorYOffset,b

        +
        plp
        clc
        rts

        .databank 0

      rsEventCommandSetCameraPosition ; 91/C77D

        .al
        .autsiz
        .databank ?

        ; SET_CAMERA_POSITION

        php
        lda [lR22],y
        and #$00FF
        asl a
        asl a
        asl a
        asl a
        sta wMapXOffset,b

        inc y
        lda [lR22],y
        and #$00FF
        asl a
        asl a
        asl a
        asl a
        sta wMapYOffset,b

        inc y
        sty wActiveEventOffset,b

        lda #$0080
        sta wCursorXOffset,b
        sta wCursorYOffset,b

        plp
        clc
        rts

        .databank 0

      rsEventCommand3B ; 91/C7A7

        .al
        .autsiz
        .databank ?

        ; Sets map state? $80 = not interactable?

        php
        phy
        lda [lR22],y
        and #$003F
        sta wScreenFadingProcInput,b

        lda [lR22],y
        ldx #3
        bit #$0080
        bne +

          ldx #2
          bit #$0040
          bne +

            ldx #0

        +
        stx wMainGameMode,b

        lda #<>rsUnknown80B122
        sta aProcSystem.wInput0,b

        lda #(`procMainLoopChangeFadeByTimer)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFadeByTimer
        sta lR44
        jsl rlProcEngineCreateProc

        lda #(`procUnknown828A30)<<8
        sta lR44+1
        lda #<>procUnknown828A30
        sta lR44
        jsl rlEventEngineCreateProc

        ply
        inc y

        plp
        clc
        rts

        .databank 0

      rsEventCommand3C ; 91/C7F0

        .al
        .autsiz
        .databank ?

        php
        phy

        lda #(`procUnknown828CA3)<<8
        sta lR44+1
        lda #<>procUnknown828CA3
        sta lR44
        jsl rlEventEngineCreateProc

        ply
        plp
        clc
        rts

        .databank 0

      rsEventCommand3D ; 91/C804

        .al
        .autsiz
        .databank ?

        php
        phy

        lda #(`procUnknown828ECB)<<8
        sta lR44+1
        lda #<>procUnknown828ECB
        sta lR44
        jsl rlEventEngineCreateProc

        ply
        plp
        clc
        rts

        .databank 0

      rsEventCommand3E ; 91/C818

        .al
        .autsiz
        .databank ?

        php
        phy

        lda #(`procUnknown828D52)<<8
        sta lR44+1
        lda #<>procUnknown828D52
        sta lR44
        jsl rlEventEngineCreateProc

        pla
        clc
        adc #3
        sta wActiveEventOffset,b
        tay

        plp
        clc
        rts

        .databank 0

      rsEventCommandScriptedMapScroll ; 91/C834

        .al
        .autsiz
        .databank ?

        ; SCRIPTED_MAP_SCROLL

        php
        phy
        lda [lR22],y
        sta wEventMapScrollScript,b
        inc y
        lda [lR22],y
        sta wEventMapScrollScript+1,b

        inc y
        inc y
        lda [lR22],y
        and #$00FF
        sta wEventMapScrollSpeed,b

        lda #(`procMapScroll)<<8
        sta lR44+1
        lda #<>procMapScroll
        sta lR44
        jsl rlEventEngineCreateProc

        pla
        clc
        adc #4
        sta wActiveEventOffset,b
        tay

        plp
        clc
        rts

        .databank 0

      rsEventCommandMapScroll ; 91/C865

        .al
        .autsiz
        .databank ?

        ; MAP_SCROLL

        php
        phy

        lda wMapScrollXPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR2

        lda wMapScrollYPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR3

        lda [lR22],y
        and #$00FF
        sta wR4

        inc y
        lda [lR22],y
        and #$00FF
        sta wR5

        inc y
        lda [lR22],y
        and #$00FF
        sta wR1

        jsl rlCreateMapScrollScriptFromCoordinates

        lda lR18
        sta wEventMapScrollScript,b
        lda lR18+1
        sta wEventMapScrollScript+1,b

        lda #(`procMapScroll)<<8
        sta lR44+1
        lda #<>procMapScroll
        sta lR44
        jsl rlEventEngineCreateProc

        pla
        clc
        adc #3
        sta wActiveEventOffset,b
        tay

        plp
        clc
        rts

        .databank 0

      rsEventCommandMapScrollToEventUnitSlot1 ; 91/C8B8

        .al
        .autsiz
        .databank ?

        php
        phy

        lda wEventUnitSlot1XCoordinate
        cmp #$FFFF
        beq _End

          lda wEventUnitSlot1YCoordinate
          cmp #$FFFF
          beq _End

            lda wEventUnitSlot1XCoordinate
            sta wR0
            lda wEventUnitSlot1YCoordinate
            sta wR1

            jsl rlGetCameraCenteredOnTile

            lda wR0
            sta wR4
            lda wR1
            sta wR5

            lda wMapScrollXPixels,b
            lsr a
            lsr a
            lsr a
            lsr a
            sta wR2

            lda wMapScrollYPixels,b
            lsr a
            lsr a
            lsr a
            lsr a
            sta wR3

            lda [lR22],y
            and #$00FF
            sta wR1

            jsl rlCreateMapScrollScriptFromCoordinates

            lda lR18
            sta wEventMapScrollScript,b
            lda lR18+1
            sta wEventMapScrollScript+1,b

            lda #(`procMapScroll)<<8
            sta lR44+1
            lda #<>procMapScroll
            sta lR44
            jsl rlEventEngineCreateProc

        _End
        pla
        clc
        adc #1
        sta wActiveEventOffset,b
        tay

        plp
        clc
        rts

        .databank 0

      rsEventCommandFillEventUnitSlot ; 91/C925

        .al
        .autsiz
        .databank ?

        ; FILL_EVENT_UNIT_SLOT

        php
        lda [lR22],y
        tax

        inc y
        inc y
        lda [lR22],y
        and #$00FF

        inc y
        phy

        cmp #0
        bne +

          txa
          jsl rlFillEventUnitSlot1
          bra ++

        +
        txa
        jsl rlFillEventUnitSlot2

        +
        ply
        plp

        clc
        rts

        .databank 0

      rlFillEventUnitSlot1 ; 91/C947

        .al
        .autsiz
        .databank ?

        jsl rlGetUnitRAMDataPointerByID
        bcs +

          lda wSelectedUnitDataRAMPointer,b
          sta wEventUnitSlot1ID,b
          jsl rlGetSelectedUnitDeploymentOffset

          tax
          lda aDeploymentTable._XTilePosition,x
          sta wEventUnitSlot1XCoordinate
          lda aDeploymentTable._YTilePosition,x
          sta wEventUnitSlot1YCoordinate
          bra ++

        +
        lda #$FFFF
        sta wEventUnitSlot1XCoordinate
        sta wEventUnitSlot1YCoordinate
        stz wEventUnitSlot1ID,b

        +
        rtl

        .databank 0

      rlFillEventUnitSlot2 ; 91/C979

        .al
        .autsiz
        .databank ?

        jsl rlGetUnitRAMDataPointerByID
        bcs +

          lda wSelectedUnitDataRAMPointer,b
          sta wEventUnitSlot2ID,b
          jsl rlGetSelectedUnitDeploymentOffset

          tax
          lda aDeploymentTable._XTilePosition,x
          sta wEventUnitSlot2XCoordinate
          lda aDeploymentTable._YTilePosition,x
          sta wEventUnitSlot2YCoordinate
          bra ++

        +
        lda #$FFFF
        sta wEventUnitSlot2XCoordinate
        sta wEventUnitSlot2YCoordinate
        stz wEventUnitSlot2ID,b
        
        +
        rtl

        .databank 0

      rsEventCommandFillEventUnitSlotByCoords ; 91/C9AB

        .al
        .autsiz
        .databank ?

        ; 3rd value => 0 = wEventUnitSlot1ID, 1 = wEventUnitSlot2ID

        php
        lda [lR22],y
        and #$00FF
        sta wR0

        inc y
        lda [lR22],y
        and #$00FF
        sta wR1

        inc y
        lda [lR22],y
        and #$00FF
        tax

        bne +

        stz wEventUnitSlot1ID,b
        bra ++

        +
        stz wEventUnitSlot2ID,b

        +
        inc y
        phy

        phx
        jsl rlGetUnitByCoordinates
        plx
        bcs _End

        lda wSelectedUnitDataRAMPointer,b
        cpx #0
        bne +

        sta wEventUnitSlot1ID,b
        bra _End

        +
        sta wEventUnitSlot2ID,b

        _End
        ply 
        plp

        clc
        rts

        .databank 0

      rsEventCommandFactionUnitDeath ; 91/C9EA

        .al
        .autsiz
        .databank ?

        ; FACTION_UNIT_DEATH

        php
        lda [lR22],y
        and #$00FF
        sta aProcSystem.wInput0,b

        inc y
        lda [lR22],y
        and #$00FF
        cmp #$00FF
        bne +

          lda #$FFFF

        +
        sta aProcSystem.wInput1,b

        inc y
        lda [lR22],y
        sta aProcSystem.wInput2,b

        inc y
        inc y
        phy

        lda #(`procFactionSlotUnitDeath)<<8
        sta lR44+1
        lda #<>procFactionSlotUnitDeath
        sta lR44
        jsl rlEventEngineCreateProc

        ply
        plp

        clc
        rts

        .databank 0

      rsEventCommandRunASM ; 91/CA1F

        .al
        .autsiz
        .databank ?

        ; RUN_ASM

        php
        phy
        rep #$30
        lda [lR22],y
        sta lR18
        inc y
        lda [lR22],y
        sta lR18+1

        jsl +

        pla
        clc
        adc #3
        sta wActiveEventOffset,b
        tay

        plp
        clc
        rts

        +
        jml [lR18]

        .databank 0

      rsEventCommand48 ; 91/CA3F

        .al
        .autsiz
        .databank ?

        php
        phy

        phy
        lda wMapMenuTransparentTile,b
        sta $7EA7C5
        lda #$00FF
        sta wMapMenuTransparentTile,b
        ply

        lda [lR22],y
        and #$00FF
        sta wR0
        asl a
        clc
        adc wR0
        tax

        inc y
        lda [lR22],y
        sta lR18
        inc y
        lda [lR22],y
        sta lR18+1

        phx
        jsl rlUnknown91A9BB
        plx

        lda lMapMenuRAMEntryPointer,b
        sta $7E93AA,x
        lda lMapMenuRAMEntryPointer+1,b
        sta $7E93AB,x

        lda #3
        ora bBufferW34SEL
        sta bBufferW34SEL

        lda bBufferTM
        ora #$0004
        sta bBufferTM

        lda bBufferTMW
        ora #$0004
        sta bBufferTMW

        sep #$20
        lda bBufferBGMODE
        ora #$08
        sta bBufferBGMODE
        rep #$20

        jsl rlUnknown91A7DF

        pla
        clc
        adc #4
        sta wActiveEventOffset,b
        tay

        plp
        clc
        rts

        .databank 0

      rsEventCommand49 ; 91/CAA9

        .al
        .autsiz
        .databank ?

        php
        phy
        rep #$30
        lda [lR22],y
        and #$00FF
        sta wR0
        asl a
        clc
        adc wR0
        tax

        lda $7E93AA,x
        sta lMapMenuRAMEntryPointer,b
        lda $7E93AB,x
        sta lMapMenuRAMEntryPointer+1,b

        lda #0
        sta $7E93AA,x
        rep #$20

        jsl rlRemoveMapMenu

        ply
        inc y
        sty wActiveEventOffset,b

        plp
        clc
        rts

        .databank 0

      rsEventCommandFadeInByTimer ; 91/CADC

        .al
        .autsiz
        .databank ?

        php
        phy
        jsl rlClearAllFadeProcs

        lda #(`procEventFadeInByTimer)<<8
        sta lR44+1
        lda #<>procEventFadeInByTimer
        sta lR44
        jsl rlEventEngineCreateProc

        ply
        inc y
        sty wActiveEventOffset,b

        plp
        clc
        rts

        .databank 0

      rsEventCommandFadeOutByTimer ; 91/CAF8

        .al
        .autsiz
        .databank ?

        php
        phy
        jsl rlClearAllFadeProcs

        lda #(`procEventFadeOutByTimer)<<8
        sta lR44+1
        lda #<>procEventFadeOutByTimer
        sta lR44
        jsl rlEventEngineCreateProc

        ply
        inc y
        sty wActiveEventOffset,b

        plp
        clc
        rts

        .databank 0

      rsEventCommandPause ; 91/CB14

        .al
        .autsiz
        .databank ?

        ; PAUSE

        php
        phy

        lda #(`procEventPause)<<8
        sta lR44+1
        lda #<>procEventPause
        sta lR44
        jsl rlEventEngineCreateProc

        ply
        inc y
        inc y
        sty wActiveEventOffset,b

        plp
        clc
        rts

        .databank 0

      rsEventCommand35 ; 91/CB2D

        .al
        .autsiz
        .databank ?

        php
        phy
        rep #$30

        lda #(`procUnknown829245)<<8
        sta lR44+1
        lda #<>procUnknown829245
        sta lR44
        jsl rlEventEngineCreateProc

        ply
        plp

        clc
        rts

        .databank 0

      rsEventCommand36 ; 91/CB43

        .al
        .autsiz
        .databank ?

        php
        phy
        rep #$30

        lda #(`procUnknown82925E)<<8
        sta lR44+1
        lda #<>procUnknown82925E
        sta lR44
        jsl rlEventEngineCreateProc

        ply
        inc y
        inc y
        sty wActiveEventOffset,b

        plp
        clc
        rts

        .databank 0

      rsEventCommandRunEventCondition ; 91/CB5E

        .al
        .autsiz
        .databank ?

        ; RUN_EVENT_CONDITION

        php
        phb

        sep #$20
        lda lR22+2
        pha
        plb
        rep #$20

        tya
        clc
        adc lR22
        tay

        jsl rlUnknown86816B

        tya
        sec
        sbc lR22
        tay

        plb
        plp

        clc
        rts

        .databank 0

      rsEventCommandSetFlagIfInChapter ; 91/CB7A

        .al
        .autsiz
        .databank ?

        ; SET_FLAG_IF_IN_CHAPTER

        php
        phb
        phy
        lda [lR22],y
        and #$00FF
        sta wR0

        inc y
        lda [lR22],y
        and #$00FF
        tax

        lda wR0
        jsl rlGetSpecifiedChaptersRAMPointer
        bcs +

          txa
          jsl rlSetEventFlag

        +
        pla
        clc
        adc #2
        tay

        plb
        plp

        clc
        rts

        .databank 0

      rsEventCommandUnsetFlagIfInChapter ; 91/CBA2

        .al
        .autsiz
        .databank ?

        ; UNSET_FLAG_IF_IN_CHAPTER

        php
        phb
        phy
        lda [lR22],y
        and #$00FF
        sta wR0

        inc y
        lda [lR22],y
        and #$00FF
        tax

        lda wR0
        jsl rlGetSpecifiedChaptersRAMPointer
        bcs +

          txa
          jsl rlUnsetEventFlag

        +
        pla
        clc
        adc #2
        tay

        plb
        plp

        clc
        rts

        .databank 0

      rsEventCommandRunEventConditionUnskippable ; 91/CBCA

        .al
        .autsiz
        .databank ?

        ; RUN_EVENT_CONDITION_UNSKIPPABLE

        php
        phb

        jsr rsEventCommandRunEventCondition

        phy
        lda #(`procUnknown828A93)<<8
        sta lR44+1
        lda #<>procUnknown828A93
        sta lR44
        jsl rlEventEngineCreateProc
        ply

        plb
        plp

        clc
        rts

        .databank 0

      rsEventCommand4E ; 91/CBE3

        .al
        .autsiz
        .databank ?

        ; EVENT_4E

        php
        phb
        phy

        lda [lR22],y
        sta lR18
        inc y
        lda [lR22],y
        sta lR18+1

        lda #2
        jsl rlDialogueStartTextAndHDMA
        ldx #0
        jsl rlSetupKeeperDialogueBox

        phy
        lda #(`procUnknown828AC3)<<8
        sta lR44+1
        lda #<>procUnknown828AC3
        sta lR44
        jsl rlEventEngineCreateProc
        ply

        ply
        inc y
        inc y
        inc y

        plb
        plp

        clc
        rts

        .databank 0

      rsEventCommandWMFadeIn ; 91/CC15

        .al
        .autsiz
        .databank ?

        php
        phb
        phy

        lda #<>rsSetupWorldMapScreen
        sta aProcSystem.wInput0,b

        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc

        ply
        plb
        plp
        
        clc
        rts

        .databank 0

      rsEventCommandWMFadeOut ; 91/CC31

        .al
        .autsiz
        .databank ?

        ; Leaves the world map: fades out to the chapter intro, or in the
        ; epilogue (wCurrentChapter $FFFF) moves on to the credits
        ; (rlStartEpilogueCredits).

        php
        phb
        phy

        lda wCurrentChapter,b
        cmp #$FFFF
        beq +

          stz wGameStateRoutine1,b

          lda #<>rsOpenChapterIntroScreen
          sta aProcSystem.wInput0,b
          lda #2
          sta wScreenFadingProcInput,b

          lda #(`procMainLoopChangeFadeByTimer)<<8
          sta lR44+1
          lda #<>procMainLoopChangeFadeByTimer
          sta lR44
          jsl rlProcEngineCreateProc

          _End
          ply
          plb
          plp

          clc
          rts

        +
        jsl rlStartEpilogueCredits
        bra _End

        .databank 0

      rsEventCommandWMScroll ; 91/CC64

        .al
        .autsiz
        .databank ?

        ; WM_SCROLL

        php
        phy

        lda #(`procWorldMapScroll)<<8
        sta lR44+1
        lda #<>procWorldMapScroll
        sta lR44
        jsl rlEventEngineCreateProc

        pla
        clc
        adc #4
        sta wActiveEventOffset,b
        tay

        plp
        clc
        rts

        .databank 0

      rsEventCommandWMMarker ; 91/CC80

        .al
        .autsiz
        .databank ?

        ; WM_MARKER

        php
        phb
        phy

        lda [lR22],y
        and #$00FF
        sta wR0

        inc y
        lda [lR22],y
        and #$00FF
        sta wR1

        inc y
        lda [lR22],y
        and #$00FF
        tax

        inc y
        lda [lR22],y
        and #$00FF
        tay

        jsl rlLoadWorldMapMarkerData

        ply
        inc y
        inc y
        inc y
        inc y

        plb
        plp

        clc
        rts

        .databank 0

      rsEventCommandWMClearMarker ; 91/CCAD

        .al
        .autsiz
        .databank ?

        ; WM_CLEAR_MARKER

        php
        phb
        phy

        lda [lR22],y
        and #$00FF
        tax

        jsl rlClearWorldMapMarker

        ply
        inc y

        plb
        plp

        clc
        rts

        .databank 0

      rsEventCommandWMLoadPortrait ; 91/CCC0

        .al
        .autsiz
        .databank ?

        ; WM_LOAD_PORTRAIT

        php
        phb
        phy

        lda [lR22],y
        and #$00FF
        tax

        inc y
        lda [lR22],y

        jsl rlLoadWorldMapPortraitIntoSlot

        ply
        inc y
        inc y
        inc y

        plb
        plp

        clc
        rts

        .databank 0

      rsEventCommandWMFadeInPortrait ; 91/CCD8

        .al
        .autsiz
        .databank ?

        ; WM_FADE_IN_PORTRAIT

        php
        phb
        phy

        lda [lR22],y
        and #$00FF
        tax

        inc y
        lda [lR22],y
        and #$00FF
        sta wR0

        inc y
        lda [lR22],y
        and #$00FF
        sta wR1

        jsl rlFadeInWorldMapPortraitSlot

        ply
        inc y
        inc y
        inc y

        plb
        plp

        clc
        rts

        .databank 0

      rsEventCommandWMFadeOutPortrait ; 91/CCFD

        .al
        .autsiz
        .databank ?

        ; WM_FADE_OUT_PORTRAIT

        php
        phb
        phy

        lda [lR22],y
        and #$00FF
        tax

        jsl rlFadeOutWorldMapPortraitSlot

        ply
        inc y

        plb
        plp

        clc
        rts

        .databank 0

      rsEventCommandWMMovePortrait ; 91/CD10

        .al
        .autsiz
        .databank ?

        ; WM_MOVE_PORTRAIT

        php
        phb
        phy

        lda [lR22],y
        and #$00FF
        tax

        inc y
        lda [lR22],y
        and #$00FF
        sta wR0

        inc y
        lda [lR22],y
        and #$00FF
        sta wR1

        jsl rlMoveWorldMapPortraitSlot

        ply
        inc y
        inc y
        inc y

        plb
        plp

        clc
        rts

        .databank 0

      rsEventCommandWMDialogue ; 91/CD35

        .al
        .autsiz
        .databank ?

        ; WM_DIALOGUE

        php
        phb
        phy

        phy
        jsl rlResetDialogueEngine
        ply

        lda [lR22],y
        sta lR18
        inc y
        lda [lR22],y
        sta lR18+1

        lda #0
        jsl rlDialogueStartTextAndHDMA

        lda #(`rlUnknown8B9275)<<8
        sta aDialogue.lHDMARoutine+1,b
        lda #<>rlUnknown8B9275
        sta aDialogue.lHDMARoutine,b

        ldx #0
        jsl rlUnknown8B91F6

        phy
        lda #(`procUnknown828AC3)<<8
        sta lR44+1
        lda #<>procUnknown828AC3
        sta lR44
        jsl rlEventEngineCreateProc
        ply

        ply
        inc y
        inc y
        inc y

        plb
        plp

        clc
        rts

        .databank 0

      rsEventCommand59 ; 91/CD79

        .al
        .autsiz
        .databank ?

        php
        phb

        phy
        jsl rlUnknown8B87A0
        ply

        plb
        plp

        clc
        rts

        .databank 0

      rsEventCommandWMClearDialogue ; 91/CD85

        .al
        .autsiz
        .databank ?

        ; Clears BG3HOFS hdma?

        php
        phb

        phy
        jsl rlUnknown8B87C5
        ply

        plb
        plp

        clc
        rts

        .databank 0

      rsEventCommandWMHighlight ; 91/CD91

        .al
        .autsiz
        .databank ?

        ; WM_HIGHLIGHT

        php
        phb
        phy

        lda [lR22],y
        and #$00FF

        jsl rlHighlightWorldMapPart

        ply
        inc y

        plb
        plp

        clc
        rts

        .databank 0

      rsEventCommandWMClearHighlight ; 91/CDA3

        .al
        .autsiz
        .databank ?

        ; WM_CLEAR_HIGHLIGHT

        php
        phb

        phy
        jsl rlClearHighlightWorldMapPart
        ply

        plb
        plp

        clc
        rts

        .databank 0

      rsEventCommand01 ; 91/CDAF

        .al
        .autsiz
        .databank ?

        ; EVENT_01

        lda #2
        sta wEventEngineState,b

        clc
        rts

        .databank 0

      rsEventCommandDemoAllowSkip ; 91/CDB7

        .al
        .autsiz
        .databank ?

        ; Event command $5D (DEMO_ALLOW_SKIP): sets $1832 (to 0 when $0CC2 is 0 and wDemoIndex is 0 or 1, with sound command $D0) and starts procDemoSkipFadeOut, which ends the opening when the event ends or Start is pressed.

        php
        phb
        phy

        stz wSavedMapStep,b
        lda #1
        sta $1832,b

        lda wDemoBattlePair,b
        bne +

          lda wDemoIndex,b
          and #$FFFE
          bne +

            stz $1832,b
            lda #$00D0
            jsl rlSendSoundCommand

        +
        lda #(`procDemoSkipFadeOut)<<8
        sta lR44+1
        lda #<>procDemoSkipFadeOut
        sta lR44
        jsl rlEventEngineCreateProc

        lda #$8000
        tsb wEventEngineFlags,b

        lda #$0010
        tsb wMapSystemFlags,b

        lda bSoundFlags,b
        ora #$0005
        sta bSoundFlags,b

        ply
        plb
        plp

        clc
        rts

        .databank 0

      rsEventCommandOpenMapBattle ; 91/CE02

        .al
        .autsiz
        .databank ?

        ; Event command $5E (OPEN_TITLE_SCREEN): flashes in the title screen (rlFlashToTitleScreen, rsOpenTitleScreen).

        php
        phb
        phy

        stz wGameStateRoutine1,b
        lda #<>rsOpenTitleScreen
        sta aProcSystem.wInput0,b

        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc

        lda bSoundFlags,b
        and #$FFFA
        sta bSoundFlags,b

        ply
        plb
        plp

        clc
        rts

        .databank 0

      rlUnknown91CE2A ; 91/CE2A

        .al
        .autsiz
        .databank ?

        rtl
        
        .databank 0

        ; 91/CE2B

    .endsection EventCommandSection


    .section Unsorted809654Section

      .al
      .xs

      rlStepMusicScript ; 80/9654

        .al
        .xl
        .autsiz
        .databank ?

        ; Steps the music script (channel 0, wMusicID) now and runs a deferred upload,
        ; outside the frame's rlUpdateSound; called after setting wMusicID.

        php
        phb
        phk
        plb
        .databank $80
        rep #$30
        pha
        phx
        phy
        lda wMusicID,b
        bne _9667
        sta aSoundScriptRunning,b
        bra _9671


        _9667
        ldx #$0000
        jsr rsStepSoundScript
        jsl rlRunDeferredSoundUpload

        _9671
        ply
        plx
        pla
        plb
        .databank ?
        plp
        rtl

        .databank 0

        ; 80/9677

      rsStepSoundScript ; 80/9677

        .al
        .xl
        .autsiz
        .databank ?

        ; X = channel (0, 2), A = its script ID: starts the script if it is not the one
        ; running, else counts down its wait and runs commands up to the next wait. At
        ; the script's end the channel stops and aSoundScriptPrevious keeps the ID.

        ldy lR38
        phy
        ldy lR38+1
        phy
        ldy wSoundDataBankHigh,b
        sty lR38+1
        stx wSoundScriptChannel,b
        cmp aSoundScriptRunning,b,x
        beq _96A3
        sta aSoundScriptRunning,b,x
        and #$00FF
        dec a
        asl a
        tay
        lda #$0001
        sta aSoundScriptWaits,b,x
        lda aSoundHeader.Scripts
        sta lR38
        lda [lR38],y
        bra _96A6


        _96A3
        lda aSoundScriptPositions,b,x

        _96A6
        tay
        lda wMusicID,b,x
        and #$8000
        xba
        sep #$20
        sta bSoundUploadNoVBlank,b
        rep #$20
        dec aSoundScriptWaits,b,x
        bne _96E9
        stz lR38

        _96BC
        lda [lR38],y
        beq _96F0
        inc y
        inc y
        sta wSoundScriptCommand,b
        and #$FC00
        beq _96D7
        xba
        lsr a
        lsr a
        dec a
        asl a
        tax
        lda [lR38],y
        inc y
        inc y
        jsr (aSoundScriptCommands,x)

        _96D7
        lda wSoundScriptCommand,b
        and #$03FF
        beq _96BC
        ldx wSoundScriptChannel,b
        sta aSoundScriptWaits,b,x
        tya
        sta aSoundScriptPositions,b,x

        _96E9
        pla
        sta lR38+1
        pla
        sta lR38
        rts


        _96F0
        ldx wSoundScriptChannel,b
        pha
        lda wMusicID,b,x
        sta aSoundScriptPrevious,b,x
        pla
        sta wMusicID,b,x
        sta aSoundScriptRunning,b,x
        bra _96E9

        .databank 0

        ; 80/9703

    .endsection Unsorted809654Section


    .section Unsorted80AF9BSection

      .al
      .xl

      rsUnknown80AF9B ; 80/AF9B

        .al
        .autsiz
        .databank ?

        jsl rlHardwareResetScreenPosMathHDMA
        jsl rlHardwareResetScreenRegisters
        lda #0
        jsl rlFillBG2Page0TilemapBuffer
        lda #$030F
        jsl rlFillBG2Page1TilemapBuffer
        lda #$00FF
        jsl rlFillBG3Page0TilemapBuffer

        ldx #$067E
        lda #0

          -
          sta aMapWindowFrameBuffer,x
          sta aMapWindowTextBuffer,x
          dec x
          dec x
          bpl -

        lda #$0000 >> 1
        sta wR1
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

        jsl rlClearSpriteExtBuffer
        jsl rlHideSprites
        jsl rlDMAPaletteAndOAMBuffer
        jsl rlDMAByStruct
          .structDMAToVRAM aBG2TilemapBuffer.Page1, $0800, $80, $A800

        jsl rlDMAByStruct
          .structDMAToVRAM aBG3TilemapBuffer.Page0, $0800, $80, $B000

        jsl rlClearUnitWindowAndTerrainWindowProcs
        jsl rlActiveSpriteEngineReset
        jsl rlEnableActiveSpriteEngine
        jsl rlResetHDMAEngine
        jsl rlResetIRQEngine
        jsl rlResetRAMStructAndAreaVariables
        jsl rlInitMapMenus
        jsl rlResetMenuOptionStack
        lda #$00FF
        sta wMapMenuTransparentTile,b
        jsl rlEnableMapMenuUploads
        rts

        .databank 0

        ; 80/B041

    .endsection Unsorted80AF9BSection


    .section Unsorted80B041Section

      .as
      .xl

      rsUnknown80B041 ; 80/B041

        .al
        .xl
        .autsiz
        .databank ?

        lda #GAMESTATE_MAP_UPKEEP
        sta wGameStateRoutine2,b
        lda #<>rsMapVBlank
        sta wVBlankPointer
        lda #<>rsMapMainLoop
        sta wMainLoopPointer
        rts

        .databank 0

        ; 80/B052

      rsUnknown80B052 ; 80/B052

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aMapRowUploadIRQ)<<8
        sta lR44+1
        lda #<>aMapRowUploadIRQ
        sta lR44
        jsl rlUnknown82E0C6
        jsl rlUnknown82E08D
        rts

        .databank 0

        ; 80/B065

      rsUnknown80B065 ; 80/B065

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown80B08C
        lda #(`aDecompressionDMAEntry80B084)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry80B084
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        jsl rlLoadMenuFontGraphics
        jsl rlLoadMenuIconGraphics
        jsl rlLoadDefaultWindowBorderPalette
        rts

        .databank 0

        ; 80/B084

    .endsection Unsorted80B041Section


    .section Unsorted80B08CSection

      .al
      .xl

      rlUnknown80B08C ; 80/B08C

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aDecompressionDMAEntry80B09B)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry80B09B
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        rtl

        .databank 0

        ; 80/B09B

    .endsection Unsorted80B08CSection


    .section Unsorted80B105Section

      .al
      .xl

      rsUnknown80B105 ; 80/B105

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$17
        sta bBufferTMW
        lda #$08
        sta bBufferWH0
        lda #$F7
        sta bBufferWH1
        lda #$33
        sta bBufferW12SEL
        lda #$03
        sta bBufferW34SEL
        lda #$15
        sta bBufferTM
        rep #$20
        rts

        .databank 0

        ; 80/B122

    .endsection Unsorted80B105Section


    .section Unsorted80B122Section

      .al
      .xl

      rsUnknown80B122 ; 80/B122

        .al
        .autsiz
        .databank ?

        ; a MainLoop routine

        php
        sei
        sep #$20
        lda #INIDISP_Setting(true, 0)
        sta bBufferINIDISP
        sta INIDISP,b
        rep #$20

        jsl rlDisableVBlank
        jsr rsUnknown80AF9B
        jsr rsUnknown80B16A
        jsl rlLoadWindowGraphics
        jsr rsUnknown80B065
        jsr rsUnknown80B105
        jsr rsUnknown80B052
        jsr rsUnknown80B041

        lda #GAMESTATE_MAP_STEP
        sta wGameStateRoutine1,b
        lda wSavedMapStep,b
        sta wGameStateStep,b
        jsr rsUnknown80B195

        sep #$20
        lda #INIDISP_Setting(false, 0)
        sta bBufferINIDISP
        sta INIDISP,b
        rep #$20

        jsl rlEnableVBlank
        plp
        cli
        rts

        .databank 0

      rsUnknown80B16A ; 80/B16A

        .al
        .autsiz
        .databank ?

        lda wMainGameMode,b
        asl a
        tax
        jmp (+,x)

        +
        .addr rsUnknown80B17A
        .addr rsUnknown80B17F
        .addr rsUnknown80B184
        .addr rsUnknown80B184

        .databank 0

      rsUnknown80B17A ; 80/B17A

        .al
        .autsiz
        .databank ?

        jsl rlSetUpChapterMapDisplay
        rts

        .databank 0

      rsUnknown80B17F ; 80/B17F

        .al
        .autsiz
        .databank ?

        jsl rlSetUpChapterMapDisplayAllFrames
        rts

        .databank 0

      rsUnknown80B184 ; 80/B184

        .al
        .autsiz
        .databank ?

        jsl rlLoadChapterMapLayout
        jsl rlUpdateAllLocationEvents
        jsl rlUnknown86C629
        jsl rlSetUpChapterMapDisplay
        rts

        .databank 0

      rsUnknown80B195 ; 80/B195

        .al
        .autsiz
        .databank ?

        lda #$0020
        trb wChapterFlags,b

        lda #(`aMapMenuRAMArea)<<8
        sta lR18+1
        lda #<>aMapMenuRAMArea
        sta lR18
        lda #1
        sta wStructIndex,b
        lda #size(aMapMenuRAMArea)
        jsl rlBuildRAMAreaHeaderAndGuidingEntry

        lda #11
        sta wGameStateStep,b
        jsl rlUnknown858728

        lda wMainGameMode,b
        cmp #2
        bcc _End

          jsl rlHandleDefeatedUnit
          bcc +

            jsl rlGetVictoryThemeIfAllEnemiesDead
            bcc +

              sta wPhaseSongID,b

          +
          lda wEventEngineFlags,b
          bne _End

            jsl rlResumePhaseMusic
            jsl rlStepMusicScript

        _End
        rts

        .databank 0

        ; 80/B1E1

    .endsection Unsorted80B122Section


    .section Unsorted80B63FSection

      .al
      .xl

      rlUnknown80B63F ; 80/B63F

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 80/B640

    .endsection Unsorted80B63FSection


    .section Unsorted80C32CSection

      .al
      .xl

      rlUnknown80C32C ; 80/C32C

        .al
        .autsiz
        .databank ?

        php
        sep #$20
        lda #$09
        sta bBufferBGMODE
        rep #$20

        lda #0
        sta wR1
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
        plp
        rtl

        .databank 0

    .endsection Unsorted80C32CSection


    .section Unsorted80C35DSection

      .al
      .xl

      rlUnknown80C35D ; 80/C35D

        .al
        .autsiz
        .databank ?

        php
        sep #$20
        lda #3
        sta BGMODE,b
        sta bBufferBGMODE
        lda #0
        sta BG1SC,b
        sta bBufferBG1SC
        sta BG2SC,b
        sta bBufferBG2SC
        rep #$20

        lda #$2000 >> 1
        sta wR1
        sta wR2
        lda #$0000 >> 1
        sta wR3
        sta wR4
        lda #$0000 >> 1
        sta wR5
        lda #$E000 >> 1
        sta wR6
        sta wR7
        lda #$0000 >> 1
        sta wR8
        jsl rlSetLayerPositionsAndSizes
        plp
        rtl

        .databank 0

        ; 80/C39A

    .endsection Unsorted80C35DSection


    .section Unsorted828431Section

      .al
      .xl

      procUnknown828431 ; 82/8431

        .structProcInfo "UA", rlProcUnknown828431Init, rlProcUnknown828431Cycle, aProcUnknown828431Code

      rlProcUnknown828431Init ; 82/8439

        .al
        .autsiz
        .databank ?

        rtl

        .databank 0

      rlProcUnknown828431Cycle ; 82/843A

        .al
        .autsiz
        .databank ?

        stz wR7
        ldx #6

          -
          lda aMovingMapSprites.wActiveSpriteOffset,b,x
          cmp #$FFFF
          beq +

            tay
            lda aActiveSpriteSystem.aUnknown0012E0,b,y
            tsb wR7

          +
          dec x
          dec x
          bpl -

        lda wR7
        bit #$8000
        bne +

          jsl rlEventEngineFreeProc

        +
        rtl

        .databank 0

      aProcUnknown828431Code ; 82/845D

        PROC_HALT

    .endsection Unsorted828431Section


    .section Unsorted828A30Section

      .al
      .xl

      procUnknown828A30 ; 82/8A30

        .structProcInfo "TT", rlProcUnknown828A30Init, rlProcUnknown828A30Cycle1, aProcUnknown828A30Code

        .word 0

      rlProcUnknown828A30Init ; 82/8A3A

        .al
        .autsiz
        .databank ?

        ldy wActiveEventOffset,b
        lda lActiveEventPointer,b
        sta @l lR22
        lda lActiveEventPointer+1,b
        sta @l lR22+1
        lda [lR22],y
        sta aProcSystem.aBody0,b,x
        rtl

        .databank 0

      rlProcUnknown828A30Cycle1 ; 82/8A51

        .al
        .autsiz
        .databank ?

        lda bBufferINIDISP
        and #INIDISP_Brightness
        cmp #INIDISP_Setting(false, 0)
        bne _End

          lda aProcSystem.aBody0,b,x
          bit #$0080
          bne +

            lda #<>rlProcUnknown828A30Cycle2
            sta aProcSystem.aHeaderOnCycle,b,x
            bra _End

          +
          lda bBufferINIDISP
          bit #INIDISP_ForcedBlank
          bne _End

            jsl rlEventEngineFreeProc

        _End
        rtl

        .databank 0

      rlProcUnknown828A30Cycle2 ; 82/8A77

        .al
        .autsiz
        .databank ?

        lda bBufferINIDISP
        and #INIDISP_Brightness
        cmp #INIDISP_Setting(false, 15)
        bne +

          jsl rlEventEngineFreeProc

        +
        rtl

        .databank 0

      aProcUnknown828A30Code ; 82/8A86

        PROC_HALT

      procUnknown828A88 ; 82/8A88

        .structProcInfo "LL", rlProcUnknown828A88Init, rlProcDialogueWithBGCycle1, aProcDialogueWithBGCode

        .word 0

      rlProcUnknown828A88Init ; 82/8A92

        .al
        .autsiz
        .databank ?

        rtl

        .databank 0

      procUnknown828A93 ; 82/8A93

        .structProcInfo "TT", rlProcUnknown828A93Init, rlProcUnknown828A93Cycle1, aProcUnknown828A93Code

        .word 0

      rlProcUnknown828A93Init ; 82/8A9D

        .al
        .autsiz
        .databank ?

        rtl

        .databank 0

      rlProcUnknown828A93Cycle1 ; 82/8A9E

        .al
        .autsiz
        .databank ?

        lda bUnknown000E7B,b
        bit #$0001
        bne +

          lda #4
          sta aProcSystem.aBody0,b,x
          lda #<>rlProcUnknown828A93Cycle2
          sta aProcSystem.aHeaderOnCycle,b,x

        +
        rtl

        .databank 0

      rlProcUnknown828A93Cycle2 ; 82/8AB3

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

      aProcUnknown828A93Code ; 82/8AC1

        PROC_HALT

      procUnknown828AC3 ; 82/8AC3

        .structProcInfo "ME", rlProcUnknown828AC3Init, rlProcUnknown828AC3Cycle, aProcUnknown828AC3Code

        .word 0

      rlProcUnknown828AC3Init ; 82/8ACD

        .al
        .autsiz
        .databank ?

        rtl

        .databank 0

      rlUnknown828ACE ; 82/8ACE

        .al
        .autsiz
        .databank ?

        lda #1
        sta aDialogue.wTextSound,b

        lda aDialogue.wStatus,b
        bit #DialogueStatusEnabled
        beq +

          lda #<>rlProcUnknown828AC3Cycle
          sta aProcSystem.aHeaderOnCycle,b,x

        +
        rtl

        .databank 0

      rlProcUnknown828AC3Cycle ; 82/8AE3

        .al
        .autsiz
        .databank ?

        lda aDialogue.wStatus,b
        bit #DialogueStatusEnabled
        bne +

          jsl rlEventEngineFreeProc

        +
        rtl

        .databank 0

      aProcUnknown828AC3Code ; 82/8AF0

        PROC_HALT

      procUnknown828AF2 ; 82/8AF2

        .structProcInfo "ME", rlProcUnknown828AF2Init, rlProcUnknown828AF2Cycle, aProcUnknown828AF2Code

        .word 0

      rlUnknown828AFC ; 82/8AFC

        .al
        .autsiz
        .databank ?

        rtl

        .databank 0

      rlUnknown828AFD ; 82/8AFD

        .al
        .autsiz
        .databank ?

        lda wMusicID,b
        bne +

          jsl rlEventEngineFreeProc

        +
        rtl

        .databank 0

      aProcCodeUnknown828B07 ; 82/8B07

        PROC_HALT

      procUnknown828B09 ; 82/8AD9

        .structProcInfo "ME", rlProcUnknown828AF2Init, rlProcUnknown828AF2Cycle, aProcUnknown828AF2Code

        .word 0

      rlProcUnknown828AF2Init ; 82/8B13

        .al
        .autsiz
        .databank ?

        rtl

        .databank 0

      rlProcUnknown828AF2Cycle ; 82/8B14
      
        .al
        .autsiz
        .databank ?

        lda #(`procMapBattle)<<8
        sta lR44+1
        lda #<>procMapBattle
        sta lR44
        jsl rlProcEngineFindProc
        bcs +

          jsl rlEventEngineFreeProc

        +
        rtl

        .databank 0

      aProcUnknown828AF2Code ; 82/8B29

        PROC_HALT

      ; 82/8B2B

    .endsection Unsorted828A30Section


    .section ProcScript828B61Section

      .al
      .xl

      procUnknown828B61 ; 82/8B61

        .structProcInfo "ME", rlProcUnknown828B61Init, rlProcUnknown828B61Cycle, aProcUnknown828B61Code

    .endsection ProcScript828B61Section


    .section Unsorted828B6BSection

      .al
      .xl

      rlProcUnknown828B61Init ; 82/8B6B

        .al
        .xl
        .autsiz
        .databank ?

        ldy wActiveEventOffset,b
        lda lActiveEventPointer,b
        sta @l lR22
        lda lActiveEventPointer+1,b
        sta @l lR22+1
        lda [lR22],y
        and #$00FF
        sta aProcSystem.wInput0,b
        inc y
        lda [lR22],y
        and #$00FF
        sta aProcSystem.wInput1,b
        jsl rlUnknown9EEC95
        rtl

        .databank 0

        ; 82/8B92

      rlProcUnknown828B61Cycle ; 82/8B92

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`procUnknown9EECA4)<<8
        sta lR44+1
        lda #<>procUnknown9EECA4
        sta lR44
        jsl rlProcEngineFindProc
        bcs _8BA6
        jsl rlEventEngineFreeProc

        _8BA6
        rtl

        .databank 0

        ; 82/8BA7

    .endsection Unsorted828B6BSection


    .section ProcScript828BA7Section

      .al
      .xl

      aProcUnknown828B61Code ; 82/8BA7

        PROC_HALT


        ; 82/8BA9

    .endsection ProcScript828BA7Section


    .section Unsorted828BEASection

      .as
      .xl

      procUnknown828BEA  ; 82/8BEA

        .structProcInfo "CC", rlProcUnknown828BEAInit, rlProcUnknown828BEACycle, aProcUnknown828BEACode
        .word 0

    .endsection Unsorted828BEASection


    .section Unsorted828BF4Section

      .al
      .xl

      rlProcUnknown828BEAInit ; 82/8BF4

        .al
        .autsiz
        .databank ?

        ldy wActiveEventOffset,b
        sep #$20
        lda [lR22],y
        sta aProcSystem.aBody0,b,x
        inc y
        lda [lR22],y
        sta aProcSystem.aBody0+1,b,x
        inc y
        lda [lR22],y
        sta aProcSystem.aBody2,b,x
        inc y
        lda [lR22],y
        sta aProcSystem.aBody1,b,x
        inc y
        lda [lR22],y
        sta aProcSystem.aBody1+1,b,x
        inc y
        lda [lR22],y
        sta aProcSystem.aBody2+1,b,x
        inc y
        lda [lR22],y
        sta aProcSystem.aBody3,b,x
        rep #$20
        inc y
        lda [lR22],y
        sta aProcSystem.aBody6,b,x
        inc y
        inc y
        lda [lR22],y
        sta aProcSystem.aBody7,b,x

        stz aProcSystem.aBody4,b,x
        stz aProcSystem.aBody5,b,x
        rtl

        .databank 0

      rlProcUnknown828BEACycle ; 82/8C38

        .al
        .autsiz
        .databank ?

        ldx aProcSystem.wOffset,b
        jsl rlUnknown91A4AC

        lda aProcSystem.aBody4,b,x
        cmp aProcSystem.aBody3,b,x
        bcs +

          inc a
          sta aProcSystem.aBody4,b,x
          rtl

        +
        lda aProcSystem.aBody5,b,x
        beq +

          sep #$20
          lda aProcSystem.aBody0,b,x
          sta lR18
          lda aProcSystem.aBody0+1,b,x
          sta lR18+1
          lda aProcSystem.aBody2,b,x
          sta lR18+2
          bra ++

          +
          sep #$20
          lda aProcSystem.aBody1,b,x
          sta lR18
          lda aProcSystem.aBody1+1,b,x
          sta lR18+1
          lda aProcSystem.aBody2+1,b,x
          sta lR18+2

        +
        rep #$20
        ldy aProcSystem.aBody6,b,x
        phy
        tya
        clc
        adc aProcSystem.aBody7,b,x
        sta wR0
        plx

          -
          lda [lR18],y
          sta aBGPaletteBuffer,x
          inc x
          inc x
          inc y
          inc y
          cpy wR0
          bcc -

        ldx aProcSystem.wOffset,b
        lda aProcSystem.aBody5,b,x
        eor #1
        sta aProcSystem.aBody5,b,x
        stz aProcSystem.aBody4,b,x
        rtl

        .databank 0

      aProcUnknown828BEACode ; 82/8CA1

        PROC_HALT

      procUnknown828CA3 ; 82/8CA3

        .structProcInfo "BM", rlProcUnknown828CA3Init, rlProcUnknown828CA3Cycle, aProcUnknown828CA3Code
        .word 0

      rlProcUnknown828CA3Init ; 82/8CAD

        .al
        .autsiz
        .databank ?

        sep #$20
        lda #$01
        ora bBufferTM
        sta bBufferTM
        lda #$01
        ora bBufferTMW
        sta bBufferTMW
        rep #$20

        stz aProcSystem.aBody0,b,x

        lda wMapScrollXPixels,b
        sta wBufferBG1HOFS
        lda wMapScrollYPixels,b
        sta wBufferBG1VOFS
        rtl

        .databank 0

      rlProcUnknown828CA3Cycle ; 82/8CCB

        .al
        .autsiz
        .databank ?

        lda aProcSystem.aBody0,b,x
        cmp #2
        beq _8D01

          cmp #1
          beq +

            lda bBufferINIDISP
            bit #$0080
            bne _8CF3

              ora #$0080
              sta bBufferINIDISP

              lda #1
              sta aProcSystem.aBody0,b,x
              bra _8D05

          +
          lda bBufferINIDISP
          eor #$0080
          sta bBufferINIDISP

          _8CF3
          phx
          jsl rlSetUpChapterMapDisplay
          plx
          lda #2
          sta aProcSystem.aBody0,b,x
          bra _8D05
        
        _8D01
        jsl rlContinueMapScroll

        _8D05
        ldx aProcSystem.wOffset,b
        jsl rlUnknown91A4AC
        bcc +

          jsr rsUnknown828D12

        +
        rtl

        .databank 0

      rsUnknown828D12 ; 82/8D12

        .al
        .autsiz
        .databank ?

        lda bBufferTM
        eor #$0001
        sta bBufferTM
        ldx aProcSystem.wOffset,b
        jsr rsProcCodeEnd

      aProcUnknown828CA3Code ; 82/8D1F

        PROC_HALT

        ; 82/8D21

    .endsection Unsorted828BF4Section


    .section Unsorted828D52Section

      .al
      .xl

      procUnknown828D52 ; 82/8D52

        .structProcInfo "MS", rlProcUnknown828D52Init, rlProcUnknown828D52Cycle, aProcUnknown828D52Code
        .word 0

      rlProcUnknown828D52Init ; 82/8D5C

        .al
        .autsiz
        .databank ?

        php
        rep #$30
        lda #0
        sta aProcSystem.aBody2,b,x
        ldy wActiveEventOffset,b
        lda [lR22],y
        sta aProcSystem.aBody0,b,x
        inc y
        inc y
        lda [lR22],y
        and #$00FF
        sta aProcSystem.aBody1,b,x
        jsr rsUnknown828E61
        bcs +

          lda #0
          sta aProcSystem.aBody1,b,x

        +
        plp
        rtl

        .databank 0

      rlProcUnknown828D52Cycle ; 82/8D84

        .al
        .autsiz
        .databank ?

        php
        phb
        lda wGameStateRoutine1,b
        cmp #GAMESTATE_MAP_STEP
        beq +

          cmp #GAMESTATE_WORLD_MAP_STEP
          bne _End

        +
        ldx aProcSystem.wOffset,b
        lda aProcSystem.aBody6,b,x
        inc a
        sta aProcSystem.aBody6,b,x
        cmp aProcSystem.aBody3,b,x
        beq _8DE8

        sta wR12
        lda #0
        sta wR13
        lda $175F,b
        sta wR10
        lda $1761,b
        sta wR11
        jsl rlUnsignedMultiply32By32

        ldx aProcSystem.wOffset,b
        lda wR15
        sec
        sbc aProcSystem.aBody5,b,x
        sta wMapScrollSpeed,b
        lda wR15
        sta aProcSystem.aBody5,b,x

        lda aProcSystem.aBody7,b,x
        sta wR0

        lda wR0
        cmp #9
        bmi +

          -
          bra -

        +
        asl a
        tax
        jsr (aUnknown828E1F,x)

        lda wMapScrollXPixels,b
        sta wBufferBG1HOFS
        lda wMapScrollYPixels,b
        sta wBufferBG1VOFS

        _End
        plb
        plp
        rtl

        _8DE8
        lda aProcSystem.aBody4,b,x
        sec
        sbc aProcSystem.aBody5,b,x
        sta wMapScrollSpeed,b

        lda aProcSystem.aBody7,b,x
        sta wR0

        lda wR0
        cmp #9
        bmi +

          -
          bra -

        +
        asl a
        tax
        jsr (aUnknown828E1F,x)
        jsr rsUnknown828E61
        bcs _End

        jsl rlCheckPointInScreenMargins
        bcc +

          lda #$0080
          sta wCursorXOffset,b
          sta wCursorYOffset,b

        +
        jsl rlEventEngineFreeProc
        bra _End

        .databank 0

      aUnknown828E1F ; 82/8E1F

        .addr rsUnknown828E31
        .addr rsUnknown828E36
        .addr rsUnknown828E3B
        .addr rsUnknown828E40
        .addr rsUnknown828E45
        .addr rsUnknown828E4A
        .addr rsUnknown828E4F
        .addr rsUnknown828E54
        .addr rsUnknown828E59

      rsUnknown828E31 ; 82/8E31

        .al
        .autsiz
        .databank ?

        jsl rlStartMapScrollUp
        rts
 
        .databank 0

      rsUnknown828E36 ; 82/8E36

        .al
        .autsiz
        .databank ?

        jsl rlStartMapScrollDown
        rts

        .databank 0

      rsUnknown828E3B ; 82/8E3B

        .al
        .autsiz
        .databank ?

        jsl rlStartMapScrollLeft
        rts

        .databank 0

      rsUnknown828E40 ; 82/8E40

        .al
        .autsiz
        .databank ?

        jsl rlStartMapScrollRight
        rts

        .databank 0

      rsUnknown828E45 ; 82/8E45

        .al
        .autsiz
        .databank ?

        jsl rlStartMapScrollUpLeft
        rts

        .databank 0

      rsUnknown828E4A ; 82/8E4A

        .al
        .autsiz
        .databank ?

        jsl rlStartMapScrollDownLeft
        rts

        .databank 0

      rsUnknown828E4F ; 82/8E4F

        .al
        .autsiz
        .databank ?

        jsl rlStartMapScrollUpRight
        rts

        .databank 0

      rsUnknown828E54 ; 82/8E54

        .al
        .autsiz
        .databank ?

        jsl rlStartMapScrollDownRight
        rts

        .databank 0

      rsUnknown828E59 ; 82/8E59

        .al
        .autsiz
        .databank ?

        jsl rlUnknown828E5E
        rts

        .databank 0

      rlUnknown828E5E ; 82/8E5E

        .al
        .autsiz
        .databank ?

        rtl

        .databank 0

      aProcUnknown828D52Code ; 82/8E5F

        PROC_HALT

    .endsection Unsorted828D52Section


    .section Unsorted828E61Section

      .as
      .xl

      rsUnknown828E61 ; 82/8E61

        .al
        .autsiz
        .databank ?

        php
        rep #$30
        ldx aProcSystem.wOffset,b
        lda aProcSystem.aBody1,b,x
        xba
        sta lR18+1
        lda aProcSystem.aBody0,b,x
        sta lR18
        ldy aProcSystem.aBody2,b,x

        lda [lR18],y
        cmp #$00FF
        beq _CLC

          lda [lR18],y
          sta aProcSystem.aBody7,b,x
          inc y
          inc y
          lda [lR18],y
          sta aProcSystem.aBody4,b,x
          sta wR13
          inc y
          inc y
          lda [lR18],y
          sta aProcSystem.aBody3,b,x
          sta wR14

          lda aProcSystem.aBody7,b,x
          cmp #8
          bne +

            stz aProcSystem.aBody4,b,x

          +
          inc y
          inc y
          tya
          sta aProcSystem.aBody2,b,x
          lda #0
          sta wR12
          sta wR15
          jsl rlUnsignedDivide32By32

          lda wR12
          sta $175F,b
          lda wR13
          sta $1761,b
          ldx aProcSystem.wOffset,b
          lda #0
          sta aProcSystem.aBody5,b,x
          sta aProcSystem.aBody6,b,x
          plp
          sec
          rts

        _CLC
        plp
        clc
        rts

        .databank 0

    .endsection Unsorted828E61Section


    .section Unsorted828ECBSection

      .al
      .xl

      procUnknown828ECB ; 82/8ECB

        .structProcInfo "CM", rlProcUnknown828ECBInit, rlProcUnknown828ECBCycle, aProcUnknown828ECBCode
        .word 0

      rlProcUnknown828ECBInit ; 82/8ED5

        .al
        .autsiz
        .databank ?

        sep #$20
        lda #$01
        ora bBufferTM
        sta bBufferTM
        lda #$01
        ora bBufferTMW
        sta bBufferTMW
        rep #$20
        stz aProcSystem.aBody0,b,x
        rtl

        .databank 0

      rlProcUnknown828ECBCycle ; 82/8EE9

        .al
        .autsiz
        .databank ?

        lda aProcSystem.aBody0,b,x
        cmp #2
        beq _8F1F

          cmp #1
          beq +

            lda bBufferINIDISP
            bit #$0080
            bne _8F11

              ora #$0080
              sta bBufferINIDISP

              lda #1
              sta aProcSystem.aBody0,b,x
              bra _8F23

          +
          lda bBufferINIDISP
          eor #$0080
          sta bBufferINIDISP

          _8F11
          phx
          jsl rlMapEmptyRoutine
          plx
          lda #2
          sta aProcSystem.aBody0,b,x
          bra _8F23

        _8F1F
        jsl rlUnknown80B63F

        _8F23
        ldx aProcSystem.wOffset,b
        jsl rlUnknown91A4AC
        bcc +

          jsr rsUnknown828F30

        +
        rtl

        .databank 0

      rsUnknown828F30 ; 82/8F30

        .al
        .autsiz
        .databank ?

        lda bBufferTM
        eor #$0001
        sta bBufferTM
        ldx aProcSystem.wOffset,b
        jsr rsProcCodeEnd

        .databank 0

      aProcUnknown828ECBCode ; 82/8F3D

        PROC_HALT

        ; 82/8F3F

    .endsection Unsorted828ECBSection


    .section Unsorted829245Section

      .al
      .xl

      procUnknown829245 ; 82/9245

        .structProcInfo "e0", rlProcUnknown829245Init, rlProcUnknown829245Cycle, aProcUnknown829245Code
        .word 2

      rlProcUnknown829245Init ; 82/924F

        .al
        .autsiz
        .databank ?

        rtl

        .databank 0

      rlProcUnknown829245Cycle ; 82/9250

        .al
        .autsiz
        .databank ?

        lda wJoy1New
        bit #JOY_ABXY
        beq +

          jsl rlEventEngineFreeProc

        +
        rtl

        .databank 0

      aProcUnknown829245Code ; 82/925C

        PROC_HALT

      procUnknown82925E ; 82/925E

        .structProcInfo "e0", rlProcUnknown82925EInit, rlProcUnknown82925ECycle, aProcUnknown82925ECode
        .word 2

      rlProcUnknown82925EInit ; 82/9268

        .al
        .autsiz
        .databank ?

        ldy wActiveEventOffset,b
        lda [lR22],y
        sta aProcSystem.aBody0,b,x
        rtl

        .databank 0

      rlProcUnknown82925ECycle ; 82/9271

        .al
        .autsiz
        .databank ?

        dec aProcSystem.aBody0,b,x
        beq +

          lda wJoy1New
          bit #JOY_ABXY
          bne +

            rtl

        +
        jsl rlEventEngineFreeProc
        rtl

        .databank 0

      aProcUnknown82925ECode ; 82/9283

        PROC_HALT

    .endsection Unsorted829245Section


    .section Unsorted8292A9Section

      .al
      .xl

      procUnknown8292A9 ; 82/92A9

        .structProcInfo "NP", rlProcUnknown8292A9Init, rlProcUnknown8292A9Init, aProcUnknown8292A9Code
        .word 0

    .endsection Unsorted8292A9Section


    .section Unsorted8292B3Section

      .al
      .xl

      rlProcUnknown8292A9Init ; 82/92B3

        .al
        .autsiz
        .databank ?

        rtl

        .databank 0

      aProcUnknown8292A9Code ; 82/92B4

        PROC_END

      procUnknown8292B6 ; 82/92B6

        .structProcInfo "RS", rlProcUnknown8292B6Init, rlProcUnknown8292B6Cycle, aProcUnknown8292B6Code ; 82/92A9
        .word 0

      rlProcUnknown8292B6Init ; 82/92C0

        .al
        .autsiz
        .databank ?

        php
        ldy wActiveEventOffset,b
        lda [lR22],y
        sta aProcSystem.aBody0,b,x
        inc y
        lda [lR22],y
        sta aProcSystem.aBody1,b,x
        inc y
        inc y
        lda [lR22],y
        and #$00FF
        sta aProcSystem.aBody2,b,x
        cmp #$00FF
        bne +

          ldx aProcSystem.wOffset,b
          jsl rlUnknown91A4AC

        +
        lda #$FFFF
        sta aProcSystem.aBody5,b,x
        plp
        rtl

        .databank 0

      rlProcUnknown8292B6Cycle ; 82/92ED

        .al
        .autsiz
        .databank ?

        php
        jsr rsUnknown829306
        bcc +

          jsr rsUnknown82932C
          bcc +

            lda #0
            sta aProcSystem.aBody2,b,x
            jsl rlEventEngineFreeProc

        +
        plp
        rtl

        .databank 0

      aProcUnknown8292B6Code ; 82/9304

        PROC_HALT

      rsUnknown829306 ; 82/9306

        .al
        .autsiz
        .databank ?

        php
        phx
        lda aProcSystem.aBody5,b,x
        cmp #$FFFE
        beq _SEC

          cmp #$FFFF
          bne +

            dec a
            sta aProcSystem.aBody5,b,x
            bra _CLC

          +
          tax
          lda aProcSystem.aHeaderBitfield,b,x
          bit #$2000
          bne _SEC

          _CLC
          plx
          plp
          clc
          rts
        
        _SEC
        plx
        plp
        sec
        rts

        .databank 0

    .endsection Unsorted8292B3Section


    .section Unsorted82932CSection

      .al
      .xl

      rsUnknown82932C ; 82/932C

        .al
        .autsiz
        .databank ?

        php
        lda aProcSystem.aBody2,b,x
        beq _SEC

          cmp #$00FF
          beq +

            dec a
            sta aProcSystem.aBody2,b,x

          +
          lda lActiveEventPointer,b
          sta aProcSystem.aBody3,b,x
          lda wActiveEventOffset,b
          sta aProcSystem.aBody4,b,x
          jsr rsUnknown829391

          ldy #0
          sty wActiveEventOffset,b
          lda lActiveEventPointer+1,b
          sta @l lR22+1
          lda aProcSystem.aBody0,b,x
          sta lActiveEventPointer,b
          sta @l lR22
          phx

          lda [lR22],y
          sta lR23
          inc y
          inc y
          sty wActiveEventOffset,b
          jsl rlUnknown91C6D8

          txa
          plx
          lda aProcSystem.aBody3,b,x
          sta lActiveEventPointer,b
          lda aProcSystem.aBody4,b,x
          sta wActiveEventOffset,b
          lda lActiveEventPointer+1,b
          sta @l lR22+1
          lda lActiveEventPointer,b
          sta @l lR22
          plp
          clc
          rts

        _SEC
        plp
        sec
        rts

        .databank 0

    .endsection Unsorted82932CSection


    .section Unsorted829391Section

      .al
      .xl

      rsUnknown829391 ; 82/9391

        .al
        .autsiz
        .databank ?

        ; Store first free proc offset into aBody5

        phx
        ldx #$001E

        -
        lda aProcSystem.aHeaderTypeOffset,b,x
        beq _CLC

          dec x
          dec x
          bpl -

          lda #$FFFF
          plx
          sta aProcSystem.aBody5,b,x
          sec
          rts

        _CLC
        txa
        plx
        sta aProcSystem.aBody5,b,x
        clc
        rts

        .databank 0

      procUnknown8293AE

        .structProcInfo "CC", rlProcUnknown8293AEInit, rlProcUnknown8293AECycle, aProcUnknown8293AECode ; 82/93AE
        .word 0

      rlProcUnknown8293AEInit ; 82/93B8

        .al
        .autsiz
        .databank ?

        ldy wActiveEventOffset,b
        lda [lR22],y
        sta aProcSystem.aBody0,b,x
        inc y
        lda [lR22],y
        and #$FF00
        sta aProcSystem.aBody2,b,x

        inc y
        inc y
        lda [lR22],y
        sta lR19
        inc y
        inc y

        sep #$20
        lda [lR22],y
        sta aProcSystem.aBody2,b,x
        sta lR19+2
        rep #$20

        lda [lR19]
        and #$00FF
        asl a
        sta aProcSystem.aBody5,b,x

        inc lR19
        lda [lR19]
        and #$00FF
        asl a
        sta aProcSystem.aBody6,b,x

        lda lR19
        inc a
        sta aProcSystem.aBody1,b,x

        stz aProcSystem.aBody3,b,x
        lda #1
        sta aProcSystem.aBody4,b,x

        ldx aProcSystem.wOffset,b
        jsl rlUnknown91A4AC
        rtl

        .databank 0

      rlProcUnknown8293AECycle ; 82/9407

        .al
        .autsiz
        .databank ?

        lda aProcSystem.aBody4,b,x
        dec a
        beq +

          sta aProcSystem.aBody4,b,x
          rtl

        +
        lda aProcSystem.aBody2,b,x
        sta lR18+1
        xba
        sta lR19+1

        lda aProcSystem.aBody0,b,x
        sta lR18
        lda aProcSystem.aBody1,b,x
        sta lR19

        lda aProcSystem.aBody3,b,x
        inc a
        inc a
        
          -
          sta aProcSystem.aBody3,b,x
          tay
          lda [lR19],y
          bit #$FF00
          bne +

            lda #0
            bra -

        +
        phx
        sep #$20
        xba
        sta aProcSystem.aBody4,b,x
        rep #$20
        xba
        and #$00FF
        asl a
        clc
        adc lR18
        sta lR18

        lda #0
        sta lR20+1

        lda #<>aBGPaletteBuffer
        clc
        adc aProcSystem.aBody5,b,x
        sta lR20

        lda aProcSystem.aBody6,b,x
        tay

          -
          lda [lR18],y
          sta [lR20],y
          dec y
          dec y
          bne -

        plx
        rtl

        .databank 0

      aProcUnknown8293AECode ; 82/9467

        PROC_HALT

        ; 82/9469

    .endsection Unsorted829391Section


    .section Unreferenced829469Section

      .al
      .xl

      rlUnknown829469 ; 82/9469

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #(`procUnknown828B09)<<8
        sta lR44+1
        lda #<>procUnknown828B09
        sta lR44
        jsl rlEventEngineCreateProc
        rtl

        .databank 0

        ; 82/9478

    .endsection Unreferenced829469Section
    .section Unsorted82E08DSection

      .al
      .xl

      rlUnknown82E08D ; 82/E08D

        .al
        .xl
        .autsiz
        .databank ?

        sei
        phb
        php
        phk
        plb
        .databank $82
        sep #$20
        lda bBufferNMITIMEN
        ora #$30
        sta bBufferNMITIMEN
        rep #$20
        lda #$8000
        trb $168F,b
        jsl rlUnknown82E147
        lda #<>rsIRQEngineCycle
        sta wIRQPointer
        plp
        plb
        .databank $82
        cli
        rtl

        .databank 0

        ; 82/E0AF

    .endsection Unsorted82E08DSection


    .section Unsorted82E0C6Section

      .al
      .xl

      rlUnknown82E0C6 ; 82/E0C6

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $82
        phx
        ldy lR44
        sep #$20
        lda lR44+2
        pha
        rep #$20
        plb
        .databank ?
        lda $1695,b
        cmp #$0007
        bcc _E0E2
        plx
        plp
        plb
        .databank ?
        sec
        rtl


        _E0E2
        lda $1695,b
        asl a
        tax
        tya
        sta $169A,b,x
        lda lR44+1
        and #$FF00
        xba
        sta $16AA,b,x
        lda #$0000
        sta $16BA,b,x
        lda $0000,b,y
        sta $16CA,b,x
        lda $0002,b,y
        sta $16DA,b,x
        lda $0004,b,y
        sta $16EA,b,x
        lda $0006,b,y
        sta $16FA,b,x
        lda #$0001
        sta $170A,b,x
        inc $1695,b
        plx
        plp
        plb
        .databank ?
        clc
        rtl

        .databank 0

        ; 82/E120

    .endsection Unsorted82E0C6Section


    .section Unreferenced82E120Section

      .al
      .xl

      rlUnknown82E120 ; 82/E120

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $82
        ldx $1691,b
        stz $169A,b,x
        stz $16DA,b,x
        dec $1695,b
        plp
        plb
        .databank $82
        rtl

        .databank 0

        ; 82/E133

    .endsection Unreferenced82E120Section
    .section Unsorted82E147Section

      .al
      .xl

      rlUnknown82E147 ; 82/E147

        .al
        .xl
        .autsiz
        .databank ?

        sei
        phb
        php
        phk
        plb
        .databank $82
        lda $1695,b
        cmp $1693,b
        beq _E173
        sta $1693,b
        jsr rsUnknown82E177
        lda $1693,b
        beq _E16A
        dec a
        asl a
        sta $1691,b
        tax
        jsr rsUnknown82E283
        bra _E173


        _E16A
        lda #$0000
        sta $1697,b
        sta $1698,b

        _E173
        plp
        plb
        .databank $82
        cli
        rtl

        .databank 0

        ; 82/E177

      rsUnknown82E177 ; 82/E177

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $82
        phx
        phy
        lda $1693,b
        cmp #$0001
        beq _E1BA
        bcc _E1BA
        and #$FFFE
        sta wR30

        _E18C
        lda $1693,b
        asl a
        sec
        sbc wR30
        sta wR32
        stz wR31

        _E197
        lda wR30
        clc
        adc wR31
        tay
        ldx wR31
        lda $16DA,b,x
        cmp $16DA,b,y
        bcs _E1AA
        jsr rsUnknown82E1BF

        _E1AA
        inc wR31
        inc wR31
        lda wR31
        cmp wR32
        bcc _E197
        dec wR30
        dec wR30
        bne _E18C

        _E1BA
        ply
        plx
        plp
        plb
        .databank ?
        rts

        .databank 0

        ; 82/E1BF

      rsUnknown82E1BF ; 82/E1BF

        .al
        .xl
        .autsiz
        .databank ?

        lda $169A,b,x
        sta $16A8,b
        lda $16AA,b,x
        sta $16B8,b
        lda $16BA,b,x
        sta $16C8,b
        lda $16CA,b,x
        sta $16D8,b
        lda $16DA,b,x
        sta $16E8,b
        lda $16EA,b,x
        sta $16F8,b
        lda $16FA,b,x
        sta $1708,b
        lda $170A,b,x
        sta $1718,b
        lda $169A,b,y
        sta $169A,b,x
        lda $16AA,b,y
        sta $16AA,b,x
        lda $16BA,b,y
        sta $16BA,b,x
        lda $16CA,b,y
        sta $16CA,b,x
        lda $16DA,b,y
        sta $16DA,b,x
        lda $16EA,b,y
        sta $16EA,b,x
        lda $16FA,b,y
        sta $16FA,b,x
        lda $170A,b,y
        sta $170A,b,x
        lda $16A8,b
        sta $169A,b,y
        lda $16B8,b
        sta $16AA,b,y
        lda $16C8,b
        sta $16BA,b,y
        lda $16D8,b
        sta $16CA,b,y
        lda $16E8,b
        sta $16DA,b,y
        lda $16F8,b
        sta $16EA,b,y
        lda $1708,b
        sta $16FA,b,y
        lda $1718,b
        sta $170A,b,y
        rts

        .databank 0

        ; 82/E250

    .endsection Unsorted82E147Section


    .section Unsorted82E283Section

      .al
      .xl

      rsUnknown82E283 ; 82/E283

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda $16CB,b,x
        sta $4208,b
        lda $16CA,b,x
        sta $4207,b
        lda $16DB,b,x
        sta $420A,b
        lda $16DA,b,x
        sta $4209,b
        rep #$20
        lda $16AA,b,x
        xba
        sta $1698,b
        lda $16EA,b,x
        sta $1697,b
        rts

        .databank 0

        ; 82/E2AD

    .endsection Unsorted82E283Section


    .section Unsorted858728Section

      .al
      .xl

      rlUnknown858728 ; 85/8728

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        lda bMapMenuFlags,b
        bit #$0080
        beq _End

          bit #$0020
          bne _End

            lda wChapterFlags,b
            bit #$0001
            beq +

              jsr rsUnknown858D18
              lda #$0001
              trb wChapterFlags,b

            +
            jsl rlMapMenuVBlankUpload

        _End
        plp
        plb
        rtl

        .databank 0

        ; 85/8751

    .endsection Unsorted858728Section


    .section Unsorted858D18Section

      .al
      .xl

      rsUnknown858D18 ; 85/8D18

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $85
        lda wMapMenuDirtyTop,b
        cmp wMapMenuDirtyBottom,b
        bcs _8D5F
        lda wMapMenuDirtyTop,b
        cmp #$0020
        bcs _8D5F
        lda wMapMenuDirtyBottom,b
        cmp #$0020
        bcs _8D5F
        lda #$7E7B
        sta lR18+1
        lda wMapMenuDirtyTop,b
        xba
        lsr a
        lsr a
        pha
        clc
        adc #$7B88
        sta lR18
        lda wMapMenuDirtyBottom,b
        sec
        sbc wMapMenuDirtyTop,b
        inc a
        xba
        lsr a
        lsr a
        sta wR0
        pla
        lsr a
        clc
        adc #$5400
        sta wR1
        jsl rlDMAByPointer

        _8D5F
        plp
        plb
        .databank ?
        rts

        .databank 0

        ; 85/8D62

    .endsection Unsorted858D18Section


    .section Unsorted86C629Section

      .al
      .xl

      rlUnknown86C629 ; 86/C629

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $86
        phx
        phy
        jsl rlGetChapterMapChangesPointer
        lda lR18
        beq _C672
        ldy lR18
        sep #$20
        lda lR18+2
        pha
        rep #$20
        plb
        .databank ?
        ldx #$0000

        _C644
        lda $0000,b,y
        cmp #$FFFF
        beq _C672
        txa
        jsr rsUnknown86C677
        bcc _C669
        lda $0003,b,y
        and #$00FF
        sta wR0
        lda $0004,b,y
        and #$00FF
        sta wR1
        lda $0005,b,y
        jsl rlApplyMapTileChange

        _C669
        tya
        clc
        adc #$0007
        tay
        inc x
        bra _C644


        _C672
        ply
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 86/C677

      rsUnknown86C677 ; 86/C677

        .al
        .xl
        .autsiz
        .databank ?

        phb
        phk
        plb
        .databank $86
        phx
        phy
        pha
        lsr a
        lsr a
        lsr a
        tax
        pla
        and #$0007
        tay
        lda aChapterActiveMapChanges,x
        and #$00FF
        and $C69A,b,y
        bne _C695
        clc
        bra _C696


        _C695
        sec

        _C696
        ply
        plx
        plb
        .databank ?
        rts

        .databank 0

        ; 86/C69A

    .endsection Unsorted86C629Section


    .section Unsorted8B91F6Section

      .al
      .xl

      rlUnknown8B91F6 ; 8B/91F6

        .al
        .autsiz
        .databank ?

        lda #DialogueStatusPreventASpeedUp
        tsb aDialogue.wStatus,b

        lda #3
        sta aDialogue.wTextSpeed,b
        lda #2
        sta aDialogue.wTextSound,b

        lda wCurrentChapter,b
        cmp #-1
        bne +

          lda #4
          sta aDialogue.wUnknown00188C,b
          lda #6
          sta aDialogue.wTextSpeed,b
          lda #0
          sta aDialogue.wTextSound,b

        +
        lda #2
        sta aDialogue.wUnknown0018D0,b
        lda #(4 << 8 | 30)
        sta aDialogue._Slot[0].wDisplayArea,b,x
        lda #$9000 >> 1
        sta aDialogue._Slot[0].wVRAMAddress,b,x
        lda #(`aBG3TilemapBuffer)<<8
        sta aDialogue._Slot[0].lBGBufferPosition+1,b,x
        lda #<>aBG3TilemapBuffer
        sta aDialogue._Slot[0].lBGBufferPosition,b,x

        ; Is this supposed to be X indexed?
        lda #TilemapEntry($100, 0, true, false, false)
        sta aDialogue.wBaseTile,b,x
        lda #$1604
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
        rtl

        .databank 0

      rlUnknown8B9275 ; 8B/9275

        .al
        .autsiz
        .databank ?

        php
        lda #$7E00
        sta $24+1
        ldy #$FF00

        lda aDialogue.wFreeHDMATable,b
        and #$0001
        bne +

        ldy #$FF80
        
        +
        sty $24

        ldy #0
        lda $18D4,b
        sec
        sbc #$8388
        lsr a
        lsr a
        lsr a
        lsr a
        lsr a
        lsr a
        pha

        asl a
        asl a
        asl a
        cmp #$007F
        bcc +
        beq +

        pha
        lda $87
        sta $00
        lda $89
        sta $02
        lda #$007F
        jsl rlDialogueWriteHDMADataEntry
        pla
        sec
        sbc #$007F
        
        +
        pha
        lda $87
        sta $00
        lda $89
        sta $02
        pla
        jsl rlDialogueWriteHDMADataEntry
        jsl rlDialogueGetSlot1BoxPixelHeight
        sta $27
        sec
        sbc #$0010
        cmp $18E1,b
        bcs _9352

        sta $2D
        lda #$0100
        clc
        adc #0
        sta $00

        lda $27
        tax
        lda $18E1,b
        sec
        sbc $2D
        jsl rlUnknown91969C
        txa
        beq _9352

        sta $2A
        clc
        adc #0
        sta $02
        lda $27
        sec
        sbc $2A
        jsl rlDialogueWriteHDMADataEntry
        lda $2A
        cmp #$0010
        bcc +

        lda #$0100
        clc
        adc #0
        sta $00
        lda $2A
        sec
        sbc $27
        clc
        adc #0
        sta $02

        lda $2A
        and #$FFF0
        jsl rlDialogueWriteHDMADataEntry

        +
        lda $2A
        and #$000F
        sta $2A
        beq _9366
        
        -
        lda #$0100
        clc
        adc #0
        sta $00
        lda $2A
        sec
        sbc $27
        clc
        adc #0
        sta $02
        lda #1
        jsl rlDialogueWriteHDMADataEntry
        dec $2A
        bne -
        bra _9366
        
        _9352
        lda #$0100
        clc
        adc #0
        sta $00
        lda #0
        sta $02
        lda $27
        jsl rlDialogueWriteHDMADataEntry
        
        _9366
        pla
        clc
        adc $18DC,b
        sta $00

        lda aDialogue.wStatus,b
        bit #$1000
        bne +

        jml rlUnknown8B9275._942F
        
        +
        lda $18ED,b
        sec
        sbc #$8388
        lsr a
        lsr a
        lsr a
        lsr a
        lsr a
        lsr a
        sec
        sbc $00
        asl a
        asl a
        asl a
        pha
        lda $87
        sta $00
        lda $89
        sta $02
        pla
        jsl rlDialogueWriteHDMADataEntry
        jsl rlDialogueGetSlot2BoxPixelHeight
        sta $27
        sec
        sbc #$0010
        cmp $18FA,b
        bcs _941D

        sta $2D
        lda $87
        clc
        adc #0
        sta $00
        lda $27
        tax
        lda $18FA,b
        sec
        sbc $2D
        jsl rlUnknown91969C
        txa
        beq _941D

        sta $2A
        clc
        adc $89
        sta $02
        lda $27
        sec
        sbc $2A
        jsl rlDialogueWriteHDMADataEntry

        lda $2A
        cmp #$0010
        bcc +

        lda $87
        clc
        adc #0
        sta $00
        lda $2A
        sec
        sbc $27
        clc
        adc $89
        sta $02
        lda $2A
        and #$FFF0
        jsl rlDialogueWriteHDMADataEntry
        
        +
        lda $2A
        and #$000F
        sta $2A
        beq _942F
        
        -
        lda $87
        clc
        adc #0
        sta $00
        lda $2A
        sec
        sbc $27
        clc
        adc $89
        sta $02
        lda #1
        jsl rlDialogueWriteHDMADataEntry
        dec $2A
        bne -
        bra _942F
        
        _941D
        lda $87
        clc
        adc #0
        sta $00
        lda $89
        sta $02
        lda $27
        jsl rlDialogueWriteHDMADataEntry
        
        _942F
        lda #1
        pha
        lda #$0100
        sta $00
        lda #0
        sta $02
        pla
        jsl rlDialogueWriteHDMADataEntry
        lda #0
        sta [$24],y
        plp
        rtl

        .databank 0

        ; 8B/9449

    .endsection Unsorted8B91F6Section


    .section Unsorted91A7BCSection

      .al
      .xl

      rlUnknown91A7BC ; 91/A7BC

        .al
        .autsiz
        .databank ?

        ; A = fill value

        php
        ldx #$07FE

          -
          sta aBG3TilemapBuffer,x
          dec x
          dec x
          bpl -

        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0800, $80, $B000

        nop
        nop
        nop
        nop
        jsl rlDisableMapMenuUploads
        plp
        rtl

        .databank 0

    .endsection Unsorted91A7BCSection


    .section Unsorted91A7DFSection

      .al
      .xl

      rlUnknown91A7DF ; 91/A7DF

        .al
        .xl
        .autsiz
        .databank ?

        php
        rep #$30
        lda #$0084
        tsb bMapMenuFlags,b
        plp
        rtl

        .databank 0

        ; 91/A7EA

    .endsection Unsorted91A7DFSection


    .section Unreferenced91A7EASection

      .al
      .xl

      rlUnknown91A7EA ; 91/A7EA

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ldx #$001E

        _A7ED
        lda $0ED7,b,x
        cmp #$8865
        beq _A808
        lda #$FFFF
        sta wEventProcBanks,b,x
        lda $0ED7,b,x
        beq _A808
        phx
        txa
        lsr a
        jsl rlProcEngineFreeProcByIndex
        plx

        _A808
        dec x
        dec x
        bpl _A7ED
        rtl

        .databank 0

        ; 91/A80D

    .endsection Unreferenced91A7EASection
    .section Unsorted91A9BBSection

      .al
      .xl

      rlUnknown91A9BB ; 91/A9BB

        .al
        .autsiz
        .databank ?

        jsl rlLoadMapMenuData

        lda #$2000
        sta aCurrentTilemapInfo.wBaseTile,b
        lda #$00FF
        sta wMapMenuTransparentTile,b
        lda #$20FF
        sta wMapMenuClearTile,b
        jsl rlClearMapMenuTiles

        lda #(`aUnknown91A9E4)<<8
        sta lR18+1
        lda #<>aUnknown91A9E4
        sta lR18
        jsl rlDrawMapMenuSimpleFrame
        rtl

        .databank 0

      aUnknown91A9E4 ; 91/A9E4

        .word $6106
        .word $2107
        .word $2106
        .word $6108
        .word $2108
        .word $E106
        .word $A107

; 06 A1 85 06 A5 27 48 A5 28 48 A9 00 00 85 28 A9 08 00 85 27 A5 06 20 15 AA 20 6F AA 68 85 28 68 85 27 6B 08 DA 5A A0 00 00 85 1A A9 10 27

    .endsection Unsorted91A9BBSection


    .section Unsorted9EEC95Section

      .al
      .xl

      rlUnknown9EEC95 ; 9E/EC95

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`procUnknown9EECA4)<<8
        sta lR44+1
        lda #<>procUnknown9EECA4
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 9E/ECA4

    .endsection Unsorted9EEC95Section


    .section ProcScript9EECA4Section

      .al
      .xl

      procUnknown9EECA4 ; 9E/ECA4

        .structProcInfo "ON", rlProcUnknown9EECA4Init, rlProcUnknown9EECA4Cycle1, aProcUnknown9EECA4Code

    .endsection ProcScript9EECA4Section


    .section Unsorted9EECACSection

      .al
      .xl

      rlProcUnknown9EECA4Init ; 9E/ECAC

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        sep #$20
        lda #$00
        sta $7E4EA9
        rep #$20
        lda #$FFFF
        sta aActionStructUnit2
        lda aProcSystem.wInput0,b
        sta wR4
        sta wR6
        sta aMapAction.wXTilePosition
        lda aProcSystem.wInput1,b
        sta wR5
        sta wR7
        sta aMapAction.wYTilePosition
        ldx aProcSystem.wInput0,b
        ldy aProcSystem.wInput1,b
        lda aActionStructUnit1.UnitRAMPointer
        jsl rlUnknown9E8D25
        lda #$0000
        sta wMapMagicFlags
        lda wR1
        xba
        ora wR0
        sta wMapMagicTargetPixel
        lda #$0027
        sta wMapMagicEffect
        plx
        lda #$0000
        sta aProcSystem.aHeaderBitfield,b,x
        sta wMapMagicStart
        sta wMapMagicDone
        sta $7F4C07
        lda wGameStateRoutine1,b
        sta aProcSystem.aBody7,b,x
        stz wGameStateRoutine1,b
        sep #$20
        lda bBufferBG2SC
        sta $7F57EA
        lda #$5C
        sta bBufferBG2SC
        lda bBufferTM
        sta $7F57EC
        lda #$15
        sta bBufferTM
        rep #$20
        ply
        rtl

        .databank 0

        ; 9E/ED30

      rlProcUnknown9EECA4Cycle1 ; 9E/ED30

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 9E/ED31

    .endsection Unsorted9EECACSection


    .section ProcScript9EED31Section

      .al
      .xl

      aProcUnknown9EECA4Code ; 9E/ED31

        PROC_YIELD 1
        PROC_SET_ONCYCLE rlUnknown9EC9FD
        PROC_YIELD 16
        PROC_CALL rlUploadMapMagicBackgroundTiles
        PROC_YIELD 4
        PROC_CALL rlUploadMapMagicBackgroundTilemap
        PROC_YIELD 2
        PROC_CALL rlCopyMapMagicBackgroundColors
        PROC_YIELD 2
        PROC_CALL rlStartMapMagicEffect
        PROC_YIELD 16
        PROC_CALL rlUnknown9EED7C
        _ED5A
        PROC_YIELD 1
        PROC_CALL rlUnknown9EED84
        PROC_JUMP_IF_BITS_UNSET _ED5A, $0004
        PROC_CALL rlEndMapMagicEffect
        PROC_CALL rlRestoreMapMagicScreenRegisters
        PROC_YIELD 1
        PROC_CALL rlUnknown9EED9A
        PROC_YIELD 1
        PROC_END


        ; 9E/ED7C

    .endsection ProcScript9EED31Section


    .section Unsorted9EED7CSection

      .al
      .xl

      rlUnknown9EED7C ; 9E/ED7C

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0001
        sta wMapMagicStart
        rtl

        .databank 0

        ; 9E/ED84

      rlUnknown9EED84 ; 9E/ED84

        .al
        .xl
        .autsiz
        .databank ?

        lda wMapMagicDone
        beq _ED99
        lda #<>rlProcUnknown9EECA4Cycle1
        sta aProcSystem.aHeaderOnCycle,b,x
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0004
        sta aProcSystem.aHeaderBitfield,b,x

        _ED99
        rtl

        .databank 0

        ; 9E/ED9A

      rlUnknown9EED9A ; 9E/ED9A

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda $7F57EA
        sta bBufferBG2SC
        lda $7F57EC
        sta bBufferTM
        sta $7F57EC
        rep #$20
        lda aProcSystem.aBody7,b,x
        sta wGameStateRoutine1,b
        rtl

        .databank 0

        ; 9E/EDB5

    .endsection Unsorted9EED7CSection


