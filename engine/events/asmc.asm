; ASMCs: assembly routines called from chapter event scripts. So far only the final
; chapter's Julia recruitment is here; other ASMCs live with the system they belong to.

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
