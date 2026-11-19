; Creating and removing the unit and terrain windows on the map.

    .section CreateUnitWindowAndTerrainWindowProcsSection

      .al
      .xl

      rlCreateUnitWindowAndTerrainWindowProcs ; 85/9B59

        .al
        .autsiz
        .databank ?

        jsl rlCheckIfUnitWindowSettingOff
        ora #0
        bne +

          lda #(`$85C652)<<8
          sta lR44+1
          lda #<>$85C652
          sta lR44
          jsl rlProcEngineFindProc
          bcs +

            jsl rlProcEngineCreateProc
        
        +
        jsl rlCheckIfTerrainWindowSettingOff
        ora #0
        bne +

          lda #(`$85C33F)<<8
          sta lR44+1
          lda #<>$85C33F
          sta lR44
          jsl rlProcEngineFindProc
          bcs +

            jsl rlProcEngineCreateProc

        +
        rtl

        .databank 0

      rlClearUnitWindowAndTerrainWindowProcs ; 85/9B94

        .al
        .autsiz
        .databank ?

        lda #(`$85C652)<<8
        sta lR44+1
        lda #<>$85C652
        sta lR44
        jsl rlProcEngineFindProc
        bcc +

          jsl rlProcEngineFreeProc

        +
        lda #(`$85C33F)<<8
        sta lR44+1
        lda #<>$85C33F
        sta lR44
        jsl rlProcEngineFindProc
        bcc +

          jsl rlProcEngineFreeProc

        +
        rtl

        .databank 0

        ; 85/9BBD

    .endsection CreateUnitWindowAndTerrainWindowProcsSection
