; TODO: describe this file.

    .section CalculateTacticsRankingSection

      .al
      .xl

      rlCalculateTacticsRanking ; 84/8CFE

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        phy

        stz wRoutineVariable1,b
        ldx #11 * size(word)
        
          -
          lda aChapterTurncounts,b,x
          clc
          adc wRoutineVariable1,b
          sta wRoutineVariable1,b
          dec x
          dec x
          bpl -

        ldy #<>aTacticsRankingThresholds
        jsr rsEvaluateSpecifiedRankingScore
        clc
        adc wDestroyedLocationsCount,b
        cmp #5
        bcc +

          lda #4

        +
        ply
        plx
        plp
        plb
        rtl

        .databank 0

      aTacticsRankingThresholds ; 84/8D2F

        .word   1,  399
        .word 400,  549
        .word 550,  799
        .word 800, 1099

      rlCalculateSurvivalRanking ; 84/8D3F

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phy

        lda wTotalAlivePlayerUnitCount
        sta wRoutineVariable1,b

        ldy #<>aSurvivalRankingThresholds
        jsr rsEvaluateSpecifiedRankingScore

        ply
        plp
        plb
        rtl

        .databank 0

      aSurvivalRankingThresholds ; 84/8D55

        .word 44, 48
        .word 43, 43
        .word 42, 42
        .word 41, 41

      rlCalculateCombatRanking ; 84/8D65

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        phy

        stz wRoutineVariable1,b
        ldx #48 - 1
        
          -
          txa
          jsl rlUnknown91EBBE
          clc
          adc wRoutineVariable1,b
          sta wRoutineVariable1,b
          dec x
          bpl -

        ldy #<>aCombatRankingThresholds
        jsr rsEvaluateSpecifiedRankingScore

        ply
        plx
        plp
        plb
        rtl

        .databank 0

      aCombatRankingThresholds ; 84/8D8B

        .word  0,  3
        .word  4, 10
        .word 11, 30
        .word 31, 50

      rlCalculateExperienceRanking ; 84/8D9B

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phy

        lda wTotalLevelUpCount
        sta wRoutineVariable1,b

        ldy #<>aExperienceRankingThresholds
        jsr rsEvaluateSpecifiedRankingScore

        ply
        plp
        plb
        rtl

        .databank 0

      aExperienceRankingThresholds ; 84/8DB1

        .word 1000, 1440
        .word 800, 999
        .word 600, 799
        .word 400, 599

      rlCalculateFinalRankingScore ; 84/8DC1

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        stz wR10

        jsl rlCalculateTacticsRanking
        clc
        adc wR10
        sta wR10

        jsl rlCalculateSurvivalRanking
        clc
        adc wR10
        sta wR10

        jsl rlCalculateCombatRanking
        clc
        adc wR10
        sta wR10

        jsl rlCalculateExperienceRanking
        clc
        adc wR10
        sta wR10

        lda wR10
        inc a
        inc a
        lsr a
        lsr a
        plp
        plb
        rtl

        .databank 0

    .endsection CalculateTacticsRankingSection


    .section EvaluateSpecifiedRankingScoreSection

      .al
      .xl

      rsEvaluateSpecifiedRankingScore ; 84/8ED7

        .al
        .autsiz
        .databank ?

        phx
        phy
        ldx #0

          _Loop
          lda $0000,b,y
          dec a
          cmp wRoutineVariable1,b
          bpl _Next

            lda $0002,b,y
            cmp wRoutineVariable1,b
            bcs _End

          _Next
          inc x
          inc y
          inc y
          inc y
          inc y
          cpx #4
          bcc _Loop

        _End
        txa
        ply
        plx
        rts

        .databank 0

        ; 84/8EFB














; 859BD1

; lands at 7ffce1

; .byte 8
; .byte 10
; .long aBG3TilemapBuffer
; .byte
; .long 0

; size 9

    .endsection EvaluateSpecifiedRankingScoreSection
