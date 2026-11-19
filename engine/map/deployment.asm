; The deployment table: which units are on the map, their map sprites, hidden and
; defeated states, terrain under them and formation IDs.

    .section DeploymentSection

      .al
      .xl

      rlDeployUnitCheckIfAsleep ; 84/C65E

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx

        ldx wR0
        phx
        ldx wR1
        phx

        lda wDeployedUnitsCount,b
        cmp #$058B
        bcs _SEC

        jsl rlGetSelectedUnitFactionSlot
        ldx #0
        jsl rlGetFactionRelation
        sta wR0
        jsl rlGetSelectedUnitMapSprite
        sta wR1
        jsr rsAddUnitToDeploymentTable
        bcs _SEC

        tax
        jsl rlGetSelectedUnitStatus
        cmp #StatusSleep
        bne +

          lda aDeploymentTable._StateBuffer,x
          ora #DeploymentStateAsleep
          sta aDeploymentTable._StateBuffer,x
          sta aDeploymentTable._State,x

        +
        txa
        plx
        stx wR1
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
        stx wR1
        plx
        stx wR0

        plx
        plp
        plb
        sec
        bra -

        .databank 0

      rsAddUnitToDeploymentTable ; 84/C6BA

        .al
        .autsiz
        .databank ?

        ; Input:
        ; wR0 = allegiance towards player faction
        ; wR1 = map sprite ID
        ; wRoutineVariable1 = deployment coordinates

        phx
        ldx #(len(aDeploymentTable._State) - 2)

          -
          lda aDeploymentTable._UnitRAMPointer,x
          beq +

            dec x
            dec x
            bpl -

          plx
          sec
          bra _End

        +
        lda wSelectedUnitDataRAMPointer,b
        sta aDeploymentTable._UnitRAMPointer,x

        lda wRoutineVariable1,b
        and #$00FF
        sta aDeploymentTable._XTilePosition,x
        asl a
        asl a
        asl a
        asl a
        sta aDeploymentTable._XPixelPosition,x

        lda wRoutineVariable1,b
        xba
        and #$00FF
        sta aDeploymentTable._YTilePosition,x
        asl a
        asl a
        asl a
        asl a
        sta aDeploymentTable._YPixelPosition,x

        jsl rlAddDeployedMapSprite
        sta aDeploymentTable._DeploymentOffsets,x

        jsl rlGetSelectedUnitFactionSlot
        sta aDeploymentTable._FactionSlot,x

        lda wR0
        and #DeploymentAllegianceMask
        ora #DeploymentStateAlive
        sta aDeploymentTable._State,x
        sta aDeploymentTable._StateBuffer,x

        inc wDeployedUnitsCount,b

        txa
        plx
        clc

        _End
        rts

        .databank 0

      rlDeployUnit ; 84/C71F

        .al
        .autsiz
        .databank ?

        phb
        phk
        plb
        phx

        ldx wR0
        phx
        ldx wR1
        phx

        ldx wDeployedUnitsCount,b
        cpx #$058B
        bcs _SEC

        sta wR1
        lda wSelectedUnitDataRAMPointer,b
        pha

        lda wR1
        jsl rlGetUnitRAMDataPointerByID
        bcs +

          jsl rlGetSelectedUnitMapSprite
          bra ++

        +
        lda wR1
        jsl rlGetCharacterMapSprite

        +
        sta wR1
        pla
        sta wSelectedUnitDataRAMPointer,b

        lda wR0
        ldx #0
        jsl rlGetFactionRelation
        sta wR0
        jsr rsAddUnitToDeploymentTable
        bcs _SEC

        clc
        
        -
        plx
        stx wR1
        plx
        stx wR0

        plx
        plb
        rtl
        
        _SEC
        sec
        bra -

        .databank 0

      rlAddDeployedMapSprite ; 84/C76E

        .al
        .autsiz
        .databank ?

        ; Input:
        ; wR1 = Map sprite ID

        ; Output:
        ; A = map sprite offset (from the start of aDeploymentTable._MapSpriteID)

        phb
        php
        phk
        plb
        phx

        lda wR1
        bmi _Tall

          ldx #47 * 2

          -
          lda aDeploymentTable._MapSpriteID,x
          cmp wR1
          beq _End

          cmp #$FFFF
          bne +

          lda wR1
          sta aDeploymentTable._MapSpriteID,x
          bra _End

          +
          dec x
          dec x
          bpl -
          bra _Break

        _Tall
        ldx #(len(aDeploymentTable._MapSpriteID) - 2)
        
        -
        lda aDeploymentTable._MapSpriteID,x
        cmp wR1
        beq _End

        cmp #$FFFF
        bne +

        lda wR1
        sta aDeploymentTable._MapSpriteID,x
        bra _End

        +
        dec x
        dec x
        bpl -
        bra _Break

        _End
        txa
        plx
        plp
        plb
        rtl

        _Break
        brk

        .databank 0

      rlFindCharactersDeploymentOffset ; 84/C7B9

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = CharacterID to find

        ; Output:
        ; A = deployment offset if found, else $FFFF

        phb
        php
        phk
        plb
        phx
        sta wRoutineVariable1,b

        ldx #(len(aDeploymentTable._State) - 2)

          -
          lda aDeploymentTable._UnitRAMPointer,x
          sta wSelectedUnitDataRAMPointer,b
          jsl rlGetSelectedUnitCharacterID
          cmp wRoutineVariable1,b
          beq +

          dec x
          dec x
          bpl -

        lda #$FFFF
        plx
        plp
        plb
        rtl

        +
        txa
        plx
        plp
        plb
        rtl

        .databank 0

      rlLoadUNITAsHidden ; 84/C7E4

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = UNIT group ID
        ; wRoutineVariable1 = entry of UNIT group

        ; Output:
        ; X = deployment offset
        ; wR0 = CharacterID
        ; wR1 = coordinates
        ; wR2 = allegiance

        phb
        php
        phk
        plb
        phx
        phy

        pha
        lda #(`aUNITGroupPointers)<<8
        sta lR18+1
        lda #<>aUNITGroupPointers
        sta lR18
        pla

        inc a
        jsl rlGetUNITGroupPointer
        sta lR18

        lda wRoutineVariable1,b
        sta wR1

        dec a
        asl a
        asl a
        asl a
        clc
        adc lR18
        sta lR18

        ldy lR18

        sep #$20
        lda lR18+2
        pha
        rep #$20
        plb

        lda structUNITEntry.DestinationCoords,b,y
        sta wRoutineVariable1,b

        lda structUNITEntry.FactionSlot,b,y
        and #$00FF
        sta wR0

        lda structUNITEntry.CharacterID,b,y
        jsl rlGetUnitRAMDataPointerByID
        bcs +

          ; Already loaded in RAM
          jsl rlGetUnitType
          cmp #UnitTypeEnemy
          beq +

            jsl rlGetSelectedUnitDeploymentOffset
            bcs +

              tax
              jsl rlUnknown84C996
              jsl rlDeployedUnitSetAliveUnsetHidden
              bra ++

        +
        lda wR1
        sta wSelectedUnitDataRAMPointer,b
        lda structUNITEntry.CharacterID,b,y
        jsl rlDeployUnit
        bcs _SEC

        tax

        +
        jsl rlDeployedUnitSetHidden

        lda structUNITEntry.CharacterID,b,y
        sta wR0
        lda structUNITEntry.DestinationCoords,b,y
        sta wR1
        lda aDeploymentTable._State,x
        and #DeploymentAllegianceMask
        sta wR2

        txa
        ply
        plx
        plp
        plb
        clc

        -
        rtl
        
        _SEC
        ply
        plx
        plp
        plb
        sec
        bra -

        .databank 0

      rlUnknown84C87A ; 84/C87A

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = CharacterID
        ; X = FactionSlot
        ; wRoutineVariable1 = DestinationCoords

        ; Output:
        ; wR2 = allegiance
        ; Always CLC ?

        phb
        php
        phk
        plb
        phx

        sta wR0
        stx wR2

        lda wRoutineVariable1,b
        sta wR1

        lda wR0
        jsl rlGetUnitRAMDataPointerByID
        bcs _NotLoaded

        jsl rlGetSelectedUnitDeploymentOffset
        bcs _NotDeployed
        bra +

          _NotLoaded
          lda wR0
          jsl rlLoadUnit

          _NotDeployed
          lda wR2
          jsl rlAssignUnitToFactionSlot

        +
        jsl rlDeploySelectedUnit

        ldx wRoutineVariable1,b
        jsl rlDeployedUnitSetHidden
        txa
        jsl rlGetTerrainTypeByDeploymentOffset
        cmp #TerrainCastle
        beq +

          jsl rlGetSelectedUnitStates
          bit #UnitStateGuardingCastle
          beq ++

            jsl rlUnknown84BA6F
            bra ++

        ; is on castle terrain
        +
        jsl rlUnknown84CFBF
        
        +
        lda aDeploymentTable._State,x
        and #DeploymentAllegianceMask
        sta wR2

        txa
        plx
        plp
        plb
        clc
        
        -
        rtl

        plx
        plp
        plb
        sec
        bra -

        .databank 0

      rlGetTerrainTypeByDeploymentOffset ; 84/C8E1

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx

        tax
        lda aDeploymentTable._YTilePosition,x
        xba
        lsr a
        lsr a
        clc
        adc aDeploymentTable._XTilePosition,x
        asl a
        tax
        lda aMapData,x
        and #$03FF
        tax
        lda aTerrainTileset,x
        and #$00FF
        cmp #$001A
        bcc +

          lda #0

        +
        plx
        plp
        plb
        rtl

        .databank 0

      rlUnknown84C910 ; 84/C910

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        tax

        lda aDeploymentTable._XTilePosition,x
        sta wR0
        lda aDeploymentTable._YTilePosition,x
        sta wR1
        jsl rlUnknown88BF37
        tax
        lda aMapData,x
        and #$FC00
        xba
        lsr a
        lsr a

        plx
        plp
        plb
        rtl

        .databank 0

      rlGetFormationIDByDeploymentOffset ; 84/C935

        .al
        .autsiz
        .databank ?

        lda aDeploymentTable._State+1,x
        and #DeploymentFormationID
        rtl

        .databank 0

      rlSetFormationIDByDeploymentOffset ; 84/C93D

        .al
        .autsiz
        .databank ?

        sep #$20
        and #DeploymentFormationID
        sta aDeploymentTable._State+1,x
        sta aDeploymentTable._StateBuffer+1,x
        rep #$20
        rtl

        .databank 0

      rlUnknown84C94C ; 84/C94C

        .al
        .autsiz
        .databank ?

        ; Input:
        ; X = deployment offset
        ; $00 = X coordinate
        ; $02 = Y coordinate

        phb
        php
        phk
        plb

        lda wEventLocationEntry,b
        pha

        lda aDeploymentTable._XTilePosition,x
        sta $7E492B
        lda aDeploymentTable._YTilePosition,x
        sta $7E492D

        lda wR0
        sta aDeploymentTable._XTilePosition,x
        asl a
        asl a
        asl a
        asl a
        sta aDeploymentTable._XPixelPosition,x

        lda wR1
        sta aDeploymentTable._YTilePosition,x
        asl a
        asl a
        asl a
        asl a
        sta aDeploymentTable._YPixelPosition,x

        stz $0580,b

        jsl rlCheckIfCoordsNotEventLocationTile
        bcs +

          lda wEventLocationEntry,b
          sta $0580,b

        +
        pla
        sta wEventLocationEntry,b

        plp
        plb
        rtl

        .databank 0

      rlUnknown84C996 ; 84/C996

        .al
        .autsiz
        .databank ?

        ; Updates units position in the deployment tables?

        ; Input:
        ; wRoutineVariable1 = destination coordinates

        phb
        php
        phk
        plb

        lda wR0
        pha
        lda wR1
        pha

        lda wRoutineVariable1,b
        bmi +

          and #$00FF
          sta wR0
          lda wRoutineVariable1+1,b
          and #$00FF
          sta wR1
          jsl rlUnknown84C94C

        +
        pla
        sta wR1
        pla
        sta wR0

        plp
        plb
        rtl

        .databank 0

      rlUnknown84C9BF ; 84/C9BF

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb

        lda wR0
        pha
        lda wR1
        pha

        lda wRoutineVariable1,b
        bmi +

          sta wUnitRelocationLocationID,b
          stx wUnitRelocationDeploymentOffset,b
          lda #0
          sta wUnitRelocationType,b

        +
        pla
        sta wR1
        pla
        sta wR0

        plp
        plb
        rtl

        .databank 0

      rlUnknown84C9E3 ; 84/C9E3

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        lda aDeploymentTable._State,x
        bit #DeploymentStateAlive
        beq ++

        lda aDeploymentTable._State,x
        bit #(DeploymentStateAsleep | DeploymentStateDefeated | DeploymentStateCanto)
        bne ++

        lda aDeploymentTable._StateBuffer,x
        bit #DeploymentStateAsleep
        bne ++

        lda #SkillIDCanto
        jsl rlCheckIfUnitHasSpecifiedPersonalOrClassSkill
        bcs +

        lda #SkillIDCanto
        jsl rlCheckIfInventoryItemsHaveSpecifiedSkill
        bcc ++

        +
        jsr rsUnknown84CA22
        bcc +

        plp
        plb
        sec
        
        -
        rtl
        
        +
        plp
        plb
        clc
        bra -

        .databank 0

      rsUnknown84CA22 ; 84/CA22

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        lda wR2
        pha

        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b

        phx
        lda aDeploymentTable._XTilePosition,x
        sec
        sbc $7E492B
        clc
        adc #32
        sta wR2

        lda aDeploymentTable._YTilePosition,x
        sec
        sbc $7E492D
        clc
        adc #32
        asl a
        asl a
        asl a
        asl a
        asl a
        asl a
        clc
        adc wR2
        tax
        lda aMovementMap,x
        plx
        and #$00FF
        beq +

          jsl rlSetSelectedUnitCantoMovement

          lda #UnitStateCanto
          jsl rlSetSelectedUnitStates

          lda aDeploymentTable._StateBuffer,x
          ora #DeploymentStateCanto
          sta aDeploymentTable._StateBuffer,x

          lda aDeploymentTable._State,x
          ora #DeploymentStateCanto
          sta aDeploymentTable._State,x

          lda #$0004
          tsb wUnknown000D79,b

          pla
          sta wR2
          plp
          plb
          sec

          -
          rts

        +
        pla
        sta wR2
        plp
        plb
        clc
        bra -

        .databank 0

      rlUnknown84CA97 ; 84/CA97

        .al
        .autsiz
        .databank ?

        lda aDeploymentTable._StateBuffer,x
        and #~DeploymentStateGrayed
        sta aDeploymentTable._StateBuffer,x

        lda #$0004
        tsb wUnknown000D79,b
        rtl

        .databank 0

      rlUnknown84CAA9 ; 84/CAA9

        .al
        .autsiz
        .databank ?

        lda wSelectedUnitDataRAMPointer,b
        pha
        lda wRoutineVariable1,b
        pha

        lda aDeploymentTable._UnitRAMPointer,x
        bne +

          jml _End
        
        +
        lda aDeploymentTable._State,x
        bit #DeploymentStateDefeated
        beq +

          jml _End

        +
        txa
        jsl rlGetTerrainTypeByDeploymentOffset
        cmp #TerrainCastle
        bne +

          jsl rlUnknown84CFBF
          bra _CB24

        +
        lda wUnknown000D79,b
        bit #$0040
        bne _CB18

          lda $0580,b
          beq _CB24

          sta wEventLocationEntry,b

          lda aDeploymentTable._State,x
          bit #DeploymentStateAlive
          beq _CB24

          jsl rlGetEventLocationEntryID
          sta wRoutineVariable1,b

          lda aDeploymentTable._FactionSlot,x
          jsl rlGetFactionSlotLocationID
          cmp wRoutineVariable1,b
          bne _CB24

          jsl rlUnknown84D4A2
          bcs +

            jml _End

          +
          lda wRoutineVariable1,b
          jsl rlSetUnitResidingInCastle
          bra _CB24
        
        _CB18
        lda aDeploymentTable._FactionSlot,x
        jsl rlGetFactionSlotLocationID
        jsl rlUnknown84CD8A

        _CB24
        lda aDeploymentTable._StateBuffer,x
        ora #DeploymentStateGrayed
        bit #DeploymentStateAlive
        beq +

          and #~DeploymentStateHidden

        +
        sta aDeploymentTable._StateBuffer,x

        lda #$0004
        tsb wUnknown000D79,b

        jsl rlUnknown85E897

        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b

        lda #UnitStateMoved
        jsl rlSetSelectedUnitStates

        lda #$1000
        tsb wUnknown000D79,b

        lda aDeploymentTable._State,x
        bit #DeploymentStateCanto
        beq +

          lda #0
          jsl rlSetSelectedUnitCantoMovement

          lda #UnitStateCanto
          jsl rlUnsetSelectedUnitStates

          lda aDeploymentTable._StateBuffer,x
          and #~DeploymentStateCanto
          sta aDeploymentTable._StateBuffer,x

        +
        stx $0D8B,b
        
        _End
        pla
        sta wRoutineVariable1,b
        pla
        sta wSelectedUnitDataRAMPointer,b
        rtl

        .databank 0

      rlDeployedUnitUnsetHiddenIfAlive ; 84/CB83

        .al
        .autsiz
        .databank ?

        ; X = deployment offset

        lda wUnknown000D79,b
        bit #$0004
        bne +

          lda aDeploymentTable._StateBuffer,x
          bit #DeploymentStateAlive
          beq ++

            and #~DeploymentStateHidden
            sta aDeploymentTable._StateBuffer,x
            sta aDeploymentTable._State,x
            rtl

        +
        lda aDeploymentTable._State,x
        bit #DeploymentStateAlive
        beq +

          and #~DeploymentStateHidden
          sta aDeploymentTable._State,x
          lda aDeploymentTable._StateBuffer,x
          and #~DeploymentStateHidden
          sta aDeploymentTable._StateBuffer,x

        +
        rtl

        .databank 0

      rlDeployedUnitSetHidden ; 84/CBBC

        .al
        .autsiz
        .databank ?

        ; X = deployment offset

        lda wUnknown000D79,b
        bit #$0004
        bne +

          lda aDeploymentTable._StateBuffer,x
          ora #DeploymentStateHidden
          sta aDeploymentTable._StateBuffer,x
          sta aDeploymentTable._State,x
          rtl

        +
        lda aDeploymentTable._State,x
        ora #DeploymentStateHidden
        sta aDeploymentTable._State,x
        lda aDeploymentTable._StateBuffer,x
        ora #DeploymentStateHidden
        sta aDeploymentTable._StateBuffer,x
        rtl

        .databank 0

      rlDeployedUnitSetAliveUnsetHidden ; 84/CBEB

        .al
        .autsiz
        .databank ?

        ; X = deployment offset

        lda aDeploymentTable._StateBuffer,x
        ora #DeploymentStateAlive
        and #~DeploymentStateHidden
        sta aDeploymentTable._StateBuffer,x
        sta aDeploymentTable._State,x
        rtl

        .databank 0

      rlDeployedUnitSetHiddenUnsetAlive ; 84/CBFE

        .al
        .autsiz
        .databank ?

        ; X = deployment offset

        lda aDeploymentTable._StateBuffer,x
        and #~DeploymentStateAlive
        ora #DeploymentStateHidden
        sta aDeploymentTable._StateBuffer,x
        sta aDeploymentTable._State,x
        rtl

        .databank 0

      rlDeployedUnitSetDefeated ; 84/CC11

        .al
        .autsiz
        .databank ?

        ; A = deployment offset

        phx
        sta wUnitRelocationDeploymentOffset,b
        tax
        lda aDeploymentTable._StateBuffer,x
        ora #DeploymentStateDefeated
        sta aDeploymentTable._StateBuffer,x
        sta aDeploymentTable._State,x
        plx
        rtl

        .databank 0

      rlClearUnitDeploymentData ; 84/CC27

        .al
        .autsiz
        .databank ?

        ; Input:
        ; X = deployment offset

        phb
        php
        phk
        plb
        phx
        tax
        lda #0
        sta aDeploymentTable._StateBuffer,x
        sta aDeploymentTable._XTilePosition,x
        sta aDeploymentTable._YTilePosition,x
        sta aDeploymentTable._XPixelPosition,x
        sta aDeploymentTable._YPixelPosition,x
        sta aDeploymentTable._DeploymentOffsets,x
        sta aDeploymentTable._UnitRAMPointer,x
        sta aDeploymentTable._FactionSlot,x
        dec wDeployedUnitsCount,b
        lda #$0004
        tsb wUnknown000D79,b
        plx
        plp
        plb
        rtl

        .databank 0

        ; 84/CC5D

    .endsection DeploymentSection
