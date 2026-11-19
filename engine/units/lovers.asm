; Setting up lover pairs.

    .section LoversSection

      .al
      .xl

      rlSetUnitsAsLoversByGenerationIDs ; 84/8C31

        .al
        .autsiz
        .databank ?

        ; Input:
        ; wRoutineVariable2 = male GenerationID
        ; wRoutineVariable3 = female GenerationID

        phb
        php
        phk
        plb
        lda wSelectedUnitDataRAMPointer,b
        pha

        lda wRoutineVariable2,b
        sta wRoutineVariable1,b

        lda #0
        jsl rlFindGenerationIDInFactionSlotData

        jsl rlGetSelectedUnitLoverGenerationID
        ora #0
        bne _End

          lda wRoutineVariable3,b
          cmp #$0010
          bcc _BRK

            jsl rlSetSelectedUnitLoverGenerationID
            jsl rlGetSelectedUnitCharacterID
            pha

            lda wRoutineVariable3,b
            sta wRoutineVariable1,b
            lda #0
            jsl rlFindGenerationIDInFactionSlotData
            lda wRoutineVariable2,b
            cmp #$0010
            bcs _BRK

              jsl rlSetSelectedUnitLoverGenerationID

              lda #$0011
              sta bEventActionIdentifier,b
              jsl rlGetSelectedUnitCharacterID
              sta wEventEngineArgument1,b

              pla
              sta wEventEngineArgument2,b

              ; Arg 1 holds male, arg 2 holds female
              jsl rlGetAndRunChapterMapEventConditions

        _End
        pla
        sta wSelectedUnitDataRAMPointer,b
        plp
        plb
        rtl

        _BRK
        brk

        .databank 0

      rlUnknown848C96 ; 84/8C96

        .al
        .autsiz
        .databank `aUnitRAMPointers

        phb
        php

        sep #$20
        lda #`aUnitRAMPointers
        pha
        rep #$20
        plb

        phx
        phy
        ldx wSelectedUnitDataRAMPointer,b
        phx
        ldx wR0
        phx

        ldx #(24 - 1) * size(word)
        lda #0
        
          -
          sta $2000,b,x
          dec x
          dec x
          bpl -

        lda aUnitRAMPointers._Header.CurrentStructCount
        and #$00FF
        asl a
        sta wR0

        ldx #0

        -
        lda aUnitRAMPointers._Entry[0],x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitCharacterID
        cmp #Gerrard
        bcs ++

          tay
          lda wCurrentChapter,b
          cmp #Chapter06
          bcc +

            cpy #Seliph
            bcc ++

          +
          jsl rlGetSelectedUnitGenerationID
          dec a
          asl a
          tay
          lda wSelectedUnitDataRAMPointer,b
          sta $2000,b,y

        +
        inc x
        inc x
        cpx wR0
        bcc -

        plx
        stx wR0
        plx
        stx wSelectedUnitDataRAMPointer,b

        ply
        plx
        plp
        plb
        rtl

        .databank 0

        ; 84/8CFE

    .endsection LoversSection
