; Code from bank $8B not yet assigned to a game system.

    .section Unsorted8B8000Section

      .al
      .xl

      rsUnknown8B8000 ; 8B/8000

        .al
        .autsiz
        .databank ?

        lda #(`procMainLoopChangeFadeByTimer)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFadeByTimer
        sta lR44
        jsl rlProcEngineFindProc
        bcs +

          lda wCurrentChapter,b
          cmp #$FFFF
          beq +

            lda wJoy1New
            cmp #JOY_Start
            bne +

              lda #2
              sta wScreenFadingProcInput,b

              lda #<>rsUnknown80F2BE
              sta aProcSystem.wInput0,b

              lda #(`procMainLoopChangeFadeByTimer)<<8
              sta lR44+1
              lda #<>procMainLoopChangeFadeByTimer
              sta lR44
              jsl rlProcEngineCreateProc

              lda #2
              sta wUnknown00171C,b
              jsl rlUnknown9180BC

        +
        jsr rsHandleWorldMapPortraits
        jsr rsHandleWorldMapMarkers

        lda aDialogue.wStatus,b
        beq +

          lda #$00E2
          sta wR0
          lda #$00C4
          sta wR1
          jsl rlDisplayDialogueAPressArrows

          jsl rlDMAByStruct

            .structDMAToVRAM $7E8908, $0140, $80, $BD80

        +
        jsr $8B8114
        rtl

        .databank 0

        ; 8B/806D

    .endsection Unsorted8B8000Section
