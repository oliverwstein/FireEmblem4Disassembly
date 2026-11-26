; Data read by the battle scene's code (banks $97-$99 and $E0): weapon and
; terrain lists, HUD tables, effect palettes and scripts. Named where the reader
; is known; see the comment on each.


    .section Data95937CSection

      .al
      .xl

      aBattleSceneHPFlashPattern ; 95/937C

        ; Read by rsBattleSceneUpdateHP1, rsBattleSceneUpdateHP2, one byte per
        ; value of bBattleSceneHP1FlashTimer/bBattleSceneHP2FlashTimer (1-15;
        ; 0 is never read). Nonzero draws the HP digits with tile base $2940
        ; (palette 2, as when the timer is 0), zero with $3540 (palette 5). So
        ; when the HP stops changing the digits switch to palette 5 for twelve
        ; frames, flicker twice, and return.

        .byte $00, $01, $00, $01, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00

        ; 95/938C

    .endsection Data95937CSection


    .section Data959894Section

      .al
      .xl

      aBattleSceneHPBarBaseTile ; 95/9894

        ; Read by rlBattleSceneDrawHPBar.

        .byte $00

        ; 95/9895

    .endsection Data959894Section


    .section Data95AC3BSection

      .al
      .xl

      aBattleSceneAttackActions ; 95/AC3B

        ; Read by rlBattleSceneQueueAttack: the action of a normal attack, plus the
        ; combatant's variant. One byte per attack style (AttackStyle...), sword to
        ; magic; staves use rlBattleSceneQueueStaffAction.

        .byte $0B ; AttackStyleSword
        .byte $0B ; 1, not used
        .byte $0B ; AttackStyleLance
        .byte $0B ; AttackStyleAxe
        .byte $07 ; AttackStyleRanged
        .byte $07 ; AttackStyleMagic

        ; 95/AC41

    .endsection Data95AC3BSection


    .section Data95ACA8Section

      .al
      .xl

      aBattleSceneCriticalActions ; 95/ACA8

        ; Read by rlBattleSceneQueueCriticalAttack: the action of a critical, as
        ; aBattleSceneAttackActions.

        .byte $11 ; AttackStyleSword
        .byte $11 ; 1, not used
        .byte $11 ; AttackStyleLance
        .byte $11 ; AttackStyleAxe
        .byte $0A ; AttackStyleRanged
        .byte $0A ; AttackStyleMagic

        ; 95/ACAE

    .endsection Data95ACA8Section


    .section Data95ACF0Section

      .al
      .xl

      aBattleSceneSpecialCriticalActions ; 95/ACF0

        ; Read by rlBattleSceneQueueSpecialCriticalAttack: the action of a critical
        ; with round bit $10, as aBattleSceneAttackActions.

        .byte $17 ; AttackStyleSword
        .byte $17 ; 1, not used
        .byte $17 ; AttackStyleLance
        .byte $17 ; AttackStyleAxe
        .byte $0D ; AttackStyleRanged
        .byte $0D ; AttackStyleMagic

        ; 95/ACF6

    .endsection Data95ACF0Section


    .section Data95AD64Section

      .al
      .xl

      aBattleSceneMagicSwordSpellActions ; 95/AD64

        ; Read by rlBattleSceneQueueMagicSwordAttack: the action after a magic
        ; sword's swing. Eight rows of five, one per value of bits 3-5 of
        ; bBattleAnimationCombatantFlags (rlBattleSceneCheckMagicSword sets 0; only
        ; rlBattleSceneRunSpellRowCommand, which nothing reaches, sets others); in each row one byte
        ; per attack style, sword to ranged.

        .byte $21, $21, $25, $25, $13
        .byte $24, $24, $28, $28, $14
        .byte $27, $27, $2B, $2B, $15
        .byte $2A, $2A, $2E, $2E, $16
        .byte $2D, $2D, $31, $31, $17
        .byte $30, $30, $34, $34, $18
        .byte $33, $33, $37, $37, $19
        .byte $36, $36, $3A, $3A, $1A

        ; 95/AD8C

    .endsection Data95AD64Section


    .section Data969BE3Section

      .al
      .xl

      aBattleSceneGreenSteps ; 96/9BE3

        ; Read by rlBattleSceneBrightenColor, rlBattleSceneDarkenColor.

        .word $0000, $0020, $0040, $0060, $0080, $00A0, $00C0, $00E0
        .word $0100, $0120, $0140, $0160, $0180, $01A0, $01C0, $01E0
        .word $0200, $0220, $0240, $0260, $0280, $02A0, $02C0, $02E0
        .word $0300, $0320, $0340, $0360, $0380, $03A0, $03C0, $03E0

        ; 96/9C23

      aBattleSceneBlueSteps ; 96/9C23

        ; Read by rlBattleSceneBrightenColor, rlBattleSceneDarkenColor.

        .word $0000, $0400, $0800, $0C00, $1000, $1400, $1800, $1C00
        .word $2000, $2400, $2800, $2C00, $3000, $3400, $3800, $3C00
        .word $4000, $4400, $4800, $4C00, $5000, $5400, $5800, $5C00
        .word $6000, $6400, $6800, $6C00, $7000, $7400, $7800, $7C00

        ; 96/9C63

    .endsection Data969BE3Section


    .section Data96ED67Section

      .al
      .xl

      aBattleSceneLumaRamp ; 96/ED67

        ; Read by rsBattleSceneConvertPaletteLuma.

        .word $0000, $0401, $0802, $0C03, $1004, $1405, $1806, $1C07
        .word $2008, $2409, $280A, $2C0B, $300C, $340D, $380E, $3C0F
        .word $4010, $4411, $4812, $4C13, $5014, $5415, $5816, $5C17
        .word $6018, $6419, $681A, $6C1B, $701C, $741D, $781E, $7C1F

        ; 96/EDA7

    .endsection Data96ED67Section


    .section Data96EDF2Section

      .al
      .xl

      aBattleSceneGrayRamp ; 96/EDF2

        ; Read by rlBattleSceneColorToLuma.

        .word $0000, $0421, $0842, $0C63, $1084, $14A5, $18C6, $1CE7
        .word $2108, $2529, $294A, $2D6B, $318C, $35AD, $39CE, $3DEF
        .word $4210, $4631, $4A52, $4E73, $5294, $56B5, $5AD6, $5EF7
        .word $6318, $6739, $6B5A, $6F7B, $739C, $77BD, $7BDE, $7FFF

        ; 96/EE32

    .endsection Data96EDF2Section


    .section Data97BDD4Section

      .al
      .xl

      aBattleSceneScriptRoutines ; 97/BDD4

        ; Long pointers to the routines that script commands 4 (call once),
        ; 5 (call every frame until it clears bit 0 of $7FE4B7) and 8 (set as
        ; the routine run every frame) take by index
        ; (rlBattleSceneCommandCallRoutine, rlBattleSceneCommandCallRoutineUntilDone,
        ; rlBattleSceneCommandSetRoutine). Entries 9-12 are empty.

        .long rlBattleSceneScriptInitExpBarSlide ; $00
        .long rlBattleSceneStartExperienceFill ; $01
        .long rlBattleSceneDrawLevelUpWindow ; $02
        .long rlBattleSceneScriptFadeOutWindow1 ; $03
        .long rlBattleSceneScriptFadeInWindow1 ; $04
        .long rlBattleSceneScriptLoadAttackerPortraitPal ; $05
        .long rlBattleSceneScriptFadeOutWindowSlow ; $06
        .long rlBattleSceneScriptFadeInWindow3 ; $07
        .long rlBattleSceneScriptFadeOutWindow3 ; $08
        .long 0 ; $09
        .long 0 ; $0A
        .long 0 ; $0B
        .long 0 ; $0C
        .long rlBattleSceneStartExperienceGauge ; $0D
        .long rlBattleSceneScriptInitStatGains ; $0E
        .long rlBattleSceneScriptInitTileWipe ; $0F
        .long rlBattleSceneScriptInitLevelUpNumber ; $10
        .long rlBattleSceneScriptHideAttacker ; $11
        .long rlBattleSceneScriptShowDefender ; $12
        .long rlBattleSceneScriptFadeOutMain1 ; $13
        .long rlBattleSceneScriptFadeInMain1 ; $14
        .long rlBattleSceneScriptFadeOutMainSlow ; $15
        .long rlBattleSceneScriptFadeInMain3 ; $16
        .long rlBattleSceneScriptFadeOutMain3 ; $17
        .long rlBattleSceneScriptNextEffectPose ; $18
        .long rlBattleSceneScriptInitMessageWindowMode3 ; $19
        .long rlBattleSceneScriptInitMessageWindowMode4 ; $1A
        .long rlBattleSceneResetToNormalMode ; $1B
        .long rlBattleSceneScriptClearMessage ; $1C
        .long rlBattleSceneScriptRunMessage ; $1D
        .long rlBattleSceneScriptFreeMessageHDMA ; $1E
        .long rlBattleSceneScriptClearMessageWindow ; $1F
        .long rlBattleSceneScriptStartMessage ; $20
        .long rlBattleSceneScriptStartMessage2 ; $21
        .long rlBattleSceneScriptLoadDialoguePortraitPal ; $22
        .long rlBattleSceneScriptContinueMessage ; $23
        .long rlBattleSceneScriptInitPalFlash ; $24
        .long rlBattleSceneScriptInitShake0 ; $25
        .long rlBattleSceneScriptHideDefender ; $26
        .long rlBattleSceneScriptInitShake1 ; $27
        .long rlBattleSceneScriptInitShake2 ; $28
        .long rlBattleSceneScriptInitShake3 ; $29
        .long rlBattleSceneScriptHideLetterbox ; $2A
        .long rlBattleSceneScriptShowLetterbox ; $2B
        .long rlBattleSceneScriptSetFullBrightness ; $2C
        .long rlBattleSceneScriptFreeLetterboxHDMA ; $2D
        .long rlBattleSceneScriptCreateLetterboxHDMA ; $2E
        .long rlBattleSceneScriptInitAttackerBlink ; $2F
        .long rlBattleSceneScriptStartBrighten ; $30
        .long rlBattleSceneScriptStartUnbrighten ; $31
        .long rlBattleSceneScriptWhiteBackdrop ; $32
        .long rlBattleSceneScriptRestorePalettes ; $33
        .long rlBattleSceneScriptInitHitSpark ; $34
        .long rlBattleSceneScriptInitBlueTintIn ; $35
        .long rlBattleSceneResetAllEffects ; $36
        .long rlBattleSceneScriptShowAttacker ; $37
        .long rlBattleSceneResetCombatant1Center ; $38
        .long rlBattleSceneScriptInitBlueTintOut ; $39
        .long rlBattleSceneRestoreHUDPalettes ; $3A
        .long rlBattleSceneClearWindowBuffersRegs ; $3B
        .long rlBattleSceneScriptPlaySound0B ; $3C
        .long rlBattleSceneScriptSetVictoryMusic ; $3D
        .long rlBattleSceneResetScrollAndHDMAEffects ; $3E
        .long rlBattleSceneScriptInitBlueTintSlow ; $3F
        .long rlBattleSceneEnableOAMBufferCopy ; $40
        .long rlBattleSceneScriptSaveOAMExt ; $41
        .long rlBattleSceneFadeMusicForJulius ; $42
        .long rlBattleSceneScriptFadeOutMusic ; $43
        .long rlBattleSceneClearWindowBuffers ; $44
        .long rlBattleSceneResetBothCombatantsCenter ; $45
        .long rlBattleSceneScriptInitBG1Dimmed ; $46
        .long rlBattleSceneResetEffectsAndColorMath ; $47

        ; 97/BEAC

    .endsection Data97BDD4Section


    .section Table97E8FBSection

      .al
      .xl

      aBattleAnimationBodyRecords ; 97/E8FB

        ; Read by rsBattleAnimationGetBodyIndex (class, weapon category, body record; $FF ends).

        .byte $00, $00, $00
        .byte $00, $01, $01
        .byte $00, $05, $02
        .byte $01, $01, $01
        .byte $01, $05, $02
        .byte $02, $03, $04
        .byte $03, $02, $00
        .byte $03, $06, $03
        .byte $04, $00, $00
        .byte $05, $00, $00
        .byte $05, $08, $05
        .byte $06, $00, $06
        .byte $06, $01, $07
        .byte $06, $05, $08
        .byte $07, $01, $07
        .byte $07, $05, $08
        .byte $08, $00, $06
        .byte $08, $01, $07
        .byte $08, $02, $06
        .byte $08, $03, $04
        .byte $08, $05, $08
        .byte $08, $06, $09
        .byte $08, $08, $0A
        .byte $09, $00, $06
        .byte $09, $01, $07
        .byte $09, $05, $08
        .byte $0A, $00, $06
        .byte $0A, $01, $07
        .byte $0A, $05, $08
        .byte $0A, $08, $0A
        .byte $0B, $03, $04
        .byte $0C, $00, $06
        .byte $0D, $00, $06
        .byte $0D, $08, $0A
        .byte $0E, $02, $06
        .byte $0E, $06, $09
        .byte $0F, $00, $0C
        .byte $0F, $01, $0D
        .byte $0F, $05, $0E
        .byte $10, $00, $0C
        .byte $10, $01, $0D
        .byte $10, $05, $0E
        .byte $11, $00, $0C
        .byte $11, $01, $0D
        .byte $11, $05, $0E
        .byte $11, $08, $0F
        .byte $12, $00, $10
        .byte $12, $01, $11
        .byte $12, $05, $12
        .byte $13, $00, $10
        .byte $13, $01, $11
        .byte $13, $05, $12
        .byte $14, $00, $10
        .byte $14, $01, $11
        .byte $14, $05, $12
        .byte $15, $03, $13
        .byte $16, $00, $26
        .byte $17, $00, $27
        .byte $18, $03, $13
        .byte $19, $00, $27
        .byte $1A, $00, $14
        .byte $1A, $01, $15
        .byte $1A, $02, $14
        .byte $1A, $03, $18
        .byte $1A, $05, $16
        .byte $1A, $06, $17
        .byte $1B, $00, $14
        .byte $1B, $01, $15
        .byte $1B, $02, $14
        .byte $1B, $03, $18
        .byte $1B, $05, $16
        .byte $1B, $06, $17
        .byte $1B, $08, $19
        .byte $1B, $07, $1A
        .byte $1C, $00, $14
        .byte $1C, $01, $15
        .byte $1C, $02, $14
        .byte $1C, $03, $18
        .byte $1C, $05, $16
        .byte $1C, $06, $17
        .byte $1C, $08, $19
        .byte $1C, $07, $1A
        .byte $22, $01, $15
        .byte $22, $05, $16
        .byte $23, $02, $14
        .byte $23, $06, $17
        .byte $24, $03, $20
        .byte $25, $00, $14
        .byte $26, $02, $21
        .byte $26, $06, $22
        .byte $27, $02, $21
        .byte $27, $06, $22
        .byte $28, $02, $21
        .byte $28, $06, $22
        .byte $29, $02, $21
        .byte $29, $03, $23
        .byte $29, $06, $22
        .byte $2A, $03, $23
        .byte $2B, $02, $21
        .byte $2B, $06, $22
        .byte $2C, $00, $28
        .byte $2D, $00, $28
        .byte $2D, $08, $24
        .byte $2D, $07, $25
        .byte $2E, $00, $2F
        .byte $2F, $00, $28
        .byte $2F, $08, $24
        .byte $30, $00, $28
        .byte $30, $08, $24
        .byte $30, $07, $25
        .byte $31, $08, $24
        .byte $31, $07, $25
        .byte $32, $00, $2B
        .byte $33, $08, $24
        .byte $34, $07, $25
        .byte $35, $07, $25
        .byte $36, $07, $25
        .byte $37, $07, $25
        .byte $38, $07, $25
        .byte $38, $08, $24
        .byte $39, $07, $25
        .byte $39, $08, $24
        .byte $3A, $07, $25
        .byte $3A, $08, $24
        .byte $3B, $07, $25
        .byte $3C, $07, $25
        .byte $3C, $08, $24
        .byte $3D, $07, $25
        .byte $3D, $08, $24
        .byte $3E, $07, $25
        .byte $3E, $08, $24
        .byte $3F, $00, $2B
        .byte $40, $00, $2B
        .byte $43, $03, $2C
        .byte $44, $03, $2C
        .byte $45, $03, $2C
        .byte $46, $03, $2C
        .byte $47, $07, $2D
        .byte $FF

      aBattleSceneCombatantBodyRecords ; 97/EA9A

        ; 48 combatant body records (8 bytes each), read by bank $95 & bank $96.

        .byte $14, $28, $20, $14, $0E, $20, $75, $00
        .byte $14, $28, $2C, $14, $0E, $20, $75, $00
        .byte $14, $28, $20, $20, $10, $20, $70, $00
        .byte $14, $28, $20, $20, $10, $20, $50, $00
        .byte $14, $28, $30, $20, $10, $20, $70, $00
        .byte $14, $28, $30, $20, $10, $20, $40, $00
        .byte $14, $28, $20, $20, $10, $20, $5C, $00
        .byte $14, $28, $24, $20, $10, $20, $5C, $00
        .byte $14, $28, $28, $20, $10, $20, $70, $00
        .byte $14, $28, $20, $20, $10, $20, $50, $00
        .byte $14, $28, $20, $20, $10, $20, $40, $00
        .byte $14, $28, $20, $20, $10, $20, $50, $00
        .byte $1D, $28, $2D, $20, $2D, $20, $70, $30
        .byte $1D, $28, $38, $10, $2D, $20, $70, $30
        .byte $1D, $28, $2B, $20, $10, $20, $70, $00
        .byte $1D, $28, $30, $20, $10, $20, $40, $00
        .byte $1A, $30, $2E, $20, $1F, $20, $70, $30
        .byte $10, $20, $30, $20, $1C, $20, $70, $30
        .byte $18, $30, $39, $20, $10, $20, $70, $00
        .byte $08, $1C, $30, $20, $10, $20, $70, $00
        .byte $0C, $20, $1A, $20, $10, $20, $28, $00
        .byte $0C, $20, $24, $20, $10, $20, $28, $00
        .byte $0C, $20, $30, $20, $10, $20, $70, $00
        .byte $0C, $20, $30, $20, $10, $20, $50, $00
        .byte $0C, $20, $30, $30, $10, $20, $70, $00
        .byte $0C, $20, $30, $20, $10, $20, $40, $00
        .byte $0C, $20, $30, $20, $10, $20, $50, $00
        .byte $08, $1D, $1A, $20, $10, $20, $2D, $00
        .byte $08, $1D, $2A, $20, $10, $20, $2E, $00
        .byte $08, $1D, $30, $20, $10, $20, $70, $00
        .byte $08, $1D, $30, $20, $10, $20, $50, $00
        .byte $0E, $1D, $30, $20, $10, $20, $70, $00
        .byte $0C, $20, $30, $30, $10, $20, $70, $00
        .byte $0E, $20, $1D, $10, $12, $20, $40, $00
        .byte $0E, $20, $30, $20, $10, $20, $50, $00
        .byte $0E, $20, $30, $20, $10, $20, $70, $00
        .byte $08, $1B, $30, $20, $10, $20, $40, $00
        .byte $08, $1D, $30, $30, $20, $20, $50, $00
        .byte $08, $1C, $18, $20, $10, $20, $40, $00
        .byte $08, $20, $18, $14, $20, $20, $5B, $00
        .byte $08, $1D, $18, $14, $20, $20, $5B, $00
        .byte $08, $1B, $30, $20, $10, $20, $40, $00
        .byte $08, $1D, $30, $30, $20, $20, $50, $00
        .byte $08, $1D, $18, $16, $15, $20, $40, $00
        .byte $25, $30, $30, $20, $10, $20, $60, $00
        .byte $08, $1D, $30, $20, $10, $60, $50, $00
        .byte $06, $1C, $30, $20, $10, $20, $40, $00
        .byte $08, $1D, $18, $14, $30, $20, $5B, $00

      aBattleSceneClassWeights ; 97/EC1A

        ; Read by rlBattleSceneGetClassWeight.

        .byte $78, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $C8, $C8, $BE, $C8, $C8, $C8, $DC
        .byte $C8, $C8, $DC, $F0, $FF, $FF, $64, $50, $5A, $5A, $5A, $D7, $EB, $FF, $8C, $8C
        .byte $8C, $8C, $8C, $C8, $C8, $C8, $C8, $78, $78, $78, $78, $78, $78, $50, $50, $50
        .byte $3C, $50, $50, $3C, $3C, $50, $50, $50, $50, $50, $64, $50, $50, $3C, $64, $64
        .byte $3C, $46, $64, $64, $FF, $FF, $FF, $FF, $50

    .endsection Table97E8FBSection


    .section Data97F19BSection

      .al
      .xl

      aTitleLoadList ; 97/F19B

        ; Read by rlRunTitleLoadList via rlStartTitleLoadList.

        .byte $00
        .long gcTitleIntroCaption01, aDecompressionBuffer
        .word $7800, $0400
        .byte $00
        .long gcTitleIntroCaption01Tilemap, aDecompressionBuffer
        .word $7F20, $0080
        .byte $00
        .long g4bppcTitleSceneTilesF676FE, aDecompressionBuffer
        .word $4000, $4000
        .byte $00
        .long acTitleSceneTilemapF524B7, aDecompressionBuffer
        .word $3800, $1000
        .byte $00
        .long gcTitleIntroCaption02, aDecompressionBuffer
        .word $7800, $04E0
        .byte $00
        .long gcTitleIntroCaption02Tilemap, aDecompressionBuffer
        .word $7F20, $0080
        .byte $00
        .long gcTitleIntroCaption03, aDecompressionBuffer
        .word $7800, $0560
        .byte $00
        .long gcTitleIntroCaption03Tilemap, aDecompressionBuffer
        .word $7F20, $0080
        .byte $00
        .long g4bppcBattleBackgroundTitleIntro, aDecompressionBuffer
        .word $0000, $4000
        .byte $00
        .long acTitleSceneTilemapF5222D, aDecompressionBuffer
        .word $3000, $1000
        .byte $00
        .long g4bppcTitleSceneTilesF47E55, aDecompressionBuffer
        .word $2000, $1000
        .byte $00
        .long acTitleSceneTilemapF527E5, aDecompressionBuffer
        .word $7000, $1000
        .byte $00
        .long g4bppcTitleSceneTilesF50A88, aDecompressionBuffer
        .word $6000, $2000
        .byte $00
        .long gcTitleIntroCaption04, aDecompressionBuffer
        .word $7800, $04C0
        .byte $00
        .long gcTitleIntroCaption04Tilemap, aDecompressionBuffer
        .word $7F20, $0080
        .byte $00
        .long acTitleSceneTilemapF03141, aDecompressionBuffer
        .word $2800, $0800
        .byte $00
        .long acTitleSceneTilemapF5299B, aDecompressionBuffer
        .word $2C00, $0800
        .byte $00
        .long gcTitleIntroCaption05, aDecompressionBuffer
        .word $7800, $05C0
        .byte $00
        .long gcTitleIntroCaption05Tilemap, aDecompressionBuffer
        .word $7F20, $0080
        .byte $00
        .long gcTitleIntroCaption06, aDecompressionBuffer
        .word $7800, $0500
        .byte $00
        .long gcTitleIntroCaption06Tilemap, aDecompressionBuffer
        .word $7F20, $0080
        .byte $00
        .long g4bppcTitleSceneTilesF02266, aDecompressionBuffer
        .word $4000, $2000
        .byte $00
        .long g4bppcTitleSceneTilesF019F4, aDecompressionBuffer
        .word $5000, $2000
        .byte $00
        .long gcTitleIntroCaption07, aDecompressionBuffer
        .word $7800, $04E0
        .byte $00
        .long gcTitleIntroCaption07Tilemap, aDecompressionBuffer
        .word $7F20, $0080
        .byte $00
        .long acTitleSceneTilemapF02FC1, aDecompressionBuffer
        .word $2000, $0800
        .byte $00
        .long acTitleSceneTilemapF039A2, aDecompressionBuffer
        .word $2400, $0800
        .byte $00
        .long g4bppcTitleSceneTilesF41F38, aDecompressionBuffer
        .word $0000, $3800
        .byte $00
        .long acTitleSceneTilemapF43803, aDecompressionBuffer
        .word $7000, $1000
        .byte $00
        .long g4bppcTitleSceneTilesF03A1C, aDecompressionBuffer
        .word $3000, $2000
        .byte $00
        .long acTitleSceneTilemapF06B78, aDecompressionBuffer
        .word $1C00, $0800
        .byte $00
        .long gcTitleIntroCaption08, aDecompressionBuffer
        .word $7800, $05C0
        .byte $00
        .long gcTitleIntroCaption08Tilemap, aDecompressionBuffer
        .word $7F20, $0080
        .byte $00
        .long g4bppcTitleSceneTilesF30E6F, aDecompressionBuffer
        .word $4000, $4000
        .byte $00
        .long acTitleSceneTilemapF339EB, aDecompressionBuffer
        .word $2800, $1000
        .byte $00
        .long g4bppcTitleSceneTilesF27E72, aDecompressionBuffer
        .word $6000, $1800
        .byte $00
        .long acTitleSceneTilemapF33663, aDecompressionBuffer
        .word $6C00, $0800
        .byte $00
        .long acTitleSceneTilemapF3365D, aDecompressionBuffer
        .word $0000, $0800
        .byte $00
        .long acTitleScreenTilemap94FF6D, aDecompressionBuffer
        .word $0400, $0800
        .byte $00
        .long gcTitleIntroCaption09, aDecompressionBuffer
        .word $7800, $03C0
        .byte $00
        .long gcTitleIntroCaption09Tilemap, aDecompressionBuffer
        .word $7F20, $0080
        .byte $00
        .long g4bppcTitleScreenTiles94E9EE, aDecompressionBuffer
        .word $1000, $2000
        .byte $00
        .long acTitleSceneTilemapF5597A, aDecompressionBuffer
        .word $0800, $0800
        .byte $00
        .long gcTitleIntroCaption10, aDecompressionBuffer
        .word $7800, $05C0
        .byte $00
        .long gcTitleIntroCaption10Tilemap, aDecompressionBuffer
        .word $7F20, $0080
        .byte $00
        .long g4bppcTitleSceneTilesF52B03, aDecompressionBuffer
        .word $3000, $2000
        .byte $00
        .long acTitleSceneTilemapF5580C, aDecompressionBuffer
        .word $0C00, $0800
        .byte $00
        .long g4bppcTitleSceneTilesF547D4, aDecompressionBuffer
        .word $2000, $1800
        .byte $00
        .long gcTitleIntroCaption11, aDecompressionBuffer
        .word $7800, $0340
        .byte $00
        .long gcTitleIntroCaption11Tilemap, aDecompressionBuffer
        .word $7F20, $0080
        .byte $00
        .long g4bppcTitleSceneTilesF55B0E, aDecompressionBuffer
        .word $4000, $2200
        .byte $00
        .long g4bppcTitleSceneTilesF57E44, aDecompressionBuffer
        .word $6000, $2C80
        .byte $00
        .long acTitleSceneTilemapF57B55, aDecompressionBuffer
        .word $5800, $1000
        .byte $00
        .long gcTitleIntroCaption12, aDecompressionBuffer
        .word $7800, $04E0
        .byte $00
        .long gcTitleIntroCaption12Tilemap, aDecompressionBuffer
        .word $7F20, $0080
        .byte $00
        .long gcTitleIntroCaption13, aDecompressionBuffer
        .word $7800, $0400
        .byte $00
        .long gcTitleIntroCaption13Tilemap, aDecompressionBuffer
        .word $7F20, $0080
        .byte $02
        .long $7F7800
        .word $7C00, $0800
        .byte $00
        .long acTitleSceneTilemapF57C2D, aDecompressionBuffer
        .word $0C00, $0800
        .byte $00
        .long g4bppcTitleSceneTilesF57765, aDecompressionBuffer
        .word $5100, $0B00
        .byte $00
        .long g4bppcSaveMenuMainTiles, aDecompressionBuffer
        .word $2000, $4000
        .byte $00
        .long acSaveMenuBG1Tilemap, $7E9B88
        .word $0000, $0010
        .byte $02
        .long $7F6580
        .word $7EC0, $00C0
        .byte $02
        .long $7F66A0
        .word $7F50, $001A
        .byte $02
        .long $7F63FA
        .word $7DFD, $0004

        ; 97/F45A

      aTitleFadeOutLoadList ; 97/F45A

        ; Read by rlRunTitleLoadList via rlStartTitleFadeOutLoadList.

        .byte $00
        .long acSaveMenuBG1Tilemap, $7F0000
        .word $7800, $0800
        .byte $00
        .long g4bppcSaveMenuMainTiles, $7F1000
        .word $0000, $4000
        .byte $00
        .long acSaveMenuBG2Tilemap, aDecompressionBuffer
        .word $3C00, $0800
        .byte $02
        .long $7F5000
        .word $2000, $0800
        .byte $02
        .long $7F0000
        .word $4000, $1000

        ; 97/F48B

    .endsection Data97F19BSection


    .section Data97F48BSection

      .al
      .xl

      aTitleSceneFadeInBrightness ; 97/F48B

        .byte $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $01, $00, $01, $00, $01, $00
        .byte $01, $01, $01, $01, $01, $01, $01, $01, $02, $01, $02, $01, $02, $01, $02, $01
        .byte $02, $02, $02, $02, $02, $02, $02, $02, $03, $02, $03, $02, $03, $02, $03, $02
        .byte $03, $03, $03, $03, $03, $03, $03, $03, $04, $03, $04, $03, $04, $03, $04, $03
        .byte $04, $04, $04, $04, $04, $04, $04, $04, $05, $04, $05, $04, $05, $04, $05, $04
        .byte $05, $05, $05, $05, $05, $05, $05, $05, $06, $05, $06, $05, $06, $05, $06, $05
        .byte $06, $06, $06, $06, $06, $06, $06, $06, $07, $06, $07, $06, $07, $06, $07, $06
        .byte $07, $07, $07, $07, $07, $07, $07, $07, $08, $07, $08, $07, $08, $07, $08, $07
        .byte $08, $08, $08, $08, $08, $08, $08, $08, $09, $08, $09, $08, $09, $08, $09, $08
        .byte $09, $09, $09, $09, $09, $09, $09, $09, $0A, $09, $0A, $09, $0A, $09, $0A, $09
        .byte $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0B, $0A, $0B, $0A, $0B, $0A, $0B, $0A
        .byte $0B, $0B, $0B, $0B, $0B, $0B, $0B, $0B, $0C, $0B, $0C, $0B, $0C, $0B, $0C, $0B
        .byte $0C, $0C, $0C, $0C, $0C, $0C, $0C, $0C, $0D, $0C, $0D, $0C, $0D, $0C, $0D, $0C
        .byte $0D, $0D, $0D, $0D, $0D, $0D, $0D, $0D, $0E, $0D, $0E, $0D, $0E, $0D, $0D, $0D
        .byte $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0F, $0E, $0F, $0E, $0F, $0E, $0F, $0E
        .byte $0F, $FF

      aTitleFadeInBrightness ; 97/F57D

        .byte $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $00, $00
        .byte $00, $00, $01, $01, $01, $01, $02, $02, $02, $02, $03, $03, $03, $03, $04, $04
        .byte $04, $04, $05, $05, $05, $05, $06, $06, $06, $06, $07, $07, $07, $07, $08, $08
        .byte $08, $08, $09, $09, $09, $09, $0A, $0A, $0A, $0A, $0B, $0B, $0B, $0B, $0C, $0C
        .byte $0C, $0C, $0D, $0D, $0D, $0D, $0E, $0E, $0E, $0E, $0F, $FF

      aTitleSceneFadeOutBrightness ; 97/F5C7

        .byte $0E, $0F, $0E, $0F
        .byte $0E, $0E, $0E, $0E, $0D, $0E, $0D, $0E, $0D, $0D, $0D, $0D, $0C, $0D, $0C, $0D
        .byte $0C, $0C, $0C, $0C, $0B, $0C, $0B, $0C, $0B, $0B, $0B, $0B, $0A, $0B, $0A, $0B
        .byte $0A, $0A, $0A, $0A, $09, $0A, $09, $0A, $09, $09, $09, $09, $08, $09, $08, $09
        .byte $08, $08, $08, $08, $07, $08, $07, $08, $07, $07, $07, $07, $06, $07, $06, $07
        .byte $06, $06, $06, $06, $05, $06, $05, $06, $05, $05, $05, $05, $04, $05, $04, $05
        .byte $04, $04, $04, $04, $03, $04, $03, $04, $03, $03, $03, $03, $02, $03, $02, $03
        .byte $02, $02, $02, $02, $01, $02, $01, $02, $01, $01, $01, $01, $00, $01, $00, $01
        .byte $80, $FF

      aTitleQuickFadeOutBrightness ; 97/F63D

        .byte $0E, $0D, $0C, $0B, $0A, $09, $08, $07, $06, $05, $04, $03, $02, $01
        .byte $00, $80, $FF

      aTitleIntroScene6WindowEffect1Data ; 97/F64E

        ; Read by rlTitleIntroScene6InitWindowEffect1.

        .byte $17, $00, $03, $00, $00, $00, $00, $04, $01, $01, $00, $FD

      aTitleSceneEffectConfig1 ; 97/F65A

        .byte $16, $00, $03, $00
        .byte $00, $00, $00, $04, $01, $01, $00, $FD

      aTitleSceneEffectConfig2 ; 97/F666

        .byte $03, $00, $03, $00, $00, $00, $00, $04
        .byte $02, $38, $00, $01, $80, $00, $00, $81, $80, $00, $00, $00, $80, $00, $00, $00
        .byte $FD

      aTitleSceneWindowData1 ; 97/F67F

        .byte $83, $02, $37, $02, $02, $7F, $00, $00, $82, $80, $00, $00, $00, $80, $80
        .byte $FF, $02, $36, $03, $03, $7F, $00, $00, $83, $7F, $00, $01, $82, $81, $00, $FE
        .byte $02, $34, $06, $06, $7F, $AB, $FF, $85, $7F, $C0, $00, $83, $82, $80, $FD, $02
        .byte $33, $07, $08, $80, $6E, $FF, $87, $80, $6D, $00, $01, $7C, $00, $00, $02, $32
        .byte $09, $08, $81, $25, $FF, $89, $81, $38, $00, $03, $7B, $00, $04, $02, $32, $0B
        .byte $07, $82, $AB, $FE, $8B, $82, $00, $00, $06, $7A, $99, $01, $02, $32, $0D, $04
        .byte $84, $56, $FC, $8D, $84, $C5, $FF, $0B, $79, $CC, $00, $02, $33, $0D, $0D, $79
        .byte $76, $00, $8D, $86, $8A, $FF, $00, $86, $77, $FF, $02, $30, $11, $11, $79, $3C
        .byte $00, $86, $79, $00, $03, $8D, $88, $16, $FF, $02, $2E, $13, $13, $7B, $00, $00
        .byte $8B, $7B, $66, $01, $8A, $89, $72, $FE, $02, $2C, $14, $14, $7D, $C0, $FF, $90
        .byte $7D, $DD, $00, $86, $8A, $67, $FC, $02, $2A, $14, $15, $80, $80, $FF, $94, $80
        .byte $73, $00, $01, $76, $00, $00, $02, $2A, $18, $12, $83, $1F, $FF, $98, $83, $35
        .byte $00, $08, $74, $DB, $02, $02, $2A, $1B, $0F, $86, $93, $FE, $9B, $86, $00, $00
        .byte $0E, $72, $89, $01, $02, $2C, $1C, $08, $8A, $93, $FC, $9C, $8A, $C0, $FF, $16
        .byte $72, $CF, $00, $02, $2F, $1A, $1A, $72, $80, $00, $9A, $8D, $80, $FF, $00, $8D
        .byte $77, $FF, $02, $2A, $20, $20, $74, $38, $00, $8A, $74, $00, $03, $98, $8F, $22
        .byte $FF, $02, $26, $23, $23, $77, $00, $00, $93, $77, $71, $01, $92, $91, $79, $FE
        .byte $02, $23, $23, $23, $7B, $C6, $FF, $9B, $7B, $D8, $00, $8A, $91, $AB, $FC, $02
        .byte $21, $22, $23, $80, $80, $FF, $A2, $80, $78, $00, $01, $6F, $00, $00, $02, $21
        .byte $27, $1E, $85, $24, $FF, $A7, $85, $3B, $00, $0B, $6C, $66, $03, $02, $22, $2B
        .byte $17, $8A, $98, $FE, $AB, $8A, $00, $00, $16, $6B, $79, $01, $02, $25, $2B, $0D
        .byte $8F, $EB, $FC, $AB, $8F, $C5, $FF, $20, $6A, $DE, $00, $02, $2A, $28, $28, $6C
        .byte $79, $00, $A8, $93, $87, $FF, $00, $93, $80, $FF, $02, $24, $2E, $2E, $6F, $37
        .byte $00, $8D, $6F, $40, $03, $A3, $96, $26, $FF, $02, $1F, $31, $31, $73, $00, $00
        .byte $9A, $73, $7A, $01, $99, $98, $76, $FE, $02, $1B, $32, $32, $79, $C3, $FF, $A5
        .byte $79, $DC, $00, $8F, $98, $EE, $FC, $02, $18, $2F, $30, $80, $7E, $FF, $AF, $80
        .byte $7D, $00, $01, $68, $00, $00, $02, $18, $36, $29, $87, $27, $FF, $B6, $87, $38
        .byte $00, $0F, $65, $49, $03, $02, $1B, $39, $1E, $8E, $85, $FE, $B9, $8E, $00, $00
        .byte $1D, $63, $89, $01, $02, $1F, $3A, $11, $94, $F0, $FC, $BA, $94, $C7, $FF, $2B
        .byte $63, $DB, $00, $02, $26, $35, $35, $65, $7D, $00, $B5, $9A, $83, $FF, $00, $9A
        .byte $7E, $FF, $02, $1E, $3D, $3D, $69, $3A, $00, $91, $69, $50, $03, $AE, $9E, $23
        .byte $FF, $02, $17, $41, $41, $6F, $00, $00, $A2, $6F, $7C, $01, $A1, $A0, $78, $FE
        .byte $02, $12, $41, $41, $77, $C5, $FF, $B1, $77, $DA, $00, $92, $A0, $B5, $FC, $02
        .byte $10, $3B, $3C, $80, $7E, $FF, $BB, $80, $7D, $00, $01, $62, $00, $00, $02, $10
        .byte $45, $33, $89, $24, $FF, $C5, $89, $37, $00, $14, $5E, $0D, $03, $02, $13, $49
        .byte $26, $92, $84, $FE, $C9, $92, $00, $00, $25, $5B, $87, $01, $02, $19, $48, $14
        .byte $9A, $BD, $FC, $C8, $9A, $C4, $FF, $36, $5C, $D9, $00, $00, $FD

      aTitleSceneWindowData2 ; 97/F8CB

        .byte $83, $02, $21
        .byte $43, $43, $5F, $7A, $00, $C3, $A0, $86, $FF, $00, $A0, $82, $FF, $02, $17, $4C
        .byte $4C, $64, $39, $00, $96, $64, $18, $03, $B8, $A5, $21, $FF, $02, $0F, $51, $51
        .byte $6C, $00, $00, $AA, $6C, $70, $01, $A9, $A7, $87, $FE, $02, $09, $50, $50, $75
        .byte $C7, $FF, $BC, $75, $D8, $00, $96, $A7, $C4, $FC, $02, $07, $49, $4A, $80, $7F
        .byte $FF, $C9, $80, $7E, $00, $01, $5B, $00, $00, $02, $07, $54, $3E, $8B, $22, $FF
        .byte $D4, $8B, $39, $00, $18, $56, $21, $03, $00, $FF

        ; Palette / battle sprite effect entries ($97/F928-$97/F9C4)
      aTitleSceneSpriteDesc01 ; 97/F928

        .long aTitleSceneSpriteAnimScript1
        .byte $15, $F7, $6E, $00, $F0, $00, $00, $00, $00, $00
      aTitleSceneSpriteDesc02 ; 97/F935

        .long aTitleSceneSpriteAnimScript1
        .byte $15, $F7, $92, $00, $F0, $00, $00, $00, $00, $00
      aTitleSceneSpriteDesc03 ; 97/F942

        .long aTitleSceneSpriteAnimScript1
        .byte $15, $F7, $4D, $00, $F0, $00, $00, $00, $00, $00
      aTitleSceneSpriteDesc04 ; 97/F94F

        .long aTitleSceneSpriteAnimScript1
        .byte $15, $F7, $B3, $00, $F0, $00, $00, $00, $00, $00
      aTitleSceneSpriteDesc05 ; 97/F95C

        .long aTitleSceneSpriteAnimScript3
        .byte $15, $F7, $3A, $00, $F0, $00, $00, $00, $00, $00
      aTitleSceneSpriteDesc06 ; 97/F969

        .long aTitleSceneSpriteAnimScript3
        .byte $15, $F7, $C6, $00, $F0, $00, $00, $00, $00, $00
      aTitleSceneSpriteDesc07 ; 97/F976

        .long aTitleSceneSpriteAnimScript2
        .byte $15, $F7, $3B, $00, $F0, $00, $00, $00, $00, $00
      aTitleSceneSpriteDesc08 ; 97/F983

        .long aTitleSceneSpriteAnimScript2
        .byte $15, $F7, $C5, $00, $F0, $00, $00, $00, $00, $00
      aTitleSceneSpriteDesc09 ; 97/F990

        .long aTitleSceneSpriteAnimScript2
        .byte $15, $F7, $4F, $00, $F0, $00, $00, $00, $00, $00
      aTitleSceneSpriteDesc10 ; 97/F99D

        .long aTitleSceneSpriteAnimScript2
        .byte $15, $F7, $B1, $00, $F0, $00, $00, $00, $00, $00
      aTitleSceneSpriteDesc11 ; 97/F9AA

        .long aTitleSceneSpriteAnimScript2
        .byte $15, $F7, $71, $00, $F0, $00, $00, $00, $00, $00
      aTitleSceneSpriteDesc12 ; 97/F9B7

        .long aTitleSceneSpriteAnimScript2
        .byte $15, $F7, $8F, $00, $F0, $00, $00, $00, $00, $00

      aTitleSceneSpriteDesc13 ; 97/F9C4

        .byte $13, $FE, $9B, $37, $FE, $80, $00, $F0, $00, $00, $00, $00, $00

      aTitleSceneSpriteOffsets ; 97/F9D1

        .byte $00, $00, $62
        .byte $00, $C4, $00, $26, $01, $88, $01, $EA, $01, $AE, $02, $10, $03, $72, $03, $D4
        .byte $03, $36, $04, $98, $04, $4C, $02, $72, $01, $3F, $01, $23, $01, $4C, $01, $58
        .byte $01, $70, $01, $36, $01, $14, $01, $6C, $01, $31, $01, $04, $01, $63, $01, $56
        .byte $04

      aTitleSceneSpriteYVelocities ; 97/FA05

        .byte $18, $00, $18, $00, $11, $00, $11, $00, $06, $00, $06, $00, $FA, $FF, $FA
        .byte $FF, $EF, $FF, $EF, $FF, $E8, $FF, $E8, $FF, $80, $FF
      aTitleSceneSpriteDesc14 ; 97/FA1F

        .long aTitleSceneSpriteAnimScript4
        .long aTitleSceneSpriteAnimScript4
        .long aTitleSceneSpriteAnimScript4
        .long aTitleSceneSpriteAnimScript4
        .long aTitleSceneSpriteAnimScript6
        .long aTitleSceneSpriteAnimScript6
        .long aTitleSceneSpriteAnimScript5
        .long aTitleSceneSpriteAnimScript5
        .long aTitleSceneSpriteAnimScript5
        .long aTitleSceneSpriteAnimScript5
        .long aTitleSceneSpriteAnimScript5
        .long aTitleSceneSpriteAnimScript5
        .byte $1D, $FE, $9B
        .long aTitleSceneCrusaderDesc01
        .long aTitleSceneCrusaderDesc02
        .long aTitleSceneCrusaderDesc03
        .long aTitleSceneCrusaderDesc04
        .long aTitleSceneCrusaderDesc05
        .long aTitleSceneCrusaderDesc06
        .long aTitleSceneCrusaderDesc07
        .long aTitleSceneCrusaderDesc08
        .long aTitleSceneCrusaderDesc09
        .long aTitleSceneCrusaderDesc10
        .long aTitleSceneCrusaderDesc11
        .long aTitleSceneCrusaderDesc12
      aTitleSceneCrusaderDesc01 ; 97/FA6A
        .long aTitleSceneCrusaderAnimScript03
        .byte $6D, $F9, $00, $00, $F0, $00, $00, $00, $00, $00
      aTitleSceneCrusaderDesc02 ; 97/FA77
        .long aTitleSceneCrusaderAnimScript07
        .byte $6D, $F9, $00, $00, $F0, $00, $00, $00, $00, $00
      aTitleSceneCrusaderDesc03 ; 97/FA84
        .long aTitleSceneCrusaderAnimScript06
        .byte $6D, $F9, $00, $00, $F0, $00, $00, $00, $00, $00
      aTitleSceneCrusaderDesc04 ; 97/FA91
        .long aTitleSceneCrusaderAnimScript04
        .byte $6D, $F9, $00, $00, $F0, $00, $00, $00, $00, $00
      aTitleSceneCrusaderDesc05 ; 97/FA9E
        .long aTitleSceneCrusaderAnimScript10
        .byte $6D, $F9, $00, $00, $F0, $00, $00, $00, $00, $00
      aTitleSceneCrusaderDesc06 ; 97/FAAB
        .long aTitleSceneCrusaderAnimScript12
        .byte $6D, $F9, $00, $00, $F0, $00, $00, $00, $00, $00
      aTitleSceneCrusaderDesc07 ; 97/FAB8
        .long aTitleSceneCrusaderAnimScript02
        .byte $6D, $F9, $00, $00, $F0, $00, $00, $00, $00, $00
      aTitleSceneCrusaderDesc08 ; 97/FAC5
        .long aTitleSceneCrusaderAnimScript01
        .byte $6D, $F9, $00, $00, $F0, $00, $00, $00, $00, $00
      aTitleSceneCrusaderDesc09 ; 97/FAD2
        .long aTitleSceneCrusaderAnimScript05
        .byte $6D, $F9, $00, $00, $F0, $00, $00, $00, $00, $00
      aTitleSceneCrusaderDesc10 ; 97/FADF
        .long aTitleSceneCrusaderAnimScript08
        .byte $6D, $F9, $00, $00, $F0, $00, $00, $00, $00, $00
      aTitleSceneCrusaderDesc11 ; 97/FAEC
        .long aTitleSceneCrusaderAnimScript09
        .byte $6D, $F9, $00, $00, $F0, $00, $00, $00, $00, $00
      aTitleSceneCrusaderDesc12 ; 97/FAF9
        .long aTitleSceneCrusaderAnimScript11
        .byte $6D, $F9, $00, $00, $F0, $00, $00, $00, $00, $00
        .byte $0B, $20, $35, $4B, $60, $75, $8B, $A0, $B5, $CB, $E0, $F5

      aTitleIntroScene1BG2WaveOffsets ; 97/FB12

        ; Read by rlStepTitleIntroScene1BG2WaveHDMA.

        .word $0000, $0000, $0001, $0001, $0001, $0002, $0002, $0002
        .word $0002, $0002, $0002, $0001, $0001, $0001, $0000, $0000
        .word $0000, $0000, -$0001, -$0001, -$0001, -$0002, -$0002, -$0002
        .word -$0002, -$0002, -$0002, -$0001, -$0001, -$0001, $0000, $0000
      aTitleSceneScrollCurve ; 97/FB52

        .word $0000, $0001, $0002, $0003, $0004, $0004, $0005, $0005
        .word $0005, $0005, $0004, $0004, $0003, $0002, $0001, $0000
        .word $0000, -$0001, -$0002, -$0003, -$0004, -$0004, -$0005, -$0005
        .word -$0005, -$0005, -$0004, -$0004, -$0003, -$0002, -$0001, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0001, $0001, $0002, $0002, $0002, $0002
        .word $0001, $0001, $0000, $0000, $0000, $0000, -$0001, -$0001
        .word -$0002, -$0002, -$0002, -$0002, -$0001, -$0001, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0001, $0001
        .word $0002, $0002, $0002, $0002, $0001, $0001, $0000, $0000
        .word $0000, $0000, -$0001, -$0001, -$0002, -$0002, -$0002, -$0002
        .word -$0001, -$0001, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0001
        .word $0001, $0002, $0002, $0002, $0002, $0001, $0001, $0000
        .word $0000, $0000, $0000, -$0001, -$0001, -$0002, -$0002, -$0002
        .word -$0002, -$0001, -$0001, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0001, $0001, $0002
        .word $0002, $0003, $0003, $0003, $0003, $0002, $0002, $0001
        .word $0001, $0000, $0000, $0000, $0000, -$0001, -$0001, -$0002
        .word -$0002, -$0003, -$0003, -$0003, -$0003, -$0002, -$0002, -$0001
        .word -$0001, $0000, $0000, $0000, $0000, $0001, $0001, $0002
        .word $0002, $0003, $0003, $0003, $0003, $0002, $0002, $0001
        .word $0001, $0000, $0000, $0000, $0000, -$0001, -$0001, -$0002
        .word -$0002, -$0003, -$0003, -$0003, -$0003, -$0002, -$0002, -$0001
        .word -$0001, $0000, $0000, $0000, $0000, $0001, $0001, $0002
        .word $0002, $0003, $0003, $0003, $0003, $0002, $0002, $0001
        .word $0001, $0000, $0000, $0000, $0000, -$0001, -$0001, -$0002
        .word -$0002, -$0003, -$0003, -$0003, -$0003, -$0002, -$0002, -$0001
        .word -$0001, $0000
        .byte $00, $00, $FE, $FE, $FD, $FB, $EF, $BD, $EE, $ED, $AA, $48, $88, $42, $08, $20
        .byte $40, $80, $80, $80, $40, $20, $10, $08, $04, $02, $01

        ; 97/FDC1

    .endsection Data97F48BSection


    .section Data988000Section

      .al
      .xl

      aBattleSceneBG2PerspectiveRecords ; 98/8000

        ; 256 x 41-byte records. Read by rsBattleSceneBuildBG2PerspectiveTable.

        .byte $5B, $59, $56, $54, $52, $50, $4D, $4B, $49, $46, $44, $42, $40, $3D, $3B, $39, $36, $34, $32, $30, $2D ; $00
        .byte $2B, $29, $26, $24, $22, $20, $1D, $1B, $19, $16, $14, $12, $10, $0D, $0B, $09, $06, $04, $02, $00
        .byte $5B, $59, $56, $54, $52, $50, $4D, $4B, $49, $46, $44, $42, $40, $3D, $3B, $39, $36, $34, $32, $30, $2D ; $01
        .byte $2B, $29, $26, $24, $22, $20, $1D, $1B, $19, $16, $14, $12, $10, $0D, $0B, $09, $06, $04, $02, $01
        .byte $5B, $59, $56, $54, $52, $50, $4D, $4B, $49, $46, $44, $42, $41, $3E, $3C, $3A, $37, $35, $33, $31, $2E ; $02
        .byte $2C, $2A, $27, $25, $23, $21, $1E, $1C, $1A, $17, $15, $13, $11, $0E, $0C, $0A, $07, $05, $03, $02
        .byte $5B, $59, $56, $55, $53, $51, $4E, $4C, $4A, $47, $45, $43, $41, $3E, $3C, $3A, $37, $35, $33, $31, $2E ; $03
        .byte $2C, $2B, $28, $26, $24, $22, $1F, $1D, $1B, $18, $16, $14, $12, $0F, $0D, $0B, $08, $06, $04, $03
        .byte $5C, $5A, $57, $55, $53, $51, $4E, $4C, $4A, $47, $45, $43, $42, $3F, $3D, $3B, $38, $36, $34, $32, $2F ; $04
        .byte $2D, $2B, $28, $26, $24, $23, $20, $1E, $1C, $19, $17, $15, $13, $10, $0E, $0C, $09, $07, $05, $04
        .byte $5C, $5A, $57, $55, $53, $51, $4E, $4D, $4B, $48, $46, $44, $42, $3F, $3D, $3B, $38, $36, $35, $33, $30 ; $05
        .byte $2E, $2C, $29, $27, $25, $23, $20, $1E, $1D, $1A, $18, $16, $14, $11, $0F, $0D, $0A, $08, $06, $05
        .byte $5C, $5A, $57, $56, $54, $52, $4F, $4D, $4B, $48, $46, $44, $43, $40, $3E, $3C, $39, $37, $35, $33, $30 ; $06
        .byte $2E, $2D, $2A, $28, $26, $24, $21, $1F, $1D, $1A, $19, $17, $15, $12, $10, $0E, $0B, $09, $07, $06
        .byte $5D, $5B, $58, $56, $54, $52, $4F, $4D, $4C, $49, $47, $45, $43, $40, $3E, $3C, $3A, $38, $36, $34, $31 ; $07
        .byte $2F, $2D, $2A, $29, $27, $25, $22, $20, $1E, $1B, $19, $18, $16, $13, $11, $0F, $0C, $0A, $08, $07
        .byte $5D, $5B, $58, $56, $54, $53, $50, $4E, $4C, $49, $47, $45, $44, $41, $3F, $3D, $3A, $38, $36, $35, $32 ; $08
        .byte $30, $2E, $2B, $29, $27, $26, $23, $21, $1F, $1C, $1A, $18, $17, $14, $12, $10, $0D, $0B, $09, $08
        .byte $5D, $5B, $58, $57, $55, $53, $50, $4E, $4C, $4A, $48, $46, $44, $41, $3F, $3D, $3B, $39, $37, $35, $32 ; $09
        .byte $30, $2F, $2C, $2A, $28, $26, $23, $22, $20, $1D, $1B, $19, $17, $15, $13, $11, $0E, $0C, $0A, $09
        .byte $5D, $5C, $59, $57, $55, $53, $50, $4F, $4D, $4A, $48, $46, $45, $42, $40, $3E, $3B, $39, $38, $36, $33 ; $0A
        .byte $31, $2F, $2D, $2B, $29, $27, $24, $22, $21, $1E, $1C, $1A, $18, $15, $14, $12, $0F, $0D, $0B, $0A
        .byte $5E, $5C, $59, $57, $55, $54, $51, $4F, $4D, $4A, $49, $47, $45, $42, $40, $3F, $3C, $3A, $38, $36, $34 ; $0B
        .byte $32, $30, $2D, $2B, $2A, $28, $25, $23, $21, $1F, $1D, $1B, $19, $16, $15, $13, $10, $0E, $0C, $0B
        .byte $5E, $5C, $59, $58, $56, $54, $51, $4F, $4E, $4B, $49, $47, $46, $43, $41, $3F, $3C, $3B, $39, $37, $34 ; $0C
        .byte $32, $31, $2E, $2C, $2A, $29, $26, $24, $22, $1F, $1E, $1C, $1A, $17, $15, $14, $11, $0F, $0D, $0C
        .byte $5E, $5C, $5A, $58, $56, $54, $52, $50, $4E, $4B, $4A, $48, $46, $43, $42, $40, $3D, $3B, $39, $38, $35 ; $0D
        .byte $33, $31, $2F, $2D, $2B, $29, $27, $25, $23, $20, $1E, $1D, $1B, $18, $16, $15, $12, $10, $0E, $0D
        .byte $5F, $5D, $5A, $58, $57, $55, $52, $50, $4F, $4C, $4A, $48, $47, $44, $42, $40, $3E, $3C, $3A, $38, $36 ; $0E
        .byte $34, $32, $2F, $2E, $2C, $2A, $27, $26, $24, $21, $1F, $1E, $1C, $19, $17, $16, $13, $11, $0F, $0E
        .byte $5F, $5D, $5A, $59, $57, $55, $52, $51, $4F, $4C, $4B, $49, $47, $44, $43, $41, $3E, $3C, $3B, $39, $36 ; $0F
        .byte $34, $33, $30, $2E, $2D, $2B, $28, $26, $25, $22, $20, $1E, $1D, $1A, $18, $16, $14, $12, $10, $0F
        .byte $5F, $5D, $5B, $59, $57, $56, $53, $51, $4F, $4D, $4B, $49, $48, $45, $43, $41, $3F, $3D, $3B, $3A, $37 ; $10
        .byte $35, $33, $31, $2F, $2D, $2C, $29, $27, $25, $23, $21, $1F, $1E, $1B, $19, $17, $15, $13, $11, $10
        .byte $5F, $5E, $5B, $59, $58, $56, $53, $52, $50, $4D, $4B, $4A, $48, $45, $44, $42, $3F, $3E, $3C, $3A, $38 ; $11
        .byte $36, $34, $31, $30, $2E, $2C, $2A, $28, $26, $24, $22, $20, $1E, $1C, $1A, $18, $16, $14, $12, $11
        .byte $60, $5E, $5B, $5A, $58, $56, $54, $52, $50, $4E, $4C, $4A, $49, $46, $44, $42, $40, $3E, $3C, $3B, $38 ; $12
        .byte $36, $35, $32, $30, $2F, $2D, $2A, $29, $27, $24, $23, $21, $1F, $1D, $1B, $19, $17, $15, $13, $12
        .byte $60, $5E, $5C, $5A, $58, $57, $54, $52, $51, $4E, $4C, $4B, $49, $46, $45, $43, $40, $3F, $3D, $3B, $39 ; $13
        .byte $37, $35, $33, $31, $2F, $2E, $2B, $29, $28, $25, $24, $22, $20, $1E, $1C, $1A, $18, $16, $14, $13
        .byte $60, $5F, $5C, $5A, $59, $57, $54, $53, $51, $4F, $4D, $4B, $4A, $47, $45, $44, $41, $3F, $3E, $3C, $39 ; $14
        .byte $38, $36, $34, $32, $30, $2F, $2C, $2A, $29, $26, $24, $23, $21, $1E, $1D, $1B, $19, $17, $15, $14
        .byte $61, $5F, $5C, $5B, $59, $57, $55, $53, $52, $4F, $4D, $4C, $4A, $47, $46, $44, $42, $40, $3E, $3D, $3A ; $15
        .byte $38, $37, $34, $33, $31, $2F, $2D, $2B, $29, $27, $25, $24, $22, $1F, $1E, $1C, $1A, $18, $16, $15
        .byte $61, $5F, $5D, $5B, $59, $58, $55, $54, $52, $4F, $4E, $4C, $4B, $48, $46, $45, $42, $41, $3F, $3D, $3B ; $16
        .byte $39, $37, $35, $33, $32, $30, $2E, $2C, $2A, $28, $26, $24, $23, $20, $1F, $1D, $1A, $19, $17, $16
        .byte $61, $60, $5D, $5B, $5A, $58, $56, $54, $52, $50, $4E, $4D, $4B, $49, $47, $45, $43, $41, $40, $3E, $3B ; $17
        .byte $3A, $38, $36, $34, $32, $31, $2E, $2D, $2B, $29, $27, $25, $24, $21, $20, $1E, $1B, $1A, $18, $17
        .byte $61, $60, $5D, $5C, $5A, $59, $56, $54, $53, $50, $4F, $4D, $4C, $49, $47, $46, $43, $42, $40, $3F, $3C ; $18
        .byte $3A, $39, $36, $35, $33, $32, $2F, $2D, $2C, $29, $28, $26, $25, $22, $20, $1F, $1C, $1B, $19, $18
        .byte $62, $60, $5E, $5C, $5A, $59, $56, $55, $53, $51, $4F, $4E, $4C, $4A, $48, $46, $44, $42, $41, $3F, $3D ; $19
        .byte $3B, $39, $37, $35, $34, $32, $30, $2E, $2D, $2A, $29, $27, $25, $23, $21, $20, $1D, $1C, $1A, $19
        .byte $62, $60, $5E, $5C, $5B, $59, $57, $55, $54, $51, $50, $4E, $4D, $4A, $49, $47, $45, $43, $41, $40, $3D ; $1A
        .byte $3C, $3A, $38, $36, $35, $33, $31, $2F, $2D, $2B, $29, $28, $26, $24, $22, $21, $1E, $1D, $1B, $1A
        .byte $62, $61, $5E, $5D, $5B, $5A, $57, $56, $54, $52, $50, $4F, $4D, $4B, $49, $47, $45, $44, $42, $40, $3E ; $1B
        .byte $3C, $3B, $38, $37, $35, $34, $31, $30, $2E, $2C, $2A, $29, $27, $25, $23, $22, $1F, $1E, $1C, $1B
        .byte $63, $61, $5F, $5D, $5C, $5A, $58, $56, $55, $52, $51, $4F, $4E, $4B, $4A, $48, $46, $44, $43, $41, $3F ; $1C
        .byte $3D, $3C, $39, $38, $36, $35, $32, $31, $2F, $2D, $2B, $2A, $28, $26, $24, $23, $20, $1F, $1D, $1C
        .byte $63, $61, $5F, $5D, $5C, $5A, $58, $57, $55, $53, $51, $50, $4E, $4C, $4A, $49, $46, $45, $43, $42, $3F ; $1D
        .byte $3E, $3C, $3A, $38, $37, $35, $33, $31, $30, $2E, $2C, $2A, $29, $27, $25, $23, $21, $20, $1E, $1D
        .byte $63, $62, $5F, $5E, $5C, $5B, $58, $57, $55, $53, $52, $50, $4F, $4C, $4B, $49, $47, $45, $44, $42, $40 ; $1E
        .byte $3E, $3D, $3B, $39, $38, $36, $34, $32, $31, $2E, $2D, $2B, $2A, $27, $26, $24, $22, $21, $1F, $1E
        .byte $63, $62, $60, $5E, $5D, $5B, $59, $57, $56, $54, $52, $51, $4F, $4D, $4B, $4A, $47, $46, $44, $43, $41 ; $1F
        .byte $3F, $3E, $3B, $3A, $38, $37, $34, $33, $31, $2F, $2E, $2C, $2B, $28, $27, $25, $23, $22, $20, $1F
        .byte $64, $62, $60, $5F, $5D, $5C, $59, $58, $56, $54, $53, $51, $50, $4D, $4C, $4A, $48, $47, $45, $44, $41 ; $20
        .byte $40, $3E, $3C, $3B, $39, $38, $35, $34, $32, $30, $2F, $2D, $2C, $29, $28, $26, $24, $23, $21, $20
        .byte $64, $63, $60, $5F, $5D, $5C, $5A, $58, $57, $54, $53, $51, $50, $4E, $4C, $4B, $49, $47, $46, $44, $42 ; $21
        .byte $40, $3F, $3D, $3B, $3A, $38, $36, $35, $33, $31, $2F, $2E, $2C, $2A, $29, $27, $25, $23, $22, $21
        .byte $64, $63, $61, $5F, $5E, $5C, $5A, $59, $57, $55, $53, $52, $51, $4E, $4D, $4B, $49, $48, $46, $45, $43 ; $22
        .byte $41, $40, $3D, $3C, $3A, $39, $37, $35, $34, $32, $30, $2F, $2D, $2B, $2A, $28, $26, $24, $23, $22
        .byte $65, $63, $61, $60, $5E, $5D, $5A, $59, $58, $55, $54, $52, $51, $4F, $4D, $4C, $4A, $48, $47, $45, $43 ; $23
        .byte $42, $40, $3E, $3D, $3B, $3A, $38, $36, $35, $32, $31, $30, $2E, $2C, $2A, $29, $27, $25, $24, $23
        .byte $65, $63, $61, $60, $5E, $5D, $5B, $59, $58, $56, $54, $53, $52, $4F, $4E, $4C, $4A, $49, $47, $46, $44 ; $24
        .byte $42, $41, $3F, $3D, $3C, $3B, $38, $37, $35, $33, $32, $30, $2F, $2D, $2B, $2A, $28, $26, $25, $24
        .byte $65, $64, $62, $60, $5F, $5D, $5B, $5A, $58, $56, $55, $53, $52, $50, $4E, $4D, $4B, $49, $48, $47, $44 ; $25
        .byte $43, $42, $40, $3E, $3D, $3B, $39, $38, $36, $34, $33, $31, $30, $2E, $2C, $2B, $29, $27, $26, $25
        .byte $65, $64, $62, $61, $5F, $5E, $5C, $5A, $59, $57, $55, $54, $53, $50, $4F, $4E, $4B, $4A, $49, $47, $45 ; $26
        .byte $44, $42, $40, $3F, $3D, $3C, $3A, $38, $37, $35, $34, $32, $31, $2F, $2D, $2C, $2A, $28, $27, $26
        .byte $66, $64, $62, $61, $60, $5E, $5C, $5B, $59, $57, $56, $54, $53, $51, $50, $4E, $4C, $4B, $49, $48, $46 ; $27
        .byte $44, $43, $41, $40, $3E, $3D, $3B, $39, $38, $36, $34, $33, $32, $30, $2E, $2D, $2B, $29, $28, $27
        .byte $66, $65, $63, $61, $60, $5F, $5C, $5B, $5A, $58, $56, $55, $54, $51, $50, $4F, $4D, $4B, $4A, $49, $46 ; $28
        .byte $45, $44, $42, $40, $3F, $3E, $3B, $3A, $39, $37, $35, $34, $33, $30, $2F, $2E, $2C, $2A, $29, $28
        .byte $66, $65, $63, $62, $60, $5F, $5D, $5B, $5A, $58, $57, $55, $54, $52, $51, $4F, $4D, $4C, $4A, $49, $47 ; $29
        .byte $46, $44, $42, $41, $40, $3E, $3C, $3B, $39, $37, $36, $35, $33, $31, $30, $2F, $2D, $2B, $2A, $29
        .byte $67, $65, $63, $62, $61, $5F, $5D, $5C, $5B, $59, $57, $56, $55, $52, $51, $50, $4E, $4C, $4B, $4A, $48 ; $2A
        .byte $46, $45, $43, $42, $40, $3F, $3D, $3C, $3A, $38, $37, $36, $34, $32, $31, $30, $2E, $2C, $2B, $2A
        .byte $67, $66, $64, $62, $61, $60, $5E, $5C, $5B, $59, $58, $56, $55, $53, $52, $50, $4E, $4D, $4C, $4A, $48 ; $2B
        .byte $47, $46, $44, $42, $41, $40, $3E, $3C, $3B, $39, $38, $36, $35, $33, $32, $30, $2E, $2D, $2C, $2B
        .byte $67, $66, $64, $63, $61, $60, $5E, $5D, $5B, $59, $58, $57, $56, $54, $52, $51, $4F, $4E, $4C, $4B, $49 ; $2C
        .byte $48, $46, $44, $43, $42, $41, $3F, $3D, $3C, $3A, $39, $37, $36, $34, $33, $31, $2F, $2E, $2D, $2C
        .byte $68, $66, $64, $63, $62, $60, $5E, $5D, $5C, $5A, $59, $57, $56, $54, $53, $51, $50, $4E, $4D, $4C, $4A ; $2D
        .byte $48, $47, $45, $44, $43, $41, $3F, $3E, $3D, $3B, $39, $38, $37, $35, $34, $32, $30, $2F, $2E, $2D
        .byte $68, $67, $65, $63, $62, $61, $5F, $5E, $5C, $5A, $59, $58, $57, $55, $53, $52, $50, $4F, $4E, $4C, $4A ; $2E
        .byte $49, $48, $46, $45, $43, $42, $40, $3F, $3E, $3C, $3A, $39, $38, $36, $35, $33, $31, $30, $2F, $2E
        .byte $68, $67, $65, $64, $62, $61, $5F, $5E, $5D, $5B, $5A, $58, $57, $55, $54, $53, $51, $4F, $4E, $4D, $4B ; $2F
        .byte $4A, $48, $47, $45, $44, $43, $41, $40, $3E, $3C, $3B, $3A, $39, $37, $35, $34, $32, $31, $30, $2F
        .byte $68, $67, $65, $64, $63, $62, $60, $5E, $5D, $5B, $5A, $59, $58, $56, $54, $53, $51, $50, $4F, $4E, $4C ; $30
        .byte $4A, $49, $47, $46, $45, $44, $42, $40, $3F, $3D, $3C, $3B, $3A, $38, $36, $35, $33, $32, $31, $30
        .byte $69, $67, $66, $64, $63, $62, $60, $5F, $5E, $5C, $5A, $59, $58, $56, $55, $54, $52, $51, $4F, $4E, $4C ; $31
        .byte $4B, $4A, $48, $47, $45, $44, $42, $41, $40, $3E, $3D, $3C, $3A, $39, $37, $36, $34, $33, $32, $31
        .byte $69, $68, $66, $65, $63, $62, $60, $5F, $5E, $5C, $5B, $5A, $59, $57, $55, $54, $52, $51, $50, $4F, $4D ; $32
        .byte $4C, $4A, $49, $47, $46, $45, $43, $42, $41, $3F, $3E, $3C, $3B, $39, $38, $37, $35, $34, $33, $32
        .byte $69, $68, $66, $65, $64, $63, $61, $60, $5E, $5D, $5B, $5A, $59, $57, $56, $55, $53, $52, $51, $4F, $4E ; $33
        .byte $4C, $4B, $49, $48, $47, $46, $44, $43, $42, $40, $3F, $3D, $3C, $3A, $39, $38, $36, $35, $34, $33
        .byte $6A, $68, $67, $65, $64, $63, $61, $60, $5F, $5D, $5C, $5B, $5A, $58, $57, $55, $54, $52, $51, $50, $4E ; $34
        .byte $4D, $4C, $4A, $49, $48, $47, $45, $44, $42, $41, $3F, $3E, $3D, $3B, $3A, $39, $37, $36, $35, $34
        .byte $6A, $69, $67, $66, $65, $63, $62, $60, $5F, $5E, $5C, $5B, $5A, $58, $57, $56, $54, $53, $52, $51, $4F ; $35
        .byte $4E, $4D, $4B, $4A, $48, $47, $45, $44, $43, $41, $40, $3F, $3E, $3C, $3B, $3A, $38, $37, $36, $35
        .byte $6A, $69, $67, $66, $65, $64, $62, $61, $60, $5E, $5D, $5C, $5B, $59, $58, $56, $55, $54, $52, $51, $50 ; $36
        .byte $4E, $4D, $4B, $4A, $49, $48, $46, $45, $44, $42, $41, $40, $3F, $3D, $3C, $3B, $39, $38, $37, $36
        .byte $6A, $69, $68, $66, $65, $64, $62, $61, $60, $5E, $5D, $5C, $5B, $59, $58, $57, $55, $54, $53, $52, $50 ; $37
        .byte $4F, $4E, $4C, $4B, $4A, $49, $47, $46, $45, $43, $42, $41, $40, $3E, $3D, $3C, $3A, $39, $38, $37
        .byte $6B, $6A, $68, $67, $66, $65, $63, $62, $61, $5F, $5E, $5D, $5C, $5A, $59, $58, $56, $55, $54, $53, $51 ; $38
        .byte $50, $4F, $4D, $4C, $4B, $4A, $48, $47, $46, $44, $43, $42, $41, $3F, $3E, $3D, $3B, $3A, $39, $38
        .byte $6B, $6A, $68, $67, $66, $65, $63, $62, $61, $5F, $5E, $5D, $5C, $5A, $59, $58, $56, $55, $54, $53, $51 ; $39
        .byte $50, $4F, $4E, $4C, $4B, $4A, $49, $47, $46, $45, $44, $42, $41, $40, $3F, $3D, $3C, $3B, $3A, $39
        .byte $6B, $6A, $69, $67, $66, $65, $64, $63, $61, $60, $5F, $5E, $5D, $5B, $5A, $59, $57, $56, $55, $54, $52 ; $3A
        .byte $51, $50, $4E, $4D, $4C, $4B, $49, $48, $47, $46, $44, $43, $42, $41, $40, $3E, $3D, $3C, $3B, $3A
        .byte $6C, $6A, $69, $68, $67, $66, $64, $63, $62, $60, $5F, $5E, $5D, $5B, $5A, $59, $58, $57, $55, $54, $53 ; $3B
        .byte $52, $51, $4F, $4E, $4D, $4C, $4A, $49, $48, $46, $45, $44, $43, $42, $40, $3F, $3E, $3D, $3C, $3B
        .byte $6C, $6B, $69, $68, $67, $66, $64, $63, $62, $61, $60, $5F, $5E, $5C, $5B, $5A, $58, $57, $56, $55, $53 ; $3C
        .byte $52, $51, $50, $4F, $4E, $4D, $4B, $4A, $49, $47, $46, $45, $44, $42, $41, $40, $3F, $3E, $3D, $3C
        .byte $6C, $6B, $6A, $68, $67, $66, $65, $64, $63, $61, $60, $5F, $5E, $5C, $5B, $5A, $59, $58, $57, $56, $54 ; $3D
        .byte $53, $52, $50, $4F, $4E, $4D, $4C, $4B, $4A, $48, $47, $46, $45, $43, $42, $41, $40, $3F, $3E, $3D
        .byte $6C, $6B, $6A, $69, $68, $67, $65, $64, $63, $62, $61, $60, $5F, $5D, $5C, $5B, $59, $58, $57, $56, $55 ; $3E
        .byte $54, $53, $51, $50, $4F, $4E, $4C, $4B, $4A, $49, $48, $47, $46, $44, $43, $42, $41, $40, $3F, $3E
        .byte $6D, $6C, $6A, $69, $68, $67, $66, $65, $64, $62, $61, $60, $5F, $5D, $5C, $5B, $5A, $59, $58, $57, $55 ; $3F
        .byte $54, $53, $52, $51, $50, $4F, $4D, $4C, $4B, $4A, $49, $48, $47, $45, $44, $43, $42, $41, $40, $3F
        .byte $6D, $6C, $6B, $6A, $69, $68, $66, $65, $64, $63, $62, $61, $60, $5E, $5D, $5C, $5B, $5A, $59, $58, $56 ; $40
        .byte $55, $54, $53, $52, $51, $50, $4E, $4D, $4C, $4B, $4A, $49, $48, $46, $45, $44, $43, $42, $41, $40
        .byte $6D, $6C, $6B, $6A, $69, $68, $66, $65, $64, $63, $62, $61, $60, $5F, $5E, $5D, $5B, $5A, $59, $58, $57 ; $41
        .byte $56, $55, $53, $52, $51, $50, $4F, $4E, $4D, $4B, $4A, $49, $48, $47, $46, $45, $43, $42, $41, $41
        .byte $6E, $6D, $6B, $6A, $69, $68, $67, $66, $65, $63, $62, $61, $61, $5F, $5E, $5D, $5C, $5B, $5A, $59, $57 ; $42
        .byte $56, $55, $54, $53, $52, $51, $50, $4F, $4E, $4C, $4B, $4A, $49, $48, $47, $46, $44, $43, $42, $42
        .byte $6E, $6D, $6B, $6B, $6A, $69, $67, $66, $65, $64, $63, $62, $61, $60, $5F, $5E, $5C, $5B, $5A, $59, $58 ; $43
        .byte $57, $56, $55, $54, $53, $52, $50, $4F, $4E, $4D, $4C, $4B, $4A, $49, $48, $47, $45, $44, $43, $43
        .byte $6E, $6D, $6C, $6B, $6A, $69, $68, $67, $66, $64, $63, $62, $62, $60, $5F, $5E, $5D, $5C, $5B, $5A, $59 ; $44
        .byte $58, $57, $55, $54, $53, $53, $51, $50, $4F, $4E, $4D, $4C, $4B, $4A, $49, $48, $46, $45, $44, $44
        .byte $6E, $6E, $6C, $6B, $6A, $69, $68, $67, $66, $65, $64, $63, $62, $61, $60, $5F, $5D, $5C, $5C, $5B, $59 ; $45
        .byte $58, $57, $56, $55, $54, $53, $52, $51, $50, $4F, $4E, $4D, $4C, $4A, $4A, $49, $47, $46, $45, $45
        .byte $6F, $6E, $6C, $6C, $6B, $6A, $68, $67, $67, $65, $64, $63, $63, $61, $60, $5F, $5E, $5D, $5C, $5B, $5A ; $46
        .byte $59, $58, $57, $56, $55, $54, $53, $52, $51, $4F, $4F, $4E, $4D, $4B, $4A, $4A, $48, $47, $46, $46
        .byte $6F, $6E, $6D, $6C, $6B, $6A, $69, $68, $67, $66, $65, $64, $63, $62, $61, $60, $5F, $5E, $5D, $5C, $5B ; $47
        .byte $5A, $59, $57, $57, $56, $55, $53, $53, $52, $50, $4F, $4F, $4E, $4C, $4B, $4B, $49, $48, $47, $47
        .byte $6F, $6E, $6D, $6C, $6B, $6B, $69, $68, $67, $66, $65, $64, $64, $62, $61, $60, $5F, $5E, $5D, $5D, $5B ; $48
        .byte $5A, $59, $58, $57, $56, $56, $54, $53, $52, $51, $50, $4F, $4F, $4D, $4C, $4B, $4A, $49, $48, $48
        .byte $70, $6F, $6D, $6D, $6C, $6B, $6A, $69, $68, $67, $66, $65, $64, $63, $62, $61, $60, $5F, $5E, $5D, $5C ; $49
        .byte $5B, $5A, $59, $58, $57, $56, $55, $54, $53, $52, $51, $50, $4F, $4E, $4D, $4C, $4B, $4A, $49, $49
        .byte $70, $6F, $6E, $6D, $6C, $6B, $6A, $69, $68, $67, $66, $65, $65, $63, $62, $62, $60, $5F, $5F, $5E, $5C ; $4A
        .byte $5C, $5B, $5A, $59, $58, $57, $56, $55, $54, $53, $52, $51, $50, $4F, $4E, $4D, $4C, $4B, $4A, $4A
        .byte $70, $6F, $6E, $6D, $6C, $6C, $6A, $6A, $69, $67, $67, $66, $65, $64, $63, $62, $61, $60, $5F, $5E, $5D ; $4B
        .byte $5C, $5B, $5A, $59, $59, $58, $57, $56, $55, $54, $53, $52, $51, $50, $4F, $4E, $4D, $4C, $4B, $4B
        .byte $70, $70, $6E, $6E, $6D, $6C, $6B, $6A, $69, $68, $67, $66, $66, $64, $63, $63, $61, $61, $60, $5F, $5E ; $4C
        .byte $5D, $5C, $5B, $5A, $59, $59, $57, $56, $56, $54, $54, $53, $52, $51, $50, $4F, $4E, $4D, $4C, $4C
        .byte $71, $70, $6F, $6E, $6D, $6C, $6B, $6A, $6A, $68, $68, $67, $66, $65, $64, $63, $62, $61, $60, $60, $5E ; $4D
        .byte $5E, $5D, $5C, $5B, $5A, $59, $58, $57, $56, $55, $54, $54, $53, $52, $51, $50, $4F, $4E, $4D, $4D
        .byte $71, $70, $6F, $6E, $6E, $6D, $6C, $6B, $6A, $69, $68, $67, $67, $65, $65, $64, $63, $62, $61, $60, $5F ; $4E
        .byte $5E, $5E, $5C, $5C, $5B, $5A, $59, $58, $57, $56, $55, $55, $54, $53, $52, $51, $50, $4F, $4E, $4E
        .byte $71, $71, $6F, $6F, $6E, $6D, $6C, $6B, $6A, $69, $69, $68, $67, $66, $65, $64, $63, $62, $62, $61, $60 ; $4F
        .byte $5F, $5E, $5D, $5C, $5C, $5B, $5A, $59, $58, $57, $56, $55, $55, $53, $53, $52, $51, $50, $4F, $4F
        .byte $72, $71, $70, $6F, $6E, $6E, $6C, $6C, $6B, $6A, $69, $68, $68, $66, $66, $65, $64, $63, $62, $62, $60 ; $50
        .byte $60, $5F, $5E, $5D, $5C, $5C, $5A, $5A, $59, $58, $57, $56, $56, $54, $54, $53, $52, $51, $50, $50
        .byte $72, $71, $70, $6F, $6F, $6E, $6D, $6C, $6B, $6A, $69, $69, $68, $67, $66, $65, $64, $64, $63, $62, $61 ; $51
        .byte $60, $60, $5E, $5E, $5D, $5C, $5B, $5A, $5A, $59, $58, $57, $56, $55, $55, $54, $53, $52, $51, $51
        .byte $72, $71, $70, $70, $6F, $6E, $6D, $6C, $6C, $6B, $6A, $69, $69, $67, $67, $66, $65, $64, $63, $63, $62 ; $52
        .byte $61, $60, $5F, $5E, $5E, $5D, $5C, $5B, $5A, $59, $59, $58, $57, $56, $55, $55, $54, $53, $52, $52
        .byte $72, $72, $71, $70, $6F, $6F, $6E, $6D, $6C, $6B, $6A, $6A, $69, $68, $67, $67, $65, $65, $64, $63, $62 ; $53
        .byte $62, $61, $60, $5F, $5E, $5E, $5D, $5C, $5B, $5A, $5A, $59, $58, $57, $56, $56, $55, $54, $53, $53
        .byte $73, $72, $71, $70, $70, $6F, $6E, $6D, $6D, $6C, $6B, $6A, $6A, $68, $68, $67, $66, $65, $65, $64, $63 ; $54
        .byte $62, $62, $61, $60, $5F, $5F, $5D, $5D, $5C, $5B, $5A, $5A, $59, $58, $57, $57, $56, $55, $54, $54
        .byte $73, $72, $71, $71, $70, $6F, $6E, $6E, $6D, $6C, $6B, $6B, $6A, $69, $68, $68, $67, $66, $65, $65, $64 ; $55
        .byte $63, $62, $61, $61, $60, $5F, $5E, $5E, $5D, $5C, $5B, $5B, $5A, $59, $58, $58, $57, $56, $55, $55
        .byte $73, $73, $72, $71, $70, $70, $6F, $6E, $6D, $6C, $6C, $6B, $6B, $6A, $69, $68, $67, $67, $66, $65, $64 ; $56
        .byte $64, $63, $62, $61, $61, $60, $5F, $5E, $5E, $5D, $5C, $5B, $5B, $5A, $59, $58, $57, $57, $56, $56
        .byte $74, $73, $72, $71, $71, $70, $6F, $6F, $6E, $6D, $6C, $6C, $6B, $6A, $69, $69, $68, $67, $67, $66, $65 ; $57
        .byte $64, $64, $63, $62, $61, $61, $60, $5F, $5F, $5E, $5D, $5C, $5C, $5B, $5A, $59, $58, $58, $57, $57
        .byte $74, $73, $72, $72, $71, $71, $70, $6F, $6E, $6D, $6D, $6C, $6C, $6B, $6A, $69, $68, $68, $67, $67, $66 ; $58
        .byte $65, $64, $63, $63, $62, $62, $61, $60, $5F, $5E, $5E, $5D, $5D, $5C, $5B, $5A, $59, $59, $58, $58
        .byte $74, $74, $73, $72, $71, $71, $70, $6F, $6F, $6E, $6D, $6D, $6C, $6B, $6A, $6A, $69, $68, $68, $67, $66 ; $59
        .byte $66, $65, $64, $63, $63, $62, $61, $61, $60, $5F, $5F, $5E, $5D, $5C, $5C, $5B, $5A, $5A, $59, $59
        .byte $75, $74, $73, $72, $72, $71, $70, $70, $6F, $6E, $6E, $6D, $6D, $6C, $6B, $6A, $6A, $69, $68, $68, $67 ; $5A
        .byte $66, $66, $65, $64, $64, $63, $62, $62, $61, $60, $5F, $5F, $5E, $5D, $5D, $5C, $5B, $5B, $5A, $5A
        .byte $75, $74, $73, $73, $72, $72, $71, $70, $70, $6F, $6E, $6E, $6D, $6C, $6C, $6B, $6A, $6A, $69, $68, $68 ; $5B
        .byte $67, $66, $65, $65, $64, $64, $63, $62, $62, $61, $60, $60, $5F, $5E, $5E, $5D, $5C, $5C, $5B, $5B
        .byte $75, $75, $74, $73, $73, $72, $71, $71, $70, $6F, $6F, $6E, $6E, $6D, $6C, $6C, $6B, $6A, $6A, $69, $68 ; $5C
        .byte $68, $67, $66, $66, $65, $65, $64, $63, $63, $62, $61, $61, $60, $5F, $5F, $5E, $5D, $5D, $5C, $5C
        .byte $75, $75, $74, $73, $73, $72, $72, $71, $70, $70, $6F, $6F, $6E, $6D, $6D, $6C, $6B, $6B, $6A, $6A, $69 ; $5D
        .byte $68, $68, $67, $66, $66, $65, $64, $64, $63, $63, $62, $61, $61, $60, $60, $5F, $5E, $5E, $5D, $5D
        .byte $76, $75, $74, $74, $73, $73, $72, $71, $71, $70, $70, $6F, $6F, $6E, $6D, $6D, $6C, $6B, $6B, $6A, $69 ; $5E
        .byte $69, $68, $68, $67, $67, $66, $65, $65, $64, $63, $63, $62, $62, $61, $60, $60, $5F, $5F, $5E, $5E
        .byte $76, $75, $75, $74, $74, $73, $72, $72, $71, $71, $70, $70, $6F, $6E, $6E, $6D, $6C, $6C, $6B, $6B, $6A ; $5F
        .byte $6A, $69, $68, $68, $67, $67, $66, $65, $65, $64, $64, $63, $63, $62, $61, $61, $60, $60, $5F, $5F
        .byte $76, $76, $75, $75, $74, $74, $73, $72, $72, $71, $71, $70, $70, $6F, $6E, $6E, $6D, $6D, $6C, $6C, $6B ; $60
        .byte $6A, $6A, $69, $69, $68, $68, $67, $66, $66, $65, $65, $64, $64, $63, $62, $62, $61, $61, $60, $60
        .byte $77, $76, $75, $75, $74, $74, $73, $73, $72, $71, $71, $70, $70, $6F, $6F, $6E, $6E, $6D, $6D, $6C, $6B ; $61
        .byte $6B, $6A, $6A, $69, $69, $68, $68, $67, $67, $66, $65, $65, $64, $64, $63, $63, $62, $61, $61, $61
        .byte $77, $76, $76, $75, $75, $74, $74, $73, $73, $72, $71, $71, $71, $70, $6F, $6F, $6E, $6E, $6D, $6D, $6C ; $62
        .byte $6C, $6B, $6A, $6A, $69, $69, $68, $68, $67, $67, $66, $66, $65, $65, $64, $64, $63, $62, $62, $62
        .byte $77, $77, $76, $76, $75, $75, $74, $73, $73, $72, $72, $71, $71, $70, $70, $6F, $6F, $6E, $6E, $6D, $6D ; $63
        .byte $6C, $6C, $6B, $6B, $6A, $6A, $69, $69, $68, $67, $67, $67, $66, $65, $65, $65, $64, $63, $63, $63
        .byte $77, $77, $76, $76, $75, $75, $74, $74, $73, $73, $72, $72, $72, $71, $70, $70, $6F, $6F, $6E, $6E, $6D ; $64
        .byte $6D, $6C, $6C, $6B, $6B, $6B, $6A, $69, $69, $68, $68, $67, $67, $66, $66, $65, $65, $64, $64, $64
        .byte $78, $77, $77, $76, $76, $75, $75, $74, $74, $73, $73, $72, $72, $71, $71, $71, $70, $6F, $6F, $6F, $6E ; $65
        .byte $6E, $6D, $6D, $6C, $6C, $6B, $6B, $6A, $6A, $69, $69, $68, $68, $67, $67, $66, $66, $65, $65, $65
        .byte $78, $78, $77, $77, $76, $76, $75, $75, $74, $74, $73, $73, $73, $72, $71, $71, $70, $70, $70, $6F, $6F ; $66
        .byte $6E, $6E, $6D, $6D, $6C, $6C, $6B, $6B, $6B, $6A, $6A, $69, $69, $68, $68, $67, $67, $66, $66, $66
        .byte $78, $78, $77, $77, $77, $76, $76, $75, $75, $74, $74, $73, $73, $72, $72, $72, $71, $71, $70, $70, $6F ; $67
        .byte $6F, $6F, $6E, $6E, $6D, $6D, $6C, $6C, $6B, $6B, $6A, $6A, $6A, $69, $69, $68, $68, $67, $67, $67
        .byte $79, $78, $78, $77, $77, $77, $76, $76, $75, $75, $74, $74, $74, $73, $73, $72, $72, $71, $71, $71, $70 ; $68
        .byte $70, $6F, $6F, $6E, $6E, $6E, $6D, $6D, $6C, $6C, $6B, $6B, $6B, $6A, $6A, $69, $69, $68, $68, $68
        .byte $79, $78, $78, $78, $77, $77, $76, $76, $76, $75, $75, $74, $74, $73, $73, $73, $72, $72, $71, $71, $71 ; $69
        .byte $70, $70, $6F, $6F, $6F, $6E, $6E, $6D, $6D, $6C, $6C, $6C, $6B, $6B, $6A, $6A, $6A, $69, $69, $69
        .byte $79, $79, $78, $78, $78, $77, $77, $76, $76, $76, $75, $75, $75, $74, $74, $73, $73, $72, $72, $72, $71 ; $6A
        .byte $71, $71, $70, $70, $6F, $6F, $6E, $6E, $6E, $6D, $6D, $6D, $6C, $6C, $6B, $6B, $6B, $6A, $6A, $6A
        .byte $79, $79, $79, $78, $78, $78, $77, $77, $76, $76, $76, $75, $75, $75, $74, $74, $73, $73, $73, $72, $72 ; $6B
        .byte $72, $71, $71, $70, $70, $70, $6F, $6F, $6F, $6E, $6E, $6D, $6D, $6D, $6C, $6C, $6B, $6B, $6B, $6B
        .byte $7A, $79, $79, $79, $78, $78, $78, $77, $77, $76, $76, $76, $76, $75, $75, $74, $74, $74, $73, $73, $73 ; $6C
        .byte $72, $72, $71, $71, $71, $71, $70, $70, $6F, $6F, $6F, $6E, $6E, $6E, $6D, $6D, $6C, $6C, $6C, $6C
        .byte $7A, $7A, $79, $79, $79, $78, $78, $78, $77, $77, $77, $76, $76, $76, $75, $75, $75, $74, $74, $74, $73 ; $6D
        .byte $73, $73, $72, $72, $72, $71, $71, $71, $70, $70, $6F, $6F, $6F, $6E, $6E, $6E, $6D, $6D, $6D, $6D
        .byte $7A, $7A, $7A, $79, $79, $79, $78, $78, $78, $77, $77, $77, $77, $76, $76, $76, $75, $75, $75, $74, $74 ; $6E
        .byte $74, $73, $73, $73, $72, $72, $72, $71, $71, $71, $70, $70, $70, $6F, $6F, $6F, $6E, $6E, $6E, $6E
        .byte $7B, $7A, $7A, $7A, $79, $79, $79, $78, $78, $78, $78, $77, $77, $77, $76, $76, $76, $75, $75, $75, $74 ; $6F
        .byte $74, $74, $74, $73, $73, $73, $72, $72, $72, $71, $71, $71, $71, $70, $70, $70, $6F, $6F, $6F, $6F
        .byte $7B, $7B, $7A, $7A, $7A, $7A, $79, $79, $79, $78, $78, $78, $78, $77, $77, $77, $76, $76, $76, $76, $75 ; $70
        .byte $75, $75, $74, $74, $74, $74, $73, $73, $73, $72, $72, $72, $72, $71, $71, $71, $70, $70, $70, $70
        .byte $7B, $7B, $7B, $7A, $7A, $7A, $7A, $79, $79, $79, $78, $78, $78, $78, $77, $77, $77, $77, $76, $76, $76 ; $71
        .byte $76, $75, $75, $75, $74, $74, $74, $74, $73, $73, $73, $73, $72, $72, $72, $72, $71, $71, $71, $71
        .byte $7B, $7B, $7B, $7B, $7A, $7A, $7A, $7A, $79, $79, $79, $79, $79, $78, $78, $78, $77, $77, $77, $77, $76 ; $72
        .byte $76, $76, $76, $75, $75, $75, $75, $74, $74, $74, $74, $73, $73, $73, $73, $72, $72, $72, $72, $72
        .byte $7C, $7C, $7B, $7B, $7B, $7B, $7A, $7A, $7A, $7A, $79, $79, $79, $79, $78, $78, $78, $78, $78, $77, $77 ; $73
        .byte $77, $77, $76, $76, $76, $76, $75, $75, $75, $75, $75, $74, $74, $74, $74, $73, $73, $73, $73, $73
        .byte $7C, $7C, $7C, $7B, $7B, $7B, $7B, $7B, $7A, $7A, $7A, $7A, $7A, $79, $79, $79, $79, $78, $78, $78, $78 ; $74
        .byte $78, $77, $77, $77, $77, $77, $76, $76, $76, $76, $75, $75, $75, $75, $75, $74, $74, $74, $74, $74
        .byte $7C, $7C, $7C, $7C, $7C, $7B, $7B, $7B, $7B, $7B, $7A, $7A, $7A, $7A, $7A, $79, $79, $79, $79, $79, $78 ; $75
        .byte $78, $78, $78, $78, $77, $77, $77, $77, $77, $76, $76, $76, $76, $76, $75, $75, $75, $75, $75, $75
        .byte $7D, $7C, $7C, $7C, $7C, $7C, $7C, $7B, $7B, $7B, $7B, $7B, $7B, $7A, $7A, $7A, $7A, $7A, $79, $79, $79 ; $76
        .byte $79, $79, $78, $78, $78, $78, $78, $78, $77, $77, $77, $77, $77, $77, $76, $76, $76, $76, $76, $76
        .byte $7D, $7D, $7D, $7C, $7C, $7C, $7C, $7C, $7C, $7B, $7B, $7B, $7B, $7B, $7B, $7B, $7A, $7A, $7A, $7A, $7A ; $77
        .byte $7A, $79, $79, $79, $79, $79, $79, $78, $78, $78, $78, $78, $78, $77, $77, $77, $77, $77, $77, $77
        .byte $7D, $7D, $7D, $7D, $7D, $7D, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7B, $7B, $7B, $7B, $7B, $7B, $7B, $7A ; $78
        .byte $7A, $7A, $7A, $7A, $7A, $7A, $79, $79, $79, $79, $79, $79, $79, $78, $78, $78, $78, $78, $78, $78
        .byte $7D, $7D, $7D, $7D, $7D, $7D, $7D, $7D, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7B, $7B, $7B, $7B, $7B ; $79
        .byte $7B, $7B, $7B, $7A, $7A, $7A, $7A, $7A, $7A, $7A, $7A, $79, $79, $79, $79, $79, $79, $79, $79, $79
        .byte $7E, $7E, $7E, $7D, $7D, $7D, $7D, $7D, $7D, $7D, $7D, $7D, $7D, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C ; $7A
        .byte $7C, $7B, $7B, $7B, $7B, $7B, $7B, $7B, $7B, $7B, $7A, $7A, $7A, $7A, $7A, $7A, $7A, $7A, $7A, $7A
        .byte $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7D, $7D, $7D, $7D, $7D, $7D, $7D, $7D, $7D, $7D, $7D, $7C, $7C, $7C ; $7B
        .byte $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7B, $7B, $7B, $7B, $7B, $7B, $7B, $7B, $7B, $7B, $7B, $7B
        .byte $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7D, $7D, $7D, $7D, $7D, $7D, $7D, $7D ; $7C
        .byte $7D, $7D, $7D, $7D, $7D, $7D, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C
        .byte $7F, $7F, $7F, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E ; $7D
        .byte $7E, $7D, $7D, $7D, $7D, $7D, $7D, $7D, $7D, $7D, $7D, $7D, $7D, $7D, $7D, $7D, $7D, $7D, $7D, $7D
        .byte $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E ; $7E
        .byte $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E
        .byte $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F ; $7F
        .byte $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F
        .byte $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80 ; $80
        .byte $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80
        .byte $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80 ; $81
        .byte $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $81
        .byte $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $81, $81, $81, $81, $81, $81, $81, $81, $81 ; $82
        .byte $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $82
        .byte $80, $80, $80, $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $81 ; $83
        .byte $81, $82, $82, $82, $82, $82, $82, $82, $82, $82, $82, $82, $82, $82, $82, $82, $82, $82, $82, $83
        .byte $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $82, $82, $82, $82, $82, $82, $82, $82, $82 ; $84
        .byte $82, $82, $82, $82, $82, $83, $83, $83, $83, $83, $83, $83, $83, $83, $83, $83, $83, $83, $83, $84
        .byte $81, $81, $81, $81, $81, $81, $81, $82, $82, $82, $82, $82, $82, $82, $82, $82, $82, $82, $83, $83, $83 ; $85
        .byte $83, $83, $83, $83, $83, $83, $83, $83, $84, $84, $84, $84, $84, $84, $84, $84, $84, $84, $84, $85
        .byte $81, $81, $81, $82, $82, $82, $82, $82, $82, $82, $82, $82, $83, $83, $83, $83, $83, $83, $83, $83, $83 ; $86
        .byte $83, $84, $84, $84, $84, $84, $84, $84, $84, $84, $85, $85, $85, $85, $85, $85, $85, $85, $85, $86
        .byte $82, $82, $82, $82, $82, $82, $82, $82, $83, $83, $83, $83, $83, $83, $83, $83, $84, $84, $84, $84, $84 ; $87
        .byte $84, $84, $84, $85, $85, $85, $85, $85, $85, $85, $85, $86, $86, $86, $86, $86, $86, $86, $86, $87
        .byte $82, $82, $82, $82, $82, $83, $83, $83, $83, $83, $83, $83, $84, $84, $84, $84, $84, $84, $84, $85, $85 ; $88
        .byte $85, $85, $85, $85, $85, $86, $86, $86, $86, $86, $86, $86, $87, $87, $87, $87, $87, $87, $87, $88
        .byte $82, $82, $82, $83, $83, $83, $83, $83, $83, $84, $84, $84, $84, $84, $84, $84, $85, $85, $85, $85, $85 ; $89
        .byte $85, $86, $86, $86, $86, $86, $86, $87, $87, $87, $87, $87, $87, $88, $88, $88, $88, $88, $88, $89
        .byte $82, $83, $83, $83, $83, $83, $83, $84, $84, $84, $84, $84, $85, $85, $85, $85, $85, $85, $86, $86, $86 ; $8A
        .byte $86, $86, $87, $87, $87, $87, $87, $87, $88, $88, $88, $88, $88, $88, $89, $89, $89, $89, $89, $8A
        .byte $83, $83, $83, $83, $83, $84, $84, $84, $84, $84, $85, $85, $85, $85, $85, $86, $86, $86, $86, $86, $87 ; $8B
        .byte $87, $87, $87, $87, $88, $88, $88, $88, $88, $89, $89, $89, $89, $89, $8A, $8A, $8A, $8A, $8A, $8B
        .byte $83, $83, $83, $84, $84, $84, $84, $84, $85, $85, $85, $85, $86, $86, $86, $86, $86, $87, $87, $87, $87 ; $8C
        .byte $87, $88, $88, $88, $88, $89, $89, $89, $89, $89, $8A, $8A, $8A, $8A, $8A, $8B, $8B, $8B, $8B, $8C
        .byte $83, $83, $84, $84, $84, $84, $85, $85, $85, $85, $86, $86, $86, $86, $87, $87, $87, $87, $87, $88, $88 ; $8D
        .byte $88, $88, $89, $89, $89, $89, $8A, $8A, $8A, $8A, $8A, $8B, $8B, $8B, $8B, $8C, $8C, $8C, $8C, $8D
        .byte $84, $84, $84, $84, $85, $85, $85, $85, $86, $86, $86, $86, $87, $87, $87, $87, $88, $88, $88, $88, $89 ; $8E
        .byte $89, $89, $89, $8A, $8A, $8A, $8A, $8B, $8B, $8B, $8B, $8C, $8C, $8C, $8C, $8D, $8D, $8D, $8D, $8E
        .byte $84, $84, $84, $85, $85, $85, $85, $86, $86, $86, $87, $87, $87, $87, $88, $88, $88, $88, $89, $89, $89 ; $8F
        .byte $89, $8A, $8A, $8A, $8B, $8B, $8B, $8B, $8C, $8C, $8C, $8C, $8D, $8D, $8D, $8D, $8E, $8E, $8E, $8F
        .byte $84, $84, $85, $85, $85, $86, $86, $86, $86, $87, $87, $87, $88, $88, $88, $88, $89, $89, $89, $8A, $8A ; $90
        .byte $8A, $8A, $8B, $8B, $8B, $8C, $8C, $8C, $8C, $8D, $8D, $8D, $8E, $8E, $8E, $8E, $8F, $8F, $8F, $90
        .byte $84, $85, $85, $85, $86, $86, $86, $87, $87, $87, $87, $88, $88, $88, $89, $89, $89, $8A, $8A, $8A, $8B ; $91
        .byte $8B, $8B, $8B, $8C, $8C, $8C, $8D, $8D, $8D, $8E, $8E, $8E, $8E, $8F, $8F, $8F, $90, $90, $90, $91
        .byte $85, $85, $85, $86, $86, $86, $87, $87, $87, $88, $88, $88, $89, $89, $89, $89, $8A, $8A, $8A, $8B, $8B ; $92
        .byte $8B, $8C, $8C, $8C, $8D, $8D, $8D, $8E, $8E, $8E, $8F, $8F, $8F, $90, $90, $90, $91, $91, $91, $92
        .byte $85, $85, $86, $86, $86, $87, $87, $87, $88, $88, $88, $89, $89, $89, $8A, $8A, $8A, $8B, $8B, $8B, $8C ; $93
        .byte $8C, $8C, $8D, $8D, $8D, $8E, $8E, $8E, $8F, $8F, $90, $90, $90, $91, $91, $91, $92, $92, $92, $93
        .byte $85, $86, $86, $86, $87, $87, $87, $88, $88, $89, $89, $89, $8A, $8A, $8A, $8B, $8B, $8B, $8C, $8C, $8C ; $94
        .byte $8D, $8D, $8E, $8E, $8E, $8F, $8F, $8F, $90, $90, $90, $91, $91, $91, $92, $92, $93, $93, $93, $94
        .byte $86, $86, $86, $87, $87, $87, $88, $88, $89, $89, $89, $8A, $8A, $8A, $8B, $8B, $8C, $8C, $8C, $8D, $8D ; $95
        .byte $8D, $8E, $8E, $8F, $8F, $8F, $90, $90, $90, $91, $91, $92, $92, $92, $93, $93, $94, $94, $94, $95
        .byte $86, $86, $87, $87, $87, $88, $88, $89, $89, $89, $8A, $8A, $8B, $8B, $8B, $8C, $8C, $8D, $8D, $8D, $8E ; $96
        .byte $8E, $8E, $8F, $8F, $90, $90, $91, $91, $91, $92, $92, $92, $93, $93, $94, $94, $94, $95, $95, $96
        .byte $86, $87, $87, $87, $88, $88, $89, $89, $89, $8A, $8A, $8B, $8B, $8C, $8C, $8C, $8D, $8D, $8E, $8E, $8E ; $97
        .byte $8F, $8F, $90, $90, $90, $91, $91, $92, $92, $93, $93, $93, $94, $94, $95, $95, $95, $96, $96, $97
        .byte $86, $87, $87, $88, $88, $89, $89, $89, $8A, $8A, $8B, $8B, $8C, $8C, $8C, $8D, $8D, $8E, $8E, $8F, $8F ; $98
        .byte $8F, $90, $90, $91, $91, $92, $92, $92, $93, $93, $94, $94, $95, $95, $95, $96, $96, $97, $97, $98
        .byte $87, $87, $88, $88, $88, $89, $89, $8A, $8A, $8B, $8B, $8C, $8C, $8D, $8D, $8D, $8E, $8E, $8F, $8F, $90 ; $99
        .byte $90, $90, $91, $91, $92, $92, $93, $93, $94, $94, $95, $95, $95, $96, $96, $97, $97, $98, $98, $99
        .byte $87, $87, $88, $88, $89, $89, $8A, $8A, $8B, $8B, $8C, $8C, $8D, $8D, $8E, $8E, $8F, $8F, $8F, $90, $90 ; $9A
        .byte $91, $91, $92, $92, $93, $93, $94, $94, $94, $95, $95, $96, $96, $97, $97, $98, $98, $99, $99, $9A
        .byte $87, $88, $88, $89, $89, $8A, $8A, $8B, $8B, $8C, $8C, $8D, $8D, $8E, $8E, $8E, $8F, $90, $90, $90, $91 ; $9B
        .byte $91, $92, $92, $93, $93, $94, $94, $95, $95, $96, $96, $97, $97, $98, $98, $99, $99, $9A, $9A, $9B
        .byte $88, $88, $89, $89, $8A, $8A, $8B, $8B, $8C, $8C, $8D, $8D, $8E, $8E, $8F, $8F, $90, $90, $91, $91, $92 ; $9C
        .byte $92, $93, $93, $94, $94, $95, $95, $96, $96, $97, $97, $98, $98, $99, $99, $9A, $9A, $9B, $9B, $9C
        .byte $88, $88, $89, $89, $8A, $8A, $8B, $8C, $8C, $8D, $8D, $8E, $8E, $8F, $8F, $90, $90, $91, $91, $92, $92 ; $9D
        .byte $93, $93, $94, $94, $95, $95, $96, $96, $97, $98, $98, $98, $99, $9A, $9A, $9A, $9B, $9C, $9C, $9D
        .byte $88, $89, $89, $8A, $8A, $8B, $8B, $8C, $8C, $8D, $8E, $8E, $8F, $8F, $90, $90, $91, $91, $92, $92, $93 ; $9E
        .byte $93, $94, $95, $95, $96, $96, $97, $97, $98, $98, $99, $99, $9A, $9A, $9B, $9B, $9C, $9D, $9D, $9E
        .byte $88, $89, $8A, $8A, $8B, $8B, $8C, $8C, $8D, $8E, $8E, $8F, $8F, $90, $90, $91, $91, $92, $92, $93, $94 ; $9F
        .byte $94, $95, $95, $96, $96, $97, $97, $98, $98, $99, $9A, $9A, $9B, $9B, $9C, $9C, $9D, $9E, $9E, $9F
        .byte $89, $89, $8A, $8B, $8B, $8C, $8C, $8D, $8D, $8E, $8F, $8F, $90, $90, $91, $91, $92, $93, $93, $94, $94 ; $A0
        .byte $95, $95, $96, $97, $97, $98, $98, $99, $99, $9A, $9B, $9B, $9C, $9C, $9D, $9D, $9E, $9F, $9F, $A0
        .byte $89, $8A, $8A, $8B, $8B, $8C, $8D, $8D, $8E, $8E, $8F, $8F, $90, $91, $91, $92, $93, $93, $94, $94, $95 ; $A1
        .byte $95, $96, $97, $97, $98, $98, $99, $9A, $9A, $9B, $9B, $9C, $9C, $9D, $9E, $9E, $9F, $9F, $A0, $A1
        .byte $89, $8A, $8B, $8B, $8C, $8C, $8D, $8E, $8E, $8F, $8F, $90, $91, $91, $92, $92, $93, $94, $94, $95, $96 ; $A2
        .byte $96, $97, $97, $98, $98, $99, $9A, $9A, $9B, $9C, $9C, $9D, $9D, $9E, $9F, $9F, $A0, $A0, $A1, $A2
        .byte $8A, $8A, $8B, $8C, $8C, $8D, $8D, $8E, $8F, $8F, $90, $90, $91, $92, $92, $93, $94, $94, $95, $95, $96 ; $A3
        .byte $97, $97, $98, $99, $99, $9A, $9B, $9B, $9C, $9C, $9D, $9E, $9E, $9F, $9F, $A0, $A1, $A1, $A2, $A3
        .byte $8A, $8A, $8B, $8C, $8C, $8D, $8E, $8E, $8F, $90, $90, $91, $92, $92, $93, $93, $94, $95, $95, $96, $97 ; $A4
        .byte $97, $98, $99, $99, $9A, $9B, $9B, $9C, $9C, $9D, $9E, $9E, $9F, $A0, $A0, $A1, $A2, $A2, $A3, $A4
        .byte $8A, $8B, $8C, $8C, $8D, $8D, $8E, $8F, $8F, $90, $91, $91, $92, $93, $93, $94, $95, $95, $96, $97, $97 ; $A5
        .byte $98, $99, $9A, $9A, $9B, $9B, $9C, $9D, $9D, $9E, $9F, $9F, $A0, $A1, $A1, $A2, $A3, $A3, $A4, $A5
        .byte $8A, $8B, $8C, $8D, $8D, $8E, $8F, $8F, $90, $91, $91, $92, $93, $93, $94, $95, $95, $96, $97, $97, $98 ; $A6
        .byte $99, $99, $9A, $9B, $9B, $9C, $9D, $9D, $9E, $9F, $A0, $A0, $A1, $A2, $A2, $A3, $A4, $A4, $A5, $A6
        .byte $8B, $8B, $8C, $8D, $8E, $8E, $8F, $90, $90, $91, $92, $92, $93, $94, $95, $95, $96, $97, $97, $98, $99 ; $A7
        .byte $99, $9A, $9B, $9C, $9C, $9D, $9E, $9E, $9F, $A0, $A0, $A1, $A2, $A3, $A3, $A4, $A5, $A5, $A6, $A7
        .byte $8B, $8C, $8D, $8D, $8E, $8F, $8F, $90, $91, $92, $92, $93, $94, $94, $95, $96, $97, $97, $98, $99, $99 ; $A8
        .byte $9A, $9B, $9C, $9C, $9D, $9E, $9E, $9F, $A0, $A1, $A1, $A2, $A3, $A3, $A4, $A5, $A6, $A6, $A7, $A8
        .byte $8B, $8C, $8D, $8E, $8E, $8F, $90, $90, $91, $92, $93, $93, $94, $95, $96, $96, $97, $98, $98, $99, $9A ; $A9
        .byte $9B, $9B, $9C, $9D, $9E, $9E, $9F, $A0, $A0, $A1, $A2, $A3, $A3, $A4, $A5, $A6, $A7, $A7, $A8, $A9
        .byte $8C, $8C, $8D, $8E, $8F, $8F, $90, $91, $92, $93, $93, $94, $95, $95, $96, $97, $98, $98, $99, $9A, $9B ; $AA
        .byte $9B, $9C, $9D, $9E, $9E, $9F, $A0, $A1, $A1, $A2, $A3, $A4, $A4, $A5, $A6, $A7, $A8, $A8, $A9, $AA
        .byte $8C, $8D, $8E, $8E, $8F, $90, $91, $91, $92, $93, $94, $94, $95, $96, $97, $97, $98, $99, $9A, $9A, $9B ; $AB
        .byte $9C, $9D, $9E, $9E, $9F, $A0, $A1, $A1, $A2, $A3, $A4, $A4, $A5, $A6, $A7, $A7, $A8, $A9, $AA, $AB
        .byte $8C, $8D, $8E, $8F, $8F, $90, $91, $92, $92, $93, $94, $95, $96, $97, $97, $98, $99, $9A, $9A, $9B, $9C ; $AC
        .byte $9D, $9D, $9E, $9F, $A0, $A1, $A2, $A2, $A3, $A4, $A5, $A5, $A6, $A7, $A8, $A8, $A9, $AA, $AB, $AC
        .byte $8D, $8D, $8E, $8F, $90, $90, $91, $92, $93, $94, $95, $95, $96, $97, $98, $98, $9A, $9A, $9B, $9C, $9D ; $AD
        .byte $9D, $9E, $9F, $A0, $A1, $A1, $A2, $A3, $A4, $A5, $A5, $A6, $A7, $A8, $A9, $A9, $AA, $AB, $AC, $AD
        .byte $8D, $8E, $8F, $8F, $90, $91, $92, $93, $93, $94, $95, $96, $97, $98, $98, $99, $9A, $9B, $9C, $9C, $9D ; $AE
        .byte $9E, $9F, $A0, $A1, $A1, $A2, $A3, $A4, $A5, $A6, $A6, $A7, $A8, $A9, $AA, $AA, $AB, $AC, $AD, $AE
        .byte $8D, $8E, $8F, $90, $90, $91, $92, $93, $94, $95, $96, $96, $97, $98, $99, $9A, $9B, $9B, $9C, $9D, $9E ; $AF
        .byte $9F, $9F, $A1, $A1, $A2, $A3, $A4, $A5, $A5, $A6, $A7, $A8, $A9, $AA, $AA, $AB, $AC, $AD, $AE, $AF
        .byte $8D, $8E, $8F, $90, $91, $92, $93, $93, $94, $95, $96, $97, $98, $99, $99, $9A, $9B, $9C, $9D, $9E, $9F ; $B0
        .byte $9F, $A0, $A1, $A2, $A3, $A4, $A5, $A5, $A6, $A7, $A8, $A9, $AA, $AB, $AB, $AC, $AD, $AE, $AF, $B0
        .byte $8E, $8E, $90, $90, $91, $92, $93, $94, $95, $96, $96, $97, $98, $99, $9A, $9B, $9C, $9D, $9D, $9E, $9F ; $B1
        .byte $A0, $A1, $A2, $A3, $A3, $A4, $A5, $A6, $A7, $A8, $A9, $AA, $AA, $AC, $AC, $AD, $AE, $AF, $B0, $B1
        .byte $8E, $8F, $90, $91, $91, $92, $93, $94, $95, $96, $97, $98, $99, $9A, $9A, $9B, $9C, $9D, $9E, $9F, $A0 ; $B2
        .byte $A1, $A1, $A3, $A3, $A4, $A5, $A6, $A7, $A8, $A9, $AA, $AA, $AB, $AC, $AD, $AE, $AF, $B0, $B1, $B2
        .byte $8E, $8F, $90, $91, $92, $93, $94, $95, $95, $97, $97, $98, $99, $9A, $9B, $9C, $9D, $9E, $9F, $9F, $A1 ; $B3
        .byte $A1, $A2, $A3, $A4, $A5, $A6, $A7, $A8, $A9, $AA, $AB, $AB, $AC, $AD, $AE, $AF, $B0, $B1, $B2, $B3
        .byte $8F, $8F, $91, $91, $92, $93, $94, $95, $96, $97, $98, $99, $9A, $9B, $9C, $9C, $9E, $9E, $9F, $A0, $A1 ; $B4
        .byte $A2, $A3, $A4, $A5, $A6, $A7, $A8, $A9, $A9, $AB, $AB, $AC, $AD, $AE, $AF, $B0, $B1, $B2, $B3, $B4
        .byte $8F, $90, $91, $92, $93, $93, $95, $95, $96, $98, $98, $99, $9A, $9B, $9C, $9D, $9E, $9F, $A0, $A1, $A2 ; $B5
        .byte $A3, $A4, $A5, $A6, $A6, $A7, $A8, $A9, $AA, $AB, $AC, $AD, $AE, $AF, $B0, $B1, $B2, $B3, $B4, $B5
        .byte $8F, $90, $91, $92, $93, $94, $95, $96, $97, $98, $99, $9A, $9B, $9C, $9D, $9D, $9F, $A0, $A0, $A1, $A3 ; $B6
        .byte $A3, $A4, $A5, $A6, $A7, $A8, $A9, $AA, $AB, $AC, $AD, $AE, $AF, $B0, $B1, $B2, $B3, $B4, $B5, $B6
        .byte $8F, $90, $92, $92, $93, $94, $95, $96, $97, $98, $99, $9A, $9B, $9C, $9D, $9E, $9F, $A0, $A1, $A2, $A3 ; $B7
        .byte $A4, $A5, $A6, $A7, $A8, $A9, $AA, $AB, $AC, $AD, $AE, $AF, $B0, $B1, $B2, $B3, $B4, $B5, $B6, $B7
        .byte $90, $91, $92, $93, $94, $95, $96, $97, $98, $99, $9A, $9B, $9C, $9D, $9E, $9F, $A0, $A1, $A2, $A3, $A4 ; $B8
        .byte $A5, $A6, $A7, $A8, $A9, $AA, $AB, $AC, $AD, $AE, $AF, $B0, $B1, $B2, $B3, $B4, $B5, $B6, $B7, $B8
        .byte $90, $91, $92, $93, $94, $95, $96, $97, $98, $99, $9A, $9B, $9C, $9D, $9E, $9F, $A0, $A1, $A2, $A3, $A4 ; $B9
        .byte $A5, $A6, $A8, $A8, $A9, $AA, $AC, $AC, $AD, $AF, $B0, $B0, $B1, $B3, $B4, $B4, $B6, $B7, $B8, $B9
        .byte $90, $91, $93, $93, $94, $95, $97, $98, $98, $9A, $9B, $9C, $9D, $9E, $9F, $A0, $A1, $A2, $A3, $A4, $A5 ; $BA
        .byte $A6, $A7, $A8, $A9, $AA, $AB, $AC, $AD, $AE, $B0, $B0, $B1, $B2, $B4, $B5, $B5, $B7, $B8, $B9, $BA
        .byte $91, $91, $93, $94, $95, $96, $97, $98, $99, $9A, $9B, $9C, $9D, $9E, $9F, $A0, $A2, $A3, $A3, $A4, $A6 ; $BB
        .byte $A7, $A8, $A9, $AA, $AB, $AC, $AD, $AE, $AF, $B0, $B1, $B2, $B3, $B5, $B5, $B6, $B8, $B9, $BA, $BB
        .byte $91, $92, $93, $94, $95, $96, $97, $98, $99, $9B, $9C, $9D, $9E, $9F, $A0, $A1, $A2, $A3, $A4, $A5, $A6 ; $BC
        .byte $A7, $A8, $AA, $AB, $AC, $AD, $AE, $AF, $B0, $B1, $B2, $B3, $B4, $B5, $B6, $B7, $B9, $BA, $BB, $BC
        .byte $91, $92, $94, $94, $95, $96, $98, $99, $9A, $9B, $9C, $9D, $9E, $9F, $A0, $A1, $A3, $A4, $A5, $A6, $A7 ; $BD
        .byte $A8, $A9, $AA, $AB, $AC, $AD, $AF, $B0, $B1, $B2, $B3, $B4, $B5, $B6, $B7, $B8, $BA, $BB, $BC, $BD
        .byte $91, $92, $94, $95, $96, $97, $98, $99, $9A, $9C, $9D, $9E, $9F, $A0, $A1, $A2, $A3, $A4, $A5, $A6, $A8 ; $BE
        .byte $A9, $AA, $AB, $AC, $AD, $AE, $AF, $B0, $B1, $B3, $B4, $B5, $B6, $B7, $B8, $B9, $BB, $BC, $BD, $BE
        .byte $92, $93, $94, $95, $96, $97, $99, $9A, $9B, $9C, $9D, $9E, $9F, $A0, $A1, $A2, $A4, $A5, $A6, $A7, $A8 ; $BF
        .byte $A9, $AA, $AC, $AD, $AE, $AF, $B0, $B1, $B2, $B4, $B5, $B6, $B7, $B8, $B9, $BA, $BC, $BD, $BE, $BF
        .byte $92, $93, $95, $96, $97, $98, $99, $9A, $9B, $9D, $9E, $9F, $A0, $A1, $A2, $A3, $A5, $A6, $A7, $A8, $A9 ; $C0
        .byte $AA, $AB, $AD, $AE, $AF, $B0, $B1, $B2, $B3, $B5, $B6, $B7, $B8, $B9, $BA, $BB, $BD, $BE, $BF, $C0
        .byte $92, $93, $95, $96, $97, $98, $99, $9A, $9B, $9D, $9E, $9F, $A0, $A2, $A3, $A4, $A5, $A6, $A7, $A8, $AA ; $C1
        .byte $AB, $AC, $AD, $AE, $AF, $B0, $B2, $B3, $B4, $B5, $B6, $B7, $B8, $BA, $BB, $BC, $BD, $BE, $BF, $C1
        .byte $93, $94, $95, $96, $97, $98, $9A, $9B, $9C, $9D, $9E, $9F, $A1, $A2, $A3, $A4, $A6, $A7, $A8, $A9, $AA ; $C2
        .byte $AB, $AC, $AE, $AF, $B0, $B1, $B3, $B4, $B5, $B6, $B7, $B8, $B9, $BB, $BC, $BD, $BE, $BF, $C0, $C2
        .byte $93, $94, $95, $97, $98, $99, $9A, $9B, $9C, $9E, $9F, $A0, $A1, $A3, $A4, $A5, $A6, $A7, $A8, $A9, $AB ; $C3
        .byte $AC, $AD, $AF, $B0, $B1, $B2, $B3, $B4, $B5, $B7, $B8, $B9, $BA, $BC, $BD, $BE, $BF, $C0, $C1, $C3
        .byte $93, $94, $96, $97, $98, $99, $9B, $9C, $9D, $9E, $9F, $A0, $A2, $A3, $A4, $A5, $A7, $A8, $A9, $AA, $AC ; $C4
        .byte $AD, $AE, $AF, $B0, $B1, $B3, $B4, $B5, $B6, $B8, $B9, $BA, $BB, $BD, $BE, $BF, $C0, $C1, $C2, $C4
        .byte $93, $95, $96, $97, $98, $99, $9B, $9C, $9D, $9F, $A0, $A1, $A2, $A4, $A5, $A6, $A7, $A8, $AA, $AB, $AC ; $C5
        .byte $AD, $AE, $B0, $B1, $B2, $B3, $B5, $B6, $B7, $B9, $BA, $BB, $BC, $BD, $BF, $C0, $C1, $C2, $C3, $C5
        .byte $94, $95, $96, $98, $99, $9A, $9B, $9C, $9E, $9F, $A0, $A1, $A3, $A4, $A5, $A6, $A8, $A9, $AA, $AB, $AD ; $C6
        .byte $AE, $AF, $B1, $B2, $B3, $B4, $B6, $B7, $B8, $B9, $BB, $BC, $BD, $BE, $BF, $C1, $C2, $C3, $C4, $C6
        .byte $94, $95, $97, $98, $99, $9A, $9C, $9D, $9E, $A0, $A1, $A2, $A3, $A5, $A6, $A7, $A9, $AA, $AB, $AC, $AE ; $C7
        .byte $AF, $B0, $B1, $B3, $B4, $B5, $B6, $B8, $B9, $BA, $BB, $BD, $BE, $BF, $C0, $C2, $C3, $C4, $C5, $C7
        .byte $94, $95, $97, $98, $99, $9B, $9C, $9D, $9E, $A0, $A1, $A2, $A4, $A5, $A6, $A7, $A9, $AA, $AB, $AD, $AE ; $C8
        .byte $AF, $B0, $B2, $B3, $B4, $B6, $B7, $B8, $B9, $BB, $BC, $BD, $BF, $C0, $C1, $C2, $C4, $C5, $C6, $C8
        .byte $95, $96, $97, $99, $9A, $9B, $9D, $9E, $9F, $A1, $A2, $A3, $A4, $A6, $A7, $A8, $AA, $AB, $AC, $AD, $AF ; $C9
        .byte $B0, $B1, $B3, $B4, $B5, $B6, $B8, $B9, $BA, $BC, $BD, $BE, $BF, $C1, $C2, $C3, $C5, $C6, $C7, $C9
        .byte $95, $96, $98, $99, $9A, $9B, $9D, $9E, $9F, $A1, $A2, $A3, $A5, $A6, $A7, $A9, $AA, $AB, $AD, $AE, $AF ; $CA
        .byte $B1, $B2, $B4, $B5, $B6, $B7, $B9, $BA, $BB, $BD, $BE, $BF, $C0, $C2, $C3, $C4, $C6, $C7, $C8, $CA
        .byte $95, $96, $98, $99, $9A, $9C, $9D, $9F, $A0, $A1, $A3, $A4, $A5, $A7, $A8, $A9, $AB, $AC, $AD, $AE, $B0 ; $CB
        .byte $B1, $B2, $B4, $B5, $B7, $B8, $BA, $BB, $BC, $BE, $BF, $C0, $C1, $C3, $C4, $C5, $C7, $C8, $C9, $CB
        .byte $95, $97, $98, $9A, $9B, $9C, $9E, $9F, $A0, $A2, $A3, $A4, $A6, $A7, $A8, $AA, $AB, $AD, $AE, $AF, $B1 ; $CC
        .byte $B2, $B3, $B5, $B6, $B7, $B9, $BA, $BB, $BD, $BE, $C0, $C1, $C2, $C4, $C5, $C6, $C8, $C9, $CA, $CC
        .byte $96, $97, $99, $9A, $9B, $9C, $9E, $9F, $A1, $A2, $A4, $A5, $A6, $A8, $A9, $AA, $AC, $AD, $AE, $B0, $B1 ; $CD
        .byte $B3, $B4, $B6, $B7, $B8, $B9, $BB, $BC, $BD, $BF, $C0, $C2, $C3, $C5, $C6, $C7, $C9, $CA, $CB, $CD
        .byte $96, $97, $99, $9A, $9C, $9D, $9F, $A0, $A1, $A3, $A4, $A5, $A7, $A8, $AA, $AB, $AD, $AE, $AF, $B0, $B2 ; $CE
        .byte $B3, $B5, $B6, $B8, $B9, $BA, $BC, $BD, $BE, $C0, $C1, $C3, $C4, $C6, $C7, $C8, $CA, $CB, $CC, $CE
        .byte $96, $98, $99, $9B, $9C, $9D, $9F, $A0, $A1, $A3, $A5, $A6, $A7, $A9, $AA, $AB, $AD, $AE, $B0, $B1, $B3 ; $CF
        .byte $B4, $B5, $B7, $B8, $BA, $BB, $BD, $BE, $BF, $C1, $C2, $C3, $C5, $C6, $C8, $C9, $CB, $CC, $CD, $CF
        .byte $97, $98, $9A, $9B, $9C, $9E, $9F, $A1, $A2, $A4, $A5, $A6, $A8, $A9, $AB, $AC, $AE, $AF, $B0, $B2, $B3 ; $D0
        .byte $B5, $B6, $B8, $B9, $BA, $BC, $BD, $BF, $C0, $C2, $C3, $C4, $C6, $C7, $C9, $CA, $CC, $CD, $CE, $D0
        .byte $97, $98, $9A, $9B, $9D, $9E, $A0, $A1, $A2, $A4, $A5, $A7, $A8, $AA, $AB, $AC, $AE, $B0, $B1, $B2, $B4 ; $D1
        .byte $B5, $B7, $B8, $BA, $BB, $BC, $BE, $BF, $C1, $C3, $C4, $C5, $C6, $C8, $CA, $CB, $CD, $CE, $CF, $D1
        .byte $97, $98, $9A, $9C, $9D, $9E, $A0, $A1, $A3, $A5, $A6, $A7, $A9, $AA, $AC, $AD, $AF, $B0, $B1, $B3, $B5 ; $D2
        .byte $B6, $B7, $B9, $BA, $BC, $BD, $BF, $C0, $C1, $C3, $C5, $C6, $C7, $C9, $CA, $CC, $CE, $CF, $D0, $D2
        .byte $97, $99, $9B, $9C, $9D, $9F, $A1, $A2, $A3, $A5, $A6, $A8, $A9, $AB, $AC, $AE, $AF, $B1, $B2, $B3, $B5 ; $D3
        .byte $B7, $B8, $BA, $BB, $BC, $BE, $C0, $C1, $C2, $C4, $C6, $C7, $C8, $CA, $CB, $CD, $CF, $D0, $D1, $D3
        .byte $98, $99, $9B, $9C, $9E, $9F, $A1, $A2, $A4, $A6, $A7, $A8, $AA, $AB, $AD, $AE, $B0, $B1, $B3, $B4, $B6 ; $D4
        .byte $B7, $B9, $BB, $BC, $BD, $BF, $C0, $C2, $C3, $C5, $C6, $C8, $C9, $CB, $CC, $CE, $D0, $D1, $D2, $D4
        .byte $98, $99, $9B, $9D, $9E, $9F, $A1, $A3, $A4, $A6, $A7, $A9, $AA, $AC, $AD, $AF, $B1, $B2, $B3, $B5, $B7 ; $D5
        .byte $B8, $B9, $BB, $BD, $BE, $BF, $C1, $C3, $C4, $C6, $C7, $C9, $CA, $CC, $CD, $CF, $D1, $D2, $D3, $D5
        .byte $98, $9A, $9C, $9D, $9E, $A0, $A2, $A3, $A4, $A6, $A8, $A9, $AB, $AD, $AE, $AF, $B1, $B3, $B4, $B5, $B7 ; $D6
        .byte $B9, $BA, $BC, $BD, $BF, $C0, $C2, $C3, $C5, $C7, $C8, $C9, $CB, $CD, $CE, $CF, $D1, $D3, $D4, $D6
        .byte $99, $9A, $9C, $9D, $9F, $A0, $A2, $A4, $A5, $A7, $A8, $AA, $AB, $AD, $AE, $B0, $B2, $B3, $B5, $B6, $B8 ; $D7
        .byte $B9, $BB, $BD, $BE, $BF, $C1, $C3, $C4, $C6, $C8, $C9, $CA, $CC, $CE, $CF, $D0, $D2, $D4, $D5, $D7
        .byte $99, $9A, $9C, $9E, $9F, $A1, $A3, $A4, $A5, $A7, $A9, $AA, $AC, $AE, $AF, $B0, $B2, $B4, $B5, $B7, $B9 ; $D8
        .byte $BA, $BB, $BD, $BF, $C0, $C2, $C4, $C5, $C6, $C8, $CA, $CB, $CD, $CF, $D0, $D1, $D3, $D5, $D6, $D8
        .byte $99, $9B, $9D, $9E, $9F, $A1, $A3, $A4, $A6, $A8, $A9, $AB, $AC, $AE, $AF, $B1, $B3, $B4, $B6, $B7, $B9 ; $D9
        .byte $BB, $BC, $BE, $BF, $C1, $C2, $C4, $C6, $C7, $C9, $CB, $CC, $CD, $CF, $D1, $D2, $D4, $D6, $D7, $D9
        .byte $9A, $9B, $9D, $9E, $A0, $A1, $A3, $A5, $A6, $A8, $AA, $AB, $AD, $AF, $B0, $B1, $B4, $B5, $B6, $B8, $BA ; $DA
        .byte $BB, $BD, $BF, $C0, $C2, $C3, $C5, $C7, $C8, $CA, $CB, $CD, $CE, $D0, $D2, $D3, $D5, $D7, $D8, $DA
        .byte $9A, $9B, $9D, $9F, $A0, $A2, $A4, $A5, $A7, $A9, $AA, $AC, $AD, $AF, $B1, $B2, $B4, $B6, $B7, $B8, $BB ; $DB
        .byte $BC, $BD, $BF, $C1, $C2, $C4, $C6, $C7, $C9, $CB, $CC, $CE, $CF, $D1, $D3, $D4, $D6, $D8, $D9, $DB
        .byte $9A, $9C, $9E, $9F, $A1, $A2, $A4, $A6, $A7, $A9, $AB, $AC, $AE, $B0, $B1, $B3, $B5, $B6, $B8, $B9, $BB ; $DC
        .byte $BD, $BE, $C0, $C2, $C3, $C5, $C7, $C8, $CA, $CC, $CD, $CF, $D0, $D2, $D4, $D5, $D7, $D9, $DA, $DC
        .byte $9A, $9C, $9E, $9F, $A1, $A2, $A5, $A6, $A7, $AA, $AB, $AD, $AE, $B0, $B2, $B3, $B5, $B7, $B8, $BA, $BC ; $DD
        .byte $BD, $BF, $C1, $C2, $C4, $C5, $C7, $C9, $CA, $CD, $CE, $CF, $D1, $D3, $D5, $D6, $D8, $DA, $DB, $DD
        .byte $9B, $9C, $9E, $A0, $A1, $A3, $A5, $A6, $A8, $AA, $AC, $AD, $AF, $B1, $B2, $B4, $B6, $B7, $B9, $BA, $BC ; $DE
        .byte $BE, $BF, $C2, $C3, $C5, $C6, $C8, $CA, $CB, $CD, $CF, $D0, $D2, $D4, $D5, $D7, $D9, $DB, $DC, $DE
        .byte $9B, $9C, $9F, $A0, $A2, $A3, $A5, $A7, $A8, $AB, $AC, $AE, $AF, $B1, $B3, $B4, $B6, $B8, $B9, $BB, $BD ; $DF
        .byte $BF, $C0, $C2, $C4, $C5, $C7, $C9, $CA, $CC, $CE, $D0, $D1, $D3, $D5, $D6, $D8, $DA, $DC, $DD, $DF
        .byte $9B, $9D, $9F, $A1, $A2, $A4, $A6, $A7, $A9, $AB, $AD, $AE, $B0, $B2, $B3, $B5, $B7, $B9, $BA, $BC, $BE ; $E0
        .byte $BF, $C1, $C3, $C5, $C6, $C8, $CA, $CB, $CD, $CF, $D1, $D2, $D4, $D6, $D7, $D9, $DB, $DD, $DE, $E0
        .byte $9C, $9D, $9F, $A1, $A2, $A4, $A6, $A8, $A9, $AB, $AD, $AE, $B0, $B2, $B4, $B5, $B8, $B9, $BB, $BC, $BE ; $E1
        .byte $C0, $C1, $C4, $C5, $C7, $C8, $CB, $CC, $CE, $D0, $D1, $D3, $D4, $D7, $D8, $DA, $DC, $DD, $DF, $E1
        .byte $9C, $9D, $A0, $A1, $A3, $A4, $A7, $A8, $AA, $AC, $AD, $AF, $B1, $B3, $B4, $B6, $B8, $BA, $BB, $BD, $BF ; $E2
        .byte $C1, $C2, $C4, $C6, $C7, $C9, $CB, $CD, $CE, $D1, $D2, $D4, $D5, $D8, $D9, $DB, $DD, $DE, $E0, $E2
        .byte $9C, $9E, $A0, $A2, $A3, $A5, $A7, $A8, $AA, $AC, $AE, $AF, $B1, $B3, $B5, $B6, $B9, $BA, $BC, $BD, $C0 ; $E3
        .byte $C1, $C3, $C5, $C7, $C8, $CA, $CC, $CE, $CF, $D1, $D3, $D5, $D6, $D8, $DA, $DC, $DE, $DF, $E1, $E3
        .byte $9C, $9E, $A0, $A2, $A3, $A5, $A7, $A9, $AA, $AD, $AE, $B0, $B2, $B4, $B5, $B7, $B9, $BB, $BC, $BE, $C0 ; $E4
        .byte $C2, $C3, $C6, $C7, $C9, $CB, $CD, $CE, $D0, $D2, $D4, $D5, $D7, $D9, $DB, $DC, $DF, $E0, $E2, $E4
        .byte $9D, $9E, $A1, $A2, $A4, $A5, $A8, $A9, $AB, $AD, $AF, $B0, $B2, $B4, $B6, $B8, $BA, $BB, $BD, $BF, $C1 ; $E5
        .byte $C3, $C4, $C7, $C8, $CA, $CB, $CE, $CF, $D1, $D3, $D5, $D6, $D8, $DA, $DC, $DD, $E0, $E1, $E3, $E5
        .byte $9D, $9F, $A1, $A3, $A4, $A6, $A8, $AA, $AB, $AE, $AF, $B1, $B3, $B5, $B6, $B8, $BA, $BC, $BE, $BF, $C2 ; $E6
        .byte $C3, $C5, $C7, $C9, $CA, $CC, $CE, $D0, $D2, $D4, $D6, $D7, $D9, $DB, $DD, $DE, $E1, $E2, $E4, $E6
        .byte $9D, $9F, $A1, $A3, $A5, $A6, $A9, $AA, $AC, $AE, $B0, $B1, $B3, $B5, $B7, $B9, $BB, $BD, $BE, $C0, $C2 ; $E7
        .byte $C4, $C6, $C8, $CA, $CB, $CD, $CF, $D1, $D2, $D5, $D6, $D8, $DA, $DC, $DE, $DF, $E2, $E3, $E5, $E7
        .byte $9E, $9F, $A2, $A3, $A5, $A7, $A9, $AB, $AC, $AF, $B0, $B2, $B4, $B6, $B8, $B9, $BC, $BD, $BF, $C1, $C3 ; $E8
        .byte $C5, $C6, $C9, $CA, $CC, $CE, $D0, $D2, $D3, $D6, $D7, $D9, $DB, $DD, $DF, $E0, $E3, $E4, $E6, $E8
        .byte $9E, $9F, $A2, $A4, $A5, $A7, $A9, $AB, $AD, $AF, $B1, $B2, $B4, $B6, $B8, $BA, $BC, $BE, $BF, $C1, $C4 ; $E9
        .byte $C5, $C7, $C9, $CB, $CD, $CE, $D1, $D2, $D4, $D6, $D8, $DA, $DB, $DE, $DF, $E1, $E4, $E5, $E7, $E9
        .byte $9E, $A0, $A2, $A4, $A6, $A7, $AA, $AB, $AD, $B0, $B1, $B3, $B5, $B7, $B9, $BA, $BD, $BE, $C0, $C2, $C4 ; $EA
        .byte $C6, $C8, $CA, $CC, $CD, $CF, $D1, $D3, $D5, $D7, $D9, $DB, $DC, $DF, $E0, $E2, $E5, $E6, $E8, $EA
        .byte $9E, $A0, $A3, $A4, $A6, $A8, $AA, $AC, $AD, $B0, $B2, $B3, $B5, $B8, $B9, $BB, $BD, $BF, $C1, $C2, $C5 ; $EB
        .byte $C7, $C8, $CB, $CC, $CE, $D0, $D2, $D4, $D6, $D8, $DA, $DB, $DD, $E0, $E1, $E3, $E5, $E7, $E9, $EB
        .byte $9F, $A0, $A3, $A5, $A6, $A8, $AB, $AC, $AE, $B0, $B2, $B4, $B6, $B8, $BA, $BB, $BE, $C0, $C1, $C3, $C6 ; $EC
        .byte $C7, $C9, $CB, $CD, $CF, $D1, $D3, $D5, $D6, $D9, $DB, $DC, $DE, $E1, $E2, $E4, $E6, $E8, $EA, $EC
        .byte $9F, $A1, $A3, $A5, $A7, $A8, $AB, $AD, $AE, $B1, $B3, $B4, $B6, $B9, $BA, $BC, $BF, $C0, $C2, $C4, $C6 ; $ED
        .byte $C8, $CA, $CC, $CE, $D0, $D1, $D4, $D6, $D7, $DA, $DB, $DD, $DF, $E1, $E3, $E5, $E7, $E9, $EB, $ED
        .byte $9F, $A1, $A4, $A5, $A7, $A9, $AB, $AD, $AF, $B1, $B3, $B5, $B7, $B9, $BB, $BD, $BF, $C1, $C3, $C4, $C7 ; $EE
        .byte $C9, $CA, $CD, $CF, $D0, $D2, $D5, $D6, $D8, $DB, $DC, $DE, $E0, $E2, $E4, $E6, $E8, $EA, $EC, $EE
        .byte $A0, $A1, $A4, $A6, $A7, $A9, $AC, $AD, $AF, $B2, $B4, $B5, $B7, $BA, $BB, $BD, $C0, $C1, $C3, $C5, $C7 ; $EF
        .byte $C9, $CB, $CE, $CF, $D1, $D3, $D5, $D7, $D9, $DB, $DD, $DF, $E1, $E3, $E5, $E7, $E9, $EB, $ED, $EF
        .byte $A0, $A2, $A4, $A6, $A8, $AA, $AC, $AE, $B0, $B2, $B4, $B6, $B8, $BA, $BC, $BE, $C0, $C2, $C4, $C6, $C8 ; $F0
        .byte $CA, $CC, $CE, $D0, $D2, $D4, $D6, $D8, $DA, $DC, $DE, $E0, $E2, $E4, $E6, $E8, $EA, $EC, $EE, $F0
        .byte $A0, $A2, $A5, $A6, $A8, $AA, $AD, $AE, $B0, $B3, $B4, $B6, $B8, $BB, $BC, $BE, $C1, $C3, $C4, $C6, $C9 ; $F1
        .byte $CB, $CC, $CF, $D1, $D2, $D4, $D7, $D9, $DA, $DD, $DF, $E1, $E2, $E5, $E7, $E9, $EB, $ED, $EF, $F1
        .byte $A0, $A2, $A5, $A7, $A8, $AA, $AD, $AF, $B0, $B3, $B5, $B7, $B9, $BB, $BD, $BF, $C1, $C3, $C5, $C7, $C9 ; $F2
        .byte $CB, $CD, $D0, $D1, $D3, $D5, $D8, $D9, $DB, $DE, $E0, $E1, $E3, $E6, $E8, $E9, $EC, $EE, $F0, $F2
        .byte $A1, $A3, $A5, $A7, $A9, $AB, $AD, $AF, $B1, $B4, $B5, $B7, $B9, $BC, $BD, $BF, $C2, $C4, $C6, $C7, $CA ; $F3
        .byte $CC, $CE, $D0, $D2, $D4, $D6, $D8, $DA, $DC, $DF, $E1, $E2, $E4, $E7, $E9, $EA, $ED, $EF, $F1, $F3
        .byte $A1, $A3, $A6, $A7, $A9, $AB, $AE, $B0, $B1, $B4, $B6, $B8, $BA, $BC, $BE, $C0, $C3, $C4, $C6, $C8, $CB ; $F4
        .byte $CD, $CE, $D1, $D3, $D5, $D7, $D9, $DB, $DD, $E0, $E1, $E3, $E5, $E8, $EA, $EB, $EE, $F0, $F2, $F4
        .byte $A1, $A3, $A6, $A8, $AA, $AB, $AE, $B0, $B2, $B5, $B6, $B8, $BA, $BD, $BF, $C0, $C3, $C5, $C7, $C9, $CB ; $F5
        .byte $CD, $CF, $D2, $D4, $D5, $D7, $DA, $DC, $DE, $E0, $E2, $E4, $E6, $E9, $EA, $EC, $EF, $F1, $F3, $F5
        .byte $A2, $A3, $A6, $A8, $AA, $AC, $AF, $B0, $B2, $B5, $B7, $B9, $BB, $BD, $BF, $C1, $C4, $C6, $C7, $C9, $CC ; $F6
        .byte $CE, $D0, $D2, $D4, $D6, $D8, $DB, $DD, $DE, $E1, $E3, $E5, $E7, $EA, $EB, $ED, $F0, $F2, $F4, $F6
        .byte $A2, $A4, $A7, $A8, $AA, $AC, $AF, $B1, $B3, $B5, $B7, $B9, $BB, $BE, $C0, $C2, $C4, $C6, $C8, $CA, $CD ; $F7
        .byte $CF, $D0, $D3, $D5, $D7, $D9, $DC, $DD, $DF, $E2, $E4, $E6, $E8, $EA, $EC, $EE, $F1, $F3, $F5, $F7
        .byte $A2, $A4, $A7, $A9, $AB, $AD, $AF, $B1, $B3, $B6, $B8, $BA, $BC, $BE, $C0, $C2, $C5, $C7, $C9, $CB, $CD ; $F8
        .byte $CF, $D1, $D4, $D6, $D8, $DA, $DC, $DE, $E0, $E3, $E5, $E7, $E9, $EB, $ED, $EF, $F2, $F4, $F6, $F8
        .byte $A2, $A4, $A7, $A9, $AB, $AD, $B0, $B2, $B3, $B6, $B8, $BA, $BC, $BF, $C1, $C3, $C5, $C7, $C9, $CB, $CE ; $F9
        .byte $D0, $D2, $D5, $D6, $D8, $DA, $DD, $DF, $E1, $E4, $E6, $E7, $E9, $EC, $EE, $F0, $F3, $F5, $F7, $F9
        .byte $A3, $A5, $A8, $A9, $AB, $AD, $B0, $B2, $B4, $B7, $B9, $BB, $BD, $BF, $C1, $C3, $C6, $C8, $CA, $CC, $CF ; $FA
        .byte $D1, $D2, $D5, $D7, $D9, $DB, $DE, $E0, $E2, $E5, $E6, $E8, $EA, $ED, $EF, $F1, $F4, $F6, $F8, $FA
        .byte $A3, $A5, $A8, $AA, $AC, $AE, $B1, $B2, $B4, $B7, $B9, $BB, $BD, $C0, $C2, $C4, $C7, $C9, $CA, $CC, $CF ; $FB
        .byte $D1, $D3, $D6, $D8, $DA, $DC, $DF, $E1, $E2, $E5, $E7, $E9, $EB, $EE, $F0, $F2, $F5, $F7, $F9, $FB
        .byte $A3, $A5, $A8, $AA, $AC, $AE, $B1, $B3, $B5, $B8, $BA, $BC, $BE, $C0, $C2, $C4, $C7, $C9, $CB, $CD, $D0 ; $FC
        .byte $D2, $D4, $D7, $D9, $DB, $DD, $DF, $E1, $E3, $E6, $E8, $EA, $EC, $EF, $F1, $F3, $F6, $F8, $FA, $FC
        .byte $A4, $A6, $A9, $AA, $AC, $AE, $B1, $B3, $B5, $B8, $BA, $BC, $BE, $C1, $C3, $C5, $C8, $CA, $CC, $CE, $D1 ; $FD
        .byte $D3, $D4, $D7, $D9, $DB, $DD, $E0, $E2, $E4, $E7, $E9, $EB, $ED, $F0, $F2, $F4, $F7, $F9, $FB, $FD
        .byte $A4, $A6, $A9, $AB, $AD, $AF, $B2, $B4, $B6, $B9, $BB, $BD, $BF, $C1, $C3, $C5, $C8, $CA, $CC, $CE, $D1 ; $FE
        .byte $D3, $D5, $D8, $DA, $DC, $DE, $E1, $E3, $E5, $E8, $EA, $EC, $EE, $F1, $F3, $F5, $F8, $FA, $FC, $FE
        .byte $A4, $A6, $A9, $AB, $AD, $AF, $B2, $B4, $B6, $B9, $BB, $BD, $BF, $C2, $C4, $C6, $C9, $CB, $CD, $CF, $D2 ; $FF
        .byte $D4, $D6, $D9, $DB, $DD, $DF, $E2, $E4, $E6, $E9, $EB, $ED, $EF, $F2, $F4, $F6, $F9, $FB, $FD, $FF

        ; 98/A900

    .endsection Data988000Section


    .section Data98AAA1Section

      .al
      .xl

      aBattleSceneNoForegroundList ; 98/AAA1

        ; Read by rsBattleSceneCheckNoForeground.

        .byte $09, $0B, $0C, $0F, $10, $11, $12, $13, $3A, $3B, $3C, $3D, $3E, $3F, $40, $41
        .byte $42, $43, $44, $45, $46, $47, $48, $49, $4A, $4B, $4C, $4D, $4E, $4F, $50, $51
        .byte $52, $53, $54, $58, $59, $5A, $5B, $5C, $5D, $5E, $5F, $60, $61, $62, $63, $64
        .byte $65, $66, $FF

        ; 98/AAD4

      aBattleAnimationEffectPaths ; 98/AAD4

        ; Read by rsBattleAnimationFollowEffectPath.

        .word $03F8, $02F8, $01F8, $01F8, $02F8, $00F8, $00F8, $01F8
        .word $01F8, $00F8, $FFF8, $00F8, $00F8, $FFF8, $FFF8, $FEF8
        .word $FEF9, $FDF9, $FCFA, $FCFB, $FDFC, $FCFD, $FDFE, $FEFF
        .word $FEFF, $FEFF, $FE00, $FEFF, $FE00, $FE00, $FE00, $FE01
        .word $FE00, $FE01, $FE01, $FE01, $FE02, $FE02, $FF03, $FF03
        .word $FF04, $0004, $0005, $0105, $0105, $0105, $0106, $0106
        .word $0106, $0206, $0206, $0206, $0206, $0206, $0206, $0206
        .word $0306, $0206, $0306, $0306, $0306, $0306, $0306, $0306
        .word $0306, $0306, $0306, $8080

        ; 98/AB5C

      aBattleAnimationEffectPathScripts ; 98/AB5C

        ; Read by rsBattleAnimationRunEffectPathScript.

        .word $FCF8, $FCF8, $FCF8, $FCF8, $FCF8, $FCF8, $FCF8, $FCF8
        .word $FCF8, $FCF8, $FCF8, $FCF8, $FCF8, $FCF8, $FCF8, $FCF8
        .word $8082, $FCF8, $FCF8, $FCF8, $FCF8, $FCF8, $FCF8, $FCF8
        .word $FCF8, $FCF8, $FCF8, $FCF8, $FCF8, $FCF8, $FCF8, $FCF8
        .word $FCF8, $8081, $8084, $04F8, $04F8, $04F8, $04F8, $04F8
        .word $04F8, $04F8, $04F8, $04F8, $04F8, $04F8, $04F8, $04F8
        .word $04F8, $04F8, $04F8, $8083, $04F8, $04F8, $04F8, $04F8
        .word $04F8, $04F8, $04F8, $04F8, $04F8, $04F8, $04F8, $04F8
        .word $04F8, $04F8, $04F8, $04F8, $04F8, $04F8, $04F8, $04F8
        .word $8085, $04F8, $04F8, $04F8, $04F8, $8080, $F1D0, $00E3

        ; 98/ABFC

      aBattleSceneWindowScrollInitValues ; 98/ABFC

        ; Read by rlBattleSceneInitWindowScrollVars.

        .word $E0E0, $E0E0, $E0E0, $E1E1, $E1E1, $E1E1, $E2E2, $E2E2
        .word $E2E2, $E3E3, $E3E3, $E3E3, $E4E4, $E4E4, $E4E4, $E5E5
        .word $E5E5, $E5E5, $E6E6, $E6E6, $E6E6, $E7E7, $E7E7, $E7E7
        .word $E8E8, $E8E8, $E8E8, $E9E9, $E9E9, $E9E9, $EAEA, $EAEA
        .word $EAEA, $EBEB, $EBEB, $EBEB, $EBEB, $ECEC, $ECEC, $ECEC

        ; 98/AC4C

      aBattleSceneExpWindowScrollSteps ; 98/AC4C

        ; Read by rlBattleSceneUpdateExpWindowScroll.

        .byte $E0, $E0, $E0, $E0, $E1, $E1, $E1, $E2, $E2, $E2, $E2, $E3, $E3, $E3, $E4, $E4
        .byte $E4, $E4, $E5, $E5, $E5, $E6, $E6, $E6, $E6, $E7, $E7, $E7, $E8, $E8, $E8, $E8
        .byte $E9, $E9, $E9, $EA, $EA, $EA, $EA, $EB, $FF, $FF, $00, $80, $00, $40, $00, $20
        .byte $00, $10, $00, $08, $00, $04, $00, $02, $00, $01

        ; 98/AC86

      aBattleSceneHUDStats ; 98/AC86

        ; The numbers rsBattleSceneDrawStats draws in the HUD's tilemap
        ; ($7FD0C0): the offset in the tilemap, then the stat's address.
        ; Combatant 1's five in palette 3, combatant 2's in palette 1.

        .word $0A62
        .long aActionStructUnit1.CurrentHP
        .word $0AF6
        .long aActionStructUnit1.Level
        .word $0AAA
        .long aActionStructUnit1.BattleAdjustedHit
        .word $0AEA
        .long aActionStructUnit1.BattleMight
        .word $0AB6
        .long aActionStructUnit1.BattleDefense
        .word $0A44
        .long aActionStructUnit2.CurrentHP
        .word $0AD8
        .long aActionStructUnit2.Level
        .word $0A8C
        .long aActionStructUnit2.BattleAdjustedHit
        .word $0ACC
        .long aActionStructUnit2.BattleMight
        .word $0A98
        .long aActionStructUnit2.BattleDefense

        ; 98/ACB8

      aBattleSceneGaugeEndTiles ; 98/ACB8

        ; Read by rlBattleSceneDrawGauge.

        .word $2123, $1A1E, $0F15, $0008

        ; 98/ACC0

    .endsection Data98AAA1Section


    .section Data98AFFDSection

      .al
      .xl

      aBattleAnimationEffectStarts ; 98/AFFD

        ; Read by rlBattleAnimationGetEffectStart: where a combatant's effect (an
        ; arrow, a thrown weapon) appears, by its class. Three lists by weapon
        ; category, each ending in $FFFF; an entry is the class (a word), then the X
        ; offset toward the opponent and the Y offset.

        _Bows ; every other weapon category: the bow users

          .word BowKnight
          .char -24, $1A
          .word MasterKnight
          .char -24, $1A
          .word ArchKnight
          .char -24, $1A
          .word Archer
          .char -24, $14
          .word Sniper
          .char -24, $14
          .word General
          .char -24, $17
          .word Emperor
          .char -24, $17
          .word Baron
          .char -24, $17
          .word BowArmor
          .char -24, $17
          .word Warrior
          .char -24, $12
          .word Hunter
          .char -24, $12
          .word Ballistician
          .char -13, $29
          .word IronBallistician
          .char -13, $29
          .word KillerBallistician
          .char -13, $29
          .word GreatBallistician
          .char -13, $29
          .word $FFFF

        _HandAxes ; AnimCategoryRangedAxe

          .word AxeKnight
          .char -24, $1A
          .word MasterKnight
          .char -24, $1A
          .word GreatKnight
          .char -24, $1A
          .word General
          .char -30, $04
          .word Emperor
          .char -30, $04
          .word Baron
          .char -30, $04
          .word AxeArmor
          .char -30, $02
          .word Barbarian
          .char -32, $06
          .word Fighter
          .char -32, $06
          .word Brigand
          .char -32, $06
          .word Warrior
          .char -32, $06
          .word Pirate
          .char -32, $06
          .word $FFFF

        _Javelins ; AnimCategoryRangedLance

          .word Cavalier
          .char -24, $30
          .word LanceKnight
          .char -24, $30
          .word KnightLord
          .char -24, $30
          .word DukeKnight
          .char -24, $30
          .word MasterKnight
          .char -24, $30
          .word Paladin
          .char -24, $30
          .word PaladinF
          .char -24, $30
          .word PegasusRider
          .char -24, $32
          .word PegasusKnight
          .char -24, $32
          .word FalconKnight
          .char -24, $32
          .word Dragonrider
          .char -24, $35
          .word Dragonknight
          .char -24, $35
          .word Dragonmaster
          .char -24, $35
          .word General
          .char -24, $1A
          .word Emperor
          .char -24, $1A
          .word Baron
          .char -24, $1A
          .word LanceArmor
          .char -24, $1F
          .word $FFFF

        ; 98/B0B3

      aBattleSceneBrightenBlueSteps ; 98/B0B3

        ; Read by rsBattleSceneBrightenColorBy.

        .word $0000, $0400, $0800, $0C00, $1000, $1400, $1800, $1C00
        .word $2000, $2400, $2800, $2C00, $3000, $3400, $3800, $3C00
        .word $4000, $4400, $4800, $4C00, $5000, $5400, $5800, $5C00
        .word $6000, $6400, $6800, $6C00, $7000, $7400, $7800, $7C00

        ; 98/B0F3

      aBattleSceneBrightenGreenSteps ; 98/B0F3

        ; Read by rsBattleSceneBrightenColorBy.

        .word $0000, $0020, $0040, $0060, $0080, $00A0, $00C0, $00E0
        .word $0100, $0120, $0140, $0160, $0180, $01A0, $01C0, $01E0
        .word $0200, $0220, $0240, $0260, $0280, $02A0, $02C0, $02E0
        .word $0300, $0320, $0340, $0360, $0380, $03A0, $03C0, $03E0

        ; 98/B133

      aBattleSceneBrightenRedSteps ; 98/B133

        ; Read by rsBattleSceneBrightenColorBy.

        .word $0000, $0001, $0002, $0003, $0004, $0005, $0006, $0007
        .word $0008, $0009, $000A, $000B, $000C, $000D, $000E, $000F
        .word $0010, $0011, $0012, $0013, $0014, $0015, $0016, $0017
        .word $0018, $0019, $001A, $001B, $001C, $001D, $001E, $001F

        ; 98/B173

      aBattleSceneHitEffectSpriteMotion ; 98/B173

        ; Read by rsBattleSceneStepHitEffectSprites.

        .word $0010, $FFE0, $0010, $0010, $000C, $FFF4, $000C, $000C
        .word $0008, $FFF8, $0008, $0008, $0005, $FFFB, $0005, $0005
        .word $0003, $FFFD, $0003, $0003, $0000, $0080, $0001, $FFFF
        .word $0001, $0001, $0000, $0080, $0000, $0000, $0000, $0080
        .word $0000, $0000, $0000, $0080, $0000, $0000, $0000, $0080
        .word $0000, $0000, $0000, $0080, $0000, $0000, $0000, $0080
        .word $0000, $0000, $0000, $0080, $0000, $0000, $0000, $0080
        .word $0000, $0000, $0000, $0080, $0000, $0000, $0000, $0080
        .word $0000, $0000, $0000, $0080, $0000, $0000, $0000, $0080
        .word $0000, $0000, $0000, $0080, $0000, $0080, $0000, $0000
        .word $8080, $0201, $0202, $0203, $0204, $0205, $0206, $0207
        .word $0208, $0209, $020A, $040B, $040C, $040D, $FFFF

        ; 98/B231

    .endsection Data98AFFDSection


    .section Table98B231Section

      .al
      .xl

      aBattleSceneDodgeMissSprites ; 98/B231

        ; Read by rsBattleSceneStepDodgeOrMissSprites.

        .word _B231_B24B - aBattleSceneDodgeMissSprites
        .word _B231_B257 - aBattleSceneDodgeMissSprites
        .word _B231_B263 - aBattleSceneDodgeMissSprites
        .word _B231_B26F - aBattleSceneDodgeMissSprites
        .word _B231_B27B - aBattleSceneDodgeMissSprites
        .word _B231_B28C - aBattleSceneDodgeMissSprites
        .word _B231_B298 - aBattleSceneDodgeMissSprites
        .word _B231_B2A9 - aBattleSceneDodgeMissSprites
        .word _B231_B2B5 - aBattleSceneDodgeMissSprites
        .word _B231_B2C6 - aBattleSceneDodgeMissSprites
        .word _B231_B2D7 - aBattleSceneDodgeMissSprites
        .word _B231_B2E8 - aBattleSceneDodgeMissSprites
        .word _B231_B2F4 - aBattleSceneDodgeMissSprites

      _B231_B24B ; 98/B24B
        .byte $02, $00, $00, $00, $F0, $7C, $36, $F8, $01, $F8, $7C, $36

      _B231_B257 ; 98/B257
        .byte $02, $00, $00, $00, $F0, $7B, $36, $F8, $01, $F8, $7B, $36

      _B231_B263 ; 98/B263
        .byte $02, $00, $F8, $01, $F8, $7C, $36, $00, $00, $F0, $7B, $36

      _B231_B26F ; 98/B26F
        .byte $02, $00, $00, $00, $F0, $7C, $36, $F8, $01, $E8, $7C, $36

      _B231_B27B ; 98/B27B
        .byte $03, $00, $00, $00, $F8, $7C, $36, $00, $00, $E0, $7C, $36, $F8, $01, $E8, $7C
        .byte $36

      _B231_B28C ; 98/B28C
        .byte $02, $00, $00, $00, $F8, $7B, $36, $00, $00, $E0, $7B, $36

      _B231_B298 ; 98/B298
        .byte $03, $00, $00, $00, $F8, $7C, $36, $F8, $01, $E0, $7C, $36, $00, $00, $E0, $7C
        .byte $36

      _B231_B2A9 ; 98/B2A9
        .byte $02, $00, $F8, $01, $F0, $7C, $36, $F8, $01, $E0, $7B, $36

      _B231_B2B5 ; 98/B2B5
        .byte $03, $00, $F8, $01, $F0, $7B, $36, $00, $00, $D8, $7C, $36, $F8, $01, $E0, $7C
        .byte $36

      _B231_B2C6 ; 98/B2C6
        .byte $03, $00, $F8, $01, $F0, $7C, $36, $F8, $01, $D0, $7C, $36, $00, $00, $D8, $7B
        .byte $36

      _B231_B2D7 ; 98/B2D7
        .byte $03, $00, $00, $00, $E8, $7C, $36, $00, $00, $D8, $7C, $36, $F8, $01, $D0, $7B
        .byte $36

      _B231_B2E8 ; 98/B2E8
        .byte $02, $00, $08, $00, $E8, $7B, $36, $00, $00, $D0, $7C, $36

      _B231_B2F4 ; 98/B2F4
        .byte $01, $00, $08, $00, $E8, $7C, $36, $0A, $00, $00, $00, $10, $7F, $BE, $00, $00
        .byte $08, $7C, $BE, $F8, $01, $08, $7B, $BE, $00, $00, $00, $7E, $BE, $F8, $01, $00
        .byte $7D, $BE, $00, $00, $E8, $7F, $3E, $00, $00, $F0, $7C, $3E, $F8, $01, $F0, $7B
        .byte $3E, $00, $00, $F8, $7E, $3E, $F8, $01, $F8, $7D, $3E, $0A, $00, $00, $00, $08
        .byte $7E, $BE, $F8, $01, $08, $7D, $BE, $00, $00, $00, $7C, $BE, $F8, $01, $00, $7B
        .byte $BE, $00, $00, $10, $7F, $BE, $00, $00, $F0, $7E, $3E, $F8, $01, $F0, $7D, $3E
        .byte $00, $00, $F8, $7C, $3E, $F8, $01, $F8, $7B, $3E, $00, $00, $E8, $7F, $3E, $07
        .byte $00, $FC, $01, $F4, $7C, $3E, $FC, $01, $EC, $7C, $3E, $FC, $01, $E4, $7B, $3E
        .byte $FC, $01, $FC, $7C, $3E, $FC, $01, $14, $7D, $3E, $FC, $01, $0C, $7C, $3E, $FC
        .byte $01, $04, $7C, $3E

        ; 98/B388

    .endsection Table98B231Section


    .section Data98B388Section

      .al
      .xl

      aBattleSceneWhiteFadeSteps ; 98/B388

        ; Read by rlBattleSceneBuildWhiteFadePalettes.

        .word $0000, $000A, $0015, $0020, $002A, $0035, $0040, $004A
        .word $0055, $0060, $006A, $0075, $0080, $008A, $0095, $00A0
        .word $00AA, $00B5, $00C0, $00CA, $00D5, $00E0, $00EA, $00F5
        .word $0100

        ; 98/B3BA

      aBattleSceneDamageFlashTable1 ; 98/B3BA

        ; Read by rsBattleSceneStepDamageFlash.

        .word $5574, $55E0, $564C, $56B8, $5724, $5790, $57FC, $5868
        .word $58D4, $5940, $59AC, $5A18, $5A84, $5AF0, $5B5C, $5BC8
        .word $5C34, $5CA0, $5D0C, $5D78, $5DE4, $5E50, $5EBC, $5F28
        .word $5F94

        ; 98/B3EC

      aBattleSceneDamageFlashTable2 ; 98/B3EC

        ; Read by rsBattleSceneStepDamageFlash.

        .word $B574, $B5E0, $B64C, $B6B8, $B724, $B790, $B7FC, $B868
        .word $B8D4, $B940, $B9AC, $BA18, <>aBattleAnimationSequencesWarMageSword, $BAF0, $BB5C, $BBC8
        .word $BC34, $BCA0, $BD0C, $BD78, $BDE4, $BE50, $BEBC, $BF28
        .word $BF94

        ; 98/B41E

    .endsection Data98B388Section


    .section Data998000Section

      .al
      .xl

      aBattleSceneWaveScaleTable ; 99/8000

        ; 101 percentage-scaling pairs (0..100). Read by rlBattleSceneStepWaveOffsetTable.

        .word $0000, $FFFF
        .word $0002, $7F00
        .word $0005, $3233
        .word $0007, $2392
        .word $000A, $1899
        .word $000C, $1455
        .word $000F, $1011
        .word $0011, $0E0F
        .word $0014, $0BCC
        .word $0017, $0A21
        .word $0019, $093D
        .word $001C, $0824
        .word $001E, $0788
        .word $0021, $06C1
        .word $0023, $0650
        .word $0026, $05BC
        .word $0028, $0566
        .word $002B, $04F4
        .word $002E, $0490
        .word $0030, $0455
        .word $0033, $0405
        .word $0035, $03D4
        .word $0038, $0392
        .word $003A, $0369
        .word $003D, $0332
        .word $0040, $0300
        .word $0042, $02E0
        .word $0045, $02B5
        .word $0047, $029B
        .word $004A, $0275
        .word $004C, $025E
        .word $004F, $023D
        .word $0051, $0229
        .word $0054, $020C
        .word $0057, $01F1
        .word $0059, $01E0
        .word $005C, $01C8
        .word $005E, $01B9
        .word $0061, $01A3
        .word $0063, $0195
        .word $0066, $0182
        .word $0068, $0176
        .word $006B, $0164
        .word $006E, $0153
        .word $0070, $0149
        .word $0073, $0139
        .word $0075, $0130
        .word $0078, $0122
        .word $007A, $0119
        .word $007D, $010C
        .word $0080, $0100
        .word $0082, $00F8
        .word $0085, $00EC
        .word $0087, $00E5
        .word $008A, $00DA
        .word $008C, $00D4
        .word $008F, $00CA
        .word $0091, $00C3
        .word $0094, $00BA
        .word $0097, $00B2
        .word $0099, $00AC
        .word $009C, $00A4
        .word $009E, $009E
        .word $00A1, $0097
        .word $00A3, $0092
        .word $00A6, $008A
        .word $00A8, $0086
        .word $00AB, $007F
        .word $00AE, $0078
        .word $00B0, $0074
        .word $00B3, $006E
        .word $00B5, $006A
        .word $00B8, $0064
        .word $00BA, $0060
        .word $00BD, $005A
        .word $00C0, $0055
        .word $00C2, $0051
        .word $00C5, $004C
        .word $00C7, $0049
        .word $00CA, $0044
        .word $00CC, $0041
        .word $00CF, $003C
        .word $00D1, $0039
        .word $00D4, $0035
        .word $00D7, $0030
        .word $00D9, $002E
        .word $00DC, $0029
        .word $00DE, $0027
        .word $00E1, $0023
        .word $00E3, $0020
        .word $00E6, $001C
        .word $00E8, $001A
        .word $00EB, $0016
        .word $00EE, $0013
        .word $00F0, $0011
        .word $00F3, $000D
        .word $00F5, $000B
        .word $00F8, $0008
        .word $00FA, $0006
        .word $00FD, $0003
        .word $0100, $0000

        ; 99/8194

    .endsection Data998000Section


    .section Data9982E3Section

      .al
      .xl

      aBattleSceneWeaponPlacements ; 99/82E3

        ; Read by rlBattleSceneGetWeaponPlacement: how the scene places the
        ; combatants for the first striker's weapon (rlBattleSceneApplyPlacement).
        ; Three bytes per weapon: item ID, the mode, and the mode at wBattleDistance 3
        ; or more; $FF is none. Modes index aBattleScenePlacements: 0 the striker
        ; alone at the center (the other hidden), 1 both at the center, 2 the other
        ; hidden, 3 both at the center on the ground (battle type 2 only), 4 nothing
        ; (a magic or status sword; rlBattleSceneCheckSwordAtRange). $FFFF ends the
        ; list.

        .byte $09, $04, $04 ; BerserkSword
        .byte $0B, $04, $04 ; SilenceSword
        .byte $0C, $04, $04 ; SleepSword
        .byte $0F, $04, $04 ; FireSword
        .byte $10, $04, $04 ; EarthSword
        .byte $11, $04, $04 ; ThunderSword
        .byte $12, $04, $04 ; WindSword
        .byte $13, $04, $04 ; LightBrand
        .byte $3A, $00, $00 ; Ballista
        .byte $3B, $00, $00 ; IronBallista
        .byte $3C, $00, $00 ; KillerBallista
        .byte $3D, $00, $00 ; GreatBallista
        .byte $42, $00, $00 ; Meteor
        .byte $47, $00, $00 ; Bolting
        .byte $4C, $00, $00 ; Blizzard
        .byte $52, $00, $00 ; Fenrir
        .byte $5B, $FF, $00 ; PhysicStaff
        .byte $5C, $01, $01 ; Fortify
        .byte $5F, $02, $02 ; RescueStaff
        .byte $61, $FF, $00 ; RestoreStaff
        .byte $62, $02, $02 ; ValkyrieStaff
        .byte $63, $FF, $00 ; SilenceStaff
        .byte $64, $FF, $00 ; SleepStaff
        .byte $65, $FF, $00 ; BerserkStaff
        .word $FFFF

        ; 99/832D

      aBattleSceneWeaponScripts ; 99/832D

        ; Read by rlBattleSceneGetWeaponScript: the battle scene script each weapon
        ; starts (sequence command $F0, or at once for a status sword). Three bytes
        ; per weapon: item ID, the script, and the script at wBattleDistance 3 or
        ; more. $FFFF ends the list.

        .byte $09, $41, $41 ; BerserkSword
        .byte $0B, $3C, $3C ; SilenceSword
        .byte $0C, $42, $42 ; SleepSword
        .byte $0F, $02, $02 ; FireSword
        .byte $10, $12, $12 ; EarthSword
        .byte $11, $07, $07 ; ThunderSword
        .byte $12, $0C, $0C ; WindSword
        .byte $13, $11, $11 ; LightBrand
        .byte $3E, $02, $02 ; Fire
        .byte $3F, $03, $03 ; Elfire
        .byte $40, $04, $04 ; Bolganone
        .byte $41, $05, $05 ; Valflame
        .byte $42, $06, $06 ; Meteor
        .byte $43, $07, $07 ; Thunder
        .byte $44, $08, $08 ; Elthunder
        .byte $45, $09, $09 ; Thoron
        .byte $46, $0A, $0A ; Mjolnir
        .byte $47, $0B, $0B ; Bolting
        .byte $48, $0C, $0C ; Wind
        .byte $49, $0D, $0D ; Elwind
        .byte $4A, $0E, $0E ; Tornado
        .byte $4B, $0F, $0F ; Forseti
        .byte $4C, $10, $10 ; Blizzard
        .byte $4D, $11, $11 ; Light
        .byte $4E, $12, $12 ; Nosferatu
        .byte $4F, $13, $13 ; Aura
        .byte $50, $14, $14 ; Naga
        .byte $51, $15, $15 ; Jormungandr
        .byte $52, $16, $16 ; Fenrir
        .byte $53, $17, $17 ; Hel
        .byte $54, $18, $18 ; Loptous
        .byte $58, $19, $19 ; HealStaff
        .byte $59, $1A, $1A ; MendStaff
        .byte $5A, $1B, $1B ; RecoverStaff
        .byte $5B, $45, $1C ; PhysicStaff
        .byte $5C, $1D, $1D ; Fortify
        .byte $5D, $1E, $1E ; ReturnStaff
        .byte $5E, $1F, $1F ; WarpStaff
        .byte $5F, $20, $20 ; RescueStaff
        .byte $60, $21, $21 ; CharmStaff
        .byte $61, $22, $46 ; RestoreStaff
        .byte $62, $23, $23 ; ValkyrieStaff
        .byte $63, $47, $24 ; SilenceStaff
        .byte $64, $25, $48 ; SleepStaff
        .byte $65, $26, $49 ; BerserkStaff
        .byte $66, $27, $27 ; ThiefStaff
        .word $FFFF

        ; 99/83B9

      aItemAnimationCategories ; 99/83B9

        ; Read by rlBattleSceneGetWeaponAnimStyle. One byte per item ID plus 1 (entry 0 is for no
        ; item): the high nibble is the weapon category of the battle animation
        ; lookup (AnimCategory...), the low nibble the attack style (AttackStyle...).

        .byte (AnimCategoryAny << 4) | AttackStyleSword  ; no item
        .byte (AnimCategorySword << 4) | AttackStyleSword  ; IronSword
        .byte (AnimCategorySword << 4) | AttackStyleSword  ; SteelSword
        .byte (AnimCategorySword << 4) | AttackStyleSword  ; SilverSword
        .byte (AnimCategorySword << 4) | AttackStyleSword  ; IronBlade
        .byte (AnimCategorySword << 4) | AttackStyleSword  ; SteelBlade
        .byte (AnimCategorySword << 4) | AttackStyleSword  ; SilverBlade
        .byte (AnimCategorySword << 4) | AttackStyleSword  ; MiracleSword
        .byte (AnimCategorySword << 4) | AttackStyleSword  ; ThiefSword
        .byte (AnimCategorySword << 4) | AttackStyleSword  ; BarrierBlade
        .byte (AnimCategorySword << 4) | AttackStyleSword  ; BerserkSword
        .byte (AnimCategorySword << 4) | AttackStyleSword  ; BraveSword
        .byte (AnimCategorySword << 4) | AttackStyleSword  ; SilenceSword
        .byte (AnimCategorySword << 4) | AttackStyleSword  ; SleepSword
        .byte (AnimCategorySword << 4) | AttackStyleSword  ; SlimSword
        .byte (AnimCategorySword << 4) | AttackStyleSword  ; Safeguard
        .byte (AnimCategorySword << 4) | AttackStyleSword  ; FireSword
        .byte (AnimCategorySword << 4) | AttackStyleSword  ; EarthSword
        .byte (AnimCategorySword << 4) | AttackStyleSword  ; ThunderSword
        .byte (AnimCategorySword << 4) | AttackStyleSword  ; WindSword
        .byte (AnimCategorySword << 4) | AttackStyleSword  ; LightBrand
        .byte (AnimCategorySword << 4) | AttackStyleSword  ; Mystletainn
        .byte (AnimCategorySword << 4) | AttackStyleSword  ; Tyrfing
        .byte (AnimCategorySword << 4) | AttackStyleSword  ; Balmung
        .byte (AnimCategorySword << 4) | AttackStyleSword  ; Armorslayer
        .byte (AnimCategorySword << 4) | AttackStyleSword  ; Wingclipper
        .byte (AnimCategorySword << 4) | AttackStyleSword  ; BrokenSwordA
        .byte (AnimCategorySword << 4) | AttackStyleSword  ; BrokenSwordB
        .byte (AnimCategorySword << 4) | AttackStyleSword  ; BrokenSwordC
        .byte (AnimCategoryLance << 4) | AttackStyleLance  ; IronLance
        .byte (AnimCategoryLance << 4) | AttackStyleLance  ; SteelLance
        .byte (AnimCategoryLance << 4) | AttackStyleLance  ; SilverLance
        .byte (AnimCategoryRangedLance << 4) | AttackStyleLance  ; Javelin
        .byte (AnimCategoryLance << 4) | AttackStyleLance  ; Ridersbane
        .byte (AnimCategoryLance << 4) | AttackStyleLance  ; BraveLance
        .byte (AnimCategoryLance << 4) | AttackStyleLance  ; SlimLance
        .byte (AnimCategoryLance << 4) | AttackStyleLance  ; Gungnir
        .byte (AnimCategoryLance << 4) | AttackStyleLance  ; GaeBolg
        .byte (AnimCategoryLance << 4) | AttackStyleLance  ; BrokenLanceA
        .byte (AnimCategoryLance << 4) | AttackStyleLance  ; BrokenLanceB
        .byte (AnimCategoryLance << 4) | AttackStyleLance  ; BrokenLanceC
        .byte (AnimCategoryAxe << 4) | AttackStyleAxe  ; IronAxe
        .byte (AnimCategoryAxe << 4) | AttackStyleAxe  ; SteelAxe
        .byte (AnimCategoryAxe << 4) | AttackStyleAxe  ; SilverAxe
        .byte (AnimCategoryAxe << 4) | AttackStyleAxe  ; BraveAxe
        .byte (AnimCategoryRangedAxe << 4) | AttackStyleAxe  ; Helswath
        .byte (AnimCategoryRangedAxe << 4) | AttackStyleAxe  ; HandAxe
        .byte (AnimCategoryAxe << 4) | AttackStyleAxe  ; BrokenAxeA
        .byte (AnimCategoryAxe << 4) | AttackStyleAxe  ; BrokenAxeB
        .byte (AnimCategoryAxe << 4) | AttackStyleAxe  ; BrokenAxeC
        .byte (AnimCategoryBow << 4) | AttackStyleRanged  ; IronBow
        .byte (AnimCategoryBow << 4) | AttackStyleRanged  ; SteelBow
        .byte (AnimCategoryBow << 4) | AttackStyleRanged  ; SilverBow
        .byte (AnimCategoryBow << 4) | AttackStyleRanged  ; BraveBow
        .byte (AnimCategoryBow << 4) | AttackStyleRanged  ; KillerBow
        .byte (AnimCategoryBow << 4) | AttackStyleRanged  ; Yewfelle
        .byte (AnimCategoryBow << 4) | AttackStyleRanged  ; BrokenBowA
        .byte (AnimCategoryBow << 4) | AttackStyleRanged  ; BrokenBowB
        .byte (AnimCategoryBow << 4) | AttackStyleRanged  ; BrokenBowC
        .byte (AnimCategoryBow << 4) | AttackStyleRanged  ; Ballista
        .byte (AnimCategoryBow << 4) | AttackStyleRanged  ; IronBallista
        .byte (AnimCategoryBow << 4) | AttackStyleRanged  ; KillerBallista
        .byte (AnimCategoryBow << 4) | AttackStyleRanged  ; GreatBallista
        .byte (AnimCategoryMagic << 4) | AttackStyleMagic  ; Fire
        .byte (AnimCategoryMagic << 4) | AttackStyleMagic  ; Elfire
        .byte (AnimCategoryMagic << 4) | AttackStyleMagic  ; Bolganone
        .byte (AnimCategoryMagic << 4) | AttackStyleMagic  ; Valflame
        .byte (AnimCategoryMagic << 4) | AttackStyleMagic  ; Meteor
        .byte (AnimCategoryMagic << 4) | AttackStyleMagic  ; Thunder
        .byte (AnimCategoryMagic << 4) | AttackStyleMagic  ; Elthunder
        .byte (AnimCategoryMagic << 4) | AttackStyleMagic  ; Thoron
        .byte (AnimCategoryMagic << 4) | AttackStyleMagic  ; Mjolnir
        .byte (AnimCategoryMagic << 4) | AttackStyleMagic  ; Bolting
        .byte (AnimCategoryMagic << 4) | AttackStyleMagic  ; Wind
        .byte (AnimCategoryMagic << 4) | AttackStyleMagic  ; Elwind
        .byte (AnimCategoryMagic << 4) | AttackStyleMagic  ; Tornado
        .byte (AnimCategoryMagic << 4) | AttackStyleMagic  ; Forseti
        .byte (AnimCategoryMagic << 4) | AttackStyleMagic  ; Blizzard
        .byte (AnimCategoryMagic << 4) | AttackStyleMagic  ; Light
        .byte (AnimCategoryMagic << 4) | AttackStyleMagic  ; Nosferatu
        .byte (AnimCategoryMagic << 4) | AttackStyleMagic  ; Aura
        .byte (AnimCategoryMagic << 4) | AttackStyleMagic  ; Naga
        .byte (AnimCategoryMagic << 4) | AttackStyleMagic  ; Jormungandr
        .byte (AnimCategoryMagic << 4) | AttackStyleMagic  ; Fenrir
        .byte (AnimCategoryMagic << 4) | AttackStyleMagic  ; Hel
        .byte (AnimCategoryMagic << 4) | AttackStyleMagic  ; Loptous
        .byte (AnimCategoryMagic << 4) | AttackStyleMagic  ; BrokenFireTomeA
        .byte (AnimCategoryMagic << 4) | AttackStyleMagic  ; BrokenFireTomeB
        .byte (AnimCategoryMagic << 4) | AttackStyleMagic  ; BrokenFireTomeC
        .byte (AnimCategoryStaff << 4) | AttackStyleStaff  ; HealStaff
        .byte (AnimCategoryStaff << 4) | AttackStyleStaff  ; MendStaff
        .byte (AnimCategoryStaff << 4) | AttackStyleStaff  ; RecoverStaff
        .byte (AnimCategoryStaff << 4) | AttackStyleStaff  ; PhysicStaff
        .byte (AnimCategoryStaff << 4) | AttackStyleStaff  ; Fortify
        .byte (AnimCategoryStaff << 4) | AttackStyleStaff  ; ReturnStaff
        .byte (AnimCategoryStaff << 4) | AttackStyleStaff  ; WarpStaff
        .byte (AnimCategoryStaff << 4) | AttackStyleStaff  ; RescueStaff
        .byte (AnimCategoryStaff << 4) | AttackStyleStaff  ; CharmStaff
        .byte (AnimCategoryStaff << 4) | AttackStyleStaff  ; RestoreStaff
        .byte (AnimCategoryStaff << 4) | AttackStyleStaff  ; ValkyrieStaff
        .byte (AnimCategoryStaff << 4) | AttackStyleStaff  ; SilenceStaff
        .byte (AnimCategoryStaff << 4) | AttackStyleStaff  ; SleepStaff
        .byte (AnimCategoryStaff << 4) | AttackStyleStaff  ; BerserkStaff
        .byte (AnimCategoryStaff << 4) | AttackStyleStaff  ; ThiefStaff
        .byte (AnimCategoryStaff << 4) | AttackStyleStaff  ; BrokenStaffA
        .byte (AnimCategoryStaff << 4) | AttackStyleStaff  ; BrokenStaffB
        .byte (AnimCategoryStaff << 4) | AttackStyleStaff  ; BrokenStaffC
        .byte (AnimCategoryAny << 4) | AttackStyleSword  ; RenewalBand
        .byte (AnimCategoryAny << 4) | AttackStyleSword  ; ParagonBand
        .byte (AnimCategoryAny << 4) | AttackStyleSword  ; ThiefBand
        .byte (AnimCategoryAny << 4) | AttackStyleSword  ; MiracleBand
        .byte (AnimCategoryAny << 4) | AttackStyleSword  ; PursuitRing
        .byte (AnimCategoryAny << 4) | AttackStyleSword  ; RecoverRing
        .byte (AnimCategoryAny << 4) | AttackStyleSword  ; BargainBand
        .byte (AnimCategoryAny << 4) | AttackStyleSword  ; KnightRing
        .byte (AnimCategoryAny << 4) | AttackStyleSword  ; ReturnBand
        .byte (AnimCategoryAny << 4) | AttackStyleSword  ; SpeedRing
        .byte (AnimCategoryAny << 4) | AttackStyleSword  ; MagicRing
        .byte (AnimCategoryAny << 4) | AttackStyleSword  ; PowerRing
        .byte (AnimCategoryAny << 4) | AttackStyleSword  ; ShieldRing
        .byte (AnimCategoryAny << 4) | AttackStyleSword  ; BarrierRing
        .byte (AnimCategoryAny << 4) | AttackStyleSword  ; LegRing
        .byte (AnimCategoryAny << 4) | AttackStyleSword  ; SkillRing
        .byte (AnimCategorySword << 4) | AttackStyleSword  ; BrokenHolySword
        .byte (AnimCategoryLance << 4) | AttackStyleLance  ; BrokenHolyLance
        .byte (AnimCategoryBow << 4) | AttackStyleRanged  ; BrokenHolyBow

        ; 99/8437

      aBattleSceneIntroSteps ; 99/8437

        ; Read by rlBattleSceneRunIntroStep: routines it calls.

        .long rlBattleSceneWaitForIntro
        .long rlBattleSceneShowBattleQuote
        .long rlBattleSceneStartFadeIn

        ; 99/8440

      aBattleSceneEndSteps ; 99/8440

        ; Read by rlBattleSceneRunEndStep: routines it calls.

        .long rlBattleSceneStartFadeOut
        .long rlBattleSceneShowJuliusQuote
        .long rlBattleSceneEndStepJulius
        .long rlBattleSceneEndStepJulius2
        .long rlBattleSceneShowWaitForPress
        .long rlBattleSceneShowWeaponBroke
        .long rlBattleSceneShowItemObtained
        .long rlBattleSceneShowGoldStolen
        .long rlBattleSceneShowGoldObtained
        .long rlBattleSceneOpenMessageWindow
        .long rlBattleSceneEndStepType2Script2
        .long rlBattleSceneShowLevelUp
        .long rlBattleScenePrepareLevelUp
        .long rlBattleSceneShowLevelUpBanner
        .long rlBattleSceneShowExperience
        .long rlBattleSceneEndStepDefeatScript2
        .long rlBattleSceneEndStepDefeatCry
        .long rlBattleSceneShowDeathQuote
        .long rlBattleSceneEndStepDefeatScript
        .long rlBattleSceneEndStepType2Script
        .long rlBattleSceneShowBG3

        ; 99/847F

      aClassDefaultGenders ; 99/847F

        ; Read by rlBattleSceneGetGender: the gender a unit of this class gets in battle
        ; animations when its own is Genderless.

        .byte GenderMale   ; Cavalier
        .byte GenderMale   ; LanceKnight
        .byte GenderMale   ; BowKnight
        .byte GenderMale   ; AxeKnight
        .byte GenderMale   ; FreeKnight
        .byte GenderFemale ; Troubadour
        .byte GenderMale   ; KnightLord
        .byte GenderMale   ; DukeKnight
        .byte GenderMale   ; MasterKnight
        .byte GenderMale   ; Paladin
        .byte GenderFemale ; PaladinF
        .byte GenderMale   ; ArchKnight
        .byte GenderMale   ; Ranger
        .byte GenderMale   ; MageKnight
        .byte GenderMale   ; GreatKnight
        .byte GenderFemale ; PegasusRider
        .byte GenderFemale ; PegasusKnight
        .byte GenderFemale ; FalconKnight
        .byte GenderMale   ; Dragonrider
        .byte GenderMale   ; Dragonknight
        .byte GenderMale   ; Dragonmaster
        .byte GenderMale   ; Archer
        .byte GenderMale   ; Myrmidon
        .byte GenderMale   ; Swordmaster
        .byte GenderMale   ; Sniper
        .byte GenderMale   ; Hero
        .byte GenderMale   ; General
        .byte GenderMale   ; Emperor
        .byte GenderMale   ; Baron
        .byte GenderMale   ; Soldier
        .byte GenderMale   ; SpearSoldier
        .byte GenderMale   ; AxeSoldier
        .byte GenderMale   ; BowSoldier
        .byte GenderMale   ; SwordSoldier
        .byte GenderMale   ; LanceArmor
        .byte GenderMale   ; AxeArmor
        .byte GenderMale   ; BowArmor
        .byte GenderMale   ; SwordArmor
        .byte GenderMale   ; Barbarian
        .byte GenderMale   ; Fighter
        .byte GenderMale   ; Brigand
        .byte GenderMale   ; Warrior
        .byte GenderMale   ; Hunter
        .byte GenderMale   ; Pirate
        .byte GenderMale   ; JuniorLord
        .byte GenderMale   ; WarMage
        .byte GenderMale   ; Prince
        .byte GenderFemale ; Princess
        .byte GenderMale   ; WarMageF
        .byte GenderFemale ; Queen
        .byte GenderMale   ; Dancer
        .byte GenderFemale ; Priest
        .byte GenderMale   ; Mage
        .byte GenderMale   ; FireMage
        .byte GenderMale   ; ThunderMage
        .byte GenderMale   ; WindMage
        .byte GenderMale   ; HighPriest
        .byte GenderMale   ; Bishop
        .byte GenderMale   ; Sage
        .byte GenderMale   ; Bard
        .byte GenderMale   ; Priestess
        .byte GenderMale   ; DarkMage
        .byte GenderMale   ; DarkBishop
        .byte GenderMale   ; Thief
        .byte GenderMale   ; Rogue
        .byte GenderMale   ; Civilian
        .byte GenderMale   ; Child
        .byte GenderMale   ; Ballistician
        .byte GenderMale   ; IronBallistician
        .byte GenderMale   ; KillerBallistician
        .byte GenderMale   ; GreatBallistician

        ; 99/84C6

      aBattleSceneLevelUpGauges ; 99/84C6

        ; The level and the eight stats before the gains, as the level up window
        ; first draws them (rlBattleSceneDrawLevelUpWindow).

        BATTLE_SCENE_GAUGE bBattleSceneLevel, $FFFF, $0CE4, $32, 2, $04, $2800
        BATTLE_SCENE_GAUGE aActionStructUnit1.LevelUpData.HP, $005C, $0DD8, $50, 2, $0C, $2800
        BATTLE_SCENE_GAUGE aActionStructUnit1.LevelUpData.Strength, $00F7, $0E18, $1E, 2, $0C, $2800
        BATTLE_SCENE_GAUGE aActionStructUnit1.LevelUpData.Magic, $00F7, $0E58, $1E, 2, $0C, $2800
        BATTLE_SCENE_GAUGE aActionStructUnit1.LevelUpData.Defense, $00F7, $0E98, $1E, 2, $0C, $2800
        BATTLE_SCENE_GAUGE aActionStructUnit1.LevelUpData.Skill, $00F7, $0DEE, $1E, 2, $0C, $2800
        BATTLE_SCENE_GAUGE aActionStructUnit1.LevelUpData.Speed, $00F7, $0E2E, $1E, 2, $0C, $2800
        BATTLE_SCENE_GAUGE aActionStructUnit1.LevelUpData.Luck, $00F7, $0E6E, $1E, 2, $0C, $2800
        BATTLE_SCENE_GAUGE aActionStructUnit1.LevelUpData.Resistance, $00F7, $0EAE, $1E, 2, $0C, $2800

        ; 99/8532

      aBattleSceneStatGainMotion ; 99/8532

        ; Read by rlBattleSceneScriptStepStatGain.

        .byte $01, $F8, $02, $F4, $03, $F2, $04, $F1, $05, $F0, $07, $EF, $09, $EF, $0B, $F0
        .byte $0C, $F1, $0D, $F3, $0E, $F5, $0E, $F7, $0E, $F9, $0E, $FB, $0D, $FD, $0C, $FE
        .byte $0A, $FF, $08, $00, $08, $00, $08, $00, $08, $00, $08, $00, $08, $00, $82, $08
        .byte $00, $08, $00, $08, $00, $08, $00, $08, $00, $08, $00, $08, $00, $08, $00, $08
        .byte $00, $08, $00, $08, $00, $08, $00, $08, $00, $08, $00, $81, $00, $08, $00, $81
        .byte $00, $08, $00, $80

        ; 99/8586

      aBattleSceneLevelUpNumberMotion ; 99/8586

        ; Read by rlBattleSceneScriptStepLevelUpNumber.

        .byte $FC, $FC, $00, $F8, $F9, $01, $F5, $F7, $02, $F2, $F5, $03, $F1, $F3, $04, $F1
        .byte $F1, $05, $F1, $F0, $06, $F1, $F0, $07, $F1, $F1, $08, $F0, $F2, $09, $EE, $F3
        .byte $0A, $EF, $F4, $09, $F0, $F4, $08, $F1, $F3, $07, $ED, $F2, $09, $F0, $F1, $08
        .byte $F0, $F1, $08, $F0, $F1, $08, $F0, $F1, $08, $F0, $F1, $08, $F0, $F1, $08, $F0
        .byte $F1, $08, $F0, $F1, $08, $F0, $F1, $08, $F0, $F1, $08, $F0, $F1, $08, $F0, $F1
        .byte $08, $F0, $F1, $08, $F0, $F1, $08, $F0, $F1, $08, $F0, $F1, $08, $F0, $F1, $08
        .byte $F0, $F1, $08, $F0, $F1, $08, $F0, $F1, $08, $F0, $F1, $08, $F0, $F1, $08, $F0
        .byte $F1, $08, $F0, $F1, $08, $F0, $F1, $08, $F0, $F1, $08, $F0, $F1, $08, $F0, $F1
        .byte $08, $F0, $F1, $08, $F0, $F1, $08, $F0, $F1, $08, $F0, $F0, $08, $F0, $F0, $08
        .byte $F0, $EF, $08, $F0, $EF, $08, $F0, $EE, $08, $F0, $EE, $08, $81, $00, $08, $F0
        .byte $ED, $08, $81, $00, $08, $F0, $EC, $08, $80

        ; 99/862F

      aBattleSceneLevelUpNumberOffsets ; 99/862F

        ; Read by rlBattleSceneScriptStepLevelUpNumber.

        .word $0000, $0000, $0201, $0403, $0402, $0806, $0603, $0C09
        .word $0804, $100C, $0A05, $140F, $0C06, $1812, $0E07, $1C15
        .word $1008, $2018, $1209, $241B, $140A, $281E, $160B, $2C21
        .word $180C, $3024, $1A0D, $3427, $1C0E, $382A, $1E0F, $3C2D
        .word $2010, $4030, $2211, $4433, $2412, $4836, $2613, $4C39
        .word $2814, $503C

        ; 99/8683

      aBattleSceneLevelUpStatGainTable ; 99/8683

        ; Read by rlBattleSceneScriptNextStatGain.

        .word $4F05, $F57E, $7E4E, $A890, $0B00, $7E4F, $4EFB, $E87E
        .word $01A8, $4F07, $F77E, $7E4E, $B090, $0D02, $7E4F, $4EFD
        .word $E87E, $03B0, $4F09, $F97E, $7E4E, $B890, $1304, $7E4F
        .word $4F03, $E87E, $05B8, $4F0F, $FF7E, $7E4E, $C090, $1106
        .word $7E4F, $4F01, $E87E, $07C0, $0080

        ; 99/86CD

      aBattleSceneLevelUpStatGauges ; 99/86CD

        ; The stats in the order a level up raises them (rlBattleSceneStartStatGauge).

        BATTLE_SCENE_STAT_GAUGE aActionStructUnit1.LevelUpData.HP, aActionStructUnit1.LevelUpData.HPGain, $005C, $0DD8, $50
        BATTLE_SCENE_STAT_GAUGE aActionStructUnit1.LevelUpData.Skill, aActionStructUnit1.LevelUpData.SkillGain, $00F7, $0DEE, $1E
        BATTLE_SCENE_STAT_GAUGE aActionStructUnit1.LevelUpData.Strength, aActionStructUnit1.LevelUpData.StrengthGain, $00F7, $0E18, $1E
        BATTLE_SCENE_STAT_GAUGE aActionStructUnit1.LevelUpData.Speed, aActionStructUnit1.LevelUpData.SpeedGain, $00F7, $0E2E, $1E
        BATTLE_SCENE_STAT_GAUGE aActionStructUnit1.LevelUpData.Magic, aActionStructUnit1.LevelUpData.MagicGain, $00F7, $0E58, $1E
        BATTLE_SCENE_STAT_GAUGE aActionStructUnit1.LevelUpData.Luck, aActionStructUnit1.LevelUpData.LuckGain, $00F7, $0E6E, $1E
        BATTLE_SCENE_STAT_GAUGE aActionStructUnit1.LevelUpData.Defense, aActionStructUnit1.LevelUpData.DefenseGain, $00F7, $0E98, $1E
        BATTLE_SCENE_STAT_GAUGE aActionStructUnit1.LevelUpData.Resistance, aActionStructUnit1.LevelUpData.ResistanceGain, $00F7, $0EAE, $1E

        ; 99/8725

    .endsection Data9982E3Section


    .section Data99892ASection

      .al
      .xl

      aBattleScenePalFlashSteps ; 99/892A

        ; Read by rlBattleSceneScriptStepPalFlash.

        .word $0380, $0380, $0280, $0280, $0180, $0180, $0080, $0080
        .word $0081, $0081, $0082, $0082, $FF85

        ; 99/8944

    .endsection Data99892ASection


    .section Data998944Section

      .al
      .xl

      aBattleSceneHUDColors ; 99/8944

        ; Read by rsBattleSceneSetHUDColors1 and rsBattleSceneSetHUDColors2 (22 bytes per entry).

        .word $039C, $39D2, $3190, $2D6F, $294E, $252D, $1CC9, $0000, $18A8, $0003, $39D2
        .word $039C, $420F, $3DEE, $39CD, $35AC, $318B, $0C42, $0000, $1CE6, $0000, $420F
        .word $039C, $5310, $4ACE, $46AD, $428C, $3A4A, $04A7, $0000, $1D64, $0880, $4ACE
        .word $039C, $4DAF, $498E, $456D, $414C, $3D2B, $0866, $0000, $2CA7, $0401, $498E
        .word $03FF, $6B7B, $635A, $5AF7, $4ED7, $3E75, $08C8, $0000, $318B, $10E7, $5F7B
        .word $03FF, $21AF, $1D8E, $196D, $154C, $152B, $04A7, $0000, $04A7, $0021, $21AF
        .word $039C, $76D3, $72B2, $6E91, $6A70, $664F, $04A7, $0000, $2106, $0C42, $5A71
        .word $03FF, $19D4, $15B3, $1192, $0D71, $0950, $04A7, $0000, $0068, $0021, $1DF5
        .word $039C, $658C, $616B, $5D4A, $5929, $5909, $0445, $0000, $3863, $0400, $61AD
        .word $0400, $0400, $0800, $0800, $0C00, $0C00, $1000, $1000, $1400, $1400, $1800
        .word $1800, $1C00, $1C00, $2000, $2000, $2000, $2400, $2400, $2400, $2800, $2800
        .word $2800, $2C00, $2C00, $2C00, $3000, $3000, $3000, $3400, $3400, $3400, $3400
        .word $3800, $3800, $3800, $3800, $3C00, $3C00, $3C00, $3C00, $3C00, $3C00, $3800
        .word $3800, $3800, $3800, $3400, $3400, $3400, $3400, $3000, $3000, $3000, $2C00
        .word $2C00, $2C00, $2800, $2800, $2800, $2400, $2400, $2400, $2000, $2000, $2000
        .word $1C00, $1C00, $1800, $1800, $1400, $1400, $1000, $1000, $0C00, $0C00, $0800
        .word $0800, $0400, $0400, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0A10
        .word $708A, $8A0A, $0AD0, $008A, $AA10, $708A, $8AAA, $AAD0, $008A

      aBattleSceneSeaColumns ; 99/8B0E

        ; Read by rsBattleAnimationUseWaterSounds.

        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01
        .byte $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $01, $01, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $0F, $1D, $E5, $04, $1D, $E5, $04, $1E, $E5, $04, $1F, $E5, $04, $20, $E5, $04
        .byte $21, $E5, $04, $22, $E5, $04, $23, $E5, $04, $24, $E5, $04, $25, $E5, $04, $26
        .byte $E5, $04, $27, $E5, $04, $28, $E5, $04, $29, $E5, $04, $2A, $E5, $08, $2B, $E5
        .byte $04, $2A, $E5, $04, $29, $E5, $04, $28, $E5, $04, $27, $E5, $04, $26, $E5, $04
        .byte $25, $E5, $04, $24, $E5, $04, $23, $E5, $04, $22, $E5, $04, $21, $E5, $04, $20
        .byte $E5, $04, $1F, $E5, $00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
        .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
        .byte $FF, $FF, $FF, $FD, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
        .byte $FF, $FF, $FD, $FE, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
        .byte $FF, $FC, $FD, $FE, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
        .byte $FA, $FC, $FD, $FE, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $F8
        .byte $FA, $FC, $FD, $FE, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $F6, $F8
        .byte $FA, $FC, $FD, $FE, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $F4, $F6, $F8
        .byte $FA, $FC, $FD, $FE, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $F2, $F4, $F6, $F8
        .byte $FA, $FC, $FD, $FE, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $F0, $F2, $F4, $F6, $F8
        .byte $FA, $FC, $FD, $FE, $FF, $FF, $FF, $FF, $FF, $FF, $EE, $F0, $F2, $F4, $F6, $F8
        .byte $FA, $FC, $FD, $FE, $FF, $FF, $FF, $FF, $FF, $EC, $EE, $F0, $F2, $F4, $F6, $F8
        .byte $FA, $FC, $FD, $FE, $FF, $FF, $FF, $FF, $EA, $EC, $EE, $F0, $F2, $F4, $F6, $F8
        .byte $FA, $FC, $FD, $FE, $FF, $FF, $FF, $E8, $EA, $EC, $EE, $F0, $F2, $F4, $F6, $F8
        .byte $FA, $FC, $FD, $FE, $FF, $FF, $E6, $E8, $EA, $EC, $EE, $F0, $F2, $F4, $F6, $F8
        .byte $FA, $FC, $FD, $FE, $FF, $E4, $E6, $E8, $EA, $EC, $EE, $F0, $F2, $F4, $F6, $F8
        .byte $FA, $FC, $FD, $FE, $E2, $E4, $E6, $E8, $EA, $EC, $EE, $F0, $F2, $F4, $F6, $F8
        .byte $FA, $FC, $FD, $E0, $E2, $E4, $E6, $E8, $EA, $EC, $EE, $F0, $F2, $F4, $F6, $F8
        .byte $FA, $FC, $E0, $E0, $E2, $E4, $E6, $E8, $EA, $EC, $EE, $F0, $F2, $F4, $F6, $F8
        .byte $FA, $E0, $E0, $E0, $E2, $E4, $E6, $E8, $EA, $EC, $EE, $F0, $F2, $F4, $F6, $F8
        .byte $E0, $E0, $E0, $E0, $E2, $E4, $E6, $E8, $EA, $EC, $EE, $F0, $F2, $F4, $F6, $E0
        .byte $E0, $E0, $E0, $E0, $E2, $E4, $E6, $E8, $EA, $EC, $EE, $F0, $F2, $F4, $E0, $E0
        .byte $E0, $E0, $E0, $E0, $E2, $E4, $E6, $E8, $EA, $EC, $EE, $F0, $F2, $E0, $E0, $E0
        .byte $E0, $E0, $E0, $E0, $E2, $E4, $E6, $E8, $EA, $EC, $EE, $F0, $E0, $E0, $E0, $E0
        .byte $E0, $E0, $E0, $E0, $E2, $E4, $E6, $E8, $EA, $EC, $EE, $E0, $E0, $E0, $E0, $E0
        .byte $E0, $E0, $E0, $E0, $E2, $E4, $E6, $E8, $EA, $EC, $E0, $E0, $E0, $E0, $E0, $E0
        .byte $E0, $E0, $E0, $E0, $E2, $E4, $E6, $E8, $EA, $E0, $E0, $E0, $E0, $E0, $E0, $E0
        .byte $E0, $E0, $E0, $E0, $E2, $E4, $E6, $E8, $E0, $E0, $E0, $E0, $E0, $E0, $E0, $E0
        .byte $E0, $E0, $E0, $E0, $E2, $E4, $E6, $E0, $E0, $E0, $E0, $E0, $E0, $E0, $E0, $E0
        .byte $E0, $E0, $E0, $E0, $E2, $E4, $E0, $E0, $E0, $E0, $E0, $E0, $E0, $E0, $E0, $E0
        .byte $E0, $E0, $E0, $E0, $E2, $00

        ; 99/8D84

    .endsection Data998944Section


    .section Data998DD8Section

      .al
      .xl

      aBattleSceneEffectSpeedTable ; 99/8DD8

        .byte $02, $02, $02, $02, $02, $03, $03, $03, $03, $05, $05, $05, $07, $07, $09, $09
        .byte $09, $09, $07, $07, $05, $05, $05, $03, $03, $03, $03, $02, $02, $02, $02, $02

      aBattleSceneCharacterColorIndices ; 99/8DF8

        ; Read by rlBattleSceneLoadCharacterColors (2-byte ID + 1-byte index, $FFFF terminated).

        .word $0001
        .byte $01
        .word $0002
        .byte $02
        .word $0003
        .byte $03
        .word $0005
        .byte $01
        .word $0006
        .byte $00
        .word $0007
        .byte $03
        .word $0008
        .byte $03
        .word $0009
        .byte $02
        .word $000A
        .byte $04
        .word $000B
        .byte $00
        .word $000C
        .byte $02
        .word $000D
        .byte $02
        .word $000E
        .byte $01
        .word $000F
        .byte $02
        .word $0010
        .byte $05
        .word $0011
        .byte $06
        .word $0012
        .byte $02
        .word $0013
        .byte $07
        .word $0014
        .byte $03
        .word $0015
        .byte $05
        .word $0016
        .byte $03
        .word $0017
        .byte $02
        .word $0018
        .byte $02
        .word $0019
        .byte $01
        .word $001A
        .byte $07
        .word $001B
        .byte $07
        .word $001C
        .byte $07
        .word $001D
        .byte $00
        .word $001E
        .byte $00
        .word $001F
        .byte $01
        .word $0020
        .byte $00
        .word $0021
        .byte $00
        .word $0022
        .byte $01
        .word $0023
        .byte $00
        .word $0025
        .byte $02
        .word $0026
        .byte $03
        .word $027F
        .byte $03
        .word $0028
        .byte $00
        .word $0029
        .byte $07
        .word $002A
        .byte $07
        .word $002B
        .byte $05
        .word $002C
        .byte $00
        .word $002D
        .byte $03
        .word $002E
        .byte $00
        .word $002F
        .byte $07
        .word $0030
        .byte $00
        .word $0031
        .byte $00
        .word $0032
        .byte $07
        .word $0033
        .byte $02
        .word $0034
        .byte $02
        .word $0035
        .byte $03
        .word $0036
        .byte $02
        .word $0037
        .byte $01
        .word $0038
        .byte $05
        .word $0039
        .byte $09
        .word $003A
        .byte $07
        .word $003B
        .byte $08
        .word $003C
        .byte $03
        .word $003D
        .byte $05
        .word $003E
        .byte $03
        .word $003F
        .byte $02
        .word $0073
        .byte $09
        .word $008A
        .byte $09
        .word $00C2
        .byte $03
        .word $00C9
        .byte $03
        .word $00D5
        .byte $07
        .word $00EB
        .byte $05
        .word $0120
        .byte $05
        .word $0122
        .byte $04
        .word $0131
        .byte $05
        .word $0132
        .byte $05
        .word $0133
        .byte $05
        .word $0142
        .byte $05
        .word $0152
        .byte $05
        .word $0153
        .byte $05
        .word $0154
        .byte $05
        .word $017D
        .byte $07
        .word $018E
        .byte $04
        .word $018F
        .byte $05
        .word $01AA
        .byte $09
        .word $01B8
        .byte $00
        .word $01BC
        .byte $09
        .word $01BF
        .byte $07
        .word $01C6
        .byte $04
        .word $01D5
        .byte $05
        .word $01D6
        .byte $07
        .word $01D7
        .byte $00
        .word $01D8
        .byte $00
        .word $FFFF

        ; 99/8F02

    .endsection Data998DD8Section


    .section Data998F02Section

      .al
      .xl

      aBattleSceneListedWeapons ; 99/8F02

        ; Read by rsBattleSceneCheckListedWeapon.

        .byte $02, $04, $05, $14, $15, $16, $1E, $23, $24, $2A, $2C, $FF, $FF

        ; 99/8F0F

      aBattleSceneHUDShakeOffsets ; 99/8F0F

        ; Read by rlBattleSceneRunHUDShake.

        .byte $02, $FF, $02, $FF, $FE, $00, $FE, $00, $00, $01, $00, $01, $00, $FF, $00, $FF
        .byte $02, $01, $FE, $FF, $FE, $FF, $02, $00, $FE, $01, $FE, $01, $01, $FF, $FF, $00
        .byte $00, $01, $00, $FF, $01, $01, $FF, $FF, $01, $00, $FF, $01, $01, $FF, $FF, $00
        .byte $00, $01, $00, $FF, $80, $80, $0F, $D4, $F8, $08, $D4, $F8, $08, $D6, $F8, $08
        .byte $D8, $F8, $08, $DA, $F8, $08, $DC, $F8, $08, $DE, $F8, $04, $E0, $F8, $08, $E2
        .byte $F8, $04, $E0, $F8, $08, $DE, $F8, $08, $DC, $F8, $08, $DA, $F8, $08, $D8, $F8
        .byte $08, $D6, $F8, $08, $D4, $F8, $00, $00, $04, $00, $03, $00, $02, $80, $01, $00
        .byte $01, $C0, $00, $80, $00, $60, $00

        ; 99/8F86

      aBattleSceneSupportStaves ; 99/8F86

        ; Read by rlBattleSceneIsSupportStaff.

        .byte $58, $59, $5A, $5B, $5C, $5D, $5E, $5F, $61, $62, $FF

        ; 99/8F91

      aBattleSceneBarehandedClasses ; 99/8F91

        ; Read by rlBattleSceneCheckBarehandedClass.

        .word $0005, $0008, $0009, $000A, $0011, $001B, $001C, $FFFF

        ; 99/8FA1

    .endsection Data998F02Section


    .section DataE00060Section

      .al
      .xl

      aBattleSceneHUDBaseColors ; E0/0060

        ; Read by rlBattleSceneSetHUDColors.

        .word $4631, $318B, $7FFF, $1484, $4ACE, $1D64, $0CA0, $4ACE
        .word $0000, $3F80, $1CA2, $73FF, $0000, $35AC, $1508, $5F7B
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000

        ; E0/00B0

      aBattleSceneHUDColorPalette ; E0/00B0

        ; Read by rlBattleSceneDrawLevelUpWindow, rlBattleSceneHBlankNormalHUD, rlBattleSceneHBlankMode1MidHUD, rlBattleSceneShowLevelUpBanner.

        .byte $C4, $09, $85, $00, $F6, $7F, $1F, $00, $03, $00, $BF, $7F, $CE, $4A, $A4, $14
        .byte $FF, $7F, $00, $04, $D3, $57, $AA, $3E

        ; E0/00C8

      aBattleSceneMessageColors ; E0/00C8

        ; Read by rlBattleSceneLoadMessageColors, rlBattleSceneHBlankMode2HUD.

        .byte $00, $00, $5F, $4B, $78, $32, $F3, $25, $00, $00, $27, $00, $9F, $57, $5F, $13
        .byte $8B, $2D

        ; E0/00DA

      aBattleSceneMessageWindowMode3Colors ; E0/00DA

        ; Read by rlBattleSceneScriptInitMessageWindowMode3.

        .word $2D8C, $7FFF, $0C41, $7FFF, $4651, $7FFF, $2129, $4E69
        .word $28C4, $1042, $10E4, $14E6, $2504, $1CE4, $14C4, $03FF
        .word $6B7B, $635A, $5AF7, $4ED7, $3E75, $08C8, $0000, $318B
        .word $10E7, $5F7B, $039C, $5310, $4ACE, $46AD, $428C, $3A4A
        .word $04A7, $0000, $1D64, $0880, $4ACE, $039C, $4DAF, $498E
        .word $456D, $414C, $3D2B, $0866, $0000, $2CA7, $0401, $498E
        .word $03FF, $21AF, $1D8E, $196D, $154C, $152B, $04A7, $0000
        .word $04A7, $0021, $21AF, $039C, $39D2, $3190, $2D6F, $294E
        .word $252D, $1CC9, $0000, $18A8, $0003, $39D2, $039C, $420F
        .word $3DEE, $39CD, $35AC, $318B, $0C42, $0000, $1CE6, $0000
        .word $420F

        ; E0/017C

      aBattleSceneCharacterColors ; E0/017C

        ; Read by rlBattleSceneLoadCharacterColors.

        .word $0CC7, $1D2E, $2170, $3CC1, $758A, $7B93, $00C6, $0231
        .word $03DE, $00E3, $01C3, $43D3, $0009, $0092, $015C, $1CE7
        .word $4210, $6F7B, $100A, $3938, $5E3F, $14A5, $2529, $39CE
        .word $00AA, $0157, $021F, $0108, $0231, $0336

        ; E0/01B8

    .endsection DataE00060Section


    .section DataE02667Section

      .al
      .xl

      aTitleGraphicsPaletteE02667 ; E0/2667

        ; Read by rlLoadTitleGraphics.

        .word $5000, $3C00, $3400, $2800, $2800, $2C00, $2000, $1800
        .word $1800, $1C00, $1400, $1000, $0400, $0800, $0800, $021F
        .word $1FFF, $7FFF, $7F15, $7E51, $7D71, $7F80, $7E4A, $7D47
        .word $7CE7, $7CA4, $7C20, $6C00, $5800, $4400, $4210, $021F
        .word $1FFF, $7FFF, $7F15, $7E51, $7D71, $7F80, $7E4A, $7D47
        .word $7CE7, $7CA4, $7C20, $6C00, $5800, $4400

        ; E0/26C3

      aTitleScreenPalette1 ; E0/26C3

        ; Read by rlLoadTitleGraphics.

        .word $42DC, $0C66, $7FDF, $479F, $371C, $2EDA, $1E99, $1E77
        .word $01B8, $0175, $0153, $00F0, $00EE, $110B, $0823

        ; E0/26E1

      aTitleScreenPalette2 ; E0/26E1

        ; Read by rlLoadTitleGraphics.

        .word $3678, $7FFF, $6316, $4E74, $4211, $3E10, $3DF0, $39EF
        .word $6271, $5E6F, $4DEA, $452C, $612A, $4927, $48A6

        ; E0/26FF

      aTitleScreenPalette3 ; E0/26FF

        ; Read by rlLoadTitleGraphics.

        .word $0000, $1D2B, $2DCF, $3A54, $3A32, $6E00, $256C, $46B6
        .word $475C, $6F6F, $6EE0, $14C6, $6DC0, $54C0, $0C84

        ; E0/271D

      aTitleScreenPalette4 ; E0/271D

        ; Read by rlLoadTitleGraphics.

        .word $0014, $2550, $0442, $7FFF, $373D, $0257, $01F8, $0173
        .word $00EE, $0069, $6316, $422C, $3A8A, $3942, $01C8

        ; E0/273B

      aTitleLogoGlintColors ; E0/273B

        ; Read by rlStartTitleLogoGlintScroll.

        .word $1084, $2108, $318C, $4265, $318C, $4210, $18C6, $4265
        .word $296B, $1084, $18C6, $4265

      aTitleLogoPaletteE02753 ; E0/2753

        .word $18C6, $2108, $18C6

        ; E0/2759

      aTitleScreenPalette5 ; E0/2759

        ; Read by rlLoadTitleGraphics.

        .word $14C7, $32FB, $0000, $1E99, $1A56, $11B8, $0D54, $0D32

        ; E0/2769

      aTitleScreenPalette6 ; E0/2769

        ; Read by rlLoadTitleGraphics.

        .word $2E36, $7FFF, $56B3, $4A53, $4211, $31CF, $2D8D, $256C
        .word $5E50, $520C, $49C9, $5949, $4908, $34E7, $18A6

        ; E0/2787

      aTitleIntroPalette1 ; E0/2787

        ; Read by rlLoadTitleIntroGraphics.

        .word $0000, $0421, $0842, $14A5, $18C6, $1CE7, $2108, $2529
        .word $294A, $2D6B, $35AD, $3DEF, $4A52, $56B5, $6739

      aBattleScenePaletteE027A5 ; E0/27A5

        .word $7E60
        .word $7E82, $7A84, $7AA5, $76C7, $76C9, $76EB, $730C, $730E
        .word $6F30, $6F52, $6F53, $73B7, $53BF, $7FFF

        ; E0/27C3

      aBattleSceneAstraColors ; E0/27C3

        ; Read by rlBattleSceneShowAstra.

        .word $7FFF, $43E0, $0360, $0240, $0120

        ; E0/27CD

      aBattleSceneLunaColors ; E0/27CD

        ; Read by rlBattleSceneShowLuna.

        .word $7FFF, $7F57, $7E90, $7DE8, $7D20

        ; E0/27D7

      aBattleSceneSolColors ; E0/27D7

        ; Read by rlBattleSceneShowSol.

        .word $03FF, $035F, $029F, $01DF, $013F

        ; E0/27E1

      aBattleSceneHolyColors ; E0/27E1

        ; Read by rlBattleSceneShowHoly.

        .word $7FFF, $5F7F, $42FF, $227F, $01FF

        ; E0/27EB

      aBattleSceneDarknessColors ; E0/27EB

        ; Read by rlBattleSceneShowDarkness.

        .word $7C1C, $7C19, $7C15, $7C12, $7C0F

        ; E0/27F5

      aBattleScenePaviseColors ; E0/27F5

        ; Read by rlBattleSceneShowPavise.

        .word $7FE0, $7F20, $7E80, $7E20, $7DA0

        ; E0/27FF

    .endsection DataE02667Section


    .section Data99F6C1Section

      .al
      .xl

      aTitleSceneSpriteAnimScript1 ; 99/F6C1
        .byte $01, $03, $02, $03, $03, $03, $04, $03, $80, $04
      aTitleSceneSpriteAnimScript2 ; 99/F6CB
        .byte $05, $03, $06, $03, $07, $03, $08, $03, $80, $04
      aTitleSceneSpriteAnimScript3 ; 99/F6D5
        .byte $09, $03, $0A, $03, $0B, $03, $0C, $03, $80, $04
      aTitleSceneSpriteAnimScript4 ; 99/F6DF
        .byte $01, $03, $02, $03, $03, $03, $04, $03, $0D, $03, $0E, $03, $0F, $03, $10, $03
        .byte $80, $04
      aTitleSceneSpriteAnimScript5 ; 99/F6F1
        .byte $05, $03, $06, $03, $07, $03, $08, $03, $15, $03, $16, $03, $17, $03, $18, $03
        .byte $80, $04
      aTitleSceneSpriteAnimScript6 ; 99/F703
        .byte $09, $03, $0A, $03, $0B, $03, $0C, $03, $19, $03, $1A, $03, $1B, $03, $1C, $03
        .byte $80, $04

      aTitleSceneSpriteFrameTable1 ; 99/F715

        .word _F715_F74D - aTitleSceneSpriteFrameTable1
        .word _F715_F76D - aTitleSceneSpriteFrameTable1
        .word _F715_F78D - aTitleSceneSpriteFrameTable1
        .word _F715_F7AD - aTitleSceneSpriteFrameTable1
        .word _F715_F7CD - aTitleSceneSpriteFrameTable1
        .word _F715_F7D4 - aTitleSceneSpriteFrameTable1
        .word _F715_F7DB - aTitleSceneSpriteFrameTable1
        .word _F715_F7E2 - aTitleSceneSpriteFrameTable1
        .word _F715_F7E9 - aTitleSceneSpriteFrameTable1
        .word _F715_F7F0 - aTitleSceneSpriteFrameTable1
        .word _F715_F7F7 - aTitleSceneSpriteFrameTable1
        .word _F715_F7FE - aTitleSceneSpriteFrameTable1
        .word _F715_F805 - aTitleSceneSpriteFrameTable1
        .word _F715_F825 - aTitleSceneSpriteFrameTable1
        .word _F715_F845 - aTitleSceneSpriteFrameTable1
        .word _F715_F865 - aTitleSceneSpriteFrameTable1
        .word _F715_F885 - aTitleSceneSpriteFrameTable1
        .word _F715_F8A5 - aTitleSceneSpriteFrameTable1
        .word _F715_F8C5 - aTitleSceneSpriteFrameTable1
        .word _F715_F8E5 - aTitleSceneSpriteFrameTable1
        .word _F715_F905 - aTitleSceneSpriteFrameTable1
        .word _F715_F90C - aTitleSceneSpriteFrameTable1
        .word _F715_F913 - aTitleSceneSpriteFrameTable1
        .word _F715_F91A - aTitleSceneSpriteFrameTable1
        .word _F715_F921 - aTitleSceneSpriteFrameTable1
        .word _F715_F928 - aTitleSceneSpriteFrameTable1
        .word _F715_F92F - aTitleSceneSpriteFrameTable1
        .word _F715_F936 - aTitleSceneSpriteFrameTable1

      _F715_F74D ; 99/F74D
        .byte $06, $00, $00, $00, $04, $21, $38, $F8, $01, $04, $20, $38, $00, $00, $FC, $11
        .byte $38, $F8, $01, $FC, $10, $38, $00, $00, $F4, $01, $38, $F8, $01, $F4, $00, $38

      _F715_F76D ; 99/F76D
        .byte $06, $00, $00, $00, $04, $23, $38, $F8, $01, $04, $22, $38, $00, $00, $FC, $13
        .byte $38, $F8, $01, $FC, $12, $38, $00, $00, $F4, $03, $38, $F8, $01, $F4, $02, $38

      _F715_F78D ; 99/F78D
        .byte $06, $00, $00, $00, $04, $25, $38, $F8, $01, $04, $24, $38, $00, $00, $FC, $15
        .byte $38, $F8, $01, $FC, $14, $38, $00, $00, $F4, $05, $38, $F8, $01, $F4, $04, $38

      _F715_F7AD ; 99/F7AD
        .byte $06, $00, $00, $00, $04, $27, $38, $F8, $01, $04, $26, $38, $00, $00, $FC, $17
        .byte $38, $F8, $01, $FC, $16, $38, $00, $00, $F4, $07, $38, $F8, $01, $F4, $06, $38

      _F715_F7CD ; 99/F7CD
        .byte $01, $00, $FC, $01, $FC, $08, $00

      _F715_F7D4 ; 99/F7D4
        .byte $01, $00, $FC, $01, $FC, $0A, $00

      _F715_F7DB ; 99/F7DB
        .byte $01, $00, $FC, $01, $FC, $0C, $00

      _F715_F7E2 ; 99/F7E2
        .byte $01, $00, $FC, $01, $FC, $0E, $00

      _F715_F7E9 ; 99/F7E9
        .byte $01, $00, $FB, $C3, $F6, $18, $38

      _F715_F7F0 ; 99/F7F0
        .byte $01, $00, $FB, $C3, $F6, $1A, $38

      _F715_F7F7 ; 99/F7F7
        .byte $01, $00, $FB, $C3, $F6, $1C, $38

      _F715_F7FE ; 99/F7FE
        .byte $01, $00, $FB, $C3, $F6, $1E, $38

      _F715_F805 ; 99/F805
        .byte $06, $00, $00, $00, $04, $91, $38, $F8, $01, $04, $90, $38, $00, $00, $FC, $81
        .byte $38, $F8, $01, $FC, $80, $38, $00, $00, $F4, $71, $38, $F8, $01, $F4, $70, $38

      _F715_F825 ; 99/F825
        .byte $06, $00, $00, $00, $04, $93, $38, $F8, $01, $04, $92, $38, $00, $00, $FC, $83
        .byte $38, $F8, $01, $FC, $82, $38, $00, $00, $F4, $73, $38, $F8, $01, $F4, $72, $38

      _F715_F845 ; 99/F845
        .byte $06, $00, $00, $00, $04, $95, $38, $F8, $01, $04, $94, $38, $00, $00, $FC, $85
        .byte $38, $F8, $01, $FC, $84, $38, $00, $00, $F4, $75, $38, $F8, $01, $F4, $74, $38

      _F715_F865 ; 99/F865
        .byte $06, $00, $00, $00, $04, $97, $38, $F8, $01, $04, $96, $38, $00, $00, $FC, $87
        .byte $38, $F8, $01, $FC, $86, $38, $00, $00, $F4, $77, $38, $F8, $01, $F4, $76, $38

      _F715_F885 ; 99/F885
        .byte $06, $00, $00, $00, $04, $99, $38, $F8, $01, $04, $98, $38, $00, $00, $FC, $89
        .byte $38, $F8, $01, $FC, $88, $38, $00, $00, $F4, $79, $38, $F8, $01, $F4, $78, $38

      _F715_F8A5 ; 99/F8A5
        .byte $06, $00, $00, $00, $04, $9B, $38, $F8, $01, $04, $9A, $38, $00, $00, $FC, $8B
        .byte $38, $F8, $01, $FC, $8A, $38, $00, $00, $F4, $7B, $38, $F8, $01, $F4, $7A, $38

      _F715_F8C5 ; 99/F8C5
        .byte $06, $00, $00, $00, $04, $9D, $38, $F8, $01, $04, $9C, $38, $00, $00, $FC, $8D
        .byte $38, $F8, $01, $FC, $8C, $38, $00, $00, $F4, $7D, $38, $F8, $01, $F4, $7C, $38

      _F715_F8E5 ; 99/F8E5
        .byte $06, $00, $00, $00, $04, $9F, $38, $F8, $01, $04, $9E, $38, $00, $00, $FC, $8F
        .byte $38, $F8, $01, $FC, $8E, $38, $00, $00, $F4, $7F, $38, $F8, $01, $F4, $7E, $38

      _F715_F905 ; 99/F905
        .byte $01, $00, $FC, $01, $FC, $0E, $80

      _F715_F90C ; 99/F90C
        .byte $01, $00, $FC, $01, $FC, $0A, $80

      _F715_F913 ; 99/F913
        .byte $01, $00, $FC, $01, $FC, $0C, $80

      _F715_F91A ; 99/F91A
        .byte $01, $00, $FC, $01, $FC, $0E, $80

      _F715_F921 ; 99/F921
        .byte $01, $00, $FB, $C3, $F6, $18, $08

      _F715_F928 ; 99/F928
        .byte $01, $00, $FB, $C3, $F6, $1A, $B8

      _F715_F92F ; 99/F92F
        .byte $01, $00, $FB, $C3, $F6, $1C, $B8

      _F715_F936 ; 99/F936
        .byte $01, $00, $FB, $C3, $F6, $1E, $B8

        ; 99/F93D
      aTitleSceneCrusaderAnimScript01 ; 99/F93D
        .byte $01, $10, $80, $01
      aTitleSceneCrusaderAnimScript02 ; 99/F941
        .byte $02, $10, $80, $01
      aTitleSceneCrusaderAnimScript03 ; 99/F945
        .byte $03, $10, $80, $01
      aTitleSceneCrusaderAnimScript04 ; 99/F949
        .byte $04, $10, $80, $01
      aTitleSceneCrusaderAnimScript05 ; 99/F94D
        .byte $05, $10, $80, $01
      aTitleSceneCrusaderAnimScript06 ; 99/F951
        .byte $06, $10, $80, $01
      aTitleSceneCrusaderAnimScript07 ; 99/F955
        .byte $07, $10, $80, $01
      aTitleSceneCrusaderAnimScript08 ; 99/F959
        .byte $08, $10, $80, $01
      aTitleSceneCrusaderAnimScript09 ; 99/F95D
        .byte $09, $10, $80, $01
      aTitleSceneCrusaderAnimScript10 ; 99/F961
        .byte $0A, $10, $80, $01
      aTitleSceneCrusaderAnimScript11 ; 99/F965
        .byte $0B, $10, $80, $01
      aTitleSceneCrusaderAnimScript12 ; 99/F969
        .byte $0C, $10, $80, $01

      aTitleSceneCrusaderFrameTable ; 99/F96D

        .word _F96D_F985 - aTitleSceneCrusaderFrameTable
        .word _F96D_F99B - aTitleSceneCrusaderFrameTable
        .word _F96D_F9B1 - aTitleSceneCrusaderFrameTable
        .word _F96D_F9C7 - aTitleSceneCrusaderFrameTable
        .word _F96D_F9DD - aTitleSceneCrusaderFrameTable
        .word _F96D_F9F3 - aTitleSceneCrusaderFrameTable
        .word _F96D_FA09 - aTitleSceneCrusaderFrameTable
        .word _F96D_FA1F - aTitleSceneCrusaderFrameTable
        .word _F96D_FA35 - aTitleSceneCrusaderFrameTable
        .word _F96D_FA4B - aTitleSceneCrusaderFrameTable
        .word _F96D_FA61 - aTitleSceneCrusaderFrameTable
        .word _F96D_FA77 - aTitleSceneCrusaderFrameTable

      _F96D_F985 ; 99/F985
        .byte $04, $00, $00, $C2, $00, $22, $3E, $F0, $C3, $00, $20, $3E, $00, $C2, $F0, $02
        .byte $3E, $F0, $C3, $F0, $00, $3E

      _F96D_F99B ; 99/F99B
        .byte $04, $00, $00, $C2, $00, $26, $3E, $F0, $C3, $00, $24, $3E, $00, $C2, $F0, $06
        .byte $3E, $F0, $C3, $F0, $04, $3E

      _F96D_F9B1 ; 99/F9B1
        .byte $04, $00, $00, $C2, $00, $2A, $3E, $F0, $C3, $00, $28, $3E, $00, $C2, $F0, $0A
        .byte $3E, $F0, $C3, $F0, $08, $3E

      _F96D_F9C7 ; 99/F9C7
        .byte $04, $00, $00, $C2, $00, $2E, $3E, $F0, $C3, $00, $2C, $3E, $00, $C2, $F0, $0E
        .byte $3E, $F0, $C3, $F0, $0C, $3E

      _F96D_F9DD ; 99/F9DD
        .byte $04, $00, $00, $C2, $00, $62, $3E, $F0, $C3, $00, $60, $3E, $00, $C2, $F0, $42
        .byte $3E, $F0, $C3, $F0, $40, $3E

      _F96D_F9F3 ; 99/F9F3
        .byte $04, $00, $00, $C2, $00, $66, $3E, $F0, $C3, $00, $64, $3E, $00, $C2, $F0, $46
        .byte $3E, $F0, $C3, $F0, $44, $3E

      _F96D_FA09 ; 99/FA09
        .byte $04, $00, $00, $C2, $00, $6A, $3E, $F0, $C3, $00, $68, $3E, $00, $C2, $F0, $4A
        .byte $3E, $F0, $C3, $F0, $48, $3E

      _F96D_FA1F ; 99/FA1F
        .byte $04, $00, $00, $C2, $00, $6E, $3E, $F0, $C3, $00, $6C, $3E, $00, $C2, $F0, $4E
        .byte $3E, $F0, $C3, $F0, $4C, $3E

      _F96D_FA35 ; 99/FA35
        .byte $04, $00, $00, $C2, $00, $A2, $3E, $F0, $C3, $00, $A0, $3E, $00, $C2, $F0, $82
        .byte $3E, $F0, $C3, $F0, $80, $3E

      _F96D_FA4B ; 99/FA4B
        .byte $04, $00, $00, $C2, $00, $A6, $3E, $F0, $C3, $00, $A4, $3E, $00, $C2, $F0, $86
        .byte $3E, $F0, $C3, $F0, $84, $3E

      _F96D_FA61 ; 99/FA61
        .byte $04, $00, $00, $C2, $00, $AA, $3E, $F0, $C3, $00, $A8, $3E, $00, $C2, $F0, $8A
        .byte $3E, $F0, $C3, $F0, $88, $3E

      _F96D_FA77 ; 99/FA77
        .byte $04, $00, $00, $C2, $00, $AE, $3E, $F0, $C3, $00, $AC, $3E, $00, $C2, $F0, $8E
        .byte $3E, $F0, $C3, $F0, $8C, $3E

    .endsection Data99F6C1Section


    .section BattleAnimationEffectData9BSection

      .al
      .xl

      aBattleScenePaletteScript9BC16F ; 9B/C16F
        .byte $82, $04, $21, $04, $21, $08, $42, $08, $63, $0C, $83, $0C, $84, $10, $A4, $10
        .byte $C5, $14, $C6, $14, $E6, $19, $07, $19, $08, $1D, $28, $1D, $49, $25, $8B, $2D
        .byte $CD, $29, $AC, $29, $8C, $21, $6A, $21, $49, $1D, $28, $19, $08, $18, $E7, $18
        .byte $E7, $14, $C6, $0C, $84, $08, $63, $08, $42, $04, $42, $04, $21, $00, $00, $00
        .byte $00, $04, $21, $04, $41, $08, $42, $08, $63, $0C, $84, $FF

      aBattleScenePaletteScript9BC1BB ; 9B/C1BB
        .byte $82, $19, $08, $18, $E7, $18, $E7, $14, $C6, $0C, $84, $08, $63, $08, $42, $04
        .byte $42, $04, $21, $00, $00, $00, $00, $04, $21, $04, $41, $08, $42, $08, $63, $0C
        .byte $84, $FF

      aBattleScenePaletteScript9BC1DD ; 9B/C1DD
        .byte $82, $14, $C6, $18, $E7, $18, $E7, $19, $08, $1D, $28, $21, $49, $21, $6A, $29
        .byte $8C, $31, $EE, $3E, $51, $3E, $51, $31, $EE, $29, $8C, $21, $6A, $21, $49, $1D
        .byte $28, $FF

      aBattleScenePaletteScript9BC1FF ; 9B/C1FF
        .byte $82, $08, $62, $08, $63, $0C, $83, $0C, $84, $0C, $A4, $10, $A4, $10, $A5, $10
        .byte $C5, $14, $C5, $14, $E6, $14, $E6, $14, $E6, $10, $C5, $10, $C5, $10, $A4, $0C
        .byte $A4, $0C, $84, $0C, $83, $08, $63, $08, $62, $08, $42, $04, $42, $04, $41, $04
        .byte $21, $00, $21, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $FF

      aBattleScenePaletteScript9BC241 ; 9B/C241
        .byte $80, $7F, $FF, $03, $FF, $02, $BF, $01, $BF, $00, $FF, $00, $BF, $00, $18, $00
        .byte $0B, $70, $1F, $40, $1F, $2C, $1B, $1C, $16, $14, $14, $0C, $12, $00, $0B, $00
        .byte $00, $7F, $FF, $FF

      aBattleScenePaletteScript9BC265 ; 9B/C265
        .byte $80, $7F, $FF, $03, $FF, $02, $BF, $01, $BF, $00, $FF, $00, $BF, $00, $18, $00
        .byte $0B, $70, $1F, $40, $1F, $2C, $1B, $1C, $16, $14, $14, $0C, $12, $00, $0B, $00
        .byte $00, $7F, $FF, $03, $FF, $02, $BF, $01, $BF, $00, $FF, $00, $BF, $00, $18, $00
        .byte $0B, $70, $1F, $40, $1F, $2C, $1B, $1C, $16, $14, $14, $0C, $12, $00, $0B, $00
        .byte $00, $7F, $FF, $03, $FF, $02, $BF, $01, $BF, $00, $FF, $00, $BF, $00, $18, $00
        .byte $0B, $70, $1F, $40, $1F, $2C, $1B, $1C, $16, $14, $14, $0C, $12, $00, $0B, $00
        .byte $00, $7F, $FF, $03, $FF, $02, $BF, $01, $BF, $00, $FF, $00, $BF, $00, $18, $00
        .byte $0B, $70, $1F, $40, $1F, $2C, $1B, $1C, $16, $14, $14, $0C, $12, $00, $0B, $00
        .byte $00, $FF

      aBattleScenePaletteScript9BC2E7 ; 9B/C2E7
        .byte $81, $43, $FF, $43, $FF, $03, $1C, $02, $DA, $02, $37, $01, $B4, $01, $73, $01
        .byte $52, $01, $31, $01, $10, $00, $EF, $00, $CE, $00, $6C, $00, $6C, $00, $CE, $00
        .byte $EF, $01, $10, $01, $31, $01, $52, $01, $73, $01, $B4, $02, $37, $02, $DA, $03
        .byte $1C, $43, $FF, $FF

      aBattleScenePaletteScript9BC31B ; 9B/C31B
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $81, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $04, $00, $03, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $01, $00, $02, $00, $03, $00, $05, $00, $08, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $02, $00, $02, $00, $04, $00, $07, $00
        .byte $0D, $00, $13, $00, $16, $00, $3D, $82, $00, $00, $00, $00, $00, $02, $00, $05
        .byte $00, $09, $00, $0D, $00, $10, $00, $14, $00, $16, $00, $5A, $01, $5B, $01, $5B
        .byte $01, $7D, $01, $9F, $02, $1F, $81, $00, $02, $00, $05, $00, $09, $00, $0D, $00
        .byte $10, $00, $14, $00, $16, $00, $5A, $01, $5B, $01, $5B, $01, $7D, $01, $9F, $02
        .byte $1F, $02, $BF, $03, $5F, $82, $00, $0D, $00, $10, $00, $14, $00, $16, $00, $5A
        .byte $01, $5B, $01, $5B, $01, $7D, $01, $9F, $02, $1F, $02, $BF, $03, $5F, $03, $FF
        .byte $1F, $FF, $43, $FF, $00, $02, $00, $00, $00, $05, $00, $09, $00, $0D, $00, $10
        .byte $00, $14, $00, $16, $00, $5A, $01, $5B, $01, $5B, $01, $7D, $01, $9F, $02, $1F
        .byte $02, $BF, $FF

      aBattleScenePaletteScript9BC42E ; 9B/C42E
        .byte $80, $02, $FF, $03, $5F, $00, $0F, $00, $0F, $00, $0C, $00, $0F, $00, $10, $00
        .byte $15, $00, $96, $00, $D9, $01, $38, $01, $1A, $01, $D8, $01, $FB, $02, $1C, $1A
        .byte $DC, $FF

      aBattleScenePaletteScript9BC450 ; 9B/C450
        .byte $82, $00, $0D, $00, $10, $00, $14, $00, $16, $00, $5A, $01, $5B, $01, $5B, $01
        .byte $7D, $01, $9F, $02, $1F, $02, $BF, $03, $5F, $03, $FF, $1F, $FF, $43, $FF, $00
        .byte $02, $00, $00, $00, $05, $00, $09, $00, $0D, $00, $10, $00, $14, $00, $16, $00
        .byte $5A, $01, $5B, $01, $5B, $01, $7D, $01, $9F, $02, $1F, $02, $BF, $00, $0D, $00
        .byte $10, $00, $14, $00, $16, $00, $5A, $01, $5B, $01, $5B, $01, $7D, $01, $9F, $02
        .byte $1F, $02, $BF, $03, $5F, $03, $FF, $1F, $FF, $43, $FF, $00, $02, $00, $00, $00
        .byte $05, $00, $09, $00, $0D, $00, $10, $00, $14, $00, $16, $00, $5A, $01, $5B, $01
        .byte $5B, $01, $7D, $01, $9F, $02, $1F, $02, $BF, $83, $00, $00, $00, $00, $00, $02
        .byte $00, $00, $00, $05, $00, $09, $00, $0D, $00, $10, $00, $14, $00, $16, $00, $5A
        .byte $01, $5B, $01, $5B, $01, $7D, $01, $9F, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $02, $00, $02, $00, $05, $00, $09, $00, $0D, $00, $10, $00, $14
        .byte $00, $16, $00, $5A, $01, $5B, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $02, $00, $05, $00, $09, $00, $0D, $00, $10
        .byte $00, $14, $00, $16, $81, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $02, $00, $05, $00, $09, $00
        .byte $0D, $00, $10, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $02, $00, $05, $00
        .byte $09, $80, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $02
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $FF

      aBattleScenePaletteScript9BC59F ; 9B/C59F
        .byte $81, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $01, $04, $02, $04
        .byte $02, $04, $03, $04, $03, $04, $04, $04, $04, $04, $05, $04, $05, $08, $05, $08
        .byte $06, $08, $06, $08, $07, $08, $06, $0C, $08, $14, $09, $18, $0B, $20, $0D, $24
        .byte $0E, $28, $10, $30, $12, $34, $13, $3C, $15, $40, $17, $44, $18, $4C, $1A, $50
        .byte $1C, $54, $1D, $5C, $1F, $5C, $1F, $54, $1E, $50, $1D, $48, $1C, $44, $1B, $3C
        .byte $1A, $38, $19, $30, $18, $2C, $17, $24, $15, $20, $14, $18, $13, $14, $12, $0C
        .byte $11, $FF

      aBattleScenePaletteScript9BC601 ; 9B/C601
        .byte $81, $08, $10, $00, $0F, $00, $0F, $08, $10, $0C, $11, $14, $12, $18, $13, $20
        .byte $14, $24, $15, $2C, $16, $30, $18, $38, $19, $3C, $1A, $44, $1B, $48, $1C, $50
        .byte $1D, $54, $1E, $5C, $1F, $5C, $1F, $54, $1E, $50, $1D, $48, $1C, $44, $1B, $3C
        .byte $1A, $38, $19, $30, $18, $2C, $17, $24, $15, $20, $14, $18, $13, $14, $12, $0C
        .byte $11, $FE

      aBattleScenePaletteScript9BC643 ; 9B/C643
        .byte $81, $14, $0B, $18, $0B, $18, $0B, $18, $0B, $14, $0A, $14, $0A, $14, $09, $10
        .byte $09, $10, $08, $10, $08, $0C, $07, $0C, $07, $0C, $06, $08, $06, $08, $06, $08
        .byte $05, $04, $05, $04, $04, $04, $04, $04, $04, $04, $03, $04, $03, $04, $03, $04
        .byte $03, $04, $02, $04, $02, $04, $02, $00, $02, $00, $01, $00, $01, $00, $01, $00
        .byte $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $FF

      aBattleScenePaletteScript9BC6A5 ; 9B/C6A5
        .byte $81, $00, $00, $00, $21, $00, $22, $00, $43, $00, $64, $00, $85, $00, $86, $00
        .byte $A7, $00, $E7, $01, $06, $01, $25, $01, $44, $01, $83, $01, $A2, $01, $C1, $01
        .byte $E0, $80, $01, $E4, $01, $E6, $02, $08, $02, $09, $02, $0B, $02, $0D, $02, $2F
        .byte $02, $31, $02, $32, $02, $34, $02, $56, $02, $58, $02, $5A, $02, $5B, $02, $7D
        .byte $02, $7F, $FF

      aBattleScenePaletteScript9BC6E8 ; 9B/C6E8
        .byte $80, $03, $E8, $03, $E4, $03, $E4, $03, $E7, $03, $EB, $03, $EE, $03, $F2, $03
        .byte $F5, $03, $F8, $03, $FC, $03, $FF, $03, $FF, $03, $BF, $03, $7F, $03, $3F, $02
        .byte $FF, $02, $BF, $02, $7F, $01, $FF, $02, $3F, $02, $7F, $02, $BF, $02, $FF, $03
        .byte $3F, $03, $7F, $03, $BF, $03, $FF, $03, $FB, $03, $F7, $03, $F3, $03, $F0, $03
        .byte $EC, $03, $E8, $03, $E4, $03, $E4, $03, $E7, $03, $EB, $03, $EE, $03, $F2, $03
        .byte $F5, $03, $F8, $03, $FC, $03, $FF, $03, $FF, $03, $BF, $03, $7F, $03, $3F, $02
        .byte $FF, $02, $BF, $02, $7F, $01, $FF, $02, $3F, $02, $7F, $02, $BF, $02, $FF, $03
        .byte $3F, $03, $7F, $03, $BF, $03, $FF, $03, $FB, $03, $F7, $03, $F3, $03, $F0, $03
        .byte $EC, $03, $E8, $03, $E4, $03, $E4, $03, $E7, $03, $EB, $03, $EE, $03, $F2, $03
        .byte $F5, $03, $F8, $03, $FC, $03, $FF, $03, $FF, $03, $BF, $03, $7F, $03, $3F, $02
        .byte $FF, $02, $BF, $02, $7F, $01, $FF, $02, $3F, $02, $7F, $02, $BF, $02, $FF, $03
        .byte $3F, $03, $7F, $03, $BF, $03, $FF, $03, $FB, $03, $F7, $03, $F3, $03, $F0, $03
        .byte $EC, $03, $E8, $03, $E4, $03, $E4, $03, $E7, $03, $EB, $03, $EE, $03, $F2, $03
        .byte $F5, $03, $F8, $03, $FC, $03, $FF, $03, $FF, $03, $BF, $03, $7F, $03, $3F, $02
        .byte $FF, $02, $BF, $02, $7F, $01, $FF, $02, $3F, $02, $7F, $02, $BF, $02, $FF, $03
        .byte $3F, $03, $7F, $03, $BF, $03, $FF, $03, $FB, $03, $F7, $03, $F3, $03, $F0, $03
        .byte $EC, $03, $E8, $03, $E4, $03, $E4, $03, $E7, $03, $EB, $03, $EE, $03, $F2, $03
        .byte $F5, $03, $F8, $03, $FC, $03, $FF, $03, $FF, $03, $BF, $03, $7F, $03, $3F, $02
        .byte $FF, $02, $BF, $02, $7F, $01, $FF, $02, $3F, $02, $7F, $02, $BF, $02, $FF, $03
        .byte $3F, $03, $7F, $03, $BF, $03, $FF, $03, $FB, $03, $F7, $03, $F3, $03, $F0, $03
        .byte $EC, $FF

      aBattleScenePaletteScript9BC82A ; 9B/C82A
        .byte $81, $50, $A0, $4C, $A0, $44, $80, $40, $60, $38, $60, $34, $40, $2C, $20, $28
        .byte $20, $20, $00, $20, $00, $28, $20, $2C, $20, $34, $40, $38, $60, $40, $60, $44
        .byte $80, $4C, $A0, $50, $A0, $58, $C0, $5C, $E0, $64, $E0, $69, $00, $71, $20, $75
        .byte $20, $7D, $40, $7D, $40, $75, $20, $71, $20, $69, $00, $64, $E0, $5C, $E0, $58
        .byte $C0, $50, $A0, $4C, $A0, $44, $80, $40, $60, $38, $60, $34, $40, $2C, $20, $28
        .byte $20, $20, $00, $20, $00, $28, $20, $2C, $20, $34, $40, $38, $60, $40, $60, $44
        .byte $80, $4C, $A0, $50, $A0, $58, $C0, $5C, $E0, $64, $E0, $69, $00, $71, $20, $75
        .byte $20, $7D, $40, $7D, $40, $75, $20, $71, $20, $69, $00, $64, $E0, $5C, $E0, $58
        .byte $C0, $50, $A0, $4C, $A0, $44, $80, $40, $60, $38, $60, $34, $40, $2C, $20, $28
        .byte $20, $20, $00, $20, $00, $28, $20, $2C, $20, $34, $40, $38, $60, $40, $60, $44
        .byte $80, $4C, $A0, $50, $A0, $58, $C0, $5C, $E0, $64, $E0, $69, $00, $71, $20, $75
        .byte $20, $7D, $40, $7D, $40, $75, $20, $71, $20, $69, $00, $64, $E0, $5C, $E0, $58
        .byte $C0, $50, $A0, $4C, $A0, $44, $80, $40, $60, $38, $60, $34, $40, $2C, $20, $28
        .byte $20, $20, $00, $20, $00, $28, $20, $2C, $20, $34, $40, $38, $60, $40, $60, $44
        .byte $80, $4C, $A0, $50, $A0, $58, $C0, $5C, $E0, $64, $E0, $69, $00, $71, $20, $75
        .byte $20, $7D, $40, $7D, $40, $75, $20, $71, $20, $69, $00, $64, $E0, $5C, $E0, $58
        .byte $C0, $FF

      aBattleScenePaletteScript9BC92C ; 9B/C92C
        .byte $80, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $08, $40, $10, $60, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $08
        .byte $40, $10, $60, $18, $A0, $20, $C0, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $08, $40, $10, $60, $18, $A0, $20
        .byte $C0, $29, $00, $31, $20, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $08, $40, $10, $60, $18, $A0, $20, $C0, $29, $00, $31, $20, $39
        .byte $60, $45, $80, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $08, $40, $10
        .byte $60, $18, $A0, $20, $C0, $29, $00, $31, $20, $39, $60, $45, $80, $4D, $C0, $55
        .byte $E0, $00, $00, $00, $00, $00, $00, $08, $40, $10, $60, $18, $A0, $20, $C0, $29
        .byte $00, $31, $20, $39, $60, $45, $80, $4D, $C0, $55, $E0, $5E, $20, $66, $40, $92
        .byte $00, $00, $08, $40, $10, $60, $18, $A0, $20, $C0, $29, $00, $31, $20, $39, $60
        .byte $45, $80, $4D, $C0, $55, $E0, $5E, $20, $66, $40, $6E, $80, $6E, $80, $81, $00
        .byte $00, $08, $40, $10, $60, $18, $A0, $20, $C0, $29, $00, $31, $20, $39, $60, $45
        .byte $80, $4D, $C0, $55, $E0, $5E, $20, $66, $40, $6E, $80, $6E, $80, $00, $00, $08
        .byte $20, $10, $60, $14, $80, $1C, $A0, $24, $C0, $2D, $00, $35, $20, $39, $40, $41
        .byte $60, $49, $A0, $51, $C0, $59, $E0, $5E, $00, $66, $40, $00, $00, $08, $20, $0C
        .byte $40, $14, $60, $18, $80, $20, $A0, $24, $C0, $2C, $E0, $31, $00, $39, $20, $3D
        .byte $40, $45, $60, $49, $80, $51, $A0, $55, $C0, $00, $00, $04, $20, $0C, $20, $10
        .byte $40, $14, $60, $18, $80, $20, $80, $24, $A0, $28, $C0, $2C, $C0, $34, $E0, $39
        .byte $00, $3D, $20, $41, $20, $49, $40, $00, $00, $04, $00, $08, $20, $0C, $20, $10
        .byte $40, $14, $40, $18, $60, $1C, $60, $20, $80, $24, $80, $28, $A0, $2C, $A0, $30
        .byte $A0, $34, $C0, $38, $C0, $00, $00, $04, $00, $04, $00, $08, $20, $0C, $20, $10
        .byte $20, $10, $20, $14, $20, $18, $40, $18, $40, $1C, $40, $20, $40, $24, $40, $24
        .byte $40, $28, $60, $00, $00, $00, $00, $04, $00, $04, $00, $08, $00, $08, $00, $0C
        .byte $00, $0C, $00, $10, $00, $10, $00, $14, $00, $14, $00, $14, $00, $18, $00, $18
        .byte $00, $82, $00, $00, $00, $00, $00, $00, $04, $00, $04, $00, $04, $00, $04, $00
        .byte $04, $00, $08, $00, $08, $00, $08, $00, $08, $00, $08, $00, $08, $00, $0C, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $FF

      aBattleScenePaletteScript9BCB6B ; 9B/CB6B
        .byte $80, $3D, $CE, $0D, $EF, $3D, $EF, $3D, $CE, $3D, $AD, $3D, $8C, $3D, $6B, $3D
        .byte $4A, $3D, $29, $3D, $0E, $3C, $E7, $3C, $C6, $3C, $A5, $3C, $84, $3C, $63, $3C
        .byte $42, $3C, $21, $3C, $00, $3C, $00, $3C, $01, $3C, $42, $3C, $63, $3C, $84, $3C
        .byte $A5, $3C, $C6, $3D, $E7, $3D, $08, $3D, $29, $3D, $4A, $3D, $6B, $3D, $8C, $3D
        .byte $AD, $FE

      aBattleScenePaletteScript9BCBAD ; 9B/CBAD
        .byte $82, $00, $11, $00, $12, $00, $13, $00, $14, $00, $15, $00, $11, $00, $12, $00
        .byte $13, $00, $14, $00, $15, $FE

      aBattleScenePaletteScript9BCBC3 ; 9B/CBC3
        .byte $82, $7F, $FF, $4F, $FF, $0B, $1F, $12, $1F, $19, $DF, $00, $1D, $00, $1A, $00
        .byte $17, $00, $14, $FE

      aBattleScenePaletteScript9BCBD7 ; 9B/CBD7
        .byte $81, $00, $1A, $00, $17, $00, $14, $00, $11, $7F, $FF, $4F, $FF, $0B, $1F, $12
        .byte $1F, $19, $DF, $00, $1D, $FE

      aBattleScenePaletteScript9BCBED ; 9B/CBED
        .byte $82, $00, $11, $00, $12, $00, $13, $00, $14, $00, $15, $00, $11, $00, $12, $00
        .byte $13, $00, $14, $00, $15, $FE

      aBattleScenePaletteScript9BCC03 ; 9B/CC03
        .byte $82, $00, $11, $00, $15, $00, $14, $00, $13, $00, $12, $00, $11, $00, $15, $00
        .byte $14, $00, $13, $00, $12, $FE

      aBattleScenePaletteScript9BCC19 ; 9B/CC19
        .byte $82, $00, $1D, $00, $9F, $01, $5F, $12, $1F, $0B, $1F, $00, $1A, $00, $14, $00
        .byte $17, $00, $1A, $00, $1D, $19, $DF, $00, $14, $00, $13, $00, $12, $00, $11, $00
        .byte $15, $00, $14, $00, $13, $00, $12, $00, $11, $00, $15, $FE

      aBattleScenePaletteScript9BCC45 ; 9B/CC45
        .byte $84, $12, $1F, $0B, $1F, $00, $1A, $00, $14, $00, $17, $00, $1A, $00, $1D, $00
        .byte $1D, $00, $9F, $01, $5F, $00, $1D, $19, $DF, $00, $14, $00, $13, $00, $12, $00
        .byte $11, $00, $15, $00, $14, $00, $13, $00, $12, $00, $11, $00, $15, $FE

      aBattleScenePaletteScript9BCC73 ; 9B/CC73
        .byte $82, $00, $11, $00, $15, $00, $14, $00, $13, $00, $12, $00, $11, $00, $15, $00
        .byte $14, $00, $13, $00, $12, $FE

      aBattleScenePaletteScript9BCC89 ; 9B/CC89
        .byte $82, $00, $03, $00, $05, $00, $07, $00, $0A, $00, $0A, $00, $11, $00, $12, $00
        .byte $13, $00, $14, $00, $15, $FF

      aBattleScenePaletteScript9BCC9F ; 9B/CC9F
        .byte $82, $00, $0A, $00, $0D, $00, $15, $00, $11, $00, $14, $00, $17, $00, $1A, $00
        .byte $1D, $19, $DF, $FF

      aBattleScenePaletteScript9BCCB3 ; 9B/CCB3
        .byte $81, $00, $00, $00, $00, $00, $00, $00, $00, $00, $0A, $00, $0D, $00, $15, $00
        .byte $11, $00, $14, $00, $17, $00, $1A, $00, $1D, $19, $DF, $FF

      aBattleScenePaletteScript9BCCCF ; 9B/CCCF
        .byte $82, $00, $03, $00, $05, $00, $07, $00, $0A, $00, $0A, $00, $11, $00, $12, $00
        .byte $13, $00, $14, $00, $15, $FF

      aBattleScenePaletteScript9BCCE5 ; 9B/CCE5
        .byte $82, $00, $00, $00, $15, $00, $0E, $00, $0B, $00, $07, $00, $05, $00, $03, $00
        .byte $03, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $FF

      aBattleScenePaletteScript9BCD0F ; 9B/CD0F
        .byte $82, $00, $11, $00, $0F, $00, $0D, $00, $0B, $00, $0A, $00, $08, $00, $06, $00
        .byte $04, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $FF

      aBattleScenePaletteScript9BCD2D ; 9B/CD2D
        .byte $84, $00, $0B, $00, $0A, $00, $08, $00, $06, $00, $04, $00, $02, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $FF

      aBattleScenePaletteScript9BCD4B ; 9B/CD4B
        .byte $82, $00, $00, $00, $15, $00, $0E, $00, $0B, $00, $07, $00, $05, $00, $03, $00
        .byte $03, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $FF

      aBattleScenePaletteScript9BCD75 ; 9B/CD75
        .byte $81, $08, $03, $08, $02, $04, $02, $30, $05, $30, $65, $2C, $A4, $2D, $04, $2D
        .byte $44, $2D, $A4, $29, $E3, $2A, $43, $42, $A5, $3E, $87, $36, $6A, $32, $4C, $2A
        .byte $0F, $1D, $B1, $11, $94, $09, $36, $3C, $00, $38, $00, $34, $00, $30, $00, $28
        .byte $01, $24, $03, $20, $04, $1C, $06, $18, $05, $14, $05, $14, $04, $10, $04, $0C
        .byte $03, $FE

      aBattleScenePaletteScript9BCDB7 ; 9B/CDB7
        .byte $81, $18, $05, $18, $05, $18, $04, $18, $04, $18, $04, $18, $03, $18, $03, $18
        .byte $03, $18, $02, $18, $02, $18, $02, $18, $01, $18, $01, $18, $01, $18, $00, $18
        .byte $00, $18, $00, $18, $00, $18, $01, $18, $01, $18, $01, $18, $02, $18, $02, $18
        .byte $02, $18, $03, $18, $03, $18, $03, $18, $04, $18, $04, $18, $04, $18, $05, $18
        .byte $05, $FE

      aBattleScenePaletteScript9BCDF9 ; 9B/CDF9
        .byte $81, $00, $00, $00, $00, $00, $00, $00, $00, $04, $00, $08, $00, $0C, $00, $10
        .byte $00, $14, $00, $18, $00, $1C, $00, $20, $00, $24, $00, $28, $00, $2C, $00, $30
        .byte $00, $34, $00, $38, $00, $3C, $00, $30, $05, $30, $65, $2C, $A4, $2D, $04, $2D
        .byte $44, $2D, $A4, $29, $E3, $2A, $43, $42, $A5, $3E, $87, $36, $6A, $32, $4C, $2A
        .byte $0F, $FF

      aBattleScenePaletteScript9BCE3B ; 9B/CE3B
        .byte $81, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $04, $00, $04, $00, $08, $00, $08, $00, $08, $00, $0C
        .byte $00, $0C, $00, $10, $00, $10, $00, $10, $00, $14, $00, $14, $00, $14, $00, $18
        .byte $00, $FF

      aBattleScenePaletteScript9BCE7D ; 9B/CE7D
        .byte $81, $1D, $B1, $11, $94, $09, $36, $3C, $00, $38, $00, $34, $00, $30, $00, $2C
        .byte $00, $28, $00, $24, $00, $20, $00, $1C, $00, $18, $00, $14, $00, $10, $00, $0C
        .byte $00, $08, $00, $04, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $FF

      aBattleScenePaletteScript9BCEBF ; 9B/CEBF
        .byte $81, $18, $00, $18, $00, $14, $00, $14, $00, $10, $00, $10, $00, $10, $00, $0C
        .byte $00, $0C, $00, $08, $00, $08, $00, $08, $00, $04, $00, $04, $00, $04, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $FF

      aBattleScenePaletteScript9BCF01 ; 9B/CF01
        .byte $81, $00, $AE, $00, $F0, $01, $59, $01, $DA, $02, $5A, $03, $3D, $03, $9F, $43
        .byte $FF, $43, $FF, $03, $9F, $03, $3D, $02, $5A, $01, $DA, $01, $59, $00, $F0, $00
        .byte $28, $00, $28, $FE

      aBattleScenePaletteScript9BCF25 ; 9B/CF25
        .byte $FF

      aBattleScenePaletteScript9BCF26 ; 9B/CF26
        .byte $80, $3D, $AD, $3D, $CE, $0D, $EF, $3D, $EF, $3D, $CE, $3D, $AD, $3D, $8C, $3D
        .byte $6B, $3D, $4A, $3D, $29, $3D, $0E, $3C, $E7, $3C, $C6, $3C, $A5, $3C, $84, $3C
        .byte $63, $3C, $42, $3C, $21, $3C, $00, $3C, $00, $3C, $01, $3C, $42, $3C, $63, $3C
        .byte $84, $3C, $A5, $3C, $C6, $3D, $E7, $3D, $08, $3D, $29, $3D, $4A, $3D, $6B, $3D
        .byte $8C, $FE

      aBattleScenePaletteScript9BCF68 ; 9B/CF68
        .byte $80, $43, $A0, $47, $C0, $09, $60, $0D, $80, $11, $C0, $15, $E0, $1A, $00, $1E
        .byte $20, $22, $60, $26, $80, $2A, $A0, $2E, $C0, $33, $00, $37, $20, $3B, $40, $3F
        .byte $60, $43, $A0, $47, $C0, $09, $60, $0D, $80, $11, $C0, $15, $E0, $1A, $00, $1E
        .byte $20, $22, $60, $26, $80, $2A, $A0, $2E, $C0, $33, $00, $37, $20, $3B, $40, $3F
        .byte $60, $FE

      aBattleScenePaletteScript9BCFAA ; 9B/CFAA
        .byte $80, $00, $A0, $00, $80, $00, $80, $00, $80, $00, $60, $00, $60, $00, $60, $00
        .byte $60, $00, $40, $00, $40, $00, $40, $00, $40, $00, $20, $00, $20, $00, $20, $00
        .byte $20, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $FF

      aBattleScenePaletteScript9BCFEC ; 9B/CFEC
        .byte $81, $4C, $0E, $5C, $4E, $64, $4B, $64, $49, $60, $46, $5C, $25, $5C, $03, $5C
        .byte $03, $4C, $00, $2C, $00, $2C, $00, $4C, $00, $5C, $03, $5C, $03, $5C, $25, $60
        .byte $46, $64, $49, $64, $4B, $5C, $4E, $4C, $0E, $44, $0C, $3C, $0A, $38, $09, $34
        .byte $08, $30, $07, $24, $04, $24, $04, $30, $07, $34, $08, $38, $09, $3C, $0A, $44
        .byte $0C, $FE

      aBattleScenePaletteScript9BD02E ; 9B/D02E
        .byte $80, $01, $36, $01, $36, $01, $14, $00, $F2, $00, $CF, $00, $AD, $FE

      aBattleScenePaletteScript9BD03C ; 9B/D03C
        .byte $82, $48, $07, $40, $C0, $34, $A0, $2C, $80, $20, $60, $18, $20, $0C, $20, $08
        .byte $00, $00, $00, $00, $00, $7E, $10, $7C, $06, $FE

      aBattleScenePaletteScript9BD056 ; 9B/D056
        .byte $82, $00, $00, $00, $00, $18, $02, $18, $02, $14, $02, $14, $02, $10, $02, $10
        .byte $01, $10, $01, $0C, $01, $0C, $01, $08, $01, $08, $01, $08, $01, $04, $01, $04
        .byte $00, $FE

      aBattleScenePaletteScript9BD078 ; 9B/D078
        .byte $82, $00, $00, $00, $00, $7C, $06, $40, $05, $38, $80, $38, $80, $2C, $60, $24
        .byte $40, $18, $20, $10, $00, $0C, $20, $08, $00, $FF

      aBattleScenePaletteScript9BD092 ; 9B/D092
        .byte $82, $00, $00, $00, $00, $18, $02, $18, $02, $14, $02, $14, $02, $10, $02, $10
        .byte $01, $10, $01, $0C, $01, $0C, $01, $08, $01, $08, $01, $08, $01, $04, $01, $04
        .byte $00, $FF

      aBattleScenePaletteScript9BD0B4 ; 9B/D0B4
        .byte $82, $48, $07, $40, $C0, $34, $A0, $2C, $80, $20, $60, $18, $20, $0C, $20, $0C
        .byte $20, $0C, $20, $08, $20, $08, $20, $08, $20, $08, $20, $04, $00, $04, $00, $04
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $FF

      aBattleScenePaletteScript9BD0F8 ; 9B/D0F8
        .byte $82, $00, $00, $00, $00, $18, $02, $18, $02, $14, $02, $14, $02, $10, $02, $10
        .byte $01, $10, $01, $0C, $01, $0C, $01, $08, $01, $08, $01, $08, $01, $04, $01, $04
        .byte $00, $04, $00, $00, $00, $18, $02, $18, $02, $14, $02, $14, $02, $10, $02, $10
        .byte $01, $10, $01, $0C, $01, $0C, $01, $08, $01, $08, $01, $08, $01, $04, $01, $04
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $FF

      aBattleScenePaletteScript9BD158 ; 9B/D158
        .byte $88, $00, $05, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $07, $00, $0B, $86
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $0C, $00, $10, $00, $17, $01, $5D, $85, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $0C, $00, $10, $00, $17, $01, $5D, $02, $1F, $02, $BF, $84, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $0C, $00, $10
        .byte $00, $17, $01, $5D, $02, $1F, $02, $BF, $02, $FF, $03, $5F, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $0C, $00, $10, $00, $17, $01, $5D, $02, $1F
        .byte $02, $BF, $02, $FF, $03, $5F, $37, $9F, $37, $9F, $00, $00, $00, $00, $00, $0C
        .byte $00, $10, $00, $17, $01, $5D, $02, $1F, $02, $BF, $02, $FF, $03, $5F, $37, $9F
        .byte $37, $9F, $37, $9F, $37, $9F, $37, $9F, $00, $06, $00, $0C, $00, $10, $00, $17
        .byte $01, $5D, $02, $1F, $02, $BF, $02, $FF, $03, $5F, $37, $9F, $37, $9F, $37, $9F
        .byte $37, $9F, $37, $9F, $37, $9F, $00, $0C, $00, $10, $00, $17, $01, $5D, $02, $1F
        .byte $02, $BF, $02, $FF, $03, $5F, $37, $9F, $37, $9F, $37, $9F, $37, $9F, $37, $9F
        .byte $37, $9F, $37, $9F, $86, $37, $9F, $37, $9F, $37, $9F, $37, $9F, $37, $9F, $03
        .byte $5F, $03, $5F, $03, $5F, $02, $FF, $02, $BF, $02, $1F, $01, $5D, $00, $17, $00
        .byte $14, $00, $10, $83, $37, $9F, $37, $9F, $37, $9F, $03, $5F, $03, $5F, $03, $5F
        .byte $02, $FF, $02, $BF, $02, $1F, $01, $5D, $00, $17, $00, $14, $00, $10, $00, $0C
        .byte $00, $0A, $37, $9F, $03, $5F, $03, $5F, $03, $5F, $02, $FF, $02, $BF, $02, $1F
        .byte $01, $5D, $00, $17, $00, $14, $00, $0E, $00, $0C, $00, $06, $00, $06, $00, $06
        .byte $82, $03, $5F, $02, $FF, $02, $BF, $02, $1F, $01, $5D, $00, $17, $00, $14, $00
        .byte $10, $00, $0C, $00, $06, $00, $06, $00, $06, $00, $06, $00, $05, $00, $04, $81
        .byte $01, $5D, $00, $17, $00, $14, $00, $10, $00, $0C, $00, $0C, $00, $08, $00, $05
        .byte $00, $03, $00, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $17
        .byte $00, $10, $00, $0C, $00, $06, $00, $06, $00, $06, $00, $05, $00, $04, $00, $03
        .byte $00, $03, $00, $02, $00, $01, $00, $00, $00, $00, $00, $00, $82, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $FF

      aBattleScenePaletteScript9BD324 ; 9B/D324
        .byte $81, $03, $9F, $03, $9F, $03, $9F, $03, $1F, $02, $9F, $02, $1F, $01, $9F, $00
        .byte $5F, $00, $1C, $00, $19, $00, $15, $00, $12, $00, $0A, $00, $09, $00, $07, $00
        .byte $06, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $FF

      aBattleScenePaletteScript9BD364 ; 9B/D364
        .byte $FF

      aBattleScenePaletteScript9BD365 ; 9B/D365
        .byte $82, $02, $FF, $03, $5F, $02, $FF, $02, $BF, $02, $1F, $01, $5D, $00, $17, $00
        .byte $10, $00, $0C, $00, $06, $00, $0C, $00, $10, $00, $17, $01, $5D, $02, $1F, $FE

      aBattleScenePaletteScript9BD385 ; 9B/D385
        .byte $82, $00, $04, $00, $07, $00, $2B, $00, $4E, $00, $91, $00, $B4, $00, $F8, $01
        .byte $1B, $00, $F8, $00, $B4, $00, $91, $00, $4E, $00, $2B, $00, $07, $00, $04, $FE

      aBattleScenePaletteScript9BD3A5 ; 9B/D3A5
        .byte $82, $00, $1F, $00, $1F, $00, $1F, $00, $1F, $00, $1F, $00, $1F, $00, $1F, $00
        .byte $1F, $00, $1F, $00, $1F, $00, $1F, $00, $1F, $00, $1F, $00, $1F, $00, $1F, $FF

      aBattleScenePaletteScript9BD3C5 ; 9B/D3C5
        .byte $82, $00, $07, $00, $0C, $00, $0F, $00, $0D, $00, $09, $00, $07, $00, $04, $00
        .byte $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $04, $00, $08, $00, $0B, $00
        .byte $0F, $00, $53, $00, $97, $00, $74, $00, $51, $00, $2E, $00, $0C, $00, $09, $00
        .byte $06, $00, $03, $FF

      aBattleScenePaletteScript9BD3F9 ; 9B/D3F9
        .byte $82, $00, $00, $00, $00, $01, $1B, $00, $F8, $00, $B4, $00, $91, $00, $4E, $00
        .byte $2B, $00, $07, $00, $04, $00, $0C, $00, $10, $00, $17, $01, $5D, $02, $1F, $02
        .byte $BF, $FF

      aBattleScenePaletteScript9BD41B ; 9B/D41B
        .byte $82, $00, $1F, $00, $1F, $00, $1F, $00, $1F, $00, $1F, $00, $1F, $00, $1F, $00
        .byte $1F, $00, $1F, $00, $1F, $00, $1F, $00, $1F, $00, $1F, $00, $1F, $00, $1F, $FF

      aBattleScenePaletteScript9BD43B ; 9B/D43B
        .byte $81, $00, $02, $00, $04, $00, $06, $00, $08, $00, $0A, $00, $0C, $00, $0E, $00
        .byte $10, $00, $12, $00, $14, $00, $16, $00, $18, $00, $1A, $00, $1C, $00, $1E, $00
        .byte $1F, $FF

      aBattleScenePaletteScript9BD45D ; 9B/D45D
        .byte $00, $1F, $00, $1F, $00, $1F, $00, $1F, $00, $1F, $00, $1F, $00, $1F, $00, $1F
        .byte $00, $1F, $00, $1F, $00, $1F, $00, $1F, $00, $1F, $00, $1F, $00, $1F, $00, $1F
        .byte $00, $1F, $00, $1F, $00, $1F, $00, $1F, $00, $1F, $00, $1F, $00, $1F, $00, $1F
        .byte $00, $1F, $00, $1F, $00, $1F, $00, $1F, $00, $1F, $00, $1F, $00, $1F, $00, $1F
        .byte $00, $1F, $00, $1F, $00, $1F, $00, $1F, $00, $1F, $00, $1F, $00, $1F, $00, $1F
        .byte $00, $1F, $00, $1F, $00, $1F, $00, $1F, $00, $1F, $00, $1F, $00, $1F, $FF

      aBattleScenePaletteScript9BD4BC ; 9B/D4BC
        .byte $81, $3B, $BE, $80, $3F, $DE, $81, $1A, $F9, $80, $0E, $97, $81, $06, $56, $80
        .byte $0A, $77, $81, $0E, $97, $80, $12, $B8, $81, $16, $D9, $80, $1A, $F9, $81, $1F
        .byte $1A, $80, $23, $1A, $81, $2B, $3B, $80, $2F, $5C, $81, $33, $7C, $80, $37, $9D
        .byte $81, $3B, $BE, $80, $3F, $DE, $81, $1A, $F9, $80, $0E, $97, $81, $06, $56, $80
        .byte $0A, $77, $81, $0E, $97, $80, $12, $B8, $81, $16, $D9, $80, $1A, $F9, $81, $1F
        .byte $1A, $80, $23, $1A, $81, $2B, $3B, $80, $2F, $5C, $81, $33, $7C, $80, $37, $9D
        .byte $FE

      aBattleScenePaletteScript9BD51D ; 9B/D51D
        .byte $81, $00, $00, $80, $00, $00, $81, $00, $00, $80, $00, $00, $81, $00, $00, $80
        .byte $00, $00, $81, $00, $00, $80, $00, $00, $81, $00, $00, $80, $00, $00, $81, $00
        .byte $00, $80, $00, $00, $81, $00, $00, $80, $00, $01, $81, $00, $22, $80, $00, $43
        .byte $81, $00, $A5, $80, $00, $A5, $81, $00, $01, $80, $00, $00, $81, $00, $00, $80
        .byte $00, $00, $81, $00, $01, $80, $00, $02, $81, $00, $24, $80, $00, $44, $81, $00
        .byte $86, $80, $00, $86, $81, $00, $C8, $80, $00, $E9, $81, $01, $2A, $80, $01, $4B
        .byte $81, $01, $8D, $80, $01, $AD, $81, $00, $E9, $80, $00, $87, $81, $00, $67, $80
        .byte $00, $88, $81, $00, $C9, $80, $00, $EA, $81, $01, $2C, $80, $01, $4C, $81, $01
        .byte $8E, $80, $01, $8E, $81, $01, $D0, $80, $01, $F1, $81, $0A, $32, $80, $0E, $53
        .byte $81, $16, $94, $80, $1A, $B5, $81, $01, $F1, $80, $01, $8F, $81, $01, $6F, $80
        .byte $01, $90, $81, $01, $D1, $80, $01, $F2, $81, $02, $34, $80, $06, $54, $81, $0E
        .byte $96, $80, $12, $96, $81, $1E, $D8, $80, $22, $F9, $81, $2B, $3A, $80, $2F, $5B
        .byte $81, $37, $9D, $80, $3B, $BD, $FF

      aBattleScenePaletteScript9BD5E4 ; 9B/D5E4
        .byte $80, $03, $E4, $03, $E4, $0B, $E6, $13, $E8, $1B, $E9, $23, $EB, $2B, $ED, $33
        .byte $EF, $3B, $F1, $47, $F2, $4F, $F4, $57, $F6, $5F, $F8, $67, $FA, $6F, $FB, $77
        .byte $FD, $7F, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F
        .byte $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F
        .byte $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F
        .byte $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F
        .byte $FF, $FF

      aBattleScenePaletteScript9BD646 ; 9B/D646
        .byte $80, $7F, $FF, $FF

      aBattleScenePaletteScript9BD64A ; 9B/D64A
        .byte $80, $7F, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F
        .byte $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F
        .byte $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F
        .byte $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F
        .byte $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F
        .byte $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $FF

      aBattleScenePaletteScript9BD6AA ; 9B/D6AA
        .byte $82, $00, $00, $04, $21, $08, $42, $0C, $63, $10, $84, $14, $A5, $18, $C6, $1C
        .byte $E7, $21, $08, $25, $29, $29, $4A, $2D, $6B, $31, $8C, $35, $AD, $39, $CE, $3D
        .byte $EF, $42, $10, $46, $31, $4A, $52, $4E, $73, $52, $94, $56, $B5, $5A, $D6, $5E
        .byte $F7, $63, $18, $67, $39, $6B, $5A, $6F, $7B, $73, $9C, $77, $BD, $7B, $DE, $7F
        .byte $FF, $FF

      aBattleScenePaletteScript9BD6EC ; 9B/D6EC
        .byte $81, $03, $E0, $0B, $E2, $13, $E4, $1B, $E6, $23, $E8, $2B, $EA, $33, $EC, $3F
        .byte $EF, $47, $F1, $4F, $F3, $57, $F5, $5F, $F7, $67, $F9, $6F, $FB, $77, $FD, $7F
        .byte $FF, $7F, $FF, $77, $FD, $6F, $FB, $67, $F9, $5F, $F7, $57, $F5, $4F, $F3, $47
        .byte $F1, $3B, $EE, $33, $EC, $2B, $EA, $23, $E8, $1B, $E6, $13, $E4, $0B, $E2, $03
        .byte $E0, $FE

      aBattleScenePaletteScript9BD72E ; 9B/D72E
        .byte $80, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $01, $00, $01, $40, $01, $80, $01, $A0, $01, $80, $01, $60, $01, $40, $01
        .byte $20, $01, $00, $00, $E0, $00, $C0, $00, $A0, $00, $80, $00, $60, $00, $40, $00
        .byte $20, $3F, $EF, $3B, $AE, $37, $6D, $33, $4C, $2F, $0B, $2A, $CA, $26, $89, $22
        .byte $48, $1E, $27, $19, $E6, $15, $A5, $11, $64, $0D, $23, $09, $02, $04, $C1, $00
        .byte $80, $FF

      aBattleScenePaletteScript9BD790 ; 9B/D790
        .byte $80, $00, $80, $04, $C1, $09, $02, $0D, $23, $11, $64, $15, $A5, $19, $E6, $1E
        .byte $27, $22, $48, $26, $89, $2A, $CA, $2F, $0B, $33, $4C, $37, $6D, $3B, $AE, $3F
        .byte $EF, $00, $20, $00, $40, $00, $40, $00, $60, $00, $60, $00, $60, $00, $80, $00
        .byte $80, $00, $A0, $00, $A0, $00, $C0, $00, $C0, $00, $E0, $00, $E0, $01, $00, $01
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $FF

      aBattleScenePaletteScript9BD7F2 ; 9B/D7F2
        .byte $82, $1C, $02, $18, $02, $18, $01, $14, $01, $10, $01, $0C, $01, $08, $01, $08
        .byte $01, $04, $00, $00, $00, $4C, $09, $24, $04, $FE

      aBattleScenePaletteScript9BD80C ; 9B/D80C
        .byte $82, $00, $00, $00, $00, $4C, $09, $24, $04, $1C, $02, $18, $02, $18, $01, $14
        .byte $01, $10, $01, $0C, $01, $08, $01, $08, $01, $FF

      aBattleScenePaletteScript9BD826 ; 9B/D826
        .byte $82, $00, $00, $00, $00, $34, $04, $24, $04, $20, $04, $1C, $03, $18, $03, $14
        .byte $02, $14, $02, $10, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $FF

      aBattleScenePaletteScript9BD85C ; 9B/D85C
        .byte $80, $00, $00, $00, $00, $08, $00, $10, $01, $18, $01, $20, $01, $28, $02, $2C
        .byte $02, $34, $02, $3C, $03, $44, $03, $7C, $0F, $FE

      aBattleScenePaletteScript9BD876 ; 9B/D876
        .byte $80, $24, $00, $2C, $00, $34, $00, $40, $00, $48, $00, $50, $00, $58, $00, $60
        .byte $00, $6C, $00, $74, $00, $7C, $00, $7C, $00, $7C, $00, $7C, $00, $7C, $00, $7C
        .byte $00, $7C, $00, $7C, $00, $7C, $00, $7C, $00, $7C, $00, $7C, $00, $7C, $00, $7C
        .byte $00, $7C, $00, $7C, $00, $FF

      aBattleScenePaletteScript9BD8AC ; 9B/D8AC
        .byte $80, $24, $00, $2C, $00, $34, $00, $40, $00, $48, $00, $50, $00, $58, $00, $60
        .byte $00, $6C, $00, $74, $00, $7C, $00, $FF

      aBattleScenePaletteScript9BD8C4 ; 9B/D8C4
        .byte $80, $7C, $85, $FF

      aBattleScenePaletteScript9BD8C8 ; 9B/D8C8
        .byte $80, $00, $00, $00, $00, $00, $00, $00, $00, $04, $00, $0C, $20, $18, $80, $24
        .byte $E0, $31, $40, $24, $E0, $1C, $A0, $14, $60, $FF

      aBattleScenePaletteScript9BD8E2 ; 9B/D8E2
        .byte $80, $7E, $DF, $76, $BC, $6E, $79, $62, $56, $5A, $13, $51, $EF, $49, $AC, $41
        .byte $89, $41, $89, $35, $46, $2D, $23, $24, $E0, $7F, $F6, $7F, $E0, $67, $40, $5E
        .byte $C0, $52, $80, $4A, $20, $41, $E0, $39, $A0, $31, $40, $24, $E0, $1C, $A0, $14
        .byte $60, $FE

      aBattleScenePaletteScript9BD914 ; 9B/D914
        .byte $80, $7F, $F6, $67, $40, $5A, $C0, $4E, $60, $41, $E0, $35, $80, $29, $00, $24
        .byte $E0, $20, $C0, $1C, $A0, $14, $60, $0C, $20, $29, $00, $24, $E0, $20, $C0, $1C
        .byte $C0, $18, $A0, $14, $80, $14, $80, $10, $60, $0C, $40, $08, $20, $04, $20, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $FF

      aBattleScenePaletteScript9BD962 ; 9B/D962
        .byte $80, $00, $00, $04, $00, $14, $00, $2C, $00, $48, $00, $04, $00, $14, $00, $2C
        .byte $00, $48, $00, $04, $00, $FF

      aBattleScenePaletteScript9BD978 ; 9B/D978
        .byte $80, $48, $00, $04, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $FF

      aBattleScenePaletteScript9BD98E ; 9B/D98E
        .byte $80, $48, $00, $04, $00, $14, $00, $2C, $00, $48, $00, $FE

      aBattleScenePaletteScript9BD99A ; 9B/D99A
        .byte $80, $10, $60, $18, $A0, $24, $E0, $2D, $20, $39, $60, $41, $A0, $56, $00, $5E
        .byte $40, $6E, $A0, $7F, $60, $00, $00, $08, $40, $FE

      aBattleScenePaletteScript9BD9B4 ; 9B/D9B4
        .byte $80, $00, $00, $00, $00, $00, $00, $08, $40, $10, $60, $18, $A0, $24, $E0, $24
        .byte $E0, $20, $C0, $18, $A0, $14, $80, $0C, $40, $08, $20, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $FF

      aBattleScenePaletteScript9BD9F2 ; 9B/D9F2
        .byte $80, $01, $FF, $00, $07, $00, $0A, $00, $0E, $00, $12, $00, $54, $00, $B7, $FE

      aBattleScenePaletteScript9BDA02 ; 9B/DA02
        .byte $82, $00, $21, $00, $00, $04, $21, $08, $42, $0C, $63, $0C, $84, $10, $A5, $14
        .byte $C6, $18, $E7, $1D, $28, $21, $49, $25, $6A, $25, $8B, $29, $AC, $2D, $CD, $31
        .byte $EE, $36, $0F, $46, $93, $36, $0F, $31, $CD, $2D, $AD, $25, $8B, $21, $4A, $1D
        .byte $28, $14, $E6, $14, $C6, $10, $A5, $0C, $84, $0C, $83, $08, $62, $04, $42, $04
        .byte $21, $00, $00, $00, $00, $04, $21, $04, $42, $08, $62, $0C, $63, $0C, $84, $FF

      aBattleScenePaletteScript9BDA52 ; 9B/DA52
        .byte $82, $1D, $28, $14, $E6, $14, $C6, $10, $A5, $0C, $84, $0C, $83, $08, $62, $04
        .byte $42, $04, $21, $00, $00, $00, $00, $04, $21, $04, $42, $08, $62, $0C, $63, $0C
        .byte $84, $FF

      aBattleScenePaletteScript9BDA74 ; 9B/DA74
        .byte $82, $10, $A5, $14, $C6, $14, $E6, $1D, $28, $21, $4A, $25, $8B, $2D, $AD, $31
        .byte $CD, $3E, $51, $4A, $B4, $4A, $B4, $3E, $51, $31, $CD, $2D, $AD, $25, $8B, $21
        .byte $4A, $FF

      aBattleScenePaletteScript9BDA96 ; 9B/DA96
        .byte $82, $0C, $83, $0C, $84, $10, $A4, $10, $A5, $14, $C5, $14, $E6, $14, $E6, $19
        .byte $07, $19, $07, $1D, $28, $1D, $28, $1D, $07, $19, $07, $18, $E6, $14, $E6, $14
        .byte $C5, $10, $A5, $10, $A4, $0C, $84, $0C, $83, $08, $63, $08, $42, $08, $42, $04
        .byte $21, $04, $21, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $FF

      aBattleScenePaletteScript9BDAD8 ; 9B/DAD8
        .byte $82, $04, $21, $00, $00, $04, $21, $08, $42, $0C, $84, $10, $A5, $14, $C6, $18
        .byte $E7, $19, $08, $1D, $4A, $21, $6B, $25, $8C, $29, $AD, $2D, $CE, $31, $EF, $36
        .byte $31, $3A, $52, $46, $B5, $36, $10, $31, $CD, $29, $8C, $21, $8B, $25, $6A, $FF

      aBattleScenePaletteScript9BDB08 ; 9B/DB08
        .byte $82, $21, $49, $1D, $27, $18, $E7, $10, $A5, $0C, $84, $0C, $83, $08, $62, $04
        .byte $42, $04, $21, $00, $00, $00, $00, $04, $21, $04, $42, $08, $62, $0C, $63, $0C
        .byte $84, $FF

      aBattleScenePaletteScript9BDB2A ; 9B/DB2A
        .byte $82, $10, $A5, $18, $E7, $1D, $27, $21, $49, $25, $6A, $21, $8B, $29, $8C, $31
        .byte $CD, $36, $10, $46, $B5, $46, $B5, $36, $10, $31, $CD, $29, $8C, $21, $8B, $25
        .byte $6A, $FF

      aBattleScenePaletteScript9BDB4C ; 9B/DB4C
        .byte $82, $0C, $84, $10, $A4, $10, $A5, $14, $C5, $14, $E6, $18, $E7, $19, $07, $1D
        .byte $28, $1D, $28, $21, $49, $21, $49, $1D, $28, $1D, $28, $19, $07, $18, $E6, $14
        .byte $C6, $14, $C5, $10, $A5, $10, $84, $0C, $83, $08, $63, $08, $42, $04, $41, $04
        .byte $21, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $FF

      aBattleScenePaletteScript9BDB8C ; 9B/DB8C
        .byte $81, $00, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $02, $00, $04, $00
        .byte $06, $00, $08, $00, $4A, $00, $8C, $00, $CE, $01, $30, $01, $D4, $02, $77, $02
        .byte $DA, $3F, $DE, $FF

      aBattleScenePaletteScript9BDBB0 ; 9B/DBB0
        .byte $81, $3F, $DE, $02, $DA, $02, $77, $01, $B3, $01, $0F, $00, $AD, $00, $6B, $00
        .byte $29, $00, $07, $00, $05, $00, $03, $00, $01, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $FF

      aBattleScenePaletteScript9BDBE2 ; 9B/DBE2
        .byte $80, $00, $AF, $00, $B0, $00, $02, $00, $03, $00, $24, $00, $25, $00, $26, $00
        .byte $47, $00, $48, $00, $48, $03, $FF, $01, $DF, $00, $6B, $00, $8C, $00, $8D, $00
        .byte $8E, $00, $AF, $00, $B0, $00, $02, $00, $03, $00, $24, $00, $25, $00, $26, $00
        .byte $47, $00, $48, $00, $48, $03, $FF, $01, $DF, $00, $6B, $00, $8C, $00, $8D, $00
        .byte $8E, $FE

    .endsection BattleAnimationEffectData9BSection


    .section DataE0205CSection

      .al
      .xl

      aBattleScenePaletteE0205CUnused ; E0/205C

        ; Unreferenced.

        .word $7BBC, $473D, $1994, $10CC, $4906, $34C4, $28A3, $0000
        .word $2C25, $4088, $4D0B, $0009, $0092, $015C, $0802

        ; E0/207A

      aTitleScenePaletteE0207A ; E0/207A

        .byte $38, $0E, $1F, $33, $F7, $1E

      aBattleScenePaletteE02080 ; E0/2080

        .byte $F0, $7F, $1F, $64, $69, $50, $ED, $60, $71, $71
        .byte $9F, $6D, $18, $2C, $0A, $00

      aBattleScenePaletteE02090 ; E0/2090

        .byte $1F, $70, $13, $7C, $0D, $5C, $0B, $50, $09, $44
        .byte $07, $3C, $05, $30, $01, $1C, $01, $00, $06, $00, $10, $00, $00, $00, $1F, $00
        .byte $FF, $00, $3F, $02, $00, $00, $1B, $00, $17, $00, $13, $00, $0F, $00, $0C, $00
        .byte $08, $00, $04, $00, $60, $00, $FF, $57, $FF, $13, $DF, $02, $3F, $02, $FF, $01
        .byte $9F, $01, $5F, $01, $BF, $00, $1F, $00, $1D, $00, $1A, $00, $17, $00, $14, $00
        .byte $11, $00, $0E, $00, $00, $00, $04, $00, $08, $00, $00, $00, $00, $00, $01, $00
        .byte $05, $00, $00, $00, $02, $00, $06, $00, $0B, $00, $00, $00, $29, $21, $29, $21
        .byte $29, $21, $47, $00, $4B, $00, $BD, $00, $E0, $3D, $00, $00, $00, $00, $00, $00
        .byte $5F, $00, $00, $00, $00, $00, $00, $00, $3E, $3E, $00, $00, $00, $00, $00, $00
        .byte $FF, $7F, $FF, $77, $FF, $6F, $FF, $67, $FF, $5F, $FF, $57, $FF, $4F, $FF, $47
        .byte $FF, $3F, $FF, $33, $FF, $2B, $FF, $23, $FF, $1B, $FF, $13, $FF, $0B

      aBattleScenePaletteE02138 ; E0/2138

        .byte $00, $0C
        .byte $40, $0C, $E0, $00, $20, $09, $60, $09, $40, $09, $80, $09, $80, $01, $23, $16
        .byte $24, $16, $8B, $2A, $8B, $2A, $8A, $2E, $8D, $36, $72, $46

      aBattleScenePaletteE02156 ; E0/2156

        .byte $4A, $00, $CA, $00
        .byte $4A, $05

      aBattleScenePaletteE0215C ; E0/215C

        .byte $AD, $35, $52, $4A, $FF, $7F, $7F, $7F, $D6, $5A, $39, $67, $FF, $7F
        .byte $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F
        .byte $6C, $08, $4A, $29, $8C, $31, $AD, $35, $EF, $3D, $10, $42, $52, $4A, $73, $4E
        .byte $B5, $56, $D6, $5A, $18, $63, $39, $67, $7B, $6F, $9C, $73, $DE, $7B, $FF, $7F
        .byte $EA, $7D, $13, $7F, $FF, $6B, $7F, $7F, $EA, $7D, $FF, $63, $FF, $33, $7F, $7F
        .byte $EA, $7D, $53, $7F, $F8, $7F, $7F, $7F, $EA, $7D, $FF, $63, $FF, $6B, $EA, $7D
        .byte $13, $7F, $FF, $6B, $7F, $7F, $EA, $7D, $FF, $63, $FF, $33, $7F, $7F, $EA, $7D
        .byte $53, $7F, $F8, $7F, $00, $34, $00, $44, $00, $54, $00, $64, $2A, $7F, $F3, $7F
        .byte $FF, $6B, $7F, $7F, $F0, $7F, $FF, $63, $FF, $2B, $7F, $7F, $6A, $7E, $F3, $7F
        .byte $FD, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $CA, $7E, $F3, $7F, $FF, $73
        .byte $00, $00, $F0, $7F, $FF, $63, $FF, $2B, $00, $00, $0A, $7E, $F3, $7F, $F8, $CA
        .byte $7E, $F3, $7F, $FF, $73, $00, $00, $F0, $7F, $FF, $63, $FF, $2B, $75, $51, $F9
        .byte $61, $9D, $72

      aBattleScenePaletteE0221D ; E0/221D

        .byte $BF, $7F, $BF, $2F, $7D, $22, $3E, $16, $16, $12, $F8, $0D, $F7
        .byte $09, $D4, $21, $2F, $01, $EE, $00, $8D, $00, $29, $00, $1F, $7E, $05, $14, $00
        .byte $00, $00, $00, $BF, $7F, $BF, $2F, $BE, $2A, $3E, $16, $16, $12, $F8, $0D, $F7
        .byte $09, $D4, $21, $2F, $01, $EE, $00, $8D, $00, $29, $00, $1F, $7E, $05, $14, $00
        .byte $00, $97, $0E, $56, $06, $77, $0A, $97, $0E, $B8, $12, $D9, $16, $F9, $1A, $1A
        .byte $1F, $1A, $23, $3B, $2B, $5C, $2F, $7C, $33, $9D, $37, $BE, $3B, $DE, $3F, $03
        .byte $1C, $20, $6D, $20, $69, $00, $61, $00, $5D, $E0, $54, $C0, $50, $C0, $48, $A1
        .byte $44, $A1, $3C, $81, $38, $61, $30, $61, $2C, $20, $1C, $00, $08, $23, $04

        ; E0/2299

      aTitleIntroPalette2 ; E0/2299

        ; Read by rlLoadTitleIntroGraphics.

        .word $4F5F, $169F, $11FF, $21DA, $0938, $04F8, $0516, $00B4
        .word $0051, $110C, $006D, $000B, $0007, $0002, $0000

        ; E0/22B7

      aTitleScenePaletteE022B7 ; E0/22B7

        .word $7FE0, $77A0, $6F60, $6300, $5AC0, $5280, $4A40, $4200
        .word $35A0, $2D60, $2520, $1CE0, $14A0, $0840, $0000, $1403
        .word $3009, $6412, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0AEF, $7FFF
        .word $77BD, $6F7B, $6318, $5AD6, $5294, $4A52, $4210, $35AD
        .word $2D6B, $2529, $1CE7, $14A5, $0842, $0000, $0000

      aBattleScenePaletteE02315 ; E0/2315

        .word $7FFF
        .word $5AF9, $5294, $3E11, $420F, $3C73, $318C, $1CE6, $048A
        .word $3826, $1400, $0043, $1083, $0001, $0000, $0001, $7FFF
        .word $5B3F, $52FD, $4E73, $3A36, $420F, $3DF0, $41EF, $294A
        .word $2107, $14C8, $2002, $0044, $1083, $0000, $14E5, $7BFE
        .word $5AF9, $5294, $3E11, $420F, $009F, $318C, $1CE6, $0488
        .word $3826, $1400, $0043, $1083, $0001, $0000

      aBattleScenePaletteE02373 ; E0/2373

        .word $1A17, $19F8
        .word $1594, $1130, $0CF0, $112F, $0CEC, $08A8, $0D07, $0886
        .word $0868, $0464, $0463, $0022, $0000, $52B3, $7540, $6D20
        .word $6920, $6100, $5D00, $54E0, $50C0, $48C0, $44A1, $3CA1
        .word $3881, $3061, $2C61, $1C00, $0000

        ; E0/23B1

      aTitleIntroPaletteE023B1 ; E0/23B1

        ; Read by rlLoadTitleIntroGraphics.

        .word $000F, $000E, $000D, $000C, $000B, $000A, $0009, $0008
        .word $0007, $0006, $0005, $0004, $0003, $0002, $0001

        ; E0/23CF

      aTitleScenePaletteE023CF ; E0/23CF

        .word $7FFF, $7FFF, $7FFF, $7FFF, $0821, $0C42, $1463, $7FFF
        .word $0400, $0821, $1042, $7FFF, $0000, $0400, $0C21, $219A
        .word $10F0, $10CD, $0CAC, $0CAA, $10AA, $0888, $0867, $0C87
        .word $0868, $0444, $0443, $0423, $0022, $0000, $0001, $1537
        .word $0CCF, $0CAC, $088B, $0889, $0C89, $0467, $0446, $0866
        .word $0447, $0022, $0000, $0001, $0000, $0000, $063D, $01BF
        .word $221C, $0118, $0118, $00F5, $090F, $00B0, $008C, $0069
        .word $0887, $0025, $0003, $0001, $0000, $35CC, $025E, $019E
        .word $1DFB, $00F7, $00F7, $00D4, $00CD, $006E, $004A, $0027
        .word $0045, $0003, $0000, $0000, $0000, $7EA0, $7E60, $7E00
        .word $7600, $71E0, $6980, $6560, $5D60, $5941, $5121, $4901
        .word $44E1, $3CE1, $38C1, $30A1, $4670, $7540, $6D20, $6920
        .word $6100, $5D00, $54E0, $50C0, $48C0, $44A1, $3CA1, $3881
        .word $3061, $2C61, $2441, $1401, $0000, $39CD, $39CD, $39CD
        .word $39CD, $39CD, $39CD, $39CD, $39CD, $39CD, $39CD, $39CD
        .word $39CD, $39CD, $39CD, $0000, $39CD, $39CD, $39CD, $39CD
        .word $39CD, $39CD, $39CD, $39CD, $39CD, $39CD, $39CD, $39CD
        .word $39CD, $39CD

        ; E0/24E3

      aTitleIntroScene7Palette ; E0/24E3

        ; Read by rlBuildTitleIntroScene7PaletteTable.

        .word $0187, $2BFF, $3C20, $0236, $4379, $2F7C, $7FFF, $0DF8
        .word $2278, $0552, $016A, $477C, $0045, $21B4, $0974, $464F
        .word $2128, $2256, $060B, $3B0F, $2840, $228E, $4753, $3F53
        .word $1000, $0297, $014E, $63B7, $4B75, $2F16, $1EFC, $2FBD
        .word $0298, $0A0E, $2F9B, $1A90, $4FB8, $4F96, $01F5, $01F3
        .word $43FF, $22B5, $1217, $3F94, $26B3, $168F, $2AFC, $0002
        .word $5BFF, $11D6, $5FFB, $3F78, $018F, $0C40, $3317, $1042
        .word $41EC, $01A8, $1040, $3FFE, $2698, $1212, $20A4, $57D7
        .word $4D47, $4060, $32F5, $11D0, $1218, $0C00, $6040, $166F
        .word $32F3, $1ABA, $1EB4, $2907, $1F3C, $01F6, $1820, $377C
        .word $1207, $4820, $2C40, $6040, $4080, $5C20, $2480, $3020
        .word $1C80, $1800, $5440, $5840, $4040, $3C40, $7040, $4C40
        .word $5840, $00F5, $0213, $42F1, $0238, $0000, $39F0, $3E0B
        .word $41E9, $18E8, $1D03, $20E4, $0864, $0C81, $1060, $0022
        .word $0020, $0840, $0041, $0001, $1D28, $0061, $2123, $0020
        .word $2129, $3E10, $0441, $256C, $0460, $10A1, $0440, $2124
        .word $0042, $00EF, $0842, $0420, $0021, $2D84, $0421, $5F18
        .word $5B17, $4207, $2D8B, $66F5, $4A74, $0463, $0CA4, $0062
        .word $4209, $1F1A, $10A2, $10A4, $0482, $3166, $4E92, $2127
        .word $35A8, $14C2, $0400, $2DAD, $0861, $528E, $14C6, $3185
        .word $0462, $1F16, $39CB, $0CC2, $526E, $0882, $0461, $18E3
        .word $4A4F, $0C83, $0442, $3186, $2545, $3168, $256A, $1D04
        .word $0863, $2273, $35CE, $0C60, $4E94, $10C5, $015B, $5270
        .word $20AD, $56B4, $14AC, $462A, $2966, $0862, $4A72, $2D83
        .word $0CA2, $42F9

        ; E0/2667

    .endsection DataE0205CSection


