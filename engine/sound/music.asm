; Choosing music: the songs for each faction's phase in each chapter, and the
; victory theme. The unknown routines here sit next to them in the ROM.

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

      rsUnknown81AAFB ; 81/AAFB

        .al
        .autsiz
        .databank ?

        ; Loads enemy music?

        jsl rlGetVictoryThemeIfAllEnemiesDead
        bcs +

          lda wCurrentChapter,b
          asl a
          tax
          lda aUnknown81AB0E,x

        +
        sta wMusicID,b
        rts

        .databank 0

      aUnknown81AB0E ; 81/AB0E

        ; Song IDs?

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

      rlUnknown81AB26 ; 81/AB26

        .al
        .autsiz
        .databank ?

        lda bAPUStatus,b
        bit #$0002
        beq +

        lda $0DAB,b
        cmp aSoundScriptPrevious,b
        beq _End

        +
        lda $0DAB,b
        beq _End

        sta wMusicID,b
        
        _End
        rtl

        .databank 0

      rlUnknown81AB3F ; 81/AB3F

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb

        jsl rlGetVictoryThemeIfAllEnemiesDead
        bcc _End

          sta $0DAB,b
          sta aProcSystem.wInput0,b

          lda wUnknown00171A,b
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

      rsUnknown81AB6B ; 81/AB6B

        .al
        .autsiz
        .databank ?

        lda wUnknown00171A,b
        bne _End

          jsl rlUnknown84C33D

          lda wActiveFactionSlot,b
          jsl rlRunTurnStartEffectsForAllUnitsInFaction
          jsl rlEnableAIEngineCycle

          lda wActiveFactionSlot,b
          jsl rlUnknown84C5D7
          bcc +

            jsl rlUnknown81A9D4

          +
          inc wGameStateStep,b
        
        _End
        rts

        .databank 0

    .endsection PlayerPhaseChapterSongIDsSection


    .section Unknown81AB90Section

      .al
      .xl

      rsUnknown81AB90 ; 81/AB90

        .al
        .autsiz
        .databank ?

        ; Handle turn start healing animations?

        lda $7E2002
        beq _ABF1

          lda $7E2000
          tax
          clc
          adc #5
          sta $7E2000

          lda $7E2006,x
          and #$00FF
          sta aProcSystem.wInput0,b

          lda aDebugMenuSkillFlags.bAdept,x
          and #$00FF
          xba
          ora aProcSystem.wInput0,b
          sta aProcSystem.wInput0,b

          lda $7E2008,x
          and #$00FF
          sta aProcSystem.wInput1,b

          lda aDebugMenuSkillFlags.bWrath,x
          and #$00FF
          sta aProcSystem.wInput2,b

          lda $7E2004,x
          and #$00FF
          sta aProcSystem.wInput3,b

          lda #(`procMapExperienceWindow)<<8
          sta $62+1
          lda #<>procMapExperienceWindow
          sta $62
          jsl rlProcEngineCreateProc

          lda $7E2002
          dec a
          sta $7E2002
          rts

        _ABF1
        jsl rlShowMapWindows

        lda #$0004
        tsb wMapSystemFlags,b

        jsr rsUnknown81AC02
        inc wGameStateStep,b
        rts

        .databank 0

    .endsection Unknown81AB90Section


    .section ProcScript8283E3Section

      .al
      .xl

      procFadeOutAndChangeSong ; 82/83E3

        .structProcInfo "SB", rlProcFadeOutAndChangeSongInit, rlProcFadeOutAndChangeSongCycle1, aProcFadeOutAndChangeSongCode

    .endsection ProcScript8283E3Section


    .section Unsorted8283EBSection

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

    .endsection Unsorted8283EBSection


    .section Unsorted8283FASection

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

    .endsection Unsorted8283FASection


    .section Unsorted82841FSection

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

    .endsection Unsorted82841FSection


    .section ProcScript828429Section

      .al
      .xl

      aProcFadeOutAndChangeSongCode ; 82/8429

        PROC_YIELD 3
        PROC_SET_ONCYCLE rlProcFadeOutAndChangeSongCycle2
        PROC_HALT


        ; 82/8431

    .endsection ProcScript828429Section


