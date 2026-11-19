; Code from bank $9F not yet assigned to a game system.

    .section Unsorted9F86B0Section

      .al
      .xl

      rlUnknown9F86B0 ; 9F/86B0

        .al
        .autsiz
        .databank ?

        lda bDecompressionArrayFlag,b
        bne +

          lda aProcSystem.aHeaderBitfield,b,x
          ora #1
          sta aProcSystem.aHeaderBitfield,b,x

        +
        rtl

        .databank 0

        ; 9F/86BF

    .endsection Unsorted9F86B0Section
