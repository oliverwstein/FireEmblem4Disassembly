; Assembly routines called from chapter event scripts (ASMCs).

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
