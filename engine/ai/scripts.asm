; The AI script interpreter and its commands, which set each group's goals.

    .section AIScriptSection

      .al
      .xl

      rlRunAIScript ; 87/CCAA

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        phy

        jsl rlClearTargetMap

        lda #1
        sta wAIUnknown7E2002
        lda #0
        sta wAIFormationType
        sta wAIFormationDirection
        sta wAIIgnoredGenerationID

        lda #round(0.7 * 256)
        jsr rsSetAIGroupLeaderScaledFieldMovement

        lda #$FFFF
        sta wAIUnknown7E2018
        lda #0
        sta wAIGroupObjective

        lda wAICurrentAISetting,b
        jsl rlTryGetGroupLeaderCoordinates

        lda wAITemp000E96,b
        sta wAIGroupLeaderXPosition
        sta wAIUnknown7E2014

        lda wAITemp000E98,b
        sta wAIGroupLeaderYPosition
        sta wAIUnknown7E2016

        lda wAIUnknownBitfield7E2000
        bit #$0008
        beq +

          ; Group leader is dead
          lda wAIGroupHighestItemRange
          cmp #10
          bcs +

            ; Max weapon range of group is 9 or less
            jsr rsAIScriptCommand18
            bra _End

        +
        ldy lAITemp000E90,b
        sep #$20
        lda lAITemp000E90+2,b
        pha
        rep #$20
        plb
        
        _Loop
        lda $0000,b,y
        and #$00FF
        cmp #$00FF
        beq _End

        inc y
        asl a
        tax
        jsr (aAIScriptCommands,x)
        bcs _End
        bra _Loop
        
        _End
        ply
        plx
        plp
        plb
        rtl

        .databank 0

      aAIScriptCommands ; 87/CD38

        .word <>rsAIScriptCommand00 ; $00
        .word <>rsAIScriptCommand01 ; $01
        .word <>rsAIScriptCommand02 ; $02
        .word <>rsAIScriptCommand03 ; $03
        .word <>rsAIScriptCommand04 ; $04
        .word <>rsAIScriptCommand05 ; $05
        .word <>rsAIScriptCommand06 ; $06
        .word <>rsAIScriptCommand07 ; $07
        .word <>rsAIScriptCommand08 ; $08
        .word <>rsAIScriptCommand09 ; $09
        .word <>rsAIScriptCommand0A ; $0A
        .word <>rsAIScriptCommand0B ; $0B
        .word <>rsAIScriptCommand0C ; $0C
        .word <>rsAIScriptCommand0D ; $0D
        .word <>rsAIScriptCommand0E ; $0E
        .word <>rsAIScriptCommand0F ; $0F
        .word <>rsAIScriptCommand10 ; $10
        .word <>rsAIScriptCommand11 ; $11
        .word <>rsAIScriptCommand12 ; $12
        .word <>rsAIScriptCommand13 ; $13
        .word <>rsAIScriptCommand14 ; $14
        .word <>rsAIScriptCommand15 ; $15
        .word <>rsAIScriptCommand16 ; $16
        .word <>rsAIScriptCommand17 ; $17
        .word <>rsAIScriptCommand18 ; $18
        .word <>rsAIScriptCommand19 ; $19
        .word <>rsAIScriptCommand1A ; $1A
        .word <>rsAIScriptCommand1A ; $1B
        .word <>rsAIScriptCommand1A ; $1C
        .word <>rsAIScriptCommand1A ; $1D
        .word <>rsAIScriptCommand1E ; $1E
        .word <>rsAIScriptCommand1F ; $1F
        .word <>rsAIScriptCommand20 ; $20
        .word <>rsAIScriptCommand21 ; $21
        .word <>rsAIScriptCommand22 ; $22
        .word <>rsAIScriptCommand23 ; $23

      rsAIScriptCommand01 ; 87/CD80

        .al
        .autsiz
        .databank ?

        ; AI_JUMP

        lda $0000,b,y
        tay

        clc
        rts

        .databank 0

      rsAIScriptCommand00 ; 87/CD86

        .al
        .autsiz
        .databank ?

        lda #0
        sta wAIGroupObjective
        sec
        rts

        .databank 0

      rsAIScriptCommand02 ; 87/CD8F

        .al
        .autsiz
        .databank ?

        lda $0000,b,y
        and #$00FF
        sta wAIUnknown7E2002
        inc y
        clc
        rts

        .databank 0

      rsAIScriptCommand03 ; 87/CD9C

        .al
        .autsiz
        .databank ?

        ; MODIFY_GROUP_LEADER_FIELD_MOVEMENT

        lda $0000,b,y
        and #$00FF
        beq +

          jsr rsSetAIGroupLeaderScaledFieldMovement

          -
          inc y
          clc
          rts

        +
        jsl rlTryGetAIFactionGroupLeader
        jsl rlGetSelectedUnitTotalFieldMovement
        sta wAIGroupLeaderFieldMovement
        bra -

        .databank 0

      rsSetAIGroupLeaderScaledFieldMovement ; 87/CDB8

        .al
        .autsiz
        .databank ?

        ; A = fraction over 256, eg. 0.7 equals $B7/$FF

        sta wR35

        jsl rlTryGetAIFactionGroupLeader
        jsl rlGetSelectedUnitTotalFieldMovement
        and #$00FF
        xba
        sta wR34

        jsl rlUnsignedMultiply16By16High

        lda wR37
        inc a
        sta wAIGroupLeaderFieldMovement
        rts

        .databank 0

      rsAIScriptCommand04 ; 87/CDD4

        .al
        .autsiz
        .databank ?

        ; AI_SET_IGNORED_GENERATION_ID

        lda $0000,b,y
        and #$00FF
        sta wAIIgnoredGenerationID
        inc y
        clc
        rts

        .databank 0

      rsAIScriptCommand05 ; 87/CDE1

        .al
        .autsiz
        .databank ?

        lda wAIUnknownBitfield7E2000
        ora #$0200
        sta wAIUnknownBitfield7E2000
        rts

        .databank 0

      rsAIScriptCommand06 ; 87/CDED

        .al
        .autsiz
        .databank ?

        ; Mark foes location ID as target tile

        ; 1st byte = Location ID
        ; 2nd byte = ?

        lda $0000,b,y
        and #$00FF
        sta wAITemp000E9A,b

        jsl rlGetLocationEventDataEntry

        lda wAIActiveFaction
        tax
        jsl rlGetLocationFactionSlotOwner
        jsl rlGetFactionRelation
        cmp #AllegianceEnemy
        bne _CLC

          ; Specified location is under foes control
          jsl rlGetEventLocationEntryEffectiveXCoordinate
          sta wAITemp000E96,b

          jsl rlGetEventLocationEntryEffectiveYCoordinate
          sta wAITemp000E98,b

          lda wAITemp000E9A,b
          jsl rlSetTargetMapTile

          lda $0001,b,y
          and #$00FF
          sta wAIUnknown7E2002

          lda #1
          sta wAIGroupObjective

          inc y
          inc y
          sec
          rts

        _CLC
        inc y
        inc y
        clc
        rts

        .databank 0

      rsAIScriptCommand07 ; 87/CE3A

        .al
        .autsiz
        .databank ?

        ; 1st byte = Location ID
        ; 2nd byte = ?

        lda $0000,b,y
        and #$00FF
        sta wAITemp000E9A,b

        jsl rlGetLocationEventDataEntry
        jsl rlGetLocationFactionSlotOwner
        cmp wAIActiveFaction,b
        bne _CLC

          ; Current faction owns specified location

          lda $0001,b,y
          and #$00FF
          cmp #5
          beq _CEA3

          jsl rlAICheckIfAnyGroupUnitCanEngageFoe
          bcs _CEA9

          jsl rlGetEventLocationEntryEffectiveXCoordinate
          sta wAITemp000E96,b

          jsl rlGetEventLocationEntryEffectiveYCoordinate
          sta wAITemp000E98,b

          lda wAITemp000E9A,b
          jsl rlSetTargetMapTile

          lda #6
          sta wAIGroupObjective
          lda $0001,b,y
          and #$00FF
          sta wAIUnknown7E2002

          lda wAIFormationType
          bne +

            ; Set aFormationPatternCastleDefense

            lda #13
            sta wAIFormationType
            lda #0
            sta wAIFormationDirection

          +
          inc y
          inc y
          sec
          rts
        
        _CLC
        inc y
        inc y
        clc
        rts
        
        _CEA3
        inc y
        inc y
        jsr rsAIScriptCommand0B
        rts

        _CEA9
        inc y
        inc y
        jsr rsAIScriptCommand18
        rts

        .databank 0

      rsAIScriptCommand08 ; 87/CEAF

        .al
        .autsiz
        .databank ?

        ; AI_TARGET_VILLAGE

        lda $0000,b,y
        and #$00FF
        jsl rlGetLocationEventDataEntry
        jsl rlGetEventLocationEntryType
        cmp #LocationTypeVillage
        bne _CLC

          ; Is a village

          jsl rlCheckIfVillageClosed
          bcs _CLC

            jsl rlCheckLocationDestroyed
            bcs _CLC

              jsl rlGetEventLocationEntryEffectiveXCoordinate
              sta wAITemp000E96,b
              jsl rlGetEventLocationEntryEffectiveYCoordinate
              sta wAITemp000E98,b

              lda $0000,b,y
              and #$00FF
              jsl rlSetTargetMapTile

              lda #2
              sta wAIGroupObjective

              inc y
              sec
              rts
        
        _CLC
        inc y
        clc
        rts

        .databank 0

      rsAIScriptCommand09 ; 87/CEF3

        .al
        .autsiz
        .databank ?

        ; AI_FLAG_IF_LEADER_ON_COORDS

        lda $0002,b,y
        and #$00FF
        sta wEventEngineParameter1,b

        lda $0000,b,y
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcs _CLC

          lda $0003,b,y
          and #$00FF
          cmp wAIGroupLeaderXPosition
          bne +

            lda $0004,b,y
            and #$00FF
            cmp wAIGroupLeaderYPosition
            bne +

              lda $0002,b,y
              and #$00FF
              jsl rlSetEventFlag
              bra _CLC

          +
          lda $0003,b,y
          and #$00FF
          sta wAITemp000E96,b
          lda $0004,b,y
          and #$00FF
          sta wAITemp000E98,b

          lda #0
          jsl rlSetTargetMapTile

          lda #7
          sta wAIGroupObjective
          lda #0
          sta wAIUnknown7E2002

          tya
          clc
          adc #5
          tay
          sec
          rts

        _CLC
        tya
        clc
        adc #5
        tay
        clc
        rts

        .databank 0

      rsAIScriptCommand0A ; 87/CF60

        .al
        .autsiz
        .databank ?

        jsl rlAICheckIfAnyGroupUnitCanEngageFoe
        bcs +

          lda #4
          sta wAIGroupObjective
          lda #4
          sta wAIUnknown7E2002
          sec
          rts

        +
        jsr rsAIScriptCommand18
        rts

        .databank 0

      rsAIScriptCommand0B ; 87/CF7A

        .al
        .autsiz
        .databank ?

        lda wAIUnknownBitfield7E2000
        bit #$0004
        beq +

          ; Any foe is in groups threat range

          lda #5
          sta wAIGroupObjective
          lda #5
          sta wAIUnknown7E2002
          sec
          rts

        +
        clc
        rts

        .databank 0

      rsAIScriptCommand0C ; 87/CF95

        .al
        .autsiz
        .databank ?

        ; AI_SET_FORMATION

        lda $0000,b,y
        and #$00FF
        sta wAIFormationType
        lda $0001,b,y
        and #$0003
        sta wAIFormationDirection
        inc y
        inc y
        clc
        rts

        .databank 0

      rsAIScriptCommand0D ; 87/CFAD

        .al
        .autsiz
        .databank ?

        ; AI_TARGET_SPECIFIED_UNIT

        lda $0000,b,y
        jsl rlGetUnitRAMDataPointerByID
        bcs _CLC

          jsl rlGetSelectedUnitStates
          bit #UnitStateDead
          bne _CLC

            bit #UnitStateGuardingCastle
            bne _CLC

              jsl rlGetSelectedUnitDeploymentOffset
              tax
              lda aDeploymentTable._XTilePosition,x
              sta wAITemp000E96,b
              lda aDeploymentTable._YTilePosition,x
              sta wAITemp000E98,b

              txa
              lsr a
              jsl rlSetTargetMapTile

              lda #3
              sta wAIGroupObjective

              inc y
              inc y
              sec
              rts
        
        _CLC
        inc y
        inc y
        clc
        rts

        .databank 0

      rsAIScriptCommand0E ; 87/CFEC

        .al
        .autsiz
        .databank $00

        ; AI_INTERACT_WITH_UNIT

        lda $0000,b,y
        jsl rlGetUnitRAMDataPointerByID
        bcs _CLC

          jsl rlGetSelectedUnitDeploymentOffset
          tax
          lda aDeploymentTable._XTilePosition,x
          sta wAITemp000E96,b
          lda aDeploymentTable._YTilePosition,x
          sta wAITemp000E98

          txa
          lsr a
          jsl rlSetTargetMapTile

          lda $0002,b,y
          and #$00FF
          sta wAIUnknown7E201C

          lda #8
          sta wAIGroupObjective

          inc y
          inc y
          inc y
          sec
          rts
        
        _CLC
        inc y
        inc y
        inc y
        clc
        rts

        .databank 0

      rsAIScriptCommand0F ; 87/D029

        .al
        .autsiz
        .databank ?

        lda #9
        sta wAIGroupObjective
        lda #$FFFF
        sta wAIUnknown7E2018
        lda #2
        sta wAIUnknown7E2002

        lda wAIUnknownBitfield7E2000
        ora #$0100
        sta wAIUnknownBitfield7E2000
        sec
        rts

        .databank 0

      rsAIScriptCommand10 ; 87/D04B

        .al
        .autsiz
        .databank ?

        lda wAITargetCounter
        bne _CLC

          lda #12
          sta wAIGroupObjective
          lda #$FFFF
          sta wAIUnknown7E2018
          lda #2
          sta wAIUnknown7E2002
          sec
          rts

        _CLC
        clc
        rts

        .databank 0

      rsAIScriptCommand11 ; 87/D06A

        .al
        .autsiz
        .databank ?

        lda wAIGroupLeaderDeploymentOffset
        cmp #$FFFF
        beq _CLC

          tax
          lda aDeploymentTable._State,x
          bit #DeploymentStateAlive
          beq _CLC

            ; Leader is alive

            lda $0000,b,y
            and #$00FF
            sta wAITemp000E9A,b

            jsl rlGetAliveGroupMembersRatio
            inc a
            cmp wAITemp000E9A,b
            bcs _CLC

              jsr rsAIScriptCommand18

              lda #10
              sta wAIGroupObjective
              lda #$FFFF
              sta wAIUnknown7E2018
              lda #1
              sta wAIUnknown7E2002

              lda wAIUnknownBitfield7E2000
              ora #$0100
              sta wAIUnknownBitfield7E2000

              inc y
              sec
              rts

        _CLC
        inc y
        clc
        rts

        .databank 0

      rsAIScriptCommand12 ; 87/D0B9

        .al
        .autsiz
        .databank ?

        jsr rsAIScriptCommand18

        lda #11
        sta wAIGroupObjective
        lda #$FFFF
        sta wAIUnknown7E2018
        lda #2
        sta wAIUnknown7E2002

        lda wAIUnknownBitfield7E2000
        ora #$0100
        sta wAIUnknownBitfield7E2000

        sec
        rts

        .databank 0

      rsAIScriptCommand13 ; 87/D0DE

        .al
        .autsiz
        .databank ?

        lda #7
        sta wAIGroupObjective
        lda #5
        sta wAIUnknown7E2002

        sec
        rts

        .databank 0

      rsAIScriptCommand14 ; 87/D0EE

        .al
        .autsiz
        .databank ?

        lda wAIUnknownBitfield7E2000
        bit #$0008
        bne +

          ; Group leader alive
          lda wCurrentTurn,b
          sta wR36

          lda $0000,b,y
          and #$00FF
          sta wR37
          jsl rlUnsignedDivide16By16

          lda wR34
          bne +

            jsl rlGetAliveGroupMembersRatio
            cmp #256
            beq +

              lda wAICurrentAISetting,b
              sta wRoutineVariable1,b
              lda wAIActiveFaction,b
              jsl rlReviveFactionsUnitsOfAISetting

              lda wAIUnknownBitfield7E2000
              ora #$0080
              sta wAIUnknownBitfield7E2000

              lda wAICurrentAISetting,b
              jsl rlBuildAIUnitList
        
        +
        inc y
        clc
        rts

        .databank 0

      rsAIScriptCommand15 ; 87/D137

        .al
        .autsiz
        .databank ?

        ; AI_SET_CHAPTER_EVENT_FLAG

        lda $0000,b,y
        jsl rlGetSpecifiedChaptersRAMPointer
        lda $0002,b,y
        and #$00FF
        jsl rlSetEventFlag

        inc y
        inc y
        inc y
        clc
        rts

        .databank 0

      rsAIScriptCommand16 ; 87/D14D

        .al
        .autsiz
        .databank ?

        ; AI_UNSET_CHAPTER_EVENT_FLAG

        lda $0000,b,y
        jsl rlGetSpecifiedChaptersRAMPointer
        lda $0002,b,y
        and #$00FF
        jsl rlUnsetEventFlag

        inc y
        inc y
        inc y
        clc
        rts

        .databank 0

      rsAIScriptCommand17 ; 87/D163

        .al
        .autsiz
        .databank ?

        ; AI_TARGET_REMAINING_VILLAGES

        ; CLC if no villages left

        ldx #0

        -
        txa
        jsl rlGetLocationEventDataEntry
        bcs _CLC

          jsl rlGetEventLocationEntryType
          cmp #LocationTypeVillage
          bne _Next

            jsl rlCheckIfVillageClosed
            bcs _Next

              jsl rlCheckLocationDestroyed
              bcc _SEC

          _Next
          inc x
          bra -

        _CLC
        clc
        rts

        _SEC
        lda #2
        sta wAIGroupObjective
        sec
        rts

        .databank 0

      rsAIScriptCommand18 ; 87/D190

        .al
        .autsiz
        .databank ?

        ; AI_TARGET_ALL_FOES, except wAIIgnoredGenerationID

        ldx #(len(aDeploymentTable._State) - 2)

          _Loop
          txa

          lda aDeploymentTable._State,x
          bit #DeploymentStateAlive
          beq _Next

            bit #DeploymentStateHidden
            bne _Next

              ; Unit is alive and not hidden
              lda aDeploymentTable._UnitRAMPointer,x
              sta wSelectedUnitDataRAMPointer,b
              jsl rlGetSelectedUnitGenerationID
              bcs +

                cmp wAIIgnoredGenerationID
                beq _Next

              +
              jsr rsCheckIfUnitIsEnemyOfCurrentPhase
              bcc _Next

                lda aDeploymentTable._XTilePosition,x
                sta wAITemp000E96,b
                lda aDeploymentTable._YTilePosition,x
                sta wAITemp000E98,b

                lda #1
                jsl rlSetTargetMapTile

          _Next
          dec x
          dec x
          bpl _Loop

        lda #3
        sta wAIGroupObjective
        sec
        rts

        .databank 0

      rsCheckIfUnitIsEnemyOfCurrentPhase ; 87/D1DC

        .al
        .autsiz
        .databank ?

        phx
        lda aDeploymentTable._FactionSlot,x
        ldx wAIActiveFaction,b
        jsl rlGetFactionRelation
        cmp #AllegianceEnemy
        bne +

          plx
          sec
          rts

        +
        plx
        clc
        rts

        .databank 0

      rsAIScriptCommand19 ; 87/D1F3

        .al
        .autsiz
        .databank ?

        jsr rsAIScriptCommand18

        lda #7
        sta wAIUnknown7E2002
        rts

        .databank 0

      rsAIScriptCommand1A ; 87/D1FE

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #$7F
        pha
        rep #$20
        plb
        .databank $7F

        jsl rlTryGetAIFactionGroupLeader
        jsl rlFillMovementCostMap

        lda wAITargetCounter
        sta $4430,b

        stz $4432,b

        ldx #0
        
          _Loop
          lda aAITargetList[0].XPosition,x
          and #$00FF
          sta wAITemp000E96
          lda aAITargetList[0].YPosition,x
          and #$00FF
          sta wAITemp000E98

          lda wAITemp000E98
          xba
          lsr a
          lsr a
          clc
          adc wAITemp000E96
          sta aAIAction.wMapPointer

          stz $442C,b

          lda #-64
          jsr rsAICheckAdjacentTileOpenForSurround
          lda #-1
          jsr rsAICheckAdjacentTileOpenForSurround
          lda #64
          jsr rsAICheckAdjacentTileOpenForSurround
          lda #1
          jsr rsAICheckAdjacentTileOpenForSurround

          lda $442C,b
          cmp #3
          bcc _Next

            lda aAITargetList[0].DeploymentOffset,x
            and #$00FF
            lsr a
            jsl rlSetTargetMapTile
            inc $4432,b
            lda #1
            sta wAIUnknown7E201C
            lda #8
            sta wAIGroupObjective
            lda #0
            sta wAIUnknown7E2002

          _Next
          txa
          clc
          adc #size(structAITargetEntry)
          tax
          dec $4430,b
          bne _Loop

        lda $4432,b
        beq _CLC

          plp
          plb
          sec
          rts

        _CLC
        plp
        plb
        clc
        rts

        .databank 0

      rsAICheckAdjacentTileOpenForSurround ; 87/D2A1

        .al
        .autsiz
        .databank $7F

        phx
        phy
        clc
        adc aAIAction.wMapPointer
        tay
        lda aMovementCostMap,y
        and #$0080
        bne _End

          lda aUnfriendlyUnitMap,y
          and #$00FF
          cmp #$00FF
          bne _End

            lda aAllyUnitMap,y
            and #$00FF
            cmp #$00FF
            beq +

              tax
              lda aDeploymentTable._UnitRAMPointer,x
              sta wSelectedUnitDataRAMPointer
              jsl rlGetSelectedUnitAI
              cmp wAICurrentAISetting
              bne _End

            +
            inc $442C,b
        
        _End
        ply
        plx
        rts

        .databank 0

      rsAIScriptCommand1E ; 87/D2DF

        .al
        .autsiz
        .databank ?

        lda wAIUnknownBitfield7E2000
        bit #$0008
        bne _CLC

          lda wAIGroupLeaderDeploymentOffset
          bmi _CLC

            ; Group leader is alive
            tax
            lda aDeploymentTable._UnitRAMPointer,x
            sta wSelectedUnitDataRAMPointer,b

            jsl rlGetSelectedUnitCurrentHP
            xba
            sta wR36
            jsl rlGetSelectedUnitMaxHP
            sta wR37
            jsl rlUnsignedDivide16By16

            lda wR36
            dec a
            sep #$20
            cmp $0000,b,y
            rep #$20
            bcc _SEC

              jsl rlGetSelectedUnitStates
              bit #UnitStateFielded
              bne _CLC

                lda wR36
                cmp $0001,b,y
                bcs _CLC

            _SEC
            jsr rsAIScriptCommand18
            jsr rsAIScriptCommand0F

            inc y
            inc y
            inc y
            sec
            rts

        _CLC
        inc y
        inc y
        inc y
        clc
        rts

        .databank 0

      rsAIScriptCommand1F ; 87/D333

        .al
        .autsiz
        .databank ?

        ; AI_JUMP_IF_TURN_REACHED

        lda $0000,b,y
        and #$00FF
        dec a
        cmp wCurrentTurn,b
        bcs +

          inc y
          jml rsAIScriptCommand01
        
        +
        inc y
        inc y
        inc y
        clc
        rts

        .databank 0

      rsAIScriptCommand20 ; 87/D349

        .al
        .autsiz
        .databank ?

        ; AI_JUMP_IF_CHAPTER_EVENT_FLAG_SET

        lda $0002,b,y
        and #$00FF
        sta wEventEngineParameter1,b

        lda $0000,b,y
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcc _CLC

          inc y
          inc y
          inc y
          jml rsAIScriptCommand01

        _CLC
        tya
        clc
        adc #5
        tay
        clc
        rts

        .databank 0

      rsAIScriptCommand21 ; 87/D36A

        .al
        .autsiz
        .databank ?

        lda $0002,b,y
        and #$00FF
        sta wEventEngineParameter1,b

        lda $0000,b,y
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcs _CLC

          inc y
          inc y
          inc y
          jml rsAIScriptCommand01

        _CLC
        tya
        clc
        adc #5
        tay
        clc
        rts

        .databank 0

      rsAIScriptCommand22 ; 87/D38B

        .al
        .autsiz
        .databank ?

        jsl rlAICheckIfAnyGroupUnitCanEngageFoe
        bcc _CLC

          jml rsAIScriptCommand01
        
        _CLC
        inc y
        inc y
        clc
        rts

        .databank 0

      rsAIScriptCommand23 ; 87/D399

        .al
        .autsiz
        .databank ?

        lda $0000,b,y
        sta lAITemp000E90,b
        lda $0001,b,y
        sta lAITemp000E90+1,b

        phk
        pea #<>(+)-1
        jml [lAITemp000E90]

        +
        bcc _CLC

          inc y
          inc y
          inc y
          jml rsAIScriptCommand01

        _CLC
        tya
        clc
        adc #5
        tay
        clc
        rts

        .databank 0

      rlGetAliveGroupMembersRatio ; 87/D3BD

        .al
        .autsiz
        .databank ?

        ; Get the total number of units of a group and the total
        ; number of dead units. Then gets the number of alive units, divides it
        ; by the total and returns a ratio over 256 in A.

        phb
        php
        phk
        plb
        phx

        stz wAITemp000E96,b
        stz wAITemp000E98,b

        ldx #1

          _Loop
          stx wRoutineVariable1,b
          lda wAIActiveFaction,b
          jsl rlGetUnitRAMDataPointerByFactionSlotEntryID
          lda wSelectedUnitDataRAMPointer,b
          beq _End

            jsl rlGetSelectedUnitAI
            cmp wAICurrentAISetting,b
            bne +

              inc wAITemp000E98,b

              jsl rlGetSelectedUnitStates
              bit #UnitStateDead
              beq +

                inc wAITemp000E96,b

          +
          inc x
          bra _Loop

        _End
        lda wAITemp000E98,b
        sec
        sbc wAITemp000E96,b
        and #$00FF
        xba
        sta wR36
        lda wAITemp000E98,b
        sta wR37
        jsl rlUnsignedDivide16By16
        lda wR36
        plx
        plp
        plb
        rtl

        .databank 0

      rlAICheckIfAnyGroupUnitCanEngageFoe ; 87/D411

        .al
        .autsiz
        .databank ?

        ; Check if any group member can engage an in-range foe; SEC + select unit if so

        phb
        php

        sep #$20
        lda #`wAIUnknownBitfield7E2000
        pha
        rep #$20
        plb
        .databank `wAIUnknownBitfield7E2000

        phx
        phy

        lda wAIUnknownBitfield7E2000
        bit #$0004
        beq _CLC

          ; Any foe is in groups threat range
          lda wAIUnitCounter
          tay
          ldx #<>aAIUnitList[0]
          
          -
          jsr rsAICheckIfUnitCanEngageAnyTarget
          bcs _SEC

          txa
          clc
          adc #size(structAIUnitEntry)
          tax
          dec y
          bne -

          lda #$0004
          trb wAIUnknownBitfield7E2000
        
        _CLC
        ply
        plx
        plp
        plb
        clc

        -
        rtl
        
        _SEC
        txa
        sec
        sbc #<>aAIUnitList[0]
        sta wAISelectedAIUnitOffset,b

        lda #$0040
        tsb wAIUnknownBitfield7E2000

        ply
        plx
        plp
        plb
        sec
        bra -

        .databank 0

      rsAICheckIfUnitCanEngageAnyTarget ; 87/D45B

        .al
        .autsiz
        .databank $7E

        ; X = aAIUnitList pointer

        phx
        phy
        lda structAIUnitEntry.UnitRAMPointer,b,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetHighestRangeItemInInventory

        lda wCurrentItemDataROMPointer,b
        sta structAIUnitEntry.ItemROMPointer,b,x
        bne +

          jml _CLC

        +
        lda structAIUnitEntry.XPosition,b,x
        and #$00FF
        sta wAITemp000E96,b
        lda structAIUnitEntry.YPosition,b,x
        and #$00FF
        sta wAITemp000E98,b
        jsl rlGetSelectedUnitTotalFieldMovement
        sta wAITemp000EA2,b

        jsl rlGetItemMinimumRange
        sta wAITemp000EA4,b

        jsl rlGetItemMaximumRange
        cmp wAITemp000EA4,b
        beq +

          clc
          adc wAITemp000EA4,b
          sta wAITemp000EA4,b

        +
        jsl rlMarkUnitAttackRangeOnMovementMap

        lda wAITargetCounter
        bne +

          jml _End
        
        +
        sta wAITemp000EA4,b
        ldy #<>aAITargetList[0]

        _Loop
        phx
        lda structAITargetEntry.DeploymentOffset,b,x
        and #$00FF
        tax
        lda aDeploymentTable._State,x
        plx

        bit #(DeploymentStateDefeated | DeploymentStateHidden)
        bne _Next

          lda structAITargetEntry.XPosition,b,y
          and #$00FF
          sta wAITemp000E96,b
          lda structAITargetEntry.YPosition,b,y
          and #$00FF
          sta wAITemp000E98,b

          phx
          lda wAITemp000E98,b
          xba
          lsr a
          lsr a
          clc
          adc wAITemp000E96,b
          tax
          lda aMovementMap,x
          plx

          bit #$0080
          beq _Next

            jsr rsAICheckTargetEngagementViability
            bcs _SEC
        
        _Next
        tya
        clc
        adc #size(structAITargetEntry)
        tay
        dec wAITemp000EA4,b
        bne _Loop

        _CLC
        clc
        
        _End
        ply
        plx
        rts

        _SEC
        sec
        bra _End

        .databank 0

      rsAICheckTargetEngagementViability ; 87/D506

        .al
        .autsiz
        .databank ?

        ; Check expected damage and if unit HP + def/res >= target might; SEC to engage

        stz wAITemp000E96,b
        stz wAITemp000E98,b

        jsl rlAIGetExpectedDamageWrapper
        bcs _SEC

          lda $0000,b,x
          sta wSelectedUnitDataRAMPointer,b
          lda $0005,b,y
          and #$00FF
          cmp #4
          bcs +

            lda $0007,b,x
            bra ++
          
          +
          lda $0008,b,x

          +
          and #$00FF
          sta wAITemp000E9C,b
          jsl rlGetSelectedUnitCurrentHP
          clc
          adc wAITemp000E9C,b
          sep #$20
          cmp $0006,b,y
          rep #$20
          bpl _SEC

          clc
          rts
        
        _SEC
        sec
        rts

        .databank 0

    .endsection AIScriptSection
