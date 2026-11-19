; Code from bank $84 not yet assigned to a game system.

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
          jsl $84BEB7
          ora #0
          beq _CLC

            jsl $81B503

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

        lda #(`$87C056)<<8
        sta lR44+1
        lda #<>$87C056
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

        jsl $87F321
        sta $7E4EB3
        lda #5000
        sta $7E4EB5
        jsl rlGetEventLocationMoneyReward
        sta $7E4EB7
        lda #500
        sta $7E4EB9
        jsl $9E9A34
        
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
        jsl $87EA09
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
