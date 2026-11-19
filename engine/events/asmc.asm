; ASMCs: assembly routines called from chapter event scripts. So far only the final
; chapter's Julia recruitment is here; other ASMCs live with the system they belong to.

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
