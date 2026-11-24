; Factions: faction slots, groups and their relations to each other, and the
; love points the player's women gain at the start of each player phase
; (rlAddTurnStartLovePoints).

    .section GetSelectedUnitFactionNameIDSection

      .al
      .xl

      rlGetSelectedUnitFactionNameID ; 84/9FBB

        ; Output:
        ; A = name ID of the selected unit's faction

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlGetSelectedUnitFactionSlot
        jsl rlGetFactionSlotNameID
        rtl

        .databank 0

        ; 84/9FC4

    .endsection GetSelectedUnitFactionNameIDSection


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

            jsl rlDeploySelectedUnit

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
            jsl rlStartGameOverEvent

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

      rlCountFactionFieldedLivingUnits ; 84/BEB7

        .al
        .autsiz
        .databank ?

        ; Input: A = faction slot. Output: A = how many of its units are fielded and
        ; not dead.

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
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitStates
        bit #UnitStateDead
        bne +

        bit #UnitStateFielded
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

      rlFindFactionUnitByCharacterID ; 84/BF25

        .al
        .autsiz
        .databank ?

        ; Input: A = faction slot, wRoutineVariable1 = character ID; if wR10 is not 0,
        ; the unit must be fielded. Output: wSelectedUnitDataRAMPointer, or 0.

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


    .section SetFactionSlotLocationIDSection

      .al
      .xl

      rlSetFactionSlotLocationID ; 84/C0BD

        ; Input:
        ; A = faction slot
        ; wRoutineVariable1 = location ID (home castle)

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $84
        phx
        jsr rsGetFactionSlotOffset
        bcs _C0D2
        sep #$20
        lda wRoutineVariable1,b
        sta $7E0000 + structFactionHeader.LocationID,x
        rep #$20

        _C0D2
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 84/C0D6

    .endsection SetFactionSlotLocationIDSection


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
              bne _Allied

                lda #AllegianceNeutral
                bra +

              _Allied
              lda #AllegianceAllied
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

            lda #AllegianceAllied
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

      rlAddTurnStartLovePoints ; 84/C33D

        .al
        .autsiz
        .databank ?

        ; Map step 4, at the start of the player phase before turn 51: each woman (generation ID 16 and up) of the player's faction gains love points with each man of it (rsAddLoveGrowthWithEachMan), and each living woman gains 5 more with each player man next to her (rsAddAdjacentLovePoints).

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
            jsl rlListFactionSlotUnitsByGenerationID

            ldx #(9 - 1) * size(word)

              -
              lda $7E201E,x
              beq +

                sta wSelectedUnitDataRAMPointer,b
                jsl rlGetSelectedUnitGenerationID
                bcs +

                  jsr rsAddLoveGrowthWithEachMan

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

                    jsr rsAddAdjacentLovePoints

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


    .section Unsorted84C398Section

      .al
      .xl

      rsAddLoveGrowthWithEachMan ; 84/C398

        .al
        .xl
        .autsiz
        .databank ?

        ; For the selected woman: adds her love growth (rlGetUnitLoveGrowthWithTarget) with each man listed at $7E2000 (generation IDs 1-15).

        phx
        phy
        ldy wSelectedUnitDataRAMPointer,b
        ldx #$001C

        _C3A0
        lda $7E2000,x
        beq _C3BA
        sta wRoutineVariable1,b
        sty wSelectedUnitDataRAMPointer,b
        jsl rlGetUnitLoveGrowthWithTarget
        sta wRoutineVariable1,b
        txa
        lsr a
        inc a
        jsl rlModifyUnitsLovePoints

        _C3BA
        dec x
        dec x
        bpl _C3A0
        ply
        plx
        rts

        .databank 0

        ; 84/C3C1

      rsAddAdjacentLovePoints ; 84/C3C1

        .al
        .xl
        .autsiz
        .databank ?

        ; For the woman at deployment offset X: adds 5 love points (6 minus the distance) with each living man of faction slot 0 next to her.

        phx
        phy
        stx wR0
        ldx #$008E

        _C3C8
        lda aDeploymentTable,x
        bit #$0080
        beq _C40B
        lda aDeploymentTable._FactionSlot,x
        bne _C40B
        stx wR1
        jsl rlGetUnitsDistance
        cmp #$0002
        bcs _C40B
        sta wRoutineVariable1,b
        lda #$0006
        sec
        sbc wRoutineVariable1,b
        sta wRoutineVariable1,b
        ldy wSelectedUnitDataRAMPointer,b
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitGenerationID
        bcs _C40B
        cmp #$0010
        bcs _C40B
        sty wSelectedUnitDataRAMPointer,b
        jsl rlModifyUnitsLovePoints

        _C40B
        dec x
        dec x
        bpl _C3C8
        ply
        plx
        rts

        .databank 0

        ; 84/C412

    .endsection Unsorted84C398Section


    .section Unsorted84C412Section

      .al
      .xl

      rlListFactionSlotUnitsByGenerationID ; 84/C412

        .al
        .autsiz
        .databank ?

        ; Lists the units of faction slot A at $7E2000 by generation ID: entry (ID - 1) holds the unit's RAM pointer, 0 for none (24 entries).

        ; A = FactionSlot?

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

        tay
        ldx #(24 - 1) * size(word)
        lda #0
        
          -
          sta $7E2000,x
          dec x
          dec x
          bpl -

        ldx #1
        
          -
          stx wRoutineVariable1,b
          tya
          jsl rlGetUnitRAMDataPointerByFactionSlotEntryID

          lda wSelectedUnitDataRAMPointer,b
          beq _End

            jsl rlGetSelectedUnitGenerationID
            bcs +

              phx
              dec a
              asl a
              tax
              lda wSelectedUnitDataRAMPointer,b
              sta $7E2000,x
              plx

          +
          inc x
          bra -
        
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

        ; 84/C461

    .endsection Unsorted84C412Section


    .section FactionUnitsSection

      .al
      .xl

      rlGetFactionGroupLeaderCharacterID ; 84/C461

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

      rlFindFactionUnitWithLowestGenerationID ; 84/C4A2

        .al
        .autsiz
        .databank ?

        ; Input: A = faction slot. Output: wSelectedUnitDataRAMPointer = its living unit
        ; with the lowest generation ID, or 0.

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


    .section Unsorted84C62ESection

      .al
      .xl

      rlSetFactionSlotUnitsMapAnimation ; 84/C62E

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Sets the map animation of every unit of faction slot A to wRoutineVariable1 (rlSetSelectedUnitMapAnimation).

        phb
        php
        phk
        plb
        .databank $84
        phx
        phy
        ldx wR0
        phx
        tay
        lda wRoutineVariable1,b
        sta wR0
        ldx #$0001

        _C640
        stx wRoutineVariable1,b
        tya
        jsl rlGetUnitRAMDataPointerByFactionSlotEntryID
        lda wSelectedUnitDataRAMPointer,b
        beq _C656
        lda wR0
        jsl rlSetSelectedUnitMapAnimation
        inc x
        bra _C640


        _C656
        plx
        stx wR0
        ply
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 84/C65E

    .endsection Unsorted84C62ESection
