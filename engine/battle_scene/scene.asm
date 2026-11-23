; The battle scene's frame: game states $18/$19 (rlBattleSceneSetup, rlBattleSceneStep),
; rlBattleSceneInit (called by rsOpenBattleScene), rsBattleSceneRunFrame, the
; scene's flags (wBattleSceneFlags), the fade (bBattleSceneFade), the copies queued
; for VBlank, the intro and end steps (bBattleSceneStep) and the arena's bouts.

    .section BattleSceneGameStateSection

      .al
      .xl

      rlBattleSceneSetup ; 95/E5C9

        .al
        .xl
        .autsiz
        .databank ?

        ; Game state routine $18, once: blanks the screen and moves on to $19 at step 0. Selected by rsOpenBattleScene.

        sep #$20
        lda #$80
        sta $2100,b
        sta bBufferINIDISP
        rep #$20
        inc wGameStateRoutine1,b
        stz wGameStateStep,b
        rtl

        .databank 0

        ; 95/E5DB

      rlBattleSceneStep ; 95/E5DB

        .al
        .xl
        .autsiz
        .databank ?

        ; Game state routine $19, every frame: unblanks, enables NMI, runs rsBattleSceneRunFrame; when that returns carry set (the scene is over), picks where to go next from wBattleSceneFlags and wBattleType: the map (wMainGameMode 2 or 3), the castle after the arena, the castle screen, or game state 0.

        sep #$20
        lda #$00
        sta $2100,b
        sta bBufferINIDISP
        rep #$20
        sep #$20
        lda bBufferNMITIMEN
        ora #$01
        sta $4200,b
        sta bBufferNMITIMEN
        rep #$20
        jsr rsBattleSceneRunFrame
        bcs _E5FC
        jml _E69D


        _E5FC
        lda wBattleSceneFlags
        bit #BattleSceneFlagToMapMode3
        beq _E616
        jsl rlBattleSceneForceBlank
        lda #$0003
        sta wMainGameMode,b
        lda #<>rsUnknown80B122
        sta wMainLoopPointer
        bra _E68B


        _E616
        lda wBattleType
        and #$00FF
        cmp #$0000
        bne _E633
        jsl rlBattleSceneForceBlank
        lda #$0002
        sta wMainGameMode,b
        lda #<>rsUnknown80B122
        sta wMainLoopPointer
        bra _E68B


        _E633
        cmp #$0001
        bne _E642
        jsl rlBattleSceneForceBlank
        jsl rlReturnToCastleFromArena
        bra _E68B


        _E642
        cmp #$0002
        bne _E658
        jsl rlBattleSceneForceBlank
        lda #CASTLE_SCREEN_RELOAD_MAP
        sta wCastleScreenHandler,b
        lda #<>rsOpenCastleScreen
        sta wMainLoopPointer
        bra _E68B


        _E658
        cmp #$0003
        bne _E66E
        jsl rlBattleSceneForceBlank
        lda #CASTLE_SCREEN_RELOAD_MAP
        sta wCastleScreenHandler,b
        lda #<>rsOpenCastleScreen
        sta wMainLoopPointer
        bra _E68B


        _E66E
        cmp #$00FF
        bne _E67C
        jsl rlBattleSceneForceBlank
        stz wGameStateRoutine1,b
        bra _E69D


        _E67C
        jsl rlBattleSceneForceBlank
        lda #$0002
        sta wMainGameMode,b
        lda #<>rsUnknown80B122
        sta wMainLoopPointer

        _E68B
        jsl rlResetHDMAEngine
        lda bUnknown000E7B,b
        bit #$0001
        beq _E69D
        lda #$0001
        trb bUnknown000E7B,b

        _E69D
        rtl

        .databank 0

        ; 95/E69E

    .endsection BattleSceneGameStateSection


    .section Unsorted958000Section

      .al
      .xl

      rlBattleSceneInit ; 95/8000

        .al
        .xl
        .autsiz
        .databank ?

        ; Called once by rsOpenBattleScene: sets the PPU, copies the combatants from the action structs, loads background, combatants and weapons, places the combatants, and resets the scene's engines.

        jsl rlUnknown9695F5
        jsr rsBattleSceneSetPPURegisters
        jsl rlBattleSceneSetFlags
        jsr rsBattleSceneCopyCombatants
        jsl rlBattleSceneCopyExperience
        jsr rsBattleSceneResetState
        jsl rlBattleSceneSetHPBarY
        jsl rlBattleSceneStopGauge
        jsr rsBattleSceneLoadBackground
        jsr rsBattleSceneLoadCombatantGraphics
        jsr rsBattleScenePlaceCombatants
        jsl rlBattleAnimationRunMoveQueue
        jsl rlBattleAnimationRunMoveQueue
        jsl rlUnknown968DBD
        jsl rlUnknown968E7E
        jsl rlBattleSceneClearScriptRoutine
        jsl rlFreeBattleScenePaletteSlots
        jsl rlBattleSceneLoadHUD
        jsl rlUnknown96D67B
        jsl rlBattleSceneDimPalettesForType2
        jsl rlBattleSceneBuildWhiteFadePalettes
        jsl rlUnknown969EBB
        rtl

        .databank 0

        ; 95/8053

      rsBattleSceneSetPPURegisters ; 95/8053

        .al
        .xl
        .autsiz
        .databank ?

        ; Mode 1 with BG3 priority, the scene's tilemap and tile bases, scroll 0, window 1 open, BG2 and sprites on the main screen.

        sep #$20
        lda #$09
        sta bBufferBGMODE
        sta $2105,b
        lda #$00
        sta bBufferMOSAIC
        sta $2106,b
        lda #$39
        sta bBufferBG1SC
        sta $2107,b
        lda #$61
        sta bBufferBG2SC
        sta $2108,b
        lda #$71
        sta bBufferBG3SC
        sta $2109,b
        lda #$02
        sta bBufferBG12NBA
        sta $210B,b
        lda #$77
        sta bBufferBG34NBA
        sta $210C,b
        lda #$00
        sta wBufferBG1HOFS
        sta $210D,b
        sta wBufferBG1VOFS
        sta $210E,b
        sta wBufferBG2HOFS
        sta $210F,b
        sta wBufferBG2VOFS
        sta $2110,b
        sta wBufferBG3HOFS
        sta $2111,b
        sta wBufferBG3VOFS
        sta $2112,b
        sta bBufferWH0
        sta $2126,b
        lda #$FF
        sta bBufferWH1
        sta $2127,b
        lda #$00
        sta bBufferWH2
        sta $2128,b
        lda #$FF
        sta bBufferWH3
        sta $2129,b
        lda #$00
        sta bBufferTMW
        sta $212E,b
        sta bBufferTSW
        sta $212F,b
        lda #$12
        sta bBufferTM
        sta $212C,b
        lda #$02
        sta bBufferOBSEL
        sta $2101,b
        lda #$00
        sta bBufferCGADSUB
        lda #$8F
        sta bBattleSceneLetterboxINIDISP,b
        rep #$20
        rts

        .databank 0

        ; 95/80E6

      rsBattleSceneResetState ; 95/80E6

        .al
        .xl
        .autsiz
        .databank ?

        ; Clears the scene's flags and counters, points lBattleSceneRoundPointer at the first entry of aBattleRoundsData, and resets each engine.

        stz wBattleSceneUploadTotal,b
        stz $0D3E,b
        lda #$0000
        sta bBattleSceneCameraXFraction
        lda #$0100
        sta wBattleSceneCameraX
        stz aBattleSceneCombatant2.HPSpeed,b
        stz aBattleSceneCombatant2.HPSpeed,b
        lda #$0000
        sta wBattleSceneFrame
        sta $7FE1B4
        sep #$20
        sta bBattleSceneCameraPan
        sta $7FE186
        sta $7FF5AF
        sta $7FFC77
        sta $7FFC9C
        sta $7FFC70
        sta $7FFC71
        sta $7FE191
        sta $7FE193
        sta bBattleSceneDamageFlash1
        sta bBattleSceneDamageFlash2
        sta bBufferCOLDATA_0
        sta bBufferCOLDATA_1
        sta bBufferCOLDATA_2
        sta bBufferCOLDATA_3
        sta $7FE4C2
        sta $7FE4C3
        sta $7FE4DB
        lda $7FE1B3
        ora #$08
        and #$FB
        sta $7FE1B3
        lda #$10
        sta $7FFC6F
        lda #$E0
        sta $7FE3EE
        sta $7FE3ED
        sta $7FE3EC
        lda #$03
        sta bBattleSceneStep
        stz bBattleSceneRoundState,b
        stz bBattleSceneStrikeFlags,b
        stz bBattleSceneUploadCount,b
        stz aBattleSceneAfterimages.Flags,b
        stz Flags,b
        rep #$20
        jsl rlUnknown95A43C
        jsl rlUnknown96DD39
        jsl rlUnknown96EB02
        jsl rlUnknown96EBC9
        jsl rlBattleSceneResetArenaBreak
        jsl rlBattleSceneClearMagicSwordFlags
        jsl rlBattleSceneResetSkillState
        jsl rlBattleSceneStopHUDShake
        lda #$0202
        sta $7FE1F0
        lda #$1212
        sta $7FE1F2
        lda #$0606
        sta $7FE1F4
        lda #$0080
        eor #$FFFF
        inc a
        and #$00FF
        sta $7FE1C8
        lda #(`aBattleRoundsData._Entry[0])<<8
        sta lBattleSceneRoundPointer+1,b
        lda #<>aBattleRoundsData._Entry[0]
        sta lBattleSceneRoundPointer,b
        jsl rlBattleSceneClearKnockback
        jsl rlBattleAnimationClearMoveQueues
        jsl rlUnknown96A4FC
        jsl rlUnknown96CB0A
        jsl rlUnknown96EE8A
        jsl rlResetBattleSceneScript
        jsl rlBattleSceneScriptClearLoading
        jsl rlUnknown96BD74
        jsl rlBattleSceneSetAnimStyles
        jsl rlBattleSceneLookUpAnimations
        jsl rlBattleAnimationSetBodyIndices
        jsl rlUnknown96957D
        jsl rlUnknown95A414
        jsl rlUnknown95A428
        rts

        .databank 0

        ; 95/820C

      rsBattleSceneCopyCombatants ; 95/820C

        .al
        .xl
        .autsiz
        .databank ?

        ; Fills aBattleSceneCombatant1 and 2 (class, character, weapon, HP, gender) from aActionStructUnit1 and 2, the initiator's and the target's terrains, and the battle distance.

        lda aActionStructUnit1.ClassID
        sta aBattleSceneCombatant1.Class,b
        lda aActionStructUnit2.ClassID
        sta aBattleSceneCombatant2.Class,b
        lda aActionStructUnit1.CharacterID
        sta aBattleSceneCombatant1.Character,b
        lda aActionStructUnit2.CharacterID
        sta aBattleSceneCombatant2.Character,b
        lda aActionStructUnit1.WeaponID
        sta aBattleSceneCombatant1.Weapon,b
        lda aActionStructUnit2.WeaponID
        sta aBattleSceneCombatant2.Weapon,b
        lda aBattleSceneCombatant1.Class,b
        sta wR0
        lda aActionStructUnit1.Gender
        and #$00FF
        jsl rlBattleSceneGetGender
        sep #$20
        sta aBattleSceneCombatant1.Gender,b
        rep #$20
        lda aBattleSceneCombatant2.Class,b
        sta wR0
        lda aActionStructUnit2.Gender
        and #$00FF
        jsl rlBattleSceneGetGender
        sep #$20
        sta aBattleSceneCombatant2.Gender,b
        lda aActionStructUnit1.CurrentHP
        sta aBattleSceneCombatant1.HP+1,b
        stz aBattleSceneCombatant1.HP,b
        lda aActionStructUnit2.CurrentHP
        sta aBattleSceneCombatant2.HP+1,b
        stz aBattleSceneCombatant2.HP,b
        lda aActionStructUnit1.MaxHP
        sta aBattleSceneCombatant1.MaxHP,b
        lda aActionStructUnit2.MaxHP
        sta aBattleSceneCombatant2.MaxHP,b
        rep #$20
        lda wBattleStatus
        and #$0001
        beq _829C
        lda aActionStructUnit1.TerrainType
        sta wBattleSceneDefenderTerrain,b
        lda aActionStructUnit2.TerrainType
        bra _82A7


        _829C
        lda aActionStructUnit2.TerrainType
        sta wBattleSceneDefenderTerrain,b
        lda aActionStructUnit1.TerrainType

        _82A7
        sta wBattleSceneAttackerTerrain,b
        lda wBattleDistance
        sep #$20
        sta bBattleSceneDistance,b
        rep #$20
        lda wBattleSceneFlags
        bit #BattleSceneFlagBattleType2
        beq _82D7
        lda #$0000
        sta aActionStructUnit1.ObtainedStealMoney
        lda #$FFFF
        sta aActionStructUnit1.ObtainedItem
        lda #$0000
        sta wBattleQuotePointer
        sta wDeathQuotePointer

        _82D7
        rts

        .databank 0

        ; 95/82D8

    .endsection Unsorted958000Section


    .section Unsorted958B07Section

      .al
      .xl

      rsBattleSceneRunFrame ; 95/8B07

        .al
        .xl
        .autsiz
        .databank ?

        ; The battle scene's work for one frame, in order: the rounds, the combatants' moves and movement, the effects, the script, HUD and palettes; then waits for VBlank and does the rest. Returns carry set when the scene has faded out (bBattleSceneFade).

        jsl rlBattleSceneRunIntroStep
        jsl rlBattleSceneCheckIntroDone
        jsr rsBattleSceneBuildBrightnessTable
        jsr rsBattleSceneReleaseHold
        jsl rlBattleSceneUpdateFade
        lda $7FFC77
        bit #$0001
        beq _8B26
        jml _8B85


        _8B26
        lda bBattleSceneRoundState,b
        bit #BattleSceneRoundMayRun
        beq _8B36
        jsl rlBattleAnimationRunMoveQueue
        jsl rlBattleSceneRunRounds

        _8B36
        jsl rlUnknown96F7D4
        jsr rsBattleSceneTurnCombatants
        ldx #$0000
        jsl rlBattleAnimationUpdateX
        jsl rlBattleAnimationApplyDefaultGravity
        jsl rlBattleAnimationUpdateJump
        jsl rlBattleAnimationUpdateYStep
        ldx #$0043
        jsl rlBattleAnimationUpdateX
        jsl rlBattleAnimationApplyDefaultGravity
        jsl rlBattleAnimationUpdateJump
        jsl rlBattleAnimationUpdateYStep
        ldx #$0086
        jsl rlBattleAnimationMoveEffectSlot
        jsl rlBattleAnimationApplyEffectGravity
        jsl rlBattleAnimationApplyEffectYStep
        ldx #$00C9
        jsl rlBattleAnimationMoveEffectSlot
        jsl rlBattleAnimationApplyEffectGravity
        jsl rlBattleAnimationApplyEffectYStep
        jsl rlBattleSceneRunKnockback

        _8B85
        jsl rlBattleSceneTrackCombatantSides
        jsl rlUnknown96A0E2
        jsl rlBattleAnimationRunSignals
        jsl rlRunBattleSceneScript
        jsl rlUnknown96CB44
        jsl rlBattleSceneScriptUpdateLoading
        jsl rlBattleSceneBuildColorHDMATable
        jsl rlUnknown96EBE3
        jsr rsBattleSceneUpdateStageScroll
        jsr rsBattleSceneUpdateBG1Scroll
        jsl rlUnknown96DE6F
        jsl rlUnknown96A532
        jsl rlUnknown96DD6E
        jsl rlBattleSceneRunCameraPan
        jsl rlUnknown96BE28
        jsl rlBattleAnimationUpdateAll
        jsl rlUnknown96A05C
        jsl rlBattleSceneDrawAfterimages
        jsr rsBattleSceneDrawShadows
        jsr rsBattleSceneUpdateHP1
        jsr rsBattleSceneUpdateHP2
        jsl rlBattleSceneRunPaletteEffects
        jsl rlUnknown95C508
        jsl rlBattleSceneRunLargeUpload
        jsl rlUnknown96C8A1
        jsr rsUnknown959CF8
        jsl rlBattleSceneRunHUDShake
        jsl rlBattleSceneQueueHPUpload

        _8BEF
        lda $7FE1CF
        and #$00FF
        beq _8BEF
        jsr rsUnknown9590F2
        jsr rsUnknown959210
        jsr rsUnknown959197
        jsl rlBattleSceneRunQueuedCopies
        jsl rlUnknown96EE95
        jsl rlBattleSceneReadArenaRetreat
        jsr rsUnknown959C64
        jsr rsBattleSceneCheckRoundsOver
        jsl rlBattleSceneCheckArenaBout
        jsl rlBattleSceneRunEndStep
        bcc _8C22
        jsr rsBattleSceneCheckNotHeld
        bcc _8C22

        _8C22
        lda bBattleSceneFade
        and #$00CF
        cmp #$0040
        bne _8C31
        sec
        bra _8C32


        _8C31
        clc

        _8C32
        php
        lda wBattleSceneFrame
        inc a
        sta wBattleSceneFrame
        plp
        rts

        .databank 0

        ; 95/8C3E

      rlBattleSceneCheckIntroDone ; 95/8C3E

        .al
        .xl
        .autsiz
        .databank ?

        ; Carry set (rlBattleSceneRunIntroStep has no intro step left) and wMusicID 0: sets BattleSceneRoundMayRun, which lets the rounds start.

        bcc _8C51
        lda wMusicID,b
        bne _8C51
        sep #$20
        lda bBattleSceneRoundState,b
        ora #BattleSceneRoundMayRun
        sta bBattleSceneRoundState,b
        rep #$20

        _8C51
        rtl

        .databank 0

        ; 95/8C52

      rsBattleSceneCheckRoundsOver ; 95/8C52

        .al
        .xl
        .autsiz
        .databank ?

        ; Carry set when the last round has been read (BattleSceneRoundAllRead) and both combatants, their HP bars, the effect slots and the skill banner are still.

        phx
        phy
        lda bBattleSceneRoundState,b
        bit #BattleSceneRoundAllRead
        beq _8CA4
        lda wBattleAnimationXSpeed,b
        bit #$7FFF
        bne _8CA4
        lda wBattleAnimationYVelocity,b
        bne _8CA4
        lda bBattleAnimationStateFlags,b
        bit #$0004
        bne _8CA4
        lda aBattleSceneCombatant1.HPSpeed,b
        bne _8CA4
        lda wBattleAnimation2XSpeed,b
        bit #$7FFF
        bne _8CA4
        lda wBattleAnimation2YVelocity,b
        bne _8CA4
        lda bBattleAnimation2StateFlags,b
        bit #$0004
        bne _8CA4
        lda aBattleSceneCombatant2.HPSpeed,b
        bne _8CA4
        lda bBattleSceneKnockback,b
        and #$003F
        bne _8CA4
        lda $7FE4B7
        bit #$0080
        bne _8CA4
        sec
        bra _8CA5


        _8CA4
        clc

        _8CA5
        ply
        plx
        rts

        .databank 0

        ; 95/8CA8

      rsBattleSceneCheckNotHeld ; 95/8CA8

        .al
        .xl
        .autsiz
        .databank ?

        ; Carry set when BattleSceneRoundHeld is clear.

        phx
        phy
        lda bBattleSceneRoundState,b
        bit #BattleSceneRoundHeld
        bne _8CB5
        sec
        bra _8CB6


        _8CB5
        clc

        _8CB6
        ply
        plx
        rts

        .databank 0

        ; 95/8CB9

    .endsection Unsorted958B07Section


    .section Unsorted959C14Section

      .al
      .xl

      rsBattleSceneReleaseHold ; 95/9C14

        .al
        .xl
        .autsiz
        .databank ?

        ; Clears BattleSceneRoundHeld when the countdown at $7FED5A reaches 1, or, with no countdown, when B is pressed.

        pha
        lda $7FED5A
        beq _9C29
        cmp #$0001
        beq _9C30
        lda $7FED5A
        dec a
        sta $7FED5A

        _9C29
        lda wJoy1New
        bit #$8000
        beq _9C3C

        _9C30
        sep #$20
        lda bBattleSceneRoundState,b
        and #$F7
        sta bBattleSceneRoundState,b
        rep #$20

        _9C3C
        pla
        rts

        .databank 0

        ; 95/9C3E

    .endsection Unsorted959C14Section


    .section Unsorted95A086Section

      .al
      .xl

      rlBattleSceneRunQueuedCopies ; 95/A086

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        phy
        ldy #$0008
        ldx #$0000

        _A08F
        lda $7FE441,x
        cmp #$FFFF
        beq _A0BD
        phx
        phy
        pha
        lda $7FE445,x
        tay
        lda $7FE443,x
        tax
        pla
        phb
        .byte $54, $7F, $7F ; mvn from bank $7F to bank $7F
        plb
        .databank ?
        ply
        plx
        lda #$FFFF
        sta $7FE441,x
        txa
        clc
        adc #$0006
        tax
        dec y
        bne _A08F

        _A0BD
        ply
        plx
        pla
        rtl

        .databank 0

        ; 95/A0C1

      rlBattleSceneQueueCopy ; 95/A0C1

        .al
        .xl
        .autsiz
        .databank ?

        ; Queues a copy of A bytes within bank $7F, from wR1 to wR0, done in VBlank by rlBattleSceneRunQueuedCopies; 8 slots, carry set when full.

        phy
        phx
        pha
        ldy #$0008
        ldx #$0000

        _A0CA
        lda $7FE441,x
        cmp #$FFFF
        bne _A0E9
        lda #1,s
        dec a
        sta $7FE441,x
        lda wR0
        sta $7FE445,x
        lda wR1
        sta $7FE443,x
        clc
        bra _A0F3


        _A0E9
        txa
        clc
        adc #$0006
        tax
        dec y
        bne _A0CA
        sec

        _A0F3
        pla
        plx
        ply
        rtl

        .databank 0

        ; 95/A0F7

    .endsection Unsorted95A086Section


    .section Unsorted95A0F7Section

      .al
      .xl

      rlBattleSceneClearQueuedCopies ; 95/A0F7

        .al
        .xl
        .autsiz
        .databank ?

        ; Empties the eight 6-byte entries at $7FE441 that rlBattleSceneRunQueuedCopies works through.

        pha
        phx
        phy
        ldy #$0008
        ldx #$0000

        _A100
        lda #$FFFF
        sta $7FE441,x
        txa
        clc
        adc #$0006
        tax
        dec y
        bne _A100
        ply
        plx
        pla
        rtl

        .databank 0

        ; 95/A114

    .endsection Unsorted95A0F7Section


    .section Unsorted95A481Section

      .al
      .xl

      rlBattleSceneUpdateFade ; 95/A481

        .al
        .xl
        .autsiz
        .databank ?

        ; Steps bBattleSceneFade's brightness (low nibble) every bBattleSceneFadeDelay frames, up (bit 6 clear) or down, until 15 or 0; then clears bit 7.

        lda bBattleSceneFade
        bit #$0080
        bne _A48E
        jml _A52C


        _A48E
        bit #$0040
        bne _A4D2
        lda bBattleSceneFade
        and #$000F
        cmp #$000F
        bcc _A4AF
        sep #$20
        lda bBattleSceneFade
        and #$7F
        sta bBattleSceneFade
        rep #$20
        bra _A52C


        _A4AF
        sep #$20
        lda bBattleSceneFade
        inc a
        pha
        lda bBattleSceneFade
        and #$F0
        ora #1,s
        sta bBattleSceneFade
        pla
        and #$0F
        sta $7FE4DD
        sta $7FE4D5
        rep #$20
        bra _A52C


        _A4D2
        lda bBattleSceneFadeTimer
        and #$00FF
        beq _A4E6
        sep #$20
        dec a
        sta bBattleSceneFadeTimer
        rep #$20
        bra _A52C


        _A4E6
        sep #$20
        lda bBattleSceneFadeDelay
        sta bBattleSceneFadeTimer
        rep #$20
        lda bBattleSceneFade
        and #$000F
        bne _A50B
        sep #$20
        lda bBattleSceneFade
        and #$7F
        sta bBattleSceneFade
        rep #$20
        bra _A52C


        _A50B
        sep #$20
        lda bBattleSceneFade
        dec a
        pha
        lda bBattleSceneFade
        and #$F0
        ora #1,s
        sta bBattleSceneFade
        pla
        and #$0F
        sta $7FE4DD
        sta $7FE4D5
        rep #$20

        _A52C
        rtl

        .databank 0

        ; 95/A52D

      rlBattleSceneForceBlank ; 95/A52D

        .al
        .xl
        .autsiz
        .databank ?

        ; Forced blank: $80 in bBufferINIDISP and its copies $7FE4DD and $7FE4D5.

        sep #$20
        lda #$80
        sta bBufferINIDISP
        sta $7FE4DD
        sta $7FE4D5
        rep #$20
        rtl

        .databank 0

        ; 95/A53E

    .endsection Unsorted95A481Section


    .section Unsorted95A53ESection

      .al
      .xl

      rlBattleSceneSetFlags ; 95/A53E

        .al
        .xl
        .autsiz
        .databank ?

        ; Sets wBattleSceneFlags from the battle: melee, battle type 2, solo, and which side carries a holy weapon or a weapon of aUnknown998F02.

        lda #$0000
        sta wBattleSceneFlags
        lda wBattleDistance
        cmp #$0002
        bcs _A565
        lda wBattleType
        and #$00FF
        cmp #$0002
        beq _A565
        lda wBattleSceneFlags
        ora #BattleSceneFlagMelee
        sta wBattleSceneFlags

        _A565
        lda wBattleType
        and #$00FF
        cmp #$0002
        bne _A57C
        lda wBattleSceneFlags
        ora #BattleSceneFlagBattleType2
        sta wBattleSceneFlags

        _A57C
        lda aActionStructUnit1.Unknown
        cmp #$0008
        bne _A593
        lda wBattleSceneFlags
        ora #BattleSceneFlagDance
        ora #BattleSceneFlagSolo2
        sta wBattleSceneFlags

        _A593
        lda aActionStructUnit1.WeaponID
        jsr rsBattleSceneCheckHolyWeapon
        bcc _A5A7
        lda wBattleSceneFlags
        ora #BattleSceneFlagHolyWeapon1
        sta wBattleSceneFlags

        _A5A7
        lda aActionStructUnit2.WeaponID
        jsr rsBattleSceneCheckHolyWeapon
        bcc _A5BB
        lda wBattleSceneFlags
        ora #BattleSceneFlagHolyWeapon2
        sta wBattleSceneFlags

        _A5BB
        lda aActionStructUnit1.WeaponID
        jsr rsBattleSceneCheckListedWeapon
        bcc _A5CF
        lda wBattleSceneFlags
        ora #BattleSceneFlagListedWeapon1
        sta wBattleSceneFlags

        _A5CF
        lda aActionStructUnit2.WeaponID
        jsr rsBattleSceneCheckListedWeapon
        bcc _A5E3
        lda wBattleSceneFlags
        ora #BattleSceneFlagListedWeapon2
        sta wBattleSceneFlags

        _A5E3
        rtl

        .databank 0

        ; 95/A5E4

      rsBattleSceneCheckHolyWeapon ; 95/A5E4

        .al
        .xl
        .autsiz
        .databank ?

        ; Carry set when A is one of the 13 holy weapons (Tyrfing ... Valkyrie Staff), whose bearer's first round opens with script $43.

        cmp #Tyrfing
        beq _A628
        cmp #Mystletainn
        beq _A628
        cmp #Balmung
        beq _A628
        cmp #Gungnir
        beq _A628
        cmp #GaeBolg
        beq _A628
        cmp #Helswath
        beq _A628
        cmp #Yewfelle
        beq _A628
        cmp #Valflame
        beq _A628
        cmp #Mjolnir
        beq _A628
        cmp #Forseti
        beq _A628
        cmp #Loptous
        beq _A628
        cmp #Naga
        beq _A628
        cmp #ValkyrieStaff
        beq _A628
        clc
        bra _A629


        _A628
        sec

        _A629
        rts

        .databank 0

        ; 95/A62A

      rsBattleSceneCheckListedWeapon ; 95/A62A

        .al
        .xl
        .autsiz
        .databank ?

        ; Carry set when A is in aUnknown998F02 (the silver weapons, blades and holy swords and lances).

        phx
        pha
        ldx #$0000

        _A62F
        lda aUnknown998F02,x
        cmp #$FFFF
        beq _A642
        and #$00FF
        cmp #1,s
        beq _A645
        inc x
        bra _A62F


        _A642
        clc
        bra _A646


        _A645
        sec

        _A646
        pla
        plx
        rts

        .databank 0

        ; 95/A649

      rlBattleSceneSetHPBarY ; 95/A649

        .al
        .xl
        .autsiz
        .databank ?

        ; $7FFC5B: $70 in battle type 2, else $64.

        lda wBattleSceneFlags
        bit #BattleSceneFlagBattleType2
        beq _A657
        lda #$0070
        bra _A65A


        _A657
        lda #$0064

        _A65A
        sta $7FFC5B
        rtl

        .databank 0

        ; 95/A65F

    .endsection Unsorted95A53ESection


    .section Unsorted96941CSection

      .al
      .xl

      rlBattleSceneRunIntroStep ; 96/941C

        .al
        .xl
        .autsiz
        .databank ?

        ; While bBattleSceneStep counts the intro steps (bit 7 clear) and no fade or skill banner runs, takes the next of aBattleSceneIntroSteps. Carry set when none is left.

        lda bBattleSceneStep
        bit #$0080
        bne _947B
        and #$007F
        beq _947B
        lda $7FE4B7
        bit #$0080
        bne _9478
        lda bBattleSceneFade
        bit #$0080
        bne _9478
        lda bBattleSceneStep
        dec a
        sep #$20
        sta bBattleSceneStep
        rep #$20
        and #$007F
        sta wR0
        phb
        jsl _9456
        plb
        .databank ?
        bra _9478


        _9456
        lda wR0
        cmp #$0003
        bmi _945F

        _945D
        bra _945D


        _945F
        asl a
        adc wR0
        tax
        lda aBattleSceneIntroSteps,x
        sta lR23
        sep #$20
        lda aBattleSceneIntroSteps+2,x
        sta lR23+2
        pha
        plb
        .databank ?
        rep #$20
        jml [lR23]


        _9478
        clc
        bra _947C


        _947B
        sec

        _947C
        rtl

        .databank 0

        ; 96/947D

    .endsection Unsorted96941CSection


    .section Unsorted96947DSection

      .al
      .xl

      rlBattleSceneWaitForIntro ; 96/947D

        .al
        .xl
        .autsiz
        .databank ?

        ; Once $7FE4B8 is 0, sets bBattleSceneStep to the 21 end steps and clears bit 3 of $7FE1B3.

        lda $7FE4B7
        lda bBattleSceneScriptWaitCount
        and #$00FF
        bne _94A0
        sep #$20
        lda #$95
        sta bBattleSceneStep
        lda $7FE1B3
        and #$F7
        sta $7FE1B3
        rep #$20
        bra _94AD


        _94A0
        sep #$20
        lda bBattleSceneStep
        inc a
        sta bBattleSceneStep
        rep #$20

        _94AD
        rtl

        .databank 0

        ; 96/94AE

      rlBattleSceneShowBG3 ; 96/94AE

        .al
        .xl
        .autsiz
        .databank ?

        ; The first end step: sets bit 3 of $7FE1B3 and scrolls BG3 to (0, $1FF).

        sep #$20
        lda $7FE1B3
        ora #$08
        sta $7FE1B3
        rep #$20
        lda #$0000
        sta wBufferBG3HOFS
        lda #$01FF
        sta wBufferBG3VOFS
        rtl

        .databank 0

        ; 96/94C7

    .endsection Unsorted96947DSection


    .section Unsorted9694C7Section

      .al
      .xl

      rlBattleSceneRunEndStep ; 96/94C7

        .al
        .xl
        .autsiz
        .databank ?

        ; Carry in set (the rounds are over): runs the next of aBattleSceneEndSteps, last to first, one each time nothing else runs; each may start a battle scene script.

        bcc _952B
        lda bBattleSceneFade
        bit #$0080
        bne _9527
        lda bBattleSceneStep
        bit #$0080
        beq _952A
        and #$007F
        beq _952A
        dec a
        sep #$20
        pha
        ora #$80
        sta bBattleSceneStep
        pla
        rep #$20
        sta wR0
        phb
        jsl _94F7
        plb
        .databank ?
        bra _9519


        _94F7
        lda wR0
        cmp #$0015
        bmi _9500

        _94FE
        bra _94FE


        _9500
        asl a
        adc wR0
        tax
        lda aBattleSceneEndSteps,x
        sta lR23
        sep #$20
        lda aBattleSceneEndSteps+2,x
        sta lR23+2
        pha
        plb
        .databank ?
        rep #$20
        jml [lR23]


        _9519
        sep #$20
        lda $7FE4DB
        ora #$01
        sta $7FE4DB
        rep #$20

        _9527
        clc
        bra _952B


        _952A
        sec

        _952B
        rtl

        .databank 0

        ; 96/952C

      rlBattleSceneBuildColorHDMATable ; 96/952C

        .al
        .xl
        .autsiz
        .databank ?

        ; Every frame: the HDMA table at aMapWindowTextBuffer that writes the fixed color ($7FE3EE, set by the brightening) for $0F and $70 lines, then ends it (rlBattleSceneEndColorHDMATable).

        phx
        ldx #$0000
        lda #$000F
        sta aMapWindowTextBuffer,x
        lda #$E3EE
        sta $7FE3CB,x
        inc x
        inc x
        inc x
        lda #$0070
        sta aMapWindowTextBuffer,x
        lda #$E3EE
        sta $7FE3CB,x
        inc x
        inc x
        inc x
        txa
        sta $7FE3EA
        jsl rlBattleSceneEndColorHDMATable
        plx
        rtl

        .databank 0

        ; 96/955D

      rlBattleSceneEndColorHDMATable ; 96/955D

        .al
        .xl
        .autsiz
        .databank ?

        ; Adds $D0 lines of $7FE3F1 and the end byte at the table's end ($7FE3EA).

        phx
        lda $7FE3EA
        tax
        lda #$00D0
        sta aMapWindowTextBuffer,x
        lda #$E3F1
        sta $7FE3CB,x
        sep #$20
        lda #$00
        sta $7FE3CD,x
        rep #$20
        plx
        rtl

        .databank 0

        ; 96/957D

    .endsection Unsorted9694C7Section


    .section Unsorted969861Section

      .al
      .xl

      rlBattleSceneRestartRounds ; 96/9861

        .al
        .xl
        .autsiz
        .databank ?

        ; Points lBattleSceneRoundPointer back at the first round and copies the experience again, for the next arena bout.

        lda #(`aBattleRoundsData._Entry[0])<<8
        sta lBattleSceneRoundPointer+1,b
        lda #<>aBattleRoundsData._Entry[0]
        sta lBattleSceneRoundPointer,b
        jsl rlBattleSceneCopyExperience
        rtl

        .databank 0

        ; 96/9872

    .endsection Unsorted969861Section


    .section Unsorted969872Section

      .al
      .xl

      rlBattleSceneBuildArenaBout ; 96/9872

        .al
        .xl
        .autsiz
        .databank ?

        ; In the main loop, outside the frame: when bit 0 of bBattleSceneArenaBout asks for the next arena bout, builds its rounds (rlActionStructBuildBattleRounds) and sets bit 2.

        pha
        lda bBattleSceneArenaBout
        bit #$0001
        beq _989C
        sep #$20
        and #$FE
        ora #$02
        sta bBattleSceneArenaBout
        rep #$20
        jsl rlActionStructBuildBattleRounds
        sep #$20
        lda bBattleSceneArenaBout
        and #$FD
        ora #$04
        sta bBattleSceneArenaBout
        rep #$20

        _989C
        pla
        rtl

        .databank 0

        ; 96/989E

    .endsection Unsorted969872Section


    .section Unsorted96989ESection

      .al
      .xl

      rlBattleSceneCheckArenaBout ; 96/989E

        .al
        .xl
        .autsiz
        .databank ?

        ; Carry in set (rounds over): when the arena asks for another bout (BattleSceneRoundArenaNextBout) starts the break between bouts (bBattleSceneArenaBout = 1); while it runs returns carry clear; at its end (bit 2) restarts the rounds. Carry set when the scene may end.

        bcc _98DF
        lda bBattleSceneRoundState,b
        bit #BattleSceneRoundArenaNextBout
        beq _98B7
        sep #$20
        and #~BattleSceneRoundArenaNextBout
        sta bBattleSceneRoundState,b
        lda #$01
        sta bBattleSceneArenaBout
        rep #$20

        _98B7
        lda bBattleSceneArenaBout
        bit #$0003
        bne _98DB
        bit #$0004
        beq _98DE
        sep #$20
        and #$FB
        sta bBattleSceneArenaBout
        lda bBattleSceneRoundState,b
        and #$F9
        sta bBattleSceneRoundState,b
        rep #$20
        jsl rlBattleSceneRestartRounds

        _98DB
        clc
        bra _98DF


        _98DE
        sec

        _98DF
        rtl

        .databank 0

        ; 96/98E0

      rlBattleSceneCheckArenaRetreat ; 96/98E0

        .al
        .xl
        .autsiz
        .databank ?

        ; Carry set when the player has asked to leave the arena (BattleSceneRoundArenaRetreat).

        pha
        lda bBattleSceneRoundState,b
        bit #BattleSceneRoundArenaRetreat
        bne _98EC
        clc
        bra _98ED


        _98EC
        sec

        _98ED
        pla
        rtl

        .databank 0

        ; 96/98EF

      rlBattleSceneReadArenaRetreat ; 96/98EF

        .al
        .xl
        .autsiz
        .databank ?

        ; In an arena battle, B (pressed, then released) sets BattleSceneRoundArenaRetreat and plays sound $0A: the player leaves after this bout.

        pha
        lda wBattleType
        and #$00FF
        cmp #$0001
        bne _9949
        lda $7FE4DB
        bit #$0001
        bne _9949
        lda bBattleSceneArenaInput
        bit #$0002
        bne _9934
        lda wJoy1Input
        bit #$8000
        beq _9949
        sep #$20
        lda bBattleSceneRoundState,b
        ora #BattleSceneRoundArenaRetreat
        sta bBattleSceneRoundState,b
        lda bBattleSceneArenaInput
        ora #$02
        sta bBattleSceneArenaInput
        rep #$20
        lda #$000A
        jsl rlPlaySoundEffect
        bra _9949


        _9934
        lda wJoy1Input
        bit #$8000
        bne _9949
        sep #$20
        lda bBattleSceneArenaInput
        and #$FD
        sta bBattleSceneArenaInput
        rep #$20

        _9949
        pla
        rtl

        .databank 0

        ; 96/994B

    .endsection Unsorted96989ESection


