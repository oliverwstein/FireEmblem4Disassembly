; Factions: faction slots, groups and their relations to each other.

    .section FactionSection

      .al
      .xl

      rlInitiateFactionRAMData ; 84/BB9A

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx

        lda #0
        sta aFactionArea

        ; IDs 0~6 get default data

        lda #(`aFactionArea)<<8
        sta lR18+1
        lda #<>aFactionArea
        sta lR18
        lda #(`aDefaultFactionData)<<8
        sta lR19+1
        lda #<>aDefaultFactionData
        sta lR19
        lda #size(aDefaultFactionData)
        sta wR0
        ldx #7

        -
        jsl rlAddOffsetTableEntry

        dec x
        bne -

        plx
        plp
        plb
        rtl

        .databank 0

      aDefaultFactionData .block ; 84/BBCD

          .structFactionHeader $80, $FF, 0, 0, 0

        .bend

      rlLoadFactionGroup ; 84/BBD2

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = faction
        ; wRoutineVariable1 = faction group ID

        phb
        php
        phk
        plb
        phx
        phy

        sta wR0

        jsr rsGetFactionSlotOffset
        bcc +

          jml _End

        +
        lda $7E0000,x
        and #$00FF
        cmp #$0080
        bne +

          ; faction entry is free

          lda wLoadedFactionCount,b
          cmp #7
          bcs +

            inc wLoadedFactionCount,b

        +
        lda wRoutineVariable1,b
        jsl rlGetFactionGroupPointerByID

        sep #$20
        lda wRoutineVariable1,b
        cmp $7E0000,x
        beq +

          sta $7E0000,x
          rep #$20

        +
        sep #$20
        lda #0
        sta $7E0002,x
        sta $7E0003,x
        rep #$20

        phy
        lda structFactionGroupData.LocationsPointer,b,y
        beq +

          tay
          lda $0000,b,y ; location ID
          sta $7E0000+1,x

          -
          lda $0000,b,y
          bmi +

            jsl rlGetLocationEventDataEntry

            lda wR0
            jsl rlSetLocationFactionSlotOwner
            inc y
            inc y
            bra -

        +
        ply
        phy
        lda structFactionGroupData.UnitsPointer,b,y
        beq _UnitsDone

          tay

          -
          lda $0000,b,y
          bmi _UnitsDone

          sta wRoutineVariable1,b
          jsl rlGetUnitRAMDataPointerByID
          bcs _NotLoaded

            jsl rlGetSelectedUnitFactionSlot
            cmp wR0
            bne +
            bra _Next

            _NotLoaded
            lda wRoutineVariable1,b
            jsl rlLoadUnit

            +
            lda wR0
            jsl rlAssignUnitToFactionSlot

            lda $7E0000 + 1,x
            jsl rlGetEventLocationEntryCoordinatesByID
            sta wRoutineVariable1,b

            jsl rlUnknown84AEC0

          _Next
          inc y
          inc y
          bra -

        _UnitsDone
        ply
        ldy #1
        
          -
          sty wRoutineVariable1,b
          lda wR0
          jsl rlGetUnitRAMDataPointerByFactionSlotEntryID

          lda wSelectedUnitDataRAMPointer,b
          beq _End

          phx
          lda $7E0000 + 1,x
          and #$001F

          pha
          jsl rlGetSelectedUnitDeploymentOffset
          tax
          pla

          jsl rlSetUnitResidingInCastle
          plx
          inc y
          bra -

        _End
        ply
        plx
        plp
        plb
        rtl

        .databank 0

      rlUnloadFactionSlot ; 84/BCAF

        .al
        .autsiz
        .databank ?

        ; Deletes all units in the specified faction slot, unless they are dynamic, then set them
        ; as factionless.
        ; Afterwards reset the faction header back to the default values.

        ; Input:
        ; A = FactionSlot

        phb
        php
        phk
        plb
        phx
        ldx wR1
        phx

        sta wR1
        jsl rlGetFactionSlotNameID
        cmp #$0080
        beq _End

          ldx #1

            _Loop
            stx wRoutineVariable1,b
            lda wR1
            jsl rlGetUnitRAMDataPointerByFactionSlotEntryID
            lda wSelectedUnitDataRAMPointer,b
            beq _Continue

              jsl rlGetUnitType
              cmp #UnitTypeDynamic
              beq +

                jsl rlDeleteUnit
                bra _Next

              +
              lda #Factionless
              jsl rlSetSelectedUnitFaction

              _Next
              inc x
              bra _Loop

          _Continue
          lda wR1
          bne +

            ; is player FactionSlot
            lda #1
            jsl rlUnknown81B32C

          +
          lda #(`aFactionArea)<<8
          sta lR18+1
          lda #<>aFactionArea
          sta lR18
          lda #(`aEmptyFactionSlotHeader)<<8
          sta lR19+1
          lda #<>aEmptyFactionSlotHeader
          sta lR19
          lda #size(aEmptyFactionSlotHeader)
          sta wR0
          lda wR1
          inc a
          jsl rlUpdateOffsetTable

        _End
        plx
        stx wR1
        plx
        plp
        plb
        rtl

        .databank 0

        .byte 0

      aEmptyFactionSlotHeader .block ; 84/BD1F

          .structFactionHeader $80, $FF, 0, 0, 0

        .bend

      rsGetFactionSlotOffset ; 84/BD24

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = FactionSlot

        ; Output:
        ; X = Faction offset

        cmp #Factionless
        bcs +

          asl a
          tax
          lda aFactionArea,x
          clc
          adc #<>aFactionArea
          tax
          clc
          rts

        +
        rts

        .databank 0

      rlGetFactionSlotOffsetWrapper ; 84/BD37

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = FactionSlot

        ; Output:
        ; X = Faction offset

        jsr rsGetFactionSlotOffset
        rtl

        .databank 0

      rsGetFactionSlotGroupPointer ; 84/BD3B

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = FactionSlot

        ; Output:
        ; Y = Faction group pointer

        jsr rsGetFactionSlotOffset
        bcs _SEC

          lda $7E0000 + structFactionHeader.GroupID,x
          and #$00FF
          cmp #$0080
          beq _SEC

            cmp #$00FF
            beq _SEC

              jsl rlGetFactionGroupPointerByID

              clc
              rts

        _SEC
        sec
        rts

        .databank 0

      rlSetFactionSlotGroupID ; 84/BD59

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = FactionSlot
        ; wRoutineVariable1 = faction group ID

        phb
        php
        phk
        plb
        phx

        jsr rsGetFactionSlotOffset
        bcs +

          sep #$20
          lda wRoutineVariable1,b
          cmp $7E0000 + structFactionHeader.GroupID,x
          beq +

            sta $7E0000 + structFactionHeader.GroupID,x
            rep #$20

        +
        plx
        plp
        plb
        rtl

        .databank 0

      rlGetFactionSlotNameID ; 84/BD78

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = FactionSlot

        ; Output:
        ; A = Faction name ID

        phb
        php
        phk
        plb
        phx
        phy

        jsr rsGetFactionSlotGroupPointer
        bcs +

        lda structFactionGroupData.FactionNameID,b,y
        and #$00FF

        -
        ply
        plx
        plp
        plb
        rtl

        +
        lda #$FFFF
        bra -

        .databank 0

      rlGetFactionSlotNamePointer ; 84/BD93

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = FactionSlot

        ; Output:
        ; lRoutineVariable = Faction name pointer

        phb
        php
        phk
        plb
        phx
        phy

        jsr rsGetFactionSlotOffset
        bcs _None

          lda $7E0000 + structFactionHeader.GroupID,x
          and #$00FF
          cmp #$0080
          beq _None

            jsl rlGetFactionGroupPointerByID

            lda structFactionGroupData.FactionNameID,b,y
            and #$00FF
            cmp #$0080
            beq _None

              cmp #$00FF
              beq _NPC

                asl a
                clc
                adc aMainDataOffsets.FactionNameOffsets
                tax
                lda #(`aMainDataOffsets)<<8
                sta lRoutineVariable+1,b
                lda aMainDataOffsets,x
                clc
                adc aMainDataOffsets.FactionNameOffsets
                adc #<>aMainDataOffsets
                sta lRoutineVariable,b
                bra +

        _None
        lda #(`aFactionNameNone)<<8
        sta lRoutineVariable+1,b
        lda #<>aFactionNameNone
        sta lRoutineVariable,b
        bra +

        _NPC
        lda #(`aFactionNameNPC)<<8
        sta lRoutineVariable+1,b
        lda #<>aFactionNameNPC
        sta lRoutineVariable,b

        +
        ply
        plx
        plp
        plb
        rtl

        .databank 0

      aFactionNameNone ; 84/BDFB

        .enc "SJIS"
        .text "　\n"

      aFactionNameNPC ; 84/BDFF

        .text "ＮＰＣ\n"

      rlGetFactionBattleHUDColorID ; 84/BE07

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        phy

        jsr rsGetFactionSlotGroupPointer
        bcs +

        lda structFactionGroupData.BattleHUDColorID,b,y
        and #$00FF
        
        -
        ply
        plx
        plp
        plb
        rtl

        +
        lda #7
        bra -

        .databank 0

      rlGetFactionBattleBannerID ; 84/BE22

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        phy

        jsr rsGetFactionSlotGroupPointer
        bcs +

        lda structFactionGroupData.BattleBannerID,b,y
        and #$00FF
        
        -
        ply
        plx
        plp
        plb
        rtl
        
        +
        lda #13
        bra -

        .databank 0

      rlGetFactionSlotLocationID ; 84/BE3D

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = FactionSlot

        ; Output:
        ; A = LocationID that the faction slot owns

        phb
        php
        phk
        plb
        phx

        jsr rsGetFactionSlotOffset
        bcs +

          lda $7E0000 + structFactionHeader.LocationID,x
          and #$00FF

        +
        plx
        plp
        plb
        rtl

        .databank 0

      rlGetFactionSlotUnitCount ; 84/BE52

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = FactionSlot

        ; Output:
        ; A = UnitCount

        phb
        php
        phk
        plb
        phx
        jsr rsGetFactionSlotOffset
        bcs +

          lda $7E0000 + structFactionHeader.UnitCount,x
          and #$00FF
          plx
          plp
          plb

          -
          rtl

        +
        lda #0
        plx
        plp
        plb
        bra -

        .databank 0

      rlCountUnitsInFactionSlotAlive ; 84/BE6F

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = FactionSlot

        ; Output:
        ; A = number of alive units in that faction

        phb
        php
        phk
        plb
        phx
        phy
        ldx wSelectedUnitDataRAMPointer,b
        phx
        ldx wRoutineVariable1,b
        phx

        jsr rsGetFactionSlotOffset
        bcs _End

          stz wRoutineVariable1,b
          lda $7E0000 + structFactionHeader.UnitCount,x
          and #$00FF
          beq ++

            tay

              _Loop
              lda $7E0000 + size(structFactionHeader),x
              sta wSelectedUnitDataRAMPointer,b
              jsl rlGetSelectedUnitStates
              bit #UnitStateDead
              bne +

                inc wRoutineVariable1,b

              +
              inc x
              inc x
              dec y
              bne _Loop

          +
          lda wRoutineVariable1,b

        _End
        plx
        stx wRoutineVariable1,b
        plx
        stx wSelectedUnitDataRAMPointer,b
        ply
        plx
        plp
        plb
        rtl

        .databank 0

      rlUnknown84BEB7 ; 84/BEB7

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx 
        phy

        jsr rsGetFactionSlotOffset
        bcs _End

        stz wRoutineVariable1,b
        lda $7E0004,x
        and #$00FF
        beq ++

        tay
        
        _Loop
        lda $7E0005,x
        sta $056F,b
        jsl rlGetSelectedUnitStates
        bit #$0200
        bne +

        bit #$8000
        beq +

        inc wRoutineVariable1,b
        
        +
        inc x
        inc x
        dec y
        bne _Loop
        
        +
        lda wRoutineVariable1,b
        
        _End
        ply
        plx
        plp
        plb
        rtl

        .databank 0

      rlGetUnitRAMDataPointerByFactionSlotEntryID ; 84/BEF4

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = FactionSlot
        ; wRoutineVariable1 = Entry ID in the FactionSlot

        ; Output:
        ; filled wSelectedUnitDataRAMPointer

        phb
        php
        phk
        plb
        phx
        jsr rsGetFactionSlotOffset
        bcs +

        lda $7E0000 + structFactionHeader.UnitCount,x
        and #$00FF
        cmp wRoutineVariable1,b
        bcc +

        phx
        lda wRoutineVariable1,b
        dec a
        asl a
        clc
        adc #1,s
        plx
        tax
        lda $7E0000 + size(structFactionHeader),x
        sta wSelectedUnitDataRAMPointer,b

        -
        plx
        plp
        plb
        rtl

        +
        stz wSelectedUnitDataRAMPointer,b
        bra -

        .databank 0

      rlUnknown84BF25 ; 84/BF25

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        phy
        jsr rsGetFactionSlotOffset
        bcs _End

        lda $7E0004,x
        and #$00FF
        ora #0
        beq _BF5F

        tay
        
        -
        lda $7E0005,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitCharacterID
        cmp wRoutineVariable1,b
        bne +

        lda wR10
        beq _End

        jsl rlGetSelectedUnitStates
        bit #UnitStateFielded
        beq _End
        
        +
        inc x
        inc x
        dec y
        bne -
        
        _BF5F
        stz wSelectedUnitDataRAMPointer,b
        
        _End
        ply
        plx
        plp
        plb
        rtl

        .databank 0

      rlFindGenerationIDInFactionSlotData ; 84/BF67

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = FactionSlot
        ; wRoutineVariable1 = GenerationID

        ; Output:
        ; wSelectedUnitDataRAMPointer

        phb
        php

        phk
        plb

        phx
        phy
        jsr rsGetFactionSlotOffset
        bcs _End

          lda $7E0000 + structFactionHeader.UnitCount,x
          and #$00FF
          beq +

            tay

            -
            lda $7E0000 + size(structFactionHeader),x
            sta wSelectedUnitDataRAMPointer,b
            jsl rlGetSelectedUnitGenerationID
            cmp wRoutineVariable1,b
            beq _End

              inc x
              inc x
              dec y
              bne -

          +
          stz wSelectedUnitDataRAMPointer,b
        
        _End
        ply
        plx

        plp
        plb
        rtl

        .databank 0

      rlAssignUnitToFactionSlot ; 84/BF99

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = FactionSlot

        phb
        php
        phk
        plb
        phx

        ldx wRoutineVariable1,b
        phx
        ldx wR0
        phx
        ldx lR18
        phx
        ldx lR18+1
        phx
        ldx lR19
        phx
        ldx lR19+1
        phx

        sta wRoutineVariable1,b
        jsr rsGetFactionSlotOffset
        bcs _End

          jsl rlGetSelectedUnitFactionSlot
          cmp wRoutineVariable1,b
          beq _End

            lda $7E0000 + structFactionHeader.UnitCount,x
            and #$00FF
            inc a
            sep #$20
            sta $7E0000 + structFactionHeader.UnitCount,x
            rep #$20

            asl a
            clc
            adc #size(structFactionHeader)
            sta wR0

            lda #(`aFactionArea)<<8
            sta lR18+1
            lda #<>aFactionArea
            sta lR18
            stz lR19+1
            stz lR19

            ; wRoutineVariable1 has FactionSlot

            lda wRoutineVariable1,b
            inc a
            jsl rlUpdateOffsetTable
            stx wR1

            lda $7E0000 + structFactionHeader.UnitCount,x
            and #$00FF
            asl a
            clc
            adc wR1
            tax

            lda wSelectedUnitDataRAMPointer,b
            sta $7E0000 + 3,x

            lda wRoutineVariable1,b
            jsl rlSetSelectedUnitFaction

            lda wRoutineVariable1,b
            bne _End

              ; Only for player units
              jsl rlAddToUnitJoinOrder

        _End
        pla
        sta lR19+1
        pla
        sta lR19
        pla
        sta lR18+1
        pla
        sta lR18
        pla
        sta wR0
        pla
        sta wRoutineVariable1,b

        plx
        plp
        plb
        rtl

        .databank 0

      rlRemoveSelectedUnitFromFactionSlot ; 84/C02B

        .al
        .autsiz
        .databank ?

        ; A = FactionSlot
        ; filled wSelectedUnitDataRAMPointer

        ; If faction slot is 0 aka player, also modify something based on GenerationID

        phb
        php
        phk
        plb
        phx
        phy

        ldx wRoutineVariable1,b
        phx
        ldx wR0
        phx
        ldx lR18
        phx
        ldx lR18+1
        phx

        sta wRoutineVariable1,b

        jsr rsGetFactionSlotOffset
        bcs _End

          sep #$20
          lda #`aFactionArea
          pha
          rep #$20
          plb

          lda structFactionHeader.UnitCount,b,x
          and #$00FF
          beq _End

            phx
            sta wR1
            txy
            
              -
              lda $0000 + size(structFactionHeader),b,x
              cmp wSelectedUnitDataRAMPointer,b
              bne +

                inc y
                inc y

              +
              lda $0000 + size(structFactionHeader),b,y
              sta $0000 + size(structFactionHeader),b,x
              inc y
              inc y
              inc x
              inc x
              dec wR1
              bne -

            plx
            phk
            plb

            lda $7E0000 + structFactionHeader.UnitCount,x
            and #$00FF
            dec a
            sep #$20
            sta $7E0000 + structFactionHeader.UnitCount,x
            rep #$20

            asl a
            clc
            adc #size(structFactionHeader)
            sta wR0

            lda #(`aFactionArea)<<8
            sta lR18+1
            lda #<>aFactionArea
            sta lR18
            stz lR19+1
            stz lR19

            lda wRoutineVariable1,b
            inc a
            jsl rlUpdateOffsetTable

            lda wRoutineVariable1,b
            bne _End

              jsl rlRemoveFromUnitJoinOrder

        _End
        pla
        sta lR18+1
        pla
        sta lR18
        pla
        sta wR0
        pla
        sta wRoutineVariable1,b

        ply
        plx
        plp
        plb
        rtl

        .databank 0

        ; 84/C0BD

    .endsection FactionSection


    .section FactionRelationsSection

      .al
      .xl

      rlGetFactionRelation ; 84/C15F

        .al
        .autsiz
        .databank `aFactionBitLookupTable

        ; Input:
        ; A = own FactionSlot
        ; X = target FactionSlot

        phb
        php
        phk
        plb
        phx
        phy
        cmp #3,s
        beq _OwnFaction

          txy

          jsr rsGetFactionSlotOffset
          bcs _Enemy

            lda aFactionBitLookupTable,y
            and #$00FF
            and $7E0000 + structFactionHeader.HostileFactions,x
            bne _Enemy

              lda aFactionBitLookupTable,y
              and #$00FF
              and $7E0000 + structFactionHeader.AlliedFactions,x
              bne _Neutral

                lda #AllegianceOther
                bra +

              _Neutral
              lda #AllegianceNeutral
              bra +

          _Enemy
          lda #AllegianceEnemy
          bra +

        _OwnFaction
        lda #AllegianceOwn

        +
        ply
        plx
        plp
        plb
        rtl

        .databank 0

      aFactionBitLookupTable ; 84/C19E

        .byte $01 ; 0
        .byte $02 ; 1
        .byte $04 ; 2
        .byte $08 ; 3
        .byte $10 ; 4
        .byte $20 ; 5
        .byte $40 ; 6

      rlSetFactionHostility ; 84/C1A5

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = word with a FactionSlot in high and low byte
        ; wRoutineVariable1 = routine index (1 = hostile, 2 = allies, 3 = neutral)

        phb
        php
        phk
        plb
        phx

        ldx wR0
        phx

        sta wR0

        lda wRoutineVariable1,b
        asl a
        tax

        lda wR0
        and #$00FF
        sta wRoutineVariable1,b

        lda wR0
        xba
        and #$00FF
        jsr (aSetFactionHostilitySettings,x)

        lda wR0
        xba
        and #$00FF
        sta wRoutineVariable1,b

        lda wR0
        and #$00FF
        jsr (aSetFactionHostilitySettings,x)

        pla
        sta wR0

        plx
        plp
        plb
        rtl

        .databank 0

      aSetFactionHostilitySettings ; 84/C1DD

        .word <>rsSetFactionHostilityBreak
        .word <>rsSetFactionSlotsHostilityEnemies
        .word <>rsSetFactionSlotsHostilityAllies
        .word <>rsSetFactionSlotsHostilityNeutral

      rsSetFactionHostilityBreak ; 84/C1E5

        .al
        .autsiz
        .databank ?

        brk

        .databank 0

      rsSetFactionSlotAllegiance ; 84/C1E6

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = FactionSlot
        ; wRoutineVariable1 = Allegiance

        phb
        php
        phk
        plb
        phx
        phy

        ldx wR0
        phx
        ldx wR1
        phx

        cmp #7
        bcs _End

          sta wR0

          lda wRoutineVariable1,b
          sta wR1

          ldy #1

            -
            sty wRoutineVariable1,b
            lda wR0
            jsl rlGetUnitRAMDataPointerByFactionSlotEntryID
            lda wSelectedUnitDataRAMPointer,b
            beq _End

            jsl rlGetSelectedUnitDeploymentOffset
            bcs +

              tax
              lda aDeploymentTable._StateBuffer,x
              and #~(DeploymentAllegianceMask)
              ora wR1
              sta aDeploymentTable._StateBuffer,x
              sta aDeploymentTable._State,x

            +
            inc y
            bra -

        _End
        pla
        sta wR1
        pla
        sta wR0

        ply
        plx
        plp
        plb
        rts

        .databank 0

      rsSetFactionSlotsHostilityEnemies ; 84/C235

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = first FactionSlot
        ; wRoutineVariable1 = second FactionSlot

        phb
        php
        phk
        plb
        phx
        phy

        ldx wR0
        phx

        sta wR0
        cmp #7

        ; Someone forgot a branch

        asl a
        tax
        lda aFactionArea,x
        clc
        adc #<>aFactionArea
        tay

        sep #$20
        lda #`aFactionArea
        pha
        rep #$20
        plb

        sep #$20
        ldx wRoutineVariable1,b
        lda aFactionBitLookupTable,x
        ora $0002,b,y
        sta $0002,b,y

        lda aFactionBitLookupTable,x
        eor #$FF
        and $0003,b,y
        sta $0003,b,y
        rep #$20

        lda wRoutineVariable1,b
        bne +

          lda #AllegianceEnemy
          sta wRoutineVariable1,b
          lda wR0
          jsr rsSetFactionSlotAllegiance

        +
        pla
        sta wR0

        ply
        plx
        plp
        plb
        rts

        .databank 0

      rsSetFactionSlotsHostilityAllies ; 84/C28B

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = first FactionSlot
        ; wRoutineVariable1 = second FactionSlot

        phb
        php
        phk
        plb
        phx
        phy

        ldx wR0
        phx

        sta wR0
        cmp #7
        bcs _End

          asl a
          tax
          lda aFactionArea,x
          clc
          adc #<>aFactionArea
          tay

          sep #$20
          lda #`aFactionArea
          pha
          rep #$20
          plb

          sep #$20
          ldx wRoutineVariable1,b
          lda aFactionBitLookupTable,x
          ora $0003,b,y
          sta $0003,b,y

          lda aFactionBitLookupTable,x
          eor #$FF
          and $0002,b,y
          sta $0002,b,y
          rep #$20

          lda wRoutineVariable1,b
          bne _End

            lda #AllegianceNeutral
            sta wRoutineVariable1,b
            lda wR0
            jsr rsSetFactionSlotAllegiance
        
        _End
        pla
        sta wR0

        ply
        plx
        plp
        plb
        rts

        .databank 0

      rsSetFactionSlotsHostilityNeutral ; 84/C2E3

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = first FactionSlot
        ; wRoutineVariable1 = second FactionSlot

        phb
        php
        phk
        plb
        phx
        phy

        ldx wR0
        phx

        sta wR0
        cmp #7
        bcs _End

          asl a
          tax
          lda aFactionArea,x
          clc
          adc #<>aFactionArea
          tay

          sep #$20
          lda #`aFactionArea
          pha
          rep #$20
          plb

          sep #$20
          ldx wRoutineVariable1,b
          lda aFactionBitLookupTable,x
          eor #$FF
          and $0002,b,y
          sta $0002,b,y

          lda aFactionBitLookupTable,x
          eor #$FF
          and $0003,b,y
          sta $0003,b,y
          rep #$20

          lda wRoutineVariable1,b
          bne _End

            lda #AllegianceOther
            sta wRoutineVariable1,b
            lda wR0
            jsr rsSetFactionSlotAllegiance

        _End
        pla
        sta wR0

        ply
        plx
        plp
        plb
        rts

        .databank 0

      rlUnknown84C33D ; 84/C33D

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx

        lda wCurrentTurn,b
        cmp #51
        bcs _End

          lda wActiveFactionSlot,b
          bne _End

            lda #0
            jsl rlUnknown84C412

            ldx #(9 - 1) * size(word)

              -
              lda $7E201E,x
              beq +

                sta wSelectedUnitDataRAMPointer,b
                jsl rlGetSelectedUnitGenerationID
                bcs +

                  jsr rsUnknown84C398

              +
              dec x
              dec x
              bpl -

            ldx #(len(aDeploymentTable._State) - 2)

              -
              lda aDeploymentTable._State,x
              bit #DeploymentStateAlive
              beq +

                lda aDeploymentTable._UnitRAMPointer,x
                sta wSelectedUnitDataRAMPointer,b
                jsl rlGetSelectedUnitGenerationID
                bcs +

                  cmp #$0010
                  bcc +

                    jsr rsUnknown84C3C1

              +
              dec x
              dec x
              bpl -

        _End
        plx
        plp
        plb
        rtl

        .databank 0

        ; 84/C398

    .endsection FactionRelationsSection


    .section FactionUnitsSection

      .al
      .xl

      rlUnknown84C461 ; 84/C461

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

        tay
        ldx #1
        
        -
        stx wRoutineVariable1,b
        tya
        jsl rlGetUnitRAMDataPointerByFactionSlotEntryID

        lda wSelectedUnitDataRAMPointer,b
        beq _C496

        jsl rlGetSelectedUnitStates
        bit #UnitStateGroupLeader
        beq +

        jsl rlGetSelectedUnitAI
        cmp wR0
        bne +

        jsl rlGetSelectedUnitCharacterID
        bra ++

        +
        inc x
        bra -
        
        _C496
        lda #0

        +
        plx
        stx wSelectedUnitDataRAMPointer,b
        ply
        plx
        plp
        plb
        rtl

        .databank 0

      rlUnknown84C4A2 ; 84/C4A2

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        phy
        ldx wR0
        phx
        ldx wR1
        phx

        tay
        lda #$0048
        sta wR0
        stz wR1
        ldx #1
        
          _Loop
          stx wRoutineVariable1,b
          tya
          jsl rlGetUnitRAMDataPointerByFactionSlotEntryID
          lda wSelectedUnitDataRAMPointer,b
          beq _End

            jsl rlGetSelectedUnitStates
            bit #UnitStateDead
            bne _Next

              jsl rlGetSelectedUnitGenerationID
              ora #0
              beq _Next

                cmp wR0
                bcs _Next

                  sta wR0
                  lda wSelectedUnitDataRAMPointer,b
                  sta wR1

            _Next
            inc x
            bra _Loop
        
        _End
        lda wR1
        sta wSelectedUnitDataRAMPointer,b

        pla
        sta wR1
        pla
        sta wR0
        ply
        plx
        plp
        plb
        rtl

        .databank 0

      rlAddCastleMoneyToAllUnitsInFaction ; 84/C4F6

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = FactionSlot

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

        tay
        jsl rlCountAlliedCastles
        dec a
        dec a
        sta wR10

        lda #1000
        sta wR11
        jsl rlUnsignedMultiply16By16
        lda wR12
        sta wR0

        ldx #1

          _Loop
          stx wRoutineVariable1,b
          tya
          jsl rlGetUnitRAMDataPointerByFactionSlotEntryID
          lda wSelectedUnitDataRAMPointer,b
          beq _End

            phx
            jsl rlGetSelectedUnitStates
            bit #UnitStateDead
            bne _Next

              lda wR0
              sta wRoutineVariable1,b
              jsl rlAddSelectedCharacterMoney

            _Next
            plx
            inc x
            bra _Loop

        _End
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

      rlReviveFactionsUnitsOfAISetting ; 84/C54C

        .al
        .autsiz
        .databank ?

        ; A = FactionSlot
        ; wRoutineVariable1 = AI

        phb
        php
        phk
        plb
        phx
        phy

        ldx wSelectedUnitDataRAMPointer,b
        phx
        ldx wR34
        phx

        tay
        lda wRoutineVariable1,b
        sta wR34
        ldx #1
        
          _Loop
          stx wRoutineVariable1,b
          tya
          jsl rlGetUnitRAMDataPointerByFactionSlotEntryID
          lda wSelectedUnitDataRAMPointer,b
          beq _End

            jsl rlGetSelectedUnitAI
            cmp wR34
            bne +

              jsl rlGetSelectedUnitStates
              bit #UnitStateDead
              beq +

                jsl rlReviveSelectedCharacter

          +
          inc x
          bra _Loop

        _End
        plx
        stx wR34
        plx
        stx wSelectedUnitDataRAMPointer,b

        ply
        plx
        plp
        plb
        rtl

        .databank 0

      rlDeleteFactionsUnitsOfAISetting ; 84/C593

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = FactionSlot
        ; wRoutineVariable1 = AI

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

        tay
        lda wRoutineVariable1,b
        sta wR0
        ldx #1
        
          _Loop
          stx wRoutineVariable1,b
          tya
          jsl rlGetUnitRAMDataPointerByFactionSlotEntryID
          lda wSelectedUnitDataRAMPointer,b
          beq _End

            jsl rlGetSelectedUnitAI
            cmp wR0
            bne _Next

              jsl rlUndeployUnit
              jsl rlDeleteUnit
              bra _Loop

            _Next
            inc x
            bra _Loop

        _End
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

        ; 84/C5D7

    .endsection FactionUnitsSection
