; The move from generation 1 to generation 2: removing parents and loading their children.

    .section GenerationTransferSection

      .al
      .xl

      rlUnknown848000 ; 84/8000

        .al
        .autsiz
        .databank ?

        phb
        php

        phk
        plb

        phx

        ldx #35
        lda #0

          -
          sta wLoadedUnitCount,b,x
          dec x
          dec x
          bpl -

        ldx #$3295
        lda #0

          -
          sta $7E2000,x
          dec x
          dec x
          bpl -

        ldx #(len(aDeploymentTable._State) - 2)
        lda #$FFFF

          -
          sta aDeploymentTable._MapSpriteID,x
          dec x
          dec x
          bpl -

        lda #(`aUnitRAMPointers)<<8
        sta lR18+1
        lda #<>aUnitRAMPointers
        sta lR18
        lda #len(aUnitRAMPointers._Entry)
        sta wR0
        lda #size(aUnitRAMPointers._Entry[0])
        sta wR1
        jsl rlBuildRAMStructHeader

        lda #(`aUnitRAMArea)<<8
        sta lR18+1
        lda #<>aUnitRAMArea
        sta lR18
        lda #1
        sta wStructIndex,b
        lda #<>size(aUnitRAMArea)
        jsl rlBuildRAMAreaHeaderAndGuidingEntry

        lda #(`aStaticUnitRAMArea)<<8
        sta lR18+1
        lda #<>aStaticUnitRAMArea
        sta lR18
        lda #1
        sta wStructIndex,b
        lda #<>size(aStaticUnitRAMArea)
        jsl rlBuildRAMAreaHeaderAndGuidingEntry

        lda #(`aDynamicUnitRAMArea)<<8
        sta lR18+1
        lda #<>aDynamicUnitRAMArea
        sta lR18
        lda #1
        sta wStructIndex,b
        lda #<>size(aDynamicUnitRAMArea)
        jsl rlBuildRAMAreaHeaderAndGuidingEntry

        lda #(`aHolyAndEnemyRAMArea)<<8
        sta lR18+1
        lda #<>aHolyAndEnemyRAMArea
        sta lR18
        lda #1
        sta wStructIndex,b
        lda #<>size(aHolyAndEnemyRAMArea)
        jsl rlBuildRAMAreaHeaderAndGuidingEntry

        lda #(`aInventoryRAMArea)<<8
        sta lR18+1
        lda #<>aInventoryRAMArea
        sta lR18
        lda #1
        sta wStructIndex,b
        lda #<>size(aInventoryRAMArea)
        jsl rlBuildRAMAreaHeaderAndGuidingEntry

        lda #(`aLoverRAMArea)<<8
        sta lR18+1
        lda #<>aLoverRAMArea
        sta lR18
        lda #1
        sta wStructIndex,b
        lda #$014C
        jsl rlBuildRAMAreaHeaderAndGuidingEntry

        lda #(`aPlayerItemTable)<<8
        sta lRoutineVariable+1,b
        lda #<>aPlayerItemTable
        sta lRoutineVariable,b
        jsl rlInitiateItemRAMData

        jsl rlInitiateFactionRAMData

        jsl rlUnknown8BCE71 ; clear some stuff

        plx
        plp
        plb
        rtl

        .databank 0

      rlUnknown8480EC ; 84/80EC

        .al
        .autsiz
        .databank ?

        ; Run on chapter start

        phb
        php
        phk
        plb
        phx
        lda wR0
        pha

        lda wLoadedFactionCount,b
        beq _810A

          lda #1
          sta wLoadedFactionCount,b
          ldx #6

            -
            txa
            jsl rlUnloadFactionSlot
            dec x
            bne -

        _810A
        lda #(`aUnitRAMPointers)<<8
        sta lStructPointer2+1,b
        lda #<>aUnitRAMPointers
        sta lStructPointer2,b
        jsl rlGetRAMStructCurrentStructCount
        ora #0
        beq _8163

          sta wR0

          -
          lda wR0
          sta wStructIndex,b
          jsl rlLoadRAMStructDataByIndex
          bcs _810A

            lda lStructPointer1,b
            sta wSelectedUnitDataRAMPointer,b
            lda #80
            sta wRoutineVariable1,b
            jsl rlHealSelectedUnitsHP
            lda #0
            jsl rlSetSelectedUnitStatusDuration
            lda #StatusHealthy
            jsl rlSetSelectedUnitStatus
            lda #0
            jsl rlSetSelectedUnitArenaLevel
            lda #None
            jsl rlSetSelectedUnitTalkTarget
            lda #(UnitStateGuardingCastle | UnitStateMoved | UnitStateFielded)
            jsl rlUnsetSelectedUnitStates
            dec wR0
            bne -

        _8163
        ldx #(len(aDeploymentTable._State) - 2)
        lda #$FFFF

          -
          sta aDeploymentTable._MapSpriteID,x
          dec x
          dec x
          bpl -

        ldx #(len(aDeploymentTable._State) - 2)

        -
        lda aDeploymentTable._UnitRAMPointer,x
        beq +

          sta wSelectedUnitDataRAMPointer,b
          jsl rlGetSelectedUnitMapSprite
          sta wR1
          jsl rlAddDeployedMapSprite
          sta aDeploymentTable._DeploymentOffsets,x
          lda aDeploymentTable._StateBuffer,x
          and #DeploymentAllegianceMask
          ora #DeploymentStateHidden
          sta aDeploymentTable._StateBuffer,x
          sta aDeploymentTable._State,x

        +
        dec x
        dec x
        bpl -

        lda wCurrentChapter,b
        cmp #6
        bne +

          jsl rlSetParentsPermanentFlags
          jsl rlDeleteParentsAndModifyChildrenData
          jsl rlUnknown8BCE71

        +
        lda wCurrentChapter,b
        cmp #6
        bne _End

        jsl rlUnknown87E007
        ora #0
        beq _End

          ldx #1

          -
          txa
          jsl rlGetItemRAMStructEntryByPlayerItemIndex
          bcs _End

            jsl rlGetItemRAMStateAndOwner
            lda wR0
            cmp #ItemStateUnobtained
            beq _81E9

              cmp #ItemStateShop
              beq +

                cmp #ItemStatePawnbroker
                bne _81E9

              +
              jsl rlRevertItemAquirement
            
            _81E9
            inc x
            bra -

        _End
        jsl rlUnknown87E93F
        jsl rlUnknown87E952
        jsl rlUnknown86C548

        pla
        sta wR0
        plx
        plp
        plb
        rtl

        .databank 0

      rlDeleteParentsAndModifyChildrenData ; 84/81FF

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        ldy #<>aModifyChildrenDataList

          _Loop
          lda $0000,b,y
          cmp #$FFFF
          beq _End

            jsl rlGetUnitRAMDataPointerByID
            bcs _Next

              lda $0002,b,y
              asl a
              tax
              jsr (aModifyChildrenDataRoutines,x)

            _Next
            tya
            clc
            adc #size(word) * 3
            tay
            bra _Loop

        _End
        jsl rlUnknown81B15A
        plx
        plp
        plb
        rtl

        .databank 0

      aModifyChildrenDataRoutines .include "../../data/system/ModifyChildrenDataRoutines.csv.asm" ; 84/822D

      aModifyChildrenDataList ; 84/8237

        .word Deirdre,  ID_LoadChildUnitAndDeleteParentUnitData, ID_LoadMaleChildUnit
        .word Ethlyn,   ID_LoadChildUnitAndDeleteParentUnitData, ID_LoadBothChildUnits
        .word Brigid,   ID_LoadChildUnitAndDeleteParentUnitData, ID_LoadBothChildUnits
        .word Edain,    ID_LoadChildUnitAndDeleteParentUnitData, ID_LoadBothChildUnits
        .word Silvia,   ID_LoadChildUnitAndDeleteParentUnitData, ID_LoadBothChildUnits
        .word Tailtiu,  ID_LoadChildUnitAndDeleteParentUnitData, ID_LoadBothChildUnits
        .word Erinys,   ID_LoadChildUnitAndDeleteParentUnitData, ID_LoadBothChildUnits
        .word Ayra,     ID_LoadChildUnitAndDeleteParentUnitData, ID_LoadBothChildUnits
        .word Lachesis, ID_LoadChildUnitAndDeleteParentUnitData, ID_LoadBothChildUnits
        .word Dew,      ID_DeleteParentUnitData, None
        .word Lex,      ID_DeleteParentUnitData, None
        .word Beowulf,  ID_DeleteParentUnitData, None
        .word Claud,    ID_DeleteParentUnitData, None
        .word Jamke,    ID_DeleteParentUnitData, None
        .word Azelle,   ID_DeleteParentUnitData, None
        .word Chulainn, ID_DeleteParentUnitData, None
        .word Lewyn,    ID_DeleteParentUnitData, None
        .word Midir,    ID_DeleteParentUnitData, None
        .word Quan,     ID_DeleteParentUnitData, None
        .word Finn,     ID_TransferUnitToGen2,   AdultFinn
        .word Arden,    ID_DeleteParentUnitData, None
        .word Alec,     ID_DeleteParentUnitData, None
        .word Naoise,   ID_DeleteParentUnitData, None
        .word Sigurd,   ID_DeleteParentUnitData, None
        .word Seliph,   ID_OverwriteSeliphUnitData, None
        .word Altena,   ID_OverwriteAltenaUnitData, None
        .sint -1

      rsDeleteParentUnitData ; 84/82D5

        .al
        .autsiz
        .databank ?

        jsl rlUndeployUnit
        jsl rlDeleteUnit
        rts

        .databank 0

      rsTransferUnitToGen2 ; 84/82DE

        .al
        .autsiz
        .databank ?

        ; Argument: new CharacterID

        phy
        jsl rlGetSelectedUnitMoney
        lsr a
        jsl rlSetSelectedUnitMoney

        lda $0004,b,y
        jsl rlGetCharacterDataROMPointer
        tay

        ldx wSelectedUnitDataRAMPointer,b
        lda #>`FinnCharacterDataOffsetsEntry
        sta $7E0000 + structCharacterDataRAM.ConstantData+1,x

        tya
        clc
        adc #structStaticCharacterROMEntry.CharacterID
        sta $7E0000 + structCharacterDataRAM.ConstantData,x

        phb
        jsl rlGetSelectedUnitPersonalDataPointer
        jsl rlGetSelectedUnitLoveDataIDByCharacterID
        sep #$20
        sta structPersonalCharacterDataRAM.LoveDataID,b,x
        lda #0
        sta structPersonalCharacterDataRAM.LoverGenerationID,b,x
        rep #$20
        plb

        ldx wSelectedUnitDataRAMPointer,b
        jsr rsUnknown849294
        jsl rlUndeployUnit
        ply
        rts

        .databank 0

      rsLoadChildUnitAndDeleteParentUnitData ; 84/8325

        .al
        .autsiz
        .databank ?

        lda $0004,b,y
        asl a
        tax
        jsr (aLoadChildUnitRoutines,x)
        jsr rsDeleteParentUnitData
        rts

        .databank 0

      aLoadChildUnitRoutines .include "../../data/system/LoadChildUnitRoutines.csv.asm" ; 84/8331

      rsLoadBothChildUnits ; 84/8339

        .al
        .autsiz
        .databank ?

        lda #0
        sta wRoutineVariable1,b
        jsl rlLoadChildUnit
        bra rsLoadFemaleChildUnit

      rsLoadMaleOrFemaleChildUnit ; 84/8345

        .al
        .autsiz
        .databank ?

        lda #50
        jsl rlRollForChance
        bcs rsLoadFemaleChildUnit

      rsLoadMaleChildUnit ; 84/834E

        .al
        .autsiz
        .databank ?

        lda #0
        bra +

      rsLoadFemaleChildUnit ; 84/8353

        .al
        .autsiz
        .databank ?

        lda #1
        
        +
        sta wRoutineVariable1,b
        jsl rlLoadChildUnit
        rts

        .databank 0

      rsOverwriteSeliphUnitData ; 84/835E

        .al
        .autsiz
        .databank ?

        phb
        jsl rlGetSelectedUnitConstantDataPointer
        lda structCharacterConstantData.Skills1,b,x
        ora #UnitSkill1Dismount
        sta structCharacterConstantData.Skills1,b,x
        lda #(MajorBaldrBlood | MinorNagaBlood)
        sta structCharacterConstantData.HolyBlood1,b,x
        lda #0
        sta structCharacterConstantData.HolyBlood2,b,x
        jsl rlGetSelectedUnitExtendedPersonalDataPointer
        sep #$20
        lda #2
        sta structExtendedCharacterDataRAM.LeadershipStars,b,x
        rep #$20
        plb
        rts

        .databank 0

      rsOverwriteAltenaUnitData ; 84/8387

        .al
        .autsiz
        .databank ?

        phb
        jsl rlGetSelectedUnitExtendedPersonalDataPointer
        sep #$20
        lda #3
        sta structExtendedCharacterDataRAM.LeadershipStars,b,x
        rep #$20
        plb
        rts

        .databank 0

        ; 84/8397

    .endsection GenerationTransferSection


    .section ChildUnitSection

      .al
      .xl

      rlLoadChildUnit ; 84/BAA1

        .al
        .autsiz
        .databank ?

        ; Input:
        ; wRoutineVariable1 = 0 if male child, 1 if female

        phb
        php
        phk
        plb
        phx
        lda wSelectedUnitDataRAMPointer,b
        pha

        lda wRoutineVariable1,b
        sta wR2

        jsl rlGetSelectedUnitCharacterID
        cmp #Ethlyn
        beq +

          cmp #Deirdre
          beq +

            jsl rlGetSelectedUnitStates
            bit #UnitStateDead
            bne _End

        +
        ldx wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitLoverGenerationID
        ora #0
        beq _End

          cmp #GEN_ID_Ethlyn
          bcs _End

            jsl rlGetUnitRAMDataPointerByID
            bcs _End

              ; father data?
              lda wSelectedUnitDataRAMPointer,b
              sta wR0

              ; mother data?
              stx wSelectedUnitDataRAMPointer,b
              lda wSelectedUnitDataRAMPointer,b
              sta wR1

              jsl rlGetSelectedUnitGenerationID
              cmp #GEN_ID_Deirdre
              bcc _End

                sec
                sbc #GEN_ID_Deirdre
                asl a
                tax

                lda wR2
                asl a
                clc
                adc aChildrenDataOffsets,x
                tax
                lda aChildrenDataOffsets,x
                beq _End

                  jsl rlLoadUnit

                  lda aChildrenPermanentFlags,x
                  bmi _End

                    jsl rlSetPermanentEventFlag

        _End
        pla
        sta wSelectedUnitDataRAMPointer,b
        plx
        plp
        plb
        rtl

        .databank 0

      aChildrenPermanentFlags ; 84/BB1E

        ; The first few entries are offsets, but it already gets indexed with an offset already.

        .sint 18
        .sint 22
        .sint 26
        .sint 30
        .sint 34
        .sint 38
        .sint 42
        .sint 46
        .sint 50

        .sint -1 ; Seliph
        .sint -1 ; None
        .sint -1 ; Leif
        .sint -1 ; Altena
        .sint PermanentFlagDiarmuidExists
        .sint PermanentFlagNannaExists
        .sint PermanentFlagScathachExists
        .sint PermanentFlagLarceiExists
        .sint PermanentFlagCedExists
        .sint PermanentFlagFeeExists
        .sint PermanentFlagArthurExists
        .sint PermanentFlagTineExists
        .sint PermanentFlagCoirpreExists
        .sint PermanentFlagLeneExists
        .sint PermanentFlagLesterExists
        .sint PermanentFlagLanaExists
        .sint PermanentFlagFebailExists
        .sint PermanentFlagPattyExists

        ; 84/BB54

    .endsection ChildUnitSection
