; Code from bank $81 not yet assigned to a game system.

    .section Unsorted8189F3Section

      .al
      .xl

      rlUnknown8189F3 ; 81/89F3

        .al
        .autsiz
        .databank ?

        phb
        lda aActiveSpriteSystem.aUnknown0012E0,b,x
        bit #$4000
        beq _End

          ldx aMovingMapSprites.wOffset,b
          lda aMovingMapSprites.wActiveSpriteOffset,b,x
          cmp #$FFFF
          beq _End

            jsl rlUnknown88D7FE

            lda aMovingMapSprites.wXPixelPosition,b,x
            sec
            sbc wMapScrollXPixels,b
            cmp #$FFC0
            bcs +

              cmp #$0140
              bcs _End

            +
            clc
            adc wR0
            sta wR0

            lda aMovingMapSprites.wYPixelPosition,b,x
            sec
            sbc wMapScrollYPixels,b
            cmp #$FFF0
            bcs +

              cmp #$0100
              bcs _End

            +
            clc
            adc wR1
            sta wR1
            lda aMovingMapSprites.wUnknown001804,b,x
            sta wR5
            jsl rlPushToOAMBuffer

        _End
        plb
        rtl

        .databank 0

        ; 81/8A42

    .endsection Unsorted8189F3Section


    .section Unsorted818D58Section

      .al
      .xl

      rlUnknown818D58 ; 81/8D58

        .al
        .autsiz
        .databank ?

        ; Sound stuff

        php
        phx
        phy
        lda aMovingMapSprites.wMovingSound,b,x
        pha
        and #$00FF
        sta aMovingMapSprites.wMovingSound,b,x
        pla
        and #$FF00
        beq _End

          xba
          dec a
          bne +

          jsr rsUnknown818D82
          bra _End

          +
          jsr rsUnknown818D95

        _End
        ply
        plx
        plp
        rtl

        .databank 0

      rlUnknown818D7B ; 81/8D7B

        .al
        .autsiz
        .databank ?

        jsr rsUnknown818D82
        jsr rsUnknown818D95
        rtl

        .databank 0

      rsUnknown818D82 ; 81/8D82

        .al
        .autsiz
        .databank ?

        php
        sep #$20
        lda #$10
        sta $04CA,b
        rep #$20
        ldx #0
        jsl rlUnknown809933
        plp
        rts

        .databank 0

      rsUnknown818D95 ; 81/8D95

        .al
        .autsiz
        .databank ?

        php
        sep #$20
        lda #$10
        sta $04CD,b
        rep #$20
        ldx #3
        jsl rlUnknown809933
        plp
        rts

        .databank 0

      rsUnknown818DA8 ; 81/8DA8

        .al
        .autsiz
        .databank ?

        lda aActiveSpriteSystem.aUnknown001320,b,y
        dec a
        sta aActiveSpriteSystem.aUnknown001320,b,y

        lda aActiveSpriteSystem.aUnknown001380,b,y
        ora aActiveSpriteSystem.aUnknown0013A0,b,y
        beq _End2

          phx
          lda aActiveSpriteSystem.aUnknown001340,b,y
          clc
          adc aActiveSpriteSystem.aUnknown001380,b,y
          sta aActiveSpriteSystem.aUnknown001340,b,y
          rol a
          and #$0001
          sta wR5
          ror a
          clc
          lda aActiveSpriteSystem.aUnknown0013A0,b,y
          adc wR5
          sta wR5

          lda aActiveSpriteSystem.aUnknown001300,b,y
          bit #$0080
          bne _End

            dec a
            sta wR4

            lda wR4
            cmp #10
            bmi +

              -
              bra -

            +
            asl a
            tax
            jsr (aMovingMapSpritePositionRoutines,x)

            lda aActiveSpriteSystem.aUnknown0012E0,b,y
            bit #$0001
            beq _End

              jsr rsUnknown818E40

          _End
          plx

        _End2
        rts

        .databank 0

    .endsection Unsorted818D58Section


    .section Unsorted818EABSection

      .al
      .xl

      rsUnknown818EAB ; 81/8EAB

        .al
        .xl
        .autsiz
        .databank ?

        pha
        lda wR0
        cmp #$0060
        pla
        rts

        .databank 0

        ; 81/8EB3

      rsUnknown818EB3 ; 81/8EB3

        .al
        .xl
        .autsiz
        .databank ?

        pha
        lda #$0080
        cmp wR0
        pla
        rts

        .databank 0

        ; 81/8EBB

      rsUnknown818EBB ; 81/8EBB

        .al
        .xl
        .autsiz
        .databank ?

        pha
        lda wR1
        cmp #$0060
        pla
        rts

        .databank 0

        ; 81/8EC3

      rsUnknown818EC3 ; 81/8EC3

        .al
        .xl
        .autsiz
        .databank ?

        pha
        lda #$0080
        cmp wR1
        pla
        rts

        .databank 0

        ; 81/8ECB

    .endsection Unsorted818EABSection


    .section Unsorted81A800Section

      .al
      .xl

      rlUnknown81A800 ; 81/A800

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown88C7CF
        jsl rlUnknown88A44C
        lda wMapScrollXPixels,b
        sta wBufferBG1HOFS
        lda wMapScrollYPixels,b
        sta wBufferBG1VOFS
        rtl

        .databank 0

        ; 81/A813

      rlUnknown81A813 ; 81/A813

        .al
        .xl
        .autsiz
        .databank ?

        lda wUnknown000D79,b
        and #$4005
        sta wUnknown000D79,b
        lda #(`aMapMenuRAMArea)<<8
        sta lR18+1
        lda #<>aMapMenuRAMArea
        sta lR18
        lda #$0001
        sta wStructIndex,b
        lda #$0E57
        jsl rlBuildRAMAreaHeaderAndGuidingEntry
        jsl rlEnableActiveSpriteEngine
        jsl rlUnknown818064
        lda wUnknown00171A,b
        bne _A84E
        lda #(`procFadeIn)<<8
        sta lR44+1
        lda #<>procFadeIn
        sta lR44
        jsl rlProcEngineCreateProc

        _A84E
        jsl rlCreateUnitWindowAndTerrainWindowProcs
        inc wGameStateRoutine1,b
        lda $0D7B,b
        sta wGameStateStep,b
        rtl

        .databank 0

        ; 81/A85C

    .endsection Unsorted81A800Section


    .section Unsorted81A85CSection

      .al
      .xl

      rlUnknown81A85C ; 81/A85C

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $81
        stz wUnknown000D79,b
        lda #$FFFF
        sta wUnitRelocationDeploymentOffset,b
        sta wDefeatedUnitDeploymentOffset,b
        sta $0D89,b
        sta $0D8B,b
        sta $0D8D,b
        stz $0D87,b
        stz wActiveFactionSlot,b
        stz $0DAF,b
        stz $0DB1,b
        stz wCurrentChapter,b
        stz wCurrentTurn,b
        stz $0D7B,b
        stz wDestroyedLocationsCount,b
        lda #$0008
        sta wOptionSettings,b
        sep #$20
        stz wAreaRestrictionBitfield,b
        rep #$20
        plp
        plb
        .databank $81
        rtl

        .databank 0

        ; 81/A89D

    .endsection Unsorted81A85CSection


    .section Unsorted81A89DSection

      .al
      .xl

      rlUnknown81A89D ; 81/A89D

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb

        jsl rlUnknown81B15A
        jsl rlUnknown81B088
        bcc +

          jsl rlUnknown81AB3F
          bra _End

        +
        lda wUnknown00171A,b
        bne +

          jsl rlUnknown81ADD8
          bcs _End

            jsr rsUnknown81AF38
            bcs _End

              jsr rsUnknown81AFD4
              bcs _End

                jsr rsUnknown81AF16
                bcs _End

                  jsr rsUnknown81B0E5
                  bcs _End

                    jsr rsUnknown81B116

        +
        lda wGameStateStep,b
        cmp #$000D
        bmi +

          -
          bra -

        +
        asl a
        tax
        jsr (aUnknown81A8F8,x)

        lda wGameStateStep,b
        sta $0D7B,b

        lda wUnknown00171A,b
        beq _End

          jsl rlUnknown88A12B
          jsl rlUnknown888560

        _End
        plp
        plb
        rtl

        .databank 0

      aUnknown81A8F8 ; 81/A8F8

        .word <>rsUnknown81A912 ; 0
        .word <>rsUnknown81A93B ; 1
        .word <>rsUnknown81A968 ; 2
        .word <>rsUnknown81A9A6 ; 3
        .word <>rsUnknown81AB6B ; 4
        .word <>rsUnknown81AB90 ; 5
        .word <>rsUnknown81AC4E ; 6
        .word <>rsUnknown81AC9C ; 7

        .word <>rsUnknown81ACD4 ; 8
        .word <>rsUnknown81ACFE ; 9
        .word <>rsUnknown81AD1C ; 10
        .word <>rsUnknown81AD28 ; 11
        .word <>rsUnknown81AD6A ; 12

      rsUnknown81A912 ; 81/A912

        .al
        .autsiz
        .databank ?

        ; Update status and miracle for all units in all factions

        lda wUnknown00171A,b
        bne _End

        lda wCurrentTurn,b
        inc a
        cmp #1000
        bcc +

          lda #999

        +
        sta wCurrentTurn,b

        lda #0
        sta wActiveFactionSlot,b

        ldy #6
        
          -
          tya
          jsl rlDecreaseFactionStatusDurations
          dec y
          bpl -

        inc wGameStateStep,b
        
        _End
        rts

        .databank 0

      rsUnknown81A93B ; 81/A93B

        .al
        .autsiz
        .databank ?

        lda $0DAD,b
        beq _INC
        bpl _DEC

          lda wActiveFactionSlot,b
          jsl rlUnknown84C5D7
          bcc _INC

            jsr rsGetActiveFactionSongID
            bcc _INC

              lda #$00E0
              jsl rlSendSoundCommand
              lda #$0020
              sta $0DAD,b
              bra +

                _DEC
                dec $0DAD,b
                bra + 

        _INC
        inc wGameStateStep,b

        +
        rts

        .databank 0

      rsUnknown81A968 ; 81/A968

        .al
        .autsiz
        .databank ?

        ; does phase transition banner?

        lda wUnknown00171A,b
        bne _End

          lda #$1000
          trb wUnknown000D79,b

          lda wActiveFactionSlot,b
          jsl rlUnknown84C5D7
          bcc +

            lda #1
            sta $0508,b
            lda #1
            sta $0500,b
            jsl rlUnknown81A9D4

            lda #(`procUnknown85ABF6)<<8
            sta $62+1
            lda #<>procUnknown85ABF6
            sta $62
            jsl rlProcEngineCreateProc

            lda #$0040
            trb $0788,b
            bra +

          +
          inc wGameStateStep,b
        
        _End
        rts

        .databank 0

      rsUnknown81A9A6 ; 81/A9A6

        .al
        .autsiz
        .databank ?

        ; sets up turn events

        lda #0
        sta $0508,b
        lda #$0021
        sta bEventActionIdentifier,b

        lda wCurrentTurn,b
        sta wEventEngineArgument1,b

        lda wActiveFactionSlot,b
        sta wEventEngineArgument2,b
        lda #0
        sta wEventEngineArgument3,b
        lda #0
        sta wEventEngineArgument4,b
        jsl rlGetAndRunChapterMapEventConditions
        bcc +

        +
        inc wGameStateStep,b

        rts

        .databank 0

      rlUnknown81A9D4 ; 81/A9D4

        .al
        .autsiz
        .databank ?

        lda wUnknown000D79,b
        bit #$4000
        beq +

          jsr rsGetActiveFactionSongID
          bcc _End

            sta $0DAB,b
            jsl rlUnknown81AB26
            bra _End

        +
        ora #$4000
        sta wUnknown000D79,b

        jsr rsUnknown81AAFB
        jsr rsGetActiveFactionSongID
        sta $0DAB,b
        
        _End
        lda #$FFFF
        sta $0DAD,b
        rtl

        .databank 0

    .endsection Unsorted81A89DSection


    .section Unsorted81AC02Section

      .al
      .xl

      rsUnknown81AC02 ; 81/AC02

        .al
        .autsiz
        .databank ?

        lda wActiveFactionSlot,b
        bne _End

          lda wCurrentTurn,b
          cmp #1
          beq +

            jsl rlUnknown87C02F
            cmp #0
            beq +

              lda $0D75,b
              and #$00FF
              sta $14
              lda $0D76,b
              and #$00FF
              sta $16
              jsl rlUnknown848E5D
              bra _End
          
          +
          lda #1
          sta wRoutineVariable1,b
          lda #0
          jsl rlFindGenerationIDInFactionSlotData

          lda wSelectedUnitDataRAMPointer,b
          beq _End

            jsl rlGetSelectedUnitDeploymentOffset
            ora #0
            bmi _End

              jsl rlUnknown88B4DB
        
        _End
        rts

        .databank 0

      rsUnknown81AC4E ; 81/AC4E

        .al
        .autsiz
        .databank ?

        lda wCurrentTurn,b
        cmp #1
        beq _INC

          lda wActiveFactionSlot,b
          bne _INC

            jsl rlUnknown87BFB0
            ora #0
            beq _INC

              lda #(`procUnknown85CA85)<<8
              sta $62+1
              lda #<>procUnknown85CA85
              sta $62
              jsl rlProcEngineFindProc
              bcs _End

                jsl rlUnknown88A12B
                jsl rlUnknown888560

                lda wUnknown0007D8,b
                bne _End

                  lda #1
                  sta aProcSystem.wInput0,b
                  lda #(`procUnknown85A47F)<<8
                  sta $62+1
                  lda #<>procUnknown85A47F
                  sta $62
                  jsl rlProcEngineCreateProc
                  bra _INC
              
              _End
              rts
        
        _INC
        inc wGameStateStep,b
        rts

        .databank 0

      rsUnknown81AC9C ; 81/AC9C

        .al
        .autsiz
        .databank ?

        ; Routine waits for some kind of input?

        lda wUnknown00171A,b
        bne +

          jsr rsUnknown81AD8E
          lda wUnknown0007D8,b
          bne +
        
        +
        lda $0D87,b
        bit #$0020
        bne +

          lda wUnknown000D79,b
          bit #$0200
          bne +

            jsl rlUnknown88A12B
            jsl rlUnknown888560
        
        +
        lda $0D87,b
        bit #$0020
        bne +

          rts
        
        +
        lda #$0020
        trb $0D87,b
        inc wGameStateStep,b
        rts

        .databank 0

      rsUnknown81ACD4 ; 81/ACD4

        .al
        .autsiz
        .databank ?

        lda wActiveFactionSlot,b
        jsl rlUnsetFactionUnitsMoved

          -
          lda wActiveFactionSlot,b
          inc a
          cmp wLoadedFactionCount,b
          bcs +

            sta wActiveFactionSlot,b
            jsl rlGetFactionSlotNameID
            cmp #$0080
            beq -

        lda #1
        sta wGameStateStep,b
        rts
        
        +
        stz wActiveFactionSlot,b
        inc wGameStateStep,b
        rts

        .databank 0

      rsUnknown81ACFE ; 81/ACFE

        .al
        .autsiz
        .databank ?

        jsl rlUnknown869D0E

        lda #$0040
        tsb $0788,b

        lda #$0020
        sta bEventActionIdentifier,b
        lda wCurrentTurn,b
        sta wEventEngineArgument1,b
        jsl rlGetAndRunChapterMapEventConditions
        stz wGameStateStep,b
        rts

        .databank 0

      rsUnknown81AD1C ; 81/AD1C

        .al
        .autsiz
        .databank ?

        lda #<>rsUnknown80BBD9
        sta wMainLoopPointer
        lda #7
        sta wGameStateStep,b
        rts

        .databank 0

    .endsection Unsorted81AC02Section


    .section Unsorted81AD28Section

      .al
      .xl

      rsUnknown81AD28 ; 81/AD28

        .al
        .autsiz
        .databank ?

        jsl rlCreateUnitWindowAndTerrainWindowProcs

        lda $0D77,b
        cmp #3
        beq ++

          cmp #1
          beq +

            lda #(`procFadeIn)<<8
            sta lR44+1
            lda #<>procFadeIn
            sta lR44
            lda #0
            jsl rlProcEngineCreateProcByIndex
            bra ++

          +
          sep #$20
          lda bBufferINIDISP
          ora #15
          sta bBufferINIDISP
          rep #$20

        +
        jsl rlUnknown81B189
        bcc +

          ldx wActiveUnitDeploymentOffset,b
          jsl rlDeployedUnitUnsetHiddenIfAlive

        +
        lda $0D7B,b
        sta wGameStateStep,b
        rts

        .databank 0

    .endsection Unsorted81AD28Section


    .section Unsorted81AD6ASection

      .al
      .xl

      rsUnknown81AD6A ; 81/AD6A

        .al
        .autsiz
        .databank ?

        lda wUnknown00171A,b
        bne +

          lda #$00E0
          jsl rlSendSoundCommand

          stz wGameStateRoutine1,b

          lda #<>rsUnknown80B1E1
          sta aProcSystem.wInput0,b

          lda #(`procMainLoopChangeFade)<<8
          sta lR44+1
          lda #<>procMainLoopChangeFade
          sta lR44
          jsl rlProcEngineCreateProc

        +
        rts

        .databank 0

    .endsection Unsorted81AD6ASection


    .section Unsorted81AD8ESection

      .al
      .xl

      rsUnknown81AD8E ; 81/AD8E

        .al
        .autsiz
        .databank ?

        lda bUnknown000E7B,b
        bit #$0040
        beq _End

          bit #$0020
          bne _End

            lda wUnknown000D79,b
            bit #$0080
            beq _End

              lda #$0080
              trb wUnknown000D79,b

              ldx wAISelectedAIUnitOffset,b
              lda aAIUnitList[0].UnitRAMPointer,x
              sta wSelectedUnitDataRAMPointer,b

              lda #$0021
              sta bEventActionIdentifier,b
              lda wCurrentTurn,b
              sta wEventEngineArgument1,b
              lda wActiveFactionSlot,b
              sta wEventEngineArgument2,b
              jsl rlGetSelectedUnitAI
              sta wEventEngineArgument3,b
              jsl rlGetSelectedUnitCharacterID
              sta wEventEngineArgument4,b
              jsl rlGetAndRunChapterMapEventConditions

        _End
        rts

        .databank 0

    .endsection Unsorted81AD8ESection


    .section Unsorted81ADD8Section

      .al
      .xl

      rlUnknown81ADD8 ; 81/ADD8

        .al
        .autsiz
        .databank ?

        phb
        phk
        plb

        lda wUnknown00171A,b
        bne _CLC

          lda wUnitRelocationDeploymentOffset,b
          bmi _CLC

            tax
            lda aDeploymentTable._UnitRAMPointer,x
            sta wSelectedUnitDataRAMPointer,b

            lda wUnitRelocationType,b
            bmi _CLC

              asl a
              tax
              jsr (aUnknown81AE02,x)

              lda #$FFFF
              sta wUnitRelocationDeploymentOffset,b
              bra +

        _CLC
        clc
        
        +
        plb
        rtl

        .databank 0

    .endsection Unsorted81ADD8Section


    .section Unsorted81AE02Section

      .al
      .xl

      aUnknown81AE02 ; 81/AE02

        .word <>rsUnknown81AE46
        .word <>rsUnknown81AE68
        .word <>rsUnknown81AE96
        .word <>rsUnknown81AEAA
        .word <>rsUnknown81AF03
        .word <>rsUnknown81AFB7
        .word <>rsUnknown81AFF8
        .word <>rsUnknown81AFFE
        .word <>rsUnknown81B016
        .word <>rsUnknown81B030

      rlUnknown81AE16 ; 81/AE16

        .al
        .autsiz
        .databank ?

        phb
        phk
        plb

        lda wUnknown00171A,b
        bne _CLC

          lda wUnitRelocationDeploymentOffset,b
          bmi _CLC

            lda wUnitRelocationType,b
            cmp #0
            beq +

              cmp #9
              beq _SEC

                cmp #3
                bne _CLC

                  lda wUnknown000D79,b
                  bit #$0040
                  beq _SEC

        _CLC
        clc
        
        -
        plb
        rtl
        
        +
        jsr rsUnknown81AE46
        
        _SEC
        sec
        bra -

        .databank 0

      rsUnknown81AE46 ; 81/AE46

        .al
        .autsiz
        .databank ?

        ldx wUnitRelocationDeploymentOffset,b

        ; packed coords?
        lda wUnitRelocationLocationID,b
        sta wRoutineVariable1,b
        jsl rlUnknown84C996

        stz $0580,b

        jsl rlDeployedUnitUnsetHiddenIfAlive

        lda wUnknown000D79,b
        bit #$0020
        beq +

          jsl rlUnknown8A9342
        
        +
        sec
        rts

        .databank 0

      rsUnknown81AE68 ; 81/AE68

        .al
        .autsiz
        .databank ?

        lda #7
        jsl rlSetSelectedUnitFaction
        jsl rlGetSelectedUnitDeploymentOffset
        cmp #$00FF
        beq _SEC

          jsl rlClearUnitDeploymentData

          lda #$00FF
          jsl rlSetSelectedUnitDeploymentOffset

          lda #$0017
          sta bEventActionIdentifier,b

          jsl rlGetSelectedUnitCharacterID
          sta wEventEngineArgument1,b
          jsl rlGetAndRunChapterMapEventConditions

        _SEC
        sec
        rts

        .databank 0

    .endsection Unsorted81AE02Section


    .section Unsorted81AE96Section

      .al
      .xl

      rsUnknown81AE96 ; 81/AE96

        .al
        .autsiz
        .databank ?

        lda $0580,b
        pha

        ldx wUnitRelocationDeploymentOffset,b
        lda wUnitRelocationLocationID,b
        jsl rlSetUnitResidingInCastle

        pla
        sta $0580,b

        sec
        rts

        .databank 0

    .endsection Unsorted81AE96Section


    .section Unsorted81AEAASection

      .al
      .xl

      rsUnknown81AEAA ; 81/AEAA

        .al
        .autsiz
        .databank ?

        ; entering castle?

        ldx wUnitRelocationDeploymentOffset,b
        lda wUnitRelocationLocationID,b
        jsl rlSetUnitResidingInCastle

        stz $0580,b

        jsl rlUnknown85CA4B

        lda wUnknown000D79,b
        bit #$0040
        beq +

          and #~($40)
          sta wUnknown000D79,b

          stz wGameStateRoutine1,b

          lda #0
          jsl rlUnknown88B2A5._B30B+2
          bra _End
        
        +
        lda wUnknown000D79,b
        bit #$0020
        beq +

          jsl rlUnknown8A9342
          bra _End
        
        +
        lda #4
        sta bEventActionIdentifier,b
        jsl rlGetSelectedUnitCharacterID
        sta wEventEngineArgument1,b

        jsl rlGetSelectedUnitHomeCastle
        sta wEventEngineArgument2,b

        jsl rlGetAndRunChapterMapEventConditions
        bcs _End

          jsl rlUnknown8CEDD0

        _End
        sec
        rts

        .databank 0

      rsUnknown81AF03 ; 81/AF03

        .al
        .autsiz
        .databank ?

        lda wUnitRelocationLocationID,b
        sta wSelectedUnitDataRAMPointer,b
        jsl rlUnknown84AF17
        lda #$001A
        jsl rlPlaySoundEffect2
        sec
        rts

        .databank 0

      rsUnknown81AF16 ; 81/AF16

        .al
        .autsiz
        .databank ?

        lda $70
        and #$00FF
        beq _CLC

          lda $0D89,b
          bmi _CLC

            tax
            lda aDeploymentTable._UnitRAMPointer,x
            sta aProcSystem.wInput0,b

            jsl rlUnknown85B14F

            lda #$FFFF
            sta $0D89,b
            sec
            rts
        
        _CLC
        clc
        rts

        .databank 0

      rsUnknown81AF38 ; 81/AF38

        .al
        .autsiz
        .databank ?

        lda $0D87,b
        bpl _CLC

          lda wUnknown00171A,b
          bne _CLC

            lda wUnknown0007D8,b
            cmp #4
            beq _CLC

              ldx wActiveUnitDeploymentOffset,b
              jsl rsUnknown88AF4C

              ldx wActiveUnitDeploymentOffset,b
              lda aDeploymentTable._UnitRAMPointer,x
              sta wSelectedUnitDataRAMPointer,b

              jsl rlGetSelectedUnitStates
              bit #UnitStateFielded
              bne +

                lda #UnitStateFielded
                jsl rlSetSelectedUnitStates
              
              +
              lda #$0008
              tsb $0788,b

              lda $0D87,b
              and #$0003
              sta $00

              phb
              jsl _AF81
              plb
              bra +
              
                _AF81
                lda $00
                asl a
                adc $00
                tax
                lda aUnknown81AFAE,x
                sta $33
                sep #$20
                lda aUnknown81AFAE+2,x
                sta $33+2
                pha
                plb
                rep #$20
                jml [$0033]

              +
              lda #$8000
              trb $0D87,b

              lda wGameStateStep,b
              cmp #11
              beq _CLC

                sec
                rts

        _CLC
        clc
        rts

        .databank 0

      aUnknown81AFAE ; 81/AFAE

        .long rlUnknown85E85D
        .long rlUnknown85E8A8
        .long rlUnknown85E8C9

    .endsection Unsorted81AEAASection


    .section Unsorted81AFB7Section

      .al
      .xl

      rsUnknown81AFB7 ; 81/AFB7

        .al
        .autsiz
        .databank ?

        lda wUnknown000D79,b
        bit #$0400
        bne +

          ldx wUnitRelocationDeploymentOffset,b
          lda #1
          sta aProcSystem.wInput2,b
          lda wUnitRelocationLocationID,b
          sta aProcSystem.wInput3,b
          jsl rlUnknown85BB2E

        +
        sec
        rts

        .databank 0

      rsUnknown81AFD4 ; 81/AFD4

        .al
        .autsiz
        .databank ?

        lda $0D8D,b
        bmi _CLC

          jsl rlUnknown888410

          lda $0D8D,b
          sta aProcSystem.wInput2,b
          lda #$0D00
          sta aProcSystem.wInput3,b
          jsl rlUnknown85B8D6

          lda #$FFFF
          sta $0D8D,b
          sec
          bra +

        _CLC
        clc
        
        +
        rts

        .databank 0

        ; 81/AFF8

    .endsection Unsorted81AFB7Section


    .section Unsorted81AFF8Section

      .al
      .xl

      rsUnknown81AFF8 ; 81/AFF8

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown85A5C5
        sec
        rts

        .databank 0

        ; 81/AFFE

    .endsection Unsorted81AFF8Section


    .section Unsorted81AFFESection

      .al
      .xl

      rsUnknown81AFFE ; 81/AFFE

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ldx wUnitRelocationLocationID,b
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlUndeployUnit
        jsl rlDeleteUnit
        jsl rlUnknown9EAC5A
        sec
        rts

        .databank 0

        ; 81/B016

    .endsection Unsorted81AFFESection


    .section Unsorted81B016Section

      .al
      .xl

      rsUnknown81B016 ; 81/B016

        .al
        .xl
        .autsiz
        .databank ?

        lda wUnitRelocationLocationID,b
        jsl rlGetItemRAMStructEntryByPlayerItemIndex
        jsl rlGetEffectiveItemIDByItemRAMStructEntry
        sta aProcSystem.wInput2,b
        lda #$0D00
        sta aProcSystem.wInput3,b
        jsl rlUnknown85BC00
        sec
        rts

        .databank 0

        ; 81/B030

      rsUnknown81B030 ; 81/B030

        .al
        .xl
        .autsiz
        .databank ?

        ldx wUnitRelocationDeploymentOffset,b
        lda wUnitRelocationLocationID,b
        jsl rlSetUnitResidingInCastle
        lda aActionStructUnit2
        tax
        lda wUnitRelocationLocationID,b
        jsl rlSetUnitResidingInCastle
        stz $0580,b
        jsl rlUnknown85CA4B
        lda #$0040
        trb wUnknown000D79,b
        phx
        stz wGameStateRoutine1,b
        lda #$0000
        jsl rlUnknown88B2A5._B30B+2
        plx
        bra _B086

        .byte $BF, $EB, $46, $7E, $8D, $6F, $05, $A9, $04, $00, $8D, $BC, $0E, $22, $33, $A3
        .byte $84, $8D, $BD, $0E, $22, $DA, $96, $84, $8D, $BF, $0E, $22, $BC, $82, $86, $B0
        .byte $04, $22, $D0, $ED, $8C


        _B086
        sec
        rts

        .databank 0

        ; 81/B088

    .endsection Unsorted81B016Section


    .section Unsorted81B088Section

      .al
      .xl

      rlUnknown81B088 ; 81/B088

        .al
        .autsiz
        .databank ?

        lda wUnknown00171A,b
        bne _CLC

          lda wDefeatedUnitDeploymentOffset,b
          bmi _CLC

            tax
            lda aDeploymentTable._UnitRAMPointer,x
            sta wSelectedUnitDataRAMPointer,b

            lda aDeploymentTable._FactionSlot,x
            bne +

              jsl rlGetSelectedUnitGenerationID
              cmp #1
              bne +

                lda #0
                jsl rlUnknown81B32C

            +
            lda aActionStructUnit1.TriggerableSkills
            ora aActionStructUnit2.TriggerableSkills
            bit #$0001
            bne +

              txa
              jsl rlDeployedUnitSetHiddenUnsetAlive

            +
            lda #$0017
            sta bEventActionIdentifier,b
            jsl rlGetSelectedUnitCharacterID
            sta wEventEngineArgument1,b

            jsl rlGetSelectedUnitFactionSlot
            sta wEventEngineArgument2,b

            jsl rlGetAndRunChapterMapEventConditions

            lda #$FFFF
            sta wDefeatedUnitDeploymentOffset,b
            sec
            bra +
        
        _CLC
        clc
        
        +
        rtl

        .databank 0

      rsUnknown81B0E5 ; 81/B0E5

        .al
        .autsiz
        .databank ?

        lda wUnknown000D79,b
        bit #$2000
        beq _CLC

          jsl rlUnknown88B6FD

          ldx wActiveUnitDeploymentOffset,b
          lda aDeploymentTable._UnitRAMPointer,x
          sta wSelectedUnitDataRAMPointer,b

          jsl rlGetSelectedUnitStates
          bit #UnitStateFielded
          bne +

            lda #UnitStateFielded
            jsl rlSetSelectedUnitStates
          
          +
          lda #$2000
          trb wUnknown000D79,b
          sec
          bra +
        
        _CLC
        clc
        
        +
        rts

        .databank 0

      rsUnknown81B116 ; 81/B116

        .al
        .autsiz
        .databank ?

        ; Prepares after action location based events

        lda $0D8B,b
        bmi _CLC

          tax
          lda aDeploymentTable._UnitRAMPointer,x
          sta wSelectedUnitDataRAMPointer,b

          lda #3
          sta bEventActionIdentifier,b
          jsl rlGetSelectedUnitCharacterID
          sta wEventEngineArgument1,b

          lda aDeploymentTable._XTilePosition,x
          sta wEventEngineArgument2,b
          lda aDeploymentTable._YTilePosition,x
          sta wEventEngineArgument3,b
          lda aDeploymentTable._FactionSlot,x
          sta wEventEngineArgument4,b
          jsl rlGetAndRunChapterMapEventConditions

          lda #$FFFF
          sta $0D8B,b

          lda #$8000
          trb wUnknown000D79,b
          sec
          bra +

        _CLC
        clc
        
        +
        rts

        .databank 0

      rlUnknown81B15A ; 81/B15A

        .al
        .autsiz
        .databank ?

        ; Updates the Deployment state with buffered values

        lda wUnknown00171A,b
        bne _CLC

          lda wGameStateStep,b
          cmp #11
          beq _CLC

            lda wUnknown000D79,b
            bit #$0004
            beq _CLC

              ldx #(72-1) * size(word)

                -
                lda aDeploymentTable._StateBuffer,x
                sta aDeploymentTable._State,x
                dec x
                dec x
                bpl -

              lda #4
              trb wUnknown000D79,b
              sec
              bra +

        _CLC
        clc
        
        +
        rtl

        .databank 0

      rlUnknown81B189 ; 81/B189

        .al
        .autsiz
        .databank ?

        phx
        lda bUnknown000E7B,b
        bit #$0040
        bne _CLC

        ldx wActiveUnitDeploymentOffset,b
        lda wUnknown000D79,b
        bit #$0004
        beq +

          lda aDeploymentTable._StateBuffer,x
          and #~DeploymentStateGrayed
          sta aDeploymentTable._State,x

        +
        lda aDeploymentTable._State,x
        bit #DeploymentStateAlive
        beq _CLC

        bit #DeploymentStateDefeated
        bne _CLC

        bit #DeploymentStateCanto
        beq _CLC

        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        lda aDeploymentTable._XTilePosition,x
        sta wR10
        lda aDeploymentTable._YTilePosition,x
        sta wR11
        jsl rlUnknown87B541
        bcc +

          jsl rlUnknown84D4A2
          bcc _SEC

        +
        lda #$2000
        tsb wUnknown000D79,b
        lda #$8000
        tsb wUnknown000D79,b
        
        _SEC
        plx
        sec
        bra +
        
        _CLC
        plx
        clc
        
        +
        rtl

        .databank 0

      rlUnknown81B1ED ; 81/B1ED

        .al
        .autsiz
        .databank ?

        lda wUnitRelocationDeploymentOffset,b
        bmi _End

          lda wUnitRelocationType,b
          cmp #5
          bne _End

            lda wUnknown000D79,b
            bit #$0400
            bne _End

              lda #1
              sta aProcSystem.wInput2,b
              lda wUnitRelocationLocationID,b
              sta aProcSystem.wInput3,b

              lda #(`procUnknown85BA41)<<8
              sta lR44+1
              lda #<>procUnknown85BA41
              sta lR44
              jsl rlEventEngineCreateProc
              lda #$FFFF
              sta wUnitRelocationDeploymentOffset,b

        _End
        rtl

        .databank 0

    .endsection Unsorted81B088Section


    .section Unsorted81B301Section

      .al
      .xl

      rlUnknown81B301 ; 81/B301

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $81
        lda #$00E0
        jsl rlSendSoundCommand
        inc wCurrentChapter,b
        stz wUnknown000D79,b
        stz wGameStateRoutine1,b
        lda #$F27C
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        plp
        plb
        .databank $81
        rtl

        .databank 0

        ; 81/B32C

    .endsection Unsorted81B301Section


    .section Unsorted81B32CSection

      .al
      .xl

      rlUnknown81B32C ; 81/B32C

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx

        asl a
        tax

        lda wCurrentChapter,b
        cmp #6
        bcc +

          txa
          clc
          adc #4
          tax

        +
        lda aUnknown81B353,x
        jsl rlUnknown80C1CB
        lda #12
        sta wGameStateStep,b

        plx
        plp
        plb
        rtl

        .databank 0

      aUnknown81B353 ; 81/B353

        ; some event IDs

        .word $022E
        .word $022F
        .word $0230
        .word $0231

      rlUnknown81B35B ; 81/B35B

        .al
        .autsiz
        .databank ?

        jsl rlUnknown869CF9
        jsl rlUnknown88AF7B
        jsl rlUnknown9E800C
        rtl

        .databank 0

      rlUnknown81B368 ; 81/B368

        .al
        .autsiz
        .databank ?

        lda #$00E0
        jsl rlSendSoundCommand

        stz $07E0,b
        stz wGameStateRoutine1,b

        lda wBattleType
        and #$00FF
        cmp #0
        beq +

        lda #<>rsUnknown80BFFB
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        bra ++

        +
        lda #(`aHDMAUnknown87C38C)<<8
        sta lR44+1
        lda #<>aHDMAUnknown87C38C
        sta lR44
        jsl rlHDMAEngineCreateEntry
        
        +
        rtl

        .databank 0

        ; 81/B3A6

    .endsection Unsorted81B32CSection


    .section Unsorted81B3A6Section

      .al
      .xl

      rlUnknown81B3A6 ; 81/B3A6

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $81
        phx
        lda wUnknown000D79,b
        bit #$0002
        beq _B429
        lda #$0002
        trb wUnknown000D79,b
        lda #$0001
        tsb wUnknown000D79,b
        lda #$8100
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$B42D
        sta lMapMenuTilemapRAMEntryPointer,b
        lda aEpilogueUnitStates
        sta wR0
        lda $7FC54C
        asl a
        asl a
        asl a
        asl a
        asl a
        clc
        adc wR0
        asl a
        tax
        jsl rlUnknown878AB5
        lda #$8100
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$B436
        sta lMapMenuTilemapRAMEntryPointer,b
        lda $7FC5AE
        sta wR0
        lda $7FC5B0
        asl a
        asl a
        asl a
        asl a
        asl a
        clc
        adc wR0
        asl a
        tax
        jsl rlUnknown878AB5
        lda $7FC5B0
        cmp #$0021
        bcs _B418
        cmp wUnknown00052A,b
        bcs _B418
        sta wUnknown00052A,b

        _B418
        clc
        adc #$0008
        cmp #$0021
        bcs _B429
        cmp wUnknown00052C,b
        bcc _B429
        sta wUnknown00052C,b

        _B429
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 81/B42D

    .endsection Unsorted81B3A6Section


    .section Unsorted81B4C5Section

      .al
      .xl

      rlUnknown81B4C5 ; 81/B4C5

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $81
        phy
        lda lChapterEventDataPointer+1,b
        sta lR18+1
        ldy lChapterEventDataPointer,b
        sep #$20
        lda lChapterEventDataPointer+2,b
        pha
        rep #$20
        plb
        .databank ?
        lda structChapterEventData.Unknown1,b,y
        sta lR18
        ply
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 81/B4E4

    .endsection Unsorted81B4C5Section


    .section Unsorted81B503Section

      .al
      .xl

      rlUnknown81B503 ; 81/B503

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $81
        phy
        lda lChapterEventDataPointer+1,b
        sta lR18+1
        ldy lChapterEventDataPointer,b
        sep #$20
        lda lChapterEventDataPointer+2,b
        pha
        rep #$20
        plb
        .databank ?
        lda structChapterEventData.Unknown3,b,y
        sta lR18
        ply
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 81/B522

    .endsection Unsorted81B503Section


    .section Unsorted81B52ASection

      .al
      .xl

      rlUnknown81B52A ; 81/B52A

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        sep #$20

        _B52C
        lda $4212,b
        bit #$40
        beq _B52C
        lda #$80
        sta $2100,b
        rep #$20
        jsl rlUnknown8887EC
        sep #$20
        lda bBufferINIDISP
        and #$80
        sta $2100,b
        rep #$20
        rtl

        .databank 0

        ; 81/B54A

    .endsection Unsorted81B52ASection
