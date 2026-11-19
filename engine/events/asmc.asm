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
