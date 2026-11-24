; ASMCs: assembly routines called from chapter event scripts. So far only the final
; chapter's Julia recruitment is here; other ASMCs live with the system they belong to.

    .section ASMCShowItemPopUpBoxSection

      .al
      .xl

      rlASMCShowItemPopUpBox ; 81/B223

        .al
        .autsiz
        .databank ?

        lda wUnitRelocationDeploymentOffset,b
        bmi _End

          lda wUnitRelocationType,b
          cmp #8
          bne _End

            lda wUnitRelocationLocationID,b
            jsl rlGetItemRAMStructEntryByPlayerItemIndex
            jsl rlGetEffectiveItemIDByItemRAMStructEntry
            sta aProcSystem.wInput2,b

            lda #$0D00
            sta aProcSystem.wInput3,b
            lda #(`procItemPopUp)<<8
            sta lR44+1
            lda #<>procItemPopUp
            sta lR44
            jsl rlEventEngineCreateProc

            lda #$FFFF
            sta wUnitRelocationDeploymentOffset,b

        _End
        rtl

        .databank 0

    .endsection ASMCShowItemPopUpBoxSection


    .section ASMCGiveToSupplyMenuIfInventoryFullSection

      .al
      .xl

      rlASMCGiveToSupplyMenuIfInventoryFull ; 81/B259

        .al
        .autsiz
        .databank ?

        lda wInventoryFullDeploymentOffset,b
        bmi +

          tax
          lda aDeploymentTable._UnitRAMPointer,x
          sta wSelectedUnitDataRAMPointer,b
          jsr rsOpenInventoryFullMenuForSlot8
          lda #$FFFF
          sta wInventoryFullDeploymentOffset,b

        +
        rtl

        .databank 0

    .endsection ASMCGiveToSupplyMenuIfInventoryFullSection


    .section ASMCGiveItemFromSlot8Section

      .al
      .xl

      rsOpenInventoryFullMenuForSlot8 ; 81/B270

        .al
        .autsiz
        .databank ?

        ; Opens the inventory-full menu for item slot 8

        lda #8
        jsl rlGetItemIDByInventorySlot
        jsl rlGetItemDataROMPointer
        lda wCurrentItemDataROMPointer,b
        sta aProcSystem.wInput0,b
        lda wSelectedUnitDataRAMPointer,b
        sta aProcSystem.wInput3,b
        jsl rlOpenInventoryFullNewItem
        jsl rlOpenInventoryFullMessage
        lda wSelectedUnitDataRAMPointer,b
        sta aProcSystem.wInput0,b
        lda wCurrentItemDataROMPointer,b
        sta aProcSystem.wInput1,b
        lda #(`procInventoryFullMenu)<<8
        sta lR44+1
        lda #<>procInventoryFullMenu
        sta lR44
        jsl rlEventEngineCreateProc
        rts

        .databank 0

    .endsection ASMCGiveItemFromSlot8Section


    .section ASMCGiveJuliaLightIfNoWeaponSection

      .al
      .xl

      rlASMCGiveJuliaLightIfNoWeapon ; 86/C6A2

        .al
        .autsiz
        .databank ?

        lda wSelectedUnitDataRAMPointer,b
        pha
        lda wRoutineVariable1,b
        pha

        lda #Julia
        jsl rlGetUnitRAMDataPointerByID
        bcs _End

          jsl rlGetFirstWeaponBattleMight
          ora #0
          bne _End

            jsl rlGetSelectedUnitInventorySize
            cmp #7
            bcc +

              lda #7
              sta wSelectedInventorySlot,b
              jsl rlDumpInventorySlotIntoSupplyIfFilled
              bcs _End

            +
            lda #PI_Light2
            sta wRoutineVariable1,b
            jsl rlGivePlayerItemIDToSelectedUnitsFirstItemSlot
            jsl rlEquipFirstWeaponInInventory

        _End
        pla
        sta wRoutineVariable1,b
        pla
        sta wSelectedUnitDataRAMPointer,b
        rtl

        .databank 0

    .endsection ASMCGiveJuliaLightIfNoWeaponSection


    .section ASMCStatUpDisplaySection

      .al
      .xl

      rlASMCStatUpDisplay ; 91/BD94

        ; Shows stat gains for unit in EventUnitSlot1

        .al
        .autsiz
        .databank ?

        lda wEventUnitSlot1XCoordinate
        sta aActionStructUnit1.XPosition
        lda wEventUnitSlot1YCoordinate
        sta aActionStructUnit1.YPosition
        jsl rlStartEventStatUpRewards
        rtl

        .databank 0

      rlStartEventStatUpRewards ; 91/BDA9

        .al
        .autsiz
        .databank ?

        ; Runs rlStartMapActionRewards with zeroed item, level, gold, and experience and halts the event

        sep #$20
        lda #0
        sta wBattleType
        rep #$20

        lda #$FFFF
        sta aActionStructUnit1.ObtainedItem
        lda #0
        sta aActionStructUnit1.GainedLevels
        sta aActionStructUnit1.ObtainedStealMoney
        sta aActionStructUnit1.GainedExperience
        jsl rlStartMapActionRewards
        jsl rlCreateProcHaltEvent
        rtl

        .databank 0

        ; 91/BDD2

    .endsection ASMCStatUpDisplaySection


    .section FinalChapterJuliaRecruitmentASMCSection

      .al
      .xl

      rlASMCChapterFinalJuliaRecruitment ; B1/E8D9

        .al
        .autsiz
        .databank ?

        lda #Julia
        jsl rlGetUnitRAMDataPointerByID
        bcs +

          jsl rlGetSelectedUnitDeploymentOffset
          tax
          lda #FS_Player
          jsl rlChangeFactionSlotOfFieldedSelectedUnit

        +
        rtl

        .databank 0

    .endsection FinalChapterJuliaRecruitmentASMCSection


    .section Unsorted85BC0FSection

      .al
      .xl

      procItemPopUp .structProcInfo "PW", rlProcItemPopUpInit, rlProcGoldPopUpShow, aProcDialogueBoxCode ; 85/BC0F

        .long aGoldPopUpData
        .byte 1

    .endsection Unsorted85BC0FSection


    .section ASMCDialogueSection

      .al
      .xl

      rlASMCContinueDuringDialogue ; 91/B11C

        .al
        .xl
        .autsiz
        .databank ?

        ; If a dialogue is running, marks its proc as one the event does not wait for (rlUnknown91A4AC), so the script goes on while the text shows.

        lda #(`procDialogue)<<8
        sta lR44+1
        lda #<>procDialogue
        sta lR44
        jsl rlProcEngineFindProc
        bcc _End

          jsl rlUnknown91A4AC

        _End
        rtl

        .databank 0

    .endsection ASMCDialogueSection


    .section Unsorted91B131Section

      .al
      .xl

      rlASMCCloseDialogue ; 91/B131

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Frees the dialogue proc and steps the dialogue until it has closed, running this command again (wActiveEventOffset back 4) while it has not.

        lda #(`procDialogue)<<8
        sta lR44+1
        lda #<>procDialogue
        sta lR44
        jsl rlProcEngineFindProc
        bcc _B147
        txa
        lsr a
        jsl rlProcEngineFreeProcByIndex

        _B147
        lda aDialogue.wStatus,b
        beq _B163
        jsl rlRunDialogueCycle
        lda aDialogue.wStatus,b
        bne _B159
        jsl rlDialogueFreeHDMA

        _B159
        lda wActiveEventOffset,b
        sec
        sbc #$0004
        sta wActiveEventOffset,b

        _B163
        rtl

        .databank 0

        ; 91/B164

    .endsection Unsorted91B131Section


