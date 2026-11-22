; The chapter event engine: chapter event RAM data, permanent and per-chapter event
; flags, running chapter opening and map events, and the event condition commands
; (fights, talks, interactions and so on).

    .section Table81B45BSection

      .al
      .xl

      aUnknown81B45B ; 81/B45B

        ; Read by rlUnknown81B43F.

        .byte $04, $08, $10, $20, $40, $80

        ; 81/B461

    .endsection Table81B45BSection


    .section Table81B47DSection

      .al
      .xl

      aUnknown81B47D ; 81/B47D

        ; Read by rlUnknown81B461.

        .byte $FB, $F7, $EF, $DF, $BF, $7F

        ; 81/B483

    .endsection Table81B47DSection


    .section EventEngineSection

      .al
      .xl

      aEventEngineVersion ; 86/8000

        .enc "screen"
        .text "VER 960402 2000"
        .byte 0

      rlUnknown868010 ; 86/8010

        .al
        .autsiz
        .databank ?

        rtl

        .databank 0

      rlUnknown868011 ; 86/8011

        .al
        .autsiz
        .databank ?

        stz $1753,b

        lda wJoy1Input
        bit #JOY_Start
        bne +

          inc wGameStateRoutine1,b
          stz wGameStateStep,b
          rtl
    
        +
        jsl rlProcEngineResetProcEngine
        stz wGameStateRoutine1,b

        lda #<>rsUnknown80F1D5
        sta aProcSystem.wInput0,b

        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

      rlUnknown86803E ; 86/803E

        .al
        .autsiz
        .databank ?

        lda wGameStateStep,b
        cmp #2
        bmi +
        
          -
          bra -

        +
        asl a
        tax
        jsr (aUnknown86804E,x)
        rtl

        .databank 0

      aUnknown86804E ; 86/804E

        .addr rsUnknown868052
        .addr rsUnknown86805D

      rsUnknown868052 ; 86/8052

        .al
        .autsiz
        .databank ?

        jsl rlUnknown9BFC8D
        bcs +

          rts

        +
        inc wGameStateStep,b
        rts

        .databank 0

      rsUnknown86805D ; 86/805D

        .al
        .autsiz
        .databank ?

        jsl rlProcEngineResetProcEngine
        stz wGameStateRoutine1,b

        lda #<>rsUnknown80C0B6
        sta aProcSystem.wInput0,b

        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        rts

        .databank 0

      rlInitiateChapterEventRAMData ; 86/8079

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb

        ldx #33

        sep #$20
        lda #0

          -
          sta bEventStatus,b,x
          dec x
          bpl -

        rep #$20

        ldx #size(aPermanentEventFlags) + size(aChapterEventRAMData) -1
        sep #$20
        lda #0
        
          -
          sta aPermanentEventFlags,x
          dec x
          bpl -

        rep #$20

        lda #0
        sta $7E52EE

        lda #(`aChapterEventRAMData)<<8
        sta lR18+1
        lda #<>aChapterEventRAMData
        sta lR18
        lda #len(aChapterEventRAMData._Entry)
        sta wR0
        lda #size(aChapterEventRAMData._Entry[0])
        sta wR1
        jsl rlBuildRAMStructHeader

        plp
        plb
        rtl

        .databank 0

      rlSetPermanentEventFlag ; 86/80BE

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        phy
        cmp #256
        bcs +

          pha

          lsr a
          lsr a
          lsr a
          tay

          sep #$20
          lda #`aPermanentEventFlags
          pha
          rep #$20
          plb

          .databank `aPermanentEventFlags

          pla
          and #$0007
          tax
          sep #$20
          lda aPermanentEventFlags,y
          ora aSetPermanentEventFlagMask,x
          sta aPermanentEventFlags,y
          rep #$20

        +
        ply
        plx
        plp
        plb
        rtl

        .databank 0

      aSetPermanentEventFlagMask ; 86/80EE

        .byte $01
        .byte $02
        .byte $04
        .byte $08
        .byte $10
        .byte $20
        .byte $40
        .byte $80

      rlUnsetPermanentEventFlag ; 86/80F6

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        phy
        cmp #256
        bcs +

          pha

          lsr a
          lsr a
          lsr a
          tay

          sep #$20
          lda #`aPermanentEventFlags
          pha
          rep #$20
          plb

          .databank `aPermanentEventFlags

          pla
          and #$0007
          tax
          sep #$20
          lda aPermanentEventFlags,y
          and aUnsetPermanentEventFlagMask,x
          sta aPermanentEventFlags,y
          rep #$20

        +
        ply
        plx
        plp
        plb
        rtl

        .databank 0

      aUnsetPermanentEventFlagMask ; 86/8126

        .byte $FE
        .byte $FD
        .byte $FB
        .byte $F7
        .byte $EF
        .byte $DF
        .byte $BF
        .byte $7F

      rlCheckPermanentEventFlagSet ; 86/812E

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        phy
        cmp #256
        bcs +

          pha

          lsr a
          lsr a
          lsr a
          tay

          sep #$20
          lda #`aPermanentEventFlags
          pha
          rep #$20
          plb

          .databank `aPermanentEventFlags

          pla
          and #$0007
          tax
          lda aPermanentEventFlags,y
          and #$00FF
          and aCheckPermanentEventFlagSetMask,x
          bne ++

        +
        ply
        plx
        plp
        plb
        clc
        rtl
        
        +
        ply
        plx
        plp
        plb
        sec
        rtl

        .databank 0

      aCheckPermanentEventFlagSetMask ; 86/8163

        .byte $01
        .byte $02
        .byte $04
        .byte $08
        .byte $10
        .byte $20
        .byte $40
        .byte $80

      rlUnknown86816B ; 86/816B

        .al
        .autsiz
        .databank ?

        lda $0000,b,y
        cmp #$FFFF
        beq +

          jsr rsRunEventConditionCommand

        +
        rtl

        .databank 0

      rlBeginChapterEvents ; 86/8177

        .al
        .autsiz
        .databank ?

        ; Creates a struct in RAM with the header data, grabs the opening
        ; event pointer and runs it.

        ; Input:
        ; lR18 = Chapter event header pointer

        phb
        php
        phk
        plb
        phy

        lda #1
        tsb bEventStatus,b

        lda #(`aChapterEventRAMData)<<8
        sta lStructPointer2+1,b
        lda #<>aChapterEventRAMData
        sta lStructPointer2,b
        lda #(`aDefaultChapterRAMData)<<8
        sta lStructPointer1+1,b
        lda #<>aDefaultChapterRAMData
        sta lStructPointer1,b
        jsl rlAppendNewStructEntry

        jsl rlGetLatestStructEntryPointer

        ldy lStructPointer1,b

        sep #$20
        lda lStructPointer1+2,b
        pha
        rep #$20
        plb

        lda [lR18]
        sta structChapterEventRAMEntry.Chapter,b,y
        lda lR18
        sta structChapterEventRAMEntry.EventPointer,b,y
        lda lR18+1
        sta structChapterEventRAMEntry.EventPointer+1,b,y

        phk
        plb

        lda lStructPointer1+1,b
        sta lChapterEventRAMDataEntryPointer+1,b
        lda lStructPointer1,b
        sta lChapterEventRAMDataEntryPointer,b
        jsl rlRunChapterOpeningEvents

        lda #1
        trb bEventStatus,b

        lda wUnknown00171A,b
        bit #$0008
        bne +

        ply
        plp
        plb
        clc

        -
        rtl

        +
        ply
        plp
        plb
        sec
        bra -

        .databank 0

      aDefaultChapterRAMData ; 86/81E8

        .word 0
        .long 0
        .word 0
        .fill 10, 0

      rlRemoveChapterRAMStruct ; 86/81F9

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb

        jsl rlGetSpecifiedChaptersRAMPointer
        bcs +

          sta wStructIndex,b
          lda #(`aChapterEventRAMData)<<8
          sta lStructPointer2+1,b
          lda #<>aChapterEventRAMData
          sta lStructPointer2,b
          jsl rlRemoveRAMStructEntryByID

          plp
          plb
          clc
          rtl

        +
        plp
        plb
        sec
        rtl

        .databank 0

      rlUnknown86821E ; 86/821E

        .al
        .autsiz
        .databank ?

        rtl

        .databank 0

      rlGetSpecifiedChaptersRAMPointer ; 86/821F

        .al
        .autsiz
        .databank ?

        ; I assume they were planning on leaving all chapter RAM data, so
        ; they could check temp flags in later chapters. Or the planned on a free roam mode like Gaiden
        ; and didnt want you to trigger eg. Ch1s brave axe event if you are currently in a Ch5 state.
        ; This routine is mostly useless and will only get the active chapters pointer back.
        ; If the specified chapter matches the current one, return CLC, else SEC.
        ; Always fills lChapterEventRAMDataEntryPointer

        ; Input:
        ; A = ChapterID

        phb
        php
        phk
        plb
        phx

        sta wEventEngineParameter3,b
        lda #(`aChapterEventRAMData)<<8
        sta lStructPointer2+1,b
        lda #<>aChapterEventRAMData
        sta lStructPointer2,b
        ldx #1

        -
        stx wStructIndex,b

        jsl rlGetRAMStructEntryPointerByStructIndex
        bcs _SEC

        lda lStructPointer1,b
        sta lChapterEventRAMDataEntryPointer,b
        lda lStructPointer1+1,b
        sta lChapterEventRAMDataEntryPointer+1,b
        jsl rlGetEventChapterID
        cmp wEventEngineParameter3,b
        beq _CLC

        inc x
        bra -

        _SEC
        lda #0
        plx
        plp
        plb
        sec
        
        -
        rtl
        
        _CLC
        txa
        plx
        plp
        plb
        clc
        bra -

        .databank 0

      rlGetChapterEventRAMEntryPointerByID ; 86/8266

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb

        sta wStructIndex,b
        lda #(`aChapterEventRAMData)<<8
        sta lStructPointer2+1,b
        lda #<>aChapterEventRAMData
        sta lStructPointer2,b
        jsl rlGetRAMStructEntryPointerByStructIndex
        bcs _SEC

        lda lStructPointer1,b
        sta lChapterEventRAMDataEntryPointer,b
        lda lStructPointer1+1,b
        sta lChapterEventRAMDataEntryPointer+1,b
        plp
        plb
        clc
        
        -
        rtl
        
        _SEC
        plp
        plb
        sec
        bra -

        .databank 0

      rlCheckIfEventFlagOfSpecifiedChapterSet ; 86/8294

        .al
        .autsiz
        .databank ?

        ; Accessing anything but the current chapter doesn't work with this. Thanks FE4

        ; Input:
        ; A = ChapterID
        ; wEventEngineParameter1 = EventFlag

        phb
        php
        phk
        plb
        jsl rlGetSpecifiedChaptersRAMPointer
        bcs ++

          lda wEventEngineParameter1,b
          jsl rlCheckEventFlagSet
          bcc +

            lda #0
            plp
            plb
            sec
            rtl

          +
          lda #0
          plp
          plb
          clc
          rtl

        +
        lda #$FFFF
        plp
        plb
        clc
        rtl

        .databank 0

      rlGetAndRunChapterMapEventConditions ; 86/82BC

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb

        lda lStructPointer1,b
        pha
        lda lStructPointer1+1,b
        pha
        phx

        lda bEventStatus,b
        bit #$0003
        bne _CLC

        lda #2
        tsb bEventStatus,b

        ldx #1

        -
        lda #(`aChapterEventRAMData)<<8
        sta lStructPointer2+1,b
        lda #<>aChapterEventRAMData
        sta lStructPointer2,b
        stx wStructIndex,b
        jsl rlGetRAMStructEntryPointerByStructIndex
        bcs +

          lda lStructPointer1,b
          sta lChapterEventRAMDataEntryPointer,b
          lda lStructPointer1+1,b
          sta lChapterEventRAMDataEntryPointer+1,b
          jsl rlRunChapterMapEventConditions
          inc x
          bra -

        +
        lda #2
        trb bEventStatus,b

        lda wUnknown00171A,b
        bit #$0008
        bne _SEC
        
        _CLC
        plx
        pla
        sta lStructPointer1+1,b
        pla
        sta lStructPointer1,b
        plp
        plb
        clc
        
        -
        rtl
        
        _SEC
        plx
        pla
        sta lStructPointer1+1,b
        pla
        sta lStructPointer1,b
        plp
        plb
        sec
        bra -

        .databank 0

      rlUnknown86832B ; 86/832B

        .al
        .autsiz
        .databank ?

        jsl rlGetEventChapterID
        jsl rlRemoveChapterRAMStruct
        rtl

        .databank 0

      rlGetCurrentEventPointer ; 86/8334

        .al
        .autsiz
        .databank ?

        ; Input:
        ; lChapterEventRAMDataEntryPointer

        phb
        php
        phk
        plb
        phy

        ldy lChapterEventRAMDataEntryPointer,b

        sep #$20
        lda lChapterEventRAMDataEntryPointer+2,b
        pha
        rep #$20
        plb

        lda structChapterEventRAMEntry.EventPointer,b,y
        sta lEventPointer
        lda structChapterEventRAMEntry.EventPointer+1,b,y
        sta lEventPointer+1

        ply
        plp
        plb
        rtl

        .databank 0

      rlGetEventChapterID ; 86/8357

        .al
        .autsiz
        .databank ?

        ; Input:
        ; lChapterEventRAMDataEntryPointer

        phb
        php
        phk
        plb
        phy
        ldy lChapterEventRAMDataEntryPointer,b

        sep #$20
        lda lChapterEventRAMDataEntryPointer+2,b
        pha
        rep #$20
        plb

        lda structChapterEventRAMEntry.Chapter,b,y
        ply
        plp
        plb
        rtl

        .databank 0

      rlRunChapterOpeningEvents ; 86/836F

        .al
        .autsiz
        .databank ?

        ; Input:
        ; lChapterEventRAMDataEntryPointer

        phb
        php
        phk
        plb
        phx
        phy
        jsl rlGetCurrentEventPointer

        ldx lEventPointer,b

        sep #$20
        lda lEventPointer+2,b
        pha
        rep #$20
        plb

        lda structChapterEventHeader.OpeningEvents,b,x
        tay

        sep #$20
        lda structChapterEventHeader.OpeningEvents+2,b,x
        pha
        rep #$20
        plb

        jsl rlRunChapterEventConditions

        ply
        plx
        plp
        plb
        rtl

        .databank 0

      rlRunChapterMapEventConditions ; 86/839B

        .al
        .autsiz
        .databank ?

        ; Input:
        ; lChapterEventRAMDataEntryPointer

        phb
        php
        phk
        plb
        phx
        phy

        jsl rlGetCurrentEventPointer

        ldx lEventPointer,b

        sep #$20
        lda lEventPointer+2,b
        pha
        rep #$20
        plb

        lda structChapterEventHeader.MapEvents,b,x

        tay
        sep #$20
        lda structChapterEventHeader.MapEvents+2,b,x
        pha
        rep #$20
        plb

        jsl rlRunChapterEventConditions

        ply
        plx
        plp
        plb
        rtl

        .databank 0

      rlUnknown8683C7 ; 86/83C7

        .al
        .autsiz
        .databank ?

        phx
        jsl rlGetCurrentEventPointer
        ldx #<>lEventPointer
        lda #8
        jsl rlUnknown80A861
        plx
        rtl

        .databank 0

      rlRunChapterEventConditions ; 86/83D8

        .al
        .autsiz
        .databank ?

        -
        lda $0000,b,y
        cmp #$FFFF
        beq +

          jsr rsRunEventConditionCommand
          bra -

        +
        rtl

        .databank 0

      rsRunEventConditionCommand ; 86/83E6

        .al
        .autsiz
        .databank ?

        inc y
        and #$00FF
        asl a
        tax
        clc
        jmp (aChapterEventConditionCommands,x)

        .databank 0

      rsTrySkipEventConditionCommand ; 86/83F0

        .al
        .autsiz
        .databank ?

        inc y
        and #$00FF
        asl a
        tax
        sec
        jmp (aChapterEventConditionCommands,x)

        .databank 0

      aChapterEventConditionCommands ; 86/83FA

        .word <>rsChapterEventConditionCommand00
        .word <>rsChapterEventConditionCommandStartPlayerPhase
        .word <>rsChapterEventConditionCommandCheckSeizingCastle
        .word <>rsChapterEventConditionCommandCheckVillageDestroyed
        .word <>rsChapterEventConditionCommandCheckTalk
        .word <>rsChapterEventConditionCommandCheckEnteringHomeCastle
        .word <>rsChapterEventConditionCommand06
        .word <>rsChapterEventConditionCommandCheckEnteringCastleMenu
        .word <>rsChapterEventConditionCommand08
        .word <>rsChapterEventConditionCommand09
        .word <>rsChapterEventConditionCommandVisitVillage
        .word <>rsChapterEventConditionCommandCheckUnitInArea
        .word <>rsChapterEventConditionCommandCheckUnitsWithinDistance
        .word <>rsChapterEventConditionCommandCheckUnitsFighting
        .word <>rsChapterEventConditionCommandCheckUnitsFighting1to2range
        .word <>rsChapterEventConditionCommandCheckUnitDied
        .word <>rsChapterEventConditionCommandCheckFellInLove
        .word <>rsChapterEventConditionCommand11
        .word <>rsChapterEventConditionCommand12
        .word <>rsChapterEventConditionCommandCheckChildEnteringHomeCastle
        .word <>rsChapterEventConditionCommandCheckChildEnteringCastleMenu
        .word <>rsChapterEventConditionCommand15
        .word <>rsChapterEventConditionCommandCheckChildTalk
        .word <>rsChapterEventConditionCommandCheckChildUnitDied
        .word <>rsChapterEventConditionCommandCheckChildFellInLove
        .word <>rsChapterEventConditionCommandCheckChildUnitsFighting
        .word <>rsChapterEventConditionCommandCheckUnitDiedTo
        .word <>rsChapterEventConditionCommandCheckChildUnitDiedTo
        .word <>rsChapterEventConditionCommandRescueCivilian
        .word <>rsChapterEventConditionCommandCheckPlayerUncapturedIfSeizing
        .word <>rsChapterEventConditionCommandCheckWonInArena
        .word <>rsChapterEventConditionCommandCheckSpecialCrit
        .word <>rsChapterEventConditionCommandBreak
        .word <>rsChapterEventConditionCommandCheckTurnPhaseAIActor
        .word <>rsChapterEventConditionCommandSkipIfStartPlayerPhase
        .word <>rsChapterEventConditionCommand23
        .word <>rsChapterEventConditionCommand24
        .word <>rsChapterEventConditionCommandBreak ; $25
        .word <>rsChapterEventConditionCommandRunASM
        .word <>rsChapterEventConditionCommandSetFlag
        .word <>rsChapterEventConditionCommandUnsetFlag
        .word <>rsChapterEventConditionCommandCheckFlagSet
        .word <>rsChapterEventConditionCommandCheckFlagUnset
        .word <>rsChapterEventConditionCommandJump
        .word <>rsChapterEventConditionCommandCheckAllFlagsInListSet
        .word <>rsChapterEventConditionCommandCheckFlagInListSet
        .word <>rsChapterEventConditionCommandBreak ; $2E
        .word <>rsChapterEventConditionCommand2F ; $2F
        .word <>rsChapterEventConditionCommandEvent
        .word <>rsChapterEventConditionCommandSetBattleOrDeathQuote
        .word <>rsChapterEventConditionCommandSetPrecombatDialogue
        .word <>rsChapterEventConditionCommandRemoveCurrentChapterStruct
        .word <>rsChapterEventConditionCommandRemoveChapterStruct
        .word <>rsChapterEventConditionCommand35
        .word <>rsChapterEventConditionCommandSetPermanentFlag
        .word <>rsChapterEventConditionCommandUnsetPermanentFlag
        .word <>rsChapterEventConditionCommandCheckPermanentFlagSet
        .word <>rsChapterEventConditionCommandCheckPermanentFlagUnset
        .word <>rsChapterEventConditionCommandCheckAllPermanentFlagsInListSet
        .word <>rsChapterEventConditionCommandSetChapterEventCounter
        .word <>rsChapterEventConditionCommandAddChapterEventCounter
        .word <>rsChapterEventConditionCommandIncrementChapterEventCounter
        .word <>rsChapterEventConditionCommandDecrementChapterEventCounter
        .word <>rsChapterEventConditionCommandCheckChapterEventCounterEqual
        .word <>rsChapterEventConditionCommandCheckChapterEventCounterNotEqual
        .word <>rsChapterEventConditionCommandCheckIfInHomeCastle
        .word <>rsChapterEventConditionCommandCheckItemUnobtained
        .word <>rsChapterEventConditionCommandCheckNoCastleDestroyed
        .word <>rsChapterEventConditionCommandCheckEveryoneInFactionDead
        .word <>rsChapterEventConditionCommandCheckUnitsMarried
        .word <>rsChapterEventConditionCommandCheckUnitAlive
        .word <>rsChapterEventConditionCommandCheckFathersChildAlive
        .word <>rsChapterEventConditionCommandSetChapterEventDataPointer
        .word <>rsChapterEventConditionCommandRegisterCharacterMapSprite
        .word <>rsChapterEventConditionCommandRegisterUnitgroupMapSprites
        .word <>rsChapterEventConditionCommandLoadFactionGroup
        .word <>rsChapterEventConditionCommandSetFactionGroup
        .word <>rsChapterEventConditionCommandSetFactionHostility
        .word <>rsChapterEventConditionCommandDeployUnitGroup
        .word <>rsChapterEventConditionCommandDeployUnitGroupChild
        .word <>rsChapterEventConditionCommandSetUnitPosition
        .word <>rsChapterEventConditionCommand51
        .word <>rsChapterEventConditionCommand52
        .word <>rsChapterEventConditionCommandChangeUnitsFactionslot
        .word <>rsChapterEventConditionCommandAddUnitMoney
        .word <>rsChapterEventConditionCommandSubtractUnitMoney
        .word <>rsChapterEventConditionCommand56
        .word <>rsChapterEventConditionCommandGiveUnitPID
        .word <>rsChapterEventConditionCommandGiveUnitPIDEquip
        .word <>rsChapterEventConditionCommandGiveChildUnitPID
        .word <>rsChapterEventConditionCommandSendInventoryToSupply
        .word <>rsChapterEventConditionCommandGiveUnitPIDForced
        .word <>rsChapterEventConditionCommandUpdateLocationAndMapChangeEvents
        .word <>rsChapterEventConditionCommand5D
        .word <>rsChapterEventConditionCommand5E
        .word <>rsChapterEventConditionCommandSetScriptedAction
        .word <>rsChapterEventConditionCommandModifyLovePoints
        .word <>rsChapterEventConditionCommandSetUnitInCastle
        .word <>rsChapterEventConditionCommandSetLocationTakeover
        .word <>rsChapterEventConditionCommandDeleteFactionsAI
        .word <>rsChapterEventConditionCommandReviveFactionsAI
        .word <>rsChapterEventConditionCommandRemoveUnit
        .word <>rsChapterEventConditionCommandUndeployUnit
        .word <>rsChapterEventConditionCommandSetEventUnitPointers
        .word <>rsChapterEventConditionCommandSetTalkTarget
        .word <>rsChapterEventConditionCommandSetTalkTargetIfUnmarried
        .word <>rsChapterEventConditionCommandSetChildTalkTarget
        .word <>rsChapterEventConditionCommandSetTalkTargetIfMarried
        .word <>rsChapterEventConditionCommandSetTalkTargetIfChildrenMarried
        .word <>rsChapterEventConditionCommandAddCastleMoney
        .word <>rsChapterEventConditionCommandCloseVillage
        .word <>rsChapterEventConditionCommandOpenVillage
        .word <>rsChapterEventConditionCommandAddUnitStat
        .word <>rsChapterEventConditionCommandRemoveAreaRestriction
        .word <>rsChapterEventConditionCommandSetAreaRestriction
        .word <>rsChapterEventConditionCommand73
        .word <>rsChapterEventConditionCommandCombatantsStayOnMap
        .word <>rsChapterEventConditionCommandSetUnitStatus
        .word <>rsChapterEventConditionCommandReplaceUnit
        .word <>rsChapterEventConditionCommandClearTalkIfOneMarried
        .word <>rsChapterEventConditionCommandSaveChapterTurncount

      rsChapterEventConditionCommand00 ; 86/84EC

        .al
        .autsiz
        .databank ?

        ; EC_NOP_00

        rts

        .databank 0

      rsUnknown8684ED ; 86/84ED

        .al
        .autsiz
        .databank ?

        bcs _AdjustScriptOffset

        sep #$20
        cmp bEventActionIdentifier,b
        rep #$20
        bne _SkipEvent

          ; Check if event always works
          lda $0000,b,y
          and #$00FF
          cmp #$00FF
          beq _CheckEvent

            bit #$0080
            bne +

              jsl rlCheckEventFlagSet
              bcs _SkipEvent
              bra _CheckEvent

            +
            and #$007F
            jsl rlCheckEventFlagSet
            bcc _SkipEvent

          _CheckEvent
          jsr _RunEventCheck
          bcc _SkipEvent

          ; Requirements fulfilled

          lda $0000,b,y
          and #$00FF
          cmp #$00FF
          beq _RunEvent

            bit #$0080
            bne +

              jsl rlSetEventFlag
              bra _RunEvent

            +
            and #$007F
            jsl rlUnsetEventFlag
          
          _RunEvent
          jsr _AdjustScriptOffset

          lda $0000,b,y
          jsr rsRunEventConditionCommand
          jml rsUnknown868C37

        _SkipEvent
        jsr _AdjustScriptOffset

        lda $0000,b,y
        jsr rsTrySkipEventConditionCommand
        bra +
        
        _AdjustScriptOffset
        tya
        clc
        adc wEventCommandLength,b
        tay

        +
        rts

        _RunEventCheck
        jmp (lEventPointer)

      rsUnknown86855D ; 86/855D

        .al
        .autsiz
        .databank ?

        php
        ldx #3
        stx wEventCommandLength,b
        ldx #<>rsUnknown86856F
        stx lEventPointer,b
        plp
        jml rsUnknown8684ED

        .databank 0

      rsUnknown86856F ; 86/856F

        .al
        .autsiz
        .databank ?

        lda $0001,b,y
        sta wEventEngineParameter1,b
        jsr rsEventCheck1Parameter
        rts

        .databank 0

      rsUnknown868579 ; 86/8579

        .al
        .autsiz
        .databank ?

        php
        ldx #5
        stx wEventCommandLength,b
        ldx #<>rsUnknown86858B
        stx lEventPointer,b
        plp
        jml rsUnknown8684ED

        .databank 0

      rsUnknown86858B ; 86/858B

        .al
        .autsiz
        .databank ?

        lda $0001,b,y
        sta wEventEngineParameter1,b
        lda $0003,b,y
        sta wEventEngineParameter2,b
        jsr rsEventCheck2Parameters
        rts

        .databank 0

      rsUnknown86859B ; 86/859B

        .al
        .autsiz
        .databank ?

        php
        ldx #7
        stx wEventCommandLength,b
        ldx #<>rsUnknown8685AD
        stx lEventPointer,b
        plp
        jml rsUnknown8684ED

        .databank 0

      rsUnknown8685AD ; 86/85AD

        .al
        .autsiz
        .databank ?

        lda $0001,b,y
        sta wEventEngineParameter1,b
        lda $0003,b,y
        sta wEventEngineParameter2,b
        lda $0005,b,y
        sta wEventEngineParameter3,b
        jsr rsEventCheck4Parameters
        rts

        .databank 0

      rsEventCheckUnitsFighting ; 86/85C3

        .al
        .autsiz
        .databank ?

        php
        ldx #9
        stx wEventCommandLength,b
        ldx #<>rsEventCheckUnitsFightingCallback
        stx lEventPointer,b
        plp
        jml rsUnknown8684ED

        .databank 0

      rsEventCheckUnitsFightingCallback ; 86/85D5

        .al
        .autsiz
        .databank ?

        lda $0001,b,y
        sta wEventEngineParameter1,b
        lda $0003,b,y
        sta wEventEngineParameter2,b
        lda $0005,b,y
        sta wEventEngineParameter3,b
        lda $0007,b,y
        sta wEventEngineParameter4,b
        jsr rsEventCheckUnitsFightingCallbackEffect
        rts

        .databank 0

      rsEventCheckUnitsFightingCallbackEffect ; 86/85F1

        .al
        .autsiz
        .databank ?

        lda wEventEngineParameter1
        bmi +

          lda wEventEngineArgument1,b
          cmp wEventEngineParameter1
          bne _CheckReverse

        +
        lda wEventEngineParameter2
        bmi +

          lda wEventEngineArgument2,b
          cmp wEventEngineParameter2
          bne _CheckReverse

        +
        lda wEventEngineParameter3
        bmi +

          lda wEventEngineArgument3,b
          cmp wEventEngineParameter3
          bne _CheckReverse

        +
        lda wEventEngineParameter4
        bmi +

          lda wEventEngineArgument4,b
          cmp wEventEngineParameter4
          bne _CheckReverse

        +
        sec
        rts

        _CheckReverse
        lda wEventEngineParameter3
        bmi +

          lda wEventEngineArgument1,b
          cmp wEventEngineParameter3
          bne _CLC

        +
        lda wEventEngineParameter4
        bmi +

          lda wEventEngineArgument2,b
          cmp wEventEngineParameter4
          bne _CLC

        +
        lda wEventEngineParameter1
        bmi +

          lda wEventEngineArgument3,b
          cmp wEventEngineParameter1
          bne _CLC

        +
        lda wEventEngineParameter2
        bmi +

          lda wEventEngineArgument4,b
          cmp wEventEngineParameter2
          bne _CLC

        +
        sec
        rts

        _CLC
        clc
        rts

        .databank 0

      rsEventCheckInteraction ; 86/866F

        .al
        .autsiz
        .databank ?

        php
        ldx #5
        stx wEventCommandLength,b
        ldx #<>rsEventCheckInteractionCallback
        stx lEventPointer,b
        plp

        jml rsUnknown8684ED

        .databank 0

      rsEventCheckInteractionCallback ; 86/8681

        .al
        .autsiz
        .databank ?

        lda $0001,b,y
        sta wEventEngineParameter1,b
        lda $0003,b,y
        sta wEventEngineParameter2,b
        jsr rsEventCheck2Parameters
        bcc +

          ; >>> Comment is for seizing castles <<<<
          ; This doesnt quite work. It expects wEventEngineArgument1 to have
          ; the seizing units CharacterID but it has the FactionSlot instead
          ; So it fails to grab the RAM pointer and writes 0 to wEventUnit1Pointer

          ldx wSelectedUnitDataRAMPointer,b
          lda wEventEngineArgument1,b
          jsl rlGetUnitRAMDataPointerByID
          lda wSelectedUnitDataRAMPointer,b
          sta wEventUnit1Pointer,b

          stx wSelectedUnitDataRAMPointer,b
          sec

        +
        rts

        .databank 0

      rsEventCheckTalk ; 86/86A7

        .al
        .autsiz
        .databank ?

        php
        ldx #7
        stx wEventCommandLength,b
        ldx #<>rsEventCheckTalkCallback
        stx lEventPointer,b
        plp
        jml rsUnknown8684ED

        .databank 0

      rsEventCheckTalkCallback ; 86/86B9

        .al
        .autsiz
        .databank ?

        lda $0001,b,y
        sta wEventEngineParameter1,b
        lda $0003,b,y
        sta wEventEngineParameter2,b
        lda $0005,b,y
        sta wEventEngineParameter3,b
        jsr rsEventCheck3Parameters
        bcc +

          ldx wSelectedUnitDataRAMPointer,b

          lda wEventEngineArgument1,b
          jsl rlGetUnitRAMDataPointerByID
          lda wSelectedUnitDataRAMPointer,b
          sta wEventUnit1Pointer,b

          lda wEventEngineArgument2,b
          jsl rlGetUnitRAMDataPointerByID
          lda wSelectedUnitDataRAMPointer,b
          sta wEventUnit2Pointer,b

          stx wSelectedUnitDataRAMPointer,b
          sec

        +
        rts

        .databank 0

      rsUnknown8686F2 ; 86/86F2

        .al
        .autsiz
        .databank ?

        php
        ldx #3
        stx wEventCommandLength,b
        ldx #<>rsUnknown868704
        stx lEventPointer,b
        plp
        jml rsUnknown8684ED

        .databank 0

      rsUnknown868704 ; 86/8704

        .al
        .autsiz
        .databank ?

        lda wEventEngineArgument1,b
        jsr rsEventUnifyGen2CharacterIds
        sta wEventEngineGen2CharacterID1,b

        lda $0001,b,y
        sta wEventEngineParameter1,b
        jsr rsEventEngineCheckGen2CharacterIDParameter
        rts

        .databank 0

      rsUnknown868717 ; 86/8717

        .al
        .autsiz
        .databank ?

        php
        ldx #5
        stx wEventCommandLength,b
        ldx #<>rsUnknown868729
        stx lEventPointer,b
        plp
        jml rsUnknown8684ED

        .databank 0

      rsUnknown868729 ; 86/8729

        .al
        .autsiz
        .databank ?

        lda wEventEngineArgument1,b
        jsr rsEventUnifyGen2CharacterIds
        sta wEventEngineGen2CharacterID1,b

        lda wEventEngineArgument2,b
        jsr rsEventUnifyGen2CharacterIds
        sta wEventEngineGen2CharacterID2,b

        lda $0001,b,y
        sta wEventEngineParameter1,b
        lda $0003,b,y
        sta wEventEngineParameter2,b
        jsr rsEventEngineCheck2Gen2CharacterIDParameters
        rts

        .databank 0

      rsUnknown86874B ; 86/874B

        .al
        .autsiz
        .databank ?

        php
        ldx #9
        stx wEventCommandLength,b
        ldx #<>rsUnknown86875D
        stx lEventPointer,b
        plp
        jml rsUnknown8684ED

        .databank 0

      rsUnknown86875D ; 86/875D

        .al
        .autsiz
        .databank ?

        lda wEventEngineArgument2,b
        jsr rsEventUnifyGen2CharacterIds
        sta wEventEngineGen2CharacterID1,b

        lda wEventEngineArgument4,b
        jsr rsEventUnifyGen2CharacterIds
        sta wEventEngineGen2CharacterID2,b

        lda $0001,b,y
        sta wEventEngineParameter1,b
        lda $0003,b,y
        sta wEventEngineParameter2,b
        lda $0005,b,y
        sta wEventEngineParameter3,b
        lda $0007,b,y
        sta wEventEngineParameter4,b
        jsr rsUnknown86890E
        rts

        .databank 0

      rsUnknown86878B ; 86/878B

        .al
        .autsiz
        .databank ?

        php
        ldx #5
        stx wEventCommandLength,b
        ldx #<>rsUnknown86879D
        stx lEventPointer,b
        plp
        jml rsUnknown8684ED

        .databank 0

      rsUnknown86879D ; 86/879D

        .al
        .autsiz
        .databank ?

        lda wEventEngineArgument1,b
        jsr rsEventUnifyGen2CharacterIds
        sta wEventEngineGen2CharacterID1,b

        lda $0001,b,y
        sta wEventEngineParameter1,b
        lda $0003,b,y
        sta wEventEngineParameter2,b
        jsr rsEventEngineCheckGen2CharacterIDParameterAdditional
        bcc +

          ldx wSelectedUnitDataRAMPointer,b

          lda wEventEngineArgument1,b
          jsl rlGetUnitRAMDataPointerByID
          lda wSelectedUnitDataRAMPointer,b
          sta wEventUnit1Pointer,b

          stx wSelectedUnitDataRAMPointer,b
          sec

        +
        rts

        .databank 0

      rsUnknown8687CC ; 86/87CC

        .al
        .autsiz
        .databank ?

        php
        ldx #5
        stx wEventCommandLength,b
        ldx #<>rsUnknown8687DE
        stx lEventPointer,b
        plp
        jml rsUnknown8684ED

        .databank 0

      rsUnknown8687DE ; 86/87DE

        .al
        .autsiz
        .databank ?

        lda wEventEngineArgument1,b
        jsr rsEventUnifyGen2CharacterIds
        sta wEventEngineGen2CharacterID1,b

        lda wEventEngineArgument2,b
        jsr rsEventUnifyGen2CharacterIds
        sta wEventEngineGen2CharacterID2,b

        lda $0001,b,y
        sta wEventEngineParameter1,b
        lda $0003,b,y
        sta wEventEngineParameter2,b
        jsr rsEventEngineCheck2Gen2CharacterIDParameters
        bcc +

          ldx wSelectedUnitDataRAMPointer,b

          lda wEventEngineArgument1,b
          jsl rlGetUnitRAMDataPointerByID
          lda wSelectedUnitDataRAMPointer,b
          sta wEventUnit1Pointer,b

          stx wSelectedUnitDataRAMPointer,b
          sec

        +
        rts

        .databank 0

      rsUnknown868816 ; 86/8816

        .al
        .autsiz
        .databank ?

        php
        ldx #5
        stx wEventCommandLength,b
        ldx #<>rsUnknown868828
        stx lEventPointer,b
        plp
        jml rsUnknown8684ED

        .databank 0

      rsUnknown868828 ; 86/8828

        .al
        .autsiz
        .databank ?

        lda wEventEngineArgument1,b
        jsr rsEventUnifyGen2CharacterIds
        sta wEventEngineGen2CharacterID1,b

        lda $0001,b,y
        sta wEventEngineParameter1,b
        lda $0003,b,y
        sta wEventEngineParameter2,b
        jsr rsEventEngineCheckGen2CharacterIDParameterAdditional
        bcc +

          ldx wSelectedUnitDataRAMPointer,b

          lda wEventEngineArgument1,b
          jsl rlGetUnitRAMDataPointerByID
          lda wSelectedUnitDataRAMPointer,b
          sta wEventUnit1Pointer,b

          lda wEventEngineArgument2,b
          jsl rlGetUnitRAMDataPointerByID
          lda wSelectedUnitDataRAMPointer,b
          sta wEventUnit2Pointer,b

          stx wSelectedUnitDataRAMPointer,b
          sec

        +
        rts

        .databank 0

      rsEventCheckChildTalk ; 86/8864

        .al
        .autsiz
        .databank ?

        php
        ldx #5
        stx wEventCommandLength,b
        ldx #<>rsEventCheckChildTalkCallback
        stx lEventPointer,b
        plp
        jml rsUnknown8684ED

        .databank 0

      rsEventCheckChildTalkCallback ; 86/8876

        .al
        .autsiz
        .databank ?

        lda wEventEngineArgument1,b
        jsr rsEventUnifyGen2CharacterIds
        sta wEventEngineGen2CharacterID1,b

        lda wEventEngineArgument2,b
        jsr rsEventUnifyGen2CharacterIds
        sta wEventEngineGen2CharacterID2,b

        lda $0001,b,y
        jsr rsEventUnifyGen2CharacterIds
        sta wEventEngineParameter1,b

        lda $0003,b,y
        jsr rsEventUnifyGen2CharacterIds
        sta wEventEngineParameter2,b

        jsr rsEventEngineCheck2Gen2CharacterIDParameters
        bcc +

          ldx wSelectedUnitDataRAMPointer,b

          lda wEventEngineArgument1,b
          jsl rlGetUnitRAMDataPointerByID
          lda wSelectedUnitDataRAMPointer,b
          sta wEventUnit1Pointer,b

          lda wEventEngineArgument2,b
          jsl rlGetUnitRAMDataPointerByID
          lda wSelectedUnitDataRAMPointer,b
          sta wEventUnit2Pointer,b

          stx wSelectedUnitDataRAMPointer,b
          sec

        +
        rts

        .databank 0

      rsEventEngineCheckGen2CharacterIDParameter ; 86/88C1

        .al
        .autsiz
        .databank ?

        lda wEventEngineParameter1,b
        bmi +

          lda wEventEngineGen2CharacterID1,b
          cmp wEventEngineParameter1,b
          bne ++

        +
        sec
        rts

        +
        clc
        rts

        .databank 0

      rsEventEngineCheckGen2CharacterIDParameterAdditional ; 86/88D2

        .al
        .autsiz
        .databank ?

        lda wEventEngineParameter1,b
        bmi +

          lda wEventEngineGen2CharacterID1,b
          cmp wEventEngineParameter1,b
          bne _CLC

        +
        lda wEventEngineParameter2,b
        bmi +

          lda wEventEngineArgument2,b
          cmp wEventEngineParameter2,b
          bne _CLC

        +
        sec
        rts

        _CLC
        clc
        rts

        .databank 0

      rsEventEngineCheck2Gen2CharacterIDParameters ; 86/88F0

        .al
        .autsiz
        .databank ?

        lda wEventEngineParameter1,b
        bmi +

          lda wEventEngineGen2CharacterID1,b
          cmp wEventEngineParameter1,b
          bne _CLC

        +
        lda wEventEngineParameter2,b
        bmi +

          lda wEventEngineGen2CharacterID2,b
          cmp wEventEngineParameter2,b
          bne _CLC

        +
        sec
        rts

        _CLC
        clc
        rts

        .databank 0

      rsUnknown86890E ; 86/890E

        .al
        .autsiz
        .databank ?

        lda wEventEngineParameter1,b
        bmi +

          lda wEventEngineArgument1,b
          cmp wEventEngineParameter1,b
          bne _8944

        +
        lda wEventEngineParameter2,b
        bmi +

          lda wEventEngineGen2CharacterID1,b
          cmp wEventEngineParameter2,b
          bne _8944

        +
        lda wEventEngineParameter3,b
        bmi +

          lda wEventEngineArgument3,b
          cmp wEventEngineParameter3,b
          bne _8944

        +
        lda wEventEngineParameter4,b
        bmi +

          lda wEventEngineGen2CharacterID2,b
          cmp wEventEngineParameter4,b
          bne _8944

        +
        sec
        rts

        _8944
        lda wEventEngineParameter3,b
        bmi +

          lda wEventEngineArgument1,b
          cmp wEventEngineParameter3,b
          bne _CLC

        +
        lda wEventEngineParameter4,b
        bmi +

          lda wEventEngineGen2CharacterID1,b
          cmp wEventEngineParameter4,b
          bne _CLC

        +
        lda wEventEngineParameter1,b
        bmi +

          lda wEventEngineArgument3,b
          cmp wEventEngineParameter1,b
          bne _CLC

        +
        lda wEventEngineParameter2,b
        bmi +

          lda wEventEngineGen2CharacterID2,b
          cmp wEventEngineParameter2,b
          bne _CLC

        +
        sec
        rts
        
        _CLC
        clc
        rts

        .databank 0

      rsChapterEventConditionCommandStartPlayerPhase ; 86/897C

        .al
        .autsiz
        .databank ?

        lda #$20
        jml rsUnknown86855D

        .databank 0

      rsChapterEventConditionCommandCheckSeizingCastle ; 86/8983

        .al
        .autsiz
        .databank ?

        ; CHECK_SEIZING_CASTLE

        ; wEventEngineArgument1 = new owner faction
        ; wEventEngineArgument2 = locationID

        lda #1
        jml rsEventCheckInteraction

        .databank 0

      rsChapterEventConditionCommandCheckVillageDestroyed ; 86/898A

        .al
        .autsiz
        .databank ?

        ; CHECK_VILLAGE_DESTROYED

        ; wEventEngineArgument1 = destroyer faction slot
        ; wEventEngineArgument2 = location id

        lda #$02
        jml rsEventCheckInteraction

        .databank 0

      rsChapterEventConditionCommandCheckTalk ; 86/8991

        .al
        .autsiz
        .databank ?

        ; CHECK_TALK

        ; wEventEngineArgument1 = initiator CharacterID
        ; wEventEngineArgument1 = target CharacterID
        ; wEventEngineArgument3 = CostsMoneyFlag, only works if there is a structChapterTalkEventEntry with the flag set

        lda #$0A
        jml rsEventCheckTalk

        .databank 0

      rsChapterEventConditionCommandCheckEnteringHomeCastle ; 86/8998

        .al
        .autsiz
        .databank ?

        ; CHECK_ENTERING_HOME_CASTLE

        ; wEventEngineArgument1 = CharacterID
        ; wEventEngineArgument2 = Home castle locationID

        lda #4
        jml rsEventCheckInteraction

        .databank 0

      rsChapterEventConditionCommand06 ; 86/899F

        .al
        .autsiz
        .databank ?

        lda #$05
        jml rsEventCheckInteraction

        .databank 0

      rsChapterEventConditionCommandCheckEnteringCastleMenu ; 86/89A6

        .al
        .autsiz
        .databank ?

        lda #$06
        jml rsEventCheckInteraction

        .databank 0

      rsChapterEventConditionCommand08 ; 86/89AD

        .al
        .autsiz
        .databank ?

        lda #$07
        jml rsEventCheckInteraction

        .databank 0

      rsChapterEventConditionCommand09 ; 86/89B4

        .al
        .autsiz
        .databank ?

        lda #$08
        jml rsEventCheckInteraction

        .databank 0

      rsChapterEventConditionCommandVisitVillage ; 86/89BB

        .al
        .autsiz
        .databank ?

        ; VISIT_VILLAGE

        lda #$09
        jml rsEventCheckInteraction

        .databank 0

      rsChapterEventConditionCommandCheckUnitInArea ; 86/89C2

        .al
        .autsiz
        .databank ?

        ; CHECK_UNIT_IN_AREA

        php
        lda #8
        sta wEventCommandLength,b
        lda #<>rsUnknown8689D7
        sta lEventPointer,b
        lda #$03
        plp
        jml rsUnknown8684ED

        .databank 0

      rsUnknown8689D7 ; 86/89D7

        .al
        .autsiz
        .databank ?

        lda $0001,b,y
        sta wEventEngineParameter1,b
        lda $0003,b,y
        sta wEventEngineParameter2,b
        lda $0005,b,y
        sta wEventEngineParameter3,b

        lda $0007,b,y
        bit #$0080
        bne +

          and #$007F
          bra ++
          
          +
          ora #$FF80

        +
        sta wEventEngineParameter4,b

        lda #$03
        jsl rlCheckEventParameters
        bcc +

          ldx wSelectedUnitDataRAMPointer,b

          lda wEventEngineArgument1,b
          jsl rlGetUnitRAMDataPointerByID
          lda wSelectedUnitDataRAMPointer,b
          sta wEventUnit1Pointer,b

          stx wSelectedUnitDataRAMPointer,b
          sec

        +
        rts

        .databank 0

      rsChapterEventConditionCommandCheckUnitsWithinDistance ; 86/8A1A

        .al
        .autsiz
        .databank ?

        php
        lda #7
        sta wEventCommandLength,b
        lda #<>rsUnknown868A2F
        sta lEventPointer,b
        lda #$03
        plp
        jml rsUnknown8684ED

        .databank 0

      rsUnknown868A2F ; 86/8A2F

        .al
        .autsiz
        .databank ?

        ; CHECK_UNITS_WITHIN_DISTANCE

        ; wEventEngineArgument1 = CharacterID
        ; wEventEngineArgument2 = XPosition
        ; wEventEngineArgument3 = YPosition
        ; wEventEngineArgument4 = Faction

        ldx wSelectedUnitDataRAMPointer,b

        lda $0006,b,y
        and #$00FF
        cmp #$00FF
        beq +

          cmp wEventEngineArgument4,b
          bne _CLC

        +
        lda $0001,b,y
        cmp #$FFFF
        beq +

          cmp wEventEngineArgument1,b
          bne _CLC

        +
        jsl rlFindCharactersDeploymentOffset

        stx wSelectedUnitDataRAMPointer,b
        ora #0
        bmi _CLC

          sta wR0
          lda $0003,b,y
          jsl rlFindCharactersDeploymentOffset
          stx wSelectedUnitDataRAMPointer,b
          ora #0
          bmi _CLC

            sta wR1
            tax
            lda aDeploymentTable._State,x
            bit #DeploymentStateAlive
            beq _CLC

              bit #DeploymentStateDefeated
              bne _CLC

                jsl rlGetUnitsDistance
                dec a
                sep #$20
                cmp $0005,b,y
                rep #$20
                bcs _CLC

                  sec
                  rts

        _CLC
        clc
        rts

        .databank 0

      rsChapterEventConditionCommandCheckUnitsFighting ; 86/8A8F

        .al
        .autsiz
        .databank ?

        ; CHECK_UNITS_FIGHTING

        lda #$14
        jml rsEventCheckUnitsFighting

        .databank 0

      rsChapterEventConditionCommandCheckUnitsFighting1to2range ; 86/8A96

        .al
        .autsiz
        .databank ?

        ; CHECK_UNITS_FIGHTING_1TO2RANGE

        php
        ldx #9
        stx wEventCommandLength,b
        ldx #<>rsEventCheckUnitsFighting1To2RangeCallback
        stx lEventPointer,b
        lda #$14
        plp
        jml rsUnknown8684ED

        .databank 0

      rsEventCheckUnitsFighting1To2RangeCallback ; 86/8AAB

        .al
        .autsiz
        .databank ?

        lda wBattleDistance
        cmp #3
        bcs +

          lda $0001,b,y
          sta wEventEngineParameter1,b
          lda $0003,b,y
          sta wEventEngineParameter2,b
          lda $0005,b,y
          sta wEventEngineParameter3,b
          lda $0007,b,y
          sta wEventEngineParameter4,b
          jsr rsEventCheckUnitsFightingCallbackEffect

          rts

        +
        clc
        rts

        .databank 0

      rsChapterEventConditionCommandCheckUnitDied ; 86/8AD2

        .al
        .autsiz
        .databank ?

        ; CHECK_UNIT_DIED

        ; wEventEngineArgument1 = CharacterID
        ; wEventEngineArgument2 = FactionSlot

        lda #$17
        jml rsUnknown868579

        .databank 0

      rsChapterEventConditionCommandCheckUnitDiedTo ; 86/8AD9

        .al
        .autsiz
        .databank ?

        ; CHECK_UNIT_DIED_TO

        lda #$18
        jml rsUnknown868579

        .databank 0

      rsChapterEventConditionCommandCheckFellInLove ; 86/8AE0

        .al
        .autsiz
        .databank ?

        ; CHECK_FELL_IN_LOVE

        lda #$11
        jml rsUnknown868579

        .databank 0

      rsChapterEventConditionCommand11 ; 86/8AE7

        .al
        .autsiz
        .databank ?

        lda #$06
        php
        ldx #7
        stx wEventCommandLength,b
        ldx #<>rsUnknown868AFC
        stx lEventPointer,b
        plp
        jml rsUnknown8684ED

        .databank 0

      rsUnknown868AFC ; 86/8AFC

        .al
        .autsiz
        .databank ?

        lda $0001,b,y
        sta wEventEngineParameter1,b
        lda $0003,b,y
        sta wEventEngineParameter2,b
        lda $0005,b,y
        sta wEventEngineParameter3,b
        jsr rsUnknown868B76
        bcc +

          ldx wSelectedUnitDataRAMPointer,b

          lda wEventEngineArgument1,b
          jsl rlGetUnitRAMDataPointerByID
          lda wSelectedUnitDataRAMPointer,b
          stx wEventUnit1Pointer,b

          stx wSelectedUnitDataRAMPointer,b
          sec

        +
        rts

        .databank 0

      rsChapterEventConditionCommand12 ; 86/8B28

        .al
        .autsiz
        .databank ?

        lda #$0A
        php
        ldx #7
        stx wEventCommandLength,b
        ldx #<>rsUnknown868B3D
        stx lEventPointer,b
        plp
        jml rsUnknown8684ED

        .databank 0

      rsUnknown868B3D ; 86/8B3D

        .al
        .autsiz
        .databank ?

        lda $0001,b,y
        sta wEventEngineParameter1,b
        lda $0003,b,y
        sta wEventEngineParameter2,b
        lda $0005,b,y
        sta wEventEngineParameter3,b
        jsr rsUnknown868B76
        bcc +

          ldx wSelectedUnitDataRAMPointer,b

          lda wEventEngineArgument1,b
          jsl rlGetUnitRAMDataPointerByID
          lda wSelectedUnitDataRAMPointer,b
          sta wEventUnit1Pointer,b

          lda wEventEngineArgument2,b
          jsl rlGetUnitRAMDataPointerByID
          lda wSelectedUnitDataRAMPointer,b
          sta wEventUnit2Pointer,b

          stx wSelectedUnitDataRAMPointer,b
          sec

        +
        rts

        .databank 0

      rsUnknown868B76 ; 86/8B76

        .al
        .autsiz
        .databank ?

        lda wEventEngineParameter1,b
        bmi +

          lda wEventEngineArgument1,b
          cmp wEventEngineParameter1,b
          bne _CLC

        +
        lda wEventEngineParameter2,b
        bmi +

          lda wEventEngineArgument2,b
          cmp wEventEngineParameter2,b
          bne _CLC

        +
        lda wEventEngineParameter3,b
        bmi +

          lda wEventEngineArgument1,b
          jsl rlGetUnitRAMDataPointerByID
          jsl rlGetSelectedUnitGender
          cmp wEventEngineParameter3,b
          bne _CLC

        +
        sec
        rts

        _CLC
        clc
        rts

        .databank 0

      rsChapterEventConditionCommandCheckChildEnteringHomeCastle ; 86/8BA9

        .al
        .autsiz
        .databank ?

        lda #$04
        jml rsUnknown86878B

        .databank 0

      rsChapterEventConditionCommandCheckChildEnteringCastleMenu ; 86/8BB0

        .al
        .autsiz
        .databank ?

        lda #$06
        jml rsUnknown86878B

        .databank 0

      rsChapterEventConditionCommand15 ; 86/8BB7

        .al
        .autsiz
        .databank ?

        lda #$0A
        jml rsUnknown868816

        .databank 0

      rsChapterEventConditionCommandCheckChildTalk ; 86/8BBE

        .al
        .autsiz
        .databank ?

        ; CHECK_CHILD_TALK

        lda #$0A
        jml rsEventCheckChildTalk

        .databank 0

      rsChapterEventConditionCommandCheckChildUnitDied ; 86/8BC5

        .al
        .autsiz
        .databank ?

        lda #$17
        jml rsUnknown8686F2

        .databank 0

      rsChapterEventConditionCommandCheckChildUnitDiedTo ; 86/8BCC

        .al
        .autsiz
        .databank ?

        lda #$18
        jml rsUnknown868717

        .databank 0

      rsChapterEventConditionCommandCheckChildFellInLove ; 86/8BD3

        .al
        .autsiz
        .databank ?

        lda #$11
        jml rsUnknown868717

        .databank 0

      rsChapterEventConditionCommandCheckChildUnitsFighting ; 86/8BDA

        .al
        .autsiz
        .databank ?

        lda #$14
        jml rsUnknown86874B

        .databank 0

      rsChapterEventConditionCommandRescueCivilian ; 86/8BE1

        .al
        .autsiz
        .databank ?

        ; RESCUE_CIVILIAN

        ; wEventEngineArgument1 = CharacterID
        ; wEventEngineArgument2 = FormationID + 1

        lda #$1A
        jml rsEventCheckInteraction

        .databank 0

      rsChapterEventConditionCommandCheckPlayerUncapturedIfSeizing ; 86/8BE8

        .al
        .autsiz
        .databank ?

        ; CHECK_PLAYER_UNCAPTURED_IF_SEIZING

        lda #$1B
        jml rsUnknown86855D

        .databank 0

      rsChapterEventConditionCommandCheckWonInArena ; 86/8BEF

        .al
        .autsiz
        .databank ?

        php
        lda #$1C
        ldx #7
        stx wEventCommandLength,b
        ldx #<>rsEventCheckWonInArenaCallback
        stx lEventPointer,b
        plp
        jml rsUnknown8684ED

        .databank 0

      rsEventCheckWonInArenaCallback ; 86/8C04

        .al
        .autsiz
        .databank ?

        ; Arg1 = player CharacterID
        ; Arg2 = LocationID
        ; Arg3 = target CharacterID

        lda $0001,b,y
        sta wEventEngineParameter1,b
        lda $0003,b,y
        sta wEventEngineParameter2,b
        lda $0005,b,y
        sta wEventEngineParameter3,b
        jsr rsEventCheck3Parameters
        bcc +

          ldx wSelectedUnitDataRAMPointer,b

          lda wEventEngineArgument1,b
          jsl rlGetUnitRAMDataPointerByID
          lda wSelectedUnitDataRAMPointer,b
          sta wEventUnit1Pointer,b

          stx wSelectedUnitDataRAMPointer,b
          sec

        +
        rts

        .databank 0

      rsChapterEventConditionCommandCheckSpecialCrit ; 86/8C30

        .al
        .autsiz
        .databank ?

        ; CHECK_SPECIAL_CRIT

        lda #$1D
        jml rsUnknown868579

        .databank 0

      rsUnknown868C37 ; 86/8C37

        .al
        .autsiz
        .databank ?

        -
        lda $0001,b,y
        cmp #$6666
        beq +
        
        -
        inc y
        bra --
        
        +
        lda $0000,b,y
        and #$00FF  
        cmp #$20
        bne -

        inc y
        inc y
        inc y
        rts

        .databank 0

      rsChapterEventConditionCommandCheckTurnPhaseAIActor ; 86/8C51

        .al
        .autsiz
        .databank ?

        bcs _End

        lda $0000,b,y
        bit #$0080
        bne +

          and #$007F
          bra ++

          +
          ora #$FF80
        
        +
        sta wEventEngineParameter1,b

        lda $0001,b,y
        bit #$0080
        bne +

          and #$007F
          bra ++

          +
          ora #$FF80
        
        +
        sta wEventEngineParameter2,b

        lda $0002,b,y
        bit #$0080
        bne +

          and #$007F
          bra ++

          +
          ora #$FF80

        +
        sta wEventEngineParameter3,b

        lda $0003,b,y
        sta wEventEngineParameter4,b
        lda #$21
        jsl rlCheckEventParameters
        bcs _End

          jml rsEventFindTurnCheckBreak

        _End
        tya
        clc
        adc #5
        tay
        rts

        .databank 0

      rsChapterEventConditionCommandSkipIfStartPlayerPhase ; 86/8CA6

        .al
        .autsiz
        .databank ?

        lda #$20
        jml rsUnknown868CBB

        .databank 0

      rsChapterEventConditionCommand23 ; 86/8CAD

        .al
        .autsiz
        .databank ?

        lda #$25
        jml rsUnknown868CBB

        .databank 0

      rsChapterEventConditionCommand24 ; 86/8CB4

        .al
        .autsiz
        .databank ?

        lda #$26
        jml rsUnknown868CBB

        .databank 0

      rsUnknown868CBB ; 86/8CBB

        .al
        .autsiz
        .databank ?

        bcs +

          sep #$20
          cmp bEventActionIdentifier,b
          rep #$20

            bne rsEventFindTurnCheckBreak
        
        +
        rts

        .databank 0

      rsEventFindTurnCheckBreak ; 86/8CC7

        .al
        .autsiz
        .databank ?

        -
        lda $0001,b,y
        cmp #$6666
        beq +

        -
        inc y
        bra --

        +
        lda $0000,b,y
        and #$00FF
        cmp #$25
        bne -

        inc y
        inc y
        inc y
        rts

        .databank 0

      rsChapterEventConditionCommandRunASM ; 86/8CE1

        .al
        .autsiz
        .databank ?

        bcs +

          lda $0000,b,y
          sta lEventPointer,b
          lda $0001,b,y
          sta lEventPointer+1,b
          phk
          pea #<>(+)-1
          jml [lEventPointer]

        +
        inc y
        inc y
        inc y
        rts

        .databank 0

      rsChapterEventConditionCommandSetFlag ; 86/8CFA

        .al
        .autsiz
        .databank ?

        ; SET_FLAG

        bcs +

          lda $0000,b,y
          and #$00FF
          jsl rlSetEventFlag

        +
        inc y
        rts

        .databank 0

      rsChapterEventConditionCommandUnsetFlag ; 86/8D08

        .al
        .autsiz
        .databank ?

        ; UNSET_FLAG

        bcs +

          lda $0000,b,y
          and #$00FF
          jsl rlUnsetEventFlag

        +
        inc y
        rts

        .databank 0

      rsChapterEventConditionCommandCheckFlagSet ; 86/8D16

        .al
        .autsiz
        .databank ?

        ; CHECK_FLAG_SET

        bcs +

          lda $0000,b,y
          and #$00FF
          jsl rlCheckEventFlagSet
          bcc rsChapterEventConditionCommand2F

        +
        inc y
        rts

        .databank 0

      rsChapterEventConditionCommandCheckFlagUnset ; 86/8D26

        .al
        .autsiz
        .databank ?

        ; CHECK_FLAG_UNSET

        bcs +

          lda $0000,b,y
          and #$00FF  
          jsl rlCheckEventFlagSet
          bcs rsChapterEventConditionCommand2F

        +
        inc y
        rts

        .databank 0

      rsChapterEventConditionCommandJump ; 86/8D36

        .al
        .autsiz
        .databank ?

        bcs +

          lda $0000,b,y
          tay

          -
          rts

        +
        inc y
        inc y
        bra -

        .databank 0

      rsChapterEventConditionCommandCheckAllFlagsInListSet ; 86/8D41

        .al
        .autsiz
        .databank ?

        ; CHECK_ALL_FLAGS_IN_LIST_SET

        bcs _Skip

          -
          lda $0000,b,y
          and #$00FF
          cmp #$00FF
          beq _End

            jsl rlCheckEventFlagSet
            bcc rsChapterEventConditionCommand2F

              inc y
              bra -

          _End
          inc y
          rts

          _Skip
          lda $0000,b,y
          and #$00FF
          cmp #$00FF
          beq +

            inc y
            bra _Skip

        +
        bra _End

        .databank 0

      rsChapterEventConditionCommandCheckFlagInListSet ; 86/8D69

        .al
        .autsiz
        .databank ?

        ; CHECK_FLAG_IN_LIST_SET

        bcs _Skip
        
          -
          lda $0000,b,y
          and #$00FF
          cmp #$00FF
          beq +

            jsl rlCheckEventFlagSet
            bcs _Skip

              inc y
              bra -

          +
          bra rsChapterEventConditionCommand2F

          _End
          inc y
          rts

        _Skip
        lda $0000,b,y
        and #$00FF
        cmp #$00FF
        beq +

          inc y
          bra _Skip

        +
        bra _End

      rsChapterEventConditionCommand2F ; 86/8D93

        .al
        .autsiz
        .databank ?

        -
        lda $0001,b,y
        cmp #$6666
        beq +

        -
        inc y
        bra --

        +
        lda $0000,b,y
        and #$00FF
        cmp #$2E
        beq +

        cmp #$2F
        bne -

        +
        inc y
        inc y
        inc y
        rts

        .databank 0

      rsChapterEventConditionCommandBreak ; 86/8DB2

        .al
        .autsiz
        .databank ?

        ; $20, $25 and $2E

        inc y
        inc y
        rts

        .databank 0

      rsChapterEventConditionCommandEvent ; 86/8DB5

        .al
        .autsiz
        .databank ?

        bcs _End

          lda $0000,b,y
          and #$00FF
          cmp #$00FF
          beq +

            jsl rlCheckEventFlagSet
            bcs _End

          +
          lda $0001,b,y
          jsl rlUnknown80C1CB
          bcs +

            lda $0000,b,y
            and #$00FF
            jsl rlSetEventFlag
            bra _End

          +
          nop

        _End
        tya
        clc
        adc #3
        tay
        rts

        .databank 0

      rsChapterEventConditionCommandSetBattleOrDeathQuote ; 86/8DE5

        .al
        .autsiz
        .databank ?

        ; SET_BATTLE_OR_DEATH_QUOTE

        bcs _End

        ldx wSelectedUnitDataRAMPointer,b

        ; If death quote flag set, always change the quote, 
        ; for battle quote check if they can talk
        lda $0004,b,y
        and #$00FF
        bne +

          lda aActionStructUnit2.UnitRAMPointer
          beq _End

            sta wSelectedUnitDataRAMPointer,b
            jsl rlGetSelectedUnitStatus
            cmp #StatusSilence
            beq _CantTalk

              cmp #StatusSleep
              beq _CantTalk

        +
        lda $0000,b,y
        and #$00FF
        cmp #$00FF
        beq +

          jsl rlCheckEventFlagSet
          bcs _End

            lda $0000,b,y
            and #$00FF
            jsl rlSetEventFlag

        +
        lda $0001,b,y
        sta lR18
        lda $0001+1,b,y
        sta lR18+1
        lda $0004,b,y
        and #$00FF
        jsl rlSetBattleDeathQuotes

        _CantTalk
        stx wSelectedUnitDataRAMPointer,b
        
        _End
        tya
        clc
        adc #5
        tay
        rts

        .databank 0

      rsChapterEventConditionCommandSetPrecombatDialogue ; 86/8E42

        .al
        .autsiz
        .databank ?

        ; SET_PRECOMBAT_DIALOGUE

        bcs _End

          lda $0000,b,y
          and #$00FF
          cmp #$00FF
          beq +

            jsl rlCheckEventFlagSet
            bcs _End

              lda $0000,b,y
              and #$00FF
              jsl rlSetEventFlag

          +
          phx
          phy
          lda wSelectedUnitDataRAMPointer,b
          pha

          lda $0001,b,y
          sta lR18
          lda $0001+1,b,y
          sta lR18+1
          lda $0004,b,y
          jsl rlUnknown91ADC7

          pla
          sta wSelectedUnitDataRAMPointer,b
          ply
          plx

        _End
        tya
        clc
        adc #6
        tay
        rts

        .databank 0

      rsChapterEventConditionCommandRemoveCurrentChapterStruct ; 86/8E83

        .al
        .autsiz
        .databank ?

        bcs +

          jsl rlUnknown86832B

        +
        rts

        .databank 0

      rsChapterEventConditionCommandRemoveChapterStruct ; 86/8E8A

        .al
        .autsiz
        .databank ?

        ; REMOVE_CHAPTER_STRUCT

        bcs +

          lda $0000,b,y
          and #$00FF
          jsl rlRemoveChapterRAMStruct
          inc y

        +
        rts

        .databank 0

      rsChapterEventConditionCommand35 ; 86/8E98

        .al
        .autsiz
        .databank ?

        bcs _Skip

          lda lChapterEventRAMDataEntryPointer,b
          pha
          lda lChapterEventRAMDataEntryPointer+1,b
          pha

          lda $0000+1,b,y
          sta lR18+1
          lda $0000,b,y
          sta lR18

          jsl rlBeginChapterEvents

          pla
          sta lChapterEventRAMDataEntryPointer+1,b
          pla
          sta lChapterEventRAMDataEntryPointer,b

        _Skip
        tya
        clc
        adc #3
        tay
        rts

        .databank 0

      rsChapterEventConditionCommandSetPermanentFlag ; 86/8EBF

        .al
        .autsiz
        .databank ?

        ; SET_PERMANENT_FLAG

        bcs +

          lda $0000,b,y
          and #$00FF
          jsl rlSetPermanentEventFlag

        +
        inc y
        rts

        .databank 0

      rsChapterEventConditionCommandUnsetPermanentFlag ; 86/8ECD

        .al
        .autsiz
        .databank ?

        ; UNSET_PERMANENT_FLAG

        bcs +

          lda $0000,b,y
          and #$00FF
          jsl rlUnsetPermanentEventFlag

        +
        inc y
        rts

        .databank 0

      rsChapterEventConditionCommandCheckPermanentFlagSet ; 86/8EDB

        .al
        .autsiz
        .databank ?

        ; CHECK_PERMANENT_FLAG_SET

        bcs +

          lda $0000,b,y
          and #$00FF
          jsl rlCheckPermanentEventFlagSet
          bcs +

            jml rsChapterEventConditionCommand2F

        +
        inc y
        rts

        .databank 0

      rsChapterEventConditionCommandCheckPermanentFlagUnset ; 86/8EEF

        .al
        .autsiz
        .databank ?

        ; CHECK_PERMANENT_FLAG_UNSET

        bcs +

          lda $0000,b,y
          and #$00FF
          jsl rlCheckPermanentEventFlagSet
          bcc +

            jml rsChapterEventConditionCommand2F

        +
        inc y
        rts

        .databank 0

      rsChapterEventConditionCommandCheckAllPermanentFlagsInListSet ; 86/8F03

        .al
        .autsiz
        .databank ?

        ; CHECK_ALL_PERMANENT_FLAGS_IN_LIST_SET

        bcs _Skip
        
          -
          lda $0000,b,y
          and #$00FF
          cmp #$00FF
          beq _End

            jsl rlCheckPermanentEventFlagSet
            bcs +

              jml rsChapterEventConditionCommand2F

            +
            inc y
            bra -

          _End
          inc y
          rts

        _Skip
        lda $0000,b,y
        and #$00FF
        cmp #$00FF
        beq +

          inc y
          bra _Skip

        +
        bra _End

        .databank 0

      rsChapterEventConditionCommandSetChapterEventCounter ; 86/8F2F

        .al
        .autsiz
        .databank ?

        ; SET_CHAPTER_EVENT_COUNTER

        bcs +

          lda $0000,b,y
          and #$00FF
          sta wEventEngineParameter1,b
          lda $0001,b,y
          and #$00FF
          jsl rlSetChapterEventCounter

        +
        inc y
        inc y
        rts

        .databank 0

      rsChapterEventConditionCommandAddChapterEventCounter ; 86/8F47

        .al
        .autsiz
        .databank ?

        ; ADD_CHAPTER_EVENT_COUNTER

        bcs +

          lda $0000,b,y
          and #$00FF
          sta wEventEngineParameter1,b
          jsl rlGetChapterEventCounter

          sep #$20
          clc
          adc $0001,b,y
          rep #$20

          and #$00FF
          jsl rlSetChapterEventCounter

        +
        inc y
        inc y
        rts

        .databank 0

      rsChapterEventConditionCommandIncrementChapterEventCounter ; 86/8F68

        .al
        .autsiz
        .databank ?

        ; INCREMENT_CHAPTER_EVENT_COUNTER

        bcs +

          lda $0000,b,y
          and #$00FF
          sta wEventEngineParameter1,b
          jsl rlIncrementChapterEventCounter

        +
        inc y
        rts

        .databank 0

      rsChapterEventConditionCommandDecrementChapterEventCounter ; 86/8F79

        .al
        .autsiz
        .databank ?

        ; DECREMENT_CHAPTER_EVENT_COUNTER

        bcs +

          lda $0000,b,y
          and #$00FF
          sta wEventEngineParameter1,b
          jsl rlDecrementChapterEventCounter

        +
        inc y
        rts

        .databank 0

      rsChapterEventConditionCommandCheckChapterEventCounterEqual ; 86/8F8A

        .al
        .autsiz
        .databank ?

        ; CHECK_CHAPTER_EVENT_COUNTER_EQUAL

        bcs +

          lda $0000,b,y
          and #$00FF
          sta wEventEngineParameter1,b
          jsl rlGetChapterEventCounter

          sep #$20
          cmp $0001,b,y
          rep #$20
          beq +

            jml rsChapterEventConditionCommand2F

        +
        inc y
        inc y
        rts

        .databank 0

      rsChapterEventConditionCommandCheckChapterEventCounterNotEqual ; 86/8FA9

        .al
        .autsiz
        .databank ?

        ; CHECK_CHAPTER_EVENT_COUNTER_NOT_EQUAL

        bcs +

          lda $0000,b,y
          and #$00FF
          sta wEventEngineParameter1,b
          jsl rlGetChapterEventCounter

          sep #$20
          cmp $0001,b,y
          rep #$20
          bne +

            jml rsChapterEventConditionCommand2F
        
        +
        inc y
        inc y
        rts

        .databank 0

      rsChapterEventConditionCommandCheckIfInHomeCastle ; 86/8FC8

        .al
        .autsiz
        .databank ?

        bcs +

          lda $0000,b,y
          jsl rlUnknown87A040
          bcs +

            jml rsChapterEventConditionCommand2F

        +
        inc y
        inc y
        rts

        .databank 0

      rsChapterEventConditionCommandCheckItemUnobtained ; 86/8FDA

        .al
        .autsiz
        .databank ?

        bcs +

          lda wR0
          pha
          lda wR1
          pha

          lda $0000,b,y
          jsl rlGetItemRAMStructEntryByPlayerItemIndex
          jsl rlGetItemRAMStateAndOwner

          lda wR0
          cmp #ItemStateUnobtained
          beq +

            pla
            sta wR1
            pla
            sta wR0
            jml rsChapterEventConditionCommand2F

        +
        pla
        sta wR1
        pla
        sta wR0
        inc y
        inc y
        rts

        .databank 0

      rsChapterEventConditionCommandCheckNoCastleDestroyed ; 86/9007

        .al
        .autsiz
        .databank ?

        ; CHECK_NO_CASTLE_DESTROYED

        bcs _End
        
          lda wEventLocationEntry,b
          pha
          ldx #0

          _Loop
          txa
          jsl rlGetLocationEventDataEntry
          bcs +

            jsl rlGetEventLocationEntryType
            cmp #LocationTypeCastle
            bne _Next

              jsl rlCheckLocationDestroyed
              bcs _Destroyed

            _Next
            inc x
            bra _Loop

          +
          pla
          sta wEventLocationEntry,b

        _End
        rts

        _Destroyed
        pla
        sta wEventLocationEntry,b
        jml rsChapterEventConditionCommand2F

        .databank 0

      rsChapterEventConditionCommandCheckEveryoneInFactionDead ; 86/9036

        .al
        .autsiz
        .databank ?

        bcs +

          lda $0000,b,y
          and #$00FF
          jsl rlCountUnitsInFactionSlotAlive
          cmp #0
          beq +

            jml rsChapterEventConditionCommand2F

        +
        inc y
        rts

        .databank 0

      rsChapterEventConditionCommandCheckUnitsMarried ; 86/904D

        .al
        .autsiz
        .databank ?

        ; CHECK_UNITS_MARRIED

        lda wR0
        pha

        lda wSelectedUnitDataRAMPointer,b
        pha

        bcs _End

          lda $0000,b,y
          and #$00FF
          jsl rlGetUnitRAMDataPointerByID
          bcs +

            jsl rlGetSelectedUnitLoverGenerationID
            sta wR0
            cmp #0
            beq +

              lda $0001,b,y
              and #$00FF
              cmp #$00FF
              beq _End

                jsl rlGetUnitRAMDataPointerByID
                bcs +

                  jsl rlGetSelectedUnitGenerationID
                  cmp wR0
                  beq _End

          +
          pla
          sta wSelectedUnitDataRAMPointer,b
          pla
          sta wR0
          jml rsChapterEventConditionCommand2F

        _End
        pla
        sta wSelectedUnitDataRAMPointer,b
        pla
        sta wR0
        inc y
        inc y
        rts

        .databank 0

      rsChapterEventConditionCommandCheckUnitAlive ; 86/909B

        .al
        .autsiz
        .databank ?

        ; CHECK_UNIT_ALIVE

        lda wSelectedUnitDataRAMPointer,b
        pha

        bcs _End

          lda $0000,b,y
          jsl rlGetUnitRAMDataPointerByID
          bcs +

            jsl rlGetSelectedUnitStates
            bit #UnitStateDead
            beq _End

          +
          pla
          sta wSelectedUnitDataRAMPointer,b
          jml rsChapterEventConditionCommand2F

        _End
        pla
        sta wSelectedUnitDataRAMPointer,b
        inc y
        inc y
        rts

        .databank 0

      rsChapterEventConditionCommandCheckFathersChildAlive ; 86/90C2

        .al
        .autsiz
        .databank ?

        ; CHECK_FATHERS_CHILD_ALIVE

        lda wSelectedUnitDataRAMPointer,b
        pha

        bcs _End

          stz wEventUnit1Pointer,b
          stz wEventUnit2Pointer,b

          lda $0000,b,y
          jsl rlGetFatherUnitsChildrenRAMPointers

          lda $7E2000
          beq _NoChildren

            sta wSelectedUnitDataRAMPointer,b
            jsl rlGetSelectedUnitStates
            bit #UnitStateDead
            bne +

              lda wSelectedUnitDataRAMPointer,b
              sta wEventUnit1Pointer,b

            +
            lda $7E2002
            beq _NoChildren

              sta wSelectedUnitDataRAMPointer,b
              jsl rlGetSelectedUnitStates
              bit #UnitStateDead
              bne +

                lda wSelectedUnitDataRAMPointer,b
                sta wEventUnit2Pointer,b

              +
              lda wEventUnit1Pointer,b
              ora wEventUnit2Pointer,b
              bne _End

          _NoChildren
          pla
          sta wSelectedUnitDataRAMPointer,b
          jml rsChapterEventConditionCommand2F

        _End
        pla
        sta wSelectedUnitDataRAMPointer,b
        inc y
        inc y
        rts

        .databank 0

      rsChapterEventConditionCommandSetChapterEventDataPointer ; 86/911C

        .al
        .autsiz
        .databank ?

        bcs +

          lda $0000+1,b,y
          sta lR18+1
          lda $0000,b,y
          sta lR18
          jsl rlSetChapterEventDataPointer

        +
        tya
        clc
        adc #3
        tay
        rts

        .databank 0

      rsChapterEventConditionCommandRegisterCharacterMapSprite ; 86/9133

        .al
        .autsiz
        .databank ?

        ; REGISTER_CHARACTER_MAP_SPRITE

        bcs +

          lda $0000,b,y
          jsl rlRegisterCharacterMapSprite

        +
        inc y
        inc y
        rts

        .databank 0

      rsChapterEventConditionCommandRegisterUnitgroupMapSprites ; 86/913F

        .al
        .autsiz
        .databank ?

        ; REGISTER_UNITGROUP_MAP_SPRITES

        bcs +

          lda #(`aUNITGroupPointers)<<8
          sta lR18+1
          lda #<>aUNITGroupPointers
          sta lR18
          lda $0000,b,y
          and #$00FF
          inc a
          jsl rlGetUNITGroupPointer
          sta lR18
          jsl rlLoadUNITGroupMapSprites ; rlLoadUNITGroupMapSprites

        +
        inc y
        rts

        .databank 0

      rsChapterEventConditionCommandLoadFactionGroup ; 86/915E

        .al
        .autsiz
        .databank ?

        ; LOAD_FACTION_GROUP

        bcs +

          lda $0001,b,y
          and #$00FF
          sta wRoutineVariable1,b
          lda $0000,b,y
          and #$00FF
          jsl rlLoadFactionGroup

        +
        inc y
        inc y
        rts

        .databank 0

      rsChapterEventConditionCommandSetFactionGroup ; 86/9176

        .al
        .autsiz
        .databank ?

        ; SET_FACTION_GROUP

        bcs +

          lda $0001,b,y
          and #$00FF
          sta wRoutineVariable1,b
          lda $0000,b,y
          and #$00FF
          jsl rlSetFactionSlotGroupID

        +
        inc y
        inc y
        rts

        .databank 0

      rsChapterEventConditionCommandSetFactionHostility ; 86/918E

        .al
        .autsiz
        .databank ?

        ; SET_FACTION_HOSTILITY

        bcs +

          lda $0000,b,y
          and #$00FF
          sta wRoutineVariable1,b
          lda $0001,b,y
          jsl rlSetFactionHostility

        +
        tya
        clc
        adc #3
        tay
        rts

        .databank 0

      rsChapterEventConditionCommandDeployUnitGroup ; 86/91A7

        .al
        .autsiz
        .databank ?

        ; DEPLOY_UNIT_GROUP

        bcs +

          stz lR19
          stz lR19+1

          lda #(`aUNITGroupPointers)<<8
          sta lR18+1
          lda #<>aUNITGroupPointers
          sta lR18

          lda $0000,b,y
          and #$00FF
          sta $0D7D,b
          inc a
          jsl rlGetUNITGroupPointer
          sta lR18
          jsl rlLoadUnitGroup
        
        +
        inc y
        rts

        .databank 0

      rsChapterEventConditionCommandDeployUnitGroupChild ; 86/91CD

        .al
        .autsiz
        .databank ?

        ; DEPLOY_UNIT_GROUP_CHILD

        bcs +

          phb
          phb
          pla
          sta lR19+1
          tya
          clc
          adc #1
          sta lR19

          lda #(`aUNITGroupPointers)<<8
          sta lR18+1
          lda #<>aUNITGroupPointers
          sta lR18

          lda $0000,b,y
          and #$00FF
          sta $0D7D,b
          inc a
          jsl rlGetUNITGroupPointer
          sta lR18
          jsl rlLoadUnitGroup

        +
        tya
        clc
        adc #6
        tay
        rts

        .databank 0

      rsChapterEventConditionCommandSetUnitPosition ; 86/9200

        .al
        .autsiz
        .databank ?

        ; SET_UNIT_POSITION

        bcs _End

          phx
          lda $0003,b,y
          sta wRoutineVariable1,b

          ldx #FS_Player
          lda $0000,b,y
          jsl rlUnknown84C87A
          tax
          jsl rlDeployedUnitUnsetHiddenIfAlive

          lda $0002,b,y
          and #$00FF
          cmp #$00FF
          beq +

            jsl rlSetUnitResidingInCastle

          +
          plx

        _End
        tya
        clc
        adc #5
        tay
        rts

        .databank 0

      rsChapterEventConditionCommand51 ; 86/922F

        .al
        .autsiz
        .databank ?

        bcs +

          lda $0003,b,y
          sta wRoutineVariable1,b

          lda $0002,b,y
          and #$00FF
          tax
          lda $0000,b,y
          jsl rlUnknown84C87A
          tax
          jsl rlDeployedUnitUnsetHiddenIfAlive

          lda $0005,b,y
          and #$007F
          jsl rlSetSelectedUnitAI

          lda $0005,b,y
          bit #$0080
          beq +

            lda #UnitStateGroupLeader
            jsl rlSetSelectedUnitStates

        +
        tya
        clc
        adc #6
        tay
        rts

        .databank 0

      rsChapterEventConditionCommand52 ; 86/926A

        .al
        .autsiz
        .databank ?

        lda #0
        sta wRoutineVariable1,b

        ldx #FS_Player
        lda $0000,b,y
        jsl rlUnknown84C87A
        tax
        jsl rlDeployedUnitUnsetHiddenIfAlive
        lda #0
        jsl rlSetUnitResidingInCastle
        jsl rlGetSelectedUnitLevel
        sta wRoutineVariable1,b
        lda $0002,b,y
        and #$00FF
        beq +

          sec
          sbc wRoutineVariable1,b
          beq +
          bcc +

            tax

            -
            lda #(`aDecompressionBuffer)<<8
            sta lRoutineVariable+1,b
            lda #<>aDecompressionBuffer
            sta lRoutineVariable,b
            jsl rlGetLevelUpStats
            dec x
            bne -

        +
        lda $0003,b,y
        and #$00FF
        cmp #$00FF
        beq +

          sta wRoutineVariable1,b
          jsl rlGivePlayerItemIDToSelectedUnit

        +
        lda $0004,b,y
        and #$00FF
        cmp #$00FF
        beq +

          sta wRoutineVariable1,b
          jsl rlGivePlayerItemIDToSelectedUnit

        +
        tya
        clc
        adc #5
        tay
        rts

        .databank 0

      rsEventLoadSpecifiedOrEventUnit1Pointer ; 86/92DC

        .al
        .autsiz
        .databank ?

        ; If the input in A has the highest bit set, load the pointer in
        ; wEventUnit1Pointer, else get the pointer by the CharacterID

        ; Input:
        ; A = CharacterID

        ; Output:
        ; filled wSelectedUnitDataRAMPointer
        ; CLC if successful, SEC if not

        bmi +
        
          jsl rlGetUnitRAMDataPointerByID
          bcs ++
          bra _CLC

        +
        lda wEventUnit1Pointer,b
        sta wSelectedUnitDataRAMPointer,b

        _CLC
        clc

        +
        rts

        .databank 0

      rsChapterEventConditionCommandChangeUnitsFactionslot ; 86/92EE

        .al
        .autsiz
        .databank ?

        bcs _End

          lda $0000,b,y
          jsr rsEventLoadSpecifiedOrEventUnit1Pointer
          bcs _End

            jsl rlGetSelectedUnitStates
            bit #UnitStateFielded
            bne +

              lda $0002,b,y
              and #$00FF
              sta wRoutineVariable1
              jsl rlChangeFactionSlotOfSelectedUnit
              bra _End

            +
            jsl rlGetSelectedUnitDeploymentOffset
            tax
            lda $0002,b,y
            and #$00FF
            jsl rlChangeFactionSlotOfFieldedSelectedUnit

        _End
        tya
        clc
        adc #3
        tay
        rts

        .databank 0

      rsChapterEventConditionCommandAddUnitMoney ; 86/9327

        .al
        .autsiz
        .databank ?

        bcs +

          lda $0000,b,y
          jsr rsEventLoadSpecifiedOrEventUnit1Pointer
          bcs +

            lda $0002,b,y
            sta wRoutineVariable1,b
            jsl rlAddSelectedCharacterMoney

        +
        tya
        clc
        adc #4
        tay
        rts

        .databank 0

      rsChapterEventConditionCommandSubtractUnitMoney ; 86/9342

        .al
        .autsiz
        .databank ?

        bcs +

          lda $0000,b,y
          jsr rsEventLoadSpecifiedOrEventUnit1Pointer
          bcs +

            lda $0002,b,y
            sta wRoutineVariable1,b
            jsl rlSubtractSelectedCharacterMoney

        +
        tya
        clc
        adc #4
        tay
        rts

        .databank 0

      rsChapterEventConditionCommand56 ; 86/935D

        .al
        .autsiz
        .databank ?

        rts

        .databank 0

      rsChapterEventConditionCommandGiveUnitPID ; 86/935E

        .al
        .autsiz
        .databank ?

        ; GIVE_UNIT_PID

        bcs +

          lda $0000,b,y
          jsr rsEventLoadSpecifiedOrEventUnit1Pointer
          bcs +

            lda $0002,b,y
            and #$00FF
            sta wRoutineVariable1,b
            jsl rlGiveItemToUnitCheckEncumbered

            stz wUnitRelocationDeploymentOffset,b
            lda #8
            sta wUnitRelocationType,b
            lda wRoutineVariable1,b
            sta wUnitRelocationLocationID,b

        +
        inc y
        inc y
        inc y
        rts

        .databank 0

      rsChapterEventConditionCommandGiveUnitPIDEquip ; 86/9388

        .al
        .autsiz
        .databank ?

        bcs +

          lda $0000,b,y
          jsr rsEventLoadSpecifiedOrEventUnit1Pointer
          bcs +

            lda $0002,b,y
            and #$00FF
            sta wRoutineVariable1,b
            jsl rlGiveItemToUnitCheckEncumbered

            jsl rlGetSelectedUnitInventorySize
            jsl rlFlagEquippedInventorySlotAndGetStatBonus
            stz wUnitRelocationDeploymentOffset,b

            lda #8
            sta wUnitRelocationType,b
            lda $0002,b,y
            and #$00FF
            sta wUnitRelocationLocationID,b

        +
        inc y
        inc y
        inc y
        rts

        .databank 0

      rsChapterEventConditionCommandGiveChildUnitPID ; 86/93BD

        .al
        .autsiz
        .databank ?

        bcs +
        
          lda $0000,b,y
          jsr rsEventUnifyGen2CharacterIds
          jsr rsEventLoadSpecifiedOrEventUnit1Pointer
          bcs +

            lda $0002,b,y
            and #$00FF
            sta wRoutineVariable1,b
            jsl rlGiveItemToUnitCheckEncumbered

            stz wUnitRelocationDeploymentOffset,b
            lda #8
            sta wUnitRelocationType,b
            lda wRoutineVariable1,b
            sta wUnitRelocationLocationID,b

        +
        inc y
        inc y
        inc y
        rts

        .databank 0

      rsChapterEventConditionCommandSendInventoryToSupply ; 86/93EA

        .al
        .autsiz
        .databank ?

        ; SEND_INVENTORY_TO_SUPPLY

        bcs +

          lda $0000,b,y
          jsr rsEventLoadSpecifiedOrEventUnit1Pointer
          bcs +

            -
            lda #1
            sta wSelectedInventorySlot,b
            jsl rlDumpInventorySlotIntoSupplyIfFilled
            bcs +
            bra -

        +
        inc y
        inc y
        rts

        .databank 0

      rsChapterEventConditionCommandGiveUnitPIDForced ; 86/9405

        .al
        .autsiz
        .databank ?

        ; GIVE_UNIT_PID_FORCED

        bcs _End

          lda $0000,b,y
          jsr rsEventLoadSpecifiedOrEventUnit1Pointer
          bcs _End

            jsl rlGetSelectedUnitInventorySize
            cmp #7
            bcc +

              lda #7
              sta wSelectedInventorySlot,b
              jsl rlDumpInventorySlotIntoSupplyIfFilled
              bcs _End

            +
            lda $0002,b,y
            and #$00FF
            sta wRoutineVariable1,b
            jsl rlGiveItemToUnitCheckEncumbered

        _End
        inc y
        inc y
        inc y
        rts

        .databank 0

      rsChapterEventConditionCommandUpdateLocationAndMapChangeEvents ; 86/9435

        .al
        .autsiz
        .databank ?

        bcs +

          jsl rlUpdateAllLocationEvents
          jsl rlUpdateMapChangeEvents

        +
        rts

        .databank 0

      rsChapterEventConditionCommand5D ; 86/9440

        .al
        .autsiz
        .databank ?

        bcs _End

          lda $0000,b,y
          and #$00FF
          cmp #$00FF
          beq +

            jsl rlCheckEventFlagSet
            bcc _End

          +
          lda $0001,b,y
          sta wEventEngineParameter1,b
          lda $0003,b,y
          bit #$0080
          bne +

            and #$007F
            bra ++

            +
            ora #$FF80

          +
          sta wEventEngineParameter2,b
          lda $0004,b,y
          bit #$0080
          bne +

            and #$007F
            bra ++

            +
            ora #$FF80

          +
          sta wEventEngineParameter3,b
          lda #$0026
          jsl rlCheckEventParameters
          bcc _End

            lda $0005,b,y
            jsl rlUnknown80C1CB

        _End
        tya
        clc
        adc #7
        tay
        rts

        .databank 0

      rsChapterEventConditionCommand5E ; 86/9496

        .al
        .autsiz
        .databank ?

        bcs +

          lda $0000,b,y
          sta lR18
          lda $0000+1,b,y
          sta lR18+1
          jsl rlUnknown84B613

        +
        inc y
        inc y
        inc y
        rts

        .databank 0

      rsChapterEventConditionCommandSetScriptedAction ; 86/94AA

        .al
        .autsiz
        .databank ?

        ; SET_SCRIPTED_ACTION

        bcs _End

          lda $0000,b,y
          jsr rsEventLoadSpecifiedOrEventUnit1Pointer
          bcs _End

            jsl rlGetSelectedUnitDeploymentOffset
            sta $0871,b

            lda $0002,b,y
            and #$00FF
            asl a
            asl a
            asl a
            asl a
            sta $0875,b

            lda $0003,b,y
            and #$00FF
            asl a
            asl a
            asl a
            asl a
            sta $0877,b

            lda $0005,b,y
            cmp #$FFFF
            beq +

              jsl rlGetUnitRAMDataPointerByID
              bcs _End

                jsl rlGetSelectedUnitDeploymentOffset

            +
            sta $0873,b

            lda $0004,b,y
            and #$00FF
            sta $0879,b
            cmp #11
            bne +

              phb
              phb
              pla
              sta lAITemp000E90+1,b
              lda $0007,b,y
              sta lAITemp000E90,b
              inc y
              inc y

            +
            lda #$FFFF
            sta $086F,b

            lda #1
            tsb bUnknown000E7B,b

        _End
        tya
        clc
        adc #7
        tay
        rts

        .databank 0

      rsChapterEventConditionCommandModifyLovePoints ; 86/9519

        .al
        .autsiz
        .databank ?

        ; MODIFY_LOVE_POINTS

        bcs _End

          lda $0002,b,y
          jsr rsEventLoadSpecifiedOrEventUnit1Pointer
          bcs _End

            jsl rlGetSelectedUnitGenerationID
            tax

            lda $0000,b,y
            jsl rlGetUnitRAMDataPointerByID
            bcs _End

              jsl rlGetSelectedUnitLoverGenerationID
              ora #0
              bne _End

                lda $0004,b,y
                bit #$0080
                bne +

                  and #$007F
                  bra ++

                  +
                  ora #$FF80

                +
                sta wRoutineVariable1,b
                txa
                jsl rlModifyUnitsLovePoints

        _End
        tya
        clc
        adc #5
        tay
        rts

        .databank 0

      rsChapterEventConditionCommandSetUnitInCastle ; 86/9559

        .al
        .autsiz
        .databank ?

        bcs +

          lda $0000,b,y
          jsl rlGetUnitRAMDataPointerByID
          bcs +

            jsl rlGetSelectedUnitDeploymentOffset
            tax
            lda $0002,b,y
            and #$00FF
            jsl rlSetUnitResidingInCastle

        +
        inc y
        inc y
        inc y
        rts

        .databank 0

      rsChapterEventConditionCommandSetLocationTakeover ; 86/9577

        .al
        .autsiz
        .databank ?

        ; SET_LOCATION_TAKEOVER

        bcs _End

          lda $0001,b,y
          and #$00FF
          jsl rlGetLocationEventDataEntry
          bcs _End

            jsl rlGetEventLocationEntryID
            sta wEventEngineParameter2

            jsl rlGetLocationFactionSlotOwner
            sta wEventEngineParameter1
            jsl rlGetFactionSlotLocationID
            cmp wEventEngineParameter2
            bne +

              lda wEventEngineParameter1
              jsl rlUnloadFactionSlot

            +
            lda $0000,b,y
            and #$00FF
            jsl rlSetLocationFactionSlotOwner
            jsl rlUnsetCastleGuarded
            jsl rlHandleEventLocationModification
            phy
            jsl rlUnknown888410
            ply

        _End
        inc y
        inc y
        rts

        .databank 0

      rsChapterEventConditionCommandDeleteFactionsAI ; 86/95C2

        .al
        .autsiz
        .databank ?

        ; DELETE_FACTIONS_AI

        bcs +

          lda $0001,b,y
          and #$00FF
          sta wRoutineVariable1,b
          lda $0000,b,y
          and #$00FF
          jsl rlDeleteFactionsUnitsOfAISetting

        +
        inc y
        inc y
        rts

        .databank 0

      rsChapterEventConditionCommandReviveFactionsAI ; 86/95DA

        .al
        .autsiz
        .databank ?

        ; REVIVE_FACTIONS_AI

        bcs +
        
          lda $0001,b,y
          and #$00FF
          sta wRoutineVariable1,b
          lda $0000,b,y
          and #$00FF
          jsl rlReviveFactionsUnitsOfAISetting

        +
        inc y
        inc y
        rts

        .databank 0

      rsChapterEventConditionCommandRemoveUnit ; 86/95F2

        .al
        .autsiz
        .databank ?

        bcs +

          lda $0000,b,y
          jsl rlGetUnitRAMDataPointerByID
          bcs +

            jsl rlUndeployUnit
            jsl rlDeleteUnit

        +
        inc y
        inc y
        rts

        .databank 0

      rsChapterEventConditionCommandUndeployUnit ; 86/9608

        .al
        .autsiz
        .databank ?

        bcs +

          lda $0000,b,y
          jsl rlGetUnitRAMDataPointerByID
          bcs +

            jsl rlUndeployUnit

        +
        inc y
        inc y
        rts

        .databank 0

      rsChapterEventConditionCommandSetEventUnitPointers ; 86/961A

        .al
        .autsiz
        .databank ?

        bcs _End

          lda $0000,b,y
          and #$00FF
          cmp #$00FF
          beq +

            jsl rlFindCharacterByGenerationID
            bcs _End

              lda wSelectedUnitDataRAMPointer,b
              sta wEventUnit1Pointer,b

          +
          inc y
          lda $0000,b,y
          and #$00FF
          cmp #$00FF
          beq _End

            jsl rlFindCharacterByGenerationID
            bcs _End

              lda wSelectedUnitDataRAMPointer,b
              sta wEventUnit2Pointer,b
        
        _End
        inc y
        rts

        .databank 0

      rsChapterEventConditionCommandSetTalkTarget ; 86/964D

        .al
        .autsiz
        .databank ?

        ; SET_TALK_TARGET

        bcs _End

          lda wSelectedUnitDataRAMPointer,b
          pha

          lda $0000,b,y
          and #$00FF
          jsl rlGetUnitRAMDataPointerByID
          bcs +

            lda $0001,b,y
            and #$00FF
            jsl rlSetSelectedUnitTalkTarget

          +
          pla
          sta wSelectedUnitDataRAMPointer,b

        _End
        inc y
        inc y
        rts

        .databank 0

      rsChapterEventConditionCommandSetTalkTargetIfUnmarried ; 86/9670

        .al
        .autsiz
        .databank ?

        ; SET_TALK_TARGET_IF_UNMARRIED

        bcs _End

          lda wSelectedUnitDataRAMPointer,b
          pha

          lda $0000,b,y
          and #$00FF
          sta wR0
          lda $0002,b,y
          and #$00FF
          sta wR1
          jsr rsEventGetExistingUnitRAMPointer
          bcs +

            jsl rlGetSelectedUnitLoverGenerationID
            ora #0
            bne +

              ldx wSelectedUnitDataRAMPointer,b
              lda $0001,b,y
              and #$00FF
              sta wR0
              lda $0003,b,y
              and #$00FF
              sta wR1
              jsr rsEventGetExistingUnitRAMPointer
              bcs +

                jsl rlGetSelectedUnitLoverGenerationID
                ora #0
                bne +

                  jsl rlGetSelectedUnitCharacterID
                  stx wSelectedUnitDataRAMPointer,b
                  jsl rlSetSelectedUnitTalkTarget

          +
          pla
          sta wSelectedUnitDataRAMPointer,b

        _End
        tya
        clc
        adc #4
        tay
        rts

        .databank 0

      rsEventGetExistingUnitRAMPointer ; 86/96CB

        .al
        .autsiz
        .databank ?

        ; If first character exists, return their pointer.
        ; If not, check 2nd character.
        ; If neither exist, exit with SEC.

        ; Input:
        ; wR0 = CharacterID 1
        ; wR1 = CharacterID 2 or $FF if ignored

        ; Output:
        ; filled wSelectedUnitDataRAMPointer if successful
        ; CLC if either unit exists
        ; SEC if none of them exist

        lda wR0
        jsl rlGetUnitRAMDataPointerByID
        bcc +

          lda wR1
          cmp #$00FF
          beq _SEC

            jsl rlGetUnitRAMDataPointerByID
            bcs _SEC

        +
        rts

        _SEC
        sec
        rts

        .databank 0

      rsChapterEventConditionCommandSetChildTalkTarget ; 86/96E3

        .al
        .autsiz
        .databank ?

        ; SET_CHILD_TALK_TARGET

        bcs _End

          lda $0000,b,y
          and #$00FF
          sta wR0
          lda $0002,b,y
          and #$00FF
          sta wR1
          jsr rsEventGetExistingUnitRAMPointer
          bcs _End

            ldx wSelectedUnitDataRAMPointer,b
            lda $0001,b,y
            and #$00FF
            jsl rlGetUnitRAMDataPointerByID
            bcc _TalkToFirst

              lda $0003,b,y
              and #$00FF
              cmp #$00FF
              beq _End

                jsl rlGetUnitRAMDataPointerByID
                bcs _End
                bra _TalkToSecond

            _TalkToFirst
            stx wSelectedUnitDataRAMPointer,b
            lda $0001,b,y
            and #$00FF
            jsl rlSetSelectedUnitTalkTarget
            bra _End

            _TalkToSecond
            stx wSelectedUnitDataRAMPointer,b
            lda $0003,b,y
            and #$00FF
            jsl rlSetSelectedUnitTalkTarget

        _End
        tya
        clc
        adc #4
        tay
        rts

        .databank 0

      rsChapterEventConditionCommandSetTalkTargetIfMarried ; 86/973F

        .al
        .autsiz
        .databank ?

        ; SET_TALK_TARGET_IF_MARRIED

        bcs _End

          lda $0000,b,y
          and #$00FF
          jsl rlCheckEventFlagSet
          bcs _End

            lda $0001,b,y
            and #$00FF
            sta wR0
            lda $0002,b,y
            and #$00FF
            sta wR1
            jsl rlCheckUnitsMarriedToEachOther
            bcs +

        _End
        tya
        clc
        adc #3
        tay
        rts

        +
        lda $0000,b,y
        and #$00FF
        jsl rlSetEventFlag
        inc y
        clc
        jml rsChapterEventConditionCommandSetTalkTarget

        .databank 0

      rsChapterEventConditionCommandSetTalkTargetIfChildrenMarried ; 86/977A

        .al
        .autsiz
        .databank ?

        bcs _End

          lda $0000,b,y
          and #$00FF
          jsl rlCheckEventFlagSet
          bcs _End

            lda $0001,b,y
            and #$00FF
            sta wR0
            lda $0002,b,y
            and #$00FF
            sta wR1
            jsl rlCheckUnitsMarriedToEachOther
            bcs _97FB

            lda $0003,b,y
            and #$00FF
            cmp #$00FF
            beq +

              sta wR0
              lda $0002,b,y
              and #$00FF
              sta wR1
              jsl rlCheckUnitsMarriedToEachOther
              bcs _97FB

            +
            lda $0001,b,y
            and #$00FF
            sta wR0
            lda $0004,b,y
            and #$00FF
            cmp #$00FF
            beq +

              sta wR1
              jsl rlCheckUnitsMarriedToEachOther
              bcs _97FB

            +
            lda $0003,b,y
            and #$00FF
            cmp #$00FF
            beq _End

              sta wR0
              lda $0004,b,y
              and #$00FF
              cmp #$00FF
              beq _End

                sta wR1
                jsl rlCheckUnitsMarriedToEachOther
                bcs _97FB

        _End
        tya
        clc
        adc #5
        tay
        rts

        _97FB
        lda $0000,b,y
        and #$00FF
        jsl rlSetEventFlag
        inc y
        clc
        jml rsChapterEventConditionCommandSetChildTalkTarget

        .databank 0

      rsChapterEventConditionCommandAddCastleMoney ; 86/980B

        .al
        .autsiz
        .databank ?

        ; ADD_CASTLE_MONEY

        bcs +

          lda #0
          jsl rlAddCastleMoneyToAllUnitsInFaction

        +
        rts

        .databank 0

      rsChapterEventConditionCommandCloseVillage ; 86/9815

        .al
        .autsiz
        .databank ?

        ; CLOSE_VILLAGE

        bcs +

          lda $0000,b,y
          and #$00FF
          jsl rlGetLocationEventDataEntry
          jsl rlGetEventLocationEntryType
          cmp #LocationTypeVillage
          bne +

            jsl rlSetVillageClosed

        +
        inc y
        rts

        .databank 0

      rsChapterEventConditionCommandOpenVillage ; 86/9830

        .al
        .autsiz
        .databank ?

        bcs +

          lda $0000,b,y
          and #$00FF
          jsl rlGetLocationEventDataEntry
          jsl rlGetEventLocationEntryType
          cmp #LocationTypeVillage
          bne +

            jsl rlSetVillageOpen
            lda #10
            jsl rlPlaySoundEffect2

        +
        inc y
        rts

        .databank 0

      rsChapterEventConditionCommandAddUnitStat ; 86/9852

        .al
        .autsiz
        .databank ?

        ; ADD_UNIT_STAT

        bcs _End

          lda $0000,b,y
          and #$00FF
          cmp #$00FF
          beq +

            jsl rlGetUnitRAMDataPointerByID
            bcs _End
            bra ++

            +
            lda wEventUnit1Pointer,b
            sta wSelectedUnitDataRAMPointer,b

          +
          lda $0001,b,y
          and #$00FF
          sta wRoutineVariable1,b
          asl a
          tax
          lda $0002,b,y
          and #$00FF
          jsl rlAddSelectedUnitStat
          sta aActionStructUnit1.LevelUpData.HPGain,x 

        _End
        inc y
        inc y
        inc y
        rts

        .databank 0

      rsChapterEventConditionCommandRemoveAreaRestriction ; 86/988A

        .al
        .autsiz
        .databank ?

        ; REMOVE_AREA_RESTRICTION

        bcs +

          lda $0000,b,y
          and #$00FF
          jsl rlUnknown81B43F

        +
        inc y
        rts

        .databank 0

      rsChapterEventConditionCommandSetAreaRestriction ; 86/9898

        .al
        .autsiz
        .databank ?

        bcs +

          lda $0000,b,y
          and #$00FF
          jsl rlUnknown81B461

        +
        inc y
        rts

        .databank 0

      rsChapterEventConditionCommand73 ; 86/98A6

        .al
        .autsiz
        .databank ?

        bcs +

          jsl rlUnknown84DE36

        +
        rts

        .databank 0

      rsChapterEventConditionCommandCombatantsStayOnMap ; 86/98AD

        .al
        .autsiz
        .databank ?

        ; COMBATANTS_STAY_ON_MAP

        bcs +

          lda aActionStructUnit1.TriggerableSkills
          ora #CombatSkillFlagStayOnMap
          sta aActionStructUnit1.TriggerableSkills

          lda aActionStructUnit2.TriggerableSkills
          ora #CombatSkillFlagStayOnMap
          sta aActionStructUnit2.TriggerableSkills

        +
        rts

        .databank 0

      rsChapterEventConditionCommandSetUnitStatus ; 86/98C6

        .al
        .autsiz
        .databank ?

        bcs +

          lda $0000,b,y
          jsl rlGetUnitRAMDataPointerByID
          bcs +

            lda $0002,b,y
            and #$00FF
            jsl rlSetSelectedUnitStatus
            lda $0003,b,y
            and #$00FF
            jsl rlSetSelectedUnitStatusDuration

        +
        tya
        clc
        adc #4
        tay
        rts

        .databank 0

      rsChapterEventConditionCommandReplaceUnit ; 86/98EC

        .al
        .autsiz
        .databank ?

        ; REPLACE_UNIT

        bcs _End

          lda $0000,b,y
          jsl rlGetUnitRAMDataPointerByID
          bcs _End

            jsl rlGetSelectedUnitFactionSlot
            sta wR0

            lda wSelectedUnitDataRAMPointer,b
            pha

            ldx wSelectedUnitDataRAMPointer,b
            lda $7E0001+1,x
            sta lR19+1
            lda $7E0001,x
            sta lR19
            lda $0002,b,y
            jsl rlLoadUnit

            ldx wSelectedUnitDataRAMPointer,b
            lda $7E0001+1,x
            sta lR20+1
            lda $7E0001,x
            sta lR20

            lda lR19+1
            sta $7E0001+1,x
            lda lR19
            sta $7E0001,x
            jsl rlGetSelectedUnitDeploymentOffset
            tax
            lda wSelectedUnitDataRAMPointer,b
            sta aDeploymentTable._UnitRAMPointer,x
            lda #Factionless
            jsl rlSetSelectedUnitFaction

            lda wR0
            jsl rlAssignUnitToFactionSlot

            plx
            stx wSelectedUnitDataRAMPointer,b

            lda lR20+1
            sta $7E0001+1,x
            lda lR20
            sta $7E0001,x
            lda wR0
            jsl rlSetSelectedUnitFaction
            jsl rlUndeployUnit
            jsl rlDeleteUnit
        
        _End
        tya
        clc
        adc #4
        tay
        rts

        .databank 0

      rsChapterEventConditionCommandClearTalkIfOneMarried ; 86/9970

        .al
        .autsiz
        .databank ?

        ; CLEAR_TALK_IF_ONE_MARRIED

        bcs _Skip

          lda wSelectedUnitDataRAMPointer,b
          pha

          phb
          phy
          lda $0000,b,y
          tax

          sep #$20
          lda $0000+2,b,y
          pha
          rep #$20
          plb

            _Loop
            lda $0000,b,x
            bmi _End

            lda $0001,b,x
            and #$00FF
            jsl rlGetUnitRAMDataPointerByID
            bcs _Next

              jsl rlGetSelectedUnitLoverGenerationID
              ora #0
              bne +

                ldy wSelectedUnitDataRAMPointer,b
                lda $0000,b,x
                and #$00FF
                jsl rlGetUnitRAMDataPointerByID
                bcs _Next

                  jsl rlGetSelectedUnitLoverGenerationID
                  ora #0
                  beq _Next

              sty wSelectedUnitDataRAMPointer,b

              +
              lda #0
              jsl rlSetSelectedUnitTalkTarget

            _Next
            inc x
            inc x
            bra _Loop

          _End
          ply
          plb
          pla
          sta wSelectedUnitDataRAMPointer,b
        
        _Skip
        inc y
        inc y
        inc y
        rts

        .databank 0

      rsChapterEventConditionCommandSaveChapterTurncount ; 86/99CF

        .al
        .autsiz
        .databank ?

        ; SAVE_CHAPTER_TURNCOUNT

        bcs +

          jsl rlSaveChapterTurncount

        +
        rts

        .databank 0

      rlSetEventFlag ; 86/99D6

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        phy
        cmp #80
        bcs +

          pha

          ; This grabs the byte to modify

          lsr a
          lsr a
          lsr a
          clc
          adc lChapterEventRAMDataEntryPointer,b
          tay

          sep #$20
          lda lChapterEventRAMDataEntryPointer+2,b
          pha
          rep #$20
          plb

          ; The bit to modify grabs the corresponding mask

          pla
          and #$0007
          tax
          sep #$20
          lda structChapterEventRAMEntry.TemporaryEventFlags,b,y
          ora aSetEventFlagMask,x
          sta structChapterEventRAMEntry.TemporaryEventFlags,b,y
          rep #$20

        +
        ply
        plx
        plp
        plb
        rtl

        .databank 0

      aSetEventFlagMask ; 86/9A0B

        .byte $01
        .byte $02
        .byte $04
        .byte $08
        .byte $10
        .byte $20
        .byte $40
        .byte $80

      rlUnsetEventFlag ; 86/9A13

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        phy
        cmp #80
        bcs +

          pha

          lsr a
          lsr a
          lsr a
          clc
          adc lChapterEventRAMDataEntryPointer,b
          tay

          sep #$20
          lda lChapterEventRAMDataEntryPointer+2,b
          pha
          rep #$20
          plb

          pla
          and #$0007
          tax
          sep #$20
          lda structChapterEventRAMEntry.TemporaryEventFlags,b,y
          and aUnsetEventFlagMask,x
          sta structChapterEventRAMEntry.TemporaryEventFlags,b,y
          rep #$20

        +
        ply
        plx
        plp
        plb
        rtl

        .databank 0

      aUnsetEventFlagMask ; 86/9A48

        .byte ~$01
        .byte ~$02
        .byte ~$04
        .byte ~$08
        .byte ~$10
        .byte ~$20
        .byte ~$40
        .byte ~$80

      rlCheckEventFlagSet ; 86/9A50

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        phy
        cmp #80
        bcs +

          pha

          lsr a
          lsr a
          lsr a
          clc
          adc lChapterEventRAMDataEntryPointer,b
          tay

          sep #$20
          lda lChapterEventRAMDataEntryPointer+2,b
          pha
          rep #$20
          plb

          pla
          and #$0007
          tax
          lda structChapterEventRAMEntry.TemporaryEventFlags,b,y
          and #$00FF
          and aCheckEventFlagSetMask,x
          bne ++

        +
        ply
        plx
        plp
        plb
        clc
        rtl

        +
        ply
        plx
        plp
        plb
        sec
        rtl

        .databank 0

      aCheckEventFlagSetMask ; 86/9A8A

        .byte $01
        .byte $02
        .byte $04
        .byte $08
        .byte $10
        .byte $20
        .byte $40
        .byte $80

      rlGetChapterEventCounter ; 86/9A92

        .al
        .autsiz
        .databank ?

        ; Input:
        ; wEventEngineParameter1 = 0 or 1

        ; Output:
        ; A = value

        phb
        php
        phk
        plb
        phy
        lda wEventEngineParameter1,b
        cmp #2
        bcs _End

          ldy lChapterEventRAMDataEntryPointer,b
          sep #$20
          lda lChapterEventRAMDataEntryPointer+2,b
          pha
          rep #$20
          plb

          tya
          clc
          adc wEventEngineParameter1
          tay
          lda structChapterEventRAMEntry.Counter1,b,y
          and #$00FF

        _End
        ply
        plp
        plb
        rtl

        .databank 0

      rlSetChapterEventCounter ; 86/9ABC

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = value to set
        ; wEventEngineParameter1 = 0 or 1

        phb
        php
        phk
        plb
        phy
        pha
        lda wEventEngineParameter1,b
        cmp #2
        bcs _End

          ldy lChapterEventRAMDataEntryPointer,b
          sep #$20
          lda lChapterEventRAMDataEntryPointer+2,b
          pha
          rep #$20
          plb

          tya
          clc
          adc wEventEngineParameter1
          tay
          pla
          sep #$20
          sta structChapterEventRAMEntry.Counter1,b,y
          rep #$20

        _End
        ply
        plp
        plb
        rtl

        .databank 0

      rlIncrementChapterEventCounter ; 86/9AE9

        .al
        .autsiz
        .databank ?

        ; Input:
        ; wEventEngineParameter1 = 0 or 1

        ; Output:
        ; A = value

        phb
        php
        phk
        plb
        phy
        lda wEventEngineParameter1,b
        cmp #2
        bcs _End

          ldy lChapterEventRAMDataEntryPointer,b
          sep #$20
          lda lChapterEventRAMDataEntryPointer+2,b
          pha
          rep #$20
          plb

          tya
          clc
          adc wEventEngineParameter1
          tay
          sep #$20
          lda structChapterEventRAMEntry.Counter1,b,y
          inc a
          sta structChapterEventRAMEntry.Counter1,b,y
          rep #$20
          and #$00FF

        _End
        ply
        plp
        plb
        rtl

        .databank 0

      rlDecrementChapterEventCounter ; 86/9B1B

        .al
        .autsiz
        .databank ?

        ; Input:
        ; wEventEngineParameter1 = 0 or 1

        ; Output:
        ; A = value

        phb
        php
        phk
        plb
        phy
        lda wEventEngineParameter1,b
        cmp #2
        bcs _End

          ldy lChapterEventRAMDataEntryPointer,b
          sep #$20
          lda lChapterEventRAMDataEntryPointer+2,b
          pha
          rep #$20
          plb

          tya
          clc
          adc wEventEngineParameter1
          tay
          sep #$20
          lda structChapterEventRAMEntry.Counter1,b,y
          dec a
          sta structChapterEventRAMEntry.Counter1,b,y
          rep #$20
          and #$00FF

        _End
        ply
        plp
        plb
        rtl

        .databank 0

      rlCheckEventParameters ; 86/9B4D

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        sep #$20
        cmp bEventActionIdentifier,b
        bne _CLC

          rep #$20

          ora #0
          bmi _SEC

            asl a
            tax
            jsr (aEventCheckParametersByIdentifier,x)
            bcc _CLC

          _SEC
          plx
          plp
          plb
          sec
          rtl
        
        _CLC
        plx
        plp
        plb
        clc
        rtl

        .databank 0

      aEventCheckParametersByIdentifier ; 86/9B71

        .word <>rsEventTrue ; $00
        .word <>rsEventCheck2Parameters ; $01
        .word <>rsEventCheck2Parameters ; $02
        .word <>rsEventCheckUnitInArea ; $03
        .word <>rsEventTrue ; $04
        .word <>rsEventTrue ; $05
        .word <>rsEventCheck2Parameters ; $06
        .word <>rsEventCheck2Parameters ; $07
        .word <>rsEventCheck2Parameters ; $08
        .word <>rsEventCheck2Parameters ; $09
        .word <>rsEventCheck2Parameters ; $0A
        .word <>rsEventTrue ; $0B
        .word <>rsEventTrue ; $0C
        .word <>rsEventTrue ; $0D
        .word <>rsEventTrue ; $0E
        .word <>rsEventTrue ; $0F
        .word <>rsEventTrue ; $10
        .word <>rsEventTrue ; $11
        .word <>rsEventTrue ; $12
        .word <>rsEventTrue ; $13
        .word <>rsEventTrue ; $14
        .word <>rsEventTrue ; $15
        .word <>rsEventTrue ; $16
        .word <>rsEventTrue ; $17
        .word <>rsEventTrue ; $18
        .word <>rsEventTrue ; $19
        .word <>rsEventCheck2Parameters ; $1A
        .word <>rsEventCheck1Parameter ; $1B
        .word <>rsEventCheck2Parameters ; $1C
        .word <>rsEventCheck1Parameter ; $1D
        .word <>rsEventTrue ; $1E
        .word <>rsEventTrue ; $1F
        .word <>rsEventCheck1Parameter ; $20
        .word <>rsEventCheck4Parameters ; $21 - turn event stuff?
        .word <>rsEventTrue ; $22
        .word <>rsEventTrue ; $23
        .word <>rsEventTrue ; $24
        .word <>rsEventTrue ; $25
        .word <>rsEventCheck3Parameters ; $26
        .word <>rsEventTrue ; $27

      rsEventTrue ; 86/9BC1

        .al
        .autsiz
        .databank ?

        sec
        rts

        .databank 0

      rsEventCheck1Parameter ; 86/9BC3

        .al
        .autsiz
        .databank ?

        lda wEventEngineParameter1,b
        bmi _SEC

          lda wEventEngineArgument1,b
          cmp wEventEngineParameter1,b
          bne +

        _SEC
        sec
        rts

        +
        clc
        rts

        .databank 0

      rsEventCheck2Parameters ; 86/9BD4

        .al
        .autsiz
        .databank ?

        lda wEventEngineParameter1,b
        bmi +

          lda wEventEngineArgument1,b
          cmp wEventEngineParameter1,b
          bne _CLC

        +
        lda wEventEngineParameter2,b
        bmi _SEC

          lda wEventEngineArgument2,b
          cmp wEventEngineParameter2,b
          bne _CLC

        _SEC
        sec
        rts
        
        _CLC
        clc
        rts

        .databank 0

      rsEventCheck3Parameters ; 86/9BF2

        .al
        .autsiz
        .databank ?

        lda wEventEngineParameter1,b
        bmi +

          lda wEventEngineArgument1,b
          cmp wEventEngineParameter1,b
          bne _CLC
        
        +
        lda wEventEngineParameter2,b
        bmi +

          lda wEventEngineArgument2,b
          cmp wEventEngineParameter2,b
          bne _CLC
        
        +
        lda wEventEngineParameter3,b
        bmi +

          lda wEventEngineArgument3,b
          cmp wEventEngineParameter3,b
          bne _CLC
        
        +
        sec
        rts
        
        _CLC
        clc
        rts

        .databank 0

      rsEventCheck4Parameters ; 86/9C1D

        .al
        .autsiz
        .databank ?

        lda wEventEngineParameter1,b
        bmi +

          lda wEventEngineArgument1,b
          cmp wEventEngineParameter1,b
          bne _CLC
        
        +
        lda wEventEngineParameter2,b
        bmi +

          lda wEventEngineArgument2,b
          cmp wEventEngineParameter2,b
          bne _CLC
        
        +
        lda wEventEngineParameter3,b
        bmi +

          lda wEventEngineArgument3,b
          cmp wEventEngineParameter3,b
          bne _CLC
        
        +
        lda wEventEngineParameter4,b 
        bmi +

          lda wEventEngineArgument4,b
          cmp wEventEngineParameter4,b
          bne _CLC
        
        +
        sec
        rts
        
        _CLC
        clc
        rts

        .databank 0

      rsEventCheckUnitInArea ; 86/9C55

        .al
        .autsiz
        .databank ?

        lda wEventEngineParameter4,b
        bmi +

          lda wEventEngineArgument4,b
          cmp wEventEngineParameter4,b
          bne _CLC
        
        +
        lda wEventEngineParameter1,b
        bmi +

          lda wEventEngineArgument1,b
          cmp wEventEngineParameter1,b
          bne _CLC
        
        +
        sep #$20
        lda wEventEngineArgument2,b
        cmp wEventEngineParameter2,b
        bmi _CLC

          dec a
          cmp wEventEngineParameter3,b
          bpl _CLC

            lda wEventEngineArgument3,b
            cmp wEventEngineParameter2+1,b
            bmi _CLC

              dec a
              cmp wEventEngineParameter3+1,b
              bpl _CLC

        rep #$20
        sec
        rts
        
        _CLC
        rep #$20
        clc
        rts

        .databank 0

      rsEventUnifyGen2CharacterIds ; 86/9C95

        .al
        .autsiz
        .databank ?

        phy
        sec
        sbc #Seliph
        tax
        lda aEventsUnifiedGen2CharacterIds,x
        and #$00FF
        clc
        ply
        rts

        .databank 0

      aEventsUnifiedGen2CharacterIds ; 86/9CA5

        .byte Seliph ; Seliph
        .byte Shannan ; Shannan
        .byte Dalvin ; Dalvin
        .byte Asaello ; Asaello
        .byte Leif ; Leif
        .byte Iuchar ; Iuchar
        .byte Charlot ; Charlot
        .byte Hawk ; Hawk
        .byte Tristan ; Tristan
        .byte AdultFinn ; AdultFinn
        .byte Deimne ; Deimne
        .byte Hannibal ; Hannibal
        .byte Ares ; Ares
        .byte Amid ; Amid
        .byte Oifey ; Oifey
        .byte Daisy ; Daisy
        .byte Creidne ; Creidne
        .byte Muirne ; Muirne
        .byte Julia ; Julia
        .byte Altena ; Altena
        .byte Hermina ; Hermina
        .byte Linda ; Linda
        .byte Laylea ; Laylea
        .byte Jeanne ; Jeanne
        .byte Iucharba ; Iucharba
        .byte Dalvin ; Scathach
        .byte Asaello ; Febail
        .byte Charlot ; Coirpre
        .byte Hawk ; Ced
        .byte Tristan ; Diarmuid
        .byte Deimne ; Lester
        .byte Amid ; Arthur
        .byte Daisy ; Patty
        .byte Creidne ; Larcei
        .byte Muirne ; Lana
        .byte Hermina ; Fee
        .byte Linda ; Tine
        .byte Laylea ; Lene
        .byte Jeanne ; Nanna

      ; 86/9CCC

    .endsection EventEngineSection


    .section ChapterEventDataSection

      .al
      .xl

      rlUnknown86C4C4 ; 86/C4C4

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = current chapter

        phx

        sta lR18
        asl a
        clc
        adc lR18
        tax
        lda aChapterEventPointers+1,x
        sta lR18+1
        lda aChapterEventPointers,x
        beq +

          sta lR18
          jsl rlBeginChapterEvents

          lda #0
          sta $7E52EE
          sta $7E52EE+1

        +
        plx
        rtl

        .databank 0

      rlUnknown86C4EB ; 86/C4EB

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        phy

        ldx #1

          _Loop
          txa
          jsl rlGetChapterEventRAMEntryPointerByID
          bcs _End

            phx
            ldy lChapterEventRAMDataEntryPointer,b

            sep #$20
            lda lChapterEventRAMDataEntryPointer+2,b
            pha
            rep #$20
            plb

            lda structChapterEventRAMEntry.Chapter,b,y
            asl a
            clc
            adc structChapterEventRAMEntry.Chapter,b,y
            tax

            lda aChapterEventPointers+1,x
            sta structChapterEventRAMEntry.EventPointer+1,b,y
            lda aChapterEventPointers,x
            sta structChapterEventRAMEntry.EventPointer,b,y
            plx
            inc x
            bra _Loop

        _End
        ply
        plx
        plp
        plb
        rtl

        .databank 0

      rlSetChapterEventDataPointerByID ; 86/C528

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = chapter ID

        phb
        php
        phk
        plb
        phx
        sta lR18

        asl a
        clc
        adc lR18
        tax

        lda aChapterEventDataPointers+1,x
        sta lR18+1
        lda aChapterEventDataPointers,x
        sta lR18
        jsl rlSetChapterEventDataPointer

        plx
        plp
        plb
        rtl

        .databank 0

      rlUnknown86C548 ; 86/C548

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb

        lda #0
        sta aChapterActiveMapChanges
        sta aChapterActiveMapChanges+2

        plp
        plb
        rtl

        .databank 0

      rlGetFactionGroupPointerByID ; 86/C55A

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = ID

        ; Output:
        ; Y = Pointer

        phx
        phk
        plb

        pha
        asl a
        clc
        adc #1,s
        tax
        pla

        sep #$20
        lda aFactionGroupPointers+2,x
        pha
        rep #$20
        plb

        lda aFactionGroupPointers,x
        tay

        plx
        rtl

        .databank 0

      rlUpdateMapChangeEvents ; 86/C575

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        phy
        jsl rlGetChapterMapChangesPointer

        lda lR18
        beq _End

          ldy lR18
          sep #$20
          lda lR18+2
          pha
          rep #$20
          plb

          ldx #0
          
          _Loop
          lda structChapterMapChangeEntry.ChapterID,b,y
          cmp #$FFFF
          beq _End

            pha
            lda structChapterMapChangeEntry.Flag,b,y
            and #$00FF
            sta wEventEngineParameter1,b
            pla

            jsl rlCheckIfEventFlagOfSpecifiedChapterSet
            bcc +

              txa
              jsr rsCheckIfChapterMapChanceActive
              bcs +

                txa
                jsr rsSetChapterMapChangeActive
                lda structChapterMapChangeEntry.XPosition,b,y
                and #$00FF
                sta wR0
                lda structChapterMapChangeEntry.YPosition,b,y
                and #$00FF
                sta wR1
                lda structChapterMapChangeEntry.MapChangeData,b,y
                jsl rlApplyMapTileChange

            +
            tya
            clc
            adc #size(structChapterMapChangeEntry)
            tay
            inc x
            bra _Loop

        _End
        jsl rlUnknown888410
        ply
        plx
        plp
        plb
        rtl

        .databank 0

      rsCheckIfChapterMapChanceActive ; 86/C5DC

        .al
        .autsiz
        .databank `aActiveMapChangesLookupTable

        ; Input:
        ; A = Map change ID

        phb
        phk
        plb
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
        and aActiveMapChangesLookupTable,y
        bne +

        clc
        
        -
        ply
        plx
        plb
        rts
        
        +
        sec
        bra -

        .databank 0

      rsSetChapterMapChangeActive ; 86/C5FF

        .al
        .autsiz
        .databank `aActiveMapChangesLookupTable

        ; Input:
        ; A = Map change ID

        phb
        phk
        plb
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
        sep #$20
        lda aChapterActiveMapChanges,x
        ora aActiveMapChangesLookupTable,y
        sta aChapterActiveMapChanges,x
        rep #$20
        ply
        plx
        plb
        rts

        .databank 0

      aActiveMapChangesLookupTable ; 86/C621

        .byte $01
        .byte $02
        .byte $04
        .byte $08
        .byte $10
        .byte $20
        .byte $40
        .byte $80

        ; 86/C629

    .endsection ChapterEventDataSection


    .section ApplyMapTileChangeSection

      .al
      .xl

      rlApplyMapTileChange ; 86/C6E8

        .al
        .autsiz
        .databank ?

        phx
        phy
        tay
        lda wR1
        xba
        lsr a
        lsr a
        clc
        adc wR0
        asl a
        tax
        lda $0000,b,y
        and #$00FF
        sta wR12
        lda $0001,b,y
        and #$00FF
        sta wR11

        lda #64
        sec
        sbc wR12
        asl a
        sta wR13
        
          _OuterLoop
          lda wR12
          sta wR10
          
            _InnerLoop
            lda $0002,b,y
            bmi +

              lda aMapData,x
              and #$FC00
              ora $0002,b,y
              sta aMapData,x

            +
            inc y
            inc y
            inc x
            inc x
            dec wR10
            bne _InnerLoop

          txa
          clc
          adc wR13
          tax
          dec wR11
          bne _OuterLoop

        ply
        plx
        rtl

        .databank 0

        ; 86/C739

    .endsection ApplyMapTileChangeSection


    .section Unsorted81B2AASection

      .al
      .xl

      rlSaveChapterTurncount ; 81/B2AA

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        lda wCurrentChapter,b
        cmp #5
        beq +

        cmp #11
        bne ++

        +
        lda #FS_Player
        jsl rlCountUnitsInFactionSlotAlive
        clc
        adc wTotalAlivePlayerUnitCount
        sta wTotalAlivePlayerUnitCount

        +
        lda wCurrentChapter,b
        asl a
        tax
        lda wCurrentTurn,b
        sta aChapterTurncounts,b,x
        lda #$FFFF
        sta wCurrentTurn,b
        lda #$0400
        tsb wUnknown000D79,b
        jsl rlClearUnitWindowAndTerrainWindowProcs

        lda wCurrentChapter,b
        cmp #11
        beq +

          lda wActiveUnitDeploymentOffset,b
          sta wUnitRelocationDeploymentOffset,b
          lda #6
          sta wUnitRelocationType,b
          bra +

        +
        plx
        plp
        plb
        rtl

        .databank 0

        ; 81/B301

    .endsection Unsorted81B2AASection


    .section Unsorted81B43FSection

      .al
      .xl

      rlUnknown81B43F ; 81/B43F

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        dec a
        cmp #6
        bcs +

          tax
          sep #$20
          lda wAreaRestrictionBitfield,b
          ora aUnknown81B45B,x
          sta wAreaRestrictionBitfield,b
          rep #$20

        +
        plp
        plb
        rtl

        .databank 0

        ; 81/B45B

    .endsection Unsorted81B43FSection


    .section Unsorted81B461Section

      .al
      .xl

      rlUnknown81B461 ; 81/B461

        .al
        .autsiz
        .databank ?


        phb
        php
        phk
        plb
        dec a
        cmp #6
        bcs +

          tax
          sep #$20
          lda wAreaRestrictionBitfield,b
          and aUnknown81B47D,x
          sta wAreaRestrictionBitfield,b
          rep #$20

        +
        plp
        plb
        rtl

        .databank 0

        ; 81/B47D

    .endsection Unsorted81B461Section


    .section Unsorted84B57ASection

      .al
      .xl

      rlUnknown84B57A ; 84/B57A

        .al
        .autsiz
        .databank ?

        ; entering castle menu

        phb
        php
        phk
        plb
        phx
        ldx wRoutineVariable1,b
        phx

        lda #$0010
        trb wUnknown000D79,b

        ldx wSelectedUnitDataRAMPointer,b
        lda #$2100
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitCharacterID
        sta wRoutineVariable1,b
        jsl rlClearSelectedUnitRAMAreaData
        stx wSelectedUnitDataRAMPointer,b

        lda #UnitStateMiracleActive
        jsl rlUnsetSelectedUnitStates
        jsl rlGetSelectedUnitDeploymentOffset
        tax
        lda aDeploymentTable._StateBuffer,x
        bit #DeploymentStateDefeated
        bne _B5FB

          lda aActionStructUnit1.ObtainedArenaMoney
          beq _B5EE

            jsl rlGetSelectedUnitMaxHP
            jsl rlSetSelectedUnitCurrentHP

            lda #$001C
            sta bEventActionIdentifier,b
            jsl rlGetSelectedUnitCharacterID
            sta wEventEngineArgument1,b
            jsl rlGetEventLocationEntryID
            sta wEventEngineArgument2,b
            lda wRoutineVariable1,b
            sta wEventEngineArgument3,b
            jsl rlGetAndRunChapterMapEventConditions

            lda aActionStructUnit1.ObtainedArenaMoney

            plx
            stx wRoutineVariable1,b
            plx
            plp
            plb
            sec

            -
            rtl

          _B5EE
          lda #0

          plx
          stx wRoutineVariable1,b
          plx
          plp
          plb
          sec
          bra -

        _B5FB
        and #~DeploymentStateDefeated
        sta aDeploymentTable._StateBuffer,x
        sta aDeploymentTable._State,x
        lda #0

        plx
        stx wRoutineVariable1,b
        plx
        plp
        plb
        clc
        bra -

        .databank 0

      rlUnknown84B613 ; 84/B613

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phy
        ldy lR18
        sep #$20
        lda lR18+2
        pha
        rep #$20
        plb

        lda $0000,b,y
        jsl rlGetUnitRAMDataPointerByID
        bcs _End

          jsl rlGetSelectedUnitDeploymentOffset
          sta wR0

          lda $0002,b,y
          and #$00FF
          sta wSelectedInventorySlot,b

          lda $0004,b,y
          jsl rlGetUnitRAMDataPointerByID
          bcs _End

            jsl rlGetSelectedUnitDeploymentOffset
            sta wR1

            lda lR18
            clc
            adc #$000D
            sta lR18

            lda lR18
            pha
            lda lR18+1
            pha

            jsl rlActionStructGetBattleStats

            sep #$20
            lda $000D,b,y
            and #$01
            ora wBattleStatus
            sta wBattleStatus
            rep #$20

            lda $0007,b,y
            sta lR18
            lda $0007+1,b,y
            sta lR18+1
            lda #0
            jsl rlSetBattleDeathQuotes

            lda $000A,b,y
            sta lR18
            lda $000A+1,b,y
            sta lR18+1
            lda #1
            jsl rlSetBattleDeathQuotes

            pla
            sta lR18+1
            pla
            sta lR18

            sep #$20
            lda #0
            sta wBattleType
            rep #$20

            jsl rlActionStructBuildScriptedBattleRounds

        _End
        ply
        plp
        plb
        rtl

        .databank 0

        ; 84/B6A6

    .endsection Unsorted84B57ASection


