; Map locations (castles, villages, etc.): event data, banners and tile changes.

    .section LocationEventDataSection

      .al
      .xl

      rlGetLocationEventDataEntry ; 87/E98D

        .al
        .autsiz
        .databank ?

        ; Looks into the chapters LocationData table and based on the specified ID, 
        ; fills the wEventLocationEntry with the matching short pointer.

        ; Input:
        ; A = LocationID

        ; Output:
        ; filled wEventLocationEntry 

        phb
        php
        phk
        plb
        phx
        ldx wR35
        phx
        ldx wR34
        phx

        sta wR35

        jsl rlGetChapterLocationDataPointer
        sta wR34

        ; Check if the location ID is within the total location events size

        tax
        lda $0000,b,x
        and #$00FF
        cmp wR35
        beq +
        bcc +

          lda wR35
          asl a
          clc
          adc wR34
          tax
          lda $0001,b,x
          sta wEventLocationEntry,b

          pla
          sta wR34
          pla
          sta wR35
          plx
          plp
          plb
          clc

          -
          rtl

        +
        pla
        sta wR34
        pla
        sta wR35
        plx
        plp
        plb
        sec
        bra -

        .databank 0

      rlGetEventLocationEntryCoordinatesByID ; 87/E9D1

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        jsl rlGetLocationEventDataEntry
        jsl rlGetEventLocationEntryCoordinates
        plp
        plb
        rtl

        .databank 0

        ; 87/E9E0

    .endsection LocationEventDataSection


    .section LocationUpdateSection

      .al
      .xl

      rlCheckIfCoordsNotEventLocationTile ; 87/EA87

        .al
        .autsiz
        .databank ?

        ; Find location event by coordinates?
        ; sec = not found

        ; Input:
        ; CLC if on event location tile, SEC if not
        ; wR0 = X coordinate
        ; wR1 = Y coordinate

        phb
        php
        phk
        plb
        phx
        phy

        lda wR2
        pha

        jsl rlGetChapterLocationDataPointer
        tay
        lda $0000,b,y
        and #$00FF
        sta wR2

          -
          phy
          ldx $0001,b,y
          stx wEventLocationEntry,b
          txy
          jsl rlGetEventLocationEntryType
          asl a
          tax
          lda aEventLocationTypeOffsets,x
          tax

          sep #$20
          lda aEventLocationTypeOffsets+6,x
          clc
          adc $0003,b,y
          cmp wR0
          bne +

            lda aEventLocationTypeOffsets+7,x
            clc
            adc $0004,b,y
            cmp wR1
            bne +

              ply
              bra _CLC

          +
          rep #$20
          ply
          inc y
          inc y
          dec wR2
          bne -

        lda #0
        sta wEventLocationEntry,b

        pla
        sta wR2

        ply
        plx
        plp
        plb
        sec
        
        _End
        rtl

        _CLC
        rep #$20

        pla
        sta wR2

        ply
        plx
        plp
        plb
        clc
        bra _End

        .databank 0

      rlUpdateAllLocationEvents ; 87/EAF1

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        phy
        lda wR3
        pha

        lda lChapterEventDataPointer,b
        beq _End

          ; Get the chapters location event count
          jsl rlGetChapterLocationDataPointer
          tay
          lda $0000,b,y
          and #$00FF
          sta wR3

            -
            ldx $0001,b,y
            stx wEventLocationEntry,b
            jsl rlHandleEventLocationModification
            inc y
            inc y
            dec wR3
            bne -

        _End
        pla
        sta wR3
        ply
        plx
        plp
        plb
        rtl

        .databank 0

      rlUnknown87EB24 ; 87/EB24

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        phy
        lda wR3
        pha
        lda wR2
        pha

        lda lChapterEventDataPointer,b
        beq _End

          jsl rlGetChapterLocationDataPointer

          tay
          stz wR2
          lda $0000,b,y
          and #$00FF
          sta wR3

            -
            ldx $0001,b,y
            stx wEventLocationEntry,b
            jsl rlGetEventLocationEntryType
            cmp #0
            bne +

              lda wEventLocationEntry,b
              sta wR2

            +
            inc y
            inc y
            dec wR3
            bne -

          lda wR2
          sta wEventLocationEntry,b
        
        _End
        pla
        sta wR2
        pla
        sta wR3
        ply
        plx
        plp
        plb
        rtl

        .databank 0

      rlCountAlliedCastles ; 87/EB6E

        .al
        .autsiz
        .databank ?

        ; Input:
        ; Filled lChapterEventDataPointer

        ; Output:
        ; A = count

        phb
        php
        phk
        plb
        phx
        phy
        lda wR3
        pha
        lda wR2
        pha
        lda lChapterEventDataPointer,b
        beq _End

          jsl rlGetChapterLocationDataPointer
          tay

          stz wR2
          lda $0000,b,y
          and #$00FF
          sta wR3
          
            _Loop
            ldx $0001,b,y
            stx wEventLocationEntry,b
            jsl rlGetEventLocationEntryType
            cmp #LocationTypeCastle
            bne _Next

              jsl rlGetLocationFactionSlotOwner
              tax

              lda #0
              jsl rlGetFactionRelation
              cmp #AllegianceOther
              beq _Next

                cmp #AllegianceEnemy
                beq _Next

                  inc wR2

            _Next
            inc y
            inc y
            dec wR3
            bne _Loop

          lda wR2

        _End
        plx
        stx wR2
        plx
        stx wR3
        ply
        plx
        plp
        plb
        rtl

        .databank 0

        ; 87/EBC8

    .endsection LocationUpdateSection


    .section LocationGettersSection

      .al
      .xl

      rlGetEventLocationEntryID ; 87/EC42

        .al
        .autsiz
        .databank ?

        ; Input:
        ; filled wEventLocationEntry

        ; Output:
        ; A = ID that is set inside the entry

        phb
        php
        phk
        plb
        phx

        ldx wEventLocationEntry,b

        sep #$20
        lda lChapterEventDataPointer+2,b
        pha
        rep #$20
        plb

        lda structChapterLocationEntry.ID,b,x
        and #$00FF

        plx
        plp
        plb
        rtl

        .databank 0

      rlGetEventLocationEntryNameID ; 87/EC5D

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx

        ldx wEventLocationEntry,b

        sep #$20
        lda lChapterEventDataPointer+2,b
        pha
        rep #$20
        plb

        lda structChapterLocationEntry.NameID,b,x
        and #$00FF

        plx
        plp
        plb
        rtl

        .databank 0

      rlGetEventLocationEntryType ; 87/EC78

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx

        ldx wEventLocationEntry,b

        sep #$20
        lda lChapterEventDataPointer+2,b
        pha
        rep #$20
        plb

        lda structChapterLocationEntry.Type,b,x
        and #$00FF

        plx
        plp
        plb
        rtl

        .databank 0

      rlGetEventLocationEntryCastleName ; 87/EC93

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx

        ldx wEventLocationEntry,b

        sep #$20
        lda lChapterEventDataPointer+2,b
        pha
        rep #$20
        plb

        lda #>`aCastleNameOffsets
        sta lRoutineVariable+1,b
        lda structChapterLocationEntry.NameID,b,x
        and #$00FF
        asl a
        tax
        lda aCastleNameOffsets,x
        clc
        adc #<>aCastleNameOffsets
        sta lRoutineVariable,b
        plx
        plp
        plb
        rtl

        .databank 0

      rlGetEventLocationEntryCoordinates ; 87/ECC1

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx

        ldx wEventLocationEntry,b

        sep #$20
        lda lChapterEventDataPointer+2,b
        pha
        rep #$20
        plb

        lda structChapterLocationEntry.XPosition,b,x

        plx
        plp
        plb
        rtl

        .databank 0

      rlGetEventLocationEntryOriginXCoordinate ; 87/ECD9

        .al
        .autsiz
        .databank ?

        jsl rlGetEventLocationEntryType
        jsl rlGetEventLocationTypeOriginXOffset
        rtl

        .databank 0

      rlGetEventLocationEntryOriginYCoordinate ; 87/ECE2

        .al
        .autsiz
        .databank ?

        jsl rlGetEventLocationEntryType
        jsl rlGetEventLocationTypeOriginYOffset
        rtl

        .databank 0

      rlGetEventLocationEntryEffectiveModificationXCoordinate ; 87/ECEB

        .al
        .autsiz
        .databank ?

        jsl rlGetEventLocationEntryType
        jsl rlGetEventLocationTypeModificationXOffset
        rtl

        .databank 0

      rlGetEventLocationEntryEffectiveModificationYCoordinate ; 87/ECF4

        .al
        .autsiz
        .databank ?

        jsl rlGetEventLocationEntryType
        jsl rlGetEventLocationTypeModificationYOffset
        rtl

        .databank 0

      rlGetEventLocationEntryEffectiveXCoordinate ; 87/ECFD

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx

        ldx wEventLocationEntry,b

        sep #$20
        lda lChapterEventDataPointer+2,b
        pha
        rep #$20
        plb

        jsl rlGetEventLocationEntryType
        jsl rlGetEventLocationTypeInteractionXOffset

        clc
        adc structChapterLocationEntry.XPosition,b,x
        and #$00FF

        plx
        plp
        plb
        rtl

        .databank 0

      rlGetEventLocationEntryEffectiveYCoordinate ; 87/ED21

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx

        ldx wEventLocationEntry,b

        sep #$20
        lda lChapterEventDataPointer+2,b
        pha
        rep #$20
        plb

        jsl rlGetEventLocationEntryType
        jsl rlGetEventLocationTypeInteractionYOffset

        clc
        adc structChapterLocationEntry.YPosition,b,x
        and #$00FF

        plx
        plp
        plb
        rtl

        .databank 0

      rlGetLocationFactionSlotOwner ; 87/ED45

        .al
        .autsiz
        .databank ?

        ; Input:
        ; filled wEventLocationEntry

        ; Output:
        ; A = FactionSlot that owns the location

        phx
        jsl rlGetEventLocationEntryID
        tax
        lda aChapterLocationRAMData,x
        and #LocationFactionSlotOwnerMask
        cmp #Factionless
        bcc +

          lda #$FFFF

        +
        plx
        rtl

        .databank 0

      rlSetLocationFactionSlotOwner ; 87/ED5C

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = FactionSlot
        ; filled wEventLocationEntry

        phx
        pha

        jsl rlGetEventLocationEntryID
        tax
        lda aChapterLocationRAMData,x
        and #~LocationFactionSlotOwnerMask
        sta aChapterLocationRAMData,x

        pla
        sep #$20
        and #LocationFactionSlotOwnerMask
        ora aChapterLocationRAMData,x
        sta aChapterLocationRAMData,x
        rep #$20
        plx
        rtl

        .databank 0

      rlBuildDeadPlayerCharacterList ; 87/ED7F

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        phy
        lda wR0
        pha

        ldx #(24 - 1) * size(word)
        lda #$FFFF

          -
          sta aDeadPlayerCharacterList,x
          dec x
          dec x
          bpl -

        jsl rlGetEventLocationEntryID
        sta wR0

        lda #(`aUnitRAMPointers)<<8
        sta lStructPointer2+1,b
        lda #<>aUnitRAMPointers
        sta lStructPointer2,b
        ldx #0
        ldy #1

          _Loop
          sty $0550,b
          jsl rlLoadRAMStructDataByIndex
          bcs _End

            lda lStructPointer1,b
            sta wSelectedUnitDataRAMPointer,b
            jsl rlGetSelectedUnitHomeCastle
            cmp wR0
            bne _Next

              jsl rlGetSelectedUnitStates
              bit #(UnitStateFielded | UnitStateDead)
              bne _Next

                jsl rlGetSelectedUnitDeploymentOffset
                bcs _Next

                  jsl rlGetSelectedUnitDeploymentOffset
                  bcs _Next

                    sta aDeadPlayerCharacterList,x
                    inc x
                    inc x

            _Next
            inc y
            bra _Loop

        _End
        pla
        sta wR0
        ply
        plx
        plp
        plb
        rtl

        .databank 0

      rlGetEventLocationMoneyReward ; 87/EDEB

        .al
        .autsiz
        .databank ?

        phx
        jsl rlGetEventLocationEntryID
        asl a
        tax
        lda aChapterLocationMoneyRewards,x
        plx
        rtl

        .databank 0

      rlSubtractEventLocationMoneyReward ; 87/EDF8

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = value to subtract

        phb
        php
        phk
        plb
        phx
        ldx wR0
        phx

        sta wR0
        jsl rlGetEventLocationEntryID
        asl a
        tax
        lda aChapterLocationMoneyRewards,x
        sec
        sbc wR0
        bpl +

          lda #0

        +
        sta aChapterLocationMoneyRewards,x
        beq _SEC

        plx
        stx wR0
        plx
        plp
        plb
        clc

        -
        rtl

        _SEC
        plx
        stx wR0
        plx
        plp
        plb
        sec
        bra -

        .databank 0

      rlCheckIfCastleGuarded ; 87/EE2B

        .al
        .autsiz
        .databank ?

        ; Input:
        ; filled wEventLocationEntry

        ; Output:
        ; SEC if true

        phx
        jsl rlGetEventLocationEntryID
        tax
        lda aChapterLocationRAMData,x
        bit #CastleGuarded
        bne +

          clc
          plx
          rtl

        +
        sec
        plx
        rtl

        .databank 0

      rlSetCastleGuarded ; 87/EE40

        .al
        .autsiz
        .databank ?

        ; Input:
        ; filled wEventLocationEntry

        phx
        jsl rlGetEventLocationEntryID
        tax
        sep #$20
        lda aChapterLocationRAMData,x
        ora #CastleGuarded
        sta aChapterLocationRAMData,x
        rep #$20
        plx
        rtl

        .databank 0

      rlUnsetCastleGuarded ; 87/EE56

        .al
        .autsiz
        .databank ?

        ; Input:
        ; filled wEventLocationEntry

        phx
        jsl rlGetEventLocationEntryID
        tax
        sep #$20
        lda aChapterLocationRAMData,x
        and #~CastleGuarded
        sta aChapterLocationRAMData,x
        rep #$20
        plx
        rtl

        .databank 0

      rlUnknown87EE6C ; 87/EE6C

        .al
        .autsiz
        .databank ?
        
        ; Input:
        ; filled wEventLocationEntry

        ; Output:
        ; SEC if true

        phx
        jsl rlGetEventLocationEntryID
        tax
        lda aChapterLocationRAMData,x
        bit #LocationState40
        bne +

        clc
        plx
        rtl

        +
        sec
        plx
        rtl

        .databank 0

      rlUnknown87EE81 ; 87/EE81

        .al
        .autsiz
        .databank ?

        ; Input:
        ; filled wEventLocationEntry

        phx
        jsl rlGetEventLocationEntryID
        tax
        lda aChapterLocationRAMData,x
        ora #LocationState40
        sta aChapterLocationRAMData,x
        plx
        rtl

        .databank 0

      rlCheckLocationDestroyed ; 87/EE94

        .al
        .autsiz
        .databank ?

        ; Input:
        ; filled wEventLocationEntry

        ; Output:
        ; SEC if true

        phx
        jsl rlGetEventLocationEntryID
        tax
        lda aChapterLocationRAMData,x
        bit #LocationDestroyed
        bne +

          clc
          plx
          rtl

        +
        sec
        plx
        rtl

        .databank 0

      rlSetLocationDestroyed ; 87/EEA9

        .al
        .autsiz
        .databank ?

        ; Input:
        ; filled wEventLocationEntry

        phx
        jsl rlGetEventLocationEntryID
        tax
        lda aChapterLocationRAMData,x
        ora #LocationDestroyed
        sta aChapterLocationRAMData,x
        plx
        rtl

        .databank 0

      rlCheckIfVillageClosed ; 87/EEBC

        .al
        .autsiz
        .databank ?

        ; Input:
        ; filled wEventLocationEntry

        ; Output:
        ; SEC if true

        phx
        jsl rlGetEventLocationEntryID
        tax
        lda aChapterLocationRAMData,x
        bit #VillageClosed
        bne +

          clc
          plx
          rtl

        +
        sec
        plx
        rtl

        .databank 0

      rlSetVillageClosed ; 87/EED1

        .al
        .autsiz
        .databank ?

        ; Input:
        ; filled wEventLocationEntry

        phx
        jsl rlGetEventLocationEntryID
        tax
        lda aChapterLocationRAMData,x
        ora #VillageClosed
        sta aChapterLocationRAMData,x
        plx
        rtl

        .databank 0

      rlSetVillageOpen ; 87/EEE4

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        lda wR0
        pha
        lda wR1
        pha

        jsl rlGetEventLocationEntryID
        tax
        lda aChapterLocationRAMData,x
        and #~VillageClosed
        sta aChapterLocationRAMData,x

        ldx wEventLocationEntry,b
        sep #$20
        lda lChapterEventDataPointer+2,b
        pha
        rep #$20
        plb

        jsl rlGetEventLocationEntryOriginXCoordinate
        clc
        adc structChapterLocationEntry.XPosition,b,x
        and #$00FF
        sta wR0
        jsl rlGetEventLocationEntryOriginYCoordinate
        clc
        adc structChapterLocationEntry.YPosition,b,x
        and #$00FF
        sta wR1
        phk
        plb
        lda #<>aVillageOpenedTileData
        jsl $86C6E8

        pla
        sta wR1
        pla
        sta wR0
        plx
        plp
        plb
        rtl

        .databank 0

      aVillageOpenedTileData ; 87/EF38

        .byte 3, 2

        .word $FFFF, $FFFF, $FFFF
        .word $FFFF, $00B1, $FFFF

        ; 87/EF46

    .endsection LocationGettersSection


    .section LocationModificationSection

      .al
      .xl

      rlHandleEventLocationModification ; 87/EF61

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        jsl rlCheckLocationDestroyed
        bcs +

          jsl rlGetEventLocationEntryType
          asl a
          tax
          jsr (aEventLocationTypeModifications,x)
          bra ++

        +
        jsr rsDestroyEventLocation

        +
        plx
        plp
        plb
        rtl

        .databank 0

      aEventLocationTypeModifications ; 87/EF7E

        .word <>rsEventLocationCastleModification
        .word <>rsEventLocationDummyModification
        .word <>rsEventLocationVillageModification
        .word <>rsEventLocationDummyModification
        .word <>rsEventLocationDummyModification
        .word <>rsEventLocationDummyModification
        .word <>rsEventLocationDummyModification

      rsEventLocationDummyModification ; 87/EF8C

        .al
        .autsiz
        .databank ?

        rts

        .databank 0

      rsEventLocationCastleModification ; 87/EF8D

        .al
        .autsiz
        .databank ?

        ; Handles changing the banner color of the bottom left tile of a castle
        ; to match the occupiers allegiance.

        lda #0
        jsl rlGetFactionSlotNameID
        cmp #$FFFF
        bne +

        lda #1
        bra ++

        +
        jsl rlGetLocationFactionSlotOwner
        tax

        lda #0
        jsl rlGetFactionRelation

        +
        asl a
        sta wR2

        ldx wEventLocationEntry,b
        sep #$20
        lda lChapterEventDataPointer+2,b
        pha
        rep #$20
        plb

        jsl rlGetEventLocationEntryEffectiveModificationXCoordinate
        clc
        adc structChapterLocationEntry.XPosition,b,x
        and #$00FF
        sta wR0

        jsl rlGetEventLocationEntryEffectiveModificationYCoordinate
        clc
        adc structChapterLocationEntry.YPosition,b,x
        and #$00FF
        sta wR1

        lda wR1
        xba
        lsr a
        lsr a
        clc
        adc wR0
        asl a
        tax

        ; Check the tile one up, two left from the allegiance indicator
        ; of a castle.
        lda aMapData - size(word) * (1 * $40 + 2),x
        and #$03FF
        cmp #$0057
        bcs _End

          sec
          sbc #$0050
          bcc _End

            phx
            tax
            lda aCastleBannerTileIndexesOffsets,x
            clc
            adc wR2
            tax
            lda aCastleBannerTileIndexesOffsets,x
            plx
            sep #$20
            sta aMapData,x
            rep #$20

        _End
        rts

        .databank 0

      aCastleBannerTileIndexesOffsets ; 87/F007

        .word aCastle1BannerTileIndexes - aCastleBannerTileIndexesOffsets
        .byte 0
        .word aCastle2BannerTileIndexes - aCastleBannerTileIndexesOffsets
        .byte 0
        .word aCastle3BannerTileIndexes - aCastleBannerTileIndexesOffsets

      aCastle1BannerTileIndexes ; 87/F00F

        .word $0072
        .word $0000
        .word $0001
        .word $0002

      aCastle2BannerTileIndexes ; 87/F017

        .word $0075
        .word $0020
        .word $0021
        .word $0022

      aCastle3BannerTileIndexes ; 87/F01F

        .word $0078
        .word $0003
        .word $0004
        .word $0005

      rsEventLocationVillageModification ; 87/F027

        .al
        .autsiz
        .databank ?

        ; Handles the different stages of village destruction.

        ; This is a way to get some pseudo-random value that will then be used
        ; for the pattern a village gets destoryed in.

        jsl rlGetEventLocationEntryID
        and #$0003
        asl a
        sta wR2

        ldx wEventLocationEntry,b
        sep #$20
        lda lChapterEventDataPointer+2,b
        pha
        rep #$20
        plb

        jsl rlGetEventLocationEntryOriginXCoordinate
        clc
        adc structChapterLocationEntry.XPosition,b,x
        and #$00FF
        sta wR0

        jsl rlGetEventLocationEntryOriginYCoordinate
        clc
        adc structChapterLocationEntry.YPosition,b,x
        and #$00FF
        sta wR1

        jsl rlGetEventLocationMoneyReward
        dec a
        sta wR13

        lda #500
        sta wR14
        jsl $80A1AB

        lda wR13
        cmp #9
        bcs +

          asl wR13
          phk
          plb
          ldx wR2
          lda aVillageDestroyedPatterns,x
          clc
          adc wR13
          tax

          lda aVillageDestroyedPatterns,x
          beq +

            jsl $86C6E8

        +
        jsl rlCheckIfVillageClosed
        bcc _End

          phk
          plb
          lda #<>aVillageClosedTiles
          jsl $86C6E8

        _End
        rts

        .databank 0

      aVillageClosedTiles ; 87/F096

        .byte 3, 2
        .word $FFFF, $FFFF, $FFFF
        .word $FFFF, $00B3, $FFFF

      aVillageDestroyedPatterns ; 87/F0A4

        .word aVillageDestroyedPattern1States - aVillageDestroyedPatterns
        .word aVillageDestroyedPattern2States - aVillageDestroyedPatterns
        .word aVillageDestroyedPattern3States - aVillageDestroyedPatterns
        .word aVillageDestroyedPattern4States - aVillageDestroyedPatterns

      aVillageDestroyedPattern1States ; 87/F0AC

        .word <>aVillageDestroyedPattern1State9Tiles
        .word <>aVillageDestroyedPattern1State8Tiles
        .word <>aVillageDestroyedPattern1State7Tiles
        .word <>aVillageDestroyedPattern1State6Tiles
        .word <>aVillageDestroyedPattern1State5Tiles
        .word <>aVillageDestroyedPattern1State4Tiles
        .word <>aVillageDestroyedPattern1State3Tiles
        .word <>aVillageDestroyedPattern1State2Tiles
        .word <>aVillageDestroyedPattern1State1Tiles

      aVillageDestroyedPattern1State1Tiles ; 87/F0BE

        .byte 3, 2
        .word $FFFF, $0007, $FFFF
        .word $FFFF, $FFFF, $FFFF

      aVillageDestroyedPattern1State2Tiles ; 87/F0CC

        .byte 3, 2
        .word $FFFF, $00BF, $FFFF
        .word $FFFF, $FFFF, $FFFF

      aVillageDestroyedPattern1State3Tiles ; 87/F0DA

        .byte 3, 2
        .word $FFFF, $00BF, $FFFF
        .word $FFFF, $FFFF, $0006

      aVillageDestroyedPattern1State4Tiles ; 87/F0E8

        .byte 3, 2
        .word $FFFF, $00BF, $FFFF
        .word $FFFF, $FFFF, $009F

      aVillageDestroyedPattern1State5Tiles ; 87/F0F6

        .byte 3, 2
        .word $FFFF, $00BF, $FFFF
        .word $0007, $FFFF, $009F

      aVillageDestroyedPattern1State6Tiles ; 87/F104

        .byte 3, 2
        .word $FFFF, $00BF, $FFFF
        .word $00BF, $FFFF, $009F

      aVillageDestroyedPattern1State7Tiles ; 87/F112

        .byte 3, 2
        .word $FFFF, $00BF, $0006
        .word $00BF, $FFFF, $009F

      aVillageDestroyedPattern1State8Tiles ; 87/F120

        .byte 3, 2
        .word $FFFF, $00BF, $009F
        .word $00BF, $FFFF, $009F

      aVillageDestroyedPattern1State9Tiles ; 87/F12E

        .byte 3, 2
        .word $0006, $00BF, $009F
        .word $00BF, $FFFF, $009F

      aVillageDestroyedPattern2States ; 87/F13C

        .word <>aVillageDestroyedPattern2State9Tiles
        .word <>aVillageDestroyedPattern2State8Tiles
        .word <>aVillageDestroyedPattern2State7Tiles
        .word <>aVillageDestroyedPattern2State6Tiles
        .word <>aVillageDestroyedPattern2State5Tiles
        .word <>aVillageDestroyedPattern2State4Tiles
        .word <>aVillageDestroyedPattern2State3Tiles
        .word <>aVillageDestroyedPattern2State2Tiles
        .word <>aVillageDestroyedPattern2State1Tiles

      aVillageDestroyedPattern2State1Tiles ; 87/F14E

        .byte 3, 2
        .word $FFFF, $FFFF, $FFFF
        .word $FFFF, $FFFF, $0006

      aVillageDestroyedPattern2State2Tiles ; 87/F15C

        .byte 3, 2
        .word $FFFF, $FFFF, $FFFF
        .word $FFFF, $FFFF, $009F

      aVillageDestroyedPattern2State3Tiles ; 87/F16A

        .byte 3, 2
        .word $FFFF, $FFFF, $FFFF
        .word $0007, $FFFF, $009F

      aVillageDestroyedPattern2State4Tiles ; 87/F178

        .byte 3, 2
        .word $FFFF, $FFFF, $FFFF
        .word $00BF, $FFFF, $009F

      aVillageDestroyedPattern2State5Tiles ; 87/F186

        .byte 3, 2
        .word $FFFF, $FFFF, $0006
        .word $00BF, $FFFF, $009F

      aVillageDestroyedPattern2State6Tiles ; 87/F194

        .byte 3, 2
        .word $FFFF, $FFFF, $009F
        .word $00BF, $FFFF, $009F

      aVillageDestroyedPattern2State7Tiles ; 87/F1A2

        .byte 3, 2
        .word $0006, $FFFF, $009F
        .word $00BF, $FFFF, $009F

      aVillageDestroyedPattern2State8Tiles ; 87/F1B0

        .byte 3, 2
        .word $009F, $FFFF, $009F
        .word $00BF, $FFFF, $009F

      aVillageDestroyedPattern2State9Tiles ; 87/F1BE

        .byte 3, 2
        .word $009F, $0007, $009F
        .word $00BF, $FFFF, $009F

      aVillageDestroyedPattern3States ; 87/F1CC

        .word <>aVillageDestroyedPattern3State9Tiles
        .word <>aVillageDestroyedPattern3State8Tiles
        .word <>aVillageDestroyedPattern3State7Tiles
        .word <>aVillageDestroyedPattern3State6Tiles
        .word <>aVillageDestroyedPattern3State5Tiles
        .word <>aVillageDestroyedPattern3State4Tiles
        .word <>aVillageDestroyedPattern3State3Tiles
        .word <>aVillageDestroyedPattern3State2Tiles
        .word <>aVillageDestroyedPattern3State1Tiles

      aVillageDestroyedPattern3State1Tiles ; 87/F1DE

        .byte 3, 2
        .word $FFFF, $FFFF, $FFFF
        .word $0007, $FFFF, $FFFF

      aVillageDestroyedPattern3State2Tiles ; 87/F1EC

        .byte 3, 2
        .word $FFFF, $FFFF, $FFFF
        .word $00BF, $FFFF, $FFFF

      aVillageDestroyedPattern3State3Tiles ; 87/F1FA

        .byte 3, 2
        .word $FFFF, $FFFF, $0006
        .word $00BF, $FFFF, $FFFF

      aVillageDestroyedPattern3State4Tiles ; 87/F208

        .byte 3, 2
        .word $FFFF, $FFFF, $009F
        .word $00BF, $FFFF, $FFFF

      aVillageDestroyedPattern3State5Tiles ; 87/F216

        .byte 3, 2
        .word $0006, $FFFF, $009F
        .word $00BF, $FFFF, $FFFF

      aVillageDestroyedPattern3State6Tiles ; 87/F224

        .byte 3, 2
        .word $009F, $FFFF, $009F
        .word $00BF, $FFFF, $FFFF

      aVillageDestroyedPattern3State7Tiles ; 87/F232

        .byte 3, 2
        .word $009F, $0007, $009F
        .word $00BF, $FFFF, $FFFF

      aVillageDestroyedPattern3State8Tiles ; 87/F240

        .byte 3, 2
        .word $009F, $00BF, $009F
        .word $00BF, $FFFF, $FFFF

      aVillageDestroyedPattern3State9Tiles ; 87/F24E

        .byte 3, 2
        .word $009F, $00BF, $009F
        .word $00BF, $FFFF, $0006

      aVillageDestroyedPattern4States ; 87/F25C

        .word <>aVillageDestroyedPattern4State9Tiles
        .word <>aVillageDestroyedPattern4State8Tiles
        .word <>aVillageDestroyedPattern4State7Tiles
        .word <>aVillageDestroyedPattern4State6Tiles
        .word <>aVillageDestroyedPattern4State5Tiles
        .word <>aVillageDestroyedPattern4State4Tiles
        .word <>aVillageDestroyedPattern4State3Tiles
        .word <>aVillageDestroyedPattern4State2Tiles
        .word <>aVillageDestroyedPattern4State1Tiles

      aVillageDestroyedPattern4State1Tiles ; 87/F26E

        .byte 3, 2
        .word $FFFF, $FFFF, $0006
        .word $FFFF, $FFFF, $FFFF

      aVillageDestroyedPattern4State2Tiles ; 87/F27C

        .byte 3, 2
        .word $FFFF, $FFFF, $009F
        .word $FFFF, $FFFF, $FFFF

      aVillageDestroyedPattern4State3Tiles ; 87/F28A

        .byte 3, 2
        .word $0006, $FFFF, $009F
        .word $FFFF, $FFFF, $FFFF

      aVillageDestroyedPattern4State4Tiles ; 87/F298

        .byte 3, 2
        .word $009F, $FFFF, $009F
        .word $FFFF, $FFFF, $FFFF

      aVillageDestroyedPattern4State5Tiles ; 87/F2A6

        .byte 3, 2
        .word $009F, $0007, $009F
        .word $FFFF, $FFFF, $FFFF

      aVillageDestroyedPattern4State6Tiles ; 87/F2B4

        .byte 3, 2
        .word $009F, $00BF, $009F
        .word $FFFF, $FFFF, $FFFF

      aVillageDestroyedPattern4State7Tiles ; 87/F2C2

        .byte 3, 2
        .word $009F, $00BF, $009F
        .word $FFFF, $FFFF, $0006

      aVillageDestroyedPattern4State8Tiles ; 87/F2D0

        .byte 3, 2
        .word $009F, $00BF, $009F
        .word $FFFF, $FFFF, $009F

      aVillageDestroyedPattern4State9Tiles ; 87/F2DE

        .byte 3, 2
        .word $009F, $00BF, $009F
        .word $0007, $FFFF, $009F

      rsDestroyEventLocation ; 87/F2EC

        .al
        .autsiz
        .databank ?

        ldx wEventLocationEntry,b
        sep #$20
        lda lChapterEventDataPointer+2,b
        pha
        rep #$20
        plb

        jsl rlGetEventLocationEntryOriginXCoordinate
        clc
        adc structChapterLocationEntry.XPosition,b,x
        and #$00FF
        sta wR0

        jsl rlGetEventLocationEntryOriginYCoordinate
        clc
        adc structChapterLocationEntry.YPosition,b,x
        and #$00FF
        sta wR1

        phk
        plb
        jsl rlGetEventLocationEntryType
        jsl rlGetEventLocationTypeDestoyedTileData
        jsl $86C6E8
        rts

        .databank 0

        ; 87/F321

    .endsection LocationModificationSection


    .section LocationTypeOffsetsSection

      .al
      .xl

      rlGetEventLocationTypeOriginXOffset ; 87/F3A7

        .al
        .autsiz
        .databank `aEventLocationTypeOffsets

        phb
        php
        phk
        plb
        phx

        asl a
        tax
        lda aEventLocationTypeOffsets,x
        clc
        adc #<>aEventLocationTypeOffsets
        tax
        lda structEventLocationType.OriginXOffset,b,x
        and #$00FF

        plx
        plp
        plb
        rtl

        .databank 0

      rlGetEventLocationTypeOriginYOffset ; 87/F3C0

        .al
        .autsiz
        .databank `aEventLocationTypeOffsets

        phb
        php
        phk
        plb
        phx
        asl a
        tax

        lda aEventLocationTypeOffsets,x
        clc
        adc #<>aEventLocationTypeOffsets
        tax
        lda structEventLocationType.OriginYOffset,b,x
        and #$00FF

        plx
        plp
        plb
        rtl

        .databank 0

      rlGetEventLocationTypeModificationXOffset ; 87/F3D9

        .al
        .autsiz
        .databank `aEventLocationTypeOffsets

        phb
        php
        phk
        plb
        phx

        asl a
        tax
        lda aEventLocationTypeOffsets,x
        clc
        adc #<>aEventLocationTypeOffsets
        tax
        lda structEventLocationType.ModificationXOffset,b,x
        and #$00FF

        plx
        plp
        plb
        rtl

        .databank 0

      rlGetEventLocationTypeModificationYOffset ; 87/F3F2

        .al
        .autsiz
        .databank `aEventLocationTypeOffsets

        phb
        php
        phk
        plb
        phx

        asl a
        tax
        lda aEventLocationTypeOffsets,x
        clc
        adc #<>aEventLocationTypeOffsets
        tax
        lda structEventLocationType.ModificationYOffset,b,x
        and #$00FF

        plx
        plp
        plb
        rtl

        .databank 0

      rlGetEventLocationTypeInteractionXOffset ; 87/F40B

        .al
        .autsiz
        .databank `aEventLocationTypeOffsets

        phb
        php
        phk
        plb
        phx

        asl a
        tax
        lda aEventLocationTypeOffsets,x
        clc
        adc #<>aEventLocationTypeOffsets
        tax
        lda structEventLocationType.InteractionXOffset,b,x
        and #$00FF

        plx
        plp
        plb
        rtl

        .databank 0

      rlGetEventLocationTypeInteractionYOffset ; 87/F424

        .al
        .autsiz
        .databank `aEventLocationTypeOffsets

        phb
        php
        phk
        plb
        phx

        asl a
        tax
        lda aEventLocationTypeOffsets,x
        clc
        adc #<>aEventLocationTypeOffsets
        tax
        lda structEventLocationType.InteractionYOffset,b,x
        and #$00FF

        plx
        plp
        plb
        rtl

        .databank 0

      rlGetEventLocationTypeDestoyedTileData ; 87/F43D

        .al
        .autsiz
        .databank `aEventLocationTypeOffsets

        phb
        php
        phk
        plb
        phx

        asl a
        tax
        lda aEventLocationTypeOffsets,x
        clc
        adc #<>aEventLocationTypeOffsets
        tax
        lda structEventLocationType.DestoyedTileData,b,x

        plx
        plp
        plb
        rtl

        .databank 0

      aEventLocationTypeOffsets ; 87/F453

        .word aCastleLocationTypeData   - aEventLocationTypeOffsets
        .word aUnknown87F46B            - aEventLocationTypeOffsets
        .word aVillageLocationTypeData  - aEventLocationTypeOffsets
        .word aUnknown87F47F            - aEventLocationTypeOffsets
        .word aUnknown87F489            - aEventLocationTypeOffsets
        .word aUnknown87F493            - aEventLocationTypeOffsets
        .word aUnknown87F49D            - aEventLocationTypeOffsets

      aCastleLocationTypeData ; 87/F461

        .structEventLocationType 0, [-1, -1], [1, 2], [0, 2], aCastleDestroyedTileData

      aUnknown87F46B ; 87/F46B

        .structEventLocationType 0, [0, 0], [1, 0], [0, 1], 0

      aVillageLocationTypeData ; 87/F475

        .structEventLocationType 5000, [-1, -1], [1, 0], [0, 0], aVillageDestroyedTileData

      aUnknown87F47F ; 87/F47F

        .structEventLocationType 0, [0, 0], [0, 0], [0, 0], 0

      aUnknown87F489 ; 87/F489

        .structEventLocationType 0, [0, 0], [0, 0], [0, 0], 0

      aUnknown87F493 ; 87/F493

        .structEventLocationType 0, [0, 0], [0, 0], [0, 0], 0

      aUnknown87F49D ; 87/F49D

        .structEventLocationType 0, [0, 0], [0, 0], [0, 0], 0

      aCastleDestroyedTileData ; 87/F4A7

        .byte 3, 4 
        .word $000D, $000E, $000F
        .word $002D, $002E, $002F
        .word $000A, $000B, $000C
        .word $002A, $002B, $002C

      aVillageDestroyedTileData ; 87/F4C1

        .byte 3, 2
        .word $009F, $00BF, $009F
        .word $00BF, $009F, $009F

        ; 87/F4CF

    .endsection LocationTypeOffsetsSection
