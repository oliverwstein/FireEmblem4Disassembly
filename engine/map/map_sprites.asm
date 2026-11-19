; Map sprites: the active sprite for a unit on the map, moving map sprites and
; their movement sounds, and hiding, revealing or flickering a faction's units.
; The unknown routines here sit among them in the ROM.

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
                sta aMovingMapSprites.wUnknown0017CC,b,x

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


    .section MapSpriteCodeSection

      .al
      .xl

      aASMapSpriteCode ; 81/89E0

        ; Active sprite code for map sprites (asMapSprite). Command $0F
        ; points the code back at itself and calls rlUnknown8189F3, so this
        ; one command runs every frame.

        .byte $0F

      rsUnknown8189E1 ; 81/89E1

        .al
        .xl
        .autsiz
        .databank ?

        ; Nothing in the disassembled code refers to this. It is a variant of
        ; rsActiveSpriteCommand0F that backs up one more byte.

        dec y
        dec y
        tya
        sta aActiveSpriteSystem.aCodeOffset,b,x
        lda #1
        sta aActiveSpriteSystem.aFrameTimer,b,x
        jsl rlUnknown8189F3
        pla
        rts

        .databank 0

    .endsection MapSpriteCodeSection


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

          jsr rsUnknown818EAB
          bcs _SEC

        +
        bit #$0100
        beq +

          jsr rsUnknown818EB3
          bcs _SEC

        +
        bit #$0800
        beq +

          jsr rsUnknown818EBB
          bcs _SEC

        +
        bit #$0400
        beq +

          jsr rsUnknown818EC3
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


    .section FillMovingMapSpriteDataPathScriptPointerSection

      .al
      .xl

      rsFillMovingMapSpriteDataPathScriptPointer ; 81/90BF

        .al
        .autsiz
        .databank ?

        ldy #6
        lda lR19
        sta [lR18],y
        inc y
        lda lR19+1
        sta [lR18],y
        rts

        .databank 0

        ; 81/90CC

    .endsection FillMovingMapSpriteDataPathScriptPointerSection


    .section ProcCycleFlickerUnitsOfFactionSlotSection

      .al
      .xl

      rlProcCycleFlickerUnitsOfFactionSlot ; 87/C0AA

        .al
        .autsiz
        .databank ?

        ; Input:
        ; aProcSystem.aBody1 = FactionSlot

        lda aProcSystem.aBody1,b,x
        sta aProcSystem.wInput0,b

        lda wVBlankEnabledFramecount
        bit #$0001
        beq +

        jsl rlRevealUnitsOfFactionSlot
        bra _End

        +
        jsl rlHideUnitsOfFactionSlot

        _End
        rtl

        .databank 0

      rlProcUnknown87C056Cycle3 ; 87/C0C2

        .al
        .autsiz
        .databank ?

        jsl rlProcEngineFreeProc
        lda #$0012
        sta wGameStateRoutine1,b
        jsl rlUnknown87C205
        jsl rlUnknown87C1E1
        rtl

        .databank 0

      rlUnknown87C0D5 ; 87/C0D5

        .al
        .autsiz
        .databank ?

        lda #$0021
        jsl rlUnknown80900D
        rtl

        .databank 0

      rlHideUnitsOfFactionSlot ; 87/C0DD

        .al
        .autsiz
        .databank ?

        ; Input:
        ; aProcSystem.wInput0 = FactionSlot

        phx
        ldx #(len(aDeploymentTable._State) - 2)
        
          _Loop
          lda aDeploymentTable._State,x
          bit #DeploymentStateAlive
          beq _Next

            lda aDeploymentTable._FactionSlot,x
            cmp aProcSystem.wInput0,b
            bne _Next

              jsl rlDeployedUnitSetHidden

          _Next
          dec x
          dec x
          bpl _Loop

        plx
        rtl

        .databank 0

      rlRevealUnitsOfFactionSlot ; 87/C0FD

        .al
        .autsiz
        .databank ?

        ; Input:
        ; aProcSystem.wInput0 = FactionSlot

        phx
        ldx #(len(aDeploymentTable._State) - 2)
        
          _Loop
          lda aDeploymentTable._State,x
          bit #DeploymentStateAlive
          beq _Next

            lda aDeploymentTable._FactionSlot,x
            cmp aProcSystem.wInput0,b
            bne _Next

              jsl rlDeployedUnitUnsetHiddenIfAlive

          _Next
          dec x
          dec x
          bpl _Loop

        plx
        rtl

        .databank 0

      rlUnknown87C11D ; 87/C11D

        .al
        .autsiz
        .databank ?

        ; Checks if the factions home castle was captured?

        lda wEventLocationEntry,b
        pha

        lda aProcSystem.aBody1,b,x
        jsl rlGetFactionSlotLocationID
        jsl rlGetLocationEventDataEntry
        jsl rlGetLocationFactionSlotOwner
        cmp aProcSystem.aBody1,b,x
        bne +

          pla
          sta wEventLocationEntry,b
          clc
          rtl

        +
        pla
        sta wEventLocationEntry,b
        sec
        rtl

        .databank 0

      rlUnknown87C141 ; 87/C141

        .al
        .autsiz
        .databank ?

        ; Returns 1 if after capturing a castle any of their units
        ; that are visible on the screen need to be faded out.
        ; Returns 0 otherwise

        phb
        php
        phk
        plb
        phx
        phy
        ldx wSelectedUnitDataRAMPointer,b
        phx

        jsl rlGetFactionSlotOffsetWrapper
        bcs _End

          lda wMapScrollXPixels,b
          lsr a
          lsr a
          lsr a
          lsr a
          sta aProcSystem.wInput0,b
          lda wMapScrollYPixels,b
          lsr a
          lsr a
          lsr a
          lsr a
          sta aProcSystem.wInput1,b

          lda $7E0000 + structFactionHeader.UnitCount,x
          and #$00FF
          beq _NoUnits

            tay

              _Loop
              phx
              lda $7E0000 + size(structFactionHeader),x
              sta wSelectedUnitDataRAMPointer,b
              jsl rlGetSelectedUnitDeploymentOffset
              bcs _Next

                tax
                lda aDeploymentTable._State,x
                bit #DeploymentStateAlive
                beq _Next

                  bit #DeploymentStateHidden
                  bne _Next

                    lda aDeploymentTable._XTilePosition,x
                    cmp aProcSystem.wInput0,b
                    bmi _Next

                      lda aDeploymentTable._XTilePosition,x
                      sec
                      sbc #16
                      cmp aProcSystem.wInput0,b
                      bpl _Next

                        lda aDeploymentTable._YTilePosition,x
                        cmp aProcSystem.wInput1,b
                        bmi _Next

                          lda aDeploymentTable._YTilePosition,x
                          sec
                          sbc #16 - 2
                          cmp aProcSystem.wInput1,b
                          bpl _Next

                            plx
                            lda #1
                            bra _End

              _Next
              plx
              inc x
              inc x
              dec y
              bne _Loop

          _NoUnits
          lda #0

        _End
        plx
        stx wSelectedUnitDataRAMPointer,b
        ply
        plx
        plp
        plb
        rtl

        .databank 0

      rlUnknown87C1D0 ; 87/C1D0

        .al
        .autsiz
        .databank ?

        lda aProcSystem.aBody1,b,x
        jsl rlUnloadFactionSlot
        jsl rlGetVictoryThemeIfAllEnemiesDead
        bcc +

          sta $0DAB,b

        +
        rtl

        .databank 0

      rlUnknown87C1E1 ; 87/C1E1

        .al
        .autsiz
        .databank ?

        ; aProcSystem.aBody0 = LocationID
        ; aProcSystem.aBody2 = New owner

        lda $08,x
        cmp #$01C6
        beq +

          lda #1
          sta bEventActionIdentifier,b
          lda aProcSystem.aBody2,b,x
          sta wEventEngineArgument1,b
          lda aProcSystem.aBody0,b,x
          sta wEventEngineArgument2,b
          jsl rlGetAndRunChapterMapEventConditions
          bcs +

            jsl rlUnknown81AB26

        +
        rtl

        .databank 0

      rlUnknown87C205 ; 87/C205

        .al
        .autsiz
        .databank ?

        lda aProcSystem.aBody2,b,x
        bne +

          stz wUnitRelocationDeploymentOffset,b
          lda #5
          sta wUnitRelocationType,b
          lda aProcSystem.aBody0,b,x
          and #$00FF
          sta wUnitRelocationLocationID,b

        +
        rtl

        .databank 0

        ; 87/C21D














      aProcUnknown87C056Code ; 87/C21D

        PROC_YIELD 32
        PROC_CALL rlUnknown87C0D5
        PROC_SET_ONCYCLE rlProcCycleFlickerUnitsOfFactionSlot
        PROC_YIELD 64
        PROC_CALL rlHideUnitsOfFactionSlot
        PROC_SET_ONCYCLE rlProcUnknown87C056Cycle
        PROC_YIELD 16

        _C235
        PROC_CALL rlUnknown87C1D0

        _C23A
        PROC_YIELD 16
        PROC_CALL rlUnknown888410
        PROC_YIELD 1
        PROC_SET_ONCYCLE rlProcUnknown87C056Cycle3
        PROC_HALT

      procFactionSlotUnitDeath ; 87/C249

        .structProcInfo "DU", rlProcUnknown87C249Init, rlProcUnknown87C249Cycle, aProcUnknown87C249Code

      rlProcUnknown87C249Init ; 87/C251

        .al
        .autsiz
        .databank ?

        lda aProcSystem.wInput0,b
        sta aProcSystem.aBody0,b,x
        lda aProcSystem.wInput1,b
        sta aProcSystem.aBody1,b,x
        lda aProcSystem.wInput2,b
        sta aProcSystem.aBody2,b,x
        lda #3
        sta aProcSystem.aBody3,b,x
        lda #0
        sta aProcSystem.aBody4,b,x
        jsl rlUnknown87C2FA

        lda aProcSystem.wInput3,b
        bne +

          jsl rlProcEngineFreeProc
          bra ++

          +
          stz wGameStateRoutine1,b

        +
        rtl

        .databank 0

      rlProcUnknown87C249Cycle ; 87/C282

        .al
        .autsiz
        .databank ?

        lda aProcSystem.aBody0,b,x
        sta aProcSystem.wInput0,b
        lda aProcSystem.aBody1,b,x
        sta aProcSystem.wInput1,b
        lda aProcSystem.aBody2,b,x
        sta aProcSystem.wInput2,b
        rtl

        .databank 0

      rlProcFactionSlotUnitDeathCycle2 ; 87/C295

        .al
        .autsiz
        .databank ?

        jsl rlProcUnknown87C249Cycle

        lda aProcSystem.aBody4,b,x
        beq ++

          cmp aProcSystem.aBody3,b,x
          bcc +

            lda #$FFFF
            sta aProcSystem.aBody4,b,x

          +
          jsl rlUnknown87C2FA
          bra ++

        +
        jsl rlUnknown87C2B7

        +
        inc aProcSystem.aBody4,b,x
        rtl

        .databank 0

      rlUnknown87C2B7 ; 87/C2B7

        .al
        .autsiz
        .databank ?

        ; Input:
        ; aProcSystem.wInput0 = FactionSlot
        ; aProcSystem.wInput1 = AI setting, if $FFFF ignored
        ; aProcSystem.wInput2 = CharacterID, if $FFFF ignored

        phx
        ldx #(len(aDeploymentTable._State) - 2)
        
          _Loop
          lda aDeploymentTable._State,x
          bit #DeploymentStateAlive
          beq _Next

            lda aDeploymentTable._FactionSlot,x
            cmp aProcSystem.wInput0,b
            bne _Next

              lda aDeploymentTable._UnitRAMPointer,x
              sta wSelectedUnitDataRAMPointer,b

              lda aProcSystem.wInput1,b
              bmi +

                jsl rlGetSelectedUnitAI
                cmp aProcSystem.wInput1,b
                bne _Next

              +
              lda aProcSystem.wInput2,b
              bmi +

                jsl rlGetSelectedUnitCharacterID
                cmp aProcSystem.wInput2,b
                bne _Next

              +
              jsl rlDeployedUnitSetHidden

          _Next
          dec x
          dec x
          bpl _Loop

        plx
        rtl

        .databank 0

      rlUnknown87C2FA ; 87/C2FA

        .al
        .autsiz
        .databank ?

        ; Input:
        ; aProcSystem.wInput0 = FactionSlot
        ; aProcSystem.wInput1 = AI setting, if $FFFF ignored
        ; aProcSystem.wInput2 = CharacterID, if $FFFF ignored

        ; Output:
        ; aProcSystem.wInput3 = count

        phx
        stz aProcSystem.wInput3,b
        ldx #(len(aDeploymentTable._State) - 2)

          _Loop
          lda aDeploymentTable._State,x
          bit #DeploymentStateAlive
          beq _Next

            lda aDeploymentTable._FactionSlot,x
            cmp aProcSystem.wInput0,b
            bne _Next

              lda aDeploymentTable._UnitRAMPointer,x
              sta wSelectedUnitDataRAMPointer,b

              lda aProcSystem.wInput1,b
              bmi +

                jsl rlGetSelectedUnitAI
                cmp aProcSystem.wInput1,b
                bne _Next

              +
              lda aProcSystem.wInput2,b
              bmi +

                jsl rlGetSelectedUnitCharacterID
                cmp aProcSystem.wInput2,b
                bne _Next

              +
              jsl rlDeployedUnitUnsetHiddenIfAlive
              inc aProcSystem.wInput3,b

          _Next
          dec x
          dec x
          bpl _Loop

        plx
        rtl

        .databank 0

      rlProcFactionSlotUnitDeathCycle3 ; 87/C343

        .al
        .autsiz
        .databank ?

        jsl rlProcEngineFreeProc
        jsl rlUnknown81AB3F

        lda #$0012
        sta wGameStateRoutine1,b
        rtl

        .databank 0

      rlUnknown87C352 ; 87/C352

        .al
        .autsiz
        .databank ?

        lda #2
        sta aProcSystem.aBody3,b,x
        rtl

        .databank 0

      rlUnknown87C359 ; 87/C359

        .al
        .autsiz
        .databank ?

        lda #1
        sta aProcSystem.aBody3,b,x
        rtl

        .databank 0

      aProcUnknown87C249Code ; 87/C360

        PROC_YIELD 4
        PROC_CALL rlUnknown87C0D5
        PROC_SET_ONCYCLE rlProcFactionSlotUnitDeathCycle2
        PROC_YIELD 16
        PROC_CALL rlUnknown87C352
        PROC_YIELD 8
        PROC_CALL rlUnknown87C359
        PROC_YIELD 8
        PROC_SET_ONCYCLE rlProcUnknown87C249Cycle
        PROC_CALL rlUnknown87C2B7
        PROC_YIELD 8
        PROC_SET_ONCYCLE rlProcFactionSlotUnitDeathCycle3
        PROC_HALT

        ; 87/C38C

    .endsection ProcCycleFlickerUnitsOfFactionSlotSection


    .section GetMapSpriteMovementSoundSection

      .al
      .xl

      rlGetMapSpriteMovementSound ; 88/C13E

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = MapSpriteID

        ; Output:
        ; A = movement sound

        phb
        php
        phk
        plb
        phk
        plb
        bit #$8000
        beq _Short

        ; Tall
        and #$7FFF
        tax
        lda aTallMapSpriteMovementSounds,x
        bra _End

        _Short
        tax
        lda aShortMapSpriteMovementSounds,x
        bra _End
        
        _End
        and #$00FF
        plp
        plb
        rtl

        .databank 0

      aShortMapSpriteMovementSounds ; 88/C160

        .byte 1 ; MageFemale
        .byte 1 ; Mage
        .byte 1 ; PriestFemale
        .byte 1 ; JuniorLord
        .byte 1 ; Myrmidon
        .byte 2 ; LanceArmor
        .byte 1 ; Barbarian
        .byte 1 ; Archer
        .byte 2 ; Soldier
        .byte 1 ; ArcherFemale
        .byte 2 ; AxeArmor
        .byte 1 ; BowSoldier
        .byte 1 ; Dancer
        .byte 1 ; MyrmidonFemale
        .byte 1 ; Princess
        .byte 1 ; Thief
        .byte 2 ; General
        .byte 1 ; Priestess
        .byte 1 ; Fighter
        .byte 1 ; WindMage
        .byte 1 ; WindMageFemale
        .byte 1 ; Priest
        .byte 1 ; Hunter
        .byte 1 ; Swordmaster
        .byte 1 ; Hero
        .byte 1 ; Warrior
        .byte 1 ; Brigang
        .byte 1 ; Pirate
        .byte 1 ; HeroFemale
        .byte 2 ; Baron
        .byte 1 ; HighPriestFemale
        .byte 1 ; SwordmasterFemale
        .byte 1 ; SniperFemale
        .byte 1 ; Sniper
        .byte 2 ; Emperor
        .byte 1 ; SwordSoldier
        .byte 1 ; AxeSoldier
        .byte 2 ; SpearSoldier
        .byte 2 ; SwordArmor
        .byte 2 ; BowArmor
        .byte 1 ; FireMageFemale
        .byte 1 ; FireMage
        .byte 1 ; ThunderMageFemale
        .byte 1 ; ThunderMage
        .byte 1 ; HighPriest
        .byte 1 ; WarMageFemale
        .byte 1 ; DarkBishop
        .byte 1 ; DarkMage
        .byte 1 ; Prince
        .byte 1 ; WarMage
        .byte 1 ; ChildFemale
        .byte 1 ; Child
        .byte 1 ; Queen
        .byte 1 ; Bishop
        .byte 1 ; Civilian
        .byte 1 ; CivilianFemale
        .byte 1 ; RogueFemale
        .byte 1 ; Bard
        .byte 1 ; ThiefFemale
        .byte 1 ; Rogue
        .byte 1 ; Sage
        .byte 1 ; SageFemale
        .byte 1 ; DarkPrince
        .byte 1 ; SmallOifey

      aTallMapSpriteMovementSounds ; 88/C1A0

        .byte 5 ; DragonRider
        .byte 3 ; Cavalier
        .byte 5 ; DukeKnight
        .byte 4 ; PegasusRider
        .byte 3 ; AxeKnight
        .byte 3 ; FreeKnight
        .byte 3 ; LanceKnight
        .byte 3 ; BowKnight
        .byte 4 ; KnightLordSeliph
        .byte 3 ; Troubadour
        .byte 4 ; KnightLordSigurd
        .byte 4 ; Paladin
        .byte 5 ; DragonMaster
        .byte 4 ; ArchKnight
        .byte 4 ; GreatKnight
        .byte 4 ; MageKnight
        .byte 5 ; DragonKnight
        .byte 5 ; PegasusKnight
        .byte 5 ; FalconKnight
        .byte 4 ; MasterKnight
        .byte 4 ; Ranger
        .byte 0 ; Ballistician
        .byte 0 ; IronBallistician
        .byte 0 ; KillerBallistician
        .byte 0 ; GreatBallistician
        .byte 5 ; DragonRiderFemale
        .byte 5 ; DragonKnightFemale
        .byte 5 ; DragonMasterFemale
        .byte 4 ; PaladinFemale
        .byte 4 ; MageKnightFemale
        .byte 4 ; MasterKnightFemale

        ; 88/C1BF

    .endsection GetMapSpriteMovementSoundSection


    .section MovingMapSpriteAppendDecompSection

      .al
      .xl

      rsMovingMapSpriteAppendDecomp ; 88/D67C

        .al
        .autsiz
        .databank ?

        lda lR18
        pha
        lda lR18+1
        pha
        phx
        phk
        plb

        lda aMovingMapSpritesMapSprites,b,x
        and #$8000
        bne +

          ; Short map sprites
          lda aMovingMapSpritesMapSprites,b,x
          phx
          and #$7FFF
          sta wR0
          clc
          adc wR0
          clc
          adc wR0
          tax

          lda aMapMovementShortSpritePointers,x
          sta lR18
          lda aMapMovementShortSpritePointers+1,x
          sta lR18+1
          plx

          jsr (aSetMovingMapSpriteBufferPointers,x)
          jsl rlAppendDecompList

          plx
          pla
          sta lR18+1
          pla
          sta lR18
          rtl

        ; Tall map sprite
        +
        lda aMovingMapSpritesMapSprites,b,x
        phx
        and #$7FFF
        sta wR0
        clc
        adc wR0
        clc
        adc wR0
        tax

        lda aMapMovementTallSpritePointers,x
        sta lR18
        lda aMapMovementTallSpritePointers+1,x
        sta lR18+1
        plx

        jsr (aSetMovingMapSpriteBufferPointers,x)
        jsl rlAppendDecompList

        plx
        pla
        sta lR18+1
        pla
        sta lR18
        rtl

        .databank 0

    .endsection MovingMapSpriteAppendDecompSection


    .section SetMovingMapSpriteBufferPointersSection

      .al
      .xl

      aSetMovingMapSpriteBufferPointers ; 88/D6E5

        .word <>rsSetMovingMapSpriteBuffer0
        .word <>rsSetMovingMapSpriteBuffer1
        .word <>rsSetMovingMapSpriteBuffer2
        .word <>rsSetMovingMapSpriteBuffer3

      rsSetMovingMapSpriteBuffer0 ; 88/D6ED

        .al
        .autsiz
        .databank ?

        lda #(`aMovingMapSpriteBuffers[0])<<8
        sta lR19+1
        lda #<>aMovingMapSpriteBuffers[0]
        sta lR19
        rts

        .databank 0

      rsSetMovingMapSpriteBuffer1 ; 88/D6F8

        .al
        .autsiz
        .databank ?

        lda #(`aMovingMapSpriteBuffers[0])<<8
        sta lR19+1
        lda #<>aMovingMapSpriteBuffers[0]
        sta lR19

        lda lR19
        clc
        adc #size(aMovingMapSpriteBuffers[0])
        sta lR19
        rts

        .databank 0

      rsSetMovingMapSpriteBuffer2 ; 88/D70B

        .al
        .autsiz
        .databank ?

        lda #(`aMovingMapSpriteBuffers[0])<<8
        sta lR19+1
        lda #<>aMovingMapSpriteBuffers[0]
        sta lR19

        lda lR19
        clc
        adc #size(aMovingMapSpriteBuffers[0]) * 2
        sta lR19
        rts

        .databank 0

      rsSetMovingMapSpriteBuffer3 ; 88/D71E

        .al
        .autsiz
        .databank ?

        lda #(`aMovingMapSpriteBuffers[0])<<8
        sta lR19+1
        lda #<>aMovingMapSpriteBuffers[0]
        sta lR19

        lda lR19
        clc
        adc #size(aMovingMapSpriteBuffers[0]) * 3
        sta lR19
        rts

        .databank 0

        ; 88/D731

    .endsection SetMovingMapSpriteBufferPointersSection


    .section Unsorted818A4ASection

      .al
      .xl

      rsUnknown818A4A ; 81/8A4A

        .al
        .autsiz
        .databank ?

        lda aActiveSpriteSystem.aUnknown001300,b,y
        cmp #9
        bne +

          lda #8
          bra _End

        +
        lda aMovingMapSprites.wSpeed,b,x
        cmp #8
        bcc _End

          lda #4
          bra _End

            lda #6

        _End
        rts

        .databank 0

      rsUnknown818A68 ; 81/8A68

        .al
        .autsiz
        .databank $81

        ; Reads scripted movement paths

        lda aActiveSpriteSystem.aUnknown0012E0,b,y
        bit #$0010
        beq +

          ; If set, unload unit as soon as they are offscreen
          jsr rsUnknown818C98
          bcc +

            ; Character is not visible
            jsl rlUnknown818B76
            sec
            rts

        +
        jsr rsUnknown818CBF

        lda aActiveSpriteSystem.aUnknown001320,b,y
        beq +

          clc
          rts

        +
        sty lR19

        lda aMovingMapSprites.wPathScriptAddress,b,x
        sta lR18
        lda aMovingMapSprites.wPathScriptBank,b,x
        sta lR18+1
        lda aMovingMapSprites.wPathScriptOffset,b,x
        tay
        
          _Loop
          lda [lR18],y
          and #$00FF
          cmp #$0080
          bne +

            jsl rlUnknown818B76
            sec
            rts

          +
          bit #$0080
          beq rsUnknown818AD8

          phy
          and #$007F
          asl a
          tay
          lda aScriptedMovementPointers,y
          sta lR20
          lda aScriptedMovementPointers+1,y
          sta lR20+1
          ply
          inc y
          jsl +
          bcc _Loop

        rts

        +
        jmp (lR20)

        .databank 0

      aScriptedMovementPointers ; 81/8AC6

        .word <>rlUnknown818B76
        .word <>rlUnknown818B5D
        .word <>rlUnknown818BF0
        .word <>rlUnknown818BF9
        .word <>rlUnknown818C13
        .word <>rlUnknown818C5D
        .word <>rlUnknown818C62
        .word <>rlUnknown818C67
        .word <>rlUnknown818C6C

      rsUnknown818AD8 ; 81/8AD8

        .al
        .autsiz
        .databank ?

        ldy #1
        sty wR0

        ldy lR19
        cmp #10
        bcc +

          sbc #9
          pha
          phy
          inc y
          lda aMovingMapSprites.wPathScriptOffset,b,x
          inc a
          sta aMovingMapSprites.wPathScriptOffset,b,x
          tay
          lda [lR18],y
          and #$00FF
          sta wR0
          ply
          pla

        +
        cmp #9
        beq +

          cmp aActiveSpriteSystem.aUnknown001300,b,y
          beq +

            pha
            dec a
            asl a
            asl a
            asl a
            sta wUnknown000911,x
            lda #0
            sta wUnknown0008F1,x
            lda #0
            sta wUnknown000901,x
            pla

        +
        sta aActiveSpriteSystem.aUnknown001300,b,y

        lda aMovingMapSprites.wPathScriptOffset,b,x
        inc a
        sta aMovingMapSprites.wPathScriptOffset,b,x

        phx
        jsr rsUnknown818A4A
        tax
        lda aUnknown818B54,x
        and #$00FF
        xba
        ora wR0
        jsl rlUnsignedMultiply8By8
        sta aActiveSpriteSystem.aUnknown001320,b,y
        plx

        lda aActiveSpriteSystem.aUnknown001300,b,y
        cmp #4
        beq +

          lda #1
          sta aActiveSpriteSystem.aFrameTimer,b,y

        +
        lda #0
        sta aActiveSpriteSystem.aUnknown001340,b,y
        clc
        rts

        .databank 0

      aUnknown818B54 ; 81/8B54

        .byte $80
        .byte $80
        .byte $40
        .byte $20
        .byte $10
        .byte $08
        .byte $04
        .byte $02
        .byte $01

      rlUnknown818B5D ; 81/8B5D

        .al
        .autsiz
        .databank ?

        phy
        tya
        sta aMovingMapSprites.wPathScriptOffset,b,x

        lda aMovingMapSprites.wActiveSpriteOffset,b,x
        tay

        lda aActiveSpriteSystem.aUnknown0012E0,b,y
        and #~$8000
        sta aActiveSpriteSystem.aUnknown0012E0,b,y

        jsl rlUnknown818D58
        ply
        sec
        rtl

        .databank 0

      rlUnknown818B76 ; 81/8B76

        .al
        .autsiz
        .databank ?

        phy
        lda aMovingMapSprites.wActiveSpriteOffset,b,x
        tay

        jsr rsUnknown818B91

        lda #$FFFF
        sta aMovingMapSprites.wActiveSpriteOffset,b,x
        lda #0
        sta aActiveSpriteSystem.aTypeOffset,b,y

        jsl rlUnknown818D58
        ply
        sec
        rtl

        .databank 0

      rsUnknown818B91 ; 81/8B91

        .al
        .autsiz
        .databank ?

        lda aActiveSpriteSystem.aUnknown0012E0,b,y
        bit #$000E
        beq _8BEF

          phx
          phy
          bit #$0008
          bne +

            lda aMovingMapSprites.wUnknown0017CC,b,x
            tax
            jsl rlDeployedUnitUnsetHiddenIfAlive
            bra _End

          +
          lda aMovingMapSprites.wUnknown001814,b,x
          sta wR1
          lda aMovingMapSprites.wXPixelPosition,b,x
          sta wR2
          lda aMovingMapSprites.wYPixelPosition,b,x
          sta wR3
          phx
          lda aMovingMapSprites.wUnknown0017CC,b,x
          tax
          lda wR2
          sta aDeploymentTable._XPixelPosition,x
          lda wR3
          sta aDeploymentTable._YPixelPosition,x
          phx
          jsl rlAddDeployedMapSprite
          plx
          sta aDeploymentTable._DeploymentOffsets,x
          plx
          lda aMovingMapSprites.wUnknown001804,b,x
          xba
          lsr a
          dec a
          ora #$0080
          and #$FFBF
          sta wR0
          lda aMovingMapSprites.wUnknown0017CC,b,x
          tax
          lda wR0
          sta aDeploymentTable._State,x

          _End
          ply
          plx

        _8BEF
        rts

        .databank 0

      rlUnknown818BF0 ; 81/8BF0

        .al
        .autsiz
        .databank ?

        lda #0
        sta aMovingMapSprites.wPathScriptOffset,b,x
        tay
        clc
        rtl

        .databank 0

      rlUnknown818BF9 ; 81/8BF9

        .al
        .autsiz
        .databank ?

        lda [lR18],y
        sta aMovingMapSprites.wPathScriptAddress,b,x
        pha
        inc y
        lda [lR18],y
        sta aMovingMapSprites.wPathScriptBank,b,x
        sta lR18+1
        pla
        sta lR18
        lda #0
        sta aMovingMapSprites.wPathScriptOffset,b,x
        tay
        clc
        rtl

        .databank 0

      rlUnknown818C13 ; 81/8C13

        .al
        .autsiz
        .databank ?

        phx
        lda [lR18],y
        and #$00FF
        sta aMovingMapSprites.wSpeed,b,x
        asl a
        sta wR0
        inc y
        tya
        sta aMovingMapSprites.wPathScriptOffset,b,x

        lda aMovingMapSprites.wActiveSpriteOffset,b,x
        tay
        ldx wR0
        lda aUnknown818C45,x
        sta aActiveSpriteSystem.aUnknown001380,b,y
        lda aUnknown818C51,x
        sta aActiveSpriteSystem.aUnknown0013A0,b,y
        lda #9
        sta aActiveSpriteSystem.aUnknown001300,b,y
        plx
        lda aMovingMapSprites.wPathScriptOffset,b,x
        tay
        clc
        rtl

        .databank 0

      aUnknown818C45 ; 81/8C45

        .word $0000
        .word $2000
        .word $4000
        .word $8000
        .word $0000
        .word $0000

      aUnknown818C51 ; 81/8C51

        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $0001
        .word $0002

    .endsection Unsorted818A4ASection


    .section Unsorted818C5DSection

      .al
      .xl

      rlUnknown818C5D ; 81/8C5D

        .al
        .autsiz
        .databank ?

        lda #1
        bra +

      rlUnknown818C62 ; 81/8C62

        .al
        .autsiz
        .databank ?

        lda #2
        bra +

      rlUnknown818C67 ; 81/8C67

        .al
        .autsiz
        .databank ?

        lda #3
        bra +

      rlUnknown818C6C ; 81/8C6C

        .al
        .autsiz
        .databank ?

        lda #4

        +
        sta wR0

        tya
        sta aMovingMapSprites.wPathScriptOffset,b,x

        lda aMovingMapSprites.wActiveSpriteOffset,b,x
        tay

        lda wR0
        pha

        dec a
        asl a
        asl a
        asl a
        sta wUnknown000911,x
        lda #0
        sta wUnknown0008F1,x
        lda #0
        sta wUnknown000901,x

        pla
        sta aActiveSpriteSystem.aUnknown001300,b,y
        sec
        rtl

        .databank 0

    .endsection Unsorted818C5DSection


    .section Unsorted818C98Section

      .al
      .xl

      rsUnknown818C98 ; 81/8C98

        .al
        .autsiz
        .databank ?

        ; Check if moving character is not visible
        ; SEC if yes, CLC if no

        lda aMovingMapSprites.wXPixelPosition,b,x
        sec
        sbc wMapScrollXPixels,b
        cmp #$FFF0
        bcs +

        cmp #$0100
        bcs _SEC

        +
        lda aMovingMapSprites.wYPixelPosition,b,x
        sec
        sbc wMapScrollYPixels,b
        cmp #$FFF0
        bcs +

        cmp #$0100
        bcs _SEC

        +
        clc
        bra +

        _SEC
        sec
        
        +
        rts

        .databank 0

      rsUnknown818CBF ; 81/8CBF

        .al
        .autsiz
        .databank ?

        ; Guess: X panned moving sound effects

        php
        phx
        phy
        lda aMovingMapSprites.wXPixelPosition,b,x
        sec
        sbc wMapScrollXPixels,b
        bmi +

        cmp #16 * 16
        bcc _Continue

        lda #$00FF
        bra _Continue

        +
        lda #0
        bra _Continue

        _Continue
        jsl rlUnknown818CE2
        ply
        plx
        plp
        rts

        .databank 0

      rlUnknown818CE2 ; 81/8CE2

        .al
        .autsiz
        .databank ?

        php
        phx
        phy

        tay
        lda aMovingMapSprites.wMovingSound,b,x
        and #$FF00
        bne +

          jsr rsUnknown818D23
          bra _End

        +
        xba
        dec a
        bne +

        sep #$20
        sty $04CB,b
        lda #0
        sta $04CC,b
        rep #$20
        ldx #0
        jsl rlUnknown809933
        bra _End

        +
        sep #$20
        sty $04CE,b
        lda #0
        sta $04CF,b
        rep #$20
        ldx #3
        jsl rlUnknown809933

        _End
        ply
        plx
        plp
        rtl

        .databank 0

        ; 81/8D23

    .endsection Unsorted818C98Section


    .section Unsorted818D23Section

      .al
      .xl

      rsUnknown818D23 ; 81/8D23

        .al
        .xl
        .autsiz
        .databank ?

        lda $04BA,b
        bne _8D57
        phx
        stz wR0
        ldx #$0000

        _8D2E
        lda aMovingMapSprites.wMovingSound,b,x
        and #$FF00
        ora wR0
        sta wR0
        inc x
        inc x
        cpx #$0008
        bne _8D2E
        plx
        lda wR0
        cmp #$0300
        beq _8D57
        phx
        lda aMovingMapSprites.wMovingSound,b,x
        jsl rlUnknown91C472
        plx
        sta aMovingMapSprites.wMovingSound,b,x
        jsl rlUnknown91C4CE

        _8D57
        rts

        .databank 0

        ; 81/8D58

    .endsection Unsorted818D23Section


