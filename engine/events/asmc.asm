; ASMCs: assembly routines called from chapter event scripts. So far only the final
; chapter's Julia recruitment is here; other ASMCs live with the system they belong to.

    .section ASMCShowItemPopUpBoxSection

      .al
      .xl

      rlASMCShowItemPopUpBox ; 81/B223

        .al
        .autsiz
        .databank ?

        lda wUnknownDeploymentOffset000D7F,b
        bmi _End

          lda $0D81,b
          cmp #8
          bne _End

            lda $0D83,b
            jsl rlGetItemRAMStructEntryByPlayerItemIndex
            jsl rlGetEffectiveItemIDByItemRAMStructEntry
            sta aProcSystem.wInput2,b

            lda #$0D00
            sta aProcSystem.wInput3,b
            lda #(`procUnknown85BC0F)<<8
            sta lR44+1
            lda #<>procUnknown85BC0F
            sta lR44
            jsl rlEventEngineCreateProc

            lda #$FFFF
            sta wUnknownDeploymentOffset000D7F,b

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

        lda $0D89,b
        bmi +

          tax
          lda aDeploymentTable._UnitRAMPointer,x
          sta wSelectedUnitDataRAMPointer,b
          jsr rsUnknown81B270
          lda #$FFFF
          sta $0D89,b

        +
        rtl

        .databank 0

    .endsection ASMCGiveToSupplyMenuIfInventoryFullSection


    .section ASMCGiveItemFromSlot8Section

      .al
      .xl

      rsUnknown81B270 ; 81/B270

        .al
        .autsiz
        .databank ?

        lda #8
        jsl rlGetItemIDByInventorySlot
        jsl rlGetItemDataROMPointer
        lda wCurrentItemDataROMPointer,b
        sta aProcSystem.wInput0,b
        lda wSelectedUnitDataRAMPointer,b
        sta aProcSystem.wInput3,b
        jsl rlUnknown85B52F
        jsl rlUnknown85B520
        lda wSelectedUnitDataRAMPointer,b
        sta aProcSystem.wInput0,b
        lda wCurrentItemDataROMPointer,b
        sta aProcSystem.wInput1,b
        lda #(`procUnknown85B18F)<<8
        sta lR44+1
        lda #<>procUnknown85B18F
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
        jsl rlUnknown91BDA9
        rtl

        .databank 0

      rlUnknown91BDA9 ; 91/BDA9

        .al
        .autsiz
        .databank ?

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
        jsl rlUnknown9EAC5A
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
