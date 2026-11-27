; Choosing music: the songs for each faction's phase in each chapter, and the
; victory theme, the chapter's first-phase song, and resuming the phase song
; (rlResumePhaseMusic) after an event or another screen. Bank $81; the map step
; that uses them is in engine/map/map_step.asm.

    .section GetActiveFactionSongIDSection

      .al
      .xl

      rsGetActiveFactionSongID ; 81/AA00

        .al
        .autsiz
        .databank ?

        ; Returns CLC if faction name out of bounds or phase has no faction name assigned
        ; Returns SEC if phase song found

        lda wActiveFactionSlot,b
        bne +

          jsl rlGetVictoryThemeIfAllEnemiesDead
          bcs _SEC

            lda wCurrentChapter,b
            asl a
            tax
            lda aPlayerPhaseChapterSongIDs,x
            bra _SEC

        +
        ldx #0
        jsl rlGetFactionRelation
        cmp #AllegianceAllied
        beq _NPC

          cmp #AllegianceNeutral
          beq _Yellow

            lda wActiveFactionSlot,b
            jsl rlGetFactionSlotNameID
            bit #$0080
            bne _CLC

              asl a
              cmp #53 * size(word)
              bcs _CLC

                tax
                lda aNonPlayerFactionPhaseSongIDs,x
                bra _SEC

          _NPC
          lda #SONG_ALLIED_PHASE
          bra _SEC

        _Yellow
        lda #SONG_NEUTRAL_PHASE

        _SEC
        sec

        -
        rts

        _CLC
        clc
        bra -

        .databank 0

    .endsection GetActiveFactionSongIDSection


    .section PlayerPhaseChapterSongIDsSection

      .al
      .xl

      aPlayerPhaseChapterSongIDs ; 81/AA4D

        .word SONG_PLAYER_PHASE_PROLOGUE
        .word SONG_PLAYER_PHASE_CHAPTER1
        .word SONG_PLAYER_PHASE_CHAPTER2
        .word SONG_PLAYER_PHASE_CHAPTER3
        .word SONG_PLAYER_PHASE_CHAPTER4
        .word SONG_PLAYER_PHASE_CHAPTER5
        .word SONG_PLAYER_PHASE_CHAPTER6
        .word SONG_PLAYER_PHASE_CHAPTER7
        .word SONG_PLAYER_PHASE_CHAPTER8
        .word SONG_PLAYER_PHASE_CHAPTER9
        .word SONG_PLAYER_PHASE_CHAPTER10
        .word SONG_PLAYER_PHASE_FINAL

      aNonPlayerFactionPhaseSongIDs ; 81/AA65

        .word $0022
        .word $0022
        .word $0022
        .word $0022
        .word $0022
        .word $0022
        .word $0022
        .word $0019
        .word $0019
        .word $0019
        .word $0019
        .word $0019
        .word $0019
        .word $0019
        .word $0027
        .word $0027
        .word $0027
        .word $0027
        .word $0027
        .word $0023
        .word $001F
        .word $001F
        .word $001F
        .word $001F
        .word $0019
        .word $0026
        .word $0026
        .word $0026
        .word $0026
        .word $0026
        .word $0025
        .word $0025
        .word $0025
        .word $0021
        .word $0021
        .word $0021
        .word $0021
        .word $0029
        .word $0029
        .word $0029
        .word $0029
        .word $0028
        .word $0028
        .word $0028
        .word $0028
        .word $0028
        .word $0017
        .word $0017
        .word $0017
        .word $0017
        .word $0017
        .word $0017
        .word $0017

      rlGetVictoryThemeIfAllEnemiesDead ; 81/AACF

        .al
        .autsiz
        .databank ?

        ; Returns SongID $20 and SEC aka victory theme if all enemies are dead.
        ; Returns CLC otherwise

        phx
        lda wActiveFactionSlot,b
        bne _CLC

          ldx #(72 -1) * size(word)
          
            -
            lda aDeploymentTable._StateBuffer,x
            bit #DeploymentStateAlive
            beq _Next

              bit #DeploymentStateHidden
              bne _Next

                and #DeploymentAllegianceMask
                cmp #AllegianceEnemy
                beq _CLC

            _Next
            dec x
            dec x
            bpl -

          lda #$0020
          sec

          -
          plx
          rtl
        
        _CLC
        clc
        bra -

        .databank 0

      rsStartChapterFirstPhaseSong ; 81/AAFB

        .al
        .autsiz
        .databank ?

        ; The first phase of a chapter: plays the victory theme if every enemy is gone, otherwise the chapter's first-phase song (aChapterFirstPhaseSongIDs).


        jsl rlGetVictoryThemeIfAllEnemiesDead
        bcs +

          lda wCurrentChapter,b
          asl a
          tax
          lda aChapterFirstPhaseSongIDs,x

        +
        sta wMusicID,b
        rts

        .databank 0

      aChapterFirstPhaseSongIDs ; 81/AB0E


        .word $0011
        .word $0013
        .word $002C
        .word $001C
        .word $0014
        .word $002B
        .word $0012
        .word $0018
        .word $001E
        .word $0024
        .word $001B
        .word $002E

      rlResumePhaseMusic ; 81/AB26

        .al
        .autsiz
        .databank ?

        ; Plays wPhaseSongID again unless it is already playing (after an event, a scene or the castle screen).

        lda bAPUStatus,b
        bit #$0002
        beq +

        lda wPhaseSongID,b
        cmp aSoundScriptPrevious,b
        beq _End

        +
        lda wPhaseSongID,b
        beq _End

        sta wMusicID,b
        
        _End
        rtl

        .databank 0

      rlCheckVictoryTheme ; 81/AB3F

        .al
        .autsiz
        .databank ?

        ; When every enemy is gone: makes the victory theme the phase song and, unless an event is running, fades the music over to it.

        phb
        php
        phk
        plb

        jsl rlGetVictoryThemeIfAllEnemiesDead
        bcc _End

          sta wPhaseSongID,b
          sta aProcSystem.wInput0,b

          lda wEventEngineFlags,b
          bne _End

            lda #$00E1
            sta aProcSystem.wInput1,b

            lda #(`procFadeOutAndChangeSong)<<8
            sta lR44+1
            lda #<>procFadeOutAndChangeSong
            sta lR44
            jsl rlProcEngineCreateProc

        _End
        plp
        plb
        rtl

        .databank 0

    .endsection PlayerPhaseChapterSongIDsSection


    .section ProcScript8283E3Section

      .al
      .xl

      procFadeOutAndChangeSong ; 82/83E3

        .structProcInfo "SB", rlProcFadeOutAndChangeSongInit, rlProcFadeOutAndChangeSongCycle1, aProcFadeOutAndChangeSongCode

    .endsection ProcScript8283E3Section


    .section ProcFadeOutAndChangeSongInitSection

      .al
      .xl

      rlProcFadeOutAndChangeSongInit ; 82/83EB

        .al
        .xl
        .autsiz
        .databank ?

        ; Save song ID wInput0 to aBody0 and send fade-out command wInput1

        lda aProcSystem.wInput0,b
        sta aProcSystem.aBody0,b,x
        lda aProcSystem.wInput1,b
        jsl rlSendSoundCommand
        rtl

        .databank 0

        ; 82/83F9

      rlProcFadeOutAndChangeSongCycle1 ; 82/83F9

        .al
        .xl
        .autsiz
        .databank ?

        ; Initial no-op on-cycle before PROC_YIELD 3 switches to Cycle2

        rtl

        .databank 0

        ; 82/83FA

    .endsection ProcFadeOutAndChangeSongInitSection


    .section ProcFadeOutAndChangeSongCycle2Section

      .al
      .xl

      rlProcFadeOutAndChangeSongCycle2 ; 82/83FA

        .al
        .xl
        .autsiz
        .databank ?

        ; Wait for wMusicID/APU silence, write aBody0 to wMusicID, switch to Cycle3

        lda wMusicID,b
        bne _841E
        lda bAPUStatus,b
        bit #$0030
        bne _841E
        lda aProcSystem.aBody0,b,x
        cmp aSoundScriptPrevious,b
        beq _841A
        sta wMusicID,b
        lda #<>rlProcFadeOutAndChangeSongCycle3
        sta aProcSystem.aHeaderOnCycle,b,x
        bra _841E


        _841A
        jsl rlProcEngineFreeProc

        _841E
        rtl

        .databank 0

        ; 82/841F

    .endsection ProcFadeOutAndChangeSongCycle2Section


    .section ProcFadeOutAndChangeSongCycle3Section

      .al
      .xl

      rlProcFadeOutAndChangeSongCycle3 ; 82/841F

        .al
        .xl
        .autsiz
        .databank ?

        ; Wait for new song wMusicID to finish/start (== 0), then free proc

        lda wMusicID,b
        bne _8428
        jsl rlProcEngineFreeProc

        _8428
        rtl

        .databank 0

        ; 82/8429

    .endsection ProcFadeOutAndChangeSongCycle3Section


    .section ProcScript828429Section

      .al
      .xl

      aProcFadeOutAndChangeSongCode ; 82/8429

        PROC_YIELD 3
        PROC_SET_ONCYCLE rlProcFadeOutAndChangeSongCycle2
        PROC_HALT


        ; 82/8431

    .endsection ProcScript828429Section


