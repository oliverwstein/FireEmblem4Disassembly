; Map sprites: event movers (aMovingMapSprites) and their movement sounds, hiding,
; revealing or flickering a faction's units, and in bank $88 the animation: every
; deployed unit drawn each VBlank (rlDrawDeployedUnitMapSprites), the standing
; frames queued eight units at a time (rlQueueStandingMapSpriteFrames) and
; uploaded with the two animated map tile sets (rlUploadMapAnimations), the moving
; unit's walking sprite, and the map sprite helpers of the unit window and status
; screen. wMapSpriteAnimationPauseFlags pauses the sprites (bit 15) or the tiles
; (bit 0). The unknown routines here sit among them in the ROM.

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
        jsr rsGetMovingMapSpriteStepShift
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
                jsl rlLoadAndDeployUnit
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
            jsr rsStepMovingMapSpritePathScript
            ply
            plx
            bcs _End

              jsr rsStepMovingMapSprite

        _End
        rtl

        .databank 0

    .endsection MapSpriteSection


    .section MapSpriteCodeSection

      .al
      .xl

      aASMapSpriteCode ; 81/89E0

        ; Active sprite code for map sprites (asMapSprite). Command $0F
        ; points the code back at itself and calls rlDrawMovingMapSprite, so this
        ; one command runs every frame.

        .byte $0F

      rsActiveSpriteCmdDrawMovingMapSpriteBack2Unused ; 81/89E1

        .al
        .xl
        .autsiz
        .databank ?

        ; Nothing in the disassembled code refers to this. It is a variant of
        ; rsActiveSpriteCommandDrawMovingMapSprite that backs up one more byte.

        dec y
        dec y
        tya
        sta aActiveSpriteSystem.aCodeOffset,b,x
        lda #1
        sta aActiveSpriteSystem.aFrameTimer,b,x
        jsl rlDrawMovingMapSprite
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

      rsCameraFollowMovingMapSprite ; 81/8E40

        .al
        .autsiz
        .databank ?

        ; Scrolls the camera in the event mover's direction at its speed (wR5), unless rsCheckMovingMapSpriteInsideMargins says it need not.

        lda wR5
        sta wMapPixelScrollDistance,b
        sta wMapScrollSpeed,b
        lda aActiveSpriteSystem.aUnknown001300,b,y
        jsr rsGetMapScrollDirectionIdentifierFromCommand
        jsr rsCheckMovingMapSpriteInsideMargins
        bcs +

          jsl rlMapScrollByDirectionBits
        
        +
        rts

        .databank 0

      rsCheckMovingMapSpriteInsideMargins ; 81/8E58

        .al
        .autsiz
        .databank ?

        ; Returns SEC when the camera need not follow the event mover: it is off screen, or it has not yet reached the margin it is heading for (direction A in joypad bits: $0100 right, $0200 left, $0400 down, $0800 up).

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

          jsr rsCheckSpriteRightOfLeftMargin
          bcs _SEC

        +
        bit #$0100
        beq +

          jsr rsCheckSpriteLeftOfRightMargin
          bcs _SEC

        +
        bit #$0800
        beq +

          jsr rsCheckSpriteBelowTopMargin
          bcs _SEC

        +
        bit #$0400
        beq +

          jsr rsCheckSpriteAboveBottomMargin
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


    .section Unreferenced819062Section

      .al
      .xl

      rlBuildMovingMapSpritePathUnused ; 81/9062

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$7E00
        sta lR18+1
        txa
        asl a
        asl a
        asl a
        asl a
        asl a
        clc
        adc #$DB88
        sta lR18
        jsr rsFillMovingMapSpriteData
        phy
        tya
        clc
        adc lR18
        sta lR18
        jsr rsInitMovingMapSpritePathHeaderUnused

        _9081
        jsr rsStepBuildMovingMapSpritePathUnused
        bcc _9081
        ply
        sty wR0
        lda lR18
        sec
        sbc wR0
        sta lR18
        plx
        rtl

        .databank 0

        ; 81/9092

    .endsection Unreferenced819062Section
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


    .section Unreferenced8190CCSection

      .al
      .xl

      rsInitMovingMapSpritePathHeaderUnused ; 81/90CC

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ldy #$0000
        lda #$0012
        sta [lR18],y
        inc y
        lda #$0004
        sta [lR18],y
        dec y
        rts

        .databank 0

        ; 81/90DC

      rsStepBuildMovingMapSpritePathUnused ; 81/90DC

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        cpy #$007F
        bne _90E5
        jml _9139


        _90E5
        ldx #$0000
        lda wR2
        cmp wR4
        beq _90EF
        inc x

        _90EF
        lda wR3
        cmp wR5
        beq _90F6
        inc x

        _90F6
        cpx #$0000
        beq _9139
        cpx #$0002
        bne _910B
        lda rlIncreaseFrameCounters
        and #$0002
        bne _9111
        beq _9125

        _910B
        lda wR2
        cmp wR4
        beq _9125

        _9111
        lda wR2
        cmp wR4
        bcc _911E
        dec wR2
        lda #$000A
        bra _9143


        _911E
        inc wR2
        lda #$000B
        bra _9143


        _9125
        lda wR3
        cmp wR5
        bcc _9132
        dec wR3
        lda #$000C
        bra _9143


        _9132
        inc wR3
        lda #$000D
        bra _9143


        _9139
        lda #$0080
        inc y
        inc y
        sta [lR18],y
        sec
        bra _9165


        _9143
        sta wR7
        lda [lR18],y
        and #$00FF
        cmp wR7
        bne _9157
        inc y
        lda [lR18],y
        inc a
        sta [lR18],y
        dec y
        bra _9164


        _9157
        lda wR7
        inc y
        inc y
        sta [lR18],y
        inc y
        lda #$0001
        sta [lR18],y
        dec y

        _9164
        clc

        _9165
        rts

        .databank 0

        ; 81/9166

    .endsection Unreferenced8190CCSection
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

      rlProcCastleTakenOverCycle3 ; 87/C0C2

        .al
        .autsiz
        .databank ?

        jsl rlProcEngineFreeProc
        lda #GAMESTATE_MAP_STEP
        sta wGameStateRoutine1,b
        jsl rlQueueSeizePopupRelocation
        jsl rlRunCastleSeizeEventOrResumeMusic
        rtl

        .databank 0

      rlPlayCastleTakenOverSound ; 87/C0D5

        .al
        .autsiz
        .databank ?

        lda #$0021
        jsl rlPlaySoundEffect2
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

      rlCheckFactionHomeCastleCaptured ; 87/C11D

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

      rlCheckFactionUnitsVisibleOnScreen ; 87/C141

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

      rlUnloadFactionAndCheckVictoryTheme ; 87/C1D0

        .al
        .autsiz
        .databank ?

        lda aProcSystem.aBody1,b,x
        jsl rlUnloadFactionSlot
        jsl rlGetVictoryThemeIfAllEnemiesDead
        bcc +

          sta wPhaseSongID,b

        +
        rtl

        .databank 0

      rlRunCastleSeizeEventOrResumeMusic ; 87/C1E1

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

            jsl rlResumePhaseMusic

        +
        rtl

        .databank 0

      rlQueueSeizePopupRelocation ; 87/C205

        .al
        .autsiz
        .databank ?

        lda aProcSystem.aBody2,b,x
        bne +

          stz wUnitRelocationDeploymentOffset,b
          lda #UNIT_RELOCATION_SEIZE_POPUP
          sta wUnitRelocationType,b
          lda aProcSystem.aBody0,b,x
          and #$00FF
          sta wUnitRelocationLocationID,b

        +
        rtl

        .databank 0

        ; 87/C21D


      aProcCastleTakenOverCode ; 87/C21D

        PROC_YIELD 32
        PROC_CALL rlPlayCastleTakenOverSound
        PROC_SET_ONCYCLE rlProcCycleFlickerUnitsOfFactionSlot
        PROC_YIELD 64
        PROC_CALL rlHideUnitsOfFactionSlot
        PROC_SET_ONCYCLE rlProcCastleTakenOverCycle
        PROC_YIELD 16

        _C235
        PROC_CALL rlUnloadFactionAndCheckVictoryTheme

        _C23A
        PROC_YIELD 16
        PROC_CALL rlRedrawVisibleMapTilemap
        PROC_YIELD 1
        PROC_SET_ONCYCLE rlProcCastleTakenOverCycle3
        PROC_HALT

      procFactionSlotUnitDeath ; 87/C249

        .structProcInfo "DU", rlProcFactionSlotUnitDeathInit, rlProcFactionSlotUnitDeathCycle, aProcFactionSlotUnitDeathCode

      rlProcFactionSlotUnitDeathInit ; 87/C251

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
        jsl rlRevealMatchingFactionUnits

        lda aProcSystem.wInput3,b
        bne +

          jsl rlProcEngineFreeProc
          bra ++

          +
          stz wGameStateRoutine1,b

        +
        rtl

        .databank 0

      rlProcFactionSlotUnitDeathCycle ; 87/C282

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

        jsl rlProcFactionSlotUnitDeathCycle

        lda aProcSystem.aBody4,b,x
        beq ++

          cmp aProcSystem.aBody3,b,x
          bcc +

            lda #$FFFF
            sta aProcSystem.aBody4,b,x

          +
          jsl rlRevealMatchingFactionUnits
          bra ++

        +
        jsl rlHideMatchingFactionUnits

        +
        inc aProcSystem.aBody4,b,x
        rtl

        .databank 0

      rlHideMatchingFactionUnits ; 87/C2B7

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

      rlRevealMatchingFactionUnits ; 87/C2FA

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
        jsl rlCheckVictoryTheme

        lda #GAMESTATE_MAP_STEP
        sta wGameStateRoutine1,b
        rtl

        .databank 0

      rlSetFactionUnitDeathFlickerRate2 ; 87/C352

        .al
        .autsiz
        .databank ?

        lda #2
        sta aProcSystem.aBody3,b,x
        rtl

        .databank 0

      rlSetFactionUnitDeathFlickerRate1 ; 87/C359

        .al
        .autsiz
        .databank ?

        lda #1
        sta aProcSystem.aBody3,b,x
        rtl

        .databank 0

      aProcFactionSlotUnitDeathCode ; 87/C360

        PROC_YIELD 4
        PROC_CALL rlPlayCastleTakenOverSound
        PROC_SET_ONCYCLE rlProcFactionSlotUnitDeathCycle2
        PROC_YIELD 16
        PROC_CALL rlSetFactionUnitDeathFlickerRate2
        PROC_YIELD 8
        PROC_CALL rlSetFactionUnitDeathFlickerRate1
        PROC_YIELD 8
        PROC_SET_ONCYCLE rlProcFactionSlotUnitDeathCycle
        PROC_CALL rlHideMatchingFactionUnits
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

      rsGetMovingMapSpriteStepShift ; 81/8A4A

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

      rsStepMovingMapSpritePathScript ; 81/8A68

        .al
        .autsiz
        .databank $81

        ; Reads scripted movement paths

        lda aActiveSpriteSystem.aUnknown0012E0,b,y
        bit #$0010
        beq +

          ; If set, unload unit as soon as they are offscreen
          jsr rsCheckMovingMapSpriteOffscreen
          bcc +

            ; Character is not visible
            jsl rlScriptedMoveCmdEnd
            sec
            rts

        +
        jsr rsUpdateMovingMapSpriteSoundPan

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

            jsl rlScriptedMoveCmdEnd
            sec
            rts

          +
          bit #$0080
          beq rsRunMovingMapSpriteMoveCmd

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

        .word <>rlScriptedMoveCmdEnd
        .word <>rlScriptedMoveCmdPause
        .word <>rlScriptedMoveCmdLoop
        .word <>rlScriptedMoveCmdJump
        .word <>rlScriptedMoveCmdSetSpeed
        .word <>rlScriptedMoveCmdFaceDown
        .word <>rlScriptedMoveCmdFaceUp
        .word <>rlScriptedMoveCmdFaceLeft
        .word <>rlScriptedMoveCmdFaceRight

      rsRunMovingMapSpriteMoveCmd ; 81/8AD8

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
        jsr rsGetMovingMapSpriteStepShift
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

      rlScriptedMoveCmdPause ; 81/8B5D

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

        jsl rlStopMovingMapSpriteSound
        ply
        sec
        rtl

        .databank 0

      rlScriptedMoveCmdEnd ; 81/8B76

        .al
        .autsiz
        .databank ?

        phy
        lda aMovingMapSprites.wActiveSpriteOffset,b,x
        tay

        jsr rsRestoreUnitAfterMovingSprite

        lda #$FFFF
        sta aMovingMapSprites.wActiveSpriteOffset,b,x
        lda #0
        sta aActiveSpriteSystem.aTypeOffset,b,y

        jsl rlStopMovingMapSpriteSound
        ply
        sec
        rtl

        .databank 0

      rsRestoreUnitAfterMovingSprite ; 81/8B91

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

      rlScriptedMoveCmdLoop ; 81/8BF0

        .al
        .autsiz
        .databank ?

        lda #0
        sta aMovingMapSprites.wPathScriptOffset,b,x
        tay
        clc
        rtl

        .databank 0

      rlScriptedMoveCmdJump ; 81/8BF9

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

      rlScriptedMoveCmdSetSpeed ; 81/8C13

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

      rlScriptedMoveCmdFaceDown ; 81/8C5D

        .al
        .autsiz
        .databank ?

        lda #1
        bra +

      rlScriptedMoveCmdFaceUp ; 81/8C62

        .al
        .autsiz
        .databank ?

        lda #2
        bra +

      rlScriptedMoveCmdFaceLeft ; 81/8C67

        .al
        .autsiz
        .databank ?

        lda #3
        bra +

      rlScriptedMoveCmdFaceRight ; 81/8C6C

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

      rsCheckMovingMapSpriteOffscreen ; 81/8C98

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

      rsUpdateMovingMapSpriteSoundPan ; 81/8CBF

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
        jsl rlUpdateMovingMapSpriteSound
        ply
        plx
        plp
        rts

        .databank 0

      rlUpdateMovingMapSpriteSound ; 81/8CE2

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

          jsr rsStartMovingMapSpriteSoundChannel
          bra _End

        +
        xba
        dec a
        bne +

        sep #$20
        sty aSoundChannelFadeState.bLevel,b
        lda #0
        sta aSoundChannelFadeState.bFlags,b
        rep #$20
        ldx #0
        jsl rlUpdateMapSpriteSoundPanning
        bra _End

        +
        sep #$20
        sty $04CE,b
        lda #0
        sta $04CF,b
        rep #$20
        ldx #3
        jsl rlUpdateMapSpriteSoundPanning

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

      rsStartMovingMapSpriteSoundChannel ; 81/8D23

        .al
        .xl
        .autsiz
        .databank ?

        lda wMusicID,b
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
        jsl rlAssignMovingSpriteSoundChannel
        plx
        sta aMovingMapSprites.wMovingSound,b,x
        jsl rlStartMovingSpriteSound

        _8D57
        rts

        .databank 0

        ; 81/8D58

    .endsection Unsorted818D23Section


    .section Unsorted87C056Section

      .al
      .xl

      procCastleTakenOver ; 87/C056

        .structProcInfo "TF", rlProcCastleTakenOverInit, rlProcCastleTakenOverCycle, aProcCastleTakenOverCode

      rlProcCastleTakenOverInit ; 87/C05E

        .al
        .autsiz
        .databank ?

        ; wInput0 = location, wInput1 = old owner, wInput2 = new owner. Skips to the end of the script unless the old owner's home castle was taken (rlCheckFactionHomeCastleCaptured) and some of its units must fade out (rlCheckFactionUnitsVisibleOnScreen). Holds the game state.

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
        jsl rlCheckFactionHomeCastleCaptured
        bcs +

          lda #<>aProcCastleTakenOverCode._C23A
          sta aProcSystem.aHeaderCodeOffset,b,x
          lda #1
          sta aProcSystem.aHeaderSleepTimer,b,x
          bra ++

        +
        lda aProcSystem.aBody1,b,x
        jsl rlCheckFactionUnitsVisibleOnScreen
        cmp #0
        bne +

          lda #<>aProcCastleTakenOverCode._C235
          sta aProcSystem.aHeaderCodeOffset,b,x
          lda #1
          sta aProcSystem.aHeaderSleepTimer,b,x

        +
        stz wGameStateRoutine1,b
        rtl

        .databank 0

      rlProcCastleTakenOverCycle ; 87/C0A9

        .al
        .autsiz
        .databank ?

        rtl

        .databank 0

    .endsection Unsorted87C056Section


    .section Unsorted88C7CFSection

      .al
      .xl

      rlAnimateMapSprites ; 88/C7CF

        .al
        .xl
        .autsiz
        .databank ?

        ; Each frame of the map (rlMapUpkeep): queues the standing map sprite frames for this frame count (rlQueueStandingMapSpriteFrames).

        phb
        lda wVBlankEnabledFramecount
        jsl rlQueueStandingMapSpriteFrames
        plb
        .databank ?
        rtl

        .databank 0

        ; 88/C7D8

    .endsection Unsorted88C7CFSection


    .section Unsorted88C7D8Section

      .al
      .xl

      rsDrawMovingSpritesTestUnused ; 88/C7D8

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ; Nothing reaches this. Sets up four moving map sprites with fixed sprites and draws them in a diagonal from the cursor; apparently a test.

        lda #$0000
        sta aMovingMapSpritesMapSprites,b
        lda #$8000
        sta $0869,b
        lda #$0002
        sta $086B,b
        lda #$8002
        sta $086D,b
        lda wMovingUnitSpriteFacing,b
        sta @l wUnknown000911
        sta @l $000913
        sta @l $000915
        sta @l $000917
        ldx #$0006

        _C806
        lda #$0400
        sta wR5
        jsl rlAnimateMovingMapSprite
        lda wR0
        clc
        adc wCursorXOffset,b
        clc
        adc aMovingSpritesTestXOffsetsUnused,x
        sta wR0
        lda wR1
        clc
        adc wCursorYOffset,b
        clc
        adc aMovingSpritesTestYOffsetsUnused,x
        sta wR1
        phx
        jsl rlPushToOAMBuffer
        plx
        dec x
        dec x
        bpl _C806
        rts

        .databank 0

        ; 88/C834

    .endsection Unsorted88C7D8Section


    .section Table88C834Section

      .al
      .xl

      aMovingSpritesTestXOffsetsUnused ; 88/C834

        ; Read by rsDrawMovingSpritesTestUnused.

        .word $0000, $0020, $0030, $0040

        ; 88/C83C

    .endsection Table88C834Section


    .section Data88C83CSection

      .al
      .xl

      aMovingSpritesTestYOffsetsUnused ; 88/C83C

        ; Read by rsDrawMovingSpritesTestUnused.

        .word $0000, $0020, $0030, $0040

        ; 88/C844

    .endsection Data88C83CSection


    .section Unsorted88C844Section

      .al
      .xl

      rlDrawMovingUnitSprite ; 88/C844

        .al
        .xl
        .autsiz
        .databank ?

        ; VBlank: draws the active unit's moving map sprite by wMovingUnitSpriteState (1 at its saved place while on screen, 2 at the cursor, 3 at wMapSavedCursorXPixel/YPixel), then gets its next frame ready (rsUpdateMovingUnitSpriteFrame).

        phx
        phy
        lda wMovingUnitSpriteState,b
        beq _C873
        cmp #$0001
        beq _C89A
        cmp #$0003
        beq _C876
        lda wCursorXOffset,b
        sta wR0
        lda wCursorYOffset,b
        sta wR1
        lda #$0000
        sta wR4
        stz wR5
        jsr rsGetMovingUnitSpriteToDraw
        phx
        jsl rlPushToOAMBuffer
        plx
        jml _C8F9


        _C873
        plx
        ply
        rtl


        _C876
        lda wMapSavedCursorXPixel,b
        sec
        sbc wMapScrollXPixels,b
        sta wR0
        lda wMapSavedCursorYPixel,b
        sec
        sbc wMapScrollYPixels,b
        sta wR1
        lda #$0000
        sta wR4
        stz wR5
        jsr rsGetMovingUnitSpriteToDraw
        phx
        jsl rlPushToOAMBuffer
        plx
        bra _C8F9


        _C89A
        ldx wActiveUnitDeploymentOffset,b
        lda wMapScrollXPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sec
        sbc #$0001
        sta wTempVariable1,b
        lda wMapScrollYPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sec
        sbc #$0001
        sta wTempVariable2,b
        lda aDeploymentTable._XTilePosition,x
        sec
        sbc wTempVariable1,b
        bmi _C873
        cmp #$0012
        bcs _C873
        lda aDeploymentTable._YTilePosition,x
        sec
        sbc wTempVariable2,b
        bmi _C873
        cmp #$0011
        bcs _C873
        lda wMovingUnitXPixel,b
        sec
        sbc wMapScrollXPixels,b
        sta wR0
        lda wMovingUnitYPixel,b
        sec
        sbc wMapScrollYPixels,b
        sta wR1
        lda #$0000
        sta wR4
        stz wR5
        jsr rsGetMovingUnitSpriteToDraw
        phx
        jsl rlPushToOAMBuffer
        plx

        _C8F9
        jsr rsUpdateMovingUnitSpriteFrame
        plx
        ply
        rtl

        .databank 0

        ; 88/C8FF

      rsGetMovingUnitSpriteToDraw ; 88/C8FF

        .al
        .xl
        .autsiz
        .databank ?

        ; Steps the walking frame when its timer runs out and returns Y = the sprite array, wR5 = the palette for its allegiance (aMapSpritePalettesByAllegiance) and the frame's X/Y nudge in wR0/wR1.

        lda wMovingUnitSpriteTimer,b
        bne _C91E
        lda bDMAArrayFlag,b
        and #$00FF
        bne _C91E
        lda wMovingUnitSpriteFrame,b
        clc
        adc #$0001
        cmp #$0004
        bcc _C91B
        lda #$0000

        _C91B
        sta wMovingUnitSpriteFrame,b

        _C91E
        ldx wActiveUnitDeploymentOffset,b
        lda aDeploymentTable._DeploymentOffsets,x
        cmp #$0060
        bcs _C939
        sep #$20
        lda #$88
        pha
        plb
        .databank $88
        rep #$20
        ldy #<>aMovingUnitSprite24x24
        jml _C97E


        _C939
        sep #$20
        lda #$88
        pha
        plb
        .databank $88
        rep #$20
        phx
        lda aDeploymentTable._DeploymentOffsets,x
        tax
        lda aDeploymentTable._MapSpriteID,x
        and #$7FFF
        asl a
        tax
        lda @l aMapSpriteWalkOffsetPointers,x
        sta wR3
        lda wMovingUnitSpriteFrame,b
        asl a
        clc
        adc wMovingUnitSpriteFacing,b
        clc
        adc wR3
        tax
        lda @l aMapSpriteWalkOffsets,x
        and #$00FF
        clc
        adc wR0
        sta wR0
        lda @l aMapSpriteWalkOffsets+1,x
        and #$00FF
        clc
        adc wR1
        sta wR1
        ldy #<>aMovingUnitSprite32x32
        plx

        _C97E
        lda aDeploymentTable,x
        and #$0003
        asl a
        phx
        tax
        lda @l aMapSpritePalettesByAllegiance,x
        sta wR5
        plx
        rts

        .databank 0

        ; 88/C990

    .endsection Unsorted88C844Section


    .section Data88C990Section

      .al
      .xl

      aMapSpritePalettesByAllegiance ; 88/C990

        ; Read by rlDrawDeployedUnitMapSprites, rsGetMovingUnitSpriteToDraw.

        .word $0200, $0400, $0600, $0800, $0000, $0200, $0400, $0600
        .word $0800, $0800, $0800

        ; 88/C9A6

    .endsection Data88C990Section


    .section Unsorted88C9A6Section

      .al
      .xl

      rlLoadMovingUnitSprite ; 88/C9A6

        .al
        .autsiz
        .databank ?

        ; Decompresses the active unit's walking sprite (short or tall, from aMapMovementShortSpritePointers or aMapMovementTallSpritePointers) to $7EAB88.

        phx
        phk
        plb

        lda #$FFFF
        sta $0865,b

        ldx wActiveUnitDeploymentOffset,b
        lda aDeploymentTable._DeploymentOffsets,x
        tax
        lda aDeploymentTable._MapSpriteID,x
        and #$8000
        bne _Tall

          ldx wActiveUnitDeploymentOffset,b
          lda aDeploymentTable._DeploymentOffsets,x
          tax
          lda aDeploymentTable._MapSpriteID,x
          and #~$8000
          sta wR0
          clc
          adc wR0
          clc
          adc wR0
          tax
          lda aMapMovementShortSpritePointers,x
          sta lR45
          lda aMapMovementShortSpritePointers+1,x
          sta lR45+1
          lda #(`$7EAB88)<<8
          sta lR47+1
          lda #<>$7EAB88
          sta lR47
          jsl rlDecompressSingle

          plx
          rtl
        
        _Tall
        ldx wActiveUnitDeploymentOffset,b
        lda aDeploymentTable._DeploymentOffsets,x
        tax
        lda aDeploymentTable._MapSpriteID,x
        and #~$8000
        sta wR0
        clc
        adc wR0
        clc
        adc wR0
        tax
        lda aMapMovementTallSpritePointers,x
        sta lR45
        lda aMapMovementTallSpritePointers+1,x
        sta lR45+1
        lda #(`$7EAB88)<<8
        sta lR47+1
        lda #<>$7EAB88
        sta lR47
        jsl rlDecompressSingle

        plx
        rtl

        .databank 0

        ; 88/CA28

    .endsection Unsorted88C9A6Section


    .section Unsorted88CA28Section

      .al
      .xl

      rsUpdateMovingUnitSpriteFrame ; 88/CA28

        .al
        .xl
        .autsiz
        .databank ?

        ; When the frame timer runs out, reloads it from aMapSpriteWalkFrameDelays and picks the next frame's graphics (short or tall); counts the timer down otherwise.

        lda $0865,b
        bmi _CA30
        stz $0865,b

        _CA30
        lda wMovingUnitSpriteState,b
        beq _CA73
        lda wMovingUnitSpriteTimer,b
        bne _CA73
        ldx wActiveUnitDeploymentOffset,b
        lda aDeploymentTable._DeploymentOffsets,x
        tax
        lda aDeploymentTable._MapSpriteID,x
        and #$7FFF
        tax
        lda aMapSpriteWalkFrameDelays,x
        and #$00FF
        sta wMovingUnitSpriteTimer,b
        ldx wActiveUnitDeploymentOffset,b
        lda aDeploymentTable._DeploymentOffsets,x
        tax
        lda aDeploymentTable._MapSpriteID,x
        and #$8000
        bne _CA6C
        jsr rsSetShortMovingUnitSpriteFrame
        inc $0865,b
        rts


        _CA6C
        jsr rsSetTallMovingUnitSpriteFrame
        inc $0865,b
        rts


        _CA73
        dec wMovingUnitSpriteTimer,b
        rts

        .databank 0

        ; 88/CA77

    .endsection Unsorted88CA28Section


    .section Unsorted88CA77Section

      .al
      .xl

      rsSetShortMovingUnitSpriteFrame ; 88/CA77

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Points the upload at the frame (wMovingUnitSpriteFrame) and facing (wMovingUnitSpriteFacing) of a short walking sprite.

        lda wMovingUnitSpriteFrame,b
        cmp #$0000
        beq _CA8E
        cmp #$0001
        beq _CA93
        cmp #$0002
        beq _CA98
        cmp #$0003
        beq _CA9D

        _CA8E
        lda #$0000
        bra _CAA2


        _CA93
        lda #$0140
        bra _CAA2


        _CA98
        lda #$0280
        bra _CAA2


        _CA9D
        lda #$03C0
        bra _CAA2


        _CAA2
        sta wMapSpriteFrameByteOffset,b
        lda wMovingUnitSpriteFacing,b
        cmp #$0000
        beq _CABC
        cmp #$0008
        beq _CAC1
        cmp #$0010
        beq _CAC6
        cmp #$0018
        beq _CACB

        _CABC
        lda #$0000
        bra _CAD0


        _CAC1
        lda #$0500
        bra _CAD0


        _CAC6
        lda #$0A00
        bra _CAD0


        _CACB
        lda #$0F00
        bra _CAD0


        _CAD0
        clc
        adc wMapSpriteFrameByteOffset,b
        sta wMapSpriteFrameByteOffset,b
        lda #$7E00
        sta lR18+1
        lda #$AB88
        sta lR18
        lda #$7E00
        sta lMapSpriteGraphicsPointer+1,b
        lda #$AB88
        sta lMapSpriteGraphicsPointer,b
        lda #$7E00
        sta $084E,b
        lda #$AB88
        sta $084D,b
        lda lMapSpriteGraphicsPointer,b
        clc
        adc wMapSpriteFrameByteOffset,b
        sta lR18
        sta $084D,b
        lda #$00A0
        sta wR0
        lda #$6200
        sta wR1
        lda $0865,b
        beq _CB1A
        phx
        jsl rlDMAByPointer
        plx

        _CB1A
        lda lMapSpriteGraphicsPointer,b
        clc
        adc #$00A0
        clc
        adc wMapSpriteFrameByteOffset,b
        sta lR18
        sta $0850,b
        lda #$00A0
        sta wR0
        lda #$6300
        sta wR1
        lda $0865,b
        beq _CB42
        phx
        jsl rlDMAByPointer
        plx
        stz $0865,b

        _CB42
        rts

        .databank 0

        ; 88/CB43

      rsSetTallMovingUnitSpriteFrame ; 88/CB43

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda wMovingUnitSpriteFrame,b
        cmp #$0000
        beq _CB5A
        cmp #$0001
        beq _CB5F
        cmp #$0002
        beq _CB64
        cmp #$0003
        beq _CB69

        _CB5A
        lda #$0000
        bra _CB6E


        _CB5F
        lda #$0200
        bra _CB6E


        _CB64
        lda #$0400
        bra _CB6E


        _CB69
        lda #$0600
        bra _CB6E


        _CB6E
        sta wMapSpriteFrameByteOffset,b
        lda wMovingUnitSpriteFacing,b
        xba
        clc
        adc wMapSpriteFrameByteOffset,b
        sta wMapSpriteFrameByteOffset,b
        lda #$7E00
        sta lR18+1
        lda #$AB88
        sta lR18
        lda #$7E00
        sta lMapSpriteGraphicsPointer+1,b
        lda #$AB88
        sta lMapSpriteGraphicsPointer,b
        lda #$7E00
        sta $084E,b
        lda #$AB88
        sta $084D,b
        lda lMapSpriteGraphicsPointer,b
        clc
        adc wMapSpriteFrameByteOffset,b
        sta lR18
        sta $084D,b
        lda #$0100
        sta wR0
        lda #$6200
        sta wR1
        lda $0865,b
        beq _CBBF
        phx
        jsl rlDMAByPointer
        plx

        _CBBF
        lda lMapSpriteGraphicsPointer,b
        clc
        adc #$0100
        clc
        adc wMapSpriteFrameByteOffset,b
        sta lR18
        sta $0850,b
        lda #$0100
        sta wR0
        lda #$6300
        sta wR1
        lda $0865,b
        beq _CBE7
        phx
        jsl rlDMAByPointer
        plx
        stz $0865,b

        _CBE7
        rts

        .databank 0

        ; 88/CBE8

    .endsection Unsorted88CA77Section


    .section Unsorted88CBE8Section

      .al
      .xl

      aMapSpriteWalkFrameDelays ; 88/CBE8

        ; Indexed by map sprite ID (without the tall flag $8000).
        ; 65 bytes of 9 and then 32 bytes of 14: the same counts as the
        ; short and tall map sprite tables.

        .fill 65, 9
        .fill 32, 14

        ; 88/CC49


      aMovingUnitSprite32x32 ; 88/CC49

        _Sprites := [[(   8,    0), $21, SpriteLarge, $026, 2, 0, false, false]]
        _Sprites ..= [[(  -8,    0), $21, SpriteLarge, $024, 2, 0, false, false]]
        _Sprites ..= [[(   8,  -16), $21, SpriteLarge, $022, 2, 0, false, false]]
        _Sprites ..= [[(  -8,  -16), $21, SpriteLarge, $020, 2, 0, false, false]]

        .structSpriteArray aMovingUnitSprite32x32._Sprites

      aMovingUnitSprite24x24 ; 88/CC5F

        _Sprites := [[(  -4,    8), $00, SpriteSmall, $034, 2, 0, false, false]]
        _Sprites ..= [[(   4,    0), $21, SpriteLarge, $022, 2, 0, false, false]]
        _Sprites ..= [[(  12,   -8), $00, SpriteSmall, $024, 2, 0, false, false]]
        _Sprites ..= [[(  -4,   -8), $21, SpriteLarge, $020, 2, 0, false, false]]

        .structSpriteArray aMovingUnitSprite24x24._Sprites

    .endsection Unsorted88CBE8Section


    .section Unsorted88CC75Section

      .al
      .xl

      rlQueueStandingMapSpriteFrames ; 88/CC75

        .al
        .xl
        .autsiz
        .databank ?

        ; Queues the standing map sprite frames for frame count A: short sprites on steps 2-7, tall ones on steps 10-15 (of 16).

        lda wMapSpriteFrameCounter,b
        and #$000F
        cmp #$0002
        bcc _CC97
        cmp #$0008
        beq _CC97
        cmp #$0009
        beq _CC97
        cmp #$000A
        bcc _CC93
        jsr rsQueueTallStandingMapSpriteFrames
        rtl


        _CC93
        jsr rsQueueShortStandingMapSpriteFrames
        rtl


        _CC97
        rtl

        .databank 0

        ; 88/CC98

      rsQueueShortStandingMapSpriteFrames ; 88/CC98

        .al
        .xl
        .autsiz
        .databank ?

        ; Queues eight units' short standing frames into aDynamicMapSpriteDMASources/aDynamicMapSpriteVRAMDestinations.

        lda wMapSpriteFrameCounter,b
        clc
        adc #$0002
        and #$000F
        asl a
        xba
        sta wTempVariable2,b
        lda wMapSpriteFrameCounter,b
        and #$000F
        sec
        sbc #$0002
        asl a
        asl a
        asl a
        asl a
        sta wTempVariable1,b
        lda wMapSpriteFrameCounter,b
        and #$0030
        cmp #$0000
        beq _CCD2
        cmp #$0010
        beq _CCD7
        cmp #$0020
        beq _CCDC
        cmp #$0030
        beq _CCE1

        _CCD2
        lda #$0000
        bra _CCE6


        _CCD7
        lda #$0080
        bra _CCE6


        _CCDC
        lda #$0100
        bra _CCE6


        _CCE1
        lda #$0080
        bra _CCE6


        _CCE6
        sta wMapSpriteFrameByteOffset,b
        sta wUnknown000790,b
        ldx wTempVariable1,b
        ldy #$0000

        _CCF2
        lda aDeploymentTable._MapSpriteID,x
        and #$7FFF
        sta wR0
        clc
        adc wR0
        clc
        adc wR0
        phx
        tax
        lda aShortStandingMapSpritePointers+1,x
        sta aDynamicMapSpriteDMASources.lTopHalf+1,b,y
        sta aDynamicMapSpriteDMASources.lBottomHalf+1,b,y
        lda aShortStandingMapSpritePointers,x
        plx
        sta lMapSpriteGraphicsPointer,b
        clc
        adc wMapSpriteFrameByteOffset,b
        sta aDynamicMapSpriteDMASources.lTopHalf,b,y
        clc
        adc #$0040
        sta aDynamicMapSpriteDMASources.lBottomHalf,b,y
        lda #$6000
        clc
        adc wTempVariable2,b
        sta aDynamicMapSpriteVRAMDestinations.wTopHalf,b,y
        clc
        adc #$0100
        sta aDynamicMapSpriteVRAMDestinations.wBottomHalf,b,y
        lda wTempVariable2,b
        clc
        adc #$0020
        sta wTempVariable2,b
        inc x
        inc x
        tya
        clc
        adc #$0006
        tay
        cpy #$0030
        bcc _CCF2
        rts

        .databank 0

        ; 88/CD4C

      rlResumeMapSpriteAnimation ; 88/CD4C

        .al
        .xl
        .autsiz
        .databank ?

        ; Clears bit 15 of wMapSpriteAnimationPauseFlags.

        lda #$8000
        trb wMapSpriteAnimationPauseFlags,b
        rtl

        .databank 0

        ; 88/CD53

    .endsection Unsorted88CC75Section


    .section Unsorted88CD53Section

      .al
      .xl

      rlPauseMapSpriteAnimation ; 88/CD53

        .al
        .autsiz
        .databank ?

        ; Sets bit 15 of wMapSpriteAnimationPauseFlags: rlUploadMapAnimations stops uploading map sprite frames.

        lda #$8000
        tsb wMapSpriteAnimationPauseFlags,b
        rtl

        .databank 0

      rlResumeMapTileAnimation ; 88/CD5A

        .al
        .autsiz
        .databank ?

        ; Clears bit 0 of wMapSpriteAnimationPauseFlags.

        lda #$0001
        trb wMapSpriteAnimationPauseFlags,b
        rtl

        .databank 0

      rlPauseMapTileAnimation ; 88/CD61

        .al
        .autsiz
        .databank ?

        ; Sets bit 0 of wMapSpriteAnimationPauseFlags: the animated map tiles stop.

        lda #$0001
        tsb wMapSpriteAnimationPauseFlags,b
        rtl

        .databank 0

        ; 88/CD68

    .endsection Unsorted88CD53Section


    .section Unsorted88CD68Section

      .al
      .xl

      rlUploadMapAnimations ; 88/CD68

        .al
        .xl
        .autsiz
        .databank ?

        ; VBlank: uploads the moving unit's frame, then on step 0 or 1 of 8 an animated map tile frame, else the queued standing map sprite frames (unless paused).

        phb
        php
        phk
        plb
        .databank $88
        jsl rlUploadMovingUnitSpriteFrame
        lda wMapSpriteFrameCounter,b
        and #$0007
        beq _CD97
        cmp #$0001
        beq _CD9D
        lda wMapSpriteAnimationPauseFlags,b
        bmi _CD94
        lda wMapSpriteFrameCounter,b
        and #$000F
        cmp #$0008
        bcc _CDA3
        jml _CE11


        _CD91
        inc wMapSpriteFrameCounter,b

        _CD94
        plp
        plb
        .databank $88
        rtl


        _CD97
        jsl rlUploadMapTileAnimation1
        bra _CD91


        _CD9D
        jsl rlUploadMapTileAnimation2
        bra _CD91


        _CDA3
        sep #$20
        rep #$10
        lda #$80
        sta $2115,b
        lda #$00
        sta $4316,b
        sta $4326,b
        lda #$18
        sta $4311,b
        sta $4321,b
        ldy #$0000

        _CDBF
        lda #$40
        sta $4315,b
        sta $4325,b
        ldx aDynamicMapSpriteDMASources.lTopHalf,b,y
        stx $4312,b
        lda aDynamicMapSpriteDMASources.lTopHalf+2,b,y
        sta $4314,b
        ldx aDynamicMapSpriteVRAMDestinations.wTopHalf,b,y
        stx $2116,b
        lda #$01
        sta $4310,b
        sta $4320,b
        lda #$02
        sta $420B,b
        ldx aDynamicMapSpriteDMASources.lBottomHalf,b,y
        stx $4322,b
        lda aDynamicMapSpriteDMASources.lBottomHalf+2,b,y
        sta $4324,b
        ldx aDynamicMapSpriteVRAMDestinations.wBottomHalf,b,y
        stx $2116,b
        lda #$04
        sta $420B,b
        tya
        clc
        adc #$06
        tay
        cpy #$0030
        beq _CE0B
        jml _CDBF


        _CE0B
        rep #$20
        jml _CD91


        _CE11
        sep #$20
        rep #$10
        lda #$80
        sta $2115,b
        lda #$18
        sta $4311,b
        sta $4321,b
        lda #$00
        sta $4316,b
        sta $4326,b
        ldy #$0000

        _CE2D
        lda #$40
        sta $4315,b
        ldx aDynamicMapSpriteDMASources.lTopHalf,b,y
        stx $4312,b
        lda aDynamicMapSpriteDMASources.lTopHalf+2,b,y
        sta $4314,b
        ldx aDynamicMapSpriteVRAMDestinations.wTopHalf,b,y
        stx $2116,b
        lda #$01
        sta $4310,b
        sta $4320,b
        lda #$02
        sta $420B,b
        lda #$80
        sta $4325,b
        ldx aDynamicMapSpriteDMASources.lBottomHalf,b,y
        stx $4322,b
        lda aDynamicMapSpriteDMASources.lBottomHalf+2,b,y
        sta $4324,b
        ldx aDynamicMapSpriteVRAMDestinations.wBottomHalf,b,y
        stx $2116,b
        lda #$04
        sta $420B,b
        tya
        clc
        adc #$06
        tay
        cpy #$0018
        beq _CE7B
        jml _CE2D


        _CE7B
        rep #$20
        jml _CD91

        .databank 0

        ; 88/CE81

      rsQueueTallStandingMapSpriteFrames ; 88/CE81

        .al
        .xl
        .autsiz
        .databank ?

        lda wMapSpriteFrameCounter,b
        and #$000F
        asl a
        xba
        sta wTempVariable2,b
        lda wMapSpriteFrameCounter,b
        and #$000F
        sec
        sbc #$000A
        asl a
        asl a
        asl a
        clc
        adc #$0060
        sta wTempVariable1,b
        lda wMapSpriteFrameCounter,b
        and #$0030
        cmp #$0000
        beq _CEBA
        cmp #$0010
        beq _CEBF
        cmp #$0020
        beq _CEC4
        cmp #$0030
        beq _CEC9

        _CEBA
        lda #$0000
        bra _CECE


        _CEBF
        lda #$00C0
        bra _CECE


        _CEC4
        lda #$0180
        bra _CECE


        _CEC9
        lda #$00C0
        bra _CECE


        _CECE
        sta wMapSpriteFrameByteOffset,b
        sta wUnknown000790,b
        ldx wTempVariable1,b
        ldy #$0000

        _CEDA
        lda aDeploymentTable._MapSpriteID,x
        and #$7FFF
        sta wR0
        clc
        adc wR0
        clc
        adc wR0
        phx
        tax
        lda aTallStandingMapSpritePointers+1,x
        sta aDynamicMapSpriteDMASources.lTopHalf+1,b,y
        sta aDynamicMapSpriteDMASources.lBottomHalf+1,b,y
        lda aTallStandingMapSpritePointers,x
        clc
        adc wMapSpriteFrameByteOffset,b
        sta aDynamicMapSpriteDMASources.lTopHalf,b,y
        clc
        adc #$0040
        sta aDynamicMapSpriteDMASources.lBottomHalf,b,y
        plx
        lda #$6000
        clc
        adc wTempVariable2,b
        sta aDynamicMapSpriteVRAMDestinations.wTopHalf,b,y
        clc
        adc #$0100
        sta aDynamicMapSpriteVRAMDestinations.wBottomHalf,b,y
        lda wTempVariable2,b
        clc
        adc #$0040
        sta wTempVariable2,b
        inc x
        inc x
        tya
        clc
        adc #$0006
        tay
        cpy #$0018
        bcc _CEDA
        rts

        .databank 0

        ; 88/CF31

      rlUploadMapTileAnimation1 ; 88/CF31

        .al
        .xl
        .autsiz
        .databank ?

        ; Copies frame (wMapSpriteFrameCounter / 8) of g4bppMapTileAnimations1 ($800 bytes, 16 frames) to VRAM $0C00.

        lda wMapSpriteAnimationPauseFlags,b
        bit #$0001
        bne _CF89
        sep #$20
        lda wMapSpriteFrameCounter,b
        and #$78
        lsr a
        lsr a
        lsr a
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda #$80
        sta $2115,b
        lda #$00
        sta $4315,b
        lda #$08
        sta $4316,b
        lda #$18
        sta $4311,b
        lda aMapTileAnimation1Frames,x
        sta $4312,b
        lda aMapTileAnimation1Frames+1,x
        sta $4313,b
        lda aMapTileAnimation1Frames+2,x
        sta $4314,b
        lda #$00
        sta $2116,b
        lda #$0C
        sta $2117,b
        lda #$01
        sta $4310,b
        lda #$02
        sta $420B,b
        rep #$20

        _CF89
        rtl

        .databank 0

        ; 88/CF8A

    .endsection Unsorted88CD68Section


    .section Table88CF8ASection

      .al
      .xl

      aMapTileAnimation1Frames ; 88/CF8A

        ; Read by rlUploadMapTileAnimation1.

        .for i in range(16)
          .long g4bppMapTileAnimations1 + (i * $0800)
        .endfor

        ; 88/CFBA

    .endsection Table88CF8ASection


    .section Unsorted88CFBASection

      .al
      .xl

      rlUploadMapTileAnimation2 ; 88/CFBA

        .al
        .xl
        .autsiz
        .databank ?

        ; Copies frame (wMapSpriteFrameCounter / 8) of g4bppMapTileAnimations2 ($400 bytes, 32 frames) to VRAM $0A00.

        lda wMapSpriteAnimationPauseFlags,b
        bit #$0001
        bne _D012
        sep #$20
        lda wMapSpriteFrameCounter,b
        and #$F8
        lsr a
        lsr a
        lsr a
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda #$80
        sta $2115,b
        lda #$00
        sta $4315,b
        lda #$04
        sta $4316,b
        lda #$18
        sta $4311,b
        lda aMapTileAnimation2Frames,x
        sta $4312,b
        lda aMapTileAnimation2Frames+1,x
        sta $4313,b
        lda aMapTileAnimation2Frames+2,x
        sta $4314,b
        lda #$00
        sta $2116,b
        lda #$0A
        sta $2117,b
        lda #$01
        sta $4310,b
        lda #$02
        sta $420B,b
        rep #$20

        _D012
        rtl

        .databank 0

        ; 88/D013

    .endsection Unsorted88CFBASection


    .section Table88D013Section

      .al
      .xl

      aMapTileAnimation2Frames ; 88/D013

        ; Read by rlUploadMapTileAnimation2.

        .for i in range(32)
          .long g4bppMapTileAnimations2 + (i * $0400)
        .endfor

        ; 88/D073

    .endsection Table88D013Section


    .section Unsorted88D073Section

      .al
      .xl

      rlUploadMapTileAnimations ; 88/D073

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $88
        phk
        plb
        .databank $88
        jsl rlUploadMapTileAnimation1
        jsl rlUploadMapTileAnimation2
        plp
        plb
        .databank $88
        rtl

        .databank 0

        ; 88/D084

    .endsection Unsorted88D073Section


    .section Unsorted88D084Section

      .al
      .xl

      rlDrawDeployedUnitMapSprites ; 88/D084

        .al
        .xl
        .autsiz
        .databank ?

        ; VBlank: draws every deployed, visible unit's map sprite on screen (with scanline culling), coloured by allegiance; units asleep (DeploymentStateAsleep), and player units that have acted (DeploymentStateGrayed), are grey ($0E00).

        phb
        sep #$20
        lda #$7E
        pha
        plb
        .databank $7E
        rep #$20
        jsl rlBeginOAMScanlineFrame
        ldy #$008E
        bra _D0A0


        _D096
        lda #$0000
        sta $0A43,b,y
        jml _D10F


        _D0A0
        lda aDeploymentTable,y
        beq _D096
        bit #$0040
        bne _D096
        lda $453B,b,y
        sec
        sbc wMapScrollXPixels,b
        sta $0923,b,y
        sta wR0
        clc
        adc #$0007
        cmp #$00FF
        bcs _D096
        lda $45CB,b,y
        sec
        sbc wMapScrollYPixels,b
        sta $09B3,b,y
        clc
        adc #$000F
        cmp #$00F1
        bcs _D096
        sec
        sbc #$001F
        sta wR1
        lda aDeploymentTable,y
        bit #$2000
        bne _D0EA
        bit #$0008
        beq _D0EF
        bit #$0003
        bne _D0EF

        _D0EA
        lda #$0E00
        bra _D0F8


        _D0EF
        and #$0003
        asl a
        tax
        lda aMapSpritePalettesByAllegiance,x

        _D0F8
        ldx $465B,b,y
        ora aMapSpriteSlotTiles,x
        sta $0A43,b,y
        cpx #$0060
        bcc _D10F
        inc a
        inc a
        sta wR4
        jsl rlPushToOAMBufferWithScanlineCulling

        _D10F
        dec y
        dec y
        bpl _D0A0
        ldy #$008E

        _D116
        lda $0A43,b,y
        beq _D12B
        sta wR4
        lda $0923,b,y
        sta wR0
        lda $09B3,b,y
        sta wR1
        jsl rlPushToOAMBufferWithScanlineCulling._88D8

        _D12B
        dec y
        dec y
        bpl _D116
        jsl rlFinishOAMScanlineFrame
        plb
        .databank $7E
        rtl

        .databank 0

        ; 88/D135

    .endsection Unsorted88D084Section


    .section Data88D135Section

      .al
      .xl

      aMapSpriteSlotTiles ; 88/D135

        ; Read by rlDrawDeployedUnitMapSprites.

        .word $2080, $2082, $2084, $2086, $2088, $208A, $208C, $208E
        .word $20A0, $20A2, $20A4, $20A6, $20A8, $20AA, $20AC, $20AE
        .word $20C0, $20C2, $20C4, $20C6, $20C8, $20CA, $20CC, $20CE
        .word $20E0, $20E2, $20E4, $20E6, $20E8, $20EA, $20EC, $20EE
        .word $2100, $2102, $2104, $2106, $2108, $210A, $210C, $210E
        .word $2120, $2122, $2124, $2126, $2128, $212A, $212C, $212E
        .word $2140, $2144, $2148, $214C, $2160, $2164, $2168, $216C
        .word $2180, $2184, $2188, $218C, $21A0, $21A4, $21A8, $21AC
        .word $21C0, $21C4, $21C8, $21CC, $21E0, $21E4, $21E8, $21EC

        ; 88/D1C5

      aShortMapSpriteSlotTiles ; 88/D1C5

        ; Read by rlCastleDrawCourtyardUnitSprites, rsUnitWindowRenderSprites.

        .word $0000, $0002, $0004, $0006, $0008, $000A, $000C, $000E
        .word $0020, $0022, $0024, $0026, $0028, $002A, $002C, $002E
        .word $0040, $0042, $0044, $0046, $0048, $004A, $004C, $004E
        .word $0060, $0062, $0064, $0066, $0068, $006A, $006C, $006E
        .word $0080, $0082, $0084, $0086, $0088, $008A, $008C, $008E
        .word $00A0, $00A2, $00A4, $00A6, $00A8, $00AA, $00AC, $00AE
        .word $0000, $0004, $0008, $000C, $0020, $0024, $0028, $002C
        .word $0040, $0044, $0048, $004C, $0060, $0064, $0068, $006C
        .word $0080, $0084, $0088, $008C, $00A0, $00A4, $00A8, $00AC

        ; 88/D255

      aTallMapSpriteSlotTiles ; 88/D255

        ; Read by rlCastleDrawCourtyardUnitSprites.

        .word $0000, $0002, $0004, $0006, $0008, $000A, $000C, $000E
        .word $0000, $0002, $0004, $0006, $0008, $000A, $000C, $000E
        .word $0000, $0002, $0004, $0006, $0008, $000A, $000C, $000E
        .word $0000, $0002, $0004, $0006, $0008, $000A, $000C, $000E
        .word $0000, $0002, $0004, $0006, $0008, $000A, $000C, $000E
        .word $0000, $0002, $0004, $0006, $0008, $000A, $000C, $000E

        ; 88/D2B5

      aTallMapSpriteSlotTiles2 ; 88/D2B5

        ; Read by rsUnitWindowRenderSprites.

        .word $0000, $0004, $0008, $000C, $0020, $0024, $0028, $002C
        .word $0040, $0044, $0048, $004C, $0060, $0064, $0068, $006C
        .word $0080, $0084, $0088, $008C, $00A0, $00A4, $00A8, $00AC
        .word $0000, $0010, $0020, $0030, $0040, $0050, $0060, $0070
        .word $0080, $0090, $00A0, $00B0, $00C0, $00D0, $00E0, $00F0
        .word $0100, $0110, $0120, $0130, $0140, $0150, $0160, $0170
        .word $0180, $0190, $01A0, $01B0, $01C0, $01D0, $01E0, $01F0
        .word $0200, $0210, $0220, $0230, $0240, $0250, $0260, $0270
        .word $0280, $0290, $02A0, $02B0, $02C0, $02D0, $02E0, $02F0
        .word $0300, $0310, $0320, $0330, $0340, $0350, $0360, $0370
        .word $0380, $0390, $03A0, $03B0, $03C0, $03D0, $03E0, $03F0

        ; 88/D365

    .endsection Data88D135Section


    .section Table88D488Section

      .al
      .xl

      aMapSpriteWalkOffsetPointers ; 88/D488

        ; Read by rsAnimateTallMovingMapSprite.

        .word $0020, $0000, $0040, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0020, $0000, $0000, $0000
        .word $0020, $0040, $0040, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0020, $0020, $0020, $0000, $0000, $0000

        ; 88/D4C6

    .endsection Table88D488Section


    .section Table88D4C6Section

      .al
      .xl

      aMapSpriteWalkOffsets ; 88/D4C6

        ; Read by rsAnimateTallMovingMapSprite.

        .word $0800, $0800, $0800, $0800, $0800, $0800, $0800, $0800
        .word $0800, $0800, $0800, $0800, $0800, $0800, $0800, $0800
        .word $0100, $0000, $0C00, $0000, $0100, $0000, $0C00, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0300, $0A00, $0700, $0000, $0300, $0A00, $0700
        .word $0000, $0000, $0600, $0000, $0000, $0000, $0600, $0000

        ; 88/D526

    .endsection Table88D4C6Section


    .section Table88D526Section

      .al
      .xl

      aShortStandingMapSpritePointers ; 88/D526

        ; Read by rsQueueShortStandingMapSpriteFrames, rsUploadShortStandingMapSprite.

        .for i in range(63)
          .long g4bppStandingMapSprites1 + (i * $0180)
        .endfor

        ; 88/D5E3

    .endsection Table88D526Section


    .section Table88D5E3Section

      .al
      .xl

      aTallStandingMapSpritePointers ; 88/D5E3

        ; Read by rsQueueTallStandingMapSpriteFrames, rsUploadTallStandingMapSprite.

        .for i in range(31)
          .long g4bppStandingMapSprites2 + (i * $0240)
        .endfor
        .rept 30
          .word $0E00
        .endrept

        ; 88/D67C

    .endsection Table88D5E3Section


    .section Unsorted88D731Section

      .al
      .xl

      rlLoadMovingMapSpriteUnused ; 88/D731

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ; Nothing reaches this. Like rsMovingMapSpriteAppendDecomp: decompresses event mover X's walking sprite into its buffer.

        lda lR18
        pha
        lda lR18+1
        pha
        phx
        phk
        plb
        .databank $88
        lda aMovingMapSpritesMapSprites,b,x
        and #$8000
        bne _D786
        lda aMovingMapSpritesMapSprites,b,x
        phx
        and #$7FFF
        sta wR0
        clc
        adc wR0
        clc
        adc wR0
        tax
        lda @l aMapMovementShortSpritePointers,x
        sta lR45
        lda @l aMapMovementShortSpritePointers+1,x
        sta lR45+1
        plx
        jsr (aSetMovingMapSpriteBufferPointersUnused,x)
        jsl rlDecompressSingle
        lda #(`g4bppcMageFemaleMapMovementSprite)<<8
        sta lR18+1
        lda #<>g4bppcMageFemaleMapMovementSprite
        sta lR18
        lda #(`aMapAction)<<8
        sta lR19+1
        lda #<>aMapAction
        sta lR19
        jsl rlAppendDecompList
        plx
        pla
        sta lR18+1
        pla
        sta lR18
        rtl


        _D786
        lda aMovingMapSpritesMapSprites,b,x
        phx
        and #$7FFF
        sta wR0
        clc
        adc wR0
        clc
        adc wR0
        tax
        lda @l aMapMovementTallSpritePointers,x
        sta lR45
        lda @l aMapMovementTallSpritePointers+1,x
        sta lR45+1
        plx
        jsr (aSetMovingMapSpriteBufferPointersUnused,x)
        jsl rlDecompressSingle
        plx
        pla
        sta lR18+1
        pla
        sta lR18
        rtl

        .databank 0

        ; 88/D7B2

    .endsection Unsorted88D731Section


    .section Table88D7B2Section

      .al
      .xl

      aSetMovingMapSpriteBufferPointersUnused ; 88/D7B2

        ; Jump table of rlLoadMovingMapSpriteUnused.
        .word <>rsSetMovingMapSpriteBuffer0Unused
        .word <>rsSetMovingMapSpriteBuffer1Unused
        .word <>rsSetMovingMapSpriteBuffer2Unused
        .word <>rsSetMovingMapSpriteBuffer3Unused

    .endsection Table88D7B2Section


    .section Unsorted88D7BASection

      .al
      .xl

      rsSetMovingMapSpriteBuffer0Unused ; 88/D7BA

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aMapAction)<<8
        sta lR47+1
        lda #<>aMapAction
        sta lR47
        rts

        .databank 0

        ; 88/D7C5

    .endsection Unsorted88D7BASection


    .section Unsorted88D7C5Section

      .al
      .xl

      rsSetMovingMapSpriteBuffer1Unused ; 88/D7C5

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aMapAction)<<8
        sta lR47+1
        lda #<>aMapAction
        sta lR47
        lda lR47
        clc
        adc #$2000
        sta lR47
        rts

        .databank 0

        ; 88/D7D8

    .endsection Unsorted88D7C5Section


    .section Unsorted88D7D8Section

      .al
      .xl

      rsSetMovingMapSpriteBuffer2Unused ; 88/D7D8

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aMapAction)<<8
        sta lR47+1
        lda #<>aMapAction
        sta lR47
        lda lR47
        clc
        adc #$4000
        sta lR47
        rts

        .databank 0

        ; 88/D7EB

    .endsection Unsorted88D7D8Section


    .section Unsorted88D7EBSection

      .al
      .xl

      rsSetMovingMapSpriteBuffer3Unused ; 88/D7EB

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aMapAction)<<8
        sta lR47+1
        lda #<>aMapAction
        sta lR47
        lda lR47
        clc
        adc #$6000
        sta lR47
        rts

        .databank 0

        ; 88/D7FE

    .endsection Unsorted88D7EBSection


    .section Unsorted88D7FESection

      .al
      .xl

      rlAnimateMovingMapSprite ; 88/D7FE

        .al
        .autsiz
        .databank ?

        ; X = an event mover (aMovingMapSprites): steps its walking frame and uploads it (short or tall).

        ; X = active mover offset

        phk
        plb
        lda aMovingMapSpriteUploadedFlags,x
        trb wUnknown000921,b
        lda aMovingMapSpriteUploadedFlags2,x
        trb wUnknown000921,b

        lda aMovingMapSpritesMapSprites,b,x
        and #$8000
        bne +

        ; Short
        jsr rsAnimateShortMovingMapSprite
        lda wUnknown000901,x
        sec
        sbc #1
        sta wUnknown000901,x
        bra ++

        ; Tall
        +
        jsr rsAnimateTallMovingMapSprite
        lda wUnknown000901,x
        sec
        sbc #1
        sta wUnknown000901,x

        +
        rtl

        .databank 0

      aMovingMapSpriteUploadedFlags ; 88/D837

        .word $0001
        .word $0002
        .word $0004
        .word $0008

      aMovingMapSpriteUploadedFlags2 ; 88/D83F

        .word $8000
        .word $4000
        .word $2000
        .word $1000

    .endsection Unsorted88D7FESection


    .section Unsorted88D847Section

      .al
      .xl

      rsAnimateShortMovingMapSprite ; 88/D847

        .al
        .autsiz
        .databank $88

        ; X = active mover offset

        ; For short map sprites

        lda wUnknown000901,x
        beq +

          jml _End

        +
        lda wUnknown000921,b
        beq ++

          and #$FF00
          beq +

            inc wUnknown000901,b,x
            jml _End

          +
          lda @l aShortMovingMapSpriteUploadFlags2,x
          tsb wUnknown000921,b

        +
        lda @l aShortMovingMapSpriteUploadFlags,x
        tsb wUnknown000921,b

        lda aMovingMapSpritesMapSprites,b,x
        and #$7FFF
        tay
        lda aMapSpriteWalkFrameDelays,y
        and #$00FF
        sta wUnknown000901,x

        lda wUnknown0008F1,x
        clc
        adc #1
        and #$0003
        sta wUnknown0008F1,x

        lda wUnknown0008F1,x
        cmp #0
        beq _D8A8

        cmp #1
        beq _D8AD

        cmp #2
        beq _D8B2

        cmp #3
        beq _D8B7

        _D8A8
        lda #size(Tile4bpp) * 0
        bra +

        _D8AD
        lda #size(Tile4bpp) * 10
        bra +

        _D8B2
        lda #size(Tile4bpp) * 20
        bra +

        _D8B7
        lda #size(Tile4bpp) * 30
        bra +

        +
        sta wMapSpriteFrameByteOffset,b

        ; Check for direction of movement
        lda wUnknown000911,x
        cmp #0
        beq _D8D7

        cmp #8
        beq _D8DC

        cmp #$0010
        beq _D8E1

        cmp #$0018
        beq _D8E6

        _D8D7
        lda #0
        bra +

        _D8DC
        lda #$0500
        bra +

        _D8E1
        lda #$0A00
        bra +

        _D8E6
        lda #$0F00
        bra +

        +
        clc
        adc wMapSpriteFrameByteOffset,b
        sta wMapSpriteFrameByteOffset,b

        jsr (aMovingMapSpriteGraphicsSetters,x)

        lda lMapSpriteGraphicsPointer,b
        clc
        adc wMapSpriteFrameByteOffset,b
        sta lR18

        lda #$00A0
        sta wR0

        lda #$C400 >> 1
        clc
        adc @l aMovingMapSpriteVRAMOffsets,x
        sta wR1
        phx
        jsl rlDMAByPointer
        plx

        lda lMapSpriteGraphicsPointer,b
        clc
        adc #$00A0
        clc
        adc wMapSpriteFrameByteOffset,b
        sta lR18

        lda #$00A0
        sta wR0

        lda #$C600 >> 1
        clc
        adc @l aMovingMapSpriteVRAMOffsets,x
        sta wR1
        phx
        jsl rlDMAByPointer
        plx

        _End
        sep #$20
        lda #$88
        pha
        plb
        rep #$20

        stz wR0
        stz wR1
        lda @l aMovingMapSpriteTileOffsets,x
        sta wR4
        ldy #<>aMovingUnitSprite24x24
        rts

        .databank 0

    .endsection Unsorted88D847Section


    .section Unsorted88D94BSection

      .al
      .xl

      aMovingMapSpriteGraphicsSetters ; 88/D94B

        .word <>rsSetMovingMapSpriteGraphics0
        .word <>rsSetMovingMapSpriteGraphics1
        .word <>rsSetMovingMapSpriteGraphics2
        .word <>rsSetMovingMapSpriteGraphics3

      aShortMovingMapSpriteUploadFlags ; 88/D953

        .word $0001
        .word $0002
        .word $0004
        .word $0008

      aShortMovingMapSpriteUploadFlags2 ; 88/D95B

        .word $8000
        .word $4000
        .word $2000
        .word $1000

    .endsection Unsorted88D94BSection


    .section Unsorted88D963Section

      .al
      .xl

      rsAnimateTallMovingMapSprite ; 88/D963

        .al
        .autsiz
        .databank $88

        lda wUnknown000901,x
        beq +

          jml _End

        +
        lda wUnknown000921,b
        beq ++

          and #$FF00
          beq +

            inc wUnknown000901,b,x
            jml _End

          +
          lda @l aTallMovingMapSpriteUploadFlags2,x
          tsb wUnknown000921,b

        +
        lda @l aTallMovingMapSpriteUploadFlags,x
        tsb wUnknown000921,b

        lda aMovingMapSpritesMapSprites,b,x
        and #$7FFF
        tay
        lda aMapSpriteWalkFrameDelays,y
        and #$00FF
        sta wUnknown000901,x

        lda wUnknown0008F1,x
        clc
        adc #1
        and #$0003
        sta wUnknown0008F1,x

        lda wUnknown0008F1,x
        cmp #0
        beq _D9C4

        cmp #1
        beq _D9C9

        cmp #2
        beq _D9CE

        cmp #3
        beq _D9D3
        
        _D9C4
        lda #0
        bra +

        _D9C9
        lda #$0200
        bra +

        _D9CE
        lda #$0400
        bra +

        _D9D3
        lda #$0600
        bra +

        +
        sta wMapSpriteFrameByteOffset,b

        lda wUnknown000911,x
        xba
        clc
        adc wMapSpriteFrameByteOffset,b
        sta wMapSpriteFrameByteOffset,b

        jsr (aMovingMapSpriteGraphicsSetters2,x)

        lda lMapSpriteGraphicsPointer,b
        clc
        adc wMapSpriteFrameByteOffset,b
        sta lR18

        lda #size(Tile4bpp) * 8
        sta wR0

        lda #$C400 >> 1
        clc
        adc @l aMovingMapSpriteVRAMOffsets,x
        sta wR1
        phx
        jsl rlDMAByPointer
        plx

        lda lMapSpriteGraphicsPointer,b
        clc
        adc #$0100
        clc
        adc wMapSpriteFrameByteOffset,b
        sta lR18

        lda #size(Tile4bpp) * 8
        sta wR0

        lda #$C600 >> 1
        clc
        adc @l aMovingMapSpriteVRAMOffsets,x
        sta wR1
        phx
        jsl rlDMAByPointer
        plx

        _End
        sep #$20
        lda #$88
        pha
        plb
        rep #$20

        phx
        lda aMovingMapSpritesMapSprites,b,x
        and #$7FFF
        asl a
        tax
        lda @l aMapSpriteWalkOffsetPointers,x
        sta wR3
        plx

        lda wUnknown0008F1,x
        asl a
        clc
        adc wUnknown000911,x
        clc
        adc wR3
        tay
        lda $D4C6,b,y
        and #$00FF
        sta wR0
        lda $D4C7,b,y
        and #$00FF
        sta wR1
        lda @l aMovingMapSpriteTileOffsets,x
        sta wR4
        ldy #<>aMovingUnitSprite32x32
        rts

        .databank 0

    .endsection Unsorted88D963Section


    .section Unsorted88DA6ASection

      .al
      .xl

      aMovingMapSpriteGraphicsSetters2 ; 88/DA6A

        .word <>rsSetMovingMapSpriteGraphics0
        .word <>rsSetMovingMapSpriteGraphics1
        .word <>rsSetMovingMapSpriteGraphics2
        .word <>rsSetMovingMapSpriteGraphics3

      aTallMovingMapSpriteUploadFlags ; 88/DA72

        .word $0001
        .word $0002
        .word $0004
        .word $0008

      aTallMovingMapSpriteUploadFlags2 ; 88/DA7A

        .word $8000
        .word $4000
        .word $2000
        .word $1000

    .endsection Unsorted88DA6ASection


    .section Unsorted88DA82Section

      .al
      .xl

      rsSetMovingMapSpriteGraphics0 ; 88/DA82

        .al
        .autsiz
        .databank ?

        lda #(`aMovingMapSpriteBuffers[0])<<8
        sta lR18+1
        lda #<>aMovingMapSpriteBuffers[0]
        sta lR18
        lda #(`aMovingMapSpriteBuffers[0])<<8
        sta $07EA+1,b
        lda #<>aMovingMapSpriteBuffers[0]
        sta lMapSpriteGraphicsPointer,b
        rts

        .databank 0

      rsSetMovingMapSpriteGraphics1 ; 88/DA99

        .al
        .autsiz
        .databank ?

        lda #(`aMovingMapSpriteBuffers[0])<<8
        sta lR18+1
        lda #<>aMovingMapSpriteBuffers[0]
        sta lR18
        lda #(`aMovingMapSpriteBuffers[0])<<8
        sta $07EA+1,b
        lda #<>aMovingMapSpriteBuffers[0]
        sta lMapSpriteGraphicsPointer,b

        lda lMapSpriteGraphicsPointer,b
        clc
        adc #$2000
        sta lMapSpriteGraphicsPointer,b
        rts

        .databank 0

      rsSetMovingMapSpriteGraphics2 ; 88/DABA

        .al
        .autsiz
        .databank ?

        lda #(`aMovingMapSpriteBuffers[0])<<8
        sta lR18+1
        lda #<>aMovingMapSpriteBuffers[0]
        sta lR18
        lda #(`aMovingMapSpriteBuffers[0])<<8
        sta lMapSpriteGraphicsPointer+1,b
        lda #<>aMovingMapSpriteBuffers[0]
        sta lMapSpriteGraphicsPointer,b

        lda lMapSpriteGraphicsPointer,b
        clc
        adc #$4000
        sta lMapSpriteGraphicsPointer,b
        rts

        .databank 0

      rsSetMovingMapSpriteGraphics3 ; 88/DADB

        .al
        .autsiz
        .databank ?

        lda #(`aMovingMapSpriteBuffers[0])<<8
        sta lR18+1
        lda #<>aMovingMapSpriteBuffers[0]
        sta lR18
        lda #(`aMovingMapSpriteBuffers[0])<<8
        sta lMapSpriteGraphicsPointer+1,b
        lda #<>aMovingMapSpriteBuffers[0]
        sta lMapSpriteGraphicsPointer,b

        lda lMapSpriteGraphicsPointer,b
        clc
        adc #$6000
        sta lMapSpriteGraphicsPointer,b
        rts

        .databank 0

    .endsection Unsorted88DA82Section


    .section Unsorted88DAFCSection

      .al
      .xl

      aMovingMapSpriteTileOffsets ; 88/DAFC

        .word $0000
        .word $0008
        .word $0020
        .word $0028

      aMovingMapSpriteVRAMOffsets ; 88/DB04

        .word $0000 >> 1
        .word $0100 >> 1
        .word $0400 >> 1
        .word $0500 >> 1

        ; 88/DB0C

    .endsection Unsorted88DAFCSection


    .section Unsorted88DB0CSection

      .al
      .xl

      rlUploadMovingUnitSpriteFrame ; 88/DB0C

        .al
        .xl
        .autsiz
        .databank ?

        ; VBlank: uploads the frame rsUpdateMovingUnitSpriteFrame picked to VRAM $6200/$6300.

        phb
        php
        phk
        plb
        .databank $88
        lda wMovingUnitSpriteState,b
        beq _DB2F
        lda $0865,b
        beq _DB2F
        ldx wActiveUnitDeploymentOffset,b
        lda aDeploymentTable._DeploymentOffsets,x
        tax
        lda aDeploymentTable._MapSpriteID,x
        and #$8000
        beq _DB32
        jml _DB90


        _DB2F
        plp
        plb
        .databank $88
        rtl


        _DB32
        sep #$20
        rep #$10
        lda #$80
        sta $2115,b
        lda #$00
        sta $4316,b
        sta $4326,b
        lda #$18
        sta $4311,b
        sta $4321,b
        lda #$01
        sta $4310,b
        sta $4320,b
        lda #$A0
        sta $4315,b
        ldx $084D,b
        stx $4312,b
        lda $084F,b
        sta $4314,b
        ldx #$6200
        stx $2116,b
        lda #$02
        sta $420B,b
        lda #$A0
        sta $4325,b
        ldx $0850,b
        stx $4322,b
        lda $084F,b
        sta $4324,b
        ldx #$6300
        stx $2116,b
        lda #$04
        sta $420B,b
        rep #$20
        plp
        plb
        .databank $88
        rtl


        _DB90
        sep #$20
        rep #$10
        lda #$80
        sta $2115,b
        lda #$18
        sta $4311,b
        sta $4321,b
        lda #$00
        sta $4315,b
        sta $4325,b
        lda #$01
        sta $4310,b
        sta $4320,b
        lda #$01
        sta $4316,b
        ldx $084D,b
        stx $4312,b
        lda $084F,b
        sta $4314,b
        ldx #$6200
        stx $2116,b
        lda #$02
        sta $420B,b
        lda #$01
        sta $4326,b
        ldx $0850,b
        stx $4322,b
        lda $084F,b
        sta $4324,b
        ldx #$6300
        stx $2116,b
        lda #$04
        sta $420B,b
        sep #$20
        plp
        plb
        .databank $88
        rtl

        .databank 0

        ; 88/DBEE

    .endsection Unsorted88DB0CSection


    .section Unsorted88DBEESection

      .al
      .xl

      rlUploadSelectedUnitMapSpriteFrame ; 88/DBEE

        .al
        .xl
        .autsiz
        .databank ?

        ; The selected unit's standing map sprite, animated by frame count (status screen).

        phb
        php
        phk
        plb
        .databank $88
        jsl rlGetSelectedUnitMapSprite
        and #$8000
        bne _DC01
        jsr rsUploadSelectedUnitShortMapSpriteFrame
        plp
        plb
        .databank $88
        rtl


        _DC01
        jsr rsUploadSelectedUnitTallMapSpriteFrame
        plp
        plb
        .databank $88
        rtl

        .databank 0

        ; 88/DC07

    .endsection Unsorted88DBEESection


    .section Unsorted88DC07Section

      .al
      .xl

      rsUploadSelectedUnitShortMapSpriteFrame ; 88/DC07

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda wVBlankEnabledFramecount
        and #$0030
        cmp #$0000
        beq _DC20
        cmp #$0010
        beq _DC25
        cmp #$0020
        beq _DC2A
        cmp #$0030
        beq _DC2F

        _DC20
        lda #$0000
        bra _DC34


        _DC25
        lda #$0080
        bra _DC34


        _DC2A
        lda #$0100
        bra _DC34


        _DC2F
        lda #$0080
        bra _DC34


        _DC34
        sta wMapSpriteFrameByteOffset,b
        jsl rlGetSelectedUnitMapSprite
        and #$7FFF
        sta wR0
        clc
        adc wR0
        clc
        adc wR0
        tax
        lda aShortStandingMapSpritePointers+1,x
        sta lR18+1
        lda aShortStandingMapSpritePointers,x
        sta lMapSpriteGraphicsPointer,b
        lda lMapSpriteGraphicsPointer,b
        clc
        adc wMapSpriteFrameByteOffset,b
        sta lR18
        lda #$0040
        sta wR0
        lda #$6E00
        sta wR1
        phx
        jsl rlDMAByPointer
        plx
        lda lMapSpriteGraphicsPointer,b
        clc
        adc #$0040
        clc
        adc wMapSpriteFrameByteOffset,b
        sta lR18
        lda #$0040
        sta wR0
        lda #$6F00
        sta wR1
        phx
        jsl rlDMAByPointer
        plx
        rts

        .databank 0

        ; 88/DC8B

      rsUploadSelectedUnitTallMapSpriteFrame ; 88/DC8B

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda wVBlankEnabledFramecount
        and #$0030
        cmp #$0000
        beq _DCA4
        cmp #$0010
        beq _DCA9
        cmp #$0020
        beq _DCAE
        cmp #$0030
        beq _DCB3

        _DCA4
        lda #$0000
        bra _DCB8


        _DCA9
        lda #$00C0
        bra _DCB8


        _DCAE
        lda #$0180
        bra _DCB8


        _DCB3
        lda #$00C0
        bra _DCB8


        _DCB8
        sta wMapSpriteFrameByteOffset,b
        jsl rlGetSelectedUnitMapSprite
        and #$7FFF
        sta wR0
        clc
        adc wR0
        clc
        adc wR0
        tax
        lda aTallStandingMapSpritePointers+1,x
        sta lR18+1
        lda aTallStandingMapSpritePointers,x
        sta lMapSpriteGraphicsPointer,b
        lda lMapSpriteGraphicsPointer,b
        clc
        adc wMapSpriteFrameByteOffset,b
        sta lR18
        lda #$0040
        sta wR0
        lda #$6E00
        sta wR1
        phx
        jsl rlDMAByPointer
        plx
        lda lMapSpriteGraphicsPointer,b
        clc
        adc #$0040
        clc
        adc wMapSpriteFrameByteOffset,b
        sta lR18
        lda #$0080
        sta wR0
        lda #$6F00
        sta wR1
        phx
        jsl rlDMAByPointer
        plx
        rts

        .databank 0

        ; 88/DD0F

    .endsection Unsorted88DC07Section


    .section Unsorted88DD0FSection

      .al
      .xl

      rlDrawActiveUnitOverlaySpriteUnused ; 88/DD0F

        ; Nothing in the build reaches this. Draws a sprite array at the active
        ; unit (wR0 = $68, wR1 = $0885 + 6): aUnknown88DD57, or aUnknown88DD77
        ; when its map sprite has bit 15 set.

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $88
        lda #$0068
        sta wR0
        lda wUnknown000885,b
        clc
        adc #$0006
        sta wR1
        stz wR4
        ldx wActiveUnitDeploymentOffset,b
        lda #$0000
        sta wR5
        jsl rlGetSelectedUnitMapSprite
        and #$8000
        bne _DD42
        sep #$20
        lda #$88
        pha
        plb
        .databank $88
        rep #$20
        lda #<>aUnknown88DD57
        tay
        bra _DD4E


        _DD42
        sep #$20
        lda #$88
        pha
        plb
        .databank $88
        rep #$20
        lda #<>aUnknown88DD77
        tay

        _DD4E
        phx
        jsl rlPushToOAMBuffer
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 88/DD57

      aUnknown88DD57 ; 88/DD57

        ; Drawn by rlDrawActiveUnitOverlaySpriteUnused when the active unit's map sprite has bit 15 clear.
        _Sprites := [[(   4,    4), $21, SpriteLarge, $00E0, 3, 1, false, false]]
        _Sprites..= [[(  16,   16), $00, SpriteSmall, $0022, 3, 2, false, false]]
        _Sprites..= [[(   8,   16), $00, SpriteSmall, $0021, 3, 2, false, false]]
        _Sprites..= [[(   0,   16), $00, SpriteSmall, $0020, 3, 2, false, false]]
        _Sprites..= [[(  16,    0), $21, SpriteLarge, $0002, 3, 2, false, false]]
        _Sprites..= [[(   0,    0), $21, SpriteLarge, $0000, 3, 2, false, false]]

        .structSpriteArray aUnknown88DD57._Sprites


      aUnknown88DD77 ; 88/DD77

        ; Drawn by rlDrawActiveUnitOverlaySpriteUnused when the active unit's map sprite has bit 15 set.
        _Sprites := [[(   4,    6), $21, SpriteLarge, $00E0, 3, 1, false, false]]
        _Sprites..= [[(   4,  -10), $21, SpriteLarge, $00E2, 3, 1, false, false]]
        _Sprites..= [[(  16,   16), $00, SpriteSmall, $0022, 3, 2, false, false]]
        _Sprites..= [[(   8,   16), $00, SpriteSmall, $0021, 3, 2, false, false]]
        _Sprites..= [[(   0,   16), $00, SpriteSmall, $0020, 3, 2, false, false]]
        _Sprites..= [[(  16,    0), $21, SpriteLarge, $0002, 3, 2, false, false]]
        _Sprites..= [[(   0,    0), $21, SpriteLarge, $0000, 3, 2, false, false]]

        .structSpriteArray aUnknown88DD77._Sprites

    .endsection Unsorted88DD0FSection


    .section Unsorted88DD9CSection

      .as
      .xl

      rlUploadMapSpriteFrame ; 88/DD9C

        .al
        .xl
        .autsiz
        .databank ?

        ; Copies a map sprite frame from lR18 to VRAM wR1: two rows of $A0 bytes, or tall rows when wR0 is not 0.

        phb
        phk
        plb
        .databank $88
        lda wR0
        bne _DDA8
        jsr rsUploadShortMapSpriteFrame
        bra _DDAB


        _DDA8
        jsr rsUploadTallMapSpriteFrame

        _DDAB
        plb
        .databank $88
        rtl

        .databank 0

        ; 88/DDAD

      rsUploadShortMapSpriteFrame ; 88/DDAD

        .al
        .xl
        .autsiz
        .databank ?

        lda #$00A0
        sta wR0
        phx
        jsl rlDMAByPointer
        plx
        lda lR18
        clc
        adc #$00A0
        sta lR18
        lda #$00A0
        sta wR0
        lda wR1
        clc
        adc #$0100
        sta wR1
        phx
        jsl rlDMAByPointer
        plx
        rts

        .databank 0

        ; 88/DDD4

      rsUploadTallMapSpriteFrame ; 88/DDD4

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0100
        sta wR0
        phx
        jsl rlDMAByPointer
        plx
        lda lR18
        clc
        adc #$0100
        sta lR18
        lda #$0100
        sta wR0
        lda wR1
        clc
        adc #$0100
        sta wR1
        phx
        jsl rlDMAByPointer
        plx
        rts

        .databank 0

        ; 88/DDFB

    .endsection Unsorted88DD9CSection


    .section Unsorted88DDFBSection

      .al
      .xl

      rlSaveDeploymentMapSprites ; 88/DDFB

        .al
        .xl
        .autsiz
        .databank ?

        ; Copies every deployment's map sprite ID to $7E4DB5 (the unit window changes them).

        ldx #$008E

        _DDFE
        lda aDeploymentTable._MapSpriteID,x
        sta $7E4DB5,x
        dec x
        dec x
        bpl _DDFE
        rtl

        .databank 0

        ; 88/DE0B

    .endsection Unsorted88DDFBSection


    .section Unsorted88DE0BSection

      .al
      .xl

      rlRestoreDeploymentMapSprites ; 88/DE0B

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$008E

        _DE0E
        lda $7E4DB5,x
        sta aDeploymentTable._MapSpriteID,x
        dec x
        dec x
        bpl _DE0E
        rtl

        .databank 0

        ; 88/DE1B

    .endsection Unsorted88DE0BSection


    .section Unsorted88DE1BSection

      .al
      .xl

      rlUploadAllStandingMapSprites ; 88/DE1B

        .al
        .xl
        .autsiz
        .databank ?

        ; Uploads the first standing frame of every deployed unit's map sprite.

        phk
        plb
        .databank $88
        stz wMapSpriteFrameByteOffset,b
        ldx #$008E

        _DE23
        lda aDeploymentTable._MapSpriteID,x
        cmp #$FFFF
        beq _DE3B
        and #$8000
        beq _DE36
        jsr rsUploadTallStandingMapSprite
        bra _DE3B


        _DE36
        jsr rsUploadShortStandingMapSprite
        bra _DE3B


        _DE3B
        dec x
        dec x
        bpl _DE23
        rtl

        .databank 0

        ; 88/DE40

      rsUploadShortStandingMapSprite ; 88/DE40

        .al
        .xl
        .autsiz
        .databank ?

        ; X = deployment: uploads its short standing frame (wMapSpriteFrameByteOffset) to its VRAM slot (aDeploymentMapSpriteVRAMOffsets).

        lda aDeploymentMapSpriteVRAMOffsets,x
        sta wTempVariable2,b
        lda aDeploymentTable._MapSpriteID,x
        and #$7FFF
        sta wR0
        clc
        adc wR0
        clc
        adc wR0
        phx
        tax
        lda aShortStandingMapSpritePointers+1,x
        sta lR18+1
        lda aShortStandingMapSpritePointers,x
        clc
        adc wMapSpriteFrameByteOffset,b
        sta lMapSpriteGraphicsPointer,b
        sta lR18
        plx
        lda #$0040
        sta wR0
        lda #$6000
        clc
        adc wTempVariable2,b
        sta wR1
        phx
        jsl rlDMAByPointer
        plx
        lda lMapSpriteGraphicsPointer,b
        clc
        adc #$0040
        sta lR18
        lda #$0040
        sta wR0
        lda #$6100
        clc
        adc wTempVariable2,b
        sta wR1
        phx
        jsl rlDMAByPointer
        plx
        rts

        .databank 0

        ; 88/DE9E

      rsUploadTallStandingMapSprite ; 88/DE9E

        .al
        .xl
        .autsiz
        .databank ?

        lda aDeploymentMapSpriteVRAMOffsets,x
        sta wTempVariable2,b
        lda aDeploymentTable._MapSpriteID,x
        and #$7FFF
        sta wR0
        clc
        adc wR0
        clc
        adc wR0
        phx
        tax
        lda aTallStandingMapSpritePointers+1,x
        sta lR18+1
        lda aTallStandingMapSpritePointers,x
        clc
        adc wMapSpriteFrameByteOffset,b
        sta lMapSpriteGraphicsPointer,b
        sta lR18
        plx
        lda #$0040
        sta wR0
        lda #$6000
        clc
        adc wTempVariable2,b
        sta wR1
        phx
        jsl rlDMAByPointer
        plx
        lda lMapSpriteGraphicsPointer,b
        clc
        adc #$0040
        sta lR18
        lda #$0080
        sta wR0
        lda #$6100
        clc
        adc wTempVariable2,b
        sta wR1
        phx
        jsl rlDMAByPointer
        plx
        rts

        .databank 0

        ; 88/DEFC

    .endsection Unsorted88DE1BSection


    .section Data88DEFCSection

      .al
      .xl

      aDeploymentMapSpriteVRAMOffsets ; 88/DEFC

        ; Read by rsUploadShortStandingMapSprite, rsUploadTallStandingMapSprite.

        .word $0800, $0820, $0840, $0860, $0880, $08A0, $08C0, $08E0
        .word $0A00, $0A20, $0A40, $0A60, $0A80, $0AA0, $0AC0, $0AE0
        .word $0C00, $0C20, $0C40, $0C60, $0C80, $0CA0, $0CC0, $0CE0
        .word $0E00, $0E20, $0E40, $0E60, $0E80, $0EA0, $0EC0, $0EE0
        .word $1000, $1020, $1040, $1060, $1080, $10A0, $10C0, $10E0
        .word $1200, $1220, $1240, $1260, $1280, $12A0, $12C0, $12E0
        .word $1400, $1440, $1480, $14C0, $1600, $1640, $1680, $16C0
        .word $1800, $1840, $1880, $18C0, $1A00, $1A40, $1A80, $1AC0
        .word $1C00, $1C40, $1C80, $1CC0, $1E00, $1E40, $1E80, $1EC0

        ; 88/DF8C

    .endsection Data88DEFCSection


    .section Unsorted88DF8CSection

      .al
      .xl

      rlAnimateUnitWindowLineSprite ; 88/DF8C

        .al
        .xl
        .autsiz
        .databank ?

        ; X = a unit window sprite slot: uploads its standing frame for the frame count, short or tall.

        lda $7E486B,x
        cmp #$FFFF
        beq _DFA0
        txa
        clc
        adc #$0060
        tax
        jsr rsAnimateUnitWindowTallSprite
        bra _DFA5


        _DFA0
        jsr rsAnimateUnitWindowShortSprite
        bra _DFA5


        _DFA5
        rtl

        .databank 0

        ; 88/DFA6

      rsAnimateUnitWindowShortSprite ; 88/DFA6

        .al
        .xl
        .autsiz
        .databank ?

        lda wVBlankEnabledFramecount
        and #$0030
        cmp #$0000
        beq _DFBF
        cmp #$0010
        beq _DFC4
        cmp #$0020
        beq _DFC9
        cmp #$0030
        beq _DFCE

        _DFBF
        lda #$0000
        bra _DFD3


        _DFC4
        lda #$0080
        bra _DFD3


        _DFC9
        lda #$0100
        bra _DFD3


        _DFCE
        lda #$0080
        bra _DFD3


        _DFD3
        sta wMapSpriteFrameByteOffset,b
        jsr rsUploadShortStandingMapSprite
        rts

        .databank 0

        ; 88/DFDA

      rsAnimateUnitWindowTallSprite ; 88/DFDA

        .al
        .xl
        .autsiz
        .databank ?

        lda wVBlankEnabledFramecount
        and #$0030
        cmp #$0000
        beq _DFF3
        cmp #$0010
        beq _DFF8
        cmp #$0020
        beq _DFFD
        cmp #$0030
        beq _E002

        _DFF3
        lda #$0000
        bra _E007


        _DFF8
        lda #$00C0
        bra _E007


        _DFFD
        lda #$0180
        bra _E007


        _E002
        lda #$00C0
        bra _E007


        _E007
        sta wMapSpriteFrameByteOffset,b
        jsr rsUploadTallStandingMapSprite
        rts

        .databank 0

        ; 88/E00E

    .endsection Unsorted88DF8CSection


    .section Unreferenced88E00ESection

      .al
      .xl

      rlUploadStandingMapSpriteByOffsetUnused ; 88/E00E

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phk
        plb
        .databank $88
        lda aDeploymentTable._DeploymentOffsets,x
        tax
        lda aDeploymentTable._MapSpriteID,x
        and #$8000
        beq _E024
        jsr rsUploadTallStandingMapSprite
        bra _E029


        _E024
        jsr rsUploadShortStandingMapSprite
        bra _E029


        _E029
        plx
        rtl

        .databank 0

        ; 88/E02B

    .endsection Unreferenced88E00ESection
    .section Unsorted8189F3Section

      .al
      .xl

      rlDrawMovingMapSprite ; 81/89F3

        .al
        .autsiz
        .databank ?

        ; Active sprite command $0F's callback for map sprites: when bit 14 of the sprite's flags is set, animates the event mover in aMovingMapSprites.wOffset and, if it is on screen, adds its position less the camera to wR0/wR1 and pushes its sprite array (wUnknown001804) to OAM.

        phb
        lda aActiveSpriteSystem.aUnknown0012E0,b,x
        bit #$4000
        beq _End

          ldx aMovingMapSprites.wOffset,b
          lda aMovingMapSprites.wActiveSpriteOffset,b,x
          cmp #$FFFF
          beq _End

            jsl rlAnimateMovingMapSprite

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

        ; Unused: 8 zero bytes.
        .fill 8, $00

    .endsection Unsorted8189F3Section


    .section Unsorted818D58Section

      .al
      .xl

      rlStopMovingMapSpriteSound ; 81/8D58

        .al
        .autsiz
        .databank ?

        ; Clears the high byte of the event mover's wMovingSound and stops the sound it names: 1 sound channel 0, anything else channel 1.


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

          jsr rsStopMapSpriteSoundChannel0
          bra _End

          +
          jsr rsStopMapSpriteSoundChannel1

        _End
        ply
        plx
        plp
        rtl

        .databank 0

      rlStopMapSpriteSounds ; 81/8D7B

        .al
        .autsiz
        .databank ?

        ; Stops the event movers' sounds on both channels (when an event ends).

        jsr rsStopMapSpriteSoundChannel0
        jsr rsStopMapSpriteSoundChannel1
        rtl

        .databank 0

      rsStopMapSpriteSoundChannel0 ; 81/8D82

        .al
        .autsiz
        .databank ?

        ; Fade mode $10 (stop) on channel 0, then rlUpdateMapSpriteSoundPanning.

        php
        sep #$20
        lda #$10
        sta aSoundChannelFadeState.bMode,b
        rep #$20
        ldx #0
        jsl rlUpdateMapSpriteSoundPanning
        plp
        rts

        .databank 0

      rsStopMapSpriteSoundChannel1 ; 81/8D95

        .al
        .autsiz
        .databank ?

        ; Fade mode $10 (stop) on channel 1, then rlUpdateMapSpriteSoundPanning.

        php
        sep #$20
        lda #$10
        sta aSoundChannelFadeState2,b
        rep #$20
        ldx #3
        jsl rlUpdateMapSpriteSoundPanning
        plp
        rts

        .databank 0

      rsStepMovingMapSprite ; 81/8DA8

        .al
        .autsiz
        .databank ?

        ; One frame of an event mover's walk (sprite Y): counts down its step timer, adds its speed (whole and fractional parts) and moves it in its direction (aMovingMapSpritePositionRoutines); with bit 0 of its flags set the camera follows (rsCameraFollowMovingMapSprite).

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

              jsr rsCameraFollowMovingMapSprite

          _End
          plx

        _End2
        rts

        .databank 0

    .endsection Unsorted818D58Section


    .section Unsorted818EABSection

      .al
      .xl

      rsCheckSpriteRightOfLeftMargin ; 81/8EAB

        .al
        .xl
        .autsiz
        .databank ?

        ; SEC if wR0 (screen X) >= $60.

        pha
        lda wR0
        cmp #$0060
        pla
        rts

        .databank 0

        ; 81/8EB3

      rsCheckSpriteLeftOfRightMargin ; 81/8EB3

        .al
        .xl
        .autsiz
        .databank ?

        ; SEC if wR0 (screen X) <= $80.

        pha
        lda #$0080
        cmp wR0
        pla
        rts

        .databank 0

        ; 81/8EBB

      rsCheckSpriteBelowTopMargin ; 81/8EBB

        .al
        .xl
        .autsiz
        .databank ?

        ; SEC if wR1 (screen Y) >= $60.

        pha
        lda wR1
        cmp #$0060
        pla
        rts

        .databank 0

        ; 81/8EC3

      rsCheckSpriteAboveBottomMargin ; 81/8EC3

        .al
        .xl
        .autsiz
        .databank ?

        ; SEC if wR1 (screen Y) <= $80.

        pha
        lda #$0080
        cmp wR1
        pla
        rts

        .databank 0

        ; 81/8ECB

    .endsection Unsorted818EABSection


