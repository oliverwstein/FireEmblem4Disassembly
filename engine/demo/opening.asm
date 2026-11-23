; The attract mode's opening (bank $90, after the dialogue, and a few routines of
; bank $8D for its first and last scenes): the event script
; aOpeningEvent and the RUN_ASM routines and tables it uses. rlStartOpeningEvent
; (bank $9B, in the map battle screen's loop) starts the script. It shows Annand's
; pegasus knights, the staff credits (engine/demo/opening_credits.asm), battle
; scenes, two conversations, then two chapter map scenes chosen by wDemoIndex,
; each followed by its scripted demo battle (engine/demo/demo_battles.asm):
; first the odd index (rlASMCSetDemoIndexOdd, rlRunDemoBattleSetup), then the
; even one below it (rlRunDemoBattleSetupAtIndex). rlRunDemoBattleSetup steps
; wDemoIndex down, so each showing of the opening moves on to the next pair. The
; last scene is Arvis ordering the final attack (on the final chapter's map). DEMO_ALLOW_SKIP lets Start end it.
;
; A demo scene: rlASMCClearDemoDeployments, rlASMCLoadDemoMapScene (chapter and
; camera), rlASMCPlaceDemoSceneSprites (the units, from aDemoSceneSpriteLists).

    .section OpeningDialogueSection

      .al
      .xl

      dialogueOpeningShannanAyra .include "../../text/dialogue/Opening/ShannanAyra.dialogue.txt" ; 8D/9ED5
      dialogueOpeningEldiganLachesis .include "../../text/dialogue/Opening/EldiganLachesis.dialogue.txt" ; 8D/9F25
      dialogueOpeningArvisFinalAttack .include "../../text/dialogue/Opening/ArvisFinalAttack.dialogue.txt" ; 8D/9F82

        ; 8D/9FB1

    .endsection OpeningDialogueSection


    .section Data90E8CESection

      .al
      .xl

      aOpeningEvent ; 90/E8CE

        ; The attract mode's opening, started by rlStartOpeningEvent. Annand's
        ; pegasus knights, the staff credits (rlShowOpeningCreditsPage1-8), two
        ; battle scenes, two conversations, a pair of chapter map scenes with
        ; their demo battles (the odd and the even wDemoIndex), and Arvis's final
        ; attack on the final chapter's map. Start ends it (DEMO_ALLOW_SKIP).

        DEMO_ALLOW_SKIP
        RUN_ASM rlASMCClearDemoDeployments
        RUN_ASM rlASMCSetOpeningMapChapter9
        SET_CAMERA_POSITION [0, 7]
        EVENT_3B $80
        PAUSE $0005
        YIELD
        RUN_ASM rlASMCSetUpOpeningSkyScene
        MOVE_TEMPORARY_BY_SCRIPT Annand, [2, 12], 5, $06, aOpeningAnnandMovement, false
        WAIT_UNIT_SPRITE_DECOMPRESSED
        MOVE_TEMPORARY_BY_SCRIPT AnnandSquadPegasusKnight, [22, 14], 4, $06, aOpeningPegasusKnightMovement1, false
        WAIT_UNIT_SPRITE_DECOMPRESSED
        MOVE_TEMPORARY_BY_SCRIPT AnnandSquadPegasusKnight, [22, 13], 4, $06, aOpeningPegasusKnightMovement2, false
        WAIT_UNIT_SPRITE_DECOMPRESSED
        MOVE_TEMPORARY_BY_SCRIPT AnnandSquadPegasusKnight, [20, 16], 4, $06, aOpeningPegasusKnightMovement3, false
        WAIT_UNIT_SPRITE_DECOMPRESSED
        FADE_IN_BY_TIMER $05
        SCRIPTED_MAP_SCROLL aOpeningScroll1, $02
        YIELD
        PAUSE $0032
        YIELD
        FADE_OUT_BY_TIMER $06
        YIELD
        WAIT_UNTIL_MAP_SPRITES_HALTING
        YIELD
        PAUSE $001E
        YIELD
        RUN_ASM rlShowOpeningCreditsPage1
        PAUSE $00B4
        YIELD
        FADE_OUT_BY_TIMER $04
        YIELD
        PAUSE $000A
        YIELD
        RUN_ASM rlUnknown97FDC1
        YIELD
        RUN_ASM rlCreateProcEventWaitBattleSceneEnd
        YIELD
        PAUSE $001E
        YIELD
        RUN_ASM rlShowOpeningCreditsPage2
        PAUSE $00C8
        YIELD
        FADE_OUT_BY_TIMER $04
        YIELD
        PAUSE $0014
        YIELD
        DIALOGUE_WITH_BG dialogueOpeningShannanAyra, $04, $05, $03
        YIELD
        PAUSE $0019
        YIELD
        RUN_ASM rlShowOpeningCreditsPage3
        PAUSE $00D2
        YIELD
        FADE_OUT_BY_TIMER $04
        YIELD
        RUN_ASM rlASMCSetDemoIndexOdd
        RUN_ASM rlASMCLoadDemoMapScene
        EVENT_3B $80
        RUN_ASM rlASMCClearDemoDeployments
        RUN_ASM rlASMCPlaceDemoSceneSprites
        PAUSE $0014
        YIELD
        RUN_ASM rlASMCTestDemoIndexIs1
        JUMP_FALSE _E9B2
        MOVE_TEMPORARY_BY_SCRIPT PapilioSquadDragonrider, [59, 46], 4, $04, aOpeningDragonriderMovement, false
        WAIT_UNIT_SPRITE_DECOMPRESSED
        PAUSE $0007
        YIELD
        SCRIPTED_MAP_SCROLL aOpeningScroll2, $01
        FADE_IN_BY_TIMER $05
        YIELD
        WAIT_UNTIL_MAP_SPRITES_HALTING
        YIELD
        CONTINUE_FORM_MAP_SPRITE_HALT
        RUN_ASM rlRunDemoBattleSetup
        RUN_ASM rlASMCStartDemoMapBattle
        PAUSE $0027
        YIELD
        RUN_ASM rlASMCHideDemoSceneUnit
        JUMP _E9C1

        _E9B2 ; 90/E9B2
        RUN_ASM rlRunDemoBattleSetup
        RUN_ASM rlASMCStartDemoMapBattle
        PAUSE $0020
        YIELD
        FADE_IN_BY_TIMER $04
        YIELD

        _E9C1 ; 90/E9C1
        RUN_ASM rlCreateProcHaltEvent
        YIELD
        FADE_OUT_BY_TIMER $04
        YIELD
        RUN_ASM rlFreeMapBattleProcAndClearSprites
        PAUSE $0019
        YIELD
        RUN_ASM rlShowOpeningCreditsPage4
        PAUSE $00D2
        YIELD
        FADE_OUT_BY_TIMER $04
        YIELD
        PAUSE $0014
        YIELD
        DIALOGUE_WITH_BG dialogueOpeningEldiganLachesis, $03, $05, $03
        YIELD
        PAUSE $0019
        YIELD
        RUN_ASM rlShowOpeningCreditsPage5
        PAUSE $00D2
        YIELD
        FADE_OUT_BY_TIMER $04
        YIELD
        RUN_ASM rlUnknown97FDC6
        YIELD
        RUN_ASM rlCreateProcEventWaitBattleSceneEnd
        YIELD
        PAUSE $001E
        YIELD
        RUN_ASM rlShowOpeningCreditsPage6
        PAUSE $00C8
        YIELD
        FADE_OUT_BY_TIMER $04
        YIELD
        RUN_ASM rlASMCLoadDemoMapScene
        EVENT_3B $80
        RUN_ASM rlASMCClearDemoDeployments
        RUN_ASM rlASMCPlaceDemoSceneSprites
        PAUSE $0014
        YIELD
        RUN_ASM rlRunDemoBattleSetupAtIndex
        RUN_ASM rlASMCStartDemoMapBattle
        PAUSE $0020
        YIELD
        FADE_IN_BY_TIMER $04
        YIELD
        RUN_ASM rlCreateProcHaltEvent
        YIELD
        FADE_OUT_BY_TIMER $04
        YIELD
        RUN_ASM rlFreeMapBattleProcAndClearSprites
        PAUSE $0019
        YIELD
        RUN_ASM rlShowOpeningCreditsPage7
        PAUSE $00C8
        YIELD
        FADE_OUT_BY_TIMER $04
        YIELD
        RUN_ASM rlASMCSetOpeningMapChapter11
        SET_CAMERA_POSITION [35, 17]
        EVENT_3B $80
        RUN_ASM rlASMCClearDemoDeployments
        RUN_ASM rlASMCPlaceOpeningFinalSceneSprites
        PAUSE $0014
        YIELD
        MOVE_TEMPORARY_TO_COORDS_CLASS $000B, [42, 24], [46, 24], 4, $06, $20, $801C, false
        WAIT_UNIT_SPRITE_DECOMPRESSED
        MOVE_TEMPORARY_TO_COORDS_CLASS $000B, [42, 24], [46, 25], 4, $06, $26, $801D, false
        WAIT_UNIT_SPRITE_DECOMPRESSED
        MOVE_TEMPORARY_TO_COORDS_CLASS $000B, [42, 24], [45, 25], 4, $06, $28, $801D, false
        WAIT_UNIT_SPRITE_DECOMPRESSED
        FADE_IN_BY_TIMER $04
        WAIT_UNTIL_MAP_SPRITES_HALTING
        YIELD
        MOVE_TEMPORARY_TO_COORDS_CLASS $0009, [42, 24], [37, 22], 4, $06, $44, $8013, false
        WAIT_UNIT_SPRITE_DECOMPRESSED
        PAUSE $000C
        YIELD
        MOVE_TEMPORARY_TO_COORDS_CLASS $0017, [42, 24], [38, 20], 4, $06, $30, $800F, false
        WAIT_UNIT_SPRITE_DECOMPRESSED
        PAUSE $000A
        YIELD
        MOVE_TEMPORARY_TO_COORDS_CLASS $0004, [42, 24], [39, 20], 4, $06, $3A, $800B, false
        WAIT_UNIT_SPRITE_DECOMPRESSED
        PAUSE $000A
        YIELD
        MOVE_TEMPORARY_TO_COORDS_CLASS $0017, [42, 24], [38, 21], 4, $06, $32, $800F, false
        WAIT_UNIT_SPRITE_DECOMPRESSED
        PAUSE $0008
        YIELD
        MOVE_TEMPORARY_TO_COORDS_CLASS $0004, [42, 24], [39, 21], 4, $06, $3C, $800B, false
        WAIT_UNIT_SPRITE_DECOMPRESSED
        PAUSE $0008
        YIELD
        MOVE_TEMPORARY_TO_COORDS_CLASS $0017, [42, 24], [38, 22], 4, $06, $34, $800F, false
        WAIT_UNIT_SPRITE_DECOMPRESSED
        PAUSE $0006
        YIELD
        MOVE_TEMPORARY_TO_COORDS_CLASS $0004, [42, 24], [39, 22], 4, $06, $3E, $800B, false
        WAIT_UNIT_SPRITE_DECOMPRESSED
        PAUSE $0006
        YIELD
        MOVE_TEMPORARY_TO_COORDS_CLASS $0017, [42, 24], [38, 23], 4, $06, $36, $800F, false
        WAIT_UNIT_SPRITE_DECOMPRESSED
        PAUSE $0004
        YIELD
        MOVE_TEMPORARY_TO_COORDS_CLASS $0004, [42, 24], [39, 23], 4, $06, $40, $800B, false
        WAIT_UNIT_SPRITE_DECOMPRESSED
        MOVE_TEMPORARY_TO_COORDS_CLASS $0017, [42, 24], [38, 24], 4, $06, $38, $800F, false
        WAIT_UNIT_SPRITE_DECOMPRESSED
        PAUSE $0006
        YIELD
        MOVE_TEMPORARY_TO_COORDS_CLASS $0004, [42, 24], [39, 24], 4, $06, $42, $800B, false
        WAIT_UNIT_SPRITE_DECOMPRESSED
        WAIT_UNTIL_MAP_SPRITES_HALTING
        YIELD
        PAUSE $000A
        YIELD
        MOVE_TEMPORARY_TO_COORDS_CLASS $0104, [42, 24], [42, 25], 3, $06, $04, $003C, false
        WAIT_UNIT_SPRITE_DECOMPRESSED
        WAIT_UNTIL_MAP_SPRITES_HALTING
        YIELD
        PAUSE $000F
        YIELD
        DIALOGUE dialogueOpeningArvisFinalAttack
        RUN_ASM rlASMCContinueDuringDialogue
        PAUSE $00C0
        YIELD
        FADE_OUT_BY_TIMER $05
        YIELD
        RUN_ASM rlASMCCloseDialogue
        YIELD
        PAUSE $0019
        YIELD
        RUN_ASM rlShowOpeningCreditsPage8
        RUN_ASM rlASMCTestDemoAllowSkipFlag
        JUMP_TRUE _EB89
        PAUSE $00B4
        YIELD
        FADE_OUT_BY_TIMER $03
        YIELD
        PAUSE $0028
        YIELD
        JUMP _EB9B

        _EB89 ; 90/EB89
        PAUSE $00B4
        YIELD
        PLAY_SFX_WORD $00E7
        PAUSE $0050
        YIELD
        FADE_OUT_BY_TIMER $06
        YIELD
        PAUSE $005A
        YIELD

        _EB9B ; 90/EB9B
        RUN_ASM rlASMCClearDemoDeployments
        OPEN_MAP_BATTLE
        END_EVENT

      aOpeningAnnandMovement ; 90/EBA2
        MAP_RIGHT_MULTIPLE 45
        MAP_SET_SPEED 3
        MAP_RIGHT_MULTIPLE 2
        MAP_SET_SPEED 4
        MAP_RIGHT_MULTIPLE 12
        MAP_END

      aOpeningPegasusKnightMovement1 ; 90/EBAD
        MAP_RIGHT_MULTIPLE 39
        MAP_END

      aOpeningPegasusKnightMovement3 ; 90/EBB0
        MAP_RIGHT_MULTIPLE 39
        MAP_END

      aOpeningPegasusKnightMovement2 ; 90/EBB3
        MAP_PAUSE 25
        MAP_RIGHT_MULTIPLE 37
        MAP_END

      aOpeningScroll1 ; 90/EBB8
        MAP_RIGHT_MULTIPLE 35
        MAP_SET_SPEED 1
        MAP_RIGHT_MULTIPLE 11
        MAP_END

      aOpeningScroll2 ; 90/EBBF
        MAP_DOWN_MULTIPLE 9
        MAP_END

      aOpeningDragonriderMovement ; 90/EBC2
        MAP_DOWN_MULTIPLE 11
        MAP_LEFT_MULTIPLE 2
        MAP_HALT
        MAP_PAUSE 27
        MAP_END

        ; 90/EBCA

    .endsection Data90E8CESection


    .section Unsorted90EBCASection

      .al
      .xl

      rlASMCTestDemoAllowSkipFlag ; 90/EBCA

        .al
        .xl
        .autsiz
        .databank ?

        ; Sets the truth flag from $1832, which DEMO_ALLOW_SKIP sets to 1, or to 0 when $0CC2 is 0 and wDemoIndex is 0 or 1. The opening's last screen differs by it (sound $E7 or not); what $1832 and $0CC2 stand for is not known.


        phx
        phy
        lda $1832,b
        sta @l wEventEngineTruthFlag
        ply
        plx
        rtl

        .databank 0

        ; 90/EBD6

      rlASMCLoadDemoMapScene ; 90/EBD6

        .al
        .xl
        .autsiz
        .databank ?

        ; Sets up the map scene for wDemoIndex: its chapter (aDemoSceneChapters) and camera (aDemoSceneCameraPositions), wMainGameMode 2, wMapStateFlags $FFFF and the cursor at (128, 128).


        phb
        php
        phk
        plb
        .databank $90
        phx
        phy
        lda wDemoIndex,b
        tax
        lda @l aDemoSceneChapters,x
        and #$00FF
        sta @l wCurrentChapter
        txa
        asl a
        asl a
        tax
        lda @l aDemoSceneCameraPositions,x
        sta @l wMapXOffset
        lda @l aDemoSceneCameraPositions+2,x
        sta @l wMapYOffset
        lda #$0002
        sta wMainGameMode,b
        lda #$FFFF
        sta wMapStateFlags,b
        lda #$0080
        sta wCursorXOffset,b
        sta wCursorYOffset,b
        ply
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 90/EC19

      aDemoSceneChapters ; 90/EC19

        ; The chapter of each demo scene, by wDemoIndex (rlASMCLoadDemoMapScene).
        .byte $07, $02, $06, $00, $08, $01, $09, $04, $0B, $03, $0A, $05


      aDemoSceneCameraPositions ; 90/EC25

        ; The camera (map X and Y offsets in pixels) of each demo scene, by wDemoIndex.
        .word $0300, $0310
        .word $02F0, $0280
        .word $0260, $0180
        .word $01A0, $0120
        .word $0060, $0050
        .word $02D0, $01F0
        .word $0270, $0280
        .word $01C0, $02E0
        .word $01D0, $00C0
        .word $0170, $0300
        .word $0080, $0000
        .word $0300, $0020


      rlASMCPlaceOpeningFinalSceneSprites ; 90/EC55

        .al
        .xl
        .autsiz
        .databank ?

        ; The opening's last map scene: places a fixed set of map sprites (positions in pixels) in deployments 2-41 with rlAddDeployedMapSprite.


        lda #$02A0
        sta aDeploymentTable._XPixelPosition+$04
        lda #$0190
        sta aDeploymentTable._YPixelPosition+$04
        lda #$003C
        sta wR1
        jsl rlAddDeployedMapSprite
        sta aDeploymentTable._DeploymentOffsets+$04
        lda #$00C2
        sta aDeploymentTable._State+$04
        lda #$02C0
        sta aDeploymentTable._XPixelPosition+$06
        lda #$0140
        sta aDeploymentTable._YPixelPosition+$06
        lda #$0010
        sta wR1
        jsl rlAddDeployedMapSprite
        sta aDeploymentTable._DeploymentOffsets+$06
        lda #$0082
        sta aDeploymentTable._State+$06
        lda #$02D0
        sta aDeploymentTable._XPixelPosition+$08
        lda #$0130
        sta aDeploymentTable._YPixelPosition+$08
        lda #$0010
        sta wR1
        jsl rlAddDeployedMapSprite
        sta aDeploymentTable._DeploymentOffsets+$08
        lda #$0082
        sta aDeploymentTable._State+$08
        lda #$02E0
        sta aDeploymentTable._XPixelPosition+$0A
        lda #$0130
        sta aDeploymentTable._YPixelPosition+$0A
        lda #$0010
        sta wR1
        jsl rlAddDeployedMapSprite
        sta aDeploymentTable._DeploymentOffsets+$0A
        lda #$0082
        sta aDeploymentTable._State+$0A
        lda #$02F0
        sta aDeploymentTable._XPixelPosition+$0C
        lda #$0130
        sta aDeploymentTable._YPixelPosition+$0C
        lda #$0010
        sta wR1
        jsl rlAddDeployedMapSprite
        sta aDeploymentTable._DeploymentOffsets+$0C
        lda #$0082
        sta aDeploymentTable._State+$0C
        lda #$0300
        sta aDeploymentTable._XPixelPosition+$0E
        lda #$0140
        sta aDeploymentTable._YPixelPosition+$0E
        lda #$0010
        sta wR1
        jsl rlAddDeployedMapSprite
        sta aDeploymentTable._DeploymentOffsets+$0E
        lda #$0082
        sta aDeploymentTable._State+$0E
        lda #$02D0
        sta aDeploymentTable._XPixelPosition+$10
        lda #$0140
        sta aDeploymentTable._YPixelPosition+$10
        lda #$0029
        sta wR1
        jsl rlAddDeployedMapSprite
        sta aDeploymentTable._DeploymentOffsets+$10
        lda #$0082
        sta aDeploymentTable._State+$10
        lda #$02E0
        sta aDeploymentTable._XPixelPosition+$12
        lda #$0140
        sta aDeploymentTable._YPixelPosition+$12
        lda #$0029
        sta wR1
        jsl rlAddDeployedMapSprite
        sta aDeploymentTable._DeploymentOffsets+$12
        lda #$0082
        sta aDeploymentTable._State+$12
        lda #$02F0
        sta aDeploymentTable._XPixelPosition+$14
        lda #$0140
        sta aDeploymentTable._YPixelPosition+$14
        lda #$0029
        sta wR1
        jsl rlAddDeployedMapSprite
        sta aDeploymentTable._DeploymentOffsets+$14
        lda #$0082
        sta aDeploymentTable._State+$14
        lda #$02D0
        sta aDeploymentTable._XPixelPosition+$16
        lda #$0150
        sta aDeploymentTable._YPixelPosition+$16
        lda #$0028
        sta wR1
        jsl rlAddDeployedMapSprite
        sta aDeploymentTable._DeploymentOffsets+$16
        lda #$0082
        sta aDeploymentTable._State+$16
        lda #$02E0
        sta aDeploymentTable._XPixelPosition+$18
        lda #$0150
        sta aDeploymentTable._YPixelPosition+$18
        lda #$0028
        sta wR1
        jsl rlAddDeployedMapSprite
        sta aDeploymentTable._DeploymentOffsets+$18
        lda #$0082
        sta aDeploymentTable._State+$18
        lda #$02F0
        sta aDeploymentTable._XPixelPosition+$1A
        lda #$0150
        sta aDeploymentTable._YPixelPosition+$1A
        lda #$0028
        sta wR1
        jsl rlAddDeployedMapSprite
        sta aDeploymentTable._DeploymentOffsets+$1A
        lda #$0082
        sta aDeploymentTable._State+$1A
        lda #$02D0
        sta aDeploymentTable._XPixelPosition+$1C
        lda #$0160
        sta aDeploymentTable._YPixelPosition+$1C
        lda #$0031
        sta wR1
        jsl rlAddDeployedMapSprite
        sta aDeploymentTable._DeploymentOffsets+$1C
        lda #$0082
        sta aDeploymentTable._State+$1C
        lda #$02F0
        sta aDeploymentTable._XPixelPosition+$1E
        lda #$0160
        sta aDeploymentTable._YPixelPosition+$1E
        lda #$002D
        sta wR1
        jsl rlAddDeployedMapSprite
        sta aDeploymentTable._DeploymentOffsets+$1E
        lda #$0082
        sta aDeploymentTable._State+$1E
        lda #$02E0
        sta aDeploymentTable._XPixelPosition+$20
        lda #$0180
        sta aDeploymentTable._YPixelPosition+$20
        lda #$801C
        sta wR1
        jsl rlAddDeployedMapSprite
        sta aDeploymentTable._DeploymentOffsets+$20
        lda #$00C2
        sta aDeploymentTable._State+$20
        lda #$02F0
        sta aDeploymentTable._XPixelPosition+$22
        lda #$0180
        sta aDeploymentTable._YPixelPosition+$22
        lda #$801C
        sta wR1
        jsl rlAddDeployedMapSprite
        sta aDeploymentTable._DeploymentOffsets+$22
        lda #$0082
        sta aDeploymentTable._State+$22
        lda #$0300
        sta aDeploymentTable._XPixelPosition+$24
        lda #$0180
        sta aDeploymentTable._YPixelPosition+$24
        lda #$801C
        sta wR1
        jsl rlAddDeployedMapSprite
        sta aDeploymentTable._DeploymentOffsets+$24
        lda #$0082
        sta aDeploymentTable._State+$24
        lda #$02D0
        sta aDeploymentTable._XPixelPosition+$26
        lda #$0190
        sta aDeploymentTable._YPixelPosition+$26
        lda #$801D
        sta wR1
        jsl rlAddDeployedMapSprite
        sta aDeploymentTable._DeploymentOffsets+$26
        lda #$00C2
        sta aDeploymentTable._State+$26
        lda #$02E0
        sta aDeploymentTable._XPixelPosition+$28
        lda #$0190
        sta aDeploymentTable._YPixelPosition+$28
        lda #$801D
        sta wR1
        jsl rlAddDeployedMapSprite
        sta aDeploymentTable._DeploymentOffsets+$28
        lda #$00C2
        sta aDeploymentTable._State+$28
        lda #$0300
        sta aDeploymentTable._XPixelPosition+$2A
        lda #$0190
        sta aDeploymentTable._YPixelPosition+$2A
        lda #$801D
        sta wR1
        jsl rlAddDeployedMapSprite
        sta aDeploymentTable._DeploymentOffsets+$2A
        lda #$0082
        sta aDeploymentTable._State+$2A
        lda #$0310
        sta aDeploymentTable._XPixelPosition+$2C
        lda #$0190
        sta aDeploymentTable._YPixelPosition+$2C
        lda #$801D
        sta wR1
        jsl rlAddDeployedMapSprite
        sta aDeploymentTable._DeploymentOffsets+$2C
        lda #$0082
        sta aDeploymentTable._State+$2C
        lda #$02F0
        sta aDeploymentTable._XPixelPosition+$2E
        lda #$0190
        sta aDeploymentTable._YPixelPosition+$2E
        lda #$801E
        sta wR1
        jsl rlAddDeployedMapSprite
        sta aDeploymentTable._DeploymentOffsets+$2E
        lda #$0082
        sta aDeploymentTable._State+$2E
        lda #$0260
        sta aDeploymentTable._XPixelPosition+$30
        lda #$0140
        sta aDeploymentTable._YPixelPosition+$30
        lda #$800F
        sta wR1
        jsl rlAddDeployedMapSprite
        sta aDeploymentTable._DeploymentOffsets+$30
        lda #$00C2
        sta aDeploymentTable._State+$30
        lda #$0260
        sta aDeploymentTable._XPixelPosition+$32
        lda #$0150
        sta aDeploymentTable._YPixelPosition+$32
        lda #$800F
        sta wR1
        jsl rlAddDeployedMapSprite
        sta aDeploymentTable._DeploymentOffsets+$32
        lda #$00C2
        sta aDeploymentTable._State+$32
        lda #$0260
        sta aDeploymentTable._XPixelPosition+$34
        lda #$0160
        sta aDeploymentTable._YPixelPosition+$34
        lda #$800F
        sta wR1
        jsl rlAddDeployedMapSprite
        sta aDeploymentTable._DeploymentOffsets+$34
        lda #$00C2
        sta aDeploymentTable._State+$34
        lda #$0260
        sta aDeploymentTable._XPixelPosition+$36
        lda #$0170
        sta aDeploymentTable._YPixelPosition+$36
        lda #$800F
        sta wR1
        jsl rlAddDeployedMapSprite
        sta aDeploymentTable._DeploymentOffsets+$36
        lda #$00C2
        sta aDeploymentTable._State+$36
        lda #$0260
        sta aDeploymentTable._XPixelPosition+$38
        lda #$0180
        sta aDeploymentTable._YPixelPosition+$38
        lda #$800F
        sta wR1
        jsl rlAddDeployedMapSprite
        sta aDeploymentTable._DeploymentOffsets+$38
        lda #$00C2
        sta aDeploymentTable._State+$38
        lda #$0270
        sta aDeploymentTable._XPixelPosition+$3A
        lda #$0140
        sta aDeploymentTable._YPixelPosition+$3A
        lda #$800B
        sta wR1
        jsl rlAddDeployedMapSprite
        sta aDeploymentTable._DeploymentOffsets+$3A
        lda #$00C2
        sta aDeploymentTable._State+$3A
        lda #$0270
        sta aDeploymentTable._XPixelPosition+$3C
        lda #$0150
        sta aDeploymentTable._YPixelPosition+$3C
        lda #$800B
        sta wR1
        jsl rlAddDeployedMapSprite
        sta aDeploymentTable._DeploymentOffsets+$3C
        lda #$00C2
        sta aDeploymentTable._State+$3C
        lda #$0270
        sta aDeploymentTable._XPixelPosition+$3E
        lda #$0160
        sta aDeploymentTable._YPixelPosition+$3E
        lda #$800B
        sta wR1
        jsl rlAddDeployedMapSprite
        sta aDeploymentTable._DeploymentOffsets+$3E
        lda #$00C2
        sta aDeploymentTable._State+$3E
        lda #$0270
        sta aDeploymentTable._XPixelPosition+$40
        lda #$0170
        sta aDeploymentTable._YPixelPosition+$40
        lda #$800B
        sta wR1
        jsl rlAddDeployedMapSprite
        sta aDeploymentTable._DeploymentOffsets+$40
        lda #$00C2
        sta aDeploymentTable._State+$40
        lda #$0270
        sta aDeploymentTable._XPixelPosition+$42
        lda #$0180
        sta aDeploymentTable._YPixelPosition+$42
        lda #$800B
        sta wR1
        jsl rlAddDeployedMapSprite
        sta aDeploymentTable._DeploymentOffsets+$42
        lda #$00C2
        sta aDeploymentTable._State+$42
        lda #$0250
        sta aDeploymentTable._XPixelPosition+$44
        lda #$0160
        sta aDeploymentTable._YPixelPosition+$44
        lda #$8013
        sta wR1
        jsl rlAddDeployedMapSprite
        sta aDeploymentTable._DeploymentOffsets+$44
        lda #$00C2
        sta aDeploymentTable._State+$44
        lda #$0280
        sta aDeploymentTable._XPixelPosition+$46
        lda #$01B0
        sta aDeploymentTable._YPixelPosition+$46
        lda #$0010
        sta wR1
        jsl rlAddDeployedMapSprite
        sta aDeploymentTable._DeploymentOffsets+$46
        lda #$0082
        sta aDeploymentTable._State+$46
        lda #$0290
        sta aDeploymentTable._XPixelPosition+$48
        lda #$01B0
        sta aDeploymentTable._YPixelPosition+$48
        lda #$0010
        sta wR1
        jsl rlAddDeployedMapSprite
        sta aDeploymentTable._DeploymentOffsets+$48
        lda #$0082
        sta aDeploymentTable._State+$48
        lda #$02A0
        sta aDeploymentTable._XPixelPosition+$4A
        lda #$01B0
        sta aDeploymentTable._YPixelPosition+$4A
        lda #$0010
        sta wR1
        jsl rlAddDeployedMapSprite
        sta aDeploymentTable._DeploymentOffsets+$4A
        lda #$0082
        sta aDeploymentTable._State+$4A
        lda #$02B0
        sta aDeploymentTable._XPixelPosition+$4C
        lda #$01B0
        sta aDeploymentTable._YPixelPosition+$4C
        lda #$0010
        sta wR1
        jsl rlAddDeployedMapSprite
        sta aDeploymentTable._DeploymentOffsets+$4C
        lda #$0082
        sta aDeploymentTable._State+$4C
        lda #$02C0
        sta aDeploymentTable._XPixelPosition+$4E
        lda #$01B0
        sta aDeploymentTable._YPixelPosition+$4E
        lda #$0010
        sta wR1
        jsl rlAddDeployedMapSprite
        sta aDeploymentTable._DeploymentOffsets+$4E
        lda #$0082
        sta aDeploymentTable._State+$4E
        lda #$02A0
        sta aDeploymentTable._XPixelPosition+$50
        lda #$01C0
        sta aDeploymentTable._YPixelPosition+$50
        lda #$001D
        sta wR1
        jsl rlAddDeployedMapSprite
        sta aDeploymentTable._DeploymentOffsets+$50
        lda #$0082
        sta aDeploymentTable._State+$50
        rtl

        .databank 0

        ; 90/F184

      rlASMCClearDemoDeployments ; 90/F184

        .al
        .xl
        .autsiz
        .databank ?

        ; Clears the deployment table (states, positions, deployment offsets; map sprites $FFFF) before a scene.


        ldx #$008E

        _F187
        lda #$0000
        sta aDeploymentTable,x
        sta aDeploymentTable._XPixelPosition,x
        sta aDeploymentTable._YPixelPosition,x
        sta aDeploymentTable._DeploymentOffsets,x
        lda #$FFFF
        sta aDeploymentTable._MapSpriteID,x
        dec x
        dec x
        bpl _F187
        rtl

        .databank 0

        ; 90/F1A6

      rlASMCSetDemoIndexOdd ; 90/F1A6

        .al
        .xl
        .autsiz
        .databank ?

        ; Sets bit 0 of wDemoIndex: the first scene of each pair is the odd one.


        lda wDemoIndex,b
        ora #$0001
        sta wDemoIndex,b
        rtl

        .databank 0

        ; 90/F1B0

      rlASMCTestDemoIndexIs1 ; 90/F1B0

        .al
        .xl
        .autsiz
        .databank ?

        ; Sets the truth flag when wDemoIndex is 1 (that scene has an extra unit walking in), clears it otherwise.


        phb
        php
        phk
        plb
        .databank $90
        phx
        phy
        lda wDemoIndex,b
        cmp #$0001
        bne _F1C7
        lda #$0001
        sta @l wEventEngineTruthFlag
        bra _F1CE


        _F1C7
        lda #$0000
        sta @l wEventEngineTruthFlag

        _F1CE
        ply
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 90/F1D3

      rlASMCHideDemoSceneUnit ; 90/F1D3

        .al
        .xl
        .autsiz
        .databank ?

        ; Hides deployment $1A (sets DeploymentStateHidden) after the scene of wDemoIndex 1.


        lda aDeploymentTable._State+$1A
        ora #$0040
        sta aDeploymentTable._State+$1A
        rtl

        .databank 0

        ; 90/F1DF

      rlASMCPlaceDemoSceneSprites ; 90/F1DF

        .al
        .xl
        .autsiz
        .databank ?

        ; Places the map sprites in the list aDemoSceneSpriteLists gives for wDemoIndex, from deployment 2 on.


        phb
        php
        phk
        plb
        .databank $90
        phx
        phy
        lda wDemoIndex,b
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda @l aDemoSceneSpriteLists+1,x
        sta lR18+1
        lda @l aDemoSceneSpriteLists,x
        sta lR18
        ldy #$0000
        ldx #$0004

        _F201
        lda [lR18],y
        and #$00FF
        beq _F239
        asl a
        asl a
        asl a
        asl a
        sta aDeploymentTable._XPixelPosition,x
        inc y
        lda [lR18],y
        and #$00FF
        asl a
        asl a
        asl a
        asl a
        sta aDeploymentTable._YPixelPosition,x
        inc y
        lda [lR18],y
        sta wR1
        jsl rlAddDeployedMapSprite
        sta aDeploymentTable._DeploymentOffsets,x
        inc y
        inc y
        lda [lR18],y
        sta aDeploymentTable,x
        inc x
        inc x
        inc y
        inc y
        bra _F201


        _F239
        ply
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 90/F23E

      aDemoSceneSpriteLists ; 90/F23E

        ; The map sprites of each demo scene, by wDemoIndex (rlASMCPlaceDemoSceneSprites).
        .long aUnknown90F5CD
        .long aUnknown90F584
        .long aUnknown90F529
        .long aUnknown90F4E0
        .long aUnknown90F48B
        .long aUnknown90F43C
        .long aUnknown90F3F9
        .long aUnknown90F392
        .long aUnknown90F337
        .long aUnknown90F2F4
        .long aUnknown90F2BD
        .long aUnknown90F262


      aUnknown90F262 ; 90/F262

        ; X and Y tile, map sprite, deployment state; ends with 0.
        .byte 51, 8
        .word $800B, $0080
        .byte 52, 9
        .word $800B, $0080
        .byte 51, 10
        .word $0010, $0080
        .byte 50, 3
        .word $003C, $0080
        .byte 58, 6
        .word $800E, $0080
        .byte 55, 12
        .word $001F, $0080
        .byte 58, 10
        .word $001E, $0080
        .byte 58, 9
        .word $800D, $0080
        .byte 59, 9
        .word $0020, $0080
        .byte 56, 8
        .word $0010, $0081
        .byte 61, 3
        .word $8016, $0081
        .byte 61, 4
        .word $8016, $0081
        .byte 61, 9
        .word $800D, $0081
        .byte 62, 8
        .word $8006, $0081
        .byte 62, 9
        .word $8006, $0081
        .byte 0


      aUnknown90F2BD ; 90/F2BD

        ; X and Y tile, map sprite, deployment state; ends with 0.
        .byte 17, 6
        .word $0017, $0080
        .byte 13, 6
        .word $8013, $0080
        .byte 13, 11
        .word $801A, $0080
        .byte 14, 9
        .word $001E, $0080
        .byte 18, 10
        .word $0015, $0080
        .byte 20, 5
        .word $003C, $0080
        .byte 10, 8
        .word $0038, $0080
        .byte 11, 10
        .word $8012, $0080
        .byte 13, 3
        .word $0018, $0080
        .byte 0


      aUnknown90F2F4 ; 90/F2F4

        ; X and Y tile, map sprite, deployment state; ends with 0.
        .byte 28, 51
        .word $8009, $0080
        .byte 34, 57
        .word $800A, $0080
        .byte 36, 59
        .word $0026, $0080
        .byte 34, 50
        .word $8007, $0080
        .byte 33, 55
        .word $000E, $0080
        .byte 31, 56
        .word $8001, $0080
        .byte 27, 50
        .word $8001, $0081
        .byte 29, 50
        .word $8001, $0081
        .byte 28, 49
        .word $8001, $0081
        .byte 26, 53
        .word $0005, $0081
        .byte 26, 54
        .word $0005, $0081
        .byte 0


      aUnknown90F337 ; 90/F337

        ; X and Y tile, map sprite, deployment state; ends with 0.
        .byte 40, 20
        .word $8008, $0080
        .byte 43, 16
        .word $003D, $0081
        .byte 40, 17
        .word $001E, $0080
        .byte 35, 22
        .word $0017, $0080
        .byte 35, 23
        .word $0018, $0080
        .byte 38, 22
        .word $8013, $0080
        .byte 33, 22
        .word $801A, $0080
        .byte 32, 23
        .word $800C, $0082
        .byte 42, 22
        .word $003E, $0081
        .byte 41, 24
        .word $002E, $0081
        .byte 40, 23
        .word $003B, $0081
        .byte 38, 24
        .word $0018, $0081
        .byte 44, 24
        .word $0031, $0081
        .byte 32, 19
        .word $8012, $0081
        .byte 33, 20
        .word $8012, $0081
        .byte 0


      aUnknown90F392 ; 90/F392

        ; X and Y tile, map sprite, deployment state; ends with 0.
        .byte 32, 52
        .word $8011, $0083
        .byte 33, 54
        .word $8011, $0083
        .byte 38, 48
        .word $8011, $0081
        .byte 39, 49
        .word $8011, $0081
        .byte 39, 51
        .word $8011, $0081
        .byte 40, 50
        .word $8011, $0081
        .byte 40, 47
        .word $8011, $0081
        .byte 41, 48
        .word $8011, $0081
        .byte 38, 52
        .word $8006, $0081
        .byte 38, 53
        .word $8006, $0081
        .byte 38, 54
        .word $8006, $0081
        .byte 39, 52
        .word $8006, $0081
        .byte 39, 53
        .word $8006, $0081
        .byte 39, 54
        .word $8006, $0081
        .byte 40, 52
        .word $8006, $0081
        .byte 40, 54
        .word $8006, $0081
        .byte 40, 53
        .word $800D, $0081
        .byte 0


      aUnknown90F3F9 ; 90/F3F9

        ; X and Y tile, map sprite, deployment state; ends with 0.
        .byte 45, 45
        .word $0030, $0080
        .byte 46, 44
        .word $8003, $0080
        .byte 47, 44
        .word $8009, $0080
        .byte 48, 49
        .word $0017, $0080
        .byte 45, 51
        .word $0003, $0080
        .byte 46, 52
        .word $0002, $0080
        .byte 53, 47
        .word $0039, $0080
        .byte 49, 50
        .word $8012, $0080
        .byte 42, 51
        .word $0018, $0080
        .byte 48, 47
        .word $8010, $0081
        .byte 51, 46
        .word $8010, $0081
        .byte 0


      aUnknown90F43C ; 90/F43C

        ; X and Y tile, map sprite, deployment state; ends with 0.
        .byte 47, 38
        .word $000F, $0080
        .byte 47, 37
        .word $0002, $0080
        .byte 54, 40
        .word $800A, $0080
        .byte 56, 38
        .word $8009, $0080
        .byte 55, 37
        .word $8003, $0080
        .byte 50, 34
        .word $8001, $0080
        .byte 50, 35
        .word $0001, $0080
        .byte 50, 36
        .word $8006, $0080
        .byte 57, 40
        .word $0012, $0081
        .byte 55, 42
        .word $0012, $0081
        .byte 46, 40
        .word $0006, $0081
        .byte 47, 42
        .word $0006, $0081
        .byte 50, 41
        .word $0006, $0081
        .byte 0


      aUnknown90F48B ; 90/F48B

        ; X and Y tile, map sprite, deployment state; ends with 0.
        .byte 8, 6
        .word $0030, $0080
        .byte 10, 10
        .word $8003, $0080
        .byte 9, 8
        .word $8009, $0080
        .byte 8, 15
        .word $0017, $0080
        .byte 11, 15
        .word $000D, $0080
        .byte 11, 17
        .word $000C, $0080
        .byte 14, 16
        .word $0038, $0080
        .byte 18, 12
        .word $0007, $0081
        .byte 20, 15
        .word $003D, $0081
        .byte 13, 12
        .word $002A, $0081
        .byte 15, 12
        .word $0014, $0081
        .byte 12, 9
        .word $8009, $0081
        .byte 11, 11
        .word $8007, $0081
        .byte 15, 8
        .word $800F, $0081
        .byte 0


      aUnknown90F4E0 ; 90/F4E0

        ; X and Y tile, map sprite, deployment state; ends with 0.
        .byte 34, 26
        .word $0012, $0081
        .byte 32, 25
        .word $0006, $0081
        .byte 34, 25
        .word $0006, $0081
        .byte 33, 26
        .word $0006, $0081
        .byte 28, 27
        .word $0016, $0081
        .byte 31, 28
        .word $0006, $0081
        .byte 36, 25
        .word $0016, $0081
        .byte 36, 26
        .word $0006, $0081
        .byte 38, 26
        .word $0006, $0081
        .byte 37, 17
        .word $0006, $0081
        .byte 36, 18
        .word $0006, $0081
        .byte 37, 19
        .word $0006, $0081
        .byte 0


      aUnknown90F529 ; 90/F529

        ; X and Y tile, map sprite, deployment state; ends with 0.
        .byte 51, 30
        .word $0003, $0080
        .byte 51, 29
        .word $0011, $0080
        .byte 48, 30
        .word $000D, $0080
        .byte 49, 26
        .word $0004, $0080
        .byte 49, 33
        .word $8004, $0082
        .byte 50, 33
        .word $8004, $0082
        .byte 51, 33
        .word $8004, $0082
        .byte 52, 33
        .word $8004, $0082
        .byte 53, 33
        .word $8004, $0082
        .byte 42, 25
        .word $0012, $0081
        .byte 42, 26
        .word $0012, $0081
        .byte 42, 27
        .word $0012, $0081
        .byte 42, 28
        .word $0012, $0081
        .byte 42, 29
        .word $0012, $0081
        .byte 42, 30
        .word $0012, $0081
        .byte 0


      aUnknown90F584 ; 90/F584

        ; X and Y tile, map sprite, deployment state; ends with 0.
        .byte 57, 59
        .word $0026, $0080
        .byte 54, 59
        .word $8001, $0080
        .byte 60, 60
        .word $000D, $0080
        .byte 59, 59
        .word $0001, $0080
        .byte 48, 60
        .word $800A, $0080
        .byte 55, 50
        .word $8000, $0081
        .byte 57, 49
        .word $8019, $0081
        .byte 57, 47
        .word $8010, $0081
        .byte 59, 48
        .word $801A, $0081
        .byte 60, 49
        .word $800C, $0081
        .byte 61, 51
        .word $801B, $0081
        .byte 56, 57
        .word $0018, $0080
        .byte 0


      aUnknown90F5CD ; 90/F5CD

        ; X and Y tile, map sprite, deployment state; ends with 0.
        .byte 50, 59
        .word $0003, $0080
        .byte 49, 59
        .word $0011, $0080
        .byte 55, 60
        .word $0017, $0080
        .byte 58, 52
        .word $0030, $0080
        .byte 60, 51
        .word $8009, $0080
        .byte 49, 53
        .word $8001, $0080
        .byte 50, 53
        .word $000C, $0080
        .byte 51, 55
        .word $001D, $0081
        .byte 50, 57
        .word $0010, $0081
        .byte 52, 57
        .word $0010, $0081
        .byte 55, 58
        .word $0028, $0081
        .byte 54, 59
        .word $002A, $0081
        .byte 56, 59
        .word $0014, $0081
        .byte 55, 55
        .word $0000, $0081
        .byte 0

    .endsection Unsorted90EBCASection


    .section Unsorted8DA810Section

      .al
      .xl

      rlASMCSetOpeningMapChapter9 ; 8D/A810

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; For the opening's first scene: chapter 9's map, wMainGameMode 2, the cursor at (128, 128).

        lda #$0009
        sta wCurrentChapter,b
        lda #$0002
        sta wMainGameMode,b
        lda #$FFFF
        sta wMapStateFlags,b
        lda #$0080
        sta wCursorXOffset,b
        sta wCursorYOffset,b
        rtl

        .databank 0

        ; 8D/A82C

      rlASMCSetOpeningMapChapter2Unused ; 8D/A82C

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ; Nothing reaches this. Like rlASMCSetOpeningMapChapter9 for chapter 2.

        lda #$0002
        sta wCurrentChapter,b
        lda #$0002
        sta wMainGameMode,b
        lda #$FFFF
        sta wMapStateFlags,b
        lda #$0080
        sta wCursorXOffset,b
        sta wCursorYOffset,b
        rtl

        .databank 0

        ; 8D/A848

      rlASMCSetOpeningMapChapter7Unused ; 8D/A848

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ; Nothing reaches this. Like rlASMCSetOpeningMapChapter9 for chapter 7.

        lda #$0007
        sta wCurrentChapter,b
        lda #$0002
        sta wMainGameMode,b
        lda #$FFFF
        sta wMapStateFlags,b
        lda #$0080
        sta wCursorXOffset,b
        sta wCursorYOffset,b
        rtl

        .databank 0

        ; 8D/A864

      rlASMCSetOpeningMapChapter11 ; 8D/A864

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; For the opening's last scene: the final chapter's map (11), wMainGameMode 2, the cursor at (128, 128).

        lda #$000B
        sta wCurrentChapter,b
        lda #$0002
        sta wMainGameMode,b
        lda #$FFFF
        sta wMapStateFlags,b
        lda #$0080
        sta wCursorXOffset,b
        sta wCursorYOffset,b
        rtl

        .databank 0

        ; 8D/A880

      rlASMCSetUpOpeningSkyScene ; 8D/A880

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; The opening's first scene: loads two sky layers and their graphics, starts procOpeningSkyScroll and sets colour math so the clouds blend over the map.

        sep #$20
        lda #$80
        sta $2100,b
        sta bBufferINIDISP
        rep #$20
        jsl rlDisableVBlank
        jsl rlResetHDMAEngine
        jsl rlInitMapMenus
        jsl rlDisableMapMenuUploads
        sep #$20
        rep #$10
        ldx #<>gcUnknownD44143
        stx DecompressionVariables
        lda #`gcUnknownD44143
        sta $CA
        ldx #$7B88
        stx $CB
        lda #$7E
        sta $CD
        rep #$30
        jsl rlDecompressor
        jsl rlDMAByStruct

          .structDMAToVRAM $7E7B88, $0800, $80, $A800

        sep #$20
        rep #$10
        ldx #<>gcUnknownD43402
        stx DecompressionVariables
        lda #`gcUnknownD43402
        sta $CA
        ldx #$9388
        stx $CB
        lda #$7E
        sta $CD
        rep #$30
        jsl rlDecompressor
        jsl rlDMAByStruct

          .structDMAToVRAM $7E9388, $1000, $80, $6000

        sep #$20
        rep #$10
        ldx #<>gcUnknownD4486F
        stx DecompressionVariables
        lda #`gcUnknownD4486F
        sta $CA
        ldx #$8388
        stx $CB
        lda #$7E
        sta $CD
        rep #$30
        jsl rlDecompressor
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0800, $80, $B000

        sep #$20
        rep #$10
        ldx #<>gcUnknownD4429B
        stx DecompressionVariables
        lda #`gcUnknownD4429B
        sta $CA
        ldx #$A388
        stx $CB
        lda #$7E
        sta $CD
        rep #$30
        jsl rlDecompressor
        jsl rlDMAByStruct

          .structDMAToVRAM $7EA388, $0800, $80, $8000

        lda #(`procOpeningSkyScroll)<<8
        sta lR44+1
        lda #<>procOpeningSkyScroll
        sta lR44
        jsl rlProcEngineCreateProc
        sep #$20
        lda #$11
        sta bBufferTM
        lda #$06
        sta bBufferTS
        sta bBufferTSW
        lda #$02
        sta bBufferCGWSEL
        lda #$27
        sta bBufferCGADSUB
        rep #$20
        ldx #$001E

        _A966
        lda aUnknown8CEBC0,x
        sta aBGPaletteBuffer.aPalette6,b,x
        dec x
        dec x
        bpl _A966
        ldx #$001C

        _A974
        lda aUnknown8CEB00+2,x
        sta $0102,b,x
        dec x
        dec x
        bpl _A974
        jsl rlEnableVBlank
        sep #$20
        lda #$00
        sta bBufferINIDISP
        rep #$20
        rtl

        .databank 0

        ; 8D/A98C

      rlSetUpOpeningSkySceneUnused ; 8D/A98C

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ; Nothing reaches this. rlASMCSetUpOpeningSkyScene without blanking the screen or resetting HDMA first.

        sep #$20
        lda #$80
        sta $2100,b
        sta bBufferINIDISP
        rep #$20
        jsl rlDisableVBlank
        jsl rlInitMapMenus
        jsl rlDisableMapMenuUploads
        sep #$20
        rep #$10
        ldx #<>gcUnknownD44143
        stx DecompressionVariables
        lda #`gcUnknownD44143
        sta $CA
        ldx #$7B88
        stx $CB
        lda #$7E
        sta $CD
        rep #$30
        jsl rlDecompressor
        jsl rlDMAByStruct

          .structDMAToVRAM $7E7B88, $0800, $80, $A800

        sep #$20
        rep #$10
        ldx #<>gcUnknownD43402
        stx DecompressionVariables
        lda #`gcUnknownD43402
        sta $CA
        ldx #$9388
        stx $CB
        lda #$7E
        sta $CD
        rep #$30
        jsl rlDecompressor
        jsl rlDMAByStruct

          .structDMAToVRAM $7E9388, $1000, $80, $6000

        sep #$20
        rep #$10
        ldx #<>gcUnknownD4486F
        stx DecompressionVariables
        lda #`gcUnknownD4486F
        sta $CA
        ldx #$8388
        stx $CB
        lda #$7E
        sta $CD
        rep #$30
        jsl rlDecompressor
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0800, $80, $B000

        sep #$20
        rep #$10
        ldx #<>gcUnknownD4429B
        stx DecompressionVariables
        lda #`gcUnknownD4429B
        sta $CA
        ldx #$A388
        stx $CB
        lda #$7E
        sta $CD
        rep #$30
        jsl rlDecompressor
        jsl rlDMAByStruct

          .structDMAToVRAM $7EA388, $0800, $80, $8000

        lda #(`procOpeningSkyScroll)<<8
        sta lR44+1
        lda #<>procOpeningSkyScroll
        sta lR44
        jsl rlProcEngineCreateProc
        sep #$20
        lda #$06
        sta bBufferTM
        sta bBufferTMW
        lda #$11
        sta bBufferTS
        sta bBufferTSW
        lda #$02
        sta bBufferCGWSEL
        lda #$27
        sta bBufferCGADSUB
        rep #$20
        ldx #$001E

        _AA70
        lda aUnknown8CEBC0,x
        sta aBGPaletteBuffer.aPalette6,b,x
        dec x
        dec x
        bpl _AA70
        ldx #$001C

        _AA7E
        lda aUnknown8CEB00+2,x
        sta $0102,b,x
        dec x
        dec x
        bpl _AA7E
        jsl rlEnableVBlank
        sep #$20
        lda #$00
        sta bBufferINIDISP
        rep #$20
        rtl

        .databank 0

        ; 8D/AA96

    .endsection Unsorted8DA810Section


    .section Unsorted8DAA96Section

      .al
      .xl

      procOpeningSkyScroll ; 8D/AA96

        .structProcInfo "KM", rlProcOpeningSkyScroll, rlProcOpeningSkyScroll._AAA4, aProcOpeningSkyScrollCode

    .endsection Unsorted8DAA96Section


    .section Unsorted8DAA9ESection

      .al
      .xl

      rlProcOpeningSkyScroll ; 8D/AA9E

        .al
        .xl
        .autsiz
        .databank ?

        ; Init and cycle of procOpeningSkyScroll: moves the two sky layers with the camera and drifts them slowly; frees itself when the game state routine is 0.

        lda wMapScrollXPixels,b
        sta aProcSystem.aBody0,b,x

        _AAA4
        lda wMapScrollXPixels,b
        cmp aProcSystem.aBody0,b,x
        beq _AABF
        sta aProcSystem.aBody0,b,x
        lda wBufferBG2HOFS
        clc
        adc wMapScrollSpeed,b
        sta wBufferBG2HOFS
        lda wBufferBG3HOFS
        clc
        adc wMapScrollSpeed,b
        sta wBufferBG3HOFS

        _AABF
        lda wVBlankEnabledFramecount
        and #$0001
        bne _AAD7
        lda wBufferBG2HOFS
        inc a
        sta wBufferBG2HOFS
        lda wVBlankEnabledFramecount
        and #$0003
        bne _AAD7
        lda wBufferBG3HOFS
        inc a
        sta wBufferBG3HOFS

        _AAD7
        lda wVBlankEnabledFramecount
        and #$0003
        bne _AAEF
        lda wBufferBG2VOFS
        dec a
        sta wBufferBG2VOFS
        lda wVBlankEnabledFramecount
        and #$0007
        bne _AAEF
        lda wBufferBG3VOFS
        dec a
        sta wBufferBG3VOFS

        _AAEF
        lda wGameStateRoutine1,b
        beq _AAF5

        _AAF4
        rtl


        _AAF5
        jsl rlProcEngineFreeProc
        bra _AAF4

        .databank 0

        ; 8D/AAFB

    .endsection Unsorted8DAA9ESection


    .section Unsorted8DAAFBSection

      .al
      .xl

      aProcOpeningSkyScrollCode ; 8D/AAFB

        PROC_HALT


        ; 8D/AAFD

    .endsection Unsorted8DAAFBSection


