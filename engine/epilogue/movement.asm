; Placing units on the map for the epilogue, and the ASMCs that move them in and out
; of each region's scene.

    .section EpilogueMovementSection

      .al
      .xl

      rlASMCSetUpEpilogue ; B2/9396

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        phy
        jsl rlSetSaveSlotCompletionFlag
        jsl rlEvaluateEpilogueEndings
        jsl rlASMCRefreshAllUnits

        lda #0
        sta wEpilogueOtherUnitsExistFlag

        ; Sets units positions for the ending scene

        ; wR12 = max unit offset
        ; wR13 = position (in group) offset
        ; wR14 = group offset
        ; wR15 = current unit offset

        phk
        plb
        stz wR14
        stz wR15

          _OuterLoop
          ldx wR14
          lda _NextEpilogueRegion,x
          and #$00FF
          sta wR12
          stz wR13

            _InnerLoop
            ldx wR15
            lda aEpilogueMainCharacters,x
            and #$00FF
            beq +

              jsr rsEpiloguePlaceUnitOnMap

              ldx wR15
              lda aEpilogueSupportingCharacters,x
              and #$00FF
              beq +

                jsr rsEpiloguePlaceUnitOnMap

            +
            inc wR15

            lda wR15
            cmp wR12
            bne _InnerLoop

          inc wR14

          lda wR14
          cmp #EpilogueRegionSilesse + 1
          bne _OuterLoop

        ply
        plx
        plp
        plb
        rtl

        .databank 0

        _NextEpilogueRegion ; B2/93F4
        .byte ShannanEpilogueID
        .byte LeifEpilogueID
        .byte AresEpilogueID
        .byte JamkesSonEpilogueID
        .byte FebailEpilogueID
        .byte ArthurEpilogueID
        .byte LexSonEpilogueID
        .byte ClaudsSonEpilogueID
        .byte AzellesSonEpilogueID
        .byte OifeyEpilogueID
        .byte CedEpilogueID
        .byte 50
        .byte 0

      rsEpiloguePlaceUnitOnMap ; B2/9401

        .al
        .autsiz
        .databank ?

        ; A = CharacterID

        sta wR10

        lda wR14
        asl a
        tax
        lda aEpilogueUnitPositionPointers,x
        sta wR11

        ldy wR13
        lda (wR11),y
        sta wRoutineVariable1,b

        ldx #FS_Player
        lda wR10
        jsl rlUnknown84C87A
        tax
        jsl rlDeployedUnitUnsetHiddenIfAlive
        inc wR13
        inc wR13

        lda wR14
        beq +

          lda #1
          sta wEpilogueOtherUnitsExistFlag

        +
        rts

        .databank 0

      aEpilogueUnitPositionPointers ; B2/9432

        .addr aEpilogueBelhallaUnitPositions
        .addr aEpilogueIsaachUnitPositions
        .addr aEpilogueNewThraciaUnitPositions
        .addr aEpilogueAgustriaUnitPositions
        .addr aEpilogueVerdaneUnitPositions
        .addr aEpilogueYngviUnitPositions
        .addr aEpilogueFriegeUnitPositions
        .addr aEpilogueDozelUnitPositions
        .addr aEpilogueEddaUnitPositions
        .addr aEpilogueVelthomerUnitPositions
        .addr aEpilogueChalphyUnitPositions
        .addr aEpilogueSilesseUnitPositions

      aEpilogueBelhallaUnitPositions ; B2/944A

        .word pack([42, 24])
        .word pack([42, 25])
        .word pack([41, 25])

      aEpilogueIsaachUnitPositions ; B2/9450

        .word pack([46, 24])
        .word pack([47, 24])
        .word pack([46, 23])
        .word pack([47, 23])
        .word pack([46, 22])
        .word pack([47, 22])
        .word pack([46, 21])
        .word pack([47, 21])

      aEpilogueNewThraciaUnitPositions ; B2/9460

        .word pack([44, 26])
        .word pack([44, 27])
        .word pack([45, 26])
        .word pack([45, 27])
        .word pack([46, 26])
        .word pack([46, 27])
        .word pack([47, 26])
        .word pack([47, 27])
        .word pack([48, 26])
        .word pack([48, 27])

      aEpilogueAgustriaUnitPositions ; B2/9474

        .word pack([39, 23])
        .word pack([38, 23])
        .word pack([39, 22])
        .word pack([38, 22])
        .word pack([39, 21])
        .word pack([38, 21])

      aEpilogueVerdaneUnitPositions ; B2/9480

        .word pack([41, 26])
        .word pack([40, 26])
        .word pack([41, 27])

      aEpilogueYngviUnitPositions ; B2/9486

        .word pack([42, 26])
        .word pack([43, 26])
        .word pack([42, 27])
        .word pack([43, 27])
        .word pack([42, 28])
        .word pack([43, 28])

      aEpilogueFriegeUnitPositions ; B2/9492

        .word pack([39, 24])
        .word pack([38, 24])
        .word pack([37, 24])

      aEpilogueDozelUnitPositions ; B2/9498

        .word pack([39, 26])
        .word pack([38, 26])
        .word pack([39, 27])
        .word pack([38, 27])
        .word pack([37, 27])

      aEpilogueEddaUnitPositions ; B2/94A2

        .word pack([46, 25])
        .word pack([47, 25])
        .word pack([48, 25])

      aEpilogueVelthomerUnitPositions ; B2/94A8

        .word pack([46, 20])
        .word pack([47, 20])
        .word pack([46, 19])

      aEpilogueChalphyUnitPositions ; B2/94AE

        .word pack([39, 25])
        .word pack([38, 25])

      aEpilogueSilesseUnitPositions ; B2/94B2

        .word pack([41, 20])
        .word pack([42, 20])
        .word pack([41, 19])
        .word pack([42, 19])
        .word pack([43, 20])
        .word pack([43, 19])
        .word pack([44, 19])

      rlASMCEpilogueHideSeliphWifeAndJulia ; B2/94C0

        .al
        .autsiz
        .databank ?

        lda aEpilogueMainCharacters + SeliphEpilogueID
        and #$00FF
        jsr rsEpilogueHideUnitInCastle

        lda aEpilogueSupportingCharacters + SeliphEpilogueID
        and #$00FF
        beq +

          jsr rsEpilogueHideUnitInCastle

        +
        lda aEpilogueMainCharacters + JuliaEpilogueID
        and #$00FF
        beq +

          jsr rsEpilogueHideUnitInCastle

        +
        rtl

        .databank 0

      rsEpilogueHideUnitInCastle ; B2/94E3

        .al
        .autsiz
        .databank ?

        jsl rlGetUnitRAMDataPointerByID
        jsl rlGetSelectedUnitDeploymentOffset
        tax
        lda #0
        jsl rlSetUnitResidingInCastle
        rts

        .databank 0

      procEpilogueUnitMovement .block ; B2/94F4

          .structProcInfo "ED", rlProcEpilogueUnitMovementInit, rlProcEpilogueUnitMovementCycle1, aProcEpilogueUnitMovementCode
          .word 0

          wCurrentTimer       = aProcSystem.aBody0
          wNextEpilogueID     = aProcSystem.aBody1
          wMaxTimer           = aProcSystem.aBody2
          wCurrentEpilogueID  = aProcSystem.aBody3

        .bend

      rlProcEpilogueUnitMovementInit ; B2/94FE

        .al
        .autsiz
        .databank ?

        lda #0
        sta procEpilogueUnitMovement.wCurrentTimer,b,x
        lda aProcSystem.wInput1,b
        sta procEpilogueUnitMovement.wNextEpilogueID,b,x
        lda aProcSystem.wInput2,b
        sta procEpilogueUnitMovement.wMaxTimer,b,x
        lda aProcSystem.wInput0,b
        sta procEpilogueUnitMovement.wCurrentEpilogueID,b,x
        rtl

        .databank 0

      rlProcEpilogueUnitMovementCycle1 ; B2/9517

        .al
        .autsiz
        .databank ?

        lda procEpilogueUnitMovement.wCurrentTimer,b,x
        beq _Instantiate

          jml _End

        _Instantiate
        lda procEpilogueUnitMovement.wMaxTimer,b,x
        bpl +

          _Loop
          phx
          lda procEpilogueUnitMovement.wMaxTimer,b,x
          and #$00FF
          sta procEpilogueUnitMovement.wMaxTimer,b,x

          lda procEpilogueUnitMovement.wCurrentEpilogueID,b,x
          and #$00FF
          tax
          lda aEpilogueSupportingCharacters,x
          and #$00FF
          sta aEpilogueUnitMovement.wCharacterID
          bra _LoadUnit

        +
        phx
        lda procEpilogueUnitMovement.wCurrentEpilogueID,b,x
        and #$00FF
        tax
        lda aEpilogueMainCharacters,x
        and #$00FF
        beq _CheckNextUnit

        sta aEpilogueUnitMovement.wCharacterID
        cmp #Seliph
        bne +

          lda aEpilogueSupportingCharacters,x
          and #$00FF
          beq _CheckNextUnit

          plx
          bra _Loop

        +
        lda aEpilogueSupportingCharacters,x
        and #$00FF
        beq _LoadUnit

          plx
          lda procEpilogueUnitMovement.wMaxTimer,b,x
          ora #$8000
          sta procEpilogueUnitMovement.wMaxTimer,b,x
          phx

        _LoadUnit
        lda aEpilogueUnitMovement.wCharacterID
        jsl rlFillEventUnitSlot1
        bcs _BRK

        ; Handle the unit movement to coords
        lda #(`aEpilogueUnitMovement)<<8
        sta lR18+1
        lda #<>aEpilogueUnitMovement
        sta lR18
        jsl rlUnknown91B03F
        plx
        bcs _95D3

        lda procEpilogueUnitMovement.wMaxTimer,b,x
        bmi +

          lda procEpilogueUnitMovement.wCurrentEpilogueID,b,x
          inc a
          sta procEpilogueUnitMovement.wCurrentEpilogueID,b,x

        +
        lda procEpilogueUnitMovement.wMaxTimer,b,x
        and #$00FF
        sta procEpilogueUnitMovement.wCurrentTimer,b,x
        lda #<>rlProcEpilogueUnitMovementCycle2
        sta aProcSystem.aHeaderOnCycle,b,x

        _End
        lda procEpilogueUnitMovement.wCurrentTimer,b,x
        beq +

          dec a
          sta procEpilogueUnitMovement.wCurrentTimer,b,x

        +
        rtl

        _CheckNextUnit
        plx
        lda procEpilogueUnitMovement.wCurrentEpilogueID,b,x
        inc a
        sta procEpilogueUnitMovement.wCurrentEpilogueID,b,x
        cmp procEpilogueUnitMovement.wNextEpilogueID,b,x
        beq +

          jml _Instantiate

        +
        jsl rlEventEngineFreeProc
        rtl

        _95D3
        txy
        lda procEpilogueUnitMovement.wCurrentEpilogueID,b,x
        and #$00FF
        tax
        lda aEpilogueSupportingCharacters,x
        and #$00FF
        cmp aEpilogueUnitMovement.wCharacterID
        beq +

          tyx
          lda procEpilogueUnitMovement.wMaxTimer,b,x
          and #$00FF
          sta procEpilogueUnitMovement.wMaxTimer,b,x
          rtl

        +
        tyx
        lda procEpilogueUnitMovement.wMaxTimer,b,x
        ora #$8000
        sta procEpilogueUnitMovement.wMaxTimer,b,x
        rtl

        _BRK
        brk

        .databank 0

      rlProcEpilogueUnitMovementCycle2 ; B2/95FF

        .al
        .autsiz
        .databank ?

        lda bDecompressionArrayFlag,b
        bne _End

          lda aMovingMapSprites.wState,b
          cmp #0
          bne _End

            phx
            jsl rlGetSelectedUnitDeploymentOffset
            tax
            lda #0
            jsl rlSetUnitResidingInCastle
            plx
            lda procEpilogueUnitMovement.wCurrentEpilogueID,b,x
            cmp procEpilogueUnitMovement.wNextEpilogueID,b,x
            beq _FreeProc

              lda #<>rlProcEpilogueUnitMovementCycle1
              sta aProcSystem.aHeaderOnCycle,b,x

        _End
        lda procEpilogueUnitMovement.wCurrentTimer,b,x
        beq +

          dec a
          sta procEpilogueUnitMovement.wCurrentTimer,b,x

        +
        rtl

        _FreeProc
        jsl rlEventEngineFreeProc
        rtl

        .databank 0

      aProcEpilogueUnitMovementCode ; B2/9637

        PROC_HALT

      rlEpilogueCheckIfRegionHasEpilogues ; B2/9639

        .al
        .autsiz
        .databank ?

        phx
        lda aProcSystem.wInput0,b
        tax

          -
          lda aEpilogueMainCharacters,x
          and #$00FF
          bne +

            inc x
            txa
            cmp aProcSystem.wInput1,b
            bne -

        lda #0

        -
        sta wEventEngineTruthFlag

        plx
        rtl

        +
        lda #1
        bra -

        .databank 0

      rlASMCEpilogueSeliphEntrance ; B2/965C

        .al
        .autsiz
        .databank ?

        lda #SeliphEpilogueID
        sta aProcSystem.wInput0,b
        lda #ShannanEpilogueID
        sta aProcSystem.wInput1,b
        lda #20
        sta aProcSystem.wInput2,b
        jsl rlEpilogueMoveUnitsIntoBelhalla
        rtl

        .databank 0

      rlASMCEpilogueIsaachEntrance ; B2/9673

        .al
        .autsiz
        .databank ?

        lda #ShannanEpilogueID
        sta aProcSystem.wInput0,b
        lda #LeifEpilogueID
        sta aProcSystem.wInput1,b
        lda #25
        sta aProcSystem.wInput2,b
        jsl rlEpilogueMoveUnitsIntoBelhalla
        rtl

        .databank 0

      rlASMCEpilogueIsaachExit ; B2/968A

        .al
        .autsiz
        .databank ?

        lda #ShannanEpilogueID
        sta aProcSystem.wInput0,b
        lda #LeifEpilogueID
        sta aProcSystem.wInput1,b
        lda #45
        sta aProcSystem.wInput2,b
        lda #pack([45, 16])
        sta aEpilogueUnitMovement.wDestinationCoordinates
        jsl rlEpilogueMoveUnitsOutOfBelhalla
        rtl

        .databank 0

      rlASMCEpilogueNewThraciaEntrance ; B2/96A8

        .al
        .autsiz
        .databank ?

        lda #LeifEpilogueID
        sta aProcSystem.wInput0,b
        lda #AresEpilogueID
        sta aProcSystem.wInput1,b
        lda #30
        sta aProcSystem.wInput2,b
        jsl rlEpilogueMoveUnitsIntoBelhalla
        rtl

        .databank 0

      rlASMCEpilogueNewThraciaExit ; B2/96BF

        .al
        .autsiz
        .databank ?

        lda #LeifEpilogueID
        sta aProcSystem.wInput0,b
        lda #AresEpilogueID
        sta aProcSystem.wInput1,b
        lda #55
        sta aProcSystem.wInput2,b
        lda #pack([48, 31])
        sta aEpilogueUnitMovement.wDestinationCoordinates
        jsl rlEpilogueMoveUnitsOutOfBelhalla
        rtl

        .databank 0

      rlASMCEpilogueAgustriaEntrance ; B2/96DD

        .al
        .autsiz
        .databank ?

        lda #AresEpilogueID
        sta aProcSystem.wInput0,b
        lda #JamkesSonEpilogueID
        sta aProcSystem.wInput1,b
        lda #32
        sta aProcSystem.wInput2,b
        jsl rlEpilogueMoveUnitsIntoBelhalla
        rtl

        .databank 0

      rlASMCEpilogueAgustriaExit ; B2/96F4

        .al
        .autsiz
        .databank ?

        lda #AresEpilogueID
        sta aProcSystem.wInput0,b
        lda #JamkesSonEpilogueID
        sta aProcSystem.wInput1,b
        lda #40
        sta aProcSystem.wInput2,b
        lda #pack([34, 22])
        sta aEpilogueUnitMovement.wDestinationCoordinates
        jsl rlEpilogueMoveUnitsOutOfBelhalla
        rtl

        .databank 0

      rlASMCEpilogueVerdaneEntrance ; B2/9712

        .al
        .autsiz
        .databank ?

        lda #JamkesSonEpilogueID
        sta aProcSystem.wInput0,b
        lda #FebailEpilogueID
        sta aProcSystem.wInput1,b
        lda #20
        sta aProcSystem.wInput2,b
        jsl rlEpilogueMoveUnitsIntoBelhalla
        rtl

        .databank 0

      rlASMCEpilogueVerdaneExit ; B2/9729

        .al
        .autsiz
        .databank ?

        lda #JamkesSonEpilogueID
        sta aProcSystem.wInput0,b
        lda #FebailEpilogueID
        sta aProcSystem.wInput1,b
        lda #45
        sta aProcSystem.wInput2,b
        lda #pack([34, 22])
        sta aEpilogueUnitMovement.wDestinationCoordinates
        jsl rlEpilogueMoveUnitsOutOfBelhalla
        rtl

        .databank 0

      rlASMCEpilogueYngviEntrance ; B2/9747

        .al
        .autsiz
        .databank ?

        lda #FebailEpilogueID
        sta aProcSystem.wInput0,b
        lda #ArthurEpilogueID
        sta aProcSystem.wInput1,b
        lda #25
        sta aProcSystem.wInput2,b
        jsl rlEpilogueMoveUnitsIntoBelhalla
        rtl

        .databank 0

      rlASMCEpilogueYngviExit ; B2/975E

        .al
        .autsiz
        .databank ?

        lda #FebailEpilogueID
        sta aProcSystem.wInput0,b
        lda #ArthurEpilogueID
        sta aProcSystem.wInput1,b
        lda #45
        sta aProcSystem.wInput2,b
        lda #pack([39, 31])
        sta aEpilogueUnitMovement.wDestinationCoordinates
        jsl rlEpilogueMoveUnitsOutOfBelhalla
        rtl

        .databank 0

      rlASMCEpilogueFriegeEntrance ; B2/977C

        .al
        .autsiz
        .databank ?

        lda #ArthurEpilogueID
        sta aProcSystem.wInput0,b
        lda #LexSonEpilogueID
        sta aProcSystem.wInput1,b
        lda #20
        sta aProcSystem.wInput2,b
        jsl rlEpilogueMoveUnitsIntoBelhalla
        rtl

        .databank 0

      rlASMCEpilogueFriegeExit ; B2/9793

        .al
        .autsiz
        .databank ?

        lda #ArthurEpilogueID
        sta aProcSystem.wInput0,b
        lda #LexSonEpilogueID
        sta aProcSystem.wInput1,b
        lda #30
        sta aProcSystem.wInput2,b
        lda #pack([34, 22])
        sta aEpilogueUnitMovement.wDestinationCoordinates
        jsl rlEpilogueMoveUnitsOutOfBelhalla
        rtl

        .databank 0

      rlASMCEpilogueDozelEntrance ; B2/97B1

        .al
        .autsiz
        .databank ?

        lda #LexSonEpilogueID
        sta aProcSystem.wInput0,b
        lda #ClaudsSonEpilogueID
        sta aProcSystem.wInput1,b
        lda #25
        sta aProcSystem.wInput2,b
        jsl rlEpilogueMoveUnitsIntoBelhalla
        rtl

        .databank 0

      rlASMCEpilogueDozelExit ; B2/97C8

        .al
        .autsiz
        .databank ?

        lda #LexSonEpilogueID
        sta aProcSystem.wInput0,b
        lda #ClaudsSonEpilogueID
        sta aProcSystem.wInput1,b
        lda #45
        sta aProcSystem.wInput2,b
        lda #pack([39, 31])
        sta aEpilogueUnitMovement.wDestinationCoordinates
        jsl rlEpilogueMoveUnitsOutOfBelhalla
        rtl

        .databank 0

      rlASMCEpilogueEddaEntrance ; B2/97E6

        .al
        .autsiz
        .databank ?

        lda #ClaudsSonEpilogueID
        sta aProcSystem.wInput0,b
        lda #AzellesSonEpilogueID
        sta aProcSystem.wInput1,b
        lda #20
        sta aProcSystem.wInput2,b
        jsl rlEpilogueMoveUnitsIntoBelhalla
        rtl

        .databank 0

      rlASMCEpilogueEddaExit ; B2/97FD

        .al
        .autsiz
        .databank ?

        lda #ClaudsSonEpilogueID
        sta aProcSystem.wInput0,b
        lda #AzellesSonEpilogueID
        sta aProcSystem.wInput1,b
        lda #35
        sta aProcSystem.wInput2,b
        lda #pack([48, 31])
        sta aEpilogueUnitMovement.wDestinationCoordinates
        jsl rlEpilogueMoveUnitsOutOfBelhalla
        rtl

        .databank 0

      rlASMCEpilogueVelthomerEntrance ; B2/981B

        .al
        .autsiz
        .databank ?

        lda #AzellesSonEpilogueID
        sta aProcSystem.wInput0,b
        lda #OifeyEpilogueID
        sta aProcSystem.wInput1,b
        lda #25
        sta aProcSystem.wInput2,b
        jsl rlEpilogueMoveUnitsIntoBelhalla
        rtl

        .databank 0

      rlASMCEpilogueVelthomerExit ; B2/9832

        .al
        .autsiz
        .databank ?

        lda #AzellesSonEpilogueID
        sta aProcSystem.wInput0,b
        lda #OifeyEpilogueID
        sta aProcSystem.wInput1,b
        lda #35
        sta aProcSystem.wInput2,b
        lda #pack([45, 16])
        sta aEpilogueUnitMovement.wDestinationCoordinates
        jsl rlEpilogueMoveUnitsOutOfBelhalla
        rtl

        .databank 0

      rlASMCEpilogueChalphyEntrance ; B2/9850

        .al
        .autsiz
        .databank ?

        lda #OifeyEpilogueID
        sta aProcSystem.wInput0,b
        lda #CedEpilogueID
        sta aProcSystem.wInput1,b
        lda #20
        sta aProcSystem.wInput2,b
        jsl rlEpilogueMoveUnitsIntoBelhalla
        rtl

        .databank 0

      rlASMCEpilogueChalphyExit ; B2/9867

        .al
        .autsiz
        .databank ?

        lda #OifeyEpilogueID
        sta aProcSystem.wInput0,b
        lda #CedEpilogueID
        sta aProcSystem.wInput1,b
        lda #45
        sta aProcSystem.wInput2,b
        lda #pack([39, 31])
        sta aEpilogueUnitMovement.wDestinationCoordinates
        jsl rlEpilogueMoveUnitsOutOfBelhalla
        rtl

        .databank 0

      rlASMCEpilogueSilesseEntrance ; B2/9885

        .al
        .autsiz
        .databank ?

        lda #CedEpilogueID
        sta aProcSystem.wInput0,b
        lda #LewnysDaughterEpilogueID + 1
        sta aProcSystem.wInput1,b
        lda #20
        sta aProcSystem.wInput2,b
        jsl rlEpilogueMoveUnitsIntoBelhalla
        rtl

        .databank 0

      rlASMCEpilogueSilesseExit ; B2/989C

        .al
        .autsiz
        .databank ?

        lda #CedEpilogueID
        sta aProcSystem.wInput0,b
        lda #LewnysDaughterEpilogueID + 1
        sta aProcSystem.wInput1,b
        lda #45
        sta aProcSystem.wInput2,b
        lda #pack([45, 16])
        sta aEpilogueUnitMovement.wDestinationCoordinates
        jsl rlEpilogueMoveUnitsOutOfBelhalla
        rtl

        .databank 0

      rlEpilogueMoveUnitsIntoBelhalla ; B2/98BA

        .al
        .autsiz
        .databank ?

        jsl rlEpilogueCheckIfRegionHasEpilogues

        lda #pack([$FF, $FF])
        sta aEpilogueUnitMovement.wStartingCoordinates
        lda #pack([42, 24])
        sta aEpilogueUnitMovement.wDestinationCoordinates
        lda #MAP_SPRITE_BLUE << 8 | EventUnitSlot1 << 5 | 4
        sta aEpilogueUnitMovement.wMovementData

        lda #(`procEpilogueUnitMovement)<<8
        sta lR44+1
        lda #<>procEpilogueUnitMovement
        sta lR44
        jsl rlEventEngineCreateProc
        rtl

        .databank 0

      rlEpilogueMoveUnitsOutOfBelhalla ; B2/98E2

        .al
        .autsiz
        .databank ?

        lda #pack([42, 24])
        sta aEpilogueUnitMovement.wStartingCoordinates
        lda #MAP_SPRITE_BLUE << 8 | int(true) << 4 | 4
        sta aEpilogueUnitMovement.wMovementData

        lda #(`procEpilogueUnitMovement)<<8
        sta lR44+1
        lda #<>procEpilogueUnitMovement
        sta lR44
        jsl rlEventEngineCreateProc
        rtl

        .databank 0

      rlASMCRefreshAllUnits ; B2/98FF

        .al
        .autsiz
        .databank ?

        ldx #len(aDeploymentTable._State)

          _Loop
          lda aDeploymentTable._StateBuffer-2,x
          and #~(DeploymentStateGrayed | DeploymentStateAsleep)
          sta aDeploymentTable._State-2,x
          sta aDeploymentTable._StateBuffer-2,x
          dec x
          dec x
          bne _Loop

        rtl

        .databank 0

        ; B2/9916

    .endsection EpilogueMovementSection
