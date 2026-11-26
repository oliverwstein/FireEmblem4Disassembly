; Scripted scenes that need their own code, such as the mages attacking at
; Belhalla. The unknown routines here sit among them in the ROM.

    .section BelhallaMagesAttackSection

      .al
      .xl

      procBelhallaMagesAttack ; 9E/F61E

        .structProcInfo "ON", rlProcBelhallaMagesAttackInit, rlProcBelhallaMagesAttackCycle, aProcBelhallaMagesAttackCode

        ; Belhalla attack

      rlProcBelhallaMagesAttackInit ; 9E/F626

        .al
        .autsiz
        .databank ?

        lda #0
        sta aProcSystem.aHeaderBitfield,b,x
        sta aProcSystem.aBody5,x
        sta aProcSystem.aBody6,x
        sta $7F57F0
        sta wMapAnimationSignals

        lda #1
        sta $7F50CB

        jsl rlPauseMapSpriteAnimation
        jsl rlPauseMapTileAnimation
        rtl

        .databank 0

      rlProcBelhallaMagesAttackCycle ; 9E/F64C

        .al
        .autsiz
        .databank ?

        rtl

        .databank 0

      aProcBelhallaMagesAttackCode ; 9E/F64D

        PROC_CALL rlSpawnNextBelhallaAttackingMage
        PROC_JUMP_IF_BITS_SET _MagesAttacked, $0002

        -
        PROC_YIELD 1
        PROC_CALL rlCheckBelhallaMageProcEnded
        PROC_JUMP_IF_BITS_UNSET -, $0004

        PROC_YIELD 1
        PROC_JUMP aProcBelhallaMagesAttackCode

        ; Check targets to hit
        _MagesAttacked
        PROC_CALL rlInitBelhallaMeteorEffect
        PROC_SET_ONCYCLE rlQueueMapMagicBackgroundAll
        PROC_YIELD 16
        PROC_CALL rlUploadMapMagicBackgroundTiles
        PROC_YIELD 2
        PROC_CALL rlUploadMapMagicBackgroundTilesRest
        PROC_YIELD 2
        PROC_CALL rlUploadMapMagicBackgroundTilemap
        PROC_YIELD 2
        PROC_CALL rlCopyMapMagicBackgroundColors
        PROC_YIELD 2
        PROC_CALL rlLoadMapMagicSprites

        PROC_JUMP_IF_BITS_UNSET _F6FA, $0002

        -
        PROC_YIELD 1
        PROC_CALL rlCheckMapMagicDecompressionDone
        PROC_JUMP_IF_BITS_UNSET -, $0001

        PROC_CALL rlUploadMapMagicSpriteTiles
        PROC_YIELD 2
        PROC_CALL rlScriptedCritSaveColors

        -
        PROC_CALL rlScriptedCritDarken
        PROC_YIELD 1
        PROC_JUMP_IF_BITS_UNSET -, $0004

        PROC_SET_LOOP_COUNTER 5

        ; Meteors fall
        -
        PROC_CALL rlAdvanceBelhallaMeteorTarget
        PROC_CALL rlStartBelhallaMagesBlast
        PROC_CALL rlStartMapMagicEffect
        PROC_YIELD 128
        PROC_CALL rlEndMapMagicEffect
        PROC_CALL rlRestoreMapMagicScreenRegisters
        PROC_YIELD 1
        PROC_JUMP_WHILE_LOOP_COUNTER -

        PROC_CALL rlClearBelhallaMagesProcBit4

        -
        PROC_CALL rlScriptedCritFadeBack
        PROC_YIELD 1
        PROC_JUMP_IF_BITS_UNSET -, $0004

        _F6FA
        PROC_YIELD 16
        PROC_CALL rlEndBelhallaMagesAttack
        PROC_END

      rlInitBelhallaMeteorEffect ; 9E/F703

        .al
        .autsiz
        .databank ?

        ; Sets Meteor magic effect (4), flags $8401, and caster pixel $00FF

        lda #4
        sta wMapMagicAttackerEffect
        sta wMapMagicEffect
        lda #$8401
        sta wMapMagicFlags
        lda #$00FF
        sta wMapMagicCasterPixel
        lda #0
        sta wMapMagicSide
        rtl

        .databank 0

      rlAdvanceBelhallaMeteorTarget ; 9E/F724

        .al
        .autsiz
        .databank ?

        ; Sets wMapMagicTargetPixel from next entry in aBelhallaMeteorTargets

        phx
        lda aProcSystem.aBody6,x
        asl a
        tax
        lda aBelhallaMeteorTargets+1,x
        and #$00FF
        tay
        lda aBelhallaMeteorTargets,x
        and #$00FF
        tax
        lda aActionStructUnit1.UnitRAMPointer
        jsl rlGetMapBattleUnitScreenPosition

        lda wR0
        and #$00FF
        sta wR0
        lda wR1
        and #$00FF
        sta wR1

        lda wR1
        xba
        ora wR0
        sta wMapMagicTargetPixel

        plx
        lda aProcSystem.aBody6,x
        inc a
        sta aProcSystem.aBody6,x
        rtl

        .databank 0

      aBelhallaMeteorTargets ; 9E/F765

        .word $3106
        .word $3007
        .word $2F05
        .word $2E07
        .word $2D06

      rlEndBelhallaMagesAttack ; 9E/F76F

        .al
        .autsiz
        .databank ?

        ; Signals animation end, resumes map sprite/tile animations, and restores OAM palettes

        lda wMapAnimationSignals
        ora #$0002
        sta wMapAnimationSignals

        jsl rlResumeMapSpriteAnimation
        jsl rlResumeMapTileAnimation

        ldx #$00DE

          -
          lda aPortraitAndMapUIOAMPalettes+2,x
          sta aOAMPaletteBuffer.aPalette1,b,x
          dec x
          dec x
          bpl -

        rtl

        .databank 0

    .endsection BelhallaMagesAttackSection


    .section ClearBelhallaMagesProcBit4Section

      .al
      .xl

      rlClearBelhallaMagesProcBit4 ; 9E/F791

        .al
        .autsiz
        .databank ?

        ; Clears bit $0004 of aProcSystem.aHeaderBitfield

        phx
        lda aProcSystem.aHeaderBitfield,b,x
        and #~$0004
        sta aProcSystem.aHeaderBitfield,b,x
        plx
        rtl

        .databank 0

    .endsection ClearBelhallaMagesProcBit4Section


    .section BelhallaAttackingMagePositionsSection

      .al
      .xl

      aBelhallaAttackingMagePositions ; 9E/F811

        .word pack([4, 50])
        .word pack([8, 49])
        .word pack([4, 48])
        .word pack([8, 47])
        .word pack([4, 46])
        .word $FFFF

    .endsection BelhallaAttackingMagePositionsSection


    .section BelhallaAttackingMageDirectionsSection

      .al
      .xl

      aBelhallaAttackingMageDirections ; 9E/F81D

        .byte 4
        .byte 0
        .byte 4
        .byte 0
        .byte 4

      rlCheckBelhallaMageProcEnded ; 9E/F822

        .al
        .autsiz
        .databank ?

        ; Sets proc bit $0004 when child Belhalla mage proc aBody4 has ended

        phx
        lda aProcSystem.aBody4,b,x
        jsl rlProcEngineCheckProcEnded
        bcc +

          lda aProcSystem.aHeaderBitfield,b,x
          ora #$0004
          sta aProcSystem.aHeaderBitfield,b,x

        +
        plx
        rtl

        .databank 0

      procBelhallaAttackingMage ; 9E/F837

        .structProcInfo "ON", rlProcBelhallaAttackingMageInit, rlProcBelhallaAttackingMageCycle1, aProcBelhallaAttackingMageCode

    .endsection BelhallaAttackingMageDirectionsSection


    .section ProcBelhallaAttackingMageInitSection

      .al
      .xl

      rlProcBelhallaAttackingMageInit ; 9E/F83F

        .al
        .autsiz
        .databank $7F

        phy
        phx
        phb

        jsl rlFillScriptedUnitMapAction

        pea #$7F00
        plb
        plb

        lda #0
        sta <>aMapAction.wMapBattleStrikeSignal,b
        sta <>aMapAction.wMapBattleStrikeDone,b
        sta <>aMapAction.wMapBattleRoundRunning,b
        sta @l aMapAction.wEffectParam
        sta @l aMapAction.wSideTallSprite
        sta @l wMapMagicStart
        sta @l wMapMagicDone
        sta @l wMapAnimationSignals

        lda #2
        sta @l wMapBattleMode

        lda aScriptedUnitMapAction + structScriptedMapAttack.wDeploymentOffset
        sta aActionStructUnit1.DeploymentNumber
        sta aActionStructUnit2.DeploymentNumber

        lda aScriptedUnitMapAction + structScriptedMapAttack.wClass
        sta @l wR0
        lda aScriptedUnitMapAction + structScriptedMapAttack.wGender
        sta @l wR1
        lda aScriptedUnitMapAction + structScriptedMapAttack.wCharacterID
        sta @l wR2
        jsl rlGetMapBattleClassSprite
        sta aMapAction.wAttackerSpriteRow

        lda aScriptedUnitMapAction + structScriptedMapAttack.wXTilePosition
        sta <>aMapAction.wAttackerXTile,b
        lda aScriptedUnitMapAction + structScriptedMapAttack.wYTilePosition
        sta <>aMapAction.wAttackerYTile,b
        lda #$FFFF
        jsl rlGetClassMapBattleWeaponType
        sta aMapAction.wAttackerWeaponType

        lda #$FFFF
        sta aActionStructUnit1.WeaponID

        lda #0
        sta aMapAction.wDefenderSpriteRow
        sta aMapAction.wDefenderXTile
        sta aMapAction.wDefenderYTile
        sta aMapAction.wDefenderWeaponType

        lda aProcSystem.wInput0
        sta aMapAction.wAttackerFacing
        sta aMapAction.wDefenderFacing

        lda #1
        sta @l aMapAction.wAttackerAllegiance

        lda #4
        sta <>wMapMagicAttackerEffect,b
        sta <>wMapMagicEffect,b
        plb

        ; Set MapScrollPixels
        lda @l aMapAction.wAttackerYTile
        tay
        lda @l aMapAction.wAttackerXTile
        tax
        jsl rlGetMapBattleUnitScreenPosition

        lda #$8000
        sta @l wMapMagicFlags
        lda wR0
        and #$00FF
        sta wR0
        lda wR1
        and #$00FF
        sta wR1

        lda wR1
        xba
        ora wR0
        sta @l wMapMagicCasterPixel
        sta @l wMapMagicTargetPixel

        lda #(`rlPushToOAMBufferDualTileBase)<<8
        sta $0015E4+1
        lda #<>rlPushToOAMBufferDualTileBase
        sta $0015E4

        lda aActiveSpriteSystem.wFlag
        sta @l wMapBattleSavedSpriteEngineFlag

        lda aActiveSpriteSystem.wFlag
        ora #$4000
        sta aActiveSpriteSystem.wFlag

        plx
        lda $000302
        sta aProcSystem.aBody7,x
        stz wGameStateRoutine1,b

        lda @l $7E4EAF
        sta aActionStructUnit1.ClassID
        ply
        rtl

        .databank 0

      rlProcBelhallaAttackingMageCycle1 ; 9E/F94D

        .al
        .autsiz
        .databank ?

        phx
        phy
        phb
        php

        sep #$20
        lda #$7F
        pha
        rep #$20
        plb
        .databank $7F

        lda @l aMapAction.wAttackerFacing
        asl a
        clc
        adc @l aMapAction.wAttackerFacing
        asl a
        sta wR0
        lda @l aMapAction.wAttackerSpriteRow
        sta wR10
        lda #49
        sta wR11
        jsl rlUnsignedMultiply16By16

        lda wR12
        clc
        adc wR0
        adc #3
        tax
        lda aBattleMapSpriteData+1,x
        sta @l lR18+1
        lda aBattleMapSpriteData,x
        sta @l lR18
        lda #(`aDecompressionBuffer)<<8
        sta @l lR19+1
        lda #<>aDecompressionBuffer
        clc
        adc #0
        sta @l lR19
        plp
        plb
        jsl rlAppendDecompList
        phb
        php
        sep #$20
        lda #$7F
        pha
        rep #$20
        plb
        .databank $7F

        ; Load map weapon slashing graphics
        lda #(`g4bppcMapBattleWeaponIcons)<<8
        sta @l lR18+1
        lda #<>g4bppcMapBattleWeaponIcons
        sta @l lR18
        lda #(`aDecompressionBuffer)<<8
        sta @l lR19+1
        lda #<>aDecompressionBuffer
        clc
        adc #$4000
        sta @l lR19
        plp
        plb
        jsl rlAppendDecompList
        ply
        plx
        lda #<>rlProcBelhallaAttackingMageCycle2
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

    .endsection ProcBelhallaAttackingMageInitSection


    .section Unsorted9EF79DSection

      .al
      .xl

      rlSpawnNextBelhallaAttackingMage ; 9E/F79D

        .al
        .autsiz
        .databank ?

        ; Spawns procBelhallaAttackingMage for next entry in aBelhallaAttackingMagePositions

        phx
        lda aProcSystem.aHeaderBitfield,b,x
        and #~$0002
        and #~$0004
        sta aProcSystem.aHeaderBitfield,b,x

        lda aProcSystem.aBody5,x
        asl a
        tax
        lda aBelhallaAttackingMagePositions,x
        cmp #$FFFF
        beq _End

          pha
          and #$00FF
          sta wR0
          pla
          xba
          and #$00FF
          sta wR1
          jsl rlGetUnitByCoordinates
          bcs +

            lda #1,s
            tax
            lda aProcSystem.aBody5,x
            tax
            lda aBelhallaAttackingMageDirections,x
            and #$00FF
            sta aProcSystem.wInput0

            lda #(`procBelhallaAttackingMage)<<8
            sta lR44+1
            lda #<>procBelhallaAttackingMage
            sta lR44
            jsl rlProcEngineCreateProc

            tay
            lda #1,s
            tax
            tya
            sta aProcSystem.aBody4,b,x

          +
          lda #1,s
          tax
          lda aProcSystem.aBody5,x
          inc a
          sta aProcSystem.aBody5,x
          bra +

        _End
        lda #1,s
        tax
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0002
        sta aProcSystem.aHeaderBitfield,b,x

        +
        plx
        rtl

        .databank 0

    .endsection Unsorted9EF79DSection


    .section Unsorted9EEFF1Section

      .al
      .xl

      rlStartSoloMapBattleAnimation ; 9E/EFF1

        ; Nothing in the build reaches this. Fills the battle action structs for the
        ; selected unit alone (no opponent: aActionStructUnit2 = $FFFF), then runs
        ; rlStartMapBattleAnimation with wMapBattleMode = 2.

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phb
        jsl rlClearBattleData
        jsl rlGetSelectedUnitDeploymentOffset
        sta aActionStructUnit1
        jsl rlGetSelectedUnitClassID
        sta aActionStructUnit1.ClassID
        jsl rlGetSelectedUnitGender
        sta aActionStructUnit1.Gender
        jsl rlGetSelectedUnitCharacterID
        sta aActionStructUnit1.CharacterID
        jsl rlGetSelectedUnitDeploymentOffset
        tax
        lda aDeploymentTable._XTilePosition,x
        sta aActionStructUnit1.XPosition
        lda aDeploymentTable._YTilePosition,x
        sta aActionStructUnit1.YPosition
        pea #$7F00
        plb
        .databank ?
        plb
        .databank ?
        lda #$FFFF
        sta aActionStructUnit1.WeaponID
        lda #$0008
        sta aActionStructUnit1.ActionType
        lda #$0000
        sta aMapAction.wAttackerAllegiance
        lda #$FFFF
        sta aActionStructUnit2
        sta aActionStructUnit2.ClassID
        lda #$0000
        sta aActionStructUnit2.Gender
        sta aActionStructUnit2.XPosition
        sta aActionStructUnit2.YPosition
        sta aActionStructUnit2.WeaponID
        sta aActionStructUnit2.ActionType
        lda #$0001
        sta wBattleDistance
        sep #$20
        lda #$00
        sta $7E4EA9
        rep #$20
        lda #(`aBattleRoundsData)<<8
        sta lR18+1
        lda #<>aBattleRoundsData
        sta lR18
        lda #$0020
        sta wR0
        lda #$0002
        sta wR1
        jsl rlBuildRAMStructHeader
        lda #$0002
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$FFFF
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        plb
        .databank ?
        lda #$0002
        sta wMapBattleMode
        jml rlStartMapBattleAnimation._8014

        .databank 0

        ; 9E/F0CF

      rlStartScriptedMapBattleAnimation ; 9E/F0CF

        ; Nothing in the build reaches this. Fills the battle action structs for
        ; the unit at wR0 and the unit at wR1, then runs rlStartMapBattleAnimation with
        ; wMapBattleMode = 2. When the second unit has no usable weapon, the original
        ; branches back to the first unit's code (bra _F11F); that looks like a bug.

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda wR1
        pha
        lda wR0
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitDeploymentOffset
        sta aActionStructUnit1
        jsl rlGetSelectedUnitClassID
        sta aActionStructUnit1.ClassID
        jsl rlGetSelectedUnitGender
        sta aActionStructUnit1.Gender
        jsl rlGetSelectedUnitCharacterID
        sta aActionStructUnit1.CharacterID
        jsl rlGetSelectedUnitDeploymentOffset
        tax
        lda aDeploymentTable._XTilePosition,x
        sta aActionStructUnit1.XPosition
        lda aDeploymentTable._YTilePosition,x
        sta aActionStructUnit1.YPosition
        jsl rlGetFirstEquippableWeaponInInventory
        ldx wCurrentItemDataROMPointer,b
        bne _F11B
        lda #$FFFF
        bra _F11F


        _F11B
        jsl rlGetItemIDByInventorySlot

        _F11F
        sta aActionStructUnit1.WeaponID
        lda #$0000
        sta aActionStructUnit1.ActionType
        jsl rlGetSelectedUnitDeploymentOffset
        sta aActionStructUnit1
        tax
        lda aDeploymentTable,x
        and #$0003
        sta aMapAction.wAttackerAllegiance
        pla
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitDeploymentOffset
        sta aActionStructUnit2
        jsl rlGetSelectedUnitClassID
        sta aActionStructUnit2.ClassID
        jsl rlGetSelectedUnitGender
        sta aActionStructUnit2.Gender
        jsl rlGetSelectedUnitCharacterID
        sta aActionStructUnit2.CharacterID
        jsl rlGetSelectedUnitDeploymentOffset
        tax
        lda aDeploymentTable._XTilePosition,x
        sta aActionStructUnit2.XPosition
        lda aDeploymentTable._YTilePosition,x
        sta aActionStructUnit2.YPosition
        jsl rlGetFirstEquippableWeaponInInventory
        ldx wCurrentItemDataROMPointer,b
        bne _F185
        lda #$FFFF
        bra _F11F


        _F185
        jsl rlGetItemIDByInventorySlot
        sta aActionStructUnit2.WeaponID
        lda #$0000
        sta aActionStructUnit2.ActionType
        jsl rlGetSelectedUnitDeploymentOffset
        sta aActionStructUnit2
        tax
        lda aDeploymentTable,x
        and #$0003
        sta aMapAction.wDefenderAllegiance
        lda #$0002
        sta wMapBattleMode
        jml rlStartMapBattleAnimation._8014

        .databank 0

        ; 9E/F1B3

      rlCutsceneUnusedPlxRtl9EF1B3 ; 9E/F1B3

        ; Only plx / rtl; nothing reaches it.

        .al
        .xl
        .autsiz
        .databank ?

        ; Unreferenced (plx/rtl)

        plx
        rtl

        .databank 0

        ; 9E/F1B5

    .endsection Unsorted9EEFF1Section


    .section Unsorted9EF1D9Section

      .al
      .xl

      rlStartWarpAwayAnimationNoUnit ; 9E/F1D9

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0001
        sta wMapBattleMode
        lda #$FFFF
        sta $7E4EA9
        sta aActionStructUnit1.UnitRAMPointer
        lda #(`procWarpAway)<<8
        sta lR44+1
        lda #<>procWarpAway
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 9E/F1FA

    .endsection Unsorted9EF1D9Section


    .section Unsorted9EF1FASection

      .al
      .xl

      rlStartWarpAwayAnimation ; 9E/F1FA

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; The event unit in slot 1 warps away (warp-away ASMCs of chapters 3 and 7-10).

        lda wEventUnitSlot1Pointer,b
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitDeploymentOffset
        sta $7E4EA9
        jsl rlGetSelectedUnitClassID
        sta $7E4EAF
        jsl rlGetSelectedUnitGender
        sta aActionStructUnit1.CharacterID
        jsl rlGetSelectedUnitCharacterID
        sta aActionStructUnit1.UnitRAMPointer
        jsl rlGetSelectedUnitDeploymentOffset
        tax
        lda aDeploymentTable._XTilePosition,x
        sta wBattleDistance
        lda aDeploymentTable._YTilePosition,x
        sta wBattleQuotePointer
        lda #$0000
        sta wMapBattleMode
        lda #(`procWarpAway)<<8
        sta lR44+1
        lda #<>procWarpAway
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 9E/F24B

      procWarpAway ; 9E/F24B

        .structProcInfo "ON", rlProcWarpAwayInit, rlProcReturnHomeQueueGraphics, aProcReturnHomeCode

      rlProcWarpAwayInit ; 9E/F253

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        phb
        pea #$7F00
        plb
        .databank ?
        plb
        .databank ?
        lda #$0000
        sta <>aMapAction.wMapBattleStrikeSignal,b
        sta <>aMapAction.wMapBattleStrikeDone,b
        sta <>aMapAction.wMapBattleRoundRunning,b
        sta aMapAction.wEffectParam
        sta aMapAction.wSideTallSprite
        sta wMapMagicStart
        sta wMapMagicDone
        sta wMapAnimationSignals
        lda $7E4EA9
        sta aActionStructUnit1
        sta aActionStructUnit2
        lda $7E4EAF
        sta @l wR0
        lda aActionStructUnit1.CharacterID
        sta @l wR1
        lda aActionStructUnit1.UnitRAMPointer
        sta @l wR2
        jsl rlGetMapBattleClassSprite
        sta <>aMapAction.wAttackerSpriteRow,b
        lda wBattleDistance
        sta <>aMapAction.wAttackerXTile,b
        lda wBattleQuotePointer
        sta <>aMapAction.wAttackerYTile,b
        lda #$FFFF
        jsl rlGetClassMapBattleWeaponType
        sta $454A,b
        lda #$FFFF
        sta aActionStructUnit1.WeaponID
        lda #$0000
        sta <>aMapAction.wDefenderSpriteRow,b
        sta <>aMapAction.wDefenderXTile,b
        sta <>aMapAction.wDefenderYTile,b
        sta <>aMapAction.wDefenderWeaponType,b
        lda #$0006
        sta <>aMapAction.wAttackerFacing,b
        sta <>aMapAction.wDefenderFacing,b
        lda #$0020
        sta <>wMapMagicEffect,b
        plb
        .databank ?
        lda aMapAction.wAttackerYTile
        tay
        lda aMapAction.wAttackerXTile
        tax
        jsl rlGetMapBattleUnitScreenPosition
        lda #$8000
        sta wMapMagicFlags
        lda $7E4EAF
        sta aActionStructUnit1.ClassID
        lda wR0
        and #$00FF
        sta wR0
        lda wR1
        and #$00FF
        sta wR1
        lda wR1
        xba
        ora wR0
        sta wMapMagicCasterPixel
        sta wMapMagicTargetPixel
        lda #(`rlPushToOAMBufferDualTileBase)<<8
        sta @l lActiveSpriteRenderer+1
        lda #<>rlPushToOAMBufferDualTileBase
        sta @l lActiveSpriteRenderer
        lda @l aActiveSpriteSystem
        sta wMapBattleSavedSpriteEngineFlag
        lda @l aActiveSpriteSystem
        ora #$4000
        sta @l aActiveSpriteSystem
        plx
        lda @l wGameStateRoutine1
        sta @l aProcSystem.aBody7,x
        stz wGameStateRoutine1,b
        jsl rlPauseMapSpriteAnimation
        jsl rlPauseMapTileAnimation
        ply
        rtl

        .databank 0

    .endsection Unsorted9EF1FASection


    .section Unsorted9EF353Section

      .al
      .xl

      rlStartWarpInAnimation ; 9E/F353

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta wMapAnimationSignals
        lda #(`procWarpIn)<<8
        sta lR44+1
        lda #<>procWarpIn
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 9E/F369
      rlStartWarpInAnimationVariant ; 9E/F369

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0004
        sta wMapAnimationSignals
        lda #(`procWarpIn)<<8
        sta lR44+1
        lda #<>procWarpIn
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 9E/F37F

    .endsection Unsorted9EF353Section


    .section Unsorted9EF37FSection

      .al
      .xl

      procWarpIn ; 9E/F37F

        .structProcInfo "ON", rlProcWarpInInit, rlProcReturnHomeQueueGraphics, aProcWarpInCode

      rlProcWarpInInit ; 9E/F387

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        phb
        pea #$7F00
        plb
        .databank ?
        plb
        .databank ?
        sep #$20
        lda #$00
        sta $7E4EA9
        rep #$20
        lda #$0000
        sta <>aMapAction.wMapBattleStrikeSignal,b
        sta <>aMapAction.wMapBattleStrikeDone,b
        sta <>aMapAction.wMapBattleRoundRunning,b
        sta aMapAction.wEffectParam
        sta aMapAction.wSideTallSprite
        sta wMapMagicStart
        sta wMapMagicDone
        lda #$0001
        sta wMapBattleMode
        lda #$FFFF
        sta aActionStructUnit1
        sta aActionStructUnit2
        lda $7E4EAF
        sta @l wR0
        lda aActionStructUnit1.CharacterID
        sta @l wR1
        lda #$FFFF
        sta @l wR2
        jsl rlGetMapBattleClassSprite
        sta <>aMapAction.wAttackerSpriteRow,b
        lda wBattleDistance
        sta <>aMapAction.wAttackerXTile,b
        lda wBattleQuotePointer
        sta <>aMapAction.wAttackerYTile,b
        lda #$FFFF
        jsl rlGetClassMapBattleWeaponType
        sta $454A,b
        lda #$FFFF
        sta aActionStructUnit1.WeaponID
        lda #$0000
        sta <>aMapAction.wDefenderSpriteRow,b
        sta <>aMapAction.wDefenderXTile,b
        sta <>aMapAction.wDefenderYTile,b
        sta <>aMapAction.wDefenderWeaponType,b
        lda #$0006
        sta <>aMapAction.wAttackerFacing,b
        sta <>aMapAction.wDefenderFacing,b
        lda #$0029
        sta <>wMapMagicEffect,b
        plb
        .databank ?
        lda aMapAction.wAttackerYTile
        tay
        lda aMapAction.wAttackerXTile
        tax
        jsl rlGetMapBattleUnitScreenPosition
        lda #$8000
        sta wMapMagicFlags
        lda wR0
        and #$00FF
        sta wR0
        lda wR1
        and #$00FF
        sta wR1
        lda wR1
        xba
        ora wR0
        sta wMapMagicTargetPixel
        sta wMapMagicCasterPixel
        lda #(`rlPushToOAMBufferDualTileBase)<<8
        sta @l lActiveSpriteRenderer+1
        lda #<>rlPushToOAMBufferDualTileBase
        sta @l lActiveSpriteRenderer
        lda @l aActiveSpriteSystem
        sta wMapBattleSavedSpriteEngineFlag
        lda @l aActiveSpriteSystem
        ora #$4000
        sta @l aActiveSpriteSystem
        plx
        lda @l wGameStateRoutine1
        sta @l aProcSystem.aBody7,x
        stz wGameStateRoutine1,b
        lda #$0000
        sta aProcSystem.aHeaderBitfield,b,x
        lda #$0038
        sta aProcSystem.aBody3,b,x
        lda $7E4EAF
        sta aActionStructUnit1.ClassID
        jsl rlPauseMapSpriteAnimation
        jsl rlPauseMapTileAnimation
        ply
        rtl

        .databank 0

    .endsection Unsorted9EF37FSection


    .section Unsorted9EF49ESection

      .al
      .xl

      aProcWarpInCode ; 9E/F49E

        PROC_YIELD 1
        _F4A0
        PROC_YIELD 1
        PROC_CALL rlWaitWarpDecompressionAndTimer
        PROC_JUMP_IF_BITS_UNSET _F4A0, $0001
        PROC_SET_ONCYCLE rlProcReturnHomeQueueSpriteData
        PROC_YIELD 56
        PROC_CALL rlUploadMapBattleShadowTiles
        PROC_YIELD 4
        PROC_CALL rlMapActionQueueEffectGraphics
        PROC_YIELD 4
        PROC_CALL rlMapActionUploadEffectGraphics
        PROC_YIELD 4
        PROC_CALL rlCreateMapBattleAttackerSprites
        PROC_CALL rlFreezeWarpAttackerSprites
        PROC_YIELD 2
        PROC_CALL rlLoadMapMagicSprites
        PROC_JUMP_IF_BITS_UNSET _F4F3, $0002
        _F4DF
        PROC_YIELD 1
        PROC_CALL rlCheckMapMagicDecompressionDone
        PROC_JUMP_IF_BITS_UNSET _F4DF, $0001
        PROC_CALL rlUploadMapMagicSpriteTiles
        PROC_YIELD 2
        _F4F3
        PROC_CALL rlStartMapMagicEffect
        PROC_YIELD 16
        _F4FA
        PROC_YIELD 1
        PROC_CALL rlReturnHomeStartMagicRound
        PROC_YIELD 1
        PROC_SET_ONCYCLE rlProcWaitMapMagicStartCycle
        _F507
        PROC_YIELD 1
        PROC_JUMP_IF_BITS_UNSET _F507, $0002
        PROC_YIELD 1
        PROC_JUMP_IF_BITS_UNSET _F4FA, $0001
        PROC_YIELD 4
        PROC_CALL rlEndMapMagicEffect
        PROC_CALL rlRestoreMapMagicScreenRegisters
        PROC_CALL rlWaitMapAnimationSignalBit2
        PROC_JUMP_IF_BITS_UNSET _F53F, $0002
        _F52E
        PROC_YIELD 1
        PROC_CALL rlSignalMapAnimationAndWaitBit3
        PROC_JUMP_IF_BITS_UNSET _F52E, $0004
        PROC_JUMP _F541

        _F53F
        PROC_YIELD 30
        _F541
        PROC_CALL rlEndReturnHomeSprites
        PROC_CALL rlLoadCursorSpriteGraphics
        PROC_YIELD 2
        PROC_CALL rlLoadMapSpriteOAMPalettes
        PROC_YIELD 1
        PROC_CALL rlSignalMapAnimationDone
        PROC_END


        ; 9E/F55B

    .endsection Unsorted9EF49ESection


    .section Unsorted9EF55BSection

      .al
      .xl

      rlWaitWarpDecompressionAndTimer ; 9E/F55B

        .al
        .xl
        .autsiz
        .databank ?

        ; Waits for aBody3 timer and bDecompressionArrayFlag == 0, then sets proc bit $0001

        lda aProcSystem.aBody3,b,x
        bne _F570
        lda bDecompressionArrayFlag,b
        bne _F577
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0001
        sta aProcSystem.aHeaderBitfield,b,x
        bra _F577


        _F570
        lda aProcSystem.aBody3,b,x
        dec a
        sta aProcSystem.aBody3,b,x

        _F577
        rtl

        .databank 0

        ; 9E/F578

      rlFreezeWarpAttackerSprites ; 9E/F578

        .al
        .xl
        .autsiz
        .databank ?

        ; Copies attacker sprite slots to defender slots and freezes their active sprites ($8000)

        phx
        lda aMapAction.wMapBattleAttackerSpriteSlot
        sta aMapAction.wMapBattleDefenderSpriteSlot
        lda aMapAction.wMapBattleAttackerAuxSpriteSlot
        sta aMapAction.wMapBattleDefenderAuxSpriteSlot
        lda aMapAction.wMapBattleAttackerSpriteSlot
        tax
        lda aActiveSpriteSystem.aXPosition,b,x
        ora #$8000
        sta aActiveSpriteSystem.aXPosition,b,x
        lda aMapAction.wMapBattleAttackerAuxSpriteSlot
        cmp #$FFFF
        beq _F5AA
        tax
        lda aActiveSpriteSystem.aXPosition,b,x
        ora #$8000
        sta aActiveSpriteSystem.aXPosition,b,x

        _F5AA
        plx
        rtl

        .databank 0

      rlUnfreezeWarpAttackerSprites ; 9E/F5AC

        .al
        .xl
        .autsiz
        .databank ?

        ; Unfreezes attacker active sprites (clears $8000)

        phx
        lda aMapAction.wMapBattleAttackerSpriteSlot
        tax
        lda aActiveSpriteSystem.aXPosition,b,x
        and #$7FFF
        sta aActiveSpriteSystem.aXPosition,b,x
        lda aMapAction.wMapBattleAttackerAuxSpriteSlot
        cmp #$FFFF
        beq _F5CE
        tax
        lda aActiveSpriteSystem.aXPosition,b,x
        and #$7FFF
        sta aActiveSpriteSystem.aXPosition,b,x

        _F5CE
        plx
        rtl

        .databank 0

        ; 9E/F5D0

    .endsection Unsorted9EF55BSection


    .section Unsorted9EF5D0Section

      .al
      .xl

      rlWaitMapAnimationSignalBit2 ; 9E/F5D0

        .al
        .xl
        .autsiz
        .databank ?

        ; Sets proc bit $0002 when wMapAnimationSignals bit $0004 is set

        phx
        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFD
        and #$FFFB
        sta aProcSystem.aHeaderBitfield,b,x
        lda wMapAnimationSignals
        bit #$0004
        beq _F5EF
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0002
        sta aProcSystem.aHeaderBitfield,b,x

        _F5EF
        plx
        rtl

        .databank 0

        ; 9E/F5F1

      rlSignalMapAnimationAndWaitBit3 ; 9E/F5F1

        .al
        .xl
        .autsiz
        .databank ?

        ; Sets wMapAnimationSignals bit $0010 and sets proc bit $0004 when bit $0008 is set

        lda wMapAnimationSignals
        ora #$0010
        sta wMapAnimationSignals
        lda wMapAnimationSignals
        bit #$0008
        beq _F60E
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0004
        sta aProcSystem.aHeaderBitfield,b,x

        _F60E
        rtl

        .databank 0

        ; 9E/F60F

    .endsection Unsorted9EF5D0Section


    .section Unsorted9EF60FSection

      .al
      .xl

      rlStartBelhallaMagesAttack ; 9E/F60F

        .al
        .autsiz
        .databank ?

        lda #(`procBelhallaMagesAttack)<<8
        sta lR44+1
        lda #<>procBelhallaMagesAttack
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

    .endsection Unsorted9EF60FSection


    .section Unsorted9EF9DFSection

      .al
      .xl

      rlProcBelhallaAttackingMageCycle2 ; 9E/F9DF

        .al
        .autsiz
        .databank ?

        rtl

        .databank 0

    .endsection Unsorted9EF9DFSection


    .section Unsorted9EF9E0Section

      .al
      .xl

      aProcBelhallaAttackingMageCode ; 9E/F9E0

        PROC_YIELD 44
        PROC_SET_ONCYCLE rlProcReturnHomeQueueSpriteData
        PROC_YIELD 32
        PROC_CALL rlUploadMapBattleShadowTiles
        PROC_YIELD 2
        PROC_CALL rlCreateMapBattleAttackerSprites
        PROC_CALL rlMapBattlePlaySound32
        PROC_YIELD 1
        PROC_CALL rlStartBelhallaMageRoundScript
        PROC_YIELD 32
        PROC_CALL rlEndBelhallaMageRoundScript
        PROC_CALL rlLoadCursorSpriteGraphics
        PROC_YIELD 4
        PROC_CALL rlLoadMapSpriteOAMPalettes
        PROC_YIELD 1
        PROC_END

    .endsection Unsorted9EF9E0Section


    .section Unsorted9EFA17Section

      .al
      .xl

      rlFillScriptedUnitMapAction ; 9E/FA17

        .al
        .autsiz
        .databank ?

        ; Copies selected unit fields into aScriptedUnitMapAction

        phx
        jsl rlGetSelectedUnitDeploymentOffset
        sta aScriptedUnitMapAction + structScriptedMapAttack.wDeploymentOffset
        jsl rlGetSelectedUnitClassID
        sta aScriptedUnitMapAction + structScriptedMapAttack.wClass
        jsl rlGetSelectedUnitGender
        sta aScriptedUnitMapAction + structScriptedMapAttack.wGender
        jsl rlGetSelectedUnitCharacterID
        sta aScriptedUnitMapAction + structScriptedMapAttack.wCharacterID
        jsl rlGetSelectedUnitDeploymentOffset
        tax
        lda aDeploymentTable._XTilePosition,x
        sta aScriptedUnitMapAction + structScriptedMapAttack.wXTilePosition
        lda aDeploymentTable._YTilePosition,x
        sta aScriptedUnitMapAction + structScriptedMapAttack.wYTilePosition
        plx
        rtl

        .databank 0

      rlStartBelhallaMageRoundScript ; 9E/FA4F

        .al
        .autsiz
        .databank ?

        ; Starts round script for Belhalla attacking mage via rsGetMapBattleRoundScripts

        phb
        php
        sep #$20
        lda #$7F
        pha
        rep #$20
        plb
        .databank $7F

        phy
        phx
        lda #0
        sta @l aMapAction.wMapBattleStrikeSignal
        sta @l aMapAction.wMapBattleStrikeDone
        sta aProcSystem.aHeaderBitfield,x

        lda #1
        sta @l aMapAction.wMapBattleRoundRunning
        lda <>aMapAction.lAttackerSpriteData+1,b
        sta <>aMapAction.lAttackerRoundScript+1,b
        sta <>aMapAction.lAttackerAuxRoundScript+1,b

        lda <>aMapAction.lAttackerSpriteData,b
        sta lR18
        lda $4598+1,b
        sta lR18+1
        lda <>aMapAction.wAttackerFacing,b
        sta wR0
        lda #0
        jsr rsGetMapBattleRoundScripts
        stx <>aMapAction.lAttackerRoundScript,b
        sty <>aMapAction.lAttackerAuxRoundScript,b
        plx
        ply
        plp
        plb
        rtl

        .databank 0

      rlEndBelhallaMageRoundScript ; 9E/FA9A

        .al
        .autsiz
        .databank ?

        ; Clears mage sprite slots, unhides unit, and restores wGameStateRoutine1 and sprite engine flag

        phx
        lda aMapAction.wMapBattleAttackerSpriteSlot
        tax
        stz aActiveSpriteSystem.aTypeOffset,b,x
        lda aMapAction.wMapBattleAttackerAuxSpriteSlot
        tax
        cpx #$FFFF
        beq +

          stz aActiveSpriteSystem.aTypeOffset,b,x

        +
        lda $7E4EA9
        tax
        jsl rlDeployedUnitUnsetHiddenIfAlive
        plx
        lda aProcSystem.aBody7,b,x
        sta wGameStateRoutine1,b
        lda #(`rlPushToOAMBuffer)<<8
        sta lActiveSpriteRenderer+1,b
        lda #<>rlPushToOAMBuffer
        sta lActiveSpriteRenderer,b

        lda wMapBattleSavedSpriteEngineFlag
        sta aActiveSpriteSystem.wFlag,b
        rtl

        .databank 0

      rlStartBelhallaMagesBlast ; 9E/FAD4

        .al
        .autsiz
        .databank ?

        lda #(`procBelhallaMagesBlast)<<8
        sta lR44+1
        lda #<>procBelhallaMagesBlast
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

      procBelhallaMagesBlast ; 9E/FAE3

        .structProcInfo "ON", rlProcBelhallaMagesBlastInit, rlProcBelhallaMagesBlastCycle, aProcBelhallaMagesBlastCode
        
      rlProcBelhallaMagesBlastInit ; 9E/FAEB

        .al
        .autsiz
        .databank ?

        phx
        lda #0
        sta aProcSystem.aHeaderBitfield,b,x
        sta aMapAction.wMapBattlePaletteRestoreFlag
        plx
        rtl

        .databank 0

      aBelhallaBlastUnitCoordLists ; 9E/FAF8

        .long aBelhallaBlastUnitCoords0
        .long aBelhallaBlastUnitCoords1
        .long aBelhallaBlastUnitCoords2
        .long aBelhallaBlastUnitCoords3
        .long aBelhallaBlastUnitCoords4

      aBelhallaBlastUnitCoords0 ; 9E/FB07

        .byte $05, $30
        .byte $06, $30
        .byte $07, $30
        .byte $05, $31
        .byte $06, $31
        .byte $07, $31
        .byte $05, $32
        .byte $06, $32
        .byte $07, $32
        .word $FFFF

      aBelhallaBlastUnitCoords1 ; 9E/FB1B

        .byte $06, $2F
        .byte $07, $2F
        .byte $06, $30
        .byte $07, $30
        .byte $06, $31
        .byte $07, $31
        .word $FFFF

      aBelhallaBlastUnitCoords2 ; 9E/FB29

        .byte $05, $2E
        .byte $06, $2E
        .byte $05, $2F
        .byte $06, $2F
        .byte $05, $30
        .byte $06, $30
        .word $FFFF

      aBelhallaBlastUnitCoords3 ; 9E/FB37

        .byte $06, $2D
        .byte $07, $2D
        .byte $06, $2E
        .byte $07, $2E
        .byte $06, $2F
        .byte $07, $2F
        .word $FFFF

      aBelhallaBlastUnitCoords4 ; 9E/FB45

        .byte $06, $2C
        .byte $05, $2D
        .byte $06, $2D
        .byte $07, $2D
        .byte $05, $2E
        .byte $06, $2E
        .byte $07, $2E
        .word $FFFF

      rlProcBelhallaMagesBlastCycle ; 9E/FB55

        .al
        .autsiz
        .databank ?

        rtl

        .databank 0

      aProcBelhallaMagesBlastCode ; 9E/FB56

        PROC_YIELD 1

        -
        PROC_YIELD 1
        PROC_CALL rlWaitBelhallaBlastStrikeStart
        PROC_JUMP_IF_BITS_UNSET -, $0004

        -
        PROC_YIELD 1
        PROC_CALL rlStepBelhallaBlastFlash
        PROC_CALL rlWaitBelhallaBlastStrikeEnd
        PROC_JUMP_IF_BITS_UNSET -, $0004

        PROC_CALL rlUngrayBelhallaBlastUnits
        PROC_YIELD 16
        PROC_END

      rlWaitBelhallaBlastStrikeStart ; 9E/FB80

        .al
        .autsiz
        .databank ?

        ; Sets proc bit $0004 when aMapAction.wMapBattleStrikeSignal != 0

        phx
        lda aProcSystem.aHeaderBitfield,b,x
        and #~$0004
        sta aProcSystem.aHeaderBitfield,b,x

        lda aMapAction.wMapBattleStrikeSignal
        beq +

          lda aProcSystem.aHeaderBitfield,b,x
          ora #$0004
          sta aProcSystem.aHeaderBitfield,b,x

        +
        plx
        rtl

        .databank 0

      rlWaitBelhallaBlastStrikeEnd ; 9E/FB9B

        .al
        .autsiz
        .databank ?

        ; Sets proc bit $0004 when aMapAction.wMapBattleStrikeSignal == 0

        phx
        lda aProcSystem.aHeaderBitfield,b,x
        and #~$0004
        sta aProcSystem.aHeaderBitfield,b,x

        lda aMapAction.wMapBattleStrikeSignal
        bne +

          lda aProcSystem.aHeaderBitfield,b,x
          ora #$0004
          sta aProcSystem.aHeaderBitfield,b,x

        +
        plx
        rtl

        .databank 0

      rlStepBelhallaBlastFlash ; 9E/FBB6

        .al
        .autsiz
        .databank ?

        ; Grays out blast target units and runs Belhalla blast palette flash

        phy
        phx
        lda aMapAction.wMapBattleStrikeSignal
        bne +

          jml _End

        +
        lda aMapAction.wMapBattlePaletteRestoreFlag
        bne _FC23

          jsl rlGrayOutBelhallaBlastUnits

          lda #9
          xba
          lsr a
          lsr a
          lsr a
          tax
          ldy #0

            -
            lda aBGPaletteBuffer,b,x
            sta wR0

            phb
            php
            sep #$20
            lda #$7F
            pha
            rep #$20
            plb
            .databank $7F

            lda wR0
            sta <>aMapAction.aMapBattleSavedPalette,b,y

            plp
            plb

            inc x
            inc x
            inc y
            inc y
            cpy #$0020
            bne -

          ldx #$01E2

            -
            lda #$7FFF
            sta aBGPaletteBuffer,b,x
            inc x
            inc x
            cpx #$0200
            bne -

          lda #1
          sta @l aMapAction.wMapBattlePaletteRestoreFlag
          lda #$0091
          sta wR0
          lda @l wMapMagicTargetPixel
          and #$00FF
          jsl rlGetSoundPanFromXPixel
          ora wR0
          jsl rlPlaySoundEffect2 ; sound
        
        _FC23
        lda #(`$7F45AC)<<8
        sta lR18+1
        lda #<>$7F45AC
        clc
        adc #2
        sta lR18
        ldy #$000F
        lda #$00F1
        jsl rlBattleSceneStepColorsToward
        bcc _End

          lda #0
          sta @l aMapAction.wMapBattleStrikeSignal

        _End
        plx
        ply
        rtl

        .databank 0

    .endsection Unsorted9EFA17Section


    .section Unsorted9EFC47Section

      .al
      .xl

      rlGrayOutBelhallaBlastUnits ; 9E/FC47

        .al
        .autsiz
        .databank ?

        ; Sets DeploymentStateGrayed on units listed in aBelhallaBlastUnitCoordLists[$7F57F0]

        phb
        phk
        plb
        phx
        phy
        lda $7F57F0
        asl a
        clc
        adc $7F57F0
        tax
        lda aBelhallaBlastUnitCoordLists,x
        sta lR18,b
        lda aBelhallaBlastUnitCoordLists+1,x
        sta lR18+1,b
        ldy #0

        _Loop
        lda [lR18],y
        cmp #$FFFF
        beq _End

          and #$00FF
          sta wR0
          inc y
          lda [$24],y
          and #$00FF
          sta wR1
          phy
          jsl rlGetUnitByCoordinates
          bcs _Next

            jsl rlGetSelectedUnitDeploymentOffset
            tax
            lda aDeploymentTable._State,x
            ora #DeploymentStateGrayed
            sta aDeploymentTable._State,x

          _Next
          ply
          inc y
          bra _Loop

        _End
        ply
        plx
        plb
        rtl

        .databank 0

      rlUngrayBelhallaBlastUnits ; 9E/FC9B

        .al
        .autsiz
        .databank ?

        ; Clears DeploymentStateGrayed on units listed in aBelhallaBlastUnitCoordLists[$7F57F0]

        phb
        phk
        plb
        phx
        phy
        lda #0
        sta aProcSystem.aHeaderBitfield,b,x
        sta aMapAction.wMapBattlePaletteRestoreFlag

        lda $7F57F0
        asl a
        clc
        adc $7F57F0
        tax
        lda aBelhallaBlastUnitCoordLists,x
        sta lR18,b
        lda aBelhallaBlastUnitCoordLists+1,x
        sta lR18+1,b
        ldy #0
        
        _Loop
        lda [lR18],y
        cmp #$FFFF
        beq _End

          and #$00FF
          sta wR0
          inc y
          lda [lR18],y
          and #$00FF
          sta wR1
          phy
          jsl rlGetUnitByCoordinates
          bcs _Next

            jsl rlGetSelectedUnitDeploymentOffset
            tax
            lda aDeploymentTable._State,x
            and #~DeploymentStateGrayed
            sta aDeploymentTable._State,x

          _Next
          ply
          inc y
          bra _Loop

        _End
        lda $7F57F0
        inc a
        sta $7F57F0

        ply
        plx
        plb
        rtl

        .databank 0

        ; 9E/FD02

        ; fill 0

    .endsection Unsorted9EFC47Section

