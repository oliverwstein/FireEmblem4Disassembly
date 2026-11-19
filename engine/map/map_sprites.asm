; TODO: describe this file.

    .section MapSpriteSection

      .al
      .xl

      asMapSprite ; 81/88B0

        .word <>rlASMapSpriteInit
        .word <>rlASMapSpriteCycle1
        .word <>aASMapSpriteCode

      rlASMapSpriteInit ; 81/88B6

        .al
        .autsiz
        .databank ?

        ; Input:
        ; X = active sprite offset

        txy
        lda aMovingMapSprites.wOffset,b
        tax
        sta aActiveSpriteSystem.aUnknown0012C0,b,y
        tya
        sta aMovingMapSprites.wActiveSpriteOffset,b,x

        lda aMovingMapSprites.wUnknown0017C2,b
        ora #$8000
        sta aActiveSpriteSystem.aUnknown0012E0,b,y

        lda #0
        sta aActiveSpriteSystem.aUnknown001320,b,y
        sta aActiveSpriteSystem.aUnknown001340,b,y
        sta aActiveSpriteSystem.aUnknown001300,b,y

        phx
        jsr rsUnknown818A4A
        asl a
        tax
        lda aUnknown81890B,x
        sta aActiveSpriteSystem.aUnknown001380,b,y
        lda aUnknown81891B,x
        sta aActiveSpriteSystem.aUnknown0013A0,b,y
        plx

        lda #0
        sta wUnknown000911,x
        lda #0
        sta wUnknown0008F1,x
        lda #0
        sta wUnknown000901,x

        lda aActiveSpriteSystem.aUnknown0012E0,b,y
        and #~$4000
        sta aActiveSpriteSystem.aUnknown0012E0,b,y
        rtl

        .databank 0

      aUnknown81890B ; 81/890B

        ; Indexed by the lowest byte of the bitfield in the event movement command

        .word $0000
        .word $2000
        .word $4000
        .word $8000
        .word $0000
        .word $0000
        .word $0000
        .word $0000

      aUnknown81891B ; 81/891B

        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $0001
        .word $0002
        .word $0004
        .word $0008

      rlASMapSpriteCycle1 ; 81/892B

        .al
        .autsiz
        .databank ?

        ; Input:
        ; X = active sprite offset

        txy

        lda bDecompressionArrayFlag,b
        beq +

          jml _End

        +
        lda aMovingMapSprites.wState,b
        cmp #0
        beq _89A8

          lda aActiveSpriteSystem.aUnknown0012C0,b,y
          lsr a
          cmp aMovingMapSprites.wEntryIndex,b
          bne _89A8

            lda aMovingMapSprites.wState,b
            cmp #2
            bne _End

              phx
              lda aMovingMapSprites.wEntryIndex,b
              asl a
              tax
              lda aMovingMapSprites.wActiveSpriteOffset,x
              tax
              lda aActiveSpriteSystem.aUnknown0012E0,x
              bit #$0004
              beq _89A7

                lda aMovingMapSprites.wEntryIndex,b
                asl a
                tax
                lda aEventMovement.aScriptEndXCoordinate,x
                sta wR0
                lda aEventMovement.aScriptEndYCoordinate,x
                xba
                ora wR0
                sta wRoutineVariable1,b
                lda aMovingMapSprites.wCharacterID,b
                ldx aMovingMapSprites.wUnknown001822,b
                jsl rlUnknown84C87A
                bcc +

                  brk

                +
                pha
                lda aMovingMapSprites.wUnknown001824,b
                and #$000F
                jsl rlSetSelectedUnitAI

                lda aMovingMapSprites.wUnknown001824,b
                bit #$0080
                beq +

                  lda #UnitStateGroupLeader
                  jsl rlSetSelectedUnitStates

                +
                lda aMovingMapSprites.wEntryIndex,b
                asl a
                tax
                pla
                sta $17CC,b,x

              _89A7
              plx

        _89A8
        lda #$0008
        tsb $4C07,b

        lda aActiveSpriteSystem.aUnknown0012E0,b,y
        ora #$4000
        sta aActiveSpriteSystem.aUnknown0012E0,b,y

        lda #<>rlASMapSpriteCycle2
        sta aActiveSpriteSystem.aOnCycle,b,x
        
        _End
        rtl

        .databank 0

      rlASMapSpriteCycle2 ; 81/89BE

        .al
        .autsiz
        .databank ?

        txy
        lda aActiveSpriteSystem.aUnknown0012C0,b,y
        tax
        stx aMovingMapSprites.wOffset,b
        cpx #$FFFF
        beq _End

          lda aActiveSpriteSystem.aUnknown0012E0,b,y
          bit #$8000
          beq _End

            phx
            phy
            jsr rsUnknown818A68
            ply
            plx
            bcs _End

              jsr rsUnknown818DA8

        _End
        rtl

        .databank 0

    .endsection MapSpriteSection


    .section MovingMapSpritePositionRoutinesSection

      .al
      .xl

      aMovingMapSpritePositionRoutines ; 81/8DF7

        .word <>rsMovingMapSpritePositionLeftwards
        .word <>rsMovingMapSpritePositionRightwards
        .word <>rsMovingMapSpritePositionUpwards
        .word <>rsMovingMapSpritePositionDownwards
        .word <>rsMovingMapSpritePositionDummy
        .word <>rsMovingMapSpritePositionDummy
        .word <>rsMovingMapSpritePositionDummy
        .word <>rsMovingMapSpritePositionDummy
        .word <>rsMovingMapSpritePositionDummy
        .word <>rsMovingMapSpritePositionDummy

      rsMovingMapSpritePositionLeftwards ; 81/8E0B

        .al
        .autsiz
        .databank ?

        ldx aMovingMapSprites.wOffset,b
        lda aMovingMapSprites.wXPixelPosition,b,x
        sec
        sbc wR5
        sta aMovingMapSprites.wXPixelPosition,b,x
        rts

        .databank 0

      rsMovingMapSpritePositionRightwards ; 81/8E18

        .al
        .autsiz
        .databank ?

        ldx aMovingMapSprites.wOffset,b
        lda aMovingMapSprites.wXPixelPosition,b,x
        clc
        adc wR5
        sta aMovingMapSprites.wXPixelPosition,b,x
        rts

        .databank 0

      rsMovingMapSpritePositionUpwards ; 81/8E25

        .al
        .autsiz
        .databank ?

        ldx aMovingMapSprites.wOffset,b
        lda aMovingMapSprites.wYPixelPosition,b,x
        sec
        sbc wR5
        sta aMovingMapSprites.wYPixelPosition,b,x
        rts

        .databank 0

      rsMovingMapSpritePositionDownwards ; 81/8E32

        .al
        .autsiz
        .databank ?

        ldx aMovingMapSprites.wOffset,b
        lda aMovingMapSprites.wYPixelPosition,b,x
        clc
        adc wR5
        sta aMovingMapSprites.wYPixelPosition,b,x
        rts

        .databank 0

      rsMovingMapSpritePositionDummy ; 81/8E3F

        .al
        .autsiz
        .databank ?

        rts

        .databank 0

      rsUnknown818E40 ; 81/8E40

        .al
        .autsiz
        .databank ?

        lda wR5
        sta wMapPixelScrollDistance,b
        sta wMapScrollSpeed,b
        lda aActiveSpriteSystem.aUnknown001300,b,y
        jsr rsGetMapScrollDirectionIdentifierFromCommand
        jsr rsUnknown818E58
        bcs +

          jsl rlUnknown819305
        
        +
        rts

        .databank 0

      rsUnknown818E58 ; 81/8E58

        .al
        .autsiz
        .databank ?

        pha
        lda aActiveSpriteSystem.aUnknown0012C0,b,y
        tax
        lda aMovingMapSprites.wXPixelPosition,b,x
        sec
        sbc wMapScrollXPixels,b
        sta wR0
        lda aMovingMapSprites.wYPixelPosition,b,x
        sec
        sbc wMapScrollYPixels,b
        sta wR1
        pla

        ldx wR0
        cpx #$0100
        bcs _SEC

        ldx wR1
        cpx #$0100
        bcs _SEC

        bit #$0200
        beq +

          jsr $818EAB
          bcs _SEC

        +
        bit #$0100
        beq +

          jsr $818EB3
          bcs _SEC

        +
        bit #$0800
        beq +

          jsr $818EBB
          bcs _SEC

        +
        bit #$0400
        beq +

          jsr $818EC3
          bcs _SEC

        +
        clc
        bra +

        _SEC
        sec

        +
        rts

        .databank 0

        ; 81/8EAB

    .endsection MovingMapSpritePositionRoutinesSection


    .section CapSpawnDestinationCoordinates100Section

      .al
      .xl

      rsCapSpawnDestinationCoordinates100 ; 81/9031

        .al
        .autsiz
        .databank ?

        ; Caps units spawn and destination coordinates at 99?
        ; How big were the maps supposed to be?

        lda wR2
        cmp #100
        bcc +

          lda #99
          sta wR2

        +
        lda wR3
        cmp #100
        bcc +

          lda #99
          sta wR3

        +
        lda wR4
        cmp #100
        bcc +

          lda #99
          sta wR4

        +
        lda wR5
        cmp #100
        bcc +

          lda #99
          sta wR5

        +
        rts

        .databank 0

        ; 81/9062

    .endsection CapSpawnDestinationCoordinates100Section


    .section FillMovingMapSpriteDataSection

      .al
      .xl

      rsFillMovingMapSpriteData ; 81/9092

        .al
        .autsiz
        .databank ?

        ldy #0
        lda wR0
        sta [lR18],y
        inc y
        inc y

        lda wR2
        sta [lR18],y
        inc y

        lda wR3
        sta [lR18],y
        inc y

        lda wR1
        sta [lR18],y
        inc y

        lda wR6
        sta [lR18],y
        inc y

        lda lR18
        clc
        adc #9
        sta [lR18],y
        inc y
        inc y

        lda lR18+2
        sta [lR18],y
        inc y

        rts

        .databank 0

    .endsection FillMovingMapSpriteDataSection
