; Lovers: pairing up lovers, and the love bases, growths and love points between
; units.

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


    .section FatherChildrenSection

      .al
      .xl

      rlGetFatherUnitsChildrenRAMPointers ; 84/8DF4

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = father CharacterID

        ; Output:
        ; wSonUnitRAMPointer = the unit RAM pointer of his son, or 0
        ; wDaughterUnitRAMPointer = the unit RAM pointer of his daughter, or 0
        ; If he has more than one, the last one in aUnitRAMPointers is kept.

        phb
        php
        phk
        plb
        phx

        ldx wSelectedUnitDataRAMPointer,b
        phx
        ldx wR0
        phx
        ldx wR1
        phx

        sta wR0

        sep #$20
        lda #$7E
        pha
        rep #$20
        plb
        .databank $7E

        lda aUnitRAMPointers._Header.CurrentStructCount
        and #$00FF
        asl a
        sta wR1

        stz wSonUnitRAMPointer
        stz wDaughterUnitRAMPointer

        ldx #0

          _Loop
          lda aUnitRAMPointers._Entry[0],x
          sta wSelectedUnitDataRAMPointer,b
          jsl rlGetSelectedUnitFatherID
          cmp wR0
          bne _Next

            jsl rlGetSelectedUnitGender
            cmp #GenderMale
            bne _Female

              lda wSelectedUnitDataRAMPointer,b
              sta @l wSonUnitRAMPointer
              bra _Next

            _Female
            lda wSelectedUnitDataRAMPointer,b
            sta @l wDaughterUnitRAMPointer

          _Next
          inc x
          inc x
          cpx wR1
          bcc _Loop

        stz wSelectedUnitDataRAMPointer,b

        pla
        sta wR1
        pla
        sta wR0
        pla
        sta wSelectedUnitDataRAMPointer,b

        plx
        plp
        plb
        rtl

        .databank 0

        ; 84/8E5D

    .endsection FatherChildrenSection


    .section CheckUnitsMarriedToEachOtherSection

      .al
      .xl

      rlCheckUnitsMarriedToEachOther ; 84/8EA0

        .al
        .autsiz
        .databank ?

        ; Input:
        ; wR0 = CharacterID1
        ; wR1 = CharacterID2

        ; Output:
        ; SEC if married, clc if not

        lda wSelectedUnitDataRAMPointer,b
        pha
        lda wRoutineVariable1,b
        pha

        lda wR1
        jsl rlGetUnitRAMDataPointerByID
        bcs _CLC

          jsl rlGetSelectedUnitGenerationID
          bcs _CLC

            sta wRoutineVariable1,b
            lda wR0
            jsl rlGetUnitRAMDataPointerByID
            bcs _CLC

              jsl rlGetSelectedUnitLoverGenerationID
              cmp wRoutineVariable1,b
              bne _CLC

                sec

                -
                pla
                sta wRoutineVariable1,b
                pla
                sta wSelectedUnitDataRAMPointer,b
                rtl

        _CLC
        clc
        bra -

        .databank 0

    .endsection CheckUnitsMarriedToEachOtherSection


    .section LovePointsSection

      .al
      .xl

      rlGetUnitLoveBaseWithTarget ; 87/ABC1

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        ldx wSelectedUnitDataRAMPointer,b
        phx
        ldx wR0
        phx
        ldx wR1
        phx

        jsl rlGetSelectedUnitGenerationID
        bcs _AC3E

        cmp #$10
        bcs +

          ; male unit
          jsl rlGetSelectedUnitLoveDataID
          sta wR0
          lda wRoutineVariable1,b
          sta wSelectedUnitDataRAMPointer,b
          jsl rlGetSelectedUnitLoveDataID
          asl a
          sta wR1
          bra ++

          ; female unit
          +
          jsl rlGetSelectedUnitLoveDataID
          asl a
          sta wR1
          lda wRoutineVariable1,b
          sta wSelectedUnitDataRAMPointer,b
          jsl rlGetSelectedUnitLoveDataID
          sta wR0

        +
        ldx wR1
        lda aLoveBaseOffsets,x
        clc
        adc wR0
        tax
        lda aLoveBaseOffsets,x
        and #$00FF
        cmp #$00FF
        beq ++

        cmp #$00FE
        beq +

        asl a
        sta wR0
        asl a
        asl a
        clc
        adc wR0
        bra _End
        
        +
        lda #499
        bra _End

        +
        lda #$FFFF
        
        _End
        plx
        stx wR1
        plx
        stx wR0
        plx
        stx wSelectedUnitDataRAMPointer,b
        plx
        plp
        plb
        rtl

        _AC3E
        lda #0
        bra _End

        .databank 0

      rlGetSelectedUnitLoverData ; 87/AC43

        .al
        .autsiz
        .databank ?

        ldx wSelectedUnitDataRAMPointer,b
        sep #$20
        lda $7E0000+structCharacterDataRAM.LoverData+2,x
        pha
        rep #$20
        plb
        lda $7E0000+structCharacterDataRAM.LoverData,x
        tax
        rtl

        .databank 0

      rlSaveLoverDataToBuffer ; 87/AC56

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        phy
        lda lR18
        pha
        lda lR18+1
        pha

        jsl rlGetSelectedUnitLoverData
        lda lRAMBufferPointer+1,b
        sta lR18+1
        lda lRAMBufferPointer,b
        sta lR18
        ldy #0

          -
          lda $0000,b,x
          sta [lR18],y
          inc x
          inc x
          inc y
          inc y
          cpy #size(structLoverDataRAM)
          bne -

        pla
        sta lR18+1
        pla
        sta lR18
        ply
        plx
        plp
        plb
        rtl

        .databank 0

      rlUnknown87AC8C ; 87/AC8C

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        phy
        lda $24
        pha
        lda $24+1
        pha

        jsl rlGetSelectedUnitLoverData
        lda lRAMBufferPointer+1,b
        sta $24+1
        lda lRAMBufferPointer,b
        sta $24
        ldy #0
        
        -
        lda [$24],y
        sta $0000,b,x
        inc x
        inc x
        inc y
        inc y
        cpy #$001E
        bne -

        pla
        sta $24+1
        pla
        sta $24
        ply
        plx
        plp
        plb
        rtl

        .databank 0

      rlGetSelectedUnitLoveDataIDByCharacterID ; 87/ACC2

        .al
        .autsiz
        .databank ?

        phx
        phy
        lda wRoutineVariable1,b
        pha

        jsl rlGetSelectedUnitCharacterID
        cmp #Gerrard
        bcs _Enemy

          sta wRoutineVariable1,b

          jsl rlGetSelectedUnitGender
          cmp #GenderMale
          bmi _Enemy
          bne _Female

          ; Male
          ldx #<>aMaleLoveDataIDs
          bra +

          _Female
          ldx #<>aFemaleLoveDataIDs
          
          +
          ldy #0
          
          -
          lda $830000,x
          bmi _End

          cmp wRoutineVariable1,b
          beq _Match

          inc y
          inc x
          inc x
          bra -
          
          _End
          plx
          stx wRoutineVariable1,b
          ply
          plx
          rtl

          _Match
          tya
          plx
          stx wRoutineVariable1,b
          ply
          plx
          rtl

        _Enemy
        lda #$FFFF
        bra _End

        .databank 0

      rlGetUnitLoveGrowthWithTarget ; 87/AD0E

        .al
        .autsiz
        .databank ?

        phb
        php

        phk
        plb

        phx
        ldx wSelectedUnitDataRAMPointer,b
        phx
        ldx wR0
        phx
        ldx wR1
        phx

        jsl rlGetSelectedUnitGenerationID
        bcs _AD79

        cmp #$10
        bcs +

        jsl rlGetSelectedUnitLoveDataID
        sta wR0
        lda wRoutineVariable1,b
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitLoveDataID
        asl a
        sta wR1
        bra ++

        +
        jsl rlGetSelectedUnitLoveDataID
        asl a
        sta wR1
        lda wRoutineVariable1,b
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitLoveDataID
        sta wR0
        
        +
        ldx wR1
        lda aLoveGrowthOffsets,x
        clc
        adc wR0
        tax
        lda aLoveGrowthOffsets,x
        bit #$0080
        bne +

        and #$007F
        bra _End
        
        +
        ora #$FF80
        
        _End
        plx
        stx wR1
        plx
        stx wR0
        plx
        stx wSelectedUnitDataRAMPointer,b
        plx

        plp
        plb
        rtl
        
        _AD79
        lda #0
        bra _End

        .databank 0

      rlGetLoverPointsWithTarget ; 87/AD7E

        .al
        .autsiz
        .databank ?

        phb
        php

        phk
        plb

        phx

        ldx wRoutineVariable1,b
        phx

        dec a
        asl a
        sta wRoutineVariable1,b
        jsl rlGetSelectedUnitLoverData
        cpx #0
        beq +

          txa
          clc
          adc wRoutineVariable1,b
          tax
          lda $0000,b,x

        +
        plx 
        stx wRoutineVariable1,b

        plx
        plp
        plb
        rtl

        .databank 0

      rlSaveUnitLoveValueWithTarget ; 87/ADA6

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        phy
        ldx wSelectedUnitDataRAMPointer,b
        phx
        ldx wR0
        phx
        ldx wR1
        phx

        sta wR0
        ldy wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitGenerationID
        cmp #$10
        bcs +

          ; male
          dec a
          sta wR1
          lda wRoutineVariable1,b
          sta wSelectedUnitDataRAMPointer,b
          bra ++
          
          ; female
          +
          lda wRoutineVariable1,b
          sta wSelectedUnitDataRAMPointer,b
          jsl rlGetSelectedUnitGenerationID
          bcs _End

          dec a
          sta wR1
          sty wSelectedUnitDataRAMPointer,b

        ; male number-1 in wR1, female pointer in wSelectedUnitDataRAMPointer
        +
        jsl rlGetSelectedUnitLoverData
        cpx #0
        beq _End

          txa
          asl wR1
          clc
          adc wR1
          tax
          lda wR0
          sta $0000,b,x

        _End
        plx
        stx wR1
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

      rlModifyUnitsLovePoints ; 87/AE05

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = male GenerationID
        ; wSelectedUnitDataRAMPointer = female character data
        ; wRoutineVariable1 = love points amount, can be negative

        ; If love points are 500 or more, marry units to each other.

        phb
        php
        phk
        plb
        phx
        phy
        ldx wRoutineVariable2,b
        phx
        ldx wRoutineVariable3,b
        phx

        cmp #$0010
        bcs _End

          sta wRoutineVariable2,b
          jsl rlGetSelectedUnitGenerationID
          bcs _End

            sta wRoutineVariable3,b
            jsl rlGetSelectedUnitLoverGenerationID
            ora #0
            bne _End

              jsl rlGetSelectedUnitLoverData
              txa
              clc
              adc wRoutineVariable2,b
              clc
              adc wRoutineVariable2,b
              dec a
              dec a
              tay

              lda $0000,b,y
              and #$01FF
              cmp #$01FF
              beq _End

                lda wRoutineVariable1,b
                beq _End
                bmi _Negative

                  lda $0000,b,y
                  clc
                  adc wRoutineVariable1,b
                  cmp #500
                  bcs +

                    sta $0000,b,y
                    bra _End

                  +
                  lda #500
                  sta $0000,b,y
                  jsl rlSetUnitsAsLoversByGenerationIDs
                  bra _End

                _Negative
                lda $0000,b,y
                clc
                adc wRoutineVariable1,b
                bpl +

                  lda #0

                +
                sta $0000,b,y

        _End
        plx
        stx wRoutineVariable3,b
        plx
        stx wRoutineVariable2,b
        ply
        plx
        plp
        plb
        rtl

        .databank 0

        ; 87/AE88

    .endsection LovePointsSection
