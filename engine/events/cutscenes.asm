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
        sta $7F4C07

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

        PROC_CALL rlUnknown9EF79D
        PROC_JUMP_IF_BITS_SET _MagesAttacked, $0002

        -
        PROC_YIELD 1
        PROC_CALL rlUnknown9EF822
        PROC_JUMP_IF_BITS_UNSET -, $0004

        PROC_YIELD 1
        PROC_JUMP aProcBelhallaMagesAttackCode

        ; Check targets to hit
        _MagesAttacked
        PROC_CALL rlUnknown9EF703
        PROC_SET_ONCYCLE $C9FD
        PROC_YIELD 16
        PROC_CALL rlUnknown9F85A3
        PROC_YIELD 2
        PROC_CALL rlUnknown9F85CC
        PROC_YIELD 2
        PROC_CALL rlUnknown9F85F5
        PROC_YIELD 2
        PROC_CALL rlUnknown9F861F
        PROC_YIELD 2
        PROC_CALL rlUnknown9F86BF

        PROC_JUMP_IF_BITS_UNSET _F6FA, $0002

        -
        PROC_YIELD 1
        PROC_CALL rlUnknown9F86B0
        PROC_JUMP_IF_BITS_UNSET -, $0001

        PROC_CALL rlUnknown9F8677
        PROC_YIELD 2
        PROC_CALL rlUnknown9EE228

        -
        PROC_CALL rlUnknown9EE23D
        PROC_YIELD 1
        PROC_JUMP_IF_BITS_UNSET -, $0004

        PROC_SET_UNK_TIMER 5

        ; Meteors fall
        -
        PROC_CALL rlUnknown9EF724
        PROC_CALL rlStartBelhallaMagesBlast
        PROC_CALL rlUnknown9F8020
        PROC_YIELD 128
        PROC_CALL rlUnknown9F8349
        PROC_CALL rlUnknown9F8473
        PROC_YIELD 1
        PROC_JUMP_WHILE_UNK_TIMER -

        PROC_CALL rlUnknown9EF791

        -
        PROC_CALL rlUnknown9EE279
        PROC_YIELD 1
        PROC_JUMP_IF_BITS_UNSET -, $0004

        _F6FA
        PROC_YIELD 16
        PROC_CALL rlUnknown9EF76F
        PROC_END

      rlUnknown9EF703 ; 9E/F703

        .al
        .autsiz
        .databank ?

        lda #4
        sta $7F508B
        sta $7F5089
        lda #$8401
        sta $7F508F
        lda #$00FF
        sta $7F5099
        lda #0
        sta $7F509F
        rtl

        .databank 0

      rlUnknown9EF724 ; 9E/F724

        .al
        .autsiz
        .databank ?

        phx
        lda aProcSystem.aBody6,x
        asl a
        tax
        lda aUnknown9EF765+1,x
        and #$00FF
        tay
        lda aUnknown9EF765,x
        and #$00FF
        tax
        lda aActionStructUnit1.UnitRAMPointer
        jsl rlUnknown9E8D25

        lda wR0
        and #$00FF
        sta wR0
        lda wR1
        and #$00FF
        sta wR1

        lda wR1
        xba
        ora wR0
        sta $7F509B

        plx
        lda aProcSystem.aBody6,x
        inc a
        sta aProcSystem.aBody6,x
        rtl

        .databank 0

      aUnknown9EF765 ; 9E/F765

        .word $3106
        .word $3007
        .word $2F05
        .word $2E07
        .word $2D06

      rlUnknown9EF76F ; 9E/F76F

        .al
        .autsiz
        .databank ?

        lda $7F4C07
        ora #$0002
        sta $7F4C07

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


    .section Unknown9EF791Section

      .al
      .xl

      rlUnknown9EF791 ; 9E/F791

        .al
        .autsiz
        .databank ?

        phx
        lda aProcSystem.aHeaderBitfield,b,x
        and #~$0004
        sta aProcSystem.aHeaderBitfield,b,x
        plx
        rtl

        .databank 0

    .endsection Unknown9EF791Section


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

      rlUnknown9EF822 ; 9E/F822

        .al
        .autsiz
        .databank ?

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


    .section ProcUnknown9EF837InitSection

      .al
      .xl

      rlProcBelhallaAttackingMageInit ; 9E/F83F

        .al
        .autsiz
        .databank $7F

        phy
        phx
        phb

        jsl rlUnknown9EFA17

        pea #$7F00
        plb
        plb

        lda #0
        sta $4580,b
        sta $4582,b
        sta $4584,b
        sta @l aMapAction.wUnknown7F455A
        sta @l aMapAction.wMapBattleAttackVariant
        sta @l $7F5091
        sta @l $7F5093
        sta @l $7F4C07

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
        sta aMapAction.wBattleClassID

        lda aScriptedUnitMapAction + structScriptedMapAttack.wXTilePosition
        sta $4552,b
        lda aScriptedUnitMapAction + structScriptedMapAttack.wYTilePosition
        sta $4554,b
        lda #$FFFF
        jsl rlGetClassMapBattleWeaponType
        sta aMapAction.wWeaponType

        lda #$FFFF
        sta aActionStructUnit1.WeaponID

        lda #0
        sta aMapAction.wUnknown7F4450
        sta aMapAction.wUnknown7F4556
        sta aMapAction.wUnknown7F4558
        sta aMapAction.wUnknown7F454C

        lda aProcSystem.wInput0
        sta aMapAction.wUnknown7F455E
        sta aMapAction.wUnknown7F4560

        lda #1
        sta @l aMapAction.wUnknown7F4562

        lda #4
        sta $508B,b
        sta $5089,b
        plb

        ; Set MapScrollPixels
        lda @l aMapAction.wYTilePosition
        tay
        lda @l aMapAction.wXTilePosition
        tax
        jsl rlUnknown9E8D25

        lda #$8000
        sta @l $7F508F
        lda wR0
        and #$00FF
        sta wR0
        lda wR1
        and #$00FF
        sta wR1

        lda wR1
        xba
        ora wR0
        sta @l $7F5099
        sta @l $7F509B

        lda #(`rlPushToOAMBufferDualTileBase)<<8
        sta $0015E4+1
        lda #<>rlPushToOAMBufferDualTileBase
        sta $0015E4

        lda aActiveSpriteSystem.wFlag
        sta @l $7F4BD9

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

        lda @l aMapAction.wUnknown7F455E
        asl a
        clc
        adc @l aMapAction.wUnknown7F455E
        asl a
        sta wR0
        lda @l aMapAction.wBattleClassID
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
        lda #(`gcUnknownACCC17)<<8
        sta @l lR18+1
        lda #<>gcUnknownACCC17
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

    .endsection ProcUnknown9EF837InitSection


    .section Unsorted9EF79DSection

      .al
      .xl

      rlUnknown9EF79D ; 9E/F79D

        .al
        .autsiz
        .databank ?

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
        sta aActionStructUnit1.Unknown
        lda #$0000
        sta aMapAction.wUnknown7F4562
        lda #$FFFF
        sta aActionStructUnit2
        sta aActionStructUnit2.ClassID
        lda #$0000
        sta aActionStructUnit2.Gender
        sta aActionStructUnit2.XPosition
        sta aActionStructUnit2.YPosition
        sta aActionStructUnit2.WeaponID
        sta aActionStructUnit2.Unknown
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
        sta aActionStructUnit1.Unknown
        jsl rlGetSelectedUnitDeploymentOffset
        sta aActionStructUnit1
        tax
        lda aDeploymentTable,x
        and #$0003
        sta aMapAction.wUnknown7F4562
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
        sta aActionStructUnit2.Unknown
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

      rlUnknown9EF1B3 ; 9E/F1B3

        ; Only plx / rtl; nothing reaches it.

        .al
        .xl
        .autsiz
        .databank ?

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

        lda wEventUnitSlot1ID,b
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

        .structProcInfo "ON", rlProcWarpAwayInit, rlUnknown9ED2B5, aProcReturnHomeCode

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
        sta $4580,b
        sta $4582,b
        sta $4584,b
        sta aMapAction.wUnknown7F455A
        sta aMapAction.wMapBattleAttackVariant
        sta $7F5091
        sta $7F5093
        sta $7F4C07
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
        sta $454E,b
        lda wBattleDistance
        sta $4552,b
        lda wBattleQuotePointer
        sta $4554,b
        lda #$FFFF
        jsl rlGetClassMapBattleWeaponType
        sta $454A,b
        lda #$FFFF
        sta aActionStructUnit1.WeaponID
        lda #$0000
        sta $4550,b
        sta $4556,b
        sta $4558,b
        sta $454C,b
        lda #$0006
        sta $455E,b
        sta $4560,b
        lda #$0020
        sta $5089,b
        plb
        .databank ?
        lda aMapAction.wYTilePosition
        tay
        lda aMapAction.wXTilePosition
        tax
        jsl rlUnknown9E8D25
        lda #$8000
        sta $7F508F
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
        sta $7F5099
        sta $7F509B
        lda #$8100
        sta @l $0015E5
        lda #$841B
        sta @l $0015E4
        lda @l aActiveSpriteSystem
        sta $7F4BD9
        lda @l aActiveSpriteSystem
        ora #$4000
        sta @l aActiveSpriteSystem
        plx
        lda @l $000302
        sta @l $0010B7,x
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
        sta $7F4C07
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
        sta $7F4C07
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

        .structProcInfo "ON", rlProcWarpInInit, rlUnknown9ED2B5, aProcWarpInCode

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
        sta $4580,b
        sta $4582,b
        sta $4584,b
        sta aMapAction.wUnknown7F455A
        sta aMapAction.wMapBattleAttackVariant
        sta $7F5091
        sta $7F5093
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
        sta $454E,b
        lda wBattleDistance
        sta $4552,b
        lda wBattleQuotePointer
        sta $4554,b
        lda #$FFFF
        jsl rlGetClassMapBattleWeaponType
        sta $454A,b
        lda #$FFFF
        sta aActionStructUnit1.WeaponID
        lda #$0000
        sta $4550,b
        sta $4556,b
        sta $4558,b
        sta $454C,b
        lda #$0006
        sta $455E,b
        sta $4560,b
        lda #$0029
        sta $5089,b
        plb
        .databank ?
        lda aMapAction.wYTilePosition
        tay
        lda aMapAction.wXTilePosition
        tax
        jsl rlUnknown9E8D25
        lda #$8000
        sta $7F508F
        lda wR0
        and #$00FF
        sta wR0
        lda wR1
        and #$00FF
        sta wR1
        lda wR1
        xba
        ora wR0
        sta $7F509B
        sta $7F5099
        lda #$8100
        sta @l $0015E5
        lda #$841B
        sta @l $0015E4
        lda @l aActiveSpriteSystem
        sta $7F4BD9
        lda @l aActiveSpriteSystem
        ora #$4000
        sta @l aActiveSpriteSystem
        plx
        lda @l $000302
        sta @l $0010B7,x
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
        PROC_CALL rlUnknown9EF55B
        PROC_JUMP_IF_BITS_UNSET _F4A0, $0001
        PROC_SET_ONCYCLE rlUnknown9ED337
        PROC_YIELD 56
        PROC_CALL rlUnknown9E99F7
        PROC_YIELD 4
        PROC_CALL rlUnknown9E9D3B
        PROC_YIELD 4
        PROC_CALL rlUnknown9E9D76
        PROC_YIELD 4
        PROC_CALL rlCreateMapBattleAttackerSprites
        PROC_CALL rlUnknown9EF578
        PROC_YIELD 2
        PROC_CALL rlUnknown9F86BF
        PROC_JUMP_IF_BITS_UNSET _F4F3, $0002
        _F4DF
        PROC_YIELD 1
        PROC_CALL rlUnknown9F86B0
        PROC_JUMP_IF_BITS_UNSET _F4DF, $0001
        PROC_CALL rlUnknown9F8677
        PROC_YIELD 2
        _F4F3
        PROC_CALL rlUnknown9F8020
        PROC_YIELD 16
        _F4FA
        PROC_YIELD 1
        PROC_CALL rlUnknown9ED372
        PROC_YIELD 1
        PROC_SET_ONCYCLE rlProcUnknown9EAF98Cycle2
        _F507
        PROC_YIELD 1
        PROC_JUMP_IF_BITS_UNSET _F507, $0002
        PROC_YIELD 1
        PROC_JUMP_IF_BITS_UNSET _F4FA, $0001
        PROC_YIELD 4
        PROC_CALL rlUnknown9F8349
        PROC_CALL rlUnknown9F8473
        PROC_CALL rlUnknown9EF5D0
        PROC_JUMP_IF_BITS_UNSET _F53F, $0002
        _F52E
        PROC_YIELD 1
        PROC_CALL rlUnknown9EF5F1
        PROC_JUMP_IF_BITS_UNSET _F52E, $0004
        PROC_JUMP _F541

        _F53F
        PROC_YIELD 30
        _F541
        PROC_CALL rlUnknown9ED3C1
        PROC_CALL rlLoadCursorSpriteGraphics
        PROC_YIELD 2
        PROC_CALL rlLoadMapSpriteOAMPalettes
        PROC_YIELD 1
        PROC_CALL rlUnknown9ED71E
        PROC_END


        ; 9E/F55B

    .endsection Unsorted9EF49ESection


    .section Unsorted9EF55BSection

      .al
      .xl

      rlUnknown9EF55B ; 9E/F55B

        .al
        .xl
        .autsiz
        .databank ?

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

      rlUnknown9EF578 ; 9E/F578

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda aMapAction.wMapBattleAttackerSpriteSlot
        sta aMapAction.wMapBattleDefenderSpriteSlot
        lda aMapAction.wMapBattleAttackerAuxSpriteSlot
        sta aMapAction.wMapBattleDefenderAuxSpriteSlot
        lda aMapAction.wMapBattleAttackerSpriteSlot
        tax
        lda aActiveSpriteSystem.aUnknown001200,b,x
        ora #$8000
        sta aActiveSpriteSystem.aUnknown001200,b,x
        lda aMapAction.wMapBattleAttackerAuxSpriteSlot
        cmp #$FFFF
        beq _F5AA
        tax
        lda aActiveSpriteSystem.aUnknown001200,b,x
        ora #$8000
        sta aActiveSpriteSystem.aUnknown001200,b,x

        _F5AA
        plx
        rtl

        .databank 0

      rlUnknown9EF5AC ; 9E/F5AC

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda aMapAction.wMapBattleAttackerSpriteSlot
        tax
        lda aActiveSpriteSystem.aUnknown001200,b,x
        and #$7FFF
        sta aActiveSpriteSystem.aUnknown001200,b,x
        lda aMapAction.wMapBattleAttackerAuxSpriteSlot
        cmp #$FFFF
        beq _F5CE
        tax
        lda aActiveSpriteSystem.aUnknown001200,b,x
        and #$7FFF
        sta aActiveSpriteSystem.aUnknown001200,b,x

        _F5CE
        plx
        rtl

        .databank 0

        ; 9E/F5D0

    .endsection Unsorted9EF55BSection


    .section Unsorted9EF5D0Section

      .al
      .xl

      rlUnknown9EF5D0 ; 9E/F5D0

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFD
        and #$FFFB
        sta aProcSystem.aHeaderBitfield,b,x
        lda $7F4C07
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

      rlUnknown9EF5F1 ; 9E/F5F1

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F4C07
        ora #$0010
        sta $7F4C07
        lda $7F4C07
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
        PROC_SET_ONCYCLE rlUnknown9ED337
        PROC_YIELD 32
        PROC_CALL rlUnknown9E99F7
        PROC_YIELD 2
        PROC_CALL rlCreateMapBattleAttackerSprites
        PROC_CALL rlUnknown9EB3DE
        PROC_YIELD 1
        PROC_CALL rlUnknown9EFA4F
        PROC_YIELD 32
        PROC_CALL rlUnknown9EFA9A
        PROC_CALL rlLoadCursorSpriteGraphics
        PROC_YIELD 4
        PROC_CALL rlLoadMapSpriteOAMPalettes
        PROC_YIELD 1
        PROC_END

    .endsection Unsorted9EF9E0Section


    .section Unsorted9EFA17Section

      .al
      .xl

      rlUnknown9EFA17 ; 9E/FA17

        .al
        .autsiz
        .databank ?

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

      rlUnknown9EFA4F ; 9E/FA4F

        .al
        .autsiz
        .databank ?

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
        sta @l aMapAction.wMapBattleActiveSpriteSyncFlag
        sta @l aMapAction.wMapBattleActiveSpriteAckFlag
        sta aProcSystem.aHeaderBitfield,x

        lda #1
        sta @l aMapAction.wMapBattlePhaseFlag
        lda $4599,b
        sta $458A,b
        sta $4587,b

        lda $4598,b
        sta lR18
        lda $4598+1,b
        sta lR18+1
        lda $455E,b
        sta wR0
        lda #0
        jsr rsGetMapBattleRoundScripts
        stx $4589,b
        sty $4586,b
        plx
        ply
        plp
        plb
        rtl

        .databank 0

      rlUnknown9EFA9A ; 9E/FA9A

        .al
        .autsiz
        .databank ?

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
        lda #$8000
        sta $15E4+1,b
        lda #$87C7
        sta $15E4,b

        lda $7F4BD9
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

      aUnknown9EFAF8 ; 9E/FAF8

        .long aUnknown9EFB07
        .long aUnknown9EFB1B
        .long aUnknown9EFB29
        .long aUnknown9EFB37
        .long aUnknown9EFB45

      aUnknown9EFB07 ; 9E/FB07

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

      aUnknown9EFB1B ; 9E/FB1B

        .byte $06, $2F
        .byte $07, $2F
        .byte $06, $30
        .byte $07, $30
        .byte $06, $31
        .byte $07, $31
        .word $FFFF

      aUnknown9EFB29 ; 9E/FB29

        .byte $05, $2E
        .byte $06, $2E
        .byte $05, $2F
        .byte $06, $2F
        .byte $05, $30
        .byte $06, $30
        .word $FFFF

      aUnknown9EFB37 ; 9E/FB37

        .byte $06, $2D
        .byte $07, $2D
        .byte $06, $2E
        .byte $07, $2E
        .byte $06, $2F
        .byte $07, $2F
        .word $FFFF

      aUnknown9EFB45 ; 9E/FB45

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
        PROC_CALL rlUnknown9EFB80
        PROC_JUMP_IF_BITS_UNSET -, $0004

        -
        PROC_YIELD 1
        PROC_CALL rlUnknown9EFBB6
        PROC_CALL rlUnknown9EFB9B
        PROC_JUMP_IF_BITS_UNSET -, $0004

        PROC_CALL rlUnknown9EFC9B
        PROC_YIELD 16
        PROC_END

      rlUnknown9EFB80 ; 9E/FB80

        .al
        .autsiz
        .databank ?

        phx
        lda aProcSystem.aHeaderBitfield,b,x
        and #~$0004
        sta aProcSystem.aHeaderBitfield,b,x

        lda aMapAction.wMapBattleActiveSpriteSyncFlag
        beq +

          lda aProcSystem.aHeaderBitfield,b,x
          ora #$0004
          sta aProcSystem.aHeaderBitfield,b,x

        +
        plx
        rtl

        .databank 0

      rlUnknown9EFB9B ; 9E/FB9B

        .al
        .autsiz
        .databank ?

        phx
        lda aProcSystem.aHeaderBitfield,b,x
        and #~$0004
        sta aProcSystem.aHeaderBitfield,b,x

        lda aMapAction.wMapBattleActiveSpriteSyncFlag
        bne +

          lda aProcSystem.aHeaderBitfield,b,x
          ora #$0004
          sta aProcSystem.aHeaderBitfield,b,x

        +
        plx
        rtl

        .databank 0

      rlUnknown9EFBB6 ; 9E/FBB6

        .al
        .autsiz
        .databank ?

        phy
        phx
        lda aMapAction.wMapBattleActiveSpriteSyncFlag
        bne +

          jml _End

        +
        lda aMapAction.wMapBattlePaletteRestoreFlag
        bne _FC23

          jsl rlUnknown9EFC47

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
            sta $45AC,b,y

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
          lda @l $7F509B
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
        jsl rlUnknown959F43
        bcc _End

          lda #0
          sta @l aMapAction.wMapBattleActiveSpriteSyncFlag

        _End
        plx
        ply
        rtl

        .databank 0

    .endsection Unsorted9EFA17Section


    .section Unsorted9EFC47Section

      .al
      .xl

      rlUnknown9EFC47 ; 9E/FC47

        .al
        .autsiz
        .databank ?

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
        lda aUnknown9EFAF8,x
        sta lR18,b
        lda aUnknown9EFAF8+1,x
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

      rlUnknown9EFC9B ; 9E/FC9B

        .al
        .autsiz
        .databank ?

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
        lda aUnknown9EFAF8,x
        sta lR18,b
        lda aUnknown9EFAF8+1,x
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

