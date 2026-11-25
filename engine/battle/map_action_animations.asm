; Map actions shown with the map battle's sprites (bank $9E): raiding a village
; (procVillageRaid), returning to the home castle (procReturnHome), the holy weapon
; shine when a holy weapon is obtained (procHolyWeaponShine), giving gold
; (procGiveGold), and the experience and rewards of an action without a battle
; (procMapActionRewards).


    .section Unsorted9E9A34Section

      .al
      .xl

      rlStartVillageRaidAnimation ; 9E/9A34

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`procVillageRaid)<<8
        sta lR44+1
        lda #<>procVillageRaid
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 9E/9A43

    .endsection Unsorted9E9A34Section


    .section ProcScript9E9A43Section

      .al
      .xl

      procVillageRaid ; 9E/9A43

        .structProcInfo "ON", rlProcVillageRaidInit, rlProcVillageRaidQueueGraphics, aProcVillageRaidCode

    .endsection ProcScript9E9A43Section


    .section Unsorted9E9A4BSection

      .al
      .xl

      rlProcVillageRaidInit ; 9E/9A4B

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
        sta @l $000FD7,x
        sta aMapAction.wUnknown7F455A
        sta aMapAction.wSideTallSprite
        sta wMapBattleMode
        sta <>wMapBattleAttackerBallista,b
        sta <>wMapBattleDefenderBallista,b
        sta wMapAnimationSignals
        lda #$0001
        sta wMapBattleRoundEntry
        lda $7E4EAF
        sta <>aMapAction.wAttackerSpriteRow,b
        lda wBattleDistance
        sta <>aMapAction.wAttackerXTile,b
        lda wBattleQuotePointer
        sta <>aMapAction.wAttackerYTile,b
        lda wDeathQuotePointer+1
        jsl rlGetItemDataROMPointer
        jsl rlGetItemWeaponType
        sta <>aMapAction.wAttackerWeaponType,b
        lda #$0000
        sta <>aMapAction.wDefenderSpriteRow,b
        sta <>aMapAction.wDefenderXTile,b
        sta <>aMapAction.wDefenderYTile,b
        sta <>aMapAction.wDefenderWeaponType,b
        lda #$0006
        sta <>aMapAction.wAttackerFacing,b
        sta <>aMapAction.wDefenderFacing,b
        lda #$003E
        sec
        sbc #$003E
        sta <>wMapMagicEffect,b
        lda wBattleSong
        asl a
        asl a
        tax
        plb
        .databank ?
        lda aMapAction.wAttackerYTile
        clc
        adc aVillageRaidFireTileOffsets+2,x
        tay
        lda aMapAction.wAttackerXTile
        clc
        adc aVillageRaidFireTileOffsets,x
        tax
        lda aActionStructUnit1.UnitRAMPointer
        jsl rlGetMapBattleUnitScreenPosition
        lda wR1
        jsl rlSetMapMagicFlagsFromBit7
        lda wMapMagicFlags
        ora #$8000
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
        sta wMapMagicCasterPixel
        sta wMapMagicTargetPixel
        lda $7E4EA9
        sta aActionStructUnit1
        lda $7E4EAF
        sta aActionStructUnit1.ClassID
        lda wDeathQuotePointer+1
        sta aActionStructUnit1.WeaponID
        lda #(`rlPushToOAMBufferDualTileBase)<<8
        sta @l lActiveSpriteRenderer+1
        lda #<>rlPushToOAMBufferDualTileBase
        sta @l lActiveSpriteRenderer
        plx
        lda @l wGameStateRoutine1
        sta @l aProcSystem.aBody7,x
        stz wGameStateRoutine1,b
        lda #$0000
        sta aProcSystem.aHeaderBitfield,b,x
        ply
        rtl

        .databank 0

        ; 9E/9B50

    .endsection Unsorted9E9A4BSection


    .section Table9E9B50Section

      .al
      .xl

      aVillageRaidFireTileOffsets ; 9E/9B50

        ; Read by rlProcVillageRaidInit.

        .word $FFFF, $FFFF, $0000, $FFFF, $0001, $FFFF, $FFFF, $0000
        .word $0000, $0000, $0001, $0000

        ; 9E/9B68

    .endsection Table9E9B50Section


    .section Unsorted9E9B68Section

      .al
      .xl

      rlProcVillageRaidWaitRoundStart ; 9E/9B68

        .al
        .xl
        .autsiz
        .databank ?

        lda aMapAction.wMapBattleRoundRunning
        beq _9B74
        lda #<>rlProcVillageRaidRunRound
        sta aProcSystem.aHeaderOnCycle,b,x

        _9B74
        lda aMapAction.wMapBattleStrikeSignal
        beq _9B81
        lda #$0000
        sta aMapAction.wMapBattleStrikeSignal

        _9B81
        rtl

        .databank 0

        ; 9E/9B82

    .endsection Unsorted9E9B68Section


    .section Unsorted9E9B82Section

      .al
      .xl

      rlProcVillageRaidRunRound ; 9E/9B82

        .al
        .xl
        .autsiz
        .databank ?

        lda aMapAction.wMapBattleRoundRunning
        bne _9B97
        lda #<>rlProcVillageRaidFinishRound
        sta aProcSystem.aHeaderOnCycle,b,x
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0002
        sta aProcSystem.aHeaderBitfield,b,x

        _9B97
        lda aMapAction.wMapBattleStrikeSignal
        beq _9BAC
        lda #$0000
        sta aMapAction.wMapBattleStrikeSignal
        jsl rlVillageRaidCreateFireSprite
        jsl rlVillageRaidStartFireEffect

        _9BAC
        rtl

        .databank 0

        ; 9E/9BAD

      rlProcVillageRaidFinishRound ; 9E/9BAD

        .al
        .xl
        .autsiz
        .databank ?

        phx
        inc aProcSystem.aBody0,b,x
        lda aProcSystem.aBody0,b,x
        cmp #$0001
        beq _9BC8
        lda #$0000
        sta aMapAction.wMapBattleRoundRunning
        lda #<>rlProcVillageRaidIdle
        sta aProcSystem.aHeaderOnCycle,b,x
        bra _9BDE


        _9BC8
        jsl rlMapBattleEndRoundScripts
        lda #<>rlProcVillageRaidIdle
        sta aProcSystem.aHeaderOnCycle,b,x
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0002
        ora #$0001
        sta aProcSystem.aHeaderBitfield,b,x

        _9BDE
        plx
        rtl

        .databank 0

        ; 9E/9BE0

      rlProcVillageRaidIdle ; 9E/9BE0

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 9E/9BE1

    .endsection Unsorted9E9B82Section


    .section ProcScript9E9BE1Section

      .al
      .xl

      aProcVillageRaidCode ; 9E/9BE1

        PROC_YIELD 1
        PROC_CALL rlCheckMapMagicDecompressionDone
        PROC_JUMP_IF_BITS_UNSET aProcVillageRaidCode, $0001
        PROC_YIELD 1
        PROC_SET_ONCYCLE rlProcVillageRaidQueueSpriteData
        PROC_YIELD 16
        PROC_CALL rlUploadMapBattleShadowTiles
        PROC_YIELD 4
        PROC_CALL rlMapActionQueueEffectGraphics
        PROC_YIELD 4
        PROC_CALL rlMapActionUploadEffectGraphics
        PROC_YIELD 4
        PROC_CALL rlCreateMapBattleAttackerSprites
        PROC_YIELD 2
        PROC_YIELD 1
        PROC_SET_ONCYCLE rlQueueMapMagicBackgroundAll
        PROC_YIELD 8
        PROC_CALL rlUploadMapMagicBackgroundTiles
        PROC_YIELD 4
        PROC_CALL rlUploadMapMagicBackgroundTilemap
        PROC_YIELD 2
        PROC_CALL rlCopyMapMagicBackgroundColors
        PROC_YIELD 2
        _9C2F
        PROC_YIELD 8
        PROC_CALL rlVillageRaidStartRound
        PROC_YIELD 1
        PROC_SET_ONCYCLE rlProcVillageRaidWaitRoundStart
        _9C3C
        PROC_YIELD 1
        PROC_JUMP_IF_BITS_UNSET _9C3C, $0002
        PROC_YIELD 1
        PROC_JUMP_IF_BITS_UNSET _9C2F, $0001
        PROC_YIELD 1
        PROC_JUMP_IF_BITS_UNSET _9C54, $0004
        _9C54
        PROC_CALL rlRedrawMapAfterVillageRaid
        PROC_YIELD 2
        PROC_CALL rlEndVillageRaidSprites
        PROC_CALL rlLoadCursorSpriteGraphics
        PROC_YIELD 4
        PROC_CALL rlLoadMapSpriteOAMPalettes
        PROC_YIELD 1
        PROC_END


        ; 9E/9C70

    .endsection ProcScript9E9BE1Section


    .section Unsorted9E9C70Section

      .al
      .xl

      rlVillageRaidStartFireEffect ; 9E/9C70

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFB
        sta aProcSystem.aHeaderBitfield,b,x
        lda wBattleSong
        cmp #$0006
        bcs _9C93
        jsl rlStartMapMagicVillageFire
        sta $7F57EE
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0004
        sta aProcSystem.aHeaderBitfield,b,x

        _9C93
        rtl

        .databank 0

        ; 9E/9C94

    .endsection Unsorted9E9C70Section


    .section Unreferenced9E9C94Section

      .al
      .xl

      rlVillageRaidWaitFireEffect ; 9E/9C94

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFB
        sta aProcSystem.aHeaderBitfield,b,x
        lda $7F57EE
        jsl rlProcEngineCheckProcEnded
        bcs _9CB7
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0004
        sta aProcSystem.aHeaderBitfield,b,x
        lda #<>rlProcVillageRaidIdle
        sta aProcSystem.aHeaderOnCycle,b,x

        _9CB7
        plx
        rtl

        .databank 0

        ; 9E/9CB9

    .endsection Unreferenced9E9C94Section
    .section Unsorted9E9CB9Section

      .al
      .xl

      rlProcVillageRaidQueueGraphics ; 9E/9CB9

        .al
        .xl
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
        lda #$0031
        sta wR11
        jsl rlUnsignedMultiply16By16
        lda wR12
        clc
        adc wR0
        adc #$0003
        tax
        lda aBattleMapSpriteData+1,x
        sta lR18+1
        lda aBattleMapSpriteData,x
        sta lR18
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        clc
        adc #$0000
        sta lR19
        plp
        plb
        .databank $7F
        jsl rlAppendDecompList
        phb
        php
        sep #$20
        lda #$7F
        pha
        rep #$20
        plb
        .databank $7F
        lda #(`g4bppcMapBattleWeaponIcons)<<8
        sta lR18+1
        lda #<>g4bppcMapBattleWeaponIcons
        sta lR18
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        clc
        adc #$4000
        sta lR19
        plp
        plb
        .databank $7F
        jsl rlAppendDecompList
        ply
        plx
        lda #<>rlProcVillageRaidIdle
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 9E/9D3B

    .endsection Unsorted9E9CB9Section


    .section Unsorted9E9D3BSection

      .al
      .xl

      rlMapActionQueueEffectGraphics ; 9E/9D3B

        .al
        .autsiz
        .databank ?

        ; Decompresses map action effect OAM graphics to aDecompressionBuffer+$2000/$3000.

        phx
        lda #(`g4bppcMapActionEffectGfx1)<<8
        sta lR18+1
        lda #<>g4bppcMapActionEffectGfx1
        sta lR18
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        clc
        adc #$2000
        sta lR19
        jsl rlAppendDecompList

        lda #(`g4bppcMapActionEffectGfx2)<<8
        sta lR18+1
        lda #<>g4bppcMapActionEffectGfx2
        sta lR18
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        clc
        adc #$3000
        sta lR19
        jsl rlAppendDecompList
        plx
        rtl

        .databank 0

        ; 9E/9D76

    .endsection Unsorted9E9D3BSection


    .section Unsorted9E9D76Section

      .al
      .xl

      rlMapActionUploadEffectGraphics ; 9E/9D76

        .al
        .xl
        .autsiz
        .databank ?

        ; Uploads the decompressed effect OAM tiles and aMapActionEffectOAMPalette.

        phy
        phx
        lda #(`aDecompressionBuffer)<<8
        sta lR18+1
        lda #<>aDecompressionBuffer
        clc
        adc #$2000
        sta lR18
        lda #$0400
        sta wR0
        lda bBufferOBSEL
        and #$0003
        asl a
        asl a
        asl a
        asl a
        asl a
        xba
        clc
        adc #$0600
        sta wR1
        jsl rlDMAByPointer
        ldx #$0000
        ldy #$01C0

        _9DA6
        lda aMapActionEffectOAMPalette,x
        sta aBGPaletteBuffer,b,y
        inc y
        inc y
        inc x
        inc x
        cpx #$0020
        bne _9DA6
        plx
        ply
        rtl

        .databank 0

        ; 9E/9DB9

    .endsection Unsorted9E9D76Section


    .section Table9E9DB9Section

      .al
      .xl

      aMapActionEffectOAMPalette ; 9E/9DB9

        ; Read by rlMapActionUploadEffectGraphics.

        .word $3800, $7FFF, $035F, $01BF, $0037, $0C8A, $0425, $7FBA
        .word $7E6E, $7C84, $30C4, $1421, $0000, $0000, $0000, $0000

        ; 9E/9DD9

    .endsection Table9E9DB9Section


    .section Unsorted9E9DD9Section

      .al
      .xl

      rlProcVillageRaidQueueSpriteData ; 9E/9DD9

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda #$0000
        sta aMapAction.wMapBattleStrikeSignal
        sta aMapAction.wMapBattleStrikeDone
        sta aMapAction.wMapBattleRoundRunning
        sta aProcSystem.aHeaderBitfield,b,x
        lda #$FFFF
        sta aMapAction.wMapBattleAttackerSpriteSlot
        sta aMapAction.wMapBattleAttackerAuxSpriteSlot
        jsl rlInitMapBattleSpriteInfos
        jsl rlSelectMapBattleAttackerSprite
        lda #$0000
        jsl rlMapBattleQueueSpriteData
        plx
        ply
        lda #<>rlProcVillageRaidIdle
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 9E/9E10

      rlVillageRaidStartRound ; 9E/9E10

        .al
        .xl
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
        lda #$0000
        sta <>aMapAction.wMapBattleStrikeSignal,b
        sta <>aMapAction.wMapBattleStrikeDone,b
        sta <>aMapAction.wMapBattleRoundRunning,b
        sta @l aProcSystem.aHeaderBitfield,x
        lda #$0001
        sta <>aMapAction.wMapBattleRoundRunning,b
        lda <>aMapAction.lAttackerSpriteData+1,b
        sta <>aMapAction.lAttackerRoundScript+1,b
        sta <>aMapAction.lAttackerAuxRoundScript+1,b
        lda <>aMapAction.lAttackerSpriteData,b
        sta @l lR18
        lda <>aMapAction.lAttackerSpriteData+1,b
        sta @l lR18+1
        lda <>aMapAction.wAttackerFacing,b
        sta @l wR0
        lda #$0000
        jsr rsGetMapBattleRoundScripts
        stx <>aMapAction.lAttackerRoundScript,b
        sty <>aMapAction.lAttackerAuxRoundScript,b
        plx
        ply
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 9E/9E61

    .endsection Unsorted9E9DD9Section


    .section Unsorted9E9E61Section

      .al
      .xl

      rlVillageRaidCreateFireSprite ; 9E/9E61

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda #$7E00
        sta aMapAction.lDefenderSpriteData+1
        sta lR18+1
        lda #$8B88
        clc
        adc #$3000
        sta aMapAction.lDefenderSpriteData
        sta lR18
        ldy #$0002
        lda [lR18],y
        clc
        adc lR18
        sta aMapBattleDefenderSpriteInfo.Code
        lda aMapAction.wAttackerYTile
        tay
        lda aMapAction.wAttackerXTile
        tax
        lda aActionStructUnit1.UnitRAMPointer
        jsl rlGetMapBattleUnitScreenPosition
        lda #(`aMapBattleDefenderSpriteInfo)<<8
        sta lR44+1
        lda #<>aMapBattleDefenderSpriteInfo
        sta lR44
        lda #<>aMapBattleDefenderSpriteInfo
        ldx wR0
        ldy wR1
        jsl rlActiveSpriteEngineCreateSpriteLowestSlotAbove0
        ldx aActiveSpriteSystem.wOffset,b
        txa
        sta aMapAction.wMapBattleDefenderSpriteSlot
        lda #$0001
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        sta aActiveSpriteSystem.aUnknown001320,b,x
        lda #$0006
        sta aActiveSpriteSystem.aPalette,b,x
        lda #$0040
        sta aActiveSpriteSystem.aTileBase,b,x
        sta aActiveSpriteSystem.aTileBaseHigh,b,x
        plx
        ply
        rtl

        .databank 0

        ; 9E/9ECF

    .endsection Unsorted9E9E61Section


    .section Unreferenced9E9ECFSection

      .al
      .xl

      rlVillageRaidSetupGoldPopup ; 9E/9ECF

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFB
        sta aProcSystem.aHeaderBitfield,b,x
        lda aActionStructUnit1.XPosition
        tax
        lda aActionStructUnit1.YPosition
        tay
        lda aActionStructUnit1.UnitRAMPointer
        jsl rlGetMapBattleUnitScreenPosition
        lda wR1
        lsr a
        lsr a
        lsr a
        and #$00FF
        xba
        sta wR1
        lda wR0
        lsr a
        lsr a
        lsr a
        and #$00FF
        ora wR1
        sta aProcSystem.wInput0,b
        lda #$1388
        sta aProcSystem.wInput1,b
        lda #$01F4
        sta aProcSystem.wInput2,b
        plx
        ply
        rtl

        .databank 0

        ; 9E/9F13

      rlVillageRaidCheckPopupDone ; 9E/9F13

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        cmp #$FFFF
        beq _9F23
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0004
        sta aProcSystem.aHeaderBitfield,b,x

        _9F23
        plx
        ply
        rtl

        .databank 0

        ; 9E/9F26

    .endsection Unreferenced9E9ECFSection
    .section Unsorted9EAC5ASection

      .al
      .xl

      rlStartMapActionRewards ; 9E/AC5A

        .al
        .autsiz
        .databank ?

        ; Experience, level up, gold and item for a map action without a battle (after a relocation, an ASMC).

        lda #(`procMapActionRewards)<<8
        sta lR44+1
        lda #<>procMapActionRewards
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 9E/AC69


      procMapActionRewards .structProcInfo "ON", rlProcMapActionRewardsInit, rlProcMapActionRewardsCycle, aProcMapActionRewardsCode ; 9E/AC69

      rlProcMapActionRewardsInit ; 9E/AC71

        .al
        .autsiz
        .databank ?

        lda wGameStateRoutine1,b
        sta aProcSystem.aBody7,x

        stz wGameStateRoutine1,b
        stz aProcSystem.aHeaderBitfield,b,x

        lda aActionStructUnit1.XPosition
        tax
        lda aActionStructUnit1.YPosition
        tay
        lda aActionStructUnit1.UnitRAMPointer
        jsl rlGetMapBattleUnitScreenPosition

        lda wR0
        and #$00FF
        sta aMapAction.wMapBattleAttackerXPixel
        lda wR1
        and #$00FF
        sta aMapAction.wMapBattleAttackerYPixel
        lda #0
        sta wMapBattleMusicLowered
        sta wMapAnimationSignals
        rtl

        .databank 0

      rlProcMapActionRewardsCycle ; 9E/ACAE

        .al
        .autsiz
        .databank ?

        rtl

        .databank 0

    .endsection Unsorted9EAC5ASection


    .section Unsorted9EACAFSection

      .al
      .xl

      aProcMapActionRewardsCode ; 9E/ACAF

        PROC_YIELD 1
        PROC_SET_ONCYCLE rlMapBattleLoadHUD

        PROC_YIELD 48
        PROC_CALL rlMapBattleOpenExperienceWindow

        PROC_JUMP_IF_BITS_UNSET _ACD1, $0002

            _ACC2
            PROC_YIELD 1
            PROC_CALL rlMapBattleWaitExperienceWindow

            PROC_JUMP_IF_BITS_UNSET _ACC2, $0004

          PROC_YIELD 1
        _ACD1
        PROC_CALL rlMapBattleStartLevelUpBanner
        PROC_JUMP_IF_BITS_UNSET _ACFC, $0002

          PROC_CALL rlMapBattleLowerMusic
          PROC_JUMP_IF_BITS_UNSET _ACEE, $0004

            PROC_YIELD 16
            PROC_CALL rlPlayLevelUpJingle

        _ACEE
        PROC_YIELD 1
        PROC_SET_ONCYCLE rlMapBattleLevelUpBanner
        PROC_JUMP_IF_BITS_UNSET _ACEE, $0004

        PROC_YIELD 107

        _ACFC
        PROC_CALL rlMapBattleStartStatGains

        PROC_JUMP_IF_BITS_UNSET _AD22, $0002
        PROC_CALL rlMapBattleLowerMusic

        PROC_JUMP_IF_BITS_UNSET _AD14, $0004

          PROC_YIELD 16

        _AD14
        PROC_SET_ONCYCLE rlMapBattleStatGains

        _AD18
        PROC_YIELD 1
        PROC_JUMP_IF_BITS_UNSET _AD18, $0004

        PROC_YIELD 8

        _AD22
        PROC_CALL rlShowObtainedGoldText

        PROC_JUMP_IF_BITS_UNSET _AD48, $0002

        PROC_CALL rlMapBattleLowerMusic
        PROC_JUMP_IF_BITS_UNSET _AD3A, $0004

          PROC_YIELD 16

        _AD3A
        PROC_CALL rlPlayGoldObtainedJingle
        PROC_YIELD 117
        PROC_CALL rlCloseMapBattleTextBox
        PROC_YIELD 8

        _AD48
        PROC_CALL rlShowObtainedItemText

        PROC_JUMP_IF_BITS_UNSET _AD6E, $0002

        PROC_CALL rlMapBattleLowerMusic

        PROC_JUMP_IF_BITS_UNSET _AD60, $0004

          PROC_YIELD 16

        _AD60
        PROC_CALL rlPlayItemObtainedJingle
        PROC_YIELD 117
        PROC_CALL rlCloseMapBattleTextBox
        PROC_YIELD 8

        _AD6E
        PROC_CALL rlMapBattleRestoreMusic
        PROC_YIELD 16
        PROC_SET_ONCYCLE rlProcMapActionRewardsRestoreGraphics
        PROC_HALT

        ; AD7B

    .endsection Unsorted9EACAFSection


    .section Unsorted9EAD7BSection

      .al
      .xl

      rlProcMapActionRewardsRestoreGraphics ; 9E/AD7B

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #<>aProcMapBattleHalt
        sta aProcSystem.aHeaderCodeOffset,b,x
        lda #$0001
        sta aProcSystem.aHeaderSleepTimer,b,x
        jsl rlLoadCursorSpriteGraphics
        lda wBattleType
        and #$00FF
        cmp #$0003
        beq _AD9E
        jsl rlRestoreMapBattlePalettes
        bra _ADA6


        _AD9E
        jsl rlCastleRestoreCourtyardPalettes
        jsl rlShowMapBattleCastleScreenUnits

        _ADA6
        phb
        jsl rlLoadMapSpriteOAMPalettes
        plb
        .databank ?
        plx
        lda #<>rlProcMapActionRewardsEnd
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 9E/ADB4

    .endsection Unsorted9EAD7BSection


    .section Unsorted9EADB4Section

      .al
      .xl

      rlProcMapActionRewardsEnd ; 9E/ADB4

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlReloadMenuIconGraphics
        bcs _ADD0
        lda wMapAnimationSignals
        ora #$0002
        sta wMapAnimationSignals
        lda @l aProcSystem.aBody7,x
        sta wGameStateRoutine1,b
        jsl rlProcEngineFreeProc

        _ADD0
        rtl

        .databank 0

        ; 9E/ADD1

    .endsection Unsorted9EADB4Section


    .section Unsorted9ED07ASection

      .al
      .xl

      rlStartReturnHomeAnimation ; 9E/D07A

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`procReturnHome)<<8
        sta lR44+1
        lda #<>procReturnHome
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 9E/D089

    .endsection Unsorted9ED07ASection


    .section Unsorted9ED089Section

      .al
      .xl

      procReturnHome ; 9E/D089

        .structProcInfo "ON", rlProcReturnHomeInit, rlProcReturnHomeQueueGraphics, aProcReturnHomeCode

      rlProcReturnHomeInit ; 9E/D091

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
        sta aMapAction.wUnknown7F455A
        sta aMapAction.wSideTallSprite
        sta wMapBattleMode
        sta wMapMagicStart
        sta wMapMagicDone
        sta <>wMapBattleAttackerBallista,b
        sta <>wMapBattleDefenderBallista,b
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
        sta <>aMapAction.wAttackerWeaponType,b
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
        lda #$001F
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
        lda #$0000
        sta aProcSystem.aHeaderBitfield,b,x
        lda $7E4EAF
        sta aActionStructUnit1.ClassID
        jsl rlPauseMapSpriteAnimation
        jsl rlPauseMapTileAnimation
        ply
        rtl

        .databank 0

    .endsection Unsorted9ED089Section


    .section Unsorted9ED1A1Section

      .al
      .xl

      rlProcWaitMapMagicStartCycle ; 9E/D1A1

        .al
        .xl
        .autsiz
        .databank ?

        ; On-cycle: once wMapMagicStart is set, moves on to rlProcWaitMapMagicDoneCycle; clears the active sprite sync flag.

        lda wMapMagicStart
        beq _D1AD
        lda #<>rlProcWaitMapMagicDoneCycle
        sta aProcSystem.aHeaderOnCycle,b,x

        _D1AD
        lda aMapAction.wMapBattleStrikeSignal
        beq _D1BA
        lda #$0000
        sta aMapAction.wMapBattleStrikeSignal

        _D1BA
        rtl

        .databank 0

        ; 9E/D1BB

      rlProcWaitMapMagicDoneCycle ; 9E/D1BB

        .al
        .xl
        .autsiz
        .databank ?

        lda wMapMagicDone
        beq _D1D0
        lda #<>rlProcReturnHomeFinishMagic
        sta aProcSystem.aHeaderOnCycle,b,x
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0002
        sta aProcSystem.aHeaderBitfield,b,x

        _D1D0
        lda aMapAction.wMapBattleStrikeSignal
        beq _D1DD
        lda #$0000
        sta aMapAction.wMapBattleStrikeSignal

        _D1DD
        rtl

        .databank 0

        ; 9E/D1DE

      rlProcReturnHomeFinishMagic ; 9E/D1DE

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #<>rlProcReturnHomeIdle
        sta aProcSystem.aHeaderOnCycle,b,x
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0002
        ora #$0001
        sta aProcSystem.aHeaderBitfield,b,x
        plx
        rtl

        .databank 0

        ; 9E/D1F3

      rlProcReturnHomeIdle ; 9E/D1F3

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 9E/D1F4

    .endsection Unsorted9ED1A1Section


    .section Unsorted9ED1F4Section

      .al
      .xl

      aProcReturnHomeCode ; 9E/D1F4

        PROC_YIELD 1
        PROC_CALL rlCheckMapMagicDecompressionDone
        PROC_JUMP_IF_BITS_UNSET aProcReturnHomeCode, $0001
        PROC_SET_ONCYCLE rlProcReturnHomeQueueSpriteData
        PROC_YIELD 56
        PROC_CALL rlUploadMapBattleShadowTiles
        PROC_YIELD 4
        PROC_CALL rlMapActionQueueEffectGraphics
        PROC_YIELD 4
        PROC_CALL rlMapActionUploadEffectGraphics
        PROC_YIELD 4
        PROC_CALL rlCreateMapBattleAttackerSprites
        PROC_CALL rlReturnHomeCopySpriteSlotsToDefender
        PROC_YIELD 2
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
        PROC_JUMP_IF_BITS_UNSET _D269, $0002
        _D255
        PROC_YIELD 1
        PROC_CALL rlCheckMapMagicDecompressionDone
        PROC_JUMP_IF_BITS_UNSET _D255, $0001
        PROC_CALL rlUploadMapMagicSpriteTiles
        PROC_YIELD 2
        _D269
        PROC_CALL rlStartMapMagicEffect
        PROC_YIELD 16
        _D270
        PROC_YIELD 1
        PROC_CALL rlReturnHomeStartMagicRound
        PROC_YIELD 1
        PROC_SET_ONCYCLE rlProcWaitMapMagicStartCycle
        _D27D
        PROC_YIELD 1
        PROC_JUMP_IF_BITS_UNSET _D27D, $0002
        PROC_YIELD 1
        PROC_JUMP_IF_BITS_UNSET _D270, $0001
        PROC_YIELD 4
        PROC_CALL rlEndMapMagicEffect
        PROC_CALL rlRestoreMapMagicScreenRegisters
        PROC_YIELD 1
        PROC_CALL rlEndReturnHomeSprites
        PROC_CALL rlLoadCursorSpriteGraphics
        PROC_YIELD 4
        PROC_CALL rlLoadMapSpriteOAMPalettes
        PROC_YIELD 1
        PROC_CALL rlSignalMapAnimationDone
        PROC_END


        ; 9E/D2B5

    .endsection Unsorted9ED1F4Section


    .section Unsorted9ED2B5Section

      .al
      .xl

      rlProcReturnHomeQueueGraphics ; 9E/D2B5

        .al
        .xl
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
        lda #$0031
        sta wR11
        jsl rlUnsignedMultiply16By16
        lda wR12
        clc
        adc wR0
        adc #$0003
        tax
        lda aBattleMapSpriteData+1,x
        sta lR18+1
        lda aBattleMapSpriteData,x
        sta lR18
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        clc
        adc #$0000
        sta lR19
        plp
        plb
        .databank $7F
        jsl rlAppendDecompList
        phb
        php
        sep #$20
        lda #$7F
        pha
        rep #$20
        plb
        .databank $7F
        lda #(`g4bppcMapBattleWeaponIcons)<<8
        sta lR18+1
        lda #<>g4bppcMapBattleWeaponIcons
        sta lR18
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        clc
        adc #$4000
        sta lR19
        plp
        plb
        .databank $7F
        jsl rlAppendDecompList
        ply
        plx
        lda #<>rlProcReturnHomeIdle
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 9E/D337

    .endsection Unsorted9ED2B5Section


    .section Unsorted9ED337Section

      .al
      .xl

      rlProcReturnHomeQueueSpriteData ; 9E/D337

        .al
        .autsiz
        .databank ?

        phy
        phx
        lda #0
        sta aMapAction.wMapBattleStrikeSignal
        sta aMapAction.wMapBattleStrikeDone
        sta aMapAction.wMapBattleRoundRunning
        sta wMapMagicStart
        sta aProcSystem.aHeaderBitfield,b,x

        lda #$FFFF
        sta aMapAction.wMapBattleAttackerSpriteSlot
        sta aMapAction.wMapBattleAttackerAuxSpriteSlot
        jsl rlInitMapBattleSpriteInfos
        jsl rlSelectMapBattleAttackerSprite
        lda #0
        jsl rlMapBattleQueueSpriteData
        plx
        lda #<>rlProcReturnHomeIdle
        sta aProcSystem.aHeaderOnCycle,b,x
        ply
        rtl

        .databank 0

        ; 9E/D372

    .endsection Unsorted9ED337Section


    .section Unsorted9ED372Section

      .al
      .xl

      rlReturnHomeStartMagicRound ; 9E/D372

        .al
        .xl
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
        lda #$0000
        sta @l aMapAction.wMapBattleStrikeSignal
        sta @l aMapAction.wMapBattleStrikeDone
        sta @l aMapAction.wMapBattleRoundRunning
        sta @l aProcSystem.aHeaderBitfield,x
        lda #$0001
        sta <>wMapMagicStart,b
        lda <>aMapAction.lAttackerSpriteData+1,b
        sta <>aMapAction.lAttackerRoundScript+1,b
        sta <>aMapAction.lAttackerAuxRoundScript+1,b
        lda <>aMapAction.lAttackerSpriteData,b
        sta lR18
        lda <>aMapAction.lAttackerSpriteData+1,b
        sta lR18+1
        lda @l aMapAction.wAttackerFacing
        sta wR0
        lda #$0000
        jsr rsGetMapBattleRoundScripts
        stx <>aMapAction.lAttackerRoundScript,b
        sty <>aMapAction.lAttackerAuxRoundScript,b
        plx
        ply
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 9E/D3C1

    .endsection Unsorted9ED372Section


    .section Unsorted9ED3C1Section

      .al
      .xl

      rlEndReturnHomeSprites ; 9E/D3C1

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Frees the unit's sprites, resumes map animations, and restores the OAM/sprite engine state.

        phx
        lda aMapAction.wMapBattleAttackerSpriteSlot
        tax
        stz aActiveSpriteSystem.aTypeOffset,b,x
        lda aMapAction.wMapBattleAttackerAuxSpriteSlot
        tax
        cpx #$FFFF
        beq _D3D7
        stz aActiveSpriteSystem.aTypeOffset,b,x

        _D3D7
        lda #$0001
        sta aMapAction.wMapBattleRoundRunning
        jsl rlResumeMapSpriteAnimation
        jsl rlResumeMapTileAnimation
        plx
        lda aProcSystem.aBody7,b,x
        sta wGameStateRoutine1,b
        lda #(`rlPushToOAMBuffer)<<8
        sta lActiveSpriteRenderer+1,b
        lda #<>rlPushToOAMBuffer
        sta lActiveSpriteRenderer,b
        lda wMapBattleSavedSpriteEngineFlag
        sta aActiveSpriteSystem,b
        rtl

        .databank 0

        ; 9E/D401

    .endsection Unsorted9ED3C1Section


    .section Unsorted9ED401Section

      .al
      .xl

      rlReturnHomeCopySpriteSlotsToDefender ; 9E/D401

        .al
        .xl
        .autsiz
        .databank ?

        lda aMapAction.wMapBattleAttackerSpriteSlot
        sta aMapAction.wMapBattleDefenderSpriteSlot
        lda aMapAction.wMapBattleAttackerAuxSpriteSlot
        sta aMapAction.wMapBattleDefenderAuxSpriteSlot
        rtl

        .databank 0

        ; 9E/D412

    .endsection Unsorted9ED401Section


    .section Unreferenced9ED412Section

      .al
      .xl

      rlReturnHomeFreeAttackerSprites ; 9E/D412

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda aMapAction.wMapBattleAttackerSpriteSlot
        tax
        stz aActiveSpriteSystem.aTypeOffset,b,x
        lda aMapAction.wMapBattleAttackerAuxSpriteSlot
        cmp #$FFFF
        beq _D428
        tax
        stz aActiveSpriteSystem.aTypeOffset,b,x

        _D428
        plx
        rtl

        .databank 0

        ; 9E/D42A

    .endsection Unreferenced9ED412Section
    .section Unsorted9ED42ASection

      .al
      .xl

      rlStartHolyWeaponShine ; 9E/D42A

        .al
        .autsiz
        .databank ?

        jsl rlClearBattleData
        jsl rlSetHolyWeaponShineUnit

        lda #(`procHolyWeaponShine)<<8
        sta lR44+1
        lda #<>procHolyWeaponShine
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

      procHolyWeaponShine .structProcInfo "ON", rlProcHolyWeaponShineInit, rlProcHolyWeaponShineQueueGraphics, aProcHolyWeaponShineCode ; 9E/D441

    .endsection Unsorted9ED42ASection


    .section Unsorted9ED449Section

      .al
      .xl

      rlProcHolyWeaponShineInit ; 9E/D449

        .al
        .autsiz
        .databank ?

        phy
        phx
        phb
        pea $7F00
        plb
        plb

        lda #0
        sta aMapAction.wMapBattleStrikeSignal
        sta aMapAction.wMapBattleStrikeDone
        sta aMapAction.wMapBattleRoundRunning
        sta aMapAction.wUnknown7F455A
        sta aMapAction.wSideTallSprite
        sta wMapBattleMode
        sta wMapBattleStrikeDrains
        sta wMapAnimationSignals
        sta <>wMapBattleAttackerBallista,b
        sta <>wMapBattleDefenderBallista,b

        lda #$FFFF
        sta aMapAction.wMapBattleAttackerSpriteSlot
        sta aMapAction.wMapBattleAttackerAuxSpriteSlot
        sta aMapAction.wMapBattleDefenderSpriteSlot
        sta aMapAction.wMapBattleDefenderAuxSpriteSlot

        lda aActionStructUnit1.ClassID
        sta @l wR0
        lda aActionStructUnit1.Gender
        sta @l wR1
        lda aActionStructUnit1.CharacterID
        sta @l wR2
        jsl rlGetMapBattleClassSprite
        sta <>aMapAction.wAttackerSpriteRow,b
        lda aActionStructUnit1.XPosition
        sta <>aMapAction.wAttackerXTile,b
        lda aActionStructUnit1.YPosition
        sta <>aMapAction.wAttackerYTile,b

        lda #$FFFF
        jsl rlGetClassMapBattleWeaponType
        sta <>aMapAction.wAttackerWeaponType,b

        lda #$FFFF
        sta aActionStructUnit1.WeaponID

        lda #0
        sta <>aMapAction.wDefenderSpriteRow,b
        sta <>aMapAction.wDefenderXTile,b
        sta <>aMapAction.wDefenderYTile,b
        sta <>aMapAction.wDefenderWeaponType,b

        lda #$FFFF
        sta aActionStructUnit2.DeploymentNumber

        lda #6
        sta <>aMapAction.wAttackerFacing,b
        sta <>aMapAction.wDefenderFacing,b

        lda #0
        sta <>wMapMagicFlags,b
        sta <>aMapAction.wMapBattleRoundIndex,b
        sta $7E4F85

        lda #5
        sta <>wMapBattleSkillEffect,b

        plb
        lda #(`rlPushToOAMBufferDualTileBase)<<8
        sta $0015E4+1
        lda #<>rlPushToOAMBufferDualTileBase
        sta $0015E4
        plx

        lda $000302
        sta aProcSystem.aBody7,x
        stz wGameStateRoutine1,b

        lda #0
        sta aProcSystem.aHeaderBitfield,b,x
        jsl rlPauseMapSpriteAnimation
        jsl rlPauseMapTileAnimation
        ply
        rtl

        .databank 0

        ; 9E/D528

    .endsection Unsorted9ED449Section


    .section Unreferenced9ED528Section

      .al
      .xl

      rlProcHolyWeaponShineFreeSprites ; 9E/D528

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsl rlHolyWeaponShineFreeAttackerSprites
        lda #<>rlProcHolyWeaponShineIdle
        sta aProcSystem.aHeaderOnCycle,b,x
        plx
        rtl

        .databank 0

        ; 9E/D535

    .endsection Unreferenced9ED528Section
    .section Unsorted9ED535Section

      .al
      .xl

      rlProcHolyWeaponShineIdle ; 9E/D535

        .al
        .autsiz
        .databank ?

        rtl

        .databank 0

      aProcHolyWeaponShineCode ; 9E/D536

        -
        PROC_YIELD 1
        PROC_CALL rlCheckMapMagicDecompressionDone
        PROC_JUMP_IF_BITS_UNSET -, $0001

        PROC_SET_ONCYCLE rlProcHolyWeaponShineQueueSpriteData
        PROC_YIELD 40
        PROC_CALL rlUploadMapBattleShadowTiles
        PROC_YIELD 4
        PROC_CALL rlMapActionQueueEffectGraphics
        PROC_YIELD 4
        PROC_CALL rlMapActionUploadEffectGraphics
        PROC_YIELD 4
        PROC_CALL rlCreateMapBattleAttackerSprites
        PROC_YIELD 2
        PROC_CALL rlHolyWeaponShineClearRoundState
        PROC_YIELD 1
        PROC_CALL rlMapBattleStartSkillEffect
        PROC_SET_LOOP_COUNTER 96

        -
        PROC_YIELD 1
        PROC_CALL rlBattleSceneRunPaletteEffects
        PROC_JUMP_WHILE_LOOP_COUNTER -

        PROC_CALL rlMapBattleEndSkillEffect
        PROC_YIELD 16
        PROC_CALL rlEndHolyWeaponShineSprites
        PROC_CALL rlLoadCursorSpriteGraphics
        PROC_YIELD 4
        PROC_CALL rlLoadMapSpriteOAMPalettes
        PROC_YIELD 1
        PROC_CALL rlSignalMapAnimationDone
        PROC_END

      rlSetHolyWeaponShineUnit ; 9E/D5A1

        .al
        .autsiz
        .databank ?

        phx
        lda wEventUnitSlot1Pointer,b
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitDeploymentOffset
        sta aActionStructUnit1.DeploymentNumber
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
        bne +

        lda #$FFFF
        bra ++

        +
        jsl rlGetItemIDByInventorySlot

        +
        sta aActionStructUnit1.WeaponID
        jsl rlGetSelectedUnitDeploymentOffset
        sta aActionStructUnit1.DeploymentNumber
        tax
        lda aDeploymentTable._State,x
        and #DeploymentAllegianceMask
        sta aMapAction.wAttackerAllegiance
        plx
        rtl

        .databank 0

    .endsection Unsorted9ED535Section


    .section Unsorted9ED609Section

      .al
      .xl

      rlProcHolyWeaponShineQueueGraphics ; 9E/D609

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
        lda #$0031
        sta wR11
        jsl rlUnsignedMultiply16By16
        lda wR12
        clc
        adc wR0
        adc #$0003
        tax
        lda aBattleMapSpriteData+1,x
        sta lR18+1
        lda aBattleMapSpriteData,x
        sta lR18

        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        clc
        adc #0
        sta lR19
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

        lda #(`g4bppcMapBattleWeaponIcons)<<8
        sta lR18+1
        lda #<>g4bppcMapBattleWeaponIcons
        sta lR18
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        clc
        adc #$4000
        sta lR19
        plp
        plb
        jsl rlAppendDecompList
        ply
        plx
        lda #<>rlProcHolyWeaponShineIdle
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

    .endsection Unsorted9ED609Section


    .section Unsorted9ED68BSection

      .al
      .xl

      rlProcHolyWeaponShineQueueSpriteData ; 9E/D68B

        .al
        .autsiz
        .databank ?

        phy
        phx
        lda #0
        sta aMapAction.wMapBattleRoundRunning
        sta aProcSystem.aHeaderBitfield,b,x
        lda #$FFFF
        sta aMapAction.wMapBattleAttackerSpriteSlot
        sta aMapAction.wMapBattleAttackerAuxSpriteSlot
        jsl rlInitMapBattleSpriteInfos
        jsl rlSelectMapBattleAttackerSprite
        lda #0
        jsl rlMapBattleQueueSpriteData
        plx
        lda #<>rlProcHolyWeaponShineIdle
        sta aProcSystem.aHeaderOnCycle,b,x
        ply
        rtl

        .databank 0

        ; 9E/D6BA

    .endsection Unsorted9ED68BSection


    .section Unsorted9ED6BASection

      .al
      .xl

      rlHolyWeaponShineClearRoundState ; 9E/D6BA

        .al
        .xl
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
        lda #$0000
        sta @l aMapAction.wMapBattleRoundRunning
        sta @l aProcSystem.aHeaderBitfield,x
        plx
        ply
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 9E/D6D6

      rlEndHolyWeaponShineSprites ; 9E/D6D6

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda aMapAction.wMapBattleAttackerSpriteSlot
        tax
        lda #$0000
        sta aActiveSpriteSystem.aTypeOffset,b,x
        lda aMapAction.wMapBattleAttackerAuxSpriteSlot
        tax
        cpx #$FFFF
        beq _D6F2
        lda #$0000
        sta aActiveSpriteSystem.aTypeOffset,b,x

        _D6F2
        lda #$0001
        sta aMapAction.wMapBattleRoundRunning
        lda aActionStructUnit1
        tax
        jsl rlDeployedUnitUnsetHiddenIfAlive
        jsl rlResumeMapSpriteAnimation
        jsl rlResumeMapTileAnimation
        plx
        lda aProcSystem.aBody7,b,x
        sta wGameStateRoutine1,b
        lda #(`rlPushToOAMBuffer)<<8
        sta lActiveSpriteRenderer+1,b
        lda #<>rlPushToOAMBuffer
        sta lActiveSpriteRenderer,b
        rtl

        .databank 0

        ; 9E/D71E

      rlSignalMapAnimationDone ; 9E/D71E

        .al
        .xl
        .autsiz
        .databank ?

        ; Sets wMapAnimationSignals bit 1 to signal the calling event/state that the animation finished.

        lda wMapAnimationSignals
        ora #$0002
        sta wMapAnimationSignals
        rtl

        .databank 0

        ; 9E/D72A

    .endsection Unsorted9ED6BASection


    .section Unreferenced9ED72ASection

      .al
      .xl

      rlHolyWeaponShineFreeAttackerSprites ; 9E/D72A

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda aMapAction.wMapBattleAttackerSpriteSlot
        tax
        stz aActiveSpriteSystem.aTypeOffset,b,x
        lda aMapAction.wMapBattleAttackerAuxSpriteSlot
        cmp #$FFFF
        beq _D740
        tax
        stz aActiveSpriteSystem.aTypeOffset,b,x

        _D740
        plx
        rtl

        .databank 0

        ; 9E/D742

    .endsection Unreferenced9ED72ASection
    .section Unsorted9EDAE7Section

      .al
      .xl

      rlStartGiveGoldAnimation ; 9E/DAE7

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`procGiveGold)<<8
        sta lR44+1
        lda #<>procGiveGold
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 9E/DAF6

    .endsection Unsorted9EDAE7Section


    .section ProcScript9EDAF6Section

      .al
      .xl

      procGiveGold ; 9E/DAF6

        .structProcInfo "ON", rlProcGiveGoldInit, rlProcGiveGoldQueueGraphics, aProcGiveGoldCode

    .endsection ProcScript9EDAF6Section


    .section Unsorted9EDAFESection

      .al
      .xl

      rlProcGiveGoldInit ; 9E/DAFE

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
        sta <>aMapAction.wUnknown7F455A,b
        sta <>aMapAction.wSideTallSprite,b
        sta <>wMapBattleMode,b
        sta <>wMapBattleStrikeDrains,b
        sta <>wMapBattleSolo,b
        sta <>wMapBattleAttackerBallista,b
        sta <>wMapBattleDefenderBallista,b
        sta <>wMapBattleMusicLowered,b
        sta @l aProcSystem.aHeaderBitfield,x
        sta wMapAnimationSignals
        lda aActionStructUnit1.ClassID
        sta @l wR0
        lda aActionStructUnit1.Gender
        sta @l wR1
        lda aActionStructUnit1.CharacterID
        sta @l wR2
        jsl rlGetMapBattleClassSprite
        sta <>aMapAction.wAttackerSpriteRow,b
        lda aActionStructUnit1.XPosition
        sta <>aMapAction.wAttackerXTile,b
        lda aActionStructUnit1.YPosition
        sta <>aMapAction.wAttackerYTile,b
        lda #$FFFF
        jsl rlGetClassMapBattleWeaponType
        sta <>aMapAction.wAttackerWeaponType,b
        lda #$FFFF
        sta aActionStructUnit1.WeaponID
        lda aActionStructUnit2.ClassID
        sta @l wR0
        lda aActionStructUnit2.Gender
        sta @l wR1
        lda aActionStructUnit2.CharacterID
        sta @l wR2
        jsl rlGetMapBattleClassSprite
        sta <>aMapAction.wDefenderSpriteRow,b
        lda aActionStructUnit2.XPosition
        sta <>aMapAction.wDefenderXTile,b
        lda aActionStructUnit2.YPosition
        sta <>aMapAction.wDefenderYTile,b
        lda #$FFFF
        jsl rlGetClassMapBattleWeaponType
        sta <>aMapAction.wDefenderWeaponType,b
        lda #$FFFF
        sta aActionStructUnit2.WeaponID
        jsl rlGetMapBattleFacing
        lda <>aMapAction.wAttackerFacing,b
        eor #$0004
        sta <>aMapAction.wDefenderFacing,b
        lda wBattleType
        and #$00FF
        cmp #$0003
        bne _DBD7
        lda #$0006
        sta <>aMapAction.wAttackerFacing,b
        sta <>aMapAction.wDefenderFacing,b
        lda #$0000
        sta @l $000891

        _DBD7
        lda #$0000
        sta <>wMapMagicFlags,b
        sta <>aMapAction.wMapBattleRoundIndex,b
        sta $7E4F85
        plb
        .databank ?
        lda #(`rlPushToOAMBufferDualTileBase)<<8
        sta @l lActiveSpriteRenderer+1
        lda #<>rlPushToOAMBufferDualTileBase
        sta @l lActiveSpriteRenderer
        plx
        lda @l wGameStateRoutine1
        sta @l aProcSystem.aBody7,x
        stz wGameStateRoutine1,b
        jsl rlPauseMapSpriteAnimation
        jsl rlPauseMapTileAnimation
        ply
        rtl

        .databank 0

        ; 9E/DC09

      rlProcGiveGoldQueueGraphics ; 9E/DC09

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlQueueMapBattleSpriteGraphics
        lda #<>rlMapBattleWaitDecompression
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 9E/DC14

      rlProcGiveGoldIdle ; 9E/DC14

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 9E/DC15

    .endsection Unsorted9EDAFESection


    .section ProcScript9EDC15Section

      .al
      .xl

      aProcGiveGoldCode ; 9E/DC15

        PROC_YIELD 1
        PROC_JUMP_IF_BITS_UNSET aProcGiveGoldCode, $0001
        PROC_YIELD 4
        PROC_SET_ONCYCLE rlProcGiveGoldQueueSpriteData
        PROC_YIELD 32
        PROC_CALL rlUploadMapBattleShadowTiles
        PROC_YIELD 2
        PROC_CALL rlCreateMapBattleAttackerSprites
        PROC_YIELD 2
        PROC_CALL rlCreateMapBattleDefenderSprites
        PROC_YIELD 2
        PROC_CALL rlGiveGoldClearRoundState
        PROC_YIELD 32
        PROC_CALL rlGiveGoldUploadCoinGraphics
        PROC_YIELD 4
        PROC_CALL rlGiveGoldCreateCoinSprite
        _DC4D
        PROC_YIELD 1
        PROC_CALL rlGiveGoldWaitCoinSprite
        PROC_JUMP_IF_BITS_UNSET _DC4D, $0004
        PROC_YIELD 4
        PROC_SET_ONCYCLE rlMapBattleLoadHUD
        PROC_YIELD 48
        PROC_CALL rlMapBattleOpenExperienceWindow
        PROC_JUMP_IF_BITS_UNSET _DC7C, $0002
        _DC6D
        PROC_YIELD 1
        PROC_CALL rlMapBattleWaitExperienceWindow
        PROC_JUMP_IF_BITS_UNSET _DC6D, $0004
        PROC_YIELD 1
        _DC7C
        PROC_CALL rlMapBattleStartLevelUpBanner
        PROC_JUMP_IF_BITS_UNSET _DCA7, $0002
        PROC_CALL rlMapBattleLowerMusic
        PROC_JUMP_IF_BITS_UNSET _DC99, $0004
        PROC_YIELD 16
        PROC_CALL rlPlayLevelUpJingle
        _DC99
        PROC_YIELD 1
        PROC_SET_ONCYCLE rlMapBattleLevelUpBanner
        PROC_JUMP_IF_BITS_UNSET _DC99, $0004
        PROC_YIELD 116
        _DCA7
        PROC_CALL rlMapBattleStartStatGains
        PROC_JUMP_IF_BITS_UNSET _DCC0, $0002
        PROC_SET_ONCYCLE rlMapBattleStatGains
        _DCB6
        PROC_YIELD 1
        PROC_JUMP_IF_BITS_UNSET _DCB6, $0004
        PROC_YIELD 8
        _DCC0
        PROC_CALL rlMapBattleRestoreMusic
        PROC_YIELD 16
        PROC_CALL rlEndGiveGoldSprites
        PROC_SET_ONCYCLE rlProcMapActionRewardsRestoreGraphics
        PROC_HALT


        ; 9E/DCD2

    .endsection ProcScript9EDC15Section


    .section Unsorted9EDCD2Section

      .al
      .xl

      rlProcGiveGoldQueueSpriteData ; 9E/DCD2

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda #$0000
        sta aMapAction.wMapBattleRoundRunning
        sta aProcSystem.aHeaderBitfield,b,x
        lda #$FFFF
        sta aMapAction.wMapBattleAttackerSpriteSlot
        sta aMapAction.wMapBattleAttackerAuxSpriteSlot
        sta aMapAction.wMapBattleDefenderSpriteSlot
        sta aMapAction.wMapBattleDefenderAuxSpriteSlot
        jsl rlInitMapBattleSpriteInfos
        jsl rlSelectMapBattleAttackerSprite
        lda #$0000
        jsl rlMapBattleQueueSpriteData
        jsl rlSelectMapBattleDefenderSprite
        lda #$0001
        jsl rlMapBattleQueueSpriteData
        plx
        lda #<>rlProcGiveGoldIdle
        sta aProcSystem.aHeaderOnCycle,b,x
        ply
        rtl

        .databank 0

        ; 9E/DD14

      rlGiveGoldClearRoundState ; 9E/DD14

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta aMapAction.wMapBattleRoundRunning
        sta @l aProcSystem.aHeaderBitfield,x
        rtl

        .databank 0

        ; 9E/DD20

      rlEndGiveGoldSprites ; 9E/DD20

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda aMapAction.wMapBattleAttackerSpriteSlot
        tax
        lda #$0000
        sta aActiveSpriteSystem.aTypeOffset,b,x
        lda aMapAction.wMapBattleAttackerAuxSpriteSlot
        tax
        cpx #$FFFF
        beq _DD3C
        lda #$0000
        sta aActiveSpriteSystem.aTypeOffset,b,x

        _DD3C
        lda aMapAction.wMapBattleDefenderSpriteSlot
        tax
        lda #$0000
        sta aActiveSpriteSystem.aTypeOffset,b,x
        lda aMapAction.wMapBattleDefenderAuxSpriteSlot
        tax
        cpx #$FFFF
        beq _DD57
        lda #$0000
        sta aActiveSpriteSystem.aTypeOffset,b,x

        _DD57
        lda #$0001
        sta aMapAction.wMapBattleRoundRunning
        lda aActionStructUnit1
        tax
        jsl rlDeployedUnitUnsetHiddenIfAlive
        lda aActionStructUnit2
        tax
        jsl rlDeployedUnitUnsetHiddenIfAlive
        lda #1,s
        tax
        jsl rlResumeMapSpriteAnimation
        lda wBattleType
        and #$00FF
        cmp #$0003
        beq _DD87
        jsl rlResumeMapTileAnimation

        _DD87
        lda #(`rlPushToOAMBuffer)<<8
        sta lActiveSpriteRenderer+1,b
        lda #<>rlPushToOAMBuffer
        sta lActiveSpriteRenderer,b
        stz wBufferBG3VOFS
        plx
        rtl

        .databank 0

        ; 9E/DD97

      rlGiveGoldUploadCoinGraphics ; 9E/DD97

        .al
        .xl
        .autsiz
        .databank ?

        ; Uploads coin OAM tiles (g4bppGiveGoldSprites) and aGiveGoldCoinOAMPalette to OAM palette 6.

        phx
        lda #(`g4bppGiveGoldSprites)<<8
        sta lR18+1
        lda #<>g4bppGiveGoldSprites
        sta lR18
        lda #$0400
        sta wR0
        lda bBufferOBSEL
        and #$0003
        asl a
        asl a
        asl a
        asl a
        asl a
        xba
        sta wR1
        jsl rlDMAByPointer
        ldx #$001E

        _DDBB
        lda aGiveGoldCoinOAMPalette,x
        sta aOAMPaletteBuffer.aPalette6,b,x
        dec x
        dec x
        bpl _DDBB
        plx
        rtl

        .databank 0

        ; 9E/DDC8

    .endsection Unsorted9EDCD2Section


    .section Table9EDDC8Section

      .al
      .xl

      aGiveGoldCoinOAMPalette ; 9E/DDC8

        ; Read by rlGiveGoldUploadCoinGraphics.

        .word $3800, $7FFF, $035F, $01BF, $0037, $0C8A, $0425, $7FBA
        .word $7E6E, $7C84, $30C4, $1421, $0000, $0000, $0000, $0000

        ; 9E/DDE8

    .endsection Table9EDDC8Section


    .section Unsorted9EDDE8Section

      .al
      .xl

      rlGiveGoldCreateCoinSprite ; 9E/DDE8

        ; Creates the coin active sprite above the recipient unit.

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda #$0000
        sta aProcSystem.aHeaderBitfield,b,x
        lda aMapAction.lAttackerSpriteData
        sta $7F57EA
        lda aMapAction.lAttackerSpriteData+1
        sta $7F57EC
        lda #(`aGiveGoldCoinSpriteData)<<8
        sta aMapAction.lAttackerSpriteData+1
        lda #<>aGiveGoldCoinSpriteData
        sta aMapAction.lAttackerSpriteData
        lda aMapAction.wDefenderYTile
        tay
        lda aMapAction.wDefenderXTile
        tax
        lda aActionStructUnit2.UnitRAMPointer
        jsl rlGetMapBattleUnitScreenPosition
        lda #(`aGiveGoldCoinSpriteInfo)<<8
        sta lR44+1
        lda #<>aGiveGoldCoinSpriteInfo
        sta lR44
        ldx wR0
        lda wR1
        clc
        adc #$0002
        tay
        lda #<>aGiveGoldCoinSpriteInfo
        jsl rlActiveSpriteEngineCreateSpriteLowestSlotAbove0
        ldx aActiveSpriteSystem.wOffset,b
        txa
        sta @l $001097
        lda #$0000
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        lda #$0000
        sta aActiveSpriteSystem.aUnknown001320,b,x
        lda #$0006
        sta aActiveSpriteSystem.aPalette,b,x
        lda #$0000
        sta aActiveSpriteSystem.aTileBase,b,x
        sta aActiveSpriteSystem.aTileBaseHigh,b,x
        plx
        ply
        rtl

        .databank 0

        ; 9E/DE60

      rlGiveGoldWaitCoinSprite ; 9E/DE60

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda @l $001097
        tax
        lda aActiveSpriteSystem.aTypeOffset,b,x
        bne _DE87
        lda #1,s
        tax
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0004
        sta aProcSystem.aHeaderBitfield,b,x
        lda $7F57EA
        sta aMapAction.lAttackerSpriteData
        lda $7F57EC
        sta aMapAction.lAttackerSpriteData+1

        _DE87
        plx
        rtl

        .databank 0

        ; 9E/DE89

    .endsection Unsorted9EDDE8Section


    .section Data9EDE89Section

      .al
      .xl

      aGiveGoldCoinSpriteData ; 9E/DE89

        .word _DE89_Table - aGiveGoldCoinSpriteData
        .word _DE89_Script - aGiveGoldCoinSpriteData

        _DE89_Frame00
          .word 1 ; sprite count
          .structSpriteEntry (  -8,  -24), $21, SpriteLarge, $002, 2, 0, false, false

        _DE89_Frame01
          .word 1 ; sprite count
          .structSpriteEntry (  -8,  -26), $21, SpriteLarge, $002, 2, 0, false, false

        _DE89_Frame02
          .word 1 ; sprite count
          .structSpriteEntry (  -8,  -27), $21, SpriteLarge, $002, 2, 0, false, false

        _DE89_Frame03
          .word 1 ; sprite count
          .structSpriteEntry (  -8,  -23), $21, SpriteLarge, $002, 2, 0, false, false

        _DE89_Frame04
          .word 1 ; sprite count
          .structSpriteEntry (  -8,  -24), $21, SpriteLarge, $000, 2, 0, false, false

        _DE89_Frame05
          .word 1 ; sprite count
          .structSpriteEntry (  -8,  -24), $21, SpriteLarge, $004, 2, 0, false, false

        _DE89_Frame06
          .word 4 ; sprite count
          .structSpriteEntry (  -1,  -18), $00, SpriteSmall, $006, 2, 0, false, false
          .structSpriteEntry (  -1,  -11), $00, SpriteSmall, $006, 2, 0, false, false
          .structSpriteEntry (  -7,  -11), $00, SpriteSmall, $006, 2, 0, false, false
          .structSpriteEntry (  -7,  -18), $00, SpriteSmall, $006, 2, 0, false, false

        _DE89_Frame07
          .word 5 ; sprite count
          .structSpriteEntry ( -11,  -20), $00, SpriteSmall, $007, 2, 0, false, false
          .structSpriteEntry (   2,  -20), $00, SpriteSmall, $007, 2, 0, false, false
          .structSpriteEntry ( -11,  -10), $00, SpriteSmall, $007, 2, 0, false, false
          .structSpriteEntry (   2,  -10), $00, SpriteSmall, $007, 2, 0, false, false
          .structSpriteEntry (  -5,  -16), $00, SpriteSmall, $016, 2, 0, false, false

        _DE89_Frame08
          .word 4 ; sprite count
          .structSpriteEntry ( -12,  -21), $00, SpriteSmall, $007, 2, 0, false, false
          .structSpriteEntry (   3,  -21), $00, SpriteSmall, $007, 2, 0, false, false
          .structSpriteEntry ( -12,   -9), $00, SpriteSmall, $007, 2, 0, false, false
          .structSpriteEntry (   3,   -9), $00, SpriteSmall, $007, 2, 0, false, false

        _DE89_Frame09
          .word 4 ; sprite count
          .structSpriteEntry ( -11,  -20), $00, SpriteSmall, $007, 2, 0, false, false
          .structSpriteEntry (   2,  -20), $00, SpriteSmall, $007, 2, 0, false, false
          .structSpriteEntry ( -11,  -10), $00, SpriteSmall, $007, 2, 0, false, false
          .structSpriteEntry (   2,  -10), $00, SpriteSmall, $007, 2, 0, false, false

        _DE89_Frame10
          .word 4 ; sprite count
          .structSpriteEntry (   2,   -9), $00, SpriteSmall, $006, 2, 0, false, false
          .structSpriteEntry ( -13,   -9), $00, SpriteSmall, $006, 2, 0, false, false
          .structSpriteEntry (   2,  -21), $00, SpriteSmall, $006, 2, 0, false, false
          .structSpriteEntry ( -13,  -21), $00, SpriteSmall, $006, 2, 0, false, false

        _DE89_Table
          .word _DE89_Frame00 - aGiveGoldCoinSpriteData
          .word _DE89_Frame01 - aGiveGoldCoinSpriteData
          .word _DE89_Frame02 - aGiveGoldCoinSpriteData
          .word _DE89_Frame03 - aGiveGoldCoinSpriteData
          .word _DE89_Frame04 - aGiveGoldCoinSpriteData
          .word _DE89_Frame05 - aGiveGoldCoinSpriteData
          .word _DE89_Frame06 - aGiveGoldCoinSpriteData
          .word _DE89_Frame07 - aGiveGoldCoinSpriteData
          .word _DE89_Frame08 - aGiveGoldCoinSpriteData
          .word _DE89_Frame09 - aGiveGoldCoinSpriteData
          .word _DE89_Frame10 - aGiveGoldCoinSpriteData

        _DE89_Script
          ACTIVE_SPRITE_TABLE_FRAME 4, 5
          ACTIVE_SPRITE_TABLE_FRAME 2, 0
          ACTIVE_SPRITE_TABLE_FRAME 4, 1
          ACTIVE_SPRITE_TABLE_FRAME 4, 2
          ACTIVE_SPRITE_SOUND $2F
          ACTIVE_SPRITE_TABLE_FRAME 3, 2
          ACTIVE_SPRITE_TABLE_FRAME 2, 3
          ACTIVE_SPRITE_TABLE_FRAME 3, 4
          ACTIVE_SPRITE_TABLE_FRAME 7, 5
          ACTIVE_SPRITE_TABLE_FRAME 48, 4
          ACTIVE_SPRITE_SOUND $30
          ACTIVE_SPRITE_TABLE_FRAME 4, 6
          ACTIVE_SPRITE_TABLE_FRAME 4, 7
          ACTIVE_SPRITE_TABLE_FRAME 2, 8
          ACTIVE_SPRITE_TABLE_FRAME 2, 9
          ACTIVE_SPRITE_TABLE_FRAME 2, 8
          ACTIVE_SPRITE_TABLE_FRAME 2, 9
          ACTIVE_SPRITE_TABLE_FRAME 32, 8
          ACTIVE_SPRITE_TABLE_FRAME 3, 10
          ACTIVE_SPRITE_END

      aGiveGoldCoinSpriteInfo ; 9E/DF78
        .word <>rlGiveGoldCoinSpriteIdle, <>rlGiveGoldCoinSpriteIdle, <>aGiveGoldCoinSpriteData._DE89_Script

      rlGiveGoldCoinSpriteIdle ; 9E/DF7E
        rtl

    .endsection Data9EDE89Section


