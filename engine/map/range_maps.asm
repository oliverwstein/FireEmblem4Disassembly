; The range maps: where the selected unit can move (aMovementMap, a flood fill of
; its movement) and what it can reach (aRangeMap), and the targets of a weapon.


    .section Unsorted87B512Section

      .al
      .xl

      rlFindTargetsForSelectedWeapon ; 87/B512

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; X = deployment offset: the targets in range of the item in wSelectedInventorySlot (rlUnknown84FED2): enemies, or with UnitState0400 set, enemies at a castle (target filter 4).

        phb
        php
        phk
        plb
        .databank $87
        lda wSelectedInventorySlot,b
        jsl rlGetItemROMDataByInventorySlot
        lda #$0001
        sta wR12
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitStates
        bit #UnitState0400
        beq _B537
        lda #$0004
        bra _B53A


        _B537
        lda #$0000

        _B53A
        jsl rlUnknown84FED2
        plp
        plb
        .databank $87
        rtl

        .databank 0

        ; 87/B541

    .endsection Unsorted87B512Section


    .section Unsorted87B541Section

      .al
      .xl

      rlBuildSelectedUnitRangeMaps ; 87/B541

        .al
        .autsiz
        .databank ?

        ; Builds aMovementMap and aRangeMap for the selected unit: where it can move (none during canto) and, from its weapons' range flags, what it can reach.

        phx
        phy
        jsl rlGetSelectedUnitFactionSlot
        sta aAIAction.wMapPointer

        jsl rlGetSelectedUnitStates
        bit #UnitStateCanto
        beq +

          lda #0
          tay
          bra ++

          +
          jsl rlGetInventoryWeaponsRangeFlags

        +
        sta $1A
        sty $08
        cmp #4
        bcc +

          jsl rlUnknown87BA0B
          sec
          bra _End

        +
        jsl rlGetSelectedUnitMovementCostPointer
        sta aAIAction.wUnknown7F442C

        jsl rlGetSelectedUnitTotalFieldMovement
        sta $18

        jsl rlBuildSelectedUnitMovementMap

        lda wActiveFactionSlot,b
        bne +

          lda aAIAction.wMapPointer
          beq +

            lda $08
            bit #$0004
            beq +

              jsl rlUnknown87BA82

        +
        jsl rlUnknown87BB27

        _End
        ply
        plx
        rtl

        .databank 0

      rlBuildSelectedUnitMovementMap ; 87/B59D

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

        jsr rsSetRangeMapOrigin
        jsr rsClearMovementMap
        jsr rsClearRangeMap
        jsr rsMarkUnitsOnRangeMap
        jsr rsMarkRangeMapBorders
        stz $22
        jsr rsFloodFillMovementMap

        lda $1A
        beq _End

        sep #$20
        ldx #$0100

          -
          cpx $06
          beq +

          ldy $894C,b,x
          jsr rsUnknown87B91C

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


    .section Unsorted87B5DDSection

      .al
      .xl

      rsFloodFillMovementMap ; 87/B5DD

        .al
        .autsiz
        .databank $7F

        ldx #64 - 2
        lda #$FFFF
        
          -
          sta $894A + (64 * 0),b,x
          sta $894A + (64 * 1),b,x
          sta $894A + (64 * 2),b,x
          sta $894A + (64 * 3),b,x
          dec x
          dec x
          bpl -

        lda #32
        asl a
        asl a
        asl a
        asl a
        asl a
        asl a
        clc
        adc #32
        tay

        lda $18
        sep #$20
        sta aMovementMap,y
        rep #$20
        sta $04
        asl a
        tax
        lda #$0100
        sta $894A,b,x

        lda #$FFFF
        sta $894A,b + $100
        tya
        sta $894A,b + $102

        lda #$0104
        sta $06
        
          -
          lda $04
          cmp #7
          bcc _End

            asl 
            tax
            
              -
              lda $894A,b,x
              bmi +

                tax
                ldy $894A+2,b,x
                jsr rsSpreadMovementToNeighbours
                bra -

          +
          dec $04
          bra --
        
        _End
        rts

        .databank 0

        ; 87/B63F

    .endsection Unsorted87B5DDSection


    .section Unsorted87B63FSection

      .al
      .xl

      rsSpreadMovementToNeighbours ; 87/B63F

        .al
        .xl
        .autsiz
        .databank ?

        ; The four neighbours of a tile, with their movement costs.

        sep #$20
        phx
        lda $750A,b,y
        bne _B692
        lda $650A,b,y
        bmi _B692
        rep #$20
        lda #$FFC0
        jsr rsUnknown87B8A7
        sep #$20
        bmi _B692
        lda wR2
        sec
        sbc wR0
        bcc _B692
        beq _B692
        pha
        jsr rsUnknown87B8FE
        pla
        bcc _B66A
        ora #$80

        _B66A
        sta $750A,b,y
        rep #$20
        and #$007F
        asl a
        tax
        lda $894A,b,x
        pha
        lda wR3
        sta $894A,b,x
        tax
        clc
        adc #$0004
        sta wR3
        pla
        sta $894A,b,x
        tya
        clc
        adc #$FFC0
        sta $894C,b,x
        sep #$20

        _B692
        lda $7549,b,y
        bne _B6E2
        lda $6549,b,y
        bmi _B6E2
        rep #$20
        lda #$FFFF
        jsr rsUnknown87B8A7
        sep #$20
        bmi _B6E2
        lda wR2
        sec
        sbc wR0
        bcc _B6E2
        beq _B6E2
        pha
        jsr rsUnknown87B8FE
        pla
        bcc _B6BA
        ora #$80

        _B6BA
        sta $7549,b,y
        rep #$20
        and #$007F
        asl a
        tax
        lda $894A,b,x
        pha
        lda wR3
        sta $894A,b,x
        tax
        clc
        adc #$0004
        sta wR3
        pla
        sta $894A,b,x
        tya
        clc
        adc #$FFFF
        sta $894C,b,x
        sep #$20

        _B6E2
        lda $754B,b,y
        bne _B732
        lda $654B,b,y
        bmi _B732
        rep #$20
        lda #$0001
        jsr rsUnknown87B8A7
        sep #$20
        bmi _B732
        lda wR2
        sec
        sbc wR0
        bcc _B732
        beq _B732
        pha
        jsr rsUnknown87B8FE
        pla
        bcc _B70A
        ora #$80

        _B70A
        sta $754B,b,y
        rep #$20
        and #$007F
        asl a
        tax
        lda $894A,b,x
        pha
        lda wR3
        sta $894A,b,x
        tax
        clc
        adc #$0004
        sta wR3
        pla
        sta $894A,b,x
        tya
        clc
        adc #$0001
        sta $894C,b,x
        sep #$20

        _B732
        lda $758A,b,y
        bne _B782
        lda $658A,b,y
        bmi _B782
        rep #$20
        lda #$0040
        jsr rsUnknown87B8A7
        sep #$20
        bmi _B782
        lda wR2
        sec
        sbc wR0
        bcc _B782
        beq _B782
        pha
        jsr rsUnknown87B8FE
        pla
        bcc _B75A
        ora #$80

        _B75A
        sta $758A,b,y
        rep #$20
        and #$007F
        asl a
        tax
        lda $894A,b,x
        pha
        lda wR3
        sta $894A,b,x
        tax
        clc
        adc #$0004
        sta wR3
        pla
        sta $894A,b,x
        tya
        clc
        adc #$0040
        sta $894C,b,x
        sep #$20

        _B782
        plx
        rep #$20
        rts

        .databank 0

        ; 87/B786

    .endsection Unsorted87B63FSection


    .section Unsorted87B786Section

      .al
      .xl

      rsSetRangeMapOrigin ; 87/B786

        .al
        .autsiz
        .databank ?

        ; $14, $16 = the unit's tile.

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

      rsClearMovementMap ; 87/B7A2

        .al
        .autsiz
        .databank ?

        lda #`aMovementMap
        ldx #<>aMovementMap
        ldy #0
        jsl rlFillMapBuffer
        rts

        .databank 0

      rsClearRangeMap ; 87/B7B0

        .al
        .autsiz
        .databank ?

        lda #`aRangeMap
        ldx #<>aRangeMap
        ldy #0
        jsl rlFillMapBuffer
        rts

        .databank 0

      rsMarkUnitsOnRangeMap ; 87/B7BE

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

                  jsr rsGetRangeMapUnitMark

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

      rsGetRangeMapUnitMark ; 87/B811

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
          cmp #AllegianceNeutral
          beq +

            cmp #AllegianceEnemy
            bne ++

          ; neutral, enemy
          +
          lda #$00FF
          rts

        ; own, allied
        +
        lda #1
        rts

        .databank 0

      rsMarkRangeMapBorders ; 87/B833

        .al
        .autsiz
        .databank ?

        ; Marks the edges of the map as walls.

        ; write map boundaries?

        lda wR14
        bmi +

          lda #$003F
          sec
          sbc wR14
          jsr rsMarkRangeMapColumnBorder

          lda wR14
          bne ++

        +
        eor #$FFFF
        inc a
        jsr rsMarkRangeMapColumnBorder
        
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
        jsr rsMarkRangeMapRowBorder

        lda wCurrentChapter
        beq _B86D

          lda wR15
          bne +

            _B86D
            lda wR15
            eor #$FFFF
            inc a
            jsr rsMarkRangeMapRowBorder
        
        +
        rts

        .databank 0

    .endsection Unsorted87B786Section


    .section Unsorted87B877Section

      .al
      .xl

      rsMarkRangeMapColumnBorder ; 87/B877

        .al
        .autsiz
        .databank ?

        ; write vertical boundaries?

        tay
        ldx #64
        
          -
          lda #$00FE
          sep #$20
          sta $654A,b,y
          rep #$20
          tya
          clc
          adc #64
          tay
          dec x
          bne -

        rts

        .databank 0

      rsMarkRangeMapRowBorder ; 87/B88F

        .al
        .autsiz
        .databank $7F

        ; write horizonal boundaries?

        asl a
        asl a
        asl a
        asl a
        asl a
        asl a
        tay

        sep #$20
        ldx #64
        
          -
          lda #$FE
          sta aRangeMap,y
          inc y
          dec x
          bne -

        rep #$20
        rts

        .databank 0

        ; 87/B8A7

    .endsection Unsorted87B877Section


    .section Unsorted87B8A7Section

      .al
      .xl

      rsUnknown87B8A7 ; 87/B8A7

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        sta wR0
        lda wR17
        bne _B8E6
        tya
        clc
        adc wR0
        clc
        adc wR16
        asl a
        tax
        lda $2400,b,x
        sta wR1
        and #$03FF
        tax
        lda $2000,b,x
        and #$00FF
        cmp #$001A
        bcc _B8CF
        lda #$0000

        _B8CF
        clc
        adc $442C,b
        tax
        lda $830000,x
        and #$00FF
        bit #$0080
        bne _B8E6
        asl a
        tax
        lda aUnknown87B8EE,x

        _B8E6
        ply
        plx
        sta wR0
        cmp #$0000
        rts

        .databank 0

        ; 87/B8EE

    .endsection Unsorted87B8A7Section


    .section Table87B8EESection

      .al
      .xl

      aUnknown87B8EE ; 87/B8EE

        ; Read by rsUnknown87B8A7.

        .word $0007, $000A, $0014, $001E, $0028, $0032, $003C, $0046

        ; 87/B8FE

    .endsection Table87B8EESection


    .section Unsorted87B8FESection

      .al
      .xl

      rsUnknown87B8FE ; 87/B8FE

        .as
        .xl
        .autsiz
        .databank ?

        lda wR17
        bne _B91A
        lda aAIAction.wMapPointer
        bne _B91A
        lda wR1+1
        and #$FC
        beq _B91A
        sta wR1+1
        and @l wAreaRestrictionBitfield
        cmp wR1+1
        beq _B91A
        sec
        rts


        _B91A
        clc
        rts

        .databank 0

        ; 87/B91C

      rsUnknown87B91C ; 87/B91C

        .as
        .xl
        .autsiz
        .databank ?

        lda $754A,b,y
        bpl _B925
        jml _BA0A


        _B925
        lda $654A,b,y
        beq _B92E
        jml _BA0A


        _B92E
        lda wR13
        and #$01
        beq _B978
        lda $750A,b,y
        bne _B945
        lda $650A,b,y
        cmp #$FE
        beq _B945
        lda #$80
        sta $750A,b,y

        _B945
        lda $758A,b,y
        bne _B956
        lda $658A,b,y
        cmp #$FE
        beq _B956
        lda #$80
        sta $758A,b,y

        _B956
        lda $7549,b,y
        bne _B967
        lda $6549,b,y
        cmp #$FE
        beq _B967
        lda #$80
        sta $7549,b,y

        _B967
        lda $754B,b,y
        bne _B978
        lda $654B,b,y
        cmp #$FE
        beq _B978
        lda #$80
        sta $754B,b,y

        _B978
        lda wR13
        and #$02
        bne _B982
        jml _BA0A


        _B982
        lda $7509,b,y
        bne _B993
        lda $6509,b,y
        cmp #$FE
        beq _B993
        lda #$80
        sta $7509,b,y

        _B993
        lda $750B,b,y
        bne _B9A4
        lda $650B,b,y
        cmp #$FE
        beq _B9A4
        lda #$80
        sta $750B,b,y

        _B9A4
        lda $7548,b,y
        bne _B9B5
        lda $6548,b,y
        cmp #$FE
        beq _B9B5
        lda #$80
        sta $7548,b,y

        _B9B5
        lda $754C,b,y
        bne _B9C6
        lda $654C,b,y
        cmp #$FE
        beq _B9C6
        lda #$80
        sta $754C,b,y

        _B9C6
        lda $7589,b,y
        bne _B9D7
        lda $6589,b,y
        cmp #$FE
        beq _B9D7
        lda #$80
        sta $7589,b,y

        _B9D7
        lda $758B,b,y
        bne _B9E8
        lda $658B,b,y
        cmp #$FE
        beq _B9E8
        lda #$80
        sta $758B,b,y

        _B9E8
        lda $74CA,b,y
        bne _B9F9
        lda $64CA,b,y
        cmp #$FE
        beq _B9F9
        lda #$80
        sta $74CA,b,y

        _B9F9
        lda $75CA,b,y
        bne _BA0A
        lda $65CA,b,y
        cmp #$FE
        beq _BA0A
        lda #$80
        sta $75CA,b,y

        _BA0A
        rts

        .databank 0

        ; 87/BA0B

      rlUnknown87BA0B ; 87/BA0B

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        sep #$20
        lda #$7F
        pha
        rep #$20
        plb
        .databank $7F
        jsr rsSetRangeMapOrigin
        jsr rsClearMovementMap
        jsr rsClearRangeMap
        jsr rsMarkRangeMapBorders
        lda #$0065
        sta wR12
        lda #$000A
        sta wR17
        jsr rsFloodFillMovementMap
        lda #$0065
        sta wR2

        _BA35
        lda wR2
        asl a
        tax

        _BA39
        lda $894A,b,x
        bmi _BA47
        tax
        ldy $894C,b,x
        jsr rsUnknown87BA54
        bra _BA39


        _BA47
        lda wR2
        sec
        sbc wR17
        sta wR2
        bpl _BA35
        plp
        plb
        .databank $7F
        clc
        rtl

        .databank 0

        ; 87/BA54

      rsUnknown87BA54 ; 87/BA54

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda wR2
        cmp #$65
        beq _BA68
        cmp #$5B
        beq _BA6C
        cmp #$51
        beq _BA74

        _BA64
        lda #$80
        bra _BA7C


        _BA68
        lda #$01
        bra _BA7C


        _BA6C
        lda wR13
        and #$01
        bne _BA64
        bra _BA7A


        _BA74
        lda wR13
        and #$02
        bne _BA64

        _BA7A
        lda #$00

        _BA7C
        sta $754A,b,y
        rep #$20
        rts

        .databank 0

        ; 87/BA82

      rlUnknown87BA82 ; 87/BA82

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        sep #$20
        lda #$7F
        pha
        rep #$20
        plb
        .databank $7F
        ldx #$0000

        _BA91
        lda aUnknown87BAD1,x
        beq _BAB7
        tay
        lda aUnknown87BAD1+2,x
        inc x
        inc x
        inc x
        inc x
        phx
        tax
        phx
        phy

        _BAA4
        jsr rsUnknown87BABB
        inc x
        dec y
        bne _BAA4
        ply
        plx

        _BAAD
        jsr rsUnknown87BABB
        dec x
        dec y
        bne _BAAD
        plx
        bra _BA91


        _BAB7
        plp
        plb
        .databank ?
        clc
        rtl

        .databank 0

        ; 87/BABB

      rsUnknown87BABB ; 87/BABB

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda $754A,b,x
        bne _BACE
        lda $654A,b,x
        cmp #$FE
        beq _BACE
        lda #$FF
        sta $754A,b,x

        _BACE
        rep #$20
        rts

        .databank 0

        ; 87/BAD1

    .endsection Unsorted87B8FESection


    .section Table87BAD1Section

      .al
      .xl

      aUnknown87BAD1 ; 87/BAD1

        ; Read by rlUnknown87BA82.

        .word $0001, $05A0, $0002, $05E0, $0003, $0620, $0004, $0660
        .word $0005, $06A0, $0006, $06E0, $0007, $0720, $0008, $0760
        .word $0009, $07A0, $000A, $07E0, $000B, $0820, $000A, $0860
        .word $0009, $08A0, $0008, $08E0, $0007, $0920, $0006, $0960
        .word $0005, $09A0, $0004, $09E0, $0003, $0A20, $0002, $0A60
        .word $0001, $0AA0, $0000

        ; 87/BB27

    .endsection Table87BAD1Section


    .section Unsorted87BB27Section

      .al
      .xl

      rlUnknown87BB27 ; 87/BB27

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda $7F7D2A
        bmi _BB31
        bne _BB4C

        _BB31
        lda $7F7DAA
        bmi _BB39
        bne _BB4C

        _BB39
        lda $7F7D69
        bmi _BB41
        bne _BB4C

        _BB41
        lda $7F7D6B
        bmi _BB49
        bne _BB4C

        _BB49
        sec
        bra _BB4D


        _BB4C
        clc

        _BB4D
        rep #$20
        rtl

        .databank 0

        ; 87/BB50

    .endsection Unsorted87BB27Section


