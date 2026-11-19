; Talk events: whether a talk event is available, and the conditions it can
; check (always, never, or enough money).

    .section GetChapterTalkEventsPointerSection

      .al
      .xl

      rlGetChapterTalkEventsPointer ; 81/B4E4

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phy

        lda $0D6D,b
        sta lR18+1

        ldy lChapterEventDataPointer,b
        sep #$20
        lda lChapterEventDataPointer+2,b
        pha
        rep #$20
        plb

        lda structChapterEventData.TalkEventsPointer,b,y
        sta lR18

        ply
        plp
        plb
        rtl

        .databank 0

        ; 81/B503

    .endsection GetChapterTalkEventsPointerSection


    .section CheckTalkEventEntryAvailableSection

      .al
      .xl

      rlCheckTalkEventEntryAvailable ; 87/9E42

        .al
        .autsiz
        .databank ?

        ; Returns SEC if a talk entry is possible
        ; Returns the CostsMoneyFlag in A

        phb
        phk 
        plb
        phx
        phy

        lda wR0
        pha
        lda wR1
        pha
        lda lR18
        pha
        lda lR18+1
        pha

        jsl rlGetChapterTalkEventsPointer

        lda lR18
        beq _End

          ldy wSelectedUnitDataRAMPointer,b

          lda wRoutineVariable1,b
          sta wSelectedUnitDataRAMPointer,b
          jsl rlGetSelectedUnitCharacterID
          sta wR1

          sty wSelectedUnitDataRAMPointer,b

          jsl rlGetSelectedUnitCharacterID
          sta wR0

          ldy lR18
          sep #$20
          lda lR18+2
          pha
          rep #$20
          plb
          
          _Loop
          lda structChapterTalkEventEntry.Chapter,b,y
          cmp #$FFFF
          beq _CLC

            pha

            lda structChapterTalkEventEntry.Flag,b,y
            and #$00FF
            sta wEventEngineParameter1,b

            pla

            jsl rlCheckIfEventFlagOfSpecifiedChapterSet
            bcs _Next

              lda structChapterTalkEventEntry.ActiveUnit,b,y
              cmp #$FFFF
              beq +

                cmp wR0
                bne _Next
              
              +
              lda structChapterTalkEventEntry.TargetUnit,b,y
              cmp wR1
              bne _Next

                ; This is a routine index and not a flag, but a flag simplifies things.
                lda structChapterTalkEventEntry.CostsMoneyFlag,b,y
                and #$00FF
                asl a
                tax
                jsr (aTalkEventRoutinePointers,x)
                bcs _SEC

            _Next
            tya
            clc
            adc #size(structChapterTalkEventEntry)
            tay
            bra _Loop

          _CLC
          clc
        
        _End
        plx
        stx lR18+1
        plx
        stx lR18
        plx
        stx wR1
        plx
        stx wR0

        ply
        plx
        plb
        rtl

        _SEC
        txa
        lsr a
        sec
        bra _End

        .databank 0

      aTalkEventRoutinePointers ; 87/9ED4

        .word <>rsTalkEventRoutineAlways
        .word <>rsTalkEventRoutineCheckMoney

      rsTalkEventRoutineAlways ; 87/9ED8

        .al
        .autsiz
        .databank ?

        sec
        rts

        .databank 0

      rsTalkEventRoutineNever ; 87/9EDA

        .al
        .autsiz
        .databank ?

        clc
        rts

        .databank 0

      rsTalkEventRoutineCheckMoney ; 87/9EDC

        .al
        .autsiz
        .databank ?

        jsl rlGetSelectedUnitMoney
        cmp #10000
        bcc rsTalkEventRoutineNever
        bra rsTalkEventRoutineAlways

        .databank 0

        ; 87/9EE7

    .endsection CheckTalkEventEntryAvailableSection
