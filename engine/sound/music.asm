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
        cmp #AllegianceNeutral
        beq _NPC

          cmp #AllegianceOther
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
          lda #$001D
          bra _SEC

        _Yellow
        lda #$002A

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
        .word $002D

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
        sta $04BA,b
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

        lda $04F6,b
        bit #$0002
        beq +

        lda $0DAB,b
        cmp $0510,b
        beq _End

        +
        lda $0DAB,b
        beq _End

        sta $04BA,b
        
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

            lda #(`$8283E3)<<8
            sta lR44+1
            lda #<>$8283E3
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
          jsl rlUnknown869CE4

          lda wActiveFactionSlot,b
          jsl rlUnknown84C5D7
          bcc +

            jsl rlUnknown81A9D4

          +
          inc $0304,b
        
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
          sta $0ECF,b

          lda $7E2007,x
          and #$00FF
          xba
          ora $0ECF,b
          sta $0ECF,b

          lda $7E2008,x
          and #$00FF
          sta $0ED1,b

          lda $7E2005,x
          and #$00FF
          sta $0ED3,b

          lda $7E2004,x
          and #$00FF
          sta $0ED5,b

          lda #(`$85CA85)<<8
          sta $62+1
          lda #<>$85CA85
          sta $62
          jsl rlProcEngineCreateProc

          lda $7E2002
          dec a
          sta $7E2002
          rts

        _ABF1
        jsl rlUnknown85C0D5

        lda #$0004
        tsb $0788,b

        jsr rsUnknown81AC02
        inc $0304,b
        rts

        .databank 0

    .endsection Unknown81AB90Section
