; Code from bank $84 not yet assigned to a game system.

    .section Unsorted848E5DSection

      .al
      .xl

      rlUnknown848E5D ; 84/8E5D

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $84
        lda wR12
        pha
        lda wR13
        pha
        lda wCursorXOffset,b
        clc
        adc wMapScrollXPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR12
        lda wCursorYOffset,b
        clc
        adc wMapScrollYPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR13
        lda wR10
        sec
        sbc wR12
        sta $0778,b
        lda wR11
        sec
        sbc wR13
        sta $077A,b
        lda #$0004
        sta wUnknown0007D8,b
        pla
        sta wR13
        pla
        sta wR12
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 84/8EA0

    .endsection Unsorted848E5DSection


    .section Unsorted848EFBSection

      .al
      .xl

      rlUnknown848EFB ; 84/8EFB

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $84
        phx
        asl a
        tax
        lda #$8383
        sta lRoutineVariable+1,b
        lda aTerrainNameOffsets,x
        clc
        adc #$837B
        sta lRoutineVariable,b
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 84/8F17

    .endsection Unsorted848EFBSection


    .section Unsorted84AF17Section

      .al
      .xl

      rlUnknown84AF17 ; 84/AF17

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $84
        jsl rlGetSelectedUnitStates
        bit #$8000
        bne _AF52
        jsl rlGetSelectedUnitHomeCastle
        jsl rlGetLocationEventDataEntry
        jsl rlGetEventLocationEntryEffectiveXCoordinate
        and #$00FF
        sta wRoutineVariable1,b
        jsl rlGetEventLocationEntryEffectiveYCoordinate
        and #$00FF
        xba
        ora wRoutineVariable1,b
        sta wRoutineVariable1,b
        jsl rlUnknown84AEC0
        lda wEventLocationEntry,b
        sta $0580,b
        plp
        plb
        .databank $84
        clc

        _AF51
        rtl


        _AF52
        plp
        plb
        .databank $84
        sec
        bra _AF51

        .databank 0

        ; 84/AF57

    .endsection Unsorted84AF17Section


    .section Unsorted84B32BSection

      .al
      .xl

      rlUnknown84B32B ; 84/B32B

        .al
        .xl
        .autsiz
        .databank ?

        lda wSelectedInventorySlot,b
        bmi _B33A
        jsl rlGetItemROMDataByInventorySlot
        jsl rlUnknown87E762
        bra _B348


        _B33A
        and #$7FFF
        sta wSelectedInventorySlot,b
        jsl rlGetItemROMDataByInventorySlot
        jsl rlUnknown87E801

        _B348
        rtl

        .databank 0

        ; 84/B349

    .endsection Unsorted84B32BSection


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

            jsl rlUnknown84DF87

        _End
        ply
        plp
        plb
        rtl

        .databank 0

        ; 84/B6A6

    .endsection Unsorted84B57ASection


    .section Unsorted84B9D4Section

      .al
      .xl

      rsUnknown84B9D4 ; 84/B9D4

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlGetSelectedUnitStates
        bit #$2000
        beq _BA07
        lda $7F679A
        and #$00FF
        cmp #$00FF
        beq _BA07
        tax
        lda $7E46EB,x
        sta wRoutineVariable1,b
        jsl rlCheckTalkEventEntryAvailable
        bcc _BA07
        lda wR12
        beq _BA04
        txa
        sep #$20
        sta $7F879A
        rep #$20

        _BA04
        sec
        bra _BA08


        _BA07
        clc

        _BA08
        rts

        .databank 0

        ; 84/BA09

      rsUnknown84BA09 ; 84/BA09

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F671A
        and #$00FF
        cmp #$00FF
        beq _BA3C
        tax
        lda aDeploymentTable,x
        bit #$0004
        beq _BA3C
        lda $7E46EB,x
        sta wRoutineVariable1,b
        jsl rlCheckTalkEventEntryAvailable
        bcc _BA3C
        lda wR12
        beq _BA39
        txa
        sep #$20
        sta $7F871A
        rep #$20

        _BA39
        sec
        bra _BA3D


        _BA3C
        clc

        _BA3D
        rts

        .databank 0

        ; 84/BA3E

    .endsection Unsorted84B9D4Section


    .section Unsorted84BA6FSection

      .al
      .xl

      rlUnknown84BA6F ; 84/BA6F

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$2000
        jsl rlUnsetSelectedUnitStates
        jsl rlGetSelectedUnitDeploymentOffset
        tax
        lda $7E489B,x
        and #$FFFB
        sta $7E489B,x
        sta aDeploymentTable,x
        jsl rlGetSelectedUnitHomeCastle
        jsl rlGetLocationEventDataEntry
        bcs _BA9F
        jsl rlCheckIfCastleGuarded
        bcc _BA9F
        jsl rlUnsetCastleGuarded

        _BA9F
        plx
        rtl

        .databank 0

        ; 84/BAA1

    .endsection Unsorted84BA6FSection


    .section Unsorted84BB54Section

      .al
      .xl

      rlUnknown84BB54 ; 84/BB54

        .al
        .autsiz
        .databank ?

        jsl rlCheckIfBattleAnimationOFF
        bcs _Off

        ; On
        jsl rlUnknown81B368
        bra +

        _Off
        jsl rlUnknown81B35B

        +
        rtl

        .databank 0

    .endsection Unsorted84BB54Section


    .section Unsorted84C398Section

      .al
      .xl

      rsUnknown84C398 ; 84/C398

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        ldy wSelectedUnitDataRAMPointer,b
        ldx #$001C

        _C3A0
        lda $7E2000,x
        beq _C3BA
        sta wRoutineVariable1,b
        sty wSelectedUnitDataRAMPointer,b
        jsl rlGetUnitLoveGrowthWithTarget
        sta wRoutineVariable1,b
        txa
        lsr a
        inc a
        jsl rlModifyUnitsLovePoints

        _C3BA
        dec x
        dec x
        bpl _C3A0
        ply
        plx
        rts

        .databank 0

        ; 84/C3C1

      rsUnknown84C3C1 ; 84/C3C1

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        stx wR0
        ldx #$008E

        _C3C8
        lda aDeploymentTable,x
        bit #$0080
        beq _C40B
        lda $7E477B,x
        bne _C40B
        stx wR1
        jsl rlGetUnitsDistance
        cmp #$0002
        bcs _C40B
        sta wRoutineVariable1,b
        lda #$0006
        sec
        sbc wRoutineVariable1,b
        sta wRoutineVariable1,b
        ldy wSelectedUnitDataRAMPointer,b
        lda $7E46EB,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitGenerationID
        bcs _C40B
        cmp #$0010
        bcs _C40B
        sty wSelectedUnitDataRAMPointer,b
        jsl rlModifyUnitsLovePoints

        _C40B
        dec x
        dec x
        bpl _C3C8
        ply
        plx
        rts

        .databank 0

        ; 84/C412

    .endsection Unsorted84C398Section


    .section Unsorted84C412Section

      .al
      .xl

      rlUnknown84C412 ; 84/C412

        .al
        .autsiz
        .databank ?

        ; A = FactionSlot?

        phb
        php
        phk
        plb
        phx
        phy

        ldx wSelectedUnitDataRAMPointer,b
        phx
        ldx wRoutineVariable1,b
        phx

        tay
        ldx #(24 - 1) * size(word)
        lda #0
        
          -
          sta $7E2000,x
          dec x
          dec x
          bpl -

        ldx #1
        
          -
          stx wRoutineVariable1,b
          tya
          jsl rlGetUnitRAMDataPointerByFactionSlotEntryID

          lda wSelectedUnitDataRAMPointer,b
          beq _End

            jsl rlGetSelectedUnitGenerationID
            bcs +

              phx
              dec a
              asl a
              tax
              lda wSelectedUnitDataRAMPointer,b
              sta $7E2000,x
              plx

          +
          inc x
          bra -
        
        _End
        plx
        stx wRoutineVariable1,b
        plx
        stx $056F,b

        ply
        plx
        plp
        plb
        rtl

        .databank 0

        ; 84/C461

    .endsection Unsorted84C412Section


    .section Unsorted84C5D7Section

      .al
      .xl

      rlUnknown84C5D7 ; 84/C5D7

        .al
        .autsiz
        .databank ?

        phb
        phx
        phy

        tax
        ora #0
        beq _SEC

          jsl rlGetFactionSlotNameID
          cmp #$00FF
          beq _CLC

          txa
          jsl rlUnknown84BEB7
          ora #0
          beq _CLC

            jsl rlUnknown81B503

            lda $24
            beq _SEC

              txa
              asl a
              clc
              adc $24
              tay

              sep #$20
              lda $24+2
              pha
              rep #$20
              plb

              lda $0000,b,y
              cmp #$FFFF
              beq _SEC

                lda $0001,b,y
                and #$00FF
                sta $0EAE,b
                lda $0000,b,y
                and #$00FF
                jsl rlCheckIfEventFlagOfSpecifiedChapterSet
                bcc _CLC
        
        _SEC
        sec
        bra +
        
        _CLC
        clc
        
        +
        ply
        plx
        plb
        rtl

        .databank 0

        ; 84/C62E

    .endsection Unsorted84C5D7Section


    .section Unsorted84CC5DSection

      .al
      .xl

      rlUnknown84CC5D ; 84/CC5D

        .al
        .xl
        .autsiz
        .databank ?

        lda $0580,b
        beq _CC83
        sta wEventLocationEntry,b
        jsl rlGetEventLocationEntryID
        sta wRoutineVariable1,b
        lda $7E477B,x
        jsl rlGetFactionSlotLocationID
        cmp wRoutineVariable1,b
        bne _CC85
        jsl rlSetUnitResidingInCastle
        lda wRoutineVariable1,b
        ldy #$0001

        _CC83
        clc

        _CC84
        rtl


        _CC85
        phx
        jsl $88B2A5
        plx
        lda $7E46EB,x
        sta wSelectedUnitDataRAMPointer,b
        lda wRoutineVariable1,b
        jsl rlSetUnitUnfieldedInCastle
        jsl rlDeployedUnitSetHidden
        lda $0D87,b
        bit #$0008
        beq _CCA9
        jsl rlUnknown84D461

        _CCA9
        jsr rsUnknown84CA22
        lda wRoutineVariable1,b
        ldy #$0000
        bra _CC84

        .databank 0

        ; 84/CCB4

    .endsection Unsorted84CC5DSection


    .section Unsorted84CD8ASection

      .al
      .xl

      rlUnknown84CD8A ; 84/CD8A

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $84
        phy
        ldy wUnknownDeploymentOffset000D7F,b
        bpl _CDA0
        sta $0D83,b
        stx wUnknownDeploymentOffset000D7F,b
        lda #$0003
        sta $0D81,b

        _CDA0
        ply
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 84/CDA4

    .endsection Unsorted84CD8ASection


    .section Unsorted84CDA4Section

      .al
      .xl

      rlUnknown84CDA4 ; 84/CDA4

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        lda $0580,b
        beq _End

          sta wEventLocationEntry,b
          lda aDeploymentTable._UnitRAMPointer,x
          sta wSelectedUnitDataRAMPointer,b
          jsl rlUnknown84CAA9
          lda #8
          sta bEventActionIdentifier,b
          jsl rlGetSelectedUnitCharacterID
          sta wEventEngineArgument1,b
          jsl rlGetEventLocationEntryID
          sta wEventEngineArgument2,b
          jsl rlGetAndRunChapterMapEventConditions

        _End
        plp
        plb
        rtl

        .databank 0

        ; 84/CDD6

    .endsection Unsorted84CDA4Section


    .section Unsorted84CE21Section

      .al
      .xl

      rlUnknown84CE21 ; 84/CE21

        .al
        .autsiz
        .databank ?

        ; X = deployment offset

        phb
        php
        phk
        plb
        lda wR0
        pha
        lda wR1
        pha

        lda $0580,b
        bne +

          jml _End

        +
        sta wEventLocationEntry,b
        jsl rlCheckIfCastleGuarded
        bcc +

          jml _End

        +
        jsl rlGetLocationFactionSlotOwner
        sta wR0
        lda aDeploymentTable._FactionSlot,x
        cmp wR0
        bne +

          jml _End

        +
        lda aDeploymentTable._FactionSlot,x
        jsl rlSetLocationFactionSlotOwner
        jsl rlUnknown84CAA9
        jsr rsUnknown84CEA3
        lda aDeploymentTable._FactionSlot,x
        bne +

          jsl rlUnknown87EE81
          jsr rsReviveCapturedPlayerCharacters
          bra _EC96

        +
        jsl rlGetEventLocationEntryID
        cmp #0
        beq _EC96

          lda wR0
          bne _EC96

            lda #$0049
            jsl rlUnknown80900D

            jsl rlSetLocationDestroyed
            inc wDestroyedLocationsCount,b
            jsl rlHandleEventLocationModification
            jsl rlUnknown888410
            bra _End

        _EC96
        jsl rlHandleEventLocationModification

        _End
        pla
        sta wR1
        pla
        sta wR0
        plp
        plb
        rtl

        .databank 0

      rsUnknown84CEA3 ; 84/CEA3

        .al
        .autsiz
        .databank ?

        ; X = deployment offset
        ; wR0 = faction slot owner of location

        jsl rlGetEventLocationEntryID
        and #$00FF
        sta aProcSystem.wInput0,b
        lda wR0
        and #$00FF
        sta aProcSystem.wInput1,b
        lda aDeploymentTable._FactionSlot,x
        sta aProcSystem.wInput2,b

        lda #(`procUnknown87C056)<<8
        sta lR44+1
        lda #<>procUnknown87C056
        sta lR44
        jsl rlProcEngineCreateProc
        rts

        .databank 0

      rsReviveCapturedPlayerCharacters ; 84/CECB

        .al
        .autsiz
        .databank ?

        phx
        lda wEventLocationEntry,b
        pha

        jsl rlBuildDeadPlayerCharacterList
        ldx #0

          _Loop
          lda aDeadPlayerCharacterList,x
          bmi _End

            phx
            tax
            lda aDeploymentTable._UnitRAMPointer,x
            sta wSelectedUnitDataRAMPointer,b
            plx
            jsl rlGetSelectedUnitStatus
            cmp #StatusCaptive
            bne _Next

              jsl rlReviveSelectedCharacter

              lda #$001B
              sta bEventActionIdentifier,b
              jsl rlGetSelectedUnitCharacterID
              sta wEventEngineArgument1,b
              jsl rlGetAndRunChapterMapEventConditions

            _Next
            inc x
            inc x
            bra _Loop

        _End
        pla
        sta wEventLocationEntry,b
        plx
        rts

        .databank 0

      rlUnknown84CF0F ; 84/CF0F

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        lda wR0
        pha

        lda $0580,b
        bne +

          jml _End

        +
        sta wEventLocationEntry,b
        jsl rlGetEventLocationEntryType
        cmp #LocationTypeVillage
        beq +

          jml _End

        +
        jsl rlUnknown84CAA9

        lda #500
        jsl rlSubtractEventLocationMoneyReward
        bcc +

          jsl rlSetLocationDestroyed
          lda aDeploymentTable._UnitRAMPointer,x
          sta wSelectedUnitDataRAMPointer,b
          jsl rlGetSelectedUnitFactionSlot
          sta wR0
          lda #2
          sta bEventActionIdentifier,b
          lda wR0
          sta wEventEngineArgument1,b
          jsl rlGetEventLocationEntryID
          sta wEventEngineArgument2,b
          jsl rlGetAndRunChapterMapEventConditions

        +
        jsl rlHandleEventLocationModification
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        txa
        sta $7E4EA9

        lda aDeploymentTable._XTilePosition,x
        sta $7E4EAB
        lda aDeploymentTable._YTilePosition,x
        sta $7E4EAD
        jsl rlGetSelectedUnitClassID
        sta $7E4EAF

        jsl rlGetFirstEquippableWeaponInInventory
        jsl rlGetItemIDByInventorySlot
        sta $7E4EB1

        jsl rlUnknown87F321
        sta $7E4EB3
        lda #5000
        sta $7E4EB5
        jsl rlGetEventLocationMoneyReward
        sta $7E4EB7
        lda #500
        sta $7E4EB9
        jsl rlUnknown9E9A34
        
        _End
        pla
        sta wR0
        plp
        plb
        rtl

        .databank 0

        ; 84/CFBF

    .endsection Unsorted84CE21Section


    .section Unsorted84CFBFSection

      .al
      .xl

      rlUnknown84CFBF ; 84/CFBF

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        lda wR0
        pha
        lda wR1
        pha

        lda aDeploymentTable._XTilePosition,x
        sta wR0
        lda aDeploymentTable._YTilePosition,x
        sta wR1
        jsl rlUnknown87EA09
        bcs +

          jsl rlCheckIfCastleGuarded
          bcs +

            jsl rlGetLocationFactionSlotOwner
            sta wR0

            lda aDeploymentTable._UnitRAMPointer,x
            sta wSelectedUnitDataRAMPointer,b

            phx
            ldx wR0
            jsl rlGetSelectedUnitFactionSlot
            jsl rlGetFactionRelation
            plx

            cmp #AllegianceEnemy
            beq +

              cmp #AllegianceOther
              beq +

                jsr rsUnknown84D010

        +
        pla
        sta wR1
        pla
        sta wR0
        plp
        plb
        rtl

        .databank 0

      rsUnknown84D010 ; 84/D010

        .al
        .autsiz
        .databank ?

        lda aDeploymentTable._StateBuffer,x
        ora #DeploymentStateGuardingCastle
        sta aDeploymentTable._StateBuffer,x
        sta aDeploymentTable._State,x

        lda #UnitStateGuardingCastle
        jsl rlSetSelectedUnitStates
        jsl rlGetEventLocationEntryID
        jsl rlSetSelectedUnitResidingCastle
        jsl rlSetCastleGuarded
        jsl rlGetEventLocationEntryCoordinates
        sta wRoutineVariable1,b
        jsl rlUnknown84C996
        rts

        .databank 0

        ; 84/D03E

    .endsection Unsorted84CFBFSection


    .section Unsorted84D16BSection

      .al
      .xl

      rlUnknown84D16B ; 84/D16B

        .al
        .autsiz
        .databank ?

        ; wR0 = initiator deployment offset
        ; wR1 = target deployment offset

        phb
        php
        phk
        plb
        phx
        ldx wR1
        lda aDeploymentTable._UnitRAMPointer,x
        sta wRoutineVariable1,b
        ldx wR0
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlUnknown84CAA9
        jsl rlCheckTalkEventEntryAvailable
        bcc +

          sta wEventEngineArgument3,b

        +
        lda wSelectedUnitDataRAMPointer,b
        pha

        lda #$000A
        sta bEventActionIdentifier,b
        jsl rlGetSelectedUnitCharacterID
        sta wEventEngineArgument1,b
        ldx wR1
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitCharacterID
        sta wEventEngineArgument2,b
        jsl rlGetAndRunChapterMapEventConditions

        pla
        sta wSelectedUnitDataRAMPointer,b
        jsl rlUnknown849EA3
        cmp wEventEngineArgument2,b
        bne +

          lda #0
          jsl rlSetSelectedUnitTalkTarget

        +
        plx
        plp
        plb
        rtl

        .databank 0

        ; 84/D1CC

    .endsection Unsorted84D16BSection


    .section Unsorted84D2BASection

      .al
      .xl

      rlUnknown84D2BA ; 84/D2BA

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $84
        phx
        jsl rlClearBattleData
        lda wR0
        sta wUnknownDeploymentOffset000D7F,b
        lda wR1
        sta $0D83,b
        lda #$0007
        sta $0D81,b
        lda wR0
        sta aActionStructUnit1
        tax
        jsl rlUnknown84CAA9
        lda $7E46EB,x
        sta $7E4EBB
        lda $7E441B,x
        sta $7E4EB7
        lda $7E44AB,x
        sta $7E4EB9
        jsl rlGetSelectedUnitExperience
        sta $7E4ECD
        lda #$0064
        sta $7E4ECF
        phb
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb
        .databank $7E
        ldx #$4EB5
        jsr rsActionstructGetLevelUpAndDroppedItemData
        plb
        .databank $7E
        lda #$001A
        sta bEventActionIdentifier,b
        jsl rlGetSelectedUnitCharacterID
        sta wEventEngineArgument1,b
        ldx wR1
        jsl rlGetFormationIDByDeploymentOffset
        inc a
        sta wEventEngineArgument2,b
        jsl rlGetAndRunChapterMapEventConditions
        plx
        plp
        plb
        .databank $7E
        rtl

        .databank 0

        ; 84/D334

      rlUnknown84D334 ; 84/D334

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $84
        phx
        ldx wR0
        lda $7E46EB,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitMoney
        sta wRoutineVariable1,b
        jsl rlSubtractSelectedCharacterMoney
        jsl rlUnknown84CAA9
        ldx wR1
        lda $7E46EB,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlAddSelectedCharacterMoney
        ora #$0000
        beq _D373
        sta wRoutineVariable1,b
        ldx wR0
        lda $7E46EB,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlAddSelectedCharacterMoney

        _D373
        jsl rlClearBattleData
        sep #$20
        lda #$00
        sta $7E4EA9
        rep #$20
        lda wR0
        sta aActionStructUnit1
        tax
        lda $7E46EB,x
        sta wSelectedUnitDataRAMPointer,b
        sta $7E4EBB
        lda $7E441B,x
        sta $7E4EB7
        lda $7E44AB,x
        sta $7E4EB9
        jsl rlGetSelectedUnitCharacterID
        sta $7E4EBD
        jsl rlGetSelectedUnitClassID
        sta $7E4EBF
        jsl rlGetSelectedUnitGender
        sta $7E4EC1
        jsl rlGetFirstEquippableWeaponInInventory
        sta $7E4EDB
        cmp #$0000
        bne _D3CD
        lda #$FFFF
        bra _D3D1


        _D3CD
        jsl rlGetItemIDByInventorySlot

        _D3D1
        sta $7E4EDD
        jsl rlGetSelectedUnitExperience
        sta $7E4ECD
        lda #$0006
        jsl rlCheckIfUnitHasSpecifiedPersonalOrClassSkill
        bcc _D3EB
        lda #$000A
        bra _D3EE


        _D3EB
        lda #$0000

        _D3EE
        sta $7E4ECF
        lda #$FFFF
        sta $7E4ED1
        lda wR1
        sta aActionStructUnit2
        tax
        lda $7E46EB,x
        sta wSelectedUnitDataRAMPointer,b
        sta $7E4F1B
        lda $7E441B,x
        sta $7E4F17
        lda $7E44AB,x
        sta $7E4F19
        jsl rlGetSelectedUnitCharacterID
        sta $7E4F1D
        jsl rlGetSelectedUnitClassID
        sta $7E4F1F
        jsl rlGetSelectedUnitGender
        sta $7E4F21
        jsl rlGetFirstEquippableWeaponInInventory
        sta $7E4F3B
        cmp #$0000
        bne _D445
        lda #$FFFF
        bra _D449


        _D445
        jsl rlGetItemIDByInventorySlot

        _D449
        sta $7E4F3D
        phb
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb
        .databank $7E
        ldx #$4EB5
        jsr rsActionstructGetLevelUpAndDroppedItemData
        plb
        .databank $7E
        plx
        plp
        plb
        .databank $7E
        rtl

        .databank 0

        ; 84/D461

      rlUnknown84D461 ; 84/D461

        .al
        .xl
        .autsiz
        .databank ?

        lda $7E441B,x
        sta $7E492B
        lda $7E44AB,x
        sta $7E492D
        rtl

        .databank 0

        ; 84/D472

    .endsection Unsorted84D2BASection


    .section Unsorted84D483Section

      .al
      .xl

      rlUnknown84D483 ; 84/D483

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $84
        lda $7E477B,x
        bne _D49D
        lda $0D87,b
        and #$FFFC
        ora #$8002
        sta $0D87,b
        plp
        plb
        .databank $84
        clc

        _D49C
        rtl


        _D49D
        plp
        plb
        .databank $84
        sec
        bra _D49C

        .databank 0

        ; 84/D4A2

    .endsection Unsorted84D483Section


    .section Unsorted84D4A2Section

      .al
      .xl

      rlUnknown84D4A2 ; 84/D4A2

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb

        lda aDeploymentTable._FactionSlot,x
        bne +

        lda $0D87,b
        and #~(1 | 2) & $FFFF
        ora #$8001
        sta $0D87,b

        lda #$8000
        tsb wUnknown000D79,b

        plp
        plb
        clc
        
        -
        rtl
        
        +
        plp
        plb
        sec
        bra -

        .databank 0

        ; 84/D4C7

    .endsection Unsorted84D4A2Section


    .section Unsorted84F75CSection

      .al
      .xl

      rlUnknown84F75C ; 84/F75C

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlGetItemROMDataByInventorySlot
        jsl rlCheckStaffEquippable
        rtl

        .databank 0

        ; 84/F765

      rlUnknown84F765 ; 84/F765

        .al
        .xl
        .autsiz
        .databank ?

        phb
        phk
        plb
        .databank $84
        jsl rlGetItemROMDataByInventorySlot
        lda wCurrentItemDataROMPointer,b
        beq _F783
        jsl rlGetItemEquipmentType
        cmp #$0001
        beq _F783
        jsl rlUnknown87E6A5
        bcc _F783
        sec

        _F781
        plb
        .databank $84
        rtl


        _F783
        clc
        bra _F781

        .databank 0

        ; 84/F786

      rlUnknown84F786 ; 84/F786

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $84
        phx
        phy
        lda wR0
        pha
        lda wR1
        pha
        lda #(`$7F654A)<<8
        sta lRoutineVariable+1,b
        lda #<>$7F654A
        sta lRoutineVariable,b
        jsl rlUnknown8483F3
        lda #$0400
        jsl rlUnsetSelectedUnitStates
        lda #$0000
        sta $7E2000
        sta wAIGroupLeaderFieldMovement
        sta wAIUnknown7E2010
        sta wAIUnknown7E2018
        sta wAIGroupLeaderDeploymentOffset
        lda #$0001
        sta wR0

        _F7C5
        jsl rlGetSelectedUnitStates
        bit #$0800
        bne _F7DA
        jsr rsUnknown84F7F5
        jsr $84F815
        jsr $84F845
        jsr $84F865

        _F7DA
        jsr $84F877
        inc wR0
        lda wR0
        cmp #$0008
        bcs _F7EA
        jml _F7C5


        _F7EA
        pla
        sta wR1
        pla
        sta wR0
        ply
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 84/F7F5

      rsUnknown84F7F5 ; 84/F7F5

        .al
        .xl
        .autsiz
        .databank ?

        lda #$2000
        sta wR1
        lda wR0
        jsl rlCheckWeaponInInventorySlotEquippable
        bcc _F814
        stz wR12
        lda #$0000
        jsl rlUnknown84FED2
        ora #$0000
        beq _F814
        jml _F889


        _F814
        rts

        .byte $A9, $08, $20, $85, $02, $A5, $00, $22, $5C, $F7, $84, $90, $0A, $22, $A5, $E6
        .byte $87, $90, $04, $5C, $89, $F8, $84, $60, $A9, $28, $20, $85, $02, $A5, $00, $22
        .byte $5C, $F7, $84, $90, $0A, $22, $09, $E7, $87, $90, $04, $5C, $89, $F8, $84, $60
        .byte $A9, $10, $20, $85, $02, $A5, $00, $22, $53, $F7, $84, $90, $12, $64, $18, $A9
        .byte $04, $00, $22, $D2, $FE, $84, $09, $00, $00, $F0, $04, $5C, $89, $F8, $84, $60
        .byte $A9, $18, $20, $85, $02, $A5, $00, $22, $65, $F7, $84, $90, $04, $5C, $89, $F8
        .byte $84, $60, $A9, $20, $20, $85, $02, $A5, $00, $22, $53, $F7, $84, $90, $04, $5C
        .byte $89, $F8, $84, $60


        _F889
        phb
        php
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb
        .databank $7E
        ldx wR1
        lda wR0
        jsl rlCheckIfWeaponEquipped
        bcs _F8B0
        lda $0000,b,x
        and #$00FF

        _F8A3
        clc
        adc wR1
        tay
        sep #$20
        lda wR0
        sta $0001,b,y
        bra _F8D1


        _F8B0
        .al
        lda $0000,b,x
        and #$00FF
        beq _F8A3
        phx
        tax
        clc
        adc wR1
        dec a
        tay
        sep #$20

        _F8C1
        lda $0001,b,y
        sta $0002,b,y
        dec y
        dec x
        bne _F8C1
        plx
        lda wR0
        sta $0002,b,y

        _F8D1
        inc $0000,b,x
        rep #$20
        plp
        plb
        .databank ?
        rts

        .databank 0

        ; 84/F8D9

    .endsection Unsorted84F75CSection


    .section Unsorted84FE98Section

      .al
      .xl

      rlUnknown84FE98 ; 84/FE98

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlGetFirstEquippableWeaponInInventory
        jsl rlGetSelectedUnitBattleHit
        rtl

        .databank 0

        ; 84/FEA1

      rlUnknown84FEA1 ; 84/FEA1

        .al
        .xl
        .autsiz
        .databank ?

        pha
        jsl rlGetFirstEquippableWeaponInInventory
        pla
        jsl rlGetSelectedUnitBattleAvoid
        rtl

        .databank 0

        ; 84/FEAC

    .endsection Unsorted84FE98Section


    .section Unsorted84FED2Section

      .al
      .xl

      rlUnknown84FED2 ; 84/FED2

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $84
        pha
        cmp #$0004
        beq _FEEA
        jsl rlGetItemMinimumRange
        sta wR10
        jsl rlGetItemMaximumRange
        sta wR11
        bra _FEFD


        _FEEA
        jsl rlGetItemMinimumRange
        ora #$0000
        beq _FF05
        cmp #$0002
        bcs _FF05
        inc a
        sta wR10
        sta wR11

        _FEFD
        pla
        jsl rlUnknown848924

        _FF02
        plp
        plb
        .databank ?
        rtl


        _FF05
        pla
        lda #$0000
        bra _FF02

        .databank 0

        ; 84/FF0B

    .endsection Unsorted84FED2Section
