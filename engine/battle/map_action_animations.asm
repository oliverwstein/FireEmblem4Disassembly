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

        .structProcInfo "ON", rlProcVillageRaidInit, rlProcUnknown9E9A43Cycle1, aProcVillageRaidCode

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
        sta $454A,b
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
        adc aUnknown9E9B50+2,x
        tay
        lda aMapAction.wAttackerXTile
        clc
        adc aUnknown9E9B50,x
        tax
        lda aActionStructUnit1.UnitRAMPointer
        jsl rlUnknown9E8D25
        lda wR1
        jsl rlUnknown9EAC49
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
        lda #$8100
        sta @l $0015E5
        lda #$841B
        sta @l $0015E4
        plx
        lda @l $000302
        sta @l $0010B7,x
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

      aUnknown9E9B50 ; 9E/9B50

        ; Read by rlProcVillageRaidInit.

        .word $FFFF, $FFFF, $0000, $FFFF, $0001, $FFFF, $FFFF, $0000
        .word $0000, $0000, $0001, $0000

        ; 9E/9B68

    .endsection Table9E9B50Section


    .section Unsorted9E9B68Section

      .al
      .xl

      rlProcUnknown9E9A43Cycle4 ; 9E/9B68

        .al
        .xl
        .autsiz
        .databank ?

        lda aMapAction.wMapBattleRoundRunning
        beq _9B74
        lda #<>rlUnknown9E9B82
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

      rlUnknown9E9B82 ; 9E/9B82

        .al
        .xl
        .autsiz
        .databank ?

        lda aMapAction.wMapBattleRoundRunning
        bne _9B97
        lda #<>rlUnknown9E9BAD
        sta aProcSystem.aHeaderOnCycle,b,x
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0002
        sta aProcSystem.aHeaderBitfield,b,x

        _9B97
        lda aMapAction.wMapBattleStrikeSignal
        beq _9BAC
        lda #$0000
        sta aMapAction.wMapBattleStrikeSignal
        jsl rlUnknown9E9E61
        jsl rlUnknown9E9C70

        _9BAC
        rtl

        .databank 0

        ; 9E/9BAD

      rlUnknown9E9BAD ; 9E/9BAD

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
        lda #<>rlUnknown9E9BE0
        sta aProcSystem.aHeaderOnCycle,b,x
        bra _9BDE


        _9BC8
        jsl rlUnknown9E8F6A
        lda #<>rlUnknown9E9BE0
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

      rlUnknown9E9BE0 ; 9E/9BE0

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
        PROC_SET_ONCYCLE rlProcUnknown9E9A43Cycle2
        PROC_YIELD 16
        PROC_CALL rlUnknown9E99F7
        PROC_YIELD 4
        PROC_CALL rlUnknown9E9D3B
        PROC_YIELD 4
        PROC_CALL rlUnknown9E9D76
        PROC_YIELD 4
        PROC_CALL rlCreateMapBattleAttackerSprites
        PROC_YIELD 2
        PROC_YIELD 1
        PROC_SET_ONCYCLE rlUnknown9EC9FD
        PROC_YIELD 8
        PROC_CALL rlUploadMapMagicBackgroundTiles
        PROC_YIELD 4
        PROC_CALL rlUploadMapMagicBackgroundTilemap
        PROC_YIELD 2
        PROC_CALL rlCopyMapMagicBackgroundColors
        PROC_YIELD 2
        _9C2F
        PROC_YIELD 8
        PROC_CALL rlUnknown9E9E10
        PROC_YIELD 1
        PROC_SET_ONCYCLE rlProcUnknown9E9A43Cycle4
        _9C3C
        PROC_YIELD 1
        PROC_JUMP_IF_BITS_UNSET _9C3C, $0002
        PROC_YIELD 1
        PROC_JUMP_IF_BITS_UNSET _9C2F, $0001
        PROC_YIELD 1
        PROC_JUMP_IF_BITS_UNSET _9C54, $0004
        _9C54
        PROC_CALL rlUnknown9E9F66
        PROC_YIELD 2
        PROC_CALL rlUnknown9E9F26
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

      rlUnknown9E9C70 ; 9E/9C70

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
        jsl rlUnknown9F9217
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

      rlUnknown9E9C94 ; 9E/9C94

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
        lda #$9BE0
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

      rlProcUnknown9E9A43Cycle1 ; 9E/9CB9

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
        lda #(`gcUnknownACCC17)<<8
        sta lR18+1
        lda #<>gcUnknownACCC17
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
        lda #<>rlUnknown9E9BE0
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 9E/9D3B

    .endsection Unsorted9E9CB9Section


    .section Unsorted9E9D3BSection

      .al
      .xl

      rlUnknown9E9D3B ; 9E/9D3B

        .al
        .autsiz
        .databank ?

        phx
        lda #(`gcUnknownD676F6)<<8
        sta lR18+1
        lda #<>gcUnknownD676F6
        sta lR18
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        clc
        adc #$2000
        sta lR19
        jsl rlAppendDecompList

        lda #(`gcUnknownD677E9)<<8
        sta lR18+1
        lda #<>gcUnknownD677E9
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

      rlUnknown9E9D76 ; 9E/9D76

        .al
        .xl
        .autsiz
        .databank ?

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
        lda aUnknown9E9DB9,x
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

      aUnknown9E9DB9 ; 9E/9DB9

        ; Read by rlUnknown9E9D76.

        .word $3800, $7FFF, $035F, $01BF, $0037, $0C8A, $0425, $7FBA
        .word $7E6E, $7C84, $30C4, $1421, $0000, $0000, $0000, $0000

        ; 9E/9DD9

    .endsection Table9E9DB9Section


    .section Unsorted9E9DD9Section

      .al
      .xl

      rlProcUnknown9E9A43Cycle2 ; 9E/9DD9

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
        jsl rlUnknown9E88CE
        jsl rlSelectMapBattleAttackerSprite
        lda #$0000
        jsl rlMapBattleQueueSpriteData
        plx
        ply
        lda #<>rlUnknown9E9BE0
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 9E/9E10

      rlUnknown9E9E10 ; 9E/9E10

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
        sta @l $000F37,x
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

      rlUnknown9E9E61 ; 9E/9E61

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
        jsl rlUnknown9E8D25
        lda #(`aMapBattleDefenderSpriteInfo)<<8
        sta lR44+1
        lda #<>aMapBattleDefenderSpriteInfo
        sta lR44
        lda #<>aMapBattleDefenderSpriteInfo
        ldx wR0
        ldy wR1
        jsl rlActiveSpriteEngineCreateSpriteLowestSlot
        ldx aActiveSpriteSystem.wOffset,b
        txa
        sta aMapAction.wMapBattleDefenderSpriteSlot
        lda #$0001
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        sta aActiveSpriteSystem.aUnknown001320,b,x
        lda #$0006
        sta aActiveSpriteSystem.aUnknown0012A0,b,x
        lda #$0040
        sta aActiveSpriteSystem.aUnknown001260,b,x
        sta aActiveSpriteSystem.aUnknown001280,b,x
        plx
        ply
        rtl

        .databank 0

        ; 9E/9ECF

    .endsection Unsorted9E9E61Section


    .section Unreferenced9E9ECFSection

      .al
      .xl

      rlUnknown9E9ECF ; 9E/9ECF

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
        jsl rlUnknown9E8D25
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

      rlUnknown9E9F13 ; 9E/9F13

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
        jsl rlUnknown9E8D25

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
        PROC_SET_ONCYCLE rlUnknown9EAD7B
        PROC_HALT

        ; AD7B

    .endsection Unsorted9EACAFSection


    .section Unsorted9EAD7BSection

      .al
      .xl

      rlUnknown9EAD7B ; 9E/AD7B

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$CE9E
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
        jsl rlUnknown9EAC1D

        _ADA6
        phb
        jsl rlLoadMapSpriteOAMPalettes
        plb
        .databank ?
        plx
        lda #<>rlUnknown9EADB4
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 9E/ADB4

    .endsection Unsorted9EAD7BSection


    .section Unsorted9EADB4Section

      .al
      .xl

      rlUnknown9EADB4 ; 9E/ADB4

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
        lda @l $0010B7,x
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

        .structProcInfo "ON", rlProcReturnHomeInit, rlUnknown9ED2B5, aProcReturnHomeCode

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
        lda #$001F
        sta <>wMapMagicEffect,b
        plb
        .databank ?
        lda aMapAction.wAttackerYTile
        tay
        lda aMapAction.wAttackerXTile
        tax
        jsl rlUnknown9E8D25
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
        lda #$8100
        sta @l $0015E5
        lda #$841B
        sta @l $0015E4
        lda @l aActiveSpriteSystem
        sta wMapBattleSavedSpriteEngineFlag
        lda @l aActiveSpriteSystem
        ora #$4000
        sta @l aActiveSpriteSystem
        plx
        lda @l $000302
        sta @l $0010B7,x
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

        ; On-cycle: once wMapMagicStart is set, moves on to rlUnknown9ED1BB; clears the active sprite sync flag.

        lda wMapMagicStart
        beq _D1AD
        lda #<>rlUnknown9ED1BB
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

      rlUnknown9ED1BB ; 9E/D1BB

        .al
        .xl
        .autsiz
        .databank ?

        lda wMapMagicDone
        beq _D1D0
        lda #<>rlUnknown9ED1DE
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

      rlUnknown9ED1DE ; 9E/D1DE

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #<>rlUnknown9ED1F3
        sta aProcSystem.aHeaderOnCycle,b,x
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0002
        ora #$0001
        sta aProcSystem.aHeaderBitfield,b,x
        plx
        rtl

        .databank 0

        ; 9E/D1F3

      rlUnknown9ED1F3 ; 9E/D1F3

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
        PROC_SET_ONCYCLE rlUnknown9ED337
        PROC_YIELD 56
        PROC_CALL rlUnknown9E99F7
        PROC_YIELD 4
        PROC_CALL rlUnknown9E9D3B
        PROC_YIELD 4
        PROC_CALL rlUnknown9E9D76
        PROC_YIELD 4
        PROC_CALL rlCreateMapBattleAttackerSprites
        PROC_CALL rlUnknown9ED401
        PROC_YIELD 2
        PROC_SET_ONCYCLE rlUnknown9EC9FD
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
        PROC_CALL rlUnknown9ED372
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
        PROC_CALL rlUnknown9ED3C1
        PROC_CALL rlLoadCursorSpriteGraphics
        PROC_YIELD 4
        PROC_CALL rlLoadMapSpriteOAMPalettes
        PROC_YIELD 1
        PROC_CALL rlUnknown9ED71E
        PROC_END


        ; 9E/D2B5

    .endsection Unsorted9ED1F4Section


    .section Unsorted9ED2B5Section

      .al
      .xl

      rlUnknown9ED2B5 ; 9E/D2B5

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
        lda #(`gcUnknownACCC17)<<8
        sta lR18+1
        lda #<>gcUnknownACCC17
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
        lda #<>rlUnknown9ED1F3
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 9E/D337

    .endsection Unsorted9ED2B5Section


    .section Unsorted9ED337Section

      .al
      .xl

      rlUnknown9ED337 ; 9E/D337

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
        jsl rlUnknown9E88CE
        jsl rlSelectMapBattleAttackerSprite
        lda #0
        jsl rlMapBattleQueueSpriteData
        plx
        lda #<>rlUnknown9ED1F3
        sta aProcSystem.aHeaderOnCycle,b,x
        ply
        rtl

        .databank 0

        ; 9E/D372

    .endsection Unsorted9ED337Section


    .section Unsorted9ED372Section

      .al
      .xl

      rlUnknown9ED372 ; 9E/D372

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
        sta @l $000F37,x
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

      rlUnknown9ED3C1 ; 9E/D3C1

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
        sta $15E5,b
        lda #<>rlPushToOAMBuffer
        sta $15E4,b
        lda wMapBattleSavedSpriteEngineFlag
        sta aActiveSpriteSystem,b
        rtl

        .databank 0

        ; 9E/D401

    .endsection Unsorted9ED3C1Section


    .section Unsorted9ED401Section

      .al
      .xl

      rlUnknown9ED401 ; 9E/D401

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

      rlUnknown9ED412 ; 9E/D412

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

      procHolyWeaponShine .structProcInfo "ON", rlProcHolyWeaponShineInit, rlProcUnknown9ED441Cycle1, aProcHolyWeaponShineCode ; 9E/D441

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
        sta $4C11,b
        sta $4C13,b

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
        sta $454E,b
        lda aActionStructUnit1.XPosition
        sta $4552,b
        lda aActionStructUnit1.YPosition
        sta $4554,b

        lda #$FFFF
        jsl rlGetClassMapBattleWeaponType
        sta $454A,b

        lda #$FFFF
        sta aActionStructUnit1.WeaponID

        lda #0
        sta $4550,b
        sta $4556,b
        sta $4558,b
        sta $454C,b

        lda #$FFFF
        sta aActionStructUnit2.DeploymentNumber

        lda #6
        sta $455E,b
        sta $4560,b

        lda #0
        sta $508F,b
        sta $459E,b
        sta $7E4F85

        lda #5
        sta $4BF3,b

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

      rlUnknown9ED528 ; 9E/D528

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsl rlUnknown9ED72A
        lda #$D535
        sta aProcSystem.aHeaderOnCycle,b,x
        plx
        rtl

        .databank 0

        ; 9E/D535

    .endsection Unreferenced9ED528Section
    .section Unsorted9ED535Section

      .al
      .xl

      rlProcUnknown9ED441Cycle2 ; 9E/D535

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

        PROC_SET_ONCYCLE rlProcUnknown9ED441Cycle3
        PROC_YIELD 40
        PROC_CALL rlUnknown9E99F7
        PROC_YIELD 4
        PROC_CALL rlUnknown9E9D3B
        PROC_YIELD 4
        PROC_CALL rlUnknown9E9D76
        PROC_YIELD 4
        PROC_CALL rlCreateMapBattleAttackerSprites
        PROC_YIELD 2
        PROC_CALL rlUnknown9ED6BA
        PROC_YIELD 1
        PROC_CALL rlUnknown9EA9B5
        PROC_SET_UNK_TIMER 96

        -
        PROC_YIELD 1
        PROC_CALL rlBattleSceneRunPaletteEffects
        PROC_JUMP_WHILE_UNK_TIMER -

        PROC_CALL rlUnknown9EAB21
        PROC_YIELD 16
        PROC_CALL rlUnknown9ED6D6
        PROC_CALL rlLoadCursorSpriteGraphics
        PROC_YIELD 4
        PROC_CALL rlLoadMapSpriteOAMPalettes
        PROC_YIELD 1
        PROC_CALL rlUnknown9ED71E
        PROC_END

      rlSetHolyWeaponShineUnit ; 9E/D5A1

        .al
        .autsiz
        .databank ?

        phx
        lda wEventUnitSlot1ID,b
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

      rlProcUnknown9ED441Cycle1 ; 9E/D609

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

        lda #(`gcUnknownACCC17)<<8
        sta lR18+1
        lda #<>gcUnknownACCC17
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
        lda #<>rlProcUnknown9ED441Cycle2
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

    .endsection Unsorted9ED609Section


    .section Unsorted9ED68BSection

      .al
      .xl

      rlProcUnknown9ED441Cycle3 ; 9E/D68B

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
        jsl rlUnknown9E88CE
        jsl rlSelectMapBattleAttackerSprite
        lda #0
        jsl rlMapBattleQueueSpriteData
        plx
        lda #<>rlProcUnknown9ED441Cycle2
        sta aProcSystem.aHeaderOnCycle,b,x
        ply
        rtl

        .databank 0

        ; 9E/D6BA

    .endsection Unsorted9ED68BSection


    .section Unsorted9ED6BASection

      .al
      .xl

      rlUnknown9ED6BA ; 9E/D6BA

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
        sta @l $000F37,x
        plx
        ply
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 9E/D6D6

      rlUnknown9ED6D6 ; 9E/D6D6

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
        sta $15E5,b
        lda #<>rlPushToOAMBuffer
        sta $15E4,b
        rtl

        .databank 0

        ; 9E/D71E

      rlUnknown9ED71E ; 9E/D71E

        .al
        .xl
        .autsiz
        .databank ?

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

      rlUnknown9ED72A ; 9E/D72A

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

        .structProcInfo "ON", rlProcGiveGoldInit, rlProcUnknown9EDAF6Cycle1, aProcGiveGoldCode

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
        sta @l $000F37,x
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
        sta $454A,b
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
        lda #$8100
        sta @l $0015E5
        lda #$841B
        sta @l $0015E4
        plx
        lda @l $000302
        sta @l $0010B7,x
        stz wGameStateRoutine1,b
        jsl rlPauseMapSpriteAnimation
        jsl rlPauseMapTileAnimation
        ply
        rtl

        .databank 0

        ; 9E/DC09

      rlProcUnknown9EDAF6Cycle1 ; 9E/DC09

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown9E88F9
        lda #<>rlUnknown9EC79B
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 9E/DC14

      rlUnknown9EDC14 ; 9E/DC14

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
        PROC_SET_ONCYCLE rlProcUnknown9EDAF6Cycle2
        PROC_YIELD 32
        PROC_CALL rlUnknown9E99F7
        PROC_YIELD 2
        PROC_CALL rlCreateMapBattleAttackerSprites
        PROC_YIELD 2
        PROC_CALL rlCreateMapBattleDefenderSprites
        PROC_YIELD 2
        PROC_CALL rlUnknown9EDD14
        PROC_YIELD 32
        PROC_CALL rlUnknown9EDD97
        PROC_YIELD 4
        PROC_CALL rlUnknown9EDDE8
        _DC4D
        PROC_YIELD 1
        PROC_CALL rlUnknown9EDE60
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
        PROC_CALL rlUnknown9EDD20
        PROC_SET_ONCYCLE rlUnknown9EAD7B
        PROC_HALT


        ; 9E/DCD2

    .endsection ProcScript9EDC15Section


    .section Unsorted9EDCD2Section

      .al
      .xl

      rlProcUnknown9EDAF6Cycle2 ; 9E/DCD2

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
        jsl rlUnknown9E88CE
        jsl rlSelectMapBattleAttackerSprite
        lda #$0000
        jsl rlMapBattleQueueSpriteData
        jsl rlSelectMapBattleDefenderSprite
        lda #$0001
        jsl rlMapBattleQueueSpriteData
        plx
        lda #<>rlUnknown9EDC14
        sta aProcSystem.aHeaderOnCycle,b,x
        ply
        rtl

        .databank 0

        ; 9E/DD14

      rlUnknown9EDD14 ; 9E/DD14

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta aMapAction.wMapBattleRoundRunning
        sta @l $000F37,x
        rtl

        .databank 0

        ; 9E/DD20

      rlUnknown9EDD20 ; 9E/DD20

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
        sta $15E5,b
        lda #<>rlPushToOAMBuffer
        sta $15E4,b
        stz wBufferBG3VOFS
        plx
        rtl

        .databank 0

        ; 9E/DD97

      rlUnknown9EDD97 ; 9E/DD97

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #(`g4bppUnknownAFC400)<<8
        sta lR18+1
        lda #<>g4bppUnknownAFC400
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
        lda aUnknown9EDDC8,x
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

      aUnknown9EDDC8 ; 9E/DDC8

        ; Read by rlUnknown9EDD97.

        .word $3800, $7FFF, $035F, $01BF, $0037, $0C8A, $0425, $7FBA
        .word $7E6E, $7C84, $30C4, $1421, $0000, $0000, $0000, $0000

        ; 9E/DDE8

    .endsection Table9EDDC8Section


    .section Unsorted9EDDE8Section

      .al
      .xl

      rlUnknown9EDDE8 ; 9E/DDE8

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
        lda #(`aUnknown9EDE89)<<8
        sta aMapAction.lAttackerSpriteData+1
        lda #<>aUnknown9EDE89
        sta aMapAction.lAttackerSpriteData
        lda aMapAction.wDefenderYTile
        tay
        lda aMapAction.wDefenderXTile
        tax
        lda aActionStructUnit2.UnitRAMPointer
        jsl rlUnknown9E8D25
        lda #(`aUnknown9EDF78)<<8
        sta lR44+1
        lda #<>aUnknown9EDF78
        sta lR44
        ldx wR0
        lda wR1
        clc
        adc #$0002
        tay
        lda #$DF78
        jsl rlActiveSpriteEngineCreateSpriteLowestSlot
        ldx aActiveSpriteSystem.wOffset,b
        txa
        sta @l $001097
        lda #$0000
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        lda #$0000
        sta aActiveSpriteSystem.aUnknown001320,b,x
        lda #$0006
        sta aActiveSpriteSystem.aUnknown0012A0,b,x
        lda #$0000
        sta aActiveSpriteSystem.aUnknown001260,b,x
        sta aActiveSpriteSystem.aUnknown001280,b,x
        plx
        ply
        rtl

        .databank 0

        ; 9E/DE60

      rlUnknown9EDE60 ; 9E/DE60

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

      aUnknown9EDE89 ; 9E/DE89

        .word _DE89_Table - aUnknown9EDE89
        .word _DE89_Script - aUnknown9EDE89

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
          .word _DE89_Frame00 - aUnknown9EDE89
          .word _DE89_Frame01 - aUnknown9EDE89
          .word _DE89_Frame02 - aUnknown9EDE89
          .word _DE89_Frame03 - aUnknown9EDE89
          .word _DE89_Frame04 - aUnknown9EDE89
          .word _DE89_Frame05 - aUnknown9EDE89
          .word _DE89_Frame06 - aUnknown9EDE89
          .word _DE89_Frame07 - aUnknown9EDE89
          .word _DE89_Frame08 - aUnknown9EDE89
          .word _DE89_Frame09 - aUnknown9EDE89
          .word _DE89_Frame10 - aUnknown9EDE89

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

      aUnknown9EDF78 ; 9E/DF78
        .word <>rlUnknown9EDF7E, <>rlUnknown9EDF7E, <>aUnknown9EDE89._DE89_Script

      rlUnknown9EDF7E ; 9E/DF7E
        rtl

    .endsection Data9EDE89Section


