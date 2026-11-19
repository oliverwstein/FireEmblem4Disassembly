; Code from bank $87 not yet assigned to a game system.

    .section Unsorted8780DFSection

      .al
      .xl

      rlUnknown8780DF ; 87/80DF

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        lda #$0080
        tsb bUnknown000521,b
        plp
        plb
        rtl

        .databank 0

      rlUnknown8780EC ; 87/80EC

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        lda #$0080
        trb bUnknown000521,b
        plp
        plb
        rtl

        .databank 0

        ; 87/80F9

    .endsection Unsorted8780DFSection


    .section Unsorted87829ASection

      .al
      .xl

      rlUnknown87829A ; 87/829A

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb

        ; Get the height into wR13
        jsl rlGetMapMenuTilemapArea
        xba
        and #$00FF
        sta wR13

        jsl rlGetMapMenuPosition
        xba
        and #$00FF
        cmp #33
        bge +

          cmp wUnknown00052A,b
          bge +

            sta wUnknown00052A,b

        +
        sta wR12
        clc
        adc wR13
        cmp #33
        bge +

          cmp wUnknown00052C,b
          blt +

            sta wUnknown00052C,b

        +
        sta wR13
        plp
        plb
        rtl

        .databank 0

        ; 87/82D4

    .endsection Unsorted87829ASection


    .section Unsorted878459Section

      .al
      .xl

      rlUnknown878459 ; 87/8459

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        lda #0
        sta wUnknown00052A,b
        lda #$001F
        sta wUnknown00052C,b
        lda #$0002
        tsb bUnknown000521,b
        plp
        plb
        rtl

        .databank 0

        ; 87/8472

    .endsection Unsorted878459Section


    .section Unsorted878921Section

      .al
      .xl

      rlUnknown878921 ; 87/8921

        .al
        .autsiz
        .databank ?

        jsl rlGetMapMenuTilemapRAMEntryPointer
        jsl rlDrawMenuTextLine
        rtl

        .databank 0

    .endsection Unsorted878921Section


    .section Unsorted878C8CSection

      .al
      .xl

      rlUnknown878C8C ; 87/8C8C

        .al
        .autsiz
        .databank ?

        php
        phb
        phx
        phy

        sep #$20
        lda lR18+2
        pha
        rep #$20
        plb

        lda lR18
        clc
        adc #$000E
        tay

        ldx #$000E

          -
          lda $0000,b,y
          clc
          adc aCurrentTilemapInfo.wBaseTile,b
          sta wR1,x
          dec y
          dec y
          dec x
          dec x
          bpl -

        phk
        plb

        ldy lMapMenuTilemapRAMEntryPointer,b
        sep #$20
        lda lMapMenuTilemapRAMEntryPointer+2,b
        pha
        rep #$20
        plb

        lda $0006,b,y
        sta lR18
        lda $0006+1,b,y
        sta lR18+1
        lda $0000,b,y
        and #$00FF
        sta wR9
        lda $0001,b,y
        and #$00FF
        sta wR10

        sep #$20
        lda lR18+2
        pha
        rep #$20
        plb

        sep #$20
        lda wR9
        sta WRMPYA
        lda wR10
        dec a
        sta WRMPYB
        nop
        nop
        nop
        rep #$20

        lda RDMPY
        asl a
        clc
        adc lR18
        tay

        ldx lR18
        lda wR1
        sta $0000,b,x
        inc x
        inc x
        lda wR6
        sta $0000,b,y
        inc y
        inc y
        lda wR9
        dec a
        dec a
        sta wR0

          -
          lda wR2
          sta $0000,b,x
          lda wR7
          sta $0000,b,y
          inc x
          inc x
          inc y
          inc y
          dec wR0
          bne -

        lda wR3
        sta $0000,b,x
        lda wR8
        sta $0000,b,y
        asl wR9

        lda wR9
        clc
        adc lR18
        tax

        clc
        adc wR9
        dec a
        dec a
        tay

        lda wR10
        dec a
        dec a
        sta wR0

          -
          lda wR4
          sta $0000,b,x
          lda wR5
          sta $0000,b,y

          txa
          clc
          adc wR9
          tax

          tya
          clc
          adc wR9
          tay
          dec wR0
          bne -

        ply
        plx
        plb
        plp
        rtl

        .databank 0

        ; 87/8D61

    .endsection Unsorted878C8CSection


    .section Unsorted87B01DSection

      .al
      .xl

      rlUnknown87B01D ; 87/B01D

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = EntryIndex
        ; wRoutineVariable1 = CharacterID

        phb
        php
        phk
        plb
        phx

        sta aEventMovement.wEntryIndex

        lda aEventMovement.wUnitXCoordinate
        bpl +

          lda wRoutineVariable1,b
          jsl rlGetUnitRAMDataPointerByID
          bcs _SEC

            jsl rlGetSelectedUnitDeploymentOffset
            tax
            lda aDeploymentTable._XTilePosition,x
            sta aEventMovement.wUnitXCoordinate
            lda aDeploymentTable._YTilePosition,x
            sta aEventMovement.wUnitYCoordinate

        +
        lda wRoutineVariable1,b
        jsl rlGetCharacterClass
        jsl rlGetClassDataROMPointer
        jsl rlGetClassMovementType
        asl a
        clc
        adc aMainDataOffsets.MovementCostOffsets
        tax
        lda aMainDataOffsets,x
        clc
        adc aMainDataOffsets.MovementCostOffsets
        adc #<>aMainDataOffsets
        sta aEventMovement.wMovementCostPointer
        jsl rlUnknown87B080
        bcs _SEC

          plx
          plp
          plb
          clc
          rtl

        _SEC
        plx
        plp
        plb
        sec
        rtl

        .databank 0

      rlUnknown87B080 ; 87/B080

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        phy
        jsl rlFillEventMovementMoveCostMap

        lda aEventMovement.wUnknown7EC494
        bne _B0F7

          lda #`aEventMovement.aTargetMap
          ldx #<>aEventMovement.aTargetMap
          jsl rlClearMapBufferAddBorders

          lda aEventMovement.wDestinationXCoordinate
          sta aEventMovement.wTargetXCoordinate
          lda aEventMovement.wDestinationYCoordinate
          sta aEventMovement.wTargetYCoordinate
          lda #0
          jsl rlSetEventMovementTargetTile

          ldx #len(aDeploymentTable._State)-2

            _Loop
            lda aDeploymentTable._State,x
            bit #DeploymentStateAlive
            beq _Next

              lda aDeploymentTable._XTilePosition,x
              sta aEventMovement.wTargetXCoordinate
              lda aDeploymentTable._YTilePosition,x
              sta aEventMovement.wTargetYCoordinate
              lda #$00FF
              jsl rlSetEventMovementTargetTile

            _Next
            dec x
            dec x
            bpl _Loop

          lda aEventMovement.wDestinationXCoordinate
          sta aEventMovement.wStartingXCoordinate
          lda aEventMovement.wDestinationYCoordinate
          sta aEventMovement.wStartingYCoordinate
          lda #0
          sta aEventMovement.wTargetXCoordinate
          jsl rlEventMovementBuildTargetDistanceMap
          bcc _SEC
          bra +

        _B0F7
        lda aEventMovement.wDestinationXCoordinate
        sta aEventMovement.wTargetXCoordinate
        lda aEventMovement.wDestinationYCoordinate
        sta aEventMovement.wTargetYCoordinate

        +
        lda aEventMovement.wEntryIndex
        asl a
        tax
        lda aEventMovement.wTargetXCoordinate
        sta aEventMovement.wStartingXCoordinate
        sta aEventMovement.aScriptEndXCoordinate,x
        lda aEventMovement.wTargetYCoordinate
        sta aEventMovement.wStartingYCoordinate
        sta aEventMovement.aScriptEndYCoordinate,x

        jsl rlClearEventMovementTargetMap

        lda aEventMovement.wUnitXCoordinate
        sta aEventMovement.wTargetXCoordinate
        sta aEventMovement.aScriptStartXCoordinate,x
        lda aEventMovement.wUnitYCoordinate
        sta aEventMovement.wTargetYCoordinate
        sta aEventMovement.aScriptStartYCoordinate,x
        lda #0
        jsl rlSetEventMovementTargetTile

        lda #1
        sta aEventMovement.wTargetXCoordinate
        jsl rlEventMovementBuildTargetDistanceMap
        bcc _SEC

        lda aEventMovement.wEntryIndex
        jsl rlEventMovementCreateMovementScriptFromTargetDistanceMap

        ply
        plx
        plp
        plb
        clc
        rtl

        _SEC
        ply
        plx
        plp
        plb
        sec
        rtl

        .databank 0

    .endsection Unsorted87B01DSection


    .section Unsorted87B541Section

      .al
      .xl

      rlUnknown87B541 ; 87/B541

        .al
        .autsiz
        .databank ?

        phx
        phy
        jsl rlGetSelectedUnitFactionSlot
        sta $7F442A

        jsl rlGetSelectedUnitStates
        bit #UnitStateCanto
        beq +

          lda #0
          tay
          bra ++

          +
          jsl $84F521

        +
        sta $1A
        sty $08
        cmp #4
        bcc +

          jsl $87BA0B
          sec
          bra _End

        +
        jsl rlGetSelectedUnitMovementCostPointer
        sta $7F442C

        jsl rlGetSelectedUnitTotalFieldMovement
        sta $18

        jsl rlUnknown87B59D

        lda wActiveFactionSlot,b
        bne +

          lda $7F442A
          beq +

            lda $08
            bit #$0004
            beq +

              jsl $87BA82

        +
        jsl $87BB27

        _End
        ply
        plx
        rtl

        .databank 0

      rlUnknown87B59D ; 87/B59D

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb

        sep #$20
        lda #$7F
        pha
        rep #$20
        plb
        .databank $7F

        jsr rsUnknown87B786
        jsr rsUnknown87B7A2
        jsr rsUnknown87B7B0
        jsr rsUnknown87B7BE
        jsr rsUnknown87B833
        stz $22
        jsr rsUnknown87B5DD

        lda $1A
        beq _End

        sep #$20
        ldx #$0100

          -
          cpx $06
          beq +

          ldy $894C,b,x
          jsr $87B91C

          inc x
          inc x
          inc x
          inc x
          cpx $06
          bra -

        +
        rep #$20
        
        _End
        plp
        plb
        rtl

        .databank 0

    .endsection Unsorted87B541Section


    .section Unsorted87B786Section

      .al
      .xl

      rsUnknown87B786 ; 87/B786

        .al
        .autsiz
        .databank ?

        ; $14 = X pos
        ; $16 = Y pos

        lda $14
        sec
        sbc #$0020
        sta $1C

        lda $16
        sec
        sbc #$0020
        sta $1E
        asl a
        asl a
        asl a
        asl a
        asl a
        asl a
        clc
        adc $1C
        sta $20
        rts

        .databank 0

      rsUnknown87B7A2 ; 87/B7A2

        .al
        .autsiz
        .databank ?

        lda #`aMovementMap
        ldx #<>aMovementMap
        ldy #0
        jsl rlFillMapBuffer
        rts

        .databank 0

      rsUnknown87B7B0 ; 87/B7B0

        .al
        .autsiz
        .databank ?

        lda #`aRangeMap
        ldx #<>aRangeMap
        ldy #0
        jsl rlFillMapBuffer
        rts

        .databank 0

      rsUnknown87B7BE ; 87/B7BE

        .al
        .autsiz
        .databank $7F

        ; fills map buffer with enemy and ally values?

        ldx #(72 - 1) * size(word)
        
        -
        lda aDeploymentTable._State,x
        bit #DeploymentStateAlive
        beq _Next

          bit #DeploymentStateHidden
          bne _Next

            bit #DeploymentStateDefeated
            bne _Next

              lda aDeploymentTable._XTilePosition,x
              sec
              sbc $1C
              sta aAIAction.wTargetXPosition
              cmp #$0040
              bcs _Next

                lda aDeploymentTable._YTilePosition,x
                sec
                sbc $1E
                sta aAIAction.wTargetYPosition
                cmp #$0040
                bcs _Next

                  jsr rsUnknown87B811

                  pha
                  lda aAIAction.wTargetYPosition
                  asl a
                  asl a
                  asl a
                  asl a
                  asl a
                  asl a
                  clc
                  adc aAIAction.wTargetXPosition
                  tay
                  pla
                  sep #$20
                  sta aRangeMap,y
                  rep #$20

        _Next
        dec x
        dec x
        bpl -

        rts

        .databank 0

      rsUnknown87B811 ; 87/B811

        .al
        .autsiz
        .databank ?

        phx
        lda aDeploymentTable._FactionSlot,x
        tax

        lda $442A,b
        bmi ++

          jsl rlGetFactionRelation
          plx
          cmp #AllegianceOther
          beq +

            cmp #AllegianceEnemy
            bne ++

          ; other, enemy
          +
          lda #$00FF
          rts

        ; player, npc 
        +
        lda #1
        rts

        .databank 0

      rsUnknown87B833 ; 87/B833

        .al
        .autsiz
        .databank ?

        ; write map boundaries?

        lda wR14
        bmi +

          lda #$003F
          sec
          sbc wR14
          jsr rsUnknown87B877

          lda wR14
          bne ++

        +
        eor #$FFFF
        inc a
        jsr rsUnknown87B877
        
        +
        lda wCurrentChapter
        beq +

          lda wR15
          bmi _B86D

            lda #$003F
            bne ++

        +
        lda #$001F

        +
        sec
        sbc wR15
        jsr rsUnknown87B88F

        lda wCurrentChapter
        beq _B86D

          lda wR15
          bne +

            _B86D
            lda wR15
            eor #$FFFF
            inc a
            jsr rsUnknown87B88F
        
        +
        rts

        .databank 0

    .endsection Unsorted87B786Section


    .section Unsorted87C056Section

      .al
      .xl

      procUnknown87C056 ; 87/C056

        .structProcInfo "TF", rlProcUnknown87C056Init, rlProcUnknown87C056Cycle, aProcUnknown87C056Code

      rlProcUnknown87C056Init ; 87/C05E

        .al
        .autsiz
        .databank ?

        ; wInput0 = LocationID
        ; wInput1 = old owner
        ; wInput2 = new owner

        lda aProcSystem.wInput0,b
        sta aProcSystem.aBody0,b,x
        lda aProcSystem.wInput1,b
        sta aProcSystem.aBody1,b,x
        lda aProcSystem.wInput2,b
        sta aProcSystem.aBody2,b,x
        lda #0
        sta aProcSystem.aBody3,b,x
        sta aProcSystem.aBody4,b,x
        jsl rlUnknown87C11D
        bcs +

          lda #<>aProcUnknown87C056Code._C23A
          sta aProcSystem.aHeaderCodeOffset,b,x
          lda #1
          sta aProcSystem.aHeaderSleepTimer,b,x
          bra ++

        +
        lda aProcSystem.aBody1,b,x
        jsl rlUnknown87C141
        cmp #0
        bne +

          lda #<>aProcUnknown87C056Code._C235
          sta aProcSystem.aHeaderCodeOffset,b,x
          lda #1
          sta aProcSystem.aHeaderSleepTimer,b,x

        +
        stz $0302,b
        rtl

        .databank 0

      rlProcUnknown87C056Cycle ; 87/C0A9

        .al
        .autsiz
        .databank ?

        rtl

        .databank 0

    .endsection Unsorted87C056Section


    .section Unsorted87EBC8Section

      .al
      .xl

      rlUnknown87EBC8 ; 87/EBC8

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        phy

        ldy wEventLocationEntry,b
        sep #$20
        lda lChapterEventDataPointer+2,b
        pha
        rep #$20
        plb

        lda structChapterLocationEntry.ID,b,y
        and #$00FF
        sta wR3
        asl a
        tax

        lda structChapterLocationEntry.Type,b,y
        and #$00FF
        jsl rlGetEventLocationTypeBaseMoney
        sta aChapterLocationMoneyRewards,x

        lda structChapterLocationEntry.Type,b,y
        and #$00FF
        cmp #LocationTypeCastle
        bne _End

          lda lChapterEventDataPointer+1,b
          sta lR18+1
          lda structChapterCastleLocationEntry.ShopDataPointer,b,y
          beq _End

            sta lR18

            ldx lR18
            sep #$20
            lda lR18+2
            pha
            rep #$20
            plb

            _Loop
            lda $0000,b,x
            cmp #$FFFF
            beq _End

              and #$00FF
              jsl rlGetItemRAMStructEntryByPlayerItemIndex
              jsl rlGetItemRAMStateAndOwner

              lda wR0
              cmp #ItemStateUnobtained
              bne _Next

                lda #ItemStateShop
                sta wR0
                lda wR3
                sta wR1
                jsl rlSetItemRAMStateAndOwner

              _Next
              inc x
              bra _Loop

        _End
        ply
        plx
        plp
        plb
        rtl

        .databank 0

        ; 87/EC42

    .endsection Unsorted87EBC8Section


    .section Unsorted87F515Section

      .al
      .xl

      rlUnknown87F515 ; 87/F515

        .al
        .autsiz
        .databank ?

        phb
        phx
        phy
        tay

        lda #(`aUnitRAMArea)<<8
        sta lR18+1
        lda #<>aUnitRAMArea
        sta lR18
        jsl rlBufferAndLoadNewRAMAreaPointer

        lda #size(structCharacterDataRAM)
        jsl rlAllocateRAMArea

        lda lR25
        sta wSelectedUnitDataRAMPointer,b

        lda #(`aUnitRAMPointers)<<8
        sta lStructPointer2+1,b
        lda #<>aUnitRAMPointers
        sta lStructPointer2,b

        lda lR25
        sta lStructPointer1,b

        jsl rlAppendNewStructEntry

        tya
        jsr $87F55A
        jsr $87FABC
        jsr $87FB94
        jsl rlLoadBufferedRAMAreaPointer

        ply
        plx
        plb
        rtl

        .databank 0

        ; 87/F559

    .endsection Unsorted87F515Section
